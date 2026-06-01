// Written in the D programming language.

module windows.win32.graphics.directmanipulation;

public import windows.core;
public import windows.win32.foundation.foundation : BOOL, HANDLE, HRESULT, HWND, RECT;
public import windows.win32.system.com.com : IUnknown;
public import windows.win32.ui.windowsandmessaging : MSG;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/ne-directmanipulation-directmanipulation_status
alias DIRECTMANIPULATION_STATUS = int;
enum : int
{
    DIRECTMANIPULATION_BUILDING  = 0x00000000,
    DIRECTMANIPULATION_ENABLED   = 0x00000001,
    DIRECTMANIPULATION_DISABLED  = 0x00000002,
    DIRECTMANIPULATION_RUNNING   = 0x00000003,
    DIRECTMANIPULATION_INERTIA   = 0x00000004,
    DIRECTMANIPULATION_READY     = 0x00000005,
    DIRECTMANIPULATION_SUSPENDED = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/ne-directmanipulation-directmanipulation_hittest_type
alias DIRECTMANIPULATION_HITTEST_TYPE = int;
enum : int
{
    DIRECTMANIPULATION_HITTEST_TYPE_ASYNCHRONOUS     = 0x00000000,
    DIRECTMANIPULATION_HITTEST_TYPE_SYNCHRONOUS      = 0x00000001,
    DIRECTMANIPULATION_HITTEST_TYPE_AUTO_SYNCHRONOUS = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/ne-directmanipulation-directmanipulation_configuration
alias DIRECTMANIPULATION_CONFIGURATION = int;
enum : int
{
    DIRECTMANIPULATION_CONFIGURATION_NONE                = 0x00000000,
    DIRECTMANIPULATION_CONFIGURATION_INTERACTION         = 0x00000001,
    DIRECTMANIPULATION_CONFIGURATION_TRANSLATION_X       = 0x00000002,
    DIRECTMANIPULATION_CONFIGURATION_TRANSLATION_Y       = 0x00000004,
    DIRECTMANIPULATION_CONFIGURATION_SCALING             = 0x00000010,
    DIRECTMANIPULATION_CONFIGURATION_TRANSLATION_INERTIA = 0x00000020,
    DIRECTMANIPULATION_CONFIGURATION_SCALING_INERTIA     = 0x00000080,
    DIRECTMANIPULATION_CONFIGURATION_RAILS_X             = 0x00000100,
    DIRECTMANIPULATION_CONFIGURATION_RAILS_Y             = 0x00000200,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/ne-directmanipulation-directmanipulation_gesture_configuration
alias DIRECTMANIPULATION_GESTURE_CONFIGURATION = int;
enum : int
{
    DIRECTMANIPULATION_GESTURE_NONE                   = 0x00000000,
    DIRECTMANIPULATION_GESTURE_DEFAULT                = 0x00000000,
    DIRECTMANIPULATION_GESTURE_CROSS_SLIDE_VERTICAL   = 0x00000008,
    DIRECTMANIPULATION_GESTURE_CROSS_SLIDE_HORIZONTAL = 0x00000010,
    DIRECTMANIPULATION_GESTURE_PINCH_ZOOM             = 0x00000020,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/ne-directmanipulation-directmanipulation_motion_types
alias DIRECTMANIPULATION_MOTION_TYPES = int;
enum : int
{
    DIRECTMANIPULATION_MOTION_NONE       = 0x00000000,
    DIRECTMANIPULATION_MOTION_TRANSLATEX = 0x00000001,
    DIRECTMANIPULATION_MOTION_TRANSLATEY = 0x00000002,
    DIRECTMANIPULATION_MOTION_ZOOM       = 0x00000004,
    DIRECTMANIPULATION_MOTION_CENTERX    = 0x00000010,
    DIRECTMANIPULATION_MOTION_CENTERY    = 0x00000020,
    DIRECTMANIPULATION_MOTION_ALL        = 0x00000037,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/ne-directmanipulation-directmanipulation_viewport_options
alias DIRECTMANIPULATION_VIEWPORT_OPTIONS = int;
enum : int
{
    DIRECTMANIPULATION_VIEWPORT_OPTIONS_DEFAULT              = 0x00000000,
    DIRECTMANIPULATION_VIEWPORT_OPTIONS_AUTODISABLE          = 0x00000001,
    DIRECTMANIPULATION_VIEWPORT_OPTIONS_MANUALUPDATE         = 0x00000002,
    DIRECTMANIPULATION_VIEWPORT_OPTIONS_INPUT                = 0x00000004,
    DIRECTMANIPULATION_VIEWPORT_OPTIONS_EXPLICITHITTEST      = 0x00000008,
    DIRECTMANIPULATION_VIEWPORT_OPTIONS_DISABLEPIXELSNAPPING = 0x00000010,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/ne-directmanipulation-directmanipulation_snappoint_type
alias DIRECTMANIPULATION_SNAPPOINT_TYPE = int;
enum : int
{
    DIRECTMANIPULATION_SNAPPOINT_MANDATORY        = 0x00000000,
    DIRECTMANIPULATION_SNAPPOINT_OPTIONAL         = 0x00000001,
    DIRECTMANIPULATION_SNAPPOINT_MANDATORY_SINGLE = 0x00000002,
    DIRECTMANIPULATION_SNAPPOINT_OPTIONAL_SINGLE  = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/ne-directmanipulation-directmanipulation_snappoint_coordinate
alias DIRECTMANIPULATION_SNAPPOINT_COORDINATE = int;
enum : int
{
    DIRECTMANIPULATION_COORDINATE_BOUNDARY = 0x00000000,
    DIRECTMANIPULATION_COORDINATE_ORIGIN   = 0x00000001,
    DIRECTMANIPULATION_COORDINATE_MIRRORED = 0x00000010,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/ne-directmanipulation-directmanipulation_horizontalalignment
alias DIRECTMANIPULATION_HORIZONTALALIGNMENT = int;
enum : int
{
    DIRECTMANIPULATION_HORIZONTALALIGNMENT_NONE         = 0x00000000,
    DIRECTMANIPULATION_HORIZONTALALIGNMENT_LEFT         = 0x00000001,
    DIRECTMANIPULATION_HORIZONTALALIGNMENT_CENTER       = 0x00000002,
    DIRECTMANIPULATION_HORIZONTALALIGNMENT_RIGHT        = 0x00000004,
    DIRECTMANIPULATION_HORIZONTALALIGNMENT_UNLOCKCENTER = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/ne-directmanipulation-directmanipulation_verticalalignment
alias DIRECTMANIPULATION_VERTICALALIGNMENT = int;
enum : int
{
    DIRECTMANIPULATION_VERTICALALIGNMENT_NONE         = 0x00000000,
    DIRECTMANIPULATION_VERTICALALIGNMENT_TOP          = 0x00000001,
    DIRECTMANIPULATION_VERTICALALIGNMENT_CENTER       = 0x00000002,
    DIRECTMANIPULATION_VERTICALALIGNMENT_BOTTOM       = 0x00000004,
    DIRECTMANIPULATION_VERTICALALIGNMENT_UNLOCKCENTER = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/ne-directmanipulation-directmanipulation_input_mode
alias DIRECTMANIPULATION_INPUT_MODE = int;
enum : int
{
    DIRECTMANIPULATION_INPUT_MODE_AUTOMATIC = 0x00000000,
    DIRECTMANIPULATION_INPUT_MODE_MANUAL    = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/ne-directmanipulation-directmanipulation_drag_drop_status
alias DIRECTMANIPULATION_DRAG_DROP_STATUS = int;
enum : int
{
    DIRECTMANIPULATION_DRAG_DROP_READY     = 0x00000000,
    DIRECTMANIPULATION_DRAG_DROP_PRESELECT = 0x00000001,
    DIRECTMANIPULATION_DRAG_DROP_SELECTING = 0x00000002,
    DIRECTMANIPULATION_DRAG_DROP_DRAGGING  = 0x00000003,
    DIRECTMANIPULATION_DRAG_DROP_CANCELLED = 0x00000004,
    DIRECTMANIPULATION_DRAG_DROP_COMMITTED = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/ne-directmanipulation-directmanipulation_drag_drop_configuration
alias DIRECTMANIPULATION_DRAG_DROP_CONFIGURATION = int;
enum : int
{
    DIRECTMANIPULATION_DRAG_DROP_CONFIGURATION_VERTICAL    = 0x00000001,
    DIRECTMANIPULATION_DRAG_DROP_CONFIGURATION_HORIZONTAL  = 0x00000002,
    DIRECTMANIPULATION_DRAG_DROP_CONFIGURATION_SELECT_ONLY = 0x00000010,
    DIRECTMANIPULATION_DRAG_DROP_CONFIGURATION_SELECT_DRAG = 0x00000020,
    DIRECTMANIPULATION_DRAG_DROP_CONFIGURATION_HOLD_DRAG   = 0x00000040,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/ne-directmanipulation-directmanipulation_interaction_type
alias DIRECTMANIPULATION_INTERACTION_TYPE = int;
enum : int
{
    DIRECTMANIPULATION_INTERACTION_BEGIN                    = 0x00000000,
    DIRECTMANIPULATION_INTERACTION_TYPE_MANIPULATION        = 0x00000001,
    DIRECTMANIPULATION_INTERACTION_TYPE_GESTURE_TAP         = 0x00000002,
    DIRECTMANIPULATION_INTERACTION_TYPE_GESTURE_HOLD        = 0x00000003,
    DIRECTMANIPULATION_INTERACTION_TYPE_GESTURE_CROSS_SLIDE = 0x00000004,
    DIRECTMANIPULATION_INTERACTION_TYPE_GESTURE_PINCH_ZOOM  = 0x00000005,
    DIRECTMANIPULATION_INTERACTION_END                      = 0x00000064,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/ne-directmanipulation-directmanipulation_autoscroll_configuration
alias DIRECTMANIPULATION_AUTOSCROLL_CONFIGURATION = int;
enum : int
{
    DIRECTMANIPULATION_AUTOSCROLL_CONFIGURATION_STOP    = 0x00000000,
    DIRECTMANIPULATION_AUTOSCROLL_CONFIGURATION_FORWARD = 0x00000001,
    DIRECTMANIPULATION_AUTOSCROLL_CONFIGURATION_REVERSE = 0x00000002,
}

// Constants


enum : uint
{
    DIRECTMANIPULATION_KEYBOARDFOCUS = 0xfffffffeU,
    DIRECTMANIPULATION_MOUSEFOCUS    = 0xfffffffdU,
}

enum GUID CLSID_VerticalIndicatorContent = GUID("a10b5f17-afe0-4aa2-91e9-3e7001d2e6b4");
enum GUID CLSID_HorizontalIndicatorContent = GUID("e7d18cf5-3ec7-44d5-a76b-3770f3cf903d");
enum GUID CLSID_VirtualViewportContent = GUID("3206a19a-86f0-4cb4-a7f3-16e3b7e2d852");
enum GUID CLSID_DragDropConfigurationBehavior = GUID("09b01b3e-ba6c-454d-82e8-95e352329f23");
enum GUID CLSID_AutoScrollBehavior = GUID("26126a51-3c70-4c9a-aec2-948849eeb093");
enum GUID CLSID_DeferContactService = GUID("d7b67cf4-84bb-434e-86ae-6592bbc9abd9");

// Interfaces

@GUID("34e211b6-3650-4f75-8334-fa359598e1c5")
struct DirectManipulationViewport;

@GUID("9fc1bfd5-1835-441a-b3b1-b6cc74b727d0")
struct DirectManipulationUpdateManager;

@GUID("caa02661-d59e-41c7-8393-3ba3bacb6b57")
struct DirectManipulationPrimaryContent;

@GUID("54e211b6-3650-4f75-8334-fa359598e1c5")
struct DirectManipulationManager;

@GUID("99793286-77cc-4b57-96db-3b354f6f9fb5")
struct DirectManipulationSharedManager;

@GUID("79dea627-a08a-43ac-8ef5-6900b9299126")
struct DCompManipulationCompositor;

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nn-directmanipulation-idirectmanipulationmanager
@GUID("fbf5d3b4-70c7-4163-9322-5a6f660d6fbc")
interface IDirectManipulationManager : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationmanager-activate
    HRESULT Activate(HWND window);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationmanager-deactivate
    HRESULT Deactivate(HWND window);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationmanager-registerhittesttarget
    HRESULT RegisterHitTestTarget(HWND window, HWND hitTestWindow, DIRECTMANIPULATION_HITTEST_TYPE type);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationmanager-processinput
    HRESULT ProcessInput(const(MSG)* message, BOOL* handled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationmanager-getupdatemanager
    HRESULT GetUpdateManager(const(GUID)* riid, void** object);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationmanager-createviewport
    HRESULT CreateViewport(IDirectManipulationFrameInfoProvider frameInfo, HWND window, const(GUID)* riid, 
                           void** object);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationmanager-createcontent
    HRESULT CreateContent(IDirectManipulationFrameInfoProvider frameInfo, const(GUID)* clsid, const(GUID)* riid, 
                          void** object);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nn-directmanipulation-idirectmanipulationmanager2
@GUID("fa1005e9-3d16-484c-bfc9-62b61e56ec4e")
interface IDirectManipulationManager2 : IDirectManipulationManager
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationmanager2-createbehavior
    HRESULT CreateBehavior(const(GUID)* clsid, const(GUID)* riid, void** object);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nn-directmanipulation-idirectmanipulationmanager3
@GUID("2cb6b33d-ffe8-488c-b750-fbdfe88dca8c")
interface IDirectManipulationManager3 : IDirectManipulationManager2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationmanager3-getservice
    HRESULT GetService(const(GUID)* clsid, const(GUID)* riid, void** object);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nn-directmanipulation-idirectmanipulationviewport
@GUID("28b85a3d-60a0-48bd-9ba1-5ce8d9ea3a6d")
interface IDirectManipulationViewport : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationviewport-enable
    HRESULT Enable();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationviewport-disable
    HRESULT Disable();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationviewport-setcontact
    HRESULT SetContact(uint pointerId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationviewport-releasecontact
    HRESULT ReleaseContact(uint pointerId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationviewport-releaseallcontacts
    HRESULT ReleaseAllContacts();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationviewport-getstatus
    HRESULT GetStatus(DIRECTMANIPULATION_STATUS* status);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationviewport-gettag
    HRESULT GetTag(const(GUID)* riid, void** object, uint* id);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationviewport-settag
    HRESULT SetTag(IUnknown object, uint id);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationviewport-getviewportrect
    HRESULT GetViewportRect(RECT* viewport);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationviewport-setviewportrect
    HRESULT SetViewportRect(const(RECT)* viewport);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationviewport-zoomtorect
    HRESULT ZoomToRect(const(float) left, const(float) top, const(float) right, const(float) bottom, BOOL animate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationviewport-setviewporttransform
    HRESULT SetViewportTransform(const(float)* matrix, uint pointCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationviewport-syncdisplaytransform
    HRESULT SyncDisplayTransform(const(float)* matrix, uint pointCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationviewport-getprimarycontent
    HRESULT GetPrimaryContent(const(GUID)* riid, void** object);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationviewport-addcontent
    HRESULT AddContent(IDirectManipulationContent content);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationviewport-removecontent
    HRESULT RemoveContent(IDirectManipulationContent content);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationviewport-setviewportoptions
    HRESULT SetViewportOptions(DIRECTMANIPULATION_VIEWPORT_OPTIONS options);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationviewport-addconfiguration
    HRESULT AddConfiguration(DIRECTMANIPULATION_CONFIGURATION configuration);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationviewport-removeconfiguration
    HRESULT RemoveConfiguration(DIRECTMANIPULATION_CONFIGURATION configuration);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationviewport-activateconfiguration
    HRESULT ActivateConfiguration(DIRECTMANIPULATION_CONFIGURATION configuration);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationviewport-setmanualgesture
    HRESULT SetManualGesture(DIRECTMANIPULATION_GESTURE_CONFIGURATION configuration);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationviewport-setchaining
    HRESULT SetChaining(DIRECTMANIPULATION_MOTION_TYPES enabledTypes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationviewport-addeventhandler
    HRESULT AddEventHandler(HWND window, IDirectManipulationViewportEventHandler eventHandler, uint* cookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationviewport-removeeventhandler
    HRESULT RemoveEventHandler(uint cookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationviewport-setinputmode
    HRESULT SetInputMode(DIRECTMANIPULATION_INPUT_MODE mode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationviewport-setupdatemode
    HRESULT SetUpdateMode(DIRECTMANIPULATION_INPUT_MODE mode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationviewport-stop
    HRESULT Stop();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationviewport-abandon
    HRESULT Abandon();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nn-directmanipulation-idirectmanipulationviewport2
@GUID("923ccaac-61e1-4385-b726-017af189882a")
interface IDirectManipulationViewport2 : IDirectManipulationViewport
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationviewport2-addbehavior
    HRESULT AddBehavior(IUnknown behavior, uint* cookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationviewport2-removebehavior
    HRESULT RemoveBehavior(uint cookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationviewport2-removeallbehaviors
    HRESULT RemoveAllBehaviors();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nn-directmanipulation-idirectmanipulationviewporteventhandler
@GUID("952121da-d69f-45f9-b0f9-f23944321a6d")
interface IDirectManipulationViewportEventHandler : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationviewporteventhandler-onviewportstatuschanged
    HRESULT OnViewportStatusChanged(IDirectManipulationViewport viewport, DIRECTMANIPULATION_STATUS current, 
                                    DIRECTMANIPULATION_STATUS previous);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationviewporteventhandler-onviewportupdated
    HRESULT OnViewportUpdated(IDirectManipulationViewport viewport);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationviewporteventhandler-oncontentupdated
    HRESULT OnContentUpdated(IDirectManipulationViewport viewport, IDirectManipulationContent content);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nn-directmanipulation-idirectmanipulationcontent
@GUID("b89962cb-3d89-442b-bb58-5098fa0f9f16")
interface IDirectManipulationContent : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationcontent-getcontentrect
    HRESULT GetContentRect(RECT* contentSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationcontent-setcontentrect
    HRESULT SetContentRect(const(RECT)* contentSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationcontent-getviewport
    HRESULT GetViewport(const(GUID)* riid, void** object);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationcontent-gettag
    HRESULT GetTag(const(GUID)* riid, void** object, uint* id);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationcontent-settag
    HRESULT SetTag(IUnknown object, uint id);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationcontent-getoutputtransform
    HRESULT GetOutputTransform(float* matrix, uint pointCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationcontent-getcontenttransform
    HRESULT GetContentTransform(float* matrix, uint pointCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationcontent-synccontenttransform
    HRESULT SyncContentTransform(const(float)* matrix, uint pointCount);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nn-directmanipulation-idirectmanipulationprimarycontent
@GUID("c12851e4-1698-4625-b9b1-7ca3ec18630b")
interface IDirectManipulationPrimaryContent : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationprimarycontent-setsnapinterval
    HRESULT SetSnapInterval(DIRECTMANIPULATION_MOTION_TYPES motion, float interval, float offset);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationprimarycontent-setsnappoints
    HRESULT SetSnapPoints(DIRECTMANIPULATION_MOTION_TYPES motion, const(float)* points, uint pointCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationprimarycontent-setsnaptype
    HRESULT SetSnapType(DIRECTMANIPULATION_MOTION_TYPES motion, DIRECTMANIPULATION_SNAPPOINT_TYPE type);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationprimarycontent-setsnapcoordinate
    HRESULT SetSnapCoordinate(DIRECTMANIPULATION_MOTION_TYPES motion, 
                              DIRECTMANIPULATION_SNAPPOINT_COORDINATE coordinate, float origin);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationprimarycontent-setzoomboundaries
    HRESULT SetZoomBoundaries(float zoomMinimum, float zoomMaximum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationprimarycontent-sethorizontalalignment
    HRESULT SetHorizontalAlignment(DIRECTMANIPULATION_HORIZONTALALIGNMENT alignment);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationprimarycontent-setverticalalignment
    HRESULT SetVerticalAlignment(DIRECTMANIPULATION_VERTICALALIGNMENT alignment);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationprimarycontent-getinertiaendtransform
    HRESULT GetInertiaEndTransform(float* matrix, uint pointCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationprimarycontent-getcenterpoint
    HRESULT GetCenterPoint(float* centerX, float* centerY);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nn-directmanipulation-idirectmanipulationdragdropeventhandler
@GUID("1fa11b10-701b-41ae-b5f2-49e36bd595aa")
interface IDirectManipulationDragDropEventHandler : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationdragdropeventhandler-ondragdropstatuschange
    HRESULT OnDragDropStatusChange(IDirectManipulationViewport2 viewport, 
                                   DIRECTMANIPULATION_DRAG_DROP_STATUS current, 
                                   DIRECTMANIPULATION_DRAG_DROP_STATUS previous);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nn-directmanipulation-idirectmanipulationdragdropbehavior
@GUID("814b5af5-c2c8-4270-a9b7-a198ce8d02fa")
interface IDirectManipulationDragDropBehavior : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationdragdropbehavior-setconfiguration
    HRESULT SetConfiguration(DIRECTMANIPULATION_DRAG_DROP_CONFIGURATION configuration);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationdragdropbehavior-getstatus
    HRESULT GetStatus(DIRECTMANIPULATION_DRAG_DROP_STATUS* status);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nn-directmanipulation-idirectmanipulationinteractioneventhandler
@GUID("e43f45b8-42b4-403e-b1f2-273b8f510830")
interface IDirectManipulationInteractionEventHandler : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationinteractioneventhandler-oninteraction
    HRESULT OnInteraction(IDirectManipulationViewport2 viewport, DIRECTMANIPULATION_INTERACTION_TYPE interaction);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nn-directmanipulation-idirectmanipulationframeinfoprovider
@GUID("fb759dba-6f4c-4c01-874e-19c8a05907f9")
interface IDirectManipulationFrameInfoProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationframeinfoprovider-getnextframeinfo
    HRESULT GetNextFrameInfo(ulong* time, ulong* processTime, ulong* compositionTime);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nn-directmanipulation-idirectmanipulationcompositor
@GUID("537a0825-0387-4efa-b62f-71eb1f085a7e")
interface IDirectManipulationCompositor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationcompositor-addcontent
    HRESULT AddContent(IDirectManipulationContent content, IUnknown device, IUnknown parentVisual, 
                       IUnknown childVisual);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationcompositor-removecontent
    HRESULT RemoveContent(IDirectManipulationContent content);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationcompositor-setupdatemanager
    HRESULT SetUpdateManager(IDirectManipulationUpdateManager updateManager);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationcompositor-flush
    HRESULT Flush();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nn-directmanipulation-idirectmanipulationcompositor2
@GUID("d38c7822-f1cb-43cb-b4b9-ac0c767a412e")
interface IDirectManipulationCompositor2 : IDirectManipulationCompositor
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationcompositor2-addcontentwithcrossprocesschaining
    HRESULT AddContentWithCrossProcessChaining(IDirectManipulationPrimaryContent content, IUnknown device, 
                                               IUnknown parentVisual, IUnknown childVisual);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nn-directmanipulation-idirectmanipulationupdatehandler
@GUID("790b6337-64f8-4ff5-a269-b32bc2af27a7")
interface IDirectManipulationUpdateHandler : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationupdatehandler-update
    HRESULT Update();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nn-directmanipulation-idirectmanipulationupdatemanager
@GUID("b0ae62fd-be34-46e7-9caa-d361facbb9cc")
interface IDirectManipulationUpdateManager : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationupdatemanager-registerwaithandlecallback
    HRESULT RegisterWaitHandleCallback(HANDLE handle, IDirectManipulationUpdateHandler eventHandler, uint* cookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationupdatemanager-unregisterwaithandlecallback
    HRESULT UnregisterWaitHandleCallback(uint cookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationupdatemanager-update
    HRESULT Update(IDirectManipulationFrameInfoProvider frameInfo);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nn-directmanipulation-idirectmanipulationautoscrollbehavior
@GUID("6d5954d4-2003-4356-9b31-d051c9ff0af7")
interface IDirectManipulationAutoScrollBehavior : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationautoscrollbehavior-setconfiguration
    HRESULT SetConfiguration(DIRECTMANIPULATION_MOTION_TYPES motionTypes, 
                             DIRECTMANIPULATION_AUTOSCROLL_CONFIGURATION scrollMotion);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nn-directmanipulation-idirectmanipulationdefercontactservice
@GUID("652d5c71-fe60-4a98-be70-e5f21291e7f1")
interface IDirectManipulationDeferContactService : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationdefercontactservice-defercontact
    HRESULT DeferContact(uint pointerId, uint timeout);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationdefercontactservice-cancelcontact
    HRESULT CancelContact(uint pointerId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directmanipulation/nf-directmanipulation-idirectmanipulationdefercontactservice-canceldeferral
    HRESULT CancelDeferral(uint pointerId);
}


// GUIDs

const GUID CLSID_DCompManipulationCompositor      = GUIDOF!DCompManipulationCompositor;
const GUID CLSID_DirectManipulationManager        = GUIDOF!DirectManipulationManager;
const GUID CLSID_DirectManipulationPrimaryContent = GUIDOF!DirectManipulationPrimaryContent;
const GUID CLSID_DirectManipulationSharedManager  = GUIDOF!DirectManipulationSharedManager;
const GUID CLSID_DirectManipulationUpdateManager  = GUIDOF!DirectManipulationUpdateManager;
const GUID CLSID_DirectManipulationViewport       = GUIDOF!DirectManipulationViewport;

const GUID IID_IDirectManipulationAutoScrollBehavior      = GUIDOF!IDirectManipulationAutoScrollBehavior;
const GUID IID_IDirectManipulationCompositor              = GUIDOF!IDirectManipulationCompositor;
const GUID IID_IDirectManipulationCompositor2             = GUIDOF!IDirectManipulationCompositor2;
const GUID IID_IDirectManipulationContent                 = GUIDOF!IDirectManipulationContent;
const GUID IID_IDirectManipulationDeferContactService     = GUIDOF!IDirectManipulationDeferContactService;
const GUID IID_IDirectManipulationDragDropBehavior        = GUIDOF!IDirectManipulationDragDropBehavior;
const GUID IID_IDirectManipulationDragDropEventHandler    = GUIDOF!IDirectManipulationDragDropEventHandler;
const GUID IID_IDirectManipulationFrameInfoProvider       = GUIDOF!IDirectManipulationFrameInfoProvider;
const GUID IID_IDirectManipulationInteractionEventHandler = GUIDOF!IDirectManipulationInteractionEventHandler;
const GUID IID_IDirectManipulationManager                 = GUIDOF!IDirectManipulationManager;
const GUID IID_IDirectManipulationManager2                = GUIDOF!IDirectManipulationManager2;
const GUID IID_IDirectManipulationManager3                = GUIDOF!IDirectManipulationManager3;
const GUID IID_IDirectManipulationPrimaryContent          = GUIDOF!IDirectManipulationPrimaryContent;
const GUID IID_IDirectManipulationUpdateHandler           = GUIDOF!IDirectManipulationUpdateHandler;
const GUID IID_IDirectManipulationUpdateManager           = GUIDOF!IDirectManipulationUpdateManager;
const GUID IID_IDirectManipulationViewport                = GUIDOF!IDirectManipulationViewport;
const GUID IID_IDirectManipulationViewport2               = GUIDOF!IDirectManipulationViewport2;
const GUID IID_IDirectManipulationViewportEventHandler    = GUIDOF!IDirectManipulationViewportEventHandler;
