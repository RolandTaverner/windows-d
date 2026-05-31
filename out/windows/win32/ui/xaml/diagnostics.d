// Written in the D programming language.

module windows.win32.ui.xaml.diagnostics;

public import windows.core;
public import system : Guid;
public import windows.win32.foundation : BOOL, BSTR, HRESULT, PWSTR, RECT;
public import windows.win32.graphics.dxgi.common : DXGI_ALPHA_MODE, DXGI_FORMAT;
public import windows.win32.system.com : IUnknown, SAFEARRAY;
public import windows.win32.system.winrt : IInspectable;

extern(Windows) @nogc nothrow:


// Enums

//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/ne-xamlom-visualmutationtype))], [])
enum VisualMutationType : int
{
    Add     = 0x00000000,
    Remove  = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/ne-xamlom-basevaluesource))], [])
enum BaseValueSource : int
{
    BaseValueSourceUnknown      = 0x00000000,
    BaseValueSourceDefault      = 0x00000001,
    BaseValueSourceBuiltInStyle = 0x00000002,
    BaseValueSourceStyle        = 0x00000003,
    BaseValueSourceLocal        = 0x00000004,
    Inherited                   = 0x00000005,
    DefaultStyleTrigger         = 0x00000006,
    TemplateTrigger             = 0x00000007,
    StyleTrigger                = 0x00000008,
    ImplicitStyleReference      = 0x00000009,
    ParentTemplate              = 0x0000000a,
    ParentTemplateTrigger       = 0x0000000b,
    Animation                   = 0x0000000c,
    Coercion                    = 0x0000000d,
    BaseValueSourceVisualState  = 0x0000000e,
}
//ENUM ATTR: ScopedEnumAttribute : CustomAttributeSig([], [])
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/ne-xamlom-metadatabit))], [])
enum MetadataBit : int
{
    None                           = 0x00000000,
    IsValueHandle                  = 0x00000001,
    IsPropertyReadOnly             = 0x00000002,
    IsValueCollection              = 0x00000004,
    IsValueCollectionReadOnly      = 0x00000008,
    IsValueBindingExpression       = 0x00000010,
    IsValueNull                    = 0x00000020,
    IsValueHandleAndEvaluatedValue = 0x00000040,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/ne-xamlom-rendertargetbitmapoptions))], [])
enum RenderTargetBitmapOptions : int
{
    RenderTarget            = 0x00000000,
    RenderTargetAndChildren = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/ne-xamlom-resourcetype))], [])
enum ResourceType : int
{
    ResourceTypeStatic = 0x00000000,
    ResourceTypeTheme  = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/ne-xamlom-visualelementstate))], [])
enum VisualElementState : int
{
    ErrorResolved         = 0x00000000,
    ErrorResourceNotFound = 0x00000001,
    ErrorInvalidResource  = 0x00000002,
}

// Constants


enum HRESULT E_UNKNOWNTYPE = HRESULT(0x802b0028);

// Structs


//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/ns-xamlom-sourceinfo))], [])
struct SourceInfo
{
    BSTR FileName;
    uint LineNumber;
    uint ColumnNumber;
    uint CharPosition;
    BSTR Hash;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/ns-xamlom-parentchildrelation))], [])
struct ParentChildRelation
{
    ulong Parent;
    ulong Child;
    uint  ChildIndex;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/ns-xamlom-visualelement))], [])
struct VisualElement
{
    ulong      Handle;
    SourceInfo SrcInfo;
    BSTR       Type;
    BSTR       Name;
    uint       NumChildren;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/ns-xamlom-propertychainsource))], [])
struct PropertyChainSource
{
    ulong           Handle;
    BSTR            TargetType;
    BSTR            Name;
    BaseValueSource Source;
    SourceInfo      SrcInfo;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/ns-xamlom-propertychainvalue))], [])
struct PropertyChainValue
{
    uint Index;
    BSTR Type;
    BSTR DeclaringType;
    BSTR ValueType;
    BSTR ItemType;
    BSTR Value;
    BOOL Overridden;
    long MetadataBits;
    BSTR PropertyName;
    uint PropertyChainIndex;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/ns-xamlom-enumtype))], [])
struct EnumType
{
    BSTR       Name;
    SAFEARRAY* ValueInts;
    SAFEARRAY* ValueStrings;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/ns-xamlom-collectionelementvalue))], [])
struct CollectionElementValue
{
    uint Index;
    BSTR ValueType;
    BSTR Value;
    long MetadataBits;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/ns-xamlom-bitmapdescription))], [])
struct BitmapDescription
{
    uint            Width;
    uint            Height;
    DXGI_FORMAT     Format;
    DXGI_ALPHA_MODE AlphaMode;
}

// Functions

@DllImport("Windows.UI.Xaml.dll")
HRESULT InitializeXamlDiagnostic(const(PWSTR) endPointName, uint pid, const(PWSTR) wszDllXamlDiagnostics, 
                                 const(PWSTR) wszTAPDllName, GUID tapClsid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
@DllImport("Windows.UI.Xaml.dll")
HRESULT InitializeXamlDiagnosticsEx(const(PWSTR) endPointName, uint pid, const(PWSTR) wszDllXamlDiagnostics, 
                                    const(PWSTR) wszTAPDllName, GUID tapClsid, const(PWSTR) wszInitializationData);


// Interfaces

@GUID("aa7a8931-80e4-4fec-8f3b-553f87b4966e")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/nn-xamlom-ivisualtreeservicecallback))], [])
interface IVisualTreeServiceCallback : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/nf-xamlom-ivisualtreeservicecallback-onvisualtreechange))], [])
    HRESULT OnVisualTreeChange(ParentChildRelation relation, VisualElement element, 
                               VisualMutationType mutationType);
}

@GUID("bad9eb88-ae77-4397-b948-5fa2db0a19ea")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.14393))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/nn-xamlom-ivisualtreeservicecallback2))], [])
interface IVisualTreeServiceCallback2 : IVisualTreeServiceCallback
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/nf-xamlom-ivisualtreeservicecallback2-onelementstatechanged))], [])
    HRESULT OnElementStateChanged(ulong element, VisualElementState elementState, const(PWSTR) context);
}

@GUID("a593b11a-d17f-48bb-8f66-83910731c8a5")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/nn-xamlom-ivisualtreeservice))], [])
interface IVisualTreeService : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/nf-xamlom-ivisualtreeservice-advisevisualtreechange))], [])
    HRESULT AdviseVisualTreeChange(IVisualTreeServiceCallback pCallback);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/nf-xamlom-ivisualtreeservice-unadvisevisualtreechange))], [])
    HRESULT UnadviseVisualTreeChange(IVisualTreeServiceCallback pCallback);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/nf-xamlom-ivisualtreeservice-getenums))], [])
    HRESULT GetEnums(uint* pCount, EnumType** ppEnums);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/nf-xamlom-ivisualtreeservice-createinstance))], [])
    HRESULT CreateInstance(BSTR typeName, BSTR value, ulong* pInstanceHandle);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/nf-xamlom-ivisualtreeservice-getpropertyvalueschain))], [])
    HRESULT GetPropertyValuesChain(ulong instanceHandle, uint* pSourceCount, 
                                   PropertyChainSource** ppPropertySources, uint* pPropertyCount, 
                                   PropertyChainValue** ppPropertyValues);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/nf-xamlom-ivisualtreeservice-setproperty))], [])
    HRESULT SetProperty(ulong instanceHandle, ulong value, uint propertyIndex);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/nf-xamlom-ivisualtreeservice-clearproperty))], [])
    HRESULT ClearProperty(ulong instanceHandle, uint propertyIndex);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/nf-xamlom-ivisualtreeservice-getcollectioncount))], [])
    HRESULT GetCollectionCount(ulong instanceHandle, uint* pCollectionSize);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/nf-xamlom-ivisualtreeservice-getcollectionelements))], [])
    HRESULT GetCollectionElements(ulong instanceHandle, uint startIndex, uint* pElementCount, 
                                  CollectionElementValue** ppElementValues);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/nf-xamlom-ivisualtreeservice-addchild))], [])
    HRESULT AddChild(ulong parent, ulong child, uint index);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/nf-xamlom-ivisualtreeservice-removechild))], [])
    HRESULT RemoveChild(ulong parent, uint index);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/nf-xamlom-ivisualtreeservice-clearchildren))], [])
    HRESULT ClearChildren(ulong parent);
}

@GUID("18c9e2b6-3f43-4116-9f2b-ff935d7770d2")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/nn-xamlom-ixamldiagnostics))], [])
interface IXamlDiagnostics : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/nf-xamlom-ixamldiagnostics-getdispatcher))], [])
    HRESULT GetDispatcher(IInspectable* ppDispatcher);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/nf-xamlom-ixamldiagnostics-getuilayer))], [])
    HRESULT GetUiLayer(IInspectable* ppLayer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/nf-xamlom-ixamldiagnostics-getapplication))], [])
    HRESULT GetApplication(IInspectable* ppApplication);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/nf-xamlom-ixamldiagnostics-getiinspectablefromhandle))], [])
    HRESULT GetIInspectableFromHandle(ulong instanceHandle, IInspectable* ppInstance);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/nf-xamlom-ixamldiagnostics-gethandlefromiinspectable))], [])
    HRESULT GetHandleFromIInspectable(IInspectable pInstance, ulong* pHandle);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/nf-xamlom-ixamldiagnostics-hittest))], [])
    HRESULT HitTest(RECT rect, uint* pCount, ulong** ppInstanceHandles);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/nf-xamlom-ixamldiagnostics-registerinstance))], [])
    HRESULT RegisterInstance(IInspectable pInstance, ulong* pInstanceHandle);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/nf-xamlom-ixamldiagnostics-getinitializationdata))], [])
    HRESULT GetInitializationData(BSTR* pInitializationData);
}

@GUID("d1a34ef2-cad8-4635-a3d2-fcda8d3f3caf")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.14393))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/nn-xamlom-ibitmapdata))], [])
interface IBitmapData : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/nf-xamlom-ibitmapdata-copybytesto))], [])
    HRESULT CopyBytesTo(uint sourceOffsetInBytes, uint maxBytesToCopy, ubyte* pvBytes, uint* numberOfBytesCopied);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/nf-xamlom-ibitmapdata-getstride))], [])
    HRESULT GetStride(uint* pStride);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/nf-xamlom-ibitmapdata-getbitmapdescription))], [])
    HRESULT GetBitmapDescription(BitmapDescription* pBitmapDescription);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/nf-xamlom-ibitmapdata-getsourcebitmapdescription))], [])
    HRESULT GetSourceBitmapDescription(BitmapDescription* pBitmapDescription);
}

@GUID("130f5136-ec43-4f61-89c7-9801a36d2e95")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.14393))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/nn-xamlom-ivisualtreeservice2))], [])
interface IVisualTreeService2 : IVisualTreeService
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/nf-xamlom-ivisualtreeservice2-getpropertyindex))], [])
    HRESULT GetPropertyIndex(ulong object, const(PWSTR) propertyName, uint* pPropertyIndex);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/nf-xamlom-ivisualtreeservice2-getproperty))], [])
    HRESULT GetProperty(ulong object, uint propertyIndex, ulong* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/nf-xamlom-ivisualtreeservice2-replaceresource))], [])
    HRESULT ReplaceResource(ulong resourceDictionary, ulong key, ulong newValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/nf-xamlom-ivisualtreeservice2-rendertargetbitmap))], [])
    HRESULT RenderTargetBitmap(ulong handle, RenderTargetBitmapOptions options, uint maxPixelWidth, 
                               uint maxPixelHeight, IBitmapData* ppBitmapData);
}

@GUID("0e79c6e0-85a0-4be8-b41a-655cf1fd19bd")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/nn-xamlom-ivisualtreeservice3))], [])
interface IVisualTreeService3 : IVisualTreeService2
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/nf-xamlom-ivisualtreeservice3-resolveresource))], [])
    HRESULT ResolveResource(ulong resourceContext, const(PWSTR) resourceName, ResourceType resourceType, 
                            uint propertyIndex);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/nf-xamlom-ivisualtreeservice3-getdictionaryitem))], [])
    HRESULT GetDictionaryItem(ulong dictionaryHandle, const(PWSTR) resourceName, BOOL resourceIsImplicitStyle, 
                              ulong* resourceHandle);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/nf-xamlom-ivisualtreeservice3-adddictionaryitem))], [])
    HRESULT AddDictionaryItem(ulong dictionaryHandle, ulong resourceKey, ulong resourceHandle);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/xamlom/nf-xamlom-ivisualtreeservice3-removedictionaryitem))], [])
    HRESULT RemoveDictionaryItem(ulong dictionaryHandle, ulong resourceKey);
}


// GUIDs


const GUID IID_IBitmapData                 = GUIDOF!IBitmapData;
const GUID IID_IVisualTreeService          = GUIDOF!IVisualTreeService;
const GUID IID_IVisualTreeService2         = GUIDOF!IVisualTreeService2;
const GUID IID_IVisualTreeService3         = GUIDOF!IVisualTreeService3;
const GUID IID_IVisualTreeServiceCallback  = GUIDOF!IVisualTreeServiceCallback;
const GUID IID_IVisualTreeServiceCallback2 = GUIDOF!IVisualTreeServiceCallback2;
const GUID IID_IXamlDiagnostics            = GUIDOF!IXamlDiagnostics;
