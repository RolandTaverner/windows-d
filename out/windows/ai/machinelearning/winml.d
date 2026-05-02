// Written in the D programming language.

module windows.ai.machinelearning.winml;

public import windows.core;
public import windows.foundation : BOOL, HRESULT, PSTR, PWSTR;
public import windows.graphics.direct3d12 : ID3D12Device, ID3D12Resource;
public import windows.system.com : IUnknown;

extern(Windows) @nogc nothrow:


// Enums

//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winml/ne-winml-winml_tensor_data_type))], [])

alias WINML_TENSOR_DATA_TYPE = int;
enum : int
{
    WINML_TENSOR_UNDEFINED  = 0x00000000,
    WINML_TENSOR_FLOAT      = 0x00000001,
    WINML_TENSOR_UINT8      = 0x00000002,
    WINML_TENSOR_INT8       = 0x00000003,
    WINML_TENSOR_UINT16     = 0x00000004,
    WINML_TENSOR_INT16      = 0x00000005,
    WINML_TENSOR_INT32      = 0x00000006,
    WINML_TENSOR_INT64      = 0x00000007,
    WINML_TENSOR_STRING     = 0x00000008,
    WINML_TENSOR_BOOLEAN    = 0x00000009,
    WINML_TENSOR_FLOAT16    = 0x0000000a,
    WINML_TENSOR_DOUBLE     = 0x0000000b,
    WINML_TENSOR_UINT32     = 0x0000000c,
    WINML_TENSOR_UINT64     = 0x0000000d,
    WINML_TENSOR_COMPLEX64  = 0x0000000e,
    WINML_TENSOR_COMPLEX128 = 0x0000000f,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winml/ne-winml-winml_feature_type))], [])

alias WINML_FEATURE_TYPE = int;
enum : int
{
    WINML_FEATURE_UNDEFINED = 0x00000000,
    WINML_FEATURE_TENSOR    = 0x00000001,
    WINML_FEATURE_SEQUENCE  = 0x00000002,
    WINML_FEATURE_MAP       = 0x00000003,
    WINML_FEATURE_IMAGE     = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winml/ne-winml-winml_binding_type))], [])

alias WINML_BINDING_TYPE = int;
enum : int
{
    WINML_BINDING_UNDEFINED = 0x00000000,
    WINML_BINDING_TENSOR    = 0x00000001,
    WINML_BINDING_SEQUENCE  = 0x00000002,
    WINML_BINDING_MAP       = 0x00000003,
    WINML_BINDING_IMAGE     = 0x00000004,
    WINML_BINDING_RESOURCE  = 0x00000005,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winml/ne-winml-winml_runtime_type))], [])

alias WINML_RUNTIME_TYPE = int;
enum : int
{
    WINML_RUNTIME_CNTK = 0x00000000,
}
//ENUM ATTR: ScopedEnumAttribute : CustomAttributeSig([], [])

enum MLOperatorAttributeType : uint
{
    Undefined   = 0x00000000,
    Float       = 0x00000002,
    Int         = 0x00000003,
    String      = 0x00000004,
    FloatArray  = 0x00000007,
    IntArray    = 0x00000008,
    StringArray = 0x00000009,
}
//ENUM ATTR: ScopedEnumAttribute : CustomAttributeSig([], [])

enum MLOperatorTensorDataType : uint
{
    Undefined  = 0x00000000,
    Float      = 0x00000001,
    UInt8      = 0x00000002,
    Int8       = 0x00000003,
    UInt16     = 0x00000004,
    Int16      = 0x00000005,
    Int32      = 0x00000006,
    Int64      = 0x00000007,
    String     = 0x00000008,
    Bool       = 0x00000009,
    Float16    = 0x0000000a,
    Double     = 0x0000000b,
    UInt32     = 0x0000000c,
    UInt64     = 0x0000000d,
    Complex64  = 0x0000000e,
    Complex128 = 0x0000000f,
}
//ENUM ATTR: ScopedEnumAttribute : CustomAttributeSig([], [])

enum MLOperatorEdgeType : uint
{
    Undefined      = 0x00000000,
    Tensor         = 0x00000001,
    SequenceTensor = 0x00000002,
    Primitive      = 0x00000003,
}
//ENUM ATTR: ScopedEnumAttribute : CustomAttributeSig([], [])

enum MLOperatorParameterOptions : uint
{
    Single   = 0x00000000,
    Optional = 0x00000001,
    Variadic = 0x00000002,
}
//ENUM ATTR: ScopedEnumAttribute : CustomAttributeSig([], [])

enum MLOperatorSchemaEdgeTypeFormat : int
{
    EdgeDescription = 0x00000000,
    Label           = 0x00000001,
}
//ENUM ATTR: ScopedEnumAttribute : CustomAttributeSig([], [])

enum MLOperatorKernelOptions : uint
{
    None                    = 0x00000000,
    AllowDynamicInputShapes = 0x00000001,
}
//ENUM ATTR: ScopedEnumAttribute : CustomAttributeSig([], [])

enum MLOperatorExecutionType : uint
{
    Undefined = 0x00000000,
    Cpu       = 0x00000001,
    D3D12     = 0x00000002,
}

// Constants


enum uint WINML_TENSOR_DIMENSION_COUNT_MAX = 0x00000004;

// Structs


//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winml/ns-winml-winml_tensor_binding_desc))], [])
struct WINML_TENSOR_BINDING_DESC
{
    WINML_TENSOR_DATA_TYPE DataType;
    uint  NumDimensions;
    long* pShape;
    uint  DataSize;
    void* pData;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winml/ns-winml-winml_sequence_binding_desc))], [])
struct WINML_SEQUENCE_BINDING_DESC
{
    uint ElementCount;
    WINML_TENSOR_DATA_TYPE ElementType;
union
    {
        PWSTR*  pStrings;
        long*   pInts;
        float*  pFloats;
        double* pDoubles;
    }
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winml/ns-winml-winml_map_binding_desc))], [])
struct WINML_MAP_BINDING_DESC
{
    uint ElementCount;
    WINML_TENSOR_DATA_TYPE KeyType;
union
    {
        PWSTR* pStringKeys;
        long*  pIntKeys;
    }
    WINML_TENSOR_DATA_TYPE Fields;
union
    {
        PWSTR*  pStringFields;
        long*   pIntFields;
        float*  pFloatFields;
        double* pDoubleFields;
    }
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winml/ns-winml-winml_image_binding_desc))], [])
struct WINML_IMAGE_BINDING_DESC
{
    WINML_TENSOR_DATA_TYPE ElementType;
    uint  NumDimensions;
    long* pShape;
    uint  DataSize;
    void* pData;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winml/ns-winml-winml_resource_binding_desc))], [])
struct WINML_RESOURCE_BINDING_DESC
{
    WINML_TENSOR_DATA_TYPE ElementType;
    uint           NumDimensions;
    long*          pShape;
    ID3D12Resource pResource;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winml/ns-winml-winml_binding_desc))], [])
struct WINML_BINDING_DESC
{
    const(PWSTR)       Name;
    WINML_BINDING_TYPE BindType;
union
    {
        WINML_TENSOR_BINDING_DESC Tensor;
        WINML_SEQUENCE_BINDING_DESC Sequence;
        WINML_MAP_BINDING_DESC Map;
        WINML_IMAGE_BINDING_DESC Image;
        WINML_RESOURCE_BINDING_DESC Resource;
    }
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winml/ns-winml-winml_tensor_variable_desc))], [])
struct WINML_TENSOR_VARIABLE_DESC
{
    WINML_TENSOR_DATA_TYPE ElementType;
    uint  NumDimensions;
    long* pShape;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winml/ns-winml-winml_sequence_variable_desc))], [])
struct WINML_SEQUENCE_VARIABLE_DESC
{
    WINML_TENSOR_DATA_TYPE ElementType;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winml/ns-winml-winml_map_variable_desc))], [])
struct WINML_MAP_VARIABLE_DESC
{
    WINML_TENSOR_DATA_TYPE KeyType;
    WINML_TENSOR_DATA_TYPE Fields;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winml/ns-winml-winml_image_variable_desc))], [])
struct WINML_IMAGE_VARIABLE_DESC
{
    WINML_TENSOR_DATA_TYPE ElementType;
    uint  NumDimensions;
    long* pShape;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winml/ns-winml-winml_variable_desc))], [])
struct WINML_VARIABLE_DESC
{
    PWSTR              Name;
    PWSTR              Description;
    WINML_FEATURE_TYPE FeatureType;
    BOOL               Required;
union
    {
        WINML_TENSOR_VARIABLE_DESC Tensor;
        WINML_SEQUENCE_VARIABLE_DESC Sequence;
        WINML_MAP_VARIABLE_DESC Map;
        WINML_IMAGE_VARIABLE_DESC Image;
    }
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winml/ns-winml-winml_model_desc))], [])
struct WINML_MODEL_DESC
{
    PWSTR  Author;
    PWSTR  Name;
    PWSTR  Domain;
    PWSTR  Description;
    size_t Version;
}

struct MLOperatorEdgeDescription
{
    MLOperatorEdgeType edgeType;
union
    {
        ulong reserved;
        MLOperatorTensorDataType tensorDataType;
    }
}

struct MLOperatorSchemaEdgeDescription
{
    MLOperatorParameterOptions options;
    MLOperatorSchemaEdgeTypeFormat typeFormat;
union
    {
        const(void)* reserved;
        const(PSTR)  typeLabel;
        MLOperatorEdgeDescription edgeDescription;
    }
}

struct MLOperatorEdgeTypeConstraint
{
    const(PSTR) typeLabel;
    const(MLOperatorEdgeDescription)* allowedTypes;
    uint        allowedTypeCount;
}

struct MLOperatorAttribute
{
    const(PSTR) name;
    MLOperatorAttributeType type;
    ubyte       required;
}

struct MLOperatorAttributeNameValue
{
    const(PSTR) name;
    MLOperatorAttributeType type;
    uint        valueCount;
union
    {
        const(void)*  reserved;
        const(long)*  ints;
        const(byte)** strings;
        const(float)* floats;
    }
}

struct MLOperatorSchemaDescription
{
    const(PSTR) name;
    int         operatorSetVersionAtLastChange;
    const(MLOperatorSchemaEdgeDescription)* inputs;
    uint        inputCount;
    const(MLOperatorSchemaEdgeDescription)* outputs;
    uint        outputCount;
    const(MLOperatorEdgeTypeConstraint)* typeConstraints;
    uint        typeConstraintCount;
    const(MLOperatorAttribute)* attributes;
    uint        attributeCount;
    const(MLOperatorAttributeNameValue)* defaultAttributes;
    uint        defaultAttributeCount;
}

struct MLOperatorSetId
{
    const(PSTR) domain;
    int         version_;
}

struct MLOperatorKernelDescription
{
    const(PSTR) domain;
    const(PSTR) name;
    int         minimumOperatorSetVersion;
    MLOperatorExecutionType executionType;
    const(MLOperatorEdgeTypeConstraint)* typeConstraints;
    uint        typeConstraintCount;
    const(MLOperatorAttributeNameValue)* defaultAttributes;
    uint        defaultAttributeCount;
    MLOperatorKernelOptions options;
    uint        executionOptions;
}

// Functions

@DllImport("winml.dll")
HRESULT WinMLCreateRuntime(IWinMLRuntime* runtime);

@DllImport("windows.ai.machinelearning.dll")
HRESULT MLCreateOperatorRegistry(IMLOperatorRegistry* registry);


// Interfaces

// === List GuidAttribute
//        GuidAttribute: type uint value CustomAttributeSig([FixedArgSig(ElementSig(3807295145)), FixedArgSig(ElementSig(62239)), FixedArgSig(ElementSig(16469)), FixedArgSig(ElementSig(165)), FixedArgSig(ElementSig(33)), FixedArgSig(ElementSig(227)), FixedArgSig(ElementSig(11)), FixedArgSig(ElementSig(91)), FixedArgSig(ElementSig(51)), FixedArgSig(ElementSig(102)), FixedArgSig(ElementSig(74))], [])
//        SupportedOSPlatformAttribute: type immutable(char)[] value CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17134))], [])
//        DocumentationAttribute: type immutable(char)[] value CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winml/nn-winml-iwinmlmodel))], [])
// === End List GuidAttribute
// Attribute GuidAttribute: type uint, value CustomAttributeSig([FixedArgSig(ElementSig(3807295145)), FixedArgSig(ElementSig(62239)), FixedArgSig(ElementSig(16469)), FixedArgSig(ElementSig(165)), FixedArgSig(ElementSig(33)), FixedArgSig(ElementSig(227)), FixedArgSig(ElementSig(11)), FixedArgSig(ElementSig(91)), FixedArgSig(ElementSig(51)), FixedArgSig(ElementSig(102)), FixedArgSig(ElementSig(74))], [])
// Found GuidAttribute ATTR: GuidAttribute : CustomAttributeSig([FixedArgSig(ElementSig(3807295145)), FixedArgSig(ElementSig(62239)), FixedArgSig(ElementSig(16469)), FixedArgSig(ElementSig(165)), FixedArgSig(ElementSig(33)), FixedArgSig(ElementSig(227)), FixedArgSig(ElementSig(11)), FixedArgSig(ElementSig(91)), FixedArgSig(ElementSig(51)), FixedArgSig(ElementSig(102)), FixedArgSig(ElementSig(74))], [])
//INTERFACEF ATTR: GuidAttribute : CustomAttributeSig([FixedArgSig(ElementSig(3807295145)), FixedArgSig(ElementSig(62239)), FixedArgSig(ElementSig(16469)), FixedArgSig(ElementSig(165)), FixedArgSig(ElementSig(33)), FixedArgSig(ElementSig(227)), FixedArgSig(ElementSig(11)), FixedArgSig(ElementSig(91)), FixedArgSig(ElementSig(51)), FixedArgSig(ElementSig(102)), FixedArgSig(ElementSig(74))], [])
// Attribute SupportedOSPlatformAttribute: type immutable(char)[], value CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17134))], [])
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17134))], [])
// Attribute DocumentationAttribute: type immutable(char)[], value CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winml/nn-winml-iwinmlmodel))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winml/nn-winml-iwinmlmodel))], [])
interface IWinMLModel : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winml/nf-winml-iwinmlmodel-getdescription))], [])
    HRESULT GetDescription(WINML_MODEL_DESC** ppDescription);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winml/nf-winml-iwinmlmodel-enumeratemetadata))], [])
    HRESULT EnumerateMetadata(uint Index, const(PWSTR)* pKey, const(PWSTR)* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winml/nf-winml-iwinmlmodel-enumeratemodelinputs))], [])
    HRESULT EnumerateModelInputs(uint Index, WINML_VARIABLE_DESC** ppInputDescriptor);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winml/nf-winml-iwinmlmodel-enumeratemodeloutputs))], [])
    HRESULT EnumerateModelOutputs(uint Index, WINML_VARIABLE_DESC** ppOutputDescriptor);
}

// === List GuidAttribute
//        GuidAttribute: type uint value CustomAttributeSig([FixedArgSig(ElementSig(2508492702)), FixedArgSig(ElementSig(22589)), FixedArgSig(ElementSig(16468)), FixedArgSig(ElementSig(175)), FixedArgSig(ElementSig(18)), FixedArgSig(ElementSig(145)), FixedArgSig(ElementSig(99)), FixedArgSig(ElementSig(135)), FixedArgSig(ElementSig(205)), FixedArgSig(ElementSig(132)), FixedArgSig(ElementSig(38))], [])
//        SupportedOSPlatformAttribute: type immutable(char)[] value CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17134))], [])
//        DocumentationAttribute: type immutable(char)[] value CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winml/nn-winml-iwinmlevaluationcontext))], [])
// === End List GuidAttribute
// Attribute GuidAttribute: type uint, value CustomAttributeSig([FixedArgSig(ElementSig(2508492702)), FixedArgSig(ElementSig(22589)), FixedArgSig(ElementSig(16468)), FixedArgSig(ElementSig(175)), FixedArgSig(ElementSig(18)), FixedArgSig(ElementSig(145)), FixedArgSig(ElementSig(99)), FixedArgSig(ElementSig(135)), FixedArgSig(ElementSig(205)), FixedArgSig(ElementSig(132)), FixedArgSig(ElementSig(38))], [])
// Found GuidAttribute ATTR: GuidAttribute : CustomAttributeSig([FixedArgSig(ElementSig(2508492702)), FixedArgSig(ElementSig(22589)), FixedArgSig(ElementSig(16468)), FixedArgSig(ElementSig(175)), FixedArgSig(ElementSig(18)), FixedArgSig(ElementSig(145)), FixedArgSig(ElementSig(99)), FixedArgSig(ElementSig(135)), FixedArgSig(ElementSig(205)), FixedArgSig(ElementSig(132)), FixedArgSig(ElementSig(38))], [])
//INTERFACEF ATTR: GuidAttribute : CustomAttributeSig([FixedArgSig(ElementSig(2508492702)), FixedArgSig(ElementSig(22589)), FixedArgSig(ElementSig(16468)), FixedArgSig(ElementSig(175)), FixedArgSig(ElementSig(18)), FixedArgSig(ElementSig(145)), FixedArgSig(ElementSig(99)), FixedArgSig(ElementSig(135)), FixedArgSig(ElementSig(205)), FixedArgSig(ElementSig(132)), FixedArgSig(ElementSig(38))], [])
// Attribute SupportedOSPlatformAttribute: type immutable(char)[], value CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17134))], [])
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17134))], [])
// Attribute DocumentationAttribute: type immutable(char)[], value CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winml/nn-winml-iwinmlevaluationcontext))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winml/nn-winml-iwinmlevaluationcontext))], [])
interface IWinMLEvaluationContext : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winml/nf-winml-iwinmlevaluationcontext-bindvalue))], [])
    HRESULT BindValue(WINML_BINDING_DESC* pDescriptor);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winml/nf-winml-iwinmlevaluationcontext-getvaluebyname))], [])
    HRESULT GetValueByName(const(PWSTR) Name, WINML_BINDING_DESC** pDescriptor);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winml/nf-winml-iwinmlevaluationcontext-clear))], [])
    HRESULT Clear();
}

// === List GuidAttribute
//        GuidAttribute: type uint value CustomAttributeSig([FixedArgSig(ElementSig(2688701225)), FixedArgSig(ElementSig(16558)), FixedArgSig(ElementSig(18649)), FixedArgSig(ElementSig(188)), FixedArgSig(ElementSig(227)), FixedArgSig(ElementSig(130)), FixedArgSig(ElementSig(158)), FixedArgSig(ElementSig(247)), FixedArgSig(ElementSig(184)), FixedArgSig(ElementSig(164)), FixedArgSig(ElementSig(26))], [])
//        SupportedOSPlatformAttribute: type immutable(char)[] value CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17134))], [])
//        DocumentationAttribute: type immutable(char)[] value CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winml/nn-winml-iwinmlruntime))], [])
// === End List GuidAttribute
// Attribute GuidAttribute: type uint, value CustomAttributeSig([FixedArgSig(ElementSig(2688701225)), FixedArgSig(ElementSig(16558)), FixedArgSig(ElementSig(18649)), FixedArgSig(ElementSig(188)), FixedArgSig(ElementSig(227)), FixedArgSig(ElementSig(130)), FixedArgSig(ElementSig(158)), FixedArgSig(ElementSig(247)), FixedArgSig(ElementSig(184)), FixedArgSig(ElementSig(164)), FixedArgSig(ElementSig(26))], [])
// Found GuidAttribute ATTR: GuidAttribute : CustomAttributeSig([FixedArgSig(ElementSig(2688701225)), FixedArgSig(ElementSig(16558)), FixedArgSig(ElementSig(18649)), FixedArgSig(ElementSig(188)), FixedArgSig(ElementSig(227)), FixedArgSig(ElementSig(130)), FixedArgSig(ElementSig(158)), FixedArgSig(ElementSig(247)), FixedArgSig(ElementSig(184)), FixedArgSig(ElementSig(164)), FixedArgSig(ElementSig(26))], [])
//INTERFACEF ATTR: GuidAttribute : CustomAttributeSig([FixedArgSig(ElementSig(2688701225)), FixedArgSig(ElementSig(16558)), FixedArgSig(ElementSig(18649)), FixedArgSig(ElementSig(188)), FixedArgSig(ElementSig(227)), FixedArgSig(ElementSig(130)), FixedArgSig(ElementSig(158)), FixedArgSig(ElementSig(247)), FixedArgSig(ElementSig(184)), FixedArgSig(ElementSig(164)), FixedArgSig(ElementSig(26))], [])
// Attribute SupportedOSPlatformAttribute: type immutable(char)[], value CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17134))], [])
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17134))], [])
// Attribute DocumentationAttribute: type immutable(char)[], value CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winml/nn-winml-iwinmlruntime))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winml/nn-winml-iwinmlruntime))], [])
interface IWinMLRuntime : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winml/nf-winml-iwinmlruntime-loadmodel))], [])
    HRESULT LoadModel(const(PWSTR) Path, IWinMLModel* ppModel);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winml/nf-winml-iwinmlruntime-createevaluationcontext))], [])
    HRESULT CreateEvaluationContext(ID3D12Device device, IWinMLEvaluationContext* ppContext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winml/nf-winml-iwinmlruntime-evaluatemodel))], [])
    HRESULT EvaluateModel(IWinMLEvaluationContext pContext);
}

// === List GuidAttribute
//        GuidAttribute: type uint value CustomAttributeSig([FixedArgSig(ElementSig(2819078221)), FixedArgSig(ElementSig(19173)), FixedArgSig(ElementSig(19392)), FixedArgSig(ElementSig(167)), FixedArgSig(ElementSig(106)), FixedArgSig(ElementSig(148)), FixedArgSig(ElementSig(26)), FixedArgSig(ElementSig(162)), FixedArgSig(ElementSig(70)), FixedArgSig(ElementSig(189)), FixedArgSig(ElementSig(65))], [])
//        SupportedOSPlatformAttribute: type immutable(char)[] value CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17134))], [])
//        DocumentationAttribute: type immutable(char)[] value CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winml/nn-winml-iwinmlruntimefactory))], [])
// === End List GuidAttribute
// Attribute GuidAttribute: type uint, value CustomAttributeSig([FixedArgSig(ElementSig(2819078221)), FixedArgSig(ElementSig(19173)), FixedArgSig(ElementSig(19392)), FixedArgSig(ElementSig(167)), FixedArgSig(ElementSig(106)), FixedArgSig(ElementSig(148)), FixedArgSig(ElementSig(26)), FixedArgSig(ElementSig(162)), FixedArgSig(ElementSig(70)), FixedArgSig(ElementSig(189)), FixedArgSig(ElementSig(65))], [])
// Found GuidAttribute ATTR: GuidAttribute : CustomAttributeSig([FixedArgSig(ElementSig(2819078221)), FixedArgSig(ElementSig(19173)), FixedArgSig(ElementSig(19392)), FixedArgSig(ElementSig(167)), FixedArgSig(ElementSig(106)), FixedArgSig(ElementSig(148)), FixedArgSig(ElementSig(26)), FixedArgSig(ElementSig(162)), FixedArgSig(ElementSig(70)), FixedArgSig(ElementSig(189)), FixedArgSig(ElementSig(65))], [])
//INTERFACEF ATTR: GuidAttribute : CustomAttributeSig([FixedArgSig(ElementSig(2819078221)), FixedArgSig(ElementSig(19173)), FixedArgSig(ElementSig(19392)), FixedArgSig(ElementSig(167)), FixedArgSig(ElementSig(106)), FixedArgSig(ElementSig(148)), FixedArgSig(ElementSig(26)), FixedArgSig(ElementSig(162)), FixedArgSig(ElementSig(70)), FixedArgSig(ElementSig(189)), FixedArgSig(ElementSig(65))], [])
// Attribute SupportedOSPlatformAttribute: type immutable(char)[], value CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17134))], [])
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17134))], [])
// Attribute DocumentationAttribute: type immutable(char)[], value CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winml/nn-winml-iwinmlruntimefactory))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winml/nn-winml-iwinmlruntimefactory))], [])
interface IWinMLRuntimeFactory : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winml/nf-winml-iwinmlruntimefactory-createruntime))], [])
    HRESULT CreateRuntime(WINML_RUNTIME_TYPE RuntimeType, IWinMLRuntime* ppRuntime);
}

// === List GuidAttribute
//        GuidAttribute: type uint value CustomAttributeSig([FixedArgSig(ElementSig(1260066649)), FixedArgSig(ElementSig(60480)), FixedArgSig(ElementSig(18028)), FixedArgSig(ElementSig(170)), FixedArgSig(ElementSig(180)), FixedArgSig(ElementSig(190)), FixedArgSig(ElementSig(181)), FixedArgSig(ElementSig(52)), FixedArgSig(ElementSig(127)), FixedArgSig(ElementSig(210)), FixedArgSig(ElementSig(76))], [])
// === End List GuidAttribute
// Attribute GuidAttribute: type uint, value CustomAttributeSig([FixedArgSig(ElementSig(1260066649)), FixedArgSig(ElementSig(60480)), FixedArgSig(ElementSig(18028)), FixedArgSig(ElementSig(170)), FixedArgSig(ElementSig(180)), FixedArgSig(ElementSig(190)), FixedArgSig(ElementSig(181)), FixedArgSig(ElementSig(52)), FixedArgSig(ElementSig(127)), FixedArgSig(ElementSig(210)), FixedArgSig(ElementSig(76))], [])
// Found GuidAttribute ATTR: GuidAttribute : CustomAttributeSig([FixedArgSig(ElementSig(1260066649)), FixedArgSig(ElementSig(60480)), FixedArgSig(ElementSig(18028)), FixedArgSig(ElementSig(170)), FixedArgSig(ElementSig(180)), FixedArgSig(ElementSig(190)), FixedArgSig(ElementSig(181)), FixedArgSig(ElementSig(52)), FixedArgSig(ElementSig(127)), FixedArgSig(ElementSig(210)), FixedArgSig(ElementSig(76))], [])
//INTERFACEF ATTR: GuidAttribute : CustomAttributeSig([FixedArgSig(ElementSig(1260066649)), FixedArgSig(ElementSig(60480)), FixedArgSig(ElementSig(18028)), FixedArgSig(ElementSig(170)), FixedArgSig(ElementSig(180)), FixedArgSig(ElementSig(190)), FixedArgSig(ElementSig(181)), FixedArgSig(ElementSig(52)), FixedArgSig(ElementSig(127)), FixedArgSig(ElementSig(210)), FixedArgSig(ElementSig(76))], [])
interface IMLOperatorAttributes : IUnknown
{
    HRESULT GetAttributeElementCount(const(PSTR) name, MLOperatorAttributeType type, uint* elementCount);
    HRESULT GetAttribute(const(PSTR) name, MLOperatorAttributeType type, uint elementCount, size_t elementByteSize, 
                         void* value);
    HRESULT GetStringAttributeElementLength(const(PSTR) name, uint elementIndex, uint* attributeElementByteSize);
    HRESULT GetStringAttributeElement(const(PSTR) name, uint elementIndex, uint attributeElementByteSize, 
                                      PSTR attributeElement);
}

// === List GuidAttribute
//        GuidAttribute: type uint value CustomAttributeSig([FixedArgSig(ElementSig(4061039806)), FixedArgSig(ElementSig(15144)), FixedArgSig(ElementSig(16968)), FixedArgSig(ElementSig(190)), FixedArgSig(ElementSig(149)), FixedArgSig(ElementSig(249)), FixedArgSig(ElementSig(111)), FixedArgSig(ElementSig(188)), FixedArgSig(ElementSig(110)), FixedArgSig(ElementSig(70)), FixedArgSig(ElementSig(67))], [])
// === End List GuidAttribute
// Attribute GuidAttribute: type uint, value CustomAttributeSig([FixedArgSig(ElementSig(4061039806)), FixedArgSig(ElementSig(15144)), FixedArgSig(ElementSig(16968)), FixedArgSig(ElementSig(190)), FixedArgSig(ElementSig(149)), FixedArgSig(ElementSig(249)), FixedArgSig(ElementSig(111)), FixedArgSig(ElementSig(188)), FixedArgSig(ElementSig(110)), FixedArgSig(ElementSig(70)), FixedArgSig(ElementSig(67))], [])
// Found GuidAttribute ATTR: GuidAttribute : CustomAttributeSig([FixedArgSig(ElementSig(4061039806)), FixedArgSig(ElementSig(15144)), FixedArgSig(ElementSig(16968)), FixedArgSig(ElementSig(190)), FixedArgSig(ElementSig(149)), FixedArgSig(ElementSig(249)), FixedArgSig(ElementSig(111)), FixedArgSig(ElementSig(188)), FixedArgSig(ElementSig(110)), FixedArgSig(ElementSig(70)), FixedArgSig(ElementSig(67))], [])
//INTERFACEF ATTR: GuidAttribute : CustomAttributeSig([FixedArgSig(ElementSig(4061039806)), FixedArgSig(ElementSig(15144)), FixedArgSig(ElementSig(16968)), FixedArgSig(ElementSig(190)), FixedArgSig(ElementSig(149)), FixedArgSig(ElementSig(249)), FixedArgSig(ElementSig(111)), FixedArgSig(ElementSig(188)), FixedArgSig(ElementSig(110)), FixedArgSig(ElementSig(70)), FixedArgSig(ElementSig(67))], [])
interface IMLOperatorTensorShapeDescription : IUnknown
{
    HRESULT GetInputTensorDimensionCount(uint inputIndex, uint* dimensionCount);
    HRESULT GetInputTensorShape(uint inputIndex, uint dimensionCount, uint* dimensions);
    bool    HasOutputShapeDescription();
    HRESULT GetOutputTensorDimensionCount(uint outputIndex, uint* dimensionCount);
    HRESULT GetOutputTensorShape(uint outputIndex, uint dimensionCount, uint* dimensions);
}

// === List GuidAttribute
//        GuidAttribute: type uint value CustomAttributeSig([FixedArgSig(ElementSig(1415165245)), FixedArgSig(ElementSig(41212)), FixedArgSig(ElementSig(18021)), FixedArgSig(ElementSig(173)), FixedArgSig(ElementSig(221)), FixedArgSig(ElementSig(112)), FixedArgSig(ElementSig(23)), FixedArgSig(ElementSig(30)), FixedArgSig(ElementSig(247)), FixedArgSig(ElementSig(230)), FixedArgSig(ElementSig(49))], [])
// === End List GuidAttribute
// Attribute GuidAttribute: type uint, value CustomAttributeSig([FixedArgSig(ElementSig(1415165245)), FixedArgSig(ElementSig(41212)), FixedArgSig(ElementSig(18021)), FixedArgSig(ElementSig(173)), FixedArgSig(ElementSig(221)), FixedArgSig(ElementSig(112)), FixedArgSig(ElementSig(23)), FixedArgSig(ElementSig(30)), FixedArgSig(ElementSig(247)), FixedArgSig(ElementSig(230)), FixedArgSig(ElementSig(49))], [])
// Found GuidAttribute ATTR: GuidAttribute : CustomAttributeSig([FixedArgSig(ElementSig(1415165245)), FixedArgSig(ElementSig(41212)), FixedArgSig(ElementSig(18021)), FixedArgSig(ElementSig(173)), FixedArgSig(ElementSig(221)), FixedArgSig(ElementSig(112)), FixedArgSig(ElementSig(23)), FixedArgSig(ElementSig(30)), FixedArgSig(ElementSig(247)), FixedArgSig(ElementSig(230)), FixedArgSig(ElementSig(49))], [])
//INTERFACEF ATTR: GuidAttribute : CustomAttributeSig([FixedArgSig(ElementSig(1415165245)), FixedArgSig(ElementSig(41212)), FixedArgSig(ElementSig(18021)), FixedArgSig(ElementSig(173)), FixedArgSig(ElementSig(221)), FixedArgSig(ElementSig(112)), FixedArgSig(ElementSig(23)), FixedArgSig(ElementSig(30)), FixedArgSig(ElementSig(247)), FixedArgSig(ElementSig(230)), FixedArgSig(ElementSig(49))], [])
interface IMLOperatorKernelCreationContext : IMLOperatorAttributes
{
    uint    GetInputCount();
    uint    GetOutputCount();
    bool    IsInputValid(uint inputIndex);
    bool    IsOutputValid(uint outputIndex);
    HRESULT GetInputEdgeDescription(uint inputIndex, MLOperatorEdgeDescription* edgeDescription);
    HRESULT GetOutputEdgeDescription(uint outputIndex, MLOperatorEdgeDescription* edgeDescription);
    bool    HasTensorShapeDescription();
    HRESULT GetTensorShapeDescription(IMLOperatorTensorShapeDescription* shapeDescription);
    void    GetExecutionInterface(IUnknown* executionObject);
}

// === List GuidAttribute
//        GuidAttribute: type uint value CustomAttributeSig([FixedArgSig(ElementSig(2145656641)), FixedArgSig(ElementSig(62512)), FixedArgSig(ElementSig(17422)), FixedArgSig(ElementSig(174)), FixedArgSig(ElementSig(206)), FixedArgSig(ElementSig(84)), FixedArgSig(ElementSig(65)), FixedArgSig(ElementSig(109)), FixedArgSig(ElementSig(200)), FixedArgSig(ElementSig(185)), FixedArgSig(ElementSig(219))], [])
// === End List GuidAttribute
// Attribute GuidAttribute: type uint, value CustomAttributeSig([FixedArgSig(ElementSig(2145656641)), FixedArgSig(ElementSig(62512)), FixedArgSig(ElementSig(17422)), FixedArgSig(ElementSig(174)), FixedArgSig(ElementSig(206)), FixedArgSig(ElementSig(84)), FixedArgSig(ElementSig(65)), FixedArgSig(ElementSig(109)), FixedArgSig(ElementSig(200)), FixedArgSig(ElementSig(185)), FixedArgSig(ElementSig(219))], [])
// Found GuidAttribute ATTR: GuidAttribute : CustomAttributeSig([FixedArgSig(ElementSig(2145656641)), FixedArgSig(ElementSig(62512)), FixedArgSig(ElementSig(17422)), FixedArgSig(ElementSig(174)), FixedArgSig(ElementSig(206)), FixedArgSig(ElementSig(84)), FixedArgSig(ElementSig(65)), FixedArgSig(ElementSig(109)), FixedArgSig(ElementSig(200)), FixedArgSig(ElementSig(185)), FixedArgSig(ElementSig(219))], [])
//INTERFACEF ATTR: GuidAttribute : CustomAttributeSig([FixedArgSig(ElementSig(2145656641)), FixedArgSig(ElementSig(62512)), FixedArgSig(ElementSig(17422)), FixedArgSig(ElementSig(174)), FixedArgSig(ElementSig(206)), FixedArgSig(ElementSig(84)), FixedArgSig(ElementSig(65)), FixedArgSig(ElementSig(109)), FixedArgSig(ElementSig(200)), FixedArgSig(ElementSig(185)), FixedArgSig(ElementSig(219))], [])
interface IMLOperatorTensor : IUnknown
{
    uint    GetDimensionCount();
    HRESULT GetShape(uint dimensionCount, uint* dimensions);
    MLOperatorTensorDataType GetTensorDataType();
    bool    IsCpuData();
    bool    IsDataInterface();
    void*   GetData();
    void    GetDataInterface(IUnknown* dataInterface);
}

// === List GuidAttribute
//        GuidAttribute: type uint value CustomAttributeSig([FixedArgSig(ElementSig(2186504744)), FixedArgSig(ElementSig(61474)), FixedArgSig(ElementSig(18281)), FixedArgSig(ElementSig(157)), FixedArgSig(ElementSig(63)), FixedArgSig(ElementSig(139)), FixedArgSig(ElementSig(39)), FixedArgSig(ElementSig(143)), FixedArgSig(ElementSig(132)), FixedArgSig(ElementSig(192)), FixedArgSig(ElementSig(195))], [])
// === End List GuidAttribute
// Attribute GuidAttribute: type uint, value CustomAttributeSig([FixedArgSig(ElementSig(2186504744)), FixedArgSig(ElementSig(61474)), FixedArgSig(ElementSig(18281)), FixedArgSig(ElementSig(157)), FixedArgSig(ElementSig(63)), FixedArgSig(ElementSig(139)), FixedArgSig(ElementSig(39)), FixedArgSig(ElementSig(143)), FixedArgSig(ElementSig(132)), FixedArgSig(ElementSig(192)), FixedArgSig(ElementSig(195))], [])
// Found GuidAttribute ATTR: GuidAttribute : CustomAttributeSig([FixedArgSig(ElementSig(2186504744)), FixedArgSig(ElementSig(61474)), FixedArgSig(ElementSig(18281)), FixedArgSig(ElementSig(157)), FixedArgSig(ElementSig(63)), FixedArgSig(ElementSig(139)), FixedArgSig(ElementSig(39)), FixedArgSig(ElementSig(143)), FixedArgSig(ElementSig(132)), FixedArgSig(ElementSig(192)), FixedArgSig(ElementSig(195))], [])
//INTERFACEF ATTR: GuidAttribute : CustomAttributeSig([FixedArgSig(ElementSig(2186504744)), FixedArgSig(ElementSig(61474)), FixedArgSig(ElementSig(18281)), FixedArgSig(ElementSig(157)), FixedArgSig(ElementSig(63)), FixedArgSig(ElementSig(139)), FixedArgSig(ElementSig(39)), FixedArgSig(ElementSig(143)), FixedArgSig(ElementSig(132)), FixedArgSig(ElementSig(192)), FixedArgSig(ElementSig(195))], [])
interface IMLOperatorKernelContext : IUnknown
{
    HRESULT GetInputTensor(uint inputIndex, IMLOperatorTensor* tensor);
    HRESULT GetOutputTensor(uint outputIndex, uint dimensionCount, const(uint)* dimensionSizes, 
                            IMLOperatorTensor* tensor);
    HRESULT GetOutputTensor(uint outputIndex, IMLOperatorTensor* tensor);
    HRESULT AllocateTemporaryData(size_t size, IUnknown* data);
    void    GetExecutionInterface(IUnknown* executionObject);
}

// === List GuidAttribute
//        GuidAttribute: type uint value CustomAttributeSig([FixedArgSig(ElementSig(298103968)), FixedArgSig(ElementSig(46183)), FixedArgSig(ElementSig(20138)), FixedArgSig(ElementSig(161)), FixedArgSig(ElementSig(166)), FixedArgSig(ElementSig(185)), FixedArgSig(ElementSig(97)), FixedArgSig(ElementSig(216)), FixedArgSig(ElementSig(208)), FixedArgSig(ElementSig(237)), FixedArgSig(ElementSig(121))], [])
// === End List GuidAttribute
// Attribute GuidAttribute: type uint, value CustomAttributeSig([FixedArgSig(ElementSig(298103968)), FixedArgSig(ElementSig(46183)), FixedArgSig(ElementSig(20138)), FixedArgSig(ElementSig(161)), FixedArgSig(ElementSig(166)), FixedArgSig(ElementSig(185)), FixedArgSig(ElementSig(97)), FixedArgSig(ElementSig(216)), FixedArgSig(ElementSig(208)), FixedArgSig(ElementSig(237)), FixedArgSig(ElementSig(121))], [])
// Found GuidAttribute ATTR: GuidAttribute : CustomAttributeSig([FixedArgSig(ElementSig(298103968)), FixedArgSig(ElementSig(46183)), FixedArgSig(ElementSig(20138)), FixedArgSig(ElementSig(161)), FixedArgSig(ElementSig(166)), FixedArgSig(ElementSig(185)), FixedArgSig(ElementSig(97)), FixedArgSig(ElementSig(216)), FixedArgSig(ElementSig(208)), FixedArgSig(ElementSig(237)), FixedArgSig(ElementSig(121))], [])
//INTERFACEF ATTR: GuidAttribute : CustomAttributeSig([FixedArgSig(ElementSig(298103968)), FixedArgSig(ElementSig(46183)), FixedArgSig(ElementSig(20138)), FixedArgSig(ElementSig(161)), FixedArgSig(ElementSig(166)), FixedArgSig(ElementSig(185)), FixedArgSig(ElementSig(97)), FixedArgSig(ElementSig(216)), FixedArgSig(ElementSig(208)), FixedArgSig(ElementSig(237)), FixedArgSig(ElementSig(121))], [])
interface IMLOperatorKernel : IUnknown
{
    HRESULT Compute(IMLOperatorKernelContext context);
}

// === List GuidAttribute
//        GuidAttribute: type uint value CustomAttributeSig([FixedArgSig(ElementSig(274426665)), FixedArgSig(ElementSig(21512)), FixedArgSig(ElementSig(19048)), FixedArgSig(ElementSig(153)), FixedArgSig(ElementSig(89)), FixedArgSig(ElementSig(9)), FixedArgSig(ElementSig(181)), FixedArgSig(ElementSig(149)), FixedArgSig(ElementSig(90)), FixedArgSig(ElementSig(52)), FixedArgSig(ElementSig(146))], [])
// === End List GuidAttribute
// Attribute GuidAttribute: type uint, value CustomAttributeSig([FixedArgSig(ElementSig(274426665)), FixedArgSig(ElementSig(21512)), FixedArgSig(ElementSig(19048)), FixedArgSig(ElementSig(153)), FixedArgSig(ElementSig(89)), FixedArgSig(ElementSig(9)), FixedArgSig(ElementSig(181)), FixedArgSig(ElementSig(149)), FixedArgSig(ElementSig(90)), FixedArgSig(ElementSig(52)), FixedArgSig(ElementSig(146))], [])
// Found GuidAttribute ATTR: GuidAttribute : CustomAttributeSig([FixedArgSig(ElementSig(274426665)), FixedArgSig(ElementSig(21512)), FixedArgSig(ElementSig(19048)), FixedArgSig(ElementSig(153)), FixedArgSig(ElementSig(89)), FixedArgSig(ElementSig(9)), FixedArgSig(ElementSig(181)), FixedArgSig(ElementSig(149)), FixedArgSig(ElementSig(90)), FixedArgSig(ElementSig(52)), FixedArgSig(ElementSig(146))], [])
//INTERFACEF ATTR: GuidAttribute : CustomAttributeSig([FixedArgSig(ElementSig(274426665)), FixedArgSig(ElementSig(21512)), FixedArgSig(ElementSig(19048)), FixedArgSig(ElementSig(153)), FixedArgSig(ElementSig(89)), FixedArgSig(ElementSig(9)), FixedArgSig(ElementSig(181)), FixedArgSig(ElementSig(149)), FixedArgSig(ElementSig(90)), FixedArgSig(ElementSig(52)), FixedArgSig(ElementSig(146))], [])
interface IMLOperatorShapeInferenceContext : IMLOperatorAttributes
{
    uint    GetInputCount();
    uint    GetOutputCount();
    bool    IsInputValid(uint inputIndex);
    bool    IsOutputValid(uint outputIndex);
    HRESULT GetInputEdgeDescription(uint inputIndex, MLOperatorEdgeDescription* edgeDescription);
    HRESULT GetInputTensorDimensionCount(uint inputIndex, uint* dimensionCount);
    HRESULT GetInputTensorShape(uint inputIndex, uint dimensionCount, uint* dimensions);
    HRESULT SetOutputTensorShape(uint outputIndex, uint dimensionCount, const(uint)* dimensions);
}

// === List GuidAttribute
//        GuidAttribute: type uint value CustomAttributeSig([FixedArgSig(ElementSig(3968416689)), FixedArgSig(ElementSig(63800)), FixedArgSig(ElementSig(17019)), FixedArgSig(ElementSig(132)), FixedArgSig(ElementSig(136)), FixedArgSig(ElementSig(200)), FixedArgSig(ElementSig(220)), FixedArgSig(ElementSig(247)), FixedArgSig(ElementSig(117)), FixedArgSig(ElementSig(241)), FixedArgSig(ElementSig(56))], [])
// === End List GuidAttribute
// Attribute GuidAttribute: type uint, value CustomAttributeSig([FixedArgSig(ElementSig(3968416689)), FixedArgSig(ElementSig(63800)), FixedArgSig(ElementSig(17019)), FixedArgSig(ElementSig(132)), FixedArgSig(ElementSig(136)), FixedArgSig(ElementSig(200)), FixedArgSig(ElementSig(220)), FixedArgSig(ElementSig(247)), FixedArgSig(ElementSig(117)), FixedArgSig(ElementSig(241)), FixedArgSig(ElementSig(56))], [])
// Found GuidAttribute ATTR: GuidAttribute : CustomAttributeSig([FixedArgSig(ElementSig(3968416689)), FixedArgSig(ElementSig(63800)), FixedArgSig(ElementSig(17019)), FixedArgSig(ElementSig(132)), FixedArgSig(ElementSig(136)), FixedArgSig(ElementSig(200)), FixedArgSig(ElementSig(220)), FixedArgSig(ElementSig(247)), FixedArgSig(ElementSig(117)), FixedArgSig(ElementSig(241)), FixedArgSig(ElementSig(56))], [])
//INTERFACEF ATTR: GuidAttribute : CustomAttributeSig([FixedArgSig(ElementSig(3968416689)), FixedArgSig(ElementSig(63800)), FixedArgSig(ElementSig(17019)), FixedArgSig(ElementSig(132)), FixedArgSig(ElementSig(136)), FixedArgSig(ElementSig(200)), FixedArgSig(ElementSig(220)), FixedArgSig(ElementSig(247)), FixedArgSig(ElementSig(117)), FixedArgSig(ElementSig(241)), FixedArgSig(ElementSig(56))], [])
interface IMLOperatorTypeInferenceContext : IMLOperatorAttributes
{
    uint    GetInputCount();
    uint    GetOutputCount();
    bool    IsInputValid(uint inputIndex);
    bool    IsOutputValid(uint outputIndex);
    HRESULT GetInputEdgeDescription(uint inputIndex, MLOperatorEdgeDescription* edgeDescription);
    HRESULT SetOutputEdgeDescription(uint outputIndex, const(MLOperatorEdgeDescription)* edgeDescription);
}

// === List GuidAttribute
//        GuidAttribute: type uint value CustomAttributeSig([FixedArgSig(ElementSig(2015030088)), FixedArgSig(ElementSig(39883)), FixedArgSig(ElementSig(18327)), FixedArgSig(ElementSig(191)), FixedArgSig(ElementSig(119)), FixedArgSig(ElementSig(139)), FixedArgSig(ElementSig(244)), FixedArgSig(ElementSig(85)), FixedArgSig(ElementSig(33)), FixedArgSig(ElementSig(123)), FixedArgSig(ElementSig(235))], [])
// === End List GuidAttribute
// Attribute GuidAttribute: type uint, value CustomAttributeSig([FixedArgSig(ElementSig(2015030088)), FixedArgSig(ElementSig(39883)), FixedArgSig(ElementSig(18327)), FixedArgSig(ElementSig(191)), FixedArgSig(ElementSig(119)), FixedArgSig(ElementSig(139)), FixedArgSig(ElementSig(244)), FixedArgSig(ElementSig(85)), FixedArgSig(ElementSig(33)), FixedArgSig(ElementSig(123)), FixedArgSig(ElementSig(235))], [])
// Found GuidAttribute ATTR: GuidAttribute : CustomAttributeSig([FixedArgSig(ElementSig(2015030088)), FixedArgSig(ElementSig(39883)), FixedArgSig(ElementSig(18327)), FixedArgSig(ElementSig(191)), FixedArgSig(ElementSig(119)), FixedArgSig(ElementSig(139)), FixedArgSig(ElementSig(244)), FixedArgSig(ElementSig(85)), FixedArgSig(ElementSig(33)), FixedArgSig(ElementSig(123)), FixedArgSig(ElementSig(235))], [])
//INTERFACEF ATTR: GuidAttribute : CustomAttributeSig([FixedArgSig(ElementSig(2015030088)), FixedArgSig(ElementSig(39883)), FixedArgSig(ElementSig(18327)), FixedArgSig(ElementSig(191)), FixedArgSig(ElementSig(119)), FixedArgSig(ElementSig(139)), FixedArgSig(ElementSig(244)), FixedArgSig(ElementSig(85)), FixedArgSig(ElementSig(33)), FixedArgSig(ElementSig(123)), FixedArgSig(ElementSig(235))], [])
interface IMLOperatorTypeInferrer : IUnknown
{
    HRESULT InferOutputTypes(IMLOperatorTypeInferenceContext context);
}

// === List GuidAttribute
//        GuidAttribute: type uint value CustomAttributeSig([FixedArgSig(ElementSig(1410065854)), FixedArgSig(ElementSig(42697)), FixedArgSig(ElementSig(16622)), FixedArgSig(ElementSig(131)), FixedArgSig(ElementSig(246)), FixedArgSig(ElementSig(210)), FixedArgSig(ElementSig(184)), FixedArgSig(ElementSig(180)), FixedArgSig(ElementSig(10)), FixedArgSig(ElementSig(119)), FixedArgSig(ElementSig(152))], [])
// === End List GuidAttribute
// Attribute GuidAttribute: type uint, value CustomAttributeSig([FixedArgSig(ElementSig(1410065854)), FixedArgSig(ElementSig(42697)), FixedArgSig(ElementSig(16622)), FixedArgSig(ElementSig(131)), FixedArgSig(ElementSig(246)), FixedArgSig(ElementSig(210)), FixedArgSig(ElementSig(184)), FixedArgSig(ElementSig(180)), FixedArgSig(ElementSig(10)), FixedArgSig(ElementSig(119)), FixedArgSig(ElementSig(152))], [])
// Found GuidAttribute ATTR: GuidAttribute : CustomAttributeSig([FixedArgSig(ElementSig(1410065854)), FixedArgSig(ElementSig(42697)), FixedArgSig(ElementSig(16622)), FixedArgSig(ElementSig(131)), FixedArgSig(ElementSig(246)), FixedArgSig(ElementSig(210)), FixedArgSig(ElementSig(184)), FixedArgSig(ElementSig(180)), FixedArgSig(ElementSig(10)), FixedArgSig(ElementSig(119)), FixedArgSig(ElementSig(152))], [])
//INTERFACEF ATTR: GuidAttribute : CustomAttributeSig([FixedArgSig(ElementSig(1410065854)), FixedArgSig(ElementSig(42697)), FixedArgSig(ElementSig(16622)), FixedArgSig(ElementSig(131)), FixedArgSig(ElementSig(246)), FixedArgSig(ElementSig(210)), FixedArgSig(ElementSig(184)), FixedArgSig(ElementSig(180)), FixedArgSig(ElementSig(10)), FixedArgSig(ElementSig(119)), FixedArgSig(ElementSig(152))], [])
interface IMLOperatorShapeInferrer : IUnknown
{
    HRESULT InferOutputShapes(IMLOperatorShapeInferenceContext context);
}

// === List GuidAttribute
//        GuidAttribute: type uint value CustomAttributeSig([FixedArgSig(ElementSig(4011175279)), FixedArgSig(ElementSig(3529)), FixedArgSig(ElementSig(18696)), FixedArgSig(ElementSig(171)), FixedArgSig(ElementSig(53)), FixedArgSig(ElementSig(165)), FixedArgSig(ElementSig(117)), FixedArgSig(ElementSig(163)), FixedArgSig(ElementSig(13)), FixedArgSig(ElementSig(251)), FixedArgSig(ElementSig(248))], [])
// === End List GuidAttribute
// Attribute GuidAttribute: type uint, value CustomAttributeSig([FixedArgSig(ElementSig(4011175279)), FixedArgSig(ElementSig(3529)), FixedArgSig(ElementSig(18696)), FixedArgSig(ElementSig(171)), FixedArgSig(ElementSig(53)), FixedArgSig(ElementSig(165)), FixedArgSig(ElementSig(117)), FixedArgSig(ElementSig(163)), FixedArgSig(ElementSig(13)), FixedArgSig(ElementSig(251)), FixedArgSig(ElementSig(248))], [])
// Found GuidAttribute ATTR: GuidAttribute : CustomAttributeSig([FixedArgSig(ElementSig(4011175279)), FixedArgSig(ElementSig(3529)), FixedArgSig(ElementSig(18696)), FixedArgSig(ElementSig(171)), FixedArgSig(ElementSig(53)), FixedArgSig(ElementSig(165)), FixedArgSig(ElementSig(117)), FixedArgSig(ElementSig(163)), FixedArgSig(ElementSig(13)), FixedArgSig(ElementSig(251)), FixedArgSig(ElementSig(248))], [])
//INTERFACEF ATTR: GuidAttribute : CustomAttributeSig([FixedArgSig(ElementSig(4011175279)), FixedArgSig(ElementSig(3529)), FixedArgSig(ElementSig(18696)), FixedArgSig(ElementSig(171)), FixedArgSig(ElementSig(53)), FixedArgSig(ElementSig(165)), FixedArgSig(ElementSig(117)), FixedArgSig(ElementSig(163)), FixedArgSig(ElementSig(13)), FixedArgSig(ElementSig(251)), FixedArgSig(ElementSig(248))], [])
interface IMLOperatorKernelFactory : IUnknown
{
    HRESULT CreateKernel(IMLOperatorKernelCreationContext context, IMLOperatorKernel* kernel);
}

// === List GuidAttribute
//        GuidAttribute: type uint value CustomAttributeSig([FixedArgSig(ElementSig(721018157)), FixedArgSig(ElementSig(46358)), FixedArgSig(ElementSig(18034)), FixedArgSig(ElementSig(154)), FixedArgSig(ElementSig(181)), FixedArgSig(ElementSig(83)), FixedArgSig(ElementSig(12)), FixedArgSig(ElementSig(32)), FixedArgSig(ElementSig(132)), FixedArgSig(ElementSig(147)), FixedArgSig(ElementSig(173))], [])
// === End List GuidAttribute
// Attribute GuidAttribute: type uint, value CustomAttributeSig([FixedArgSig(ElementSig(721018157)), FixedArgSig(ElementSig(46358)), FixedArgSig(ElementSig(18034)), FixedArgSig(ElementSig(154)), FixedArgSig(ElementSig(181)), FixedArgSig(ElementSig(83)), FixedArgSig(ElementSig(12)), FixedArgSig(ElementSig(32)), FixedArgSig(ElementSig(132)), FixedArgSig(ElementSig(147)), FixedArgSig(ElementSig(173))], [])
// Found GuidAttribute ATTR: GuidAttribute : CustomAttributeSig([FixedArgSig(ElementSig(721018157)), FixedArgSig(ElementSig(46358)), FixedArgSig(ElementSig(18034)), FixedArgSig(ElementSig(154)), FixedArgSig(ElementSig(181)), FixedArgSig(ElementSig(83)), FixedArgSig(ElementSig(12)), FixedArgSig(ElementSig(32)), FixedArgSig(ElementSig(132)), FixedArgSig(ElementSig(147)), FixedArgSig(ElementSig(173))], [])
//INTERFACEF ATTR: GuidAttribute : CustomAttributeSig([FixedArgSig(ElementSig(721018157)), FixedArgSig(ElementSig(46358)), FixedArgSig(ElementSig(18034)), FixedArgSig(ElementSig(154)), FixedArgSig(ElementSig(181)), FixedArgSig(ElementSig(83)), FixedArgSig(ElementSig(12)), FixedArgSig(ElementSig(32)), FixedArgSig(ElementSig(132)), FixedArgSig(ElementSig(147)), FixedArgSig(ElementSig(173))], [])
interface IMLOperatorRegistry : IUnknown
{
    HRESULT RegisterOperatorSetSchema(const(MLOperatorSetId)* operatorSetId, int baselineVersion, 
                                      const(MLOperatorSchemaDescription)** schema, uint schemaCount, 
                                      IMLOperatorTypeInferrer typeInferrer, IMLOperatorShapeInferrer shapeInferrer);
    HRESULT RegisterOperatorKernel(const(MLOperatorKernelDescription)* operatorKernel, 
                                   IMLOperatorKernelFactory operatorKernelFactory, 
                                   IMLOperatorShapeInferrer shapeInferrer);
}


