module climetadata.mdcollection.compositeindex;

public import std.variant : Algebraic;
public import climetadata.mdcollection.entitytypes;
import climetadata.mdcollection.bits;
import climetadata.mdtable.type;

struct CompositeIndex(CodedIndexType)
{
    public const uint codedIndex;

    this(uint codedIndex)
    {
        this.codedIndex = codedIndex;
    }

    this(uint decodedIndex, CodedIndexType value)
    {
        this.codedIndex = (decodedIndex << indexBits!CodedIndexType) | value;
    }

    uint index() const
    {
        return codedIndex >> indexBits!CodedIndexType;
    }

    CodedIndexType type()
    {
        return cast(T)(codedIndex & ((1 << indexBits!CodedIndexType) - 1));
    }
}

// Refer to Common Language Infrastructure (CLI), Partition II: Metadata Definition and Semantics, II.24.2.6 #~ stream
// Order of enum values must be preserved !!!

//=============================================================================
// TypeDefOrRef coded index

@Bits(2)
enum TypeDefOrRef
{
    typeDef,
    typeRef,
    typeSpec,
}

public alias TypeDefOrRefValue = Algebraic!(TypeDef, TypeRef, TypeSpec);

// private template isCodedIndexType(CodedIndexType) if (is(CodedIndexType == TypeDefOrRef))
// {
//     alias isCodedIndexType = true;
// }

public template CodedIndexValueType(CodedIndexType) if (is(CodedIndexType == TypeDefOrRef))
{
    alias CodedIndexValueType = TypeDefOrRefValue;
}

template CodedIndexMDTableType(CodedIndexType, CodedIndexType m) if (is(CodedIndexType == TypeDefOrRef))
{
    static if (m == TypeDefOrRef.typeDef)
    {
        alias CodedIndexMDTableType = MDTableType.typeDef;
    }
    else static if (m == TypeDefOrRef.typeRef)
    {
        alias CodedIndexMDTableType = MDTableType.typeRef;
    }
    else static if (m == TypeDefOrRef.typeSpec)
    {
        alias CodedIndexMDTableType = MDTableType.typeSpec;
    }
    else
    {
        static assert(false, "invalid coded index membder");
    }
}

unittest
{
    static assert (is(CodedIndexValueType!(TypeDefOrRef) == TypeDefOrRefValue));

    static assert(CodedIndexMDTableType!(TypeDefOrRef, TypeDefOrRef.typeDef) == MDTableType.typeDef);
    static assert(CodedIndexMDTableType!(TypeDefOrRef, TypeDefOrRef.typeRef) == MDTableType.typeRef);
    static assert(CodedIndexMDTableType!(TypeDefOrRef, TypeDefOrRef.typeSpec) == MDTableType.typeSpec);
}

//=============================================================================
// HasConstant coded index

@Bits(2)
enum HasConstant
{
    field,
    param,
    property,
}

public alias HasConstantValue = Algebraic!(Field, Param, Property);

public template CodedIndexValueType(CodedIndexType) if (is(CodedIndexType == HasConstant))
{
    alias CodedIndexValueType = HasConstantValue;
}

template CodedIndexMDTableType(CodedIndexType, CodedIndexType m) if (is(CodedIndexType == HasConstant))
{
    static if (m == HasConstant.field)
    {
        alias CodedIndexMDTableType = MDTableType.field;
    }
    else static if (m == HasConstant.param)
    {
        alias CodedIndexMDTableType = MDTableType.param;
    }
    else static if (m == HasConstant.property)
    {
        alias CodedIndexMDTableType = MDTableType.property;
    }
    else
    {
        static assert(false, "invalid coded index membder");
    }
}

unittest
{
    static assert (is(CodedIndexValueType!(HasConstant) == HasConstantValue));

    static assert(CodedIndexMDTableType!(HasConstant, HasConstant.field) == MDTableType.field);
    static assert(CodedIndexMDTableType!(HasConstant, HasConstant.param) == MDTableType.param);
    static assert(CodedIndexMDTableType!(HasConstant, HasConstant.property) == MDTableType.property);
}

//=============================================================================
// HasCustomAttribute coded index

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

public alias HasCustomAttributeValue = Algebraic!(
    MethodDef, Field, TypeRef, TypeDef, Param, InterfaceImpl, MemberRef,
    Module, DeclSecurity, Property, Event, StandAloneSig, ModuleRef,
    TypeSpec, Assembly, AssemblyRef, File, ExportedType, ManifestResource,
    GenericParam, GenericParamConstraint, MethodSpec);

public template CodedIndexValueType(CodedIndexType) if (is(CodedIndexType == HasCustomAttribute))
{
    alias CodedIndexValueType = HasCustomAttributeValue;
}

template CodedIndexMDTableType(CodedIndexType, CodedIndexType m) if (is(CodedIndexType == HasCustomAttribute))
{
    static if (m == HasCustomAttribute.methodDef)
    {
        alias CodedIndexMDTableType = MDTableType.methodDef;
    }
    else static if (m == HasCustomAttribute.field)
    {
        alias CodedIndexMDTableType = MDTableType.field;
    }
    else static if (m == HasCustomAttribute.typeRef)
    {
        alias CodedIndexMDTableType = MDTableType.typeRef;
    }
    else
    {
        static assert(false, "invalid coded index membder");
    }
}

unittest
{
    static assert (is(CodedIndexValueType!(HasCustomAttribute) == HasCustomAttributeValue));

    static assert(CodedIndexMDTableType!(HasCustomAttribute, HasCustomAttribute.methodDef) == MDTableType.methodDef);
    static assert(CodedIndexMDTableType!(HasCustomAttribute, HasCustomAttribute.field) == MDTableType.field);
    static assert(CodedIndexMDTableType!(HasCustomAttribute, HasCustomAttribute.typeRef) == MDTableType.typeRef);
}

//=============================================================================
// HasFieldMarshal coded index

@Bits(1)
enum HasFieldMarshal
{
    field,
    param,
}

public alias HasFieldMarshalValue = Algebraic!(Field, Param);

@Bits(2)
enum HasDeclSecurity
{
    typeDef,
    methodDef,
    assembly,
}

public alias HasDeclSecurityValue = Algebraic!(TypeDef, MethodDef, Assembly);

@Bits(3)
enum MemberRefParent
{
    typeDef,
    typeRef,
    moduleRef,
    methodDef,
    typeSpec,
}

public alias MemberRefParentValue = Algebraic!(TypeDef, TypeRef, ModuleRef, MethodDef, TypeSpec);

@Bits(1)
enum HasSemantics
{
    event,
    property,
}

public alias HasSemanticsValue = Algebraic!(Event, Property);

@Bits(1)
enum MethodDefOrRef
{
    methodDef,
    memberRef,
}

public alias MethodDefOrRefValue = Algebraic!(MethodDef, MemberRef);

@Bits(1)
enum MemberForwarded
{
    field,
    methodDef,
}

public alias MemberForwardedValue = Algebraic!(Field, MethodDef);

@Bits(2)
enum Implementation
{
    file,
    assemblyRef,
    exportedType,
}

public alias ImplementationValue = Algebraic!(File, AssemblyRef, ExportedType);

@Bits(3)
enum CustomAttributeType
{
    __notUsed1,
    __notUsed2,
    methodDef,
    memberRef,
    __notUsed3,
}

public alias CustomAttributeTypeValue = Algebraic!(MethodDef, MemberRef);

//=============================================================================
// ResolutionScope coded index

@Bits(2)
enum ResolutionScope
{
    module_,
    moduleRef,
    assemblyRef,
    typeRef,
}

public alias ResolutionScopeValue = Algebraic!(Module, ModuleRef, AssemblyRef, TypeRef);

public template CodedIndexValueType(CodedIndexType) if (is(CodedIndexType == ResolutionScope))
{
    alias CodedIndexValueType = ResolutionScopeValue;
}

template CodedIndexMDTableType(CodedIndexType, CodedIndexType m) if (is(CodedIndexType == ResolutionScope))
{
    static if (m == ResolutionScope.module_)
    {
        alias CodedIndexMDTableType = MDTableType.module_;
    }
    else static if (m == ResolutionScope.moduleRef)
    {
        alias CodedIndexMDTableType = MDTableType.moduleRef;
    }
    else static if (m == ResolutionScope.assemblyRef)
    {
        alias CodedIndexMDTableType = MDTableType.assemblyRef;
    }
    else static if (m == ResolutionScope.typeRef)
    {
        alias CodedIndexMDTableType = MDTableType.typeRef;
    }
    else
    {
        static assert(false, "invalid coded index membder");
    }
}

unittest
{
    static assert (is(CodedIndexValueType!(ResolutionScope) == ResolutionScopeValue));

    static assert(CodedIndexMDTableType!(ResolutionScope, ResolutionScope.module_) == MDTableType.module_);
    static assert(CodedIndexMDTableType!(ResolutionScope, ResolutionScope.moduleRef) == MDTableType.moduleRef);
    static assert(CodedIndexMDTableType!(ResolutionScope, ResolutionScope.assemblyRef) == MDTableType.assemblyRef);
    static assert(CodedIndexMDTableType!(ResolutionScope, ResolutionScope.typeRef) == MDTableType.typeRef);
}

//=============================================================================
// TypeOrMethodDef coded index

@Bits(1)
enum TypeOrMethodDef
{
    typeDef,
    methodDef,
}

public alias TypeOrMethodDefValue = Algebraic!(TypeDef, MethodDef);
