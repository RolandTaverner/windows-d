// Written in the D programming language.

module windows.win32.storage.projectedfilesystem;

public import windows.core;
public import system : Guid;
public import windows.win32.foundation : BOOLEAN, HRESULT, PWSTR;

extern(Windows) @nogc nothrow:


// Enums

//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/projectedfslib/ne-projectedfslib-prj_notify_types))], [])
alias PRJ_NOTIFY_TYPES = uint;
enum : uint
{
    PRJ_NOTIFY_NONE                               = 0x00000000,
    PRJ_NOTIFY_SUPPRESS_NOTIFICATIONS             = 0x00000001,
    PRJ_NOTIFY_FILE_OPENED                        = 0x00000002,
    PRJ_NOTIFY_NEW_FILE_CREATED                   = 0x00000004,
    PRJ_NOTIFY_FILE_OVERWRITTEN                   = 0x00000008,
    PRJ_NOTIFY_PRE_DELETE                         = 0x00000010,
    PRJ_NOTIFY_PRE_RENAME                         = 0x00000020,
    PRJ_NOTIFY_PRE_SET_HARDLINK                   = 0x00000040,
    PRJ_NOTIFY_FILE_RENAMED                       = 0x00000080,
    PRJ_NOTIFY_HARDLINK_CREATED                   = 0x00000100,
    PRJ_NOTIFY_FILE_HANDLE_CLOSED_NO_MODIFICATION = 0x00000200,
    PRJ_NOTIFY_FILE_HANDLE_CLOSED_FILE_MODIFIED   = 0x00000400,
    PRJ_NOTIFY_FILE_HANDLE_CLOSED_FILE_DELETED    = 0x00000800,
    PRJ_NOTIFY_FILE_PRE_CONVERT_TO_FULL           = 0x00001000,
    PRJ_NOTIFY_USE_EXISTING_MASK                  = 0xffffffff,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/projectedfslib/ne-projectedfslib-prj_notification))], [])
alias PRJ_NOTIFICATION = int;
enum : int
{
    PRJ_NOTIFICATION_FILE_OPENED                        = 0x00000002,
    PRJ_NOTIFICATION_NEW_FILE_CREATED                   = 0x00000004,
    PRJ_NOTIFICATION_FILE_OVERWRITTEN                   = 0x00000008,
    PRJ_NOTIFICATION_PRE_DELETE                         = 0x00000010,
    PRJ_NOTIFICATION_PRE_RENAME                         = 0x00000020,
    PRJ_NOTIFICATION_PRE_SET_HARDLINK                   = 0x00000040,
    PRJ_NOTIFICATION_FILE_RENAMED                       = 0x00000080,
    PRJ_NOTIFICATION_HARDLINK_CREATED                   = 0x00000100,
    PRJ_NOTIFICATION_FILE_HANDLE_CLOSED_NO_MODIFICATION = 0x00000200,
    PRJ_NOTIFICATION_FILE_HANDLE_CLOSED_FILE_MODIFIED   = 0x00000400,
    PRJ_NOTIFICATION_FILE_HANDLE_CLOSED_FILE_DELETED    = 0x00000800,
    PRJ_NOTIFICATION_FILE_PRE_CONVERT_TO_FULL           = 0x00001000,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/projectedfslib/ne-projectedfslib-prj_ext_info_type))], [])
alias PRJ_EXT_INFO_TYPE = int;
enum : int
{
    PRJ_EXT_INFO_TYPE_SYMLINK = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/projectedfslib/ne-projectedfslib-prj_startvirtualizing_flags))], [])
alias PRJ_STARTVIRTUALIZING_FLAGS = int;
enum : int
{
    PRJ_FLAG_NONE                    = 0x00000000,
    PRJ_FLAG_USE_NEGATIVE_PATH_CACHE = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/projectedfslib/ne-projectedfslib-prj_placeholder_id))], [])
alias PRJ_PLACEHOLDER_ID = int;
enum : int
{
    PRJ_PLACEHOLDER_ID_LENGTH = 0x00000080,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/projectedfslib/ne-projectedfslib-prj_update_types))], [])
alias PRJ_UPDATE_TYPES = int;
enum : int
{
    PRJ_UPDATE_NONE                 = 0x00000000,
    PRJ_UPDATE_ALLOW_DIRTY_METADATA = 0x00000001,
    PRJ_UPDATE_ALLOW_DIRTY_DATA     = 0x00000002,
    PRJ_UPDATE_ALLOW_TOMBSTONE      = 0x00000004,
    PRJ_UPDATE_RESERVED1            = 0x00000008,
    PRJ_UPDATE_RESERVED2            = 0x00000010,
    PRJ_UPDATE_ALLOW_READ_ONLY      = 0x00000020,
    PRJ_UPDATE_MAX_VAL              = 0x00000040,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/projectedfslib/ne-projectedfslib-prj_update_failure_causes))], [])
alias PRJ_UPDATE_FAILURE_CAUSES = int;
enum : int
{
    PRJ_UPDATE_FAILURE_CAUSE_NONE           = 0x00000000,
    PRJ_UPDATE_FAILURE_CAUSE_DIRTY_METADATA = 0x00000001,
    PRJ_UPDATE_FAILURE_CAUSE_DIRTY_DATA     = 0x00000002,
    PRJ_UPDATE_FAILURE_CAUSE_TOMBSTONE      = 0x00000004,
    PRJ_UPDATE_FAILURE_CAUSE_READ_ONLY      = 0x00000008,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/projectedfslib/ne-projectedfslib-prj_file_state))], [])
alias PRJ_FILE_STATE = int;
enum : int
{
    PRJ_FILE_STATE_PLACEHOLDER          = 0x00000001,
    PRJ_FILE_STATE_HYDRATED_PLACEHOLDER = 0x00000002,
    PRJ_FILE_STATE_DIRTY_PLACEHOLDER    = 0x00000004,
    PRJ_FILE_STATE_FULL                 = 0x00000008,
    PRJ_FILE_STATE_TOMBSTONE            = 0x00000010,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/projectedfslib/ne-projectedfslib-prj_callback_data_flags))], [])
alias PRJ_CALLBACK_DATA_FLAGS = int;
enum : int
{
    PRJ_CB_DATA_FLAG_ENUM_RESTART_SCAN        = 0x00000001,
    PRJ_CB_DATA_FLAG_ENUM_RETURN_SINGLE_ENTRY = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/projectedfslib/ne-projectedfslib-prj_complete_command_type))], [])
alias PRJ_COMPLETE_COMMAND_TYPE = int;
enum : int
{
    PRJ_COMPLETE_COMMAND_TYPE_NOTIFICATION = 0x00000001,
    PRJ_COMPLETE_COMMAND_TYPE_ENUMERATION  = 0x00000002,
}

// Callbacks

alias PRJ_START_DIRECTORY_ENUMERATION_CB = HRESULT function(const(PRJ_CALLBACK_DATA)* callbackData, 
                                                            const(GUID)* enumerationId);
alias PRJ_GET_DIRECTORY_ENUMERATION_CB = HRESULT function(const(PRJ_CALLBACK_DATA)* callbackData, 
                                                          const(GUID)* enumerationId, const(PWSTR) searchExpression, 
                                                          PRJ_DIR_ENTRY_BUFFER_HANDLE dirEntryBufferHandle);
alias PRJ_END_DIRECTORY_ENUMERATION_CB = HRESULT function(const(PRJ_CALLBACK_DATA)* callbackData, 
                                                          const(GUID)* enumerationId);
alias PRJ_GET_PLACEHOLDER_INFO_CB = HRESULT function(const(PRJ_CALLBACK_DATA)* callbackData);
alias PRJ_GET_FILE_DATA_CB = HRESULT function(const(PRJ_CALLBACK_DATA)* callbackData, ulong byteOffset, 
                                              uint length);
alias PRJ_QUERY_FILE_NAME_CB = HRESULT function(const(PRJ_CALLBACK_DATA)* callbackData);
alias PRJ_NOTIFICATION_CB = HRESULT function(const(PRJ_CALLBACK_DATA)* callbackData, BOOLEAN isDirectory, 
                                             PRJ_NOTIFICATION notification, const(PWSTR) destinationFileName, 
                                             PRJ_NOTIFICATION_PARAMETERS* operationParameters);
alias PRJ_CANCEL_COMMAND_CB = void function(const(PRJ_CALLBACK_DATA)* callbackData);

// Structs


//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT
{
    void* Value;
}

//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct PRJ_DIR_ENTRY_BUFFER_HANDLE
{
    void* Value;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/projectedfslib/ns-projectedfslib-prj_extended_info))], [])
struct PRJ_EXTENDED_INFO
{
    PRJ_EXT_INFO_TYPE   InfoType;
    uint                NextInfoOffset;
    _Anonymous_e__Union Anonymous;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/projectedfslib/ns-projectedfslib-prj_notification_mapping))], [])
struct PRJ_NOTIFICATION_MAPPING
{
    PRJ_NOTIFY_TYPES NotificationBitMask;
    const(PWSTR)     NotificationRoot;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/projectedfslib/ns-projectedfslib-prj_startvirtualizing_options))], [])
struct PRJ_STARTVIRTUALIZING_OPTIONS
{
    PRJ_STARTVIRTUALIZING_FLAGS Flags;
    uint PoolThreadCount;
    uint ConcurrentThreadCount;
    PRJ_NOTIFICATION_MAPPING* NotificationMappings;
    uint NotificationMappingsCount;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/projectedfslib/ns-projectedfslib-prj_virtualization_instance_info))], [])
struct PRJ_VIRTUALIZATION_INSTANCE_INFO
{
    GUID InstanceID;
    uint WriteAlignment;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/projectedfslib/ns-projectedfslib-prj_placeholder_version_info))], [])
struct PRJ_PLACEHOLDER_VERSION_INFO
{
    ubyte[128] ProviderID;
    ubyte[128] ContentID;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/projectedfslib/ns-projectedfslib-prj_file_basic_info))], [])
struct PRJ_FILE_BASIC_INFO
{
    BOOLEAN IsDirectory;
    long    FileSize;
    long    CreationTime;
    long    LastAccessTime;
    long    LastWriteTime;
    long    ChangeTime;
    uint    FileAttributes;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/projectedfslib/ns-projectedfslib-prj_placeholder_info))], [])
struct PRJ_PLACEHOLDER_INFO
{
    PRJ_FILE_BASIC_INFO FileBasicInfo;
    _EaInformation_e__Struct EaInformation;
    _SecurityInformation_e__Struct SecurityInformation;
    _StreamsInformation_e__Struct StreamsInformation;
    PRJ_PLACEHOLDER_VERSION_INFO VersionInfo;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] VariableData;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/projectedfslib/ns-projectedfslib-prj_callback_data))], [])
struct PRJ_CALLBACK_DATA
{
    uint         Size;
    PRJ_CALLBACK_DATA_FLAGS Flags;
    PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT NamespaceVirtualizationContext;
    int          CommandId;
    GUID         FileId;
    GUID         DataStreamId;
    const(PWSTR) FilePathName;
    PRJ_PLACEHOLDER_VERSION_INFO* VersionInfo;
    uint         TriggeringProcessId;
    const(PWSTR) TriggeringProcessImageFileName;
    void*        InstanceContext;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/projectedfslib/ns-projectedfslib-prj_notification_parameters))], [])
union PRJ_NOTIFICATION_PARAMETERS
{
    _PostCreate_e__Struct PostCreate;
    _FileRenamed_e__Struct FileRenamed;
    _FileDeletedOnHandleClose_e__Struct FileDeletedOnHandleClose;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/projectedfslib/ns-projectedfslib-prj_callbacks))], [])
struct PRJ_CALLBACKS
{
    PRJ_START_DIRECTORY_ENUMERATION_CB StartDirectoryEnumerationCallback;
    PRJ_END_DIRECTORY_ENUMERATION_CB EndDirectoryEnumerationCallback;
    PRJ_GET_DIRECTORY_ENUMERATION_CB GetDirectoryEnumerationCallback;
    PRJ_GET_PLACEHOLDER_INFO_CB GetPlaceholderInfoCallback;
    PRJ_GET_FILE_DATA_CB GetFileDataCallback;
    PRJ_QUERY_FILE_NAME_CB QueryFileNameCallback;
    PRJ_NOTIFICATION_CB  NotificationCallback;
    PRJ_CANCEL_COMMAND_CB CancelCommandCallback;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/projectedfslib/ns-projectedfslib-prj_complete_command_extended_parameters))], [])
struct PRJ_COMPLETE_COMMAND_EXTENDED_PARAMETERS
{
    PRJ_COMPLETE_COMMAND_TYPE CommandType;
    _Anonymous_e__Union Anonymous;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17763))], [])
@DllImport("PROJECTEDFSLIB.dll")
HRESULT PrjStartVirtualizing(const(PWSTR) virtualizationRootPath, const(PRJ_CALLBACKS)* callbacks, 
                             const(void)* instanceContext, const(PRJ_STARTVIRTUALIZING_OPTIONS)* options, 
                             PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT* namespaceVirtualizationContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17763))], [])
@DllImport("PROJECTEDFSLIB.dll")
void PrjStopVirtualizing(PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT namespaceVirtualizationContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17763))], [])
@DllImport("PROJECTEDFSLIB.dll")
HRESULT PrjClearNegativePathCache(PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT namespaceVirtualizationContext, 
                                  uint* totalEntryNumber);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17763))], [])
@DllImport("PROJECTEDFSLIB.dll")
HRESULT PrjGetVirtualizationInstanceInfo(PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT namespaceVirtualizationContext, 
                                         PRJ_VIRTUALIZATION_INSTANCE_INFO* virtualizationInstanceInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17763))], [])
@DllImport("PROJECTEDFSLIB.dll")
HRESULT PrjMarkDirectoryAsPlaceholder(const(PWSTR) rootPathName, const(PWSTR) targetPathName, 
                                      const(PRJ_PLACEHOLDER_VERSION_INFO)* versionInfo, 
                                      const(GUID)* virtualizationInstanceID);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17763))], [])
@DllImport("PROJECTEDFSLIB.dll")
HRESULT PrjWritePlaceholderInfo(PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT namespaceVirtualizationContext, 
                                const(PWSTR) destinationFileName, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/const(PRJ_PLACEHOLDER_INFO)* placeholderInfo, 
                                uint placeholderInfoSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.19041))], [])
@DllImport("PROJECTEDFSLIB.dll")
HRESULT PrjWritePlaceholderInfo2(PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT namespaceVirtualizationContext, 
                                 const(PWSTR) destinationFileName, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/const(PRJ_PLACEHOLDER_INFO)* placeholderInfo, 
                                 uint placeholderInfoSize, const(PRJ_EXTENDED_INFO)* ExtendedInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17763))], [])
@DllImport("PROJECTEDFSLIB.dll")
HRESULT PrjUpdateFileIfNeeded(PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT namespaceVirtualizationContext, 
                              const(PWSTR) destinationFileName, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/const(PRJ_PLACEHOLDER_INFO)* placeholderInfo, 
                              uint placeholderInfoSize, PRJ_UPDATE_TYPES updateFlags, 
                              PRJ_UPDATE_FAILURE_CAUSES* failureReason);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17763))], [])
@DllImport("PROJECTEDFSLIB.dll")
HRESULT PrjDeleteFile(PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT namespaceVirtualizationContext, 
                      const(PWSTR) destinationFileName, PRJ_UPDATE_TYPES updateFlags, 
                      PRJ_UPDATE_FAILURE_CAUSES* failureReason);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17763))], [])
@DllImport("PROJECTEDFSLIB.dll")
HRESULT PrjWriteFileData(PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT namespaceVirtualizationContext, 
                         const(GUID)* dataStreamId, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* buffer, 
                         ulong byteOffset, uint length);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17763))], [])
@DllImport("PROJECTEDFSLIB.dll")
HRESULT PrjGetOnDiskFileState(const(PWSTR) destinationFileName, PRJ_FILE_STATE* fileState);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17763))], [])
@DllImport("PROJECTEDFSLIB.dll")
void* PrjAllocateAlignedBuffer(PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT namespaceVirtualizationContext, size_t size);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17763))], [])
@DllImport("PROJECTEDFSLIB.dll")
void PrjFreeAlignedBuffer(void* buffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17763))], [])
@DllImport("PROJECTEDFSLIB.dll")
HRESULT PrjCompleteCommand(PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT namespaceVirtualizationContext, int commandId, 
                           HRESULT completionResult, PRJ_COMPLETE_COMMAND_EXTENDED_PARAMETERS* extendedParameters);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17763))], [])
@DllImport("PROJECTEDFSLIB.dll")
HRESULT PrjFillDirEntryBuffer(const(PWSTR) fileName, PRJ_FILE_BASIC_INFO* fileBasicInfo, 
                              PRJ_DIR_ENTRY_BUFFER_HANDLE dirEntryBufferHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.19041))], [])
@DllImport("PROJECTEDFSLIB.dll")
HRESULT PrjFillDirEntryBuffer2(PRJ_DIR_ENTRY_BUFFER_HANDLE dirEntryBufferHandle, const(PWSTR) fileName, 
                               PRJ_FILE_BASIC_INFO* fileBasicInfo, PRJ_EXTENDED_INFO* extendedInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17763))], [])
@DllImport("PROJECTEDFSLIB.dll")
BOOLEAN PrjFileNameMatch(const(PWSTR) fileNameToCheck, const(PWSTR) pattern);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17763))], [])
@DllImport("PROJECTEDFSLIB.dll")
int PrjFileNameCompare(const(PWSTR) fileName1, const(PWSTR) fileName2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17763))], [])
@DllImport("PROJECTEDFSLIB.dll")
BOOLEAN PrjDoesNameContainWildCards(const(PWSTR) fileName);


