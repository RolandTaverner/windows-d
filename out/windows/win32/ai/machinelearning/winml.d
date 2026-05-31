// Written in the D programming language.

module windows.win32.ai.machinelearning.winml;

public import windows.core;
public import windows.win32.foundation : BOOL, HRESULT, PSTR, PWSTR;
public import windows.win32.graphics.direct3d12 : ID3D12Device, ID3D12Resource;
public import windows.win32.system.com : IUnknown;

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
    uint                ElementCount;
    WINML_TENSOR_DATA_TYPE ElementType;
    _Anonymous_e__Union Anonymous;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winml/ns-winml-winml_map_binding_desc))], [])
struct WINML_MAP_BINDING_DESC
{
    uint                 ElementCount;
    WINML_TENSOR_DATA_TYPE KeyType;
    _Anonymous1_e__Union Anonymous1;
    WINML_TENSOR_DATA_TYPE Fields;
    _Anonymous2_e__Union Anonymous2;
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
    const(PWSTR)        Name;
    WINML_BINDING_TYPE  BindType;
    _Anonymous_e__Union Anonymous;
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
    PWSTR               Name;
    PWSTR               Description;
    WINML_FEATURE_TYPE  FeatureType;
    BOOL                Required;
    _Anonymous_e__Union Anonymous;
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
    MLOperatorEdgeType  edgeType;
    _Anonymous_e__Union Anonymous;
}

struct MLOperatorSchemaEdgeDescription
{
    MLOperatorParameterOptions options;
    MLOperatorSchemaEdgeTypeFormat typeFormat;
    _Anonymous_e__Union Anonymous;
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
    const(PSTR)         name;
    MLOperatorAttributeType type;
    uint                valueCount;
    _Anonymous_e__Union Anonymous;
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

@GUID("e2eeb6a9-f31f-4055-a521-e30b5b33664a")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17134))], [])
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

@GUID("95848f9e-583d-4054-af12-916387cd8426")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17134))], [])
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

@GUID("a0425329-40ae-48d9-bce3-829ef7b8a41a")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17134))], [])
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

@GUID("a807b84d-4ae5-4bc0-a76a-941aa246bd41")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17134))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winml/nn-winml-iwinmlruntimefactory))], [])
interface IWinMLRuntimeFactory : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winml/nf-winml-iwinmlruntimefactory-createruntime))], [])
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
