// Written in the D programming language.

module windows.win32.system.componentservices;

public import windows.core;
public import system.system : Guid;
public import windows.win32.foundation.foundation : BOOL, BSTR, FILETIME, HRESULT, PWSTR,
                                                    VARIANT_BOOL;
public import windows.win32.security.security : PSID;
public import windows.win32.system.com.com : APTTYPE, BLOB, IClassFactory, IDispatch,
                                             IUnknown, SAFEARRAY;
public import windows.win32.system.distributedtransactioncoordinator : ITransaction, ITransactionVoterBallotAsync2,
                                                                       ITransactionVoterNotifyAsync2;
public import windows.win32.system.variant : VARIANT;

extern(Windows) @nogc nothrow:


// Enums


enum COMAdminInUse : int
{
    COMAdminNotInUse                 = 0x00000000,
    COMAdminInUseByCatalog           = 0x00000001,
    COMAdminInUseByRegistryUnknown   = 0x00000002,
    COMAdminInUseByRegistryProxyStub = 0x00000003,
    COMAdminInUseByRegistryTypeLib   = 0x00000004,
    COMAdminInUseByRegistryClsid     = 0x00000005,
}

enum COMAdminComponentType : int
{
    COMAdmin32BitComponent = 0x00000001,
    COMAdmin64BitComponent = 0x00000002,
}

enum COMAdminApplicationInstallOptions : int
{
    COMAdminInstallNoUsers               = 0x00000000,
    COMAdminInstallUsers                 = 0x00000001,
    COMAdminInstallForceOverwriteOfFiles = 0x00000002,
}

enum COMAdminApplicationExportOptions : int
{
    COMAdminExportNoUsers               = 0x00000000,
    COMAdminExportUsers                 = 0x00000001,
    COMAdminExportApplicationProxy      = 0x00000002,
    COMAdminExportForceOverwriteOfFiles = 0x00000004,
    COMAdminExportIn10Format            = 0x00000010,
}

enum COMAdminThreadingModels : int
{
    COMAdminThreadingModelApartment    = 0x00000000,
    COMAdminThreadingModelFree         = 0x00000001,
    COMAdminThreadingModelMain         = 0x00000002,
    COMAdminThreadingModelBoth         = 0x00000003,
    COMAdminThreadingModelNeutral      = 0x00000004,
    COMAdminThreadingModelNotSpecified = 0x00000005,
}

enum COMAdminTransactionOptions : int
{
    COMAdminTransactionIgnored     = 0x00000000,
    COMAdminTransactionNone        = 0x00000001,
    COMAdminTransactionSupported   = 0x00000002,
    COMAdminTransactionRequired    = 0x00000003,
    COMAdminTransactionRequiresNew = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/ne-comadmin-comadmintxisolationleveloptions
enum COMAdminTxIsolationLevelOptions : int
{
    COMAdminTxIsolationLevelAny             = 0x00000000,
    COMAdminTxIsolationLevelReadUnCommitted = 0x00000001,
    COMAdminTxIsolationLevelReadCommitted   = 0x00000002,
    COMAdminTxIsolationLevelRepeatableRead  = 0x00000003,
    COMAdminTxIsolationLevelSerializable    = 0x00000004,
}

enum COMAdminSynchronizationOptions : int
{
    COMAdminSynchronizationIgnored     = 0x00000000,
    COMAdminSynchronizationNone        = 0x00000001,
    COMAdminSynchronizationSupported   = 0x00000002,
    COMAdminSynchronizationRequired    = 0x00000003,
    COMAdminSynchronizationRequiresNew = 0x00000004,
}

enum COMAdminActivationOptions : int
{
    COMAdminActivationInproc = 0x00000000,
    COMAdminActivationLocal  = 0x00000001,
}

enum COMAdminAccessChecksLevelOptions : int
{
    COMAdminAccessChecksApplicationLevel          = 0x00000000,
    COMAdminAccessChecksApplicationComponentLevel = 0x00000001,
}

enum COMAdminAuthenticationLevelOptions : int
{
    COMAdminAuthenticationDefault   = 0x00000000,
    COMAdminAuthenticationNone      = 0x00000001,
    COMAdminAuthenticationConnect   = 0x00000002,
    COMAdminAuthenticationCall      = 0x00000003,
    COMAdminAuthenticationPacket    = 0x00000004,
    COMAdminAuthenticationIntegrity = 0x00000005,
    COMAdminAuthenticationPrivacy   = 0x00000006,
}

enum COMAdminImpersonationLevelOptions : int
{
    COMAdminImpersonationAnonymous   = 0x00000001,
    COMAdminImpersonationIdentify    = 0x00000002,
    COMAdminImpersonationImpersonate = 0x00000003,
    COMAdminImpersonationDelegate    = 0x00000004,
}

enum COMAdminAuthenticationCapabilitiesOptions : int
{
    COMAdminAuthenticationCapabilitiesNone            = 0x00000000,
    COMAdminAuthenticationCapabilitiesSecureReference = 0x00000002,
    COMAdminAuthenticationCapabilitiesStaticCloaking  = 0x00000020,
    COMAdminAuthenticationCapabilitiesDynamicCloaking = 0x00000040,
}

alias COMAdminOS = int;
enum : int
{
    COMAdminOSNotInitialized                  = 0x00000000,
    COMAdminOSWindows3_1                      = 0x00000001,
    COMAdminOSWindows9x                       = 0x00000002,
    COMAdminOSWindows2000                     = 0x00000003,
    COMAdminOSWindows2000AdvancedServer       = 0x00000004,
    COMAdminOSWindows2000Unknown              = 0x00000005,
    COMAdminOSUnknown                         = 0x00000006,
    COMAdminOSWindowsXPPersonal               = 0x0000000b,
    COMAdminOSWindowsXPProfessional           = 0x0000000c,
    COMAdminOSWindowsNETStandardServer        = 0x0000000d,
    COMAdminOSWindowsNETEnterpriseServer      = 0x0000000e,
    COMAdminOSWindowsNETDatacenterServer      = 0x0000000f,
    COMAdminOSWindowsNETWebServer             = 0x00000010,
    COMAdminOSWindowsLonghornPersonal         = 0x00000011,
    COMAdminOSWindowsLonghornProfessional     = 0x00000012,
    COMAdminOSWindowsLonghornStandardServer   = 0x00000013,
    COMAdminOSWindowsLonghornEnterpriseServer = 0x00000014,
    COMAdminOSWindowsLonghornDatacenterServer = 0x00000015,
    COMAdminOSWindowsLonghornWebServer        = 0x00000016,
    COMAdminOSWindows7Personal                = 0x00000017,
    COMAdminOSWindows7Professional            = 0x00000018,
    COMAdminOSWindows7StandardServer          = 0x00000019,
    COMAdminOSWindows7EnterpriseServer        = 0x0000001a,
    COMAdminOSWindows7DatacenterServer        = 0x0000001b,
    COMAdminOSWindows7WebServer               = 0x0000001c,
    COMAdminOSWindows8Personal                = 0x0000001d,
    COMAdminOSWindows8Professional            = 0x0000001e,
    COMAdminOSWindows8StandardServer          = 0x0000001f,
    COMAdminOSWindows8EnterpriseServer        = 0x00000020,
    COMAdminOSWindows8DatacenterServer        = 0x00000021,
    COMAdminOSWindows8WebServer               = 0x00000022,
    COMAdminOSWindowsBluePersonal             = 0x00000023,
    COMAdminOSWindowsBlueProfessional         = 0x00000024,
    COMAdminOSWindowsBlueStandardServer       = 0x00000025,
    COMAdminOSWindowsBlueEnterpriseServer     = 0x00000026,
    COMAdminOSWindowsBlueDatacenterServer     = 0x00000027,
    COMAdminOSWindowsBlueWebServer            = 0x00000028,
}

enum COMAdminServiceOptions : int
{
    COMAdminServiceLoadBalanceRouter = 0x00000001,
}

enum COMAdminServiceStatusOptions : int
{
    COMAdminServiceStopped         = 0x00000000,
    COMAdminServiceStartPending    = 0x00000001,
    COMAdminServiceStopPending     = 0x00000002,
    COMAdminServiceRunning         = 0x00000003,
    COMAdminServiceContinuePending = 0x00000004,
    COMAdminServicePausePending    = 0x00000005,
    COMAdminServicePaused          = 0x00000006,
    COMAdminServiceUnknownState    = 0x00000007,
}

enum COMAdminQCMessageAuthenticateOptions : int
{
    COMAdminQCMessageAuthenticateSecureApps = 0x00000000,
    COMAdminQCMessageAuthenticateOff        = 0x00000001,
    COMAdminQCMessageAuthenticateOn         = 0x00000002,
}

enum COMAdminFileFlags : int
{
    COMAdminFileFlagLoadable          = 0x00000001,
    COMAdminFileFlagCOM               = 0x00000002,
    COMAdminFileFlagContainsPS        = 0x00000004,
    COMAdminFileFlagContainsComp      = 0x00000008,
    COMAdminFileFlagContainsTLB       = 0x00000010,
    COMAdminFileFlagSelfReg           = 0x00000020,
    COMAdminFileFlagSelfUnReg         = 0x00000040,
    COMAdminFileFlagUnloadableDLL     = 0x00000080,
    COMAdminFileFlagDoesNotExist      = 0x00000100,
    COMAdminFileFlagAlreadyInstalled  = 0x00000200,
    COMAdminFileFlagBadTLB            = 0x00000400,
    COMAdminFileFlagGetClassObjFailed = 0x00000800,
    COMAdminFileFlagClassNotAvailable = 0x00001000,
    COMAdminFileFlagRegistrar         = 0x00002000,
    COMAdminFileFlagNoRegistrar       = 0x00004000,
    COMAdminFileFlagDLLRegsvrFailed   = 0x00008000,
    COMAdminFileFlagRegTLBFailed      = 0x00010000,
    COMAdminFileFlagRegistrarFailed   = 0x00020000,
    COMAdminFileFlagError             = 0x00040000,
}

enum COMAdminComponentFlags : int
{
    COMAdminCompFlagTypeInfoFound          = 0x00000001,
    COMAdminCompFlagCOMPlusPropertiesFound = 0x00000002,
    COMAdminCompFlagProxyFound             = 0x00000004,
    COMAdminCompFlagInterfacesFound        = 0x00000008,
    COMAdminCompFlagAlreadyInstalled       = 0x00000010,
    COMAdminCompFlagNotInApplication       = 0x00000020,
}

enum COMAdminErrorCodes : int
{
    COMAdminErrObjectErrors                  = 0x80110401,
    COMAdminErrObjectInvalid                 = 0x80110402,
    COMAdminErrKeyMissing                    = 0x80110403,
    COMAdminErrAlreadyInstalled              = 0x80110404,
    COMAdminErrAppFileWriteFail              = 0x80110407,
    COMAdminErrAppFileReadFail               = 0x80110408,
    COMAdminErrAppFileVersion                = 0x80110409,
    COMAdminErrBadPath                       = 0x8011040a,
    COMAdminErrApplicationExists             = 0x8011040b,
    COMAdminErrRoleExists                    = 0x8011040c,
    COMAdminErrCantCopyFile                  = 0x8011040d,
    COMAdminErrNoUser                        = 0x8011040f,
    COMAdminErrInvalidUserids                = 0x80110410,
    COMAdminErrNoRegistryCLSID               = 0x80110411,
    COMAdminErrBadRegistryProgID             = 0x80110412,
    COMAdminErrAuthenticationLevel           = 0x80110413,
    COMAdminErrUserPasswdNotValid            = 0x80110414,
    COMAdminErrCLSIDOrIIDMismatch            = 0x80110418,
    COMAdminErrRemoteInterface               = 0x80110419,
    COMAdminErrDllRegisterServer             = 0x8011041a,
    COMAdminErrNoServerShare                 = 0x8011041b,
    COMAdminErrDllLoadFailed                 = 0x8011041d,
    COMAdminErrBadRegistryLibID              = 0x8011041e,
    COMAdminErrAppDirNotFound                = 0x8011041f,
    COMAdminErrRegistrarFailed               = 0x80110423,
    COMAdminErrCompFileDoesNotExist          = 0x80110424,
    COMAdminErrCompFileLoadDLLFail           = 0x80110425,
    COMAdminErrCompFileGetClassObj           = 0x80110426,
    COMAdminErrCompFileClassNotAvail         = 0x80110427,
    COMAdminErrCompFileBadTLB                = 0x80110428,
    COMAdminErrCompFileNotInstallable        = 0x80110429,
    COMAdminErrNotChangeable                 = 0x8011042a,
    COMAdminErrNotDeletable                  = 0x8011042b,
    COMAdminErrSession                       = 0x8011042c,
    COMAdminErrCompMoveLocked                = 0x8011042d,
    COMAdminErrCompMoveBadDest               = 0x8011042e,
    COMAdminErrRegisterTLB                   = 0x80110430,
    COMAdminErrSystemApp                     = 0x80110433,
    COMAdminErrCompFileNoRegistrar           = 0x80110434,
    COMAdminErrCoReqCompInstalled            = 0x80110435,
    COMAdminErrServiceNotInstalled           = 0x80110436,
    COMAdminErrPropertySaveFailed            = 0x80110437,
    COMAdminErrObjectExists                  = 0x80110438,
    COMAdminErrComponentExists               = 0x80110439,
    COMAdminErrRegFileCorrupt                = 0x8011043b,
    COMAdminErrPropertyOverflow              = 0x8011043c,
    COMAdminErrNotInRegistry                 = 0x8011043e,
    COMAdminErrObjectNotPoolable             = 0x8011043f,
    COMAdminErrApplidMatchesClsid            = 0x80110446,
    COMAdminErrRoleDoesNotExist              = 0x80110447,
    COMAdminErrStartAppNeedsComponents       = 0x80110448,
    COMAdminErrRequiresDifferentPlatform     = 0x80110449,
    COMAdminErrQueuingServiceNotAvailable    = 0x80110602,
    COMAdminErrObjectParentMissing           = 0x80110808,
    COMAdminErrObjectDoesNotExist            = 0x80110809,
    COMAdminErrCanNotExportAppProxy          = 0x8011044a,
    COMAdminErrCanNotStartApp                = 0x8011044b,
    COMAdminErrCanNotExportSystemApp         = 0x8011044c,
    COMAdminErrCanNotSubscribeToComponent    = 0x8011044d,
    COMAdminErrAppNotRunning                 = 0x8011080a,
    COMAdminErrEventClassCannotBeSubscriber  = 0x8011044e,
    COMAdminErrLibAppProxyIncompatible       = 0x8011044f,
    COMAdminErrBasePartitionOnly             = 0x80110450,
    COMAdminErrDuplicatePartitionName        = 0x80110457,
    COMAdminErrPartitionInUse                = 0x80110459,
    COMAdminErrImportedComponentsNotAllowed  = 0x8011045b,
    COMAdminErrRegdbNotInitialized           = 0x80110472,
    COMAdminErrRegdbNotOpen                  = 0x80110473,
    COMAdminErrRegdbSystemErr                = 0x80110474,
    COMAdminErrRegdbAlreadyRunning           = 0x80110475,
    COMAdminErrMigVersionNotSupported        = 0x80110480,
    COMAdminErrMigSchemaNotFound             = 0x80110481,
    COMAdminErrCatBitnessMismatch            = 0x80110482,
    COMAdminErrCatUnacceptableBitness        = 0x80110483,
    COMAdminErrCatWrongAppBitnessBitness     = 0x80110484,
    COMAdminErrCatPauseResumeNotSupported    = 0x80110485,
    COMAdminErrCatServerFault                = 0x80110486,
    COMAdminErrCantRecycleLibraryApps        = 0x8011080f,
    COMAdminErrCantRecycleServiceApps        = 0x80110811,
    COMAdminErrProcessAlreadyRecycled        = 0x80110812,
    COMAdminErrPausedProcessMayNotBeRecycled = 0x80110813,
    COMAdminErrInvalidPartition              = 0x8011080b,
    COMAdminErrPartitionMsiOnly              = 0x80110819,
    COMAdminErrStartAppDisabled              = 0x80110451,
    COMAdminErrCompMoveSource                = 0x8011081c,
    COMAdminErrCompMoveDest                  = 0x8011081d,
    COMAdminErrCompMovePrivate               = 0x8011081e,
    COMAdminErrCannotCopyEventClass          = 0x80110820,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/ne-comsvcs-tracking_coll_type
alias TRACKING_COLL_TYPE = int;
enum : int
{
    TRKCOLL_PROCESSES    = 0x00000000,
    TRKCOLL_APPLICATIONS = 0x00000001,
    TRKCOLL_COMPONENTS   = 0x00000002,
}

alias DUMPTYPE = int;
enum : int
{
    DUMPTYPE_FULL = 0x00000000,
    DUMPTYPE_MINI = 0x00000001,
    DUMPTYPE_NONE = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/ne-comsvcs-complus_apptype
alias COMPLUS_APPTYPE = int;
enum : int
{
    APPTYPE_UNKNOWN = 0xffffffff,
    APPTYPE_SERVER  = 0x00000001,
    APPTYPE_LIBRARY = 0x00000000,
    APPTYPE_SWC     = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/ne-comsvcs-getapptrackerdataflags
enum GetAppTrackerDataFlags : int
{
    GATD_INCLUDE_PROCESS_EXE_NAME = 0x00000001,
    GATD_INCLUDE_LIBRARY_APPS     = 0x00000002,
    GATD_INCLUDE_SWC              = 0x00000004,
    GATD_INCLUDE_CLASS_NAME       = 0x00000008,
    GATD_INCLUDE_APPLICATION_NAME = 0x00000010,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/ne-comsvcs-transactionvote
enum TransactionVote : int
{
    TxCommit = 0x00000000,
    TxAbort  = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/ne-comsvcs-crmtransactionstate
enum CrmTransactionState : int
{
    TxState_Active    = 0x00000000,
    TxState_Committed = 0x00000001,
    TxState_Aborted   = 0x00000002,
    TxState_Indoubt   = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/ne-comsvcs-csc_inheritanceconfig
alias CSC_InheritanceConfig = int;
enum : int
{
    CSC_Inherit = 0x00000000,
    CSC_Ignore  = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/ne-comsvcs-csc_threadpool
alias CSC_ThreadPool = int;
enum : int
{
    CSC_ThreadPoolNone    = 0x00000000,
    CSC_ThreadPoolInherit = 0x00000001,
    CSC_STAThreadPool     = 0x00000002,
    CSC_MTAThreadPool     = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/ne-comsvcs-csc_binding
alias CSC_Binding = int;
enum : int
{
    CSC_NoBinding        = 0x00000000,
    CSC_BindToPoolThread = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/ne-comsvcs-csc_transactionconfig
alias CSC_TransactionConfig = int;
enum : int
{
    CSC_NoTransaction                = 0x00000000,
    CSC_IfContainerIsTransactional   = 0x00000001,
    CSC_CreateTransactionIfNecessary = 0x00000002,
    CSC_NewTransaction               = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/ne-comsvcs-csc_synchronizationconfig
alias CSC_SynchronizationConfig = int;
enum : int
{
    CSC_NoSynchronization             = 0x00000000,
    CSC_IfContainerIsSynchronized     = 0x00000001,
    CSC_NewSynchronizationIfNecessary = 0x00000002,
    CSC_NewSynchronization            = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/ne-comsvcs-csc_trackerconfig
alias CSC_TrackerConfig = int;
enum : int
{
    CSC_DontUseTracker = 0x00000000,
    CSC_UseTracker     = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/ne-comsvcs-csc_partitionconfig
alias CSC_PartitionConfig = int;
enum : int
{
    CSC_NoPartition      = 0x00000000,
    CSC_InheritPartition = 0x00000001,
    CSC_NewPartition     = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/ne-comsvcs-csc_iisintrinsicsconfig
alias CSC_IISIntrinsicsConfig = int;
enum : int
{
    CSC_NoIISIntrinsics      = 0x00000000,
    CSC_InheritIISIntrinsics = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/ne-comsvcs-csc_comtiintrinsicsconfig
alias CSC_COMTIIntrinsicsConfig = int;
enum : int
{
    CSC_NoCOMTIIntrinsics      = 0x00000000,
    CSC_InheritCOMTIIntrinsics = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/ne-comsvcs-csc_sxsconfig
alias CSC_SxsConfig = int;
enum : int
{
    CSC_NoSxs      = 0x00000000,
    CSC_InheritSxs = 0x00000001,
    CSC_NewSxs     = 0x00000002,
}

alias AutoSvcs_Error_Constants = uint;
enum : uint
{
    mtsErrCtxAborted                   = 0x8004e002U,
    mtsErrCtxAborting                  = 0x8004e003U,
    mtsErrCtxNoContext                 = 0x8004e004U,
    mtsErrCtxNotRegistered             = 0x8004e005U,
    mtsErrCtxSynchTimeout              = 0x8004e006U,
    mtsErrCtxOldReference              = 0x8004e007U,
    mtsErrCtxRoleNotFound              = 0x8004e00cU,
    mtsErrCtxNoSecurity                = 0x8004e00dU,
    mtsErrCtxWrongThread               = 0x8004e00eU,
    mtsErrCtxTMNotAvailable            = 0x8004e00fU,
    comQCErrApplicationNotQueued       = 0x80110600U,
    comQCErrNoQueueableInterfaces      = 0x80110601U,
    comQCErrQueuingServiceNotAvailable = 0x80110602U,
    comQCErrQueueTransactMismatch      = 0x80110603U,
    comqcErrRecorderMarshalled         = 0x80110604U,
    comqcErrOutParam                   = 0x80110605U,
    comqcErrRecorderNotTrusted         = 0x80110606U,
    comqcErrPSLoad                     = 0x80110607U,
    comqcErrMarshaledObjSameTxn        = 0x80110608U,
    comqcErrInvalidMessage             = 0x80110650U,
    comqcErrMsmqSidUnavailable         = 0x80110651U,
    comqcErrWrongMsgExtension          = 0x80110652U,
    comqcErrMsmqServiceUnavailable     = 0x80110653U,
    comqcErrMsgNotAuthenticated        = 0x80110654U,
    comqcErrMsmqConnectorUsed          = 0x80110655U,
    comqcErrBadMarshaledObject         = 0x80110656U,
}

enum LockModes : int
{
    LockSetGet = 0x00000000,
    LockMethod = 0x00000001,
}

enum ReleaseModes : int
{
    Standard = 0x00000000,
    Process  = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/ne-comsvcs-crmflags
alias CRMFLAGS = int;
enum : int
{
    CRMFLAG_FORGETTARGET          = 0x00000001,
    CRMFLAG_WRITTENDURINGPREPARE  = 0x00000002,
    CRMFLAG_WRITTENDURINGCOMMIT   = 0x00000004,
    CRMFLAG_WRITTENDURINGABORT    = 0x00000008,
    CRMFLAG_WRITTENDURINGRECOVERY = 0x00000010,
    CRMFLAG_WRITTENDURINGREPLAY   = 0x00000020,
    CRMFLAG_REPLAYINPROGRESS      = 0x00000040,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/ne-comsvcs-crmregflags
alias CRMREGFLAGS = int;
enum : int
{
    CRMREGFLAG_PREPAREPHASE         = 0x00000001,
    CRMREGFLAG_COMMITPHASE          = 0x00000002,
    CRMREGFLAG_ABORTPHASE           = 0x00000004,
    CRMREGFLAG_ALLPHASES            = 0x00000007,
    CRMREGFLAG_FAILIFINDOUBTSREMAIN = 0x00000010,
}

// Constants


enum const(wchar)* TRACKER_STARTSTOP_EVENT = "Global\\COM+ Tracker Push Event";
enum const(wchar)* TRACKER_INIT_EVENT = "Global\\COM+ Tracker Init Event";
enum uint GUID_STRING_SIZE = 0x00000028U;
enum uint DATA_NOT_AVAILABLE = 0xffffffffU;
enum uint MTXDM_E_ENLISTRESOURCEFAILED = 0x8004e100U;
enum uint CRR_NO_REASON_SUPPLIED = 0x00000000U;
enum uint CRR_LIFETIME_LIMIT = 0xffffffffU;
enum uint CRR_ACTIVATION_LIMIT = 0xfffffffeU;
enum uint CRR_CALL_LIMIT = 0xfffffffdU;
enum uint CRR_MEMORY_LIMIT = 0xfffffffcU;
enum uint CRR_RECYCLED_FROM_UI = 0xfffffffbU;

// Structs


//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/ns-comsvcs-comsvcseventinfo
struct COMSVCSEVENTINFO
{
    uint  cbSize;
    uint  dwPid;
    long  lTime;
    int   lMicroTime;
    long  perfCount;
    GUID  guidApp;
    PWSTR sMachineName;
}

struct RECYCLE_INFO
{
    GUID guidCombaseProcessIdentifier;
    long ProcessStartTime;
    uint dwRecycleLifetimeLimit;
    uint dwRecycleMemoryLimit;
    uint dwRecycleExpirationTimeout;
}

struct HANG_INFO
{
    BOOL     fAppHangMonitorEnabled;
    BOOL     fTerminateOnHang;
    DUMPTYPE DumpType;
    uint     dwHangTimeout;
    uint     dwDumpCount;
    uint     dwInfoMsgCount;
}

struct APPSTATISTICS
{
    uint m_cTotalCalls;
    uint m_cTotalInstances;
    uint m_cTotalClasses;
    uint m_cCallsPerSecond;
}

struct APPDATA
{
    uint          m_idApp;
    wchar[40]     m_szAppGuid;
    uint          m_dwAppProcessId;
    APPSTATISTICS m_AppStatistics;
}

struct CLSIDDATA
{
    GUID m_clsid;
    uint m_cReferences;
    uint m_cBound;
    uint m_cPooled;
    uint m_cInCall;
    uint m_dwRespTime;
    uint m_cCallsCompleted;
    uint m_cCallsFailed;
}

struct CLSIDDATA2
{
    GUID            m_clsid;
    GUID            m_appid;
    GUID            m_partid;
    PWSTR           m_pwszAppName;
    PWSTR           m_pwszCtxName;
    COMPLUS_APPTYPE m_eAppType;
    uint            m_cReferences;
    uint            m_cBound;
    uint            m_cPooled;
    uint            m_cInCall;
    uint            m_dwRespTime;
    uint            m_cCallsCompleted;
    uint            m_cCallsFailed;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/ns-comsvcs-applicationprocesssummary
struct ApplicationProcessSummary
{
    GUID            PartitionIdPrimaryApplication;
    GUID            ApplicationIdPrimaryApplication;
    GUID            ApplicationInstanceId;
    uint            ProcessId;
    COMPLUS_APPTYPE Type;
    PWSTR           ProcessExeName;
    BOOL            IsService;
    BOOL            IsPaused;
    BOOL            IsRecycled;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/ns-comsvcs-applicationprocessstatistics
struct ApplicationProcessStatistics
{
    uint NumCallsOutstanding;
    uint NumTrackedComponents;
    uint NumComponentInstances;
    uint AvgCallsPerSecond;
    uint Reserved1;
    uint Reserved2;
    uint Reserved3;
    uint Reserved4;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/ns-comsvcs-applicationprocessrecycleinfo
struct ApplicationProcessRecycleInfo
{
    BOOL     IsRecyclable;
    BOOL     IsRecycled;
    FILETIME TimeRecycled;
    FILETIME TimeToTerminate;
    int      RecycleReasonCode;
    BOOL     IsPendingRecycle;
    BOOL     HasAutomaticLifetimeRecycling;
    FILETIME TimeForAutomaticRecycling;
    uint     MemoryLimitInKB;
    uint     MemoryUsageInKBLastCheck;
    uint     ActivationLimit;
    uint     NumActivationsLastReported;
    uint     CallLimit;
    uint     NumCallsLastReported;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/ns-comsvcs-applicationsummary
struct ApplicationSummary
{
    GUID            ApplicationInstanceId;
    GUID            PartitionId;
    GUID            ApplicationId;
    COMPLUS_APPTYPE Type;
    PWSTR           ApplicationName;
    uint            NumTrackedComponents;
    uint            NumComponentInstances;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/ns-comsvcs-componentsummary
struct ComponentSummary
{
    GUID  ApplicationInstanceId;
    GUID  PartitionId;
    GUID  ApplicationId;
    GUID  Clsid;
    PWSTR ClassName;
    PWSTR ApplicationName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/ns-comsvcs-componentstatistics
struct ComponentStatistics
{
    uint NumInstances;
    uint NumBoundReferences;
    uint NumPooledObjects;
    uint NumObjectsInCall;
    uint AvgResponseTimeInMs;
    uint NumCallsCompletedRecent;
    uint NumCallsFailedRecent;
    uint NumCallsCompletedTotal;
    uint NumCallsFailedTotal;
    uint Reserved1;
    uint Reserved2;
    uint Reserved3;
    uint Reserved4;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/ns-comsvcs-componenthangmonitorinfo
struct ComponentHangMonitorInfo
{
    BOOL IsMonitored;
    BOOL TerminateOnHang;
    uint AvgCallThresholdInMs;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/ns-comsvcs-crmlogrecordread
struct CrmLogRecordRead
{
    uint dwCrmFlags;
    uint dwSequenceNumber;
    BLOB blobUserData;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("OLE32.dll")
HRESULT CoGetDefaultContext(APTTYPE aptType, const(GUID)* riid, void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("comsvcs.dll")
HRESULT CoCreateActivity(IUnknown pIUnknown, const(GUID)* riid, void** ppObj);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("comsvcs.dll")
HRESULT CoEnterServiceDomain(IUnknown pConfigObject);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("comsvcs.dll")
void CoLeaveServiceDomain(IUnknown pUnkStatus);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("comsvcs.dll")
HRESULT GetManagedExtensions(uint* dwExts);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("comsvcs.dll")
void* SafeRef(const(GUID)* rid, IUnknown pUnk);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("comsvcs.dll")
HRESULT RecycleSurrogate(int lReasonCode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("comsvcs.dll")
HRESULT MTSCreateActivity(const(GUID)* riid, void** ppobj);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MTxDM.dll")
HRESULT GetDispenserManager(IDispenserManager* param0);


// Interfaces

@GUID("f618c514-dfb8-11d1-a2cf-00805fc79235")
struct COMAdminCatalog;

@GUID("f618c515-dfb8-11d1-a2cf-00805fc79235")
struct COMAdminCatalogObject;

@GUID("f618c516-dfb8-11d1-a2cf-00805fc79235")
struct COMAdminCatalogCollection;

@GUID("ecabb0a5-7f19-11d2-978e-0000f8757e2a")
struct SecurityIdentity;

@GUID("ecabb0a6-7f19-11d2-978e-0000f8757e2a")
struct SecurityCallers;

@GUID("ecabb0a7-7f19-11d2-978e-0000f8757e2a")
struct SecurityCallContext;

@GUID("ecabb0a8-7f19-11d2-978e-0000f8757e2a")
struct GetSecurityCallContextAppObject;

@GUID("ecabb0a9-7f19-11d2-978e-0000f8757e2a")
struct Dummy30040732;

@GUID("7999fc25-d3c6-11cf-acab-00a024a55aef")
struct TransactionContext;

@GUID("5cb66670-d3d4-11cf-acab-00a024a55aef")
struct TransactionContextEx;

@GUID("ecabb0aa-7f19-11d2-978e-0000f8757e2a")
struct ByotServerEx;

@GUID("ecabb0c8-7f19-11d2-978e-0000f8757e2a")
struct CServiceConfig;

@GUID("ecabb0c9-7f19-11d2-978e-0000f8757e2a")
struct ServicePool;

@GUID("ecabb0ca-7f19-11d2-978e-0000f8757e2a")
struct ServicePoolConfig;

@GUID("2a005c05-a5de-11cf-9e66-00aa00a3f464")
struct SharedProperty;

@GUID("2a005c0b-a5de-11cf-9e66-00aa00a3f464")
struct SharedPropertyGroup;

@GUID("2a005c11-a5de-11cf-9e66-00aa00a3f464")
struct SharedPropertyGroupManager;

@GUID("ecabb0ab-7f19-11d2-978e-0000f8757e2a")
struct COMEvents;

@GUID("ecabb0ac-7f19-11d2-978e-0000f8757e2a")
struct CoMTSLocator;

@GUID("4b2e958d-0393-11d1-b1ab-00aa00ba3258")
struct MtsGrp;

@GUID("ecabb0c3-7f19-11d2-978e-0000f8757e2a")
struct ComServiceEvents;

@GUID("ecabb0c6-7f19-11d2-978e-0000f8757e2a")
struct ComSystemAppEventData;

@GUID("ecabb0bd-7f19-11d2-978e-0000f8757e2a")
struct CRMClerk;

@GUID("ecabb0be-7f19-11d2-978e-0000f8757e2a")
struct CRMRecoveryClerk;

@GUID("ecabb0c1-7f19-11d2-978e-0000f8757e2a")
struct LBEvents;

@GUID("ecabb0bf-7f19-11d2-978e-0000f8757e2a")
struct MessageMover;

@GUID("ecabb0c0-7f19-11d2-978e-0000f8757e2a")
struct DispenserManager;

@GUID("ecabafb5-7f19-11d2-978e-0000f8757e2a")
struct PoolMgr;

@GUID("ecabafbc-7f19-11d2-978e-0000f8757e2a")
struct EventServer;

@GUID("ecabafb9-7f19-11d2-978e-0000f8757e2a")
struct TrackerServer;

@GUID("ef24f689-14f8-4d92-b4af-d7b1f0e70fd4")
struct AppDomainHelper;

@GUID("458aa3b5-265a-4b75-bc05-9bea4630cf18")
struct ClrAssemblyLocator;

@GUID("dd662187-dfc2-11d1-a2cf-00805fc79235")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nn-comadmin-icomadmincatalog
interface ICOMAdminCatalog : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog-getcollection
    HRESULT GetCollection(BSTR bstrCollName, IDispatch* ppCatalogCollection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog-connect
    HRESULT Connect(BSTR bstrCatalogServerName, IDispatch* ppCatalogCollection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog-get_majorversion
    HRESULT get_MajorVersion(int* plMajorVersion);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog-get_minorversion
    HRESULT get_MinorVersion(int* plMinorVersion);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog-getcollectionbyquery
    HRESULT GetCollectionByQuery(BSTR bstrCollName, SAFEARRAY** ppsaVarQuery, IDispatch* ppCatalogCollection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog-importcomponent
    HRESULT ImportComponent(BSTR bstrApplIDOrName, BSTR bstrCLSIDOrProgID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog-installcomponent
    HRESULT InstallComponent(BSTR bstrApplIDOrName, BSTR bstrDLL, BSTR bstrTLB, BSTR bstrPSDLL);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog-shutdownapplication
    HRESULT ShutdownApplication(BSTR bstrApplIDOrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog-exportapplication
    HRESULT ExportApplication(BSTR bstrApplIDOrName, BSTR bstrApplicationFile, 
                              COMAdminApplicationExportOptions lOptions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog-installapplication
    HRESULT InstallApplication(BSTR bstrApplicationFile, BSTR bstrDestinationDirectory, 
                               COMAdminApplicationInstallOptions lOptions, BSTR bstrUserId, BSTR bstrPassword, 
                               BSTR bstrRSN);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog-stoprouter
    HRESULT StopRouter();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog-refreshrouter
    HRESULT RefreshRouter();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog-startrouter
    HRESULT StartRouter();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nn-comadmin-icomadmincatalog
    HRESULT Reserved1();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nn-comadmin-icomadmincatalog
    HRESULT Reserved2();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog-installmultiplecomponents
    HRESULT InstallMultipleComponents(BSTR bstrApplIDOrName, SAFEARRAY** ppsaVarFileNames, 
                                      SAFEARRAY** ppsaVarCLSIDs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog-getmultiplecomponentsinfo
    HRESULT GetMultipleComponentsInfo(BSTR bstrApplIdOrName, SAFEARRAY** ppsaVarFileNames, 
                                      SAFEARRAY** ppsaVarCLSIDs, SAFEARRAY** ppsaVarClassNames, 
                                      SAFEARRAY** ppsaVarFileFlags, SAFEARRAY** ppsaVarComponentFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog-refreshcomponents
    HRESULT RefreshComponents();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog-backupregdb
    HRESULT BackupREGDB(BSTR bstrBackupFilePath);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog-restoreregdb
    HRESULT RestoreREGDB(BSTR bstrBackupFilePath);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog-queryapplicationfile
    HRESULT QueryApplicationFile(BSTR bstrApplicationFile, BSTR* pbstrApplicationName, 
                                 BSTR* pbstrApplicationDescription, VARIANT_BOOL* pbHasUsers, 
                                 VARIANT_BOOL* pbIsProxy, SAFEARRAY** ppsaVarFileNames);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog-startapplication
    HRESULT StartApplication(BSTR bstrApplIdOrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog-servicecheck
    HRESULT ServiceCheck(int lService, int* plStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog-installmultipleeventclasses
    HRESULT InstallMultipleEventClasses(BSTR bstrApplIdOrName, SAFEARRAY** ppsaVarFileNames, 
                                        SAFEARRAY** ppsaVarCLSIDS);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog-installeventclass
    HRESULT InstallEventClass(BSTR bstrApplIdOrName, BSTR bstrDLL, BSTR bstrTLB, BSTR bstrPSDLL);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog-geteventclassesforiid
    HRESULT GetEventClassesForIID(BSTR bstrIID, SAFEARRAY** ppsaVarCLSIDs, SAFEARRAY** ppsaVarProgIDs, 
                                  SAFEARRAY** ppsaVarDescriptions);
}

@GUID("790c6e0b-9194-4cc9-9426-a48a63185696")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nn-comadmin-icomadmincatalog2
interface ICOMAdminCatalog2 : ICOMAdminCatalog
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog2-getcollectionbyquery2
    HRESULT GetCollectionByQuery2(BSTR bstrCollectionName, VARIANT* pVarQueryStrings, 
                                  IDispatch* ppCatalogCollection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog2-getapplicationinstanceidfromprocessid
    HRESULT GetApplicationInstanceIDFromProcessID(int lProcessID, BSTR* pbstrApplicationInstanceID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog2-shutdownapplicationinstances
    HRESULT ShutdownApplicationInstances(VARIANT* pVarApplicationInstanceID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog2-pauseapplicationinstances
    HRESULT PauseApplicationInstances(VARIANT* pVarApplicationInstanceID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog2-resumeapplicationinstances
    HRESULT ResumeApplicationInstances(VARIANT* pVarApplicationInstanceID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog2-recycleapplicationinstances
    HRESULT RecycleApplicationInstances(VARIANT* pVarApplicationInstanceID, int lReasonCode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog2-areapplicationinstancespaused
    HRESULT AreApplicationInstancesPaused(VARIANT* pVarApplicationInstanceID, VARIANT_BOOL* pVarBoolPaused);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog2-dumpapplicationinstance
    HRESULT DumpApplicationInstance(BSTR bstrApplicationInstanceID, BSTR bstrDirectory, int lMaxImages, 
                                    BSTR* pbstrDumpFile);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog2-get_isapplicationinstancedumpsupported
    HRESULT get_IsApplicationInstanceDumpSupported(VARIANT_BOOL* pVarBoolDumpSupported);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog2-createserviceforapplication
    HRESULT CreateServiceForApplication(BSTR bstrApplicationIDOrName, BSTR bstrServiceName, BSTR bstrStartType, 
                                        BSTR bstrErrorControl, BSTR bstrDependencies, BSTR bstrRunAs, 
                                        BSTR bstrPassword, VARIANT_BOOL bDesktopOk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog2-deleteserviceforapplication
    HRESULT DeleteServiceForApplication(BSTR bstrApplicationIDOrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog2-getpartitionid
    HRESULT GetPartitionID(BSTR bstrApplicationIDOrName, BSTR* pbstrPartitionID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog2-getpartitionname
    HRESULT GetPartitionName(BSTR bstrApplicationIDOrName, BSTR* pbstrPartitionName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog2-put_currentpartition
    HRESULT put_CurrentPartition(BSTR bstrPartitionIDOrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog2-get_currentpartitionid
    HRESULT get_CurrentPartitionID(BSTR* pbstrPartitionID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog2-get_currentpartitionname
    HRESULT get_CurrentPartitionName(BSTR* pbstrPartitionName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog2-get_globalpartitionid
    HRESULT get_GlobalPartitionID(BSTR* pbstrGlobalPartitionID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog2-flushpartitioncache
    HRESULT FlushPartitionCache();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog2-copyapplications
    HRESULT CopyApplications(BSTR bstrSourcePartitionIDOrName, VARIANT* pVarApplicationID, 
                             BSTR bstrDestinationPartitionIDOrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog2-copycomponents
    HRESULT CopyComponents(BSTR bstrSourceApplicationIDOrName, VARIANT* pVarCLSIDOrProgID, 
                           BSTR bstrDestinationApplicationIDOrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog2-movecomponents
    HRESULT MoveComponents(BSTR bstrSourceApplicationIDOrName, VARIANT* pVarCLSIDOrProgID, 
                           BSTR bstrDestinationApplicationIDOrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog2-aliascomponent
    HRESULT AliasComponent(BSTR bstrSrcApplicationIDOrName, BSTR bstrCLSIDOrProgID, 
                           BSTR bstrDestApplicationIDOrName, BSTR bstrNewProgId, BSTR bstrNewClsid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog2-issafetodelete
    HRESULT IsSafeToDelete(BSTR bstrDllName, COMAdminInUse* pCOMAdminInUse);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog2-importunconfiguredcomponents
    HRESULT ImportUnconfiguredComponents(BSTR bstrApplicationIDOrName, VARIANT* pVarCLSIDOrProgID, 
                                         VARIANT* pVarComponentType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog2-promoteunconfiguredcomponents
    HRESULT PromoteUnconfiguredComponents(BSTR bstrApplicationIDOrName, VARIANT* pVarCLSIDOrProgID, 
                                          VARIANT* pVarComponentType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog2-importcomponents
    HRESULT ImportComponents(BSTR bstrApplicationIDOrName, VARIANT* pVarCLSIDOrProgID, VARIANT* pVarComponentType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog2-get_is64bitcatalogserver
    HRESULT get_Is64BitCatalogServer(VARIANT_BOOL* pbIs64Bit);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog2-exportpartition
    HRESULT ExportPartition(BSTR bstrPartitionIDOrName, BSTR bstrPartitionFileName, 
                            COMAdminApplicationExportOptions lOptions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog2-installpartition
    HRESULT InstallPartition(BSTR bstrFileName, BSTR bstrDestDirectory, COMAdminApplicationInstallOptions lOptions, 
                             BSTR bstrUserID, BSTR bstrPassword, BSTR bstrRSN);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog2-queryapplicationfile2
    HRESULT QueryApplicationFile2(BSTR bstrApplicationFile, IDispatch* ppFilesForImport);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icomadmincatalog2-getcomponentversioncount
    HRESULT GetComponentVersionCount(BSTR bstrCLSIDOrProgID, int* plVersionCount);
}

@GUID("6eb22871-8a19-11d0-81b6-00a0c9231c29")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nn-comadmin-icatalogobject
interface ICatalogObject : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icatalogobject-get_value
    HRESULT get_Value(BSTR bstrPropName, VARIANT* pvarRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icatalogobject-put_value
    HRESULT put_Value(BSTR bstrPropName, VARIANT val);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icatalogobject-get_key
    HRESULT get_Key(VARIANT* pvarRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icatalogobject-get_name
    HRESULT get_Name(VARIANT* pvarRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icatalogobject-ispropertyreadonly
    HRESULT IsPropertyReadOnly(BSTR bstrPropName, VARIANT_BOOL* pbRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icatalogobject-get_valid
    HRESULT get_Valid(VARIANT_BOOL* pbRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icatalogobject-ispropertywriteonly
    HRESULT IsPropertyWriteOnly(BSTR bstrPropName, VARIANT_BOOL* pbRetVal);
}

@GUID("6eb22872-8a19-11d0-81b6-00a0c9231c29")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nn-comadmin-icatalogcollection
interface ICatalogCollection : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icatalogcollection-get__newenum
    HRESULT get__NewEnum(IUnknown* ppEnumVariant);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icatalogcollection-get_item
    HRESULT get_Item(int lIndex, IDispatch* ppCatalogObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icatalogcollection-get_count
    HRESULT get_Count(int* plObjectCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icatalogcollection-remove
    HRESULT Remove(int lIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icatalogcollection-add
    HRESULT Add(IDispatch* ppCatalogObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icatalogcollection-populate
    HRESULT Populate();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icatalogcollection-savechanges
    HRESULT SaveChanges(int* pcChanges);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icatalogcollection-getcollection
    HRESULT GetCollection(BSTR bstrCollName, VARIANT varObjectKey, IDispatch* ppCatalogCollection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icatalogcollection-get_name
    HRESULT get_Name(VARIANT* pVarNamel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icatalogcollection-get_addenabled
    HRESULT get_AddEnabled(VARIANT_BOOL* pVarBool);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icatalogcollection-get_removeenabled
    HRESULT get_RemoveEnabled(VARIANT_BOOL* pVarBool);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icatalogcollection-getutilinterface
    HRESULT GetUtilInterface(IDispatch* ppIDispatch);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icatalogcollection-get_datastoremajorversion
    HRESULT get_DataStoreMajorVersion(int* plMajorVersion);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icatalogcollection-get_datastoreminorversion
    HRESULT get_DataStoreMinorVersion(int* plMinorVersionl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icatalogcollection-populatebykey
    HRESULT PopulateByKey(SAFEARRAY* psaKeys);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comadmin/nf-comadmin-icatalogcollection-populatebyquery
    HRESULT PopulateByQuery(BSTR bstrQueryString, int lQueryType);
}

@GUID("cafc823c-b441-11d1-b82b-0000f8757e2a")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-isecurityidentitycoll
interface ISecurityIdentityColl : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-isecurityidentitycoll-get_count
    HRESULT get_Count(int* plCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-isecurityidentitycoll-get_item
    HRESULT get_Item(BSTR name, VARIANT* pItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-isecurityidentitycoll-get__newenum
    HRESULT get__NewEnum(IUnknown* ppEnum);
}

@GUID("cafc823d-b441-11d1-b82b-0000f8757e2a")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-isecuritycallerscoll
interface ISecurityCallersColl : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-isecuritycallerscoll-get_count
    HRESULT get_Count(int* plCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-isecuritycallerscoll-get_item
    HRESULT get_Item(int lIndex, ISecurityIdentityColl* pObj);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-isecuritycallerscoll-get__newenum
    HRESULT get__NewEnum(IUnknown* ppEnum);
}

@GUID("cafc823e-b441-11d1-b82b-0000f8757e2a")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-isecuritycallcontext
interface ISecurityCallContext : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-isecuritycallcontext-get_count
    HRESULT get_Count(int* plCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-isecuritycallcontext-get_item
    HRESULT get_Item(BSTR name, VARIANT* pItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-isecuritycallcontext-get__newenum
    HRESULT get__NewEnum(IUnknown* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-isecuritycallcontext-iscallerinrole
    HRESULT IsCallerInRole(BSTR bstrRole, VARIANT_BOOL* pfInRole);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-isecuritycallcontext-issecurityenabled
    HRESULT IsSecurityEnabled(VARIANT_BOOL* pfIsEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-isecuritycallcontext-isuserinrole
    HRESULT IsUserInRole(VARIANT* pUser, BSTR bstrRole, VARIANT_BOOL* pfInRole);
}

@GUID("cafc823f-b441-11d1-b82b-0000f8757e2a")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-igetsecuritycallcontext
interface IGetSecurityCallContext : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-igetsecuritycallcontext-getsecuritycallcontext
    HRESULT GetSecurityCallContext(ISecurityCallContext* ppObject);
}

@GUID("e74a7215-014d-11d1-a63c-00a0c911b4e0")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-securityproperty
interface SecurityProperty : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-securityproperty-getdirectcallername
    HRESULT GetDirectCallerName(BSTR* bstrUserName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-securityproperty-getdirectcreatorname
    HRESULT GetDirectCreatorName(BSTR* bstrUserName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-securityproperty-getoriginalcallername
    HRESULT GetOriginalCallerName(BSTR* bstrUserName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-securityproperty-getoriginalcreatorname
    HRESULT GetOriginalCreatorName(BSTR* bstrUserName);
}

@GUID("19a5a02c-0ac8-11d2-b286-00c04f8ef934")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-contextinfo
interface ContextInfo : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-contextinfo-isintransaction
    HRESULT IsInTransaction(VARIANT_BOOL* pbIsInTx);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-contextinfo-gettransaction
    HRESULT GetTransaction(IUnknown* ppTx);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-contextinfo-gettransactionid
    HRESULT GetTransactionId(BSTR* pbstrTxId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-contextinfo-getactivityid
    HRESULT GetActivityId(BSTR* pbstrActivityId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-contextinfo-getcontextid
    HRESULT GetContextId(BSTR* pbstrCtxId);
}

@GUID("c99d6e75-2375-11d4-8331-00c04f605588")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-contextinfo2
interface ContextInfo2 : ContextInfo
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-contextinfo2-getpartitionid
    HRESULT GetPartitionId(BSTR* __MIDL__ContextInfo20000);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-contextinfo2-getapplicationid
    HRESULT GetApplicationId(BSTR* __MIDL__ContextInfo20001);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-contextinfo2-getapplicationinstanceid
    HRESULT GetApplicationInstanceId(BSTR* __MIDL__ContextInfo20002);
}

@GUID("74c08646-cedb-11cf-8b49-00aa00b8a790")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-objectcontext
interface ObjectContext : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-objectcontext-createinstance
    HRESULT CreateInstance(BSTR bstrProgID, VARIANT* pObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-objectcontext-setcomplete
    HRESULT SetComplete();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-objectcontext-setabort
    HRESULT SetAbort();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-objectcontext-enablecommit
    HRESULT EnableCommit();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-objectcontext-disablecommit
    HRESULT DisableCommit();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-objectcontext-isintransaction
    HRESULT IsInTransaction(VARIANT_BOOL* pbIsInTx);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-objectcontext-issecurityenabled
    HRESULT IsSecurityEnabled(VARIANT_BOOL* pbIsEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-objectcontext-iscallerinrole
    HRESULT IsCallerInRole(BSTR bstrRole, VARIANT_BOOL* pbInRole);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-objectcontext-get_count
    HRESULT get_Count(int* plCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-objectcontext-get_item
    HRESULT get_Item(BSTR name, VARIANT* pItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-objectcontext-get__newenum
    HRESULT get__NewEnum(IUnknown* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-objectcontext-get_security
    HRESULT get_Security(SecurityProperty* ppSecurityProperty);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-objectcontext-get_contextinfo
    HRESULT get_ContextInfo(ContextInfo* ppContextInfo);
}

@GUID("7999fc22-d3c6-11cf-acab-00a024a55aef")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-itransactioncontextex
interface ITransactionContextEx : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-itransactioncontextex-createinstance
    HRESULT CreateInstance(const(GUID)* rclsid, const(GUID)* riid, void** pObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-itransactioncontextex-commit
    HRESULT Commit();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-itransactioncontextex-abort
    HRESULT Abort();
}

@GUID("7999fc21-d3c6-11cf-acab-00a024a55aef")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-itransactioncontext
interface ITransactionContext : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-itransactioncontext-createinstance
    HRESULT CreateInstance(BSTR pszProgId, VARIANT* pObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-itransactioncontext-commit
    HRESULT Commit();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-itransactioncontext-abort
    HRESULT Abort();
}

@GUID("455acf57-5345-11d2-99cf-00c04f797bc9")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-icreatewithtransactionex
interface ICreateWithTransactionEx : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icreatewithtransactionex-createinstance
    HRESULT CreateInstance(ITransaction pTransaction, const(GUID)* rclsid, const(GUID)* riid, void** pObject);
}

@GUID("227ac7a8-8423-42ce-b7cf-03061ec9aaa3")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-icreatewithlocaltransaction
interface ICreateWithLocalTransaction : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icreatewithlocaltransaction-createinstancewithsystx
    HRESULT CreateInstanceWithSysTx(IUnknown pTransaction, const(GUID)* rclsid, const(GUID)* riid, void** pObject);
}

@GUID("455acf59-5345-11d2-99cf-00c04f797bc9")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-icreatewithtiptransactionex
interface ICreateWithTipTransactionEx : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icreatewithtiptransactionex-createinstance
    HRESULT CreateInstance(BSTR bstrTipUrl, const(GUID)* rclsid, const(GUID)* riid, void** pObject);
}

@GUID("605cf82c-578e-4298-975d-82babcd9e053")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-icomltxevents
interface IComLTxEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomltxevents-onltxtransactionstart
    HRESULT OnLtxTransactionStart(COMSVCSEVENTINFO* pInfo, GUID guidLtx, GUID tsid, BOOL fRoot, 
                                  int nIsolationLevel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomltxevents-onltxtransactionprepare
    HRESULT OnLtxTransactionPrepare(COMSVCSEVENTINFO* pInfo, GUID guidLtx, BOOL fVote);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomltxevents-onltxtransactionabort
    HRESULT OnLtxTransactionAbort(COMSVCSEVENTINFO* pInfo, GUID guidLtx);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomltxevents-onltxtransactioncommit
    HRESULT OnLtxTransactionCommit(COMSVCSEVENTINFO* pInfo, GUID guidLtx);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomltxevents-onltxtransactionpromote
    HRESULT OnLtxTransactionPromote(COMSVCSEVENTINFO* pInfo, GUID guidLtx, GUID txnId);
}

@GUID("683130a4-2e50-11d2-98a5-00c04f8ee1c4")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-icomuserevent
interface IComUserEvent : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomuserevent-onuserevent
    HRESULT OnUserEvent(COMSVCSEVENTINFO* pInfo, VARIANT* pvarEvent);
}

@GUID("683130a5-2e50-11d2-98a5-00c04f8ee1c4")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-icomthreadevents
interface IComThreadEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomthreadevents-onthreadstart
    HRESULT OnThreadStart(COMSVCSEVENTINFO* pInfo, ulong ThreadID, uint dwThread, uint dwTheadCnt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomthreadevents-onthreadterminate
    HRESULT OnThreadTerminate(COMSVCSEVENTINFO* pInfo, ulong ThreadID, uint dwThread, uint dwTheadCnt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomthreadevents-onthreadbindtoapartment
    HRESULT OnThreadBindToApartment(COMSVCSEVENTINFO* pInfo, ulong ThreadID, ulong AptID, uint dwActCnt, 
                                    uint dwLowCnt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomthreadevents-onthreadunbind
    HRESULT OnThreadUnBind(COMSVCSEVENTINFO* pInfo, ulong ThreadID, ulong AptID, uint dwActCnt);
    HRESULT OnThreadWorkEnque(COMSVCSEVENTINFO* pInfo, ulong ThreadID, ulong MsgWorkID, uint QueueLen);
    HRESULT OnThreadWorkPrivate(COMSVCSEVENTINFO* pInfo, ulong ThreadID, ulong MsgWorkID);
    HRESULT OnThreadWorkPublic(COMSVCSEVENTINFO* pInfo, ulong ThreadID, ulong MsgWorkID, uint QueueLen);
    HRESULT OnThreadWorkRedirect(COMSVCSEVENTINFO* pInfo, ulong ThreadID, ulong MsgWorkID, uint QueueLen, 
                                 ulong ThreadNum);
    HRESULT OnThreadWorkReject(COMSVCSEVENTINFO* pInfo, ulong ThreadID, ulong MsgWorkID, uint QueueLen);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomthreadevents-onthreadassignapartment
    HRESULT OnThreadAssignApartment(COMSVCSEVENTINFO* pInfo, const(GUID)* guidActivity, ulong AptID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomthreadevents-onthreadunassignapartment
    HRESULT OnThreadUnassignApartment(COMSVCSEVENTINFO* pInfo, ulong AptID);
}

@GUID("683130a6-2e50-11d2-98a5-00c04f8ee1c4")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-icomappevents
interface IComAppEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomappevents-onappactivation
    HRESULT OnAppActivation(COMSVCSEVENTINFO* pInfo, GUID guidApp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomappevents-onappshutdown
    HRESULT OnAppShutdown(COMSVCSEVENTINFO* pInfo, GUID guidApp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomappevents-onappforceshutdown
    HRESULT OnAppForceShutdown(COMSVCSEVENTINFO* pInfo, GUID guidApp);
}

@GUID("683130a7-2e50-11d2-98a5-00c04f8ee1c4")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-icominstanceevents
interface IComInstanceEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icominstanceevents-onobjectcreate
    HRESULT OnObjectCreate(COMSVCSEVENTINFO* pInfo, const(GUID)* guidActivity, const(GUID)* clsid, 
                           const(GUID)* tsid, ulong CtxtID, ulong ObjectID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icominstanceevents-onobjectdestroy
    HRESULT OnObjectDestroy(COMSVCSEVENTINFO* pInfo, ulong CtxtID);
}

@GUID("683130a8-2e50-11d2-98a5-00c04f8ee1c4")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-icomtransactionevents
interface IComTransactionEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomtransactionevents-ontransactionstart
    HRESULT OnTransactionStart(COMSVCSEVENTINFO* pInfo, const(GUID)* guidTx, const(GUID)* tsid, BOOL fRoot);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomtransactionevents-ontransactionprepare
    HRESULT OnTransactionPrepare(COMSVCSEVENTINFO* pInfo, const(GUID)* guidTx, BOOL fVoteYes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomtransactionevents-ontransactionabort
    HRESULT OnTransactionAbort(COMSVCSEVENTINFO* pInfo, const(GUID)* guidTx);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomtransactionevents-ontransactioncommit
    HRESULT OnTransactionCommit(COMSVCSEVENTINFO* pInfo, const(GUID)* guidTx);
}

@GUID("683130a9-2e50-11d2-98a5-00c04f8ee1c4")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-icommethodevents
interface IComMethodEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icommethodevents-onmethodcall
    HRESULT OnMethodCall(COMSVCSEVENTINFO* pInfo, ulong oid, const(GUID)* guidCid, const(GUID)* guidRid, 
                         uint iMeth);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icommethodevents-onmethodreturn
    HRESULT OnMethodReturn(COMSVCSEVENTINFO* pInfo, ulong oid, const(GUID)* guidCid, const(GUID)* guidRid, 
                           uint iMeth, HRESULT hresult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icommethodevents-onmethodexception
    HRESULT OnMethodException(COMSVCSEVENTINFO* pInfo, ulong oid, const(GUID)* guidCid, const(GUID)* guidRid, 
                              uint iMeth);
}

@GUID("683130aa-2e50-11d2-98a5-00c04f8ee1c4")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-icomobjectevents
interface IComObjectEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomobjectevents-onobjectactivate
    HRESULT OnObjectActivate(COMSVCSEVENTINFO* pInfo, ulong CtxtID, ulong ObjectID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomobjectevents-onobjectdeactivate
    HRESULT OnObjectDeactivate(COMSVCSEVENTINFO* pInfo, ulong CtxtID, ulong ObjectID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomobjectevents-ondisablecommit
    HRESULT OnDisableCommit(COMSVCSEVENTINFO* pInfo, ulong CtxtID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomobjectevents-onenablecommit
    HRESULT OnEnableCommit(COMSVCSEVENTINFO* pInfo, ulong CtxtID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomobjectevents-onsetcomplete
    HRESULT OnSetComplete(COMSVCSEVENTINFO* pInfo, ulong CtxtID);
    HRESULT OnSetAbort(COMSVCSEVENTINFO* pInfo, ulong CtxtID);
}

@GUID("683130ab-2e50-11d2-98a5-00c04f8ee1c4")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-icomresourceevents
interface IComResourceEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomresourceevents-onresourcecreate
    HRESULT OnResourceCreate(COMSVCSEVENTINFO* pInfo, ulong ObjectID, const(PWSTR) pszType, ulong resId, 
                             BOOL enlisted);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomresourceevents-onresourceallocate
    HRESULT OnResourceAllocate(COMSVCSEVENTINFO* pInfo, ulong ObjectID, const(PWSTR) pszType, ulong resId, 
                               BOOL enlisted, uint NumRated, uint Rating);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomresourceevents-onresourcerecycle
    HRESULT OnResourceRecycle(COMSVCSEVENTINFO* pInfo, ulong ObjectID, const(PWSTR) pszType, ulong resId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomresourceevents-onresourcedestroy
    HRESULT OnResourceDestroy(COMSVCSEVENTINFO* pInfo, ulong ObjectID, HRESULT hr, const(PWSTR) pszType, 
                              ulong resId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomresourceevents-onresourcetrack
    HRESULT OnResourceTrack(COMSVCSEVENTINFO* pInfo, ulong ObjectID, const(PWSTR) pszType, ulong resId, 
                            BOOL enlisted);
}

@GUID("683130ac-2e50-11d2-98a5-00c04f8ee1c4")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-icomsecurityevents
interface IComSecurityEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomsecurityevents-onauthenticate
    HRESULT OnAuthenticate(COMSVCSEVENTINFO* pInfo, const(GUID)* guidActivity, ulong ObjectID, 
                           const(GUID)* guidIID, uint iMeth, uint cbByteOrig, ubyte* pSidOriginalUser, 
                           uint cbByteCur, ubyte* pSidCurrentUser, BOOL bCurrentUserInpersonatingInProc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomsecurityevents-onauthenticatefail
    HRESULT OnAuthenticateFail(COMSVCSEVENTINFO* pInfo, const(GUID)* guidActivity, ulong ObjectID, 
                               const(GUID)* guidIID, uint iMeth, uint cbByteOrig, ubyte* pSidOriginalUser, 
                               uint cbByteCur, ubyte* pSidCurrentUser, BOOL bCurrentUserInpersonatingInProc);
}

@GUID("683130ad-2e50-11d2-98a5-00c04f8ee1c4")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-icomobjectpoolevents
interface IComObjectPoolEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomobjectpoolevents-onobjpoolputobject
    HRESULT OnObjPoolPutObject(COMSVCSEVENTINFO* pInfo, const(GUID)* guidObject, int nReason, uint dwAvailable, 
                               ulong oid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomobjectpoolevents-onobjpoolgetobject
    HRESULT OnObjPoolGetObject(COMSVCSEVENTINFO* pInfo, const(GUID)* guidActivity, const(GUID)* guidObject, 
                               uint dwAvailable, ulong oid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomobjectpoolevents-onobjpoolrecycletotx
    HRESULT OnObjPoolRecycleToTx(COMSVCSEVENTINFO* pInfo, const(GUID)* guidActivity, const(GUID)* guidObject, 
                                 const(GUID)* guidTx, ulong objid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomobjectpoolevents-onobjpoolgetfromtx
    HRESULT OnObjPoolGetFromTx(COMSVCSEVENTINFO* pInfo, const(GUID)* guidActivity, const(GUID)* guidObject, 
                               const(GUID)* guidTx, ulong objid);
}

@GUID("683130ae-2e50-11d2-98a5-00c04f8ee1c4")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-icomobjectpoolevents2
interface IComObjectPoolEvents2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomobjectpoolevents2-onobjpoolcreateobject
    HRESULT OnObjPoolCreateObject(COMSVCSEVENTINFO* pInfo, const(GUID)* guidObject, uint dwObjsCreated, ulong oid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomobjectpoolevents2-onobjpooldestroyobject
    HRESULT OnObjPoolDestroyObject(COMSVCSEVENTINFO* pInfo, const(GUID)* guidObject, uint dwObjsCreated, ulong oid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomobjectpoolevents2-onobjpoolcreatedecision
    HRESULT OnObjPoolCreateDecision(COMSVCSEVENTINFO* pInfo, uint dwThreadsWaiting, uint dwAvail, uint dwCreated, 
                                    uint dwMin, uint dwMax);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomobjectpoolevents2-onobjpooltimeout
    HRESULT OnObjPoolTimeout(COMSVCSEVENTINFO* pInfo, const(GUID)* guidObject, const(GUID)* guidActivity, 
                             uint dwTimeout);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomobjectpoolevents2-onobjpoolcreatepool
    HRESULT OnObjPoolCreatePool(COMSVCSEVENTINFO* pInfo, const(GUID)* guidObject, uint dwMin, uint dwMax, 
                                uint dwTimeout);
}

@GUID("683130af-2e50-11d2-98a5-00c04f8ee1c4")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-icomobjectconstructionevents
interface IComObjectConstructionEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomobjectconstructionevents-onobjectconstruct
    HRESULT OnObjectConstruct(COMSVCSEVENTINFO* pInfo, const(GUID)* guidObject, const(PWSTR) sConstructString, 
                              ulong oid);
}

@GUID("683130b0-2e50-11d2-98a5-00c04f8ee1c4")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-icomactivityevents
interface IComActivityEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomactivityevents-onactivitycreate
    HRESULT OnActivityCreate(COMSVCSEVENTINFO* pInfo, const(GUID)* guidActivity);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomactivityevents-onactivitydestroy
    HRESULT OnActivityDestroy(COMSVCSEVENTINFO* pInfo, const(GUID)* guidActivity);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomactivityevents-onactivityenter
    HRESULT OnActivityEnter(COMSVCSEVENTINFO* pInfo, const(GUID)* guidCurrent, const(GUID)* guidEntered, 
                            uint dwThread);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomactivityevents-onactivitytimeout
    HRESULT OnActivityTimeout(COMSVCSEVENTINFO* pInfo, const(GUID)* guidCurrent, const(GUID)* guidEntered, 
                              uint dwThread, uint dwTimeout);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomactivityevents-onactivityreenter
    HRESULT OnActivityReenter(COMSVCSEVENTINFO* pInfo, const(GUID)* guidCurrent, uint dwThread, uint dwCallDepth);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomactivityevents-onactivityleave
    HRESULT OnActivityLeave(COMSVCSEVENTINFO* pInfo, const(GUID)* guidCurrent, const(GUID)* guidLeft);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomactivityevents-onactivityleavesame
    HRESULT OnActivityLeaveSame(COMSVCSEVENTINFO* pInfo, const(GUID)* guidCurrent, uint dwCallDepth);
}

@GUID("683130b1-2e50-11d2-98a5-00c04f8ee1c4")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-icomidentityevents
interface IComIdentityEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomidentityevents-oniisrequestinfo
    HRESULT OnIISRequestInfo(COMSVCSEVENTINFO* pInfo, ulong ObjId, const(PWSTR) pszClientIP, 
                             const(PWSTR) pszServerIP, const(PWSTR) pszURL);
}

@GUID("683130b2-2e50-11d2-98a5-00c04f8ee1c4")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-icomqcevents
interface IComQCEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomqcevents-onqcrecord
    HRESULT OnQCRecord(COMSVCSEVENTINFO* pInfo, ulong objid, PWSTR szQueue, const(GUID)* guidMsgId, 
                       const(GUID)* guidWorkFlowId, HRESULT msmqhr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomqcevents-onqcqueueopen
    HRESULT OnQCQueueOpen(COMSVCSEVENTINFO* pInfo, PWSTR szQueue, ulong QueueID, HRESULT hr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomqcevents-onqcreceive
    HRESULT OnQCReceive(COMSVCSEVENTINFO* pInfo, ulong QueueID, const(GUID)* guidMsgId, 
                        const(GUID)* guidWorkFlowId, HRESULT hr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomqcevents-onqcreceivefail
    HRESULT OnQCReceiveFail(COMSVCSEVENTINFO* pInfo, ulong QueueID, HRESULT msmqhr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomqcevents-onqcmovetoretryqueue
    HRESULT OnQCMoveToReTryQueue(COMSVCSEVENTINFO* pInfo, const(GUID)* guidMsgId, const(GUID)* guidWorkFlowId, 
                                 uint RetryIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomqcevents-onqcmovetodeadqueue
    HRESULT OnQCMoveToDeadQueue(COMSVCSEVENTINFO* pInfo, const(GUID)* guidMsgId, const(GUID)* guidWorkFlowId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomqcevents-onqcplayback
    HRESULT OnQCPlayback(COMSVCSEVENTINFO* pInfo, ulong objid, const(GUID)* guidMsgId, const(GUID)* guidWorkFlowId, 
                         HRESULT hr);
}

@GUID("683130b3-2e50-11d2-98a5-00c04f8ee1c4")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-icomexceptionevents
interface IComExceptionEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomexceptionevents-onexceptionuser
    HRESULT OnExceptionUser(COMSVCSEVENTINFO* pInfo, uint code, ulong address, const(PWSTR) pszStackTrace);
}

@GUID("683130b4-2e50-11d2-98a5-00c04f8ee1c4")
interface ILBEvents : IUnknown
{
    HRESULT TargetUp(BSTR bstrServerName, BSTR bstrClsidEng);
    HRESULT TargetDown(BSTR bstrServerName, BSTR bstrClsidEng);
    HRESULT EngineDefined(BSTR bstrPropName, VARIANT* varPropValue, BSTR bstrClsidEng);
}

@GUID("683130b5-2e50-11d2-98a5-00c04f8ee1c4")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-icomcrmevents
interface IComCRMEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomcrmevents-oncrmrecoverystart
    HRESULT OnCRMRecoveryStart(COMSVCSEVENTINFO* pInfo, GUID guidApp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomcrmevents-oncrmrecoverydone
    HRESULT OnCRMRecoveryDone(COMSVCSEVENTINFO* pInfo, GUID guidApp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomcrmevents-oncrmcheckpoint
    HRESULT OnCRMCheckpoint(COMSVCSEVENTINFO* pInfo, GUID guidApp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomcrmevents-oncrmbegin
    HRESULT OnCRMBegin(COMSVCSEVENTINFO* pInfo, GUID guidClerkCLSID, GUID guidActivity, GUID guidTx, 
                       PWSTR szProgIdCompensator, PWSTR szDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomcrmevents-oncrmprepare
    HRESULT OnCRMPrepare(COMSVCSEVENTINFO* pInfo, GUID guidClerkCLSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomcrmevents-oncrmcommit
    HRESULT OnCRMCommit(COMSVCSEVENTINFO* pInfo, GUID guidClerkCLSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomcrmevents-oncrmabort
    HRESULT OnCRMAbort(COMSVCSEVENTINFO* pInfo, GUID guidClerkCLSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomcrmevents-oncrmindoubt
    HRESULT OnCRMIndoubt(COMSVCSEVENTINFO* pInfo, GUID guidClerkCLSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomcrmevents-oncrmdone
    HRESULT OnCRMDone(COMSVCSEVENTINFO* pInfo, GUID guidClerkCLSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomcrmevents-oncrmrelease
    HRESULT OnCRMRelease(COMSVCSEVENTINFO* pInfo, GUID guidClerkCLSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomcrmevents-oncrmanalyze
    HRESULT OnCRMAnalyze(COMSVCSEVENTINFO* pInfo, GUID guidClerkCLSID, uint dwCrmRecordType, uint dwRecordSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomcrmevents-oncrmwrite
    HRESULT OnCRMWrite(COMSVCSEVENTINFO* pInfo, GUID guidClerkCLSID, BOOL fVariants, uint dwRecordSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomcrmevents-oncrmforget
    HRESULT OnCRMForget(COMSVCSEVENTINFO* pInfo, GUID guidClerkCLSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomcrmevents-oncrmforce
    HRESULT OnCRMForce(COMSVCSEVENTINFO* pInfo, GUID guidClerkCLSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomcrmevents-oncrmdeliver
    HRESULT OnCRMDeliver(COMSVCSEVENTINFO* pInfo, GUID guidClerkCLSID, BOOL fVariants, uint dwRecordSize);
}

@GUID("fb388aaa-567d-4024-af8e-6e93ee748573")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-icommethod2events
interface IComMethod2Events : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icommethod2events-onmethodcall2
    HRESULT OnMethodCall2(COMSVCSEVENTINFO* pInfo, ulong oid, const(GUID)* guidCid, const(GUID)* guidRid, 
                          uint dwThread, uint iMeth);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icommethod2events-onmethodreturn2
    HRESULT OnMethodReturn2(COMSVCSEVENTINFO* pInfo, ulong oid, const(GUID)* guidCid, const(GUID)* guidRid, 
                            uint dwThread, uint iMeth, HRESULT hresult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icommethod2events-onmethodexception2
    HRESULT OnMethodException2(COMSVCSEVENTINFO* pInfo, ulong oid, const(GUID)* guidCid, const(GUID)* guidRid, 
                               uint dwThread, uint iMeth);
}

@GUID("4e6cdcc9-fb25-4fd5-9cc5-c9f4b6559cec")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-icomtrackinginfoevents
interface IComTrackingInfoEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomtrackinginfoevents-onnewtrackinginfo
    HRESULT OnNewTrackingInfo(IUnknown pToplevelCollection);
}

@GUID("c266c677-c9ad-49ab-9fd9-d9661078588a")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-icomtrackinginfocollection
interface IComTrackingInfoCollection : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomtrackinginfocollection-type
    HRESULT Type(TRACKING_COLL_TYPE* pType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomtrackinginfocollection-count
    HRESULT Count(uint* pCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomtrackinginfocollection-item
    HRESULT Item(uint ulIndex, const(GUID)* riid, void** ppv);
}

@GUID("116e42c5-d8b1-47bf-ab1e-c895ed3e2372")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-icomtrackinginfoobject
interface IComTrackingInfoObject : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomtrackinginfoobject-getvalue
    HRESULT GetValue(PWSTR szPropertyName, VARIANT* pvarOut);
}

@GUID("789b42be-6f6b-443a-898e-67abf390aa14")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-icomtrackinginfoproperties
interface IComTrackingInfoProperties : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomtrackinginfoproperties-propcount
    HRESULT PropCount(uint* pCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomtrackinginfoproperties-getpropname
    HRESULT GetPropName(uint ulIndex, PWSTR* ppszPropName);
}

@GUID("1290bc1a-b219-418d-b078-5934ded08242")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-icomapp2events
interface IComApp2Events : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomapp2events-onappactivation2
    HRESULT OnAppActivation2(COMSVCSEVENTINFO* pInfo, GUID guidApp, GUID guidProcess);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomapp2events-onappshutdown2
    HRESULT OnAppShutdown2(COMSVCSEVENTINFO* pInfo, GUID guidApp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomapp2events-onappforceshutdown2
    HRESULT OnAppForceShutdown2(COMSVCSEVENTINFO* pInfo, GUID guidApp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomapp2events-onapppaused2
    HRESULT OnAppPaused2(COMSVCSEVENTINFO* pInfo, GUID guidApp, BOOL bPaused);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomapp2events-onapprecycle2
    HRESULT OnAppRecycle2(COMSVCSEVENTINFO* pInfo, GUID guidApp, GUID guidProcess, int lReason);
}

@GUID("a136f62a-2f94-4288-86e0-d8a1fa4c0299")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-icomtransaction2events
interface IComTransaction2Events : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomtransaction2events-ontransactionstart2
    HRESULT OnTransactionStart2(COMSVCSEVENTINFO* pInfo, const(GUID)* guidTx, const(GUID)* tsid, BOOL fRoot, 
                                int nIsolationLevel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomtransaction2events-ontransactionprepare2
    HRESULT OnTransactionPrepare2(COMSVCSEVENTINFO* pInfo, const(GUID)* guidTx, BOOL fVoteYes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomtransaction2events-ontransactionabort2
    HRESULT OnTransactionAbort2(COMSVCSEVENTINFO* pInfo, const(GUID)* guidTx);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomtransaction2events-ontransactioncommit2
    HRESULT OnTransactionCommit2(COMSVCSEVENTINFO* pInfo, const(GUID)* guidTx);
}

@GUID("20e3bf07-b506-4ad5-a50c-d2ca5b9c158e")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-icominstance2events
interface IComInstance2Events : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icominstance2events-onobjectcreate2
    HRESULT OnObjectCreate2(COMSVCSEVENTINFO* pInfo, const(GUID)* guidActivity, const(GUID)* clsid, 
                            const(GUID)* tsid, ulong CtxtID, ulong ObjectID, const(GUID)* guidPartition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icominstance2events-onobjectdestroy2
    HRESULT OnObjectDestroy2(COMSVCSEVENTINFO* pInfo, ulong CtxtID);
}

@GUID("65bf6534-85ea-4f64-8cf4-3d974b2ab1cf")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-icomobjectpool2events
interface IComObjectPool2Events : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomobjectpool2events-onobjpoolputobject2
    HRESULT OnObjPoolPutObject2(COMSVCSEVENTINFO* pInfo, const(GUID)* guidObject, int nReason, uint dwAvailable, 
                                ulong oid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomobjectpool2events-onobjpoolgetobject2
    HRESULT OnObjPoolGetObject2(COMSVCSEVENTINFO* pInfo, const(GUID)* guidActivity, const(GUID)* guidObject, 
                                uint dwAvailable, ulong oid, const(GUID)* guidPartition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomobjectpool2events-onobjpoolrecycletotx2
    HRESULT OnObjPoolRecycleToTx2(COMSVCSEVENTINFO* pInfo, const(GUID)* guidActivity, const(GUID)* guidObject, 
                                  const(GUID)* guidTx, ulong objid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomobjectpool2events-onobjpoolgetfromtx2
    HRESULT OnObjPoolGetFromTx2(COMSVCSEVENTINFO* pInfo, const(GUID)* guidActivity, const(GUID)* guidObject, 
                                const(GUID)* guidTx, ulong objid, const(GUID)* guidPartition);
}

@GUID("4b5a7827-8df2-45c0-8f6f-57ea1f856a9f")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-icomobjectconstruction2events
interface IComObjectConstruction2Events : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomobjectconstruction2events-onobjectconstruct2
    HRESULT OnObjectConstruct2(COMSVCSEVENTINFO* pInfo, const(GUID)* guidObject, const(PWSTR) sConstructString, 
                               ulong oid, const(GUID)* guidPartition);
}

@GUID("d6d48a3c-d5c5-49e7-8c74-99e4889ed52f")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-isystemappeventdata
interface ISystemAppEventData : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-isystemappeventdata-startup
    HRESULT Startup();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-isystemappeventdata-ondatachanged
    HRESULT OnDataChanged(uint dwPID, uint dwMask, uint dwNumberSinks, BSTR bstrDwMethodMask, uint dwReason, 
                          ulong u64TraceHandle);
}

@GUID("bacedf4d-74ab-11d0-b162-00aa00ba3258")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-imtsevents
interface IMtsEvents : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-imtsevents-get_packagename
    HRESULT get_PackageName(BSTR* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-imtsevents-get_packageguid
    HRESULT get_PackageGuid(BSTR* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-imtsevents-postevent
    HRESULT PostEvent(VARIANT* vEvent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-imtsevents-get_fireevents
    HRESULT get_FireEvents(VARIANT_BOOL* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-imtsevents-getprocessid
    HRESULT GetProcessID(int* id);
}

@GUID("d56c3dc1-8482-11d0-b170-00aa00ba3258")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-imtseventinfo
interface IMtsEventInfo : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-imtseventinfo-get_names
    HRESULT get_Names(IUnknown* pUnk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-imtseventinfo-get_displayname
    HRESULT get_DisplayName(BSTR* sDisplayName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-imtseventinfo-get_eventid
    HRESULT get_EventID(BSTR* sGuidEventID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-imtseventinfo-get_count
    HRESULT get_Count(int* lCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-imtseventinfo-get_value
    HRESULT get_Value(BSTR sKey, VARIANT* pVal);
}

@GUID("d19b8bfd-7f88-11d0-b16e-00aa00ba3258")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-imtslocator
interface IMTSLocator : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-imtslocator-geteventdispatcher
    HRESULT GetEventDispatcher(IUnknown* pUnk);
}

@GUID("4b2e958c-0393-11d1-b1ab-00aa00ba3258")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-imtsgrp
interface IMtsGrp : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-imtsgrp-get_count
    HRESULT get_Count(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-imtsgrp-item
    HRESULT Item(int lIndex, IUnknown* ppUnkDispatcher);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-imtsgrp-refresh
    HRESULT Refresh();
}

@GUID("588a085a-b795-11d1-8054-00c04fc340ee")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-imessagemover
interface IMessageMover : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-imessagemover-get_sourcepath
    HRESULT get_SourcePath(BSTR* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-imessagemover-put_sourcepath
    HRESULT put_SourcePath(BSTR newVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-imessagemover-get_destpath
    HRESULT get_DestPath(BSTR* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-imessagemover-put_destpath
    HRESULT put_DestPath(BSTR newVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-imessagemover-get_commitbatchsize
    HRESULT get_CommitBatchSize(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-imessagemover-put_commitbatchsize
    HRESULT put_CommitBatchSize(int newVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-imessagemover-movemessages
    HRESULT MoveMessages(int* plMessagesMoved);
}

@GUID("9a9f12b8-80af-47ab-a579-35ea57725370")
interface IEventServerTrace : IDispatch
{
    HRESULT StartTraceGuid(BSTR bstrguidEvent, BSTR bstrguidFilter, int lPidFilter);
    HRESULT StopTraceGuid(BSTR bstrguidEvent, BSTR bstrguidFilter, int lPidFilter);
    HRESULT EnumTraceGuid(int* plCntGuids, BSTR* pbstrGuidList);
}

@GUID("507c3ac8-3e12-4cb0-9366-653d3e050638")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-igetapptrackerdata
interface IGetAppTrackerData : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-igetapptrackerdata-getapplicationprocesses
    HRESULT GetApplicationProcesses(const(GUID)* PartitionId, const(GUID)* ApplicationId, uint Flags, 
                                    uint* NumApplicationProcesses, ApplicationProcessSummary** ApplicationProcesses);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-igetapptrackerdata-getapplicationprocessdetails
    HRESULT GetApplicationProcessDetails(const(GUID)* ApplicationInstanceId, uint ProcessId, uint Flags, 
                                         ApplicationProcessSummary* Summary, 
                                         ApplicationProcessStatistics* Statistics, 
                                         ApplicationProcessRecycleInfo* RecycleInfo, 
                                         BOOL* AnyComponentsHangMonitored);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-igetapptrackerdata-getapplicationsinprocess
    HRESULT GetApplicationsInProcess(const(GUID)* ApplicationInstanceId, uint ProcessId, const(GUID)* PartitionId, 
                                     uint Flags, uint* NumApplicationsInProcess, ApplicationSummary** Applications);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-igetapptrackerdata-getcomponentsinprocess
    HRESULT GetComponentsInProcess(const(GUID)* ApplicationInstanceId, uint ProcessId, const(GUID)* PartitionId, 
                                   const(GUID)* ApplicationId, uint Flags, uint* NumComponentsInProcess, 
                                   ComponentSummary** Components);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-igetapptrackerdata-getcomponentdetails
    HRESULT GetComponentDetails(const(GUID)* ApplicationInstanceId, uint ProcessId, const(GUID)* Clsid, uint Flags, 
                                ComponentSummary* Summary, ComponentStatistics* Statistics, 
                                ComponentHangMonitorInfo* HangMonitorInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-igetapptrackerdata-gettrackerdataascollectionobject
    HRESULT GetTrackerDataAsCollectionObject(IUnknown* TopLevelCollection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-igetapptrackerdata-getsuggestedpollinginterval
    HRESULT GetSuggestedPollingInterval(uint* PollingIntervalInSeconds);
}

@GUID("5cb31e10-2b5f-11cf-be10-00aa00a2fa25")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-idispensermanager
interface IDispenserManager : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-idispensermanager-registerdispenser
    HRESULT RegisterDispenser(IDispenserDriver __MIDL__IDispenserManager0000, const(PWSTR) szDispenserName, 
                              IHolder* __MIDL__IDispenserManager0001);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-idispensermanager-getcontext
    HRESULT GetContext(size_t* __MIDL__IDispenserManager0002, size_t* __MIDL__IDispenserManager0003);
}

@GUID("bf6a1850-2b45-11cf-be10-00aa00a2fa25")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-iholder
interface IHolder : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iholder-allocresource
    HRESULT AllocResource(const(size_t) __MIDL__IHolder0000, size_t* __MIDL__IHolder0001);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iholder-freeresource
    HRESULT FreeResource(const(size_t) __MIDL__IHolder0002);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iholder-trackresource
    HRESULT TrackResource(const(size_t) __MIDL__IHolder0003);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iholder-trackresources
    HRESULT TrackResourceS(ushort* __MIDL__IHolder0004);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iholder-untrackresource
    HRESULT UntrackResource(const(size_t) __MIDL__IHolder0005, const(BOOL) __MIDL__IHolder0006);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iholder-untrackresources
    HRESULT UntrackResourceS(ushort* __MIDL__IHolder0007, const(BOOL) __MIDL__IHolder0008);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iholder-close
    HRESULT Close();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iholder-requestdestroyresource
    HRESULT RequestDestroyResource(const(size_t) __MIDL__IHolder0009);
}

@GUID("208b3651-2b48-11cf-be10-00aa00a2fa25")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-idispenserdriver
interface IDispenserDriver : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-idispenserdriver-createresource
    HRESULT CreateResource(const(size_t) ResTypId, size_t* pResId, int* pSecsFreeBeforeDestroy);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-idispenserdriver-rateresource
    HRESULT RateResource(const(size_t) ResTypId, const(size_t) ResId, const(BOOL) fRequiresTransactionEnlistment, 
                         uint* pRating);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-idispenserdriver-enlistresource
    HRESULT EnlistResource(const(size_t) ResId, const(size_t) TransId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-idispenserdriver-resetresource
    HRESULT ResetResource(const(size_t) ResId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-idispenserdriver-destroyresource
    HRESULT DestroyResource(const(size_t) ResId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-idispenserdriver-destroyresources
    HRESULT DestroyResourceS(ushort* ResId);
}

@GUID("02558374-df2e-4dae-bd6b-1d5c994f9bdc")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-itransactionproxy
interface ITransactionProxy : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-itransactionproxy-commit
    HRESULT Commit(GUID guid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-itransactionproxy-abort
    HRESULT Abort();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-itransactionproxy-promote
    HRESULT Promote(ITransaction* pTransaction);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-itransactionproxy-createvoter
    HRESULT CreateVoter(ITransactionVoterNotifyAsync2 pTxAsync, ITransactionVoterBallotAsync2* ppBallot);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-itransactionproxy-getisolationlevel
    HRESULT GetIsolationLevel(int* __MIDL__ITransactionProxy0000);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-itransactionproxy-getidentifier
    HRESULT GetIdentifier(GUID* pbstrIdentifier);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-itransactionproxy-isreusable
    HRESULT IsReusable(BOOL* pfIsReusable);
}

@GUID("a7549a29-a7c4-42e1-8dc1-7e3d748dc24a")
interface IContextSecurityPerimeter : IUnknown
{
    HRESULT GetPerimeterFlag(BOOL* pFlag);
    HRESULT SetPerimeterFlag(BOOL fFlag);
}

@GUID("13d86f31-0139-41af-bcad-c7d50435fe9f")
interface ITxProxyHolder : IUnknown
{
    void GetIdentifier(GUID* pGuidLtx);
}

@GUID("51372ae0-cae7-11cf-be81-00aa00a2fa25")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-iobjectcontext
interface IObjectContext : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iobjectcontext-createinstance
    HRESULT CreateInstance(const(GUID)* rclsid, const(GUID)* riid, void** ppv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iobjectcontext-setcomplete
    HRESULT SetComplete();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iobjectcontext-setabort
    HRESULT SetAbort();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iobjectcontext-enablecommit
    HRESULT EnableCommit();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iobjectcontext-disablecommit
    HRESULT DisableCommit();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iobjectcontext-isintransaction
    BOOL    IsInTransaction();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iobjectcontext-issecurityenabled
    BOOL    IsSecurityEnabled();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iobjectcontext-iscallerinrole
    HRESULT IsCallerInRole(BSTR bstrRole, BOOL* pfIsInRole);
}

@GUID("51372aec-cae7-11cf-be81-00aa00a2fa25")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-iobjectcontrol
interface IObjectControl : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iobjectcontrol-activate
    HRESULT Activate();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iobjectcontrol-deactivate
    void    Deactivate();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iobjectcontrol-canbepooled
    BOOL    CanBePooled();
}

@GUID("51372af2-cae7-11cf-be81-00aa00a2fa25")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-ienumnames
interface IEnumNames : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-ienumnames-next
    HRESULT Next(uint celt, BSTR* rgname, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-ienumnames-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-ienumnames-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-ienumnames-clone
    HRESULT Clone(IEnumNames* ppenum);
}

@GUID("51372aea-cae7-11cf-be81-00aa00a2fa25")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-isecurityproperty
interface ISecurityProperty : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-isecurityproperty-getdirectcreatorsid
    HRESULT GetDirectCreatorSID(PSID* pSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-isecurityproperty-getoriginalcreatorsid
    HRESULT GetOriginalCreatorSID(PSID* pSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-isecurityproperty-getdirectcallersid
    HRESULT GetDirectCallerSID(PSID* pSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-isecurityproperty-getoriginalcallersid
    HRESULT GetOriginalCallerSID(PSID* pSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-isecurityproperty-releasesid
    HRESULT ReleaseSID(PSID pSID);
}

@GUID("7dc41850-0c31-11d0-8b79-00aa00b8a790")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-objectcontrol
interface ObjectControl : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-objectcontrol-activate
    HRESULT Activate();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-objectcontrol-deactivate
    HRESULT Deactivate();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-objectcontrol-canbepooled
    HRESULT CanBePooled(VARIANT_BOOL* pbPoolable);
}

@GUID("2a005c01-a5de-11cf-9e66-00aa00a3f464")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-isharedproperty
interface ISharedProperty : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-isharedproperty-get_value
    HRESULT get_Value(VARIANT* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-isharedproperty-put_value
    HRESULT put_Value(VARIANT val);
}

@GUID("2a005c07-a5de-11cf-9e66-00aa00a3f464")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-isharedpropertygroup
interface ISharedPropertyGroup : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-isharedpropertygroup-createpropertybyposition
    HRESULT CreatePropertyByPosition(int Index, VARIANT_BOOL* fExists, ISharedProperty* ppProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-isharedpropertygroup-get_propertybyposition
    HRESULT get_PropertyByPosition(int Index, ISharedProperty* ppProperty);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-isharedpropertygroup-createproperty
    HRESULT CreateProperty(BSTR Name, VARIANT_BOOL* fExists, ISharedProperty* ppProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-isharedpropertygroup-get_property
    HRESULT get_Property(BSTR Name, ISharedProperty* ppProperty);
}

@GUID("2a005c0d-a5de-11cf-9e66-00aa00a3f464")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-isharedpropertygroupmanager
interface ISharedPropertyGroupManager : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-isharedpropertygroupmanager-createpropertygroup
    HRESULT CreatePropertyGroup(BSTR Name, int* dwIsoMode, int* dwRelMode, VARIANT_BOOL* fExists, 
                                ISharedPropertyGroup* ppGroup);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-isharedpropertygroupmanager-get_group
    HRESULT get_Group(BSTR Name, ISharedPropertyGroup* ppGroup);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-isharedpropertygroupmanager-get__newenum
    HRESULT get__NewEnum(IUnknown* retval);
}

@GUID("41c4f8b3-7439-11d2-98cb-00c04f8ee1c4")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-iobjectconstruct
interface IObjectConstruct : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iobjectconstruct-construct
    HRESULT Construct(IDispatch pCtorObj);
}

@GUID("41c4f8b2-7439-11d2-98cb-00c04f8ee1c4")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-iobjectconstructstring
interface IObjectConstructString : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iobjectconstructstring-get_constructstring
    HRESULT get_ConstructString(BSTR* pVal);
}

@GUID("51372afc-cae7-11cf-be81-00aa00a2fa25")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-iobjectcontextactivity
interface IObjectContextActivity : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iobjectcontextactivity-getactivityid
    HRESULT GetActivityId(GUID* pGUID);
}

@GUID("75b52ddb-e8ed-11d1-93ad-00aa00ba3258")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-iobjectcontextinfo
interface IObjectContextInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iobjectcontextinfo-isintransaction
    BOOL    IsInTransaction();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iobjectcontextinfo-gettransaction
    HRESULT GetTransaction(IUnknown* pptrans);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iobjectcontextinfo-gettransactionid
    HRESULT GetTransactionId(GUID* pGuid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iobjectcontextinfo-getactivityid
    HRESULT GetActivityId(GUID* pGUID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iobjectcontextinfo-getcontextid
    HRESULT GetContextId(GUID* pGuid);
}

@GUID("594be71a-4bc4-438b-9197-cfd176248b09")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-iobjectcontextinfo2
interface IObjectContextInfo2 : IObjectContextInfo
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iobjectcontextinfo2-getpartitionid
    HRESULT GetPartitionId(GUID* pGuid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iobjectcontextinfo2-getapplicationid
    HRESULT GetApplicationId(GUID* pGuid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iobjectcontextinfo2-getapplicationinstanceid
    HRESULT GetApplicationInstanceId(GUID* pGuid);
}

@GUID("61f589e8-3724-4898-a0a4-664ae9e1d1b4")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-itransactionstatus
interface ITransactionStatus : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-itransactionstatus-settransactionstatus
    HRESULT SetTransactionStatus(HRESULT hrStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-itransactionstatus-gettransactionstatus
    HRESULT GetTransactionStatus(HRESULT* pHrStatus);
}

@GUID("92fd41ca-bad9-11d2-9a2d-00c04f797bc9")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-iobjectcontexttip
interface IObjectContextTip : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iobjectcontexttip-gettipurl
    HRESULT GetTipUrl(BSTR* pTipUrl);
}

@GUID("51372afd-cae7-11cf-be81-00aa00a2fa25")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-iplaybackcontrol
interface IPlaybackControl : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iplaybackcontrol-finalclientretry
    HRESULT FinalClientRetry();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iplaybackcontrol-finalserverretry
    HRESULT FinalServerRetry();
}

@GUID("51372af4-cae7-11cf-be81-00aa00a2fa25")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-igetcontextproperties
interface IGetContextProperties : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-igetcontextproperties-count
    HRESULT Count(int* plCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-igetcontextproperties-getproperty
    HRESULT GetProperty(BSTR name, VARIANT* pProperty);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-igetcontextproperties-enumnames
    HRESULT EnumNames(IEnumNames* ppenum);
}

@GUID("3c05e54b-a42a-11d2-afc4-00c04f8ee1c4")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-icontextstate
interface IContextState : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icontextstate-setdeactivateonreturn
    HRESULT SetDeactivateOnReturn(VARIANT_BOOL bDeactivate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icontextstate-getdeactivateonreturn
    HRESULT GetDeactivateOnReturn(VARIANT_BOOL* pbDeactivate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icontextstate-setmytransactionvote
    HRESULT SetMyTransactionVote(TransactionVote txVote);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icontextstate-getmytransactionvote
    HRESULT GetMyTransactionVote(TransactionVote* ptxVote);
}

@GUID("0a469861-5a91-43a0-99b6-d5e179bb0631")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-ipoolmanager
interface IPoolManager : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-ipoolmanager-shutdownpool
    HRESULT ShutdownPool(BSTR CLSIDOrProgID);
}

@GUID("dcf443f4-3f8a-4872-b9f0-369a796d12d6")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-iselectcomlbserver
interface ISelectCOMLBServer : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iselectcomlbserver-init
    HRESULT Init();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iselectcomlbserver-getlbserver
    HRESULT GetLBServer(IUnknown pUnk);
}

@GUID("3a0f150f-8ee5-4b94-b40e-aef2f9e42ed2")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-icomlbarguments
interface ICOMLBArguments : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomlbarguments-getclsid
    HRESULT GetCLSID(GUID* pCLSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomlbarguments-setclsid
    HRESULT SetCLSID(GUID* pCLSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomlbarguments-getmachinename
    HRESULT GetMachineName(uint cchSvr, PWSTR szServerName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icomlbarguments-setmachinename
    HRESULT SetMachineName(uint cchSvr, PWSTR szServerName);
}

@GUID("a0e174b3-d26e-11d2-8f84-00805fc7bcd9")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-icrmlogcontrol
interface ICrmLogControl : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icrmlogcontrol-get_transactionuow
    HRESULT get_TransactionUOW(BSTR* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icrmlogcontrol-registercompensator
    HRESULT RegisterCompensator(const(PWSTR) lpcwstrProgIdCompensator, const(PWSTR) lpcwstrDescription, 
                                int lCrmRegFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icrmlogcontrol-writelogrecordvariants
    HRESULT WriteLogRecordVariants(VARIANT* pLogRecord);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icrmlogcontrol-forcelog
    HRESULT ForceLog();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icrmlogcontrol-forgetlogrecord
    HRESULT ForgetLogRecord();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icrmlogcontrol-forcetransactiontoabort
    HRESULT ForceTransactionToAbort();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icrmlogcontrol-writelogrecord
    HRESULT WriteLogRecord(BLOB* rgBlob, uint cBlob);
}

@GUID("f0baf8e4-7804-11d1-82e9-00a0c91eede9")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-icrmcompensatorvariants
interface ICrmCompensatorVariants : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icrmcompensatorvariants-setlogcontrolvariants
    HRESULT SetLogControlVariants(ICrmLogControl pLogControl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icrmcompensatorvariants-beginpreparevariants
    HRESULT BeginPrepareVariants();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icrmcompensatorvariants-preparerecordvariants
    HRESULT PrepareRecordVariants(VARIANT* pLogRecord, VARIANT_BOOL* pbForget);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icrmcompensatorvariants-endpreparevariants
    HRESULT EndPrepareVariants(VARIANT_BOOL* pbOkToPrepare);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icrmcompensatorvariants-begincommitvariants
    HRESULT BeginCommitVariants(VARIANT_BOOL bRecovery);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icrmcompensatorvariants-commitrecordvariants
    HRESULT CommitRecordVariants(VARIANT* pLogRecord, VARIANT_BOOL* pbForget);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icrmcompensatorvariants-endcommitvariants
    HRESULT EndCommitVariants();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icrmcompensatorvariants-beginabortvariants
    HRESULT BeginAbortVariants(VARIANT_BOOL bRecovery);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icrmcompensatorvariants-abortrecordvariants
    HRESULT AbortRecordVariants(VARIANT* pLogRecord, VARIANT_BOOL* pbForget);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icrmcompensatorvariants-endabortvariants
    HRESULT EndAbortVariants();
}

@GUID("bbc01830-8d3b-11d1-82ec-00a0c91eede9")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-icrmcompensator
interface ICrmCompensator : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icrmcompensator-setlogcontrol
    HRESULT SetLogControl(ICrmLogControl pLogControl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icrmcompensator-beginprepare
    HRESULT BeginPrepare();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icrmcompensator-preparerecord
    HRESULT PrepareRecord(CrmLogRecordRead crmLogRec, BOOL* pfForget);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icrmcompensator-endprepare
    HRESULT EndPrepare(BOOL* pfOkToPrepare);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icrmcompensator-begincommit
    HRESULT BeginCommit(BOOL fRecovery);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icrmcompensator-commitrecord
    HRESULT CommitRecord(CrmLogRecordRead crmLogRec, BOOL* pfForget);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icrmcompensator-endcommit
    HRESULT EndCommit();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icrmcompensator-beginabort
    HRESULT BeginAbort(BOOL fRecovery);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icrmcompensator-abortrecord
    HRESULT AbortRecord(CrmLogRecordRead crmLogRec, BOOL* pfForget);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icrmcompensator-endabort
    HRESULT EndAbort();
}

@GUID("70c8e441-c7ed-11d1-82fb-00a0c91eede9")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-icrmmonitorlogrecords
interface ICrmMonitorLogRecords : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icrmmonitorlogrecords-get_count
    HRESULT get_Count(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icrmmonitorlogrecords-get_transactionstate
    HRESULT get_TransactionState(CrmTransactionState* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icrmmonitorlogrecords-get_structuredrecords
    HRESULT get_StructuredRecords(VARIANT_BOOL* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icrmmonitorlogrecords-getlogrecord
    HRESULT GetLogRecord(uint dwIndex, CrmLogRecordRead* pCrmLogRec);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icrmmonitorlogrecords-getlogrecordvariants
    HRESULT GetLogRecordVariants(VARIANT IndexNumber, VARIANT* pLogRecord);
}

@GUID("70c8e442-c7ed-11d1-82fb-00a0c91eede9")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-icrmmonitorclerks
interface ICrmMonitorClerks : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icrmmonitorclerks-item
    HRESULT Item(VARIANT Index, VARIANT* pItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icrmmonitorclerks-get__newenum
    HRESULT get__NewEnum(IUnknown* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icrmmonitorclerks-get_count
    HRESULT get_Count(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icrmmonitorclerks-progidcompensator
    HRESULT ProgIdCompensator(VARIANT Index, VARIANT* pItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icrmmonitorclerks-description
    HRESULT Description(VARIANT Index, VARIANT* pItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icrmmonitorclerks-transactionuow
    HRESULT TransactionUOW(VARIANT Index, VARIANT* pItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icrmmonitorclerks-activityid
    HRESULT ActivityId(VARIANT Index, VARIANT* pItem);
}

@GUID("70c8e443-c7ed-11d1-82fb-00a0c91eede9")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-icrmmonitor
interface ICrmMonitor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icrmmonitor-getclerks
    HRESULT GetClerks(ICrmMonitorClerks* pClerks);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icrmmonitor-holdclerk
    HRESULT HoldClerk(VARIANT Index, VARIANT* pItem);
}

@GUID("9c51d821-c98b-11d1-82fb-00a0c91eede9")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-icrmformatlogrecords
interface ICrmFormatLogRecords : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icrmformatlogrecords-getcolumncount
    HRESULT GetColumnCount(int* plColumnCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icrmformatlogrecords-getcolumnheaders
    HRESULT GetColumnHeaders(VARIANT* pHeaders);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icrmformatlogrecords-getcolumn
    HRESULT GetColumn(CrmLogRecordRead CrmLogRec, VARIANT* pFormattedLogRecord);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icrmformatlogrecords-getcolumnvariants
    HRESULT GetColumnVariants(VARIANT LogRecord, VARIANT* pFormattedLogRecord);
}

@GUID("1a0cf920-d452-46f4-bc36-48118d54ea52")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-iserviceiisintrinsicsconfig
interface IServiceIISIntrinsicsConfig : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iserviceiisintrinsicsconfig-iisintrinsicsconfig
    HRESULT IISIntrinsicsConfig(CSC_IISIntrinsicsConfig iisIntrinsicsConfig);
}

@GUID("09e6831e-04e1-4ed4-9d0f-e8b168bafeaf")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-iservicecomtiintrinsicsconfig
interface IServiceComTIIntrinsicsConfig : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iservicecomtiintrinsicsconfig-comtiintrinsicsconfig
    HRESULT ComTIIntrinsicsConfig(CSC_COMTIIntrinsicsConfig comtiIntrinsicsConfig);
}

@GUID("c7cd7379-f3f2-4634-811b-703281d73e08")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-iservicesxsconfig
interface IServiceSxsConfig : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iservicesxsconfig-sxsconfig
    HRESULT SxsConfig(CSC_SxsConfig scsConfig);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iservicesxsconfig-sxsname
    HRESULT SxsName(const(PWSTR) szSxsName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iservicesxsconfig-sxsdirectory
    HRESULT SxsDirectory(const(PWSTR) szSxsDirectory);
}

@GUID("0ff5a96f-11fc-47d1-baa6-25dd347e7242")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-ichecksxsconfig
interface ICheckSxsConfig : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-ichecksxsconfig-issamesxsconfig
    HRESULT IsSameSxsConfig(const(PWSTR) wszSxsName, const(PWSTR) wszSxsDirectory, const(PWSTR) wszSxsAppName);
}

@GUID("92186771-d3b4-4d77-a8ea-ee842d586f35")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-iserviceinheritanceconfig
interface IServiceInheritanceConfig : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iserviceinheritanceconfig-containingcontexttreatment
    HRESULT ContainingContextTreatment(CSC_InheritanceConfig inheritanceConfig);
}

@GUID("186d89bc-f277-4bcc-80d5-4df7b836ef4a")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-iservicethreadpoolconfig
interface IServiceThreadPoolConfig : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iservicethreadpoolconfig-selectthreadpool
    HRESULT SelectThreadPool(CSC_ThreadPool threadPool);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iservicethreadpoolconfig-setbindinginfo
    HRESULT SetBindingInfo(CSC_Binding binding);
}

@GUID("772b3fbe-6ffd-42fb-b5f8-8f9b260f3810")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-iservicetransactionconfigbase
interface IServiceTransactionConfigBase : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iservicetransactionconfigbase-configuretransaction
    HRESULT ConfigureTransaction(CSC_TransactionConfig transactionConfig);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iservicetransactionconfigbase-isolationlevel
    HRESULT IsolationLevel(COMAdminTxIsolationLevelOptions option);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iservicetransactionconfigbase-transactiontimeout
    HRESULT TransactionTimeout(uint ulTimeoutSec);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iservicetransactionconfigbase-bringyourowntransaction
    HRESULT BringYourOwnTransaction(const(PWSTR) szTipURL);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iservicetransactionconfigbase-newtransactiondescription
    HRESULT NewTransactionDescription(const(PWSTR) szTxDesc);
}

@GUID("59f4c2a3-d3d7-4a31-b6e4-6ab3177c50b9")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-iservicetransactionconfig
interface IServiceTransactionConfig : IServiceTransactionConfigBase
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iservicetransactionconfig-configurebyot
    HRESULT ConfigureBYOT(ITransaction pITxByot);
}

@GUID("33caf1a1-fcb8-472b-b45e-967448ded6d8")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-iservicesystxnconfig
interface IServiceSysTxnConfig : IServiceTransactionConfig
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iservicesystxnconfig-configurebyotsystxn
    HRESULT ConfigureBYOTSysTxn(ITransactionProxy pTxProxy);
}

@GUID("fd880e81-6dce-4c58-af83-a208846c0030")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-iservicesynchronizationconfig
interface IServiceSynchronizationConfig : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iservicesynchronizationconfig-configuresynchronization
    HRESULT ConfigureSynchronization(CSC_SynchronizationConfig synchConfig);
}

@GUID("6c3a3e1d-0ba6-4036-b76f-d0404db816c9")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-iservicetrackerconfig
interface IServiceTrackerConfig : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iservicetrackerconfig-trackerconfig
    HRESULT TrackerConfig(CSC_TrackerConfig trackerConfig, const(PWSTR) szTrackerAppName, 
                          const(PWSTR) szTrackerCtxName);
}

@GUID("80182d03-5ea4-4831-ae97-55beffc2e590")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-iservicepartitionconfig
interface IServicePartitionConfig : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iservicepartitionconfig-partitionconfig
    HRESULT PartitionConfig(CSC_PartitionConfig partitionConfig);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iservicepartitionconfig-partitionid
    HRESULT PartitionID(const(GUID)* guidPartitionID);
}

@GUID("bd3e2e12-42dd-40f4-a09a-95a50c58304b")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-iservicecall
interface IServiceCall : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iservicecall-oncall
    HRESULT OnCall();
}

@GUID("fe6777fb-a674-4177-8f32-6d707e113484")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-iasyncerrornotify
interface IAsyncErrorNotify : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iasyncerrornotify-onerror
    HRESULT OnError(HRESULT hr);
}

@GUID("67532e0c-9e2f-4450-a354-035633944e17")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-iserviceactivity
interface IServiceActivity : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iserviceactivity-synchronouscall
    HRESULT SynchronousCall(IServiceCall pIServiceCall);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iserviceactivity-asynchronouscall
    HRESULT AsynchronousCall(IServiceCall pIServiceCall);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iserviceactivity-bindtocurrentthread
    HRESULT BindToCurrentThread();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iserviceactivity-unbindfromthread
    HRESULT UnbindFromThread();
}

@GUID("51372af7-cae7-11cf-be81-00aa00a2fa25")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-ithreadpoolknobs
interface IThreadPoolKnobs : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-ithreadpoolknobs-getmaxthreads
    HRESULT GetMaxThreads(int* plcMaxThreads);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-ithreadpoolknobs-getcurrentthreads
    HRESULT GetCurrentThreads(int* plcCurrentThreads);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-ithreadpoolknobs-setmaxthreads
    HRESULT SetMaxThreads(int lcMaxThreads);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-ithreadpoolknobs-getdeletedelay
    HRESULT GetDeleteDelay(int* pmsecDeleteDelay);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-ithreadpoolknobs-setdeletedelay
    HRESULT SetDeleteDelay(int msecDeleteDelay);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-ithreadpoolknobs-getmaxqueuedrequests
    HRESULT GetMaxQueuedRequests(int* plcMaxQueuedRequests);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-ithreadpoolknobs-getcurrentqueuedrequests
    HRESULT GetCurrentQueuedRequests(int* plcCurrentQueuedRequests);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-ithreadpoolknobs-setmaxqueuedrequests
    HRESULT SetMaxQueuedRequests(int lcMaxQueuedRequests);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-ithreadpoolknobs-setminthreads
    HRESULT SetMinThreads(int lcMinThreads);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-ithreadpoolknobs-setqueuedepth
    HRESULT SetQueueDepth(int lcQueueDepth);
}

@GUID("324b64fa-33b6-11d2-98b7-00c04f8ee1c4")
interface IComStaThreadPoolKnobs : IUnknown
{
    HRESULT SetMinThreadCount(uint minThreads);
    HRESULT GetMinThreadCount(uint* minThreads);
    HRESULT SetMaxThreadCount(uint maxThreads);
    HRESULT GetMaxThreadCount(uint* maxThreads);
    HRESULT SetActivityPerThread(uint activitiesPerThread);
    HRESULT GetActivityPerThread(uint* activitiesPerThread);
    HRESULT SetActivityRatio(double activityRatio);
    HRESULT GetActivityRatio(double* activityRatio);
    HRESULT GetThreadCount(uint* pdwThreads);
    HRESULT GetQueueDepth(uint* pdwQDepth);
    HRESULT SetQueueDepth(int dwQDepth);
}

@GUID("f9a76d2e-76a5-43eb-a0c4-49bec8e48480")
interface IComMtaThreadPoolKnobs : IUnknown
{
    HRESULT MTASetMaxThreadCount(uint dwMaxThreads);
    HRESULT MTAGetMaxThreadCount(uint* pdwMaxThreads);
    HRESULT MTASetThrottleValue(uint dwThrottle);
    HRESULT MTAGetThrottleValue(uint* pdwThrottle);
}

@GUID("73707523-ff9a-4974-bf84-2108dc213740")
interface IComStaThreadPoolKnobs2 : IComStaThreadPoolKnobs
{
    HRESULT GetMaxCPULoad(uint* pdwLoad);
    HRESULT SetMaxCPULoad(int pdwLoad);
    HRESULT GetCPUMetricEnabled(BOOL* pbMetricEnabled);
    HRESULT SetCPUMetricEnabled(BOOL bMetricEnabled);
    HRESULT GetCreateThreadsAggressively(BOOL* pbMetricEnabled);
    HRESULT SetCreateThreadsAggressively(BOOL bMetricEnabled);
    HRESULT GetMaxCSR(uint* pdwCSR);
    HRESULT SetMaxCSR(int dwCSR);
    HRESULT GetWaitTimeForThreadCleanup(uint* pdwThreadCleanupWaitTime);
    HRESULT SetWaitTimeForThreadCleanup(int dwThreadCleanupWaitTime);
}

@GUID("1113f52d-dc7f-4943-aed6-88d04027e32a")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-iprocessinitializer
interface IProcessInitializer : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iprocessinitializer-startup
    HRESULT Startup(IUnknown punkProcessControl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iprocessinitializer-shutdown
    HRESULT Shutdown();
}

@GUID("a9690656-5bca-470c-8451-250c1f43a33e")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-iservicepoolconfig
interface IServicePoolConfig : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iservicepoolconfig-put_maxpoolsize
    HRESULT put_MaxPoolSize(uint dwMaxPool);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iservicepoolconfig-get_maxpoolsize
    HRESULT get_MaxPoolSize(uint* pdwMaxPool);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iservicepoolconfig-put_minpoolsize
    HRESULT put_MinPoolSize(uint dwMinPool);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iservicepoolconfig-get_minpoolsize
    HRESULT get_MinPoolSize(uint* pdwMinPool);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iservicepoolconfig-put_creationtimeout
    HRESULT put_CreationTimeout(uint dwCreationTimeout);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iservicepoolconfig-get_creationtimeout
    HRESULT get_CreationTimeout(uint* pdwCreationTimeout);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iservicepoolconfig-put_transactionaffinity
    HRESULT put_TransactionAffinity(BOOL fTxAffinity);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iservicepoolconfig-get_transactionaffinity
    HRESULT get_TransactionAffinity(BOOL* pfTxAffinity);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iservicepoolconfig-put_classfactory
    HRESULT put_ClassFactory(IClassFactory pFactory);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iservicepoolconfig-get_classfactory
    HRESULT get_ClassFactory(IClassFactory* pFactory);
}

@GUID("b302df81-ea45-451e-99a2-09f9fd1b1e13")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-iservicepool
interface IServicePool : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iservicepool-initialize
    HRESULT Initialize(IUnknown pPoolConfig);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iservicepool-getobject
    HRESULT GetObject(const(GUID)* riid, void** ppv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iservicepool-shutdown
    HRESULT Shutdown();
}

@GUID("c5da4bea-1b42-4437-8926-b6a38860a770")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-imanagedpooledobj
interface IManagedPooledObj : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-imanagedpooledobj-setheld
    HRESULT SetHeld(BOOL m_bHeld);
}

@GUID("da91b74e-5388-4783-949d-c1cd5fb00506")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-imanagedpoolaction
interface IManagedPoolAction : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-imanagedpoolaction-lastrelease
    HRESULT LastRelease();
}

@GUID("1427c51a-4584-49d8-90a0-c50d8086cbe9")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-imanagedobjectinfo
interface IManagedObjectInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-imanagedobjectinfo-getiunknown
    HRESULT GetIUnknown(IUnknown* pUnk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-imanagedobjectinfo-getiobjectcontrol
    HRESULT GetIObjectControl(IObjectControl* pCtrl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-imanagedobjectinfo-setinpool
    HRESULT SetInPool(BOOL bInPool, IManagedPooledObj pPooledObj);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-imanagedobjectinfo-setwrapperstrength
    HRESULT SetWrapperStrength(BOOL bStrong);
}

@GUID("c7b67079-8255-42c6-9ec0-6994a3548780")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-iappdomainhelper
interface IAppDomainHelper : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iappdomainhelper-initialize
    HRESULT Initialize(IUnknown pUnkAD, ptrdiff_t __MIDL__IAppDomainHelper0000, void* pPool);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iappdomainhelper-docallback
    HRESULT DoCallback(IUnknown pUnkAD, ptrdiff_t __MIDL__IAppDomainHelper0001, void* pPool);
}

@GUID("391ffbb9-a8ee-432a-abc8-baa238dab90f")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-iassemblylocator
interface IAssemblyLocator : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iassemblylocator-getmodules
    HRESULT GetModules(BSTR applicationDir, BSTR applicationName, BSTR assemblyName, SAFEARRAY** pModules);
}

@GUID("a5f325af-572f-46da-b8ab-827c3d95d99e")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-imanagedactivationevents
interface IManagedActivationEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-imanagedactivationevents-createmanagedstub
    HRESULT CreateManagedStub(IManagedObjectInfo pInfo, BOOL fDist);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-imanagedactivationevents-destroymanagedstub
    HRESULT DestroyManagedStub(IManagedObjectInfo pInfo);
}

@GUID("2732fd59-b2b4-4d44-878c-8b8f09626008")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-isendmethodevents
interface ISendMethodEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-isendmethodevents-sendmethodcall
    HRESULT SendMethodCall(const(void)* pIdentity, const(GUID)* riid, uint dwMeth);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-isendmethodevents-sendmethodreturn
    HRESULT SendMethodReturn(const(void)* pIdentity, const(GUID)* riid, uint dwMeth, HRESULT hrCall, 
                             HRESULT hrServer);
}

@GUID("c5feb7c1-346a-11d1-b1cc-00aa00ba3258")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-itransactionresourcepool
interface ITransactionResourcePool : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-itransactionresourcepool-putresource
    HRESULT PutResource(IObjPool pPool, IUnknown pUnk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-itransactionresourcepool-getresource
    HRESULT GetResource(IObjPool pPool, IUnknown* ppUnk);
}

@GUID("51372aef-cae7-11cf-be81-00aa00a2fa25")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-imtscall
interface IMTSCall : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-imtscall-oncall
    HRESULT OnCall();
}

@GUID("d396da85-bf8f-11d1-bbae-00c04fc2fa5f")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-icontextproperties
interface IContextProperties : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icontextproperties-count
    HRESULT Count(int* plCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icontextproperties-getproperty
    HRESULT GetProperty(BSTR name, VARIANT* pProperty);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icontextproperties-enumnames
    HRESULT EnumNames(IEnumNames* ppenum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icontextproperties-setproperty
    HRESULT SetProperty(BSTR name, VARIANT property);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-icontextproperties-removeproperty
    HRESULT RemoveProperty(BSTR name);
}

@GUID("7d8805a0-2ea7-11d1-b1cc-00aa00ba3258")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-iobjpool
interface IObjPool : IUnknown
{
    void Reserved1();
    void Reserved2();
    void Reserved3();
    void Reserved4();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-iobjpool-putendtx
    void PutEndTx(IUnknown pObj);
    void Reserved5();
    void Reserved6();
}

@GUID("788ea814-87b1-11d1-bba6-00c04fc2fa5f")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-itransactionproperty
interface ITransactionProperty : IUnknown
{
    void    Reserved1();
    void    Reserved2();
    void    Reserved3();
    void    Reserved4();
    void    Reserved5();
    void    Reserved6();
    void    Reserved7();
    void    Reserved8();
    void    Reserved9();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-itransactionproperty-gettransactionresourcepool
    HRESULT GetTransactionResourcePool(ITransactionResourcePool* ppTxPool);
    void    Reserved10();
    void    Reserved11();
    void    Reserved12();
    void    Reserved13();
    void    Reserved14();
    void    Reserved15();
    void    Reserved16();
    void    Reserved17();
}

@GUID("51372af0-cae7-11cf-be81-00aa00a2fa25")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nn-comsvcs-imtsactivity
interface IMTSActivity : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-imtsactivity-synchronouscall
    HRESULT SynchronousCall(IMTSCall pCall);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-imtsactivity-asynccall
    HRESULT AsyncCall(IMTSCall pCall);
    void    Reserved1();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-imtsactivity-bindtocurrentthread
    HRESULT BindToCurrentThread();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/comsvcs/nf-comsvcs-imtsactivity-unbindfromthread
    HRESULT UnbindFromThread();
}


// GUIDs

const GUID CLSID_AppDomainHelper                 = GUIDOF!AppDomainHelper;
const GUID CLSID_ByotServerEx                    = GUIDOF!ByotServerEx;
const GUID CLSID_COMAdminCatalog                 = GUIDOF!COMAdminCatalog;
const GUID CLSID_COMAdminCatalogCollection       = GUIDOF!COMAdminCatalogCollection;
const GUID CLSID_COMAdminCatalogObject           = GUIDOF!COMAdminCatalogObject;
const GUID CLSID_COMEvents                       = GUIDOF!COMEvents;
const GUID CLSID_CRMClerk                        = GUIDOF!CRMClerk;
const GUID CLSID_CRMRecoveryClerk                = GUIDOF!CRMRecoveryClerk;
const GUID CLSID_CServiceConfig                  = GUIDOF!CServiceConfig;
const GUID CLSID_ClrAssemblyLocator              = GUIDOF!ClrAssemblyLocator;
const GUID CLSID_CoMTSLocator                    = GUIDOF!CoMTSLocator;
const GUID CLSID_ComServiceEvents                = GUIDOF!ComServiceEvents;
const GUID CLSID_ComSystemAppEventData           = GUIDOF!ComSystemAppEventData;
const GUID CLSID_DispenserManager                = GUIDOF!DispenserManager;
const GUID CLSID_Dummy30040732                   = GUIDOF!Dummy30040732;
const GUID CLSID_EventServer                     = GUIDOF!EventServer;
const GUID CLSID_GetSecurityCallContextAppObject = GUIDOF!GetSecurityCallContextAppObject;
const GUID CLSID_LBEvents                        = GUIDOF!LBEvents;
const GUID CLSID_MessageMover                    = GUIDOF!MessageMover;
const GUID CLSID_MtsGrp                          = GUIDOF!MtsGrp;
const GUID CLSID_PoolMgr                         = GUIDOF!PoolMgr;
const GUID CLSID_SecurityCallContext             = GUIDOF!SecurityCallContext;
const GUID CLSID_SecurityCallers                 = GUIDOF!SecurityCallers;
const GUID CLSID_SecurityIdentity                = GUIDOF!SecurityIdentity;
const GUID CLSID_ServicePool                     = GUIDOF!ServicePool;
const GUID CLSID_ServicePoolConfig               = GUIDOF!ServicePoolConfig;
const GUID CLSID_SharedProperty                  = GUIDOF!SharedProperty;
const GUID CLSID_SharedPropertyGroup             = GUIDOF!SharedPropertyGroup;
const GUID CLSID_SharedPropertyGroupManager      = GUIDOF!SharedPropertyGroupManager;
const GUID CLSID_TrackerServer                   = GUIDOF!TrackerServer;
const GUID CLSID_TransactionContext              = GUIDOF!TransactionContext;
const GUID CLSID_TransactionContextEx            = GUIDOF!TransactionContextEx;

const GUID IID_ContextInfo                   = GUIDOF!ContextInfo;
const GUID IID_ContextInfo2                  = GUIDOF!ContextInfo2;
const GUID IID_IAppDomainHelper              = GUIDOF!IAppDomainHelper;
const GUID IID_IAssemblyLocator              = GUIDOF!IAssemblyLocator;
const GUID IID_IAsyncErrorNotify             = GUIDOF!IAsyncErrorNotify;
const GUID IID_ICOMAdminCatalog              = GUIDOF!ICOMAdminCatalog;
const GUID IID_ICOMAdminCatalog2             = GUIDOF!ICOMAdminCatalog2;
const GUID IID_ICOMLBArguments               = GUIDOF!ICOMLBArguments;
const GUID IID_ICatalogCollection            = GUIDOF!ICatalogCollection;
const GUID IID_ICatalogObject                = GUIDOF!ICatalogObject;
const GUID IID_ICheckSxsConfig               = GUIDOF!ICheckSxsConfig;
const GUID IID_IComActivityEvents            = GUIDOF!IComActivityEvents;
const GUID IID_IComApp2Events                = GUIDOF!IComApp2Events;
const GUID IID_IComAppEvents                 = GUIDOF!IComAppEvents;
const GUID IID_IComCRMEvents                 = GUIDOF!IComCRMEvents;
const GUID IID_IComExceptionEvents           = GUIDOF!IComExceptionEvents;
const GUID IID_IComIdentityEvents            = GUIDOF!IComIdentityEvents;
const GUID IID_IComInstance2Events           = GUIDOF!IComInstance2Events;
const GUID IID_IComInstanceEvents            = GUIDOF!IComInstanceEvents;
const GUID IID_IComLTxEvents                 = GUIDOF!IComLTxEvents;
const GUID IID_IComMethod2Events             = GUIDOF!IComMethod2Events;
const GUID IID_IComMethodEvents              = GUIDOF!IComMethodEvents;
const GUID IID_IComMtaThreadPoolKnobs        = GUIDOF!IComMtaThreadPoolKnobs;
const GUID IID_IComObjectConstruction2Events = GUIDOF!IComObjectConstruction2Events;
const GUID IID_IComObjectConstructionEvents  = GUIDOF!IComObjectConstructionEvents;
const GUID IID_IComObjectEvents              = GUIDOF!IComObjectEvents;
const GUID IID_IComObjectPool2Events         = GUIDOF!IComObjectPool2Events;
const GUID IID_IComObjectPoolEvents          = GUIDOF!IComObjectPoolEvents;
const GUID IID_IComObjectPoolEvents2         = GUIDOF!IComObjectPoolEvents2;
const GUID IID_IComQCEvents                  = GUIDOF!IComQCEvents;
const GUID IID_IComResourceEvents            = GUIDOF!IComResourceEvents;
const GUID IID_IComSecurityEvents            = GUIDOF!IComSecurityEvents;
const GUID IID_IComStaThreadPoolKnobs        = GUIDOF!IComStaThreadPoolKnobs;
const GUID IID_IComStaThreadPoolKnobs2       = GUIDOF!IComStaThreadPoolKnobs2;
const GUID IID_IComThreadEvents              = GUIDOF!IComThreadEvents;
const GUID IID_IComTrackingInfoCollection    = GUIDOF!IComTrackingInfoCollection;
const GUID IID_IComTrackingInfoEvents        = GUIDOF!IComTrackingInfoEvents;
const GUID IID_IComTrackingInfoObject        = GUIDOF!IComTrackingInfoObject;
const GUID IID_IComTrackingInfoProperties    = GUIDOF!IComTrackingInfoProperties;
const GUID IID_IComTransaction2Events        = GUIDOF!IComTransaction2Events;
const GUID IID_IComTransactionEvents         = GUIDOF!IComTransactionEvents;
const GUID IID_IComUserEvent                 = GUIDOF!IComUserEvent;
const GUID IID_IContextProperties            = GUIDOF!IContextProperties;
const GUID IID_IContextSecurityPerimeter     = GUIDOF!IContextSecurityPerimeter;
const GUID IID_IContextState                 = GUIDOF!IContextState;
const GUID IID_ICreateWithLocalTransaction   = GUIDOF!ICreateWithLocalTransaction;
const GUID IID_ICreateWithTipTransactionEx   = GUIDOF!ICreateWithTipTransactionEx;
const GUID IID_ICreateWithTransactionEx      = GUIDOF!ICreateWithTransactionEx;
const GUID IID_ICrmCompensator               = GUIDOF!ICrmCompensator;
const GUID IID_ICrmCompensatorVariants       = GUIDOF!ICrmCompensatorVariants;
const GUID IID_ICrmFormatLogRecords          = GUIDOF!ICrmFormatLogRecords;
const GUID IID_ICrmLogControl                = GUIDOF!ICrmLogControl;
const GUID IID_ICrmMonitor                   = GUIDOF!ICrmMonitor;
const GUID IID_ICrmMonitorClerks             = GUIDOF!ICrmMonitorClerks;
const GUID IID_ICrmMonitorLogRecords         = GUIDOF!ICrmMonitorLogRecords;
const GUID IID_IDispenserDriver              = GUIDOF!IDispenserDriver;
const GUID IID_IDispenserManager             = GUIDOF!IDispenserManager;
const GUID IID_IEnumNames                    = GUIDOF!IEnumNames;
const GUID IID_IEventServerTrace             = GUIDOF!IEventServerTrace;
const GUID IID_IGetAppTrackerData            = GUIDOF!IGetAppTrackerData;
const GUID IID_IGetContextProperties         = GUIDOF!IGetContextProperties;
const GUID IID_IGetSecurityCallContext       = GUIDOF!IGetSecurityCallContext;
const GUID IID_IHolder                       = GUIDOF!IHolder;
const GUID IID_ILBEvents                     = GUIDOF!ILBEvents;
const GUID IID_IMTSActivity                  = GUIDOF!IMTSActivity;
const GUID IID_IMTSCall                      = GUIDOF!IMTSCall;
const GUID IID_IMTSLocator                   = GUIDOF!IMTSLocator;
const GUID IID_IManagedActivationEvents      = GUIDOF!IManagedActivationEvents;
const GUID IID_IManagedObjectInfo            = GUIDOF!IManagedObjectInfo;
const GUID IID_IManagedPoolAction            = GUIDOF!IManagedPoolAction;
const GUID IID_IManagedPooledObj             = GUIDOF!IManagedPooledObj;
const GUID IID_IMessageMover                 = GUIDOF!IMessageMover;
const GUID IID_IMtsEventInfo                 = GUIDOF!IMtsEventInfo;
const GUID IID_IMtsEvents                    = GUIDOF!IMtsEvents;
const GUID IID_IMtsGrp                       = GUIDOF!IMtsGrp;
const GUID IID_IObjPool                      = GUIDOF!IObjPool;
const GUID IID_IObjectConstruct              = GUIDOF!IObjectConstruct;
const GUID IID_IObjectConstructString        = GUIDOF!IObjectConstructString;
const GUID IID_IObjectContext                = GUIDOF!IObjectContext;
const GUID IID_IObjectContextActivity        = GUIDOF!IObjectContextActivity;
const GUID IID_IObjectContextInfo            = GUIDOF!IObjectContextInfo;
const GUID IID_IObjectContextInfo2           = GUIDOF!IObjectContextInfo2;
const GUID IID_IObjectContextTip             = GUIDOF!IObjectContextTip;
const GUID IID_IObjectControl                = GUIDOF!IObjectControl;
const GUID IID_IPlaybackControl              = GUIDOF!IPlaybackControl;
const GUID IID_IPoolManager                  = GUIDOF!IPoolManager;
const GUID IID_IProcessInitializer           = GUIDOF!IProcessInitializer;
const GUID IID_ISecurityCallContext          = GUIDOF!ISecurityCallContext;
const GUID IID_ISecurityCallersColl          = GUIDOF!ISecurityCallersColl;
const GUID IID_ISecurityIdentityColl         = GUIDOF!ISecurityIdentityColl;
const GUID IID_ISecurityProperty             = GUIDOF!ISecurityProperty;
const GUID IID_ISelectCOMLBServer            = GUIDOF!ISelectCOMLBServer;
const GUID IID_ISendMethodEvents             = GUIDOF!ISendMethodEvents;
const GUID IID_IServiceActivity              = GUIDOF!IServiceActivity;
const GUID IID_IServiceCall                  = GUIDOF!IServiceCall;
const GUID IID_IServiceComTIIntrinsicsConfig = GUIDOF!IServiceComTIIntrinsicsConfig;
const GUID IID_IServiceIISIntrinsicsConfig   = GUIDOF!IServiceIISIntrinsicsConfig;
const GUID IID_IServiceInheritanceConfig     = GUIDOF!IServiceInheritanceConfig;
const GUID IID_IServicePartitionConfig       = GUIDOF!IServicePartitionConfig;
const GUID IID_IServicePool                  = GUIDOF!IServicePool;
const GUID IID_IServicePoolConfig            = GUIDOF!IServicePoolConfig;
const GUID IID_IServiceSxsConfig             = GUIDOF!IServiceSxsConfig;
const GUID IID_IServiceSynchronizationConfig = GUIDOF!IServiceSynchronizationConfig;
const GUID IID_IServiceSysTxnConfig          = GUIDOF!IServiceSysTxnConfig;
const GUID IID_IServiceThreadPoolConfig      = GUIDOF!IServiceThreadPoolConfig;
const GUID IID_IServiceTrackerConfig         = GUIDOF!IServiceTrackerConfig;
const GUID IID_IServiceTransactionConfig     = GUIDOF!IServiceTransactionConfig;
const GUID IID_IServiceTransactionConfigBase = GUIDOF!IServiceTransactionConfigBase;
const GUID IID_ISharedProperty               = GUIDOF!ISharedProperty;
const GUID IID_ISharedPropertyGroup          = GUIDOF!ISharedPropertyGroup;
const GUID IID_ISharedPropertyGroupManager   = GUIDOF!ISharedPropertyGroupManager;
const GUID IID_ISystemAppEventData           = GUIDOF!ISystemAppEventData;
const GUID IID_IThreadPoolKnobs              = GUIDOF!IThreadPoolKnobs;
const GUID IID_ITransactionContext           = GUIDOF!ITransactionContext;
const GUID IID_ITransactionContextEx         = GUIDOF!ITransactionContextEx;
const GUID IID_ITransactionProperty          = GUIDOF!ITransactionProperty;
const GUID IID_ITransactionProxy             = GUIDOF!ITransactionProxy;
const GUID IID_ITransactionResourcePool      = GUIDOF!ITransactionResourcePool;
const GUID IID_ITransactionStatus            = GUIDOF!ITransactionStatus;
const GUID IID_ITxProxyHolder                = GUIDOF!ITxProxyHolder;
const GUID IID_ObjectContext                 = GUIDOF!ObjectContext;
const GUID IID_ObjectControl                 = GUIDOF!ObjectControl;
const GUID IID_SecurityProperty              = GUIDOF!SecurityProperty;
