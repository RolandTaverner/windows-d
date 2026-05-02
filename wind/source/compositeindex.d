module compositeindex;

import bits;


struct CompositeIndex(T)
{
    public uint codedIndex;

    this(uint codedIndex)
    {
        this.codedIndex = codedIndex;
    }

    this(uint decodedIndex, T value)
    {        
        this.codedIndex = (decodedIndex << indexBits!T) | value;
    }

    uint index()
    {
        return codedIndex >> indexBits!T;
    }

    T type()
    {
        return cast(T)(codedIndex & ((1 << indexBits!T) - 1));
    }
}

@Bits(2)
enum TypeDefOrRef
{
    typeDef,
    typeRef,
    typeSpec,
}

@Bits(2)
enum HasConstant
{
    field,
    param,
    property,
}

@Bits(5)
enum HasCustomAttribute
{
    methodDef,
    field,
    typeRef,
    typeDef,
    param,
    interfaceImpl,
    memberRef,
    module_,
    permission,
    property,
    event,
    standAloneSig,
    moduleRef,
    typeSpec,
    assembly,
    assemblyRef,
    file,
    exportedType,
    manifestResource,
    genericParam,
    genericParamConstraint,
    methodSpec,
}

@Bits(1)
enum HasFieldMarshal
{
    field,
    param,
}

@Bits(2)
enum HasDeclSecurity
{
    typeDef,
    methodDef,
    assembly,
}

@Bits(3)
enum MemberRefParent
{
    typeDef,
    typeRef,
    moduleRef,
    methodDef,
    typeSpec,
}

@Bits(1)
enum HasSemantics
{
    event,
    property,
}

@Bits(1)
enum MethodDefOrRef
{
    methodDef,
    memberRef,
}

@Bits(1)
enum MemberForwarded
{
    field,
    methodDef,
}

@Bits(2)
enum Implementation 
{
    file,
    assemblyRef,
    exportedType,
}

@Bits(3)
enum CustomAttributeType
{
    methodDef = 2,
    memberRef,
}

@Bits(2)
enum ResolutionScope 
{
    module_,
    moduleRef,
    assemblyRef,
    typeRef,
}


@Bits(1)
enum TypeOrMethodDef
{
    typeDef,
    methodDef,
}
