// Written in the D programming language.

module windows.win32.system.winrt.xaml;

public import windows.core;
public import system.system : Guid;
public import windows.win32.foundation.foundation : BOOL, HANDLE, HRESULT, HWND, POINT,
                                                    RECT;
public import windows.win32.graphics.dxgi.dxgi : IDXGIDevice, IDXGISurface, IDXGISwapChain;
public import windows.win32.system.com.com : IUnknown;
public import windows.win32.ui.windowsandmessaging : MSG;

extern(Windows) @nogc nothrow:


// Enums


alias XAML_REFERENCETRACKER_DISCONNECT = int;
enum : int
{
    XAML_REFERENCETRACKER_DISCONNECT_DEFAULT = 0x00000000,
    XAML_REFERENCETRACKER_DISCONNECT_SUSPEND = 0x00000001,
}

// Constants


enum uint E_SURFACE_CONTENTS_LOST = 0x802b0020U;

// Structs


struct TrackerHandle
{
    void* Value;
}

// Interfaces

@GUID("f2e9edc1-d307-4525-9886-0fafaa44163c")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.media.dxinterop/nn-windows-ui-xaml-media-dxinterop-isurfaceimagesourcenative
interface ISurfaceImageSourceNative : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.media.dxinterop/nf-windows-ui-xaml-media-dxinterop-isurfaceimagesourcenative-setdevice
    HRESULT SetDevice(IDXGIDevice device);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.media.dxinterop/nf-windows-ui-xaml-media-dxinterop-isurfaceimagesourcenative-begindraw
    HRESULT BeginDraw(RECT updateRect, IDXGISurface* surface, POINT* offset);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.media.dxinterop/nf-windows-ui-xaml-media-dxinterop-isurfaceimagesourcenative-enddraw
    HRESULT EndDraw();
}

@GUID("dbf2e947-8e6c-4254-9eee-7738f71386c9")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.media.dxinterop/nn-windows-ui-xaml-media-dxinterop-ivirtualsurfaceupdatescallbacknative
interface IVirtualSurfaceUpdatesCallbackNative : IUnknown
{
    HRESULT UpdatesNeeded();
}

@GUID("e9550983-360b-4f53-b391-afd695078691")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.media.dxinterop/nn-windows-ui-xaml-media-dxinterop-ivirtualsurfaceimagesourcenative
interface IVirtualSurfaceImageSourceNative : ISurfaceImageSourceNative
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.media.dxinterop/nf-windows-ui-xaml-media-dxinterop-ivirtualsurfaceimagesourcenative-invalidate
    HRESULT Invalidate(RECT updateRect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.media.dxinterop/nf-windows-ui-xaml-media-dxinterop-ivirtualsurfaceimagesourcenative-getupdaterectcount
    HRESULT GetUpdateRectCount(uint* count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.media.dxinterop/nf-windows-ui-xaml-media-dxinterop-ivirtualsurfaceimagesourcenative-getupdaterects
    HRESULT GetUpdateRects(RECT* updates, uint count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.media.dxinterop/nf-windows-ui-xaml-media-dxinterop-ivirtualsurfaceimagesourcenative-getvisiblebounds
    HRESULT GetVisibleBounds(RECT* bounds);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.media.dxinterop/nf-windows-ui-xaml-media-dxinterop-ivirtualsurfaceimagesourcenative-registerforupdatesneeded
    HRESULT RegisterForUpdatesNeeded(IVirtualSurfaceUpdatesCallbackNative callback);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.media.dxinterop/nf-windows-ui-xaml-media-dxinterop-ivirtualsurfaceimagesourcenative-resize
    HRESULT Resize(int newWidth, int newHeight);
}

@GUID("43bebd4e-add5-4035-8f85-5608d08e9dc9")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.media.dxinterop/nn-windows-ui-xaml-media-dxinterop-iswapchainbackgroundpanelnative
interface ISwapChainBackgroundPanelNative : IUnknown
{
    HRESULT SetSwapChain(IDXGISwapChain swapChain);
}

@GUID("4c8798b7-1d88-4a0f-b59b-b93f600de8c8")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.media.dxinterop/nn-windows-ui-xaml-media-dxinterop-isurfaceimagesourcemanagernative
interface ISurfaceImageSourceManagerNative : IUnknown
{
    HRESULT FlushAllSurfacesWithDevice(IUnknown device);
}

@GUID("54298223-41e1-4a41-9c08-02e8256864a1")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.media.dxinterop/nn-windows-ui-xaml-media-dxinterop-isurfaceimagesourcenativewithd2d
interface ISurfaceImageSourceNativeWithD2D : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.media.dxinterop/nf-windows-ui-xaml-media-dxinterop-isurfaceimagesourcenativewithd2d-setdevice
    HRESULT SetDevice(IUnknown device);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.media.dxinterop/nf-windows-ui-xaml-media-dxinterop-isurfaceimagesourcenativewithd2d-begindraw
    HRESULT BeginDraw(const(RECT)* updateRect, const(GUID)* iid, void** updateObject, POINT* offset);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.media.dxinterop/nf-windows-ui-xaml-media-dxinterop-isurfaceimagesourcenativewithd2d-enddraw
    HRESULT EndDraw();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.media.dxinterop/nf-windows-ui-xaml-media-dxinterop-isurfaceimagesourcenativewithd2d-suspenddraw
    HRESULT SuspendDraw();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.media.dxinterop/nf-windows-ui-xaml-media-dxinterop-isurfaceimagesourcenativewithd2d-resumedraw
    HRESULT ResumeDraw();
}

@GUID("f92f19d2-3ade-45a6-a20c-f6f1ea90554b")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.media.dxinterop/nn-windows-ui-xaml-media-dxinterop-iswapchainpanelnative
interface ISwapChainPanelNative : IUnknown
{
    HRESULT SetSwapChain(IDXGISwapChain swapChain);
}

@GUID("d5a2f60c-37b2-44a2-937b-8d8eb9726821")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.media.dxinterop/nn-windows-ui-xaml-media-dxinterop-iswapchainpanelnative2
interface ISwapChainPanelNative2 : ISwapChainPanelNative
{
    HRESULT SetSwapChainHandle(HANDLE swapChainHandle);
}

@GUID("3cbcf1bf-2f76-4e9c-96ab-e84b37972554")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.hosting.desktopwindowxamlsource/nn-windows-ui-xaml-hosting-desktopwindowxamlsource-idesktopwindowxamlsourcenative
interface IDesktopWindowXamlSourceNative : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.hosting.desktopwindowxamlsource/nf-windows-ui-xaml-hosting-desktopwindowxamlsource-idesktopwindowxamlsourcenative-attachtowindow
    HRESULT AttachToWindow(HWND parentWnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.hosting.desktopwindowxamlsource/nf-windows-ui-xaml-hosting-desktopwindowxamlsource-idesktopwindowxamlsourcenative-get_windowhandle
    HRESULT get_WindowHandle(HWND* hWnd);
}

@GUID("e3dcd8c7-3057-4692-99c3-7b7720afda31")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.hosting.desktopwindowxamlsource/nn-windows-ui-xaml-hosting-desktopwindowxamlsource-idesktopwindowxamlsourcenative2
interface IDesktopWindowXamlSourceNative2 : IDesktopWindowXamlSourceNative
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.hosting.desktopwindowxamlsource/nf-windows-ui-xaml-hosting-desktopwindowxamlsource-idesktopwindowxamlsourcenative2-pretranslatemessage
    HRESULT PreTranslateMessage(const(MSG)* message, BOOL* result);
}

@GUID("64bd43f8-bfee-4ec4-b7eb-2935158dae21")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.hosting.referencetracker/nn-windows-ui-xaml-hosting-referencetracker-ireferencetrackertarget
interface IReferenceTrackerTarget : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.hosting.referencetracker/nf-windows-ui-xaml-hosting-referencetracker-ireferencetrackertarget-addreffromreferencetracker
    uint    AddRefFromReferenceTracker();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.hosting.referencetracker/nf-windows-ui-xaml-hosting-referencetracker-ireferencetrackertarget-releasefromreferencetracker
    uint    ReleaseFromReferenceTracker();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.hosting.referencetracker/nf-windows-ui-xaml-hosting-referencetracker-ireferencetrackertarget-peg
    HRESULT Peg();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.hosting.referencetracker/nf-windows-ui-xaml-hosting-referencetracker-ireferencetrackertarget-unpeg
    HRESULT Unpeg();
}

@GUID("11d3b13a-180e-4789-a8be-7712882893e6")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.hosting.referencetracker/nn-windows-ui-xaml-hosting-referencetracker-ireferencetracker
interface IReferenceTracker : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.hosting.referencetracker/nf-windows-ui-xaml-hosting-referencetracker-ireferencetracker-connectfromtrackersource
    HRESULT ConnectFromTrackerSource();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.hosting.referencetracker/nf-windows-ui-xaml-hosting-referencetracker-ireferencetracker-disconnectfromtrackersource
    HRESULT DisconnectFromTrackerSource();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.hosting.referencetracker/nf-windows-ui-xaml-hosting-referencetracker-ireferencetracker-findtrackertargets
    HRESULT FindTrackerTargets(IFindReferenceTargetsCallback callback);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.hosting.referencetracker/nf-windows-ui-xaml-hosting-referencetracker-ireferencetracker-getreferencetrackermanager
    HRESULT GetReferenceTrackerManager(IReferenceTrackerManager* value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.hosting.referencetracker/nf-windows-ui-xaml-hosting-referencetracker-ireferencetracker-addreffromtrackersource
    HRESULT AddRefFromTrackerSource();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.hosting.referencetracker/nf-windows-ui-xaml-hosting-referencetracker-ireferencetracker-releasefromtrackersource
    HRESULT ReleaseFromTrackerSource();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.hosting.referencetracker/nf-windows-ui-xaml-hosting-referencetracker-ireferencetracker-pegfromtrackersource
    HRESULT PegFromTrackerSource();
}

@GUID("3cf184b4-7ccb-4dda-8455-7e6ce99a3298")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.hosting.referencetracker/nn-windows-ui-xaml-hosting-referencetracker-ireferencetrackermanager
interface IReferenceTrackerManager : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.hosting.referencetracker/nf-windows-ui-xaml-hosting-referencetracker-ireferencetrackermanager-referencetrackingstarted
    HRESULT ReferenceTrackingStarted();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.hosting.referencetracker/nf-windows-ui-xaml-hosting-referencetracker-ireferencetrackermanager-findtrackertargetscompleted
    HRESULT FindTrackerTargetsCompleted(ubyte findFailed);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.hosting.referencetracker/nf-windows-ui-xaml-hosting-referencetracker-ireferencetrackermanager-referencetrackingcompleted
    HRESULT ReferenceTrackingCompleted();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.hosting.referencetracker/nf-windows-ui-xaml-hosting-referencetracker-ireferencetrackermanager-setreferencetrackerhost
    HRESULT SetReferenceTrackerHost(IReferenceTrackerHost value);
}

@GUID("04b3486c-4687-4229-8d14-505ab584dd88")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.hosting.referencetracker/nn-windows-ui-xaml-hosting-referencetracker-ifindreferencetargetscallback
interface IFindReferenceTargetsCallback : IUnknown
{
    HRESULT FoundTrackerTarget(IReferenceTrackerTarget target);
}

@GUID("29a71c6a-3c42-4416-a39d-e2825a07a773")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.hosting.referencetracker/nn-windows-ui-xaml-hosting-referencetracker-ireferencetrackerhost
interface IReferenceTrackerHost : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.hosting.referencetracker/nf-windows-ui-xaml-hosting-referencetracker-ireferencetrackerhost-disconnectunusedreferencesources
    HRESULT DisconnectUnusedReferenceSources(XAML_REFERENCETRACKER_DISCONNECT options);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.hosting.referencetracker/nf-windows-ui-xaml-hosting-referencetracker-ireferencetrackerhost-releasedisconnectedreferencesources
    HRESULT ReleaseDisconnectedReferenceSources();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.hosting.referencetracker/nf-windows-ui-xaml-hosting-referencetracker-ireferencetrackerhost-notifyendofreferencetrackingonthread
    HRESULT NotifyEndOfReferenceTrackingOnThread();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.hosting.referencetracker/nf-windows-ui-xaml-hosting-referencetracker-ireferencetrackerhost-gettrackertarget
    HRESULT GetTrackerTarget(IUnknown unknown, IReferenceTrackerTarget* newReference);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.hosting.referencetracker/nf-windows-ui-xaml-hosting-referencetracker-ireferencetrackerhost-addmemorypressure
    HRESULT AddMemoryPressure(ulong bytesAllocated);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.xaml.hosting.referencetracker/nf-windows-ui-xaml-hosting-referencetracker-ireferencetrackerhost-removememorypressure
    HRESULT RemoveMemoryPressure(ulong bytesAllocated);
}

@GUID("4e897caa-59d5-4613-8f8c-f7ebd1f399b0")
interface IReferenceTrackerExtension : IUnknown
{
}

@GUID("eb24c20b-9816-4ac7-8cff-36f67a118f4e")
interface ITrackerOwner : IUnknown
{
    HRESULT CreateTrackerHandle(TrackerHandle* returnValue);
    HRESULT DeleteTrackerHandle(TrackerHandle handle);
    HRESULT SetTrackerValue(TrackerHandle handle, IUnknown value);
    ubyte   TryGetSafeTrackerValue(TrackerHandle handle, IUnknown* returnValue);
}


// GUIDs


const GUID IID_IDesktopWindowXamlSourceNative       = GUIDOF!IDesktopWindowXamlSourceNative;
const GUID IID_IDesktopWindowXamlSourceNative2      = GUIDOF!IDesktopWindowXamlSourceNative2;
const GUID IID_IFindReferenceTargetsCallback        = GUIDOF!IFindReferenceTargetsCallback;
const GUID IID_IReferenceTracker                    = GUIDOF!IReferenceTracker;
const GUID IID_IReferenceTrackerExtension           = GUIDOF!IReferenceTrackerExtension;
const GUID IID_IReferenceTrackerHost                = GUIDOF!IReferenceTrackerHost;
const GUID IID_IReferenceTrackerManager             = GUIDOF!IReferenceTrackerManager;
const GUID IID_IReferenceTrackerTarget              = GUIDOF!IReferenceTrackerTarget;
const GUID IID_ISurfaceImageSourceManagerNative     = GUIDOF!ISurfaceImageSourceManagerNative;
const GUID IID_ISurfaceImageSourceNative            = GUIDOF!ISurfaceImageSourceNative;
const GUID IID_ISurfaceImageSourceNativeWithD2D     = GUIDOF!ISurfaceImageSourceNativeWithD2D;
const GUID IID_ISwapChainBackgroundPanelNative      = GUIDOF!ISwapChainBackgroundPanelNative;
const GUID IID_ISwapChainPanelNative                = GUIDOF!ISwapChainPanelNative;
const GUID IID_ISwapChainPanelNative2               = GUIDOF!ISwapChainPanelNative2;
const GUID IID_ITrackerOwner                        = GUIDOF!ITrackerOwner;
const GUID IID_IVirtualSurfaceImageSourceNative     = GUIDOF!IVirtualSurfaceImageSourceNative;
const GUID IID_IVirtualSurfaceUpdatesCallbackNative = GUIDOF!IVirtualSurfaceUpdatesCallbackNative;
