// Written in the D programming language.

module windows.win32.ui.wpf;

public import windows.core;
public import system : Guid;
public import windows.win32.foundation : BSTR, HRESULT, VARIANT_BOOL;
public import windows.win32.graphics.dwm : MilMatrix3x2D;
public import windows.win32.graphics.imaging : IWICBitmapSource;
public import windows.win32.system.com : IUnknown;

extern(Windows) @nogc nothrow:


// Constants


enum uint MILBITMAPEFFECT_SDK_VERSION = 0x01000000;

enum : GUID
{
    CLSID_MILBitmapEffectGroup      = GUID("ac9c1a9a-7e18-4f64-ac7e-47cf7f051e95"),
    CLSID_MILBitmapEffectBlur       = GUID("a924df87-225d-4373-8f5b-b90ec85ae3de"),
    CLSID_MILBitmapEffectDropShadow = GUID("459a3fbe-d8ac-4692-874b-7a265715aa16"),
    CLSID_MILBitmapEffectOuterGlow  = GUID("e2161bdd-7eb6-4725-9c0b-8a2a1b4f0667"),
    CLSID_MILBitmapEffectBevel      = GUID("fd361dbe-6c9b-4de0-8290-f6400c2737ed"),
    CLSID_MILBitmapEffectEmboss     = GUID("cd299846-824f-47ec-a007-12aa767f2816"),
}

// Structs


//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/ns-mileffects-milrectd))], [])
struct MilRectD
{
    double left;
    double top;
    double right;
    double bottom;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/ns-mileffects-milpoint2d))], [])
struct MilPoint2D
{
    double X;
    double Y;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/ns-mileffects-milmatrixf))], [])
struct MILMatrixF
{
    double _11;
    double _12;
    double _13;
    double _14;
    double _21;
    double _22;
    double _23;
    double _24;
    double _31;
    double _32;
    double _33;
    double _34;
    double _41;
    double _42;
    double _43;
    double _44;
}

// Interfaces

@GUID("f66d2e4b-b46b-42fc-859e-3da0ecdb3c43")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nn-mileffects-imilbitmapeffectconnectorinfo))], [])
interface IMILBitmapEffectConnectorInfo : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectconnectorinfo-getindex))], [])
    HRESULT GetIndex(uint* puiIndex);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectconnectorinfo-getoptimalformat))], [])
    HRESULT GetOptimalFormat(GUID* pFormat);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectconnectorinfo-getnumberformats))], [])
    HRESULT GetNumberFormats(uint* pulNumberFormats);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectconnectorinfo-getformat))], [])
    HRESULT GetFormat(uint ulIndex, GUID* pFormat);
}

@GUID("476b538a-c765-4237-ba4a-d6a880ff0cfc")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nn-mileffects-imilbitmapeffectconnectionsinfo))], [])
interface IMILBitmapEffectConnectionsInfo : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectconnectionsinfo-getnumberinputs))], [])
    HRESULT GetNumberInputs(uint* puiNumInputs);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectconnectionsinfo-getnumberoutputs))], [])
    HRESULT GetNumberOutputs(uint* puiNumOutputs);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectconnectionsinfo-getinputconnectorinfo))], [])
    HRESULT GetInputConnectorInfo(uint uiIndex, IMILBitmapEffectConnectorInfo* ppConnectorInfo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectconnectionsinfo-getoutputconnectorinfo))], [])
    HRESULT GetOutputConnectorInfo(uint uiIndex, IMILBitmapEffectConnectorInfo* ppConnectorInfo);
}

@GUID("c2b5d861-9b1a-4374-89b0-dec4874d6a81")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nn-mileffects-imilbitmapeffectconnections))], [])
interface IMILBitmapEffectConnections : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectconnections-getinputconnector))], [])
    HRESULT GetInputConnector(uint uiIndex, IMILBitmapEffectInputConnector* ppConnector);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectconnections-getoutputconnector))], [])
    HRESULT GetOutputConnector(uint uiIndex, IMILBitmapEffectOutputConnector* ppConnector);
}

@GUID("8a6ff321-c944-4a1b-9944-9954af301258")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nn-mileffects-imilbitmapeffect))], [])
interface IMILBitmapEffect : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffect-getoutput))], [])
    HRESULT GetOutput(uint uiIndex, IMILBitmapEffectRenderContext pContext, IWICBitmapSource* ppBitmapSource);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffect-getparenteffect))], [])
    HRESULT GetParentEffect(IMILBitmapEffectGroup* ppParentEffect);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffect-setinputsource))], [])
    HRESULT SetInputSource(uint uiIndex, IWICBitmapSource pBitmapSource);
}

@GUID("cc2468f2-9936-47be-b4af-06b5df5dbcbb")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nn-mileffects-imilbitmapeffectimpl))], [])
interface IMILBitmapEffectImpl : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectimpl-isinplacemodificationallowed))], [])
    HRESULT IsInPlaceModificationAllowed(IMILBitmapEffectOutputConnector pOutputConnector, 
                                         VARIANT_BOOL* pfModifyInPlace);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectimpl-setparenteffect))], [])
    HRESULT SetParentEffect(IMILBitmapEffectGroup pParentEffect);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectimpl-getinputsource))], [])
    HRESULT GetInputSource(uint uiIndex, IWICBitmapSource* ppBitmapSource);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectimpl-getinputsourcebounds))], [])
    HRESULT GetInputSourceBounds(uint uiIndex, MilRectD* pRect);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectimpl-getinputbitmapsource))], [])
    HRESULT GetInputBitmapSource(uint uiIndex, IMILBitmapEffectRenderContext pRenderContext, 
                                 VARIANT_BOOL* pfModifyInPlace, IWICBitmapSource* ppBitmapSource);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectimpl-getoutputbitmapsource))], [])
    HRESULT GetOutputBitmapSource(uint uiIndex, IMILBitmapEffectRenderContext pRenderContext, 
                                  VARIANT_BOOL* pfModifyInPlace, IWICBitmapSource* ppBitmapSource);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectimpl-initialize))], [])
    HRESULT Initialize(IUnknown pInner);
}

@GUID("2f952360-698a-4ac6-81a1-bcfdf08eb8e8")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nn-mileffects-imilbitmapeffectgroup))], [])
interface IMILBitmapEffectGroup : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectgroup-getinteriorinputconnector))], [])
    HRESULT GetInteriorInputConnector(uint uiIndex, IMILBitmapEffectOutputConnector* ppConnector);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectgroup-getinterioroutputconnector))], [])
    HRESULT GetInteriorOutputConnector(uint uiIndex, IMILBitmapEffectInputConnector* ppConnector);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectgroup-add))], [])
    HRESULT Add(IMILBitmapEffect pEffect);
}

@GUID("78fed518-1cfc-4807-8b85-6b6e51398f62")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nn-mileffects-imilbitmapeffectgroupimpl))], [])
interface IMILBitmapEffectGroupImpl : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectgroupimpl-preprocess))], [])
    HRESULT Preprocess(IMILBitmapEffectRenderContext pContext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectgroupimpl-getnumberchildren))], [])
    HRESULT GetNumberChildren(uint* puiNumberChildren);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectgroupimpl-getchildren))], [])
    HRESULT GetChildren(IMILBitmapEffects* pChildren);
}

@GUID("12a2ec7e-2d33-44b2-b334-1abb7846e390")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nn-mileffects-imilbitmapeffectrendercontext))], [])
interface IMILBitmapEffectRenderContext : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectrendercontext-setoutputpixelformat))], [])
    HRESULT SetOutputPixelFormat(GUID* format);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectrendercontext-getoutputpixelformat))], [])
    HRESULT GetOutputPixelFormat(GUID* pFormat);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectrendercontext-setusesoftwarerenderer))], [])
    HRESULT SetUseSoftwareRenderer(VARIANT_BOOL fSoftware);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectrendercontext-setinitialtransform))], [])
    HRESULT SetInitialTransform(MILMatrixF* pMatrix);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectrendercontext-getfinaltransform))], [])
    HRESULT GetFinalTransform(MILMatrixF* pMatrix);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectrendercontext-setoutputdpi))], [])
    HRESULT SetOutputDPI(double dblDpiX, double dblDpiY);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectrendercontext-getoutputdpi))], [])
    HRESULT GetOutputDPI(double* pdblDpiX, double* pdblDpiY);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectrendercontext-setregionofinterest))], [])
    HRESULT SetRegionOfInterest(MilRectD* pRect);
}

@GUID("4d25accb-797d-4fd2-b128-dffeff84fcc3")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nn-mileffects-imilbitmapeffectrendercontextimpl))], [])
interface IMILBitmapEffectRenderContextImpl : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectrendercontextimpl-getusesoftwarerenderer))], [])
    HRESULT GetUseSoftwareRenderer(VARIANT_BOOL* pfSoftware);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectrendercontextimpl-gettransform))], [])
    HRESULT GetTransform(MILMatrixF* pMatrix);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectrendercontextimpl-updatetransform))], [])
    HRESULT UpdateTransform(MILMatrixF* pMatrix);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectrendercontextimpl-getoutputbounds))], [])
    HRESULT GetOutputBounds(MilRectD* pRect);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectrendercontextimpl-updateoutputbounds))], [])
    HRESULT UpdateOutputBounds(MilRectD* pRect);
}

@GUID("33a9df34-a403-4ec7-b07e-bc0682370845")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nn-mileffects-imilbitmapeffectfactory))], [])
interface IMILBitmapEffectFactory : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectfactory-createeffect))], [])
    HRESULT CreateEffect(const(GUID)* pguidEffect, IMILBitmapEffect* ppEffect);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectfactory-createcontext))], [])
    HRESULT CreateContext(IMILBitmapEffectRenderContext* ppContext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectfactory-createeffectouter))], [])
    HRESULT CreateEffectOuter(IMILBitmapEffect* ppEffect);
}

@GUID("67e31025-3091-4dfc-98d6-dd494551461d")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nn-mileffects-imilbitmapeffectprimitive))], [])
interface IMILBitmapEffectPrimitive : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectprimitive-getoutput))], [])
    HRESULT GetOutput(uint uiIndex, IMILBitmapEffectRenderContext pContext, VARIANT_BOOL* pfModifyInPlace, 
                      IWICBitmapSource* ppBitmapSource);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectprimitive-transformpoint))], [])
    HRESULT TransformPoint(uint uiIndex, MilPoint2D* p, VARIANT_BOOL fForwardTransform, 
                           IMILBitmapEffectRenderContext pContext, VARIANT_BOOL* pfPointTransformed);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectprimitive-transformrect))], [])
    HRESULT TransformRect(uint uiIndex, MilRectD* p, VARIANT_BOOL fForwardTransform, 
                          IMILBitmapEffectRenderContext pContext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectprimitive-hasaffinetransform))], [])
    HRESULT HasAffineTransform(uint uiIndex, VARIANT_BOOL* pfAffine);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectprimitive-hasinversetransform))], [])
    HRESULT HasInverseTransform(uint uiIndex, VARIANT_BOOL* pfHasInverse);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectprimitive-getaffinematrix))], [])
    HRESULT GetAffineMatrix(uint uiIndex, MilMatrix3x2D* pMatrix);
}

@GUID("ce41e00b-efa6-44e7-b007-dd042e3ae126")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nn-mileffects-imilbitmapeffectprimitiveimpl))], [])
interface IMILBitmapEffectPrimitiveImpl : IUnknown
{
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT IsDirty(uint uiOutputIndex, VARIANT_BOOL* pfDirty);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectprimitiveimpl-isvolatile))], [])
    HRESULT IsVolatile(uint uiOutputIndex, VARIANT_BOOL* pfVolatile);
}

@GUID("51ac3dce-67c5-448b-9180-ad3eabddd5dd")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nn-mileffects-imilbitmapeffects))], [])
interface IMILBitmapEffects : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffects-_newenum))], [])
    HRESULT _NewEnum(IUnknown* ppiuReturn);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffects-get_parent))], [])
    HRESULT get_Parent(IMILBitmapEffectGroup* ppEffect);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffects-item))], [])
    HRESULT Item(uint uindex, IMILBitmapEffect* ppEffect);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffects-get_count))], [])
    HRESULT get_Count(uint* puiCount);
}

@GUID("f59567b3-76c1-4d47-ba1e-79f955e350ef")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nn-mileffects-imilbitmapeffectconnector))], [])
interface IMILBitmapEffectConnector : IMILBitmapEffectConnectorInfo
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectconnector-isconnected))], [])
    HRESULT IsConnected(VARIANT_BOOL* pfConnected);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectconnector-getbitmapeffect))], [])
    HRESULT GetBitmapEffect(IMILBitmapEffect* ppEffect);
}

@GUID("a9b4ecaa-7a3c-45e7-8573-f4b81b60dd6c")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nn-mileffects-imilbitmapeffectinputconnector))], [])
interface IMILBitmapEffectInputConnector : IMILBitmapEffectConnector
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectinputconnector-connectto))], [])
    HRESULT ConnectTo(IMILBitmapEffectOutputConnector pConnector);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectinputconnector-getconnection))], [])
    HRESULT GetConnection(IMILBitmapEffectOutputConnector* ppConnector);
}

@GUID("92957aad-841b-4866-82ec-8752468b07fd")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nn-mileffects-imilbitmapeffectoutputconnector))], [])
interface IMILBitmapEffectOutputConnector : IMILBitmapEffectConnector
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectoutputconnector-getnumberconnections))], [])
    HRESULT GetNumberConnections(uint* puiNumberConnections);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectoutputconnector-getconnection))], [])
    HRESULT GetConnection(uint uiIndex, IMILBitmapEffectInputConnector* ppConnection);
}

@GUID("21fae777-8b39-4bfa-9f2d-f3941ed36913")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nn-mileffects-imilbitmapeffectoutputconnectorimpl))], [])
interface IMILBitmapEffectOutputConnectorImpl : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectoutputconnectorimpl-addbacklink))], [])
    HRESULT AddBackLink(IMILBitmapEffectInputConnector pConnection);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectoutputconnectorimpl-removebacklink))], [])
    HRESULT RemoveBackLink(IMILBitmapEffectInputConnector pConnection);
}

@GUID("20287e9e-86a2-4e15-953d-eb1438a5b842")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nn-mileffects-imilbitmapeffectinteriorinputconnector))], [])
interface IMILBitmapEffectInteriorInputConnector : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectinteriorinputconnector-getinputconnector))], [])
    HRESULT GetInputConnector(IMILBitmapEffectInputConnector* pInputConnector);
}

@GUID("00bbb6dc-acc9-4bfc-b344-8bee383dfefa")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nn-mileffects-imilbitmapeffectinterioroutputconnector))], [])
interface IMILBitmapEffectInteriorOutputConnector : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectinterioroutputconnector-getoutputconnector))], [])
    HRESULT GetOutputConnector(IMILBitmapEffectOutputConnector* pOutputConnector);
}

@GUID("2e880dd8-f8ce-457b-8199-d60bb3d7ef98")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nn-mileffects-imilbitmapeffectevents))], [])
interface IMILBitmapEffectEvents : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectevents-propertychange))], [])
    HRESULT PropertyChange(IMILBitmapEffect pEffect, BSTR bstrPropertyName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mileffects/nf-mileffects-imilbitmapeffectevents-dirtyregion))], [])
    HRESULT DirtyRegion(IMILBitmapEffect pEffect, MilRectD* pRect);
}


// GUIDs


const GUID IID_IMILBitmapEffect                        = GUIDOF!IMILBitmapEffect;
const GUID IID_IMILBitmapEffectConnections             = GUIDOF!IMILBitmapEffectConnections;
const GUID IID_IMILBitmapEffectConnectionsInfo         = GUIDOF!IMILBitmapEffectConnectionsInfo;
const GUID IID_IMILBitmapEffectConnector               = GUIDOF!IMILBitmapEffectConnector;
const GUID IID_IMILBitmapEffectConnectorInfo           = GUIDOF!IMILBitmapEffectConnectorInfo;
const GUID IID_IMILBitmapEffectEvents                  = GUIDOF!IMILBitmapEffectEvents;
const GUID IID_IMILBitmapEffectFactory                 = GUIDOF!IMILBitmapEffectFactory;
const GUID IID_IMILBitmapEffectGroup                   = GUIDOF!IMILBitmapEffectGroup;
const GUID IID_IMILBitmapEffectGroupImpl               = GUIDOF!IMILBitmapEffectGroupImpl;
const GUID IID_IMILBitmapEffectImpl                    = GUIDOF!IMILBitmapEffectImpl;
const GUID IID_IMILBitmapEffectInputConnector          = GUIDOF!IMILBitmapEffectInputConnector;
const GUID IID_IMILBitmapEffectInteriorInputConnector  = GUIDOF!IMILBitmapEffectInteriorInputConnector;
const GUID IID_IMILBitmapEffectInteriorOutputConnector = GUIDOF!IMILBitmapEffectInteriorOutputConnector;
const GUID IID_IMILBitmapEffectOutputConnector         = GUIDOF!IMILBitmapEffectOutputConnector;
const GUID IID_IMILBitmapEffectOutputConnectorImpl     = GUIDOF!IMILBitmapEffectOutputConnectorImpl;
const GUID IID_IMILBitmapEffectPrimitive               = GUIDOF!IMILBitmapEffectPrimitive;
const GUID IID_IMILBitmapEffectPrimitiveImpl           = GUIDOF!IMILBitmapEffectPrimitiveImpl;
const GUID IID_IMILBitmapEffectRenderContext           = GUIDOF!IMILBitmapEffectRenderContext;
const GUID IID_IMILBitmapEffectRenderContextImpl       = GUIDOF!IMILBitmapEffectRenderContextImpl;
const GUID IID_IMILBitmapEffects                       = GUIDOF!IMILBitmapEffects;
