// Written in the D programming language.

module windows.win32.storage.filehistory;

public import windows.core;
public import windows.win32.foundation : BOOL, BSTR, FILETIME, HRESULT;
public import windows.win32.system.com : IUnknown;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fhcfg/ne-fhcfg-fh_target_property_type
alias FH_TARGET_PROPERTY_TYPE = int;
enum : int
{
    FH_TARGET_NAME       = 0x00000000,
    FH_TARGET_URL        = 0x00000001,
    FH_TARGET_DRIVE_TYPE = 0x00000002,
    MAX_TARGET_PROPERTY  = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fhcfg/ne-fhcfg-fh_target_drive_types
alias FH_TARGET_DRIVE_TYPES = int;
enum : int
{
    FH_DRIVE_UNKNOWN   = 0x00000000,
    FH_DRIVE_REMOVABLE = 0x00000002,
    FH_DRIVE_FIXED     = 0x00000003,
    FH_DRIVE_REMOTE    = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fhcfg/ne-fhcfg-fh_protected_item_category
alias FH_PROTECTED_ITEM_CATEGORY = int;
enum : int
{
    FH_FOLDER                   = 0x00000000,
    FH_LIBRARY                  = 0x00000001,
    MAX_PROTECTED_ITEM_CATEGORY = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fhcfg/ne-fhcfg-fh_local_policy_type
alias FH_LOCAL_POLICY_TYPE = int;
enum : int
{
    FH_FREQUENCY      = 0x00000000,
    FH_RETENTION_TYPE = 0x00000001,
    FH_RETENTION_AGE  = 0x00000002,
    MAX_LOCAL_POLICY  = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fhcfg/ne-fhcfg-fh_retention_types
alias FH_RETENTION_TYPES = int;
enum : int
{
    FH_RETENTION_DISABLED  = 0x00000000,
    FH_RETENTION_UNLIMITED = 0x00000001,
    FH_RETENTION_AGE_BASED = 0x00000002,
    MAX_RETENTION_TYPE     = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fhcfg/ne-fhcfg-fh_backup_status
alias FH_BACKUP_STATUS = int;
enum : int
{
    FH_STATUS_DISABLED       = 0x00000000,
    FH_STATUS_DISABLED_BY_GP = 0x00000001,
    FH_STATUS_ENABLED        = 0x00000002,
    FH_STATUS_REHYDRATING    = 0x00000003,
    MAX_BACKUP_STATUS        = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fhcfg/ne-fhcfg-fh_device_validation_result
alias FH_DEVICE_VALIDATION_RESULT = int;
enum : int
{
    FH_ACCESS_DENIED          = 0x00000000,
    FH_INVALID_DRIVE_TYPE     = 0x00000001,
    FH_READ_ONLY_PERMISSION   = 0x00000002,
    FH_CURRENT_DEFAULT        = 0x00000003,
    FH_NAMESPACE_EXISTS       = 0x00000004,
    FH_TARGET_PART_OF_LIBRARY = 0x00000005,
    FH_VALID_TARGET           = 0x00000006,
    MAX_VALIDATION_RESULT     = 0x00000007,
}

enum FhBackupStopReason : int
{
    BackupInvalidStopReason        = 0x00000000,
    BackupLimitUserBusyMachineOnAC = 0x00000001,
    BackupLimitUserIdleMachineOnDC = 0x00000002,
    BackupLimitUserBusyMachineOnDC = 0x00000003,
    BackupCancelled                = 0x00000004,
}

// Constants


enum HRESULT FHCFG_E_CORRUPT_CONFIG_FILE = HRESULT(0x80040300);

enum : HRESULT
{
    FHCFG_E_CONFIG_FILE_NOT_FOUND = HRESULT(0x80040301),
    FHCFG_E_CONFIG_ALREADY_EXISTS = HRESULT(0x80040302),
}

enum HRESULT FHCFG_E_NO_VALID_CONFIGURATION_LOADED = HRESULT(0x80040303);
enum HRESULT FHCFG_E_TARGET_NOT_CONNECTED = HRESULT(0x80040304);
enum HRESULT FHCFG_E_CONFIGURATION_PREVIOUSLY_LOADED = HRESULT(0x80040305);

enum : HRESULT
{
    FHCFG_E_TARGET_VERIFICATION_FAILED   = HRESULT(0x80040306),
    FHCFG_E_TARGET_NOT_CONFIGURED        = HRESULT(0x80040307),
    FHCFG_E_TARGET_NOT_ENOUGH_FREE_SPACE = HRESULT(0x80040308),
    FHCFG_E_TARGET_CANNOT_BE_USED        = HRESULT(0x80040309),
}

enum HRESULT FHCFG_E_INVALID_REHYDRATION_STATE = HRESULT(0x8004030a);
enum HRESULT FHCFG_E_RECOMMENDATION_CHANGE_NOT_ALLOWED = HRESULT(0x80040310);
enum HRESULT FHCFG_E_TARGET_REHYDRATED_ELSEWHERE = HRESULT(0x80040311);

enum : HRESULT
{
    FHCFG_E_LEGACY_TARGET_UNSUPPORTED            = HRESULT(0x80040312),
    FHCFG_E_LEGACY_TARGET_VALIDATION_UNSUPPORTED = HRESULT(0x80040313),
}

enum : HRESULT
{
    FHCFG_E_LEGACY_BACKUP_USER_EXCLUDED = HRESULT(0x80040314),
    FHCFG_E_LEGACY_BACKUP_NOT_FOUND     = HRESULT(0x80040315),
}

enum HRESULT FHSVC_E_BACKUP_BLOCKED = HRESULT(0x80040600);
enum HRESULT FHSVC_E_NOT_CONFIGURED = HRESULT(0x80040601);

enum : HRESULT
{
    FHSVC_E_CONFIG_DISABLED    = HRESULT(0x80040602),
    FHSVC_E_CONFIG_DISABLED_GP = HRESULT(0x80040603),
}

enum HRESULT FHSVC_E_FATAL_CONFIG_ERROR = HRESULT(0x80040604);
enum HRESULT FHSVC_E_CONFIG_REHYDRATING = HRESULT(0x80040605);

enum : uint
{
    FH_STATE_NOT_TRACKED    = 0x00000000U,
    FH_STATE_OFF            = 0x00000001U,
    FH_STATE_DISABLED_BY_GP = 0x00000002U,
}

enum uint FH_STATE_FATAL_CONFIG_ERROR = 0x00000003U;

enum : uint
{
    FH_STATE_MIGRATING                      = 0x00000004U,
    FH_STATE_REHYDRATING                    = 0x00000005U,
    FH_STATE_TARGET_FS_LIMITATION           = 0x0000000dU,
    FH_STATE_TARGET_ACCESS_DENIED           = 0x0000000eU,
    FH_STATE_TARGET_VOLUME_DIRTY            = 0x0000000fU,
    FH_STATE_TARGET_FULL_RETENTION_MAX      = 0x00000010U,
    FH_STATE_TARGET_FULL                    = 0x00000011U,
    FH_STATE_STAGING_FULL                   = 0x00000012U,
    FH_STATE_TARGET_LOW_SPACE_RETENTION_MAX = 0x00000013U,
    FH_STATE_TARGET_LOW_SPACE               = 0x00000014U,
    FH_STATE_TARGET_ABSENT                  = 0x00000015U,
    FH_STATE_TOO_MUCH_BEHIND                = 0x000000f0U,
}

enum : uint
{
    FH_STATE_NO_ERROR             = 0x000000ffU,
    FH_STATE_BACKUP_NOT_SUPPORTED = 0x00000810U,
}

enum uint FH_STATE_RUNNING = 0x00000100U;

// Structs


@RAIIFree!FhServiceClosePipe
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct FH_SERVICE_PIPE_HANDLE
{
    void* Value;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("fhsvcctl.dll")
HRESULT FhServiceOpenPipe(BOOL StartServiceIfStopped, FH_SERVICE_PIPE_HANDLE* Pipe);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("fhsvcctl.dll")
HRESULT FhServiceClosePipe(FH_SERVICE_PIPE_HANDLE Pipe);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("fhsvcctl.dll")
HRESULT FhServiceStartBackup(FH_SERVICE_PIPE_HANDLE Pipe, BOOL LowPriorityIo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("fhsvcctl.dll")
HRESULT FhServiceStopBackup(FH_SERVICE_PIPE_HANDLE Pipe, BOOL StopTracking);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("fhsvcctl.dll")
HRESULT FhServiceReloadConfiguration(FH_SERVICE_PIPE_HANDLE Pipe);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("fhsvcctl.dll")
HRESULT FhServiceBlockBackup(FH_SERVICE_PIPE_HANDLE Pipe);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("fhsvcctl.dll")
HRESULT FhServiceUnblockBackup(FH_SERVICE_PIPE_HANDLE Pipe);


// Interfaces

// Microsoft documentation: https://learn.microsoft.com/windows/win32/DevNotes/fhconfigmgr
@GUID("ed43bb3c-09e9-498a-9df6-2177244c6db4")
struct FhConfigMgr;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/DevNotes/fhreassociation
@GUID("4d728e35-16fa-4320-9e8b-bfd7100a8846")
struct FhReassociation;

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fhcfg/nn-fhcfg-ifhtarget
@GUID("d87965fd-2bad-4657-bd3b-9567eb300ced")
interface IFhTarget : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fhcfg/nf-fhcfg-ifhtarget-getstringproperty
    HRESULT GetStringProperty(FH_TARGET_PROPERTY_TYPE PropertyType, BSTR* PropertyValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fhcfg/nf-fhcfg-ifhtarget-getnumericalproperty
    HRESULT GetNumericalProperty(FH_TARGET_PROPERTY_TYPE PropertyType, ulong* PropertyValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fhcfg/nn-fhcfg-ifhscopeiterator
@GUID("3197abce-532a-44c6-8615-f3666566a720")
interface IFhScopeIterator : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fhcfg/nf-fhcfg-ifhscopeiterator-movetonextitem
    HRESULT MoveToNextItem();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fhcfg/nf-fhcfg-ifhscopeiterator-getitem
    HRESULT GetItem(BSTR* Item);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fhcfg/nn-fhcfg-ifhconfigmgr
@GUID("6a5fea5b-bf8f-4ee5-b8c3-44d8a0d7331c")
interface IFhConfigMgr : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fhcfg/nf-fhcfg-ifhconfigmgr-loadconfiguration
    HRESULT LoadConfiguration();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fhcfg/nf-fhcfg-ifhconfigmgr-createdefaultconfiguration
    HRESULT CreateDefaultConfiguration(BOOL OverwriteIfExists);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fhcfg/nf-fhcfg-ifhconfigmgr-saveconfiguration
    HRESULT SaveConfiguration();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fhcfg/nf-fhcfg-ifhconfigmgr-addremoveexcluderule
    HRESULT AddRemoveExcludeRule(BOOL Add, FH_PROTECTED_ITEM_CATEGORY Category, BSTR Item);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fhcfg/nf-fhcfg-ifhconfigmgr-getincludeexcluderules
    HRESULT GetIncludeExcludeRules(BOOL Include, FH_PROTECTED_ITEM_CATEGORY Category, IFhScopeIterator* Iterator);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fhcfg/nf-fhcfg-ifhconfigmgr-getlocalpolicy
    HRESULT GetLocalPolicy(FH_LOCAL_POLICY_TYPE LocalPolicyType, ulong* PolicyValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fhcfg/nf-fhcfg-ifhconfigmgr-setlocalpolicy
    HRESULT SetLocalPolicy(FH_LOCAL_POLICY_TYPE LocalPolicyType, ulong PolicyValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fhcfg/nf-fhcfg-ifhconfigmgr-getbackupstatus
    HRESULT GetBackupStatus(FH_BACKUP_STATUS* BackupStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fhcfg/nf-fhcfg-ifhconfigmgr-setbackupstatus
    HRESULT SetBackupStatus(FH_BACKUP_STATUS BackupStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fhcfg/nf-fhcfg-ifhconfigmgr-getdefaulttarget
    HRESULT GetDefaultTarget(IFhTarget* DefaultTarget);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fhcfg/nf-fhcfg-ifhconfigmgr-validatetarget
    HRESULT ValidateTarget(BSTR TargetUrl, FH_DEVICE_VALIDATION_RESULT* ValidationResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fhcfg/nf-fhcfg-ifhconfigmgr-provisionandsetnewtarget
    HRESULT ProvisionAndSetNewTarget(BSTR TargetUrl, BSTR TargetName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fhcfg/nf-fhcfg-ifhconfigmgr-changedefaulttargetrecommendation
    HRESULT ChangeDefaultTargetRecommendation(BOOL Recommend);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fhcfg/nf-fhcfg-ifhconfigmgr-queryprotectionstatus
    HRESULT QueryProtectionStatus(uint* ProtectionState, BSTR* ProtectedUntilTime);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fhcfg/nn-fhcfg-ifhreassociation
@GUID("6544a28a-f68d-47ac-91ef-16b2b36aa3ee")
interface IFhReassociation : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fhcfg/nf-fhcfg-ifhreassociation-validatetarget
    HRESULT ValidateTarget(BSTR TargetUrl, FH_DEVICE_VALIDATION_RESULT* ValidationResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fhcfg/nf-fhcfg-ifhreassociation-scantargetforconfigurations
    HRESULT ScanTargetForConfigurations(BSTR TargetUrl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fhcfg/nf-fhcfg-ifhreassociation-getconfigurationdetails
    HRESULT GetConfigurationDetails(uint Index, BSTR* UserName, BSTR* PcName, FILETIME* BackupTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fhcfg/nf-fhcfg-ifhreassociation-selectconfiguration
    HRESULT SelectConfiguration(uint Index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fhcfg/nf-fhcfg-ifhreassociation-performreassociation
    HRESULT PerformReassociation(BOOL OverwriteIfExists);
}


// GUIDs

const GUID CLSID_FhConfigMgr     = GUIDOF!FhConfigMgr;
const GUID CLSID_FhReassociation = GUIDOF!FhReassociation;

const GUID IID_IFhConfigMgr     = GUIDOF!IFhConfigMgr;
const GUID IID_IFhReassociation = GUIDOF!IFhReassociation;
const GUID IID_IFhScopeIterator = GUIDOF!IFhScopeIterator;
const GUID IID_IFhTarget        = GUIDOF!IFhTarget;
