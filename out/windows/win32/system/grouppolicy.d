// Written in the D programming language.

module windows.win32.system.grouppolicy;

public import windows.core;
public import system.system : Guid;
public import windows.win32.foundation.foundation : BOOL, BSTR, CHAR, HANDLE, HRESULT,
                                                    HWND, LPARAM, PSTR, PWSTR, SYSTEMTIME,
                                                    VARIANT_BOOL;
public import windows.win32.security.security : GENERIC_MAPPING, OBJECT_TYPE_LIST, PRIVILEGE_SET,
                                                PSECURITY_DESCRIPTOR, PSID;
public import windows.win32.system.com.com : IDispatch, IUnknown, SAFEARRAY;
public import windows.win32.system.ole : IEnumVARIANT;
public import windows.win32.system.registry : HKEY;
public import windows.win32.system.variant : VARIANT;
public import windows.win32.system.wmi : IWbemClassObject, IWbemServices;
public import windows.win32.ui.controls.controls : HPROPSHEETPAGE;
public import windows.win32.ui.shell.shell : APPCATEGORYINFOLIST;

extern(Windows) @nogc nothrow:


// Enums


alias GPO_OPEN_FLAGS = uint;
enum : uint
{
    GPO_OPEN_LOAD_REGISTRY = 0x00000001U,
    GPO_OPEN_READ_ONLY     = 0x00000002U,
}

alias GPO_OPTIONS = uint;
enum : uint
{
    GPO_OPTION_DISABLE_USER    = 0x00000001U,
    GPO_OPTION_DISABLE_MACHINE = 0x00000002U,
}

alias GPO_SECTION = uint;
enum : uint
{
    GPO_SECTION_ROOT    = 0x00000000U,
    GPO_SECTION_USER    = 0x00000001U,
    GPO_SECTION_MACHINE = 0x00000002U,
}

alias GPMRSOPMode = int;
enum : int
{
    rsopUnknown  = 0x00000000,
    rsopPlanning = 0x00000001,
    rsopLogging  = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/ne-gpmgmt-gpmpermissiontype
enum GPMPermissionType : int
{
    permGPOApply                 = 0x00010000,
    permGPORead                  = 0x00010100,
    permGPOEdit                  = 0x00010101,
    permGPOEditSecurityAndDelete = 0x00010102,
    permGPOCustom                = 0x00010103,
    permWMIFilterEdit            = 0x00020000,
    permWMIFilterFullControl     = 0x00020001,
    permWMIFilterCustom          = 0x00020002,
    permSOMLink                  = 0x001c0000,
    permSOMLogging               = 0x00180100,
    permSOMPlanning              = 0x00180200,
    permSOMWMICreate             = 0x00100300,
    permSOMWMIFullControl        = 0x00100301,
    permSOMGPOCreate             = 0x00100400,
    permStarterGPORead           = 0x00030500,
    permStarterGPOEdit           = 0x00030501,
    permStarterGPOFullControl    = 0x00030502,
    permStarterGPOCustom         = 0x00030503,
    permSOMStarterGPOCreate      = 0x00100500,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/ne-gpmgmt-gpmsearchproperty
enum GPMSearchProperty : int
{
    gpoPermissions                 = 0x00000000,
    gpoEffectivePermissions        = 0x00000001,
    gpoDisplayName                 = 0x00000002,
    gpoWMIFilter                   = 0x00000003,
    gpoID                          = 0x00000004,
    gpoComputerExtensions          = 0x00000005,
    gpoUserExtensions              = 0x00000006,
    somLinks                       = 0x00000007,
    gpoDomain                      = 0x00000008,
    backupMostRecent               = 0x00000009,
    starterGPOPermissions          = 0x0000000a,
    starterGPOEffectivePermissions = 0x0000000b,
    starterGPODisplayName          = 0x0000000c,
    starterGPOID                   = 0x0000000d,
    starterGPODomain               = 0x0000000e,
}

enum GPMSearchOperation : int
{
    opEquals      = 0x00000000,
    opContains    = 0x00000001,
    opNotContains = 0x00000002,
    opNotEquals   = 0x00000003,
}

enum GPMReportType : int
{
    repXML                    = 0x00000000,
    repHTML                   = 0x00000001,
    repInfraXML               = 0x00000002,
    repInfraRefreshXML        = 0x00000003,
    repClientHealthXML        = 0x00000004,
    repClientHealthRefreshXML = 0x00000005,
}

enum GPMEntryType : int
{
    typeUser           = 0x00000000,
    typeComputer       = 0x00000001,
    typeLocalGroup     = 0x00000002,
    typeGlobalGroup    = 0x00000003,
    typeUniversalGroup = 0x00000004,
    typeUNCPath        = 0x00000005,
    typeUnknown        = 0x00000006,
}

enum GPMDestinationOption : int
{
    opDestinationSameAsSource   = 0x00000000,
    opDestinationNone           = 0x00000001,
    opDestinationByRelativeName = 0x00000002,
    opDestinationSet            = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/ne-gpmgmt-gpmreportingoptions
enum GPMReportingOptions : int
{
    opReportLegacy   = 0x00000000,
    opReportComments = 0x00000001,
}

alias GPMSOMType = int;
enum : int
{
    somSite   = 0x00000000,
    somDomain = 0x00000001,
    somOU     = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/ne-gpmgmt-gpmbackuptype
enum GPMBackupType : int
{
    typeGPO        = 0x00000000,
    typeStarterGPO = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/ne-gpmgmt-gpmstartergpotype
enum GPMStarterGPOType : int
{
    typeSystem = 0x00000000,
    typeCustom = 0x00000001,
}

alias GPO_LINK = int;
enum : int
{
    GPLinkUnknown            = 0x00000000,
    GPLinkMachine            = 0x00000001,
    GPLinkSite               = 0x00000002,
    GPLinkDomain             = 0x00000003,
    GPLinkOrganizationalUnit = 0x00000004,
}

alias SETTINGSTATUS = int;
enum : int
{
    RSOPUnspecified      = 0x00000000,
    RSOPApplied          = 0x00000001,
    RSOPIgnored          = 0x00000002,
    RSOPFailed           = 0x00000003,
    RSOPSubsettingFailed = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appmgmt/ne-appmgmt-installspectype
alias INSTALLSPECTYPE = int;
enum : int
{
    APPNAME  = 0x00000001,
    FILEEXT  = 0x00000002,
    PROGID   = 0x00000003,
    COMCLASS = 0x00000004,
}

alias APPSTATE = int;
enum : int
{
    ABSENT    = 0x00000000,
    ASSIGNED  = 0x00000001,
    PUBLISHED = 0x00000002,
}

alias GROUP_POLICY_OBJECT_TYPE = int;
enum : int
{
    GPOTypeLocal      = 0x00000000,
    GPOTypeRemote     = 0x00000001,
    GPOTypeDS         = 0x00000002,
    GPOTypeLocalUser  = 0x00000003,
    GPOTypeLocalGroup = 0x00000004,
}

alias GROUP_POLICY_HINT_TYPE = int;
enum : int
{
    GPHintUnknown            = 0x00000000,
    GPHintMachine            = 0x00000001,
    GPHintSite               = 0x00000002,
    GPHintDomain             = 0x00000003,
    GPHintOrganizationalUnit = 0x00000004,
}

// Constants


enum : uint
{
    GPM_USE_PDC   = 0x00000000U,
    GPM_USE_ANYDC = 0x00000001U,
}

enum : uint
{
    GPM_DONOTUSE_W2KDC   = 0x00000002U,
    GPM_DONOT_VALIDATEDC = 0x00000001U,
}

enum uint GPM_MIGRATIONTABLE_ONLY = 0x00000001U;
enum uint GPM_PROCESS_SECURITY = 0x00000002U;

enum : uint
{
    RSOP_NO_COMPUTER                         = 0x00010000U,
    RSOP_NO_USER                             = 0x00020000U,
    RSOP_PLANNING_ASSUME_SLOW_LINK           = 0x00000001U,
    RSOP_PLANNING_ASSUME_LOOPBACK_MERGE      = 0x00000002U,
    RSOP_PLANNING_ASSUME_LOOPBACK_REPLACE    = 0x00000004U,
    RSOP_PLANNING_ASSUME_USER_WQLFILTER_TRUE = 0x00000008U,
    RSOP_PLANNING_ASSUME_COMP_WQLFILTER_TRUE = 0x00000010U,
}

enum : uint
{
    PI_NOUI        = 0x00000001U,
    PI_APPLYPOLICY = 0x00000002U,
}

enum uint PT_TEMPORARY = 0x00000001U;
enum uint PT_ROAMING = 0x00000002U;
enum uint PT_MANDATORY = 0x00000004U;
enum uint PT_ROAMING_PREEXISTING = 0x00000008U;
enum uint RP_FORCE = 0x00000001U;
enum uint RP_SYNC = 0x00000002U;
enum uint GPC_BLOCK_POLICY = 0x00000001U;

enum : uint
{
    GPO_FLAG_DISABLE = 0x00000001U,
    GPO_FLAG_FORCE   = 0x00000002U,
}

enum : uint
{
    GPO_LIST_FLAG_MACHINE            = 0x00000001U,
    GPO_LIST_FLAG_SITEONLY           = 0x00000002U,
    GPO_LIST_FLAG_NO_WMIFILTERS      = 0x00000004U,
    GPO_LIST_FLAG_NO_SECURITYFILTERS = 0x00000008U,
}

enum const(wchar)* GP_DLLNAME = "DllName";
enum const(wchar)* GP_ENABLEASYNCHRONOUSPROCESSING = "EnableAsynchronousProcessing";
enum const(wchar)* GP_MAXNOGPOLISTCHANGESINTERVAL = "MaxNoGPOListChangesInterval";
enum const(wchar)* GP_NOBACKGROUNDPOLICY = "NoBackgroundPolicy";
enum const(wchar)* GP_NOGPOLISTCHANGES = "NoGPOListChanges";
enum const(wchar)* GP_NOMACHINEPOLICY = "NoMachinePolicy";
enum const(wchar)* GP_NOSLOWLINK = "NoSlowLink";
enum const(wchar)* GP_NOTIFYLINKTRANSITION = "NotifyLinkTransition";
enum const(wchar)* GP_NOUSERPOLICY = "NoUserPolicy";
enum const(wchar)* GP_PERUSERLOCALSETTINGS = "PerUserLocalSettings";
enum const(wchar)* GP_PROCESSGROUPPOLICY = "ProcessGroupPolicy";
enum const(wchar)* GP_REQUIRESSUCCESSFULREGISTRY = "RequiresSuccessfulRegistry";

enum : uint
{
    GPO_INFO_FLAG_MACHINE            = 0x00000001U,
    GPO_INFO_FLAG_BACKGROUND         = 0x00000010U,
    GPO_INFO_FLAG_SLOWLINK           = 0x00000020U,
    GPO_INFO_FLAG_VERBOSE            = 0x00000040U,
    GPO_INFO_FLAG_NOCHANGES          = 0x00000080U,
    GPO_INFO_FLAG_LINKTRANSITION     = 0x00000100U,
    GPO_INFO_FLAG_LOGRSOP_TRANSITION = 0x00000200U,
    GPO_INFO_FLAG_FORCED_REFRESH     = 0x00000400U,
    GPO_INFO_FLAG_SAFEMODE_BOOT      = 0x00000800U,
    GPO_INFO_FLAG_ASYNC_FOREGROUND   = 0x00001000U,
}

enum GUID REGISTRY_EXTENSION_GUID = GUID("35378eac-683f-11d2-a89a-00c04fbbcfa2");
enum GUID GROUP_POLICY_TRIGGER_EVENT_PROVIDER_GUID = GUID("bd2f4252-5e1e-49fc-9a30-f3978ad89ee2");
enum GUID MACHINE_POLICY_PRESENT_TRIGGER_GUID = GUID("659fcae6-5bdb-4da9-b1ff-ca2a178d46e0");
enum GUID USER_POLICY_PRESENT_TRIGGER_GUID = GUID("54fb46c8-f089-464c-b1fd-59d1b62c3b50");

enum : uint
{
    FLAG_NO_GPO_FILTER = 0x80000000U,
    FLAG_NO_CSE_INVOKE = 0x40000000U,
}

enum uint FLAG_ASSUME_SLOW_LINK = 0x20000000U;

enum : uint
{
    FLAG_LOOPBACK_MERGE   = 0x10000000U,
    FLAG_LOOPBACK_REPLACE = 0x08000000U,
}

enum uint FLAG_ASSUME_USER_WQLFILTER_TRUE = 0x04000000U;
enum uint FLAG_ASSUME_COMP_WQLFILTER_TRUE = 0x02000000U;
enum uint FLAG_PLANNING_MODE = 0x01000000U;

enum : uint
{
    FLAG_NO_USER     = 0x00000001U,
    FLAG_NO_COMPUTER = 0x00000002U,
}

enum uint FLAG_FORCE_CREATENAMESPACE = 0x00000004U;
enum uint RSOP_USER_ACCESS_DENIED = 0x00000001U;
enum uint RSOP_COMPUTER_ACCESS_DENIED = 0x00000002U;
enum uint RSOP_TEMPNAMESPACE_EXISTS = 0x00000004U;

enum : uint
{
    LOCALSTATE_ASSIGNED            = 0x00000001U,
    LOCALSTATE_PUBLISHED           = 0x00000002U,
    LOCALSTATE_UNINSTALL_UNMANAGED = 0x00000004U,
}

enum : uint
{
    LOCALSTATE_POLICYREMOVE_ORPHAN    = 0x00000008U,
    LOCALSTATE_POLICYREMOVE_UNINSTALL = 0x00000010U,
}

enum : uint
{
    LOCALSTATE_ORPHANED    = 0x00000020U,
    LOCALSTATE_UNINSTALLED = 0x00000040U,
}

enum : uint
{
    MANAGED_APPS_USERAPPLICATIONS  = 0x00000001U,
    MANAGED_APPS_FROMCATEGORY      = 0x00000002U,
    MANAGED_APPS_INFOLEVEL_DEFAULT = 0x00010000U,
}

enum : uint
{
    MANAGED_APPTYPE_WINDOWSINSTALLER = 0x00000001U,
    MANAGED_APPTYPE_SETUPEXE         = 0x00000002U,
    MANAGED_APPTYPE_UNSUPPORTED      = 0x00000003U,
}

enum GUID CLSID_GPESnapIn = GUID("8fc0b734-a0e1-11d1-a7d3-0000f87571e3");

enum : GUID
{
    NODEID_Machine           = GUID("8fc0b737-a0e1-11d1-a7d3-0000f87571e3"),
    NODEID_MachineSWSettings = GUID("8fc0b73a-a0e1-11d1-a7d3-0000f87571e3"),
}

enum : GUID
{
    NODEID_User           = GUID("8fc0b738-a0e1-11d1-a7d3-0000f87571e3"),
    NODEID_UserSWSettings = GUID("8fc0b73c-a0e1-11d1-a7d3-0000f87571e3"),
}

enum GUID CLSID_GroupPolicyObject = GUID("ea502722-a23d-11d1-a7d3-0000f87571e3");
enum GUID ADMXCOMMENTS_EXTENSION_GUID = GUID("6c5a2a86-9eb3-42b9-aa83-a7371ba011b9");
enum GUID CLSID_RSOPSnapIn = GUID("6dc3804b-7212-458d-adb0-9a07e2ae1fa2");

enum : GUID
{
    NODEID_RSOPMachine           = GUID("bd4c1a2e-0b7a-4a62-a6b0-c0577539c97e"),
    NODEID_RSOPMachineSWSettings = GUID("6a76273e-eb8e-45db-94c5-25663a5f2c1a"),
}

enum : GUID
{
    NODEID_RSOPUser           = GUID("ab87364f-0cec-4cd8-9bf8-898f34628fb8"),
    NODEID_RSOPUserSWSettings = GUID("e52c5ce3-fd27-4402-84de-d9a5f2858910"),
}

enum uint RSOP_INFO_FLAG_DIAGNOSTIC_MODE = 0x00000001U;

enum : uint
{
    GPO_BROWSE_DISABLENEW      = 0x00000001U,
    GPO_BROWSE_NOCOMPUTERS     = 0x00000002U,
    GPO_BROWSE_NODSGPOS        = 0x00000004U,
    GPO_BROWSE_OPENBUTTON      = 0x00000008U,
    GPO_BROWSE_INITTOALL       = 0x00000010U,
    GPO_BROWSE_NOUSERGPOS      = 0x00000020U,
    GPO_BROWSE_SENDAPPLYONEDIT = 0x00000040U,
}

// Callbacks

alias PFNSTATUSMESSAGECALLBACK = uint function(BOOL bVerbose, PWSTR lpMessage);
alias PFNPROCESSGROUPPOLICY = uint function(uint dwFlags, HANDLE hToken, HKEY hKeyRoot, 
                                            GROUP_POLICY_OBJECTA* pDeletedGPOList, 
                                            GROUP_POLICY_OBJECTA* pChangedGPOList, size_t pHandle, BOOL* pbAbort, 
                                            PFNSTATUSMESSAGECALLBACK pStatusCallback);
alias PFNPROCESSGROUPPOLICYEX = uint function(uint dwFlags, HANDLE hToken, HKEY hKeyRoot, 
                                              GROUP_POLICY_OBJECTA* pDeletedGPOList, 
                                              GROUP_POLICY_OBJECTA* pChangedGPOList, size_t pHandle, BOOL* pbAbort, 
                                              PFNSTATUSMESSAGECALLBACK pStatusCallback, IWbemServices pWbemServices, 
                                              HRESULT* pRsopStatus);
alias PFNGENERATEGROUPPOLICY = uint function(uint dwFlags, BOOL* pbAbort, PWSTR pwszSite, 
                                             RSOP_TARGET* pComputerTarget, RSOP_TARGET* pUserTarget);

// Structs


//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/userenv/ns-userenv-group_policy_objecta
struct GROUP_POLICY_OBJECTA
{
    uint     dwOptions;
    uint     dwVersion;
    PSTR     lpDSPath;
    PSTR     lpFileSysPath;
    PSTR     lpDisplayName;
    CHAR[50] szGPOName;
    GPO_LINK GPOLink;
    LPARAM   lParam;
    GROUP_POLICY_OBJECTA* pNext;
    GROUP_POLICY_OBJECTA* pPrev;
    PSTR     lpExtensions;
    LPARAM   lParam2;
    PSTR     lpLink;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/userenv/ns-userenv-group_policy_objectw
struct GROUP_POLICY_OBJECTW
{
    uint      dwOptions;
    uint      dwVersion;
    PWSTR     lpDSPath;
    PWSTR     lpFileSysPath;
    PWSTR     lpDisplayName;
    wchar[50] szGPOName;
    GPO_LINK  GPOLink;
    LPARAM    lParam;
    GROUP_POLICY_OBJECTW* pNext;
    GROUP_POLICY_OBJECTW* pPrev;
    PWSTR     lpExtensions;
    LPARAM    lParam2;
    PWSTR     lpLink;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/userenv/ns-userenv-rsop_target
struct RSOP_TARGET
{
    PWSTR         pwszAccountName;
    PWSTR         pwszNewSOM;
    SAFEARRAY*    psaSecurityGroups;
    void*         pRsopToken;
    GROUP_POLICY_OBJECTA* pGPOList;
    IWbemServices pWbemServices;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/userenv/ns-userenv-policysettingstatusinfo
struct POLICYSETTINGSTATUSINFO
{
    PWSTR         szKey;
    PWSTR         szEventSource;
    PWSTR         szEventLogName;
    uint          dwEventID;
    uint          dwErrorCode;
    SETTINGSTATUS status;
    SYSTEMTIME    timeLogged;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appmgmt/ns-appmgmt-installspec
union INSTALLSPEC
{
    struct AppName
    {
        PWSTR Name;
        GUID  GPOId;
    }
    PWSTR FileExt;
    PWSTR ProgId;
    struct COMClass
    {
        GUID Clsid;
        uint ClsCtx;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appmgmt/ns-appmgmt-installdata
struct INSTALLDATA
{
    INSTALLSPECTYPE Type;
    INSTALLSPEC     Spec;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appmgmt/ns-appmgmt-localmanagedapplication
struct LOCALMANAGEDAPPLICATION
{
    PWSTR pszDeploymentName;
    PWSTR pszPolicyName;
    PWSTR pszProductId;
    uint  dwState;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appmgmt/ns-appmgmt-managedapplication
struct MANAGEDAPPLICATION
{
    PWSTR  pszPackageName;
    PWSTR  pszPublisher;
    uint   dwVersionHi;
    uint   dwVersionLo;
    uint   dwRevision;
    GUID   GpoId;
    PWSTR  pszPolicyName;
    GUID   ProductId;
    ushort Language;
    PWSTR  pszOwner;
    PWSTR  pszCompany;
    PWSTR  pszComments;
    PWSTR  pszContact;
    PWSTR  pszSupportUrl;
    uint   dwPathType;
    BOOL   bInstalled;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpedit/ns-gpedit-gpobrowseinfo
struct GPOBROWSEINFO
{
    uint  dwSize;
    uint  dwFlags;
    HWND  hwndOwner;
    PWSTR lpTitle;
    PWSTR lpInitialOU;
    PWSTR lpDSPath;
    uint  dwDSPathSize;
    PWSTR lpName;
    uint  dwNameSize;
    GROUP_POLICY_OBJECT_TYPE gpoType;
    GROUP_POLICY_HINT_TYPE gpoHint;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("USERENV.dll")
BOOL RefreshPolicy(BOOL bMachine);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("USERENV.dll")
BOOL RefreshPolicyEx(BOOL bMachine, uint dwOptions);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("USERENV.dll")
HANDLE EnterCriticalPolicySection(BOOL bMachine);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("USERENV.dll")
BOOL LeaveCriticalPolicySection(HANDLE hSection);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("USERENV.dll")
BOOL RegisterGPNotification(HANDLE hEvent, BOOL bMachine);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("USERENV.dll")
BOOL UnregisterGPNotification(HANDLE hEvent);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("USERENV.dll")
BOOL GetGPOListA(HANDLE hToken, const(PSTR) lpName, const(PSTR) lpHostName, const(PSTR) lpComputerName, 
                 uint dwFlags, GROUP_POLICY_OBJECTA** pGPOList);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("USERENV.dll")
BOOL GetGPOListW(HANDLE hToken, const(PWSTR) lpName, const(PWSTR) lpHostName, const(PWSTR) lpComputerName, 
                 uint dwFlags, GROUP_POLICY_OBJECTW** pGPOList);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("USERENV.dll")
BOOL FreeGPOListA(GROUP_POLICY_OBJECTA* pGPOList);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("USERENV.dll")
BOOL FreeGPOListW(GROUP_POLICY_OBJECTW* pGPOList);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("USERENV.dll")
uint GetAppliedGPOListA(uint dwFlags, const(PSTR) pMachineName, PSID pSidUser, GUID* pGuidExtension, 
                        GROUP_POLICY_OBJECTA** ppGPOList);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("USERENV.dll")
uint GetAppliedGPOListW(uint dwFlags, const(PWSTR) pMachineName, PSID pSidUser, GUID* pGuidExtension, 
                        GROUP_POLICY_OBJECTW** ppGPOList);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("USERENV.dll")
uint ProcessGroupPolicyCompleted(GUID* extensionId, size_t pAsyncHandle, uint dwStatus);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("USERENV.dll")
uint ProcessGroupPolicyCompletedEx(GUID* extensionId, size_t pAsyncHandle, uint dwStatus, HRESULT RsopStatus);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("USERENV.dll")
HRESULT RsopAccessCheckByType(PSECURITY_DESCRIPTOR pSecurityDescriptor, PSID pPrincipalSelfSid, void* pRsopToken, 
                              uint dwDesiredAccessMask, OBJECT_TYPE_LIST* pObjectTypeList, uint ObjectTypeListLength, 
                              GENERIC_MAPPING* pGenericMapping, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(8)))])*/PRIVILEGE_SET* pPrivilegeSet, 
                              uint* pdwPrivilegeSetLength, uint* pdwGrantedAccessMask, BOOL* pbAccessStatus);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("USERENV.dll")
HRESULT RsopFileAccessCheck(PWSTR pszFileName, void* pRsopToken, uint dwDesiredAccessMask, 
                            uint* pdwGrantedAccessMask, BOOL* pbAccessStatus);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("USERENV.dll")
HRESULT RsopSetPolicySettingStatus(uint dwFlags, IWbemServices pServices, IWbemClassObject pSettingInstance, 
                                   uint nInfo, POLICYSETTINGSTATUSINFO* pStatus);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("USERENV.dll")
HRESULT RsopResetPolicySettingStatus(uint dwFlags, IWbemServices pServices, IWbemClassObject pSettingInstance);

@DllImport("USERENV.dll")
uint GenerateGPNotification(BOOL bMachine, const(PWSTR) lpwszMgmtProduct, uint dwMgmtProductOptions);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
uint InstallApplication(INSTALLDATA* pInstallInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
uint UninstallApplication(PWSTR ProductCode, uint dwStatus);

@DllImport("ADVAPI32.dll")
uint CommandLineFromMsiDescriptor(PWSTR Descriptor, PWSTR CommandLine, uint* CommandLineLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
uint GetManagedApplications(GUID* pCategory, uint dwQueryFlags, uint dwInfoLevel, uint* pdwApps, 
                            MANAGEDAPPLICATION** prgManagedApps);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
uint GetLocalManagedApplications(BOOL bUserApps, uint* pdwApps, LOCALMANAGEDAPPLICATION** prgLocalApps);

@DllImport("ADVAPI32.dll")
void GetLocalManagedApplicationData(PWSTR ProductCode, PWSTR* DisplayName, PWSTR* SupportUrl);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
uint GetManagedApplicationCategories(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwReserved, 
                                     APPCATEGORYINFOLIST* pAppCategory);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("GPEDIT.dll")
HRESULT CreateGPOLink(PWSTR lpGPO, PWSTR lpContainer, BOOL fHighPriority);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("GPEDIT.dll")
HRESULT DeleteGPOLink(PWSTR lpGPO, PWSTR lpContainer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("GPEDIT.dll")
HRESULT DeleteAllGPOLinks(PWSTR lpContainer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("GPEDIT.dll")
HRESULT BrowseForGPO(GPOBROWSEINFO* lpBrowseInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("GPEDIT.dll")
HRESULT ImportRSoPData(PWSTR lpNameSpace, PWSTR lpFileName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("GPEDIT.dll")
HRESULT ExportRSoPData(PWSTR lpNameSpace, PWSTR lpFileName);


// Interfaces

@GUID("f5694708-88fe-4b35-babf-e56162d5fbc8")
struct GPM;

@GUID("710901be-1050-4cb1-838a-c5cff259e183")
struct GPMDomain;

@GUID("229f5c42-852c-4b30-945f-c522be9bd386")
struct GPMSitesContainer;

@GUID("fce4a59d-0f21-4afa-b859-e6d0c62cd10c")
struct GPMBackupDir;

@GUID("32d93fac-450e-44cf-829c-8b22ff6bdae1")
struct GPMSOM;

@GUID("17aaca26-5ce0-44fa-8cc0-5259e6483566")
struct GPMSearchCriteria;

@GUID("5871a40a-e9c0-46ec-913e-944ef9225a94")
struct GPMPermission;

@GUID("547a5e8f-9162-4516-a4df-9ddb9686d846")
struct GPMSecurityInfo;

@GUID("ed1a54b8-5efa-482a-93c0-8ad86f0d68c3")
struct GPMBackup;

@GUID("eb8f035b-70db-4a9f-9676-37c25994e9dc")
struct GPMBackupCollection;

@GUID("24c1f147-3720-4f5b-a9c3-06b4e4f931d2")
struct GPMSOMCollection;

@GUID("626745d8-0dea-4062-bf60-cfc5b1ca1286")
struct GPMWMIFilter;

@GUID("74dc6d28-e820-47d6-a0b8-f08d93d7fa33")
struct GPMWMIFilterCollection;

@GUID("489b0caf-9ec2-4eb7-91f5-b6f71d43da8c")
struct GPMRSOP;

@GUID("d2ce2994-59b5-4064-b581-4d68486a16c4")
struct GPMGPO;

@GUID("7a057325-832d-4de3-a41f-c780436a4e09")
struct GPMGPOCollection;

@GUID("c1df9880-5303-42c6-8a3c-0488e1bf7364")
struct GPMGPOLink;

@GUID("f6ed581a-49a5-47e2-b771-fd8dc02b6259")
struct GPMGPOLinksCollection;

@GUID("372796a9-76ec-479d-ad6c-556318ed5f9d")
struct GPMAsyncCancel;

@GUID("2824e4be-4bcc-4cac-9e60-0e3ed7f12496")
struct GPMStatusMsgCollection;

@GUID("4b77cc94-d255-409b-bc62-370881715a19")
struct GPMStatusMessage;

@GUID("c54a700d-19b6-4211-bcb0-e8e2475e471e")
struct GPMTrustee;

@GUID("c1a2e70e-659c-4b1a-940b-f88b0af9c8a4")
struct GPMClientSideExtension;

@GUID("cf92b828-2d44-4b61-b10a-b327afd42da8")
struct GPMCSECollection;

@GUID("3855e880-cd9e-4d0c-9eaf-1579283a1888")
struct GPMConstants;

@GUID("92101ac0-9287-4206-a3b2-4bdb73d225f6")
struct GPMResult;

@GUID("0cf75d5b-a3a1-4c55-b4fe-9e149c41f66d")
struct GPMMapEntryCollection;

@GUID("8c975253-5431-4471-b35d-0626c928258a")
struct GPMMapEntry;

@GUID("55af4043-2a06-4f72-abef-631b44079c76")
struct GPMMigrationTable;

@GUID("e8c0988a-cf03-4c5b-8be2-2aa9ad32aada")
struct GPMBackupDirEx;

@GUID("e75ea59d-1aeb-4cb5-a78a-281daa582406")
struct GPMStarterGPOBackupCollection;

@GUID("389e400a-d8ef-455b-a861-5f9ca34a6a02")
struct GPMStarterGPOBackup;

@GUID("ecf1d454-71da-4e2f-a8c0-8185465911d9")
struct GPMTemplate;

@GUID("82f8aa8b-49ba-43b2-956e-3397f9b94c3a")
struct GPMStarterGPOCollection;

@GUID("f5fae809-3bd6-4da9-a65e-17665b41d763")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nn-gpmgmt-igpm
interface IGPM : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpm-getdomain
    HRESULT GetDomain(BSTR bstrDomain, BSTR bstrDomainController, int lDCFlags, IGPMDomain* pIGPMDomain);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpm-getbackupdir
    HRESULT GetBackupDir(BSTR bstrBackupDir, IGPMBackupDir* pIGPMBackupDir);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpm-getsitescontainer
    HRESULT GetSitesContainer(BSTR bstrForest, BSTR bstrDomain, BSTR bstrDomainController, int lDCFlags, 
                              IGPMSitesContainer* ppIGPMSitesContainer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpm-getrsop
    HRESULT GetRSOP(GPMRSOPMode gpmRSoPMode, BSTR bstrNamespace, int lFlags, IGPMRSOP* ppIGPMRSOP);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpm-createpermission
    HRESULT CreatePermission(BSTR bstrTrustee, GPMPermissionType perm, VARIANT_BOOL bInheritable, 
                             IGPMPermission* ppPerm);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpm-createsearchcriteria
    HRESULT CreateSearchCriteria(IGPMSearchCriteria* ppIGPMSearchCriteria);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpm-createtrustee
    HRESULT CreateTrustee(BSTR bstrTrustee, IGPMTrustee* ppIGPMTrustee);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpm-getclientsideextensions
    HRESULT GetClientSideExtensions(IGPMCSECollection* ppIGPMCSECollection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpm-getconstants
    HRESULT GetConstants(IGPMConstants* ppIGPMConstants);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpm-getmigrationtable
    HRESULT GetMigrationTable(BSTR bstrMigrationTablePath, IGPMMigrationTable* ppMigrationTable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpm-createmigrationtable
    HRESULT CreateMigrationTable(IGPMMigrationTable* ppMigrationTable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpm-initializereporting
    HRESULT InitializeReporting(BSTR bstrAdmPath);
}

@GUID("6b21cc14-5a00-4f44-a738-feec8a94c7e3")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nn-gpmgmt-igpmdomain
interface IGPMDomain : IDispatch
{
    HRESULT get_DomainController(BSTR* pVal);
    HRESULT get_Domain(BSTR* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmdomain-creategpo
    HRESULT CreateGPO(IGPMGPO* ppNewGPO);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmdomain-getgpo
    HRESULT GetGPO(BSTR bstrGuid, IGPMGPO* ppGPO);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmdomain-searchgpos
    HRESULT SearchGPOs(IGPMSearchCriteria pIGPMSearchCriteria, IGPMGPOCollection* ppIGPMGPOCollection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmdomain-restoregpo
    HRESULT RestoreGPO(IGPMBackup pIGPMBackup, int lDCFlags, VARIANT* pvarGPMProgress, VARIANT* pvarGPMCancel, 
                       IGPMResult* ppIGPMResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmdomain-getsom
    HRESULT GetSOM(BSTR bstrPath, IGPMSOM* ppSOM);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmdomain-searchsoms
    HRESULT SearchSOMs(IGPMSearchCriteria pIGPMSearchCriteria, IGPMSOMCollection* ppIGPMSOMCollection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmdomain-getwmifilter
    HRESULT GetWMIFilter(BSTR bstrPath, IGPMWMIFilter* ppWMIFilter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmdomain-searchwmifilters
    HRESULT SearchWMIFilters(IGPMSearchCriteria pIGPMSearchCriteria, 
                             IGPMWMIFilterCollection* ppIGPMWMIFilterCollection);
}

@GUID("b1568bed-0a93-4acc-810f-afe7081019b9")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nn-gpmgmt-igpmbackupdir
interface IGPMBackupDir : IDispatch
{
    HRESULT get_BackupDirectory(BSTR* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmbackupdir-getbackup
    HRESULT GetBackup(BSTR bstrID, IGPMBackup* ppBackup);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmbackupdir-searchbackups
    HRESULT SearchBackups(IGPMSearchCriteria pIGPMSearchCriteria, IGPMBackupCollection* ppIGPMBackupCollection);
}

@GUID("4725a899-2782-4d27-a6bb-d499246ffd72")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nn-gpmgmt-igpmsitescontainer
interface IGPMSitesContainer : IDispatch
{
    HRESULT get_DomainController(BSTR* pVal);
    HRESULT get_Domain(BSTR* pVal);
    HRESULT get_Forest(BSTR* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmsitescontainer-getsite
    HRESULT GetSite(BSTR bstrSiteName, IGPMSOM* ppSOM);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmsitescontainer-searchsites
    HRESULT SearchSites(IGPMSearchCriteria pIGPMSearchCriteria, IGPMSOMCollection* ppIGPMSOMCollection);
}

@GUID("d6f11c42-829b-48d4-83f5-3615b67dfc22")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nn-gpmgmt-igpmsearchcriteria
interface IGPMSearchCriteria : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmsearchcriteria-add
    HRESULT Add(GPMSearchProperty searchProperty, GPMSearchOperation searchOperation, VARIANT varValue);
}

@GUID("3b466da8-c1a4-4b2a-999a-befcdd56cefb")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nn-gpmgmt-igpmtrustee
interface IGPMTrustee : IDispatch
{
    HRESULT get_TrusteeSid(BSTR* bstrVal);
    HRESULT get_TrusteeName(BSTR* bstrVal);
    HRESULT get_TrusteeDomain(BSTR* bstrVal);
    HRESULT get_TrusteeDSPath(BSTR* pVal);
    HRESULT get_TrusteeType(int* lVal);
}

@GUID("35ebca40-e1a1-4a02-8905-d79416fb464a")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nn-gpmgmt-igpmpermission
interface IGPMPermission : IDispatch
{
    HRESULT get_Inherited(VARIANT_BOOL* pVal);
    HRESULT get_Inheritable(VARIANT_BOOL* pVal);
    HRESULT get_Denied(VARIANT_BOOL* pVal);
    HRESULT get_Permission(GPMPermissionType* pVal);
    HRESULT get_Trustee(IGPMTrustee* ppIGPMTrustee);
}

@GUID("b6c31ed4-1c93-4d3e-ae84-eb6d61161b60")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nn-gpmgmt-igpmsecurityinfo
interface IGPMSecurityInfo : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmsecurityinfo-get_count
    HRESULT get_Count(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmsecurityinfo-get_item
    HRESULT get_Item(int lIndex, VARIANT* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmsecurityinfo-get__newenum
    HRESULT get__NewEnum(IEnumVARIANT* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmsecurityinfo-add
    HRESULT Add(IGPMPermission pPerm);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmsecurityinfo-remove
    HRESULT Remove(IGPMPermission pPerm);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmsecurityinfo-removetrustee
    HRESULT RemoveTrustee(BSTR bstrTrustee);
}

@GUID("d8a16a35-3b0d-416b-8d02-4df6f95a7119")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nn-gpmgmt-igpmbackup
interface IGPMBackup : IDispatch
{
    HRESULT get_ID(BSTR* pVal);
    HRESULT get_GPOID(BSTR* pVal);
    HRESULT get_GPODomain(BSTR* pVal);
    HRESULT get_GPODisplayName(BSTR* pVal);
    HRESULT get_Timestamp(double* pVal);
    HRESULT get_Comment(BSTR* pVal);
    HRESULT get_BackupDir(BSTR* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmbackup-delete
    HRESULT Delete();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmbackup-generatereport
    HRESULT GenerateReport(GPMReportType gpmReportType, VARIANT* pvarGPMProgress, VARIANT* pvarGPMCancel, 
                           IGPMResult* ppIGPMResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmbackup-generatereporttofile
    HRESULT GenerateReportToFile(GPMReportType gpmReportType, BSTR bstrTargetFilePath, IGPMResult* ppIGPMResult);
}

@GUID("c786fc0f-26d8-4bab-a745-39ca7e800cac")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nn-gpmgmt-igpmbackupcollection
interface IGPMBackupCollection : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmbackupcollection-get_count
    HRESULT get_Count(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmbackupcollection-get_item
    HRESULT get_Item(int lIndex, VARIANT* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmbackupcollection-get__newenum
    HRESULT get__NewEnum(IEnumVARIANT* ppIGPMBackup);
}

@GUID("c0a7f09e-05a1-4f0c-8158-9e5c33684f6b")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nn-gpmgmt-igpmsom
interface IGPMSOM : IDispatch
{
    HRESULT get_GPOInheritanceBlocked(VARIANT_BOOL* pVal);
    HRESULT put_GPOInheritanceBlocked(VARIANT_BOOL newVal);
    HRESULT get_Name(BSTR* pVal);
    HRESULT get_Path(BSTR* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmsom-creategpolink
    HRESULT CreateGPOLink(int lLinkPos, IGPMGPO pGPO, IGPMGPOLink* ppNewGPOLink);
    HRESULT get_Type(GPMSOMType* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmsom-getgpolinks
    HRESULT GetGPOLinks(IGPMGPOLinksCollection* ppGPOLinks);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmsom-getinheritedgpolinks
    HRESULT GetInheritedGPOLinks(IGPMGPOLinksCollection* ppGPOLinks);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmsom-getsecurityinfo
    HRESULT GetSecurityInfo(IGPMSecurityInfo* ppSecurityInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmsom-setsecurityinfo
    HRESULT SetSecurityInfo(IGPMSecurityInfo pSecurityInfo);
}

@GUID("adc1688e-00e4-4495-abba-bed200df0cab")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nn-gpmgmt-igpmsomcollection
interface IGPMSOMCollection : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmsomcollection-get_count
    HRESULT get_Count(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmsomcollection-get_item
    HRESULT get_Item(int lIndex, VARIANT* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmsomcollection-get__newenum
    HRESULT get__NewEnum(IEnumVARIANT* ppIGPMSOM);
}

@GUID("ef2ff9b4-3c27-459a-b979-038305cec75d")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nn-gpmgmt-igpmwmifilter
interface IGPMWMIFilter : IDispatch
{
    HRESULT get_Path(BSTR* pVal);
    HRESULT put_Name(BSTR newVal);
    HRESULT get_Name(BSTR* pVal);
    HRESULT put_Description(BSTR newVal);
    HRESULT get_Description(BSTR* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmwmifilter-getquerylist
    HRESULT GetQueryList(VARIANT* pQryList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmwmifilter-getsecurityinfo
    HRESULT GetSecurityInfo(IGPMSecurityInfo* ppSecurityInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmwmifilter-setsecurityinfo
    HRESULT SetSecurityInfo(IGPMSecurityInfo pSecurityInfo);
}

@GUID("5782d582-1a36-4661-8a94-c3c32551945b")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nn-gpmgmt-igpmwmifiltercollection
interface IGPMWMIFilterCollection : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmwmifiltercollection-get_count
    HRESULT get_Count(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmwmifiltercollection-get_item
    HRESULT get_Item(int lIndex, VARIANT* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmwmifiltercollection-get__newenum
    HRESULT get__NewEnum(IEnumVARIANT* pVal);
}

@GUID("49ed785a-3237-4ff2-b1f0-fdf5a8d5a1ee")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nn-gpmgmt-igpmrsop
interface IGPMRSOP : IDispatch
{
    HRESULT get_Mode(GPMRSOPMode* pVal);
    HRESULT get_Namespace(BSTR* bstrVal);
    HRESULT put_LoggingComputer(BSTR bstrVal);
    HRESULT get_LoggingComputer(BSTR* bstrVal);
    HRESULT put_LoggingUser(BSTR bstrVal);
    HRESULT get_LoggingUser(BSTR* bstrVal);
    HRESULT put_LoggingFlags(int lVal);
    HRESULT get_LoggingFlags(int* lVal);
    HRESULT put_PlanningFlags(int lVal);
    HRESULT get_PlanningFlags(int* lVal);
    HRESULT put_PlanningDomainController(BSTR bstrVal);
    HRESULT get_PlanningDomainController(BSTR* bstrVal);
    HRESULT put_PlanningSiteName(BSTR bstrVal);
    HRESULT get_PlanningSiteName(BSTR* bstrVal);
    HRESULT put_PlanningUser(BSTR bstrVal);
    HRESULT get_PlanningUser(BSTR* bstrVal);
    HRESULT put_PlanningUserSOM(BSTR bstrVal);
    HRESULT get_PlanningUserSOM(BSTR* bstrVal);
    HRESULT put_PlanningUserWMIFilters(VARIANT varVal);
    HRESULT get_PlanningUserWMIFilters(VARIANT* varVal);
    HRESULT put_PlanningUserSecurityGroups(VARIANT varVal);
    HRESULT get_PlanningUserSecurityGroups(VARIANT* varVal);
    HRESULT put_PlanningComputer(BSTR bstrVal);
    HRESULT get_PlanningComputer(BSTR* bstrVal);
    HRESULT put_PlanningComputerSOM(BSTR bstrVal);
    HRESULT get_PlanningComputerSOM(BSTR* bstrVal);
    HRESULT put_PlanningComputerWMIFilters(VARIANT varVal);
    HRESULT get_PlanningComputerWMIFilters(VARIANT* varVal);
    HRESULT put_PlanningComputerSecurityGroups(VARIANT varVal);
    HRESULT get_PlanningComputerSecurityGroups(VARIANT* varVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmrsop-loggingenumerateusers
    HRESULT LoggingEnumerateUsers(VARIANT* varVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmrsop-createqueryresults
    HRESULT CreateQueryResults();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmrsop-releasequeryresults
    HRESULT ReleaseQueryResults();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmrsop-generatereport
    HRESULT GenerateReport(GPMReportType gpmReportType, VARIANT* pvarGPMProgress, VARIANT* pvarGPMCancel, 
                           IGPMResult* ppIGPMResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmrsop-generatereporttofile
    HRESULT GenerateReportToFile(GPMReportType gpmReportType, BSTR bstrTargetFilePath, IGPMResult* ppIGPMResult);
}

@GUID("58cc4352-1ca3-48e5-9864-1da4d6e0d60f")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nn-gpmgmt-igpmgpo
interface IGPMGPO : IDispatch
{
    HRESULT get_DisplayName(BSTR* pVal);
    HRESULT put_DisplayName(BSTR newVal);
    HRESULT get_Path(BSTR* pVal);
    HRESULT get_ID(BSTR* pVal);
    HRESULT get_DomainName(BSTR* pVal);
    HRESULT get_CreationTime(double* pDate);
    HRESULT get_ModificationTime(double* pDate);
    HRESULT get_UserDSVersionNumber(int* pVal);
    HRESULT get_ComputerDSVersionNumber(int* pVal);
    HRESULT get_UserSysvolVersionNumber(int* pVal);
    HRESULT get_ComputerSysvolVersionNumber(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmgpo-getwmifilter
    HRESULT GetWMIFilter(IGPMWMIFilter* ppIGPMWMIFilter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmgpo-setwmifilter
    HRESULT SetWMIFilter(IGPMWMIFilter pIGPMWMIFilter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmgpo-setuserenabled
    HRESULT SetUserEnabled(VARIANT_BOOL vbEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmgpo-setcomputerenabled
    HRESULT SetComputerEnabled(VARIANT_BOOL vbEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmgpo-isuserenabled
    HRESULT IsUserEnabled(VARIANT_BOOL* pvbEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmgpo-iscomputerenabled
    HRESULT IsComputerEnabled(VARIANT_BOOL* pvbEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmgpo-getsecurityinfo
    HRESULT GetSecurityInfo(IGPMSecurityInfo* ppSecurityInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmgpo-setsecurityinfo
    HRESULT SetSecurityInfo(IGPMSecurityInfo pSecurityInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmgpo-delete
    HRESULT Delete();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmgpo-backup
    HRESULT Backup(BSTR bstrBackupDir, BSTR bstrComment, VARIANT* pvarGPMProgress, VARIANT* pvarGPMCancel, 
                   IGPMResult* ppIGPMResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmgpo-import
    HRESULT Import(int lFlags, IGPMBackup pIGPMBackup, VARIANT* pvarMigrationTable, VARIANT* pvarGPMProgress, 
                   VARIANT* pvarGPMCancel, IGPMResult* ppIGPMResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmgpo-generatereport
    HRESULT GenerateReport(GPMReportType gpmReportType, VARIANT* pvarGPMProgress, VARIANT* pvarGPMCancel, 
                           IGPMResult* ppIGPMResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmgpo-generatereporttofile
    HRESULT GenerateReportToFile(GPMReportType gpmReportType, BSTR bstrTargetFilePath, IGPMResult* ppIGPMResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmgpo-copyto
    HRESULT CopyTo(int lFlags, IGPMDomain pIGPMDomain, VARIANT* pvarNewDisplayName, VARIANT* pvarMigrationTable, 
                   VARIANT* pvarGPMProgress, VARIANT* pvarGPMCancel, IGPMResult* ppIGPMResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmgpo-setsecuritydescriptor
    HRESULT SetSecurityDescriptor(int lFlags, IDispatch pSD);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmgpo-getsecuritydescriptor
    HRESULT GetSecurityDescriptor(int lFlags, IDispatch* ppSD);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmgpo-isaclconsistent
    HRESULT IsACLConsistent(VARIANT_BOOL* pvbConsistent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmgpo-makeaclconsistent
    HRESULT MakeACLConsistent();
}

@GUID("f0f0d5cf-70ca-4c39-9e29-b642f8726c01")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nn-gpmgmt-igpmgpocollection
interface IGPMGPOCollection : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmgpocollection-get_count
    HRESULT get_Count(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmgpocollection-get_item
    HRESULT get_Item(int lIndex, VARIANT* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmgpocollection-get__newenum
    HRESULT get__NewEnum(IEnumVARIANT* ppIGPMGPOs);
}

@GUID("434b99bd-5de7-478a-809c-c251721df70c")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nn-gpmgmt-igpmgpolink
interface IGPMGPOLink : IDispatch
{
    HRESULT get_GPOID(BSTR* pVal);
    HRESULT get_GPODomain(BSTR* pVal);
    HRESULT get_Enabled(VARIANT_BOOL* pVal);
    HRESULT put_Enabled(VARIANT_BOOL newVal);
    HRESULT get_Enforced(VARIANT_BOOL* pVal);
    HRESULT put_Enforced(VARIANT_BOOL newVal);
    HRESULT get_SOMLinkOrder(int* lVal);
    HRESULT get_SOM(IGPMSOM* ppIGPMSOM);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmgpolink-delete
    HRESULT Delete();
}

@GUID("189d7b68-16bd-4d0d-a2ec-2e6aa2288c7f")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nn-gpmgmt-igpmgpolinkscollection
interface IGPMGPOLinksCollection : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmgpolinkscollection-get_count
    HRESULT get_Count(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmgpolinkscollection-get_item
    HRESULT get_Item(int lIndex, VARIANT* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmgpolinkscollection-get__newenum
    HRESULT get__NewEnum(IEnumVARIANT* ppIGPMLinks);
}

@GUID("2e52a97d-0a4a-4a6f-85db-201622455da0")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nn-gpmgmt-igpmcsecollection
interface IGPMCSECollection : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmcsecollection-get_count
    HRESULT get_Count(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmcsecollection-get_item
    HRESULT get_Item(int lIndex, VARIANT* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmcsecollection-get__newenum
    HRESULT get__NewEnum(IEnumVARIANT* ppIGPMCSEs);
}

@GUID("69da7488-b8db-415e-9266-901be4d49928")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nn-gpmgmt-igpmclientsideextension
interface IGPMClientSideExtension : IDispatch
{
    HRESULT get_ID(BSTR* pVal);
    HRESULT get_DisplayName(BSTR* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmclientsideextension-isuserenabled
    HRESULT IsUserEnabled(VARIANT_BOOL* pvbEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmclientsideextension-iscomputerenabled
    HRESULT IsComputerEnabled(VARIANT_BOOL* pvbEnabled);
}

@GUID("ddc67754-be67-4541-8166-f48166868c9c")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nn-gpmgmt-igpmasynccancel
interface IGPMAsyncCancel : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmasynccancel-cancel
    HRESULT Cancel();
}

@GUID("6aac29f8-5948-4324-bf70-423818942dbc")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nn-gpmgmt-igpmasyncprogress
interface IGPMAsyncProgress : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmasyncprogress-status
    HRESULT Status(int lProgressNumerator, int lProgressDenominator, HRESULT hrStatus, VARIANT* pResult, 
                   IGPMStatusMsgCollection ppIGPMStatusMsgCollection);
}

@GUID("9b6e1af0-1a92-40f3-a59d-f36ac1f728b7")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nn-gpmgmt-igpmstatusmsgcollection
interface IGPMStatusMsgCollection : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmstatusmsgcollection-get_count
    HRESULT get_Count(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmstatusmsgcollection-get_item
    HRESULT get_Item(int lIndex, VARIANT* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmstatusmsgcollection-get__newenum
    HRESULT get__NewEnum(IEnumVARIANT* pVal);
}

@GUID("8496c22f-f3de-4a1f-8f58-603caaa93d7b")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nn-gpmgmt-igpmstatusmessage
interface IGPMStatusMessage : IDispatch
{
    HRESULT get_ObjectPath(BSTR* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmstatusmessage-errorcode
    HRESULT ErrorCode();
    HRESULT get_ExtensionName(BSTR* pVal);
    HRESULT get_SettingsName(BSTR* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmstatusmessage-operationcode
    HRESULT OperationCode();
    HRESULT get_Message(BSTR* pVal);
}

@GUID("50ef73e6-d35c-4c8d-be63-7ea5d2aac5c4")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nn-gpmgmt-igpmconstants
interface IGPMConstants : IDispatch
{
    HRESULT get_PermGPOApply(GPMPermissionType* pVal);
    HRESULT get_PermGPORead(GPMPermissionType* pVal);
    HRESULT get_PermGPOEdit(GPMPermissionType* pVal);
    HRESULT get_PermGPOEditSecurityAndDelete(GPMPermissionType* pVal);
    HRESULT get_PermGPOCustom(GPMPermissionType* pVal);
    HRESULT get_PermWMIFilterEdit(GPMPermissionType* pVal);
    HRESULT get_PermWMIFilterFullControl(GPMPermissionType* pVal);
    HRESULT get_PermWMIFilterCustom(GPMPermissionType* pVal);
    HRESULT get_PermSOMLink(GPMPermissionType* pVal);
    HRESULT get_PermSOMLogging(GPMPermissionType* pVal);
    HRESULT get_PermSOMPlanning(GPMPermissionType* pVal);
    HRESULT get_PermSOMGPOCreate(GPMPermissionType* pVal);
    HRESULT get_PermSOMWMICreate(GPMPermissionType* pVal);
    HRESULT get_PermSOMWMIFullControl(GPMPermissionType* pVal);
    HRESULT get_SearchPropertyGPOPermissions(GPMSearchProperty* pVal);
    HRESULT get_SearchPropertyGPOEffectivePermissions(GPMSearchProperty* pVal);
    HRESULT get_SearchPropertyGPODisplayName(GPMSearchProperty* pVal);
    HRESULT get_SearchPropertyGPOWMIFilter(GPMSearchProperty* pVal);
    HRESULT get_SearchPropertyGPOID(GPMSearchProperty* pVal);
    HRESULT get_SearchPropertyGPOComputerExtensions(GPMSearchProperty* pVal);
    HRESULT get_SearchPropertyGPOUserExtensions(GPMSearchProperty* pVal);
    HRESULT get_SearchPropertySOMLinks(GPMSearchProperty* pVal);
    HRESULT get_SearchPropertyGPODomain(GPMSearchProperty* pVal);
    HRESULT get_SearchPropertyBackupMostRecent(GPMSearchProperty* pVal);
    HRESULT get_SearchOpEquals(GPMSearchOperation* pVal);
    HRESULT get_SearchOpContains(GPMSearchOperation* pVal);
    HRESULT get_SearchOpNotContains(GPMSearchOperation* pVal);
    HRESULT get_SearchOpNotEquals(GPMSearchOperation* pVal);
    HRESULT get_UsePDC(int* pVal);
    HRESULT get_UseAnyDC(int* pVal);
    HRESULT get_DoNotUseW2KDC(int* pVal);
    HRESULT get_SOMSite(GPMSOMType* pVal);
    HRESULT get_SOMDomain(GPMSOMType* pVal);
    HRESULT get_SOMOU(GPMSOMType* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmconstants-get_securityflags
    HRESULT get_SecurityFlags(VARIANT_BOOL vbOwner, VARIANT_BOOL vbGroup, VARIANT_BOOL vbDACL, VARIANT_BOOL vbSACL, 
                              int* pVal);
    HRESULT get_DoNotValidateDC(int* pVal);
    HRESULT get_ReportHTML(GPMReportType* pVal);
    HRESULT get_ReportXML(GPMReportType* pVal);
    HRESULT get_RSOPModeUnknown(GPMRSOPMode* pVal);
    HRESULT get_RSOPModePlanning(GPMRSOPMode* pVal);
    HRESULT get_RSOPModeLogging(GPMRSOPMode* pVal);
    HRESULT get_EntryTypeUser(GPMEntryType* pVal);
    HRESULT get_EntryTypeComputer(GPMEntryType* pVal);
    HRESULT get_EntryTypeLocalGroup(GPMEntryType* pVal);
    HRESULT get_EntryTypeGlobalGroup(GPMEntryType* pVal);
    HRESULT get_EntryTypeUniversalGroup(GPMEntryType* pVal);
    HRESULT get_EntryTypeUNCPath(GPMEntryType* pVal);
    HRESULT get_EntryTypeUnknown(GPMEntryType* pVal);
    HRESULT get_DestinationOptionSameAsSource(GPMDestinationOption* pVal);
    HRESULT get_DestinationOptionNone(GPMDestinationOption* pVal);
    HRESULT get_DestinationOptionByRelativeName(GPMDestinationOption* pVal);
    HRESULT get_DestinationOptionSet(GPMDestinationOption* pVal);
    HRESULT get_MigrationTableOnly(int* pVal);
    HRESULT get_ProcessSecurity(int* pVal);
    HRESULT get_RsopLoggingNoComputer(int* pVal);
    HRESULT get_RsopLoggingNoUser(int* pVal);
    HRESULT get_RsopPlanningAssumeSlowLink(int* pVal);
    HRESULT get_RsopPlanningLoopbackOption(VARIANT_BOOL vbMerge, int* pVal);
    HRESULT get_RsopPlanningAssumeUserWQLFilterTrue(int* pVal);
    HRESULT get_RsopPlanningAssumeCompWQLFilterTrue(int* pVal);
}

@GUID("86dff7e9-f76f-42ab-9570-cebc6be8a52d")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nn-gpmgmt-igpmresult
interface IGPMResult : IDispatch
{
    HRESULT get_Status(IGPMStatusMsgCollection* ppIGPMStatusMsgCollection);
    HRESULT get_Result(VARIANT* pvarResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmresult-overallstatus
    HRESULT OverallStatus();
}

@GUID("bb0bf49b-e53f-443f-b807-8be22bfb6d42")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nn-gpmgmt-igpmmapentrycollection
interface IGPMMapEntryCollection : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmmapentrycollection-get_count
    HRESULT get_Count(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmmapentrycollection-get_item
    HRESULT get_Item(int lIndex, VARIANT* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmmapentrycollection-get__newenum
    HRESULT get__NewEnum(IEnumVARIANT* pVal);
}

@GUID("8e79ad06-2381-4444-be4c-ff693e6e6f2b")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nn-gpmgmt-igpmmapentry
interface IGPMMapEntry : IDispatch
{
    HRESULT get_Source(BSTR* pbstrSource);
    HRESULT get_Destination(BSTR* pbstrDestination);
    HRESULT get_DestinationOption(GPMDestinationOption* pgpmDestOption);
    HRESULT get_EntryType(GPMEntryType* pgpmEntryType);
}

@GUID("48f823b1-efaf-470b-b6ed-40d14ee1a4ec")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nn-gpmgmt-igpmmigrationtable
interface IGPMMigrationTable : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmmigrationtable-save
    HRESULT Save(BSTR bstrMigrationTablePath);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmmigrationtable-add
    HRESULT Add(int lFlags, VARIANT var);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmmigrationtable-addentry
    HRESULT AddEntry(BSTR bstrSource, GPMEntryType gpmEntryType, VARIANT* pvarDestination, IGPMMapEntry* ppEntry);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmmigrationtable-getentry
    HRESULT GetEntry(BSTR bstrSource, IGPMMapEntry* ppEntry);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmmigrationtable-deleteentry
    HRESULT DeleteEntry(BSTR bstrSource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmmigrationtable-updatedestination
    HRESULT UpdateDestination(BSTR bstrSource, VARIANT* pvarDestination, IGPMMapEntry* ppEntry);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmmigrationtable-validate
    HRESULT Validate(IGPMResult* ppResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmmigrationtable-getentries
    HRESULT GetEntries(IGPMMapEntryCollection* ppEntries);
}

@GUID("f8dc55ed-3ba0-4864-aad4-d365189ee1d5")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nn-gpmgmt-igpmbackupdirex
interface IGPMBackupDirEx : IDispatch
{
    HRESULT get_BackupDir(BSTR* pbstrBackupDir);
    HRESULT get_BackupType(GPMBackupType* pgpmBackupType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmbackupdirex-getbackup
    HRESULT GetBackup(BSTR bstrID, VARIANT* pvarBackup);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmbackupdirex-searchbackups
    HRESULT SearchBackups(IGPMSearchCriteria pIGPMSearchCriteria, VARIANT* pvarBackupCollection);
}

@GUID("c998031d-add0-4bb5-8dea-298505d8423b")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nn-gpmgmt-igpmstartergpobackupcollection
interface IGPMStarterGPOBackupCollection : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmstartergpobackupcollection-get_count
    HRESULT get_Count(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmstartergpobackupcollection-get_item
    HRESULT get_Item(int lIndex, VARIANT* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmstartergpobackupcollection-get__newenum
    HRESULT get__NewEnum(IEnumVARIANT* ppIGPMTmplBackup);
}

@GUID("51d98eda-a87e-43dd-b80a-0b66ef1938d6")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nn-gpmgmt-igpmstartergpobackup
interface IGPMStarterGPOBackup : IDispatch
{
    HRESULT get_BackupDir(BSTR* pbstrBackupDir);
    HRESULT get_Comment(BSTR* pbstrComment);
    HRESULT get_DisplayName(BSTR* pbstrDisplayName);
    HRESULT get_Domain(BSTR* pbstrTemplateDomain);
    HRESULT get_StarterGPOID(BSTR* pbstrTemplateID);
    HRESULT get_ID(BSTR* pbstrID);
    HRESULT get_Timestamp(double* pTimestamp);
    HRESULT get_Type(GPMStarterGPOType* pType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmstartergpobackup-delete
    HRESULT Delete();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmstartergpobackup-generatereport
    HRESULT GenerateReport(GPMReportType gpmReportType, VARIANT* pvarGPMProgress, VARIANT* pvarGPMCancel, 
                           IGPMResult* ppIGPMResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmstartergpobackup-generatereporttofile
    HRESULT GenerateReportToFile(GPMReportType gpmReportType, BSTR bstrTargetFilePath, IGPMResult* ppIGPMResult);
}

@GUID("00238f8a-3d86-41ac-8f5e-06a6638a634a")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nn-gpmgmt-igpm2
interface IGPM2 : IGPM
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpm2-getbackupdirex
    HRESULT GetBackupDirEx(BSTR bstrBackupDir, GPMBackupType backupDirType, IGPMBackupDirEx* ppIGPMBackupDirEx);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpm2-initializereportingex
    HRESULT InitializeReportingEx(BSTR bstrAdmPath, int reportingOptions);
}

@GUID("dfc3f61b-8880-4490-9337-d29c7ba8c2f0")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nn-gpmgmt-igpmstartergpo
interface IGPMStarterGPO : IDispatch
{
    HRESULT get_DisplayName(BSTR* pVal);
    HRESULT put_DisplayName(BSTR newVal);
    HRESULT get_Description(BSTR* pVal);
    HRESULT put_Description(BSTR newVal);
    HRESULT get_Author(BSTR* pVal);
    HRESULT get_Product(BSTR* pVal);
    HRESULT get_CreationTime(double* pVal);
    HRESULT get_ID(BSTR* pVal);
    HRESULT get_ModifiedTime(double* pVal);
    HRESULT get_Type(GPMStarterGPOType* pVal);
    HRESULT get_ComputerVersion(ushort* pVal);
    HRESULT get_UserVersion(ushort* pVal);
    HRESULT get_StarterGPOVersion(BSTR* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmstartergpo-delete
    HRESULT Delete();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmstartergpo-save
    HRESULT Save(BSTR bstrSaveFile, VARIANT_BOOL bOverwrite, VARIANT_BOOL bSaveAsSystem, VARIANT* bstrLanguage, 
                 VARIANT* bstrAuthor, VARIANT* bstrProduct, VARIANT* bstrUniqueID, VARIANT* bstrVersion, 
                 VARIANT* pvarGPMProgress, VARIANT* pvarGPMCancel, IGPMResult* ppIGPMResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmstartergpo-backup
    HRESULT Backup(BSTR bstrBackupDir, BSTR bstrComment, VARIANT* pvarGPMProgress, VARIANT* pvarGPMCancel, 
                   IGPMResult* ppIGPMResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmstartergpo-copyto
    HRESULT CopyTo(VARIANT* pvarNewDisplayName, VARIANT* pvarGPMProgress, VARIANT* pvarGPMCancel, 
                   IGPMResult* ppIGPMResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmstartergpo-generatereport
    HRESULT GenerateReport(GPMReportType gpmReportType, VARIANT* pvarGPMProgress, VARIANT* pvarGPMCancel, 
                           IGPMResult* ppIGPMResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmstartergpo-generatereporttofile
    HRESULT GenerateReportToFile(GPMReportType gpmReportType, BSTR bstrTargetFilePath, IGPMResult* ppIGPMResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmstartergpo-getsecurityinfo
    HRESULT GetSecurityInfo(IGPMSecurityInfo* ppSecurityInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmstartergpo-setsecurityinfo
    HRESULT SetSecurityInfo(IGPMSecurityInfo pSecurityInfo);
}

@GUID("2e522729-2219-44ad-933a-64dfd650c423")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nn-gpmgmt-igpmstartergpocollection
interface IGPMStarterGPOCollection : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmstartergpocollection-get_count
    HRESULT get_Count(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmstartergpocollection-get_item
    HRESULT get_Item(int lIndex, VARIANT* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmstartergpocollection-get__newenum
    HRESULT get__NewEnum(IEnumVARIANT* ppIGPMTemplates);
}

@GUID("7ca6bb8b-f1eb-490a-938d-3c4e51c768e6")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nn-gpmgmt-igpmdomain2
interface IGPMDomain2 : IGPMDomain
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmdomain2-createstartergpo
    HRESULT CreateStarterGPO(IGPMStarterGPO* ppnewTemplate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmdomain2-creategpofromstartergpo
    HRESULT CreateGPOFromStarterGPO(IGPMStarterGPO pGPOTemplate, IGPMGPO* ppnewGPO);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmdomain2-getstartergpo
    HRESULT GetStarterGPO(BSTR bstrGuid, IGPMStarterGPO* ppTemplate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmdomain2-searchstartergpos
    HRESULT SearchStarterGPOs(IGPMSearchCriteria pIGPMSearchCriteria, 
                              IGPMStarterGPOCollection* ppIGPMTemplateCollection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmdomain2-loadstartergpo
    HRESULT LoadStarterGPO(BSTR bstrLoadFile, VARIANT_BOOL bOverwrite, VARIANT* pvarGPMProgress, 
                           VARIANT* pvarGPMCancel, IGPMResult* ppIGPMResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nf-gpmgmt-igpmdomain2-restorestartergpo
    HRESULT RestoreStarterGPO(IGPMStarterGPOBackup pIGPMTmplBackup, VARIANT* pvarGPMProgress, 
                              VARIANT* pvarGPMCancel, IGPMResult* ppIGPMResult);
}

@GUID("05ae21b0-ac09-4032-a26f-9e7da786dc19")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nn-gpmgmt-igpmconstants2
interface IGPMConstants2 : IGPMConstants
{
    HRESULT get_BackupTypeGPO(GPMBackupType* pVal);
    HRESULT get_BackupTypeStarterGPO(GPMBackupType* pVal);
    HRESULT get_StarterGPOTypeSystem(GPMStarterGPOType* pVal);
    HRESULT get_StarterGPOTypeCustom(GPMStarterGPOType* pVal);
    HRESULT get_SearchPropertyStarterGPOPermissions(GPMSearchProperty* pVal);
    HRESULT get_SearchPropertyStarterGPOEffectivePermissions(GPMSearchProperty* pVal);
    HRESULT get_SearchPropertyStarterGPODisplayName(GPMSearchProperty* pVal);
    HRESULT get_SearchPropertyStarterGPOID(GPMSearchProperty* pVal);
    HRESULT get_SearchPropertyStarterGPODomain(GPMSearchProperty* pVal);
    HRESULT get_PermStarterGPORead(GPMPermissionType* pVal);
    HRESULT get_PermStarterGPOEdit(GPMPermissionType* pVal);
    HRESULT get_PermStarterGPOFullControl(GPMPermissionType* pVal);
    HRESULT get_PermStarterGPOCustom(GPMPermissionType* pVal);
    HRESULT get_ReportLegacy(GPMReportingOptions* pVal);
    HRESULT get_ReportComments(GPMReportingOptions* pVal);
}

@GUID("8a66a210-b78b-4d99-88e2-c306a817c925")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpmgmt/nn-gpmgmt-igpmgpo2
interface IGPMGPO2 : IGPMGPO
{
    HRESULT get_Description(BSTR* pVal);
    HRESULT put_Description(BSTR newVal);
}

@GUID("0077fdfe-88c7-4acf-a11d-d10a7c310a03")
interface IGPMDomain3 : IGPMDomain2
{
    HRESULT GenerateReport(GPMReportType gpmReportType, VARIANT* pvarGPMProgress, VARIANT* pvarGPMCancel, 
                           IGPMResult* ppIGPMResult);
    HRESULT get_InfrastructureDC(BSTR* pVal);
    HRESULT put_InfrastructureDC(BSTR newVal);
    HRESULT put_InfrastructureFlags(uint dwFlags);
}

@GUID("7cf123a1-f94a-4112-bfae-6aa1db9cb248")
interface IGPMGPO3 : IGPMGPO2
{
    HRESULT get_InfrastructureDC(BSTR* pVal);
    HRESULT put_InfrastructureDC(BSTR newVal);
    HRESULT put_InfrastructureFlags(uint dwFlags);
}

@GUID("8fc0b735-a0e1-11d1-a7d3-0000f87571e3")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpedit/nn-gpedit-igpeinformation
interface IGPEInformation : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpedit/nf-gpedit-igpeinformation-getname
    HRESULT GetName(PWSTR pszName, int cchMaxLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpedit/nf-gpedit-igpeinformation-getdisplayname
    HRESULT GetDisplayName(PWSTR pszName, int cchMaxLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpedit/nf-gpedit-igpeinformation-getregistrykey
    HRESULT GetRegistryKey(uint dwSection, HKEY* hKey);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpedit/nf-gpedit-igpeinformation-getdspath
    HRESULT GetDSPath(uint dwSection, PWSTR pszPath, int cchMaxPath);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpedit/nf-gpedit-igpeinformation-getfilesyspath
    HRESULT GetFileSysPath(uint dwSection, PWSTR pszPath, int cchMaxPath);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpedit/nf-gpedit-igpeinformation-getoptions
    HRESULT GetOptions(uint* dwOptions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpedit/nf-gpedit-igpeinformation-gettype
    HRESULT GetType(GROUP_POLICY_OBJECT_TYPE* gpoType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpedit/nf-gpedit-igpeinformation-gethint
    HRESULT GetHint(GROUP_POLICY_HINT_TYPE* gpHint);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpedit/nf-gpedit-igpeinformation-policychanged
    HRESULT PolicyChanged(BOOL bMachine, BOOL bAdd, GUID* pGuidExtension, GUID* pGuidSnapin);
}

@GUID("ea502723-a23d-11d1-a7d3-0000f87571e3")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpedit/nn-gpedit-igrouppolicyobject
interface IGroupPolicyObject : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpedit/nf-gpedit-igrouppolicyobject-new
    HRESULT New(PWSTR pszDomainName, PWSTR pszDisplayName, uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpedit/nf-gpedit-igrouppolicyobject-opendsgpo
    HRESULT OpenDSGPO(PWSTR pszPath, GPO_OPEN_FLAGS dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpedit/nf-gpedit-igrouppolicyobject-openlocalmachinegpo
    HRESULT OpenLocalMachineGPO(GPO_OPEN_FLAGS dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpedit/nf-gpedit-igrouppolicyobject-openremotemachinegpo
    HRESULT OpenRemoteMachineGPO(PWSTR pszComputerName, GPO_OPEN_FLAGS dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpedit/nf-gpedit-igrouppolicyobject-save
    HRESULT Save(BOOL bMachine, BOOL bAdd, GUID* pGuidExtension, GUID* pGuid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpedit/nf-gpedit-igrouppolicyobject-delete
    HRESULT Delete();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpedit/nf-gpedit-igrouppolicyobject-getname
    HRESULT GetName(PWSTR pszName, int cchMaxLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpedit/nf-gpedit-igrouppolicyobject-getdisplayname
    HRESULT GetDisplayName(PWSTR pszName, int cchMaxLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpedit/nf-gpedit-igrouppolicyobject-setdisplayname
    HRESULT SetDisplayName(PWSTR pszName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpedit/nf-gpedit-igrouppolicyobject-getpath
    HRESULT GetPath(PWSTR pszPath, int cchMaxLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpedit/nf-gpedit-igrouppolicyobject-getdspath
    HRESULT GetDSPath(uint dwSection, PWSTR pszPath, int cchMaxPath);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpedit/nf-gpedit-igrouppolicyobject-getfilesyspath
    HRESULT GetFileSysPath(uint dwSection, PWSTR pszPath, int cchMaxPath);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpedit/nf-gpedit-igrouppolicyobject-getregistrykey
    HRESULT GetRegistryKey(GPO_SECTION dwSection, HKEY* hKey);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpedit/nf-gpedit-igrouppolicyobject-getoptions
    HRESULT GetOptions(GPO_OPTIONS* dwOptions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpedit/nf-gpedit-igrouppolicyobject-setoptions
    HRESULT SetOptions(GPO_OPTIONS dwOptions, uint dwMask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpedit/nf-gpedit-igrouppolicyobject-gettype
    HRESULT GetType(GROUP_POLICY_OBJECT_TYPE* gpoType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpedit/nf-gpedit-igrouppolicyobject-getmachinename
    HRESULT GetMachineName(PWSTR pszName, int cchMaxLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpedit/nf-gpedit-igrouppolicyobject-getpropertysheetpages
    HRESULT GetPropertySheetPages(HPROPSHEETPAGE** hPages, uint* uPageCount);
}

@GUID("9a5a81b5-d9c7-49ef-9d11-ddf50968c48d")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpedit/nn-gpedit-irsopinformation
interface IRSOPInformation : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpedit/nf-gpedit-irsopinformation-getnamespace
    HRESULT GetNamespace(uint dwSection, PWSTR pszName, int cchMaxLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpedit/nf-gpedit-irsopinformation-getflags
    HRESULT GetFlags(uint* pdwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gpedit/nf-gpedit-irsopinformation-geteventlogentrytext
    HRESULT GetEventLogEntryText(PWSTR pszEventSource, PWSTR pszEventLogName, PWSTR pszEventTime, uint dwEventID, 
                                 PWSTR* ppszText);
}


// GUIDs

const GUID CLSID_GPM                           = GUIDOF!GPM;
const GUID CLSID_GPMAsyncCancel                = GUIDOF!GPMAsyncCancel;
const GUID CLSID_GPMBackup                     = GUIDOF!GPMBackup;
const GUID CLSID_GPMBackupCollection           = GUIDOF!GPMBackupCollection;
const GUID CLSID_GPMBackupDir                  = GUIDOF!GPMBackupDir;
const GUID CLSID_GPMBackupDirEx                = GUIDOF!GPMBackupDirEx;
const GUID CLSID_GPMCSECollection              = GUIDOF!GPMCSECollection;
const GUID CLSID_GPMClientSideExtension        = GUIDOF!GPMClientSideExtension;
const GUID CLSID_GPMConstants                  = GUIDOF!GPMConstants;
const GUID CLSID_GPMDomain                     = GUIDOF!GPMDomain;
const GUID CLSID_GPMGPO                        = GUIDOF!GPMGPO;
const GUID CLSID_GPMGPOCollection              = GUIDOF!GPMGPOCollection;
const GUID CLSID_GPMGPOLink                    = GUIDOF!GPMGPOLink;
const GUID CLSID_GPMGPOLinksCollection         = GUIDOF!GPMGPOLinksCollection;
const GUID CLSID_GPMMapEntry                   = GUIDOF!GPMMapEntry;
const GUID CLSID_GPMMapEntryCollection         = GUIDOF!GPMMapEntryCollection;
const GUID CLSID_GPMMigrationTable             = GUIDOF!GPMMigrationTable;
const GUID CLSID_GPMPermission                 = GUIDOF!GPMPermission;
const GUID CLSID_GPMRSOP                       = GUIDOF!GPMRSOP;
const GUID CLSID_GPMResult                     = GUIDOF!GPMResult;
const GUID CLSID_GPMSOM                        = GUIDOF!GPMSOM;
const GUID CLSID_GPMSOMCollection              = GUIDOF!GPMSOMCollection;
const GUID CLSID_GPMSearchCriteria             = GUIDOF!GPMSearchCriteria;
const GUID CLSID_GPMSecurityInfo               = GUIDOF!GPMSecurityInfo;
const GUID CLSID_GPMSitesContainer             = GUIDOF!GPMSitesContainer;
const GUID CLSID_GPMStarterGPOBackup           = GUIDOF!GPMStarterGPOBackup;
const GUID CLSID_GPMStarterGPOBackupCollection = GUIDOF!GPMStarterGPOBackupCollection;
const GUID CLSID_GPMStarterGPOCollection       = GUIDOF!GPMStarterGPOCollection;
const GUID CLSID_GPMStatusMessage              = GUIDOF!GPMStatusMessage;
const GUID CLSID_GPMStatusMsgCollection        = GUIDOF!GPMStatusMsgCollection;
const GUID CLSID_GPMTemplate                   = GUIDOF!GPMTemplate;
const GUID CLSID_GPMTrustee                    = GUIDOF!GPMTrustee;
const GUID CLSID_GPMWMIFilter                  = GUIDOF!GPMWMIFilter;
const GUID CLSID_GPMWMIFilterCollection        = GUIDOF!GPMWMIFilterCollection;

const GUID IID_IGPEInformation                = GUIDOF!IGPEInformation;
const GUID IID_IGPM                           = GUIDOF!IGPM;
const GUID IID_IGPM2                          = GUIDOF!IGPM2;
const GUID IID_IGPMAsyncCancel                = GUIDOF!IGPMAsyncCancel;
const GUID IID_IGPMAsyncProgress              = GUIDOF!IGPMAsyncProgress;
const GUID IID_IGPMBackup                     = GUIDOF!IGPMBackup;
const GUID IID_IGPMBackupCollection           = GUIDOF!IGPMBackupCollection;
const GUID IID_IGPMBackupDir                  = GUIDOF!IGPMBackupDir;
const GUID IID_IGPMBackupDirEx                = GUIDOF!IGPMBackupDirEx;
const GUID IID_IGPMCSECollection              = GUIDOF!IGPMCSECollection;
const GUID IID_IGPMClientSideExtension        = GUIDOF!IGPMClientSideExtension;
const GUID IID_IGPMConstants                  = GUIDOF!IGPMConstants;
const GUID IID_IGPMConstants2                 = GUIDOF!IGPMConstants2;
const GUID IID_IGPMDomain                     = GUIDOF!IGPMDomain;
const GUID IID_IGPMDomain2                    = GUIDOF!IGPMDomain2;
const GUID IID_IGPMDomain3                    = GUIDOF!IGPMDomain3;
const GUID IID_IGPMGPO                        = GUIDOF!IGPMGPO;
const GUID IID_IGPMGPO2                       = GUIDOF!IGPMGPO2;
const GUID IID_IGPMGPO3                       = GUIDOF!IGPMGPO3;
const GUID IID_IGPMGPOCollection              = GUIDOF!IGPMGPOCollection;
const GUID IID_IGPMGPOLink                    = GUIDOF!IGPMGPOLink;
const GUID IID_IGPMGPOLinksCollection         = GUIDOF!IGPMGPOLinksCollection;
const GUID IID_IGPMMapEntry                   = GUIDOF!IGPMMapEntry;
const GUID IID_IGPMMapEntryCollection         = GUIDOF!IGPMMapEntryCollection;
const GUID IID_IGPMMigrationTable             = GUIDOF!IGPMMigrationTable;
const GUID IID_IGPMPermission                 = GUIDOF!IGPMPermission;
const GUID IID_IGPMRSOP                       = GUIDOF!IGPMRSOP;
const GUID IID_IGPMResult                     = GUIDOF!IGPMResult;
const GUID IID_IGPMSOM                        = GUIDOF!IGPMSOM;
const GUID IID_IGPMSOMCollection              = GUIDOF!IGPMSOMCollection;
const GUID IID_IGPMSearchCriteria             = GUIDOF!IGPMSearchCriteria;
const GUID IID_IGPMSecurityInfo               = GUIDOF!IGPMSecurityInfo;
const GUID IID_IGPMSitesContainer             = GUIDOF!IGPMSitesContainer;
const GUID IID_IGPMStarterGPO                 = GUIDOF!IGPMStarterGPO;
const GUID IID_IGPMStarterGPOBackup           = GUIDOF!IGPMStarterGPOBackup;
const GUID IID_IGPMStarterGPOBackupCollection = GUIDOF!IGPMStarterGPOBackupCollection;
const GUID IID_IGPMStarterGPOCollection       = GUIDOF!IGPMStarterGPOCollection;
const GUID IID_IGPMStatusMessage              = GUIDOF!IGPMStatusMessage;
const GUID IID_IGPMStatusMsgCollection        = GUIDOF!IGPMStatusMsgCollection;
const GUID IID_IGPMTrustee                    = GUIDOF!IGPMTrustee;
const GUID IID_IGPMWMIFilter                  = GUIDOF!IGPMWMIFilter;
const GUID IID_IGPMWMIFilterCollection        = GUIDOF!IGPMWMIFilterCollection;
const GUID IID_IGroupPolicyObject             = GUIDOF!IGroupPolicyObject;
const GUID IID_IRSOPInformation               = GUIDOF!IRSOPInformation;
