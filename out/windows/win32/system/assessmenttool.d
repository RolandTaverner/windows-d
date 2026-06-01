// Written in the D programming language.

module windows.win32.system.assessmenttool;

public import windows.core;
public import windows.win32.data.xml.msxml : IXMLDOMNodeList;
public import windows.win32.foundation.foundation : BSTR, HRESULT, HWND, PWSTR;
public import windows.win32.graphics.gdi : HBITMAP;
public import windows.win32.system.com.com : IDispatch, IUnknown;
public import windows.win32.system.variant : VARIANT;
public import windows.win32.ui.accessibility : IAccessible;

extern(Windows) @nogc nothrow:


// Enums


alias WINSAT_OEM_CUSTOMIZATION_STATE = int;
enum : int
{
    WINSAT_OEM_DATA_VALID                = 0x00000000,
    WINSAT_OEM_DATA_NON_SYS_CONFIG_MATCH = 0x00000001,
    WINSAT_OEM_DATA_INVALID              = 0x00000002,
    WINSAT_OEM_NO_DATA_SUPPLIED          = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsatcominterfacei/ne-winsatcominterfacei-winsat_assessment_state
alias WINSAT_ASSESSMENT_STATE = int;
enum : int
{
    WINSAT_ASSESSMENT_STATE_MIN                      = 0x00000000,
    WINSAT_ASSESSMENT_STATE_UNKNOWN                  = 0x00000000,
    WINSAT_ASSESSMENT_STATE_VALID                    = 0x00000001,
    WINSAT_ASSESSMENT_STATE_INCOHERENT_WITH_HARDWARE = 0x00000002,
    WINSAT_ASSESSMENT_STATE_NOT_AVAILABLE            = 0x00000003,
    WINSAT_ASSESSMENT_STATE_INVALID                  = 0x00000004,
    WINSAT_ASSESSMENT_STATE_MAX                      = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsatcominterfacei/ne-winsatcominterfacei-winsat_assessment_type
alias WINSAT_ASSESSMENT_TYPE = int;
enum : int
{
    WINSAT_ASSESSMENT_MEMORY   = 0x00000000,
    WINSAT_ASSESSMENT_CPU      = 0x00000001,
    WINSAT_ASSESSMENT_DISK     = 0x00000002,
    WINSAT_ASSESSMENT_D3D      = 0x00000003,
    WINSAT_ASSESSMENT_GRAPHICS = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsatcominterfacei/ne-winsatcominterfacei-winsat_bitmap_size
alias WINSAT_BITMAP_SIZE = int;
enum : int
{
    WINSAT_BITMAP_SIZE_SMALL  = 0x00000000,
    WINSAT_BITMAP_SIZE_NORMAL = 0x00000001,
}

// Interfaces

@GUID("489331dc-f5e0-4528-9fda-45331bf4a571")
struct CInitiateWinSAT;

@GUID("f3bdfad3-f276-49e9-9b17-c474f48f0764")
struct CQueryWinSAT;

@GUID("05df8d13-c355-47f4-a11e-851b338cefb8")
struct CQueryAllWinSAT;

@GUID("9f377d7e-e551-44f8-9f94-9db392b03b7b")
struct CProvideWinSATVisuals;

@GUID("6e18f9c6-a3eb-495a-89b7-956482e19f7a")
struct CAccessiblityWinSAT;

@GUID("c47a41b7-b729-424f-9af9-5cb3934f2dfa")
struct CQueryOEMWinSATCustomization;

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsatcominterfacei/nn-winsatcominterfacei-iprovidewinsatassessmentinfo
@GUID("0cd1c380-52d3-4678-ac6f-e929e480be9e")
interface IProvideWinSATAssessmentInfo : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsatcominterfacei/nf-winsatcominterfacei-iprovidewinsatassessmentinfo-get_score
    HRESULT get_Score(float* score);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsatcominterfacei/nf-winsatcominterfacei-iprovidewinsatassessmentinfo-get_title
    HRESULT get_Title(BSTR* title);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsatcominterfacei/nf-winsatcominterfacei-iprovidewinsatassessmentinfo-get_description
    HRESULT get_Description(BSTR* description);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsatcominterfacei/nn-winsatcominterfacei-iprovidewinsatresultsinfo
@GUID("f8334d5d-568e-4075-875f-9df341506640")
interface IProvideWinSATResultsInfo : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsatcominterfacei/nf-winsatcominterfacei-iprovidewinsatresultsinfo-getassessmentinfo
    HRESULT GetAssessmentInfo(WINSAT_ASSESSMENT_TYPE assessment, IProvideWinSATAssessmentInfo* ppinfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsatcominterfacei/nf-winsatcominterfacei-iprovidewinsatresultsinfo-get_assessmentstate
    HRESULT get_AssessmentState(WINSAT_ASSESSMENT_STATE* state);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsatcominterfacei/nf-winsatcominterfacei-iprovidewinsatresultsinfo-get_assessmentdatetime
    HRESULT get_AssessmentDateTime(VARIANT* fileTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsatcominterfacei/nf-winsatcominterfacei-iprovidewinsatresultsinfo-get_systemrating
    HRESULT get_SystemRating(float* level);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsatcominterfacei/nf-winsatcominterfacei-iprovidewinsatresultsinfo-get_ratingstatedesc
    HRESULT get_RatingStateDesc(BSTR* description);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsatcominterfacei/nn-winsatcominterfacei-iqueryrecentwinsatassessment
@GUID("f8ad5d1f-3b47-4bdc-9375-7c6b1da4eca7")
interface IQueryRecentWinSATAssessment : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsatcominterfacei/nf-winsatcominterfacei-iqueryrecentwinsatassessment-get_xml
    HRESULT get_XML(BSTR xPath, BSTR namespaces, IXMLDOMNodeList* ppDomNodeList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsatcominterfacei/nf-winsatcominterfacei-iqueryrecentwinsatassessment-get_info
    HRESULT get_Info(IProvideWinSATResultsInfo* ppWinSATAssessmentInfo);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsatcominterfacei/nn-winsatcominterfacei-iprovidewinsatvisuals
@GUID("a9f4ade0-871a-42a3-b813-3078d25162c9")
interface IProvideWinSATVisuals : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsatcominterfacei/nf-winsatcominterfacei-iprovidewinsatvisuals-get_bitmap
    HRESULT get_Bitmap(WINSAT_BITMAP_SIZE bitmapSize, WINSAT_ASSESSMENT_STATE state, float rating, 
                       HBITMAP* pBitmap);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsatcominterfacei/nn-winsatcominterfacei-iqueryallwinsatassessments
@GUID("0b89ed1d-6398-4fea-87fc-567d8d19176f")
interface IQueryAllWinSATAssessments : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsatcominterfacei/nf-winsatcominterfacei-iqueryallwinsatassessments-get_allxml
    HRESULT get_AllXML(BSTR xPath, BSTR namespaces, IXMLDOMNodeList* ppDomNodeList);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsatcominterfacei/nn-winsatcominterfacei-iwinsatinitiateevents
@GUID("262a1918-ba0d-41d5-92c2-fab4633ee74f")
interface IWinSATInitiateEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsatcominterfacei/nf-winsatcominterfacei-iwinsatinitiateevents-winsatcomplete
    HRESULT WinSATComplete(HRESULT hresult, const(PWSTR) strDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsatcominterfacei/nf-winsatcominterfacei-iwinsatinitiateevents-winsatupdate
    HRESULT WinSATUpdate(uint uCurrentTick, uint uTickTotal, const(PWSTR) strCurrentState);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsatcominterfacei/nn-winsatcominterfacei-iinitiatewinsatassessment
@GUID("d983fc50-f5bf-49d5-b5ed-cccb18aa7fc1")
interface IInitiateWinSATAssessment : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsatcominterfacei/nf-winsatcominterfacei-iinitiatewinsatassessment-initiateassessment
    HRESULT InitiateAssessment(const(PWSTR) cmdLine, IWinSATInitiateEvents pCallbacks, HWND callerHwnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsatcominterfacei/nf-winsatcominterfacei-iinitiatewinsatassessment-initiateformalassessment
    HRESULT InitiateFormalAssessment(IWinSATInitiateEvents pCallbacks, HWND callerHwnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsatcominterfacei/nf-winsatcominterfacei-iinitiatewinsatassessment-cancelassessment
    HRESULT CancelAssessment();
}

@GUID("30e6018a-94a8-4ff8-a69a-71b67413f07b")
interface IAccessibleWinSAT : IAccessible
{
    HRESULT SetAccessiblityData(const(PWSTR) wsName, const(PWSTR) wsValue, const(PWSTR) wsDesc);
}

@GUID("bc9a6a9f-ad4e-420e-9953-b34671e9df22")
interface IQueryOEMWinSATCustomization : IUnknown
{
    HRESULT GetOEMPrePopulationInfo(WINSAT_OEM_CUSTOMIZATION_STATE* state);
}


// GUIDs

const GUID CLSID_CAccessiblityWinSAT          = GUIDOF!CAccessiblityWinSAT;
const GUID CLSID_CInitiateWinSAT              = GUIDOF!CInitiateWinSAT;
const GUID CLSID_CProvideWinSATVisuals        = GUIDOF!CProvideWinSATVisuals;
const GUID CLSID_CQueryAllWinSAT              = GUIDOF!CQueryAllWinSAT;
const GUID CLSID_CQueryOEMWinSATCustomization = GUIDOF!CQueryOEMWinSATCustomization;
const GUID CLSID_CQueryWinSAT                 = GUIDOF!CQueryWinSAT;

const GUID IID_IAccessibleWinSAT            = GUIDOF!IAccessibleWinSAT;
const GUID IID_IInitiateWinSATAssessment    = GUIDOF!IInitiateWinSATAssessment;
const GUID IID_IProvideWinSATAssessmentInfo = GUIDOF!IProvideWinSATAssessmentInfo;
const GUID IID_IProvideWinSATResultsInfo    = GUIDOF!IProvideWinSATResultsInfo;
const GUID IID_IProvideWinSATVisuals        = GUIDOF!IProvideWinSATVisuals;
const GUID IID_IQueryAllWinSATAssessments   = GUIDOF!IQueryAllWinSATAssessments;
const GUID IID_IQueryOEMWinSATCustomization = GUIDOF!IQueryOEMWinSATCustomization;
const GUID IID_IQueryRecentWinSATAssessment = GUIDOF!IQueryRecentWinSATAssessment;
const GUID IID_IWinSATInitiateEvents        = GUIDOF!IWinSATInitiateEvents;
