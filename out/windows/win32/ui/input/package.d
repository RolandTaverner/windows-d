// Written in the D programming language.

module windows.win32.ui.input;

public import windows.core;
public import windows.win32.foundation : BOOL, HANDLE, HWND, LRESULT, WPARAM;

extern(Windows) @nogc nothrow:


// Enums


alias RAW_INPUT_DATA_COMMAND_FLAGS = uint;
enum : uint
{
    RID_HEADER = 0x10000005U,
    RID_INPUT  = 0x10000003U,
}

alias RAW_INPUT_DEVICE_INFO_COMMAND = uint;
enum : uint
{
    RIDI_PREPARSEDDATA = 0x20000005U,
    RIDI_DEVICENAME    = 0x20000007U,
    RIDI_DEVICEINFO    = 0x2000000bU,
}

alias RID_DEVICE_INFO_TYPE = uint;
enum : uint
{
    RIM_TYPEMOUSE    = 0x00000000U,
    RIM_TYPEKEYBOARD = 0x00000001U,
    RIM_TYPEHID      = 0x00000002U,
}

alias RAWINPUTDEVICE_FLAGS = uint;
enum : uint
{
    RIDEV_REMOVE       = 0x00000001U,
    RIDEV_EXCLUDE      = 0x00000010U,
    RIDEV_PAGEONLY     = 0x00000020U,
    RIDEV_NOLEGACY     = 0x00000030U,
    RIDEV_INPUTSINK    = 0x00000100U,
    RIDEV_CAPTUREMOUSE = 0x00000200U,
    RIDEV_NOHOTKEYS    = 0x00000200U,
    RIDEV_APPKEYS      = 0x00000400U,
    RIDEV_EXINPUTSINK  = 0x00001000U,
    RIDEV_DEVNOTIFY    = 0x00002000U,
}

alias MOUSE_STATE = ushort;
enum : ushort
{
    MOUSE_MOVE_RELATIVE      = cast(ushort) 0x0000,
    MOUSE_MOVE_ABSOLUTE      = cast(ushort) 0x0001,
    MOUSE_VIRTUAL_DESKTOP    = cast(ushort) 0x0002,
    MOUSE_ATTRIBUTES_CHANGED = cast(ushort) 0x0004,
    MOUSE_MOVE_NOCOALESCE    = cast(ushort) 0x0008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winuser/ne-winuser-input_message_device_type
alias INPUT_MESSAGE_DEVICE_TYPE = int;
enum : int
{
    IMDT_UNAVAILABLE = 0x00000000,
    IMDT_KEYBOARD    = 0x00000001,
    IMDT_MOUSE       = 0x00000002,
    IMDT_TOUCH       = 0x00000004,
    IMDT_PEN         = 0x00000008,
    IMDT_TOUCHPAD    = 0x00000010,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winuser/ne-winuser-input_message_origin_id
alias INPUT_MESSAGE_ORIGIN_ID = int;
enum : int
{
    IMO_UNAVAILABLE = 0x00000000,
    IMO_HARDWARE    = 0x00000001,
    IMO_INJECTED    = 0x00000002,
    IMO_SYSTEM      = 0x00000004,
}

// Structs


//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HRAWINPUT
{
    void* Value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-rawinputheader
struct RAWINPUTHEADER
{
    uint   dwType;
    uint   dwSize;
    HANDLE hDevice;
    WPARAM wParam;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-rawmouse
struct RAWMOUSE
{
    MOUSE_STATE usFlags;
    union
    {
        uint ulButtons;
        struct
        {
            ushort usButtonFlags;
            ushort usButtonData;
        }
    }
    uint        ulRawButtons;
    int         lLastX;
    int         lLastY;
    uint        ulExtraInformation;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-rawkeyboard
struct RAWKEYBOARD
{
    ushort MakeCode;
    ushort Flags;
    ushort Reserved;
    ushort VKey;
    uint   Message;
    uint   ExtraInformation;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-rawhid
struct RAWHID
{
    uint     dwSizeHid;
    uint     dwCount;
    ubyte[1] bRawData; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-rawinput
struct RAWINPUT
{
    RAWINPUTHEADER header;
    union data
    {
        RAWMOUSE    mouse;
        RAWKEYBOARD keyboard;
        RAWHID      hid;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-rid_device_info_mouse
struct RID_DEVICE_INFO_MOUSE
{
    uint dwId;
    uint dwNumberOfButtons;
    uint dwSampleRate;
    BOOL fHasHorizontalWheel;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-rid_device_info_keyboard
struct RID_DEVICE_INFO_KEYBOARD
{
    uint dwType;
    uint dwSubType;
    uint dwKeyboardMode;
    uint dwNumberOfFunctionKeys;
    uint dwNumberOfIndicators;
    uint dwNumberOfKeysTotal;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-rid_device_info_hid
struct RID_DEVICE_INFO_HID
{
    uint   dwVendorId;
    uint   dwProductId;
    uint   dwVersionNumber;
    ushort usUsagePage;
    ushort usUsage;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-rid_device_info
struct RID_DEVICE_INFO
{
    uint                 cbSize;
    RID_DEVICE_INFO_TYPE dwType;
    union
    {
        RID_DEVICE_INFO_MOUSE mouse;
        RID_DEVICE_INFO_KEYBOARD keyboard;
        RID_DEVICE_INFO_HID hid;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-rawinputdevice
struct RAWINPUTDEVICE
{
    ushort               usUsagePage;
    ushort               usUsage;
    RAWINPUTDEVICE_FLAGS dwFlags;
    HWND                 hwndTarget;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-rawinputdevicelist
struct RAWINPUTDEVICELIST
{
    HANDLE               hDevice;
    RID_DEVICE_INFO_TYPE dwType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-input_message_source
struct INPUT_MESSAGE_SOURCE
{
    INPUT_MESSAGE_DEVICE_TYPE deviceType;
    INPUT_MESSAGE_ORIGIN_ID originId;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("USER32.dll")
uint GetRawInputData(HRAWINPUT hRawInput, RAW_INPUT_DATA_COMMAND_FLAGS uiCommand, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pData, 
                     uint* pcbSize, uint cbSizeHeader);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("USER32.dll")
uint GetRawInputDeviceInfoA(HANDLE hDevice, RAW_INPUT_DEVICE_INFO_COMMAND uiCommand, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pData, 
                            uint* pcbSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("USER32.dll")
uint GetRawInputDeviceInfoW(HANDLE hDevice, RAW_INPUT_DEVICE_INFO_COMMAND uiCommand, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pData, 
                            uint* pcbSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("USER32.dll")
uint GetRawInputBuffer(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/RAWINPUT* pData, 
                       uint* pcbSize, uint cbSizeHeader);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("USER32.dll")
BOOL RegisterRawInputDevices(RAWINPUTDEVICE* pRawInputDevices, uint uiNumDevices, uint cbSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("USER32.dll")
uint GetRegisteredRawInputDevices(RAWINPUTDEVICE* pRawInputDevices, uint* puiNumDevices, uint cbSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("USER32.dll")
uint GetRawInputDeviceList(RAWINPUTDEVICELIST* pRawInputDeviceList, uint* puiNumDevices, uint cbSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("USER32.dll")
LRESULT DefRawInputProc(RAWINPUT** paRawInput, int nInput, uint cbSizeHeader);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("USER32.dll")
BOOL GetCurrentInputMessageSource(INPUT_MESSAGE_SOURCE* inputMessageSource);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("USER32.dll")
BOOL GetCIMSSM(INPUT_MESSAGE_SOURCE* inputMessageSource);


