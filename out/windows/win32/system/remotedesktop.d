// Written in the D programming language.

module windows.win32.system.remotedesktop;

public import windows.core;
public import windows.win32.foundation.foundation : BOOL, BOOLEAN, BSTR, CHAR, FILETIME,
                                                    HANDLE, HANDLE_PTR, HRESULT, HWND,
                                                    PSTR, PWSTR, RECT, VARIANT_BOOL;
public import windows.win32.media.audio.apo : APO_CONNECTION_PROPERTY;
public import windows.win32.media.audio.audio : WAVEFORMATEX;
public import windows.win32.security.security : OBJECT_SECURITY_INFORMATION, PSECURITY_DESCRIPTOR,
                                                PSID;
public import windows.win32.system.com.com : IDispatch, IUnknown, SAFEARRAY;
public import windows.win32.system.com.structuredstorage : IPropertyBag;
public import windows.win32.system.variant : VARIANT;
public import windows.win32.system.winrt.winrt : HSTRING;
public import windows.win32.ui.windowsandmessaging : MESSAGEBOX_RESULT, MESSAGEBOX_STYLE;

extern(Windows) @nogc nothrow:


// Enums


alias WTS_SECURITY_FLAGS = uint;
enum : uint
{
    WTS_SECURITY_CURRENT_GUEST_ACCESS = 0x00000048U,
    WTS_SECURITY_USER_ACCESS          = 0x00000149U,
    WTS_SECURITY_CURRENT_USER_ACCESS  = 0x0000024eU,
    WTS_SECURITY_ALL_ACCESS           = 0x000f03bfU,
    WTS_SECURITY_QUERY_INFORMATION    = 0x00000001U,
    WTS_SECURITY_SET_INFORMATION      = 0x00000002U,
    WTS_SECURITY_RESET                = 0x00000004U,
    WTS_SECURITY_VIRTUAL_CHANNELS     = 0x00000008U,
    WTS_SECURITY_REMOTE_CONTROL       = 0x00000010U,
    WTS_SECURITY_LOGON                = 0x00000020U,
    WTS_SECURITY_LOGOFF               = 0x00000040U,
    WTS_SECURITY_MESSAGE              = 0x00000080U,
    WTS_SECURITY_CONNECT              = 0x00000100U,
    WTS_SECURITY_DISCONNECT           = 0x00000200U,
    WTS_SECURITY_GUEST_ACCESS         = 0x00000020U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/ne-audioengineendpoint-ae_position_flags
alias AE_POSITION_FLAGS = int;
enum : int
{
    POSITION_INVALID       = 0x00000000,
    POSITION_DISCONTINUOUS = 0x00000001,
    POSITION_CONTINUOUS    = 0x00000002,
    POSITION_QPC_ERROR     = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsgpolicyengine/ne-tsgpolicyengine-aaauthschemes
enum AAAuthSchemes : int
{
    AA_AUTH_MIN                 = 0x00000000,
    AA_AUTH_BASIC               = 0x00000001,
    AA_AUTH_NTLM                = 0x00000002,
    AA_AUTH_SC                  = 0x00000003,
    AA_AUTH_LOGGEDONCREDENTIALS = 0x00000004,
    AA_AUTH_NEGOTIATE           = 0x00000005,
    AA_AUTH_ANY                 = 0x00000006,
    AA_AUTH_COOKIE              = 0x00000007,
    AA_AUTH_DIGEST              = 0x00000008,
    AA_AUTH_ORGID               = 0x00000009,
    AA_AUTH_CONID               = 0x0000000a,
    AA_AUTH_SSPI_NTLM           = 0x0000000b,
    AA_AUTH_MAX                 = 0x0000000c,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsgpolicyengine/ne-tsgpolicyengine-aaaccountingdatatype
enum AAAccountingDataType : int
{
    AA_MAIN_SESSION_CREATION = 0x00000000,
    AA_SUB_SESSION_CREATION  = 0x00000001,
    AA_SUB_SESSION_CLOSED    = 0x00000002,
    AA_MAIN_SESSION_CLOSED   = 0x00000003,
}

alias SESSION_TIMEOUT_ACTION_TYPE = int;
enum : int
{
    SESSION_TIMEOUT_ACTION_DISCONNECT    = 0x00000000,
    SESSION_TIMEOUT_ACTION_SILENT_REAUTH = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsgpolicyengine/ne-tsgpolicyengine-policyattributetype
enum PolicyAttributeType : int
{
    EnableAllRedirections        = 0x00000000,
    DisableAllRedirections       = 0x00000001,
    DriveRedirectionDisabled     = 0x00000002,
    PrinterRedirectionDisabled   = 0x00000003,
    PortRedirectionDisabled      = 0x00000004,
    ClipboardRedirectionDisabled = 0x00000005,
    PnpRedirectionDisabled       = 0x00000006,
    AllowOnlySDRServers          = 0x00000007,
}

alias AATrustClassID = int;
enum : int
{
    AA_UNTRUSTED                   = 0x00000000,
    AA_TRUSTEDUSER_UNTRUSTEDCLIENT = 0x00000001,
    AA_TRUSTEDUSER_TRUSTEDCLIENT   = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsapi32/ne-wtsapi32-wts_connectstate_class
alias WTS_CONNECTSTATE_CLASS = int;
enum : int
{
    WTSActive       = 0x00000000,
    WTSConnected    = 0x00000001,
    WTSConnectQuery = 0x00000002,
    WTSShadow       = 0x00000003,
    WTSDisconnected = 0x00000004,
    WTSIdle         = 0x00000005,
    WTSListen       = 0x00000006,
    WTSReset        = 0x00000007,
    WTSDown         = 0x00000008,
    WTSInit         = 0x00000009,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsapi32/ne-wtsapi32-wts_info_class
alias WTS_INFO_CLASS = int;
enum : int
{
    WTSInitialProgram     = 0x00000000,
    WTSApplicationName    = 0x00000001,
    WTSWorkingDirectory   = 0x00000002,
    WTSOEMId              = 0x00000003,
    WTSSessionId          = 0x00000004,
    WTSUserName           = 0x00000005,
    WTSWinStationName     = 0x00000006,
    WTSDomainName         = 0x00000007,
    WTSConnectState       = 0x00000008,
    WTSClientBuildNumber  = 0x00000009,
    WTSClientName         = 0x0000000a,
    WTSClientDirectory    = 0x0000000b,
    WTSClientProductId    = 0x0000000c,
    WTSClientHardwareId   = 0x0000000d,
    WTSClientAddress      = 0x0000000e,
    WTSClientDisplay      = 0x0000000f,
    WTSClientProtocolType = 0x00000010,
    WTSIdleTime           = 0x00000011,
    WTSLogonTime          = 0x00000012,
    WTSIncomingBytes      = 0x00000013,
    WTSOutgoingBytes      = 0x00000014,
    WTSIncomingFrames     = 0x00000015,
    WTSOutgoingFrames     = 0x00000016,
    WTSClientInfo         = 0x00000017,
    WTSSessionInfo        = 0x00000018,
    WTSSessionInfoEx      = 0x00000019,
    WTSConfigInfo         = 0x0000001a,
    WTSValidationInfo     = 0x0000001b,
    WTSSessionAddressV4   = 0x0000001c,
    WTSIsRemoteSession    = 0x0000001d,
    WTSSessionActivityId  = 0x0000001e,
    WTSCapabilityCheck    = 0x0000001f,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsapi32/ne-wtsapi32-wts_config_class
alias WTS_CONFIG_CLASS = int;
enum : int
{
    WTSUserConfigInitialProgram                = 0x00000000,
    WTSUserConfigWorkingDirectory              = 0x00000001,
    WTSUserConfigfInheritInitialProgram        = 0x00000002,
    WTSUserConfigfAllowLogonTerminalServer     = 0x00000003,
    WTSUserConfigTimeoutSettingsConnections    = 0x00000004,
    WTSUserConfigTimeoutSettingsDisconnections = 0x00000005,
    WTSUserConfigTimeoutSettingsIdle           = 0x00000006,
    WTSUserConfigfDeviceClientDrives           = 0x00000007,
    WTSUserConfigfDeviceClientPrinters         = 0x00000008,
    WTSUserConfigfDeviceClientDefaultPrinter   = 0x00000009,
    WTSUserConfigBrokenTimeoutSettings         = 0x0000000a,
    WTSUserConfigReconnectSettings             = 0x0000000b,
    WTSUserConfigModemCallbackSettings         = 0x0000000c,
    WTSUserConfigModemCallbackPhoneNumber      = 0x0000000d,
    WTSUserConfigShadowingSettings             = 0x0000000e,
    WTSUserConfigTerminalServerProfilePath     = 0x0000000f,
    WTSUserConfigTerminalServerHomeDir         = 0x00000010,
    WTSUserConfigTerminalServerHomeDirDrive    = 0x00000011,
    WTSUserConfigfTerminalServerRemoteHomeDir  = 0x00000012,
    WTSUserConfigUser                          = 0x00000013,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsapi32/ne-wtsapi32-wts_config_source
alias WTS_CONFIG_SOURCE = int;
enum : int
{
    WTSUserConfigSourceSAM = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsapi32/ne-wtsapi32-wts_virtual_class
alias WTS_VIRTUAL_CLASS = int;
enum : int
{
    WTSVirtualClientData = 0x00000000,
    WTSVirtualFileHandle = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsapi32/ne-wtsapi32-wts_type_class
alias WTS_TYPE_CLASS = int;
enum : int
{
    WTSTypeProcessInfoLevel0        = 0x00000000,
    WTSTypeProcessInfoLevel1        = 0x00000001,
    WTSTypeSessionInfoLevel1        = 0x00000002,
    WTSTypeCloudAuthServerNonce     = 0x00000003,
    WTSTypeSerializedUserCredential = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tssbx/ne-tssbx-wtssbx_machine_drain
alias WTSSBX_MACHINE_DRAIN = int;
enum : int
{
    WTSSBX_MACHINE_DRAIN_UNSPEC = 0x00000000,
    WTSSBX_MACHINE_DRAIN_OFF    = 0x00000001,
    WTSSBX_MACHINE_DRAIN_ON     = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tssbx/ne-tssbx-wtssbx_machine_session_mode
alias WTSSBX_MACHINE_SESSION_MODE = int;
enum : int
{
    WTSSBX_MACHINE_SESSION_MODE_UNSPEC   = 0x00000000,
    WTSSBX_MACHINE_SESSION_MODE_SINGLE   = 0x00000001,
    WTSSBX_MACHINE_SESSION_MODE_MULTIPLE = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tssbx/ne-tssbx-wtssbx_address_family
alias WTSSBX_ADDRESS_FAMILY = int;
enum : int
{
    WTSSBX_ADDRESS_FAMILY_AF_UNSPEC  = 0x00000000,
    WTSSBX_ADDRESS_FAMILY_AF_INET    = 0x00000001,
    WTSSBX_ADDRESS_FAMILY_AF_INET6   = 0x00000002,
    WTSSBX_ADDRESS_FAMILY_AF_IPX     = 0x00000003,
    WTSSBX_ADDRESS_FAMILY_AF_NETBIOS = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tssbx/ne-tssbx-wtssbx_machine_state
alias WTSSBX_MACHINE_STATE = int;
enum : int
{
    WTSSBX_MACHINE_STATE_UNSPEC        = 0x00000000,
    WTSSBX_MACHINE_STATE_READY         = 0x00000001,
    WTSSBX_MACHINE_STATE_SYNCHRONIZING = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tssbx/ne-tssbx-wtssbx_session_state
alias WTSSBX_SESSION_STATE = int;
enum : int
{
    WTSSBX_SESSION_STATE_UNSPEC       = 0x00000000,
    WTSSBX_SESSION_STATE_ACTIVE       = 0x00000001,
    WTSSBX_SESSION_STATE_DISCONNECTED = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tssbx/ne-tssbx-wtssbx_notification_type
alias WTSSBX_NOTIFICATION_TYPE = int;
enum : int
{
    WTSSBX_NOTIFICATION_REMOVED = 0x00000001,
    WTSSBX_NOTIFICATION_CHANGED = 0x00000002,
    WTSSBX_NOTIFICATION_ADDED   = 0x00000004,
    WTSSBX_NOTIFICATION_RESYNC  = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sessdirpublictypes/ne-sessdirpublictypes-tssd_addrv46type
alias TSSD_AddrV46Type = int;
enum : int
{
    TSSD_ADDR_UNDEFINED = 0x00000000,
    TSSD_ADDR_IPv4      = 0x00000004,
    TSSD_ADDR_IPv6      = 0x00000006,
}

alias TSSB_NOTIFICATION_TYPE = int;
enum : int
{
    TSSB_NOTIFY_INVALID                   = 0x00000000,
    TSSB_NOTIFY_TARGET_CHANGE             = 0x00000001,
    TSSB_NOTIFY_SESSION_CHANGE            = 0x00000002,
    TSSB_NOTIFY_CONNECTION_REQUEST_CHANGE = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sessdirpublictypes/ne-sessdirpublictypes-target_state
alias TARGET_STATE = int;
enum : int
{
    TARGET_UNKNOWN      = 0x00000001,
    TARGET_INITIALIZING = 0x00000002,
    TARGET_RUNNING      = 0x00000003,
    TARGET_DOWN         = 0x00000004,
    TARGET_HIBERNATED   = 0x00000005,
    TARGET_CHECKED_OUT  = 0x00000006,
    TARGET_STOPPED      = 0x00000007,
    TARGET_INVALID      = 0x00000008,
    TARGET_STARTING     = 0x00000009,
    TARGET_STOPPING     = 0x0000000a,
    TARGET_MAXSTATE     = 0x0000000b,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sessdirpublictypes/ne-sessdirpublictypes-target_change_type
alias TARGET_CHANGE_TYPE = int;
enum : int
{
    TARGET_CHANGE_UNSPEC           = 0x00000001,
    TARGET_EXTERNALIP_CHANGED      = 0x00000002,
    TARGET_INTERNALIP_CHANGED      = 0x00000004,
    TARGET_JOINED                  = 0x00000008,
    TARGET_REMOVED                 = 0x00000010,
    TARGET_STATE_CHANGED           = 0x00000020,
    TARGET_IDLE                    = 0x00000040,
    TARGET_PENDING                 = 0x00000080,
    TARGET_INUSE                   = 0x00000100,
    TARGET_PATCH_STATE_CHANGED     = 0x00000200,
    TARGET_FARM_MEMBERSHIP_CHANGED = 0x00000400,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sessdirpublictypes/ne-sessdirpublictypes-target_type
alias TARGET_TYPE = int;
enum : int
{
    UNKNOWN = 0x00000000,
    FARM    = 0x00000001,
    NONFARM = 0x00000002,
}

alias TARGET_PATCH_STATE = int;
enum : int
{
    TARGET_PATCH_UNKNOWN     = 0x00000000,
    TARGET_PATCH_NOT_STARTED = 0x00000001,
    TARGET_PATCH_IN_PROGRESS = 0x00000002,
    TARGET_PATCH_COMPLETED   = 0x00000003,
    TARGET_PATCH_FAILED      = 0x00000004,
}

alias CLIENT_MESSAGE_TYPE = int;
enum : int
{
    CLIENT_MESSAGE_CONNECTION_INVALID = 0x00000000,
    CLIENT_MESSAGE_CONNECTION_STATUS  = 0x00000001,
    CLIENT_MESSAGE_CONNECTION_ERROR   = 0x00000002,
}

alias CONNECTION_CHANGE_NOTIFICATION = int;
enum : int
{
    CONNECTION_REQUEST_INVALID            = 0x00000000,
    CONNECTION_REQUEST_PENDING            = 0x00000001,
    CONNECTION_REQUEST_FAILED             = 0x00000002,
    CONNECTION_REQUEST_TIMEDOUT           = 0x00000003,
    CONNECTION_REQUEST_SUCCEEDED          = 0x00000004,
    CONNECTION_REQUEST_CANCELLED          = 0x00000005,
    CONNECTION_REQUEST_LB_COMPLETED       = 0x00000006,
    CONNECTION_REQUEST_QUERY_PL_COMPLETED = 0x00000007,
    CONNECTION_REQUEST_ORCH_COMPLETED     = 0x00000008,
}

alias RD_FARM_TYPE = int;
enum : int
{
    RD_FARM_RDSH                 = 0x00000000,
    RD_FARM_TEMP_VM              = 0x00000001,
    RD_FARM_MANUAL_PERSONAL_VM   = 0x00000002,
    RD_FARM_AUTO_PERSONAL_VM     = 0x00000003,
    RD_FARM_MANUAL_PERSONAL_RDSH = 0x00000004,
    RD_FARM_AUTO_PERSONAL_RDSH   = 0x00000005,
    RD_FARM_TYPE_UNKNOWN         = 0xffffffff,
}

alias PLUGIN_TYPE = int;
enum : int
{
    UNKNOWN_PLUGIN        = 0x00000000,
    POLICY_PLUGIN         = 0x00000001,
    RESOURCE_PLUGIN       = 0x00000002,
    LOAD_BALANCING_PLUGIN = 0x00000004,
    PLACEMENT_PLUGIN      = 0x00000008,
    ORCHESTRATION_PLUGIN  = 0x00000010,
    PROVISIONING_PLUGIN   = 0x00000020,
    TASK_PLUGIN           = 0x00000040,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sessdirpublictypes/ne-sessdirpublictypes-tssession_state
alias TSSESSION_STATE = int;
enum : int
{
    STATE_INVALID      = 0xffffffff,
    STATE_ACTIVE       = 0x00000000,
    STATE_CONNECTED    = 0x00000001,
    STATE_CONNECTQUERY = 0x00000002,
    STATE_SHADOW       = 0x00000003,
    STATE_DISCONNECTED = 0x00000004,
    STATE_IDLE         = 0x00000005,
    STATE_LISTEN       = 0x00000006,
    STATE_RESET        = 0x00000007,
    STATE_DOWN         = 0x00000008,
    STATE_INIT         = 0x00000009,
    STATE_MAX          = 0x0000000a,
}

alias TARGET_OWNER = int;
enum : int
{
    OWNER_UNKNOWN      = 0x00000000,
    OWNER_MS_TS_PLUGIN = 0x00000001,
    OWNER_MS_VM_PLUGIN = 0x00000002,
}

alias VM_NOTIFY_STATUS = int;
enum : int
{
    VM_NOTIFY_STATUS_PENDING     = 0x00000000,
    VM_NOTIFY_STATUS_IN_PROGRESS = 0x00000001,
    VM_NOTIFY_STATUS_COMPLETE    = 0x00000002,
    VM_NOTIFY_STATUS_FAILED      = 0x00000003,
    VM_NOTIFY_STATUS_CANCELED    = 0x00000004,
}

alias VM_HOST_NOTIFY_STATUS = int;
enum : int
{
    VM_HOST_STATUS_INIT_PENDING     = 0x00000000,
    VM_HOST_STATUS_INIT_IN_PROGRESS = 0x00000001,
    VM_HOST_STATUS_INIT_COMPLETE    = 0x00000002,
    VM_HOST_STATUS_INIT_FAILED      = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sessdirpublictypes/ne-sessdirpublictypes-rdv_task_status
alias RDV_TASK_STATUS = int;
enum : int
{
    RDV_TASK_STATUS_UNKNOWN     = 0x00000000,
    RDV_TASK_STATUS_SEARCHING   = 0x00000001,
    RDV_TASK_STATUS_DOWNLOADING = 0x00000002,
    RDV_TASK_STATUS_APPLYING    = 0x00000003,
    RDV_TASK_STATUS_REBOOTING   = 0x00000004,
    RDV_TASK_STATUS_REBOOTED    = 0x00000005,
    RDV_TASK_STATUS_SUCCESS     = 0x00000006,
    RDV_TASK_STATUS_FAILED      = 0x00000007,
    RDV_TASK_STATUS_TIMEOUT     = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/ne-sbtsv-ts_sb_sort_by
alias TS_SB_SORT_BY = int;
enum : int
{
    TS_SB_SORT_BY_NONE = 0x00000000,
    TS_SB_SORT_BY_NAME = 0x00000001,
    TS_SB_SORT_BY_PROP = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tspubplugin2com/ne-tspubplugin2com-tspub_plugin_pd_resolution_type
alias TSPUB_PLUGIN_PD_RESOLUTION_TYPE = int;
enum : int
{
    TSPUB_PLUGIN_PD_QUERY_OR_CREATE = 0x00000000,
    TSPUB_PLUGIN_PD_QUERY_EXISTING  = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tspubplugin2com/ne-tspubplugin2com-tspub_plugin_pd_assignment_type
alias TSPUB_PLUGIN_PD_ASSIGNMENT_TYPE = int;
enum : int
{
    TSPUB_PLUGIN_PD_ASSIGNMENT_NEW      = 0x00000000,
    TSPUB_PLUGIN_PD_ASSIGNMENT_EXISTING = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wrdsgraphicschannels/ne-wrdsgraphicschannels-wrdsgraphicschanneltype
enum WRdsGraphicsChannelType : int
{
    WRdsGraphicsChannelType_GuaranteedDelivery = 0x00000000,
    WRdsGraphicsChannelType_BestEffortDelivery = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsdefs/ne-wtsdefs-wts_rcm_service_state
alias WTS_RCM_SERVICE_STATE = int;
enum : int
{
    WTS_SERVICE_NONE  = 0x00000000,
    WTS_SERVICE_START = 0x00000001,
    WTS_SERVICE_STOP  = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsdefs/ne-wtsdefs-wts_rcm_drain_state
alias WTS_RCM_DRAIN_STATE = int;
enum : int
{
    WTS_DRAIN_STATE_NONE   = 0x00000000,
    WTS_DRAIN_IN_DRAIN     = 0x00000001,
    WTS_DRAIN_NOT_IN_DRAIN = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsdefs/ne-wtsdefs-wts_logon_error_redirector_response
alias WTS_LOGON_ERROR_REDIRECTOR_RESPONSE = int;
enum : int
{
    WTS_LOGON_ERR_INVALID                      = 0x00000000,
    WTS_LOGON_ERR_NOT_HANDLED                  = 0x00000001,
    WTS_LOGON_ERR_HANDLED_SHOW                 = 0x00000002,
    WTS_LOGON_ERR_HANDLED_DONT_SHOW            = 0x00000003,
    WTS_LOGON_ERR_HANDLED_DONT_SHOW_START_OVER = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsdefs/ne-wtsdefs-wts_cert_type
alias WTS_CERT_TYPE = int;
enum : int
{
    WTS_CERT_TYPE_INVALID     = 0x00000000,
    WTS_CERT_TYPE_PROPRIETORY = 0x00000001,
    WTS_CERT_TYPE_X509        = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsdefs/ne-wtsdefs-wrds_connection_setting_level
alias WRDS_CONNECTION_SETTING_LEVEL = int;
enum : int
{
    WRDS_CONNECTION_SETTING_LEVEL_INVALID = 0x00000000,
    WRDS_CONNECTION_SETTING_LEVEL_1       = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsdefs/ne-wtsdefs-wrds_listener_setting_level
alias WRDS_LISTENER_SETTING_LEVEL = int;
enum : int
{
    WRDS_LISTENER_SETTING_LEVEL_INVALID = 0x00000000,
    WRDS_LISTENER_SETTING_LEVEL_1       = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsdefs/ne-wtsdefs-wrds_setting_type
alias WRDS_SETTING_TYPE = int;
enum : int
{
    WRDS_SETTING_TYPE_INVALID = 0x00000000,
    WRDS_SETTING_TYPE_MACHINE = 0x00000001,
    WRDS_SETTING_TYPE_USER    = 0x00000002,
    WRDS_SETTING_TYPE_SAM     = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsdefs/ne-wtsdefs-wrds_setting_status
alias WRDS_SETTING_STATUS = int;
enum : int
{
    WRDS_SETTING_STATUS_NOTAPPLICABLE = 0xffffffff,
    WRDS_SETTING_STATUS_DISABLED      = 0x00000000,
    WRDS_SETTING_STATUS_ENABLED       = 0x00000001,
    WRDS_SETTING_STATUS_NOTCONFIGURED = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsdefs/ne-wtsdefs-wrds_setting_level
alias WRDS_SETTING_LEVEL = int;
enum : int
{
    WRDS_SETTING_LEVEL_INVALID = 0x00000000,
    WRDS_SETTING_LEVEL_1       = 0x00000001,
}

enum PasswordEncodingType : int
{
    PasswordEncodingUTF8    = 0x00000000,
    PasswordEncodingUTF16LE = 0x00000001,
    PasswordEncodingUTF16BE = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpappcontainerclient/ne-rdpappcontainerclient-remoteactiontype
enum RemoteActionType : int
{
    RemoteActionCharms      = 0x00000000,
    RemoteActionAppbar      = 0x00000001,
    RemoteActionSnap        = 0x00000002,
    RemoteActionStartScreen = 0x00000003,
    RemoteActionAppSwitch   = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpappcontainerclient/ne-rdpappcontainerclient-snapshotencodingtype
enum SnapshotEncodingType : int
{
    SnapshotEncodingDataUri = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpappcontainerclient/ne-rdpappcontainerclient-snapshotformattype
enum SnapshotFormatType : int
{
    SnapshotFormatPng  = 0x00000000,
    SnapshotFormatJpeg = 0x00000001,
    SnapshotFormatBmp  = 0x00000002,
}

enum KeyCombinationType : int
{
    KeyCombinationHome   = 0x00000000,
    KeyCombinationLeft   = 0x00000001,
    KeyCombinationUp     = 0x00000002,
    KeyCombinationRight  = 0x00000003,
    KeyCombinationDown   = 0x00000004,
    KeyCombinationScroll = 0x00000005,
}

// Constants


enum : HANDLE
{
    WTS_CURRENT_SERVER        = HANDLE(0x00000000),
    WTS_CURRENT_SERVER_HANDLE = HANDLE(0x00000000),
}

enum const(wchar)* WTS_CURRENT_SERVER_NAME = "";
enum uint WTS_DOMAIN_LENGTH = 0x000000ffU;
enum uint WTS_USERNAME_LENGTH = 0x000000ffU;
enum uint WTS_PASSWORD_LENGTH = 0x000000ffU;
enum uint WTS_DIRECTORY_LENGTH = 0x00000100U;
enum uint WTS_INITIALPROGRAM_LENGTH = 0x00000100U;
enum uint WTS_PROTOCOL_NAME_LENGTH = 0x00000008U;
enum uint WTS_DRIVER_NAME_LENGTH = 0x00000008U;
enum uint WTS_DEVICE_NAME_LENGTH = 0x00000013U;
enum uint WTS_IMEFILENAME_LENGTH = 0x00000020U;

enum : uint
{
    WTS_CLIENTNAME_LENGTH        = 0x00000014U,
    WTS_CLIENTADDRESS_LENGTH     = 0x0000001eU,
    WTS_CLIENT_PRODUCT_ID_LENGTH = 0x00000020U,
}

enum uint WTS_MAX_PROTOCOL_CACHE = 0x00000004U;
enum uint WTS_MAX_CACHE_RESERVED = 0x00000014U;

enum : uint
{
    WTS_MAX_RESERVED           = 0x00000064U,
    WTS_MAX_COUNTERS           = 0x00000064U,
    WTS_MAX_DISPLAY_IOCTL_DATA = 0x00000100U,
}

enum : uint
{
    WTS_PERF_DISABLE_NOTHING        = 0x00000000U,
    WTS_PERF_DISABLE_WALLPAPER      = 0x00000001U,
    WTS_PERF_DISABLE_FULLWINDOWDRAG = 0x00000002U,
    WTS_PERF_DISABLE_MENUANIMATIONS = 0x00000004U,
    WTS_PERF_DISABLE_THEMING        = 0x00000008U,
}

enum uint WTS_PERF_ENABLE_ENHANCED_GRAPHICS = 0x00000010U;

enum : uint
{
    WTS_PERF_DISABLE_CURSOR_SHADOW  = 0x00000020U,
    WTS_PERF_DISABLE_CURSORSETTINGS = 0x00000040U,
}

enum : uint
{
    WTS_PERF_ENABLE_FONT_SMOOTHING      = 0x00000080U,
    WTS_PERF_ENABLE_DESKTOP_COMPOSITION = 0x00000100U,
}

enum : uint
{
    WTS_VALUE_TYPE_ULONG  = 0x00000001U,
    WTS_VALUE_TYPE_STRING = 0x00000002U,
    WTS_VALUE_TYPE_BINARY = 0x00000003U,
    WTS_VALUE_TYPE_GUID   = 0x00000004U,
}

enum : uint
{
    WTS_KEY_EXCHANGE_ALG_RSA = 0x00000001U,
    WTS_KEY_EXCHANGE_ALG_DH  = 0x00000002U,
}

enum : uint
{
    WTS_LICENSE_PROTOCOL_VERSION = 0x00010000U,
    WTS_LICENSE_PREAMBLE_VERSION = 0x00000003U,
}

enum uint WRDS_DOMAIN_LENGTH = 0x000000ffU;
enum uint WRDS_USERNAME_LENGTH = 0x000000ffU;
enum uint WRDS_PASSWORD_LENGTH = 0x000000ffU;
enum uint WRDS_DIRECTORY_LENGTH = 0x00000100U;
enum uint WRDS_INITIALPROGRAM_LENGTH = 0x00000100U;
enum uint WRDS_PROTOCOL_NAME_LENGTH = 0x00000008U;
enum uint WRDS_DRIVER_NAME_LENGTH = 0x00000008U;
enum uint WRDS_DEVICE_NAME_LENGTH = 0x00000013U;
enum uint WRDS_IMEFILENAME_LENGTH = 0x00000020U;

enum : uint
{
    WRDS_CLIENTNAME_LENGTH        = 0x00000014U,
    WRDS_CLIENTADDRESS_LENGTH     = 0x0000001eU,
    WRDS_CLIENT_PRODUCT_ID_LENGTH = 0x00000020U,
}

enum uint WRDS_MAX_PROTOCOL_CACHE = 0x00000004U;
enum uint WRDS_MAX_CACHE_RESERVED = 0x00000014U;

enum : uint
{
    WRDS_MAX_RESERVED           = 0x00000064U,
    WRDS_MAX_COUNTERS           = 0x00000064U,
    WRDS_MAX_DISPLAY_IOCTL_DATA = 0x00000100U,
}

enum : uint
{
    WRDS_PERF_DISABLE_NOTHING        = 0x00000000U,
    WRDS_PERF_DISABLE_WALLPAPER      = 0x00000001U,
    WRDS_PERF_DISABLE_FULLWINDOWDRAG = 0x00000002U,
    WRDS_PERF_DISABLE_MENUANIMATIONS = 0x00000004U,
    WRDS_PERF_DISABLE_THEMING        = 0x00000008U,
}

enum uint WRDS_PERF_ENABLE_ENHANCED_GRAPHICS = 0x00000010U;

enum : uint
{
    WRDS_PERF_DISABLE_CURSOR_SHADOW  = 0x00000020U,
    WRDS_PERF_DISABLE_CURSORSETTINGS = 0x00000040U,
}

enum : uint
{
    WRDS_PERF_ENABLE_FONT_SMOOTHING      = 0x00000080U,
    WRDS_PERF_ENABLE_DESKTOP_COMPOSITION = 0x00000100U,
}

enum : uint
{
    WRDS_VALUE_TYPE_ULONG  = 0x00000001U,
    WRDS_VALUE_TYPE_STRING = 0x00000002U,
    WRDS_VALUE_TYPE_BINARY = 0x00000003U,
    WRDS_VALUE_TYPE_GUID   = 0x00000004U,
}

enum : uint
{
    WRDS_KEY_EXCHANGE_ALG_RSA = 0x00000001U,
    WRDS_KEY_EXCHANGE_ALG_DH  = 0x00000002U,
}

enum : uint
{
    WRDS_LICENSE_PROTOCOL_VERSION = 0x00010000U,
    WRDS_LICENSE_PREAMBLE_VERSION = 0x00000003U,
}

enum uint SINGLE_SESSION = 0x00000001U;

enum : uint
{
    FORCE_REJOIN                = 0x00000002U,
    FORCE_REJOIN_IN_CLUSTERMODE = 0x00000003U,
}

enum uint RESERVED_FOR_LEGACY = 0x00000004U;
enum uint KEEP_EXISTING_SESSIONS = 0x00000008U;

enum : uint
{
    CHANNEL_EVENT_INITIALIZED     = 0x00000000U,
    CHANNEL_EVENT_CONNECTED       = 0x00000001U,
    CHANNEL_EVENT_V1_CONNECTED    = 0x00000002U,
    CHANNEL_EVENT_DISCONNECTED    = 0x00000003U,
    CHANNEL_EVENT_TERMINATED      = 0x00000004U,
    CHANNEL_EVENT_DATA_RECEIVED   = 0x0000000aU,
    CHANNEL_EVENT_WRITE_COMPLETE  = 0x0000000bU,
    CHANNEL_EVENT_WRITE_CANCELLED = 0x0000000cU,
}

enum : uint
{
    CHANNEL_RC_OK                  = 0x00000000U,
    CHANNEL_RC_ALREADY_INITIALIZED = 0x00000001U,
}

enum : uint
{
    CHANNEL_RC_NOT_INITIALIZED   = 0x00000002U,
    CHANNEL_RC_ALREADY_CONNECTED = 0x00000003U,
}

enum : uint
{
    CHANNEL_RC_NOT_CONNECTED     = 0x00000004U,
    CHANNEL_RC_TOO_MANY_CHANNELS = 0x00000005U,
}

enum : uint
{
    CHANNEL_RC_BAD_CHANNEL        = 0x00000006U,
    CHANNEL_RC_BAD_CHANNEL_HANDLE = 0x00000007U,
}

enum : uint
{
    CHANNEL_RC_NO_BUFFER            = 0x00000008U,
    CHANNEL_RC_BAD_INIT_HANDLE      = 0x00000009U,
    CHANNEL_RC_NOT_OPEN             = 0x0000000aU,
    CHANNEL_RC_BAD_PROC             = 0x0000000bU,
    CHANNEL_RC_NO_MEMORY            = 0x0000000cU,
    CHANNEL_RC_UNKNOWN_CHANNEL_NAME = 0x0000000dU,
}

enum : uint
{
    CHANNEL_RC_ALREADY_OPEN               = 0x0000000eU,
    CHANNEL_RC_NOT_IN_VIRTUALCHANNELENTRY = 0x0000000fU,
}

enum : uint
{
    CHANNEL_RC_NULL_DATA           = 0x00000010U,
    CHANNEL_RC_ZERO_LENGTH         = 0x00000011U,
    CHANNEL_RC_INVALID_INSTANCE    = 0x00000012U,
    CHANNEL_RC_UNSUPPORTED_VERSION = 0x00000013U,
}

enum uint CHANNEL_RC_INITIALIZATION_ERROR = 0x00000014U;
enum uint VIRTUAL_CHANNEL_VERSION_WIN2000 = 0x00000001U;
enum uint CHANNEL_CHUNK_LENGTH = 0x00000640U;

enum : uint
{
    CHANNEL_BUFFER_SIZE                      = 0x0000ffffU,
    CHANNEL_FLAG_FIRST                       = 0x00000001U,
    CHANNEL_FLAG_LAST                        = 0x00000002U,
    CHANNEL_FLAG_MIDDLE                      = 0x00000000U,
    CHANNEL_FLAG_FAIL                        = 0x00000100U,
    CHANNEL_OPTION_INITIALIZED               = 0x80000000U,
    CHANNEL_OPTION_ENCRYPT_RDP               = 0x40000000U,
    CHANNEL_OPTION_ENCRYPT_SC                = 0x20000000U,
    CHANNEL_OPTION_ENCRYPT_CS                = 0x10000000U,
    CHANNEL_OPTION_PRI_HIGH                  = 0x08000000U,
    CHANNEL_OPTION_PRI_MED                   = 0x04000000U,
    CHANNEL_OPTION_PRI_LOW                   = 0x02000000U,
    CHANNEL_OPTION_COMPRESS_RDP              = 0x00800000U,
    CHANNEL_OPTION_COMPRESS                  = 0x00400000U,
    CHANNEL_OPTION_SHOW_PROTOCOL             = 0x00200000U,
    CHANNEL_OPTION_REMOTE_CONTROL_PERSISTENT = 0x00100000U,
}

enum : uint
{
    CHANNEL_MAX_COUNT = 0x0000001eU,
    CHANNEL_NAME_LEN  = 0x00000007U,
}

enum uint MAX_POLICY_ATTRIBUTES = 0x00000014U;
enum uint WTS_CURRENT_SESSION = 0xffffffffU;
enum uint USERNAME_LENGTH = 0x00000014U;
enum uint CLIENTNAME_LENGTH = 0x00000014U;
enum uint CLIENTADDRESS_LENGTH = 0x0000001eU;

enum : uint
{
    WTS_WSD_LOGOFF     = 0x00000001U,
    WTS_WSD_SHUTDOWN   = 0x00000002U,
    WTS_WSD_REBOOT     = 0x00000004U,
    WTS_WSD_POWEROFF   = 0x00000008U,
    WTS_WSD_FASTREBOOT = 0x00000010U,
}

enum uint MAX_ELAPSED_TIME_LENGTH = 0x0000000fU;
enum uint MAX_DATE_TIME_LENGTH = 0x00000038U;
enum uint WINSTATIONNAME_LENGTH = 0x00000020U;
enum uint DOMAIN_LENGTH = 0x00000011U;
enum uint WTS_DRIVE_LENGTH = 0x00000003U;
enum uint WTS_LISTENER_NAME_LENGTH = 0x00000020U;
enum uint WTS_COMMENT_LENGTH = 0x0000003cU;

enum : uint
{
    WTS_LISTENER_CREATE = 0x00000001U,
    WTS_LISTENER_UPDATE = 0x00000010U,
}

enum : uint
{
    WTS_PROTOCOL_TYPE_CONSOLE = 0x00000000U,
    WTS_PROTOCOL_TYPE_ICA     = 0x00000001U,
    WTS_PROTOCOL_TYPE_RDP     = 0x00000002U,
}

enum : uint
{
    WTS_SESSIONSTATE_UNKNOWN = 0xffffffffU,
    WTS_SESSIONSTATE_LOCK    = 0x00000000U,
    WTS_SESSIONSTATE_UNLOCK  = 0x00000001U,
}

enum uint PRODUCTINFO_COMPANYNAME_LENGTH = 0x00000100U;
enum uint PRODUCTINFO_PRODUCTID_LENGTH = 0x00000004U;

enum : uint
{
    VALIDATIONINFORMATION_LICENSE_LENGTH    = 0x00004000U,
    VALIDATIONINFORMATION_HARDWAREID_LENGTH = 0x00000014U,
}

enum : uint
{
    WTS_EVENT_NONE        = 0x00000000U,
    WTS_EVENT_CREATE      = 0x00000001U,
    WTS_EVENT_DELETE      = 0x00000002U,
    WTS_EVENT_RENAME      = 0x00000004U,
    WTS_EVENT_CONNECT     = 0x00000008U,
    WTS_EVENT_DISCONNECT  = 0x00000010U,
    WTS_EVENT_LOGON       = 0x00000020U,
    WTS_EVENT_LOGOFF      = 0x00000040U,
    WTS_EVENT_STATECHANGE = 0x00000080U,
    WTS_EVENT_LICENSE     = 0x00000100U,
    WTS_EVENT_ALL         = 0x7fffffffU,
    WTS_EVENT_FLUSH       = 0x80000000U,
}

enum : uint
{
    REMOTECONTROL_KBDSHIFT_HOTKEY = 0x00000001U,
    REMOTECONTROL_KBDCTRL_HOTKEY  = 0x00000002U,
    REMOTECONTROL_KBDALT_HOTKEY   = 0x00000004U,
}

enum : uint
{
    WTS_CHANNEL_OPTION_DYNAMIC             = 0x00000001U,
    WTS_CHANNEL_OPTION_DYNAMIC_PRI_LOW     = 0x00000000U,
    WTS_CHANNEL_OPTION_DYNAMIC_PRI_MED     = 0x00000002U,
    WTS_CHANNEL_OPTION_DYNAMIC_PRI_HIGH    = 0x00000004U,
    WTS_CHANNEL_OPTION_DYNAMIC_PRI_REAL    = 0x00000006U,
    WTS_CHANNEL_OPTION_DYNAMIC_NO_COMPRESS = 0x00000008U,
}

enum : uint
{
    NOTIFY_FOR_ALL_SESSIONS = 0x00000001U,
    NOTIFY_FOR_THIS_SESSION = 0x00000000U,
}

enum : uint
{
    WTS_PROCESS_INFO_LEVEL_0 = 0x00000000U,
    WTS_PROCESS_INFO_LEVEL_1 = 0x00000001U,
}

enum uint PLUGIN_CAPABILITY_EXTERNAL_REDIRECTION = 0x00000001U;
enum uint MaxFQDN_Len = 0x00000100U;
enum uint MaxNetBiosName_Len = 0x00000010U;
enum uint MaxNumOfExposed_IPs = 0x0000000cU;
enum uint MaxUserName_Len = 0x00000068U;
enum uint MaxDomainName_Len = 0x00000100U;
enum uint MaxFarm_Len = 0x00000100U;
enum uint MaxAppName_Len = 0x00000100U;
enum uint WKS_FLAG_CLEAR_CREDS_ON_LAST_RESOURCE = 0x00000001U;
enum uint WKS_FLAG_PASSWORD_ENCRYPTED = 0x00000002U;
enum uint WKS_FLAG_CREDS_AUTHENTICATED = 0x00000004U;
enum uint SB_SYNCH_CONFLICT_MAX_WRITE_ATTEMPTS = 0x00000064U;
enum uint ACQUIRE_TARGET_LOCK_TIMEOUT = 0x000493e0U;

enum : uint
{
    RENDER_HINT_CLEAR        = 0x00000000U,
    RENDER_HINT_VIDEO        = 0x00000001U,
    RENDER_HINT_MAPPEDWINDOW = 0x00000002U,
}

enum const(wchar)* WTS_PROPERTY_DEFAULT_CONFIG = "DefaultConfig";
enum uint TS_VC_LISTENER_STATIC_CHANNEL = 0x00000001U;
enum uint WRdsGraphicsChannels_LossyChannelMaxMessageSize = 0x000003dcU;
enum uint RFX_RDP_MSG_PREFIX = 0x00000000U;

enum : uint
{
    RFX_GFX_MSG_PREFIX      = 0x00000030U,
    RFX_GFX_MSG_PREFIX_MASK = 0x00000030U,
}

enum uint RFX_GFX_MAX_SUPPORTED_MONITORS = 0x00000010U;
enum uint RFX_CLIENT_ID_LENGTH = 0x00000020U;

enum : uint
{
    DISPID_METHOD_REMOTEDESKTOPCLIENT_CONNECT                        = 0x000002bdU,
    DISPID_METHOD_REMOTEDESKTOPCLIENT_DISCONNECT                     = 0x000002beU,
    DISPID_METHOD_REMOTEDESKTOPCLIENT_RECONNECT                      = 0x000002bfU,
    DISPID_METHOD_REMOTEDESKTOPCLIENT_DELETE_SAVED_CREDENTIALS       = 0x000002c0U,
    DISPID_METHOD_REMOTEDESKTOPCLIENT_UPDATE_SESSION_DISPLAYSETTINGS = 0x000002c1U,
    DISPID_METHOD_REMOTEDESKTOPCLIENT_ATTACH_EVENT                   = 0x000002c2U,
    DISPID_METHOD_REMOTEDESKTOPCLIENT_DETACH_EVENT                   = 0x000002c3U,
}

enum : uint
{
    DISPID_PROP_REMOTEDESKTOPCLIENT_SETTINGS      = 0x000002c6U,
    DISPID_PROP_REMOTEDESKTOPCLIENT_ACTIONS       = 0x000002c7U,
    DISPID_PROP_REMOTEDESKTOPCLIENT_TOUCH_POINTER = 0x000002c8U,
}

enum : uint
{
    DISPID_METHOD_REMOTEDESKTOPCLIENT_SET_RDPPROPERTY        = 0x000002d0U,
    DISPID_METHOD_REMOTEDESKTOPCLIENT_GET_RDPPROPERTY        = 0x000002d1U,
    DISPID_METHOD_REMOTEDESKTOPCLIENT_APPLY_SETTINGS         = 0x000002d2U,
    DISPID_METHOD_REMOTEDESKTOPCLIENT_RETRIEVE_SETTINGS      = 0x000002d3U,
    DISPID_METHOD_REMOTEDESKTOPCLIENT_SUSPEND_SCREEN_UPDATES = 0x000002daU,
    DISPID_METHOD_REMOTEDESKTOPCLIENT_RESUME_SCREEN_UPDATES  = 0x000002dbU,
    DISPID_METHOD_REMOTEDESKTOPCLIENT_EXECUTE_REMOTE_ACTION  = 0x000002dcU,
    DISPID_METHOD_REMOTEDESKTOPCLIENT_GET_SNAPSHOT           = 0x000002ddU,
}

enum : uint
{
    DISPID_PROP_REMOTEDESKTOPCLIENT_TOUCHPOINTER_ENABLED       = 0x000002e4U,
    DISPID_PROP_REMOTEDESKTOPCLIENT_TOUCHPOINTER_EVENTSENABLED = 0x000002e5U,
    DISPID_PROP_REMOTEDESKTOPCLIENT_TOUCHPOINTER_POINTERSPEED  = 0x000002e6U,
}

enum : uint
{
    DISPID_AX_CONNECTING       = 0x000002eeU,
    DISPID_AX_CONNECTED        = 0x000002efU,
    DISPID_AX_LOGINCOMPLETED   = 0x000002f0U,
    DISPID_AX_DISCONNECTED     = 0x000002f1U,
    DISPID_AX_STATUSCHANGED    = 0x000002f2U,
    DISPID_AX_AUTORECONNECTING = 0x000002f3U,
    DISPID_AX_AUTORECONNECTED  = 0x000002f4U,
}

enum : uint
{
    DISPID_AX_DIALOGDISPLAYING = 0x000002f5U,
    DISPID_AX_DIALOGDISMISSED  = 0x000002f6U,
}

enum uint DISPID_AX_NETWORKSTATUSCHANGED = 0x000002f7U;
enum uint DISPID_AX_ADMINMESSAGERECEIVED = 0x000002f8U;
enum uint DISPID_AX_KEYCOMBINATIONPRESSED = 0x000002f9U;
enum uint DISPID_AX_REMOTEDESKTOPSIZECHANGED = 0x000002faU;
enum uint DISPID_AX_TOUCHPOINTERCURSORMOVED = 0x00000320U;
enum GUID RDCLIENT_BITMAP_RENDER_SERVICE = GUID("e4cc08cb-942e-4b19-8504-bd5a89a747f5");
enum GUID WTS_QUERY_ALLOWED_INITIAL_APP = GUID("c77d1b30-5be1-4c6b-a0e1-bd6d2e5c9fcc");
enum GUID WTS_QUERY_LOGON_SCREEN_SIZE = GUID("8b8e0fe7-0804-4a0e-b279-8660b1df0049");

enum : GUID
{
    WTS_QUERY_AUDIOENUM_DLL     = GUID("9bf4fa97-c883-4c2a-80ab-5a39c9af00db"),
    WTS_QUERY_MF_FORMAT_SUPPORT = GUID("41869ad0-6332-4dc8-95d5-db749e2f1d94"),
}

enum GUID WRDS_SERVICE_ID_GRAPHICS_GUID = GUID("d2993f4d-02cf-4280-8c48-1624b44f8706");
enum GUID PROPERTY_DYNAMIC_TIME_ZONE_INFORMATION = GUID("0cdfd28e-d0b9-4c1f-a5eb-6d1f6c6535b9");

enum : GUID
{
    PROPERTY_TYPE_GET_FAST_RECONNECT          = GUID("6212d757-0043-4862-99c3-9f3059ac2a3b"),
    PROPERTY_TYPE_GET_FAST_RECONNECT_USER_SID = GUID("197c427a-0135-4b6d-9c5e-e6579a0ab625"),
}

enum GUID PROPERTY_TYPE_ENABLE_UNIVERSAL_APPS_FOR_CUSTOM_SHELL = GUID("ed2c3fda-338d-4d3f-81a3-e767310d908e");

enum : GUID
{
    CONNECTION_PROPERTY_IDLE_TIME_WARNING     = GUID("693f7ff5-0c4e-4d17-b8e0-1f70325e5d58"),
    CONNECTION_PROPERTY_CURSOR_BLINK_DISABLED = GUID("4b150580-fea4-4d3c-9de4-7433a66618f7"),
}

// Callbacks

alias PCHANNEL_INIT_EVENT_FN = void function(void* pInitHandle, uint event, void* pData, uint dataLength);
alias PCHANNEL_OPEN_EVENT_FN = void function(uint openHandle, uint event, void* pData, uint dataLength, 
                                             uint totalLength, uint dataFlags);
alias PVIRTUALCHANNELINIT = uint function(void** ppInitHandle, CHANNEL_DEF* pChannel, int channelCount, 
                                          uint versionRequested, PCHANNEL_INIT_EVENT_FN pChannelInitEventProc);
alias PVIRTUALCHANNELOPEN = uint function(void* pInitHandle, uint* pOpenHandle, 
                                          /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PSTR pChannelName, 
                                          PCHANNEL_OPEN_EVENT_FN pChannelOpenEventProc);
alias PVIRTUALCHANNELCLOSE = uint function(uint openHandle);
alias PVIRTUALCHANNELWRITE = uint function(uint openHandle, void* pData, uint dataLength, void* pUserData);
alias PVIRTUALCHANNELENTRY = BOOL function(CHANNEL_ENTRY_POINTS* pEntryPoints);

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/ns-audioengineendpoint-ae_current_position
struct AE_CURRENT_POSITION
{
    ulong             u64DevicePosition;
    ulong             u64StreamPosition;
    ulong             u64PaddingFrames;
    long              hnsQPCPosition;
    float             f32FramesPerSecond;
    AE_POSITION_FLAGS Flag;
}

@RAIIFree!WTSCloudAuthClose
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct WTS_CLOUD_AUTH_HANDLE
{
    void* Value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsgpolicyengine/ns-tsgpolicyengine-aaaccountingdata
struct AAAccountingData
{
    BSTR          userName;
    BSTR          clientName;
    AAAuthSchemes authType;
    BSTR          resourceName;
    int           portNumber;
    BSTR          protocolName;
    int           numberOfBytesReceived;
    int           numberOfBytesTransfered;
    BSTR          reasonForDisconnect;
    GUID          mainSessionId;
    int           subSessionId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsapi32/ns-wtsapi32-wts_server_infow
struct WTS_SERVER_INFOW
{
    PWSTR pServerName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsapi32/ns-wtsapi32-wts_server_infoa
struct WTS_SERVER_INFOA
{
    PSTR pServerName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsapi32/ns-wtsapi32-wts_session_infow
struct WTS_SESSION_INFOW
{
    uint  SessionId;
    PWSTR pWinStationName;
    WTS_CONNECTSTATE_CLASS State;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsapi32/ns-wtsapi32-wts_session_infoa
struct WTS_SESSION_INFOA
{
    uint SessionId;
    PSTR pWinStationName;
    WTS_CONNECTSTATE_CLASS State;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsapi32/ns-wtsapi32-wts_session_info_1w
struct WTS_SESSION_INFO_1W
{
    uint  ExecEnvId;
    WTS_CONNECTSTATE_CLASS State;
    uint  SessionId;
    PWSTR pSessionName;
    PWSTR pHostName;
    PWSTR pUserName;
    PWSTR pDomainName;
    PWSTR pFarmName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsapi32/ns-wtsapi32-wts_session_info_1a
struct WTS_SESSION_INFO_1A
{
    uint ExecEnvId;
    WTS_CONNECTSTATE_CLASS State;
    uint SessionId;
    PSTR pSessionName;
    PSTR pHostName;
    PSTR pUserName;
    PSTR pDomainName;
    PSTR pFarmName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsapi32/ns-wtsapi32-wts_process_infow
struct WTS_PROCESS_INFOW
{
    uint  SessionId;
    uint  ProcessId;
    PWSTR pProcessName;
    PSID  pUserSid;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsapi32/ns-wtsapi32-wts_process_infoa
struct WTS_PROCESS_INFOA
{
    uint SessionId;
    uint ProcessId;
    PSTR pProcessName;
    PSID pUserSid;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsapi32/ns-wtsapi32-wtsconfiginfow
struct WTSCONFIGINFOW
{
    uint       version_;
    uint       fConnectClientDrivesAtLogon;
    uint       fConnectPrinterAtLogon;
    uint       fDisablePrinterRedirection;
    uint       fDisableDefaultMainClientPrinter;
    uint       ShadowSettings;
    wchar[21]  LogonUserName;
    wchar[18]  LogonDomain;
    wchar[261] WorkDirectory;
    wchar[261] InitialProgram;
    wchar[261] ApplicationName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsapi32/ns-wtsapi32-wtsconfiginfoa
struct WTSCONFIGINFOA
{
    uint      version_;
    uint      fConnectClientDrivesAtLogon;
    uint      fConnectPrinterAtLogon;
    uint      fDisablePrinterRedirection;
    uint      fDisableDefaultMainClientPrinter;
    uint      ShadowSettings;
    CHAR[21]  LogonUserName;
    CHAR[18]  LogonDomain;
    CHAR[261] WorkDirectory;
    CHAR[261] InitialProgram;
    CHAR[261] ApplicationName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsapi32/ns-wtsapi32-wtsinfow
struct WTSINFOW
{
    WTS_CONNECTSTATE_CLASS State;
    uint      SessionId;
    uint      IncomingBytes;
    uint      OutgoingBytes;
    uint      IncomingFrames;
    uint      OutgoingFrames;
    uint      IncomingCompressedBytes;
    uint      OutgoingCompressedBytes;
    wchar[32] WinStationName;
    wchar[17] Domain;
    wchar[21] UserName;
    long      ConnectTime;
    long      DisconnectTime;
    long      LastInputTime;
    long      LogonTime;
    long      CurrentTime;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsapi32/ns-wtsapi32-wtsinfoa
struct WTSINFOA
{
    WTS_CONNECTSTATE_CLASS State;
    uint     SessionId;
    uint     IncomingBytes;
    uint     OutgoingBytes;
    uint     IncomingFrames;
    uint     OutgoingFrames;
    uint     IncomingCompressedBytes;
    uint     OutgoingCompressedBy;
    CHAR[32] WinStationName;
    CHAR[17] Domain;
    CHAR[21] UserName;
    long     ConnectTime;
    long     DisconnectTime;
    long     LastInputTime;
    long     LogonTime;
    long     CurrentTime;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsapi32/ns-wtsapi32-wtsinfoex_level1_w
struct WTSINFOEX_LEVEL1_W
{
    uint      SessionId;
    WTS_CONNECTSTATE_CLASS SessionState;
    int       SessionFlags;
    wchar[33] WinStationName;
    wchar[21] UserName;
    wchar[18] DomainName;
    long      LogonTime;
    long      ConnectTime;
    long      DisconnectTime;
    long      LastInputTime;
    long      CurrentTime;
    uint      IncomingBytes;
    uint      OutgoingBytes;
    uint      IncomingFrames;
    uint      OutgoingFrames;
    uint      IncomingCompressedBytes;
    uint      OutgoingCompressedBytes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsapi32/ns-wtsapi32-wtsinfoex_level1_a
struct WTSINFOEX_LEVEL1_A
{
    uint     SessionId;
    WTS_CONNECTSTATE_CLASS SessionState;
    int      SessionFlags;
    CHAR[33] WinStationName;
    CHAR[21] UserName;
    CHAR[18] DomainName;
    long     LogonTime;
    long     ConnectTime;
    long     DisconnectTime;
    long     LastInputTime;
    long     CurrentTime;
    uint     IncomingBytes;
    uint     OutgoingBytes;
    uint     IncomingFrames;
    uint     OutgoingFrames;
    uint     IncomingCompressedBytes;
    uint     OutgoingCompressedBytes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsapi32/ns-wtsapi32-wtsinfoex_level_w
union WTSINFOEX_LEVEL_W
{
    WTSINFOEX_LEVEL1_W WTSInfoExLevel1;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsapi32/ns-wtsapi32-wtsinfoex_level_a
union WTSINFOEX_LEVEL_A
{
    WTSINFOEX_LEVEL1_A WTSInfoExLevel1;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsapi32/ns-wtsapi32-wtsinfoexw
struct WTSINFOEXW
{
    uint              Level;
    WTSINFOEX_LEVEL_W Data;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsapi32/ns-wtsapi32-wtsinfoexa
struct WTSINFOEXA
{
    uint              Level;
    WTSINFOEX_LEVEL_A Data;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsapi32/ns-wtsapi32-wtsclientw
struct WTSCLIENTW
{
    wchar[21]  ClientName;
    wchar[18]  Domain;
    wchar[21]  UserName;
    wchar[261] WorkDirectory;
    wchar[261] InitialProgram;
    ubyte      EncryptionLevel;
    uint       ClientAddressFamily;
    ushort[31] ClientAddress;
    ushort     HRes;
    ushort     VRes;
    ushort     ColorDepth;
    wchar[261] ClientDirectory;
    uint       ClientBuildNumber;
    uint       ClientHardwareId;
    ushort     ClientProductId;
    ushort     OutBufCountHost;
    ushort     OutBufCountClient;
    ushort     OutBufLength;
    wchar[261] DeviceId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsapi32/ns-wtsapi32-wtsclienta
struct WTSCLIENTA
{
    CHAR[21]   ClientName;
    CHAR[18]   Domain;
    CHAR[21]   UserName;
    CHAR[261]  WorkDirectory;
    CHAR[261]  InitialProgram;
    ubyte      EncryptionLevel;
    uint       ClientAddressFamily;
    ushort[31] ClientAddress;
    ushort     HRes;
    ushort     VRes;
    ushort     ColorDepth;
    CHAR[261]  ClientDirectory;
    uint       ClientBuildNumber;
    uint       ClientHardwareId;
    ushort     ClientProductId;
    ushort     OutBufCountHost;
    ushort     OutBufCountClient;
    ushort     OutBufLength;
    CHAR[261]  DeviceId;
}

struct PRODUCT_INFOA
{
    CHAR[256] CompanyName;
    CHAR[4]   ProductID;
}

struct PRODUCT_INFOW
{
    wchar[256] CompanyName;
    wchar[4]   ProductID;
}

struct WTS_VALIDATION_INFORMATIONA
{
    PRODUCT_INFOA ProductInfo;
    ubyte[16384]  License;
    uint          LicenseLength;
    ubyte[20]     HardwareID;
    uint          HardwareIDLength;
}

struct WTS_VALIDATION_INFORMATIONW
{
    PRODUCT_INFOW ProductInfo;
    ubyte[16384]  License;
    uint          LicenseLength;
    ubyte[20]     HardwareID;
    uint          HardwareIDLength;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsapi32/ns-wtsapi32-wts_client_address
struct WTS_CLIENT_ADDRESS
{
    uint      AddressFamily;
    ubyte[20] Address;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsapi32/ns-wtsapi32-wts_client_display
struct WTS_CLIENT_DISPLAY
{
    uint HorizontalResolution;
    uint VerticalResolution;
    uint ColorDepth;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsapi32/ns-wtsapi32-wtsuserconfiga
struct WTSUSERCONFIGA
{
    uint      Source;
    uint      InheritInitialProgram;
    uint      AllowLogonTerminalServer;
    uint      TimeoutSettingsConnections;
    uint      TimeoutSettingsDisconnections;
    uint      TimeoutSettingsIdle;
    uint      DeviceClientDrives;
    uint      DeviceClientPrinters;
    uint      ClientDefaultPrinter;
    uint      BrokenTimeoutSettings;
    uint      ReconnectSettings;
    uint      ShadowingSettings;
    uint      TerminalServerRemoteHomeDir;
    CHAR[261] InitialProgram;
    CHAR[261] WorkDirectory;
    CHAR[261] TerminalServerProfilePath;
    CHAR[261] TerminalServerHomeDir;
    CHAR[4]   TerminalServerHomeDirDrive;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsapi32/ns-wtsapi32-wtsuserconfigw
struct WTSUSERCONFIGW
{
    uint       Source;
    uint       InheritInitialProgram;
    uint       AllowLogonTerminalServer;
    uint       TimeoutSettingsConnections;
    uint       TimeoutSettingsDisconnections;
    uint       TimeoutSettingsIdle;
    uint       DeviceClientDrives;
    uint       DeviceClientPrinters;
    uint       ClientDefaultPrinter;
    uint       BrokenTimeoutSettings;
    uint       ReconnectSettings;
    uint       ShadowingSettings;
    uint       TerminalServerRemoteHomeDir;
    wchar[261] InitialProgram;
    wchar[261] WorkDirectory;
    wchar[261] TerminalServerProfilePath;
    wchar[261] TerminalServerHomeDir;
    wchar[4]   TerminalServerHomeDirDrive;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsapi32/ns-wtsapi32-wts_session_address
struct WTS_SESSION_ADDRESS
{
    uint      AddressFamily;
    ubyte[20] Address;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsapi32/ns-wtsapi32-wts_process_info_exw
struct WTS_PROCESS_INFO_EXW
{
    uint  SessionId;
    uint  ProcessId;
    PWSTR pProcessName;
    PSID  pUserSid;
    uint  NumberOfThreads;
    uint  HandleCount;
    uint  PagefileUsage;
    uint  PeakPagefileUsage;
    uint  WorkingSetSize;
    uint  PeakWorkingSetSize;
    long  UserTime;
    long  KernelTime;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsapi32/ns-wtsapi32-wts_process_info_exa
struct WTS_PROCESS_INFO_EXA
{
    uint SessionId;
    uint ProcessId;
    PSTR pProcessName;
    PSID pUserSid;
    uint NumberOfThreads;
    uint HandleCount;
    uint PagefileUsage;
    uint PeakPagefileUsage;
    uint WorkingSetSize;
    uint PeakWorkingSetSize;
    long UserTime;
    long KernelTime;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsapi32/ns-wtsapi32-wtslistenerconfigw
struct WTSLISTENERCONFIGW
{
    uint       version_;
    uint       fEnableListener;
    uint       MaxConnectionCount;
    uint       fPromptForPassword;
    uint       fInheritColorDepth;
    uint       ColorDepth;
    uint       fInheritBrokenTimeoutSettings;
    uint       BrokenTimeoutSettings;
    uint       fDisablePrinterRedirection;
    uint       fDisableDriveRedirection;
    uint       fDisableComPortRedirection;
    uint       fDisableLPTPortRedirection;
    uint       fDisableClipboardRedirection;
    uint       fDisableAudioRedirection;
    uint       fDisablePNPRedirection;
    uint       fDisableDefaultMainClientPrinter;
    uint       LanAdapter;
    uint       PortNumber;
    uint       fInheritShadowSettings;
    uint       ShadowSettings;
    uint       TimeoutSettingsConnection;
    uint       TimeoutSettingsDisconnection;
    uint       TimeoutSettingsIdle;
    uint       SecurityLayer;
    uint       MinEncryptionLevel;
    uint       UserAuthentication;
    wchar[61]  Comment;
    wchar[21]  LogonUserName;
    wchar[18]  LogonDomain;
    wchar[261] WorkDirectory;
    wchar[261] InitialProgram;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsapi32/ns-wtsapi32-wtslistenerconfiga
struct WTSLISTENERCONFIGA
{
    uint      version_;
    uint      fEnableListener;
    uint      MaxConnectionCount;
    uint      fPromptForPassword;
    uint      fInheritColorDepth;
    uint      ColorDepth;
    uint      fInheritBrokenTimeoutSettings;
    uint      BrokenTimeoutSettings;
    uint      fDisablePrinterRedirection;
    uint      fDisableDriveRedirection;
    uint      fDisableComPortRedirection;
    uint      fDisableLPTPortRedirection;
    uint      fDisableClipboardRedirection;
    uint      fDisableAudioRedirection;
    uint      fDisablePNPRedirection;
    uint      fDisableDefaultMainClientPrinter;
    uint      LanAdapter;
    uint      PortNumber;
    uint      fInheritShadowSettings;
    uint      ShadowSettings;
    uint      TimeoutSettingsConnection;
    uint      TimeoutSettingsDisconnection;
    uint      TimeoutSettingsIdle;
    uint      SecurityLayer;
    uint      MinEncryptionLevel;
    uint      UserAuthentication;
    CHAR[61]  Comment;
    CHAR[21]  LogonUserName;
    CHAR[18]  LogonDomain;
    CHAR[261] WorkDirectory;
    CHAR[261] InitialProgram;
}

struct WTS_SERIALIZED_USER_CREDENTIAL
{
    uint   SerializationLength;
    ubyte* Serialization;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tssbx/ns-tssbx-wtssbx_ip_address
struct WTSSBX_IP_ADDRESS
{
    WTSSBX_ADDRESS_FAMILY AddressFamily;
    ubyte[16] Address;
    ushort    PortNumber;
    uint      dwScope;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tssbx/ns-tssbx-wtssbx_machine_connect_info
struct WTSSBX_MACHINE_CONNECT_INFO
{
    wchar[257] wczMachineFQDN;
    wchar[17]  wczMachineNetBiosName;
    uint       dwNumOfIPAddr;
    WTSSBX_IP_ADDRESS[12] IPaddr;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tssbx/ns-tssbx-wtssbx_machine_info
struct WTSSBX_MACHINE_INFO
{
    WTSSBX_MACHINE_CONNECT_INFO ClientConnectInfo;
    wchar[257]           wczFarmName;
    WTSSBX_IP_ADDRESS    InternalIPAddress;
    uint                 dwMaxSessionsLimit;
    uint                 ServerWeight;
    WTSSBX_MACHINE_SESSION_MODE SingleSessionMode;
    WTSSBX_MACHINE_DRAIN InDrain;
    WTSSBX_MACHINE_STATE MachineState;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tssbx/ns-tssbx-wtssbx_session_info
struct WTSSBX_SESSION_INFO
{
    wchar[105]           wszUserName;
    wchar[257]           wszDomainName;
    wchar[257]           ApplicationType;
    uint                 dwSessionId;
    FILETIME             CreateTime;
    FILETIME             DisconnectTime;
    WTSSBX_SESSION_STATE SessionState;
}

struct CHANNEL_DEF
{
align (1):
    CHAR[8] name;
    uint    options;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pchannel/ns-pchannel-channel_pdu_header
struct CHANNEL_PDU_HEADER
{
    uint length;
    uint flags;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cchannel/ns-cchannel-channel_entry_points
struct CHANNEL_ENTRY_POINTS
{
    uint                 cbSize;
    uint                 protocolVersion;
    PVIRTUALCHANNELINIT  pVirtualChannelInit;
    PVIRTUALCHANNELOPEN  pVirtualChannelOpen;
    PVIRTUALCHANNELCLOSE pVirtualChannelClose;
    PVIRTUALCHANNELWRITE pVirtualChannelWrite;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sessdirpublictypes/ns-sessdirpublictypes-client_display
struct CLIENT_DISPLAY
{
    uint HorizontalResolution;
    uint VerticalResolution;
    uint ColorDepth;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sessdirpublictypes/ns-sessdirpublictypes-tssd_connectionpoint
struct TSSD_ConnectionPoint
{
    ubyte[16]        ServerAddressB;
    TSSD_AddrV46Type AddressType;
    ushort           PortNumber;
    uint             AddressScope;
}

struct VM_NOTIFY_ENTRY
{
    wchar[128] VmName;
    wchar[128] VmHost;
}

struct VM_PATCH_INFO
{
    uint   dwNumEntries;
    PWSTR* pVmNames;
}

struct VM_NOTIFY_INFO
{
    uint              dwNumEntries;
    VM_NOTIFY_ENTRY** ppVmEntries;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tspubplugincom/ns-tspubplugincom-pluginresource
struct pluginResource
{
    wchar[256] alias_;
    wchar[256] name;
    PWSTR      resourceFileContents;
    wchar[256] fileExtension;
    wchar[256] resourcePluginType;
    ubyte      isDiscoverable;
    int        resourceType;
    uint       pceIconSize;
    ubyte*     iconContents;
    uint       pcePluginBlobSize;
    ubyte*     blobContents;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tspubplugin2com/ns-tspubplugin2com-pluginresource2fileassociation
struct pluginResource2FileAssociation
{
    wchar[256] extName;
    ubyte      primaryHandler;
    uint       pceIconSize;
    ubyte*     iconContents;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tspubplugin2com/ns-tspubplugin2com-pluginresource2
struct pluginResource2
{
    pluginResource resourceV1;
    uint           pceFileAssocListSize;
    pluginResource2FileAssociation* fileAssocList;
    PWSTR          securityDescriptor;
    uint           pceFolderListSize;
    ushort**       folderList;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsvirtualchannels/ns-tsvirtualchannels-bitmap_renderer_statistics
struct BITMAP_RENDERER_STATISTICS
{
    uint dwFramesDelivered;
    uint dwFramesDropped;
}

struct RFX_GFX_RECT
{
align (1):
    int left;
    int top;
    int right;
    int bottom;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct RFX_GFX_MSG_HEADER
{
align (1):
    ushort uMSGType;
    ushort cbSize;
}

struct RFX_GFX_MONITOR_INFO
{
align (1):
    int  left;
    int  top;
    int  right;
    int  bottom;
    uint physicalWidth;
    uint physicalHeight;
    uint orientation;
    BOOL primary;
}

struct RFX_GFX_MSG_CLIENT_DESKTOP_INFO_REQUEST
{
    RFX_GFX_MSG_HEADER channelHdr;
}

struct RFX_GFX_MSG_CLIENT_DESKTOP_INFO_RESPONSE
{
align (1):
    RFX_GFX_MSG_HEADER channelHdr;
    uint               reserved;
    uint               monitorCount;
    RFX_GFX_MONITOR_INFO[16] MonitorData;
    wchar[32]          clientUniqueId;
}

struct RFX_GFX_MSG_DESKTOP_CONFIG_CHANGE_NOTIFY
{
align (1):
    RFX_GFX_MSG_HEADER channelHdr;
    uint               ulWidth;
    uint               ulHeight;
    uint               ulBpp;
    uint               Reserved;
}

struct RFX_GFX_MSG_DESKTOP_CONFIG_CHANGE_CONFIRM
{
    RFX_GFX_MSG_HEADER channelHdr;
}

struct RFX_GFX_MSG_DESKTOP_INPUT_RESET
{
align (1):
    RFX_GFX_MSG_HEADER channelHdr;
    uint               ulWidth;
    uint               ulHeight;
}

struct RFX_GFX_MSG_DISCONNECT_NOTIFY
{
align (1):
    RFX_GFX_MSG_HEADER channelHdr;
    uint               DisconnectReason;
}

struct RFX_GFX_MSG_DESKTOP_RESEND_REQUEST
{
    RFX_GFX_MSG_HEADER channelHdr;
    RFX_GFX_RECT       RedrawRect;
}

struct RFX_GFX_MSG_RDP_DATA
{
    RFX_GFX_MSG_HEADER channelHdr;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] rdpData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsdefs/ns-wtsdefs-wts_sockaddr
struct WTS_SOCKADDR
{
    ushort sin_family;
    union u
    {
        struct ipv4
        {
            ushort   sin_port;
            uint     IN_ADDR;
            ubyte[8] sin_zero;
        }
        struct ipv6
        {
            ushort    sin6_port;
            uint      sin6_flowinfo;
            ushort[8] sin6_addr;
            uint      sin6_scope_id;
        }
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsdefs/ns-wtsdefs-wts_small_rect
struct WTS_SMALL_RECT
{
    short Left;
    short Top;
    short Right;
    short Bottom;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsdefs/ns-wtsdefs-wts_service_state
struct WTS_SERVICE_STATE
{
    WTS_RCM_SERVICE_STATE RcmServiceState;
    WTS_RCM_DRAIN_STATE RcmDrainState;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsdefs/ns-wtsdefs-wts_session_id
struct WTS_SESSION_ID
{
    GUID SessionUniqueGuid;
    uint SessionId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsdefs/ns-wtsdefs-wts_user_credential
struct WTS_USER_CREDENTIAL
{
    wchar[256] UserName;
    wchar[256] Password;
    wchar[256] Domain;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsdefs/ns-wtsdefs-wts_systemtime
struct WTS_SYSTEMTIME
{
    ushort wYear;
    ushort wMonth;
    ushort wDayOfWeek;
    ushort wDay;
    ushort wHour;
    ushort wMinute;
    ushort wSecond;
    ushort wMilliseconds;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsdefs/ns-wtsdefs-wts_time_zone_information
struct WTS_TIME_ZONE_INFORMATION
{
    int            Bias;
    wchar[32]      StandardName;
    WTS_SYSTEMTIME StandardDate;
    int            StandardBias;
    wchar[32]      DaylightName;
    WTS_SYSTEMTIME DaylightDate;
    int            DaylightBias;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsdefs/ns-wtsdefs-wrds_dynamic_time_zone_information
struct WRDS_DYNAMIC_TIME_ZONE_INFORMATION
{
    int            Bias;
    wchar[32]      StandardName;
    WTS_SYSTEMTIME StandardDate;
    int            StandardBias;
    wchar[32]      DaylightName;
    WTS_SYSTEMTIME DaylightDate;
    int            DaylightBias;
    wchar[128]     TimeZoneKeyName;
    ushort         DynamicDaylightTimeDisabled;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsdefs/ns-wtsdefs-wts_client_data
struct WTS_CLIENT_DATA
{
    BOOLEAN      fDisableCtrlAltDel;
    BOOLEAN      fDoubleClickDetect;
    BOOLEAN      fEnableWindowsKey;
    BOOLEAN      fHideTitleBar;
    BOOL         fInheritAutoLogon;
    BOOLEAN      fPromptForPassword;
    BOOLEAN      fUsingSavedCreds;
    wchar[256]   Domain;
    wchar[256]   UserName;
    wchar[256]   Password;
    BOOLEAN      fPasswordIsScPin;
    BOOL         fInheritInitialProgram;
    wchar[257]   WorkDirectory;
    wchar[257]   InitialProgram;
    BOOLEAN      fMaximizeShell;
    ubyte        EncryptionLevel;
    uint         PerformanceFlags;
    wchar[9]     ProtocolName;
    ushort       ProtocolType;
    BOOL         fInheritColorDepth;
    ushort       HRes;
    ushort       VRes;
    ushort       ColorDepth;
    wchar[9]     DisplayDriverName;
    wchar[20]    DisplayDeviceName;
    BOOLEAN      fMouse;
    uint         KeyboardLayout;
    uint         KeyboardType;
    uint         KeyboardSubType;
    uint         KeyboardFunctionKey;
    wchar[33]    imeFileName;
    uint         ActiveInputLocale;
    BOOLEAN      fNoAudioPlayback;
    BOOLEAN      fRemoteConsoleAudio;
    wchar[9]     AudioDriverName;
    WTS_TIME_ZONE_INFORMATION ClientTimeZone;
    wchar[21]    ClientName;
    uint         SerialNumber;
    uint         ClientAddressFamily;
    wchar[31]    ClientAddress;
    WTS_SOCKADDR ClientSockAddress;
    wchar[257]   ClientDirectory;
    uint         ClientBuildNumber;
    ushort       ClientProductId;
    ushort       OutBufCountHost;
    ushort       OutBufCountClient;
    ushort       OutBufLength;
    uint         ClientSessionId;
    wchar[33]    ClientDigProductId;
    BOOLEAN      fDisableCpm;
    BOOLEAN      fDisableCdm;
    BOOLEAN      fDisableCcm;
    BOOLEAN      fDisableLPT;
    BOOLEAN      fDisableClip;
    BOOLEAN      fDisablePNP;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsdefs/ns-wtsdefs-wts_user_data
struct WTS_USER_DATA
{
    wchar[257] WorkDirectory;
    wchar[257] InitialProgram;
    WTS_TIME_ZONE_INFORMATION UserTimeZone;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsdefs/ns-wtsdefs-wts_policy_data
struct WTS_POLICY_DATA
{
    BOOLEAN fDisableEncryption;
    BOOLEAN fDisableAutoReconnect;
    uint    ColorDepth;
    ubyte   MinEncryptionLevel;
    BOOLEAN fDisableCpm;
    BOOLEAN fDisableCdm;
    BOOLEAN fDisableCcm;
    BOOLEAN fDisableLPT;
    BOOLEAN fDisableClip;
    BOOLEAN fDisablePNPRedir;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsdefs/ns-wtsdefs-wts_protocol_cache
struct WTS_PROTOCOL_CACHE
{
    uint CacheReads;
    uint CacheHits;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsdefs/ns-wtsdefs-wts_cache_stats_un
union WTS_CACHE_STATS_UN
{
    WTS_PROTOCOL_CACHE[4] ProtocolCache;
    uint     TShareCacheStats;
    uint[20] Reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsdefs/ns-wtsdefs-wts_cache_stats
struct WTS_CACHE_STATS
{
    uint               Specific;
    WTS_CACHE_STATS_UN Data;
    ushort             ProtocolType;
    ushort             Length;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsdefs/ns-wtsdefs-wts_protocol_counters
struct WTS_PROTOCOL_COUNTERS
{
    uint      WdBytes;
    uint      WdFrames;
    uint      WaitForOutBuf;
    uint      Frames;
    uint      Bytes;
    uint      CompressedBytes;
    uint      CompressFlushes;
    uint      Errors;
    uint      Timeouts;
    uint      AsyncFramingError;
    uint      AsyncOverrunError;
    uint      AsyncOverflowError;
    uint      AsyncParityError;
    uint      TdErrors;
    ushort    ProtocolType;
    ushort    Length;
    ushort    Specific;
    uint[100] Reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsdefs/ns-wtsdefs-wts_protocol_status
struct WTS_PROTOCOL_STATUS
{
    WTS_PROTOCOL_COUNTERS Output;
    WTS_PROTOCOL_COUNTERS Input;
    WTS_CACHE_STATS Cache;
    uint            AsyncSignal;
    uint            AsyncSignalMask;
    long[100]       Counters;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsdefs/ns-wtsdefs-wts_display_ioctl
struct WTS_DISPLAY_IOCTL
{
    ubyte[256] pDisplayIOCtlData;
    uint       cbDisplayIOCtlData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsdefs/ns-wtsdefs-wts_property_value
struct WTS_PROPERTY_VALUE
{
    ushort Type;
    union u
    {
        uint ulVal;
        struct strVal
        {
            uint  size;
            PWSTR pstrVal;
        }
        struct bVal
        {
            uint size;
            PSTR pbVal;
        }
        GUID guidVal;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsdefs/ns-wtsdefs-wts_license_capabilities
struct WTS_LICENSE_CAPABILITIES
{
    uint          KeyExchangeAlg;
    uint          ProtocolVer;
    BOOL          fAuthenticateServer;
    WTS_CERT_TYPE CertType;
    uint          cbClientName;
    ubyte[42]     rgbClientName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsdefs/ns-wtsdefs-wrds_listener_settings_1
struct WRDS_LISTENER_SETTINGS_1
{
    uint   MaxProtocolListenerConnectionCount;
    uint   SecurityDescriptorSize;
    ubyte* pSecurityDescriptor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsdefs/ns-wtsdefs-wrds_listener_setting
union WRDS_LISTENER_SETTING
{
    WRDS_LISTENER_SETTINGS_1 WRdsListenerSettings1;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsdefs/ns-wtsdefs-wrds_listener_settings
struct WRDS_LISTENER_SETTINGS
{
    WRDS_LISTENER_SETTING_LEVEL WRdsListenerSettingLevel;
    WRDS_LISTENER_SETTING WRdsListenerSetting;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsdefs/ns-wtsdefs-wrds_connection_settings_1
struct WRDS_CONNECTION_SETTINGS_1
{
    BOOLEAN      fInheritInitialProgram;
    BOOLEAN      fInheritColorDepth;
    BOOLEAN      fHideTitleBar;
    BOOLEAN      fInheritAutoLogon;
    BOOLEAN      fMaximizeShell;
    BOOLEAN      fDisablePNP;
    BOOLEAN      fPasswordIsScPin;
    BOOLEAN      fPromptForPassword;
    BOOLEAN      fDisableCpm;
    BOOLEAN      fDisableCdm;
    BOOLEAN      fDisableCcm;
    BOOLEAN      fDisableLPT;
    BOOLEAN      fDisableClip;
    BOOLEAN      fResetBroken;
    BOOLEAN      fDisableEncryption;
    BOOLEAN      fDisableAutoReconnect;
    BOOLEAN      fDisableCtrlAltDel;
    BOOLEAN      fDoubleClickDetect;
    BOOLEAN      fEnableWindowsKey;
    BOOLEAN      fUsingSavedCreds;
    BOOLEAN      fMouse;
    BOOLEAN      fNoAudioPlayback;
    BOOLEAN      fRemoteConsoleAudio;
    ubyte        EncryptionLevel;
    ushort       ColorDepth;
    ushort       ProtocolType;
    ushort       HRes;
    ushort       VRes;
    ushort       ClientProductId;
    ushort       OutBufCountHost;
    ushort       OutBufCountClient;
    ushort       OutBufLength;
    uint         KeyboardLayout;
    uint         MaxConnectionTime;
    uint         MaxDisconnectionTime;
    uint         MaxIdleTime;
    uint         PerformanceFlags;
    uint         KeyboardType;
    uint         KeyboardSubType;
    uint         KeyboardFunctionKey;
    uint         ActiveInputLocale;
    uint         SerialNumber;
    uint         ClientAddressFamily;
    uint         ClientBuildNumber;
    uint         ClientSessionId;
    wchar[257]   WorkDirectory;
    wchar[257]   InitialProgram;
    wchar[256]   UserName;
    wchar[256]   Domain;
    wchar[256]   Password;
    wchar[9]     ProtocolName;
    wchar[9]     DisplayDriverName;
    wchar[20]    DisplayDeviceName;
    wchar[33]    imeFileName;
    wchar[9]     AudioDriverName;
    wchar[21]    ClientName;
    wchar[31]    ClientAddress;
    wchar[257]   ClientDirectory;
    wchar[33]    ClientDigProductId;
    WTS_SOCKADDR ClientSockAddress;
    WTS_TIME_ZONE_INFORMATION ClientTimeZone;
    WRDS_LISTENER_SETTINGS WRdsListenerSettings;
    GUID         EventLogActivityId;
    uint         ContextSize;
    ubyte*       ContextData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsdefs/ns-wtsdefs-wrds_settings_1
struct WRDS_SETTINGS_1
{
    WRDS_SETTING_STATUS WRdsDisableClipStatus;
    uint                WRdsDisableClipValue;
    WRDS_SETTING_STATUS WRdsDisableLPTStatus;
    uint                WRdsDisableLPTValue;
    WRDS_SETTING_STATUS WRdsDisableCcmStatus;
    uint                WRdsDisableCcmValue;
    WRDS_SETTING_STATUS WRdsDisableCdmStatus;
    uint                WRdsDisableCdmValue;
    WRDS_SETTING_STATUS WRdsDisableCpmStatus;
    uint                WRdsDisableCpmValue;
    WRDS_SETTING_STATUS WRdsDisablePnpStatus;
    uint                WRdsDisablePnpValue;
    WRDS_SETTING_STATUS WRdsEncryptionLevelStatus;
    uint                WRdsEncryptionValue;
    WRDS_SETTING_STATUS WRdsColorDepthStatus;
    uint                WRdsColorDepthValue;
    WRDS_SETTING_STATUS WRdsDisableAutoReconnecetStatus;
    uint                WRdsDisableAutoReconnecetValue;
    WRDS_SETTING_STATUS WRdsDisableEncryptionStatus;
    uint                WRdsDisableEncryptionValue;
    WRDS_SETTING_STATUS WRdsResetBrokenStatus;
    uint                WRdsResetBrokenValue;
    WRDS_SETTING_STATUS WRdsMaxIdleTimeStatus;
    uint                WRdsMaxIdleTimeValue;
    WRDS_SETTING_STATUS WRdsMaxDisconnectTimeStatus;
    uint                WRdsMaxDisconnectTimeValue;
    WRDS_SETTING_STATUS WRdsMaxConnectTimeStatus;
    uint                WRdsMaxConnectTimeValue;
    WRDS_SETTING_STATUS WRdsKeepAliveStatus;
    BOOLEAN             WRdsKeepAliveStartValue;
    uint                WRdsKeepAliveIntervalValue;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsdefs/ns-wtsdefs-wrds_connection_setting
union WRDS_CONNECTION_SETTING
{
    WRDS_CONNECTION_SETTINGS_1 WRdsConnectionSettings1;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsdefs/ns-wtsdefs-wrds_connection_settings
struct WRDS_CONNECTION_SETTINGS
{
    WRDS_CONNECTION_SETTING_LEVEL WRdsConnectionSettingLevel;
    WRDS_CONNECTION_SETTING WRdsConnectionSetting;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsdefs/ns-wtsdefs-wrds_setting
union WRDS_SETTING
{
    WRDS_SETTINGS_1 WRdsSettings1;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsdefs/ns-wtsdefs-wrds_settings
struct WRDS_SETTINGS
{
    WRDS_SETTING_TYPE  WRdsSettingType;
    WRDS_SETTING_LEVEL WRdsSettingLevel;
    WRDS_SETTING       WRdsSetting;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-wtssession_notification
struct WTSSESSION_NOTIFICATION
{
    uint cbSize;
    uint dwSessionId;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSStopRemoteControlSession(uint LogonId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSStartRemoteControlSessionW(PWSTR pTargetServerName, uint TargetLogonId, ubyte HotkeyVk, 
                                   ushort HotkeyModifiers);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSStartRemoteControlSessionA(PSTR pTargetServerName, uint TargetLogonId, ubyte HotkeyVk, 
                                   ushort HotkeyModifiers);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSConnectSessionA(uint LogonId, uint TargetLogonId, PSTR pPassword, BOOL bWait);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSConnectSessionW(uint LogonId, uint TargetLogonId, PWSTR pPassword, BOOL bWait);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSEnumerateServersW(PWSTR pDomainName, uint Reserved, uint Version, WTS_SERVER_INFOW** ppServerInfo, 
                          uint* pCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSEnumerateServersA(PSTR pDomainName, uint Reserved, uint Version, WTS_SERVER_INFOA** ppServerInfo, 
                          uint* pCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WTSAPI32.dll")
HANDLE WTSOpenServerW(PWSTR pServerName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WTSAPI32.dll")
HANDLE WTSOpenServerA(PSTR pServerName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("WTSAPI32.dll")
HANDLE WTSOpenServerExW(PWSTR pServerName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("WTSAPI32.dll")
HANDLE WTSOpenServerExA(PSTR pServerName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WTSAPI32.dll")
void WTSCloseServer(HANDLE hServer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSEnumerateSessionsW(HANDLE hServer, uint Reserved, uint Version, WTS_SESSION_INFOW** ppSessionInfo, 
                           uint* pCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSEnumerateSessionsA(HANDLE hServer, uint Reserved, uint Version, WTS_SESSION_INFOA** ppSessionInfo, 
                           uint* pCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSEnumerateSessionsExW(HANDLE hServer, uint* pLevel, uint Filter, WTS_SESSION_INFO_1W** ppSessionInfo, 
                             uint* pCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSEnumerateSessionsExA(HANDLE hServer, uint* pLevel, uint Filter, WTS_SESSION_INFO_1A** ppSessionInfo, 
                             uint* pCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSEnumerateProcessesW(HANDLE hServer, uint Reserved, uint Version, WTS_PROCESS_INFOW** ppProcessInfo, 
                            uint* pCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSEnumerateProcessesA(HANDLE hServer, uint Reserved, uint Version, WTS_PROCESS_INFOA** ppProcessInfo, 
                            uint* pCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSTerminateProcess(HANDLE hServer, uint ProcessId, uint ExitCode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSQuerySessionInformationW(HANDLE hServer, uint SessionId, WTS_INFO_CLASS WTSInfoClass, PWSTR* ppBuffer, 
                                 uint* pBytesReturned);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSQuerySessionInformationA(HANDLE hServer, uint SessionId, WTS_INFO_CLASS WTSInfoClass, PSTR* ppBuffer, 
                                 uint* pBytesReturned);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSQueryUserConfigW(PWSTR pServerName, PWSTR pUserName, WTS_CONFIG_CLASS WTSConfigClass, PWSTR* ppBuffer, 
                         uint* pBytesReturned);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSQueryUserConfigA(PSTR pServerName, PSTR pUserName, WTS_CONFIG_CLASS WTSConfigClass, PSTR* ppBuffer, 
                         uint* pBytesReturned);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSSetUserConfigW(PWSTR pServerName, PWSTR pUserName, WTS_CONFIG_CLASS WTSConfigClass, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/PWSTR pBuffer, 
                       uint DataLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSSetUserConfigA(PSTR pServerName, PSTR pUserName, WTS_CONFIG_CLASS WTSConfigClass, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/PSTR pBuffer, 
                       uint DataLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSSendMessageW(HANDLE hServer, uint SessionId, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/PWSTR pTitle, 
                     uint TitleLength, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/PWSTR pMessage, 
                     uint MessageLength, MESSAGEBOX_STYLE Style, uint Timeout, MESSAGEBOX_RESULT* pResponse, 
                     BOOL bWait);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSSendMessageA(HANDLE hServer, uint SessionId, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/PSTR pTitle, 
                     uint TitleLength, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/PSTR pMessage, 
                     uint MessageLength, MESSAGEBOX_STYLE Style, uint Timeout, MESSAGEBOX_RESULT* pResponse, 
                     BOOL bWait);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSDisconnectSession(HANDLE hServer, uint SessionId, BOOL bWait);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSLogoffSession(HANDLE hServer, uint SessionId, BOOL bWait);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSShutdownSystem(HANDLE hServer, uint ShutdownFlag);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSWaitSystemEvent(HANDLE hServer, uint EventMask, uint* pEventFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WTSAPI32.dll")
HANDLE WTSVirtualChannelOpen(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/HANDLE hServer, 
                             uint SessionId, PSTR pVirtualName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WTSAPI32.dll")
HANDLE WTSVirtualChannelOpenEx(uint SessionId, PSTR pVirtualName, uint flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSVirtualChannelClose(HANDLE hChannelHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSVirtualChannelRead(HANDLE hChannelHandle, uint TimeOut, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/PSTR Buffer, 
                           uint BufferSize, uint* pBytesRead);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSVirtualChannelWrite(HANDLE hChannelHandle, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/PSTR Buffer, 
                            uint Length, uint* pBytesWritten);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSVirtualChannelPurgeInput(HANDLE hChannelHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSVirtualChannelPurgeOutput(HANDLE hChannelHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSVirtualChannelQuery(HANDLE hChannelHandle, WTS_VIRTUAL_CLASS param1, void** ppBuffer, uint* pBytesReturned);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WTSAPI32.dll")
void WTSFreeMemory(void* pMemory);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSRegisterSessionNotification(HWND hWnd, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSUnRegisterSessionNotification(HWND hWnd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSRegisterSessionNotificationEx(HANDLE hServer, HWND hWnd, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSUnRegisterSessionNotificationEx(HANDLE hServer, HWND hWnd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSQueryUserToken(uint SessionId, HANDLE* phToken);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSFreeMemoryExW(WTS_TYPE_CLASS WTSTypeClass, void* pMemory, uint NumberOfEntries);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSFreeMemoryExA(WTS_TYPE_CLASS WTSTypeClass, void* pMemory, uint NumberOfEntries);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSEnumerateProcessesExW(HANDLE hServer, uint* pLevel, uint SessionId, PWSTR* ppProcessInfo, uint* pCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSEnumerateProcessesExA(HANDLE hServer, uint* pLevel, uint SessionId, PSTR* ppProcessInfo, uint* pCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSEnumerateListenersW(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/HANDLE hServer, 
                            void* pReserved, uint Reserved, ushort** pListeners, uint* pCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSEnumerateListenersA(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/HANDLE hServer, 
                            void* pReserved, uint Reserved, byte** pListeners, uint* pCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSQueryListenerConfigW(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/HANDLE hServer, 
                             void* pReserved, uint Reserved, PWSTR pListenerName, WTSLISTENERCONFIGW* pBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSQueryListenerConfigA(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/HANDLE hServer, 
                             void* pReserved, uint Reserved, PSTR pListenerName, WTSLISTENERCONFIGA* pBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSCreateListenerW(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/HANDLE hServer, 
                        void* pReserved, uint Reserved, PWSTR pListenerName, WTSLISTENERCONFIGW* pBuffer, uint flag);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSCreateListenerA(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/HANDLE hServer, 
                        void* pReserved, uint Reserved, PSTR pListenerName, WTSLISTENERCONFIGA* pBuffer, uint flag);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSSetListenerSecurityW(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/HANDLE hServer, 
                             void* pReserved, uint Reserved, PWSTR pListenerName, 
                             OBJECT_SECURITY_INFORMATION SecurityInformation, 
                             PSECURITY_DESCRIPTOR pSecurityDescriptor);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSSetListenerSecurityA(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/HANDLE hServer, 
                             void* pReserved, uint Reserved, PSTR pListenerName, 
                             OBJECT_SECURITY_INFORMATION SecurityInformation, 
                             PSECURITY_DESCRIPTOR pSecurityDescriptor);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSGetListenerSecurityW(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/HANDLE hServer, 
                             void* pReserved, uint Reserved, PWSTR pListenerName, 
                             OBJECT_SECURITY_INFORMATION SecurityInformation, 
                             PSECURITY_DESCRIPTOR pSecurityDescriptor, uint nLength, uint* lpnLengthNeeded);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSGetListenerSecurityA(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/HANDLE hServer, 
                             void* pReserved, uint Reserved, PSTR pListenerName, 
                             OBJECT_SECURITY_INFORMATION SecurityInformation, 
                             PSECURITY_DESCRIPTOR pSecurityDescriptor, uint nLength, uint* lpnLengthNeeded);

@DllImport("WTSAPI32.dll")
WTS_CLOUD_AUTH_HANDLE WTSCloudAuthOpen(const(GUID)* activityId);

@DllImport("WTSAPI32.dll")
void WTSCloudAuthClose(WTS_CLOUD_AUTH_HANDLE cloudAuthHandle);

@DllImport("WTSAPI32.dll")
BOOL WTSCloudAuthGetServerNonce(WTS_CLOUD_AUTH_HANDLE cloudAuthHandle, PWSTR* serverNonce);

@DllImport("WTSAPI32.dll")
BOOL WTSCloudAuthConvertAssertionToSerializedUserCredential(WTS_CLOUD_AUTH_HANDLE cloudAuthHandle, 
                                                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(PSTR) assertion, 
                                                            uint assertionLength, const(PWSTR) resourceId, 
                                                            WTS_SERIALIZED_USER_CREDENTIAL** userCredential);

@DllImport("WTSAPI32.dll")
BOOL WTSCloudAuthNetworkLogonWithSerializedCredential(WTS_CLOUD_AUTH_HANDLE cloudAuthHandle, 
                                                      WTS_SERIALIZED_USER_CREDENTIAL* userCredential, HANDLE* token);

@DllImport("WTSAPI32.dll")
BOOL WTSCloudAuthDuplicateSerializedUserCredential(const(WTS_SERIALIZED_USER_CREDENTIAL)* userCredential, 
                                                   WTS_SERIALIZED_USER_CREDENTIAL** duplicatedUserCredential);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSEnableChildSessions(BOOL bEnable);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSIsChildSessionsEnabled(BOOL* pbEnabled);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("WTSAPI32.dll")
BOOL WTSGetChildSessionId(uint* pSessionId);

@DllImport("WTSAPI32.dll")
BOOL WTSActiveSessionExists(BOOL* pbActiveSessionExists);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("WTSAPI32.dll")
HRESULT WTSSetRenderHint(ulong* pRenderHintID, HWND hwndOwner, uint renderHintType, uint cbHintDataLength, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* pHintData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL ProcessIdToSessionId(uint dwProcessId, uint* pSessionId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
uint WTSGetActiveConsoleSessionId();


// Interfaces

@GUID("0910dd01-df8c-11d1-ae27-00c04fa35813")
struct TSUserExInterfaces;

@GUID("e2e9cae6-1e7b-4b8e-babd-e9bf6292ac29")
struct ADsTSUserEx;

@GUID("4f1dfca6-3aad-48e1-8406-4bc21a501d7c")
struct Workspace;

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/nn-audioengineendpoint-iaudioendpoint
@GUID("30a99515-1527-4451-af9f-00c5f0234daf")
interface IAudioEndpoint : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/nf-audioengineendpoint-iaudioendpoint-getframeformat
    HRESULT GetFrameFormat(WAVEFORMATEX** ppFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/nf-audioengineendpoint-iaudioendpoint-getframesperpacket
    HRESULT GetFramesPerPacket(uint* pFramesPerPacket);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/nf-audioengineendpoint-iaudioendpoint-getlatency
    HRESULT GetLatency(long* pLatency);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/nf-audioengineendpoint-iaudioendpoint-setstreamflags
    HRESULT SetStreamFlags(uint streamFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/nf-audioengineendpoint-iaudioendpoint-seteventhandle
    HRESULT SetEventHandle(HANDLE eventHandle);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/nn-audioengineendpoint-iaudioendpointrt
@GUID("dfd2005f-a6e5-4d39-a265-939ada9fbb4d")
interface IAudioEndpointRT : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/nf-audioengineendpoint-iaudioendpointrt-getcurrentpadding
    void    GetCurrentPadding(long* pPadding, AE_CURRENT_POSITION* pAeCurrentPosition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/nf-audioengineendpoint-iaudioendpointrt-processingcomplete
    void    ProcessingComplete();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/nf-audioengineendpoint-iaudioendpointrt-setpininactive
    HRESULT SetPinInactive();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/nf-audioengineendpoint-iaudioendpointrt-setpinactive
    HRESULT SetPinActive();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/nn-audioengineendpoint-iaudioinputendpointrt
@GUID("8026ab61-92b2-43c1-a1df-5c37ebd08d82")
interface IAudioInputEndpointRT : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/nf-audioengineendpoint-iaudioinputendpointrt-getinputdatapointer
    void GetInputDataPointer(APO_CONNECTION_PROPERTY* pConnectionProperty, AE_CURRENT_POSITION* pAeTimeStamp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/nf-audioengineendpoint-iaudioinputendpointrt-releaseinputdatapointer
    void ReleaseInputDataPointer(uint u32FrameCount, size_t pDataPointer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/nf-audioengineendpoint-iaudioinputendpointrt-pulseendpoint
    void PulseEndpoint();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/nn-audioengineendpoint-iaudiooutputendpointrt
@GUID("8fa906e4-c31c-4e31-932e-19a66385e9aa")
interface IAudioOutputEndpointRT : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/nf-audioengineendpoint-iaudiooutputendpointrt-getoutputdatapointer
    size_t GetOutputDataPointer(uint u32FrameCount, AE_CURRENT_POSITION* pAeTimeStamp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/nf-audioengineendpoint-iaudiooutputendpointrt-releaseoutputdatapointer
    void   ReleaseOutputDataPointer(const(APO_CONNECTION_PROPERTY)* pConnectionProperty);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/nf-audioengineendpoint-iaudiooutputendpointrt-pulseendpoint
    void   PulseEndpoint();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/nn-audioengineendpoint-iaudiodeviceendpoint
@GUID("d4952f5a-a0b2-4cc4-8b82-9358488dd8ac")
interface IAudioDeviceEndpoint : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/nf-audioengineendpoint-iaudiodeviceendpoint-setbuffer
    HRESULT SetBuffer(long MaxPeriod, uint u32LatencyCoefficient);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/nf-audioengineendpoint-iaudiodeviceendpoint-getrtcaps
    HRESULT GetRTCaps(BOOL* pbIsRTCapable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/nf-audioengineendpoint-iaudiodeviceendpoint-geteventdrivencapable
    HRESULT GetEventDrivenCapable(BOOL* pbisEventCapable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/nf-audioengineendpoint-iaudiodeviceendpoint-writeexclusivemodeparameterstosharedmemory
    HRESULT WriteExclusiveModeParametersToSharedMemory(size_t hTargetProcess, long hnsPeriod, 
                                                       long hnsBufferDuration, uint u32LatencyCoefficient, 
                                                       uint* pu32SharedMemorySize, size_t* phSharedMemory);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/nn-audioengineendpoint-iaudioendpointcontrol
@GUID("c684b72a-6df4-4774-bdf9-76b77509b653")
interface IAudioEndpointControl : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/nf-audioengineendpoint-iaudioendpointcontrol-start
    HRESULT Start();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/nf-audioengineendpoint-iaudioendpointcontrol-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/nf-audioengineendpoint-iaudioendpointcontrol-stop
    HRESULT Stop();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsuserex/nn-tsuserex-iadstsuserex
@GUID("c4930e79-2989-4462-8a60-2fcf2f2955ef")
interface IADsTSUserEx : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsuserex/nf-tsuserex-iadstsuserex-get_terminalservicesprofilepath
    HRESULT get_TerminalServicesProfilePath(BSTR* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsuserex/nf-tsuserex-iadstsuserex-put_terminalservicesprofilepath
    HRESULT put_TerminalServicesProfilePath(BSTR pNewVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsuserex/nf-tsuserex-iadstsuserex-get_terminalserviceshomedirectory
    HRESULT get_TerminalServicesHomeDirectory(BSTR* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsuserex/nf-tsuserex-iadstsuserex-put_terminalserviceshomedirectory
    HRESULT put_TerminalServicesHomeDirectory(BSTR pNewVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsuserex/nf-tsuserex-iadstsuserex-get_terminalserviceshomedrive
    HRESULT get_TerminalServicesHomeDrive(BSTR* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsuserex/nf-tsuserex-iadstsuserex-put_terminalserviceshomedrive
    HRESULT put_TerminalServicesHomeDrive(BSTR pNewVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsuserex/nf-tsuserex-iadstsuserex-get_allowlogon
    HRESULT get_AllowLogon(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsuserex/nf-tsuserex-iadstsuserex-put_allowlogon
    HRESULT put_AllowLogon(int NewVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsuserex/nf-tsuserex-iadstsuserex-get_enableremotecontrol
    HRESULT get_EnableRemoteControl(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsuserex/nf-tsuserex-iadstsuserex-put_enableremotecontrol
    HRESULT put_EnableRemoteControl(int NewVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsuserex/nf-tsuserex-iadstsuserex-get_maxdisconnectiontime
    HRESULT get_MaxDisconnectionTime(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsuserex/nf-tsuserex-iadstsuserex-put_maxdisconnectiontime
    HRESULT put_MaxDisconnectionTime(int NewVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsuserex/nf-tsuserex-iadstsuserex-get_maxconnectiontime
    HRESULT get_MaxConnectionTime(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsuserex/nf-tsuserex-iadstsuserex-put_maxconnectiontime
    HRESULT put_MaxConnectionTime(int NewVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsuserex/nf-tsuserex-iadstsuserex-get_maxidletime
    HRESULT get_MaxIdleTime(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsuserex/nf-tsuserex-iadstsuserex-put_maxidletime
    HRESULT put_MaxIdleTime(int NewVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsuserex/nf-tsuserex-iadstsuserex-get_reconnectionaction
    HRESULT get_ReconnectionAction(int* pNewVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsuserex/nf-tsuserex-iadstsuserex-put_reconnectionaction
    HRESULT put_ReconnectionAction(int NewVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsuserex/nf-tsuserex-iadstsuserex-get_brokenconnectionaction
    HRESULT get_BrokenConnectionAction(int* pNewVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsuserex/nf-tsuserex-iadstsuserex-put_brokenconnectionaction
    HRESULT put_BrokenConnectionAction(int NewVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsuserex/nf-tsuserex-iadstsuserex-get_connectclientdrivesatlogon
    HRESULT get_ConnectClientDrivesAtLogon(int* pNewVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsuserex/nf-tsuserex-iadstsuserex-put_connectclientdrivesatlogon
    HRESULT put_ConnectClientDrivesAtLogon(int NewVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsuserex/nf-tsuserex-iadstsuserex-get_connectclientprintersatlogon
    HRESULT get_ConnectClientPrintersAtLogon(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsuserex/nf-tsuserex-iadstsuserex-put_connectclientprintersatlogon
    HRESULT put_ConnectClientPrintersAtLogon(int NewVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsuserex/nf-tsuserex-iadstsuserex-get_defaulttomainprinter
    HRESULT get_DefaultToMainPrinter(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsuserex/nf-tsuserex-iadstsuserex-put_defaulttomainprinter
    HRESULT put_DefaultToMainPrinter(int NewVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsuserex/nf-tsuserex-iadstsuserex-get_terminalservicesworkdirectory
    HRESULT get_TerminalServicesWorkDirectory(BSTR* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsuserex/nf-tsuserex-iadstsuserex-put_terminalservicesworkdirectory
    HRESULT put_TerminalServicesWorkDirectory(BSTR pNewVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsuserex/nf-tsuserex-iadstsuserex-get_terminalservicesinitialprogram
    HRESULT get_TerminalServicesInitialProgram(BSTR* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsuserex/nf-tsuserex-iadstsuserex-put_terminalservicesinitialprogram
    HRESULT put_TerminalServicesInitialProgram(BSTR pNewVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsgpolicyengine/nn-tsgpolicyengine-itsgauthorizeconnectionsink
@GUID("c27ece33-7781-4318-98ef-1cf2da7b7005")
interface ITSGAuthorizeConnectionSink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsgpolicyengine/nf-tsgpolicyengine-itsgauthorizeconnectionsink-onconnectionauthorized
    HRESULT OnConnectionAuthorized(HRESULT hrIn, GUID mainSessionId, uint cbSoHResponse, ubyte* pbSoHResponse, 
                                   uint idleTimeout, uint sessionTimeout, 
                                   SESSION_TIMEOUT_ACTION_TYPE sessionTimeoutAction, AATrustClassID trustClass, 
                                   uint* policyAttributes);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsgpolicyengine/nn-tsgpolicyengine-itsgauthorizeresourcesink
@GUID("feddfcd4-fa12-4435-ae55-7ad1a9779af7")
interface ITSGAuthorizeResourceSink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsgpolicyengine/nf-tsgpolicyengine-itsgauthorizeresourcesink-onchannelauthorized
    HRESULT OnChannelAuthorized(HRESULT hrIn, GUID mainSessionId, int subSessionId, BSTR* allowedResourceNames, 
                                uint numAllowedResourceNames, BSTR* failedResourceNames, uint numFailedResourceNames);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsgpolicyengine/nn-tsgpolicyengine-itsgpolicyengine
@GUID("8bc24f08-6223-42f4-a5b4-8e37cd135bbd")
interface ITSGPolicyEngine : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsgpolicyengine/nf-tsgpolicyengine-itsgpolicyengine-authorizeconnection
    HRESULT AuthorizeConnection(GUID mainSessionId, BSTR username, AAAuthSchemes authType, BSTR clientMachineIP, 
                                BSTR clientMachineName, ubyte* sohData, uint numSOHBytes, ubyte* cookieData, 
                                uint numCookieBytes, HANDLE_PTR userToken, ITSGAuthorizeConnectionSink pSink);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsgpolicyengine/nf-tsgpolicyengine-itsgpolicyengine-authorizeresource
    HRESULT AuthorizeResource(GUID mainSessionId, int subSessionId, BSTR username, BSTR* resourceNames, 
                              uint numResources, BSTR* alternateResourceNames, uint numAlternateResourceName, 
                              uint portNumber, BSTR operation, ubyte* cookie, uint numBytesInCookie, 
                              ITSGAuthorizeResourceSink pSink);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsgpolicyengine/nf-tsgpolicyengine-itsgpolicyengine-refresh
    HRESULT Refresh();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsgpolicyengine/nf-tsgpolicyengine-itsgpolicyengine-isquarantineenabled
    HRESULT IsQuarantineEnabled(BOOL* quarantineEnabled);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsgpolicyengine/nn-tsgpolicyengine-itsgaccountingengine
@GUID("4ce2a0c9-e874-4f1a-86f4-06bbb9115338")
interface ITSGAccountingEngine : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsgpolicyengine/nf-tsgpolicyengine-itsgaccountingengine-doaccounting
    HRESULT DoAccounting(AAAccountingDataType accountingDataType, AAAccountingData accountingData);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsgauthenticationengine/nn-tsgauthenticationengine-itsgauthenticateusersink
@GUID("2c3e2e73-a782-47f9-8dfb-77ee1ed27a03")
interface ITSGAuthenticateUserSink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsgauthenticationengine/nf-tsgauthenticationengine-itsgauthenticateusersink-onuserauthenticated
    HRESULT OnUserAuthenticated(BSTR userName, BSTR userDomain, size_t context, HANDLE_PTR userToken);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsgauthenticationengine/nf-tsgauthenticationengine-itsgauthenticateusersink-onuserauthenticationfailed
    HRESULT OnUserAuthenticationFailed(size_t context, HRESULT genericErrorCode, HRESULT specificErrorCode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsgauthenticationengine/nf-tsgauthenticationengine-itsgauthenticateusersink-reauthenticateuser
    HRESULT ReauthenticateUser(size_t context);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsgauthenticationengine/nf-tsgauthenticationengine-itsgauthenticateusersink-disconnectuser
    HRESULT DisconnectUser(size_t context);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsgauthenticationengine/nn-tsgauthenticationengine-itsgauthenticationengine
@GUID("9ee3e5bf-04ab-4691-998c-d7f622321a56")
interface ITSGAuthenticationEngine : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsgauthenticationengine/nf-tsgauthenticationengine-itsgauthenticationengine-authenticateuser
    HRESULT AuthenticateUser(GUID mainSessionId, ubyte* cookieData, uint numCookieBytes, size_t context, 
                             ITSGAuthenticateUserSink pSink);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsgauthenticationengine/nf-tsgauthenticationengine-itsgauthenticationengine-cancelauthentication
    HRESULT CancelAuthentication(GUID mainSessionId, size_t context);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tssbx/nn-tssbx-iwtssbplugin
@GUID("dc44be78-b18d-4399-b210-641bf67a002c")
interface IWTSSBPlugin : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tssbx/nf-tssbx-iwtssbplugin-initialize
    HRESULT Initialize(uint* PluginCapabilities);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tssbx/nf-tssbx-iwtssbplugin-wtssbx_machinechangenotification
    HRESULT WTSSBX_MachineChangeNotification(WTSSBX_NOTIFICATION_TYPE NotificationType, int MachineId, 
                                             WTSSBX_MACHINE_INFO* pMachineInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tssbx/nf-tssbx-iwtssbplugin-wtssbx_sessionchangenotification
    HRESULT WTSSBX_SessionChangeNotification(WTSSBX_NOTIFICATION_TYPE NotificationType, int MachineId, 
                                             uint NumOfSessions, WTSSBX_SESSION_INFO* SessionInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tssbx/nf-tssbx-iwtssbplugin-wtssbx_getmostsuitableserver
    HRESULT WTSSBX_GetMostSuitableServer(PWSTR UserName, PWSTR DomainName, PWSTR ApplicationType, PWSTR FarmName, 
                                         int* pMachineId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tssbx/nf-tssbx-iwtssbplugin-terminated
    HRESULT Terminated();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tssbx/nf-tssbx-iwtssbplugin-wtssbx_getuserexternalsession
    HRESULT WTSSBX_GetUserExternalSession(PWSTR UserName, PWSTR DomainName, PWSTR ApplicationType, 
                                          WTSSBX_IP_ADDRESS* RedirectorInternalIP, uint* pSessionId, 
                                          WTSSBX_MACHINE_CONNECT_INFO* pMachineConnectInfo);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/workspaceruntimeclientext/nn-workspaceruntimeclientext-iworkspaceclientext
@GUID("12b952f4-41ca-4f21-a829-a6d07d9a16e5")
interface IWorkspaceClientExt : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/workspaceruntimeclientext/nf-workspaceruntimeclientext-iworkspaceclientext-getresourceid
    HRESULT GetResourceId(BSTR* bstrWorkspaceId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/workspaceruntimeclientext/nf-workspaceruntimeclientext-iworkspaceclientext-getresourcedisplayname
    HRESULT GetResourceDisplayName(BSTR* bstrWorkspaceDisplayName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/workspaceruntimeclientext/nf-workspaceruntimeclientext-iworkspaceclientext-issuedisconnect
    HRESULT IssueDisconnect();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/workspaceruntime/nn-workspaceruntime-iworkspace
@GUID("b922bbb8-4c55-4fea-8496-beb0b44285e5")
interface IWorkspace : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/workspaceruntime/nf-workspaceruntime-iworkspace-getworkspacenames
    HRESULT GetWorkspaceNames(SAFEARRAY** psaWkspNames);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/workspaceruntime/nf-workspaceruntime-iworkspace-startremoteapplication
    HRESULT StartRemoteApplication(BSTR bstrWorkspaceId, SAFEARRAY* psaParams);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/workspaceruntime/nf-workspaceruntime-iworkspace-getprocessid
    HRESULT GetProcessId(uint* pulProcessId);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/workspaceruntime/nn-workspaceruntime-iworkspace2
@GUID("96d8d7cf-783e-4286-834c-ebc0e95f783c")
interface IWorkspace2 : IWorkspace
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/workspaceruntime/nf-workspaceruntime-iworkspace2-startremoteapplicationex
    HRESULT StartRemoteApplicationEx(BSTR bstrWorkspaceId, BSTR bstrRequestingAppId, 
                                     BSTR bstrRequestingAppFamilyName, VARIANT_BOOL bLaunchIntoImmersiveClient, 
                                     BSTR bstrImmersiveClientActivationContext, SAFEARRAY* psaParams);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/workspaceruntime/nn-workspaceruntime-iworkspace3
@GUID("1becbe4a-d654-423b-afeb-be8d532c13c6")
interface IWorkspace3 : IWorkspace2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/workspaceruntime/nf-workspaceruntime-iworkspace3-getclaimstoken2
    HRESULT GetClaimsToken2(BSTR bstrClaimsHint, BSTR bstrUserHint, uint claimCookie, uint hwndCredUiParent, 
                            RECT rectCredUiParent, BSTR* pbstrAccessToken);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/workspaceruntime/nf-workspaceruntime-iworkspace3-setclaimstoken
    HRESULT SetClaimsToken(BSTR bstrAccessToken, ulong ullAccessTokenExpiration, BSTR bstrRefreshToken);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/workspaceruntime/nn-workspaceruntime-iworkspaceregistration
@GUID("b922bbb8-4c55-4fea-8496-beb0b44285e6")
interface IWorkspaceRegistration : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/workspaceruntime/nf-workspaceruntime-iworkspaceregistration-addresource
    HRESULT AddResource(IWorkspaceClientExt pUnk, uint* pdwCookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/workspaceruntime/nf-workspaceruntime-iworkspaceregistration-removeresource
    HRESULT RemoveResource(uint dwCookieConnection);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/workspaceruntime/nn-workspaceruntime-iworkspaceregistration2
@GUID("cf59f654-39bb-44d8-94d0-4635728957e9")
interface IWorkspaceRegistration2 : IWorkspaceRegistration
{
    HRESULT AddResourceEx(IWorkspaceClientExt pUnk, BSTR bstrEventLogUploadAddress, uint* pdwCookie, 
                          GUID correlationId);
    HRESULT RemoveResourceEx(uint dwCookieConnection, GUID correlationId);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/workspaceruntime/nn-workspaceruntime-iworkspacescriptable
@GUID("efea49a2-dda5-429d-8f42-b23b92c4c347")
interface IWorkspaceScriptable : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/workspaceruntime/nf-workspaceruntime-iworkspacescriptable-disconnectworkspace
    HRESULT DisconnectWorkspace(BSTR bstrWorkspaceId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/workspaceruntime/nf-workspaceruntime-iworkspacescriptable-startworkspace
    HRESULT StartWorkspace(BSTR bstrWorkspaceId, BSTR bstrUserName, BSTR bstrPassword, BSTR bstrWorkspaceParams, 
                           int lTimeout, int lFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/workspaceruntime/nf-workspaceruntime-iworkspacescriptable-isworkspacecredentialspecified
    HRESULT IsWorkspaceCredentialSpecified(BSTR bstrWorkspaceId, VARIANT_BOOL bCountUnauthenticatedCredentials, 
                                           VARIANT_BOOL* pbCredExist);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/workspaceruntime/nf-workspaceruntime-iworkspacescriptable-isworkspacessoenabled
    HRESULT IsWorkspaceSSOEnabled(VARIANT_BOOL* pbSSOEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/workspaceruntime/nf-workspaceruntime-iworkspacescriptable-clearworkspacecredential
    HRESULT ClearWorkspaceCredential(BSTR bstrWorkspaceId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/workspaceruntime/nf-workspaceruntime-iworkspacescriptable-onauthenticated
    HRESULT OnAuthenticated(BSTR bstrWorkspaceId, BSTR bstrUserName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/workspaceruntime/nf-workspaceruntime-iworkspacescriptable-disconnectworkspacebyfriendlyname
    HRESULT DisconnectWorkspaceByFriendlyName(BSTR bstrWorkspaceFriendlyName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/workspaceruntime/nn-workspaceruntime-iworkspacescriptable2
@GUID("efea49a2-dda5-429d-8f42-b33ba2c4c348")
interface IWorkspaceScriptable2 : IWorkspaceScriptable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/workspaceruntime/nf-workspaceruntime-iworkspacescriptable2-startworkspaceex
    HRESULT StartWorkspaceEx(BSTR bstrWorkspaceId, BSTR bstrWorkspaceFriendlyName, BSTR bstrRedirectorName, 
                             BSTR bstrUserName, BSTR bstrPassword, BSTR bstrAppContainer, BSTR bstrWorkspaceParams, 
                             int lTimeout, int lFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/workspaceruntime/nf-workspaceruntime-iworkspacescriptable2-resourcedismissed
    HRESULT ResourceDismissed(BSTR bstrWorkspaceId, BSTR bstrWorkspaceFriendlyName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/workspaceruntime/nn-workspaceruntime-iworkspacescriptable3
@GUID("531e6512-2cbf-4bd2-80a5-d90a71636a9a")
interface IWorkspaceScriptable3 : IWorkspaceScriptable2
{
    HRESULT StartWorkspaceEx2(BSTR bstrWorkspaceId, BSTR bstrWorkspaceFriendlyName, BSTR bstrRedirectorName, 
                              BSTR bstrUserName, BSTR bstrPassword, BSTR bstrAppContainer, BSTR bstrWorkspaceParams, 
                              int lTimeout, int lFlags, BSTR bstrEventLogUploadAddress, GUID correlationId);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/workspaceruntime/nn-workspaceruntime-iworkspacereportmessage
@GUID("a7c06739-500f-4e8c-99a8-2bd6955899eb")
interface IWorkspaceReportMessage : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/workspaceruntime/nf-workspaceruntime-iworkspacereportmessage-registererrorlogmessage
    HRESULT RegisterErrorLogMessage(BSTR bstrMessage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/workspaceruntime/nf-workspaceruntime-iworkspacereportmessage-iserrormessageregistered
    HRESULT IsErrorMessageRegistered(BSTR bstrWkspId, uint dwErrorType, BSTR bstrErrorMessageType, 
                                     uint dwErrorCode, VARIANT_BOOL* pfErrorExist);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/workspaceruntime/nf-workspaceruntime-iworkspacereportmessage-registererrorevent
    HRESULT RegisterErrorEvent(BSTR bstrWkspId, uint dwErrorType, BSTR bstrErrorMessageType, uint dwErrorCode);
}

@GUID("b922bbb8-4c55-4fea-8496-beb0b44285e9")
interface _ITSWkspEvents : IDispatch
{
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nn-sbtsv-itssbplugin
@GUID("48cd7406-caab-465f-a5d6-baa863b9ea4f")
interface ITsSbPlugin : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbplugin-initialize
    HRESULT Initialize(ITsSbProvider pProvider, ITsSbPluginNotifySink pNotifySink, 
                       ITsSbPluginPropertySet pPropertySet);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbplugin-terminate
    HRESULT Terminate(HRESULT hr);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nn-sbtsv-itssbresourceplugin
@GUID("ea8db42c-98ed-4535-a88b-2a164f35490f")
interface ITsSbResourcePlugin : ITsSbPlugin
{
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nn-sbtsv-itssbservicenotification
@GUID("86cb68ae-86e0-4f57-8a64-bb7406bc5550")
interface ITsSbServiceNotification : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbservicenotification-notifyservicefailure
    HRESULT NotifyServiceFailure();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbservicenotification-notifyservicesuccess
    HRESULT NotifyServiceSuccess();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nn-sbtsv-itssbloadbalancing
@GUID("24329274-9eb7-11dc-ae98-f2b456d89593")
interface ITsSbLoadBalancing : ITsSbPlugin
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbloadbalancing-getmostsuitabletarget
    HRESULT GetMostSuitableTarget(ITsSbClientConnection pConnection, ITsSbLoadBalancingNotifySink pLBSink);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nn-sbtsv-itssbplacement
@GUID("daadee5f-6d32-480e-9e36-ddab2329f06d")
interface ITsSbPlacement : ITsSbPlugin
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbplacement-queryenvironmentfortarget
    HRESULT QueryEnvironmentForTarget(ITsSbClientConnection pConnection, ITsSbPlacementNotifySink pPlacementSink);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nn-sbtsv-itssborchestration
@GUID("64fc1172-9eb7-11dc-8b00-3aba56d89593")
interface ITsSbOrchestration : ITsSbPlugin
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssborchestration-preparetargetforconnect
    HRESULT PrepareTargetForConnect(ITsSbClientConnection pConnection, 
                                    ITsSbOrchestrationNotifySink pOrchestrationNotifySink);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nn-sbtsv-itssbenvironment
@GUID("8c87f7f7-bf51-4a5c-87bf-8e94fb6e2256")
interface ITsSbEnvironment : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbenvironment-get_name
    HRESULT get_Name(BSTR* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbenvironment-get_serverweight
    HRESULT get_ServerWeight(uint* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbenvironment-get_environmentpropertyset
    HRESULT get_EnvironmentPropertySet(ITsSbEnvironmentPropertySet* ppPropertySet);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbenvironment-put_environmentpropertyset
    HRESULT put_EnvironmentPropertySet(ITsSbEnvironmentPropertySet pVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nn-sbtsv-itssbloadbalanceresult
@GUID("24fdb7ac-fea6-11dc-9672-9a8956d89593")
interface ITsSbLoadBalanceResult : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbloadbalanceresult-get_targetname
    HRESULT get_TargetName(BSTR* pVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nn-sbtsv-itssbtarget
@GUID("16616ecc-272d-411d-b324-126893033856")
interface ITsSbTarget : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbtarget-get_targetname
    HRESULT get_TargetName(BSTR* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbtarget-put_targetname
    HRESULT put_TargetName(BSTR Val);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbtarget-get_farmname
    HRESULT get_FarmName(BSTR* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbtarget-put_farmname
    HRESULT put_FarmName(BSTR Val);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbtarget-get_targetfqdn
    HRESULT get_TargetFQDN(BSTR* TargetFqdnName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbtarget-put_targetfqdn
    HRESULT put_TargetFQDN(BSTR Val);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbtarget-get_targetnetbios
    HRESULT get_TargetNetbios(BSTR* TargetNetbiosName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbtarget-put_targetnetbios
    HRESULT put_TargetNetbios(BSTR Val);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbtarget-get_ipaddresses
    HRESULT get_IpAddresses(TSSD_ConnectionPoint* SOCKADDR, uint* numAddresses);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbtarget-put_ipaddresses
    HRESULT put_IpAddresses(TSSD_ConnectionPoint* SOCKADDR, uint numAddresses);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbtarget-get_targetstate
    HRESULT get_TargetState(TARGET_STATE* pState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbtarget-put_targetstate
    HRESULT put_TargetState(TARGET_STATE State);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbtarget-get_targetpropertyset
    HRESULT get_TargetPropertySet(ITsSbTargetPropertySet* ppPropertySet);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbtarget-put_targetpropertyset
    HRESULT put_TargetPropertySet(ITsSbTargetPropertySet pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbtarget-get_environmentname
    HRESULT get_EnvironmentName(BSTR* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbtarget-put_environmentname
    HRESULT put_EnvironmentName(BSTR Val);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbtarget-get_numsessions
    HRESULT get_NumSessions(uint* pNumSessions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbtarget-get_numpendingconnections
    HRESULT get_NumPendingConnections(uint* pNumPendingConnections);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbtarget-get_targetload
    HRESULT get_TargetLoad(uint* pTargetLoad);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nn-sbtsv-itssbsession
@GUID("d453aac7-b1d8-4c5e-ba34-9afb4c8c5510")
interface ITsSbSession : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbsession-get_sessionid
    HRESULT get_SessionId(uint* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbsession-get_targetname
    HRESULT get_TargetName(BSTR* targetName);
    HRESULT put_TargetName(BSTR targetName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbsession-get_username
    HRESULT get_Username(BSTR* userName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbsession-get_domain
    HRESULT get_Domain(BSTR* domain);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbsession-get_state
    HRESULT get_State(TSSESSION_STATE* pState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbsession-put_state
    HRESULT put_State(TSSESSION_STATE State);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbsession-get_createtime
    HRESULT get_CreateTime(FILETIME* pTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbsession-put_createtime
    HRESULT put_CreateTime(FILETIME Time);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbsession-get_disconnecttime
    HRESULT get_DisconnectTime(FILETIME* pTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbsession-put_disconnecttime
    HRESULT put_DisconnectTime(FILETIME Time);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbsession-get_initialprogram
    HRESULT get_InitialProgram(BSTR* app);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbsession-put_initialprogram
    HRESULT put_InitialProgram(BSTR Application);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbsession-get_clientdisplay
    HRESULT get_ClientDisplay(CLIENT_DISPLAY* pClientDisplay);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbsession-put_clientdisplay
    HRESULT put_ClientDisplay(CLIENT_DISPLAY pClientDisplay);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbsession-get_protocoltype
    HRESULT get_ProtocolType(uint* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbsession-put_protocoltype
    HRESULT put_ProtocolType(uint Val);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nn-sbtsv-itssbresourcenotification
@GUID("65d3e85a-c39b-11dc-b92d-3cd255d89593")
interface ITsSbResourceNotification : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbresourcenotification-notifysessionchange
    HRESULT NotifySessionChange(TSSESSION_STATE changeType, ITsSbSession pSession);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbresourcenotification-notifytargetchange
    HRESULT NotifyTargetChange(uint TargetChangeType, ITsSbTarget pTarget);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbresourcenotification-notifyclientconnectionstatechange
    HRESULT NotifyClientConnectionStateChange(CONNECTION_CHANGE_NOTIFICATION ChangeType, 
                                              ITsSbClientConnection pConnection);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nn-sbtsv-itssbresourcenotificationex
@GUID("a8a47fde-ca91-44d2-b897-3aa28a43b2b7")
interface ITsSbResourceNotificationEx : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbresourcenotificationex-notifysessionchangeex
    HRESULT NotifySessionChangeEx(BSTR targetName, BSTR userName, BSTR domain, uint sessionId, 
                                  TSSESSION_STATE sessionState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbresourcenotificationex-notifytargetchangeex
    HRESULT NotifyTargetChangeEx(BSTR targetName, uint targetChangeType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbresourcenotificationex-notifyclientconnectionstatechangeex
    HRESULT NotifyClientConnectionStateChangeEx(BSTR userName, BSTR domain, BSTR initialProgram, BSTR poolName, 
                                                BSTR targetName, CONNECTION_CHANGE_NOTIFICATION connectionChangeType);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nn-sbtsv-itssbtaskinfo
@GUID("523d1083-89be-48dd-99ea-04e82ffa7265")
interface ITsSbTaskInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbtaskinfo-get_targetid
    HRESULT get_TargetId(BSTR* pName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbtaskinfo-get_starttime
    HRESULT get_StartTime(FILETIME* pStartTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbtaskinfo-get_endtime
    HRESULT get_EndTime(FILETIME* pEndTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbtaskinfo-get_deadline
    HRESULT get_Deadline(FILETIME* pDeadline);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbtaskinfo-get_identifier
    HRESULT get_Identifier(BSTR* pIdentifier);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbtaskinfo-get_label
    HRESULT get_Label(BSTR* pLabel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbtaskinfo-get_context
    HRESULT get_Context(SAFEARRAY** pContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbtaskinfo-get_plugin
    HRESULT get_Plugin(BSTR* pPlugin);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbtaskinfo-get_status
    HRESULT get_Status(RDV_TASK_STATUS* pStatus);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nn-sbtsv-itssbtaskplugin
@GUID("fa22ef0f-8705-41be-93bc-44bdbcf1c9c4")
interface ITsSbTaskPlugin : ITsSbPlugin
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbtaskplugin-initializetaskplugin
    HRESULT InitializeTaskPlugin(ITsSbTaskPluginNotifySink pITsSbTaskPluginNotifySink);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbtaskplugin-settaskqueue
    HRESULT SetTaskQueue(BSTR pszHostName, uint SbTaskInfoSize, ITsSbTaskInfo* pITsSbTaskInfo);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nn-sbtsv-itssbpropertyset
@GUID("5c025171-bb1e-4baf-a212-6d5e9774b33b")
interface ITsSbPropertySet : IPropertyBag
{
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nn-sbtsv-itssbpluginpropertyset
@GUID("95006e34-7eff-4b6c-bb40-49a4fda7cea6")
interface ITsSbPluginPropertySet : ITsSbPropertySet
{
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nn-sbtsv-itssbclientconnectionpropertyset
@GUID("e51995b0-46d6-11dd-aa21-cedc55d89593")
interface ITsSbClientConnectionPropertySet : ITsSbPropertySet
{
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nn-sbtsv-itssbtargetpropertyset
@GUID("f7bda5d6-994c-4e11-a079-2763b61830ac")
interface ITsSbTargetPropertySet : ITsSbPropertySet
{
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nn-sbtsv-itssbenvironmentpropertyset
@GUID("d0d1bf7e-7acf-11dd-a243-e51156d89593")
interface ITsSbEnvironmentPropertySet : ITsSbPropertySet
{
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nn-sbtsv-itssbbasenotifysink
@GUID("808a6537-1282-4989-9e09-f43938b71722")
interface ITsSbBaseNotifySink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbbasenotifysink-onerror
    HRESULT OnError(HRESULT hrError);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbbasenotifysink-onreportstatus
    HRESULT OnReportStatus(CLIENT_MESSAGE_TYPE messageType, uint messageID);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nn-sbtsv-itssbpluginnotifysink
@GUID("44dfe30b-c3be-40f5-bf82-7a95bb795adf")
interface ITsSbPluginNotifySink : ITsSbBaseNotifySink
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbpluginnotifysink-oninitialized
    HRESULT OnInitialized(HRESULT hr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbpluginnotifysink-onterminated
    HRESULT OnTerminated();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nn-sbtsv-itssbloadbalancingnotifysink
@GUID("5f8a8297-3244-4e6a-958a-27c822c1e141")
interface ITsSbLoadBalancingNotifySink : ITsSbBaseNotifySink
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbloadbalancingnotifysink-ongetmostsuitabletarget
    HRESULT OnGetMostSuitableTarget(ITsSbLoadBalanceResult pLBResult, BOOL fIsNewConnection);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nn-sbtsv-itssbplacementnotifysink
@GUID("68a0c487-2b4f-46c2-94a1-6ce685183634")
interface ITsSbPlacementNotifySink : ITsSbBaseNotifySink
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbplacementnotifysink-onqueryenvironmentcompleted
    HRESULT OnQueryEnvironmentCompleted(ITsSbEnvironment pEnvironment);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nn-sbtsv-itssborchestrationnotifysink
@GUID("36c37d61-926b-442f-bca5-118c6d50dcf2")
interface ITsSbOrchestrationNotifySink : ITsSbBaseNotifySink
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssborchestrationnotifysink-onreadytoconnect
    HRESULT OnReadyToConnect(ITsSbTarget pTarget);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nn-sbtsv-itssbtaskpluginnotifysink
@GUID("6aaf899e-c2ec-45ee-aa37-45e60895261a")
interface ITsSbTaskPluginNotifySink : ITsSbBaseNotifySink
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbtaskpluginnotifysink-onsettasktime
    HRESULT OnSetTaskTime(BSTR szTargetName, FILETIME TaskStartTime, FILETIME TaskEndTime, FILETIME TaskDeadline, 
                          BSTR szTaskLabel, BSTR szTaskIdentifier, BSTR szTaskPlugin, uint dwTaskStatus, 
                          SAFEARRAY* saContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbtaskpluginnotifysink-ondeletetasktime
    HRESULT OnDeleteTaskTime(BSTR szTargetName, BSTR szTaskIdentifier);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbtaskpluginnotifysink-onupdatetaskstatus
    HRESULT OnUpdateTaskStatus(BSTR szTargetName, BSTR TaskIdentifier, RDV_TASK_STATUS TaskStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbtaskpluginnotifysink-onreporttasks
    HRESULT OnReportTasks(BSTR szHostName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nn-sbtsv-itssbclientconnection
@GUID("18857499-ad61-4b1b-b7df-cbcd41fb8338")
interface ITsSbClientConnection : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbclientconnection-get_username
    HRESULT get_UserName(BSTR* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbclientconnection-get_domain
    HRESULT get_Domain(BSTR* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbclientconnection-get_initialprogram
    HRESULT get_InitialProgram(BSTR* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbclientconnection-get_loadbalanceresult
    HRESULT get_LoadBalanceResult(ITsSbLoadBalanceResult* ppVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbclientconnection-get_farmname
    HRESULT get_FarmName(BSTR* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbclientconnection-putcontext
    HRESULT PutContext(BSTR contextId, VARIANT context, VARIANT* existingContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbclientconnection-getcontext
    HRESULT GetContext(BSTR contextId, VARIANT* context);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbclientconnection-get_environment
    HRESULT get_Environment(ITsSbEnvironment* ppEnvironment);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbclientconnection-get_connectionerror
    HRESULT get_ConnectionError();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbclientconnection-get_samuseraccount
    HRESULT get_SamUserAccount(BSTR* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbclientconnection-get_clientconnectionpropertyset
    HRESULT get_ClientConnectionPropertySet(ITsSbClientConnectionPropertySet* ppPropertySet);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbclientconnection-get_isfirstassignment
    HRESULT get_IsFirstAssignment(BOOL* ppVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbclientconnection-get_rdfarmtype
    HRESULT get_RdFarmType(RD_FARM_TYPE* pRdFarmType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbclientconnection-get_usersidstring
    HRESULT get_UserSidString(byte** pszUserSidString);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbclientconnection-getdisconnectedsession
    HRESULT GetDisconnectedSession(ITsSbSession* ppSession);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nn-sbtsv-itssbprovider
@GUID("87a4098f-6d7b-44dd-bc17-8ce44e370d52")
interface ITsSbProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbprovider-createtargetobject
    HRESULT CreateTargetObject(BSTR TargetName, BSTR EnvironmentName, ITsSbTarget* ppTarget);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbprovider-createloadbalanceresultobject
    HRESULT CreateLoadBalanceResultObject(BSTR TargetName, ITsSbLoadBalanceResult* ppLBResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbprovider-createsessionobject
    HRESULT CreateSessionObject(BSTR TargetName, BSTR UserName, BSTR Domain, uint SessionId, 
                                ITsSbSession* ppSession);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbprovider-createpluginpropertyset
    HRESULT CreatePluginPropertySet(ITsSbPluginPropertySet* ppPropertySet);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbprovider-createtargetpropertysetobject
    HRESULT CreateTargetPropertySetObject(ITsSbTargetPropertySet* ppPropertySet);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbprovider-createenvironmentobject
    HRESULT CreateEnvironmentObject(BSTR Name, uint ServerWeight, ITsSbEnvironment* ppEnvironment);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbprovider-getresourcepluginstore
    HRESULT GetResourcePluginStore(ITsSbResourcePluginStore* ppStore);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbprovider-getfilterpluginstore
    HRESULT GetFilterPluginStore(ITsSbFilterPluginStore* ppStore);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbprovider-registerfornotification
    HRESULT RegisterForNotification(uint notificationType, BSTR ResourceToMonitor, 
                                    ITsSbResourceNotification pPluginNotification);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbprovider-unregisterfornotification
    HRESULT UnRegisterForNotification(uint notificationType, BSTR ResourceToMonitor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbprovider-getinstanceofglobalstore
    HRESULT GetInstanceOfGlobalStore(ITsSbGlobalStore* ppGlobalStore);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbprovider-createenvironmentpropertysetobject
    HRESULT CreateEnvironmentPropertySetObject(ITsSbEnvironmentPropertySet* ppPropertySet);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nn-sbtsv-itssbresourcepluginstore
@GUID("5c38f65f-bcf1-4036-a6bf-9e3cccae0b63")
interface ITsSbResourcePluginStore : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbresourcepluginstore-querytarget
    HRESULT QueryTarget(BSTR TargetName, BSTR FarmName, ITsSbTarget* ppTarget);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbresourcepluginstore-querysessionbysessionid
    HRESULT QuerySessionBySessionId(uint dwSessionId, BSTR TargetName, ITsSbSession* ppSession);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbresourcepluginstore-addtargettostore
    HRESULT AddTargetToStore(ITsSbTarget pTarget);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbresourcepluginstore-addsessiontostore
    HRESULT AddSessionToStore(ITsSbSession pSession);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbresourcepluginstore-addenvironmenttostore
    HRESULT AddEnvironmentToStore(ITsSbEnvironment pEnvironment);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbresourcepluginstore-removeenvironmentfromstore
    HRESULT RemoveEnvironmentFromStore(BSTR EnvironmentName, BOOL bIgnoreOwner);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbresourcepluginstore-enumeratefarms
    HRESULT EnumerateFarms(uint* pdwCount, SAFEARRAY** pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbresourcepluginstore-queryenvironment
    HRESULT QueryEnvironment(BSTR EnvironmentName, ITsSbEnvironment* ppEnvironment);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbresourcepluginstore-enumerateenvironments
    HRESULT EnumerateEnvironments(uint* pdwCount, ITsSbEnvironment** pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbresourcepluginstore-savetarget
    HRESULT SaveTarget(ITsSbTarget pTarget, BOOL bForceWrite);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbresourcepluginstore-saveenvironment
    HRESULT SaveEnvironment(ITsSbEnvironment pEnvironment, BOOL bForceWrite);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbresourcepluginstore-savesession
    HRESULT SaveSession(ITsSbSession pSession);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbresourcepluginstore-settargetproperty
    HRESULT SetTargetProperty(BSTR TargetName, BSTR PropertyName, VARIANT* pProperty);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbresourcepluginstore-setenvironmentproperty
    HRESULT SetEnvironmentProperty(BSTR EnvironmentName, BSTR PropertyName, VARIANT* pProperty);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbresourcepluginstore-settargetstate
    HRESULT SetTargetState(BSTR targetName, TARGET_STATE newState, TARGET_STATE* pOldState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbresourcepluginstore-setsessionstate
    HRESULT SetSessionState(ITsSbSession sbSession);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbresourcepluginstore-enumeratetargets
    HRESULT EnumerateTargets(BSTR FarmName, BSTR EnvName, TS_SB_SORT_BY sortByFieldId, BSTR sortyByPropName, 
                             uint* pdwCount, ITsSbTarget** pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbresourcepluginstore-enumeratesessions
    HRESULT EnumerateSessions(BSTR targetName, BSTR userName, BSTR userDomain, BSTR poolName, BSTR initialProgram, 
                              TSSESSION_STATE* pSessionState, uint* pdwCount, ITsSbSession** ppVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbresourcepluginstore-getfarmproperty
    HRESULT GetFarmProperty(BSTR farmName, BSTR propertyName, VARIANT* pVarValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbresourcepluginstore-deletetarget
    HRESULT DeleteTarget(BSTR targetName, BSTR hostName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbresourcepluginstore-settargetpropertywithversioncheck
    HRESULT SetTargetPropertyWithVersionCheck(ITsSbTarget pTarget, BSTR PropertyName, VARIANT* pProperty);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbresourcepluginstore-setenvironmentpropertywithversioncheck
    HRESULT SetEnvironmentPropertyWithVersionCheck(ITsSbEnvironment pEnvironment, BSTR PropertyName, 
                                                   VARIANT* pProperty);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbresourcepluginstore-acquiretargetlock
    HRESULT AcquireTargetLock(BSTR targetName, uint dwTimeout, IUnknown* ppContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbresourcepluginstore-releasetargetlock
    HRESULT ReleaseTargetLock(IUnknown pContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbresourcepluginstore-testandsetserverstate
    HRESULT TestAndSetServerState(BSTR PoolName, BSTR ServerFQDN, TARGET_STATE NewState, TARGET_STATE TestState, 
                                  TARGET_STATE* pInitState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbresourcepluginstore-setserverwaitingtostart
    HRESULT SetServerWaitingToStart(BSTR PoolName, BSTR serverName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbresourcepluginstore-getserverstate
    HRESULT GetServerState(BSTR PoolName, BSTR ServerFQDN, TARGET_STATE* pState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbresourcepluginstore-setserverdrainmode
    HRESULT SetServerDrainMode(BSTR ServerFQDN, uint DrainMode);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nn-sbtsv-itssbfilterpluginstore
@GUID("85b44b0f-ed78-413f-9702-fa6d3b5ee755")
interface ITsSbFilterPluginStore : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbfilterpluginstore-saveproperties
    HRESULT SaveProperties(ITsSbPropertySet pPropertySet);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbfilterpluginstore-enumerateproperties
    HRESULT EnumerateProperties(ITsSbPropertySet* ppPropertySet);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbfilterpluginstore-deleteproperties
    HRESULT DeleteProperties(BSTR propertyName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nn-sbtsv-itssbglobalstore
@GUID("9ab60f7b-bd72-4d9f-8a3a-a0ea5574e635")
interface ITsSbGlobalStore : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbglobalstore-querytarget
    HRESULT QueryTarget(BSTR ProviderName, BSTR TargetName, BSTR FarmName, ITsSbTarget* ppTarget);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbglobalstore-querysessionbysessionid
    HRESULT QuerySessionBySessionId(BSTR ProviderName, uint dwSessionId, BSTR TargetName, ITsSbSession* ppSession);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbglobalstore-enumeratefarms
    HRESULT EnumerateFarms(BSTR ProviderName, uint* pdwCount, SAFEARRAY** pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbglobalstore-enumeratetargets
    HRESULT EnumerateTargets(BSTR ProviderName, BSTR FarmName, BSTR EnvName, uint* pdwCount, ITsSbTarget** pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbglobalstore-enumerateenvironmentsbyprovider
    HRESULT EnumerateEnvironmentsByProvider(BSTR ProviderName, uint* pdwCount, ITsSbEnvironment** ppVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbglobalstore-enumeratesessions
    HRESULT EnumerateSessions(BSTR ProviderName, BSTR targetName, BSTR userName, BSTR userDomain, BSTR poolName, 
                              BSTR initialProgram, TSSESSION_STATE* pSessionState, uint* pdwCount, 
                              ITsSbSession** ppVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbglobalstore-getfarmproperty
    HRESULT GetFarmProperty(BSTR farmName, BSTR propertyName, VARIANT* pVarValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nn-sbtsv-itssbprovisioningpluginnotifysink
@GUID("aca87a8e-818b-4581-a032-49c3dfb9c701")
interface ITsSbProvisioningPluginNotifySink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbprovisioningpluginnotifysink-onjobcreated
    HRESULT OnJobCreated(VM_NOTIFY_INFO* pVmNotifyInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbprovisioningpluginnotifysink-onvirtualmachinestatuschanged
    HRESULT OnVirtualMachineStatusChanged(VM_NOTIFY_ENTRY* pVmNotifyEntry, VM_NOTIFY_STATUS VmNotifyStatus, 
                                          HRESULT ErrorCode, BSTR ErrorDescr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbprovisioningpluginnotifysink-onjobcompleted
    HRESULT OnJobCompleted(HRESULT ResultCode, BSTR ResultDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbprovisioningpluginnotifysink-onjobcancelled
    HRESULT OnJobCancelled();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbprovisioningpluginnotifysink-lockvirtualmachine
    HRESULT LockVirtualMachine(VM_NOTIFY_ENTRY* pVmNotifyEntry);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbprovisioningpluginnotifysink-onvirtualmachinehoststatuschanged
    HRESULT OnVirtualMachineHostStatusChanged(BSTR VmHost, VM_HOST_NOTIFY_STATUS VmHostNotifyStatus, 
                                              HRESULT ErrorCode, BSTR ErrorDescr);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nn-sbtsv-itssbprovisioning
@GUID("2f6f0dbb-9e4f-462b-9c3f-fccc3dcb6232")
interface ITsSbProvisioning : ITsSbPlugin
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbprovisioning-createvirtualmachines
    HRESULT CreateVirtualMachines(BSTR JobXmlString, BSTR JobGuid, ITsSbProvisioningPluginNotifySink pSink);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbprovisioning-patchvirtualmachines
    HRESULT PatchVirtualMachines(BSTR JobXmlString, BSTR JobGuid, ITsSbProvisioningPluginNotifySink pSink, 
                                 VM_PATCH_INFO* pVMPatchInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbprovisioning-deletevirtualmachines
    HRESULT DeleteVirtualMachines(BSTR JobXmlString, BSTR JobGuid, ITsSbProvisioningPluginNotifySink pSink);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbprovisioning-canceljob
    HRESULT CancelJob(BSTR JobGuid);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2016))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nn-sbtsv-itssbgenericnotifysink
@GUID("4c4c8c4f-300b-46ad-9164-8468a7e7568c")
interface ITsSbGenericNotifySink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbgenericnotifysink-oncompleted
    HRESULT OnCompleted(HRESULT Status);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbtsv/nf-sbtsv-itssbgenericnotifysink-getwaittimeout
    HRESULT GetWaitTimeout(FILETIME* pftTimeout);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tspubplugincom/nn-tspubplugincom-itspubplugin
@GUID("70c04b05-f347-412b-822f-36c99c54ca45")
interface ItsPubPlugin : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tspubplugincom/nf-tspubplugincom-itspubplugin-getresourcelist
    HRESULT GetResourceList(const(PWSTR) userID, int* pceAppListSize, pluginResource** resourceList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tspubplugincom/nf-tspubplugincom-itspubplugin-getresource
    HRESULT GetResource(const(PWSTR) alias_, int flags, pluginResource* resource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tspubplugincom/nf-tspubplugincom-itspubplugin-getcachelastupdatetime
    HRESULT GetCacheLastUpdateTime(ulong* lastUpdateTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tspubplugincom/nf-tspubplugincom-itspubplugin-get_pluginname
    HRESULT get_pluginName(BSTR* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tspubplugincom/nf-tspubplugincom-itspubplugin-get_pluginversion
    HRESULT get_pluginVersion(BSTR* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tspubplugincom/nf-tspubplugincom-itspubplugin-resolveresource
    HRESULT ResolveResource(uint* resourceType, PWSTR resourceLocation, PWSTR endPointName, PWSTR userID, 
                            PWSTR alias_);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tspubplugin2com/nn-tspubplugin2com-itspubplugin2
@GUID("fa4ce418-aad7-4ec6-bad1-0a321ba465d5")
interface ItsPubPlugin2 : ItsPubPlugin
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tspubplugin2com/nf-tspubplugin2com-itspubplugin2-getresource2list
    HRESULT GetResource2List(const(PWSTR) userID, int* pceAppListSize, pluginResource2** resourceList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tspubplugin2com/nf-tspubplugin2com-itspubplugin2-getresource2
    HRESULT GetResource2(const(PWSTR) alias_, int flags, pluginResource2* resource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tspubplugin2com/nf-tspubplugin2com-itspubplugin2-resolvepersonaldesktop
    HRESULT ResolvePersonalDesktop(const(PWSTR) userId, const(PWSTR) poolId, 
                                   TSPUB_PLUGIN_PD_RESOLUTION_TYPE ePdResolutionType, 
                                   TSPUB_PLUGIN_PD_ASSIGNMENT_TYPE* pPdAssignmentType, PWSTR endPointName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tspubplugin2com/nf-tspubplugin2com-itspubplugin2-deletepersonaldesktopassignment
    HRESULT DeletePersonalDesktopAssignment(const(PWSTR) userId, const(PWSTR) poolId, const(PWSTR) endpointName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/workspaceax/nn-workspaceax-iworkspacerestyperegistry
@GUID("1d428c79-6e2e-4351-a361-c0401a03a0ba")
interface IWorkspaceResTypeRegistry : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/workspaceax/nf-workspaceax-iworkspacerestyperegistry-addresourcetype
    HRESULT AddResourceType(VARIANT_BOOL fMachineWide, BSTR bstrFileExtension, BSTR bstrLauncher);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/workspaceax/nf-workspaceax-iworkspacerestyperegistry-deleteresourcetype
    HRESULT DeleteResourceType(VARIANT_BOOL fMachineWide, BSTR bstrFileExtension);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/workspaceax/nf-workspaceax-iworkspacerestyperegistry-getregisteredfileextensions
    HRESULT GetRegisteredFileExtensions(VARIANT_BOOL fMachineWide, SAFEARRAY** psaFileExtensions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/workspaceax/nf-workspaceax-iworkspacerestyperegistry-getresourcetypeinfo
    HRESULT GetResourceTypeInfo(VARIANT_BOOL fMachineWide, BSTR bstrFileExtension, BSTR* pbstrLauncher);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/workspaceax/nf-workspaceax-iworkspacerestyperegistry-modifyresourcetype
    HRESULT ModifyResourceType(VARIANT_BOOL fMachineWide, BSTR bstrFileExtension, BSTR bstrLauncher);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsvirtualchannels/nn-tsvirtualchannels-iwtsplugin
@GUID("a1230201-1439-4e62-a414-190d0ac3d40e")
interface IWTSPlugin : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsvirtualchannels/nf-tsvirtualchannels-iwtsplugin-initialize
    HRESULT Initialize(IWTSVirtualChannelManager pChannelMgr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsvirtualchannels/nf-tsvirtualchannels-iwtsplugin-connected
    HRESULT Connected();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsvirtualchannels/nf-tsvirtualchannels-iwtsplugin-disconnected
    HRESULT Disconnected(uint dwDisconnectCode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsvirtualchannels/nf-tsvirtualchannels-iwtsplugin-terminated
    HRESULT Terminated();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsvirtualchannels/nn-tsvirtualchannels-iwtslistener
@GUID("a1230206-9a39-4d58-8674-cdb4dff4e73b")
interface IWTSListener : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsvirtualchannels/nf-tsvirtualchannels-iwtslistener-getconfiguration
    HRESULT GetConfiguration(IPropertyBag* ppPropertyBag);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsvirtualchannels/nn-tsvirtualchannels-iwtslistenercallback
@GUID("a1230203-d6a7-11d8-b9fd-000bdbd1f198")
interface IWTSListenerCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsvirtualchannels/nf-tsvirtualchannels-iwtslistenercallback-onnewchannelconnection
    HRESULT OnNewChannelConnection(IWTSVirtualChannel pChannel, BSTR data, BOOL* pbAccept, 
                                   IWTSVirtualChannelCallback* ppCallback);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsvirtualchannels/nn-tsvirtualchannels-iwtsvirtualchannelcallback
@GUID("a1230204-d6a7-11d8-b9fd-000bdbd1f198")
interface IWTSVirtualChannelCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsvirtualchannels/nf-tsvirtualchannels-iwtsvirtualchannelcallback-ondatareceived
    HRESULT OnDataReceived(uint cbSize, ubyte* pBuffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsvirtualchannels/nf-tsvirtualchannels-iwtsvirtualchannelcallback-onclose
    HRESULT OnClose();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsvirtualchannels/nn-tsvirtualchannels-iwtsvirtualchannelmanager
@GUID("a1230205-d6a7-11d8-b9fd-000bdbd1f198")
interface IWTSVirtualChannelManager : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsvirtualchannels/nf-tsvirtualchannels-iwtsvirtualchannelmanager-createlistener
    HRESULT CreateListener(const(PSTR) pszChannelName, uint uFlags, IWTSListenerCallback pListenerCallback, 
                           IWTSListener* ppListener);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsvirtualchannels/nn-tsvirtualchannels-iwtsvirtualchannel
@GUID("a1230207-d6a7-11d8-b9fd-000bdbd1f198")
interface IWTSVirtualChannel : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsvirtualchannels/nf-tsvirtualchannels-iwtsvirtualchannel-write
    HRESULT Write(uint cbSize, ubyte* pBuffer, IUnknown pReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsvirtualchannels/nf-tsvirtualchannels-iwtsvirtualchannel-close
    HRESULT Close();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsvirtualchannels/nn-tsvirtualchannels-iwtspluginserviceprovider
@GUID("d3e07363-087c-476c-86a7-dbb15f46ddb4")
interface IWTSPluginServiceProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsvirtualchannels/nf-tsvirtualchannels-iwtspluginserviceprovider-getservice
    HRESULT GetService(GUID ServiceId, IUnknown* ppunkObject);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsvirtualchannels/nn-tsvirtualchannels-iwtsbitmaprenderer
@GUID("5b7acc97-f3c9-46f7-8c5b-fa685d3441b1")
interface IWTSBitmapRenderer : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsvirtualchannels/nf-tsvirtualchannels-iwtsbitmaprenderer-render
    HRESULT Render(GUID imageFormat, uint dwWidth, uint dwHeight, int cbStride, uint cbImageBuffer, 
                   ubyte* pImageBuffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsvirtualchannels/nf-tsvirtualchannels-iwtsbitmaprenderer-getrendererstatistics
    HRESULT GetRendererStatistics(BITMAP_RENDERER_STATISTICS* pStatistics);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsvirtualchannels/nf-tsvirtualchannels-iwtsbitmaprenderer-removemapping
    HRESULT RemoveMapping();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsvirtualchannels/nn-tsvirtualchannels-iwtsbitmaprenderercallback
@GUID("d782928e-fe4e-4e77-ae90-9cd0b3e3b353")
interface IWTSBitmapRendererCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsvirtualchannels/nf-tsvirtualchannels-iwtsbitmaprenderercallback-ontargetsizechanged
    HRESULT OnTargetSizeChanged(RECT rcNewSize);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsvirtualchannels/nn-tsvirtualchannels-iwtsbitmaprenderservice
@GUID("ea326091-05fe-40c1-b49c-3d2ef4626a0e")
interface IWTSBitmapRenderService : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tsvirtualchannels/nf-tsvirtualchannels-iwtsbitmaprenderservice-getmappedrenderer
    HRESULT GetMappedRenderer(ulong mappingId, IWTSBitmapRendererCallback pMappedRendererCallback, 
                              IWTSBitmapRenderer* ppMappedRenderer);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wrdsgraphicschannels/nn-wrdsgraphicschannels-iwrdsgraphicschannelevents
@GUID("67f2368c-d674-4fae-66a5-d20628a640d2")
interface IWRdsGraphicsChannelEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wrdsgraphicschannels/nf-wrdsgraphicschannels-iwrdsgraphicschannelevents-ondatareceived
    HRESULT OnDataReceived(uint cbSize, ubyte* pBuffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wrdsgraphicschannels/nf-wrdsgraphicschannels-iwrdsgraphicschannelevents-onclose
    HRESULT OnClose();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wrdsgraphicschannels/nf-wrdsgraphicschannels-iwrdsgraphicschannelevents-onchannelopened
    HRESULT OnChannelOpened(HRESULT OpenResult, IUnknown pOpenContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wrdsgraphicschannels/nf-wrdsgraphicschannels-iwrdsgraphicschannelevents-ondatasent
    HRESULT OnDataSent(IUnknown pWriteContext, BOOL bCancelled, ubyte* pBuffer, uint cbBuffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wrdsgraphicschannels/nf-wrdsgraphicschannels-iwrdsgraphicschannelevents-onmetricsupdate
    HRESULT OnMetricsUpdate(uint bandwidth, uint RTT, ulong lastSentByteIndex);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wrdsgraphicschannels/nn-wrdsgraphicschannels-iwrdsgraphicschannel
@GUID("684b7a0b-edff-43ad-d5a2-4a8d5388f401")
interface IWRdsGraphicsChannel : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wrdsgraphicschannels/nf-wrdsgraphicschannels-iwrdsgraphicschannel-write
    HRESULT Write(uint cbSize, ubyte* pBuffer, IUnknown pContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wrdsgraphicschannels/nf-wrdsgraphicschannels-iwrdsgraphicschannel-close
    HRESULT Close();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wrdsgraphicschannels/nf-wrdsgraphicschannels-iwrdsgraphicschannel-open
    HRESULT Open(IWRdsGraphicsChannelEvents pChannelEvents, IUnknown pOpenContext);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wrdsgraphicschannels/nn-wrdsgraphicschannels-iwrdsgraphicschannelmanager
@GUID("0fd57159-e83e-476a-a8b9-4a7976e71e18")
interface IWRdsGraphicsChannelManager : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wrdsgraphicschannels/nf-wrdsgraphicschannels-iwrdsgraphicschannelmanager-createchannel
    HRESULT CreateChannel(const(ubyte)* pszChannelName, WRdsGraphicsChannelType channelType, 
                          IWRdsGraphicsChannel* ppVirtualChannel);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nn-wtsprotocol-iwtsprotocolmanager
@GUID("f9eaf6cc-ed79-4f01-821d-1f881b9f66cc")
interface IWTSProtocolManager : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwtsprotocolmanager-createlistener
    HRESULT CreateListener(PWSTR wszListenerName, IWTSProtocolListener* pProtocolListener);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwtsprotocolmanager-notifyservicestatechange
    HRESULT NotifyServiceStateChange(WTS_SERVICE_STATE* pTSServiceStateChange);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwtsprotocolmanager-notifysessionofservicestart
    HRESULT NotifySessionOfServiceStart(WTS_SESSION_ID* SessionId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwtsprotocolmanager-notifysessionofservicestop
    HRESULT NotifySessionOfServiceStop(WTS_SESSION_ID* SessionId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwtsprotocolmanager-notifysessionstatechange
    HRESULT NotifySessionStateChange(WTS_SESSION_ID* SessionId, uint EventId);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nn-wtsprotocol-iwtsprotocollistener
@GUID("23083765-45f0-4394-8f69-32b2bc0ef4ca")
interface IWTSProtocolListener : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwtsprotocollistener-startlisten
    HRESULT StartListen(IWTSProtocolListenerCallback pCallback);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwtsprotocollistener-stoplisten
    HRESULT StopListen();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nn-wtsprotocol-iwtsprotocollistenercallback
@GUID("23083765-1a2d-4de2-97de-4a35f260f0b3")
interface IWTSProtocolListenerCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwtsprotocollistenercallback-onconnected
    HRESULT OnConnected(IWTSProtocolConnection pConnection, IWTSProtocolConnectionCallback* pCallback);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nn-wtsprotocol-iwtsprotocolconnection
@GUID("23083765-9095-4648-98bf-ef81c914032d")
interface IWTSProtocolConnection : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwtsprotocolconnection-getlogonerrorredirector
    HRESULT GetLogonErrorRedirector(IWTSProtocolLogonErrorRedirector* ppLogonErrorRedir);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwtsprotocolconnection-sendpolicydata
    HRESULT SendPolicyData(WTS_POLICY_DATA* pPolicyData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwtsprotocolconnection-acceptconnection
    HRESULT AcceptConnection();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwtsprotocolconnection-getclientdata
    HRESULT GetClientData(WTS_CLIENT_DATA* pClientData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwtsprotocolconnection-getusercredentials
    HRESULT GetUserCredentials(WTS_USER_CREDENTIAL* pUserCreds);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwtsprotocolconnection-getlicenseconnection
    HRESULT GetLicenseConnection(IWTSProtocolLicenseConnection* ppLicenseConnection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwtsprotocolconnection-authenticateclienttosession
    HRESULT AuthenticateClientToSession(WTS_SESSION_ID* SessionId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwtsprotocolconnection-notifysessionid
    HRESULT NotifySessionId(WTS_SESSION_ID* SessionId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwtsprotocolconnection-getprotocolhandles
    HRESULT GetProtocolHandles(HANDLE_PTR* pKeyboardHandle, HANDLE_PTR* pMouseHandle, HANDLE_PTR* pBeepHandle, 
                               HANDLE_PTR* pVideoHandle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwtsprotocolconnection-connectnotify
    HRESULT ConnectNotify(uint SessionId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwtsprotocolconnection-isuserallowedtologon
    HRESULT IsUserAllowedToLogon(uint SessionId, HANDLE_PTR UserToken, PWSTR pDomainName, PWSTR pUserName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwtsprotocolconnection-sessionarbitrationenumeration
    HRESULT SessionArbitrationEnumeration(HANDLE_PTR hUserToken, BOOL bSingleSessionPerUserEnabled, 
                                          uint* pSessionIdArray, uint* pdwSessionIdentifierCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwtsprotocolconnection-logonnotify
    HRESULT LogonNotify(HANDLE_PTR hClientToken, PWSTR wszUserName, PWSTR wszDomainName, WTS_SESSION_ID* SessionId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwtsprotocolconnection-getuserdata
    HRESULT GetUserData(WTS_POLICY_DATA* pPolicyData, WTS_USER_DATA* pClientData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwtsprotocolconnection-disconnectnotify
    HRESULT DisconnectNotify();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwtsprotocolconnection-close
    HRESULT Close();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwtsprotocolconnection-getprotocolstatus
    HRESULT GetProtocolStatus(WTS_PROTOCOL_STATUS* pProtocolStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwtsprotocolconnection-getlastinputtime
    HRESULT GetLastInputTime(ulong* pLastInputTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwtsprotocolconnection-seterrorinfo
    HRESULT SetErrorInfo(uint ulError);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwtsprotocolconnection-sendbeep
    HRESULT SendBeep(uint Frequency, uint Duration);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwtsprotocolconnection-createvirtualchannel
    HRESULT CreateVirtualChannel(PSTR szEndpointName, BOOL bStatic, uint RequestedPriority, size_t* phChannel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwtsprotocolconnection-queryproperty
    HRESULT QueryProperty(GUID QueryType, uint ulNumEntriesIn, uint ulNumEntriesOut, 
                          WTS_PROPERTY_VALUE* pPropertyEntriesIn, WTS_PROPERTY_VALUE* pPropertyEntriesOut);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwtsprotocolconnection-getshadowconnection
    HRESULT GetShadowConnection(IWTSProtocolShadowConnection* ppShadowConnection);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nn-wtsprotocol-iwtsprotocolconnectioncallback
@GUID("23083765-75eb-41fe-b4fb-e086242afa0f")
interface IWTSProtocolConnectionCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwtsprotocolconnectioncallback-onready
    HRESULT OnReady();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwtsprotocolconnectioncallback-brokenconnection
    HRESULT BrokenConnection(uint Reason, uint Source);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwtsprotocolconnectioncallback-stopscreenupdates
    HRESULT StopScreenUpdates();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwtsprotocolconnectioncallback-redrawwindow
    HRESULT RedrawWindow(WTS_SMALL_RECT* rect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwtsprotocolconnectioncallback-displayioctl
    HRESULT DisplayIOCtl(WTS_DISPLAY_IOCTL* DisplayIOCtl);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nn-wtsprotocol-iwtsprotocolshadowconnection
@GUID("ee3b0c14-37fb-456b-bab3-6d6cd51e13bf")
interface IWTSProtocolShadowConnection : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwtsprotocolshadowconnection-start
    HRESULT Start(PWSTR pTargetServerName, uint TargetSessionId, ubyte HotKeyVk, ushort HotkeyModifiers, 
                  IWTSProtocolShadowCallback pShadowCallback);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwtsprotocolshadowconnection-stop
    HRESULT Stop();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwtsprotocolshadowconnection-dotarget
    HRESULT DoTarget(ubyte* pParam1, uint Param1Size, ubyte* pParam2, uint Param2Size, ubyte* pParam3, 
                     uint Param3Size, ubyte* pParam4, uint Param4Size, PWSTR pClientName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nn-wtsprotocol-iwtsprotocolshadowcallback
@GUID("503a2504-aae5-4ab1-93e0-6d1c4bc6f71a")
interface IWTSProtocolShadowCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwtsprotocolshadowcallback-stopshadow
    HRESULT StopShadow();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwtsprotocolshadowcallback-invoketargetshadow
    HRESULT InvokeTargetShadow(PWSTR pTargetServerName, uint TargetSessionId, ubyte* pParam1, uint Param1Size, 
                               ubyte* pParam2, uint Param2Size, ubyte* pParam3, uint Param3Size, ubyte* pParam4, 
                               uint Param4Size, PWSTR pClientName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nn-wtsprotocol-iwtsprotocollicenseconnection
@GUID("23083765-178c-4079-8e4a-fea6496a4d70")
interface IWTSProtocolLicenseConnection : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwtsprotocollicenseconnection-requestlicensingcapabilities
    HRESULT RequestLicensingCapabilities(WTS_LICENSE_CAPABILITIES* ppLicenseCapabilities, 
                                         uint* pcbLicenseCapabilities);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwtsprotocollicenseconnection-sendclientlicense
    HRESULT SendClientLicense(ubyte* pClientLicense, uint cbClientLicense);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwtsprotocollicenseconnection-requestclientlicense
    HRESULT RequestClientLicense(ubyte* Reserve1, uint Reserve2, ubyte* ppClientLicense, uint* pcbClientLicense);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwtsprotocollicenseconnection-protocolcomplete
    HRESULT ProtocolComplete(uint ulComplete);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nn-wtsprotocol-iwtsprotocollogonerrorredirector
@GUID("fd9b61a7-2916-4627-8dee-4328711ad6cb")
interface IWTSProtocolLogonErrorRedirector : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwtsprotocollogonerrorredirector-onbeginpainting
    HRESULT OnBeginPainting();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwtsprotocollogonerrorredirector-redirectstatus
    HRESULT RedirectStatus(const(PWSTR) pszMessage, WTS_LOGON_ERROR_REDIRECTOR_RESPONSE* pResponse);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwtsprotocollogonerrorredirector-redirectmessage
    HRESULT RedirectMessage(const(PWSTR) pszCaption, const(PWSTR) pszMessage, uint uType, 
                            WTS_LOGON_ERROR_REDIRECTOR_RESPONSE* pResponse);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwtsprotocollogonerrorredirector-redirectlogonerror
    HRESULT RedirectLogonError(int ntsStatus, int ntsSubstatus, const(PWSTR) pszCaption, const(PWSTR) pszMessage, 
                               uint uType, WTS_LOGON_ERROR_REDIRECTOR_RESPONSE* pResponse);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nn-wtsprotocol-iwrdsprotocolsettings
@GUID("654a5a6a-2550-47eb-b6f7-ebd637475265")
interface IWRdsProtocolSettings : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocolsettings-getsettings
    HRESULT GetSettings(WRDS_SETTING_TYPE WRdsSettingType, WRDS_SETTING_LEVEL WRdsSettingLevel, 
                        WRDS_SETTINGS* pWRdsSettings);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocolsettings-mergesettings
    HRESULT MergeSettings(WRDS_SETTINGS* pWRdsSettings, WRDS_CONNECTION_SETTING_LEVEL WRdsConnectionSettingLevel, 
                          WRDS_CONNECTION_SETTINGS* pWRdsConnectionSettings);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nn-wtsprotocol-iwrdsprotocolmanager
@GUID("dc796967-3abb-40cd-a446-105276b58950")
interface IWRdsProtocolManager : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocolmanager-initialize
    HRESULT Initialize(IWRdsProtocolSettings pIWRdsSettings, WRDS_SETTINGS* pWRdsSettings);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocolmanager-createlistener
    HRESULT CreateListener(PWSTR wszListenerName, IWRdsProtocolListener* pProtocolListener);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocolmanager-notifyservicestatechange
    HRESULT NotifyServiceStateChange(WTS_SERVICE_STATE* pTSServiceStateChange);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocolmanager-notifysessionofservicestart
    HRESULT NotifySessionOfServiceStart(WTS_SESSION_ID* SessionId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocolmanager-notifysessionofservicestop
    HRESULT NotifySessionOfServiceStop(WTS_SESSION_ID* SessionId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocolmanager-notifysessionstatechange
    HRESULT NotifySessionStateChange(WTS_SESSION_ID* SessionId, uint EventId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocolmanager-notifysettingschange
    HRESULT NotifySettingsChange(WRDS_SETTINGS* pWRdsSettings);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocolmanager-uninitialize
    HRESULT Uninitialize();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nn-wtsprotocol-iwrdsprotocollistener
@GUID("fcbc131b-c686-451d-a773-e279e230f540")
interface IWRdsProtocolListener : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocollistener-getsettings
    HRESULT GetSettings(WRDS_LISTENER_SETTING_LEVEL WRdsListenerSettingLevel, 
                        WRDS_LISTENER_SETTINGS* pWRdsListenerSettings);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocollistener-startlisten
    HRESULT StartListen(IWRdsProtocolListenerCallback pCallback);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocollistener-stoplisten
    HRESULT StopListen();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nn-wtsprotocol-iwrdsprotocollistenercallback
@GUID("3ab27e5b-4449-4dc1-b74a-91621d4fe984")
interface IWRdsProtocolListenerCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocollistenercallback-onconnected
    HRESULT OnConnected(IWRdsProtocolConnection pConnection, WRDS_CONNECTION_SETTINGS* pWRdsConnectionSettings, 
                        IWRdsProtocolConnectionCallback* pCallback);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nn-wtsprotocol-iwrdsprotocolconnection
@GUID("324ed94f-fdaf-4ff6-81a8-42abe755830b")
interface IWRdsProtocolConnection : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocolconnection-getlogonerrorredirector
    HRESULT GetLogonErrorRedirector(IWRdsProtocolLogonErrorRedirector* ppLogonErrorRedir);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocolconnection-acceptconnection
    HRESULT AcceptConnection();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocolconnection-getclientdata
    HRESULT GetClientData(WTS_CLIENT_DATA* pClientData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocolconnection-getclientmonitordata
    HRESULT GetClientMonitorData(uint* pNumMonitors, uint* pPrimaryMonitor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocolconnection-getusercredentials
    HRESULT GetUserCredentials(WTS_USER_CREDENTIAL* pUserCreds);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocolconnection-getlicenseconnection
    HRESULT GetLicenseConnection(IWRdsProtocolLicenseConnection* ppLicenseConnection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocolconnection-authenticateclienttosession
    HRESULT AuthenticateClientToSession(WTS_SESSION_ID* SessionId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocolconnection-notifysessionid
    HRESULT NotifySessionId(WTS_SESSION_ID* SessionId, HANDLE_PTR SessionHandle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocolconnection-getinputhandles
    HRESULT GetInputHandles(HANDLE_PTR* pKeyboardHandle, HANDLE_PTR* pMouseHandle, HANDLE_PTR* pBeepHandle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocolconnection-getvideohandle
    HRESULT GetVideoHandle(HANDLE_PTR* pVideoHandle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocolconnection-connectnotify
    HRESULT ConnectNotify(uint SessionId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocolconnection-isuserallowedtologon
    HRESULT IsUserAllowedToLogon(uint SessionId, HANDLE_PTR UserToken, PWSTR pDomainName, PWSTR pUserName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocolconnection-sessionarbitrationenumeration
    HRESULT SessionArbitrationEnumeration(HANDLE_PTR hUserToken, BOOL bSingleSessionPerUserEnabled, 
                                          uint* pSessionIdArray, uint* pdwSessionIdentifierCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocolconnection-logonnotify
    HRESULT LogonNotify(HANDLE_PTR hClientToken, PWSTR wszUserName, PWSTR wszDomainName, WTS_SESSION_ID* SessionId, 
                        WRDS_CONNECTION_SETTINGS* pWRdsConnectionSettings);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocolconnection-predisconnect
    HRESULT PreDisconnect(uint DisconnectReason);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocolconnection-disconnectnotify
    HRESULT DisconnectNotify();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocolconnection-close
    HRESULT Close();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocolconnection-getprotocolstatus
    HRESULT GetProtocolStatus(WTS_PROTOCOL_STATUS* pProtocolStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocolconnection-getlastinputtime
    HRESULT GetLastInputTime(ulong* pLastInputTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocolconnection-seterrorinfo
    HRESULT SetErrorInfo(uint ulError);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocolconnection-createvirtualchannel
    HRESULT CreateVirtualChannel(PSTR szEndpointName, BOOL bStatic, uint RequestedPriority, size_t* phChannel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocolconnection-queryproperty
    HRESULT QueryProperty(GUID QueryType, uint ulNumEntriesIn, uint ulNumEntriesOut, 
                          WTS_PROPERTY_VALUE* pPropertyEntriesIn, WTS_PROPERTY_VALUE* pPropertyEntriesOut);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocolconnection-getshadowconnection
    HRESULT GetShadowConnection(IWRdsProtocolShadowConnection* ppShadowConnection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocolconnection-notifycommandprocesscreated
    HRESULT NotifyCommandProcessCreated(uint SessionId);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nn-wtsprotocol-iwrdsprotocolconnectioncallback
@GUID("f1d70332-d070-4ef1-a088-78313536c2d6")
interface IWRdsProtocolConnectionCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocolconnectioncallback-onready
    HRESULT OnReady();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocolconnectioncallback-brokenconnection
    HRESULT BrokenConnection(uint Reason, uint Source);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocolconnectioncallback-stopscreenupdates
    HRESULT StopScreenUpdates();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocolconnectioncallback-redrawwindow
    HRESULT RedrawWindow(WTS_SMALL_RECT* rect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocolconnectioncallback-getconnectionid
    HRESULT GetConnectionId(uint* pConnectionId);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nn-wtsprotocol-iwrdsprotocolshadowconnection
@GUID("9ae85ce6-cade-4548-8feb-99016597f60a")
interface IWRdsProtocolShadowConnection : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocolshadowconnection-start
    HRESULT Start(PWSTR pTargetServerName, uint TargetSessionId, ubyte HotKeyVk, ushort HotkeyModifiers, 
                  IWRdsProtocolShadowCallback pShadowCallback);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocolshadowconnection-stop
    HRESULT Stop();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocolshadowconnection-dotarget
    HRESULT DoTarget(ubyte* pParam1, uint Param1Size, ubyte* pParam2, uint Param2Size, ubyte* pParam3, 
                     uint Param3Size, ubyte* pParam4, uint Param4Size, PWSTR pClientName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nn-wtsprotocol-iwrdsprotocolshadowcallback
@GUID("e0667ce0-0372-40d6-adb2-a0f3322674d6")
interface IWRdsProtocolShadowCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocolshadowcallback-stopshadow
    HRESULT StopShadow();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocolshadowcallback-invoketargetshadow
    HRESULT InvokeTargetShadow(PWSTR pTargetServerName, uint TargetSessionId, ubyte* pParam1, uint Param1Size, 
                               ubyte* pParam2, uint Param2Size, ubyte* pParam3, uint Param3Size, ubyte* pParam4, 
                               uint Param4Size, PWSTR pClientName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nn-wtsprotocol-iwrdsprotocollicenseconnection
@GUID("1d6a145f-d095-4424-957a-407fae822d84")
interface IWRdsProtocolLicenseConnection : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocollicenseconnection-requestlicensingcapabilities
    HRESULT RequestLicensingCapabilities(WTS_LICENSE_CAPABILITIES* ppLicenseCapabilities, 
                                         uint* pcbLicenseCapabilities);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocollicenseconnection-sendclientlicense
    HRESULT SendClientLicense(ubyte* pClientLicense, uint cbClientLicense);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocollicenseconnection-requestclientlicense
    HRESULT RequestClientLicense(ubyte* Reserve1, uint Reserve2, ubyte* ppClientLicense, uint* pcbClientLicense);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocollicenseconnection-protocolcomplete
    HRESULT ProtocolComplete(uint ulComplete);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nn-wtsprotocol-iwrdsprotocollogonerrorredirector
@GUID("519fe83b-142a-4120-a3d5-a405d315281a")
interface IWRdsProtocolLogonErrorRedirector : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocollogonerrorredirector-onbeginpainting
    HRESULT OnBeginPainting();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocollogonerrorredirector-redirectstatus
    HRESULT RedirectStatus(const(PWSTR) pszMessage, WTS_LOGON_ERROR_REDIRECTOR_RESPONSE* pResponse);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocollogonerrorredirector-redirectmessage
    HRESULT RedirectMessage(const(PWSTR) pszCaption, const(PWSTR) pszMessage, uint uType, 
                            WTS_LOGON_ERROR_REDIRECTOR_RESPONSE* pResponse);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsprotocollogonerrorredirector-redirectlogonerror
    HRESULT RedirectLogonError(int ntsStatus, int ntsSubstatus, const(PWSTR) pszCaption, const(PWSTR) pszMessage, 
                               uint uType, WTS_LOGON_ERROR_REDIRECTOR_RESPONSE* pResponse);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nn-wtsprotocol-iwrdswddmiddprops
@GUID("1382df4d-a289-43d1-a184-144726f9af90")
interface IWRdsWddmIddProps : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdswddmiddprops-gethardwareid
    HRESULT GetHardwareId(PWSTR pDisplayDriverHardwareId, uint Count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdswddmiddprops-ondriverload
    HRESULT OnDriverLoad(uint SessionId, HANDLE_PTR DriverHandle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdswddmiddprops-ondriverunload
    HRESULT OnDriverUnload(uint SessionId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdswddmiddprops-enablewddmidd
    HRESULT EnableWddmIdd(BOOL Enabled);
}

@GUID("60f71b1a-3682-4bc7-997e-4e4f02a08148")
interface IWRdsWddmIddProps1 : IUnknown
{
    HRESULT GetHardwareId(PWSTR pDisplayDriverHardwareId, uint Count);
    HRESULT OnDriverLoad(uint SessionId, const(PWSTR) DeviceInstance);
    HRESULT OnDriverUnload(uint SessionId);
}

@GUID("83fcf5d3-f6f4-ea94-9cd2-32f280e1e510")
interface IWRdsProtocolConnectionSettings : IUnknown
{
    HRESULT SetConnectionSetting(GUID PropertyID, WTS_PROPERTY_VALUE* pPropertyEntriesIn);
    HRESULT GetConnectionSetting(GUID PropertyID, WTS_PROPERTY_VALUE* pPropertyEntriesOut);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nn-wtsprotocol-iwrdsenhancedfastreconnectarbitrator
@GUID("5718ae9b-47f2-499f-b634-d8175bd51131")
interface IWRdsEnhancedFastReconnectArbitrator : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtsprotocol/nf-wtsprotocol-iwrdsenhancedfastreconnectarbitrator-getsessionforenhancedfastreconnect
    HRESULT GetSessionForEnhancedFastReconnect(int* pSessionIdArray, uint dwSessionCount, int* pResultSessionId);
}

@GUID("c2bd9b66-4a76-4701-b6a3-bfafc1482169")
interface IWRdsProtocolConnection2 : IWRdsProtocolConnection
{
    HRESULT GetSerializedUserCredential(WTS_SERIALIZED_USER_CREDENTIAL** userCredential);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpappcontainerclient/nn-rdpappcontainerclient-iremotedesktopclientsettings
@GUID("48a0f2a7-2713-431f-bbac-6f4558e7d64d")
interface IRemoteDesktopClientSettings : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpappcontainerclient/nf-rdpappcontainerclient-iremotedesktopclientsettings-applysettings
    HRESULT ApplySettings(BSTR rdpFileContents);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpappcontainerclient/nf-rdpappcontainerclient-iremotedesktopclientsettings-retrievesettings
    HRESULT RetrieveSettings(BSTR* rdpFileContents);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpappcontainerclient/nf-rdpappcontainerclient-iremotedesktopclientsettings-getrdpproperty
    HRESULT GetRdpProperty(BSTR propertyName, VARIANT* value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpappcontainerclient/nf-rdpappcontainerclient-iremotedesktopclientsettings-setrdpproperty
    HRESULT SetRdpProperty(BSTR propertyName, VARIANT value);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpappcontainerclient/nn-rdpappcontainerclient-iremotedesktopclientactions
@GUID("7d54bc4e-1028-45d4-8b0a-b9b6bffba176")
interface IRemoteDesktopClientActions : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpappcontainerclient/nf-rdpappcontainerclient-iremotedesktopclientactions-suspendscreenupdates
    HRESULT SuspendScreenUpdates();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpappcontainerclient/nf-rdpappcontainerclient-iremotedesktopclientactions-resumescreenupdates
    HRESULT ResumeScreenUpdates();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpappcontainerclient/nf-rdpappcontainerclient-iremotedesktopclientactions-executeremoteaction
    HRESULT ExecuteRemoteAction(RemoteActionType remoteAction);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpappcontainerclient/nf-rdpappcontainerclient-iremotedesktopclientactions-getsnapshot
    HRESULT GetSnapshot(SnapshotEncodingType snapshotEncoding, SnapshotFormatType snapshotFormat, 
                        uint snapshotWidth, uint snapshotHeight, BSTR* snapshotData);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpappcontainerclient/nn-rdpappcontainerclient-iremotedesktopclienttouchpointer
@GUID("260ec22d-8cbc-44b5-9e88-2a37f6c93ae9")
interface IRemoteDesktopClientTouchPointer : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpappcontainerclient/nf-rdpappcontainerclient-iremotedesktopclienttouchpointer-put_enabled
    HRESULT put_Enabled(VARIANT_BOOL enabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpappcontainerclient/nf-rdpappcontainerclient-iremotedesktopclienttouchpointer-get_enabled
    HRESULT get_Enabled(VARIANT_BOOL* enabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpappcontainerclient/nf-rdpappcontainerclient-iremotedesktopclienttouchpointer-put_eventsenabled
    HRESULT put_EventsEnabled(VARIANT_BOOL eventsEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpappcontainerclient/nf-rdpappcontainerclient-iremotedesktopclienttouchpointer-get_eventsenabled
    HRESULT get_EventsEnabled(VARIANT_BOOL* eventsEnabled);
    HRESULT put_PointerSpeed(uint pointerSpeed);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpappcontainerclient/nf-rdpappcontainerclient-iremotedesktopclienttouchpointer-get_pointerspeed
    HRESULT get_PointerSpeed(uint* pointerSpeed);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpappcontainerclient/nn-rdpappcontainerclient-iremotedesktopclient
@GUID("57d25668-625a-4905-be4e-304caa13f89c")
interface IRemoteDesktopClient : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpappcontainerclient/nf-rdpappcontainerclient-iremotedesktopclient-connect
    HRESULT Connect();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpappcontainerclient/nf-rdpappcontainerclient-iremotedesktopclient-disconnect
    HRESULT Disconnect();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpappcontainerclient/nf-rdpappcontainerclient-iremotedesktopclient-reconnect
    HRESULT Reconnect(uint width, uint height);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpappcontainerclient/nf-rdpappcontainerclient-iremotedesktopclient-get_settings
    HRESULT get_Settings(IRemoteDesktopClientSettings* settings);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpappcontainerclient/nf-rdpappcontainerclient-iremotedesktopclient-get_actions
    HRESULT get_Actions(IRemoteDesktopClientActions* actions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpappcontainerclient/nf-rdpappcontainerclient-iremotedesktopclient-get_touchpointer
    HRESULT get_TouchPointer(IRemoteDesktopClientTouchPointer* touchPointer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpappcontainerclient/nf-rdpappcontainerclient-iremotedesktopclient-deletesavedcredentials
    HRESULT DeleteSavedCredentials(BSTR serverName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpappcontainerclient/nf-rdpappcontainerclient-iremotedesktopclient-updatesessiondisplaysettings
    HRESULT UpdateSessionDisplaySettings(uint width, uint height);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpappcontainerclient/nf-rdpappcontainerclient-iremotedesktopclient-attachevent
    HRESULT attachEvent(BSTR eventName, IDispatch callback);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rdpappcontainerclient/nf-rdpappcontainerclient-iremotedesktopclient-detachevent
    HRESULT detachEvent(BSTR eventName, IDispatch callback);
}

@GUID("eeaa3d5f-ec63-4d27-af38-e86b1d7292cb")
interface IRemoteSystemAdditionalInfoProvider : IUnknown
{
    HRESULT GetAdditionalInfo(HSTRING* deduplicationId, const(GUID)* riid, void** mapView);
}


// GUIDs

const GUID CLSID_ADsTSUserEx        = GUIDOF!ADsTSUserEx;
const GUID CLSID_TSUserExInterfaces = GUIDOF!TSUserExInterfaces;
const GUID CLSID_Workspace          = GUIDOF!Workspace;

const GUID IID_IADsTSUserEx                         = GUIDOF!IADsTSUserEx;
const GUID IID_IAudioDeviceEndpoint                 = GUIDOF!IAudioDeviceEndpoint;
const GUID IID_IAudioEndpoint                       = GUIDOF!IAudioEndpoint;
const GUID IID_IAudioEndpointControl                = GUIDOF!IAudioEndpointControl;
const GUID IID_IAudioEndpointRT                     = GUIDOF!IAudioEndpointRT;
const GUID IID_IAudioInputEndpointRT                = GUIDOF!IAudioInputEndpointRT;
const GUID IID_IAudioOutputEndpointRT               = GUIDOF!IAudioOutputEndpointRT;
const GUID IID_IRemoteDesktopClient                 = GUIDOF!IRemoteDesktopClient;
const GUID IID_IRemoteDesktopClientActions          = GUIDOF!IRemoteDesktopClientActions;
const GUID IID_IRemoteDesktopClientSettings         = GUIDOF!IRemoteDesktopClientSettings;
const GUID IID_IRemoteDesktopClientTouchPointer     = GUIDOF!IRemoteDesktopClientTouchPointer;
const GUID IID_IRemoteSystemAdditionalInfoProvider  = GUIDOF!IRemoteSystemAdditionalInfoProvider;
const GUID IID_ITSGAccountingEngine                 = GUIDOF!ITSGAccountingEngine;
const GUID IID_ITSGAuthenticateUserSink             = GUIDOF!ITSGAuthenticateUserSink;
const GUID IID_ITSGAuthenticationEngine             = GUIDOF!ITSGAuthenticationEngine;
const GUID IID_ITSGAuthorizeConnectionSink          = GUIDOF!ITSGAuthorizeConnectionSink;
const GUID IID_ITSGAuthorizeResourceSink            = GUIDOF!ITSGAuthorizeResourceSink;
const GUID IID_ITSGPolicyEngine                     = GUIDOF!ITSGPolicyEngine;
const GUID IID_ITsSbBaseNotifySink                  = GUIDOF!ITsSbBaseNotifySink;
const GUID IID_ITsSbClientConnection                = GUIDOF!ITsSbClientConnection;
const GUID IID_ITsSbClientConnectionPropertySet     = GUIDOF!ITsSbClientConnectionPropertySet;
const GUID IID_ITsSbEnvironment                     = GUIDOF!ITsSbEnvironment;
const GUID IID_ITsSbEnvironmentPropertySet          = GUIDOF!ITsSbEnvironmentPropertySet;
const GUID IID_ITsSbFilterPluginStore               = GUIDOF!ITsSbFilterPluginStore;
const GUID IID_ITsSbGenericNotifySink               = GUIDOF!ITsSbGenericNotifySink;
const GUID IID_ITsSbGlobalStore                     = GUIDOF!ITsSbGlobalStore;
const GUID IID_ITsSbLoadBalanceResult               = GUIDOF!ITsSbLoadBalanceResult;
const GUID IID_ITsSbLoadBalancing                   = GUIDOF!ITsSbLoadBalancing;
const GUID IID_ITsSbLoadBalancingNotifySink         = GUIDOF!ITsSbLoadBalancingNotifySink;
const GUID IID_ITsSbOrchestration                   = GUIDOF!ITsSbOrchestration;
const GUID IID_ITsSbOrchestrationNotifySink         = GUIDOF!ITsSbOrchestrationNotifySink;
const GUID IID_ITsSbPlacement                       = GUIDOF!ITsSbPlacement;
const GUID IID_ITsSbPlacementNotifySink             = GUIDOF!ITsSbPlacementNotifySink;
const GUID IID_ITsSbPlugin                          = GUIDOF!ITsSbPlugin;
const GUID IID_ITsSbPluginNotifySink                = GUIDOF!ITsSbPluginNotifySink;
const GUID IID_ITsSbPluginPropertySet               = GUIDOF!ITsSbPluginPropertySet;
const GUID IID_ITsSbPropertySet                     = GUIDOF!ITsSbPropertySet;
const GUID IID_ITsSbProvider                        = GUIDOF!ITsSbProvider;
const GUID IID_ITsSbProvisioning                    = GUIDOF!ITsSbProvisioning;
const GUID IID_ITsSbProvisioningPluginNotifySink    = GUIDOF!ITsSbProvisioningPluginNotifySink;
const GUID IID_ITsSbResourceNotification            = GUIDOF!ITsSbResourceNotification;
const GUID IID_ITsSbResourceNotificationEx          = GUIDOF!ITsSbResourceNotificationEx;
const GUID IID_ITsSbResourcePlugin                  = GUIDOF!ITsSbResourcePlugin;
const GUID IID_ITsSbResourcePluginStore             = GUIDOF!ITsSbResourcePluginStore;
const GUID IID_ITsSbServiceNotification             = GUIDOF!ITsSbServiceNotification;
const GUID IID_ITsSbSession                         = GUIDOF!ITsSbSession;
const GUID IID_ITsSbTarget                          = GUIDOF!ITsSbTarget;
const GUID IID_ITsSbTargetPropertySet               = GUIDOF!ITsSbTargetPropertySet;
const GUID IID_ITsSbTaskInfo                        = GUIDOF!ITsSbTaskInfo;
const GUID IID_ITsSbTaskPlugin                      = GUIDOF!ITsSbTaskPlugin;
const GUID IID_ITsSbTaskPluginNotifySink            = GUIDOF!ITsSbTaskPluginNotifySink;
const GUID IID_IWRdsEnhancedFastReconnectArbitrator = GUIDOF!IWRdsEnhancedFastReconnectArbitrator;
const GUID IID_IWRdsGraphicsChannel                 = GUIDOF!IWRdsGraphicsChannel;
const GUID IID_IWRdsGraphicsChannelEvents           = GUIDOF!IWRdsGraphicsChannelEvents;
const GUID IID_IWRdsGraphicsChannelManager          = GUIDOF!IWRdsGraphicsChannelManager;
const GUID IID_IWRdsProtocolConnection              = GUIDOF!IWRdsProtocolConnection;
const GUID IID_IWRdsProtocolConnection2             = GUIDOF!IWRdsProtocolConnection2;
const GUID IID_IWRdsProtocolConnectionCallback      = GUIDOF!IWRdsProtocolConnectionCallback;
const GUID IID_IWRdsProtocolConnectionSettings      = GUIDOF!IWRdsProtocolConnectionSettings;
const GUID IID_IWRdsProtocolLicenseConnection       = GUIDOF!IWRdsProtocolLicenseConnection;
const GUID IID_IWRdsProtocolListener                = GUIDOF!IWRdsProtocolListener;
const GUID IID_IWRdsProtocolListenerCallback        = GUIDOF!IWRdsProtocolListenerCallback;
const GUID IID_IWRdsProtocolLogonErrorRedirector    = GUIDOF!IWRdsProtocolLogonErrorRedirector;
const GUID IID_IWRdsProtocolManager                 = GUIDOF!IWRdsProtocolManager;
const GUID IID_IWRdsProtocolSettings                = GUIDOF!IWRdsProtocolSettings;
const GUID IID_IWRdsProtocolShadowCallback          = GUIDOF!IWRdsProtocolShadowCallback;
const GUID IID_IWRdsProtocolShadowConnection        = GUIDOF!IWRdsProtocolShadowConnection;
const GUID IID_IWRdsWddmIddProps                    = GUIDOF!IWRdsWddmIddProps;
const GUID IID_IWRdsWddmIddProps1                   = GUIDOF!IWRdsWddmIddProps1;
const GUID IID_IWTSBitmapRenderService              = GUIDOF!IWTSBitmapRenderService;
const GUID IID_IWTSBitmapRenderer                   = GUIDOF!IWTSBitmapRenderer;
const GUID IID_IWTSBitmapRendererCallback           = GUIDOF!IWTSBitmapRendererCallback;
const GUID IID_IWTSListener                         = GUIDOF!IWTSListener;
const GUID IID_IWTSListenerCallback                 = GUIDOF!IWTSListenerCallback;
const GUID IID_IWTSPlugin                           = GUIDOF!IWTSPlugin;
const GUID IID_IWTSPluginServiceProvider            = GUIDOF!IWTSPluginServiceProvider;
const GUID IID_IWTSProtocolConnection               = GUIDOF!IWTSProtocolConnection;
const GUID IID_IWTSProtocolConnectionCallback       = GUIDOF!IWTSProtocolConnectionCallback;
const GUID IID_IWTSProtocolLicenseConnection        = GUIDOF!IWTSProtocolLicenseConnection;
const GUID IID_IWTSProtocolListener                 = GUIDOF!IWTSProtocolListener;
const GUID IID_IWTSProtocolListenerCallback         = GUIDOF!IWTSProtocolListenerCallback;
const GUID IID_IWTSProtocolLogonErrorRedirector     = GUIDOF!IWTSProtocolLogonErrorRedirector;
const GUID IID_IWTSProtocolManager                  = GUIDOF!IWTSProtocolManager;
const GUID IID_IWTSProtocolShadowCallback           = GUIDOF!IWTSProtocolShadowCallback;
const GUID IID_IWTSProtocolShadowConnection         = GUIDOF!IWTSProtocolShadowConnection;
const GUID IID_IWTSSBPlugin                         = GUIDOF!IWTSSBPlugin;
const GUID IID_IWTSVirtualChannel                   = GUIDOF!IWTSVirtualChannel;
const GUID IID_IWTSVirtualChannelCallback           = GUIDOF!IWTSVirtualChannelCallback;
const GUID IID_IWTSVirtualChannelManager            = GUIDOF!IWTSVirtualChannelManager;
const GUID IID_IWorkspace                           = GUIDOF!IWorkspace;
const GUID IID_IWorkspace2                          = GUIDOF!IWorkspace2;
const GUID IID_IWorkspace3                          = GUIDOF!IWorkspace3;
const GUID IID_IWorkspaceClientExt                  = GUIDOF!IWorkspaceClientExt;
const GUID IID_IWorkspaceRegistration               = GUIDOF!IWorkspaceRegistration;
const GUID IID_IWorkspaceRegistration2              = GUIDOF!IWorkspaceRegistration2;
const GUID IID_IWorkspaceReportMessage              = GUIDOF!IWorkspaceReportMessage;
const GUID IID_IWorkspaceResTypeRegistry            = GUIDOF!IWorkspaceResTypeRegistry;
const GUID IID_IWorkspaceScriptable                 = GUIDOF!IWorkspaceScriptable;
const GUID IID_IWorkspaceScriptable2                = GUIDOF!IWorkspaceScriptable2;
const GUID IID_IWorkspaceScriptable3                = GUIDOF!IWorkspaceScriptable3;
const GUID IID_ItsPubPlugin                         = GUIDOF!ItsPubPlugin;
const GUID IID_ItsPubPlugin2                        = GUIDOF!ItsPubPlugin2;
const GUID IID__ITSWkspEvents                       = GUIDOF!_ITSWkspEvents;
