// Written in the D programming language.

module windows.win32.ai.machinelearning.winml;

public import windows.core;
public import windows.win32.foundation.foundation : BOOL, HRESULT, PSTR, PWSTR;
public import windows.win32.graphics.direct3d12 : ID3D12Device, ID3D12Resource;
public import windows.win32.system.com.com : IUnknown;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winml/ne-winml-winml_tensor_data_type
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winml/ne-winml-winml_feature_type
alias WINML_FEATURE_TYPE = int;
enum : int
{
    WINML_FEATURE_UNDEFINED = 0x00000000,
    WINML_FEATURE_TENSOR    = 0x00000001,
    WINML_FEATURE_SEQUENCE  = 0x00000002,
    WINML_FEATURE_MAP       = 0x00000003,
    WINML_FEATURE_IMAGE     = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winml/ne-winml-winml_binding_type
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winml/ne-winml-winml_runtime_type
alias WINML_RUNTIME_TYPE = int;
enum : int
{
    WINML_RUNTIME_CNTK = 0x00000000,
}

//ENUM ATTR: ScopedEnumAttribute : CustomAttributeSig([], [])
enum MLOperatorAttributeType : uint
{
    Undefined   = 0x00000000U,
    Float       = 0x00000002U,
    Int         = 0x00000003U,
    String      = 0x00000004U,
    FloatArray  = 0x00000007U,
    IntArray    = 0x00000008U,
    StringArray = 0x00000009U,
}

//ENUM ATTR: ScopedEnumAttribute : CustomAttributeSig([], [])
enum MLOperatorTensorDataType : uint
{
    Undefined  = 0x00000000U,
    Float      = 0x00000001U,
    UInt8      = 0x00000002U,
    Int8       = 0x00000003U,
    UInt16     = 0x00000004U,
    Int16      = 0x00000005U,
    Int32      = 0x00000006U,
    Int64      = 0x00000007U,
    String     = 0x00000008U,
    Bool       = 0x00000009U,
    Float16    = 0x0000000aU,
    Double     = 0x0000000bU,
    UInt32     = 0x0000000cU,
    UInt64     = 0x0000000dU,
    Complex64  = 0x0000000eU,
    Complex128 = 0x0000000fU,
}

//ENUM ATTR: ScopedEnumAttribute : CustomAttributeSig([], [])
enum MLOperatorEdgeType : uint
{
    Undefined      = 0x00000000U,
    Tensor         = 0x00000001U,
    SequenceTensor = 0x00000002U,
    Primitive      = 0x00000003U,
}

//ENUM ATTR: ScopedEnumAttribute : CustomAttributeSig([], [])
enum MLOperatorParameterOptions : uint
{
    Single   = 0x00000000U,
    Optional = 0x00000001U,
    Variadic = 0x00000002U,
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
    None                    = 0x00000000U,
    AllowDynamicInputShapes = 0x00000001U,
}

//ENUM ATTR: ScopedEnumAttribute : CustomAttributeSig([], [])
enum MLOperatorExecutionType : uint
{
    Undefined = 0x00000000U,
    Cpu       = 0x00000001U,
    D3D12     = 0x00000002U,
}

// Constants


enum uint WINML_TENSOR_DIMENSION_COUNT_MAX = 0x00000004U;

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winml/ns-winml-winml_tensor_binding_desc
struct WINML_TENSOR_BINDING_DESC
{
    WINML_TENSOR_DATA_TYPE DataType;
    uint  NumDimensions;
    long* pShape;
    uint  DataSize;
    void* pData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winml/ns-winml-winml_sequence_binding_desc
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winml/ns-winml-winml_map_binding_desc
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winml/ns-winml-winml_image_binding_desc
struct WINML_IMAGE_BINDING_DESC
{
    WINML_TENSOR_DATA_TYPE ElementType;
    uint  NumDimensions;
    long* pShape;
    uint  DataSize;
    void* pData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winml/ns-winml-winml_resource_binding_desc
struct WINML_RESOURCE_BINDING_DESC
{
    WINML_TENSOR_DATA_TYPE ElementType;
    uint           NumDimensions;
    long*          pShape;
    ID3D12Resource pResource;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winml/ns-winml-winml_binding_desc
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winml/ns-winml-winml_tensor_variable_desc
struct WINML_TENSOR_VARIABLE_DESC
{
    WINML_TENSOR_DATA_TYPE ElementType;
    uint  NumDimensions;
    long* pShape;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winml/ns-winml-winml_sequence_variable_desc
struct WINML_SEQUENCE_VARIABLE_DESC
{
    WINML_TENSOR_DATA_TYPE ElementType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winml/ns-winml-winml_map_variable_desc
struct WINML_MAP_VARIABLE_DESC
{
    WINML_TENSOR_DATA_TYPE KeyType;
    WINML_TENSOR_DATA_TYPE Fields;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winml/ns-winml-winml_image_variable_desc
struct WINML_IMAGE_VARIABLE_DESC
{
    WINML_TENSOR_DATA_TYPE ElementType;
    uint  NumDimensions;
    long* pShape;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winml/ns-winml-winml_variable_desc
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winml/ns-winml-winml_model_desc
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

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17134))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winml/nn-winml-iwinmlmodel
@GUID("e2eeb6a9-f31f-4055-a521-e30b5b33664a")
interface IWinMLModel : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winml/nf-winml-iwinmlmodel-getdescription
    HRESULT GetDescription(WINML_MODEL_DESC** ppDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winml/nf-winml-iwinmlmodel-enumeratemetadata
    HRESULT EnumerateMetadata(uint Index, const(PWSTR)* pKey, const(PWSTR)* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winml/nf-winml-iwinmlmodel-enumeratemodelinputs
    HRESULT EnumerateModelInputs(uint Index, WINML_VARIABLE_DESC** ppInputDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winml/nf-winml-iwinmlmodel-enumeratemodeloutputs
    HRESULT EnumerateModelOutputs(uint Index, WINML_VARIABLE_DESC** ppOutputDescriptor);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17134))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winml/nn-winml-iwinmlevaluationcontext
@GUID("95848f9e-583d-4054-af12-916387cd8426")
interface IWinMLEvaluationContext : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winml/nf-winml-iwinmlevaluationcontext-bindvalue
    HRESULT BindValue(WINML_BINDING_DESC* pDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winml/nf-winml-iwinmlevaluationcontext-getvaluebyname
    HRESULT GetValueByName(const(PWSTR) Name, WINML_BINDING_DESC** pDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winml/nf-winml-iwinmlevaluationcontext-clear
    HRESULT Clear();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17134))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winml/nn-winml-iwinmlruntime
@GUID("a0425329-40ae-48d9-bce3-829ef7b8a41a")
interface IWinMLRuntime : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winml/nf-winml-iwinmlruntime-loadmodel
    HRESULT LoadModel(const(PWSTR) Path, IWinMLModel* ppModel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winml/nf-winml-iwinmlruntime-createevaluationcontext
    HRESULT CreateEvaluationContext(ID3D12Device device, IWinMLEvaluationContext* ppContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winml/nf-winml-iwinmlruntime-evaluatemodel
    HRESULT EvaluateModel(IWinMLEvaluationContext pContext);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17134))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winml/nn-winml-iwinmlruntimefactory
@GUID("a807b84d-4ae5-4bc0-a76a-941aa246bd41")
interface IWinMLRuntimeFactory : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winml/nf-winml-iwinmlruntimefactory-createruntime
    HRESULT CreateRuntime(WINML_RUNTIME_TYPE RuntimeType, IWinMLRuntime* ppRuntime);
}

@GUID("4b1b1759-ec40-466c-aab4-beb5347fd24c")
interface IMLOperatorAttributes : IUnknown
{
    HRESULT GetAttributeElementCount(const(PSTR) name, MLOperatorAttributeType type, uint* elementCount);
    HRESULT GetAttribute(const(PSTR) name, MLOperatorAttributeType type, uint elementCount, size_t elementByteSize, 
                         void* value);
    HRESULT GetStringAttributeElementLength(const(PSTR) name, uint elementIndex, uint* attributeElementByteSize);
    HRESULT GetStringAttributeElement(const(PSTR) name, uint elementIndex, uint attributeElementByteSize, 
                                      PSTR attributeElement);
}

@GUID("f20e8cbe-3b28-4248-be95-f96fbc6e4643")
interface IMLOperatorTensorShapeDescription : IUnknown
{
    HRESULT GetInputTensorDimensionCount(uint inputIndex, uint* dimensionCount);
    HRESULT GetInputTensorShape(uint inputIndex, uint dimensionCount, uint* dimensions);
    bool    HasOutputShapeDescription();
    HRESULT GetOutputTensorDimensionCount(uint outputIndex, uint* dimensionCount);
    HRESULT GetOutputTensorShape(uint outputIndex, uint dimensionCount, uint* dimensions);
}

@GUID("5459b53d-a0fc-4665-addd-70171ef7e631")
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

@GUID("7fe41f41-f430-440e-aece-54416dc8b9db")
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

@GUID("82536a28-f022-4769-9d3f-8b278f84c0c3")
interface IMLOperatorKernelContext : IUnknown
{
    HRESULT GetInputTensor(uint inputIndex, IMLOperatorTensor* tensor);
    HRESULT GetOutputTensor(uint outputIndex, uint dimensionCount, const(uint)* dimensionSizes, 
                            IMLOperatorTensor* tensor);
    HRESULT GetOutputTensor(uint outputIndex, IMLOperatorTensor* tensor);
    HRESULT AllocateTemporaryData(size_t size, IUnknown* data);
    void    GetExecutionInterface(IUnknown* executionObject);
}

@GUID("11c4b4a0-b467-4eaa-a1a6-b961d8d0ed79")
interface IMLOperatorKernel : IUnknown
{
    HRESULT Compute(IMLOperatorKernelContext context);
}

@GUID("105b6b29-5408-4a68-9959-09b5955a3492")
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

@GUID("ec893bb1-f938-427b-8488-c8dcf775f138")
interface IMLOperatorTypeInferenceContext : IMLOperatorAttributes
{
    uint    GetInputCount();
    uint    GetOutputCount();
    bool    IsInputValid(uint inputIndex);
    bool    IsOutputValid(uint outputIndex);
    HRESULT GetInputEdgeDescription(uint inputIndex, MLOperatorEdgeDescription* edgeDescription);
    HRESULT SetOutputEdgeDescription(uint outputIndex, const(MLOperatorEdgeDescription)* edgeDescription);
}

@GUID("781aeb48-9bcb-4797-bf77-8bf455217beb")
interface IMLOperatorTypeInferrer : IUnknown
{
    HRESULT InferOutputTypes(IMLOperatorTypeInferenceContext context);
}

@GUID("540be5be-a6c9-40ee-83f6-d2b8b40a7798")
interface IMLOperatorShapeInferrer : IUnknown
{
    HRESULT InferOutputShapes(IMLOperatorShapeInferenceContext context);
}

@GUID("ef15ad6f-0dc9-4908-ab35-a575a30dfbf8")
interface IMLOperatorKernelFactory : IUnknown
{
    HRESULT CreateKernel(IMLOperatorKernelCreationContext context, IMLOperatorKernel* kernel);
}

@GUID("2af9dd2d-b516-4672-9ab5-530c208493ad")
interface IMLOperatorRegistry : IUnknown
{
    HRESULT RegisterOperatorSetSchema(const(MLOperatorSetId)* operatorSetId, int baselineVersion, 
                                      const(MLOperatorSchemaDescription)** schema, uint schemaCount, 
                                      IMLOperatorTypeInferrer typeInferrer, IMLOperatorShapeInferrer shapeInferrer);
    HRESULT RegisterOperatorKernel(const(MLOperatorKernelDescription)* operatorKernel, 
                                   IMLOperatorKernelFactory operatorKernelFactory, 
                                   IMLOperatorShapeInferrer shapeInferrer);
}


// GUIDs


const GUID IID_IMLOperatorAttributes             = GUIDOF!IMLOperatorAttributes;
const GUID IID_IMLOperatorKernel                 = GUIDOF!IMLOperatorKernel;
const GUID IID_IMLOperatorKernelContext          = GUIDOF!IMLOperatorKernelContext;
const GUID IID_IMLOperatorKernelCreationContext  = GUIDOF!IMLOperatorKernelCreationContext;
const GUID IID_IMLOperatorKernelFactory          = GUIDOF!IMLOperatorKernelFactory;
const GUID IID_IMLOperatorRegistry               = GUIDOF!IMLOperatorRegistry;
const GUID IID_IMLOperatorShapeInferenceContext  = GUIDOF!IMLOperatorShapeInferenceContext;
const GUID IID_IMLOperatorShapeInferrer          = GUIDOF!IMLOperatorShapeInferrer;
const GUID IID_IMLOperatorTensor                 = GUIDOF!IMLOperatorTensor;
const GUID IID_IMLOperatorTensorShapeDescription = GUIDOF!IMLOperatorTensorShapeDescription;
const GUID IID_IMLOperatorTypeInferenceContext   = GUIDOF!IMLOperatorTypeInferenceContext;
const GUID IID_IMLOperatorTypeInferrer           = GUIDOF!IMLOperatorTypeInferrer;
const GUID IID_IWinMLEvaluationContext           = GUIDOF!IWinMLEvaluationContext;
const GUID IID_IWinMLModel                       = GUIDOF!IWinMLModel;
const GUID IID_IWinMLRuntime                     = GUIDOF!IWinMLRuntime;
const GUID IID_IWinMLRuntimeFactory              = GUIDOF!IWinMLRuntimeFactory;
