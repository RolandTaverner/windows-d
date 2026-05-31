// Written in the D programming language.

module windows.win32.system.deploymentservices;

public import windows.core;
public import windows.win32.foundation.foundation : BOOL, BSTR, HANDLE, HRESULT, LPARAM,
                                                    PWSTR, SYSTEMTIME, VARIANT_BOOL,
                                                    WPARAM;
public import windows.win32.system.com.com : IDispatch, IUnknown;
public import windows.win32.system.registry : HKEY;

extern(Windows) @nogc nothrow:


// Enums


alias CPU_ARCHITECTURE = uint;
enum : uint
{
    CPU_ARCHITECTURE_AMD64 = 0x00000009U,
    CPU_ARCHITECTURE_IA64  = 0x00000006U,
    CPU_ARCHITECTURE_INTEL = 0x00000000U,
}

alias PFN_WDS_CLI_CALLBACK_MESSAGE_ID = uint;
enum : uint
{
    WDS_CLI_MSG_START    = 0x00000000U,
    WDS_CLI_MSG_COMPLETE = 0x00000001U,
    WDS_CLI_MSG_PROGRESS = 0x00000002U,
    WDS_CLI_MSG_TEXT     = 0x00000003U,
}

alias WDS_TRANSPORTCLIENT_REQUEST_AUTH_LEVEL = uint;
enum : uint
{
    WDS_TRANSPORTCLIENT_AUTH    = 0x00000001U,
    WDS_TRANSPORTCLIENT_NO_AUTH = 0x00000002U,
}

alias WDS_CLI_IMAGE_TYPE = int;
enum : int
{
    WDS_CLI_IMAGE_TYPE_UNKNOWN = 0x00000000,
    WDS_CLI_IMAGE_TYPE_WIM     = 0x00000001,
    WDS_CLI_IMAGE_TYPE_VHD     = 0x00000002,
    WDS_CLI_IMAGE_TYPE_VHDX    = 0x00000003,
}

alias WDS_CLI_FIRMWARE_TYPE = int;
enum : int
{
    WDS_CLI_FIRMWARE_UNKNOWN = 0x00000000,
    WDS_CLI_FIRMWARE_BIOS    = 0x00000001,
    WDS_CLI_FIRMWARE_EFI     = 0x00000002,
}

alias WDS_CLI_IMAGE_PARAM_TYPE = int;
enum : int
{
    WDS_CLI_IMAGE_PARAM_UNKNOWN             = 0x00000000,
    WDS_CLI_IMAGE_PARAM_SPARSE_FILE         = 0x00000001,
    WDS_CLI_IMAGE_PARAM_SUPPORTED_FIRMWARES = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstpdi/ne-wdstpdi-transportprovider_callback_id
alias TRANSPORTPROVIDER_CALLBACK_ID = int;
enum : int
{
    WDS_TRANSPORTPROVIDER_CREATE_INSTANCE      = 0x00000000,
    WDS_TRANSPORTPROVIDER_COMPARE_CONTENT      = 0x00000001,
    WDS_TRANSPORTPROVIDER_OPEN_CONTENT         = 0x00000002,
    WDS_TRANSPORTPROVIDER_USER_ACCESS_CHECK    = 0x00000003,
    WDS_TRANSPORTPROVIDER_GET_CONTENT_SIZE     = 0x00000004,
    WDS_TRANSPORTPROVIDER_READ_CONTENT         = 0x00000005,
    WDS_TRANSPORTPROVIDER_CLOSE_CONTENT        = 0x00000006,
    WDS_TRANSPORTPROVIDER_CLOSE_INSTANCE       = 0x00000007,
    WDS_TRANSPORTPROVIDER_SHUTDOWN             = 0x00000008,
    WDS_TRANSPORTPROVIDER_DUMP_STATE           = 0x00000009,
    WDS_TRANSPORTPROVIDER_REFRESH_SETTINGS     = 0x0000000a,
    WDS_TRANSPORTPROVIDER_GET_CONTENT_METADATA = 0x0000000b,
    WDS_TRANSPORTPROVIDER_MAX_CALLBACKS        = 0x0000000c,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstci/ne-wdstci-transportclient_callback_id
alias TRANSPORTCLIENT_CALLBACK_ID = int;
enum : int
{
    WDS_TRANSPORTCLIENT_SESSION_START     = 0x00000000,
    WDS_TRANSPORTCLIENT_RECEIVE_CONTENTS  = 0x00000001,
    WDS_TRANSPORTCLIENT_SESSION_COMPLETE  = 0x00000002,
    WDS_TRANSPORTCLIENT_RECEIVE_METADATA  = 0x00000003,
    WDS_TRANSPORTCLIENT_SESSION_STARTEX   = 0x00000004,
    WDS_TRANSPORTCLIENT_SESSION_NEGOTIATE = 0x00000005,
    WDS_TRANSPORTCLIENT_MAX_CALLBACKS     = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/ne-wdstptmgmt-wdstransport_feature_flags
alias WDSTRANSPORT_FEATURE_FLAGS = int;
enum : int
{
    WdsTptFeatureAdminPack        = 0x00000001,
    WdsTptFeatureTransportServer  = 0x00000002,
    WdsTptFeatureDeploymentServer = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/ne-wdstptmgmt-wdstransport_protocol_flags
alias WDSTRANSPORT_PROTOCOL_FLAGS = int;
enum : int
{
    WdsTptProtocolUnicast   = 0x00000001,
    WdsTptProtocolMulticast = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/ne-wdstptmgmt-wdstransport_namespace_type
alias WDSTRANSPORT_NAMESPACE_TYPE = int;
enum : int
{
    WdsTptNamespaceTypeUnknown                  = 0x00000000,
    WdsTptNamespaceTypeAutoCast                 = 0x00000001,
    WdsTptNamespaceTypeScheduledCastManualStart = 0x00000002,
    WdsTptNamespaceTypeScheduledCastAutoStart   = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/ne-wdstptmgmt-wdstransport_disconnect_type
alias WDSTRANSPORT_DISCONNECT_TYPE = int;
enum : int
{
    WdsTptDisconnectUnknown  = 0x00000000,
    WdsTptDisconnectFallback = 0x00000001,
    WdsTptDisconnectAbort    = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/ne-wdstptmgmt-wdstransport_service_notification
alias WDSTRANSPORT_SERVICE_NOTIFICATION = int;
enum : int
{
    WdsTptServiceNotifyUnknown      = 0x00000000,
    WdsTptServiceNotifyReadSettings = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/ne-wdstptmgmt-wdstransport_ip_address_type
alias WDSTRANSPORT_IP_ADDRESS_TYPE = int;
enum : int
{
    WdsTptIpAddressUnknown = 0x00000000,
    WdsTptIpAddressIpv4    = 0x00000001,
    WdsTptIpAddressIpv6    = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/ne-wdstptmgmt-wdstransport_ip_address_source_type
alias WDSTRANSPORT_IP_ADDRESS_SOURCE_TYPE = int;
enum : int
{
    WdsTptIpAddressSourceUnknown = 0x00000000,
    WdsTptIpAddressSourceDhcp    = 0x00000001,
    WdsTptIpAddressSourceRange   = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/ne-wdstptmgmt-wdstransport_network_profile_type
alias WDSTRANSPORT_NETWORK_PROFILE_TYPE = int;
enum : int
{
    WdsTptNetworkProfileUnknown = 0x00000000,
    WdsTptNetworkProfileCustom  = 0x00000001,
    WdsTptNetworkProfile10Mbps  = 0x00000002,
    WdsTptNetworkProfile100Mbps = 0x00000003,
    WdsTptNetworkProfile1Gbps   = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/ne-wdstptmgmt-wdstransport_diagnostics_component_flags
alias WDSTRANSPORT_DIAGNOSTICS_COMPONENT_FLAGS = int;
enum : int
{
    WdsTptDiagnosticsComponentPxe         = 0x00000001,
    WdsTptDiagnosticsComponentTftp        = 0x00000002,
    WdsTptDiagnosticsComponentImageServer = 0x00000004,
    WdsTptDiagnosticsComponentMulticast   = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/ne-wdstptmgmt-wdstransport_slow_client_handling_type
alias WDSTRANSPORT_SLOW_CLIENT_HANDLING_TYPE = int;
enum : int
{
    WdsTptSlowClientHandlingUnknown        = 0x00000000,
    WdsTptSlowClientHandlingNone           = 0x00000001,
    WdsTptSlowClientHandlingAutoDisconnect = 0x00000002,
    WdsTptSlowClientHandlingMultistream    = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/ne-wdstptmgmt-wdstransport_udp_port_policy
alias WDSTRANSPORT_UDP_PORT_POLICY = int;
enum : int
{
    WdsTptUdpPortPolicyDynamic = 0x00000000,
    WdsTptUdpPortPolicyFixed   = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/ne-wdstptmgmt-wdstransport_tftp_capability
alias WDSTRANSPORT_TFTP_CAPABILITY = int;
enum : int
{
    WdsTptTftpCapMaximumBlockSize = 0x00000001,
    WdsTptTftpCapVariableWindow   = 0x00000002,
}

// Constants


enum uint WDS_CLI_TRANSFER_ASYNCHRONOUS = 0x00000001U;
enum uint WDS_CLI_NO_SPARSE_FILE = 0x00000002U;

enum : uint
{
    PXE_DHCP_SERVER_PORT = 0x00000043U,
    PXE_DHCP_CLIENT_PORT = 0x00000044U,
}

enum uint PXE_SERVER_PORT = 0x00000fabU;

enum : uint
{
    PXE_DHCPV6_SERVER_PORT = 0x00000223U,
    PXE_DHCPV6_CLIENT_PORT = 0x00000222U,
}

enum : uint
{
    PXE_DHCP_FILE_SIZE         = 0x00000080U,
    PXE_DHCP_SERVER_SIZE       = 0x00000040U,
    PXE_DHCP_HWAADR_SIZE       = 0x00000010U,
    PXE_DHCP_MAGIC_COOKIE_SIZE = 0x00000004U,
}

enum : uint
{
    PXE_REG_INDEX_TOP    = 0x00000000U,
    PXE_REG_INDEX_BOTTOM = 0xffffffffU,
}

enum : uint
{
    PXE_CALLBACK_RECV_REQUEST    = 0x00000000U,
    PXE_CALLBACK_SHUTDOWN        = 0x00000001U,
    PXE_CALLBACK_SERVICE_CONTROL = 0x00000002U,
    PXE_CALLBACK_MAX             = 0x00000003U,
}

enum uint PXE_GSI_TRACE_ENABLED = 0x00000001U;
enum uint PXE_GSI_SERVER_DUID = 0x00000002U;
enum uint PXE_MAX_ADDRESS = 0x00000010U;

enum : uint
{
    PXE_ADDR_BROADCAST      = 0x00000001U,
    PXE_ADDR_USE_PORT       = 0x00000002U,
    PXE_ADDR_USE_ADDR       = 0x00000004U,
    PXE_ADDR_USE_DHCP_RULES = 0x00000008U,
}

enum uint PXE_DHCPV6_RELAY_HOP_COUNT_LIMIT = 0x00000020U;

enum : uint
{
    PXE_BA_NBP      = 0x00000001U,
    PXE_BA_CUSTOM   = 0x00000002U,
    PXE_BA_IGNORE   = 0x00000003U,
    PXE_BA_REJECTED = 0x00000004U,
}

enum : uint
{
    PXE_TRACE_VERBOSE = 0x00010000U,
    PXE_TRACE_INFO    = 0x00020000U,
    PXE_TRACE_WARNING = 0x00040000U,
    PXE_TRACE_ERROR   = 0x00080000U,
    PXE_TRACE_FATAL   = 0x00100000U,
}

enum : uint
{
    PXE_PROV_ATTR_FILTER       = 0x00000000U,
    PXE_PROV_ATTR_FILTER_IPV6  = 0x00000001U,
    PXE_PROV_ATTR_IPV6_CAPABLE = 0x00000002U,
}

enum : uint
{
    PXE_PROV_FILTER_ALL       = 0x00000000U,
    PXE_PROV_FILTER_DHCP_ONLY = 0x00000001U,
    PXE_PROV_FILTER_PXE_ONLY  = 0x00000002U,
}

enum uint MC_SERVER_CURRENT_VERSION = 0x00000001U;
enum uint TRANSPORTPROVIDER_CURRENT_VERSION = 0x00000001U;

enum : uint
{
    WDS_MC_TRACE_VERBOSE = 0x00010000U,
    WDS_MC_TRACE_INFO    = 0x00020000U,
    WDS_MC_TRACE_WARNING = 0x00040000U,
    WDS_MC_TRACE_ERROR   = 0x00080000U,
    WDS_MC_TRACE_FATAL   = 0x00100000U,
}

enum : uint
{
    WDS_TRANSPORTCLIENT_CURRENT_API_VERSION = 0x00000001U,
    WDS_TRANSPORTCLIENT_PROTOCOL_MULTICAST  = 0x00000001U,
    WDS_TRANSPORTCLIENT_NO_CACHE            = 0x00000000U,
    WDS_TRANSPORTCLIENT_STATUS_IN_PROGRESS  = 0x00000001U,
    WDS_TRANSPORTCLIENT_STATUS_SUCCESS      = 0x00000002U,
    WDS_TRANSPORTCLIENT_STATUS_FAILURE      = 0x00000003U,
}

enum uint WDSTRANSPORT_RESOURCE_UTILIZATION_UNKNOWN = 0x000000ffU;

enum : uint
{
    WDSBP_PK_TYPE_DHCP   = 0x00000001U,
    WDSBP_PK_TYPE_WDSNBP = 0x00000002U,
    WDSBP_PK_TYPE_BCD    = 0x00000004U,
    WDSBP_PK_TYPE_DHCPV6 = 0x00000008U,
}

enum : uint
{
    WDSBP_OPT_TYPE_NONE              = 0x00000000U,
    WDSBP_OPT_TYPE_BYTE              = 0x00000001U,
    WDSBP_OPT_TYPE_USHORT            = 0x00000002U,
    WDSBP_OPT_TYPE_ULONG             = 0x00000003U,
    WDSBP_OPT_TYPE_WSTR              = 0x00000004U,
    WDSBP_OPT_TYPE_STR               = 0x00000005U,
    WDSBP_OPT_TYPE_IP4               = 0x00000006U,
    WDSBP_OPT_TYPE_IP6               = 0x00000007U,
    WDSBP_OPTVAL_ACTION_APPROVAL     = 0x00000001U,
    WDSBP_OPTVAL_ACTION_REFERRAL     = 0x00000003U,
    WDSBP_OPTVAL_ACTION_ABORT        = 0x00000005U,
    WDSBP_OPTVAL_PXE_PROMPT_OPTIN    = 0x00000001U,
    WDSBP_OPTVAL_PXE_PROMPT_NOPROMPT = 0x00000002U,
    WDSBP_OPTVAL_PXE_PROMPT_OPTOUT   = 0x00000003U,
    WDSBP_OPTVAL_NBP_VER_7           = 0x00000700U,
    WDSBP_OPTVAL_NBP_VER_8           = 0x00000800U,
}

enum : uint
{
    FACILITY_WDSMCSERVER = 0x00000121U,
    FACILITY_WDSMCCLIENT = 0x00000122U,
}

enum HRESULT WDSMCSERVER_CATEGORY = HRESULT(0x00000001);
enum HRESULT WDSMCCLIENT_CATEGORY = HRESULT(0x00000002);
enum HRESULT WDSMCS_E_SESSION_SHUTDOWN_IN_PROGRESS = HRESULT(0xc1210100);
enum HRESULT WDSMCS_E_REQCALLBACKS_NOT_REG = HRESULT(0xc1210101);
enum HRESULT WDSMCS_E_INCOMPATIBLE_VERSION = HRESULT(0xc1210102);
enum HRESULT WDSMCS_E_CONTENT_NOT_FOUND = HRESULT(0xc1210103);
enum HRESULT WDSMCS_E_CLIENT_NOT_FOUND = HRESULT(0xc1210104);
enum HRESULT WDSMCS_E_NAMESPACE_NOT_FOUND = HRESULT(0xc1210105);
enum HRESULT WDSMCS_E_CONTENT_PROVIDER_NOT_FOUND = HRESULT(0xc1210106);

enum : HRESULT
{
    WDSMCS_E_NAMESPACE_ALREADY_EXISTS       = HRESULT(0xc1210107),
    WDSMCS_E_NAMESPACE_SHUTDOWN_IN_PROGRESS = HRESULT(0xc1210108),
    WDSMCS_E_NAMESPACE_ALREADY_STARTED      = HRESULT(0xc1210109),
}

enum HRESULT WDSMCS_E_NS_START_FAILED_NO_CLIENTS = HRESULT(0xc121010a);
enum HRESULT WDSMCS_E_START_TIME_IN_PAST = HRESULT(0xc121010b);

enum : HRESULT
{
    WDSMCS_E_PACKET_NOT_HASHED     = HRESULT(0xc121010c),
    WDSMCS_E_PACKET_NOT_SIGNED     = HRESULT(0xc121010d),
    WDSMCS_E_PACKET_HAS_SECURITY   = HRESULT(0xc121010e),
    WDSMCS_E_PACKET_NOT_CHECKSUMED = HRESULT(0xc121010f),
}

enum HRESULT WDSMCS_E_CLIENT_DOESNOT_SUPPORT_SECURITY_MODE = HRESULT(0xc1210110);
enum HRESULT EVT_WDSMCS_S_PARAMETERS_READ = HRESULT(0x41210200);
enum HRESULT EVT_WDSMCS_E_PARAMETERS_READ_FAILED = HRESULT(0xc1210201);
enum HRESULT EVT_WDSMCS_E_DUPLICATE_MULTICAST_ADDR = HRESULT(0xc1210202);
enum HRESULT EVT_WDSMCS_E_NON_WDS_DUPLICATE_MULTICAST_ADDR = HRESULT(0xc1210203);

enum : HRESULT
{
    EVT_WDSMCS_E_CP_DLL_LOAD_FAILED             = HRESULT(0xc1210250),
    EVT_WDSMCS_E_CP_INIT_FUNC_MISSING           = HRESULT(0xc1210251),
    EVT_WDSMCS_E_CP_INIT_FUNC_FAILED            = HRESULT(0xc1210252),
    EVT_WDSMCS_E_CP_INCOMPATIBLE_SERVER_VERSION = HRESULT(0xc1210253),
}

enum : HRESULT
{
    EVT_WDSMCS_E_CP_CALLBACKS_NOT_REG     = HRESULT(0xc1210254),
    EVT_WDSMCS_E_CP_SHUTDOWN_FUNC_FAILED  = HRESULT(0xc1210255),
    EVT_WDSMCS_E_CP_MEMORY_LEAK           = HRESULT(0xc1210256),
    EVT_WDSMCS_E_CP_OPEN_INSTANCE_FAILED  = HRESULT(0xc1210257),
    EVT_WDSMCS_E_CP_CLOSE_INSTANCE_FAILED = HRESULT(0xc1210258),
    EVT_WDSMCS_E_CP_OPEN_CONTENT_FAILED   = HRESULT(0xc1210259),
}

enum HRESULT EVT_WDSMCS_W_CP_DLL_LOAD_FAILED_NOT_CRITICAL = HRESULT(0x8121025a);
enum HRESULT EVT_WDSMCS_E_CP_DLL_LOAD_FAILED_CRITICAL = HRESULT(0xc121025b);

enum : HRESULT
{
    EVT_WDSMCS_E_NSREG_START_TIME_IN_PAST       = HRESULT(0xc1210300),
    EVT_WDSMCS_E_NSREG_CONTENT_PROVIDER_NOT_REG = HRESULT(0xc1210301),
    EVT_WDSMCS_E_NSREG_NAMESPACE_EXISTS         = HRESULT(0xc1210302),
    EVT_WDSMCS_E_NSREG_FAILURE                  = HRESULT(0xc1210303),
}

enum HRESULT WDSTPC_E_CALLBACKS_NOT_REG = HRESULT(0xc1220300);

enum : HRESULT
{
    WDSTPC_E_ALREADY_COMPLETED   = HRESULT(0xc1220301),
    WDSTPC_E_ALREADY_IN_PROGRESS = HRESULT(0xc1220302),
}

enum : HRESULT
{
    WDSTPC_E_UNKNOWN_ERROR   = HRESULT(0xc1220303),
    WDSTPC_E_NOT_INITIALIZED = HRESULT(0xc1220304),
}

enum : HRESULT
{
    WDSTPC_E_KICKED_POLICY_NOT_MET = HRESULT(0xc1220305),
    WDSTPC_E_KICKED_FALLBACK       = HRESULT(0xc1220306),
    WDSTPC_E_KICKED_FAIL           = HRESULT(0xc1220307),
    WDSTPC_E_KICKED_UNKNOWN        = HRESULT(0xc1220308),
}

enum HRESULT WDSTPC_E_MULTISTREAM_NOT_ENABLED = HRESULT(0xc1220309);
enum HRESULT WDSTPC_E_ALREADY_IN_LOWEST_SESSION = HRESULT(0xc122030a);
enum HRESULT WDSTPC_E_CLIENT_DEMOTE_NOT_SUPPORTED = HRESULT(0xc122030b);
enum HRESULT WDSTPC_E_NO_IP4_INTERFACE = HRESULT(0xc122030c);
enum HRESULT WDSTPTC_E_WIM_APPLY_REQUIRES_REFERENCE_IMAGE = HRESULT(0xc122030d);
enum uint FACILITY_WDSTPTMGMT = 0x00000110U;

enum : HRESULT
{
    WDSTPTMGMT_CATEGORY                              = HRESULT(0x00000001),
    WDSTPTMGMT_E_INVALID_PROPERTY                    = HRESULT(0xc1100100),
    WDSTPTMGMT_E_INVALID_OPERATION                   = HRESULT(0xc1100101),
    WDSTPTMGMT_E_INVALID_CLASS                       = HRESULT(0xc1100102),
    WDSTPTMGMT_E_CONTENT_PROVIDER_ALREADY_REGISTERED = HRESULT(0xc1100103),
    WDSTPTMGMT_E_CONTENT_PROVIDER_NOT_REGISTERED     = HRESULT(0xc1100104),
}

enum HRESULT WDSTPTMGMT_E_INVALID_CONTENT_PROVIDER_NAME = HRESULT(0xc1100105);
enum HRESULT WDSTPTMGMT_E_TRANSPORT_SERVER_ROLE_NOT_CONFIGURED = HRESULT(0xc1100106);

enum : HRESULT
{
    WDSTPTMGMT_E_NAMESPACE_ALREADY_REGISTERED = HRESULT(0xc1100107),
    WDSTPTMGMT_E_NAMESPACE_NOT_REGISTERED     = HRESULT(0xc1100108),
}

enum HRESULT WDSTPTMGMT_E_CANNOT_REINITIALIZE_OBJECT = HRESULT(0xc1100109);

enum : HRESULT
{
    WDSTPTMGMT_E_INVALID_NAMESPACE_NAME = HRESULT(0xc110010a),
    WDSTPTMGMT_E_INVALID_NAMESPACE_DATA = HRESULT(0xc110010b),
}

enum : HRESULT
{
    WDSTPTMGMT_E_NAMESPACE_READ_ONLY            = HRESULT(0xc110010c),
    WDSTPTMGMT_E_INVALID_NAMESPACE_START_TIME   = HRESULT(0xc110010d),
    WDSTPTMGMT_E_INVALID_DIAGNOSTICS_COMPONENTS = HRESULT(0xc110010e),
}

enum HRESULT WDSTPTMGMT_E_CANNOT_REFRESH_DIRTY_OBJECT = HRESULT(0xc110010f);

enum : HRESULT
{
    WDSTPTMGMT_E_INVALID_SERVICE_IP_ADDRESS_RANGE   = HRESULT(0xc1100110),
    WDSTPTMGMT_E_INVALID_SERVICE_PORT_RANGE         = HRESULT(0xc1100111),
    WDSTPTMGMT_E_INVALID_NAMESPACE_START_PARAMETERS = HRESULT(0xc1100112),
}

enum HRESULT WDSTPTMGMT_E_TRANSPORT_SERVER_UNAVAILABLE = HRESULT(0xc1100113);

enum : HRESULT
{
    WDSTPTMGMT_E_NAMESPACE_NOT_ON_SERVER       = HRESULT(0xc1100114),
    WDSTPTMGMT_E_NAMESPACE_REMOVED_FROM_SERVER = HRESULT(0xc1100115),
}

enum : HRESULT
{
    WDSTPTMGMT_E_INVALID_IP_ADDRESS             = HRESULT(0xc1100116),
    WDSTPTMGMT_E_INVALID_IPV4_MULTICAST_ADDRESS = HRESULT(0xc1100117),
    WDSTPTMGMT_E_INVALID_IPV6_MULTICAST_ADDRESS = HRESULT(0xc1100118),
}

enum : HRESULT
{
    WDSTPTMGMT_E_IPV6_NOT_SUPPORTED                    = HRESULT(0xc1100119),
    WDSTPTMGMT_E_INVALID_IPV6_MULTICAST_ADDRESS_SOURCE = HRESULT(0xc110011a),
    WDSTPTMGMT_E_INVALID_MULTISTREAM_STREAM_COUNT      = HRESULT(0xc110011b),
    WDSTPTMGMT_E_INVALID_AUTO_DISCONNECT_THRESHOLD     = HRESULT(0xc110011c),
}

enum HRESULT WDSTPTMGMT_E_MULTICAST_SESSION_POLICY_NOT_SUPPORTED = HRESULT(0xc110011d);
enum HRESULT WDSTPTMGMT_E_INVALID_SLOW_CLIENT_HANDLING_TYPE = HRESULT(0xc110011e);
enum HRESULT WDSTPTMGMT_E_NETWORK_PROFILES_NOT_SUPPORTED = HRESULT(0xc110011f);
enum HRESULT WDSTPTMGMT_E_UDP_PORT_POLICY_NOT_SUPPORTED = HRESULT(0xc1100120);
enum HRESULT WDSTPTMGMT_E_TFTP_MAX_BLOCKSIZE_NOT_SUPPORTED = HRESULT(0xc1100121);
enum HRESULT WDSTPTMGMT_E_TFTP_VAR_WINDOW_NOT_SUPPORTED = HRESULT(0xc1100122);
enum HRESULT WDSTPTMGMT_E_INVALID_TFTP_MAX_BLOCKSIZE = HRESULT(0xc1100123);

enum : int
{
    WdsCliFlagEnumFilterVersion  = 0x00000001,
    WdsCliFlagEnumFilterFirmware = 0x00000002,
}

enum : int
{
    WDS_LOG_TYPE_CLIENT_ERROR                            = 0x00000001,
    WDS_LOG_TYPE_CLIENT_STARTED                          = 0x00000002,
    WDS_LOG_TYPE_CLIENT_FINISHED                         = 0x00000003,
    WDS_LOG_TYPE_CLIENT_IMAGE_SELECTED                   = 0x00000004,
    WDS_LOG_TYPE_CLIENT_APPLY_STARTED                    = 0x00000005,
    WDS_LOG_TYPE_CLIENT_APPLY_FINISHED                   = 0x00000006,
    WDS_LOG_TYPE_CLIENT_GENERIC_MESSAGE                  = 0x00000007,
    WDS_LOG_TYPE_CLIENT_UNATTEND_MODE                    = 0x00000008,
    WDS_LOG_TYPE_CLIENT_TRANSFER_START                   = 0x00000009,
    WDS_LOG_TYPE_CLIENT_TRANSFER_END                     = 0x0000000a,
    WDS_LOG_TYPE_CLIENT_TRANSFER_DOWNGRADE               = 0x0000000b,
    WDS_LOG_TYPE_CLIENT_DOMAINJOINERROR                  = 0x0000000c,
    WDS_LOG_TYPE_CLIENT_POST_ACTIONS_START               = 0x0000000d,
    WDS_LOG_TYPE_CLIENT_POST_ACTIONS_END                 = 0x0000000e,
    WDS_LOG_TYPE_CLIENT_APPLY_STARTED_2                  = 0x0000000f,
    WDS_LOG_TYPE_CLIENT_APPLY_FINISHED_2                 = 0x00000010,
    WDS_LOG_TYPE_CLIENT_DOMAINJOINERROR_2                = 0x00000011,
    WDS_LOG_TYPE_CLIENT_DRIVER_PACKAGE_NOT_ACCESSIBLE    = 0x00000012,
    WDS_LOG_TYPE_CLIENT_OFFLINE_DRIVER_INJECTION_START   = 0x00000013,
    WDS_LOG_TYPE_CLIENT_OFFLINE_DRIVER_INJECTION_END     = 0x00000014,
    WDS_LOG_TYPE_CLIENT_OFFLINE_DRIVER_INJECTION_FAILURE = 0x00000015,
}

enum : int
{
    WDS_LOG_TYPE_CLIENT_IMAGE_SELECTED2 = 0x00000016,
    WDS_LOG_TYPE_CLIENT_IMAGE_SELECTED3 = 0x00000017,
    WDS_LOG_TYPE_CLIENT_MAX_CODE        = 0x00000018,
}

enum : int
{
    WDS_LOG_LEVEL_DISABLED = 0x00000000,
    WDS_LOG_LEVEL_ERROR    = 0x00000001,
    WDS_LOG_LEVEL_WARNING  = 0x00000002,
    WDS_LOG_LEVEL_INFO     = 0x00000003,
}

// Callbacks

alias PFN_WdsCliTraceFunction = void function(const(PWSTR) pwszFormat, byte* Params);
alias PFN_WdsCliCallback = void function(PFN_WDS_CLI_CALLBACK_MESSAGE_ID dwMessageId, WPARAM wParam, LPARAM lParam, 
                                         void* pvUserData);
alias PFN_WdsTransportClientSessionStart = void function(HANDLE hSessionKey, void* pCallerData, ulong* ullFileSize);
alias PFN_WdsTransportClientSessionStartEx = void function(HANDLE hSessionKey, void* pCallerData, 
                                                           TRANSPORTCLIENT_SESSION_INFO* Info);
alias PFN_WdsTransportClientReceiveMetadata = void function(HANDLE hSessionKey, void* pCallerData, 
                                                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pMetadata, 
                                                            uint ulSize);
alias PFN_WdsTransportClientReceiveContents = void function(HANDLE hSessionKey, void* pCallerData, 
                                                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pContents, 
                                                            uint ulSize, ulong* pullContentOffset);
alias PFN_WdsTransportClientSessionComplete = void function(HANDLE hSessionKey, void* pCallerData, uint dwError);
alias PFN_WdsTransportClientSessionNegotiate = void function(HANDLE hSessionKey, void* pCallerData, 
                                                             TRANSPORTCLIENT_SESSION_INFO* pInfo, 
                                                             HANDLE hNegotiateKey);

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdsclientapi/ns-wdsclientapi-wds_cli_cred
struct WDS_CLI_CRED
{
    const(PWSTR) pwszUserName;
    const(PWSTR) pwszDomain;
    const(PWSTR) pwszPassword;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdspxe/ns-wdspxe-pxe_dhcp_option
struct PXE_DHCP_OPTION
{
align (1):
    ubyte OptionType;
    ubyte OptionLength;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] OptionValue;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdspxe/ns-wdspxe-pxe_dhcp_message
struct PXE_DHCP_MESSAGE
{
align (1):
    ubyte           Operation;
    ubyte           HardwareAddressType;
    ubyte           HardwareAddressLength;
    ubyte           HopCount;
    uint            TransactionID;
    ushort          SecondsSinceBoot;
    ushort          Reserved;
    uint            ClientIpAddress;
    uint            YourIpAddress;
    uint            BootstrapServerAddress;
    uint            RelayAgentIpAddress;
    ubyte[16]       HardwareAddress;
    ubyte[64]       HostName;
    ubyte[128]      BootFileName;
    union
    {
    align (1):
        ubyte[4] bMagicCookie;
        uint     uMagicCookie;
    }
    PXE_DHCP_OPTION Option;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdspxe/ns-wdspxe-pxe_dhcpv6_option
struct PXE_DHCPV6_OPTION
{
align (1):
    ushort OptionCode;
    ushort DataLength;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] Data;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdspxe/ns-wdspxe-pxe_dhcpv6_message_header
struct PXE_DHCPV6_MESSAGE_HEADER
{
align (1):
    ubyte MessageType;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] Message;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdspxe/ns-wdspxe-pxe_dhcpv6_message
struct PXE_DHCPV6_MESSAGE
{
align (1):
    ubyte MessageType;
    ubyte TransactionIDByte1;
    ubyte TransactionIDByte2;
    ubyte TransactionIDByte3;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/PXE_DHCPV6_OPTION[1] Options;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdspxe/ns-wdspxe-pxe_dhcpv6_relay_message
struct PXE_DHCPV6_RELAY_MESSAGE
{
align (1):
    ubyte     MessageType;
    ubyte     HopCount;
    ubyte[16] LinkAddress;
    ubyte[16] PeerAddress;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/PXE_DHCPV6_OPTION[1] Options;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdspxe/ns-wdspxe-pxe_provider
struct PXE_PROVIDER
{
    uint  uSizeOfStruct;
    PWSTR pwszName;
    PWSTR pwszFilePath;
    BOOL  bIsCritical;
    uint  uIndex;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdspxe/ns-wdspxe-pxe_address
struct PXE_ADDRESS
{
    uint   uFlags;
    union
    {
        ubyte[16] bAddress;
        uint      uIpAddress;
    }
    uint   uAddrLen;
    ushort uPort;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdspxe/ns-wdspxe-pxe_dhcpv6_nested_relay_message
struct PXE_DHCPV6_NESTED_RELAY_MESSAGE
{
    PXE_DHCPV6_RELAY_MESSAGE* pRelayMessage;
    uint   cbRelayMessage;
    void*  pInterfaceIdOption;
    ushort cbInterfaceIdOption;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstpdi/ns-wdstpdi-wds_transportprovider_init_params
struct WDS_TRANSPORTPROVIDER_INIT_PARAMS
{
    uint   ulLength;
    uint   ulMcServerVersion;
    HKEY   hRegistryKey;
    HANDLE hProvider;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstpdi/ns-wdstpdi-wds_transportprovider_settings
struct WDS_TRANSPORTPROVIDER_SETTINGS
{
    uint ulLength;
    uint ulProviderVersion;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstci/ns-wdstci-transportclient_session_info
struct TRANSPORTCLIENT_SESSION_INFO
{
    uint  ulStructureLength;
    ulong ullFileSize;
    uint  ulBlockSize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstci/ns-wdstci-wds_transportclient_request
struct WDS_TRANSPORTCLIENT_REQUEST
{
    uint         ulLength;
    uint         ulApiVersion;
    WDS_TRANSPORTCLIENT_REQUEST_AUTH_LEVEL ulAuthLevel;
    const(PWSTR) pwszServer;
    const(PWSTR) pwszNamespace;
    const(PWSTR) pwszObjectName;
    uint         ulCacheSize;
    uint         ulProtocol;
    void*        pvProtocolData;
    uint         ulProtocolDataLength;
}

struct WDS_TRANSPORTCLIENT_CALLBACKS
{
    PFN_WdsTransportClientSessionStart SessionStart;
    PFN_WdsTransportClientSessionStartEx SessionStartEx;
    PFN_WdsTransportClientReceiveContents ReceiveContents;
    PFN_WdsTransportClientReceiveMetadata ReceiveMetadata;
    PFN_WdsTransportClientSessionComplete SessionComplete;
    PFN_WdsTransportClientSessionNegotiate SessionNegotiate;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliClose(HANDLE Handle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliRegisterTrace(PFN_WdsCliTraceFunction pfn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliFreeStringArray(PWSTR* ppwszArray, uint ulCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliFindFirstImage(HANDLE hSession, HANDLE* phFindHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliFindNextImage(HANDLE Handle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliGetEnumerationFlags(HANDLE Handle, uint* pdwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliGetImageHandleFromFindHandle(HANDLE FindHandle, HANDLE* phImageHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliGetImageHandleFromTransferHandle(HANDLE hTransfer, HANDLE* phImageHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliCreateSession(PWSTR pwszServer, WDS_CLI_CRED* pCred, HANDLE* phSession);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliAuthorizeSession(HANDLE hSession, WDS_CLI_CRED* pCred);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliInitializeLog(HANDLE hSession, CPU_ARCHITECTURE ulClientArchitecture, PWSTR pwszClientId, 
                            PWSTR pwszClientAddress);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliLog(HANDLE hSession, uint ulLogLevel, uint ulMessageCode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliGetImageName(HANDLE hIfh, PWSTR* ppwszValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliGetImageDescription(HANDLE hIfh, PWSTR* ppwszValue);

@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliGetImageType(HANDLE hIfh, WDS_CLI_IMAGE_TYPE* pImageType);

@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliGetImageFiles(HANDLE hIfh, PWSTR** pppwszFiles, uint* pdwCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliGetImageLanguage(HANDLE hIfh, PWSTR* ppwszValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliGetImageLanguages(HANDLE hIfh, byte*** pppszValues, uint* pdwNumValues);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliGetImageVersion(HANDLE hIfh, PWSTR* ppwszValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliGetImagePath(HANDLE hIfh, PWSTR* ppwszValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliGetImageIndex(HANDLE hIfh, uint* pdwValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliGetImageArchitecture(HANDLE hIfh, CPU_ARCHITECTURE* pdwValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliGetImageLastModifiedTime(HANDLE hIfh, SYSTEMTIME** ppSysTimeValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliGetImageSize(HANDLE hIfh, ulong* pullValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliGetImageHalName(HANDLE hIfh, PWSTR* ppwszValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliGetImageGroup(HANDLE hIfh, PWSTR* ppwszValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliGetImageNamespace(HANDLE hIfh, PWSTR* ppwszValue);

@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliGetImageParameter(HANDLE hIfh, WDS_CLI_IMAGE_PARAM_TYPE ParamType, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pResponse, 
                                uint uResponseLen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliGetTransferSize(HANDLE hIfh, ulong* pullValue);

@DllImport("WDSCLIENTAPI.dll")
void WdsCliSetTransferBufferSize(uint ulSizeInBytes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliTransferImage(HANDLE hImage, PWSTR pwszLocalPath, uint dwFlags, uint dwReserved, 
                            PFN_WdsCliCallback pfnWdsCliCallback, void* pvUserData, HANDLE* phTransfer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliTransferFile(const(PWSTR) pwszServer, const(PWSTR) pwszNamespace, const(PWSTR) pwszRemoteFilePath, 
                           const(PWSTR) pwszLocalFilePath, uint dwFlags, uint dwReserved, 
                           PFN_WdsCliCallback pfnWdsCliCallback, void* pvUserData, HANDLE* phTransfer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliCancelTransfer(HANDLE hTransfer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliWaitForTransfer(HANDLE hTransfer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliObtainDriverPackages(HANDLE hImage, PWSTR* ppwszServerName, PWSTR** pppwszDriverPackages, 
                                   uint* pulCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliObtainDriverPackagesEx(HANDLE hSession, PWSTR pwszMachineInfo, PWSTR* ppwszServerName, 
                                     PWSTR** pppwszDriverPackages, uint* pulCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliGetDriverQueryXml(PWSTR pwszWinDirPath, PWSTR* ppwszDriverQuery);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("WDSPXE.dll")
uint PxeProviderRegister(const(PWSTR) pszProviderName, const(PWSTR) pszModulePath, uint Index, BOOL bIsCritical, 
                         HKEY* phProviderKey);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("WDSPXE.dll")
uint PxeProviderUnRegister(const(PWSTR) pszProviderName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("WDSPXE.dll")
uint PxeProviderQueryIndex(const(PWSTR) pszProviderName, uint* puIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("WDSPXE.dll")
uint PxeProviderEnumFirst(HANDLE* phEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("WDSPXE.dll")
uint PxeProviderEnumNext(HANDLE hEnum, PXE_PROVIDER** ppProvider);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("WDSPXE.dll")
uint PxeProviderEnumClose(HANDLE hEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("WDSPXE.dll")
uint PxeProviderFreeInfo(PXE_PROVIDER* pProvider);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("WDSPXE.dll")
uint PxeRegisterCallback(HANDLE hProvider, uint CallbackType, void* pCallbackFunction, void* pContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("WDSPXE.dll")
uint PxeSendReply(HANDLE hClientRequest, 
                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pPacket, 
                  uint uPacketLen, PXE_ADDRESS* pAddress);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("WDSPXE.dll")
uint PxeAsyncRecvDone(HANDLE hClientRequest, uint Action);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("WDSPXE.dll")
uint PxeTrace(HANDLE hProvider, uint Severity, const(PWSTR) pszFormat);

@DllImport("WDSPXE.dll")
uint PxeTraceV(HANDLE hProvider, uint Severity, const(PWSTR) pszFormat, byte* Params);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("WDSPXE.dll")
void* PxePacketAllocate(HANDLE hProvider, HANDLE hClientRequest, uint uSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("WDSPXE.dll")
uint PxePacketFree(HANDLE hProvider, HANDLE hClientRequest, void* pPacket);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("WDSPXE.dll")
uint PxeProviderSetAttribute(HANDLE hProvider, uint Attribute, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pParameterBuffer, 
                             uint uParamLen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("WDSPXE.dll")
uint PxeDhcpInitialize(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* pRecvPacket, 
                       uint uRecvPacketLen, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pReplyPacket, 
                       uint uMaxReplyPacketLen, uint* puReplyPacketLen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("WDSPXE.dll")
uint PxeDhcpv6Initialize(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* pRequest, 
                         uint cbRequest, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pReply, 
                         uint cbReply, uint* pcbReplyUsed);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("WDSPXE.dll")
uint PxeDhcpAppendOption(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* pReplyPacket, 
                         uint uMaxReplyPacketLen, uint* puReplyPacketLen, ubyte bOption, ubyte bOptionLen, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* pValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("WDSPXE.dll")
uint PxeDhcpv6AppendOption(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* pReply, 
                           uint cbReply, uint* pcbReplyUsed, ushort wOptionType, ushort cbOption, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* pOption);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("WDSPXE.dll")
uint PxeDhcpAppendOptionRaw(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* pReplyPacket, 
                            uint uMaxReplyPacketLen, uint* puReplyPacketLen, ushort uBufferLen, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("WDSPXE.dll")
uint PxeDhcpv6AppendOptionRaw(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* pReply, 
                              uint cbReply, uint* pcbReplyUsed, ushort cbBuffer, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("WDSPXE.dll")
uint PxeDhcpIsValid(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* pPacket, 
                    uint uPacketLen, BOOL bRequestPacket, BOOL* pbPxeOptionPresent);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("WDSPXE.dll")
uint PxeDhcpv6IsValid(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* pPacket, 
                      uint uPacketLen, BOOL bRequestPacket, BOOL* pbPxeOptionPresent);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("WDSPXE.dll")
uint PxeDhcpGetOptionValue(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* pPacket, 
                           uint uPacketLen, uint uInstance, ubyte bOption, ubyte* pbOptionLen, void** ppOptionValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("WDSPXE.dll")
uint PxeDhcpv6GetOptionValue(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* pPacket, 
                             uint uPacketLen, uint uInstance, ushort wOption, ushort* pwOptionLen, 
                             void** ppOptionValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("WDSPXE.dll")
uint PxeDhcpGetVendorOptionValue(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* pPacket, 
                                 uint uPacketLen, ubyte bOption, uint uInstance, ubyte* pbOptionLen, 
                                 void** ppOptionValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("WDSPXE.dll")
uint PxeDhcpv6GetVendorOptionValue(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* pPacket, 
                                   uint uPacketLen, uint dwEnterpriseNumber, ushort wOption, uint uInstance, 
                                   ushort* pwOptionLen, void** ppOptionValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("WDSPXE.dll")
uint PxeDhcpv6ParseRelayForw(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* pRelayForwPacket, 
                             uint uRelayForwPacketLen, PXE_DHCPV6_NESTED_RELAY_MESSAGE* pRelayMessages, 
                             uint nRelayMessages, uint* pnRelayMessages, ubyte** ppInnerPacket, uint* pcbInnerPacket);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("WDSPXE.dll")
uint PxeDhcpv6CreateRelayRepl(PXE_DHCPV6_NESTED_RELAY_MESSAGE* pRelayMessages, uint nRelayMessages, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* pInnerPacket, 
                              uint cbInnerPacket, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* pReplyBuffer, 
                              uint cbReplyBuffer, uint* pcbReplyBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("WDSPXE.dll")
uint PxeGetServerInfo(uint uInfoType, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pBuffer, 
                      uint uBufferLen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("WDSPXE.dll")
uint PxeGetServerInfoEx(uint uInfoType, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pBuffer, 
                        uint uBufferLen, uint* puBufferUsed);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("WDSMC.dll")
HRESULT WdsTransportServerRegisterCallback(HANDLE hProvider, TRANSPORTPROVIDER_CALLBACK_ID CallbackId, 
                                           void* pfnCallback);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("WDSMC.dll")
HRESULT WdsTransportServerCompleteRead(HANDLE hProvider, uint ulBytesRead, void* pvUserData, HRESULT hReadResult);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("WDSMC.dll")
HRESULT WdsTransportServerTrace(HANDLE hProvider, uint Severity, const(PWSTR) pwszFormat);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("WDSMC.dll")
HRESULT WdsTransportServerTraceV(HANDLE hProvider, uint Severity, const(PWSTR) pwszFormat, byte* Params);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("WDSMC.dll")
void* WdsTransportServerAllocateBuffer(HANDLE hProvider, uint ulBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("WDSMC.dll")
HRESULT WdsTransportServerFreeBuffer(HANDLE hProvider, void* pvBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WDSTPTC.dll")
uint WdsTransportClientInitialize();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WDSTPTC.dll")
uint WdsTransportClientInitializeSession(WDS_TRANSPORTCLIENT_REQUEST* pSessionRequest, void* pCallerData, 
                                         HANDLE* hSessionKey);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WDSTPTC.dll")
uint WdsTransportClientRegisterCallback(HANDLE hSessionKey, TRANSPORTCLIENT_CALLBACK_ID CallbackId, 
                                        void* pfnCallback);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WDSTPTC.dll")
uint WdsTransportClientStartSession(HANDLE hSessionKey);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WDSTPTC.dll")
uint WdsTransportClientCompleteReceive(HANDLE hSessionKey, uint ulSize, ulong* pullOffset);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WDSTPTC.dll")
uint WdsTransportClientCancelSession(HANDLE hSessionKey);

@DllImport("WDSTPTC.dll")
uint WdsTransportClientCancelSessionEx(HANDLE hSessionKey, uint dwErrorCode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WDSTPTC.dll")
uint WdsTransportClientWaitForCompletion(HANDLE hSessionKey, uint uTimeout);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WDSTPTC.dll")
uint WdsTransportClientQueryStatus(HANDLE hSessionKey, uint* puStatus, uint* puErrorCode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WDSTPTC.dll")
uint WdsTransportClientCloseSession(HANDLE hSessionKey);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WDSTPTC.dll")
uint WdsTransportClientAddRefBuffer(void* pvBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WDSTPTC.dll")
uint WdsTransportClientReleaseBuffer(void* pvBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WDSTPTC.dll")
uint WdsTransportClientShutdown();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WDSBP.dll")
uint WdsBpParseInitialize(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* pPacket, 
                          uint uPacketLen, ubyte* pbPacketType, HANDLE* phHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("WDSBP.dll")
uint WdsBpParseInitializev6(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* pPacket, 
                            uint uPacketLen, ubyte* pbPacketType, HANDLE* phHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WDSBP.dll")
uint WdsBpInitialize(ubyte bPacketType, HANDLE* phHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WDSBP.dll")
uint WdsBpCloseHandle(HANDLE hHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WDSBP.dll")
uint WdsBpQueryOption(HANDLE hHandle, uint uOption, uint uValueLen, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pValue, 
                      uint* puBytes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WDSBP.dll")
uint WdsBpAddOption(HANDLE hHandle, uint uOption, uint uValueLen, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WDSBP.dll")
uint WdsBpGetOptionBuffer(HANDLE hHandle, uint uBufferLen, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* pBuffer, 
                          uint* puBytes);


// Interfaces

@GUID("70590b16-f146-46bd-bd9d-4aaa90084bf5")
struct WdsTransportCacheable;

@GUID("c7f18b09-391e-436e-b10b-c3ef46f2c34f")
struct WdsTransportCollection;

@GUID("f21523f6-837c-4a58-af99-8a7e27f8ff59")
struct WdsTransportManager;

@GUID("ea19b643-4adf-4413-942c-14f379118760")
struct WdsTransportServer;

@GUID("c7beeaad-9f04-4923-9f0c-fbf52bc7590f")
struct WdsTransportSetupManager;

@GUID("8743f674-904c-47ca-8512-35fe98f6b0ac")
struct WdsTransportConfigurationManager;

@GUID("f08cdb63-85de-4a28-a1a9-5ca3e7efda73")
struct WdsTransportNamespaceManager;

@GUID("65aceadc-2f0b-4f43-9f4d-811865d8cead")
struct WdsTransportServicePolicy;

@GUID("eb3333e1-a7ad-46f5-80d6-6b740204e509")
struct WdsTransportDiagnosticsPolicy;

@GUID("3c6bc3f4-6418-472a-b6f1-52d457195437")
struct WdsTransportMulticastSessionPolicy;

@GUID("d8385768-0732-4ec1-95ea-16da581908a1")
struct WdsTransportNamespace;

@GUID("b091f5a8-6a99-478d-b23b-09e8fee04574")
struct WdsTransportNamespaceAutoCast;

@GUID("badc1897-7025-44eb-9108-fb61c4055792")
struct WdsTransportNamespaceScheduledCast;

@GUID("d3e1a2aa-caac-460e-b98a-47f9f318a1fa")
struct WdsTransportNamespaceScheduledCastManualStart;

@GUID("a1107052-122c-4b81-9b7c-386e6855383f")
struct WdsTransportNamespaceScheduledCastAutoStart;

@GUID("0a891fe7-4a3f-4c65-b6f2-1467619679ea")
struct WdsTransportContent;

@GUID("749ac4e0-67bc-4743-bfe5-cacb1f26f57f")
struct WdsTransportSession;

@GUID("66d2c5e9-0ff6-49ec-9733-dafb1e01df1c")
struct WdsTransportClient;

@GUID("50343925-7c5c-4c8c-96c4-ad9fa5005fba")
struct WdsTransportTftpClient;

@GUID("c8e9dca2-3241-4e4d-b806-bc74019dfeda")
struct WdsTransportTftpManager;

@GUID("e0be741f-5a75-4eb9-8a2d-5e189b45f327")
struct WdsTransportContentProvider;

@GUID("46ad894b-0bab-47dc-84b2-7b553f1d8f80")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nn-wdstptmgmt-iwdstransportcacheable
interface IWdsTransportCacheable : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportcacheable-get_dirty
    HRESULT get_Dirty(VARIANT_BOOL* pbDirty);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportcacheable-discard
    HRESULT Discard();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportcacheable-refresh
    HRESULT Refresh();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportcacheable-commit
    HRESULT Commit();
}

@GUID("b8ba4b1a-2ff4-43ab-996c-b2b10a91a6eb")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nn-wdstptmgmt-iwdstransportcollection
interface IWdsTransportCollection : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportcollection-get_count
    HRESULT get_Count(uint* pulCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportcollection-get_item
    HRESULT get_Item(uint ulIndex, IDispatch* ppVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportcollection-get__newenum
    HRESULT get__NewEnum(IUnknown* ppVal);
}

@GUID("5b0d35f5-1b13-4afd-b878-6526dc340b5d")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nn-wdstptmgmt-iwdstransportmanager
interface IWdsTransportManager : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportmanager-getwdstransportserver
    HRESULT GetWdsTransportServer(BSTR bszServerName, IWdsTransportServer* ppWdsTransportServer);
}

@GUID("09ccd093-830d-4344-a30a-73ae8e8fca90")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nn-wdstptmgmt-iwdstransportserver
interface IWdsTransportServer : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportserver-get_name
    HRESULT get_Name(BSTR* pbszName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportserver-get_setupmanager
    HRESULT get_SetupManager(IWdsTransportSetupManager* ppWdsTransportSetupManager);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportserver-get_configurationmanager
    HRESULT get_ConfigurationManager(IWdsTransportConfigurationManager* ppWdsTransportConfigurationManager);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportserver-get_namespacemanager
    HRESULT get_NamespaceManager(IWdsTransportNamespaceManager* ppWdsTransportNamespaceManager);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportserver-disconnectclient
    HRESULT DisconnectClient(uint ulClientId, WDSTRANSPORT_DISCONNECT_TYPE DisconnectionType);
}

@GUID("256e999f-6df4-4538-81b9-857b9ab8fb47")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nn-wdstptmgmt-iwdstransportserver2
interface IWdsTransportServer2 : IWdsTransportServer
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportserver2-get_tftpmanager
    HRESULT get_TftpManager(IWdsTransportTftpManager* ppWdsTransportTftpManager);
}

@GUID("f7238425-efa8-40a4-aef9-c98d969c0b75")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nn-wdstptmgmt-iwdstransportsetupmanager
interface IWdsTransportSetupManager : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportsetupmanager-get_version
    HRESULT get_Version(ulong* pullVersion);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportsetupmanager-get_installedfeatures
    HRESULT get_InstalledFeatures(uint* pulInstalledFeatures);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportsetupmanager-get_protocols
    HRESULT get_Protocols(uint* pulProtocols);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportsetupmanager-registercontentprovider
    HRESULT RegisterContentProvider(BSTR bszName, BSTR bszDescription, BSTR bszFilePath, 
                                    BSTR bszInitializationRoutine);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportsetupmanager-deregistercontentprovider
    HRESULT DeregisterContentProvider(BSTR bszName);
}

@GUID("02be79da-7e9e-4366-8b6e-2aa9a91be47f")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nn-wdstptmgmt-iwdstransportsetupmanager2
interface IWdsTransportSetupManager2 : IWdsTransportSetupManager
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportsetupmanager2-get_tftpcapabilities
    HRESULT get_TftpCapabilities(uint* pulTftpCapabilities);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportsetupmanager2-get_contentproviders
    HRESULT get_ContentProviders(IWdsTransportCollection* ppProviderCollection);
}

@GUID("84cc4779-42dd-4792-891e-1321d6d74b44")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nn-wdstptmgmt-iwdstransportconfigurationmanager
interface IWdsTransportConfigurationManager : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportconfigurationmanager-get_servicepolicy
    HRESULT get_ServicePolicy(IWdsTransportServicePolicy* ppWdsTransportServicePolicy);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportconfigurationmanager-get_diagnosticspolicy
    HRESULT get_DiagnosticsPolicy(IWdsTransportDiagnosticsPolicy* ppWdsTransportDiagnosticsPolicy);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportconfigurationmanager-get_wdstransportservicesrunning
    HRESULT get_WdsTransportServicesRunning(VARIANT_BOOL bRealtimeStatus, VARIANT_BOOL* pbServicesRunning);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportconfigurationmanager-enablewdstransportservices
    HRESULT EnableWdsTransportServices();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportconfigurationmanager-disablewdstransportservices
    HRESULT DisableWdsTransportServices();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportconfigurationmanager-startwdstransportservices
    HRESULT StartWdsTransportServices();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportconfigurationmanager-stopwdstransportservices
    HRESULT StopWdsTransportServices();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportconfigurationmanager-restartwdstransportservices
    HRESULT RestartWdsTransportServices();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportconfigurationmanager-notifywdstransportservices
    HRESULT NotifyWdsTransportServices(WDSTRANSPORT_SERVICE_NOTIFICATION ServiceNotification);
}

@GUID("d0d85caf-a153-4f1d-a9dd-96f431c50717")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nn-wdstptmgmt-iwdstransportconfigurationmanager2
interface IWdsTransportConfigurationManager2 : IWdsTransportConfigurationManager
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportconfigurationmanager2-get_multicastsessionpolicy
    HRESULT get_MulticastSessionPolicy(IWdsTransportMulticastSessionPolicy* ppWdsTransportMulticastSessionPolicy);
}

@GUID("3e22d9f6-3777-4d98-83e1-f98696717ba3")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nn-wdstptmgmt-iwdstransportnamespacemanager
interface IWdsTransportNamespaceManager : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportnamespacemanager-createnamespace
    HRESULT CreateNamespace(WDSTRANSPORT_NAMESPACE_TYPE NamespaceType, BSTR bszNamespaceName, 
                            BSTR bszContentProvider, BSTR bszConfiguration, 
                            IWdsTransportNamespace* ppWdsTransportNamespace);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportnamespacemanager-retrievenamespace
    HRESULT RetrieveNamespace(BSTR bszNamespaceName, IWdsTransportNamespace* ppWdsTransportNamespace);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportnamespacemanager-retrievenamespaces
    HRESULT RetrieveNamespaces(BSTR bszContentProvider, BSTR bszNamespaceName, VARIANT_BOOL bIncludeTombstones, 
                               IWdsTransportCollection* ppWdsTransportNamespaces);
}

@GUID("1327a7c8-ae8a-4fb3-8150-136227c37e9a")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nn-wdstptmgmt-iwdstransporttftpmanager
interface IWdsTransportTftpManager : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransporttftpmanager-retrievetftpclients
    HRESULT RetrieveTftpClients(IWdsTransportCollection* ppWdsTransportTftpClients);
}

@GUID("b9468578-9f2b-48cc-b27a-a60799c2750c")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nn-wdstptmgmt-iwdstransportservicepolicy
interface IWdsTransportServicePolicy : IWdsTransportCacheable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportservicepolicy-get_ipaddresssource
    HRESULT get_IpAddressSource(WDSTRANSPORT_IP_ADDRESS_TYPE AddressType, 
                                WDSTRANSPORT_IP_ADDRESS_SOURCE_TYPE* pSourceType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportservicepolicy-put_ipaddresssource
    HRESULT put_IpAddressSource(WDSTRANSPORT_IP_ADDRESS_TYPE AddressType, 
                                WDSTRANSPORT_IP_ADDRESS_SOURCE_TYPE SourceType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportservicepolicy-get_startipaddress
    HRESULT get_StartIpAddress(WDSTRANSPORT_IP_ADDRESS_TYPE AddressType, BSTR* pbszStartIpAddress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportservicepolicy-put_startipaddress
    HRESULT put_StartIpAddress(WDSTRANSPORT_IP_ADDRESS_TYPE AddressType, BSTR bszStartIpAddress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportservicepolicy-get_endipaddress
    HRESULT get_EndIpAddress(WDSTRANSPORT_IP_ADDRESS_TYPE AddressType, BSTR* pbszEndIpAddress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportservicepolicy-put_endipaddress
    HRESULT put_EndIpAddress(WDSTRANSPORT_IP_ADDRESS_TYPE AddressType, BSTR bszEndIpAddress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportservicepolicy-get_startport
    HRESULT get_StartPort(uint* pulStartPort);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportservicepolicy-put_startport
    HRESULT put_StartPort(uint ulStartPort);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportservicepolicy-get_endport
    HRESULT get_EndPort(uint* pulEndPort);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportservicepolicy-put_endport
    HRESULT put_EndPort(uint ulEndPort);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportservicepolicy-get_networkprofile
    HRESULT get_NetworkProfile(WDSTRANSPORT_NETWORK_PROFILE_TYPE* pProfileType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportservicepolicy-put_networkprofile
    HRESULT put_NetworkProfile(WDSTRANSPORT_NETWORK_PROFILE_TYPE ProfileType);
}

@GUID("65c19e5c-aa7e-4b91-8944-91e0e5572797")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nn-wdstptmgmt-iwdstransportservicepolicy2
interface IWdsTransportServicePolicy2 : IWdsTransportServicePolicy
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportservicepolicy2-get_udpportpolicy
    HRESULT get_UdpPortPolicy(WDSTRANSPORT_UDP_PORT_POLICY* pUdpPortPolicy);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportservicepolicy2-put_udpportpolicy
    HRESULT put_UdpPortPolicy(WDSTRANSPORT_UDP_PORT_POLICY UdpPortPolicy);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportservicepolicy2-get_tftpmaximumblocksize
    HRESULT get_TftpMaximumBlockSize(uint* pulTftpMaximumBlockSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportservicepolicy2-put_tftpmaximumblocksize
    HRESULT put_TftpMaximumBlockSize(uint ulTftpMaximumBlockSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportservicepolicy2-get_enabletftpvariablewindowextension
    HRESULT get_EnableTftpVariableWindowExtension(VARIANT_BOOL* pbEnableTftpVariableWindowExtension);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportservicepolicy2-put_enabletftpvariablewindowextension
    HRESULT put_EnableTftpVariableWindowExtension(VARIANT_BOOL bEnableTftpVariableWindowExtension);
}

@GUID("13b33efc-7856-4f61-9a59-8de67b6b87b6")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nn-wdstptmgmt-iwdstransportdiagnosticspolicy
interface IWdsTransportDiagnosticsPolicy : IWdsTransportCacheable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportdiagnosticspolicy-get_enabled
    HRESULT get_Enabled(VARIANT_BOOL* pbEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportdiagnosticspolicy-put_enabled
    HRESULT put_Enabled(VARIANT_BOOL bEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportdiagnosticspolicy-get_components
    HRESULT get_Components(uint* pulComponents);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportdiagnosticspolicy-put_components
    HRESULT put_Components(uint ulComponents);
}

@GUID("4e5753cf-68ec-4504-a951-4a003266606b")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nn-wdstptmgmt-iwdstransportmulticastsessionpolicy
interface IWdsTransportMulticastSessionPolicy : IWdsTransportCacheable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportmulticastsessionpolicy-get_slowclienthandling
    HRESULT get_SlowClientHandling(WDSTRANSPORT_SLOW_CLIENT_HANDLING_TYPE* pSlowClientHandling);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportmulticastsessionpolicy-put_slowclienthandling
    HRESULT put_SlowClientHandling(WDSTRANSPORT_SLOW_CLIENT_HANDLING_TYPE SlowClientHandling);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportmulticastsessionpolicy-get_autodisconnectthreshold
    HRESULT get_AutoDisconnectThreshold(uint* pulThreshold);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportmulticastsessionpolicy-put_autodisconnectthreshold
    HRESULT put_AutoDisconnectThreshold(uint ulThreshold);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportmulticastsessionpolicy-get_multistreamstreamcount
    HRESULT get_MultistreamStreamCount(uint* pulStreamCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportmulticastsessionpolicy-put_multistreamstreamcount
    HRESULT put_MultistreamStreamCount(uint ulStreamCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportmulticastsessionpolicy-get_slowclientfallback
    HRESULT get_SlowClientFallback(VARIANT_BOOL* pbClientFallback);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportmulticastsessionpolicy-put_slowclientfallback
    HRESULT put_SlowClientFallback(VARIANT_BOOL bClientFallback);
}

@GUID("fa561f57-fbef-4ed3-b056-127cb1b33b84")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nn-wdstptmgmt-iwdstransportnamespace
interface IWdsTransportNamespace : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportnamespace-get_type
    HRESULT get_Type(WDSTRANSPORT_NAMESPACE_TYPE* pType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportnamespace-get_id
    HRESULT get_Id(uint* pulId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportnamespace-get_name
    HRESULT get_Name(BSTR* pbszName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportnamespace-put_name
    HRESULT put_Name(BSTR bszName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportnamespace-get_friendlyname
    HRESULT get_FriendlyName(BSTR* pbszFriendlyName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportnamespace-put_friendlyname
    HRESULT put_FriendlyName(BSTR bszFriendlyName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportnamespace-get_description
    HRESULT get_Description(BSTR* pbszDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportnamespace-put_description
    HRESULT put_Description(BSTR bszDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportnamespace-get_contentprovider
    HRESULT get_ContentProvider(BSTR* pbszContentProvider);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportnamespace-put_contentprovider
    HRESULT put_ContentProvider(BSTR bszContentProvider);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportnamespace-get_configuration
    HRESULT get_Configuration(BSTR* pbszConfiguration);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportnamespace-put_configuration
    HRESULT put_Configuration(BSTR bszConfiguration);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportnamespace-get_registered
    HRESULT get_Registered(VARIANT_BOOL* pbRegistered);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportnamespace-get_tombstoned
    HRESULT get_Tombstoned(VARIANT_BOOL* pbTombstoned);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportnamespace-get_tombstonetime
    HRESULT get_TombstoneTime(double* pTombstoneTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportnamespace-get_transmissionstarted
    HRESULT get_TransmissionStarted(VARIANT_BOOL* pbTransmissionStarted);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportnamespace-register
    HRESULT Register();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportnamespace-deregister
    HRESULT Deregister(VARIANT_BOOL bTerminateSessions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportnamespace-clone
    HRESULT Clone(IWdsTransportNamespace* ppWdsTransportNamespaceClone);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportnamespace-refresh
    HRESULT Refresh();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportnamespace-retrievecontents
    HRESULT RetrieveContents(IWdsTransportCollection* ppWdsTransportContents);
}

@GUID("ad931a72-c4bd-4c41-8fbc-59c9c748df9e")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nn-wdstptmgmt-iwdstransportnamespaceautocast
interface IWdsTransportNamespaceAutoCast : IWdsTransportNamespace
{
}

@GUID("3840cecf-d76c-416e-a4cc-31c741d2874b")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nn-wdstptmgmt-iwdstransportnamespacescheduledcast
interface IWdsTransportNamespaceScheduledCast : IWdsTransportNamespace
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportnamespacescheduledcast-starttransmission
    HRESULT StartTransmission();
}

@GUID("013e6e4c-e6a7-4fb5-b7ff-d9f5da805c31")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nn-wdstptmgmt-iwdstransportnamespacescheduledcastmanualstart
interface IWdsTransportNamespaceScheduledCastManualStart : IWdsTransportNamespaceScheduledCast
{
}

@GUID("d606af3d-ea9c-4219-961e-7491d618d9b9")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nn-wdstptmgmt-iwdstransportnamespacescheduledcastautostart
interface IWdsTransportNamespaceScheduledCastAutoStart : IWdsTransportNamespaceScheduledCast
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportnamespacescheduledcastautostart-get_minimumclients
    HRESULT get_MinimumClients(uint* pulMinimumClients);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportnamespacescheduledcastautostart-put_minimumclients
    HRESULT put_MinimumClients(uint ulMinimumClients);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportnamespacescheduledcastautostart-get_starttime
    HRESULT get_StartTime(double* pStartTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportnamespacescheduledcastautostart-put_starttime
    HRESULT put_StartTime(double StartTime);
}

@GUID("d405d711-0296-4ab4-a860-ac7d32e65798")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nn-wdstptmgmt-iwdstransportcontent
interface IWdsTransportContent : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportcontent-get_namespace
    HRESULT get_Namespace(IWdsTransportNamespace* ppWdsTransportNamespace);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportcontent-get_id
    HRESULT get_Id(uint* pulId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportcontent-get_name
    HRESULT get_Name(BSTR* pbszName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportcontent-retrievesessions
    HRESULT RetrieveSessions(IWdsTransportCollection* ppWdsTransportSessions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportcontent-terminate
    HRESULT Terminate();
}

@GUID("f4efea88-65b1-4f30-a4b9-2793987796fb")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nn-wdstptmgmt-iwdstransportsession
interface IWdsTransportSession : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportsession-get_content
    HRESULT get_Content(IWdsTransportContent* ppWdsTransportContent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportsession-get_id
    HRESULT get_Id(uint* pulId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportsession-get_networkinterfacename
    HRESULT get_NetworkInterfaceName(BSTR* pbszNetworkInterfaceName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportsession-get_networkinterfaceaddress
    HRESULT get_NetworkInterfaceAddress(BSTR* pbszNetworkInterfaceAddress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportsession-get_transferrate
    HRESULT get_TransferRate(uint* pulTransferRate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportsession-get_masterclientid
    HRESULT get_MasterClientId(uint* pulMasterClientId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportsession-retrieveclients
    HRESULT RetrieveClients(IWdsTransportCollection* ppWdsTransportClients);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportsession-terminate
    HRESULT Terminate();
}

@GUID("b5dbc93a-cabe-46ca-837f-3e44e93c6545")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nn-wdstptmgmt-iwdstransportclient
interface IWdsTransportClient : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportclient-get_session
    HRESULT get_Session(IWdsTransportSession* ppWdsTransportSession);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportclient-get_id
    HRESULT get_Id(uint* pulId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportclient-get_name
    HRESULT get_Name(BSTR* pbszName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportclient-get_macaddress
    HRESULT get_MacAddress(BSTR* pbszMacAddress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportclient-get_ipaddress
    HRESULT get_IpAddress(BSTR* pbszIpAddress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportclient-get_percentcompletion
    HRESULT get_PercentCompletion(uint* pulPercentCompletion);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportclient-get_joinduration
    HRESULT get_JoinDuration(uint* pulJoinDuration);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportclient-get_cpuutilization
    HRESULT get_CpuUtilization(uint* pulCpuUtilization);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportclient-get_memoryutilization
    HRESULT get_MemoryUtilization(uint* pulMemoryUtilization);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportclient-get_networkutilization
    HRESULT get_NetworkUtilization(uint* pulNetworkUtilization);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportclient-get_useridentity
    HRESULT get_UserIdentity(BSTR* pbszUserIdentity);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportclient-disconnect
    HRESULT Disconnect(WDSTRANSPORT_DISCONNECT_TYPE DisconnectionType);
}

@GUID("b022d3ae-884d-4d85-b146-53320e76ef62")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nn-wdstptmgmt-iwdstransporttftpclient
interface IWdsTransportTftpClient : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransporttftpclient-get_filename
    HRESULT get_FileName(BSTR* pbszFileName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransporttftpclient-get_ipaddress
    HRESULT get_IpAddress(BSTR* pbszIpAddress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransporttftpclient-get_timeout
    HRESULT get_Timeout(uint* pulTimeout);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransporttftpclient-get_currentfileoffset
    HRESULT get_CurrentFileOffset(ulong* pul64CurrentOffset);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransporttftpclient-get_filesize
    HRESULT get_FileSize(ulong* pul64FileSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransporttftpclient-get_blocksize
    HRESULT get_BlockSize(uint* pulBlockSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransporttftpclient-get_windowsize
    HRESULT get_WindowSize(uint* pulWindowSize);
}

@GUID("b9489f24-f219-4acf-aad7-265c7c08a6ae")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nn-wdstptmgmt-iwdstransportcontentprovider
interface IWdsTransportContentProvider : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportcontentprovider-get_name
    HRESULT get_Name(BSTR* pbszName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportcontentprovider-get_description
    HRESULT get_Description(BSTR* pbszDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportcontentprovider-get_filepath
    HRESULT get_FilePath(BSTR* pbszFilePath);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wdstptmgmt/nf-wdstptmgmt-iwdstransportcontentprovider-get_initializationroutine
    HRESULT get_InitializationRoutine(BSTR* pbszInitializationRoutine);
}


// GUIDs

const GUID CLSID_WdsTransportCacheable                         = GUIDOF!WdsTransportCacheable;
const GUID CLSID_WdsTransportClient                            = GUIDOF!WdsTransportClient;
const GUID CLSID_WdsTransportCollection                        = GUIDOF!WdsTransportCollection;
const GUID CLSID_WdsTransportConfigurationManager              = GUIDOF!WdsTransportConfigurationManager;
const GUID CLSID_WdsTransportContent                           = GUIDOF!WdsTransportContent;
const GUID CLSID_WdsTransportContentProvider                   = GUIDOF!WdsTransportContentProvider;
const GUID CLSID_WdsTransportDiagnosticsPolicy                 = GUIDOF!WdsTransportDiagnosticsPolicy;
const GUID CLSID_WdsTransportManager                           = GUIDOF!WdsTransportManager;
const GUID CLSID_WdsTransportMulticastSessionPolicy            = GUIDOF!WdsTransportMulticastSessionPolicy;
const GUID CLSID_WdsTransportNamespace                         = GUIDOF!WdsTransportNamespace;
const GUID CLSID_WdsTransportNamespaceAutoCast                 = GUIDOF!WdsTransportNamespaceAutoCast;
const GUID CLSID_WdsTransportNamespaceManager                  = GUIDOF!WdsTransportNamespaceManager;
const GUID CLSID_WdsTransportNamespaceScheduledCast            = GUIDOF!WdsTransportNamespaceScheduledCast;
const GUID CLSID_WdsTransportNamespaceScheduledCastAutoStart   = GUIDOF!WdsTransportNamespaceScheduledCastAutoStart;
const GUID CLSID_WdsTransportNamespaceScheduledCastManualStart = GUIDOF!WdsTransportNamespaceScheduledCastManualStart;
const GUID CLSID_WdsTransportServer                            = GUIDOF!WdsTransportServer;
const GUID CLSID_WdsTransportServicePolicy                     = GUIDOF!WdsTransportServicePolicy;
const GUID CLSID_WdsTransportSession                           = GUIDOF!WdsTransportSession;
const GUID CLSID_WdsTransportSetupManager                      = GUIDOF!WdsTransportSetupManager;
const GUID CLSID_WdsTransportTftpClient                        = GUIDOF!WdsTransportTftpClient;
const GUID CLSID_WdsTransportTftpManager                       = GUIDOF!WdsTransportTftpManager;

const GUID IID_IWdsTransportCacheable                         = GUIDOF!IWdsTransportCacheable;
const GUID IID_IWdsTransportClient                            = GUIDOF!IWdsTransportClient;
const GUID IID_IWdsTransportCollection                        = GUIDOF!IWdsTransportCollection;
const GUID IID_IWdsTransportConfigurationManager              = GUIDOF!IWdsTransportConfigurationManager;
const GUID IID_IWdsTransportConfigurationManager2             = GUIDOF!IWdsTransportConfigurationManager2;
const GUID IID_IWdsTransportContent                           = GUIDOF!IWdsTransportContent;
const GUID IID_IWdsTransportContentProvider                   = GUIDOF!IWdsTransportContentProvider;
const GUID IID_IWdsTransportDiagnosticsPolicy                 = GUIDOF!IWdsTransportDiagnosticsPolicy;
const GUID IID_IWdsTransportManager                           = GUIDOF!IWdsTransportManager;
const GUID IID_IWdsTransportMulticastSessionPolicy            = GUIDOF!IWdsTransportMulticastSessionPolicy;
const GUID IID_IWdsTransportNamespace                         = GUIDOF!IWdsTransportNamespace;
const GUID IID_IWdsTransportNamespaceAutoCast                 = GUIDOF!IWdsTransportNamespaceAutoCast;
const GUID IID_IWdsTransportNamespaceManager                  = GUIDOF!IWdsTransportNamespaceManager;
const GUID IID_IWdsTransportNamespaceScheduledCast            = GUIDOF!IWdsTransportNamespaceScheduledCast;
const GUID IID_IWdsTransportNamespaceScheduledCastAutoStart   = GUIDOF!IWdsTransportNamespaceScheduledCastAutoStart;
const GUID IID_IWdsTransportNamespaceScheduledCastManualStart = GUIDOF!IWdsTransportNamespaceScheduledCastManualStart;
const GUID IID_IWdsTransportServer                            = GUIDOF!IWdsTransportServer;
const GUID IID_IWdsTransportServer2                           = GUIDOF!IWdsTransportServer2;
const GUID IID_IWdsTransportServicePolicy                     = GUIDOF!IWdsTransportServicePolicy;
const GUID IID_IWdsTransportServicePolicy2                    = GUIDOF!IWdsTransportServicePolicy2;
const GUID IID_IWdsTransportSession                           = GUIDOF!IWdsTransportSession;
const GUID IID_IWdsTransportSetupManager                      = GUIDOF!IWdsTransportSetupManager;
const GUID IID_IWdsTransportSetupManager2                     = GUIDOF!IWdsTransportSetupManager2;
const GUID IID_IWdsTransportTftpClient                        = GUIDOF!IWdsTransportTftpClient;
const GUID IID_IWdsTransportTftpManager                       = GUIDOF!IWdsTransportTftpManager;
