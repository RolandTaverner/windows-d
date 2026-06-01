// Written in the D programming language.

module windows.win32.system.stationsanddesktops;

public import windows.core;
public import windows.win32.foundation.foundation : BOOL, HANDLE, HWND, LPARAM, LUID, PSTR,
                                                    PWSTR, WPARAM;
public import windows.win32.graphics.gdi : DEVMODEA, DEVMODEW;
public import windows.win32.security.security : SECURITY_ATTRIBUTES;
public import windows.win32.ui.windowsandmessaging : WNDENUMPROC;

extern(Windows) @nogc nothrow:


// Enums


alias BROADCAST_SYSTEM_MESSAGE_FLAGS = uint;
enum : uint
{
    BSF_ALLOWSFW           = 0x00000080U,
    BSF_FLUSHDISK          = 0x00000004U,
    BSF_FORCEIFHUNG        = 0x00000020U,
    BSF_IGNORECURRENTTASK  = 0x00000002U,
    BSF_NOHANG             = 0x00000008U,
    BSF_NOTIMEOUTIFNOTHUNG = 0x00000040U,
    BSF_POSTMESSAGE        = 0x00000010U,
    BSF_QUERY              = 0x00000001U,
    BSF_SENDNOTIFYMESSAGE  = 0x00000100U,
    BSF_LUID               = 0x00000400U,
    BSF_RETURNHDESK        = 0x00000200U,
}

alias BROADCAST_SYSTEM_MESSAGE_INFO = uint;
enum : uint
{
    BSM_ALLCOMPONENTS = 0x00000000U,
    BSM_ALLDESKTOPS   = 0x00000010U,
    BSM_APPLICATIONS  = 0x00000008U,
}

alias USER_OBJECT_INFORMATION_INDEX = int;
enum : int
{
    UOI_FLAGS    = 0x00000001,
    UOI_HEAPSIZE = 0x00000005,
    UOI_IO       = 0x00000006,
    UOI_NAME     = 0x00000002,
    UOI_TYPE     = 0x00000003,
    UOI_USER_SID = 0x00000004,
}

alias DESKTOP_CONTROL_FLAGS = uint;
enum : uint
{
    DF_ALLOWOTHERACCOUNTHOOK = 0x00000001U,
}

alias DESKTOP_ACCESS_FLAGS = uint;
enum : uint
{
    DESKTOP_DELETE          = 0x00010000U,
    DESKTOP_READ_CONTROL    = 0x00020000U,
    DESKTOP_WRITE_DAC       = 0x00040000U,
    DESKTOP_WRITE_OWNER     = 0x00080000U,
    DESKTOP_SYNCHRONIZE     = 0x00100000U,
    DESKTOP_READOBJECTS     = 0x00000001U,
    DESKTOP_CREATEWINDOW    = 0x00000002U,
    DESKTOP_CREATEMENU      = 0x00000004U,
    DESKTOP_HOOKCONTROL     = 0x00000008U,
    DESKTOP_JOURNALRECORD   = 0x00000010U,
    DESKTOP_JOURNALPLAYBACK = 0x00000020U,
    DESKTOP_ENUMERATE       = 0x00000040U,
    DESKTOP_WRITEOBJECTS    = 0x00000080U,
    DESKTOP_SWITCHDESKTOP   = 0x00000100U,
}

// Callbacks

alias WINSTAENUMPROCA = BOOL function(PSTR param0, LPARAM param1);
alias WINSTAENUMPROCW = BOOL function(PWSTR param0, LPARAM param1);
alias DESKTOPENUMPROCA = BOOL function(PSTR param0, LPARAM param1);
alias DESKTOPENUMPROCW = BOOL function(PWSTR param0, LPARAM param1);

// Structs


@RAIIFree!CloseWindowStation
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HWINSTA
{
    void* Value;
}

@RAIIFree!CloseDesktop
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HDESK
{
    void* Value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-userobjectflags
struct USEROBJECTFLAGS
{
    BOOL fInherit;
    BOOL fReserved;
    uint dwFlags;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-bsminfo
struct BSMINFO
{
    uint  cbSize;
    HDESK hdesk;
    HWND  hwnd;
    LUID  luid;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
HDESK CreateDesktopA(const(PSTR) lpszDesktop, 
                     /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/const(PSTR) lpszDevice, 
                     /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/DEVMODEA* pDevmode, 
                     DESKTOP_CONTROL_FLAGS dwFlags, uint dwDesiredAccess, SECURITY_ATTRIBUTES* lpsa);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
HDESK CreateDesktopW(const(PWSTR) lpszDesktop, 
                     /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/const(PWSTR) lpszDevice, 
                     /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/DEVMODEW* pDevmode, 
                     DESKTOP_CONTROL_FLAGS dwFlags, uint dwDesiredAccess, SECURITY_ATTRIBUTES* lpsa);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("USER32.dll")
HDESK CreateDesktopExA(const(PSTR) lpszDesktop, 
                       /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/const(PSTR) lpszDevice, 
                       /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/DEVMODEA* pDevmode, 
                       DESKTOP_CONTROL_FLAGS dwFlags, uint dwDesiredAccess, SECURITY_ATTRIBUTES* lpsa, 
                       uint ulHeapSize, /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pvoid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("USER32.dll")
HDESK CreateDesktopExW(const(PWSTR) lpszDesktop, 
                       /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/const(PWSTR) lpszDevice, 
                       /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/DEVMODEW* pDevmode, 
                       DESKTOP_CONTROL_FLAGS dwFlags, uint dwDesiredAccess, SECURITY_ATTRIBUTES* lpsa, 
                       uint ulHeapSize, /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pvoid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
HDESK OpenDesktopA(const(PSTR) lpszDesktop, DESKTOP_CONTROL_FLAGS dwFlags, BOOL fInherit, uint dwDesiredAccess);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
HDESK OpenDesktopW(const(PWSTR) lpszDesktop, DESKTOP_CONTROL_FLAGS dwFlags, BOOL fInherit, uint dwDesiredAccess);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
HDESK OpenInputDesktop(DESKTOP_CONTROL_FLAGS dwFlags, BOOL fInherit, DESKTOP_ACCESS_FLAGS dwDesiredAccess);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
BOOL EnumDesktopsA(HWINSTA hwinsta, DESKTOPENUMPROCA lpEnumFunc, LPARAM lParam);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
BOOL EnumDesktopsW(HWINSTA hwinsta, DESKTOPENUMPROCW lpEnumFunc, LPARAM lParam);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
BOOL EnumDesktopWindows(HDESK hDesktop, WNDENUMPROC lpfn, LPARAM lParam);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
BOOL SwitchDesktop(HDESK hDesktop);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
BOOL SetThreadDesktop(HDESK hDesktop);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
BOOL CloseDesktop(HDESK hDesktop);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
HDESK GetThreadDesktop(uint dwThreadId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
HWINSTA CreateWindowStationA(const(PSTR) lpwinsta, uint dwFlags, uint dwDesiredAccess, SECURITY_ATTRIBUTES* lpsa);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
HWINSTA CreateWindowStationW(const(PWSTR) lpwinsta, uint dwFlags, uint dwDesiredAccess, SECURITY_ATTRIBUTES* lpsa);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
HWINSTA OpenWindowStationA(const(PSTR) lpszWinSta, BOOL fInherit, uint dwDesiredAccess);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
HWINSTA OpenWindowStationW(const(PWSTR) lpszWinSta, BOOL fInherit, uint dwDesiredAccess);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
BOOL EnumWindowStationsA(WINSTAENUMPROCA lpEnumFunc, LPARAM lParam);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
BOOL EnumWindowStationsW(WINSTAENUMPROCW lpEnumFunc, LPARAM lParam);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
BOOL CloseWindowStation(HWINSTA hWinSta);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
BOOL SetProcessWindowStation(HWINSTA hWinSta);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
HWINSTA GetProcessWindowStation();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
BOOL GetUserObjectInformationA(HANDLE hObj, USER_OBJECT_INFORMATION_INDEX nIndex, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pvInfo, 
                               uint nLength, uint* lpnLengthNeeded);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
BOOL GetUserObjectInformationW(HANDLE hObj, USER_OBJECT_INFORMATION_INDEX nIndex, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pvInfo, 
                               uint nLength, uint* lpnLengthNeeded);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
BOOL SetUserObjectInformationA(HANDLE hObj, int nIndex, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pvInfo, 
                               uint nLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
BOOL SetUserObjectInformationW(HANDLE hObj, int nIndex, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pvInfo, 
                               uint nLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("USER32.dll")
int BroadcastSystemMessageExA(BROADCAST_SYSTEM_MESSAGE_FLAGS flags, BROADCAST_SYSTEM_MESSAGE_INFO* lpInfo, 
                              uint Msg, WPARAM wParam, LPARAM lParam, BSMINFO* pbsmInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("USER32.dll")
int BroadcastSystemMessageExW(BROADCAST_SYSTEM_MESSAGE_FLAGS flags, BROADCAST_SYSTEM_MESSAGE_INFO* lpInfo, 
                              uint Msg, WPARAM wParam, LPARAM lParam, BSMINFO* pbsmInfo);

@DllImport("USER32.dll")
int BroadcastSystemMessageA(uint flags, uint* lpInfo, uint Msg, WPARAM wParam, LPARAM lParam);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
int BroadcastSystemMessageW(BROADCAST_SYSTEM_MESSAGE_FLAGS flags, BROADCAST_SYSTEM_MESSAGE_INFO* lpInfo, uint Msg, 
                            WPARAM wParam, LPARAM lParam);


