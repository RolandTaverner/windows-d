// Written in the D programming language.

module windows.win32.devices.nfc;

public import windows.core;
public import system : Guid;
public import windows.win32.foundation : BOOLEAN;

extern(Windows) @nogc nothrow:


// Enums

alias SECURE_ELEMENT_TYPE = int;
enum : int
{
    Integrated = 0x00000000,
    External   = 0x00000001,
    DeviceHost = 0x00000002,
}
alias SECURE_ELEMENT_EVENT_TYPE = int;
enum : int
{
    ExternalReaderArrival   = 0x00000000,
    ExternalReaderDeparture = 0x00000001,
    ApplicationSelected     = 0x00000002,
    Transaction             = 0x00000003,
    HceActivated            = 0x00000004,
    HceDeactivated          = 0x00000005,
    ExternalFieldEnter      = 0x00000006,
    ExternalFieldExit       = 0x00000007,
}
alias SECURE_ELEMENT_CARD_EMULATION_MODE = int;
enum : int
{
    EmulationOff                = 0x00000000,
    EmulationOnPowerIndependent = 0x00000001,
    EmulationOnPowerDependent   = 0x00000002,
    EmulationStealthListen      = 0x00000003,
}
alias SECURE_ELEMENT_ROUTING_TYPE = int;
enum : int
{
    RoutingTypeTech     = 0x00000000,
    RoutingTypeProtocol = 0x00000001,
    RoutingTypeAid      = 0x00000002,
}
alias SECURE_ELEMENT_POWER_MODE = int;
enum : int
{
    SEPowerMode_ForceOn  = 0x00000000,
    SEPowerMode_AllowOff = 0x00000001,
}
alias NFC_RF_DISCOVERY_MODE = int;
enum : int
{
    RfDiscoveryConfig = 0x00000000,
    RfDiscoveryStart  = 0x00000001,
    RFDiscoveryResume = 0x00000002,
}
alias NFC_P2P_MODE = int;
enum : int
{
    NfcDepDefault = 0x00000000,
    NfcDepPoll    = 0x00000001,
    NfcDepListen  = 0x00000002,
}
alias NFC_DEVICE_TYPE = int;
enum : int
{
    NfcType1Tag     = 0x00000000,
    NfcType2Tag     = 0x00000001,
    NfcType3Tag     = 0x00000002,
    NfcType4Tag     = 0x00000003,
    NfcIP1Target    = 0x00000004,
    NfcIP1Initiator = 0x00000005,
    NfcReader       = 0x00000006,
}
alias NFC_RELEASE_TYPE = int;
enum : int
{
    IdleMode  = 0x00000000,
    SleepMode = 0x00000001,
    Discovery = 0x00000002,
}
alias NFC_LLCP_SOCKET_TYPE = int;
enum : int
{
    ConnectionOriented = 0x00000000,
    Connectionless     = 0x00000001,
}
alias NFC_LLCP_LINK_STATUS = int;
enum : int
{
    LinkActivated   = 0x00000000,
    LinkDeactivated = 0x00000001,
}
alias NFC_LLCP_SOCKET_CONNECT_TYPE = int;
enum : int
{
    NfcConnectBySap = 0x00000000,
    NfcConnectByUri = 0x00000001,
}
alias NFC_LLCP_SOCKET_ERROR = int;
enum : int
{
    NfcLlcpErrorDisconnected     = 0x00000000,
    NfcLlcpErrorFrameRejected    = 0x00000001,
    NfcLlcpErrorBusyCondition    = 0x00000002,
    NfcLlcpErrorNotBusyCondition = 0x00000003,
}
alias NFC_SNEP_SERVER_TYPE = int;
enum : int
{
    DefaultSnepServer  = 0x00000000,
    ExtendedSnepServer = 0x00000001,
}
alias NFC_SNEP_REQUEST_TYPE = int;
enum : int
{
    SnepRequestGet = 0x00000000,
    SnepRequestPut = 0x00000001,
}
alias NFC_SE_EMULATION_MODE = int;
enum : int
{
    EmulationDisabled = 0x00000000,
    EmulationEnabled  = 0x00000001,
}

// Constants


enum GUID GUID_DEVINTERFACE_NFCDTA = GUID("7fd3f30b-5e49-4be1-b3aa-af06260d236a");

enum : uint
{
    IOCTL_NFCDTA_CONFIG_RF_DISCOVERY       = 0x00221400,
    IOCTL_NFCDTA_REMOTE_DEV_GET_NEXT       = 0x00221404,
    IOCTL_NFCDTA_REMOTE_DEV_CONNECT        = 0x00221408,
    IOCTL_NFCDTA_REMOTE_DEV_DISCONNECT     = 0x0022140c,
    IOCTL_NFCDTA_REMOTE_DEV_TRANSCEIVE     = 0x00221410,
    IOCTL_NFCDTA_REMOTE_DEV_RECV           = 0x00221414,
    IOCTL_NFCDTA_REMOTE_DEV_SEND           = 0x00221418,
    IOCTL_NFCDTA_REMOTE_DEV_CHECK_PRESENCE = 0x0022141c,
}

enum : uint
{
    IOCTL_NFCDTA_CONFIG_P2P_PARAM                  = 0x00221420,
    IOCTL_NFCDTA_SET_RF_CONFIG                     = 0x00221424,
    IOCTL_NFCDTA_REMOTE_DEV_NDEF_WRITE             = 0x00221440,
    IOCTL_NFCDTA_REMOTE_DEV_NDEF_READ              = 0x00221444,
    IOCTL_NFCDTA_REMOTE_DEV_NDEF_CONVERT_READ_ONLY = 0x00221448,
    IOCTL_NFCDTA_REMOTE_DEV_NDEF_CHECK             = 0x0022144c,
}

enum : uint
{
    IOCTL_NFCDTA_LLCP_CONFIG                = 0x00221480,
    IOCTL_NFCDTA_LLCP_ACTIVATE              = 0x00221484,
    IOCTL_NFCDTA_LLCP_DEACTIVATE            = 0x00221488,
    IOCTL_NFCDTA_LLCP_DISCOVER_SERVICES     = 0x0022148c,
    IOCTL_NFCDTA_LLCP_LINK_STATUS_CHECK     = 0x00221490,
    IOCTL_NFCDTA_LLCP_GET_NEXT_LINK_STATUS  = 0x00221494,
    IOCTL_NFCDTA_LLCP_SOCKET_CREATE         = 0x00221498,
    IOCTL_NFCDTA_LLCP_SOCKET_CLOSE          = 0x0022149c,
    IOCTL_NFCDTA_LLCP_SOCKET_BIND           = 0x002214a0,
    IOCTL_NFCDTA_LLCP_SOCKET_LISTEN         = 0x002214a4,
    IOCTL_NFCDTA_LLCP_SOCKET_ACCEPT         = 0x002214a8,
    IOCTL_NFCDTA_LLCP_SOCKET_CONNECT        = 0x002214ac,
    IOCTL_NFCDTA_LLCP_SOCKET_DISCONNECT     = 0x002214b0,
    IOCTL_NFCDTA_LLCP_SOCKET_RECV           = 0x002214b4,
    IOCTL_NFCDTA_LLCP_SOCKET_RECV_FROM      = 0x002214b8,
    IOCTL_NFCDTA_LLCP_SOCKET_SEND           = 0x002214bc,
    IOCTL_NFCDTA_LLCP_SOCKET_SNED_TO        = 0x002214c0,
    IOCTL_NFCDTA_LLCP_SOCKET_GET_NEXT_ERROR = 0x002214c4,
}

enum : uint
{
    IOCTL_NFCDTA_SNEP_INIT_SERVER                = 0x00221500,
    IOCTL_NFCDTA_SNEP_DEINIT_SERVER              = 0x00221504,
    IOCTL_NFCDTA_SNEP_SERVER_GET_NEXT_CONNECTION = 0x00221508,
    IOCTL_NFCDTA_SNEP_SERVER_ACCEPT              = 0x0022150c,
    IOCTL_NFCDTA_SNEP_SERVER_GET_NEXT_REQUEST    = 0x00221510,
    IOCTL_NFCDTA_SNEP_SERVER_SEND_RESPONSE       = 0x00221514,
    IOCTL_NFCDTA_SNEP_INIT_CLIENT                = 0x00221540,
    IOCTL_NFCDTA_SNEP_DEINIT_CLIENT              = 0x00221544,
    IOCTL_NFCDTA_SNEP_CLIENT_PUT                 = 0x00221548,
    IOCTL_NFCDTA_SNEP_CLIENT_GET                 = 0x0022154c,
    IOCTL_NFCDTA_SE_ENUMERATE                    = 0x00221580,
    IOCTL_NFCDTA_SE_SET_EMULATION_MODE           = 0x00221584,
    IOCTL_NFCDTA_SE_SET_ROUTING_TABLE            = 0x00221588,
    IOCTL_NFCDTA_SE_GET_NEXT_EVENT               = 0x0022158c,
}

enum uint MAX_ATR_LENGTH = 0x00000030;
enum uint MAX_UID_SIZE = 0x00000010;
enum uint MAX_LLCP_SERVICE_NAME_SIZE = 0x00000100;
enum uint MAX_SNEP_SERVER_NAME_SIZE = 0x00000100;
enum GUID GUID_NFC_RADIO_MEDIA_DEVICE_INTERFACE = GUID("4d51e930-750d-4a36-a9f7-91dc540fcd30");
enum GUID GUID_NFCSE_RADIO_MEDIA_DEVICE_INTERFACE = GUID("ef8ba08f-148d-4116-83ef-a2679dfc3fa5");
enum uint NFCRMDDI_IOCTL_BASE = 0x00000050;

enum : uint
{
    IOCTL_NFCRM_SET_RADIO_STATE   = 0x00510184,
    IOCTL_NFCRM_QUERY_RADIO_STATE = 0x00510188,
}

enum : uint
{
    IOCTL_NFCSERM_SET_RADIO_STATE   = 0x0051018c,
    IOCTL_NFCSERM_QUERY_RADIO_STATE = 0x00510190,
}

enum GUID GUID_DEVINTERFACE_NFCSE = GUID("8dc7c854-f5e5-4bed-815d-0c85ad047725");

enum : uint
{
    IOCTL_NFCSE_ENUM_ENDPOINTS      = 0x00220800,
    IOCTL_NFCSE_SUBSCRIBE_FOR_EVENT = 0x00220804,
}

enum : uint
{
    IOCTL_NFCSE_GET_NEXT_EVENT          = 0x00220808,
    IOCTL_NFCSE_SET_CARD_EMULATION_MODE = 0x0022080c,
}

enum : uint
{
    IOCTL_NFCSE_GET_NFCC_CAPABILITIES = 0x00220810,
    IOCTL_NFCSE_GET_ROUTING_TABLE     = 0x00220814,
    IOCTL_NFCSE_SET_ROUTING_TABLE     = 0x00220818,
    IOCTL_NFCSE_HCE_REMOTE_RECV       = 0x00220940,
    IOCTL_NFCSE_HCE_REMOTE_SEND       = 0x00220944,
    IOCTL_NFCSE_SET_POWER_MODE        = 0x00220948,
}

enum : uint
{
    EVT_TRANSACTION_TAG_AID           = 0x00000081,
    EVT_TRANSACTION_TAG_PARAMETERS    = 0x00000082,
    EVT_TRANSACTION_PARAMETER_MAX_LEN = 0x000000ff,
}

enum uint ISO_7816_MINIMUM_AID_LENGTH = 0x00000005;
enum uint ISO_7816_MAXIMUM_AID_LENGTH = 0x00000010;

// Structs


struct SECURE_ELEMENT_ENDPOINT_INFO
{
    GUID                guidSecureElementId;
    SECURE_ELEMENT_TYPE eSecureElementType;
}

struct SECURE_ELEMENT_ENDPOINT_LIST
{
    uint NumberOfEndpoints;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/SECURE_ELEMENT_ENDPOINT_INFO[1] EndpointList;
}

struct SECURE_ELEMENT_EVENT_SUBSCRIPTION_INFO
{
    GUID guidSecureElementId;
    SECURE_ELEMENT_EVENT_TYPE eEventType;
}

struct SECURE_ELEMENT_EVENT_INFO
{
    GUID guidSecureElementId;
    SECURE_ELEMENT_EVENT_TYPE eEventType;
    uint cbEventData;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] pbEventData;
}

struct SECURE_ELEMENT_SET_CARD_EMULATION_MODE_INFO
{
    GUID guidSecureElementId;
    SECURE_ELEMENT_CARD_EMULATION_MODE eMode;
}

struct SECURE_ELEMENT_NFCC_CAPABILITIES
{
    ushort  cbMaxRoutingTableSize;
    BOOLEAN IsAidRoutingSupported;
    BOOLEAN IsProtocolRoutingSupported;
    BOOLEAN IsTechRoutingSupported;
}

struct SECURE_ELEMENT_TECH_ROUTING_INFO
{
    GUID  guidSecureElementId;
    ubyte eRfTechType;
}

struct SECURE_ELEMENT_PROTO_ROUTING_INFO
{
    GUID  guidSecureElementId;
    ubyte eRfProtocolType;
}

struct SECURE_ELEMENT_AID_ROUTING_INFO
{
    GUID      guidSecureElementId;
    uint      cbAid;
    ubyte[16] pbAid;
}

struct SECURE_ELEMENT_ROUTING_TABLE_ENTRY
{
    SECURE_ELEMENT_ROUTING_TYPE eRoutingType;
    _Anonymous_e__Union Anonymous;
}

struct SECURE_ELEMENT_ROUTING_TABLE
{
    uint NumberOfEntries;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/SECURE_ELEMENT_ROUTING_TABLE_ENTRY[1] TableEntries;
}

struct SECURE_ELEMENT_HCE_ACTIVATION_PAYLOAD
{
    ushort bConnectionId;
    ubyte  eRfTechType;
    ubyte  eRfProtocolType;
}

struct SECURE_ELEMENT_HCE_DATA_PACKET
{
    ushort bConnectionId;
    ushort cbPayload;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] pbPayload;
}

struct SECURE_ELEMENT_SET_POWER_MODE_INFO
{
    GUID guidSecureElementId;
    SECURE_ELEMENT_POWER_MODE powerMode;
}

struct NFC_RF_DISCOVERY_CONFIG
{
    ushort   usTotalDuration;
    uint     ulPollConfig;
    BOOLEAN  fDisableCardEmulation;
    ubyte    ucNfcIPMode;
    BOOLEAN  fNfcIPTgtModeDisable;
    ubyte    ucNfcIPTgtMode;
    ubyte    ucNfcCEMode;
    ubyte    ucBailoutConfig;
    ubyte[2] ucSystemCode;
    ubyte    ucRequestCode;
    ubyte    ucTimeSlotNumber;
    NFC_RF_DISCOVERY_MODE eRfDiscoveryMode;
}

struct NFC_P2P_PARAM_CONFIG
{
    NFC_P2P_MODE eP2pMode;
    ubyte        cbGeneralBytes;
    ubyte[48]    pbGeneralBytes;
}

struct NFC_REMOTE_DEV_INFO
{
    ptrdiff_t       hRemoteDev;
    NFC_DEVICE_TYPE eType;
    ubyte           eRFTech;
    ubyte           eProtocol;
    ubyte           cbUid;
    ubyte[16]       pbUid;
}

struct NFC_REMOTE_DEVICE_DISCONNET
{
    ptrdiff_t        hRemoteDev;
    NFC_RELEASE_TYPE eReleaseType;
}

struct NFC_DATA_BUFFER
{
    ushort cbBuffer;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] pbBuffer;
}

struct NFC_REMOTE_DEV_SEND_INFO
{
    ptrdiff_t       hRemoteDev;
    ushort          usTimeOut;
    NFC_DATA_BUFFER sSendBuffer;
}

struct NFC_REMOTE_DEV_RECV_INFO
{
    ptrdiff_t       hRemoteDev;
    NFC_DATA_BUFFER sRecvBuffer;
}

struct NFC_NDEF_INFO
{
    BOOLEAN fIsNdefFormatted;
    BOOLEAN fIsReadOnly;
    uint    dwActualMessageLength;
    uint    dwMaxMessageLength;
}

struct NFC_LLCP_SOCKET_OPTION
{
    ushort uMIUX;
    ubyte  bRW;
}

struct NFC_LLCP_CONFIG
{
    ushort  uMIU;
    ushort  uWKS;
    ubyte   bLTO;
    ubyte   bOptions;
    BOOLEAN fAutoActivate;
}

struct NFC_LLCP_SERVICE_NAME_ENTRY
{
    uint cbServiceName;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] pbServiceName;
}

struct NFC_LLCP_SERVICE_DISCOVER_REQUEST
{
    ptrdiff_t hRemoteDev;
    uint      NumberOfEntries;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/NFC_LLCP_SERVICE_NAME_ENTRY[1] ServiceNameEntries;
}

struct NFC_LLCP_SERVICE_DISCOVER_SAP
{
    uint NumberOfEntries;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] SAPEntries;
}

struct NFC_LLCP_SOCKET_INFO
{
    NFC_LLCP_SOCKET_TYPE eSocketType;
    NFC_LLCP_SOCKET_OPTION sSocketOption;
}

struct NFC_LLCP_SOCKET_SERVICE_INFO
{
    ptrdiff_t hSocket;
    ubyte     bSAP;
    NFC_LLCP_SERVICE_NAME_ENTRY sServiceName;
}

struct NFC_LLCP_SOCKET_PAYLOAD
{
    ptrdiff_t       hSocket;
    ubyte           bSAP;
    NFC_DATA_BUFFER sPayload;
}

struct NFC_LLCP_SOCKET_ACCEPT_INFO
{
    ptrdiff_t hSocket;
    NFC_LLCP_SOCKET_OPTION sSocketOption;
}

struct NFC_LLCP_SOCKET_CONNECT_INFO
{
    ptrdiff_t           hRemoteDev;
    ptrdiff_t           hSocket;
    NFC_LLCP_SOCKET_CONNECT_TYPE eConnectType;
    _Anonymous_e__Union Anonymous;
}

struct NFC_LLCP_SOCKET_CL_PAYLOAD
{
    ptrdiff_t       hSocket;
    ubyte           bSAP;
    NFC_DATA_BUFFER sPayload;
}

struct NFC_LLCP_SOCKET_ERROR_INFO
{
    ptrdiff_t hSocket;
    NFC_LLCP_SOCKET_ERROR eSocketError;
}

struct NFC_SNEP_SERVER_INFO
{
    NFC_SNEP_SERVER_TYPE eServerType;
    NFC_LLCP_SOCKET_OPTION sSocketOption;
    ushort               usInboxSize;
    ubyte                bSAP;
    NFC_LLCP_SERVICE_NAME_ENTRY sService;
}

struct NFC_SNEP_SERVER_ACCEPT_INFO
{
    ptrdiff_t hSnepServer;
    ptrdiff_t hConnection;
    NFC_LLCP_SOCKET_OPTION sSocketOption;
}

struct NFC_SNEP_SERVER_REQUEST
{
    ptrdiff_t       hSnepServer;
    ptrdiff_t       hConnection;
    NFC_SNEP_REQUEST_TYPE eRequestType;
    NFC_DATA_BUFFER sRequestPayload;
}

struct NFC_SNEP_SERVER_RESPONSE_INFO
{
    ptrdiff_t       hSnepServer;
    ptrdiff_t       hConnection;
    uint            dwResponseStatus;
    NFC_DATA_BUFFER sResponsePayload;
}

struct NFC_SNEP_CLIENT_INFO
{
    ptrdiff_t            hRemoteDev;
    NFC_SNEP_SERVER_TYPE eServerType;
    NFC_LLCP_SOCKET_OPTION sSocketOption;
    NFC_LLCP_SERVICE_NAME_ENTRY sService;
}

struct NFC_SNEP_CLIENT_PUT_INFO
{
    ptrdiff_t       hSnepClient;
    NFC_DATA_BUFFER sPutPayload;
}

struct NFC_SNEP_CLIENT_GET_INFO
{
    ptrdiff_t       hSnepClient;
    NFC_DATA_BUFFER sGetPayload;
}

struct NFC_SE_INFO
{
    ptrdiff_t           hSecureElement;
    SECURE_ELEMENT_TYPE eSecureElementType;
}

struct NFC_SE_LIST
{
    uint NumberOfEndpoints;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/NFC_SE_INFO[1] EndpointList;
}

struct NFC_SE_EMULATION_MODE_INFO
{
    ptrdiff_t hSecureElement;
    NFC_SE_EMULATION_MODE eMode;
}

struct NFC_SE_TECH_ROUTING_INFO
{
    ptrdiff_t hSecureElement;
    ubyte     bPowerState;
    ubyte     eRfTechType;
}

struct NFC_SE_PROTO_ROUTING_INFO
{
    ptrdiff_t hSecureElement;
    ubyte     bPowerState;
    ubyte     eRfProtocolType;
}

struct NFC_SE_AID_ROUTING_INFO
{
    ptrdiff_t hSecureElement;
    ubyte     bPowerState;
    uint      cbAid;
    ubyte[16] pbAid;
}

struct NFC_SE_ROUTING_TABLE_ENTRY
{
    SECURE_ELEMENT_ROUTING_TYPE eRoutingType;
    _Anonymous_e__Union Anonymous;
}

struct NFC_SE_ROUTING_TABLE
{
    uint NumberOfEntries;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/NFC_SE_ROUTING_TABLE_ENTRY[1] TableEntries;
}

struct NFC_SE_EVENT_INFO
{
    ptrdiff_t hSecureElement;
    SECURE_ELEMENT_EVENT_TYPE eEventType;
    uint      cbEventData;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] pbEventData;
}

struct NFCRM_SET_RADIO_STATE
{
    BOOLEAN SystemStateUpdate;
    BOOLEAN MediaRadioOn;
}

struct NFCRM_RADIO_STATE
{
    BOOLEAN MediaRadioOn;
}

