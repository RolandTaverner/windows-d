// Written in the D programming language.

module windows.win32.storage.fileserverresourcemanager;

public import windows.core;
public import system : Guid;
public import windows.win32.foundation : BSTR, HRESULT, VARIANT_BOOL;
public import windows.win32.system.com : IDispatch, IUnknown, SAFEARRAY;
public import windows.win32.system.variant : VARIANT;

extern(Windows) @nogc nothrow:


// Enums

//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmenums/ne-fsrmenums-fsrmquotaflags))], [])
enum FsrmQuotaFlags : int
{
    FsrmQuotaFlags_Enforce          = 0x00000100,
    FsrmQuotaFlags_Disable          = 0x00000200,
    FsrmQuotaFlags_StatusIncomplete = 0x00010000,
    FsrmQuotaFlags_StatusRebuilding = 0x00020000,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmenums/ne-fsrmenums-fsrmfilescreenflags))], [])
enum FsrmFileScreenFlags : int
{
    FsrmFileScreenFlags_Enforce = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmenums/ne-fsrmenums-fsrmcollectionstate))], [])
enum FsrmCollectionState : int
{
    FsrmCollectionState_Fetching   = 0x00000001,
    FsrmCollectionState_Committing = 0x00000002,
    FsrmCollectionState_Complete   = 0x00000003,
    FsrmCollectionState_Cancelled  = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmenums/ne-fsrmenums-fsrmenumoptions))], [])
enum FsrmEnumOptions : int
{
    FsrmEnumOptions_None                     = 0x00000000,
    FsrmEnumOptions_Asynchronous             = 0x00000001,
    FsrmEnumOptions_CheckRecycleBin          = 0x00000002,
    FsrmEnumOptions_IncludeClusterNodes      = 0x00000004,
    FsrmEnumOptions_IncludeDeprecatedObjects = 0x00000008,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmenums/ne-fsrmenums-fsrmcommitoptions))], [])
enum FsrmCommitOptions : int
{
    FsrmCommitOptions_None         = 0x00000000,
    FsrmCommitOptions_Asynchronous = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmenums/ne-fsrmenums-fsrmtemplateapplyoptions))], [])
enum FsrmTemplateApplyOptions : int
{
    FsrmTemplateApplyOptions_ApplyToDerivedMatching = 0x00000001,
    FsrmTemplateApplyOptions_ApplyToDerivedAll      = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmenums/ne-fsrmenums-fsrmactiontype))], [])
enum FsrmActionType : int
{
    FsrmActionType_Unknown  = 0x00000000,
    FsrmActionType_EventLog = 0x00000001,
    FsrmActionType_Email    = 0x00000002,
    FsrmActionType_Command  = 0x00000003,
    FsrmActionType_Report   = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmenums/ne-fsrmenums-fsrmeventtype))], [])
enum FsrmEventType : int
{
    FsrmEventType_Unknown     = 0x00000000,
    FsrmEventType_Information = 0x00000001,
    FsrmEventType_Warning     = 0x00000002,
    FsrmEventType_Error       = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmenums/ne-fsrmenums-fsrmaccounttype))], [])
enum FsrmAccountType : int
{
    FsrmAccountType_Unknown        = 0x00000000,
    FsrmAccountType_NetworkService = 0x00000001,
    FsrmAccountType_LocalService   = 0x00000002,
    FsrmAccountType_LocalSystem    = 0x00000003,
    FsrmAccountType_InProc         = 0x00000004,
    FsrmAccountType_External       = 0x00000005,
    FsrmAccountType_Automatic      = 0x000001f4,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmenums/ne-fsrmenums-fsrmreporttype))], [])
enum FsrmReportType : int
{
    FsrmReportType_Unknown                 = 0x00000000,
    FsrmReportType_LargeFiles              = 0x00000001,
    FsrmReportType_FilesByType             = 0x00000002,
    FsrmReportType_LeastRecentlyAccessed   = 0x00000003,
    FsrmReportType_MostRecentlyAccessed    = 0x00000004,
    FsrmReportType_QuotaUsage              = 0x00000005,
    FsrmReportType_FilesByOwner            = 0x00000006,
    FsrmReportType_ExportReport            = 0x00000007,
    FsrmReportType_DuplicateFiles          = 0x00000008,
    FsrmReportType_FileScreenAudit         = 0x00000009,
    FsrmReportType_FilesByProperty         = 0x0000000a,
    FsrmReportType_AutomaticClassification = 0x0000000b,
    FsrmReportType_Expiration              = 0x0000000c,
    FsrmReportType_FoldersByProperty       = 0x0000000d,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmenums/ne-fsrmenums-fsrmreportformat))], [])
enum FsrmReportFormat : int
{
    FsrmReportFormat_Unknown = 0x00000000,
    FsrmReportFormat_DHtml   = 0x00000001,
    FsrmReportFormat_Html    = 0x00000002,
    FsrmReportFormat_Txt     = 0x00000003,
    FsrmReportFormat_Csv     = 0x00000004,
    FsrmReportFormat_Xml     = 0x00000005,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmenums/ne-fsrmenums-fsrmreportrunningstatus))], [])
enum FsrmReportRunningStatus : int
{
    FsrmReportRunningStatus_Unknown    = 0x00000000,
    FsrmReportRunningStatus_NotRunning = 0x00000001,
    FsrmReportRunningStatus_Queued     = 0x00000002,
    FsrmReportRunningStatus_Running    = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmenums/ne-fsrmenums-fsrmreportgenerationcontext))], [])
enum FsrmReportGenerationContext : int
{
    FsrmReportGenerationContext_Undefined         = 0x00000001,
    FsrmReportGenerationContext_ScheduledReport   = 0x00000002,
    FsrmReportGenerationContext_InteractiveReport = 0x00000003,
    FsrmReportGenerationContext_IncidentReport    = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmenums/ne-fsrmenums-fsrmreportfilter))], [])
enum FsrmReportFilter : int
{
    FsrmReportFilter_MinSize       = 0x00000001,
    FsrmReportFilter_MinAgeDays    = 0x00000002,
    FsrmReportFilter_MaxAgeDays    = 0x00000003,
    FsrmReportFilter_MinQuotaUsage = 0x00000004,
    FsrmReportFilter_FileGroups    = 0x00000005,
    FsrmReportFilter_Owners        = 0x00000006,
    FsrmReportFilter_NamePattern   = 0x00000007,
    FsrmReportFilter_Property      = 0x00000008,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmenums/ne-fsrmenums-fsrmreportlimit))], [])
enum FsrmReportLimit : int
{
    FsrmReportLimit_MaxFiles                 = 0x00000001,
    FsrmReportLimit_MaxFileGroups            = 0x00000002,
    FsrmReportLimit_MaxOwners                = 0x00000003,
    FsrmReportLimit_MaxFilesPerFileGroup     = 0x00000004,
    FsrmReportLimit_MaxFilesPerOwner         = 0x00000005,
    FsrmReportLimit_MaxFilesPerDuplGroup     = 0x00000006,
    FsrmReportLimit_MaxDuplicateGroups       = 0x00000007,
    FsrmReportLimit_MaxQuotas                = 0x00000008,
    FsrmReportLimit_MaxFileScreenEvents      = 0x00000009,
    FsrmReportLimit_MaxPropertyValues        = 0x0000000a,
    FsrmReportLimit_MaxFilesPerPropertyValue = 0x0000000b,
    FsrmReportLimit_MaxFolders               = 0x0000000c,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmenums/ne-fsrmenums-fsrmpropertydefinitiontype))], [])
enum FsrmPropertyDefinitionType : int
{
    FsrmPropertyDefinitionType_Unknown          = 0x00000000,
    FsrmPropertyDefinitionType_OrderedList      = 0x00000001,
    FsrmPropertyDefinitionType_MultiChoiceList  = 0x00000002,
    FsrmPropertyDefinitionType_SingleChoiceList = 0x00000003,
    FsrmPropertyDefinitionType_String           = 0x00000004,
    FsrmPropertyDefinitionType_MultiString      = 0x00000005,
    FsrmPropertyDefinitionType_Int              = 0x00000006,
    FsrmPropertyDefinitionType_Bool             = 0x00000007,
    FsrmPropertyDefinitionType_Date             = 0x00000008,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmenums/ne-fsrmenums-fsrmpropertydefinitionflags))], [])
enum FsrmPropertyDefinitionFlags : int
{
    FsrmPropertyDefinitionFlags_Global     = 0x00000001,
    FsrmPropertyDefinitionFlags_Deprecated = 0x00000002,
    FsrmPropertyDefinitionFlags_Secure     = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmenums/ne-fsrmenums-fsrmpropertydefinitionappliesto))], [])
enum FsrmPropertyDefinitionAppliesTo : int
{
    FsrmPropertyDefinitionAppliesTo_Files   = 0x00000001,
    FsrmPropertyDefinitionAppliesTo_Folders = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmenums/ne-fsrmenums-fsrmruletype))], [])
enum FsrmRuleType : int
{
    FsrmRuleType_Unknown        = 0x00000000,
    FsrmRuleType_Classification = 0x00000001,
    FsrmRuleType_Generic        = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmenums/ne-fsrmenums-fsrmruleflags))], [])
enum FsrmRuleFlags : int
{
    FsrmRuleFlags_Disabled                             = 0x00000100,
    FsrmRuleFlags_ClearAutomaticallyClassifiedProperty = 0x00000400,
    FsrmRuleFlags_ClearManuallyClassifiedProperty      = 0x00000800,
    FsrmRuleFlags_Invalid                              = 0x00001000,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmenums/ne-fsrmenums-fsrmclassificationloggingflags))], [])
enum FsrmClassificationLoggingFlags : int
{
    FsrmClassificationLoggingFlags_None                       = 0x00000000,
    FsrmClassificationLoggingFlags_ClassificationsInLogFile   = 0x00000001,
    FsrmClassificationLoggingFlags_ErrorsInLogFile            = 0x00000002,
    FsrmClassificationLoggingFlags_ClassificationsInSystemLog = 0x00000004,
    FsrmClassificationLoggingFlags_ErrorsInSystemLog          = 0x00000008,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmenums/ne-fsrmenums-fsrmexecutionoption))], [])
enum FsrmExecutionOption : int
{
    FsrmExecutionOption_Unknown                          = 0x00000000,
    FsrmExecutionOption_EvaluateUnset                    = 0x00000001,
    FsrmExecutionOption_ReEvaluate_ConsiderExistingValue = 0x00000002,
    FsrmExecutionOption_ReEvaluate_IgnoreExistingValue   = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmenums/ne-fsrmenums-fsrmstoragemodulecaps))], [])
enum FsrmStorageModuleCaps : int
{
    FsrmStorageModuleCaps_Unknown              = 0x00000000,
    FsrmStorageModuleCaps_CanGet               = 0x00000001,
    FsrmStorageModuleCaps_CanSet               = 0x00000002,
    FsrmStorageModuleCaps_CanHandleDirectories = 0x00000004,
    FsrmStorageModuleCaps_CanHandleFiles       = 0x00000008,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmenums/ne-fsrmenums-fsrmstoragemoduletype))], [])
enum FsrmStorageModuleType : int
{
    FsrmStorageModuleType_Unknown  = 0x00000000,
    FsrmStorageModuleType_Cache    = 0x00000001,
    FsrmStorageModuleType_InFile   = 0x00000002,
    FsrmStorageModuleType_Database = 0x00000003,
    FsrmStorageModuleType_System   = 0x00000064,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmenums/ne-fsrmenums-fsrmpropertybagflags))], [])
enum FsrmPropertyBagFlags : int
{
    FsrmPropertyBagFlags_UpdatedByClassifier         = 0x00000001,
    FsrmPropertyBagFlags_FailedLoadingProperties     = 0x00000002,
    FsrmPropertyBagFlags_FailedSavingProperties      = 0x00000004,
    FsrmPropertyBagFlags_FailedClassifyingProperties = 0x00000008,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmenums/ne-fsrmenums-fsrmpropertybagfield))], [])
enum FsrmPropertyBagField : int
{
    FsrmPropertyBagField_AccessVolume   = 0x00000000,
    FsrmPropertyBagField_VolumeGuidName = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmenums/ne-fsrmenums-fsrmpropertyflags))], [])
enum FsrmPropertyFlags : int
{
    FsrmPropertyFlags_None                        = 0x00000000,
    FsrmPropertyFlags_Orphaned                    = 0x00000001,
    FsrmPropertyFlags_RetrievedFromCache          = 0x00000002,
    FsrmPropertyFlags_RetrievedFromStorage        = 0x00000004,
    FsrmPropertyFlags_SetByClassifier             = 0x00000008,
    FsrmPropertyFlags_Deleted                     = 0x00000010,
    FsrmPropertyFlags_Reclassified                = 0x00000020,
    FsrmPropertyFlags_AggregationFailed           = 0x00000040,
    FsrmPropertyFlags_Existing                    = 0x00000080,
    FsrmPropertyFlags_FailedLoadingProperties     = 0x00000100,
    FsrmPropertyFlags_FailedClassifyingProperties = 0x00000200,
    FsrmPropertyFlags_FailedSavingProperties      = 0x00000400,
    FsrmPropertyFlags_Secure                      = 0x00000800,
    FsrmPropertyFlags_PolicyDerived               = 0x00001000,
    FsrmPropertyFlags_Inherited                   = 0x00002000,
    FsrmPropertyFlags_Manual                      = 0x00004000,
    FsrmPropertyFlags_ExplicitValueDeleted        = 0x00008000,
    FsrmPropertyFlags_PropertyDeletedFromClear    = 0x00010000,
    FsrmPropertyFlags_PropertySourceMask          = 0x0000000e,
    FsrmPropertyFlags_PersistentMask              = 0x00005000,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmenums/ne-fsrmenums-fsrmpipelinemoduletype))], [])
enum FsrmPipelineModuleType : int
{
    FsrmPipelineModuleType_Unknown    = 0x00000000,
    FsrmPipelineModuleType_Storage    = 0x00000001,
    FsrmPipelineModuleType_Classifier = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmenums/ne-fsrmenums-fsrmgetfilepropertyoptions))], [])
enum FsrmGetFilePropertyOptions : int
{
    FsrmGetFilePropertyOptions_None                = 0x00000000,
    FsrmGetFilePropertyOptions_NoRuleEvaluation    = 0x00000001,
    FsrmGetFilePropertyOptions_Persistent          = 0x00000002,
    FsrmGetFilePropertyOptions_FailOnPersistErrors = 0x00000004,
    FsrmGetFilePropertyOptions_SkipOrphaned        = 0x00000008,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmenums/ne-fsrmenums-fsrmfilemanagementtype))], [])
enum FsrmFileManagementType : int
{
    FsrmFileManagementType_Unknown    = 0x00000000,
    FsrmFileManagementType_Expiration = 0x00000001,
    FsrmFileManagementType_Custom     = 0x00000002,
    FsrmFileManagementType_Rms        = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmenums/ne-fsrmenums-fsrmfilemanagementloggingflags))], [])
enum FsrmFileManagementLoggingFlags : int
{
    FsrmFileManagementLoggingFlags_None        = 0x00000000,
    FsrmFileManagementLoggingFlags_Error       = 0x00000001,
    FsrmFileManagementLoggingFlags_Information = 0x00000002,
    FsrmFileManagementLoggingFlags_Audit       = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmenums/ne-fsrmenums-fsrmpropertyconditiontype))], [])
enum FsrmPropertyConditionType : int
{
    FsrmPropertyConditionType_Unknown        = 0x00000000,
    FsrmPropertyConditionType_Equal          = 0x00000001,
    FsrmPropertyConditionType_NotEqual       = 0x00000002,
    FsrmPropertyConditionType_GreaterThan    = 0x00000003,
    FsrmPropertyConditionType_LessThan       = 0x00000004,
    FsrmPropertyConditionType_Contain        = 0x00000005,
    FsrmPropertyConditionType_Exist          = 0x00000006,
    FsrmPropertyConditionType_NotExist       = 0x00000007,
    FsrmPropertyConditionType_StartWith      = 0x00000008,
    FsrmPropertyConditionType_EndWith        = 0x00000009,
    FsrmPropertyConditionType_ContainedIn    = 0x0000000a,
    FsrmPropertyConditionType_PrefixOf       = 0x0000000b,
    FsrmPropertyConditionType_SuffixOf       = 0x0000000c,
    FsrmPropertyConditionType_MatchesPattern = 0x0000000d,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmenums/ne-fsrmenums-fsrmfilestreamingmode))], [])
enum FsrmFileStreamingMode : int
{
    FsrmFileStreamingMode_Unknown = 0x00000000,
    FsrmFileStreamingMode_Read    = 0x00000001,
    FsrmFileStreamingMode_Write   = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmenums/ne-fsrmenums-fsrmfilestreaminginterfacetype))], [])
enum FsrmFileStreamingInterfaceType : int
{
    FsrmFileStreamingInterfaceType_Unknown    = 0x00000000,
    FsrmFileStreamingInterfaceType_ILockBytes = 0x00000001,
    FsrmFileStreamingInterfaceType_IStream    = 0x00000002,
}
enum FsrmFileConditionType : int
{
    FsrmFileConditionType_Unknown  = 0x00000000,
    FsrmFileConditionType_Property = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmenums/ne-fsrmenums-fsrmfilesystempropertyid))], [])
enum FsrmFileSystemPropertyId : int
{
    FsrmFileSystemPropertyId_Undefined        = 0x00000000,
    FsrmFileSystemPropertyId_FileName         = 0x00000001,
    FsrmFileSystemPropertyId_DateCreated      = 0x00000002,
    FsrmFileSystemPropertyId_DateLastAccessed = 0x00000003,
    FsrmFileSystemPropertyId_DateLastModified = 0x00000004,
    FsrmFileSystemPropertyId_DateNow          = 0x00000005,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmenums/ne-fsrmenums-fsrmpropertyvaluetype))], [])
enum FsrmPropertyValueType : int
{
    FsrmPropertyValueType_Undefined  = 0x00000000,
    FsrmPropertyValueType_Literal    = 0x00000001,
    FsrmPropertyValueType_DateOffset = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmenums/ne-fsrmenums-adrclientdisplayflags))], [])
enum AdrClientDisplayFlags : int
{
    AdrClientDisplayFlags_AllowEmailRequests        = 0x00000001,
    AdrClientDisplayFlags_ShowDeviceTroubleshooting = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmenums/ne-fsrmenums-adremailflags))], [])
enum AdrEmailFlags : int
{
    AdrEmailFlags_PutDataOwnerOnToLine = 0x00000001,
    AdrEmailFlags_PutAdminOnToLine     = 0x00000002,
    AdrEmailFlags_IncludeDeviceClaims  = 0x00000004,
    AdrEmailFlags_IncludeUserInfo      = 0x00000008,
    AdrEmailFlags_GenerateEventLog     = 0x00000010,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmenums/ne-fsrmenums-adrclienterrortype))], [])
enum AdrClientErrorType : int
{
    AdrClientErrorType_Unknown      = 0x00000000,
    AdrClientErrorType_AccessDenied = 0x00000001,
    AdrClientErrorType_FileNotFound = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmenums/ne-fsrmenums-adrclientflags))], [])
enum AdrClientFlags : int
{
    AdrClientFlags_None                       = 0x00000000,
    AdrClientFlags_FailForLocalPaths          = 0x00000001,
    AdrClientFlags_FailIfNotSupportedByServer = 0x00000002,
    AdrClientFlags_FailIfNotDomainJoined      = 0x00000004,
}

// Constants


enum : uint
{
    FSRM_DISPID_FEATURE_MASK           = 0x0f000000,
    FSRM_DISPID_INTERFACE_A_MASK       = 0x00f00000,
    FSRM_DISPID_INTERFACE_B_MASK       = 0x000f0000,
    FSRM_DISPID_INTERFACE_C_MASK       = 0x0000f000,
    FSRM_DISPID_INTERFACE_D_MASK       = 0x00000f00,
    FSRM_DISPID_IS_PROPERTY            = 0x00000080,
    FSRM_DISPID_METHOD_NUM_MASK        = 0x0000007f,
    FSRM_DISPID_FEATURE_GENERAL        = 0x01000000,
    FSRM_DISPID_FEATURE_QUOTA          = 0x02000000,
    FSRM_DISPID_FEATURE_FILESCREEN     = 0x03000000,
    FSRM_DISPID_FEATURE_REPORTS        = 0x04000000,
    FSRM_DISPID_FEATURE_CLASSIFICATION = 0x05000000,
    FSRM_DISPID_FEATURE_PIPELINE       = 0x06000000,
}

enum uint FsrmMaxNumberThresholds = 0x00000010;
enum uint FsrmMinThresholdValue = 0x00000001;
enum uint FsrmMaxThresholdValue = 0x000000fa;
enum uint FsrmMinQuotaLimit = 0x00000400;
enum uint FsrmMaxExcludeFolders = 0x00000020;
enum uint FsrmMaxNumberPropertyDefinitions = 0x00000064;
enum uint MessageSizeLimit = 0x00001000;
enum int FsrmDaysNotSpecified = 0xffffffff;

enum : HRESULT
{
    FSRM_S_PARTIAL_BATCH          = HRESULT(0x00045304),
    FSRM_S_PARTIAL_CLASSIFICATION = HRESULT(0x00045305),
}

enum HRESULT FSRM_S_CLASSIFICATION_SCAN_FAILURES = HRESULT(0x00045306);

enum : HRESULT
{
    FSRM_E_NOT_FOUND                  = HRESULT(0x80045301),
    FSRM_E_INVALID_SCHEDULER_ARGUMENT = HRESULT(0x80045302),
}

enum HRESULT FSRM_E_ALREADY_EXISTS = HRESULT(0x80045303);
enum HRESULT FSRM_E_PATH_NOT_FOUND = HRESULT(0x80045304);

enum : HRESULT
{
    FSRM_E_INVALID_USER  = HRESULT(0x80045305),
    FSRM_E_INVALID_PATH  = HRESULT(0x80045306),
    FSRM_E_INVALID_LIMIT = HRESULT(0x80045307),
    FSRM_E_INVALID_NAME  = HRESULT(0x80045308),
}

enum : HRESULT
{
    FSRM_E_FAIL_BATCH             = HRESULT(0x80045309),
    FSRM_E_INVALID_TEXT           = HRESULT(0x8004530a),
    FSRM_E_INVALID_IMPORT_VERSION = HRESULT(0x8004530b),
}

enum HRESULT FSRM_E_OUT_OF_RANGE = HRESULT(0x8004530d);
enum HRESULT FSRM_E_REQD_PARAM_MISSING = HRESULT(0x8004530e);
enum HRESULT FSRM_E_INVALID_COMBINATION = HRESULT(0x8004530f);
enum HRESULT FSRM_E_DUPLICATE_NAME = HRESULT(0x80045310);
enum HRESULT FSRM_E_NOT_SUPPORTED = HRESULT(0x80045311);
enum HRESULT FSRM_E_DRIVER_NOT_READY = HRESULT(0x80045313);
enum HRESULT FSRM_E_INSUFFICIENT_DISK = HRESULT(0x80045314);
enum HRESULT FSRM_E_VOLUME_UNSUPPORTED = HRESULT(0x80045315);

enum : HRESULT
{
    FSRM_E_UNEXPECTED          = HRESULT(0x80045316),
    FSRM_E_INSECURE_PATH       = HRESULT(0x80045317),
    FSRM_E_INVALID_SMTP_SERVER = HRESULT(0x80045318),
}

enum : HRESULT
{
    FSRM_E_AUTO_QUOTA     = HRESULT(0x0004531b),
    FSRM_E_EMAIL_NOT_SENT = HRESULT(0x8004531c),
}

enum HRESULT FSRM_E_INVALID_EMAIL_ADDRESS = HRESULT(0x8004531e);
enum HRESULT FSRM_E_FILE_SYSTEM_CORRUPT = HRESULT(0x8004531f);
enum HRESULT FSRM_E_LONG_CMDLINE = HRESULT(0x80045320);

enum : HRESULT
{
    FSRM_E_INVALID_FILEGROUP_DEFINITION  = HRESULT(0x80045321),
    FSRM_E_INVALID_DATASCREEN_DEFINITION = HRESULT(0x80045324),
    FSRM_E_INVALID_REPORT_FORMAT         = HRESULT(0x80045328),
    FSRM_E_INVALID_REPORT_DESC           = HRESULT(0x80045329),
    FSRM_E_INVALID_FILENAME              = HRESULT(0x8004532a),
}

enum HRESULT FSRM_E_SHADOW_COPY = HRESULT(0x8004532c);
enum HRESULT FSRM_E_XML_CORRUPTED = HRESULT(0x8004532d);
enum HRESULT FSRM_E_CLUSTER_NOT_RUNNING = HRESULT(0x8004532e);
enum HRESULT FSRM_E_STORE_NOT_INSTALLED = HRESULT(0x8004532f);
enum HRESULT FSRM_E_NOT_CLUSTER_VOLUME = HRESULT(0x80045330);
enum HRESULT FSRM_E_DIFFERENT_CLUSTER_GROUP = HRESULT(0x80045331);

enum : HRESULT
{
    FSRM_E_REPORT_TYPE_ALREADY_EXISTS = HRESULT(0x80045332),
    FSRM_E_REPORT_JOB_ALREADY_RUNNING = HRESULT(0x80045333),
    FSRM_E_REPORT_GENERATION_ERR      = HRESULT(0x80045334),
    FSRM_E_REPORT_TASK_TRIGGER        = HRESULT(0x80045335),
}

enum HRESULT FSRM_E_LOADING_DISABLED_MODULE = HRESULT(0x80045336);
enum HRESULT FSRM_E_CANNOT_AGGREGATE = HRESULT(0x80045337);
enum HRESULT FSRM_E_MESSAGE_LIMIT_EXCEEDED = HRESULT(0x80045338);
enum HRESULT FSRM_E_OBJECT_IN_USE = HRESULT(0x80045339);

enum : HRESULT
{
    FSRM_E_CANNOT_RENAME_PROPERTY      = HRESULT(0x8004533a),
    FSRM_E_CANNOT_CHANGE_PROPERTY_TYPE = HRESULT(0x8004533b),
}

enum HRESULT FSRM_E_MAX_PROPERTY_DEFINITIONS = HRESULT(0x8004533c);

enum : HRESULT
{
    FSRM_E_CLASSIFICATION_ALREADY_RUNNING = HRESULT(0x8004533d),
    FSRM_E_CLASSIFICATION_NOT_RUNNING     = HRESULT(0x8004533e),
}

enum : HRESULT
{
    FSRM_E_FILE_MANAGEMENT_JOB_ALREADY_RUNNING = HRESULT(0x8004533f),
    FSRM_E_FILE_MANAGEMENT_JOB_EXPIRATION      = HRESULT(0x80045340),
    FSRM_E_FILE_MANAGEMENT_JOB_CUSTOM          = HRESULT(0x80045341),
    FSRM_E_FILE_MANAGEMENT_JOB_NOTIFICATION    = HRESULT(0x80045342),
}

enum HRESULT FSRM_E_FILE_OPEN_ERROR = HRESULT(0x80045343);
enum HRESULT FSRM_E_UNSECURE_LINK_TO_HOSTED_MODULE = HRESULT(0x80045344);

enum : HRESULT
{
    FSRM_E_CACHE_INVALID               = HRESULT(0x80045345),
    FSRM_E_CACHE_MODULE_ALREADY_EXISTS = HRESULT(0x80045346),
}

enum : HRESULT
{
    FSRM_E_FILE_MANAGEMENT_EXPIRATION_DIR_IN_SCOPE = HRESULT(0x80045347),
    FSRM_E_FILE_MANAGEMENT_JOB_ALREADY_EXISTS      = HRESULT(0x80045348),
}

enum HRESULT FSRM_E_PROPERTY_DELETED = HRESULT(0x80045349);
enum HRESULT FSRM_E_LAST_ACCESS_UPDATE_DISABLED = HRESULT(0x80045350);
enum HRESULT FSRM_E_NO_PROPERTY_VALUE = HRESULT(0x80045351);
enum HRESULT FSRM_E_INPROC_MODULE_BLOCKED = HRESULT(0x80045352);
enum HRESULT FSRM_E_ENUM_PROPERTIES_FAILED = HRESULT(0x80045353);
enum HRESULT FSRM_E_SET_PROPERTY_FAILED = HRESULT(0x80045354);

enum : HRESULT
{
    FSRM_E_CANNOT_STORE_PROPERTIES        = HRESULT(0x80045355),
    FSRM_E_CANNOT_ALLOW_REPARSE_POINT_TAG = HRESULT(0x80045356),
}

enum HRESULT FSRM_E_PARTIAL_CLASSIFICATION_PROPERTY_NOT_FOUND = HRESULT(0x80045357);

enum : HRESULT
{
    FSRM_E_TEXTREADER_NOT_INITIALIZED   = HRESULT(0x80045358),
    FSRM_E_TEXTREADER_IFILTER_NOT_FOUND = HRESULT(0x80045359),
}

enum HRESULT FSRM_E_PERSIST_PROPERTIES_FAILED_ENCRYPTED = HRESULT(0x8004535a);

enum : HRESULT
{
    FSRM_E_TEXTREADER_IFILTER_CLSID_MALFORMED = HRESULT(0x80045360),
    FSRM_E_TEXTREADER_STREAM_ERROR            = HRESULT(0x80045361),
    FSRM_E_TEXTREADER_FILENAME_TOO_LONG       = HRESULT(0x80045362),
}

enum HRESULT FSRM_E_INCOMPATIBLE_FORMAT = HRESULT(0x80045363);
enum HRESULT FSRM_E_FILE_ENCRYPTED = HRESULT(0x80045364);
enum HRESULT FSRM_E_PERSIST_PROPERTIES_FAILED = HRESULT(0x80045365);
enum HRESULT FSRM_E_VOLUME_OFFLINE = HRESULT(0x80045366);

enum : HRESULT
{
    FSRM_E_FILE_MANAGEMENT_ACTION_TIMEOUT             = HRESULT(0x80045367),
    FSRM_E_FILE_MANAGEMENT_ACTION_GET_EXITCODE_FAILED = HRESULT(0x80045368),
}

enum : HRESULT
{
    FSRM_E_MODULE_INVALID_PARAM          = HRESULT(0x80045369),
    FSRM_E_MODULE_INITIALIZATION         = HRESULT(0x8004536a),
    FSRM_E_MODULE_SESSION_INITIALIZATION = HRESULT(0x8004536b),
}

enum HRESULT FSRM_E_CLASSIFICATION_SCAN_FAIL = HRESULT(0x8004536c);

enum : HRESULT
{
    FSRM_E_FILE_MANAGEMENT_JOB_NOT_LEGACY_ACCESSIBLE = HRESULT(0x8004536d),
    FSRM_E_FILE_MANAGEMENT_JOB_MAX_FILE_CONDITIONS   = HRESULT(0x8004536e),
}

enum HRESULT FSRM_E_CANNOT_USE_DEPRECATED_PROPERTY = HRESULT(0x8004536f);
enum HRESULT FSRM_E_SYNC_TASK_TIMEOUT = HRESULT(0x80045370);
enum HRESULT FSRM_E_CANNOT_USE_DELETED_PROPERTY = HRESULT(0x80045371);
enum HRESULT FSRM_E_INVALID_AD_CLAIM = HRESULT(0x80045372);
enum HRESULT FSRM_E_CLASSIFICATION_CANCELED = HRESULT(0x80045373);
enum HRESULT FSRM_E_INVALID_FOLDER_PROPERTY_STORE = HRESULT(0x80045374);
enum HRESULT FSRM_E_REBUILDING_FODLER_TYPE_INDEX = HRESULT(0x80045375);
enum HRESULT FSRM_E_PROPERTY_MUST_APPLY_TO_FILES = HRESULT(0x80045376);

enum : HRESULT
{
    FSRM_E_CLASSIFICATION_TIMEOUT       = HRESULT(0x80045377),
    FSRM_E_CLASSIFICATION_PARTIAL_BATCH = HRESULT(0x80045378),
}

enum HRESULT FSRM_E_CANNOT_DELETE_SYSTEM_PROPERTY = HRESULT(0x80045379);
enum HRESULT FSRM_E_FILE_IN_USE = HRESULT(0x8004537a);
enum HRESULT FSRM_E_ERROR_NOT_ENABLED = HRESULT(0x8004537b);
enum HRESULT FSRM_E_CANNOT_CREATE_TEMP_COPY = HRESULT(0x8004537c);
enum HRESULT FSRM_E_NO_EMAIL_ADDRESS = HRESULT(0x8004537d);
enum HRESULT FSRM_E_ADR_MAX_EMAILS_SENT = HRESULT(0x8004537e);
enum HRESULT FSRM_E_PATH_NOT_IN_NAMESPACE = HRESULT(0x8004537f);
enum HRESULT FSRM_E_RMS_TEMPLATE_NOT_FOUND = HRESULT(0x80045380);
enum HRESULT FSRM_E_SECURE_PROPERTIES_NOT_SUPPORTED = HRESULT(0x80045381);

enum : HRESULT
{
    FSRM_E_RMS_NO_PROTECTORS_INSTALLED         = HRESULT(0x80045382),
    FSRM_E_RMS_NO_PROTECTOR_INSTALLED_FOR_FILE = HRESULT(0x80045383),
}

enum : HRESULT
{
    FSRM_E_PROPERTY_MUST_APPLY_TO_FOLDERS = HRESULT(0x80045384),
    FSRM_E_PROPERTY_MUST_BE_SECURE        = HRESULT(0x80045385),
    FSRM_E_PROPERTY_MUST_BE_GLOBAL        = HRESULT(0x80045386),
}

enum HRESULT FSRM_E_WMI_FAILURE = HRESULT(0x80045387);
enum HRESULT FSRM_E_FILE_MANAGEMENT_JOB_RMS = HRESULT(0x80045388);
enum HRESULT FSRM_E_SYNC_TASK_HAD_ERRORS = HRESULT(0x80045389);
enum HRESULT FSRM_E_ADR_SRV_NOT_SUPPORTED = HRESULT(0x80045390);

enum : HRESULT
{
    FSRM_E_ADR_PATH_IS_LOCAL     = HRESULT(0x80045391),
    FSRM_E_ADR_NOT_DOMAIN_JOINED = HRESULT(0x80045392),
}

enum HRESULT FSRM_E_CANNOT_REMOVE_READONLY = HRESULT(0x80045393);
enum HRESULT FSRM_E_FILE_MANAGEMENT_JOB_INVALID_CONTINUOUS_CONFIG = HRESULT(0x80045394);
enum HRESULT FSRM_E_LEGACY_SCHEDULE = HRESULT(0x80045395);
enum HRESULT FSRM_E_CSC_PATH_NOT_SUPPORTED = HRESULT(0x80045396);

enum : HRESULT
{
    FSRM_E_EXPIRATION_PATH_NOT_WRITEABLE = HRESULT(0x80045397),
    FSRM_E_EXPIRATION_PATH_TOO_LONG      = HRESULT(0x80045398),
    FSRM_E_EXPIRATION_VOLUME_NOT_NTFS    = HRESULT(0x80045399),
}

enum HRESULT FSRM_E_FILE_MANAGEMENT_JOB_DEPRECATED = HRESULT(0x8004539a);
enum HRESULT FSRM_E_MODULE_TIMEOUT = HRESULT(0x8004539b);

// Interfaces

@GUID("f556d708-6d4d-4594-9c61-7dbb0dae2a46")
struct FsrmSetting;

@GUID("f3be42bd-8ac2-409e-bbd8-faf9b6b41feb")
struct FsrmPathMapper;

@GUID("1482dc37-fae9-4787-9025-8ce4e024ab56")
struct FsrmExportImport;

@GUID("90dcab7f-347c-4bfc-b543-540326305fbe")
struct FsrmQuotaManager;

@GUID("97d3d443-251c-4337-81e7-b32e8f4ee65e")
struct FsrmQuotaTemplateManager;

@GUID("8f1363f6-656f-4496-9226-13aecbd7718f")
struct FsrmFileGroupManager;

@GUID("95941183-db53-4c5f-b37b-7d0921cf9dc7")
struct FsrmFileScreenManager;

@GUID("243111df-e474-46aa-a054-eaa33edc292a")
struct FsrmFileScreenTemplateManager;

@GUID("0058ef37-aa66-4c48-bd5b-2fce432ab0c8")
struct FsrmReportManager;

@GUID("ea25f1b8-1b8d-4290-8ee8-e17c12c2fe20")
struct FsrmReportScheduler;

@GUID("eb18f9b2-4c3a-4321-b203-205120cff614")
struct FsrmFileManagementJobManager;

@GUID("b15c0e47-c391-45b9-95c8-eb596c853f3a")
struct FsrmClassificationManager;

@GUID("c7643375-1eb5-44de-a062-623547d933bc")
struct FsrmPipelineModuleConnector;

@GUID("2ae64751-b728-4d6b-97a0-b2da2e7d2a3b")
struct AdSyncTask;

@GUID("100b4fc8-74c1-470f-b1b7-dd7b6bae79bd")
struct FsrmAccessDeniedRemediationClient;

@GUID("22bcef93-4a3f-4183-89f9-2f8b8a628aee")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nn-fsrm-ifsrmobject))], [])
interface IFsrmObject : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmobject-get_id))], [])
    HRESULT get_Id(GUID* id);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmobject-get_description))], [])
    HRESULT get_Description(BSTR* description);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmobject-put_description))], [])
    HRESULT put_Description(BSTR description);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmobject-delete))], [])
    HRESULT Delete();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmobject-commit))], [])
    HRESULT Commit();
}

@GUID("f76fbf3b-8ddd-4b42-b05a-cb1c3ff1fee8")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nn-fsrm-ifsrmcollection))], [])
interface IFsrmCollection : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmcollection-get__newenum))], [])
    HRESULT get__NewEnum(IUnknown* unknown);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmcollection-get_item))], [])
    HRESULT get_Item(int index, VARIANT* item);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmcollection-get_count))], [])
    HRESULT get_Count(int* count);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmcollection-get_state))], [])
    HRESULT get_State(FsrmCollectionState* state);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmcollection-cancel))], [])
    HRESULT Cancel();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmcollection-waitforcompletion))], [])
    HRESULT WaitForCompletion(int waitSeconds, VARIANT_BOOL* completed);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmcollection-getbyid))], [])
    HRESULT GetById(GUID id, VARIANT* entry);
}

@GUID("1bb617b8-3886-49dc-af82-a6c90fa35dda")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nn-fsrm-ifsrmmutablecollection))], [])
interface IFsrmMutableCollection : IFsrmCollection
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmmutablecollection-add))], [])
    HRESULT Add(VARIANT item);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmmutablecollection-remove))], [])
    HRESULT Remove(int index);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmmutablecollection-removebyid))], [])
    HRESULT RemoveById(GUID id);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmmutablecollection-clone))], [])
    HRESULT Clone(IFsrmMutableCollection* collection);
}

@GUID("96deb3b5-8b91-4a2a-9d93-80a35d8aa847")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nn-fsrm-ifsrmcommittablecollection))], [])
interface IFsrmCommittableCollection : IFsrmMutableCollection
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmcommittablecollection-commit))], [])
    HRESULT Commit(FsrmCommitOptions options, IFsrmCollection* results);
}

@GUID("6cd6408a-ae60-463b-9ef1-e117534d69dc")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nn-fsrm-ifsrmaction))], [])
interface IFsrmAction : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmaction-get_id))], [])
    HRESULT get_Id(GUID* id);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmaction-get_actiontype))], [])
    HRESULT get_ActionType(FsrmActionType* actionType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmaction-get_runlimitinterval))], [])
    HRESULT get_RunLimitInterval(int* minutes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmaction-put_runlimitinterval))], [])
    HRESULT put_RunLimitInterval(int minutes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmaction-delete))], [])
    HRESULT Delete();
}

@GUID("d646567d-26ae-4caa-9f84-4e0aad207fca")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nn-fsrm-ifsrmactionemail))], [])
interface IFsrmActionEmail : IFsrmAction
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmactionemail-get_mailfrom))], [])
    HRESULT get_MailFrom(BSTR* mailFrom);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmactionemail-put_mailfrom))], [])
    HRESULT put_MailFrom(BSTR mailFrom);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmactionemail-get_mailreplyto))], [])
    HRESULT get_MailReplyTo(BSTR* mailReplyTo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmactionemail-put_mailreplyto))], [])
    HRESULT put_MailReplyTo(BSTR mailReplyTo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmactionemail-get_mailto))], [])
    HRESULT get_MailTo(BSTR* mailTo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmactionemail-put_mailto))], [])
    HRESULT put_MailTo(BSTR mailTo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmactionemail-get_mailcc))], [])
    HRESULT get_MailCc(BSTR* mailCc);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmactionemail-put_mailcc))], [])
    HRESULT put_MailCc(BSTR mailCc);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmactionemail-get_mailbcc))], [])
    HRESULT get_MailBcc(BSTR* mailBcc);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmactionemail-put_mailbcc))], [])
    HRESULT put_MailBcc(BSTR mailBcc);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmactionemail-get_mailsubject))], [])
    HRESULT get_MailSubject(BSTR* mailSubject);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmactionemail-put_mailsubject))], [])
    HRESULT put_MailSubject(BSTR mailSubject);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmactionemail-get_messagetext))], [])
    HRESULT get_MessageText(BSTR* messageText);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmactionemail-put_messagetext))], [])
    HRESULT put_MessageText(BSTR messageText);
}

@GUID("8276702f-2532-4839-89bf-4872609a2ea4")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nn-fsrm-ifsrmactionemail2))], [])
interface IFsrmActionEmail2 : IFsrmActionEmail
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmactionemail2-get_attachmentfilelistsize))], [])
    HRESULT get_AttachmentFileListSize(int* attachmentFileListSize);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmactionemail2-put_attachmentfilelistsize))], [])
    HRESULT put_AttachmentFileListSize(int attachmentFileListSize);
}

@GUID("2dbe63c4-b340-48a0-a5b0-158e07fc567e")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nn-fsrm-ifsrmactionreport))], [])
interface IFsrmActionReport : IFsrmAction
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmactionreport-get_reporttypes))], [])
    HRESULT get_ReportTypes(SAFEARRAY** reportTypes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmactionreport-put_reporttypes))], [])
    HRESULT put_ReportTypes(SAFEARRAY* reportTypes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmactionreport-get_mailto))], [])
    HRESULT get_MailTo(BSTR* mailTo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmactionreport-put_mailto))], [])
    HRESULT put_MailTo(BSTR mailTo);
}

@GUID("4c8f96c3-5d94-4f37-a4f4-f56ab463546f")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nn-fsrm-ifsrmactioneventlog))], [])
interface IFsrmActionEventLog : IFsrmAction
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmactioneventlog-get_eventtype))], [])
    HRESULT get_EventType(FsrmEventType* eventType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmactioneventlog-put_eventtype))], [])
    HRESULT put_EventType(FsrmEventType eventType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmactioneventlog-get_messagetext))], [])
    HRESULT get_MessageText(BSTR* messageText);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmactioneventlog-put_messagetext))], [])
    HRESULT put_MessageText(BSTR messageText);
}

@GUID("12937789-e247-4917-9c20-f3ee9c7ee783")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nn-fsrm-ifsrmactioncommand))], [])
interface IFsrmActionCommand : IFsrmAction
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmactioncommand-get_executablepath))], [])
    HRESULT get_ExecutablePath(BSTR* executablePath);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmactioncommand-put_executablepath))], [])
    HRESULT put_ExecutablePath(BSTR executablePath);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmactioncommand-get_arguments))], [])
    HRESULT get_Arguments(BSTR* arguments);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmactioncommand-put_arguments))], [])
    HRESULT put_Arguments(BSTR arguments);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmactioncommand-get_account))], [])
    HRESULT get_Account(FsrmAccountType* account);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmactioncommand-put_account))], [])
    HRESULT put_Account(FsrmAccountType account);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmactioncommand-get_workingdirectory))], [])
    HRESULT get_WorkingDirectory(BSTR* workingDirectory);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmactioncommand-put_workingdirectory))], [])
    HRESULT put_WorkingDirectory(BSTR workingDirectory);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmactioncommand-get_monitorcommand))], [])
    HRESULT get_MonitorCommand(VARIANT_BOOL* monitorCommand);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmactioncommand-put_monitorcommand))], [])
    HRESULT put_MonitorCommand(VARIANT_BOOL monitorCommand);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmactioncommand-get_killtimeout))], [])
    HRESULT get_KillTimeOut(int* minutes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmactioncommand-put_killtimeout))], [])
    HRESULT put_KillTimeOut(int minutes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmactioncommand-get_logresult))], [])
    HRESULT get_LogResult(VARIANT_BOOL* logResults);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmactioncommand-put_logresult))], [])
    HRESULT put_LogResult(VARIANT_BOOL logResults);
}

@GUID("f411d4fd-14be-4260-8c40-03b7c95e608a")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nn-fsrm-ifsrmsetting))], [])
interface IFsrmSetting : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmsetting-get_smtpserver))], [])
    HRESULT get_SmtpServer(BSTR* smtpServer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmsetting-put_smtpserver))], [])
    HRESULT put_SmtpServer(BSTR smtpServer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmsetting-get_mailfrom))], [])
    HRESULT get_MailFrom(BSTR* mailFrom);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmsetting-put_mailfrom))], [])
    HRESULT put_MailFrom(BSTR mailFrom);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmsetting-get_adminemail))], [])
    HRESULT get_AdminEmail(BSTR* adminEmail);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmsetting-put_adminemail))], [])
    HRESULT put_AdminEmail(BSTR adminEmail);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmsetting-get_disablecommandline))], [])
    HRESULT get_DisableCommandLine(VARIANT_BOOL* disableCommandLine);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmsetting-put_disablecommandline))], [])
    HRESULT put_DisableCommandLine(VARIANT_BOOL disableCommandLine);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmsetting-get_enablescreeningaudit))], [])
    HRESULT get_EnableScreeningAudit(VARIANT_BOOL* enableScreeningAudit);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmsetting-put_enablescreeningaudit))], [])
    HRESULT put_EnableScreeningAudit(VARIANT_BOOL enableScreeningAudit);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmsetting-emailtest))], [])
    HRESULT EmailTest(BSTR mailTo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmsetting-setactionrunlimitinterval))], [])
    HRESULT SetActionRunLimitInterval(FsrmActionType actionType, int delayTimeMinutes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmsetting-getactionrunlimitinterval))], [])
    HRESULT GetActionRunLimitInterval(FsrmActionType actionType, int* delayTimeMinutes);
}

@GUID("6f4dbfff-6920-4821-a6c3-b7e94c1fd60c")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nn-fsrm-ifsrmpathmapper))], [])
interface IFsrmPathMapper : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmpathmapper-getsharepathsforlocalpath))], [])
    HRESULT GetSharePathsForLocalPath(BSTR localPath, SAFEARRAY** sharePaths);
}

@GUID("efcb0ab1-16c4-4a79-812c-725614c3306b")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nn-fsrm-ifsrmexportimport))], [])
interface IFsrmExportImport : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmexportimport-exportfilegroups))], [])
    HRESULT ExportFileGroups(BSTR filePath, VARIANT* fileGroupNamesSafeArray, BSTR remoteHost);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmexportimport-importfilegroups))], [])
    HRESULT ImportFileGroups(BSTR filePath, VARIANT* fileGroupNamesSafeArray, BSTR remoteHost, 
                             IFsrmCommittableCollection* fileGroups);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmexportimport-exportfilescreentemplates))], [])
    HRESULT ExportFileScreenTemplates(BSTR filePath, VARIANT* templateNamesSafeArray, BSTR remoteHost);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmexportimport-importfilescreentemplates))], [])
    HRESULT ImportFileScreenTemplates(BSTR filePath, VARIANT* templateNamesSafeArray, BSTR remoteHost, 
                                      IFsrmCommittableCollection* templates);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmexportimport-exportquotatemplates))], [])
    HRESULT ExportQuotaTemplates(BSTR filePath, VARIANT* templateNamesSafeArray, BSTR remoteHost);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmexportimport-importquotatemplates))], [])
    HRESULT ImportQuotaTemplates(BSTR filePath, VARIANT* templateNamesSafeArray, BSTR remoteHost, 
                                 IFsrmCommittableCollection* templates);
}

@GUID("39322a2d-38ee-4d0d-8095-421a80849a82")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nn-fsrm-ifsrmderivedobjectsresult))], [])
interface IFsrmDerivedObjectsResult : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmderivedobjectsresult-get_derivedobjects))], [])
    HRESULT get_DerivedObjects(IFsrmCollection* derivedObjects);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmderivedobjectsresult-get_results))], [])
    HRESULT get_Results(IFsrmCollection* results);
}

@GUID("40002314-590b-45a5-8e1b-8c05da527e52")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nn-fsrm-ifsrmaccessdeniedremediationclient))], [])
interface IFsrmAccessDeniedRemediationClient : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrm/nf-fsrm-ifsrmaccessdeniedremediationclient-show))], [])
    HRESULT Show(size_t parentWnd, BSTR accessPath, AdrClientErrorType errorType, int flags, BSTR windowTitle, 
                 BSTR windowMessage, int* result);
}

@GUID("1568a795-3924-4118-b74b-68d8f0fa5daf")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nn-fsrmquota-ifsrmquotabase))], [])
interface IFsrmQuotaBase : IFsrmObject
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nf-fsrmquota-ifsrmquotabase-get_quotalimit))], [])
    HRESULT get_QuotaLimit(VARIANT* quotaLimit);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nf-fsrmquota-ifsrmquotabase-put_quotalimit))], [])
    HRESULT put_QuotaLimit(VARIANT quotaLimit);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nf-fsrmquota-ifsrmquotabase-get_quotaflags))], [])
    HRESULT get_QuotaFlags(int* quotaFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nf-fsrmquota-ifsrmquotabase-put_quotaflags))], [])
    HRESULT put_QuotaFlags(int quotaFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nf-fsrmquota-ifsrmquotabase-get_thresholds))], [])
    HRESULT get_Thresholds(SAFEARRAY** thresholds);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nf-fsrmquota-ifsrmquotabase-addthreshold))], [])
    HRESULT AddThreshold(int threshold);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nf-fsrmquota-ifsrmquotabase-deletethreshold))], [])
    HRESULT DeleteThreshold(int threshold);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nf-fsrmquota-ifsrmquotabase-modifythreshold))], [])
    HRESULT ModifyThreshold(int threshold, int newThreshold);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nf-fsrmquota-ifsrmquotabase-createthresholdaction))], [])
    HRESULT CreateThresholdAction(int threshold, FsrmActionType actionType, IFsrmAction* action);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nf-fsrmquota-ifsrmquotabase-enumthresholdactions))], [])
    HRESULT EnumThresholdActions(int threshold, IFsrmCollection* actions);
}

@GUID("42dc3511-61d5-48ae-b6dc-59fc00c0a8d6")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nn-fsrmquota-ifsrmquotaobject))], [])
interface IFsrmQuotaObject : IFsrmQuotaBase
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nf-fsrmquota-ifsrmquotaobject-get_path))], [])
    HRESULT get_Path(BSTR* path);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nf-fsrmquota-ifsrmquotaobject-get_usersid))], [])
    HRESULT get_UserSid(BSTR* userSid);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nf-fsrmquota-ifsrmquotaobject-get_useraccount))], [])
    HRESULT get_UserAccount(BSTR* userAccount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nf-fsrmquota-ifsrmquotaobject-get_sourcetemplatename))], [])
    HRESULT get_SourceTemplateName(BSTR* quotaTemplateName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nf-fsrmquota-ifsrmquotaobject-get_matchessourcetemplate))], [])
    HRESULT get_MatchesSourceTemplate(VARIANT_BOOL* matches);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nf-fsrmquota-ifsrmquotaobject-applytemplate))], [])
    HRESULT ApplyTemplate(BSTR quotaTemplateName);
}

@GUID("377f739d-9647-4b8e-97d2-5ffce6d759cd")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nn-fsrmquota-ifsrmquota))], [])
interface IFsrmQuota : IFsrmQuotaObject
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nf-fsrmquota-ifsrmquota-get_quotaused))], [])
    HRESULT get_QuotaUsed(VARIANT* used);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nf-fsrmquota-ifsrmquota-get_quotapeakusage))], [])
    HRESULT get_QuotaPeakUsage(VARIANT* peakUsage);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nf-fsrmquota-ifsrmquota-get_quotapeakusagetime))], [])
    HRESULT get_QuotaPeakUsageTime(double* peakUsageDateTime);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nf-fsrmquota-ifsrmquota-resetpeakusage))], [])
    HRESULT ResetPeakUsage();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nf-fsrmquota-ifsrmquota-refreshusageproperties))], [])
    HRESULT RefreshUsageProperties();
}

@GUID("f82e5729-6aba-4740-bfc7-c7f58f75fb7b")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nn-fsrmquota-ifsrmautoapplyquota))], [])
interface IFsrmAutoApplyQuota : IFsrmQuotaObject
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nf-fsrmquota-ifsrmautoapplyquota-get_excludefolders))], [])
    HRESULT get_ExcludeFolders(SAFEARRAY** folders);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nf-fsrmquota-ifsrmautoapplyquota-put_excludefolders))], [])
    HRESULT put_ExcludeFolders(SAFEARRAY* folders);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nf-fsrmquota-ifsrmautoapplyquota-commitandupdatederived))], [])
    HRESULT CommitAndUpdateDerived(FsrmCommitOptions commitOptions, FsrmTemplateApplyOptions applyOptions, 
                                   IFsrmDerivedObjectsResult* derivedObjectsResult);
}

@GUID("8bb68c7d-19d8-4ffb-809e-be4fc1734014")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nn-fsrmquota-ifsrmquotamanager))], [])
interface IFsrmQuotaManager : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nf-fsrmquota-ifsrmquotamanager-get_actionvariables))], [])
    HRESULT get_ActionVariables(SAFEARRAY** variables);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nf-fsrmquota-ifsrmquotamanager-get_actionvariabledescriptions))], [])
    HRESULT get_ActionVariableDescriptions(SAFEARRAY** descriptions);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nf-fsrmquota-ifsrmquotamanager-createquota))], [])
    HRESULT CreateQuota(BSTR path, IFsrmQuota* quota);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nf-fsrmquota-ifsrmquotamanager-createautoapplyquota))], [])
    HRESULT CreateAutoApplyQuota(BSTR quotaTemplateName, BSTR path, IFsrmAutoApplyQuota* quota);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nf-fsrmquota-ifsrmquotamanager-getquota))], [])
    HRESULT GetQuota(BSTR path, IFsrmQuota* quota);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nf-fsrmquota-ifsrmquotamanager-getautoapplyquota))], [])
    HRESULT GetAutoApplyQuota(BSTR path, IFsrmAutoApplyQuota* quota);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nf-fsrmquota-ifsrmquotamanager-getrestrictivequota))], [])
    HRESULT GetRestrictiveQuota(BSTR path, IFsrmQuota* quota);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nf-fsrmquota-ifsrmquotamanager-enumquotas))], [])
    HRESULT EnumQuotas(BSTR path, FsrmEnumOptions options, IFsrmCommittableCollection* quotas);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nf-fsrmquota-ifsrmquotamanager-enumautoapplyquotas))], [])
    HRESULT EnumAutoApplyQuotas(BSTR path, FsrmEnumOptions options, IFsrmCommittableCollection* quotas);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nf-fsrmquota-ifsrmquotamanager-enumeffectivequotas))], [])
    HRESULT EnumEffectiveQuotas(BSTR path, FsrmEnumOptions options, IFsrmCommittableCollection* quotas);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nf-fsrmquota-ifsrmquotamanager-scan))], [])
    HRESULT Scan(BSTR strPath);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nf-fsrmquota-ifsrmquotamanager-createquotacollection))], [])
    HRESULT CreateQuotaCollection(IFsrmCommittableCollection* collection);
}

@GUID("4846cb01-d430-494f-abb4-b1054999fb09")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nn-fsrmquota-ifsrmquotamanagerex))], [])
interface IFsrmQuotaManagerEx : IFsrmQuotaManager
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nf-fsrmquota-ifsrmquotamanagerex-isaffectedbyquota))], [])
    HRESULT IsAffectedByQuota(BSTR path, FsrmEnumOptions options, VARIANT_BOOL* affected);
}

@GUID("a2efab31-295e-46bb-b976-e86d58b52e8b")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nn-fsrmquota-ifsrmquotatemplate))], [])
interface IFsrmQuotaTemplate : IFsrmQuotaBase
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nf-fsrmquota-ifsrmquotatemplate-get_name))], [])
    HRESULT get_Name(BSTR* name);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nf-fsrmquota-ifsrmquotatemplate-put_name))], [])
    HRESULT put_Name(BSTR name);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nf-fsrmquota-ifsrmquotatemplate-copytemplate))], [])
    HRESULT CopyTemplate(BSTR quotaTemplateName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nf-fsrmquota-ifsrmquotatemplate-commitandupdatederived))], [])
    HRESULT CommitAndUpdateDerived(FsrmCommitOptions commitOptions, FsrmTemplateApplyOptions applyOptions, 
                                   IFsrmDerivedObjectsResult* derivedObjectsResult);
}

@GUID("9a2bf113-a329-44cc-809a-5c00fce8da40")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nn-fsrmquota-ifsrmquotatemplateimported))], [])
interface IFsrmQuotaTemplateImported : IFsrmQuotaTemplate
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nf-fsrmquota-ifsrmquotatemplateimported-get_overwriteoncommit))], [])
    HRESULT get_OverwriteOnCommit(VARIANT_BOOL* overwrite);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nf-fsrmquota-ifsrmquotatemplateimported-put_overwriteoncommit))], [])
    HRESULT put_OverwriteOnCommit(VARIANT_BOOL overwrite);
}

@GUID("4173ac41-172d-4d52-963c-fdc7e415f717")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nn-fsrmquota-ifsrmquotatemplatemanager))], [])
interface IFsrmQuotaTemplateManager : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nf-fsrmquota-ifsrmquotatemplatemanager-createtemplate))], [])
    HRESULT CreateTemplate(IFsrmQuotaTemplate* quotaTemplate);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nf-fsrmquota-ifsrmquotatemplatemanager-gettemplate))], [])
    HRESULT GetTemplate(BSTR name, IFsrmQuotaTemplate* quotaTemplate);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nf-fsrmquota-ifsrmquotatemplatemanager-enumtemplates))], [])
    HRESULT EnumTemplates(FsrmEnumOptions options, IFsrmCommittableCollection* quotaTemplates);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nf-fsrmquota-ifsrmquotatemplatemanager-exporttemplates))], [])
    HRESULT ExportTemplates(VARIANT* quotaTemplateNamesArray, BSTR* serializedQuotaTemplates);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmquota/nf-fsrmquota-ifsrmquotatemplatemanager-importtemplates))], [])
    HRESULT ImportTemplates(BSTR serializedQuotaTemplates, VARIANT* quotaTemplateNamesArray, 
                            IFsrmCommittableCollection* quotaTemplates);
}

@GUID("8dd04909-0e34-4d55-afaa-89e1f1a1bbb9")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nn-fsrmscreen-ifsrmfilegroup))], [])
interface IFsrmFileGroup : IFsrmObject
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nf-fsrmscreen-ifsrmfilegroup-get_name))], [])
    HRESULT get_Name(BSTR* name);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nf-fsrmscreen-ifsrmfilegroup-put_name))], [])
    HRESULT put_Name(BSTR name);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nf-fsrmscreen-ifsrmfilegroup-get_members))], [])
    HRESULT get_Members(IFsrmMutableCollection* members);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nf-fsrmscreen-ifsrmfilegroup-put_members))], [])
    HRESULT put_Members(IFsrmMutableCollection members);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nf-fsrmscreen-ifsrmfilegroup-get_nonmembers))], [])
    HRESULT get_NonMembers(IFsrmMutableCollection* nonMembers);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nf-fsrmscreen-ifsrmfilegroup-put_nonmembers))], [])
    HRESULT put_NonMembers(IFsrmMutableCollection nonMembers);
}

@GUID("ad55f10b-5f11-4be7-94ef-d9ee2e470ded")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nn-fsrmscreen-ifsrmfilegroupimported))], [])
interface IFsrmFileGroupImported : IFsrmFileGroup
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nf-fsrmscreen-ifsrmfilegroupimported-get_overwriteoncommit))], [])
    HRESULT get_OverwriteOnCommit(VARIANT_BOOL* overwrite);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nf-fsrmscreen-ifsrmfilegroupimported-put_overwriteoncommit))], [])
    HRESULT put_OverwriteOnCommit(VARIANT_BOOL overwrite);
}

@GUID("426677d5-018c-485c-8a51-20b86d00bdc4")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nn-fsrmscreen-ifsrmfilegroupmanager))], [])
interface IFsrmFileGroupManager : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nf-fsrmscreen-ifsrmfilegroupmanager-createfilegroup))], [])
    HRESULT CreateFileGroup(IFsrmFileGroup* fileGroup);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nf-fsrmscreen-ifsrmfilegroupmanager-getfilegroup))], [])
    HRESULT GetFileGroup(BSTR name, IFsrmFileGroup* fileGroup);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nf-fsrmscreen-ifsrmfilegroupmanager-enumfilegroups))], [])
    HRESULT EnumFileGroups(FsrmEnumOptions options, IFsrmCommittableCollection* fileGroups);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nf-fsrmscreen-ifsrmfilegroupmanager-exportfilegroups))], [])
    HRESULT ExportFileGroups(VARIANT* fileGroupNamesArray, BSTR* serializedFileGroups);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nf-fsrmscreen-ifsrmfilegroupmanager-importfilegroups))], [])
    HRESULT ImportFileGroups(BSTR serializedFileGroups, VARIANT* fileGroupNamesArray, 
                             IFsrmCommittableCollection* fileGroups);
}

@GUID("f3637e80-5b22-4a2b-a637-bbb642b41cfc")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nn-fsrmscreen-ifsrmfilescreenbase))], [])
interface IFsrmFileScreenBase : IFsrmObject
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nf-fsrmscreen-ifsrmfilescreenbase-get_blockedfilegroups))], [])
    HRESULT get_BlockedFileGroups(IFsrmMutableCollection* blockList);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nf-fsrmscreen-ifsrmfilescreenbase-put_blockedfilegroups))], [])
    HRESULT put_BlockedFileGroups(IFsrmMutableCollection blockList);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nf-fsrmscreen-ifsrmfilescreenbase-get_filescreenflags))], [])
    HRESULT get_FileScreenFlags(int* fileScreenFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nf-fsrmscreen-ifsrmfilescreenbase-put_filescreenflags))], [])
    HRESULT put_FileScreenFlags(int fileScreenFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nf-fsrmscreen-ifsrmfilescreenbase-createaction))], [])
    HRESULT CreateAction(FsrmActionType actionType, IFsrmAction* action);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nf-fsrmscreen-ifsrmfilescreenbase-enumactions))], [])
    HRESULT EnumActions(IFsrmCollection* actions);
}

@GUID("5f6325d3-ce88-4733-84c1-2d6aefc5ea07")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nn-fsrmscreen-ifsrmfilescreen))], [])
interface IFsrmFileScreen : IFsrmFileScreenBase
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nf-fsrmscreen-ifsrmfilescreen-get_path))], [])
    HRESULT get_Path(BSTR* path);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nf-fsrmscreen-ifsrmfilescreen-get_sourcetemplatename))], [])
    HRESULT get_SourceTemplateName(BSTR* fileScreenTemplateName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nf-fsrmscreen-ifsrmfilescreen-get_matchessourcetemplate))], [])
    HRESULT get_MatchesSourceTemplate(VARIANT_BOOL* matches);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nf-fsrmscreen-ifsrmfilescreen-get_usersid))], [])
    HRESULT get_UserSid(BSTR* userSid);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nf-fsrmscreen-ifsrmfilescreen-get_useraccount))], [])
    HRESULT get_UserAccount(BSTR* userAccount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nf-fsrmscreen-ifsrmfilescreen-applytemplate))], [])
    HRESULT ApplyTemplate(BSTR fileScreenTemplateName);
}

@GUID("bee7ce02-df77-4515-9389-78f01c5afc1a")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nn-fsrmscreen-ifsrmfilescreenexception))], [])
interface IFsrmFileScreenException : IFsrmObject
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nf-fsrmscreen-ifsrmfilescreenexception-get_path))], [])
    HRESULT get_Path(BSTR* path);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nf-fsrmscreen-ifsrmfilescreenexception-get_allowedfilegroups))], [])
    HRESULT get_AllowedFileGroups(IFsrmMutableCollection* allowList);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nf-fsrmscreen-ifsrmfilescreenexception-put_allowedfilegroups))], [])
    HRESULT put_AllowedFileGroups(IFsrmMutableCollection allowList);
}

@GUID("ff4fa04e-5a94-4bda-a3a0-d5b4d3c52eba")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nn-fsrmscreen-ifsrmfilescreenmanager))], [])
interface IFsrmFileScreenManager : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nf-fsrmscreen-ifsrmfilescreenmanager-get_actionvariables))], [])
    HRESULT get_ActionVariables(SAFEARRAY** variables);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nf-fsrmscreen-ifsrmfilescreenmanager-get_actionvariabledescriptions))], [])
    HRESULT get_ActionVariableDescriptions(SAFEARRAY** descriptions);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nf-fsrmscreen-ifsrmfilescreenmanager-createfilescreen))], [])
    HRESULT CreateFileScreen(BSTR path, IFsrmFileScreen* fileScreen);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nf-fsrmscreen-ifsrmfilescreenmanager-getfilescreen))], [])
    HRESULT GetFileScreen(BSTR path, IFsrmFileScreen* fileScreen);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nf-fsrmscreen-ifsrmfilescreenmanager-enumfilescreens))], [])
    HRESULT EnumFileScreens(BSTR path, FsrmEnumOptions options, IFsrmCommittableCollection* fileScreens);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nf-fsrmscreen-ifsrmfilescreenmanager-createfilescreenexception))], [])
    HRESULT CreateFileScreenException(BSTR path, IFsrmFileScreenException* fileScreenException);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nf-fsrmscreen-ifsrmfilescreenmanager-getfilescreenexception))], [])
    HRESULT GetFileScreenException(BSTR path, IFsrmFileScreenException* fileScreenException);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nf-fsrmscreen-ifsrmfilescreenmanager-enumfilescreenexceptions))], [])
    HRESULT EnumFileScreenExceptions(BSTR path, FsrmEnumOptions options, 
                                     IFsrmCommittableCollection* fileScreenExceptions);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nf-fsrmscreen-ifsrmfilescreenmanager-createfilescreencollection))], [])
    HRESULT CreateFileScreenCollection(IFsrmCommittableCollection* collection);
}

@GUID("205bebf8-dd93-452a-95a6-32b566b35828")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nn-fsrmscreen-ifsrmfilescreentemplate))], [])
interface IFsrmFileScreenTemplate : IFsrmFileScreenBase
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nf-fsrmscreen-ifsrmfilescreentemplate-get_name))], [])
    HRESULT get_Name(BSTR* name);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nf-fsrmscreen-ifsrmfilescreentemplate-put_name))], [])
    HRESULT put_Name(BSTR name);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nf-fsrmscreen-ifsrmfilescreentemplate-copytemplate))], [])
    HRESULT CopyTemplate(BSTR fileScreenTemplateName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nf-fsrmscreen-ifsrmfilescreentemplate-commitandupdatederived))], [])
    HRESULT CommitAndUpdateDerived(FsrmCommitOptions commitOptions, FsrmTemplateApplyOptions applyOptions, 
                                   IFsrmDerivedObjectsResult* derivedObjectsResult);
}

@GUID("e1010359-3e5d-4ecd-9fe4-ef48622fdf30")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nn-fsrmscreen-ifsrmfilescreentemplateimported))], [])
interface IFsrmFileScreenTemplateImported : IFsrmFileScreenTemplate
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nf-fsrmscreen-ifsrmfilescreentemplateimported-get_overwriteoncommit))], [])
    HRESULT get_OverwriteOnCommit(VARIANT_BOOL* overwrite);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nf-fsrmscreen-ifsrmfilescreentemplateimported-put_overwriteoncommit))], [])
    HRESULT put_OverwriteOnCommit(VARIANT_BOOL overwrite);
}

@GUID("cfe36cba-1949-4e74-a14f-f1d580ceaf13")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nn-fsrmscreen-ifsrmfilescreentemplatemanager))], [])
interface IFsrmFileScreenTemplateManager : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nf-fsrmscreen-ifsrmfilescreentemplatemanager-createtemplate))], [])
    HRESULT CreateTemplate(IFsrmFileScreenTemplate* fileScreenTemplate);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nf-fsrmscreen-ifsrmfilescreentemplatemanager-gettemplate))], [])
    HRESULT GetTemplate(BSTR name, IFsrmFileScreenTemplate* fileScreenTemplate);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nf-fsrmscreen-ifsrmfilescreentemplatemanager-enumtemplates))], [])
    HRESULT EnumTemplates(FsrmEnumOptions options, IFsrmCommittableCollection* fileScreenTemplates);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nf-fsrmscreen-ifsrmfilescreentemplatemanager-exporttemplates))], [])
    HRESULT ExportTemplates(VARIANT* fileScreenTemplateNamesArray, BSTR* serializedFileScreenTemplates);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmscreen/nf-fsrmscreen-ifsrmfilescreentemplatemanager-importtemplates))], [])
    HRESULT ImportTemplates(BSTR serializedFileScreenTemplates, VARIANT* fileScreenTemplateNamesArray, 
                            IFsrmCommittableCollection* fileScreenTemplates);
}

@GUID("27b899fe-6ffa-4481-a184-d3daade8a02b")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nn-fsrmreports-ifsrmreportmanager))], [])
interface IFsrmReportManager : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmreportmanager-enumreportjobs))], [])
    HRESULT EnumReportJobs(FsrmEnumOptions options, IFsrmCollection* reportJobs);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmreportmanager-createreportjob))], [])
    HRESULT CreateReportJob(IFsrmReportJob* reportJob);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmreportmanager-getreportjob))], [])
    HRESULT GetReportJob(BSTR taskName, IFsrmReportJob* reportJob);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmreportmanager-getoutputdirectory))], [])
    HRESULT GetOutputDirectory(FsrmReportGenerationContext context, BSTR* path);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmreportmanager-setoutputdirectory))], [])
    HRESULT SetOutputDirectory(FsrmReportGenerationContext context, BSTR path);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmreportmanager-isfiltervalidforreporttype))], [])
    HRESULT IsFilterValidForReportType(FsrmReportType reportType, FsrmReportFilter filter, VARIANT_BOOL* valid);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmreportmanager-getdefaultfilter))], [])
    HRESULT GetDefaultFilter(FsrmReportType reportType, FsrmReportFilter filter, VARIANT* filterValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmreportmanager-setdefaultfilter))], [])
    HRESULT SetDefaultFilter(FsrmReportType reportType, FsrmReportFilter filter, VARIANT filterValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmreportmanager-getreportsizelimit))], [])
    HRESULT GetReportSizeLimit(FsrmReportLimit limit, VARIANT* limitValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmreportmanager-setreportsizelimit))], [])
    HRESULT SetReportSizeLimit(FsrmReportLimit limit, VARIANT limitValue);
}

@GUID("38e87280-715c-4c7d-a280-ea1651a19fef")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nn-fsrmreports-ifsrmreportjob))], [])
interface IFsrmReportJob : IFsrmObject
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmreportjob-get_task))], [])
    HRESULT get_Task(BSTR* taskName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmreportjob-put_task))], [])
    HRESULT put_Task(BSTR taskName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmreportjob-get_namespaceroots))], [])
    HRESULT get_NamespaceRoots(SAFEARRAY** namespaceRoots);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmreportjob-put_namespaceroots))], [])
    HRESULT put_NamespaceRoots(SAFEARRAY* namespaceRoots);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmreportjob-get_formats))], [])
    HRESULT get_Formats(SAFEARRAY** formats);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmreportjob-put_formats))], [])
    HRESULT put_Formats(SAFEARRAY* formats);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmreportjob-get_mailto))], [])
    HRESULT get_MailTo(BSTR* mailTo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmreportjob-put_mailto))], [])
    HRESULT put_MailTo(BSTR mailTo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmreportjob-get_runningstatus))], [])
    HRESULT get_RunningStatus(FsrmReportRunningStatus* runningStatus);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmreportjob-get_lastrun))], [])
    HRESULT get_LastRun(double* lastRun);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmreportjob-get_lasterror))], [])
    HRESULT get_LastError(BSTR* lastError);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmreportjob-get_lastgeneratedindirectory))], [])
    HRESULT get_LastGeneratedInDirectory(BSTR* path);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmreportjob-enumreports))], [])
    HRESULT EnumReports(IFsrmCollection* reports);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmreportjob-createreport))], [])
    HRESULT CreateReport(FsrmReportType reportType, IFsrmReport* report);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmreportjob-run))], [])
    HRESULT Run(FsrmReportGenerationContext context);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmreportjob-waitforcompletion))], [])
    HRESULT WaitForCompletion(int waitSeconds, VARIANT_BOOL* completed);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmreportjob-cancel))], [])
    HRESULT Cancel();
}

@GUID("d8cc81d9-46b8-4fa4-bfa5-4aa9dec9b638")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nn-fsrmreports-ifsrmreport))], [])
interface IFsrmReport : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmreport-get_type))], [])
    HRESULT get_Type(FsrmReportType* reportType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmreport-get_name))], [])
    HRESULT get_Name(BSTR* name);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmreport-put_name))], [])
    HRESULT put_Name(BSTR name);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmreport-get_description))], [])
    HRESULT get_Description(BSTR* description);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmreport-put_description))], [])
    HRESULT put_Description(BSTR description);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmreport-get_lastgeneratedfilenameprefix))], [])
    HRESULT get_LastGeneratedFileNamePrefix(BSTR* prefix);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmreport-getfilter))], [])
    HRESULT GetFilter(FsrmReportFilter filter, VARIANT* filterValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmreport-setfilter))], [])
    HRESULT SetFilter(FsrmReportFilter filter, VARIANT filterValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmreport-delete))], [])
    HRESULT Delete();
}

@GUID("6879caf9-6617-4484-8719-71c3d8645f94")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nn-fsrmreports-ifsrmreportscheduler))], [])
interface IFsrmReportScheduler : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmreportscheduler-verifynamespaces))], [])
    HRESULT VerifyNamespaces(VARIANT* namespacesSafeArray);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmreportscheduler-createscheduletask))], [])
    HRESULT CreateScheduleTask(BSTR taskName, VARIANT* namespacesSafeArray, BSTR serializedTask);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmreportscheduler-modifyscheduletask))], [])
    HRESULT ModifyScheduleTask(BSTR taskName, VARIANT* namespacesSafeArray, BSTR serializedTask);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmreportscheduler-deletescheduletask))], [])
    HRESULT DeleteScheduleTask(BSTR taskName);
}

@GUID("ee321ecb-d95e-48e9-907c-c7685a013235")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nn-fsrmreports-ifsrmfilemanagementjobmanager))], [])
interface IFsrmFileManagementJobManager : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjobmanager-get_actionvariables))], [])
    HRESULT get_ActionVariables(SAFEARRAY** variables);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjobmanager-get_actionvariabledescriptions))], [])
    HRESULT get_ActionVariableDescriptions(SAFEARRAY** descriptions);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjobmanager-enumfilemanagementjobs))], [])
    HRESULT EnumFileManagementJobs(FsrmEnumOptions options, IFsrmCollection* fileManagementJobs);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjobmanager-createfilemanagementjob))], [])
    HRESULT CreateFileManagementJob(IFsrmFileManagementJob* fileManagementJob);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjobmanager-getfilemanagementjob))], [])
    HRESULT GetFileManagementJob(BSTR name, IFsrmFileManagementJob* fileManagementJob);
}

@GUID("0770687e-9f36-4d6f-8778-599d188461c9")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nn-fsrmreports-ifsrmfilemanagementjob))], [])
interface IFsrmFileManagementJob : IFsrmObject
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjob-get_name))], [])
    HRESULT get_Name(BSTR* name);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjob-put_name))], [])
    HRESULT put_Name(BSTR name);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjob-get_namespaceroots))], [])
    HRESULT get_NamespaceRoots(SAFEARRAY** namespaceRoots);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjob-put_namespaceroots))], [])
    HRESULT put_NamespaceRoots(SAFEARRAY* namespaceRoots);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjob-get_enabled))], [])
    HRESULT get_Enabled(VARIANT_BOOL* enabled);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjob-put_enabled))], [])
    HRESULT put_Enabled(VARIANT_BOOL enabled);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjob-get_operationtype))], [])
    HRESULT get_OperationType(FsrmFileManagementType* operationType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjob-put_operationtype))], [])
    HRESULT put_OperationType(FsrmFileManagementType operationType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjob-get_expirationdirectory))], [])
    HRESULT get_ExpirationDirectory(BSTR* expirationDirectory);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjob-put_expirationdirectory))], [])
    HRESULT put_ExpirationDirectory(BSTR expirationDirectory);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjob-get_customaction))], [])
    HRESULT get_CustomAction(IFsrmActionCommand* action);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjob-get_notifications))], [])
    HRESULT get_Notifications(SAFEARRAY** notifications);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjob-get_logging))], [])
    HRESULT get_Logging(int* loggingFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjob-put_logging))], [])
    HRESULT put_Logging(int loggingFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjob-get_reportenabled))], [])
    HRESULT get_ReportEnabled(VARIANT_BOOL* reportEnabled);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjob-put_reportenabled))], [])
    HRESULT put_ReportEnabled(VARIANT_BOOL reportEnabled);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjob-get_formats))], [])
    HRESULT get_Formats(SAFEARRAY** formats);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjob-put_formats))], [])
    HRESULT put_Formats(SAFEARRAY* formats);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjob-get_mailto))], [])
    HRESULT get_MailTo(BSTR* mailTo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjob-put_mailto))], [])
    HRESULT put_MailTo(BSTR mailTo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjob-get_dayssincefilecreated))], [])
    HRESULT get_DaysSinceFileCreated(int* daysSinceCreation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjob-put_dayssincefilecreated))], [])
    HRESULT put_DaysSinceFileCreated(int daysSinceCreation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjob-get_dayssincefilelastaccessed))], [])
    HRESULT get_DaysSinceFileLastAccessed(int* daysSinceAccess);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjob-put_dayssincefilelastaccessed))], [])
    HRESULT put_DaysSinceFileLastAccessed(int daysSinceAccess);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjob-get_dayssincefilelastmodified))], [])
    HRESULT get_DaysSinceFileLastModified(int* daysSinceModify);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjob-put_dayssincefilelastmodified))], [])
    HRESULT put_DaysSinceFileLastModified(int daysSinceModify);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjob-get_propertyconditions))], [])
    HRESULT get_PropertyConditions(IFsrmCollection* propertyConditions);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjob-get_fromdate))], [])
    HRESULT get_FromDate(double* fromDate);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjob-put_fromdate))], [])
    HRESULT put_FromDate(double fromDate);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjob-get_task))], [])
    HRESULT get_Task(BSTR* taskName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjob-put_task))], [])
    HRESULT put_Task(BSTR taskName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjob-get_parameters))], [])
    HRESULT get_Parameters(SAFEARRAY** parameters);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjob-put_parameters))], [])
    HRESULT put_Parameters(SAFEARRAY* parameters);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjob-get_runningstatus))], [])
    HRESULT get_RunningStatus(FsrmReportRunningStatus* runningStatus);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjob-get_lasterror))], [])
    HRESULT get_LastError(BSTR* lastError);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjob-get_lastreportpathwithoutextension))], [])
    HRESULT get_LastReportPathWithoutExtension(BSTR* path);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjob-get_lastrun))], [])
    HRESULT get_LastRun(double* lastRun);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjob-get_filenamepattern))], [])
    HRESULT get_FileNamePattern(BSTR* fileNamePattern);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjob-put_filenamepattern))], [])
    HRESULT put_FileNamePattern(BSTR fileNamePattern);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjob-run))], [])
    HRESULT Run(FsrmReportGenerationContext context);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjob-waitforcompletion))], [])
    HRESULT WaitForCompletion(int waitSeconds, VARIANT_BOOL* completed);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjob-cancel))], [])
    HRESULT Cancel();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjob-addnotification))], [])
    HRESULT AddNotification(int days);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjob-deletenotification))], [])
    HRESULT DeleteNotification(int days);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjob-modifynotification))], [])
    HRESULT ModifyNotification(int days, int newDays);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjob-createnotificationaction))], [])
    HRESULT CreateNotificationAction(int days, FsrmActionType actionType, IFsrmAction* action);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjob-enumnotificationactions))], [])
    HRESULT EnumNotificationActions(int days, IFsrmCollection* actions);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjob-createpropertycondition))], [])
    HRESULT CreatePropertyCondition(BSTR name, IFsrmPropertyCondition* propertyCondition);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfilemanagementjob-createcustomaction))], [])
    HRESULT CreateCustomAction(IFsrmActionCommand* customAction);
}

@GUID("326af66f-2ac0-4f68-bf8c-4759f054fa29")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nn-fsrmreports-ifsrmpropertycondition))], [])
interface IFsrmPropertyCondition : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmpropertycondition-get_name))], [])
    HRESULT get_Name(BSTR* name);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmpropertycondition-put_name))], [])
    HRESULT put_Name(BSTR name);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmpropertycondition-get_type))], [])
    HRESULT get_Type(FsrmPropertyConditionType* type);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmpropertycondition-put_type))], [])
    HRESULT put_Type(FsrmPropertyConditionType type);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmpropertycondition-get_value))], [])
    HRESULT get_Value(BSTR* value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmpropertycondition-put_value))], [])
    HRESULT put_Value(BSTR value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmpropertycondition-delete))], [])
    HRESULT Delete();
}

@GUID("70684ffc-691a-4a1a-b922-97752e138cc1")
interface IFsrmFileCondition : IDispatch
{
    HRESULT get_Type(FsrmFileConditionType* pVal);
    HRESULT Delete();
}

@GUID("81926775-b981-4479-988f-da171d627360")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nn-fsrmreports-ifsrmfileconditionproperty))], [])
interface IFsrmFileConditionProperty : IFsrmFileCondition
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfileconditionproperty-get_propertyname))], [])
    HRESULT get_PropertyName(BSTR* pVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfileconditionproperty-put_propertyname))], [])
    HRESULT put_PropertyName(BSTR newVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfileconditionproperty-get_propertyid))], [])
    HRESULT get_PropertyId(FsrmFileSystemPropertyId* pVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfileconditionproperty-put_propertyid))], [])
    HRESULT put_PropertyId(FsrmFileSystemPropertyId newVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfileconditionproperty-get_operator))], [])
    HRESULT get_Operator(FsrmPropertyConditionType* pVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfileconditionproperty-put_operator))], [])
    HRESULT put_Operator(FsrmPropertyConditionType newVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfileconditionproperty-get_valuetype))], [])
    HRESULT get_ValueType(FsrmPropertyValueType* pVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfileconditionproperty-put_valuetype))], [])
    HRESULT put_ValueType(FsrmPropertyValueType newVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfileconditionproperty-get_value))], [])
    HRESULT get_Value(VARIANT* pVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmreports/nf-fsrmreports-ifsrmfileconditionproperty-put_value))], [])
    HRESULT put_Value(VARIANT newVal);
}

@GUID("ede0150f-e9a3-419c-877c-01fe5d24c5d3")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nn-fsrmpipeline-ifsrmpropertydefinition))], [])
interface IFsrmPropertyDefinition : IFsrmObject
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpropertydefinition-get_name))], [])
    HRESULT get_Name(BSTR* name);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpropertydefinition-put_name))], [])
    HRESULT put_Name(BSTR name);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpropertydefinition-get_type))], [])
    HRESULT get_Type(FsrmPropertyDefinitionType* type);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpropertydefinition-put_type))], [])
    HRESULT put_Type(FsrmPropertyDefinitionType type);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpropertydefinition-get_possiblevalues))], [])
    HRESULT get_PossibleValues(SAFEARRAY** possibleValues);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpropertydefinition-put_possiblevalues))], [])
    HRESULT put_PossibleValues(SAFEARRAY* possibleValues);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpropertydefinition-get_valuedescriptions))], [])
    HRESULT get_ValueDescriptions(SAFEARRAY** valueDescriptions);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpropertydefinition-put_valuedescriptions))], [])
    HRESULT put_ValueDescriptions(SAFEARRAY* valueDescriptions);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpropertydefinition-get_parameters))], [])
    HRESULT get_Parameters(SAFEARRAY** parameters);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpropertydefinition-put_parameters))], [])
    HRESULT put_Parameters(SAFEARRAY* parameters);
}

@GUID("47782152-d16c-4229-b4e1-0ddfe308b9f6")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nn-fsrmpipeline-ifsrmpropertydefinition2))], [])
interface IFsrmPropertyDefinition2 : IFsrmPropertyDefinition
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpropertydefinition2-get_propertydefinitionflags))], [])
    HRESULT get_PropertyDefinitionFlags(int* propertyDefinitionFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpropertydefinition2-get_displayname))], [])
    HRESULT get_DisplayName(BSTR* name);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpropertydefinition2-put_displayname))], [])
    HRESULT put_DisplayName(BSTR name);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpropertydefinition2-get_appliesto))], [])
    HRESULT get_AppliesTo(int* appliesTo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpropertydefinition2-get_valuedefinitions))], [])
    HRESULT get_ValueDefinitions(IFsrmCollection* valueDefinitions);
}

@GUID("e946d148-bd67-4178-8e22-1c44925ed710")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nn-fsrmpipeline-ifsrmpropertydefinitionvalue))], [])
interface IFsrmPropertyDefinitionValue : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpropertydefinitionvalue-get_name))], [])
    HRESULT get_Name(BSTR* name);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpropertydefinitionvalue-get_displayname))], [])
    HRESULT get_DisplayName(BSTR* displayName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpropertydefinitionvalue-get_description))], [])
    HRESULT get_Description(BSTR* description);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpropertydefinitionvalue-get_uniqueid))], [])
    HRESULT get_UniqueID(BSTR* uniqueID);
}

@GUID("4a73fee4-4102-4fcc-9ffb-38614f9ee768")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nn-fsrmpipeline-ifsrmproperty))], [])
interface IFsrmProperty : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmproperty-get_name))], [])
    HRESULT get_Name(BSTR* name);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmproperty-get_value))], [])
    HRESULT get_Value(BSTR* value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmproperty-get_sources))], [])
    HRESULT get_Sources(SAFEARRAY** sources);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmproperty-get_propertyflags))], [])
    HRESULT get_PropertyFlags(int* flags);
}

@GUID("cb0df960-16f5-4495-9079-3f9360d831df")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nn-fsrmpipeline-ifsrmrule))], [])
interface IFsrmRule : IFsrmObject
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmrule-get_name))], [])
    HRESULT get_Name(BSTR* name);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmrule-put_name))], [])
    HRESULT put_Name(BSTR name);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmrule-get_ruletype))], [])
    HRESULT get_RuleType(FsrmRuleType* ruleType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmrule-get_moduledefinitionname))], [])
    HRESULT get_ModuleDefinitionName(BSTR* moduleDefinitionName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmrule-put_moduledefinitionname))], [])
    HRESULT put_ModuleDefinitionName(BSTR moduleDefinitionName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmrule-get_namespaceroots))], [])
    HRESULT get_NamespaceRoots(SAFEARRAY** namespaceRoots);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmrule-put_namespaceroots))], [])
    HRESULT put_NamespaceRoots(SAFEARRAY* namespaceRoots);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmrule-get_ruleflags))], [])
    HRESULT get_RuleFlags(int* ruleFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmrule-put_ruleflags))], [])
    HRESULT put_RuleFlags(int ruleFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmrule-get_parameters))], [])
    HRESULT get_Parameters(SAFEARRAY** parameters);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmrule-put_parameters))], [])
    HRESULT put_Parameters(SAFEARRAY* parameters);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmrule-get_lastmodified))], [])
    HRESULT get_LastModified(VARIANT* lastModified);
}

@GUID("afc052c2-5315-45ab-841b-c6db0e120148")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nn-fsrmpipeline-ifsrmclassificationrule))], [])
interface IFsrmClassificationRule : IFsrmRule
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmclassificationrule-get_executionoption))], [])
    HRESULT get_ExecutionOption(FsrmExecutionOption* executionOption);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmclassificationrule-put_executionoption))], [])
    HRESULT put_ExecutionOption(FsrmExecutionOption executionOption);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmclassificationrule-get_propertyaffected))], [])
    HRESULT get_PropertyAffected(BSTR* property);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmclassificationrule-put_propertyaffected))], [])
    HRESULT put_PropertyAffected(BSTR property);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmclassificationrule-get_value))], [])
    HRESULT get_Value(BSTR* value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmclassificationrule-put_value))], [])
    HRESULT put_Value(BSTR value);
}

@GUID("515c1277-2c81-440e-8fcf-367921ed4f59")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nn-fsrmpipeline-ifsrmpipelinemoduledefinition))], [])
interface IFsrmPipelineModuleDefinition : IFsrmObject
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpipelinemoduledefinition-get_moduleclsid))], [])
    HRESULT get_ModuleClsid(BSTR* moduleClsid);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpipelinemoduledefinition-put_moduleclsid))], [])
    HRESULT put_ModuleClsid(BSTR moduleClsid);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpipelinemoduledefinition-get_name))], [])
    HRESULT get_Name(BSTR* name);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpipelinemoduledefinition-put_name))], [])
    HRESULT put_Name(BSTR name);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpipelinemoduledefinition-get_company))], [])
    HRESULT get_Company(BSTR* company);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpipelinemoduledefinition-put_company))], [])
    HRESULT put_Company(BSTR company);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpipelinemoduledefinition-get_version))], [])
    HRESULT get_Version(BSTR* version_);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpipelinemoduledefinition-put_version))], [])
    HRESULT put_Version(BSTR version_);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpipelinemoduledefinition-get_moduletype))], [])
    HRESULT get_ModuleType(FsrmPipelineModuleType* moduleType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpipelinemoduledefinition-get_enabled))], [])
    HRESULT get_Enabled(VARIANT_BOOL* enabled);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpipelinemoduledefinition-put_enabled))], [])
    HRESULT put_Enabled(VARIANT_BOOL enabled);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpipelinemoduledefinition-get_needsfilecontent))], [])
    HRESULT get_NeedsFileContent(VARIANT_BOOL* needsFileContent);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpipelinemoduledefinition-put_needsfilecontent))], [])
    HRESULT put_NeedsFileContent(VARIANT_BOOL needsFileContent);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpipelinemoduledefinition-get_account))], [])
    HRESULT get_Account(FsrmAccountType* retrievalAccount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpipelinemoduledefinition-put_account))], [])
    HRESULT put_Account(FsrmAccountType retrievalAccount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpipelinemoduledefinition-get_supportedextensions))], [])
    HRESULT get_SupportedExtensions(SAFEARRAY** supportedExtensions);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpipelinemoduledefinition-put_supportedextensions))], [])
    HRESULT put_SupportedExtensions(SAFEARRAY* supportedExtensions);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpipelinemoduledefinition-get_parameters))], [])
    HRESULT get_Parameters(SAFEARRAY** parameters);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpipelinemoduledefinition-put_parameters))], [])
    HRESULT put_Parameters(SAFEARRAY* parameters);
}

@GUID("bb36ea26-6318-4b8c-8592-f72dd602e7a5")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nn-fsrmpipeline-ifsrmclassifiermoduledefinition))], [])
interface IFsrmClassifierModuleDefinition : IFsrmPipelineModuleDefinition
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmclassifiermoduledefinition-get_propertiesaffected))], [])
    HRESULT get_PropertiesAffected(SAFEARRAY** propertiesAffected);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmclassifiermoduledefinition-put_propertiesaffected))], [])
    HRESULT put_PropertiesAffected(SAFEARRAY* propertiesAffected);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmclassifiermoduledefinition-get_propertiesused))], [])
    HRESULT get_PropertiesUsed(SAFEARRAY** propertiesUsed);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmclassifiermoduledefinition-put_propertiesused))], [])
    HRESULT put_PropertiesUsed(SAFEARRAY* propertiesUsed);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmclassifiermoduledefinition-get_needsexplicitvalue))], [])
    HRESULT get_NeedsExplicitValue(VARIANT_BOOL* needsExplicitValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmclassifiermoduledefinition-put_needsexplicitvalue))], [])
    HRESULT put_NeedsExplicitValue(VARIANT_BOOL needsExplicitValue);
}

@GUID("15a81350-497d-4aba-80e9-d4dbcc5521fe")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nn-fsrmpipeline-ifsrmstoragemoduledefinition))], [])
interface IFsrmStorageModuleDefinition : IFsrmPipelineModuleDefinition
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmstoragemoduledefinition-get_capabilities))], [])
    HRESULT get_Capabilities(FsrmStorageModuleCaps* capabilities);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmstoragemoduledefinition-put_capabilities))], [])
    HRESULT put_Capabilities(FsrmStorageModuleCaps capabilities);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmstoragemoduledefinition-get_storagetype))], [])
    HRESULT get_StorageType(FsrmStorageModuleType* storageType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmstoragemoduledefinition-put_storagetype))], [])
    HRESULT put_StorageType(FsrmStorageModuleType storageType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmstoragemoduledefinition-get_updatesfilecontent))], [])
    HRESULT get_UpdatesFileContent(VARIANT_BOOL* updatesFileContent);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmstoragemoduledefinition-put_updatesfilecontent))], [])
    HRESULT put_UpdatesFileContent(VARIANT_BOOL updatesFileContent);
}

@GUID("d2dc89da-ee91-48a0-85d8-cc72a56f7d04")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nn-fsrmpipeline-ifsrmclassificationmanager))], [])
interface IFsrmClassificationManager : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmclassificationmanager-get_classificationreportformats))], [])
    HRESULT get_ClassificationReportFormats(SAFEARRAY** formats);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmclassificationmanager-put_classificationreportformats))], [])
    HRESULT put_ClassificationReportFormats(SAFEARRAY* formats);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmclassificationmanager-get_logging))], [])
    HRESULT get_Logging(int* logging);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmclassificationmanager-put_logging))], [])
    HRESULT put_Logging(int logging);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmclassificationmanager-get_classificationreportmailto))], [])
    HRESULT get_ClassificationReportMailTo(BSTR* mailTo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmclassificationmanager-put_classificationreportmailto))], [])
    HRESULT put_ClassificationReportMailTo(BSTR mailTo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmclassificationmanager-get_classificationreportenabled))], [])
    HRESULT get_ClassificationReportEnabled(VARIANT_BOOL* reportEnabled);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmclassificationmanager-put_classificationreportenabled))], [])
    HRESULT put_ClassificationReportEnabled(VARIANT_BOOL reportEnabled);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmclassificationmanager-get_classificationlastreportpathwithoutextension))], [])
    HRESULT get_ClassificationLastReportPathWithoutExtension(BSTR* lastReportPath);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmclassificationmanager-get_classificationlasterror))], [])
    HRESULT get_ClassificationLastError(BSTR* lastError);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmclassificationmanager-get_classificationrunningstatus))], [])
    HRESULT get_ClassificationRunningStatus(FsrmReportRunningStatus* runningStatus);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmclassificationmanager-enumpropertydefinitions))], [])
    HRESULT EnumPropertyDefinitions(FsrmEnumOptions options, IFsrmCollection* propertyDefinitions);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmclassificationmanager-createpropertydefinition))], [])
    HRESULT CreatePropertyDefinition(IFsrmPropertyDefinition* propertyDefinition);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmclassificationmanager-getpropertydefinition))], [])
    HRESULT GetPropertyDefinition(BSTR propertyName, IFsrmPropertyDefinition* propertyDefinition);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmclassificationmanager-enumrules))], [])
    HRESULT EnumRules(FsrmRuleType ruleType, FsrmEnumOptions options, IFsrmCollection* Rules);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmclassificationmanager-createrule))], [])
    HRESULT CreateRule(FsrmRuleType ruleType, IFsrmRule* Rule);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmclassificationmanager-getrule))], [])
    HRESULT GetRule(BSTR ruleName, FsrmRuleType ruleType, IFsrmRule* Rule);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmclassificationmanager-enummoduledefinitions))], [])
    HRESULT EnumModuleDefinitions(FsrmPipelineModuleType moduleType, FsrmEnumOptions options, 
                                  IFsrmCollection* moduleDefinitions);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmclassificationmanager-createmoduledefinition))], [])
    HRESULT CreateModuleDefinition(FsrmPipelineModuleType moduleType, 
                                   IFsrmPipelineModuleDefinition* moduleDefinition);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmclassificationmanager-getmoduledefinition))], [])
    HRESULT GetModuleDefinition(BSTR moduleName, FsrmPipelineModuleType moduleType, 
                                IFsrmPipelineModuleDefinition* moduleDefinition);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmclassificationmanager-runclassification))], [])
    HRESULT RunClassification(FsrmReportGenerationContext context, BSTR reserved);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmclassificationmanager-waitforclassificationcompletion))], [])
    HRESULT WaitForClassificationCompletion(int waitSeconds, VARIANT_BOOL* completed);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmclassificationmanager-cancelclassification))], [])
    HRESULT CancelClassification();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmclassificationmanager-enumfileproperties))], [])
    HRESULT EnumFileProperties(BSTR filePath, FsrmGetFilePropertyOptions options, IFsrmCollection* fileProperties);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmclassificationmanager-getfileproperty))], [])
    HRESULT GetFileProperty(BSTR filePath, BSTR propertyName, FsrmGetFilePropertyOptions options, 
                            IFsrmProperty* property);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmclassificationmanager-setfileproperty))], [])
    HRESULT SetFileProperty(BSTR filePath, BSTR propertyName, BSTR propertyValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmclassificationmanager-clearfileproperty))], [])
    HRESULT ClearFileProperty(BSTR filePath, BSTR property);
}

@GUID("0004c1c9-127e-4765-ba07-6a3147bca112")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nn-fsrmpipeline-ifsrmclassificationmanager2))], [])
interface IFsrmClassificationManager2 : IFsrmClassificationManager
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmclassificationmanager2-classifyfiles))], [])
    HRESULT ClassifyFiles(SAFEARRAY* filePaths, SAFEARRAY* propertyNames, SAFEARRAY* propertyValues, 
                          FsrmGetFilePropertyOptions options);
}

@GUID("774589d1-d300-4f7a-9a24-f7b766800250")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nn-fsrmpipeline-ifsrmpropertybag))], [])
interface IFsrmPropertyBag : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpropertybag-get_name))], [])
    HRESULT get_Name(BSTR* name);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpropertybag-get_relativepath))], [])
    HRESULT get_RelativePath(BSTR* path);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpropertybag-get_volumename))], [])
    HRESULT get_VolumeName(BSTR* volumeName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpropertybag-get_relativenamespaceroot))], [])
    HRESULT get_RelativeNamespaceRoot(BSTR* relativeNamespaceRoot);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpropertybag-get_volumeindex))], [])
    HRESULT get_VolumeIndex(uint* volumeId);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpropertybag-get_fileid))], [])
    HRESULT get_FileId(VARIANT* fileId);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpropertybag-get_parentdirectoryid))], [])
    HRESULT get_ParentDirectoryId(VARIANT* parentDirectoryId);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpropertybag-get_size))], [])
    HRESULT get_Size(VARIANT* size);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpropertybag-get_sizeallocated))], [])
    HRESULT get_SizeAllocated(VARIANT* sizeAllocated);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpropertybag-get_creationtime))], [])
    HRESULT get_CreationTime(VARIANT* creationTime);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpropertybag-get_lastaccesstime))], [])
    HRESULT get_LastAccessTime(VARIANT* lastAccessTime);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpropertybag-get_lastmodificationtime))], [])
    HRESULT get_LastModificationTime(VARIANT* lastModificationTime);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpropertybag-get_attributes))], [])
    HRESULT get_Attributes(uint* attributes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpropertybag-get_ownersid))], [])
    HRESULT get_OwnerSid(BSTR* ownerSid);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpropertybag-get_filepropertynames))], [])
    HRESULT get_FilePropertyNames(SAFEARRAY** filePropertyNames);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpropertybag-get_messages))], [])
    HRESULT get_Messages(SAFEARRAY** messages);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpropertybag-get_propertybagflags))], [])
    HRESULT get_PropertyBagFlags(uint* flags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpropertybag-getfileproperty))], [])
    HRESULT GetFileProperty(BSTR name, IFsrmProperty* fileProperty);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpropertybag-setfileproperty))], [])
    HRESULT SetFileProperty(BSTR name, BSTR value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpropertybag-addmessage))], [])
    HRESULT AddMessage(BSTR message);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpropertybag-getfilestreaminterface))], [])
    HRESULT GetFileStreamInterface(FsrmFileStreamingMode accessMode, FsrmFileStreamingInterfaceType interfaceType, 
                                   VARIANT* pStreamInterface);
}

@GUID("0e46bdbd-2402-4fed-9c30-9266e6eb2cc9")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nn-fsrmpipeline-ifsrmpropertybag2))], [])
interface IFsrmPropertyBag2 : IFsrmPropertyBag
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpropertybag2-getfieldvalue))], [])
    HRESULT GetFieldValue(FsrmPropertyBagField field, VARIANT* value);
    HRESULT GetUntrustedInFileProperties(IFsrmCollection* props);
}

@GUID("b7907906-2b02-4cb5-84a9-fdf54613d6cd")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nn-fsrmpipeline-ifsrmpipelinemoduleimplementation))], [])
interface IFsrmPipelineModuleImplementation : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpipelinemoduleimplementation-onload))], [])
    HRESULT OnLoad(IFsrmPipelineModuleDefinition moduleDefinition, IFsrmPipelineModuleConnector* moduleConnector);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpipelinemoduleimplementation-onunload))], [])
    HRESULT OnUnload();
}

@GUID("4c968fc6-6edb-4051-9c18-73b7291ae106")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nn-fsrmpipeline-ifsrmclassifiermoduleimplementation))], [])
interface IFsrmClassifierModuleImplementation : IFsrmPipelineModuleImplementation
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmclassifiermoduleimplementation-get_lastmodified))], [])
    HRESULT get_LastModified(VARIANT* lastModified);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmclassifiermoduleimplementation-userulesanddefinitions))], [])
    HRESULT UseRulesAndDefinitions(IFsrmCollection rules, IFsrmCollection propertyDefinitions);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmclassifiermoduleimplementation-onbeginfile))], [])
    HRESULT OnBeginFile(IFsrmPropertyBag propertyBag, SAFEARRAY* arrayRuleIds);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmclassifiermoduleimplementation-doespropertyvalueapply))], [])
    HRESULT DoesPropertyValueApply(BSTR property, BSTR value, VARIANT_BOOL* applyValue, GUID idRule, 
                                   GUID idPropDef);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmclassifiermoduleimplementation-getpropertyvaluetoapply))], [])
    HRESULT GetPropertyValueToApply(BSTR property, BSTR* value, GUID idRule, GUID idPropDef);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmclassifiermoduleimplementation-onendfile))], [])
    HRESULT OnEndFile();
}

@GUID("0af4a0da-895a-4e50-8712-a96724bcec64")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nn-fsrmpipeline-ifsrmstoragemoduleimplementation))], [])
interface IFsrmStorageModuleImplementation : IFsrmPipelineModuleImplementation
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmstoragemoduleimplementation-usedefinitions))], [])
    HRESULT UseDefinitions(IFsrmCollection propertyDefinitions);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmstoragemoduleimplementation-loadproperties))], [])
    HRESULT LoadProperties(IFsrmPropertyBag propertyBag);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmstoragemoduleimplementation-saveproperties))], [])
    HRESULT SaveProperties(IFsrmPropertyBag propertyBag);
}

@GUID("c16014f3-9aa1-46b3-b0a7-ab146eb205f2")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nn-fsrmpipeline-ifsrmpipelinemoduleconnector))], [])
interface IFsrmPipelineModuleConnector : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpipelinemoduleconnector-get_moduleimplementation))], [])
    HRESULT get_ModuleImplementation(IFsrmPipelineModuleImplementation* pipelineModuleImplementation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpipelinemoduleconnector-get_modulename))], [])
    HRESULT get_ModuleName(BSTR* userName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpipelinemoduleconnector-get_hostinguseraccount))], [])
    HRESULT get_HostingUserAccount(BSTR* userAccount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpipelinemoduleconnector-get_hostingprocesspid))], [])
    HRESULT get_HostingProcessPid(int* pid);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmpipeline/nf-fsrmpipeline-ifsrmpipelinemoduleconnector-bind))], [])
    HRESULT Bind(IFsrmPipelineModuleDefinition moduleDefinition, 
                 IFsrmPipelineModuleImplementation moduleImplementation);
}

@GUID("26942db0-dabf-41d8-bbdd-b129a9f70424")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fsrmtlb/nn-fsrmtlb-difsrmclassificationevents))], [])
interface DIFsrmClassificationEvents : IDispatch
{
}


// GUIDs

const GUID CLSID_AdSyncTask                        = GUIDOF!AdSyncTask;
const GUID CLSID_FsrmAccessDeniedRemediationClient = GUIDOF!FsrmAccessDeniedRemediationClient;
const GUID CLSID_FsrmClassificationManager         = GUIDOF!FsrmClassificationManager;
const GUID CLSID_FsrmExportImport                  = GUIDOF!FsrmExportImport;
const GUID CLSID_FsrmFileGroupManager              = GUIDOF!FsrmFileGroupManager;
const GUID CLSID_FsrmFileManagementJobManager      = GUIDOF!FsrmFileManagementJobManager;
const GUID CLSID_FsrmFileScreenManager             = GUIDOF!FsrmFileScreenManager;
const GUID CLSID_FsrmFileScreenTemplateManager     = GUIDOF!FsrmFileScreenTemplateManager;
const GUID CLSID_FsrmPathMapper                    = GUIDOF!FsrmPathMapper;
const GUID CLSID_FsrmPipelineModuleConnector       = GUIDOF!FsrmPipelineModuleConnector;
const GUID CLSID_FsrmQuotaManager                  = GUIDOF!FsrmQuotaManager;
const GUID CLSID_FsrmQuotaTemplateManager          = GUIDOF!FsrmQuotaTemplateManager;
const GUID CLSID_FsrmReportManager                 = GUIDOF!FsrmReportManager;
const GUID CLSID_FsrmReportScheduler               = GUIDOF!FsrmReportScheduler;
const GUID CLSID_FsrmSetting                       = GUIDOF!FsrmSetting;

const GUID IID_DIFsrmClassificationEvents          = GUIDOF!DIFsrmClassificationEvents;
const GUID IID_IFsrmAccessDeniedRemediationClient  = GUIDOF!IFsrmAccessDeniedRemediationClient;
const GUID IID_IFsrmAction                         = GUIDOF!IFsrmAction;
const GUID IID_IFsrmActionCommand                  = GUIDOF!IFsrmActionCommand;
const GUID IID_IFsrmActionEmail                    = GUIDOF!IFsrmActionEmail;
const GUID IID_IFsrmActionEmail2                   = GUIDOF!IFsrmActionEmail2;
const GUID IID_IFsrmActionEventLog                 = GUIDOF!IFsrmActionEventLog;
const GUID IID_IFsrmActionReport                   = GUIDOF!IFsrmActionReport;
const GUID IID_IFsrmAutoApplyQuota                 = GUIDOF!IFsrmAutoApplyQuota;
const GUID IID_IFsrmClassificationManager          = GUIDOF!IFsrmClassificationManager;
const GUID IID_IFsrmClassificationManager2         = GUIDOF!IFsrmClassificationManager2;
const GUID IID_IFsrmClassificationRule             = GUIDOF!IFsrmClassificationRule;
const GUID IID_IFsrmClassifierModuleDefinition     = GUIDOF!IFsrmClassifierModuleDefinition;
const GUID IID_IFsrmClassifierModuleImplementation = GUIDOF!IFsrmClassifierModuleImplementation;
const GUID IID_IFsrmCollection                     = GUIDOF!IFsrmCollection;
const GUID IID_IFsrmCommittableCollection          = GUIDOF!IFsrmCommittableCollection;
const GUID IID_IFsrmDerivedObjectsResult           = GUIDOF!IFsrmDerivedObjectsResult;
const GUID IID_IFsrmExportImport                   = GUIDOF!IFsrmExportImport;
const GUID IID_IFsrmFileCondition                  = GUIDOF!IFsrmFileCondition;
const GUID IID_IFsrmFileConditionProperty          = GUIDOF!IFsrmFileConditionProperty;
const GUID IID_IFsrmFileGroup                      = GUIDOF!IFsrmFileGroup;
const GUID IID_IFsrmFileGroupImported              = GUIDOF!IFsrmFileGroupImported;
const GUID IID_IFsrmFileGroupManager               = GUIDOF!IFsrmFileGroupManager;
const GUID IID_IFsrmFileManagementJob              = GUIDOF!IFsrmFileManagementJob;
const GUID IID_IFsrmFileManagementJobManager       = GUIDOF!IFsrmFileManagementJobManager;
const GUID IID_IFsrmFileScreen                     = GUIDOF!IFsrmFileScreen;
const GUID IID_IFsrmFileScreenBase                 = GUIDOF!IFsrmFileScreenBase;
const GUID IID_IFsrmFileScreenException            = GUIDOF!IFsrmFileScreenException;
const GUID IID_IFsrmFileScreenManager              = GUIDOF!IFsrmFileScreenManager;
const GUID IID_IFsrmFileScreenTemplate             = GUIDOF!IFsrmFileScreenTemplate;
const GUID IID_IFsrmFileScreenTemplateImported     = GUIDOF!IFsrmFileScreenTemplateImported;
const GUID IID_IFsrmFileScreenTemplateManager      = GUIDOF!IFsrmFileScreenTemplateManager;
const GUID IID_IFsrmMutableCollection              = GUIDOF!IFsrmMutableCollection;
const GUID IID_IFsrmObject                         = GUIDOF!IFsrmObject;
const GUID IID_IFsrmPathMapper                     = GUIDOF!IFsrmPathMapper;
const GUID IID_IFsrmPipelineModuleConnector        = GUIDOF!IFsrmPipelineModuleConnector;
const GUID IID_IFsrmPipelineModuleDefinition       = GUIDOF!IFsrmPipelineModuleDefinition;
const GUID IID_IFsrmPipelineModuleImplementation   = GUIDOF!IFsrmPipelineModuleImplementation;
const GUID IID_IFsrmProperty                       = GUIDOF!IFsrmProperty;
const GUID IID_IFsrmPropertyBag                    = GUIDOF!IFsrmPropertyBag;
const GUID IID_IFsrmPropertyBag2                   = GUIDOF!IFsrmPropertyBag2;
const GUID IID_IFsrmPropertyCondition              = GUIDOF!IFsrmPropertyCondition;
const GUID IID_IFsrmPropertyDefinition             = GUIDOF!IFsrmPropertyDefinition;
const GUID IID_IFsrmPropertyDefinition2            = GUIDOF!IFsrmPropertyDefinition2;
const GUID IID_IFsrmPropertyDefinitionValue        = GUIDOF!IFsrmPropertyDefinitionValue;
const GUID IID_IFsrmQuota                          = GUIDOF!IFsrmQuota;
const GUID IID_IFsrmQuotaBase                      = GUIDOF!IFsrmQuotaBase;
const GUID IID_IFsrmQuotaManager                   = GUIDOF!IFsrmQuotaManager;
const GUID IID_IFsrmQuotaManagerEx                 = GUIDOF!IFsrmQuotaManagerEx;
const GUID IID_IFsrmQuotaObject                    = GUIDOF!IFsrmQuotaObject;
const GUID IID_IFsrmQuotaTemplate                  = GUIDOF!IFsrmQuotaTemplate;
const GUID IID_IFsrmQuotaTemplateImported          = GUIDOF!IFsrmQuotaTemplateImported;
const GUID IID_IFsrmQuotaTemplateManager           = GUIDOF!IFsrmQuotaTemplateManager;
const GUID IID_IFsrmReport                         = GUIDOF!IFsrmReport;
const GUID IID_IFsrmReportJob                      = GUIDOF!IFsrmReportJob;
const GUID IID_IFsrmReportManager                  = GUIDOF!IFsrmReportManager;
const GUID IID_IFsrmReportScheduler                = GUIDOF!IFsrmReportScheduler;
const GUID IID_IFsrmRule                           = GUIDOF!IFsrmRule;
const GUID IID_IFsrmSetting                        = GUIDOF!IFsrmSetting;
const GUID IID_IFsrmStorageModuleDefinition        = GUIDOF!IFsrmStorageModuleDefinition;
const GUID IID_IFsrmStorageModuleImplementation    = GUIDOF!IFsrmStorageModuleImplementation;
