// Written in the D programming language.

module windows.win32.system.eventlog;

public import windows.core;
public import windows.win32.foundation.foundation : BOOL, FILETIME, HANDLE, PSTR, PWSTR,
                                                    SYSTEMTIME;
public import windows.win32.security.security : PSID;

extern(Windows) @nogc nothrow:


// Enums


alias REPORT_EVENT_TYPE = ushort;
enum : ushort
{
    EVENTLOG_SUCCESS          = cast(ushort) 0x0000,
    EVENTLOG_AUDIT_FAILURE    = cast(ushort) 0x0010,
    EVENTLOG_AUDIT_SUCCESS    = cast(ushort) 0x0008,
    EVENTLOG_ERROR_TYPE       = cast(ushort) 0x0001,
    EVENTLOG_INFORMATION_TYPE = cast(ushort) 0x0004,
    EVENTLOG_WARNING_TYPE     = cast(ushort) 0x0002,
}

alias READ_EVENT_LOG_READ_FLAGS = uint;
enum : uint
{
    EVENTLOG_SEEK_READ       = 0x00000002U,
    EVENTLOG_SEQUENTIAL_READ = 0x00000001U,
    EVENTLOG_FORWARDS_READ   = 0x00000004U,
    EVENTLOG_BACKWARDS_READ  = 0x00000008U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winevt/ne-winevt-evt_variant_type
alias EVT_VARIANT_TYPE = int;
enum : int
{
    EvtVarTypeNull       = 0x00000000,
    EvtVarTypeString     = 0x00000001,
    EvtVarTypeAnsiString = 0x00000002,
    EvtVarTypeSByte      = 0x00000003,
    EvtVarTypeByte       = 0x00000004,
    EvtVarTypeInt16      = 0x00000005,
    EvtVarTypeUInt16     = 0x00000006,
    EvtVarTypeInt32      = 0x00000007,
    EvtVarTypeUInt32     = 0x00000008,
    EvtVarTypeInt64      = 0x00000009,
    EvtVarTypeUInt64     = 0x0000000a,
    EvtVarTypeSingle     = 0x0000000b,
    EvtVarTypeDouble     = 0x0000000c,
    EvtVarTypeBoolean    = 0x0000000d,
    EvtVarTypeBinary     = 0x0000000e,
    EvtVarTypeGuid       = 0x0000000f,
    EvtVarTypeSizeT      = 0x00000010,
    EvtVarTypeFileTime   = 0x00000011,
    EvtVarTypeSysTime    = 0x00000012,
    EvtVarTypeSid        = 0x00000013,
    EvtVarTypeHexInt32   = 0x00000014,
    EvtVarTypeHexInt64   = 0x00000015,
    EvtVarTypeEvtHandle  = 0x00000020,
    EvtVarTypeEvtXml     = 0x00000023,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winevt/ne-winevt-evt_login_class
alias EVT_LOGIN_CLASS = int;
enum : int
{
    EvtRpcLogin = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winevt/ne-winevt-evt_rpc_login_flags
alias EVT_RPC_LOGIN_FLAGS = uint;
enum : uint
{
    EvtRpcLoginAuthDefault   = 0x00000000U,
    EvtRpcLoginAuthNegotiate = 0x00000001U,
    EvtRpcLoginAuthKerberos  = 0x00000002U,
    EvtRpcLoginAuthNTLM      = 0x00000003U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winevt/ne-winevt-evt_query_flags
alias EVT_QUERY_FLAGS = uint;
enum : uint
{
    EvtQueryChannelPath         = 0x00000001U,
    EvtQueryFilePath            = 0x00000002U,
    EvtQueryForwardDirection    = 0x00000100U,
    EvtQueryReverseDirection    = 0x00000200U,
    EvtQueryTolerateQueryErrors = 0x00001000U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winevt/ne-winevt-evt_seek_flags
alias EVT_SEEK_FLAGS = uint;
enum : uint
{
    EvtSeekRelativeToFirst    = 0x00000001U,
    EvtSeekRelativeToLast     = 0x00000002U,
    EvtSeekRelativeToCurrent  = 0x00000003U,
    EvtSeekRelativeToBookmark = 0x00000004U,
    EvtSeekOriginMask         = 0x00000007U,
    EvtSeekStrict             = 0x00010000U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winevt/ne-winevt-evt_subscribe_flags
alias EVT_SUBSCRIBE_FLAGS = uint;
enum : uint
{
    EvtSubscribeToFutureEvents      = 0x00000001U,
    EvtSubscribeStartAtOldestRecord = 0x00000002U,
    EvtSubscribeStartAfterBookmark  = 0x00000003U,
    EvtSubscribeOriginMask          = 0x00000003U,
    EvtSubscribeTolerateQueryErrors = 0x00001000U,
    EvtSubscribeStrict              = 0x00010000U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winevt/ne-winevt-evt_subscribe_notify_action
alias EVT_SUBSCRIBE_NOTIFY_ACTION = int;
enum : int
{
    EvtSubscribeActionError   = 0x00000000,
    EvtSubscribeActionDeliver = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winevt/ne-winevt-evt_system_property_id
alias EVT_SYSTEM_PROPERTY_ID = int;
enum : int
{
    EvtSystemProviderName      = 0x00000000,
    EvtSystemProviderGuid      = 0x00000001,
    EvtSystemEventID           = 0x00000002,
    EvtSystemQualifiers        = 0x00000003,
    EvtSystemLevel             = 0x00000004,
    EvtSystemTask              = 0x00000005,
    EvtSystemOpcode            = 0x00000006,
    EvtSystemKeywords          = 0x00000007,
    EvtSystemTimeCreated       = 0x00000008,
    EvtSystemEventRecordId     = 0x00000009,
    EvtSystemActivityID        = 0x0000000a,
    EvtSystemRelatedActivityID = 0x0000000b,
    EvtSystemProcessID         = 0x0000000c,
    EvtSystemThreadID          = 0x0000000d,
    EvtSystemChannel           = 0x0000000e,
    EvtSystemComputer          = 0x0000000f,
    EvtSystemUserID            = 0x00000010,
    EvtSystemVersion           = 0x00000011,
    EvtSystemPropertyIdEND     = 0x00000012,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winevt/ne-winevt-evt_render_context_flags
alias EVT_RENDER_CONTEXT_FLAGS = uint;
enum : uint
{
    EvtRenderContextValues = 0x00000000U,
    EvtRenderContextSystem = 0x00000001U,
    EvtRenderContextUser   = 0x00000002U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winevt/ne-winevt-evt_render_flags
alias EVT_RENDER_FLAGS = uint;
enum : uint
{
    EvtRenderEventValues = 0x00000000U,
    EvtRenderEventXml    = 0x00000001U,
    EvtRenderBookmark    = 0x00000002U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winevt/ne-winevt-evt_format_message_flags
alias EVT_FORMAT_MESSAGE_FLAGS = uint;
enum : uint
{
    EvtFormatMessageEvent    = 0x00000001U,
    EvtFormatMessageLevel    = 0x00000002U,
    EvtFormatMessageTask     = 0x00000003U,
    EvtFormatMessageOpcode   = 0x00000004U,
    EvtFormatMessageKeyword  = 0x00000005U,
    EvtFormatMessageChannel  = 0x00000006U,
    EvtFormatMessageProvider = 0x00000007U,
    EvtFormatMessageId       = 0x00000008U,
    EvtFormatMessageXml      = 0x00000009U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winevt/ne-winevt-evt_open_log_flags
alias EVT_OPEN_LOG_FLAGS = uint;
enum : uint
{
    EvtOpenChannelPath = 0x00000001U,
    EvtOpenFilePath    = 0x00000002U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winevt/ne-winevt-evt_log_property_id
alias EVT_LOG_PROPERTY_ID = int;
enum : int
{
    EvtLogCreationTime       = 0x00000000,
    EvtLogLastAccessTime     = 0x00000001,
    EvtLogLastWriteTime      = 0x00000002,
    EvtLogFileSize           = 0x00000003,
    EvtLogAttributes         = 0x00000004,
    EvtLogNumberOfLogRecords = 0x00000005,
    EvtLogOldestRecordNumber = 0x00000006,
    EvtLogFull               = 0x00000007,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winevt/ne-winevt-evt_exportlog_flags
alias EVT_EXPORTLOG_FLAGS = uint;
enum : uint
{
    EvtExportLogChannelPath         = 0x00000001U,
    EvtExportLogFilePath            = 0x00000002U,
    EvtExportLogTolerateQueryErrors = 0x00001000U,
    EvtExportLogOverwrite           = 0x00002000U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winevt/ne-winevt-evt_channel_config_property_id
alias EVT_CHANNEL_CONFIG_PROPERTY_ID = int;
enum : int
{
    EvtChannelConfigEnabled               = 0x00000000,
    EvtChannelConfigIsolation             = 0x00000001,
    EvtChannelConfigType                  = 0x00000002,
    EvtChannelConfigOwningPublisher       = 0x00000003,
    EvtChannelConfigClassicEventlog       = 0x00000004,
    EvtChannelConfigAccess                = 0x00000005,
    EvtChannelLoggingConfigRetention      = 0x00000006,
    EvtChannelLoggingConfigAutoBackup     = 0x00000007,
    EvtChannelLoggingConfigMaxSize        = 0x00000008,
    EvtChannelLoggingConfigLogFilePath    = 0x00000009,
    EvtChannelPublishingConfigLevel       = 0x0000000a,
    EvtChannelPublishingConfigKeywords    = 0x0000000b,
    EvtChannelPublishingConfigControlGuid = 0x0000000c,
    EvtChannelPublishingConfigBufferSize  = 0x0000000d,
    EvtChannelPublishingConfigMinBuffers  = 0x0000000e,
    EvtChannelPublishingConfigMaxBuffers  = 0x0000000f,
    EvtChannelPublishingConfigLatency     = 0x00000010,
    EvtChannelPublishingConfigClockType   = 0x00000011,
    EvtChannelPublishingConfigSidType     = 0x00000012,
    EvtChannelPublisherList               = 0x00000013,
    EvtChannelPublishingConfigFileMax     = 0x00000014,
    EvtChannelConfigPropertyIdEND         = 0x00000015,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winevt/ne-winevt-evt_channel_type
alias EVT_CHANNEL_TYPE = int;
enum : int
{
    EvtChannelTypeAdmin       = 0x00000000,
    EvtChannelTypeOperational = 0x00000001,
    EvtChannelTypeAnalytic    = 0x00000002,
    EvtChannelTypeDebug       = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winevt/ne-winevt-evt_channel_isolation_type
alias EVT_CHANNEL_ISOLATION_TYPE = int;
enum : int
{
    EvtChannelIsolationTypeApplication = 0x00000000,
    EvtChannelIsolationTypeSystem      = 0x00000001,
    EvtChannelIsolationTypeCustom      = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winevt/ne-winevt-evt_channel_clock_type
alias EVT_CHANNEL_CLOCK_TYPE = int;
enum : int
{
    EvtChannelClockTypeSystemTime = 0x00000000,
    EvtChannelClockTypeQPC        = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winevt/ne-winevt-evt_channel_sid_type
alias EVT_CHANNEL_SID_TYPE = int;
enum : int
{
    EvtChannelSidTypeNone       = 0x00000000,
    EvtChannelSidTypePublishing = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winevt/ne-winevt-evt_channel_reference_flags
alias EVT_CHANNEL_REFERENCE_FLAGS = uint;
enum : uint
{
    EvtChannelReferenceImported = 0x00000001U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winevt/ne-winevt-evt_publisher_metadata_property_id
alias EVT_PUBLISHER_METADATA_PROPERTY_ID = int;
enum : int
{
    EvtPublisherMetadataPublisherGuid             = 0x00000000,
    EvtPublisherMetadataResourceFilePath          = 0x00000001,
    EvtPublisherMetadataParameterFilePath         = 0x00000002,
    EvtPublisherMetadataMessageFilePath           = 0x00000003,
    EvtPublisherMetadataHelpLink                  = 0x00000004,
    EvtPublisherMetadataPublisherMessageID        = 0x00000005,
    EvtPublisherMetadataChannelReferences         = 0x00000006,
    EvtPublisherMetadataChannelReferencePath      = 0x00000007,
    EvtPublisherMetadataChannelReferenceIndex     = 0x00000008,
    EvtPublisherMetadataChannelReferenceID        = 0x00000009,
    EvtPublisherMetadataChannelReferenceFlags     = 0x0000000a,
    EvtPublisherMetadataChannelReferenceMessageID = 0x0000000b,
    EvtPublisherMetadataLevels                    = 0x0000000c,
    EvtPublisherMetadataLevelName                 = 0x0000000d,
    EvtPublisherMetadataLevelValue                = 0x0000000e,
    EvtPublisherMetadataLevelMessageID            = 0x0000000f,
    EvtPublisherMetadataTasks                     = 0x00000010,
    EvtPublisherMetadataTaskName                  = 0x00000011,
    EvtPublisherMetadataTaskEventGuid             = 0x00000012,
    EvtPublisherMetadataTaskValue                 = 0x00000013,
    EvtPublisherMetadataTaskMessageID             = 0x00000014,
    EvtPublisherMetadataOpcodes                   = 0x00000015,
    EvtPublisherMetadataOpcodeName                = 0x00000016,
    EvtPublisherMetadataOpcodeValue               = 0x00000017,
    EvtPublisherMetadataOpcodeMessageID           = 0x00000018,
    EvtPublisherMetadataKeywords                  = 0x00000019,
    EvtPublisherMetadataKeywordName               = 0x0000001a,
    EvtPublisherMetadataKeywordValue              = 0x0000001b,
    EvtPublisherMetadataKeywordMessageID          = 0x0000001c,
    EvtPublisherMetadataPropertyIdEND             = 0x0000001d,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winevt/ne-winevt-evt_event_metadata_property_id
alias EVT_EVENT_METADATA_PROPERTY_ID = int;
enum : int
{
    EventMetadataEventID          = 0x00000000,
    EventMetadataEventVersion     = 0x00000001,
    EventMetadataEventChannel     = 0x00000002,
    EventMetadataEventLevel       = 0x00000003,
    EventMetadataEventOpcode      = 0x00000004,
    EventMetadataEventTask        = 0x00000005,
    EventMetadataEventKeyword     = 0x00000006,
    EventMetadataEventMessageID   = 0x00000007,
    EventMetadataEventTemplate    = 0x00000008,
    EvtEventMetadataPropertyIdEND = 0x00000009,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winevt/ne-winevt-evt_query_property_id
alias EVT_QUERY_PROPERTY_ID = int;
enum : int
{
    EvtQueryNames         = 0x00000000,
    EvtQueryStatuses      = 0x00000001,
    EvtQueryPropertyIdEND = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winevt/ne-winevt-evt_event_property_id
alias EVT_EVENT_PROPERTY_ID = int;
enum : int
{
    EvtEventQueryIDs      = 0x00000000,
    EvtEventPath          = 0x00000001,
    EvtEventPropertyIdEND = 0x00000002,
}

// Constants


enum : uint
{
    EVT_VARIANT_TYPE_MASK  = 0x0000007fU,
    EVT_VARIANT_TYPE_ARRAY = 0x00000080U,
}

enum uint EVT_READ_ACCESS = 0x00000001U;
enum uint EVT_WRITE_ACCESS = 0x00000002U;
enum uint EVT_CLEAR_ACCESS = 0x00000004U;
enum uint EVT_ALL_ACCESS = 0x00000007U;

// Callbacks

alias EVT_SUBSCRIBE_CALLBACK = uint function(EVT_SUBSCRIBE_NOTIFY_ACTION Action, void* UserContext, 
                                             EVT_HANDLE Event);

// Structs


@RAIIFree!EvtClose
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct EVT_HANDLE
{
    ptrdiff_t Value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winevt/ns-winevt-evt_variant
struct EVT_VARIANT
{
    union
    {
        BOOL          BooleanVal;
        byte          SByteVal;
        short         Int16Val;
        int           Int32Val;
        long          Int64Val;
        ubyte         ByteVal;
        ushort        UInt16Val;
        uint          UInt32Val;
        ulong         UInt64Val;
        float         SingleVal;
        double        DoubleVal;
        ulong         FileTimeVal;
        SYSTEMTIME*   SysTimeVal;
        GUID*         GuidVal;
        const(PWSTR)  StringVal;
        const(PSTR)   AnsiStringVal;
        ubyte*        BinaryVal;
        PSID          SidVal;
        size_t        SizeTVal;
        BOOL*         BooleanArr;
        byte*         SByteArr;
        short*        Int16Arr;
        int*          Int32Arr;
        long*         Int64Arr;
        ubyte*        ByteArr;
        ushort*       UInt16Arr;
        uint*         UInt32Arr;
        ulong*        UInt64Arr;
        float*        SingleArr;
        double*       DoubleArr;
        FILETIME*     FileTimeArr;
        SYSTEMTIME*   SysTimeArr;
        GUID*         GuidArr;
        PWSTR*        StringArr;
        PSTR*         AnsiStringArr;
        PSID*         SidArr;
        size_t*       SizeTArr;
        EVT_HANDLE    EvtHandleVal;
        const(PWSTR)  XmlVal;
        const(PWSTR)* XmlValArr;
    }
    uint Count;
    uint Type;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winevt/ns-winevt-evt_rpc_login
struct EVT_RPC_LOGIN
{
    PWSTR Server;
    PWSTR User;
    PWSTR Domain;
    PWSTR Password;
    uint  Flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-eventlogrecord
struct EVENTLOGRECORD
{
    uint              Length;
    uint              Reserved;
    uint              RecordNumber;
    uint              TimeGenerated;
    uint              TimeWritten;
    uint              EventID;
    REPORT_EVENT_TYPE EventType;
    ushort            NumStrings;
    ushort            EventCategory;
    ushort            ReservedFlags;
    uint              ClosingRecordNumber;
    uint              StringOffset;
    uint              UserSidLength;
    uint              UserSidOffset;
    uint              DataLength;
    uint              DataOffset;
}

deprecated("struct EVENTSFORLOGFILE is deprecated and might not work on all platforms. For more info, see MSDN.") 
struct EVENTSFORLOGFILE
{
    uint              ulSize;
    wchar[256]        szLogicalLogFile;
    uint              ulNumRecords;
    EVENTLOGRECORD[1] pEventLogRecords;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/ns-winbase-eventlog_full_information
struct EVENTLOG_FULL_INFORMATION
{
    uint dwFull;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wevtapi.dll")
EVT_HANDLE EvtOpenSession(EVT_LOGIN_CLASS LoginClass, void* Login, 
                          /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint Timeout, 
                          /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wevtapi.dll")
BOOL EvtClose(EVT_HANDLE Object);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wevtapi.dll")
BOOL EvtCancel(EVT_HANDLE Object);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wevtapi.dll")
uint EvtGetExtendedStatus(uint BufferSize, PWSTR Buffer, uint* BufferUsed);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wevtapi.dll")
EVT_HANDLE EvtQuery(EVT_HANDLE Session, const(PWSTR) Path, const(PWSTR) Query, uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wevtapi.dll")
BOOL EvtNext(EVT_HANDLE ResultSet, uint EventsSize, ptrdiff_t* Events, uint Timeout, uint Flags, uint* Returned);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wevtapi.dll")
BOOL EvtSeek(EVT_HANDLE ResultSet, long Position, EVT_HANDLE Bookmark, 
             /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint Timeout, uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wevtapi.dll")
EVT_HANDLE EvtSubscribe(EVT_HANDLE Session, HANDLE SignalEvent, const(PWSTR) ChannelPath, const(PWSTR) Query, 
                        EVT_HANDLE Bookmark, void* Context, EVT_SUBSCRIBE_CALLBACK Callback, uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wevtapi.dll")
EVT_HANDLE EvtCreateRenderContext(uint ValuePathsCount, const(PWSTR)* ValuePaths, uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wevtapi.dll")
BOOL EvtRender(EVT_HANDLE Context, EVT_HANDLE Fragment, uint Flags, uint BufferSize, 
               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Buffer, 
               uint* BufferUsed, uint* PropertyCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wevtapi.dll")
BOOL EvtFormatMessage(EVT_HANDLE PublisherMetadata, EVT_HANDLE Event, uint MessageId, uint ValueCount, 
                      EVT_VARIANT* Values, uint Flags, uint BufferSize, PWSTR Buffer, uint* BufferUsed);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wevtapi.dll")
EVT_HANDLE EvtOpenLog(EVT_HANDLE Session, const(PWSTR) Path, uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wevtapi.dll")
BOOL EvtGetLogInfo(EVT_HANDLE Log, EVT_LOG_PROPERTY_ID PropertyId, uint PropertyValueBufferSize, 
                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/EVT_VARIANT* PropertyValueBuffer, 
                   uint* PropertyValueBufferUsed);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wevtapi.dll")
BOOL EvtClearLog(EVT_HANDLE Session, const(PWSTR) ChannelPath, const(PWSTR) TargetFilePath, uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wevtapi.dll")
BOOL EvtExportLog(EVT_HANDLE Session, const(PWSTR) Path, const(PWSTR) Query, const(PWSTR) TargetFilePath, 
                  uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wevtapi.dll")
BOOL EvtArchiveExportedLog(EVT_HANDLE Session, const(PWSTR) LogFilePath, uint Locale, uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wevtapi.dll")
EVT_HANDLE EvtOpenChannelEnum(EVT_HANDLE Session, uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wevtapi.dll")
BOOL EvtNextChannelPath(EVT_HANDLE ChannelEnum, uint ChannelPathBufferSize, PWSTR ChannelPathBuffer, 
                        uint* ChannelPathBufferUsed);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wevtapi.dll")
EVT_HANDLE EvtOpenChannelConfig(EVT_HANDLE Session, const(PWSTR) ChannelPath, uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wevtapi.dll")
BOOL EvtSaveChannelConfig(EVT_HANDLE ChannelConfig, uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wevtapi.dll")
BOOL EvtSetChannelConfigProperty(EVT_HANDLE ChannelConfig, EVT_CHANNEL_CONFIG_PROPERTY_ID PropertyId, uint Flags, 
                                 EVT_VARIANT* PropertyValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wevtapi.dll")
BOOL EvtGetChannelConfigProperty(EVT_HANDLE ChannelConfig, EVT_CHANNEL_CONFIG_PROPERTY_ID PropertyId, uint Flags, 
                                 uint PropertyValueBufferSize, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/EVT_VARIANT* PropertyValueBuffer, 
                                 uint* PropertyValueBufferUsed);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wevtapi.dll")
EVT_HANDLE EvtOpenPublisherEnum(EVT_HANDLE Session, uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wevtapi.dll")
BOOL EvtNextPublisherId(EVT_HANDLE PublisherEnum, uint PublisherIdBufferSize, PWSTR PublisherIdBuffer, 
                        uint* PublisherIdBufferUsed);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wevtapi.dll")
EVT_HANDLE EvtOpenPublisherMetadata(EVT_HANDLE Session, const(PWSTR) PublisherId, const(PWSTR) LogFilePath, 
                                    uint Locale, uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wevtapi.dll")
BOOL EvtGetPublisherMetadataProperty(EVT_HANDLE PublisherMetadata, EVT_PUBLISHER_METADATA_PROPERTY_ID PropertyId, 
                                     uint Flags, uint PublisherMetadataPropertyBufferSize, 
                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/EVT_VARIANT* PublisherMetadataPropertyBuffer, 
                                     uint* PublisherMetadataPropertyBufferUsed);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wevtapi.dll")
EVT_HANDLE EvtOpenEventMetadataEnum(EVT_HANDLE PublisherMetadata, uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wevtapi.dll")
EVT_HANDLE EvtNextEventMetadata(EVT_HANDLE EventMetadataEnum, uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wevtapi.dll")
BOOL EvtGetEventMetadataProperty(EVT_HANDLE EventMetadata, EVT_EVENT_METADATA_PROPERTY_ID PropertyId, uint Flags, 
                                 uint EventMetadataPropertyBufferSize, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/EVT_VARIANT* EventMetadataPropertyBuffer, 
                                 uint* EventMetadataPropertyBufferUsed);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wevtapi.dll")
BOOL EvtGetObjectArraySize(ptrdiff_t ObjectArray, uint* ObjectArraySize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wevtapi.dll")
BOOL EvtGetObjectArrayProperty(ptrdiff_t ObjectArray, uint PropertyId, uint ArrayIndex, uint Flags, 
                               uint PropertyValueBufferSize, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/EVT_VARIANT* PropertyValueBuffer, 
                               uint* PropertyValueBufferUsed);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wevtapi.dll")
BOOL EvtGetQueryInfo(EVT_HANDLE QueryOrSubscription, EVT_QUERY_PROPERTY_ID PropertyId, 
                     uint PropertyValueBufferSize, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/EVT_VARIANT* PropertyValueBuffer, 
                     uint* PropertyValueBufferUsed);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wevtapi.dll")
EVT_HANDLE EvtCreateBookmark(const(PWSTR) BookmarkXml);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wevtapi.dll")
BOOL EvtUpdateBookmark(EVT_HANDLE Bookmark, EVT_HANDLE Event);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wevtapi.dll")
BOOL EvtGetEventInfo(EVT_HANDLE Event, EVT_EVENT_PROPERTY_ID PropertyId, uint PropertyValueBufferSize, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/EVT_VARIANT* PropertyValueBuffer, 
                     uint* PropertyValueBufferUsed);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ADVAPI32.dll")
BOOL ClearEventLogA(HANDLE hEventLog, const(PSTR) lpBackupFileName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ADVAPI32.dll")
BOOL ClearEventLogW(HANDLE hEventLog, const(PWSTR) lpBackupFileName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ADVAPI32.dll")
BOOL BackupEventLogA(HANDLE hEventLog, const(PSTR) lpBackupFileName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ADVAPI32.dll")
BOOL BackupEventLogW(HANDLE hEventLog, const(PWSTR) lpBackupFileName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ADVAPI32.dll")
BOOL CloseEventLog(HANDLE hEventLog);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ADVAPI32.dll")
BOOL DeregisterEventSource(HANDLE hEventLog);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ADVAPI32.dll")
BOOL NotifyChangeEventLog(HANDLE hEventLog, HANDLE hEvent);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ADVAPI32.dll")
BOOL GetNumberOfEventLogRecords(HANDLE hEventLog, uint* NumberOfRecords);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ADVAPI32.dll")
BOOL GetOldestEventLogRecord(HANDLE hEventLog, uint* OldestRecord);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ADVAPI32.dll")
HANDLE OpenEventLogA(const(PSTR) lpUNCServerName, const(PSTR) lpSourceName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ADVAPI32.dll")
HANDLE OpenEventLogW(const(PWSTR) lpUNCServerName, const(PWSTR) lpSourceName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ADVAPI32.dll")
HANDLE RegisterEventSourceA(const(PSTR) lpUNCServerName, const(PSTR) lpSourceName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ADVAPI32.dll")
HANDLE RegisterEventSourceW(const(PWSTR) lpUNCServerName, const(PWSTR) lpSourceName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ADVAPI32.dll")
HANDLE OpenBackupEventLogA(const(PSTR) lpUNCServerName, const(PSTR) lpFileName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ADVAPI32.dll")
HANDLE OpenBackupEventLogW(const(PWSTR) lpUNCServerName, const(PWSTR) lpFileName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ADVAPI32.dll")
BOOL ReadEventLogA(HANDLE hEventLog, READ_EVENT_LOG_READ_FLAGS dwReadFlags, uint dwRecordOffset, 
                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* lpBuffer, 
                   uint nNumberOfBytesToRead, uint* pnBytesRead, uint* pnMinNumberOfBytesNeeded);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ADVAPI32.dll")
BOOL ReadEventLogW(HANDLE hEventLog, READ_EVENT_LOG_READ_FLAGS dwReadFlags, uint dwRecordOffset, 
                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* lpBuffer, 
                   uint nNumberOfBytesToRead, uint* pnBytesRead, uint* pnMinNumberOfBytesNeeded);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ADVAPI32.dll")
BOOL ReportEventA(HANDLE hEventLog, REPORT_EVENT_TYPE wType, ushort wCategory, uint dwEventID, PSID lpUserSid, 
                  ushort wNumStrings, uint dwDataSize, const(PSTR)* lpStrings, 
                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* lpRawData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ADVAPI32.dll")
BOOL ReportEventW(HANDLE hEventLog, REPORT_EVENT_TYPE wType, ushort wCategory, uint dwEventID, PSID lpUserSid, 
                  ushort wNumStrings, uint dwDataSize, const(PWSTR)* lpStrings, 
                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* lpRawData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ADVAPI32.dll")
BOOL GetEventLogInformation(HANDLE hEventLog, uint dwInfoLevel, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpBuffer, 
                            uint cbBufSize, uint* pcbBytesNeeded);


