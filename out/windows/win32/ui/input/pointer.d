// Written in the D programming language.

module windows.win32.ui.input.pointer;

public import windows.core;
public import windows.win32.foundation : BOOL, HANDLE, HWND, POINT, RECT;
public import windows.win32.graphics.gdi : HMONITOR;
public import windows.win32.ui.windowsandmessaging : POINTER_INPUT_TYPE;

extern(Windows) @nogc nothrow:


// Enums

alias POINTER_FLAGS = uint;
enum : uint
{
    POINTER_FLAG_NONE           = 0x00000000,
    POINTER_FLAG_NEW            = 0x00000001,
    POINTER_FLAG_INRANGE        = 0x00000002,
    POINTER_FLAG_INCONTACT      = 0x00000004,
    POINTER_FLAG_FIRSTBUTTON    = 0x00000010,
    POINTER_FLAG_SECONDBUTTON   = 0x00000020,
    POINTER_FLAG_THIRDBUTTON    = 0x00000040,
    POINTER_FLAG_FOURTHBUTTON   = 0x00000080,
    POINTER_FLAG_FIFTHBUTTON    = 0x00000100,
    POINTER_FLAG_PRIMARY        = 0x00002000,
    POINTER_FLAG_CONFIDENCE     = 0x00004000,
    POINTER_FLAG_CANCELED       = 0x00008000,
    POINTER_FLAG_DOWN           = 0x00010000,
    POINTER_FLAG_UPDATE         = 0x00020000,
    POINTER_FLAG_UP             = 0x00040000,
    POINTER_FLAG_WHEEL          = 0x00080000,
    POINTER_FLAG_HWHEEL         = 0x00100000,
    POINTER_FLAG_CAPTURECHANGED = 0x00200000,
    POINTER_FLAG_HASTRANSFORM   = 0x00400000,
}
alias TOUCH_FEEDBACK_MODE = uint;
enum : uint
{
    TOUCH_FEEDBACK_DEFAULT  = 0x00000001,
    TOUCH_FEEDBACK_INDIRECT = 0x00000002,
    TOUCH_FEEDBACK_NONE     = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/ne-winuser-pointer_button_change_type))], [])
alias POINTER_BUTTON_CHANGE_TYPE = int;
enum : int
{
    POINTER_CHANGE_NONE              = 0x00000000,
    POINTER_CHANGE_FIRSTBUTTON_DOWN  = 0x00000001,
    POINTER_CHANGE_FIRSTBUTTON_UP    = 0x00000002,
    POINTER_CHANGE_SECONDBUTTON_DOWN = 0x00000003,
    POINTER_CHANGE_SECONDBUTTON_UP   = 0x00000004,
    POINTER_CHANGE_THIRDBUTTON_DOWN  = 0x00000005,
    POINTER_CHANGE_THIRDBUTTON_UP    = 0x00000006,
    POINTER_CHANGE_FOURTHBUTTON_DOWN = 0x00000007,
    POINTER_CHANGE_FOURTHBUTTON_UP   = 0x00000008,
    POINTER_CHANGE_FIFTHBUTTON_DOWN  = 0x00000009,
    POINTER_CHANGE_FIFTHBUTTON_UP    = 0x0000000a,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/ne-winuser-pointer_feedback_mode))], [])
alias POINTER_FEEDBACK_MODE = int;
enum : int
{
    POINTER_FEEDBACK_DEFAULT  = 0x00000001,
    POINTER_FEEDBACK_INDIRECT = 0x00000002,
    POINTER_FEEDBACK_NONE     = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/ne-winuser-pointer_device_type))], [])
alias POINTER_DEVICE_TYPE = int;
enum : int
{
    POINTER_DEVICE_TYPE_INTEGRATED_PEN = 0x00000001,
    POINTER_DEVICE_TYPE_EXTERNAL_PEN   = 0x00000002,
    POINTER_DEVICE_TYPE_TOUCH          = 0x00000003,
    POINTER_DEVICE_TYPE_TOUCH_PAD      = 0x00000004,
    POINTER_DEVICE_TYPE_MAX            = 0xffffffff,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/ne-winuser-pointer_device_cursor_type))], [])
alias POINTER_DEVICE_CURSOR_TYPE = int;
enum : int
{
    POINTER_DEVICE_CURSOR_TYPE_UNKNOWN = 0x00000000,
    POINTER_DEVICE_CURSOR_TYPE_TIP     = 0x00000001,
    POINTER_DEVICE_CURSOR_TYPE_ERASER  = 0x00000002,
    POINTER_DEVICE_CURSOR_TYPE_MAX     = 0xffffffff,
}

// Structs


@RAIIFree!DestroySyntheticPointerDevice
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HSYNTHETICPOINTERDEVICE
{
    void* Value;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-pointer_info))], [])
struct POINTER_INFO
{
    POINTER_INPUT_TYPE pointerType;
    uint               pointerId;
    uint               frameId;
    POINTER_FLAGS      pointerFlags;
    HANDLE             sourceDevice;
    HWND               hwndTarget;
    POINT              ptPixelLocation;
    POINT              ptHimetricLocation;
    POINT              ptPixelLocationRaw;
    POINT              ptHimetricLocationRaw;
    uint               dwTime;
    uint               historyCount;
    int                InputData;
    uint               dwKeyStates;
    ulong              PerformanceCount;
    POINTER_BUTTON_CHANGE_TYPE ButtonChangeType;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-pointer_touch_info))], [])
struct POINTER_TOUCH_INFO
{
    POINTER_INFO pointerInfo;
    uint         touchFlags;
    uint         touchMask;
    RECT         rcContact;
    RECT         rcContactRaw;
    uint         orientation;
    uint         pressure;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-pointer_pen_info))], [])
struct POINTER_PEN_INFO
{
    POINTER_INFO pointerInfo;
    uint         penFlags;
    uint         penMask;
    uint         pressure;
    uint         rotation;
    int          tiltX;
    int          tiltY;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-pointer_type_info))], [])
struct POINTER_TYPE_INFO
{
    POINTER_INPUT_TYPE  type;
    _Anonymous_e__Union Anonymous;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-input_injection_value))], [])
struct INPUT_INJECTION_VALUE
{
    ushort page;
    ushort usage;
    int    value;
    ushort index;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-input_transform))], [])
struct INPUT_TRANSFORM
{
    _Anonymous_e__Union Anonymous;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-pointer_device_info))], [])
struct POINTER_DEVICE_INFO
{
    uint                displayOrientation;
    HANDLE              device;
    POINTER_DEVICE_TYPE pointerDeviceType;
    HMONITOR            monitor;
    uint                startingCursorId;
    ushort              maxActiveContacts;
    wchar[520]          productString;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-pointer_device_property))], [])
struct POINTER_DEVICE_PROPERTY
{
    int    logicalMin;
    int    logicalMax;
    int    physicalMin;
    int    physicalMax;
    uint   unit;
    uint   unitExponent;
    ushort usagePageId;
    ushort usageId;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-pointer_device_cursor_info))], [])
struct POINTER_DEVICE_CURSOR_INFO
{
    uint cursorId;
    POINTER_DEVICE_CURSOR_TYPE cursor;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("USER32.dll")
uint GetUnpredictedMessagePos();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("USER32.dll")
BOOL InitializeTouchInjection(uint maxCount, TOUCH_FEEDBACK_MODE dwMode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("USER32.dll")
BOOL InjectTouchInput(uint count, const(POINTER_TOUCH_INFO)* contacts);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("USER32.dll")
BOOL GetPointerType(uint pointerId, POINTER_INPUT_TYPE* pointerType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("USER32.dll")
BOOL GetPointerCursorId(uint pointerId, uint* cursorId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("USER32.dll")
BOOL GetPointerInfo(uint pointerId, POINTER_INFO* pointerInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("USER32.dll")
BOOL GetPointerInfoHistory(uint pointerId, uint* entriesCount, POINTER_INFO* pointerInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("USER32.dll")
BOOL GetPointerFrameInfo(uint pointerId, uint* pointerCount, POINTER_INFO* pointerInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("USER32.dll")
BOOL GetPointerFrameInfoHistory(uint pointerId, uint* entriesCount, uint* pointerCount, POINTER_INFO* pointerInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("USER32.dll")
BOOL GetPointerTouchInfo(uint pointerId, POINTER_TOUCH_INFO* touchInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("USER32.dll")
BOOL GetPointerTouchInfoHistory(uint pointerId, uint* entriesCount, POINTER_TOUCH_INFO* touchInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("USER32.dll")
BOOL GetPointerFrameTouchInfo(uint pointerId, uint* pointerCount, POINTER_TOUCH_INFO* touchInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("USER32.dll")
BOOL GetPointerFrameTouchInfoHistory(uint pointerId, uint* entriesCount, uint* pointerCount, 
                                     POINTER_TOUCH_INFO* touchInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("USER32.dll")
BOOL GetPointerPenInfo(uint pointerId, POINTER_PEN_INFO* penInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("USER32.dll")
BOOL GetPointerPenInfoHistory(uint pointerId, uint* entriesCount, POINTER_PEN_INFO* penInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("USER32.dll")
BOOL GetPointerFramePenInfo(uint pointerId, uint* pointerCount, POINTER_PEN_INFO* penInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("USER32.dll")
BOOL GetPointerFramePenInfoHistory(uint pointerId, uint* entriesCount, uint* pointerCount, 
                                   POINTER_PEN_INFO* penInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("USER32.dll")
BOOL SkipPointerFrameMessages(uint pointerId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17763))], [])
@DllImport("USER32.dll")
BOOL InjectSyntheticPointerInput(HSYNTHETICPOINTERDEVICE device, const(POINTER_TYPE_INFO)* pointerInfo, uint count);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17763))], [])
@DllImport("USER32.dll")
void DestroySyntheticPointerDevice(HSYNTHETICPOINTERDEVICE device);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("USER32.dll")
BOOL EnableMouseInPointer(BOOL fEnable);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("USER32.dll")
BOOL IsMouseInPointerEnabled();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("USER32.dll")
BOOL GetPointerInputTransform(uint pointerId, uint historyCount, INPUT_TRANSFORM* inputTransform);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("USER32.dll")
BOOL GetPointerDevices(uint* deviceCount, POINTER_DEVICE_INFO* pointerDevices);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("USER32.dll")
BOOL GetPointerDevice(HANDLE device, POINTER_DEVICE_INFO* pointerDevice);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("USER32.dll")
BOOL GetPointerDeviceProperties(HANDLE device, uint* propertyCount, POINTER_DEVICE_PROPERTY* pointerProperties);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("USER32.dll")
BOOL GetPointerDeviceRects(HANDLE device, RECT* pointerDeviceRect, RECT* displayRect);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("USER32.dll")
BOOL GetPointerDeviceCursors(HANDLE device, uint* cursorCount, POINTER_DEVICE_CURSOR_INFO* deviceCursors);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("USER32.dll")
BOOL GetRawPointerDeviceData(uint pointerId, uint historyCount, uint propertiesCount, 
                             POINTER_DEVICE_PROPERTY* pProperties, int* pValues);


