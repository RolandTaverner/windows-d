// Written in the D programming language.

module windows.win32.networkmanagement.qos;

public import windows.core;
public import windows.win32.foundation.foundation : BOOL, BOOLEAN, HANDLE, PSTR, PWSTR;
public import windows.win32.networkmanagement.ndis : NETWORK_ADDRESS_LIST;
public import windows.win32.networking.winsock : FLOWSPEC, SOCKADDR, SOCKET;
public import windows.win32.system.io : OVERLAPPED;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qos2/ne-qos2-qos_traffic_type
alias QOS_TRAFFIC_TYPE = int;
enum : int
{
    QOSTrafficTypeBestEffort      = 0x00000000,
    QOSTrafficTypeBackground      = 0x00000001,
    QOSTrafficTypeExcellentEffort = 0x00000002,
    QOSTrafficTypeAudioVideo      = 0x00000003,
    QOSTrafficTypeVoice           = 0x00000004,
    QOSTrafficTypeControl         = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qos2/ne-qos2-qos_set_flow
alias QOS_SET_FLOW = int;
enum : int
{
    QOSSetTrafficType       = 0x00000000,
    QOSSetOutgoingRate      = 0x00000001,
    QOSSetOutgoingDSCPValue = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qos2/ne-qos2-qos_flowrate_reason
alias QOS_FLOWRATE_REASON = int;
enum : int
{
    QOSFlowRateNotApplicable         = 0x00000000,
    QOSFlowRateContentChange         = 0x00000001,
    QOSFlowRateCongestion            = 0x00000002,
    QOSFlowRateHigherContentEncoding = 0x00000003,
    QOSFlowRateUserCaused            = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qos2/ne-qos2-qos_shaping
alias QOS_SHAPING = int;
enum : int
{
    QOSShapeOnly                = 0x00000000,
    QOSShapeAndMark             = 0x00000001,
    QOSUseNonConformantMarkings = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qos2/ne-qos2-qos_query_flow
alias QOS_QUERY_FLOW = int;
enum : int
{
    QOSQueryFlowFundamentals = 0x00000000,
    QOSQueryPacketPriority   = 0x00000001,
    QOSQueryOutgoingRate     = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qos2/ne-qos2-qos_notify_flow
alias QOS_NOTIFY_FLOW = int;
enum : int
{
    QOSNotifyCongested   = 0x00000000,
    QOSNotifyUncongested = 0x00000001,
    QOSNotifyAvailable   = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qossp/ne-qossp-filtertype
enum FilterType : int
{
    FILTERSPECV4      = 0x00000001,
    FILTERSPECV6      = 0x00000002,
    FILTERSPECV6_FLOW = 0x00000003,
    FILTERSPECV4_GPI  = 0x00000004,
    FILTERSPECV6_GPI  = 0x00000005,
    FILTERSPEC_END    = 0x00000006,
}

// Constants


enum uint QOS_MAX_OBJECT_STRING_LENGTH = 0x00000100U;
enum uint QOS_TRAFFIC_GENERAL_ID_BASE = 0x00000fa0U;

enum : uint
{
    SERVICETYPE_NOTRAFFIC           = 0x00000000U,
    SERVICETYPE_BESTEFFORT          = 0x00000001U,
    SERVICETYPE_CONTROLLEDLOAD      = 0x00000002U,
    SERVICETYPE_GUARANTEED          = 0x00000003U,
    SERVICETYPE_NETWORK_UNAVAILABLE = 0x00000004U,
}

enum uint SERVICETYPE_GENERAL_INFORMATION = 0x00000005U;

enum : uint
{
    SERVICETYPE_NOCHANGE        = 0x00000006U,
    SERVICETYPE_NONCONFORMING   = 0x00000009U,
    SERVICETYPE_NETWORK_CONTROL = 0x0000000aU,
    SERVICETYPE_QUALITATIVE     = 0x0000000dU,
}

enum : uint
{
    SERVICE_BESTEFFORT     = 0x80010000U,
    SERVICE_CONTROLLEDLOAD = 0x80020000U,
}

enum : uint
{
    SERVICE_GUARANTEED         = 0x80040000U,
    SERVICE_QUALITATIVE        = 0x80200000U,
    SERVICE_NO_TRAFFIC_CONTROL = 0x81000000U,
    SERVICE_NO_QOS_SIGNALING   = 0x40000000U,
}

enum uint QOS_NOT_SPECIFIED = 0xffffffffU;
enum uint POSITIVE_INFINITY_RATE = 0xfffffffeU;
enum uint QOS_GENERAL_ID_BASE = 0x000007d0U;

enum : uint
{
    TC_NONCONF_BORROW      = 0x00000000U,
    TC_NONCONF_SHAPE       = 0x00000001U,
    TC_NONCONF_DISCARD     = 0x00000002U,
    TC_NONCONF_BORROW_PLUS = 0x00000003U,
}

enum uint CURRENT_TCI_VERSION = 0x00000002U;

enum : uint
{
    TC_NOTIFY_IFC_UP        = 0x00000001U,
    TC_NOTIFY_IFC_CLOSE     = 0x00000002U,
    TC_NOTIFY_IFC_CHANGE    = 0x00000003U,
    TC_NOTIFY_PARAM_CHANGED = 0x00000004U,
    TC_NOTIFY_FLOW_CLOSE    = 0x00000005U,
}

enum uint MAX_STRING_LENGTH = 0x00000100U;
enum uint QOS_OUTGOING_DEFAULT_MINIMUM_BANDWIDTH = 0xffffffffU;
enum uint QOS_QUERYFLOW_FRESH = 0x00000001U;
enum uint QOS_NON_ADAPTIVE_FLOW = 0x00000002U;
enum uint RSVP_OBJECT_ID_BASE = 0x000003e8U;
enum uint RSVP_DEFAULT_STYLE = 0x00000000U;
enum uint RSVP_WILDCARD_STYLE = 0x00000001U;
enum uint RSVP_FIXED_FILTER_STYLE = 0x00000002U;
enum uint RSVP_SHARED_EXPLICIT_STYLE = 0x00000003U;
enum uint AD_FLAG_BREAK_BIT = 0x00000001U;

enum : uint
{
    mIOC_IN     = 0x80000000U,
    mIOC_OUT    = 0x40000000U,
    mIOC_VENDOR = 0x04000000U,
}

enum uint mCOMPANY = 0x18000000U;
enum uint ioctl_code = 0x00000001U;
enum uint QOSSPBASE = 0x0000c350U;
enum uint ALLOWED_TO_SEND_DATA = 0x0000c351U;
enum uint ABLE_TO_RECV_RSVP = 0x0000c352U;
enum uint LINE_RATE = 0x0000c353U;
enum uint LOCAL_TRAFFIC_CONTROL = 0x0000c354U;
enum uint LOCAL_QOSABILITY = 0x0000c355U;
enum uint END_TO_END_QOSABILITY = 0x0000c356U;
enum uint INFO_NOT_AVAILABLE = 0xffffffffU;
enum uint ANY_DEST_ADDR = 0xffffffffU;
enum uint MODERATELY_DELAY_SENSITIVE = 0xfffffffdU;
enum uint HIGHLY_DELAY_SENSITIVE = 0xfffffffeU;
enum uint QOSSP_ERR_BASE = 0x0000dac0U;

enum : uint
{
    GQOS_NO_ERRORCODE  = 0x00000000U,
    GQOS_NO_ERRORVALUE = 0x00000000U,
}

enum : uint
{
    GQOS_ERRORCODE_UNKNOWN  = 0xffffffffU,
    GQOS_ERRORVALUE_UNKNOWN = 0xffffffffU,
}

enum : uint
{
    GQOS_NET_ADMISSION = 0x0000db24U,
    GQOS_NET_POLICY    = 0x0000db88U,
}

enum : uint
{
    GQOS_RSVP          = 0x0000dbecU,
    GQOS_API           = 0x0000dc50U,
    GQOS_KERNEL_TC_SYS = 0x0000dcb4U,
}

enum uint GQOS_RSVP_SYS = 0x0000dd18U;
enum uint GQOS_KERNEL_TC = 0x0000dd7cU;
enum uint PE_TYPE_APPID = 0x00000003U;
enum uint PE_ATTRIB_TYPE_POLICY_LOCATOR = 0x00000001U;

enum : uint
{
    POLICY_LOCATOR_SUB_TYPE_ASCII_DN       = 0x00000001U,
    POLICY_LOCATOR_SUB_TYPE_UNICODE_DN     = 0x00000002U,
    POLICY_LOCATOR_SUB_TYPE_ASCII_DN_ENC   = 0x00000003U,
    POLICY_LOCATOR_SUB_TYPE_UNICODE_DN_ENC = 0x00000004U,
}

enum uint PE_ATTRIB_TYPE_CREDENTIAL = 0x00000002U;

enum : uint
{
    CREDENTIAL_SUB_TYPE_ASCII_ID     = 0x00000001U,
    CREDENTIAL_SUB_TYPE_UNICODE_ID   = 0x00000002U,
    CREDENTIAL_SUB_TYPE_KERBEROS_TKT = 0x00000003U,
    CREDENTIAL_SUB_TYPE_X509_V3_CERT = 0x00000004U,
    CREDENTIAL_SUB_TYPE_PGP_CERT     = 0x00000005U,
}

enum uint TCBASE = 0x00001d4cU;
enum uint ERROR_INCOMPATIBLE_TCI_VERSION = 0x00001d4dU;

enum : uint
{
    ERROR_INVALID_SERVICE_TYPE  = 0x00001d4eU,
    ERROR_INVALID_TOKEN_RATE    = 0x00001d4fU,
    ERROR_INVALID_PEAK_RATE     = 0x00001d50U,
    ERROR_INVALID_SD_MODE       = 0x00001d51U,
    ERROR_INVALID_QOS_PRIORITY  = 0x00001d52U,
    ERROR_INVALID_TRAFFIC_CLASS = 0x00001d53U,
    ERROR_INVALID_ADDRESS_TYPE  = 0x00001d54U,
}

enum uint ERROR_DUPLICATE_FILTER = 0x00001d55U;
enum uint ERROR_FILTER_CONFLICT = 0x00001d56U;
enum uint ERROR_ADDRESS_TYPE_NOT_SUPPORTED = 0x00001d57U;
enum uint ERROR_TC_SUPPORTED_OBJECTS_EXIST = 0x00001d58U;
enum uint ERROR_INCOMPATABLE_QOS = 0x00001d59U;

enum : uint
{
    ERROR_TC_NOT_SUPPORTED         = 0x00001d5aU,
    ERROR_TC_OBJECT_LENGTH_INVALID = 0x00001d5bU,
}

enum : uint
{
    ERROR_INVALID_FLOW_MODE     = 0x00001d5cU,
    ERROR_INVALID_DIFFSERV_FLOW = 0x00001d5dU,
}

enum uint ERROR_DS_MAPPING_EXISTS = 0x00001d5eU;

enum : uint
{
    ERROR_INVALID_SHAPE_RATE = 0x00001d5fU,
    ERROR_INVALID_DS_CLASS   = 0x00001d60U,
}

enum uint ERROR_TOO_MANY_CLIENTS = 0x00001d61U;
enum GUID GUID_QOS_REMAINING_BANDWIDTH = GUID("c4c51720-40ec-11d1-2c91-00aa00574915");
enum GUID GUID_QOS_BESTEFFORT_BANDWIDTH = GUID("ed885290-40ec-11d1-2c91-00aa00574915");

enum : GUID
{
    GUID_QOS_LATENCY              = GUID("fc408ef0-40ec-11d1-2c91-00aa00574915"),
    GUID_QOS_FLOW_COUNT           = GUID("1147f880-40ed-11d1-2c91-00aa00574915"),
    GUID_QOS_NON_BESTEFFORT_LIMIT = GUID("185c44e0-40ed-11d1-2c91-00aa00574915"),
}

enum GUID GUID_QOS_MAX_OUTSTANDING_SENDS = GUID("161ffa86-6120-11d1-2c91-00aa00574915");
enum GUID GUID_QOS_STATISTICS_BUFFER = GUID("bb2c0980-e900-11d1-b07e-0080c71382bf");

enum : GUID
{
    GUID_QOS_FLOW_MODE        = GUID("5c82290a-515a-11d2-8e58-00c04fc9bfcb"),
    GUID_QOS_ISSLOW_FLOW      = GUID("abf273a4-ee07-11d2-be1b-00a0c99ee63b"),
    GUID_QOS_TIMER_RESOLUTION = GUID("ba10cc88-f13e-11d2-be1b-00a0c99ee63b"),
}

enum : GUID
{
    GUID_QOS_FLOW_IP_CONFORMING       = GUID("07f99a8b-fcd2-11d2-be1e-00a0c99ee63b"),
    GUID_QOS_FLOW_IP_NONCONFORMING    = GUID("087a5987-fcd2-11d2-be1e-00a0c99ee63b"),
    GUID_QOS_FLOW_8021P_CONFORMING    = GUID("08c1e013-fcd2-11d2-be1e-00a0c99ee63b"),
    GUID_QOS_FLOW_8021P_NONCONFORMING = GUID("09023f91-fcd2-11d2-be1e-00a0c99ee63b"),
}

enum : GUID
{
    GUID_QOS_ENABLE_AVG_STATS         = GUID("bafb6d11-27c4-4801-a46f-ef8080c188c8"),
    GUID_QOS_ENABLE_WINDOW_ADJUSTMENT = GUID("aa966725-d3e9-4c55-b335-2a00279a1e64"),
}

enum uint FSCTL_TCP_BASE = 0x00000012U;
enum const(wchar)* DD_TCP_DEVICE_NAME = "\\Device\\Tcp";
enum uint IF_MIB_STATS_ID = 0x00000001U;

enum : uint
{
    IP_MIB_STATS_ID           = 0x00000001U,
    IP_MIB_ADDRTABLE_ENTRY_ID = 0x00000102U,
}

enum uint IP_INTFC_INFO_ID = 0x00000103U;
enum uint MAX_PHYSADDR_SIZE = 0x00000008U;

enum : uint
{
    SIPAEV_PREBOOT_CERT    = 0x00000000U,
    SIPAEV_POST_CODE       = 0x00000001U,
    SIPAEV_UNUSED          = 0x00000002U,
    SIPAEV_NO_ACTION       = 0x00000003U,
    SIPAEV_SEPARATOR       = 0x00000004U,
    SIPAEV_ACTION          = 0x00000005U,
    SIPAEV_EVENT_TAG       = 0x00000006U,
    SIPAEV_S_CRTM_CONTENTS = 0x00000007U,
    SIPAEV_S_CRTM_VERSION  = 0x00000008U,
}

enum uint SIPAEV_CPU_MICROCODE = 0x00000009U;
enum uint SIPAEV_PLATFORM_CONFIG_FLAGS = 0x0000000aU;
enum uint SIPAEV_TABLE_OF_DEVICES = 0x0000000bU;
enum uint SIPAEV_COMPACT_HASH = 0x0000000cU;

enum : uint
{
    SIPAEV_IPL                = 0x0000000dU,
    SIPAEV_IPL_PARTITION_DATA = 0x0000000eU,
}

enum : uint
{
    SIPAEV_NONHOST_CODE   = 0x0000000fU,
    SIPAEV_NONHOST_CONFIG = 0x00000010U,
    SIPAEV_NONHOST_INFO   = 0x00000011U,
}

enum uint SIPAEV_OMIT_BOOT_DEVICE_EVENTS = 0x00000012U;

enum : uint
{
    SIPAEV_EFI_EVENT_BASE                = 0x80000000U,
    SIPAEV_EFI_VARIABLE_DRIVER_CONFIG    = 0x80000001U,
    SIPAEV_EFI_VARIABLE_BOOT             = 0x80000002U,
    SIPAEV_EFI_BOOT_SERVICES_APPLICATION = 0x80000003U,
    SIPAEV_EFI_BOOT_SERVICES_DRIVER      = 0x80000004U,
}

enum uint SIPAEV_EFI_RUNTIME_SERVICES_DRIVER = 0x80000005U;

enum : uint
{
    SIPAEV_EFI_GPT_EVENT              = 0x80000006U,
    SIPAEV_EFI_ACTION                 = 0x80000007U,
    SIPAEV_EFI_PLATFORM_FIRMWARE_BLOB = 0x80000008U,
}

enum : uint
{
    SIPAEV_EFI_HANDOFF_TABLES          = 0x80000009U,
    SIPAEV_EFI_PLATFORM_FIRMWARE_BLOB2 = 0x8000000aU,
}

enum : uint
{
    SIPAEV_EFI_HANDOFF_TABLES2    = 0x8000000bU,
    SIPAEV_EFI_VARIABLE_BOOT2     = 0x8000000cU,
    SIPAEV_EFI_HCRTM_EVENT        = 0x80000010U,
    SIPAEV_EFI_VARIABLE_AUTHORITY = 0x800000e0U,
}

enum : uint
{
    SIPAEV_EFI_SPDM_FIRMWARE_BLOB   = 0x800000e1U,
    SIPAEV_EFI_SPDM_FIRMWARE_CONFIG = 0x800000e2U,
}

enum : uint
{
    SIPAEV_TXT_EVENT_BASE           = 0x00000400U,
    SIPAEV_TXT_PCR_MAPPING          = 0x00000401U,
    SIPAEV_TXT_HASH_START           = 0x00000402U,
    SIPAEV_TXT_COMBINED_HASH        = 0x00000403U,
    SIPAEV_TXT_MLE_HASH             = 0x00000404U,
    SIPAEV_TXT_BIOSAC_REG_DATA      = 0x0000040aU,
    SIPAEV_TXT_CPU_SCRTM_STAT       = 0x0000040bU,
    SIPAEV_TXT_LCP_CONTROL_HASH     = 0x0000040cU,
    SIPAEV_TXT_ELEMENTS_HASH        = 0x0000040dU,
    SIPAEV_TXT_STM_HASH             = 0x0000040eU,
    SIPAEV_TXT_OSSINITDATA_CAP_HASH = 0x0000040fU,
}

enum uint SIPAEV_TXT_SINIT_PUBKEY_HASH = 0x00000410U;

enum : uint
{
    SIPAEV_TXT_LCP_HASH             = 0x00000411U,
    SIPAEV_TXT_LCP_DETAILS_HASH     = 0x00000412U,
    SIPAEV_TXT_LCP_AUTHORITIES_HASH = 0x00000413U,
}

enum : uint
{
    SIPAEV_TXT_NV_INFO_HASH        = 0x00000414U,
    SIPAEV_TXT_COLD_BOOT_BIOS_HASH = 0x00000415U,
}

enum : uint
{
    SIPAEV_TXT_KM_HASH       = 0x00000416U,
    SIPAEV_TXT_BPM_HASH      = 0x00000417U,
    SIPAEV_TXT_KM_INFO_HASH  = 0x00000418U,
    SIPAEV_TXT_BPM_INFO_HASH = 0x00000419U,
    SIPAEV_TXT_BOOT_POL_HASH = 0x0000041aU,
    SIPAEV_TXT_RANDOM_VALUE  = 0x000004feU,
    SIPAEV_TXT_CAP_VALUE     = 0x000004ffU,
}

enum : uint
{
    SIPAEV_AMD_SL_EVENT_BASE       = 0x00008000U,
    SIPAEV_AMD_SL_LOAD             = 0x00008001U,
    SIPAEV_AMD_SL_PSP_FW_SPLT      = 0x00008002U,
    SIPAEV_AMD_SL_TSME_RB_FUSE     = 0x00008003U,
    SIPAEV_AMD_SL_PUB_KEY          = 0x00008004U,
    SIPAEV_AMD_SL_SVN              = 0x00008005U,
    SIPAEV_AMD_SL_LOAD_1           = 0x00008006U,
    SIPAEV_AMD_SL_SEPARATOR        = 0x00008007U,
    SIPAEV_AMD_NO_ACTION           = 0x00000003U,
    SIPAEV_AMD_BASE_2              = 0x00008200U,
    SIPAEV_AMD_SPL_TABLE_ROM       = 0x00008201U,
    SIPAEV_AMD_PSP_BL_STAGE_1      = 0x00008202U,
    SIPAEV_AMD_PSP_KEYDB           = 0x00008203U,
    SIPAEV_AMD_SPL_TABLE_FW        = 0x00008204U,
    SIPAEV_AMD_PSP_BL_STAGE_2      = 0x00008205U,
    SIPAEV_AMD_PSP_L0_SEC_POL      = 0x00008206U,
    SIPAEV_AMD_PMFW0               = 0x00008207U,
    SIPAEV_AMD_MP2_CONFIG          = 0x00008208U,
    SIPAEV_AMD_MP2_FW              = 0x00008209U,
    SIPAEV_AMD_ABL_1               = 0x0000820aU,
    SIPAEV_AMD_ABL_2               = 0x0000820bU,
    SIPAEV_AMD_ABL_3               = 0x0000820cU,
    SIPAEV_AMD_ABL_4               = 0x0000820dU,
    SIPAEV_AMD_ABL_5               = 0x0000820eU,
    SIPAEV_AMD_ABL_6               = 0x0000820fU,
    SIPAEV_AMD_ABL_7               = 0x00008210U,
    SIPAEV_AMD_ABL_8               = 0x00008211U,
    SIPAEV_AMD_ABL_9               = 0x00008212U,
    SIPAEV_AMD_ABL_10              = 0x00008213U,
    SIPAEV_AMD_ABL_11              = 0x00008214U,
    SIPAEV_AMD_ABL_12              = 0x00008215U,
    SIPAEV_AMD_ABL_13              = 0x00008216U,
    SIPAEV_AMD_ABL_14              = 0x00008217U,
    SIPAEV_AMD_ABL_15              = 0x00008218U,
    SIPAEV_AMD_ABL_16              = 0x00008219U,
    SIPAEV_AMD_ABL_17              = 0x0000821aU,
    SIPAEV_AMD_ABL_18              = 0x0000821bU,
    SIPAEV_AMD_ABL_19              = 0x0000821cU,
    SIPAEV_AMD_ABL_20              = 0x0000821dU,
    SIPAEV_AMD_ABL_21              = 0x0000821eU,
    SIPAEV_AMD_ABL_22              = 0x0000821fU,
    SIPAEV_AMD_ABL_23              = 0x00008220U,
    SIPAEV_AMD_ABL_24              = 0x00008221U,
    SIPAEV_AMD_ABL_25              = 0x00008222U,
    SIPAEV_AMD_ABL_26              = 0x00008223U,
    SIPAEV_AMD_ABL_27              = 0x00008224U,
    SIPAEV_AMD_ABL_28              = 0x00008225U,
    SIPAEV_AMD_ABL_29              = 0x00008226U,
    SIPAEV_AMD_ABL_30              = 0x00008227U,
    SIPAEV_AMD_ABL_31              = 0x00008228U,
    SIPAEV_AMD_ABL_32              = 0x00008229U,
    SIPAEV_AMD_ABL_33              = 0x0000822aU,
    SIPAEV_AMD_ABL_34              = 0x0000822bU,
    SIPAEV_AMD_ABL_35              = 0x0000822cU,
    SIPAEV_AMD_ABL_36              = 0x0000822dU,
    SIPAEV_AMD_ABL_37              = 0x0000822eU,
    SIPAEV_AMD_ABL_38              = 0x0000822fU,
    SIPAEV_AMD_ABL_39              = 0x00008230U,
    SIPAEV_AMD_ABL_40              = 0x00008231U,
    SIPAEV_AMD_ABL_41              = 0x00008232U,
    SIPAEV_AMD_ABL_42              = 0x00008233U,
    SIPAEV_AMD_ABL_43              = 0x00008234U,
    SIPAEV_AMD_ABL_44              = 0x00008235U,
    SIPAEV_AMD_ABL_45              = 0x00008236U,
    SIPAEV_AMD_ABL_46              = 0x00008237U,
    SIPAEV_AMD_ABL_47              = 0x00008238U,
    SIPAEV_AMD_ABL_48              = 0x00008239U,
    SIPAEV_AMD_MID_SMU             = 0x0000823aU,
    SIPAEV_AMD_PM_FW1              = 0x0000823bU,
    SIPAEV_AMD_VBL_1               = 0x0000823cU,
    SIPAEV_AMD_VBL_2               = 0x0000823dU,
    SIPAEV_AMD_VBL_3               = 0x0000823eU,
    SIPAEV_AMD_VBL_4               = 0x0000823fU,
    SIPAEV_AMD_VBL_5               = 0x00008240U,
    SIPAEV_AMD_VBL_6               = 0x00008241U,
    SIPAEV_AMD_VBL_7               = 0x00008242U,
    SIPAEV_AMD_VBL_8               = 0x00008243U,
    SIPAEV_AMD_VBL_9               = 0x00008244U,
    SIPAEV_AMD_VBL_10              = 0x00008245U,
    SIPAEV_AMD_PSP_L1_SEC_POL      = 0x00008246U,
    SIPAEV_AMD_IP_DISCOVERY        = 0x00008247U,
    SIPAEV_AMD_SYS_DRV             = 0x00008248U,
    SIPAEV_AMD_TOS                 = 0x00008249U,
    SIPAEV_AMD_PSP_TOS_KEYDB       = 0x0000824aU,
    SIPAEV_AMD_ABL_TOC             = 0x0000824bU,
    SIPAEV_AMD_PMU1_DATA           = 0x0000824cU,
    SIPAEV_AMD_PMU2_DATA           = 0x0000824dU,
    SIPAEV_AMD_PMU1                = 0x0000824eU,
    SIPAEV_AMD_PMU2                = 0x0000824fU,
    SIPAEV_AMD_MPIO_FW             = 0x00008250U,
    SIPAEV_AMD_MP5                 = 0x00008251U,
    SIPAEV_AMD_MPCCX               = 0x00008252U,
    SIPAEV_AMD_GMI3                = 0x00008253U,
    SIPAEV_AMD_TPMLITE             = 0x00008254U,
    SIPAEV_AMD_PSP_SPIROM_CONFIG   = 0x00008255U,
    SIPAEV_AMD_PSP_DF_RIB_TOC      = 0x00008256U,
    SIPAEV_AMD_PSP_DF_RIB0         = 0x00008257U,
    SIPAEV_AMD_PSP_DF_RIB1         = 0x00008258U,
    SIPAEV_AMD_PSP_DF_RIB2         = 0x00008259U,
    SIPAEV_AMD_PSP_DF_RIB3         = 0x0000825aU,
    SIPAEV_AMD_PSP_DF_RIB4         = 0x0000825bU,
    SIPAEV_AMD_PSP_DF_RIB5         = 0x0000825cU,
    SIPAEV_AMD_PSP_DF_RIB6         = 0x0000825dU,
    SIPAEV_AMD_PSP_DF_RIB7         = 0x0000825eU,
    SIPAEV_AMD_PSP_DF_RIB8         = 0x0000825fU,
    SIPAEV_AMD_PSP_DF_RIB9         = 0x00008260U,
    SIPAEV_AMD_PSP_DF_RIB10        = 0x00008261U,
    SIPAEV_AMD_PSP_DF_RIB11        = 0x00008262U,
    SIPAEV_AMD_PSP_DF_RIB12        = 0x00008263U,
    SIPAEV_AMD_PSP_DF_RIB13        = 0x00008264U,
    SIPAEV_AMD_PSP_DF_RIB14        = 0x00008265U,
    SIPAEV_AMD_PSP_DF_RIB15        = 0x00008266U,
    SIPAEV_AMD_SECURE_DEBUG_UNLOCK = 0x00008267U,
}

enum : uint
{
    SIPAEV_AMD_PSP_BL_END         = 0x000082ffU,
    SIPAEV_AMD_FTPM_DRV           = 0x00008300U,
    SIPAEV_AMD_DRTM_DRV           = 0x00008301U,
    SIPAEV_AMD_AGESA_DRV          = 0x00008302U,
    SIPAEV_AMD_PSP_END            = 0x000083ffU,
    SIPAEV_ARM_BASE               = 0x00009000U,
    SIPAEV_ARM_PCR_SCHEMA         = 0x00009001U,
    SIPAEV_ARM_DCE                = 0x00009002U,
    SIPAEV_ARM_DCE_PUBKEY         = 0x00009003U,
    SIPAEV_ARM_DLME               = 0x00009004U,
    SIPAEV_ARM_DLME_ENTRY_POINT   = 0x00009005U,
    SIPAEV_ARM_DEBUG_CONFIG       = 0x00009006U,
    SIPAEV_ARM_NONSECURE_CONFIG   = 0x00009007U,
    SIPAEV_ARM_DCE_SECONDARY      = 0x00009008U,
    SIPAEV_ARM_TZFW               = 0x00009009U,
    SIPAEV_ARM_SEPARATOR          = 0x0000900aU,
    SIPAEV_ARM_DLME_PUBKEY        = 0x0000900bU,
    SIPAEV_ARM_DLME_SVN           = 0x0000900cU,
    SIPAEV_ARM_NO_ACTION          = 0x0000900dU,
    SIPAEV_ARM_SECURE_INT_DISABLE = 0x0000900eU,
}

enum : uint
{
    SIPAEVENTTYPE_NONMEASURED    = 0x80000000U,
    SIPAEVENTTYPE_AGGREGATION    = 0x40000000U,
    SIPAEVENTTYPE_CONTAINER      = 0x00010000U,
    SIPAEVENTTYPE_INFORMATION    = 0x00020000U,
    SIPAEVENTTYPE_ERROR          = 0x00030000U,
    SIPAEVENTTYPE_PREOSPARAMETER = 0x00040000U,
    SIPAEVENTTYPE_OSPARAMETER    = 0x00050000U,
    SIPAEVENTTYPE_AUTHORITY      = 0x00060000U,
    SIPAEVENTTYPE_LOADEDMODULE   = 0x00070000U,
    SIPAEVENTTYPE_TRUSTPOINT     = 0x00080000U,
    SIPAEVENTTYPE_ELAM           = 0x00090000U,
    SIPAEVENTTYPE_VBS            = 0x000a0000U,
    SIPAEVENTTYPE_KSR            = 0x000b0000U,
    SIPAEVENTTYPE_DRTM           = 0x000c0000U,
}

enum uint SIPAERROR_FIRMWAREFAILURE = 0x00030001U;
enum uint SIPAERROR_INTERNALFAILURE = 0x00030003U;
enum uint SIPAERROR_HYPERVISORFAILURE = 0x00030005U;

enum : uint
{
    SIPAEVENT_INFORMATION      = 0x00020001U,
    SIPAEVENT_BOOTCOUNTER      = 0x00020002U,
    SIPAEVENT_TRANSFER_CONTROL = 0x00020003U,
}

enum uint SIPAEVENT_APPLICATION_RETURN = 0x00020004U;
enum uint SIPAEVENT_BITLOCKER_UNLOCK = 0x00020005U;

enum : uint
{
    SIPAEVENT_EVENTCOUNTER          = 0x00020006U,
    SIPAEVENT_COUNTERID             = 0x00020007U,
    SIPAEVENT_MORBIT_NOT_CANCELABLE = 0x00020008U,
}

enum uint SIPAEVENT_APPLICATION_SVN = 0x00020009U;
enum uint SIPAEVENT_SVN_CHAIN_STATUS = 0x0002000aU;
enum uint SIPAEVENT_IDK_GENERATION_STATUS = 0x0002000cU;
enum uint SIPAEVENT_MORBIT_API_STATUS = 0x0002000bU;

enum : uint
{
    SIPAEVENT_BOOTDEBUGGING        = 0x00040001U,
    SIPAEVENT_BOOT_REVOCATION_LIST = 0x00040002U,
}

enum : uint
{
    SIPAEVENT_OSKERNELDEBUG           = 0x00050001U,
    SIPAEVENT_CODEINTEGRITY           = 0x00050002U,
    SIPAEVENT_TESTSIGNING             = 0x00050003U,
    SIPAEVENT_DATAEXECUTIONPREVENTION = 0x00050004U,
}

enum : uint
{
    SIPAEVENT_SAFEMODE                 = 0x00050005U,
    SIPAEVENT_WINPE                    = 0x00050006U,
    SIPAEVENT_PHYSICALADDRESSEXTENSION = 0x00050007U,
}

enum : uint
{
    SIPAEVENT_OSDEVICE                = 0x00050008U,
    SIPAEVENT_SYSTEMROOT              = 0x00050009U,
    SIPAEVENT_HYPERVISOR_LAUNCH_TYPE  = 0x0005000aU,
    SIPAEVENT_HYPERVISOR_PATH         = 0x0005000bU,
    SIPAEVENT_HYPERVISOR_IOMMU_POLICY = 0x0005000cU,
    SIPAEVENT_HYPERVISOR_DEBUG        = 0x0005000dU,
}

enum uint SIPAEVENT_DRIVER_LOAD_POLICY = 0x0005000eU;

enum : uint
{
    SIPAEVENT_SI_POLICY                    = 0x0005000fU,
    SIPAEVENT_HYPERVISOR_MMIO_NX_POLICY    = 0x00050010U,
    SIPAEVENT_HYPERVISOR_MSR_FILTER_POLICY = 0x00050011U,
}

enum uint SIPAEVENT_VSM_LAUNCH_TYPE = 0x00050012U;
enum uint SIPAEVENT_OS_REVOCATION_LIST = 0x00050013U;

enum : uint
{
    SIPAEVENT_SMT_STATUS                  = 0x00050014U,
    SIPAEVENT_VSM_IDK_INFO                = 0x00050020U,
    SIPAEVENT_FLIGHTSIGNING               = 0x00050021U,
    SIPAEVENT_PAGEFILE_ENCRYPTION_ENABLED = 0x00050022U,
}

enum : uint
{
    SIPAEVENT_VSM_IDKS_INFO        = 0x00050023U,
    SIPAEVENT_HIBERNATION_DISABLED = 0x00050024U,
}

enum : uint
{
    SIPAEVENT_DUMPS_DISABLED             = 0x00050025U,
    SIPAEVENT_DUMP_ENCRYPTION_ENABLED    = 0x00050026U,
    SIPAEVENT_DUMP_ENCRYPTION_KEY_DIGEST = 0x00050027U,
}

enum : uint
{
    SIPAEVENT_LSAISO_CONFIG                  = 0x00050028U,
    SIPAEVENT_SBCP_INFO                      = 0x00050029U,
    SIPAEVENT_HYPERVISOR_BOOT_DMA_PROTECTION = 0x00050030U,
}

enum : uint
{
    SIPAEVENT_SI_POLICY_SIGNER        = 0x00050031U,
    SIPAEVENT_SI_POLICY_UPDATE_SIGNER = 0x00050032U,
}

enum uint SIPAEVENT_REFS_VOLUME_CHECKPOINT_RECORD_CHECKSUM = 0x00050033U;

enum : uint
{
    SIPAEVENT_REFS_ROLLBACK_PROTECTION_FROZEN_VOLUME_CHECKSUM  = 0x00050034U,
    SIPAEVENT_REFS_ROLLBACK_PROTECTION_USER_PAYLOAD_HASH       = 0x00050035U,
    SIPAEVENT_REFS_ROLLBACK_PROTECTION_VERIFICATION_SUCCEEDED  = 0x00050036U,
    SIPAEVENT_REFS_ROLLBACK_PROTECTION_VOLUME_FIRST_EVER_MOUNT = 0x00050037U,
}

enum : uint
{
    SIPAEVENT_VSM_SEALED_SI_POLICY      = 0x0005003aU,
    SIPAEVENT_VSM_DRTM_KEYROLL_DETECTED = 0x0005003bU,
}

enum : uint
{
    SIPAEVENT_VSM_SRTM_UNSEAL_POLICY         = 0x0005003cU,
    SIPAEVENT_VSM_SRTM_ANTI_ROLLBACK_COUNTER = 0x0005003dU,
}

enum uint SIPAEVENT_VTL1_DUMP_CONFIG = 0x00050040U;

enum : uint
{
    SIPAEVENT_NOAUTHORITY     = 0x00060001U,
    SIPAEVENT_AUTHORITYPUBKEY = 0x00060002U,
}

enum : uint
{
    SIPAEVENT_FILEPATH        = 0x00070001U,
    SIPAEVENT_IMAGESIZE       = 0x00070002U,
    SIPAEVENT_HASHALGORITHMID = 0x00070003U,
}

enum : uint
{
    SIPAEVENT_AUTHENTICODEHASH = 0x00070004U,
    SIPAEVENT_AUTHORITYISSUER  = 0x00070005U,
    SIPAEVENT_AUTHORITYSERIAL  = 0x00070006U,
}

enum : uint
{
    SIPAEVENT_IMAGEBASE               = 0x00070007U,
    SIPAEVENT_AUTHORITYPUBLISHER      = 0x00070008U,
    SIPAEVENT_AUTHORITYSHA1THUMBPRINT = 0x00070009U,
}

enum : uint
{
    SIPAEVENT_IMAGEVALIDATED           = 0x0007000aU,
    SIPAEVENT_MODULE_SVN               = 0x0007000bU,
    SIPAEVENT_MODULE_PLUTON            = 0x0007000cU,
    SIPAEVENT_MODULE_ORIGINAL_FILENAME = 0x0007000dU,
    SIPAEVENT_MODULE_VERSION           = 0x0007000eU,
    SIPAEVENT_PUBLISHER_OEMNAME        = 0x0007000fU,
}

enum : uint
{
    SIPAEVENT_ELAM_KEYNAME               = 0x00090001U,
    SIPAEVENT_ELAM_CONFIGURATION         = 0x00090002U,
    SIPAEVENT_ELAM_POLICY                = 0x00090003U,
    SIPAEVENT_ELAM_MEASURED              = 0x00090004U,
    SIPAEVENT_VBS_VSM_REQUIRED           = 0x000a0001U,
    SIPAEVENT_VBS_SECUREBOOT_REQUIRED    = 0x000a0002U,
    SIPAEVENT_VBS_IOMMU_REQUIRED         = 0x000a0003U,
    SIPAEVENT_VBS_MMIO_NX_REQUIRED       = 0x000a0004U,
    SIPAEVENT_VBS_MSR_FILTERING_REQUIRED = 0x000a0005U,
    SIPAEVENT_VBS_MANDATORY_ENFORCEMENT  = 0x000a0006U,
}

enum : uint
{
    SIPAEVENT_VBS_HVCI_POLICY                   = 0x000a0007U,
    SIPAEVENT_VBS_MICROSOFT_BOOT_CHAIN_REQUIRED = 0x000a0008U,
}

enum : uint
{
    SIPAEVENT_VBS_DUMP_USES_AMEROOT      = 0x000a0009U,
    SIPAEVENT_VBS_VSM_NOSECRETS_ENFORCED = 0x000a000aU,
}

enum : uint
{
    SIPAEVENT_KSR_SIGNATURE           = 0x000b0001U,
    SIPAEVENT_DRTM_STATE_AUTH         = 0x000c0001U,
    SIPAEVENT_DRTM_SMM_LEVEL          = 0x000c0002U,
    SIPAEVENT_DRTM_AMD_SMM_HASH       = 0x000c0003U,
    SIPAEVENT_DRTM_AMD_SMM_SIGNER_KEY = 0x000c0004U,
}

enum : uint
{
    FVEB_UNLOCK_FLAG_NONE          = 0x00000000U,
    FVEB_UNLOCK_FLAG_CACHED        = 0x00000001U,
    FVEB_UNLOCK_FLAG_MEDIA         = 0x00000002U,
    FVEB_UNLOCK_FLAG_TPM           = 0x00000004U,
    FVEB_UNLOCK_FLAG_PIN           = 0x00000010U,
    FVEB_UNLOCK_FLAG_EXTERNAL      = 0x00000020U,
    FVEB_UNLOCK_FLAG_RECOVERY      = 0x00000040U,
    FVEB_UNLOCK_FLAG_PASSPHRASE    = 0x00000080U,
    FVEB_UNLOCK_FLAG_NBP           = 0x00000100U,
    FVEB_UNLOCK_FLAG_AUK_OSFVEINFO = 0x00000200U,
}

enum : uint
{
    OSDEVICE_TYPE_UNKNOWN                 = 0x00000000U,
    OSDEVICE_TYPE_BLOCKIO_HARDDISK        = 0x00010001U,
    OSDEVICE_TYPE_BLOCKIO_REMOVABLEDISK   = 0x00010002U,
    OSDEVICE_TYPE_BLOCKIO_CDROM           = 0x00010003U,
    OSDEVICE_TYPE_BLOCKIO_PARTITION       = 0x00010004U,
    OSDEVICE_TYPE_BLOCKIO_FILE            = 0x00010005U,
    OSDEVICE_TYPE_BLOCKIO_RAMDISK         = 0x00010006U,
    OSDEVICE_TYPE_BLOCKIO_VIRTUALHARDDISK = 0x00010007U,
}

enum : uint
{
    OSDEVICE_TYPE_SERIAL    = 0x00020000U,
    OSDEVICE_TYPE_UDP       = 0x00030000U,
    OSDEVICE_TYPE_VMBUS     = 0x00040000U,
    OSDEVICE_TYPE_COMPOSITE = 0x00050000U,
    OSDEVICE_TYPE_CIMFS     = 0x00060000U,
}

enum uint SIPAHDRSIGNATURE = 0x4c434257U;
enum uint SIPALOGVERSION = 0x00000001U;
enum uint SIPAKSRHDRSIGNATURE = 0x4d52534bU;

enum : uint
{
    WBCL_DIGEST_ALG_ID_SHA_1         = 0x00000004U,
    WBCL_DIGEST_ALG_ID_SHA_2_256     = 0x0000000bU,
    WBCL_DIGEST_ALG_ID_SHA_2_384     = 0x0000000cU,
    WBCL_DIGEST_ALG_ID_SHA_2_512     = 0x0000000dU,
    WBCL_DIGEST_ALG_ID_SM3_256       = 0x00000012U,
    WBCL_DIGEST_ALG_ID_SHA3_256      = 0x00000027U,
    WBCL_DIGEST_ALG_ID_SHA3_384      = 0x00000028U,
    WBCL_DIGEST_ALG_ID_SHA3_512      = 0x00000029U,
    WBCL_DIGEST_ALG_BITMAP_SHA_1     = 0x00000001U,
    WBCL_DIGEST_ALG_BITMAP_SHA_2_256 = 0x00000002U,
    WBCL_DIGEST_ALG_BITMAP_SHA_2_384 = 0x00000004U,
    WBCL_DIGEST_ALG_BITMAP_SHA_2_512 = 0x00000008U,
    WBCL_DIGEST_ALG_BITMAP_SM3_256   = 0x00000010U,
    WBCL_DIGEST_ALG_BITMAP_SHA3_256  = 0x00000020U,
    WBCL_DIGEST_ALG_BITMAP_SHA3_384  = 0x00000040U,
    WBCL_DIGEST_ALG_BITMAP_SHA3_512  = 0x00000080U,
}

enum uint MAX_PLUTON_UPGRADE_FILENAME_LENGTH = 0x00000040U;
enum uint WBCL_MAX_PLUTON_UPGRADE_HASH_LEN = 0x00000040U;
enum uint WBCL_HASH_LEN_SHA1 = 0x00000014U;

// Callbacks

alias TCI_NOTIFY_HANDLER = void function(HANDLE ClRegCtx, HANDLE ClIfcCtx, uint Event, HANDLE SubCode, 
                                         uint BufSize, 
                                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* Buffer);
alias TCI_ADD_FLOW_COMPLETE_HANDLER = void function(HANDLE ClFlowCtx, uint Status);
alias TCI_MOD_FLOW_COMPLETE_HANDLER = void function(HANDLE ClFlowCtx, uint Status);
alias TCI_DEL_FLOW_COMPLETE_HANDLER = void function(HANDLE ClFlowCtx, uint Status);

// Structs


//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct RHANDLE
{
    void* Value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qos/ns-qos-qos_object_hdr
struct QOS_OBJECT_HDR
{
    uint ObjectType;
    uint ObjectLength;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qos/ns-qos-qos_sd_mode
struct QOS_SD_MODE
{
    QOS_OBJECT_HDR ObjectHdr;
    uint           ShapeDiscardMode;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qos/ns-qos-qos_shaping_rate
struct QOS_SHAPING_RATE
{
    QOS_OBJECT_HDR ObjectHdr;
    uint           ShapingRate;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qos2/ns-qos2-qos_packet_priority
struct QOS_PACKET_PRIORITY
{
    uint ConformantDSCPValue;
    uint NonConformantDSCPValue;
    uint ConformantL2Value;
    uint NonConformantL2Value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qos2/ns-qos2-qos_flow_fundamentals
struct QOS_FLOW_FUNDAMENTALS
{
    BOOL  BottleneckBandwidthSet;
    ulong BottleneckBandwidth;
    BOOL  AvailableBandwidthSet;
    ulong AvailableBandwidth;
    BOOL  RTTSet;
    uint  RTT;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qos2/ns-qos2-qos_flowrate_outgoing
struct QOS_FLOWRATE_OUTGOING
{
    ulong               Bandwidth;
    QOS_SHAPING         ShapingBehavior;
    QOS_FLOWRATE_REASON Reason;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qos2/ns-qos2-qos_version
struct QOS_VERSION
{
    ushort MajorVersion;
    ushort MinorVersion;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qosobjs/ns-qosobjs-qos_friendly_name
struct QOS_FRIENDLY_NAME
{
    QOS_OBJECT_HDR ObjectHdr;
    wchar[256]     FriendlyName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qosobjs/ns-qosobjs-qos_traffic_class
struct QOS_TRAFFIC_CLASS
{
    QOS_OBJECT_HDR ObjectHdr;
    uint           TrafficClass;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qosobjs/ns-qosobjs-qos_ds_class
struct QOS_DS_CLASS
{
    QOS_OBJECT_HDR ObjectHdr;
    uint           DSField;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qosobjs/ns-qosobjs-qos_diffserv
struct QOS_DIFFSERV
{
    QOS_OBJECT_HDR ObjectHdr;
    uint           DSFieldCount;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] DiffservRule;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qosobjs/ns-qosobjs-qos_diffserv_rule
struct QOS_DIFFSERV_RULE
{
    ubyte InboundDSField;
    ubyte ConformingOutboundDSField;
    ubyte NonConformingOutboundDSField;
    ubyte ConformingUserPriority;
    ubyte NonConformingUserPriority;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qosobjs/ns-qosobjs-qos_tcp_traffic
struct QOS_TCP_TRAFFIC
{
    QOS_OBJECT_HDR ObjectHdr;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/traffic/ns-traffic-tci_client_func_list
struct TCI_CLIENT_FUNC_LIST
{
    TCI_NOTIFY_HANDLER ClNotifyHandler;
    TCI_ADD_FLOW_COMPLETE_HANDLER ClAddFlowCompleteHandler;
    TCI_MOD_FLOW_COMPLETE_HANDLER ClModifyFlowCompleteHandler;
    TCI_DEL_FLOW_COMPLETE_HANDLER ClDeleteFlowCompleteHandler;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/traffic/ns-traffic-address_list_descriptor
struct ADDRESS_LIST_DESCRIPTOR
{
    uint                 MediaType;
    NETWORK_ADDRESS_LIST AddressList;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/traffic/ns-traffic-tc_ifc_descriptor
struct TC_IFC_DESCRIPTOR
{
    uint  Length;
    PWSTR pInterfaceName;
    PWSTR pInterfaceID;
    ADDRESS_LIST_DESCRIPTOR AddressListDesc;
}

struct TC_SUPPORTED_INFO_BUFFER
{
    ushort     InstanceIDLength;
    wchar[256] InstanceID;
    ulong      InterfaceLuid;
    ADDRESS_LIST_DESCRIPTOR AddrListDesc;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/traffic/ns-traffic-tc_gen_filter
struct TC_GEN_FILTER
{
    ushort AddressType;
    uint   PatternSize;
    void*  Pattern;
    void*  Mask;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/traffic/ns-traffic-tc_gen_flow
struct TC_GEN_FLOW
{
    FLOWSPEC SendingFlowspec;
    FLOWSPEC ReceivingFlowspec;
    uint     TcObjectsLength;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/QOS_OBJECT_HDR[1] TcObjects;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/traffic/ns-traffic-ip_pattern
struct IP_PATTERN
{
    uint     Reserved1;
    uint     Reserved2;
    uint     SrcAddr;
    uint     DstAddr;
    union S_un
    {
        struct S_un_ports
        {
            ushort s_srcport;
            ushort s_dstport;
        }
        struct S_un_icmp
        {
            ubyte  s_type;
            ubyte  s_code;
            ushort filler;
        }
        uint S_Spi;
    }
    ubyte    ProtocolId;
    ubyte[3] Reserved3;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/traffic/ns-traffic-ipx_pattern
struct IPX_PATTERN
{
    struct Src
    {
        uint     NetworkAddress;
        ubyte[6] NodeAddress;
        ushort   Socket;
    }
    struct Dest
    {
        uint     NetworkAddress;
        ubyte[6] NodeAddress;
        ushort   Socket;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/traffic/ns-traffic-enumeration_buffer
struct ENUMERATION_BUFFER
{
    uint         Length;
    uint         OwnerProcessId;
    ushort       FlowNameLength;
    wchar[256]   FlowName;
    TC_GEN_FLOW* pFlow;
    uint         NumberOfFilters;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/TC_GEN_FILTER[1] GenericFilter;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qossp/ns-qossp-in_addr_ipv4
union IN_ADDR_IPV4
{
    uint     Addr;
    ubyte[4] AddrBytes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qossp/ns-qossp-in_addr_ipv6
struct IN_ADDR_IPV6
{
    ubyte[16] Addr;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qossp/ns-qossp-rsvp_filterspec_v4
struct RSVP_FILTERSPEC_V4
{
    IN_ADDR_IPV4 Address;
    ushort       Unused;
    ushort       Port;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qossp/ns-qossp-rsvp_filterspec_v6
struct RSVP_FILTERSPEC_V6
{
    IN_ADDR_IPV6 Address;
    ushort       UnUsed;
    ushort       Port;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qossp/ns-qossp-rsvp_filterspec_v6_flow
struct RSVP_FILTERSPEC_V6_FLOW
{
    IN_ADDR_IPV6 Address;
    ubyte        UnUsed;
    ubyte[3]     FlowLabel;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qossp/ns-qossp-rsvp_filterspec_v4_gpi
struct RSVP_FILTERSPEC_V4_GPI
{
    IN_ADDR_IPV4 Address;
    uint         GeneralPortId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qossp/ns-qossp-rsvp_filterspec_v6_gpi
struct RSVP_FILTERSPEC_V6_GPI
{
    IN_ADDR_IPV6 Address;
    uint         GeneralPortId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qossp/ns-qossp-rsvp_filterspec
struct RSVP_FILTERSPEC
{
    FilterType Type;
    union
    {
        RSVP_FILTERSPEC_V4 FilterSpecV4;
        RSVP_FILTERSPEC_V6 FilterSpecV6;
        RSVP_FILTERSPEC_V6_FLOW FilterSpecV6Flow;
        RSVP_FILTERSPEC_V4_GPI FilterSpecV4Gpi;
        RSVP_FILTERSPEC_V6_GPI FilterSpecV6Gpi;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qossp/ns-qossp-flowdescriptor
struct FLOWDESCRIPTOR
{
    FLOWSPEC         FlowSpec;
    uint             NumFilters;
    RSVP_FILTERSPEC* FilterList;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qossp/ns-qossp-rsvp_policy
struct RSVP_POLICY
{
    ushort   Len;
    ushort   Type;
    ubyte[4] Info;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qossp/ns-qossp-rsvp_policy_info
struct RSVP_POLICY_INFO
{
    QOS_OBJECT_HDR ObjectHdr;
    uint           NumPolicyElement;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/RSVP_POLICY[1] PolicyElement;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qossp/ns-qossp-rsvp_reserve_info
struct RSVP_RESERVE_INFO
{
    QOS_OBJECT_HDR    ObjectHdr;
    uint              Style;
    uint              ConfirmRequest;
    RSVP_POLICY_INFO* PolicyElementList;
    uint              NumFlowDesc;
    FLOWDESCRIPTOR*   FlowDescList;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qossp/ns-qossp-rsvp_status_info
struct RSVP_STATUS_INFO
{
    QOS_OBJECT_HDR ObjectHdr;
    uint           StatusCode;
    uint           ExtendedStatus1;
    uint           ExtendedStatus2;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qossp/ns-qossp-qos_destaddr
struct QOS_DESTADDR
{
    QOS_OBJECT_HDR   ObjectHdr;
    const(SOCKADDR)* SocketAddress;
    uint             SocketAddressLength;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qossp/ns-qossp-ad_general_params
struct AD_GENERAL_PARAMS
{
    uint IntServAwareHopCount;
    uint PathBandwidthEstimate;
    uint MinimumLatency;
    uint PathMTU;
    uint Flags;
}

struct AD_GUARANTEED
{
    uint CTotal;
    uint DTotal;
    uint CSum;
    uint DSum;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qossp/ns-qossp-param_buffer
struct PARAM_BUFFER
{
    uint ParameterId;
    uint Length;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] Buffer;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qossp/ns-qossp-control_service
struct CONTROL_SERVICE
{
    uint              Length;
    uint              Service;
    AD_GENERAL_PARAMS Overrides;
    union
    {
        AD_GUARANTEED Guaranteed;
        /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/PARAM_BUFFER[1] ParamBuffer;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qossp/ns-qossp-rsvp_adspec
struct RSVP_ADSPEC
{
    QOS_OBJECT_HDR    ObjectHdr;
    AD_GENERAL_PARAMS GeneralParams;
    uint              NumberOfServices;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/CONTROL_SERVICE[1] Services;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qospol/ns-qospol-idpe_attr
struct IDPE_ATTR
{
    ushort   PeAttribLength;
    ubyte    PeAttribType;
    ubyte    PeAttribSubType;
    ubyte[4] PeAttribValue;
}

struct SIPAEVENT_REFS_ROLLBACK_PROTECTION_USER_PAYLOAD_HASH_DATA
{
    ushort ChecksumType;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] ChecksumBuffer;
}

struct WBCL_Iterator
{
align (1):
    void*  firstElementPtr;
    uint   logSize;
    void*  currentElementPtr;
    uint   currentElementSize;
    ushort digestSize;
    ushort logFormat;
    uint   numberOfDigests;
    void*  digestSizes;
    uint   supportedAlgorithms;
    ushort hashAlgorithm;
}

struct PLUTON_UPGRADE_IMAGEDATA
{
align (1):
    ushort    hashAlgID;
    ushort    digestSize;
    ubyte[64] digest;
    wchar[64] fileName;
}

struct TCG_PCClientPCREventStruct
{
align (1):
    uint      pcrIndex;
    uint      eventType;
    ubyte[20] digest;
    uint      eventDataSize;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] event;
}

struct TCG_PCClientTaggedEventStruct
{
align (1):
    uint EventID;
    uint EventDataSize;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] EventData;
}

struct WBCL_LogHdr
{
align (1):
    uint signature;
    uint version_;
    uint entries;
    uint length;
}

struct SIPAEVENT_VSM_IDK_RSA_INFO
{
align (1):
    uint KeyBitLength;
    uint PublicExpLengthBytes;
    uint ModulusSizeBytes;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] PublicKeyData;
}

struct SIPAEVENT_VSM_IDK_INFO_PAYLOAD
{
align (1):
    uint KeyAlgID;
    union
    {
        SIPAEVENT_VSM_IDK_RSA_INFO RsaKeyInfo;
    }
}

struct SIPAEVENT_SI_POLICY_PAYLOAD
{
align (1):
    ulong  PolicyVersion;
    ushort PolicyNameLength;
    ushort HashAlgID;
    uint   DigestLength;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] VarLengthData;
}

struct SIPAEVENT_SI_POLICY_CERTIFICATE_PAYLOAD
{
align (1):
    ushort PublisherCommonNameLength;
    ushort IssuerCommonNameLength;
    uint   HashAlgID;
    ushort DigestLength;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] VarLengthData;
}

struct SIPAEVENT_SI_POLICY_SIGNER_PAYLOAD
{
align (1):
    uint   RootID;
    uint   CertificatesLength;
    ushort CertificatesCount;
    ushort PolicyNameLength;
    ushort EKUsLength;
    ushort EKUsCount;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] VarLengthData;
}

struct SIPAEVENT_REVOCATION_LIST_PAYLOAD
{
align (1):
    long   CreationTime;
    uint   DigestLength;
    ushort HashAlgID;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] Digest;
}

struct SIPAEVENT_KSR_SIGNATURE_PAYLOAD
{
align (1):
    uint SignAlgID;
    uint SignatureLength;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] Signature;
}

struct SIPAEVENT_SBCP_INFO_PAYLOAD_V1
{
align (1):
    uint   PayloadVersion;
    uint   VarDataOffset;
    ushort HashAlgID;
    ushort DigestLength;
    uint   Options;
    uint   SignersCount;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] VarData;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("qwave.dll")
BOOL QOSCreateHandle(QOS_VERSION* Version, HANDLE* QOSHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("qwave.dll")
BOOL QOSCloseHandle(HANDLE QOSHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("qwave.dll")
BOOL QOSStartTrackingClient(HANDLE QOSHandle, SOCKADDR* DestAddr, 
                            /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("qwave.dll")
BOOL QOSStopTrackingClient(HANDLE QOSHandle, SOCKADDR* DestAddr, 
                           /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("qwave.dll")
BOOL QOSEnumerateFlows(HANDLE QOSHandle, uint* Size, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* Buffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("qwave.dll")
BOOL QOSAddSocketToFlow(HANDLE QOSHandle, SOCKET Socket, SOCKADDR* DestAddr, QOS_TRAFFIC_TYPE TrafficType, 
                        uint Flags, uint* FlowId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("qwave.dll")
BOOL QOSRemoveSocketFromFlow(HANDLE QOSHandle, SOCKET Socket, uint FlowId, 
                             /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("qwave.dll")
BOOL QOSSetFlow(HANDLE QOSHandle, uint FlowId, QOS_SET_FLOW Operation, uint Size, 
                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Buffer, 
                /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint Flags, OVERLAPPED* Overlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("qwave.dll")
BOOL QOSQueryFlow(HANDLE QOSHandle, uint FlowId, QOS_QUERY_FLOW Operation, uint* Size, 
                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Buffer, 
                  uint Flags, OVERLAPPED* Overlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("qwave.dll")
BOOL QOSNotifyFlow(HANDLE QOSHandle, uint FlowId, QOS_NOTIFY_FLOW Operation, uint* Size, 
                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Buffer, 
                   /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint Flags, OVERLAPPED* Overlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("qwave.dll")
BOOL QOSCancel(HANDLE QOSHandle, OVERLAPPED* Overlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("TRAFFIC.dll")
uint TcRegisterClient(uint TciVersion, HANDLE ClRegCtx, TCI_CLIENT_FUNC_LIST* ClientHandlerList, 
                      HANDLE* pClientHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("TRAFFIC.dll")
uint TcEnumerateInterfaces(HANDLE ClientHandle, uint* pBufferSize, TC_IFC_DESCRIPTOR* InterfaceBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("TRAFFIC.dll")
uint TcOpenInterfaceA(PSTR pInterfaceName, HANDLE ClientHandle, HANDLE ClIfcCtx, HANDLE* pIfcHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("TRAFFIC.dll")
uint TcOpenInterfaceW(PWSTR pInterfaceName, HANDLE ClientHandle, HANDLE ClIfcCtx, HANDLE* pIfcHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("TRAFFIC.dll")
uint TcCloseInterface(HANDLE IfcHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("TRAFFIC.dll")
uint TcQueryInterface(HANDLE IfcHandle, GUID* pGuidParam, BOOLEAN NotifyChange, uint* pBufferSize, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Buffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("TRAFFIC.dll")
uint TcSetInterface(HANDLE IfcHandle, GUID* pGuidParam, uint BufferSize, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* Buffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("TRAFFIC.dll")
uint TcQueryFlowA(PSTR pFlowName, GUID* pGuidParam, uint* pBufferSize, 
                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* Buffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("TRAFFIC.dll")
uint TcQueryFlowW(PWSTR pFlowName, GUID* pGuidParam, uint* pBufferSize, 
                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* Buffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("TRAFFIC.dll")
uint TcSetFlowA(PSTR pFlowName, GUID* pGuidParam, uint BufferSize, 
                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* Buffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("TRAFFIC.dll")
uint TcSetFlowW(PWSTR pFlowName, GUID* pGuidParam, uint BufferSize, 
                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* Buffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("TRAFFIC.dll")
uint TcAddFlow(HANDLE IfcHandle, HANDLE ClFlowCtx, uint Flags, TC_GEN_FLOW* pGenericFlow, HANDLE* pFlowHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("TRAFFIC.dll")
uint TcGetFlowNameA(HANDLE FlowHandle, uint StrSize, PSTR pFlowName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("TRAFFIC.dll")
uint TcGetFlowNameW(HANDLE FlowHandle, uint StrSize, PWSTR pFlowName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("TRAFFIC.dll")
uint TcModifyFlow(HANDLE FlowHandle, TC_GEN_FLOW* pGenericFlow);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("TRAFFIC.dll")
uint TcAddFilter(HANDLE FlowHandle, TC_GEN_FILTER* pGenericFilter, HANDLE* pFilterHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("TRAFFIC.dll")
uint TcDeregisterClient(HANDLE ClientHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("TRAFFIC.dll")
uint TcDeleteFlow(HANDLE FlowHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("TRAFFIC.dll")
uint TcDeleteFilter(HANDLE FilterHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("TRAFFIC.dll")
uint TcEnumerateFlows(HANDLE IfcHandle, HANDLE* pEnumHandle, uint* pFlowCount, uint* pBufSize, 
                      ENUMERATION_BUFFER* Buffer);


