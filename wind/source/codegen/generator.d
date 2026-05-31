module codegen.generator;

import std.algorithm.iteration : filter, map, splitter, uniq;
import std.algorithm.searching : any, canFind, commonPrefix, count, endsWith, find, startsWith;
import std.algorithm.sorting : sort;
import std.array : array, join, split;
import std.container.rbtree : RedBlackTree;
import std.conv : to;
import std.file : copy, mkdirRecurse;
import std.format : format;
import std.path : buildPath, dirName, dirSeparator;
import std.range : padLeft, chain;
import std.stdio;
import std.string : indexOf, lastIndexOf, strip;
import std.typecons : Nullable;
import std.uni : toLower;

import climetadata.mdcollection.attributeprops;
import climetadata.mdcollection.database;
import climetadata.mdcollection.entity;
import climetadata.mdcollection.entitytypes;
import climetadata.mdcollection.sigtnature;
import climetadata.utils.memcast;

enum maxLineWidth = 120;
enum minSetTreshold = 0.4;
enum maxFieldAlignment = 20;
enum maxReturnTypeAlignment = 8;

public struct Generator
{
    @disable this();

    this(const Database *db,
        ref const string[] ignoredNamespaces,
        ref const string[string] configNamespace,
        string cfgCoreFileName,
        ref const string[string] safeWords,
        ref const bool[string] skipInterfaces,
        ref const bool[string] skipMethods,
        string outDirectory)
    {
        this.db = db;
        this.ignoredNamespaces = ignoredNamespaces.dup;
        this.configNamespace = configNamespace.dup;
        this.cfgCoreFileName = cfgCoreFileName;
        this.safeWords = safeWords.dup;
        this.skipInterfaces = skipInterfaces.dup;
        this.skipMethods = skipMethods.dup;
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
            dumpApisConstants(f, namespace, safeWords);
            dumpDelegates(f, namespace, false /*docsDirectory.length > 0*/);
            dumpStructs(f, namespace, false /*docsDirectory.length > 0*/);
            dumpApis(f, namespace, false /*docsDirectory.length > 0*/);
            dumpInterfaces(f, namespace, false /*docsDirectory.length > 0*/);
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

    private void dumpEnum(scope ref std.stdio.File f, const ref TypeDefEntity e, bool docs = false)
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

    private void dumpConstant(scope ref std.stdio.File f, ConstantEntity.ConstantValue v)
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

    private void dumpApisConstants(scope ref std.stdio.File f, string namespace, scope ref const string[string] safeWords)
    {
        bool wasOne;
        auto apis = getApisClasses(db, namespace);
        if (!apis.empty() && !apis.front().getFieldList().empty())
        {
            dumpSectionHeader(f, "Constants");
            FieldEntity[] flds;
            string lastTypeText;
            string lastField;
            bool mustReturn;

            foreach(fld; apis.front().getFieldList())
            {
                auto typeText = getTypeText(fld.getSignature().typeSig, safeWords);
                auto fieldName = fld.getName();

                if (!flds.length)
                {
                    lastField = fld.getName();
                    lastTypeText = typeText;
                    flds ~= fld;
                    continue;
                }

                if ((typeText == lastTypeText && lastField.length > 0 && commonPrefix(lastField, fieldName).length / cast(double)(lastField.length) > minSetTreshold))
                {
                    lastField = fld.getName();
                    lastTypeText = typeText;
                    flds ~= fld;
                    continue;
                }

                dumpFieldCollection(f, flds, wasOne);    
                wasOne = flds.length == 1;

                lastField = fld.getName();
                lastTypeText = typeText;
                flds = [fld];
            }

            if (flds.length)
            {
                dumpFieldCollection(f, flds, wasOne);
            }
        }
    }

    private void dumpFieldCollection(scope ref std.stdio.File f, scope ref const FieldEntity[] flds, bool wasOne)
    {
        auto sig = flds[0].getSignature().typeSig;
        bool isStruct = sig.type.peek!TypeRefEntity || sig.type.peek!TypeDefEntity;
        bool isGuidConst = flds[0].getCustomAttributes().canFind!(a => a.name() == "GuidAttribute");
        auto typeText = isGuidConst ? "GUID" : getFieldTypeText(flds[0], safeWords);
        if (isGuidConst)
        {
            isStruct = true;
        }
        auto isPropKey = typeText.endsWith("/PROPERTYKEY") || typeText.endsWith("/DEVPROPKEY"); // TODO: get type name instead of typeText here, getFieldTypeText() change may break this

        if (flds.length == 1)
        {
            auto fx = flds[0];

            if (!wasOne)
                f.writeln;
            f.write("enum ");
            f.write(typeText);   
            f.write(" ");
            f.write(safeWords.get(fx.getName(), fx.getName()));
            f.write(" = ");
            if (isStruct)
            {
                f.write(typeText);
                f.write("(");
            }
            if (fx.getFlags().isLiteral())
            {
                assert(!fx.getConstant().isNull, "isLiteral() field must has not null Constant");
                dumpConstant(f, fx.getConstant().get.value);
            }
            else
            {
                foreach(ca; fx.getCustomAttributes())
                {
                    if (ca.name() == "GuidAttribute")
                    {
                        f.writef("\"%s\"", readGuid(ca).toString());
                        break;
                    }
                    else if (ca.name() == "ConstantAttribute")
                    {
                        auto constValue = readConstantValue(ca, isPropKey);
                        f.write(constValue);
                        break;
                    }
                    else
                    {
                        // TODO: throw
                        writeln("ERROR ", fx.getName(), " no GuidAttribute or ConstantAttribute");
                    }
                }
            }

            if (isStruct)
                f.write(")");
            f.writeln(";");
        }
        else
        {
            size_t maxLen;
            foreach(fx; flds)
            {
                if (fx.getName().length > maxLen)
                    maxLen = fx.getName().length;
            }

            f.writeln;
            f.write("enum : ");       
            f.writeln(typeText);
            f.writeln("{");
            foreach(fx; flds)
            {
                f.write("".padLeft(' ', 4));
                foreach(ca; fx.getCustomAttributes())
                {
                    if (ca.name() == "ObsoleteAttribute")
                    {
                        auto fixed = ca.value.fixed[0];
                        auto element = fixed.value.get!ElementSig;
                        auto msg = element.value.get!string;
                        f.writefln("deprecated(\"%s\") ", msg);
                        f.write("".padLeft(' ', 4));
                        break;
                    }
                }
                auto name = safeWords.get(fx.getName(), fx.getName());
                f.write(name);
                if (name.length < maxLen)
                    f.write("".padLeft(' ', maxLen - name.length));
                f.write(" = ");
                if (isStruct)
                {
                    f.write(typeText);
                    f.write("(");                
                }

                if (fx.getFlags().isLiteral())
                {
                    assert(!fx.getConstant().isNull, "isLiteral() field must has not null Constant");
                    dumpConstant(f, fx.getConstant().get.value);
                }
                else
                {
                    foreach(ca; fx.getCustomAttributes())
                    {
                        if (ca.name() == "GuidAttribute")
                        {
                            f.writef("\"%s\"", readGuid(ca).toString());
                            break;
                        }
                        else if (ca.name() == "ConstantAttribute")
                        {
                            auto constValue = readConstantValue(ca, isPropKey);
                            f.write(constValue);
                            break;
                        }
                        else
                        {
                            // TODO: throw
                            writeln("ERROR ", fx.getName(), " no GuidAttribute or ConstantAttribute");
                        }
                    }
                }
                if (isStruct)
                {
                    f.write(")");
                }
                f.writeln(",");
            }
            f.writeln("}");
        }
    }

    private void dumpStructs(scope ref std.stdio.File f, string namespace, bool docs = false)
    {
        auto structs = getStructs(db, namespace);
        if (!structs.empty)
        {
            dumpSectionHeader(f, "Structs");
            foreach(s; structs)
                dumpStruct(f, s, 0, null, docs);
        }
    }

    private void dumpStruct(scope ref std.stdio.File f, scope ref const TypeDefEntity struc, int level = 0, string nameOverride = "", bool docs = false)
    {
        if (!level)
            f.writeln;

        // MDMatcher* doc = level == 0 && docs ? findDoc(struc.name) : null;
        // if (doc)
        //     dumpDocumentation(f, doc.description, 0); 

        foreach(ca; struc.getAttributes())
        {
            if (ca.name() == "NativeTypedefAttribute")
            {
                //do nothing
            }
            else if (ca.name() == "RAIIFreeAttribute")
            {
                f.write("".padLeft(' ', level * 4));
                auto fixed = ca.value.fixed[0];
                auto element = fixed.value.get!ElementSig;
                auto str = element.value.get!string;
                f.writefln("@RAIIFree!%s", str);
            }
            else
            {
                f.write("".padLeft(' ', level * 4));
                f.writefln("//STRUCT ATTR: %s : %s", ca.name(), ca.value());
            }
        }

        string[string] types;

        size_t maxNameLen;
        size_t maxTypeLen;
        int nativeType;
        auto nestedClasses = struc in nestedMap;

        foreach(fx; struc.getFieldList())
        {
            auto name = safeWords.get(fx.getName(), fx.getName());

            auto fieldType = fx.getSignature().typeSig.type;
            
            if (nestedClasses)
            {
                auto td = resolveType(fieldType);
                if (!td.isNull)
                    if (td.get in *nestedClasses)
                        continue;                
            }
                
            if (name.length > maxNameLen && name.length <= maxFieldAlignment)
                maxNameLen = name.length;        
            auto type = getFieldTypeText(fx, safeWords, true);
            if (type.length > maxTypeLen && type.length <= maxFieldAlignment)
                maxTypeLen = type.length;    
            types[name] = type;
        }

        bool isExplicit = struc.getFlags().layout == TypeLayout.explicitLayout;
        bool isAnonymous = struc.getTypeName().startsWith("_Anonymous");

        f.write(isExplicit ? "union" : "struct");
        
        if (!isAnonymous)
        {
            f.write(" ");
            if (nameOverride.length > 0)
                f.write(nameOverride);
            else
                f.write(safeWords.get(struc.getTypeName(), struc.getTypeName()));
        }
        f.writeln;

    
        f.write("".padLeft(' ', level * 4));
        f.writeln("{");

        auto lay = struc.getLayout();
        if (!lay.isNull)
        {
            f.write("".padLeft(' ', level * 4));
            f.writefln("align (%d):", lay.get.getPackingSize());
        }

        foreach(fx; struc.getFieldList())
        {
            if (nestedClasses)
            {
                auto td = resolveType(fx.getSignature().typeSig.type);
                if (!td.isNull)
                {
                    if (td.get in *nestedClasses)
                    {
                        dumpStruct(f, td.get, level + 1, safeWords.get(fx.getName(), fx.getName()), false);
                        continue;
                    }
                }
            }    

            string name = safeWords.get(fx.getName(), fx.getName());        
            auto type = types[name];
            if (name == "_bitfield" || name == type)
            {
                name = getUnique(name);
            }

            // if (doc)
            // {
            //     auto fdoc = doc.fields.find!(a => a.name == fx.name);
            //     if (!fdoc.empty)            
            //         dumpDocumentation(f, fdoc.front.description, level + 1);            
            // }
            
            f.write("".padLeft(' ', level * 4));
            f.write("".padLeft(' ' , 4));
            f.write(type);
            if (type.length < maxTypeLen)
                f.write("".padLeft(' ' , maxTypeLen - type.length));
            f.write (' ');
            f.write(name);
            auto ct = fx.getConstant();
            if (!ct.isNull)
            {
                if (name.length < maxNameLen)
                    f.write("".padLeft(' ' , maxNameLen - name.length));
                f.writef(" = ");
                dumpConstant(f, ct.get.value);
            }
            f.writeln(";");
        }  
        f.write("".padLeft(' ', level * 4));
        f.writeln("}");
    }

    private void dumpDelegates(scope ref std.stdio.File f, string namespace, bool docs = false)
    {
        auto delegates = getDelegates(db, namespace);
        if (!delegates.empty())
        {
            dumpSectionHeader(f, "Callbacks");
            foreach(d; delegates)
                dumpDelegate(f, d, docs);
        }
    }

    private void dumpDelegate(scope ref std.stdio.File f, scope ref const TypeDefEntity type, bool docs = false)
    {
        string conv;
        foreach(ca; type.getAttributes())
        {
            if (ca.name() == "UnmanagedFunctionPointerAttribute")
            {
                auto fixed = ca.value().fixed[0];
                auto element = fixed.value.get!ElementSig;
                auto v = element.value.get!int;
                if (v == 1 || v == 3)
                    conv = "Windows";            
                else if (v == 2)
                    conv = "C";
                else
                    conv = format("Unknown[%s]", v);
            }
            else
                f.writefln("//DELEGATE ATTR: %s : %s", ca.name(), ca.value());
        }

        foreach(meth; type.getMethodList())
        {        
            if (meth.getName() == "Invoke")
            {
                // auto doc = docs ? findDoc(type.name) : null;
                // if (doc)
                // {
                //     dumpDocumentation(f, doc.description, 0);
                //     dumpDocumentationParams(f, *doc, 0);
                //     dumpDocumentationReturn(f, doc.returns, 0);
                // }
                auto name = safeWords.get(type.getTypeName(), type.getTypeName());
                size_t w, v;
                f.write("alias ");
                f.write(name);
                f.write(" = ");
                w = name.length + 9;
                auto sig = meth.getSignature();
                if (sig.retSig.isByRef)
                {
                    f.write("ref ");
                    w += 4;
                }

                if (sig.retSig.isVoid)
                {
                    f.write("void");
                    w += 4;
                }
                else
                {
                    auto retTypeName = getTypeText(sig.retSig.typeSig, safeWords);
                    f.write(retTypeName);
                    w += retTypeName.length;
                }

                f.write(" function(");
                w += 10;
                v = w;

                ParamEntity[int] paramNames;
                foreach(p; meth.getParamList())
                {
                    ParamEntity pe = p;
                    int key = pe.getSequence();
                    paramNames.require(key, pe);
                }

                int idx = 1;

                bool atLeastOne;
                foreach(param; sig.params)
                {
                    if (atLeastOne)
                        f.write(", ");
                    w += 2;
                    auto paramText = getParamText(param, paramNames[idx++], safeWords);
                    if (!atLeastOne || w + paramText.length < maxLineWidth - 3)
                    {
                        f.write(paramText);
                        w += paramText.length;
                    }
                    else
                    {
                        f.writeln;
                        f.write("".padLeft(' ', v));
                        f.write(paramText);
                        w = v + paramText.length;
                    }
                    atLeastOne = true;
                }

                f.writeln(");");
                return;
            }       
        }
    }

    private void dumpApis(scope ref std.stdio.File f, string namespace, bool docs = false)
    {
        auto apis = getApisClasses(db, namespace);
        if (!apis.empty() && !apis.front().getMethodList().empty())
        {
            dumpSectionHeader(f, "Functions");
            foreach(meth; apis.front().getMethodList())
            {
                if (meth.getName() in skipMethods)
                    continue;
                dumpMethod(f, meth, 0, 0, docs);
            }
        }
    }

    private void dumpMethod(scope ref std.stdio.File f, scope ref const MethodDefEntity meth, int level, size_t maxReturnTypeLength, bool docs = false, string prefix = null)
    {
        size_t w, v;

        foreach(ca; meth.getAttributes())
        {
            f.writefln("//METH ATTR: %s : %s", ca.name(), ca.value());
        }
    
        // auto doc = docs ? findDoc(prefix.length ? prefix ~ '.' ~ meth.name: meth.name) : null;

        // if (doc)
        // {
        //     dumpDocumentation(f, doc.description, level);
        //     dumpDocumentationParams(f, *doc, level);     
        //     dumpDocumentationReturn(f, doc.returns, level);
        // }

        f.write("".padLeft(' ', level * 4));
        w = level * 4;

        auto impl = meth.getImplementation();
        if (!impl.isNull)
        {
            auto dllName = impl.get.getImportScope().getName();        
            f.writefln("@DllImport(\"%s\")", dllName);
        }

        auto sig = meth.getSignature();
        if (sig.retSig.isByRef)
        {
            f.write("ref ");
            w += 4;
        }

        if (sig.retSig.isVoid)
        {
            f.write("void");
            w += 4;
        }
        else
        {
            auto retTypeName = getTypeText(sig.retSig.typeSig, safeWords);
            f.write(retTypeName);
            w += retTypeName.length;
        }

        auto typeLen = w - level * 4;
        if (typeLen < maxReturnTypeLength)
        {
            f.write(" ".padLeft(' ', maxReturnTypeLength - typeLen));
            w += maxReturnTypeLength - typeLen;
        }

        auto methodName = meth.getName();
        f.write(" ");
        f.write(methodName);    
        f.write("(");
        w += methodName.length + 2;
        v = w;

        ParamEntity[int] paramNames;
        foreach(p; meth.getParamList())
        {
            ParamEntity pe = p;
            int key = pe.getSequence();
            paramNames.require(key, pe);
        }

        int idx = 1;

        bool atLeastOne;
        foreach(param; sig.params)
        {
            if (atLeastOne)
                f.write(", ");
            w += 2;
            auto paramText = getParamText(param, paramNames[idx++], safeWords);
            if (!atLeastOne || w + paramText.length < maxLineWidth - 3)
            {
                f.write(paramText);
                w += paramText.length;
            }
            else
            {
                f.writeln;
                f.write("".padLeft(' ', v));
                f.write(paramText);
                w = v + paramText.length;
            }
            atLeastOne = true;
        }

        f.writeln(");");
        if (!level)
            f.writeln;
    }

    private void dumpInterfaces(scope ref std.stdio.File f, string namespace, bool docs = false)
    {
        size_t maxLength, maxStructLength;
        RedBlackTree!string interfaceSet = new RedBlackTree!string;
        RedBlackTree!string structSet = new RedBlackTree!string;

        bool anyInterface = !getInterfaces(db, namespace).empty || !getEmptyInterfaces(db, namespace).empty;

        if (anyInterface)
            dumpSectionHeader(f, "Interfaces");

        foreach(intf; getEmptyInterfaces(db, namespace))
        {
            // auto doc = docs ? findDoc(intf.name) : null;
            // if (doc)
            //     dumpDocumentation(f, doc.description, 0);

            auto attr = intf.getAttributes().find!(a => a.name() == "GuidAttribute").front;
            dumpGUIDAttr(f, attr);
            auto intfName = intf.getTypeName();
            
            f.writefln("struct %s;", intfName);
            f.writeln;
            structSet.insert(intfName);
            if (intfName.length > maxStructLength)
                maxStructLength = intfName.length;
        }

        foreach(intf; getInterfaces(db, namespace))
        {
            if (intf.getTypeName() in skipInterfaces)
                continue;
            bool hasGuid;

            // auto doc = docs ? findDoc(intf.name) : null;
            // if (doc)
            //     dumpDocumentation(f, doc.description, 0);

            foreach(ca; intf.getAttributes())
            {
                auto attrName = ca.name();
                if (attrName == "GuidAttribute")
                {
                    dumpGUIDAttr(f, ca); 
                    hasGuid = true;
                }
                else
                {
                    f.writefln("//INTERFACEF ATTR: %s : %s", ca.name(), ca.value());
                }
            }

            auto name = intf.getTypeName();
            if (hasGuid)
            {
                interfaceSet.insert(name);
                if (name.length > maxLength)
                    maxLength = name.length;
            }
            
            f.writef("interface %s", name);
            bool atLeastOne;    

            foreach (interf; intf.getInterfaces())
            {
                auto implName = nameof(interf.getInterface());
                f.write(atLeastOne ? ", ": " : ");
                f.write(implName);
                atLeastOne = true;
            }

            f.writeln;
            f.writefln("{");

            size_t maxReturnTypeLength;
            foreach(meth; intf.getMethodList())
            {
                auto retSig = meth.getSignature().retSig;
                auto len = retSig.isVoid ? 4 : getTypeText(retSig.typeSig, safeWords).length;
                if (len > maxReturnTypeLength && len <= maxReturnTypeAlignment)
                    maxReturnTypeLength = len;
            }

            foreach(meth; intf.getMethodList())
                dumpMethod(f, meth, 1, maxReturnTypeLength, docs, intf.getTypeName());

            f.writeln("}");
            f.writeln;
        }

        if (!interfaceSet.empty || !structSet.empty)
            dumpSectionHeader(f, "GUIDs");

        foreach(intf;structSet)
        {
            f.writef("const GUID CLSID_%s", intf);
            f.write("".padLeft(' ', maxStructLength - intf.length + 1));
            f.writefln("= GUIDOF!%s;", intf);
        }

        f.writeln;

        foreach(intf;interfaceSet)
        {
            f.writef("const GUID IID_%s", intf);
            f.write("".padLeft(' ', maxLength - intf.length + 1));
            f.writefln("= GUIDOF!%s;", intf);
        }
    }

    private void dumpSectionHeader(scope ref std.stdio.File f, string name) const
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
    private const bool[string] skipInterfaces;
    private const bool[string] skipMethods;
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

auto getStructs(const Database* db, string namespace)
{
    return getTypeDefs(db, namespace).filter!(a => a.isValueType 
                                              && !a.getAttributes().any!(c => c.name == "GuidAttribute"));
}

auto getDelegates(const Database* db, string namespace)
{
    return getTypeDefs(db, namespace).filter!(a => a.isDelegate());
}

auto getApisClasses(const Database* db, string namespace)
{
    return getTypeDefs(db, namespace).filter!(a => a.getTypeName() == "Apis");
}

auto getInterfaces(const Database* db, string namespace)
{
    return getTypeDefs(db, namespace).filter!(a => a.isInterface());
}

auto getEmptyInterfaces(const Database* db, string namespace)
{
    return getTypeDefs(db, namespace).filter!(a => a.isValueType()
                                              && !a.getFieldList().any!(b => true)
                                              && a.getAttributes().any!(c => c.name() == "GuidAttribute"));
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

string getTypeText(const ref TypeSig sig, scope ref const string[string] safeWords, bool isConst = false, int nativeReplacement = 0)
{
    string s;
    if (nativeReplacement)
    {
        switch(nativeReplacement)
        {
            case 20 : return "const(char)*";
            case 21 : return "const(wchar)*"; 
            case 42 : return "char*";
            default : s = format("/*UNKNOWN NATIVE - %s*/", nativeReplacement);
        }
    }
    
    if (isConst)
    {
        s ~= "const(";
    }

    if (auto elType = sig.type.peek!ElementType)
    {
        switch(*elType)
        {
            case ElementType.boolean:
                s ~= "bool"; break;
            case ElementType.char_:
                s ~= "wchar"; break;
            case ElementType.i1:
                s ~= "byte"; break;
            case ElementType.u1:
                s ~= "ubyte"; break;         
            case ElementType.i2:
                s ~= "short"; break;
            case ElementType.u2:
                s ~= "ushort"; break;         
            case ElementType.i4:
                s ~= "int"; break;
            case ElementType.u4:
                s ~= "uint"; break;         
            case ElementType.i8:
                s ~= "long"; break;
            case ElementType.u8:
                s ~= "ulong"; break;    
            case ElementType.r4:
                s ~= "float"; break;    
            case ElementType.r8:
                s ~= "double"; break;    
            case ElementType.string:
                s ~= "const(wchar)*"; break; 
            case ElementType.object:
                s ~= "object"; break; 
            case ElementType.void_:
                s ~= "void"; break; 
            case ElementType.i:
                s ~= "ptrdiff_t"; break; 
            case ElementType.u:
                s ~= "size_t"; break; 
            default:
                s ~= "// unknown element type for "; break;
        }
    }
    else if (auto elType = sig.type.peek!TypeRefEntity)  
    {
        auto t = safeWords.get(elType.getTypeName(), elType.getTypeName()); 
        s ~= t == "Guid" ? "GUID" : t;
    }
    else if (auto elType = sig.type.peek!TypeDefEntity)
    {
        auto t = safeWords.get(elType.getTypeName(), elType.getTypeName()); 
        s ~= t == "Guid" ? "GUID" : t;
    }
    else
        s ~= "/* unknown type */";

    if (isConst)
        s ~= ")";

    if (sig.isArray)
    {
        for(size_t i = 0; i < sig.arraySizes.length; ++i)
            s ~= format("[%d]", sig.arraySizes[i]);
    }
    
    for (int i = 0; i < sig.ptrCount; ++i)
        s ~= '*';

    return s;
}

string getFieldTypeText(scope ref const FieldEntity field, scope ref const string[string] safeWords, bool checkConst = false)
{
    string s;
    int nativeReplacement;
    bool isConst;
    foreach(ca; field.getCustomAttributes())
    {
        if (ca.name() == "ConstAttribute")
        {
            isConst = checkConst;
        }
        else if (ca.name() == "NativeTypeInfoAttribute")
        {
            auto fixed = ca.value().fixed[0];
            auto element = fixed.value().get!ElementSig;
            nativeReplacement = element.value().get!int;
        }
        else if (ca.name() == "NotNullTerminated")
        {
            //cant't find any use
        }
        else if(ca.name() == "ObsoleteAttribute" || ca.name() == "GuidConstAttribute")
        {
            //ignore now, use when writing field
        }
        else
            s = format("/*FIELD ATTR: %s : %s*/", ca.name(), ca.value());
    }
    s ~= getTypeText(field.getSignature().typeSig, safeWords, isConst, nativeReplacement);
    return s;
}

private UUID readGuid(scope ref const CustomAttributeEntity ca)
{
    assert(ca.name() == "GuidAttribute", "readGuid: CustomAttribute.name() != \"GuidAttribute\"");
    auto sig = ca.value();

    assert(sig.fixed.length == 11);

    auto a = sig.fixed[0].value.get!ElementSig.value.get!uint;
    auto b = sig.fixed[1].value.get!ElementSig.value.get!ushort;
    auto c = sig.fixed[2].value.get!ElementSig.value.get!ushort;
    auto d = sig.fixed[3].value.get!ElementSig.value.get!ubyte;
    auto e = sig.fixed[4].value.get!ElementSig.value.get!ubyte;
    auto f = sig.fixed[5].value.get!ElementSig.value.get!ubyte;
    auto g = sig.fixed[6].value.get!ElementSig.value.get!ubyte;
    auto h = sig.fixed[7].value.get!ElementSig.value.get!ubyte;
    auto i = sig.fixed[8].value.get!ElementSig.value.get!ubyte;
    auto j = sig.fixed[9].value.get!ElementSig.value.get!ubyte;
    auto k = sig.fixed[10].value.get!ElementSig.value.get!ubyte;

    ubyte a0 = (a >> (0 * 8)) & 0xFF; 
    ubyte a1 = (a >> (1 * 8)) & 0xFF;
    ubyte a2 = (a >> (2 * 8)) & 0xFF;
    ubyte a3 = (a >> (3 * 8)) & 0xFF;

    ubyte b0 = (b >> (0 * 8)) & 0xFF; 
    ubyte b1 = (b >> (1 * 8)) & 0xFF;

    ubyte c0 = (c >> (0 * 8)) & 0xFF; 
    ubyte c1 = (c >> (1 * 8)) & 0xFF;

    auto guid = UUID(a3, a2, a1, a0, b1, b0, c1, c0, d, e, f, g, h, i, j, k);

    return guid;
}

private string readConstantValue(scope ref const CustomAttributeEntity ca, bool isPropKey)
{
    assert(ca.name() == "ConstantAttribute");
    auto sig = ca.value();
    
    if (sig.fixed.length != 1)
    {
        throw new Exception(format("ConstantAttribute contains %s FixedArgSig elements, expected 1", sig.fixed.length));
    }

    auto element = sig.fixed[0].value.peek!ElementSig;
    assert(element != null);

    // propkey (PROPERTYKEY/DEVPROPKEY) values are strings like "{4277826612, 57597, 19242, 144, 90, 125, 1, 39, 169, 240, 28}, 2"
    if (isPropKey)
    {
        if (element.value.peek!string == null)
        {
            throw new Exception("ConstantAttribute fixed[0] FixedArgSig element's value is not string");
        }
        const string strValue = element.value.get!string;
        if (strValue.count('{') != 1)
        {
            throw new Exception("ConstantAttribute: invalid PROPERTYKEY value: '{' count != 1");
        }
        if (strValue.count('}') != 1)
        {
            throw new Exception("ConstantAttribute: invalid PROPERTYKEY value: '}' count != 1");
        }

        auto idxOpenBr = strValue.indexOf('{');
        auto idxCloseBr = strValue.indexOf('}');
        auto guidStr = strValue[idxOpenBr + 1 .. idxCloseBr];
        string[] guidParts = guidStr.split(",").map!(s => s.strip).array;
        if (guidParts.length != 11)
        {
            throw new Exception(format("ConstantAttribute: invalid GUID components count %s != 11", guidParts.length));
        }
        string[] guidPartsHex = [
            format("%08X", to!uint(guidParts[0])),
            format("%04X", to!ushort(guidParts[1])),
            format("%04X", to!ushort(guidParts[2])),
            format("%02X", to!ubyte(guidParts[3])),
            format("%02X", to!ubyte(guidParts[4])),
            format("%02X", to!ubyte(guidParts[5])),
            format("%02X", to!ubyte(guidParts[6])),
            format("%02X", to!ubyte(guidParts[7])),
            format("%02X", to!ubyte(guidParts[8])),
            format("%02X", to!ubyte(guidParts[9])),
            format("%02X", to!ubyte(guidParts[10])),
            ];

        auto guidValue = guidPartsHex[0] 
            ~ "-" ~ guidPartsHex[1] 
            ~ "-" ~ guidPartsHex[2]
            ~ "-" ~ guidPartsHex[3] ~ guidPartsHex[4]
            ~ "-" ~ guidPartsHex[5 .. $].join();

        auto pidStr = strValue[idxCloseBr + 1 .. $];

        return "GUID(\"" ~ guidValue ~ "\")" ~ pidStr;
    }

    // This is unused

    import std.math.algebraic : abs;
    import std.math.traits : signbit, isInfinity, isNaN;

    if (auto s = element.value.peek!bool)
        return format("%s", *s);
    else if (auto s = element.value.peek!wchar) // TODO: to '\u00A9' form
        return format("%s", *s);
    else if (auto s = element.value.peek!ubyte)
        return format("%s", *s);
    else if (auto s = element.value.peek!byte)
        return format("%s", *s);
    else if (auto s = element.value.peek!ushort)
        return format("%s", *s);
    else if (auto s = element.value.peek!short)
        return format("%s", *s);
    else if (auto s = element.value.peek!uint)
        return format("%s", *s);
    else if (auto s = element.value.peek!int)
        return format("%s", *s);
    else if (auto s = element.value.peek!ulong)
        return format("%s", *s);
    else if (auto s = element.value.peek!long)
        return format("%s", *s);
    else if (auto s = element.value.peek!float)
        return format("%s", *s);
    else if (auto s = element.value.peek!double)
        return format("%s", *s);
    else if (auto s = element.value.peek!string)
        return format("\"string %s\"", *s); // TODO: escape?
    else if (auto s = element.value.peek!SystemType)
        return format("SystemType %s", *s); // TODO: unused
    else if (auto s = element.value.peek!EnumDefinition)
        return format("EnumDefinition %s", *s); // TODO: unused
    else
        return "null";

    // if (auto s = element.peek!wstring)
    //     return format("\"%s\"", *s);
    // // else if (auto n = v.peek!(typeof(null)))
    // //     return ("null");
    // else if (auto i = v.peek!int)
    //     f.writef("0x%08x", *i);
    // else if (auto i = v.peek!uint)
    //     f.writef("0x%08x", *i);
    // else if (auto i = v.peek!short)
    //     f.writef("0x%04x", *i);
    // else if (auto i = v.peek!ushort)
    //     f.writef("0x%04x", *i);
    // else if (auto i = v.peek!byte)
    //     f.writef("0x%02x", *i);
    // else if (auto i = v.peek!ubyte)
    //     f.writef("0x%02x", *i);
    // else if (auto i = v.peek!long)
    //     f.writef("0x%016x", *i);
    // else if (auto i = v.peek!ulong)
    //     f.writef("0x%016x", *i);
    // else if (auto i = v.peek!float)
    // {
    //     if (signbit(*i))
    //         f.write("-");
    //     if (isNaN(*i))
    //         f.write("float.nan");
    //     else if (isInfinity(*i))
    //         f.write("float.infinity");
    //     else
    //         f.writef("%a", abs(*i));
    // }
    // else if (auto i = v.peek!double)
    // {
    //     if (signbit(*i))
    //         f.write("-");
    //     if (isNaN(*i))
    //         f.write("double.nan");
    //     else if (isInfinity(*i))
    //         f.write("double.infinity");
    //     else
    //         f.writef("%a", abs(*i));
    // }
    // else
    // {
    //     f.write(v);
    // }

    return "";
}

private Nullable!TypeDefEntity resolveType(scope ref const TypeSig.TypeValue v)
{
    if (auto r = v.peek!TypeDefEntity)
        return Nullable!TypeDefEntity(*r);
    else if (auto r = v.peek!TypeRefEntity)
        return r.resolve();
    else
        return (Nullable!TypeDefEntity).init;
}

string getUnique(string s)
{
    static int i;
    return s ~ to!string(i++);
}

string getParamText(scope ref const ParamSig sig, scope ref const ParamEntity param, scope ref const string[string] safeWords)
{
    string s;
    bool isConst;
    int nativeReplacement;
    foreach(ca; param.getCustomAttributes())
    {
        if (ca.name == "ConstAttribute")
            isConst = true;
        else if (ca.name() == "NativeTypeInfoAttribute")
        {
            auto fixed = ca.value().fixed[0];
            auto element = fixed.value.get!ElementSig;
            nativeReplacement = element.value.get!int;
        }
        else if (ca.name() == "ComOutPtrAttribute")
        {
            //can't find any use
        }
        else if (ca.name() == "NativeArrayInfoAttribute")
        {
            //cant't find any use
        }
        else if (ca.name() == "NotNullTerminated")
        {
            //cant't find any use
        }
        else if (ca.name() == "RetValAttribute")
        {
            //cant't find any use
        }
        else if (ca.name() == "NullNullTerminatedAttribute")
        {
            //cant't find any use
        }
        else
            s = format("/*PARAM ATTR: %s : %s*/", ca.name(), ca.value());
    }
    if (sig.isByRef)
         s = "ref ";

    auto attr = param.getFlags();
    //if (attr.isIn)
    //    f.write("in ");
    //if (attr.isOut)
    //    f.write("/* out */ ");
    //if (attr.isOptional)
    //    f.write("/* optional */ ");
    s ~= getTypeText(sig.typeSig, safeWords, isConst, nativeReplacement);
    s ~= " " ~ safeWords.get(param.getName(), param.getName());
    return s;
}

void dumpGUIDAttr(scope ref std.stdio.File f, scope ref const CustomAttributeEntity ca)
{
    f.writefln("@GUID(\"%s\")", readGuid(ca));
}

string nameof(T)(T value)
{
    if (auto td = value.peek!TypeDefEntity)
       return td.getTypeName();
    else if (auto td = value.peek!TypeRefEntity)
        return td.getTypeName();
    return null;
}
