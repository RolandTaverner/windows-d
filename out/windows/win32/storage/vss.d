// Written in the D programming language.

module windows.win32.storage.vss;

public import windows.core;
public import system.system : Guid;
public import windows.win32.data.xml.msxml : IXMLDOMDocument;
public import windows.win32.foundation.foundation : BOOL, BSTR, FILETIME, HRESULT, PWSTR;
public import windows.win32.storage.virtualdiskservice : VDS_LUN_INFORMATION;
public import windows.win32.system.com.com : IUnknown;
public import windows.win32.system.variant : VARIANT;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vss/ne-vss-vss_object_type
alias VSS_OBJECT_TYPE = int;
enum : int
{
    VSS_OBJECT_UNKNOWN      = 0x00000000,
    VSS_OBJECT_NONE         = 0x00000001,
    VSS_OBJECT_SNAPSHOT_SET = 0x00000002,
    VSS_OBJECT_SNAPSHOT     = 0x00000003,
    VSS_OBJECT_PROVIDER     = 0x00000004,
    VSS_OBJECT_TYPE_COUNT   = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vss/ne-vss-vss_snapshot_state
alias VSS_SNAPSHOT_STATE = int;
enum : int
{
    VSS_SS_UNKNOWN                    = 0x00000000,
    VSS_SS_PREPARING                  = 0x00000001,
    VSS_SS_PROCESSING_PREPARE         = 0x00000002,
    VSS_SS_PREPARED                   = 0x00000003,
    VSS_SS_PROCESSING_PRECOMMIT       = 0x00000004,
    VSS_SS_PRECOMMITTED               = 0x00000005,
    VSS_SS_PROCESSING_COMMIT          = 0x00000006,
    VSS_SS_COMMITTED                  = 0x00000007,
    VSS_SS_PROCESSING_POSTCOMMIT      = 0x00000008,
    VSS_SS_PROCESSING_PREFINALCOMMIT  = 0x00000009,
    VSS_SS_PREFINALCOMMITTED          = 0x0000000a,
    VSS_SS_PROCESSING_POSTFINALCOMMIT = 0x0000000b,
    VSS_SS_CREATED                    = 0x0000000c,
    VSS_SS_ABORTED                    = 0x0000000d,
    VSS_SS_DELETED                    = 0x0000000e,
    VSS_SS_POSTCOMMITTED              = 0x0000000f,
    VSS_SS_COUNT                      = 0x00000010,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vss/ne-vss-vss_volume_snapshot_attributes
alias VSS_VOLUME_SNAPSHOT_ATTRIBUTES = int;
enum : int
{
    VSS_VOLSNAP_ATTR_PERSISTENT           = 0x00000001,
    VSS_VOLSNAP_ATTR_NO_AUTORECOVERY      = 0x00000002,
    VSS_VOLSNAP_ATTR_CLIENT_ACCESSIBLE    = 0x00000004,
    VSS_VOLSNAP_ATTR_NO_AUTO_RELEASE      = 0x00000008,
    VSS_VOLSNAP_ATTR_NO_WRITERS           = 0x00000010,
    VSS_VOLSNAP_ATTR_TRANSPORTABLE        = 0x00000020,
    VSS_VOLSNAP_ATTR_NOT_SURFACED         = 0x00000040,
    VSS_VOLSNAP_ATTR_NOT_TRANSACTED       = 0x00000080,
    VSS_VOLSNAP_ATTR_HARDWARE_ASSISTED    = 0x00010000,
    VSS_VOLSNAP_ATTR_DIFFERENTIAL         = 0x00020000,
    VSS_VOLSNAP_ATTR_PLEX                 = 0x00040000,
    VSS_VOLSNAP_ATTR_IMPORTED             = 0x00080000,
    VSS_VOLSNAP_ATTR_EXPOSED_LOCALLY      = 0x00100000,
    VSS_VOLSNAP_ATTR_EXPOSED_REMOTELY     = 0x00200000,
    VSS_VOLSNAP_ATTR_AUTORECOVER          = 0x00400000,
    VSS_VOLSNAP_ATTR_ROLLBACK_RECOVERY    = 0x00800000,
    VSS_VOLSNAP_ATTR_DELAYED_POSTSNAPSHOT = 0x01000000,
    VSS_VOLSNAP_ATTR_TXF_RECOVERY         = 0x02000000,
    VSS_VOLSNAP_ATTR_FILE_SHARE           = 0x04000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vss/ne-vss-vss_snapshot_context
alias VSS_SNAPSHOT_CONTEXT = int;
enum : int
{
    VSS_CTX_BACKUP                    = 0x00000000,
    VSS_CTX_FILE_SHARE_BACKUP         = 0x00000010,
    VSS_CTX_NAS_ROLLBACK              = 0x00000019,
    VSS_CTX_APP_ROLLBACK              = 0x00000009,
    VSS_CTX_CLIENT_ACCESSIBLE         = 0x0000001d,
    VSS_CTX_CLIENT_ACCESSIBLE_WRITERS = 0x0000000d,
    VSS_CTX_ALL                       = 0xffffffff,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vss/ne-vss-vss_provider_capabilities
alias VSS_PROVIDER_CAPABILITIES = int;
enum : int
{
    VSS_PRV_CAPABILITY_LEGACY           = 0x00000001,
    VSS_PRV_CAPABILITY_COMPLIANT        = 0x00000002,
    VSS_PRV_CAPABILITY_LUN_REPOINT      = 0x00000004,
    VSS_PRV_CAPABILITY_LUN_RESYNC       = 0x00000008,
    VSS_PRV_CAPABILITY_OFFLINE_CREATION = 0x00000010,
    VSS_PRV_CAPABILITY_MULTIPLE_IMPORT  = 0x00000020,
    VSS_PRV_CAPABILITY_RECYCLING        = 0x00000040,
    VSS_PRV_CAPABILITY_PLEX             = 0x00000080,
    VSS_PRV_CAPABILITY_DIFFERENTIAL     = 0x00000100,
    VSS_PRV_CAPABILITY_CLUSTERED        = 0x00000200,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vss/ne-vss-vss_hardware_options
alias VSS_HARDWARE_OPTIONS = int;
enum : int
{
    VSS_BREAKEX_FLAG_MASK_LUNS                    = 0x00000001,
    VSS_BREAKEX_FLAG_MAKE_READ_WRITE              = 0x00000002,
    VSS_BREAKEX_FLAG_REVERT_IDENTITY_ALL          = 0x00000004,
    VSS_BREAKEX_FLAG_REVERT_IDENTITY_NONE         = 0x00000008,
    VSS_ONLUNSTATECHANGE_NOTIFY_READ_WRITE        = 0x00000100,
    VSS_ONLUNSTATECHANGE_NOTIFY_LUN_PRE_RECOVERY  = 0x00000200,
    VSS_ONLUNSTATECHANGE_NOTIFY_LUN_POST_RECOVERY = 0x00000400,
    VSS_ONLUNSTATECHANGE_DO_MASK_LUNS             = 0x00000800,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vss/ne-vss-vss_recovery_options
alias VSS_RECOVERY_OPTIONS = int;
enum : int
{
    VSS_RECOVERY_REVERT_IDENTITY_ALL = 0x00000100,
    VSS_RECOVERY_NO_VOLUME_CHECK     = 0x00000200,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vss/ne-vss-vss_writer_state
alias VSS_WRITER_STATE = int;
enum : int
{
    VSS_WS_UNKNOWN                     = 0x00000000,
    VSS_WS_STABLE                      = 0x00000001,
    VSS_WS_WAITING_FOR_FREEZE          = 0x00000002,
    VSS_WS_WAITING_FOR_THAW            = 0x00000003,
    VSS_WS_WAITING_FOR_POST_SNAPSHOT   = 0x00000004,
    VSS_WS_WAITING_FOR_BACKUP_COMPLETE = 0x00000005,
    VSS_WS_FAILED_AT_IDENTIFY          = 0x00000006,
    VSS_WS_FAILED_AT_PREPARE_BACKUP    = 0x00000007,
    VSS_WS_FAILED_AT_PREPARE_SNAPSHOT  = 0x00000008,
    VSS_WS_FAILED_AT_FREEZE            = 0x00000009,
    VSS_WS_FAILED_AT_THAW              = 0x0000000a,
    VSS_WS_FAILED_AT_POST_SNAPSHOT     = 0x0000000b,
    VSS_WS_FAILED_AT_BACKUP_COMPLETE   = 0x0000000c,
    VSS_WS_FAILED_AT_PRE_RESTORE       = 0x0000000d,
    VSS_WS_FAILED_AT_POST_RESTORE      = 0x0000000e,
    VSS_WS_FAILED_AT_BACKUPSHUTDOWN    = 0x0000000f,
    VSS_WS_COUNT                       = 0x00000010,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vss/ne-vss-vss_backup_type
alias VSS_BACKUP_TYPE = int;
enum : int
{
    VSS_BT_UNDEFINED    = 0x00000000,
    VSS_BT_FULL         = 0x00000001,
    VSS_BT_INCREMENTAL  = 0x00000002,
    VSS_BT_DIFFERENTIAL = 0x00000003,
    VSS_BT_LOG          = 0x00000004,
    VSS_BT_COPY         = 0x00000005,
    VSS_BT_OTHER        = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vss/ne-vss-vss_restore_type
alias VSS_RESTORE_TYPE = int;
enum : int
{
    VSS_RTYPE_UNDEFINED = 0x00000000,
    VSS_RTYPE_BY_COPY   = 0x00000001,
    VSS_RTYPE_IMPORT    = 0x00000002,
    VSS_RTYPE_OTHER     = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vss/ne-vss-vss_rollforward_type
alias VSS_ROLLFORWARD_TYPE = int;
enum : int
{
    VSS_RF_UNDEFINED = 0x00000000,
    VSS_RF_NONE      = 0x00000001,
    VSS_RF_ALL       = 0x00000002,
    VSS_RF_PARTIAL   = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vss/ne-vss-vss_provider_type
alias VSS_PROVIDER_TYPE = int;
enum : int
{
    VSS_PROV_UNKNOWN   = 0x00000000,
    VSS_PROV_SYSTEM    = 0x00000001,
    VSS_PROV_SOFTWARE  = 0x00000002,
    VSS_PROV_HARDWARE  = 0x00000003,
    VSS_PROV_FILESHARE = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vss/ne-vss-vss_application_level
alias VSS_APPLICATION_LEVEL = int;
enum : int
{
    VSS_APP_UNKNOWN   = 0x00000000,
    VSS_APP_SYSTEM    = 0x00000001,
    VSS_APP_BACK_END  = 0x00000002,
    VSS_APP_FRONT_END = 0x00000003,
    VSS_APP_SYSTEM_RM = 0x00000004,
    VSS_APP_AUTO      = 0xffffffff,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vss/ne-vss-vss_snapshot_compatibility
alias VSS_SNAPSHOT_COMPATIBILITY = int;
enum : int
{
    VSS_SC_DISABLE_DEFRAG       = 0x00000001,
    VSS_SC_DISABLE_CONTENTINDEX = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vss/ne-vss-vss_snapshot_property_id
alias VSS_SNAPSHOT_PROPERTY_ID = int;
enum : int
{
    VSS_SPROPID_UNKNOWN             = 0x00000000,
    VSS_SPROPID_SNAPSHOT_ID         = 0x00000001,
    VSS_SPROPID_SNAPSHOT_SET_ID     = 0x00000002,
    VSS_SPROPID_SNAPSHOTS_COUNT     = 0x00000003,
    VSS_SPROPID_SNAPSHOT_DEVICE     = 0x00000004,
    VSS_SPROPID_ORIGINAL_VOLUME     = 0x00000005,
    VSS_SPROPID_ORIGINATING_MACHINE = 0x00000006,
    VSS_SPROPID_SERVICE_MACHINE     = 0x00000007,
    VSS_SPROPID_EXPOSED_NAME        = 0x00000008,
    VSS_SPROPID_EXPOSED_PATH        = 0x00000009,
    VSS_SPROPID_PROVIDER_ID         = 0x0000000a,
    VSS_SPROPID_SNAPSHOT_ATTRIBUTES = 0x0000000b,
    VSS_SPROPID_CREATION_TIMESTAMP  = 0x0000000c,
    VSS_SPROPID_STATUS              = 0x0000000d,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vss/ne-vss-vss_file_spec_backup_type
alias VSS_FILE_SPEC_BACKUP_TYPE = int;
enum : int
{
    VSS_FSBT_FULL_BACKUP_REQUIRED           = 0x00000001,
    VSS_FSBT_DIFFERENTIAL_BACKUP_REQUIRED   = 0x00000002,
    VSS_FSBT_INCREMENTAL_BACKUP_REQUIRED    = 0x00000004,
    VSS_FSBT_LOG_BACKUP_REQUIRED            = 0x00000008,
    VSS_FSBT_FULL_SNAPSHOT_REQUIRED         = 0x00000100,
    VSS_FSBT_DIFFERENTIAL_SNAPSHOT_REQUIRED = 0x00000200,
    VSS_FSBT_INCREMENTAL_SNAPSHOT_REQUIRED  = 0x00000400,
    VSS_FSBT_LOG_SNAPSHOT_REQUIRED          = 0x00000800,
    VSS_FSBT_CREATED_DURING_BACKUP          = 0x00010000,
    VSS_FSBT_ALL_BACKUP_REQUIRED            = 0x0000000f,
    VSS_FSBT_ALL_SNAPSHOT_REQUIRED          = 0x00000f00,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vss/ne-vss-vss_backup_schema
alias VSS_BACKUP_SCHEMA = int;
enum : int
{
    VSS_BS_UNDEFINED                          = 0x00000000,
    VSS_BS_DIFFERENTIAL                       = 0x00000001,
    VSS_BS_INCREMENTAL                        = 0x00000002,
    VSS_BS_EXCLUSIVE_INCREMENTAL_DIFFERENTIAL = 0x00000004,
    VSS_BS_LOG                                = 0x00000008,
    VSS_BS_COPY                               = 0x00000010,
    VSS_BS_TIMESTAMPED                        = 0x00000020,
    VSS_BS_LAST_MODIFY                        = 0x00000040,
    VSS_BS_LSN                                = 0x00000080,
    VSS_BS_WRITER_SUPPORTS_NEW_TARGET         = 0x00000100,
    VSS_BS_WRITER_SUPPORTS_RESTORE_WITH_MOVE  = 0x00000200,
    VSS_BS_INDEPENDENT_SYSTEM_STATE           = 0x00000400,
    VSS_BS_ROLLFORWARD_RESTORE                = 0x00001000,
    VSS_BS_RESTORE_RENAME                     = 0x00002000,
    VSS_BS_AUTHORITATIVE_RESTORE              = 0x00004000,
    VSS_BS_WRITER_SUPPORTS_PARALLEL_RESTORES  = 0x00008000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/ne-vswriter-vss_usage_type
alias VSS_USAGE_TYPE = int;
enum : int
{
    VSS_UT_UNDEFINED           = 0x00000000,
    VSS_UT_BOOTABLESYSTEMSTATE = 0x00000001,
    VSS_UT_SYSTEMSERVICE       = 0x00000002,
    VSS_UT_USERDATA            = 0x00000003,
    VSS_UT_OTHER               = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/ne-vswriter-vss_source_type
alias VSS_SOURCE_TYPE = int;
enum : int
{
    VSS_ST_UNDEFINED       = 0x00000000,
    VSS_ST_TRANSACTEDDB    = 0x00000001,
    VSS_ST_NONTRANSACTEDDB = 0x00000002,
    VSS_ST_OTHER           = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/ne-vswriter-vss_restoremethod_enum
alias VSS_RESTOREMETHOD_ENUM = int;
enum : int
{
    VSS_RME_UNDEFINED                           = 0x00000000,
    VSS_RME_RESTORE_IF_NOT_THERE                = 0x00000001,
    VSS_RME_RESTORE_IF_CAN_REPLACE              = 0x00000002,
    VSS_RME_STOP_RESTORE_START                  = 0x00000003,
    VSS_RME_RESTORE_TO_ALTERNATE_LOCATION       = 0x00000004,
    VSS_RME_RESTORE_AT_REBOOT                   = 0x00000005,
    VSS_RME_RESTORE_AT_REBOOT_IF_CANNOT_REPLACE = 0x00000006,
    VSS_RME_CUSTOM                              = 0x00000007,
    VSS_RME_RESTORE_STOP_START                  = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/ne-vswriter-vss_writerrestore_enum
alias VSS_WRITERRESTORE_ENUM = int;
enum : int
{
    VSS_WRE_UNDEFINED        = 0x00000000,
    VSS_WRE_NEVER            = 0x00000001,
    VSS_WRE_IF_REPLACE_FAILS = 0x00000002,
    VSS_WRE_ALWAYS           = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/ne-vswriter-vss_component_type
alias VSS_COMPONENT_TYPE = int;
enum : int
{
    VSS_CT_UNDEFINED = 0x00000000,
    VSS_CT_DATABASE  = 0x00000001,
    VSS_CT_FILEGROUP = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/ne-vswriter-vss_alternate_writer_state
alias VSS_ALTERNATE_WRITER_STATE = int;
enum : int
{
    VSS_AWS_UNDEFINED                = 0x00000000,
    VSS_AWS_NO_ALTERNATE_WRITER      = 0x00000001,
    VSS_AWS_ALTERNATE_WRITER_EXISTS  = 0x00000002,
    VSS_AWS_THIS_IS_ALTERNATE_WRITER = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/ne-vswriter-vss_subscribe_mask
alias VSS_SUBSCRIBE_MASK = int;
enum : int
{
    VSS_SM_POST_SNAPSHOT_FLAG  = 0x00000001,
    VSS_SM_BACKUP_EVENTS_FLAG  = 0x00000002,
    VSS_SM_RESTORE_EVENTS_FLAG = 0x00000004,
    VSS_SM_IO_THROTTLING_FLAG  = 0x00000008,
    VSS_SM_ALL_FLAGS           = 0xffffffff,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/ne-vswriter-vss_restore_target
alias VSS_RESTORE_TARGET = int;
enum : int
{
    VSS_RT_UNDEFINED         = 0x00000000,
    VSS_RT_ORIGINAL          = 0x00000001,
    VSS_RT_ALTERNATE         = 0x00000002,
    VSS_RT_DIRECTED          = 0x00000003,
    VSS_RT_ORIGINAL_LOCATION = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/ne-vswriter-vss_file_restore_status
alias VSS_FILE_RESTORE_STATUS = int;
enum : int
{
    VSS_RS_UNDEFINED = 0x00000000,
    VSS_RS_NONE      = 0x00000001,
    VSS_RS_ALL       = 0x00000002,
    VSS_RS_FAILED    = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/ne-vswriter-vss_component_flags
alias VSS_COMPONENT_FLAGS = int;
enum : int
{
    VSS_CF_BACKUP_RECOVERY       = 0x00000001,
    VSS_CF_APP_ROLLBACK_RECOVERY = 0x00000002,
    VSS_CF_NOT_SYSTEM_STATE      = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsmgmt/ne-vsmgmt-vss_mgmt_object_type
alias VSS_MGMT_OBJECT_TYPE = int;
enum : int
{
    VSS_MGMT_OBJECT_UNKNOWN     = 0x00000000,
    VSS_MGMT_OBJECT_VOLUME      = 0x00000001,
    VSS_MGMT_OBJECT_DIFF_VOLUME = 0x00000002,
    VSS_MGMT_OBJECT_DIFF_AREA   = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsmgmt/ne-vsmgmt-vss_protection_level
alias VSS_PROTECTION_LEVEL = int;
enum : int
{
    VSS_PROTECTION_LEVEL_ORIGINAL_VOLUME = 0x00000000,
    VSS_PROTECTION_LEVEL_SNAPSHOT        = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsmgmt/ne-vsmgmt-vss_protection_fault
alias VSS_PROTECTION_FAULT = int;
enum : int
{
    VSS_PROTECTION_FAULT_NONE                         = 0x00000000,
    VSS_PROTECTION_FAULT_DIFF_AREA_MISSING            = 0x00000001,
    VSS_PROTECTION_FAULT_IO_FAILURE_DURING_ONLINE     = 0x00000002,
    VSS_PROTECTION_FAULT_META_DATA_CORRUPTION         = 0x00000003,
    VSS_PROTECTION_FAULT_MEMORY_ALLOCATION_FAILURE    = 0x00000004,
    VSS_PROTECTION_FAULT_MAPPED_MEMORY_FAILURE        = 0x00000005,
    VSS_PROTECTION_FAULT_COW_READ_FAILURE             = 0x00000006,
    VSS_PROTECTION_FAULT_COW_WRITE_FAILURE            = 0x00000007,
    VSS_PROTECTION_FAULT_DIFF_AREA_FULL               = 0x00000008,
    VSS_PROTECTION_FAULT_GROW_TOO_SLOW                = 0x00000009,
    VSS_PROTECTION_FAULT_GROW_FAILED                  = 0x0000000a,
    VSS_PROTECTION_FAULT_DESTROY_ALL_SNAPSHOTS        = 0x0000000b,
    VSS_PROTECTION_FAULT_FILE_SYSTEM_FAILURE          = 0x0000000c,
    VSS_PROTECTION_FAULT_IO_FAILURE                   = 0x0000000d,
    VSS_PROTECTION_FAULT_DIFF_AREA_REMOVED            = 0x0000000e,
    VSS_PROTECTION_FAULT_EXTERNAL_WRITER_TO_DIFF_AREA = 0x0000000f,
    VSS_PROTECTION_FAULT_MOUNT_DURING_CLUSTER_OFFLINE = 0x00000010,
}

// Constants


enum int VSS_ASSOC_NO_MAX_SPACE = 0xffffffff;
enum uint VSS_ASSOC_REMOVE = 0x00000000U;
enum HRESULT VSS_E_BAD_STATE = HRESULT(0x80042301);
enum HRESULT VSS_E_UNEXPECTED = HRESULT(0x80042302);

enum : HRESULT
{
    VSS_E_PROVIDER_ALREADY_REGISTERED = HRESULT(0x80042303),
    VSS_E_PROVIDER_NOT_REGISTERED     = HRESULT(0x80042304),
    VSS_E_PROVIDER_VETO               = HRESULT(0x80042306),
    VSS_E_PROVIDER_IN_USE             = HRESULT(0x80042307),
}

enum HRESULT VSS_E_OBJECT_NOT_FOUND = HRESULT(0x80042308);

enum : HRESULT
{
    VSS_S_ASYNC_PENDING   = HRESULT(0x00042309),
    VSS_S_ASYNC_FINISHED  = HRESULT(0x0004230a),
    VSS_S_ASYNC_CANCELLED = HRESULT(0x0004230b),
}

enum : HRESULT
{
    VSS_E_VOLUME_NOT_SUPPORTED             = HRESULT(0x8004230c),
    VSS_E_VOLUME_NOT_SUPPORTED_BY_PROVIDER = HRESULT(0x8004230e),
}

enum HRESULT VSS_E_OBJECT_ALREADY_EXISTS = HRESULT(0x8004230d);
enum HRESULT VSS_E_UNEXPECTED_PROVIDER_ERROR = HRESULT(0x8004230f);
enum HRESULT VSS_E_CORRUPT_XML_DOCUMENT = HRESULT(0x80042310);
enum HRESULT VSS_E_INVALID_XML_DOCUMENT = HRESULT(0x80042311);
enum HRESULT VSS_E_MAXIMUM_NUMBER_OF_VOLUMES_REACHED = HRESULT(0x80042312);
enum HRESULT VSS_E_FLUSH_WRITES_TIMEOUT = HRESULT(0x80042313);
enum HRESULT VSS_E_HOLD_WRITES_TIMEOUT = HRESULT(0x80042314);
enum HRESULT VSS_E_UNEXPECTED_WRITER_ERROR = HRESULT(0x80042315);
enum HRESULT VSS_E_SNAPSHOT_SET_IN_PROGRESS = HRESULT(0x80042316);
enum HRESULT VSS_E_MAXIMUM_NUMBER_OF_SNAPSHOTS_REACHED = HRESULT(0x80042317);

enum : HRESULT
{
    VSS_E_WRITER_INFRASTRUCTURE     = HRESULT(0x80042318),
    VSS_E_WRITER_NOT_RESPONDING     = HRESULT(0x80042319),
    VSS_E_WRITER_ALREADY_SUBSCRIBED = HRESULT(0x8004231a),
}

enum HRESULT VSS_E_UNSUPPORTED_CONTEXT = HRESULT(0x8004231b);
enum HRESULT VSS_E_VOLUME_IN_USE = HRESULT(0x8004231d);
enum HRESULT VSS_E_MAXIMUM_DIFFAREA_ASSOCIATIONS_REACHED = HRESULT(0x8004231e);
enum HRESULT VSS_E_INSUFFICIENT_STORAGE = HRESULT(0x8004231f);
enum HRESULT VSS_E_NO_SNAPSHOTS_IMPORTED = HRESULT(0x80042320);
enum HRESULT VSS_S_SOME_SNAPSHOTS_NOT_IMPORTED = HRESULT(0x00042321);
enum HRESULT VSS_E_SOME_SNAPSHOTS_NOT_IMPORTED = HRESULT(0x80042321);
enum HRESULT VSS_E_MAXIMUM_NUMBER_OF_REMOTE_MACHINES_REACHED = HRESULT(0x80042322);

enum : HRESULT
{
    VSS_E_REMOTE_SERVER_UNAVAILABLE = HRESULT(0x80042323),
    VSS_E_REMOTE_SERVER_UNSUPPORTED = HRESULT(0x80042324),
}

enum : HRESULT
{
    VSS_E_REVERT_IN_PROGRESS = HRESULT(0x80042325),
    VSS_E_REVERT_VOLUME_LOST = HRESULT(0x80042326),
}

enum HRESULT VSS_E_REBOOT_REQUIRED = HRESULT(0x80042327);

enum : HRESULT
{
    VSS_E_TRANSACTION_FREEZE_TIMEOUT = HRESULT(0x80042328),
    VSS_E_TRANSACTION_THAW_TIMEOUT   = HRESULT(0x80042329),
}

enum HRESULT VSS_E_VOLUME_NOT_LOCAL = HRESULT(0x8004232d);
enum HRESULT VSS_E_CLUSTER_TIMEOUT = HRESULT(0x8004232e);

enum : HRESULT
{
    VSS_E_WRITERERROR_INCONSISTENTSNAPSHOT = HRESULT(0x800423f0),
    VSS_E_WRITERERROR_OUTOFRESOURCES       = HRESULT(0x800423f1),
    VSS_E_WRITERERROR_TIMEOUT              = HRESULT(0x800423f2),
    VSS_E_WRITERERROR_RETRYABLE            = HRESULT(0x800423f3),
    VSS_E_WRITERERROR_NONRETRYABLE         = HRESULT(0x800423f4),
    VSS_E_WRITERERROR_RECOVERY_FAILED      = HRESULT(0x800423f5),
}

enum HRESULT VSS_E_BREAK_REVERT_ID_FAILED = HRESULT(0x800423f6);
enum HRESULT VSS_E_LEGACY_PROVIDER = HRESULT(0x800423f7);

enum : HRESULT
{
    VSS_E_MISSING_DISK          = HRESULT(0x800423f8),
    VSS_E_MISSING_HIDDEN_VOLUME = HRESULT(0x800423f9),
    VSS_E_MISSING_VOLUME        = HRESULT(0x800423fa),
}

enum HRESULT VSS_E_AUTORECOVERY_FAILED = HRESULT(0x800423fb);
enum HRESULT VSS_E_DYNAMIC_DISK_ERROR = HRESULT(0x800423fc);
enum HRESULT VSS_E_NONTRANSPORTABLE_BCD = HRESULT(0x800423fd);
enum HRESULT VSS_E_CANNOT_REVERT_DISKID = HRESULT(0x800423fe);
enum HRESULT VSS_E_RESYNC_IN_PROGRESS = HRESULT(0x800423ff);
enum HRESULT VSS_E_CLUSTER_ERROR = HRESULT(0x80042400);
enum HRESULT VSS_E_UNSELECTED_VOLUME = HRESULT(0x8004232a);
enum HRESULT VSS_E_SNAPSHOT_NOT_IN_SET = HRESULT(0x8004232b);
enum HRESULT VSS_E_NESTED_VOLUME_LIMIT = HRESULT(0x8004232c);
enum HRESULT VSS_E_NOT_SUPPORTED = HRESULT(0x8004232f);
enum HRESULT VSS_E_WRITERERROR_PARTIAL_FAILURE = HRESULT(0x80042336);

enum : HRESULT
{
    VSS_E_ASRERROR_DISK_ASSIGNMENT_FAILED   = HRESULT(0x80042401),
    VSS_E_ASRERROR_DISK_RECREATION_FAILED   = HRESULT(0x80042402),
    VSS_E_ASRERROR_NO_ARCPATH               = HRESULT(0x80042403),
    VSS_E_ASRERROR_MISSING_DYNDISK          = HRESULT(0x80042404),
    VSS_E_ASRERROR_SHARED_CRIDISK           = HRESULT(0x80042405),
    VSS_E_ASRERROR_DATADISK_RDISK0          = HRESULT(0x80042406),
    VSS_E_ASRERROR_RDISK0_TOOSMALL          = HRESULT(0x80042407),
    VSS_E_ASRERROR_CRITICAL_DISKS_TOO_SMALL = HRESULT(0x80042408),
}

enum HRESULT VSS_E_WRITER_STATUS_NOT_AVAILABLE = HRESULT(0x80042409);
enum HRESULT VSS_E_ASRERROR_DYNAMIC_VHD_NOT_SUPPORTED = HRESULT(0x8004240a);
enum HRESULT VSS_E_CRITICAL_VOLUME_ON_INVALID_DISK = HRESULT(0x80042411);
enum HRESULT VSS_E_ASRERROR_RDISK_FOR_SYSTEM_DISK_NOT_FOUND = HRESULT(0x80042412);
enum HRESULT VSS_E_ASRERROR_NO_PHYSICAL_DISK_AVAILABLE = HRESULT(0x80042413);
enum HRESULT VSS_E_ASRERROR_FIXED_PHYSICAL_DISK_AVAILABLE_AFTER_DISK_EXCLUSION = HRESULT(0x80042414);
enum HRESULT VSS_E_ASRERROR_CRITICAL_DISK_CANNOT_BE_EXCLUDED = HRESULT(0x80042415);
enum HRESULT VSS_E_ASRERROR_SYSTEM_PARTITION_HIDDEN = HRESULT(0x80042416);
enum HRESULT VSS_E_FSS_TIMEOUT = HRESULT(0x80042417);

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vss/ns-vss-vss_snapshot_prop
struct VSS_SNAPSHOT_PROP
{
    GUID               m_SnapshotId;
    GUID               m_SnapshotSetId;
    int                m_lSnapshotsCount;
    ushort*            m_pwszSnapshotDeviceObject;
    ushort*            m_pwszOriginalVolumeName;
    ushort*            m_pwszOriginatingMachine;
    ushort*            m_pwszServiceMachine;
    ushort*            m_pwszExposedName;
    ushort*            m_pwszExposedPath;
    GUID               m_ProviderId;
    int                m_lSnapshotAttributes;
    long               m_tsCreationTimestamp;
    VSS_SNAPSHOT_STATE m_eStatus;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vss/ns-vss-vss_provider_prop
struct VSS_PROVIDER_PROP
{
    GUID              m_ProviderId;
    ushort*           m_pwszProviderName;
    VSS_PROVIDER_TYPE m_eProviderType;
    ushort*           m_pwszProviderVersion;
    GUID              m_ProviderVersionId;
    GUID              m_ClassId;
}

union VSS_OBJECT_UNION
{
    VSS_SNAPSHOT_PROP Snap;
    VSS_PROVIDER_PROP Prov;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vss/ns-vss-vss_object_prop
struct VSS_OBJECT_PROP
{
    VSS_OBJECT_TYPE  Type;
    VSS_OBJECT_UNION Obj;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsmgmt/ns-vsmgmt-vss_volume_prop
struct VSS_VOLUME_PROP
{
    ushort* m_pwszVolumeName;
    ushort* m_pwszVolumeDisplayName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsmgmt/ns-vsmgmt-vss_diff_volume_prop
struct VSS_DIFF_VOLUME_PROP
{
    ushort* m_pwszVolumeName;
    ushort* m_pwszVolumeDisplayName;
    long    m_llVolumeFreeSpace;
    long    m_llVolumeTotalSpace;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsmgmt/ns-vsmgmt-vss_diff_area_prop
struct VSS_DIFF_AREA_PROP
{
    ushort* m_pwszVolumeName;
    ushort* m_pwszDiffAreaVolumeName;
    long    m_llMaximumDiffSpace;
    long    m_llAllocatedDiffSpace;
    long    m_llUsedDiffSpace;
}

union VSS_MGMT_OBJECT_UNION
{
    VSS_VOLUME_PROP      Vol;
    VSS_DIFF_VOLUME_PROP DiffVol;
    VSS_DIFF_AREA_PROP   DiffArea;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsmgmt/ns-vsmgmt-vss_mgmt_object_prop
struct VSS_MGMT_OBJECT_PROP
{
    VSS_MGMT_OBJECT_TYPE Type;
    VSS_MGMT_OBJECT_UNION Obj;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsmgmt/ns-vsmgmt-vss_volume_protection_info
struct VSS_VOLUME_PROTECTION_INFO
{
    VSS_PROTECTION_LEVEL m_protectionLevel;
    BOOL                 m_volumeIsOfflineForProtection;
    VSS_PROTECTION_FAULT m_protectionFault;
    int                  m_failureStatus;
    BOOL                 m_volumeHasUnusedDiffArea;
    uint                 m_reserved;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("VSSAPI.dll")
HRESULT CreateVssExpressWriterInternal(IVssExpressWriter* ppWriter);


// Interfaces

@GUID("0b5a2c52-3eb9-470a-96e2-6c6d4570e40f")
struct VssSnapshotMgmt;

@GUID("e579ab5f-1cc4-44b4-bed9-de0991ff0623")
struct VSSCoordinator;

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vss/nn-vss-ivssenumobject
@GUID("ae1c7110-2f60-11d3-8a39-00c04f72d8e3")
interface IVssEnumObject : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vss/nf-vss-ivssenumobject-next
    HRESULT Next(uint celt, VSS_OBJECT_PROP* rgelt, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vss/nf-vss-ivssenumobject-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vss/nf-vss-ivssenumobject-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vss/nf-vss-ivssenumobject-clone
    HRESULT Clone(IVssEnumObject* ppenum);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vss/nn-vss-ivssasync
@GUID("507c37b4-cf5b-4e95-b0af-14eb9767467e")
interface IVssAsync : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vss/nf-vss-ivssasync-cancel
    HRESULT Cancel();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vss/nf-vss-ivssasync-wait
    HRESULT Wait(uint dwMilliseconds);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vss/nf-vss-ivssasync-querystatus
    HRESULT QueryStatus(HRESULT* pHrResult, int* pReserved);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nl-vswriter-ivsswmfiledesc
interface IVssWMFiledesc : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsswmfiledesc-getpath
    HRESULT GetPath(BSTR* pbstrPath);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsswmfiledesc-getfilespec
    HRESULT GetFilespec(BSTR* pbstrFilespec);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsswmfiledesc-getrecursive
    HRESULT GetRecursive(bool* pbRecursive);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsswmfiledesc-getalternatelocation
    HRESULT GetAlternateLocation(BSTR* pbstrAlternateLocation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsswmfiledesc-getbackuptypemask
    HRESULT GetBackupTypeMask(uint* pdwTypeMask);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nl-vswriter-ivsswmdependency
interface IVssWMDependency : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsswmdependency-getwriterid
    HRESULT GetWriterId(GUID* pWriterId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsswmdependency-getlogicalpath
    HRESULT GetLogicalPath(BSTR* pbstrLogicalPath);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsswmdependency-getcomponentname
    HRESULT GetComponentName(BSTR* pbstrComponentName);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nl-vswriter-ivsscomponent
@GUID("d2c72c96-c121-4518-b627-e5a93d010ead")
interface IVssComponent : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscomponent-getlogicalpath
    HRESULT GetLogicalPath(BSTR* pbstrPath);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscomponent-getcomponenttype
    HRESULT GetComponentType(VSS_COMPONENT_TYPE* pct);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscomponent-getcomponentname
    HRESULT GetComponentName(BSTR* pbstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscomponent-getbackupsucceeded
    HRESULT GetBackupSucceeded(bool* pbSucceeded);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscomponent-getalternatelocationmappingcount
    HRESULT GetAlternateLocationMappingCount(uint* pcMappings);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscomponent-getalternatelocationmapping
    HRESULT GetAlternateLocationMapping(uint iMapping, IVssWMFiledesc* ppFiledesc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscomponent-setbackupmetadata
    HRESULT SetBackupMetadata(const(PWSTR) wszData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscomponent-getbackupmetadata
    HRESULT GetBackupMetadata(BSTR* pbstrData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscomponent-addpartialfile
    HRESULT AddPartialFile(const(PWSTR) wszPath, const(PWSTR) wszFilename, const(PWSTR) wszRanges, 
                           const(PWSTR) wszMetadata);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscomponent-getpartialfilecount
    HRESULT GetPartialFileCount(uint* pcPartialFiles);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscomponent-getpartialfile
    HRESULT GetPartialFile(uint iPartialFile, BSTR* pbstrPath, BSTR* pbstrFilename, BSTR* pbstrRange, 
                           BSTR* pbstrMetadata);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscomponent-isselectedforrestore
    HRESULT IsSelectedForRestore(bool* pbSelectedForRestore);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscomponent-getadditionalrestores
    HRESULT GetAdditionalRestores(bool* pbAdditionalRestores);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscomponent-getnewtargetcount
    HRESULT GetNewTargetCount(uint* pcNewTarget);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscomponent-getnewtarget
    HRESULT GetNewTarget(uint iNewTarget, IVssWMFiledesc* ppFiledesc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscomponent-adddirectedtarget
    HRESULT AddDirectedTarget(const(PWSTR) wszSourcePath, const(PWSTR) wszSourceFilename, 
                              const(PWSTR) wszSourceRangeList, const(PWSTR) wszDestinationPath, 
                              const(PWSTR) wszDestinationFilename, const(PWSTR) wszDestinationRangeList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscomponent-getdirectedtargetcount
    HRESULT GetDirectedTargetCount(uint* pcDirectedTarget);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscomponent-getdirectedtarget
    HRESULT GetDirectedTarget(uint iDirectedTarget, BSTR* pbstrSourcePath, BSTR* pbstrSourceFileName, 
                              BSTR* pbstrSourceRangeList, BSTR* pbstrDestinationPath, BSTR* pbstrDestinationFilename, 
                              BSTR* pbstrDestinationRangeList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscomponent-setrestoremetadata
    HRESULT SetRestoreMetadata(const(PWSTR) wszRestoreMetadata);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscomponent-getrestoremetadata
    HRESULT GetRestoreMetadata(BSTR* pbstrRestoreMetadata);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscomponent-setrestoretarget
    HRESULT SetRestoreTarget(VSS_RESTORE_TARGET target);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscomponent-getrestoretarget
    HRESULT GetRestoreTarget(VSS_RESTORE_TARGET* pTarget);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscomponent-setprerestorefailuremsg
    HRESULT SetPreRestoreFailureMsg(const(PWSTR) wszPreRestoreFailureMsg);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscomponent-getprerestorefailuremsg
    HRESULT GetPreRestoreFailureMsg(BSTR* pbstrPreRestoreFailureMsg);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscomponent-setpostrestorefailuremsg
    HRESULT SetPostRestoreFailureMsg(const(PWSTR) wszPostRestoreFailureMsg);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscomponent-getpostrestorefailuremsg
    HRESULT GetPostRestoreFailureMsg(BSTR* pbstrPostRestoreFailureMsg);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscomponent-setbackupstamp
    HRESULT SetBackupStamp(const(PWSTR) wszBackupStamp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscomponent-getbackupstamp
    HRESULT GetBackupStamp(BSTR* pbstrBackupStamp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscomponent-getpreviousbackupstamp
    HRESULT GetPreviousBackupStamp(BSTR* pbstrBackupStamp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscomponent-getbackupoptions
    HRESULT GetBackupOptions(BSTR* pbstrBackupOptions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscomponent-getrestoreoptions
    HRESULT GetRestoreOptions(BSTR* pbstrRestoreOptions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscomponent-getrestoresubcomponentcount
    HRESULT GetRestoreSubcomponentCount(uint* pcRestoreSubcomponent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscomponent-getrestoresubcomponent
    HRESULT GetRestoreSubcomponent(uint iComponent, BSTR* pbstrLogicalPath, BSTR* pbstrComponentName, 
                                   bool* pbRepair);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscomponent-getfilerestorestatus
    HRESULT GetFileRestoreStatus(VSS_FILE_RESTORE_STATUS* pStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscomponent-adddifferencedfilesbylastmodifytime
    HRESULT AddDifferencedFilesByLastModifyTime(const(PWSTR) wszPath, const(PWSTR) wszFilespec, BOOL bRecursive, 
                                                FILETIME ftLastModifyTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscomponent-adddifferencedfilesbylastmodifylsn
    HRESULT AddDifferencedFilesByLastModifyLSN(const(PWSTR) wszPath, const(PWSTR) wszFilespec, BOOL bRecursive, 
                                               BSTR bstrLsnString);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscomponent-getdifferencedfilescount
    HRESULT GetDifferencedFilesCount(uint* pcDifferencedFiles);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscomponent-getdifferencedfile
    HRESULT GetDifferencedFile(uint iDifferencedFile, BSTR* pbstrPath, BSTR* pbstrFilespec, BOOL* pbRecursive, 
                               BSTR* pbstrLsnString, FILETIME* pftLastModifyTime);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nl-vswriter-ivsswritercomponents
interface IVssWriterComponents
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsswritercomponents-getcomponentcount
    HRESULT GetComponentCount(uint* pcComponents);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsswritercomponents-getwriterinfo
    HRESULT GetWriterInfo(GUID* pidInstance, GUID* pidWriter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsswritercomponents-getcomponent
    HRESULT GetComponent(uint iComponent, IVssComponent* ppComponent);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nl-vswriter-ivsscomponentex
@GUID("156c8b5e-f131-4bd7-9c97-d1923be7e1fa")
interface IVssComponentEx : IVssComponent
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscomponentex-setprepareforbackupfailuremsg
    HRESULT SetPrepareForBackupFailureMsg(const(PWSTR) wszFailureMsg);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscomponentex-setpostsnapshotfailuremsg
    HRESULT SetPostSnapshotFailureMsg(const(PWSTR) wszFailureMsg);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscomponentex-getprepareforbackupfailuremsg
    HRESULT GetPrepareForBackupFailureMsg(BSTR* pbstrFailureMsg);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscomponentex-getpostsnapshotfailuremsg
    HRESULT GetPostSnapshotFailureMsg(BSTR* pbstrFailureMsg);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscomponentex-getauthoritativerestore
    HRESULT GetAuthoritativeRestore(bool* pbAuth);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscomponentex-getrollforward
    HRESULT GetRollForward(VSS_ROLLFORWARD_TYPE* pRollType, BSTR* pbstrPoint);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscomponentex-getrestorename
    HRESULT GetRestoreName(BSTR* pbstrName);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nl-vswriter-ivsscomponentex2
@GUID("3b5be0f2-07a9-4e4b-bdd3-cfdc8e2c0d2d")
interface IVssComponentEx2 : IVssComponentEx
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscomponentex2-setfailure
    HRESULT SetFailure(HRESULT hr, HRESULT hrApplication, const(PWSTR) wszApplicationMessage, uint dwReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscomponentex2-getfailure
    HRESULT GetFailure(HRESULT* phr, HRESULT* phrApplication, BSTR* pbstrApplicationMessage, uint* pdwReserved);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nl-vswriter-ivsscreatewritermetadata
interface IVssCreateWriterMetadata
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscreatewritermetadata-addincludefiles
    HRESULT AddIncludeFiles(const(PWSTR) wszPath, const(PWSTR) wszFilespec, ubyte bRecursive, 
                            const(PWSTR) wszAlternateLocation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscreatewritermetadata-addexcludefiles
    HRESULT AddExcludeFiles(const(PWSTR) wszPath, const(PWSTR) wszFilespec, ubyte bRecursive);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscreatewritermetadata-addcomponent
    HRESULT AddComponent(VSS_COMPONENT_TYPE ct, const(PWSTR) wszLogicalPath, const(PWSTR) wszComponentName, 
                         const(PWSTR) wszCaption, const(ubyte)* pbIcon, uint cbIcon, ubyte bRestoreMetadata, 
                         ubyte bNotifyOnBackupComplete, ubyte bSelectable, ubyte bSelectableForRestore, 
                         uint dwComponentFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscreatewritermetadata-adddatabasefiles
    HRESULT AddDatabaseFiles(const(PWSTR) wszLogicalPath, const(PWSTR) wszDatabaseName, const(PWSTR) wszPath, 
                             const(PWSTR) wszFilespec, uint dwBackupTypeMask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscreatewritermetadata-adddatabaselogfiles
    HRESULT AddDatabaseLogFiles(const(PWSTR) wszLogicalPath, const(PWSTR) wszDatabaseName, const(PWSTR) wszPath, 
                                const(PWSTR) wszFilespec, uint dwBackupTypeMask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscreatewritermetadata-addfilestofilegroup
    HRESULT AddFilesToFileGroup(const(PWSTR) wszLogicalPath, const(PWSTR) wszGroupName, const(PWSTR) wszPath, 
                                const(PWSTR) wszFilespec, ubyte bRecursive, const(PWSTR) wszAlternateLocation, 
                                uint dwBackupTypeMask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscreatewritermetadata-setrestoremethod
    HRESULT SetRestoreMethod(VSS_RESTOREMETHOD_ENUM method, const(PWSTR) wszService, const(PWSTR) wszUserProcedure, 
                             VSS_WRITERRESTORE_ENUM writerRestore, ubyte bRebootRequired);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscreatewritermetadata-addalternatelocationmapping
    HRESULT AddAlternateLocationMapping(const(PWSTR) wszSourcePath, const(PWSTR) wszSourceFilespec, 
                                        ubyte bRecursive, const(PWSTR) wszDestination);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscreatewritermetadata-addcomponentdependency
    HRESULT AddComponentDependency(const(PWSTR) wszForLogicalPath, const(PWSTR) wszForComponentName, 
                                   GUID onWriterId, const(PWSTR) wszOnLogicalPath, const(PWSTR) wszOnComponentName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscreatewritermetadata-setbackupschema
    HRESULT SetBackupSchema(uint dwSchemaMask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscreatewritermetadata-getdocument
    HRESULT GetDocument(IXMLDOMDocument* pDoc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscreatewritermetadata-saveasxml
    HRESULT SaveAsXML(BSTR* pbstrXML);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nl-vswriter-ivsscreateexpresswritermetadata
@GUID("9c772e77-b26e-427f-92dd-c996f41ea5e3")
interface IVssCreateExpressWriterMetadata : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscreateexpresswritermetadata-addexcludefiles
    HRESULT AddExcludeFiles(const(PWSTR) wszPath, const(PWSTR) wszFilespec, ubyte bRecursive);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscreateexpresswritermetadata-addcomponent
    HRESULT AddComponent(VSS_COMPONENT_TYPE ct, const(PWSTR) wszLogicalPath, const(PWSTR) wszComponentName, 
                         const(PWSTR) wszCaption, const(ubyte)* pbIcon, uint cbIcon, ubyte bRestoreMetadata, 
                         ubyte bNotifyOnBackupComplete, ubyte bSelectable, ubyte bSelectableForRestore, 
                         uint dwComponentFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscreateexpresswritermetadata-addfilestofilegroup
    HRESULT AddFilesToFileGroup(const(PWSTR) wszLogicalPath, const(PWSTR) wszGroupName, const(PWSTR) wszPath, 
                                const(PWSTR) wszFilespec, ubyte bRecursive, const(PWSTR) wszAlternateLocation, 
                                uint dwBackupTypeMask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscreateexpresswritermetadata-setrestoremethod
    HRESULT SetRestoreMethod(VSS_RESTOREMETHOD_ENUM method, const(PWSTR) wszService, const(PWSTR) wszUserProcedure, 
                             VSS_WRITERRESTORE_ENUM writerRestore, ubyte bRebootRequired);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscreateexpresswritermetadata-addcomponentdependency
    HRESULT AddComponentDependency(const(PWSTR) wszForLogicalPath, const(PWSTR) wszForComponentName, 
                                   GUID onWriterId, const(PWSTR) wszOnLogicalPath, const(PWSTR) wszOnComponentName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscreateexpresswritermetadata-setbackupschema
    HRESULT SetBackupSchema(uint dwSchemaMask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivsscreateexpresswritermetadata-saveasxml
    HRESULT SaveAsXML(BSTR* pbstrXML);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nl-vswriter-ivssexpresswriter
@GUID("e33affdc-59c7-47b1-97d5-4266598f6235")
interface IVssExpressWriter : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivssexpresswriter-createmetadata
    HRESULT CreateMetadata(GUID writerId, const(PWSTR) writerName, VSS_USAGE_TYPE usageType, uint versionMajor, 
                           uint versionMinor, uint reserved, IVssCreateExpressWriterMetadata* ppMetadata);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivssexpresswriter-loadmetadata
    HRESULT LoadMetadata(const(PWSTR) metadata, uint reserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivssexpresswriter-register
    HRESULT Register();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vswriter/nf-vswriter-ivssexpresswriter-unregister
    HRESULT Unregister(GUID writerId);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsmgmt/nn-vsmgmt-ivsssnapshotmgmt
@GUID("fa7df749-66e7-4986-a27f-e2f04ae53772")
interface IVssSnapshotMgmt : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsmgmt/nf-vsmgmt-ivsssnapshotmgmt-getprovidermgmtinterface
    HRESULT GetProviderMgmtInterface(GUID ProviderId, const(GUID)* InterfaceId, IUnknown* ppItf);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsmgmt/nf-vsmgmt-ivsssnapshotmgmt-queryvolumessupportedforsnapshots
    HRESULT QueryVolumesSupportedForSnapshots(GUID ProviderId, int lContext, IVssEnumMgmtObject* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsmgmt/nf-vsmgmt-ivsssnapshotmgmt-querysnapshotsbyvolume
    HRESULT QuerySnapshotsByVolume(ushort* pwszVolumeName, GUID ProviderId, IVssEnumObject* ppEnum);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsmgmt/nn-vsmgmt-ivsssnapshotmgmt2
@GUID("0f61ec39-fe82-45f2-a3f0-768b5d427102")
interface IVssSnapshotMgmt2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsmgmt/nf-vsmgmt-ivsssnapshotmgmt2-getmindiffareasize
    HRESULT GetMinDiffAreaSize(long* pllMinDiffAreaSize);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsmgmt/nn-vsmgmt-ivssdifferentialsoftwaresnapshotmgmt
@GUID("214a0f28-b737-4026-b847-4f9e37d79529")
interface IVssDifferentialSoftwareSnapshotMgmt : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsmgmt/nf-vsmgmt-ivssdifferentialsoftwaresnapshotmgmt-adddiffarea
    HRESULT AddDiffArea(ushort* pwszVolumeName, ushort* pwszDiffAreaVolumeName, long llMaximumDiffSpace);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsmgmt/nf-vsmgmt-ivssdifferentialsoftwaresnapshotmgmt-changediffareamaximumsize
    HRESULT ChangeDiffAreaMaximumSize(ushort* pwszVolumeName, ushort* pwszDiffAreaVolumeName, 
                                      long llMaximumDiffSpace);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsmgmt/nf-vsmgmt-ivssdifferentialsoftwaresnapshotmgmt-queryvolumessupportedfordiffareas
    HRESULT QueryVolumesSupportedForDiffAreas(ushort* pwszOriginalVolumeName, IVssEnumMgmtObject* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsmgmt/nf-vsmgmt-ivssdifferentialsoftwaresnapshotmgmt-querydiffareasforvolume
    HRESULT QueryDiffAreasForVolume(ushort* pwszVolumeName, IVssEnumMgmtObject* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsmgmt/nf-vsmgmt-ivssdifferentialsoftwaresnapshotmgmt-querydiffareasonvolume
    HRESULT QueryDiffAreasOnVolume(ushort* pwszVolumeName, IVssEnumMgmtObject* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsmgmt/nf-vsmgmt-ivssdifferentialsoftwaresnapshotmgmt-querydiffareasforsnapshot
    HRESULT QueryDiffAreasForSnapshot(GUID SnapshotId, IVssEnumMgmtObject* ppEnum);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsmgmt/nn-vsmgmt-ivssdifferentialsoftwaresnapshotmgmt2
@GUID("949d7353-675f-4275-8969-f044c6277815")
interface IVssDifferentialSoftwareSnapshotMgmt2 : IVssDifferentialSoftwareSnapshotMgmt
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsmgmt/nf-vsmgmt-ivssdifferentialsoftwaresnapshotmgmt2-changediffareamaximumsizeex
    HRESULT ChangeDiffAreaMaximumSizeEx(ushort* pwszVolumeName, ushort* pwszDiffAreaVolumeName, 
                                        long llMaximumDiffSpace, BOOL bVolatile);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsmgmt/nf-vsmgmt-ivssdifferentialsoftwaresnapshotmgmt2-migratediffareas
    HRESULT MigrateDiffAreas(ushort* pwszVolumeName, ushort* pwszDiffAreaVolumeName, 
                             ushort* pwszNewDiffAreaVolumeName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsmgmt/nf-vsmgmt-ivssdifferentialsoftwaresnapshotmgmt2-querymigrationstatus
    HRESULT QueryMigrationStatus(ushort* pwszVolumeName, ushort* pwszDiffAreaVolumeName, IVssAsync* ppAsync);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsmgmt/nf-vsmgmt-ivssdifferentialsoftwaresnapshotmgmt2-setsnapshotpriority
    HRESULT SetSnapshotPriority(GUID idSnapshot, ubyte priority);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsmgmt/nn-vsmgmt-ivssdifferentialsoftwaresnapshotmgmt3
@GUID("383f7e71-a4c5-401f-b27f-f826289f8458")
interface IVssDifferentialSoftwareSnapshotMgmt3 : IVssDifferentialSoftwareSnapshotMgmt2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsmgmt/nf-vsmgmt-ivssdifferentialsoftwaresnapshotmgmt3-setvolumeprotectlevel
    HRESULT SetVolumeProtectLevel(ushort* pwszVolumeName, VSS_PROTECTION_LEVEL protectionLevel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsmgmt/nf-vsmgmt-ivssdifferentialsoftwaresnapshotmgmt3-getvolumeprotectlevel
    HRESULT GetVolumeProtectLevel(ushort* pwszVolumeName, VSS_VOLUME_PROTECTION_INFO* protectionLevel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsmgmt/nf-vsmgmt-ivssdifferentialsoftwaresnapshotmgmt3-clearvolumeprotectfault
    HRESULT ClearVolumeProtectFault(ushort* pwszVolumeName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsmgmt/nf-vsmgmt-ivssdifferentialsoftwaresnapshotmgmt3-deleteunuseddiffareas
    HRESULT DeleteUnusedDiffAreas(ushort* pwszDiffAreaVolumeName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsmgmt/nf-vsmgmt-ivssdifferentialsoftwaresnapshotmgmt3-querysnapshotdeltabitmap
    HRESULT QuerySnapshotDeltaBitmap(GUID idSnapshotOlder, GUID idSnapshotYounger, uint* pcBlockSizePerBit, 
                                     uint* pcBitmapLength, ubyte** ppbBitmap);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsmgmt/nn-vsmgmt-ivssenummgmtobject
@GUID("01954e6b-9254-4e6e-808c-c9e05d007696")
interface IVssEnumMgmtObject : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsmgmt/nf-vsmgmt-ivssenummgmtobject-next
    HRESULT Next(uint celt, VSS_MGMT_OBJECT_PROP* rgelt, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsmgmt/nf-vsmgmt-ivssenummgmtobject-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsmgmt/nf-vsmgmt-ivssenummgmtobject-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsmgmt/nf-vsmgmt-ivssenummgmtobject-clone
    HRESULT Clone(IVssEnumMgmtObject* ppenum);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsadmin/nn-vsadmin-ivssadmin
@GUID("77ed5996-2f63-11d3-8a39-00c04f72d8e3")
interface IVssAdmin : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsadmin/nf-vsadmin-ivssadmin-registerprovider
    HRESULT RegisterProvider(GUID pProviderId, GUID ClassId, ushort* pwszProviderName, 
                             VSS_PROVIDER_TYPE eProviderType, ushort* pwszProviderVersion, GUID ProviderVersionId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsadmin/nf-vsadmin-ivssadmin-unregisterprovider
    HRESULT UnregisterProvider(GUID ProviderId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsadmin/nf-vsadmin-ivssadmin-queryproviders
    HRESULT QueryProviders(IVssEnumObject* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsadmin/nf-vsadmin-ivssadmin-abortallsnapshotsinprogress
    HRESULT AbortAllSnapshotsInProgress();
}

@GUID("7858a9f8-b1fa-41a6-964f-b9b36b8cd8d8")
interface IVssAdminEx : IVssAdmin
{
    HRESULT GetProviderCapability(GUID pProviderId, ulong* pllOriginalCapabilityMask);
    HRESULT GetProviderContext(GUID ProviderId, int* plContext);
    HRESULT SetProviderContext(GUID ProviderId, int lContext);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsprov/nn-vsprov-ivsssoftwaresnapshotprovider
@GUID("609e123e-2c5a-44d3-8f01-0b1d9a47d1ff")
interface IVssSoftwareSnapshotProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsprov/nf-vsprov-ivsssoftwaresnapshotprovider-setcontext
    HRESULT SetContext(int lContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsprov/nf-vsprov-ivsssoftwaresnapshotprovider-getsnapshotproperties
    HRESULT GetSnapshotProperties(GUID SnapshotId, VSS_SNAPSHOT_PROP* pProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsprov/nf-vsprov-ivsssoftwaresnapshotprovider-query
    HRESULT Query(GUID QueriedObjectId, VSS_OBJECT_TYPE eQueriedObjectType, VSS_OBJECT_TYPE eReturnedObjectsType, 
                  IVssEnumObject* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsprov/nf-vsprov-ivsssoftwaresnapshotprovider-deletesnapshots
    HRESULT DeleteSnapshots(GUID SourceObjectId, VSS_OBJECT_TYPE eSourceObjectType, BOOL bForceDelete, 
                            int* plDeletedSnapshots, GUID* pNondeletedSnapshotID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsprov/nf-vsprov-ivsssoftwaresnapshotprovider-beginpreparesnapshot
    HRESULT BeginPrepareSnapshot(GUID SnapshotSetId, GUID SnapshotId, ushort* pwszVolumeName, int lNewContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsprov/nf-vsprov-ivsssoftwaresnapshotprovider-isvolumesupported
    HRESULT IsVolumeSupported(ushort* pwszVolumeName, BOOL* pbSupportedByThisProvider);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsprov/nf-vsprov-ivsssoftwaresnapshotprovider-isvolumesnapshotted
    HRESULT IsVolumeSnapshotted(ushort* pwszVolumeName, BOOL* pbSnapshotsPresent, int* plSnapshotCompatibility);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsprov/nf-vsprov-ivsssoftwaresnapshotprovider-setsnapshotproperty
    HRESULT SetSnapshotProperty(GUID SnapshotId, VSS_SNAPSHOT_PROPERTY_ID eSnapshotPropertyId, VARIANT vProperty);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsprov/nf-vsprov-ivsssoftwaresnapshotprovider-reverttosnapshot
    HRESULT RevertToSnapshot(GUID SnapshotId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsprov/nf-vsprov-ivsssoftwaresnapshotprovider-queryrevertstatus
    HRESULT QueryRevertStatus(ushort* pwszVolume, IVssAsync* ppAsync);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsprov/nn-vsprov-ivssprovidercreatesnapshotset
@GUID("5f894e5b-1e39-4778-8e23-9abad9f0e08c")
interface IVssProviderCreateSnapshotSet : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsprov/nf-vsprov-ivssprovidercreatesnapshotset-endpreparesnapshots
    HRESULT EndPrepareSnapshots(GUID SnapshotSetId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsprov/nf-vsprov-ivssprovidercreatesnapshotset-precommitsnapshots
    HRESULT PreCommitSnapshots(GUID SnapshotSetId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsprov/nf-vsprov-ivssprovidercreatesnapshotset-commitsnapshots
    HRESULT CommitSnapshots(GUID SnapshotSetId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsprov/nf-vsprov-ivssprovidercreatesnapshotset-postcommitsnapshots
    HRESULT PostCommitSnapshots(GUID SnapshotSetId, int lSnapshotsCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsprov/nf-vsprov-ivssprovidercreatesnapshotset-prefinalcommitsnapshots
    HRESULT PreFinalCommitSnapshots(GUID SnapshotSetId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsprov/nf-vsprov-ivssprovidercreatesnapshotset-postfinalcommitsnapshots
    HRESULT PostFinalCommitSnapshots(GUID SnapshotSetId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsprov/nf-vsprov-ivssprovidercreatesnapshotset-abortsnapshots
    HRESULT AbortSnapshots(GUID SnapshotSetId);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsprov/nn-vsprov-ivssprovidernotifications
@GUID("e561901f-03a5-4afe-86d0-72baeece7004")
interface IVssProviderNotifications : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsprov/nf-vsprov-ivssprovidernotifications-onload
    HRESULT OnLoad(IUnknown pCallback);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsprov/nf-vsprov-ivssprovidernotifications-onunload
    HRESULT OnUnload(BOOL bForceUnload);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsprov/nn-vsprov-ivsshardwaresnapshotprovider
@GUID("9593a157-44e9-4344-bbeb-44fbf9b06b10")
interface IVssHardwareSnapshotProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsprov/nf-vsprov-ivsshardwaresnapshotprovider-arelunssupported
    HRESULT AreLunsSupported(int lLunCount, int lContext, ushort** rgwszDevices, 
                             VDS_LUN_INFORMATION* pLunInformation, BOOL* pbIsSupported);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsprov/nf-vsprov-ivsshardwaresnapshotprovider-fillinluninfo
    HRESULT FillInLunInfo(ushort* wszDeviceName, VDS_LUN_INFORMATION* pLunInfo, BOOL* pbIsSupported);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsprov/nf-vsprov-ivsshardwaresnapshotprovider-beginpreparesnapshot
    HRESULT BeginPrepareSnapshot(GUID SnapshotSetId, GUID SnapshotId, int lContext, int lLunCount, 
                                 ushort** rgDeviceNames, VDS_LUN_INFORMATION* rgLunInformation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsprov/nf-vsprov-ivsshardwaresnapshotprovider-gettargetluns
    HRESULT GetTargetLuns(int lLunCount, ushort** rgDeviceNames, VDS_LUN_INFORMATION* rgSourceLuns, 
                          VDS_LUN_INFORMATION* rgDestinationLuns);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsprov/nf-vsprov-ivsshardwaresnapshotprovider-locateluns
    HRESULT LocateLuns(int lLunCount, VDS_LUN_INFORMATION* rgSourceLuns);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsprov/nf-vsprov-ivsshardwaresnapshotprovider-onlunempty
    HRESULT OnLunEmpty(ushort* wszDeviceName, VDS_LUN_INFORMATION* pInformation);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsprov/nn-vsprov-ivsshardwaresnapshotproviderex
@GUID("7f5ba925-cdb1-4d11-a71f-339eb7e709fd")
interface IVssHardwareSnapshotProviderEx : IVssHardwareSnapshotProvider
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsprov/nf-vsprov-ivsshardwaresnapshotproviderex-getprovidercapabilities
    HRESULT GetProviderCapabilities(ulong* pllOriginalCapabilityMask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsprov/nf-vsprov-ivsshardwaresnapshotproviderex-onlunstatechange
    HRESULT OnLunStateChange(VDS_LUN_INFORMATION* pSnapshotLuns, VDS_LUN_INFORMATION* pOriginalLuns, uint dwCount, 
                             uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsprov/nf-vsprov-ivsshardwaresnapshotproviderex-resyncluns
    HRESULT ResyncLuns(VDS_LUN_INFORMATION* pSourceLuns, VDS_LUN_INFORMATION* pTargetLuns, uint dwCount, 
                       IVssAsync* ppAsync);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsprov/nf-vsprov-ivsshardwaresnapshotproviderex-onreuseluns
    HRESULT OnReuseLuns(VDS_LUN_INFORMATION* pSnapshotLuns, VDS_LUN_INFORMATION* pOriginalLuns, uint dwCount);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsprov/nn-vsprov-ivssfilesharesnapshotprovider
@GUID("c8636060-7c2e-11df-8c4a-0800200c9a66")
interface IVssFileShareSnapshotProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsprov/nf-vsprov-ivssfilesharesnapshotprovider-setcontext
    HRESULT SetContext(int lContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsprov/nf-vsprov-ivssfilesharesnapshotprovider-getsnapshotproperties
    HRESULT GetSnapshotProperties(GUID SnapshotId, VSS_SNAPSHOT_PROP* pProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsprov/nf-vsprov-ivssfilesharesnapshotprovider-query
    HRESULT Query(GUID QueriedObjectId, VSS_OBJECT_TYPE eQueriedObjectType, VSS_OBJECT_TYPE eReturnedObjectsType, 
                  IVssEnumObject* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsprov/nf-vsprov-ivssfilesharesnapshotprovider-deletesnapshots
    HRESULT DeleteSnapshots(GUID SourceObjectId, VSS_OBJECT_TYPE eSourceObjectType, BOOL bForceDelete, 
                            int* plDeletedSnapshots, GUID* pNondeletedSnapshotID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsprov/nf-vsprov-ivssfilesharesnapshotprovider-beginpreparesnapshot
    HRESULT BeginPrepareSnapshot(GUID SnapshotSetId, GUID SnapshotId, ushort* pwszSharePath, int lNewContext, 
                                 GUID ProviderId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsprov/nf-vsprov-ivssfilesharesnapshotprovider-ispathsupported
    HRESULT IsPathSupported(ushort* pwszSharePath, BOOL* pbSupportedByThisProvider);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsprov/nf-vsprov-ivssfilesharesnapshotprovider-ispathsnapshotted
    HRESULT IsPathSnapshotted(ushort* pwszSharePath, BOOL* pbSnapshotsPresent, int* plSnapshotCompatibility);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vsprov/nf-vsprov-ivssfilesharesnapshotprovider-setsnapshotproperty
    HRESULT SetSnapshotProperty(GUID SnapshotId, VSS_SNAPSHOT_PROPERTY_ID eSnapshotPropertyId, VARIANT vProperty);
}


// GUIDs

const GUID CLSID_VSSCoordinator  = GUIDOF!VSSCoordinator;
const GUID CLSID_VssSnapshotMgmt = GUIDOF!VssSnapshotMgmt;

const GUID IID_IVssAdmin                             = GUIDOF!IVssAdmin;
const GUID IID_IVssAdminEx                           = GUIDOF!IVssAdminEx;
const GUID IID_IVssAsync                             = GUIDOF!IVssAsync;
const GUID IID_IVssComponent                         = GUIDOF!IVssComponent;
const GUID IID_IVssComponentEx                       = GUIDOF!IVssComponentEx;
const GUID IID_IVssComponentEx2                      = GUIDOF!IVssComponentEx2;
const GUID IID_IVssCreateExpressWriterMetadata       = GUIDOF!IVssCreateExpressWriterMetadata;
const GUID IID_IVssDifferentialSoftwareSnapshotMgmt  = GUIDOF!IVssDifferentialSoftwareSnapshotMgmt;
const GUID IID_IVssDifferentialSoftwareSnapshotMgmt2 = GUIDOF!IVssDifferentialSoftwareSnapshotMgmt2;
const GUID IID_IVssDifferentialSoftwareSnapshotMgmt3 = GUIDOF!IVssDifferentialSoftwareSnapshotMgmt3;
const GUID IID_IVssEnumMgmtObject                    = GUIDOF!IVssEnumMgmtObject;
const GUID IID_IVssEnumObject                        = GUIDOF!IVssEnumObject;
const GUID IID_IVssExpressWriter                     = GUIDOF!IVssExpressWriter;
const GUID IID_IVssFileShareSnapshotProvider         = GUIDOF!IVssFileShareSnapshotProvider;
const GUID IID_IVssHardwareSnapshotProvider          = GUIDOF!IVssHardwareSnapshotProvider;
const GUID IID_IVssHardwareSnapshotProviderEx        = GUIDOF!IVssHardwareSnapshotProviderEx;
const GUID IID_IVssProviderCreateSnapshotSet         = GUIDOF!IVssProviderCreateSnapshotSet;
const GUID IID_IVssProviderNotifications             = GUIDOF!IVssProviderNotifications;
const GUID IID_IVssSnapshotMgmt                      = GUIDOF!IVssSnapshotMgmt;
const GUID IID_IVssSnapshotMgmt2                     = GUIDOF!IVssSnapshotMgmt2;
const GUID IID_IVssSoftwareSnapshotProvider          = GUIDOF!IVssSoftwareSnapshotProvider;
