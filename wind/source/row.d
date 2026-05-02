module row;

import std.exception: enforce;
import std.format: format;
public import std.typecons : Nullable;
public import std.uuid : UUID;
public import std.variant: Algebraic;

public import attributes;
import compositeindex;
import convert;
public import md;
import table : Table;
public import sig;
import rowtypes;
import metadata: Metadata;
import reader;
import listenumerator;


public struct Row(MD md)
{
    private const(Table!md)* table;

    private uint index;

    this(const(Table!md)* table, uint index)
    {
        this.table = table;
        this.index = index;
    }

    private T getValue(T)(uint column) const
    {
        return table.getValue!T(index - 1, column);
    }

    private CompositeIndex!T getCompositeIndex(T)(uint column) const
    {
        auto ci =  table.getCompositeIndex!T(index - 1, column);
        return table.getCompositeIndex!T(index - 1, column);
    }

    private string getString(uint column) const
    {
        return table.getString(index - 1, column);
    }

    private UUID getGUID(uint column) const
    {
        return table.getGUID(index - 1, column);
    }

    private const(ubyte)[] getBlob(uint column) const
    {
        return table.getBlob(index - 1, column);
    }

    private auto getList(MD target)(uint column) const
    {
        return table.getList!target(index - 1, column);
    }

    private auto getRange(MD target)(ubyte targetColumn) const
    {
        return table.db.getRange!target(index, targetColumn);
    }

    private auto getAll(MD target)(ubyte targetColumn) const
    {
        return table.db.getAll!target(index, targetColumn);
    }

    private auto getRange(MD target, T)(ubyte targetColumn, T enumVal) const
    {
        return table.db.getRange!(target, T)(CompositeIndex!T(index, enumVal), targetColumn);
    }

    private auto findFirst(MD target)(ubyte targetColumn) const
    {
        return table.db.findFirst!target(index, targetColumn);
    }

    private auto findFirst(MD target, T)(ubyte targetColumn, T enumVal) const
    {
        return table.db.findFirst!(target, T)(CompositeIndex!T(index, enumVal), targetColumn);
    }

    private auto findFirstRequired(MD target)(ubyte targetColumn) const
    {
        return table.db.findFirstRequired!target(index, targetColumn);
    }

    private auto findFirstRequired(MD target, T)(ubyte targetColumn, T enumVal) const
    {
        return table.db.findFirstRequired!(target, T)(CompositeIndex!T(index, enumVal), targetColumn);
    }

    private auto findParent(MD target)(ubyte parentColumn) const
    {
        auto parentTable = table.db.getTable!target;
        uint parentRow = 0;
        uint parentVal = parentTable.getValue!uint(parentRow, parentColumn);
        while (parentVal < index && parentRow < parentTable.rowCount)
        {
            ++parentRow;
            parentVal = parentTable.getValue!uint(parentRow, parentColumn);
        }        
        enforce(parentRow < parentTable.rowCount, 
                format("Missing parent (%s) reference to child (%s - %d)", target.stringof, md.stringof, index));      
        //parentVal >= index
        if (parentVal == index)
			return table.db.getTable!target[parentRow + 1];
        else
        {
            //parentVal > index
            enforce(parentRow > 0,
                    format("Missing parent (%s) reference to child (%s - %d)", target.stringof, md.stringof, index));
            return table.db.getTable!target[parentRow];
        }
    }

    @safe pure nothrow
    bool opEquals()(auto ref const Row!md other) const
    {
        return this.index == other.index;
    }

    @safe pure nothrow
    int opCmp(ref const Row!md other) const
    {
        if (this.index > other.index)
            return 1;
        if (this.index < other.index)
            return -1;
        return 0;
    }

    @safe pure nothrow
    size_t toHash() const
    {
        return index;
    }


    static if (md == MD.module_)
    {
        public string name()
        {
            return getString(1);
        }

        public UUID mvId()
        {
            return getGUID(2);
        }

        public UUID encId()
        {
            return getGUID(3);
        }

        public UUID encBaseId()
        {
            return getGUID(4);
        }

        public auto attributes()
        {
            return getRange!(MD.customAttribute, HasCustomAttribute)(0, HasCustomAttribute.module_);
        }
    }
    else static if (md == MD.typeRef)
    {
        public string name() const
        {
            return getString(1);
        }

        public string namespace() const
        {
            return getString(2);
        }

        public auto resolutionScope() const
        {
            return compositeValue(table.db, getCompositeIndex!ResolutionScope(0));
        }

        public auto attributes() const
        {
            return getRange!(MD.customAttribute, HasCustomAttribute)(0, HasCustomAttribute.typeRef);
        }

        Nullable!TypeDef resolve() const
        {
            auto rs = resolutionScope();
            if (auto md = rs.peek!Module)
            {
                return table.db.findByName(namespace, name);
            }
            else if (auto tr = rs.peek!TypeRef)
            {
                auto parent = tr.resolve();
                if (parent.isNull)
                    return parent;
                auto nestings = parent.get.getAll!(MD.nestedClass)(1);
                foreach(n; nestings)
                {

                    if (n.nested.name  == this.name)
                        return Nullable!TypeDef(n.nested);
                }
            }
            return (Nullable!TypeDef).init;
        }
    }
    else static if (md == MD.typeDef)
    {
        public const(TypeAttributes) typeAttributes() const
        {
            return TypeAttributes(getValue!uint(0));
        }

        public string name() const
        {
            return getString(1);
        }

        public string namespace() const
        {
            return getString(2);
        }

        public auto extends() const
        {        
            alias V = Nullable!TypeDefOrRefValue;
            auto r = compositeValue(table.db, getCompositeIndex!TypeDefOrRef(3));
            if (auto td = r.peek!TypeDef)
                return (*td).index > 0 ? V(r) : V.init;
            return V(r);
        }

        public auto fields() const
        {
            return getList!(MD.field)(4);
        }

        public auto methods() const
        {
            auto g = getValue!uint(5);
            return getList!(MD.methodDef)(5);
        }

        public auto attributes() const
        {
            return getRange!(MD.customAttribute, HasCustomAttribute)(0, HasCustomAttribute.typeDef);
        }

        public auto interfaces() const
        {
            return getRange!(MD.interfaceImpl)(0);
        }

        public auto layout() const
        {
            return findFirst!(MD.classLayout)(2);
        }

        public auto genericParameters() const
        {
            return getRange!(MD.genericParam, TypeOrMethodDef)(2, TypeOrMethodDef.typeDef);
        }

        public auto methodImplementations() const
        {
            return getRange!(MD.methodImpl)(0);
        }

        public auto enclosing() const
        {          
            auto row = findFirst!(MD.nestedClass)(0);
            if (!row.isNull)            
                return Row!md(table, row.get.getValue!uint(1));                      
            return this;
        }

        public bool isEnum() const
        {
            auto row = extends();
            if (row.isNull)
                return false;
            if (row.get.peek!TypeRef)
            {
                auto td = row.get.get!TypeRef;
                return td.name == "Enum" && td.namespace == "System";
            }
            else if (row.get.peek!TypeDef)
            {
                auto td = row.get.get!TypeDef;
                return td.name == "Enum" && td.namespace == "System";
            }
            return false;            
        }

        public bool isDelegate() const
        {
            auto row = extends();
            if (row.isNull)
                return false;
            if (row.get.peek!TypeRef)
            {
                auto td = row.get.get!TypeRef;
                return td.name == "MulticastDelegate" && td.namespace == "System";
            }
            else if (row.get.peek!TypeDef)
            {
                auto td = row.get.get!TypeDef;
                return td.name == "MulticastDelegate" && td.namespace == "System";
            }
            return false;            
        }

        public bool isValueType() const
        {
            auto row = extends();
            if (row.isNull)
                return false;
            if (row.get.peek!TypeRef)
            {
                auto td = row.get.get!TypeRef;
                return td.name == "ValueType" && td.namespace == "System";
            }
            else if (row.get.peek!TypeDef)
            {
                auto td = row.get.get!TypeDef;
                return td.name == "ValueType" && td.namespace == "System";
            }
            return false;            
        }

        public bool isInterface() const
        {
            return typeAttributes.semantics == TypeSemantics.interface_;
        }

        public ElementType underlyingEnumType() const
        {
            ElementType result;
            foreach(field; fields)
            {
                if (!field.fieldAttributes.isLiteral && !field.fieldAttributes.isStatic)
                {
                    result = field.signature.typeSig.type.get!ElementType;
                    break;
                }
            }

            enforce(result >= ElementType.boolean && result <= ElementType.u8, "Invalid enum underlying type");
            return result;
        }

        public auto properties()
        {
            auto propMap = findFirst!(MD.propertyMap)(0);
            if (!propMap.isNull)
                return propMap.get.properties;
            else 
                return ListEnumerator!(MD.property)(table.db, 2, 1);
        }

        public auto events()
        {
            auto eventMap = findFirst!(MD.eventMap)(0);
            if (!eventMap.isNull)
                return eventMap.get.events;
            else 
                return ListEnumerator!(MD.event)(table.db, 2, 1);
        }

        public bool isNested() const
        {
            return !findFirst!(MD.nestedClass)(1).isNull;
        }
    }
    else static if (md == MD.field)
    {

        public FieldAttributes fieldAttributes() const
        {
            return FieldAttributes(getValue!ushort(0));
        }

        public string name() const
        {
            return getString(1);
        }

        public const(FieldSig) signature() const
        {
            auto view = getBlob(2);
            return FieldSig(table.db, view);
        }

        public auto attributes() const
        {
            return getRange!(MD.customAttribute, HasCustomAttribute)(0, HasCustomAttribute.field);
        }

        public auto parent() const
        {
            return findParent!(MD.typeDef)(4);
        }

        public auto constant() const
        {
            return findFirst!(MD.constant)(1, HasConstant.field);            
        }

        public auto marshal() const
        {
            return findFirst!(MD.fieldMarshal)(0, HasFieldMarshal.field);            
        }
    }
    else static if (md == MD.methodDef)
    {
        public uint RVA()
        {
            return getValue!uint(0);
        }

        public const(MethodAttributes) methodAttributes() const
        {
            return MethodAttributes(getValue!ushort(1), getValue!ushort(2));
        }

        public string name() const
        {
            return getString(3);
        }

        public MethodDefSig signature() const
        {
            auto data = getBlob(4);
            return MethodDefSig(table.db, data);
        }

        public auto parameters() const
        {
            return getList!(MD.param)(5);
        }

        public auto genericParameters() const
        {
            return getRange!(MD.genericParam, TypeOrMethodDef)(2, TypeOrMethodDef.methodDef);
        }

        public auto parent() const
        {
            return findParent!(MD.typeDef)(5);
        }

        public auto implementation()
        {
            return findFirst!(MD.implMap)(1, MemberForwarded.methodDef);
        }

        public auto attributes() const
        {
            return getRange!(MD.customAttribute, HasCustomAttribute)(0, HasCustomAttribute.methodDef);
        }
    }
    else static if (md == MD.param)
    {
        public const(ParamAttributes) paramAttributes() const
        {
            return ParamAttributes(getValue!ushort(0));
        }

        public uint rank() const
        {
            return getValue!uint(1);
        }

        public string name() const
        {
            return getString(2);
        }

        public auto constant() const
        {
            return findFirst!(MD.constant)(1, HasConstant.param);            
        }

        public auto marshal() const
        {
            return findFirst!(MD.fieldMarshal)(0, HasFieldMarshal.param);            
        }

        public auto attributes() const
        {
            return getRange!(MD.customAttribute, HasCustomAttribute)(0, HasCustomAttribute.param);
        }
    }
    else static if (md == MD.interfaceImpl)
    {
        public auto type() const
        {
            return table.db.typeDefTable[getValue!uint(0)];
        }

        public auto implementation() const
        {
            auto idx = getCompositeIndex!TypeDefOrRef(1);
            return compositeValue(table.db, idx);
        }

        public auto attributes() const
        {
            return getRange!(MD.customAttribute, HasCustomAttribute)(0, HasCustomAttribute.param);
        }
    }
    else static if (md == MD.memberRef)
    {
        public auto reference() const
        {
            auto idx = getCompositeIndex!MemberRefParent(0);
            return compositeValue(table.db, idx);
        }

        public string name() const
        {
            return getString(1);
        }

        public MethodDefSig signature() const
        {
            auto data = getBlob(2);
            return MethodDefSig(table.db, data);
        }

        public auto attributes()
        {
            return getRange!(MD.customAttribute, HasCustomAttribute)(0, HasCustomAttribute.memberRef);
        }

    }
    else static if (md == MD.constant)
    {
        alias ConstantValue = Algebraic!(bool, byte, ubyte, short, ushort, int, uint, long, ulong, wchar, float, double, wstring, typeof(null));

        public ConstantType type() const
        {
            return getValue!ConstantType(0);
        }

        public auto parent() const
        {
            auto idx = getCompositeIndex!HasConstant(1);
            return compositeValue(table.db, idx);
        }

        public auto value() const
        {
            auto t = type();
            if (t == ConstantType.class_)
                return ConstantValue(null);
            else
            {
                auto data = getBlob(2);
                if (t == ConstantType.string)
                    return ConstantValue(asArray!(immutable(wchar))(data));
                switch(t)
                {
                    case ConstantType.boolean:
                        return ConstantValue(asVal!bool(data));
                    case ConstantType.char_:
                        return ConstantValue(asVal!wchar(data));
                    case ConstantType.int8:
                        return ConstantValue(asVal!byte(data));
                    case ConstantType.uint8:
                        return ConstantValue(asVal!ubyte(data));
                    case ConstantType.int16:
                        return ConstantValue(asVal!short(data));
                    case ConstantType.uint16:
                        return ConstantValue(asVal!ushort(data));
                    case ConstantType.int32:
                        return ConstantValue(asVal!int(data));
                    case ConstantType.uint32:
                        return ConstantValue(asVal!uint(data));
                    case ConstantType.int64:
                        return ConstantValue(asVal!long(data));
                    case ConstantType.uint64:
                        return ConstantValue(asVal!ulong(data));
                    case ConstantType.float32:
                        return ConstantValue(asVal!float(data));
                    case ConstantType.float64:
                        return ConstantValue(asVal!double(data));
                    default:
                        assert(0);
                }
            }
        }      

    }
    else static if (md == MD.customAttribute)
    {
        public auto parent() const
        {
            auto idx = getCompositeIndex!HasCustomAttribute(0);
            return compositeValue(table.db, idx);
        }

        public auto constructor() const
        {
            auto idx = getCompositeIndex!CustomAttributeType(1);
            return compositeValue(table.db, idx);
        }

        public auto type() const
        {
            auto ctor = constructor;
            if (ctor.peek!MethodDef)
            {
                auto meth = ctor.get!MethodDef;
                return TypeDefOrRefValue(meth.parent);
            }
            else
            {
                auto mr = ctor.get!MemberRef;
                auto parent = mr.reference;
                if (parent.peek!TypeDef)
                    return TypeDefOrRefValue(parent.get!TypeDef);
                else
                    return TypeDefOrRefValue(parent.get!TypeRef);
            }
        }

        public auto name() const
        {
            auto t = type();
            if (auto td = t.peek!TypeDef)
                return td.name;
            else
                return t.get!TypeRef.name;
        }

        public auto value() const
        {
            auto view = getBlob(2);
            auto ctor = constructor();
            if (auto mdef = ctor.peek!MethodDef)
                return CustomAttributeSig(table.db, view, mdef.signature);
            else
                return CustomAttributeSig(table.db, view, ctor.get!MemberRef.signature);
        }
    }
    else static if (md == MD.fieldMarshal)
    {
        public auto parent() const
        {
            auto idx = getCompositeIndex!HasFieldMarshal(0);
            return compositeValue(table.db, idx);
        }

        public const(FieldMarshalSig) signature() const
        {
            auto data = getBlob(1);
            return FieldMarshalSig(data);
        }

    }
    else static if (md == MD.declSecurity)
    {

        public SecurityAction action() const
        {
            return getValue!SecurityAction(0);
        }

        public auto parent() const
        {
            auto idx = getCompositeIndex!HasDeclSecurity(1);
            return compositeValue(table.db, idx);
        }

        public const(PermissionSig) permissions() const
        {
            auto data = getBlob(2);
            return PermissionSig(table.db, data);
        }
    }
    else static if (md == MD.classLayout)
    {
        public ushort packingSize() const
        {
            return getValue!ushort(0);
        }

        public uint classSize() const
        {
            return getValue!uint(1);
        }

        public auto parent() const
        {
            return table.db.typeDefTable[getValue!uint(2)];
        }
    }
    else static if (md == MD.fieldLayout)
    {
        public uint offset() const
        {
            return getValue!uint(0);
        }

        public auto parent() const
        {
            return table.db.fieldTable[getValue!uint(1)];
        }
    }
    else static if (md == MD.standAloneSig)
    {
        public const(MethodDefSig) signature() const
        {
            auto data = getBlob(0);
            return MethodDefSig(table.db, data);
        }

        public auto attributes() const
        {
            return getRange!(MD.customAttribute, HasCustomAttribute)(0, HasCustomAttribute.standAloneSig);
        }
    }
    else static if (md == MD.eventMap) 
    {
        public auto parent() const
        {
            return table.db.typeDefTable[getValue!uint(0)];
        }

        public auto events() const
        {
            return getList!(MD.event)(1);
        }

    }
    else static if (md == MD.event)
    {
        public const(EventAttributes) eventAttributes() const
        {
            return EventAttributes(getValue!ushort(0));
        }

        public string name() const
        {
            return getString(1);
        }

        public auto eventType() const
        {
            auto idx = getCompositeIndex!TypeDefOrRef(2);
            return compositeValue(table.db, idx);
        }

        public auto attributes() const
        {
            return getRange!(MD.customAttribute, HasCustomAttribute)(0, HasCustomAttribute.event);
        }

        public auto parent() const
        {
            return findParent!(MD.eventMap)(1).parent();
        }

        public auto semantics() const
        {
            return getRange!(MD.methodSemantics, HasSemantics)(2, HasSemantics.event);
        }
    }
    else static if (md == MD.propertyMap)
    {
        public auto parent() const
        {
            return table.db.typeDefTable[getValue!uint(0)];
        }

        public auto properties() const
        {
            return getList!(MD.property)(1);
        }
    }
    else static if (md == MD.property)
    {
        public const(PropertyAttributes) propertyAttributes() const
        {
            return PropertyAttributes(getValue!ushort(0));
        }

        public string name() const
        {
            return getString(1);
        }

        public auto attributes() const
        {
            return getRange!(MD.customAttribute, HasCustomAttribute)(0, HasCustomAttribute.property);
        }

        public auto parent() const
        {
            return findParent!(MD.propertyMap)(1).parent();
        }

        public auto semantics() const
        {
            return getRange!(MD.methodSemantics, HasSemantics)(2, HasSemantics.property);
        }

        public auto constant() const
        {
            return findFirst!(MD.constant)(1, HasConstant.property);            
        }

        public const(PropertySig) signature() const
        {
            auto view = getBlob(2);
            return PropertySig(table.db, view);
        }
    }
    else static if (md == MD.methodSemantics)
    {
        public const(SemanticsAttributes) semantics()
        {
            return SemanticsAttributes(getValue!ushort(0));
        }

        public auto method()
        {
            return table.db.methodDefTable[getValue!uint(1)];
        }

        public auto association()
        {
            return compositeValue(table.db, getCompositeIndex!HasSemantics(2));
        }
    }
    else static if (md == MD.methodImpl)
    {
        public auto parent()
        {
            return table.db.methodDefTable[getValue!uint(0)];
        }

        public auto methodBody()
        {
            return compositeValue(table.db, getCompositeIndex!MethodDefOrRef(1));
        }

        public auto methodDeclaration()
        {
            return compositeValue(table.db, getCompositeIndex!MethodDefOrRef(2));
        }
    }
    else static if (md == MD.moduleRef)
    {
        public string name()
        {
            return getString(0);
        }   

        public auto attributes()
        {
            return getRange!(MD.customAttribute, HasCustomAttribute)(0, HasCustomAttribute.moduleRef);
        }
    }
    else static if (md == MD.typeSpec)
    {
        public const(TypeSpecSig) signature()
        {
            auto data = getBlob(0);
            return TypeSpecSig(table.db, data);
        }

        public auto attributes()
        {
            return getRange!(MD.customAttribute, HasCustomAttribute)(0, HasCustomAttribute.moduleRef);
        }
    }
    else static if (md == MD.implMap)
    {
        public PInvokeAttributes implAttributes()
        {
            return PInvokeAttributes(getValue!ushort(0));
        }

        public auto memberForwarded()
        {
            auto idx = getCompositeIndex!MemberForwarded(1);
            return compositeValue(table.db, idx);
        }

        public string name()
        {
            return getString(2);
        }

        public auto importScope()
        {
            return table.db.moduleRefTable[getValue!uint(3)];
        }

    }
    else static if (md == MD.fieldRVA)
    {
        public uint rva()
        {
            return getValue!uint(0);
        }

        public auto parent()
        {
            return table.db.fieldTable[getValue!uint(1)];
        }
    }
    else static if (md == MD.assembly)
    {
        public AssemblyHashAlgorithm algorithm()
        {
            return getValue!AssemblyHashAlgorithm(0);
        }

        public AssemblyVersion ver()
        {
            auto v = getValue!ulong(1);
            return *cast(AssemblyVersion*)(&v);
        }

        public AssemblyAttributes assemblyAttributes()
        {
            return AssemblyAttributes(getValue!uint(2));
        }

        public const(ubyte)[] publicKey()
        {
            return getBlob(3);
        }

        public string name()
        {
            return getString(4);
        }

        public string culture()
        {
            return getString(5);
        }

        public auto attributes()
        {
            return getRange!(MD.customAttribute, HasCustomAttribute)(0, HasCustomAttribute.assembly);
        }

    }
    else static if (md == MD.assemblyProcessor)
    {
        public AssemblyArch processor()
        {
            return getValue!AssemblyArch(0);
        }
    }
    else static if (md == MD.assemblyOS)
    {
        public uint osPlatform()
        {
            return getValue!uint(0);
        }

        public uint osMajorVersion()
        {
            return getValue!uint(1);
        }

        public uint osMinorVersion()
        {
            return getValue!uint(2);
        }
    }
    else static if (md == MD.assemblyRef)
    {
        public AssemblyVersion ver()
        {
            auto v = getValue!ulong(0);
            return *cast(AssemblyVersion*)(&v);
        }

        public AssemblyAttributes assemblyAttributes()
        {
            return AssemblyAttributes(getValue!uint(1));
        }

        public const(ubyte)[] publicKeyOrToken()
        {
            return getBlob(2);
        }

        public string name()
        {
            return getString(3);
        }

        public string culture()
        {
            return getString(4);
        }

        public auto attributes()
        {
            return getRange!(MD.customAttribute, HasCustomAttribute)(0, HasCustomAttribute.assemblyRef);
        }

    }
    else static if (md == MD.assemblyRefProcessor)
    {
        public AssemblyArch processor()
        {
            return getValue!AssemblyArch(0);
        }

        public auto assembly()
        {
            return table.db.assemblyRefTable[getValue!uint(1)];
        }
    }
    else static if (md == MD.assemblyRefOS)
    {
        public uint osPlatform()
        {
            return getValue!uint(0);
        }

        public uint osMajorVersion()
        {
            return getValue!uint(1);
        }

        public uint osMinorVersion()
        {
            return getValue!uint(2);
        }

        public auto assembly()
        {
            return table.db.assemblyRefTable[getValue!uint(3)];
        }
    }
    else static if (md == MD.file)
    {
        public bool hasMetadata()
        {
            return getValue!uint(0) != 0;
        }

        public string name()
        {
            return getString(1);
        }

        public const(ubyte)[] hash()
        {
            return getBlob(2);
        }

        public auto attributes()
        {
            return getRange!(MD.customAttribute, HasCustomAttribute)(0, HasCustomAttribute.file);
        }
    }
    else static if (md == MD.exportedType)
    {
        public TypeAttributes typeAttributes()
        {
            return TypeAttributes(getValue!uint(0));
        }

        public Nullable!TypeDef hint()
        {
            auto hintIndex = getValue!uint(1);
            if (table.db.typeDefTable.rowCount <= hintIndex)
            {
                auto td = table.db.typeDefTable[hintIndex];
                if (td.name == name && td.namespace == td.namespace)
                    return Nullable!TypeDef(td);
            }
            return (Nullable!TypeDef).init;
        }

        public string name()
        {
            return getString(2);
        }

        public string namespace()
        {
            return getString(3);
        }

        public auto implementation()
        {
            auto idx = getCompositeIndex!Implementation(4);
            return compositeValue(table.db, idx);
        }

        public auto attributes()
        {
            return getRange!(MD.customAttribute, HasCustomAttribute)(0, HasCustomAttribute.exportedType);
        }

    }
    else static if (md == MD.manifestResource)
    {        
        public uint offset()
        {
            return getValue!uint(0);
        }

        public ManifestVisibility visibility()
        {
            return getValue!ManifestVisibility(1);
        }

        public string name()
        {
            return getString(2);
        }

        public auto implementation()
        {
            auto idx = getCompositeIndex!Implementation(3);
            if (idx.codedIndex == 0)
                return Nullable!(ImplementationValue).init;
            return Nullable!(ImplementationValue)(compositeValue(table.db, idx));
        }

        public auto attributes()
        {
            return getRange!(MD.customAttribute, HasCustomAttribute)(0, HasCustomAttribute.manifestResource);
        }
    }
    else static if (md == MD.nestedClass)
    {        
        public auto nested()
        {
            return table.db.typeDefTable[getValue!uint(0)];
        }

        public auto enclosing()
        {
            return table.db.typeDefTable[getValue!uint(1)];
        }


    }
    else static if (md == MD.genericParam)
    {        
        public ushort rank()
        {
            return getValue!ushort(0);
        }

        public GenericAttributes genericAttributes()
        {
            return GenericAttributes(getValue!ushort(1));
        }

        public auto owner()
        {
            auto idx = getCompositeIndex!TypeOrMethodDef(2);
            return compositeValue(table.db, idx);
        }

        public string name()
        {
            return getString(3);
        }

        public auto attributes()
        {
            return getRange!(MD.customAttribute, HasCustomAttribute)(0, HasCustomAttribute.genericParam);
        }

    }
    else static if (md == MD.genericParamConstraint)
    {        
        public auto owner()
        {
            return table.db.genericParamTable[getValue!uint(0)];
        }

        public auto constraint()
        {
            auto idx = getCompositeIndex!TypeDefOrRef(1);
            return compositeValue(table.db, idx);
        }

        public auto attributes()
        {
            return getRange!(MD.customAttribute, HasCustomAttribute)(0, HasCustomAttribute.genericParamConstraint);
        }

    }
    else static assert ("Row!(" ~ md.stringof  ~ ") not implemented");
}


private auto compositeValue(T)(const(Metadata)* db, CompositeIndex!T c)
{
    static if (is(T == ResolutionScope))
    {
        final switch (c.type)
        {
            case ResolutionScope.module_:
                return ResolutionScopeValue(db.moduleTable[c.index]);
            case ResolutionScope.moduleRef:
                return ResolutionScopeValue(db.moduleRefTable[c.index]);
            case ResolutionScope.assemblyRef:
                return ResolutionScopeValue(db.assemblyRefTable[c.index]);
            case ResolutionScope.typeRef:
                return ResolutionScopeValue(db.typeRefTable[c.index]);
        }
    }
    else static if (is(T == MethodDefOrRef))
    {
        final switch (c.type)
        {
            case MethodDefOrRef.methodDef:
                return MethodDefOrRefValue(db.methodDefTable[c.index]);
            case MethodDefOrRef.memberRef:
                return MethodDefOrRefValue(db.memberRefTable[c.index]);
        }
    }
    else static if (is(T == CustomAttributeType))
    {
        final switch (c.type)
        {
            case CustomAttributeType.methodDef:
                return CustomAttributeTypeValue(db.methodDefTable[c.index]);
            case CustomAttributeType.memberRef:
                return CustomAttributeTypeValue(db.memberRefTable[c.index]);
        }
    }
    else static if (is(T == HasSemantics))
    {
        final switch (c.type)
        {
            case HasSemantics.event:
                return HasSemanticsValue(db.eventTable[c.index]);
            case HasSemantics.property:
                return HasSemanticsValue(db.propertyTable[c.index]);
        }
    }
    else static if (is(T == TypeOrMethodDef))
    {
        final switch (c.type)
        {
            case TypeOrMethodDef.typeDef:
                return TypeOrMethodDefValue(db.typeDefTable[c.index]);
            case TypeOrMethodDef.methodDef:
                return TypeOrMethodDefValue(db.methodDefTable[c.index]);
        }
    }
    else static if (is(T == MemberForwarded))
    {
        final switch (c.type)
        {
            case MemberForwarded.methodDef:
                return MemberForwardedValue(db.methodDefTable[c.index]);
            case MemberForwarded.field:
                return MemberForwardedValue(db.fieldTable[c.index]);
        }
    }
    else static if (is(T == HasFieldMarshal))
    {
        final switch (c.type)
        {
            case HasFieldMarshal.param:
                return HasFieldMarshalValue(db.paramTable[c.index]);
            case HasFieldMarshal.field:
                return HasFieldMarshalValue(db.fieldTable[c.index]);
        }
    }
    else static if (is(T == TypeDefOrRef))
    {
        final switch (c.type)
        {
            case TypeDefOrRef.typeDef:
                return TypeDefOrRefValue(db.typeDefTable[c.index]);
            case TypeDefOrRef.typeRef:
                return TypeDefOrRefValue(db.typeRefTable[c.index]);
            case TypeDefOrRef.typeSpec:
                return TypeDefOrRefValue(db.typeSpecTable[c.index]);
        }
    }
    else static if (is(T == HasDeclSecurity))
    {
        final switch (c.type)
        {
            case HasDeclSecurity.typeDef:
                return HasDeclSecurityValue(db.typeDefTable[c.index]);
            case HasDeclSecurity.methodDef:
                return HasDeclSecurityValue(db.methodDefTable[c.index]);
            case HasDeclSecurity.assembly:
                return HasDeclSecurityValue(db.assemblyTable[c.index]);
        }
    }
    else static if (is(T == MemberRefParent))
    {
        final switch (c.type)
        {
            case MemberRefParent.typeDef:
                return MemberRefParentValue(db.typeDefTable[c.index]);
            case MemberRefParent.typeRef:
                return MemberRefParentValue(db.typeRefTable[c.index]);
            case MemberRefParent.typeSpec:
                return MemberRefParentValue(db.typeSpecTable[c.index]);
            case MemberRefParent.moduleRef:
                return MemberRefParentValue(db.moduleRefTable[c.index]);
            case MemberRefParent.methodDef:
                return MemberRefParentValue(db.methodDefTable[c.index]);
        }
    }
    else static if (is(T == HasConstant))
    {
        final switch (c.type)
        {
            case HasConstant.param:
                return HasConstantValue(db.paramTable[c.index]);
            case HasConstant.field:
                return HasConstantValue(db.fieldTable[c.index]);
            case HasConstant.property:
                return HasConstantValue(db.propertyTable[c.index]);
        }
    }
    else static if (is(T == Implementation))
    {
        final switch (c.type)
        {
            case Implementation.file:
                return ImplementationValue(db.fileTable[c.index]);
            case Implementation.assemblyRef:
                return ImplementationValue(db.assemblyRefTable[c.index]);
            case Implementation.exportedType:
                return ImplementationValue(db.exportedTypeTable[c.index]);
        }
    }
    else static if(is(T == HasCustomAttribute))
    {
        final switch(c.type)
        {
            case HasCustomAttribute.methodDef:
                return HasCustomAttributeValue(db.methodDefTable[c.index]);
            case HasCustomAttribute.field:
                return HasCustomAttributeValue(db.fieldTable[c.index]);
            case HasCustomAttribute.typeRef:
                return HasCustomAttributeValue(db.typeRefTable[c.index]);
            case HasCustomAttribute.typeDef:
                return HasCustomAttributeValue(db.typeDefTable[c.index]);
            case HasCustomAttribute.param:
                return HasCustomAttributeValue(db.paramTable[c.index]);
            case HasCustomAttribute.interfaceImpl:
                return HasCustomAttributeValue(db.interfaceImplTable[c.index]);
            case HasCustomAttribute.memberRef:
                return HasCustomAttributeValue(db.memberRefTable[c.index]);
            case HasCustomAttribute.module_:
                return HasCustomAttributeValue(db.moduleTable[c.index]);
            case HasCustomAttribute.permission:
                return HasCustomAttributeValue(db.declSecurityTable[c.index]);
            case HasCustomAttribute.property:
                return HasCustomAttributeValue(db.propertyTable[c.index]);
            case HasCustomAttribute.event:
                return HasCustomAttributeValue(db.eventTable[c.index]);
            case HasCustomAttribute.standAloneSig:
                return HasCustomAttributeValue(db.standAloneSigTable[c.index]);
            case HasCustomAttribute.moduleRef:
                return HasCustomAttributeValue(db.moduleRefTable[c.index]);
            case HasCustomAttribute.typeSpec:
                return HasCustomAttributeValue(db.typeSpecTable[c.index]);
            case HasCustomAttribute.assembly:
                return HasCustomAttributeValue(db.assemblyTable[c.index]);
            case HasCustomAttribute.assemblyRef:
                return HasCustomAttributeValue(db.assemblyRefTable[c.index]);
            case HasCustomAttribute.file:
                return HasCustomAttributeValue(db.fileTable[c.index]);
            case HasCustomAttribute.exportedType:
                return HasCustomAttributeValue(db.exportedTypeTable[c.index]);
            case HasCustomAttribute.manifestResource:
                return HasCustomAttributeValue(db.manifestResourceTable[c.index]);
            case HasCustomAttribute.genericParam:
                return HasCustomAttributeValue(db.genericParamTable[c.index]);
            case HasCustomAttribute.genericParamConstraint:
                return HasCustomAttributeValue(db.genericParamConstraintTable[c.index]);
            case HasCustomAttribute.methodSpec:
                return HasCustomAttributeValue(db.methodSpecTable[c.index]);
        }
    }

}


public alias ResolutionScopeValue = Algebraic!(Module, ModuleRef, AssemblyRef, TypeRef);
public alias TypeDefOrRefValue = Algebraic!(TypeDef, TypeRef, TypeSpec);
public alias MemberRefParentValue = Algebraic!(TypeDef, TypeRef, TypeSpec, ModuleRef, MethodDef);
public alias HasConstantValue = Algebraic!(Param, Field, Property);
public alias HasCustomAttributeValue = Algebraic!(MethodDef, Field, TypeRef, TypeDef, Param, InterfaceImpl, MemberRef,
                                                  Module, DeclSecurity, Property, Event, StandAloneSig, ModuleRef, 
                                                  TypeSpec, Assembly, AssemblyRef, File, ExportedType, ManifestResource, 
                                                  GenericParam, GenericParamConstraint, MethodSpec);
public alias MethodDefOrRefValue = Algebraic!(MethodDef, MemberRef);
public alias HasFieldMarshalValue = Algebraic!(Field, Param);
public alias HasDeclSecurityValue = Algebraic!(TypeDef, MethodDef, Assembly);
public alias HasSemanticsValue = Algebraic!(Property, Event);
public alias MemberForwardedValue = Algebraic!(Field, MethodDef);
public alias ImplementationValue = Algebraic!(File, AssemblyRef, ExportedType);
public alias TypeOrMethodDefValue = Algebraic!(TypeDef, MethodDef);
public alias CustomAttributeTypeValue = Algebraic!(MethodDef, MemberRef);
