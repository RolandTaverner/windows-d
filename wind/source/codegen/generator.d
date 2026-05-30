module codegen.generator;

import std.algorithm.iteration : filter, map, splitter, uniq;
import std.algorithm.searching : any, canFind, count, startsWith;
import std.algorithm.sorting : sort;
import std.array : array;
import std.container.rbtree : RedBlackTree;
import std.file : copy, mkdirRecurse;
import std.path : buildPath, dirName, dirSeparator;
import std.range : padLeft, chain;
import std.stdio;
import std.string : lastIndexOf;
import std.uni : toLower;

import climetadata.mdcollection.database;
import climetadata.mdcollection.entity;
import climetadata.mdcollection.entitytypes;
import climetadata.mdcollection.sigtnature;

enum maxLineWidth = 120;

public struct Generator
{
    @disable this();

    this(const Database *db,
        ref const string[] ignoredNamespaces,
        ref const string[string] configNamespace,
        string cfgCoreFileName,
        ref const string[string] safeWords,
        string outDirectory)
    {
        this.db = db;
        this.ignoredNamespaces = ignoredNamespaces.dup;
        this.configNamespace = configNamespace.dup;
        this.cfgCoreFileName = cfgCoreFileName;
        this.safeWords = safeWords.dup;
        this.outDirectory = outDirectory;
    }

    void generate()
    {
        auto namespaces = getNamespaces(db, ignoredNamespaces);

        writeln("Building dependency graph...");

        foreach(nestedClassRecord; db.nestedClassCollection.items())
        {
            auto child = nestedClassRecord.getNestedClass();
            auto parent = nestedClassRecord.getEnclosingClass();
            if (auto aa = parent in nestedMap)
            {
                (*aa)[child] = true;
            }
            else
            {
                auto aa = [child : true];            
                nestedMap[parent] = aa;
            }
        }
        nestedMap.rehash();

        foreach(namespace; namespaces)
        {
            auto rb = new RedBlackTree!string();
            dependencies[namespace] = rb;

            foreach(type; getTypeDefs(db, namespace))
            {            
                buildDependencies(type, namespace, rb);
            }
        }
        writeln("Building dependency graph done.");

        bool mustCopyCore = true;
        foreach(namespace; namespaces)
        {
            string path = makePath(outDirectory, namespace, configNamespace) ~ ".d";
            string modName = makeModuleName(namespace, configNamespace);        
            mkdirRecurse(dirName(path));        
            if (mustCopyCore)
            {
                copy(cfgCoreFileName, buildPath(dirName(path), "core.d"));
                mustCopyCore = false;
            }

            auto f = std.stdio.File(path, "w");
            f.writeln("// Written in the D programming language.");
            f.writeln();
            f.writefln("module %s;", modName);
            f.writeln;
            writefln("Processing %s", namespace);
            f.writeln("public import windows.core;");

            writeImports(namespace, f);
            dumpEnums(f, namespace, false /*docsDirectory.length > 0*/);


         }
    }

    private void buildDependencies(const TypeDefEntity type, string namespace, StringSet rb)
    {
        foreach(field; type.getFieldList())
        {
            auto dep = fullnameof(field.getSignature().typeSig.type);
            if (dep.length && dep[0] != '.' && !dep.startsWith(namespace ~ '.'))
            {
                rb.insert(dep);
            }
        }

        if (type in nestedMap)
        {
            foreach(nstruct; nestedMap[type].byKey)
            {
                buildDependencies(nstruct, namespace, rb);
            }
        }

        foreach(meth; type.getMethodList())
        {   
            auto sig = meth.getSignature();

            auto dep = fullnameof(sig.retSig.typeSig.type);
            if (dep.length && dep[0] != '.' && !dep.startsWith(namespace ~ '.'))
            {
                rb.insert(dep);
            }

            foreach(par; sig.params)
            {                    
                dep = fullnameof(par.typeSig.type);
                if (dep.length && dep[0] != '.' && !dep.startsWith(namespace ~ '.'))
                {
                    rb.insert(dep);
                }
            }
        }

        foreach (interf; type.getInterfaces())
        {
            auto dep = fullnameof(interf.getInterface());
            if (namespace == "Windows.Win32.DirectShow" && dep == "Windows.Win32.Mmc.IComponent")
            {
                dep = "Windows.Win32.DirectShow.IComponent";
            }
            else if (namespace == "Windows.Win32.Controls" && dep == "Windows.Win32.Mmc.IImageList")
            {
                dep = "Windows.Win32.Controls.IImageList";
            }
            else if (namespace == "Windows.Win32.Mmc" && dep == "Windows.Win32.DirectShow.IComponent")
            {
                dep = "Windows.Win32.Mmc.IComponent";
            }

            if (dep.length && dep[0] != '.' && !dep.startsWith(namespace))
            {
                rb.insert(dep);   
            }
        }   

        if (type.isValueType())
        {
            foreach(attr; type.getAttributes())
            {
                if (attr.name() == "RAIIFreeAttribute")
                {
                    auto fixed = attr.value().fixed[0];
                    auto element = fixed.value.get!ElementSig;
                    auto str = element.value.get!string;
                    foreach(t; db.typeDefCollection.items())
                    {
                        if (t.getTypeName() == "Apis")
                        {
                            foreach(m; t.getMethodList())
                            {
                                if (m.getName() == str)
                                {
                                    auto dep = t.getTypeNamespace() ~ '.' ~ m.getName();
                                    if (!dep.startsWith(namespace ~ '.'))
                                    {
                                        rb.insert(dep);
                                    }
                                    return;
                                }
                            }
                        }
                    }
                }
            }
        }

    }

    private void writeImports(string namespace, scope ref File f)
    {
        auto imports = dependencies[namespace].array.filter!(a => !ignoredNamespaces.canFind(getNamespace(a))).array.sort;

        string lastNamespace;
        bool atLeastOne;
        ptrdiff_t w, v;
        foreach(i; imports)
        {
            atLeastOne = true;
            auto n = getNamespace(i);
            if (n != lastNamespace)
            {
                if (lastNamespace.length)
                {
                    f.writeln(";");
                }
                auto moduleName = makeModuleName(n, configNamespace);
                auto importName = getName(i);
                f.writef("public import %s : %s", moduleName, importName);
                lastNamespace = n;
                w = 17 + moduleName.length + importName.length;
                v = w - importName.length;
            }
            else
            {
                auto importName = getName(i);
                if (importName.length + w > maxLineWidth - 3)
                {
                    f.writeln(",");                    
                    f.write("".padLeft(' ', v));
                    w = v;
                }
                else
                {
                    f.write(", ");
                }
                f.write(importName);
                w += importName.length + 2;
                w += importName.length + 2;
            }
        }
        if (atLeastOne)
        {
            f.writeln(";");
        }
        f.writeln;
        f.writeln("extern(Windows) @nogc nothrow:");
        f.writeln;
    }

    private void dumpEnums(scope ref std.stdio.File f, string namespace, bool docs = false)
    {
        auto enums = getEnums(db, namespace);
        if (!enums.empty())
        {
            dumpSectionHeader(f, "Enums");
            foreach(e; enums)
            {
                dumpEnum(f, e, docs);
            }
        }
    }

    void dumpEnum(scope ref std.stdio.File f, const ref TypeDefEntity e, bool docs = false)
    {
        foreach(ca; e.getAttributes())
        {
            if (ca.name() == "FlagsAttribute")
            {
                //can't find any use
            }
            else
            {
                f.writefln("//ENUM ATTR: %s : %s", ca.name(), ca.value);
            }
        }
        
        bool hasMembers = e.getFieldList().any!(f => !f.getFlags().hasRuntimeSpecialName);
        bool trueEnum = hasMembers && seemsLikeTrueEnum(e.getTypeName());
        size_t maxLen;
        foreach(fx; e.getFieldList())
        {
            if (fx.getName().length > maxLen)
            {
                maxLen = fx.getName().length;
            }
        }

        auto typeText = getEnumTypeText(e);

        // MDMatcher* doc = docs ? findDoc(e.name) : null;
        // f.writeln;
        // if (doc)
        //     dumpDocumentation(f, doc.description, 0);
            

        if (!trueEnum)
        {
            f.writefln("alias %s = %s;", e.getTypeName(), typeText);
            if (hasMembers)
            {
                f.writefln("enum : %s", typeText);
            }
        }
        else
        {
            f.writefln("enum %s : %s", e.getTypeName(), typeText);  
        }
        
        if (hasMembers)
        {
            f.writeln("{");
            foreach(fx; e.getFieldList())
            {            
                auto name = safeWords.get(fx.getName(), fx.getName());
                if (!fx.getFlags().hasRuntimeSpecialName)
                {
                    // if (doc)
                    // {
                    //     auto fdoc = doc.fields.find!(a => a.name == name);
                    //     if (!fdoc.empty)
                    //         dumpDocumentation(f, fdoc.front.description, 1);
                    // }
                    f.write("".padLeft(' ', 4));
                    f.write(name);

                    if (fx.getFlags().isLiteral)
                    {
                        if (name.length < maxLen)
                            f.write("".padLeft(' ', maxLen - name.length));
                        auto ct = fx.getConstant();
                        if (!ct.isNull)
                        {
                            f.writef(" = ");
                            dumpConstant(f, ct.get.value);
                        }
                    }
                    f.writeln(",");
                }
            }   
            f.writeln("}");
        }
    }

    void dumpConstant(scope ref std.stdio.File f, ConstantEntity.ConstantValue v)
    {
        import std.math.algebraic : abs;
        import std.math.traits : signbit, isInfinity, isNaN;

        if (auto s = v.peek!wstring)
            f.writef("\"%s\"", *s);
        else if (auto n = v.peek!(typeof(null)))
            f.write("null");
        else if (auto i = v.peek!int)
            f.writef("0x%08x", *i);
        else if (auto i = v.peek!uint)
            f.writef("0x%08x", *i);
        else if (auto i = v.peek!short)
            f.writef("0x%04x", *i);
        else if (auto i = v.peek!ushort)
            f.writef("0x%04x", *i);
        else if (auto i = v.peek!byte)
            f.writef("0x%02x", *i);
        else if (auto i = v.peek!ubyte)
            f.writef("0x%02x", *i);
        else if (auto i = v.peek!long)
            f.writef("0x%016x", *i);
        else if (auto i = v.peek!ulong)
            f.writef("0x%016x", *i);
        else if (auto i = v.peek!float)
        {
            if (signbit(*i))
                f.write("-");
            if (isNaN(*i))
                f.write("float.nan");
            else if (isInfinity(*i))
                f.write("float.infinity");
            else
                f.writef("%a", abs(*i));
        }
        else if (auto i = v.peek!double)
        {
            if (signbit(*i))
                f.write("-");
            if (isNaN(*i))
                f.write("double.nan");
            else if (isInfinity(*i))
                f.write("double.infinity");
            else
                f.writef("%a", abs(*i));
        }
        else
        {
            f.write(v);
        }
    }

    void dumpSectionHeader(scope ref std.stdio.File f, string name)
    {
        f.writeln;
        f.write("// ");
        f.writeln(name);
        f.writeln;
    }

    private StringSet[string] dependencies;
    private TypeSet[const(TypeDefEntity)] nestedMap;

    private const Database *db;
    private const string[] ignoredNamespaces;
    private const string[string] configNamespace;
    private const string cfgCoreFileName;
    private const string[string] safeWords;
    private const string outDirectory;
}

alias StringSet = RedBlackTree!string;
alias TypeSet = bool[const(TypeDefEntity)];

auto getNamespaces(const Database* db, ref const string[] ignored)
{
    auto defSet = db.typeDefCollection.items().map!(a => a.getTypeNamespace()).array.sort.uniq;
    auto refSet = db.typeRefCollection.items().map!(a => a.getTypeNamespace()).array.sort.uniq;

    return chain(defSet, refSet).filter!(a => a.length > 0 && !ignored.canFind(a)).array.sort.uniq;
}

string fullnameof(T)(T value)
{
    if (auto td = value.peek!TypeDefEntity)
        return td.getTypeNamespace() ~ "." ~ td.getTypeName();
    else if (auto td = value.peek!TypeRefEntity)
        return td.getTypeNamespace() ~ "." ~ td.getTypeName();
    return null;
}

string makePath(string outDir, string namespace, ref const string[string] config)
{
    string result;
    foreach(name; namespace.splitter('.'))
    {
        auto part = config.get(name.toLower, name.toLower);
        if (part.length)
        {
            if (result.length)
                result ~= dirSeparator;
            result ~= part;
        }
    }
    return buildPath(outDir, result);
}

string makeModuleName(string namespace, ref const string[string] config)
{
    string result;
    foreach(name; namespace.splitter('.'))
    {
        auto part = config.get(name.toLower, name.toLower);
        if (part.length)
        {
            if (result.length)
                result ~= '.';
            result ~= part;
        }
    }
    return result;
}

string getNamespace(string name)
{
    auto c = lastIndexOf(name, '.');
    return c > 0 ? name[0 .. c] : null;
}

string getName(string name)
{
    auto c = lastIndexOf(name, '.');
    return c > 0 ? name[c + 1 .. $] : name;
}

auto getTypeDefs(const Database* db, string namespace)
{
    return db.typeDefCollection.items().filter!(a => a.getTypeNamespace() == namespace);
}

auto getEnums(const Database* db, string namespace)
{
    return getTypeDefs(db, namespace).filter!(a => a.isEnum);
}

bool seemsLikeTrueEnum(string e)
{
    auto mjlen = e.count!(a => a >= 'A' && a <= 'Z');
    auto mnlen = e.count!(a => a >= 'a' && a <= 'z'); 
    return mjlen > 0 
        && e[$ - 1] >= 'a' && e[$ - 1] <= 'z'
        && e[0] >= 'A' && e[0] <= 'Z'
        && mjlen < mnlen 
        && e.count!(a => a == '_') == 0;
}

string getEnumTypeText(scope ref const TypeDefEntity e)
{
    auto type = e.underlyingEnumType;
    switch(type)
    {
        case ElementType.boolean:
            return "bool";
        case ElementType.char_:
            return "wchar";
        case ElementType.i1:
            return "byte";
        case ElementType.u1:
            return "ubyte";         
        case ElementType.i2:
            return "short";
        case ElementType.u2:
            return "ushort";         
        case ElementType.i4:
            return "int";
        case ElementType.u4:
            return "uint";         
        case ElementType.i8:
            return "long";
        case ElementType.u8:
            return "ulong";    
        case ElementType.r4:
            return "float";    
        case ElementType.r8:
            return "double";    
        default:
            assert(0);
    }
}
