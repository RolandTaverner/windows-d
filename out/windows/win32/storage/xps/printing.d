// Written in the D programming language.

module windows.win32.storage.xps.printing;

public import windows.core;
public import system.system : Guid;
public import windows.win32.foundation.foundation : BOOL, HANDLE, HRESULT, PWSTR;
public import windows.win32.storage.xps.xps : IXpsOMPackageTarget;
public import windows.win32.system.com.com : IDispatch, ISequentialStream, IStream,
                                             IUnknown;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsprint/ne-xpsprint-xps_job_completion
alias XPS_JOB_COMPLETION = int;
enum : int
{
    XPS_JOB_IN_PROGRESS = 0x00000000,
    XPS_JOB_COMPLETED   = 0x00000001,
    XPS_JOB_CANCELLED   = 0x00000002,
    XPS_JOB_FAILED      = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/documenttarget/ne-documenttarget-printdocumentpackagecompletion
enum PrintDocumentPackageCompletion : int
{
    PrintDocumentPackageCompletion_InProgress = 0x00000000,
    PrintDocumentPackageCompletion_Completed  = 0x00000001,
    PrintDocumentPackageCompletion_Canceled   = 0x00000002,
    PrintDocumentPackageCompletion_Failed     = 0x00000003,
}

// Constants


enum : GUID
{
    ID_DOCUMENTPACKAGETARGET_MSXPS           = GUID("9cae40a8-ded1-41c9-a9fd-d735ef33aeda"),
    ID_DOCUMENTPACKAGETARGET_OPENXPS         = GUID("0056bb72-8c9c-4612-bd0f-93012a87099d"),
    ID_DOCUMENTPACKAGETARGET_OPENXPS_WITH_3D = GUID("63dbd720-8b14-4577-b074-7bb11b596d28"),
}

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsprint/ns-xpsprint-xps_job_status
struct XPS_JOB_STATUS
{
    uint               jobId;
    int                currentDocument;
    int                currentPage;
    int                currentPageTotal;
    XPS_JOB_COMPLETION completion;
    HRESULT            jobStatus;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/documenttarget/ns-documenttarget-printdocumentpackagestatus
struct PrintDocumentPackageStatus
{
    uint    JobId;
    int     CurrentDocument;
    int     CurrentPage;
    int     CurrentPageTotal;
    PrintDocumentPackageCompletion Completion;
    HRESULT PackageStatus;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("XPSPRINT.dll")
HRESULT StartXpsPrintJob(const(PWSTR) printerName, const(PWSTR) jobName, const(PWSTR) outputFileName, 
                         HANDLE progressEvent, HANDLE completionEvent, ubyte* printablePagesOn, 
                         uint printablePagesOnCount, IXpsPrintJob* xpsPrintJob, IXpsPrintJobStream* documentStream, 
                         IXpsPrintJobStream* printTicketStream);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("XPSPRINT.dll")
HRESULT StartXpsPrintJob1(const(PWSTR) printerName, const(PWSTR) jobName, const(PWSTR) outputFileName, 
                          HANDLE progressEvent, HANDLE completionEvent, IXpsPrintJob* xpsPrintJob, 
                          IXpsOMPackageTarget* printContentReceiver);


// Interfaces

@GUID("4842669e-9947-46ea-8ba2-d8cce432c2ca")
struct PrintDocumentPackageTarget;

@GUID("348ef17d-6c81-4982-92b4-ee188a43867a")
struct PrintDocumentPackageTargetFactory;

@GUID("7a77dc5f-45d6-4dff-9307-d8cb846347ca")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsprint/nn-xpsprint-ixpsprintjobstream
interface IXpsPrintJobStream : ISequentialStream
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsprint/nf-xpsprint-ixpsprintjobstream-close
    HRESULT Close();
}

@GUID("5ab89b06-8194-425f-ab3b-d7a96e350161")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsprint/nn-xpsprint-ixpsprintjob
interface IXpsPrintJob : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsprint/nf-xpsprint-ixpsprintjob-cancel
    HRESULT Cancel();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsprint/nf-xpsprint-ixpsprintjob-getjobstatus
    HRESULT GetJobStatus(XPS_JOB_STATUS* jobStatus);
}

@GUID("1b8efec4-3019-4c27-964e-367202156906")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/documenttarget/nn-documenttarget-iprintdocumentpackagetarget
interface IPrintDocumentPackageTarget : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/documenttarget/nf-documenttarget-iprintdocumentpackagetarget-getpackagetargettypes
    HRESULT GetPackageTargetTypes(uint* targetCount, GUID** targetTypes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/documenttarget/nf-documenttarget-iprintdocumentpackagetarget-getpackagetarget
    HRESULT GetPackageTarget(const(GUID)* guidTargetType, const(GUID)* riid, void** ppvTarget);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/documenttarget/nf-documenttarget-iprintdocumentpackagetarget-cancel
    HRESULT Cancel();
}

@GUID("c560298a-535c-48f9-866a-632540660cb4")
interface IPrintDocumentPackageTarget2 : IUnknown
{
    HRESULT GetIsTargetIppPrinter(BOOL* isIppPrinter);
    HRESULT GetTargetIppPrintDevice(const(GUID)* riid, void** ppvTarget);
}

@GUID("ed90c8ad-5c34-4d05-a1ec-0e8a9b3ad7af")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/documenttarget/nn-documenttarget-iprintdocumentpackagestatusevent
interface IPrintDocumentPackageStatusEvent : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/documenttarget/nf-documenttarget-iprintdocumentpackagestatusevent-packagestatusupdated
    HRESULT PackageStatusUpdated(PrintDocumentPackageStatus* packageStatus);
}

@GUID("d2959bf7-b31b-4a3d-9600-712eb1335ba4")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/documenttarget/nn-documenttarget-iprintdocumentpackagetargetfactory
interface IPrintDocumentPackageTargetFactory : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/documenttarget/nf-documenttarget-iprintdocumentpackagetargetfactory-createdocumentpackagetargetforprintjob
    HRESULT CreateDocumentPackageTargetForPrintJob(const(PWSTR) printerName, const(PWSTR) jobName, 
                                                   IStream jobOutputStream, IStream jobPrintTicketStream, 
                                                   IPrintDocumentPackageTarget* docPackageTarget);
}


// GUIDs

const GUID CLSID_PrintDocumentPackageTarget        = GUIDOF!PrintDocumentPackageTarget;
const GUID CLSID_PrintDocumentPackageTargetFactory = GUIDOF!PrintDocumentPackageTargetFactory;

const GUID IID_IPrintDocumentPackageStatusEvent   = GUIDOF!IPrintDocumentPackageStatusEvent;
const GUID IID_IPrintDocumentPackageTarget        = GUIDOF!IPrintDocumentPackageTarget;
const GUID IID_IPrintDocumentPackageTarget2       = GUIDOF!IPrintDocumentPackageTarget2;
const GUID IID_IPrintDocumentPackageTargetFactory = GUIDOF!IPrintDocumentPackageTargetFactory;
const GUID IID_IXpsPrintJob                       = GUIDOF!IXpsPrintJob;
const GUID IID_IXpsPrintJobStream                 = GUIDOF!IXpsPrintJobStream;
