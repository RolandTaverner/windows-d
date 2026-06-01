// Written in the D programming language.

module windows.win32.storage.virtualdiskservice;

public import windows.core;
public import system.system : Guid;
public import windows.win32.foundation.foundation : BOOL, BOOLEAN, HRESULT, PWSTR;
public import windows.win32.storage.vhd : ATTACH_VIRTUAL_DISK_FLAG, COMPACT_VIRTUAL_DISK_FLAG,
                                          CREATE_VIRTUAL_DISK_FLAG, DEPENDENT_DISK_FLAG,
                                          DETACH_VIRTUAL_DISK_FLAG,
                                          EXPAND_VIRTUAL_DISK_FLAG, MERGE_VIRTUAL_DISK_FLAG,
                                          OPEN_VIRTUAL_DISK_FLAG, VIRTUAL_DISK_ACCESS_MASK,
                                          VIRTUAL_STORAGE_TYPE;
public import windows.win32.system.com.com : IUnknown;

extern(Windows) @nogc nothrow:


// Enums


alias VDS_NF_PACK = uint;
enum : uint
{
    VDS_NF_PACK_ARRIVE = 0x00000001U,
    VDS_NF_PACK_DEPART = 0x00000002U,
    VDS_NF_PACK_MODIFY = 0x00000003U,
}

alias VDS_NF_FILE_SYSTEM = uint;
enum : uint
{
    VDS_NF_FILE_SYSTEM_MODIFY          = 0x000000cbU,
    VDS_NF_FILE_SYSTEM_FORMAT_PROGRESS = 0x000000ccU,
}

alias VDS_NF_CONTROLLER = uint;
enum : uint
{
    VDS_NF_CONTROLLER_ARRIVE  = 0x00000067U,
    VDS_NF_CONTROLLER_DEPART  = 0x00000068U,
    VDS_NF_CONTROLLER_MODIFY  = 0x0000015eU,
    VDS_NF_CONTROLLER_REMOVED = 0x0000015fU,
}

alias VDS_NF_DRIVE = uint;
enum : uint
{
    VDS_NF_DRIVE_ARRIVE  = 0x00000069U,
    VDS_NF_DRIVE_DEPART  = 0x0000006aU,
    VDS_NF_DRIVE_MODIFY  = 0x0000006bU,
    VDS_NF_DRIVE_REMOVED = 0x00000162U,
}

alias VDS_NF_PORT = uint;
enum : uint
{
    VDS_NF_PORT_ARRIVE  = 0x00000079U,
    VDS_NF_PORT_DEPART  = 0x0000007aU,
    VDS_NF_PORT_MODIFY  = 0x00000160U,
    VDS_NF_PORT_REMOVED = 0x00000161U,
}

alias VDS_NF_LUN = uint;
enum : uint
{
    VDS_NF_LUN_ARRIVE = 0x0000006cU,
    VDS_NF_LUN_DEPART = 0x0000006dU,
    VDS_NF_LUN_MODIFY = 0x0000006eU,
}

alias VDS_NF_DISK = uint;
enum : uint
{
    VDS_NF_DISK_ARRIVE = 0x00000008U,
    VDS_NF_DISK_DEPART = 0x00000009U,
    VDS_NF_DISK_MODIFY = 0x0000000aU,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdslun/ne-vdslun-vds_storage_identifier_code_set
alias VDS_STORAGE_IDENTIFIER_CODE_SET = int;
enum : int
{
    VDSStorageIdCodeSetReserved = 0x00000000,
    VDSStorageIdCodeSetBinary   = 0x00000001,
    VDSStorageIdCodeSetAscii    = 0x00000002,
    VDSStorageIdCodeSetUtf8     = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdslun/ne-vdslun-vds_storage_identifier_type
alias VDS_STORAGE_IDENTIFIER_TYPE = int;
enum : int
{
    VDSStorageIdTypeVendorSpecific           = 0x00000000,
    VDSStorageIdTypeVendorId                 = 0x00000001,
    VDSStorageIdTypeEUI64                    = 0x00000002,
    VDSStorageIdTypeFCPHName                 = 0x00000003,
    VDSStorageIdTypePortRelative             = 0x00000004,
    VDSStorageIdTypeTargetPortGroup          = 0x00000005,
    VDSStorageIdTypeLogicalUnitGroup         = 0x00000006,
    VDSStorageIdTypeMD5LogicalUnitIdentifier = 0x00000007,
    VDSStorageIdTypeScsiNameString           = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdslun/ne-vdslun-vds_storage_bus_type
alias VDS_STORAGE_BUS_TYPE = int;
enum : int
{
    VDSBusTypeUnknown           = 0x00000000,
    VDSBusTypeScsi              = 0x00000001,
    VDSBusTypeAtapi             = 0x00000002,
    VDSBusTypeAta               = 0x00000003,
    VDSBusType1394              = 0x00000004,
    VDSBusTypeSsa               = 0x00000005,
    VDSBusTypeFibre             = 0x00000006,
    VDSBusTypeUsb               = 0x00000007,
    VDSBusTypeRAID              = 0x00000008,
    VDSBusTypeiScsi             = 0x00000009,
    VDSBusTypeSas               = 0x0000000a,
    VDSBusTypeSata              = 0x0000000b,
    VDSBusTypeSd                = 0x0000000c,
    VDSBusTypeMmc               = 0x0000000d,
    VDSBusTypeMax               = 0x0000000e,
    VDSBusTypeVirtual           = 0x0000000e,
    VDSBusTypeFileBackedVirtual = 0x0000000f,
    VDSBusTypeSpaces            = 0x00000010,
    VDSBusTypeNVMe              = 0x00000011,
    VDSBusTypeScm               = 0x00000012,
    VDSBusTypeUfs               = 0x00000013,
    VDSBusTypeMaxReserved       = 0x0000007f,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdslun/ne-vdslun-vds_interconnect_address_type
alias VDS_INTERCONNECT_ADDRESS_TYPE = int;
enum : int
{
    VDS_IA_UNKNOWN = 0x00000000,
    VDS_IA_FCFS    = 0x00000001,
    VDS_IA_FCPH    = 0x00000002,
    VDS_IA_FCPH3   = 0x00000003,
    VDS_IA_MAC     = 0x00000004,
    VDS_IA_SCSI    = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ne-vdshwprv-vds_object_type
alias VDS_OBJECT_TYPE = int;
enum : int
{
    VDS_OT_UNKNOWN      = 0x00000000,
    VDS_OT_PROVIDER     = 0x00000001,
    VDS_OT_PACK         = 0x0000000a,
    VDS_OT_VOLUME       = 0x0000000b,
    VDS_OT_VOLUME_PLEX  = 0x0000000c,
    VDS_OT_DISK         = 0x0000000d,
    VDS_OT_SUB_SYSTEM   = 0x0000001e,
    VDS_OT_CONTROLLER   = 0x0000001f,
    VDS_OT_DRIVE        = 0x00000020,
    VDS_OT_LUN          = 0x00000021,
    VDS_OT_LUN_PLEX     = 0x00000022,
    VDS_OT_PORT         = 0x00000023,
    VDS_OT_PORTAL       = 0x00000024,
    VDS_OT_TARGET       = 0x00000025,
    VDS_OT_PORTAL_GROUP = 0x00000026,
    VDS_OT_STORAGE_POOL = 0x00000027,
    VDS_OT_HBAPORT      = 0x0000005a,
    VDS_OT_INIT_ADAPTER = 0x0000005b,
    VDS_OT_INIT_PORTAL  = 0x0000005c,
    VDS_OT_ASYNC        = 0x00000064,
    VDS_OT_ENUM         = 0x00000065,
    VDS_OT_VDISK        = 0x000000c8,
    VDS_OT_OPEN_VDISK   = 0x000000c9,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ne-vdshwprv-vds_provider_type
alias VDS_PROVIDER_TYPE = int;
enum : int
{
    VDS_PT_UNKNOWN     = 0x00000000,
    VDS_PT_SOFTWARE    = 0x00000001,
    VDS_PT_HARDWARE    = 0x00000002,
    VDS_PT_VIRTUALDISK = 0x00000003,
    VDS_PT_MAX         = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ne-vdshwprv-vds_provider_flag
alias VDS_PROVIDER_FLAG = int;
enum : int
{
    VDS_PF_DYNAMIC                         = 0x00000001,
    VDS_PF_INTERNAL_HARDWARE_PROVIDER      = 0x00000002,
    VDS_PF_ONE_DISK_ONLY_PER_PACK          = 0x00000004,
    VDS_PF_ONE_PACK_ONLINE_ONLY            = 0x00000008,
    VDS_PF_VOLUME_SPACE_MUST_BE_CONTIGUOUS = 0x00000010,
    VDS_PF_SUPPORT_DYNAMIC                 = 0x80000000,
    VDS_PF_SUPPORT_FAULT_TOLERANT          = 0x40000000,
    VDS_PF_SUPPORT_DYNAMIC_1394            = 0x20000000,
    VDS_PF_SUPPORT_MIRROR                  = 0x00000020,
    VDS_PF_SUPPORT_RAID5                   = 0x00000040,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ne-vdshwprv-vds_recover_action
alias VDS_RECOVER_ACTION = int;
enum : int
{
    VDS_RA_UNKNOWN = 0x00000000,
    VDS_RA_REFRESH = 0x00000001,
    VDS_RA_RESTART = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ne-vdshwprv-vds_notification_target_type
alias VDS_NOTIFICATION_TARGET_TYPE = int;
enum : int
{
    VDS_NTT_UNKNOWN      = 0x00000000,
    VDS_NTT_PACK         = 0x0000000a,
    VDS_NTT_VOLUME       = 0x0000000b,
    VDS_NTT_DISK         = 0x0000000d,
    VDS_NTT_PARTITION    = 0x0000003c,
    VDS_NTT_DRIVE_LETTER = 0x0000003d,
    VDS_NTT_FILE_SYSTEM  = 0x0000003e,
    VDS_NTT_MOUNT_POINT  = 0x0000003f,
    VDS_NTT_SUB_SYSTEM   = 0x0000001e,
    VDS_NTT_CONTROLLER   = 0x0000001f,
    VDS_NTT_DRIVE        = 0x00000020,
    VDS_NTT_LUN          = 0x00000021,
    VDS_NTT_PORT         = 0x00000023,
    VDS_NTT_PORTAL       = 0x00000024,
    VDS_NTT_TARGET       = 0x00000025,
    VDS_NTT_PORTAL_GROUP = 0x00000026,
    VDS_NTT_SERVICE      = 0x000000c8,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ne-vdshwprv-vds_async_output_type
alias VDS_ASYNC_OUTPUT_TYPE = int;
enum : int
{
    VDS_ASYNCOUT_UNKNOWN           = 0x00000000,
    VDS_ASYNCOUT_CREATEVOLUME      = 0x00000001,
    VDS_ASYNCOUT_EXTENDVOLUME      = 0x00000002,
    VDS_ASYNCOUT_SHRINKVOLUME      = 0x00000003,
    VDS_ASYNCOUT_ADDVOLUMEPLEX     = 0x00000004,
    VDS_ASYNCOUT_BREAKVOLUMEPLEX   = 0x00000005,
    VDS_ASYNCOUT_REMOVEVOLUMEPLEX  = 0x00000006,
    VDS_ASYNCOUT_REPAIRVOLUMEPLEX  = 0x00000007,
    VDS_ASYNCOUT_RECOVERPACK       = 0x00000008,
    VDS_ASYNCOUT_REPLACEDISK       = 0x00000009,
    VDS_ASYNCOUT_CREATEPARTITION   = 0x0000000a,
    VDS_ASYNCOUT_CLEAN             = 0x0000000b,
    VDS_ASYNCOUT_CREATELUN         = 0x00000032,
    VDS_ASYNCOUT_ADDLUNPLEX        = 0x00000034,
    VDS_ASYNCOUT_REMOVELUNPLEX     = 0x00000035,
    VDS_ASYNCOUT_EXTENDLUN         = 0x00000036,
    VDS_ASYNCOUT_SHRINKLUN         = 0x00000037,
    VDS_ASYNCOUT_RECOVERLUN        = 0x00000038,
    VDS_ASYNCOUT_LOGINTOTARGET     = 0x0000003c,
    VDS_ASYNCOUT_LOGOUTFROMTARGET  = 0x0000003d,
    VDS_ASYNCOUT_CREATETARGET      = 0x0000003e,
    VDS_ASYNCOUT_CREATEPORTALGROUP = 0x0000003f,
    VDS_ASYNCOUT_DELETETARGET      = 0x00000040,
    VDS_ASYNCOUT_ADDPORTAL         = 0x00000041,
    VDS_ASYNCOUT_REMOVEPORTAL      = 0x00000042,
    VDS_ASYNCOUT_DELETEPORTALGROUP = 0x00000043,
    VDS_ASYNCOUT_FORMAT            = 0x00000065,
    VDS_ASYNCOUT_CREATE_VDISK      = 0x000000c8,
    VDS_ASYNCOUT_ATTACH_VDISK      = 0x000000c9,
    VDS_ASYNCOUT_COMPACT_VDISK     = 0x000000ca,
    VDS_ASYNCOUT_MERGE_VDISK       = 0x000000cb,
    VDS_ASYNCOUT_EXPAND_VDISK      = 0x000000cc,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ne-vdshwprv-vds_ipaddress_type
alias VDS_IPADDRESS_TYPE = int;
enum : int
{
    VDS_IPT_TEXT  = 0x00000000,
    VDS_IPT_IPV4  = 0x00000001,
    VDS_IPT_IPV6  = 0x00000002,
    VDS_IPT_EMPTY = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ne-vdshwprv-vds_health
alias VDS_HEALTH = int;
enum : int
{
    VDS_H_UNKNOWN                   = 0x00000000,
    VDS_H_HEALTHY                   = 0x00000001,
    VDS_H_REBUILDING                = 0x00000002,
    VDS_H_STALE                     = 0x00000003,
    VDS_H_FAILING                   = 0x00000004,
    VDS_H_FAILING_REDUNDANCY        = 0x00000005,
    VDS_H_FAILED_REDUNDANCY         = 0x00000006,
    VDS_H_FAILED_REDUNDANCY_FAILING = 0x00000007,
    VDS_H_FAILED                    = 0x00000008,
    VDS_H_REPLACED                  = 0x00000009,
    VDS_H_PENDING_FAILURE           = 0x0000000a,
    VDS_H_DEGRADED                  = 0x0000000b,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ne-vdshwprv-vds_transition_state
alias VDS_TRANSITION_STATE = int;
enum : int
{
    VDS_TS_UNKNOWN     = 0x00000000,
    VDS_TS_STABLE      = 0x00000001,
    VDS_TS_EXTENDING   = 0x00000002,
    VDS_TS_SHRINKING   = 0x00000003,
    VDS_TS_RECONFIGING = 0x00000004,
    VDS_TS_RESTRIPING  = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ne-vdshwprv-vds_file_system_type
alias VDS_FILE_SYSTEM_TYPE = int;
enum : int
{
    VDS_FST_UNKNOWN = 0x00000000,
    VDS_FST_RAW     = 0x00000001,
    VDS_FST_FAT     = 0x00000002,
    VDS_FST_FAT32   = 0x00000003,
    VDS_FST_NTFS    = 0x00000004,
    VDS_FST_CDFS    = 0x00000005,
    VDS_FST_UDF     = 0x00000006,
    VDS_FST_EXFAT   = 0x00000007,
    VDS_FST_CSVFS   = 0x00000008,
    VDS_FST_REFS    = 0x00000009,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ne-vdshwprv-vds_hbaport_type
alias VDS_HBAPORT_TYPE = int;
enum : int
{
    VDS_HPT_UNKNOWN    = 0x00000001,
    VDS_HPT_OTHER      = 0x00000002,
    VDS_HPT_NOTPRESENT = 0x00000003,
    VDS_HPT_NPORT      = 0x00000005,
    VDS_HPT_NLPORT     = 0x00000006,
    VDS_HPT_FLPORT     = 0x00000007,
    VDS_HPT_FPORT      = 0x00000008,
    VDS_HPT_EPORT      = 0x00000009,
    VDS_HPT_GPORT      = 0x0000000a,
    VDS_HPT_LPORT      = 0x00000014,
    VDS_HPT_PTP        = 0x00000015,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ne-vdshwprv-vds_hbaport_status
alias VDS_HBAPORT_STATUS = int;
enum : int
{
    VDS_HPS_UNKNOWN     = 0x00000001,
    VDS_HPS_ONLINE      = 0x00000002,
    VDS_HPS_OFFLINE     = 0x00000003,
    VDS_HPS_BYPASSED    = 0x00000004,
    VDS_HPS_DIAGNOSTICS = 0x00000005,
    VDS_HPS_LINKDOWN    = 0x00000006,
    VDS_HPS_ERROR       = 0x00000007,
    VDS_HPS_LOOPBACK    = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ne-vdshwprv-vds_hbaport_speed_flag
alias VDS_HBAPORT_SPEED_FLAG = int;
enum : int
{
    VDS_HSF_UNKNOWN        = 0x00000000,
    VDS_HSF_1GBIT          = 0x00000001,
    VDS_HSF_2GBIT          = 0x00000002,
    VDS_HSF_10GBIT         = 0x00000004,
    VDS_HSF_4GBIT          = 0x00000008,
    VDS_HSF_NOT_NEGOTIATED = 0x00008000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ne-vdshwprv-vds_path_status
alias VDS_PATH_STATUS = int;
enum : int
{
    VDS_MPS_UNKNOWN = 0x00000000,
    VDS_MPS_ONLINE  = 0x00000001,
    VDS_MPS_FAILED  = 0x00000005,
    VDS_MPS_STANDBY = 0x00000007,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ne-vdshwprv-vds_loadbalance_policy_enum
alias VDS_LOADBALANCE_POLICY_ENUM = int;
enum : int
{
    VDS_LBP_UNKNOWN                 = 0x00000000,
    VDS_LBP_FAILOVER                = 0x00000001,
    VDS_LBP_ROUND_ROBIN             = 0x00000002,
    VDS_LBP_ROUND_ROBIN_WITH_SUBSET = 0x00000003,
    VDS_LBP_DYN_LEAST_QUEUE_DEPTH   = 0x00000004,
    VDS_LBP_WEIGHTED_PATHS          = 0x00000005,
    VDS_LBP_LEAST_BLOCKS            = 0x00000006,
    VDS_LBP_VENDOR_SPECIFIC         = 0x00000007,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ne-vdshwprv-vds_provider_lbsupport_flag
alias VDS_PROVIDER_LBSUPPORT_FLAG = int;
enum : int
{
    VDS_LBF_FAILOVER                = 0x00000001,
    VDS_LBF_ROUND_ROBIN             = 0x00000002,
    VDS_LBF_ROUND_ROBIN_WITH_SUBSET = 0x00000004,
    VDS_LBF_DYN_LEAST_QUEUE_DEPTH   = 0x00000008,
    VDS_LBF_WEIGHTED_PATHS          = 0x00000010,
    VDS_LBF_LEAST_BLOCKS            = 0x00000020,
    VDS_LBF_VENDOR_SPECIFIC         = 0x00000040,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ne-vdshwprv-vds_version_support_flag
alias VDS_VERSION_SUPPORT_FLAG = int;
enum : int
{
    VDS_VSF_1_0 = 0x00000001,
    VDS_VSF_1_1 = 0x00000002,
    VDS_VSF_2_0 = 0x00000004,
    VDS_VSF_2_1 = 0x00000008,
    VDS_VSF_3_0 = 0x00000010,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ne-vdshwprv-vds_hwprovider_type
alias VDS_HWPROVIDER_TYPE = int;
enum : int
{
    VDS_HWT_UNKNOWN       = 0x00000000,
    VDS_HWT_PCI_RAID      = 0x00000001,
    VDS_HWT_FIBRE_CHANNEL = 0x00000002,
    VDS_HWT_ISCSI         = 0x00000003,
    VDS_HWT_SAS           = 0x00000004,
    VDS_HWT_HYBRID        = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ne-vdshwprv-vds_iscsi_login_type
alias VDS_ISCSI_LOGIN_TYPE = int;
enum : int
{
    VDS_ILT_MANUAL     = 0x00000000,
    VDS_ILT_PERSISTENT = 0x00000001,
    VDS_ILT_BOOT       = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ne-vdshwprv-vds_iscsi_auth_type
alias VDS_ISCSI_AUTH_TYPE = int;
enum : int
{
    VDS_IAT_NONE        = 0x00000000,
    VDS_IAT_CHAP        = 0x00000001,
    VDS_IAT_MUTUAL_CHAP = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ne-vdshwprv-vds_iscsi_ipsec_flag
alias VDS_ISCSI_IPSEC_FLAG = int;
enum : int
{
    VDS_IIF_VALID                    = 0x00000001,
    VDS_IIF_IKE                      = 0x00000002,
    VDS_IIF_MAIN_MODE                = 0x00000004,
    VDS_IIF_AGGRESSIVE_MODE          = 0x00000008,
    VDS_IIF_PFS_ENABLE               = 0x00000010,
    VDS_IIF_TRANSPORT_MODE_PREFERRED = 0x00000020,
    VDS_IIF_TUNNEL_MODE_PREFERRED    = 0x00000040,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ne-vdshwprv-vds_iscsi_login_flag
alias VDS_ISCSI_LOGIN_FLAG = int;
enum : int
{
    VDS_ILF_REQUIRE_IPSEC     = 0x00000001,
    VDS_ILF_MULTIPATH_ENABLED = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/ne-vds-vds_pack_status
alias VDS_PACK_STATUS = int;
enum : int
{
    VDS_PS_UNKNOWN = 0x00000000,
    VDS_PS_ONLINE  = 0x00000001,
    VDS_PS_OFFLINE = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/ne-vds-vds_pack_flag
alias VDS_PACK_FLAG = int;
enum : int
{
    VDS_PKF_FOREIGN      = 0x00000001,
    VDS_PKF_NOQUORUM     = 0x00000002,
    VDS_PKF_POLICY       = 0x00000004,
    VDS_PKF_CORRUPTED    = 0x00000008,
    VDS_PKF_ONLINE_ERROR = 0x00000010,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/ne-vds-vds_disk_status
alias VDS_DISK_STATUS = int;
enum : int
{
    VDS_DS_UNKNOWN   = 0x00000000,
    VDS_DS_ONLINE    = 0x00000001,
    VDS_DS_NOT_READY = 0x00000002,
    VDS_DS_NO_MEDIA  = 0x00000003,
    VDS_DS_FAILED    = 0x00000005,
    VDS_DS_MISSING   = 0x00000006,
    VDS_DS_OFFLINE   = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/ne-vds-vds_partition_style
alias VDS_PARTITION_STYLE = int;
enum : int
{
    VDS_PST_UNKNOWN = 0x00000000,
    VDS_PST_MBR     = 0x00000001,
    VDS_PST_GPT     = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/ne-vds-vds_disk_flag
alias VDS_DISK_FLAG = int;
enum : int
{
    VDS_DF_AUDIO_CD             = 0x00000001,
    VDS_DF_HOTSPARE             = 0x00000002,
    VDS_DF_RESERVE_CAPABLE      = 0x00000004,
    VDS_DF_MASKED               = 0x00000008,
    VDS_DF_STYLE_CONVERTIBLE    = 0x00000010,
    VDS_DF_CLUSTERED            = 0x00000020,
    VDS_DF_READ_ONLY            = 0x00000040,
    VDS_DF_SYSTEM_DISK          = 0x00000080,
    VDS_DF_BOOT_DISK            = 0x00000100,
    VDS_DF_PAGEFILE_DISK        = 0x00000200,
    VDS_DF_HIBERNATIONFILE_DISK = 0x00000400,
    VDS_DF_CRASHDUMP_DISK       = 0x00000800,
    VDS_DF_HAS_ARC_PATH         = 0x00001000,
    VDS_DF_DYNAMIC              = 0x00002000,
    VDS_DF_BOOT_FROM_DISK       = 0x00004000,
    VDS_DF_CURRENT_READ_ONLY    = 0x00008000,
    VDS_DF_REFS_NOT_SUPPORTED   = 0x00010000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/ne-vds-vds_partition_flag
alias VDS_PARTITION_FLAG = int;
enum : int
{
    VDS_PTF_SYSTEM = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/ne-vds-vds_lun_reserve_mode
alias VDS_LUN_RESERVE_MODE = int;
enum : int
{
    VDS_LRM_NONE         = 0x00000000,
    VDS_LRM_EXCLUSIVE_RW = 0x00000001,
    VDS_LRM_EXCLUSIVE_RO = 0x00000002,
    VDS_LRM_SHARED_RO    = 0x00000003,
    VDS_LRM_SHARED_RW    = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/ne-vds-vds_volume_status
alias VDS_VOLUME_STATUS = int;
enum : int
{
    VDS_VS_UNKNOWN  = 0x00000000,
    VDS_VS_ONLINE   = 0x00000001,
    VDS_VS_NO_MEDIA = 0x00000003,
    VDS_VS_FAILED   = 0x00000005,
    VDS_VS_OFFLINE  = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/ne-vds-vds_volume_type
alias VDS_VOLUME_TYPE = int;
enum : int
{
    VDS_VT_UNKNOWN = 0x00000000,
    VDS_VT_SIMPLE  = 0x0000000a,
    VDS_VT_SPAN    = 0x0000000b,
    VDS_VT_STRIPE  = 0x0000000c,
    VDS_VT_MIRROR  = 0x0000000d,
    VDS_VT_PARITY  = 0x0000000e,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/ne-vds-vds_volume_flag
alias VDS_VOLUME_FLAG = int;
enum : int
{
    VDS_VF_SYSTEM_VOLUME                = 0x00000001,
    VDS_VF_BOOT_VOLUME                  = 0x00000002,
    VDS_VF_ACTIVE                       = 0x00000004,
    VDS_VF_READONLY                     = 0x00000008,
    VDS_VF_HIDDEN                       = 0x00000010,
    VDS_VF_CAN_EXTEND                   = 0x00000020,
    VDS_VF_CAN_SHRINK                   = 0x00000040,
    VDS_VF_PAGEFILE                     = 0x00000080,
    VDS_VF_HIBERNATION                  = 0x00000100,
    VDS_VF_CRASHDUMP                    = 0x00000200,
    VDS_VF_INSTALLABLE                  = 0x00000400,
    VDS_VF_LBN_REMAP_ENABLED            = 0x00000800,
    VDS_VF_FORMATTING                   = 0x00001000,
    VDS_VF_NOT_FORMATTABLE              = 0x00002000,
    VDS_VF_NTFS_NOT_SUPPORTED           = 0x00004000,
    VDS_VF_FAT32_NOT_SUPPORTED          = 0x00008000,
    VDS_VF_FAT_NOT_SUPPORTED            = 0x00010000,
    VDS_VF_NO_DEFAULT_DRIVE_LETTER      = 0x00020000,
    VDS_VF_PERMANENTLY_DISMOUNTED       = 0x00040000,
    VDS_VF_PERMANENT_DISMOUNT_SUPPORTED = 0x00080000,
    VDS_VF_SHADOW_COPY                  = 0x00100000,
    VDS_VF_FVE_ENABLED                  = 0x00200000,
    VDS_VF_DIRTY                        = 0x00400000,
    VDS_VF_REFS_NOT_SUPPORTED           = 0x00800000,
    VDS_VF_BACKS_BOOT_VOLUME            = 0x01000000,
    VDS_VF_BACKED_BY_WIM_IMAGE          = 0x02000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/ne-vds-vds_volume_plex_type
alias VDS_VOLUME_PLEX_TYPE = int;
enum : int
{
    VDS_VPT_UNKNOWN = 0x00000000,
    VDS_VPT_SIMPLE  = 0x0000000a,
    VDS_VPT_SPAN    = 0x0000000b,
    VDS_VPT_STRIPE  = 0x0000000c,
    VDS_VPT_PARITY  = 0x0000000e,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/ne-vds-vds_volume_plex_status
alias VDS_VOLUME_PLEX_STATUS = int;
enum : int
{
    VDS_VPS_UNKNOWN  = 0x00000000,
    VDS_VPS_ONLINE   = 0x00000001,
    VDS_VPS_NO_MEDIA = 0x00000003,
    VDS_VPS_FAILED   = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/ne-vds-vds_disk_extent_type
alias VDS_DISK_EXTENT_TYPE = int;
enum : int
{
    VDS_DET_UNKNOWN  = 0x00000000,
    VDS_DET_FREE     = 0x00000001,
    VDS_DET_DATA     = 0x00000002,
    VDS_DET_OEM      = 0x00000003,
    VDS_DET_ESP      = 0x00000004,
    VDS_DET_MSR      = 0x00000005,
    VDS_DET_LDM      = 0x00000006,
    VDS_DET_CLUSTER  = 0x00000007,
    VDS_DET_UNUSABLE = 0x00007fff,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/ne-vds-vds_disk_offline_reason
alias VDS_DISK_OFFLINE_REASON = int;
enum : int
{
    VDSDiskOfflineReasonNone                = 0x00000000,
    VDSDiskOfflineReasonPolicy              = 0x00000001,
    VDSDiskOfflineReasonRedundantPath       = 0x00000002,
    VDSDiskOfflineReasonSnapshot            = 0x00000003,
    VDSDiskOfflineReasonCollision           = 0x00000004,
    VDSDiskOfflineReasonResourceExhaustion  = 0x00000005,
    VDSDiskOfflineReasonWriteFailure        = 0x00000006,
    VDSDiskOfflineReasonDIScan              = 0x00000007,
    VDSDiskOfflineReasonLostDataPersistence = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/ne-vds-__vds_partition_style
alias __VDS_PARTITION_STYLE = int;
enum : int
{
    VDS_PARTITION_STYLE_MBR = 0x00000000,
    VDS_PARTITION_STYLE_GPT = 0x00000001,
    VDS_PARTITION_STYLE_RAW = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ne-vdshwprv-vds_sub_system_status
alias VDS_SUB_SYSTEM_STATUS = int;
enum : int
{
    VDS_SSS_UNKNOWN           = 0x00000000,
    VDS_SSS_ONLINE            = 0x00000001,
    VDS_SSS_NOT_READY         = 0x00000002,
    VDS_SSS_OFFLINE           = 0x00000004,
    VDS_SSS_FAILED            = 0x00000005,
    VDS_SSS_PARTIALLY_MANAGED = 0x00000009,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ne-vdshwprv-vds_sub_system_flag
alias VDS_SUB_SYSTEM_FLAG = int;
enum : int
{
    VDS_SF_LUN_MASKING_CAPABLE              = 0x00000001,
    VDS_SF_LUN_PLEXING_CAPABLE              = 0x00000002,
    VDS_SF_LUN_REMAPPING_CAPABLE            = 0x00000004,
    VDS_SF_DRIVE_EXTENT_CAPABLE             = 0x00000008,
    VDS_SF_HARDWARE_CHECKSUM_CAPABLE        = 0x00000010,
    VDS_SF_RADIUS_CAPABLE                   = 0x00000020,
    VDS_SF_READ_BACK_VERIFY_CAPABLE         = 0x00000040,
    VDS_SF_WRITE_THROUGH_CACHING_CAPABLE    = 0x00000080,
    VDS_SF_SUPPORTS_FAULT_TOLERANT_LUNS     = 0x00000200,
    VDS_SF_SUPPORTS_NON_FAULT_TOLERANT_LUNS = 0x00000400,
    VDS_SF_SUPPORTS_SIMPLE_LUNS             = 0x00000800,
    VDS_SF_SUPPORTS_SPAN_LUNS               = 0x00001000,
    VDS_SF_SUPPORTS_STRIPE_LUNS             = 0x00002000,
    VDS_SF_SUPPORTS_MIRROR_LUNS             = 0x00004000,
    VDS_SF_SUPPORTS_PARITY_LUNS             = 0x00008000,
    VDS_SF_SUPPORTS_AUTH_CHAP               = 0x00010000,
    VDS_SF_SUPPORTS_AUTH_MUTUAL_CHAP        = 0x00020000,
    VDS_SF_SUPPORTS_SIMPLE_TARGET_CONFIG    = 0x00040000,
    VDS_SF_SUPPORTS_LUN_NUMBER              = 0x00080000,
    VDS_SF_SUPPORTS_MIRRORED_CACHE          = 0x00100000,
    VDS_SF_READ_CACHING_CAPABLE             = 0x00200000,
    VDS_SF_WRITE_CACHING_CAPABLE            = 0x00400000,
    VDS_SF_MEDIA_SCAN_CAPABLE               = 0x00800000,
    VDS_SF_CONSISTENCY_CHECK_CAPABLE        = 0x01000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ne-vdshwprv-vds_sub_system_supported_raid_type_flag
alias VDS_SUB_SYSTEM_SUPPORTED_RAID_TYPE_FLAG = int;
enum : int
{
    VDS_SF_SUPPORTS_RAID2_LUNS  = 0x00000001,
    VDS_SF_SUPPORTS_RAID3_LUNS  = 0x00000002,
    VDS_SF_SUPPORTS_RAID4_LUNS  = 0x00000004,
    VDS_SF_SUPPORTS_RAID5_LUNS  = 0x00000008,
    VDS_SF_SUPPORTS_RAID6_LUNS  = 0x00000010,
    VDS_SF_SUPPORTS_RAID01_LUNS = 0x00000020,
    VDS_SF_SUPPORTS_RAID03_LUNS = 0x00000040,
    VDS_SF_SUPPORTS_RAID05_LUNS = 0x00000080,
    VDS_SF_SUPPORTS_RAID10_LUNS = 0x00000100,
    VDS_SF_SUPPORTS_RAID15_LUNS = 0x00000200,
    VDS_SF_SUPPORTS_RAID30_LUNS = 0x00000400,
    VDS_SF_SUPPORTS_RAID50_LUNS = 0x00000800,
    VDS_SF_SUPPORTS_RAID51_LUNS = 0x00001000,
    VDS_SF_SUPPORTS_RAID53_LUNS = 0x00002000,
    VDS_SF_SUPPORTS_RAID60_LUNS = 0x00004000,
    VDS_SF_SUPPORTS_RAID61_LUNS = 0x00008000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ne-vdshwprv-vds_interconnect_flag
alias VDS_INTERCONNECT_FLAG = int;
enum : int
{
    VDS_ITF_PCI_RAID      = 0x00000001,
    VDS_ITF_FIBRE_CHANNEL = 0x00000002,
    VDS_ITF_ISCSI         = 0x00000004,
    VDS_ITF_SAS           = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ne-vdshwprv-vds_controller_status
alias VDS_CONTROLLER_STATUS = int;
enum : int
{
    VDS_CS_UNKNOWN   = 0x00000000,
    VDS_CS_ONLINE    = 0x00000001,
    VDS_CS_NOT_READY = 0x00000002,
    VDS_CS_OFFLINE   = 0x00000004,
    VDS_CS_FAILED    = 0x00000005,
    VDS_CS_REMOVED   = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ne-vdshwprv-vds_port_status
alias VDS_PORT_STATUS = int;
enum : int
{
    VDS_PRS_UNKNOWN   = 0x00000000,
    VDS_PRS_ONLINE    = 0x00000001,
    VDS_PRS_NOT_READY = 0x00000002,
    VDS_PRS_OFFLINE   = 0x00000004,
    VDS_PRS_FAILED    = 0x00000005,
    VDS_PRS_REMOVED   = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ne-vdshwprv-vds_drive_status
alias VDS_DRIVE_STATUS = int;
enum : int
{
    VDS_DRS_UNKNOWN   = 0x00000000,
    VDS_DRS_ONLINE    = 0x00000001,
    VDS_DRS_NOT_READY = 0x00000002,
    VDS_DRS_OFFLINE   = 0x00000004,
    VDS_DRS_FAILED    = 0x00000005,
    VDS_DRS_REMOVED   = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ne-vdshwprv-vds_drive_flag
alias VDS_DRIVE_FLAG = int;
enum : int
{
    VDS_DRF_HOTSPARE         = 0x00000001,
    VDS_DRF_ASSIGNED         = 0x00000002,
    VDS_DRF_UNASSIGNED       = 0x00000004,
    VDS_DRF_HOTSPARE_IN_USE  = 0x00000008,
    VDS_DRF_HOTSPARE_STANDBY = 0x00000010,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ne-vdshwprv-vds_lun_type
alias VDS_LUN_TYPE = int;
enum : int
{
    VDS_LT_UNKNOWN            = 0x00000000,
    VDS_LT_DEFAULT            = 0x00000001,
    VDS_LT_FAULT_TOLERANT     = 0x00000002,
    VDS_LT_NON_FAULT_TOLERANT = 0x00000003,
    VDS_LT_SIMPLE             = 0x0000000a,
    VDS_LT_SPAN               = 0x0000000b,
    VDS_LT_STRIPE             = 0x0000000c,
    VDS_LT_MIRROR             = 0x0000000d,
    VDS_LT_PARITY             = 0x0000000e,
    VDS_LT_RAID2              = 0x0000000f,
    VDS_LT_RAID3              = 0x00000010,
    VDS_LT_RAID4              = 0x00000011,
    VDS_LT_RAID5              = 0x00000012,
    VDS_LT_RAID6              = 0x00000013,
    VDS_LT_RAID01             = 0x00000014,
    VDS_LT_RAID03             = 0x00000015,
    VDS_LT_RAID05             = 0x00000016,
    VDS_LT_RAID10             = 0x00000017,
    VDS_LT_RAID15             = 0x00000018,
    VDS_LT_RAID30             = 0x00000019,
    VDS_LT_RAID50             = 0x0000001a,
    VDS_LT_RAID51             = 0x0000001b,
    VDS_LT_RAID53             = 0x0000001c,
    VDS_LT_RAID60             = 0x0000001d,
    VDS_LT_RAID61             = 0x0000001e,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ne-vdshwprv-vds_lun_status
alias VDS_LUN_STATUS = int;
enum : int
{
    VDS_LS_UNKNOWN   = 0x00000000,
    VDS_LS_ONLINE    = 0x00000001,
    VDS_LS_NOT_READY = 0x00000002,
    VDS_LS_OFFLINE   = 0x00000004,
    VDS_LS_FAILED    = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ne-vdshwprv-vds_lun_flag
alias VDS_LUN_FLAG = int;
enum : int
{
    VDS_LF_LBN_REMAP_ENABLED             = 0x00000001,
    VDS_LF_READ_BACK_VERIFY_ENABLED      = 0x00000002,
    VDS_LF_WRITE_THROUGH_CACHING_ENABLED = 0x00000004,
    VDS_LF_HARDWARE_CHECKSUM_ENABLED     = 0x00000008,
    VDS_LF_READ_CACHE_ENABLED            = 0x00000010,
    VDS_LF_WRITE_CACHE_ENABLED           = 0x00000020,
    VDS_LF_MEDIA_SCAN_ENABLED            = 0x00000040,
    VDS_LF_CONSISTENCY_CHECK_ENABLED     = 0x00000080,
    VDS_LF_SNAPSHOT                      = 0x00000100,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ne-vdshwprv-vds_lun_plex_type
alias VDS_LUN_PLEX_TYPE = int;
enum : int
{
    VDS_LPT_UNKNOWN = 0x00000000,
    VDS_LPT_SIMPLE  = 0x0000000a,
    VDS_LPT_SPAN    = 0x0000000b,
    VDS_LPT_STRIPE  = 0x0000000c,
    VDS_LPT_PARITY  = 0x0000000e,
    VDS_LPT_RAID2   = 0x0000000f,
    VDS_LPT_RAID3   = 0x00000010,
    VDS_LPT_RAID4   = 0x00000011,
    VDS_LPT_RAID5   = 0x00000012,
    VDS_LPT_RAID6   = 0x00000013,
    VDS_LPT_RAID03  = 0x00000015,
    VDS_LPT_RAID05  = 0x00000016,
    VDS_LPT_RAID10  = 0x00000017,
    VDS_LPT_RAID15  = 0x00000018,
    VDS_LPT_RAID30  = 0x00000019,
    VDS_LPT_RAID50  = 0x0000001a,
    VDS_LPT_RAID53  = 0x0000001c,
    VDS_LPT_RAID60  = 0x0000001d,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ne-vdshwprv-vds_lun_plex_status
alias VDS_LUN_PLEX_STATUS = int;
enum : int
{
    VDS_LPS_UNKNOWN   = 0x00000000,
    VDS_LPS_ONLINE    = 0x00000001,
    VDS_LPS_NOT_READY = 0x00000002,
    VDS_LPS_OFFLINE   = 0x00000004,
    VDS_LPS_FAILED    = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ne-vdshwprv-vds_lun_plex_flag
alias VDS_LUN_PLEX_FLAG = int;
enum : int
{
    VDS_LPF_LBN_REMAP_ENABLED = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ne-vdshwprv-vds_iscsi_portal_status
alias VDS_ISCSI_PORTAL_STATUS = int;
enum : int
{
    VDS_IPS_UNKNOWN   = 0x00000000,
    VDS_IPS_ONLINE    = 0x00000001,
    VDS_IPS_NOT_READY = 0x00000002,
    VDS_IPS_OFFLINE   = 0x00000004,
    VDS_IPS_FAILED    = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ne-vdshwprv-vds_storage_pool_status
alias VDS_STORAGE_POOL_STATUS = int;
enum : int
{
    VDS_SPS_UNKNOWN   = 0x00000000,
    VDS_SPS_ONLINE    = 0x00000001,
    VDS_SPS_NOT_READY = 0x00000002,
    VDS_SPS_OFFLINE   = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ne-vdshwprv-vds_storage_pool_type
alias VDS_STORAGE_POOL_TYPE = int;
enum : int
{
    VDS_SPT_UNKNOWN    = 0x00000000,
    VDS_SPT_PRIMORDIAL = 0x00000001,
    VDS_SPT_CONCRETE   = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ne-vdshwprv-vds_maintenance_operation
alias VDS_MAINTENANCE_OPERATION = int;
enum : int
{
    BlinkLight = 0x00000001,
    BeepAlarm  = 0x00000002,
    SpinDown   = 0x00000003,
    SpinUp     = 0x00000004,
    Ping       = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ne-vdshwprv-vds_raid_type
alias VDS_RAID_TYPE = int;
enum : int
{
    VDS_RT_UNKNOWN = 0x00000000,
    VDS_RT_RAID0   = 0x0000000a,
    VDS_RT_RAID1   = 0x0000000b,
    VDS_RT_RAID2   = 0x0000000c,
    VDS_RT_RAID3   = 0x0000000d,
    VDS_RT_RAID4   = 0x0000000e,
    VDS_RT_RAID5   = 0x0000000f,
    VDS_RT_RAID6   = 0x00000010,
    VDS_RT_RAID01  = 0x00000011,
    VDS_RT_RAID03  = 0x00000012,
    VDS_RT_RAID05  = 0x00000013,
    VDS_RT_RAID10  = 0x00000014,
    VDS_RT_RAID15  = 0x00000015,
    VDS_RT_RAID30  = 0x00000016,
    VDS_RT_RAID50  = 0x00000017,
    VDS_RT_RAID51  = 0x00000018,
    VDS_RT_RAID53  = 0x00000019,
    VDS_RT_RAID60  = 0x0000001a,
    VDS_RT_RAID61  = 0x0000001b,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/ne-vds-vds_vdisk_state
alias VDS_VDISK_STATE = int;
enum : int
{
    VDS_VST_UNKNOWN           = 0x00000000,
    VDS_VST_ADDED             = 0x00000001,
    VDS_VST_OPEN              = 0x00000002,
    VDS_VST_ATTACH_PENDING    = 0x00000003,
    VDS_VST_ATTACHED_NOT_OPEN = 0x00000004,
    VDS_VST_ATTACHED          = 0x00000005,
    VDS_VST_DETACH_PENDING    = 0x00000006,
    VDS_VST_COMPACTING        = 0x00000007,
    VDS_VST_MERGING           = 0x00000008,
    VDS_VST_EXPANDING         = 0x00000009,
    VDS_VST_DELETED           = 0x0000000a,
    VDS_VST_MAX               = 0x0000000b,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/ne-vds-vds_service_flag
alias VDS_SERVICE_FLAG = int;
enum : int
{
    VDS_SVF_SUPPORT_DYNAMIC            = 0x00000001,
    VDS_SVF_SUPPORT_FAULT_TOLERANT     = 0x00000002,
    VDS_SVF_SUPPORT_GPT                = 0x00000004,
    VDS_SVF_SUPPORT_DYNAMIC_1394       = 0x00000008,
    VDS_SVF_CLUSTER_SERVICE_CONFIGURED = 0x00000010,
    VDS_SVF_AUTO_MOUNT_OFF             = 0x00000020,
    VDS_SVF_OS_UNINSTALL_VALID         = 0x00000040,
    VDS_SVF_EFI                        = 0x00000080,
    VDS_SVF_SUPPORT_MIRROR             = 0x00000100,
    VDS_SVF_SUPPORT_RAID5              = 0x00000200,
    VDS_SVF_SUPPORT_REFS               = 0x00000400,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/ne-vds-vds_san_policy
alias VDS_SAN_POLICY = int;
enum : int
{
    VDS_SP_UNKNOWN          = 0x00000000,
    VDS_SP_ONLINE           = 0x00000001,
    VDS_SP_OFFLINE_SHARED   = 0x00000002,
    VDS_SP_OFFLINE          = 0x00000003,
    VDS_SP_OFFLINE_INTERNAL = 0x00000004,
    VDS_SP_MAX              = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/ne-vds-vds_drive_letter_flag
alias VDS_DRIVE_LETTER_FLAG = int;
enum : int
{
    VDS_DLF_NON_PERSISTENT = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/ne-vds-vds_file_system_flag
alias VDS_FILE_SYSTEM_FLAG = int;
enum : int
{
    VDS_FSF_SUPPORT_FORMAT          = 0x00000001,
    VDS_FSF_SUPPORT_QUICK_FORMAT    = 0x00000002,
    VDS_FSF_SUPPORT_COMPRESS        = 0x00000004,
    VDS_FSF_SUPPORT_SPECIFY_LABEL   = 0x00000008,
    VDS_FSF_SUPPORT_MOUNT_POINT     = 0x00000010,
    VDS_FSF_SUPPORT_REMOVABLE_MEDIA = 0x00000020,
    VDS_FSF_SUPPORT_EXTEND          = 0x00000040,
    VDS_FSF_ALLOCATION_UNIT_512     = 0x00010000,
    VDS_FSF_ALLOCATION_UNIT_1K      = 0x00020000,
    VDS_FSF_ALLOCATION_UNIT_2K      = 0x00040000,
    VDS_FSF_ALLOCATION_UNIT_4K      = 0x00080000,
    VDS_FSF_ALLOCATION_UNIT_8K      = 0x00100000,
    VDS_FSF_ALLOCATION_UNIT_16K     = 0x00200000,
    VDS_FSF_ALLOCATION_UNIT_32K     = 0x00400000,
    VDS_FSF_ALLOCATION_UNIT_64K     = 0x00800000,
    VDS_FSF_ALLOCATION_UNIT_128K    = 0x01000000,
    VDS_FSF_ALLOCATION_UNIT_256K    = 0x02000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/ne-vds-vds_file_system_format_support_flag
alias VDS_FILE_SYSTEM_FORMAT_SUPPORT_FLAG = int;
enum : int
{
    VDS_FSS_DEFAULT           = 0x00000001,
    VDS_FSS_PREVIOUS_REVISION = 0x00000002,
    VDS_FSS_RECOMMENDED       = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/ne-vds-vds_file_system_prop_flag
alias VDS_FILE_SYSTEM_PROP_FLAG = int;
enum : int
{
    VDS_FPF_COMPRESSED = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/ne-vds-vds_format_option_flags
alias VDS_FORMAT_OPTION_FLAGS = int;
enum : int
{
    VDS_FSOF_NONE               = 0x00000000,
    VDS_FSOF_FORCE              = 0x00000001,
    VDS_FSOF_QUICK              = 0x00000002,
    VDS_FSOF_COMPRESSION        = 0x00000004,
    VDS_FSOF_DUPLICATE_METADATA = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/ne-vds-vds_query_provider_flag
alias VDS_QUERY_PROVIDER_FLAG = int;
enum : int
{
    VDS_QUERY_SOFTWARE_PROVIDERS    = 0x00000001,
    VDS_QUERY_HARDWARE_PROVIDERS    = 0x00000002,
    VDS_QUERY_VIRTUALDISK_PROVIDERS = 0x00000004,
}

// Constants


enum : uint
{
    VDS_NF_VOLUME_ARRIVE              = 0x00000004U,
    VDS_NF_VOLUME_DEPART              = 0x00000005U,
    VDS_NF_VOLUME_MODIFY              = 0x00000006U,
    VDS_NF_VOLUME_REBUILDING_PROGRESS = 0x00000007U,
}

enum : uint
{
    VDS_NF_PARTITION_ARRIVE = 0x0000000bU,
    VDS_NF_PARTITION_DEPART = 0x0000000cU,
    VDS_NF_PARTITION_MODIFY = 0x0000000dU,
}

enum : uint
{
    VDS_NF_SUB_SYSTEM_ARRIVE = 0x00000065U,
    VDS_NF_SUB_SYSTEM_DEPART = 0x00000066U,
}

enum : uint
{
    VDS_NF_PORTAL_ARRIVE = 0x0000007bU,
    VDS_NF_PORTAL_DEPART = 0x0000007cU,
    VDS_NF_PORTAL_MODIFY = 0x0000007dU,
}

enum : uint
{
    VDS_NF_TARGET_ARRIVE = 0x0000007eU,
    VDS_NF_TARGET_DEPART = 0x0000007fU,
    VDS_NF_TARGET_MODIFY = 0x00000080U,
}

enum : uint
{
    VDS_NF_PORTAL_GROUP_ARRIVE = 0x00000081U,
    VDS_NF_PORTAL_GROUP_DEPART = 0x00000082U,
    VDS_NF_PORTAL_GROUP_MODIFY = 0x00000083U,
}

enum uint VDS_NF_SUB_SYSTEM_MODIFY = 0x00000097U;

enum : uint
{
    VDS_NF_DRIVE_LETTER_FREE   = 0x000000c9U,
    VDS_NF_DRIVE_LETTER_ASSIGN = 0x000000caU,
}

enum uint VDS_NF_MOUNT_POINTS_CHANGE = 0x000000cdU;
enum uint VDS_NF_FILE_SYSTEM_SHRINKING_PROGRESS = 0x000000ceU;
enum uint VDS_NF_SERVICE_OUT_OF_SYNC = 0x0000012dU;
enum uint GPT_PARTITION_NAME_LENGTH = 0x00000024U;
enum int VDS_HINT_FASTCRASHRECOVERYREQUIRED = 0x00000001;

enum : int
{
    VDS_HINT_MOSTLYREADS                 = 0x00000002,
    VDS_HINT_OPTIMIZEFORSEQUENTIALREADS  = 0x00000004,
    VDS_HINT_OPTIMIZEFORSEQUENTIALWRITES = 0x00000008,
}

enum int VDS_HINT_READBACKVERIFYENABLED = 0x00000010;

enum : int
{
    VDS_HINT_REMAPENABLED               = 0x00000020,
    VDS_HINT_WRITETHROUGHCACHINGENABLED = 0x00000040,
}

enum int VDS_HINT_HARDWARECHECKSUMENABLED = 0x00000080;

enum : int
{
    VDS_HINT_ISYANKABLE       = 0x00000100,
    VDS_HINT_ALLOCATEHOTSPARE = 0x00000200,
}

enum : int
{
    VDS_HINT_BUSTYPE          = 0x00000400,
    VDS_HINT_USEMIRROREDCACHE = 0x00000800,
}

enum int VDS_HINT_READCACHINGENABLED = 0x00001000;
enum int VDS_HINT_WRITECACHINGENABLED = 0x00002000;
enum int VDS_HINT_MEDIASCANENABLED = 0x00004000;
enum int VDS_HINT_CONSISTENCYCHECKENABLED = 0x00008000;

enum : uint
{
    VDS_REBUILD_PRIORITY_MIN = 0x00000000U,
    VDS_REBUILD_PRIORITY_MAX = 0x00000010U,
}

enum : int
{
    VDS_POOL_ATTRIB_RAIDTYPE         = 0x00000001,
    VDS_POOL_ATTRIB_BUSTYPE          = 0x00000002,
    VDS_POOL_ATTRIB_ALLOW_SPINDOWN   = 0x00000004,
    VDS_POOL_ATTRIB_THIN_PROVISION   = 0x00000008,
    VDS_POOL_ATTRIB_NO_SINGLE_POF    = 0x00000010,
    VDS_POOL_ATTRIB_DATA_RDNCY_MAX   = 0x00000020,
    VDS_POOL_ATTRIB_DATA_RDNCY_MIN   = 0x00000040,
    VDS_POOL_ATTRIB_DATA_RDNCY_DEF   = 0x00000080,
    VDS_POOL_ATTRIB_PKG_RDNCY_MAX    = 0x00000100,
    VDS_POOL_ATTRIB_PKG_RDNCY_MIN    = 0x00000200,
    VDS_POOL_ATTRIB_PKG_RDNCY_DEF    = 0x00000400,
    VDS_POOL_ATTRIB_STRIPE_SIZE      = 0x00000800,
    VDS_POOL_ATTRIB_STRIPE_SIZE_MAX  = 0x00001000,
    VDS_POOL_ATTRIB_STRIPE_SIZE_MIN  = 0x00002000,
    VDS_POOL_ATTRIB_STRIPE_SIZE_DEF  = 0x00004000,
    VDS_POOL_ATTRIB_NUM_CLMNS        = 0x00008000,
    VDS_POOL_ATTRIB_NUM_CLMNS_MAX    = 0x00010000,
    VDS_POOL_ATTRIB_NUM_CLMNS_MIN    = 0x00020000,
    VDS_POOL_ATTRIB_NUM_CLMNS_DEF    = 0x00040000,
    VDS_POOL_ATTRIB_DATA_AVL_HINT    = 0x00080000,
    VDS_POOL_ATTRIB_ACCS_RNDM_HINT   = 0x00100000,
    VDS_POOL_ATTRIB_ACCS_DIR_HINT    = 0x00200000,
    VDS_POOL_ATTRIB_ACCS_SIZE_HINT   = 0x00400000,
    VDS_POOL_ATTRIB_ACCS_LTNCY_HINT  = 0x00800000,
    VDS_POOL_ATTRIB_ACCS_BDW_WT_HINT = 0x01000000,
    VDS_POOL_ATTRIB_STOR_COST_HINT   = 0x02000000,
    VDS_POOL_ATTRIB_STOR_EFFCY_HINT  = 0x04000000,
    VDS_POOL_ATTRIB_CUSTOM_ATTRIB    = 0x08000000,
}

enum uint VDS_ATTACH_VIRTUAL_DISK_FLAG_USE_FILE_ACL = 0x00000001U;

enum : GUID
{
    CLSID_VdsLoader  = GUID("9c38ed61-d565-4728-aeee-c80952f0ecde"),
    CLSID_VdsService = GUID("7d1933cb-86f6-4a98-8628-01be94c9a575"),
}

enum : uint
{
    MAX_FS_NAME_SIZE                = 0x00000008U,
    MAX_FS_FORMAT_SUPPORT_NAME_SIZE = 0x00000020U,
}

enum uint MAX_FS_ALLOWED_CLUSTER_SIZES_SIZE = 0x00000020U;
enum uint VER_VDS_LUN_INFORMATION = 0x00000001U;
enum HRESULT VDS_E_NOT_SUPPORTED = HRESULT(0x80042400);

enum : HRESULT
{
    VDS_E_INITIALIZED_FAILED    = HRESULT(0x80042401),
    VDS_E_INITIALIZE_NOT_CALLED = HRESULT(0x80042402),
}

enum HRESULT VDS_E_ALREADY_REGISTERED = HRESULT(0x80042403);
enum HRESULT VDS_E_ANOTHER_CALL_IN_PROGRESS = HRESULT(0x80042404);
enum HRESULT VDS_E_OBJECT_NOT_FOUND = HRESULT(0x80042405);
enum HRESULT VDS_E_INVALID_SPACE = HRESULT(0x80042406);

enum : HRESULT
{
    VDS_E_PARTITION_LIMIT_REACHED = HRESULT(0x80042407),
    VDS_E_PARTITION_NOT_EMPTY     = HRESULT(0x80042408),
}

enum : HRESULT
{
    VDS_E_OPERATION_PENDING = HRESULT(0x80042409),
    VDS_E_OPERATION_DENIED  = HRESULT(0x8004240a),
}

enum HRESULT VDS_E_OBJECT_DELETED = HRESULT(0x8004240b);
enum HRESULT VDS_E_CANCEL_TOO_LATE = HRESULT(0x8004240c);
enum HRESULT VDS_E_OPERATION_CANCELED = HRESULT(0x8004240d);
enum HRESULT VDS_E_CANNOT_EXTEND = HRESULT(0x8004240e);

enum : HRESULT
{
    VDS_E_NOT_ENOUGH_SPACE = HRESULT(0x8004240f),
    VDS_E_NOT_ENOUGH_DRIVE = HRESULT(0x80042410),
}

enum HRESULT VDS_E_BAD_COOKIE = HRESULT(0x80042411);

enum : HRESULT
{
    VDS_E_NO_MEDIA      = HRESULT(0x80042412),
    VDS_E_DEVICE_IN_USE = HRESULT(0x80042413),
}

enum HRESULT VDS_E_DISK_NOT_EMPTY = HRESULT(0x80042414);
enum HRESULT VDS_E_INVALID_OPERATION = HRESULT(0x80042415);
enum HRESULT VDS_E_PATH_NOT_FOUND = HRESULT(0x80042416);
enum HRESULT VDS_E_DISK_NOT_INITIALIZED = HRESULT(0x80042417);
enum HRESULT VDS_E_NOT_AN_UNALLOCATED_DISK = HRESULT(0x80042418);
enum HRESULT VDS_E_UNRECOVERABLE_ERROR = HRESULT(0x80042419);
enum HRESULT VDS_S_DISK_PARTIALLY_CLEANED = HRESULT(0x0004241a);
enum HRESULT VDS_E_DMADMIN_SERVICE_CONNECTION_FAILED = HRESULT(0x8004241b);
enum HRESULT VDS_E_PROVIDER_INITIALIZATION_FAILED = HRESULT(0x8004241c);
enum HRESULT VDS_E_OBJECT_EXISTS = HRESULT(0x8004241d);
enum HRESULT VDS_E_NO_DISKS_FOUND = HRESULT(0x8004241e);
enum HRESULT VDS_E_PROVIDER_CACHE_CORRUPT = HRESULT(0x8004241f);
enum HRESULT VDS_E_DMADMIN_METHOD_CALL_FAILED = HRESULT(0x80042420);
enum HRESULT VDS_S_PROVIDER_ERROR_LOADING_CACHE = HRESULT(0x00042421);

enum : HRESULT
{
    VDS_E_PROVIDER_VOL_DEVICE_NAME_NOT_FOUND = HRESULT(0x80042422),
    VDS_E_PROVIDER_VOL_OPEN                  = HRESULT(0x80042423),
}

enum HRESULT VDS_E_DMADMIN_CORRUPT_NOTIFICATION = HRESULT(0x80042424);

enum : HRESULT
{
    VDS_E_INCOMPATIBLE_FILE_SYSTEM = HRESULT(0x80042425),
    VDS_E_INCOMPATIBLE_MEDIA       = HRESULT(0x80042426),
}

enum HRESULT VDS_E_ACCESS_DENIED = HRESULT(0x80042427);
enum HRESULT VDS_E_MEDIA_WRITE_PROTECTED = HRESULT(0x80042428);
enum HRESULT VDS_E_BAD_LABEL = HRESULT(0x80042429);
enum HRESULT VDS_E_CANT_QUICK_FORMAT = HRESULT(0x8004242a);

enum : HRESULT
{
    VDS_E_IO_ERROR         = HRESULT(0x8004242b),
    VDS_E_VOLUME_TOO_SMALL = HRESULT(0x8004242c),
    VDS_E_VOLUME_TOO_BIG   = HRESULT(0x8004242d),
}

enum : HRESULT
{
    VDS_E_CLUSTER_SIZE_TOO_SMALL      = HRESULT(0x8004242e),
    VDS_E_CLUSTER_SIZE_TOO_BIG        = HRESULT(0x8004242f),
    VDS_E_CLUSTER_COUNT_BEYOND_32BITS = HRESULT(0x80042430),
}

enum HRESULT VDS_E_OBJECT_STATUS_FAILED = HRESULT(0x80042431);
enum HRESULT VDS_E_VOLUME_INCOMPLETE = HRESULT(0x80042432);
enum HRESULT VDS_E_EXTENT_SIZE_LESS_THAN_MIN = HRESULT(0x80042433);
enum HRESULT VDS_S_UPDATE_BOOTFILE_FAILED = HRESULT(0x00042434);
enum HRESULT VDS_S_BOOT_PARTITION_NUMBER_CHANGE = HRESULT(0x00042436);
enum HRESULT VDS_E_BOOT_PARTITION_NUMBER_CHANGE = HRESULT(0x80042436);
enum HRESULT VDS_E_NO_FREE_SPACE = HRESULT(0x80042437);
enum HRESULT VDS_E_ACTIVE_PARTITION = HRESULT(0x80042438);
enum HRESULT VDS_E_PARTITION_OF_UNKNOWN_TYPE = HRESULT(0x80042439);
enum HRESULT VDS_E_LEGACY_VOLUME_FORMAT = HRESULT(0x8004243a);
enum HRESULT VDS_E_NON_CONTIGUOUS_DATA_PARTITIONS = HRESULT(0x8004243b);
enum HRESULT VDS_E_MIGRATE_OPEN_VOLUME = HRESULT(0x8004243c);

enum : HRESULT
{
    VDS_E_VOLUME_NOT_ONLINE  = HRESULT(0x8004243d),
    VDS_E_VOLUME_NOT_HEALTHY = HRESULT(0x8004243e),
    VDS_E_VOLUME_SPANS_DISKS = HRESULT(0x8004243f),
}

enum HRESULT VDS_E_REQUIRES_CONTIGUOUS_DISK_SPACE = HRESULT(0x80042440);
enum HRESULT VDS_E_BAD_PROVIDER_DATA = HRESULT(0x80042441);
enum HRESULT VDS_E_PROVIDER_FAILURE = HRESULT(0x80042442);
enum HRESULT VDS_S_VOLUME_COMPRESS_FAILED = HRESULT(0x00042443);
enum HRESULT VDS_E_PACK_OFFLINE = HRESULT(0x80042444);
enum HRESULT VDS_E_VOLUME_NOT_A_MIRROR = HRESULT(0x80042445);
enum HRESULT VDS_E_NO_EXTENTS_FOR_VOLUME = HRESULT(0x80042446);
enum HRESULT VDS_E_DISK_NOT_LOADED_TO_CACHE = HRESULT(0x80042447);
enum HRESULT VDS_E_INTERNAL_ERROR = HRESULT(0x80042448);
enum HRESULT VDS_S_ACCESS_PATH_NOT_DELETED = HRESULT(0x00044244);
enum HRESULT VDS_E_PROVIDER_TYPE_NOT_SUPPORTED = HRESULT(0x8004244a);

enum : HRESULT
{
    VDS_E_DISK_NOT_ONLINE       = HRESULT(0x8004244b),
    VDS_E_DISK_IN_USE_BY_VOLUME = HRESULT(0x8004244c),
}

enum HRESULT VDS_S_IN_PROGRESS = HRESULT(0x0004244d);
enum HRESULT VDS_E_ASYNC_OBJECT_FAILURE = HRESULT(0x8004244e);
enum HRESULT VDS_E_VOLUME_NOT_MOUNTED = HRESULT(0x8004244f);
enum HRESULT VDS_E_PACK_NOT_FOUND = HRESULT(0x80042450);
enum HRESULT VDS_E_IMPORT_SET_INCOMPLETE = HRESULT(0x80042451);
enum HRESULT VDS_E_DISK_NOT_IMPORTED = HRESULT(0x80042452);
enum HRESULT VDS_E_OBJECT_OUT_OF_SYNC = HRESULT(0x80042453);
enum HRESULT VDS_E_MISSING_DISK = HRESULT(0x80042454);
enum HRESULT VDS_E_DISK_PNP_REG_CORRUPT = HRESULT(0x80042455);
enum HRESULT VDS_E_LBN_REMAP_ENABLED_FLAG = HRESULT(0x80042456);
enum HRESULT VDS_E_NO_DRIVELETTER_FLAG = HRESULT(0x80042457);

enum : HRESULT
{
    VDS_E_REVERT_ON_CLOSE     = HRESULT(0x80042458),
    VDS_E_REVERT_ON_CLOSE_SET = HRESULT(0x80042459),
}

enum HRESULT VDS_E_IA64_BOOT_MIRRORED_TO_MBR = HRESULT(0x8004245a);
enum HRESULT VDS_S_IA64_BOOT_MIRRORED_TO_MBR = HRESULT(0x0004245a);
enum HRESULT VDS_S_UNABLE_TO_GET_GPT_ATTRIBUTES = HRESULT(0x0004245b);
enum HRESULT VDS_E_VOLUME_TEMPORARILY_DISMOUNTED = HRESULT(0x8004245c);
enum HRESULT VDS_E_VOLUME_PERMANENTLY_DISMOUNTED = HRESULT(0x8004245d);
enum HRESULT VDS_E_VOLUME_HAS_PATH = HRESULT(0x8004245e);

enum : HRESULT
{
    VDS_E_TIMEOUT            = HRESULT(0x8004245f),
    VDS_E_REPAIR_VOLUMESTATE = HRESULT(0x80042460),
}

enum HRESULT VDS_E_LDM_TIMEOUT = HRESULT(0x80042461);
enum HRESULT VDS_E_REVERT_ON_CLOSE_MISMATCH = HRESULT(0x80042462);

enum : HRESULT
{
    VDS_E_RETRY              = HRESULT(0x80042463),
    VDS_E_ONLINE_PACK_EXISTS = HRESULT(0x80042464),
}

enum HRESULT VDS_S_EXTEND_FILE_SYSTEM_FAILED = HRESULT(0x00042465);
enum HRESULT VDS_E_EXTEND_FILE_SYSTEM_FAILED = HRESULT(0x80042466);
enum HRESULT VDS_S_MBR_BOOT_MIRRORED_TO_GPT = HRESULT(0x00042467);
enum HRESULT VDS_E_MAX_USABLE_MBR = HRESULT(0x80042468);
enum HRESULT VDS_S_GPT_BOOT_MIRRORED_TO_MBR = HRESULT(0x80042469);
enum HRESULT VDS_E_NO_SOFTWARE_PROVIDERS_LOADED = HRESULT(0x80042500);
enum HRESULT VDS_E_DISK_NOT_MISSING = HRESULT(0x80042501);
enum HRESULT VDS_E_NO_VOLUME_LAYOUT = HRESULT(0x80042502);
enum HRESULT VDS_E_CORRUPT_VOLUME_INFO = HRESULT(0x80042503);
enum HRESULT VDS_E_INVALID_ENUMERATOR = HRESULT(0x80042504);
enum HRESULT VDS_E_DRIVER_INTERNAL_ERROR = HRESULT(0x80042505);
enum HRESULT VDS_E_VOLUME_INVALID_NAME = HRESULT(0x80042507);
enum HRESULT VDS_S_DISK_IS_MISSING = HRESULT(0x00042508);
enum HRESULT VDS_E_CORRUPT_PARTITION_INFO = HRESULT(0x80042509);
enum HRESULT VDS_S_NONCONFORMANT_PARTITION_INFO = HRESULT(0x0004250a);
enum HRESULT VDS_E_CORRUPT_EXTENT_INFO = HRESULT(0x8004250b);
enum HRESULT VDS_E_DUP_EMPTY_PACK_GUID = HRESULT(0x8004250c);
enum HRESULT VDS_E_DRIVER_NO_PACK_NAME = HRESULT(0x8004250d);
enum HRESULT VDS_S_SYSTEM_PARTITION = HRESULT(0x0004250e);
enum HRESULT VDS_E_BAD_PNP_MESSAGE = HRESULT(0x8004250f);

enum : HRESULT
{
    VDS_E_NO_PNP_DISK_ARRIVE   = HRESULT(0x80042510),
    VDS_E_NO_PNP_VOLUME_ARRIVE = HRESULT(0x80042511),
    VDS_E_NO_PNP_DISK_REMOVE   = HRESULT(0x80042512),
    VDS_E_NO_PNP_VOLUME_REMOVE = HRESULT(0x80042513),
}

enum HRESULT VDS_E_PROVIDER_EXITING = HRESULT(0x80042514);
enum HRESULT VDS_E_EXTENT_EXCEEDS_DISK_FREE_SPACE = HRESULT(0x80042515);
enum HRESULT VDS_E_MEMBER_SIZE_INVALID = HRESULT(0x80042516);
enum HRESULT VDS_S_NO_NOTIFICATION = HRESULT(0x00042517);
enum HRESULT VDS_S_DEFAULT_PLEX_MEMBER_IDS = HRESULT(0x00042518);

enum : HRESULT
{
    VDS_E_INVALID_DISK = HRESULT(0x80042519),
    VDS_E_INVALID_PACK = HRESULT(0x8004251a),
}

enum HRESULT VDS_E_VOLUME_ON_DISK = HRESULT(0x8004251b);
enum HRESULT VDS_E_DRIVER_INVALID_PARAM = HRESULT(0x8004251c);
enum HRESULT VDS_E_TARGET_PACK_NOT_EMPTY = HRESULT(0x8004251d);
enum HRESULT VDS_E_CANNOT_SHRINK = HRESULT(0x8004251e);
enum HRESULT VDS_E_MULTIPLE_PACKS = HRESULT(0x8004251f);
enum HRESULT VDS_E_PACK_ONLINE = HRESULT(0x80042520);

enum : HRESULT
{
    VDS_E_INVALID_PLEX_COUNT   = HRESULT(0x80042521),
    VDS_E_INVALID_MEMBER_COUNT = HRESULT(0x80042522),
    VDS_E_INVALID_PLEX_ORDER   = HRESULT(0x80042523),
    VDS_E_INVALID_MEMBER_ORDER = HRESULT(0x80042524),
    VDS_E_INVALID_STRIPE_SIZE  = HRESULT(0x80042525),
    VDS_E_INVALID_DISK_COUNT   = HRESULT(0x80042526),
    VDS_E_INVALID_EXTENT_COUNT = HRESULT(0x80042527),
}

enum HRESULT VDS_E_SOURCE_IS_TARGET_PACK = HRESULT(0x80042528);
enum HRESULT VDS_E_VOLUME_DISK_COUNT_MAX_EXCEEDED = HRESULT(0x80042529);
enum HRESULT VDS_E_CORRUPT_NOTIFICATION_INFO = HRESULT(0x8004252a);
enum HRESULT VDS_E_INVALID_PLEX_GUID = HRESULT(0x8004252c);
enum HRESULT VDS_E_DISK_NOT_FOUND_IN_PACK = HRESULT(0x8004252d);
enum HRESULT VDS_E_DUPLICATE_DISK = HRESULT(0x8004252e);
enum HRESULT VDS_E_LAST_VALID_DISK = HRESULT(0x8004252f);
enum HRESULT VDS_E_INVALID_SECTOR_SIZE = HRESULT(0x80042530);
enum HRESULT VDS_E_ONE_EXTENT_PER_DISK = HRESULT(0x80042531);
enum HRESULT VDS_E_INVALID_BLOCK_SIZE = HRESULT(0x80042532);
enum HRESULT VDS_E_PLEX_SIZE_INVALID = HRESULT(0x80042533);
enum HRESULT VDS_E_NO_EXTENTS_FOR_PLEX = HRESULT(0x80042534);

enum : HRESULT
{
    VDS_E_INVALID_PLEX_TYPE       = HRESULT(0x80042535),
    VDS_E_INVALID_PLEX_BLOCK_SIZE = HRESULT(0x80042536),
}

enum HRESULT VDS_E_NO_HEALTHY_DISKS = HRESULT(0x80042537);
enum HRESULT VDS_E_CONFIG_LIMIT = HRESULT(0x80042538);

enum : HRESULT
{
    VDS_E_DISK_CONFIGURATION_CORRUPTED     = HRESULT(0x80042539),
    VDS_E_DISK_CONFIGURATION_NOT_IN_SYNC   = HRESULT(0x8004253a),
    VDS_E_DISK_CONFIGURATION_UPDATE_FAILED = HRESULT(0x8004253b),
}

enum HRESULT VDS_E_DISK_DYNAMIC = HRESULT(0x8004253c);
enum HRESULT VDS_E_DRIVER_OBJECT_NOT_FOUND = HRESULT(0x8004253d);
enum HRESULT VDS_E_PARTITION_NOT_CYLINDER_ALIGNED = HRESULT(0x8004253e);
enum HRESULT VDS_E_DISK_LAYOUT_PARTITIONS_TOO_SMALL = HRESULT(0x8004253f);
enum HRESULT VDS_E_DISK_IO_FAILING = HRESULT(0x80042540);
enum HRESULT VDS_E_DYNAMIC_DISKS_NOT_SUPPORTED = HRESULT(0x80042541);
enum HRESULT VDS_E_FAULT_TOLERANT_DISKS_NOT_SUPPORTED = HRESULT(0x80042542);
enum HRESULT VDS_E_GPT_ATTRIBUTES_INVALID = HRESULT(0x80042543);

enum : HRESULT
{
    VDS_E_MEMBER_IS_HEALTHY   = HRESULT(0x80042544),
    VDS_E_MEMBER_REGENERATING = HRESULT(0x80042545),
}

enum HRESULT VDS_E_PACK_NAME_INVALID = HRESULT(0x80042546);

enum : HRESULT
{
    VDS_E_PLEX_IS_HEALTHY  = HRESULT(0x80042547),
    VDS_E_PLEX_LAST_ACTIVE = HRESULT(0x80042548),
    VDS_E_PLEX_MISSING     = HRESULT(0x80042549),
}

enum HRESULT VDS_E_MEMBER_MISSING = HRESULT(0x8004254a);
enum HRESULT VDS_E_PLEX_REGENERATING = HRESULT(0x8004254b);
enum HRESULT VDS_E_UNEXPECTED_DISK_LAYOUT_CHANGE = HRESULT(0x8004254d);
enum HRESULT VDS_E_INVALID_VOLUME_LENGTH = HRESULT(0x8004254e);
enum HRESULT VDS_E_VOLUME_LENGTH_NOT_SECTOR_SIZE_MULTIPLE = HRESULT(0x8004254f);

enum : HRESULT
{
    VDS_E_VOLUME_NOT_RETAINED = HRESULT(0x80042550),
    VDS_E_VOLUME_RETAINED     = HRESULT(0x80042551),
}

enum HRESULT VDS_E_ALIGN_BEYOND_FIRST_CYLINDER = HRESULT(0x80042553);

enum : HRESULT
{
    VDS_E_ALIGN_NOT_SECTOR_SIZE_MULTIPLE = HRESULT(0x80042554),
    VDS_E_ALIGN_NOT_ZERO                 = HRESULT(0x80042555),
}

enum : HRESULT
{
    VDS_E_CACHE_CORRUPT            = HRESULT(0x80042556),
    VDS_E_CANNOT_CLEAR_VOLUME_FLAG = HRESULT(0x80042557),
}

enum : HRESULT
{
    VDS_E_DISK_BEING_CLEANED        = HRESULT(0x80042558),
    VDS_E_DISK_NOT_CONVERTIBLE      = HRESULT(0x80042559),
    VDS_E_DISK_REMOVEABLE           = HRESULT(0x8004255a),
    VDS_E_DISK_REMOVEABLE_NOT_EMPTY = HRESULT(0x8004255b),
}

enum HRESULT VDS_E_DRIVE_LETTER_NOT_FREE = HRESULT(0x8004255c);
enum HRESULT VDS_E_EXTEND_MULTIPLE_DISKS_NOT_SUPPORTED = HRESULT(0x8004255d);

enum : HRESULT
{
    VDS_E_INVALID_DRIVE_LETTER            = HRESULT(0x8004255e),
    VDS_E_INVALID_DRIVE_LETTER_COUNT      = HRESULT(0x8004255f),
    VDS_E_INVALID_FS_FLAG                 = HRESULT(0x80042560),
    VDS_E_INVALID_FS_TYPE                 = HRESULT(0x80042561),
    VDS_E_INVALID_OBJECT_TYPE             = HRESULT(0x80042562),
    VDS_E_INVALID_PARTITION_LAYOUT        = HRESULT(0x80042563),
    VDS_E_INVALID_PARTITION_STYLE         = HRESULT(0x80042564),
    VDS_E_INVALID_PARTITION_TYPE          = HRESULT(0x80042565),
    VDS_E_INVALID_PROVIDER_CLSID          = HRESULT(0x80042566),
    VDS_E_INVALID_PROVIDER_ID             = HRESULT(0x80042567),
    VDS_E_INVALID_PROVIDER_NAME           = HRESULT(0x80042568),
    VDS_E_INVALID_PROVIDER_TYPE           = HRESULT(0x80042569),
    VDS_E_INVALID_PROVIDER_VERSION_GUID   = HRESULT(0x8004256a),
    VDS_E_INVALID_PROVIDER_VERSION_STRING = HRESULT(0x8004256b),
}

enum : HRESULT
{
    VDS_E_INVALID_QUERY_PROVIDER_FLAG = HRESULT(0x8004256c),
    VDS_E_INVALID_SERVICE_FLAG        = HRESULT(0x8004256d),
    VDS_E_INVALID_VOLUME_FLAG         = HRESULT(0x8004256e),
}

enum : HRESULT
{
    VDS_E_PARTITION_NOT_OEM        = HRESULT(0x8004256f),
    VDS_E_PARTITION_PROTECTED      = HRESULT(0x80042570),
    VDS_E_PARTITION_STYLE_MISMATCH = HRESULT(0x80042571),
}

enum HRESULT VDS_E_PROVIDER_INTERNAL_ERROR = HRESULT(0x80042572);

enum : HRESULT
{
    VDS_E_SHRINK_SIZE_LESS_THAN_MIN = HRESULT(0x80042573),
    VDS_E_SHRINK_SIZE_TOO_BIG       = HRESULT(0x80042574),
}

enum HRESULT VDS_E_UNRECOVERABLE_PROVIDER_ERROR = HRESULT(0x80042575);
enum HRESULT VDS_E_VOLUME_HIDDEN = HRESULT(0x80042576);
enum HRESULT VDS_S_DISMOUNT_FAILED = HRESULT(0x00042577);
enum HRESULT VDS_S_REMOUNT_FAILED = HRESULT(0x00042578);
enum HRESULT VDS_E_FLAG_ALREADY_SET = HRESULT(0x80042579);
enum HRESULT VDS_S_RESYNC_NOTIFICATION_TASK_FAILED = HRESULT(0x0004257a);
enum HRESULT VDS_E_DISTINCT_VOLUME = HRESULT(0x8004257b);
enum HRESULT VDS_E_VOLUME_NOT_FOUND_IN_PACK = HRESULT(0x8004257c);
enum HRESULT VDS_E_PARTITION_NON_DATA = HRESULT(0x8004257d);
enum HRESULT VDS_E_CRITICAL_PLEX = HRESULT(0x8004257e);

enum : HRESULT
{
    VDS_E_VOLUME_SYNCHRONIZING = HRESULT(0x8004257f),
    VDS_E_VOLUME_REGENERATING  = HRESULT(0x80042580),
}

enum HRESULT VDS_S_VSS_FLUSH_AND_HOLD_WRITES = HRESULT(0x00042581);
enum HRESULT VDS_S_VSS_RELEASE_WRITES = HRESULT(0x00042582);
enum HRESULT VDS_S_FS_LOCK = HRESULT(0x00042583);

enum : HRESULT
{
    VDS_E_READONLY            = HRESULT(0x80042584),
    VDS_E_INVALID_VOLUME_TYPE = HRESULT(0x80042585),
}

enum HRESULT VDS_E_BAD_BOOT_DISK = HRESULT(0x80042586);
enum HRESULT VDS_E_LOG_UPDATE = HRESULT(0x80042587);

enum : HRESULT
{
    VDS_E_VOLUME_MIRRORED       = HRESULT(0x80042588),
    VDS_E_VOLUME_SIMPLE_SPANNED = HRESULT(0x80042589),
}

enum HRESULT VDS_E_NO_VALID_LOG_COPIES = HRESULT(0x8004258a);
enum HRESULT VDS_S_PLEX_NOT_LOADED_TO_CACHE = HRESULT(0x0004258b);
enum HRESULT VDS_E_PLEX_NOT_LOADED_TO_CACHE = HRESULT(0x8004258b);

enum : HRESULT
{
    VDS_E_PARTITION_MSR = HRESULT(0x8004258c),
    VDS_E_PARTITION_LDM = HRESULT(0x8004258d),
}

enum HRESULT VDS_S_WINPE_BOOTENTRY = HRESULT(0x0004258e);
enum HRESULT VDS_E_ALIGN_NOT_A_POWER_OF_TWO = HRESULT(0x8004258f);
enum HRESULT VDS_E_ALIGN_IS_ZERO = HRESULT(0x80042590);
enum HRESULT VDS_E_SHRINK_IN_PROGRESS = HRESULT(0x80042591);
enum HRESULT VDS_E_CANT_INVALIDATE_FVE = HRESULT(0x80042592);
enum HRESULT VDS_E_FS_NOT_DETERMINED = HRESULT(0x80042593);
enum HRESULT VDS_E_DISK_NOT_OFFLINE = HRESULT(0x80042595);

enum : HRESULT
{
    VDS_E_FAILED_TO_ONLINE_DISK  = HRESULT(0x80042596),
    VDS_E_FAILED_TO_OFFLINE_DISK = HRESULT(0x80042597),
}

enum HRESULT VDS_E_BAD_REVISION_NUMBER = HRESULT(0x80042598);

enum : HRESULT
{
    VDS_E_SHRINK_USER_CANCELLED = HRESULT(0x80042599),
    VDS_E_SHRINK_DIRTY_VOLUME   = HRESULT(0x8004259a),
}

enum HRESULT VDS_S_NAME_TRUNCATED = HRESULT(0x00042700);
enum HRESULT VDS_E_NAME_NOT_UNIQUE = HRESULT(0x80042701);
enum HRESULT VDS_S_STATUSES_INCOMPLETELY_SET = HRESULT(0x00042702);
enum HRESULT VDS_E_ADDRESSES_INCOMPLETELY_SET = HRESULT(0x80042703);
enum HRESULT VDS_E_SECURITY_INCOMPLETELY_SET = HRESULT(0x80042705);
enum HRESULT VDS_E_TARGET_SPECIFIC_NOT_SUPPORTED = HRESULT(0x80042706);
enum HRESULT VDS_E_INITIATOR_SPECIFIC_NOT_SUPPORTED = HRESULT(0x80042707);

enum : HRESULT
{
    VDS_E_ISCSI_LOGIN_FAILED      = HRESULT(0x80042708),
    VDS_E_ISCSI_LOGOUT_FAILED     = HRESULT(0x80042709),
    VDS_E_ISCSI_SESSION_NOT_FOUND = HRESULT(0x8004270a),
}

enum : HRESULT
{
    VDS_E_ASSOCIATED_LUNS_EXIST    = HRESULT(0x8004270b),
    VDS_E_ASSOCIATED_PORTALS_EXIST = HRESULT(0x8004270c),
}

enum HRESULT VDS_E_NO_DISCOVERY_DOMAIN = HRESULT(0x8004270d);
enum HRESULT VDS_E_MULTIPLE_DISCOVERY_DOMAINS = HRESULT(0x8004270e);
enum HRESULT VDS_E_NO_DISK_PATHNAME = HRESULT(0x8004270f);
enum HRESULT VDS_E_ISCSI_LOGOUT_INCOMPLETE = HRESULT(0x80042710);
enum HRESULT VDS_E_NO_VOLUME_PATHNAME = HRESULT(0x80042711);
enum HRESULT VDS_E_PROVIDER_CACHE_OUTOFSYNC = HRESULT(0x80042712);
enum HRESULT VDS_E_NO_IMPORT_TARGET = HRESULT(0x80042713);
enum HRESULT VDS_S_ALREADY_EXISTS = HRESULT(0x00042714);
enum HRESULT VDS_S_PROPERTIES_INCOMPLETE = HRESULT(0x00042715);
enum HRESULT VDS_S_ISCSI_SESSION_NOT_FOUND_PERSISTENT_LOGIN_REMOVED = HRESULT(0x00042800);
enum HRESULT VDS_S_ISCSI_PERSISTENT_LOGIN_MAY_NOT_BE_REMOVED = HRESULT(0x00042801);
enum HRESULT VDS_S_ISCSI_LOGIN_ALREAD_EXISTS = HRESULT(0x00042802);
enum HRESULT VDS_E_UNABLE_TO_FIND_BOOT_DISK = HRESULT(0x80042803);
enum HRESULT VDS_E_INCORRECT_BOOT_VOLUME_EXTENT_INFO = HRESULT(0x80042804);
enum HRESULT VDS_E_GET_SAN_POLICY = HRESULT(0x80042805);
enum HRESULT VDS_E_SET_SAN_POLICY = HRESULT(0x80042806);
enum HRESULT VDS_E_BOOT_DISK = HRESULT(0x80042807);

enum : HRESULT
{
    VDS_S_DISK_MOUNT_FAILED    = HRESULT(0x00042808),
    VDS_S_DISK_DISMOUNT_FAILED = HRESULT(0x00042809),
}

enum : HRESULT
{
    VDS_E_DISK_IS_OFFLINE   = HRESULT(0x8004280a),
    VDS_E_DISK_IS_READ_ONLY = HRESULT(0x8004280b),
}

enum HRESULT VDS_E_PAGEFILE_DISK = HRESULT(0x8004280c);
enum HRESULT VDS_E_HIBERNATION_FILE_DISK = HRESULT(0x8004280d);
enum HRESULT VDS_E_CRASHDUMP_DISK = HRESULT(0x8004280e);
enum HRESULT VDS_E_UNABLE_TO_FIND_SYSTEM_DISK = HRESULT(0x8004280f);
enum HRESULT VDS_E_INCORRECT_SYSTEM_VOLUME_EXTENT_INFO = HRESULT(0x80042810);
enum HRESULT VDS_E_SYSTEM_DISK = HRESULT(0x80042811);

enum : HRESULT
{
    VDS_E_VOLUME_SHRINK_FVE_LOCKED   = HRESULT(0x80042812),
    VDS_E_VOLUME_SHRINK_FVE_CORRUPT  = HRESULT(0x80042813),
    VDS_E_VOLUME_SHRINK_FVE_RECOVERY = HRESULT(0x80042814),
    VDS_E_VOLUME_SHRINK_FVE          = HRESULT(0x80042815),
}

enum HRESULT VDS_E_SHRINK_OVER_DATA = HRESULT(0x80042816);
enum HRESULT VDS_E_INVALID_SHRINK_SIZE = HRESULT(0x80042817);

enum : HRESULT
{
    VDS_E_LUN_DISK_MISSING   = HRESULT(0x80042818),
    VDS_E_LUN_DISK_FAILED    = HRESULT(0x80042819),
    VDS_E_LUN_DISK_NOT_READY = HRESULT(0x8004281a),
    VDS_E_LUN_DISK_NO_MEDIA  = HRESULT(0x8004281b),
    VDS_E_LUN_NOT_READY      = HRESULT(0x8004281c),
    VDS_E_LUN_OFFLINE        = HRESULT(0x8004281d),
    VDS_E_LUN_FAILED         = HRESULT(0x8004281e),
}

enum : HRESULT
{
    VDS_E_VOLUME_EXTEND_FVE_LOCKED   = HRESULT(0x8004281f),
    VDS_E_VOLUME_EXTEND_FVE_CORRUPT  = HRESULT(0x80042820),
    VDS_E_VOLUME_EXTEND_FVE_RECOVERY = HRESULT(0x80042821),
    VDS_E_VOLUME_EXTEND_FVE          = HRESULT(0x80042822),
}

enum HRESULT VDS_E_SECTOR_SIZE_ERROR = HRESULT(0x80042823);
enum HRESULT VDS_E_INITIATOR_ADAPTER_NOT_FOUND = HRESULT(0x80042900);
enum HRESULT VDS_E_TARGET_PORTAL_NOT_FOUND = HRESULT(0x80042901);

enum : HRESULT
{
    VDS_E_INVALID_PORT_PATH         = HRESULT(0x80042902),
    VDS_E_INVALID_ISCSI_TARGET_NAME = HRESULT(0x80042903),
}

enum HRESULT VDS_E_SET_TUNNEL_MODE_OUTER_ADDRESS = HRESULT(0x80042904);

enum : HRESULT
{
    VDS_E_ISCSI_GET_IKE_INFO = HRESULT(0x80042905),
    VDS_E_ISCSI_SET_IKE_INFO = HRESULT(0x80042906),
}

enum HRESULT VDS_E_SUBSYSTEM_ID_IS_NULL = HRESULT(0x80042907);
enum HRESULT VDS_E_ISCSI_INITIATOR_NODE_NAME = HRESULT(0x80042908);
enum HRESULT VDS_E_ISCSI_GROUP_PRESHARE_KEY = HRESULT(0x80042909);
enum HRESULT VDS_E_ISCSI_CHAP_SECRET = HRESULT(0x8004290a);
enum HRESULT VDS_E_INVALID_IP_ADDRESS = HRESULT(0x8004290b);
enum HRESULT VDS_E_REBOOT_REQUIRED = HRESULT(0x8004290c);
enum HRESULT VDS_E_VOLUME_GUID_PATHNAME_NOT_ALLOWED = HRESULT(0x8004290d);
enum HRESULT VDS_E_BOOT_PAGEFILE_DRIVE_LETTER = HRESULT(0x8004290e);
enum HRESULT VDS_E_DELETE_WITH_CRITICAL = HRESULT(0x8004290f);

enum : HRESULT
{
    VDS_E_CLEAN_WITH_DATA     = HRESULT(0x80042910),
    VDS_E_CLEAN_WITH_OEM      = HRESULT(0x80042911),
    VDS_E_CLEAN_WITH_CRITICAL = HRESULT(0x80042912),
}

enum HRESULT VDS_E_FORMAT_CRITICAL = HRESULT(0x80042913);
enum HRESULT VDS_E_NTFS_FORMAT_NOT_SUPPORTED = HRESULT(0x80042914);
enum HRESULT VDS_E_FAT32_FORMAT_NOT_SUPPORTED = HRESULT(0x80042915);
enum HRESULT VDS_E_FAT_FORMAT_NOT_SUPPORTED = HRESULT(0x80042916);
enum HRESULT VDS_E_FORMAT_NOT_SUPPORTED = HRESULT(0x80042917);
enum HRESULT VDS_E_COMPRESSION_NOT_SUPPORTED = HRESULT(0x80042918);

enum : HRESULT
{
    VDS_E_VDISK_NOT_OPEN         = HRESULT(0x80042919),
    VDS_E_VDISK_INVALID_OP_STATE = HRESULT(0x8004291a),
}

enum : HRESULT
{
    VDS_E_INVALID_PATH       = HRESULT(0x8004291b),
    VDS_E_INVALID_ISCSI_PATH = HRESULT(0x8004291c),
}

enum HRESULT VDS_E_SHRINK_LUN_NOT_UNMASKED = HRESULT(0x8004291d);

enum : HRESULT
{
    VDS_E_LUN_DISK_READ_ONLY  = HRESULT(0x8004291e),
    VDS_E_LUN_UPDATE_DISK     = HRESULT(0x8004291f),
    VDS_E_LUN_DYNAMIC         = HRESULT(0x80042920),
    VDS_E_LUN_DYNAMIC_OFFLINE = HRESULT(0x80042921),
}

enum HRESULT VDS_E_LUN_SHRINK_GPT_HEADER = HRESULT(0x80042922);
enum HRESULT VDS_E_MIRROR_NOT_SUPPORTED = HRESULT(0x80042923);
enum HRESULT VDS_E_RAID5_NOT_SUPPORTED = HRESULT(0x80042924);
enum HRESULT VDS_E_DISK_NOT_CONVERTIBLE_SIZE = HRESULT(0x80042925);
enum HRESULT VDS_E_OFFLINE_NOT_SUPPORTED = HRESULT(0x80042926);
enum HRESULT VDS_E_VDISK_PATHNAME_INVALID = HRESULT(0x80042927);

enum : HRESULT
{
    VDS_E_EXTEND_TOO_MANY_CLUSTERS  = HRESULT(0x80042928),
    VDS_E_EXTEND_UNKNOWN_FILESYSTEM = HRESULT(0x80042929),
}

enum HRESULT VDS_E_SHRINK_UNKNOWN_FILESYSTEM = HRESULT(0x8004292a);

enum : HRESULT
{
    VDS_E_VD_DISK_NOT_OPEN      = HRESULT(0x8004292b),
    VDS_E_VD_DISK_IS_EXPANDING  = HRESULT(0x8004292c),
    VDS_E_VD_DISK_IS_COMPACTING = HRESULT(0x8004292d),
    VDS_E_VD_DISK_IS_MERGING    = HRESULT(0x8004292e),
}

enum : HRESULT
{
    VDS_E_VD_IS_ATTACHED            = HRESULT(0x8004292f),
    VDS_E_VD_DISK_ALREADY_OPEN      = HRESULT(0x80042930),
    VDS_E_VD_DISK_ALREADY_EXPANDING = HRESULT(0x80042931),
}

enum : HRESULT
{
    VDS_E_VD_ALREADY_COMPACTING = HRESULT(0x80042932),
    VDS_E_VD_ALREADY_MERGING    = HRESULT(0x80042933),
    VDS_E_VD_ALREADY_ATTACHED   = HRESULT(0x80042934),
    VDS_E_VD_ALREADY_DETACHED   = HRESULT(0x80042935),
}

enum HRESULT VDS_E_VD_NOT_ATTACHED_READONLY = HRESULT(0x80042936);

enum : HRESULT
{
    VDS_E_VD_IS_BEING_ATTACHED = HRESULT(0x80042937),
    VDS_E_VD_IS_BEING_DETACHED = HRESULT(0x80042938),
}

enum : HRESULT
{
    VDS_E_NO_POOL             = HRESULT(0x80042a00),
    VDS_E_NO_POOL_CREATED     = HRESULT(0x80042a01),
    VDS_E_NO_MAINTENANCE_MODE = HRESULT(0x80042a02),
}

enum HRESULT VDS_E_BLOCK_CLUSTERED = HRESULT(0x80042a03);
enum HRESULT VDS_E_DISK_HAS_BANDS = HRESULT(0x80042a04);
enum HRESULT VDS_E_INVALID_STATE = HRESULT(0x80042a05);
enum HRESULT VDS_E_REFS_FORMAT_NOT_SUPPORTED = HRESULT(0x80042a06);
enum HRESULT VDS_E_DELETE_WITH_BOOTBACKING = HRESULT(0x80042a07);
enum HRESULT VDS_E_FORMAT_WITH_BOOTBACKING = HRESULT(0x80042a08);
enum HRESULT VDS_E_CLEAN_WITH_BOOTBACKING = HRESULT(0x80042a09);
enum HRESULT VDS_E_SHRINK_EXTEND_UNALIGNED = HRESULT(0x80042b00);

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdslun/ns-vdslun-vds_storage_identifier
struct VDS_STORAGE_IDENTIFIER
{
    VDS_STORAGE_IDENTIFIER_CODE_SET m_CodeSet;
    VDS_STORAGE_IDENTIFIER_TYPE m_Type;
    uint   m_cbIdentifier;
    ubyte* m_rgbIdentifier;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdslun/ns-vdslun-vds_storage_device_id_descriptor
struct VDS_STORAGE_DEVICE_ID_DESCRIPTOR
{
    uint m_version;
    uint m_cIdentifiers;
    VDS_STORAGE_IDENTIFIER* m_rgIdentifiers;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdslun/ns-vdslun-vds_interconnect
struct VDS_INTERCONNECT
{
    VDS_INTERCONNECT_ADDRESS_TYPE m_addressType;
    uint   m_cbPort;
    ubyte* m_pbPort;
    uint   m_cbAddress;
    ubyte* m_pbAddress;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdslun/ns-vdslun-vds_lun_information
struct VDS_LUN_INFORMATION
{
    uint                 m_version;
    ubyte                m_DeviceType;
    ubyte                m_DeviceTypeModifier;
    BOOL                 m_bCommandQueueing;
    VDS_STORAGE_BUS_TYPE m_BusType;
    ubyte*               m_szVendorId;
    ubyte*               m_szProductId;
    ubyte*               m_szProductRevision;
    ubyte*               m_szSerialNumber;
    GUID                 m_diskSignature;
    VDS_STORAGE_DEVICE_ID_DESCRIPTOR m_deviceIdDescriptor;
    uint                 m_cInterconnects;
    VDS_INTERCONNECT*    m_rgInterconnects;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ns-vdshwprv-vds_pack_notification
struct VDS_PACK_NOTIFICATION
{
    VDS_NF_PACK ulEvent;
    GUID        packId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ns-vdshwprv-vds_disk_notification
struct VDS_DISK_NOTIFICATION
{
    VDS_NF_DISK ulEvent;
    GUID        diskId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ns-vdshwprv-vds_volume_notification
struct VDS_VOLUME_NOTIFICATION
{
    uint ulEvent;
    GUID volumeId;
    GUID plexId;
    uint ulPercentCompleted;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ns-vdshwprv-vds_partition_notification
struct VDS_PARTITION_NOTIFICATION
{
    uint  ulEvent;
    GUID  diskId;
    ulong ullOffset;
}

struct VDS_SERVICE_NOTIFICATION
{
    uint               ulEvent;
    VDS_RECOVER_ACTION action;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ns-vdshwprv-vds_drive_letter_notification
struct VDS_DRIVE_LETTER_NOTIFICATION
{
    uint  ulEvent;
    wchar wcLetter;
    GUID  volumeId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ns-vdshwprv-vds_file_system_notification
struct VDS_FILE_SYSTEM_NOTIFICATION
{
    VDS_NF_FILE_SYSTEM ulEvent;
    GUID               volumeId;
    uint               dwPercentCompleted;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ns-vdshwprv-vds_mount_point_notification
struct VDS_MOUNT_POINT_NOTIFICATION
{
    uint ulEvent;
    GUID volumeId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ns-vdshwprv-vds_sub_system_notification
struct VDS_SUB_SYSTEM_NOTIFICATION
{
    uint ulEvent;
    GUID subSystemId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ns-vdshwprv-vds_controller_notification
struct VDS_CONTROLLER_NOTIFICATION
{
    VDS_NF_CONTROLLER ulEvent;
    GUID              controllerId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ns-vdshwprv-vds_drive_notification
struct VDS_DRIVE_NOTIFICATION
{
    VDS_NF_DRIVE ulEvent;
    GUID         driveId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ns-vdshwprv-vds_lun_notification
struct VDS_LUN_NOTIFICATION
{
    VDS_NF_LUN ulEvent;
    GUID       LunId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ns-vdshwprv-vds_port_notification
struct VDS_PORT_NOTIFICATION
{
    VDS_NF_PORT ulEvent;
    GUID        portId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ns-vdshwprv-vds_portal_notification
struct VDS_PORTAL_NOTIFICATION
{
    uint ulEvent;
    GUID portalId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ns-vdshwprv-vds_target_notification
struct VDS_TARGET_NOTIFICATION
{
    uint ulEvent;
    GUID targetId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ns-vdshwprv-vds_portal_group_notification
struct VDS_PORTAL_GROUP_NOTIFICATION
{
    uint ulEvent;
    GUID portalGroupId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ns-vdshwprv-vds_notification
struct VDS_NOTIFICATION
{
    VDS_NOTIFICATION_TARGET_TYPE objectType;
    union
    {
        VDS_PACK_NOTIFICATION Pack;
        VDS_DISK_NOTIFICATION Disk;
        VDS_VOLUME_NOTIFICATION Volume;
        VDS_PARTITION_NOTIFICATION Partition;
        VDS_DRIVE_LETTER_NOTIFICATION Letter;
        VDS_FILE_SYSTEM_NOTIFICATION FileSystem;
        VDS_MOUNT_POINT_NOTIFICATION MountPoint;
        VDS_SUB_SYSTEM_NOTIFICATION SubSystem;
        VDS_CONTROLLER_NOTIFICATION Controller;
        VDS_DRIVE_NOTIFICATION Drive;
        VDS_LUN_NOTIFICATION Lun;
        VDS_PORT_NOTIFICATION Port;
        VDS_PORTAL_NOTIFICATION Portal;
        VDS_TARGET_NOTIFICATION Target;
        VDS_PORTAL_GROUP_NOTIFICATION PortalGroup;
        VDS_SERVICE_NOTIFICATION Service;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ns-vdshwprv-vds_async_output
struct VDS_ASYNC_OUTPUT
{
    VDS_ASYNC_OUTPUT_TYPE type;
    union
    {
        struct cp
        {
            ulong ullOffset;
            GUID  volumeId;
        }
        struct cv
        {
            IUnknown pVolumeUnk;
        }
        struct bvp
        {
            IUnknown pVolumeUnk;
        }
        struct sv
        {
            ulong ullReclaimedBytes;
        }
        struct cl
        {
            IUnknown pLunUnk;
        }
        struct ct
        {
            IUnknown pTargetUnk;
        }
        struct cpg
        {
            IUnknown pPortalGroupUnk;
        }
        struct cvd
        {
            IUnknown pVDiskUnk;
        }
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ns-vdshwprv-vds_path_id
struct VDS_PATH_ID
{
    ulong ullSourceId;
    ulong ullPathId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ns-vdshwprv-vds_wwn
struct VDS_WWN
{
    ubyte[8] rguchWwn;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ns-vdshwprv-vds_ipaddress
struct VDS_IPADDRESS
{
    VDS_IPADDRESS_TYPE type;
    uint               ipv4Address;
    ubyte[16]          ipv6Address;
    uint               ulIpv6FlowInfo;
    uint               ulIpv6ScopeId;
    wchar[257]         wszTextAddress;
    uint               ulPort;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ns-vdshwprv-vds_iscsi_ipsec_key
struct VDS_ISCSI_IPSEC_KEY
{
    ubyte* pKey;
    uint   ulKeySize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ns-vdshwprv-vds_iscsi_shared_secret
struct VDS_ISCSI_SHARED_SECRET
{
    ubyte* pSharedSecret;
    uint   ulSharedSecretSize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ns-vdshwprv-vds_hbaport_prop
struct VDS_HBAPORT_PROP
{
    GUID               id;
    VDS_WWN            wwnNode;
    VDS_WWN            wwnPort;
    VDS_HBAPORT_TYPE   type;
    VDS_HBAPORT_STATUS status;
    uint               ulPortSpeed;
    uint               ulSupportedPortSpeed;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ns-vdshwprv-vds_iscsi_initiator_adapter_prop
struct VDS_ISCSI_INITIATOR_ADAPTER_PROP
{
    GUID  id;
    PWSTR pwszName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ns-vdshwprv-vds_iscsi_initiator_portal_prop
struct VDS_ISCSI_INITIATOR_PORTAL_PROP
{
    GUID          id;
    VDS_IPADDRESS address;
    uint          ulPortIndex;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ns-vdshwprv-vds_provider_prop
struct VDS_PROVIDER_PROP
{
    GUID              id;
    PWSTR             pwszName;
    GUID              guidVersionId;
    PWSTR             pwszVersion;
    VDS_PROVIDER_TYPE type;
    uint              ulFlags;
    uint              ulStripeSizeFlags;
    short             sRebuildPriority;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ns-vdshwprv-vds_path_info
struct VDS_PATH_INFO
{
    VDS_PATH_ID         pathId;
    VDS_HWPROVIDER_TYPE type;
    VDS_PATH_STATUS     status;
    union
    {
        GUID controllerPortId;
        GUID targetPortalId;
    }
    union
    {
        GUID hbaPortId;
        GUID initiatorAdapterId;
    }
    union
    {
        VDS_HBAPORT_PROP* pHbaPortProp;
        VDS_IPADDRESS*    pInitiatorPortalIpAddr;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ns-vdshwprv-vds_path_policy
struct VDS_PATH_POLICY
{
    VDS_PATH_ID pathId;
    BOOL        bPrimaryPath;
    uint        ulWeight;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/ns-vds-vds_pack_prop
struct VDS_PACK_PROP
{
    GUID            id;
    PWSTR           pwszName;
    VDS_PACK_STATUS status;
    uint            ulFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/ns-vds-vds_disk_prop
struct VDS_DISK_PROP
{
    GUID                 id;
    VDS_DISK_STATUS      status;
    VDS_LUN_RESERVE_MODE ReserveMode;
    VDS_HEALTH           health;
    uint                 dwDeviceType;
    uint                 dwMediaType;
    ulong                ullSize;
    uint                 ulBytesPerSector;
    uint                 ulSectorsPerTrack;
    uint                 ulTracksPerCylinder;
    uint                 ulFlags;
    VDS_STORAGE_BUS_TYPE BusType;
    VDS_PARTITION_STYLE  PartitionStyle;
    union
    {
        uint dwSignature;
        GUID DiskGuid;
    }
    PWSTR                pwszDiskAddress;
    PWSTR                pwszName;
    PWSTR                pwszFriendlyName;
    PWSTR                pwszAdaptorName;
    PWSTR                pwszDevicePath;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/ns-vds-vds_disk_prop2
struct VDS_DISK_PROP2
{
    GUID                 id;
    VDS_DISK_STATUS      status;
    VDS_DISK_OFFLINE_REASON OfflineReason;
    VDS_LUN_RESERVE_MODE ReserveMode;
    VDS_HEALTH           health;
    uint                 dwDeviceType;
    uint                 dwMediaType;
    ulong                ullSize;
    uint                 ulBytesPerSector;
    uint                 ulSectorsPerTrack;
    uint                 ulTracksPerCylinder;
    uint                 ulFlags;
    VDS_STORAGE_BUS_TYPE BusType;
    VDS_PARTITION_STYLE  PartitionStyle;
    union
    {
        uint dwSignature;
        GUID DiskGuid;
    }
    PWSTR                pwszDiskAddress;
    PWSTR                pwszName;
    PWSTR                pwszFriendlyName;
    PWSTR                pwszAdaptorName;
    PWSTR                pwszDevicePath;
    PWSTR                pwszLocationPath;
}

struct VDS_ADVANCEDDISK_PROP
{
    PWSTR                pwszId;
    PWSTR                pwszPathname;
    PWSTR                pwszLocation;
    PWSTR                pwszFriendlyName;
    PWSTR                pswzIdentifier;
    ushort               usIdentifierFormat;
    uint                 ulNumber;
    PWSTR                pwszSerialNumber;
    PWSTR                pwszFirmwareVersion;
    PWSTR                pwszManufacturer;
    PWSTR                pwszModel;
    ulong                ullTotalSize;
    ulong                ullAllocatedSize;
    uint                 ulLogicalSectorSize;
    uint                 ulPhysicalSectorSize;
    uint                 ulPartitionCount;
    VDS_DISK_STATUS      status;
    VDS_HEALTH           health;
    VDS_STORAGE_BUS_TYPE BusType;
    VDS_PARTITION_STYLE  PartitionStyle;
    union
    {
        uint dwSignature;
        GUID DiskGuid;
    }
    uint                 ulFlags;
    uint                 dwDeviceType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/ns-vds-vds_volume_prop
struct VDS_VOLUME_PROP
{
    GUID                 id;
    VDS_VOLUME_TYPE      type;
    VDS_VOLUME_STATUS    status;
    VDS_HEALTH           health;
    VDS_TRANSITION_STATE TransitionState;
    ulong                ullSize;
    uint                 ulFlags;
    VDS_FILE_SYSTEM_TYPE RecommendedFileSystemType;
    PWSTR                pwszName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/ns-vds-vds_volume_prop2
struct VDS_VOLUME_PROP2
{
    GUID                 id;
    VDS_VOLUME_TYPE      type;
    VDS_VOLUME_STATUS    status;
    VDS_HEALTH           health;
    VDS_TRANSITION_STATE TransitionState;
    ulong                ullSize;
    uint                 ulFlags;
    VDS_FILE_SYSTEM_TYPE RecommendedFileSystemType;
    uint                 cbUniqueId;
    PWSTR                pwszName;
    ubyte*               pUniqueId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/ns-vds-vds_volume_plex_prop
struct VDS_VOLUME_PLEX_PROP
{
    GUID                 id;
    VDS_VOLUME_PLEX_TYPE type;
    VDS_VOLUME_PLEX_STATUS status;
    VDS_HEALTH           health;
    VDS_TRANSITION_STATE TransitionState;
    ulong                ullSize;
    uint                 ulStripeSize;
    uint                 ulNumberOfMembers;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/ns-vds-vds_disk_extent
struct VDS_DISK_EXTENT
{
    GUID                 diskId;
    VDS_DISK_EXTENT_TYPE type;
    ulong                ullOffset;
    ulong                ullSize;
    GUID                 volumeId;
    GUID                 plexId;
    uint                 memberIdx;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/ns-vds-vds_disk_free_extent
struct VDS_DISK_FREE_EXTENT
{
    GUID  diskId;
    ulong ullOffset;
    ulong ullSize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/ns-vds-vds_input_disk
struct VDS_INPUT_DISK
{
    GUID  diskId;
    ulong ullSize;
    GUID  plexId;
    uint  memberIdx;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/ns-vds-vds_partition_info_gpt
struct VDS_PARTITION_INFO_GPT
{
    GUID      partitionType;
    GUID      partitionId;
    ulong     attributes;
    wchar[36] name;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/ns-vds-vds_partition_info_mbr
struct VDS_PARTITION_INFO_MBR
{
    ubyte   partitionType;
    BOOLEAN bootIndicator;
    BOOLEAN recognizedPartition;
    uint    hiddenSectors;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/ns-vds-vds_partition_prop
struct VDS_PARTITION_PROP
{
    VDS_PARTITION_STYLE PartitionStyle;
    uint                ulFlags;
    uint                ulPartitionNumber;
    ulong               ullOffset;
    ulong               ullSize;
    union
    {
        VDS_PARTITION_INFO_MBR Mbr;
        VDS_PARTITION_INFO_GPT Gpt;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/ns-vds-vds_partition_information_ex
struct VDS_PARTITION_INFORMATION_EX
{
    __VDS_PARTITION_STYLE dwPartitionStyle;
    ulong   ullStartingOffset;
    ulong   ullPartitionLength;
    uint    dwPartitionNumber;
    BOOLEAN bRewritePartition;
    union
    {
        VDS_PARTITION_INFO_MBR Mbr;
        VDS_PARTITION_INFO_GPT Gpt;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/ns-vds-create_partition_parameters
struct CREATE_PARTITION_PARAMETERS
{
    VDS_PARTITION_STYLE style;
    union
    {
        struct MbrPartInfo
        {
            ubyte   partitionType;
            BOOLEAN bootIndicator;
        }
        struct GptPartInfo
        {
            GUID      partitionType;
            GUID      partitionId;
            ulong     attributes;
            wchar[36] name;
        }
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/ns-vds-change_attributes_parameters
struct CHANGE_ATTRIBUTES_PARAMETERS
{
    VDS_PARTITION_STYLE style;
    union
    {
        struct MbrPartInfo
        {
            BOOLEAN bootIndicator;
        }
        struct GptPartInfo
        {
            ulong attributes;
        }
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/ns-vds-change_partition_type_parameters
struct CHANGE_PARTITION_TYPE_PARAMETERS
{
    VDS_PARTITION_STYLE style;
    union
    {
        struct MbrPartInfo
        {
            ubyte partitionType;
        }
        struct GptPartInfo
        {
            GUID partitionType;
        }
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ns-vdshwprv-vds_hints
struct VDS_HINTS
{
    ulong ullHintMask;
    ulong ullExpectedMaximumSize;
    uint  ulOptimalReadSize;
    uint  ulOptimalReadAlignment;
    uint  ulOptimalWriteSize;
    uint  ulOptimalWriteAlignment;
    uint  ulMaximumDriveCount;
    uint  ulStripeSize;
    BOOL  bFastCrashRecoveryRequired;
    BOOL  bMostlyReads;
    BOOL  bOptimizeForSequentialReads;
    BOOL  bOptimizeForSequentialWrites;
    BOOL  bRemapEnabled;
    BOOL  bReadBackVerifyEnabled;
    BOOL  bWriteThroughCachingEnabled;
    BOOL  bHardwareChecksumEnabled;
    BOOL  bIsYankable;
    short sRebuildPriority;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ns-vdshwprv-vds_hints2
struct VDS_HINTS2
{
    ulong                ullHintMask;
    ulong                ullExpectedMaximumSize;
    uint                 ulOptimalReadSize;
    uint                 ulOptimalReadAlignment;
    uint                 ulOptimalWriteSize;
    uint                 ulOptimalWriteAlignment;
    uint                 ulMaximumDriveCount;
    uint                 ulStripeSize;
    uint                 ulReserved1;
    uint                 ulReserved2;
    uint                 ulReserved3;
    BOOL                 bFastCrashRecoveryRequired;
    BOOL                 bMostlyReads;
    BOOL                 bOptimizeForSequentialReads;
    BOOL                 bOptimizeForSequentialWrites;
    BOOL                 bRemapEnabled;
    BOOL                 bReadBackVerifyEnabled;
    BOOL                 bWriteThroughCachingEnabled;
    BOOL                 bHardwareChecksumEnabled;
    BOOL                 bIsYankable;
    BOOL                 bAllocateHotSpare;
    BOOL                 bUseMirroredCache;
    BOOL                 bReadCachingEnabled;
    BOOL                 bWriteCachingEnabled;
    BOOL                 bMediaScanEnabled;
    BOOL                 bConsistencyCheckEnabled;
    VDS_STORAGE_BUS_TYPE BusType;
    BOOL                 bReserved1;
    BOOL                 bReserved2;
    BOOL                 bReserved3;
    short                sRebuildPriority;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ns-vdshwprv-vds_sub_system_prop
struct VDS_SUB_SYSTEM_PROP
{
    GUID       id;
    PWSTR      pwszFriendlyName;
    PWSTR      pwszIdentification;
    uint       ulFlags;
    uint       ulStripeSizeFlags;
    VDS_SUB_SYSTEM_STATUS status;
    VDS_HEALTH health;
    short      sNumberOfInternalBuses;
    short      sMaxNumberOfSlotsEachBus;
    short      sMaxNumberOfControllers;
    short      sRebuildPriority;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ns-vdshwprv-vds_sub_system_prop2
struct VDS_SUB_SYSTEM_PROP2
{
    GUID       id;
    PWSTR      pwszFriendlyName;
    PWSTR      pwszIdentification;
    uint       ulFlags;
    uint       ulStripeSizeFlags;
    uint       ulSupportedRaidTypeFlags;
    VDS_SUB_SYSTEM_STATUS status;
    VDS_HEALTH health;
    short      sNumberOfInternalBuses;
    short      sMaxNumberOfSlotsEachBus;
    short      sMaxNumberOfControllers;
    short      sRebuildPriority;
    uint       ulNumberOfEnclosures;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ns-vdshwprv-vds_controller_prop
struct VDS_CONTROLLER_PROP
{
    GUID       id;
    PWSTR      pwszFriendlyName;
    PWSTR      pwszIdentification;
    VDS_CONTROLLER_STATUS status;
    VDS_HEALTH health;
    short      sNumberOfPorts;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ns-vdshwprv-vds_drive_prop
struct VDS_DRIVE_PROP
{
    GUID             id;
    ulong            ullSize;
    PWSTR            pwszFriendlyName;
    PWSTR            pwszIdentification;
    uint             ulFlags;
    VDS_DRIVE_STATUS status;
    VDS_HEALTH       health;
    short            sInternalBusNumber;
    short            sSlotNumber;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ns-vdshwprv-vds_drive_prop2
struct VDS_DRIVE_PROP2
{
    GUID                 id;
    ulong                ullSize;
    PWSTR                pwszFriendlyName;
    PWSTR                pwszIdentification;
    uint                 ulFlags;
    VDS_DRIVE_STATUS     status;
    VDS_HEALTH           health;
    short                sInternalBusNumber;
    short                sSlotNumber;
    uint                 ulEnclosureNumber;
    VDS_STORAGE_BUS_TYPE busType;
    uint                 ulSpindleSpeed;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ns-vdshwprv-vds_drive_extent
struct VDS_DRIVE_EXTENT
{
    GUID  id;
    GUID  LunId;
    ulong ullSize;
    BOOL  bUsed;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ns-vdshwprv-vds_lun_prop
struct VDS_LUN_PROP
{
    GUID                 id;
    ulong                ullSize;
    PWSTR                pwszFriendlyName;
    PWSTR                pwszIdentification;
    PWSTR                pwszUnmaskingList;
    uint                 ulFlags;
    VDS_LUN_TYPE         type;
    VDS_LUN_STATUS       status;
    VDS_HEALTH           health;
    VDS_TRANSITION_STATE TransitionState;
    short                sRebuildPriority;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ns-vdshwprv-vds_lun_plex_prop
struct VDS_LUN_PLEX_PROP
{
    GUID                 id;
    ulong                ullSize;
    VDS_LUN_PLEX_TYPE    type;
    VDS_LUN_PLEX_STATUS  status;
    VDS_HEALTH           health;
    VDS_TRANSITION_STATE TransitionState;
    uint                 ulFlags;
    uint                 ulStripeSize;
    short                sRebuildPriority;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ns-vdshwprv-vds_port_prop
struct VDS_PORT_PROP
{
    GUID            id;
    PWSTR           pwszFriendlyName;
    PWSTR           pwszIdentification;
    VDS_PORT_STATUS status;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ns-vdshwprv-vds_iscsi_portal_prop
struct VDS_ISCSI_PORTAL_PROP
{
    GUID          id;
    VDS_IPADDRESS address;
    VDS_ISCSI_PORTAL_STATUS status;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ns-vdshwprv-vds_iscsi_target_prop
struct VDS_ISCSI_TARGET_PROP
{
    GUID  id;
    PWSTR pwszIscsiName;
    PWSTR pwszFriendlyName;
    BOOL  bChapEnabled;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ns-vdshwprv-vds_iscsi_portalgroup_prop
struct VDS_ISCSI_PORTALGROUP_PROP
{
    GUID   id;
    ushort tag;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ns-vdshwprv-vds_pool_custom_attributes
struct VDS_POOL_CUSTOM_ATTRIBUTES
{
    PWSTR pwszName;
    PWSTR pwszValue;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ns-vdshwprv-vds_pool_attributes
struct VDS_POOL_ATTRIBUTES
{
    ulong                ullAttributeMask;
    VDS_RAID_TYPE        raidType;
    VDS_STORAGE_BUS_TYPE busType;
    PWSTR                pwszIntendedUsage;
    BOOL                 bSpinDown;
    BOOL                 bIsThinProvisioned;
    ulong                ullProvisionedSpace;
    BOOL                 bNoSinglePointOfFailure;
    uint                 ulDataRedundancyMax;
    uint                 ulDataRedundancyMin;
    uint                 ulDataRedundancyDefault;
    uint                 ulPackageRedundancyMax;
    uint                 ulPackageRedundancyMin;
    uint                 ulPackageRedundancyDefault;
    uint                 ulStripeSize;
    uint                 ulStripeSizeMax;
    uint                 ulStripeSizeMin;
    uint                 ulDefaultStripeSize;
    uint                 ulNumberOfColumns;
    uint                 ulNumberOfColumnsMax;
    uint                 ulNumberOfColumnsMin;
    uint                 ulDefaultNumberofColumns;
    uint                 ulDataAvailabilityHint;
    uint                 ulAccessRandomnessHint;
    uint                 ulAccessDirectionHint;
    uint                 ulAccessSizeHint;
    uint                 ulAccessLatencyHint;
    uint                 ulAccessBandwidthWeightHint;
    uint                 ulStorageCostHint;
    uint                 ulStorageEfficiencyHint;
    uint                 ulNumOfCustomAttributes;
    VDS_POOL_CUSTOM_ATTRIBUTES* pPoolCustomAttributes;
    BOOL                 bReserved1;
    BOOL                 bReserved2;
    uint                 ulReserved1;
    uint                 ulReserved2;
    ulong                ullReserved1;
    ulong                ullReserved2;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ns-vdshwprv-vds_storage_pool_prop
struct VDS_STORAGE_POOL_PROP
{
    GUID       id;
    VDS_STORAGE_POOL_STATUS status;
    VDS_HEALTH health;
    VDS_STORAGE_POOL_TYPE type;
    PWSTR      pwszName;
    PWSTR      pwszDescription;
    ulong      ullTotalConsumedSpace;
    ulong      ullTotalManagedSpace;
    ulong      ullRemainingFreeSpace;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/ns-vdshwprv-vds_storage_pool_drive_extent
struct VDS_STORAGE_POOL_DRIVE_EXTENT
{
    GUID  id;
    ulong ullSize;
    BOOL  bUsed;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/ns-vds-vds_create_vdisk_parameters
struct VDS_CREATE_VDISK_PARAMETERS
{
    GUID  UniqueId;
    ulong MaximumSize;
    uint  BlockSizeInBytes;
    uint  SectorSizeInBytes;
    PWSTR pParentPath;
    PWSTR pSourcePath;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/ns-vds-vds_vdisk_properties
struct VDS_VDISK_PROPERTIES
{
    GUID                 Id;
    VDS_VDISK_STATE      State;
    VIRTUAL_STORAGE_TYPE VirtualDeviceType;
    ulong                VirtualSize;
    ulong                PhysicalSize;
    PWSTR                pPath;
    PWSTR                pDeviceName;
    DEPENDENT_DISK_FLAG  DiskFlag;
    BOOL                 bIsChild;
    PWSTR                pParentPath;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/ns-vds-vds_service_prop
struct VDS_SERVICE_PROP
{
    PWSTR pwszVersion;
    uint  ulFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/ns-vds-vds_reparse_point_prop
struct VDS_REPARSE_POINT_PROP
{
    GUID  SourceVolumeId;
    PWSTR pwszPath;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/ns-vds-vds_drive_letter_prop
struct VDS_DRIVE_LETTER_PROP
{
    wchar wcLetter;
    GUID  volumeId;
    uint  ulFlags;
    BOOL  bUsed;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/ns-vds-vds_file_system_type_prop
struct VDS_FILE_SYSTEM_TYPE_PROP
{
    VDS_FILE_SYSTEM_TYPE type;
    wchar[8]             wszName;
    uint                 ulFlags;
    uint                 ulCompressionFlags;
    uint                 ulMaxLableLength;
    PWSTR                pwszIllegalLabelCharSet;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/ns-vds-vds_file_system_format_support_prop
struct VDS_FILE_SYSTEM_FORMAT_SUPPORT_PROP
{
    uint      ulFlags;
    ushort    usRevision;
    uint      ulDefaultUnitAllocationSize;
    uint[32]  rgulAllowedUnitAllocationSizes;
    wchar[32] wszName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/ns-vds-vds_file_system_prop
struct VDS_FILE_SYSTEM_PROP
{
    VDS_FILE_SYSTEM_TYPE type;
    GUID                 volumeId;
    uint                 ulFlags;
    ulong                ullTotalAllocationUnits;
    ulong                ullAvailableAllocationUnits;
    uint                 ulAllocationUnitSize;
    PWSTR                pwszLabel;
}

// Interfaces

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nn-vdshwprv-ivdsproviderprivate
@GUID("11f3cd41-b7e8-48ff-9472-9dff018aa292")
interface IVdsProviderPrivate : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsproviderprivate-getobject
    HRESULT GetObject(GUID ObjectId, VDS_OBJECT_TYPE type, IUnknown* ppObjectUnk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsproviderprivate-onload
    HRESULT OnLoad(PWSTR pwszMachineName, IUnknown pCallbackObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsproviderprivate-onunload
    HRESULT OnUnload(BOOL bForceUnload);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nn-vdshwprv-ivdshwproviderprivate
@GUID("98f17bf3-9f33-4f12-8714-8b4075092c2e")
interface IVdsHwProviderPrivate : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdshwproviderprivate-queryifcreatedlun
    HRESULT QueryIfCreatedLun(PWSTR pwszDevicePath, VDS_LUN_INFORMATION* pVdsLunInformation, GUID* pLunId);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nn-vdshwprv-ivdshwproviderprivatempio
@GUID("310a7715-ac2b-4c6f-9827-3d742f351676")
interface IVdsHwProviderPrivateMpio : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdshwproviderprivatempio-setallpathstatusesfromhbaport
    HRESULT SetAllPathStatusesFromHbaPort(VDS_HBAPORT_PROP hbaPortProp, VDS_PATH_STATUS status);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nn-vdshwprv-ivdsadmin
@GUID("d188e97d-85aa-4d33-abc6-26299a10ffc1")
interface IVdsAdmin : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsadmin-registerprovider
    HRESULT RegisterProvider(GUID providerId, GUID providerClsid, PWSTR pwszName, VDS_PROVIDER_TYPE type, 
                             PWSTR pwszMachineName, PWSTR pwszVersion, GUID guidVersionId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsadmin-unregisterprovider
    HRESULT UnregisterProvider(GUID providerId);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nn-vdshwprv-ienumvdsobject
@GUID("118610b7-8d94-4030-b5b8-500889788e4e")
interface IEnumVdsObject : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ienumvdsobject-next
    HRESULT Next(uint celt, IUnknown* ppObjectArray, uint* pcFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ienumvdsobject-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ienumvdsobject-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ienumvdsobject-clone
    HRESULT Clone(IEnumVdsObject* ppEnum);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nn-vdshwprv-ivdsasync
@GUID("d5d23b6d-5a55-4492-9889-397a3c2d2dbc")
interface IVdsAsync : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsasync-cancel
    HRESULT Cancel();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsasync-wait
    HRESULT Wait(HRESULT* pHrResult, VDS_ASYNC_OUTPUT* pAsyncOut);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsasync-querystatus
    HRESULT QueryStatus(HRESULT* pHrResult, uint* pulPercentCompleted);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nn-vdshwprv-ivdsadvisesink
@GUID("8326cd1d-cf59-4936-b786-5efc08798e25")
interface IVdsAdviseSink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsadvisesink-onnotify
    HRESULT OnNotify(int lNumberOfNotifications, VDS_NOTIFICATION* pNotificationArray);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nn-vdshwprv-ivdsprovider
@GUID("10c5e575-7984-4e81-a56b-431f5f92ae42")
interface IVdsProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsprovider-getproperties
    HRESULT GetProperties(VDS_PROVIDER_PROP* pProviderProp);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nn-vdshwprv-ivdsprovidersupport
@GUID("1732be13-e8f9-4a03-bfbc-5f616aa66ce1")
interface IVdsProviderSupport : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsprovidersupport-getversionsupport
    HRESULT GetVersionSupport(uint* ulVersionSupport);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nn-vds-ivdsswprovider
@GUID("9aa58360-ce33-4f92-b658-ed24b14425b8")
interface IVdsSwProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsswprovider-querypacks
    HRESULT QueryPacks(IEnumVdsObject* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsswprovider-createpack
    HRESULT CreatePack(IVdsPack* ppPack);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nn-vds-ivdspack
@GUID("3b69d7f5-9d94-4648-91ca-79939ba263bf")
interface IVdsPack : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdspack-getproperties
    HRESULT GetProperties(VDS_PACK_PROP* pPackProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdspack-getprovider
    HRESULT GetProvider(IVdsProvider* ppProvider);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdspack-queryvolumes
    HRESULT QueryVolumes(IEnumVdsObject* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdspack-querydisks
    HRESULT QueryDisks(IEnumVdsObject* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdspack-createvolume
    HRESULT CreateVolume(VDS_VOLUME_TYPE type, VDS_INPUT_DISK* pInputDiskArray, int lNumberOfDisks, 
                         uint ulStripeSize, IVdsAsync* ppAsync);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdspack-adddisk
    HRESULT AddDisk(GUID DiskId, VDS_PARTITION_STYLE PartitionStyle, BOOL bAsHotSpare);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdspack-migratedisks
    HRESULT MigrateDisks(GUID* pDiskArray, int lNumberOfDisks, GUID TargetPack, BOOL bForce, BOOL bQueryOnly, 
                         HRESULT* pResults, BOOL* pbRebootNeeded);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdspack-replacedisk
    HRESULT ReplaceDisk(GUID OldDiskId, GUID NewDiskId, IVdsAsync* ppAsync);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdspack-removemissingdisk
    HRESULT RemoveMissingDisk(GUID DiskId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdspack-recover
    HRESULT Recover(IVdsAsync* ppAsync);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nn-vds-ivdspack2
@GUID("13b50bff-290a-47dd-8558-b7c58db1a71a")
interface IVdsPack2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdspack2-createvolume2
    HRESULT CreateVolume2(VDS_VOLUME_TYPE type, VDS_INPUT_DISK* pInputDiskArray, int lNumberOfDisks, 
                          uint ulStripeSize, uint ulAlign, IVdsAsync* ppAsync);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nn-vds-ivdsdisk
@GUID("07e5c822-f00c-47a1-8fce-b244da56fd06")
interface IVdsDisk : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsdisk-getproperties
    HRESULT GetProperties(VDS_DISK_PROP* pDiskProperties);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsdisk-getpack
    HRESULT GetPack(IVdsPack* ppPack);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsdisk-getidentificationdata
    HRESULT GetIdentificationData(VDS_LUN_INFORMATION* pLunInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsdisk-queryextents
    HRESULT QueryExtents(VDS_DISK_EXTENT** ppExtentArray, int* plNumberOfExtents);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsdisk-convertstyle
    HRESULT ConvertStyle(VDS_PARTITION_STYLE NewStyle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsdisk-setflags
    HRESULT SetFlags(uint ulFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsdisk-clearflags
    HRESULT ClearFlags(uint ulFlags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nn-vds-ivdsdisk2
@GUID("40f73c8b-687d-4a13-8d96-3d7f2e683936")
interface IVdsDisk2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsdisk2-setsanmode
    HRESULT SetSANMode(BOOL bEnable);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nn-vds-ivdsdiskonline
@GUID("90681b1d-6a7f-48e8-9061-31b7aa125322")
interface IVdsDiskOnline : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsdiskonline-online
    HRESULT Online();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsdiskonline-offline
    HRESULT Offline();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nn-vds-ivdsadvanceddisk
@GUID("6e6f6b40-977c-4069-bddd-ac710059f8c0")
interface IVdsAdvancedDisk : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsadvanceddisk-getpartitionproperties
    HRESULT GetPartitionProperties(ulong ullOffset, VDS_PARTITION_PROP* pPartitionProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsadvanceddisk-querypartitions
    HRESULT QueryPartitions(VDS_PARTITION_PROP** ppPartitionPropArray, int* plNumberOfPartitions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsadvanceddisk-createpartition
    HRESULT CreatePartition(ulong ullOffset, ulong ullSize, CREATE_PARTITION_PARAMETERS* para, IVdsAsync* ppAsync);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsadvanceddisk-deletepartition
    HRESULT DeletePartition(ulong ullOffset, BOOL bForce, BOOL bForceProtected);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsadvanceddisk-changeattributes
    HRESULT ChangeAttributes(ulong ullOffset, CHANGE_ATTRIBUTES_PARAMETERS* para);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsadvanceddisk-assigndriveletter
    HRESULT AssignDriveLetter(ulong ullOffset, wchar wcLetter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsadvanceddisk-deletedriveletter
    HRESULT DeleteDriveLetter(ulong ullOffset, wchar wcLetter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsadvanceddisk-getdriveletter
    HRESULT GetDriveLetter(ulong ullOffset, PWSTR pwcLetter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsadvanceddisk-formatpartition
    HRESULT FormatPartition(ulong ullOffset, VDS_FILE_SYSTEM_TYPE type, PWSTR pwszLabel, uint dwUnitAllocationSize, 
                            BOOL bForce, BOOL bQuickFormat, BOOL bEnableCompression, IVdsAsync* ppAsync);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsadvanceddisk-clean
    HRESULT Clean(BOOL bForce, BOOL bForceOEM, BOOL bFullClean, IVdsAsync* ppAsync);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nn-vds-ivdsadvanceddisk2
@GUID("9723f420-9355-42de-ab66-e31bb15beeac")
interface IVdsAdvancedDisk2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsadvanceddisk2-changepartitiontype
    HRESULT ChangePartitionType(ulong ullOffset, BOOL bForce, CHANGE_PARTITION_TYPE_PARAMETERS* para);
}

@GUID("3858c0d5-0f35-4bf5-9714-69874963bc36")
interface IVdsAdvancedDisk3 : IUnknown
{
    HRESULT GetProperties(VDS_ADVANCEDDISK_PROP* pAdvDiskProp);
    HRESULT GetUniqueId(PWSTR* ppwszId);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nn-vds-ivdscreatepartitionex
@GUID("9882f547-cfc3-420b-9750-00dfbec50662")
interface IVdsCreatePartitionEx : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdscreatepartitionex-createpartitionex
    HRESULT CreatePartitionEx(ulong ullOffset, ulong ullSize, uint ulAlign, CREATE_PARTITION_PARAMETERS* para, 
                              IVdsAsync* ppAsync);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nn-vds-ivdsremovable
@GUID("0316560b-5db4-4ed9-bbb5-213436ddc0d9")
interface IVdsRemovable : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsremovable-querymedia
    HRESULT QueryMedia();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsremovable-eject
    HRESULT Eject();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nn-vds-ivdsvolume
@GUID("88306bb2-e71f-478c-86a2-79da200a0f11")
interface IVdsVolume : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsvolume-getproperties
    HRESULT GetProperties(VDS_VOLUME_PROP* pVolumeProperties);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsvolume-getpack
    HRESULT GetPack(IVdsPack* ppPack);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsvolume-queryplexes
    HRESULT QueryPlexes(IEnumVdsObject* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsvolume-extend
    HRESULT Extend(VDS_INPUT_DISK* pInputDiskArray, int lNumberOfDisks, IVdsAsync* ppAsync);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsvolume-shrink
    HRESULT Shrink(ulong ullNumberOfBytesToRemove, IVdsAsync* ppAsync);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsvolume-addplex
    HRESULT AddPlex(GUID VolumeId, IVdsAsync* ppAsync);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsvolume-breakplex
    HRESULT BreakPlex(GUID plexId, IVdsAsync* ppAsync);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsvolume-removeplex
    HRESULT RemovePlex(GUID plexId, IVdsAsync* ppAsync);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsvolume-delete
    HRESULT Delete(BOOL bForce);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsvolume-setflags
    HRESULT SetFlags(uint ulFlags, BOOL bRevertOnClose);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsvolume-clearflags
    HRESULT ClearFlags(uint ulFlags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nn-vds-ivdsvolume2
@GUID("72ae6713-dcbb-4a03-b36b-371f6ac6b53d")
interface IVdsVolume2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsvolume2-getproperties2
    HRESULT GetProperties2(VDS_VOLUME_PROP2* pVolumeProperties);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nn-vds-ivdsvolumeonline
@GUID("1be2275a-b315-4f70-9e44-879b3a2a53f2")
interface IVdsVolumeOnline : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsvolumeonline-online
    HRESULT Online();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nn-vds-ivdsvolumeplex
@GUID("4daa0135-e1d1-40f1-aaa5-3cc1e53221c3")
interface IVdsVolumePlex : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsvolumeplex-getproperties
    HRESULT GetProperties(VDS_VOLUME_PLEX_PROP* pPlexProperties);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsvolumeplex-getvolume
    HRESULT GetVolume(IVdsVolume* ppVolume);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsvolumeplex-queryextents
    HRESULT QueryExtents(VDS_DISK_EXTENT** ppExtentArray, int* plNumberOfExtents);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsvolumeplex-repair
    HRESULT Repair(VDS_INPUT_DISK* pInputDiskArray, int lNumberOfDisks, IVdsAsync* ppAsync);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nn-vds-ivdsdisk3
@GUID("8f4b2f5d-ec15-4357-992f-473ef10975b9")
interface IVdsDisk3 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsdisk3-getproperties2
    HRESULT GetProperties2(VDS_DISK_PROP2* pDiskProperties);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsdisk3-queryfreeextents
    HRESULT QueryFreeExtents(uint ulAlign, VDS_DISK_FREE_EXTENT** ppFreeExtentArray, int* plNumberOfFreeExtents);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nn-vdshwprv-ivdshwprovider
@GUID("d99bdaae-b13a-4178-9fdb-e27f16b4603e")
interface IVdsHwProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdshwprovider-querysubsystems
    HRESULT QuerySubSystems(IEnumVdsObject* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdshwprovider-reenumerate
    HRESULT Reenumerate();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdshwprovider-refresh
    HRESULT Refresh();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nn-vdshwprv-ivdshwprovidertype
@GUID("3e0f5166-542d-4fc6-947a-012174240b7e")
interface IVdsHwProviderType : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdshwprovidertype-getprovidertype
    HRESULT GetProviderType(VDS_HWPROVIDER_TYPE* pType);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nn-vdshwprv-ivdshwprovidertype2
@GUID("8190236f-c4d0-4e81-8011-d69512fcc984")
interface IVdsHwProviderType2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdshwprovidertype2-getprovidertype2
    HRESULT GetProviderType2(VDS_HWPROVIDER_TYPE* pType);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nn-vdshwprv-ivdshwproviderstoragepools
@GUID("d5b5937a-f188-4c79-b86c-11c920ad11b8")
interface IVdsHwProviderStoragePools : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdshwproviderstoragepools-querystoragepools
    HRESULT QueryStoragePools(uint ulFlags, ulong ullRemainingFreeSpace, VDS_POOL_ATTRIBUTES* pPoolAttributes, 
                              IEnumVdsObject* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdshwproviderstoragepools-createluninstoragepool
    HRESULT CreateLunInStoragePool(VDS_LUN_TYPE type, ulong ullSizeInBytes, GUID StoragePoolId, 
                                   PWSTR pwszUnmaskingList, VDS_HINTS2* pHints2, IVdsAsync* ppAsync);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdshwproviderstoragepools-querymaxluncreatesizeinstoragepool
    HRESULT QueryMaxLunCreateSizeInStoragePool(VDS_LUN_TYPE type, GUID StoragePoolId, VDS_HINTS2* pHints2, 
                                               ulong* pullMaxLunSize);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nn-vdshwprv-ivdssubsystem
@GUID("6fcee2d3-6d90-4f91-80e2-a5c7caaca9d8")
interface IVdsSubSystem : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdssubsystem-getproperties
    HRESULT GetProperties(VDS_SUB_SYSTEM_PROP* pSubSystemProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdssubsystem-getprovider
    HRESULT GetProvider(IVdsProvider* ppProvider);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdssubsystem-querycontrollers
    HRESULT QueryControllers(IEnumVdsObject* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdssubsystem-queryluns
    HRESULT QueryLuns(IEnumVdsObject* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdssubsystem-querydrives
    HRESULT QueryDrives(IEnumVdsObject* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdssubsystem-getdrive
    HRESULT GetDrive(short sBusNumber, short sSlotNumber, IVdsDrive* ppDrive);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdssubsystem-reenumerate
    HRESULT Reenumerate();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdssubsystem-setcontrollerstatus
    HRESULT SetControllerStatus(GUID* pOnlineControllerIdArray, int lNumberOfOnlineControllers, 
                                GUID* pOfflineControllerIdArray, int lNumberOfOfflineControllers);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdssubsystem-createlun
    HRESULT CreateLun(VDS_LUN_TYPE type, ulong ullSizeInBytes, GUID* pDriveIdArray, int lNumberOfDrives, 
                      PWSTR pwszUnmaskingList, VDS_HINTS* pHints, IVdsAsync* ppAsync);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdssubsystem-replacedrive
    HRESULT ReplaceDrive(GUID DriveToBeReplaced, GUID ReplacementDrive);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdssubsystem-setstatus
    HRESULT SetStatus(VDS_SUB_SYSTEM_STATUS status);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdssubsystem-querymaxluncreatesize
    HRESULT QueryMaxLunCreateSize(VDS_LUN_TYPE type, GUID* pDriveIdArray, int lNumberOfDrives, VDS_HINTS* pHints, 
                                  ulong* pullMaxLunSize);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nn-vdshwprv-ivdssubsystem2
@GUID("be666735-7800-4a77-9d9c-40f85b87e292")
interface IVdsSubSystem2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdssubsystem2-getproperties2
    HRESULT GetProperties2(VDS_SUB_SYSTEM_PROP2* pSubSystemProp2);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdssubsystem2-getdrive2
    HRESULT GetDrive2(short sBusNumber, short sSlotNumber, uint ulEnclosureNumber, IVdsDrive* ppDrive);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdssubsystem2-createlun2
    HRESULT CreateLun2(VDS_LUN_TYPE type, ulong ullSizeInBytes, GUID* pDriveIdArray, int lNumberOfDrives, 
                       PWSTR pwszUnmaskingList, VDS_HINTS2* pHints2, IVdsAsync* ppAsync);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdssubsystem2-querymaxluncreatesize2
    HRESULT QueryMaxLunCreateSize2(VDS_LUN_TYPE type, GUID* pDriveIdArray, int lNumberOfDrives, 
                                   VDS_HINTS2* pHints2, ulong* pullMaxLunSize);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nn-vdshwprv-ivdssubsystemnaming
@GUID("0d70faa3-9cd4-4900-aa20-6981b6aafc75")
interface IVdsSubSystemNaming : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdssubsystemnaming-setfriendlyname
    HRESULT SetFriendlyName(PWSTR pwszFriendlyName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nn-vdshwprv-ivdssubsystemiscsi
@GUID("0027346f-40d0-4b45-8cec-5906dc0380c8")
interface IVdsSubSystemIscsi : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdssubsystemiscsi-querytargets
    HRESULT QueryTargets(IEnumVdsObject* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdssubsystemiscsi-queryportals
    HRESULT QueryPortals(IEnumVdsObject* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdssubsystemiscsi-createtarget
    HRESULT CreateTarget(PWSTR pwszIscsiName, PWSTR pwszFriendlyName, IVdsAsync* ppAsync);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdssubsystemiscsi-setipsecgrouppresharedkey
    HRESULT SetIpsecGroupPresharedKey(VDS_ISCSI_IPSEC_KEY* pIpsecKey);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nn-vdshwprv-ivdssubsysteminterconnect
@GUID("9e6fa560-c141-477b-83ba-0b6c38f7febf")
interface IVdsSubSystemInterconnect : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdssubsysteminterconnect-getsupportedinterconnects
    HRESULT GetSupportedInterconnects(uint* pulSupportedInterconnectsFlag);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nn-vdshwprv-ivdscontrollerport
@GUID("18691d0d-4e7f-43e8-92e4-cf44beeed11c")
interface IVdsControllerPort : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdscontrollerport-getproperties
    HRESULT GetProperties(VDS_PORT_PROP* pPortProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdscontrollerport-getcontroller
    HRESULT GetController(IVdsController* ppController);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdscontrollerport-queryassociatedluns
    HRESULT QueryAssociatedLuns(IEnumVdsObject* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdscontrollerport-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdscontrollerport-setstatus
    HRESULT SetStatus(VDS_PORT_STATUS status);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nn-vdshwprv-ivdscontroller
@GUID("cb53d96e-dffb-474a-a078-790d1e2bc082")
interface IVdsController : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdscontroller-getproperties
    HRESULT GetProperties(VDS_CONTROLLER_PROP* pControllerProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdscontroller-getsubsystem
    HRESULT GetSubSystem(IVdsSubSystem* ppSubSystem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdscontroller-getportproperties
    HRESULT GetPortProperties(short sPortNumber, VDS_PORT_PROP* pPortProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdscontroller-flushcache
    HRESULT FlushCache();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdscontroller-invalidatecache
    HRESULT InvalidateCache();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdscontroller-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdscontroller-queryassociatedluns
    HRESULT QueryAssociatedLuns(IEnumVdsObject* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdscontroller-setstatus
    HRESULT SetStatus(VDS_CONTROLLER_STATUS status);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nn-vdshwprv-ivdscontrollercontrollerport
@GUID("ca5d735f-6bae-42c0-b30e-f2666045ce71")
interface IVdsControllerControllerPort : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdscontrollercontrollerport-querycontrollerports
    HRESULT QueryControllerPorts(IEnumVdsObject* ppEnum);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nn-vdshwprv-ivdsdrive
@GUID("ff24efa4-aade-4b6b-898b-eaa6a20887c7")
interface IVdsDrive : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsdrive-getproperties
    HRESULT GetProperties(VDS_DRIVE_PROP* pDriveProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsdrive-getsubsystem
    HRESULT GetSubSystem(IVdsSubSystem* ppSubSystem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsdrive-queryextents
    HRESULT QueryExtents(VDS_DRIVE_EXTENT** ppExtentArray, int* plNumberOfExtents);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsdrive-setflags
    HRESULT SetFlags(uint ulFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsdrive-clearflags
    HRESULT ClearFlags(uint ulFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsdrive-setstatus
    HRESULT SetStatus(VDS_DRIVE_STATUS status);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nn-vdshwprv-ivdsdrive2
@GUID("60b5a730-addf-4436-8ca7-5769e2d1ffa4")
interface IVdsDrive2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsdrive2-getproperties2
    HRESULT GetProperties2(VDS_DRIVE_PROP2* pDriveProp2);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nn-vdshwprv-ivdslun
@GUID("3540a9c7-e60f-4111-a840-8bba6c2c83d8")
interface IVdsLun : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdslun-getproperties
    HRESULT GetProperties(VDS_LUN_PROP* pLunProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdslun-getsubsystem
    HRESULT GetSubSystem(IVdsSubSystem* ppSubSystem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdslun-getidentificationdata
    HRESULT GetIdentificationData(VDS_LUN_INFORMATION* pLunInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdslun-queryactivecontrollers
    HRESULT QueryActiveControllers(IEnumVdsObject* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdslun-extend
    HRESULT Extend(ulong ullNumberOfBytesToAdd, GUID* pDriveIdArray, int lNumberOfDrives, IVdsAsync* ppAsync);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdslun-shrink
    HRESULT Shrink(ulong ullNumberOfBytesToRemove, IVdsAsync* ppAsync);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdslun-queryplexes
    HRESULT QueryPlexes(IEnumVdsObject* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdslun-addplex
    HRESULT AddPlex(GUID lunId, IVdsAsync* ppAsync);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdslun-removeplex
    HRESULT RemovePlex(GUID plexId, IVdsAsync* ppAsync);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdslun-recover
    HRESULT Recover(IVdsAsync* ppAsync);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdslun-setmask
    HRESULT SetMask(PWSTR pwszUnmaskingList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdslun-delete
    HRESULT Delete();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdslun-associatecontrollers
    HRESULT AssociateControllers(GUID* pActiveControllerIdArray, int lNumberOfActiveControllers, 
                                 GUID* pInactiveControllerIdArray, int lNumberOfInactiveControllers);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdslun-queryhints
    HRESULT QueryHints(VDS_HINTS* pHints);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdslun-applyhints
    HRESULT ApplyHints(VDS_HINTS* pHints);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdslun-setstatus
    HRESULT SetStatus(VDS_LUN_STATUS status);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdslun-querymaxlunextendsize
    HRESULT QueryMaxLunExtendSize(GUID* pDriveIdArray, int lNumberOfDrives, ulong* pullMaxBytesToBeAdded);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nn-vdshwprv-ivdslun2
@GUID("e5b3a735-9efb-499a-8071-4394d9ee6fcb")
interface IVdsLun2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdslun2-queryhints2
    HRESULT QueryHints2(VDS_HINTS2* pHints2);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdslun2-applyhints2
    HRESULT ApplyHints2(VDS_HINTS2* pHints2);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nn-vdshwprv-ivdslunnaming
@GUID("907504cb-6b4e-4d88-a34d-17ba661fbb06")
interface IVdsLunNaming : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdslunnaming-setfriendlyname
    HRESULT SetFriendlyName(PWSTR pwszFriendlyName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nn-vdshwprv-ivdslunnumber
@GUID("d3f95e46-54b3-41f9-b678-0f1871443a08")
interface IVdsLunNumber : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdslunnumber-getlunnumber
    HRESULT GetLunNumber(uint* pulLunNumber);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nn-vdshwprv-ivdsluncontrollerports
@GUID("451fe266-da6d-406a-bb60-82e534f85aeb")
interface IVdsLunControllerPorts : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsluncontrollerports-associatecontrollerports
    HRESULT AssociateControllerPorts(GUID* pActiveControllerPortIdArray, int lNumberOfActiveControllerPorts, 
                                     GUID* pInactiveControllerPortIdArray, int lNumberOfInactiveControllerPorts);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsluncontrollerports-queryactivecontrollerports
    HRESULT QueryActiveControllerPorts(IEnumVdsObject* ppEnum);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nn-vdshwprv-ivdslunmpio
@GUID("7c5fbae3-333a-48a1-a982-33c15788cde3")
interface IVdsLunMpio : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdslunmpio-getpathinfo
    HRESULT GetPathInfo(VDS_PATH_INFO** ppPaths, int* plNumberOfPaths);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdslunmpio-getloadbalancepolicy
    HRESULT GetLoadBalancePolicy(VDS_LOADBALANCE_POLICY_ENUM* pPolicy, VDS_PATH_POLICY** ppPaths, 
                                 int* plNumberOfPaths);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdslunmpio-setloadbalancepolicy
    HRESULT SetLoadBalancePolicy(VDS_LOADBALANCE_POLICY_ENUM policy, VDS_PATH_POLICY* pPaths, int lNumberOfPaths);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdslunmpio-getsupportedlbpolicies
    HRESULT GetSupportedLbPolicies(uint* pulLbFlags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nn-vdshwprv-ivdsluniscsi
@GUID("0d7c1e64-b59b-45ae-b86a-2c2cc6a42067")
interface IVdsLunIscsi : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsluniscsi-associatetargets
    HRESULT AssociateTargets(GUID* pTargetIdArray, int lNumberOfTargets);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsluniscsi-queryassociatedtargets
    HRESULT QueryAssociatedTargets(IEnumVdsObject* ppEnum);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nn-vdshwprv-ivdslunplex
@GUID("0ee1a790-5d2e-4abb-8c99-c481e8be2138")
interface IVdsLunPlex : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdslunplex-getproperties
    HRESULT GetProperties(VDS_LUN_PLEX_PROP* pPlexProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdslunplex-getlun
    HRESULT GetLun(IVdsLun* ppLun);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdslunplex-queryextents
    HRESULT QueryExtents(VDS_DRIVE_EXTENT** ppExtentArray, int* plNumberOfExtents);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdslunplex-queryhints
    HRESULT QueryHints(VDS_HINTS* pHints);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdslunplex-applyhints
    HRESULT ApplyHints(VDS_HINTS* pHints);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nn-vdshwprv-ivdsiscsiportal
@GUID("7fa1499d-ec85-4a8a-a47b-ff69201fcd34")
interface IVdsIscsiPortal : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsiscsiportal-getproperties
    HRESULT GetProperties(VDS_ISCSI_PORTAL_PROP* pPortalProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsiscsiportal-getsubsystem
    HRESULT GetSubSystem(IVdsSubSystem* ppSubSystem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsiscsiportal-queryassociatedportalgroups
    HRESULT QueryAssociatedPortalGroups(IEnumVdsObject* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsiscsiportal-setstatus
    HRESULT SetStatus(VDS_ISCSI_PORTAL_STATUS status);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsiscsiportal-setipsectunneladdress
    HRESULT SetIpsecTunnelAddress(VDS_IPADDRESS* pTunnelAddress, VDS_IPADDRESS* pDestinationAddress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsiscsiportal-getipsecsecurity
    HRESULT GetIpsecSecurity(VDS_IPADDRESS* pInitiatorPortalAddress, ulong* pullSecurityFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsiscsiportal-setipsecsecurity
    HRESULT SetIpsecSecurity(VDS_IPADDRESS* pInitiatorPortalAddress, ulong ullSecurityFlags, 
                             VDS_ISCSI_IPSEC_KEY* pIpsecKey);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nn-vdshwprv-ivdsiscsitarget
@GUID("aa8f5055-83e5-4bcc-aa73-19851a36a849")
interface IVdsIscsiTarget : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsiscsitarget-getproperties
    HRESULT GetProperties(VDS_ISCSI_TARGET_PROP* pTargetProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsiscsitarget-getsubsystem
    HRESULT GetSubSystem(IVdsSubSystem* ppSubSystem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsiscsitarget-queryportalgroups
    HRESULT QueryPortalGroups(IEnumVdsObject* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsiscsitarget-queryassociatedluns
    HRESULT QueryAssociatedLuns(IEnumVdsObject* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsiscsitarget-createportalgroup
    HRESULT CreatePortalGroup(IVdsAsync* ppAsync);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsiscsitarget-delete
    HRESULT Delete(IVdsAsync* ppAsync);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsiscsitarget-setfriendlyname
    HRESULT SetFriendlyName(PWSTR pwszFriendlyName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsiscsitarget-setsharedsecret
    HRESULT SetSharedSecret(VDS_ISCSI_SHARED_SECRET* pTargetSharedSecret, PWSTR pwszInitiatorName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsiscsitarget-rememberinitiatorsharedsecret
    HRESULT RememberInitiatorSharedSecret(PWSTR pwszInitiatorName, VDS_ISCSI_SHARED_SECRET* pInitiatorSharedSecret);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsiscsitarget-getconnectedinitiators
    HRESULT GetConnectedInitiators(PWSTR** pppwszInitiatorList, int* plNumberOfInitiators);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nn-vdshwprv-ivdsiscsiportalgroup
@GUID("fef5f89d-a3dd-4b36-bf28-e7dde045c593")
interface IVdsIscsiPortalGroup : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsiscsiportalgroup-getproperties
    HRESULT GetProperties(VDS_ISCSI_PORTALGROUP_PROP* pPortalGroupProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsiscsiportalgroup-gettarget
    HRESULT GetTarget(IVdsIscsiTarget* ppTarget);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsiscsiportalgroup-queryassociatedportals
    HRESULT QueryAssociatedPortals(IEnumVdsObject* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsiscsiportalgroup-addportal
    HRESULT AddPortal(GUID portalId, IVdsAsync* ppAsync);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsiscsiportalgroup-removeportal
    HRESULT RemovePortal(GUID portalId, IVdsAsync* ppAsync);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsiscsiportalgroup-delete
    HRESULT Delete(IVdsAsync* ppAsync);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nn-vdshwprv-ivdsstoragepool
@GUID("932ca8cf-0eb3-4ba8-9620-22665d7f8450")
interface IVdsStoragePool : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsstoragepool-getprovider
    HRESULT GetProvider(IVdsProvider* ppProvider);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsstoragepool-getproperties
    HRESULT GetProperties(VDS_STORAGE_POOL_PROP* pStoragePoolProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsstoragepool-getattributes
    HRESULT GetAttributes(VDS_POOL_ATTRIBUTES* pStoragePoolAttributes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsstoragepool-querydriveextents
    HRESULT QueryDriveExtents(VDS_STORAGE_POOL_DRIVE_EXTENT** ppExtentArray, int* plNumberOfExtents);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsstoragepool-queryallocatedluns
    HRESULT QueryAllocatedLuns(IEnumVdsObject* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsstoragepool-queryallocatedstoragepools
    HRESULT QueryAllocatedStoragePools(IEnumVdsObject* ppEnum);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nn-vdshwprv-ivdsmaintenance
@GUID("daebeef3-8523-47ed-a2b9-05cecce2a1ae")
interface IVdsMaintenance : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsmaintenance-startmaintenance
    HRESULT StartMaintenance(VDS_MAINTENANCE_OPERATION operation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsmaintenance-stopmaintenance
    HRESULT StopMaintenance(VDS_MAINTENANCE_OPERATION operation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vdshwprv/nf-vdshwprv-ivdsmaintenance-pulsemaintenance
    HRESULT PulseMaintenance(VDS_MAINTENANCE_OPERATION operation, uint ulCount);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nn-vds-ivdsvdprovider
@GUID("b481498c-8354-45f9-84a0-0bdd2832a91f")
interface IVdsVdProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsvdprovider-queryvdisks
    HRESULT QueryVDisks(IEnumVdsObject* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsvdprovider-createvdisk
    HRESULT CreateVDisk(VIRTUAL_STORAGE_TYPE* VirtualDeviceType, PWSTR pPath, PWSTR pStringSecurityDescriptor, 
                        CREATE_VIRTUAL_DISK_FLAG Flags, uint ProviderSpecificFlags, uint Reserved, 
                        VDS_CREATE_VDISK_PARAMETERS* pCreateDiskParameters, IVdsAsync* ppAsync);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsvdprovider-addvdisk
    HRESULT AddVDisk(VIRTUAL_STORAGE_TYPE* VirtualDeviceType, PWSTR pPath, IVdsVDisk* ppVDisk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsvdprovider-getdiskfromvdisk
    HRESULT GetDiskFromVDisk(IVdsVDisk pVDisk, IVdsDisk* ppDisk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsvdprovider-getvdiskfromdisk
    HRESULT GetVDiskFromDisk(IVdsDisk pDisk, IVdsVDisk* ppVDisk);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nn-vds-ivdsvdisk
@GUID("1e062b84-e5e6-4b4b-8a25-67b81e8f13e8")
interface IVdsVDisk : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsvdisk-open
    HRESULT Open(VIRTUAL_DISK_ACCESS_MASK AccessMask, OPEN_VIRTUAL_DISK_FLAG Flags, uint ReadWriteDepth, 
                 IVdsOpenVDisk* ppOpenVDisk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsvdisk-getproperties
    HRESULT GetProperties(VDS_VDISK_PROPERTIES* pDiskProperties);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsvdisk-gethostvolume
    HRESULT GetHostVolume(IVdsVolume* ppVolume);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsvdisk-getdevicename
    HRESULT GetDeviceName(PWSTR* ppDeviceName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nn-vds-ivdsopenvdisk
@GUID("75c8f324-f715-4fe3-a28e-f9011b61a4a1")
interface IVdsOpenVDisk : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsopenvdisk-attach
    HRESULT Attach(PWSTR pStringSecurityDescriptor, ATTACH_VIRTUAL_DISK_FLAG Flags, uint ProviderSpecificFlags, 
                   uint TimeoutInMs, IVdsAsync* ppAsync);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsopenvdisk-detach
    HRESULT Detach(DETACH_VIRTUAL_DISK_FLAG Flags, uint ProviderSpecificFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsopenvdisk-detachanddelete
    HRESULT DetachAndDelete(DETACH_VIRTUAL_DISK_FLAG Flags, uint ProviderSpecificFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsopenvdisk-compact
    HRESULT Compact(COMPACT_VIRTUAL_DISK_FLAG Flags, uint Reserved, IVdsAsync* ppAsync);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsopenvdisk-merge
    HRESULT Merge(MERGE_VIRTUAL_DISK_FLAG Flags, uint MergeDepth, IVdsAsync* ppAsync);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsopenvdisk-expand
    HRESULT Expand(EXPAND_VIRTUAL_DISK_FLAG Flags, ulong NewSize, IVdsAsync* ppAsync);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nn-vds-ivdsserviceloader
@GUID("e0393303-90d4-4a97-ab71-e9b671ee2729")
interface IVdsServiceLoader : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsserviceloader-loadservice
    HRESULT LoadService(PWSTR pwszMachineName, IVdsService* ppService);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nn-vds-ivdsservice
@GUID("0818a8ef-9ba9-40d8-a6f9-e22833cc771e")
interface IVdsService : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsservice-isserviceready
    HRESULT IsServiceReady();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsservice-waitforserviceready
    HRESULT WaitForServiceReady();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsservice-getproperties
    HRESULT GetProperties(VDS_SERVICE_PROP* pServiceProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsservice-queryproviders
    HRESULT QueryProviders(uint masks, IEnumVdsObject* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsservice-querymaskeddisks
    HRESULT QueryMaskedDisks(IEnumVdsObject* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsservice-queryunallocateddisks
    HRESULT QueryUnallocatedDisks(IEnumVdsObject* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsservice-getobject
    HRESULT GetObject(GUID ObjectId, VDS_OBJECT_TYPE type, IUnknown* ppObjectUnk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsservice-querydriveletters
    HRESULT QueryDriveLetters(wchar wcFirstLetter, uint count, VDS_DRIVE_LETTER_PROP* pDriveLetterPropArray);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsservice-queryfilesystemtypes
    HRESULT QueryFileSystemTypes(VDS_FILE_SYSTEM_TYPE_PROP** ppFileSystemTypeProps, int* plNumberOfFileSystems);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsservice-reenumerate
    HRESULT Reenumerate();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsservice-refresh
    HRESULT Refresh();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsservice-cleanupobsoletemountpoints
    HRESULT CleanupObsoleteMountPoints();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsservice-advise
    HRESULT Advise(IVdsAdviseSink pSink, uint* pdwCookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsservice-unadvise
    HRESULT Unadvise(uint dwCookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsservice-reboot
    HRESULT Reboot();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsservice-setflags
    HRESULT SetFlags(uint ulFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsservice-clearflags
    HRESULT ClearFlags(uint ulFlags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nn-vds-ivdsserviceuninstalldisk
@GUID("b6b22da8-f903-4be7-b492-c09d875ac9da")
interface IVdsServiceUninstallDisk : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsserviceuninstalldisk-getdiskidfromluninfo
    HRESULT GetDiskIdFromLunInfo(VDS_LUN_INFORMATION* pLunInfo, GUID* pDiskId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsserviceuninstalldisk-uninstalldisks
    HRESULT UninstallDisks(GUID* pDiskIdArray, uint ulCount, BOOLEAN bForce, ubyte* pbReboot, HRESULT* pResults);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nn-vds-ivdsservicehba
@GUID("0ac13689-3134-47c6-a17c-4669216801be")
interface IVdsServiceHba : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsservicehba-queryhbaports
    HRESULT QueryHbaPorts(IEnumVdsObject* ppEnum);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nn-vds-ivdsserviceiscsi
@GUID("14fbe036-3ed7-4e10-90e9-a5ff991aff01")
interface IVdsServiceIscsi : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsserviceiscsi-getinitiatorname
    HRESULT GetInitiatorName(PWSTR* ppwszIscsiName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsserviceiscsi-queryinitiatoradapters
    HRESULT QueryInitiatorAdapters(IEnumVdsObject* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsserviceiscsi-setipsecgrouppresharedkey
    HRESULT SetIpsecGroupPresharedKey(VDS_ISCSI_IPSEC_KEY* pIpsecKey);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsserviceiscsi-setallipsectunneladdresses
    HRESULT SetAllIpsecTunnelAddresses(VDS_IPADDRESS* pTunnelAddress, VDS_IPADDRESS* pDestinationAddress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsserviceiscsi-setallipsecsecurity
    HRESULT SetAllIpsecSecurity(GUID targetPortalId, ulong ullSecurityFlags, VDS_ISCSI_IPSEC_KEY* pIpsecKey);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsserviceiscsi-setinitiatorsharedsecret
    HRESULT SetInitiatorSharedSecret(VDS_ISCSI_SHARED_SECRET* pInitiatorSharedSecret, GUID targetId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsserviceiscsi-remembertargetsharedsecret
    HRESULT RememberTargetSharedSecret(GUID targetId, VDS_ISCSI_SHARED_SECRET* pTargetSharedSecret);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nn-vds-ivdsserviceinitialization
@GUID("4afc3636-db01-4052-80c3-03bbcb8d3c69")
interface IVdsServiceInitialization : IUnknown
{
    HRESULT Initialize(PWSTR pwszMachineName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nn-vds-ivdshbaport
@GUID("2abd757f-2851-4997-9a13-47d2a885d6ca")
interface IVdsHbaPort : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdshbaport-getproperties
    HRESULT GetProperties(VDS_HBAPORT_PROP* pHbaPortProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdshbaport-setallpathstatuses
    HRESULT SetAllPathStatuses(VDS_PATH_STATUS status);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nn-vds-ivdsiscsiinitiatoradapter
@GUID("b07fedd4-1682-4440-9189-a39b55194dc5")
interface IVdsIscsiInitiatorAdapter : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsiscsiinitiatoradapter-getproperties
    HRESULT GetProperties(VDS_ISCSI_INITIATOR_ADAPTER_PROP* pInitiatorAdapterProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsiscsiinitiatoradapter-queryinitiatorportals
    HRESULT QueryInitiatorPortals(IEnumVdsObject* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsiscsiinitiatoradapter-logintotarget
    HRESULT LoginToTarget(VDS_ISCSI_LOGIN_TYPE loginType, GUID targetId, GUID targetPortalId, 
                          GUID initiatorPortalId, uint ulLoginFlags, BOOL bHeaderDigest, BOOL bDataDigest, 
                          VDS_ISCSI_AUTH_TYPE authType, IVdsAsync* ppAsync);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsiscsiinitiatoradapter-logoutfromtarget
    HRESULT LogoutFromTarget(GUID targetId, IVdsAsync* ppAsync);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nn-vds-ivdsiscsiinitiatorportal
@GUID("38a0a9ab-7cc8-4693-ac07-1f28bd03c3da")
interface IVdsIscsiInitiatorPortal : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsiscsiinitiatorportal-getproperties
    HRESULT GetProperties(VDS_ISCSI_INITIATOR_PORTAL_PROP* pInitiatorPortalProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsiscsiinitiatorportal-getinitiatoradapter
    HRESULT GetInitiatorAdapter(IVdsIscsiInitiatorAdapter* ppInitiatorAdapter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsiscsiinitiatorportal-setipsectunneladdress
    HRESULT SetIpsecTunnelAddress(VDS_IPADDRESS* pTunnelAddress, VDS_IPADDRESS* pDestinationAddress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsiscsiinitiatorportal-getipsecsecurity
    HRESULT GetIpsecSecurity(GUID targetPortalId, ulong* pullSecurityFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsiscsiinitiatorportal-setipsecsecurity
    HRESULT SetIpsecSecurity(GUID targetPortalId, ulong ullSecurityFlags, VDS_ISCSI_IPSEC_KEY* pIpsecKey);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nn-vds-ivdsdiskpartitionmf
@GUID("538684e0-ba3d-4bc0-aca9-164aff85c2a9")
interface IVdsDiskPartitionMF : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsdiskpartitionmf-getpartitionfilesystemproperties
    HRESULT GetPartitionFileSystemProperties(ulong ullOffset, VDS_FILE_SYSTEM_PROP* pFileSystemProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsdiskpartitionmf-getpartitionfilesystemtypename
    HRESULT GetPartitionFileSystemTypeName(ulong ullOffset, PWSTR* ppwszFileSystemTypeName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsdiskpartitionmf-querypartitionfilesystemformatsupport
    HRESULT QueryPartitionFileSystemFormatSupport(ulong ullOffset, 
                                                  VDS_FILE_SYSTEM_FORMAT_SUPPORT_PROP** ppFileSystemSupportProps, 
                                                  int* plNumberOfFileSystems);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsdiskpartitionmf-formatpartitionex
    HRESULT FormatPartitionEx(ulong ullOffset, PWSTR pwszFileSystemTypeName, ushort usFileSystemRevision, 
                              uint ulDesiredUnitAllocationSize, PWSTR pwszLabel, BOOL bForce, BOOL bQuickFormat, 
                              BOOL bEnableCompression, IVdsAsync* ppAsync);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nn-vds-ivdsvolumemf
@GUID("ee2d5ded-6236-4169-931d-b9778ce03dc6")
interface IVdsVolumeMF : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsvolumemf-getfilesystemproperties
    HRESULT GetFileSystemProperties(VDS_FILE_SYSTEM_PROP* pFileSystemProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsvolumemf-format
    HRESULT Format(VDS_FILE_SYSTEM_TYPE type, PWSTR pwszLabel, uint dwUnitAllocationSize, BOOL bForce, 
                   BOOL bQuickFormat, BOOL bEnableCompression, IVdsAsync* ppAsync);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsvolumemf-addaccesspath
    HRESULT AddAccessPath(PWSTR pwszPath);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsvolumemf-queryaccesspaths
    HRESULT QueryAccessPaths(PWSTR** pwszPathArray, int* plNumberOfAccessPaths);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsvolumemf-queryreparsepoints
    HRESULT QueryReparsePoints(VDS_REPARSE_POINT_PROP** ppReparsePointProps, int* plNumberOfReparsePointProps);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsvolumemf-deleteaccesspath
    HRESULT DeleteAccessPath(PWSTR pwszPath, BOOL bForce);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsvolumemf-mount
    HRESULT Mount();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsvolumemf-dismount
    HRESULT Dismount(BOOL bForce, BOOL bPermanent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsvolumemf-setfilesystemflags
    HRESULT SetFileSystemFlags(uint ulFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsvolumemf-clearfilesystemflags
    HRESULT ClearFileSystemFlags(uint ulFlags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nn-vds-ivdsvolumemf2
@GUID("4dbcee9a-6343-4651-b85f-5e75d74d983c")
interface IVdsVolumeMF2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsvolumemf2-getfilesystemtypename
    HRESULT GetFileSystemTypeName(PWSTR* ppwszFileSystemTypeName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsvolumemf2-queryfilesystemformatsupport
    HRESULT QueryFileSystemFormatSupport(VDS_FILE_SYSTEM_FORMAT_SUPPORT_PROP** ppFileSystemSupportProps, 
                                         int* plNumberOfFileSystems);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsvolumemf2-formatex
    HRESULT FormatEx(PWSTR pwszFileSystemTypeName, ushort usFileSystemRevision, uint ulDesiredUnitAllocationSize, 
                     PWSTR pwszLabel, BOOL bForce, BOOL bQuickFormat, BOOL bEnableCompression, IVdsAsync* ppAsync);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nn-vds-ivdsvolumeshrink
@GUID("d68168c9-82a2-4f85-b6e9-74707c49a58f")
interface IVdsVolumeShrink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsvolumeshrink-querymaxreclaimablebytes
    HRESULT QueryMaxReclaimableBytes(ulong* pullMaxNumberOfReclaimableBytes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsvolumeshrink-shrink
    HRESULT Shrink(ulong ullDesiredNumberOfReclaimableBytes, ulong ullMinNumberOfReclaimableBytes, 
                   IVdsAsync* ppAsync);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nn-vds-ivdssubsystemimporttarget
@GUID("83bfb87f-43fb-4903-baa6-127f01029eec")
interface IVdsSubSystemImportTarget : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdssubsystemimporttarget-getimporttarget
    HRESULT GetImportTarget(PWSTR* ppwszIscsiName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdssubsystemimporttarget-setimporttarget
    HRESULT SetImportTarget(PWSTR pwszIscsiName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nn-vds-ivdsiscsiportallocal
@GUID("ad837c28-52c1-421d-bf04-fae7da665396")
interface IVdsIscsiPortalLocal : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsiscsiportallocal-setipsecsecuritylocal
    HRESULT SetIpsecSecurityLocal(ulong ullSecurityFlags, VDS_ISCSI_IPSEC_KEY* pIpsecKey);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nn-vds-ivdsservicesan
@GUID("fc5d23e8-a88b-41a5-8de0-2d2f73c5a630")
interface IVdsServiceSAN : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsservicesan-getsanpolicy
    HRESULT GetSANPolicy(VDS_SAN_POLICY* pSanPolicy);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsservicesan-setsanpolicy
    HRESULT SetSANPolicy(VDS_SAN_POLICY SanPolicy);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nn-vds-ivdsvolumemf3
@GUID("6788faf9-214e-4b85-ba59-266953616e09")
interface IVdsVolumeMF3 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsvolumemf3-queryvolumeguidpathnames
    HRESULT QueryVolumeGuidPathnames(PWSTR** pwszPathArray, uint* pulNumberOfPaths);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsvolumemf3-formatex2
    HRESULT FormatEx2(PWSTR pwszFileSystemTypeName, ushort usFileSystemRevision, uint ulDesiredUnitAllocationSize, 
                      PWSTR pwszLabel, uint Options, IVdsAsync* ppAsync);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsvolumemf3-offlinevolume
    HRESULT OfflineVolume();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nn-vds-ivdsdiskpartitionmf2
@GUID("9cbe50ca-f2d2-4bf4-ace1-96896b729625")
interface IVdsDiskPartitionMF2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vds/nf-vds-ivdsdiskpartitionmf2-formatpartitionex2
    HRESULT FormatPartitionEx2(ulong ullOffset, PWSTR pwszFileSystemTypeName, ushort usFileSystemRevision, 
                               uint ulDesiredUnitAllocationSize, PWSTR pwszLabel, uint Options, IVdsAsync* ppAsync);
}

@GUID("15fc031c-0652-4306-b2c3-f558b8f837e2")
interface IVdsServiceSw : IUnknown
{
    HRESULT GetDiskObject(const(PWSTR) pwszDeviceID, IUnknown* ppDiskUnk);
}


// GUIDs


const GUID IID_IEnumVdsObject               = GUIDOF!IEnumVdsObject;
const GUID IID_IVdsAdmin                    = GUIDOF!IVdsAdmin;
const GUID IID_IVdsAdvancedDisk             = GUIDOF!IVdsAdvancedDisk;
const GUID IID_IVdsAdvancedDisk2            = GUIDOF!IVdsAdvancedDisk2;
const GUID IID_IVdsAdvancedDisk3            = GUIDOF!IVdsAdvancedDisk3;
const GUID IID_IVdsAdviseSink               = GUIDOF!IVdsAdviseSink;
const GUID IID_IVdsAsync                    = GUIDOF!IVdsAsync;
const GUID IID_IVdsController               = GUIDOF!IVdsController;
const GUID IID_IVdsControllerControllerPort = GUIDOF!IVdsControllerControllerPort;
const GUID IID_IVdsControllerPort           = GUIDOF!IVdsControllerPort;
const GUID IID_IVdsCreatePartitionEx        = GUIDOF!IVdsCreatePartitionEx;
const GUID IID_IVdsDisk                     = GUIDOF!IVdsDisk;
const GUID IID_IVdsDisk2                    = GUIDOF!IVdsDisk2;
const GUID IID_IVdsDisk3                    = GUIDOF!IVdsDisk3;
const GUID IID_IVdsDiskOnline               = GUIDOF!IVdsDiskOnline;
const GUID IID_IVdsDiskPartitionMF          = GUIDOF!IVdsDiskPartitionMF;
const GUID IID_IVdsDiskPartitionMF2         = GUIDOF!IVdsDiskPartitionMF2;
const GUID IID_IVdsDrive                    = GUIDOF!IVdsDrive;
const GUID IID_IVdsDrive2                   = GUIDOF!IVdsDrive2;
const GUID IID_IVdsHbaPort                  = GUIDOF!IVdsHbaPort;
const GUID IID_IVdsHwProvider               = GUIDOF!IVdsHwProvider;
const GUID IID_IVdsHwProviderPrivate        = GUIDOF!IVdsHwProviderPrivate;
const GUID IID_IVdsHwProviderPrivateMpio    = GUIDOF!IVdsHwProviderPrivateMpio;
const GUID IID_IVdsHwProviderStoragePools   = GUIDOF!IVdsHwProviderStoragePools;
const GUID IID_IVdsHwProviderType           = GUIDOF!IVdsHwProviderType;
const GUID IID_IVdsHwProviderType2          = GUIDOF!IVdsHwProviderType2;
const GUID IID_IVdsIscsiInitiatorAdapter    = GUIDOF!IVdsIscsiInitiatorAdapter;
const GUID IID_IVdsIscsiInitiatorPortal     = GUIDOF!IVdsIscsiInitiatorPortal;
const GUID IID_IVdsIscsiPortal              = GUIDOF!IVdsIscsiPortal;
const GUID IID_IVdsIscsiPortalGroup         = GUIDOF!IVdsIscsiPortalGroup;
const GUID IID_IVdsIscsiPortalLocal         = GUIDOF!IVdsIscsiPortalLocal;
const GUID IID_IVdsIscsiTarget              = GUIDOF!IVdsIscsiTarget;
const GUID IID_IVdsLun                      = GUIDOF!IVdsLun;
const GUID IID_IVdsLun2                     = GUIDOF!IVdsLun2;
const GUID IID_IVdsLunControllerPorts       = GUIDOF!IVdsLunControllerPorts;
const GUID IID_IVdsLunIscsi                 = GUIDOF!IVdsLunIscsi;
const GUID IID_IVdsLunMpio                  = GUIDOF!IVdsLunMpio;
const GUID IID_IVdsLunNaming                = GUIDOF!IVdsLunNaming;
const GUID IID_IVdsLunNumber                = GUIDOF!IVdsLunNumber;
const GUID IID_IVdsLunPlex                  = GUIDOF!IVdsLunPlex;
const GUID IID_IVdsMaintenance              = GUIDOF!IVdsMaintenance;
const GUID IID_IVdsOpenVDisk                = GUIDOF!IVdsOpenVDisk;
const GUID IID_IVdsPack                     = GUIDOF!IVdsPack;
const GUID IID_IVdsPack2                    = GUIDOF!IVdsPack2;
const GUID IID_IVdsProvider                 = GUIDOF!IVdsProvider;
const GUID IID_IVdsProviderPrivate          = GUIDOF!IVdsProviderPrivate;
const GUID IID_IVdsProviderSupport          = GUIDOF!IVdsProviderSupport;
const GUID IID_IVdsRemovable                = GUIDOF!IVdsRemovable;
const GUID IID_IVdsService                  = GUIDOF!IVdsService;
const GUID IID_IVdsServiceHba               = GUIDOF!IVdsServiceHba;
const GUID IID_IVdsServiceInitialization    = GUIDOF!IVdsServiceInitialization;
const GUID IID_IVdsServiceIscsi             = GUIDOF!IVdsServiceIscsi;
const GUID IID_IVdsServiceLoader            = GUIDOF!IVdsServiceLoader;
const GUID IID_IVdsServiceSAN               = GUIDOF!IVdsServiceSAN;
const GUID IID_IVdsServiceSw                = GUIDOF!IVdsServiceSw;
const GUID IID_IVdsServiceUninstallDisk     = GUIDOF!IVdsServiceUninstallDisk;
const GUID IID_IVdsStoragePool              = GUIDOF!IVdsStoragePool;
const GUID IID_IVdsSubSystem                = GUIDOF!IVdsSubSystem;
const GUID IID_IVdsSubSystem2               = GUIDOF!IVdsSubSystem2;
const GUID IID_IVdsSubSystemImportTarget    = GUIDOF!IVdsSubSystemImportTarget;
const GUID IID_IVdsSubSystemInterconnect    = GUIDOF!IVdsSubSystemInterconnect;
const GUID IID_IVdsSubSystemIscsi           = GUIDOF!IVdsSubSystemIscsi;
const GUID IID_IVdsSubSystemNaming          = GUIDOF!IVdsSubSystemNaming;
const GUID IID_IVdsSwProvider               = GUIDOF!IVdsSwProvider;
const GUID IID_IVdsVDisk                    = GUIDOF!IVdsVDisk;
const GUID IID_IVdsVdProvider               = GUIDOF!IVdsVdProvider;
const GUID IID_IVdsVolume                   = GUIDOF!IVdsVolume;
const GUID IID_IVdsVolume2                  = GUIDOF!IVdsVolume2;
const GUID IID_IVdsVolumeMF                 = GUIDOF!IVdsVolumeMF;
const GUID IID_IVdsVolumeMF2                = GUIDOF!IVdsVolumeMF2;
const GUID IID_IVdsVolumeMF3                = GUIDOF!IVdsVolumeMF3;
const GUID IID_IVdsVolumeOnline             = GUIDOF!IVdsVolumeOnline;
const GUID IID_IVdsVolumePlex               = GUIDOF!IVdsVolumePlex;
const GUID IID_IVdsVolumeShrink             = GUIDOF!IVdsVolumeShrink;
