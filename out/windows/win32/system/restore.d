// Written in the D programming language.

module windows.win32.system.restore;

public import windows.core;
public import windows.win32.foundation.foundation : BOOL, CHAR, FILETIME, WIN32_ERROR;

extern(Windows) @nogc nothrow:


// Enums


alias RESTOREPOINTINFO_TYPE = uint;
enum : uint
{
    APPLICATION_INSTALL   = 0x00000000U,
    APPLICATION_UNINSTALL = 0x00000001U,
    DEVICE_DRIVER_INSTALL = 0x0000000aU,
    MODIFY_SETTINGS       = 0x0000000cU,
    CANCELLED_OPERATION   = 0x0000000dU,
}

alias RESTOREPOINTINFO_EVENT_TYPE = uint;
enum : uint
{
    BEGIN_NESTED_SYSTEM_CHANGE = 0x00000066U,
    BEGIN_SYSTEM_CHANGE        = 0x00000064U,
    END_NESTED_SYSTEM_CHANGE   = 0x00000067U,
    END_SYSTEM_CHANGE          = 0x00000065U,
}

// Constants


enum uint MIN_EVENT = 0x00000064U;
enum uint BEGIN_NESTED_SYSTEM_CHANGE_NORP = 0x00000068U;
enum uint MAX_EVENT = 0x00000068U;
enum uint MIN_RPT = 0x00000000U;
enum uint DESKTOP_SETTING = 0x00000002U;
enum uint ACCESSIBILITY_SETTING = 0x00000003U;
enum uint OE_SETTING = 0x00000004U;
enum uint APPLICATION_RUN = 0x00000005U;
enum uint RESTORE = 0x00000006U;
enum uint CHECKPOINT = 0x00000007U;

enum : uint
{
    WINDOWS_SHUTDOWN = 0x00000008U,
    WINDOWS_BOOT     = 0x00000009U,
}

enum uint FIRSTRUN = 0x0000000bU;
enum uint BACKUP_RECOVERY = 0x0000000eU;
enum uint BACKUP = 0x0000000fU;
enum uint MANUAL_CHECKPOINT = 0x00000010U;
enum uint WINDOWS_UPDATE = 0x00000011U;
enum uint CRITICAL_UPDATE = 0x00000012U;

enum : uint
{
    MAX_RPT    = 0x00000012U,
    MAX_DESC   = 0x00000040U,
    MAX_DESC_W = 0x00000100U,
}

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/srrestoreptapi/ns-srrestoreptapi-restorepointinfoa
struct RESTOREPOINTINFOA
{
align (1):
    RESTOREPOINTINFO_EVENT_TYPE dwEventType;
    RESTOREPOINTINFO_TYPE dwRestorePtType;
    long     llSequenceNumber;
    CHAR[64] szDescription;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/srrestoreptapi/ns-srrestoreptapi-restorepointinfow
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/srrestoreptapi/ns-srrestoreptapi-statemgrstatus
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


