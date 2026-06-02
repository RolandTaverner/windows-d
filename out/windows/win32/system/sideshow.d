// Written in the D programming language.

module windows.win32.system.sideshow;

public import windows.core;
public import windows.win32.foundation : BOOL, HRESULT, PROPERTYKEY, PWSTR, SYSTEMTIME;
public import windows.win32.system.com : IUnknown;
public import windows.win32.system.com.structuredstorage : PROPVARIANT;
public import windows.win32.ui.windowsandmessaging : HICON;

extern(Windows) @nogc nothrow:


// Enums


alias SIDESHOW_SCREEN_TYPE = int;
enum : int
{
    SIDESHOW_SCREEN_TYPE_BITMAP = 0x00000000,
    SIDESHOW_SCREEN_TYPE_TEXT   = 0x00000001,
}

alias SIDESHOW_COLOR_TYPE = int;
enum : int
{
    SIDESHOW_COLOR_TYPE_COLOR           = 0x00000000,
    SIDESHOW_COLOR_TYPE_GREYSCALE       = 0x00000001,
    SIDESHOW_COLOR_TYPE_BLACK_AND_WHITE = 0x00000002,
}

alias SCF_EVENT_IDS = int;
enum : int
{
    SCF_EVENT_NAVIGATION  = 0x00000001,
    SCF_EVENT_MENUACTION  = 0x00000002,
    SCF_EVENT_CONTEXTMENU = 0x00000003,
}

alias SCF_BUTTON_IDS = int;
enum : int
{
    SCF_BUTTON_MENU        = 0x00000001,
    SCF_BUTTON_SELECT      = 0x00000002,
    SCF_BUTTON_UP          = 0x00000003,
    SCF_BUTTON_DOWN        = 0x00000004,
    SCF_BUTTON_LEFT        = 0x00000005,
    SCF_BUTTON_RIGHT       = 0x00000006,
    SCF_BUTTON_PLAY        = 0x00000007,
    SCF_BUTTON_PAUSE       = 0x00000008,
    SCF_BUTTON_FASTFORWARD = 0x00000009,
    SCF_BUTTON_REWIND      = 0x0000000a,
    SCF_BUTTON_STOP        = 0x0000000b,
    SCF_BUTTON_BACK        = 0x0000ff00,
}

// Constants


enum : GUID
{
    SIDESHOW_ENDPOINT_SIMPLE_CONTENT_FORMAT = GUID("a9a5353f-2d4b-47ce-93ee-759f3a7dda4f"),
    SIDESHOW_ENDPOINT_ICAL                  = GUID("4dff36b5-9dde-4f76-9a2a-96435047063d"),
    SIDESHOW_CAPABILITY_DEVICE_PROPERTIES   = GUID("8abc88a8-857b-4ad7-a35a-b5942f492b99"),
}

enum : PROPERTYKEY
{
    SIDESHOW_CAPABILITY_DEVICE_ID               = PROPERTYKEY(GUID("8ABC88A8-857B-4AD7-A35A-B5942F492B99"), 1),
    SIDESHOW_CAPABILITY_SCREEN_TYPE             = PROPERTYKEY(GUID("8ABC88A8-857B-4AD7-A35A-B5942F492B99"), 2),
    SIDESHOW_CAPABILITY_SCREEN_WIDTH            = PROPERTYKEY(GUID("8ABC88A8-857B-4AD7-A35A-B5942F492B99"), 3),
    SIDESHOW_CAPABILITY_SCREEN_HEIGHT           = PROPERTYKEY(GUID("8ABC88A8-857B-4AD7-A35A-B5942F492B99"), 4),
    SIDESHOW_CAPABILITY_COLOR_DEPTH             = PROPERTYKEY(GUID("8ABC88A8-857B-4AD7-A35A-B5942F492B99"), 5),
    SIDESHOW_CAPABILITY_COLOR_TYPE              = PROPERTYKEY(GUID("8ABC88A8-857B-4AD7-A35A-B5942F492B99"), 6),
    SIDESHOW_CAPABILITY_DATA_CACHE              = PROPERTYKEY(GUID("8ABC88A8-857B-4AD7-A35A-B5942F492B99"), 7),
    SIDESHOW_CAPABILITY_SUPPORTED_LANGUAGES     = PROPERTYKEY(GUID("8ABC88A8-857B-4AD7-A35A-B5942F492B99"), 8),
    SIDESHOW_CAPABILITY_CURRENT_LANGUAGE        = PROPERTYKEY(GUID("8ABC88A8-857B-4AD7-A35A-B5942F492B99"), 9),
    SIDESHOW_CAPABILITY_SUPPORTED_THEMES        = PROPERTYKEY(GUID("8ABC88A8-857B-4AD7-A35A-B5942F492B99"), 10),
    SIDESHOW_CAPABILITY_SUPPORTED_IMAGE_FORMATS = PROPERTYKEY(GUID("8ABC88A8-857B-4AD7-A35A-B5942F492B99"), 14),
    SIDESHOW_CAPABILITY_CLIENT_AREA_WIDTH       = PROPERTYKEY(GUID("8ABC88A8-857B-4AD7-A35A-B5942F492B99"), 15),
    SIDESHOW_CAPABILITY_CLIENT_AREA_HEIGHT      = PROPERTYKEY(GUID("8ABC88A8-857B-4AD7-A35A-B5942F492B99"), 16),
}

enum GUID GUID_DEVINTERFACE_SIDESHOW = GUID("152e5811-feb9-4b00-90f4-d32947ae1681");
enum GUID SIDESHOW_CONTENT_MISSING_EVENT = GUID("5007fba8-d313-439f-bea2-a50201d3e9a8");
enum GUID SIDESHOW_APPLICATION_EVENT = GUID("4cb572fa-1d3b-49b3-a17a-2e6bff052854");
enum GUID SIDESHOW_USER_CHANGE_REQUEST_EVENT = GUID("5009673c-3f7d-4c7e-9971-eaa2e91f1575");
enum GUID SIDESHOW_NEW_EVENT_DATA_AVAILABLE = GUID("57813854-2fc1-411c-a59f-f24927608804");
enum uint CONTENT_ID_GLANCE = 0x00000000U;

enum : uint
{
    SIDESHOW_EVENTID_APPLICATION_ENTER = 0xffff0000U,
    SIDESHOW_EVENTID_APPLICATION_EXIT  = 0xffff0001U,
}

enum uint CONTENT_ID_HOME = 0x00000001U;
enum uint VERSION_1_WINDOWS_7 = 0x00000000U;

// Structs


struct SCF_EVENT_HEADER
{
    uint PreviousPage;
    uint TargetPage;
}

struct SCF_NAVIGATION_EVENT
{
    uint PreviousPage;
    uint TargetPage;
    uint Button;
}

struct SCF_MENUACTION_EVENT
{
    uint PreviousPage;
    uint TargetPage;
    uint Button;
    uint ItemId;
}

struct SCF_CONTEXTMENU_EVENT
{
    uint PreviousPage;
    uint TargetPage;
    uint PreviousItemId;
    uint MenuPage;
    uint MenuItemId;
}

struct CONTENT_MISSING_EVENT_DATA
{
align (1):
    uint cbContentMissingEventData;
    GUID ApplicationId;
    GUID EndpointId;
    uint ContentId;
}

struct APPLICATION_EVENT_DATA
{
align (1):
    uint     cbApplicationEventData;
    GUID     ApplicationId;
    GUID     EndpointId;
    uint     dwEventId;
    uint     cbEventData;
    ubyte[1] bEventData; // Flexible array
}

struct DEVICE_USER_CHANGE_EVENT_DATA
{
align (1):
    uint  cbDeviceUserChangeEventData;
    wchar wszUser;
}

struct NEW_EVENT_DATA_AVAILABLE
{
align (1):
    uint cbNewEventDataAvailable;
    uint dwVersion;
}

struct EVENT_DATA_HEADER
{
align (1):
    uint cbEventDataHeader;
    GUID guidEventType;
    uint dwVersion;
    uint cbEventDataSid;
}

// Interfaces

@GUID("e20543b9-f785-4ea2-981e-c4ffa76bbc7c")
struct SideShowSession;

@GUID("0ce3e86f-d5cd-4525-a766-1abab1a752f5")
struct SideShowNotification;

@GUID("dfbbdbf8-18de-49b8-83dc-ebc727c62d94")
struct SideShowKeyCollection;

@GUID("e640f415-539e-4923-96cd-5f093bc250cd")
struct SideShowPropVariantCollection;

@GUID("e22331ee-9e7d-4922-9fc2-ab7aa41ce491")
interface ISideShowSession : IUnknown
{
    HRESULT RegisterContent(GUID* in_applicationId, GUID* in_endpointId, ISideShowContentManager* out_ppIContent);
    HRESULT RegisterNotifications(GUID* in_applicationId, ISideShowNotificationManager* out_ppINotification);
}

@GUID("63cea909-f2b9-4302-b5e1-c68e6d9ab833")
interface ISideShowNotificationManager : IUnknown
{
    HRESULT Show(ISideShowNotification in_pINotification);
    HRESULT Revoke(const(uint) in_notificationId);
    HRESULT RevokeAll();
}

@GUID("03c93300-8ab2-41c5-9b79-46127a30e148")
interface ISideShowNotification : IUnknown
{
    HRESULT get_NotificationId(uint* out_pNotificationId);
    HRESULT put_NotificationId(uint in_notificationId);
    HRESULT get_Title(PWSTR* out_ppwszTitle);
    HRESULT put_Title(PWSTR in_pwszTitle);
    HRESULT get_Message(PWSTR* out_ppwszMessage);
    HRESULT put_Message(PWSTR in_pwszMessage);
    HRESULT get_Image(HICON* out_phIcon);
    HRESULT put_Image(HICON in_hIcon);
    HRESULT get_ExpirationTime(SYSTEMTIME* out_pTime);
    HRESULT put_ExpirationTime(SYSTEMTIME* in_pTime);
}

@GUID("a5d5b66b-eef9-41db-8d7e-e17c33ab10b0")
interface ISideShowContentManager : IUnknown
{
    HRESULT Add(ISideShowContent in_pIContent);
    HRESULT Remove(const(uint) in_contentId);
    HRESULT RemoveAll();
    HRESULT SetEventSink(ISideShowEvents in_pIEvents);
    HRESULT GetDeviceCapabilities(ISideShowCapabilitiesCollection* out_ppCollection);
}

@GUID("c18552ed-74ff-4fec-be07-4cfed29d4887")
interface ISideShowContent : IUnknown
{
    HRESULT GetContent(ISideShowCapabilities in_pICapabilities, uint* out_pdwSize, ubyte** out_ppbData);
    HRESULT get_ContentId(uint* out_pcontentId);
    HRESULT get_DifferentiateContent(BOOL* out_pfDifferentiateContent);
}

@GUID("61feca4c-deb4-4a7e-8d75-51f1132d615b")
interface ISideShowEvents : IUnknown
{
    HRESULT ContentMissing(const(uint) in_contentId, ISideShowContent* out_ppIContent);
    HRESULT ApplicationEvent(ISideShowCapabilities in_pICapabilities, const(uint) in_dwEventId, 
                             const(uint) in_dwEventSize, const(ubyte)* in_pbEventData);
    HRESULT DeviceAdded(ISideShowCapabilities in_pIDevice);
    HRESULT DeviceRemoved(ISideShowCapabilities in_pIDevice);
}

@GUID("535e1379-c09e-4a54-a511-597bab3a72b8")
interface ISideShowCapabilities : IUnknown
{
    HRESULT GetCapability(const(PROPERTYKEY)* in_keyCapability, PROPVARIANT* inout_pValue);
}

@GUID("50305597-5e0d-4ff7-b3af-33d0d9bd52dd")
interface ISideShowCapabilitiesCollection : IUnknown
{
    HRESULT GetCount(uint* out_pdwCount);
    HRESULT GetAt(uint in_dwIndex, ISideShowCapabilities* out_ppCapabilities);
}

@GUID("3a2b7fbc-3ad5-48bd-bbf1-0e6cfbd10807")
interface ISideShowBulkCapabilities : ISideShowCapabilities
{
    HRESULT GetCapabilities(ISideShowKeyCollection in_keyCollection, ISideShowPropVariantCollection* inout_pValues);
}

@GUID("045473bc-a37b-4957-b144-68105411ed8e")
interface ISideShowKeyCollection : IUnknown
{
    HRESULT Add(const(PROPERTYKEY)* Key);
    HRESULT Clear();
    HRESULT GetAt(const(uint) dwIndex, PROPERTYKEY* pKey);
    HRESULT GetCount(uint* pcElems);
    HRESULT RemoveAt(const(uint) dwIndex);
}

@GUID("2ea7a549-7bff-4aae-bab0-22d43111de49")
interface ISideShowPropVariantCollection : IUnknown
{
    HRESULT Add(const(PROPVARIANT)* pValue);
    HRESULT Clear();
    HRESULT GetAt(const(uint) dwIndex, PROPVARIANT* pValue);
    HRESULT GetCount(uint* pcElems);
    HRESULT RemoveAt(const(uint) dwIndex);
}


// GUIDs

const GUID CLSID_SideShowKeyCollection         = GUIDOF!SideShowKeyCollection;
const GUID CLSID_SideShowNotification          = GUIDOF!SideShowNotification;
const GUID CLSID_SideShowPropVariantCollection = GUIDOF!SideShowPropVariantCollection;
const GUID CLSID_SideShowSession               = GUIDOF!SideShowSession;

const GUID IID_ISideShowBulkCapabilities       = GUIDOF!ISideShowBulkCapabilities;
const GUID IID_ISideShowCapabilities           = GUIDOF!ISideShowCapabilities;
const GUID IID_ISideShowCapabilitiesCollection = GUIDOF!ISideShowCapabilitiesCollection;
const GUID IID_ISideShowContent                = GUIDOF!ISideShowContent;
const GUID IID_ISideShowContentManager         = GUIDOF!ISideShowContentManager;
const GUID IID_ISideShowEvents                 = GUIDOF!ISideShowEvents;
const GUID IID_ISideShowKeyCollection          = GUIDOF!ISideShowKeyCollection;
const GUID IID_ISideShowNotification           = GUIDOF!ISideShowNotification;
const GUID IID_ISideShowNotificationManager    = GUIDOF!ISideShowNotificationManager;
const GUID IID_ISideShowPropVariantCollection  = GUIDOF!ISideShowPropVariantCollection;
const GUID IID_ISideShowSession                = GUIDOF!ISideShowSession;
