// Written in the D programming language.

module windows.win32.networkmanagement.p2p;

public import windows.core;
public import windows.win32.foundation.foundation : BOOL, FILETIME, HANDLE, HRESULT, HWND,
                                                    PWSTR;
public import windows.win32.networking.winsock : SOCKADDR, SOCKADDR_IN6, SOCKADDR_STORAGE,
                                                 SOCKET_ADDRESS, SOCKET_ADDRESS_LIST;
public import windows.win32.security.cryptography.cryptography : CERT_CONTEXT, CERT_PUBLIC_KEY_INFO;
public import windows.win32.system.com.com : BLOB;
public import windows.win32.system.io : OVERLAPPED;

extern(Windows) @nogc nothrow:


// Enums


alias PEERDIST_RETRIEVAL_OPTIONS_CONTENTINFO_VERSION_VALUE = uint;
enum : uint
{
    PEERDIST_RETRIEVAL_OPTIONS_CONTENTINFO_VERSION_1 = 0x00000001U,
    PEERDIST_RETRIEVAL_OPTIONS_CONTENTINFO_VERSION_2 = 0x00000002U,
    PEERDIST_RETRIEVAL_OPTIONS_CONTENTINFO_VERSION   = 0x00000002U,
}

alias PNRP_SCOPE = int;
enum : int
{
    PNRP_SCOPE_ANY        = 0x00000000,
    PNRP_GLOBAL_SCOPE     = 0x00000001,
    PNRP_SITE_LOCAL_SCOPE = 0x00000002,
    PNRP_LINK_LOCAL_SCOPE = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pnrpdef/ne-pnrpdef-pnrp_cloud_state
alias PNRP_CLOUD_STATE = int;
enum : int
{
    PNRP_CLOUD_STATE_VIRTUAL       = 0x00000000,
    PNRP_CLOUD_STATE_SYNCHRONISING = 0x00000001,
    PNRP_CLOUD_STATE_ACTIVE        = 0x00000002,
    PNRP_CLOUD_STATE_DEAD          = 0x00000003,
    PNRP_CLOUD_STATE_DISABLED      = 0x00000004,
    PNRP_CLOUD_STATE_NO_NET        = 0x00000005,
    PNRP_CLOUD_STATE_ALONE         = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pnrpdef/ne-pnrpdef-pnrp_cloud_flags
alias PNRP_CLOUD_FLAGS = int;
enum : int
{
    PNRP_CLOUD_NO_FLAGS         = 0x00000000,
    PNRP_CLOUD_NAME_LOCAL       = 0x00000001,
    PNRP_CLOUD_RESOLVE_ONLY     = 0x00000002,
    PNRP_CLOUD_FULL_PARTICIPANT = 0x00000004,
}

alias PNRP_REGISTERED_ID_STATE = int;
enum : int
{
    PNRP_REGISTERED_ID_STATE_OK      = 0x00000001,
    PNRP_REGISTERED_ID_STATE_PROBLEM = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pnrpdef/ne-pnrpdef-pnrp_resolve_criteria
alias PNRP_RESOLVE_CRITERIA = int;
enum : int
{
    PNRP_RESOLVE_CRITERIA_DEFAULT                               = 0x00000000,
    PNRP_RESOLVE_CRITERIA_REMOTE_PEER_NAME                      = 0x00000001,
    PNRP_RESOLVE_CRITERIA_NEAREST_REMOTE_PEER_NAME              = 0x00000002,
    PNRP_RESOLVE_CRITERIA_NON_CURRENT_PROCESS_PEER_NAME         = 0x00000003,
    PNRP_RESOLVE_CRITERIA_NEAREST_NON_CURRENT_PROCESS_PEER_NAME = 0x00000004,
    PNRP_RESOLVE_CRITERIA_ANY_PEER_NAME                         = 0x00000005,
    PNRP_RESOLVE_CRITERIA_NEAREST_PEER_NAME                     = 0x00000006,
}

alias PNRP_EXTENDED_PAYLOAD_TYPE = int;
enum : int
{
    PNRP_EXTENDED_PAYLOAD_TYPE_NONE   = 0x00000000,
    PNRP_EXTENDED_PAYLOAD_TYPE_BINARY = 0x00000001,
    PNRP_EXTENDED_PAYLOAD_TYPE_STRING = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ne-p2p-peer_record_change_type
alias PEER_RECORD_CHANGE_TYPE = int;
enum : int
{
    PEER_RECORD_ADDED   = 0x00000001,
    PEER_RECORD_UPDATED = 0x00000002,
    PEER_RECORD_DELETED = 0x00000003,
    PEER_RECORD_EXPIRED = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ne-p2p-peer_connection_status
alias PEER_CONNECTION_STATUS = int;
enum : int
{
    PEER_CONNECTED         = 0x00000001,
    PEER_DISCONNECTED      = 0x00000002,
    PEER_CONNECTION_FAILED = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ne-p2p-peer_connection_flags
alias PEER_CONNECTION_FLAGS = int;
enum : int
{
    PEER_CONNECTION_NEIGHBOR = 0x00000001,
    PEER_CONNECTION_DIRECT   = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ne-p2p-peer_record_flags
alias PEER_RECORD_FLAGS = int;
enum : int
{
    PEER_RECORD_FLAG_AUTOREFRESH = 0x00000001,
    PEER_RECORD_FLAG_DELETED     = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ne-p2p-peer_graph_event_type
alias PEER_GRAPH_EVENT_TYPE = int;
enum : int
{
    PEER_GRAPH_EVENT_STATUS_CHANGED      = 0x00000001,
    PEER_GRAPH_EVENT_PROPERTY_CHANGED    = 0x00000002,
    PEER_GRAPH_EVENT_RECORD_CHANGED      = 0x00000003,
    PEER_GRAPH_EVENT_DIRECT_CONNECTION   = 0x00000004,
    PEER_GRAPH_EVENT_NEIGHBOR_CONNECTION = 0x00000005,
    PEER_GRAPH_EVENT_INCOMING_DATA       = 0x00000006,
    PEER_GRAPH_EVENT_CONNECTION_REQUIRED = 0x00000007,
    PEER_GRAPH_EVENT_NODE_CHANGED        = 0x00000008,
    PEER_GRAPH_EVENT_SYNCHRONIZED        = 0x00000009,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ne-p2p-peer_node_change_type
alias PEER_NODE_CHANGE_TYPE = int;
enum : int
{
    PEER_NODE_CHANGE_CONNECTED    = 0x00000001,
    PEER_NODE_CHANGE_DISCONNECTED = 0x00000002,
    PEER_NODE_CHANGE_UPDATED      = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ne-p2p-peer_graph_status_flags
alias PEER_GRAPH_STATUS_FLAGS = int;
enum : int
{
    PEER_GRAPH_STATUS_LISTENING       = 0x00000001,
    PEER_GRAPH_STATUS_HAS_CONNECTIONS = 0x00000002,
    PEER_GRAPH_STATUS_SYNCHRONIZED    = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ne-p2p-peer_graph_property_flags
alias PEER_GRAPH_PROPERTY_FLAGS = int;
enum : int
{
    PEER_GRAPH_PROPERTY_HEARTBEATS       = 0x00000001,
    PEER_GRAPH_PROPERTY_DEFER_EXPIRATION = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ne-p2p-peer_graph_scope
alias PEER_GRAPH_SCOPE = int;
enum : int
{
    PEER_GRAPH_SCOPE_ANY       = 0x00000000,
    PEER_GRAPH_SCOPE_GLOBAL    = 0x00000001,
    PEER_GRAPH_SCOPE_SITELOCAL = 0x00000002,
    PEER_GRAPH_SCOPE_LINKLOCAL = 0x00000003,
    PEER_GRAPH_SCOPE_LOOPBACK  = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ne-p2p-peer_group_event_type
alias PEER_GROUP_EVENT_TYPE = int;
enum : int
{
    PEER_GROUP_EVENT_STATUS_CHANGED        = 0x00000001,
    PEER_GROUP_EVENT_PROPERTY_CHANGED      = 0x00000002,
    PEER_GROUP_EVENT_RECORD_CHANGED        = 0x00000003,
    PEER_GROUP_EVENT_DIRECT_CONNECTION     = 0x00000004,
    PEER_GROUP_EVENT_NEIGHBOR_CONNECTION   = 0x00000005,
    PEER_GROUP_EVENT_INCOMING_DATA         = 0x00000006,
    PEER_GROUP_EVENT_MEMBER_CHANGED        = 0x00000008,
    PEER_GROUP_EVENT_CONNECTION_FAILED     = 0x0000000a,
    PEER_GROUP_EVENT_AUTHENTICATION_FAILED = 0x0000000b,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ne-p2p-peer_group_status
alias PEER_GROUP_STATUS = int;
enum : int
{
    PEER_GROUP_STATUS_LISTENING       = 0x00000001,
    PEER_GROUP_STATUS_HAS_CONNECTIONS = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ne-p2p-peer_group_property_flags
alias PEER_GROUP_PROPERTY_FLAGS = int;
enum : int
{
    PEER_MEMBER_DATA_OPTIONAL = 0x00000001,
    PEER_DISABLE_PRESENCE     = 0x00000002,
    PEER_DEFER_EXPIRATION     = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ne-p2p-peer_group_authentication_scheme
alias PEER_GROUP_AUTHENTICATION_SCHEME = int;
enum : int
{
    PEER_GROUP_GMC_AUTHENTICATION      = 0x00000001,
    PEER_GROUP_PASSWORD_AUTHENTICATION = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ne-p2p-peer_member_flags
alias PEER_MEMBER_FLAGS = int;
enum : int
{
    PEER_MEMBER_PRESENT = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ne-p2p-peer_member_change_type
alias PEER_MEMBER_CHANGE_TYPE = int;
enum : int
{
    PEER_MEMBER_CONNECTED    = 0x00000001,
    PEER_MEMBER_DISCONNECTED = 0x00000002,
    PEER_MEMBER_UPDATED      = 0x00000003,
    PEER_MEMBER_JOINED       = 0x00000004,
    PEER_MEMBER_LEFT         = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ne-p2p-peer_group_issue_credential_flags
alias PEER_GROUP_ISSUE_CREDENTIAL_FLAGS = int;
enum : int
{
    PEER_GROUP_STORE_CREDENTIALS = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ne-p2p-peer_signin_flags
alias PEER_SIGNIN_FLAGS = int;
enum : int
{
    PEER_SIGNIN_NONE     = 0x00000000,
    PEER_SIGNIN_NEAR_ME  = 0x00000001,
    PEER_SIGNIN_INTERNET = 0x00000002,
    PEER_SIGNIN_ALL      = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ne-p2p-peer_watch_permission
alias PEER_WATCH_PERMISSION = int;
enum : int
{
    PEER_WATCH_BLOCKED = 0x00000000,
    PEER_WATCH_ALLOWED = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ne-p2p-peer_publication_scope
alias PEER_PUBLICATION_SCOPE = int;
enum : int
{
    PEER_PUBLICATION_SCOPE_NONE     = 0x00000000,
    PEER_PUBLICATION_SCOPE_NEAR_ME  = 0x00000001,
    PEER_PUBLICATION_SCOPE_INTERNET = 0x00000002,
    PEER_PUBLICATION_SCOPE_ALL      = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ne-p2p-peer_invitation_response_type
alias PEER_INVITATION_RESPONSE_TYPE = int;
enum : int
{
    PEER_INVITATION_RESPONSE_DECLINED = 0x00000000,
    PEER_INVITATION_RESPONSE_ACCEPTED = 0x00000001,
    PEER_INVITATION_RESPONSE_EXPIRED  = 0x00000002,
    PEER_INVITATION_RESPONSE_ERROR    = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ne-p2p-peer_application_registration_type
alias PEER_APPLICATION_REGISTRATION_TYPE = int;
enum : int
{
    PEER_APPLICATION_CURRENT_USER = 0x00000000,
    PEER_APPLICATION_ALL_USERS    = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ne-p2p-peer_presence_status
alias PEER_PRESENCE_STATUS = int;
enum : int
{
    PEER_PRESENCE_OFFLINE       = 0x00000000,
    PEER_PRESENCE_OUT_TO_LUNCH  = 0x00000001,
    PEER_PRESENCE_AWAY          = 0x00000002,
    PEER_PRESENCE_BE_RIGHT_BACK = 0x00000003,
    PEER_PRESENCE_IDLE          = 0x00000004,
    PEER_PRESENCE_BUSY          = 0x00000005,
    PEER_PRESENCE_ON_THE_PHONE  = 0x00000006,
    PEER_PRESENCE_ONLINE        = 0x00000007,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ne-p2p-peer_change_type
alias PEER_CHANGE_TYPE = int;
enum : int
{
    PEER_CHANGE_ADDED   = 0x00000000,
    PEER_CHANGE_DELETED = 0x00000001,
    PEER_CHANGE_UPDATED = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ne-p2p-peer_collab_event_type
alias PEER_COLLAB_EVENT_TYPE = int;
enum : int
{
    PEER_EVENT_WATCHLIST_CHANGED            = 0x00000001,
    PEER_EVENT_ENDPOINT_CHANGED             = 0x00000002,
    PEER_EVENT_ENDPOINT_PRESENCE_CHANGED    = 0x00000003,
    PEER_EVENT_ENDPOINT_APPLICATION_CHANGED = 0x00000004,
    PEER_EVENT_ENDPOINT_OBJECT_CHANGED      = 0x00000005,
    PEER_EVENT_MY_ENDPOINT_CHANGED          = 0x00000006,
    PEER_EVENT_MY_PRESENCE_CHANGED          = 0x00000007,
    PEER_EVENT_MY_APPLICATION_CHANGED       = 0x00000008,
    PEER_EVENT_MY_OBJECT_CHANGED            = 0x00000009,
    PEER_EVENT_PEOPLE_NEAR_ME_CHANGED       = 0x0000000a,
    PEER_EVENT_REQUEST_STATUS_CHANGED       = 0x0000000b,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/drt/ne-drt-drt_scope
alias DRT_SCOPE = int;
enum : int
{
    DRT_GLOBAL_SCOPE     = 0x00000001,
    DRT_SITE_LOCAL_SCOPE = 0x00000002,
    DRT_LINK_LOCAL_SCOPE = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/drt/ne-drt-drt_status
alias DRT_STATUS = int;
enum : int
{
    DRT_ACTIVE     = 0x00000000,
    DRT_ALONE      = 0x00000001,
    DRT_NO_NETWORK = 0x0000000a,
    DRT_FAULTED    = 0x00000014,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/drt/ne-drt-drt_match_type
alias DRT_MATCH_TYPE = int;
enum : int
{
    DRT_MATCH_EXACT        = 0x00000000,
    DRT_MATCH_NEAR         = 0x00000001,
    DRT_MATCH_INTERMEDIATE = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/drt/ne-drt-drt_leafset_key_change_type
alias DRT_LEAFSET_KEY_CHANGE_TYPE = int;
enum : int
{
    DRT_LEAFSET_KEY_ADDED   = 0x00000000,
    DRT_LEAFSET_KEY_DELETED = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/drt/ne-drt-drt_event_type
alias DRT_EVENT_TYPE = int;
enum : int
{
    DRT_EVENT_STATUS_CHANGED             = 0x00000000,
    DRT_EVENT_LEAFSET_KEY_CHANGED        = 0x00000001,
    DRT_EVENT_REGISTRATION_STATE_CHANGED = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/drt/ne-drt-drt_security_mode
alias DRT_SECURITY_MODE = int;
enum : int
{
    DRT_SECURE_RESOLVE             = 0x00000000,
    DRT_SECURE_MEMBERSHIP          = 0x00000001,
    DRT_SECURE_CONFIDENTIALPAYLOAD = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/drt/ne-drt-drt_registration_state
alias DRT_REGISTRATION_STATE = int;
enum : int
{
    DRT_REGISTRATION_STATE_UNRESOLVEABLE = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/drt/ne-drt-drt_address_flags
alias DRT_ADDRESS_FLAGS = int;
enum : int
{
    DRT_ADDRESS_FLAG_ACCEPTED                = 0x00000001,
    DRT_ADDRESS_FLAG_REJECTED                = 0x00000002,
    DRT_ADDRESS_FLAG_UNREACHABLE             = 0x00000004,
    DRT_ADDRESS_FLAG_LOOP                    = 0x00000008,
    DRT_ADDRESS_FLAG_TOO_BUSY                = 0x00000010,
    DRT_ADDRESS_FLAG_BAD_VALIDATE_ID         = 0x00000020,
    DRT_ADDRESS_FLAG_SUSPECT_UNREGISTERED_ID = 0x00000040,
    DRT_ADDRESS_FLAG_INQUIRE                 = 0x00000080,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/peerdist/ne-peerdist-peerdist_status
alias PEERDIST_STATUS = int;
enum : int
{
    PEERDIST_STATUS_DISABLED    = 0x00000000,
    PEERDIST_STATUS_UNAVAILABLE = 0x00000001,
    PEERDIST_STATUS_AVAILABLE   = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/peerdist/ne-peerdist-peerdist_client_info_by_handle_class
alias PEERDIST_CLIENT_INFO_BY_HANDLE_CLASS = int;
enum : int
{
    PeerDistClientBasicInfo                 = 0x00000000,
    MaximumPeerDistClientInfoByHandlesClass = 0x00000001,
}

// Constants


enum : uint
{
    NS_PNRPNAME  = 0x00000026U,
    NS_PNRPCLOUD = 0x00000027U,
}

enum uint PNRPINFO_HINT = 0x00000001U;

enum : GUID
{
    NS_PROVIDER_PNRPNAME  = GUID("03fe89cd-766d-4976-b9c1-bb9bc42c7b4d"),
    NS_PROVIDER_PNRPCLOUD = GUID("03fe89ce-766d-4976-b9c1-bb9bc42c7b4d"),
}

enum : GUID
{
    SVCID_PNRPCLOUD   = GUID("c2239ce6-00c0-4fbf-bad6-18139385a49a"),
    SVCID_PNRPNAME_V1 = GUID("c2239ce5-00c0-4fbf-bad6-18139385a49a"),
    SVCID_PNRPNAME_V2 = GUID("c2239ce7-00c0-4fbf-bad6-18139385a49a"),
}

enum uint PNRP_MAX_ENDPOINT_ADDRESSES = 0x0000000aU;

enum : const(wchar)*
{
    WSZ_SCOPE_GLOBAL    = "GLOBAL",
    WSZ_SCOPE_SITELOCAL = "SITELOCAL",
    WSZ_SCOPE_LINKLOCAL = "LINKLOCAL",
}

enum uint PNRP_MAX_EXTENDED_PAYLOAD_BYTES = 0x00001000U;
enum const(wchar)* PEER_PNRP_ALL_LINK_CLOUDS = "PEER_PNRP_ALL_LINKS";

enum : uint
{
    WSA_PNRP_ERROR_BASE      = 0x00002cecU,
    WSA_PNRP_CLOUD_NOT_FOUND = 0x00002cedU,
    WSA_PNRP_CLOUD_DISABLED  = 0x00002ceeU,
}

enum uint WSA_PNRP_INVALID_IDENTITY = 0x00002cefU;

enum : uint
{
    WSA_PNRP_TOO_MUCH_LOAD        = 0x00002cf0U,
    WSA_PNRP_CLOUD_IS_SEARCH_ONLY = 0x00002cf1U,
}

enum uint WSA_PNRP_CLIENT_INVALID_COMPARTMENT_ID = 0x00002cf2U;
enum uint WSA_PNRP_DUPLICATE_PEER_NAME = 0x00002cf4U;
enum uint WSA_PNRP_CLOUD_IS_DEAD = 0x00002cf5U;

enum : HRESULT
{
    PEER_E_CLOUD_NOT_FOUND = HRESULT(0x80072ced),
    PEER_E_CLOUD_DISABLED  = HRESULT(0x80072cee),
}

enum HRESULT PEER_E_INVALID_IDENTITY = HRESULT(0x80072cef);
enum HRESULT PEER_E_TOO_MUCH_LOAD = HRESULT(0x80072cf0);
enum HRESULT PEER_E_CLOUD_IS_SEARCH_ONLY = HRESULT(0x80072cf1);
enum HRESULT PEER_E_CLIENT_INVALID_COMPARTMENT_ID = HRESULT(0x80072cf2);
enum HRESULT PEER_E_DUPLICATE_PEER_NAME = HRESULT(0x80072cf4);
enum HRESULT PEER_E_CLOUD_IS_DEAD = HRESULT(0x80072cf5);

enum : HRESULT
{
    PEER_E_NOT_FOUND      = HRESULT(0x80070490),
    PEER_E_DISK_FULL      = HRESULT(0x80070070),
    PEER_E_ALREADY_EXISTS = HRESULT(0x800700b7),
}

enum : GUID
{
    PEER_GROUP_ROLE_ADMIN           = GUID("04387127-aa56-450a-8ce5-4f565c6790f4"),
    PEER_GROUP_ROLE_MEMBER          = GUID("f12dc4c7-0857-4ca0-93fc-b1bb19a3d8c2"),
    PEER_GROUP_ROLE_INVITING_MEMBER = GUID("4370fd89-dc18-4cfb-8dbf-9853a8a9f905"),
}

enum GUID PEER_COLLAB_OBJECTID_USER_PICTURE = GUID("dd15f41f-fc4e-4922-b035-4c06a754d01d");
enum uint FACILITY_DRT = 0x00000062U;

enum : HRESULT
{
    DRT_E_TIMEOUT            = HRESULT(0x80621001),
    DRT_E_INVALID_KEY_SIZE   = HRESULT(0x80621002),
    DRT_E_INVALID_CERT_CHAIN = HRESULT(0x80621004),
    DRT_E_INVALID_MESSAGE    = HRESULT(0x80621005),
}

enum : HRESULT
{
    DRT_E_NO_MORE               = HRESULT(0x80621006),
    DRT_E_INVALID_MAX_ADDRESSES = HRESULT(0x80621007),
}

enum HRESULT DRT_E_SEARCH_IN_PROGRESS = HRESULT(0x80621008);
enum HRESULT DRT_E_INVALID_KEY = HRESULT(0x80621009);
enum HRESULT DRT_S_RETRY = HRESULT(0x00621010);

enum : HRESULT
{
    DRT_E_INVALID_MAX_ENDPOINTS      = HRESULT(0x80621011),
    DRT_E_INVALID_SEARCH_RANGE       = HRESULT(0x80621012),
    DRT_E_INVALID_PORT               = HRESULT(0x80622000),
    DRT_E_INVALID_TRANSPORT_PROVIDER = HRESULT(0x80622001),
    DRT_E_INVALID_SECURITY_PROVIDER  = HRESULT(0x80622002),
}

enum HRESULT DRT_E_STILL_IN_USE = HRESULT(0x80622003);

enum : HRESULT
{
    DRT_E_INVALID_BOOTSTRAP_PROVIDER = HRESULT(0x80622004),
    DRT_E_INVALID_ADDRESS            = HRESULT(0x80622005),
    DRT_E_INVALID_SCOPE              = HRESULT(0x80622006),
}

enum HRESULT DRT_E_TRANSPORT_SHUTTING_DOWN = HRESULT(0x80622007);
enum HRESULT DRT_E_NO_ADDRESSES_AVAILABLE = HRESULT(0x80622008);
enum HRESULT DRT_E_DUPLICATE_KEY = HRESULT(0x80622009);

enum : HRESULT
{
    DRT_E_TRANSPORTPROVIDER_IN_USE       = HRESULT(0x8062200a),
    DRT_E_TRANSPORTPROVIDER_NOT_ATTACHED = HRESULT(0x8062200b),
}

enum : HRESULT
{
    DRT_E_SECURITYPROVIDER_IN_USE       = HRESULT(0x8062200c),
    DRT_E_SECURITYPROVIDER_NOT_ATTACHED = HRESULT(0x8062200d),
}

enum : HRESULT
{
    DRT_E_BOOTSTRAPPROVIDER_IN_USE       = HRESULT(0x8062200e),
    DRT_E_BOOTSTRAPPROVIDER_NOT_ATTACHED = HRESULT(0x8062200f),
}

enum : HRESULT
{
    DRT_E_TRANSPORT_ALREADY_BOUND            = HRESULT(0x80622101),
    DRT_E_TRANSPORT_NOT_BOUND                = HRESULT(0x80622102),
    DRT_E_TRANSPORT_UNEXPECTED               = HRESULT(0x80622103),
    DRT_E_TRANSPORT_INVALID_ARGUMENT         = HRESULT(0x80622104),
    DRT_E_TRANSPORT_NO_DEST_ADDRESSES        = HRESULT(0x80622105),
    DRT_E_TRANSPORT_EXECUTING_CALLBACK       = HRESULT(0x80622106),
    DRT_E_TRANSPORT_ALREADY_EXISTS_FOR_SCOPE = HRESULT(0x80622107),
}

enum : HRESULT
{
    DRT_E_INVALID_SETTINGS    = HRESULT(0x80622108),
    DRT_E_INVALID_SEARCH_INFO = HRESULT(0x80622109),
}

enum : HRESULT
{
    DRT_E_FAULTED               = HRESULT(0x8062210a),
    DRT_E_TRANSPORT_STILL_BOUND = HRESULT(0x8062210b),
}

enum HRESULT DRT_E_INSUFFICIENT_BUFFER = HRESULT(0x8062210c);

enum : HRESULT
{
    DRT_E_INVALID_INSTANCE_PREFIX = HRESULT(0x8062210d),
    DRT_E_INVALID_SECURITY_MODE   = HRESULT(0x8062210e),
}

enum HRESULT DRT_E_CAPABILITY_MISMATCH = HRESULT(0x8062210f);
enum uint DRT_PAYLOAD_REVOKED = 0x00000001U;
enum uint DRT_MIN_ROUTING_ADDRESSES = 0x00000001U;
enum uint DRT_MAX_ROUTING_ADDRESSES = 0x00000014U;
enum uint DRT_MAX_PAYLOAD_SIZE = 0x00001400U;
enum uint DRT_MAX_INSTANCE_PREFIX_LEN = 0x00000080U;
enum uint DRT_LINK_LOCAL_ISATAP_SCOPEID = 0xffffffffU;

enum : int
{
    PEERDIST_PUBLICATION_OPTIONS_VERSION_1 = 0x00000001,
    PEERDIST_PUBLICATION_OPTIONS_VERSION   = 0x00000002,
    PEERDIST_PUBLICATION_OPTIONS_VERSION_2 = 0x00000002,
}

enum : uint
{
    PEERDIST_READ_TIMEOUT_LOCAL_CACHE_ONLY = 0x00000000U,
    PEERDIST_READ_TIMEOUT_DEFAULT          = 0xfffffffeU,
}

// Callbacks

deprecated("marked as obsolete") 
alias PFNPEER_VALIDATE_RECORD = HRESULT function(void* hGraph, void* pvContext, PEER_RECORD* pRecord, 
                                                 PEER_RECORD_CHANGE_TYPE changeType);
deprecated("marked as obsolete") 
alias PFNPEER_SECURE_RECORD = HRESULT function(void* hGraph, void* pvContext, PEER_RECORD* pRecord, 
                                               PEER_RECORD_CHANGE_TYPE changeType, PEER_DATA** ppSecurityData);
deprecated("marked as obsolete") 
alias PFNPEER_FREE_SECURITY_DATA = HRESULT function(void* hGraph, void* pvContext, PEER_DATA* pSecurityData);
deprecated("marked as obsolete") 
alias PFNPEER_ON_PASSWORD_AUTH_FAILED = HRESULT function(void* hGraph, void* pvContext);
alias DRT_BOOTSTRAP_RESOLVE_CALLBACK = void function(HRESULT hr, void* pvContext, SOCKET_ADDRESS_LIST* pAddresses, 
                                                     BOOL fFatalError);

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pnrpdef/ns-pnrpdef-pnrp_cloud_id
struct PNRP_CLOUD_ID
{
    int        AddressFamily;
    PNRP_SCOPE Scope;
    uint       ScopeId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pnrpns/ns-pnrpns-pnrpinfo_v1
struct PNRPINFO_V1
{
    uint           dwSize;
    PWSTR          lpwszIdentity;
    uint           nMaxResolve;
    uint           dwTimeout;
    uint           dwLifetime;
    PNRP_RESOLVE_CRITERIA enResolveCriteria;
    uint           dwFlags;
    SOCKET_ADDRESS saHint;
    PNRP_REGISTERED_ID_STATE enNameState;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pnrpns/ns-pnrpns-pnrpinfo_v2
struct PNRPINFO_V2
{
    uint           dwSize;
    PWSTR          lpwszIdentity;
    uint           nMaxResolve;
    uint           dwTimeout;
    uint           dwLifetime;
    PNRP_RESOLVE_CRITERIA enResolveCriteria;
    uint           dwFlags;
    SOCKET_ADDRESS saHint;
    PNRP_REGISTERED_ID_STATE enNameState;
    PNRP_EXTENDED_PAYLOAD_TYPE enExtendedPayloadType;
    union
    {
        BLOB  blobPayload;
        PWSTR pwszPayload;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pnrpns/ns-pnrpns-pnrpcloudinfo
struct PNRPCLOUDINFO
{
    uint             dwSize;
    PNRP_CLOUD_ID    Cloud;
    PNRP_CLOUD_STATE enCloudState;
    PNRP_CLOUD_FLAGS enCloudFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ns-p2p-peer_version_data
struct PEER_VERSION_DATA
{
    ushort wVersion;
    ushort wHighestVersion;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ns-p2p-peer_data
struct PEER_DATA
{
    uint   cbData;
    ubyte* pbData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ns-p2p-peer_record
struct PEER_RECORD
{
    uint      dwSize;
    GUID      type;
    GUID      id;
    uint      dwVersion;
    uint      dwFlags;
    PWSTR     pwzCreatorId;
    PWSTR     pwzModifiedById;
    PWSTR     pwzAttributes;
    FILETIME  ftCreation;
    FILETIME  ftExpiration;
    FILETIME  ftLastModified;
    PEER_DATA securityData;
    PEER_DATA data;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ns-p2p-peer_address
struct PEER_ADDRESS
{
    uint         dwSize;
    SOCKADDR_IN6 sin6;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ns-p2p-peer_connection_info
struct PEER_CONNECTION_INFO
{
    uint         dwSize;
    uint         dwFlags;
    ulong        ullConnectionId;
    ulong        ullNodeId;
    PWSTR        pwzPeerId;
    PEER_ADDRESS address;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ns-p2p-peer_event_incoming_data
struct PEER_EVENT_INCOMING_DATA
{
    uint      dwSize;
    ulong     ullConnectionId;
    GUID      type;
    PEER_DATA data;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ns-p2p-peer_event_record_change_data
struct PEER_EVENT_RECORD_CHANGE_DATA
{
    uint dwSize;
    PEER_RECORD_CHANGE_TYPE changeType;
    GUID recordId;
    GUID recordType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ns-p2p-peer_event_connection_change_data
struct PEER_EVENT_CONNECTION_CHANGE_DATA
{
    uint    dwSize;
    PEER_CONNECTION_STATUS status;
    ulong   ullConnectionId;
    ulong   ullNodeId;
    ulong   ullNextConnectionId;
    HRESULT hrConnectionFailedReason;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ns-p2p-peer_event_synchronized_data
struct PEER_EVENT_SYNCHRONIZED_DATA
{
    uint dwSize;
    GUID recordType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ns-p2p-peer_graph_properties
struct PEER_GRAPH_PROPERTIES
{
    uint  dwSize;
    uint  dwFlags;
    uint  dwScope;
    uint  dwMaxRecordSize;
    PWSTR pwzGraphId;
    PWSTR pwzCreatorId;
    PWSTR pwzFriendlyName;
    PWSTR pwzComment;
    uint  ulPresenceLifetime;
    uint  cPresenceMax;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ns-p2p-peer_node_info
struct PEER_NODE_INFO
{
    uint          dwSize;
    ulong         ullNodeId;
    PWSTR         pwzPeerId;
    uint          cAddresses;
    PEER_ADDRESS* pAddresses;
    PWSTR         pwzAttributes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ns-p2p-peer_event_node_change_data
struct PEER_EVENT_NODE_CHANGE_DATA
{
    uint  dwSize;
    PEER_NODE_CHANGE_TYPE changeType;
    ulong ullNodeId;
    PWSTR pwzPeerId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ns-p2p-peer_graph_event_registration
struct PEER_GRAPH_EVENT_REGISTRATION
{
    PEER_GRAPH_EVENT_TYPE eventType;
    GUID* pType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ns-p2p-peer_graph_event_data
struct PEER_GRAPH_EVENT_DATA
{
    PEER_GRAPH_EVENT_TYPE eventType;
    union
    {
        PEER_GRAPH_STATUS_FLAGS dwStatus;
        PEER_EVENT_INCOMING_DATA incomingData;
        PEER_EVENT_RECORD_CHANGE_DATA recordChangeData;
        PEER_EVENT_CONNECTION_CHANGE_DATA connectionChangeData;
        PEER_EVENT_NODE_CHANGE_DATA nodeChangeData;
        PEER_EVENT_SYNCHRONIZED_DATA synchronizedData;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ns-p2p-peer_security_interface
struct PEER_SECURITY_INTERFACE
{
    uint   dwSize;
    PWSTR  pwzSspFilename;
    PWSTR  pwzPackageName;
    uint   cbSecurityInfo;
    ubyte* pbSecurityInfo;
    void*  pvContext;
    PFNPEER_VALIDATE_RECORD pfnValidateRecord;
    PFNPEER_SECURE_RECORD pfnSecureRecord;
    PFNPEER_FREE_SECURITY_DATA pfnFreeSecurityData;
    PFNPEER_ON_PASSWORD_AUTH_FAILED pfnAuthFailed;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ns-p2p-peer_credential_info
struct PEER_CREDENTIAL_INFO
{
    uint     dwSize;
    uint     dwFlags;
    PWSTR    pwzFriendlyName;
    CERT_PUBLIC_KEY_INFO* pPublicKey;
    PWSTR    pwzIssuerPeerName;
    PWSTR    pwzIssuerFriendlyName;
    FILETIME ftValidityStart;
    FILETIME ftValidityEnd;
    uint     cRoles;
    GUID*    pRoles;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ns-p2p-peer_member
struct PEER_MEMBER
{
    uint          dwSize;
    uint          dwFlags;
    PWSTR         pwzIdentity;
    PWSTR         pwzAttributes;
    ulong         ullNodeId;
    uint          cAddresses;
    PEER_ADDRESS* pAddresses;
    PEER_CREDENTIAL_INFO* pCredentialInfo;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ns-p2p-peer_invitation_info
struct PEER_INVITATION_INFO
{
    uint     dwSize;
    uint     dwFlags;
    PWSTR    pwzCloudName;
    uint     dwScope;
    uint     dwCloudFlags;
    PWSTR    pwzGroupPeerName;
    PWSTR    pwzIssuerPeerName;
    PWSTR    pwzSubjectPeerName;
    PWSTR    pwzGroupFriendlyName;
    PWSTR    pwzIssuerFriendlyName;
    PWSTR    pwzSubjectFriendlyName;
    FILETIME ftValidityStart;
    FILETIME ftValidityEnd;
    uint     cRoles;
    GUID*    pRoles;
    uint     cClassifiers;
    PWSTR*   ppwzClassifiers;
    CERT_PUBLIC_KEY_INFO* pSubjectPublicKey;
    PEER_GROUP_AUTHENTICATION_SCHEME authScheme;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ns-p2p-peer_group_properties
struct PEER_GROUP_PROPERTIES
{
    uint  dwSize;
    uint  dwFlags;
    PWSTR pwzCloud;
    PWSTR pwzClassifier;
    PWSTR pwzGroupPeerName;
    PWSTR pwzCreatorPeerName;
    PWSTR pwzFriendlyName;
    PWSTR pwzComment;
    uint  ulMemberDataLifetime;
    uint  ulPresenceLifetime;
    uint  dwAuthenticationSchemes;
    PWSTR pwzGroupPassword;
    GUID  groupPasswordRole;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ns-p2p-peer_event_member_change_data
struct PEER_EVENT_MEMBER_CHANGE_DATA
{
    uint  dwSize;
    PEER_MEMBER_CHANGE_TYPE changeType;
    PWSTR pwzIdentity;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ns-p2p-peer_group_event_registration
struct PEER_GROUP_EVENT_REGISTRATION
{
    PEER_GROUP_EVENT_TYPE eventType;
    GUID* pType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ns-p2p-peer_group_event_data~r1
struct PEER_GROUP_EVENT_DATA
{
    PEER_GROUP_EVENT_TYPE eventType;
    union
    {
        PEER_GROUP_STATUS dwStatus;
        PEER_EVENT_INCOMING_DATA incomingData;
        PEER_EVENT_RECORD_CHANGE_DATA recordChangeData;
        PEER_EVENT_CONNECTION_CHANGE_DATA connectionChangeData;
        PEER_EVENT_MEMBER_CHANGE_DATA memberChangeData;
        HRESULT           hrConnectionFailedReason;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ns-p2p-peer_name_pair
struct PEER_NAME_PAIR
{
    uint  dwSize;
    PWSTR pwzPeerName;
    PWSTR pwzFriendlyName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ns-p2p-peer_application
struct PEER_APPLICATION
{
    GUID      id;
    PEER_DATA data;
    PWSTR     pwzDescription;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ns-p2p-peer_object
struct PEER_OBJECT
{
    GUID      id;
    PEER_DATA data;
    uint      dwPublicationScope;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ns-p2p-peer_contact
struct PEER_CONTACT
{
    PWSTR     pwzPeerName;
    PWSTR     pwzNickName;
    PWSTR     pwzDisplayName;
    PWSTR     pwzEmailAddress;
    BOOL      fWatch;
    PEER_WATCH_PERMISSION WatcherPermissions;
    PEER_DATA credentials;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ns-p2p-peer_endpoint
struct PEER_ENDPOINT
{
    PEER_ADDRESS address;
    PWSTR        pwzEndpointName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ns-p2p-peer_people_near_me
struct PEER_PEOPLE_NEAR_ME
{
    PWSTR         pwzNickName;
    PEER_ENDPOINT endpoint;
    GUID          id;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ns-p2p-peer_invitation
struct PEER_INVITATION
{
    GUID      applicationId;
    PEER_DATA applicationData;
    PWSTR     pwzMessage;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ns-p2p-peer_invitation_response
struct PEER_INVITATION_RESPONSE
{
    PEER_INVITATION_RESPONSE_TYPE action;
    PWSTR   pwzMessage;
    HRESULT hrExtendedInfo;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ns-p2p-peer_app_launch_info
struct PEER_APP_LAUNCH_INFO
{
    PEER_CONTACT*    pContact;
    PEER_ENDPOINT*   pEndpoint;
    PEER_INVITATION* pInvitation;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ns-p2p-peer_application_registration_info
struct PEER_APPLICATION_REGISTRATION_INFO
{
    PEER_APPLICATION application;
    PWSTR            pwzApplicationToLaunch;
    PWSTR            pwzApplicationArguments;
    uint             dwPublicationScope;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ns-p2p-peer_presence_info
struct PEER_PRESENCE_INFO
{
    PEER_PRESENCE_STATUS status;
    PWSTR                pwzDescriptiveText;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ns-p2p-peer_collab_event_registration
struct PEER_COLLAB_EVENT_REGISTRATION
{
    PEER_COLLAB_EVENT_TYPE eventType;
    GUID* pInstance;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ns-p2p-peer_event_watchlist_changed_data
struct PEER_EVENT_WATCHLIST_CHANGED_DATA
{
    PEER_CONTACT*    pContact;
    PEER_CHANGE_TYPE changeType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ns-p2p-peer_event_presence_changed_data
struct PEER_EVENT_PRESENCE_CHANGED_DATA
{
    PEER_CONTACT*       pContact;
    PEER_ENDPOINT*      pEndpoint;
    PEER_CHANGE_TYPE    changeType;
    PEER_PRESENCE_INFO* pPresenceInfo;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ns-p2p-peer_event_application_changed_data
struct PEER_EVENT_APPLICATION_CHANGED_DATA
{
    PEER_CONTACT*     pContact;
    PEER_ENDPOINT*    pEndpoint;
    PEER_CHANGE_TYPE  changeType;
    PEER_APPLICATION* pApplication;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ns-p2p-peer_event_object_changed_data
struct PEER_EVENT_OBJECT_CHANGED_DATA
{
    PEER_CONTACT*    pContact;
    PEER_ENDPOINT*   pEndpoint;
    PEER_CHANGE_TYPE changeType;
    PEER_OBJECT*     pObject;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ns-p2p-peer_event_endpoint_changed_data
struct PEER_EVENT_ENDPOINT_CHANGED_DATA
{
    PEER_CONTACT*  pContact;
    PEER_ENDPOINT* pEndpoint;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ns-p2p-peer_event_people_near_me_changed_data
struct PEER_EVENT_PEOPLE_NEAR_ME_CHANGED_DATA
{
    PEER_CHANGE_TYPE     changeType;
    PEER_PEOPLE_NEAR_ME* pPeopleNearMe;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ns-p2p-peer_event_request_status_changed_data
struct PEER_EVENT_REQUEST_STATUS_CHANGED_DATA
{
    PEER_ENDPOINT* pEndpoint;
    HRESULT        hrChange;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ns-p2p-peer_collab_event_data~r1
struct PEER_COLLAB_EVENT_DATA
{
    PEER_COLLAB_EVENT_TYPE eventType;
    union
    {
        PEER_EVENT_WATCHLIST_CHANGED_DATA watchListChangedData;
        PEER_EVENT_PRESENCE_CHANGED_DATA presenceChangedData;
        PEER_EVENT_APPLICATION_CHANGED_DATA applicationChangedData;
        PEER_EVENT_OBJECT_CHANGED_DATA objectChangedData;
        PEER_EVENT_ENDPOINT_CHANGED_DATA endpointChangedData;
        PEER_EVENT_PEOPLE_NEAR_ME_CHANGED_DATA peopleNearMeChangedData;
        PEER_EVENT_REQUEST_STATUS_CHANGED_DATA requestStatusChangedData;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ns-p2p-peer_pnrp_endpoint_info
struct PEER_PNRP_ENDPOINT_INFO
{
    PWSTR      pwzPeerName;
    uint       cAddresses;
    SOCKADDR** ppAddresses;
    PWSTR      pwzComment;
    PEER_DATA  payload;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ns-p2p-peer_pnrp_cloud_info
struct PEER_PNRP_CLOUD_INFO
{
    PWSTR      pwzCloudName;
    PNRP_SCOPE dwScope;
    uint       dwScopeId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/p2p/ns-p2p-peer_pnrp_registration_info
struct PEER_PNRP_REGISTRATION_INFO
{
    PWSTR      pwzCloudName;
    PWSTR      pwzPublishingIdentity;
    uint       cAddresses;
    SOCKADDR** ppAddresses;
    ushort     wPort;
    PWSTR      pwzComment;
    PEER_DATA  payload;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/drt/ns-drt-drt_data
struct DRT_DATA
{
    uint   cb;
    ubyte* pb;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/drt/ns-drt-drt_registration
struct DRT_REGISTRATION
{
    DRT_DATA key;
    DRT_DATA appData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/drt/ns-drt-drt_security_provider
struct DRT_SECURITY_PROVIDER
{
    void*     pvContext;
    ptrdiff_t Attach;
    ptrdiff_t Detach;
    ptrdiff_t RegisterKey;
    ptrdiff_t UnregisterKey;
    ptrdiff_t ValidateAndUnpackPayload;
    ptrdiff_t SecureAndPackPayload;
    ptrdiff_t FreeData;
    ptrdiff_t EncryptData;
    ptrdiff_t DecryptData;
    ptrdiff_t GetSerializedCredential;
    ptrdiff_t ValidateRemoteCredential;
    ptrdiff_t SignData;
    ptrdiff_t VerifyData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/drt/ns-drt-drt_bootstrap_provider
struct DRT_BOOTSTRAP_PROVIDER
{
    void*     pvContext;
    ptrdiff_t Attach;
    ptrdiff_t Detach;
    ptrdiff_t InitResolve;
    ptrdiff_t IssueResolve;
    ptrdiff_t EndResolve;
    ptrdiff_t Register;
    ptrdiff_t Unregister;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/drt/ns-drt-drt_settings
struct DRT_SETTINGS
{
    uint              dwSize;
    uint              cbKey;
    ubyte             bProtocolMajorVersion;
    ubyte             bProtocolMinorVersion;
    uint              ulMaxRoutingAddresses;
    PWSTR             pwzDrtInstancePrefix;
    void*             hTransport;
    DRT_SECURITY_PROVIDER* pSecurityProvider;
    DRT_BOOTSTRAP_PROVIDER* pBootstrapProvider;
    DRT_SECURITY_MODE eSecurityMode;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/drt/ns-drt-drt_search_info
struct DRT_SEARCH_INFO
{
    uint      dwSize;
    BOOL      fIterative;
    BOOL      fAllowCurrentInstanceMatch;
    BOOL      fAnyMatchInRange;
    uint      cMaxEndpoints;
    DRT_DATA* pMaximumKey;
    DRT_DATA* pMinimumKey;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/drt/ns-drt-drt_address
struct DRT_ADDRESS
{
    SOCKADDR_STORAGE socketAddress;
    uint             flags;
    int              nearness;
    uint             latency;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/drt/ns-drt-drt_address_list
struct DRT_ADDRESS_LIST
{
    uint AddressCount;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/DRT_ADDRESS[1] AddressList;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/drt/ns-drt-drt_search_result
struct DRT_SEARCH_RESULT
{
    uint             dwSize;
    DRT_MATCH_TYPE   type;
    void*            pvContext;
    DRT_REGISTRATION registration;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/drt/ns-drt-drt_event_data
struct DRT_EVENT_DATA
{
    DRT_EVENT_TYPE type;
    HRESULT        hr;
    void*          pvContext;
    union
    {
        struct leafsetKeyChange
        {
            DRT_LEAFSET_KEY_CHANGE_TYPE change;
            DRT_DATA localKey;
            DRT_DATA remoteKey;
        }
        struct registrationStateChange
        {
            DRT_REGISTRATION_STATE state;
            DRT_DATA localKey;
        }
        struct statusChange
        {
            DRT_STATUS status;
            struct bootstrapAddresses
            {
                uint              cntAddress;
                SOCKADDR_STORAGE* pAddresses;
            }
        }
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/peerdist/ns-peerdist-peerdist_publication_options
struct PEERDIST_PUBLICATION_OPTIONS
{
    uint dwVersion;
    uint dwFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/peerdist/ns-peerdist-peerdist_content_tag
struct PEERDIST_CONTENT_TAG
{
    ubyte[16] Data;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/peerdist/ns-peerdist-peerdist_retrieval_options
struct PEERDIST_RETRIEVAL_OPTIONS
{
    uint cbSize;
    uint dwContentInfoMinVersion;
    uint dwContentInfoMaxVersion;
    uint dwReserved;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/peerdist/ns-peerdist-peerdist_status_info
struct PEERDIST_STATUS_INFO
{
    uint            cbSize;
    PEERDIST_STATUS status;
    PEERDIST_RETRIEVAL_OPTIONS_CONTENTINFO_VERSION_VALUE dwMinVer;
    PEERDIST_RETRIEVAL_OPTIONS_CONTENTINFO_VERSION_VALUE dwMaxVer;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/peerdist/ns-peerdist-peerdist_client_basic_info
struct PEERDIST_CLIENT_BASIC_INFO
{
    BOOL fFlashCrowd;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphStartup(ushort wVersionRequested, PEER_VERSION_DATA* pVersionData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphShutdown();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2PGRAPH.dll")
void PeerGraphFreeData(void* pvData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphGetItemCount(void* hPeerEnum, uint* pCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphGetNextItem(void* hPeerEnum, uint* pCount, void*** pppvItems);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphEndEnumeration(void* hPeerEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphCreate(PEER_GRAPH_PROPERTIES* pGraphProperties, const(PWSTR) pwzDatabaseName, 
                        PEER_SECURITY_INTERFACE* pSecurityInterface, void** phGraph);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphOpen(const(PWSTR) pwzGraphId, const(PWSTR) pwzPeerId, const(PWSTR) pwzDatabaseName, 
                      PEER_SECURITY_INTERFACE* pSecurityInterface, uint cRecordTypeSyncPrecedence, 
                      const(GUID)* pRecordTypeSyncPrecedence, void** phGraph);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphListen(void* hGraph, uint dwScope, uint dwScopeId, ushort wPort);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphConnect(void* hGraph, const(PWSTR) pwzPeerId, PEER_ADDRESS* pAddress, ulong* pullConnectionId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphClose(void* hGraph);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphDelete(const(PWSTR) pwzGraphId, const(PWSTR) pwzPeerId, const(PWSTR) pwzDatabaseName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphGetStatus(void* hGraph, uint* pdwStatus);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphGetProperties(void* hGraph, PEER_GRAPH_PROPERTIES** ppGraphProperties);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphSetProperties(void* hGraph, PEER_GRAPH_PROPERTIES* pGraphProperties);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphRegisterEvent(void* hGraph, HANDLE hEvent, uint cEventRegistrations, 
                               PEER_GRAPH_EVENT_REGISTRATION* pEventRegistrations, void** phPeerEvent);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphUnregisterEvent(void* hPeerEvent);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphGetEventData(void* hPeerEvent, PEER_GRAPH_EVENT_DATA** ppEventData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphGetRecord(void* hGraph, const(GUID)* pRecordId, PEER_RECORD** ppRecord);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphAddRecord(void* hGraph, PEER_RECORD* pRecord, GUID* pRecordId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphUpdateRecord(void* hGraph, PEER_RECORD* pRecord);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphDeleteRecord(void* hGraph, const(GUID)* pRecordId, BOOL fLocal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphEnumRecords(void* hGraph, const(GUID)* pRecordType, const(PWSTR) pwzPeerId, void** phPeerEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphSearchRecords(void* hGraph, const(PWSTR) pwzCriteria, void** phPeerEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphExportDatabase(void* hGraph, const(PWSTR) pwzFilePath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphImportDatabase(void* hGraph, const(PWSTR) pwzFilePath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphValidateDeferredRecords(void* hGraph, uint cRecordIds, const(GUID)* pRecordIds);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphOpenDirectConnection(void* hGraph, const(PWSTR) pwzPeerId, PEER_ADDRESS* pAddress, 
                                      ulong* pullConnectionId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphSendData(void* hGraph, ulong ullConnectionId, const(GUID)* pType, uint cbData, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pvData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphCloseDirectConnection(void* hGraph, ulong ullConnectionId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphEnumConnections(void* hGraph, uint dwFlags, void** phPeerEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphEnumNodes(void* hGraph, const(PWSTR) pwzPeerId, void** phPeerEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphSetPresence(void* hGraph, BOOL fPresent);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphGetNodeInfo(void* hGraph, ulong ullNodeId, PEER_NODE_INFO** ppNodeInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphSetNodeAttributes(void* hGraph, const(PWSTR) pwzAttributes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphPeerTimeToUniversalTime(void* hGraph, FILETIME* pftPeerTime, FILETIME* pftUniversalTime);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2PGRAPH.dll")
HRESULT PeerGraphUniversalTimeToPeerTime(void* hGraph, FILETIME* pftUniversalTime, FILETIME* pftPeerTime);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
void PeerFreeData(const(void)* pvData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerGetItemCount(void* hPeerEnum, uint* pCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerGetNextItem(void* hPeerEnum, uint* pCount, void*** pppvItems);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerEndEnumeration(void* hPeerEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerGroupStartup(ushort wVersionRequested, PEER_VERSION_DATA* pVersionData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerGroupShutdown();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerGroupCreate(PEER_GROUP_PROPERTIES* pProperties, void** phGroup);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerGroupOpen(const(PWSTR) pwzIdentity, const(PWSTR) pwzGroupPeerName, const(PWSTR) pwzCloud, 
                      void** phGroup);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerGroupJoin(const(PWSTR) pwzIdentity, const(PWSTR) pwzInvitation, const(PWSTR) pwzCloud, void** phGroup);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerGroupPasswordJoin(const(PWSTR) pwzIdentity, const(PWSTR) pwzInvitation, const(PWSTR) pwzPassword, 
                              const(PWSTR) pwzCloud, void** phGroup);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerGroupConnect(void* hGroup);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerGroupConnectByAddress(void* hGroup, uint cAddresses, PEER_ADDRESS* pAddresses);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerGroupClose(void* hGroup);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerGroupDelete(const(PWSTR) pwzIdentity, const(PWSTR) pwzGroupPeerName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerGroupCreateInvitation(void* hGroup, const(PWSTR) pwzIdentityInfo, FILETIME* pftExpiration, uint cRoles, 
                                  const(GUID)* pRoles, PWSTR* ppwzInvitation);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerGroupCreatePasswordInvitation(void* hGroup, PWSTR* ppwzInvitation);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerGroupParseInvitation(const(PWSTR) pwzInvitation, PEER_INVITATION_INFO** ppInvitationInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerGroupGetStatus(void* hGroup, uint* pdwStatus);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerGroupGetProperties(void* hGroup, PEER_GROUP_PROPERTIES** ppProperties);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerGroupSetProperties(void* hGroup, PEER_GROUP_PROPERTIES* pProperties);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerGroupEnumMembers(void* hGroup, uint dwFlags, const(PWSTR) pwzIdentity, void** phPeerEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerGroupOpenDirectConnection(void* hGroup, const(PWSTR) pwzIdentity, PEER_ADDRESS* pAddress, 
                                      ulong* pullConnectionId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerGroupCloseDirectConnection(void* hGroup, ulong ullConnectionId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerGroupEnumConnections(void* hGroup, uint dwFlags, void** phPeerEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerGroupSendData(void* hGroup, ulong ullConnectionId, const(GUID)* pType, uint cbData, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pvData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerGroupRegisterEvent(void* hGroup, HANDLE hEvent, uint cEventRegistration, 
                               PEER_GROUP_EVENT_REGISTRATION* pEventRegistrations, void** phPeerEvent);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerGroupUnregisterEvent(void* hPeerEvent);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerGroupGetEventData(void* hPeerEvent, PEER_GROUP_EVENT_DATA** ppEventData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerGroupGetRecord(void* hGroup, const(GUID)* pRecordId, PEER_RECORD** ppRecord);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerGroupAddRecord(void* hGroup, PEER_RECORD* pRecord, GUID* pRecordId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerGroupUpdateRecord(void* hGroup, PEER_RECORD* pRecord);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerGroupDeleteRecord(void* hGroup, const(GUID)* pRecordId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerGroupEnumRecords(void* hGroup, const(GUID)* pRecordType, void** phPeerEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerGroupSearchRecords(void* hGroup, const(PWSTR) pwzCriteria, void** phPeerEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerGroupExportDatabase(void* hGroup, const(PWSTR) pwzFilePath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerGroupImportDatabase(void* hGroup, const(PWSTR) pwzFilePath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerGroupIssueCredentials(void* hGroup, const(PWSTR) pwzSubjectIdentity, 
                                  PEER_CREDENTIAL_INFO* pCredentialInfo, uint dwFlags, PWSTR* ppwzInvitation);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerGroupExportConfig(void* hGroup, const(PWSTR) pwzPassword, PWSTR* ppwzXML);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerGroupImportConfig(const(PWSTR) pwzXML, const(PWSTR) pwzPassword, BOOL fOverwrite, PWSTR* ppwzIdentity, 
                              PWSTR* ppwzGroup);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerGroupPeerTimeToUniversalTime(void* hGroup, FILETIME* pftPeerTime, FILETIME* pftUniversalTime);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerGroupUniversalTimeToPeerTime(void* hGroup, FILETIME* pftUniversalTime, FILETIME* pftPeerTime);

deprecated("marked as obsolete") 
@DllImport("P2P.dll")
HRESULT PeerGroupResumePasswordAuthentication(void* hGroup, void* hPeerEventHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerIdentityCreate(const(PWSTR) pwzClassifier, const(PWSTR) pwzFriendlyName, size_t hCryptProv, 
                           PWSTR* ppwzIdentity);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerIdentityGetFriendlyName(const(PWSTR) pwzIdentity, PWSTR* ppwzFriendlyName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerIdentitySetFriendlyName(const(PWSTR) pwzIdentity, const(PWSTR) pwzFriendlyName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerIdentityGetCryptKey(const(PWSTR) pwzIdentity, size_t* phCryptProv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerIdentityDelete(const(PWSTR) pwzIdentity);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerEnumIdentities(void** phPeerEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerEnumGroups(const(PWSTR) pwzIdentity, void** phPeerEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerCreatePeerName(const(PWSTR) pwzIdentity, const(PWSTR) pwzClassifier, PWSTR* ppwzPeerName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerIdentityGetXML(const(PWSTR) pwzIdentity, PWSTR* ppwzIdentityXML);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerIdentityExport(const(PWSTR) pwzIdentity, const(PWSTR) pwzPassword, PWSTR* ppwzExportXML);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerIdentityImport(const(PWSTR) pwzImportXML, const(PWSTR) pwzPassword, PWSTR* ppwzIdentity);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerIdentityGetDefault(PWSTR* ppwzPeerName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("P2P.dll")
HRESULT PeerCollabStartup(ushort wVersionRequested);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("P2P.dll")
HRESULT PeerCollabShutdown();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("P2P.dll")
HRESULT PeerCollabSignin(HWND hwndParent, uint dwSigninOptions);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("P2P.dll")
HRESULT PeerCollabSignout(uint dwSigninOptions);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("P2P.dll")
HRESULT PeerCollabGetSigninOptions(uint* pdwSigninOptions);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("P2P.dll")
HRESULT PeerCollabAsyncInviteContact(PEER_CONTACT* pcContact, PEER_ENDPOINT* pcEndpoint, 
                                     PEER_INVITATION* pcInvitation, HANDLE hEvent, HANDLE* phInvitation);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("P2P.dll")
HRESULT PeerCollabGetInvitationResponse(HANDLE hInvitation, PEER_INVITATION_RESPONSE** ppInvitationResponse);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("P2P.dll")
HRESULT PeerCollabCancelInvitation(HANDLE hInvitation);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("P2P.dll")
HRESULT PeerCollabCloseHandle(HANDLE hInvitation);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("P2P.dll")
HRESULT PeerCollabInviteContact(PEER_CONTACT* pcContact, PEER_ENDPOINT* pcEndpoint, PEER_INVITATION* pcInvitation, 
                                PEER_INVITATION_RESPONSE** ppResponse);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("P2P.dll")
HRESULT PeerCollabAsyncInviteEndpoint(PEER_ENDPOINT* pcEndpoint, PEER_INVITATION* pcInvitation, HANDLE hEvent, 
                                      HANDLE* phInvitation);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("P2P.dll")
HRESULT PeerCollabInviteEndpoint(PEER_ENDPOINT* pcEndpoint, PEER_INVITATION* pcInvitation, 
                                 PEER_INVITATION_RESPONSE** ppResponse);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("P2P.dll")
HRESULT PeerCollabGetAppLaunchInfo(PEER_APP_LAUNCH_INFO** ppLaunchInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("P2P.dll")
HRESULT PeerCollabRegisterApplication(PEER_APPLICATION_REGISTRATION_INFO* pcApplication, 
                                      PEER_APPLICATION_REGISTRATION_TYPE registrationType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("P2P.dll")
HRESULT PeerCollabUnregisterApplication(const(GUID)* pApplicationId, 
                                        PEER_APPLICATION_REGISTRATION_TYPE registrationType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("P2P.dll")
HRESULT PeerCollabGetApplicationRegistrationInfo(const(GUID)* pApplicationId, 
                                                 PEER_APPLICATION_REGISTRATION_TYPE registrationType, 
                                                 PEER_APPLICATION_REGISTRATION_INFO** ppApplication);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("P2P.dll")
HRESULT PeerCollabEnumApplicationRegistrationInfo(PEER_APPLICATION_REGISTRATION_TYPE registrationType, 
                                                  void** phPeerEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("P2P.dll")
HRESULT PeerCollabGetPresenceInfo(PEER_ENDPOINT* pcEndpoint, PEER_PRESENCE_INFO** ppPresenceInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("P2P.dll")
HRESULT PeerCollabEnumApplications(PEER_ENDPOINT* pcEndpoint, const(GUID)* pApplicationId, void** phPeerEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("P2P.dll")
HRESULT PeerCollabEnumObjects(PEER_ENDPOINT* pcEndpoint, const(GUID)* pObjectId, void** phPeerEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("P2P.dll")
HRESULT PeerCollabEnumEndpoints(PEER_CONTACT* pcContact, void** phPeerEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("P2P.dll")
HRESULT PeerCollabRefreshEndpointData(PEER_ENDPOINT* pcEndpoint);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("P2P.dll")
HRESULT PeerCollabDeleteEndpointData(PEER_ENDPOINT* pcEndpoint);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("P2P.dll")
HRESULT PeerCollabQueryContactData(PEER_ENDPOINT* pcEndpoint, PWSTR* ppwzContactData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("P2P.dll")
HRESULT PeerCollabSubscribeEndpointData(const(PEER_ENDPOINT)* pcEndpoint);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("P2P.dll")
HRESULT PeerCollabUnsubscribeEndpointData(const(PEER_ENDPOINT)* pcEndpoint);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("P2P.dll")
HRESULT PeerCollabSetPresenceInfo(PEER_PRESENCE_INFO* pcPresenceInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("P2P.dll")
HRESULT PeerCollabGetEndpointName(PWSTR* ppwzEndpointName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("P2P.dll")
HRESULT PeerCollabSetEndpointName(const(PWSTR) pwzEndpointName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("P2P.dll")
HRESULT PeerCollabSetObject(PEER_OBJECT* pcObject);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("P2P.dll")
HRESULT PeerCollabDeleteObject(const(GUID)* pObjectId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("P2P.dll")
HRESULT PeerCollabRegisterEvent(HANDLE hEvent, uint cEventRegistration, 
                                PEER_COLLAB_EVENT_REGISTRATION* pEventRegistrations, void** phPeerEvent);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("P2P.dll")
HRESULT PeerCollabGetEventData(void* hPeerEvent, PEER_COLLAB_EVENT_DATA** ppEventData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("P2P.dll")
HRESULT PeerCollabUnregisterEvent(void* hPeerEvent);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("P2P.dll")
HRESULT PeerCollabEnumPeopleNearMe(void** phPeerEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("P2P.dll")
HRESULT PeerCollabAddContact(const(PWSTR) pwzContactData, PEER_CONTACT** ppContact);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("P2P.dll")
HRESULT PeerCollabDeleteContact(const(PWSTR) pwzPeerName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("P2P.dll")
HRESULT PeerCollabGetContact(const(PWSTR) pwzPeerName, PEER_CONTACT** ppContact);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("P2P.dll")
HRESULT PeerCollabUpdateContact(PEER_CONTACT* pContact);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("P2P.dll")
HRESULT PeerCollabEnumContacts(void** phPeerEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("P2P.dll")
HRESULT PeerCollabExportContact(const(PWSTR) pwzPeerName, PWSTR* ppwzContactData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("P2P.dll")
HRESULT PeerCollabParseContact(const(PWSTR) pwzContactData, PEER_CONTACT** ppContact);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerNameToPeerHostName(const(PWSTR) pwzPeerName, PWSTR* ppwzHostName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerHostNameToPeerName(const(PWSTR) pwzHostName, PWSTR* ppwzPeerName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerPnrpStartup(ushort wVersionRequested);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerPnrpShutdown();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerPnrpRegister(const(PWSTR) pcwzPeerName, PEER_PNRP_REGISTRATION_INFO* pRegistrationInfo, 
                         void** phRegistration);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerPnrpUpdateRegistration(void* hRegistration, PEER_PNRP_REGISTRATION_INFO* pRegistrationInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerPnrpUnregister(void* hRegistration);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerPnrpResolve(const(PWSTR) pcwzPeerName, const(PWSTR) pcwzCloudName, uint* pcEndpoints, 
                        PEER_PNRP_ENDPOINT_INFO** ppEndpoints);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerPnrpStartResolve(const(PWSTR) pcwzPeerName, const(PWSTR) pcwzCloudName, uint cMaxEndpoints, 
                             HANDLE hEvent, void** phResolve);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerPnrpGetCloudInfo(uint* pcNumClouds, PEER_PNRP_CLOUD_INFO** ppCloudInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerPnrpGetEndpoint(void* hResolve, PEER_PNRP_ENDPOINT_INFO** ppEndpoint);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("P2P.dll")
HRESULT PeerPnrpEndResolve(void* hResolve);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("drtprov.dll")
HRESULT DrtCreatePnrpBootstrapResolver(BOOL fPublish, const(PWSTR) pwzPeerName, const(PWSTR) pwzCloudName, 
                                       const(PWSTR) pwzPublishingIdentity, DRT_BOOTSTRAP_PROVIDER** ppResolver);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("drtprov.dll")
void DrtDeletePnrpBootstrapResolver(DRT_BOOTSTRAP_PROVIDER* pResolver);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("drtprov.dll")
HRESULT DrtCreateDnsBootstrapResolver(ushort port, const(PWSTR) pwszAddress, DRT_BOOTSTRAP_PROVIDER** ppModule);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("drtprov.dll")
void DrtDeleteDnsBootstrapResolver(DRT_BOOTSTRAP_PROVIDER* pResolver);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("drttransport.dll")
HRESULT DrtCreateIpv6UdpTransport(DRT_SCOPE scope_, uint dwScopeId, uint dwLocalityThreshold, ushort* pwPort, 
                                  void** phTransport);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("drttransport.dll")
HRESULT DrtDeleteIpv6UdpTransport(void* hTransport);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("drtprov.dll")
HRESULT DrtCreateDerivedKeySecurityProvider(const(CERT_CONTEXT)* pRootCert, const(CERT_CONTEXT)* pLocalCert, 
                                            DRT_SECURITY_PROVIDER** ppSecurityProvider);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("drtprov.dll")
HRESULT DrtCreateDerivedKey(const(CERT_CONTEXT)* pLocalCert, DRT_DATA* pKey);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("drtprov.dll")
void DrtDeleteDerivedKeySecurityProvider(DRT_SECURITY_PROVIDER* pSecurityProvider);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("drtprov.dll")
HRESULT DrtCreateNullSecurityProvider(DRT_SECURITY_PROVIDER** ppSecurityProvider);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("drtprov.dll")
void DrtDeleteNullSecurityProvider(DRT_SECURITY_PROVIDER* pSecurityProvider);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("drt.dll")
HRESULT DrtOpen(const(DRT_SETTINGS)* pSettings, HANDLE hEvent, const(void)* pvContext, void** phDrt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("drt.dll")
void DrtClose(void* hDrt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("drt.dll")
HRESULT DrtGetEventDataSize(void* hDrt, uint* pulEventDataLen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("drt.dll")
HRESULT DrtGetEventData(void* hDrt, uint ulEventDataLen, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/DRT_EVENT_DATA* pEventData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("drt.dll")
HRESULT DrtRegisterKey(void* hDrt, DRT_REGISTRATION* pRegistration, void* pvKeyContext, void** phKeyRegistration);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("drt.dll")
HRESULT DrtUpdateKey(void* hKeyRegistration, DRT_DATA* pAppData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("drt.dll")
void DrtUnregisterKey(void* hKeyRegistration);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("drt.dll")
HRESULT DrtStartSearch(void* hDrt, DRT_DATA* pKey, const(DRT_SEARCH_INFO)* pInfo, uint timeout, HANDLE hEvent, 
                       const(void)* pvContext, void** hSearchContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("drt.dll")
HRESULT DrtContinueSearch(void* hSearchContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("drt.dll")
HRESULT DrtGetSearchResultSize(void* hSearchContext, uint* pulSearchResultSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("drt.dll")
HRESULT DrtGetSearchResult(void* hSearchContext, uint ulSearchResultSize, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/DRT_SEARCH_RESULT* pSearchResult);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("drt.dll")
HRESULT DrtGetSearchPathSize(void* hSearchContext, uint* pulSearchPathSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("drt.dll")
HRESULT DrtGetSearchPath(void* hSearchContext, uint ulSearchPathSize, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/DRT_ADDRESS_LIST* pSearchPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("drt.dll")
HRESULT DrtEndSearch(void* hSearchContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("drt.dll")
HRESULT DrtGetInstanceName(void* hDrt, uint ulcbInstanceNameSize, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/PWSTR pwzDrtInstanceName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("drt.dll")
HRESULT DrtGetInstanceNameSize(void* hDrt, uint* pulcbInstanceNameSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("PeerDist.dll")
uint PeerDistStartup(uint dwVersionRequested, ptrdiff_t* phPeerDist, uint* pdwSupportedVersion);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("PeerDist.dll")
uint PeerDistShutdown(ptrdiff_t hPeerDist);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("PeerDist.dll")
uint PeerDistGetStatus(ptrdiff_t hPeerDist, PEERDIST_STATUS* pPeerDistStatus);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("PeerDist.dll")
uint PeerDistRegisterForStatusChangeNotification(ptrdiff_t hPeerDist, HANDLE hCompletionPort, 
                                                 size_t ulCompletionKey, OVERLAPPED* lpOverlapped, 
                                                 PEERDIST_STATUS* pPeerDistStatus);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("PeerDist.dll")
uint PeerDistUnregisterForStatusChangeNotification(ptrdiff_t hPeerDist);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("PeerDist.dll")
uint PeerDistServerPublishStream(ptrdiff_t hPeerDist, uint cbContentIdentifier, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/ubyte* pContentIdentifier, 
                                 ulong cbContentLength, PEERDIST_PUBLICATION_OPTIONS* pPublishOptions, 
                                 HANDLE hCompletionPort, size_t ulCompletionKey, ptrdiff_t* phStream);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("PeerDist.dll")
uint PeerDistServerPublishAddToStream(ptrdiff_t hPeerDist, ptrdiff_t hStream, uint cbNumberOfBytes, 
                                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ubyte* pBuffer, 
                                      OVERLAPPED* lpOverlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("PeerDist.dll")
uint PeerDistServerPublishCompleteStream(ptrdiff_t hPeerDist, ptrdiff_t hStream, OVERLAPPED* lpOverlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("PeerDist.dll")
uint PeerDistServerCloseStreamHandle(ptrdiff_t hPeerDist, ptrdiff_t hStream);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("PeerDist.dll")
uint PeerDistServerUnpublish(ptrdiff_t hPeerDist, uint cbContentIdentifier, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/ubyte* pContentIdentifier);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("PeerDist.dll")
uint PeerDistServerOpenContentInformation(ptrdiff_t hPeerDist, uint cbContentIdentifier, 
                                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/ubyte* pContentIdentifier, 
                                          ulong ullContentOffset, ulong cbContentLength, HANDLE hCompletionPort, 
                                          size_t ulCompletionKey, ptrdiff_t* phContentInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("PeerDist.dll")
uint PeerDistServerRetrieveContentInformation(ptrdiff_t hPeerDist, ptrdiff_t hContentInfo, uint cbMaxNumberOfBytes, 
                                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ubyte* pBuffer, 
                                              OVERLAPPED* lpOverlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("PeerDist.dll")
uint PeerDistServerCloseContentInformation(ptrdiff_t hPeerDist, ptrdiff_t hContentInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("PeerDist.dll")
uint PeerDistServerCancelAsyncOperation(ptrdiff_t hPeerDist, uint cbContentIdentifier, 
                                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/ubyte* pContentIdentifier, 
                                        OVERLAPPED* pOverlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("PeerDist.dll")
uint PeerDistClientOpenContent(ptrdiff_t hPeerDist, PEERDIST_CONTENT_TAG* pContentTag, HANDLE hCompletionPort, 
                               size_t ulCompletionKey, ptrdiff_t* phContentHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("PeerDist.dll")
uint PeerDistClientCloseContent(ptrdiff_t hPeerDist, ptrdiff_t hContentHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("PeerDist.dll")
uint PeerDistClientAddContentInformation(ptrdiff_t hPeerDist, ptrdiff_t hContentHandle, uint cbNumberOfBytes, 
                                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ubyte* pBuffer, 
                                         OVERLAPPED* lpOverlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("PeerDist.dll")
uint PeerDistClientCompleteContentInformation(ptrdiff_t hPeerDist, ptrdiff_t hContentHandle, 
                                              OVERLAPPED* lpOverlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("PeerDist.dll")
uint PeerDistClientAddData(ptrdiff_t hPeerDist, ptrdiff_t hContentHandle, uint cbNumberOfBytes, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ubyte* pBuffer, 
                           OVERLAPPED* lpOverlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("PeerDist.dll")
uint PeerDistClientBlockRead(ptrdiff_t hPeerDist, ptrdiff_t hContentHandle, uint cbMaxNumberOfBytes, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ubyte* pBuffer, 
                             uint dwTimeoutInMilliseconds, OVERLAPPED* lpOverlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("PeerDist.dll")
uint PeerDistClientStreamRead(ptrdiff_t hPeerDist, ptrdiff_t hContentHandle, uint cbMaxNumberOfBytes, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ubyte* pBuffer, 
                              uint dwTimeoutInMilliseconds, OVERLAPPED* lpOverlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("PeerDist.dll")
uint PeerDistClientFlushContent(ptrdiff_t hPeerDist, PEERDIST_CONTENT_TAG* pContentTag, HANDLE hCompletionPort, 
                                size_t ulCompletionKey, OVERLAPPED* lpOverlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("PeerDist.dll")
uint PeerDistClientCancelAsyncOperation(ptrdiff_t hPeerDist, ptrdiff_t hContentHandle, OVERLAPPED* pOverlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("PeerDist.dll")
uint PeerDistGetStatusEx(ptrdiff_t hPeerDist, PEERDIST_STATUS_INFO* pPeerDistStatus);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("PeerDist.dll")
uint PeerDistRegisterForStatusChangeNotificationEx(ptrdiff_t hPeerDist, HANDLE hCompletionPort, 
                                                   size_t ulCompletionKey, OVERLAPPED* lpOverlapped, 
                                                   PEERDIST_STATUS_INFO* pPeerDistStatus);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("PeerDist.dll")
BOOL PeerDistGetOverlappedResult(OVERLAPPED* lpOverlapped, uint* lpNumberOfBytesTransferred, BOOL bWait);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("PeerDist.dll")
uint PeerDistServerOpenContentInformationEx(ptrdiff_t hPeerDist, uint cbContentIdentifier, 
                                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/ubyte* pContentIdentifier, 
                                            ulong ullContentOffset, ulong cbContentLength, 
                                            PEERDIST_RETRIEVAL_OPTIONS* pRetrievalOptions, HANDLE hCompletionPort, 
                                            size_t ulCompletionKey, ptrdiff_t* phContentInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("PeerDist.dll")
uint PeerDistClientGetInformationByHandle(ptrdiff_t hPeerDist, ptrdiff_t hContentHandle, 
                                          PEERDIST_CLIENT_INFO_BY_HANDLE_CLASS PeerDistClientInfoClass, 
                                          uint dwBufferSize, 
                                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpInformation);


