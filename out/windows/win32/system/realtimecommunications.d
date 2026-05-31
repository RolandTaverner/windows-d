// Written in the D programming language.

module windows.win32.system.realtimecommunications;

public import windows.core;
public import windows.win32.foundation.foundation : BSTR, HRESULT, VARIANT_BOOL;
public import windows.win32.media.directshow.directshow : IVideoWindow;
public import windows.win32.networking.winsock : TRANSPORT_SETTING_ID;
public import windows.win32.system.com.com : IDispatch, IUnknown;
public import windows.win32.system.variant : VARIANT;

extern(Windows) @nogc nothrow:


// Enums


alias RTC_AUDIO_DEVICE = int;
enum : int
{
    RTCAD_SPEAKER    = 0x00000000,
    RTCAD_MICROPHONE = 0x00000001,
}

alias RTC_VIDEO_DEVICE = int;
enum : int
{
    RTCVD_RECEIVE = 0x00000000,
    RTCVD_PREVIEW = 0x00000001,
}

alias RTC_EVENT = int;
enum : int
{
    RTCE_CLIENT                     = 0x00000000,
    RTCE_REGISTRATION_STATE_CHANGE  = 0x00000001,
    RTCE_SESSION_STATE_CHANGE       = 0x00000002,
    RTCE_SESSION_OPERATION_COMPLETE = 0x00000003,
    RTCE_PARTICIPANT_STATE_CHANGE   = 0x00000004,
    RTCE_MEDIA                      = 0x00000005,
    RTCE_INTENSITY                  = 0x00000006,
    RTCE_MESSAGING                  = 0x00000007,
    RTCE_BUDDY                      = 0x00000008,
    RTCE_WATCHER                    = 0x00000009,
    RTCE_PROFILE                    = 0x0000000a,
    RTCE_USERSEARCH                 = 0x0000000b,
    RTCE_INFO                       = 0x0000000c,
    RTCE_GROUP                      = 0x0000000d,
    RTCE_MEDIA_REQUEST              = 0x0000000e,
    RTCE_ROAMING                    = 0x0000000f,
    RTCE_PRESENCE_PROPERTY          = 0x00000010,
    RTCE_PRESENCE_DATA              = 0x00000011,
    RTCE_PRESENCE_STATUS            = 0x00000012,
    RTCE_SESSION_REFER_STATUS       = 0x00000013,
    RTCE_SESSION_REFERRED           = 0x00000014,
    RTCE_REINVITE                   = 0x00000015,
}

alias RTC_LISTEN_MODE = int;
enum : int
{
    RTCLM_NONE    = 0x00000000,
    RTCLM_DYNAMIC = 0x00000001,
    RTCLM_BOTH    = 0x00000002,
}

alias RTC_CLIENT_EVENT_TYPE = int;
enum : int
{
    RTCCET_VOLUME_CHANGE          = 0x00000000,
    RTCCET_DEVICE_CHANGE          = 0x00000001,
    RTCCET_NETWORK_QUALITY_CHANGE = 0x00000002,
    RTCCET_ASYNC_CLEANUP_DONE     = 0x00000003,
}

alias RTC_BUDDY_EVENT_TYPE = int;
enum : int
{
    RTCBET_BUDDY_ADD          = 0x00000000,
    RTCBET_BUDDY_REMOVE       = 0x00000001,
    RTCBET_BUDDY_UPDATE       = 0x00000002,
    RTCBET_BUDDY_STATE_CHANGE = 0x00000003,
    RTCBET_BUDDY_ROAMED       = 0x00000004,
    RTCBET_BUDDY_SUBSCRIBED   = 0x00000005,
}

alias RTC_WATCHER_EVENT_TYPE = int;
enum : int
{
    RTCWET_WATCHER_ADD      = 0x00000000,
    RTCWET_WATCHER_REMOVE   = 0x00000001,
    RTCWET_WATCHER_UPDATE   = 0x00000002,
    RTCWET_WATCHER_OFFERING = 0x00000003,
    RTCWET_WATCHER_ROAMED   = 0x00000004,
}

alias RTC_GROUP_EVENT_TYPE = int;
enum : int
{
    RTCGET_GROUP_ADD          = 0x00000000,
    RTCGET_GROUP_REMOVE       = 0x00000001,
    RTCGET_GROUP_UPDATE       = 0x00000002,
    RTCGET_GROUP_BUDDY_ADD    = 0x00000003,
    RTCGET_GROUP_BUDDY_REMOVE = 0x00000004,
    RTCGET_GROUP_ROAMED       = 0x00000005,
}

alias RTC_TERMINATE_REASON = int;
enum : int
{
    RTCTR_NORMAL                      = 0x00000000,
    RTCTR_DND                         = 0x00000001,
    RTCTR_BUSY                        = 0x00000002,
    RTCTR_REJECT                      = 0x00000003,
    RTCTR_TIMEOUT                     = 0x00000004,
    RTCTR_SHUTDOWN                    = 0x00000005,
    RTCTR_INSUFFICIENT_SECURITY_LEVEL = 0x00000006,
    RTCTR_NOT_SUPPORTED               = 0x00000007,
}

alias RTC_REGISTRATION_STATE = int;
enum : int
{
    RTCRS_NOT_REGISTERED       = 0x00000000,
    RTCRS_REGISTERING          = 0x00000001,
    RTCRS_REGISTERED           = 0x00000002,
    RTCRS_REJECTED             = 0x00000003,
    RTCRS_UNREGISTERING        = 0x00000004,
    RTCRS_ERROR                = 0x00000005,
    RTCRS_LOGGED_OFF           = 0x00000006,
    RTCRS_LOCAL_PA_LOGGED_OFF  = 0x00000007,
    RTCRS_REMOTE_PA_LOGGED_OFF = 0x00000008,
}

alias RTC_SESSION_STATE = int;
enum : int
{
    RTCSS_IDLE         = 0x00000000,
    RTCSS_INCOMING     = 0x00000001,
    RTCSS_ANSWERING    = 0x00000002,
    RTCSS_INPROGRESS   = 0x00000003,
    RTCSS_CONNECTED    = 0x00000004,
    RTCSS_DISCONNECTED = 0x00000005,
    RTCSS_HOLD         = 0x00000006,
    RTCSS_REFER        = 0x00000007,
}

alias RTC_PARTICIPANT_STATE = int;
enum : int
{
    RTCPS_IDLE          = 0x00000000,
    RTCPS_PENDING       = 0x00000001,
    RTCPS_INCOMING      = 0x00000002,
    RTCPS_ANSWERING     = 0x00000003,
    RTCPS_INPROGRESS    = 0x00000004,
    RTCPS_ALERTING      = 0x00000005,
    RTCPS_CONNECTED     = 0x00000006,
    RTCPS_DISCONNECTING = 0x00000007,
    RTCPS_DISCONNECTED  = 0x00000008,
}

alias RTC_WATCHER_STATE = int;
enum : int
{
    RTCWS_UNKNOWN  = 0x00000000,
    RTCWS_OFFERING = 0x00000001,
    RTCWS_ALLOWED  = 0x00000002,
    RTCWS_BLOCKED  = 0x00000003,
    RTCWS_DENIED   = 0x00000004,
    RTCWS_PROMPT   = 0x00000005,
}

alias RTC_ACE_SCOPE = int;
enum : int
{
    RTCAS_SCOPE_USER   = 0x00000000,
    RTCAS_SCOPE_DOMAIN = 0x00000001,
    RTCAS_SCOPE_ALL    = 0x00000002,
}

alias RTC_OFFER_WATCHER_MODE = int;
enum : int
{
    RTCOWM_OFFER_WATCHER_EVENT       = 0x00000000,
    RTCOWM_AUTOMATICALLY_ADD_WATCHER = 0x00000001,
}

alias RTC_WATCHER_MATCH_MODE = int;
enum : int
{
    RTCWMM_EXACT_MATCH    = 0x00000000,
    RTCWMM_BEST_ACE_MATCH = 0x00000001,
}

alias RTC_PRIVACY_MODE = int;
enum : int
{
    RTCPM_BLOCK_LIST_EXCLUDED = 0x00000000,
    RTCPM_ALLOW_LIST_ONLY     = 0x00000001,
}

alias RTC_SESSION_TYPE = int;
enum : int
{
    RTCST_PC_TO_PC       = 0x00000000,
    RTCST_PC_TO_PHONE    = 0x00000001,
    RTCST_PHONE_TO_PHONE = 0x00000002,
    RTCST_IM             = 0x00000003,
    RTCST_MULTIPARTY_IM  = 0x00000004,
    RTCST_APPLICATION    = 0x00000005,
}

alias RTC_PRESENCE_STATUS = int;
enum : int
{
    RTCXS_PRESENCE_OFFLINE       = 0x00000000,
    RTCXS_PRESENCE_ONLINE        = 0x00000001,
    RTCXS_PRESENCE_AWAY          = 0x00000002,
    RTCXS_PRESENCE_IDLE          = 0x00000003,
    RTCXS_PRESENCE_BUSY          = 0x00000004,
    RTCXS_PRESENCE_BE_RIGHT_BACK = 0x00000005,
    RTCXS_PRESENCE_ON_THE_PHONE  = 0x00000006,
    RTCXS_PRESENCE_OUT_TO_LUNCH  = 0x00000007,
}

alias RTC_BUDDY_SUBSCRIPTION_TYPE = int;
enum : int
{
    RTCBT_SUBSCRIBED     = 0x00000000,
    RTCBT_ALWAYS_OFFLINE = 0x00000001,
    RTCBT_ALWAYS_ONLINE  = 0x00000002,
    RTCBT_POLL           = 0x00000003,
}

alias RTC_MEDIA_EVENT_TYPE = int;
enum : int
{
    RTCMET_STOPPED = 0x00000000,
    RTCMET_STARTED = 0x00000001,
    RTCMET_FAILED  = 0x00000002,
}

alias RTC_MEDIA_EVENT_REASON = int;
enum : int
{
    RTCMER_NORMAL              = 0x00000000,
    RTCMER_HOLD                = 0x00000001,
    RTCMER_TIMEOUT             = 0x00000002,
    RTCMER_BAD_DEVICE          = 0x00000003,
    RTCMER_NO_PORT             = 0x00000004,
    RTCMER_PORT_MAPPING_FAILED = 0x00000005,
    RTCMER_REMOTE_REQUEST      = 0x00000006,
}

alias RTC_MESSAGING_EVENT_TYPE = int;
enum : int
{
    RTCMSET_MESSAGE = 0x00000000,
    RTCMSET_STATUS  = 0x00000001,
}

alias RTC_MESSAGING_USER_STATUS = int;
enum : int
{
    RTCMUS_IDLE   = 0x00000000,
    RTCMUS_TYPING = 0x00000001,
}

alias RTC_DTMF = int;
enum : int
{
    RTC_DTMF_0     = 0x00000000,
    RTC_DTMF_1     = 0x00000001,
    RTC_DTMF_2     = 0x00000002,
    RTC_DTMF_3     = 0x00000003,
    RTC_DTMF_4     = 0x00000004,
    RTC_DTMF_5     = 0x00000005,
    RTC_DTMF_6     = 0x00000006,
    RTC_DTMF_7     = 0x00000007,
    RTC_DTMF_8     = 0x00000008,
    RTC_DTMF_9     = 0x00000009,
    RTC_DTMF_STAR  = 0x0000000a,
    RTC_DTMF_POUND = 0x0000000b,
    RTC_DTMF_A     = 0x0000000c,
    RTC_DTMF_B     = 0x0000000d,
    RTC_DTMF_C     = 0x0000000e,
    RTC_DTMF_D     = 0x0000000f,
    RTC_DTMF_FLASH = 0x00000010,
}

alias RTC_PROVIDER_URI = int;
enum : int
{
    RTCPU_URIHOMEPAGE          = 0x00000000,
    RTCPU_URIHELPDESK          = 0x00000001,
    RTCPU_URIPERSONALACCOUNT   = 0x00000002,
    RTCPU_URIDISPLAYDURINGCALL = 0x00000003,
    RTCPU_URIDISPLAYDURINGIDLE = 0x00000004,
}

alias RTC_RING_TYPE = int;
enum : int
{
    RTCRT_PHONE    = 0x00000000,
    RTCRT_MESSAGE  = 0x00000001,
    RTCRT_RINGBACK = 0x00000002,
}

alias RTC_T120_APPLET = int;
enum : int
{
    RTCTA_WHITEBOARD = 0x00000000,
    RTCTA_APPSHARING = 0x00000001,
}

alias RTC_PORT_TYPE = int;
enum : int
{
    RTCPT_AUDIO_RTP  = 0x00000000,
    RTCPT_AUDIO_RTCP = 0x00000001,
    RTCPT_VIDEO_RTP  = 0x00000002,
    RTCPT_VIDEO_RTCP = 0x00000003,
    RTCPT_SIP        = 0x00000004,
}

alias RTC_USER_SEARCH_COLUMN = int;
enum : int
{
    RTCUSC_URI         = 0x00000000,
    RTCUSC_DISPLAYNAME = 0x00000001,
    RTCUSC_TITLE       = 0x00000002,
    RTCUSC_OFFICE      = 0x00000003,
    RTCUSC_PHONE       = 0x00000004,
    RTCUSC_COMPANY     = 0x00000005,
    RTCUSC_CITY        = 0x00000006,
    RTCUSC_STATE       = 0x00000007,
    RTCUSC_COUNTRY     = 0x00000008,
    RTCUSC_EMAIL       = 0x00000009,
}

alias RTC_USER_SEARCH_PREFERENCE = int;
enum : int
{
    RTCUSP_MAX_MATCHES = 0x00000000,
    RTCUSP_TIME_LIMIT  = 0x00000001,
}

alias RTC_ROAMING_EVENT_TYPE = int;
enum : int
{
    RTCRET_BUDDY_ROAMING    = 0x00000000,
    RTCRET_WATCHER_ROAMING  = 0x00000001,
    RTCRET_PRESENCE_ROAMING = 0x00000002,
    RTCRET_PROFILE_ROAMING  = 0x00000003,
    RTCRET_WPENDING_ROAMING = 0x00000004,
}

alias RTC_PROFILE_EVENT_TYPE = int;
enum : int
{
    RTCPFET_PROFILE_GET    = 0x00000000,
    RTCPFET_PROFILE_UPDATE = 0x00000001,
}

alias RTC_ANSWER_MODE = int;
enum : int
{
    RTCAM_OFFER_SESSION_EVENT  = 0x00000000,
    RTCAM_AUTOMATICALLY_ACCEPT = 0x00000001,
    RTCAM_AUTOMATICALLY_REJECT = 0x00000002,
    RTCAM_NOT_SUPPORTED        = 0x00000003,
}

alias RTC_SESSION_REFER_STATUS = int;
enum : int
{
    RTCSRS_REFERRING = 0x00000000,
    RTCSRS_ACCEPTED  = 0x00000001,
    RTCSRS_ERROR     = 0x00000002,
    RTCSRS_REJECTED  = 0x00000003,
    RTCSRS_DROPPED   = 0x00000004,
    RTCSRS_DONE      = 0x00000005,
}

alias RTC_PRESENCE_PROPERTY = int;
enum : int
{
    RTCPP_PHONENUMBER = 0x00000000,
    RTCPP_DISPLAYNAME = 0x00000001,
    RTCPP_EMAIL       = 0x00000002,
    RTCPP_DEVICE_NAME = 0x00000003,
    RTCPP_MULTIPLE    = 0x00000004,
}

alias RTC_SECURITY_TYPE = int;
enum : int
{
    RTCSECT_AUDIO_VIDEO_MEDIA_ENCRYPTION = 0x00000000,
    RTCSECT_T120_MEDIA_ENCRYPTION        = 0x00000001,
}

alias RTC_SECURITY_LEVEL = int;
enum : int
{
    RTCSECL_UNSUPPORTED = 0x00000001,
    RTCSECL_SUPPORTED   = 0x00000002,
    RTCSECL_REQUIRED    = 0x00000003,
}

alias RTC_REINVITE_STATE = int;
enum : int
{
    RTCRIN_INCOMING  = 0x00000000,
    RTCRIN_SUCCEEDED = 0x00000001,
    RTCRIN_FAIL      = 0x00000002,
}

// Constants


enum uint RTCCS_FORCE_PROFILE = 0x00000001U;
enum uint RTCCS_FAIL_ON_REDIRECT = 0x00000002U;

enum : uint
{
    RTCMT_AUDIO_SEND    = 0x00000001U,
    RTCMT_AUDIO_RECEIVE = 0x00000002U,
}

enum : uint
{
    RTCMT_VIDEO_SEND    = 0x00000004U,
    RTCMT_VIDEO_RECEIVE = 0x00000008U,
}

enum uint RTCMT_T120_SENDRECV = 0x00000010U;

enum : uint
{
    RTCSI_PC_TO_PC       = 0x00000001U,
    RTCSI_PC_TO_PHONE    = 0x00000002U,
    RTCSI_PHONE_TO_PHONE = 0x00000004U,
}

enum : uint
{
    RTCSI_IM            = 0x00000008U,
    RTCSI_MULTIPARTY_IM = 0x00000010U,
}

enum uint RTCSI_APPLICATION = 0x00000020U;

enum : uint
{
    RTCTR_UDP = 0x00000001U,
    RTCTR_TCP = 0x00000002U,
    RTCTR_TLS = 0x00000004U,
}

enum : uint
{
    RTCAU_BASIC          = 0x00000001U,
    RTCAU_DIGEST         = 0x00000002U,
    RTCAU_NTLM           = 0x00000004U,
    RTCAU_KERBEROS       = 0x00000008U,
    RTCAU_USE_LOGON_CRED = 0x00010000U,
}

enum : uint
{
    RTCRF_REGISTER_INVITE_SESSIONS  = 0x00000001U,
    RTCRF_REGISTER_MESSAGE_SESSIONS = 0x00000002U,
    RTCRF_REGISTER_PRESENCE         = 0x00000004U,
    RTCRF_REGISTER_NOTIFY           = 0x00000008U,
    RTCRF_REGISTER_ALL              = 0x0000000fU,
}

enum uint RTCRMF_BUDDY_ROAMING = 0x00000001U;
enum uint RTCRMF_WATCHER_ROAMING = 0x00000002U;
enum uint RTCRMF_PRESENCE_ROAMING = 0x00000004U;
enum uint RTCRMF_PROFILE_ROAMING = 0x00000008U;
enum uint RTCRMF_ALL_ROAMING = 0x0000000fU;

enum : uint
{
    RTCEF_CLIENT                    = 0x00000001U,
    RTCEF_REGISTRATION_STATE_CHANGE = 0x00000002U,
}

enum : uint
{
    RTCEF_SESSION_STATE_CHANGE       = 0x00000004U,
    RTCEF_SESSION_OPERATION_COMPLETE = 0x00000008U,
}

enum uint RTCEF_PARTICIPANT_STATE_CHANGE = 0x00000010U;

enum : uint
{
    RTCEF_MEDIA     = 0x00000020U,
    RTCEF_INTENSITY = 0x00000040U,
}

enum uint RTCEF_MESSAGING = 0x00000080U;

enum : uint
{
    RTCEF_BUDDY      = 0x00000100U,
    RTCEF_WATCHER    = 0x00000200U,
    RTCEF_PROFILE    = 0x00000400U,
    RTCEF_USERSEARCH = 0x00000800U,
}

enum : uint
{
    RTCEF_INFO          = 0x00001000U,
    RTCEF_GROUP         = 0x00002000U,
    RTCEF_MEDIA_REQUEST = 0x00004000U,
}

enum : uint
{
    RTCEF_ROAMING           = 0x00010000U,
    RTCEF_PRESENCE_PROPERTY = 0x00020000U,
}

enum : uint
{
    RTCEF_BUDDY2               = 0x00040000U,
    RTCEF_WATCHER2             = 0x00080000U,
    RTCEF_SESSION_REFER_STATUS = 0x00100000U,
    RTCEF_SESSION_REFERRED     = 0x00200000U,
}

enum : uint
{
    RTCEF_REINVITE        = 0x00400000U,
    RTCEF_PRESENCE_DATA   = 0x00800000U,
    RTCEF_PRESENCE_STATUS = 0x01000000U,
}

enum uint RTCEF_ALL = 0x01ffffffU;

enum : uint
{
    RTCIF_DISABLE_MEDIA = 0x00000001U,
    RTCIF_DISABLE_UPNP  = 0x00000002U,
}

enum uint RTCIF_ENABLE_SERVER_CLASS = 0x00000004U;
enum uint RTCIF_DISABLE_STRICT_DNS = 0x00000008U;

enum : uint
{
    FACILITY_RTC_INTERFACE   = 0x000000eeU,
    FACILITY_SIP_STATUS_CODE = 0x000000efU,
}

enum uint FACILITY_PINT_STATUS_CODE = 0x000000f0U;
enum uint STATUS_SEVERITY_RTC_ERROR = 0x00000002U;
enum HRESULT RTC_E_SIP_CODECS_DO_NOT_MATCH = HRESULT(0x80ee0000);

enum : HRESULT
{
    RTC_E_SIP_STREAM_PRESENT     = HRESULT(0x80ee0001),
    RTC_E_SIP_STREAM_NOT_PRESENT = HRESULT(0x80ee0002),
}

enum : HRESULT
{
    RTC_E_SIP_NO_STREAM          = HRESULT(0x80ee0003),
    RTC_E_SIP_PARSE_FAILED       = HRESULT(0x80ee0004),
    RTC_E_SIP_HEADER_NOT_PRESENT = HRESULT(0x80ee0005),
}

enum : HRESULT
{
    RTC_E_SDP_NOT_PRESENT     = HRESULT(0x80ee0006),
    RTC_E_SDP_PARSE_FAILED    = HRESULT(0x80ee0007),
    RTC_E_SDP_UPDATE_FAILED   = HRESULT(0x80ee0008),
    RTC_E_SDP_MULTICAST       = HRESULT(0x80ee0009),
    RTC_E_SDP_CONNECTION_ADDR = HRESULT(0x80ee000a),
}

enum HRESULT RTC_E_SDP_NO_MEDIA = HRESULT(0x80ee000b);

enum : HRESULT
{
    RTC_E_SIP_TIMEOUT         = HRESULT(0x80ee000c),
    RTC_E_SDP_FAILED_TO_BUILD = HRESULT(0x80ee000d),
}

enum HRESULT RTC_E_SIP_INVITE_TRANSACTION_PENDING = HRESULT(0x80ee000e);

enum : HRESULT
{
    RTC_E_SIP_AUTH_HEADER_SENT        = HRESULT(0x80ee000f),
    RTC_E_SIP_AUTH_TYPE_NOT_SUPPORTED = HRESULT(0x80ee0010),
    RTC_E_SIP_AUTH_FAILED             = HRESULT(0x80ee0011),
}

enum HRESULT RTC_E_INVALID_SIP_URL = HRESULT(0x80ee0012);
enum HRESULT RTC_E_DESTINATION_ADDRESS_LOCAL = HRESULT(0x80ee0013);
enum HRESULT RTC_E_INVALID_ADDRESS_LOCAL = HRESULT(0x80ee0014);
enum HRESULT RTC_E_DESTINATION_ADDRESS_MULTICAST = HRESULT(0x80ee0015);
enum HRESULT RTC_E_INVALID_PROXY_ADDRESS = HRESULT(0x80ee0016);
enum HRESULT RTC_E_SIP_TRANSPORT_NOT_SUPPORTED = HRESULT(0x80ee0017);

enum : HRESULT
{
    RTC_E_SIP_NEED_MORE_DATA    = HRESULT(0x80ee0018),
    RTC_E_SIP_CALL_DISCONNECTED = HRESULT(0x80ee0019),
}

enum HRESULT RTC_E_SIP_REQUEST_DESTINATION_ADDR_NOT_PRESENT = HRESULT(0x80ee001a);
enum HRESULT RTC_E_SIP_UDP_SIZE_EXCEEDED = HRESULT(0x80ee001b);

enum : HRESULT
{
    RTC_E_SIP_SSL_TUNNEL_FAILED       = HRESULT(0x80ee001c),
    RTC_E_SIP_SSL_NEGOTIATION_TIMEOUT = HRESULT(0x80ee001d),
}

enum HRESULT RTC_E_SIP_STACK_SHUTDOWN = HRESULT(0x80ee001e);

enum : HRESULT
{
    RTC_E_MEDIA_CONTROLLER_STATE           = HRESULT(0x80ee001f),
    RTC_E_MEDIA_NEED_TERMINAL              = HRESULT(0x80ee0020),
    RTC_E_MEDIA_AUDIO_DEVICE_NOT_AVAILABLE = HRESULT(0x80ee0021),
}

enum HRESULT RTC_E_MEDIA_VIDEO_DEVICE_NOT_AVAILABLE = HRESULT(0x80ee0022);
enum HRESULT RTC_E_START_STREAM = HRESULT(0x80ee0023);
enum HRESULT RTC_E_MEDIA_AEC = HRESULT(0x80ee0024);

enum : HRESULT
{
    RTC_E_CLIENT_NOT_INITIALIZED     = HRESULT(0x80ee0025),
    RTC_E_CLIENT_ALREADY_INITIALIZED = HRESULT(0x80ee0026),
    RTC_E_CLIENT_ALREADY_SHUT_DOWN   = HRESULT(0x80ee0027),
}

enum HRESULT RTC_E_PRESENCE_NOT_ENABLED = HRESULT(0x80ee0028);

enum : HRESULT
{
    RTC_E_INVALID_SESSION_TYPE  = HRESULT(0x80ee0029),
    RTC_E_INVALID_SESSION_STATE = HRESULT(0x80ee002a),
}

enum HRESULT RTC_E_NO_PROFILE = HRESULT(0x80ee002b);
enum HRESULT RTC_E_LOCAL_PHONE_NEEDED = HRESULT(0x80ee002c);
enum HRESULT RTC_E_NO_DEVICE = HRESULT(0x80ee002d);
enum HRESULT RTC_E_INVALID_PROFILE = HRESULT(0x80ee002e);

enum : HRESULT
{
    RTC_E_PROFILE_NO_PROVISION              = HRESULT(0x80ee002f),
    RTC_E_PROFILE_NO_KEY                    = HRESULT(0x80ee0030),
    RTC_E_PROFILE_NO_NAME                   = HRESULT(0x80ee0031),
    RTC_E_PROFILE_NO_USER                   = HRESULT(0x80ee0032),
    RTC_E_PROFILE_NO_USER_URI               = HRESULT(0x80ee0033),
    RTC_E_PROFILE_NO_SERVER                 = HRESULT(0x80ee0034),
    RTC_E_PROFILE_NO_SERVER_ADDRESS         = HRESULT(0x80ee0035),
    RTC_E_PROFILE_NO_SERVER_PROTOCOL        = HRESULT(0x80ee0036),
    RTC_E_PROFILE_INVALID_SERVER_PROTOCOL   = HRESULT(0x80ee0037),
    RTC_E_PROFILE_INVALID_SERVER_AUTHMETHOD = HRESULT(0x80ee0038),
    RTC_E_PROFILE_INVALID_SERVER_ROLE       = HRESULT(0x80ee0039),
    RTC_E_PROFILE_MULTIPLE_REGISTRARS       = HRESULT(0x80ee003a),
    RTC_E_PROFILE_INVALID_SESSION           = HRESULT(0x80ee003b),
    RTC_E_PROFILE_INVALID_SESSION_PARTY     = HRESULT(0x80ee003c),
    RTC_E_PROFILE_INVALID_SESSION_TYPE      = HRESULT(0x80ee003d),
}

enum HRESULT RTC_E_OPERATION_WITH_TOO_MANY_PARTICIPANTS = HRESULT(0x80ee003e);
enum HRESULT RTC_E_BASIC_AUTH_SET_TLS = HRESULT(0x80ee003f);
enum HRESULT RTC_E_SIP_HIGH_SECURITY_SET_TLS = HRESULT(0x80ee0040);
enum HRESULT RTC_S_ROAMING_NOT_SUPPORTED = HRESULT(0x00ee0041);
enum HRESULT RTC_E_PROFILE_SERVER_UNAUTHORIZED = HRESULT(0x80ee0042);
enum HRESULT RTC_E_DUPLICATE_REALM = HRESULT(0x80ee0043);
enum HRESULT RTC_E_POLICY_NOT_ALLOW = HRESULT(0x80ee0044);

enum : HRESULT
{
    RTC_E_PORT_MAPPING_UNAVAILABLE = HRESULT(0x80ee0045),
    RTC_E_PORT_MAPPING_FAILED      = HRESULT(0x80ee0046),
}

enum : HRESULT
{
    RTC_E_SECURITY_LEVEL_NOT_COMPATIBLE               = HRESULT(0x80ee0047),
    RTC_E_SECURITY_LEVEL_NOT_DEFINED                  = HRESULT(0x80ee0048),
    RTC_E_SECURITY_LEVEL_NOT_SUPPORTED_BY_PARTICIPANT = HRESULT(0x80ee0049),
}

enum : HRESULT
{
    RTC_E_DUPLICATE_BUDDY   = HRESULT(0x80ee004a),
    RTC_E_DUPLICATE_WATCHER = HRESULT(0x80ee004b),
}

enum HRESULT RTC_E_MALFORMED_XML = HRESULT(0x80ee004c);
enum HRESULT RTC_E_ROAMING_OPERATION_INTERRUPTED = HRESULT(0x80ee004d);
enum HRESULT RTC_E_ROAMING_FAILED = HRESULT(0x80ee004e);

enum : HRESULT
{
    RTC_E_INVALID_BUDDY_LIST = HRESULT(0x80ee004f),
    RTC_E_INVALID_ACL_LIST   = HRESULT(0x80ee0050),
}

enum : HRESULT
{
    RTC_E_NO_GROUP        = HRESULT(0x80ee0051),
    RTC_E_DUPLICATE_GROUP = HRESULT(0x80ee0052),
}

enum HRESULT RTC_E_TOO_MANY_GROUPS = HRESULT(0x80ee0053);

enum : HRESULT
{
    RTC_E_NO_BUDDY     = HRESULT(0x80ee0054),
    RTC_E_NO_WATCHER   = HRESULT(0x80ee0055),
    RTC_E_NO_REALM     = HRESULT(0x80ee0056),
    RTC_E_NO_TRANSPORT = HRESULT(0x80ee0057),
    RTC_E_NOT_EXIST    = HRESULT(0x80ee0058),
}

enum HRESULT RTC_E_INVALID_PREFERENCE_LIST = HRESULT(0x80ee0059);
enum HRESULT RTC_E_MAX_PENDING_OPERATIONS = HRESULT(0x80ee005a);
enum HRESULT RTC_E_TOO_MANY_RETRIES = HRESULT(0x80ee005b);
enum HRESULT RTC_E_INVALID_PORTRANGE = HRESULT(0x80ee005c);
enum HRESULT RTC_E_SIP_CALL_CONNECTION_NOT_ESTABLISHED = HRESULT(0x80ee005d);
enum HRESULT RTC_E_SIP_ADDITIONAL_PARTY_IN_TWO_PARTY_SESSION = HRESULT(0x80ee005e);
enum HRESULT RTC_E_SIP_PARTY_ALREADY_IN_SESSION = HRESULT(0x80ee005f);
enum HRESULT RTC_E_SIP_OTHER_PARTY_JOIN_IN_PROGRESS = HRESULT(0x80ee0060);
enum HRESULT RTC_E_INVALID_OBJECT_STATE = HRESULT(0x80ee0061);
enum HRESULT RTC_E_PRESENCE_ENABLED = HRESULT(0x80ee0062);
enum HRESULT RTC_E_ROAMING_ENABLED = HRESULT(0x80ee0063);
enum HRESULT RTC_E_SIP_TLS_INCOMPATIBLE_ENCRYPTION = HRESULT(0x80ee0064);
enum HRESULT RTC_E_SIP_INVALID_CERTIFICATE = HRESULT(0x80ee0065);

enum : HRESULT
{
    RTC_E_SIP_DNS_FAIL = HRESULT(0x80ee0066),
    RTC_E_SIP_TCP_FAIL = HRESULT(0x80ee0067),
}

enum HRESULT RTC_E_TOO_SMALL_EXPIRES_VALUE = HRESULT(0x80ee0068);
enum HRESULT RTC_E_SIP_TLS_FAIL = HRESULT(0x80ee0069);
enum HRESULT RTC_E_NOT_PRESENCE_PROFILE = HRESULT(0x80ee006a);
enum HRESULT RTC_E_SIP_INVITEE_PARTY_TIMEOUT = HRESULT(0x80ee006b);
enum HRESULT RTC_E_SIP_AUTH_TIME_SKEW = HRESULT(0x80ee006c);
enum HRESULT RTC_E_INVALID_REGISTRATION_STATE = HRESULT(0x80ee006d);

enum : HRESULT
{
    RTC_E_MEDIA_DISABLED = HRESULT(0x80ee006e),
    RTC_E_MEDIA_ENABLED  = HRESULT(0x80ee006f),
}

enum : HRESULT
{
    RTC_E_REFER_NOT_ACCEPTED = HRESULT(0x80ee0070),
    RTC_E_REFER_NOT_ALLOWED  = HRESULT(0x80ee0071),
    RTC_E_REFER_NOT_EXIST    = HRESULT(0x80ee0072),
}

enum HRESULT RTC_E_SIP_HOLD_OPERATION_PENDING = HRESULT(0x80ee0073);
enum HRESULT RTC_E_SIP_UNHOLD_OPERATION_PENDING = HRESULT(0x80ee0074);

enum : HRESULT
{
    RTC_E_MEDIA_SESSION_NOT_EXIST = HRESULT(0x80ee0075),
    RTC_E_MEDIA_SESSION_IN_HOLD   = HRESULT(0x80ee0076),
}

enum HRESULT RTC_E_ANOTHER_MEDIA_SESSION_ACTIVE = HRESULT(0x80ee0077);
enum HRESULT RTC_E_MAX_REDIRECTS = HRESULT(0x80ee0078);
enum HRESULT RTC_E_REDIRECT_PROCESSING_FAILED = HRESULT(0x80ee0079);
enum HRESULT RTC_E_LISTENING_SOCKET_NOT_EXIST = HRESULT(0x80ee007a);
enum HRESULT RTC_E_INVALID_LISTEN_SOCKET = HRESULT(0x80ee007b);
enum HRESULT RTC_E_PORT_MANAGER_ALREADY_SET = HRESULT(0x80ee007c);
enum HRESULT RTC_E_SECURITY_LEVEL_ALREADY_SET = HRESULT(0x80ee007d);
enum HRESULT RTC_E_UDP_NOT_SUPPORTED = HRESULT(0x80ee007e);
enum HRESULT RTC_E_SIP_REFER_OPERATION_PENDING = HRESULT(0x80ee007f);
enum HRESULT RTC_E_PLATFORM_NOT_SUPPORTED = HRESULT(0x80ee0080);
enum HRESULT RTC_E_SIP_PEER_PARTICIPANT_IN_MULTIPARTY_SESSION = HRESULT(0x80ee0081);
enum HRESULT RTC_E_NOT_ALLOWED = HRESULT(0x80ee0082);

enum : HRESULT
{
    RTC_E_REGISTRATION_DEACTIVATED  = HRESULT(0x80ee0083),
    RTC_E_REGISTRATION_REJECTED     = HRESULT(0x80ee0084),
    RTC_E_REGISTRATION_UNREGISTERED = HRESULT(0x80ee0085),
}

enum : HRESULT
{
    RTC_E_STATUS_INFO_TRYING                  = HRESULT(0x00ef0064),
    RTC_E_STATUS_INFO_RINGING                 = HRESULT(0x00ef00b4),
    RTC_E_STATUS_INFO_CALL_FORWARDING         = HRESULT(0x00ef00b5),
    RTC_E_STATUS_INFO_QUEUED                  = HRESULT(0x00ef00b6),
    RTC_E_STATUS_SESSION_PROGRESS             = HRESULT(0x00ef00b7),
    RTC_E_STATUS_SUCCESS                      = HRESULT(0x00ef00c8),
    RTC_E_STATUS_REDIRECT_MULTIPLE_CHOICES    = HRESULT(0x80ef012c),
    RTC_E_STATUS_REDIRECT_MOVED_PERMANENTLY   = HRESULT(0x80ef012d),
    RTC_E_STATUS_REDIRECT_MOVED_TEMPORARILY   = HRESULT(0x80ef012e),
    RTC_E_STATUS_REDIRECT_SEE_OTHER           = HRESULT(0x80ef012f),
    RTC_E_STATUS_REDIRECT_USE_PROXY           = HRESULT(0x80ef0131),
    RTC_E_STATUS_REDIRECT_ALTERNATIVE_SERVICE = HRESULT(0x80ef017c),
}

enum : HRESULT
{
    RTC_E_STATUS_CLIENT_BAD_REQUEST                   = HRESULT(0x80ef0190),
    RTC_E_STATUS_CLIENT_UNAUTHORIZED                  = HRESULT(0x80ef0191),
    RTC_E_STATUS_CLIENT_PAYMENT_REQUIRED              = HRESULT(0x80ef0192),
    RTC_E_STATUS_CLIENT_FORBIDDEN                     = HRESULT(0x80ef0193),
    RTC_E_STATUS_CLIENT_NOT_FOUND                     = HRESULT(0x80ef0194),
    RTC_E_STATUS_CLIENT_METHOD_NOT_ALLOWED            = HRESULT(0x80ef0195),
    RTC_E_STATUS_CLIENT_NOT_ACCEPTABLE                = HRESULT(0x80ef0196),
    RTC_E_STATUS_CLIENT_PROXY_AUTHENTICATION_REQUIRED = HRESULT(0x80ef0197),
    RTC_E_STATUS_CLIENT_REQUEST_TIMEOUT               = HRESULT(0x80ef0198),
    RTC_E_STATUS_CLIENT_CONFLICT                      = HRESULT(0x80ef0199),
    RTC_E_STATUS_CLIENT_GONE                          = HRESULT(0x80ef019a),
    RTC_E_STATUS_CLIENT_LENGTH_REQUIRED               = HRESULT(0x80ef019b),
    RTC_E_STATUS_CLIENT_REQUEST_ENTITY_TOO_LARGE      = HRESULT(0x80ef019d),
    RTC_E_STATUS_CLIENT_REQUEST_URI_TOO_LARGE         = HRESULT(0x80ef019e),
    RTC_E_STATUS_CLIENT_UNSUPPORTED_MEDIA_TYPE        = HRESULT(0x80ef019f),
    RTC_E_STATUS_CLIENT_BAD_EXTENSION                 = HRESULT(0x80ef01a4),
    RTC_E_STATUS_CLIENT_TEMPORARILY_NOT_AVAILABLE     = HRESULT(0x80ef01e0),
    RTC_E_STATUS_CLIENT_TRANSACTION_DOES_NOT_EXIST    = HRESULT(0x80ef01e1),
    RTC_E_STATUS_CLIENT_LOOP_DETECTED                 = HRESULT(0x80ef01e2),
    RTC_E_STATUS_CLIENT_TOO_MANY_HOPS                 = HRESULT(0x80ef01e3),
    RTC_E_STATUS_CLIENT_ADDRESS_INCOMPLETE            = HRESULT(0x80ef01e4),
    RTC_E_STATUS_CLIENT_AMBIGUOUS                     = HRESULT(0x80ef01e5),
    RTC_E_STATUS_CLIENT_BUSY_HERE                     = HRESULT(0x80ef01e6),
    RTC_E_STATUS_REQUEST_TERMINATED                   = HRESULT(0x80ef01e7),
    RTC_E_STATUS_NOT_ACCEPTABLE_HERE                  = HRESULT(0x80ef01e8),
    RTC_E_STATUS_SERVER_INTERNAL_ERROR                = HRESULT(0x80ef01f4),
    RTC_E_STATUS_SERVER_NOT_IMPLEMENTED               = HRESULT(0x80ef01f5),
    RTC_E_STATUS_SERVER_BAD_GATEWAY                   = HRESULT(0x80ef01f6),
    RTC_E_STATUS_SERVER_SERVICE_UNAVAILABLE           = HRESULT(0x80ef01f7),
    RTC_E_STATUS_SERVER_SERVER_TIMEOUT                = HRESULT(0x80ef01f8),
    RTC_E_STATUS_SERVER_VERSION_NOT_SUPPORTED         = HRESULT(0x80ef01f9),
}

enum : HRESULT
{
    RTC_E_STATUS_GLOBAL_BUSY_EVERYWHERE         = HRESULT(0x80ef0258),
    RTC_E_STATUS_GLOBAL_DECLINE                 = HRESULT(0x80ef025b),
    RTC_E_STATUS_GLOBAL_DOES_NOT_EXIST_ANYWHERE = HRESULT(0x80ef025c),
    RTC_E_STATUS_GLOBAL_NOT_ACCEPTABLE          = HRESULT(0x80ef025e),
}

enum : HRESULT
{
    RTC_E_PINT_STATUS_REJECTED_BUSY      = HRESULT(0x80f00005),
    RTC_E_PINT_STATUS_REJECTED_NO_ANSWER = HRESULT(0x80f00006),
    RTC_E_PINT_STATUS_REJECTED_ALL_BUSY  = HRESULT(0x80f00007),
    RTC_E_PINT_STATUS_REJECTED_PL_FAILED = HRESULT(0x80f00008),
    RTC_E_PINT_STATUS_REJECTED_SW_FAILED = HRESULT(0x80f00009),
    RTC_E_PINT_STATUS_REJECTED_CANCELLED = HRESULT(0x80f0000a),
    RTC_E_PINT_STATUS_REJECTED_BADNUMBER = HRESULT(0x80f0000b),
}

// Structs


struct TRANSPORT_SETTING
{
    TRANSPORT_SETTING_ID SettingId;
    uint*                Length;
    ubyte*               Value;
}

// Interfaces

@GUID("7a42ea29-a2b7-40c4-b091-f6f024aa89be")
struct RTCClient;

@GUID("07829e45-9a34-408e-a011-bddf13487cd1")
interface IRTCClient : IUnknown
{
    HRESULT Initialize();
    HRESULT Shutdown();
    HRESULT PrepareForShutdown();
    HRESULT put_EventFilter(int lFilter);
    HRESULT get_EventFilter(int* plFilter);
    HRESULT SetPreferredMediaTypes(int lMediaTypes, VARIANT_BOOL fPersistent);
    HRESULT get_PreferredMediaTypes(int* plMediaTypes);
    HRESULT get_MediaCapabilities(int* plMediaTypes);
    HRESULT CreateSession(RTC_SESSION_TYPE enType, BSTR bstrLocalPhoneURI, IRTCProfile pProfile, int lFlags, 
                          IRTCSession* ppSession);
    HRESULT put_ListenForIncomingSessions(RTC_LISTEN_MODE enListen);
    HRESULT get_ListenForIncomingSessions(RTC_LISTEN_MODE* penListen);
    HRESULT get_NetworkAddresses(VARIANT_BOOL fTCP, VARIANT_BOOL fExternal, VARIANT* pvAddresses);
    HRESULT put_Volume(RTC_AUDIO_DEVICE enDevice, int lVolume);
    HRESULT get_Volume(RTC_AUDIO_DEVICE enDevice, int* plVolume);
    HRESULT put_AudioMuted(RTC_AUDIO_DEVICE enDevice, VARIANT_BOOL fMuted);
    HRESULT get_AudioMuted(RTC_AUDIO_DEVICE enDevice, VARIANT_BOOL* pfMuted);
    HRESULT get_IVideoWindow(RTC_VIDEO_DEVICE enDevice, IVideoWindow* ppIVideoWindow);
    HRESULT put_PreferredAudioDevice(RTC_AUDIO_DEVICE enDevice, BSTR bstrDeviceName);
    HRESULT get_PreferredAudioDevice(RTC_AUDIO_DEVICE enDevice, BSTR* pbstrDeviceName);
    HRESULT put_PreferredVolume(RTC_AUDIO_DEVICE enDevice, int lVolume);
    HRESULT get_PreferredVolume(RTC_AUDIO_DEVICE enDevice, int* plVolume);
    HRESULT put_PreferredAEC(VARIANT_BOOL bEnable);
    HRESULT get_PreferredAEC(VARIANT_BOOL* pbEnabled);
    HRESULT put_PreferredVideoDevice(BSTR bstrDeviceName);
    HRESULT get_PreferredVideoDevice(BSTR* pbstrDeviceName);
    HRESULT get_ActiveMedia(int* plMediaType);
    HRESULT put_MaxBitrate(int lMaxBitrate);
    HRESULT get_MaxBitrate(int* plMaxBitrate);
    HRESULT put_TemporalSpatialTradeOff(int lValue);
    HRESULT get_TemporalSpatialTradeOff(int* plValue);
    HRESULT get_NetworkQuality(int* plNetworkQuality);
    HRESULT StartT120Applet(RTC_T120_APPLET enApplet);
    HRESULT StopT120Applets();
    HRESULT get_IsT120AppletRunning(RTC_T120_APPLET enApplet, VARIANT_BOOL* pfRunning);
    HRESULT get_LocalUserURI(BSTR* pbstrUserURI);
    HRESULT put_LocalUserURI(BSTR bstrUserURI);
    HRESULT get_LocalUserName(BSTR* pbstrUserName);
    HRESULT put_LocalUserName(BSTR bstrUserName);
    HRESULT PlayRing(RTC_RING_TYPE enType, VARIANT_BOOL bPlay);
    HRESULT SendDTMF(RTC_DTMF enDTMF);
    HRESULT InvokeTuningWizard(ptrdiff_t hwndParent);
    HRESULT get_IsTuned(VARIANT_BOOL* pfTuned);
}

@GUID("0c91d71d-1064-42da-bfa5-572beb8eea84")
interface IRTCClient2 : IRTCClient
{
    HRESULT put_AnswerMode(RTC_SESSION_TYPE enType, RTC_ANSWER_MODE enMode);
    HRESULT get_AnswerMode(RTC_SESSION_TYPE enType, RTC_ANSWER_MODE* penMode);
    HRESULT InvokeTuningWizardEx(ptrdiff_t hwndParent, VARIANT_BOOL fAllowAudio, VARIANT_BOOL fAllowVideo);
    HRESULT get_Version(int* plVersion);
    HRESULT put_ClientName(BSTR bstrClientName);
    HRESULT put_ClientCurVer(BSTR bstrClientCurVer);
    HRESULT InitializeEx(int lFlags);
    HRESULT CreateSessionWithDescription(BSTR bstrContentType, BSTR bstrSessionDescription, IRTCProfile pProfile, 
                                         int lFlags, IRTCSession2* ppSession2);
    HRESULT SetSessionDescriptionManager(IRTCSessionDescriptionManager pSessionDescriptionManager);
    HRESULT put_PreferredSecurityLevel(RTC_SECURITY_TYPE enSecurityType, RTC_SECURITY_LEVEL enSecurityLevel);
    HRESULT get_PreferredSecurityLevel(RTC_SECURITY_TYPE enSecurityType, RTC_SECURITY_LEVEL* penSecurityLevel);
    HRESULT put_AllowedPorts(int lTransport, RTC_LISTEN_MODE enListenMode);
    HRESULT get_AllowedPorts(int lTransport, RTC_LISTEN_MODE* penListenMode);
}

@GUID("11c3cbcc-0744-42d1-968a-51aa1bb274c6")
interface IRTCClientPresence : IUnknown
{
    HRESULT EnablePresence(VARIANT_BOOL fUseStorage, VARIANT varStorage);
    HRESULT Export(VARIANT varStorage);
    HRESULT Import(VARIANT varStorage, VARIANT_BOOL fReplaceAll);
    HRESULT EnumerateBuddies(IRTCEnumBuddies* ppEnum);
    HRESULT get_Buddies(IRTCCollection* ppCollection);
    HRESULT get_Buddy(BSTR bstrPresentityURI, IRTCBuddy* ppBuddy);
    HRESULT AddBuddy(BSTR bstrPresentityURI, BSTR bstrUserName, BSTR bstrData, VARIANT_BOOL fPersistent, 
                     IRTCProfile pProfile, int lFlags, IRTCBuddy* ppBuddy);
    HRESULT RemoveBuddy(IRTCBuddy pBuddy);
    HRESULT EnumerateWatchers(IRTCEnumWatchers* ppEnum);
    HRESULT get_Watchers(IRTCCollection* ppCollection);
    HRESULT get_Watcher(BSTR bstrPresentityURI, IRTCWatcher* ppWatcher);
    HRESULT AddWatcher(BSTR bstrPresentityURI, BSTR bstrUserName, BSTR bstrData, VARIANT_BOOL fBlocked, 
                       VARIANT_BOOL fPersistent, IRTCWatcher* ppWatcher);
    HRESULT RemoveWatcher(IRTCWatcher pWatcher);
    HRESULT SetLocalPresenceInfo(RTC_PRESENCE_STATUS enStatus, BSTR bstrNotes);
    HRESULT get_OfferWatcherMode(RTC_OFFER_WATCHER_MODE* penMode);
    HRESULT put_OfferWatcherMode(RTC_OFFER_WATCHER_MODE enMode);
    HRESULT get_PrivacyMode(RTC_PRIVACY_MODE* penMode);
    HRESULT put_PrivacyMode(RTC_PRIVACY_MODE enMode);
}

@GUID("ad1809e8-62f7-4783-909a-29c9d2cb1d34")
interface IRTCClientPresence2 : IRTCClientPresence
{
    HRESULT EnablePresenceEx(IRTCProfile pProfile, VARIANT varStorage, int lFlags);
    HRESULT DisablePresence();
    HRESULT AddGroup(BSTR bstrGroupName, BSTR bstrData, IRTCProfile pProfile, int lFlags, IRTCBuddyGroup* ppGroup);
    HRESULT RemoveGroup(IRTCBuddyGroup pGroup);
    HRESULT EnumerateGroups(IRTCEnumGroups* ppEnum);
    HRESULT get_Groups(IRTCCollection* ppCollection);
    HRESULT get_Group(BSTR bstrGroupName, IRTCBuddyGroup* ppGroup);
    HRESULT AddWatcherEx(BSTR bstrPresentityURI, BSTR bstrUserName, BSTR bstrData, RTC_WATCHER_STATE enState, 
                         VARIANT_BOOL fPersistent, RTC_ACE_SCOPE enScope, IRTCProfile pProfile, int lFlags, 
                         IRTCWatcher2* ppWatcher);
    HRESULT get_WatcherEx(RTC_WATCHER_MATCH_MODE enMode, BSTR bstrPresentityURI, IRTCWatcher2* ppWatcher);
    HRESULT put_PresenceProperty(RTC_PRESENCE_PROPERTY enProperty, BSTR bstrProperty);
    HRESULT get_PresenceProperty(RTC_PRESENCE_PROPERTY enProperty, BSTR* pbstrProperty);
    HRESULT SetPresenceData(BSTR bstrNamespace, BSTR bstrData);
    HRESULT GetPresenceData(BSTR* pbstrNamespace, BSTR* pbstrData);
    HRESULT GetLocalPresenceInfo(RTC_PRESENCE_STATUS* penStatus, BSTR* pbstrNotes);
    HRESULT AddBuddyEx(BSTR bstrPresentityURI, BSTR bstrUserName, BSTR bstrData, VARIANT_BOOL fPersistent, 
                       RTC_BUDDY_SUBSCRIPTION_TYPE enSubscriptionType, IRTCProfile pProfile, int lFlags, 
                       IRTCBuddy2* ppBuddy);
}

@GUID("b9f5cf06-65b9-4a80-a0e6-73cae3ef3822")
interface IRTCClientProvisioning : IUnknown
{
    HRESULT CreateProfile(BSTR bstrProfileXML, IRTCProfile* ppProfile);
    HRESULT EnableProfile(IRTCProfile pProfile, int lRegisterFlags);
    HRESULT DisableProfile(IRTCProfile pProfile);
    HRESULT EnumerateProfiles(IRTCEnumProfiles* ppEnum);
    HRESULT get_Profiles(IRTCCollection* ppCollection);
    HRESULT GetProfile(BSTR bstrUserAccount, BSTR bstrUserPassword, BSTR bstrUserURI, BSTR bstrServer, 
                       int lTransport, ptrdiff_t lCookie);
    HRESULT get_SessionCapabilities(int* plSupportedSessions);
}

@GUID("a70909b5-f40e-4587-bb75-e6bc0845023e")
interface IRTCClientProvisioning2 : IRTCClientProvisioning
{
    HRESULT EnableProfileEx(IRTCProfile pProfile, int lRegisterFlags, int lRoamingFlags);
}

@GUID("d07eca9e-4062-4dd4-9e7d-722a49ba7303")
interface IRTCProfile : IUnknown
{
    HRESULT get_Key(BSTR* pbstrKey);
    HRESULT get_Name(BSTR* pbstrName);
    HRESULT get_XML(BSTR* pbstrXML);
    HRESULT get_ProviderName(BSTR* pbstrName);
    HRESULT get_ProviderURI(RTC_PROVIDER_URI enURI, BSTR* pbstrURI);
    HRESULT get_ProviderData(BSTR* pbstrData);
    HRESULT get_ClientName(BSTR* pbstrName);
    HRESULT get_ClientBanner(VARIANT_BOOL* pfBanner);
    HRESULT get_ClientMinVer(BSTR* pbstrMinVer);
    HRESULT get_ClientCurVer(BSTR* pbstrCurVer);
    HRESULT get_ClientUpdateURI(BSTR* pbstrUpdateURI);
    HRESULT get_ClientData(BSTR* pbstrData);
    HRESULT get_UserURI(BSTR* pbstrUserURI);
    HRESULT get_UserName(BSTR* pbstrUserName);
    HRESULT get_UserAccount(BSTR* pbstrUserAccount);
    HRESULT SetCredentials(BSTR bstrUserURI, BSTR bstrUserAccount, BSTR bstrPassword);
    HRESULT get_SessionCapabilities(int* plSupportedSessions);
    HRESULT get_State(RTC_REGISTRATION_STATE* penState);
}

@GUID("4b81f84e-bdc7-4184-9154-3cb2dd7917fb")
interface IRTCProfile2 : IRTCProfile
{
    HRESULT get_Realm(BSTR* pbstrRealm);
    HRESULT put_Realm(BSTR bstrRealm);
    HRESULT get_AllowedAuth(int* plAllowedAuth);
    HRESULT put_AllowedAuth(int lAllowedAuth);
}

@GUID("387c8086-99be-42fb-9973-7c0fc0ca9fa8")
interface IRTCSession : IUnknown
{
    HRESULT get_Client(IRTCClient* ppClient);
    HRESULT get_State(RTC_SESSION_STATE* penState);
    HRESULT get_Type(RTC_SESSION_TYPE* penType);
    HRESULT get_Profile(IRTCProfile* ppProfile);
    HRESULT get_Participants(IRTCCollection* ppCollection);
    HRESULT Answer();
    HRESULT Terminate(RTC_TERMINATE_REASON enReason);
    HRESULT Redirect(RTC_SESSION_TYPE enType, BSTR bstrLocalPhoneURI, IRTCProfile pProfile, int lFlags);
    HRESULT AddParticipant(BSTR bstrAddress, BSTR bstrName, IRTCParticipant* ppParticipant);
    HRESULT RemoveParticipant(IRTCParticipant pParticipant);
    HRESULT EnumerateParticipants(IRTCEnumParticipants* ppEnum);
    HRESULT get_CanAddParticipants(VARIANT_BOOL* pfCanAdd);
    HRESULT get_RedirectedUserURI(BSTR* pbstrUserURI);
    HRESULT get_RedirectedUserName(BSTR* pbstrUserName);
    HRESULT NextRedirectedUser();
    HRESULT SendMessage(BSTR bstrMessageHeader, BSTR bstrMessage, ptrdiff_t lCookie);
    HRESULT SendMessageStatus(RTC_MESSAGING_USER_STATUS enUserStatus, ptrdiff_t lCookie);
    HRESULT AddStream(int lMediaType, ptrdiff_t lCookie);
    HRESULT RemoveStream(int lMediaType, ptrdiff_t lCookie);
    HRESULT put_EncryptionKey(int lMediaType, BSTR EncryptionKey);
}

@GUID("17d7cdfc-b007-484c-99d2-86a8a820991d")
interface IRTCSession2 : IRTCSession
{
    HRESULT SendInfo(BSTR bstrInfoHeader, BSTR bstrInfo, ptrdiff_t lCookie);
    HRESULT put_PreferredSecurityLevel(RTC_SECURITY_TYPE enSecurityType, RTC_SECURITY_LEVEL enSecurityLevel);
    HRESULT get_PreferredSecurityLevel(RTC_SECURITY_TYPE enSecurityType, RTC_SECURITY_LEVEL* penSecurityLevel);
    HRESULT IsSecurityEnabled(RTC_SECURITY_TYPE enSecurityType, VARIANT_BOOL* pfSecurityEnabled);
    HRESULT AnswerWithSessionDescription(BSTR bstrContentType, BSTR bstrSessionDescription);
    HRESULT ReInviteWithSessionDescription(BSTR bstrContentType, BSTR bstrSessionDescription, ptrdiff_t lCookie);
}

@GUID("e9a50d94-190b-4f82-9530-3b8ebf60758a")
interface IRTCSessionCallControl : IUnknown
{
    HRESULT Hold(ptrdiff_t lCookie);
    HRESULT UnHold(ptrdiff_t lCookie);
    HRESULT Forward(BSTR bstrForwardToURI);
    HRESULT Refer(BSTR bstrReferToURI, BSTR bstrReferCookie);
    HRESULT put_ReferredByURI(BSTR bstrReferredByURI);
    HRESULT get_ReferredByURI(BSTR* pbstrReferredByURI);
    HRESULT put_ReferCookie(BSTR bstrReferCookie);
    HRESULT get_ReferCookie(BSTR* pbstrReferCookie);
    HRESULT get_IsReferred(VARIANT_BOOL* pfIsReferred);
}

@GUID("ae86add5-26b1-4414-af1d-b94cd938d739")
interface IRTCParticipant : IUnknown
{
    HRESULT get_UserURI(BSTR* pbstrUserURI);
    HRESULT get_Name(BSTR* pbstrName);
    HRESULT get_Removable(VARIANT_BOOL* pfRemovable);
    HRESULT get_State(RTC_PARTICIPANT_STATE* penState);
    HRESULT get_Session(IRTCSession* ppSession);
}

@GUID("79960a6b-0cb1-4dc8-a805-7318e99902e8")
interface IRTCRoamingEvent : IDispatch
{
    HRESULT get_EventType(RTC_ROAMING_EVENT_TYPE* pEventType);
    HRESULT get_Profile(IRTCProfile2* ppProfile);
    HRESULT get_StatusCode(int* plStatusCode);
    HRESULT get_StatusText(BSTR* pbstrStatusText);
}

@GUID("d6d5ab3b-770e-43e8-800a-79b062395fca")
interface IRTCProfileEvent : IDispatch
{
    HRESULT get_Profile(IRTCProfile* ppProfile);
    HRESULT get_Cookie(ptrdiff_t* plCookie);
    HRESULT get_StatusCode(int* plStatusCode);
}

@GUID("62e56edc-03fa-4121-94fb-23493fd0ae64")
interface IRTCProfileEvent2 : IRTCProfileEvent
{
    HRESULT get_EventType(RTC_PROFILE_EVENT_TYPE* pEventType);
}

@GUID("2b493b7a-3cba-4170-9c8b-76a9dacdd644")
interface IRTCClientEvent : IDispatch
{
    HRESULT get_EventType(RTC_CLIENT_EVENT_TYPE* penEventType);
    HRESULT get_Client(IRTCClient* ppClient);
}

@GUID("62d0991b-50ab-4f02-b948-ca94f26f8f95")
interface IRTCRegistrationStateChangeEvent : IDispatch
{
    HRESULT get_Profile(IRTCProfile* ppProfile);
    HRESULT get_State(RTC_REGISTRATION_STATE* penState);
    HRESULT get_StatusCode(int* plStatusCode);
    HRESULT get_StatusText(BSTR* pbstrStatusText);
}

@GUID("b5bad703-5952-48b3-9321-7f4500521506")
interface IRTCSessionStateChangeEvent : IDispatch
{
    HRESULT get_Session(IRTCSession* ppSession);
    HRESULT get_State(RTC_SESSION_STATE* penState);
    HRESULT get_StatusCode(int* plStatusCode);
    HRESULT get_StatusText(BSTR* pbstrStatusText);
}

@GUID("4f933171-6f95-4880-80d9-2ec8d495d261")
interface IRTCSessionStateChangeEvent2 : IRTCSessionStateChangeEvent
{
    HRESULT get_MediaTypes(int* pMediaTypes);
    HRESULT get_RemotePreferredSecurityLevel(RTC_SECURITY_TYPE enSecurityType, 
                                             RTC_SECURITY_LEVEL* penSecurityLevel);
    HRESULT get_IsForked(VARIANT_BOOL* pfIsForked);
    HRESULT GetRemoteSessionDescription(BSTR* pbstrContentType, BSTR* pbstrSessionDescription);
}

@GUID("a6bff4c0-f7c8-4d3c-9a41-3550f78a95b0")
interface IRTCSessionOperationCompleteEvent : IDispatch
{
    HRESULT get_Session(IRTCSession* ppSession);
    HRESULT get_Cookie(ptrdiff_t* plCookie);
    HRESULT get_StatusCode(int* plStatusCode);
    HRESULT get_StatusText(BSTR* pbstrStatusText);
}

@GUID("f6fc2a9b-d5bc-4241-b436-1b8460c13832")
interface IRTCSessionOperationCompleteEvent2 : IRTCSessionOperationCompleteEvent
{
    HRESULT get_Participant(IRTCParticipant* ppParticipant);
    HRESULT GetRemoteSessionDescription(BSTR* pbstrContentType, BSTR* pbstrSessionDescription);
}

@GUID("09bcb597-f0fa-48f9-b420-468cea7fde04")
interface IRTCParticipantStateChangeEvent : IDispatch
{
    HRESULT get_Participant(IRTCParticipant* ppParticipant);
    HRESULT get_State(RTC_PARTICIPANT_STATE* penState);
    HRESULT get_StatusCode(int* plStatusCode);
}

@GUID("099944fb-bcda-453e-8c41-e13da2adf7f3")
interface IRTCMediaEvent : IDispatch
{
    HRESULT get_MediaType(int* pMediaType);
    HRESULT get_EventType(RTC_MEDIA_EVENT_TYPE* penEventType);
    HRESULT get_EventReason(RTC_MEDIA_EVENT_REASON* penEventReason);
}

@GUID("4c23bf51-390c-4992-a41d-41eec05b2a4b")
interface IRTCIntensityEvent : IDispatch
{
    HRESULT get_Level(int* plLevel);
    HRESULT get_Min(int* plMin);
    HRESULT get_Max(int* plMax);
    HRESULT get_Direction(RTC_AUDIO_DEVICE* penDirection);
}

@GUID("d3609541-1b29-4de5-a4ad-5aebaf319512")
interface IRTCMessagingEvent : IDispatch
{
    HRESULT get_Session(IRTCSession* ppSession);
    HRESULT get_Participant(IRTCParticipant* ppParticipant);
    HRESULT get_EventType(RTC_MESSAGING_EVENT_TYPE* penEventType);
    HRESULT get_Message(BSTR* pbstrMessage);
    HRESULT get_MessageHeader(BSTR* pbstrMessageHeader);
    HRESULT get_UserStatus(RTC_MESSAGING_USER_STATUS* penUserStatus);
}

@GUID("f36d755d-17e6-404e-954f-0fc07574c78d")
interface IRTCBuddyEvent : IDispatch
{
    HRESULT get_Buddy(IRTCBuddy* ppBuddy);
}

@GUID("484a7f1e-73f0-4990-bfc2-60bc3978a720")
interface IRTCBuddyEvent2 : IRTCBuddyEvent
{
    HRESULT get_EventType(RTC_BUDDY_EVENT_TYPE* pEventType);
    HRESULT get_StatusCode(int* plStatusCode);
    HRESULT get_StatusText(BSTR* pbstrStatusText);
}

@GUID("f30d7261-587a-424f-822c-312788f43548")
interface IRTCWatcherEvent : IDispatch
{
    HRESULT get_Watcher(IRTCWatcher* ppWatcher);
}

@GUID("e52891e8-188c-49af-b005-98ed13f83f9c")
interface IRTCWatcherEvent2 : IRTCWatcherEvent
{
    HRESULT get_EventType(RTC_WATCHER_EVENT_TYPE* pEventType);
    HRESULT get_StatusCode(int* plStatusCode);
}

@GUID("3a79e1d1-b736-4414-96f8-bbc7f08863e4")
interface IRTCBuddyGroupEvent : IDispatch
{
    HRESULT get_EventType(RTC_GROUP_EVENT_TYPE* pEventType);
    HRESULT get_Group(IRTCBuddyGroup* ppGroup);
    HRESULT get_Buddy(IRTCBuddy2* ppBuddy);
    HRESULT get_StatusCode(int* plStatusCode);
}

@GUID("4e1d68ae-1912-4f49-b2c3-594fadfd425f")
interface IRTCInfoEvent : IDispatch
{
    HRESULT get_Session(IRTCSession2* ppSession);
    HRESULT get_Participant(IRTCParticipant* ppParticipant);
    HRESULT get_Info(BSTR* pbstrInfo);
    HRESULT get_InfoHeader(BSTR* pbstrInfoHeader);
}

@GUID("52572d15-148c-4d97-a36c-2da55c289d63")
interface IRTCMediaRequestEvent : IDispatch
{
    HRESULT get_Session(IRTCSession2* ppSession);
    HRESULT get_ProposedMedia(int* plMediaTypes);
    HRESULT get_CurrentMedia(int* plMediaTypes);
    HRESULT Accept(int lMediaTypes);
    HRESULT get_RemotePreferredSecurityLevel(RTC_SECURITY_TYPE enSecurityType, 
                                             RTC_SECURITY_LEVEL* penSecurityLevel);
    HRESULT Reject();
    HRESULT get_State(RTC_REINVITE_STATE* pState);
}

@GUID("11558d84-204c-43e7-99b0-2034e9417f7d")
interface IRTCReInviteEvent : IDispatch
{
    HRESULT get_Session(IRTCSession2* ppSession2);
    HRESULT Accept(BSTR bstrContentType, BSTR bstrSessionDescription);
    HRESULT Reject();
    HRESULT get_State(RTC_REINVITE_STATE* pState);
    HRESULT GetRemoteSessionDescription(BSTR* pbstrContentType, BSTR* pbstrSessionDescription);
}

@GUID("f777f570-a820-49d5-86bd-e099493f1518")
interface IRTCPresencePropertyEvent : IDispatch
{
    HRESULT get_StatusCode(int* plStatusCode);
    HRESULT get_StatusText(BSTR* pbstrStatusText);
    HRESULT get_PresenceProperty(RTC_PRESENCE_PROPERTY* penPresProp);
    HRESULT get_Value(BSTR* pbstrValue);
}

@GUID("38f0e78c-8b87-4c04-a82d-aedd83c909bb")
interface IRTCPresenceDataEvent : IDispatch
{
    HRESULT get_StatusCode(int* plStatusCode);
    HRESULT get_StatusText(BSTR* pbstrStatusText);
    HRESULT GetPresenceData(BSTR* pbstrNamespace, BSTR* pbstrData);
}

@GUID("78673f32-4a0f-462c-89aa-ee7706707678")
interface IRTCPresenceStatusEvent : IDispatch
{
    HRESULT get_StatusCode(int* plStatusCode);
    HRESULT get_StatusText(BSTR* pbstrStatusText);
    HRESULT GetLocalPresenceInfo(RTC_PRESENCE_STATUS* penStatus, BSTR* pbstrNotes);
}

@GUID("ec7c8096-b918-4044-94f1-e4fba0361d5c")
interface IRTCCollection : IDispatch
{
    HRESULT get_Count(int* lCount);
    HRESULT get_Item(int Index, VARIANT* pVariant);
    HRESULT get__NewEnum(IUnknown* ppNewEnum);
}

@GUID("fcd56f29-4a4f-41b2-ba5c-f5bccc060bf6")
interface IRTCEnumParticipants : IUnknown
{
    HRESULT Next(uint celt, IRTCParticipant* ppElements, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
    HRESULT Clone(IRTCEnumParticipants* ppEnum);
}

@GUID("29b7c41c-ed82-4bca-84ad-39d5101b58e3")
interface IRTCEnumProfiles : IUnknown
{
    HRESULT Next(uint celt, IRTCProfile* ppElements, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
    HRESULT Clone(IRTCEnumProfiles* ppEnum);
}

@GUID("f7296917-5569-4b3b-b3af-98d1144b2b87")
interface IRTCEnumBuddies : IUnknown
{
    HRESULT Next(uint celt, IRTCBuddy* ppElements, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
    HRESULT Clone(IRTCEnumBuddies* ppEnum);
}

@GUID("a87d55d7-db74-4ed1-9ca4-77a0e41b413e")
interface IRTCEnumWatchers : IUnknown
{
    HRESULT Next(uint celt, IRTCWatcher* ppElements, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
    HRESULT Clone(IRTCEnumWatchers* ppEnum);
}

@GUID("742378d6-a141-4415-8f27-35d99076cf5d")
interface IRTCEnumGroups : IUnknown
{
    HRESULT Next(uint celt, IRTCBuddyGroup* ppElements, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
    HRESULT Clone(IRTCEnumGroups* ppEnum);
}

@GUID("8b22f92c-cd90-42db-a733-212205c3e3df")
interface IRTCPresenceContact : IUnknown
{
    HRESULT get_PresentityURI(BSTR* pbstrPresentityURI);
    HRESULT put_PresentityURI(BSTR bstrPresentityURI);
    HRESULT get_Name(BSTR* pbstrName);
    HRESULT put_Name(BSTR bstrName);
    HRESULT get_Data(BSTR* pbstrData);
    HRESULT put_Data(BSTR bstrData);
    HRESULT get_Persistent(VARIANT_BOOL* pfPersistent);
    HRESULT put_Persistent(VARIANT_BOOL fPersistent);
}

@GUID("fcb136c8-7b90-4e0c-befe-56edf0ba6f1c")
interface IRTCBuddy : IRTCPresenceContact
{
    HRESULT get_Status(RTC_PRESENCE_STATUS* penStatus);
    HRESULT get_Notes(BSTR* pbstrNotes);
}

@GUID("102f9588-23e7-40e3-954d-cd7a1d5c0361")
interface IRTCBuddy2 : IRTCBuddy
{
    HRESULT get_Profile(IRTCProfile2* ppProfile);
    HRESULT Refresh();
    HRESULT EnumerateGroups(IRTCEnumGroups* ppEnum);
    HRESULT get_Groups(IRTCCollection* ppCollection);
    HRESULT get_PresenceProperty(RTC_PRESENCE_PROPERTY enProperty, BSTR* pbstrProperty);
    HRESULT EnumeratePresenceDevices(IRTCEnumPresenceDevices* ppEnumDevices);
    HRESULT get_PresenceDevices(IRTCCollection* ppDevicesCollection);
    HRESULT get_SubscriptionType(RTC_BUDDY_SUBSCRIPTION_TYPE* penSubscriptionType);
}

@GUID("c7cedad8-346b-4d1b-ac02-a2088df9be4f")
interface IRTCWatcher : IRTCPresenceContact
{
    HRESULT get_State(RTC_WATCHER_STATE* penState);
    HRESULT put_State(RTC_WATCHER_STATE enState);
}

@GUID("d4d9967f-d011-4b1d-91e3-aba78f96393d")
interface IRTCWatcher2 : IRTCWatcher
{
    HRESULT get_Profile(IRTCProfile2* ppProfile);
    HRESULT get_Scope(RTC_ACE_SCOPE* penScope);
}

@GUID("60361e68-9164-4389-a4c6-d0b3925bda5e")
interface IRTCBuddyGroup : IUnknown
{
    HRESULT get_Name(BSTR* pbstrGroupName);
    HRESULT put_Name(BSTR bstrGroupName);
    HRESULT AddBuddy(IRTCBuddy pBuddy);
    HRESULT RemoveBuddy(IRTCBuddy pBuddy);
    HRESULT EnumerateBuddies(IRTCEnumBuddies* ppEnum);
    HRESULT get_Buddies(IRTCCollection* ppCollection);
    HRESULT get_Data(BSTR* pbstrData);
    HRESULT put_Data(BSTR bstrData);
    HRESULT get_Profile(IRTCProfile2* ppProfile);
}

@GUID("13fa24c7-5748-4b21-91f5-7397609ce747")
interface IRTCEventNotification : IUnknown
{
    HRESULT Event(RTC_EVENT RTCEvent, IDispatch pEvent);
}

@GUID("da77c14b-6208-43ca-8ddf-5b60a0a69fac")
interface IRTCPortManager : IUnknown
{
    HRESULT GetMapping(BSTR bstrRemoteAddress, RTC_PORT_TYPE enPortType, BSTR* pbstrInternalLocalAddress, 
                       int* plInternalLocalPort, BSTR* pbstrExternalLocalAddress, int* plExternalLocalPort);
    HRESULT UpdateRemoteAddress(BSTR bstrRemoteAddress, BSTR bstrInternalLocalAddress, int lInternalLocalPort, 
                                BSTR bstrExternalLocalAddress, int lExternalLocalPort);
    HRESULT ReleaseMapping(BSTR bstrInternalLocalAddress, int lInternalLocalPort, BSTR bstrExternalLocalAddress, 
                           int lExternalLocalAddress);
}

@GUID("a072f1d6-0286-4e1f-85f2-17a2948456ec")
interface IRTCSessionPortManagement : IUnknown
{
    HRESULT SetPortManager(IRTCPortManager pPortManager);
}

@GUID("d5df3f03-4bde-4417-aefe-71177bdaea66")
interface IRTCClientPortManagement : IUnknown
{
    HRESULT StartListenAddressAndPort(BSTR bstrInternalLocalAddress, int lInternalLocalPort);
    HRESULT StopListenAddressAndPort(BSTR bstrInternalLocalAddress, int lInternalLocalPort);
    HRESULT GetPortRange(RTC_PORT_TYPE enPortType, int* plMinValue, int* plMaxValue);
}

@GUID("b619882b-860c-4db4-be1b-693b6505bbe5")
interface IRTCUserSearch : IUnknown
{
    HRESULT CreateQuery(IRTCUserSearchQuery* ppQuery);
    HRESULT ExecuteSearch(IRTCUserSearchQuery pQuery, IRTCProfile pProfile, ptrdiff_t lCookie);
}

@GUID("288300f5-d23a-4365-9a73-9985c98c2881")
interface IRTCUserSearchQuery : IUnknown
{
    HRESULT put_SearchTerm(BSTR bstrName, BSTR bstrValue);
    HRESULT get_SearchTerm(BSTR bstrName, BSTR* pbstrValue);
    HRESULT get_SearchTerms(BSTR* pbstrNames);
    HRESULT put_SearchPreference(RTC_USER_SEARCH_PREFERENCE enPreference, int lValue);
    HRESULT get_SearchPreference(RTC_USER_SEARCH_PREFERENCE enPreference, int* plValue);
    HRESULT put_SearchDomain(BSTR bstrDomain);
    HRESULT get_SearchDomain(BSTR* pbstrDomain);
}

@GUID("851278b2-9592-480f-8db5-2de86b26b54d")
interface IRTCUserSearchResult : IUnknown
{
    HRESULT get_Value(RTC_USER_SEARCH_COLUMN enColumn, BSTR* pbstrValue);
}

@GUID("83d4d877-aa5d-4a5b-8d0e-002a8067e0e8")
interface IRTCEnumUserSearchResults : IUnknown
{
    HRESULT Next(uint celt, IRTCUserSearchResult* ppElements, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
    HRESULT Clone(IRTCEnumUserSearchResults* ppEnum);
}

@GUID("d8c8c3cd-7fac-4088-81c5-c24cbc0938e3")
interface IRTCUserSearchResultsEvent : IDispatch
{
    HRESULT EnumerateResults(IRTCEnumUserSearchResults* ppEnum);
    HRESULT get_Results(IRTCCollection* ppCollection);
    HRESULT get_Profile(IRTCProfile2* ppProfile);
    HRESULT get_Query(IRTCUserSearchQuery* ppQuery);
    HRESULT get_Cookie(ptrdiff_t* plCookie);
    HRESULT get_StatusCode(int* plStatusCode);
    HRESULT get_MoreAvailable(VARIANT_BOOL* pfMoreAvailable);
}

@GUID("3d8fc2cd-5d76-44ab-bb68-2a80353b34a2")
interface IRTCSessionReferStatusEvent : IDispatch
{
    HRESULT get_Session(IRTCSession2* ppSession);
    HRESULT get_ReferStatus(RTC_SESSION_REFER_STATUS* penReferStatus);
    HRESULT get_StatusCode(int* plStatusCode);
    HRESULT get_StatusText(BSTR* pbstrStatusText);
}

@GUID("176a6828-4fcc-4f28-a862-04597a6cf1c4")
interface IRTCSessionReferredEvent : IDispatch
{
    HRESULT get_Session(IRTCSession2* ppSession);
    HRESULT get_ReferredByURI(BSTR* pbstrReferredByURI);
    HRESULT get_ReferToURI(BSTR* pbstrReferoURI);
    HRESULT get_ReferCookie(BSTR* pbstrReferCookie);
    HRESULT Accept();
    HRESULT Reject();
    HRESULT SetReferredSessionState(RTC_SESSION_STATE enState);
}

@GUID("ba7f518e-d336-4070-93a6-865395c843f9")
interface IRTCSessionDescriptionManager : IUnknown
{
    HRESULT EvaluateSessionDescription(BSTR bstrContentType, BSTR bstrSessionDescription, 
                                       VARIANT_BOOL* pfApplicationSession);
}

@GUID("708c2ab7-8bf8-42f8-8c7d-635197ad5539")
interface IRTCEnumPresenceDevices : IUnknown
{
    HRESULT Next(uint celt, IRTCPresenceDevice* ppElements, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
    HRESULT Clone(IRTCEnumPresenceDevices* ppEnum);
}

@GUID("bc6a90dd-ad9a-48da-9b0c-2515e38521ad")
interface IRTCPresenceDevice : IUnknown
{
    HRESULT get_Status(RTC_PRESENCE_STATUS* penStatus);
    HRESULT get_Notes(BSTR* pbstrNotes);
    HRESULT get_PresenceProperty(RTC_PRESENCE_PROPERTY enProperty, BSTR* pbstrProperty);
    HRESULT GetPresenceData(BSTR* pbstrNamespace, BSTR* pbstrData);
}

@GUID("176ddfbe-fec0-4d55-bc87-84cff1ef7f91")
interface IRTCDispatchEventNotification : IDispatch
{
}

@GUID("5123e076-29e3-4bfd-84fe-0192d411e3e8")
interface ITransportSettingsInternal : IUnknown
{
    HRESULT ApplySetting(TRANSPORT_SETTING* Setting);
    HRESULT QuerySetting(TRANSPORT_SETTING* Setting);
}

@GUID("5e7abb2c-f2c1-4a61-bd35-deb7a08ab0f1")
interface INetworkTransportSettings : IUnknown
{
    HRESULT ApplySetting(const(TRANSPORT_SETTING_ID)* SettingId, uint LengthIn, const(ubyte)* ValueIn, 
                         uint* LengthOut, ubyte** ValueOut);
    HRESULT QuerySetting(const(TRANSPORT_SETTING_ID)* SettingId, uint LengthIn, const(ubyte)* ValueIn, 
                         uint* LengthOut, ubyte** ValueOut);
}

@GUID("79eb1402-0ab8-49c0-9e14-a1ae4ba93058")
interface INotificationTransportSync : IUnknown
{
    HRESULT CompleteDelivery();
    HRESULT Flush();
}


// GUIDs

const GUID CLSID_RTCClient = GUIDOF!RTCClient;

const GUID IID_INetworkTransportSettings          = GUIDOF!INetworkTransportSettings;
const GUID IID_INotificationTransportSync         = GUIDOF!INotificationTransportSync;
const GUID IID_IRTCBuddy                          = GUIDOF!IRTCBuddy;
const GUID IID_IRTCBuddy2                         = GUIDOF!IRTCBuddy2;
const GUID IID_IRTCBuddyEvent                     = GUIDOF!IRTCBuddyEvent;
const GUID IID_IRTCBuddyEvent2                    = GUIDOF!IRTCBuddyEvent2;
const GUID IID_IRTCBuddyGroup                     = GUIDOF!IRTCBuddyGroup;
const GUID IID_IRTCBuddyGroupEvent                = GUIDOF!IRTCBuddyGroupEvent;
const GUID IID_IRTCClient                         = GUIDOF!IRTCClient;
const GUID IID_IRTCClient2                        = GUIDOF!IRTCClient2;
const GUID IID_IRTCClientEvent                    = GUIDOF!IRTCClientEvent;
const GUID IID_IRTCClientPortManagement           = GUIDOF!IRTCClientPortManagement;
const GUID IID_IRTCClientPresence                 = GUIDOF!IRTCClientPresence;
const GUID IID_IRTCClientPresence2                = GUIDOF!IRTCClientPresence2;
const GUID IID_IRTCClientProvisioning             = GUIDOF!IRTCClientProvisioning;
const GUID IID_IRTCClientProvisioning2            = GUIDOF!IRTCClientProvisioning2;
const GUID IID_IRTCCollection                     = GUIDOF!IRTCCollection;
const GUID IID_IRTCDispatchEventNotification      = GUIDOF!IRTCDispatchEventNotification;
const GUID IID_IRTCEnumBuddies                    = GUIDOF!IRTCEnumBuddies;
const GUID IID_IRTCEnumGroups                     = GUIDOF!IRTCEnumGroups;
const GUID IID_IRTCEnumParticipants               = GUIDOF!IRTCEnumParticipants;
const GUID IID_IRTCEnumPresenceDevices            = GUIDOF!IRTCEnumPresenceDevices;
const GUID IID_IRTCEnumProfiles                   = GUIDOF!IRTCEnumProfiles;
const GUID IID_IRTCEnumUserSearchResults          = GUIDOF!IRTCEnumUserSearchResults;
const GUID IID_IRTCEnumWatchers                   = GUIDOF!IRTCEnumWatchers;
const GUID IID_IRTCEventNotification              = GUIDOF!IRTCEventNotification;
const GUID IID_IRTCInfoEvent                      = GUIDOF!IRTCInfoEvent;
const GUID IID_IRTCIntensityEvent                 = GUIDOF!IRTCIntensityEvent;
const GUID IID_IRTCMediaEvent                     = GUIDOF!IRTCMediaEvent;
const GUID IID_IRTCMediaRequestEvent              = GUIDOF!IRTCMediaRequestEvent;
const GUID IID_IRTCMessagingEvent                 = GUIDOF!IRTCMessagingEvent;
const GUID IID_IRTCParticipant                    = GUIDOF!IRTCParticipant;
const GUID IID_IRTCParticipantStateChangeEvent    = GUIDOF!IRTCParticipantStateChangeEvent;
const GUID IID_IRTCPortManager                    = GUIDOF!IRTCPortManager;
const GUID IID_IRTCPresenceContact                = GUIDOF!IRTCPresenceContact;
const GUID IID_IRTCPresenceDataEvent              = GUIDOF!IRTCPresenceDataEvent;
const GUID IID_IRTCPresenceDevice                 = GUIDOF!IRTCPresenceDevice;
const GUID IID_IRTCPresencePropertyEvent          = GUIDOF!IRTCPresencePropertyEvent;
const GUID IID_IRTCPresenceStatusEvent            = GUIDOF!IRTCPresenceStatusEvent;
const GUID IID_IRTCProfile                        = GUIDOF!IRTCProfile;
const GUID IID_IRTCProfile2                       = GUIDOF!IRTCProfile2;
const GUID IID_IRTCProfileEvent                   = GUIDOF!IRTCProfileEvent;
const GUID IID_IRTCProfileEvent2                  = GUIDOF!IRTCProfileEvent2;
const GUID IID_IRTCReInviteEvent                  = GUIDOF!IRTCReInviteEvent;
const GUID IID_IRTCRegistrationStateChangeEvent   = GUIDOF!IRTCRegistrationStateChangeEvent;
const GUID IID_IRTCRoamingEvent                   = GUIDOF!IRTCRoamingEvent;
const GUID IID_IRTCSession                        = GUIDOF!IRTCSession;
const GUID IID_IRTCSession2                       = GUIDOF!IRTCSession2;
const GUID IID_IRTCSessionCallControl             = GUIDOF!IRTCSessionCallControl;
const GUID IID_IRTCSessionDescriptionManager      = GUIDOF!IRTCSessionDescriptionManager;
const GUID IID_IRTCSessionOperationCompleteEvent  = GUIDOF!IRTCSessionOperationCompleteEvent;
const GUID IID_IRTCSessionOperationCompleteEvent2 = GUIDOF!IRTCSessionOperationCompleteEvent2;
const GUID IID_IRTCSessionPortManagement          = GUIDOF!IRTCSessionPortManagement;
const GUID IID_IRTCSessionReferStatusEvent        = GUIDOF!IRTCSessionReferStatusEvent;
const GUID IID_IRTCSessionReferredEvent           = GUIDOF!IRTCSessionReferredEvent;
const GUID IID_IRTCSessionStateChangeEvent        = GUIDOF!IRTCSessionStateChangeEvent;
const GUID IID_IRTCSessionStateChangeEvent2       = GUIDOF!IRTCSessionStateChangeEvent2;
const GUID IID_IRTCUserSearch                     = GUIDOF!IRTCUserSearch;
const GUID IID_IRTCUserSearchQuery                = GUIDOF!IRTCUserSearchQuery;
const GUID IID_IRTCUserSearchResult               = GUIDOF!IRTCUserSearchResult;
const GUID IID_IRTCUserSearchResultsEvent         = GUIDOF!IRTCUserSearchResultsEvent;
const GUID IID_IRTCWatcher                        = GUIDOF!IRTCWatcher;
const GUID IID_IRTCWatcher2                       = GUIDOF!IRTCWatcher2;
const GUID IID_IRTCWatcherEvent                   = GUIDOF!IRTCWatcherEvent;
const GUID IID_IRTCWatcherEvent2                  = GUIDOF!IRTCWatcherEvent2;
const GUID IID_ITransportSettingsInternal         = GUIDOF!ITransportSettingsInternal;
