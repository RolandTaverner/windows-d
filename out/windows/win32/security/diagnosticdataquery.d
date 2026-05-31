// Written in the D programming language.

module windows.win32.security.diagnosticdataquery;

public import windows.core;
public import system : Guid;
public import windows.win32.foundation : BOOL, FILETIME, HRESULT, PWSTR;

extern(Windows) @nogc nothrow:


// Enums

//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/diagnosticdataquerytypes/ne-diagnosticdataquerytypes-ddqaccesslevel))], [])
enum DdqAccessLevel : int
{
    NoData          = 0x00000000,
    CurrentUserData = 0x00000001,
    AllUserData     = 0x00000002,
}

// Structs


@RAIIFree!DdqCloseSession
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HDIAGNOSTIC_DATA_QUERY_SESSION
{
    void* Value;
}

@RAIIFree!DdqFreeDiagnosticReport
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HDIAGNOSTIC_REPORT
{
    void* Value;
}

@RAIIFree!DdqFreeDiagnosticRecordLocaleTags
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HDIAGNOSTIC_EVENT_TAG_DESCRIPTION
{
    void* Value;
}

@RAIIFree!DdqFreeDiagnosticRecordProducers
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HDIAGNOSTIC_EVENT_PRODUCER_DESCRIPTION
{
    void* Value;
}

@RAIIFree!DdqFreeDiagnosticRecordProducerCategories
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HDIAGNOSTIC_EVENT_CATEGORY_DESCRIPTION
{
    void* Value;
}

@RAIIFree!DdqFreeDiagnosticRecordPage
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HDIAGNOSTIC_RECORD
{
    void* Value;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/diagnosticdataquerytypes/ns-diagnosticdataquerytypes-diagnostic_data_record))], [])
struct DIAGNOSTIC_DATA_RECORD
{
    long  rowId;
    ulong timestamp;
    ulong eventKeywords;
    PWSTR fullEventName;
    PWSTR providerGroupGuid;
    PWSTR producerName;
    int*  privacyTags;
    uint  privacyTagCount;
    int*  categoryIds;
    uint  categoryIdCount;
    BOOL  isCoreData;
    PWSTR extra1;
    PWSTR extra2;
    PWSTR extra3;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/diagnosticdataquerytypes/ns-diagnosticdataquerytypes-diagnostic_data_search_criteria))], [])
struct DIAGNOSTIC_DATA_SEARCH_CRITERIA
{
    const(PWSTR)* producerNames;
    uint          producerNameCount;
    const(PWSTR)  textToMatch;
    const(int)*   categoryIds;
    uint          categoryIdCount;
    const(int)*   privacyTags;
    uint          privacyTagCount;
    BOOL          coreDataOnly;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/diagnosticdataquerytypes/ns-diagnosticdataquerytypes-diagnostic_data_event_tag_description))], [])
struct DIAGNOSTIC_DATA_EVENT_TAG_DESCRIPTION
{
    int   privacyTag;
    PWSTR name;
    PWSTR description;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/diagnosticdataquerytypes/ns-diagnosticdataquerytypes-diagnostic_data_event_producer_description))], [])
struct DIAGNOSTIC_DATA_EVENT_PRODUCER_DESCRIPTION
{
    PWSTR name;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/diagnosticdataquerytypes/ns-diagnosticdataquerytypes-diagnostic_data_event_category_description))], [])
struct DIAGNOSTIC_DATA_EVENT_CATEGORY_DESCRIPTION
{
    int   id;
    PWSTR name;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/diagnosticdataquerytypes/ns-diagnosticdataquerytypes-diagnostic_data_event_tag_stats))], [])
struct DIAGNOSTIC_DATA_EVENT_TAG_STATS
{
    int  privacyTag;
    uint eventCount;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/diagnosticdataquerytypes/ns-diagnosticdataquerytypes-diagnostic_data_event_binary_stats))], [])
struct DIAGNOSTIC_DATA_EVENT_BINARY_STATS
{
    PWSTR moduleName;
    PWSTR friendlyModuleName;
    uint  eventCount;
    ulong uploadSizeBytes;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/diagnosticdataquerytypes/ns-diagnosticdataquerytypes-diagnostic_data_general_stats))], [])
struct DIAGNOSTIC_DATA_GENERAL_STATS
{
    uint  optInLevel;
    ulong transcriptSizeBytes;
    ulong oldestEventTimestamp;
    uint  totalEventCountLast24Hours;
    float averageDailyEvents;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/diagnosticdataquerytypes/ns-diagnosticdataquerytypes-diagnostic_data_event_transcript_configuration))], [])
struct DIAGNOSTIC_DATA_EVENT_TRANSCRIPT_CONFIGURATION
{
    uint hoursOfHistoryToKeep;
    uint maxStoreMegabytes;
    uint requestedMaxStoreMegabytes;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/diagnosticdataquerytypes/ns-diagnosticdataquerytypes-diagnostic_report_parameter))], [])
struct DIAGNOSTIC_REPORT_PARAMETER
{
    wchar[129] name;
    wchar[260] value;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/diagnosticdataquerytypes/ns-diagnosticdataquerytypes-diagnostic_report_signature))], [])
struct DIAGNOSTIC_REPORT_SIGNATURE
{
    wchar[65] eventName;
    DIAGNOSTIC_REPORT_PARAMETER[10] parameters;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/diagnosticdataquerytypes/ns-diagnosticdataquerytypes-diagnostic_report_data))], [])
struct DIAGNOSTIC_REPORT_DATA
{
    DIAGNOSTIC_REPORT_SIGNATURE signature;
    GUID     bucketId;
    GUID     reportId;
    FILETIME creationTime;
    ulong    sizeInBytes;
    PWSTR    cabId;
    uint     reportStatus;
    GUID     reportIntegratorId;
    PWSTR*   fileNames;
    uint     fileCount;
    PWSTR    friendlyEventName;
    PWSTR    applicationName;
    PWSTR    applicationPath;
    PWSTR    description;
    PWSTR    bucketIdString;
    ulong    legacyBucketId;
    PWSTR    reportKey;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.19041))], [])
@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqCreateSession(DdqAccessLevel accessLevel, HDIAGNOSTIC_DATA_QUERY_SESSION* hSession);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.19041))], [])
@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqCloseSession(HDIAGNOSTIC_DATA_QUERY_SESSION hSession);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.19041))], [])
@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqGetSessionAccessLevel(HDIAGNOSTIC_DATA_QUERY_SESSION hSession, DdqAccessLevel* accessLevel);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.19041))], [])
@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqGetDiagnosticDataAccessLevelAllowed(DdqAccessLevel* accessLevel);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.19041))], [])
@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqGetDiagnosticRecordStats(HDIAGNOSTIC_DATA_QUERY_SESSION hSession, 
                                    const(DIAGNOSTIC_DATA_SEARCH_CRITERIA)* searchCriteria, uint* recordCount, 
                                    long* minRowId, long* maxRowId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.19041))], [])
@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqGetDiagnosticRecordPayload(HDIAGNOSTIC_DATA_QUERY_SESSION hSession, long rowId, const(PWSTR)* payload);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.19041))], [])
@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqGetDiagnosticRecordLocaleTags(HDIAGNOSTIC_DATA_QUERY_SESSION hSession, const(PWSTR) locale, 
                                         HDIAGNOSTIC_EVENT_TAG_DESCRIPTION* hTagDescription);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.19041))], [])
@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqFreeDiagnosticRecordLocaleTags(HDIAGNOSTIC_EVENT_TAG_DESCRIPTION hTagDescription);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.19041))], [])
@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqGetDiagnosticRecordLocaleTagAtIndex(HDIAGNOSTIC_EVENT_TAG_DESCRIPTION hTagDescription, uint index, 
                                               DIAGNOSTIC_DATA_EVENT_TAG_DESCRIPTION* tagDescription);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.19041))], [])
@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqGetDiagnosticRecordLocaleTagCount(HDIAGNOSTIC_EVENT_TAG_DESCRIPTION hTagDescription, 
                                             uint* tagDescriptionCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.19041))], [])
@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqGetDiagnosticRecordProducers(HDIAGNOSTIC_DATA_QUERY_SESSION hSession, 
                                        HDIAGNOSTIC_EVENT_PRODUCER_DESCRIPTION* hProducerDescription);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.19041))], [])
@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqFreeDiagnosticRecordProducers(HDIAGNOSTIC_EVENT_PRODUCER_DESCRIPTION hProducerDescription);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.19041))], [])
@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqGetDiagnosticRecordProducerAtIndex(HDIAGNOSTIC_EVENT_PRODUCER_DESCRIPTION hProducerDescription, 
                                              uint index, 
                                              DIAGNOSTIC_DATA_EVENT_PRODUCER_DESCRIPTION* producerDescription);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.19041))], [])
@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqGetDiagnosticRecordProducerCount(HDIAGNOSTIC_EVENT_PRODUCER_DESCRIPTION hProducerDescription, 
                                            uint* producerDescriptionCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.19041))], [])
@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqGetDiagnosticRecordProducerCategories(HDIAGNOSTIC_DATA_QUERY_SESSION hSession, 
                                                 const(PWSTR) producerName, 
                                                 HDIAGNOSTIC_EVENT_CATEGORY_DESCRIPTION* hCategoryDescription);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.19041))], [])
@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqFreeDiagnosticRecordProducerCategories(HDIAGNOSTIC_EVENT_CATEGORY_DESCRIPTION hCategoryDescription);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.19041))], [])
@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqGetDiagnosticRecordCategoryAtIndex(HDIAGNOSTIC_EVENT_CATEGORY_DESCRIPTION hCategoryDescription, 
                                              uint index, 
                                              DIAGNOSTIC_DATA_EVENT_CATEGORY_DESCRIPTION* categoryDescription);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.19041))], [])
@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqGetDiagnosticRecordCategoryCount(HDIAGNOSTIC_EVENT_CATEGORY_DESCRIPTION hCategoryDescription, 
                                            uint* categoryDescriptionCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.19041))], [])
@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqIsDiagnosticRecordSampledIn(HDIAGNOSTIC_DATA_QUERY_SESSION hSession, const(GUID)* providerGroup, 
                                       const(GUID)* providerId, const(PWSTR) providerName, const(uint)* eventId, 
                                       const(PWSTR) eventName, const(uint)* eventVersion, 
                                       const(ulong)* eventKeywords, BOOL* isSampledIn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.19041))], [])
@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqGetDiagnosticRecordPage(HDIAGNOSTIC_DATA_QUERY_SESSION hSession, 
                                   DIAGNOSTIC_DATA_SEARCH_CRITERIA* searchCriteria, uint offset, 
                                   uint pageRecordCount, long baseRowId, HDIAGNOSTIC_RECORD* hRecord);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.19041))], [])
@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqFreeDiagnosticRecordPage(HDIAGNOSTIC_RECORD hRecord);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.19041))], [])
@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqGetDiagnosticRecordAtIndex(HDIAGNOSTIC_RECORD hRecord, uint index, DIAGNOSTIC_DATA_RECORD* record);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.19041))], [])
@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqGetDiagnosticRecordCount(HDIAGNOSTIC_RECORD hRecord, uint* recordCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.19041))], [])
@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqGetDiagnosticReportStoreReportCount(HDIAGNOSTIC_DATA_QUERY_SESSION hSession, uint reportStoreType, 
                                               uint* reportCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.19041))], [])
@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqCancelDiagnosticRecordOperation(HDIAGNOSTIC_DATA_QUERY_SESSION hSession);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.19041))], [])
@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqGetDiagnosticReport(HDIAGNOSTIC_DATA_QUERY_SESSION hSession, uint reportStoreType, 
                               HDIAGNOSTIC_REPORT* hReport);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.19041))], [])
@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqFreeDiagnosticReport(HDIAGNOSTIC_REPORT hReport);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.19041))], [])
@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqGetDiagnosticReportAtIndex(HDIAGNOSTIC_REPORT hReport, uint index, DIAGNOSTIC_REPORT_DATA* report);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.19041))], [])
@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqGetDiagnosticReportCount(HDIAGNOSTIC_REPORT hReport, uint* reportCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.19041))], [])
@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqExtractDiagnosticReport(HDIAGNOSTIC_DATA_QUERY_SESSION hSession, uint reportStoreType, 
                                   const(PWSTR) reportKey, const(PWSTR) destinationPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.19041))], [])
@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqGetDiagnosticRecordTagDistribution(HDIAGNOSTIC_DATA_QUERY_SESSION hSession, const(PWSTR)* producerNames, 
                                              uint producerNameCount, DIAGNOSTIC_DATA_EVENT_TAG_STATS** tagStats, 
                                              uint* statCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.19041))], [])
@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqGetDiagnosticRecordBinaryDistribution(HDIAGNOSTIC_DATA_QUERY_SESSION hSession, 
                                                 const(PWSTR)* producerNames, uint producerNameCount, 
                                                 uint topNBinaries, DIAGNOSTIC_DATA_EVENT_BINARY_STATS** binaryStats, 
                                                 uint* statCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.19041))], [])
@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqGetDiagnosticRecordSummary(HDIAGNOSTIC_DATA_QUERY_SESSION hSession, const(PWSTR)* producerNames, 
                                      uint producerNameCount, DIAGNOSTIC_DATA_GENERAL_STATS* generalStats);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.19041))], [])
@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqSetTranscriptConfiguration(HDIAGNOSTIC_DATA_QUERY_SESSION hSession, 
                                      const(DIAGNOSTIC_DATA_EVENT_TRANSCRIPT_CONFIGURATION)* desiredConfig);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.19041))], [])
@DllImport("DiagnosticDataQuery.dll")
HRESULT DdqGetTranscriptConfiguration(HDIAGNOSTIC_DATA_QUERY_SESSION hSession, 
                                      DIAGNOSTIC_DATA_EVENT_TRANSCRIPT_CONFIGURATION* currentConfig);


