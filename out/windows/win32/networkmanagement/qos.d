// Written in the D programming language.

module windows.win32.networkmanagement.qos;

public import windows.core;
public import system : Guid;
public import windows.win32.foundation : BOOL, BOOLEAN, HANDLE, PSTR, PWSTR;
public import windows.win32.networkmanagement.ndis : NETWORK_ADDRESS_LIST;
public import windows.win32.networking.winsock : FLOWSPEC, SOCKADDR, SOCKET;
public import windows.win32.system.io : OVERLAPPED;

extern(Windows) @nogc nothrow:


// Enums

//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qos2/ne-qos2-qos_traffic_type))], [])
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
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qos2/ne-qos2-qos_set_flow))], [])
alias QOS_SET_FLOW = int;
enum : int
{
    QOSSetTrafficType       = 0x00000000,
    QOSSetOutgoingRate      = 0x00000001,
    QOSSetOutgoingDSCPValue = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qos2/ne-qos2-qos_flowrate_reason))], [])
alias QOS_FLOWRATE_REASON = int;
enum : int
{
    QOSFlowRateNotApplicable         = 0x00000000,
    QOSFlowRateContentChange         = 0x00000001,
    QOSFlowRateCongestion            = 0x00000002,
    QOSFlowRateHigherContentEncoding = 0x00000003,
    QOSFlowRateUserCaused            = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qos2/ne-qos2-qos_shaping))], [])
alias QOS_SHAPING = int;
enum : int
{
    QOSShapeOnly                = 0x00000000,
    QOSShapeAndMark             = 0x00000001,
    QOSUseNonConformantMarkings = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qos2/ne-qos2-qos_query_flow))], [])
alias QOS_QUERY_FLOW = int;
enum : int
{
    QOSQueryFlowFundamentals = 0x00000000,
    QOSQueryPacketPriority   = 0x00000001,
    QOSQueryOutgoingRate     = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qos2/ne-qos2-qos_notify_flow))], [])
alias QOS_NOTIFY_FLOW = int;
enum : int
{
    QOSNotifyCongested   = 0x00000000,
    QOSNotifyUncongested = 0x00000001,
    QOSNotifyAvailable   = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qossp/ne-qossp-filtertype))], [])
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


enum uint QOS_MAX_OBJECT_STRING_LENGTH = 0x00000100;
enum uint QOS_TRAFFIC_GENERAL_ID_BASE = 0x00000fa0;

enum : uint
{
    SERVICETYPE_NOTRAFFIC           = 0x00000000,
    SERVICETYPE_BESTEFFORT          = 0x00000001,
    SERVICETYPE_CONTROLLEDLOAD      = 0x00000002,
    SERVICETYPE_GUARANTEED          = 0x00000003,
    SERVICETYPE_NETWORK_UNAVAILABLE = 0x00000004,
}

enum uint SERVICETYPE_GENERAL_INFORMATION = 0x00000005;

enum : uint
{
    SERVICETYPE_NOCHANGE        = 0x00000006,
    SERVICETYPE_NONCONFORMING   = 0x00000009,
    SERVICETYPE_NETWORK_CONTROL = 0x0000000a,
    SERVICETYPE_QUALITATIVE     = 0x0000000d,
}

enum : uint
{
    SERVICE_BESTEFFORT     = 0x80010000,
    SERVICE_CONTROLLEDLOAD = 0x80020000,
}

enum : uint
{
    SERVICE_GUARANTEED         = 0x80040000,
    SERVICE_QUALITATIVE        = 0x80200000,
    SERVICE_NO_TRAFFIC_CONTROL = 0x81000000,
    SERVICE_NO_QOS_SIGNALING   = 0x40000000,
}

enum uint QOS_NOT_SPECIFIED = 0xffffffff;
enum uint POSITIVE_INFINITY_RATE = 0xfffffffe;
enum uint QOS_GENERAL_ID_BASE = 0x000007d0;

enum : uint
{
    TC_NONCONF_BORROW      = 0x00000000,
    TC_NONCONF_SHAPE       = 0x00000001,
    TC_NONCONF_DISCARD     = 0x00000002,
    TC_NONCONF_BORROW_PLUS = 0x00000003,
}

enum uint CURRENT_TCI_VERSION = 0x00000002;

enum : uint
{
    TC_NOTIFY_IFC_UP        = 0x00000001,
    TC_NOTIFY_IFC_CLOSE     = 0x00000002,
    TC_NOTIFY_IFC_CHANGE    = 0x00000003,
    TC_NOTIFY_PARAM_CHANGED = 0x00000004,
    TC_NOTIFY_FLOW_CLOSE    = 0x00000005,
}

enum uint MAX_STRING_LENGTH = 0x00000100;
enum uint QOS_OUTGOING_DEFAULT_MINIMUM_BANDWIDTH = 0xffffffff;
enum uint QOS_QUERYFLOW_FRESH = 0x00000001;
enum uint QOS_NON_ADAPTIVE_FLOW = 0x00000002;
enum uint RSVP_OBJECT_ID_BASE = 0x000003e8;
enum uint RSVP_DEFAULT_STYLE = 0x00000000;
enum uint RSVP_WILDCARD_STYLE = 0x00000001;
enum uint RSVP_FIXED_FILTER_STYLE = 0x00000002;
enum uint RSVP_SHARED_EXPLICIT_STYLE = 0x00000003;
enum uint AD_FLAG_BREAK_BIT = 0x00000001;

enum : uint
{
    mIOC_IN     = 0x80000000,
    mIOC_OUT    = 0x40000000,
    mIOC_VENDOR = 0x04000000,
}

enum uint mCOMPANY = 0x18000000;
enum uint ioctl_code = 0x00000001;
enum uint QOSSPBASE = 0x0000c350;
enum uint ALLOWED_TO_SEND_DATA = 0x0000c351;
enum uint ABLE_TO_RECV_RSVP = 0x0000c352;
enum uint LINE_RATE = 0x0000c353;
enum uint LOCAL_TRAFFIC_CONTROL = 0x0000c354;
enum uint LOCAL_QOSABILITY = 0x0000c355;
enum uint END_TO_END_QOSABILITY = 0x0000c356;
enum uint INFO_NOT_AVAILABLE = 0xffffffff;
enum uint ANY_DEST_ADDR = 0xffffffff;
enum uint MODERATELY_DELAY_SENSITIVE = 0xfffffffd;
enum uint HIGHLY_DELAY_SENSITIVE = 0xfffffffe;
enum uint QOSSP_ERR_BASE = 0x0000dac0;

enum : uint
{
    GQOS_NO_ERRORCODE  = 0x00000000,
    GQOS_NO_ERRORVALUE = 0x00000000,
}

enum : uint
{
    GQOS_ERRORCODE_UNKNOWN  = 0xffffffff,
    GQOS_ERRORVALUE_UNKNOWN = 0xffffffff,
}

enum : uint
{
    GQOS_NET_ADMISSION = 0x0000db24,
    GQOS_NET_POLICY    = 0x0000db88,
}

enum : uint
{
    GQOS_RSVP          = 0x0000dbec,
    GQOS_API           = 0x0000dc50,
    GQOS_KERNEL_TC_SYS = 0x0000dcb4,
}

enum uint GQOS_RSVP_SYS = 0x0000dd18;
enum uint GQOS_KERNEL_TC = 0x0000dd7c;
enum uint PE_TYPE_APPID = 0x00000003;
enum uint PE_ATTRIB_TYPE_POLICY_LOCATOR = 0x00000001;

enum : uint
{
    POLICY_LOCATOR_SUB_TYPE_ASCII_DN       = 0x00000001,
    POLICY_LOCATOR_SUB_TYPE_UNICODE_DN     = 0x00000002,
    POLICY_LOCATOR_SUB_TYPE_ASCII_DN_ENC   = 0x00000003,
    POLICY_LOCATOR_SUB_TYPE_UNICODE_DN_ENC = 0x00000004,
}

enum uint PE_ATTRIB_TYPE_CREDENTIAL = 0x00000002;

enum : uint
{
    CREDENTIAL_SUB_TYPE_ASCII_ID     = 0x00000001,
    CREDENTIAL_SUB_TYPE_UNICODE_ID   = 0x00000002,
    CREDENTIAL_SUB_TYPE_KERBEROS_TKT = 0x00000003,
    CREDENTIAL_SUB_TYPE_X509_V3_CERT = 0x00000004,
    CREDENTIAL_SUB_TYPE_PGP_CERT     = 0x00000005,
}

enum uint TCBASE = 0x00001d4c;
enum uint ERROR_INCOMPATIBLE_TCI_VERSION = 0x00001d4d;

enum : uint
{
    ERROR_INVALID_SERVICE_TYPE  = 0x00001d4e,
    ERROR_INVALID_TOKEN_RATE    = 0x00001d4f,
    ERROR_INVALID_PEAK_RATE     = 0x00001d50,
    ERROR_INVALID_SD_MODE       = 0x00001d51,
    ERROR_INVALID_QOS_PRIORITY  = 0x00001d52,
    ERROR_INVALID_TRAFFIC_CLASS = 0x00001d53,
    ERROR_INVALID_ADDRESS_TYPE  = 0x00001d54,
}

enum uint ERROR_DUPLICATE_FILTER = 0x00001d55;
enum uint ERROR_FILTER_CONFLICT = 0x00001d56;
enum uint ERROR_ADDRESS_TYPE_NOT_SUPPORTED = 0x00001d57;
enum uint ERROR_TC_SUPPORTED_OBJECTS_EXIST = 0x00001d58;
enum uint ERROR_INCOMPATABLE_QOS = 0x00001d59;

enum : uint
{
    ERROR_TC_NOT_SUPPORTED         = 0x00001d5a,
    ERROR_TC_OBJECT_LENGTH_INVALID = 0x00001d5b,
}

enum : uint
{
    ERROR_INVALID_FLOW_MODE     = 0x00001d5c,
    ERROR_INVALID_DIFFSERV_FLOW = 0x00001d5d,
}

enum uint ERROR_DS_MAPPING_EXISTS = 0x00001d5e;

enum : uint
{
    ERROR_INVALID_SHAPE_RATE = 0x00001d5f,
    ERROR_INVALID_DS_CLASS   = 0x00001d60,
}

enum uint ERROR_TOO_MANY_CLIENTS = 0x00001d61;
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

enum uint FSCTL_TCP_BASE = 0x00000012;
enum const(wchar)* DD_TCP_DEVICE_NAME = "\\Device\\Tcp";
enum uint IF_MIB_STATS_ID = 0x00000001;

enum : uint
{
    IP_MIB_STATS_ID           = 0x00000001,
    IP_MIB_ADDRTABLE_ENTRY_ID = 0x00000102,
}

enum uint IP_INTFC_INFO_ID = 0x00000103;
enum uint MAX_PHYSADDR_SIZE = 0x00000008;

enum : uint
{
    SIPAEV_PREBOOT_CERT    = 0x00000000,
    SIPAEV_POST_CODE       = 0x00000001,
    SIPAEV_UNUSED          = 0x00000002,
    SIPAEV_NO_ACTION       = 0x00000003,
    SIPAEV_SEPARATOR       = 0x00000004,
    SIPAEV_ACTION          = 0x00000005,
    SIPAEV_EVENT_TAG       = 0x00000006,
    SIPAEV_S_CRTM_CONTENTS = 0x00000007,
    SIPAEV_S_CRTM_VERSION  = 0x00000008,
}

enum uint SIPAEV_CPU_MICROCODE = 0x00000009;
enum uint SIPAEV_PLATFORM_CONFIG_FLAGS = 0x0000000a;
enum uint SIPAEV_TABLE_OF_DEVICES = 0x0000000b;
enum uint SIPAEV_COMPACT_HASH = 0x0000000c;

enum : uint
{
    SIPAEV_IPL                = 0x0000000d,
    SIPAEV_IPL_PARTITION_DATA = 0x0000000e,
}

enum : uint
{
    SIPAEV_NONHOST_CODE   = 0x0000000f,
    SIPAEV_NONHOST_CONFIG = 0x00000010,
    SIPAEV_NONHOST_INFO   = 0x00000011,
}

enum uint SIPAEV_OMIT_BOOT_DEVICE_EVENTS = 0x00000012;

enum : uint
{
    SIPAEV_EFI_EVENT_BASE                = 0x80000000,
    SIPAEV_EFI_VARIABLE_DRIVER_CONFIG    = 0x80000001,
    SIPAEV_EFI_VARIABLE_BOOT             = 0x80000002,
    SIPAEV_EFI_BOOT_SERVICES_APPLICATION = 0x80000003,
    SIPAEV_EFI_BOOT_SERVICES_DRIVER      = 0x80000004,
}

enum uint SIPAEV_EFI_RUNTIME_SERVICES_DRIVER = 0x80000005;

enum : uint
{
    SIPAEV_EFI_GPT_EVENT              = 0x80000006,
    SIPAEV_EFI_ACTION                 = 0x80000007,
    SIPAEV_EFI_PLATFORM_FIRMWARE_BLOB = 0x80000008,
}

enum : uint
{
    SIPAEV_EFI_HANDOFF_TABLES          = 0x80000009,
    SIPAEV_EFI_PLATFORM_FIRMWARE_BLOB2 = 0x8000000a,
}

enum : uint
{
    SIPAEV_EFI_HANDOFF_TABLES2    = 0x8000000b,
    SIPAEV_EFI_VARIABLE_BOOT2     = 0x8000000c,
    SIPAEV_EFI_HCRTM_EVENT        = 0x80000010,
    SIPAEV_EFI_VARIABLE_AUTHORITY = 0x800000e0,
}

enum : uint
{
    SIPAEV_EFI_SPDM_FIRMWARE_BLOB   = 0x800000e1,
    SIPAEV_EFI_SPDM_FIRMWARE_CONFIG = 0x800000e2,
}

enum : uint
{
    SIPAEV_TXT_EVENT_BASE           = 0x00000400,
    SIPAEV_TXT_PCR_MAPPING          = 0x00000401,
    SIPAEV_TXT_HASH_START           = 0x00000402,
    SIPAEV_TXT_COMBINED_HASH        = 0x00000403,
    SIPAEV_TXT_MLE_HASH             = 0x00000404,
    SIPAEV_TXT_BIOSAC_REG_DATA      = 0x0000040a,
    SIPAEV_TXT_CPU_SCRTM_STAT       = 0x0000040b,
    SIPAEV_TXT_LCP_CONTROL_HASH     = 0x0000040c,
    SIPAEV_TXT_ELEMENTS_HASH        = 0x0000040d,
    SIPAEV_TXT_STM_HASH             = 0x0000040e,
    SIPAEV_TXT_OSSINITDATA_CAP_HASH = 0x0000040f,
}

enum uint SIPAEV_TXT_SINIT_PUBKEY_HASH = 0x00000410;

enum : uint
{
    SIPAEV_TXT_LCP_HASH             = 0x00000411,
    SIPAEV_TXT_LCP_DETAILS_HASH     = 0x00000412,
    SIPAEV_TXT_LCP_AUTHORITIES_HASH = 0x00000413,
}

enum : uint
{
    SIPAEV_TXT_NV_INFO_HASH        = 0x00000414,
    SIPAEV_TXT_COLD_BOOT_BIOS_HASH = 0x00000415,
}

enum : uint
{
    SIPAEV_TXT_KM_HASH       = 0x00000416,
    SIPAEV_TXT_BPM_HASH      = 0x00000417,
    SIPAEV_TXT_KM_INFO_HASH  = 0x00000418,
    SIPAEV_TXT_BPM_INFO_HASH = 0x00000419,
    SIPAEV_TXT_BOOT_POL_HASH = 0x0000041a,
    SIPAEV_TXT_RANDOM_VALUE  = 0x000004fe,
    SIPAEV_TXT_CAP_VALUE     = 0x000004ff,
}

enum : uint
{
    SIPAEV_AMD_SL_EVENT_BASE       = 0x00008000,
    SIPAEV_AMD_SL_LOAD             = 0x00008001,
    SIPAEV_AMD_SL_PSP_FW_SPLT      = 0x00008002,
    SIPAEV_AMD_SL_TSME_RB_FUSE     = 0x00008003,
    SIPAEV_AMD_SL_PUB_KEY          = 0x00008004,
    SIPAEV_AMD_SL_SVN              = 0x00008005,
    SIPAEV_AMD_SL_LOAD_1           = 0x00008006,
    SIPAEV_AMD_SL_SEPARATOR        = 0x00008007,
    SIPAEV_AMD_NO_ACTION           = 0x00000003,
    SIPAEV_AMD_BASE_2              = 0x00008200,
    SIPAEV_AMD_SPL_TABLE_ROM       = 0x00008201,
    SIPAEV_AMD_PSP_BL_STAGE_1      = 0x00008202,
    SIPAEV_AMD_PSP_KEYDB           = 0x00008203,
    SIPAEV_AMD_SPL_TABLE_FW        = 0x00008204,
    SIPAEV_AMD_PSP_BL_STAGE_2      = 0x00008205,
    SIPAEV_AMD_PSP_L0_SEC_POL      = 0x00008206,
    SIPAEV_AMD_PMFW0               = 0x00008207,
    SIPAEV_AMD_MP2_CONFIG          = 0x00008208,
    SIPAEV_AMD_MP2_FW              = 0x00008209,
    SIPAEV_AMD_ABL_1               = 0x0000820a,
    SIPAEV_AMD_ABL_2               = 0x0000820b,
    SIPAEV_AMD_ABL_3               = 0x0000820c,
    SIPAEV_AMD_ABL_4               = 0x0000820d,
    SIPAEV_AMD_ABL_5               = 0x0000820e,
    SIPAEV_AMD_ABL_6               = 0x0000820f,
    SIPAEV_AMD_ABL_7               = 0x00008210,
    SIPAEV_AMD_ABL_8               = 0x00008211,
    SIPAEV_AMD_ABL_9               = 0x00008212,
    SIPAEV_AMD_ABL_10              = 0x00008213,
    SIPAEV_AMD_ABL_11              = 0x00008214,
    SIPAEV_AMD_ABL_12              = 0x00008215,
    SIPAEV_AMD_ABL_13              = 0x00008216,
    SIPAEV_AMD_ABL_14              = 0x00008217,
    SIPAEV_AMD_ABL_15              = 0x00008218,
    SIPAEV_AMD_ABL_16              = 0x00008219,
    SIPAEV_AMD_ABL_17              = 0x0000821a,
    SIPAEV_AMD_ABL_18              = 0x0000821b,
    SIPAEV_AMD_ABL_19              = 0x0000821c,
    SIPAEV_AMD_ABL_20              = 0x0000821d,
    SIPAEV_AMD_ABL_21              = 0x0000821e,
    SIPAEV_AMD_ABL_22              = 0x0000821f,
    SIPAEV_AMD_ABL_23              = 0x00008220,
    SIPAEV_AMD_ABL_24              = 0x00008221,
    SIPAEV_AMD_ABL_25              = 0x00008222,
    SIPAEV_AMD_ABL_26              = 0x00008223,
    SIPAEV_AMD_ABL_27              = 0x00008224,
    SIPAEV_AMD_ABL_28              = 0x00008225,
    SIPAEV_AMD_ABL_29              = 0x00008226,
    SIPAEV_AMD_ABL_30              = 0x00008227,
    SIPAEV_AMD_ABL_31              = 0x00008228,
    SIPAEV_AMD_ABL_32              = 0x00008229,
    SIPAEV_AMD_ABL_33              = 0x0000822a,
    SIPAEV_AMD_ABL_34              = 0x0000822b,
    SIPAEV_AMD_ABL_35              = 0x0000822c,
    SIPAEV_AMD_ABL_36              = 0x0000822d,
    SIPAEV_AMD_ABL_37              = 0x0000822e,
    SIPAEV_AMD_ABL_38              = 0x0000822f,
    SIPAEV_AMD_ABL_39              = 0x00008230,
    SIPAEV_AMD_ABL_40              = 0x00008231,
    SIPAEV_AMD_ABL_41              = 0x00008232,
    SIPAEV_AMD_ABL_42              = 0x00008233,
    SIPAEV_AMD_ABL_43              = 0x00008234,
    SIPAEV_AMD_ABL_44              = 0x00008235,
    SIPAEV_AMD_ABL_45              = 0x00008236,
    SIPAEV_AMD_ABL_46              = 0x00008237,
    SIPAEV_AMD_ABL_47              = 0x00008238,
    SIPAEV_AMD_ABL_48              = 0x00008239,
    SIPAEV_AMD_MID_SMU             = 0x0000823a,
    SIPAEV_AMD_PM_FW1              = 0x0000823b,
    SIPAEV_AMD_VBL_1               = 0x0000823c,
    SIPAEV_AMD_VBL_2               = 0x0000823d,
    SIPAEV_AMD_VBL_3               = 0x0000823e,
    SIPAEV_AMD_VBL_4               = 0x0000823f,
    SIPAEV_AMD_VBL_5               = 0x00008240,
    SIPAEV_AMD_VBL_6               = 0x00008241,
    SIPAEV_AMD_VBL_7               = 0x00008242,
    SIPAEV_AMD_VBL_8               = 0x00008243,
    SIPAEV_AMD_VBL_9               = 0x00008244,
    SIPAEV_AMD_VBL_10              = 0x00008245,
    SIPAEV_AMD_PSP_L1_SEC_POL      = 0x00008246,
    SIPAEV_AMD_IP_DISCOVERY        = 0x00008247,
    SIPAEV_AMD_SYS_DRV             = 0x00008248,
    SIPAEV_AMD_TOS                 = 0x00008249,
    SIPAEV_AMD_PSP_TOS_KEYDB       = 0x0000824a,
    SIPAEV_AMD_ABL_TOC             = 0x0000824b,
    SIPAEV_AMD_PMU1_DATA           = 0x0000824c,
    SIPAEV_AMD_PMU2_DATA           = 0x0000824d,
    SIPAEV_AMD_PMU1                = 0x0000824e,
    SIPAEV_AMD_PMU2                = 0x0000824f,
    SIPAEV_AMD_MPIO_FW             = 0x00008250,
    SIPAEV_AMD_MP5                 = 0x00008251,
    SIPAEV_AMD_MPCCX               = 0x00008252,
    SIPAEV_AMD_GMI3                = 0x00008253,
    SIPAEV_AMD_TPMLITE             = 0x00008254,
    SIPAEV_AMD_PSP_SPIROM_CONFIG   = 0x00008255,
    SIPAEV_AMD_PSP_DF_RIB_TOC      = 0x00008256,
    SIPAEV_AMD_PSP_DF_RIB0         = 0x00008257,
    SIPAEV_AMD_PSP_DF_RIB1         = 0x00008258,
    SIPAEV_AMD_PSP_DF_RIB2         = 0x00008259,
    SIPAEV_AMD_PSP_DF_RIB3         = 0x0000825a,
    SIPAEV_AMD_PSP_DF_RIB4         = 0x0000825b,
    SIPAEV_AMD_PSP_DF_RIB5         = 0x0000825c,
    SIPAEV_AMD_PSP_DF_RIB6         = 0x0000825d,
    SIPAEV_AMD_PSP_DF_RIB7         = 0x0000825e,
    SIPAEV_AMD_PSP_DF_RIB8         = 0x0000825f,
    SIPAEV_AMD_PSP_DF_RIB9         = 0x00008260,
    SIPAEV_AMD_PSP_DF_RIB10        = 0x00008261,
    SIPAEV_AMD_PSP_DF_RIB11        = 0x00008262,
    SIPAEV_AMD_PSP_DF_RIB12        = 0x00008263,
    SIPAEV_AMD_PSP_DF_RIB13        = 0x00008264,
    SIPAEV_AMD_PSP_DF_RIB14        = 0x00008265,
    SIPAEV_AMD_PSP_DF_RIB15        = 0x00008266,
    SIPAEV_AMD_SECURE_DEBUG_UNLOCK = 0x00008267,
}

enum : uint
{
    SIPAEV_AMD_PSP_BL_END         = 0x000082ff,
    SIPAEV_AMD_FTPM_DRV           = 0x00008300,
    SIPAEV_AMD_DRTM_DRV           = 0x00008301,
    SIPAEV_AMD_AGESA_DRV          = 0x00008302,
    SIPAEV_AMD_PSP_END            = 0x000083ff,
    SIPAEV_ARM_BASE               = 0x00009000,
    SIPAEV_ARM_PCR_SCHEMA         = 0x00009001,
    SIPAEV_ARM_DCE                = 0x00009002,
    SIPAEV_ARM_DCE_PUBKEY         = 0x00009003,
    SIPAEV_ARM_DLME               = 0x00009004,
    SIPAEV_ARM_DLME_ENTRY_POINT   = 0x00009005,
    SIPAEV_ARM_DEBUG_CONFIG       = 0x00009006,
    SIPAEV_ARM_NONSECURE_CONFIG   = 0x00009007,
    SIPAEV_ARM_DCE_SECONDARY      = 0x00009008,
    SIPAEV_ARM_TZFW               = 0x00009009,
    SIPAEV_ARM_SEPARATOR          = 0x0000900a,
    SIPAEV_ARM_DLME_PUBKEY        = 0x0000900b,
    SIPAEV_ARM_DLME_SVN           = 0x0000900c,
    SIPAEV_ARM_NO_ACTION          = 0x0000900d,
    SIPAEV_ARM_SECURE_INT_DISABLE = 0x0000900e,
}

enum : uint
{
    SIPAEVENTTYPE_NONMEASURED    = 0x80000000,
    SIPAEVENTTYPE_AGGREGATION    = 0x40000000,
    SIPAEVENTTYPE_CONTAINER      = 0x00010000,
    SIPAEVENTTYPE_INFORMATION    = 0x00020000,
    SIPAEVENTTYPE_ERROR          = 0x00030000,
    SIPAEVENTTYPE_PREOSPARAMETER = 0x00040000,
    SIPAEVENTTYPE_OSPARAMETER    = 0x00050000,
    SIPAEVENTTYPE_AUTHORITY      = 0x00060000,
    SIPAEVENTTYPE_LOADEDMODULE   = 0x00070000,
    SIPAEVENTTYPE_TRUSTPOINT     = 0x00080000,
    SIPAEVENTTYPE_ELAM           = 0x00090000,
    SIPAEVENTTYPE_VBS            = 0x000a0000,
    SIPAEVENTTYPE_KSR            = 0x000b0000,
    SIPAEVENTTYPE_DRTM           = 0x000c0000,
}

enum uint SIPAERROR_FIRMWAREFAILURE = 0x00030001;
enum uint SIPAERROR_INTERNALFAILURE = 0x00030003;
enum uint SIPAERROR_HYPERVISORFAILURE = 0x00030005;

enum : uint
{
    SIPAEVENT_INFORMATION      = 0x00020001,
    SIPAEVENT_BOOTCOUNTER      = 0x00020002,
    SIPAEVENT_TRANSFER_CONTROL = 0x00020003,
}

enum uint SIPAEVENT_APPLICATION_RETURN = 0x00020004;
enum uint SIPAEVENT_BITLOCKER_UNLOCK = 0x00020005;

enum : uint
{
    SIPAEVENT_EVENTCOUNTER          = 0x00020006,
    SIPAEVENT_COUNTERID             = 0x00020007,
    SIPAEVENT_MORBIT_NOT_CANCELABLE = 0x00020008,
}

enum uint SIPAEVENT_APPLICATION_SVN = 0x00020009;
enum uint SIPAEVENT_SVN_CHAIN_STATUS = 0x0002000a;
enum uint SIPAEVENT_IDK_GENERATION_STATUS = 0x0002000c;
enum uint SIPAEVENT_MORBIT_API_STATUS = 0x0002000b;

enum : uint
{
    SIPAEVENT_BOOTDEBUGGING        = 0x00040001,
    SIPAEVENT_BOOT_REVOCATION_LIST = 0x00040002,
}

enum : uint
{
    SIPAEVENT_OSKERNELDEBUG           = 0x00050001,
    SIPAEVENT_CODEINTEGRITY           = 0x00050002,
    SIPAEVENT_TESTSIGNING             = 0x00050003,
    SIPAEVENT_DATAEXECUTIONPREVENTION = 0x00050004,
}

enum : uint
{
    SIPAEVENT_SAFEMODE                 = 0x00050005,
    SIPAEVENT_WINPE                    = 0x00050006,
    SIPAEVENT_PHYSICALADDRESSEXTENSION = 0x00050007,
}

enum : uint
{
    SIPAEVENT_OSDEVICE                = 0x00050008,
    SIPAEVENT_SYSTEMROOT              = 0x00050009,
    SIPAEVENT_HYPERVISOR_LAUNCH_TYPE  = 0x0005000a,
    SIPAEVENT_HYPERVISOR_PATH         = 0x0005000b,
    SIPAEVENT_HYPERVISOR_IOMMU_POLICY = 0x0005000c,
    SIPAEVENT_HYPERVISOR_DEBUG        = 0x0005000d,
}

enum uint SIPAEVENT_DRIVER_LOAD_POLICY = 0x0005000e;

enum : uint
{
    SIPAEVENT_SI_POLICY                    = 0x0005000f,
    SIPAEVENT_HYPERVISOR_MMIO_NX_POLICY    = 0x00050010,
    SIPAEVENT_HYPERVISOR_MSR_FILTER_POLICY = 0x00050011,
}

enum uint SIPAEVENT_VSM_LAUNCH_TYPE = 0x00050012;
enum uint SIPAEVENT_OS_REVOCATION_LIST = 0x00050013;

enum : uint
{
    SIPAEVENT_SMT_STATUS                  = 0x00050014,
    SIPAEVENT_VSM_IDK_INFO                = 0x00050020,
    SIPAEVENT_FLIGHTSIGNING               = 0x00050021,
    SIPAEVENT_PAGEFILE_ENCRYPTION_ENABLED = 0x00050022,
}

enum : uint
{
    SIPAEVENT_VSM_IDKS_INFO        = 0x00050023,
    SIPAEVENT_HIBERNATION_DISABLED = 0x00050024,
}

enum : uint
{
    SIPAEVENT_DUMPS_DISABLED             = 0x00050025,
    SIPAEVENT_DUMP_ENCRYPTION_ENABLED    = 0x00050026,
    SIPAEVENT_DUMP_ENCRYPTION_KEY_DIGEST = 0x00050027,
}

enum : uint
{
    SIPAEVENT_LSAISO_CONFIG                  = 0x00050028,
    SIPAEVENT_SBCP_INFO                      = 0x00050029,
    SIPAEVENT_HYPERVISOR_BOOT_DMA_PROTECTION = 0x00050030,
}

enum : uint
{
    SIPAEVENT_SI_POLICY_SIGNER        = 0x00050031,
    SIPAEVENT_SI_POLICY_UPDATE_SIGNER = 0x00050032,
}

enum uint SIPAEVENT_REFS_VOLUME_CHECKPOINT_RECORD_CHECKSUM = 0x00050033;

enum : uint
{
    SIPAEVENT_REFS_ROLLBACK_PROTECTION_FROZEN_VOLUME_CHECKSUM  = 0x00050034,
    SIPAEVENT_REFS_ROLLBACK_PROTECTION_USER_PAYLOAD_HASH       = 0x00050035,
    SIPAEVENT_REFS_ROLLBACK_PROTECTION_VERIFICATION_SUCCEEDED  = 0x00050036,
    SIPAEVENT_REFS_ROLLBACK_PROTECTION_VOLUME_FIRST_EVER_MOUNT = 0x00050037,
}

enum : uint
{
    SIPAEVENT_VSM_SEALED_SI_POLICY      = 0x0005003a,
    SIPAEVENT_VSM_DRTM_KEYROLL_DETECTED = 0x0005003b,
}

enum : uint
{
    SIPAEVENT_VSM_SRTM_UNSEAL_POLICY         = 0x0005003c,
    SIPAEVENT_VSM_SRTM_ANTI_ROLLBACK_COUNTER = 0x0005003d,
}

enum uint SIPAEVENT_VTL1_DUMP_CONFIG = 0x00050040;

enum : uint
{
    SIPAEVENT_NOAUTHORITY     = 0x00060001,
    SIPAEVENT_AUTHORITYPUBKEY = 0x00060002,
}

enum : uint
{
    SIPAEVENT_FILEPATH        = 0x00070001,
    SIPAEVENT_IMAGESIZE       = 0x00070002,
    SIPAEVENT_HASHALGORITHMID = 0x00070003,
}

enum : uint
{
    SIPAEVENT_AUTHENTICODEHASH = 0x00070004,
    SIPAEVENT_AUTHORITYISSUER  = 0x00070005,
    SIPAEVENT_AUTHORITYSERIAL  = 0x00070006,
}

enum : uint
{
    SIPAEVENT_IMAGEBASE               = 0x00070007,
    SIPAEVENT_AUTHORITYPUBLISHER      = 0x00070008,
    SIPAEVENT_AUTHORITYSHA1THUMBPRINT = 0x00070009,
}

enum : uint
{
    SIPAEVENT_IMAGEVALIDATED           = 0x0007000a,
    SIPAEVENT_MODULE_SVN               = 0x0007000b,
    SIPAEVENT_MODULE_PLUTON            = 0x0007000c,
    SIPAEVENT_MODULE_ORIGINAL_FILENAME = 0x0007000d,
    SIPAEVENT_MODULE_VERSION           = 0x0007000e,
    SIPAEVENT_PUBLISHER_OEMNAME        = 0x0007000f,
}

enum : uint
{
    SIPAEVENT_ELAM_KEYNAME               = 0x00090001,
    SIPAEVENT_ELAM_CONFIGURATION         = 0x00090002,
    SIPAEVENT_ELAM_POLICY                = 0x00090003,
    SIPAEVENT_ELAM_MEASURED              = 0x00090004,
    SIPAEVENT_VBS_VSM_REQUIRED           = 0x000a0001,
    SIPAEVENT_VBS_SECUREBOOT_REQUIRED    = 0x000a0002,
    SIPAEVENT_VBS_IOMMU_REQUIRED         = 0x000a0003,
    SIPAEVENT_VBS_MMIO_NX_REQUIRED       = 0x000a0004,
    SIPAEVENT_VBS_MSR_FILTERING_REQUIRED = 0x000a0005,
    SIPAEVENT_VBS_MANDATORY_ENFORCEMENT  = 0x000a0006,
}

enum : uint
{
    SIPAEVENT_VBS_HVCI_POLICY                   = 0x000a0007,
    SIPAEVENT_VBS_MICROSOFT_BOOT_CHAIN_REQUIRED = 0x000a0008,
}

enum : uint
{
    SIPAEVENT_VBS_DUMP_USES_AMEROOT      = 0x000a0009,
    SIPAEVENT_VBS_VSM_NOSECRETS_ENFORCED = 0x000a000a,
}

enum : uint
{
    SIPAEVENT_KSR_SIGNATURE           = 0x000b0001,
    SIPAEVENT_DRTM_STATE_AUTH         = 0x000c0001,
    SIPAEVENT_DRTM_SMM_LEVEL          = 0x000c0002,
    SIPAEVENT_DRTM_AMD_SMM_HASH       = 0x000c0003,
    SIPAEVENT_DRTM_AMD_SMM_SIGNER_KEY = 0x000c0004,
}

enum : uint
{
    FVEB_UNLOCK_FLAG_NONE          = 0x00000000,
    FVEB_UNLOCK_FLAG_CACHED        = 0x00000001,
    FVEB_UNLOCK_FLAG_MEDIA         = 0x00000002,
    FVEB_UNLOCK_FLAG_TPM           = 0x00000004,
    FVEB_UNLOCK_FLAG_PIN           = 0x00000010,
    FVEB_UNLOCK_FLAG_EXTERNAL      = 0x00000020,
    FVEB_UNLOCK_FLAG_RECOVERY      = 0x00000040,
    FVEB_UNLOCK_FLAG_PASSPHRASE    = 0x00000080,
    FVEB_UNLOCK_FLAG_NBP           = 0x00000100,
    FVEB_UNLOCK_FLAG_AUK_OSFVEINFO = 0x00000200,
}

enum : uint
{
    OSDEVICE_TYPE_UNKNOWN                 = 0x00000000,
    OSDEVICE_TYPE_BLOCKIO_HARDDISK        = 0x00010001,
    OSDEVICE_TYPE_BLOCKIO_REMOVABLEDISK   = 0x00010002,
    OSDEVICE_TYPE_BLOCKIO_CDROM           = 0x00010003,
    OSDEVICE_TYPE_BLOCKIO_PARTITION       = 0x00010004,
    OSDEVICE_TYPE_BLOCKIO_FILE            = 0x00010005,
    OSDEVICE_TYPE_BLOCKIO_RAMDISK         = 0x00010006,
    OSDEVICE_TYPE_BLOCKIO_VIRTUALHARDDISK = 0x00010007,
}

enum : uint
{
    OSDEVICE_TYPE_SERIAL    = 0x00020000,
    OSDEVICE_TYPE_UDP       = 0x00030000,
    OSDEVICE_TYPE_VMBUS     = 0x00040000,
    OSDEVICE_TYPE_COMPOSITE = 0x00050000,
    OSDEVICE_TYPE_CIMFS     = 0x00060000,
}

enum uint SIPAHDRSIGNATURE = 0x4c434257;
enum uint SIPALOGVERSION = 0x00000001;
enum uint SIPAKSRHDRSIGNATURE = 0x4d52534b;

enum : uint
{
    WBCL_DIGEST_ALG_ID_SHA_1         = 0x00000004,
    WBCL_DIGEST_ALG_ID_SHA_2_256     = 0x0000000b,
    WBCL_DIGEST_ALG_ID_SHA_2_384     = 0x0000000c,
    WBCL_DIGEST_ALG_ID_SHA_2_512     = 0x0000000d,
    WBCL_DIGEST_ALG_ID_SM3_256       = 0x00000012,
    WBCL_DIGEST_ALG_ID_SHA3_256      = 0x00000027,
    WBCL_DIGEST_ALG_ID_SHA3_384      = 0x00000028,
    WBCL_DIGEST_ALG_ID_SHA3_512      = 0x00000029,
    WBCL_DIGEST_ALG_BITMAP_SHA_1     = 0x00000001,
    WBCL_DIGEST_ALG_BITMAP_SHA_2_256 = 0x00000002,
    WBCL_DIGEST_ALG_BITMAP_SHA_2_384 = 0x00000004,
    WBCL_DIGEST_ALG_BITMAP_SHA_2_512 = 0x00000008,
    WBCL_DIGEST_ALG_BITMAP_SM3_256   = 0x00000010,
    WBCL_DIGEST_ALG_BITMAP_SHA3_256  = 0x00000020,
    WBCL_DIGEST_ALG_BITMAP_SHA3_384  = 0x00000040,
    WBCL_DIGEST_ALG_BITMAP_SHA3_512  = 0x00000080,
}

enum uint MAX_PLUTON_UPGRADE_FILENAME_LENGTH = 0x00000040;
enum uint WBCL_MAX_PLUTON_UPGRADE_HASH_LEN = 0x00000040;
enum uint WBCL_HASH_LEN_SHA1 = 0x00000014;

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

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qos/ns-qos-qos_object_hdr))], [])
struct QOS_OBJECT_HDR
{
    uint ObjectType;
    uint ObjectLength;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qos/ns-qos-qos_sd_mode))], [])
struct QOS_SD_MODE
{
    QOS_OBJECT_HDR ObjectHdr;
    uint           ShapeDiscardMode;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qos/ns-qos-qos_shaping_rate))], [])
struct QOS_SHAPING_RATE
{
    QOS_OBJECT_HDR ObjectHdr;
    uint           ShapingRate;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qos2/ns-qos2-qos_packet_priority))], [])
struct QOS_PACKET_PRIORITY
{
    uint ConformantDSCPValue;
    uint NonConformantDSCPValue;
    uint ConformantL2Value;
    uint NonConformantL2Value;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qos2/ns-qos2-qos_flow_fundamentals))], [])
struct QOS_FLOW_FUNDAMENTALS
{
    BOOL  BottleneckBandwidthSet;
    ulong BottleneckBandwidth;
    BOOL  AvailableBandwidthSet;
    ulong AvailableBandwidth;
    BOOL  RTTSet;
    uint  RTT;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qos2/ns-qos2-qos_flowrate_outgoing))], [])
struct QOS_FLOWRATE_OUTGOING
{
    ulong               Bandwidth;
    QOS_SHAPING         ShapingBehavior;
    QOS_FLOWRATE_REASON Reason;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qos2/ns-qos2-qos_version))], [])
struct QOS_VERSION
{
    ushort MajorVersion;
    ushort MinorVersion;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qosobjs/ns-qosobjs-qos_friendly_name))], [])
struct QOS_FRIENDLY_NAME
{
    QOS_OBJECT_HDR ObjectHdr;
    wchar[256]     FriendlyName;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qosobjs/ns-qosobjs-qos_traffic_class))], [])
struct QOS_TRAFFIC_CLASS
{
    QOS_OBJECT_HDR ObjectHdr;
    uint           TrafficClass;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qosobjs/ns-qosobjs-qos_ds_class))], [])
struct QOS_DS_CLASS
{
    QOS_OBJECT_HDR ObjectHdr;
    uint           DSField;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qosobjs/ns-qosobjs-qos_diffserv))], [])
struct QOS_DIFFSERV
{
    QOS_OBJECT_HDR ObjectHdr;
    uint           DSFieldCount;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] DiffservRule;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qosobjs/ns-qosobjs-qos_diffserv_rule))], [])
struct QOS_DIFFSERV_RULE
{
    ubyte InboundDSField;
    ubyte ConformingOutboundDSField;
    ubyte NonConformingOutboundDSField;
    ubyte ConformingUserPriority;
    ubyte NonConformingUserPriority;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qosobjs/ns-qosobjs-qos_tcp_traffic))], [])
struct QOS_TCP_TRAFFIC
{
    QOS_OBJECT_HDR ObjectHdr;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/traffic/ns-traffic-tci_client_func_list))], [])
struct TCI_CLIENT_FUNC_LIST
{
    TCI_NOTIFY_HANDLER ClNotifyHandler;
    TCI_ADD_FLOW_COMPLETE_HANDLER ClAddFlowCompleteHandler;
    TCI_MOD_FLOW_COMPLETE_HANDLER ClModifyFlowCompleteHandler;
    TCI_DEL_FLOW_COMPLETE_HANDLER ClDeleteFlowCompleteHandler;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/traffic/ns-traffic-address_list_descriptor))], [])
struct ADDRESS_LIST_DESCRIPTOR
{
    uint                 MediaType;
    NETWORK_ADDRESS_LIST AddressList;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/traffic/ns-traffic-tc_ifc_descriptor))], [])
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

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/traffic/ns-traffic-tc_gen_filter))], [])
struct TC_GEN_FILTER
{
    ushort AddressType;
    uint   PatternSize;
    void*  Pattern;
    void*  Mask;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/traffic/ns-traffic-tc_gen_flow))], [])
struct TC_GEN_FLOW
{
    FLOWSPEC SendingFlowspec;
    FLOWSPEC ReceivingFlowspec;
    uint     TcObjectsLength;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/QOS_OBJECT_HDR[1] TcObjects;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/traffic/ns-traffic-ip_pattern))], [])
struct IP_PATTERN
{
    uint           Reserved1;
    uint           Reserved2;
    uint           SrcAddr;
    uint           DstAddr;
    _S_un_e__Union S_un;
    ubyte          ProtocolId;
    ubyte[3]       Reserved3;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/traffic/ns-traffic-ipx_pattern))], [])
struct IPX_PATTERN
{
    _Src_e__Struct Src;
    _Src_e__Struct Dest;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/traffic/ns-traffic-enumeration_buffer))], [])
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

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qossp/ns-qossp-in_addr_ipv4))], [])
union IN_ADDR_IPV4
{
    uint     Addr;
    ubyte[4] AddrBytes;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qossp/ns-qossp-in_addr_ipv6))], [])
struct IN_ADDR_IPV6
{
    ubyte[16] Addr;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qossp/ns-qossp-rsvp_filterspec_v4))], [])
struct RSVP_FILTERSPEC_V4
{
    IN_ADDR_IPV4 Address;
    ushort       Unused;
    ushort       Port;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qossp/ns-qossp-rsvp_filterspec_v6))], [])
struct RSVP_FILTERSPEC_V6
{
    IN_ADDR_IPV6 Address;
    ushort       UnUsed;
    ushort       Port;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qossp/ns-qossp-rsvp_filterspec_v6_flow))], [])
struct RSVP_FILTERSPEC_V6_FLOW
{
    IN_ADDR_IPV6 Address;
    ubyte        UnUsed;
    ubyte[3]     FlowLabel;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qossp/ns-qossp-rsvp_filterspec_v4_gpi))], [])
struct RSVP_FILTERSPEC_V4_GPI
{
    IN_ADDR_IPV4 Address;
    uint         GeneralPortId;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qossp/ns-qossp-rsvp_filterspec_v6_gpi))], [])
struct RSVP_FILTERSPEC_V6_GPI
{
    IN_ADDR_IPV6 Address;
    uint         GeneralPortId;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qossp/ns-qossp-rsvp_filterspec))], [])
struct RSVP_FILTERSPEC
{
    FilterType          Type;
    _Anonymous_e__Union Anonymous;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qossp/ns-qossp-flowdescriptor))], [])
struct FLOWDESCRIPTOR
{
    FLOWSPEC         FlowSpec;
    uint             NumFilters;
    RSVP_FILTERSPEC* FilterList;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qossp/ns-qossp-rsvp_policy))], [])
struct RSVP_POLICY
{
    ushort   Len;
    ushort   Type;
    ubyte[4] Info;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qossp/ns-qossp-rsvp_policy_info))], [])
struct RSVP_POLICY_INFO
{
    QOS_OBJECT_HDR ObjectHdr;
    uint           NumPolicyElement;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/RSVP_POLICY[1] PolicyElement;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qossp/ns-qossp-rsvp_reserve_info))], [])
struct RSVP_RESERVE_INFO
{
    QOS_OBJECT_HDR    ObjectHdr;
    uint              Style;
    uint              ConfirmRequest;
    RSVP_POLICY_INFO* PolicyElementList;
    uint              NumFlowDesc;
    FLOWDESCRIPTOR*   FlowDescList;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qossp/ns-qossp-rsvp_status_info))], [])
struct RSVP_STATUS_INFO
{
    QOS_OBJECT_HDR ObjectHdr;
    uint           StatusCode;
    uint           ExtendedStatus1;
    uint           ExtendedStatus2;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qossp/ns-qossp-qos_destaddr))], [])
struct QOS_DESTADDR
{
    QOS_OBJECT_HDR   ObjectHdr;
    const(SOCKADDR)* SocketAddress;
    uint             SocketAddressLength;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qossp/ns-qossp-ad_general_params))], [])
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

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qossp/ns-qossp-param_buffer))], [])
struct PARAM_BUFFER
{
    uint ParameterId;
    uint Length;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] Buffer;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qossp/ns-qossp-control_service))], [])
struct CONTROL_SERVICE
{
    uint                Length;
    uint                Service;
    AD_GENERAL_PARAMS   Overrides;
    _Anonymous_e__Union Anonymous;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qossp/ns-qossp-rsvp_adspec))], [])
struct RSVP_ADSPEC
{
    QOS_OBJECT_HDR    ObjectHdr;
    AD_GENERAL_PARAMS GeneralParams;
    uint              NumberOfServices;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/CONTROL_SERVICE[1] Services;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qospol/ns-qospol-idpe_attr))], [])
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
    uint                KeyAlgID;
    _Anonymous_e__Union Anonymous;
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


