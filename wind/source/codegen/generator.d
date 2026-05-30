module codegen.generator;

import std.algorithm.iteration : filter, map, uniq;
import std.algorithm.searching : canFind, startsWith;
import std.algorithm.sorting : sort;
import std.array : array;
import std.container.rbtree : RedBlackTree;
import std.range : padLeft, chain;
import std.stdio;

import climetadata.mdcollection.database;
import climetadata.mdcollection.entity;
import climetadata.mdcollection.entitytypes;
import climetadata.mdcollection.sigtnature;

public struct Generator
{
    @disable this();

    this(const Database *db, ref const string[] ignoredNamespaces)
    {
        this.db = db;
        this.ignoredNamespaces = ignoredNamespaces.dup;
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

    private StringSet[string] dependencies;
    private TypeSet[const(TypeDefEntity)] nestedMap;

    private const Database *db;
    private const string[] ignoredNamespaces;
}

alias StringSet = RedBlackTree!string;
alias TypeSet = bool[const(TypeDefEntity)];

auto getNamespaces(const Database* db, ref const string[] ignored)
{
    auto defSet = db.typeDefCollection.items().map!(a => a.getTypeNamespace()).array.sort.uniq;
    auto refSet = db.typeRefCollection.items().map!(a => a.getTypeNamespace()).array.sort.uniq;

    return chain(defSet, refSet).filter!(a => a.length > 0 && !ignored.canFind(a)).array.sort.uniq;
}

auto getTypeDefs(const Database* db, string namespace)
{
    return db.typeDefCollection.items().filter!(a => a.getTypeNamespace() == namespace);
}

string fullnameof(T)(T value)
{
    if (auto td = value.peek!TypeDefEntity)
        return td.getTypeNamespace() ~ "." ~ td.getTypeName();
    else if (auto td = value.peek!TypeRefEntity)
        return td.getTypeNamespace() ~ "." ~ td.getTypeName();
    return null;
}
