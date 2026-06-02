// Written in the D programming language.

module windows.win32.system.shutdown;

public import windows.core;
public import windows.win32.foundation : BOOL, BOOLEAN, HWND, PSTR, PWSTR;

extern(Windows) @nogc nothrow:


// Enums


alias SHUTDOWN_REASON = uint;
enum : uint
{
    SHTDN_REASON_NONE                           = 0x00000000U,
    SHTDN_REASON_FLAG_COMMENT_REQUIRED          = 0x01000000U,
    SHTDN_REASON_FLAG_DIRTY_PROBLEM_ID_REQUIRED = 0x02000000U,
    SHTDN_REASON_FLAG_CLEAN_UI                  = 0x04000000U,
    SHTDN_REASON_FLAG_DIRTY_UI                  = 0x08000000U,
    SHTDN_REASON_FLAG_MOBILE_UI_RESERVED        = 0x10000000U,
    SHTDN_REASON_FLAG_USER_DEFINED              = 0x40000000U,
    SHTDN_REASON_FLAG_PLANNED                   = 0x80000000U,
    SHTDN_REASON_MAJOR_OTHER                    = 0x00000000U,
    SHTDN_REASON_MAJOR_NONE                     = 0x00000000U,
    SHTDN_REASON_MAJOR_HARDWARE                 = 0x00010000U,
    SHTDN_REASON_MAJOR_OPERATINGSYSTEM          = 0x00020000U,
    SHTDN_REASON_MAJOR_SOFTWARE                 = 0x00030000U,
    SHTDN_REASON_MAJOR_APPLICATION              = 0x00040000U,
    SHTDN_REASON_MAJOR_SYSTEM                   = 0x00050000U,
    SHTDN_REASON_MAJOR_POWER                    = 0x00060000U,
    SHTDN_REASON_MAJOR_LEGACY_API               = 0x00070000U,
    SHTDN_REASON_MINOR_OTHER                    = 0x00000000U,
    SHTDN_REASON_MINOR_NONE                     = 0x000000ffU,
    SHTDN_REASON_MINOR_MAINTENANCE              = 0x00000001U,
    SHTDN_REASON_MINOR_INSTALLATION             = 0x00000002U,
    SHTDN_REASON_MINOR_UPGRADE                  = 0x00000003U,
    SHTDN_REASON_MINOR_RECONFIG                 = 0x00000004U,
    SHTDN_REASON_MINOR_HUNG                     = 0x00000005U,
    SHTDN_REASON_MINOR_UNSTABLE                 = 0x00000006U,
    SHTDN_REASON_MINOR_DISK                     = 0x00000007U,
    SHTDN_REASON_MINOR_PROCESSOR                = 0x00000008U,
    SHTDN_REASON_MINOR_NETWORKCARD              = 0x00000009U,
    SHTDN_REASON_MINOR_POWER_SUPPLY             = 0x0000000aU,
    SHTDN_REASON_MINOR_CORDUNPLUGGED            = 0x0000000bU,
    SHTDN_REASON_MINOR_ENVIRONMENT              = 0x0000000cU,
    SHTDN_REASON_MINOR_HARDWARE_DRIVER          = 0x0000000dU,
    SHTDN_REASON_MINOR_OTHERDRIVER              = 0x0000000eU,
    SHTDN_REASON_MINOR_BLUESCREEN               = 0x0000000fU,
    SHTDN_REASON_MINOR_SERVICEPACK              = 0x00000010U,
    SHTDN_REASON_MINOR_HOTFIX                   = 0x00000011U,
    SHTDN_REASON_MINOR_SECURITYFIX              = 0x00000012U,
    SHTDN_REASON_MINOR_SECURITY                 = 0x00000013U,
    SHTDN_REASON_MINOR_NETWORK_CONNECTIVITY     = 0x00000014U,
    SHTDN_REASON_MINOR_WMI                      = 0x00000015U,
    SHTDN_REASON_MINOR_SERVICEPACK_UNINSTALL    = 0x00000016U,
    SHTDN_REASON_MINOR_HOTFIX_UNINSTALL         = 0x00000017U,
    SHTDN_REASON_MINOR_SECURITYFIX_UNINSTALL    = 0x00000018U,
    SHTDN_REASON_MINOR_MMC                      = 0x00000019U,
    SHTDN_REASON_MINOR_SYSTEMRESTORE            = 0x0000001aU,
    SHTDN_REASON_MINOR_TERMSRV                  = 0x00000020U,
    SHTDN_REASON_MINOR_DC_PROMOTION             = 0x00000021U,
    SHTDN_REASON_MINOR_DC_DEMOTION              = 0x00000022U,
    SHTDN_REASON_UNKNOWN                        = 0x000000ffU,
    SHTDN_REASON_LEGACY_API                     = 0x80070000U,
    SHTDN_REASON_VALID_BIT_MASK                 = 0xc0ffffffU,
}

alias SHUTDOWN_FLAGS = uint;
enum : uint
{
    SHUTDOWN_FORCE_OTHERS          = 0x00000001U,
    SHUTDOWN_FORCE_SELF            = 0x00000002U,
    SHUTDOWN_RESTART               = 0x00000004U,
    SHUTDOWN_POWEROFF              = 0x00000008U,
    SHUTDOWN_NOREBOOT              = 0x00000010U,
    SHUTDOWN_GRACE_OVERRIDE        = 0x00000020U,
    SHUTDOWN_INSTALL_UPDATES       = 0x00000040U,
    SHUTDOWN_RESTARTAPPS           = 0x00000080U,
    SHUTDOWN_SKIP_SVC_PRESHUTDOWN  = 0x00000100U,
    SHUTDOWN_HYBRID                = 0x00000200U,
    SHUTDOWN_RESTART_BOOTOPTIONS   = 0x00000400U,
    SHUTDOWN_SOFT_REBOOT           = 0x00000800U,
    SHUTDOWN_MOBILE_UI             = 0x00001000U,
    SHUTDOWN_ARSO                  = 0x00002000U,
    SHUTDOWN_CHECK_SAFE_FOR_SERVER = 0x00004000U,
    SHUTDOWN_VAIL_CONTAINER        = 0x00008000U,
    SHUTDOWN_SYSTEM_INITIATED      = 0x00010000U,
    SHUTDOWN_UPDATE_POWEROFF       = 0x00020000U,
}

alias EXIT_WINDOWS_FLAGS = uint;
enum : uint
{
    EWX_LOGOFF                = 0x00000000U,
    EWX_SHUTDOWN              = 0x00000001U,
    EWX_REBOOT                = 0x00000002U,
    EWX_FORCE                 = 0x00000004U,
    EWX_POWEROFF              = 0x00000008U,
    EWX_FORCEIFHUNG           = 0x00000010U,
    EWX_QUICKRESOLVE          = 0x00000020U,
    EWX_RESTARTAPPS           = 0x00000040U,
    EWX_HYBRID_SHUTDOWN       = 0x00400000U,
    EWX_BOOTOPTIONS           = 0x01000000U,
    EWX_ARSO                  = 0x04000000U,
    EWX_CHECK_SAFE_FOR_SERVER = 0x08000000U,
    EWX_SYSTEM_INITIATED      = 0x10000000U,
}

// Constants


enum : uint
{
    MAX_REASON_NAME_LEN    = 0x00000040U,
    MAX_REASON_DESC_LEN    = 0x00000100U,
    MAX_REASON_BUGID_LEN   = 0x00000020U,
    MAX_REASON_COMMENT_LEN = 0x00000200U,
}

enum uint SHUTDOWN_TYPE_LEN = 0x00000020U;

enum : uint
{
    POLICY_SHOWREASONUI_NEVER           = 0x00000000U,
    POLICY_SHOWREASONUI_ALWAYS          = 0x00000001U,
    POLICY_SHOWREASONUI_WORKSTATIONONLY = 0x00000002U,
    POLICY_SHOWREASONUI_SERVERONLY      = 0x00000003U,
}

enum : uint
{
    SNAPSHOT_POLICY_NEVER     = 0x00000000U,
    SNAPSHOT_POLICY_ALWAYS    = 0x00000001U,
    SNAPSHOT_POLICY_UNPLANNED = 0x00000002U,
}

enum uint MAX_NUM_REASONS = 0x00000100U;

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL InitiateSystemShutdownA(PSTR lpMachineName, PSTR lpMessage, uint dwTimeout, BOOL bForceAppsClosed, 
                             BOOL bRebootAfterShutdown);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL InitiateSystemShutdownW(PWSTR lpMachineName, PWSTR lpMessage, uint dwTimeout, BOOL bForceAppsClosed, 
                             BOOL bRebootAfterShutdown);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL AbortSystemShutdownA(PSTR lpMachineName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL AbortSystemShutdownW(PWSTR lpMachineName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL InitiateSystemShutdownExA(PSTR lpMachineName, PSTR lpMessage, uint dwTimeout, BOOL bForceAppsClosed, 
                               BOOL bRebootAfterShutdown, SHUTDOWN_REASON dwReason);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL InitiateSystemShutdownExW(PWSTR lpMachineName, PWSTR lpMessage, uint dwTimeout, BOOL bForceAppsClosed, 
                               BOOL bRebootAfterShutdown, SHUTDOWN_REASON dwReason);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
uint InitiateShutdownA(PSTR lpMachineName, PSTR lpMessage, uint dwGracePeriod, SHUTDOWN_FLAGS dwShutdownFlags, 
                       SHUTDOWN_REASON dwReason);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
uint InitiateShutdownW(PWSTR lpMachineName, PWSTR lpMessage, uint dwGracePeriod, SHUTDOWN_FLAGS dwShutdownFlags, 
                       SHUTDOWN_REASON dwReason);

@DllImport("ADVAPI32.dll")
uint CheckForHiberboot(BOOLEAN* pHiberboot, BOOLEAN bClearFlag);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("USER32.dll")
BOOL ExitWindowsEx(EXIT_WINDOWS_FLAGS uFlags, SHUTDOWN_REASON dwReason);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("USER32.dll")
BOOL LockWorkStation();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("USER32.dll")
BOOL ShutdownBlockReasonCreate(HWND hWnd, const(PWSTR) pwszReason);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("USER32.dll")
BOOL ShutdownBlockReasonQuery(HWND hWnd, PWSTR pwszBuff, uint* pcchBuff);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("USER32.dll")
BOOL ShutdownBlockReasonDestroy(HWND hWnd);


