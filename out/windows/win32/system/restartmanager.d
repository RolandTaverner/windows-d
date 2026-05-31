// Written in the D programming language.

module windows.win32.system.restartmanager;

public import windows.core;
public import windows.win32.foundation : BOOL, FILETIME, PWSTR, WIN32_ERROR;

extern(Windows) @nogc nothrow:


// Enums

//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/restartmanager/ne-restartmanager-rm_app_type))], [])
alias RM_APP_TYPE = int;
enum : int
{
    RmUnknownApp  = 0x00000000,
    RmMainWindow  = 0x00000001,
    RmOtherWindow = 0x00000002,
    RmService     = 0x00000003,
    RmExplorer    = 0x00000004,
    RmConsole     = 0x00000005,
    RmCritical    = 0x000003e8,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/restartmanager/ne-restartmanager-rm_shutdown_type))], [])
alias RM_SHUTDOWN_TYPE = int;
enum : int
{
    RmForceShutdown          = 0x00000001,
    RmShutdownOnlyRegistered = 0x00000010,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/restartmanager/ne-restartmanager-rm_app_status))], [])
alias RM_APP_STATUS = int;
enum : int
{
    RmStatusUnknown        = 0x00000000,
    RmStatusRunning        = 0x00000001,
    RmStatusStopped        = 0x00000002,
    RmStatusStoppedOther   = 0x00000004,
    RmStatusRestarted      = 0x00000008,
    RmStatusErrorOnStop    = 0x00000010,
    RmStatusErrorOnRestart = 0x00000020,
    RmStatusShutdownMasked = 0x00000040,
    RmStatusRestartMasked  = 0x00000080,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/restartmanager/ne-restartmanager-rm_reboot_reason))], [])
alias RM_REBOOT_REASON = int;
enum : int
{
    RmRebootReasonNone             = 0x00000000,
    RmRebootReasonPermissionDenied = 0x00000001,
    RmRebootReasonSessionMismatch  = 0x00000002,
    RmRebootReasonCriticalProcess  = 0x00000004,
    RmRebootReasonCriticalService  = 0x00000008,
    RmRebootReasonDetectedSelf     = 0x00000010,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/restartmanager/ne-restartmanager-rm_filter_trigger))], [])
alias RM_FILTER_TRIGGER = int;
enum : int
{
    RmFilterTriggerInvalid = 0x00000000,
    RmFilterTriggerFile    = 0x00000001,
    RmFilterTriggerProcess = 0x00000002,
    RmFilterTriggerService = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/restartmanager/ne-restartmanager-rm_filter_action))], [])
alias RM_FILTER_ACTION = int;
enum : int
{
    RmInvalidFilterAction = 0x00000000,
    RmNoRestart           = 0x00000001,
    RmNoShutdown          = 0x00000002,
}

// Constants


enum uint CCH_RM_SESSION_KEY = 0x00000020;

enum : uint
{
    CCH_RM_MAX_APP_NAME = 0x000000ff,
    CCH_RM_MAX_SVC_NAME = 0x0000003f,
}

enum : int
{
    RM_INVALID_TS_SESSION = 0xffffffff,
    RM_INVALID_PROCESS    = 0xffffffff,
}

// Callbacks

alias RM_WRITE_STATUS_CALLBACK = void function(uint nPercentComplete);

// Structs


//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/restartmanager/ns-restartmanager-rm_unique_process))], [])
struct RM_UNIQUE_PROCESS
{
    uint     dwProcessId;
    FILETIME ProcessStartTime;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/restartmanager/ns-restartmanager-rm_process_info))], [])
struct RM_PROCESS_INFO
{
    RM_UNIQUE_PROCESS Process;
    wchar[256]        strAppName;
    wchar[64]         strServiceShortName;
    RM_APP_TYPE       ApplicationType;
    /*FIELD ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(RM_APP_STATUS))], [])*/uint AppStatus;
    uint              TSSessionId;
    BOOL              bRestartable;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/restartmanager/ns-restartmanager-rm_filter_info))], [])
struct RM_FILTER_INFO
{
    RM_FILTER_ACTION    FilterAction;
    RM_FILTER_TRIGGER   FilterTrigger;
    uint                cbNextOffset;
    _Anonymous_e__Union Anonymous;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("rstrtmgr.dll")
WIN32_ERROR RmStartSession(uint* pSessionHandle, 
                           /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwSessionFlags, 
                           PWSTR strSessionKey);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("RstrtMgr.dll")
WIN32_ERROR RmJoinSession(uint* pSessionHandle, const(PWSTR) strSessionKey);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("rstrtmgr.dll")
WIN32_ERROR RmEndSession(uint dwSessionHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("rstrtmgr.dll")
WIN32_ERROR RmRegisterResources(uint dwSessionHandle, uint nFiles, const(PWSTR)* rgsFileNames, uint nApplications, 
                                RM_UNIQUE_PROCESS* rgApplications, uint nServices, const(PWSTR)* rgsServiceNames);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("rstrtmgr.dll")
WIN32_ERROR RmGetList(uint dwSessionHandle, uint* pnProcInfoNeeded, uint* pnProcInfo, 
                      RM_PROCESS_INFO* rgAffectedApps, uint* lpdwRebootReasons);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("rstrtmgr.dll")
WIN32_ERROR RmShutdown(uint dwSessionHandle, uint lActionFlags, RM_WRITE_STATUS_CALLBACK fnStatus);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("rstrtmgr.dll")
WIN32_ERROR RmRestart(uint dwSessionHandle, 
                      /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwRestartFlags, 
                      RM_WRITE_STATUS_CALLBACK fnStatus);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("RstrtMgr.dll")
WIN32_ERROR RmCancelCurrentTask(uint dwSessionHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("RstrtMgr.dll")
WIN32_ERROR RmAddFilter(uint dwSessionHandle, const(PWSTR) strModuleName, RM_UNIQUE_PROCESS* pProcess, 
                        const(PWSTR) strServiceShortName, RM_FILTER_ACTION FilterAction);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("RstrtMgr.dll")
WIN32_ERROR RmRemoveFilter(uint dwSessionHandle, const(PWSTR) strModuleName, RM_UNIQUE_PROCESS* pProcess, 
                           const(PWSTR) strServiceShortName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("RstrtMgr.dll")
WIN32_ERROR RmGetFilterList(uint dwSessionHandle, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ubyte* pbFilterBuf, 
                            uint cbFilterBuf, uint* cbFilterBufNeeded);


