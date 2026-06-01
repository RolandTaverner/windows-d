// Written in the D programming language.

module windows.win32.devices.humaninterfacedevice;

public import windows.core;
public import windows.win32.foundation.foundation : BOOL, BOOLEAN, CHAR, DEVPROPKEY,
                                                    FILETIME, HANDLE, HINSTANCE, HRESULT,
                                                    HWND, NTSTATUS, POINT, PSTR, PWSTR,
                                                    RECT;
public import windows.win32.system.com.com : IUnknown;
public import windows.win32.system.registry : HKEY;

extern(Windows) @nogc nothrow:


// Enums


alias HIDP_REPORT_TYPE = int;
enum : int
{
    HidP_Input   = 0x00000000,
    HidP_Output  = 0x00000001,
    HidP_Feature = 0x00000002,
}

alias HIDP_KEYBOARD_DIRECTION = int;
enum : int
{
    HidP_Keyboard_Break = 0x00000000,
    HidP_Keyboard_Make  = 0x00000001,
}

alias GPIOBUTTONS_BUTTON_TYPE = int;
enum : int
{
    GPIO_BUTTON_POWER          = 0x00000000,
    GPIO_BUTTON_WINDOWS        = 0x00000001,
    GPIO_BUTTON_VOLUME_UP      = 0x00000002,
    GPIO_BUTTON_VOLUME_DOWN    = 0x00000003,
    GPIO_BUTTON_ROTATION_LOCK  = 0x00000004,
    GPIO_BUTTON_BACK           = 0x00000005,
    GPIO_BUTTON_SEARCH         = 0x00000006,
    GPIO_BUTTON_CAMERA_FOCUS   = 0x00000007,
    GPIO_BUTTON_CAMERA_SHUTTER = 0x00000008,
    GPIO_BUTTON_RINGER_TOGGLE  = 0x00000009,
    GPIO_BUTTON_HEADSET        = 0x0000000a,
    GPIO_BUTTON_HWKB_DEPLOY    = 0x0000000b,
    GPIO_BUTTON_CAMERA_LENS    = 0x0000000c,
    GPIO_BUTTON_OEM_CUSTOM     = 0x0000000d,
    GPIO_BUTTON_OEM_CUSTOM2    = 0x0000000e,
    GPIO_BUTTON_OEM_CUSTOM3    = 0x0000000f,
    GPIO_BUTTON_COUNT_MIN      = 0x00000005,
    GPIO_BUTTON_COUNT          = 0x00000010,
}

// Constants


enum uint DIRECTINPUT_VERSION = 0x00000800U;

enum : uint
{
    JOY_HW_NONE          = 0x00000000U,
    JOY_HW_CUSTOM        = 0x00000001U,
    JOY_HW_2A_2B_GENERIC = 0x00000002U,
    JOY_HW_2A_4B_GENERIC = 0x00000003U,
}

enum : uint
{
    JOY_HW_2B_GAMEPAD            = 0x00000004U,
    JOY_HW_2B_FLIGHTYOKE         = 0x00000005U,
    JOY_HW_2B_FLIGHTYOKETHROTTLE = 0x00000006U,
}

enum : uint
{
    JOY_HW_3A_2B_GENERIC = 0x00000007U,
    JOY_HW_3A_4B_GENERIC = 0x00000008U,
}

enum : uint
{
    JOY_HW_4B_GAMEPAD            = 0x00000009U,
    JOY_HW_4B_FLIGHTYOKE         = 0x0000000aU,
    JOY_HW_4B_FLIGHTYOKETHROTTLE = 0x0000000bU,
}

enum uint JOY_HW_TWO_2A_2B_WITH_Y = 0x0000000cU;
enum uint JOY_HW_LASTENTRY = 0x0000000dU;

enum : int
{
    JOY_ISCAL_XY  = 0x00000001,
    JOY_ISCAL_Z   = 0x00000002,
    JOY_ISCAL_R   = 0x00000004,
    JOY_ISCAL_U   = 0x00000008,
    JOY_ISCAL_V   = 0x00000010,
    JOY_ISCAL_POV = 0x00000020,
}

enum : uint
{
    JOY_POV_NUMDIRS     = 0x00000004U,
    JOY_POVVAL_FORWARD  = 0x00000000U,
    JOY_POVVAL_BACKWARD = 0x00000001U,
    JOY_POVVAL_LEFT     = 0x00000002U,
    JOY_POVVAL_RIGHT    = 0x00000003U,
}

enum : int
{
    JOY_HWS_HASZ              = 0x00000001,
    JOY_HWS_HASPOV            = 0x00000002,
    JOY_HWS_POVISBUTTONCOMBOS = 0x00000004,
    JOY_HWS_POVISPOLL         = 0x00000008,
    JOY_HWS_ISYOKE            = 0x00000010,
    JOY_HWS_ISGAMEPAD         = 0x00000020,
    JOY_HWS_ISCARCTRL         = 0x00000040,
    JOY_HWS_XISJ1Y            = 0x00000080,
    JOY_HWS_XISJ2X            = 0x00000100,
    JOY_HWS_XISJ2Y            = 0x00000200,
    JOY_HWS_YISJ1X            = 0x00000400,
    JOY_HWS_YISJ2X            = 0x00000800,
    JOY_HWS_YISJ2Y            = 0x00001000,
    JOY_HWS_ZISJ1X            = 0x00002000,
    JOY_HWS_ZISJ1Y            = 0x00004000,
    JOY_HWS_ZISJ2X            = 0x00008000,
    JOY_HWS_POVISJ1X          = 0x00010000,
    JOY_HWS_POVISJ1Y          = 0x00020000,
    JOY_HWS_POVISJ2X          = 0x00040000,
    JOY_HWS_HASR              = 0x00080000,
    JOY_HWS_RISJ1X            = 0x00100000,
    JOY_HWS_RISJ1Y            = 0x00200000,
    JOY_HWS_RISJ2Y            = 0x00400000,
    JOY_HWS_HASU              = 0x00800000,
    JOY_HWS_HASV              = 0x01000000,
}

enum : int
{
    JOY_US_HASRUDDER = 0x00000001,
    JOY_US_PRESENT   = 0x00000002,
    JOY_US_ISOEM     = 0x00000004,
    JOY_US_RESERVED  = 0x80000000,
}

enum int JOYTYPE_ZEROGAMEENUMOEMDATA = 0x00000001;
enum int JOYTYPE_NOAUTODETECTGAMEPORT = 0x00000002;

enum : int
{
    JOYTYPE_NOHIDDIRECT  = 0x00000004,
    JOYTYPE_ANALOGCOMPAT = 0x00000008,
}

enum : int
{
    JOYTYPE_DEFAULTPROPSHEET  = 0x80000000,
    JOYTYPE_DEVICEHIDE        = 0x00010000,
    JOYTYPE_MOUSEHIDE         = 0x00020000,
    JOYTYPE_KEYBHIDE          = 0x00040000,
    JOYTYPE_GAMEHIDE          = 0x00080000,
    JOYTYPE_HIDEACTIVE        = 0x00100000,
    JOYTYPE_INFOMASK          = 0x00e00000,
    JOYTYPE_INFODEFAULT       = 0x00000000,
    JOYTYPE_INFOYYPEDALS      = 0x00200000,
    JOYTYPE_INFOZYPEDALS      = 0x00400000,
    JOYTYPE_INFOYRPEDALS      = 0x00600000,
    JOYTYPE_INFOZRPEDALS      = 0x00800000,
    JOYTYPE_INFOZISSLIDER     = 0x00200000,
    JOYTYPE_INFOZISZ          = 0x00400000,
    JOYTYPE_ENABLEINPUTREPORT = 0x01000000,
}

enum : uint
{
    MAX_JOYSTRING          = 0x00000100U,
    MAX_JOYSTICKOEMVXDNAME = 0x00000104U,
}

enum uint DITC_REGHWSETTINGS = 0x00000001U;
enum uint DITC_CLSIDCONFIG = 0x00000002U;
enum uint DITC_DISPLAYNAME = 0x00000004U;

enum : uint
{
    DITC_CALLOUT    = 0x00000008U,
    DITC_HARDWAREID = 0x00000010U,
}

enum : uint
{
    DITC_FLAGS1  = 0x00000020U,
    DITC_FLAGS2  = 0x00000040U,
    DITC_MAPFILE = 0x00000080U,
}

enum uint DIJC_GUIDINSTANCE = 0x00000001U;
enum uint DIJC_REGHWCONFIGTYPE = 0x00000002U;

enum : uint
{
    DIJC_GAIN        = 0x00000004U,
    DIJC_CALLOUT     = 0x00000008U,
    DIJC_WDMGAMEPORT = 0x00000010U,
}

enum uint DIJU_USERVALUES = 0x00000001U;
enum uint DIJU_GLOBALDRIVER = 0x00000002U;
enum uint DIJU_GAMEPORTEMULATOR = 0x00000004U;
enum GUID GUID_KeyboardClass = GUID("4d36e96b-e325-11ce-bfc1-08002be10318");
enum GUID GUID_MediaClass = GUID("4d36e96c-e325-11ce-bfc1-08002be10318");
enum GUID GUID_MouseClass = GUID("4d36e96f-e325-11ce-bfc1-08002be10318");
enum GUID GUID_HIDClass = GUID("745a17a0-74d3-11d0-b6fe-00a0c90f57da");

enum : /*FIELD ATTR: NativeEncodingAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ansi))], [])*/const(wchar)*
{
    DIRECTINPUT_NOTIFICATION_MSGSTRINGA = "DIRECTINPUT_NOTIFICATION_MSGSTRING",
    DIRECTINPUT_NOTIFICATION_MSGSTRINGW = "DIRECTINPUT_NOTIFICATION_MSGSTRING",
    DIRECTINPUT_NOTIFICATION_MSGSTRING  = "DIRECTINPUT_NOTIFICATION_MSGSTRING",
}

enum : uint
{
    DIMSGWP_NEWAPPSTART       = 0x00000001U,
    DIMSGWP_DX8APPSTART       = 0x00000002U,
    DIMSGWP_DX8MAPPERAPPSTART = 0x00000003U,
}

enum : uint
{
    DIAPPIDFLAG_NOTIME = 0x00000001U,
    DIAPPIDFLAG_NOSIZE = 0x00000002U,
}

enum : /*FIELD ATTR: NativeEncodingAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ansi))], [])*/const(wchar)*
{
    DIRECTINPUT_REGSTR_VAL_APPIDFLAGA  = "AppIdFlag",
    DIRECTINPUT_REGSTR_KEY_LASTAPPA    = "MostRecentApplication",
    DIRECTINPUT_REGSTR_KEY_LASTMAPAPPA = "MostRecentMapperApplication",
    DIRECTINPUT_REGSTR_VAL_VERSIONA    = "Version",
    DIRECTINPUT_REGSTR_VAL_NAMEA       = "Name",
    DIRECTINPUT_REGSTR_VAL_IDA         = "Id",
    DIRECTINPUT_REGSTR_VAL_MAPPERA     = "UsesMapper",
    DIRECTINPUT_REGSTR_VAL_LASTSTARTA  = "MostRecentStart",
    DIRECTINPUT_REGSTR_VAL_APPIDFLAGW  = "AppIdFlag",
    DIRECTINPUT_REGSTR_KEY_LASTAPPW    = "MostRecentApplication",
    DIRECTINPUT_REGSTR_KEY_LASTMAPAPPW = "MostRecentMapperApplication",
    DIRECTINPUT_REGSTR_VAL_VERSIONW    = "Version",
    DIRECTINPUT_REGSTR_VAL_NAMEW       = "Name",
    DIRECTINPUT_REGSTR_VAL_IDW         = "Id",
    DIRECTINPUT_REGSTR_VAL_MAPPERW     = "UsesMapper",
    DIRECTINPUT_REGSTR_VAL_LASTSTARTW  = "MostRecentStart",
    DIRECTINPUT_REGSTR_VAL_APPIDFLAG   = "AppIdFlag",
    DIRECTINPUT_REGSTR_KEY_LASTAPP     = "MostRecentApplication",
    DIRECTINPUT_REGSTR_KEY_LASTMAPAPP  = "MostRecentMapperApplication",
    DIRECTINPUT_REGSTR_VAL_VERSION     = "Version",
    DIRECTINPUT_REGSTR_VAL_NAME        = "Name",
    DIRECTINPUT_REGSTR_VAL_ID          = "Id",
    DIRECTINPUT_REGSTR_VAL_MAPPER      = "UsesMapper",
    DIRECTINPUT_REGSTR_VAL_LASTSTART   = "MostRecentStart",
}

enum HRESULT DIERR_NOMOREITEMS = HRESULT(0x80070103);

enum : int
{
    DIERR_DRIVERFIRST = 0x80040300,
    DIERR_DRIVERLAST  = 0x800403ff,
}

enum int DIERR_INVALIDCLASSINSTALLER = 0x80040400;
enum int DIERR_CANCELLED = 0x80040401;
enum int DIERR_BADINF = 0x80040402;
enum uint DIDIFT_DELETE = 0x01000000U;
enum GUID GUID_DEVINTERFACE_HID = GUID("4d1e55b2-f16f-11cf-88cb-001111000030");

enum : GUID
{
    GUID_HID_INTERFACE_NOTIFY   = GUID("2c4e2e88-25e6-4c33-882f-3d82e6073681"),
    GUID_HID_INTERFACE_HIDPARSE = GUID("f5c315a5-69ac-4bc2-9279-d0b64576f44b"),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3421733648, 18967, 17168, 161, 235, 36, 127, 11, 103, 89, 59}, 2))], [])*/DEVPROPKEY
{
    DEVPKEY_DeviceInterface_HID_UsagePage                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3421733648, 18967, 17168, 161, 235, 36, 127, 11, 103, 89, 59}, 2))], [])*/DEVPROPKEY(GUID("CBF38310-4A17-4310-A1EB-247F0B67593B"), 2),
    DEVPKEY_DeviceInterface_HID_UsageId                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3421733648, 18967, 17168, 161, 235, 36, 127, 11, 103, 89, 59}, 2))], [])*/DEVPROPKEY(GUID("CBF38310-4A17-4310-A1EB-247F0B67593B"), 3),
    DEVPKEY_DeviceInterface_HID_IsReadOnly               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3421733648, 18967, 17168, 161, 235, 36, 127, 11, 103, 89, 59}, 2))], [])*/DEVPROPKEY(GUID("CBF38310-4A17-4310-A1EB-247F0B67593B"), 4),
    DEVPKEY_DeviceInterface_HID_VendorId                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3421733648, 18967, 17168, 161, 235, 36, 127, 11, 103, 89, 59}, 2))], [])*/DEVPROPKEY(GUID("CBF38310-4A17-4310-A1EB-247F0B67593B"), 5),
    DEVPKEY_DeviceInterface_HID_ProductId                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3421733648, 18967, 17168, 161, 235, 36, 127, 11, 103, 89, 59}, 2))], [])*/DEVPROPKEY(GUID("CBF38310-4A17-4310-A1EB-247F0B67593B"), 6),
    DEVPKEY_DeviceInterface_HID_VersionNumber            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3421733648, 18967, 17168, 161, 235, 36, 127, 11, 103, 89, 59}, 2))], [])*/DEVPROPKEY(GUID("CBF38310-4A17-4310-A1EB-247F0B67593B"), 7),
    DEVPKEY_DeviceInterface_HID_BackgroundAccess         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3421733648, 18967, 17168, 161, 235, 36, 127, 11, 103, 89, 59}, 2))], [])*/DEVPROPKEY(GUID("CBF38310-4A17-4310-A1EB-247F0B67593B"), 8),
    DEVPKEY_DeviceInterface_HID_WakeScreenOnInputCapable = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3421733648, 18967, 17168, 161, 235, 36, 127, 11, 103, 89, 59}, 2))], [])*/DEVPROPKEY(GUID("CBF38310-4A17-4310-A1EB-247F0B67593B"), 9),
}

enum uint HID_REVISION = 0x00000001U;

enum : NTSTATUS
{
    HIDP_STATUS_SUCCESS                = NTSTATUS(0x00110000),
    HIDP_STATUS_NULL                   = NTSTATUS(0x80110001),
    HIDP_STATUS_INVALID_PREPARSED_DATA = NTSTATUS(0xc0110001),
    HIDP_STATUS_INVALID_REPORT_TYPE    = NTSTATUS(0xc0110002),
    HIDP_STATUS_INVALID_REPORT_LENGTH  = NTSTATUS(0xc0110003),
}

enum : NTSTATUS
{
    HIDP_STATUS_USAGE_NOT_FOUND    = NTSTATUS(0xc0110004),
    HIDP_STATUS_VALUE_OUT_OF_RANGE = NTSTATUS(0xc0110005),
}

enum : NTSTATUS
{
    HIDP_STATUS_BAD_LOG_PHY_VALUES     = NTSTATUS(0xc0110006),
    HIDP_STATUS_BUFFER_TOO_SMALL       = NTSTATUS(0xc0110007),
    HIDP_STATUS_INTERNAL_ERROR         = NTSTATUS(0xc0110008),
    HIDP_STATUS_I8042_TRANS_UNKNOWN    = NTSTATUS(0xc0110009),
    HIDP_STATUS_INCOMPATIBLE_REPORT_ID = NTSTATUS(0xc011000a),
}

enum : NTSTATUS
{
    HIDP_STATUS_NOT_VALUE_ARRAY         = NTSTATUS(0xc011000b),
    HIDP_STATUS_IS_VALUE_ARRAY          = NTSTATUS(0xc011000c),
    HIDP_STATUS_DATA_INDEX_NOT_FOUND    = NTSTATUS(0xc011000d),
    HIDP_STATUS_DATA_INDEX_OUT_OF_RANGE = NTSTATUS(0xc011000e),
}

enum NTSTATUS HIDP_STATUS_BUTTON_NOT_PRESSED = NTSTATUS(0xc011000f);
enum NTSTATUS HIDP_STATUS_REPORT_DOES_NOT_EXIST = NTSTATUS(0xc0110010);

enum : NTSTATUS
{
    HIDP_STATUS_NOT_IMPLEMENTED     = NTSTATUS(0xc0110020),
    HIDP_STATUS_NOT_BUTTON_ARRAY    = NTSTATUS(0xc0110021),
    HIDP_STATUS_I8242_TRANS_UNKNOWN = NTSTATUS(0xc0110009),
}

enum : ushort
{
    HID_USAGE_PAGE_UNDEFINED                     = cast(ushort) 0x0000,
    HID_USAGE_PAGE_ARCADE                        = cast(ushort) 0x0091,
    HID_USAGE_PAGE_ALPHANUMERIC                  = cast(ushort) 0x0014,
    HID_USAGE_PAGE_BARCODE_SCANNER               = cast(ushort) 0x008c,
    HID_USAGE_PAGE_BATTERY_SYSTEM                = cast(ushort) 0x0085,
    HID_USAGE_PAGE_BRAILLE_DISPLAY               = cast(ushort) 0x0041,
    HID_USAGE_PAGE_BUTTON                        = cast(ushort) 0x0009,
    HID_USAGE_PAGE_CAMERA_CONTROL                = cast(ushort) 0x0090,
    HID_USAGE_PAGE_CONSUMER                      = cast(ushort) 0x000c,
    HID_USAGE_PAGE_DIGITIZER                     = cast(ushort) 0x000d,
    HID_USAGE_PAGE_EYE_AND_HEAD_TRACKERS         = cast(ushort) 0x0012,
    HID_USAGE_PAGE_FIDO_ALLIANCE                 = cast(ushort) 0xf1d0,
    HID_USAGE_PAGE_GAME                          = cast(ushort) 0x0005,
    HID_USAGE_PAGE_GAMING_DEVICE                 = cast(ushort) 0x0092,
    HID_USAGE_PAGE_GENERIC                       = cast(ushort) 0x0001,
    HID_USAGE_PAGE_GENERIC_DEVICE                = cast(ushort) 0x0006,
    HID_USAGE_PAGE_HAPTICS                       = cast(ushort) 0x000e,
    HID_USAGE_PAGE_KEYBOARD                      = cast(ushort) 0x0007,
    HID_USAGE_PAGE_LED                           = cast(ushort) 0x0008,
    HID_USAGE_PAGE_LIGHTING_ILLUMINATION         = cast(ushort) 0x0059,
    HID_USAGE_PAGE_MAGNETIC_STRIPE_READER        = cast(ushort) 0x008e,
    HID_USAGE_PAGE_MEDICAL_INSTRUMENT            = cast(ushort) 0x0040,
    HID_USAGE_PAGE_MICROSOFT_BLUETOOTH_HANDSFREE = cast(ushort) 0xfff3,
}

enum : ushort
{
    HID_USAGE_PAGE_MONITOR               = cast(ushort) 0x0080,
    HID_USAGE_PAGE_MONITOR_ENUMERATED    = cast(ushort) 0x0081,
    HID_USAGE_PAGE_ORDINAL               = cast(ushort) 0x000a,
    HID_USAGE_PAGE_PID                   = cast(ushort) 0x000f,
    HID_USAGE_PAGE_POWER                 = cast(ushort) 0x0084,
    HID_USAGE_PAGE_WEIGHING_DEVICE       = cast(ushort) 0x008d,
    HID_USAGE_PAGE_SENSOR                = cast(ushort) 0x0020,
    HID_USAGE_PAGE_SIMULATION            = cast(ushort) 0x0002,
    HID_USAGE_PAGE_SOC                   = cast(ushort) 0x0011,
    HID_USAGE_PAGE_SPORT                 = cast(ushort) 0x0004,
    HID_USAGE_PAGE_TELEPHONY             = cast(ushort) 0x000b,
    HID_USAGE_PAGE_UNICODE               = cast(ushort) 0x0010,
    HID_USAGE_PAGE_VESA_VIRTUAL_CONTROLS = cast(ushort) 0x0082,
    HID_USAGE_PAGE_VR                    = cast(ushort) 0x0003,
    HID_USAGE_PAGE_VENDOR_DEFINED_BEGIN  = cast(ushort) 0xff00,
    HID_USAGE_PAGE_VENDOR_DEFINED_END    = cast(ushort) 0xffff,
}

enum : ushort
{
    HID_USAGE_UNDEFINED                                   = cast(ushort) 0x0000,
    HID_USAGE_ARCADE_GENERAL_PURPOSE_IO_CARD              = cast(ushort) 0x0001,
    HID_USAGE_ARCADE_COIN_DOOR                            = cast(ushort) 0x0002,
    HID_USAGE_ARCADE_WATCHDOG_TIMER                       = cast(ushort) 0x0003,
    HID_USAGE_ARCADE_GENERAL_PURPOSE_ANALOG_INPUT_STATE   = cast(ushort) 0x0030,
    HID_USAGE_ARCADE_GENERAL_PURPOSE_DIGITAL_INPUT_STATE  = cast(ushort) 0x0031,
    HID_USAGE_ARCADE_GENERAL_PURPOSE_OPTICAL_INPUT_STATE  = cast(ushort) 0x0032,
    HID_USAGE_ARCADE_GENERAL_PURPOSE_DIGITAL_OUTPUT_STATE = cast(ushort) 0x0033,
}

enum : ushort
{
    HID_USAGE_ARCADE_NUMBER_OF_COIN_DOORS         = cast(ushort) 0x0034,
    HID_USAGE_ARCADE_COIN_DRAWER_DROP_COUNT       = cast(ushort) 0x0035,
    HID_USAGE_ARCADE_COIN_DRAWER_START            = cast(ushort) 0x0036,
    HID_USAGE_ARCADE_COIN_DRAWER_SERVICE          = cast(ushort) 0x0037,
    HID_USAGE_ARCADE_COIN_DRAWER_TILT             = cast(ushort) 0x0038,
    HID_USAGE_ARCADE_COIN_DOOR_TEST               = cast(ushort) 0x0039,
    HID_USAGE_ARCADE_COIN_DOOR_LOCKOUT            = cast(ushort) 0x0040,
    HID_USAGE_ARCADE_WATCHDOG_TIMEOUT             = cast(ushort) 0x0041,
    HID_USAGE_ARCADE_WATCHDOG_ACTION              = cast(ushort) 0x0042,
    HID_USAGE_ARCADE_WATCHDOG_REBOOT              = cast(ushort) 0x0043,
    HID_USAGE_ARCADE_WATCHDOG_RESTART             = cast(ushort) 0x0044,
    HID_USAGE_ARCADE_ALARM_INPUT                  = cast(ushort) 0x0045,
    HID_USAGE_ARCADE_COIN_DOOR_COUNTER            = cast(ushort) 0x0046,
    HID_USAGE_ARCADE_IO_DIRECTION_MAPPING         = cast(ushort) 0x0047,
    HID_USAGE_ARCADE_SET_IO_DIRECTION_MAPPING     = cast(ushort) 0x0048,
    HID_USAGE_ARCADE_EXTENDED_OPTICAL_INPUT_STATE = cast(ushort) 0x0049,
}

enum : ushort
{
    HID_USAGE_ARCADE_PIN_PAD_INPUT_STATE = cast(ushort) 0x004a,
    HID_USAGE_ARCADE_PIN_PAD_STATUS      = cast(ushort) 0x004b,
    HID_USAGE_ARCADE_PIN_PAD_OUTPUT      = cast(ushort) 0x004c,
    HID_USAGE_ARCADE_PIN_PAD_COMMAND     = cast(ushort) 0x004d,
}

enum : ushort
{
    HID_USAGE_ALPHANUMERIC_ALPHANUMERIC_DISPLAY         = cast(ushort) 0x0001,
    HID_USAGE_ALPHANUMERIC_BITMAPPED_DISPLAY            = cast(ushort) 0x0002,
    HID_USAGE_ALPHANUMERIC_DISPLAY_ATTRIBUTES_REPORT    = cast(ushort) 0x0020,
    HID_USAGE_ALPHANUMERIC_ASCII_CHARACTER_SET          = cast(ushort) 0x0021,
    HID_USAGE_ALPHANUMERIC_DATA_READ_BACK               = cast(ushort) 0x0022,
    HID_USAGE_ALPHANUMERIC_FONT_READ_BACK               = cast(ushort) 0x0023,
    HID_USAGE_ALPHANUMERIC_DISPLAY_CONTROL_REPORT       = cast(ushort) 0x0024,
    HID_USAGE_ALPHANUMERIC_CLEAR_DISPLAY                = cast(ushort) 0x0025,
    HID_USAGE_ALPHANUMERIC_DISPLAY_ENABLE               = cast(ushort) 0x0026,
    HID_USAGE_ALPHANUMERIC_SCREEN_SAVER_DELAY           = cast(ushort) 0x0027,
    HID_USAGE_ALPHANUMERIC_SCREEN_SAVER_ENABLE          = cast(ushort) 0x0028,
    HID_USAGE_ALPHANUMERIC_VERTICAL_SCROLL              = cast(ushort) 0x0029,
    HID_USAGE_ALPHANUMERIC_HORIZONTAL_SCROLL            = cast(ushort) 0x002a,
    HID_USAGE_ALPHANUMERIC_CHARACTER_REPORT             = cast(ushort) 0x002b,
    HID_USAGE_ALPHANUMERIC_DISPLAY_DATA                 = cast(ushort) 0x002c,
    HID_USAGE_ALPHANUMERIC_DISPLAY_STATUS               = cast(ushort) 0x002d,
    HID_USAGE_ALPHANUMERIC_STATUS_NOT_READY             = cast(ushort) 0x002e,
    HID_USAGE_ALPHANUMERIC_STATUS_READY                 = cast(ushort) 0x002f,
    HID_USAGE_ALPHANUMERIC_ERR_NOT_A_LOADABLE_CHARACTER = cast(ushort) 0x0030,
    HID_USAGE_ALPHANUMERIC_ERR_FONT_DATA_CANNOT_BE_READ = cast(ushort) 0x0031,
    HID_USAGE_ALPHANUMERIC_CURSOR_POSITION_REPORT       = cast(ushort) 0x0032,
    HID_USAGE_ALPHANUMERIC_ROW                          = cast(ushort) 0x0033,
    HID_USAGE_ALPHANUMERIC_COLUMN                       = cast(ushort) 0x0034,
    HID_USAGE_ALPHANUMERIC_ROWS                         = cast(ushort) 0x0035,
    HID_USAGE_ALPHANUMERIC_COLUMNS                      = cast(ushort) 0x0036,
    HID_USAGE_ALPHANUMERIC_CURSOR_PIXEL_POSITIONING     = cast(ushort) 0x0037,
    HID_USAGE_ALPHANUMERIC_CURSOR_MODE                  = cast(ushort) 0x0038,
    HID_USAGE_ALPHANUMERIC_CURSOR_ENABLE                = cast(ushort) 0x0039,
    HID_USAGE_ALPHANUMERIC_CURSOR_BLINK                 = cast(ushort) 0x003a,
    HID_USAGE_ALPHANUMERIC_FONT_REPORT                  = cast(ushort) 0x003b,
    HID_USAGE_ALPHANUMERIC_FONT_DATA                    = cast(ushort) 0x003c,
    HID_USAGE_ALPHANUMERIC_CHAR_WIDTH                   = cast(ushort) 0x003d,
    HID_USAGE_ALPHANUMERIC_CHAR_HEIGHT                  = cast(ushort) 0x003e,
    HID_USAGE_ALPHANUMERIC_CHAR_SPACING_HORIZONTAL      = cast(ushort) 0x003f,
    HID_USAGE_ALPHANUMERIC_CHAR_SPACING_VERTICAL        = cast(ushort) 0x0040,
    HID_USAGE_ALPHANUMERIC_UNICODE_CHAR_SET             = cast(ushort) 0x0041,
    HID_USAGE_ALPHANUMERIC_FONT_7_SEGMENT               = cast(ushort) 0x0042,
    HID_USAGE_ALPHANUMERIC_7_SEGMENT_DIRECT_MAP         = cast(ushort) 0x0043,
    HID_USAGE_ALPHANUMERIC_FONT_14_SEGMENT              = cast(ushort) 0x0044,
    HID_USAGE_ALPHANUMERIC_14_SEGMENT_DIRECT_MAP        = cast(ushort) 0x0045,
    HID_USAGE_ALPHANUMERIC_DISPLAY_BRIGHTNESS           = cast(ushort) 0x0046,
    HID_USAGE_ALPHANUMERIC_DISPLAY_CONTRAST             = cast(ushort) 0x0047,
    HID_USAGE_ALPHANUMERIC_CHARACTER_ATTRIBUTE          = cast(ushort) 0x0048,
    HID_USAGE_ALPHANUMERIC_ATTRIBUTE_READBACK           = cast(ushort) 0x0049,
    HID_USAGE_ALPHANUMERIC_ATTRIBUTE_DATA               = cast(ushort) 0x004a,
    HID_USAGE_ALPHANUMERIC_CHAR_ATTR_ENHANCE            = cast(ushort) 0x004b,
    HID_USAGE_ALPHANUMERIC_CHAR_ATTR_UNDERLINE          = cast(ushort) 0x004c,
    HID_USAGE_ALPHANUMERIC_CHAR_ATTR_BLINK              = cast(ushort) 0x004d,
    HID_USAGE_ALPHANUMERIC_BITMAP_SIZE_X                = cast(ushort) 0x0080,
    HID_USAGE_ALPHANUMERIC_BITMAP_SIZE_Y                = cast(ushort) 0x0081,
    HID_USAGE_ALPHANUMERIC_MAX_BLIT_SIZE                = cast(ushort) 0x0082,
    HID_USAGE_ALPHANUMERIC_BIT_DEPTH_FORMAT             = cast(ushort) 0x0083,
    HID_USAGE_ALPHANUMERIC_DISPLAY_ORIENTATION          = cast(ushort) 0x0084,
    HID_USAGE_ALPHANUMERIC_PALETTE_REPORT               = cast(ushort) 0x0085,
    HID_USAGE_ALPHANUMERIC_PALETTE_DATA_SIZE            = cast(ushort) 0x0086,
    HID_USAGE_ALPHANUMERIC_PALETTE_DATA_OFFSET          = cast(ushort) 0x0087,
    HID_USAGE_ALPHANUMERIC_PALETTE_DATA                 = cast(ushort) 0x0088,
    HID_USAGE_ALPHANUMERIC_BLIT_REPORT                  = cast(ushort) 0x008a,
    HID_USAGE_ALPHANUMERIC_BLIT_RECTANGLE_X1            = cast(ushort) 0x008b,
    HID_USAGE_ALPHANUMERIC_BLIT_RECTANGLE_Y1            = cast(ushort) 0x008c,
    HID_USAGE_ALPHANUMERIC_BLIT_RECTANGLE_X2            = cast(ushort) 0x008d,
    HID_USAGE_ALPHANUMERIC_BLIT_RECTANGLE_Y2            = cast(ushort) 0x008e,
    HID_USAGE_ALPHANUMERIC_BLIT_DATA                    = cast(ushort) 0x008f,
    HID_USAGE_ALPHANUMERIC_SOFT_BUTTON                  = cast(ushort) 0x0090,
    HID_USAGE_ALPHANUMERIC_SOFT_BUTTON_ID               = cast(ushort) 0x0091,
    HID_USAGE_ALPHANUMERIC_SOFT_BUTTON_SIDE             = cast(ushort) 0x0092,
    HID_USAGE_ALPHANUMERIC_SOFT_BUTTON_OFFSET1          = cast(ushort) 0x0093,
    HID_USAGE_ALPHANUMERIC_SOFT_BUTTON_OFFSET2          = cast(ushort) 0x0094,
    HID_USAGE_ALPHANUMERIC_SOFT_BUTTON_REPORT           = cast(ushort) 0x0095,
    HID_USAGE_ALPHANUMERIC_SOFT_KEYS                    = cast(ushort) 0x00c2,
    HID_USAGE_ALPHANUMERIC_DISPLAY_DATA_EXTENSIONS      = cast(ushort) 0x00cc,
    HID_USAGE_ALPHANUMERIC_CHARACTER_MAPPING            = cast(ushort) 0x00cf,
    HID_USAGE_ALPHANUMERIC_UNICODE_EQUIVALENT           = cast(ushort) 0x00dd,
    HID_USAGE_ALPHANUMERIC_CHARACTER_PAGE_MAPPING       = cast(ushort) 0x00df,
    HID_USAGE_ALPHANUMERIC_REQUEST_REPORT               = cast(ushort) 0x00ff,
}

enum : ushort
{
    HID_USAGE_BARCODE_SCANNER_BARCODE_BADGE_READER                         = cast(ushort) 0x0001,
    HID_USAGE_BARCODE_SCANNER_BARCODE_SCANNER                              = cast(ushort) 0x0002,
    HID_USAGE_BARCODE_SCANNER_DUMB_BAR_CODE_SCANNER                        = cast(ushort) 0x0003,
    HID_USAGE_BARCODE_SCANNER_CORDLESS_SCANNER_BASE                        = cast(ushort) 0x0004,
    HID_USAGE_BARCODE_SCANNER_BAR_CODE_SCANNER_CRADLE                      = cast(ushort) 0x0005,
    HID_USAGE_BARCODE_SCANNER_ATTRIBUTE_REPORT                             = cast(ushort) 0x0010,
    HID_USAGE_BARCODE_SCANNER_SETTINGS_REPORT                              = cast(ushort) 0x0011,
    HID_USAGE_BARCODE_SCANNER_SCANNED_DATA_REPORT                          = cast(ushort) 0x0012,
    HID_USAGE_BARCODE_SCANNER_RAW_SCANNED_DATA_REPORT                      = cast(ushort) 0x0013,
    HID_USAGE_BARCODE_SCANNER_TRIGGER_REPORT                               = cast(ushort) 0x0014,
    HID_USAGE_BARCODE_SCANNER_STATUS_REPORT                                = cast(ushort) 0x0015,
    HID_USAGE_BARCODE_SCANNER_UPCEAN_CONTROL_REPORT                        = cast(ushort) 0x0016,
    HID_USAGE_BARCODE_SCANNER_EAN_23_LABEL_CONTROL_REPORT                  = cast(ushort) 0x0017,
    HID_USAGE_BARCODE_SCANNER_CODE_39_CONTROL_REPORT                       = cast(ushort) 0x0018,
    HID_USAGE_BARCODE_SCANNER_INTERLEAVED_2_OF_5_CONTROL_REPORT            = cast(ushort) 0x0019,
    HID_USAGE_BARCODE_SCANNER_STANDARD_2_OF_5_CONTROL_REPORT               = cast(ushort) 0x001a,
    HID_USAGE_BARCODE_SCANNER_MSI_PLESSEY_CONTROL_REPORT                   = cast(ushort) 0x001b,
    HID_USAGE_BARCODE_SCANNER_CODABAR_CONTROL_REPORT                       = cast(ushort) 0x001c,
    HID_USAGE_BARCODE_SCANNER_CODE_128_CONTROL_REPORT                      = cast(ushort) 0x001d,
    HID_USAGE_BARCODE_SCANNER_MISC_1D_CONTROL_REPORT                       = cast(ushort) 0x001e,
    HID_USAGE_BARCODE_SCANNER_2D_CONTROL_REPORT                            = cast(ushort) 0x001f,
    HID_USAGE_BARCODE_SCANNER_AIMINGPOINTER_MODE                           = cast(ushort) 0x0030,
    HID_USAGE_BARCODE_SCANNER_BAR_CODE_PRESENT_SENSOR                      = cast(ushort) 0x0031,
    HID_USAGE_BARCODE_SCANNER_CLASS_1A_LASER                               = cast(ushort) 0x0032,
    HID_USAGE_BARCODE_SCANNER_CLASS_2_LASER                                = cast(ushort) 0x0033,
    HID_USAGE_BARCODE_SCANNER_HEATER_PRESENT                               = cast(ushort) 0x0034,
    HID_USAGE_BARCODE_SCANNER_CONTACT_SCANNER                              = cast(ushort) 0x0035,
    HID_USAGE_BARCODE_SCANNER_ELECTRONIC_ARTICLE_SURVEILLANCE_NOTIFICATION = cast(ushort) 0x0036,
}

enum ushort HID_USAGE_BARCODE_SCANNER_CONSTANT_ELECTRONIC_ARTICLE_SURVEILLANCE = cast(ushort) 0x0037;

enum : ushort
{
    HID_USAGE_BARCODE_SCANNER_ERROR_INDICATION                          = cast(ushort) 0x0038,
    HID_USAGE_BARCODE_SCANNER_FIXED_BEEPER                              = cast(ushort) 0x0039,
    HID_USAGE_BARCODE_SCANNER_GOOD_DECODE_INDICATION                    = cast(ushort) 0x003a,
    HID_USAGE_BARCODE_SCANNER_HANDS_FREE_SCANNING                       = cast(ushort) 0x003b,
    HID_USAGE_BARCODE_SCANNER_INTRINSICALLY_SAFE                        = cast(ushort) 0x003c,
    HID_USAGE_BARCODE_SCANNER_KLASSE_EINS_LASER                         = cast(ushort) 0x003d,
    HID_USAGE_BARCODE_SCANNER_LONG_RANGE_SCANNER                        = cast(ushort) 0x003e,
    HID_USAGE_BARCODE_SCANNER_MIRROR_SPEED_CONTROL                      = cast(ushort) 0x003f,
    HID_USAGE_BARCODE_SCANNER_NOT_ON_FILE_INDICATION                    = cast(ushort) 0x0040,
    HID_USAGE_BARCODE_SCANNER_PROGRAMMABLE_BEEPER                       = cast(ushort) 0x0041,
    HID_USAGE_BARCODE_SCANNER_TRIGGERLESS                               = cast(ushort) 0x0042,
    HID_USAGE_BARCODE_SCANNER_WAND                                      = cast(ushort) 0x0043,
    HID_USAGE_BARCODE_SCANNER_WATER_RESISTANT                           = cast(ushort) 0x0044,
    HID_USAGE_BARCODE_SCANNER_MULTIRANGE_SCANNER                        = cast(ushort) 0x0045,
    HID_USAGE_BARCODE_SCANNER_PROXIMITY_SENSOR                          = cast(ushort) 0x0046,
    HID_USAGE_BARCODE_SCANNER_FRAGMENT_DECODING                         = cast(ushort) 0x004d,
    HID_USAGE_BARCODE_SCANNER_SCANNER_READ_CONFIDENCE                   = cast(ushort) 0x004e,
    HID_USAGE_BARCODE_SCANNER_DATA_PREFIX                               = cast(ushort) 0x004f,
    HID_USAGE_BARCODE_SCANNER_PREFIX_AIMI                               = cast(ushort) 0x0050,
    HID_USAGE_BARCODE_SCANNER_PREFIX_NONE                               = cast(ushort) 0x0051,
    HID_USAGE_BARCODE_SCANNER_PREFIX_PROPRIETARY                        = cast(ushort) 0x0052,
    HID_USAGE_BARCODE_SCANNER_ACTIVE_TIME                               = cast(ushort) 0x0055,
    HID_USAGE_BARCODE_SCANNER_AIMING_LASER_PATTERN                      = cast(ushort) 0x0056,
    HID_USAGE_BARCODE_SCANNER_BAR_CODE_PRESENT                          = cast(ushort) 0x0057,
    HID_USAGE_BARCODE_SCANNER_BEEPER_STATE                              = cast(ushort) 0x0058,
    HID_USAGE_BARCODE_SCANNER_LASER_ON_TIME                             = cast(ushort) 0x0059,
    HID_USAGE_BARCODE_SCANNER_LASER_STATE                               = cast(ushort) 0x005a,
    HID_USAGE_BARCODE_SCANNER_LOCKOUT_TIME                              = cast(ushort) 0x005b,
    HID_USAGE_BARCODE_SCANNER_MOTOR_STATE                               = cast(ushort) 0x005c,
    HID_USAGE_BARCODE_SCANNER_MOTOR_TIMEOUT                             = cast(ushort) 0x005d,
    HID_USAGE_BARCODE_SCANNER_POWER_ON_RESET_SCANNER                    = cast(ushort) 0x005e,
    HID_USAGE_BARCODE_SCANNER_PREVENT_READ_OF_BARCODES                  = cast(ushort) 0x005f,
    HID_USAGE_BARCODE_SCANNER_INITIATE_BARCODE_READ                     = cast(ushort) 0x0060,
    HID_USAGE_BARCODE_SCANNER_TRIGGER_STATE                             = cast(ushort) 0x0061,
    HID_USAGE_BARCODE_SCANNER_TRIGGER_MODE                              = cast(ushort) 0x0062,
    HID_USAGE_BARCODE_SCANNER_TRIGGER_MODE_BLINKING_LASER_ON            = cast(ushort) 0x0063,
    HID_USAGE_BARCODE_SCANNER_TRIGGER_MODE_CONTINUOUS_LASER_ON          = cast(ushort) 0x0064,
    HID_USAGE_BARCODE_SCANNER_TRIGGER_MODE_LASER_ON_WHILE_PULLED        = cast(ushort) 0x0065,
    HID_USAGE_BARCODE_SCANNER_TRIGGER_MODE_LASER_STAYS_ON_AFTER_RELEASE = cast(ushort) 0x0066,
}

enum : ushort
{
    HID_USAGE_BARCODE_SCANNER_COMMIT_PARAMETERS_TO_NVM                   = cast(ushort) 0x006d,
    HID_USAGE_BARCODE_SCANNER_PARAMETER_SCANNING                         = cast(ushort) 0x006e,
    HID_USAGE_BARCODE_SCANNER_PARAMETERS_CHANGED                         = cast(ushort) 0x006f,
    HID_USAGE_BARCODE_SCANNER_SET_PARAMETER_DEFAULT_VALUES               = cast(ushort) 0x0070,
    HID_USAGE_BARCODE_SCANNER_SCANNER_IN_CRADLE                          = cast(ushort) 0x0075,
    HID_USAGE_BARCODE_SCANNER_SCANNER_IN_RANGE                           = cast(ushort) 0x0076,
    HID_USAGE_BARCODE_SCANNER_AIM_DURATION                               = cast(ushort) 0x007a,
    HID_USAGE_BARCODE_SCANNER_GOOD_READ_LAMP_DURATION                    = cast(ushort) 0x007b,
    HID_USAGE_BARCODE_SCANNER_GOOD_READ_LAMP_INTENSITY                   = cast(ushort) 0x007c,
    HID_USAGE_BARCODE_SCANNER_GOOD_READ_LED                              = cast(ushort) 0x007d,
    HID_USAGE_BARCODE_SCANNER_GOOD_READ_TONE_FREQUENCY                   = cast(ushort) 0x007e,
    HID_USAGE_BARCODE_SCANNER_GOOD_READ_TONE_LENGTH                      = cast(ushort) 0x007f,
    HID_USAGE_BARCODE_SCANNER_GOOD_READ_TONE_VOLUME                      = cast(ushort) 0x0080,
    HID_USAGE_BARCODE_SCANNER_NO_READ_MESSAGE                            = cast(ushort) 0x0082,
    HID_USAGE_BARCODE_SCANNER_NOT_ON_FILE_VOLUME                         = cast(ushort) 0x0083,
    HID_USAGE_BARCODE_SCANNER_POWERUP_BEEP                               = cast(ushort) 0x0084,
    HID_USAGE_BARCODE_SCANNER_SOUND_ERROR_BEEP                           = cast(ushort) 0x0085,
    HID_USAGE_BARCODE_SCANNER_SOUND_GOOD_READ_BEEP                       = cast(ushort) 0x0086,
    HID_USAGE_BARCODE_SCANNER_SOUND_NOT_ON_FILE_BEEP                     = cast(ushort) 0x0087,
    HID_USAGE_BARCODE_SCANNER_GOOD_READ_WHEN_TO_WRITE                    = cast(ushort) 0x0088,
    HID_USAGE_BARCODE_SCANNER_GRWTI_AFTER_DECODE                         = cast(ushort) 0x0089,
    HID_USAGE_BARCODE_SCANNER_GRWTI_BEEPLAMP_AFTER_TRANSMIT              = cast(ushort) 0x008a,
    HID_USAGE_BARCODE_SCANNER_GRWTI_NO_BEEPLAMP_USE_AT_ALL               = cast(ushort) 0x008b,
    HID_USAGE_BARCODE_SCANNER_BOOKLAND_EAN                               = cast(ushort) 0x0091,
    HID_USAGE_BARCODE_SCANNER_CONVERT_EAN_8_TO_13_TYPE                   = cast(ushort) 0x0092,
    HID_USAGE_BARCODE_SCANNER_CONVERT_UPC_A_TO_EAN13                     = cast(ushort) 0x0093,
    HID_USAGE_BARCODE_SCANNER_CONVERT_UPCE_TO_A                          = cast(ushort) 0x0094,
    HID_USAGE_BARCODE_SCANNER_EAN13                                      = cast(ushort) 0x0095,
    HID_USAGE_BARCODE_SCANNER_EAN8                                       = cast(ushort) 0x0096,
    HID_USAGE_BARCODE_SCANNER_EAN99_128_MANDATORY                        = cast(ushort) 0x0097,
    HID_USAGE_BARCODE_SCANNER_EAN99_P5128_OPTIONAL                       = cast(ushort) 0x0098,
    HID_USAGE_BARCODE_SCANNER_ENABLE_EAN_TWO_LABEL                       = cast(ushort) 0x0099,
    HID_USAGE_BARCODE_SCANNER_UPCEAN                                     = cast(ushort) 0x009a,
    HID_USAGE_BARCODE_SCANNER_UPCEAN_COUPON_CODE                         = cast(ushort) 0x009b,
    HID_USAGE_BARCODE_SCANNER_UPCEAN_PERIODICALS                         = cast(ushort) 0x009c,
    HID_USAGE_BARCODE_SCANNER_UPCA                                       = cast(ushort) 0x009d,
    HID_USAGE_BARCODE_SCANNER_UPCA_WITH_128_MANDATORY                    = cast(ushort) 0x009e,
    HID_USAGE_BARCODE_SCANNER_UPCA_WITH_128_OPTIONAL                     = cast(ushort) 0x009f,
    HID_USAGE_BARCODE_SCANNER_UPCA_WITH_P5_OPTIONAL                      = cast(ushort) 0x00a0,
    HID_USAGE_BARCODE_SCANNER_UPCE                                       = cast(ushort) 0x00a1,
    HID_USAGE_BARCODE_SCANNER_UPCE1                                      = cast(ushort) 0x00a2,
    HID_USAGE_BARCODE_SCANNER_PERIODICAL                                 = cast(ushort) 0x00a9,
    HID_USAGE_BARCODE_SCANNER_PERIODICAL_AUTODISCRIMINATE_2              = cast(ushort) 0x00aa,
    HID_USAGE_BARCODE_SCANNER_PERIODICAL_ONLY_DECODE_WITH_2              = cast(ushort) 0x00ab,
    HID_USAGE_BARCODE_SCANNER_PERIODICAL_IGNORE_2                        = cast(ushort) 0x00ac,
    HID_USAGE_BARCODE_SCANNER_PERIODICAL_AUTODISCRIMINATE_5              = cast(ushort) 0x00ad,
    HID_USAGE_BARCODE_SCANNER_PERIODICAL_ONLY_DECODE_WITH_5              = cast(ushort) 0x00ae,
    HID_USAGE_BARCODE_SCANNER_PERIODICAL_IGNORE_5                        = cast(ushort) 0x00af,
    HID_USAGE_BARCODE_SCANNER_CHECK                                      = cast(ushort) 0x00b0,
    HID_USAGE_BARCODE_SCANNER_CHECK_DISABLE_PRICE                        = cast(ushort) 0x00b1,
    HID_USAGE_BARCODE_SCANNER_CHECK_ENABLE_4_DIGIT_PRICE                 = cast(ushort) 0x00b2,
    HID_USAGE_BARCODE_SCANNER_CHECK_ENABLE_5_DIGIT_PRICE                 = cast(ushort) 0x00b3,
    HID_USAGE_BARCODE_SCANNER_CHECK_ENABLE_EUROPEAN_4_DIGIT_PRICE        = cast(ushort) 0x00b4,
    HID_USAGE_BARCODE_SCANNER_CHECK_ENABLE_EUROPEAN_5_DIGIT_PRICE        = cast(ushort) 0x00b5,
    HID_USAGE_BARCODE_SCANNER_EAN_TWO_LABEL                              = cast(ushort) 0x00b7,
    HID_USAGE_BARCODE_SCANNER_EAN_THREE_LABEL                            = cast(ushort) 0x00b8,
    HID_USAGE_BARCODE_SCANNER_EAN_8_FLAG_DIGIT_1                         = cast(ushort) 0x00b9,
    HID_USAGE_BARCODE_SCANNER_EAN_8_FLAG_DIGIT_2                         = cast(ushort) 0x00ba,
    HID_USAGE_BARCODE_SCANNER_EAN_8_FLAG_DIGIT_3                         = cast(ushort) 0x00bb,
    HID_USAGE_BARCODE_SCANNER_EAN_13_FLAG_DIGIT_1                        = cast(ushort) 0x00bc,
    HID_USAGE_BARCODE_SCANNER_EAN_13_FLAG_DIGIT_2                        = cast(ushort) 0x00bd,
    HID_USAGE_BARCODE_SCANNER_EAN_13_FLAG_DIGIT_3                        = cast(ushort) 0x00be,
    HID_USAGE_BARCODE_SCANNER_ADD_EAN_23_LABEL_DEFINITION                = cast(ushort) 0x00bf,
    HID_USAGE_BARCODE_SCANNER_CLEAR_ALL_EAN_23_LABEL_DEFINITIONS         = cast(ushort) 0x00c0,
    HID_USAGE_BARCODE_SCANNER_CODABAR                                    = cast(ushort) 0x00c3,
    HID_USAGE_BARCODE_SCANNER_CODE_128                                   = cast(ushort) 0x00c4,
    HID_USAGE_BARCODE_SCANNER_CODE_39                                    = cast(ushort) 0x00c7,
    HID_USAGE_BARCODE_SCANNER_CODE_93                                    = cast(ushort) 0x00c8,
    HID_USAGE_BARCODE_SCANNER_FULL_ASCII_CONVERSION                      = cast(ushort) 0x00c9,
    HID_USAGE_BARCODE_SCANNER_INTERLEAVED_2_OF_5                         = cast(ushort) 0x00ca,
    HID_USAGE_BARCODE_SCANNER_ITALIAN_PHARMACY_CODE                      = cast(ushort) 0x00cb,
    HID_USAGE_BARCODE_SCANNER_MSIPLESSEY                                 = cast(ushort) 0x00cc,
    HID_USAGE_BARCODE_SCANNER_STANDARD_2_OF_5_IATA                       = cast(ushort) 0x00cd,
    HID_USAGE_BARCODE_SCANNER_STANDARD_2_OF_5                            = cast(ushort) 0x00ce,
    HID_USAGE_BARCODE_SCANNER_TRANSMIT_STARTSTOP                         = cast(ushort) 0x00d3,
    HID_USAGE_BARCODE_SCANNER_TRIOPTIC                                   = cast(ushort) 0x00d4,
    HID_USAGE_BARCODE_SCANNER_UCCEAN128                                  = cast(ushort) 0x00d5,
    HID_USAGE_BARCODE_SCANNER_CHECK_DIGIT                                = cast(ushort) 0x00d6,
    HID_USAGE_BARCODE_SCANNER_CHECK_DIGIT_DISABLE                        = cast(ushort) 0x00d7,
    HID_USAGE_BARCODE_SCANNER_CHECK_DIGIT_ENABLE_INTERLEAVED_2_OF_5_OPCC = cast(ushort) 0x00d8,
    HID_USAGE_BARCODE_SCANNER_CHECK_DIGIT_ENABLE_INTERLEAVED_2_OF_5_USS  = cast(ushort) 0x00d9,
    HID_USAGE_BARCODE_SCANNER_CHECK_DIGIT_ENABLE_STANDARD_2_OF_5_OPCC    = cast(ushort) 0x00da,
    HID_USAGE_BARCODE_SCANNER_CHECK_DIGIT_ENABLE_STANDARD_2_OF_5_USS     = cast(ushort) 0x00db,
    HID_USAGE_BARCODE_SCANNER_CHECK_DIGIT_ENABLE_ONE_MSI_PLESSEY         = cast(ushort) 0x00dc,
    HID_USAGE_BARCODE_SCANNER_CHECK_DIGIT_ENABLE_TWO_MSI_PLESSEY         = cast(ushort) 0x00dd,
    HID_USAGE_BARCODE_SCANNER_CHECK_DIGIT_CODABAR_ENABLE                 = cast(ushort) 0x00de,
    HID_USAGE_BARCODE_SCANNER_CHECK_DIGIT_CODE_39_ENABLE                 = cast(ushort) 0x00df,
    HID_USAGE_BARCODE_SCANNER_TRANSMIT_CHECK_DIGIT                       = cast(ushort) 0x00f0,
    HID_USAGE_BARCODE_SCANNER_DISABLE_CHECK_DIGIT_TRANSMIT               = cast(ushort) 0x00f1,
    HID_USAGE_BARCODE_SCANNER_ENABLE_CHECK_DIGIT_TRANSMIT                = cast(ushort) 0x00f2,
    HID_USAGE_BARCODE_SCANNER_SYMBOLOGY_IDENTIFIER_1                     = cast(ushort) 0x00fb,
    HID_USAGE_BARCODE_SCANNER_SYMBOLOGY_IDENTIFIER_2                     = cast(ushort) 0x00fc,
    HID_USAGE_BARCODE_SCANNER_SYMBOLOGY_IDENTIFIER_3                     = cast(ushort) 0x00fd,
    HID_USAGE_BARCODE_SCANNER_DECODED_DATA                               = cast(ushort) 0x00fe,
    HID_USAGE_BARCODE_SCANNER_DECODE_DATA_CONTINUED                      = cast(ushort) 0x00ff,
    HID_USAGE_BARCODE_SCANNER_BAR_SPACE_DATA                             = cast(ushort) 0x0100,
    HID_USAGE_BARCODE_SCANNER_SCANNER_DATA_ACCURACY                      = cast(ushort) 0x0101,
    HID_USAGE_BARCODE_SCANNER_RAW_DATA_POLARITY                          = cast(ushort) 0x0102,
    HID_USAGE_BARCODE_SCANNER_POLARITY_INVERTED_BAR_CODE                 = cast(ushort) 0x0103,
    HID_USAGE_BARCODE_SCANNER_POLARITY_NORMAL_BAR_CODE                   = cast(ushort) 0x0104,
    HID_USAGE_BARCODE_SCANNER_MINIMUM_LENGTH_TO_DECODE                   = cast(ushort) 0x0106,
    HID_USAGE_BARCODE_SCANNER_MAXIMUM_LENGTH_TO_DECODE                   = cast(ushort) 0x0107,
    HID_USAGE_BARCODE_SCANNER_DISCRETE_LENGTH_TO_DECODE_1                = cast(ushort) 0x0108,
    HID_USAGE_BARCODE_SCANNER_DISCRETE_LENGTH_TO_DECODE_2                = cast(ushort) 0x0109,
    HID_USAGE_BARCODE_SCANNER_DATA_LENGTH_METHOD                         = cast(ushort) 0x010a,
    HID_USAGE_BARCODE_SCANNER_DL_METHOD_READ_ANY                         = cast(ushort) 0x010b,
    HID_USAGE_BARCODE_SCANNER_DL_METHOD_CHECK_IN_RANGE                   = cast(ushort) 0x010c,
    HID_USAGE_BARCODE_SCANNER_DL_METHOD_CHECK_FOR_DISCRETE               = cast(ushort) 0x010d,
    HID_USAGE_BARCODE_SCANNER_AZTEC_CODE                                 = cast(ushort) 0x0110,
    HID_USAGE_BARCODE_SCANNER_BC412                                      = cast(ushort) 0x0111,
    HID_USAGE_BARCODE_SCANNER_CHANNEL_CODE                               = cast(ushort) 0x0112,
    HID_USAGE_BARCODE_SCANNER_CODE_16                                    = cast(ushort) 0x0113,
    HID_USAGE_BARCODE_SCANNER_CODE_32                                    = cast(ushort) 0x0114,
    HID_USAGE_BARCODE_SCANNER_CODE_49                                    = cast(ushort) 0x0115,
    HID_USAGE_BARCODE_SCANNER_CODE_ONE                                   = cast(ushort) 0x0116,
    HID_USAGE_BARCODE_SCANNER_COLORCODE                                  = cast(ushort) 0x0117,
    HID_USAGE_BARCODE_SCANNER_DATA_MATRIX                                = cast(ushort) 0x0118,
    HID_USAGE_BARCODE_SCANNER_MAXICODE                                   = cast(ushort) 0x0119,
    HID_USAGE_BARCODE_SCANNER_MICROPDF                                   = cast(ushort) 0x011a,
    HID_USAGE_BARCODE_SCANNER_PDF417                                     = cast(ushort) 0x011b,
    HID_USAGE_BARCODE_SCANNER_POSICODE                                   = cast(ushort) 0x011c,
    HID_USAGE_BARCODE_SCANNER_QR_CODE                                    = cast(ushort) 0x011d,
    HID_USAGE_BARCODE_SCANNER_SUPERCODE                                  = cast(ushort) 0x011e,
    HID_USAGE_BARCODE_SCANNER_ULTRACODE                                  = cast(ushort) 0x011f,
    HID_USAGE_BARCODE_SCANNER_USD5_SLUG_CODE                             = cast(ushort) 0x0120,
    HID_USAGE_BARCODE_SCANNER_VERICODE                                   = cast(ushort) 0x0121,
}

enum : ushort
{
    HID_USAGE_BATTERY_SYSTEM_SMART_BATTERY_BATTERY_MODE      = cast(ushort) 0x0001,
    HID_USAGE_BATTERY_SYSTEM_SMART_BATTERY_BATTERY_STATUS    = cast(ushort) 0x0002,
    HID_USAGE_BATTERY_SYSTEM_SMART_BATTERY_ALARM_WARNING     = cast(ushort) 0x0003,
    HID_USAGE_BATTERY_SYSTEM_SMART_BATTERY_CHARGER_MODE      = cast(ushort) 0x0004,
    HID_USAGE_BATTERY_SYSTEM_SMART_BATTERY_CHARGER_STATUS    = cast(ushort) 0x0005,
    HID_USAGE_BATTERY_SYSTEM_SMART_BATTERY_CHARGER_SPEC_INFO = cast(ushort) 0x0006,
    HID_USAGE_BATTERY_SYSTEM_SMART_BATTERY_SELECTOR_STATE    = cast(ushort) 0x0007,
    HID_USAGE_BATTERY_SYSTEM_SMART_BATTERY_SELECTOR_PRESETS  = cast(ushort) 0x0008,
    HID_USAGE_BATTERY_SYSTEM_SMART_BATTERY_SELECTOR_INFO     = cast(ushort) 0x0009,
    HID_USAGE_BATTERY_SYSTEM_OPTIONAL_MFG_FUNCTION_1         = cast(ushort) 0x0010,
    HID_USAGE_BATTERY_SYSTEM_OPTIONAL_MFG_FUNCTION_2         = cast(ushort) 0x0011,
    HID_USAGE_BATTERY_SYSTEM_OPTIONAL_MFG_FUNCTION_3         = cast(ushort) 0x0012,
    HID_USAGE_BATTERY_SYSTEM_OPTIONAL_MFG_FUNCTION_4         = cast(ushort) 0x0013,
    HID_USAGE_BATTERY_SYSTEM_OPTIONAL_MFG_FUNCTION_5         = cast(ushort) 0x0014,
    HID_USAGE_BATTERY_SYSTEM_CONNECTION_TO_SM_BUS            = cast(ushort) 0x0015,
    HID_USAGE_BATTERY_SYSTEM_OUTPUT_CONNECTION               = cast(ushort) 0x0016,
    HID_USAGE_BATTERY_SYSTEM_CHARGER_CONNECTION              = cast(ushort) 0x0017,
    HID_USAGE_BATTERY_SYSTEM_BATTERY_INSERTION               = cast(ushort) 0x0018,
    HID_USAGE_BATTERY_SYSTEM_USE_NEXT                        = cast(ushort) 0x0019,
    HID_USAGE_BATTERY_SYSTEM_OK_TO_USE                       = cast(ushort) 0x001a,
    HID_USAGE_BATTERY_SYSTEM_BATTERY_SUPPORTED               = cast(ushort) 0x001b,
    HID_USAGE_BATTERY_SYSTEM_SELECTOR_REVISION               = cast(ushort) 0x001c,
    HID_USAGE_BATTERY_SYSTEM_CHARGING_INDICATOR              = cast(ushort) 0x001d,
    HID_USAGE_BATTERY_SYSTEM_MANUFACTURER_ACCESS             = cast(ushort) 0x0028,
    HID_USAGE_BATTERY_SYSTEM_REMAINING_CAPACITY_LIMIT        = cast(ushort) 0x0029,
    HID_USAGE_BATTERY_SYSTEM_REMAINING_TIME_LIMIT            = cast(ushort) 0x002a,
    HID_USAGE_BATTERY_SYSTEM_AT_RATE                         = cast(ushort) 0x002b,
    HID_USAGE_BATTERY_SYSTEM_CAPACITY_MODE                   = cast(ushort) 0x002c,
    HID_USAGE_BATTERY_SYSTEM_BROADCAST_TO_CHARGER            = cast(ushort) 0x002d,
    HID_USAGE_BATTERY_SYSTEM_PRIMARY_BATTERY                 = cast(ushort) 0x002e,
    HID_USAGE_BATTERY_SYSTEM_CHARGE_CONTROLLER               = cast(ushort) 0x002f,
    HID_USAGE_BATTERY_SYSTEM_TERMINATE_CHARGE                = cast(ushort) 0x0040,
    HID_USAGE_BATTERY_SYSTEM_TERMINATE_DISCHARGE             = cast(ushort) 0x0041,
    HID_USAGE_BATTERY_SYSTEM_BELOW_REMAINING_CAPACITY_LIMIT  = cast(ushort) 0x0042,
    HID_USAGE_BATTERY_SYSTEM_REMAINING_TIME_LIMIT_EXPIRED    = cast(ushort) 0x0043,
    HID_USAGE_BATTERY_SYSTEM_CHARGING                        = cast(ushort) 0x0044,
    HID_USAGE_BATTERY_SYSTEM_DISCHARGING                     = cast(ushort) 0x0045,
    HID_USAGE_BATTERY_SYSTEM_FULLY_CHARGED                   = cast(ushort) 0x0046,
    HID_USAGE_BATTERY_SYSTEM_FULLY_DISCHARGED                = cast(ushort) 0x0047,
    HID_USAGE_BATTERY_SYSTEM_CONDITIONING_FLAG               = cast(ushort) 0x0048,
    HID_USAGE_BATTERY_SYSTEM_AT_RATE_OK                      = cast(ushort) 0x0049,
    HID_USAGE_BATTERY_SYSTEM_SMART_BATTERY_ERROR_CODE        = cast(ushort) 0x004a,
    HID_USAGE_BATTERY_SYSTEM_NEED_REPLACEMENT                = cast(ushort) 0x004b,
    HID_USAGE_BATTERY_SYSTEM_AT_RATE_TIME_TO_FULL            = cast(ushort) 0x0060,
    HID_USAGE_BATTERY_SYSTEM_AT_RATE_TIME_TO_EMPTY           = cast(ushort) 0x0061,
    HID_USAGE_BATTERY_SYSTEM_AVERAGE_CURRENT                 = cast(ushort) 0x0062,
    HID_USAGE_BATTERY_SYSTEM_MAX_ERROR                       = cast(ushort) 0x0063,
    HID_USAGE_BATTERY_SYSTEM_RELATIVE_STATE_OF_CHARGE        = cast(ushort) 0x0064,
    HID_USAGE_BATTERY_SYSTEM_ABSOLUTE_STATE_OF_CHARGE        = cast(ushort) 0x0065,
    HID_USAGE_BATTERY_SYSTEM_REMAINING_CAPACITY              = cast(ushort) 0x0066,
    HID_USAGE_BATTERY_SYSTEM_FULL_CHARGE_CAPACITY            = cast(ushort) 0x0067,
    HID_USAGE_BATTERY_SYSTEM_RUN_TIME_TO_EMPTY               = cast(ushort) 0x0068,
    HID_USAGE_BATTERY_SYSTEM_AVERAGE_TIME_TO_EMPTY           = cast(ushort) 0x0069,
    HID_USAGE_BATTERY_SYSTEM_AVERAGE_TIME_TO_FULL            = cast(ushort) 0x006a,
    HID_USAGE_BATTERY_SYSTEM_CYCLE_COUNT                     = cast(ushort) 0x006b,
    HID_USAGE_BATTERY_SYSTEM_BATTERY_PACK_MODEL_LEVEL        = cast(ushort) 0x0080,
    HID_USAGE_BATTERY_SYSTEM_INTERNAL_CHARGE_CONTROLLER      = cast(ushort) 0x0081,
    HID_USAGE_BATTERY_SYSTEM_PRIMARY_BATTERY_SUPPORT         = cast(ushort) 0x0082,
    HID_USAGE_BATTERY_SYSTEM_DESIGN_CAPACITY                 = cast(ushort) 0x0083,
    HID_USAGE_BATTERY_SYSTEM_SPECIFICATION_INFO              = cast(ushort) 0x0084,
    HID_USAGE_BATTERY_SYSTEM_MANUFACTURE_DATE                = cast(ushort) 0x0085,
    HID_USAGE_BATTERY_SYSTEM_SERIAL_NUMBER                   = cast(ushort) 0x0086,
    HID_USAGE_BATTERY_SYSTEM_IMANUFACTURER_NAME              = cast(ushort) 0x0087,
    HID_USAGE_BATTERY_SYSTEM_IDEVICE_NAME                    = cast(ushort) 0x0088,
    HID_USAGE_BATTERY_SYSTEM_IDEVICE_CHEMISTRY               = cast(ushort) 0x0089,
    HID_USAGE_BATTERY_SYSTEM_MANUFACTURER_DATA               = cast(ushort) 0x008a,
    HID_USAGE_BATTERY_SYSTEM_RECHARGABLE                     = cast(ushort) 0x008b,
    HID_USAGE_BATTERY_SYSTEM_WARNING_CAPACITY_LIMIT          = cast(ushort) 0x008c,
    HID_USAGE_BATTERY_SYSTEM_CAPACITY_GRANULARITY_1          = cast(ushort) 0x008d,
    HID_USAGE_BATTERY_SYSTEM_CAPACITY_GRANULARITY_2          = cast(ushort) 0x008e,
    HID_USAGE_BATTERY_SYSTEM_IOEM_INFORMATION                = cast(ushort) 0x008f,
    HID_USAGE_BATTERY_SYSTEM_INHIBIT_CHARGE                  = cast(ushort) 0x00c0,
    HID_USAGE_BATTERY_SYSTEM_ENABLE_POLLING                  = cast(ushort) 0x00c1,
    HID_USAGE_BATTERY_SYSTEM_RESET_TO_ZERO                   = cast(ushort) 0x00c2,
    HID_USAGE_BATTERY_SYSTEM_AC_PRESENT                      = cast(ushort) 0x00d0,
    HID_USAGE_BATTERY_SYSTEM_BATTERY_PRESENT                 = cast(ushort) 0x00d1,
    HID_USAGE_BATTERY_SYSTEM_POWER_FAIL                      = cast(ushort) 0x00d2,
    HID_USAGE_BATTERY_SYSTEM_ALARM_INHIBITED                 = cast(ushort) 0x00d3,
    HID_USAGE_BATTERY_SYSTEM_THERMISTOR_UNDER_RANGE          = cast(ushort) 0x00d4,
    HID_USAGE_BATTERY_SYSTEM_THERMISTOR_HOT                  = cast(ushort) 0x00d5,
    HID_USAGE_BATTERY_SYSTEM_THERMISTOR_COLD                 = cast(ushort) 0x00d6,
    HID_USAGE_BATTERY_SYSTEM_THERMISTOR_OVER_RANGE           = cast(ushort) 0x00d7,
    HID_USAGE_BATTERY_SYSTEM_VOLTAGE_OUT_OF_RANGE            = cast(ushort) 0x00d8,
    HID_USAGE_BATTERY_SYSTEM_CURRENT_OUT_OF_RANGE            = cast(ushort) 0x00d9,
    HID_USAGE_BATTERY_SYSTEM_CURRENT_NOT_REGULATED           = cast(ushort) 0x00da,
    HID_USAGE_BATTERY_SYSTEM_VOLTAGE_NOT_REGULATED           = cast(ushort) 0x00db,
    HID_USAGE_BATTERY_SYSTEM_MASTER_MODE                     = cast(ushort) 0x00dc,
    HID_USAGE_BATTERY_SYSTEM_CHARGER_SELECTOR_SUPPORT        = cast(ushort) 0x00f0,
    HID_USAGE_BATTERY_SYSTEM_CHARGER_SPEC                    = cast(ushort) 0x00f1,
    HID_USAGE_BATTERY_SYSTEM_LEVEL_2                         = cast(ushort) 0x00f2,
    HID_USAGE_BATTERY_SYSTEM_LEVEL_3                         = cast(ushort) 0x00f3,
}

enum : ushort
{
    HID_USAGE_BRAILLE_DISPLAY_BRAILLE_DISPLAY              = cast(ushort) 0x0001,
    HID_USAGE_BRAILLE_DISPLAY_BRAILLE_ROW                  = cast(ushort) 0x0002,
    HID_USAGE_BRAILLE_DISPLAY_8_DOT_BRAILLE_CELL           = cast(ushort) 0x0003,
    HID_USAGE_BRAILLE_DISPLAY_6_DOT_BRAILLE_CELL           = cast(ushort) 0x0004,
    HID_USAGE_BRAILLE_DISPLAY_NUMBER_OF_BRAILLE_CELLS      = cast(ushort) 0x0005,
    HID_USAGE_BRAILLE_DISPLAY_SCREEN_READER_CONTROL        = cast(ushort) 0x0006,
    HID_USAGE_BRAILLE_DISPLAY_SCREEN_READER_IDENTIFIER     = cast(ushort) 0x0007,
    HID_USAGE_BRAILLE_DISPLAY_ROUTER_SET_1                 = cast(ushort) 0x00fa,
    HID_USAGE_BRAILLE_DISPLAY_ROUTER_SET_2                 = cast(ushort) 0x00fb,
    HID_USAGE_BRAILLE_DISPLAY_ROUTER_SET_3                 = cast(ushort) 0x00fc,
    HID_USAGE_BRAILLE_DISPLAY_ROUTER_KEY                   = cast(ushort) 0x0100,
    HID_USAGE_BRAILLE_DISPLAY_ROW_ROUTER_KEY               = cast(ushort) 0x0101,
    HID_USAGE_BRAILLE_DISPLAY_BRAILLE_BUTTONS              = cast(ushort) 0x0200,
    HID_USAGE_BRAILLE_DISPLAY_BRAILLE_KEYBOARD_DOT_1       = cast(ushort) 0x0201,
    HID_USAGE_BRAILLE_DISPLAY_BRAILLE_KEYBOARD_DOT_2       = cast(ushort) 0x0202,
    HID_USAGE_BRAILLE_DISPLAY_BRAILLE_KEYBOARD_DOT_3       = cast(ushort) 0x0203,
    HID_USAGE_BRAILLE_DISPLAY_BRAILLE_KEYBOARD_DOT_4       = cast(ushort) 0x0204,
    HID_USAGE_BRAILLE_DISPLAY_BRAILLE_KEYBOARD_DOT_5       = cast(ushort) 0x0205,
    HID_USAGE_BRAILLE_DISPLAY_BRAILLE_KEYBOARD_DOT_6       = cast(ushort) 0x0206,
    HID_USAGE_BRAILLE_DISPLAY_BRAILLE_KEYBOARD_DOT_7       = cast(ushort) 0x0207,
    HID_USAGE_BRAILLE_DISPLAY_BRAILLE_KEYBOARD_DOT_8       = cast(ushort) 0x0208,
    HID_USAGE_BRAILLE_DISPLAY_BRAILLE_KEYBOARD_SPACE       = cast(ushort) 0x0209,
    HID_USAGE_BRAILLE_DISPLAY_BRAILLE_KEYBOARD_LEFT_SPACE  = cast(ushort) 0x020a,
    HID_USAGE_BRAILLE_DISPLAY_BRAILLE_KEYBOARD_RIGHT_SPACE = cast(ushort) 0x020b,
    HID_USAGE_BRAILLE_DISPLAY_BRAILLE_FACE_CONTROLS        = cast(ushort) 0x020c,
    HID_USAGE_BRAILLE_DISPLAY_BRAILLE_LEFT_CONTROLS        = cast(ushort) 0x020d,
    HID_USAGE_BRAILLE_DISPLAY_BRAILLE_RIGHT_CONTROLS       = cast(ushort) 0x020e,
    HID_USAGE_BRAILLE_DISPLAY_BRAILLE_TOP_CONTROLS         = cast(ushort) 0x020f,
    HID_USAGE_BRAILLE_DISPLAY_BRAILLE_JOYSTICK_CENTER      = cast(ushort) 0x0210,
    HID_USAGE_BRAILLE_DISPLAY_BRAILLE_JOYSTICK_UP          = cast(ushort) 0x0211,
    HID_USAGE_BRAILLE_DISPLAY_BRAILLE_JOYSTICK_DOWN        = cast(ushort) 0x0212,
    HID_USAGE_BRAILLE_DISPLAY_BRAILLE_JOYSTICK_LEFT        = cast(ushort) 0x0213,
    HID_USAGE_BRAILLE_DISPLAY_BRAILLE_JOYSTICK_RIGHT       = cast(ushort) 0x0214,
    HID_USAGE_BRAILLE_DISPLAY_BRAILLE_DPAD_CENTER          = cast(ushort) 0x0215,
    HID_USAGE_BRAILLE_DISPLAY_BRAILLE_DPAD_UP              = cast(ushort) 0x0216,
    HID_USAGE_BRAILLE_DISPLAY_BRAILLE_DPAD_DOWN            = cast(ushort) 0x0217,
    HID_USAGE_BRAILLE_DISPLAY_BRAILLE_DPAD_LEFT            = cast(ushort) 0x0218,
    HID_USAGE_BRAILLE_DISPLAY_BRAILLE_DPAD_RIGHT           = cast(ushort) 0x0219,
    HID_USAGE_BRAILLE_DISPLAY_BRAILLE_PAN_LEFT             = cast(ushort) 0x021a,
    HID_USAGE_BRAILLE_DISPLAY_BRAILLE_PAN_RIGHT            = cast(ushort) 0x021b,
    HID_USAGE_BRAILLE_DISPLAY_BRAILLE_ROCKER_UP            = cast(ushort) 0x021c,
    HID_USAGE_BRAILLE_DISPLAY_BRAILLE_ROCKER_DOWN          = cast(ushort) 0x021d,
    HID_USAGE_BRAILLE_DISPLAY_BRAILLE_ROCKER_PRESS         = cast(ushort) 0x021e,
}

enum : ushort
{
    HID_USAGE_CAMERA_AUTO_FOCUS                              = cast(ushort) 0x0020,
    HID_USAGE_CAMERA_SHUTTER                                 = cast(ushort) 0x0021,
    HID_USAGE_CONSUMERCTRL                                   = cast(ushort) 0x0001,
    HID_USAGE_CONSUMER_NUMERIC_KEY_PAD                       = cast(ushort) 0x0002,
    HID_USAGE_CONSUMER_PROGRAMMABLE_BUTTONS                  = cast(ushort) 0x0003,
    HID_USAGE_CONSUMER_MICROPHONE                            = cast(ushort) 0x0004,
    HID_USAGE_CONSUMER_HEADPHONE                             = cast(ushort) 0x0005,
    HID_USAGE_CONSUMER_GRAPHIC_EQUALIZER                     = cast(ushort) 0x0006,
    HID_USAGE_CONSUMER_KEYBOARD_BACKLIGHT                    = cast(ushort) 0x0007,
    HID_USAGE_CONSUMER_10                                    = cast(ushort) 0x0020,
    HID_USAGE_CONSUMER_100                                   = cast(ushort) 0x0021,
    HID_USAGE_CONSUMER_AMPM                                  = cast(ushort) 0x0022,
    HID_USAGE_CONSUMER_POWER                                 = cast(ushort) 0x0030,
    HID_USAGE_CONSUMER_RESET                                 = cast(ushort) 0x0031,
    HID_USAGE_CONSUMER_SLEEP                                 = cast(ushort) 0x0032,
    HID_USAGE_CONSUMER_SLEEP_AFTER                           = cast(ushort) 0x0033,
    HID_USAGE_CONSUMER_SLEEP_MODE                            = cast(ushort) 0x0034,
    HID_USAGE_CONSUMER_ILLUMINATION                          = cast(ushort) 0x0035,
    HID_USAGE_CONSUMER_FUNCTION_BUTTONS                      = cast(ushort) 0x0036,
    HID_USAGE_CONSUMER_MENU                                  = cast(ushort) 0x0040,
    HID_USAGE_CONSUMER_MENU_PICK                             = cast(ushort) 0x0041,
    HID_USAGE_CONSUMER_MENU_UP                               = cast(ushort) 0x0042,
    HID_USAGE_CONSUMER_MENU_DOWN                             = cast(ushort) 0x0043,
    HID_USAGE_CONSUMER_MENU_LEFT                             = cast(ushort) 0x0044,
    HID_USAGE_CONSUMER_MENU_RIGHT                            = cast(ushort) 0x0045,
    HID_USAGE_CONSUMER_MENU_ESCAPE                           = cast(ushort) 0x0046,
    HID_USAGE_CONSUMER_MENU_VALUE_INCREASE                   = cast(ushort) 0x0047,
    HID_USAGE_CONSUMER_MENU_VALUE_DECREASE                   = cast(ushort) 0x0048,
    HID_USAGE_CONSUMER_DATA_ON_SCREEN                        = cast(ushort) 0x0060,
    HID_USAGE_CONSUMER_CLOSED_CAPTION                        = cast(ushort) 0x0061,
    HID_USAGE_CONSUMER_CLOSED_CAPTION_SELECT                 = cast(ushort) 0x0062,
    HID_USAGE_CONSUMER_VCRTV                                 = cast(ushort) 0x0063,
    HID_USAGE_CONSUMER_BROADCAST_MODE                        = cast(ushort) 0x0064,
    HID_USAGE_CONSUMER_SNAPSHOT                              = cast(ushort) 0x0065,
    HID_USAGE_CONSUMER_STILL                                 = cast(ushort) 0x0066,
    HID_USAGE_CONSUMER_PICTUREINPICTURE_TOGGLE               = cast(ushort) 0x0067,
    HID_USAGE_CONSUMER_PICTUREINPICTURE_SWAP                 = cast(ushort) 0x0068,
    HID_USAGE_CONSUMER_RED_MENU_BUTTON                       = cast(ushort) 0x0069,
    HID_USAGE_CONSUMER_GREEN_MENU_BUTTON                     = cast(ushort) 0x006a,
    HID_USAGE_CONSUMER_BLUE_MENU_BUTTON                      = cast(ushort) 0x006b,
    HID_USAGE_CONSUMER_YELLOW_MENU_BUTTON                    = cast(ushort) 0x006c,
    HID_USAGE_CONSUMER_ASPECT                                = cast(ushort) 0x006d,
    HID_USAGE_CONSUMER_3D_MODE_SELECT                        = cast(ushort) 0x006e,
    HID_USAGE_CONSUMER_DISPLAY_BRIGHTNESS_INCREMENT          = cast(ushort) 0x006f,
    HID_USAGE_CONSUMER_DISPLAY_BRIGHTNESS_DECREMENT          = cast(ushort) 0x0070,
    HID_USAGE_CONSUMER_DISPLAY_BRIGHTNESS                    = cast(ushort) 0x0071,
    HID_USAGE_CONSUMER_DISPLAY_BACKLIGHT_TOGGLE              = cast(ushort) 0x0072,
    HID_USAGE_CONSUMER_DISPLAY_SET_BRIGHTNESS_TO_MINIMUM     = cast(ushort) 0x0073,
    HID_USAGE_CONSUMER_DISPLAY_SET_BRIGHTNESS_TO_MAXIMUM     = cast(ushort) 0x0074,
    HID_USAGE_CONSUMER_DISPLAY_SET_AUTO_BRIGHTNESS           = cast(ushort) 0x0075,
    HID_USAGE_CONSUMER_CAMERA_ACCESS_ENABLED                 = cast(ushort) 0x0076,
    HID_USAGE_CONSUMER_CAMERA_ACCESS_DISABLED                = cast(ushort) 0x0077,
    HID_USAGE_CONSUMER_CAMERA_ACCESS_TOGGLE                  = cast(ushort) 0x0078,
    HID_USAGE_CONSUMER_KEYBOARD_BRIGHTNESS_INCREMENT         = cast(ushort) 0x0079,
    HID_USAGE_CONSUMER_KEYBOARD_BRIGHTNESS_DECREMENT         = cast(ushort) 0x007a,
    HID_USAGE_CONSUMER_KEYBOARD_BACKLIGHT_SET_LEVEL          = cast(ushort) 0x007b,
    HID_USAGE_CONSUMER_KEYBOARD_BACKLIGHT_OOC                = cast(ushort) 0x007c,
    HID_USAGE_CONSUMER_KEYBOARD_BACKLIGHT_SET_MINIMUM        = cast(ushort) 0x007d,
    HID_USAGE_CONSUMER_KEYBOARD_BACKLIGHT_SET_MAXIMUM        = cast(ushort) 0x007e,
    HID_USAGE_CONSUMER_KEYBOARD_BACKLIGHT_AUTO               = cast(ushort) 0x007f,
    HID_USAGE_CONSUMER_SELECTION                             = cast(ushort) 0x0080,
    HID_USAGE_CONSUMER_ASSIGN_SELECTION                      = cast(ushort) 0x0081,
    HID_USAGE_CONSUMER_MODE_STEP                             = cast(ushort) 0x0082,
    HID_USAGE_CONSUMER_RECALL_LAST                           = cast(ushort) 0x0083,
    HID_USAGE_CONSUMER_ENTER_CHANNEL                         = cast(ushort) 0x0084,
    HID_USAGE_CONSUMER_ORDER_MOVIE                           = cast(ushort) 0x0085,
    HID_USAGE_CONSUMER_CHANNEL                               = cast(ushort) 0x0086,
    HID_USAGE_CONSUMER_MEDIA_SELECTION                       = cast(ushort) 0x0087,
    HID_USAGE_CONSUMER_MEDIA_SELECT_COMPUTER                 = cast(ushort) 0x0088,
    HID_USAGE_CONSUMER_MEDIA_SELECT_TV                       = cast(ushort) 0x0089,
    HID_USAGE_CONSUMER_MEDIA_SELECT_WWW                      = cast(ushort) 0x008a,
    HID_USAGE_CONSUMER_MEDIA_SELECT_DVD                      = cast(ushort) 0x008b,
    HID_USAGE_CONSUMER_MEDIA_SELECT_TELEPHONE                = cast(ushort) 0x008c,
    HID_USAGE_CONSUMER_MEDIA_SELECT_PROGRAM_GUIDE            = cast(ushort) 0x008d,
    HID_USAGE_CONSUMER_MEDIA_SELECT_VIDEO_PHONE              = cast(ushort) 0x008e,
    HID_USAGE_CONSUMER_MEDIA_SELECT_GAMES                    = cast(ushort) 0x008f,
    HID_USAGE_CONSUMER_MEDIA_SELECT_MESSAGES                 = cast(ushort) 0x0090,
    HID_USAGE_CONSUMER_MEDIA_SELECT_CD                       = cast(ushort) 0x0091,
    HID_USAGE_CONSUMER_MEDIA_SELECT_VCR                      = cast(ushort) 0x0092,
    HID_USAGE_CONSUMER_MEDIA_SELECT_TUNER                    = cast(ushort) 0x0093,
    HID_USAGE_CONSUMER_QUIT                                  = cast(ushort) 0x0094,
    HID_USAGE_CONSUMER_HELP                                  = cast(ushort) 0x0095,
    HID_USAGE_CONSUMER_MEDIA_SELECT_TAPE                     = cast(ushort) 0x0096,
    HID_USAGE_CONSUMER_MEDIA_SELECT_CABLE                    = cast(ushort) 0x0097,
    HID_USAGE_CONSUMER_MEDIA_SELECT_SATELLITE                = cast(ushort) 0x0098,
    HID_USAGE_CONSUMER_MEDIA_SELECT_SECURITY                 = cast(ushort) 0x0099,
    HID_USAGE_CONSUMER_MEDIA_SELECT_HOME                     = cast(ushort) 0x009a,
    HID_USAGE_CONSUMER_MEDIA_SELECT_CALL                     = cast(ushort) 0x009b,
    HID_USAGE_CONSUMER_CHANNEL_INCREMENT                     = cast(ushort) 0x009c,
    HID_USAGE_CONSUMER_CHANNEL_DECREMENT                     = cast(ushort) 0x009d,
    HID_USAGE_CONSUMER_MEDIA_SELECT_SAP                      = cast(ushort) 0x009e,
    HID_USAGE_CONSUMER_VCR_PLUS                              = cast(ushort) 0x00a0,
    HID_USAGE_CONSUMER_ONCE                                  = cast(ushort) 0x00a1,
    HID_USAGE_CONSUMER_DAILY                                 = cast(ushort) 0x00a2,
    HID_USAGE_CONSUMER_WEEKLY                                = cast(ushort) 0x00a3,
    HID_USAGE_CONSUMER_MONTHLY                               = cast(ushort) 0x00a4,
    HID_USAGE_CONSUMER_PLAY                                  = cast(ushort) 0x00b0,
    HID_USAGE_CONSUMER_PAUSE                                 = cast(ushort) 0x00b1,
    HID_USAGE_CONSUMER_RECORD                                = cast(ushort) 0x00b2,
    HID_USAGE_CONSUMER_FAST_FORWARD                          = cast(ushort) 0x00b3,
    HID_USAGE_CONSUMER_REWIND                                = cast(ushort) 0x00b4,
    HID_USAGE_CONSUMER_SCAN_NEXT_TRACK                       = cast(ushort) 0x00b5,
    HID_USAGE_CONSUMER_SCAN_PREV_TRACK                       = cast(ushort) 0x00b6,
    HID_USAGE_CONSUMER_STOP                                  = cast(ushort) 0x00b7,
    HID_USAGE_CONSUMER_EJECT                                 = cast(ushort) 0x00b8,
    HID_USAGE_CONSUMER_RANDOM_PLAY                           = cast(ushort) 0x00b9,
    HID_USAGE_CONSUMER_SELECT_DISC                           = cast(ushort) 0x00ba,
    HID_USAGE_CONSUMER_ENTER_DISC                            = cast(ushort) 0x00bb,
    HID_USAGE_CONSUMER_REPEAT                                = cast(ushort) 0x00bc,
    HID_USAGE_CONSUMER_TRACKING                              = cast(ushort) 0x00bd,
    HID_USAGE_CONSUMER_TRACK_NORMAL                          = cast(ushort) 0x00be,
    HID_USAGE_CONSUMER_SLOW_TRACKING                         = cast(ushort) 0x00bf,
    HID_USAGE_CONSUMER_FRAME_FORWARD                         = cast(ushort) 0x00c0,
    HID_USAGE_CONSUMER_FRAME_BACK                            = cast(ushort) 0x00c1,
    HID_USAGE_CONSUMER_MARK                                  = cast(ushort) 0x00c2,
    HID_USAGE_CONSUMER_CLEAR_MARK                            = cast(ushort) 0x00c3,
    HID_USAGE_CONSUMER_REPEAT_FROM_MARK                      = cast(ushort) 0x00c4,
    HID_USAGE_CONSUMER_RETURN_TO_MARK                        = cast(ushort) 0x00c5,
    HID_USAGE_CONSUMER_SEARCH_MARK_FORWARD                   = cast(ushort) 0x00c6,
    HID_USAGE_CONSUMER_SEARCH_MARK_BACKWARDS                 = cast(ushort) 0x00c7,
    HID_USAGE_CONSUMER_COUNTER_RESET                         = cast(ushort) 0x00c8,
    HID_USAGE_CONSUMER_SHOW_COUNTER                          = cast(ushort) 0x00c9,
    HID_USAGE_CONSUMER_TRACKING_INCREMENT                    = cast(ushort) 0x00ca,
    HID_USAGE_CONSUMER_TRACKING_DECREMENT                    = cast(ushort) 0x00cb,
    HID_USAGE_CONSUMER_STOPEJECT                             = cast(ushort) 0x00cc,
    HID_USAGE_CONSUMER_PLAY_PAUSE                            = cast(ushort) 0x00cd,
    HID_USAGE_CONSUMER_PLAYSKIP                              = cast(ushort) 0x00ce,
    HID_USAGE_CONSUMER_VOICE_COMMAND                         = cast(ushort) 0x00cf,
    HID_USAGE_CONSUMER_GAMEDVR_OPEN_GAMEBAR                  = cast(ushort) 0x00d0,
    HID_USAGE_CONSUMER_GAMEDVR_TOGGLE_RECORD                 = cast(ushort) 0x00d1,
    HID_USAGE_CONSUMER_GAMEDVR_RECORD_CLIP                   = cast(ushort) 0x00d2,
    HID_USAGE_CONSUMER_GAMEDVR_SCREENSHOT                    = cast(ushort) 0x00d3,
    HID_USAGE_CONSUMER_GAMEDVR_TOGGLE_INDICATOR              = cast(ushort) 0x00d4,
    HID_USAGE_CONSUMER_GAMEDVR_TOGGLE_MICROPHONE             = cast(ushort) 0x00d5,
    HID_USAGE_CONSUMER_GAMEDVR_TOGGLE_CAMERA                 = cast(ushort) 0x00d6,
    HID_USAGE_CONSUMER_GAMEDVR_TOGGLE_BROADCAST              = cast(ushort) 0x00d7,
    HID_USAGE_CONSUMER_START_OR_STOP_VOICE_DICTATION_SESSION = cast(ushort) 0x00d8,
}

enum : ushort
{
    HID_USAGE_CONSUMER_INVOKEDISMISS_EMOJI_PICKER           = cast(ushort) 0x00d9,
    HID_USAGE_CONSUMER_VOLUME                               = cast(ushort) 0x00e0,
    HID_USAGE_CONSUMER_BALANCE                              = cast(ushort) 0x00e1,
    HID_USAGE_CONSUMER_MUTE                                 = cast(ushort) 0x00e2,
    HID_USAGE_CONSUMER_BASS                                 = cast(ushort) 0x00e3,
    HID_USAGE_CONSUMER_TREBLE                               = cast(ushort) 0x00e4,
    HID_USAGE_CONSUMER_BASS_BOOST                           = cast(ushort) 0x00e5,
    HID_USAGE_CONSUMER_SURROUND_MODE                        = cast(ushort) 0x00e6,
    HID_USAGE_CONSUMER_LOUDNESS                             = cast(ushort) 0x00e7,
    HID_USAGE_CONSUMER_MPX                                  = cast(ushort) 0x00e8,
    HID_USAGE_CONSUMER_VOLUME_INCREMENT                     = cast(ushort) 0x00e9,
    HID_USAGE_CONSUMER_VOLUME_DECREMENT                     = cast(ushort) 0x00ea,
    HID_USAGE_CONSUMER_SPEED_SELECT                         = cast(ushort) 0x00f0,
    HID_USAGE_CONSUMER_PLAYBACK_SPEED                       = cast(ushort) 0x00f1,
    HID_USAGE_CONSUMER_STANDARD_PLAY                        = cast(ushort) 0x00f2,
    HID_USAGE_CONSUMER_LONG_PLAY                            = cast(ushort) 0x00f3,
    HID_USAGE_CONSUMER_EXTENDED_PLAY                        = cast(ushort) 0x00f4,
    HID_USAGE_CONSUMER_SLOW                                 = cast(ushort) 0x00f5,
    HID_USAGE_CONSUMER_FAN_ENABLE                           = cast(ushort) 0x0100,
    HID_USAGE_CONSUMER_FAN_SPEED                            = cast(ushort) 0x0101,
    HID_USAGE_CONSUMER_LIGHT_ENABLE                         = cast(ushort) 0x0102,
    HID_USAGE_CONSUMER_LIGHT_ILLUMINATION_LEVEL             = cast(ushort) 0x0103,
    HID_USAGE_CONSUMER_CLIMATE_CONTROL_ENABLE               = cast(ushort) 0x0104,
    HID_USAGE_CONSUMER_ROOM_TEMPERATURE                     = cast(ushort) 0x0105,
    HID_USAGE_CONSUMER_SECURITY_ENABLE                      = cast(ushort) 0x0106,
    HID_USAGE_CONSUMER_FIRE_ALARM                           = cast(ushort) 0x0107,
    HID_USAGE_CONSUMER_POLICE_ALARM                         = cast(ushort) 0x0108,
    HID_USAGE_CONSUMER_PROXIMITY                            = cast(ushort) 0x0109,
    HID_USAGE_CONSUMER_MOTION                               = cast(ushort) 0x010a,
    HID_USAGE_CONSUMER_DURESS_ALARM                         = cast(ushort) 0x010b,
    HID_USAGE_CONSUMER_HOLDUP_ALARM                         = cast(ushort) 0x010c,
    HID_USAGE_CONSUMER_MEDICAL_ALARM                        = cast(ushort) 0x010d,
    HID_USAGE_CONSUMER_BALANCE_RIGHT                        = cast(ushort) 0x0150,
    HID_USAGE_CONSUMER_BALANCE_LEFT                         = cast(ushort) 0x0151,
    HID_USAGE_CONSUMER_BASS_INCREMENT                       = cast(ushort) 0x0152,
    HID_USAGE_CONSUMER_BASS_DECREMENT                       = cast(ushort) 0x0153,
    HID_USAGE_CONSUMER_TREBLE_INCREMENT                     = cast(ushort) 0x0154,
    HID_USAGE_CONSUMER_TREBLE_DECREMENT                     = cast(ushort) 0x0155,
    HID_USAGE_CONSUMER_SPEAKER_SYSTEM                       = cast(ushort) 0x0160,
    HID_USAGE_CONSUMER_CHANNEL_LEFT                         = cast(ushort) 0x0161,
    HID_USAGE_CONSUMER_CHANNEL_RIGHT                        = cast(ushort) 0x0162,
    HID_USAGE_CONSUMER_CHANNEL_CENTER                       = cast(ushort) 0x0163,
    HID_USAGE_CONSUMER_CHANNEL_FRONT                        = cast(ushort) 0x0164,
    HID_USAGE_CONSUMER_CHANNEL_CENTER_FRONT                 = cast(ushort) 0x0165,
    HID_USAGE_CONSUMER_CHANNEL_SIDE                         = cast(ushort) 0x0166,
    HID_USAGE_CONSUMER_CHANNEL_SURROUND                     = cast(ushort) 0x0167,
    HID_USAGE_CONSUMER_CHANNEL_LOW_FREQUENCY_ENHANCEMENT    = cast(ushort) 0x0168,
    HID_USAGE_CONSUMER_CHANNEL_TOP                          = cast(ushort) 0x0169,
    HID_USAGE_CONSUMER_CHANNEL_UNKNOWN                      = cast(ushort) 0x016a,
    HID_USAGE_CONSUMER_SUBCHANNEL                           = cast(ushort) 0x0170,
    HID_USAGE_CONSUMER_SUBCHANNEL_INCREMENT                 = cast(ushort) 0x0171,
    HID_USAGE_CONSUMER_SUBCHANNEL_DECREMENT                 = cast(ushort) 0x0172,
    HID_USAGE_CONSUMER_ALTERNATE_AUDIO_INCREMENT            = cast(ushort) 0x0173,
    HID_USAGE_CONSUMER_ALTERNATE_AUDIO_DECREMENT            = cast(ushort) 0x0174,
    HID_USAGE_CONSUMER_APPLICATION_LAUNCH_BUTTONS           = cast(ushort) 0x0180,
    HID_USAGE_CONSUMER_AL_LAUNCH_BUTTON_CONFIGURATION_TOOL  = cast(ushort) 0x0181,
    HID_USAGE_CONSUMER_AL_PROGRAMMABLE_BUTTON_CONFIGURATION = cast(ushort) 0x0182,
}

enum : ushort
{
    HID_USAGE_CONSUMER_AL_CONFIGURATION                     = cast(ushort) 0x0183,
    HID_USAGE_CONSUMER_AL_WORD_PROCESSOR                    = cast(ushort) 0x0184,
    HID_USAGE_CONSUMER_AL_TEXT_EDITOR                       = cast(ushort) 0x0185,
    HID_USAGE_CONSUMER_AL_SPREADSHEET                       = cast(ushort) 0x0186,
    HID_USAGE_CONSUMER_AL_GRAPHICS_EDITOR                   = cast(ushort) 0x0187,
    HID_USAGE_CONSUMER_AL_PRESENTATION_APP                  = cast(ushort) 0x0188,
    HID_USAGE_CONSUMER_AL_DATABASE_APP                      = cast(ushort) 0x0189,
    HID_USAGE_CONSUMER_AL_EMAIL                             = cast(ushort) 0x018a,
    HID_USAGE_CONSUMER_AL_NEWSREADER                        = cast(ushort) 0x018b,
    HID_USAGE_CONSUMER_AL_VOICEMAIL                         = cast(ushort) 0x018c,
    HID_USAGE_CONSUMER_AL_CONTACTSADDRESS_BOOK              = cast(ushort) 0x018d,
    HID_USAGE_CONSUMER_AL_CALENDARSCHEDULE                  = cast(ushort) 0x018e,
    HID_USAGE_CONSUMER_AL_TASKPROJECT_MANAGER               = cast(ushort) 0x018f,
    HID_USAGE_CONSUMER_AL_LOGJOURNALTIMECARD                = cast(ushort) 0x0190,
    HID_USAGE_CONSUMER_AL_CHECKBOOKFINANCE                  = cast(ushort) 0x0191,
    HID_USAGE_CONSUMER_AL_CALCULATOR                        = cast(ushort) 0x0192,
    HID_USAGE_CONSUMER_AL_AV_CAPTUREPLAYBACK                = cast(ushort) 0x0193,
    HID_USAGE_CONSUMER_AL_BROWSER                           = cast(ushort) 0x0194,
    HID_USAGE_CONSUMER_AL_LANWAN_BROWSER                    = cast(ushort) 0x0195,
    HID_USAGE_CONSUMER_AL_INTERNET_BROWSER                  = cast(ushort) 0x0196,
    HID_USAGE_CONSUMER_AL_REMOTE_NETWORKINGISP_CONNECT      = cast(ushort) 0x0197,
    HID_USAGE_CONSUMER_AL_NETWORK_CONFERENCE                = cast(ushort) 0x0198,
    HID_USAGE_CONSUMER_AL_NETWORK_CHAT                      = cast(ushort) 0x0199,
    HID_USAGE_CONSUMER_AL_TELEPHONYDIALER                   = cast(ushort) 0x019a,
    HID_USAGE_CONSUMER_AL_LOGON                             = cast(ushort) 0x019b,
    HID_USAGE_CONSUMER_AL_LOGOFF                            = cast(ushort) 0x019c,
    HID_USAGE_CONSUMER_AL_LOGONLOGOFF                       = cast(ushort) 0x019d,
    HID_USAGE_CONSUMER_AL_TERMINAL_LOCKSCREENSAVER          = cast(ushort) 0x019e,
    HID_USAGE_CONSUMER_AL_CONTROL_PANEL                     = cast(ushort) 0x019f,
    HID_USAGE_CONSUMER_AL_COMMAND_LINE_PROCESSORRUN         = cast(ushort) 0x01a0,
    HID_USAGE_CONSUMER_AL_PROCESSTASK_MANAGER               = cast(ushort) 0x01a1,
    HID_USAGE_CONSUMER_AL_SELECT_TASKAPPLICATION            = cast(ushort) 0x01a2,
    HID_USAGE_CONSUMER_AL_NEXT_TASKAPPLICATION              = cast(ushort) 0x01a3,
    HID_USAGE_CONSUMER_AL_PREVIOUS_TASKAPPLICATION          = cast(ushort) 0x01a4,
    HID_USAGE_CONSUMER_AL_PREEMPTIVE_HALT_TASKAPPLICATION   = cast(ushort) 0x01a5,
    HID_USAGE_CONSUMER_AL_INTEGRATED_HELP_CENTER            = cast(ushort) 0x01a6,
    HID_USAGE_CONSUMER_AL_DOCUMENTS                         = cast(ushort) 0x01a7,
    HID_USAGE_CONSUMER_AL_THESAURUS                         = cast(ushort) 0x01a8,
    HID_USAGE_CONSUMER_AL_DICTIONARY                        = cast(ushort) 0x01a9,
    HID_USAGE_CONSUMER_AL_DESKTOP                           = cast(ushort) 0x01aa,
    HID_USAGE_CONSUMER_AL_SPELL_CHECK                       = cast(ushort) 0x01ab,
    HID_USAGE_CONSUMER_AL_GRAMMAR_CHECK                     = cast(ushort) 0x01ac,
    HID_USAGE_CONSUMER_AL_WIRELESS_STATUS                   = cast(ushort) 0x01ad,
    HID_USAGE_CONSUMER_AL_KEYBOARD_LAYOUT                   = cast(ushort) 0x01ae,
    HID_USAGE_CONSUMER_AL_VIRUS_PROTECTION                  = cast(ushort) 0x01af,
    HID_USAGE_CONSUMER_AL_ENCRYPTION                        = cast(ushort) 0x01b0,
    HID_USAGE_CONSUMER_AL_SCREEN_SAVER                      = cast(ushort) 0x01b1,
    HID_USAGE_CONSUMER_AL_ALARMS                            = cast(ushort) 0x01b2,
    HID_USAGE_CONSUMER_AL_CLOCK                             = cast(ushort) 0x01b3,
    HID_USAGE_CONSUMER_AL_FILE_BROWSER                      = cast(ushort) 0x01b4,
    HID_USAGE_CONSUMER_AL_POWER_STATUS                      = cast(ushort) 0x01b5,
    HID_USAGE_CONSUMER_AL_IMAGE_BROWSER                     = cast(ushort) 0x01b6,
    HID_USAGE_CONSUMER_AL_AUDIO_BROWSER                     = cast(ushort) 0x01b7,
    HID_USAGE_CONSUMER_AL_MOVIE_BROWSER                     = cast(ushort) 0x01b8,
    HID_USAGE_CONSUMER_AL_DIGITAL_RIGHTS_MANAGER            = cast(ushort) 0x01b9,
    HID_USAGE_CONSUMER_AL_DIGITAL_WALLET                    = cast(ushort) 0x01ba,
    HID_USAGE_CONSUMER_AL_INSTANT_MESSAGING                 = cast(ushort) 0x01bc,
    HID_USAGE_CONSUMER_AL_OEM_FEATURES_TIPSTUTORIAL_BROWSER = cast(ushort) 0x01bd,
    HID_USAGE_CONSUMER_AL_OEM_HELP                          = cast(ushort) 0x01be,
    HID_USAGE_CONSUMER_AL_ONLINE_COMMUNITY                  = cast(ushort) 0x01bf,
    HID_USAGE_CONSUMER_AL_ENTERTAINMENT_CONTENT_BROWSER     = cast(ushort) 0x01c0,
    HID_USAGE_CONSUMER_AL_ONLINE_SHOPPING_BROWSER           = cast(ushort) 0x01c1,
    HID_USAGE_CONSUMER_AL_SMARTCARD_INFORMATIONHELP         = cast(ushort) 0x01c2,
    HID_USAGE_CONSUMER_AL_MARKET_MONITORFINANCE_BROWSER     = cast(ushort) 0x01c3,
    HID_USAGE_CONSUMER_AL_CUSTOMIZED_CORPORATE_NEWS_BROWSER = cast(ushort) 0x01c4,
}

enum : ushort
{
    HID_USAGE_CONSUMER_AL_ONLINE_ACTIVITY_BROWSER        = cast(ushort) 0x01c5,
    HID_USAGE_CONSUMER_AL_SEARCH                         = cast(ushort) 0x01c6,
    HID_USAGE_CONSUMER_AL_AUDIO_PLAYER                   = cast(ushort) 0x01c7,
    HID_USAGE_CONSUMER_AL_MESSAGE_STATUS                 = cast(ushort) 0x01c8,
    HID_USAGE_CONSUMER_AL_CONTACT_SYNC                   = cast(ushort) 0x01c9,
    HID_USAGE_CONSUMER_AL_NAVIGATION                     = cast(ushort) 0x01ca,
    HID_USAGE_CONSUMER_AL_CONTEXTAWARE_DESKTOP_ASSISTANT = cast(ushort) 0x01cb,
}

enum ushort HID_USAGE_CONSUMER_GENERIC_GUI_APPLICATION_CONTROLS = cast(ushort) 0x0200;

enum : ushort
{
    HID_USAGE_CONSUMER_AC_NEW                                  = cast(ushort) 0x0201,
    HID_USAGE_CONSUMER_AC_OPEN                                 = cast(ushort) 0x0202,
    HID_USAGE_CONSUMER_AC_CLOSE                                = cast(ushort) 0x0203,
    HID_USAGE_CONSUMER_AC_EXIT                                 = cast(ushort) 0x0204,
    HID_USAGE_CONSUMER_AC_MAXIMIZE                             = cast(ushort) 0x0205,
    HID_USAGE_CONSUMER_AC_MINIMIZE                             = cast(ushort) 0x0206,
    HID_USAGE_CONSUMER_AC_SAVE                                 = cast(ushort) 0x0207,
    HID_USAGE_CONSUMER_AC_PRINT                                = cast(ushort) 0x0208,
    HID_USAGE_CONSUMER_AC_PROPERTIES                           = cast(ushort) 0x0209,
    HID_USAGE_CONSUMER_AC_UNDO                                 = cast(ushort) 0x021a,
    HID_USAGE_CONSUMER_AC_COPY                                 = cast(ushort) 0x021b,
    HID_USAGE_CONSUMER_AC_CUT                                  = cast(ushort) 0x021c,
    HID_USAGE_CONSUMER_AC_PASTE                                = cast(ushort) 0x021d,
    HID_USAGE_CONSUMER_AC_SELECT_ALL                           = cast(ushort) 0x021e,
    HID_USAGE_CONSUMER_AC_FIND                                 = cast(ushort) 0x021f,
    HID_USAGE_CONSUMER_AC_FIND_AND_REPLACE                     = cast(ushort) 0x0220,
    HID_USAGE_CONSUMER_AC_SEARCH                               = cast(ushort) 0x0221,
    HID_USAGE_CONSUMER_AC_GOTO                                 = cast(ushort) 0x0222,
    HID_USAGE_CONSUMER_AC_HOME                                 = cast(ushort) 0x0223,
    HID_USAGE_CONSUMER_AC_BACK                                 = cast(ushort) 0x0224,
    HID_USAGE_CONSUMER_AC_FORWARD                              = cast(ushort) 0x0225,
    HID_USAGE_CONSUMER_AC_STOP                                 = cast(ushort) 0x0226,
    HID_USAGE_CONSUMER_AC_REFRESH                              = cast(ushort) 0x0227,
    HID_USAGE_CONSUMER_AC_PREVIOUS                             = cast(ushort) 0x0228,
    HID_USAGE_CONSUMER_AC_NEXT                                 = cast(ushort) 0x0229,
    HID_USAGE_CONSUMER_AC_BOOKMARKS                            = cast(ushort) 0x022a,
    HID_USAGE_CONSUMER_AC_HISTORY                              = cast(ushort) 0x022b,
    HID_USAGE_CONSUMER_AC_SUBSCRIPTIONS                        = cast(ushort) 0x022c,
    HID_USAGE_CONSUMER_AC_ZOOM_IN                              = cast(ushort) 0x022d,
    HID_USAGE_CONSUMER_AC_ZOOM_OUT                             = cast(ushort) 0x022e,
    HID_USAGE_CONSUMER_AC_ZOOM                                 = cast(ushort) 0x022f,
    HID_USAGE_CONSUMER_AC_FULL_SCREEN_VIEW                     = cast(ushort) 0x0230,
    HID_USAGE_CONSUMER_AC_NORMAL_VIEW                          = cast(ushort) 0x0231,
    HID_USAGE_CONSUMER_AC_VIEW_TOGGLE                          = cast(ushort) 0x0232,
    HID_USAGE_CONSUMER_AC_SCROLL_UP                            = cast(ushort) 0x0233,
    HID_USAGE_CONSUMER_AC_SCROLL_DOWN                          = cast(ushort) 0x0234,
    HID_USAGE_CONSUMER_AC_SCROLL                               = cast(ushort) 0x0235,
    HID_USAGE_CONSUMER_AC_PAN_LEFT                             = cast(ushort) 0x0236,
    HID_USAGE_CONSUMER_AC_PAN_RIGHT                            = cast(ushort) 0x0237,
    HID_USAGE_CONSUMER_AC_PAN                                  = cast(ushort) 0x0238,
    HID_USAGE_CONSUMER_AC_NEW_WINDOW                           = cast(ushort) 0x0239,
    HID_USAGE_CONSUMER_AC_TILE_HORIZONTALLY                    = cast(ushort) 0x023a,
    HID_USAGE_CONSUMER_AC_TILE_VERTICALLY                      = cast(ushort) 0x023b,
    HID_USAGE_CONSUMER_AC_FORMAT                               = cast(ushort) 0x023c,
    HID_USAGE_CONSUMER_AC_EDIT                                 = cast(ushort) 0x023d,
    HID_USAGE_CONSUMER_AC_BOLD                                 = cast(ushort) 0x023e,
    HID_USAGE_CONSUMER_AC_ITALICS                              = cast(ushort) 0x023f,
    HID_USAGE_CONSUMER_AC_UNDERLINE                            = cast(ushort) 0x0240,
    HID_USAGE_CONSUMER_AC_STRIKETHROUGH                        = cast(ushort) 0x0241,
    HID_USAGE_CONSUMER_AC_SUBSCRIPT                            = cast(ushort) 0x0242,
    HID_USAGE_CONSUMER_AC_SUPERSCRIPT                          = cast(ushort) 0x0243,
    HID_USAGE_CONSUMER_AC_ALL_CAPS                             = cast(ushort) 0x0244,
    HID_USAGE_CONSUMER_AC_ROTATE                               = cast(ushort) 0x0245,
    HID_USAGE_CONSUMER_AC_RESIZE                               = cast(ushort) 0x0246,
    HID_USAGE_CONSUMER_AC_FLIP_HORIZONTAL                      = cast(ushort) 0x0247,
    HID_USAGE_CONSUMER_AC_FLIP_VERTICAL                        = cast(ushort) 0x0248,
    HID_USAGE_CONSUMER_AC_MIRROR_HORIZONTAL                    = cast(ushort) 0x0249,
    HID_USAGE_CONSUMER_AC_MIRROR_VERTICAL                      = cast(ushort) 0x024a,
    HID_USAGE_CONSUMER_AC_FONT_SELECT                          = cast(ushort) 0x024b,
    HID_USAGE_CONSUMER_AC_FONT_COLOR                           = cast(ushort) 0x024c,
    HID_USAGE_CONSUMER_AC_FONT_SIZE                            = cast(ushort) 0x024d,
    HID_USAGE_CONSUMER_AC_JUSTIFY_LEFT                         = cast(ushort) 0x024e,
    HID_USAGE_CONSUMER_AC_JUSTIFY_CENTER_H                     = cast(ushort) 0x024f,
    HID_USAGE_CONSUMER_AC_JUSTIFY_RIGHT                        = cast(ushort) 0x0250,
    HID_USAGE_CONSUMER_AC_JUSTIFY_BLOCK_H                      = cast(ushort) 0x0251,
    HID_USAGE_CONSUMER_AC_JUSTIFY_TOP                          = cast(ushort) 0x0252,
    HID_USAGE_CONSUMER_AC_JUSTIFY_CENTER_V                     = cast(ushort) 0x0253,
    HID_USAGE_CONSUMER_AC_JUSTIFY_BOTTOM                       = cast(ushort) 0x0254,
    HID_USAGE_CONSUMER_AC_JUSTIFY_BLOCK_V                      = cast(ushort) 0x0255,
    HID_USAGE_CONSUMER_AC_INDENT_DECREASE                      = cast(ushort) 0x0256,
    HID_USAGE_CONSUMER_AC_INDENT_INCREASE                      = cast(ushort) 0x0257,
    HID_USAGE_CONSUMER_AC_NUMBERED_LIST                        = cast(ushort) 0x0258,
    HID_USAGE_CONSUMER_AC_RESTART_NUMBERING                    = cast(ushort) 0x0259,
    HID_USAGE_CONSUMER_AC_BULLETED_LIST                        = cast(ushort) 0x025a,
    HID_USAGE_CONSUMER_AC_PROMOTE                              = cast(ushort) 0x025b,
    HID_USAGE_CONSUMER_AC_DEMOTE                               = cast(ushort) 0x025c,
    HID_USAGE_CONSUMER_AC_YES                                  = cast(ushort) 0x025d,
    HID_USAGE_CONSUMER_AC_NO                                   = cast(ushort) 0x025e,
    HID_USAGE_CONSUMER_AC_CANCEL                               = cast(ushort) 0x025f,
    HID_USAGE_CONSUMER_AC_CATALOG                              = cast(ushort) 0x0260,
    HID_USAGE_CONSUMER_AC_BUYCHECKOUT                          = cast(ushort) 0x0261,
    HID_USAGE_CONSUMER_AC_ADD_TO_CART                          = cast(ushort) 0x0262,
    HID_USAGE_CONSUMER_AC_EXPAND                               = cast(ushort) 0x0263,
    HID_USAGE_CONSUMER_AC_EXPAND_ALL                           = cast(ushort) 0x0264,
    HID_USAGE_CONSUMER_AC_COLLAPSE                             = cast(ushort) 0x0265,
    HID_USAGE_CONSUMER_AC_COLLAPSE_ALL                         = cast(ushort) 0x0266,
    HID_USAGE_CONSUMER_AC_PRINT_PREVIEW                        = cast(ushort) 0x0267,
    HID_USAGE_CONSUMER_AC_PASTE_SPECIAL                        = cast(ushort) 0x0268,
    HID_USAGE_CONSUMER_AC_INSERT_MODE                          = cast(ushort) 0x0269,
    HID_USAGE_CONSUMER_AC_DELETE                               = cast(ushort) 0x026a,
    HID_USAGE_CONSUMER_AC_LOCK                                 = cast(ushort) 0x026b,
    HID_USAGE_CONSUMER_AC_UNLOCK                               = cast(ushort) 0x026c,
    HID_USAGE_CONSUMER_AC_PROTECT                              = cast(ushort) 0x026d,
    HID_USAGE_CONSUMER_AC_UNPROTECT                            = cast(ushort) 0x026e,
    HID_USAGE_CONSUMER_AC_ATTACH_COMMENT                       = cast(ushort) 0x026f,
    HID_USAGE_CONSUMER_AC_DELETE_COMMENT                       = cast(ushort) 0x0270,
    HID_USAGE_CONSUMER_AC_VIEW_COMMENT                         = cast(ushort) 0x0271,
    HID_USAGE_CONSUMER_AC_SELECT_WORD                          = cast(ushort) 0x0272,
    HID_USAGE_CONSUMER_AC_SELECT_SENTENCE                      = cast(ushort) 0x0273,
    HID_USAGE_CONSUMER_AC_SELECT_PARAGRAPH                     = cast(ushort) 0x0274,
    HID_USAGE_CONSUMER_AC_SELECT_COLUMN                        = cast(ushort) 0x0275,
    HID_USAGE_CONSUMER_AC_SELECT_ROW                           = cast(ushort) 0x0276,
    HID_USAGE_CONSUMER_AC_SELECT_TABLE                         = cast(ushort) 0x0277,
    HID_USAGE_CONSUMER_AC_SELECT_OBJECT                        = cast(ushort) 0x0278,
    HID_USAGE_CONSUMER_AC_REDOREPEAT                           = cast(ushort) 0x0279,
    HID_USAGE_CONSUMER_AC_SORT                                 = cast(ushort) 0x027a,
    HID_USAGE_CONSUMER_AC_SORT_ASCENDING                       = cast(ushort) 0x027b,
    HID_USAGE_CONSUMER_AC_SORT_DESCENDING                      = cast(ushort) 0x027c,
    HID_USAGE_CONSUMER_AC_FILTER                               = cast(ushort) 0x027d,
    HID_USAGE_CONSUMER_AC_SET_CLOCK                            = cast(ushort) 0x027e,
    HID_USAGE_CONSUMER_AC_VIEW_CLOCK                           = cast(ushort) 0x027f,
    HID_USAGE_CONSUMER_AC_SELECT_TIME_ZONE                     = cast(ushort) 0x0280,
    HID_USAGE_CONSUMER_AC_EDIT_TIME_ZONES                      = cast(ushort) 0x0281,
    HID_USAGE_CONSUMER_AC_SET_ALARM                            = cast(ushort) 0x0282,
    HID_USAGE_CONSUMER_AC_CLEAR_ALARM                          = cast(ushort) 0x0283,
    HID_USAGE_CONSUMER_AC_SNOOZE_ALARM                         = cast(ushort) 0x0284,
    HID_USAGE_CONSUMER_AC_RESET_ALARM                          = cast(ushort) 0x0285,
    HID_USAGE_CONSUMER_AC_SYNCHRONIZE                          = cast(ushort) 0x0286,
    HID_USAGE_CONSUMER_AC_SENDRECEIVE                          = cast(ushort) 0x0287,
    HID_USAGE_CONSUMER_AC_SEND_TO                              = cast(ushort) 0x0288,
    HID_USAGE_CONSUMER_AC_REPLY                                = cast(ushort) 0x0289,
    HID_USAGE_CONSUMER_AC_REPLY_ALL                            = cast(ushort) 0x028a,
    HID_USAGE_CONSUMER_AC_FORWARD_MSG                          = cast(ushort) 0x028b,
    HID_USAGE_CONSUMER_AC_SEND                                 = cast(ushort) 0x028c,
    HID_USAGE_CONSUMER_AC_ATTACH_FILE                          = cast(ushort) 0x028d,
    HID_USAGE_CONSUMER_AC_UPLOAD                               = cast(ushort) 0x028e,
    HID_USAGE_CONSUMER_AC_DOWNLOAD_SAVE_TARGET_AS              = cast(ushort) 0x028f,
    HID_USAGE_CONSUMER_AC_SET_BORDERS                          = cast(ushort) 0x0290,
    HID_USAGE_CONSUMER_AC_INSERT_ROW                           = cast(ushort) 0x0291,
    HID_USAGE_CONSUMER_AC_INSERT_COLUMN                        = cast(ushort) 0x0292,
    HID_USAGE_CONSUMER_AC_INSERT_FILE                          = cast(ushort) 0x0293,
    HID_USAGE_CONSUMER_AC_INSERT_PICTURE                       = cast(ushort) 0x0294,
    HID_USAGE_CONSUMER_AC_INSERT_OBJECT                        = cast(ushort) 0x0295,
    HID_USAGE_CONSUMER_AC_INSERT_SYMBOL                        = cast(ushort) 0x0296,
    HID_USAGE_CONSUMER_AC_SAVE_AND_CLOSE                       = cast(ushort) 0x0297,
    HID_USAGE_CONSUMER_AC_RENAME                               = cast(ushort) 0x0298,
    HID_USAGE_CONSUMER_AC_MERGE                                = cast(ushort) 0x0299,
    HID_USAGE_CONSUMER_AC_SPLIT                                = cast(ushort) 0x029a,
    HID_USAGE_CONSUMER_AC_DISRIBUTE_HORIZONTALLY               = cast(ushort) 0x029b,
    HID_USAGE_CONSUMER_AC_DISTRIBUTE_VERTICALLY                = cast(ushort) 0x029c,
    HID_USAGE_CONSUMER_AC_NEXT_KEYBOARD_LAYOUT_SELECT          = cast(ushort) 0x029d,
    HID_USAGE_CONSUMER_AC_NAVIGATION_GUIDANCE                  = cast(ushort) 0x029e,
    HID_USAGE_CONSUMER_AC_DESKTOP_SHOW_ALL_WINDOWS             = cast(ushort) 0x029f,
    HID_USAGE_CONSUMER_AC_SOFT_KEY_LEFT                        = cast(ushort) 0x02a0,
    HID_USAGE_CONSUMER_AC_SOFT_KEY_RIGHT                       = cast(ushort) 0x02a1,
    HID_USAGE_CONSUMER_AC_DESKTOP_SHOW_ALL_APPLICATIONS        = cast(ushort) 0x02a2,
    HID_USAGE_CONSUMER_AC_IDLE_KEEP_ALIVE                      = cast(ushort) 0x02b0,
    HID_USAGE_CONSUMER_EXTENDED_KEYBOARD_ATTRIBUTES_COLLECTION = cast(ushort) 0x02c0,
}

enum : ushort
{
    HID_USAGE_CONSUMER_KEYBOARD_FORM_FACTOR                     = cast(ushort) 0x02c1,
    HID_USAGE_CONSUMER_KEYBOARD_KEY_TYPE                        = cast(ushort) 0x02c2,
    HID_USAGE_CONSUMER_KEYBOARD_PHYSICAL_LAYOUT                 = cast(ushort) 0x02c3,
    HID_USAGE_CONSUMER_VENDOR_SPECIFIC_KEYBOARD_PHYSICAL_LAYOUT = cast(ushort) 0x02c4,
}

enum ushort HID_USAGE_CONSUMER_KEYBOARD_IETF_LANGUAGE_TAG_INDEX = cast(ushort) 0x02c5;
enum ushort HID_USAGE_CONSUMER_IMPLEMENTED_KEYBOARD_INPUT_ASSIST_CONTROLS = cast(ushort) 0x02c6;

enum : ushort
{
    HID_USAGE_CONSUMER_KEYBOARD_INPUT_ASSIST_PREVIOUS       = cast(ushort) 0x02c7,
    HID_USAGE_CONSUMER_KEYBOARD_INPUT_ASSIST_NEXT           = cast(ushort) 0x02c8,
    HID_USAGE_CONSUMER_KEYBOARD_INPUT_ASSIST_PREVIOUS_GROUP = cast(ushort) 0x02c9,
    HID_USAGE_CONSUMER_KEYBOARD_INPUT_ASSIST_NEXT_GROUP     = cast(ushort) 0x02ca,
    HID_USAGE_CONSUMER_KEYBOARD_INPUT_ASSIST_ACCEPT         = cast(ushort) 0x02cb,
    HID_USAGE_CONSUMER_KEYBOARD_INPUT_ASSIST_CANCEL         = cast(ushort) 0x02cc,
    HID_USAGE_CONSUMER_PRIVACY_SCREEN_TOGGLE                = cast(ushort) 0x02d0,
    HID_USAGE_CONSUMER_PRIVACY_SCREEN_LEVEL_DECREMENT       = cast(ushort) 0x02d1,
    HID_USAGE_CONSUMER_PRIVACY_SCREEN_LEVEL_INCREMENT       = cast(ushort) 0x02d2,
    HID_USAGE_CONSUMER_PRIVACY_SCREEN_LEVEL_MINIMUM         = cast(ushort) 0x02d3,
    HID_USAGE_CONSUMER_PRIVACY_SCREEN_LEVEL_MAXIMUM         = cast(ushort) 0x02d4,
    HID_USAGE_CONSUMER_CONTACT_EDITED                       = cast(ushort) 0x0500,
    HID_USAGE_CONSUMER_CONTACT_ADDED                        = cast(ushort) 0x0501,
    HID_USAGE_CONSUMER_CONTACT_RECORD_ACTIVE                = cast(ushort) 0x0502,
    HID_USAGE_CONSUMER_CONTACT_INDEX                        = cast(ushort) 0x0503,
    HID_USAGE_CONSUMER_CONTACT_NICKNAME                     = cast(ushort) 0x0504,
    HID_USAGE_CONSUMER_CONTACT_FIRST_NAME                   = cast(ushort) 0x0505,
    HID_USAGE_CONSUMER_CONTACT_LAST_NAME                    = cast(ushort) 0x0506,
    HID_USAGE_CONSUMER_CONTACT_FULL_NAME                    = cast(ushort) 0x0507,
    HID_USAGE_CONSUMER_CONTACT_PHONE_NUMBER_PERSONAL        = cast(ushort) 0x0508,
    HID_USAGE_CONSUMER_CONTACT_PHONE_NUMBER_BUSINESS        = cast(ushort) 0x0509,
    HID_USAGE_CONSUMER_CONTACT_PHONE_NUMBER_MOBILE          = cast(ushort) 0x050a,
    HID_USAGE_CONSUMER_CONTACT_PHONE_NUMBER_PAGER           = cast(ushort) 0x050b,
    HID_USAGE_CONSUMER_CONTACT_PHONE_NUMBER_FAX             = cast(ushort) 0x050c,
    HID_USAGE_CONSUMER_CONTACT_PHONE_NUMBER_OTHER           = cast(ushort) 0x050d,
    HID_USAGE_CONSUMER_CONTACT_EMAIL_PERSONAL               = cast(ushort) 0x050e,
    HID_USAGE_CONSUMER_CONTACT_EMAIL_BUSINESS               = cast(ushort) 0x050f,
    HID_USAGE_CONSUMER_CONTACT_EMAIL_OTHER                  = cast(ushort) 0x0510,
    HID_USAGE_CONSUMER_CONTACT_EMAIL_MAIN                   = cast(ushort) 0x0511,
    HID_USAGE_CONSUMER_CONTACT_SPEED_DIAL_NUMBER            = cast(ushort) 0x0512,
    HID_USAGE_CONSUMER_CONTACT_STATUS_FLAG                  = cast(ushort) 0x0513,
    HID_USAGE_CONSUMER_CONTACT_MISC                         = cast(ushort) 0x0514,
    HID_USAGE_CONSUMER_KEYBOARD_BRIGHTNESS_NEXT             = cast(ushort) 0x0515,
    HID_USAGE_CONSUMER_KEYBOARD_BRIGHTNESS_PREVIOUS         = cast(ushort) 0x0516,
    HID_USAGE_CONSUMER_KEYBOARD_BACKLIGHT_LEVEL_SUGGESTION  = cast(ushort) 0x0517,
}

enum : ushort
{
    HID_USAGE_DIGITIZER_DIGITIZER                      = cast(ushort) 0x0001,
    HID_USAGE_DIGITIZER_PEN                            = cast(ushort) 0x0002,
    HID_USAGE_DIGITIZER_LIGHT_PEN                      = cast(ushort) 0x0003,
    HID_USAGE_DIGITIZER_TOUCH_SCREEN                   = cast(ushort) 0x0004,
    HID_USAGE_DIGITIZER_TOUCH_PAD                      = cast(ushort) 0x0005,
    HID_USAGE_DIGITIZER_WHITE_BOARD                    = cast(ushort) 0x0006,
    HID_USAGE_DIGITIZER_COORD_MEASURING                = cast(ushort) 0x0007,
    HID_USAGE_DIGITIZER_3D_DIGITIZER                   = cast(ushort) 0x0008,
    HID_USAGE_DIGITIZER_STEREO_PLOTTER                 = cast(ushort) 0x0009,
    HID_USAGE_DIGITIZER_ARTICULATED_ARM                = cast(ushort) 0x000a,
    HID_USAGE_DIGITIZER_ARMATURE                       = cast(ushort) 0x000b,
    HID_USAGE_DIGITIZER_MULTI_POINT                    = cast(ushort) 0x000c,
    HID_USAGE_DIGITIZER_FREE_SPACE_WAND                = cast(ushort) 0x000d,
    HID_USAGE_DIGITIZER_DEVICE_CONFIGURATION           = cast(ushort) 0x000e,
    HID_USAGE_DIGITIZER_HEAT_MAP                       = cast(ushort) 0x000f,
    HID_USAGE_DIGITIZER_STYLUS                         = cast(ushort) 0x0020,
    HID_USAGE_DIGITIZER_PUCK                           = cast(ushort) 0x0021,
    HID_USAGE_DIGITIZER_FINGER                         = cast(ushort) 0x0022,
    HID_USAGE_DIGITIZER_DEVICE_SETTINGS                = cast(ushort) 0x0023,
    HID_USAGE_DIGITIZER_CHARACTER_GESTURE              = cast(ushort) 0x0024,
    HID_USAGE_DIGITIZER_TIP_PRESSURE                   = cast(ushort) 0x0030,
    HID_USAGE_DIGITIZER_BARREL_PRESSURE                = cast(ushort) 0x0031,
    HID_USAGE_DIGITIZER_IN_RANGE                       = cast(ushort) 0x0032,
    HID_USAGE_DIGITIZER_TOUCH                          = cast(ushort) 0x0033,
    HID_USAGE_DIGITIZER_UNTOUCH                        = cast(ushort) 0x0034,
    HID_USAGE_DIGITIZER_TAP                            = cast(ushort) 0x0035,
    HID_USAGE_DIGITIZER_QUALITY                        = cast(ushort) 0x0036,
    HID_USAGE_DIGITIZER_DATA_VALID                     = cast(ushort) 0x0037,
    HID_USAGE_DIGITIZER_TRANSDUCER_INDEX               = cast(ushort) 0x0038,
    HID_USAGE_DIGITIZER_TABLET_FUNC_KEYS               = cast(ushort) 0x0039,
    HID_USAGE_DIGITIZER_PROG_CHANGE_KEYS               = cast(ushort) 0x003a,
    HID_USAGE_DIGITIZER_BATTERY_STRENGTH               = cast(ushort) 0x003b,
    HID_USAGE_DIGITIZER_INVERT                         = cast(ushort) 0x003c,
    HID_USAGE_DIGITIZER_X_TILT                         = cast(ushort) 0x003d,
    HID_USAGE_DIGITIZER_Y_TILT                         = cast(ushort) 0x003e,
    HID_USAGE_DIGITIZER_AZIMUTH                        = cast(ushort) 0x003f,
    HID_USAGE_DIGITIZER_ALTITUDE                       = cast(ushort) 0x0040,
    HID_USAGE_DIGITIZER_TWIST                          = cast(ushort) 0x0041,
    HID_USAGE_DIGITIZER_TIP_SWITCH                     = cast(ushort) 0x0042,
    HID_USAGE_DIGITIZER_SECONDARY_TIP_SWITCH           = cast(ushort) 0x0043,
    HID_USAGE_DIGITIZER_BARREL_SWITCH                  = cast(ushort) 0x0044,
    HID_USAGE_DIGITIZER_ERASER                         = cast(ushort) 0x0045,
    HID_USAGE_DIGITIZER_TABLET_PICK                    = cast(ushort) 0x0046,
    HID_USAGE_DIGITIZER_TOUCH_VALID                    = cast(ushort) 0x0047,
    HID_USAGE_DIGITIZER_WIDTH                          = cast(ushort) 0x0048,
    HID_USAGE_DIGITIZER_HEIGHT                         = cast(ushort) 0x0049,
    HID_USAGE_DIGITIZER_CONTACT_IDENTIFIER             = cast(ushort) 0x0051,
    HID_USAGE_DIGITIZER_DEVICE_MODE                    = cast(ushort) 0x0052,
    HID_USAGE_DIGITIZER_DEVICE_IDENTIFIER              = cast(ushort) 0x0053,
    HID_USAGE_DIGITIZER_CONTACT_COUNT                  = cast(ushort) 0x0054,
    HID_USAGE_DIGITIZER_CONTACT_COUNT_MAXIMUM          = cast(ushort) 0x0055,
    HID_USAGE_DIGITIZER_SCAN_TIME                      = cast(ushort) 0x0056,
    HID_USAGE_DIGITIZER_SURFACE_SWITCH                 = cast(ushort) 0x0057,
    HID_USAGE_DIGITIZER_BUTTON_SWITCH                  = cast(ushort) 0x0058,
    HID_USAGE_DIGITIZER_PAD_TYPE                       = cast(ushort) 0x0059,
    HID_USAGE_DIGITIZER_SECONDARY_BARREL_SWITCH        = cast(ushort) 0x005a,
    HID_USAGE_DIGITIZER_TRANSDUCER_SERIAL              = cast(ushort) 0x005b,
    HID_USAGE_DIGITIZER_PREFERRED_COLOR                = cast(ushort) 0x005c,
    HID_USAGE_DIGITIZER_PREFERRED_COLOR_IS_LOCKED      = cast(ushort) 0x005d,
    HID_USAGE_DIGITIZER_PREFERRED_LINE_WIDTH           = cast(ushort) 0x005e,
    HID_USAGE_DIGITIZER_PREFERRED_LINE_WIDTH_IS_LOCKED = cast(ushort) 0x005f,
}

enum : ushort
{
    HID_USAGE_DIGITIZER_LATENCY_MODE                                   = cast(ushort) 0x0060,
    HID_USAGE_DIGITIZER_GESTURE_CHARACTER_QUALITY                      = cast(ushort) 0x0061,
    HID_USAGE_DIGITIZER_CHARACTER_GESTURE_DATA_LENGTH                  = cast(ushort) 0x0062,
    HID_USAGE_DIGITIZER_CHARACTER_GESTURE_DATA                         = cast(ushort) 0x0063,
    HID_USAGE_DIGITIZER_GESTURE_CHARACTER_ENCODING                     = cast(ushort) 0x0064,
    HID_USAGE_DIGITIZER_UTF8_CHARACTER_GESTURE_ENCODING                = cast(ushort) 0x0065,
    HID_USAGE_DIGITIZER_UTF16_LITTLE_ENDIAN_CHARACTER_GESTURE_ENCODING = cast(ushort) 0x0066,
}

enum ushort HID_USAGE_DIGITIZER_UTF16_BIG_ENDIAN_CHARACTER_GESTURE_ENCODING = cast(ushort) 0x0067;
enum ushort HID_USAGE_DIGITIZER_UTF32_LITTLE_ENDIAN_CHARACTER_GESTURE_ENCODING = cast(ushort) 0x0068;
enum ushort HID_USAGE_DIGITIZER_UTF32_BIG_ENDIAN_CHARACTER_GESTURE_ENCODING = cast(ushort) 0x0069;

enum : ushort
{
    HID_USAGE_DIGITIZER_HEAT_MAP_PROTOCOL_VENDOR_ID    = cast(ushort) 0x006a,
    HID_USAGE_DIGITIZER_HEAT_MAP_PROTOCOL_VERSION      = cast(ushort) 0x006b,
    HID_USAGE_DIGITIZER_HEAT_MAP_FRAME_DATA            = cast(ushort) 0x006c,
    HID_USAGE_DIGITIZER_GESTURE_CHARACTER_ENABLE       = cast(ushort) 0x006d,
    HID_USAGE_DIGITIZER_TRANSDUCER_SERIAL_PART2        = cast(ushort) 0x006e,
    HID_USAGE_DIGITIZER_NO_PREFERRED_COLOR             = cast(ushort) 0x006f,
    HID_USAGE_DIGITIZER_PREFERRED_LINE_STYLE           = cast(ushort) 0x0070,
    HID_USAGE_DIGITIZER_PREFERRED_LINE_STYLE_IS_LOCKED = cast(ushort) 0x0071,
}

enum : ushort
{
    HID_USAGE_DIGITIZER_INK                                 = cast(ushort) 0x0072,
    HID_USAGE_DIGITIZER_PENCIL                              = cast(ushort) 0x0073,
    HID_USAGE_DIGITIZER_HIGHLIGHTER                         = cast(ushort) 0x0074,
    HID_USAGE_DIGITIZER_CHISEL_MARKER                       = cast(ushort) 0x0075,
    HID_USAGE_DIGITIZER_BRUSH                               = cast(ushort) 0x0076,
    HID_USAGE_DIGITIZER_NO_PREFERENCE                       = cast(ushort) 0x0077,
    HID_USAGE_DIGITIZER_DIGITIZER_DIAGNOSTIC                = cast(ushort) 0x0080,
    HID_USAGE_DIGITIZER_DIGITIZER_ERROR                     = cast(ushort) 0x0081,
    HID_USAGE_DIGITIZER_ERR_NORMAL_STATUS                   = cast(ushort) 0x0082,
    HID_USAGE_DIGITIZER_ERR_TRANSDUCERS_EXCEEDED            = cast(ushort) 0x0083,
    HID_USAGE_DIGITIZER_ERR_FULL_TRANS_FEATURES_UNAVAILABLE = cast(ushort) 0x0084,
    HID_USAGE_DIGITIZER_ERR_CHARGE_LOW                      = cast(ushort) 0x0085,
    HID_USAGE_DIGITIZER_TRANSDUCER_SOFTWARE_INFO            = cast(ushort) 0x0090,
    HID_USAGE_DIGITIZER_TRANSDUCER_VENDOR                   = cast(ushort) 0x0091,
    HID_USAGE_DIGITIZER_TRANSDUCER_PRODUCT                  = cast(ushort) 0x0092,
    HID_USAGE_DIGITIZER_DEVICE_SUPPORTED_PROTOCOLS          = cast(ushort) 0x0093,
    HID_USAGE_DIGITIZER_TRANSDUCER_SUPPORTED_PROTOCOLS      = cast(ushort) 0x0094,
}

enum : ushort
{
    HID_USAGE_DIGITIZER_NO_PROTOCOL               = cast(ushort) 0x0095,
    HID_USAGE_DIGITIZER_WACOM_AES_PROTOCOL        = cast(ushort) 0x0096,
    HID_USAGE_DIGITIZER_USI_PROTOCOL              = cast(ushort) 0x0097,
    HID_USAGE_DIGITIZER_MICROSOFT_PEN_PROTOCOL    = cast(ushort) 0x0098,
    HID_USAGE_DIGITIZER_SUPPORTED_REPORT_RATES    = cast(ushort) 0x00a0,
    HID_USAGE_DIGITIZER_REPORT_RATE               = cast(ushort) 0x00a1,
    HID_USAGE_DIGITIZER_TRANSDUCER_CONNECTED      = cast(ushort) 0x00a2,
    HID_USAGE_DIGITIZER_SWITCH_DISABLED           = cast(ushort) 0x00a3,
    HID_USAGE_DIGITIZER_SWITCH_UNIMPLEMENTED      = cast(ushort) 0x00a4,
    HID_USAGE_DIGITIZER_TRANSDUCER_SWITCHES       = cast(ushort) 0x00a5,
    HID_USAGE_DIGITIZER_TRANSDUCER_INDEX_SELECTOR = cast(ushort) 0x00a6,
    HID_USAGE_DIGITIZER_BUTTON_PRESS_THRESHOLD    = cast(ushort) 0x00b0,
}

enum : ushort
{
    HID_USAGE_EYE_AND_HEAD_TRACKERS_EYE_TRACKER                 = cast(ushort) 0x0001,
    HID_USAGE_EYE_AND_HEAD_TRACKERS_HEAD_TRACKER                = cast(ushort) 0x0002,
    HID_USAGE_EYE_AND_HEAD_TRACKERS_TRACKING_DATA               = cast(ushort) 0x0010,
    HID_USAGE_EYE_AND_HEAD_TRACKERS_CAPABILITIES                = cast(ushort) 0x0011,
    HID_USAGE_EYE_AND_HEAD_TRACKERS_CONFIGURATION               = cast(ushort) 0x0012,
    HID_USAGE_EYE_AND_HEAD_TRACKERS_STATUS                      = cast(ushort) 0x0013,
    HID_USAGE_EYE_AND_HEAD_TRACKERS_CONTROL                     = cast(ushort) 0x0014,
    HID_USAGE_EYE_AND_HEAD_TRACKERS_SENSOR_TIMESTAMP            = cast(ushort) 0x0020,
    HID_USAGE_EYE_AND_HEAD_TRACKERS_POSITION_X                  = cast(ushort) 0x0021,
    HID_USAGE_EYE_AND_HEAD_TRACKERS_POSITION_Y                  = cast(ushort) 0x0022,
    HID_USAGE_EYE_AND_HEAD_TRACKERS_POSITION_Z                  = cast(ushort) 0x0023,
    HID_USAGE_EYE_AND_HEAD_TRACKERS_GAZE_POINT                  = cast(ushort) 0x0024,
    HID_USAGE_EYE_AND_HEAD_TRACKERS_LEFT_EYE_POSITION           = cast(ushort) 0x0025,
    HID_USAGE_EYE_AND_HEAD_TRACKERS_RIGHT_EYE_POSITION          = cast(ushort) 0x0026,
    HID_USAGE_EYE_AND_HEAD_TRACKERS_HEAD_POSITION               = cast(ushort) 0x0027,
    HID_USAGE_EYE_AND_HEAD_TRACKERS_HEAD_DIRECTION_POINT        = cast(ushort) 0x0028,
    HID_USAGE_EYE_AND_HEAD_TRACKERS_ROTATION_ABOUT_X_AXIS       = cast(ushort) 0x0029,
    HID_USAGE_EYE_AND_HEAD_TRACKERS_ROTATION_ABOUT_Y_AXIS       = cast(ushort) 0x002a,
    HID_USAGE_EYE_AND_HEAD_TRACKERS_ROTATION_ABOUT_Z_AXIS       = cast(ushort) 0x002b,
    HID_USAGE_EYE_AND_HEAD_TRACKERS_TRACKER_QUALITY             = cast(ushort) 0x0100,
    HID_USAGE_EYE_AND_HEAD_TRACKERS_MINIMUM_TRACKING_DISTANCE   = cast(ushort) 0x0101,
    HID_USAGE_EYE_AND_HEAD_TRACKERS_OPTIMUM_TRACKING_DISTANCE   = cast(ushort) 0x0102,
    HID_USAGE_EYE_AND_HEAD_TRACKERS_MAXIMUM_TRACKING_DISTANCE   = cast(ushort) 0x0103,
    HID_USAGE_EYE_AND_HEAD_TRACKERS_MAXIMUM_SCREEN_PLANE_WIDTH  = cast(ushort) 0x0104,
    HID_USAGE_EYE_AND_HEAD_TRACKERS_MAXIMUM_SCREEN_PLANE_HEIGHT = cast(ushort) 0x0105,
    HID_USAGE_EYE_AND_HEAD_TRACKERS_DISPLAY_MANUFACTURER_ID     = cast(ushort) 0x0200,
    HID_USAGE_EYE_AND_HEAD_TRACKERS_DISPLAY_PRODUCT_ID          = cast(ushort) 0x0201,
    HID_USAGE_EYE_AND_HEAD_TRACKERS_DISPLAY_SERIAL_NUMBER       = cast(ushort) 0x0202,
    HID_USAGE_EYE_AND_HEAD_TRACKERS_DISPLAY_MANUFACTURER_DATE   = cast(ushort) 0x0203,
    HID_USAGE_EYE_AND_HEAD_TRACKERS_CALIBRATED_SCREEN_WIDTH     = cast(ushort) 0x0204,
    HID_USAGE_EYE_AND_HEAD_TRACKERS_CALIBRATED_SCREEN_HEIGHT    = cast(ushort) 0x0205,
    HID_USAGE_EYE_AND_HEAD_TRACKERS_SAMPLING_FREQUENCY          = cast(ushort) 0x0300,
    HID_USAGE_EYE_AND_HEAD_TRACKERS_CONFIGURATION_STATUS        = cast(ushort) 0x0301,
    HID_USAGE_EYE_AND_HEAD_TRACKERS_DEVICE_MODE_REQUEST         = cast(ushort) 0x0400,
}

enum : ushort
{
    HID_USAGE_FIDO_ALLIANCE_U2F_AUTHENTICATOR_DEVICE = cast(ushort) 0x0001,
    HID_USAGE_FIDO_ALLIANCE_INPUT_REPORT_DATA        = cast(ushort) 0x0020,
    HID_USAGE_FIDO_ALLIANCE_OUTPUT_REPORT_DATA       = cast(ushort) 0x0021,
}

enum : ushort
{
    HID_USAGE_GAME_3D_GAME_CONTROLLER  = cast(ushort) 0x0001,
    HID_USAGE_GAME_PINBALL_DEVICE      = cast(ushort) 0x0002,
    HID_USAGE_GAME_GUN_DEVICE          = cast(ushort) 0x0003,
    HID_USAGE_GAME_POV                 = cast(ushort) 0x0020,
    HID_USAGE_GAME_TURN_RIGHT_LEFT     = cast(ushort) 0x0021,
    HID_USAGE_GAME_PITCH_FORWARD_BACK  = cast(ushort) 0x0022,
    HID_USAGE_GAME_ROLL_RIGHT_LEFT     = cast(ushort) 0x0023,
    HID_USAGE_GAME_MOVE_RIGHT_LEFT     = cast(ushort) 0x0024,
    HID_USAGE_GAME_MOVE_FORWARD_BACK   = cast(ushort) 0x0025,
    HID_USAGE_GAME_MOVE_UP_DOWN        = cast(ushort) 0x0026,
    HID_USAGE_GAME_LEAN_RIGHT_LEFT     = cast(ushort) 0x0027,
    HID_USAGE_GAME_LEAN_FORWARD_BACK   = cast(ushort) 0x0028,
    HID_USAGE_GAME_POV_HEIGHT          = cast(ushort) 0x0029,
    HID_USAGE_GAME_FLIPPER             = cast(ushort) 0x002a,
    HID_USAGE_GAME_SECONDARY_FLIPPER   = cast(ushort) 0x002b,
    HID_USAGE_GAME_BUMP                = cast(ushort) 0x002c,
    HID_USAGE_GAME_NEW_GAME            = cast(ushort) 0x002d,
    HID_USAGE_GAME_SHOOT_BALL          = cast(ushort) 0x002e,
    HID_USAGE_GAME_PLAYER              = cast(ushort) 0x002f,
    HID_USAGE_GAME_GUN_BOLT            = cast(ushort) 0x0030,
    HID_USAGE_GAME_GUN_CLIP            = cast(ushort) 0x0031,
    HID_USAGE_GAME_GUN_SELECTOR        = cast(ushort) 0x0032,
    HID_USAGE_GAME_GUN_SINGLE_SHOT     = cast(ushort) 0x0033,
    HID_USAGE_GAME_GUN_BURST           = cast(ushort) 0x0034,
    HID_USAGE_GAME_GUN_AUTOMATIC       = cast(ushort) 0x0035,
    HID_USAGE_GAME_GUN_SAFETY          = cast(ushort) 0x0036,
    HID_USAGE_GAME_GAMEPAD_FIRE_JUMP   = cast(ushort) 0x0037,
    HID_USAGE_GAME_GAMEPAD_TRIGGER     = cast(ushort) 0x0039,
    HID_USAGE_GAME_FORMFITTING_GAMEPAD = cast(ushort) 0x003a,
}

enum : ushort
{
    HID_USAGE_GENERIC_POINTER                       = cast(ushort) 0x0001,
    HID_USAGE_GENERIC_MOUSE                         = cast(ushort) 0x0002,
    HID_USAGE_GENERIC_JOYSTICK                      = cast(ushort) 0x0004,
    HID_USAGE_GENERIC_GAMEPAD                       = cast(ushort) 0x0005,
    HID_USAGE_GENERIC_KEYBOARD                      = cast(ushort) 0x0006,
    HID_USAGE_GENERIC_KEYPAD                        = cast(ushort) 0x0007,
    HID_USAGE_GENERIC_MULTI_AXIS_CONTROLLER         = cast(ushort) 0x0008,
    HID_USAGE_GENERIC_TABLET_PC_SYSTEM_CTL          = cast(ushort) 0x0009,
    HID_USAGE_GENERIC_WATER_COOLING_DEVICE          = cast(ushort) 0x000a,
    HID_USAGE_GENERIC_COMPUTER_CHASSIS_DEVICE       = cast(ushort) 0x000b,
    HID_USAGE_GENERIC_WIRELESS_RADIO_CONTROLS       = cast(ushort) 0x000c,
    HID_USAGE_GENERIC_PORTABLE_DEVICE_CONTROL       = cast(ushort) 0x000d,
    HID_USAGE_GENERIC_INTERACTIVE_CONTROL           = cast(ushort) 0x000e,
    HID_USAGE_GENERIC_SPATIAL_CONTROLLER            = cast(ushort) 0x000f,
    HID_USAGE_GENERIC_ASSISTIVE_CONTROL             = cast(ushort) 0x0010,
    HID_USAGE_GENERIC_DEVICE_DOCK                   = cast(ushort) 0x0011,
    HID_USAGE_GENERIC_DOCKABLE_DEVICE               = cast(ushort) 0x0012,
    HID_USAGE_GENERIC_CALL_STATE_MANAGEMENT_CONTROL = cast(ushort) 0x0013,
}

enum : ushort
{
    HID_USAGE_GENERIC_X                            = cast(ushort) 0x0030,
    HID_USAGE_GENERIC_Y                            = cast(ushort) 0x0031,
    HID_USAGE_GENERIC_Z                            = cast(ushort) 0x0032,
    HID_USAGE_GENERIC_RX                           = cast(ushort) 0x0033,
    HID_USAGE_GENERIC_RY                           = cast(ushort) 0x0034,
    HID_USAGE_GENERIC_RZ                           = cast(ushort) 0x0035,
    HID_USAGE_GENERIC_SLIDER                       = cast(ushort) 0x0036,
    HID_USAGE_GENERIC_DIAL                         = cast(ushort) 0x0037,
    HID_USAGE_GENERIC_WHEEL                        = cast(ushort) 0x0038,
    HID_USAGE_GENERIC_HATSWITCH                    = cast(ushort) 0x0039,
    HID_USAGE_GENERIC_COUNTED_BUFFER               = cast(ushort) 0x003a,
    HID_USAGE_GENERIC_BYTE_COUNT                   = cast(ushort) 0x003b,
    HID_USAGE_GENERIC_MOTION_WAKEUP                = cast(ushort) 0x003c,
    HID_USAGE_GENERIC_START                        = cast(ushort) 0x003d,
    HID_USAGE_GENERIC_SELECT                       = cast(ushort) 0x003e,
    HID_USAGE_GENERIC_VX                           = cast(ushort) 0x0040,
    HID_USAGE_GENERIC_VY                           = cast(ushort) 0x0041,
    HID_USAGE_GENERIC_VZ                           = cast(ushort) 0x0042,
    HID_USAGE_GENERIC_VBRX                         = cast(ushort) 0x0043,
    HID_USAGE_GENERIC_VBRY                         = cast(ushort) 0x0044,
    HID_USAGE_GENERIC_VBRZ                         = cast(ushort) 0x0045,
    HID_USAGE_GENERIC_VNO                          = cast(ushort) 0x0046,
    HID_USAGE_GENERIC_FEATURE_NOTIFICATION         = cast(ushort) 0x0047,
    HID_USAGE_GENERIC_RESOLUTION_MULTIPLIER        = cast(ushort) 0x0048,
    HID_USAGE_GENERIC_QX                           = cast(ushort) 0x0049,
    HID_USAGE_GENERIC_QY                           = cast(ushort) 0x004a,
    HID_USAGE_GENERIC_QZ                           = cast(ushort) 0x004b,
    HID_USAGE_GENERIC_QW                           = cast(ushort) 0x004c,
    HID_USAGE_GENERIC_SYSTEM_CTL                   = cast(ushort) 0x0080,
    HID_USAGE_GENERIC_SYSCTL_POWER                 = cast(ushort) 0x0081,
    HID_USAGE_GENERIC_SYSCTL_SLEEP                 = cast(ushort) 0x0082,
    HID_USAGE_GENERIC_SYSCTL_WAKE                  = cast(ushort) 0x0083,
    HID_USAGE_GENERIC_SYSCTL_CONTEXT_MENU          = cast(ushort) 0x0084,
    HID_USAGE_GENERIC_SYSCTL_MAIN_MENU             = cast(ushort) 0x0085,
    HID_USAGE_GENERIC_SYSCTL_APP_MENU              = cast(ushort) 0x0086,
    HID_USAGE_GENERIC_SYSCTL_HELP_MENU             = cast(ushort) 0x0087,
    HID_USAGE_GENERIC_SYSCTL_MENU_EXIT             = cast(ushort) 0x0088,
    HID_USAGE_GENERIC_SYSCTL_MENU_SELECT           = cast(ushort) 0x0089,
    HID_USAGE_GENERIC_SYSCTL_MENU_RIGHT            = cast(ushort) 0x008a,
    HID_USAGE_GENERIC_SYSCTL_MENU_LEFT             = cast(ushort) 0x008b,
    HID_USAGE_GENERIC_SYSCTL_MENU_UP               = cast(ushort) 0x008c,
    HID_USAGE_GENERIC_SYSCTL_MENU_DOWN             = cast(ushort) 0x008d,
    HID_USAGE_GENERIC_SYSCTL_COLD_RESTART          = cast(ushort) 0x008e,
    HID_USAGE_GENERIC_SYSCTL_WARM_RESTART          = cast(ushort) 0x008f,
    HID_USAGE_GENERIC_DPAD_UP                      = cast(ushort) 0x0090,
    HID_USAGE_GENERIC_DPAD_DOWN                    = cast(ushort) 0x0091,
    HID_USAGE_GENERIC_DPAD_RIGHT                   = cast(ushort) 0x0092,
    HID_USAGE_GENERIC_DPAD_LEFT                    = cast(ushort) 0x0093,
    HID_USAGE_GENERIC_INDEX_TRIGGER                = cast(ushort) 0x0094,
    HID_USAGE_GENERIC_PALM_TRIGGER                 = cast(ushort) 0x0095,
    HID_USAGE_GENERIC_THUMBSTICK                   = cast(ushort) 0x0096,
    HID_USAGE_GENERIC_SYSCTL_FN                    = cast(ushort) 0x0097,
    HID_USAGE_GENERIC_SYSCTL_FN_LOCK               = cast(ushort) 0x0098,
    HID_USAGE_GENERIC_SYSCTL_FN_LOCK_INDICATOR     = cast(ushort) 0x0099,
    HID_USAGE_GENERIC_SYSCTL_DISMISS_NOTIFICATION  = cast(ushort) 0x009a,
    HID_USAGE_GENERIC_SYSTEM_DO_NOT_DISTURB        = cast(ushort) 0x009b,
    HID_USAGE_GENERIC_SYSCTL_DOCK                  = cast(ushort) 0x00a0,
    HID_USAGE_GENERIC_SYSCTL_UNDOCK                = cast(ushort) 0x00a1,
    HID_USAGE_GENERIC_SYSCTL_SETUP                 = cast(ushort) 0x00a2,
    HID_USAGE_GENERIC_SYSCTL_SYS_BREAK             = cast(ushort) 0x00a3,
    HID_USAGE_GENERIC_SYSCTL_SYS_DBG_BREAK         = cast(ushort) 0x00a4,
    HID_USAGE_GENERIC_SYSCTL_APP_BREAK             = cast(ushort) 0x00a5,
    HID_USAGE_GENERIC_SYSCTL_APP_DBG_BREAK         = cast(ushort) 0x00a6,
    HID_USAGE_GENERIC_SYSCTL_MUTE                  = cast(ushort) 0x00a7,
    HID_USAGE_GENERIC_SYSCTL_HIBERNATE             = cast(ushort) 0x00a8,
    HID_USAGE_GENERIC_SYSCTL_MICROPHONE_MUTE       = cast(ushort) 0x00a9,
    HID_USAGE_GENERIC_SYSCTL_ACCESSIBILITY_BINDING = cast(ushort) 0x00aa,
    HID_USAGE_GENERIC_SYSCTL_DISP_INVERT           = cast(ushort) 0x00b0,
    HID_USAGE_GENERIC_SYSCTL_DISP_INTERNAL         = cast(ushort) 0x00b1,
    HID_USAGE_GENERIC_SYSCTL_DISP_EXTERNAL         = cast(ushort) 0x00b2,
    HID_USAGE_GENERIC_SYSCTL_DISP_BOTH             = cast(ushort) 0x00b3,
    HID_USAGE_GENERIC_SYSCTL_DISP_DUAL             = cast(ushort) 0x00b4,
    HID_USAGE_GENERIC_SYSCTL_DISP_TOGGLE           = cast(ushort) 0x00b5,
    HID_USAGE_GENERIC_SYSCTL_DISP_SWAP             = cast(ushort) 0x00b6,
    HID_USAGE_GENERIC_SYSCTL_DISP_AUTOSCALE        = cast(ushort) 0x00b7,
    HID_USAGE_GENERIC_SENSOR_ZONE                  = cast(ushort) 0x00c0,
    HID_USAGE_GENERIC_RPM                          = cast(ushort) 0x00c1,
    HID_USAGE_GENERIC_COOLANT_LEVEL                = cast(ushort) 0x00c2,
    HID_USAGE_GENERIC_COOLANT_CRITICAL_LEVEL       = cast(ushort) 0x00c3,
    HID_USAGE_GENERIC_COOLANT_PUMP                 = cast(ushort) 0x00c4,
    HID_USAGE_GENERIC_CHASSIS_ENCLOSURE            = cast(ushort) 0x00c5,
    HID_USAGE_GENERIC_WIRELESS_RADIO_BUTTON        = cast(ushort) 0x00c6,
    HID_USAGE_GENERIC_WIRELESS_RADIO_LED           = cast(ushort) 0x00c7,
    HID_USAGE_GENERIC_WIRELESS_RADIO_SLIDER_SWITCH = cast(ushort) 0x00c8,
}

enum : ushort
{
    HID_USAGE_GENERIC_SYSTEM_DISPLAY_ROTATION_LOCK_BUTTON        = cast(ushort) 0x00c9,
    HID_USAGE_GENERIC_SYSTEM_DISPLAY_ROTATION_LOCK_SLIDER_SWITCH = cast(ushort) 0x00ca,
}

enum : ushort
{
    HID_USAGE_GENERIC_CONTROL_ENABLE                     = cast(ushort) 0x00cb,
    HID_USAGE_GENERIC_DOCKABLE_DEVICE_UNIQUE_ID          = cast(ushort) 0x00d0,
    HID_USAGE_GENERIC_DOCKABLE_DEVICE_VENDOR_ID          = cast(ushort) 0x00d1,
    HID_USAGE_GENERIC_DOCKABLE_DEVICE_PRIMARY_USAGE_PAGE = cast(ushort) 0x00d2,
    HID_USAGE_GENERIC_DOCKABLE_DEVICE_PRIMARY_USAGE_ID   = cast(ushort) 0x00d3,
    HID_USAGE_GENERIC_DOCKABLE_DEVICE_DOCKING_STATE      = cast(ushort) 0x00d4,
    HID_USAGE_GENERIC_DOCKABLE_DEVICE_DISPLAY_OCCLUSION  = cast(ushort) 0x00d5,
    HID_USAGE_GENERIC_DOCKABLE_DEVICE_OBJECT_TYPE        = cast(ushort) 0x00d6,
}

enum : ushort
{
    HID_USAGE_GENERIC_CALL_ACTIVE_LED                   = cast(ushort) 0x00e0,
    HID_USAGE_GENERIC_CALL_MUTE_TOGGLE                  = cast(ushort) 0x00e1,
    HID_USAGE_GENERIC_CALL_MUTE_LED                     = cast(ushort) 0x00e2,
    HID_USAGE_GENERIC_DEVICE_BACKGROUNDNONUSER_CONTROLS = cast(ushort) 0x0001,
    HID_USAGE_GENERIC_DEVICE_BATTERY_STRENGTH           = cast(ushort) 0x0020,
    HID_USAGE_GENERIC_DEVICE_WIRELESS_CHANNEL           = cast(ushort) 0x0021,
    HID_USAGE_GENERIC_DEVICE_WIRELESS_ID                = cast(ushort) 0x0022,
    HID_USAGE_GENERIC_DEVICE_DISCOVER_WIRELESS_CONTROL  = cast(ushort) 0x0023,
    HID_USAGE_GENERIC_DEVICE_SECURITY_CODE_CHAR_ENTERED = cast(ushort) 0x0024,
    HID_USAGE_GENERIC_DEVICE_SECURITY_CODE_CHAR_ERASED  = cast(ushort) 0x0025,
    HID_USAGE_GENERIC_DEVICE_SECURITY_CODE_CLEARED      = cast(ushort) 0x0026,
    HID_USAGE_GENERIC_DEVICE_SEQUENCE_ID                = cast(ushort) 0x0027,
    HID_USAGE_GENERIC_DEVICE_SEQUENCE_ID_RESET          = cast(ushort) 0x0028,
    HID_USAGE_GENERIC_DEVICE_RF_SIGNAL_STRENGTH         = cast(ushort) 0x0029,
    HID_USAGE_GENERIC_DEVICE_SOFTWARE_VERSION           = cast(ushort) 0x002a,
    HID_USAGE_GENERIC_DEVICE_PROTOCOL_VERSION           = cast(ushort) 0x002b,
    HID_USAGE_GENERIC_DEVICE_HARDWARE_VERSION           = cast(ushort) 0x002c,
    HID_USAGE_GENERIC_DEVICE_MAJOR                      = cast(ushort) 0x002d,
    HID_USAGE_GENERIC_DEVICE_MINOR                      = cast(ushort) 0x002e,
    HID_USAGE_GENERIC_DEVICE_REVISION                   = cast(ushort) 0x002f,
    HID_USAGE_GENERIC_DEVICE_HANDEDNESS                 = cast(ushort) 0x0030,
    HID_USAGE_GENERIC_DEVICE_EITHER_HAND                = cast(ushort) 0x0031,
    HID_USAGE_GENERIC_DEVICE_LEFT_HAND                  = cast(ushort) 0x0032,
    HID_USAGE_GENERIC_DEVICE_RIGHT_HAND                 = cast(ushort) 0x0033,
    HID_USAGE_GENERIC_DEVICE_BOTH_HANDS                 = cast(ushort) 0x0034,
    HID_USAGE_GENERIC_DEVICE_GRIP_POSE_OFFSET           = cast(ushort) 0x0040,
    HID_USAGE_GENERIC_DEVICE_POINTER_POSE_OFFSET        = cast(ushort) 0x0041,
}

enum : ushort
{
    HID_USAGE_HAPTICS_SIMPLE_CONTROLLER                 = cast(ushort) 0x0001,
    HID_USAGE_HAPTICS_WAVEFORM_LIST                     = cast(ushort) 0x0010,
    HID_USAGE_HAPTICS_DURATION_LIST                     = cast(ushort) 0x0011,
    HID_USAGE_HAPTICS_AUTO_TRIGGER                      = cast(ushort) 0x0020,
    HID_USAGE_HAPTICS_MANUAL_TRIGGER                    = cast(ushort) 0x0021,
    HID_USAGE_HAPTICS_AUTO_ASSOCIATED_CONTROL           = cast(ushort) 0x0022,
    HID_USAGE_HAPTICS_INTENSITY                         = cast(ushort) 0x0023,
    HID_USAGE_HAPTICS_REPEAT_COUNT                      = cast(ushort) 0x0024,
    HID_USAGE_HAPTICS_RETRIGGER_PERIOD                  = cast(ushort) 0x0025,
    HID_USAGE_HAPTICS_WAVEFORM_VENDOR_PAGE              = cast(ushort) 0x0026,
    HID_USAGE_HAPTICS_WAVEFORM_VENDOR_ID                = cast(ushort) 0x0027,
    HID_USAGE_HAPTICS_WAVEFORM_CUTOFF_TIME              = cast(ushort) 0x0028,
    HID_USAGE_HAPTICS_WAVEFORM_NONE                     = cast(ushort) 0x1001,
    HID_USAGE_HAPTICS_WAVEFORM_STOP                     = cast(ushort) 0x1002,
    HID_USAGE_HAPTICS_WAVEFORM_CLICK                    = cast(ushort) 0x1003,
    HID_USAGE_HAPTICS_WAVEFORM_BUZZ                     = cast(ushort) 0x1004,
    HID_USAGE_HAPTICS_WAVEFORM_RUMBLE                   = cast(ushort) 0x1005,
    HID_USAGE_HAPTICS_WAVEFORM_PRESS                    = cast(ushort) 0x1006,
    HID_USAGE_HAPTICS_WAVEFORM_RELEASE                  = cast(ushort) 0x1007,
    HID_USAGE_HAPTICS_WAVEFORM_HOVER                    = cast(ushort) 0x1008,
    HID_USAGE_HAPTICS_WAVEFORM_SUCCESS                  = cast(ushort) 0x1009,
    HID_USAGE_HAPTICS_WAVEFORM_ERROR                    = cast(ushort) 0x100a,
    HID_USAGE_HAPTICS_WAVEFORM_INK_CONTINUOUS           = cast(ushort) 0x100b,
    HID_USAGE_HAPTICS_WAVEFORM_PENCIL_CONTINUOUS        = cast(ushort) 0x100c,
    HID_USAGE_HAPTICS_WAVEFORM_MARKER_CONTINUOUS        = cast(ushort) 0x100d,
    HID_USAGE_HAPTICS_WAVEFORM_CHISEL_MARKER_CONTINUOUS = cast(ushort) 0x100e,
    HID_USAGE_HAPTICS_WAVEFORM_BRUSH_CONTINUOUS         = cast(ushort) 0x100f,
    HID_USAGE_HAPTICS_WAVEFORM_ERASER_CONTINUOUS        = cast(ushort) 0x1010,
    HID_USAGE_HAPTICS_WAVEFORM_SPARKLE_CONTINUOUS       = cast(ushort) 0x1011,
}

enum : ushort
{
    HID_USAGE_KEYBOARD_NOEVENT                       = cast(ushort) 0x0000,
    HID_USAGE_KEYBOARD_ROLLOVER                      = cast(ushort) 0x0001,
    HID_USAGE_KEYBOARD_POSTFAIL                      = cast(ushort) 0x0002,
    HID_USAGE_KEYBOARD_UNDEFINED                     = cast(ushort) 0x0003,
    HID_USAGE_KEYBOARD_aA                            = cast(ushort) 0x0004,
    HID_USAGE_KEYBOARD_bB                            = cast(ushort) 0x0005,
    HID_USAGE_KEYBOARD_cC                            = cast(ushort) 0x0006,
    HID_USAGE_KEYBOARD_dD                            = cast(ushort) 0x0007,
    HID_USAGE_KEYBOARD_eE                            = cast(ushort) 0x0008,
    HID_USAGE_KEYBOARD_fF                            = cast(ushort) 0x0009,
    HID_USAGE_KEYBOARD_gG                            = cast(ushort) 0x000a,
    HID_USAGE_KEYBOARD_hH                            = cast(ushort) 0x000b,
    HID_USAGE_KEYBOARD_iI                            = cast(ushort) 0x000c,
    HID_USAGE_KEYBOARD_jJ                            = cast(ushort) 0x000d,
    HID_USAGE_KEYBOARD_kK                            = cast(ushort) 0x000e,
    HID_USAGE_KEYBOARD_lL                            = cast(ushort) 0x000f,
    HID_USAGE_KEYBOARD_mM                            = cast(ushort) 0x0010,
    HID_USAGE_KEYBOARD_nN                            = cast(ushort) 0x0011,
    HID_USAGE_KEYBOARD_oO                            = cast(ushort) 0x0012,
    HID_USAGE_KEYBOARD_pP                            = cast(ushort) 0x0013,
    HID_USAGE_KEYBOARD_qQ                            = cast(ushort) 0x0014,
    HID_USAGE_KEYBOARD_rR                            = cast(ushort) 0x0015,
    HID_USAGE_KEYBOARD_sS                            = cast(ushort) 0x0016,
    HID_USAGE_KEYBOARD_tT                            = cast(ushort) 0x0017,
    HID_USAGE_KEYBOARD_uU                            = cast(ushort) 0x0018,
    HID_USAGE_KEYBOARD_vV                            = cast(ushort) 0x0019,
    HID_USAGE_KEYBOARD_wW                            = cast(ushort) 0x001a,
    HID_USAGE_KEYBOARD_xX                            = cast(ushort) 0x001b,
    HID_USAGE_KEYBOARD_yY                            = cast(ushort) 0x001c,
    HID_USAGE_KEYBOARD_zZ                            = cast(ushort) 0x001d,
    HID_USAGE_KEYBOARD_ONE                           = cast(ushort) 0x001e,
    HID_USAGE_KEYBOARD_TWO_AND_AT                    = cast(ushort) 0x001f,
    HID_USAGE_KEYBOARD_THREE_AND_HASH                = cast(ushort) 0x0020,
    HID_USAGE_KEYBOARD_FOUR_AND_DOLLAR               = cast(ushort) 0x0021,
    HID_USAGE_KEYBOARD_FIVE_AND_PERCENT              = cast(ushort) 0x0022,
    HID_USAGE_KEYBOARD_SIX_AND_CARET                 = cast(ushort) 0x0023,
    HID_USAGE_KEYBOARD_SEVEN_AND_AMPERSAND           = cast(ushort) 0x0024,
    HID_USAGE_KEYBOARD_EIGHT_AND_STAR                = cast(ushort) 0x0025,
    HID_USAGE_KEYBOARD_NINE_AND_LEFT_BRACKET         = cast(ushort) 0x0026,
    HID_USAGE_KEYBOARD_ZERO                          = cast(ushort) 0x0027,
    HID_USAGE_KEYBOARD_RETURN                        = cast(ushort) 0x0028,
    HID_USAGE_KEYBOARD_ESCAPE                        = cast(ushort) 0x0029,
    HID_USAGE_KEYBOARD_DELETE                        = cast(ushort) 0x002a,
    HID_USAGE_KEYBOARD_TAB                           = cast(ushort) 0x002b,
    HID_USAGE_KEYBOARD_SPACEBAR                      = cast(ushort) 0x002c,
    HID_USAGE_KEYBOARD_DASH_AND_UNDERSCORE           = cast(ushort) 0x002d,
    HID_USAGE_KEYBOARD_EQUALS_AND_PLUS               = cast(ushort) 0x002e,
    HID_USAGE_KEYBOARD_LEFT_BRACE                    = cast(ushort) 0x002f,
    HID_USAGE_KEYBOARD_RIGHT_BRACE                   = cast(ushort) 0x0030,
    HID_USAGE_KEYBOARD_BACKSLASH_AND_PIPE            = cast(ushort) 0x0031,
    HID_USAGE_KEYBOARD_NONUS_HASH_AND_TILDE          = cast(ushort) 0x0032,
    HID_USAGE_KEYBOARD_SEMICOLON_AND_COLON           = cast(ushort) 0x0033,
    HID_USAGE_KEYBOARD_LEFT_APOS_AND_DOUBLE          = cast(ushort) 0x0034,
    HID_USAGE_KEYBOARD_GRAVE_ACCENT_AND_TILDE        = cast(ushort) 0x0035,
    HID_USAGE_KEYBOARD_COMMA_AND_LESSTHAN            = cast(ushort) 0x0036,
    HID_USAGE_KEYBOARD_PERIOD_AND_GREATERTHAN        = cast(ushort) 0x0037,
    HID_USAGE_KEYBOARD_FORWARDSLASH_AND_QUESTIONMARK = cast(ushort) 0x0038,
}

enum : ushort
{
    HID_USAGE_KEYBOARD_CAPS_LOCK                  = cast(ushort) 0x0039,
    HID_USAGE_KEYBOARD_F1                         = cast(ushort) 0x003a,
    HID_USAGE_KEYBOARD_F2                         = cast(ushort) 0x003b,
    HID_USAGE_KEYBOARD_F3                         = cast(ushort) 0x003c,
    HID_USAGE_KEYBOARD_F4                         = cast(ushort) 0x003d,
    HID_USAGE_KEYBOARD_F5                         = cast(ushort) 0x003e,
    HID_USAGE_KEYBOARD_F6                         = cast(ushort) 0x003f,
    HID_USAGE_KEYBOARD_F7                         = cast(ushort) 0x0040,
    HID_USAGE_KEYBOARD_F8                         = cast(ushort) 0x0041,
    HID_USAGE_KEYBOARD_F9                         = cast(ushort) 0x0042,
    HID_USAGE_KEYBOARD_F10                        = cast(ushort) 0x0043,
    HID_USAGE_KEYBOARD_F11                        = cast(ushort) 0x0044,
    HID_USAGE_KEYBOARD_F12                        = cast(ushort) 0x0045,
    HID_USAGE_KEYBOARD_PRINT_SCREEN               = cast(ushort) 0x0046,
    HID_USAGE_KEYBOARD_SCROLL_LOCK                = cast(ushort) 0x0047,
    HID_USAGE_KEYBOARD_PAUSE                      = cast(ushort) 0x0048,
    HID_USAGE_KEYBOARD_INSERT                     = cast(ushort) 0x0049,
    HID_USAGE_KEYBOARD_HOME                       = cast(ushort) 0x004a,
    HID_USAGE_KEYBOARD_PAGEUP                     = cast(ushort) 0x004b,
    HID_USAGE_KEYBOARD_DELETE_FORWARD             = cast(ushort) 0x004c,
    HID_USAGE_KEYBOARD_END                        = cast(ushort) 0x004d,
    HID_USAGE_KEYBOARD_PAGEDOWN                   = cast(ushort) 0x004e,
    HID_USAGE_KEYBOARD_RIGHTARROW                 = cast(ushort) 0x004f,
    HID_USAGE_KEYBOARD_LEFTARROW                  = cast(ushort) 0x0050,
    HID_USAGE_KEYBOARD_DOWNARROW                  = cast(ushort) 0x0051,
    HID_USAGE_KEYBOARD_UPARROW                    = cast(ushort) 0x0052,
    HID_USAGE_KEYBOARD_NUM_LOCK                   = cast(ushort) 0x0053,
    HID_USAGE_KEYBOARD_KEYPAD_FORWARDSLASH        = cast(ushort) 0x0054,
    HID_USAGE_KEYBOARD_KEYPAD_STAR                = cast(ushort) 0x0055,
    HID_USAGE_KEYBOARD_DASH                       = cast(ushort) 0x0056,
    HID_USAGE_KEYBOARD_KEYPAD_PLUS                = cast(ushort) 0x0057,
    HID_USAGE_KEYBOARD_KEYPAD_ENTER               = cast(ushort) 0x0058,
    HID_USAGE_KEYBOARD_KEYPAD_ONE_AND_END         = cast(ushort) 0x0059,
    HID_USAGE_KEYBOARD_KEYPAD_TWO_AND_DOWN_ARROW  = cast(ushort) 0x005a,
    HID_USAGE_KEYBOARD_KEYPAD_THREE_AND_PAGEDN    = cast(ushort) 0x005b,
    HID_USAGE_KEYBOARD_KEYPAD_FOUR_AND_LEFT_ARROW = cast(ushort) 0x005c,
    HID_USAGE_KEYBOARD_KEYPAD_FIVE                = cast(ushort) 0x005d,
    HID_USAGE_KEYBOARD_KEYPAD_SIX_AND_RIGHT_ARROW = cast(ushort) 0x005e,
    HID_USAGE_KEYBOARD_KEYPAD_SEVEN_AND_HOME      = cast(ushort) 0x005f,
    HID_USAGE_KEYBOARD_KEYPAD_EIGHT_AND_UP_ARROW  = cast(ushort) 0x0060,
    HID_USAGE_KEYBOARD_KEYPAD_NINE_AND_PAGEUP     = cast(ushort) 0x0061,
    HID_USAGE_KEYBOARD_KEYPAD_ZERO_AND_INSERT     = cast(ushort) 0x0062,
    HID_USAGE_KEYBOARD_KEYPAD_PERIOD_AND_DELETE   = cast(ushort) 0x0063,
    HID_USAGE_KEYBOARD_NONUS_BACKSLASH_AND_PIPE   = cast(ushort) 0x0064,
    HID_USAGE_KEYBOARD_APPLICATION                = cast(ushort) 0x0065,
    HID_USAGE_KEYBOARD_POWER                      = cast(ushort) 0x0066,
    HID_USAGE_KEYBOARD_KEYPAD_EQUALS              = cast(ushort) 0x0067,
    HID_USAGE_KEYBOARD_F13                        = cast(ushort) 0x0068,
    HID_USAGE_KEYBOARD_F14                        = cast(ushort) 0x0069,
    HID_USAGE_KEYBOARD_F15                        = cast(ushort) 0x006a,
    HID_USAGE_KEYBOARD_F16                        = cast(ushort) 0x006b,
    HID_USAGE_KEYBOARD_F17                        = cast(ushort) 0x006c,
    HID_USAGE_KEYBOARD_F18                        = cast(ushort) 0x006d,
    HID_USAGE_KEYBOARD_F19                        = cast(ushort) 0x006e,
    HID_USAGE_KEYBOARD_F20                        = cast(ushort) 0x006f,
    HID_USAGE_KEYBOARD_F21                        = cast(ushort) 0x0070,
    HID_USAGE_KEYBOARD_F22                        = cast(ushort) 0x0071,
    HID_USAGE_KEYBOARD_F23                        = cast(ushort) 0x0072,
    HID_USAGE_KEYBOARD_F24                        = cast(ushort) 0x0073,
    HID_USAGE_KEYBOARD_EXECUTE                    = cast(ushort) 0x0074,
    HID_USAGE_KEYBOARD_HELP                       = cast(ushort) 0x0075,
    HID_USAGE_KEYBOARD_MENU                       = cast(ushort) 0x0076,
    HID_USAGE_KEYBOARD_SELECT                     = cast(ushort) 0x0077,
    HID_USAGE_KEYBOARD_STOP                       = cast(ushort) 0x0078,
    HID_USAGE_KEYBOARD_AGAIN                      = cast(ushort) 0x0079,
    HID_USAGE_KEYBOARD_UNDO                       = cast(ushort) 0x007a,
    HID_USAGE_KEYBOARD_CUT                        = cast(ushort) 0x007b,
    HID_USAGE_KEYBOARD_COPY                       = cast(ushort) 0x007c,
    HID_USAGE_KEYBOARD_PASTE                      = cast(ushort) 0x007d,
    HID_USAGE_KEYBOARD_FIND                       = cast(ushort) 0x007e,
    HID_USAGE_KEYBOARD_MUTE                       = cast(ushort) 0x007f,
    HID_USAGE_KEYBOARD_VOLUME_UP                  = cast(ushort) 0x0080,
    HID_USAGE_KEYBOARD_VOLUME_DOWN                = cast(ushort) 0x0081,
    HID_USAGE_KEYBOARD_LOCKING_CAPS_LOCK          = cast(ushort) 0x0082,
    HID_USAGE_KEYBOARD_LOCKING_NUM_LOCK           = cast(ushort) 0x0083,
    HID_USAGE_KEYBOARD_LOCKING_SCROLL_LOCK        = cast(ushort) 0x0084,
    HID_USAGE_KEYBOARD_KEYPAD_COMMA               = cast(ushort) 0x0085,
    HID_USAGE_KEYBOARD_KEYPAD_EQUAL_SIGN          = cast(ushort) 0x0086,
    HID_USAGE_KEYBOARD_INTERNATIONAL1             = cast(ushort) 0x0087,
    HID_USAGE_KEYBOARD_INTERNATIONAL2             = cast(ushort) 0x0088,
    HID_USAGE_KEYBOARD_INTERNATIONAL3             = cast(ushort) 0x0089,
    HID_USAGE_KEYBOARD_INTERNATIONAL4             = cast(ushort) 0x008a,
    HID_USAGE_KEYBOARD_INTERNATIONAL5             = cast(ushort) 0x008b,
    HID_USAGE_KEYBOARD_INTERNATIONAL6             = cast(ushort) 0x008c,
    HID_USAGE_KEYBOARD_INTERNATIONAL7             = cast(ushort) 0x008d,
    HID_USAGE_KEYBOARD_INTERNATIONAL8             = cast(ushort) 0x008e,
    HID_USAGE_KEYBOARD_INTERNATIONAL9             = cast(ushort) 0x008f,
    HID_USAGE_KEYBOARD_LANG1                      = cast(ushort) 0x0090,
    HID_USAGE_KEYBOARD_LANG2                      = cast(ushort) 0x0091,
    HID_USAGE_KEYBOARD_LANG3                      = cast(ushort) 0x0092,
    HID_USAGE_KEYBOARD_LANG4                      = cast(ushort) 0x0093,
    HID_USAGE_KEYBOARD_LANG5                      = cast(ushort) 0x0094,
    HID_USAGE_KEYBOARD_LANG6                      = cast(ushort) 0x0095,
    HID_USAGE_KEYBOARD_LANG7                      = cast(ushort) 0x0096,
    HID_USAGE_KEYBOARD_LANG8                      = cast(ushort) 0x0097,
    HID_USAGE_KEYBOARD_LANG9                      = cast(ushort) 0x0098,
    HID_USAGE_KEYBOARD_ALTERNATE_ERASE            = cast(ushort) 0x0099,
    HID_USAGE_KEYBOARD_SYSREQ_ATTENTION           = cast(ushort) 0x009a,
    HID_USAGE_KEYBOARD_CANCEL                     = cast(ushort) 0x009b,
    HID_USAGE_KEYBOARD_CLEAR                      = cast(ushort) 0x009c,
    HID_USAGE_KEYBOARD_PRIOR                      = cast(ushort) 0x009d,
    HID_USAGE_KEYBOARD_RETURN_NO_ENTER            = cast(ushort) 0x009e,
    HID_USAGE_KEYBOARD_SEPARATOR                  = cast(ushort) 0x009f,
    HID_USAGE_KEYBOARD_OUT                        = cast(ushort) 0x00a0,
    HID_USAGE_KEYBOARD_OPER                       = cast(ushort) 0x00a1,
    HID_USAGE_KEYBOARD_CLEAR_AGAIN                = cast(ushort) 0x00a2,
    HID_USAGE_KEYBOARD_CRSEL_PROPS                = cast(ushort) 0x00a3,
    HID_USAGE_KEYBOARD_EXSEL                      = cast(ushort) 0x00a4,
    HID_USAGE_KEYBOARD_KEYPAD_DOUBLE_0            = cast(ushort) 0x00b0,
    HID_USAGE_KEYBOARD_KEYPAD_TRIPLE_0            = cast(ushort) 0x00b1,
    HID_USAGE_KEYBOARD_THOUSANDS_SEPARATOR        = cast(ushort) 0x00b2,
    HID_USAGE_KEYBOARD_DECIMAL_SEPARATOR          = cast(ushort) 0x00b3,
    HID_USAGE_KEYBOARD_CURRENCY_UNIT              = cast(ushort) 0x00b4,
    HID_USAGE_KEYBOARD_CURRENCY_SUBUNIT           = cast(ushort) 0x00b5,
    HID_USAGE_KEYBOARD_KEYPAD_LEFT_BRACKET        = cast(ushort) 0x00b6,
    HID_USAGE_KEYBOARD_KEYPAD_RIGHT_BRACKET       = cast(ushort) 0x00b7,
    HID_USAGE_KEYBOARD_KEYPAD_LEFT_BRACE          = cast(ushort) 0x00b8,
    HID_USAGE_KEYBOARD_KEYPAD_RIGHT_BRACE         = cast(ushort) 0x00b9,
    HID_USAGE_KEYBOARD_KEYPAD_TAB                 = cast(ushort) 0x00ba,
    HID_USAGE_KEYBOARD_KEYPAD_BACKSPACE           = cast(ushort) 0x00bb,
    HID_USAGE_KEYBOARD_KEYPAD_A                   = cast(ushort) 0x00bc,
    HID_USAGE_KEYBOARD_KEYPAD_B                   = cast(ushort) 0x00bd,
    HID_USAGE_KEYBOARD_KEYPAD_C                   = cast(ushort) 0x00be,
    HID_USAGE_KEYBOARD_KEYPAD_D                   = cast(ushort) 0x00bf,
    HID_USAGE_KEYBOARD_KEYPAD_E                   = cast(ushort) 0x00c0,
    HID_USAGE_KEYBOARD_KEYPAD_F                   = cast(ushort) 0x00c1,
    HID_USAGE_KEYBOARD_KEYPAD_XOR                 = cast(ushort) 0x00c2,
    HID_USAGE_KEYBOARD_KEYPAD_CARET               = cast(ushort) 0x00c3,
    HID_USAGE_KEYBOARD_KEYPAD_PERCENTAGE          = cast(ushort) 0x00c4,
    HID_USAGE_KEYBOARD_KEYPAD_LESS                = cast(ushort) 0x00c5,
    HID_USAGE_KEYBOARD_KEYPAD_GREATER             = cast(ushort) 0x00c6,
    HID_USAGE_KEYBOARD_KEYPAD_AMPERSAND           = cast(ushort) 0x00c7,
    HID_USAGE_KEYBOARD_KEYPAD_DOUBLE_AMPERSAND    = cast(ushort) 0x00c8,
    HID_USAGE_KEYBOARD_KEYPAD_BAR                 = cast(ushort) 0x00c9,
    HID_USAGE_KEYBOARD_KEYPAD_DOUBLE_BAR          = cast(ushort) 0x00ca,
    HID_USAGE_KEYBOARD_KEYPAD_COLON               = cast(ushort) 0x00cb,
    HID_USAGE_KEYBOARD_KEYPAD_HASH                = cast(ushort) 0x00cc,
    HID_USAGE_KEYBOARD_KEYPAD_SPACE               = cast(ushort) 0x00cd,
    HID_USAGE_KEYBOARD_KEYPAD_AT                  = cast(ushort) 0x00ce,
    HID_USAGE_KEYBOARD_KEYPAD_BANG                = cast(ushort) 0x00cf,
    HID_USAGE_KEYBOARD_KEYPAD_MEMORY_STORE        = cast(ushort) 0x00d0,
    HID_USAGE_KEYBOARD_KEYPAD_MEMORY_RECALL       = cast(ushort) 0x00d1,
    HID_USAGE_KEYBOARD_KEYPAD_MEMORY_CLEAR        = cast(ushort) 0x00d2,
    HID_USAGE_KEYBOARD_KEYPAD_MEMORY_ADD          = cast(ushort) 0x00d3,
    HID_USAGE_KEYBOARD_KEYPAD_MEMORY_SUBTRACT     = cast(ushort) 0x00d4,
    HID_USAGE_KEYBOARD_KEYPAD_MEMORY_MULTIPLY     = cast(ushort) 0x00d5,
    HID_USAGE_KEYBOARD_KEYPAD_MEMORY_DIVIDE       = cast(ushort) 0x00d6,
    HID_USAGE_KEYBOARD_KEYPAD_PLUS_MINUS          = cast(ushort) 0x00d7,
    HID_USAGE_KEYBOARD_KEYPAD_CLEAR               = cast(ushort) 0x00d8,
    HID_USAGE_KEYBOARD_KEYPAD_CLEAR_ENTRY         = cast(ushort) 0x00d9,
    HID_USAGE_KEYBOARD_KEYPAD_BINARY              = cast(ushort) 0x00da,
    HID_USAGE_KEYBOARD_KEYPAD_OCTAL               = cast(ushort) 0x00db,
    HID_USAGE_KEYBOARD_KEYPAD_DECIMAL             = cast(ushort) 0x00dc,
    HID_USAGE_KEYBOARD_KEYPAD_HEXADECIMAL         = cast(ushort) 0x00dd,
    HID_USAGE_KEYBOARD_LCTRL                      = cast(ushort) 0x00e0,
    HID_USAGE_KEYBOARD_LSHFT                      = cast(ushort) 0x00e1,
    HID_USAGE_KEYBOARD_LALT                       = cast(ushort) 0x00e2,
    HID_USAGE_KEYBOARD_LGUI                       = cast(ushort) 0x00e3,
    HID_USAGE_KEYBOARD_RCTRL                      = cast(ushort) 0x00e4,
    HID_USAGE_KEYBOARD_RSHFT                      = cast(ushort) 0x00e5,
    HID_USAGE_KEYBOARD_RALT                       = cast(ushort) 0x00e6,
    HID_USAGE_KEYBOARD_RGUI                       = cast(ushort) 0x00e7,
    HID_USAGE_LED_NUM_LOCK                        = cast(ushort) 0x0001,
    HID_USAGE_LED_CAPS_LOCK                       = cast(ushort) 0x0002,
    HID_USAGE_LED_SCROLL_LOCK                     = cast(ushort) 0x0003,
    HID_USAGE_LED_COMPOSE                         = cast(ushort) 0x0004,
    HID_USAGE_LED_KANA                            = cast(ushort) 0x0005,
    HID_USAGE_LED_POWER                           = cast(ushort) 0x0006,
    HID_USAGE_LED_SHIFT                           = cast(ushort) 0x0007,
    HID_USAGE_LED_DO_NOT_DISTURB                  = cast(ushort) 0x0008,
    HID_USAGE_LED_MUTE                            = cast(ushort) 0x0009,
    HID_USAGE_LED_TONE_ENABLE                     = cast(ushort) 0x000a,
    HID_USAGE_LED_HIGH_CUT_FILTER                 = cast(ushort) 0x000b,
    HID_USAGE_LED_LOW_CUT_FILTER                  = cast(ushort) 0x000c,
    HID_USAGE_LED_EQUALIZER_ENABLE                = cast(ushort) 0x000d,
    HID_USAGE_LED_SOUND_FIELD_ON                  = cast(ushort) 0x000e,
    HID_USAGE_LED_SURROUND_FIELD_ON               = cast(ushort) 0x000f,
    HID_USAGE_LED_REPEAT                          = cast(ushort) 0x0010,
    HID_USAGE_LED_STEREO                          = cast(ushort) 0x0011,
    HID_USAGE_LED_SAMPLING_RATE_DETECT            = cast(ushort) 0x0012,
    HID_USAGE_LED_SPINNING                        = cast(ushort) 0x0013,
    HID_USAGE_LED_CAV                             = cast(ushort) 0x0014,
    HID_USAGE_LED_CLV                             = cast(ushort) 0x0015,
    HID_USAGE_LED_RECORDING_FORMAT_DET            = cast(ushort) 0x0016,
    HID_USAGE_LED_OFF_HOOK                        = cast(ushort) 0x0017,
    HID_USAGE_LED_RING                            = cast(ushort) 0x0018,
    HID_USAGE_LED_MESSAGE_WAITING                 = cast(ushort) 0x0019,
    HID_USAGE_LED_DATA_MODE                       = cast(ushort) 0x001a,
    HID_USAGE_LED_BATTERY_OPERATION               = cast(ushort) 0x001b,
    HID_USAGE_LED_BATTERY_OK                      = cast(ushort) 0x001c,
    HID_USAGE_LED_BATTERY_LOW                     = cast(ushort) 0x001d,
    HID_USAGE_LED_SPEAKER                         = cast(ushort) 0x001e,
    HID_USAGE_LED_HEAD_SET                        = cast(ushort) 0x001f,
    HID_USAGE_LED_HOLD                            = cast(ushort) 0x0020,
    HID_USAGE_LED_MICROPHONE                      = cast(ushort) 0x0021,
    HID_USAGE_LED_COVERAGE                        = cast(ushort) 0x0022,
    HID_USAGE_LED_NIGHT_MODE                      = cast(ushort) 0x0023,
    HID_USAGE_LED_SEND_CALLS                      = cast(ushort) 0x0024,
    HID_USAGE_LED_CALL_PICKUP                     = cast(ushort) 0x0025,
    HID_USAGE_LED_CONFERENCE                      = cast(ushort) 0x0026,
    HID_USAGE_LED_STAND_BY                        = cast(ushort) 0x0027,
    HID_USAGE_LED_CAMERA_ON                       = cast(ushort) 0x0028,
    HID_USAGE_LED_CAMERA_OFF                      = cast(ushort) 0x0029,
    HID_USAGE_LED_ON_LINE                         = cast(ushort) 0x002a,
    HID_USAGE_LED_OFF_LINE                        = cast(ushort) 0x002b,
    HID_USAGE_LED_BUSY                            = cast(ushort) 0x002c,
    HID_USAGE_LED_READY                           = cast(ushort) 0x002d,
    HID_USAGE_LED_PAPER_OUT                       = cast(ushort) 0x002e,
    HID_USAGE_LED_PAPER_JAM                       = cast(ushort) 0x002f,
    HID_USAGE_LED_REMOTE                          = cast(ushort) 0x0030,
    HID_USAGE_LED_FORWARD                         = cast(ushort) 0x0031,
    HID_USAGE_LED_REVERSE                         = cast(ushort) 0x0032,
    HID_USAGE_LED_STOP                            = cast(ushort) 0x0033,
    HID_USAGE_LED_REWIND                          = cast(ushort) 0x0034,
    HID_USAGE_LED_FAST_FORWARD                    = cast(ushort) 0x0035,
    HID_USAGE_LED_PLAY                            = cast(ushort) 0x0036,
    HID_USAGE_LED_PAUSE                           = cast(ushort) 0x0037,
    HID_USAGE_LED_RECORD                          = cast(ushort) 0x0038,
    HID_USAGE_LED_ERROR                           = cast(ushort) 0x0039,
    HID_USAGE_LED_SELECTED_INDICATOR              = cast(ushort) 0x003a,
    HID_USAGE_LED_IN_USE_INDICATOR                = cast(ushort) 0x003b,
    HID_USAGE_LED_MULTI_MODE_INDICATOR            = cast(ushort) 0x003c,
    HID_USAGE_LED_INDICATOR_ON                    = cast(ushort) 0x003d,
    HID_USAGE_LED_INDICATOR_FLASH                 = cast(ushort) 0x003e,
    HID_USAGE_LED_INDICATOR_SLOW_BLINK            = cast(ushort) 0x003f,
    HID_USAGE_LED_INDICATOR_FAST_BLINK            = cast(ushort) 0x0040,
    HID_USAGE_LED_INDICATOR_OFF                   = cast(ushort) 0x0041,
    HID_USAGE_LED_FLASH_ON_TIME                   = cast(ushort) 0x0042,
    HID_USAGE_LED_SLOW_BLINK_ON_TIME              = cast(ushort) 0x0043,
    HID_USAGE_LED_SLOW_BLINK_OFF_TIME             = cast(ushort) 0x0044,
    HID_USAGE_LED_FAST_BLINK_ON_TIME              = cast(ushort) 0x0045,
    HID_USAGE_LED_FAST_BLINK_OFF_TIME             = cast(ushort) 0x0046,
    HID_USAGE_LED_INDICATOR_COLOR                 = cast(ushort) 0x0047,
    HID_USAGE_LED_RED                             = cast(ushort) 0x0048,
    HID_USAGE_LED_GREEN                           = cast(ushort) 0x0049,
    HID_USAGE_LED_AMBER                           = cast(ushort) 0x004a,
    HID_USAGE_LED_GENERIC_INDICATOR               = cast(ushort) 0x004b,
    HID_USAGE_LED_SYSTEM_SUSPEND                  = cast(ushort) 0x004c,
    HID_USAGE_LED_EXTERNAL_POWER                  = cast(ushort) 0x004d,
    HID_USAGE_LED_INDICATOR_BLUE                  = cast(ushort) 0x004e,
    HID_USAGE_LED_INDICATOR_ORANGE                = cast(ushort) 0x004f,
    HID_USAGE_LED_GOOD_STATUS                     = cast(ushort) 0x0050,
    HID_USAGE_LED_WARNING_STATUS                  = cast(ushort) 0x0051,
    HID_USAGE_LED_RGB_LED                         = cast(ushort) 0x0052,
    HID_USAGE_LED_RED_LED_CHANNEL                 = cast(ushort) 0x0053,
    HID_USAGE_LED_BLUE_LED_CHANNEL                = cast(ushort) 0x0054,
    HID_USAGE_LED_GREEN_LED_CHANNEL               = cast(ushort) 0x0055,
    HID_USAGE_LED_LED_INTENSITY                   = cast(ushort) 0x0056,
    HID_USAGE_LED_SYSTEM_MICROPHONE_MUTE          = cast(ushort) 0x0057,
}

enum : ushort
{
    HID_USAGE_LED_PLAYER_INDICATOR                         = cast(ushort) 0x0060,
    HID_USAGE_LED_PLAYER_1                                 = cast(ushort) 0x0061,
    HID_USAGE_LED_PLAYER_2                                 = cast(ushort) 0x0062,
    HID_USAGE_LED_PLAYER_3                                 = cast(ushort) 0x0063,
    HID_USAGE_LED_PLAYER_4                                 = cast(ushort) 0x0064,
    HID_USAGE_LED_PLAYER_5                                 = cast(ushort) 0x0065,
    HID_USAGE_LED_PLAYER_6                                 = cast(ushort) 0x0066,
    HID_USAGE_LED_PLAYER_7                                 = cast(ushort) 0x0067,
    HID_USAGE_LED_PLAYER_8                                 = cast(ushort) 0x0068,
    HID_USAGE_LAMPARRAY                                    = cast(ushort) 0x0001,
    HID_USAGE_LAMPARRAY_ATTRBIUTES_REPORT                  = cast(ushort) 0x0002,
    HID_USAGE_LAMPARRAY_LAMP_COUNT                         = cast(ushort) 0x0003,
    HID_USAGE_LAMPARRAY_BOUNDING_BOX_WIDTH_IN_MICROMETERS  = cast(ushort) 0x0004,
    HID_USAGE_LAMPARRAY_BOUNDING_BOX_HEIGHT_IN_MICROMETERS = cast(ushort) 0x0005,
    HID_USAGE_LAMPARRAY_BOUNDING_BOX_DEPTH_IN_MICROMETERS  = cast(ushort) 0x0006,
}

enum : ushort
{
    HID_USAGE_LAMPARRAY_KIND                                = cast(ushort) 0x0007,
    HID_USAGE_LAMPARRAY_MIN_UPDATE_INTERVAL_IN_MICROSECONDS = cast(ushort) 0x0008,
}

enum : ushort
{
    HID_USAGE_LAMPARRAY_LAMP_ATTRIBUTES_REQUEST_REPORT  = cast(ushort) 0x0020,
    HID_USAGE_LAMPARRAY_LAMP_ID                         = cast(ushort) 0x0021,
    HID_USAGE_LAMPARRAY_LAMP_ATTRIBUTES_RESPONSE_REPORT = cast(ushort) 0x0022,
}

enum : ushort
{
    HID_USAGE_LAMPARRAY_POSITION_X_IN_MICROMETERS      = cast(ushort) 0x0023,
    HID_USAGE_LAMPARRAY_POSITION_Y_IN_MICROMETERS      = cast(ushort) 0x0024,
    HID_USAGE_LAMPARRAY_POSITION_Z_IN_MICROMETERS      = cast(ushort) 0x0025,
    HID_USAGE_LAMPARRAY_LAMP_PURPOSES                  = cast(ushort) 0x0026,
    HID_USAGE_LAMPARRAY_UPDATE_LATENCY_IN_MICROSECONDS = cast(ushort) 0x0027,
}

enum : ushort
{
    HID_USAGE_LAMPARRAY_RED_LEVEL_COUNT               = cast(ushort) 0x0028,
    HID_USAGE_LAMPARRAY_GREEN_LEVEL_COUNT             = cast(ushort) 0x0029,
    HID_USAGE_LAMPARRAY_BLUE_LEVEL_COUNT              = cast(ushort) 0x002a,
    HID_USAGE_LAMPARRAY_INTENSITY_LEVEL_COUNT         = cast(ushort) 0x002b,
    HID_USAGE_LAMPARRAY_IS_PROGRAMMABLE               = cast(ushort) 0x002c,
    HID_USAGE_LAMPARRAY_INPUT_BINDING                 = cast(ushort) 0x002d,
    HID_USAGE_LAMPARRAY_LAMP_MULTI_UPDATE_REPORT      = cast(ushort) 0x0050,
    HID_USAGE_LAMPARRAY_LAMP_RED_UPDATE_CHANNEL       = cast(ushort) 0x0051,
    HID_USAGE_LAMPARRAY_LAMP_GREEN_UPDATE_CHANNEL     = cast(ushort) 0x0052,
    HID_USAGE_LAMPARRAY_LAMP_BLUE_UPDATE_CHANNEL      = cast(ushort) 0x0053,
    HID_USAGE_LAMPARRAY_LAMP_INTENSITY_UPDATE_CHANNEL = cast(ushort) 0x0054,
    HID_USAGE_LAMPARRAY_LAMP_UPDATE_FLAGS             = cast(ushort) 0x0055,
    HID_USAGE_LAMPARRAY_LAMP_RANGE_UPDATE_REPORT      = cast(ushort) 0x0060,
    HID_USAGE_LAMPARRAY_LAMP_ID_START                 = cast(ushort) 0x0061,
    HID_USAGE_LAMPARRAY_LAMP_ID_END                   = cast(ushort) 0x0062,
    HID_USAGE_LAMPARRAY_CONTROL_REPORT                = cast(ushort) 0x0070,
    HID_USAGE_LAMPARRAY_AUTONOMOUS_MODE               = cast(ushort) 0x0071,
}

enum : ushort
{
    HID_USAGE_MAGNETIC_STRIPE_READER_MSR_DEVICE_READONLY = cast(ushort) 0x0001,
    HID_USAGE_MAGNETIC_STRIPE_READER_TRACK_1_LENGTH      = cast(ushort) 0x0011,
    HID_USAGE_MAGNETIC_STRIPE_READER_TRACK_2_LENGTH      = cast(ushort) 0x0012,
    HID_USAGE_MAGNETIC_STRIPE_READER_TRACK_3_LENGTH      = cast(ushort) 0x0013,
    HID_USAGE_MAGNETIC_STRIPE_READER_TRACK_JIS_LENGTH    = cast(ushort) 0x0014,
    HID_USAGE_MAGNETIC_STRIPE_READER_TRACK_DATA          = cast(ushort) 0x0020,
    HID_USAGE_MAGNETIC_STRIPE_READER_TRACK_1_DATA        = cast(ushort) 0x0021,
    HID_USAGE_MAGNETIC_STRIPE_READER_TRACK_2_DATA        = cast(ushort) 0x0022,
    HID_USAGE_MAGNETIC_STRIPE_READER_TRACK_3_DATA        = cast(ushort) 0x0023,
    HID_USAGE_MAGNETIC_STRIPE_READER_TRACK_JIS_DATA      = cast(ushort) 0x0024,
}

enum : ushort
{
    HID_USAGE_MEDICAL_INSTRUMENT_MEDICAL_ULTRASOUND           = cast(ushort) 0x0001,
    HID_USAGE_MEDICAL_INSTRUMENT_VCRACQUISITION               = cast(ushort) 0x0020,
    HID_USAGE_MEDICAL_INSTRUMENT_FREEZETHAW                   = cast(ushort) 0x0021,
    HID_USAGE_MEDICAL_INSTRUMENT_CLIP_STORE                   = cast(ushort) 0x0022,
    HID_USAGE_MEDICAL_INSTRUMENT_UPDATE                       = cast(ushort) 0x0023,
    HID_USAGE_MEDICAL_INSTRUMENT_NEXT                         = cast(ushort) 0x0024,
    HID_USAGE_MEDICAL_INSTRUMENT_SAVE                         = cast(ushort) 0x0025,
    HID_USAGE_MEDICAL_INSTRUMENT_PRINT                        = cast(ushort) 0x0026,
    HID_USAGE_MEDICAL_INSTRUMENT_MICROPHONE_ENABLE            = cast(ushort) 0x0027,
    HID_USAGE_MEDICAL_INSTRUMENT_CINE                         = cast(ushort) 0x0040,
    HID_USAGE_MEDICAL_INSTRUMENT_TRANSMIT_POWER               = cast(ushort) 0x0041,
    HID_USAGE_MEDICAL_INSTRUMENT_VOLUME                       = cast(ushort) 0x0042,
    HID_USAGE_MEDICAL_INSTRUMENT_FOCUS                        = cast(ushort) 0x0043,
    HID_USAGE_MEDICAL_INSTRUMENT_DEPTH                        = cast(ushort) 0x0044,
    HID_USAGE_MEDICAL_INSTRUMENT_SOFT_STEP__PRIMARY           = cast(ushort) 0x0060,
    HID_USAGE_MEDICAL_INSTRUMENT_SOFT_STEP__SECONDARY         = cast(ushort) 0x0061,
    HID_USAGE_MEDICAL_INSTRUMENT_DEPTH_GAIN_COMPENSATION      = cast(ushort) 0x0070,
    HID_USAGE_MEDICAL_INSTRUMENT_ZOOM_SELECT                  = cast(ushort) 0x0080,
    HID_USAGE_MEDICAL_INSTRUMENT_ZOOM_ADJUST                  = cast(ushort) 0x0081,
    HID_USAGE_MEDICAL_INSTRUMENT_SPECTRAL_DOPPLER_MODE_SELECT = cast(ushort) 0x0082,
    HID_USAGE_MEDICAL_INSTRUMENT_SPECTRAL_DOPPLER_ADJUST      = cast(ushort) 0x0083,
    HID_USAGE_MEDICAL_INSTRUMENT_COLOR_DOPPLER_MODE_SELECT    = cast(ushort) 0x0084,
    HID_USAGE_MEDICAL_INSTRUMENT_COLOR_DOPPLER_ADJUST         = cast(ushort) 0x0085,
    HID_USAGE_MEDICAL_INSTRUMENT_MOTION_MODE_SELECT           = cast(ushort) 0x0086,
    HID_USAGE_MEDICAL_INSTRUMENT_MOTION_MODE_ADJUST           = cast(ushort) 0x0087,
    HID_USAGE_MEDICAL_INSTRUMENT_2D_MODE_SELECT               = cast(ushort) 0x0088,
    HID_USAGE_MEDICAL_INSTRUMENT_2D_MODE_ADJUST               = cast(ushort) 0x0089,
    HID_USAGE_MEDICAL_INSTRUMENT_SOFT_CONTROL_SELECT          = cast(ushort) 0x00a0,
    HID_USAGE_MEDICAL_INSTRUMENT_SOFT_CONTROL_ADJUST          = cast(ushort) 0x00a1,
}

enum : ushort
{
    HID_USAGE_MICROSOFT_BLUETOOTH_HANDSFREE_GENERAL     = cast(ushort) 0x0001,
    HID_USAGE_MICROSOFT_BLUETOOTH_HANDSFREE_DIAL_NUMBER = cast(ushort) 0x0021,
    HID_USAGE_MICROSOFT_BLUETOOTH_HANDSFREE_DIAL_MEMORY = cast(ushort) 0x0022,
    HID_USAGE_MICROSOFT_BLUETOOTH_HANDSFREE_CALL_SETUP  = cast(ushort) 0x0024,
}

enum : ushort
{
    HID_USAGE_MONITOR_MONITOR_CONTROL  = cast(ushort) 0x0001,
    HID_USAGE_MONITOR_EDID_INFORMATION = cast(ushort) 0x0002,
    HID_USAGE_MONITOR_VDIF_INFORMATION = cast(ushort) 0x0003,
    HID_USAGE_MONITOR_VESA_VERSION     = cast(ushort) 0x0004,
}

enum ushort HID_USAGE_PID_PHYSICAL_INPUT_DEVICE = cast(ushort) 0x0001;

enum : ushort
{
    HID_USAGE_PID_NORMAL                 = cast(ushort) 0x0020,
    HID_USAGE_PID_SET_EFFECT_REPORT      = cast(ushort) 0x0021,
    HID_USAGE_PID_EFFECT_BLOCK_INDEX     = cast(ushort) 0x0022,
    HID_USAGE_PID_PARAMETER_BLOCK_OFFSET = cast(ushort) 0x0023,
}

enum : ushort
{
    HID_USAGE_PID_ROM_FLAG                = cast(ushort) 0x0024,
    HID_USAGE_PID_EFFECT_TYPE             = cast(ushort) 0x0025,
    HID_USAGE_PID_ET_CONSTANT             = cast(ushort) 0x0026,
    HID_USAGE_PID_ET_RAMP                 = cast(ushort) 0x0027,
    HID_USAGE_PID_ET_CUSTOM               = cast(ushort) 0x0028,
    HID_USAGE_PID_ET_SQUARE               = cast(ushort) 0x0030,
    HID_USAGE_PID_ET_SINE                 = cast(ushort) 0x0031,
    HID_USAGE_PID_ET_TRIANGLE             = cast(ushort) 0x0032,
    HID_USAGE_PID_ET_SAWTOOTH_UP          = cast(ushort) 0x0033,
    HID_USAGE_PID_ET_SAWTOOTH_DOWN        = cast(ushort) 0x0034,
    HID_USAGE_PID_ET_SPRING               = cast(ushort) 0x0040,
    HID_USAGE_PID_ET_DAMPER               = cast(ushort) 0x0041,
    HID_USAGE_PID_ET_INERTIA              = cast(ushort) 0x0042,
    HID_USAGE_PID_ET_FRICTION             = cast(ushort) 0x0043,
    HID_USAGE_PID_DURATION                = cast(ushort) 0x0050,
    HID_USAGE_PID_SAMPLE_PERIOD           = cast(ushort) 0x0051,
    HID_USAGE_PID_GAIN                    = cast(ushort) 0x0052,
    HID_USAGE_PID_TRIGGER_BUTTON          = cast(ushort) 0x0053,
    HID_USAGE_PID_TRIGGER_REPEAT_INTERVAL = cast(ushort) 0x0054,
}

enum : ushort
{
    HID_USAGE_PID_AXES_ENABLE                = cast(ushort) 0x0055,
    HID_USAGE_PID_DIRECTION_ENABLE           = cast(ushort) 0x0056,
    HID_USAGE_PID_DIRECTION                  = cast(ushort) 0x0057,
    HID_USAGE_PID_TYPE_SPECIFIC_BLOCK_OFFSET = cast(ushort) 0x0058,
}

enum : ushort
{
    HID_USAGE_PID_BLOCK_TYPE            = cast(ushort) 0x0059,
    HID_USAGE_PID_SET_ENVELOPE_REPORT   = cast(ushort) 0x005a,
    HID_USAGE_PID_ATTACK_LEVEL          = cast(ushort) 0x005b,
    HID_USAGE_PID_ATTACK_TIME           = cast(ushort) 0x005c,
    HID_USAGE_PID_FADE_LEVEL            = cast(ushort) 0x005d,
    HID_USAGE_PID_FADE_TIME             = cast(ushort) 0x005e,
    HID_USAGE_PID_SET_CONDITION_REPORT  = cast(ushort) 0x005f,
    HID_USAGE_PID_CP_OFFSET             = cast(ushort) 0x0060,
    HID_USAGE_PID_POSITIVE_COEFFICIENT  = cast(ushort) 0x0061,
    HID_USAGE_PID_NEGATIVE_COEFFICIENT  = cast(ushort) 0x0062,
    HID_USAGE_PID_POSITIVE_SATURATION   = cast(ushort) 0x0063,
    HID_USAGE_PID_NEGATIVE_SATURATION   = cast(ushort) 0x0064,
    HID_USAGE_PID_DEAD_BAND             = cast(ushort) 0x0065,
    HID_USAGE_PID_DOWNLOAD_FORCE_SAMPLE = cast(ushort) 0x0066,
}

enum ushort HID_USAGE_PID_ISOCH_CUSTOMFORCE_ENABLE = cast(ushort) 0x0067;

enum : ushort
{
    HID_USAGE_PID_CUSTOM_FORCE_DATA_REPORT         = cast(ushort) 0x0068,
    HID_USAGE_PID_CUSTOM_FORCE_DATA                = cast(ushort) 0x0069,
    HID_USAGE_PID_CUSTOM_FORCE_VENDOR_DEFINED_DATA = cast(ushort) 0x006a,
}

enum ushort HID_USAGE_PID_SET_CUSTOM_FORCE_REPORT = cast(ushort) 0x006b;
enum ushort HID_USAGE_PID_CUSTOM_FORCE_DATA_OFFSET = cast(ushort) 0x006c;

enum : ushort
{
    HID_USAGE_PID_SAMPLE_COUNT              = cast(ushort) 0x006d,
    HID_USAGE_PID_SET_PERIODIC_REPORT       = cast(ushort) 0x006e,
    HID_USAGE_PID_OFFSET                    = cast(ushort) 0x006f,
    HID_USAGE_PID_MAGNITUDE                 = cast(ushort) 0x0070,
    HID_USAGE_PID_PHASE                     = cast(ushort) 0x0071,
    HID_USAGE_PID_PERIOD                    = cast(ushort) 0x0072,
    HID_USAGE_PID_SET_CONSTANT_FORCE_REPORT = cast(ushort) 0x0073,
    HID_USAGE_PID_SET_RAMP_FORCE_REPORT     = cast(ushort) 0x0074,
}

enum : ushort
{
    HID_USAGE_PID_RAMP_START              = cast(ushort) 0x0075,
    HID_USAGE_PID_RAMP_END                = cast(ushort) 0x0076,
    HID_USAGE_PID_EFFECT_OPERATION_REPORT = cast(ushort) 0x0077,
    HID_USAGE_PID_EFFECT_OPERATION        = cast(ushort) 0x0078,
    HID_USAGE_PID_OP_EFFECT_START         = cast(ushort) 0x0079,
    HID_USAGE_PID_OP_EFFECT_START_SOLO    = cast(ushort) 0x007a,
    HID_USAGE_PID_OP_EFFECT_STOP          = cast(ushort) 0x007b,
    HID_USAGE_PID_LOOP_COUNT              = cast(ushort) 0x007c,
    HID_USAGE_PID_DEVICE_GAIN_REPORT      = cast(ushort) 0x007d,
    HID_USAGE_PID_DEVICE_GAIN             = cast(ushort) 0x007e,
    HID_USAGE_PID_POOL_REPORT             = cast(ushort) 0x007f,
    HID_USAGE_PID_RAM_POOL_SIZE           = cast(ushort) 0x0080,
    HID_USAGE_PID_ROM_POOL_SIZE           = cast(ushort) 0x0081,
    HID_USAGE_PID_ROM_EFFECT_BLOCK_COUNT  = cast(ushort) 0x0082,
}

enum ushort HID_USAGE_PID_SIMULTANEOUS_EFFECTS_MAX = cast(ushort) 0x0083;

enum : ushort
{
    HID_USAGE_PID_POOL_ALIGNMENT              = cast(ushort) 0x0084,
    HID_USAGE_PID_PARAMETER_BLOCK_MOVE_REPORT = cast(ushort) 0x0085,
}

enum : ushort
{
    HID_USAGE_PID_MOVE_SOURCE                = cast(ushort) 0x0086,
    HID_USAGE_PID_MOVE_DESTINATION           = cast(ushort) 0x0087,
    HID_USAGE_PID_MOVE_LENGTH                = cast(ushort) 0x0088,
    HID_USAGE_PID_BLOCK_LOAD_REPORT          = cast(ushort) 0x0089,
    HID_USAGE_PID_BLOCK_LOAD_STATUS          = cast(ushort) 0x008b,
    HID_USAGE_PID_BLOCK_LOAD_SUCCESS         = cast(ushort) 0x008c,
    HID_USAGE_PID_BLOCK_LOAD_FULL            = cast(ushort) 0x008d,
    HID_USAGE_PID_BLOCK_LOAD_ERROR           = cast(ushort) 0x008e,
    HID_USAGE_PID_BLOCK_HANDLE               = cast(ushort) 0x008f,
    HID_USAGE_PID_BLOCK_FREE_REPORT          = cast(ushort) 0x0090,
    HID_USAGE_PID_TYPE_SPECIFIC_BLOCK_HANDLE = cast(ushort) 0x0091,
}

enum : ushort
{
    HID_USAGE_PID_STATE_REPORT              = cast(ushort) 0x0092,
    HID_USAGE_PID_EFFECT_PLAYING            = cast(ushort) 0x0094,
    HID_USAGE_PID_PID_DEVICE_CONTROL_REPORT = cast(ushort) 0x0095,
}

enum : ushort
{
    HID_USAGE_PID_DEVICE_CONTROL           = cast(ushort) 0x0096,
    HID_USAGE_PID_DC_ENABLE_ACTUATORS      = cast(ushort) 0x0097,
    HID_USAGE_PID_DC_DISABLE_ACTUATORS     = cast(ushort) 0x0098,
    HID_USAGE_PID_DC_STOP_ALL_EFFECTS      = cast(ushort) 0x0099,
    HID_USAGE_PID_DC_DEVICE_RESET          = cast(ushort) 0x009a,
    HID_USAGE_PID_DC_DEVICE_PAUSE          = cast(ushort) 0x009b,
    HID_USAGE_PID_DC_DEVICE_CONTINUE       = cast(ushort) 0x009c,
    HID_USAGE_PID_DEVICE_PAUSED            = cast(ushort) 0x009f,
    HID_USAGE_PID_ACTUATORS_ENABLED        = cast(ushort) 0x00a0,
    HID_USAGE_PID_SAFETY_SWITCH            = cast(ushort) 0x00a4,
    HID_USAGE_PID_ACTUATOR_OVERRIDE_SWITCH = cast(ushort) 0x00a5,
    HID_USAGE_PID_ACTUATOR_POWER           = cast(ushort) 0x00a6,
    HID_USAGE_PID_START_DELAY              = cast(ushort) 0x00a7,
    HID_USAGE_PID_PARAMETER_BLOCK_SIZE     = cast(ushort) 0x00a8,
    HID_USAGE_PID_DEVICE_MANAGED_POOL      = cast(ushort) 0x00a9,
    HID_USAGE_PID_SHARED_PARAMETER_BLOCKS  = cast(ushort) 0x00aa,
}

enum : ushort
{
    HID_USAGE_PID_CREATE_NEW_EFFECT = cast(ushort) 0x00ab,
    HID_USAGE_PID_RAMPOOL_AVAILABLE = cast(ushort) 0x00ac,
}

enum : ushort
{
    HID_USAGE_POWER_INAME                  = cast(ushort) 0x0001,
    HID_USAGE_POWER_PRESENT_STATUS         = cast(ushort) 0x0002,
    HID_USAGE_POWER_CHANGED_STATUS         = cast(ushort) 0x0003,
    HID_USAGE_POWER_UPS                    = cast(ushort) 0x0004,
    HID_USAGE_POWER_POWER_SUPPLY           = cast(ushort) 0x0005,
    HID_USAGE_POWER_BATTERY_SYSTEM         = cast(ushort) 0x0010,
    HID_USAGE_POWER_BATTERY_SYSTEM_ID      = cast(ushort) 0x0011,
    HID_USAGE_POWER_BATTERY                = cast(ushort) 0x0012,
    HID_USAGE_POWER_BATTERY_ID             = cast(ushort) 0x0013,
    HID_USAGE_POWER_CHARGER                = cast(ushort) 0x0014,
    HID_USAGE_POWER_CHARGER_ID             = cast(ushort) 0x0015,
    HID_USAGE_POWER_POWER_CONVERTER        = cast(ushort) 0x0016,
    HID_USAGE_POWER_POWER_CONVERTER_ID     = cast(ushort) 0x0017,
    HID_USAGE_POWER_OUTLET_SYSTEM          = cast(ushort) 0x0018,
    HID_USAGE_POWER_OUTLET_SYSTEM_ID       = cast(ushort) 0x0019,
    HID_USAGE_POWER_INPUT                  = cast(ushort) 0x001a,
    HID_USAGE_POWER_INPUT_ID               = cast(ushort) 0x001b,
    HID_USAGE_POWER_OUTPUT                 = cast(ushort) 0x001c,
    HID_USAGE_POWER_OUTPUT_ID              = cast(ushort) 0x001d,
    HID_USAGE_POWER_FLOW                   = cast(ushort) 0x001e,
    HID_USAGE_POWER_FLOW_ID                = cast(ushort) 0x001f,
    HID_USAGE_POWER_OUTLET                 = cast(ushort) 0x0020,
    HID_USAGE_POWER_OUTLET_ID              = cast(ushort) 0x0021,
    HID_USAGE_POWER_GANG                   = cast(ushort) 0x0022,
    HID_USAGE_POWER_GANG_ID                = cast(ushort) 0x0023,
    HID_USAGE_POWER_POWER_SUMMARY          = cast(ushort) 0x0024,
    HID_USAGE_POWER_POWER_SUMMARY_ID       = cast(ushort) 0x0025,
    HID_USAGE_POWER_VOLTAGE                = cast(ushort) 0x0030,
    HID_USAGE_POWER_CURRENT                = cast(ushort) 0x0031,
    HID_USAGE_POWER_FREQUENCY              = cast(ushort) 0x0032,
    HID_USAGE_POWER_APPARENT_POWER         = cast(ushort) 0x0033,
    HID_USAGE_POWER_ACTIVE_POWER           = cast(ushort) 0x0034,
    HID_USAGE_POWER_PERCENT_LOAD           = cast(ushort) 0x0035,
    HID_USAGE_POWER_TEMPERATURE            = cast(ushort) 0x0036,
    HID_USAGE_POWER_HUMIDITY               = cast(ushort) 0x0037,
    HID_USAGE_POWER_BAD_COUNT              = cast(ushort) 0x0038,
    HID_USAGE_POWER_CONFIG_VOLTAGE         = cast(ushort) 0x0040,
    HID_USAGE_POWER_CONFIG_CURRENT         = cast(ushort) 0x0041,
    HID_USAGE_POWER_CONFIG_FREQUENCY       = cast(ushort) 0x0042,
    HID_USAGE_POWER_CONFIG_APPARENT_POWER  = cast(ushort) 0x0043,
    HID_USAGE_POWER_CONFIG_ACTIVE_POWER    = cast(ushort) 0x0044,
    HID_USAGE_POWER_CONFIG_PERCENT_LOAD    = cast(ushort) 0x0045,
    HID_USAGE_POWER_CONFIG_TEMPERATURE     = cast(ushort) 0x0046,
    HID_USAGE_POWER_CONFIG_HUMIDITY        = cast(ushort) 0x0047,
    HID_USAGE_POWER_SWITCH_ON_CONTROL      = cast(ushort) 0x0050,
    HID_USAGE_POWER_SWITCH_OFF_CONTROL     = cast(ushort) 0x0051,
    HID_USAGE_POWER_TOGGLE_CONTROL         = cast(ushort) 0x0052,
    HID_USAGE_POWER_LOW_VOLTAGE_TRANSFER   = cast(ushort) 0x0053,
    HID_USAGE_POWER_HIGH_VOLTAGE_TRANSFER  = cast(ushort) 0x0054,
    HID_USAGE_POWER_DELAY_BEFORE_REBOOT    = cast(ushort) 0x0055,
    HID_USAGE_POWER_DELAY_BEFORE_STARTUP   = cast(ushort) 0x0056,
    HID_USAGE_POWER_DELAY_BEFORE_SHUTDOWN  = cast(ushort) 0x0057,
    HID_USAGE_POWER_TEST                   = cast(ushort) 0x0058,
    HID_USAGE_POWER_MODULE_RESET           = cast(ushort) 0x0059,
    HID_USAGE_POWER_AUDIBLE_ALARM_CONTROL  = cast(ushort) 0x005a,
    HID_USAGE_POWER_PRESENT                = cast(ushort) 0x0060,
    HID_USAGE_POWER_GOOD                   = cast(ushort) 0x0061,
    HID_USAGE_POWER_INTERNAL_FAILURE       = cast(ushort) 0x0062,
    HID_USAGE_POWER_VOLTAG_OUT_OF_RANGE    = cast(ushort) 0x0063,
    HID_USAGE_POWER_FREQUENCY_OUT_OF_RANGE = cast(ushort) 0x0064,
    HID_USAGE_POWER_OVERLOAD               = cast(ushort) 0x0065,
    HID_USAGE_POWER_OVER_CHARGED           = cast(ushort) 0x0066,
    HID_USAGE_POWER_OVER_TEMPERATURE       = cast(ushort) 0x0067,
    HID_USAGE_POWER_SHUTDOWN_REQUESTED     = cast(ushort) 0x0068,
    HID_USAGE_POWER_SHUTDOWN_IMMINENT      = cast(ushort) 0x0069,
    HID_USAGE_POWER_SWITCH_ONOFF           = cast(ushort) 0x006b,
    HID_USAGE_POWER_SWITCHABLE             = cast(ushort) 0x006c,
    HID_USAGE_POWER_USED                   = cast(ushort) 0x006d,
    HID_USAGE_POWER_BOOST                  = cast(ushort) 0x006e,
    HID_USAGE_POWER_BUCK                   = cast(ushort) 0x006f,
    HID_USAGE_POWER_INITIALIZED            = cast(ushort) 0x0070,
    HID_USAGE_POWER_TESTED                 = cast(ushort) 0x0071,
    HID_USAGE_POWER_AWAITING_POWER         = cast(ushort) 0x0072,
    HID_USAGE_POWER_COMMUNICATION_LOST     = cast(ushort) 0x0073,
    HID_USAGE_POWER_IMANUFACTURER          = cast(ushort) 0x00fd,
    HID_USAGE_POWER_IPRODUCT               = cast(ushort) 0x00fe,
    HID_USAGE_POWER_ISERIALNUMBER          = cast(ushort) 0x00ff,
}

enum : ushort
{
    HID_USAGE_WEIGHING_DEVICE_SCALES                                = cast(ushort) 0x0001,
    HID_USAGE_WEIGHING_DEVICE_SCALE_DEVICE                          = cast(ushort) 0x0020,
    HID_USAGE_WEIGHING_DEVICE_SCALE_CLASS                           = cast(ushort) 0x0021,
    HID_USAGE_WEIGHING_DEVICE_SCALE_CLASS_I_METRIC                  = cast(ushort) 0x0022,
    HID_USAGE_WEIGHING_DEVICE_SCALE_CLASS_II_METRIC                 = cast(ushort) 0x0023,
    HID_USAGE_WEIGHING_DEVICE_SCALE_CLASS_III_METRIC                = cast(ushort) 0x0024,
    HID_USAGE_WEIGHING_DEVICE_SCALE_CLASS_IIIL_METRIC               = cast(ushort) 0x0025,
    HID_USAGE_WEIGHING_DEVICE_SCALE_CLASS_IV_METRIC                 = cast(ushort) 0x0026,
    HID_USAGE_WEIGHING_DEVICE_SCALE_CLASS_III_ENGLISH               = cast(ushort) 0x0027,
    HID_USAGE_WEIGHING_DEVICE_SCALE_CLASS_IIIL_ENGLISH              = cast(ushort) 0x0028,
    HID_USAGE_WEIGHING_DEVICE_SCALE_CLASS_IV_ENGLISH                = cast(ushort) 0x0029,
    HID_USAGE_WEIGHING_DEVICE_SCALE_CLASS_GENERIC                   = cast(ushort) 0x002a,
    HID_USAGE_WEIGHING_DEVICE_SCALE_ATTRIBUTE_REPORT                = cast(ushort) 0x0030,
    HID_USAGE_WEIGHING_DEVICE_SCALE_CONTROL_REPORT                  = cast(ushort) 0x0031,
    HID_USAGE_WEIGHING_DEVICE_SCALE_DATA_REPORT                     = cast(ushort) 0x0032,
    HID_USAGE_WEIGHING_DEVICE_SCALE_STATUS_REPORT                   = cast(ushort) 0x0033,
    HID_USAGE_WEIGHING_DEVICE_SCALE_WEIGHT_LIMIT_REPORT             = cast(ushort) 0x0034,
    HID_USAGE_WEIGHING_DEVICE_SCALE_STATISTICS_REPORT               = cast(ushort) 0x0035,
    HID_USAGE_WEIGHING_DEVICE_DATA_WEIGHT                           = cast(ushort) 0x0040,
    HID_USAGE_WEIGHING_DEVICE_DATA_SCALING                          = cast(ushort) 0x0041,
    HID_USAGE_WEIGHING_DEVICE_WEIGHT_UNIT                           = cast(ushort) 0x0050,
    HID_USAGE_WEIGHING_DEVICE_WEIGHT_UNIT_MILLIGRAM                 = cast(ushort) 0x0051,
    HID_USAGE_WEIGHING_DEVICE_WEIGHT_UNIT_GRAM                      = cast(ushort) 0x0052,
    HID_USAGE_WEIGHING_DEVICE_WEIGHT_UNIT_KILOGRAM                  = cast(ushort) 0x0053,
    HID_USAGE_WEIGHING_DEVICE_WEIGHT_UNIT_CARATS                    = cast(ushort) 0x0054,
    HID_USAGE_WEIGHING_DEVICE_WEIGHT_UNIT_TAELS                     = cast(ushort) 0x0055,
    HID_USAGE_WEIGHING_DEVICE_WEIGHT_UNIT_GRAINS                    = cast(ushort) 0x0056,
    HID_USAGE_WEIGHING_DEVICE_WEIGHT_UNIT_PENNYWEIGHTS              = cast(ushort) 0x0057,
    HID_USAGE_WEIGHING_DEVICE_WEIGHT_UNIT_METRIC_TON                = cast(ushort) 0x0058,
    HID_USAGE_WEIGHING_DEVICE_WEIGHT_UNIT_AVOIR_TON                 = cast(ushort) 0x0059,
    HID_USAGE_WEIGHING_DEVICE_WEIGHT_UNIT_TROY_OUNCE                = cast(ushort) 0x005a,
    HID_USAGE_WEIGHING_DEVICE_WEIGHT_UNIT_OUNCE                     = cast(ushort) 0x005b,
    HID_USAGE_WEIGHING_DEVICE_WEIGHT_UNIT_POUND                     = cast(ushort) 0x005c,
    HID_USAGE_WEIGHING_DEVICE_CALIBRATION_COUNT                     = cast(ushort) 0x0060,
    HID_USAGE_WEIGHING_DEVICE_REZERO_COUNT                          = cast(ushort) 0x0061,
    HID_USAGE_WEIGHING_DEVICE_SCALE_STATUS                          = cast(ushort) 0x0070,
    HID_USAGE_WEIGHING_DEVICE_SCALE_STATUS_FAULT                    = cast(ushort) 0x0071,
    HID_USAGE_WEIGHING_DEVICE_SCALE_STATUS_STABLE_AT_CENTER_OF_ZERO = cast(ushort) 0x0072,
    HID_USAGE_WEIGHING_DEVICE_SCALE_STATUS_IN_MOTION                = cast(ushort) 0x0073,
    HID_USAGE_WEIGHING_DEVICE_SCALE_STATUS_WEIGHT_STABLE            = cast(ushort) 0x0074,
    HID_USAGE_WEIGHING_DEVICE_SCALE_STATUS_UNDER_ZERO               = cast(ushort) 0x0075,
    HID_USAGE_WEIGHING_DEVICE_SCALE_STATUS_OVER_WEIGHT_LIMIT        = cast(ushort) 0x0076,
    HID_USAGE_WEIGHING_DEVICE_SCALE_STATUS_REQUIRES_CALIBRATION     = cast(ushort) 0x0077,
    HID_USAGE_WEIGHING_DEVICE_SCALE_STATUS_REQUIRES_REZEROING       = cast(ushort) 0x0078,
    HID_USAGE_WEIGHING_DEVICE_ZERO_SCALE                            = cast(ushort) 0x0080,
    HID_USAGE_WEIGHING_DEVICE_ENFORCED_ZERO_RETURN                  = cast(ushort) 0x0081,
}

enum : ushort
{
    HID_USAGE_SENSORS_SENSOR                                   = cast(ushort) 0x0001,
    HID_USAGE_SENSORS_BIOMETRIC                                = cast(ushort) 0x0010,
    HID_USAGE_SENSORS_BIOMETRIC_HUMAN_PRESENCE                 = cast(ushort) 0x0011,
    HID_USAGE_SENSORS_BIOMETRIC_HUMAN_PROXIMITY                = cast(ushort) 0x0012,
    HID_USAGE_SENSORS_BIOMETRIC_HUMAN_TOUCH                    = cast(ushort) 0x0013,
    HID_USAGE_SENSORS_BIOMETRIC_BLOOD_PRESSURE                 = cast(ushort) 0x0014,
    HID_USAGE_SENSORS_BIOMETRIC_BODY_TEMPERATURE               = cast(ushort) 0x0015,
    HID_USAGE_SENSORS_BIOMETRIC_HEART_RATE                     = cast(ushort) 0x0016,
    HID_USAGE_SENSORS_BIOMETRIC_HEART_RATE_VARIABILITY         = cast(ushort) 0x0017,
    HID_USAGE_SENSORS_BIOMETRIC_PERIPHERAL_OXYGEN_SATURATION   = cast(ushort) 0x0018,
    HID_USAGE_SENSORS_BIOMETRIC_RESPIRATORY_RATE               = cast(ushort) 0x0019,
    HID_USAGE_SENSORS_ELECTRICAL                               = cast(ushort) 0x0020,
    HID_USAGE_SENSORS_ELECTRICAL_CAPACITANCE                   = cast(ushort) 0x0021,
    HID_USAGE_SENSORS_ELECTRICAL_CURRENT                       = cast(ushort) 0x0022,
    HID_USAGE_SENSORS_ELECTRICAL_POWER                         = cast(ushort) 0x0023,
    HID_USAGE_SENSORS_ELECTRICAL_INDUCTANCE                    = cast(ushort) 0x0024,
    HID_USAGE_SENSORS_ELECTRICAL_RESISTANCE                    = cast(ushort) 0x0025,
    HID_USAGE_SENSORS_ELECTRICAL_VOLTAGE                       = cast(ushort) 0x0026,
    HID_USAGE_SENSORS_ELECTRICAL_POTENTIOMETER                 = cast(ushort) 0x0027,
    HID_USAGE_SENSORS_ELECTRICAL_FREQUENCY                     = cast(ushort) 0x0028,
    HID_USAGE_SENSORS_ELECTRICAL_PERIOD                        = cast(ushort) 0x0029,
    HID_USAGE_SENSORS_ENVIRONMENTAL                            = cast(ushort) 0x0030,
    HID_USAGE_SENSORS_ENVIRONMENTAL_ATMOSPHERIC_PRESSURE       = cast(ushort) 0x0031,
    HID_USAGE_SENSORS_ENVIRONMENTAL_HUMIDITY                   = cast(ushort) 0x0032,
    HID_USAGE_SENSORS_ENVIRONMENTAL_TEMPERATURE                = cast(ushort) 0x0033,
    HID_USAGE_SENSORS_ENVIRONMENTAL_WIND_DIRECTION             = cast(ushort) 0x0034,
    HID_USAGE_SENSORS_ENVIRONMENTAL_WIND_SPEED                 = cast(ushort) 0x0035,
    HID_USAGE_SENSORS_ENVIRONMENTAL_AIR_QUALITY                = cast(ushort) 0x0036,
    HID_USAGE_SENSORS_ENVIRONMENTAL_HEAT_INDEX                 = cast(ushort) 0x0037,
    HID_USAGE_SENSORS_ENVIRONMENTAL_SURFACE_TEMPERATURE        = cast(ushort) 0x0038,
    HID_USAGE_SENSORS_ENVIRONMENTAL_VOLATILE_ORGANIC_COMPOUNDS = cast(ushort) 0x0039,
    HID_USAGE_SENSORS_ENVIRONMENTAL_OBJECT_PRESENCE            = cast(ushort) 0x003a,
    HID_USAGE_SENSORS_ENVIRONMENTAL_OBJECT_PROXIMITY           = cast(ushort) 0x003b,
}

enum : ushort
{
    HID_USAGE_SENSORS_LIGHT                                  = cast(ushort) 0x0040,
    HID_USAGE_SENSORS_LIGHT_AMBIENT_LIGHT                    = cast(ushort) 0x0041,
    HID_USAGE_SENSORS_LIGHT_CONSUMER_INFRARED                = cast(ushort) 0x0042,
    HID_USAGE_SENSORS_LIGHT_INFRARED_LIGHT                   = cast(ushort) 0x0043,
    HID_USAGE_SENSORS_LIGHT_VISIBLE_LIGHT                    = cast(ushort) 0x0044,
    HID_USAGE_SENSORS_LIGHT_ULTRAVIOLET_LIGHT                = cast(ushort) 0x0045,
    HID_USAGE_SENSORS_LOCATION                               = cast(ushort) 0x0050,
    HID_USAGE_SENSORS_LOCATION_BROADCAST                     = cast(ushort) 0x0051,
    HID_USAGE_SENSORS_LOCATION_DEAD_RECKONING                = cast(ushort) 0x0052,
    HID_USAGE_SENSORS_LOCATION_GPS_GLOBAL_POSITIONING_SYSTEM = cast(ushort) 0x0053,
    HID_USAGE_SENSORS_LOCATION_LOOKUP                        = cast(ushort) 0x0054,
    HID_USAGE_SENSORS_LOCATION_OTHER                         = cast(ushort) 0x0055,
    HID_USAGE_SENSORS_LOCATION_STATIC                        = cast(ushort) 0x0056,
    HID_USAGE_SENSORS_LOCATION_TRIANGULATION                 = cast(ushort) 0x0057,
    HID_USAGE_SENSORS_MECHANICAL                             = cast(ushort) 0x0060,
    HID_USAGE_SENSORS_MECHANICAL_BOOLEAN_SWITCH              = cast(ushort) 0x0061,
    HID_USAGE_SENSORS_MECHANICAL_BOOLEAN_SWITCH_ARRAY        = cast(ushort) 0x0062,
    HID_USAGE_SENSORS_MECHANICAL_MULTIVALUE_SWITCH           = cast(ushort) 0x0063,
    HID_USAGE_SENSORS_MECHANICAL_FORCE                       = cast(ushort) 0x0064,
    HID_USAGE_SENSORS_MECHANICAL_PRESSURE                    = cast(ushort) 0x0065,
    HID_USAGE_SENSORS_MECHANICAL_STRAIN                      = cast(ushort) 0x0066,
    HID_USAGE_SENSORS_MECHANICAL_WEIGHT                      = cast(ushort) 0x0067,
    HID_USAGE_SENSORS_MECHANICAL_HAPTIC_VIBRATOR             = cast(ushort) 0x0068,
    HID_USAGE_SENSORS_MECHANICAL_HALL_EFFECT_SWITCH          = cast(ushort) 0x0069,
    HID_USAGE_SENSORS_MOTION                                 = cast(ushort) 0x0070,
    HID_USAGE_SENSORS_MOTION_ACCELEROMETER_1D                = cast(ushort) 0x0071,
    HID_USAGE_SENSORS_MOTION_ACCELEROMETER_2D                = cast(ushort) 0x0072,
    HID_USAGE_SENSORS_MOTION_ACCELEROMETER_3D                = cast(ushort) 0x0073,
    HID_USAGE_SENSORS_MOTION_GYROMETER_1D                    = cast(ushort) 0x0074,
    HID_USAGE_SENSORS_MOTION_GYROMETER_2D                    = cast(ushort) 0x0075,
    HID_USAGE_SENSORS_MOTION_GYROMETER_3D                    = cast(ushort) 0x0076,
    HID_USAGE_SENSORS_MOTION_MOTION_DETECTOR                 = cast(ushort) 0x0077,
    HID_USAGE_SENSORS_MOTION_SPEEDOMETER                     = cast(ushort) 0x0078,
    HID_USAGE_SENSORS_MOTION_ACCELEROMETER                   = cast(ushort) 0x0079,
    HID_USAGE_SENSORS_MOTION_GYROMETER                       = cast(ushort) 0x007a,
    HID_USAGE_SENSORS_MOTION_GRAVITY_VECTOR                  = cast(ushort) 0x007b,
    HID_USAGE_SENSORS_MOTION_LINEAR_ACCELEROMETER            = cast(ushort) 0x007c,
}

enum : ushort
{
    HID_USAGE_SENSORS_ORIENTATION                      = cast(ushort) 0x0080,
    HID_USAGE_SENSORS_ORIENTATION_COMPASS_1D           = cast(ushort) 0x0081,
    HID_USAGE_SENSORS_ORIENTATION_COMPASS_2D           = cast(ushort) 0x0082,
    HID_USAGE_SENSORS_ORIENTATION_COMPASS_3D           = cast(ushort) 0x0083,
    HID_USAGE_SENSORS_ORIENTATION_INCLINOMETER_1D      = cast(ushort) 0x0084,
    HID_USAGE_SENSORS_ORIENTATION_INCLINOMETER_2D      = cast(ushort) 0x0085,
    HID_USAGE_SENSORS_ORIENTATION_INCLINOMETER_3D      = cast(ushort) 0x0086,
    HID_USAGE_SENSORS_ORIENTATION_DISTANCE_1D          = cast(ushort) 0x0087,
    HID_USAGE_SENSORS_ORIENTATION_DISTANCE_2D          = cast(ushort) 0x0088,
    HID_USAGE_SENSORS_ORIENTATION_DISTANCE_3D          = cast(ushort) 0x0089,
    HID_USAGE_SENSORS_ORIENTATION_DEVICE_ORIENTATION   = cast(ushort) 0x008a,
    HID_USAGE_SENSORS_ORIENTATION_COMPASS              = cast(ushort) 0x008b,
    HID_USAGE_SENSORS_ORIENTATION_INCLINOMETER         = cast(ushort) 0x008c,
    HID_USAGE_SENSORS_ORIENTATION_DISTANCE             = cast(ushort) 0x008d,
    HID_USAGE_SENSORS_ORIENTATION_RELATIVE_ORIENTATION = cast(ushort) 0x008e,
    HID_USAGE_SENSORS_ORIENTATION_SIMPLE_ORIENTATION   = cast(ushort) 0x008f,
}

enum : ushort
{
    HID_USAGE_SENSORS_SCANNER                              = cast(ushort) 0x0090,
    HID_USAGE_SENSORS_SCANNER_BARCODE                      = cast(ushort) 0x0091,
    HID_USAGE_SENSORS_SCANNER_RFID                         = cast(ushort) 0x0092,
    HID_USAGE_SENSORS_SCANNER_NFC                          = cast(ushort) 0x0093,
    HID_USAGE_SENSORS_TIME                                 = cast(ushort) 0x00a0,
    HID_USAGE_SENSORS_TIME_ALARM_TIMER                     = cast(ushort) 0x00a1,
    HID_USAGE_SENSORS_TIME_REAL_TIME_CLOCK                 = cast(ushort) 0x00a2,
    HID_USAGE_SENSORS_PERSONAL_ACTIVITY                    = cast(ushort) 0x00b0,
    HID_USAGE_SENSORS_PERSONAL_ACTIVITY_ACTIVITY_DETECTION = cast(ushort) 0x00b1,
    HID_USAGE_SENSORS_PERSONAL_ACTIVITY_DEVICE_POSITION    = cast(ushort) 0x00b2,
    HID_USAGE_SENSORS_PERSONAL_ACTIVITY_FLOOR_TRACKER      = cast(ushort) 0x00b3,
    HID_USAGE_SENSORS_PERSONAL_ACTIVITY_PEDOMETER          = cast(ushort) 0x00b4,
    HID_USAGE_SENSORS_PERSONAL_ACTIVITY_STEP_DETECTION     = cast(ushort) 0x00b5,
}

enum : ushort
{
    HID_USAGE_SENSORS_ORIENTATION_EXTENDED                         = cast(ushort) 0x00c0,
    HID_USAGE_SENSORS_ORIENTATION_EXTENDED_GEOMAGNETIC_ORIENTATION = cast(ushort) 0x00c1,
    HID_USAGE_SENSORS_ORIENTATION_EXTENDED_MAGNETOMETER            = cast(ushort) 0x00c2,
}

enum : ushort
{
    HID_USAGE_SENSORS_GESTURE                                      = cast(ushort) 0x00d0,
    HID_USAGE_SENSORS_GESTURE_CHASSIS_FLIP_GESTURE                 = cast(ushort) 0x00d1,
    HID_USAGE_SENSORS_GESTURE_HINGE_FOLD_GESTURE                   = cast(ushort) 0x00d2,
    HID_USAGE_SENSORS_OTHER                                        = cast(ushort) 0x00e0,
    HID_USAGE_SENSORS_OTHER_CUSTOM                                 = cast(ushort) 0x00e1,
    HID_USAGE_SENSORS_OTHER_GENERIC                                = cast(ushort) 0x00e2,
    HID_USAGE_SENSORS_OTHER_GENERIC_ENUMERATOR                     = cast(ushort) 0x00e3,
    HID_USAGE_SENSORS_OTHER_HINGE_ANGLE                            = cast(ushort) 0x00e4,
    HID_USAGE_SENSORS_VENDOR_RESERVED_1                            = cast(ushort) 0x00f0,
    HID_USAGE_SENSORS_VENDOR_RESERVED_2                            = cast(ushort) 0x00f1,
    HID_USAGE_SENSORS_VENDOR_RESERVED_3                            = cast(ushort) 0x00f2,
    HID_USAGE_SENSORS_VENDOR_RESERVED_4                            = cast(ushort) 0x00f3,
    HID_USAGE_SENSORS_VENDOR_RESERVED_5                            = cast(ushort) 0x00f4,
    HID_USAGE_SENSORS_VENDOR_RESERVED_6                            = cast(ushort) 0x00f5,
    HID_USAGE_SENSORS_VENDOR_RESERVED_7                            = cast(ushort) 0x00f6,
    HID_USAGE_SENSORS_VENDOR_RESERVED_8                            = cast(ushort) 0x00f7,
    HID_USAGE_SENSORS_VENDOR_RESERVED_9                            = cast(ushort) 0x00f8,
    HID_USAGE_SENSORS_VENDOR_RESERVED_10                           = cast(ushort) 0x00f9,
    HID_USAGE_SENSORS_VENDOR_RESERVED_11                           = cast(ushort) 0x00fa,
    HID_USAGE_SENSORS_VENDOR_RESERVED_12                           = cast(ushort) 0x00fb,
    HID_USAGE_SENSORS_VENDOR_RESERVED_13                           = cast(ushort) 0x00fc,
    HID_USAGE_SENSORS_VENDOR_RESERVED_14                           = cast(ushort) 0x00fd,
    HID_USAGE_SENSORS_VENDOR_RESERVED_15                           = cast(ushort) 0x00fe,
    HID_USAGE_SENSORS_VENDOR_RESERVED_16                           = cast(ushort) 0x00ff,
    HID_USAGE_SENSORS_EVENT                                        = cast(ushort) 0x0200,
    HID_USAGE_SENSORS_EVENT_SENSOR_STATE                           = cast(ushort) 0x0201,
    HID_USAGE_SENSORS_EVENT_SENSOR_EVENT                           = cast(ushort) 0x0202,
    HID_USAGE_SENSORS_PROPERTY                                     = cast(ushort) 0x0300,
    HID_USAGE_SENSORS_PROPERTY_FRIENDLY_NAME                       = cast(ushort) 0x0301,
    HID_USAGE_SENSORS_PROPERTY_PERSISTENT_UNIQUE_ID                = cast(ushort) 0x0302,
    HID_USAGE_SENSORS_PROPERTY_SENSOR_STATUS                       = cast(ushort) 0x0303,
    HID_USAGE_SENSORS_PROPERTY_MINIMUM_REPORT_INTERVAL             = cast(ushort) 0x0304,
    HID_USAGE_SENSORS_PROPERTY_SENSOR_MANUFACTURER                 = cast(ushort) 0x0305,
    HID_USAGE_SENSORS_PROPERTY_SENSOR_MODEL                        = cast(ushort) 0x0306,
    HID_USAGE_SENSORS_PROPERTY_SENSOR_SERIAL_NUMBER                = cast(ushort) 0x0307,
    HID_USAGE_SENSORS_PROPERTY_SENSOR_DESCRIPTION                  = cast(ushort) 0x0308,
    HID_USAGE_SENSORS_PROPERTY_SENSOR_CONNECTION_TYPE              = cast(ushort) 0x0309,
    HID_USAGE_SENSORS_PROPERTY_SENSOR_DEVICE_PATH                  = cast(ushort) 0x030a,
    HID_USAGE_SENSORS_PROPERTY_HARDWARE_REVISION                   = cast(ushort) 0x030b,
    HID_USAGE_SENSORS_PROPERTY_FIRMWARE_VERSION                    = cast(ushort) 0x030c,
    HID_USAGE_SENSORS_PROPERTY_RELEASE_DATE                        = cast(ushort) 0x030d,
    HID_USAGE_SENSORS_PROPERTY_REPORT_INTERVAL                     = cast(ushort) 0x030e,
    HID_USAGE_SENSORS_PROPERTY_CHANGE_SENSITIVITY_ABSOLUTE         = cast(ushort) 0x030f,
    HID_USAGE_SENSORS_PROPERTY_CHANGE_SENSITIVITY_PERCENT_OF_RANGE = cast(ushort) 0x0310,
    HID_USAGE_SENSORS_PROPERTY_CHANGE_SENSITIVITY_PERCENT_RELATIVE = cast(ushort) 0x0311,
    HID_USAGE_SENSORS_PROPERTY_ACCURACY                            = cast(ushort) 0x0312,
    HID_USAGE_SENSORS_PROPERTY_RESOLUTION                          = cast(ushort) 0x0313,
    HID_USAGE_SENSORS_PROPERTY_MAXIMUM                             = cast(ushort) 0x0314,
    HID_USAGE_SENSORS_PROPERTY_MINIMUM                             = cast(ushort) 0x0315,
    HID_USAGE_SENSORS_PROPERTY_REPORTING_STATE                     = cast(ushort) 0x0316,
    HID_USAGE_SENSORS_PROPERTY_SAMPLING_RATE                       = cast(ushort) 0x0317,
    HID_USAGE_SENSORS_PROPERTY_RESPONSE_CURVE                      = cast(ushort) 0x0318,
    HID_USAGE_SENSORS_PROPERTY_POWER_STATE                         = cast(ushort) 0x0319,
    HID_USAGE_SENSORS_PROPERTY_MAXIMUM_FIFO_EVENTS                 = cast(ushort) 0x031a,
    HID_USAGE_SENSORS_PROPERTY_REPORT_LATENCY                      = cast(ushort) 0x031b,
    HID_USAGE_SENSORS_PROPERTY_FLUSH_FIFO_EVENTS                   = cast(ushort) 0x031c,
    HID_USAGE_SENSORS_PROPERTY_MAXIMUM_POWER_CONSUMPTION           = cast(ushort) 0x031d,
    HID_USAGE_SENSORS_PROPERTY_IS_PRIMARY                          = cast(ushort) 0x031e,
    HID_USAGE_SENSORS_PROPERTY_HUMAN_PRESENCE_DETECTION_TYPE       = cast(ushort) 0x031f,
}

enum : ushort
{
    HID_USAGE_SENSORS_DATA_FIELD_LOCATION                          = cast(ushort) 0x0400,
    HID_USAGE_SENSORS_DATA_FIELD_ALTITUDE_ANTENNA_SEA_LEVEL        = cast(ushort) 0x0402,
    HID_USAGE_SENSORS_DATA_FIELD_DIFFERENTIAL_REFERENCE_STATION_ID = cast(ushort) 0x0403,
    HID_USAGE_SENSORS_DATA_FIELD_ALTITUDE_ELLIPSOID_ERROR          = cast(ushort) 0x0404,
    HID_USAGE_SENSORS_DATA_FIELD_ALTITUDE_ELLIPSOID                = cast(ushort) 0x0405,
    HID_USAGE_SENSORS_DATA_FIELD_ALTITUDE_SEA_LEVEL_ERROR          = cast(ushort) 0x0406,
    HID_USAGE_SENSORS_DATA_FIELD_ALTITUDE_SEA_LEVEL                = cast(ushort) 0x0407,
    HID_USAGE_SENSORS_DATA_FIELD_DIFFERENTIAL_GPS_DATA_AGE         = cast(ushort) 0x0408,
    HID_USAGE_SENSORS_DATA_FIELD_ERROR_RADIUS                      = cast(ushort) 0x0409,
    HID_USAGE_SENSORS_DATA_FIELD_FIX_QUALITY                       = cast(ushort) 0x040a,
    HID_USAGE_SENSORS_DATA_FIELD_FIX_TYPE                          = cast(ushort) 0x040b,
    HID_USAGE_SENSORS_DATA_FIELD_GEOIDAL_SEPARATION                = cast(ushort) 0x040c,
    HID_USAGE_SENSORS_DATA_FIELD_GPS_OPERATION_MODE                = cast(ushort) 0x040d,
    HID_USAGE_SENSORS_DATA_FIELD_GPS_SELECTION_MODE                = cast(ushort) 0x040e,
    HID_USAGE_SENSORS_DATA_FIELD_GPS_STATUS                        = cast(ushort) 0x040f,
    HID_USAGE_SENSORS_DATA_FIELD_POSITION_DILUTION_OF_PRECISION    = cast(ushort) 0x0410,
    HID_USAGE_SENSORS_DATA_FIELD_HORIZONTAL_DILUTION_OF_PRECISION  = cast(ushort) 0x0411,
    HID_USAGE_SENSORS_DATA_FIELD_VERTICAL_DILUTION_OF_PRECISION    = cast(ushort) 0x0412,
    HID_USAGE_SENSORS_DATA_FIELD_LATITUDE                          = cast(ushort) 0x0413,
    HID_USAGE_SENSORS_DATA_FIELD_LONGITUDE                         = cast(ushort) 0x0414,
    HID_USAGE_SENSORS_DATA_FIELD_TRUE_HEADING                      = cast(ushort) 0x0415,
    HID_USAGE_SENSORS_DATA_FIELD_MAGNETIC_HEADING                  = cast(ushort) 0x0416,
    HID_USAGE_SENSORS_DATA_FIELD_MAGNETIC_VARIATION                = cast(ushort) 0x0417,
    HID_USAGE_SENSORS_DATA_FIELD_SPEED                             = cast(ushort) 0x0418,
    HID_USAGE_SENSORS_DATA_FIELD_SATELLITES_IN_VIEW                = cast(ushort) 0x0419,
    HID_USAGE_SENSORS_DATA_FIELD_SATELLITES_IN_VIEW_AZIMUTH        = cast(ushort) 0x041a,
    HID_USAGE_SENSORS_DATA_FIELD_SATELLITES_IN_VIEW_ELEVATION      = cast(ushort) 0x041b,
    HID_USAGE_SENSORS_DATA_FIELD_SATELLITES_IN_VIEW_IDS            = cast(ushort) 0x041c,
    HID_USAGE_SENSORS_DATA_FIELD_SATELLITES_IN_VIEW_PRNS           = cast(ushort) 0x041d,
    HID_USAGE_SENSORS_DATA_FIELD_SATELLITES_IN_VIEW_SN_RATIOS      = cast(ushort) 0x041e,
    HID_USAGE_SENSORS_DATA_FIELD_SATELLITES_USED_COUNT             = cast(ushort) 0x041f,
    HID_USAGE_SENSORS_DATA_FIELD_SATELLITES_USED_PRNS              = cast(ushort) 0x0420,
    HID_USAGE_SENSORS_DATA_FIELD_NMEA_SENTENCE                     = cast(ushort) 0x0421,
    HID_USAGE_SENSORS_DATA_FIELD_ADDRESS_LINE_1                    = cast(ushort) 0x0422,
    HID_USAGE_SENSORS_DATA_FIELD_ADDRESS_LINE_2                    = cast(ushort) 0x0423,
    HID_USAGE_SENSORS_DATA_FIELD_CITY                              = cast(ushort) 0x0424,
    HID_USAGE_SENSORS_DATA_FIELD_STATE_OR_PROVINCE                 = cast(ushort) 0x0425,
    HID_USAGE_SENSORS_DATA_FIELD_COUNTRY_OR_REGION                 = cast(ushort) 0x0426,
    HID_USAGE_SENSORS_DATA_FIELD_POSTAL_CODE                       = cast(ushort) 0x0427,
    HID_USAGE_SENSORS_PROPERTY_LOCATION                            = cast(ushort) 0x042a,
    HID_USAGE_SENSORS_PROPERTY_LOCATION_DESIRED_ACCURACY           = cast(ushort) 0x042b,
}

enum : ushort
{
    HID_USAGE_SENSORS_DATA_FIELD_ENVIRONMENTAL                           = cast(ushort) 0x0430,
    HID_USAGE_SENSORS_DATA_FIELD_ATMOSPHERIC_PRESSURE                    = cast(ushort) 0x0431,
    HID_USAGE_SENSORS_DATA_FIELD_RELATIVE_HUMIDITY                       = cast(ushort) 0x0433,
    HID_USAGE_SENSORS_DATA_FIELD_TEMPERATURE                             = cast(ushort) 0x0434,
    HID_USAGE_SENSORS_DATA_FIELD_WIND_DIRECTION                          = cast(ushort) 0x0435,
    HID_USAGE_SENSORS_DATA_FIELD_WIND_SPEED                              = cast(ushort) 0x0436,
    HID_USAGE_SENSORS_DATA_FIELD_AIR_QUALITY_INDEX                       = cast(ushort) 0x0437,
    HID_USAGE_SENSORS_DATA_FIELD_EQUIVALENT_CO2                          = cast(ushort) 0x0438,
    HID_USAGE_SENSORS_DATA_FIELD_VOLATILE_ORGANIC_COMPOUND_CONCENTRATION = cast(ushort) 0x0439,
    HID_USAGE_SENSORS_DATA_FIELD_OBJECT_PRESENCE                         = cast(ushort) 0x043a,
    HID_USAGE_SENSORS_DATA_FIELD_OBJECT_PROXIMITY_RANGE                  = cast(ushort) 0x043b,
    HID_USAGE_SENSORS_DATA_FIELD_OBJECT_PROXIMITY_OUT_OF_RANGE           = cast(ushort) 0x043c,
}

enum : ushort
{
    HID_USAGE_SENSORS_PROPERTY_ENVIRONMENTAL      = cast(ushort) 0x0440,
    HID_USAGE_SENSORS_PROPERTY_REFERENCE_PRESSURE = cast(ushort) 0x0441,
}

enum : ushort
{
    HID_USAGE_SENSORS_DATA_FIELD_MOTION                             = cast(ushort) 0x0450,
    HID_USAGE_SENSORS_DATA_FIELD_MOTION_STATE                       = cast(ushort) 0x0451,
    HID_USAGE_SENSORS_DATA_FIELD_ACCELERATION                       = cast(ushort) 0x0452,
    HID_USAGE_SENSORS_DATA_FIELD_ACCELERATION_AXIS_X                = cast(ushort) 0x0453,
    HID_USAGE_SENSORS_DATA_FIELD_ACCELERATION_AXIS_Y                = cast(ushort) 0x0454,
    HID_USAGE_SENSORS_DATA_FIELD_ACCELERATION_AXIS_Z                = cast(ushort) 0x0455,
    HID_USAGE_SENSORS_DATA_FIELD_ANGULAR_VELOCITY                   = cast(ushort) 0x0456,
    HID_USAGE_SENSORS_DATA_FIELD_ANGULAR_VELOCITY_ABOUT_X_AXIS      = cast(ushort) 0x0457,
    HID_USAGE_SENSORS_DATA_FIELD_ANGULAR_VELOCITY_ABOUT_Y_AXIS      = cast(ushort) 0x0458,
    HID_USAGE_SENSORS_DATA_FIELD_ANGULAR_VELOCITY_ABOUT_Z_AXIS      = cast(ushort) 0x0459,
    HID_USAGE_SENSORS_DATA_FIELD_ANGULAR_POSITION                   = cast(ushort) 0x045a,
    HID_USAGE_SENSORS_DATA_FIELD_ANGULAR_POSITION_ABOUT_X_AXIS      = cast(ushort) 0x045b,
    HID_USAGE_SENSORS_DATA_FIELD_ANGULAR_POSITION_ABOUT_Y_AXIS      = cast(ushort) 0x045c,
    HID_USAGE_SENSORS_DATA_FIELD_ANGULAR_POSITION_ABOUT_Z_AXIS      = cast(ushort) 0x045d,
    HID_USAGE_SENSORS_DATA_FIELD_MOTION_SPEED                       = cast(ushort) 0x045e,
    HID_USAGE_SENSORS_DATA_FIELD_MOTION_INTENSITY                   = cast(ushort) 0x045f,
    HID_USAGE_SENSORS_DATA_FIELD_ORIENTATION                        = cast(ushort) 0x0470,
    HID_USAGE_SENSORS_DATA_FIELD_HEADING                            = cast(ushort) 0x0471,
    HID_USAGE_SENSORS_DATA_FIELD_HEADING_X_AXIS                     = cast(ushort) 0x0472,
    HID_USAGE_SENSORS_DATA_FIELD_HEADING_Y_AXIS                     = cast(ushort) 0x0473,
    HID_USAGE_SENSORS_DATA_FIELD_HEADING_Z_AXIS                     = cast(ushort) 0x0474,
    HID_USAGE_SENSORS_DATA_FIELD_HEADING_COMPENSATED_MAGNETIC_NORTH = cast(ushort) 0x0475,
    HID_USAGE_SENSORS_DATA_FIELD_HEADING_COMPENSATED_TRUE_NORTH     = cast(ushort) 0x0476,
    HID_USAGE_SENSORS_DATA_FIELD_HEADING_MAGNETIC_NORTH             = cast(ushort) 0x0477,
    HID_USAGE_SENSORS_DATA_FIELD_HEADING_TRUE_NORTH                 = cast(ushort) 0x0478,
    HID_USAGE_SENSORS_DATA_FIELD_DISTANCE                           = cast(ushort) 0x0479,
    HID_USAGE_SENSORS_DATA_FIELD_DISTANCE_X_AXIS                    = cast(ushort) 0x047a,
    HID_USAGE_SENSORS_DATA_FIELD_DISTANCE_Y_AXIS                    = cast(ushort) 0x047b,
    HID_USAGE_SENSORS_DATA_FIELD_DISTANCE_Z_AXIS                    = cast(ushort) 0x047c,
    HID_USAGE_SENSORS_DATA_FIELD_DISTANCE_OUTOFRANGE                = cast(ushort) 0x047d,
    HID_USAGE_SENSORS_DATA_FIELD_TILT                               = cast(ushort) 0x047e,
    HID_USAGE_SENSORS_DATA_FIELD_TILT_X_AXIS                        = cast(ushort) 0x047f,
    HID_USAGE_SENSORS_DATA_FIELD_TILT_Y_AXIS                        = cast(ushort) 0x0480,
    HID_USAGE_SENSORS_DATA_FIELD_TILT_Z_AXIS                        = cast(ushort) 0x0481,
    HID_USAGE_SENSORS_DATA_FIELD_ROTATION_MATRIX                    = cast(ushort) 0x0482,
    HID_USAGE_SENSORS_DATA_FIELD_QUATERNION                         = cast(ushort) 0x0483,
    HID_USAGE_SENSORS_DATA_FIELD_MAGNETIC_FLUX                      = cast(ushort) 0x0484,
    HID_USAGE_SENSORS_DATA_FIELD_MAGNETIC_FLUX_X_AXIS               = cast(ushort) 0x0485,
    HID_USAGE_SENSORS_DATA_FIELD_MAGNETIC_FLUX_Y_AXIS               = cast(ushort) 0x0486,
    HID_USAGE_SENSORS_DATA_FIELD_MAGNETIC_FLUX_Z_AXIS               = cast(ushort) 0x0487,
    HID_USAGE_SENSORS_DATA_FIELD_MAGNETOMETER_ACCURACY              = cast(ushort) 0x0488,
    HID_USAGE_SENSORS_DATA_FIELD_SIMPLE_ORIENTATION_DIRECTION       = cast(ushort) 0x0489,
    HID_USAGE_SENSORS_DATA_FIELD_MECHANICAL                         = cast(ushort) 0x0490,
    HID_USAGE_SENSORS_DATA_FIELD_BOOLEAN_SWITCH_STATE               = cast(ushort) 0x0491,
    HID_USAGE_SENSORS_DATA_FIELD_BOOLEAN_SWITCH_ARRAY_STATES        = cast(ushort) 0x0492,
    HID_USAGE_SENSORS_DATA_FIELD_MULTIVALUE_SWITCH_VALUE            = cast(ushort) 0x0493,
    HID_USAGE_SENSORS_DATA_FIELD_FORCE                              = cast(ushort) 0x0494,
    HID_USAGE_SENSORS_DATA_FIELD_ABSOLUTE_PRESSURE                  = cast(ushort) 0x0495,
    HID_USAGE_SENSORS_DATA_FIELD_GAUGE_PRESSURE                     = cast(ushort) 0x0496,
    HID_USAGE_SENSORS_DATA_FIELD_STRAIN                             = cast(ushort) 0x0497,
    HID_USAGE_SENSORS_DATA_FIELD_WEIGHT                             = cast(ushort) 0x0498,
    HID_USAGE_SENSORS_PROPERTY_MECHANICAL                           = cast(ushort) 0x04a0,
    HID_USAGE_SENSORS_PROPERTY_VIBRATION_STATE                      = cast(ushort) 0x04a1,
    HID_USAGE_SENSORS_PROPERTY_FORWARD_VIBRATION_SPEED              = cast(ushort) 0x04a2,
    HID_USAGE_SENSORS_PROPERTY_BACKWARD_VIBRATION_SPEED             = cast(ushort) 0x04a3,
}

enum : ushort
{
    HID_USAGE_SENSORS_DATA_FIELD_BIOMETRIC                    = cast(ushort) 0x04b0,
    HID_USAGE_SENSORS_DATA_FIELD_HUMAN_PRESENCE               = cast(ushort) 0x04b1,
    HID_USAGE_SENSORS_DATA_FIELD_HUMAN_PROXIMITY_RANGE        = cast(ushort) 0x04b2,
    HID_USAGE_SENSORS_DATA_FIELD_HUMAN_PROXIMITY_OUT_OF_RANGE = cast(ushort) 0x04b3,
    HID_USAGE_SENSORS_DATA_FIELD_HUMAN_TOUCH_STATE            = cast(ushort) 0x04b4,
    HID_USAGE_SENSORS_DATA_FIELD_BLOOD_PRESSURE               = cast(ushort) 0x04b5,
    HID_USAGE_SENSORS_DATA_FIELD_BLOOD_PRESSURE_DIASTOLIC     = cast(ushort) 0x04b6,
    HID_USAGE_SENSORS_DATA_FIELD_BLOOD_PRESSURE_SYSTOLIC      = cast(ushort) 0x04b7,
    HID_USAGE_SENSORS_DATA_FIELD_HEART_RATE                   = cast(ushort) 0x04b8,
    HID_USAGE_SENSORS_DATA_FIELD_RESTING_HEART_RATE           = cast(ushort) 0x04b9,
    HID_USAGE_SENSORS_DATA_FIELD_HEARTBEAT_INTERVAL           = cast(ushort) 0x04ba,
    HID_USAGE_SENSORS_DATA_FIELD_RESPIRATORY_RATE             = cast(ushort) 0x04bb,
    HID_USAGE_SENSORS_DATA_FIELD_SPO2                         = cast(ushort) 0x04bc,
    HID_USAGE_SENSORS_DATA_FIELD_HUMAN_ATTENTION_DETECTED     = cast(ushort) 0x04bd,
    HID_USAGE_SENSORS_DATA_FIELD_HUMAN_HEAD_AZIMUTH           = cast(ushort) 0x04be,
    HID_USAGE_SENSORS_DATA_FIELD_HUMAN_HEAD_ALTITUDE          = cast(ushort) 0x04bf,
    HID_USAGE_SENSORS_DATA_FIELD_HUMAN_HEAD_ROLL              = cast(ushort) 0x04c0,
    HID_USAGE_SENSORS_DATA_FIELD_HUMAN_HEAD_PITCH             = cast(ushort) 0x04c1,
    HID_USAGE_SENSORS_DATA_FIELD_HUMAN_HEAD_YAW               = cast(ushort) 0x04c2,
    HID_USAGE_SENSORS_DATA_FIELD_HUMAN_CORRELATION_ID         = cast(ushort) 0x04c3,
    HID_USAGE_SENSORS_DATA_FIELD_LIGHT                        = cast(ushort) 0x04d0,
    HID_USAGE_SENSORS_DATA_FIELD_ILLUMINANCE                  = cast(ushort) 0x04d1,
    HID_USAGE_SENSORS_DATA_FIELD_COLOR_TEMPERATURE            = cast(ushort) 0x04d2,
    HID_USAGE_SENSORS_DATA_FIELD_CHROMATICITY                 = cast(ushort) 0x04d3,
    HID_USAGE_SENSORS_DATA_FIELD_CHROMATICITY_X               = cast(ushort) 0x04d4,
    HID_USAGE_SENSORS_DATA_FIELD_CHROMATICITY_Y               = cast(ushort) 0x04d5,
    HID_USAGE_SENSORS_DATA_FIELD_CONSUMER_IR_SENTENCE_RECEIVE = cast(ushort) 0x04d6,
    HID_USAGE_SENSORS_DATA_FIELD_INFRARED_LIGHT               = cast(ushort) 0x04d7,
    HID_USAGE_SENSORS_DATA_FIELD_RED_LIGHT                    = cast(ushort) 0x04d8,
    HID_USAGE_SENSORS_DATA_FIELD_GREEN_LIGHT                  = cast(ushort) 0x04d9,
    HID_USAGE_SENSORS_DATA_FIELD_BLUE_LIGHT                   = cast(ushort) 0x04da,
    HID_USAGE_SENSORS_DATA_FIELD_ULTRAVIOLET_A_LIGHT          = cast(ushort) 0x04db,
    HID_USAGE_SENSORS_DATA_FIELD_ULTRAVIOLET_B_LIGHT          = cast(ushort) 0x04dc,
    HID_USAGE_SENSORS_DATA_FIELD_ULTRAVIOLET_INDEX            = cast(ushort) 0x04dd,
    HID_USAGE_SENSORS_DATA_FIELD_NEAR_INFRARED_LIGHT          = cast(ushort) 0x04de,
}

enum : ushort
{
    HID_USAGE_SENSORS_PROPERTY_LIGHT                     = cast(ushort) 0x04df,
    HID_USAGE_SENSORS_PROPERTY_CONSUMER_IR_SENTENCE_SEND = cast(ushort) 0x04e0,
    HID_USAGE_SENSORS_PROPERTY_AUTO_BRIGHTNESS_PREFERRED = cast(ushort) 0x04e2,
    HID_USAGE_SENSORS_PROPERTY_AUTO_COLOR_PREFERRED      = cast(ushort) 0x04e3,
}

enum : ushort
{
    HID_USAGE_SENSORS_DATA_FIELD_SCANNER              = cast(ushort) 0x04f0,
    HID_USAGE_SENSORS_DATA_FIELD_RFID_TAG_40_BIT      = cast(ushort) 0x04f1,
    HID_USAGE_SENSORS_DATA_FIELD_NFC_SENTENCE_RECEIVE = cast(ushort) 0x04f2,
}

enum : ushort
{
    HID_USAGE_SENSORS_PROPERTY_SCANNER                  = cast(ushort) 0x04f8,
    HID_USAGE_SENSORS_PROPERTY_NFC_SENTENCE_SEND        = cast(ushort) 0x04f9,
    HID_USAGE_SENSORS_DATA_FIELD_ELECTRICAL             = cast(ushort) 0x0500,
    HID_USAGE_SENSORS_DATA_FIELD_CAPACITANCE            = cast(ushort) 0x0501,
    HID_USAGE_SENSORS_DATA_FIELD_CURRENT                = cast(ushort) 0x0502,
    HID_USAGE_SENSORS_DATA_FIELD_ELECTRICAL_POWER       = cast(ushort) 0x0503,
    HID_USAGE_SENSORS_DATA_FIELD_INDUCTANCE             = cast(ushort) 0x0504,
    HID_USAGE_SENSORS_DATA_FIELD_RESISTANCE             = cast(ushort) 0x0505,
    HID_USAGE_SENSORS_DATA_FIELD_VOLTAGE                = cast(ushort) 0x0506,
    HID_USAGE_SENSORS_DATA_FIELD_FREQUENCY              = cast(ushort) 0x0507,
    HID_USAGE_SENSORS_DATA_FIELD_PERIOD                 = cast(ushort) 0x0508,
    HID_USAGE_SENSORS_DATA_FIELD_PERCENT_OF_RANGE       = cast(ushort) 0x0509,
    HID_USAGE_SENSORS_DATA_FIELD_TIME                   = cast(ushort) 0x0520,
    HID_USAGE_SENSORS_DATA_FIELD_YEAR                   = cast(ushort) 0x0521,
    HID_USAGE_SENSORS_DATA_FIELD_MONTH                  = cast(ushort) 0x0522,
    HID_USAGE_SENSORS_DATA_FIELD_DAY                    = cast(ushort) 0x0523,
    HID_USAGE_SENSORS_DATA_FIELD_DAY_OF_WEEK            = cast(ushort) 0x0524,
    HID_USAGE_SENSORS_DATA_FIELD_HOUR                   = cast(ushort) 0x0525,
    HID_USAGE_SENSORS_DATA_FIELD_MINUTE                 = cast(ushort) 0x0526,
    HID_USAGE_SENSORS_DATA_FIELD_SECOND                 = cast(ushort) 0x0527,
    HID_USAGE_SENSORS_DATA_FIELD_MILLISECOND            = cast(ushort) 0x0528,
    HID_USAGE_SENSORS_DATA_FIELD_TIMESTAMP              = cast(ushort) 0x0529,
    HID_USAGE_SENSORS_DATA_FIELD_JULIAN_DAY_OF_YEAR     = cast(ushort) 0x052a,
    HID_USAGE_SENSORS_DATA_FIELD_TIME_SINCE_SYSTEM_BOOT = cast(ushort) 0x052b,
}

enum : ushort
{
    HID_USAGE_SENSORS_PROPERTY_TIME                                 = cast(ushort) 0x0530,
    HID_USAGE_SENSORS_PROPERTY_TIME_ZONE_OFFSET_FROM_UTC            = cast(ushort) 0x0531,
    HID_USAGE_SENSORS_PROPERTY_TIME_ZONE_NAME                       = cast(ushort) 0x0532,
    HID_USAGE_SENSORS_PROPERTY_DAYLIGHT_SAVINGS_TIME_OBSERVED       = cast(ushort) 0x0533,
    HID_USAGE_SENSORS_PROPERTY_TIME_TRIM_ADJUSTMENT                 = cast(ushort) 0x0534,
    HID_USAGE_SENSORS_PROPERTY_ARM_ALARM                            = cast(ushort) 0x0535,
    HID_USAGE_SENSORS_DATA_FIELD_CUSTOM                             = cast(ushort) 0x0540,
    HID_USAGE_SENSORS_DATA_FIELD_CUSTOM_USAGE                       = cast(ushort) 0x0541,
    HID_USAGE_SENSORS_DATA_FIELD_CUSTOM_BOOLEAN_ARRAY               = cast(ushort) 0x0542,
    HID_USAGE_SENSORS_DATA_FIELD_CUSTOM_VALUE                       = cast(ushort) 0x0543,
    HID_USAGE_SENSORS_DATA_FIELD_CUSTOM_VALUE_1                     = cast(ushort) 0x0544,
    HID_USAGE_SENSORS_DATA_FIELD_CUSTOM_VALUE_2                     = cast(ushort) 0x0545,
    HID_USAGE_SENSORS_DATA_FIELD_CUSTOM_VALUE_3                     = cast(ushort) 0x0546,
    HID_USAGE_SENSORS_DATA_FIELD_CUSTOM_VALUE_4                     = cast(ushort) 0x0547,
    HID_USAGE_SENSORS_DATA_FIELD_CUSTOM_VALUE_5                     = cast(ushort) 0x0548,
    HID_USAGE_SENSORS_DATA_FIELD_CUSTOM_VALUE_6                     = cast(ushort) 0x0549,
    HID_USAGE_SENSORS_DATA_FIELD_CUSTOM_VALUE_7                     = cast(ushort) 0x054a,
    HID_USAGE_SENSORS_DATA_FIELD_CUSTOM_VALUE_8                     = cast(ushort) 0x054b,
    HID_USAGE_SENSORS_DATA_FIELD_CUSTOM_VALUE_9                     = cast(ushort) 0x054c,
    HID_USAGE_SENSORS_DATA_FIELD_CUSTOM_VALUE_10                    = cast(ushort) 0x054d,
    HID_USAGE_SENSORS_DATA_FIELD_CUSTOM_VALUE_11                    = cast(ushort) 0x054e,
    HID_USAGE_SENSORS_DATA_FIELD_CUSTOM_VALUE_12                    = cast(ushort) 0x054f,
    HID_USAGE_SENSORS_DATA_FIELD_CUSTOM_VALUE_13                    = cast(ushort) 0x0550,
    HID_USAGE_SENSORS_DATA_FIELD_CUSTOM_VALUE_14                    = cast(ushort) 0x0551,
    HID_USAGE_SENSORS_DATA_FIELD_CUSTOM_VALUE_15                    = cast(ushort) 0x0552,
    HID_USAGE_SENSORS_DATA_FIELD_CUSTOM_VALUE_16                    = cast(ushort) 0x0553,
    HID_USAGE_SENSORS_DATA_FIELD_CUSTOM_VALUE_17                    = cast(ushort) 0x0554,
    HID_USAGE_SENSORS_DATA_FIELD_CUSTOM_VALUE_18                    = cast(ushort) 0x0555,
    HID_USAGE_SENSORS_DATA_FIELD_CUSTOM_VALUE_19                    = cast(ushort) 0x0556,
    HID_USAGE_SENSORS_DATA_FIELD_CUSTOM_VALUE_20                    = cast(ushort) 0x0557,
    HID_USAGE_SENSORS_DATA_FIELD_CUSTOM_VALUE_21                    = cast(ushort) 0x0558,
    HID_USAGE_SENSORS_DATA_FIELD_CUSTOM_VALUE_22                    = cast(ushort) 0x0559,
    HID_USAGE_SENSORS_DATA_FIELD_CUSTOM_VALUE_23                    = cast(ushort) 0x055a,
    HID_USAGE_SENSORS_DATA_FIELD_CUSTOM_VALUE_24                    = cast(ushort) 0x055b,
    HID_USAGE_SENSORS_DATA_FIELD_CUSTOM_VALUE_25                    = cast(ushort) 0x055c,
    HID_USAGE_SENSORS_DATA_FIELD_CUSTOM_VALUE_26                    = cast(ushort) 0x055d,
    HID_USAGE_SENSORS_DATA_FIELD_CUSTOM_VALUE_27                    = cast(ushort) 0x055e,
    HID_USAGE_SENSORS_DATA_FIELD_CUSTOM_VALUE_28                    = cast(ushort) 0x055f,
    HID_USAGE_SENSORS_DATA_FIELD_GENERIC                            = cast(ushort) 0x0560,
    HID_USAGE_SENSORS_DATA_FIELD_GENERIC_GUID_OR_PROPERTYKEY        = cast(ushort) 0x0561,
    HID_USAGE_SENSORS_DATA_FIELD_GENERIC_CATEGORY_GUID              = cast(ushort) 0x0562,
    HID_USAGE_SENSORS_DATA_FIELD_GENERIC_TYPE_GUID                  = cast(ushort) 0x0563,
    HID_USAGE_SENSORS_DATA_FIELD_GENERIC_EVENT_PROPERTYKEY          = cast(ushort) 0x0564,
    HID_USAGE_SENSORS_DATA_FIELD_GENERIC_PROPERTY_PROPERTYKEY       = cast(ushort) 0x0565,
    HID_USAGE_SENSORS_DATA_FIELD_GENERIC_DATA_FIELD_PROPERTYKEY     = cast(ushort) 0x0566,
    HID_USAGE_SENSORS_DATA_FIELD_GENERIC_EVENT                      = cast(ushort) 0x0567,
    HID_USAGE_SENSORS_DATA_FIELD_GENERIC_PROPERTY                   = cast(ushort) 0x0568,
    HID_USAGE_SENSORS_DATA_FIELD_GENERIC_DATA_FIELD                 = cast(ushort) 0x0569,
    HID_USAGE_SENSORS_DATA_FIELD_ENUMERATOR_TABLE_ROW_INDEX         = cast(ushort) 0x056a,
    HID_USAGE_SENSORS_DATA_FIELD_ENUMERATOR_TABLE_ROW_COUNT         = cast(ushort) 0x056b,
    HID_USAGE_SENSORS_DATA_FIELD_GENERIC_GUID_OR_PROPERTYKEY_KIND   = cast(ushort) 0x056c,
    HID_USAGE_SENSORS_DATA_FIELD_GENERIC_GUID                       = cast(ushort) 0x056d,
    HID_USAGE_SENSORS_DATA_FIELD_GENERIC_PROPERTYKEY                = cast(ushort) 0x056e,
    HID_USAGE_SENSORS_DATA_FIELD_GENERIC_TOP_LEVEL_COLLECTION_ID    = cast(ushort) 0x056f,
    HID_USAGE_SENSORS_DATA_FIELD_GENERIC_REPORT_ID                  = cast(ushort) 0x0570,
    HID_USAGE_SENSORS_DATA_FIELD_GENERIC_REPORT_ITEM_POSITION_INDEX = cast(ushort) 0x0571,
    HID_USAGE_SENSORS_DATA_FIELD_GENERIC_FIRMWARE_VARTYPE           = cast(ushort) 0x0572,
    HID_USAGE_SENSORS_DATA_FIELD_GENERIC_UNIT_OF_MEASURE            = cast(ushort) 0x0573,
    HID_USAGE_SENSORS_DATA_FIELD_GENERIC_UNIT_EXPONENT              = cast(ushort) 0x0574,
    HID_USAGE_SENSORS_DATA_FIELD_GENERIC_REPORT_SIZE                = cast(ushort) 0x0575,
    HID_USAGE_SENSORS_DATA_FIELD_GENERIC_REPORT_COUNT               = cast(ushort) 0x0576,
}

enum : ushort
{
    HID_USAGE_SENSORS_PROPERTY_GENERIC                    = cast(ushort) 0x0580,
    HID_USAGE_SENSORS_PROPERTY_ENUMERATOR_TABLE_ROW_INDEX = cast(ushort) 0x0581,
    HID_USAGE_SENSORS_PROPERTY_ENUMERATOR_TABLE_ROW_COUNT = cast(ushort) 0x0582,
}

enum : ushort
{
    HID_USAGE_SENSORS_DATA_FIELD_PERSONAL_ACTIVITY                 = cast(ushort) 0x0590,
    HID_USAGE_SENSORS_DATA_FIELD_ACTIVITY_TYPE                     = cast(ushort) 0x0591,
    HID_USAGE_SENSORS_DATA_FIELD_ACTIVITY_STATE                    = cast(ushort) 0x0592,
    HID_USAGE_SENSORS_DATA_FIELD_DEVICE_POSITION                   = cast(ushort) 0x0593,
    HID_USAGE_SENSORS_DATA_FIELD_STEP_COUNT                        = cast(ushort) 0x0594,
    HID_USAGE_SENSORS_DATA_FIELD_STEP_COUNT_RESET                  = cast(ushort) 0x0595,
    HID_USAGE_SENSORS_DATA_FIELD_STEP_DURATION                     = cast(ushort) 0x0596,
    HID_USAGE_SENSORS_DATA_FIELD_STEP_TYPE                         = cast(ushort) 0x0597,
    HID_USAGE_SENSORS_PROPERTY_MINIMUM_ACTIVITY_DETECTION_INTERVAL = cast(ushort) 0x05a0,
    HID_USAGE_SENSORS_PROPERTY_SUPPORTED_ACTIVITY_TYPES            = cast(ushort) 0x05a1,
    HID_USAGE_SENSORS_PROPERTY_SUBSCRIBED_ACTIVITY_TYPES           = cast(ushort) 0x05a2,
    HID_USAGE_SENSORS_PROPERTY_SUPPORTED_STEP_TYPES                = cast(ushort) 0x05a3,
    HID_USAGE_SENSORS_PROPERTY_SUBSCRIBED_STEP_TYPES               = cast(ushort) 0x05a4,
    HID_USAGE_SENSORS_PROPERTY_FLOOR_HEIGHT                        = cast(ushort) 0x05a5,
    HID_USAGE_SENSORS_DATA_FIELD_CUSTOM_TYPE_ID                    = cast(ushort) 0x05b0,
    HID_USAGE_SENSORS_PROPERTY_CUSTOM                              = cast(ushort) 0x05c0,
    HID_USAGE_SENSORS_PROPERTY_CUSTOM_VALUE_1                      = cast(ushort) 0x05c1,
    HID_USAGE_SENSORS_PROPERTY_CUSTOM_VALUE_2                      = cast(ushort) 0x05c2,
    HID_USAGE_SENSORS_PROPERTY_CUSTOM_VALUE_3                      = cast(ushort) 0x05c3,
    HID_USAGE_SENSORS_PROPERTY_CUSTOM_VALUE_4                      = cast(ushort) 0x05c4,
    HID_USAGE_SENSORS_PROPERTY_CUSTOM_VALUE_5                      = cast(ushort) 0x05c5,
    HID_USAGE_SENSORS_PROPERTY_CUSTOM_VALUE_6                      = cast(ushort) 0x05c6,
    HID_USAGE_SENSORS_PROPERTY_CUSTOM_VALUE_7                      = cast(ushort) 0x05c7,
    HID_USAGE_SENSORS_PROPERTY_CUSTOM_VALUE_8                      = cast(ushort) 0x05c8,
    HID_USAGE_SENSORS_PROPERTY_CUSTOM_VALUE_9                      = cast(ushort) 0x05c9,
    HID_USAGE_SENSORS_PROPERTY_CUSTOM_VALUE_10                     = cast(ushort) 0x05ca,
    HID_USAGE_SENSORS_PROPERTY_CUSTOM_VALUE_11                     = cast(ushort) 0x05cb,
    HID_USAGE_SENSORS_PROPERTY_CUSTOM_VALUE_12                     = cast(ushort) 0x05cc,
    HID_USAGE_SENSORS_PROPERTY_CUSTOM_VALUE_13                     = cast(ushort) 0x05cd,
    HID_USAGE_SENSORS_PROPERTY_CUSTOM_VALUE_14                     = cast(ushort) 0x05ce,
    HID_USAGE_SENSORS_PROPERTY_CUSTOM_VALUE_15                     = cast(ushort) 0x05cf,
    HID_USAGE_SENSORS_PROPERTY_CUSTOM_VALUE_16                     = cast(ushort) 0x05d0,
    HID_USAGE_SENSORS_DATA_FIELD_HINGE                             = cast(ushort) 0x05e0,
    HID_USAGE_SENSORS_DATA_FIELD_HINGE_ANGLE                       = cast(ushort) 0x05e1,
    HID_USAGE_SENSORS_DATA_FIELD_GESTURE_SENSOR                    = cast(ushort) 0x05f0,
    HID_USAGE_SENSORS_DATA_FIELD_GESTURE_STATE                     = cast(ushort) 0x05f1,
    HID_USAGE_SENSORS_DATA_FIELD_HINGE_FOLD_INITIAL_ANGLE          = cast(ushort) 0x05f2,
    HID_USAGE_SENSORS_DATA_FIELD_HINGE_FOLD_FINAL_ANGLE            = cast(ushort) 0x05f3,
    HID_USAGE_SENSORS_DATA_FIELD_HINGE_FOLD_CONTRIBUTING_PANEL     = cast(ushort) 0x05f4,
    HID_USAGE_SENSORS_DATA_FIELD_HINGE_FOLD_TYPE                   = cast(ushort) 0x05f5,
    HID_USAGE_SENSORS_SENSOR_STATE_UNDEFINED                       = cast(ushort) 0x0800,
    HID_USAGE_SENSORS_SENSOR_STATE_READY                           = cast(ushort) 0x0801,
    HID_USAGE_SENSORS_SENSOR_STATE_NOT_AVAILABLE                   = cast(ushort) 0x0802,
    HID_USAGE_SENSORS_SENSOR_STATE_NO_DATA                         = cast(ushort) 0x0803,
    HID_USAGE_SENSORS_SENSOR_STATE_INITIALIZING                    = cast(ushort) 0x0804,
    HID_USAGE_SENSORS_SENSOR_STATE_ACCESS_DENIED                   = cast(ushort) 0x0805,
    HID_USAGE_SENSORS_SENSOR_STATE_ERROR                           = cast(ushort) 0x0806,
    HID_USAGE_SENSORS_SENSOR_EVENT_UNKNOWN                         = cast(ushort) 0x0810,
    HID_USAGE_SENSORS_SENSOR_EVENT_STATE_CHANGED                   = cast(ushort) 0x0811,
    HID_USAGE_SENSORS_SENSOR_EVENT_PROPERTY_CHANGED                = cast(ushort) 0x0812,
    HID_USAGE_SENSORS_SENSOR_EVENT_DATA_UPDATED                    = cast(ushort) 0x0813,
    HID_USAGE_SENSORS_SENSOR_EVENT_POLL_RESPONSE                   = cast(ushort) 0x0814,
    HID_USAGE_SENSORS_SENSOR_EVENT_CHANGE_SENSITIVITY              = cast(ushort) 0x0815,
    HID_USAGE_SENSORS_SENSOR_EVENT_RANGE_MAXIMUM_REACHED           = cast(ushort) 0x0816,
    HID_USAGE_SENSORS_SENSOR_EVENT_RANGE_MINIMUM_REACHED           = cast(ushort) 0x0817,
    HID_USAGE_SENSORS_SENSOR_EVENT_HIGH_THRESHOLD_CROSS_UPWARD     = cast(ushort) 0x0818,
    HID_USAGE_SENSORS_SENSOR_EVENT_HIGH_THRESHOLD_CROSS_DOWNWARD   = cast(ushort) 0x0819,
    HID_USAGE_SENSORS_SENSOR_EVENT_LOW_THRESHOLD_CROSS_UPWARD      = cast(ushort) 0x081a,
    HID_USAGE_SENSORS_SENSOR_EVENT_LOW_THRESHOLD_CROSS_DOWNWARD    = cast(ushort) 0x081b,
    HID_USAGE_SENSORS_SENSOR_EVENT_ZERO_THRESHOLD_CROSS_UPWARD     = cast(ushort) 0x081c,
    HID_USAGE_SENSORS_SENSOR_EVENT_ZERO_THRESHOLD_CROSS_DOWNWARD   = cast(ushort) 0x081d,
    HID_USAGE_SENSORS_SENSOR_EVENT_PERIOD_EXCEEDED                 = cast(ushort) 0x081e,
    HID_USAGE_SENSORS_SENSOR_EVENT_FREQUENCY_EXCEEDED              = cast(ushort) 0x081f,
    HID_USAGE_SENSORS_SENSOR_EVENT_COMPLEX_TRIGGER                 = cast(ushort) 0x0820,
}

enum : ushort
{
    HID_USAGE_SENSORS_CONNECTION_TYPE_PC_INTEGRATED = cast(ushort) 0x0830,
    HID_USAGE_SENSORS_CONNECTION_TYPE_PC_ATTACHED   = cast(ushort) 0x0831,
    HID_USAGE_SENSORS_CONNECTION_TYPE_PC_EXTERNAL   = cast(ushort) 0x0832,
}

enum : ushort
{
    HID_USAGE_SENSORS_REPORTING_STATE_REPORT_NO_EVENTS         = cast(ushort) 0x0840,
    HID_USAGE_SENSORS_REPORTING_STATE_REPORT_ALL_EVENTS        = cast(ushort) 0x0841,
    HID_USAGE_SENSORS_REPORTING_STATE_REPORT_THRESHOLD_EVENTS  = cast(ushort) 0x0842,
    HID_USAGE_SENSORS_REPORTING_STATE_WAKE_ON_NO_EVENTS        = cast(ushort) 0x0843,
    HID_USAGE_SENSORS_REPORTING_STATE_WAKE_ON_ALL_EVENTS       = cast(ushort) 0x0844,
    HID_USAGE_SENSORS_REPORTING_STATE_WAKE_ON_THRESHOLD_EVENTS = cast(ushort) 0x0845,
    HID_USAGE_SENSORS_REPORTING_STATE_ANYTIME_SEL              = cast(ushort) 0x0846,
}

enum : ushort
{
    HID_USAGE_SENSORS_POWER_STATE_UNDEFINED                                = cast(ushort) 0x0850,
    HID_USAGE_SENSORS_POWER_STATE_D0_FULL_POWER                            = cast(ushort) 0x0851,
    HID_USAGE_SENSORS_POWER_STATE_D1_LOW_POWER                             = cast(ushort) 0x0852,
    HID_USAGE_SENSORS_POWER_STATE_D2_STANDBY_POWER_WITH_WAKEUP             = cast(ushort) 0x0853,
    HID_USAGE_SENSORS_POWER_STATE_D3_SLEEP_WITH_WAKEUP                     = cast(ushort) 0x0854,
    HID_USAGE_SENSORS_POWER_STATE_D4_POWER_OFF                             = cast(ushort) 0x0855,
    HID_USAGE_SENSORS_ACCURACY_DEFAULT                                     = cast(ushort) 0x0860,
    HID_USAGE_SENSORS_ACCURACY_HIGH                                        = cast(ushort) 0x0861,
    HID_USAGE_SENSORS_ACCURACY_MEDIUM                                      = cast(ushort) 0x0862,
    HID_USAGE_SENSORS_ACCURACY_LOW                                         = cast(ushort) 0x0863,
    HID_USAGE_SENSORS_FIX_QUALITY_NO_FIX                                   = cast(ushort) 0x0870,
    HID_USAGE_SENSORS_FIX_QUALITY_GPS                                      = cast(ushort) 0x0871,
    HID_USAGE_SENSORS_FIX_QUALITY_DGPS                                     = cast(ushort) 0x0872,
    HID_USAGE_SENSORS_FIX_TYPE_NO_FIX                                      = cast(ushort) 0x0880,
    HID_USAGE_SENSORS_FIX_TYPE_GPS_SPS_MODE_FIX_VALID                      = cast(ushort) 0x0881,
    HID_USAGE_SENSORS_FIX_TYPE_DGPS_SPS_MODE_FIX_VALID                     = cast(ushort) 0x0882,
    HID_USAGE_SENSORS_FIX_TYPE_GPS_PPS_MODE_FIX_VALID                      = cast(ushort) 0x0883,
    HID_USAGE_SENSORS_FIX_TYPE_REAL_TIME_KINEMATIC                         = cast(ushort) 0x0884,
    HID_USAGE_SENSORS_FIX_TYPE_FLOAT_RTK                                   = cast(ushort) 0x0885,
    HID_USAGE_SENSORS_FIX_TYPE_ESTIMATED_DEAD_RECKONED                     = cast(ushort) 0x0886,
    HID_USAGE_SENSORS_FIX_TYPE_MANUAL_INPUT_MODE                           = cast(ushort) 0x0887,
    HID_USAGE_SENSORS_FIX_TYPE_SIMULATOR_MODE                              = cast(ushort) 0x0888,
    HID_USAGE_SENSORS_GPS_OPERATION_MODE_MANUAL                            = cast(ushort) 0x0890,
    HID_USAGE_SENSORS_GPS_OPERATION_MODE_AUTOMATIC                         = cast(ushort) 0x0891,
    HID_USAGE_SENSORS_GPS_SELECTION_MODE_AUTONOMOUS                        = cast(ushort) 0x08a0,
    HID_USAGE_SENSORS_GPS_SELECTION_MODE_DGPS                              = cast(ushort) 0x08a1,
    HID_USAGE_SENSORS_GPS_SELECTION_MODE_ESTIMATED_DEAD_RECKONED           = cast(ushort) 0x08a2,
    HID_USAGE_SENSORS_GPS_SELECTION_MODE_MANUAL_INPUT                      = cast(ushort) 0x08a3,
    HID_USAGE_SENSORS_GPS_SELECTION_MODE_SIMULATOR                         = cast(ushort) 0x08a4,
    HID_USAGE_SENSORS_GPS_SELECTION_MODE_DATA_NOT_VALID                    = cast(ushort) 0x08a5,
    HID_USAGE_SENSORS_GPS_STATUS_DATA_VALID                                = cast(ushort) 0x08b0,
    HID_USAGE_SENSORS_GPS_STATUS_DATA_NOT_VALID                            = cast(ushort) 0x08b1,
    HID_USAGE_SENSORS_DAY_OF_WEEK_SUNDAY                                   = cast(ushort) 0x08c0,
    HID_USAGE_SENSORS_DAY_OF_WEEK_MONDAY                                   = cast(ushort) 0x08c1,
    HID_USAGE_SENSORS_DAY_OF_WEEK_TUESDAY                                  = cast(ushort) 0x08c2,
    HID_USAGE_SENSORS_DAY_OF_WEEK_WEDNESDAY                                = cast(ushort) 0x08c3,
    HID_USAGE_SENSORS_DAY_OF_WEEK_THURSDAY                                 = cast(ushort) 0x08c4,
    HID_USAGE_SENSORS_DAY_OF_WEEK_FRIDAY                                   = cast(ushort) 0x08c5,
    HID_USAGE_SENSORS_DAY_OF_WEEK_SATURDAY                                 = cast(ushort) 0x08c6,
    HID_USAGE_SENSORS_KIND_CATEGORY                                        = cast(ushort) 0x08d0,
    HID_USAGE_SENSORS_KIND_TYPE                                            = cast(ushort) 0x08d1,
    HID_USAGE_SENSORS_KIND_EVENT                                           = cast(ushort) 0x08d2,
    HID_USAGE_SENSORS_KIND_PROPERTY                                        = cast(ushort) 0x08d3,
    HID_USAGE_SENSORS_KIND_DATA_FIELD                                      = cast(ushort) 0x08d4,
    HID_USAGE_SENSORS_MAGNETOMETER_ACCURACY_LOW                            = cast(ushort) 0x08e0,
    HID_USAGE_SENSORS_MAGNETOMETER_ACCURACY_MEDIUM                         = cast(ushort) 0x08e1,
    HID_USAGE_SENSORS_MAGNETOMETER_ACCURACY_HIGH                           = cast(ushort) 0x08e2,
    HID_USAGE_SENSORS_SIMPLE_ORIENTATION_DIRECTION_NOT_ROTATED             = cast(ushort) 0x08f0,
    HID_USAGE_SENSORS_SIMPLE_ORIENTATION_DIRECTION_ROTATED_90_DEGREES_CCW  = cast(ushort) 0x08f1,
    HID_USAGE_SENSORS_SIMPLE_ORIENTATION_DIRECTION_ROTATED_180_DEGREES_CCW = cast(ushort) 0x08f2,
    HID_USAGE_SENSORS_SIMPLE_ORIENTATION_DIRECTION_ROTATED_270_DEGREES_CCW = cast(ushort) 0x08f3,
    HID_USAGE_SENSORS_SIMPLE_ORIENTATION_DIRECTION_FACE_UP                 = cast(ushort) 0x08f4,
    HID_USAGE_SENSORS_SIMPLE_ORIENTATION_DIRECTION_FACE_DOWN               = cast(ushort) 0x08f5,
}

enum : ushort
{
    HID_USAGE_SENSORS_VT_NULL                        = cast(ushort) 0x0900,
    HID_USAGE_SENSORS_VT_BOOL                        = cast(ushort) 0x0901,
    HID_USAGE_SENSORS_VT_UI1                         = cast(ushort) 0x0902,
    HID_USAGE_SENSORS_VT_I1                          = cast(ushort) 0x0903,
    HID_USAGE_SENSORS_VT_UI2                         = cast(ushort) 0x0904,
    HID_USAGE_SENSORS_VT_I2                          = cast(ushort) 0x0905,
    HID_USAGE_SENSORS_VT_UI4                         = cast(ushort) 0x0906,
    HID_USAGE_SENSORS_VT_I4                          = cast(ushort) 0x0907,
    HID_USAGE_SENSORS_VT_UI8                         = cast(ushort) 0x0908,
    HID_USAGE_SENSORS_VT_I8                          = cast(ushort) 0x0909,
    HID_USAGE_SENSORS_VT_R4                          = cast(ushort) 0x090a,
    HID_USAGE_SENSORS_VT_R8                          = cast(ushort) 0x090b,
    HID_USAGE_SENSORS_VT_WSTR                        = cast(ushort) 0x090c,
    HID_USAGE_SENSORS_VT_STR                         = cast(ushort) 0x090d,
    HID_USAGE_SENSORS_VT_CLSID                       = cast(ushort) 0x090e,
    HID_USAGE_SENSORS_VT_VECTOR_VT_UI1               = cast(ushort) 0x090f,
    HID_USAGE_SENSORS_VT_F16E0                       = cast(ushort) 0x0910,
    HID_USAGE_SENSORS_VT_F16E1                       = cast(ushort) 0x0911,
    HID_USAGE_SENSORS_VT_F16E2                       = cast(ushort) 0x0912,
    HID_USAGE_SENSORS_VT_F16E3                       = cast(ushort) 0x0913,
    HID_USAGE_SENSORS_VT_F16E4                       = cast(ushort) 0x0914,
    HID_USAGE_SENSORS_VT_F16E5                       = cast(ushort) 0x0915,
    HID_USAGE_SENSORS_VT_F16E6                       = cast(ushort) 0x0916,
    HID_USAGE_SENSORS_VT_F16E7                       = cast(ushort) 0x0917,
    HID_USAGE_SENSORS_VT_F16E8                       = cast(ushort) 0x0918,
    HID_USAGE_SENSORS_VT_F16E9                       = cast(ushort) 0x0919,
    HID_USAGE_SENSORS_VT_F16EA                       = cast(ushort) 0x091a,
    HID_USAGE_SENSORS_VT_F16EB                       = cast(ushort) 0x091b,
    HID_USAGE_SENSORS_VT_F16EC                       = cast(ushort) 0x091c,
    HID_USAGE_SENSORS_VT_F16ED                       = cast(ushort) 0x091d,
    HID_USAGE_SENSORS_VT_F16EE                       = cast(ushort) 0x091e,
    HID_USAGE_SENSORS_VT_F16EF                       = cast(ushort) 0x091f,
    HID_USAGE_SENSORS_VT_F32E0                       = cast(ushort) 0x0920,
    HID_USAGE_SENSORS_VT_F32E1                       = cast(ushort) 0x0921,
    HID_USAGE_SENSORS_VT_F32E2                       = cast(ushort) 0x0922,
    HID_USAGE_SENSORS_VT_F32E3                       = cast(ushort) 0x0923,
    HID_USAGE_SENSORS_VT_F32E4                       = cast(ushort) 0x0924,
    HID_USAGE_SENSORS_VT_F32E5                       = cast(ushort) 0x0925,
    HID_USAGE_SENSORS_VT_F32E6                       = cast(ushort) 0x0926,
    HID_USAGE_SENSORS_VT_F32E7                       = cast(ushort) 0x0927,
    HID_USAGE_SENSORS_VT_F32E8                       = cast(ushort) 0x0928,
    HID_USAGE_SENSORS_VT_F32E9                       = cast(ushort) 0x0929,
    HID_USAGE_SENSORS_VT_F32EA                       = cast(ushort) 0x092a,
    HID_USAGE_SENSORS_VT_F32EB                       = cast(ushort) 0x092b,
    HID_USAGE_SENSORS_VT_F32EC                       = cast(ushort) 0x092c,
    HID_USAGE_SENSORS_VT_F32ED                       = cast(ushort) 0x092d,
    HID_USAGE_SENSORS_VT_F32EE                       = cast(ushort) 0x092e,
    HID_USAGE_SENSORS_VT_F32EF                       = cast(ushort) 0x092f,
    HID_USAGE_SENSORS_ACTIVITY_TYPE_UNKNOWN          = cast(ushort) 0x0930,
    HID_USAGE_SENSORS_ACTIVITY_TYPE_STATIONARY       = cast(ushort) 0x0931,
    HID_USAGE_SENSORS_ACTIVITY_TYPE_FIDGETING        = cast(ushort) 0x0932,
    HID_USAGE_SENSORS_ACTIVITY_TYPE_WALKING          = cast(ushort) 0x0933,
    HID_USAGE_SENSORS_ACTIVITY_TYPE_RUNNING          = cast(ushort) 0x0934,
    HID_USAGE_SENSORS_ACTIVITY_TYPE_IN_VEHICLE       = cast(ushort) 0x0935,
    HID_USAGE_SENSORS_ACTIVITY_TYPE_BIKING           = cast(ushort) 0x0936,
    HID_USAGE_SENSORS_ACTIVITY_TYPE_IDLE             = cast(ushort) 0x0937,
    HID_USAGE_SENSORS_UNIT_NOT_SPECIFIED             = cast(ushort) 0x0940,
    HID_USAGE_SENSORS_UNIT_LUX                       = cast(ushort) 0x0941,
    HID_USAGE_SENSORS_UNIT_DEGREES_KELVIN            = cast(ushort) 0x0942,
    HID_USAGE_SENSORS_UNIT_DEGREES_CELSIUS           = cast(ushort) 0x0943,
    HID_USAGE_SENSORS_UNIT_PASCAL                    = cast(ushort) 0x0944,
    HID_USAGE_SENSORS_UNIT_NEWTON                    = cast(ushort) 0x0945,
    HID_USAGE_SENSORS_UNIT_METERSSECOND              = cast(ushort) 0x0946,
    HID_USAGE_SENSORS_UNIT_KILOGRAM                  = cast(ushort) 0x0947,
    HID_USAGE_SENSORS_UNIT_METER                     = cast(ushort) 0x0948,
    HID_USAGE_SENSORS_UNIT_METERSSECONDSECOND        = cast(ushort) 0x0949,
    HID_USAGE_SENSORS_UNIT_FARAD                     = cast(ushort) 0x094a,
    HID_USAGE_SENSORS_UNIT_AMPERE                    = cast(ushort) 0x094b,
    HID_USAGE_SENSORS_UNIT_WATT                      = cast(ushort) 0x094c,
    HID_USAGE_SENSORS_UNIT_HENRY                     = cast(ushort) 0x094d,
    HID_USAGE_SENSORS_UNIT_OHM                       = cast(ushort) 0x094e,
    HID_USAGE_SENSORS_UNIT_VOLT                      = cast(ushort) 0x094f,
    HID_USAGE_SENSORS_UNIT_HERTZ                     = cast(ushort) 0x0950,
    HID_USAGE_SENSORS_UNIT_BAR                       = cast(ushort) 0x0951,
    HID_USAGE_SENSORS_UNIT_DEGREES_ANTICLOCKWISE     = cast(ushort) 0x0952,
    HID_USAGE_SENSORS_UNIT_DEGREES_CLOCKWISE         = cast(ushort) 0x0953,
    HID_USAGE_SENSORS_UNIT_DEGREES                   = cast(ushort) 0x0954,
    HID_USAGE_SENSORS_UNIT_DEGREESSECOND             = cast(ushort) 0x0955,
    HID_USAGE_SENSORS_UNIT_DEGREESSECONDSECOND       = cast(ushort) 0x0956,
    HID_USAGE_SENSORS_UNIT_KNOT                      = cast(ushort) 0x0957,
    HID_USAGE_SENSORS_UNIT_PERCENT                   = cast(ushort) 0x0958,
    HID_USAGE_SENSORS_UNIT_SECOND                    = cast(ushort) 0x0959,
    HID_USAGE_SENSORS_UNIT_MILLISECOND               = cast(ushort) 0x095a,
    HID_USAGE_SENSORS_UNIT_G                         = cast(ushort) 0x095b,
    HID_USAGE_SENSORS_UNIT_BYTES                     = cast(ushort) 0x095c,
    HID_USAGE_SENSORS_UNIT_MILLIGAUSS                = cast(ushort) 0x095d,
    HID_USAGE_SENSORS_UNIT_BITS                      = cast(ushort) 0x095e,
    HID_USAGE_SENSORS_ACTIVITY_STATE_NO_STATE_CHANGE = cast(ushort) 0x0960,
    HID_USAGE_SENSORS_ACTIVITY_STATE_START_ACTIVITY  = cast(ushort) 0x0961,
    HID_USAGE_SENSORS_ACTIVITY_STATE_END_ACTIVITY    = cast(ushort) 0x0962,
}

enum : ushort
{
    HID_USAGE_SENSORS_EXPONENT_0                        = cast(ushort) 0x0970,
    HID_USAGE_SENSORS_EXPONENT_1                        = cast(ushort) 0x0971,
    HID_USAGE_SENSORS_EXPONENT_2                        = cast(ushort) 0x0972,
    HID_USAGE_SENSORS_EXPONENT_3                        = cast(ushort) 0x0973,
    HID_USAGE_SENSORS_EXPONENT_4                        = cast(ushort) 0x0974,
    HID_USAGE_SENSORS_EXPONENT_5                        = cast(ushort) 0x0975,
    HID_USAGE_SENSORS_EXPONENT_6                        = cast(ushort) 0x0976,
    HID_USAGE_SENSORS_EXPONENT_7                        = cast(ushort) 0x0977,
    HID_USAGE_SENSORS_EXPONENT_8                        = cast(ushort) 0x0978,
    HID_USAGE_SENSORS_EXPONENT_9                        = cast(ushort) 0x0979,
    HID_USAGE_SENSORS_EXPONENT_A                        = cast(ushort) 0x097a,
    HID_USAGE_SENSORS_EXPONENT_B                        = cast(ushort) 0x097b,
    HID_USAGE_SENSORS_EXPONENT_C                        = cast(ushort) 0x097c,
    HID_USAGE_SENSORS_EXPONENT_D                        = cast(ushort) 0x097d,
    HID_USAGE_SENSORS_EXPONENT_E                        = cast(ushort) 0x097e,
    HID_USAGE_SENSORS_EXPONENT_F                        = cast(ushort) 0x097f,
    HID_USAGE_SENSORS_DEVICE_POSITION_UNKNOWN           = cast(ushort) 0x0980,
    HID_USAGE_SENSORS_DEVICE_POSITION_UNCHANGED         = cast(ushort) 0x0981,
    HID_USAGE_SENSORS_DEVICE_POSITION_ON_DESK           = cast(ushort) 0x0982,
    HID_USAGE_SENSORS_DEVICE_POSITION_IN_HAND           = cast(ushort) 0x0983,
    HID_USAGE_SENSORS_DEVICE_POSITION_MOVING_IN_BAG     = cast(ushort) 0x0984,
    HID_USAGE_SENSORS_DEVICE_POSITION_STATIONARY_IN_BAG = cast(ushort) 0x0985,
}

enum : ushort
{
    HID_USAGE_SENSORS_STEP_TYPE_UNKNOWN                                        = cast(ushort) 0x0990,
    HID_USAGE_SENSORS_STEP_TYPE_WALKING                                        = cast(ushort) 0x0991,
    HID_USAGE_SENSORS_STEP_TYPE_RUNNING                                        = cast(ushort) 0x0992,
    HID_USAGE_SENSORS_GESTURE_STATE_UNKNOWN                                    = cast(ushort) 0x09a0,
    HID_USAGE_SENSORS_GESTURE_STATE_STARTED                                    = cast(ushort) 0x09a1,
    HID_USAGE_SENSORS_GESTURE_STATE_COMPLETED                                  = cast(ushort) 0x09a2,
    HID_USAGE_SENSORS_GESTURE_STATE_CANCELLED                                  = cast(ushort) 0x09a3,
    HID_USAGE_SENSORS_HINGE_FOLD_CONTRIBUTING_PANEL_UNKNOWN                    = cast(ushort) 0x09b0,
    HID_USAGE_SENSORS_HINGE_FOLD_CONTRIBUTING_PANEL_PANEL_1                    = cast(ushort) 0x09b1,
    HID_USAGE_SENSORS_HINGE_FOLD_CONTRIBUTING_PANEL_PANEL_2                    = cast(ushort) 0x09b2,
    HID_USAGE_SENSORS_HINGE_FOLD_CONTRIBUTING_PANEL_BOTH                       = cast(ushort) 0x09b3,
    HID_USAGE_SENSORS_HINGE_FOLD_TYPE_UNKNOWN                                  = cast(ushort) 0x09b4,
    HID_USAGE_SENSORS_HINGE_FOLD_TYPE_INCREASING                               = cast(ushort) 0x09b5,
    HID_USAGE_SENSORS_HINGE_FOLD_TYPE_DECREASING                               = cast(ushort) 0x09b6,
    HID_USAGE_SENSORS_HUMAN_PRESENCE_DETECTION_TYPE_VENDORDEFINED_NONBIOMETRIC = cast(ushort) 0x09c0,
    HID_USAGE_SENSORS_HUMAN_PRESENCE_DETECTION_TYPE_VENDORDEFINED_BIOMETRIC    = cast(ushort) 0x09c1,
    HID_USAGE_SENSORS_HUMAN_PRESENCE_DETECTION_TYPE_FACIAL_BIOMETRIC           = cast(ushort) 0x09c2,
    HID_USAGE_SENSORS_HUMAN_PRESENCE_DETECTION_TYPE_AUDIO_BIOMETRIC            = cast(ushort) 0x09c3,
}

enum : ushort
{
    HID_USAGE_SENSORS_MODIFIER_CHANGE_SENSITIVITY_ABSOLUTE         = cast(ushort) 0x1000,
    HID_USAGE_SENSORS_MODIFIER_MAXIMUM                             = cast(ushort) 0x2000,
    HID_USAGE_SENSORS_MODIFIER_MINIMUM                             = cast(ushort) 0x3000,
    HID_USAGE_SENSORS_MODIFIER_ACCURACY                            = cast(ushort) 0x4000,
    HID_USAGE_SENSORS_MODIFIER_RESOLUTION                          = cast(ushort) 0x5000,
    HID_USAGE_SENSORS_MODIFIER_THRESHOLD_HIGH                      = cast(ushort) 0x6000,
    HID_USAGE_SENSORS_MODIFIER_THRESHOLD_LOW                       = cast(ushort) 0x7000,
    HID_USAGE_SENSORS_MODIFIER_CALIBRATION_OFFSET                  = cast(ushort) 0x8000,
    HID_USAGE_SENSORS_MODIFIER_CALIBRATION_MULTIPLIER              = cast(ushort) 0x9000,
    HID_USAGE_SENSORS_MODIFIER_REPORT_INTERVAL                     = cast(ushort) 0xa000,
    HID_USAGE_SENSORS_MODIFIER_FREQUENCY_MAX                       = cast(ushort) 0xb000,
    HID_USAGE_SENSORS_MODIFIER_PERIOD_MAX                          = cast(ushort) 0xc000,
    HID_USAGE_SENSORS_MODIFIER_CHANGE_SENSITIVITY_PERCENT_OF_RANGE = cast(ushort) 0xd000,
    HID_USAGE_SENSORS_MODIFIER_CHANGE_SENSITIVITY_PERCENT_RELATIVE = cast(ushort) 0xe000,
    HID_USAGE_SENSORS_MODIFIER_VENDOR_RESERVED                     = cast(ushort) 0xf000,
}

enum : ushort
{
    HID_USAGE_SIMULATION_FLIGHT_SIMULATION_DEVICE       = cast(ushort) 0x0001,
    HID_USAGE_SIMULATION_AUTOMOBILE_SIMULATION_DEVICE   = cast(ushort) 0x0002,
    HID_USAGE_SIMULATION_TANK_SIMULATION_DEVICE         = cast(ushort) 0x0003,
    HID_USAGE_SIMULATION_SPACESHIP_SIMULATION_DEVICE    = cast(ushort) 0x0004,
    HID_USAGE_SIMULATION_SUBMARINE_SIMULATION_DEVICE    = cast(ushort) 0x0005,
    HID_USAGE_SIMULATION_SAILING_SIMULATION_DEVICE      = cast(ushort) 0x0006,
    HID_USAGE_SIMULATION_MOTORCYCLE_SIMULATION_DEVICE   = cast(ushort) 0x0007,
    HID_USAGE_SIMULATION_SPORTS_SIMULATION_DEVICE       = cast(ushort) 0x0008,
    HID_USAGE_SIMULATION_AIRPLANE_SIMULATION_DEVICE     = cast(ushort) 0x0009,
    HID_USAGE_SIMULATION_HELICOPTER_SIMULATION_DEVICE   = cast(ushort) 0x000a,
    HID_USAGE_SIMULATION_MAGIC_CARPET_SIMULATION_DEVICE = cast(ushort) 0x000b,
    HID_USAGE_SIMULATION_BICYCLE_SIMULATION_DEVICE      = cast(ushort) 0x000c,
    HID_USAGE_SIMULATION_FLIGHT_CONTROL_STICK           = cast(ushort) 0x0020,
    HID_USAGE_SIMULATION_FLIGHT_STICK                   = cast(ushort) 0x0021,
    HID_USAGE_SIMULATION_CYCLIC_CONTROL                 = cast(ushort) 0x0022,
    HID_USAGE_SIMULATION_CYCLIC_TRIM                    = cast(ushort) 0x0023,
    HID_USAGE_SIMULATION_FLIGHT_YOKE                    = cast(ushort) 0x0024,
    HID_USAGE_SIMULATION_TRACK_CONTROL                  = cast(ushort) 0x0025,
    HID_USAGE_SIMULATION_AILERON                        = cast(ushort) 0x00b0,
    HID_USAGE_SIMULATION_AILERON_TRIM                   = cast(ushort) 0x00b1,
    HID_USAGE_SIMULATION_ANTI_TORQUE_CONTROL            = cast(ushort) 0x00b2,
    HID_USAGE_SIMULATION_AUTOPIOLOT_ENABLE              = cast(ushort) 0x00b3,
    HID_USAGE_SIMULATION_CHAFF_RELEASE                  = cast(ushort) 0x00b4,
    HID_USAGE_SIMULATION_COLLECTIVE_CONTROL             = cast(ushort) 0x00b5,
    HID_USAGE_SIMULATION_DIVE_BRAKE                     = cast(ushort) 0x00b6,
    HID_USAGE_SIMULATION_ELECTRONIC_COUNTERMEASURES     = cast(ushort) 0x00b7,
    HID_USAGE_SIMULATION_ELEVATOR                       = cast(ushort) 0x00b8,
    HID_USAGE_SIMULATION_ELEVATOR_TRIM                  = cast(ushort) 0x00b9,
    HID_USAGE_SIMULATION_RUDDER                         = cast(ushort) 0x00ba,
    HID_USAGE_SIMULATION_THROTTLE                       = cast(ushort) 0x00bb,
    HID_USAGE_SIMULATION_FLIGHT_COMMUNICATIONS          = cast(ushort) 0x00bc,
    HID_USAGE_SIMULATION_FLARE_RELEASE                  = cast(ushort) 0x00bd,
    HID_USAGE_SIMULATION_LANDING_GEAR                   = cast(ushort) 0x00be,
    HID_USAGE_SIMULATION_TOE_BRAKE                      = cast(ushort) 0x00bf,
    HID_USAGE_SIMULATION_TRIGGER                        = cast(ushort) 0x00c0,
    HID_USAGE_SIMULATION_WEAPONS_ARM                    = cast(ushort) 0x00c1,
    HID_USAGE_SIMULATION_WEAPONS_SELECT                 = cast(ushort) 0x00c2,
    HID_USAGE_SIMULATION_WING_FLAPS                     = cast(ushort) 0x00c3,
    HID_USAGE_SIMULATION_ACCELERATOR                    = cast(ushort) 0x00c4,
    HID_USAGE_SIMULATION_BRAKE                          = cast(ushort) 0x00c5,
    HID_USAGE_SIMULATION_CLUTCH                         = cast(ushort) 0x00c6,
    HID_USAGE_SIMULATION_SHIFTER                        = cast(ushort) 0x00c7,
    HID_USAGE_SIMULATION_STEERING                       = cast(ushort) 0x00c8,
    HID_USAGE_SIMULATION_TURRET_DIRECTION               = cast(ushort) 0x00c9,
    HID_USAGE_SIMULATION_BARREL_ELEVATION               = cast(ushort) 0x00ca,
    HID_USAGE_SIMULATION_DIVE_PLANE                     = cast(ushort) 0x00cb,
    HID_USAGE_SIMULATION_BALLAST                        = cast(ushort) 0x00cc,
    HID_USAGE_SIMULATION_BICYCLE_CRANK                  = cast(ushort) 0x00cd,
    HID_USAGE_SIMULATION_HANDLE_BARS                    = cast(ushort) 0x00ce,
    HID_USAGE_SIMULATION_FRONT_BRAKE                    = cast(ushort) 0x00cf,
    HID_USAGE_SIMULATION_REAR_BRAKE                     = cast(ushort) 0x00d0,
}

enum : ushort
{
    HID_USAGE_SOC_SOC_CONTROL                      = cast(ushort) 0x0001,
    HID_USAGE_SOC_FIRMWARE_TRANSFER                = cast(ushort) 0x0002,
    HID_USAGE_SOC_FIRMWARE_FILE_ID                 = cast(ushort) 0x0003,
    HID_USAGE_SOC_FILE_OFFSET_IN_BYTES             = cast(ushort) 0x0004,
    HID_USAGE_SOC_FILE_TRANSFER_SIZE_MAX_IN_BYTES  = cast(ushort) 0x0005,
    HID_USAGE_SOC_FILE_PAYLOAD                     = cast(ushort) 0x0006,
    HID_USAGE_SOC_FILE_PAYLOAD_SIZE_IN_BYTES       = cast(ushort) 0x0007,
    HID_USAGE_SOC_FILE_PAYLOAD_CONTAINS_LAST_BYTES = cast(ushort) 0x0008,
    HID_USAGE_SOC_FILE_TRANSFER_STOP               = cast(ushort) 0x0009,
    HID_USAGE_SOC_FILE_TRANSFER_TILL_END           = cast(ushort) 0x000a,
}

enum : ushort
{
    HID_USAGE_SPORT_BASEBALL_BAT                    = cast(ushort) 0x0001,
    HID_USAGE_SPORT_GOLF_CLUB                       = cast(ushort) 0x0002,
    HID_USAGE_SPORT_ROWING_MACHINE                  = cast(ushort) 0x0003,
    HID_USAGE_SPORT_TREADMILL                       = cast(ushort) 0x0004,
    HID_USAGE_SPORT_OAR                             = cast(ushort) 0x0030,
    HID_USAGE_SPORT_SLOPE                           = cast(ushort) 0x0031,
    HID_USAGE_SPORT_RATE                            = cast(ushort) 0x0032,
    HID_USAGE_SPORT_STICK_SPEED                     = cast(ushort) 0x0033,
    HID_USAGE_SPORT_STICK_FACE_ANGLE                = cast(ushort) 0x0034,
    HID_USAGE_SPORT_HEEL_TOE                        = cast(ushort) 0x0035,
    HID_USAGE_SPORT_FOLLOW_THROUGH                  = cast(ushort) 0x0036,
    HID_USAGE_SPORT_TEMPO                           = cast(ushort) 0x0037,
    HID_USAGE_SPORT_STICK_TYPE                      = cast(ushort) 0x0038,
    HID_USAGE_SPORT_HEIGHT                          = cast(ushort) 0x0039,
    HID_USAGE_SPORT_PUTTER                          = cast(ushort) 0x0050,
    HID_USAGE_SPORT_1_IRON                          = cast(ushort) 0x0051,
    HID_USAGE_SPORT_2_IRON                          = cast(ushort) 0x0052,
    HID_USAGE_SPORT_3_IRON                          = cast(ushort) 0x0053,
    HID_USAGE_SPORT_4_IRON                          = cast(ushort) 0x0054,
    HID_USAGE_SPORT_5_IRON                          = cast(ushort) 0x0055,
    HID_USAGE_SPORT_6_IRON                          = cast(ushort) 0x0056,
    HID_USAGE_SPORT_7_IRON                          = cast(ushort) 0x0057,
    HID_USAGE_SPORT_8_IRON                          = cast(ushort) 0x0058,
    HID_USAGE_SPORT_9_IRON                          = cast(ushort) 0x0059,
    HID_USAGE_SPORT_10_IRON                         = cast(ushort) 0x005a,
    HID_USAGE_SPORT_11_IRON                         = cast(ushort) 0x005b,
    HID_USAGE_SPORT_SAND_WEDGE                      = cast(ushort) 0x005c,
    HID_USAGE_SPORT_LOFT_WEDGE                      = cast(ushort) 0x005d,
    HID_USAGE_SPORT_POWER_WEDGE                     = cast(ushort) 0x005e,
    HID_USAGE_SPORT_1_WOOD                          = cast(ushort) 0x005f,
    HID_USAGE_SPORT_3_WOOD                          = cast(ushort) 0x0060,
    HID_USAGE_SPORT_5_WOOD                          = cast(ushort) 0x0061,
    HID_USAGE_SPORT_7_WOOD                          = cast(ushort) 0x0062,
    HID_USAGE_SPORT_9_WOOD                          = cast(ushort) 0x0063,
    HID_USAGE_TELEPHONY_PHONE                       = cast(ushort) 0x0001,
    HID_USAGE_TELEPHONY_ANSWERING_MACHINE           = cast(ushort) 0x0002,
    HID_USAGE_TELEPHONY_MESSAGE_CONTROLS            = cast(ushort) 0x0003,
    HID_USAGE_TELEPHONY_HANDSET                     = cast(ushort) 0x0004,
    HID_USAGE_TELEPHONY_HEADSET                     = cast(ushort) 0x0005,
    HID_USAGE_TELEPHONY_KEYPAD                      = cast(ushort) 0x0006,
    HID_USAGE_TELEPHONY_PROGRAMMABLE_BUTTON         = cast(ushort) 0x0007,
    HID_USAGE_TELEPHONY_HOOK_SWITCH                 = cast(ushort) 0x0020,
    HID_USAGE_TELEPHONY_FLASH                       = cast(ushort) 0x0021,
    HID_USAGE_TELEPHONY_FEATURE                     = cast(ushort) 0x0022,
    HID_USAGE_TELEPHONY_HOLD                        = cast(ushort) 0x0023,
    HID_USAGE_TELEPHONY_REDIAL                      = cast(ushort) 0x0024,
    HID_USAGE_TELEPHONY_TRANSFER                    = cast(ushort) 0x0025,
    HID_USAGE_TELEPHONY_DROP                        = cast(ushort) 0x0026,
    HID_USAGE_TELEPHONY_PARK                        = cast(ushort) 0x0027,
    HID_USAGE_TELEPHONY_FORWARD_CALLS               = cast(ushort) 0x0028,
    HID_USAGE_TELEPHONY_ALTERNATE_FUNCTION          = cast(ushort) 0x0029,
    HID_USAGE_TELEPHONY_LINE                        = cast(ushort) 0x002a,
    HID_USAGE_TELEPHONY_SPEAKER_PHONE               = cast(ushort) 0x002b,
    HID_USAGE_TELEPHONY_CONFERENCE                  = cast(ushort) 0x002c,
    HID_USAGE_TELEPHONY_RING_ENABLE                 = cast(ushort) 0x002d,
    HID_USAGE_TELEPHONY_RING_SELECT                 = cast(ushort) 0x002e,
    HID_USAGE_TELEPHONY_PHONE_MUTE                  = cast(ushort) 0x002f,
    HID_USAGE_TELEPHONY_CALLER_ID                   = cast(ushort) 0x0030,
    HID_USAGE_TELEPHONY_SEND                        = cast(ushort) 0x0031,
    HID_USAGE_TELEPHONY_SPEED_DIAL                  = cast(ushort) 0x0050,
    HID_USAGE_TELEPHONY_STORE_NUMBER                = cast(ushort) 0x0051,
    HID_USAGE_TELEPHONY_RECALL_NUMBER               = cast(ushort) 0x0052,
    HID_USAGE_TELEPHONY_PHONE_DIRECTORY             = cast(ushort) 0x0053,
    HID_USAGE_TELEPHONY_VOICE_MAIL                  = cast(ushort) 0x0070,
    HID_USAGE_TELEPHONY_SCREEN_CALLS                = cast(ushort) 0x0071,
    HID_USAGE_TELEPHONY_DO_NOT_DISTURB              = cast(ushort) 0x0072,
    HID_USAGE_TELEPHONY_MESSAGE                     = cast(ushort) 0x0073,
    HID_USAGE_TELEPHONY_ANSWER_ONOFF                = cast(ushort) 0x0074,
    HID_USAGE_TELEPHONY_INSIDE_DIAL_TONE            = cast(ushort) 0x0090,
    HID_USAGE_TELEPHONY_OUTSIDE_DIAL_TONE           = cast(ushort) 0x0091,
    HID_USAGE_TELEPHONY_INSIDE_RING_TONE            = cast(ushort) 0x0092,
    HID_USAGE_TELEPHONY_OUTSIDE_RING_TONE           = cast(ushort) 0x0093,
    HID_USAGE_TELEPHONY_PRIORITY_RING_TONE          = cast(ushort) 0x0094,
    HID_USAGE_TELEPHONY_INSIDE_RINGBACK             = cast(ushort) 0x0095,
    HID_USAGE_TELEPHONY_PRIORITY_RINGBACK           = cast(ushort) 0x0096,
    HID_USAGE_TELEPHONY_LINE_BUSY_TONE              = cast(ushort) 0x0097,
    HID_USAGE_TELEPHONY_REORDER_TONE                = cast(ushort) 0x0098,
    HID_USAGE_TELEPHONY_CALL_WAITING_TONE           = cast(ushort) 0x0099,
    HID_USAGE_TELEPHONY_CONFIRMATION_TONE_1         = cast(ushort) 0x009a,
    HID_USAGE_TELEPHONY_CONFIRMATION_TONE_2         = cast(ushort) 0x009b,
    HID_USAGE_TELEPHONY_TONES_OFF                   = cast(ushort) 0x009c,
    HID_USAGE_TELEPHONY_OUTSIDE_RINGBACK            = cast(ushort) 0x009d,
    HID_USAGE_TELEPHONY_RINGER                      = cast(ushort) 0x009e,
    HID_USAGE_TELEPHONY_PHONE_KEY_0                 = cast(ushort) 0x00b0,
    HID_USAGE_TELEPHONY_PHONE_KEY_1                 = cast(ushort) 0x00b1,
    HID_USAGE_TELEPHONY_PHONE_KEY_2                 = cast(ushort) 0x00b2,
    HID_USAGE_TELEPHONY_PHONE_KEY_3                 = cast(ushort) 0x00b3,
    HID_USAGE_TELEPHONY_PHONE_KEY_4                 = cast(ushort) 0x00b4,
    HID_USAGE_TELEPHONY_PHONE_KEY_5                 = cast(ushort) 0x00b5,
    HID_USAGE_TELEPHONY_PHONE_KEY_6                 = cast(ushort) 0x00b6,
    HID_USAGE_TELEPHONY_PHONE_KEY_7                 = cast(ushort) 0x00b7,
    HID_USAGE_TELEPHONY_PHONE_KEY_8                 = cast(ushort) 0x00b8,
    HID_USAGE_TELEPHONY_PHONE_KEY_9                 = cast(ushort) 0x00b9,
    HID_USAGE_TELEPHONY_PHONE_KEY_STAR              = cast(ushort) 0x00ba,
    HID_USAGE_TELEPHONY_PHONE_KEY_POUND             = cast(ushort) 0x00bb,
    HID_USAGE_TELEPHONY_PHONE_KEY_A                 = cast(ushort) 0x00bc,
    HID_USAGE_TELEPHONY_PHONE_KEY_B                 = cast(ushort) 0x00bd,
    HID_USAGE_TELEPHONY_PHONE_KEY_C                 = cast(ushort) 0x00be,
    HID_USAGE_TELEPHONY_PHONE_KEY_D                 = cast(ushort) 0x00bf,
    HID_USAGE_TELEPHONY_PHONE_CALL_HISTORY_KEY      = cast(ushort) 0x00c0,
    HID_USAGE_TELEPHONY_PHONE_CALLER_ID_KEY         = cast(ushort) 0x00c1,
    HID_USAGE_TELEPHONY_PHONE_SETTINGS_KEY          = cast(ushort) 0x00c2,
    HID_USAGE_TELEPHONY_HOST_CONTROL                = cast(ushort) 0x00f0,
    HID_USAGE_TELEPHONY_HOST_AVAILABLE              = cast(ushort) 0x00f1,
    HID_USAGE_TELEPHONY_HOST_CALL_ACTIVE            = cast(ushort) 0x00f2,
    HID_USAGE_TELEPHONY_ACTIVATE_HANDSET_AUDIO      = cast(ushort) 0x00f3,
    HID_USAGE_TELEPHONY_RING_TYPE                   = cast(ushort) 0x00f4,
    HID_USAGE_TELEPHONY_REDIALABLE_PHONE_NUMBER     = cast(ushort) 0x00f5,
    HID_USAGE_TELEPHONY_STOP_RING_TONE              = cast(ushort) 0x00f8,
    HID_USAGE_TELEPHONY_PSTN_RING_TONE              = cast(ushort) 0x00f9,
    HID_USAGE_TELEPHONY_HOST_RING_TONE              = cast(ushort) 0x00fa,
    HID_USAGE_TELEPHONY_ALERT_SOUND_ERROR           = cast(ushort) 0x00fb,
    HID_USAGE_TELEPHONY_ALERT_SOUND_CONFIRM         = cast(ushort) 0x00fc,
    HID_USAGE_TELEPHONY_ALERT_SOUND_NOTIFICATION    = cast(ushort) 0x00fd,
    HID_USAGE_TELEPHONY_SILENT_RING                 = cast(ushort) 0x00fe,
    HID_USAGE_TELEPHONY_EMAIL_MESSAGE_WAITING       = cast(ushort) 0x0108,
    HID_USAGE_TELEPHONY_VOICEMAIL_MESSAGE_WAITING   = cast(ushort) 0x0109,
    HID_USAGE_TELEPHONY_HOST_HOLD                   = cast(ushort) 0x010a,
    HID_USAGE_TELEPHONY_INCOMING_CALL_HISTORY_COUNT = cast(ushort) 0x0110,
    HID_USAGE_TELEPHONY_OUTGOING_CALL_HISTORY_COUNT = cast(ushort) 0x0111,
    HID_USAGE_TELEPHONY_INCOMING_CALL_HISTORY       = cast(ushort) 0x0112,
    HID_USAGE_TELEPHONY_OUTGOING_CALL_HISTORY       = cast(ushort) 0x0113,
    HID_USAGE_TELEPHONY_PHONE_LOCALE                = cast(ushort) 0x0114,
    HID_USAGE_TELEPHONY_PHONE_TIME_SECOND           = cast(ushort) 0x0140,
    HID_USAGE_TELEPHONY_PHONE_TIME_MINUTE           = cast(ushort) 0x0141,
    HID_USAGE_TELEPHONY_PHONE_TIME_HOUR             = cast(ushort) 0x0142,
    HID_USAGE_TELEPHONY_PHONE_DATE_DAY              = cast(ushort) 0x0143,
    HID_USAGE_TELEPHONY_PHONE_DATE_MONTH            = cast(ushort) 0x0144,
    HID_USAGE_TELEPHONY_PHONE_DATE_YEAR             = cast(ushort) 0x0145,
    HID_USAGE_TELEPHONY_HANDSET_NICKNAME            = cast(ushort) 0x0146,
    HID_USAGE_TELEPHONY_ADDRESS_BOOK_ID             = cast(ushort) 0x0147,
    HID_USAGE_TELEPHONY_CALL_DURATION               = cast(ushort) 0x014a,
    HID_USAGE_TELEPHONY_DUAL_MODE_PHONE             = cast(ushort) 0x014b,
}

enum : ushort
{
    HID_USAGE_VESA_VIRTUAL_CONTROLS_DEGAUSS                              = cast(ushort) 0x0001,
    HID_USAGE_VESA_VIRTUAL_CONTROLS_BRIGHTNESS                           = cast(ushort) 0x0010,
    HID_USAGE_VESA_VIRTUAL_CONTROLS_CONTRAST                             = cast(ushort) 0x0012,
    HID_USAGE_VESA_VIRTUAL_CONTROLS_RED_VIDEO_GAIN                       = cast(ushort) 0x0016,
    HID_USAGE_VESA_VIRTUAL_CONTROLS_GREEN_VIDEO_GAIN                     = cast(ushort) 0x0018,
    HID_USAGE_VESA_VIRTUAL_CONTROLS_BLUE_VIDEO_GAIN                      = cast(ushort) 0x001a,
    HID_USAGE_VESA_VIRTUAL_CONTROLS_FOCUS                                = cast(ushort) 0x001c,
    HID_USAGE_VESA_VIRTUAL_CONTROLS_HORIZONTAL_POSITION                  = cast(ushort) 0x0020,
    HID_USAGE_VESA_VIRTUAL_CONTROLS_HORIZONTAL_SIZE                      = cast(ushort) 0x0022,
    HID_USAGE_VESA_VIRTUAL_CONTROLS_HORIZONTAL_PINCUSHION                = cast(ushort) 0x0024,
    HID_USAGE_VESA_VIRTUAL_CONTROLS_HORIZONTAL_PINCUSHION_BALANCE        = cast(ushort) 0x0026,
    HID_USAGE_VESA_VIRTUAL_CONTROLS_HORIZONTAL_MISCONVERGENCE            = cast(ushort) 0x0028,
    HID_USAGE_VESA_VIRTUAL_CONTROLS_HORIZONTAL_LINEARITY                 = cast(ushort) 0x002a,
    HID_USAGE_VESA_VIRTUAL_CONTROLS_HORIZONTAL_LINEARITY_BALANCE         = cast(ushort) 0x002c,
    HID_USAGE_VESA_VIRTUAL_CONTROLS_VERTICAL_POSITION                    = cast(ushort) 0x0030,
    HID_USAGE_VESA_VIRTUAL_CONTROLS_VERTICAL_SIZE                        = cast(ushort) 0x0032,
    HID_USAGE_VESA_VIRTUAL_CONTROLS_VERTICAL_PINCUSHION                  = cast(ushort) 0x0034,
    HID_USAGE_VESA_VIRTUAL_CONTROLS_VERTICAL_PINCUSHION_BALANCE          = cast(ushort) 0x0036,
    HID_USAGE_VESA_VIRTUAL_CONTROLS_VERTICAL_MISCONVERGENCE              = cast(ushort) 0x0038,
    HID_USAGE_VESA_VIRTUAL_CONTROLS_VERTICAL_LINEARITY                   = cast(ushort) 0x003a,
    HID_USAGE_VESA_VIRTUAL_CONTROLS_VERTICAL_LINEARITY_BALANCE           = cast(ushort) 0x003c,
    HID_USAGE_VESA_VIRTUAL_CONTROLS_PARALLELOGRAM_DISTORTION_KEY_BALANCE = cast(ushort) 0x0040,
    HID_USAGE_VESA_VIRTUAL_CONTROLS_TRAPEZOIDAL_DISTORTION_KEY           = cast(ushort) 0x0042,
    HID_USAGE_VESA_VIRTUAL_CONTROLS_TILT_ROTATION                        = cast(ushort) 0x0044,
    HID_USAGE_VESA_VIRTUAL_CONTROLS_TOP_CORNER_DISTORTION_CONTROL        = cast(ushort) 0x0046,
    HID_USAGE_VESA_VIRTUAL_CONTROLS_TOP_CORNER_DISTORTION_BALANCE        = cast(ushort) 0x0048,
    HID_USAGE_VESA_VIRTUAL_CONTROLS_BOTTOM_CORNER_DISTORTION_CONTROL     = cast(ushort) 0x004a,
    HID_USAGE_VESA_VIRTUAL_CONTROLS_BOTTOM_CORNER_DISTORTION_BALANCE     = cast(ushort) 0x004c,
    HID_USAGE_VESA_VIRTUAL_CONTROLS_HORIZONTAL_MOIRE                     = cast(ushort) 0x0056,
    HID_USAGE_VESA_VIRTUAL_CONTROLS_VERTICAL_MOIRE                       = cast(ushort) 0x0058,
    HID_USAGE_VESA_VIRTUAL_CONTROLS_INPUT_LEVEL_SELECT                   = cast(ushort) 0x005e,
    HID_USAGE_VESA_VIRTUAL_CONTROLS_INPUT_SOURCE_SELECT                  = cast(ushort) 0x0060,
    HID_USAGE_VESA_VIRTUAL_CONTROLS_RED_VIDEO_BLACK_LEVEL                = cast(ushort) 0x006c,
    HID_USAGE_VESA_VIRTUAL_CONTROLS_GREEN_VIDEO_BLACK_LEVEL              = cast(ushort) 0x006e,
    HID_USAGE_VESA_VIRTUAL_CONTROLS_BLUE_VIDEO_BLACK_LEVEL               = cast(ushort) 0x0070,
    HID_USAGE_VESA_VIRTUAL_CONTROLS_AUTO_SIZE_CENTER                     = cast(ushort) 0x00a2,
    HID_USAGE_VESA_VIRTUAL_CONTROLS_POLARITY_HORIZONTAL_SYNCHRONIZATION  = cast(ushort) 0x00a4,
    HID_USAGE_VESA_VIRTUAL_CONTROLS_POLARITY_VERTICAL_SYNCHRONIZATION    = cast(ushort) 0x00a6,
    HID_USAGE_VESA_VIRTUAL_CONTROLS_SYNCHRONIZATION_TYPE                 = cast(ushort) 0x00a8,
    HID_USAGE_VESA_VIRTUAL_CONTROLS_SCREEN_ORIENTATION                   = cast(ushort) 0x00aa,
    HID_USAGE_VESA_VIRTUAL_CONTROLS_HORIZONTAL_FREQUENCY                 = cast(ushort) 0x00ac,
    HID_USAGE_VESA_VIRTUAL_CONTROLS_VERTICAL_FREQUENCY                   = cast(ushort) 0x00ae,
    HID_USAGE_VESA_VIRTUAL_CONTROLS_SETTINGS                             = cast(ushort) 0x00b0,
    HID_USAGE_VESA_VIRTUAL_CONTROLS_ON_SCREEN_DISPLAY                    = cast(ushort) 0x00ca,
    HID_USAGE_VESA_VIRTUAL_CONTROLS_STEREO_MODE                          = cast(ushort) 0x00d4,
}

enum : ushort
{
    HID_USAGE_VR_BELT                 = cast(ushort) 0x0001,
    HID_USAGE_VR_BODY_SUIT            = cast(ushort) 0x0002,
    HID_USAGE_VR_FLEXOR               = cast(ushort) 0x0003,
    HID_USAGE_VR_GLOVE                = cast(ushort) 0x0004,
    HID_USAGE_VR_HEAD_TRACKER         = cast(ushort) 0x0005,
    HID_USAGE_VR_HEAD_MOUNTED_DISPLAY = cast(ushort) 0x0006,
    HID_USAGE_VR_HAND_TRACKER         = cast(ushort) 0x0007,
    HID_USAGE_VR_OCULOMETER           = cast(ushort) 0x0008,
    HID_USAGE_VR_VEST                 = cast(ushort) 0x0009,
    HID_USAGE_VR_ANIMATRONIC_DEVICE   = cast(ushort) 0x000a,
    HID_USAGE_VR_STEREO_ENABLE        = cast(ushort) 0x0020,
    HID_USAGE_VR_DISPLAY_ENABLE       = cast(ushort) 0x0021,
}

enum : /*FIELD ATTR: NativeEncodingAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ansi))], [])*/const(wchar)*
{
    DD_KEYBOARD_DEVICE_NAME   = "\\Device\\KeyboardClass",
    DD_KEYBOARD_DEVICE_NAME_U = "\\Device\\KeyboardClass",
}

enum : /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ntddkbd/ni-ntddkbd-ioctl_keyboard_query_attributes))], [])*/uint
{
    IOCTL_KEYBOARD_QUERY_ATTRIBUTES            = 0x000b0000U,
    IOCTL_KEYBOARD_SET_TYPEMATIC               = 0x000b0004U,
    IOCTL_KEYBOARD_SET_INDICATORS              = 0x000b0008U,
    IOCTL_KEYBOARD_QUERY_TYPEMATIC             = 0x000b0020U,
    IOCTL_KEYBOARD_QUERY_INDICATORS            = 0x000b0040U,
    IOCTL_KEYBOARD_QUERY_INDICATOR_TRANSLATION = 0x000b0080U,
}

enum : uint
{
    IOCTL_KEYBOARD_INSERT_DATA               = 0x000b0100U,
    IOCTL_KEYBOARD_QUERY_EXTENDED_ATTRIBUTES = 0x000b0200U,
    IOCTL_KEYBOARD_QUERY_IME_STATUS          = 0x000b1000U,
    IOCTL_KEYBOARD_SET_IME_STATUS            = 0x000b1004U,
}

enum GUID GUID_DEVINTERFACE_KEYBOARD = GUID("884b96c3-56ef-11d1-bc8c-00a0c91405dd");
enum uint KEYBOARD_OVERRUN_MAKE_CODE = 0x000000ffU;

enum : uint
{
    KEY_MAKE             = 0x00000000U,
    KEY_BREAK            = 0x00000001U,
    KEY_E0               = 0x00000002U,
    KEY_E1               = 0x00000004U,
    KEY_TERMSRV_SET_LED  = 0x00000008U,
    KEY_TERMSRV_SHADOW   = 0x00000010U,
    KEY_TERMSRV_VKPACKET = 0x00000020U,
}

enum uint KEY_RIM_VKEY = 0x00000040U;
enum uint KEY_FROM_KEYBOARD_OVERRIDER = 0x00000080U;

enum : uint
{
    KEY_UNICODE_SEQUENCE_ITEM = 0x00000100U,
    KEY_UNICODE_SEQUENCE_END  = 0x00000200U,
}

enum uint KEYBOARD_EXTENDED_ATTRIBUTES_STRUCT_VERSION_1 = 0x00000001U;

enum : uint
{
    KEYBOARD_LED_INJECTED   = 0x00008000U,
    KEYBOARD_SHADOW         = 0x00004000U,
    KEYBOARD_KANA_LOCK_ON   = 0x00000008U,
    KEYBOARD_CAPS_LOCK_ON   = 0x00000004U,
    KEYBOARD_NUM_LOCK_ON    = 0x00000002U,
    KEYBOARD_SCROLL_LOCK_ON = 0x00000001U,
}

enum uint KEYBOARD_ERROR_VALUE_BASE = 0x00002710U;

enum : /*FIELD ATTR: NativeEncodingAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ansi))], [])*/const(wchar)*
{
    DD_MOUSE_DEVICE_NAME   = "\\Device\\PointerClass",
    DD_MOUSE_DEVICE_NAME_U = "\\Device\\PointerClass",
}

enum : /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ntddmou/ni-ntddmou-ioctl_mouse_query_attributes))], [])*/uint
{
    IOCTL_MOUSE_QUERY_ATTRIBUTES = 0x000f0000U,
    IOCTL_MOUSE_INSERT_DATA      = 0x000f0004U,
}

enum GUID GUID_DEVINTERFACE_MOUSE = GUID("378de44c-56ef-11d1-bc8c-00a0c91405dd");

enum : uint
{
    MOUSE_LEFT_BUTTON_DOWN = 0x00000001U,
    MOUSE_LEFT_BUTTON_UP   = 0x00000002U,
}

enum : uint
{
    MOUSE_RIGHT_BUTTON_DOWN = 0x00000004U,
    MOUSE_RIGHT_BUTTON_UP   = 0x00000008U,
}

enum : uint
{
    MOUSE_MIDDLE_BUTTON_DOWN = 0x00000010U,
    MOUSE_MIDDLE_BUTTON_UP   = 0x00000020U,
}

enum : uint
{
    MOUSE_BUTTON_1_DOWN = 0x00000001U,
    MOUSE_BUTTON_1_UP   = 0x00000002U,
    MOUSE_BUTTON_2_DOWN = 0x00000004U,
    MOUSE_BUTTON_2_UP   = 0x00000008U,
    MOUSE_BUTTON_3_DOWN = 0x00000010U,
    MOUSE_BUTTON_3_UP   = 0x00000020U,
    MOUSE_BUTTON_4_DOWN = 0x00000040U,
    MOUSE_BUTTON_4_UP   = 0x00000080U,
    MOUSE_BUTTON_5_DOWN = 0x00000100U,
    MOUSE_BUTTON_5_UP   = 0x00000200U,
}

enum : uint
{
    MOUSE_WHEEL              = 0x00000400U,
    MOUSE_HWHEEL             = 0x00000800U,
    MOUSE_TERMSRV_SRC_SHADOW = 0x00000100U,
}

enum uint MOUSE_INPORT_HARDWARE = 0x00000001U;
enum uint MOUSE_I8042_HARDWARE = 0x00000002U;
enum uint MOUSE_SERIAL_HARDWARE = 0x00000004U;

enum : uint
{
    BALLPOINT_I8042_HARDWARE  = 0x00000008U,
    BALLPOINT_SERIAL_HARDWARE = 0x00000010U,
}

enum : uint
{
    WHEELMOUSE_I8042_HARDWARE  = 0x00000020U,
    WHEELMOUSE_SERIAL_HARDWARE = 0x00000040U,
}

enum uint MOUSE_HID_HARDWARE = 0x00000080U;
enum uint WHEELMOUSE_HID_HARDWARE = 0x00000100U;
enum uint HORIZONTAL_WHEEL_PRESENT = 0x00008000U;
enum uint MOUSE_ERROR_VALUE_BASE = 0x00004e20U;
enum uint DIRECTINPUT_HEADER_VERSION = 0x00000800U;

enum : GUID
{
    CLSID_DirectInput        = GUID("25e609e0-b259-11cf-bfc7-444553540000"),
    CLSID_DirectInputDevice  = GUID("25e609e1-b259-11cf-bfc7-444553540000"),
    CLSID_DirectInput8       = GUID("25e609e4-b259-11cf-bfc7-444553540000"),
    CLSID_DirectInputDevice8 = GUID("25e609e5-b259-11cf-bfc7-444553540000"),
}

enum : GUID
{
    GUID_XAxis       = GUID("a36d02e0-c9f3-11cf-bfc7-444553540000"),
    GUID_YAxis       = GUID("a36d02e1-c9f3-11cf-bfc7-444553540000"),
    GUID_ZAxis       = GUID("a36d02e2-c9f3-11cf-bfc7-444553540000"),
    GUID_RxAxis      = GUID("a36d02f4-c9f3-11cf-bfc7-444553540000"),
    GUID_RyAxis      = GUID("a36d02f5-c9f3-11cf-bfc7-444553540000"),
    GUID_RzAxis      = GUID("a36d02e3-c9f3-11cf-bfc7-444553540000"),
    GUID_Slider      = GUID("a36d02e4-c9f3-11cf-bfc7-444553540000"),
    GUID_Button      = GUID("a36d02f0-c9f3-11cf-bfc7-444553540000"),
    GUID_Key         = GUID("55728220-d33c-11cf-bfc7-444553540000"),
    GUID_POV         = GUID("a36d02f2-c9f3-11cf-bfc7-444553540000"),
    GUID_Unknown     = GUID("a36d02f3-c9f3-11cf-bfc7-444553540000"),
    GUID_SysMouse    = GUID("6f1d2b60-d5a0-11cf-bfc7-444553540000"),
    GUID_SysKeyboard = GUID("6f1d2b61-d5a0-11cf-bfc7-444553540000"),
}

enum GUID GUID_Joystick = GUID("6f1d2b70-d5a0-11cf-bfc7-444553540000");

enum : GUID
{
    GUID_SysMouseEm     = GUID("6f1d2b80-d5a0-11cf-bfc7-444553540000"),
    GUID_SysMouseEm2    = GUID("6f1d2b81-d5a0-11cf-bfc7-444553540000"),
    GUID_SysKeyboardEm  = GUID("6f1d2b82-d5a0-11cf-bfc7-444553540000"),
    GUID_SysKeyboardEm2 = GUID("6f1d2b83-d5a0-11cf-bfc7-444553540000"),
}

enum GUID GUID_ConstantForce = GUID("13541c20-8e33-11d0-9ad0-00a0c9a06e35");
enum GUID GUID_RampForce = GUID("13541c21-8e33-11d0-9ad0-00a0c9a06e35");

enum : GUID
{
    GUID_Square   = GUID("13541c22-8e33-11d0-9ad0-00a0c9a06e35"),
    GUID_Sine     = GUID("13541c23-8e33-11d0-9ad0-00a0c9a06e35"),
    GUID_Triangle = GUID("13541c24-8e33-11d0-9ad0-00a0c9a06e35"),
}

enum : GUID
{
    GUID_SawtoothUp   = GUID("13541c25-8e33-11d0-9ad0-00a0c9a06e35"),
    GUID_SawtoothDown = GUID("13541c26-8e33-11d0-9ad0-00a0c9a06e35"),
}

enum : GUID
{
    GUID_Spring   = GUID("13541c27-8e33-11d0-9ad0-00a0c9a06e35"),
    GUID_Damper   = GUID("13541c28-8e33-11d0-9ad0-00a0c9a06e35"),
    GUID_Inertia  = GUID("13541c29-8e33-11d0-9ad0-00a0c9a06e35"),
    GUID_Friction = GUID("13541c2a-8e33-11d0-9ad0-00a0c9a06e35"),
}

enum GUID GUID_CustomForce = GUID("13541c2b-8e33-11d0-9ad0-00a0c9a06e35");

enum : uint
{
    DIEFT_ALL           = 0x00000000U,
    DIEFT_CONSTANTFORCE = 0x00000001U,
}

enum uint DIEFT_RAMPFORCE = 0x00000002U;

enum : uint
{
    DIEFT_PERIODIC    = 0x00000003U,
    DIEFT_CONDITION   = 0x00000004U,
    DIEFT_CUSTOMFORCE = 0x00000005U,
}

enum : uint
{
    DIEFT_HARDWARE   = 0x000000ffU,
    DIEFT_FFATTACK   = 0x00000200U,
    DIEFT_FFFADE     = 0x00000400U,
    DIEFT_SATURATION = 0x00000800U,
}

enum : uint
{
    DIEFT_POSNEGCOEFFICIENTS = 0x00001000U,
    DIEFT_POSNEGSATURATION   = 0x00002000U,
}

enum : uint
{
    DIEFT_DEADBAND   = 0x00004000U,
    DIEFT_STARTDELAY = 0x00008000U,
}

enum uint DI_DEGREES = 0x00000064U;
enum uint DI_FFNOMINALMAX = 0x00002710U;
enum uint DI_SECONDS = 0x000f4240U;

enum : uint
{
    DIEFF_OBJECTIDS     = 0x00000001U,
    DIEFF_OBJECTOFFSETS = 0x00000002U,
}

enum uint DIEFF_CARTESIAN = 0x00000010U;

enum : uint
{
    DIEFF_POLAR     = 0x00000020U,
    DIEFF_SPHERICAL = 0x00000040U,
}

enum uint DIEP_DURATION = 0x00000001U;
enum uint DIEP_SAMPLEPERIOD = 0x00000002U;

enum : uint
{
    DIEP_GAIN                  = 0x00000004U,
    DIEP_TRIGGERBUTTON         = 0x00000008U,
    DIEP_TRIGGERREPEATINTERVAL = 0x00000010U,
}

enum : uint
{
    DIEP_AXES      = 0x00000020U,
    DIEP_DIRECTION = 0x00000040U,
}

enum uint DIEP_ENVELOPE = 0x00000080U;
enum uint DIEP_TYPESPECIFICPARAMS = 0x00000100U;
enum uint DIEP_STARTDELAY = 0x00000200U;

enum : uint
{
    DIEP_ALLPARAMS_DX5 = 0x000001ffU,
    DIEP_ALLPARAMS     = 0x000003ffU,
}

enum : uint
{
    DIEP_START      = 0x20000000U,
    DIEP_NORESTART  = 0x40000000U,
    DIEP_NODOWNLOAD = 0x80000000U,
}

enum uint DIEB_NOTRIGGER = 0xffffffffU;

enum : uint
{
    DIES_SOLO       = 0x00000001U,
    DIES_NODOWNLOAD = 0x80000000U,
}

enum : uint
{
    DIEGES_PLAYING  = 0x00000001U,
    DIEGES_EMULATED = 0x00000002U,
}

enum : uint
{
    DIDEVTYPE_DEVICE   = 0x00000001U,
    DIDEVTYPE_MOUSE    = 0x00000002U,
    DIDEVTYPE_KEYBOARD = 0x00000003U,
    DIDEVTYPE_JOYSTICK = 0x00000004U,
}

enum : uint
{
    DI8DEVCLASS_ALL      = 0x00000000U,
    DI8DEVCLASS_DEVICE   = 0x00000001U,
    DI8DEVCLASS_POINTER  = 0x00000002U,
    DI8DEVCLASS_KEYBOARD = 0x00000003U,
    DI8DEVCLASS_GAMECTRL = 0x00000004U,
}

enum : uint
{
    DI8DEVTYPE_DEVICE        = 0x00000011U,
    DI8DEVTYPE_MOUSE         = 0x00000012U,
    DI8DEVTYPE_KEYBOARD      = 0x00000013U,
    DI8DEVTYPE_JOYSTICK      = 0x00000014U,
    DI8DEVTYPE_GAMEPAD       = 0x00000015U,
    DI8DEVTYPE_DRIVING       = 0x00000016U,
    DI8DEVTYPE_FLIGHT        = 0x00000017U,
    DI8DEVTYPE_1STPERSON     = 0x00000018U,
    DI8DEVTYPE_DEVICECTRL    = 0x00000019U,
    DI8DEVTYPE_SCREENPOINTER = 0x0000001aU,
    DI8DEVTYPE_REMOTE        = 0x0000001bU,
    DI8DEVTYPE_SUPPLEMENTAL  = 0x0000001cU,
}

enum : uint
{
    DIDEVTYPE_HID              = 0x00010000U,
    DIDEVTYPEMOUSE_UNKNOWN     = 0x00000001U,
    DIDEVTYPEMOUSE_TRADITIONAL = 0x00000002U,
    DIDEVTYPEMOUSE_FINGERSTICK = 0x00000003U,
    DIDEVTYPEMOUSE_TOUCHPAD    = 0x00000004U,
    DIDEVTYPEMOUSE_TRACKBALL   = 0x00000005U,
}

enum : uint
{
    DIDEVTYPEKEYBOARD_UNKNOWN     = 0x00000000U,
    DIDEVTYPEKEYBOARD_PCXT        = 0x00000001U,
    DIDEVTYPEKEYBOARD_OLIVETTI    = 0x00000002U,
    DIDEVTYPEKEYBOARD_PCAT        = 0x00000003U,
    DIDEVTYPEKEYBOARD_PCENH       = 0x00000004U,
    DIDEVTYPEKEYBOARD_NOKIA1050   = 0x00000005U,
    DIDEVTYPEKEYBOARD_NOKIA9140   = 0x00000006U,
    DIDEVTYPEKEYBOARD_NEC98       = 0x00000007U,
    DIDEVTYPEKEYBOARD_NEC98LAPTOP = 0x00000008U,
    DIDEVTYPEKEYBOARD_NEC98106    = 0x00000009U,
    DIDEVTYPEKEYBOARD_JAPAN106    = 0x0000000aU,
    DIDEVTYPEKEYBOARD_JAPANAX     = 0x0000000bU,
    DIDEVTYPEKEYBOARD_J3100       = 0x0000000cU,
}

enum : uint
{
    DIDEVTYPEJOYSTICK_UNKNOWN     = 0x00000001U,
    DIDEVTYPEJOYSTICK_TRADITIONAL = 0x00000002U,
    DIDEVTYPEJOYSTICK_FLIGHTSTICK = 0x00000003U,
    DIDEVTYPEJOYSTICK_GAMEPAD     = 0x00000004U,
    DIDEVTYPEJOYSTICK_RUDDER      = 0x00000005U,
    DIDEVTYPEJOYSTICK_WHEEL       = 0x00000006U,
    DIDEVTYPEJOYSTICK_HEADTRACKER = 0x00000007U,
}

enum : uint
{
    DI8DEVTYPEMOUSE_UNKNOWN        = 0x00000001U,
    DI8DEVTYPEMOUSE_TRADITIONAL    = 0x00000002U,
    DI8DEVTYPEMOUSE_FINGERSTICK    = 0x00000003U,
    DI8DEVTYPEMOUSE_TOUCHPAD       = 0x00000004U,
    DI8DEVTYPEMOUSE_TRACKBALL      = 0x00000005U,
    DI8DEVTYPEMOUSE_ABSOLUTE       = 0x00000006U,
    DI8DEVTYPEKEYBOARD_UNKNOWN     = 0x00000000U,
    DI8DEVTYPEKEYBOARD_PCXT        = 0x00000001U,
    DI8DEVTYPEKEYBOARD_OLIVETTI    = 0x00000002U,
    DI8DEVTYPEKEYBOARD_PCAT        = 0x00000003U,
    DI8DEVTYPEKEYBOARD_PCENH       = 0x00000004U,
    DI8DEVTYPEKEYBOARD_NOKIA1050   = 0x00000005U,
    DI8DEVTYPEKEYBOARD_NOKIA9140   = 0x00000006U,
    DI8DEVTYPEKEYBOARD_NEC98       = 0x00000007U,
    DI8DEVTYPEKEYBOARD_NEC98LAPTOP = 0x00000008U,
    DI8DEVTYPEKEYBOARD_NEC98106    = 0x00000009U,
    DI8DEVTYPEKEYBOARD_JAPAN106    = 0x0000000aU,
    DI8DEVTYPEKEYBOARD_JAPANAX     = 0x0000000bU,
    DI8DEVTYPEKEYBOARD_J3100       = 0x0000000cU,
    DI8DEVTYPE_LIMITEDGAMESUBTYPE  = 0x00000001U,
}

enum : uint
{
    DI8DEVTYPEJOYSTICK_LIMITED  = 0x00000001U,
    DI8DEVTYPEJOYSTICK_STANDARD = 0x00000002U,
}

enum : uint
{
    DI8DEVTYPEGAMEPAD_LIMITED        = 0x00000001U,
    DI8DEVTYPEGAMEPAD_STANDARD       = 0x00000002U,
    DI8DEVTYPEGAMEPAD_TILT           = 0x00000003U,
    DI8DEVTYPEDRIVING_LIMITED        = 0x00000001U,
    DI8DEVTYPEDRIVING_COMBINEDPEDALS = 0x00000002U,
    DI8DEVTYPEDRIVING_DUALPEDALS     = 0x00000003U,
    DI8DEVTYPEDRIVING_THREEPEDALS    = 0x00000004U,
    DI8DEVTYPEDRIVING_HANDHELD       = 0x00000005U,
}

enum : uint
{
    DI8DEVTYPEFLIGHT_LIMITED    = 0x00000001U,
    DI8DEVTYPEFLIGHT_STICK      = 0x00000002U,
    DI8DEVTYPEFLIGHT_YOKE       = 0x00000003U,
    DI8DEVTYPEFLIGHT_RC         = 0x00000004U,
    DI8DEVTYPE1STPERSON_LIMITED = 0x00000001U,
    DI8DEVTYPE1STPERSON_UNKNOWN = 0x00000002U,
    DI8DEVTYPE1STPERSON_SIXDOF  = 0x00000003U,
    DI8DEVTYPE1STPERSON_SHOOTER = 0x00000004U,
}

enum : uint
{
    DI8DEVTYPESCREENPTR_UNKNOWN  = 0x00000002U,
    DI8DEVTYPESCREENPTR_LIGHTGUN = 0x00000003U,
    DI8DEVTYPESCREENPTR_LIGHTPEN = 0x00000004U,
    DI8DEVTYPESCREENPTR_TOUCH    = 0x00000005U,
}

enum : uint
{
    DI8DEVTYPEREMOTE_UNKNOWN                      = 0x00000002U,
    DI8DEVTYPEDEVICECTRL_UNKNOWN                  = 0x00000002U,
    DI8DEVTYPEDEVICECTRL_COMMSSELECTION           = 0x00000003U,
    DI8DEVTYPEDEVICECTRL_COMMSSELECTION_HARDWIRED = 0x00000004U,
}

enum : uint
{
    DI8DEVTYPESUPPLEMENTAL_UNKNOWN           = 0x00000002U,
    DI8DEVTYPESUPPLEMENTAL_2NDHANDCONTROLLER = 0x00000003U,
    DI8DEVTYPESUPPLEMENTAL_HEADTRACKER       = 0x00000004U,
    DI8DEVTYPESUPPLEMENTAL_HANDTRACKER       = 0x00000005U,
    DI8DEVTYPESUPPLEMENTAL_SHIFTSTICKGATE    = 0x00000006U,
    DI8DEVTYPESUPPLEMENTAL_SHIFTER           = 0x00000007U,
    DI8DEVTYPESUPPLEMENTAL_THROTTLE          = 0x00000008U,
    DI8DEVTYPESUPPLEMENTAL_SPLITTHROTTLE     = 0x00000009U,
    DI8DEVTYPESUPPLEMENTAL_COMBINEDPEDALS    = 0x0000000aU,
    DI8DEVTYPESUPPLEMENTAL_DUALPEDALS        = 0x0000000bU,
    DI8DEVTYPESUPPLEMENTAL_THREEPEDALS       = 0x0000000cU,
    DI8DEVTYPESUPPLEMENTAL_RUDDERPEDALS      = 0x0000000dU,
}

enum uint DIDC_ATTACHED = 0x00000001U;
enum uint DIDC_POLLEDDEVICE = 0x00000002U;
enum uint DIDC_EMULATED = 0x00000004U;
enum uint DIDC_POLLEDDATAFORMAT = 0x00000008U;
enum uint DIDC_FORCEFEEDBACK = 0x00000100U;

enum : uint
{
    DIDC_FFATTACK   = 0x00000200U,
    DIDC_FFFADE     = 0x00000400U,
    DIDC_SATURATION = 0x00000800U,
}

enum : uint
{
    DIDC_POSNEGCOEFFICIENTS = 0x00001000U,
    DIDC_POSNEGSATURATION   = 0x00002000U,
}

enum uint DIDC_DEADBAND = 0x00004000U;
enum uint DIDC_STARTDELAY = 0x00008000U;

enum : uint
{
    DIDC_ALIAS   = 0x00010000U,
    DIDC_PHANTOM = 0x00020000U,
    DIDC_HIDDEN  = 0x00040000U,
}

enum : uint
{
    DIDFT_ALL       = 0x00000000U,
    DIDFT_RELAXIS   = 0x00000001U,
    DIDFT_ABSAXIS   = 0x00000002U,
    DIDFT_AXIS      = 0x00000003U,
    DIDFT_PSHBUTTON = 0x00000004U,
}

enum uint DIDFT_TGLBUTTON = 0x00000008U;

enum : uint
{
    DIDFT_BUTTON     = 0x0000000cU,
    DIDFT_POV        = 0x00000010U,
    DIDFT_COLLECTION = 0x00000040U,
}

enum : uint
{
    DIDFT_NODATA      = 0x00000080U,
    DIDFT_ANYINSTANCE = 0x00ffff00U,
}

enum uint DIDFT_INSTANCEMASK = 0x00ffff00U;

enum : uint
{
    DIDFT_FFACTUATOR      = 0x01000000U,
    DIDFT_FFEFFECTTRIGGER = 0x02000000U,
}

enum : uint
{
    DIDFT_OUTPUT        = 0x10000000U,
    DIDFT_VENDORDEFINED = 0x04000000U,
}

enum : uint
{
    DIDFT_ALIAS        = 0x08000000U,
    DIDFT_NOCOLLECTION = 0x00ffff00U,
}

enum : uint
{
    DIDF_ABSAXIS = 0x00000001U,
    DIDF_RELAXIS = 0x00000002U,
}

enum uint DIA_FORCEFEEDBACK = 0x00000001U;

enum : uint
{
    DIA_APPMAPPED = 0x00000002U,
    DIA_APPNOMAP  = 0x00000004U,
}

enum uint DIA_NORANGE = 0x00000008U;
enum uint DIA_APPFIXED = 0x00000010U;

enum : uint
{
    DIAH_UNMAPPED   = 0x00000000U,
    DIAH_USERCONFIG = 0x00000001U,
}

enum uint DIAH_APPREQUESTED = 0x00000002U;

enum : uint
{
    DIAH_HWAPP     = 0x00000004U,
    DIAH_HWDEFAULT = 0x00000008U,
}

enum : uint
{
    DIAH_DEFAULT = 0x00000020U,
    DIAH_ERROR   = 0x80000000U,
}

enum : uint
{
    DIAFTS_NEWDEVICELOW  = 0xffffffffU,
    DIAFTS_NEWDEVICEHIGH = 0xffffffffU,
}

enum : uint
{
    DIAFTS_UNUSEDDEVICELOW  = 0x00000000U,
    DIAFTS_UNUSEDDEVICEHIGH = 0x00000000U,
}

enum : uint
{
    DIDBAM_DEFAULT    = 0x00000000U,
    DIDBAM_PRESERVE   = 0x00000001U,
    DIDBAM_INITIALIZE = 0x00000002U,
    DIDBAM_HWDEFAULTS = 0x00000004U,
}

enum : uint
{
    DIDSAM_DEFAULT   = 0x00000000U,
    DIDSAM_NOUSER    = 0x00000001U,
    DIDSAM_FORCESAVE = 0x00000002U,
}

enum : uint
{
    DICD_DEFAULT = 0x00000000U,
    DICD_EDIT    = 0x00000001U,
}

enum uint DIDIFT_CONFIGURATION = 0x00000001U;
enum uint DIDIFT_OVERLAY = 0x00000002U;

enum : uint
{
    DIDAL_CENTERED    = 0x00000000U,
    DIDAL_LEFTALIGNED = 0x00000001U,
}

enum uint DIDAL_RIGHTALIGNED = 0x00000002U;

enum : uint
{
    DIDAL_MIDDLE     = 0x00000000U,
    DIDAL_TOPALIGNED = 0x00000004U,
}

enum uint DIDAL_BOTTOMALIGNED = 0x00000008U;

enum : uint
{
    DIDOI_FFACTUATOR      = 0x00000001U,
    DIDOI_FFEFFECTTRIGGER = 0x00000002U,
}

enum : uint
{
    DIDOI_POLLED         = 0x00008000U,
    DIDOI_ASPECTPOSITION = 0x00000100U,
    DIDOI_ASPECTVELOCITY = 0x00000200U,
    DIDOI_ASPECTACCEL    = 0x00000300U,
    DIDOI_ASPECTFORCE    = 0x00000400U,
    DIDOI_ASPECTMASK     = 0x00000f00U,
}

enum uint DIDOI_GUIDISUSAGE = 0x00010000U;

enum : uint
{
    DIPH_DEVICE   = 0x00000000U,
    DIPH_BYOFFSET = 0x00000001U,
    DIPH_BYID     = 0x00000002U,
    DIPH_BYUSAGE  = 0x00000003U,
}

enum uint MAXCPOINTSNUM = 0x00000008U;

enum : GUID
{
    DIPROP_BUFFERSIZE = GUID("00000000-0000-0000-0000-000000000001"),
    DIPROP_AXISMODE   = GUID("00000000-0000-0000-0000-000000000002"),
}

enum : uint
{
    DIPROPAXISMODE_ABS = 0x00000000U,
    DIPROPAXISMODE_REL = 0x00000001U,
}

enum GUID DIPROP_GRANULARITY = GUID("00000000-0000-0000-0000-000000000003");

enum : GUID
{
    DIPROP_RANGE      = GUID("00000000-0000-0000-0000-000000000004"),
    DIPROP_DEADZONE   = GUID("00000000-0000-0000-0000-000000000005"),
    DIPROP_SATURATION = GUID("00000000-0000-0000-0000-000000000006"),
    DIPROP_FFGAIN     = GUID("00000000-0000-0000-0000-000000000007"),
    DIPROP_FFLOAD     = GUID("00000000-0000-0000-0000-000000000008"),
    DIPROP_AUTOCENTER = GUID("00000000-0000-0000-0000-000000000009"),
}

enum : uint
{
    DIPROPAUTOCENTER_OFF = 0x00000000U,
    DIPROPAUTOCENTER_ON  = 0x00000001U,
}

enum GUID DIPROP_CALIBRATIONMODE = GUID("00000000-0000-0000-0000-00000000000a");

enum : uint
{
    DIPROPCALIBRATIONMODE_COOKED = 0x00000000U,
    DIPROPCALIBRATIONMODE_RAW    = 0x00000001U,
}

enum GUID DIPROP_CALIBRATION = GUID("00000000-0000-0000-0000-00000000000b");
enum GUID DIPROP_GUIDANDPATH = GUID("00000000-0000-0000-0000-00000000000c");
enum GUID DIPROP_INSTANCENAME = GUID("00000000-0000-0000-0000-00000000000d");
enum GUID DIPROP_PRODUCTNAME = GUID("00000000-0000-0000-0000-00000000000e");

enum : GUID
{
    DIPROP_JOYSTICKID         = GUID("00000000-0000-0000-0000-00000000000f"),
    DIPROP_GETPORTDISPLAYNAME = GUID("00000000-0000-0000-0000-000000000010"),
}

enum GUID DIPROP_PHYSICALRANGE = GUID("00000000-0000-0000-0000-000000000012");
enum GUID DIPROP_LOGICALRANGE = GUID("00000000-0000-0000-0000-000000000013");

enum : GUID
{
    DIPROP_KEYNAME  = GUID("00000000-0000-0000-0000-000000000014"),
    DIPROP_CPOINTS  = GUID("00000000-0000-0000-0000-000000000015"),
    DIPROP_APPDATA  = GUID("00000000-0000-0000-0000-000000000016"),
    DIPROP_SCANCODE = GUID("00000000-0000-0000-0000-000000000017"),
    DIPROP_VIDPID   = GUID("00000000-0000-0000-0000-000000000018"),
    DIPROP_USERNAME = GUID("00000000-0000-0000-0000-000000000019"),
    DIPROP_TYPENAME = GUID("00000000-0000-0000-0000-00000000001a"),
}

enum uint DIGDD_PEEK = 0x00000001U;
enum uint DISCL_EXCLUSIVE = 0x00000001U;
enum uint DISCL_NONEXCLUSIVE = 0x00000002U;
enum uint DISCL_FOREGROUND = 0x00000004U;
enum uint DISCL_BACKGROUND = 0x00000008U;
enum uint DISCL_NOWINKEY = 0x00000010U;

enum : uint
{
    DISFFC_RESET           = 0x00000001U,
    DISFFC_STOPALL         = 0x00000002U,
    DISFFC_PAUSE           = 0x00000004U,
    DISFFC_CONTINUE        = 0x00000008U,
    DISFFC_SETACTUATORSON  = 0x00000010U,
    DISFFC_SETACTUATORSOFF = 0x00000020U,
}

enum : uint
{
    DIGFFS_EMPTY        = 0x00000001U,
    DIGFFS_STOPPED      = 0x00000002U,
    DIGFFS_PAUSED       = 0x00000004U,
    DIGFFS_ACTUATORSON  = 0x00000010U,
    DIGFFS_ACTUATORSOFF = 0x00000020U,
}

enum : uint
{
    DIGFFS_POWERON         = 0x00000040U,
    DIGFFS_POWEROFF        = 0x00000080U,
    DIGFFS_SAFETYSWITCHON  = 0x00000100U,
    DIGFFS_SAFETYSWITCHOFF = 0x00000200U,
}

enum : uint
{
    DIGFFS_USERFFSWITCHON  = 0x00000400U,
    DIGFFS_USERFFSWITCHOFF = 0x00000800U,
}

enum uint DIGFFS_DEVICELOST = 0x80000000U;
enum uint DISDD_CONTINUE = 0x00000001U;

enum : uint
{
    DIFEF_DEFAULT            = 0x00000000U,
    DIFEF_INCLUDENONSTANDARD = 0x00000001U,
}

enum uint DIFEF_MODIFYIFNEEDED = 0x00000010U;
enum uint DIK_ESCAPE = 0x00000001U;

enum : uint
{
    DIK_1      = 0x00000002U,
    DIK_2      = 0x00000003U,
    DIK_3      = 0x00000004U,
    DIK_4      = 0x00000005U,
    DIK_5      = 0x00000006U,
    DIK_6      = 0x00000007U,
    DIK_7      = 0x00000008U,
    DIK_8      = 0x00000009U,
    DIK_9      = 0x0000000aU,
    DIK_0      = 0x0000000bU,
    DIK_MINUS  = 0x0000000cU,
    DIK_EQUALS = 0x0000000dU,
}

enum : uint
{
    DIK_BACK     = 0x0000000eU,
    DIK_TAB      = 0x0000000fU,
    DIK_Q        = 0x00000010U,
    DIK_W        = 0x00000011U,
    DIK_E        = 0x00000012U,
    DIK_R        = 0x00000013U,
    DIK_T        = 0x00000014U,
    DIK_Y        = 0x00000015U,
    DIK_U        = 0x00000016U,
    DIK_I        = 0x00000017U,
    DIK_O        = 0x00000018U,
    DIK_P        = 0x00000019U,
    DIK_LBRACKET = 0x0000001aU,
}

enum : uint
{
    DIK_RBRACKET = 0x0000001bU,
    DIK_RETURN   = 0x0000001cU,
}

enum uint DIK_LCONTROL = 0x0000001dU;

enum : uint
{
    DIK_A         = 0x0000001eU,
    DIK_S         = 0x0000001fU,
    DIK_D         = 0x00000020U,
    DIK_F         = 0x00000021U,
    DIK_G         = 0x00000022U,
    DIK_H         = 0x00000023U,
    DIK_J         = 0x00000024U,
    DIK_K         = 0x00000025U,
    DIK_L         = 0x00000026U,
    DIK_SEMICOLON = 0x00000027U,
}

enum uint DIK_APOSTROPHE = 0x00000028U;

enum : uint
{
    DIK_GRAVE  = 0x00000029U,
    DIK_LSHIFT = 0x0000002aU,
}

enum uint DIK_BACKSLASH = 0x0000002bU;

enum : uint
{
    DIK_Z      = 0x0000002cU,
    DIK_X      = 0x0000002dU,
    DIK_C      = 0x0000002eU,
    DIK_V      = 0x0000002fU,
    DIK_B      = 0x00000030U,
    DIK_N      = 0x00000031U,
    DIK_M      = 0x00000032U,
    DIK_COMMA  = 0x00000033U,
    DIK_PERIOD = 0x00000034U,
}

enum : uint
{
    DIK_SLASH  = 0x00000035U,
    DIK_RSHIFT = 0x00000036U,
}

enum uint DIK_MULTIPLY = 0x00000037U;

enum : uint
{
    DIK_LMENU   = 0x00000038U,
    DIK_SPACE   = 0x00000039U,
    DIK_CAPITAL = 0x0000003aU,
}

enum : uint
{
    DIK_F1      = 0x0000003bU,
    DIK_F2      = 0x0000003cU,
    DIK_F3      = 0x0000003dU,
    DIK_F4      = 0x0000003eU,
    DIK_F5      = 0x0000003fU,
    DIK_F6      = 0x00000040U,
    DIK_F7      = 0x00000041U,
    DIK_F8      = 0x00000042U,
    DIK_F9      = 0x00000043U,
    DIK_F10     = 0x00000044U,
    DIK_NUMLOCK = 0x00000045U,
}

enum uint DIK_SCROLL = 0x00000046U;

enum : uint
{
    DIK_NUMPAD7 = 0x00000047U,
    DIK_NUMPAD8 = 0x00000048U,
    DIK_NUMPAD9 = 0x00000049U,
}

enum uint DIK_SUBTRACT = 0x0000004aU;

enum : uint
{
    DIK_NUMPAD4 = 0x0000004bU,
    DIK_NUMPAD5 = 0x0000004cU,
    DIK_NUMPAD6 = 0x0000004dU,
}

enum : uint
{
    DIK_ADD     = 0x0000004eU,
    DIK_NUMPAD1 = 0x0000004fU,
    DIK_NUMPAD2 = 0x00000050U,
    DIK_NUMPAD3 = 0x00000051U,
    DIK_NUMPAD0 = 0x00000052U,
}

enum uint DIK_DECIMAL = 0x00000053U;
enum uint DIK_OEM_102 = 0x00000056U;

enum : uint
{
    DIK_F11     = 0x00000057U,
    DIK_F12     = 0x00000058U,
    DIK_F13     = 0x00000064U,
    DIK_F14     = 0x00000065U,
    DIK_F15     = 0x00000066U,
    DIK_KANA    = 0x00000070U,
    DIK_ABNT_C1 = 0x00000073U,
}

enum uint DIK_CONVERT = 0x00000079U;
enum uint DIK_NOCONVERT = 0x0000007bU;

enum : uint
{
    DIK_YEN     = 0x0000007dU,
    DIK_ABNT_C2 = 0x0000007eU,
}

enum uint DIK_NUMPADEQUALS = 0x0000008dU;
enum uint DIK_PREVTRACK = 0x00000090U;

enum : uint
{
    DIK_AT        = 0x00000091U,
    DIK_COLON     = 0x00000092U,
    DIK_UNDERLINE = 0x00000093U,
}

enum : uint
{
    DIK_KANJI     = 0x00000094U,
    DIK_STOP      = 0x00000095U,
    DIK_AX        = 0x00000096U,
    DIK_UNLABELED = 0x00000097U,
}

enum uint DIK_NEXTTRACK = 0x00000099U;
enum uint DIK_NUMPADENTER = 0x0000009cU;
enum uint DIK_RCONTROL = 0x0000009dU;

enum : uint
{
    DIK_MUTE       = 0x000000a0U,
    DIK_CALCULATOR = 0x000000a1U,
}

enum uint DIK_PLAYPAUSE = 0x000000a2U;
enum uint DIK_MEDIASTOP = 0x000000a4U;

enum : uint
{
    DIK_VOLUMEDOWN = 0x000000aeU,
    DIK_VOLUMEUP   = 0x000000b0U,
}

enum uint DIK_WEBHOME = 0x000000b2U;
enum uint DIK_NUMPADCOMMA = 0x000000b3U;
enum uint DIK_DIVIDE = 0x000000b5U;

enum : uint
{
    DIK_SYSRQ  = 0x000000b7U,
    DIK_RMENU  = 0x000000b8U,
    DIK_PAUSE  = 0x000000c5U,
    DIK_HOME   = 0x000000c7U,
    DIK_UP     = 0x000000c8U,
    DIK_PRIOR  = 0x000000c9U,
    DIK_LEFT   = 0x000000cbU,
    DIK_RIGHT  = 0x000000cdU,
    DIK_END    = 0x000000cfU,
    DIK_DOWN   = 0x000000d0U,
    DIK_NEXT   = 0x000000d1U,
    DIK_INSERT = 0x000000d2U,
}

enum uint DIK_DELETE = 0x000000d3U;

enum : uint
{
    DIK_LWIN         = 0x000000dbU,
    DIK_RWIN         = 0x000000dcU,
    DIK_APPS         = 0x000000ddU,
    DIK_POWER        = 0x000000deU,
    DIK_SLEEP        = 0x000000dfU,
    DIK_WAKE         = 0x000000e3U,
    DIK_WEBSEARCH    = 0x000000e5U,
    DIK_WEBFAVORITES = 0x000000e6U,
    DIK_WEBREFRESH   = 0x000000e7U,
    DIK_WEBSTOP      = 0x000000e8U,
    DIK_WEBFORWARD   = 0x000000e9U,
    DIK_WEBBACK      = 0x000000eaU,
}

enum uint DIK_MYCOMPUTER = 0x000000ebU;

enum : uint
{
    DIK_MAIL        = 0x000000ecU,
    DIK_MEDIASELECT = 0x000000edU,
}

enum uint DIK_BACKSPACE = 0x0000000eU;
enum uint DIK_NUMPADSTAR = 0x00000037U;

enum : uint
{
    DIK_LALT     = 0x00000038U,
    DIK_CAPSLOCK = 0x0000003aU,
}

enum : uint
{
    DIK_NUMPADMINUS  = 0x0000004aU,
    DIK_NUMPADPLUS   = 0x0000004eU,
    DIK_NUMPADPERIOD = 0x00000053U,
    DIK_NUMPADSLASH  = 0x000000b5U,
}

enum : uint
{
    DIK_RALT    = 0x000000b8U,
    DIK_UPARROW = 0x000000c8U,
}

enum : uint
{
    DIK_PGUP      = 0x000000c9U,
    DIK_LEFTARROW = 0x000000cbU,
}

enum uint DIK_RIGHTARROW = 0x000000cdU;
enum uint DIK_DOWNARROW = 0x000000d0U;

enum : uint
{
    DIK_PGDN       = 0x000000d1U,
    DIK_CIRCUMFLEX = 0x00000090U,
}

enum : uint
{
    DIENUM_STOP     = 0x00000000U,
    DIENUM_CONTINUE = 0x00000001U,
}

enum : uint
{
    DIEDFL_ALLDEVICES   = 0x00000000U,
    DIEDFL_ATTACHEDONLY = 0x00000001U,
}

enum uint DIEDFL_FORCEFEEDBACK = 0x00000100U;

enum : uint
{
    DIEDFL_INCLUDEALIASES  = 0x00010000U,
    DIEDFL_INCLUDEPHANTOMS = 0x00020000U,
    DIEDFL_INCLUDEHIDDEN   = 0x00040000U,
}

enum : uint
{
    DIEDBS_MAPPEDPRI1   = 0x00000001U,
    DIEDBS_MAPPEDPRI2   = 0x00000002U,
    DIEDBS_RECENTDEVICE = 0x00000010U,
}

enum uint DIEDBS_NEWDEVICE = 0x00000020U;

enum : uint
{
    DIEDBSFL_ATTACHEDONLY     = 0x00000000U,
    DIEDBSFL_THISUSER         = 0x00000010U,
    DIEDBSFL_FORCEFEEDBACK    = 0x00000100U,
    DIEDBSFL_AVAILABLEDEVICES = 0x00001000U,
}

enum uint DIEDBSFL_MULTIMICEKEYBOARDS = 0x00002000U;
enum uint DIEDBSFL_NONGAMINGDEVICES = 0x00004000U;
enum uint DIEDBSFL_VALID = 0x00007110U;

enum : int
{
    DI_OK          = 0x00000000,
    DI_NOTATTACHED = 0x00000001,
}

enum int DI_BUFFEROVERFLOW = 0x00000001;
enum int DI_PROPNOEFFECT = 0x00000001;
enum int DI_NOEFFECT = 0x00000001;
enum HRESULT DI_POLLEDDEVICE = HRESULT(0x00000002);
enum HRESULT DI_DOWNLOADSKIPPED = HRESULT(0x00000003);
enum HRESULT DI_EFFECTRESTARTED = HRESULT(0x00000004);
enum HRESULT DI_TRUNCATED = HRESULT(0x00000008);
enum HRESULT DI_SETTINGSNOTSAVED = HRESULT(0x0000000b);
enum HRESULT DI_TRUNCATEDANDRESTARTED = HRESULT(0x0000000c);
enum HRESULT DI_WRITEPROTECT = HRESULT(0x00000013);
enum HRESULT DIERR_OLDDIRECTINPUTVERSION = HRESULT(0x8007047e);
enum HRESULT DIERR_BETADIRECTINPUTVERSION = HRESULT(0x80070481);
enum HRESULT DIERR_BADDRIVERVER = HRESULT(0x80070077);
enum int DIERR_DEVICENOTREG = 0x80040154;

enum : HRESULT
{
    DIERR_NOTFOUND       = HRESULT(0x80070002),
    DIERR_OBJECTNOTFOUND = HRESULT(0x80070002),
}

enum int DIERR_INVALIDPARAM = 0x80070057;
enum int DIERR_NOINTERFACE = 0x80004002;

enum : int
{
    DIERR_GENERIC     = 0x80004005,
    DIERR_OUTOFMEMORY = 0x8007000e,
}

enum int DIERR_UNSUPPORTED = 0x80004001;
enum HRESULT DIERR_NOTINITIALIZED = HRESULT(0x80070015);
enum HRESULT DIERR_ALREADYINITIALIZED = HRESULT(0x800704df);
enum int DIERR_NOAGGREGATION = 0x80040110;
enum int DIERR_OTHERAPPHASPRIO = 0x80070005;
enum HRESULT DIERR_INPUTLOST = HRESULT(0x8007001e);

enum : HRESULT
{
    DIERR_ACQUIRED    = HRESULT(0x800700aa),
    DIERR_NOTACQUIRED = HRESULT(0x8007000c),
}

enum : int
{
    DIERR_READONLY     = 0x80070005,
    DIERR_HANDLEEXISTS = 0x80070005,
}

enum int DIERR_INSUFFICIENTPRIVS = 0x80040200;
enum int DIERR_DEVICEFULL = 0x80040201;

enum : int
{
    DIERR_MOREDATA      = 0x80040202,
    DIERR_NOTDOWNLOADED = 0x80040203,
}

enum int DIERR_HASEFFECTS = 0x80040204;
enum int DIERR_NOTEXCLUSIVEACQUIRED = 0x80040205;
enum int DIERR_INCOMPLETEEFFECT = 0x80040206;
enum int DIERR_NOTBUFFERED = 0x80040207;
enum int DIERR_EFFECTPLAYING = 0x80040208;
enum int DIERR_UNPLUGGED = 0x80040209;
enum int DIERR_REPORTFULL = 0x8004020a;
enum int DIERR_MAPFILEFAIL = 0x8004020b;

enum : uint
{
    DIKEYBOARD_ESCAPE       = 0x81000401U,
    DIKEYBOARD_1            = 0x81000402U,
    DIKEYBOARD_2            = 0x81000403U,
    DIKEYBOARD_3            = 0x81000404U,
    DIKEYBOARD_4            = 0x81000405U,
    DIKEYBOARD_5            = 0x81000406U,
    DIKEYBOARD_6            = 0x81000407U,
    DIKEYBOARD_7            = 0x81000408U,
    DIKEYBOARD_8            = 0x81000409U,
    DIKEYBOARD_9            = 0x8100040aU,
    DIKEYBOARD_0            = 0x8100040bU,
    DIKEYBOARD_MINUS        = 0x8100040cU,
    DIKEYBOARD_EQUALS       = 0x8100040dU,
    DIKEYBOARD_BACK         = 0x8100040eU,
    DIKEYBOARD_TAB          = 0x8100040fU,
    DIKEYBOARD_Q            = 0x81000410U,
    DIKEYBOARD_W            = 0x81000411U,
    DIKEYBOARD_E            = 0x81000412U,
    DIKEYBOARD_R            = 0x81000413U,
    DIKEYBOARD_T            = 0x81000414U,
    DIKEYBOARD_Y            = 0x81000415U,
    DIKEYBOARD_U            = 0x81000416U,
    DIKEYBOARD_I            = 0x81000417U,
    DIKEYBOARD_O            = 0x81000418U,
    DIKEYBOARD_P            = 0x81000419U,
    DIKEYBOARD_LBRACKET     = 0x8100041aU,
    DIKEYBOARD_RBRACKET     = 0x8100041bU,
    DIKEYBOARD_RETURN       = 0x8100041cU,
    DIKEYBOARD_LCONTROL     = 0x8100041dU,
    DIKEYBOARD_A            = 0x8100041eU,
    DIKEYBOARD_S            = 0x8100041fU,
    DIKEYBOARD_D            = 0x81000420U,
    DIKEYBOARD_F            = 0x81000421U,
    DIKEYBOARD_G            = 0x81000422U,
    DIKEYBOARD_H            = 0x81000423U,
    DIKEYBOARD_J            = 0x81000424U,
    DIKEYBOARD_K            = 0x81000425U,
    DIKEYBOARD_L            = 0x81000426U,
    DIKEYBOARD_SEMICOLON    = 0x81000427U,
    DIKEYBOARD_APOSTROPHE   = 0x81000428U,
    DIKEYBOARD_GRAVE        = 0x81000429U,
    DIKEYBOARD_LSHIFT       = 0x8100042aU,
    DIKEYBOARD_BACKSLASH    = 0x8100042bU,
    DIKEYBOARD_Z            = 0x8100042cU,
    DIKEYBOARD_X            = 0x8100042dU,
    DIKEYBOARD_C            = 0x8100042eU,
    DIKEYBOARD_V            = 0x8100042fU,
    DIKEYBOARD_B            = 0x81000430U,
    DIKEYBOARD_N            = 0x81000431U,
    DIKEYBOARD_M            = 0x81000432U,
    DIKEYBOARD_COMMA        = 0x81000433U,
    DIKEYBOARD_PERIOD       = 0x81000434U,
    DIKEYBOARD_SLASH        = 0x81000435U,
    DIKEYBOARD_RSHIFT       = 0x81000436U,
    DIKEYBOARD_MULTIPLY     = 0x81000437U,
    DIKEYBOARD_LMENU        = 0x81000438U,
    DIKEYBOARD_SPACE        = 0x81000439U,
    DIKEYBOARD_CAPITAL      = 0x8100043aU,
    DIKEYBOARD_F1           = 0x8100043bU,
    DIKEYBOARD_F2           = 0x8100043cU,
    DIKEYBOARD_F3           = 0x8100043dU,
    DIKEYBOARD_F4           = 0x8100043eU,
    DIKEYBOARD_F5           = 0x8100043fU,
    DIKEYBOARD_F6           = 0x81000440U,
    DIKEYBOARD_F7           = 0x81000441U,
    DIKEYBOARD_F8           = 0x81000442U,
    DIKEYBOARD_F9           = 0x81000443U,
    DIKEYBOARD_F10          = 0x81000444U,
    DIKEYBOARD_NUMLOCK      = 0x81000445U,
    DIKEYBOARD_SCROLL       = 0x81000446U,
    DIKEYBOARD_NUMPAD7      = 0x81000447U,
    DIKEYBOARD_NUMPAD8      = 0x81000448U,
    DIKEYBOARD_NUMPAD9      = 0x81000449U,
    DIKEYBOARD_SUBTRACT     = 0x8100044aU,
    DIKEYBOARD_NUMPAD4      = 0x8100044bU,
    DIKEYBOARD_NUMPAD5      = 0x8100044cU,
    DIKEYBOARD_NUMPAD6      = 0x8100044dU,
    DIKEYBOARD_ADD          = 0x8100044eU,
    DIKEYBOARD_NUMPAD1      = 0x8100044fU,
    DIKEYBOARD_NUMPAD2      = 0x81000450U,
    DIKEYBOARD_NUMPAD3      = 0x81000451U,
    DIKEYBOARD_NUMPAD0      = 0x81000452U,
    DIKEYBOARD_DECIMAL      = 0x81000453U,
    DIKEYBOARD_OEM_102      = 0x81000456U,
    DIKEYBOARD_F11          = 0x81000457U,
    DIKEYBOARD_F12          = 0x81000458U,
    DIKEYBOARD_F13          = 0x81000464U,
    DIKEYBOARD_F14          = 0x81000465U,
    DIKEYBOARD_F15          = 0x81000466U,
    DIKEYBOARD_KANA         = 0x81000470U,
    DIKEYBOARD_ABNT_C1      = 0x81000473U,
    DIKEYBOARD_CONVERT      = 0x81000479U,
    DIKEYBOARD_NOCONVERT    = 0x8100047bU,
    DIKEYBOARD_YEN          = 0x8100047dU,
    DIKEYBOARD_ABNT_C2      = 0x8100047eU,
    DIKEYBOARD_NUMPADEQUALS = 0x8100048dU,
    DIKEYBOARD_PREVTRACK    = 0x81000490U,
    DIKEYBOARD_AT           = 0x81000491U,
    DIKEYBOARD_COLON        = 0x81000492U,
    DIKEYBOARD_UNDERLINE    = 0x81000493U,
    DIKEYBOARD_KANJI        = 0x81000494U,
    DIKEYBOARD_STOP         = 0x81000495U,
    DIKEYBOARD_AX           = 0x81000496U,
    DIKEYBOARD_UNLABELED    = 0x81000497U,
    DIKEYBOARD_NEXTTRACK    = 0x81000499U,
    DIKEYBOARD_NUMPADENTER  = 0x8100049cU,
    DIKEYBOARD_RCONTROL     = 0x8100049dU,
    DIKEYBOARD_MUTE         = 0x810004a0U,
    DIKEYBOARD_CALCULATOR   = 0x810004a1U,
    DIKEYBOARD_PLAYPAUSE    = 0x810004a2U,
    DIKEYBOARD_MEDIASTOP    = 0x810004a4U,
    DIKEYBOARD_VOLUMEDOWN   = 0x810004aeU,
    DIKEYBOARD_VOLUMEUP     = 0x810004b0U,
    DIKEYBOARD_WEBHOME      = 0x810004b2U,
    DIKEYBOARD_NUMPADCOMMA  = 0x810004b3U,
    DIKEYBOARD_DIVIDE       = 0x810004b5U,
    DIKEYBOARD_SYSRQ        = 0x810004b7U,
    DIKEYBOARD_RMENU        = 0x810004b8U,
    DIKEYBOARD_PAUSE        = 0x810004c5U,
    DIKEYBOARD_HOME         = 0x810004c7U,
    DIKEYBOARD_UP           = 0x810004c8U,
    DIKEYBOARD_PRIOR        = 0x810004c9U,
    DIKEYBOARD_LEFT         = 0x810004cbU,
    DIKEYBOARD_RIGHT        = 0x810004cdU,
    DIKEYBOARD_END          = 0x810004cfU,
    DIKEYBOARD_DOWN         = 0x810004d0U,
    DIKEYBOARD_NEXT         = 0x810004d1U,
    DIKEYBOARD_INSERT       = 0x810004d2U,
    DIKEYBOARD_DELETE       = 0x810004d3U,
    DIKEYBOARD_LWIN         = 0x810004dbU,
    DIKEYBOARD_RWIN         = 0x810004dcU,
    DIKEYBOARD_APPS         = 0x810004ddU,
    DIKEYBOARD_POWER        = 0x810004deU,
    DIKEYBOARD_SLEEP        = 0x810004dfU,
    DIKEYBOARD_WAKE         = 0x810004e3U,
    DIKEYBOARD_WEBSEARCH    = 0x810004e5U,
    DIKEYBOARD_WEBFAVORITES = 0x810004e6U,
    DIKEYBOARD_WEBREFRESH   = 0x810004e7U,
    DIKEYBOARD_WEBSTOP      = 0x810004e8U,
    DIKEYBOARD_WEBFORWARD   = 0x810004e9U,
    DIKEYBOARD_WEBBACK      = 0x810004eaU,
    DIKEYBOARD_MYCOMPUTER   = 0x810004ebU,
    DIKEYBOARD_MAIL         = 0x810004ecU,
    DIKEYBOARD_MEDIASELECT  = 0x810004edU,
}

enum : uint
{
    DIVOICE_CHANNEL1     = 0x83000401U,
    DIVOICE_CHANNEL2     = 0x83000402U,
    DIVOICE_CHANNEL3     = 0x83000403U,
    DIVOICE_CHANNEL4     = 0x83000404U,
    DIVOICE_CHANNEL5     = 0x83000405U,
    DIVOICE_CHANNEL6     = 0x83000406U,
    DIVOICE_CHANNEL7     = 0x83000407U,
    DIVOICE_CHANNEL8     = 0x83000408U,
    DIVOICE_TEAM         = 0x83000409U,
    DIVOICE_ALL          = 0x8300040aU,
    DIVOICE_RECORDMUTE   = 0x8300040bU,
    DIVOICE_PLAYBACKMUTE = 0x8300040cU,
}

enum : uint
{
    DIVOICE_TRANSMIT     = 0x8300040dU,
    DIVOICE_VOICECOMMAND = 0x83000410U,
}

enum uint DIVIRTUAL_DRIVING_RACE = 0x01000000U;

enum : uint
{
    DIAXIS_DRIVINGR_STEER      = 0x01008a01U,
    DIAXIS_DRIVINGR_ACCELERATE = 0x01039202U,
    DIAXIS_DRIVINGR_BRAKE      = 0x01041203U,
}

enum : uint
{
    DIBUTTON_DRIVINGR_SHIFTUP   = 0x01000c01U,
    DIBUTTON_DRIVINGR_SHIFTDOWN = 0x01000c02U,
    DIBUTTON_DRIVINGR_VIEW      = 0x01001c03U,
    DIBUTTON_DRIVINGR_MENU      = 0x010004fdU,
}

enum uint DIAXIS_DRIVINGR_ACCEL_AND_BRAKE = 0x01014a04U;
enum uint DIHATSWITCH_DRIVINGR_GLANCE = 0x01004601U;

enum : uint
{
    DIBUTTON_DRIVINGR_BRAKE             = 0x01004c04U,
    DIBUTTON_DRIVINGR_DASHBOARD         = 0x01004405U,
    DIBUTTON_DRIVINGR_AIDS              = 0x01004406U,
    DIBUTTON_DRIVINGR_MAP               = 0x01004407U,
    DIBUTTON_DRIVINGR_BOOST             = 0x01004408U,
    DIBUTTON_DRIVINGR_PIT               = 0x01004409U,
    DIBUTTON_DRIVINGR_ACCELERATE_LINK   = 0x0103d4e0U,
    DIBUTTON_DRIVINGR_STEER_LEFT_LINK   = 0x0100cce4U,
    DIBUTTON_DRIVINGR_STEER_RIGHT_LINK  = 0x0100ccecU,
    DIBUTTON_DRIVINGR_GLANCE_LEFT_LINK  = 0x0107c4e4U,
    DIBUTTON_DRIVINGR_GLANCE_RIGHT_LINK = 0x0107c4ecU,
    DIBUTTON_DRIVINGR_DEVICE            = 0x010044feU,
    DIBUTTON_DRIVINGR_PAUSE             = 0x010044fcU,
}

enum uint DIVIRTUAL_DRIVING_COMBAT = 0x02000000U;

enum : uint
{
    DIAXIS_DRIVINGC_STEER      = 0x02008a01U,
    DIAXIS_DRIVINGC_ACCELERATE = 0x02039202U,
    DIAXIS_DRIVINGC_BRAKE      = 0x02041203U,
}

enum : uint
{
    DIBUTTON_DRIVINGC_FIRE    = 0x02000c01U,
    DIBUTTON_DRIVINGC_WEAPONS = 0x02000c02U,
    DIBUTTON_DRIVINGC_TARGET  = 0x02000c03U,
    DIBUTTON_DRIVINGC_MENU    = 0x020004fdU,
}

enum uint DIAXIS_DRIVINGC_ACCEL_AND_BRAKE = 0x02014a04U;
enum uint DIHATSWITCH_DRIVINGC_GLANCE = 0x02004601U;

enum : uint
{
    DIBUTTON_DRIVINGC_SHIFTUP           = 0x02004c04U,
    DIBUTTON_DRIVINGC_SHIFTDOWN         = 0x02004c05U,
    DIBUTTON_DRIVINGC_DASHBOARD         = 0x02004406U,
    DIBUTTON_DRIVINGC_AIDS              = 0x02004407U,
    DIBUTTON_DRIVINGC_BRAKE             = 0x02004c08U,
    DIBUTTON_DRIVINGC_FIRESECONDARY     = 0x02004c09U,
    DIBUTTON_DRIVINGC_ACCELERATE_LINK   = 0x0203d4e0U,
    DIBUTTON_DRIVINGC_STEER_LEFT_LINK   = 0x0200cce4U,
    DIBUTTON_DRIVINGC_STEER_RIGHT_LINK  = 0x0200ccecU,
    DIBUTTON_DRIVINGC_GLANCE_LEFT_LINK  = 0x0207c4e4U,
    DIBUTTON_DRIVINGC_GLANCE_RIGHT_LINK = 0x0207c4ecU,
    DIBUTTON_DRIVINGC_DEVICE            = 0x020044feU,
    DIBUTTON_DRIVINGC_PAUSE             = 0x020044fcU,
}

enum uint DIVIRTUAL_DRIVING_TANK = 0x03000000U;

enum : uint
{
    DIAXIS_DRIVINGT_STEER      = 0x03008a01U,
    DIAXIS_DRIVINGT_BARREL     = 0x03010202U,
    DIAXIS_DRIVINGT_ACCELERATE = 0x03039203U,
    DIAXIS_DRIVINGT_ROTATE     = 0x03020204U,
}

enum : uint
{
    DIBUTTON_DRIVINGT_FIRE    = 0x03000c01U,
    DIBUTTON_DRIVINGT_WEAPONS = 0x03000c02U,
    DIBUTTON_DRIVINGT_TARGET  = 0x03000c03U,
    DIBUTTON_DRIVINGT_MENU    = 0x030004fdU,
}

enum uint DIHATSWITCH_DRIVINGT_GLANCE = 0x03004601U;

enum : uint
{
    DIAXIS_DRIVINGT_BRAKE           = 0x03045205U,
    DIAXIS_DRIVINGT_ACCEL_AND_BRAKE = 0x03014a06U,
}

enum : uint
{
    DIBUTTON_DRIVINGT_VIEW              = 0x03005c04U,
    DIBUTTON_DRIVINGT_DASHBOARD         = 0x03005c05U,
    DIBUTTON_DRIVINGT_BRAKE             = 0x03004c06U,
    DIBUTTON_DRIVINGT_FIRESECONDARY     = 0x03004c07U,
    DIBUTTON_DRIVINGT_ACCELERATE_LINK   = 0x0303d4e0U,
    DIBUTTON_DRIVINGT_STEER_LEFT_LINK   = 0x0300cce4U,
    DIBUTTON_DRIVINGT_STEER_RIGHT_LINK  = 0x0300ccecU,
    DIBUTTON_DRIVINGT_BARREL_UP_LINK    = 0x030144e0U,
    DIBUTTON_DRIVINGT_BARREL_DOWN_LINK  = 0x030144e8U,
    DIBUTTON_DRIVINGT_ROTATE_LEFT_LINK  = 0x030244e4U,
    DIBUTTON_DRIVINGT_ROTATE_RIGHT_LINK = 0x030244ecU,
    DIBUTTON_DRIVINGT_GLANCE_LEFT_LINK  = 0x0307c4e4U,
    DIBUTTON_DRIVINGT_GLANCE_RIGHT_LINK = 0x0307c4ecU,
    DIBUTTON_DRIVINGT_DEVICE            = 0x030044feU,
    DIBUTTON_DRIVINGT_PAUSE             = 0x030044fcU,
}

enum uint DIVIRTUAL_FLYING_CIVILIAN = 0x04000000U;

enum : uint
{
    DIAXIS_FLYINGC_BANK     = 0x04008a01U,
    DIAXIS_FLYINGC_PITCH    = 0x04010a02U,
    DIAXIS_FLYINGC_THROTTLE = 0x04039203U,
}

enum : uint
{
    DIBUTTON_FLYINGC_VIEW    = 0x04002401U,
    DIBUTTON_FLYINGC_DISPLAY = 0x04002402U,
    DIBUTTON_FLYINGC_GEAR    = 0x04002c03U,
    DIBUTTON_FLYINGC_MENU    = 0x040004fdU,
}

enum uint DIHATSWITCH_FLYINGC_GLANCE = 0x04004601U;

enum : uint
{
    DIAXIS_FLYINGC_BRAKE  = 0x04046a04U,
    DIAXIS_FLYINGC_RUDDER = 0x04025205U,
    DIAXIS_FLYINGC_FLAPS  = 0x04055a06U,
}

enum : uint
{
    DIBUTTON_FLYINGC_FLAPSUP           = 0x04006404U,
    DIBUTTON_FLYINGC_FLAPSDOWN         = 0x04006405U,
    DIBUTTON_FLYINGC_BRAKE_LINK        = 0x04046ce0U,
    DIBUTTON_FLYINGC_FASTER_LINK       = 0x0403d4e0U,
    DIBUTTON_FLYINGC_SLOWER_LINK       = 0x0403d4e8U,
    DIBUTTON_FLYINGC_GLANCE_LEFT_LINK  = 0x0407c4e4U,
    DIBUTTON_FLYINGC_GLANCE_RIGHT_LINK = 0x0407c4ecU,
    DIBUTTON_FLYINGC_GLANCE_UP_LINK    = 0x0407c4e0U,
    DIBUTTON_FLYINGC_GLANCE_DOWN_LINK  = 0x0407c4e8U,
    DIBUTTON_FLYINGC_DEVICE            = 0x040044feU,
    DIBUTTON_FLYINGC_PAUSE             = 0x040044fcU,
}

enum uint DIVIRTUAL_FLYING_MILITARY = 0x05000000U;

enum : uint
{
    DIAXIS_FLYINGM_BANK     = 0x05008a01U,
    DIAXIS_FLYINGM_PITCH    = 0x05010a02U,
    DIAXIS_FLYINGM_THROTTLE = 0x05039203U,
}

enum : uint
{
    DIBUTTON_FLYINGM_FIRE    = 0x05000c01U,
    DIBUTTON_FLYINGM_WEAPONS = 0x05000c02U,
    DIBUTTON_FLYINGM_TARGET  = 0x05000c03U,
    DIBUTTON_FLYINGM_MENU    = 0x050004fdU,
}

enum uint DIHATSWITCH_FLYINGM_GLANCE = 0x05004601U;
enum uint DIBUTTON_FLYINGM_COUNTER = 0x05005c04U;

enum : uint
{
    DIAXIS_FLYINGM_RUDDER = 0x05024a04U,
    DIAXIS_FLYINGM_BRAKE  = 0x05046205U,
}

enum : uint
{
    DIBUTTON_FLYINGM_VIEW    = 0x05006405U,
    DIBUTTON_FLYINGM_DISPLAY = 0x05006406U,
}

enum uint DIAXIS_FLYINGM_FLAPS = 0x05055206U;

enum : uint
{
    DIBUTTON_FLYINGM_FLAPSUP           = 0x05005407U,
    DIBUTTON_FLYINGM_FLAPSDOWN         = 0x05005408U,
    DIBUTTON_FLYINGM_FIRESECONDARY     = 0x05004c09U,
    DIBUTTON_FLYINGM_GEAR              = 0x0500640aU,
    DIBUTTON_FLYINGM_BRAKE_LINK        = 0x050464e0U,
    DIBUTTON_FLYINGM_FASTER_LINK       = 0x0503d4e0U,
    DIBUTTON_FLYINGM_SLOWER_LINK       = 0x0503d4e8U,
    DIBUTTON_FLYINGM_GLANCE_LEFT_LINK  = 0x0507c4e4U,
    DIBUTTON_FLYINGM_GLANCE_RIGHT_LINK = 0x0507c4ecU,
    DIBUTTON_FLYINGM_GLANCE_UP_LINK    = 0x0507c4e0U,
    DIBUTTON_FLYINGM_GLANCE_DOWN_LINK  = 0x0507c4e8U,
    DIBUTTON_FLYINGM_DEVICE            = 0x050044feU,
    DIBUTTON_FLYINGM_PAUSE             = 0x050044fcU,
}

enum uint DIVIRTUAL_FLYING_HELICOPTER = 0x06000000U;

enum : uint
{
    DIAXIS_FLYINGH_BANK       = 0x06008a01U,
    DIAXIS_FLYINGH_PITCH      = 0x06010a02U,
    DIAXIS_FLYINGH_COLLECTIVE = 0x06018a03U,
}

enum : uint
{
    DIBUTTON_FLYINGH_FIRE    = 0x06001401U,
    DIBUTTON_FLYINGH_WEAPONS = 0x06001402U,
    DIBUTTON_FLYINGH_TARGET  = 0x06001403U,
    DIBUTTON_FLYINGH_MENU    = 0x060004fdU,
}

enum uint DIHATSWITCH_FLYINGH_GLANCE = 0x06004601U;

enum : uint
{
    DIAXIS_FLYINGH_TORQUE   = 0x06025a04U,
    DIAXIS_FLYINGH_THROTTLE = 0x0603da05U,
}

enum : uint
{
    DIBUTTON_FLYINGH_COUNTER           = 0x06005404U,
    DIBUTTON_FLYINGH_VIEW              = 0x06006405U,
    DIBUTTON_FLYINGH_GEAR              = 0x06006406U,
    DIBUTTON_FLYINGH_FIRESECONDARY     = 0x06004c07U,
    DIBUTTON_FLYINGH_FASTER_LINK       = 0x0603dce0U,
    DIBUTTON_FLYINGH_SLOWER_LINK       = 0x0603dce8U,
    DIBUTTON_FLYINGH_GLANCE_LEFT_LINK  = 0x0607c4e4U,
    DIBUTTON_FLYINGH_GLANCE_RIGHT_LINK = 0x0607c4ecU,
    DIBUTTON_FLYINGH_GLANCE_UP_LINK    = 0x0607c4e0U,
    DIBUTTON_FLYINGH_GLANCE_DOWN_LINK  = 0x0607c4e8U,
    DIBUTTON_FLYINGH_DEVICE            = 0x060044feU,
    DIBUTTON_FLYINGH_PAUSE             = 0x060044fcU,
}

enum uint DIVIRTUAL_SPACESIM = 0x07000000U;

enum : uint
{
    DIAXIS_SPACESIM_LATERAL  = 0x07008201U,
    DIAXIS_SPACESIM_MOVE     = 0x07010202U,
    DIAXIS_SPACESIM_THROTTLE = 0x07038203U,
}

enum : uint
{
    DIBUTTON_SPACESIM_FIRE    = 0x07000401U,
    DIBUTTON_SPACESIM_WEAPONS = 0x07000402U,
    DIBUTTON_SPACESIM_TARGET  = 0x07000403U,
    DIBUTTON_SPACESIM_MENU    = 0x070004fdU,
}

enum uint DIHATSWITCH_SPACESIM_GLANCE = 0x07004601U;

enum : uint
{
    DIAXIS_SPACESIM_CLIMB  = 0x0701c204U,
    DIAXIS_SPACESIM_ROTATE = 0x07024205U,
}

enum : uint
{
    DIBUTTON_SPACESIM_VIEW              = 0x07004404U,
    DIBUTTON_SPACESIM_DISPLAY           = 0x07004405U,
    DIBUTTON_SPACESIM_RAISE             = 0x07004406U,
    DIBUTTON_SPACESIM_LOWER             = 0x07004407U,
    DIBUTTON_SPACESIM_GEAR              = 0x07004408U,
    DIBUTTON_SPACESIM_FIRESECONDARY     = 0x07004409U,
    DIBUTTON_SPACESIM_LEFT_LINK         = 0x0700c4e4U,
    DIBUTTON_SPACESIM_RIGHT_LINK        = 0x0700c4ecU,
    DIBUTTON_SPACESIM_FORWARD_LINK      = 0x070144e0U,
    DIBUTTON_SPACESIM_BACKWARD_LINK     = 0x070144e8U,
    DIBUTTON_SPACESIM_FASTER_LINK       = 0x0703c4e0U,
    DIBUTTON_SPACESIM_SLOWER_LINK       = 0x0703c4e8U,
    DIBUTTON_SPACESIM_TURN_LEFT_LINK    = 0x070244e4U,
    DIBUTTON_SPACESIM_TURN_RIGHT_LINK   = 0x070244ecU,
    DIBUTTON_SPACESIM_GLANCE_LEFT_LINK  = 0x0707c4e4U,
    DIBUTTON_SPACESIM_GLANCE_RIGHT_LINK = 0x0707c4ecU,
    DIBUTTON_SPACESIM_GLANCE_UP_LINK    = 0x0707c4e0U,
    DIBUTTON_SPACESIM_GLANCE_DOWN_LINK  = 0x0707c4e8U,
    DIBUTTON_SPACESIM_DEVICE            = 0x070044feU,
    DIBUTTON_SPACESIM_PAUSE             = 0x070044fcU,
}

enum uint DIVIRTUAL_FIGHTING_HAND2HAND = 0x08000000U;

enum : uint
{
    DIAXIS_FIGHTINGH_LATERAL = 0x08008201U,
    DIAXIS_FIGHTINGH_MOVE    = 0x08010202U,
}

enum : uint
{
    DIBUTTON_FIGHTINGH_PUNCH    = 0x08000401U,
    DIBUTTON_FIGHTINGH_KICK     = 0x08000402U,
    DIBUTTON_FIGHTINGH_BLOCK    = 0x08000403U,
    DIBUTTON_FIGHTINGH_CROUCH   = 0x08000404U,
    DIBUTTON_FIGHTINGH_JUMP     = 0x08000405U,
    DIBUTTON_FIGHTINGH_SPECIAL1 = 0x08000406U,
    DIBUTTON_FIGHTINGH_SPECIAL2 = 0x08000407U,
    DIBUTTON_FIGHTINGH_MENU     = 0x080004fdU,
    DIBUTTON_FIGHTINGH_SELECT   = 0x08004408U,
}

enum uint DIHATSWITCH_FIGHTINGH_SLIDE = 0x08004601U;
enum uint DIBUTTON_FIGHTINGH_DISPLAY = 0x08004409U;
enum uint DIAXIS_FIGHTINGH_ROTATE = 0x08024203U;

enum : uint
{
    DIBUTTON_FIGHTINGH_DODGE         = 0x0800440aU,
    DIBUTTON_FIGHTINGH_LEFT_LINK     = 0x0800c4e4U,
    DIBUTTON_FIGHTINGH_RIGHT_LINK    = 0x0800c4ecU,
    DIBUTTON_FIGHTINGH_FORWARD_LINK  = 0x080144e0U,
    DIBUTTON_FIGHTINGH_BACKWARD_LINK = 0x080144e8U,
    DIBUTTON_FIGHTINGH_DEVICE        = 0x080044feU,
    DIBUTTON_FIGHTINGH_PAUSE         = 0x080044fcU,
}

enum uint DIVIRTUAL_FIGHTING_FPS = 0x09000000U;

enum : uint
{
    DIAXIS_FPS_ROTATE = 0x09008201U,
    DIAXIS_FPS_MOVE   = 0x09010202U,
}

enum : uint
{
    DIBUTTON_FPS_FIRE    = 0x09000401U,
    DIBUTTON_FPS_WEAPONS = 0x09000402U,
    DIBUTTON_FPS_APPLY   = 0x09000403U,
    DIBUTTON_FPS_SELECT  = 0x09000404U,
    DIBUTTON_FPS_CROUCH  = 0x09000405U,
    DIBUTTON_FPS_JUMP    = 0x09000406U,
}

enum uint DIAXIS_FPS_LOOKUPDOWN = 0x09018203U;

enum : uint
{
    DIBUTTON_FPS_STRAFE = 0x09000407U,
    DIBUTTON_FPS_MENU   = 0x090004fdU,
}

enum uint DIHATSWITCH_FPS_GLANCE = 0x09004601U;
enum uint DIBUTTON_FPS_DISPLAY = 0x09004408U;
enum uint DIAXIS_FPS_SIDESTEP = 0x09024204U;

enum : uint
{
    DIBUTTON_FPS_DODGE             = 0x09004409U,
    DIBUTTON_FPS_GLANCEL           = 0x0900440aU,
    DIBUTTON_FPS_GLANCER           = 0x0900440bU,
    DIBUTTON_FPS_FIRESECONDARY     = 0x0900440cU,
    DIBUTTON_FPS_ROTATE_LEFT_LINK  = 0x0900c4e4U,
    DIBUTTON_FPS_ROTATE_RIGHT_LINK = 0x0900c4ecU,
    DIBUTTON_FPS_FORWARD_LINK      = 0x090144e0U,
    DIBUTTON_FPS_BACKWARD_LINK     = 0x090144e8U,
    DIBUTTON_FPS_GLANCE_UP_LINK    = 0x0901c4e0U,
    DIBUTTON_FPS_GLANCE_DOWN_LINK  = 0x0901c4e8U,
    DIBUTTON_FPS_STEP_LEFT_LINK    = 0x090244e4U,
    DIBUTTON_FPS_STEP_RIGHT_LINK   = 0x090244ecU,
    DIBUTTON_FPS_DEVICE            = 0x090044feU,
    DIBUTTON_FPS_PAUSE             = 0x090044fcU,
}

enum uint DIVIRTUAL_FIGHTING_THIRDPERSON = 0x0a000000U;

enum : uint
{
    DIAXIS_TPS_TURN = 0x0a020201U,
    DIAXIS_TPS_MOVE = 0x0a010202U,
}

enum : uint
{
    DIBUTTON_TPS_RUN    = 0x0a000401U,
    DIBUTTON_TPS_ACTION = 0x0a000402U,
    DIBUTTON_TPS_SELECT = 0x0a000403U,
    DIBUTTON_TPS_USE    = 0x0a000404U,
    DIBUTTON_TPS_JUMP   = 0x0a000405U,
    DIBUTTON_TPS_MENU   = 0x0a0004fdU,
}

enum uint DIHATSWITCH_TPS_GLANCE = 0x0a004601U;

enum : uint
{
    DIBUTTON_TPS_VIEW      = 0x0a004406U,
    DIBUTTON_TPS_STEPLEFT  = 0x0a004407U,
    DIBUTTON_TPS_STEPRIGHT = 0x0a004408U,
}

enum uint DIAXIS_TPS_STEP = 0x0a00c203U;

enum : uint
{
    DIBUTTON_TPS_DODGE             = 0x0a004409U,
    DIBUTTON_TPS_INVENTORY         = 0x0a00440aU,
    DIBUTTON_TPS_TURN_LEFT_LINK    = 0x0a0244e4U,
    DIBUTTON_TPS_TURN_RIGHT_LINK   = 0x0a0244ecU,
    DIBUTTON_TPS_FORWARD_LINK      = 0x0a0144e0U,
    DIBUTTON_TPS_BACKWARD_LINK     = 0x0a0144e8U,
    DIBUTTON_TPS_GLANCE_UP_LINK    = 0x0a07c4e0U,
    DIBUTTON_TPS_GLANCE_DOWN_LINK  = 0x0a07c4e8U,
    DIBUTTON_TPS_GLANCE_LEFT_LINK  = 0x0a07c4e4U,
    DIBUTTON_TPS_GLANCE_RIGHT_LINK = 0x0a07c4ecU,
    DIBUTTON_TPS_DEVICE            = 0x0a0044feU,
    DIBUTTON_TPS_PAUSE             = 0x0a0044fcU,
}

enum uint DIVIRTUAL_STRATEGY_ROLEPLAYING = 0x0b000000U;

enum : uint
{
    DIAXIS_STRATEGYR_LATERAL = 0x0b008201U,
    DIAXIS_STRATEGYR_MOVE    = 0x0b010202U,
}

enum : uint
{
    DIBUTTON_STRATEGYR_GET    = 0x0b000401U,
    DIBUTTON_STRATEGYR_APPLY  = 0x0b000402U,
    DIBUTTON_STRATEGYR_SELECT = 0x0b000403U,
    DIBUTTON_STRATEGYR_ATTACK = 0x0b000404U,
    DIBUTTON_STRATEGYR_CAST   = 0x0b000405U,
    DIBUTTON_STRATEGYR_CROUCH = 0x0b000406U,
    DIBUTTON_STRATEGYR_JUMP   = 0x0b000407U,
    DIBUTTON_STRATEGYR_MENU   = 0x0b0004fdU,
}

enum uint DIHATSWITCH_STRATEGYR_GLANCE = 0x0b004601U;

enum : uint
{
    DIBUTTON_STRATEGYR_MAP     = 0x0b004408U,
    DIBUTTON_STRATEGYR_DISPLAY = 0x0b004409U,
}

enum uint DIAXIS_STRATEGYR_ROTATE = 0x0b024203U;

enum : uint
{
    DIBUTTON_STRATEGYR_LEFT_LINK         = 0x0b00c4e4U,
    DIBUTTON_STRATEGYR_RIGHT_LINK        = 0x0b00c4ecU,
    DIBUTTON_STRATEGYR_FORWARD_LINK      = 0x0b0144e0U,
    DIBUTTON_STRATEGYR_BACK_LINK         = 0x0b0144e8U,
    DIBUTTON_STRATEGYR_ROTATE_LEFT_LINK  = 0x0b0244e4U,
    DIBUTTON_STRATEGYR_ROTATE_RIGHT_LINK = 0x0b0244ecU,
    DIBUTTON_STRATEGYR_DEVICE            = 0x0b0044feU,
    DIBUTTON_STRATEGYR_PAUSE             = 0x0b0044fcU,
}

enum uint DIVIRTUAL_STRATEGY_TURN = 0x0c000000U;

enum : uint
{
    DIAXIS_STRATEGYT_LATERAL = 0x0c008201U,
    DIAXIS_STRATEGYT_MOVE    = 0x0c010202U,
}

enum : uint
{
    DIBUTTON_STRATEGYT_SELECT       = 0x0c000401U,
    DIBUTTON_STRATEGYT_INSTRUCT     = 0x0c000402U,
    DIBUTTON_STRATEGYT_APPLY        = 0x0c000403U,
    DIBUTTON_STRATEGYT_TEAM         = 0x0c000404U,
    DIBUTTON_STRATEGYT_TURN         = 0x0c000405U,
    DIBUTTON_STRATEGYT_MENU         = 0x0c0004fdU,
    DIBUTTON_STRATEGYT_ZOOM         = 0x0c004406U,
    DIBUTTON_STRATEGYT_MAP          = 0x0c004407U,
    DIBUTTON_STRATEGYT_DISPLAY      = 0x0c004408U,
    DIBUTTON_STRATEGYT_LEFT_LINK    = 0x0c00c4e4U,
    DIBUTTON_STRATEGYT_RIGHT_LINK   = 0x0c00c4ecU,
    DIBUTTON_STRATEGYT_FORWARD_LINK = 0x0c0144e0U,
    DIBUTTON_STRATEGYT_BACK_LINK    = 0x0c0144e8U,
    DIBUTTON_STRATEGYT_DEVICE       = 0x0c0044feU,
    DIBUTTON_STRATEGYT_PAUSE        = 0x0c0044fcU,
}

enum uint DIVIRTUAL_SPORTS_HUNTING = 0x0d000000U;

enum : uint
{
    DIAXIS_HUNTING_LATERAL = 0x0d008201U,
    DIAXIS_HUNTING_MOVE    = 0x0d010202U,
}

enum : uint
{
    DIBUTTON_HUNTING_FIRE      = 0x0d000401U,
    DIBUTTON_HUNTING_AIM       = 0x0d000402U,
    DIBUTTON_HUNTING_WEAPON    = 0x0d000403U,
    DIBUTTON_HUNTING_BINOCULAR = 0x0d000404U,
    DIBUTTON_HUNTING_CALL      = 0x0d000405U,
    DIBUTTON_HUNTING_MAP       = 0x0d000406U,
    DIBUTTON_HUNTING_SPECIAL   = 0x0d000407U,
    DIBUTTON_HUNTING_MENU      = 0x0d0004fdU,
}

enum uint DIHATSWITCH_HUNTING_GLANCE = 0x0d004601U;
enum uint DIBUTTON_HUNTING_DISPLAY = 0x0d004408U;
enum uint DIAXIS_HUNTING_ROTATE = 0x0d024203U;

enum : uint
{
    DIBUTTON_HUNTING_CROUCH            = 0x0d004409U,
    DIBUTTON_HUNTING_JUMP              = 0x0d00440aU,
    DIBUTTON_HUNTING_FIRESECONDARY     = 0x0d00440bU,
    DIBUTTON_HUNTING_LEFT_LINK         = 0x0d00c4e4U,
    DIBUTTON_HUNTING_RIGHT_LINK        = 0x0d00c4ecU,
    DIBUTTON_HUNTING_FORWARD_LINK      = 0x0d0144e0U,
    DIBUTTON_HUNTING_BACK_LINK         = 0x0d0144e8U,
    DIBUTTON_HUNTING_ROTATE_LEFT_LINK  = 0x0d0244e4U,
    DIBUTTON_HUNTING_ROTATE_RIGHT_LINK = 0x0d0244ecU,
    DIBUTTON_HUNTING_DEVICE            = 0x0d0044feU,
    DIBUTTON_HUNTING_PAUSE             = 0x0d0044fcU,
}

enum uint DIVIRTUAL_SPORTS_FISHING = 0x0e000000U;

enum : uint
{
    DIAXIS_FISHING_LATERAL = 0x0e008201U,
    DIAXIS_FISHING_MOVE    = 0x0e010202U,
}

enum : uint
{
    DIBUTTON_FISHING_CAST      = 0x0e000401U,
    DIBUTTON_FISHING_TYPE      = 0x0e000402U,
    DIBUTTON_FISHING_BINOCULAR = 0x0e000403U,
    DIBUTTON_FISHING_BAIT      = 0x0e000404U,
    DIBUTTON_FISHING_MAP       = 0x0e000405U,
    DIBUTTON_FISHING_MENU      = 0x0e0004fdU,
}

enum uint DIHATSWITCH_FISHING_GLANCE = 0x0e004601U;
enum uint DIBUTTON_FISHING_DISPLAY = 0x0e004406U;
enum uint DIAXIS_FISHING_ROTATE = 0x0e024203U;

enum : uint
{
    DIBUTTON_FISHING_CROUCH            = 0x0e004407U,
    DIBUTTON_FISHING_JUMP              = 0x0e004408U,
    DIBUTTON_FISHING_LEFT_LINK         = 0x0e00c4e4U,
    DIBUTTON_FISHING_RIGHT_LINK        = 0x0e00c4ecU,
    DIBUTTON_FISHING_FORWARD_LINK      = 0x0e0144e0U,
    DIBUTTON_FISHING_BACK_LINK         = 0x0e0144e8U,
    DIBUTTON_FISHING_ROTATE_LEFT_LINK  = 0x0e0244e4U,
    DIBUTTON_FISHING_ROTATE_RIGHT_LINK = 0x0e0244ecU,
    DIBUTTON_FISHING_DEVICE            = 0x0e0044feU,
    DIBUTTON_FISHING_PAUSE             = 0x0e0044fcU,
}

enum uint DIVIRTUAL_SPORTS_BASEBALL_BAT = 0x0f000000U;

enum : uint
{
    DIAXIS_BASEBALLB_LATERAL = 0x0f008201U,
    DIAXIS_BASEBALLB_MOVE    = 0x0f010202U,
}

enum : uint
{
    DIBUTTON_BASEBALLB_SELECT       = 0x0f000401U,
    DIBUTTON_BASEBALLB_NORMAL       = 0x0f000402U,
    DIBUTTON_BASEBALLB_POWER        = 0x0f000403U,
    DIBUTTON_BASEBALLB_BUNT         = 0x0f000404U,
    DIBUTTON_BASEBALLB_STEAL        = 0x0f000405U,
    DIBUTTON_BASEBALLB_BURST        = 0x0f000406U,
    DIBUTTON_BASEBALLB_SLIDE        = 0x0f000407U,
    DIBUTTON_BASEBALLB_CONTACT      = 0x0f000408U,
    DIBUTTON_BASEBALLB_MENU         = 0x0f0004fdU,
    DIBUTTON_BASEBALLB_NOSTEAL      = 0x0f004409U,
    DIBUTTON_BASEBALLB_BOX          = 0x0f00440aU,
    DIBUTTON_BASEBALLB_LEFT_LINK    = 0x0f00c4e4U,
    DIBUTTON_BASEBALLB_RIGHT_LINK   = 0x0f00c4ecU,
    DIBUTTON_BASEBALLB_FORWARD_LINK = 0x0f0144e0U,
    DIBUTTON_BASEBALLB_BACK_LINK    = 0x0f0144e8U,
    DIBUTTON_BASEBALLB_DEVICE       = 0x0f0044feU,
    DIBUTTON_BASEBALLB_PAUSE        = 0x0f0044fcU,
}

enum uint DIVIRTUAL_SPORTS_BASEBALL_PITCH = 0x10000000U;

enum : uint
{
    DIAXIS_BASEBALLP_LATERAL = 0x10008201U,
    DIAXIS_BASEBALLP_MOVE    = 0x10010202U,
}

enum : uint
{
    DIBUTTON_BASEBALLP_SELECT       = 0x10000401U,
    DIBUTTON_BASEBALLP_PITCH        = 0x10000402U,
    DIBUTTON_BASEBALLP_BASE         = 0x10000403U,
    DIBUTTON_BASEBALLP_THROW        = 0x10000404U,
    DIBUTTON_BASEBALLP_FAKE         = 0x10000405U,
    DIBUTTON_BASEBALLP_MENU         = 0x100004fdU,
    DIBUTTON_BASEBALLP_WALK         = 0x10004406U,
    DIBUTTON_BASEBALLP_LOOK         = 0x10004407U,
    DIBUTTON_BASEBALLP_LEFT_LINK    = 0x1000c4e4U,
    DIBUTTON_BASEBALLP_RIGHT_LINK   = 0x1000c4ecU,
    DIBUTTON_BASEBALLP_FORWARD_LINK = 0x100144e0U,
    DIBUTTON_BASEBALLP_BACK_LINK    = 0x100144e8U,
    DIBUTTON_BASEBALLP_DEVICE       = 0x100044feU,
    DIBUTTON_BASEBALLP_PAUSE        = 0x100044fcU,
}

enum uint DIVIRTUAL_SPORTS_BASEBALL_FIELD = 0x11000000U;

enum : uint
{
    DIAXIS_BASEBALLF_LATERAL = 0x11008201U,
    DIAXIS_BASEBALLF_MOVE    = 0x11010202U,
}

enum : uint
{
    DIBUTTON_BASEBALLF_NEAREST        = 0x11000401U,
    DIBUTTON_BASEBALLF_THROW1         = 0x11000402U,
    DIBUTTON_BASEBALLF_THROW2         = 0x11000403U,
    DIBUTTON_BASEBALLF_BURST          = 0x11000404U,
    DIBUTTON_BASEBALLF_JUMP           = 0x11000405U,
    DIBUTTON_BASEBALLF_DIVE           = 0x11000406U,
    DIBUTTON_BASEBALLF_MENU           = 0x110004fdU,
    DIBUTTON_BASEBALLF_SHIFTIN        = 0x11004407U,
    DIBUTTON_BASEBALLF_SHIFTOUT       = 0x11004408U,
    DIBUTTON_BASEBALLF_AIM_LEFT_LINK  = 0x1100c4e4U,
    DIBUTTON_BASEBALLF_AIM_RIGHT_LINK = 0x1100c4ecU,
    DIBUTTON_BASEBALLF_FORWARD_LINK   = 0x110144e0U,
    DIBUTTON_BASEBALLF_BACK_LINK      = 0x110144e8U,
    DIBUTTON_BASEBALLF_DEVICE         = 0x110044feU,
    DIBUTTON_BASEBALLF_PAUSE          = 0x110044fcU,
}

enum uint DIVIRTUAL_SPORTS_BASKETBALL_OFFENSE = 0x12000000U;

enum : uint
{
    DIAXIS_BBALLO_LATERAL = 0x12008201U,
    DIAXIS_BBALLO_MOVE    = 0x12010202U,
}

enum : uint
{
    DIBUTTON_BBALLO_SHOOT   = 0x12000401U,
    DIBUTTON_BBALLO_DUNK    = 0x12000402U,
    DIBUTTON_BBALLO_PASS    = 0x12000403U,
    DIBUTTON_BBALLO_FAKE    = 0x12000404U,
    DIBUTTON_BBALLO_SPECIAL = 0x12000405U,
    DIBUTTON_BBALLO_PLAYER  = 0x12000406U,
    DIBUTTON_BBALLO_BURST   = 0x12000407U,
    DIBUTTON_BBALLO_CALL    = 0x12000408U,
    DIBUTTON_BBALLO_MENU    = 0x120004fdU,
}

enum uint DIHATSWITCH_BBALLO_GLANCE = 0x12004601U;

enum : uint
{
    DIBUTTON_BBALLO_SCREEN       = 0x12004409U,
    DIBUTTON_BBALLO_PLAY         = 0x1200440aU,
    DIBUTTON_BBALLO_JAB          = 0x1200440bU,
    DIBUTTON_BBALLO_POST         = 0x1200440cU,
    DIBUTTON_BBALLO_TIMEOUT      = 0x1200440dU,
    DIBUTTON_BBALLO_SUBSTITUTE   = 0x1200440eU,
    DIBUTTON_BBALLO_LEFT_LINK    = 0x1200c4e4U,
    DIBUTTON_BBALLO_RIGHT_LINK   = 0x1200c4ecU,
    DIBUTTON_BBALLO_FORWARD_LINK = 0x120144e0U,
    DIBUTTON_BBALLO_BACK_LINK    = 0x120144e8U,
    DIBUTTON_BBALLO_DEVICE       = 0x120044feU,
    DIBUTTON_BBALLO_PAUSE        = 0x120044fcU,
}

enum uint DIVIRTUAL_SPORTS_BASKETBALL_DEFENSE = 0x13000000U;

enum : uint
{
    DIAXIS_BBALLD_LATERAL = 0x13008201U,
    DIAXIS_BBALLD_MOVE    = 0x13010202U,
}

enum : uint
{
    DIBUTTON_BBALLD_JUMP    = 0x13000401U,
    DIBUTTON_BBALLD_STEAL   = 0x13000402U,
    DIBUTTON_BBALLD_FAKE    = 0x13000403U,
    DIBUTTON_BBALLD_SPECIAL = 0x13000404U,
    DIBUTTON_BBALLD_PLAYER  = 0x13000405U,
    DIBUTTON_BBALLD_BURST   = 0x13000406U,
    DIBUTTON_BBALLD_PLAY    = 0x13000407U,
    DIBUTTON_BBALLD_MENU    = 0x130004fdU,
}

enum uint DIHATSWITCH_BBALLD_GLANCE = 0x13004601U;

enum : uint
{
    DIBUTTON_BBALLD_TIMEOUT      = 0x13004408U,
    DIBUTTON_BBALLD_SUBSTITUTE   = 0x13004409U,
    DIBUTTON_BBALLD_LEFT_LINK    = 0x1300c4e4U,
    DIBUTTON_BBALLD_RIGHT_LINK   = 0x1300c4ecU,
    DIBUTTON_BBALLD_FORWARD_LINK = 0x130144e0U,
    DIBUTTON_BBALLD_BACK_LINK    = 0x130144e8U,
    DIBUTTON_BBALLD_DEVICE       = 0x130044feU,
    DIBUTTON_BBALLD_PAUSE        = 0x130044fcU,
}

enum uint DIVIRTUAL_SPORTS_FOOTBALL_FIELD = 0x14000000U;

enum : uint
{
    DIBUTTON_FOOTBALLP_PLAY   = 0x14000401U,
    DIBUTTON_FOOTBALLP_SELECT = 0x14000402U,
    DIBUTTON_FOOTBALLP_HELP   = 0x14000403U,
    DIBUTTON_FOOTBALLP_MENU   = 0x140004fdU,
    DIBUTTON_FOOTBALLP_DEVICE = 0x140044feU,
    DIBUTTON_FOOTBALLP_PAUSE  = 0x140044fcU,
}

enum uint DIVIRTUAL_SPORTS_FOOTBALL_QBCK = 0x15000000U;

enum : uint
{
    DIAXIS_FOOTBALLQ_LATERAL = 0x15008201U,
    DIAXIS_FOOTBALLQ_MOVE    = 0x15010202U,
}

enum : uint
{
    DIBUTTON_FOOTBALLQ_SELECT       = 0x15000401U,
    DIBUTTON_FOOTBALLQ_SNAP         = 0x15000402U,
    DIBUTTON_FOOTBALLQ_JUMP         = 0x15000403U,
    DIBUTTON_FOOTBALLQ_SLIDE        = 0x15000404U,
    DIBUTTON_FOOTBALLQ_PASS         = 0x15000405U,
    DIBUTTON_FOOTBALLQ_FAKE         = 0x15000406U,
    DIBUTTON_FOOTBALLQ_MENU         = 0x150004fdU,
    DIBUTTON_FOOTBALLQ_FAKESNAP     = 0x15004407U,
    DIBUTTON_FOOTBALLQ_MOTION       = 0x15004408U,
    DIBUTTON_FOOTBALLQ_AUDIBLE      = 0x15004409U,
    DIBUTTON_FOOTBALLQ_LEFT_LINK    = 0x1500c4e4U,
    DIBUTTON_FOOTBALLQ_RIGHT_LINK   = 0x1500c4ecU,
    DIBUTTON_FOOTBALLQ_FORWARD_LINK = 0x150144e0U,
    DIBUTTON_FOOTBALLQ_BACK_LINK    = 0x150144e8U,
    DIBUTTON_FOOTBALLQ_DEVICE       = 0x150044feU,
    DIBUTTON_FOOTBALLQ_PAUSE        = 0x150044fcU,
}

enum uint DIVIRTUAL_SPORTS_FOOTBALL_OFFENSE = 0x16000000U;

enum : uint
{
    DIAXIS_FOOTBALLO_LATERAL = 0x16008201U,
    DIAXIS_FOOTBALLO_MOVE    = 0x16010202U,
}

enum : uint
{
    DIBUTTON_FOOTBALLO_JUMP         = 0x16000401U,
    DIBUTTON_FOOTBALLO_LEFTARM      = 0x16000402U,
    DIBUTTON_FOOTBALLO_RIGHTARM     = 0x16000403U,
    DIBUTTON_FOOTBALLO_THROW        = 0x16000404U,
    DIBUTTON_FOOTBALLO_SPIN         = 0x16000405U,
    DIBUTTON_FOOTBALLO_MENU         = 0x160004fdU,
    DIBUTTON_FOOTBALLO_JUKE         = 0x16004406U,
    DIBUTTON_FOOTBALLO_SHOULDER     = 0x16004407U,
    DIBUTTON_FOOTBALLO_TURBO        = 0x16004408U,
    DIBUTTON_FOOTBALLO_DIVE         = 0x16004409U,
    DIBUTTON_FOOTBALLO_ZOOM         = 0x1600440aU,
    DIBUTTON_FOOTBALLO_SUBSTITUTE   = 0x1600440bU,
    DIBUTTON_FOOTBALLO_LEFT_LINK    = 0x1600c4e4U,
    DIBUTTON_FOOTBALLO_RIGHT_LINK   = 0x1600c4ecU,
    DIBUTTON_FOOTBALLO_FORWARD_LINK = 0x160144e0U,
    DIBUTTON_FOOTBALLO_BACK_LINK    = 0x160144e8U,
    DIBUTTON_FOOTBALLO_DEVICE       = 0x160044feU,
    DIBUTTON_FOOTBALLO_PAUSE        = 0x160044fcU,
}

enum uint DIVIRTUAL_SPORTS_FOOTBALL_DEFENSE = 0x17000000U;

enum : uint
{
    DIAXIS_FOOTBALLD_LATERAL = 0x17008201U,
    DIAXIS_FOOTBALLD_MOVE    = 0x17010202U,
}

enum : uint
{
    DIBUTTON_FOOTBALLD_PLAY         = 0x17000401U,
    DIBUTTON_FOOTBALLD_SELECT       = 0x17000402U,
    DIBUTTON_FOOTBALLD_JUMP         = 0x17000403U,
    DIBUTTON_FOOTBALLD_TACKLE       = 0x17000404U,
    DIBUTTON_FOOTBALLD_FAKE         = 0x17000405U,
    DIBUTTON_FOOTBALLD_SUPERTACKLE  = 0x17000406U,
    DIBUTTON_FOOTBALLD_MENU         = 0x170004fdU,
    DIBUTTON_FOOTBALLD_SPIN         = 0x17004407U,
    DIBUTTON_FOOTBALLD_SWIM         = 0x17004408U,
    DIBUTTON_FOOTBALLD_BULLRUSH     = 0x17004409U,
    DIBUTTON_FOOTBALLD_RIP          = 0x1700440aU,
    DIBUTTON_FOOTBALLD_AUDIBLE      = 0x1700440bU,
    DIBUTTON_FOOTBALLD_ZOOM         = 0x1700440cU,
    DIBUTTON_FOOTBALLD_SUBSTITUTE   = 0x1700440dU,
    DIBUTTON_FOOTBALLD_LEFT_LINK    = 0x1700c4e4U,
    DIBUTTON_FOOTBALLD_RIGHT_LINK   = 0x1700c4ecU,
    DIBUTTON_FOOTBALLD_FORWARD_LINK = 0x170144e0U,
    DIBUTTON_FOOTBALLD_BACK_LINK    = 0x170144e8U,
    DIBUTTON_FOOTBALLD_DEVICE       = 0x170044feU,
    DIBUTTON_FOOTBALLD_PAUSE        = 0x170044fcU,
}

enum uint DIVIRTUAL_SPORTS_GOLF = 0x18000000U;

enum : uint
{
    DIAXIS_GOLF_LATERAL = 0x18008201U,
    DIAXIS_GOLF_MOVE    = 0x18010202U,
}

enum : uint
{
    DIBUTTON_GOLF_SWING   = 0x18000401U,
    DIBUTTON_GOLF_SELECT  = 0x18000402U,
    DIBUTTON_GOLF_UP      = 0x18000403U,
    DIBUTTON_GOLF_DOWN    = 0x18000404U,
    DIBUTTON_GOLF_TERRAIN = 0x18000405U,
    DIBUTTON_GOLF_FLYBY   = 0x18000406U,
    DIBUTTON_GOLF_MENU    = 0x180004fdU,
}

enum uint DIHATSWITCH_GOLF_SCROLL = 0x18004601U;

enum : uint
{
    DIBUTTON_GOLF_ZOOM         = 0x18004407U,
    DIBUTTON_GOLF_TIMEOUT      = 0x18004408U,
    DIBUTTON_GOLF_SUBSTITUTE   = 0x18004409U,
    DIBUTTON_GOLF_LEFT_LINK    = 0x1800c4e4U,
    DIBUTTON_GOLF_RIGHT_LINK   = 0x1800c4ecU,
    DIBUTTON_GOLF_FORWARD_LINK = 0x180144e0U,
    DIBUTTON_GOLF_BACK_LINK    = 0x180144e8U,
    DIBUTTON_GOLF_DEVICE       = 0x180044feU,
    DIBUTTON_GOLF_PAUSE        = 0x180044fcU,
}

enum uint DIVIRTUAL_SPORTS_HOCKEY_OFFENSE = 0x19000000U;

enum : uint
{
    DIAXIS_HOCKEYO_LATERAL = 0x19008201U,
    DIAXIS_HOCKEYO_MOVE    = 0x19010202U,
}

enum : uint
{
    DIBUTTON_HOCKEYO_SHOOT   = 0x19000401U,
    DIBUTTON_HOCKEYO_PASS    = 0x19000402U,
    DIBUTTON_HOCKEYO_BURST   = 0x19000403U,
    DIBUTTON_HOCKEYO_SPECIAL = 0x19000404U,
    DIBUTTON_HOCKEYO_FAKE    = 0x19000405U,
    DIBUTTON_HOCKEYO_MENU    = 0x190004fdU,
}

enum uint DIHATSWITCH_HOCKEYO_SCROLL = 0x19004601U;

enum : uint
{
    DIBUTTON_HOCKEYO_ZOOM         = 0x19004406U,
    DIBUTTON_HOCKEYO_STRATEGY     = 0x19004407U,
    DIBUTTON_HOCKEYO_TIMEOUT      = 0x19004408U,
    DIBUTTON_HOCKEYO_SUBSTITUTE   = 0x19004409U,
    DIBUTTON_HOCKEYO_LEFT_LINK    = 0x1900c4e4U,
    DIBUTTON_HOCKEYO_RIGHT_LINK   = 0x1900c4ecU,
    DIBUTTON_HOCKEYO_FORWARD_LINK = 0x190144e0U,
    DIBUTTON_HOCKEYO_BACK_LINK    = 0x190144e8U,
    DIBUTTON_HOCKEYO_DEVICE       = 0x190044feU,
    DIBUTTON_HOCKEYO_PAUSE        = 0x190044fcU,
}

enum uint DIVIRTUAL_SPORTS_HOCKEY_DEFENSE = 0x1a000000U;

enum : uint
{
    DIAXIS_HOCKEYD_LATERAL = 0x1a008201U,
    DIAXIS_HOCKEYD_MOVE    = 0x1a010202U,
}

enum : uint
{
    DIBUTTON_HOCKEYD_PLAYER = 0x1a000401U,
    DIBUTTON_HOCKEYD_STEAL  = 0x1a000402U,
    DIBUTTON_HOCKEYD_BURST  = 0x1a000403U,
    DIBUTTON_HOCKEYD_BLOCK  = 0x1a000404U,
    DIBUTTON_HOCKEYD_FAKE   = 0x1a000405U,
    DIBUTTON_HOCKEYD_MENU   = 0x1a0004fdU,
}

enum uint DIHATSWITCH_HOCKEYD_SCROLL = 0x1a004601U;

enum : uint
{
    DIBUTTON_HOCKEYD_ZOOM         = 0x1a004406U,
    DIBUTTON_HOCKEYD_STRATEGY     = 0x1a004407U,
    DIBUTTON_HOCKEYD_TIMEOUT      = 0x1a004408U,
    DIBUTTON_HOCKEYD_SUBSTITUTE   = 0x1a004409U,
    DIBUTTON_HOCKEYD_LEFT_LINK    = 0x1a00c4e4U,
    DIBUTTON_HOCKEYD_RIGHT_LINK   = 0x1a00c4ecU,
    DIBUTTON_HOCKEYD_FORWARD_LINK = 0x1a0144e0U,
    DIBUTTON_HOCKEYD_BACK_LINK    = 0x1a0144e8U,
    DIBUTTON_HOCKEYD_DEVICE       = 0x1a0044feU,
    DIBUTTON_HOCKEYD_PAUSE        = 0x1a0044fcU,
}

enum uint DIVIRTUAL_SPORTS_HOCKEY_GOALIE = 0x1b000000U;

enum : uint
{
    DIAXIS_HOCKEYG_LATERAL = 0x1b008201U,
    DIAXIS_HOCKEYG_MOVE    = 0x1b010202U,
}

enum : uint
{
    DIBUTTON_HOCKEYG_PASS  = 0x1b000401U,
    DIBUTTON_HOCKEYG_POKE  = 0x1b000402U,
    DIBUTTON_HOCKEYG_STEAL = 0x1b000403U,
    DIBUTTON_HOCKEYG_BLOCK = 0x1b000404U,
    DIBUTTON_HOCKEYG_MENU  = 0x1b0004fdU,
}

enum uint DIHATSWITCH_HOCKEYG_SCROLL = 0x1b004601U;

enum : uint
{
    DIBUTTON_HOCKEYG_ZOOM         = 0x1b004405U,
    DIBUTTON_HOCKEYG_STRATEGY     = 0x1b004406U,
    DIBUTTON_HOCKEYG_TIMEOUT      = 0x1b004407U,
    DIBUTTON_HOCKEYG_SUBSTITUTE   = 0x1b004408U,
    DIBUTTON_HOCKEYG_LEFT_LINK    = 0x1b00c4e4U,
    DIBUTTON_HOCKEYG_RIGHT_LINK   = 0x1b00c4ecU,
    DIBUTTON_HOCKEYG_FORWARD_LINK = 0x1b0144e0U,
    DIBUTTON_HOCKEYG_BACK_LINK    = 0x1b0144e8U,
    DIBUTTON_HOCKEYG_DEVICE       = 0x1b0044feU,
    DIBUTTON_HOCKEYG_PAUSE        = 0x1b0044fcU,
}

enum uint DIVIRTUAL_SPORTS_BIKING_MOUNTAIN = 0x1c000000U;

enum : uint
{
    DIAXIS_BIKINGM_TURN  = 0x1c008201U,
    DIAXIS_BIKINGM_PEDAL = 0x1c010202U,
}

enum : uint
{
    DIBUTTON_BIKINGM_JUMP     = 0x1c000401U,
    DIBUTTON_BIKINGM_CAMERA   = 0x1c000402U,
    DIBUTTON_BIKINGM_SPECIAL1 = 0x1c000403U,
    DIBUTTON_BIKINGM_SELECT   = 0x1c000404U,
    DIBUTTON_BIKINGM_SPECIAL2 = 0x1c000405U,
    DIBUTTON_BIKINGM_MENU     = 0x1c0004fdU,
}

enum uint DIHATSWITCH_BIKINGM_SCROLL = 0x1c004601U;
enum uint DIBUTTON_BIKINGM_ZOOM = 0x1c004406U;
enum uint DIAXIS_BIKINGM_BRAKE = 0x1c044203U;

enum : uint
{
    DIBUTTON_BIKINGM_LEFT_LINK         = 0x1c00c4e4U,
    DIBUTTON_BIKINGM_RIGHT_LINK        = 0x1c00c4ecU,
    DIBUTTON_BIKINGM_FASTER_LINK       = 0x1c0144e0U,
    DIBUTTON_BIKINGM_SLOWER_LINK       = 0x1c0144e8U,
    DIBUTTON_BIKINGM_BRAKE_BUTTON_LINK = 0x1c0444e8U,
    DIBUTTON_BIKINGM_DEVICE            = 0x1c0044feU,
    DIBUTTON_BIKINGM_PAUSE             = 0x1c0044fcU,
}

enum uint DIVIRTUAL_SPORTS_SKIING = 0x1d000000U;

enum : uint
{
    DIAXIS_SKIING_TURN  = 0x1d008201U,
    DIAXIS_SKIING_SPEED = 0x1d010202U,
}

enum : uint
{
    DIBUTTON_SKIING_JUMP     = 0x1d000401U,
    DIBUTTON_SKIING_CROUCH   = 0x1d000402U,
    DIBUTTON_SKIING_CAMERA   = 0x1d000403U,
    DIBUTTON_SKIING_SPECIAL1 = 0x1d000404U,
    DIBUTTON_SKIING_SELECT   = 0x1d000405U,
    DIBUTTON_SKIING_SPECIAL2 = 0x1d000406U,
    DIBUTTON_SKIING_MENU     = 0x1d0004fdU,
}

enum uint DIHATSWITCH_SKIING_GLANCE = 0x1d004601U;

enum : uint
{
    DIBUTTON_SKIING_ZOOM        = 0x1d004407U,
    DIBUTTON_SKIING_LEFT_LINK   = 0x1d00c4e4U,
    DIBUTTON_SKIING_RIGHT_LINK  = 0x1d00c4ecU,
    DIBUTTON_SKIING_FASTER_LINK = 0x1d0144e0U,
    DIBUTTON_SKIING_SLOWER_LINK = 0x1d0144e8U,
    DIBUTTON_SKIING_DEVICE      = 0x1d0044feU,
    DIBUTTON_SKIING_PAUSE       = 0x1d0044fcU,
}

enum uint DIVIRTUAL_SPORTS_SOCCER_OFFENSE = 0x1e000000U;

enum : uint
{
    DIAXIS_SOCCERO_LATERAL = 0x1e008201U,
    DIAXIS_SOCCERO_MOVE    = 0x1e010202U,
    DIAXIS_SOCCERO_BEND    = 0x1e018203U,
}

enum : uint
{
    DIBUTTON_SOCCERO_SHOOT    = 0x1e000401U,
    DIBUTTON_SOCCERO_PASS     = 0x1e000402U,
    DIBUTTON_SOCCERO_FAKE     = 0x1e000403U,
    DIBUTTON_SOCCERO_PLAYER   = 0x1e000404U,
    DIBUTTON_SOCCERO_SPECIAL1 = 0x1e000405U,
    DIBUTTON_SOCCERO_SELECT   = 0x1e000406U,
    DIBUTTON_SOCCERO_MENU     = 0x1e0004fdU,
}

enum uint DIHATSWITCH_SOCCERO_GLANCE = 0x1e004601U;

enum : uint
{
    DIBUTTON_SOCCERO_SUBSTITUTE   = 0x1e004407U,
    DIBUTTON_SOCCERO_SHOOTLOW     = 0x1e004408U,
    DIBUTTON_SOCCERO_SHOOTHIGH    = 0x1e004409U,
    DIBUTTON_SOCCERO_PASSTHRU     = 0x1e00440aU,
    DIBUTTON_SOCCERO_SPRINT       = 0x1e00440bU,
    DIBUTTON_SOCCERO_CONTROL      = 0x1e00440cU,
    DIBUTTON_SOCCERO_HEAD         = 0x1e00440dU,
    DIBUTTON_SOCCERO_LEFT_LINK    = 0x1e00c4e4U,
    DIBUTTON_SOCCERO_RIGHT_LINK   = 0x1e00c4ecU,
    DIBUTTON_SOCCERO_FORWARD_LINK = 0x1e0144e0U,
    DIBUTTON_SOCCERO_BACK_LINK    = 0x1e0144e8U,
    DIBUTTON_SOCCERO_DEVICE       = 0x1e0044feU,
    DIBUTTON_SOCCERO_PAUSE        = 0x1e0044fcU,
}

enum uint DIVIRTUAL_SPORTS_SOCCER_DEFENSE = 0x1f000000U;

enum : uint
{
    DIAXIS_SOCCERD_LATERAL = 0x1f008201U,
    DIAXIS_SOCCERD_MOVE    = 0x1f010202U,
}

enum : uint
{
    DIBUTTON_SOCCERD_BLOCK   = 0x1f000401U,
    DIBUTTON_SOCCERD_STEAL   = 0x1f000402U,
    DIBUTTON_SOCCERD_FAKE    = 0x1f000403U,
    DIBUTTON_SOCCERD_PLAYER  = 0x1f000404U,
    DIBUTTON_SOCCERD_SPECIAL = 0x1f000405U,
    DIBUTTON_SOCCERD_SELECT  = 0x1f000406U,
    DIBUTTON_SOCCERD_SLIDE   = 0x1f000407U,
    DIBUTTON_SOCCERD_MENU    = 0x1f0004fdU,
}

enum uint DIHATSWITCH_SOCCERD_GLANCE = 0x1f004601U;

enum : uint
{
    DIBUTTON_SOCCERD_FOUL         = 0x1f004408U,
    DIBUTTON_SOCCERD_HEAD         = 0x1f004409U,
    DIBUTTON_SOCCERD_CLEAR        = 0x1f00440aU,
    DIBUTTON_SOCCERD_GOALIECHARGE = 0x1f00440bU,
    DIBUTTON_SOCCERD_SUBSTITUTE   = 0x1f00440cU,
    DIBUTTON_SOCCERD_LEFT_LINK    = 0x1f00c4e4U,
    DIBUTTON_SOCCERD_RIGHT_LINK   = 0x1f00c4ecU,
    DIBUTTON_SOCCERD_FORWARD_LINK = 0x1f0144e0U,
    DIBUTTON_SOCCERD_BACK_LINK    = 0x1f0144e8U,
    DIBUTTON_SOCCERD_DEVICE       = 0x1f0044feU,
    DIBUTTON_SOCCERD_PAUSE        = 0x1f0044fcU,
}

enum uint DIVIRTUAL_SPORTS_RACQUET = 0x20000000U;

enum : uint
{
    DIAXIS_RACQUET_LATERAL = 0x20008201U,
    DIAXIS_RACQUET_MOVE    = 0x20010202U,
}

enum : uint
{
    DIBUTTON_RACQUET_SWING     = 0x20000401U,
    DIBUTTON_RACQUET_BACKSWING = 0x20000402U,
    DIBUTTON_RACQUET_SMASH     = 0x20000403U,
    DIBUTTON_RACQUET_SPECIAL   = 0x20000404U,
    DIBUTTON_RACQUET_SELECT    = 0x20000405U,
    DIBUTTON_RACQUET_MENU      = 0x200004fdU,
}

enum uint DIHATSWITCH_RACQUET_GLANCE = 0x20004601U;

enum : uint
{
    DIBUTTON_RACQUET_TIMEOUT      = 0x20004406U,
    DIBUTTON_RACQUET_SUBSTITUTE   = 0x20004407U,
    DIBUTTON_RACQUET_LEFT_LINK    = 0x2000c4e4U,
    DIBUTTON_RACQUET_RIGHT_LINK   = 0x2000c4ecU,
    DIBUTTON_RACQUET_FORWARD_LINK = 0x200144e0U,
    DIBUTTON_RACQUET_BACK_LINK    = 0x200144e8U,
    DIBUTTON_RACQUET_DEVICE       = 0x200044feU,
    DIBUTTON_RACQUET_PAUSE        = 0x200044fcU,
}

enum uint DIVIRTUAL_ARCADE_SIDE2SIDE = 0x21000000U;

enum : uint
{
    DIAXIS_ARCADES_LATERAL = 0x21008201U,
    DIAXIS_ARCADES_MOVE    = 0x21010202U,
}

enum : uint
{
    DIBUTTON_ARCADES_THROW   = 0x21000401U,
    DIBUTTON_ARCADES_CARRY   = 0x21000402U,
    DIBUTTON_ARCADES_ATTACK  = 0x21000403U,
    DIBUTTON_ARCADES_SPECIAL = 0x21000404U,
    DIBUTTON_ARCADES_SELECT  = 0x21000405U,
    DIBUTTON_ARCADES_MENU    = 0x210004fdU,
}

enum uint DIHATSWITCH_ARCADES_VIEW = 0x21004601U;

enum : uint
{
    DIBUTTON_ARCADES_LEFT_LINK       = 0x2100c4e4U,
    DIBUTTON_ARCADES_RIGHT_LINK      = 0x2100c4ecU,
    DIBUTTON_ARCADES_FORWARD_LINK    = 0x210144e0U,
    DIBUTTON_ARCADES_BACK_LINK       = 0x210144e8U,
    DIBUTTON_ARCADES_VIEW_UP_LINK    = 0x2107c4e0U,
    DIBUTTON_ARCADES_VIEW_DOWN_LINK  = 0x2107c4e8U,
    DIBUTTON_ARCADES_VIEW_LEFT_LINK  = 0x2107c4e4U,
    DIBUTTON_ARCADES_VIEW_RIGHT_LINK = 0x2107c4ecU,
    DIBUTTON_ARCADES_DEVICE          = 0x210044feU,
    DIBUTTON_ARCADES_PAUSE           = 0x210044fcU,
}

enum uint DIVIRTUAL_ARCADE_PLATFORM = 0x22000000U;

enum : uint
{
    DIAXIS_ARCADEP_LATERAL = 0x22008201U,
    DIAXIS_ARCADEP_MOVE    = 0x22010202U,
}

enum : uint
{
    DIBUTTON_ARCADEP_JUMP    = 0x22000401U,
    DIBUTTON_ARCADEP_FIRE    = 0x22000402U,
    DIBUTTON_ARCADEP_CROUCH  = 0x22000403U,
    DIBUTTON_ARCADEP_SPECIAL = 0x22000404U,
    DIBUTTON_ARCADEP_SELECT  = 0x22000405U,
    DIBUTTON_ARCADEP_MENU    = 0x220004fdU,
}

enum uint DIHATSWITCH_ARCADEP_VIEW = 0x22004601U;

enum : uint
{
    DIBUTTON_ARCADEP_FIRESECONDARY   = 0x22004406U,
    DIBUTTON_ARCADEP_LEFT_LINK       = 0x2200c4e4U,
    DIBUTTON_ARCADEP_RIGHT_LINK      = 0x2200c4ecU,
    DIBUTTON_ARCADEP_FORWARD_LINK    = 0x220144e0U,
    DIBUTTON_ARCADEP_BACK_LINK       = 0x220144e8U,
    DIBUTTON_ARCADEP_VIEW_UP_LINK    = 0x2207c4e0U,
    DIBUTTON_ARCADEP_VIEW_DOWN_LINK  = 0x2207c4e8U,
    DIBUTTON_ARCADEP_VIEW_LEFT_LINK  = 0x2207c4e4U,
    DIBUTTON_ARCADEP_VIEW_RIGHT_LINK = 0x2207c4ecU,
    DIBUTTON_ARCADEP_DEVICE          = 0x220044feU,
    DIBUTTON_ARCADEP_PAUSE           = 0x220044fcU,
}

enum uint DIVIRTUAL_CAD_2DCONTROL = 0x23000000U;

enum : uint
{
    DIAXIS_2DCONTROL_LATERAL = 0x23008201U,
    DIAXIS_2DCONTROL_MOVE    = 0x23010202U,
    DIAXIS_2DCONTROL_INOUT   = 0x23018203U,
}

enum : uint
{
    DIBUTTON_2DCONTROL_SELECT   = 0x23000401U,
    DIBUTTON_2DCONTROL_SPECIAL1 = 0x23000402U,
    DIBUTTON_2DCONTROL_SPECIAL  = 0x23000403U,
    DIBUTTON_2DCONTROL_SPECIAL2 = 0x23000404U,
    DIBUTTON_2DCONTROL_MENU     = 0x230004fdU,
}

enum uint DIHATSWITCH_2DCONTROL_HATSWITCH = 0x23004601U;
enum uint DIAXIS_2DCONTROL_ROTATEZ = 0x23024204U;

enum : uint
{
    DIBUTTON_2DCONTROL_DISPLAY = 0x23004405U,
    DIBUTTON_2DCONTROL_DEVICE  = 0x230044feU,
    DIBUTTON_2DCONTROL_PAUSE   = 0x230044fcU,
}

enum uint DIVIRTUAL_CAD_3DCONTROL = 0x24000000U;

enum : uint
{
    DIAXIS_3DCONTROL_LATERAL = 0x24008201U,
    DIAXIS_3DCONTROL_MOVE    = 0x24010202U,
    DIAXIS_3DCONTROL_INOUT   = 0x24018203U,
}

enum : uint
{
    DIBUTTON_3DCONTROL_SELECT   = 0x24000401U,
    DIBUTTON_3DCONTROL_SPECIAL1 = 0x24000402U,
    DIBUTTON_3DCONTROL_SPECIAL  = 0x24000403U,
    DIBUTTON_3DCONTROL_SPECIAL2 = 0x24000404U,
    DIBUTTON_3DCONTROL_MENU     = 0x240004fdU,
}

enum uint DIHATSWITCH_3DCONTROL_HATSWITCH = 0x24004601U;

enum : uint
{
    DIAXIS_3DCONTROL_ROTATEX = 0x24034204U,
    DIAXIS_3DCONTROL_ROTATEY = 0x2402c205U,
    DIAXIS_3DCONTROL_ROTATEZ = 0x24024206U,
}

enum : uint
{
    DIBUTTON_3DCONTROL_DISPLAY = 0x24004405U,
    DIBUTTON_3DCONTROL_DEVICE  = 0x240044feU,
    DIBUTTON_3DCONTROL_PAUSE   = 0x240044fcU,
}

enum uint DIVIRTUAL_CAD_FLYBY = 0x25000000U;

enum : uint
{
    DIAXIS_CADF_LATERAL = 0x25008201U,
    DIAXIS_CADF_MOVE    = 0x25010202U,
    DIAXIS_CADF_INOUT   = 0x25018203U,
}

enum : uint
{
    DIBUTTON_CADF_SELECT   = 0x25000401U,
    DIBUTTON_CADF_SPECIAL1 = 0x25000402U,
    DIBUTTON_CADF_SPECIAL  = 0x25000403U,
    DIBUTTON_CADF_SPECIAL2 = 0x25000404U,
    DIBUTTON_CADF_MENU     = 0x250004fdU,
}

enum uint DIHATSWITCH_CADF_HATSWITCH = 0x25004601U;

enum : uint
{
    DIAXIS_CADF_ROTATEX = 0x25034204U,
    DIAXIS_CADF_ROTATEY = 0x2502c205U,
    DIAXIS_CADF_ROTATEZ = 0x25024206U,
}

enum : uint
{
    DIBUTTON_CADF_DISPLAY = 0x25004405U,
    DIBUTTON_CADF_DEVICE  = 0x250044feU,
    DIBUTTON_CADF_PAUSE   = 0x250044fcU,
}

enum uint DIVIRTUAL_CAD_MODEL = 0x26000000U;

enum : uint
{
    DIAXIS_CADM_LATERAL = 0x26008201U,
    DIAXIS_CADM_MOVE    = 0x26010202U,
    DIAXIS_CADM_INOUT   = 0x26018203U,
}

enum : uint
{
    DIBUTTON_CADM_SELECT   = 0x26000401U,
    DIBUTTON_CADM_SPECIAL1 = 0x26000402U,
    DIBUTTON_CADM_SPECIAL  = 0x26000403U,
    DIBUTTON_CADM_SPECIAL2 = 0x26000404U,
    DIBUTTON_CADM_MENU     = 0x260004fdU,
}

enum uint DIHATSWITCH_CADM_HATSWITCH = 0x26004601U;

enum : uint
{
    DIAXIS_CADM_ROTATEX = 0x26034204U,
    DIAXIS_CADM_ROTATEY = 0x2602c205U,
    DIAXIS_CADM_ROTATEZ = 0x26024206U,
}

enum : uint
{
    DIBUTTON_CADM_DISPLAY = 0x26004405U,
    DIBUTTON_CADM_DEVICE  = 0x260044feU,
    DIBUTTON_CADM_PAUSE   = 0x260044fcU,
}

enum uint DIVIRTUAL_REMOTE_CONTROL = 0x27000000U;
enum uint DIAXIS_REMOTE_SLIDER = 0x27050201U;

enum : uint
{
    DIBUTTON_REMOTE_MUTE   = 0x27000401U,
    DIBUTTON_REMOTE_SELECT = 0x27000402U,
    DIBUTTON_REMOTE_PLAY   = 0x27002403U,
    DIBUTTON_REMOTE_CUE    = 0x27002404U,
    DIBUTTON_REMOTE_REVIEW = 0x27002405U,
    DIBUTTON_REMOTE_CHANGE = 0x27002406U,
    DIBUTTON_REMOTE_RECORD = 0x27002407U,
    DIBUTTON_REMOTE_MENU   = 0x270004fdU,
}

enum uint DIAXIS_REMOTE_SLIDER2 = 0x27054202U;

enum : uint
{
    DIBUTTON_REMOTE_TV     = 0x27005c08U,
    DIBUTTON_REMOTE_CABLE  = 0x27005c09U,
    DIBUTTON_REMOTE_CD     = 0x27005c0aU,
    DIBUTTON_REMOTE_VCR    = 0x27005c0bU,
    DIBUTTON_REMOTE_TUNER  = 0x27005c0cU,
    DIBUTTON_REMOTE_DVD    = 0x27005c0dU,
    DIBUTTON_REMOTE_ADJUST = 0x27005c0eU,
    DIBUTTON_REMOTE_DIGIT0 = 0x2700540fU,
    DIBUTTON_REMOTE_DIGIT1 = 0x27005410U,
    DIBUTTON_REMOTE_DIGIT2 = 0x27005411U,
    DIBUTTON_REMOTE_DIGIT3 = 0x27005412U,
    DIBUTTON_REMOTE_DIGIT4 = 0x27005413U,
    DIBUTTON_REMOTE_DIGIT5 = 0x27005414U,
    DIBUTTON_REMOTE_DIGIT6 = 0x27005415U,
    DIBUTTON_REMOTE_DIGIT7 = 0x27005416U,
    DIBUTTON_REMOTE_DIGIT8 = 0x27005417U,
    DIBUTTON_REMOTE_DIGIT9 = 0x27005418U,
    DIBUTTON_REMOTE_DEVICE = 0x270044feU,
    DIBUTTON_REMOTE_PAUSE  = 0x270044fcU,
}

enum uint DIVIRTUAL_BROWSER_CONTROL = 0x28000000U;

enum : uint
{
    DIAXIS_BROWSER_LATERAL = 0x28008201U,
    DIAXIS_BROWSER_MOVE    = 0x28010202U,
}

enum uint DIBUTTON_BROWSER_SELECT = 0x28000401U;
enum uint DIAXIS_BROWSER_VIEW = 0x28018203U;

enum : uint
{
    DIBUTTON_BROWSER_REFRESH   = 0x28000402U,
    DIBUTTON_BROWSER_MENU      = 0x280004fdU,
    DIBUTTON_BROWSER_SEARCH    = 0x28004403U,
    DIBUTTON_BROWSER_STOP      = 0x28004404U,
    DIBUTTON_BROWSER_HOME      = 0x28004405U,
    DIBUTTON_BROWSER_FAVORITES = 0x28004406U,
    DIBUTTON_BROWSER_NEXT      = 0x28004407U,
    DIBUTTON_BROWSER_PREVIOUS  = 0x28004408U,
    DIBUTTON_BROWSER_HISTORY   = 0x28004409U,
    DIBUTTON_BROWSER_PRINT     = 0x2800440aU,
    DIBUTTON_BROWSER_DEVICE    = 0x280044feU,
    DIBUTTON_BROWSER_PAUSE     = 0x280044fcU,
}

enum uint DIVIRTUAL_DRIVING_MECHA = 0x29000000U;

enum : uint
{
    DIAXIS_MECHA_STEER    = 0x29008201U,
    DIAXIS_MECHA_TORSO    = 0x29010202U,
    DIAXIS_MECHA_ROTATE   = 0x29020203U,
    DIAXIS_MECHA_THROTTLE = 0x29038204U,
}

enum : uint
{
    DIBUTTON_MECHA_FIRE    = 0x29000401U,
    DIBUTTON_MECHA_WEAPONS = 0x29000402U,
    DIBUTTON_MECHA_TARGET  = 0x29000403U,
    DIBUTTON_MECHA_REVERSE = 0x29000404U,
    DIBUTTON_MECHA_ZOOM    = 0x29000405U,
    DIBUTTON_MECHA_JUMP    = 0x29000406U,
    DIBUTTON_MECHA_MENU    = 0x290004fdU,
    DIBUTTON_MECHA_CENTER  = 0x29004407U,
}

enum uint DIHATSWITCH_MECHA_GLANCE = 0x29004601U;

enum : uint
{
    DIBUTTON_MECHA_VIEW              = 0x29004408U,
    DIBUTTON_MECHA_FIRESECONDARY     = 0x29004409U,
    DIBUTTON_MECHA_LEFT_LINK         = 0x2900c4e4U,
    DIBUTTON_MECHA_RIGHT_LINK        = 0x2900c4ecU,
    DIBUTTON_MECHA_FORWARD_LINK      = 0x290144e0U,
    DIBUTTON_MECHA_BACK_LINK         = 0x290144e8U,
    DIBUTTON_MECHA_ROTATE_LEFT_LINK  = 0x290244e4U,
    DIBUTTON_MECHA_ROTATE_RIGHT_LINK = 0x290244ecU,
    DIBUTTON_MECHA_FASTER_LINK       = 0x2903c4e0U,
    DIBUTTON_MECHA_SLOWER_LINK       = 0x2903c4e8U,
    DIBUTTON_MECHA_DEVICE            = 0x290044feU,
    DIBUTTON_MECHA_PAUSE             = 0x290044fcU,
}

enum : uint
{
    DIAXIS_ANY_X_1 = 0xff00c201U,
    DIAXIS_ANY_X_2 = 0xff00c202U,
    DIAXIS_ANY_Y_1 = 0xff014201U,
    DIAXIS_ANY_Y_2 = 0xff014202U,
    DIAXIS_ANY_Z_1 = 0xff01c201U,
    DIAXIS_ANY_Z_2 = 0xff01c202U,
    DIAXIS_ANY_R_1 = 0xff024201U,
    DIAXIS_ANY_R_2 = 0xff024202U,
    DIAXIS_ANY_U_1 = 0xff02c201U,
    DIAXIS_ANY_U_2 = 0xff02c202U,
    DIAXIS_ANY_V_1 = 0xff034201U,
    DIAXIS_ANY_V_2 = 0xff034202U,
    DIAXIS_ANY_A_1 = 0xff03c201U,
    DIAXIS_ANY_A_2 = 0xff03c202U,
    DIAXIS_ANY_B_1 = 0xff044201U,
    DIAXIS_ANY_B_2 = 0xff044202U,
    DIAXIS_ANY_C_1 = 0xff04c201U,
    DIAXIS_ANY_C_2 = 0xff04c202U,
    DIAXIS_ANY_S_1 = 0xff054201U,
    DIAXIS_ANY_S_2 = 0xff054202U,
    DIAXIS_ANY_1   = 0xff004201U,
    DIAXIS_ANY_2   = 0xff004202U,
    DIAXIS_ANY_3   = 0xff004203U,
    DIAXIS_ANY_4   = 0xff004204U,
}

enum : uint
{
    DIPOV_ANY_1 = 0xff004601U,
    DIPOV_ANY_2 = 0xff004602U,
    DIPOV_ANY_3 = 0xff004603U,
    DIPOV_ANY_4 = 0xff004604U,
}

enum int JOY_PASSDRIVERDATA = 0x10000000;

enum : int
{
    JOY_HWS_ISHEADTRACKER      = 0x02000000,
    JOY_HWS_ISGAMEPORTDRIVER   = 0x04000000,
    JOY_HWS_ISANALOGPORTDRIVER = 0x08000000,
}

enum : int
{
    JOY_HWS_AUTOLOAD      = 0x10000000,
    JOY_HWS_NODEVNODE     = 0x20000000,
    JOY_HWS_ISGAMEPORTBUS = 0x80000000,
}

enum int JOY_HWS_GAMEPORTBUSBUSY = 0x00000001;
enum int JOY_US_VOLATILE = 0x00000008;
enum uint JOY_OEMPOLL_PASSDRIVERDATA = 0x00000007U;

enum : uint
{
    BUTTON_BIT_POWER          = 0x00000001U,
    BUTTON_BIT_WINDOWS        = 0x00000002U,
    BUTTON_BIT_VOLUMEUP       = 0x00000004U,
    BUTTON_BIT_VOLUMEDOWN     = 0x00000008U,
    BUTTON_BIT_ROTATION_LOCK  = 0x00000010U,
    BUTTON_BIT_BACK           = 0x00000020U,
    BUTTON_BIT_SEARCH         = 0x00000040U,
    BUTTON_BIT_CAMERAFOCUS    = 0x00000080U,
    BUTTON_BIT_CAMERASHUTTER  = 0x00000100U,
    BUTTON_BIT_RINGERTOGGLE   = 0x00000200U,
    BUTTON_BIT_HEADSET        = 0x00000400U,
    BUTTON_BIT_HWKBDEPLOY     = 0x00000800U,
    BUTTON_BIT_CAMERALENS     = 0x00001000U,
    BUTTON_BIT_OEMCUSTOM      = 0x00002000U,
    BUTTON_BIT_OEMCUSTOM2     = 0x00004000U,
    BUTTON_BIT_OEMCUSTOM3     = 0x00008000U,
    BUTTON_BIT_ALLBUTTONSMASK = 0x00003fffU,
}

enum : uint
{
    IOCTL_BUTTON_SET_ENABLED_ON_IDLE = 0x000b02a8U,
    IOCTL_BUTTON_GET_ENABLED_ON_IDLE = 0x000b02acU,
}

// Callbacks

alias LPDIENUMEFFECTSINFILECALLBACK = BOOL function(DIFILEEFFECT* param0, void* param1);
alias LPDIENUMDEVICEOBJECTSCALLBACKA = BOOL function(DIDEVICEOBJECTINSTANCEA* param0, void* param1);
alias LPDIENUMDEVICEOBJECTSCALLBACKW = BOOL function(DIDEVICEOBJECTINSTANCEW* param0, void* param1);
alias LPDIENUMEFFECTSCALLBACKA = BOOL function(DIEFFECTINFOA* param0, void* param1);
alias LPDIENUMEFFECTSCALLBACKW = BOOL function(DIEFFECTINFOW* param0, void* param1);
alias LPDIENUMCREATEDEFFECTOBJECTSCALLBACK = BOOL function(IDirectInputEffect param0, void* param1);
alias LPDIENUMDEVICESCALLBACKA = BOOL function(DIDEVICEINSTANCEA* param0, void* param1);
alias LPDIENUMDEVICESCALLBACKW = BOOL function(DIDEVICEINSTANCEW* param0, void* param1);
alias LPDICONFIGUREDEVICESCALLBACK = BOOL function(IUnknown param0, void* param1);
alias LPDIENUMDEVICESBYSEMANTICSCBA = BOOL function(DIDEVICEINSTANCEA* param0, IDirectInputDevice8A param1, 
                                                    uint param2, uint param3, void* param4);
alias LPDIENUMDEVICESBYSEMANTICSCBW = BOOL function(DIDEVICEINSTANCEW* param0, IDirectInputDevice8W param1, 
                                                    uint param2, uint param3, void* param4);
alias LPFNSHOWJOYCPL = void function(HWND hWnd);
alias LPDIJOYTYPECALLBACK = BOOL function(const(PWSTR) param0, void* param1);
alias PHIDP_INSERT_SCANCODES = BOOLEAN function(void* Context, 
                                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/PSTR NewScanCodes, 
                                                uint Length);
alias PFN_HidP_GetVersionInternal = NTSTATUS function(uint* Version);

// Structs


struct PHIDP_PREPARSED_DATA
{
    ptrdiff_t Value;
}

struct DICONSTANTFORCE
{
    int lMagnitude;
}

struct DIRAMPFORCE
{
    int lStart;
    int lEnd;
}

struct DIPERIODIC
{
    uint dwMagnitude;
    int  lOffset;
    uint dwPhase;
    uint dwPeriod;
}

struct DICONDITION
{
    int  lOffset;
    int  lPositiveCoefficient;
    int  lNegativeCoefficient;
    uint dwPositiveSaturation;
    uint dwNegativeSaturation;
    int  lDeadBand;
}

struct DICUSTOMFORCE
{
    uint cChannels;
    uint dwSamplePeriod;
    uint cSamples;
    int* rglForceData;
}

struct DIENVELOPE
{
    uint dwSize;
    uint dwAttackLevel;
    uint dwAttackTime;
    uint dwFadeLevel;
    uint dwFadeTime;
}

struct DIEFFECT_DX5
{
    uint        dwSize;
    uint        dwFlags;
    uint        dwDuration;
    uint        dwSamplePeriod;
    uint        dwGain;
    uint        dwTriggerButton;
    uint        dwTriggerRepeatInterval;
    uint        cAxes;
    uint*       rgdwAxes;
    int*        rglDirection;
    DIENVELOPE* lpEnvelope;
    uint        cbTypeSpecificParams;
    void*       lpvTypeSpecificParams;
}

struct DIEFFECT
{
    uint        dwSize;
    uint        dwFlags;
    uint        dwDuration;
    uint        dwSamplePeriod;
    uint        dwGain;
    uint        dwTriggerButton;
    uint        dwTriggerRepeatInterval;
    uint        cAxes;
    uint*       rgdwAxes;
    int*        rglDirection;
    DIENVELOPE* lpEnvelope;
    uint        cbTypeSpecificParams;
    void*       lpvTypeSpecificParams;
    uint        dwStartDelay;
}

struct DIFILEEFFECT
{
    uint      dwSize;
    GUID      GuidEffect;
    DIEFFECT* lpDiEffect;
    CHAR[260] szFriendlyName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dinput/ns-dinput-dieffescape
struct DIEFFESCAPE
{
    uint  dwSize;
    uint  dwCommand;
    void* lpvInBuffer;
    uint  cbInBuffer;
    void* lpvOutBuffer;
    uint  cbOutBuffer;
}

struct DIDEVCAPS_DX3
{
    uint dwSize;
    uint dwFlags;
    uint dwDevType;
    uint dwAxes;
    uint dwButtons;
    uint dwPOVs;
}

struct DIDEVCAPS
{
    uint dwSize;
    uint dwFlags;
    uint dwDevType;
    uint dwAxes;
    uint dwButtons;
    uint dwPOVs;
    uint dwFFSamplePeriod;
    uint dwFFMinTimeResolution;
    uint dwFirmwareRevision;
    uint dwHardwareRevision;
    uint dwFFDriverVersion;
}

struct DIOBJECTDATAFORMAT
{
    const(GUID)* pguid;
    uint         dwOfs;
    uint         dwType;
    uint         dwFlags;
}

struct DIDATAFORMAT
{
    uint                dwSize;
    uint                dwObjSize;
    uint                dwFlags;
    uint                dwDataSize;
    uint                dwNumObjs;
    DIOBJECTDATAFORMAT* rgodf;
}

struct DIACTIONA
{
    size_t uAppData;
    uint   dwSemantic;
    uint   dwFlags;
    union
    {
        const(PSTR) lptszActionName;
        uint        uResIdString;
    }
    GUID   guidInstance;
    uint   dwObjID;
    uint   dwHow;
}

struct DIACTIONW
{
    size_t uAppData;
    uint   dwSemantic;
    uint   dwFlags;
    union
    {
        const(PWSTR) lptszActionName;
        uint         uResIdString;
    }
    GUID   guidInstance;
    uint   dwObjID;
    uint   dwHow;
}

struct DIACTIONFORMATA
{
    uint       dwSize;
    uint       dwActionSize;
    uint       dwDataSize;
    uint       dwNumActions;
    DIACTIONA* rgoAction;
    GUID       guidActionMap;
    uint       dwGenre;
    uint       dwBufferSize;
    int        lAxisMin;
    int        lAxisMax;
    HINSTANCE  hInstString;
    FILETIME   ftTimeStamp;
    uint       dwCRC;
    CHAR[260]  tszActionMap;
}

struct DIACTIONFORMATW
{
    uint       dwSize;
    uint       dwActionSize;
    uint       dwDataSize;
    uint       dwNumActions;
    DIACTIONW* rgoAction;
    GUID       guidActionMap;
    uint       dwGenre;
    uint       dwBufferSize;
    int        lAxisMin;
    int        lAxisMax;
    HINSTANCE  hInstString;
    FILETIME   ftTimeStamp;
    uint       dwCRC;
    wchar[260] tszActionMap;
}

struct DICOLORSET
{
    uint dwSize;
    uint cTextFore;
    uint cTextHighlight;
    uint cCalloutLine;
    uint cCalloutHighlight;
    uint cBorder;
    uint cControlFill;
    uint cHighlightFill;
    uint cAreaFill;
}

struct DICONFIGUREDEVICESPARAMSA
{
    uint             dwSize;
    uint             dwcUsers;
    PSTR             lptszUserNames;
    uint             dwcFormats;
    DIACTIONFORMATA* lprgFormats;
    HWND             hwnd;
    DICOLORSET       dics;
    IUnknown         lpUnkDDSTarget;
}

struct DICONFIGUREDEVICESPARAMSW
{
    uint             dwSize;
    uint             dwcUsers;
    PWSTR            lptszUserNames;
    uint             dwcFormats;
    DIACTIONFORMATW* lprgFormats;
    HWND             hwnd;
    DICOLORSET       dics;
    IUnknown         lpUnkDDSTarget;
}

struct DIDEVICEIMAGEINFOA
{
    CHAR[260] tszImagePath;
    uint      dwFlags;
    uint      dwViewID;
    RECT      rcOverlay;
    uint      dwObjID;
    uint      dwcValidPts;
    POINT[5]  rgptCalloutLine;
    RECT      rcCalloutRect;
    uint      dwTextAlign;
}

struct DIDEVICEIMAGEINFOW
{
    wchar[260] tszImagePath;
    uint       dwFlags;
    uint       dwViewID;
    RECT       rcOverlay;
    uint       dwObjID;
    uint       dwcValidPts;
    POINT[5]   rgptCalloutLine;
    RECT       rcCalloutRect;
    uint       dwTextAlign;
}

struct DIDEVICEIMAGEINFOHEADERA
{
    uint                dwSize;
    uint                dwSizeImageInfo;
    uint                dwcViews;
    uint                dwcButtons;
    uint                dwcAxes;
    uint                dwcPOVs;
    uint                dwBufferSize;
    uint                dwBufferUsed;
    DIDEVICEIMAGEINFOA* lprgImageInfoArray;
}

struct DIDEVICEIMAGEINFOHEADERW
{
    uint                dwSize;
    uint                dwSizeImageInfo;
    uint                dwcViews;
    uint                dwcButtons;
    uint                dwcAxes;
    uint                dwcPOVs;
    uint                dwBufferSize;
    uint                dwBufferUsed;
    DIDEVICEIMAGEINFOW* lprgImageInfoArray;
}

struct DIDEVICEOBJECTINSTANCE_DX3A
{
    uint      dwSize;
    GUID      guidType;
    uint      dwOfs;
    uint      dwType;
    uint      dwFlags;
    CHAR[260] tszName;
}

struct DIDEVICEOBJECTINSTANCE_DX3W
{
    uint       dwSize;
    GUID       guidType;
    uint       dwOfs;
    uint       dwType;
    uint       dwFlags;
    wchar[260] tszName;
}

struct DIDEVICEOBJECTINSTANCEA
{
    uint      dwSize;
    GUID      guidType;
    uint      dwOfs;
    uint      dwType;
    uint      dwFlags;
    CHAR[260] tszName;
    uint      dwFFMaxForce;
    uint      dwFFForceResolution;
    ushort    wCollectionNumber;
    ushort    wDesignatorIndex;
    ushort    wUsagePage;
    ushort    wUsage;
    uint      dwDimension;
    ushort    wExponent;
    ushort    wReportId;
}

struct DIDEVICEOBJECTINSTANCEW
{
    uint       dwSize;
    GUID       guidType;
    uint       dwOfs;
    uint       dwType;
    uint       dwFlags;
    wchar[260] tszName;
    uint       dwFFMaxForce;
    uint       dwFFForceResolution;
    ushort     wCollectionNumber;
    ushort     wDesignatorIndex;
    ushort     wUsagePage;
    ushort     wUsage;
    uint       dwDimension;
    ushort     wExponent;
    ushort     wReportId;
}

struct DIPROPHEADER
{
    uint dwSize;
    uint dwHeaderSize;
    uint dwObj;
    uint dwHow;
}

struct DIPROPDWORD
{
    DIPROPHEADER diph;
    uint         dwData;
}

struct DIPROPPOINTER
{
    DIPROPHEADER diph;
    size_t       uData;
}

struct DIPROPRANGE
{
    DIPROPHEADER diph;
    int          lMin;
    int          lMax;
}

struct DIPROPCAL
{
    DIPROPHEADER diph;
    int          lMin;
    int          lCenter;
    int          lMax;
}

struct DIPROPCALPOV
{
    DIPROPHEADER diph;
    int[5]       lMin;
    int[5]       lMax;
}

struct DIPROPGUIDANDPATH
{
    DIPROPHEADER diph;
    GUID         guidClass;
    wchar[260]   wszPath;
}

struct DIPROPSTRING
{
    DIPROPHEADER diph;
    wchar[260]   wsz;
}

struct CPOINT
{
    int  lP;
    uint dwLog;
}

struct DIPROPCPOINTS
{
    DIPROPHEADER diph;
    uint         dwCPointsNum;
    CPOINT[8]    cp;
}

struct DIDEVICEOBJECTDATA_DX3
{
    uint dwOfs;
    uint dwData;
    uint dwTimeStamp;
    uint dwSequence;
}

struct DIDEVICEOBJECTDATA
{
    uint   dwOfs;
    uint   dwData;
    uint   dwTimeStamp;
    uint   dwSequence;
    size_t uAppData;
}

struct DIDEVICEINSTANCE_DX3A
{
    uint      dwSize;
    GUID      guidInstance;
    GUID      guidProduct;
    uint      dwDevType;
    CHAR[260] tszInstanceName;
    CHAR[260] tszProductName;
}

struct DIDEVICEINSTANCE_DX3W
{
    uint       dwSize;
    GUID       guidInstance;
    GUID       guidProduct;
    uint       dwDevType;
    wchar[260] tszInstanceName;
    wchar[260] tszProductName;
}

struct DIDEVICEINSTANCEA
{
    uint      dwSize;
    GUID      guidInstance;
    GUID      guidProduct;
    uint      dwDevType;
    CHAR[260] tszInstanceName;
    CHAR[260] tszProductName;
    GUID      guidFFDriver;
    ushort    wUsagePage;
    ushort    wUsage;
}

struct DIDEVICEINSTANCEW
{
    uint       dwSize;
    GUID       guidInstance;
    GUID       guidProduct;
    uint       dwDevType;
    wchar[260] tszInstanceName;
    wchar[260] tszProductName;
    GUID       guidFFDriver;
    ushort     wUsagePage;
    ushort     wUsage;
}

struct DIEFFECTINFOA
{
    uint      dwSize;
    GUID      guid;
    uint      dwEffType;
    uint      dwStaticParams;
    uint      dwDynamicParams;
    CHAR[260] tszName;
}

struct DIEFFECTINFOW
{
    uint       dwSize;
    GUID       guid;
    uint       dwEffType;
    uint       dwStaticParams;
    uint       dwDynamicParams;
    wchar[260] tszName;
}

struct DIMOUSESTATE
{
    int      lX;
    int      lY;
    int      lZ;
    ubyte[4] rgbButtons;
}

struct DIMOUSESTATE2
{
    int      lX;
    int      lY;
    int      lZ;
    ubyte[8] rgbButtons;
}

struct DIJOYSTATE
{
    int       lX;
    int       lY;
    int       lZ;
    int       lRx;
    int       lRy;
    int       lRz;
    int[2]    rglSlider;
    uint[4]   rgdwPOV;
    ubyte[32] rgbButtons;
}

struct DIJOYSTATE2
{
    int        lX;
    int        lY;
    int        lZ;
    int        lRx;
    int        lRy;
    int        lRz;
    int[2]     rglSlider;
    uint[4]    rgdwPOV;
    ubyte[128] rgbButtons;
    int        lVX;
    int        lVY;
    int        lVZ;
    int        lVRx;
    int        lVRy;
    int        lVRz;
    int[2]     rglVSlider;
    int        lAX;
    int        lAY;
    int        lAZ;
    int        lARx;
    int        lARy;
    int        lARz;
    int[2]     rglASlider;
    int        lFX;
    int        lFY;
    int        lFZ;
    int        lFRx;
    int        lFRy;
    int        lFRz;
    int[2]     rglFSlider;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dinputd/ns-dinputd-diobjectattributes
struct DIOBJECTATTRIBUTES
{
    uint   dwFlags;
    ushort wUsagePage;
    ushort wUsage;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dinputd/ns-dinputd-diffobjectattributes
struct DIFFOBJECTATTRIBUTES
{
    uint dwFFMaxForce;
    uint dwFFForceResolution;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dinputd/ns-dinputd-diobjectcalibration
struct DIOBJECTCALIBRATION
{
    int lMin;
    int lCenter;
    int lMax;
}

struct DIPOVCALIBRATION
{
    int[5] lMin;
    int[5] lMax;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dinputd/ns-dinputd-dieffectattributes
struct DIEFFECTATTRIBUTES
{
    uint dwEffectId;
    uint dwEffType;
    uint dwStaticParams;
    uint dwDynamicParams;
    uint dwCoords;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dinputd/ns-dinputd-diffdeviceattributes
struct DIFFDEVICEATTRIBUTES
{
    uint dwFlags;
    uint dwFFSamplePeriod;
    uint dwFFMinTimeResolution;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dinputd/ns-dinputd-didriverversions
struct DIDRIVERVERSIONS
{
    uint dwSize;
    uint dwFirmwareRevision;
    uint dwHardwareRevision;
    uint dwFFDriverVersion;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dinputd/ns-dinputd-didevicestate
struct DIDEVICESTATE
{
    uint dwSize;
    uint dwState;
    uint dwLoad;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dinputd/ns-dinputd-dihidffinitinfo
struct DIHIDFFINITINFO
{
    uint  dwSize;
    PWSTR pwszDeviceInterface;
    GUID  GuidInstance;
}

struct JOYPOS
{
    uint dwX;
    uint dwY;
    uint dwZ;
    uint dwR;
    uint dwU;
    uint dwV;
}

struct JOYRANGE
{
    JOYPOS jpMin;
    JOYPOS jpMax;
    JOYPOS jpCenter;
}

struct JOYREGUSERVALUES
{
    uint     dwTimeOut;
    JOYRANGE jrvRanges;
    JOYPOS   jpDeadZone;
}

struct JOYREGHWSETTINGS
{
    uint dwFlags;
    uint dwNumButtons;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dinputd/ns-dinputd-joyreghwvalues
struct JOYREGHWVALUES
{
    JOYRANGE jrvHardware;
    uint[4]  dwPOVValues;
    uint     dwCalFlags;
}

struct JOYREGHWCONFIG
{
    JOYREGHWSETTINGS hws;
    uint             dwUsageSettings;
    JOYREGHWVALUES   hwv;
    uint             dwType;
    uint             dwReserved;
}

struct JOYCALIBRATE
{
    uint wXbase;
    uint wXdelta;
    uint wYbase;
    uint wYdelta;
    uint wZbase;
    uint wZdelta;
}

struct DIJOYTYPEINFO_DX5
{
    uint             dwSize;
    JOYREGHWSETTINGS hws;
    GUID             clsidConfig;
    wchar[256]       wszDisplayName;
    wchar[260]       wszCallout;
}

struct DIJOYTYPEINFO_DX6
{
    uint             dwSize;
    JOYREGHWSETTINGS hws;
    GUID             clsidConfig;
    wchar[256]       wszDisplayName;
    wchar[260]       wszCallout;
    wchar[256]       wszHardwareId;
    uint             dwFlags1;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dinputd/ns-dinputd-dijoytypeinfo
struct DIJOYTYPEINFO
{
    uint             dwSize;
    JOYREGHWSETTINGS hws;
    GUID             clsidConfig;
    wchar[256]       wszDisplayName;
    wchar[260]       wszCallout;
    wchar[256]       wszHardwareId;
    uint             dwFlags1;
    uint             dwFlags2;
    wchar[256]       wszMapFile;
}

struct DIJOYCONFIG_DX5
{
    uint           dwSize;
    GUID           guidInstance;
    JOYREGHWCONFIG hwc;
    uint           dwGain;
    wchar[256]     wszType;
    wchar[256]     wszCallout;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dinputd/ns-dinputd-dijoyconfig
struct DIJOYCONFIG
{
    uint           dwSize;
    GUID           guidInstance;
    JOYREGHWCONFIG hwc;
    uint           dwGain;
    wchar[256]     wszType;
    wchar[256]     wszCallout;
    GUID           guidGameport;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dinputd/ns-dinputd-dijoyuservalues
struct DIJOYUSERVALUES
{
    uint             dwSize;
    JOYREGUSERVALUES ruv;
    wchar[256]       wszGlobalDriver;
    wchar[256]       wszGameportEmulator;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntddkbd/ns-ntddkbd-keyboard_input_data
struct KEYBOARD_INPUT_DATA
{
    ushort UnitId;
    ushort MakeCode;
    ushort Flags;
    ushort Reserved;
    uint   ExtraInformation;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntddkbd/ns-ntddkbd-keyboard_typematic_parameters
struct KEYBOARD_TYPEMATIC_PARAMETERS
{
    ushort UnitId;
    ushort Rate;
    ushort Delay;
}

struct KEYBOARD_ID
{
    ubyte Type;
    ubyte Subtype;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntddkbd/ns-ntddkbd-keyboard_attributes
struct KEYBOARD_ATTRIBUTES
{
    KEYBOARD_ID KeyboardIdentifier;
    ushort      KeyboardMode;
    ushort      NumberOfFunctionKeys;
    ushort      NumberOfIndicators;
    ushort      NumberOfKeysTotal;
    uint        InputDataQueueLength;
    KEYBOARD_TYPEMATIC_PARAMETERS KeyRepeatMinimum;
    KEYBOARD_TYPEMATIC_PARAMETERS KeyRepeatMaximum;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntddkbd/ns-ntddkbd-keyboard_extended_attributes
struct KEYBOARD_EXTENDED_ATTRIBUTES
{
    ubyte Version;
    ubyte FormFactor;
    ubyte KeyType;
    ubyte PhysicalLayout;
    ubyte VendorSpecificPhysicalLayout;
    ubyte IETFLanguageTagIndex;
    ubyte ImplementedInputAssistControls;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntddkbd/ns-ntddkbd-keyboard_indicator_parameters
struct KEYBOARD_INDICATOR_PARAMETERS
{
    ushort UnitId;
    ushort LedFlags;
}

struct INDICATOR_LIST
{
    ushort MakeCode;
    ushort IndicatorFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntddkbd/ns-ntddkbd-keyboard_indicator_translation
struct KEYBOARD_INDICATOR_TRANSLATION
{
    ushort NumberOfIndicatorKeys;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/INDICATOR_LIST[1] IndicatorList;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntddkbd/ns-ntddkbd-keyboard_unit_id_parameter
struct KEYBOARD_UNIT_ID_PARAMETER
{
    ushort UnitId;
}

struct KEYBOARD_IME_STATUS
{
    ushort UnitId;
    uint   ImeOpen;
    uint   ImeConvMode;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntddmou/ns-ntddmou-mouse_input_data
struct MOUSE_INPUT_DATA
{
    ushort UnitId;
    ushort Flags;
    union
    {
        uint Buttons;
        struct
        {
            ushort ButtonFlags;
            ushort ButtonData;
        }
    }
    uint   RawButtons;
    int    LastX;
    int    LastY;
    uint   ExtraInformation;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntddmou/ns-ntddmou-mouse_attributes
struct MOUSE_ATTRIBUTES
{
    ushort MouseIdentifier;
    ushort NumberOfButtons;
    ushort SampleRate;
    uint   InputDataQueueLength;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntddmou/ns-ntddmou-mouse_unit_id_parameter
struct MOUSE_UNIT_ID_PARAMETER
{
    ushort UnitId;
}

struct USAGE_AND_PAGE
{
    ushort Usage;
    ushort UsagePage;
}

struct HIDP_BUTTON_CAPS
{
    ushort  UsagePage;
    ubyte   ReportID;
    BOOLEAN IsAlias;
    ushort  BitField;
    ushort  LinkCollection;
    ushort  LinkUsage;
    ushort  LinkUsagePage;
    BOOLEAN IsRange;
    BOOLEAN IsStringRange;
    BOOLEAN IsDesignatorRange;
    BOOLEAN IsAbsolute;
    ushort  ReportCount;
    ushort  Reserved2;
    uint[9] Reserved;
    union
    {
        struct Range
        {
            ushort UsageMin;
            ushort UsageMax;
            ushort StringMin;
            ushort StringMax;
            ushort DesignatorMin;
            ushort DesignatorMax;
            ushort DataIndexMin;
            ushort DataIndexMax;
        }
        struct NotRange
        {
            ushort Usage;
            ushort Reserved1;
            ushort StringIndex;
            ushort Reserved2;
            ushort DesignatorIndex;
            ushort Reserved3;
            ushort DataIndex;
            ushort Reserved4;
        }
    }
}

struct HIDP_VALUE_CAPS
{
    ushort    UsagePage;
    ubyte     ReportID;
    BOOLEAN   IsAlias;
    ushort    BitField;
    ushort    LinkCollection;
    ushort    LinkUsage;
    ushort    LinkUsagePage;
    BOOLEAN   IsRange;
    BOOLEAN   IsStringRange;
    BOOLEAN   IsDesignatorRange;
    BOOLEAN   IsAbsolute;
    BOOLEAN   HasNull;
    ubyte     Reserved;
    ushort    BitSize;
    ushort    ReportCount;
    ushort[5] Reserved2;
    uint      UnitsExp;
    uint      Units;
    int       LogicalMin;
    int       LogicalMax;
    int       PhysicalMin;
    int       PhysicalMax;
    union
    {
        struct Range
        {
            ushort UsageMin;
            ushort UsageMax;
            ushort StringMin;
            ushort StringMax;
            ushort DesignatorMin;
            ushort DesignatorMax;
            ushort DataIndexMin;
            ushort DataIndexMax;
        }
        struct NotRange
        {
            ushort Usage;
            ushort Reserved1;
            ushort StringIndex;
            ushort Reserved2;
            ushort DesignatorIndex;
            ushort Reserved3;
            ushort DataIndex;
            ushort Reserved4;
        }
    }
}

struct HIDP_LINK_COLLECTION_NODE
{
align (4):
    ushort LinkUsage;
    ushort LinkUsagePage;
    ushort Parent;
    ushort NumberOfChildren;
    ushort NextSibling;
    ushort FirstChild;
    /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(Reserved)), FixedArgSig(ElementSig(9)), FixedArgSig(ElementSig(23))], [])*/uint _bitfield48;
    void*  UserContext;
}

struct HIDP_CAPS
{
    ushort     Usage;
    ushort     UsagePage;
    ushort     InputReportByteLength;
    ushort     OutputReportByteLength;
    ushort     FeatureReportByteLength;
    ushort[17] Reserved;
    ushort     NumberLinkCollectionNodes;
    ushort     NumberInputButtonCaps;
    ushort     NumberInputValueCaps;
    ushort     NumberInputDataIndices;
    ushort     NumberOutputButtonCaps;
    ushort     NumberOutputValueCaps;
    ushort     NumberOutputDataIndices;
    ushort     NumberFeatureButtonCaps;
    ushort     NumberFeatureValueCaps;
    ushort     NumberFeatureDataIndices;
}

struct HIDP_DATA
{
    ushort DataIndex;
    ushort Reserved;
    union
    {
        uint    RawValue;
        BOOLEAN On;
    }
}

struct HIDP_UNKNOWN_TOKEN
{
    ubyte    Token;
    ubyte[3] Reserved;
    uint     BitField;
}

struct HIDP_EXTENDED_ATTRIBUTES
{
align (4):
    ubyte               NumGlobalUnknowns;
    ubyte[3]            Reserved;
    HIDP_UNKNOWN_TOKEN* GlobalUnknowns;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/uint[1] Data;
}

struct HIDP_BUTTON_ARRAY_DATA
{
    ushort  ArrayIndex;
    BOOLEAN On;
}

struct HIDP_KEYBOARD_MODIFIER_STATE
{
    union
    {
        struct
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(Reserved)), FixedArgSig(ElementSig(11)), FixedArgSig(ElementSig(21))], [])*/uint _bitfield49;
        }
        uint ul;
    }
}

struct HIDD_CONFIGURATION
{
align (4):
    void* cookie;
    uint  size;
    uint  RingBufferSize;
}

struct HIDD_ATTRIBUTES
{
    uint   Size;
    ushort VendorID;
    ushort ProductID;
    ushort VersionNumber;
}

struct HID_XFER_PACKET
{
    ubyte* reportBuffer;
    uint   reportBufferLen;
    ubyte  reportId;
}

struct HID_COLLECTION_INFORMATION
{
    uint     DescriptorSize;
    BOOLEAN  Polled;
    ubyte[1] Reserved1;
    ushort   VendorID;
    ushort   ProductID;
    ushort   VersionNumber;
}

struct HID_DRIVER_CONFIG
{
    uint Size;
    uint RingBufferSize;
}

struct INPUT_BUTTON_ENABLE_INFO
{
    GPIOBUTTONS_BUTTON_TYPE ButtonType;
    BOOLEAN Enabled;
}

// Functions

@DllImport("DINPUT8.dll")
HRESULT DirectInput8Create(HINSTANCE hinst, uint dwVersion, const(GUID)* riidltf, void** ppvOut, 
                           IUnknown punkOuter);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint joyConfigChanged(uint dwFlags);

@DllImport("HID.dll")
NTSTATUS HidP_GetCaps(PHIDP_PREPARSED_DATA PreparsedData, HIDP_CAPS* Capabilities);

@DllImport("HID.dll")
NTSTATUS HidP_GetLinkCollectionNodes(HIDP_LINK_COLLECTION_NODE* LinkCollectionNodes, 
                                     uint* LinkCollectionNodesLength, PHIDP_PREPARSED_DATA PreparsedData);

@DllImport("HID.dll")
NTSTATUS HidP_GetSpecificButtonCaps(HIDP_REPORT_TYPE ReportType, ushort UsagePage, ushort LinkCollection, 
                                    ushort Usage, HIDP_BUTTON_CAPS* ButtonCaps, ushort* ButtonCapsLength, 
                                    PHIDP_PREPARSED_DATA PreparsedData);

@DllImport("HID.dll")
NTSTATUS HidP_GetButtonCaps(HIDP_REPORT_TYPE ReportType, HIDP_BUTTON_CAPS* ButtonCaps, ushort* ButtonCapsLength, 
                            PHIDP_PREPARSED_DATA PreparsedData);

@DllImport("HID.dll")
NTSTATUS HidP_GetSpecificValueCaps(HIDP_REPORT_TYPE ReportType, ushort UsagePage, ushort LinkCollection, 
                                   ushort Usage, HIDP_VALUE_CAPS* ValueCaps, ushort* ValueCapsLength, 
                                   PHIDP_PREPARSED_DATA PreparsedData);

@DllImport("HID.dll")
NTSTATUS HidP_GetValueCaps(HIDP_REPORT_TYPE ReportType, HIDP_VALUE_CAPS* ValueCaps, ushort* ValueCapsLength, 
                           PHIDP_PREPARSED_DATA PreparsedData);

@DllImport("HID.dll")
NTSTATUS HidP_GetExtendedAttributes(HIDP_REPORT_TYPE ReportType, ushort DataIndex, 
                                    PHIDP_PREPARSED_DATA PreparsedData, HIDP_EXTENDED_ATTRIBUTES* Attributes, 
                                    uint* LengthAttributes);

@DllImport("HID.dll")
NTSTATUS HidP_InitializeReportForID(HIDP_REPORT_TYPE ReportType, ubyte ReportID, 
                                    PHIDP_PREPARSED_DATA PreparsedData, 
                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/PSTR Report, 
                                    uint ReportLength);

@DllImport("HID.dll")
NTSTATUS HidP_SetData(HIDP_REPORT_TYPE ReportType, HIDP_DATA* DataList, uint* DataLength, 
                      PHIDP_PREPARSED_DATA PreparsedData, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/PSTR Report, 
                      uint ReportLength);

@DllImport("HID.dll")
NTSTATUS HidP_GetData(HIDP_REPORT_TYPE ReportType, HIDP_DATA* DataList, uint* DataLength, 
                      PHIDP_PREPARSED_DATA PreparsedData, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/PSTR Report, 
                      uint ReportLength);

@DllImport("HID.dll")
uint HidP_MaxDataListLength(HIDP_REPORT_TYPE ReportType, PHIDP_PREPARSED_DATA PreparsedData);

@DllImport("HID.dll")
NTSTATUS HidP_SetUsages(HIDP_REPORT_TYPE ReportType, ushort UsagePage, ushort LinkCollection, ushort* UsageList, 
                        uint* UsageLength, PHIDP_PREPARSED_DATA PreparsedData, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(7)))])*/PSTR Report, 
                        uint ReportLength);

@DllImport("HID.dll")
NTSTATUS HidP_UnsetUsages(HIDP_REPORT_TYPE ReportType, ushort UsagePage, ushort LinkCollection, ushort* UsageList, 
                          uint* UsageLength, PHIDP_PREPARSED_DATA PreparsedData, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(7)))])*/PSTR Report, 
                          uint ReportLength);

@DllImport("HID.dll")
NTSTATUS HidP_GetUsages(HIDP_REPORT_TYPE ReportType, ushort UsagePage, ushort LinkCollection, ushort* UsageList, 
                        uint* UsageLength, PHIDP_PREPARSED_DATA PreparsedData, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(7)))])*/PSTR Report, 
                        uint ReportLength);

@DllImport("HID.dll")
NTSTATUS HidP_GetUsagesEx(HIDP_REPORT_TYPE ReportType, ushort LinkCollection, USAGE_AND_PAGE* ButtonList, 
                          uint* UsageLength, PHIDP_PREPARSED_DATA PreparsedData, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/PSTR Report, 
                          uint ReportLength);

@DllImport("HID.dll")
uint HidP_MaxUsageListLength(HIDP_REPORT_TYPE ReportType, ushort UsagePage, PHIDP_PREPARSED_DATA PreparsedData);

@DllImport("HID.dll")
NTSTATUS HidP_SetUsageValue(HIDP_REPORT_TYPE ReportType, ushort UsagePage, ushort LinkCollection, ushort Usage, 
                            uint UsageValue, PHIDP_PREPARSED_DATA PreparsedData, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(7)))])*/PSTR Report, 
                            uint ReportLength);

@DllImport("HID.dll")
NTSTATUS HidP_SetScaledUsageValue(HIDP_REPORT_TYPE ReportType, ushort UsagePage, ushort LinkCollection, 
                                  ushort Usage, int UsageValue, PHIDP_PREPARSED_DATA PreparsedData, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(7)))])*/PSTR Report, 
                                  uint ReportLength);

@DllImport("HID.dll")
NTSTATUS HidP_SetUsageValueArray(HIDP_REPORT_TYPE ReportType, ushort UsagePage, ushort LinkCollection, 
                                 ushort Usage, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/PSTR UsageValue, 
                                 ushort UsageValueByteLength, PHIDP_PREPARSED_DATA PreparsedData, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(8)))])*/PSTR Report, 
                                 uint ReportLength);

@DllImport("HID.dll")
NTSTATUS HidP_GetUsageValue(HIDP_REPORT_TYPE ReportType, ushort UsagePage, ushort LinkCollection, ushort Usage, 
                            uint* UsageValue, PHIDP_PREPARSED_DATA PreparsedData, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(7)))])*/PSTR Report, 
                            uint ReportLength);

@DllImport("HID.dll")
NTSTATUS HidP_GetScaledUsageValue(HIDP_REPORT_TYPE ReportType, ushort UsagePage, ushort LinkCollection, 
                                  ushort Usage, int* UsageValue, PHIDP_PREPARSED_DATA PreparsedData, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(7)))])*/PSTR Report, 
                                  uint ReportLength);

@DllImport("HID.dll")
NTSTATUS HidP_GetUsageValueArray(HIDP_REPORT_TYPE ReportType, ushort UsagePage, ushort LinkCollection, 
                                 ushort Usage, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/PSTR UsageValue, 
                                 ushort UsageValueByteLength, PHIDP_PREPARSED_DATA PreparsedData, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(8)))])*/PSTR Report, 
                                 uint ReportLength);

@DllImport("HID.dll")
NTSTATUS HidP_UsageListDifference(ushort* PreviousUsageList, ushort* CurrentUsageList, ushort* BreakUsageList, 
                                  ushort* MakeUsageList, uint UsageListLength);

@DllImport("HID.dll")
NTSTATUS HidP_GetButtonArray(HIDP_REPORT_TYPE ReportType, ushort UsagePage, ushort LinkCollection, ushort Usage, 
                             HIDP_BUTTON_ARRAY_DATA* ButtonData, ushort* ButtonDataLength, 
                             PHIDP_PREPARSED_DATA PreparsedData, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(8)))])*/PSTR Report, 
                             uint ReportLength);

@DllImport("HID.dll")
NTSTATUS HidP_SetButtonArray(HIDP_REPORT_TYPE ReportType, ushort UsagePage, ushort LinkCollection, ushort Usage, 
                             HIDP_BUTTON_ARRAY_DATA* ButtonData, ushort ButtonDataLength, 
                             PHIDP_PREPARSED_DATA PreparsedData, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(8)))])*/PSTR Report, 
                             uint ReportLength);

@DllImport("HID.dll")
NTSTATUS HidP_TranslateUsagesToI8042ScanCodes(ushort* ChangedUsageList, uint UsageListLength, 
                                              HIDP_KEYBOARD_DIRECTION KeyAction, 
                                              HIDP_KEYBOARD_MODIFIER_STATE* ModifierState, 
                                              PHIDP_INSERT_SCANCODES InsertCodesProcedure, void* InsertCodesContext);

@DllImport("HID.dll")
BOOLEAN HidD_GetAttributes(HANDLE HidDeviceObject, HIDD_ATTRIBUTES* Attributes);

@DllImport("HID.dll")
void HidD_GetHidGuid(GUID* HidGuid);

@DllImport("HID.dll")
BOOLEAN HidD_GetPreparsedData(HANDLE HidDeviceObject, PHIDP_PREPARSED_DATA* PreparsedData);

@DllImport("HID.dll")
BOOLEAN HidD_FreePreparsedData(PHIDP_PREPARSED_DATA PreparsedData);

@DllImport("HID.dll")
BOOLEAN HidD_FlushQueue(HANDLE HidDeviceObject);

@DllImport("HID.dll")
BOOLEAN HidD_GetConfiguration(HANDLE HidDeviceObject, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/HIDD_CONFIGURATION* Configuration, 
                              uint ConfigurationLength);

@DllImport("HID.dll")
BOOLEAN HidD_SetConfiguration(HANDLE HidDeviceObject, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/HIDD_CONFIGURATION* Configuration, 
                              uint ConfigurationLength);

@DllImport("HID.dll")
BOOLEAN HidD_GetFeature(HANDLE HidDeviceObject, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* ReportBuffer, 
                        uint ReportBufferLength);

@DllImport("HID.dll")
BOOLEAN HidD_SetFeature(HANDLE HidDeviceObject, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* ReportBuffer, 
                        uint ReportBufferLength);

@DllImport("HID.dll")
BOOLEAN HidD_GetInputReport(HANDLE HidDeviceObject, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* ReportBuffer, 
                            uint ReportBufferLength);

@DllImport("HID.dll")
BOOLEAN HidD_SetOutputReport(HANDLE HidDeviceObject, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* ReportBuffer, 
                             uint ReportBufferLength);

@DllImport("HID.dll")
BOOLEAN HidD_GetNumInputBuffers(HANDLE HidDeviceObject, uint* NumberBuffers);

@DllImport("HID.dll")
BOOLEAN HidD_SetNumInputBuffers(HANDLE HidDeviceObject, uint NumberBuffers);

@DllImport("HID.dll")
BOOLEAN HidD_GetPhysicalDescriptor(HANDLE HidDeviceObject, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* Buffer, 
                                   uint BufferLength);

@DllImport("HID.dll")
BOOLEAN HidD_GetManufacturerString(HANDLE HidDeviceObject, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* Buffer, 
                                   uint BufferLength);

@DllImport("HID.dll")
BOOLEAN HidD_GetProductString(HANDLE HidDeviceObject, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* Buffer, 
                              uint BufferLength);

@DllImport("HID.dll")
BOOLEAN HidD_GetIndexedString(HANDLE HidDeviceObject, uint StringIndex, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Buffer, 
                              uint BufferLength);

@DllImport("HID.dll")
BOOLEAN HidD_GetSerialNumberString(HANDLE HidDeviceObject, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* Buffer, 
                                   uint BufferLength);

@DllImport("HID.dll")
BOOLEAN HidD_GetMsGenreDescriptor(HANDLE HidDeviceObject, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* Buffer, 
                                  uint BufferLength);


// Interfaces

@GUID("e7e1f7c0-88d2-11d0-9ad0-00a0c9a06e35")
interface IDirectInputEffect : IUnknown
{
    HRESULT Initialize(HINSTANCE param0, uint param1, const(GUID)* param2);
    HRESULT GetEffectGuid(GUID* param0);
    HRESULT GetParameters(DIEFFECT* param0, uint param1);
    HRESULT SetParameters(DIEFFECT* param0, uint param1);
    HRESULT Start(uint param0, uint param1);
    HRESULT Stop();
    HRESULT GetEffectStatus(uint* param0);
    HRESULT Download();
    HRESULT Unload();
    HRESULT Escape(DIEFFESCAPE* param0);
}

@GUID("5944e681-c92e-11cf-bfc7-444553540000")
interface IDirectInputDeviceW : IUnknown
{
    HRESULT GetCapabilities(DIDEVCAPS* param0);
    HRESULT EnumObjects(LPDIENUMDEVICEOBJECTSCALLBACKW param0, void* param1, uint param2);
    HRESULT GetProperty(const(GUID)* param0, DIPROPHEADER* param1);
    HRESULT SetProperty(const(GUID)* param0, DIPROPHEADER* param1);
    HRESULT Acquire();
    HRESULT Unacquire();
    HRESULT GetDeviceState(uint param0, void* param1);
    HRESULT GetDeviceData(uint param0, DIDEVICEOBJECTDATA* param1, uint* param2, uint param3);
    HRESULT SetDataFormat(DIDATAFORMAT* param0);
    HRESULT SetEventNotification(HANDLE param0);
    HRESULT SetCooperativeLevel(HWND param0, uint param1);
    HRESULT GetObjectInfo(DIDEVICEOBJECTINSTANCEW* param0, uint param1, uint param2);
    HRESULT GetDeviceInfo(DIDEVICEINSTANCEW* param0);
    HRESULT RunControlPanel(HWND param0, uint param1);
    HRESULT Initialize(HINSTANCE param0, uint param1, const(GUID)* param2);
}

@GUID("5944e680-c92e-11cf-bfc7-444553540000")
interface IDirectInputDeviceA : IUnknown
{
    HRESULT GetCapabilities(DIDEVCAPS* param0);
    HRESULT EnumObjects(LPDIENUMDEVICEOBJECTSCALLBACKA param0, void* param1, uint param2);
    HRESULT GetProperty(const(GUID)* param0, DIPROPHEADER* param1);
    HRESULT SetProperty(const(GUID)* param0, DIPROPHEADER* param1);
    HRESULT Acquire();
    HRESULT Unacquire();
    HRESULT GetDeviceState(uint param0, void* param1);
    HRESULT GetDeviceData(uint param0, DIDEVICEOBJECTDATA* param1, uint* param2, uint param3);
    HRESULT SetDataFormat(DIDATAFORMAT* param0);
    HRESULT SetEventNotification(HANDLE param0);
    HRESULT SetCooperativeLevel(HWND param0, uint param1);
    HRESULT GetObjectInfo(DIDEVICEOBJECTINSTANCEA* param0, uint param1, uint param2);
    HRESULT GetDeviceInfo(DIDEVICEINSTANCEA* param0);
    HRESULT RunControlPanel(HWND param0, uint param1);
    HRESULT Initialize(HINSTANCE param0, uint param1, const(GUID)* param2);
}

@GUID("5944e683-c92e-11cf-bfc7-444553540000")
interface IDirectInputDevice2W : IDirectInputDeviceW
{
    HRESULT CreateEffect(const(GUID)* param0, DIEFFECT* param1, IDirectInputEffect* param2, IUnknown param3);
    HRESULT EnumEffects(LPDIENUMEFFECTSCALLBACKW param0, void* param1, uint param2);
    HRESULT GetEffectInfo(DIEFFECTINFOW* param0, const(GUID)* param1);
    HRESULT GetForceFeedbackState(uint* param0);
    HRESULT SendForceFeedbackCommand(uint param0);
    HRESULT EnumCreatedEffectObjects(LPDIENUMCREATEDEFFECTOBJECTSCALLBACK param0, void* param1, uint param2);
    HRESULT Escape(DIEFFESCAPE* param0);
    HRESULT Poll();
    HRESULT SendDeviceData(uint param0, DIDEVICEOBJECTDATA* param1, uint* param2, uint param3);
}

@GUID("5944e682-c92e-11cf-bfc7-444553540000")
interface IDirectInputDevice2A : IDirectInputDeviceA
{
    HRESULT CreateEffect(const(GUID)* param0, DIEFFECT* param1, IDirectInputEffect* param2, IUnknown param3);
    HRESULT EnumEffects(LPDIENUMEFFECTSCALLBACKA param0, void* param1, uint param2);
    HRESULT GetEffectInfo(DIEFFECTINFOA* param0, const(GUID)* param1);
    HRESULT GetForceFeedbackState(uint* param0);
    HRESULT SendForceFeedbackCommand(uint param0);
    HRESULT EnumCreatedEffectObjects(LPDIENUMCREATEDEFFECTOBJECTSCALLBACK param0, void* param1, uint param2);
    HRESULT Escape(DIEFFESCAPE* param0);
    HRESULT Poll();
    HRESULT SendDeviceData(uint param0, DIDEVICEOBJECTDATA* param1, uint* param2, uint param3);
}

@GUID("57d7c6bd-2356-11d3-8e9d-00c04f6844ae")
interface IDirectInputDevice7W : IDirectInputDevice2W
{
    HRESULT EnumEffectsInFile(const(PWSTR) param0, LPDIENUMEFFECTSINFILECALLBACK param1, void* param2, uint param3);
    HRESULT WriteEffectToFile(const(PWSTR) param0, uint param1, DIFILEEFFECT* param2, uint param3);
}

@GUID("57d7c6bc-2356-11d3-8e9d-00c04f6844ae")
interface IDirectInputDevice7A : IDirectInputDevice2A
{
    HRESULT EnumEffectsInFile(const(PSTR) param0, LPDIENUMEFFECTSINFILECALLBACK param1, void* param2, uint param3);
    HRESULT WriteEffectToFile(const(PSTR) param0, uint param1, DIFILEEFFECT* param2, uint param3);
}

@GUID("54d41081-dc15-4833-a41b-748f73a38179")
interface IDirectInputDevice8W : IUnknown
{
    HRESULT GetCapabilities(DIDEVCAPS* param0);
    HRESULT EnumObjects(LPDIENUMDEVICEOBJECTSCALLBACKW param0, void* param1, uint param2);
    HRESULT GetProperty(const(GUID)* param0, DIPROPHEADER* param1);
    HRESULT SetProperty(const(GUID)* param0, DIPROPHEADER* param1);
    HRESULT Acquire();
    HRESULT Unacquire();
    HRESULT GetDeviceState(uint param0, void* param1);
    HRESULT GetDeviceData(uint param0, DIDEVICEOBJECTDATA* param1, uint* param2, uint param3);
    HRESULT SetDataFormat(DIDATAFORMAT* param0);
    HRESULT SetEventNotification(HANDLE param0);
    HRESULT SetCooperativeLevel(HWND param0, uint param1);
    HRESULT GetObjectInfo(DIDEVICEOBJECTINSTANCEW* param0, uint param1, uint param2);
    HRESULT GetDeviceInfo(DIDEVICEINSTANCEW* param0);
    HRESULT RunControlPanel(HWND param0, uint param1);
    HRESULT Initialize(HINSTANCE param0, uint param1, const(GUID)* param2);
    HRESULT CreateEffect(const(GUID)* param0, DIEFFECT* param1, IDirectInputEffect* param2, IUnknown param3);
    HRESULT EnumEffects(LPDIENUMEFFECTSCALLBACKW param0, void* param1, uint param2);
    HRESULT GetEffectInfo(DIEFFECTINFOW* param0, const(GUID)* param1);
    HRESULT GetForceFeedbackState(uint* param0);
    HRESULT SendForceFeedbackCommand(uint param0);
    HRESULT EnumCreatedEffectObjects(LPDIENUMCREATEDEFFECTOBJECTSCALLBACK param0, void* param1, uint param2);
    HRESULT Escape(DIEFFESCAPE* param0);
    HRESULT Poll();
    HRESULT SendDeviceData(uint param0, DIDEVICEOBJECTDATA* param1, uint* param2, uint param3);
    HRESULT EnumEffectsInFile(const(PWSTR) param0, LPDIENUMEFFECTSINFILECALLBACK param1, void* param2, uint param3);
    HRESULT WriteEffectToFile(const(PWSTR) param0, uint param1, DIFILEEFFECT* param2, uint param3);
    HRESULT BuildActionMap(DIACTIONFORMATW* param0, const(PWSTR) param1, uint param2);
    HRESULT SetActionMap(DIACTIONFORMATW* param0, const(PWSTR) param1, uint param2);
    HRESULT GetImageInfo(DIDEVICEIMAGEINFOHEADERW* param0);
}

@GUID("54d41080-dc15-4833-a41b-748f73a38179")
interface IDirectInputDevice8A : IUnknown
{
    HRESULT GetCapabilities(DIDEVCAPS* param0);
    HRESULT EnumObjects(LPDIENUMDEVICEOBJECTSCALLBACKA param0, void* param1, uint param2);
    HRESULT GetProperty(const(GUID)* param0, DIPROPHEADER* param1);
    HRESULT SetProperty(const(GUID)* param0, DIPROPHEADER* param1);
    HRESULT Acquire();
    HRESULT Unacquire();
    HRESULT GetDeviceState(uint param0, void* param1);
    HRESULT GetDeviceData(uint param0, DIDEVICEOBJECTDATA* param1, uint* param2, uint param3);
    HRESULT SetDataFormat(DIDATAFORMAT* param0);
    HRESULT SetEventNotification(HANDLE param0);
    HRESULT SetCooperativeLevel(HWND param0, uint param1);
    HRESULT GetObjectInfo(DIDEVICEOBJECTINSTANCEA* param0, uint param1, uint param2);
    HRESULT GetDeviceInfo(DIDEVICEINSTANCEA* param0);
    HRESULT RunControlPanel(HWND param0, uint param1);
    HRESULT Initialize(HINSTANCE param0, uint param1, const(GUID)* param2);
    HRESULT CreateEffect(const(GUID)* param0, DIEFFECT* param1, IDirectInputEffect* param2, IUnknown param3);
    HRESULT EnumEffects(LPDIENUMEFFECTSCALLBACKA param0, void* param1, uint param2);
    HRESULT GetEffectInfo(DIEFFECTINFOA* param0, const(GUID)* param1);
    HRESULT GetForceFeedbackState(uint* param0);
    HRESULT SendForceFeedbackCommand(uint param0);
    HRESULT EnumCreatedEffectObjects(LPDIENUMCREATEDEFFECTOBJECTSCALLBACK param0, void* param1, uint param2);
    HRESULT Escape(DIEFFESCAPE* param0);
    HRESULT Poll();
    HRESULT SendDeviceData(uint param0, DIDEVICEOBJECTDATA* param1, uint* param2, uint param3);
    HRESULT EnumEffectsInFile(const(PSTR) param0, LPDIENUMEFFECTSINFILECALLBACK param1, void* param2, uint param3);
    HRESULT WriteEffectToFile(const(PSTR) param0, uint param1, DIFILEEFFECT* param2, uint param3);
    HRESULT BuildActionMap(DIACTIONFORMATA* param0, const(PSTR) param1, uint param2);
    HRESULT SetActionMap(DIACTIONFORMATA* param0, const(PSTR) param1, uint param2);
    HRESULT GetImageInfo(DIDEVICEIMAGEINFOHEADERA* param0);
}

@GUID("89521361-aa8a-11cf-bfc7-444553540000")
interface IDirectInputW : IUnknown
{
    HRESULT CreateDevice(const(GUID)* param0, IDirectInputDeviceW* param1, IUnknown param2);
    HRESULT EnumDevices(uint param0, LPDIENUMDEVICESCALLBACKW param1, void* param2, uint param3);
    HRESULT GetDeviceStatus(const(GUID)* param0);
    HRESULT RunControlPanel(HWND param0, uint param1);
    HRESULT Initialize(HINSTANCE param0, uint param1);
}

@GUID("89521360-aa8a-11cf-bfc7-444553540000")
interface IDirectInputA : IUnknown
{
    HRESULT CreateDevice(const(GUID)* param0, IDirectInputDeviceA* param1, IUnknown param2);
    HRESULT EnumDevices(uint param0, LPDIENUMDEVICESCALLBACKA param1, void* param2, uint param3);
    HRESULT GetDeviceStatus(const(GUID)* param0);
    HRESULT RunControlPanel(HWND param0, uint param1);
    HRESULT Initialize(HINSTANCE param0, uint param1);
}

@GUID("5944e663-aa8a-11cf-bfc7-444553540000")
interface IDirectInput2W : IDirectInputW
{
    HRESULT FindDevice(const(GUID)* param0, const(PWSTR) param1, GUID* param2);
}

@GUID("5944e662-aa8a-11cf-bfc7-444553540000")
interface IDirectInput2A : IDirectInputA
{
    HRESULT FindDevice(const(GUID)* param0, const(PSTR) param1, GUID* param2);
}

@GUID("9a4cb685-236d-11d3-8e9d-00c04f6844ae")
interface IDirectInput7W : IDirectInput2W
{
    HRESULT CreateDeviceEx(const(GUID)* param0, const(GUID)* param1, void** param2, IUnknown param3);
}

@GUID("9a4cb684-236d-11d3-8e9d-00c04f6844ae")
interface IDirectInput7A : IDirectInput2A
{
    HRESULT CreateDeviceEx(const(GUID)* param0, const(GUID)* param1, void** param2, IUnknown param3);
}

@GUID("bf798031-483a-4da2-aa99-5d64ed369700")
interface IDirectInput8W : IUnknown
{
    HRESULT CreateDevice(const(GUID)* param0, IDirectInputDevice8W* param1, IUnknown param2);
    HRESULT EnumDevices(uint param0, LPDIENUMDEVICESCALLBACKW param1, void* param2, uint param3);
    HRESULT GetDeviceStatus(const(GUID)* param0);
    HRESULT RunControlPanel(HWND param0, uint param1);
    HRESULT Initialize(HINSTANCE param0, uint param1);
    HRESULT FindDevice(const(GUID)* param0, const(PWSTR) param1, GUID* param2);
    HRESULT EnumDevicesBySemantics(const(PWSTR) param0, DIACTIONFORMATW* param1, 
                                   LPDIENUMDEVICESBYSEMANTICSCBW param2, void* param3, uint param4);
    HRESULT ConfigureDevices(LPDICONFIGUREDEVICESCALLBACK param0, DICONFIGUREDEVICESPARAMSW* param1, uint param2, 
                             void* param3);
}

@GUID("bf798030-483a-4da2-aa99-5d64ed369700")
interface IDirectInput8A : IUnknown
{
    HRESULT CreateDevice(const(GUID)* param0, IDirectInputDevice8A* param1, IUnknown param2);
    HRESULT EnumDevices(uint param0, LPDIENUMDEVICESCALLBACKA param1, void* param2, uint param3);
    HRESULT GetDeviceStatus(const(GUID)* param0);
    HRESULT RunControlPanel(HWND param0, uint param1);
    HRESULT Initialize(HINSTANCE param0, uint param1);
    HRESULT FindDevice(const(GUID)* param0, const(PSTR) param1, GUID* param2);
    HRESULT EnumDevicesBySemantics(const(PSTR) param0, DIACTIONFORMATA* param1, 
                                   LPDIENUMDEVICESBYSEMANTICSCBA param2, void* param3, uint param4);
    HRESULT ConfigureDevices(LPDICONFIGUREDEVICESCALLBACK param0, DICONFIGUREDEVICESPARAMSA* param1, uint param2, 
                             void* param3);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dinputd/nn-dinputd-idirectinputeffectdriver
@GUID("02538130-898f-11d0-9ad0-00a0c9a06e35")
interface IDirectInputEffectDriver : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dinputd/nf-dinputd-idirectinputeffectdriver-deviceid
    HRESULT DeviceID(uint param0, uint param1, uint param2, uint param3, void* param4);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dinputd/nf-dinputd-idirectinputeffectdriver-getversions
    HRESULT GetVersions(DIDRIVERVERSIONS* param0);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dinputd/nf-dinputd-idirectinputeffectdriver-escape
    HRESULT Escape(uint param0, uint param1, DIEFFESCAPE* param2);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dinputd/nf-dinputd-idirectinputeffectdriver-setgain
    HRESULT SetGain(uint param0, uint param1);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dinputd/nf-dinputd-idirectinputeffectdriver-sendforcefeedbackcommand
    HRESULT SendForceFeedbackCommand(uint param0, uint param1);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dinputd/nf-dinputd-idirectinputeffectdriver-getforcefeedbackstate
    HRESULT GetForceFeedbackState(uint param0, DIDEVICESTATE* param1);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dinputd/nf-dinputd-idirectinputeffectdriver-downloadeffect
    HRESULT DownloadEffect(uint param0, uint param1, uint* param2, DIEFFECT* param3, uint param4);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dinputd/nf-dinputd-idirectinputeffectdriver-destroyeffect
    HRESULT DestroyEffect(uint param0, uint param1);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dinputd/nf-dinputd-idirectinputeffectdriver-starteffect
    HRESULT StartEffect(uint param0, uint param1, uint param2, uint param3);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dinputd/nf-dinputd-idirectinputeffectdriver-stopeffect
    HRESULT StopEffect(uint param0, uint param1);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dinputd/nf-dinputd-idirectinputeffectdriver-geteffectstatus
    HRESULT GetEffectStatus(uint param0, uint param1, uint* param2);
}

@GUID("1de12ab1-c9f5-11cf-bfc7-444553540000")
interface IDirectInputJoyConfig : IUnknown
{
    HRESULT Acquire();
    HRESULT Unacquire();
    HRESULT SetCooperativeLevel(HWND param0, uint param1);
    HRESULT SendNotify();
    HRESULT EnumTypes(LPDIJOYTYPECALLBACK param0, void* param1);
    HRESULT GetTypeInfo(const(PWSTR) param0, DIJOYTYPEINFO* param1, uint param2);
    HRESULT SetTypeInfo(const(PWSTR) param0, DIJOYTYPEINFO* param1, uint param2);
    HRESULT DeleteType(const(PWSTR) param0);
    HRESULT GetConfig(uint param0, DIJOYCONFIG* param1, uint param2);
    HRESULT SetConfig(uint param0, DIJOYCONFIG* param1, uint param2);
    HRESULT DeleteConfig(uint param0);
    HRESULT GetUserValues(DIJOYUSERVALUES* param0, uint param1);
    HRESULT SetUserValues(DIJOYUSERVALUES* param0, uint param1);
    HRESULT AddNewHardware(HWND param0, const(GUID)* param1);
    HRESULT OpenTypeKey(const(PWSTR) param0, uint param1, HKEY* param2);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dinputd/nf-dinputd-idirectinputjoyconfig-openconfigkey
    HRESULT OpenConfigKey(uint param0, uint param1, HKEY* param2);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dinputd/nn-dinputd-idirectinputjoyconfig8
@GUID("eb0d7dfa-1990-4f27-b4d6-edf2eec4a44c")
interface IDirectInputJoyConfig8 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dinputd/nf-dinputd-idirectinputjoyconfig8-acquire
    HRESULT Acquire();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dinputd/nf-dinputd-idirectinputjoyconfig8-unacquire
    HRESULT Unacquire();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dinputd/nf-dinputd-idirectinputjoyconfig8-setcooperativelevel
    HRESULT SetCooperativeLevel(HWND param0, uint param1);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dinputd/nf-dinputd-idirectinputjoyconfig8-sendnotify
    HRESULT SendNotify();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dinputd/nf-dinputd-idirectinputjoyconfig8-enumtypes
    HRESULT EnumTypes(LPDIJOYTYPECALLBACK param0, void* param1);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dinputd/nf-dinputd-idirectinputjoyconfig8-gettypeinfo
    HRESULT GetTypeInfo(const(PWSTR) param0, DIJOYTYPEINFO* param1, uint param2);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dinputd/nf-dinputd-idirectinputjoyconfig8-settypeinfo
    HRESULT SetTypeInfo(const(PWSTR) param0, DIJOYTYPEINFO* param1, uint param2, PWSTR param3);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dinputd/nf-dinputd-idirectinputjoyconfig8-deletetype
    HRESULT DeleteType(const(PWSTR) param0);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dinputd/nf-dinputd-idirectinputjoyconfig8-getconfig
    HRESULT GetConfig(uint param0, DIJOYCONFIG* param1, uint param2);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dinputd/nf-dinputd-idirectinputjoyconfig8-setconfig
    HRESULT SetConfig(uint param0, DIJOYCONFIG* param1, uint param2);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dinputd/nf-dinputd-idirectinputjoyconfig8-deleteconfig
    HRESULT DeleteConfig(uint param0);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dinputd/nf-dinputd-idirectinputjoyconfig8-getuservalues
    HRESULT GetUserValues(DIJOYUSERVALUES* param0, uint param1);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dinputd/nf-dinputd-idirectinputjoyconfig8-setuservalues
    HRESULT SetUserValues(DIJOYUSERVALUES* param0, uint param1);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dinputd/nf-dinputd-idirectinputjoyconfig8-addnewhardware
    HRESULT AddNewHardware(HWND param0, const(GUID)* param1);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dinputd/nf-dinputd-idirectinputjoyconfig8-opentypekey
    HRESULT OpenTypeKey(const(PWSTR) param0, uint param1, HKEY* param2);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dinputd/nf-dinputd-idirectinputjoyconfig8-openappstatuskey
    HRESULT OpenAppStatusKey(HKEY* param0);
}


// GUIDs


const GUID IID_IDirectInput2A           = GUIDOF!IDirectInput2A;
const GUID IID_IDirectInput2W           = GUIDOF!IDirectInput2W;
const GUID IID_IDirectInput7A           = GUIDOF!IDirectInput7A;
const GUID IID_IDirectInput7W           = GUIDOF!IDirectInput7W;
const GUID IID_IDirectInput8A           = GUIDOF!IDirectInput8A;
const GUID IID_IDirectInput8W           = GUIDOF!IDirectInput8W;
const GUID IID_IDirectInputA            = GUIDOF!IDirectInputA;
const GUID IID_IDirectInputDevice2A     = GUIDOF!IDirectInputDevice2A;
const GUID IID_IDirectInputDevice2W     = GUIDOF!IDirectInputDevice2W;
const GUID IID_IDirectInputDevice7A     = GUIDOF!IDirectInputDevice7A;
const GUID IID_IDirectInputDevice7W     = GUIDOF!IDirectInputDevice7W;
const GUID IID_IDirectInputDevice8A     = GUIDOF!IDirectInputDevice8A;
const GUID IID_IDirectInputDevice8W     = GUIDOF!IDirectInputDevice8W;
const GUID IID_IDirectInputDeviceA      = GUIDOF!IDirectInputDeviceA;
const GUID IID_IDirectInputDeviceW      = GUIDOF!IDirectInputDeviceW;
const GUID IID_IDirectInputEffect       = GUIDOF!IDirectInputEffect;
const GUID IID_IDirectInputEffectDriver = GUIDOF!IDirectInputEffectDriver;
const GUID IID_IDirectInputJoyConfig    = GUIDOF!IDirectInputJoyConfig;
const GUID IID_IDirectInputJoyConfig8   = GUIDOF!IDirectInputJoyConfig8;
const GUID IID_IDirectInputW            = GUIDOF!IDirectInputW;
