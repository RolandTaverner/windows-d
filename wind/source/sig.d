module sig;

public import std.variant: Algebraic;
import std.exception: enforce;
import std.format: format;

import attributeprops;
import compositeindex;
import metadata: Metadata;
import rowtypes;
import reader;
import convert;


struct CustomModSig
{
    @disable this();
    this(ref const(ubyte)[] data)
    {
        elementType = readCompressed!ElementType(data);
        assert(elementType == ElementType.cModOpt || elementType == ElementType.cModReqd);
        typeIndex = CompositeIndex!TypeDefOrRef(readCompressed!uint(data));        
    }

    ElementType elementType;
    CompositeIndex!TypeDefOrRef typeIndex;
}

CustomModSig[] readCustomMods(ref const(ubyte)[] data)
{
    CustomModSig[] mods;
    auto et = peekCompressed!ElementType(data);
    while (et == ElementType.cModOpt || et == ElementType.cModReqd)
    {
        mods ~= CustomModSig(data);
        et = peekCompressed!ElementType(data);
    }
    return mods;
}

struct GenericTypeIndex { uint index; }
struct GenericMethodTypeIndex { uint index; }

struct TypeSig
{    
    alias TypeValue = Algebraic!(ElementType, TypeDef, TypeRef, TypeSpec, GenericTypeInstSig, GenericTypeIndex, GenericMethodTypeIndex);
    this(const(Metadata)* db, ref const(ubyte)[] data)
    {
        isSZArray = readCompressedCond!ElementType(data, ElementType.szArray);
        isArray = readCompressedCond!ElementType(data, ElementType.array);
        while (readCompressedCond!ElementType(data, ElementType.ptr))
            ++ptrCount;
        customMods = readCustomMods(data);
        elementType = peekCompressed!ElementType(data);
        type = readTypeValue(db, data);
        if (isArray)
        {
            arrayRank = readCompressed(data);
            arraySizes.length = readCompressed(data);
            for (size_t i = 0; i < arraySizes.length; ++i)
                arraySizes[i] = readCompressed(data);
        }
    }

    bool isSZArray;
    bool isArray;
    int ptrCount;
    ElementType elementType;
    TypeValue type;
    uint arrayRank;
    uint[] arraySizes;
    CustomModSig[] customMods;

    private TypeValue readTypeValue(const(Metadata*) db, ref const(ubyte)[] data)
    {        
        auto t = readCompressed!ElementType(data);
        switch (t)
        {
            case ElementType.boolean:
            case ElementType.char_:
            case ElementType.i1:
            case ElementType.u1:
            case ElementType.i2:
            case ElementType.u2:
            case ElementType.i4:
            case ElementType.u4:
            case ElementType.i8:
            case ElementType.u8:
            case ElementType.r4:
            case ElementType.r8:
            case ElementType.string:
            case ElementType.object:
            case ElementType.u:
            case ElementType.i:
            case ElementType.void_:
                return TypeValue(t);
            case ElementType.class_:
            case ElementType.valueType:
                auto ci = CompositeIndex!TypeDefOrRef(readCompressed(data));
                if (ci.type == TypeDefOrRef.typeDef)
                    return TypeValue(db.typeDefTable[ci.index]);
                else if (ci.type == TypeDefOrRef.typeRef)
                    return TypeValue(db.typeRefTable[ci.index]);
                else
                    return TypeValue(db.typeSpecTable[ci.index]);
            case ElementType.var:
                return TypeValue(GenericTypeIndex(readCompressed(data)));
            case ElementType.mVar:
                return TypeValue(GenericMethodTypeIndex(readCompressed(data)));                
            case ElementType.genericInst:
                return TypeValue(GenericTypeInstSig(db, data));
            default:
                throw new Exception("Invalid element type");
        }
        assert(0);
    }
}

struct GenericTypeInstSig
{
    this(const(Metadata*) db, ref const(ubyte)[] data)
    {
        value = readCompressed!ElementType(data);
        enforce(value == ElementType.class_ || value == ElementType.valueType, "Invalid generic type instantation");
        typeIndex = CompositeIndex!TypeDefOrRef(readCompressed!uint(data));
        genericArgs.length = readCompressed(data);
        enforce(genericArgs.length <= data.length, "Invalid generic argument count");
        for (size_t i = 0; i < genericArgs.length; ++i)
            genericArgs[i] = TypeSig(db, data);
    }

    ElementType value;
    CompositeIndex!TypeDefOrRef typeIndex;
    TypeSig[] genericArgs;    
}

struct ParamSig
{
    this(const(Metadata*) db, ref const(ubyte)[] data)
    {     
        customMods = readCustomMods(data);
        isByRef = readCompressedCond(data, ElementType.byRef);
        typeSig = TypeSig(db, data);
    }

    CustomModSig[] customMods;
    bool isByRef;
    TypeSig typeSig;
}

struct RetTypeSig
{
    this(const(Metadata*) db, ref const(ubyte)[] data)
    {
        customMods = readCustomMods(data);
        isByRef = readCompressedCond(data, ElementType.byRef);
        isVoid = readCompressedCond(data, ElementType.void_);
        if (!isVoid)        
            typeSig = TypeSig(db, data);        
    }

    CustomModSig[] customMods;
    bool isByRef;
    bool isVoid;
    TypeSig typeSig;
}

struct MethodDefSig
{
    this(const(Metadata*) db, ref const(ubyte)[] data)
    {
        callingConvention = readCompressed!CallingConvention(data);
        if (callingConvention == CallingConvention.generic)
            genericParamCount = readCompressed(data);
        params.length = readCompressed(data);
        retSig = RetTypeSig(db, data);
        enforce(params.length <= data.length, "Invalid number of parameters");
        for (size_t i = 0; i < params.length; ++i)
            params[i] = ParamSig(db, data);
    }

    CallingConvention callingConvention;
    uint genericParamCount;
    RetTypeSig retSig;
    ParamSig[] params;
}

struct FieldSig
{
    this(const(Metadata)* db, ref const(ubyte)[] data)
    {
        callingConvention = read!CallingConvention(data);
        enforce((callingConvention & CallingConvention.field) == CallingConvention.field, "Invalid field signature");
        customMods = readCustomMods(data);
        typeSig = TypeSig(db, data);
    }

    CallingConvention callingConvention;
    CustomModSig[] customMods;
    TypeSig typeSig;
}

struct PropertySig
{
    this(const(Metadata*) db, ref const(ubyte)[] data)
    {
        callingConvention = read!CallingConvention(data);
        enforce(callingConvention == CallingConvention.property, "Invalid calling convention for property");
        params.length = readCompressed!uint(data);
        customMods = readCustomMods(data);
        typeSig = TypeSig(db, data);
        enforce(params.length <= data.length, "Invalid parameter count for property");
        for (size_t i = 0; i < params.length; ++i)
            params[i] = ParamSig(db, data);
    }

    CallingConvention callingConvention;
    CustomModSig[] customMods;
    TypeSig typeSig;
    ParamSig[] params;
}

struct TypeSpecSig
{
    this(const(Metadata*) db, ref const(ubyte)[] data)
    {
        isSZArray = readCompressedCond!ElementType(data, ElementType.szArray);
        isArray = readCompressedCond!ElementType(data, ElementType.array);
        while (readCompressedCond!ElementType(data, ElementType.ptr))
            ++ptrCount;
        customMods = readCustomMods(data);
        elementType = readCompressed!ElementType(data);
        if (elementType == ElementType.fnPtr)
            methodSig = MethodDefSig(db, data);
        else if (elementType == ElementType.genericInst) 
            genSig = GenericTypeInstSig(db, data);
        else 
            throw new Exception("Unsupported TypeSpec signature");
        if (isArray)
        {
            arrayRank = readCompressed(data);
            arraySizes.length = readCompressed(data);
            for (size_t i = 0; i < arraySizes.length; ++i)
                arraySizes[i] = readCompressed(data);
        }
    }

    bool isSZArray;
    bool isArray;
    int ptrCount;
    uint arrayRank;
    uint[] arraySizes;
    ElementType elementType;
    CustomModSig[] customMods;
    GenericTypeInstSig genSig;
    MethodDefSig methodSig;
}

struct SystemType 
{
    string name;
}

struct EnumDefinition
{
    alias Value = Algebraic!(bool, wchar, ubyte, byte, ushort, short, uint, int, ulong, long);
    TypeDef type;
    Value value;
}

struct ElementSig
{
    alias Value = Algebraic!(bool, wchar, ubyte, byte, ushort, short, uint, int, ulong, long, float, double, string, SystemType, EnumDefinition);

    this(SystemType type)
    {
        value = Value(type);
    }

    this(ElementType e, ref const(ubyte)[] data)
    {
        value = readPrimitiveValue(e, data);
    }

    this(const ref TypeDef type, ref const(ubyte)[] data)
    {
        enforce(type.isEnum, "Only System.Enum types are supported");
        value = EnumDefinition(type, readEnumValue(type.underlyingEnumType, data));
    }

    this(const(Metadata)* db, ref const TypeSig.TypeValue paramType, ref const(ubyte)[] data)
    {
        if (auto p = paramType.peek!ElementType())
            value = readPrimitiveValue(*p, data);
        else if (auto ti = paramType.peek!TypeRef)    
        {
            if (ti.name == "Type" && ti.namespace == "System")
                value = SystemType(readString(data));
            else if(ti.name == "UnmanagedType" && ti.namespace == "System.Runtime.InteropServices")
                value = read!int(data);
            else if(ti.name == "CallingConvention" && ti.namespace == "System.Runtime.InteropServices")
                value = read!int(data);
            else
                throw new Exception(
                                    format("Type references (%s.%s) do not provide enough information to read enum values",
                                           ti.namespace, ti.name));
        }
        else if (auto ti = paramType.peek!TypeDef)
        {
            if (ti.name == "Type" && ti.namespace == "System")
                value = SystemType(readString(data));
            else if (ti.isEnum)                
                value = EnumDefinition(*ti, readEnumValue(ti.underlyingEnumType, data));
            else
                throw new Exception("Unsupported attribute type");
        }
        else
            throw new Exception("Type specs do not provide enough information to read enum values");
    }


    private Value readPrimitiveValue(ElementType e, ref const(ubyte)[] data)
    {
        switch (e)
        {
            case ElementType.boolean:
                return Value(read!bool(data));
            case ElementType.char_:
                return Value(read!wchar(data));
            case ElementType.i1:
                return Value(read!byte(data));
            case ElementType.u1:
                return Value(read!ubyte(data));
            case ElementType.i2:
                return Value(read!short(data));
            case ElementType.u2:
                return Value(read!ushort(data));
            case ElementType.i4:
                return Value(read!int(data));
            case ElementType.u4:
                return Value(read!uint(data));
            case ElementType.i8:
                return Value(read!long(data));
            case ElementType.u8:
                return Value(read!ulong(data));
            case ElementType.r4:
                return Value(read!float(data));
            case ElementType.r8:
                return Value(read!double(data));
            case ElementType.string:
                return Value(readString(data));
            default:
                throw new Exception("Expecting primitive value");
        }
        assert(0);
    }

    private EnumDefinition.Value readEnumValue(ElementType e, ref const(ubyte)[] data)
    {
        switch (e)
        {
            case ElementType.boolean:
                return EnumDefinition.Value(read!bool(data));
            case ElementType.char_:
                return EnumDefinition.Value(read!wchar(data));
            case ElementType.i1:
                return EnumDefinition.Value(read!byte(data));
            case ElementType.u1:
                return EnumDefinition.Value(read!ubyte(data));
            case ElementType.i2:
                return EnumDefinition.Value(read!short(data));
            case ElementType.u2:
                return EnumDefinition.Value(read!ushort(data));
            case ElementType.i4:
                return EnumDefinition.Value(read!int(data));
            case ElementType.u4:
                return EnumDefinition.Value(read!uint(data));
            case ElementType.i8:
                return EnumDefinition.Value(read!long(data));
            case ElementType.u8:
                return EnumDefinition.Value(read!ulong(data));        
            default:
                throw new Exception("Non primitive types are not supported");
        }
    }
    Value value;
}

struct FixedArgSig
{
    alias Value = Algebraic!(ElementSig, ElementSig[]);

    this(const(Metadata)* db, const ref TypeSig typeSig, ref const(ubyte)[] data)
    {
        if (typeSig.isSZArray)
        {
            ElementSig[] elements;
            auto count = read!uint(data);
            if (count != uint.max)
            {
                enforce(count <= data.length, "Invalid blob size for array");
                elements.length = count;
                for(uint i = 0; i < count; ++i)
                    elements[i] = ElementSig(db, typeSig.type, data);                
            }
            value = elements;
        }
        else
            value = ElementSig(db, typeSig.type, data);        
    }

    this(ElementType type, bool isArray, ref const(ubyte)[] data)
    {

        if (isArray)
        {
            ElementSig[] elements;
            auto count = read!uint(data);
            if (count != uint.max)
            {
                enforce(count <= data.length, "Invalid blob size for array");
                elements.length = count;
                for(uint i = 0; i < count; ++i)
                    elements[i] = ElementSig(type, data);                
            }
            value = elements;
        }
        else
            value = ElementSig(type, data);        
    }

    this(SystemType type)
    {
        value = ElementSig(type);
    }

    this(const ref TypeDef type, ref const(ubyte)[] data)
    {
        value = ElementSig(type, data);
    }

    Value value;
}

struct NamedArgSig
{
    this(const(Metadata)* db, ref const(ubyte)[] data)
    {
        auto e = read!ElementType(data);
        enforce(e == ElementType.field || e == ElementType.property, 
                "Only fields or properties can be passed as named arguments");
        e = read!ElementType(data);
        switch(e)
        {
            case ElementType.type:
                name = readString(data);
                value = FixedArgSig(SystemType(readString(data)));
                break;
            case ElementType.enum_:
                auto type = readString(data);
                name = readString(data);  
                auto def = db.findByName(type);
                if (def.isNull && type == "System.Runtime.InteropServices.UnmanagedType")
                    value = FixedArgSig(ElementType.i4, false, data);
                else
                {
                    enforce(!def.isNull, format("Unknown enum type (%s) for named parameter %s", type, name));
                    enforce(def.get.isEnum, "Only enum type can be used as named parameters");
                    value = FixedArgSig(def.get, data);
                }
                break;
            default:
                bool isArray = e == ElementType.szArray;
                if (isArray)                
                    e = read!ElementType(data);
                enforce (e >= ElementType.boolean && e <= ElementType.string, "Invalid data type for named parameter");
                name = readString(data);
                value = FixedArgSig(e, isArray, data);
                break;
        }
    }

    string name;
    FixedArgSig value;
}

struct CustomAttributeSig
{
    this(const(Metadata)* db, ref const(ubyte)[] data, MethodDefSig ctor)
    {     
        enforce(asVal!ushort(data) == 0x0001, "Invalid prolog for custom attribute");
        data = data[2 .. $];    
        fixed.length = ctor.params.length;
        for(size_t i = 0; i < fixed.length; ++i)
            fixed[i] = FixedArgSig(db, ctor.params[i].typeSig, data);
        named.length = read!ushort(data);
        for(size_t i = 0; i < named.length; ++i)
            named[i] = NamedArgSig(db, data);
    }    

    FixedArgSig[] fixed;
    NamedArgSig[] named;
}

struct FieldMarshalSig
{
    this(ref const(ubyte)[] data)
    {     
        isArray = readCompressedCond!NativeType(data, NativeType.array);
        elementType = readCompressed!NativeType(data);
        if (data.length)
            paramNum = readCompressed!uint(data);
        if (data.length)
            arrayRank = readCompressed!uint(data);
    }

    bool isArray;
    uint paramNum;
    uint arrayRank;
    NativeType elementType;
    GenericTypeInstSig genSig;
    MethodDefSig methodSig;
}

struct PermissionSig
{
    this(const(Metadata)* db, ref const(ubyte)[] data)
    {     
        enforce(read!char(data) == '.', "Invalid permission signature");
        permissions.length = readCompressed!uint(data);
        for (size_t i = 0; i < permissions.length; ++i)
            permissions[i] = PermissionSetSig(db, data);
    }

    PermissionSetSig[] permissions;
}

struct PermissionSetSig
{
    this(const(Metadata)* db, ref const(ubyte)[] data)
    {           
        name = readString(data);
        arguments.length = read!ushort(data);
        for(size_t i = 0; i < arguments.length; ++i)
            arguments[i] = NamedArgSig(db, data);
    }    

    string name;
    NamedArgSig[] arguments;
}
