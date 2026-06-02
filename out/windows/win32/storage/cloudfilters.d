// Written in the D programming language.

module windows.win32.storage.cloudfilters;

public import windows.core;
public import windows.win32.foundation : BOOLEAN, HANDLE, HRESULT, NTSTATUS, PWSTR;
public import windows.win32.storage.filesystem : FILE_BASIC_INFO, FILE_INFO_BY_HANDLE_CLASS,
                                                 WIN32_FIND_DATAA;
public import windows.win32.system.correlationvector : CORRELATION_VECTOR;
public import windows.win32.system.io : OVERLAPPED;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ne-cfapi-cf_placeholder_create_flags
alias CF_PLACEHOLDER_CREATE_FLAGS = int;
enum : int
{
    CF_PLACEHOLDER_CREATE_FLAG_NONE                         = 0x00000000,
    CF_PLACEHOLDER_CREATE_FLAG_DISABLE_ON_DEMAND_POPULATION = 0x00000001,
    CF_PLACEHOLDER_CREATE_FLAG_MARK_IN_SYNC                 = 0x00000002,
    CF_PLACEHOLDER_CREATE_FLAG_SUPERSEDE                    = 0x00000004,
    CF_PLACEHOLDER_CREATE_FLAG_ALWAYS_FULL                  = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ne-cfapi-cf_sync_provider_status
alias CF_SYNC_PROVIDER_STATUS = uint;
enum : uint
{
    CF_PROVIDER_STATUS_DISCONNECTED       = 0x00000000U,
    CF_PROVIDER_STATUS_IDLE               = 0x00000001U,
    CF_PROVIDER_STATUS_POPULATE_NAMESPACE = 0x00000002U,
    CF_PROVIDER_STATUS_POPULATE_METADATA  = 0x00000004U,
    CF_PROVIDER_STATUS_POPULATE_CONTENT   = 0x00000008U,
    CF_PROVIDER_STATUS_SYNC_INCREMENTAL   = 0x00000010U,
    CF_PROVIDER_STATUS_SYNC_FULL          = 0x00000020U,
    CF_PROVIDER_STATUS_CONNECTIVITY_LOST  = 0x00000040U,
    CF_PROVIDER_STATUS_CLEAR_FLAGS        = 0x80000000U,
    CF_PROVIDER_STATUS_TERMINATED         = 0xc0000001U,
    CF_PROVIDER_STATUS_ERROR              = 0xc0000002U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ne-cfapi-cf_register_flags
alias CF_REGISTER_FLAGS = int;
enum : int
{
    CF_REGISTER_FLAG_NONE                                 = 0x00000000,
    CF_REGISTER_FLAG_UPDATE                               = 0x00000001,
    CF_REGISTER_FLAG_DISABLE_ON_DEMAND_POPULATION_ON_ROOT = 0x00000002,
    CF_REGISTER_FLAG_MARK_IN_SYNC_ON_ROOT                 = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ne-cfapi-cf_hydration_policy_primary
alias CF_HYDRATION_POLICY_PRIMARY = ushort;
enum : ushort
{
    CF_HYDRATION_POLICY_PARTIAL     = cast(ushort) 0x0000,
    CF_HYDRATION_POLICY_PROGRESSIVE = cast(ushort) 0x0001,
    CF_HYDRATION_POLICY_FULL        = cast(ushort) 0x0002,
    CF_HYDRATION_POLICY_ALWAYS_FULL = cast(ushort) 0x0003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ne-cfapi-cf_hydration_policy_modifier
alias CF_HYDRATION_POLICY_MODIFIER = ushort;
enum : ushort
{
    CF_HYDRATION_POLICY_MODIFIER_NONE                         = cast(ushort) 0x0000,
    CF_HYDRATION_POLICY_MODIFIER_VALIDATION_REQUIRED          = cast(ushort) 0x0001,
    CF_HYDRATION_POLICY_MODIFIER_STREAMING_ALLOWED            = cast(ushort) 0x0002,
    CF_HYDRATION_POLICY_MODIFIER_AUTO_DEHYDRATION_ALLOWED     = cast(ushort) 0x0004,
    CF_HYDRATION_POLICY_MODIFIER_ALLOW_FULL_RESTART_HYDRATION = cast(ushort) 0x0008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ne-cfapi-cf_population_policy_primary
alias CF_POPULATION_POLICY_PRIMARY = ushort;
enum : ushort
{
    CF_POPULATION_POLICY_PARTIAL     = cast(ushort) 0x0000,
    CF_POPULATION_POLICY_FULL        = cast(ushort) 0x0002,
    CF_POPULATION_POLICY_ALWAYS_FULL = cast(ushort) 0x0003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ne-cfapi-cf_population_policy_modifier
alias CF_POPULATION_POLICY_MODIFIER = ushort;
enum : ushort
{
    CF_POPULATION_POLICY_MODIFIER_NONE = cast(ushort) 0x0000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ne-cfapi-cf_placeholder_management_policy
alias CF_PLACEHOLDER_MANAGEMENT_POLICY = int;
enum : int
{
    CF_PLACEHOLDER_MANAGEMENT_POLICY_DEFAULT                 = 0x00000000,
    CF_PLACEHOLDER_MANAGEMENT_POLICY_CREATE_UNRESTRICTED     = 0x00000001,
    CF_PLACEHOLDER_MANAGEMENT_POLICY_CONVERT_TO_UNRESTRICTED = 0x00000002,
    CF_PLACEHOLDER_MANAGEMENT_POLICY_UPDATE_UNRESTRICTED     = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ne-cfapi-cf_insync_policy
alias CF_INSYNC_POLICY = uint;
enum : uint
{
    CF_INSYNC_POLICY_NONE                               = 0x00000000U,
    CF_INSYNC_POLICY_TRACK_FILE_CREATION_TIME           = 0x00000001U,
    CF_INSYNC_POLICY_TRACK_FILE_READONLY_ATTRIBUTE      = 0x00000002U,
    CF_INSYNC_POLICY_TRACK_FILE_HIDDEN_ATTRIBUTE        = 0x00000004U,
    CF_INSYNC_POLICY_TRACK_FILE_SYSTEM_ATTRIBUTE        = 0x00000008U,
    CF_INSYNC_POLICY_TRACK_DIRECTORY_CREATION_TIME      = 0x00000010U,
    CF_INSYNC_POLICY_TRACK_DIRECTORY_READONLY_ATTRIBUTE = 0x00000020U,
    CF_INSYNC_POLICY_TRACK_DIRECTORY_HIDDEN_ATTRIBUTE   = 0x00000040U,
    CF_INSYNC_POLICY_TRACK_DIRECTORY_SYSTEM_ATTRIBUTE   = 0x00000080U,
    CF_INSYNC_POLICY_TRACK_FILE_LAST_WRITE_TIME         = 0x00000100U,
    CF_INSYNC_POLICY_TRACK_DIRECTORY_LAST_WRITE_TIME    = 0x00000200U,
    CF_INSYNC_POLICY_TRACK_FILE_ALL                     = 0x0055550fU,
    CF_INSYNC_POLICY_TRACK_DIRECTORY_ALL                = 0x00aaaaf0U,
    CF_INSYNC_POLICY_TRACK_ALL                          = 0x00ffffffU,
    CF_INSYNC_POLICY_PRESERVE_INSYNC_FOR_SYNC_ENGINE    = 0x80000000U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ne-cfapi-cf_hardlink_policy
alias CF_HARDLINK_POLICY = int;
enum : int
{
    CF_HARDLINK_POLICY_NONE    = 0x00000000,
    CF_HARDLINK_POLICY_ALLOWED = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ne-cfapi-cf_callback_cancel_flags
alias CF_CALLBACK_CANCEL_FLAGS = int;
enum : int
{
    CF_CALLBACK_CANCEL_FLAG_NONE       = 0x00000000,
    CF_CALLBACK_CANCEL_FLAG_IO_TIMEOUT = 0x00000001,
    CF_CALLBACK_CANCEL_FLAG_IO_ABORTED = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ne-cfapi-cf_callback_fetch_data_flags
alias CF_CALLBACK_FETCH_DATA_FLAGS = int;
enum : int
{
    CF_CALLBACK_FETCH_DATA_FLAG_NONE               = 0x00000000,
    CF_CALLBACK_FETCH_DATA_FLAG_RECOVERY           = 0x00000001,
    CF_CALLBACK_FETCH_DATA_FLAG_EXPLICIT_HYDRATION = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ne-cfapi-cf_callback_validate_data_flags
alias CF_CALLBACK_VALIDATE_DATA_FLAGS = int;
enum : int
{
    CF_CALLBACK_VALIDATE_DATA_FLAG_NONE               = 0x00000000,
    CF_CALLBACK_VALIDATE_DATA_FLAG_EXPLICIT_HYDRATION = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ne-cfapi-cf_callback_fetch_placeholders_flags
alias CF_CALLBACK_FETCH_PLACEHOLDERS_FLAGS = int;
enum : int
{
    CF_CALLBACK_FETCH_PLACEHOLDERS_FLAG_NONE = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ne-cfapi-cf_callback_open_completion_flags
alias CF_CALLBACK_OPEN_COMPLETION_FLAGS = int;
enum : int
{
    CF_CALLBACK_OPEN_COMPLETION_FLAG_NONE                    = 0x00000000,
    CF_CALLBACK_OPEN_COMPLETION_FLAG_PLACEHOLDER_UNKNOWN     = 0x00000001,
    CF_CALLBACK_OPEN_COMPLETION_FLAG_PLACEHOLDER_UNSUPPORTED = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ne-cfapi-cf_callback_close_completion_flags
alias CF_CALLBACK_CLOSE_COMPLETION_FLAGS = int;
enum : int
{
    CF_CALLBACK_CLOSE_COMPLETION_FLAG_NONE    = 0x00000000,
    CF_CALLBACK_CLOSE_COMPLETION_FLAG_DELETED = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ne-cfapi-cf_callback_dehydrate_flags
alias CF_CALLBACK_DEHYDRATE_FLAGS = int;
enum : int
{
    CF_CALLBACK_DEHYDRATE_FLAG_NONE       = 0x00000000,
    CF_CALLBACK_DEHYDRATE_FLAG_BACKGROUND = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ne-cfapi-cf_callback_dehydrate_completion_flags
alias CF_CALLBACK_DEHYDRATE_COMPLETION_FLAGS = int;
enum : int
{
    CF_CALLBACK_DEHYDRATE_COMPLETION_FLAG_NONE       = 0x00000000,
    CF_CALLBACK_DEHYDRATE_COMPLETION_FLAG_BACKGROUND = 0x00000001,
    CF_CALLBACK_DEHYDRATE_COMPLETION_FLAG_DEHYDRATED = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ne-cfapi-cf_callback_delete_flags
alias CF_CALLBACK_DELETE_FLAGS = int;
enum : int
{
    CF_CALLBACK_DELETE_FLAG_NONE         = 0x00000000,
    CF_CALLBACK_DELETE_FLAG_IS_DIRECTORY = 0x00000001,
    CF_CALLBACK_DELETE_FLAG_IS_UNDELETE  = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ne-cfapi-cf_callback_delete_completion_flags
alias CF_CALLBACK_DELETE_COMPLETION_FLAGS = int;
enum : int
{
    CF_CALLBACK_DELETE_COMPLETION_FLAG_NONE = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ne-cfapi-cf_callback_rename_flags
alias CF_CALLBACK_RENAME_FLAGS = int;
enum : int
{
    CF_CALLBACK_RENAME_FLAG_NONE            = 0x00000000,
    CF_CALLBACK_RENAME_FLAG_IS_DIRECTORY    = 0x00000001,
    CF_CALLBACK_RENAME_FLAG_SOURCE_IN_SCOPE = 0x00000002,
    CF_CALLBACK_RENAME_FLAG_TARGET_IN_SCOPE = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ne-cfapi-cf_callback_rename_completion_flags
alias CF_CALLBACK_RENAME_COMPLETION_FLAGS = int;
enum : int
{
    CF_CALLBACK_RENAME_COMPLETION_FLAG_NONE = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ne-cfapi-cf_callback_dehydration_reason
alias CF_CALLBACK_DEHYDRATION_REASON = int;
enum : int
{
    CF_CALLBACK_DEHYDRATION_REASON_NONE              = 0x00000000,
    CF_CALLBACK_DEHYDRATION_REASON_USER_MANUAL       = 0x00000001,
    CF_CALLBACK_DEHYDRATION_REASON_SYSTEM_LOW_SPACE  = 0x00000002,
    CF_CALLBACK_DEHYDRATION_REASON_SYSTEM_INACTIVITY = 0x00000003,
    CF_CALLBACK_DEHYDRATION_REASON_SYSTEM_OS_UPGRADE = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ne-cfapi-cf_callback_type
alias CF_CALLBACK_TYPE = int;
enum : int
{
    CF_CALLBACK_TYPE_FETCH_DATA                   = 0x00000000,
    CF_CALLBACK_TYPE_VALIDATE_DATA                = 0x00000001,
    CF_CALLBACK_TYPE_CANCEL_FETCH_DATA            = 0x00000002,
    CF_CALLBACK_TYPE_FETCH_PLACEHOLDERS           = 0x00000003,
    CF_CALLBACK_TYPE_CANCEL_FETCH_PLACEHOLDERS    = 0x00000004,
    CF_CALLBACK_TYPE_NOTIFY_FILE_OPEN_COMPLETION  = 0x00000005,
    CF_CALLBACK_TYPE_NOTIFY_FILE_CLOSE_COMPLETION = 0x00000006,
    CF_CALLBACK_TYPE_NOTIFY_DEHYDRATE             = 0x00000007,
    CF_CALLBACK_TYPE_NOTIFY_DEHYDRATE_COMPLETION  = 0x00000008,
    CF_CALLBACK_TYPE_NOTIFY_DELETE                = 0x00000009,
    CF_CALLBACK_TYPE_NOTIFY_DELETE_COMPLETION     = 0x0000000a,
    CF_CALLBACK_TYPE_NOTIFY_RENAME                = 0x0000000b,
    CF_CALLBACK_TYPE_NOTIFY_RENAME_COMPLETION     = 0x0000000c,
    CF_CALLBACK_TYPE_NONE                         = 0xffffffff,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ne-cfapi-cf_connect_flags
alias CF_CONNECT_FLAGS = int;
enum : int
{
    CF_CONNECT_FLAG_NONE                          = 0x00000000,
    CF_CONNECT_FLAG_REQUIRE_PROCESS_INFO          = 0x00000002,
    CF_CONNECT_FLAG_REQUIRE_FULL_FILE_PATH        = 0x00000004,
    CF_CONNECT_FLAG_BLOCK_SELF_IMPLICIT_HYDRATION = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ne-cfapi-cf_operation_type
alias CF_OPERATION_TYPE = int;
enum : int
{
    CF_OPERATION_TYPE_TRANSFER_DATA         = 0x00000000,
    CF_OPERATION_TYPE_RETRIEVE_DATA         = 0x00000001,
    CF_OPERATION_TYPE_ACK_DATA              = 0x00000002,
    CF_OPERATION_TYPE_RESTART_HYDRATION     = 0x00000003,
    CF_OPERATION_TYPE_TRANSFER_PLACEHOLDERS = 0x00000004,
    CF_OPERATION_TYPE_ACK_DEHYDRATE         = 0x00000005,
    CF_OPERATION_TYPE_ACK_DELETE            = 0x00000006,
    CF_OPERATION_TYPE_ACK_RENAME            = 0x00000007,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ne-cfapi-cf_operation_transfer_data_flags
alias CF_OPERATION_TRANSFER_DATA_FLAGS = int;
enum : int
{
    CF_OPERATION_TRANSFER_DATA_FLAG_NONE = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ne-cfapi-cf_operation_retrieve_data_flags
alias CF_OPERATION_RETRIEVE_DATA_FLAGS = int;
enum : int
{
    CF_OPERATION_RETRIEVE_DATA_FLAG_NONE = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ne-cfapi-cf_operation_ack_data_flags
alias CF_OPERATION_ACK_DATA_FLAGS = int;
enum : int
{
    CF_OPERATION_ACK_DATA_FLAG_NONE = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ne-cfapi-cf_operation_restart_hydration_flags
alias CF_OPERATION_RESTART_HYDRATION_FLAGS = int;
enum : int
{
    CF_OPERATION_RESTART_HYDRATION_FLAG_NONE         = 0x00000000,
    CF_OPERATION_RESTART_HYDRATION_FLAG_MARK_IN_SYNC = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ne-cfapi-cf_operation_transfer_placeholders_flags
alias CF_OPERATION_TRANSFER_PLACEHOLDERS_FLAGS = int;
enum : int
{
    CF_OPERATION_TRANSFER_PLACEHOLDERS_FLAG_NONE                         = 0x00000000,
    CF_OPERATION_TRANSFER_PLACEHOLDERS_FLAG_STOP_ON_ERROR                = 0x00000001,
    CF_OPERATION_TRANSFER_PLACEHOLDERS_FLAG_DISABLE_ON_DEMAND_POPULATION = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ne-cfapi-cf_operation_ack_dehydrate_flags
alias CF_OPERATION_ACK_DEHYDRATE_FLAGS = int;
enum : int
{
    CF_OPERATION_ACK_DEHYDRATE_FLAG_NONE = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ne-cfapi-cf_operation_ack_rename_flags
alias CF_OPERATION_ACK_RENAME_FLAGS = int;
enum : int
{
    CF_OPERATION_ACK_RENAME_FLAG_NONE = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ne-cfapi-cf_operation_ack_delete_flags
alias CF_OPERATION_ACK_DELETE_FLAGS = int;
enum : int
{
    CF_OPERATION_ACK_DELETE_FLAG_NONE = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ne-cfapi-cf_create_flags
alias CF_CREATE_FLAGS = int;
enum : int
{
    CF_CREATE_FLAG_NONE          = 0x00000000,
    CF_CREATE_FLAG_STOP_ON_ERROR = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ne-cfapi-cf_open_file_flags
alias CF_OPEN_FILE_FLAGS = int;
enum : int
{
    CF_OPEN_FILE_FLAG_NONE          = 0x00000000,
    CF_OPEN_FILE_FLAG_EXCLUSIVE     = 0x00000001,
    CF_OPEN_FILE_FLAG_WRITE_ACCESS  = 0x00000002,
    CF_OPEN_FILE_FLAG_DELETE_ACCESS = 0x00000004,
    CF_OPEN_FILE_FLAG_FOREGROUND    = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ne-cfapi-cf_convert_flags
alias CF_CONVERT_FLAGS = int;
enum : int
{
    CF_CONVERT_FLAG_NONE                        = 0x00000000,
    CF_CONVERT_FLAG_MARK_IN_SYNC                = 0x00000001,
    CF_CONVERT_FLAG_DEHYDRATE                   = 0x00000002,
    CF_CONVERT_FLAG_ENABLE_ON_DEMAND_POPULATION = 0x00000004,
    CF_CONVERT_FLAG_ALWAYS_FULL                 = 0x00000008,
    CF_CONVERT_FLAG_FORCE_CONVERT_TO_CLOUD_FILE = 0x00000010,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ne-cfapi-cf_update_flags
alias CF_UPDATE_FLAGS = int;
enum : int
{
    CF_UPDATE_FLAG_NONE                         = 0x00000000,
    CF_UPDATE_FLAG_VERIFY_IN_SYNC               = 0x00000001,
    CF_UPDATE_FLAG_MARK_IN_SYNC                 = 0x00000002,
    CF_UPDATE_FLAG_DEHYDRATE                    = 0x00000004,
    CF_UPDATE_FLAG_ENABLE_ON_DEMAND_POPULATION  = 0x00000008,
    CF_UPDATE_FLAG_DISABLE_ON_DEMAND_POPULATION = 0x00000010,
    CF_UPDATE_FLAG_REMOVE_FILE_IDENTITY         = 0x00000020,
    CF_UPDATE_FLAG_CLEAR_IN_SYNC                = 0x00000040,
    CF_UPDATE_FLAG_REMOVE_PROPERTY              = 0x00000080,
    CF_UPDATE_FLAG_PASSTHROUGH_FS_METADATA      = 0x00000100,
    CF_UPDATE_FLAG_ALWAYS_FULL                  = 0x00000200,
    CF_UPDATE_FLAG_ALLOW_PARTIAL                = 0x00000400,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ne-cfapi-cf_revert_flags
alias CF_REVERT_FLAGS = int;
enum : int
{
    CF_REVERT_FLAG_NONE = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ne-cfapi-cf_hydrate_flags
alias CF_HYDRATE_FLAGS = int;
enum : int
{
    CF_HYDRATE_FLAG_NONE = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ne-cfapi-cf_dehydrate_flags
alias CF_DEHYDRATE_FLAGS = int;
enum : int
{
    CF_DEHYDRATE_FLAG_NONE       = 0x00000000,
    CF_DEHYDRATE_FLAG_BACKGROUND = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ne-cfapi-cf_pin_state
alias CF_PIN_STATE = int;
enum : int
{
    CF_PIN_STATE_UNSPECIFIED = 0x00000000,
    CF_PIN_STATE_PINNED      = 0x00000001,
    CF_PIN_STATE_UNPINNED    = 0x00000002,
    CF_PIN_STATE_EXCLUDED    = 0x00000003,
    CF_PIN_STATE_INHERIT     = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ne-cfapi-cf_set_pin_flags
alias CF_SET_PIN_FLAGS = int;
enum : int
{
    CF_SET_PIN_FLAG_NONE                  = 0x00000000,
    CF_SET_PIN_FLAG_RECURSE               = 0x00000001,
    CF_SET_PIN_FLAG_RECURSE_ONLY          = 0x00000002,
    CF_SET_PIN_FLAG_RECURSE_STOP_ON_ERROR = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ne-cfapi-cf_in_sync_state
alias CF_IN_SYNC_STATE = int;
enum : int
{
    CF_IN_SYNC_STATE_NOT_IN_SYNC = 0x00000000,
    CF_IN_SYNC_STATE_IN_SYNC     = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ne-cfapi-cf_set_in_sync_flags
alias CF_SET_IN_SYNC_FLAGS = int;
enum : int
{
    CF_SET_IN_SYNC_FLAG_NONE = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ne-cfapi-cf_placeholder_state
alias CF_PLACEHOLDER_STATE = uint;
enum : uint
{
    CF_PLACEHOLDER_STATE_NO_STATES              = 0x00000000U,
    CF_PLACEHOLDER_STATE_PLACEHOLDER            = 0x00000001U,
    CF_PLACEHOLDER_STATE_SYNC_ROOT              = 0x00000002U,
    CF_PLACEHOLDER_STATE_ESSENTIAL_PROP_PRESENT = 0x00000004U,
    CF_PLACEHOLDER_STATE_IN_SYNC                = 0x00000008U,
    CF_PLACEHOLDER_STATE_PARTIAL                = 0x00000010U,
    CF_PLACEHOLDER_STATE_PARTIALLY_ON_DISK      = 0x00000020U,
    CF_PLACEHOLDER_STATE_INVALID                = 0xffffffffU,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ne-cfapi-cf_placeholder_info_class
alias CF_PLACEHOLDER_INFO_CLASS = int;
enum : int
{
    CF_PLACEHOLDER_INFO_BASIC    = 0x00000000,
    CF_PLACEHOLDER_INFO_STANDARD = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ne-cfapi-cf_sync_root_info_class
alias CF_SYNC_ROOT_INFO_CLASS = int;
enum : int
{
    CF_SYNC_ROOT_INFO_BASIC    = 0x00000000,
    CF_SYNC_ROOT_INFO_STANDARD = 0x00000001,
    CF_SYNC_ROOT_INFO_PROVIDER = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ne-cfapi-cf_placeholder_range_info_class
alias CF_PLACEHOLDER_RANGE_INFO_CLASS = int;
enum : int
{
    CF_PLACEHOLDER_RANGE_INFO_ONDISK    = 0x00000001,
    CF_PLACEHOLDER_RANGE_INFO_VALIDATED = 0x00000002,
    CF_PLACEHOLDER_RANGE_INFO_MODIFIED  = 0x00000003,
}

// Constants


enum uint CF_REQUEST_KEY_DEFAULT = 0x00000000U;
enum uint CF_PLACEHOLDER_MAX_FILE_IDENTITY_LENGTH = 0x00001000U;

enum : uint
{
    CF_MAX_PRIORITY_HINT           = 0x0000000fU,
    CF_MAX_PROVIDER_NAME_LENGTH    = 0x000000ffU,
    CF_MAX_PROVIDER_VERSION_LENGTH = 0x000000ffU,
}

// Callbacks

alias CF_CALLBACK = void function(const(CF_CALLBACK_INFO)* CallbackInfo, 
                                  const(CF_CALLBACK_PARAMETERS)* CallbackParameters);

// Structs


@RAIIFree!CfDisconnectSyncRoot
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct CF_CONNECTION_KEY
{
    long Value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ns-cfapi-cf_fs_metadata
struct CF_FS_METADATA
{
    FILE_BASIC_INFO BasicInfo;
    long            FileSize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ns-cfapi-cf_placeholder_create_info
struct CF_PLACEHOLDER_CREATE_INFO
{
    const(PWSTR)   RelativeFileName;
    CF_FS_METADATA FsMetadata;
    const(void)*   FileIdentity;
    uint           FileIdentityLength;
    CF_PLACEHOLDER_CREATE_FLAGS Flags;
    HRESULT        Result;
    long           CreateUsn;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ns-cfapi-cf_process_info
struct CF_PROCESS_INFO
{
    uint         StructSize;
    uint         ProcessId;
    const(PWSTR) ImagePath;
    const(PWSTR) PackageName;
    const(PWSTR) ApplicationId;
    const(PWSTR) CommandLine;
    uint         SessionId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ns-cfapi-cf_platform_info
struct CF_PLATFORM_INFO
{
    uint BuildNumber;
    uint RevisionNumber;
    uint IntegrationNumber;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ns-cfapi-cf_hydration_policy
struct CF_HYDRATION_POLICY
{
    CF_HYDRATION_POLICY_PRIMARY Primary;
    CF_HYDRATION_POLICY_MODIFIER Modifier;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ns-cfapi-cf_population_policy
struct CF_POPULATION_POLICY
{
    CF_POPULATION_POLICY_PRIMARY Primary;
    CF_POPULATION_POLICY_MODIFIER Modifier;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ns-cfapi-cf_sync_policies
struct CF_SYNC_POLICIES
{
    uint                 StructSize;
    CF_HYDRATION_POLICY  Hydration;
    CF_POPULATION_POLICY Population;
    CF_INSYNC_POLICY     InSync;
    CF_HARDLINK_POLICY   HardLink;
    CF_PLACEHOLDER_MANAGEMENT_POLICY PlaceholderManagement;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ns-cfapi-cf_sync_registration
struct CF_SYNC_REGISTRATION
{
    uint         StructSize;
    const(PWSTR) ProviderName;
    const(PWSTR) ProviderVersion;
    const(void)* SyncRootIdentity;
    uint         SyncRootIdentityLength;
    const(void)* FileIdentity;
    uint         FileIdentityLength;
    GUID         ProviderId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ns-cfapi-cf_callback_info
struct CF_CALLBACK_INFO
{
    uint                StructSize;
    CF_CONNECTION_KEY   ConnectionKey;
    void*               CallbackContext;
    const(PWSTR)        VolumeGuidName;
    const(PWSTR)        VolumeDosName;
    uint                VolumeSerialNumber;
    long                SyncRootFileId;
    const(void)*        SyncRootIdentity;
    uint                SyncRootIdentityLength;
    long                FileId;
    long                FileSize;
    const(void)*        FileIdentity;
    uint                FileIdentityLength;
    const(PWSTR)        NormalizedPath;
    long                TransferKey;
    ubyte               PriorityHint;
    CORRELATION_VECTOR* CorrelationVector;
    CF_PROCESS_INFO*    ProcessInfo;
    long                RequestKey;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ns-cfapi-cf_callback_parameters
struct CF_CALLBACK_PARAMETERS
{
    uint ParamSize;
    union
    {
        struct Cancel
        {
            CF_CALLBACK_CANCEL_FLAGS Flags;
            union
            {
                struct FetchData
                {
                    long FileOffset;
                    long Length;
                }
            }
        }
        struct FetchData
        {
            CF_CALLBACK_FETCH_DATA_FLAGS Flags;
            long RequiredFileOffset;
            long RequiredLength;
            long OptionalFileOffset;
            long OptionalLength;
            long LastDehydrationTime;
            CF_CALLBACK_DEHYDRATION_REASON LastDehydrationReason;
        }
        struct ValidateData
        {
            CF_CALLBACK_VALIDATE_DATA_FLAGS Flags;
            long RequiredFileOffset;
            long RequiredLength;
        }
        struct FetchPlaceholders
        {
            CF_CALLBACK_FETCH_PLACEHOLDERS_FLAGS Flags;
            const(PWSTR) Pattern;
        }
        struct OpenCompletion
        {
            CF_CALLBACK_OPEN_COMPLETION_FLAGS Flags;
        }
        struct CloseCompletion
        {
            CF_CALLBACK_CLOSE_COMPLETION_FLAGS Flags;
        }
        struct Dehydrate
        {
            CF_CALLBACK_DEHYDRATE_FLAGS Flags;
            CF_CALLBACK_DEHYDRATION_REASON Reason;
        }
        struct DehydrateCompletion
        {
            CF_CALLBACK_DEHYDRATE_COMPLETION_FLAGS Flags;
            CF_CALLBACK_DEHYDRATION_REASON Reason;
        }
        struct Delete
        {
            CF_CALLBACK_DELETE_FLAGS Flags;
        }
        struct DeleteCompletion
        {
            CF_CALLBACK_DELETE_COMPLETION_FLAGS Flags;
        }
        struct Rename
        {
            CF_CALLBACK_RENAME_FLAGS Flags;
            const(PWSTR) TargetPath;
        }
        struct RenameCompletion
        {
            CF_CALLBACK_RENAME_COMPLETION_FLAGS Flags;
            const(PWSTR) SourcePath;
        }
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ns-cfapi-cf_callback_registration
struct CF_CALLBACK_REGISTRATION
{
    CF_CALLBACK_TYPE Type;
    CF_CALLBACK      Callback;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ns-cfapi-cf_sync_status
struct CF_SYNC_STATUS
{
    uint StructSize;
    uint Code;
    uint DescriptionOffset;
    uint DescriptionLength;
    uint DeviceIdOffset;
    uint DeviceIdLength;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ns-cfapi-cf_operation_info
struct CF_OPERATION_INFO
{
    uint              StructSize;
    CF_OPERATION_TYPE Type;
    CF_CONNECTION_KEY ConnectionKey;
    long              TransferKey;
    const(CORRELATION_VECTOR)* CorrelationVector;
    const(CF_SYNC_STATUS)* SyncStatus;
    long              RequestKey;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ns-cfapi-cf_operation_parameters
struct CF_OPERATION_PARAMETERS
{
    uint ParamSize;
    union
    {
        struct TransferData
        {
            CF_OPERATION_TRANSFER_DATA_FLAGS Flags;
            NTSTATUS     CompletionStatus;
            const(void)* Buffer;
            long         Offset;
            long         Length;
        }
        struct RetrieveData
        {
            CF_OPERATION_RETRIEVE_DATA_FLAGS Flags;
            void* Buffer;
            long  Offset;
            long  Length;
            long  ReturnedLength;
        }
        struct AckData
        {
            CF_OPERATION_ACK_DATA_FLAGS Flags;
            NTSTATUS CompletionStatus;
            long     Offset;
            long     Length;
        }
        struct RestartHydration
        {
            CF_OPERATION_RESTART_HYDRATION_FLAGS Flags;
            const(CF_FS_METADATA)* FsMetadata;
            const(void)* FileIdentity;
            uint         FileIdentityLength;
        }
        struct TransferPlaceholders
        {
            CF_OPERATION_TRANSFER_PLACEHOLDERS_FLAGS Flags;
            NTSTATUS CompletionStatus;
            long     PlaceholderTotalCount;
            CF_PLACEHOLDER_CREATE_INFO* PlaceholderArray;
            uint     PlaceholderCount;
            uint     EntriesProcessed;
        }
        struct AckDehydrate
        {
            CF_OPERATION_ACK_DEHYDRATE_FLAGS Flags;
            NTSTATUS     CompletionStatus;
            const(void)* FileIdentity;
            uint         FileIdentityLength;
        }
        struct AckRename
        {
            CF_OPERATION_ACK_RENAME_FLAGS Flags;
            NTSTATUS CompletionStatus;
        }
        struct AckDelete
        {
            CF_OPERATION_ACK_DELETE_FLAGS Flags;
            NTSTATUS CompletionStatus;
        }
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ns-cfapi-cf_file_range
struct CF_FILE_RANGE
{
    long StartingOffset;
    long Length;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ns-cfapi-cf_placeholder_basic_info
struct CF_PLACEHOLDER_BASIC_INFO
{
    CF_PIN_STATE     PinState;
    CF_IN_SYNC_STATE InSyncState;
    long             FileId;
    long             SyncRootFileId;
    uint             FileIdentityLength;
    ubyte[1]         FileIdentity; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ns-cfapi-cf_placeholder_standard_info
struct CF_PLACEHOLDER_STANDARD_INFO
{
    long             OnDiskDataSize;
    long             ValidatedDataSize;
    long             ModifiedDataSize;
    long             PropertiesSize;
    CF_PIN_STATE     PinState;
    CF_IN_SYNC_STATE InSyncState;
    long             FileId;
    long             SyncRootFileId;
    uint             FileIdentityLength;
    ubyte[1]         FileIdentity; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ns-cfapi-cf_sync_root_basic_info
struct CF_SYNC_ROOT_BASIC_INFO
{
    long SyncRootFileId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ns-cfapi-cf_sync_root_provider_info
struct CF_SYNC_ROOT_PROVIDER_INFO
{
    CF_SYNC_PROVIDER_STATUS ProviderStatus;
    wchar[256] ProviderName;
    wchar[256] ProviderVersion;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/ns-cfapi-cf_sync_root_standard_info
struct CF_SYNC_ROOT_STANDARD_INFO
{
    long                 SyncRootFileId;
    CF_HYDRATION_POLICY  HydrationPolicy;
    CF_POPULATION_POLICY PopulationPolicy;
    CF_INSYNC_POLICY     InSyncPolicy;
    CF_HARDLINK_POLICY   HardLinkPolicy;
    CF_SYNC_PROVIDER_STATUS ProviderStatus;
    wchar[256]           ProviderName;
    wchar[256]           ProviderVersion;
    uint                 SyncRootIdentityLength;
    ubyte[1]             SyncRootIdentity; // Flexible array
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("cldapi.dll")
HRESULT CfGetPlatformInfo(CF_PLATFORM_INFO* PlatformVersion);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("cldapi.dll")
HRESULT CfRegisterSyncRoot(const(PWSTR) SyncRootPath, const(CF_SYNC_REGISTRATION)* Registration, 
                           const(CF_SYNC_POLICIES)* Policies, CF_REGISTER_FLAGS RegisterFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("cldapi.dll")
HRESULT CfUnregisterSyncRoot(const(PWSTR) SyncRootPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("cldapi.dll")
HRESULT CfConnectSyncRoot(const(PWSTR) SyncRootPath, const(CF_CALLBACK_REGISTRATION)* CallbackTable, 
                          const(void)* CallbackContext, CF_CONNECT_FLAGS ConnectFlags, 
                          CF_CONNECTION_KEY* ConnectionKey);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("cldapi.dll")
HRESULT CfDisconnectSyncRoot(CF_CONNECTION_KEY ConnectionKey);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("cldapi.dll")
HRESULT CfGetTransferKey(HANDLE FileHandle, long* TransferKey);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("cldapi.dll")
void CfReleaseTransferKey(HANDLE FileHandle, long* TransferKey);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("cldapi.dll")
HRESULT CfExecute(const(CF_OPERATION_INFO)* OpInfo, CF_OPERATION_PARAMETERS* OpParams);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("cldapi.dll")
HRESULT CfUpdateSyncProviderStatus(CF_CONNECTION_KEY ConnectionKey, CF_SYNC_PROVIDER_STATUS ProviderStatus);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("cldapi.dll")
HRESULT CfQuerySyncProviderStatus(CF_CONNECTION_KEY ConnectionKey, CF_SYNC_PROVIDER_STATUS* ProviderStatus);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17134))], [])
@DllImport("cldapi.dll")
HRESULT CfReportSyncStatus(const(PWSTR) SyncRootPath, CF_SYNC_STATUS* SyncStatus);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("cldapi.dll")
HRESULT CfCreatePlaceholders(const(PWSTR) BaseDirectoryPath, CF_PLACEHOLDER_CREATE_INFO* PlaceholderArray, 
                             uint PlaceholderCount, CF_CREATE_FLAGS CreateFlags, uint* EntriesProcessed);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("cldapi.dll")
HRESULT CfOpenFileWithOplock(const(PWSTR) FilePath, CF_OPEN_FILE_FLAGS Flags, 
                             /*PARAM ATTR: RAIIFreeAttribute : CustomAttributeSig([FixedArgSig(ElementSig(CfCloseHandle))], [])*/HANDLE* ProtectedHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("cldapi.dll")
BOOLEAN CfReferenceProtectedHandle(HANDLE ProtectedHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("cldapi.dll")
HANDLE CfGetWin32HandleFromProtectedHandle(HANDLE ProtectedHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("cldapi.dll")
void CfReleaseProtectedHandle(HANDLE ProtectedHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("cldapi.dll")
void CfCloseHandle(HANDLE FileHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("cldapi.dll")
HRESULT CfConvertToPlaceholder(HANDLE FileHandle, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(void)* FileIdentity, 
                               uint FileIdentityLength, CF_CONVERT_FLAGS ConvertFlags, long* ConvertUsn, 
                               OVERLAPPED* Overlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("cldapi.dll")
HRESULT CfUpdatePlaceholder(HANDLE FileHandle, const(CF_FS_METADATA)* FsMetadata, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/const(void)* FileIdentity, 
                            uint FileIdentityLength, const(CF_FILE_RANGE)* DehydrateRangeArray, 
                            uint DehydrateRangeCount, CF_UPDATE_FLAGS UpdateFlags, long* UpdateUsn, 
                            OVERLAPPED* Overlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("cldapi.dll")
HRESULT CfRevertPlaceholder(HANDLE FileHandle, CF_REVERT_FLAGS RevertFlags, OVERLAPPED* Overlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("cldapi.dll")
HRESULT CfHydratePlaceholder(HANDLE FileHandle, long StartingOffset, long Length, CF_HYDRATE_FLAGS HydrateFlags, 
                             OVERLAPPED* Overlapped);

@DllImport("cldapi.dll")
HRESULT CfDehydratePlaceholder(HANDLE FileHandle, long StartingOffset, long Length, 
                               CF_DEHYDRATE_FLAGS DehydrateFlags, OVERLAPPED* Overlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("cldapi.dll")
HRESULT CfSetPinState(HANDLE FileHandle, CF_PIN_STATE PinState, CF_SET_PIN_FLAGS PinFlags, OVERLAPPED* Overlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("cldapi.dll")
HRESULT CfSetInSyncState(HANDLE FileHandle, CF_IN_SYNC_STATE InSyncState, CF_SET_IN_SYNC_FLAGS InSyncFlags, 
                         long* InSyncUsn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("cldapi.dll")
HRESULT CfSetCorrelationVector(HANDLE FileHandle, const(CORRELATION_VECTOR)* CorrelationVector);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("cldapi.dll")
HRESULT CfGetCorrelationVector(HANDLE FileHandle, CORRELATION_VECTOR* CorrelationVector);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("cldapi.dll")
CF_PLACEHOLDER_STATE CfGetPlaceholderStateFromAttributeTag(uint FileAttributes, uint ReparseTag);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("cldapi.dll")
CF_PLACEHOLDER_STATE CfGetPlaceholderStateFromFileInfo(const(void)* InfoBuffer, 
                                                       FILE_INFO_BY_HANDLE_CLASS InfoClass);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("cldapi.dll")
CF_PLACEHOLDER_STATE CfGetPlaceholderStateFromFindData(const(WIN32_FIND_DATAA)* FindData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("cldapi.dll")
HRESULT CfGetPlaceholderInfo(HANDLE FileHandle, CF_PLACEHOLDER_INFO_CLASS InfoClass, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* InfoBuffer, 
                             uint InfoBufferLength, uint* ReturnedLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("cldapi.dll")
HRESULT CfGetSyncRootInfoByPath(const(PWSTR) FilePath, CF_SYNC_ROOT_INFO_CLASS InfoClass, void* InfoBuffer, 
                                uint InfoBufferLength, uint* ReturnedLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("cldapi.dll")
HRESULT CfGetSyncRootInfoByHandle(HANDLE FileHandle, CF_SYNC_ROOT_INFO_CLASS InfoClass, void* InfoBuffer, 
                                  uint InfoBufferLength, uint* ReturnedLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("cldapi.dll")
HRESULT CfGetPlaceholderRangeInfo(HANDLE FileHandle, CF_PLACEHOLDER_RANGE_INFO_CLASS InfoClass, 
                                  long StartingOffset, long Length, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* InfoBuffer, 
                                  uint InfoBufferLength, uint* ReturnedLength);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/nf-cfapi-cfgetplaceholderrangeinfoforhydration
@DllImport("cldapi.dll")
HRESULT CfGetPlaceholderRangeInfoForHydration(CF_CONNECTION_KEY ConnectionKey, long TransferKey, long FileId, 
                                              CF_PLACEHOLDER_RANGE_INFO_CLASS InfoClass, long StartingOffset, 
                                              long RangeLength, 
                                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(7)))])*/void* InfoBuffer, 
                                              uint InfoBufferSize, uint* InfoBufferWritten);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("cldapi.dll")
HRESULT CfReportProviderProgress(CF_CONNECTION_KEY ConnectionKey, long TransferKey, long ProviderProgressTotal, 
                                 long ProviderProgressCompleted);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cfapi/nf-cfapi-cfreportproviderprogress2
@DllImport("cldapi.dll")
HRESULT CfReportProviderProgress2(CF_CONNECTION_KEY ConnectionKey, long TransferKey, long RequestKey, 
                                  long ProviderProgressTotal, long ProviderProgressCompleted, uint TargetSessionId);


