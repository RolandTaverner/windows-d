// Written in the D programming language.

module windows.win32.system.restore;

public import windows.core;
public import windows.win32.foundation : BOOL, CHAR, FILETIME, WIN32_ERROR;

extern(Windows) @nogc nothrow:


// Enums

alias RESTOREPOINTINFO_TYPE = uint;
enum : uint
{
    APPLICATION_INSTALL   = 0x00000000,
    APPLICATION_UNINSTALL = 0x00000001,
    DEVICE_DRIVER_INSTALL = 0x0000000a,
    MODIFY_SETTINGS       = 0x0000000c,
    CANCELLED_OPERATION   = 0x0000000d,
}
alias RESTOREPOINTINFO_EVENT_TYPE = uint;
enum : uint
{
    BEGIN_NESTED_SYSTEM_CHANGE = 0x00000066,
    BEGIN_SYSTEM_CHANGE        = 0x00000064,
    END_NESTED_SYSTEM_CHANGE   = 0x00000067,
    END_SYSTEM_CHANGE          = 0x00000065,
}

// Constants


enum uint MIN_EVENT = 0x00000064;
enum uint BEGIN_NESTED_SYSTEM_CHANGE_NORP = 0x00000068;
enum uint MAX_EVENT = 0x00000068;
enum uint MIN_RPT = 0x00000000;
enum uint DESKTOP_SETTING = 0x00000002;
enum uint ACCESSIBILITY_SETTING = 0x00000003;
enum uint OE_SETTING = 0x00000004;
enum uint APPLICATION_RUN = 0x00000005;
enum uint RESTORE = 0x00000006;
enum uint CHECKPOINT = 0x00000007;

enum : uint
{
    WINDOWS_SHUTDOWN = 0x00000008,
    WINDOWS_BOOT     = 0x00000009,
}

enum uint FIRSTRUN = 0x0000000b;
enum uint BACKUP_RECOVERY = 0x0000000e;
enum uint BACKUP = 0x0000000f;
enum uint MANUAL_CHECKPOINT = 0x00000010;
enum uint WINDOWS_UPDATE = 0x00000011;
enum uint CRITICAL_UPDATE = 0x00000012;

enum : uint
{
    MAX_RPT    = 0x00000012,
    MAX_DESC   = 0x00000040,
    MAX_DESC_W = 0x00000100,
}

// Structs


//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/srrestoreptapi/ns-srrestoreptapi-restorepointinfoa))], [])
struct RESTOREPOINTINFOA
{
align (1):
    RESTOREPOINTINFO_EVENT_TYPE dwEventType;
    RESTOREPOINTINFO_TYPE dwRestorePtType;
    long     llSequenceNumber;
    CHAR[64] szDescription;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/srrestoreptapi/ns-srrestoreptapi-restorepointinfow))], [])
struct RESTOREPOINTINFOW
{
align (1):
    RESTOREPOINTINFO_EVENT_TYPE dwEventType;
    RESTOREPOINTINFO_TYPE dwRestorePtType;
    long       llSequenceNumber;
    wchar[256] szDescription;
}

struct RESTOREPOINTINFOEX
{
align (1):
    FILETIME   ftCreation;
    uint       dwEventType;
    uint       dwRestorePtType;
    uint       dwRPNum;
    wchar[256] szDescription;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/srrestoreptapi/ns-srrestoreptapi-statemgrstatus))], [])
struct STATEMGRSTATUS
{
align (1):
    WIN32_ERROR nStatus;
    long        llSequenceNumber;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("sfc.dll")
BOOL SRSetRestorePointA(RESTOREPOINTINFOA* pRestorePtSpec, STATEMGRSTATUS* pSMgrStatus);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("sfc.dll")
BOOL SRSetRestorePointW(RESTOREPOINTINFOW* pRestorePtSpec, STATEMGRSTATUS* pSMgrStatus);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SrClient.dll")
uint SRRemoveRestorePoint(uint dwRPNum);


