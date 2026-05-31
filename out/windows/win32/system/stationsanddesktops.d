// Written in the D programming language.

module windows.win32.system.stationsanddesktops;

public import windows.core;
public import windows.win32.foundation : BOOL, HANDLE, HWND, LPARAM, LUID, PSTR,
                                         PWSTR, WPARAM;
public import windows.win32.graphics.gdi : DEVMODEA, DEVMODEW;
public import windows.win32.security : SECURITY_ATTRIBUTES;
public import windows.win32.ui.windowsandmessaging : WNDENUMPROC;

extern(Windows) @nogc nothrow:


// Enums

alias BROADCAST_SYSTEM_MESSAGE_FLAGS = uint;
enum : uint
{
    BSF_ALLOWSFW           = 0x00000080,
    BSF_FLUSHDISK          = 0x00000004,
    BSF_FORCEIFHUNG        = 0x00000020,
    BSF_IGNORECURRENTTASK  = 0x00000002,
    BSF_NOHANG             = 0x00000008,
    BSF_NOTIMEOUTIFNOTHUNG = 0x00000040,
    BSF_POSTMESSAGE        = 0x00000010,
    BSF_QUERY              = 0x00000001,
    BSF_SENDNOTIFYMESSAGE  = 0x00000100,
    BSF_LUID               = 0x00000400,
    BSF_RETURNHDESK        = 0x00000200,
}
alias BROADCAST_SYSTEM_MESSAGE_INFO = uint;
enum : uint
{
    BSM_ALLCOMPONENTS = 0x00000000,
    BSM_ALLDESKTOPS   = 0x00000010,
    BSM_APPLICATIONS  = 0x00000008,
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
    DF_ALLOWOTHERACCOUNTHOOK = 0x00000001,
}
alias DESKTOP_ACCESS_FLAGS = uint;
enum : uint
{
    DESKTOP_DELETE          = 0x00010000,
    DESKTOP_READ_CONTROL    = 0x00020000,
    DESKTOP_WRITE_DAC       = 0x00040000,
    DESKTOP_WRITE_OWNER     = 0x00080000,
    DESKTOP_SYNCHRONIZE     = 0x00100000,
    DESKTOP_READOBJECTS     = 0x00000001,
    DESKTOP_CREATEWINDOW    = 0x00000002,
    DESKTOP_CREATEMENU      = 0x00000004,
    DESKTOP_HOOKCONTROL     = 0x00000008,
    DESKTOP_JOURNALRECORD   = 0x00000010,
    DESKTOP_JOURNALPLAYBACK = 0x00000020,
    DESKTOP_ENUMERATE       = 0x00000040,
    DESKTOP_WRITEOBJECTS    = 0x00000080,
    DESKTOP_SWITCHDESKTOP   = 0x00000100,
}

// Callbacks

//DELEGATE ATTR: AnsiAttribute : CustomAttributeSig([], [])
alias WINSTAENUMPROCA = BOOL function(PSTR param0, LPARAM param1);
//DELEGATE ATTR: UnicodeAttribute : CustomAttributeSig([], [])
alias WINSTAENUMPROCW = BOOL function(PWSTR param0, LPARAM param1);
//DELEGATE ATTR: AnsiAttribute : CustomAttributeSig([], [])
alias DESKTOPENUMPROCA = BOOL function(PSTR param0, LPARAM param1);
//DELEGATE ATTR: UnicodeAttribute : CustomAttributeSig([], [])
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

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-userobjectflags))], [])
struct USEROBJECTFLAGS
{
    BOOL fInherit;
    BOOL fReserved;
    uint dwFlags;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-bsminfo))], [])
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

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("USER32.dll")
int BroadcastSystemMessageA(uint flags, uint* lpInfo, uint Msg, WPARAM wParam, LPARAM lParam);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
int BroadcastSystemMessageW(BROADCAST_SYSTEM_MESSAGE_FLAGS flags, BROADCAST_SYSTEM_MESSAGE_INFO* lpInfo, uint Msg, 
                            WPARAM wParam, LPARAM lParam);


