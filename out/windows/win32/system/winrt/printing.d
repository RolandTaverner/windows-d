// Written in the D programming language.

module windows.win32.system.winrt.printing;

public import windows.core;
public import system : Guid;
public import windows.win32.foundation : HRESULT, HWND, PWSTR;
public import windows.win32.graphics.printing : IPrinterPropertyBag, IPrinterQueue;
public import windows.win32.storage.xps : IXpsDocumentPackageTarget, IXpsOMObjectFactory1,
                                          IXpsOMPageReference;
public import windows.win32.storage.xps.printing : IPrintDocumentPackageTarget;
public import windows.win32.system.com : IStream, IUnknown;
public import windows.win32.system.winrt : IInspectable;

extern(Windows) @nogc nothrow:


// Interfaces

@GUID("9ca31010-1484-4587-b26b-dddf9f9caecd")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/print3dmanagerinterop/nn-print3dmanagerinterop-iprinting3dmanagerinterop))], [])
interface IPrinting3DManagerInterop : IInspectable
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/print3dmanagerinterop/nf-print3dmanagerinterop-iprinting3dmanagerinterop-getforwindow))], [])
    HRESULT GetForWindow(HWND appWindow, const(GUID)* riid, void** printManager);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/print3dmanagerinterop/nf-print3dmanagerinterop-iprinting3dmanagerinterop-showprintuiforwindowasync))], [])
    HRESULT ShowPrintUIForWindowAsync(HWND appWindow, const(GUID)* riid, void** asyncOperation);
}

@GUID("c5435a42-8d43-4e7b-a68a-ef311e392087")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/printmanagerinterop/nn-printmanagerinterop-iprintmanagerinterop))], [])
interface IPrintManagerInterop : IInspectable
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/printmanagerinterop/nf-printmanagerinterop-iprintmanagerinterop-getforwindow))], [])
    HRESULT GetForWindow(HWND appWindow, const(GUID)* riid, void** printManager);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/printmanagerinterop/nf-printmanagerinterop-iprintmanagerinterop-showprintuiforwindowasync))], [])
    HRESULT ShowPrintUIForWindowAsync(HWND appWindow, const(GUID)* riid, void** asyncOperation);
}

@GUID("0b31cc62-d7ec-4747-9d6e-f2537d870f2b")
interface IPrintPreviewPageCollection : IUnknown
{
    HRESULT Paginate(uint currentJobPage, IInspectable printTaskOptions);
    HRESULT MakePage(uint desiredJobPage, float width, float height);
}

@GUID("a96bb1db-172e-4667-82b5-ad97a252318f")
interface IPrintDocumentPageSource : IUnknown
{
    HRESULT GetPreviewPageCollection(IPrintDocumentPackageTarget docPackageTarget, 
                                     IPrintPreviewPageCollection* docPageCollection);
    HRESULT MakeDocument(IInspectable printTaskOptions, IPrintDocumentPackageTarget docPackageTarget);
}

@GUID("04097374-77b8-47f6-8167-aae29d4cf84b")
interface IPrintWorkflowXpsReceiver : IUnknown
{
    HRESULT SetDocumentSequencePrintTicket(IStream documentSequencePrintTicket);
    HRESULT SetDocumentSequenceUri(const(PWSTR) documentSequenceUri);
    HRESULT AddDocumentData(uint documentId, IStream documentPrintTicket, const(PWSTR) documentUri);
    HRESULT AddPage(uint documentId, uint pageId, IXpsOMPageReference pageReference, const(PWSTR) pageUri);
    HRESULT Close();
}

@GUID("023bcc0c-dfab-4a61-b074-490c6995580d")
interface IPrintWorkflowXpsReceiver2 : IPrintWorkflowXpsReceiver
{
    HRESULT Failed(HRESULT XpsError);
}

@GUID("68c9e477-993e-4052-8ac6-454eff58db9d")
interface IPrintWorkflowObjectModelSourceFileContentNative : IUnknown
{
    HRESULT StartXpsOMGeneration(IPrintWorkflowXpsReceiver receiver);
    HRESULT get_ObjectFactory(IXpsOMObjectFactory1* value);
}

@GUID("7d96bc74-9b54-4ca1-ad3a-979c3d44ddac")
interface IPrintWorkflowXpsObjectModelTargetPackageNative : IUnknown
{
    HRESULT get_DocumentPackageTarget(IXpsDocumentPackageTarget* value);
}

@GUID("c056be0a-9ee2-450a-9823-964f0006f2bb")
interface IPrintWorkflowConfigurationNative : IUnknown
{
    HRESULT get_PrinterQueue(IPrinterQueue* value);
    HRESULT get_DriverProperties(IPrinterPropertyBag* value);
    HRESULT get_UserProperties(IPrinterPropertyBag* value);
}


// GUIDs


const GUID IID_IPrintDocumentPageSource                         = GUIDOF!IPrintDocumentPageSource;
const GUID IID_IPrintManagerInterop                             = GUIDOF!IPrintManagerInterop;
const GUID IID_IPrintPreviewPageCollection                      = GUIDOF!IPrintPreviewPageCollection;
const GUID IID_IPrintWorkflowConfigurationNative                = GUIDOF!IPrintWorkflowConfigurationNative;
const GUID IID_IPrintWorkflowObjectModelSourceFileContentNative = GUIDOF!IPrintWorkflowObjectModelSourceFileContentNative;
const GUID IID_IPrintWorkflowXpsObjectModelTargetPackageNative  = GUIDOF!IPrintWorkflowXpsObjectModelTargetPackageNative;
const GUID IID_IPrintWorkflowXpsReceiver                        = GUIDOF!IPrintWorkflowXpsReceiver;
const GUID IID_IPrintWorkflowXpsReceiver2                       = GUIDOF!IPrintWorkflowXpsReceiver2;
const GUID IID_IPrinting3DManagerInterop                        = GUIDOF!IPrinting3DManagerInterop;
