// Written in the D programming language.

module windows.win32.networkmanagement.mobilebroadband;

public import windows.core;
public import windows.win32.foundation.foundation : BOOL, BSTR, HRESULT, PWSTR, VARIANT_BOOL;
public import windows.win32.system.com.com : IDispatch, IUnknown, SAFEARRAY;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/ne-mbnapi-mbn_signal_constants
alias MBN_SIGNAL_CONSTANTS = int;
enum : int
{
    MBN_RSSI_DEFAULT       = 0xffffffff,
    MBN_RSSI_DISABLE       = 0x00000000,
    MBN_RSSI_UNKNOWN       = 0x00000063,
    MBN_ERROR_RATE_UNKNOWN = 0x00000063,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/ne-mbnapi-mbn_cellular_class
alias MBN_CELLULAR_CLASS = int;
enum : int
{
    MBN_CELLULAR_CLASS_NONE = 0x00000000,
    MBN_CELLULAR_CLASS_GSM  = 0x00000001,
    MBN_CELLULAR_CLASS_CDMA = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/ne-mbnapi-mbn_voice_class
alias MBN_VOICE_CLASS = int;
enum : int
{
    MBN_VOICE_CLASS_NONE                    = 0x00000000,
    MBN_VOICE_CLASS_NO_VOICE                = 0x00000001,
    MBN_VOICE_CLASS_SEPARATE_VOICE_DATA     = 0x00000002,
    MBN_VOICE_CLASS_SIMULTANEOUS_VOICE_DATA = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/ne-mbnapi-mbn_provider_state
alias MBN_PROVIDER_STATE = int;
enum : int
{
    MBN_PROVIDER_STATE_NONE                   = 0x00000000,
    MBN_PROVIDER_STATE_HOME                   = 0x00000001,
    MBN_PROVIDER_STATE_FORBIDDEN              = 0x00000002,
    MBN_PROVIDER_STATE_PREFERRED              = 0x00000004,
    MBN_PROVIDER_STATE_VISIBLE                = 0x00000008,
    MBN_PROVIDER_STATE_REGISTERED             = 0x00000010,
    MBN_PROVIDER_STATE_PREFERRED_MULTICARRIER = 0x00000020,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/ne-mbnapi-mbn_provider_constants
alias MBN_PROVIDER_CONSTANTS = int;
enum : int
{
    MBN_PROVIDERNAME_LEN = 0x00000014,
    MBN_PROVIDERID_LEN   = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/ne-mbnapi-mbn_interface_caps_constants
alias MBN_INTERFACE_CAPS_CONSTANTS = int;
enum : int
{
    MBN_DEVICEID_LEN     = 0x00000012,
    MBN_MANUFACTURER_LEN = 0x00000020,
    MBN_MODEL_LEN        = 0x00000020,
    MBN_FIRMWARE_LEN     = 0x00000020,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/ne-mbnapi-mbn_data_class
alias MBN_DATA_CLASS = int;
enum : int
{
    MBN_DATA_CLASS_NONE        = 0x00000000,
    MBN_DATA_CLASS_GPRS        = 0x00000001,
    MBN_DATA_CLASS_EDGE        = 0x00000002,
    MBN_DATA_CLASS_UMTS        = 0x00000004,
    MBN_DATA_CLASS_HSDPA       = 0x00000008,
    MBN_DATA_CLASS_HSUPA       = 0x00000010,
    MBN_DATA_CLASS_LTE         = 0x00000020,
    MBN_DATA_CLASS_5G_NSA      = 0x00000040,
    MBN_DATA_CLASS_5G_SA       = 0x00000080,
    MBN_DATA_CLASS_1XRTT       = 0x00010000,
    MBN_DATA_CLASS_1XEVDO      = 0x00020000,
    MBN_DATA_CLASS_1XEVDO_REVA = 0x00040000,
    MBN_DATA_CLASS_1XEVDV      = 0x00080000,
    MBN_DATA_CLASS_3XRTT       = 0x00100000,
    MBN_DATA_CLASS_1XEVDO_REVB = 0x00200000,
    MBN_DATA_CLASS_UMB         = 0x00400000,
    MBN_DATA_CLASS_CUSTOM      = 0x80000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/ne-mbnapi-mbn_ctrl_caps
alias MBN_CTRL_CAPS = int;
enum : int
{
    MBN_CTRL_CAPS_NONE                = 0x00000000,
    MBN_CTRL_CAPS_REG_MANUAL          = 0x00000001,
    MBN_CTRL_CAPS_HW_RADIO_SWITCH     = 0x00000002,
    MBN_CTRL_CAPS_CDMA_MOBILE_IP      = 0x00000004,
    MBN_CTRL_CAPS_CDMA_SIMPLE_IP      = 0x00000008,
    MBN_CTRL_CAPS_PROTECT_UNIQUEID    = 0x00000010,
    MBN_CTRL_CAPS_MODEL_MULTI_CARRIER = 0x00000020,
    MBN_CTRL_CAPS_USSD                = 0x00000040,
    MBN_CTRL_CAPS_MULTI_MODE          = 0x00000080,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/ne-mbnapi-mbn_sms_caps
alias MBN_SMS_CAPS = int;
enum : int
{
    MBN_SMS_CAPS_NONE         = 0x00000000,
    MBN_SMS_CAPS_PDU_RECEIVE  = 0x00000001,
    MBN_SMS_CAPS_PDU_SEND     = 0x00000002,
    MBN_SMS_CAPS_TEXT_RECEIVE = 0x00000004,
    MBN_SMS_CAPS_TEXT_SEND    = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/ne-mbnapi-mbn_band_class
alias MBN_BAND_CLASS = int;
enum : int
{
    MBN_BAND_CLASS_NONE   = 0x00000000,
    MBN_BAND_CLASS_0      = 0x00000001,
    MBN_BAND_CLASS_I      = 0x00000002,
    MBN_BAND_CLASS_II     = 0x00000004,
    MBN_BAND_CLASS_III    = 0x00000008,
    MBN_BAND_CLASS_IV     = 0x00000010,
    MBN_BAND_CLASS_V      = 0x00000020,
    MBN_BAND_CLASS_VI     = 0x00000040,
    MBN_BAND_CLASS_VII    = 0x00000080,
    MBN_BAND_CLASS_VIII   = 0x00000100,
    MBN_BAND_CLASS_IX     = 0x00000200,
    MBN_BAND_CLASS_X      = 0x00000400,
    MBN_BAND_CLASS_XI     = 0x00000800,
    MBN_BAND_CLASS_XII    = 0x00001000,
    MBN_BAND_CLASS_XIII   = 0x00002000,
    MBN_BAND_CLASS_XIV    = 0x00004000,
    MBN_BAND_CLASS_XV     = 0x00008000,
    MBN_BAND_CLASS_XVI    = 0x00010000,
    MBN_BAND_CLASS_XVII   = 0x00020000,
    MBN_BAND_CLASS_CUSTOM = 0x80000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/ne-mbnapi-mbn_ready_state
alias MBN_READY_STATE = int;
enum : int
{
    MBN_READY_STATE_OFF              = 0x00000000,
    MBN_READY_STATE_INITIALIZED      = 0x00000001,
    MBN_READY_STATE_SIM_NOT_INSERTED = 0x00000002,
    MBN_READY_STATE_BAD_SIM          = 0x00000003,
    MBN_READY_STATE_FAILURE          = 0x00000004,
    MBN_READY_STATE_NOT_ACTIVATED    = 0x00000005,
    MBN_READY_STATE_DEVICE_LOCKED    = 0x00000006,
    MBN_READY_STATE_DEVICE_BLOCKED   = 0x00000007,
    MBN_READY_STATE_NO_ESIM_PROFILE  = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/ne-mbnapi-mbn_activation_state
alias MBN_ACTIVATION_STATE = int;
enum : int
{
    MBN_ACTIVATION_STATE_NONE         = 0x00000000,
    MBN_ACTIVATION_STATE_ACTIVATED    = 0x00000001,
    MBN_ACTIVATION_STATE_ACTIVATING   = 0x00000002,
    MBN_ACTIVATION_STATE_DEACTIVATED  = 0x00000003,
    MBN_ACTIVATION_STATE_DEACTIVATING = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/ne-mbnapi-mbn_connection_mode
alias MBN_CONNECTION_MODE = int;
enum : int
{
    MBN_CONNECTION_MODE_PROFILE     = 0x00000000,
    MBN_CONNECTION_MODE_TMP_PROFILE = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/ne-mbnapi-mbn_voice_call_state
alias MBN_VOICE_CALL_STATE = int;
enum : int
{
    MBN_VOICE_CALL_STATE_NONE        = 0x00000000,
    MBN_VOICE_CALL_STATE_IN_PROGRESS = 0x00000001,
    MBN_VOICE_CALL_STATE_HANGUP      = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/ne-mbnapi-mbn_registration_constants
alias MBN_REGISTRATION_CONSTANTS = int;
enum : int
{
    MBN_ROAMTEXT_LEN             = 0x00000040,
    MBN_CDMA_DEFAULT_PROVIDER_ID = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/ne-mbnapi-mbn_register_state
alias MBN_REGISTER_STATE = int;
enum : int
{
    MBN_REGISTER_STATE_NONE         = 0x00000000,
    MBN_REGISTER_STATE_DEREGISTERED = 0x00000001,
    MBN_REGISTER_STATE_SEARCHING    = 0x00000002,
    MBN_REGISTER_STATE_HOME         = 0x00000003,
    MBN_REGISTER_STATE_ROAMING      = 0x00000004,
    MBN_REGISTER_STATE_PARTNER      = 0x00000005,
    MBN_REGISTER_STATE_DENIED       = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/ne-mbnapi-mbn_register_mode
alias MBN_REGISTER_MODE = int;
enum : int
{
    MBN_REGISTER_MODE_NONE      = 0x00000000,
    MBN_REGISTER_MODE_AUTOMATIC = 0x00000001,
    MBN_REGISTER_MODE_MANUAL    = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/ne-mbnapi-mbn_pin_constants
alias MBN_PIN_CONSTANTS = int;
enum : int
{
    MBN_ATTEMPTS_REMAINING_UNKNOWN = 0xffffffff,
    MBN_PIN_LENGTH_UNKNOWN         = 0xffffffff,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/ne-mbnapi-mbn_pin_state
alias MBN_PIN_STATE = int;
enum : int
{
    MBN_PIN_STATE_NONE    = 0x00000000,
    MBN_PIN_STATE_ENTER   = 0x00000001,
    MBN_PIN_STATE_UNBLOCK = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/ne-mbnapi-mbn_pin_type
alias MBN_PIN_TYPE = int;
enum : int
{
    MBN_PIN_TYPE_NONE                 = 0x00000000,
    MBN_PIN_TYPE_CUSTOM               = 0x00000001,
    MBN_PIN_TYPE_PIN1                 = 0x00000002,
    MBN_PIN_TYPE_PIN2                 = 0x00000003,
    MBN_PIN_TYPE_DEVICE_SIM_PIN       = 0x00000004,
    MBN_PIN_TYPE_DEVICE_FIRST_SIM_PIN = 0x00000005,
    MBN_PIN_TYPE_NETWORK_PIN          = 0x00000006,
    MBN_PIN_TYPE_NETWORK_SUBSET_PIN   = 0x00000007,
    MBN_PIN_TYPE_SVC_PROVIDER_PIN     = 0x00000008,
    MBN_PIN_TYPE_CORPORATE_PIN        = 0x00000009,
    MBN_PIN_TYPE_SUBSIDY_LOCK         = 0x0000000a,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/ne-mbnapi-mbn_pin_mode
alias MBN_PIN_MODE = int;
enum : int
{
    MBN_PIN_MODE_ENABLED  = 0x00000001,
    MBN_PIN_MODE_DISABLED = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/ne-mbnapi-mbn_pin_format
alias MBN_PIN_FORMAT = int;
enum : int
{
    MBN_PIN_FORMAT_NONE         = 0x00000000,
    MBN_PIN_FORMAT_NUMERIC      = 0x00000001,
    MBN_PIN_FORMAT_ALPHANUMERIC = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/ne-mbnapi-mbn_context_constants
alias MBN_CONTEXT_CONSTANTS = int;
enum : int
{
    MBN_ACCESSSTRING_LEN  = 0x00000064,
    MBN_USERNAME_LEN      = 0x000000ff,
    MBN_PASSWORD_LEN      = 0x000000ff,
    MBN_CONTEXT_ID_APPEND = 0xffffffff,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/ne-mbnapi-mbn_auth_protocol
alias MBN_AUTH_PROTOCOL = int;
enum : int
{
    MBN_AUTH_PROTOCOL_NONE     = 0x00000000,
    MBN_AUTH_PROTOCOL_PAP      = 0x00000001,
    MBN_AUTH_PROTOCOL_CHAP     = 0x00000002,
    MBN_AUTH_PROTOCOL_MSCHAPV2 = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/ne-mbnapi-mbn_compression
alias MBN_COMPRESSION = int;
enum : int
{
    MBN_COMPRESSION_NONE   = 0x00000000,
    MBN_COMPRESSION_ENABLE = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/ne-mbnapi-mbn_context_type
alias MBN_CONTEXT_TYPE = int;
enum : int
{
    MBN_CONTEXT_TYPE_NONE        = 0x00000000,
    MBN_CONTEXT_TYPE_INTERNET    = 0x00000001,
    MBN_CONTEXT_TYPE_VPN         = 0x00000002,
    MBN_CONTEXT_TYPE_VOICE       = 0x00000003,
    MBN_CONTEXT_TYPE_VIDEO_SHARE = 0x00000004,
    MBN_CONTEXT_TYPE_CUSTOM      = 0x00000005,
    MBN_CONTEXT_TYPE_PURCHASE    = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/ne-mbnapi-wwaext_sms_constants
alias WWAEXT_SMS_CONSTANTS = int;
enum : int
{
    MBN_MESSAGE_INDEX_NONE          = 0x00000000,
    MBN_CDMA_SHORT_MSG_SIZE_UNKNOWN = 0x00000000,
    MBN_CDMA_SHORT_MSG_SIZE_MAX     = 0x000000a0,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/ne-mbnapi-mbn_msg_status
alias MBN_MSG_STATUS = int;
enum : int
{
    MBN_MSG_STATUS_NEW   = 0x00000000,
    MBN_MSG_STATUS_OLD   = 0x00000001,
    MBN_MSG_STATUS_DRAFT = 0x00000002,
    MBN_MSG_STATUS_SENT  = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/ne-mbnapi-mbn_sms_cdma_lang
alias MBN_SMS_CDMA_LANG = int;
enum : int
{
    MBN_SMS_CDMA_LANG_NONE     = 0x00000000,
    MBN_SMS_CDMA_LANG_ENGLISH  = 0x00000001,
    MBN_SMS_CDMA_LANG_FRENCH   = 0x00000002,
    MBN_SMS_CDMA_LANG_SPANISH  = 0x00000003,
    MBN_SMS_CDMA_LANG_JAPANESE = 0x00000004,
    MBN_SMS_CDMA_LANG_KOREAN   = 0x00000005,
    MBN_SMS_CDMA_LANG_CHINESE  = 0x00000006,
    MBN_SMS_CDMA_LANG_HEBREW   = 0x00000007,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/ne-mbnapi-mbn_sms_cdma_encoding
alias MBN_SMS_CDMA_ENCODING = int;
enum : int
{
    MBN_SMS_CDMA_ENCODING_OCTET        = 0x00000000,
    MBN_SMS_CDMA_ENCODING_EPM          = 0x00000001,
    MBN_SMS_CDMA_ENCODING_7BIT_ASCII   = 0x00000002,
    MBN_SMS_CDMA_ENCODING_IA5          = 0x00000003,
    MBN_SMS_CDMA_ENCODING_UNICODE      = 0x00000004,
    MBN_SMS_CDMA_ENCODING_SHIFT_JIS    = 0x00000005,
    MBN_SMS_CDMA_ENCODING_KOREAN       = 0x00000006,
    MBN_SMS_CDMA_ENCODING_LATIN_HEBREW = 0x00000007,
    MBN_SMS_CDMA_ENCODING_LATIN        = 0x00000008,
    MBN_SMS_CDMA_ENCODING_GSM_7BIT     = 0x00000009,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/ne-mbnapi-mbn_sms_flag
alias MBN_SMS_FLAG = int;
enum : int
{
    MBN_SMS_FLAG_ALL   = 0x00000000,
    MBN_SMS_FLAG_INDEX = 0x00000001,
    MBN_SMS_FLAG_NEW   = 0x00000002,
    MBN_SMS_FLAG_OLD   = 0x00000003,
    MBN_SMS_FLAG_SENT  = 0x00000004,
    MBN_SMS_FLAG_DRAFT = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/ne-mbnapi-mbn_sms_status_flag
alias MBN_SMS_STATUS_FLAG = int;
enum : int
{
    MBN_SMS_FLAG_NONE               = 0x00000000,
    MBN_SMS_FLAG_MESSAGE_STORE_FULL = 0x00000001,
    MBN_SMS_FLAG_NEW_MESSAGE        = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/ne-mbnapi-mbn_sms_format
alias MBN_SMS_FORMAT = int;
enum : int
{
    MBN_SMS_FORMAT_NONE = 0x00000000,
    MBN_SMS_FORMAT_PDU  = 0x00000001,
    MBN_SMS_FORMAT_TEXT = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/ne-mbnapi-mbn_radio
alias MBN_RADIO = int;
enum : int
{
    MBN_RADIO_OFF = 0x00000000,
    MBN_RADIO_ON  = 0x00000001,
}

alias MBN_DEVICE_SERVICE_SESSIONS_STATE = int;
enum : int
{
    MBN_DEVICE_SERVICE_SESSIONS_RESTORED = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/ne-mbnapi-mbn_device_services_interface_state
alias MBN_DEVICE_SERVICES_INTERFACE_STATE = int;
enum : int
{
    MBN_DEVICE_SERVICES_CAPABLE_INTERFACE_ARRIVAL = 0x00000000,
    MBN_DEVICE_SERVICES_CAPABLE_INTERFACE_REMOVAL = 0x00000001,
}

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/ns-mbnapi-mbn_interface_caps
struct MBN_INTERFACE_CAPS
{
    MBN_CELLULAR_CLASS cellularClass;
    MBN_VOICE_CLASS    voiceClass;
    uint               dataClass;
    BSTR               customDataClass;
    uint               gsmBandClass;
    uint               cdmaBandClass;
    BSTR               customBandClass;
    uint               smsCaps;
    uint               controlCaps;
    BSTR               deviceID;
    BSTR               manufacturer;
    BSTR               model;
    BSTR               firmwareInfo;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/ns-mbnapi-mbn_provider
struct MBN_PROVIDER
{
    BSTR providerID;
    uint providerState;
    BSTR providerName;
    uint dataClass;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/ns-mbnapi-mbn_provider2
struct MBN_PROVIDER2
{
    MBN_PROVIDER       provider;
    MBN_CELLULAR_CLASS cellularClass;
    uint               signalStrength;
    uint               signalError;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/ns-mbnapi-mbn_pin_info
struct MBN_PIN_INFO
{
    MBN_PIN_STATE pinState;
    MBN_PIN_TYPE  pinType;
    uint          attemptsRemaining;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/ns-mbnapi-mbn_context
struct MBN_CONTEXT
{
    uint              contextID;
    MBN_CONTEXT_TYPE  contextType;
    BSTR              accessString;
    BSTR              userName;
    BSTR              password;
    MBN_COMPRESSION   compression;
    MBN_AUTH_PROTOCOL authType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/ns-mbnapi-mbn_sms_filter
struct MBN_SMS_FILTER
{
    MBN_SMS_FLAG flag;
    uint         messageIndex;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/ns-mbnapi-mbn_sms_status_info
struct MBN_SMS_STATUS_INFO
{
    uint flag;
    uint messageIndex;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/ns-mbnapi-mbn_device_service
struct MBN_DEVICE_SERVICE
{
    BSTR         deviceServiceID;
    VARIANT_BOOL dataWriteSupported;
    VARIANT_BOOL dataReadSupported;
}

struct __mbnapi_ReferenceRemainingTypes__
{
    MBN_BAND_CLASS       bandClass;
    MBN_CONTEXT_CONSTANTS contextConstants;
    MBN_CTRL_CAPS        ctrlCaps;
    MBN_DATA_CLASS       dataClass;
    MBN_INTERFACE_CAPS_CONSTANTS interfaceCapsConstants;
    MBN_PIN_CONSTANTS    pinConstants;
    MBN_PROVIDER_CONSTANTS providerConstants;
    MBN_PROVIDER_STATE   providerState;
    MBN_REGISTRATION_CONSTANTS registrationConstants;
    MBN_SIGNAL_CONSTANTS signalConstants;
    MBN_SMS_CAPS         smsCaps;
    WWAEXT_SMS_CONSTANTS smsConstants;
    WWAEXT_SMS_CONSTANTS wwaextSmsConstants;
    MBN_SMS_STATUS_FLAG  smsStatusFlag;
}

struct __DummyPinType__
{
    uint pinType;
}

// Interfaces

@GUID("bdfee05a-4418-11dd-90ed-001c257ccff1")
struct MbnConnectionProfileManager;

@GUID("bdfee05b-4418-11dd-90ed-001c257ccff1")
struct MbnInterfaceManager;

@GUID("bdfee05c-4418-11dd-90ed-001c257ccff1")
struct MbnConnectionManager;

@GUID("2269daa3-2a9f-4165-a501-ce00a6f7a75b")
struct MbnDeviceServicesManager;

@GUID("dcbbbab6-ffff-4bbb-aaee-338e368af6fa")
interface IDummyMBNUCMExt : IDispatch
{
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nn-mbnapi-imbnconnection
@GUID("dcbbbab6-200d-4bbb-aaee-338e368af6fa")
interface IMbnConnection : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnconnection-get_connectionid
    HRESULT get_ConnectionID(BSTR* ConnectionID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnconnection-get_interfaceid
    HRESULT get_InterfaceID(BSTR* InterfaceID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnconnection-connect
    HRESULT Connect(MBN_CONNECTION_MODE connectionMode, const(PWSTR) strProfile, uint* requestID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnconnection-disconnect
    HRESULT Disconnect(uint* requestID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnconnection-getconnectionstate
    HRESULT GetConnectionState(MBN_ACTIVATION_STATE* ConnectionState, BSTR* ProfileName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnconnection-getvoicecallstate
    HRESULT GetVoiceCallState(MBN_VOICE_CALL_STATE* voiceCallState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnconnection-getactivationnetworkerror
    HRESULT GetActivationNetworkError(uint* networkError);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nn-mbnapi-imbnconnectionevents
@GUID("dcbbbab6-200e-4bbb-aaee-338e368af6fa")
interface IMbnConnectionEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnconnectionevents-onconnectcomplete
    HRESULT OnConnectComplete(IMbnConnection newConnection, uint requestID, HRESULT status);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnconnectionevents-ondisconnectcomplete
    HRESULT OnDisconnectComplete(IMbnConnection newConnection, uint requestID, HRESULT status);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnconnectionevents-onconnectstatechange
    HRESULT OnConnectStateChange(IMbnConnection newConnection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnconnectionevents-onvoicecallstatechange
    HRESULT OnVoiceCallStateChange(IMbnConnection newConnection);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nn-mbnapi-imbninterface
@GUID("dcbbbab6-2001-4bbb-aaee-338e368af6fa")
interface IMbnInterface : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbninterface-get_interfaceid
    HRESULT get_InterfaceID(BSTR* InterfaceID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbninterface-getinterfacecapability
    HRESULT GetInterfaceCapability(MBN_INTERFACE_CAPS* interfaceCaps);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbninterface-getsubscriberinformation
    HRESULT GetSubscriberInformation(IMbnSubscriberInformation* subscriberInformation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbninterface-getreadystate
    HRESULT GetReadyState(MBN_READY_STATE* readyState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbninterface-inemergencymode
    HRESULT InEmergencyMode(VARIANT_BOOL* emergencyMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbninterface-gethomeprovider
    HRESULT GetHomeProvider(MBN_PROVIDER* homeProvider);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbninterface-getpreferredproviders
    HRESULT GetPreferredProviders(SAFEARRAY** preferredProviders);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbninterface-setpreferredproviders
    HRESULT SetPreferredProviders(SAFEARRAY* preferredProviders, uint* requestID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbninterface-getvisibleproviders
    HRESULT GetVisibleProviders(uint* age, SAFEARRAY** visibleProviders);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbninterface-scannetwork
    HRESULT ScanNetwork(uint* requestID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbninterface-getconnection
    HRESULT GetConnection(IMbnConnection* mbnConnection);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nn-mbnapi-imbninterfaceevents
@GUID("dcbbbab6-2002-4bbb-aaee-338e368af6fa")
interface IMbnInterfaceEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbninterfaceevents-oninterfacecapabilityavailable
    HRESULT OnInterfaceCapabilityAvailable(IMbnInterface newInterface);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbninterfaceevents-onsubscriberinformationchange
    HRESULT OnSubscriberInformationChange(IMbnInterface newInterface);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbninterfaceevents-onreadystatechange
    HRESULT OnReadyStateChange(IMbnInterface newInterface);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbninterfaceevents-onemergencymodechange
    HRESULT OnEmergencyModeChange(IMbnInterface newInterface);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbninterfaceevents-onhomeprovideravailable
    HRESULT OnHomeProviderAvailable(IMbnInterface newInterface);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbninterfaceevents-onpreferredproviderschange
    HRESULT OnPreferredProvidersChange(IMbnInterface newInterface);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbninterfaceevents-onsetpreferredproviderscomplete
    HRESULT OnSetPreferredProvidersComplete(IMbnInterface newInterface, uint requestID, HRESULT status);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbninterfaceevents-onscannetworkcomplete
    HRESULT OnScanNetworkComplete(IMbnInterface newInterface, uint requestID, HRESULT status);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nn-mbnapi-imbninterfacemanager
@GUID("dcbbbab6-201b-4bbb-aaee-338e368af6fa")
interface IMbnInterfaceManager : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbninterfacemanager-getinterface
    HRESULT GetInterface(const(PWSTR) interfaceID, IMbnInterface* mbnInterface);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbninterfacemanager-getinterfaces
    HRESULT GetInterfaces(SAFEARRAY** mbnInterfaces);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nn-mbnapi-imbninterfacemanagerevents
@GUID("dcbbbab6-201c-4bbb-aaee-338e368af6fa")
interface IMbnInterfaceManagerEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbninterfacemanagerevents-oninterfacearrival
    HRESULT OnInterfaceArrival(IMbnInterface newInterface);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbninterfacemanagerevents-oninterfaceremoval
    HRESULT OnInterfaceRemoval(IMbnInterface oldInterface);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nn-mbnapi-imbnregistration
@GUID("dcbbbab6-2009-4bbb-aaee-338e368af6fa")
interface IMbnRegistration : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnregistration-getregisterstate
    HRESULT GetRegisterState(MBN_REGISTER_STATE* registerState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnregistration-getregistermode
    HRESULT GetRegisterMode(MBN_REGISTER_MODE* registerMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnregistration-getproviderid
    HRESULT GetProviderID(BSTR* providerID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnregistration-getprovidername
    HRESULT GetProviderName(BSTR* providerName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnregistration-getroamingtext
    HRESULT GetRoamingText(BSTR* roamingText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnregistration-getavailabledataclasses
    HRESULT GetAvailableDataClasses(uint* availableDataClasses);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnregistration-getcurrentdataclass
    HRESULT GetCurrentDataClass(uint* currentDataClass);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnregistration-getregistrationnetworkerror
    HRESULT GetRegistrationNetworkError(uint* registrationNetworkError);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnregistration-getpacketattachnetworkerror
    HRESULT GetPacketAttachNetworkError(uint* packetAttachNetworkError);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnregistration-setregistermode
    HRESULT SetRegisterMode(MBN_REGISTER_MODE registerMode, const(PWSTR) providerID, uint dataClass, 
                            uint* requestID);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nn-mbnapi-imbnregistrationevents
@GUID("dcbbbab6-200a-4bbb-aaee-338e368af6fa")
interface IMbnRegistrationEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnregistrationevents-onregistermodeavailable
    HRESULT OnRegisterModeAvailable(IMbnRegistration newInterface);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnregistrationevents-onregisterstatechange
    HRESULT OnRegisterStateChange(IMbnRegistration newInterface);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnregistrationevents-onpacketservicestatechange
    HRESULT OnPacketServiceStateChange(IMbnRegistration newInterface);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnregistrationevents-onsetregistermodecomplete
    HRESULT OnSetRegisterModeComplete(IMbnRegistration newInterface, uint requestID, HRESULT status);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nn-mbnapi-imbnconnectionmanager
@GUID("dcbbbab6-201d-4bbb-aaee-338e368af6fa")
interface IMbnConnectionManager : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnconnectionmanager-getconnection
    HRESULT GetConnection(const(PWSTR) connectionID, IMbnConnection* mbnConnection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnconnectionmanager-getconnections
    HRESULT GetConnections(SAFEARRAY** mbnConnections);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nn-mbnapi-imbnconnectionmanagerevents
@GUID("dcbbbab6-201e-4bbb-aaee-338e368af6fa")
interface IMbnConnectionManagerEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnconnectionmanagerevents-onconnectionarrival
    HRESULT OnConnectionArrival(IMbnConnection newConnection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnconnectionmanagerevents-onconnectionremoval
    HRESULT OnConnectionRemoval(IMbnConnection oldConnection);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nn-mbnapi-imbnpinmanager
@GUID("dcbbbab6-2005-4bbb-aaee-338e368af6fa")
interface IMbnPinManager : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnpinmanager-getpinlist
    HRESULT GetPinList(SAFEARRAY** pinList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnpinmanager-getpin
    HRESULT GetPin(MBN_PIN_TYPE pinType, IMbnPin* pin);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnpinmanager-getpinstate
    HRESULT GetPinState(uint* requestID);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nn-mbnapi-imbnpinmanagerevents
@GUID("dcbbbab6-2006-4bbb-aaee-338e368af6fa")
interface IMbnPinManagerEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnpinmanagerevents-onpinlistavailable
    HRESULT OnPinListAvailable(IMbnPinManager pinManager);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnpinmanagerevents-ongetpinstatecomplete
    HRESULT OnGetPinStateComplete(IMbnPinManager pinManager, MBN_PIN_INFO pinInfo, uint requestID, HRESULT status);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nn-mbnapi-imbnpinevents
@GUID("dcbbbab6-2008-4bbb-aaee-338e368af6fa")
interface IMbnPinEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnpinevents-onenablecomplete
    HRESULT OnEnableComplete(IMbnPin pin, MBN_PIN_INFO* pinInfo, uint requestID, HRESULT status);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnpinevents-ondisablecomplete
    HRESULT OnDisableComplete(IMbnPin pin, MBN_PIN_INFO* pinInfo, uint requestID, HRESULT status);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnpinevents-onentercomplete
    HRESULT OnEnterComplete(IMbnPin Pin, MBN_PIN_INFO* pinInfo, uint requestID, HRESULT status);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnpinevents-onchangecomplete
    HRESULT OnChangeComplete(IMbnPin Pin, MBN_PIN_INFO* pinInfo, uint requestID, HRESULT status);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnpinevents-onunblockcomplete
    HRESULT OnUnblockComplete(IMbnPin Pin, MBN_PIN_INFO* pinInfo, uint requestID, HRESULT status);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nn-mbnapi-imbnsubscriberinformation
@GUID("459ecc43-bcf5-11dc-a8a8-001321f1405f")
interface IMbnSubscriberInformation : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnsubscriberinformation-get_subscriberid
    HRESULT get_SubscriberID(BSTR* SubscriberID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnsubscriberinformation-get_simiccid
    HRESULT get_SimIccID(BSTR* SimIccID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnsubscriberinformation-get_telephonenumbers
    HRESULT get_TelephoneNumbers(SAFEARRAY** TelephoneNumbers);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nn-mbnapi-imbnsignal
@GUID("dcbbbab6-2003-4bbb-aaee-338e368af6fa")
interface IMbnSignal : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnsignal-getsignalstrength
    HRESULT GetSignalStrength(uint* signalStrength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnsignal-getsignalerror
    HRESULT GetSignalError(uint* signalError);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nn-mbnapi-imbnsignalevents
@GUID("dcbbbab6-2004-4bbb-aaee-338e368af6fa")
interface IMbnSignalEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnsignalevents-onsignalstatechange
    HRESULT OnSignalStateChange(IMbnSignal newInterface);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nn-mbnapi-imbnconnectioncontext
@GUID("dcbbbab6-200b-4bbb-aaee-338e368af6fa")
interface IMbnConnectionContext : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnconnectioncontext-getprovisionedcontexts
    HRESULT GetProvisionedContexts(SAFEARRAY** provisionedContexts);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnconnectioncontext-setprovisionedcontext
    HRESULT SetProvisionedContext(MBN_CONTEXT provisionedContexts, const(PWSTR) providerID, uint* requestID);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nn-mbnapi-imbnconnectioncontextevents
@GUID("dcbbbab6-200c-4bbb-aaee-338e368af6fa")
interface IMbnConnectionContextEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnconnectioncontextevents-onprovisionedcontextlistchange
    HRESULT OnProvisionedContextListChange(IMbnConnectionContext newInterface);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnconnectioncontextevents-onsetprovisionedcontextcomplete
    HRESULT OnSetProvisionedContextComplete(IMbnConnectionContext newInterface, uint requestID, HRESULT status);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nn-mbnapi-imbnconnectionprofilemanager
@GUID("dcbbbab6-200f-4bbb-aaee-338e368af6fa")
interface IMbnConnectionProfileManager : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnconnectionprofilemanager-getconnectionprofiles
    HRESULT GetConnectionProfiles(IMbnInterface mbnInterface, SAFEARRAY** connectionProfiles);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnconnectionprofilemanager-getconnectionprofile
    HRESULT GetConnectionProfile(IMbnInterface mbnInterface, const(PWSTR) profileName, 
                                 IMbnConnectionProfile* connectionProfile);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnconnectionprofilemanager-createconnectionprofile
    HRESULT CreateConnectionProfile(const(PWSTR) xmlProfile);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nn-mbnapi-imbnconnectionprofile
@GUID("dcbbbab6-2010-4bbb-aaee-338e368af6fa")
interface IMbnConnectionProfile : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnconnectionprofile-getprofilexmldata
    HRESULT GetProfileXmlData(BSTR* profileData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnconnectionprofile-updateprofile
    HRESULT UpdateProfile(const(PWSTR) strProfile);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnconnectionprofile-delete
    HRESULT Delete();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nn-mbnapi-imbnconnectionprofileevents
@GUID("dcbbbab6-2011-4bbb-aaee-338e368af6fa")
interface IMbnConnectionProfileEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnconnectionprofileevents-onprofileupdate
    HRESULT OnProfileUpdate(IMbnConnectionProfile newProfile);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nn-mbnapi-imbnsmsconfiguration
@GUID("dcbbbab6-2012-4bbb-aaee-338e368af6fa")
interface IMbnSmsConfiguration : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnsmsconfiguration-get_servicecenteraddress
    HRESULT get_ServiceCenterAddress(BSTR* scAddress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnsmsconfiguration-put_servicecenteraddress
    HRESULT put_ServiceCenterAddress(const(PWSTR) scAddress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnsmsconfiguration-get_maxmessageindex
    HRESULT get_MaxMessageIndex(uint* index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnsmsconfiguration-get_cdmashortmsgsize
    HRESULT get_CdmaShortMsgSize(uint* shortMsgSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnsmsconfiguration-get_smsformat
    HRESULT get_SmsFormat(MBN_SMS_FORMAT* smsFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnsmsconfiguration-put_smsformat
    HRESULT put_SmsFormat(MBN_SMS_FORMAT smsFormat);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nn-mbnapi-imbnsmsreadmsgpdu
@GUID("dcbbbab6-2013-4bbb-aaee-338e368af6fa")
interface IMbnSmsReadMsgPdu : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnsmsreadmsgpdu-get_index
    HRESULT get_Index(uint* Index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnsmsreadmsgpdu-get_status
    HRESULT get_Status(MBN_MSG_STATUS* Status);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnsmsreadmsgpdu-get_pdudata
    HRESULT get_PduData(BSTR* PduData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnsmsreadmsgpdu-get_message
    HRESULT get_Message(SAFEARRAY** Message);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nn-mbnapi-imbnsmsreadmsgtextcdma
@GUID("dcbbbab6-2014-4bbb-aaee-338e368af6fa")
interface IMbnSmsReadMsgTextCdma : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnsmsreadmsgtextcdma-get_index
    HRESULT get_Index(uint* Index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnsmsreadmsgtextcdma-get_status
    HRESULT get_Status(MBN_MSG_STATUS* Status);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnsmsreadmsgtextcdma-get_address
    HRESULT get_Address(BSTR* Address);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnsmsreadmsgtextcdma-get_timestamp
    HRESULT get_Timestamp(BSTR* Timestamp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnsmsreadmsgtextcdma-get_encodingid
    HRESULT get_EncodingID(MBN_SMS_CDMA_ENCODING* EncodingID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnsmsreadmsgtextcdma-get_languageid
    HRESULT get_LanguageID(MBN_SMS_CDMA_LANG* LanguageID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnsmsreadmsgtextcdma-get_sizeincharacters
    HRESULT get_SizeInCharacters(uint* SizeInCharacters);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnsmsreadmsgtextcdma-get_message
    HRESULT get_Message(SAFEARRAY** Message);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nn-mbnapi-imbnsms
@GUID("dcbbbab6-2015-4bbb-aaee-338e368af6fa")
interface IMbnSms : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnsms-getsmsconfiguration
    HRESULT GetSmsConfiguration(IMbnSmsConfiguration* smsConfiguration);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnsms-setsmsconfiguration
    HRESULT SetSmsConfiguration(IMbnSmsConfiguration smsConfiguration, uint* requestID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnsms-smssendpdu
    HRESULT SmsSendPdu(const(PWSTR) pduData, ubyte size, uint* requestID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnsms-smssendcdma
    HRESULT SmsSendCdma(const(PWSTR) address, MBN_SMS_CDMA_ENCODING encoding, MBN_SMS_CDMA_LANG language, 
                        uint sizeInCharacters, SAFEARRAY* message, uint* requestID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnsms-smssendcdmapdu
    HRESULT SmsSendCdmaPdu(SAFEARRAY* message, uint* requestID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnsms-smsread
    HRESULT SmsRead(MBN_SMS_FILTER* smsFilter, MBN_SMS_FORMAT smsFormat, uint* requestID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnsms-smsdelete
    HRESULT SmsDelete(MBN_SMS_FILTER* smsFilter, uint* requestID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnsms-getsmsstatus
    HRESULT GetSmsStatus(MBN_SMS_STATUS_INFO* smsStatusInfo);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nn-mbnapi-imbnsmsevents
@GUID("dcbbbab6-2016-4bbb-aaee-338e368af6fa")
interface IMbnSmsEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnsmsevents-onsmsconfigurationchange
    HRESULT OnSmsConfigurationChange(IMbnSms sms);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnsmsevents-onsetsmsconfigurationcomplete
    HRESULT OnSetSmsConfigurationComplete(IMbnSms sms, uint requestID, HRESULT status);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnsmsevents-onsmssendcomplete
    HRESULT OnSmsSendComplete(IMbnSms sms, uint requestID, HRESULT status);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnsmsevents-onsmsreadcomplete
    HRESULT OnSmsReadComplete(IMbnSms sms, MBN_SMS_FORMAT smsFormat, SAFEARRAY* readMsgs, VARIANT_BOOL moreMsgs, 
                              uint requestID, HRESULT status);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnsmsevents-onsmsnewclass0message
    HRESULT OnSmsNewClass0Message(IMbnSms sms, MBN_SMS_FORMAT smsFormat, SAFEARRAY* readMsgs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnsmsevents-onsmsdeletecomplete
    HRESULT OnSmsDeleteComplete(IMbnSms sms, uint requestID, HRESULT status);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnsmsevents-onsmsstatuschange
    HRESULT OnSmsStatusChange(IMbnSms sms);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nn-mbnapi-imbnserviceactivation
@GUID("dcbbbab6-2017-4bbb-aaee-338e368af6fa")
interface IMbnServiceActivation : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnserviceactivation-activate
    HRESULT Activate(SAFEARRAY* vendorSpecificData, uint* requestID);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nn-mbnapi-imbnserviceactivationevents
@GUID("dcbbbab6-2018-4bbb-aaee-338e368af6fa")
interface IMbnServiceActivationEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnserviceactivationevents-onactivationcomplete
    HRESULT OnActivationComplete(IMbnServiceActivation serviceActivation, SAFEARRAY* vendorSpecificData, 
                                 uint requestID, HRESULT status, uint networkError);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nn-mbnapi-imbnvendorspecificoperation
@GUID("dcbbbab6-2019-4bbb-aaee-338e368af6fa")
interface IMbnVendorSpecificOperation : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnvendorspecificoperation-setvendorspecific
    HRESULT SetVendorSpecific(SAFEARRAY* vendorSpecificData, uint* requestID);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nn-mbnapi-imbnvendorspecificevents
@GUID("dcbbbab6-201a-4bbb-aaee-338e368af6fa")
interface IMbnVendorSpecificEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnvendorspecificevents-oneventnotification
    HRESULT OnEventNotification(IMbnVendorSpecificOperation vendorOperation, SAFEARRAY* vendorSpecificData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnvendorspecificevents-onsetvendorspecificcomplete
    HRESULT OnSetVendorSpecificComplete(IMbnVendorSpecificOperation vendorOperation, SAFEARRAY* vendorSpecificData, 
                                        uint requestID);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nn-mbnapi-imbnconnectionprofilemanagerevents
@GUID("dcbbbab6-201f-4bbb-aaee-338e368af6fa")
interface IMbnConnectionProfileManagerEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnconnectionprofilemanagerevents-onconnectionprofilearrival
    HRESULT OnConnectionProfileArrival(IMbnConnectionProfile newConnectionProfile);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnconnectionprofilemanagerevents-onconnectionprofileremoval
    HRESULT OnConnectionProfileRemoval(IMbnConnectionProfile oldConnectionProfile);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nn-mbnapi-imbnradio
@GUID("dccccab6-201f-4bbb-aaee-338e368af6fa")
interface IMbnRadio : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnradio-get_softwareradiostate
    HRESULT get_SoftwareRadioState(MBN_RADIO* SoftwareRadioState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnradio-get_hardwareradiostate
    HRESULT get_HardwareRadioState(MBN_RADIO* HardwareRadioState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnradio-setsoftwareradiostate
    HRESULT SetSoftwareRadioState(MBN_RADIO radioState, uint* requestID);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nn-mbnapi-imbnradioevents
@GUID("dcdddab6-201f-4bbb-aaee-338e368af6fa")
interface IMbnRadioEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnradioevents-onradiostatechange
    HRESULT OnRadioStateChange(IMbnRadio newInterface);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnradioevents-onsetsoftwareradiostatecomplete
    HRESULT OnSetSoftwareRadioStateComplete(IMbnRadio newInterface, uint requestID, HRESULT status);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nn-mbnapi-imbnmulticarrier
@GUID("dcbbbab6-2020-4bbb-aaee-338e368af6fa")
interface IMbnMultiCarrier : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnmulticarrier-sethomeprovider
    HRESULT SetHomeProvider(MBN_PROVIDER2* homeProvider, uint* requestID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnmulticarrier-getpreferredproviders
    HRESULT GetPreferredProviders(SAFEARRAY** preferredMulticarrierProviders);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnmulticarrier-getvisibleproviders
    HRESULT GetVisibleProviders(uint* age, SAFEARRAY** visibleProviders);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnmulticarrier-getsupportedcellularclasses
    HRESULT GetSupportedCellularClasses(SAFEARRAY** cellularClasses);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnmulticarrier-getcurrentcellularclass
    HRESULT GetCurrentCellularClass(MBN_CELLULAR_CLASS* currentCellularClass);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnmulticarrier-scannetwork
    HRESULT ScanNetwork(uint* requestID);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nn-mbnapi-imbnmulticarrierevents
@GUID("dcdddab6-2021-4bbb-aaee-338e368af6fa")
interface IMbnMultiCarrierEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnmulticarrierevents-onsethomeprovidercomplete
    HRESULT OnSetHomeProviderComplete(IMbnMultiCarrier mbnInterface, uint requestID, HRESULT status);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnmulticarrierevents-oncurrentcellularclasschange
    HRESULT OnCurrentCellularClassChange(IMbnMultiCarrier mbnInterface);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnmulticarrierevents-onpreferredproviderschange
    HRESULT OnPreferredProvidersChange(IMbnMultiCarrier mbnInterface);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnmulticarrierevents-onscannetworkcomplete
    HRESULT OnScanNetworkComplete(IMbnMultiCarrier mbnInterface, uint requestID, HRESULT status);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnmulticarrierevents-oninterfacecapabilitychange
    HRESULT OnInterfaceCapabilityChange(IMbnMultiCarrier mbnInterface);
}

@GUID("5d3ff196-89ee-49d8-8b60-33ffddffc58d")
interface IMbnDeviceServiceStateEvents : IUnknown
{
    HRESULT OnSessionsStateChange(BSTR interfaceID, MBN_DEVICE_SERVICE_SESSIONS_STATE stateChange);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nn-mbnapi-imbndeviceservicesmanager
@GUID("20a26258-6811-4478-ac1d-13324e45e41c")
interface IMbnDeviceServicesManager : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbndeviceservicesmanager-getdeviceservicescontext
    HRESULT GetDeviceServicesContext(BSTR networkInterfaceID, IMbnDeviceServicesContext* mbnDevicesContext);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nn-mbnapi-imbndeviceservicescontext
@GUID("fc5ac347-1592-4068-80bb-6a57580150d8")
interface IMbnDeviceServicesContext : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbndeviceservicescontext-enumeratedeviceservices
    HRESULT EnumerateDeviceServices(SAFEARRAY** deviceServices);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbndeviceservicescontext-getdeviceservice
    HRESULT GetDeviceService(BSTR deviceServiceID, IMbnDeviceService* mbnDeviceService);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbndeviceservicescontext-get_maxcommandsize
    HRESULT get_MaxCommandSize(uint* maxCommandSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbndeviceservicescontext-get_maxdatasize
    HRESULT get_MaxDataSize(uint* maxDataSize);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nn-mbnapi-imbndeviceservicesevents
@GUID("0a900c19-6824-4e97-b76e-cf239d0ca642")
interface IMbnDeviceServicesEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbndeviceservicesevents-onquerysupportedcommandscomplete
    HRESULT OnQuerySupportedCommandsComplete(IMbnDeviceService deviceService, SAFEARRAY* commandIDList, 
                                             HRESULT status, uint requestID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbndeviceservicesevents-onopencommandsessioncomplete
    HRESULT OnOpenCommandSessionComplete(IMbnDeviceService deviceService, HRESULT status, uint requestID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbndeviceservicesevents-onclosecommandsessioncomplete
    HRESULT OnCloseCommandSessionComplete(IMbnDeviceService deviceService, HRESULT status, uint requestID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbndeviceservicesevents-onsetcommandcomplete
    HRESULT OnSetCommandComplete(IMbnDeviceService deviceService, uint responseID, SAFEARRAY* deviceServiceData, 
                                 HRESULT status, uint requestID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbndeviceservicesevents-onquerycommandcomplete
    HRESULT OnQueryCommandComplete(IMbnDeviceService deviceService, uint responseID, SAFEARRAY* deviceServiceData, 
                                   HRESULT status, uint requestID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbndeviceservicesevents-oneventnotification
    HRESULT OnEventNotification(IMbnDeviceService deviceService, uint eventID, SAFEARRAY* deviceServiceData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbndeviceservicesevents-onopendatasessioncomplete
    HRESULT OnOpenDataSessionComplete(IMbnDeviceService deviceService, HRESULT status, uint requestID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbndeviceservicesevents-onclosedatasessioncomplete
    HRESULT OnCloseDataSessionComplete(IMbnDeviceService deviceService, HRESULT status, uint requestID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbndeviceservicesevents-onwritedatacomplete
    HRESULT OnWriteDataComplete(IMbnDeviceService deviceService, HRESULT status, uint requestID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbndeviceservicesevents-onreaddata
    HRESULT OnReadData(IMbnDeviceService deviceService, SAFEARRAY* deviceServiceData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbndeviceservicesevents-oninterfacestatechange
    HRESULT OnInterfaceStateChange(BSTR interfaceID, MBN_DEVICE_SERVICES_INTERFACE_STATE stateChange);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nn-mbnapi-imbndeviceservice
@GUID("b3bb9a71-dc70-4be9-a4da-7886ae8b191b")
interface IMbnDeviceService : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbndeviceservice-querysupportedcommands
    HRESULT QuerySupportedCommands(uint* requestID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbndeviceservice-opencommandsession
    HRESULT OpenCommandSession(uint* requestID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbndeviceservice-closecommandsession
    HRESULT CloseCommandSession(uint* requestID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbndeviceservice-setcommand
    HRESULT SetCommand(uint commandID, SAFEARRAY* deviceServiceData, uint* requestID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbndeviceservice-querycommand
    HRESULT QueryCommand(uint commandID, SAFEARRAY* deviceServiceData, uint* requestID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbndeviceservice-opendatasession
    HRESULT OpenDataSession(uint* requestID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbndeviceservice-closedatasession
    HRESULT CloseDataSession(uint* requestID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbndeviceservice-writedata
    HRESULT WriteData(SAFEARRAY* deviceServiceData, uint* requestID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbndeviceservice-get_interfaceid
    HRESULT get_InterfaceID(BSTR* InterfaceID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbndeviceservice-get_deviceserviceid
    HRESULT get_DeviceServiceID(BSTR* DeviceServiceID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbndeviceservice-get_iscommandsessionopen
    HRESULT get_IsCommandSessionOpen(BOOL* value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbndeviceservice-get_isdatasessionopen
    HRESULT get_IsDataSessionOpen(BOOL* value);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nn-mbnapi-imbnpin
@GUID("dcbbbab6-2007-4bbb-aaee-338e368af6fa")
interface IMbnPin : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnpin-get_pintype
    HRESULT get_PinType(MBN_PIN_TYPE* PinType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnpin-get_pinformat
    HRESULT get_PinFormat(MBN_PIN_FORMAT* PinFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnpin-get_pinlengthmin
    HRESULT get_PinLengthMin(uint* PinLengthMin);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnpin-get_pinlengthmax
    HRESULT get_PinLengthMax(uint* PinLengthMax);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnpin-get_pinmode
    HRESULT get_PinMode(MBN_PIN_MODE* PinMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnpin-enable
    HRESULT Enable(const(PWSTR) pin, uint* requestID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnpin-disable
    HRESULT Disable(const(PWSTR) pin, uint* requestID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnpin-enter
    HRESULT Enter(const(PWSTR) pin, uint* requestID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnpin-change
    HRESULT Change(const(PWSTR) pin, const(PWSTR) newPin, uint* requestID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnpin-unblock
    HRESULT Unblock(const(PWSTR) puk, const(PWSTR) newPin, uint* requestID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mbnapi/nf-mbnapi-imbnpin-getpinmanager
    HRESULT GetPinManager(IMbnPinManager* pinManager);
}


// GUIDs

const GUID CLSID_MbnConnectionManager        = GUIDOF!MbnConnectionManager;
const GUID CLSID_MbnConnectionProfileManager = GUIDOF!MbnConnectionProfileManager;
const GUID CLSID_MbnDeviceServicesManager    = GUIDOF!MbnDeviceServicesManager;
const GUID CLSID_MbnInterfaceManager         = GUIDOF!MbnInterfaceManager;

const GUID IID_IDummyMBNUCMExt                    = GUIDOF!IDummyMBNUCMExt;
const GUID IID_IMbnConnection                     = GUIDOF!IMbnConnection;
const GUID IID_IMbnConnectionContext              = GUIDOF!IMbnConnectionContext;
const GUID IID_IMbnConnectionContextEvents        = GUIDOF!IMbnConnectionContextEvents;
const GUID IID_IMbnConnectionEvents               = GUIDOF!IMbnConnectionEvents;
const GUID IID_IMbnConnectionManager              = GUIDOF!IMbnConnectionManager;
const GUID IID_IMbnConnectionManagerEvents        = GUIDOF!IMbnConnectionManagerEvents;
const GUID IID_IMbnConnectionProfile              = GUIDOF!IMbnConnectionProfile;
const GUID IID_IMbnConnectionProfileEvents        = GUIDOF!IMbnConnectionProfileEvents;
const GUID IID_IMbnConnectionProfileManager       = GUIDOF!IMbnConnectionProfileManager;
const GUID IID_IMbnConnectionProfileManagerEvents = GUIDOF!IMbnConnectionProfileManagerEvents;
const GUID IID_IMbnDeviceService                  = GUIDOF!IMbnDeviceService;
const GUID IID_IMbnDeviceServiceStateEvents       = GUIDOF!IMbnDeviceServiceStateEvents;
const GUID IID_IMbnDeviceServicesContext          = GUIDOF!IMbnDeviceServicesContext;
const GUID IID_IMbnDeviceServicesEvents           = GUIDOF!IMbnDeviceServicesEvents;
const GUID IID_IMbnDeviceServicesManager          = GUIDOF!IMbnDeviceServicesManager;
const GUID IID_IMbnInterface                      = GUIDOF!IMbnInterface;
const GUID IID_IMbnInterfaceEvents                = GUIDOF!IMbnInterfaceEvents;
const GUID IID_IMbnInterfaceManager               = GUIDOF!IMbnInterfaceManager;
const GUID IID_IMbnInterfaceManagerEvents         = GUIDOF!IMbnInterfaceManagerEvents;
const GUID IID_IMbnMultiCarrier                   = GUIDOF!IMbnMultiCarrier;
const GUID IID_IMbnMultiCarrierEvents             = GUIDOF!IMbnMultiCarrierEvents;
const GUID IID_IMbnPin                            = GUIDOF!IMbnPin;
const GUID IID_IMbnPinEvents                      = GUIDOF!IMbnPinEvents;
const GUID IID_IMbnPinManager                     = GUIDOF!IMbnPinManager;
const GUID IID_IMbnPinManagerEvents               = GUIDOF!IMbnPinManagerEvents;
const GUID IID_IMbnRadio                          = GUIDOF!IMbnRadio;
const GUID IID_IMbnRadioEvents                    = GUIDOF!IMbnRadioEvents;
const GUID IID_IMbnRegistration                   = GUIDOF!IMbnRegistration;
const GUID IID_IMbnRegistrationEvents             = GUIDOF!IMbnRegistrationEvents;
const GUID IID_IMbnServiceActivation              = GUIDOF!IMbnServiceActivation;
const GUID IID_IMbnServiceActivationEvents        = GUIDOF!IMbnServiceActivationEvents;
const GUID IID_IMbnSignal                         = GUIDOF!IMbnSignal;
const GUID IID_IMbnSignalEvents                   = GUIDOF!IMbnSignalEvents;
const GUID IID_IMbnSms                            = GUIDOF!IMbnSms;
const GUID IID_IMbnSmsConfiguration               = GUIDOF!IMbnSmsConfiguration;
const GUID IID_IMbnSmsEvents                      = GUIDOF!IMbnSmsEvents;
const GUID IID_IMbnSmsReadMsgPdu                  = GUIDOF!IMbnSmsReadMsgPdu;
const GUID IID_IMbnSmsReadMsgTextCdma             = GUIDOF!IMbnSmsReadMsgTextCdma;
const GUID IID_IMbnSubscriberInformation          = GUIDOF!IMbnSubscriberInformation;
const GUID IID_IMbnVendorSpecificEvents           = GUIDOF!IMbnVendorSpecificEvents;
const GUID IID_IMbnVendorSpecificOperation        = GUIDOF!IMbnVendorSpecificOperation;
