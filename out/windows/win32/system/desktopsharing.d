// Written in the D programming language.

module windows.win32.system.desktopsharing;

public import windows.core;
public import windows.win32.foundation.foundation : BSTR, HRESULT, VARIANT_BOOL;
public import windows.win32.system.com.com : IDispatch, IUnknown, SAFEARRAY;
public import windows.win32.system.variant : VARIANT;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/ne-rdpencomapi-ctrl_level
alias CTRL_LEVEL = int;
enum : int
{
    CTRL_LEVEL_MIN                 = 0x00000000,
    CTRL_LEVEL_INVALID             = 0x00000000,
    CTRL_LEVEL_NONE                = 0x00000001,
    CTRL_LEVEL_VIEW                = 0x00000002,
    CTRL_LEVEL_INTERACTIVE         = 0x00000003,
    CTRL_LEVEL_REQCTRL_VIEW        = 0x00000004,
    CTRL_LEVEL_REQCTRL_INTERACTIVE = 0x00000005,
    CTRL_LEVEL_MAX                 = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/ne-rdpencomapi-attendee_disconnect_reason
alias ATTENDEE_DISCONNECT_REASON = int;
enum : int
{
    ATTENDEE_DISCONNECT_REASON_MIN = 0x00000000,
    ATTENDEE_DISCONNECT_REASON_APP = 0x00000000,
    ATTENDEE_DISCONNECT_REASON_ERR = 0x00000001,
    ATTENDEE_DISCONNECT_REASON_CLI = 0x00000002,
    ATTENDEE_DISCONNECT_REASON_MAX = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/ne-rdpencomapi-channel_priority
alias CHANNEL_PRIORITY = int;
enum : int
{
    CHANNEL_PRIORITY_LO  = 0x00000000,
    CHANNEL_PRIORITY_MED = 0x00000001,
    CHANNEL_PRIORITY_HI  = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/ne-rdpencomapi-channel_flags
alias CHANNEL_FLAGS = int;
enum : int
{
    CHANNEL_FLAGS_LEGACY       = 0x00000001,
    CHANNEL_FLAGS_UNCOMPRESSED = 0x00000002,
    CHANNEL_FLAGS_DYNAMIC      = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/ne-rdpencomapi-channel_access_enum
alias CHANNEL_ACCESS_ENUM = int;
enum : int
{
    CHANNEL_ACCESS_ENUM_NONE        = 0x00000000,
    CHANNEL_ACCESS_ENUM_SENDRECEIVE = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/ne-rdpencomapi-rdpencomapi_attendee_flags
alias RDPENCOMAPI_ATTENDEE_FLAGS = int;
enum : int
{
    ATTENDEE_FLAGS_LOCAL = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/ne-rdpencomapi-rdpsrapi_wnd_flags
alias RDPSRAPI_WND_FLAGS = int;
enum : int
{
    WND_FLAG_PRIVILEGED = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/ne-rdpencomapi-rdpsrapi_app_flags
alias RDPSRAPI_APP_FLAGS = int;
enum : int
{
    APP_FLAG_PRIVILEGED = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/ne-rdpencomapi-rdpsrapi_mouse_button_type
alias RDPSRAPI_MOUSE_BUTTON_TYPE = int;
enum : int
{
    RDPSRAPI_MOUSE_BUTTON_BUTTON1  = 0x00000000,
    RDPSRAPI_MOUSE_BUTTON_BUTTON2  = 0x00000001,
    RDPSRAPI_MOUSE_BUTTON_BUTTON3  = 0x00000002,
    RDPSRAPI_MOUSE_BUTTON_XBUTTON1 = 0x00000003,
    RDPSRAPI_MOUSE_BUTTON_XBUTTON2 = 0x00000004,
    RDPSRAPI_MOUSE_BUTTON_XBUTTON3 = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/ne-rdpencomapi-rdpsrapi_kbd_code_type
alias RDPSRAPI_KBD_CODE_TYPE = int;
enum : int
{
    RDPSRAPI_KBD_CODE_SCANCODE = 0x00000000,
    RDPSRAPI_KBD_CODE_UNICODE  = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/ne-rdpencomapi-rdpsrapi_kbd_sync_flag
alias RDPSRAPI_KBD_SYNC_FLAG = int;
enum : int
{
    RDPSRAPI_KBD_SYNC_FLAG_SCROLL_LOCK = 0x00000001,
    RDPSRAPI_KBD_SYNC_FLAG_NUM_LOCK    = 0x00000002,
    RDPSRAPI_KBD_SYNC_FLAG_CAPS_LOCK   = 0x00000004,
    RDPSRAPI_KBD_SYNC_FLAG_KANA_LOCK   = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/ne-rdpencomapi-rdpencomapi_constants
alias RDPENCOMAPI_CONSTANTS = int;
enum : int
{
    CONST_MAX_CHANNEL_MESSAGE_SIZE        = 0x00000400,
    CONST_MAX_CHANNEL_NAME_LEN            = 0x00000008,
    CONST_MAX_LEGACY_CHANNEL_MESSAGE_SIZE = 0x00064000,
    CONST_ATTENDEE_ID_EVERYONE            = 0xffffffff,
    CONST_ATTENDEE_ID_HOST                = 0x00000000,
    CONST_CONN_INTERVAL                   = 0x00000032,
    CONST_ATTENDEE_ID_DEFAULT             = 0xffffffff,
}

// Constants


enum : uint
{
    DISPID_RDPSRAPI_METHOD_OPEN                           = 0x00000064U,
    DISPID_RDPSRAPI_METHOD_CLOSE                          = 0x00000065U,
    DISPID_RDPSRAPI_METHOD_SETSHAREDRECT                  = 0x00000066U,
    DISPID_RDPSRAPI_METHOD_GETSHAREDRECT                  = 0x00000067U,
    DISPID_RDPSRAPI_METHOD_VIEWERCONNECT                  = 0x00000068U,
    DISPID_RDPSRAPI_METHOD_VIEWERDISCONNECT               = 0x00000069U,
    DISPID_RDPSRAPI_METHOD_TERMINATE_CONNECTION           = 0x0000006aU,
    DISPID_RDPSRAPI_METHOD_CREATE_INVITATION              = 0x0000006bU,
    DISPID_RDPSRAPI_METHOD_REQUEST_CONTROL                = 0x0000006cU,
    DISPID_RDPSRAPI_METHOD_VIRTUAL_CHANNEL_CREATE         = 0x0000006dU,
    DISPID_RDPSRAPI_METHOD_VIRTUAL_CHANNEL_SEND_DATA      = 0x0000006eU,
    DISPID_RDPSRAPI_METHOD_VIRTUAL_CHANNEL_SET_ACCESS     = 0x0000006fU,
    DISPID_RDPSRAPI_METHOD_PAUSE                          = 0x00000070U,
    DISPID_RDPSRAPI_METHOD_RESUME                         = 0x00000071U,
    DISPID_RDPSRAPI_METHOD_SHOW_WINDOW                    = 0x00000072U,
    DISPID_RDPSRAPI_METHOD_REQUEST_COLOR_DEPTH_CHANGE     = 0x00000073U,
    DISPID_RDPSRAPI_METHOD_STARTREVCONNECTLISTENER        = 0x00000074U,
    DISPID_RDPSRAPI_METHOD_CONNECTTOCLIENT                = 0x00000075U,
    DISPID_RDPSRAPI_METHOD_SET_RENDERING_SURFACE          = 0x00000076U,
    DISPID_RDPSRAPI_METHOD_SEND_MOUSE_BUTTON_EVENT        = 0x00000077U,
    DISPID_RDPSRAPI_METHOD_SEND_MOUSE_MOVE_EVENT          = 0x00000078U,
    DISPID_RDPSRAPI_METHOD_SEND_MOUSE_WHEEL_EVENT         = 0x00000079U,
    DISPID_RDPSRAPI_METHOD_SEND_KEYBOARD_EVENT            = 0x0000007aU,
    DISPID_RDPSRAPI_METHOD_SEND_SYNC_EVENT                = 0x0000007bU,
    DISPID_RDPSRAPI_METHOD_BEGIN_TOUCH_FRAME              = 0x0000007cU,
    DISPID_RDPSRAPI_METHOD_ADD_TOUCH_INPUT                = 0x0000007dU,
    DISPID_RDPSRAPI_METHOD_END_TOUCH_FRAME                = 0x0000007eU,
    DISPID_RDPSRAPI_METHOD_CONNECTUSINGTRANSPORTSTREAM    = 0x0000007fU,
    DISPID_RDPSRAPI_METHOD_SENDCONTROLLEVELCHANGERESPONSE = 0x00000094U,
    DISPID_RDPSRAPI_METHOD_GETFRAMEBUFFERBITS             = 0x00000095U,
}

enum : uint
{
    DISPID_RDPSRAPI_PROP_DISPIDVALUE                         = 0x000000c8U,
    DISPID_RDPSRAPI_PROP_ID                                  = 0x000000c9U,
    DISPID_RDPSRAPI_PROP_SESSION_PROPERTIES                  = 0x000000caU,
    DISPID_RDPSRAPI_PROP_ATTENDEES                           = 0x000000cbU,
    DISPID_RDPSRAPI_PROP_INVITATIONS                         = 0x000000ccU,
    DISPID_RDPSRAPI_PROP_INVITATION                          = 0x000000cdU,
    DISPID_RDPSRAPI_PROP_CHANNELMANAGER                      = 0x000000ceU,
    DISPID_RDPSRAPI_PROP_VIRTUAL_CHANNEL_GETNAME             = 0x000000cfU,
    DISPID_RDPSRAPI_PROP_VIRTUAL_CHANNEL_GETFLAGS            = 0x000000d0U,
    DISPID_RDPSRAPI_PROP_VIRTUAL_CHANNEL_GETPRIORITY         = 0x000000d1U,
    DISPID_RDPSRAPI_PROP_WINDOWID                            = 0x000000d2U,
    DISPID_RDPSRAPI_PROP_APPLICATION                         = 0x000000d3U,
    DISPID_RDPSRAPI_PROP_WINDOWSHARED                        = 0x000000d4U,
    DISPID_RDPSRAPI_PROP_WINDOWNAME                          = 0x000000d5U,
    DISPID_RDPSRAPI_PROP_APPNAME                             = 0x000000d6U,
    DISPID_RDPSRAPI_PROP_APPLICATION_FILTER                  = 0x000000d7U,
    DISPID_RDPSRAPI_PROP_WINDOW_LIST                         = 0x000000d8U,
    DISPID_RDPSRAPI_PROP_APPLICATION_LIST                    = 0x000000d9U,
    DISPID_RDPSRAPI_PROP_APPFILTER_ENABLED                   = 0x000000daU,
    DISPID_RDPSRAPI_PROP_APPFILTERENABLED                    = 0x000000dbU,
    DISPID_RDPSRAPI_PROP_SHARED                              = 0x000000dcU,
    DISPID_RDPSRAPI_PROP_INVITATIONITEM                      = 0x000000ddU,
    DISPID_RDPSRAPI_PROP_DBG_CLX_CMDLINE                     = 0x000000deU,
    DISPID_RDPSRAPI_PROP_APPFLAGS                            = 0x000000dfU,
    DISPID_RDPSRAPI_PROP_WNDFLAGS                            = 0x000000e0U,
    DISPID_RDPSRAPI_PROP_PROTOCOL_TYPE                       = 0x000000e1U,
    DISPID_RDPSRAPI_PROP_LOCAL_PORT                          = 0x000000e2U,
    DISPID_RDPSRAPI_PROP_LOCAL_IP                            = 0x000000e3U,
    DISPID_RDPSRAPI_PROP_PEER_PORT                           = 0x000000e4U,
    DISPID_RDPSRAPI_PROP_PEER_IP                             = 0x000000e5U,
    DISPID_RDPSRAPI_PROP_ATTENDEE_FLAGS                      = 0x000000e6U,
    DISPID_RDPSRAPI_PROP_CONINFO                             = 0x000000e7U,
    DISPID_RDPSRAPI_PROP_CONNECTION_STRING                   = 0x000000e8U,
    DISPID_RDPSRAPI_PROP_GROUP_NAME                          = 0x000000e9U,
    DISPID_RDPSRAPI_PROP_PASSWORD                            = 0x000000eaU,
    DISPID_RDPSRAPI_PROP_ATTENDEELIMIT                       = 0x000000ebU,
    DISPID_RDPSRAPI_PROP_REVOKED                             = 0x000000ecU,
    DISPID_RDPSRAPI_PROP_DISCONNECTED_STRING                 = 0x000000edU,
    DISPID_RDPSRAPI_PROP_USESMARTSIZING                      = 0x000000eeU,
    DISPID_RDPSRAPI_PROP_SESSION_COLORDEPTH                  = 0x000000efU,
    DISPID_RDPSRAPI_PROP_REASON                              = 0x000000f0U,
    DISPID_RDPSRAPI_PROP_CODE                                = 0x000000f1U,
    DISPID_RDPSRAPI_PROP_CTRL_LEVEL                          = 0x000000f2U,
    DISPID_RDPSRAPI_PROP_REMOTENAME                          = 0x000000f3U,
    DISPID_RDPSRAPI_PROP_COUNT                               = 0x000000f4U,
    DISPID_RDPSRAPI_PROP_FRAMEBUFFER_HEIGHT                  = 0x000000fbU,
    DISPID_RDPSRAPI_PROP_FRAMEBUFFER_WIDTH                   = 0x000000fcU,
    DISPID_RDPSRAPI_PROP_FRAMEBUFFER_BPP                     = 0x000000fdU,
    DISPID_RDPSRAPI_PROP_FRAMEBUFFER                         = 0x000000feU,
    DISPID_RDPSRAPI_EVENT_ON_ATTENDEE_CONNECTED              = 0x0000012dU,
    DISPID_RDPSRAPI_EVENT_ON_ATTENDEE_DISCONNECTED           = 0x0000012eU,
    DISPID_RDPSRAPI_EVENT_ON_ATTENDEE_UPDATE                 = 0x0000012fU,
    DISPID_RDPSRAPI_EVENT_ON_ERROR                           = 0x00000130U,
    DISPID_RDPSRAPI_EVENT_ON_VIEWER_CONNECTED                = 0x00000131U,
    DISPID_RDPSRAPI_EVENT_ON_VIEWER_DISCONNECTED             = 0x00000132U,
    DISPID_RDPSRAPI_EVENT_ON_VIEWER_AUTHENTICATED            = 0x00000133U,
    DISPID_RDPSRAPI_EVENT_ON_VIEWER_CONNECTFAILED            = 0x00000134U,
    DISPID_RDPSRAPI_EVENT_ON_CTRLLEVEL_CHANGE_REQUEST        = 0x00000135U,
    DISPID_RDPSRAPI_EVENT_ON_GRAPHICS_STREAM_PAUSED          = 0x00000136U,
    DISPID_RDPSRAPI_EVENT_ON_GRAPHICS_STREAM_RESUMED         = 0x00000137U,
    DISPID_RDPSRAPI_EVENT_ON_VIRTUAL_CHANNEL_JOIN            = 0x00000138U,
    DISPID_RDPSRAPI_EVENT_ON_VIRTUAL_CHANNEL_LEAVE           = 0x00000139U,
    DISPID_RDPSRAPI_EVENT_ON_VIRTUAL_CHANNEL_DATARECEIVED    = 0x0000013aU,
    DISPID_RDPSRAPI_EVENT_ON_VIRTUAL_CHANNEL_SENDCOMPLETED   = 0x0000013bU,
    DISPID_RDPSRAPI_EVENT_ON_APPLICATION_OPEN                = 0x0000013cU,
    DISPID_RDPSRAPI_EVENT_ON_APPLICATION_CLOSE               = 0x0000013dU,
    DISPID_RDPSRAPI_EVENT_ON_APPLICATION_UPDATE              = 0x0000013eU,
    DISPID_RDPSRAPI_EVENT_ON_WINDOW_OPEN                     = 0x0000013fU,
    DISPID_RDPSRAPI_EVENT_ON_WINDOW_CLOSE                    = 0x00000140U,
    DISPID_RDPSRAPI_EVENT_ON_WINDOW_UPDATE                   = 0x00000141U,
    DISPID_RDPSRAPI_EVENT_ON_APPFILTER_UPDATE                = 0x00000142U,
    DISPID_RDPSRAPI_EVENT_ON_SHARED_RECT_CHANGED             = 0x00000143U,
    DISPID_RDPSRAPI_EVENT_ON_FOCUSRELEASED                   = 0x00000144U,
    DISPID_RDPSRAPI_EVENT_ON_SHARED_DESKTOP_SETTINGS_CHANGED = 0x00000145U,
    DISPID_RDPSRAPI_EVENT_ON_CTRLLEVEL_CHANGE_RESPONSE       = 0x00000152U,
}

enum uint DISPID_RDPAPI_EVENT_ON_BOUNDING_RECT_CHANGED = 0x00000154U;

enum : uint
{
    DISPID_RDPSRAPI_METHOD_STREAM_ALLOCBUFFER       = 0x000001a5U,
    DISPID_RDPSRAPI_METHOD_STREAM_FREEBUFFER        = 0x000001a6U,
    DISPID_RDPSRAPI_METHOD_STREAMSENDDATA           = 0x000001a7U,
    DISPID_RDPSRAPI_METHOD_STREAMREADDATA           = 0x000001a8U,
    DISPID_RDPSRAPI_METHOD_STREAMOPEN               = 0x000001a9U,
    DISPID_RDPSRAPI_METHOD_STREAMCLOSE              = 0x000001aaU,
    DISPID_RDPSRAPI_PROP_STREAMBUFFER_STORAGE       = 0x0000022bU,
    DISPID_RDPSRAPI_PROP_STREAMBUFFER_PAYLOADSIZE   = 0x0000022eU,
    DISPID_RDPSRAPI_PROP_STREAMBUFFER_PAYLOADOFFSET = 0x0000022fU,
    DISPID_RDPSRAPI_PROP_STREAMBUFFER_CONTEXT       = 0x00000230U,
    DISPID_RDPSRAPI_PROP_STREAMBUFFER_FLAGS         = 0x00000231U,
    DISPID_RDPSRAPI_PROP_STREAMBUFFER_STORESIZE     = 0x00000232U,
}

enum : uint
{
    DISPID_RDPSRAPI_EVENT_ON_STREAM_SENDCOMPLETED    = 0x00000278U,
    DISPID_RDPSRAPI_EVENT_ON_STREAM_DATARECEIVED     = 0x00000279U,
    DISPID_RDPSRAPI_EVENT_ON_STREAM_CLOSED           = 0x0000027aU,
    DISPID_RDPSRAPI_EVENT_VIEW_MOUSE_BUTTON_RECEIVED = 0x000002bcU,
    DISPID_RDPSRAPI_EVENT_VIEW_MOUSE_MOVE_RECEIVED   = 0x000002bdU,
    DISPID_RDPSRAPI_EVENT_VIEW_MOUSE_WHEEL_RECEIVED  = 0x000002beU,
}

// Structs


struct __ReferenceRemainingTypes__
{
    CTRL_LEVEL          __ctrlLevel__;
    ATTENDEE_DISCONNECT_REASON __attendeeDisconnectReason__;
    CHANNEL_PRIORITY    __channelPriority__;
    CHANNEL_FLAGS       __channelFlags__;
    CHANNEL_ACCESS_ENUM __channelAccessEnum__;
    RDPENCOMAPI_ATTENDEE_FLAGS __rdpencomapiAttendeeFlags__;
    RDPSRAPI_WND_FLAGS  __rdpsrapiWndFlags__;
    RDPSRAPI_APP_FLAGS  __rdpsrapiAppFlags__;
}

// Interfaces

@GUID("32be5ed2-5c86-480f-a914-0ff8885a1b3f")
struct RDPViewer;

@GUID("dd7594ff-ea2a-4c06-8fdf-132de48b6510")
struct RDPSRAPISessionProperties;

@GUID("53d9c9db-75ab-4271-948a-4c4eb36a8f2b")
struct RDPSRAPIInvitationManager;

@GUID("49174dc6-0731-4b5e-8ee1-83a63d3868fa")
struct RDPSRAPIInvitation;

@GUID("d7b13a01-f7d4-42a6-8595-12fc8c24e851")
struct RDPSRAPIAttendeeManager;

@GUID("74f93bb5-755f-488e-8a29-2390108aef55")
struct RDPSRAPIAttendee;

@GUID("b47d7250-5bdb-405d-b487-caad9c56f4f8")
struct RDPSRAPIAttendeeDisconnectInfo;

@GUID("e35ace89-c7e8-427e-a4f9-b9da072826bd")
struct RDPSRAPIApplicationFilter;

@GUID("9e31c815-7433-4876-97fb-ed59fe2baa22")
struct RDPSRAPIApplicationList;

@GUID("c116a484-4b25-4b9f-8a54-b934b06e57fa")
struct RDPSRAPIApplication;

@GUID("9c21e2b8-5dd4-42cc-81ba-1c099852e6fa")
struct RDPSRAPIWindowList;

@GUID("03cf46db-ce45-4d36-86ed-ed28b74398bf")
struct RDPSRAPIWindow;

@GUID("be49db3f-ebb6-4278-8ce0-d5455833eaee")
struct RDPSRAPITcpConnectionInfo;

@GUID("9b78f0e6-3e05-4a5b-b2e8-e743a8956b65")
struct RDPSession;

@GUID("a4f66bcc-538e-4101-951d-30847adb5101")
struct RDPSRAPIFrameBuffer;

@GUID("8d4a1c69-f17f-4549-a699-761c6e6b5c0a")
struct RDPTransportStreamBuffer;

@GUID("31e3ab20-5350-483f-9dc6-6748665efdeb")
struct RDPTransportStreamEvents;

@GUID("aa1e42b5-496d-4ca4-a690-348dcb2ec4ad")
interface IRDPSRAPIDebug : IUnknown
{
    HRESULT put_CLXCmdLine(BSTR CLXCmdLine);
    HRESULT get_CLXCmdLine(BSTR* pCLXCmdLine);
}

@GUID("071c2533-0fa4-4e8f-ae83-9c10b4305ab5")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nn-rdpencomapi-irdpsrapiperfcounterlogger
interface IRDPSRAPIPerfCounterLogger : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiperfcounterlogger-logvalue
    HRESULT LogValue(long lValue);
}

@GUID("9a512c86-ac6e-4a8e-b1a4-fcef363f6e64")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nn-rdpencomapi-irdpsrapiperfcounterloggingmanager
interface IRDPSRAPIPerfCounterLoggingManager : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiperfcounterloggingmanager-createlogger
    HRESULT CreateLogger(BSTR bstrCounterName, IRDPSRAPIPerfCounterLogger* ppLogger);
}

@GUID("e3e30ef9-89c6-4541-ba3b-19336ac6d31c")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nn-rdpencomapi-irdpsrapiaudiostream
interface IRDPSRAPIAudioStream : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiaudiostream-initialize
    HRESULT Initialize(long* pnPeriodInHundredNsIntervals);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiaudiostream-start
    HRESULT Start();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiaudiostream-stop
    HRESULT Stop();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiaudiostream-getbuffer
    HRESULT GetBuffer(ubyte** ppbData, uint* pcbData, ulong* pTimestamp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiaudiostream-freebuffer
    HRESULT FreeBuffer();
}

@GUID("d559f59a-7a27-4138-8763-247ce5f659a8")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nn-rdpencomapi-irdpsrapiclipboarduseevents
interface IRDPSRAPIClipboardUseEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiclipboarduseevents-onpastefromclipboard
    HRESULT OnPasteFromClipboard(uint clipboardFormat, IDispatch pAttendee, VARIANT_BOOL* pRetVal);
}

@GUID("beafe0f9-c77b-4933-ba9f-a24cddcc27cf")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nn-rdpencomapi-irdpsrapiwindow
interface IRDPSRAPIWindow : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiwindow-get_id
    HRESULT get_Id(int* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiwindow-get_application
    HRESULT get_Application(IRDPSRAPIApplication* pApplication);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiwindow-get_shared
    HRESULT get_Shared(VARIANT_BOOL* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiwindow-put_shared
    HRESULT put_Shared(VARIANT_BOOL NewVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiwindow-get_name
    HRESULT get_Name(BSTR* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiwindow-show
    HRESULT Show();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiwindow-get_flags
    HRESULT get_Flags(uint* pdwFlags);
}

@GUID("8a05ce44-715a-4116-a189-a118f30a07bd")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nn-rdpencomapi-irdpsrapiwindowlist
interface IRDPSRAPIWindowList : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiwindowlist-get__newenum
    HRESULT get__NewEnum(IUnknown* retval);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiwindowlist-get_item
    HRESULT get_Item(int item, IRDPSRAPIWindow* pWindow);
}

@GUID("41e7a09d-eb7a-436e-935d-780ca2628324")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nn-rdpencomapi-irdpsrapiapplication
interface IRDPSRAPIApplication : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiapplication-get_windows
    HRESULT get_Windows(IRDPSRAPIWindowList* pWindowList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiapplication-get_id
    HRESULT get_Id(int* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiapplication-get_shared
    HRESULT get_Shared(VARIANT_BOOL* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiapplication-put_shared
    HRESULT put_Shared(VARIANT_BOOL NewVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiapplication-get_name
    HRESULT get_Name(BSTR* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiapplication-get_flags
    HRESULT get_Flags(uint* pdwFlags);
}

@GUID("d4b4aeb3-22dc-4837-b3b6-42ea2517849a")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nn-rdpencomapi-irdpsrapiapplicationlist
interface IRDPSRAPIApplicationList : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiapplicationlist-get__newenum
    HRESULT get__NewEnum(IUnknown* retval);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiapplicationlist-get_item
    HRESULT get_Item(int item, IRDPSRAPIApplication* pApplication);
}

@GUID("d20f10ca-6637-4f06-b1d5-277ea7e5160d")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nn-rdpencomapi-irdpsrapiapplicationfilter
interface IRDPSRAPIApplicationFilter : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiapplicationfilter-get_applications
    HRESULT get_Applications(IRDPSRAPIApplicationList* pApplications);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiapplicationfilter-get_windows
    HRESULT get_Windows(IRDPSRAPIWindowList* pWindows);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiapplicationfilter-get_enabled
    HRESULT get_Enabled(VARIANT_BOOL* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiapplicationfilter-put_enabled
    HRESULT put_Enabled(VARIANT_BOOL NewVal);
}

@GUID("339b24f2-9bc0-4f16-9aac-f165433d13d4")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nn-rdpencomapi-irdpsrapisessionproperties
interface IRDPSRAPISessionProperties : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapisessionproperties-get_property
    HRESULT get_Property(BSTR PropertyName, VARIANT* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapisessionproperties-put_property
    HRESULT put_Property(BSTR PropertyName, VARIANT newVal);
}

@GUID("4fac1d43-fc51-45bb-b1b4-2b53aa562fa3")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nn-rdpencomapi-irdpsrapiinvitation
interface IRDPSRAPIInvitation : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiinvitation-get_connectionstring
    HRESULT get_ConnectionString(BSTR* pbstrVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiinvitation-get_groupname
    HRESULT get_GroupName(BSTR* pbstrVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiinvitation-get_password
    HRESULT get_Password(BSTR* pbstrVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiinvitation-get_attendeelimit
    HRESULT get_AttendeeLimit(int* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiinvitation-put_attendeelimit
    HRESULT put_AttendeeLimit(int NewVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiinvitation-get_revoked
    HRESULT get_Revoked(VARIANT_BOOL* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiinvitation-put_revoked
    HRESULT put_Revoked(VARIANT_BOOL NewVal);
}

@GUID("4722b049-92c3-4c2d-8a65-f7348f644dcf")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nn-rdpencomapi-irdpsrapiinvitationmanager
interface IRDPSRAPIInvitationManager : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiinvitationmanager-get__newenum
    HRESULT get__NewEnum(IUnknown* retval);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiinvitationmanager-get_item
    HRESULT get_Item(VARIANT item, IRDPSRAPIInvitation* ppInvitation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiinvitationmanager-get_count
    HRESULT get_Count(int* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiinvitationmanager-createinvitation
    HRESULT CreateInvitation(BSTR bstrAuthString, BSTR bstrGroupName, BSTR bstrPassword, int AttendeeLimit, 
                             IRDPSRAPIInvitation* ppInvitation);
}

@GUID("f74049a4-3d06-4028-8193-0a8c29bc2452")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nn-rdpencomapi-irdpsrapitcpconnectioninfo
interface IRDPSRAPITcpConnectionInfo : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapitcpconnectioninfo-get_protocol
    HRESULT get_Protocol(int* plProtocol);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapitcpconnectioninfo-get_localport
    HRESULT get_LocalPort(int* plPort);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapitcpconnectioninfo-get_localip
    HRESULT get_LocalIP(BSTR* pbsrLocalIP);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapitcpconnectioninfo-get_peerport
    HRESULT get_PeerPort(int* plPort);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapitcpconnectioninfo-get_peerip
    HRESULT get_PeerIP(BSTR* pbstrIP);
}

@GUID("ec0671b3-1b78-4b80-a464-9132247543e3")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nn-rdpencomapi-irdpsrapiattendee
interface IRDPSRAPIAttendee : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiattendee-get_id
    HRESULT get_Id(int* pId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiattendee-get_remotename
    HRESULT get_RemoteName(BSTR* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiattendee-get_controllevel
    HRESULT get_ControlLevel(CTRL_LEVEL* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiattendee-put_controllevel
    HRESULT put_ControlLevel(CTRL_LEVEL pNewVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiattendee-get_invitation
    HRESULT get_Invitation(IRDPSRAPIInvitation* ppVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiattendee-terminateconnection
    HRESULT TerminateConnection();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiattendee-get_flags
    HRESULT get_Flags(int* plFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiattendee-get_connectivityinfo
    HRESULT get_ConnectivityInfo(IUnknown* ppVal);
}

@GUID("ba3a37e8-33da-4749-8da0-07fa34da7944")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nn-rdpencomapi-irdpsrapiattendeemanager
interface IRDPSRAPIAttendeeManager : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiattendeemanager-get__newenum
    HRESULT get__NewEnum(IUnknown* retval);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiattendeemanager-get_item
    HRESULT get_Item(int id, IRDPSRAPIAttendee* ppItem);
}

@GUID("c187689f-447c-44a1-9c14-fffbb3b7ec17")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nn-rdpencomapi-irdpsrapiattendeedisconnectinfo
interface IRDPSRAPIAttendeeDisconnectInfo : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiattendeedisconnectinfo-get_attendee
    HRESULT get_Attendee(IRDPSRAPIAttendee* retval);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiattendeedisconnectinfo-get_reason
    HRESULT get_Reason(ATTENDEE_DISCONNECT_REASON* pReason);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiattendeedisconnectinfo-get_code
    HRESULT get_Code(int* pVal);
}

@GUID("05e12f95-28b3-4c9a-8780-d0248574a1e0")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nn-rdpencomapi-irdpsrapivirtualchannel
interface IRDPSRAPIVirtualChannel : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapivirtualchannel-senddata
    HRESULT SendData(BSTR bstrData, int lAttendeeId, uint ChannelSendFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapivirtualchannel-setaccess
    HRESULT SetAccess(int lAttendeeId, CHANNEL_ACCESS_ENUM AccessType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapivirtualchannel-get_name
    HRESULT get_Name(BSTR* pbstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapivirtualchannel-get_flags
    HRESULT get_Flags(int* plFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapivirtualchannel-get_priority
    HRESULT get_Priority(CHANNEL_PRIORITY* pPriority);
}

@GUID("0d11c661-5d0d-4ee4-89df-2166ae1fdfed")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nn-rdpencomapi-irdpsrapivirtualchannelmanager
interface IRDPSRAPIVirtualChannelManager : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapivirtualchannelmanager-get__newenum
    HRESULT get__NewEnum(IUnknown* retval);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapivirtualchannelmanager-get_item
    HRESULT get_Item(VARIANT item, IRDPSRAPIVirtualChannel* pChannel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapivirtualchannelmanager-createvirtualchannel
    HRESULT CreateVirtualChannel(BSTR bstrChannelName, CHANNEL_PRIORITY Priority, uint ChannelFlags, 
                                 IRDPSRAPIVirtualChannel* ppChannel);
}

@GUID("c6bfcd38-8ce9-404d-8ae8-f31d00c65cb5")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nn-rdpencomapi-irdpsrapiviewer
interface IRDPSRAPIViewer : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiviewer-connect
    HRESULT Connect(BSTR bstrConnectionString, BSTR bstrName, BSTR bstrPassword);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiviewer-disconnect
    HRESULT Disconnect();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiviewer-get_attendees
    HRESULT get_Attendees(IRDPSRAPIAttendeeManager* ppVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiviewer-get_invitations
    HRESULT get_Invitations(IRDPSRAPIInvitationManager* ppVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiviewer-get_applicationfilter
    HRESULT get_ApplicationFilter(IRDPSRAPIApplicationFilter* ppVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiviewer-get_virtualchannelmanager
    HRESULT get_VirtualChannelManager(IRDPSRAPIVirtualChannelManager* ppVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiviewer-put_smartsizing
    HRESULT put_SmartSizing(VARIANT_BOOL vbSmartSizing);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiviewer-get_smartsizing
    HRESULT get_SmartSizing(VARIANT_BOOL* pvbSmartSizing);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiviewer-requestcontrol
    HRESULT RequestControl(CTRL_LEVEL CtrlLevel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiviewer-put_disconnectedtext
    HRESULT put_DisconnectedText(BSTR bstrDisconnectedText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiviewer-get_disconnectedtext
    HRESULT get_DisconnectedText(BSTR* pbstrDisconnectedText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiviewer-requestcolordepthchange
    HRESULT RequestColorDepthChange(int Bpp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiviewer-get_properties
    HRESULT get_Properties(IRDPSRAPISessionProperties* ppVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiviewer-startreverseconnectlistener
    HRESULT StartReverseConnectListener(BSTR bstrConnectionString, BSTR bstrUserName, BSTR bstrPassword, 
                                        BSTR* pbstrReverseConnectString);
}

@GUID("bb590853-a6c5-4a7b-8dd4-76b69eea12d5")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nn-rdpencomapi-irdpviewerinputsink
interface IRDPViewerInputSink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpviewerinputsink-sendmousebuttonevent
    HRESULT SendMouseButtonEvent(RDPSRAPI_MOUSE_BUTTON_TYPE buttonType, VARIANT_BOOL vbButtonDown, uint xPos, 
                                 uint yPos);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpviewerinputsink-sendmousemoveevent
    HRESULT SendMouseMoveEvent(uint xPos, uint yPos);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpviewerinputsink-sendmousewheelevent
    HRESULT SendMouseWheelEvent(ushort wheelRotation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpviewerinputsink-sendkeyboardevent
    HRESULT SendKeyboardEvent(RDPSRAPI_KBD_CODE_TYPE codeType, ushort keycode, VARIANT_BOOL vbKeyUp, 
                              VARIANT_BOOL vbRepeat, VARIANT_BOOL vbExtended);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpviewerinputsink-sendsyncevent
    HRESULT SendSyncEvent(uint syncFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpviewerinputsink-begintouchframe
    HRESULT BeginTouchFrame();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpviewerinputsink-addtouchinput
    HRESULT AddTouchInput(uint contactId, uint event, int x, int y);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpviewerinputsink-endtouchframe
    HRESULT EndTouchFrame();
}

@GUID("3d67e7d2-b27b-448e-81b3-c6110ed8b4be")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nn-rdpencomapi-irdpsrapiframebuffer
interface IRDPSRAPIFrameBuffer : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiframebuffer-get_width
    HRESULT get_Width(int* plWidth);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiframebuffer-get_height
    HRESULT get_Height(int* plHeight);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiframebuffer-get_bpp
    HRESULT get_Bpp(int* plBpp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapiframebuffer-getframebufferbits
    HRESULT GetFrameBufferBits(int x, int y, int Width, int Heigth, SAFEARRAY** ppBits);
}

@GUID("81c80290-5085-44b0-b460-f865c39cb4a9")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nn-rdpencomapi-irdpsrapitransportstreambuffer
interface IRDPSRAPITransportStreamBuffer : IUnknown
{
    HRESULT get_Storage(ubyte** ppbStorage);
    HRESULT get_StorageSize(int* plMaxStore);
    HRESULT get_PayloadSize(int* plRetVal);
    HRESULT put_PayloadSize(int lVal);
    HRESULT get_PayloadOffset(int* plRetVal);
    HRESULT put_PayloadOffset(int lRetVal);
    HRESULT get_Flags(int* plFlags);
    HRESULT put_Flags(int lFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapitransportstreambuffer-get_context
    HRESULT get_Context(IUnknown* ppContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapitransportstreambuffer-put_context
    HRESULT put_Context(IUnknown pContext);
}

@GUID("ea81c254-f5af-4e40-982e-3e63bb595276")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nn-rdpencomapi-irdpsrapitransportstreamevents
interface IRDPSRAPITransportStreamEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapitransportstreamevents-onwritecompleted
    void OnWriteCompleted(IRDPSRAPITransportStreamBuffer pBuffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapitransportstreamevents-onreadcompleted
    void OnReadCompleted(IRDPSRAPITransportStreamBuffer pBuffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapitransportstreamevents-onstreamclosed
    void OnStreamClosed(HRESULT hrReason);
}

@GUID("36cfa065-43bb-4ef7-aed7-9b88a5053036")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nn-rdpencomapi-irdpsrapitransportstream
interface IRDPSRAPITransportStream : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapitransportstream-allocbuffer
    HRESULT AllocBuffer(int maxPayload, IRDPSRAPITransportStreamBuffer* ppBuffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapitransportstream-freebuffer
    HRESULT FreeBuffer(IRDPSRAPITransportStreamBuffer pBuffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapitransportstream-writebuffer
    HRESULT WriteBuffer(IRDPSRAPITransportStreamBuffer pBuffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapitransportstream-readbuffer
    HRESULT ReadBuffer(IRDPSRAPITransportStreamBuffer pBuffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapitransportstream-open
    HRESULT Open(IRDPSRAPITransportStreamEvents pCallbacks);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapitransportstream-close
    HRESULT Close();
}

@GUID("eeb20886-e470-4cf6-842b-2739c0ec5cfb")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nn-rdpencomapi-irdpsrapisharingsession
interface IRDPSRAPISharingSession : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapisharingsession-open
    HRESULT Open();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapisharingsession-close
    HRESULT Close();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapisharingsession-put_colordepth
    HRESULT put_ColorDepth(int colorDepth);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapisharingsession-get_colordepth
    HRESULT get_ColorDepth(int* pColorDepth);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapisharingsession-get_properties
    HRESULT get_Properties(IRDPSRAPISessionProperties* ppVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapisharingsession-get_attendees
    HRESULT get_Attendees(IRDPSRAPIAttendeeManager* ppVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapisharingsession-get_invitations
    HRESULT get_Invitations(IRDPSRAPIInvitationManager* ppVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapisharingsession-get_applicationfilter
    HRESULT get_ApplicationFilter(IRDPSRAPIApplicationFilter* ppVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapisharingsession-get_virtualchannelmanager
    HRESULT get_VirtualChannelManager(IRDPSRAPIVirtualChannelManager* ppVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapisharingsession-pause
    HRESULT Pause();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapisharingsession-resume
    HRESULT Resume();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapisharingsession-connecttoclient
    HRESULT ConnectToClient(BSTR bstrConnectionString);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapisharingsession-setdesktopsharedrect
    HRESULT SetDesktopSharedRect(int left, int top, int right, int bottom);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapisharingsession-getdesktopsharedrect
    HRESULT GetDesktopSharedRect(int* pleft, int* ptop, int* pright, int* pbottom);
}

@GUID("fee4ee57-e3e8-4205-8fb0-8fd1d0675c21")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nn-rdpencomapi-irdpsrapisharingsession2
interface IRDPSRAPISharingSession2 : IRDPSRAPISharingSession
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapisharingsession2-connectusingtransportstream
    HRESULT ConnectUsingTransportStream(IRDPSRAPITransportStream pStream, BSTR bstrGroup, 
                                        BSTR bstrAuthenticatedAttendeeName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapisharingsession2-get_framebuffer
    HRESULT get_FrameBuffer(IRDPSRAPIFrameBuffer* ppVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nf-rdpencomapi-irdpsrapisharingsession2-sendcontrollevelchangeresponse
    HRESULT SendControlLevelChangeResponse(IRDPSRAPIAttendee pAttendee, CTRL_LEVEL RequestedLevel, int ReasonCode);
}

@GUID("98a97042-6698-40e9-8efd-b3200990004b")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpencomapi/nn-rdpencomapi-_irdpsessionevents
interface _IRDPSessionEvents : IDispatch
{
}


// GUIDs

const GUID CLSID_RDPSRAPIApplication            = GUIDOF!RDPSRAPIApplication;
const GUID CLSID_RDPSRAPIApplicationFilter      = GUIDOF!RDPSRAPIApplicationFilter;
const GUID CLSID_RDPSRAPIApplicationList        = GUIDOF!RDPSRAPIApplicationList;
const GUID CLSID_RDPSRAPIAttendee               = GUIDOF!RDPSRAPIAttendee;
const GUID CLSID_RDPSRAPIAttendeeDisconnectInfo = GUIDOF!RDPSRAPIAttendeeDisconnectInfo;
const GUID CLSID_RDPSRAPIAttendeeManager        = GUIDOF!RDPSRAPIAttendeeManager;
const GUID CLSID_RDPSRAPIFrameBuffer            = GUIDOF!RDPSRAPIFrameBuffer;
const GUID CLSID_RDPSRAPIInvitation             = GUIDOF!RDPSRAPIInvitation;
const GUID CLSID_RDPSRAPIInvitationManager      = GUIDOF!RDPSRAPIInvitationManager;
const GUID CLSID_RDPSRAPISessionProperties      = GUIDOF!RDPSRAPISessionProperties;
const GUID CLSID_RDPSRAPITcpConnectionInfo      = GUIDOF!RDPSRAPITcpConnectionInfo;
const GUID CLSID_RDPSRAPIWindow                 = GUIDOF!RDPSRAPIWindow;
const GUID CLSID_RDPSRAPIWindowList             = GUIDOF!RDPSRAPIWindowList;
const GUID CLSID_RDPSession                     = GUIDOF!RDPSession;
const GUID CLSID_RDPTransportStreamBuffer       = GUIDOF!RDPTransportStreamBuffer;
const GUID CLSID_RDPTransportStreamEvents       = GUIDOF!RDPTransportStreamEvents;
const GUID CLSID_RDPViewer                      = GUIDOF!RDPViewer;

const GUID IID_IRDPSRAPIApplication               = GUIDOF!IRDPSRAPIApplication;
const GUID IID_IRDPSRAPIApplicationFilter         = GUIDOF!IRDPSRAPIApplicationFilter;
const GUID IID_IRDPSRAPIApplicationList           = GUIDOF!IRDPSRAPIApplicationList;
const GUID IID_IRDPSRAPIAttendee                  = GUIDOF!IRDPSRAPIAttendee;
const GUID IID_IRDPSRAPIAttendeeDisconnectInfo    = GUIDOF!IRDPSRAPIAttendeeDisconnectInfo;
const GUID IID_IRDPSRAPIAttendeeManager           = GUIDOF!IRDPSRAPIAttendeeManager;
const GUID IID_IRDPSRAPIAudioStream               = GUIDOF!IRDPSRAPIAudioStream;
const GUID IID_IRDPSRAPIClipboardUseEvents        = GUIDOF!IRDPSRAPIClipboardUseEvents;
const GUID IID_IRDPSRAPIDebug                     = GUIDOF!IRDPSRAPIDebug;
const GUID IID_IRDPSRAPIFrameBuffer               = GUIDOF!IRDPSRAPIFrameBuffer;
const GUID IID_IRDPSRAPIInvitation                = GUIDOF!IRDPSRAPIInvitation;
const GUID IID_IRDPSRAPIInvitationManager         = GUIDOF!IRDPSRAPIInvitationManager;
const GUID IID_IRDPSRAPIPerfCounterLogger         = GUIDOF!IRDPSRAPIPerfCounterLogger;
const GUID IID_IRDPSRAPIPerfCounterLoggingManager = GUIDOF!IRDPSRAPIPerfCounterLoggingManager;
const GUID IID_IRDPSRAPISessionProperties         = GUIDOF!IRDPSRAPISessionProperties;
const GUID IID_IRDPSRAPISharingSession            = GUIDOF!IRDPSRAPISharingSession;
const GUID IID_IRDPSRAPISharingSession2           = GUIDOF!IRDPSRAPISharingSession2;
const GUID IID_IRDPSRAPITcpConnectionInfo         = GUIDOF!IRDPSRAPITcpConnectionInfo;
const GUID IID_IRDPSRAPITransportStream           = GUIDOF!IRDPSRAPITransportStream;
const GUID IID_IRDPSRAPITransportStreamBuffer     = GUIDOF!IRDPSRAPITransportStreamBuffer;
const GUID IID_IRDPSRAPITransportStreamEvents     = GUIDOF!IRDPSRAPITransportStreamEvents;
const GUID IID_IRDPSRAPIViewer                    = GUIDOF!IRDPSRAPIViewer;
const GUID IID_IRDPSRAPIVirtualChannel            = GUIDOF!IRDPSRAPIVirtualChannel;
const GUID IID_IRDPSRAPIVirtualChannelManager     = GUIDOF!IRDPSRAPIVirtualChannelManager;
const GUID IID_IRDPSRAPIWindow                    = GUIDOF!IRDPSRAPIWindow;
const GUID IID_IRDPSRAPIWindowList                = GUIDOF!IRDPSRAPIWindowList;
const GUID IID_IRDPViewerInputSink                = GUIDOF!IRDPViewerInputSink;
const GUID IID__IRDPSessionEvents                 = GUIDOF!_IRDPSessionEvents;
