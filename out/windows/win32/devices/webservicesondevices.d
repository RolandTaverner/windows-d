// Written in the D programming language.

module windows.win32.devices.webservicesondevices;

public import windows.core;
public import system : Guid;
public import windows.win32.foundation : BOOL, HANDLE, HRESULT, PWSTR;
public import windows.win32.networking.winsock : SOCKADDR_STORAGE;
public import windows.win32.security.cryptography : CERT_CONTEXT, HCERTSTORE;
public import windows.win32.system.com : IUnknown;

extern(Windows) @nogc nothrow:


// Enums

//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/ne-wsdbase-wsd_config_param_type))], [])
alias WSD_CONFIG_PARAM_TYPE = int;
enum : int
{
    WSD_CONFIG_MAX_INBOUND_MESSAGE_SIZE                  = 0x00000001,
    WSD_CONFIG_MAX_OUTBOUND_MESSAGE_SIZE                 = 0x00000002,
    WSD_SECURITY_SSL_CERT_FOR_CLIENT_AUTH                = 0x00000003,
    WSD_SECURITY_SSL_SERVER_CERT_VALIDATION              = 0x00000004,
    WSD_SECURITY_SSL_CLIENT_CERT_VALIDATION              = 0x00000005,
    WSD_SECURITY_SSL_NEGOTIATE_CLIENT_CERT               = 0x00000006,
    WSD_SECURITY_COMPACTSIG_SIGNING_CERT                 = 0x00000007,
    WSD_SECURITY_COMPACTSIG_VALIDATION                   = 0x00000008,
    WSD_CONFIG_HOSTING_ADDRESSES                         = 0x00000009,
    WSD_CONFIG_DEVICE_ADDRESSES                          = 0x0000000a,
    WSD_SECURITY_REQUIRE_HTTP_CLIENT_AUTH                = 0x0000000b,
    WSD_SECURITY_REQUIRE_CLIENT_CERT_OR_HTTP_CLIENT_AUTH = 0x0000000c,
    WSD_SECURITY_USE_HTTP_CLIENT_AUTH                    = 0x0000000d,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/ne-wsdbase-wsdudpmessagetype))], [])
enum WSDUdpMessageType : int
{
    ONE_WAY = 0x00000000,
    TWO_WAY = 0x00000001,
}
alias WSDXML_OP = int;
enum : int
{
    OpNone                  = 0x00000000,
    OpEndOfTable            = 0x00000001,
    OpBeginElement_         = 0x00000002,
    OpBeginAnyElement       = 0x00000003,
    OpEndElement            = 0x00000004,
    OpElement_              = 0x00000005,
    OpAnyElement            = 0x00000006,
    OpAnyElements           = 0x00000007,
    OpAnyText               = 0x00000008,
    OpAttribute_            = 0x00000009,
    OpBeginChoice           = 0x0000000a,
    OpEndChoice             = 0x0000000b,
    OpBeginSequence         = 0x0000000c,
    OpEndSequence           = 0x0000000d,
    OpBeginAll              = 0x0000000e,
    OpEndAll                = 0x0000000f,
    OpAnything              = 0x00000010,
    OpAnyNumber             = 0x00000011,
    OpOneOrMore             = 0x00000012,
    OpOptional              = 0x00000013,
    OpFormatBool_           = 0x00000014,
    OpFormatInt8_           = 0x00000015,
    OpFormatInt16_          = 0x00000016,
    OpFormatInt32_          = 0x00000017,
    OpFormatInt64_          = 0x00000018,
    OpFormatUInt8_          = 0x00000019,
    OpFormatUInt16_         = 0x0000001a,
    OpFormatUInt32_         = 0x0000001b,
    OpFormatUInt64_         = 0x0000001c,
    OpFormatUnicodeString_  = 0x0000001d,
    OpFormatDom_            = 0x0000001e,
    OpFormatStruct_         = 0x0000001f,
    OpFormatUri_            = 0x00000020,
    OpFormatUuidUri_        = 0x00000021,
    OpFormatName_           = 0x00000022,
    OpFormatListInsertTail_ = 0x00000023,
    OpFormatType_           = 0x00000024,
    OpFormatDynamicType_    = 0x00000025,
    OpFormatLookupType_     = 0x00000026,
    OpFormatDuration_       = 0x00000027,
    OpFormatDateTime_       = 0x00000028,
    OpFormatFloat_          = 0x00000029,
    OpFormatDouble_         = 0x0000002a,
    OpProcess_              = 0x0000002b,
    OpQualifiedAttribute_   = 0x0000002c,
    OpFormatXMLDeclaration_ = 0x0000002d,
    OpFormatMax             = 0x0000002e,
}
enum DeviceDiscoveryMechanism : int
{
    MulticastDiscovery      = 0x00000000,
    DirectedDiscovery       = 0x00000001,
    SecureDirectedDiscovery = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ne-wsdtypes-wsd_protocol_type))], [])
alias WSD_PROTOCOL_TYPE = int;
enum : int
{
    WSD_PT_NONE  = 0x00000000,
    WSD_PT_UDP   = 0x00000001,
    WSD_PT_HTTP  = 0x00000002,
    WSD_PT_HTTPS = 0x00000004,
    WSD_PT_ALL   = 0x000000ff,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ne-wsdtypes-wsdeventtype))], [])
enum WSDEventType : int
{
    WSDET_NONE                 = 0x00000000,
    WSDET_INCOMING_MESSAGE     = 0x00000001,
    WSDET_INCOMING_FAULT       = 0x00000002,
    WSDET_TRANSMISSION_FAILURE = 0x00000003,
    WSDET_RESPONSE_TIMEOUT     = 0x00000004,
}

// Constants


enum : const(wchar)*
{
    WSD_DEFAULT_HOSTING_ADDRESS        = "http://*:5357/",
    WSD_DEFAULT_SECURE_HOSTING_ADDRESS = "https://*:5358/",
}

enum const(wchar)* WSD_DEFAULT_EVENTING_ADDRESS = "http://*:5357/";
enum uint WSDAPI_OPTION_MAX_INBOUND_MESSAGE_SIZE = 0x00000001;

enum : uint
{
    WSDAPI_OPTION_TRACE_XML_TO_DEBUGGER = 0x00000002,
    WSDAPI_OPTION_TRACE_XML_TO_FILE     = 0x00000003,
}

enum : uint
{
    WSDAPI_SSL_CERT_APPLY_DEFAULT_CHECKS = 0x00000000,
    WSDAPI_SSL_CERT_IGNORE_REVOCATION    = 0x00000001,
    WSDAPI_SSL_CERT_IGNORE_EXPIRY        = 0x00000002,
    WSDAPI_SSL_CERT_IGNORE_WRONG_USAGE   = 0x00000004,
    WSDAPI_SSL_CERT_IGNORE_UNKNOWN_CA    = 0x00000008,
    WSDAPI_SSL_CERT_IGNORE_INVALID_CN    = 0x00000010,
}

enum uint WSDAPI_COMPACTSIG_ACCEPT_ALL_MESSAGES = 0x00000001;

enum : uint
{
    WSD_SECURITY_HTTP_AUTH_SCHEME_NEGOTIATE = 0x00000001,
    WSD_SECURITY_HTTP_AUTH_SCHEME_NTLM      = 0x00000002,
}

enum : uint
{
    WSDAPI_ADDRESSFAMILY_IPV4 = 0x00000001,
    WSDAPI_ADDRESSFAMILY_IPV6 = 0x00000002,
}

// Callbacks

alias WSD_STUB_FUNCTION = HRESULT function(IUnknown server, IWSDServiceMessaging session, WSD_EVENT* event);
alias PWSD_SOAP_MESSAGE_HANDLER = HRESULT function(IUnknown thisUnknown, WSD_EVENT* event);

// Structs


//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/ns-wsdbase-wsd_config_param))], [])
struct WSD_CONFIG_PARAM
{
    WSD_CONFIG_PARAM_TYPE configParamType;
    void* pConfigData;
    uint  dwConfigDataSize;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/ns-wsdbase-wsd_security_cert_validation_v1))], [])
struct WSD_SECURITY_CERT_VALIDATION_V1
{
    CERT_CONTEXT** certMatchArray;
    uint           dwCertMatchArrayCount;
    HCERTSTORE     hCertMatchStore;
    HCERTSTORE     hCertIssuerStore;
    uint           dwCertCheckOptions;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/ns-wsdbase-wsd_security_cert_validation))], [])
struct WSD_SECURITY_CERT_VALIDATION
{
    CERT_CONTEXT** certMatchArray;
    uint           dwCertMatchArrayCount;
    HCERTSTORE     hCertMatchStore;
    HCERTSTORE     hCertIssuerStore;
    uint           dwCertCheckOptions;
    const(PWSTR)   pszCNGHashAlgId;
    ubyte*         pbCertHash;
    uint           dwCertHashSize;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/ns-wsdbase-wsd_security_signature_validation))], [])
struct WSD_SECURITY_SIGNATURE_VALIDATION
{
    CERT_CONTEXT** signingCertArray;
    uint           dwSigningCertArrayCount;
    HCERTSTORE     hSigningCertStore;
    uint           dwFlags;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/ns-wsdbase-wsd_config_addresses))], [])
struct WSD_CONFIG_ADDRESSES
{
    IWSDAddress* addresses;
    uint         dwAddressCount;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/ns-wsdbase-wsdudpretransmitparams))], [])
struct WSDUdpRetransmitParams
{
    uint ulSendDelay;
    uint ulRepeat;
    uint ulRepeatMinDelay;
    uint ulRepeatMaxDelay;
    uint ulRepeatUpperDelay;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdxml/ns-wsdxml-wsd_datetime))], [])
struct WSD_DATETIME
{
    BOOL  isPositive;
    uint  year;
    ubyte month;
    ubyte day;
    ubyte hour;
    ubyte minute;
    ubyte second;
    uint  millisecond;
    BOOL  TZIsLocal;
    BOOL  TZIsPositive;
    ubyte TZHour;
    ubyte TZMinute;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdxml/ns-wsdxml-wsd_duration))], [])
struct WSD_DURATION
{
    BOOL isPositive;
    uint year;
    uint month;
    uint day;
    uint hour;
    uint minute;
    uint second;
    uint millisecond;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdxmldom/ns-wsdxmldom-wsdxml_namespace))], [])
struct WSDXML_NAMESPACE
{
    const(PWSTR) Uri;
    const(PWSTR) PreferredPrefix;
    WSDXML_NAME* Names;
    ushort       NamesCount;
    ushort       Encoding;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdxmldom/ns-wsdxmldom-wsdxml_name))], [])
struct WSDXML_NAME
{
    WSDXML_NAMESPACE* Space;
    PWSTR             LocalName;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdxmldom/ns-wsdxmldom-wsdxml_type))], [])
struct WSDXML_TYPE
{
    const(PWSTR)  Uri;
    const(ubyte)* Table;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdxmldom/ns-wsdxmldom-wsdxml_prefix_mapping))], [])
struct WSDXML_PREFIX_MAPPING
{
    uint              Refs;
    WSDXML_PREFIX_MAPPING* Next;
    WSDXML_NAMESPACE* Space;
    PWSTR             Prefix;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdxmldom/ns-wsdxmldom-wsdxml_attribute))], [])
struct WSDXML_ATTRIBUTE
{
    WSDXML_ELEMENT*   Element;
    WSDXML_ATTRIBUTE* Next;
    WSDXML_NAME*      Name;
    PWSTR             Value;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdxmldom/ns-wsdxmldom-wsdxml_node))], [])
struct WSDXML_NODE
{
    int             Type;
    WSDXML_ELEMENT* Parent;
    WSDXML_NODE*    Next;
    int             ElementType = 0x00000000;
    int             TextType    = 0x00000001;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdxmldom/ns-wsdxmldom-wsdxml_element))], [])
struct WSDXML_ELEMENT
{
    WSDXML_NODE       Node;
    WSDXML_NAME*      Name;
    WSDXML_ATTRIBUTE* FirstAttribute;
    WSDXML_NODE*      FirstChild;
    WSDXML_PREFIX_MAPPING* PrefixMappings;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdxmldom/ns-wsdxmldom-wsdxml_text))], [])
struct WSDXML_TEXT
{
    WSDXML_NODE Node;
    PWSTR       Text;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdxmldom/ns-wsdxmldom-wsdxml_element_list))], [])
struct WSDXML_ELEMENT_LIST
{
    WSDXML_ELEMENT_LIST* Next;
    WSDXML_ELEMENT*      Element;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-wsd_operation))], [])
struct WSD_OPERATION
{
    WSDXML_TYPE*      RequestType;
    WSDXML_TYPE*      ResponseType;
    WSD_STUB_FUNCTION RequestStubFunction;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-wsd_handler_context))], [])
struct WSD_HANDLER_CONTEXT
{
    PWSD_SOAP_MESSAGE_HANDLER Handler;
    void*    PVoid;
    IUnknown Unknown;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-wsd_synchronous_response_context))], [])
struct WSD_SYNCHRONOUS_RESPONSE_CONTEXT
{
    HRESULT hr;
    HANDLE  eventHandle;
    IWSDMessageParameters messageParameters;
    void*   results;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-wsd_port_type))], [])
struct WSD_PORT_TYPE
{
    uint              EncodedName;
    uint              OperationCount;
    WSD_OPERATION*    Operations;
    WSD_PROTOCOL_TYPE ProtocolType;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-wsd_relationship_metadata))], [])
struct WSD_RELATIONSHIP_METADATA
{
    const(PWSTR)       Type;
    WSD_HOST_METADATA* Data;
    WSDXML_ELEMENT*    Any;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-wsd_service_metadata_list))], [])
struct WSD_SERVICE_METADATA_LIST
{
    WSD_SERVICE_METADATA_LIST* Next;
    WSD_SERVICE_METADATA* Element;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-wsd_host_metadata))], [])
struct WSD_HOST_METADATA
{
    WSD_SERVICE_METADATA* Host;
    WSD_SERVICE_METADATA_LIST* Hosted;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-wsd_endpoint_reference_list))], [])
struct WSD_ENDPOINT_REFERENCE_LIST
{
    WSD_ENDPOINT_REFERENCE_LIST* Next;
    WSD_ENDPOINT_REFERENCE* Element;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-wsd_service_metadata))], [])
struct WSD_SERVICE_METADATA
{
    WSD_ENDPOINT_REFERENCE_LIST* EndpointReference;
    WSD_NAME_LIST*  Types;
    const(PWSTR)    ServiceId;
    WSDXML_ELEMENT* Any;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-wsd_this_device_metadata))], [])
struct WSD_THIS_DEVICE_METADATA
{
    WSD_LOCALIZED_STRING_LIST* FriendlyName;
    const(PWSTR)    FirmwareVersion;
    const(PWSTR)    SerialNumber;
    WSDXML_ELEMENT* Any;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-wsd_this_model_metadata))], [])
struct WSD_THIS_MODEL_METADATA
{
    WSD_LOCALIZED_STRING_LIST* Manufacturer;
    const(PWSTR)    ManufacturerUrl;
    WSD_LOCALIZED_STRING_LIST* ModelName;
    const(PWSTR)    ModelNumber;
    const(PWSTR)    ModelUrl;
    const(PWSTR)    PresentationUrl;
    WSDXML_ELEMENT* Any;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-wsd_localized_string_list))], [])
struct WSD_LOCALIZED_STRING_LIST
{
    WSD_LOCALIZED_STRING_LIST* Next;
    WSD_LOCALIZED_STRING* Element;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-wsd_soap_fault_reason))], [])
struct WSD_SOAP_FAULT_REASON
{
    WSD_LOCALIZED_STRING_LIST* Text;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-wsd_soap_fault_subcode))], [])
struct WSD_SOAP_FAULT_SUBCODE
{
    WSDXML_NAME* Value;
    WSD_SOAP_FAULT_SUBCODE* Subcode;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-wsd_soap_fault_code))], [])
struct WSD_SOAP_FAULT_CODE
{
    WSDXML_NAME* Value;
    WSD_SOAP_FAULT_SUBCODE* Subcode;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-wsd_soap_fault))], [])
struct WSD_SOAP_FAULT
{
    WSD_SOAP_FAULT_CODE* Code;
    WSD_SOAP_FAULT_REASON* Reason;
    const(PWSTR)         Node;
    const(PWSTR)         Role;
    WSDXML_ELEMENT*      Detail;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-wsd_app_sequence))], [])
struct WSD_APP_SEQUENCE
{
    ulong        InstanceId;
    const(PWSTR) SequenceId;
    ulong        MessageNumber;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-wsd_header_relatesto))], [])
struct WSD_HEADER_RELATESTO
{
    WSDXML_NAME* RelationshipType;
    const(PWSTR) MessageID;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-wsd_soap_header))], [])
struct WSD_SOAP_HEADER
{
    const(PWSTR)         To;
    const(PWSTR)         Action;
    const(PWSTR)         MessageID;
    WSD_HEADER_RELATESTO RelatesTo;
    WSD_ENDPOINT_REFERENCE* ReplyTo;
    WSD_ENDPOINT_REFERENCE* From;
    WSD_ENDPOINT_REFERENCE* FaultTo;
    WSD_APP_SEQUENCE*    AppSequence;
    WSDXML_ELEMENT*      AnyHeaders;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-wsd_soap_message))], [])
struct WSD_SOAP_MESSAGE
{
    WSD_SOAP_HEADER Header;
    void*           Body;
    WSDXML_TYPE*    BodyType;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-wsd_resolve_matches))], [])
struct WSD_RESOLVE_MATCHES
{
    WSD_RESOLVE_MATCH* ResolveMatch;
    WSDXML_ELEMENT*    Any;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-wsd_resolve_match))], [])
struct WSD_RESOLVE_MATCH
{
    WSD_ENDPOINT_REFERENCE* EndpointReference;
    WSD_NAME_LIST*  Types;
    WSD_SCOPES*     Scopes;
    WSD_URI_LIST*   XAddrs;
    ulong           MetadataVersion;
    WSDXML_ELEMENT* Any;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-wsd_resolve))], [])
struct WSD_RESOLVE
{
    WSD_ENDPOINT_REFERENCE* EndpointReference;
    WSDXML_ELEMENT* Any;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-wsd_probe_match))], [])
struct WSD_PROBE_MATCH
{
    WSD_ENDPOINT_REFERENCE* EndpointReference;
    WSD_NAME_LIST*  Types;
    WSD_SCOPES*     Scopes;
    WSD_URI_LIST*   XAddrs;
    ulong           MetadataVersion;
    WSDXML_ELEMENT* Any;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-wsd_probe_match_list))], [])
struct WSD_PROBE_MATCH_LIST
{
    WSD_PROBE_MATCH_LIST* Next;
    WSD_PROBE_MATCH* Element;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-wsd_probe_matches))], [])
struct WSD_PROBE_MATCHES
{
    WSD_PROBE_MATCH_LIST* ProbeMatch;
    WSDXML_ELEMENT* Any;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-wsd_probe))], [])
struct WSD_PROBE
{
    WSD_NAME_LIST*  Types;
    WSD_SCOPES*     Scopes;
    WSDXML_ELEMENT* Any;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-wsd_bye))], [])
struct WSD_BYE
{
    WSD_ENDPOINT_REFERENCE* EndpointReference;
    WSDXML_ELEMENT* Any;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-wsd_scopes))], [])
struct WSD_SCOPES
{
    const(PWSTR)  MatchBy;
    WSD_URI_LIST* Scopes;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-wsd_name_list))], [])
struct WSD_NAME_LIST
{
    WSD_NAME_LIST* Next;
    WSDXML_NAME*   Element;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-wsd_hello))], [])
struct WSD_HELLO
{
    WSD_ENDPOINT_REFERENCE* EndpointReference;
    WSD_NAME_LIST*  Types;
    WSD_SCOPES*     Scopes;
    WSD_URI_LIST*   XAddrs;
    ulong           MetadataVersion;
    WSDXML_ELEMENT* Any;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-wsd_reference_parameters))], [])
struct WSD_REFERENCE_PARAMETERS
{
    WSDXML_ELEMENT* Any;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-wsd_reference_properties))], [])
struct WSD_REFERENCE_PROPERTIES
{
    WSDXML_ELEMENT* Any;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-wsd_endpoint_reference))], [])
struct WSD_ENDPOINT_REFERENCE
{
    const(PWSTR)    Address;
    WSD_REFERENCE_PROPERTIES ReferenceProperties;
    WSD_REFERENCE_PARAMETERS ReferenceParameters;
    WSDXML_NAME*    PortType;
    WSDXML_NAME*    ServiceName;
    WSDXML_ELEMENT* Any;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-wsd_metadata_section))], [])
struct WSD_METADATA_SECTION
{
    const(PWSTR)    Dialect;
    const(PWSTR)    Identifier;
    void*           Data;
    WSD_ENDPOINT_REFERENCE* MetadataReference;
    const(PWSTR)    Location;
    WSDXML_ELEMENT* Any;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-wsd_metadata_section_list))], [])
struct WSD_METADATA_SECTION_LIST
{
    WSD_METADATA_SECTION_LIST* Next;
    WSD_METADATA_SECTION* Element;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-wsd_uri_list))], [])
struct WSD_URI_LIST
{
    WSD_URI_LIST* Next;
    const(PWSTR)  Element;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-wsd_eventing_filter_action))], [])
struct WSD_EVENTING_FILTER_ACTION
{
    WSD_URI_LIST* Actions;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-wsd_eventing_filter))], [])
struct WSD_EVENTING_FILTER
{
    const(PWSTR) Dialect;
    WSD_EVENTING_FILTER_ACTION* FilterAction;
    void*        Data;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-wsd_eventing_expires))], [])
struct WSD_EVENTING_EXPIRES
{
    WSD_DURATION* Duration;
    WSD_DATETIME* DateTime;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-wsd_eventing_delivery_mode_push))], [])
struct WSD_EVENTING_DELIVERY_MODE_PUSH
{
    WSD_ENDPOINT_REFERENCE* NotifyTo;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-wsd_eventing_delivery_mode))], [])
struct WSD_EVENTING_DELIVERY_MODE
{
    const(PWSTR) Mode;
    WSD_EVENTING_DELIVERY_MODE_PUSH* Push;
    void*        Data;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-wsd_localized_string))], [])
struct WSD_LOCALIZED_STRING
{
    const(PWSTR) lang;
    const(PWSTR) String;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-responsebody_getmetadata))], [])
struct RESPONSEBODY_GetMetadata
{
    WSD_METADATA_SECTION_LIST* Metadata;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-requestbody_subscribe))], [])
struct REQUESTBODY_Subscribe
{
    WSD_ENDPOINT_REFERENCE* EndTo;
    WSD_EVENTING_DELIVERY_MODE* Delivery;
    WSD_EVENTING_EXPIRES* Expires;
    WSD_EVENTING_FILTER* Filter;
    WSDXML_ELEMENT*      Any;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-responsebody_subscribe))], [])
struct RESPONSEBODY_Subscribe
{
    WSD_ENDPOINT_REFERENCE* SubscriptionManager;
    WSD_EVENTING_EXPIRES* expires;
    WSDXML_ELEMENT* any;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-requestbody_renew))], [])
struct REQUESTBODY_Renew
{
    WSD_EVENTING_EXPIRES* Expires;
    WSDXML_ELEMENT* Any;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-responsebody_renew))], [])
struct RESPONSEBODY_Renew
{
    WSD_EVENTING_EXPIRES* expires;
    WSDXML_ELEMENT* any;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-requestbody_getstatus))], [])
struct REQUESTBODY_GetStatus
{
    WSDXML_ELEMENT* Any;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-responsebody_getstatus))], [])
struct RESPONSEBODY_GetStatus
{
    WSD_EVENTING_EXPIRES* expires;
    WSDXML_ELEMENT* any;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-requestbody_unsubscribe))], [])
struct REQUESTBODY_Unsubscribe
{
    WSDXML_ELEMENT* any;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-responsebody_subscriptionend))], [])
struct RESPONSEBODY_SubscriptionEnd
{
    WSD_ENDPOINT_REFERENCE* SubscriptionManager;
    const(PWSTR)    Status;
    WSD_LOCALIZED_STRING* Reason;
    WSDXML_ELEMENT* Any;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-wsd_unknown_lookup))], [])
struct WSD_UNKNOWN_LOOKUP
{
    WSDXML_ELEMENT* Any;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdtypes/ns-wsdtypes-wsd_event))], [])
struct WSD_EVENT
{
    HRESULT             Hr;
    uint                EventType;
    PWSTR               DispatchTag;
    WSD_HANDLER_CONTEXT HandlerContext;
    WSD_SOAP_MESSAGE*   Soap;
    WSD_OPERATION*      Operation;
    IWSDMessageParameters MessageParameters;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wsdapi.dll")
HRESULT WSDCreateUdpMessageParameters(IWSDUdpMessageParameters* ppTxParams);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wsdapi.dll")
HRESULT WSDCreateUdpAddress(IWSDUdpAddress* ppAddress);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wsdapi.dll")
HRESULT WSDCreateHttpMessageParameters(IWSDHttpMessageParameters* ppTxParams);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wsdapi.dll")
HRESULT WSDCreateHttpAddress(IWSDHttpAddress* ppAddress);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wsdapi.dll")
HRESULT WSDCreateOutboundAttachment(IWSDOutboundAttachment* ppAttachment);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wsdapi.dll")
HRESULT WSDXMLGetNameFromBuiltinNamespace(const(PWSTR) pszNamespace, const(PWSTR) pszName, WSDXML_NAME** ppName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wsdapi.dll")
HRESULT WSDXMLCreateContext(IWSDXMLContext* ppContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wsdapi.dll")
HRESULT WSDCreateDiscoveryProvider(IWSDXMLContext pContext, IWSDiscoveryProvider* ppProvider);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("wsdapi.dll")
HRESULT WSDCreateDiscoveryProvider2(IWSDXMLContext pContext, WSD_CONFIG_PARAM* pConfigParams, 
                                    uint dwConfigParamCount, IWSDiscoveryProvider* ppProvider);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wsdapi.dll")
HRESULT WSDCreateDiscoveryPublisher(IWSDXMLContext pContext, IWSDiscoveryPublisher* ppPublisher);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("wsdapi.dll")
HRESULT WSDCreateDiscoveryPublisher2(IWSDXMLContext pContext, WSD_CONFIG_PARAM* pConfigParams, 
                                     uint dwConfigParamCount, IWSDiscoveryPublisher* ppPublisher);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wsdapi.dll")
HRESULT WSDCreateDeviceProxy(const(PWSTR) pszDeviceId, const(PWSTR) pszLocalId, IWSDXMLContext pContext, 
                             IWSDDeviceProxy* ppDeviceProxy);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wsdapi.dll")
HRESULT WSDCreateDeviceProxyAdvanced(const(PWSTR) pszDeviceId, IWSDAddress pDeviceAddress, const(PWSTR) pszLocalId, 
                                     IWSDXMLContext pContext, IWSDDeviceProxy* ppDeviceProxy);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("wsdapi.dll")
HRESULT WSDCreateDeviceProxy2(const(PWSTR) pszDeviceId, const(PWSTR) pszLocalId, IWSDXMLContext pContext, 
                              WSD_CONFIG_PARAM* pConfigParams, uint dwConfigParamCount, 
                              IWSDDeviceProxy* ppDeviceProxy);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wsdapi.dll")
HRESULT WSDCreateDeviceHost(const(PWSTR) pszLocalId, IWSDXMLContext pContext, IWSDDeviceHost* ppDeviceHost);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wsdapi.dll")
HRESULT WSDCreateDeviceHostAdvanced(const(PWSTR) pszLocalId, IWSDXMLContext pContext, IWSDAddress* ppHostAddresses, 
                                    uint dwHostAddressCount, IWSDDeviceHost* ppDeviceHost);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("wsdapi.dll")
HRESULT WSDCreateDeviceHost2(const(PWSTR) pszLocalId, IWSDXMLContext pContext, WSD_CONFIG_PARAM* pConfigParams, 
                             uint dwConfigParamCount, IWSDDeviceHost* ppDeviceHost);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wsdapi.dll")
HRESULT WSDSetConfigurationOption(uint dwOption, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pVoid, 
                                  uint cbInBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wsdapi.dll")
HRESULT WSDGetConfigurationOption(uint dwOption, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pVoid, 
                                  uint cbOutBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wsdapi.dll")
void* WSDAllocateLinkedMemory(void* pParent, size_t cbSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wsdapi.dll")
void WSDFreeLinkedMemory(void* pVoid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wsdapi.dll")
void WSDAttachLinkedMemory(void* pParent, void* pChild);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wsdapi.dll")
void WSDDetachLinkedMemory(void* pVoid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wsdapi.dll")
HRESULT WSDXMLBuildAnyForSingleElement(WSDXML_NAME* pElementName, const(PWSTR) pszText, WSDXML_ELEMENT** ppAny);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wsdapi.dll")
HRESULT WSDXMLGetValueFromAny(const(PWSTR) pszNamespace, const(PWSTR) pszName, WSDXML_ELEMENT* pAny, 
                              const(PWSTR)* ppszValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wsdapi.dll")
HRESULT WSDXMLAddSibling(WSDXML_ELEMENT* pFirst, WSDXML_ELEMENT* pSecond);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wsdapi.dll")
HRESULT WSDXMLAddChild(WSDXML_ELEMENT* pParent, WSDXML_ELEMENT* pChild);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wsdapi.dll")
HRESULT WSDXMLCleanupElement(WSDXML_ELEMENT* pAny);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wsdapi.dll")
HRESULT WSDGenerateFault(const(PWSTR) pszCode, const(PWSTR) pszSubCode, const(PWSTR) pszReason, 
                         const(PWSTR) pszDetail, IWSDXMLContext pContext, WSD_SOAP_FAULT** ppFault);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wsdapi.dll")
HRESULT WSDGenerateFaultEx(WSDXML_NAME* pCode, WSDXML_NAME* pSubCode, WSD_LOCALIZED_STRING_LIST* pReasons, 
                           const(PWSTR) pszDetail, WSD_SOAP_FAULT** ppFault);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("wsdapi.dll")
HRESULT WSDUriEncode(const(PWSTR) source, uint cchSource, PWSTR* destOut, uint* cchDestOut);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("wsdapi.dll")
HRESULT WSDUriDecode(const(PWSTR) source, uint cchSource, PWSTR* destOut, uint* cchDestOut);


// Interfaces

@GUID("b9574c6c-12a6-4f74-93a1-3318ff605759")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nn-wsdbase-iwsdaddress))], [])
interface IWSDAddress : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nf-wsdbase-iwsdaddress-serialize))], [])
    HRESULT Serialize(PWSTR pszBuffer, uint cchLength, BOOL fSafe);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nf-wsdbase-iwsdaddress-deserialize))], [])
    HRESULT Deserialize(const(PWSTR) pszBuffer);
}

@GUID("70d23498-4ee6-4340-a3df-d845d2235467")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nn-wsdbase-iwsdtransportaddress))], [])
interface IWSDTransportAddress : IWSDAddress
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nf-wsdbase-iwsdtransportaddress-getport))], [])
    HRESULT GetPort(ushort* pwPort);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nf-wsdbase-iwsdtransportaddress-setport))], [])
    HRESULT SetPort(ushort wPort);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nf-wsdbase-iwsdtransportaddress-gettransportaddress))], [])
    HRESULT GetTransportAddress(const(PWSTR)* ppszAddress);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nf-wsdbase-iwsdtransportaddress-gettransportaddressex))], [])
    HRESULT GetTransportAddressEx(BOOL fSafe, const(PWSTR)* ppszAddress);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nf-wsdbase-iwsdtransportaddress-settransportaddress))], [])
    HRESULT SetTransportAddress(const(PWSTR) pszAddress);
}

@GUID("1fafe8a2-e6fc-4b80-b6cf-b7d45c416d7c")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nn-wsdbase-iwsdmessageparameters))], [])
interface IWSDMessageParameters : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nf-wsdbase-iwsdmessageparameters-getlocaladdress))], [])
    HRESULT GetLocalAddress(IWSDAddress* ppAddress);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nf-wsdbase-iwsdmessageparameters-setlocaladdress))], [])
    HRESULT SetLocalAddress(IWSDAddress pAddress);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nf-wsdbase-iwsdmessageparameters-getremoteaddress))], [])
    HRESULT GetRemoteAddress(IWSDAddress* ppAddress);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nf-wsdbase-iwsdmessageparameters-setremoteaddress))], [])
    HRESULT SetRemoteAddress(IWSDAddress pAddress);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nf-wsdbase-iwsdmessageparameters-getlowerparameters))], [])
    HRESULT GetLowerParameters(IWSDMessageParameters* ppTxParams);
}

@GUID("9934149f-8f0c-447b-aa0b-73124b0ca7f0")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nn-wsdbase-iwsdudpmessageparameters))], [])
interface IWSDUdpMessageParameters : IWSDMessageParameters
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nf-wsdbase-iwsdudpmessageparameters-setretransmitparams))], [])
    HRESULT SetRetransmitParams(const(WSDUdpRetransmitParams)* pParams);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nf-wsdbase-iwsdudpmessageparameters-getretransmitparams))], [])
    HRESULT GetRetransmitParams(WSDUdpRetransmitParams* pParams);
}

@GUID("74d6124a-a441-4f78-a1eb-97a8d1996893")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nn-wsdbase-iwsdudpaddress))], [])
interface IWSDUdpAddress : IWSDTransportAddress
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nf-wsdbase-iwsdudpaddress-setsockaddr))], [])
    HRESULT SetSockaddr(const(SOCKADDR_STORAGE)* pSockAddr);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nf-wsdbase-iwsdudpaddress-getsockaddr))], [])
    HRESULT GetSockaddr(SOCKADDR_STORAGE* pSockAddr);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nf-wsdbase-iwsdudpaddress-setexclusive))], [])
    HRESULT SetExclusive(BOOL fExclusive);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nf-wsdbase-iwsdudpaddress-getexclusive))], [])
    HRESULT GetExclusive();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nf-wsdbase-iwsdudpaddress-setmessagetype))], [])
    HRESULT SetMessageType(WSDUdpMessageType messageType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nf-wsdbase-iwsdudpaddress-getmessagetype))], [])
    HRESULT GetMessageType(WSDUdpMessageType* pMessageType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nf-wsdbase-iwsdudpaddress-setttl))], [])
    HRESULT SetTTL(uint dwTTL);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nf-wsdbase-iwsdudpaddress-getttl))], [])
    HRESULT GetTTL(uint* pdwTTL);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nf-wsdbase-iwsdudpaddress-setalias))], [])
    HRESULT SetAlias(const(GUID)* pAlias);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nf-wsdbase-iwsdudpaddress-getalias))], [])
    HRESULT GetAlias(GUID* pAlias);
}

@GUID("540bd122-5c83-4dec-b396-ea62a2697fdf")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nn-wsdbase-iwsdhttpmessageparameters))], [])
interface IWSDHttpMessageParameters : IWSDMessageParameters
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nf-wsdbase-iwsdhttpmessageparameters-setinboundhttpheaders))], [])
    HRESULT SetInboundHttpHeaders(const(PWSTR) pszHeaders);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nf-wsdbase-iwsdhttpmessageparameters-getinboundhttpheaders))], [])
    HRESULT GetInboundHttpHeaders(const(PWSTR)* ppszHeaders);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nf-wsdbase-iwsdhttpmessageparameters-setoutboundhttpheaders))], [])
    HRESULT SetOutboundHttpHeaders(const(PWSTR) pszHeaders);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nf-wsdbase-iwsdhttpmessageparameters-getoutboundhttpheaders))], [])
    HRESULT GetOutboundHttpHeaders(const(PWSTR)* ppszHeaders);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nf-wsdbase-iwsdhttpmessageparameters-setid))], [])
    HRESULT SetID(const(PWSTR) pszId);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nf-wsdbase-iwsdhttpmessageparameters-getid))], [])
    HRESULT GetID(const(PWSTR)* ppszId);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nf-wsdbase-iwsdhttpmessageparameters-setcontext))], [])
    HRESULT SetContext(IUnknown pContext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nf-wsdbase-iwsdhttpmessageparameters-getcontext))], [])
    HRESULT GetContext(IUnknown* ppContext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nf-wsdbase-iwsdhttpmessageparameters-clear))], [])
    HRESULT Clear();
}

@GUID("d09ac7bd-2a3e-4b85-8605-2737ff3e4ea0")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nn-wsdbase-iwsdhttpaddress))], [])
interface IWSDHttpAddress : IWSDTransportAddress
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nf-wsdbase-iwsdhttpaddress-getsecure))], [])
    HRESULT GetSecure();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nf-wsdbase-iwsdhttpaddress-setsecure))], [])
    HRESULT SetSecure(BOOL fSecure);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nf-wsdbase-iwsdhttpaddress-getpath))], [])
    HRESULT GetPath(const(PWSTR)* ppszPath);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nf-wsdbase-iwsdhttpaddress-setpath))], [])
    HRESULT SetPath(const(PWSTR) pszPath);
}

@GUID("de105e87-a0da-418e-98ad-27b9eed87bdc")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nn-wsdbase-iwsdsslclientcertificate))], [])
interface IWSDSSLClientCertificate : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nf-wsdbase-iwsdsslclientcertificate-getclientcertificate))], [])
    HRESULT GetClientCertificate(CERT_CONTEXT** ppCertContext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nf-wsdbase-iwsdsslclientcertificate-getmappedaccesstoken))], [])
    HRESULT GetMappedAccessToken(HANDLE* phToken);
}

@GUID("0b476df0-8dac-480d-b05c-99781a5884aa")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nn-wsdbase-iwsdhttpauthparameters))], [])
interface IWSDHttpAuthParameters : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nf-wsdbase-iwsdhttpauthparameters-getclientaccesstoken))], [])
    HRESULT GetClientAccessToken(HANDLE* phToken);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nf-wsdbase-iwsdhttpauthparameters-getauthtype))], [])
    HRESULT GetAuthType(uint* pAuthType);
}

@GUID("03ce20aa-71c4-45e2-b32e-3766c61c790f")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nn-wsdbase-iwsdsignatureproperty))], [])
interface IWSDSignatureProperty : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nf-wsdbase-iwsdsignatureproperty-ismessagesigned))], [])
    HRESULT IsMessageSigned(BOOL* pbSigned);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nf-wsdbase-iwsdsignatureproperty-ismessagesignaturetrusted))], [])
    HRESULT IsMessageSignatureTrusted(BOOL* pbSignatureTrusted);
    HRESULT GetKeyInfo(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/ubyte* pbKeyInfo, 
                       uint* pdwKeyInfoSize);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nf-wsdbase-iwsdsignatureproperty-getsignature))], [])
    HRESULT GetSignature(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/ubyte* pbSignature, 
                         uint* pdwSignatureSize);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdbase/nf-wsdbase-iwsdsignatureproperty-getsignedinfohash))], [])
    HRESULT GetSignedInfoHash(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/ubyte* pbSignedInfoHash, 
                              uint* pdwHashSize);
}

@GUID("5d55a616-9df8-4b09-b156-9ba351a48b76")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdattachment/nn-wsdattachment-iwsdattachment))], [])
interface IWSDAttachment : IUnknown
{
}

@GUID("aa302f8d-5a22-4ba5-b392-aa8486f4c15d")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdattachment/nn-wsdattachment-iwsdoutboundattachment))], [])
interface IWSDOutboundAttachment : IWSDAttachment
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdattachment/nf-wsdattachment-iwsdoutboundattachment-write))], [])
    HRESULT Write(const(ubyte)* pBuffer, uint dwBytesToWrite, uint* pdwNumberOfBytesWritten);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdattachment/nf-wsdattachment-iwsdoutboundattachment-close))], [])
    HRESULT Close();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdattachment/nf-wsdattachment-iwsdoutboundattachment-abort))], [])
    HRESULT Abort();
}

@GUID("5bd6ca65-233c-4fb8-9f7a-2641619655c9")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdattachment/nn-wsdattachment-iwsdinboundattachment))], [])
interface IWSDInboundAttachment : IWSDAttachment
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdattachment/nf-wsdattachment-iwsdinboundattachment-read))], [])
    HRESULT Read(ubyte* pBuffer, uint dwBytesToRead, uint* pdwNumberOfBytesRead);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdattachment/nf-wsdattachment-iwsdinboundattachment-close))], [])
    HRESULT Close();
}

@GUID("75d8f3ee-3e5a-43b4-a15a-bcf6887460c0")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdxml/nn-wsdxml-iwsdxmlcontext))], [])
interface IWSDXMLContext : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdxml/nf-wsdxml-iwsdxmlcontext-addnamespace))], [])
    HRESULT AddNamespace(const(PWSTR) pszUri, const(PWSTR) pszSuggestedPrefix, WSDXML_NAMESPACE** ppNamespace);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdxml/nf-wsdxml-iwsdxmlcontext-addnametonamespace))], [])
    HRESULT AddNameToNamespace(const(PWSTR) pszUri, const(PWSTR) pszName, WSDXML_NAME** ppName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdxml/nf-wsdxml-iwsdxmlcontext-setnamespaces))], [])
    HRESULT SetNamespaces(const(WSDXML_NAMESPACE)** pNamespaces, ushort wNamespacesCount, ubyte bLayerNumber);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdxml/nf-wsdxml-iwsdxmlcontext-settypes))], [])
    HRESULT SetTypes(const(WSDXML_TYPE)** pTypes, uint dwTypesCount, ubyte bLayerNumber);
}

@GUID("8ffc8e55-f0eb-480f-88b7-b435dd281d45")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsddisco/nn-wsddisco-iwsdiscoveryprovider))], [])
interface IWSDiscoveryProvider : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsddisco/nf-wsddisco-iwsdiscoveryprovider-setaddressfamily))], [])
    HRESULT SetAddressFamily(uint dwAddressFamily);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsddisco/nf-wsddisco-iwsdiscoveryprovider-attach))], [])
    HRESULT Attach(IWSDiscoveryProviderNotify pSink);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsddisco/nf-wsddisco-iwsdiscoveryprovider-detach))], [])
    HRESULT Detach();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsddisco/nf-wsddisco-iwsdiscoveryprovider-searchbyid))], [])
    HRESULT SearchById(const(PWSTR) pszId, const(PWSTR) pszTag);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsddisco/nf-wsddisco-iwsdiscoveryprovider-searchbyaddress))], [])
    HRESULT SearchByAddress(const(PWSTR) pszAddress, const(PWSTR) pszTag);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsddisco/nf-wsddisco-iwsdiscoveryprovider-searchbytype))], [])
    HRESULT SearchByType(const(WSD_NAME_LIST)* pTypesList, const(WSD_URI_LIST)* pScopesList, 
                         const(PWSTR) pszMatchBy, const(PWSTR) pszTag);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsddisco/nf-wsddisco-iwsdiscoveryprovider-getxmlcontext))], [])
    HRESULT GetXMLContext(IWSDXMLContext* ppContext);
}

@GUID("73ee3ced-b6e6-4329-a546-3e8ad46563d2")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsddisco/nn-wsddisco-iwsdiscoveryprovidernotify))], [])
interface IWSDiscoveryProviderNotify : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsddisco/nf-wsddisco-iwsdiscoveryprovidernotify-add))], [])
    HRESULT Add(IWSDiscoveredService pService);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsddisco/nf-wsddisco-iwsdiscoveryprovidernotify-remove))], [])
    HRESULT Remove(IWSDiscoveredService pService);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsddisco/nf-wsddisco-iwsdiscoveryprovidernotify-searchfailed))], [])
    HRESULT SearchFailed(HRESULT hr, const(PWSTR) pszTag);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsddisco/nf-wsddisco-iwsdiscoveryprovidernotify-searchcomplete))], [])
    HRESULT SearchComplete(const(PWSTR) pszTag);
}

@GUID("4bad8a3b-b374-4420-9632-aac945b374aa")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsddisco/nn-wsddisco-iwsdiscoveredservice))], [])
interface IWSDiscoveredService : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsddisco/nf-wsddisco-iwsdiscoveredservice-getendpointreference))], [])
    HRESULT GetEndpointReference(WSD_ENDPOINT_REFERENCE** ppEndpointReference);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsddisco/nf-wsddisco-iwsdiscoveredservice-gettypes))], [])
    HRESULT GetTypes(WSD_NAME_LIST** ppTypesList);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsddisco/nf-wsddisco-iwsdiscoveredservice-getscopes))], [])
    HRESULT GetScopes(WSD_URI_LIST** ppScopesList);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsddisco/nf-wsddisco-iwsdiscoveredservice-getxaddrs))], [])
    HRESULT GetXAddrs(WSD_URI_LIST** ppXAddrsList);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsddisco/nf-wsddisco-iwsdiscoveredservice-getmetadataversion))], [])
    HRESULT GetMetadataVersion(ulong* pullMetadataVersion);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsddisco/nf-wsddisco-iwsdiscoveredservice-getextendeddiscoxml))], [])
    HRESULT GetExtendedDiscoXML(WSDXML_ELEMENT** ppHeaderAny, WSDXML_ELEMENT** ppBodyAny);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsddisco/nf-wsddisco-iwsdiscoveredservice-getproberesolvetag))], [])
    HRESULT GetProbeResolveTag(const(PWSTR)* ppszTag);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsddisco/nf-wsddisco-iwsdiscoveredservice-getremotetransportaddress))], [])
    HRESULT GetRemoteTransportAddress(const(PWSTR)* ppszRemoteTransportAddress);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsddisco/nf-wsddisco-iwsdiscoveredservice-getlocaltransportaddress))], [])
    HRESULT GetLocalTransportAddress(const(PWSTR)* ppszLocalTransportAddress);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsddisco/nf-wsddisco-iwsdiscoveredservice-getlocalinterfaceguid))], [])
    HRESULT GetLocalInterfaceGUID(GUID* pGuid);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsddisco/nf-wsddisco-iwsdiscoveredservice-getinstanceid))], [])
    HRESULT GetInstanceId(ulong* pullInstanceId);
}

@GUID("ae01e1a8-3ff9-4148-8116-057cc616fe13")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsddisco/nn-wsddisco-iwsdiscoverypublisher))], [])
interface IWSDiscoveryPublisher : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsddisco/nf-wsddisco-iwsdiscoverypublisher-setaddressfamily))], [])
    HRESULT SetAddressFamily(uint dwAddressFamily);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsddisco/nf-wsddisco-iwsdiscoverypublisher-registernotificationsink))], [])
    HRESULT RegisterNotificationSink(IWSDiscoveryPublisherNotify pSink);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsddisco/nf-wsddisco-iwsdiscoverypublisher-unregisternotificationsink))], [])
    HRESULT UnRegisterNotificationSink(IWSDiscoveryPublisherNotify pSink);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsddisco/nf-wsddisco-iwsdiscoverypublisher-publish))], [])
    HRESULT Publish(const(PWSTR) pszId, ulong ullMetadataVersion, ulong ullInstanceId, ulong ullMessageNumber, 
                    const(PWSTR) pszSessionId, const(WSD_NAME_LIST)* pTypesList, const(WSD_URI_LIST)* pScopesList, 
                    const(WSD_URI_LIST)* pXAddrsList);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsddisco/nf-wsddisco-iwsdiscoverypublisher-unpublish))], [])
    HRESULT UnPublish(const(PWSTR) pszId, ulong ullInstanceId, ulong ullMessageNumber, const(PWSTR) pszSessionId, 
                      const(WSDXML_ELEMENT)* pAny);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsddisco/nf-wsddisco-iwsdiscoverypublisher-matchprobe))], [])
    HRESULT MatchProbe(const(WSD_SOAP_MESSAGE)* pProbeMessage, IWSDMessageParameters pMessageParameters, 
                       const(PWSTR) pszId, ulong ullMetadataVersion, ulong ullInstanceId, ulong ullMessageNumber, 
                       const(PWSTR) pszSessionId, const(WSD_NAME_LIST)* pTypesList, const(WSD_URI_LIST)* pScopesList, 
                       const(WSD_URI_LIST)* pXAddrsList);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsddisco/nf-wsddisco-iwsdiscoverypublisher-matchresolve))], [])
    HRESULT MatchResolve(const(WSD_SOAP_MESSAGE)* pResolveMessage, IWSDMessageParameters pMessageParameters, 
                         const(PWSTR) pszId, ulong ullMetadataVersion, ulong ullInstanceId, ulong ullMessageNumber, 
                         const(PWSTR) pszSessionId, const(WSD_NAME_LIST)* pTypesList, 
                         const(WSD_URI_LIST)* pScopesList, const(WSD_URI_LIST)* pXAddrsList);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsddisco/nf-wsddisco-iwsdiscoverypublisher-publishex))], [])
    HRESULT PublishEx(const(PWSTR) pszId, ulong ullMetadataVersion, ulong ullInstanceId, ulong ullMessageNumber, 
                      const(PWSTR) pszSessionId, const(WSD_NAME_LIST)* pTypesList, const(WSD_URI_LIST)* pScopesList, 
                      const(WSD_URI_LIST)* pXAddrsList, const(WSDXML_ELEMENT)* pHeaderAny, 
                      const(WSDXML_ELEMENT)* pReferenceParameterAny, const(WSDXML_ELEMENT)* pPolicyAny, 
                      const(WSDXML_ELEMENT)* pEndpointReferenceAny, const(WSDXML_ELEMENT)* pAny);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsddisco/nf-wsddisco-iwsdiscoverypublisher-matchprobeex))], [])
    HRESULT MatchProbeEx(const(WSD_SOAP_MESSAGE)* pProbeMessage, IWSDMessageParameters pMessageParameters, 
                         const(PWSTR) pszId, ulong ullMetadataVersion, ulong ullInstanceId, ulong ullMessageNumber, 
                         const(PWSTR) pszSessionId, const(WSD_NAME_LIST)* pTypesList, 
                         const(WSD_URI_LIST)* pScopesList, const(WSD_URI_LIST)* pXAddrsList, 
                         const(WSDXML_ELEMENT)* pHeaderAny, const(WSDXML_ELEMENT)* pReferenceParameterAny, 
                         const(WSDXML_ELEMENT)* pPolicyAny, const(WSDXML_ELEMENT)* pEndpointReferenceAny, 
                         const(WSDXML_ELEMENT)* pAny);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsddisco/nf-wsddisco-iwsdiscoverypublisher-matchresolveex))], [])
    HRESULT MatchResolveEx(const(WSD_SOAP_MESSAGE)* pResolveMessage, IWSDMessageParameters pMessageParameters, 
                           const(PWSTR) pszId, ulong ullMetadataVersion, ulong ullInstanceId, ulong ullMessageNumber, 
                           const(PWSTR) pszSessionId, const(WSD_NAME_LIST)* pTypesList, 
                           const(WSD_URI_LIST)* pScopesList, const(WSD_URI_LIST)* pXAddrsList, 
                           const(WSDXML_ELEMENT)* pHeaderAny, const(WSDXML_ELEMENT)* pReferenceParameterAny, 
                           const(WSDXML_ELEMENT)* pPolicyAny, const(WSDXML_ELEMENT)* pEndpointReferenceAny, 
                           const(WSDXML_ELEMENT)* pAny);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsddisco/nf-wsddisco-iwsdiscoverypublisher-registerscopematchingrule))], [])
    HRESULT RegisterScopeMatchingRule(IWSDScopeMatchingRule pScopeMatchingRule);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsddisco/nf-wsddisco-iwsdiscoverypublisher-unregisterscopematchingrule))], [])
    HRESULT UnRegisterScopeMatchingRule(IWSDScopeMatchingRule pScopeMatchingRule);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsddisco/nf-wsddisco-iwsdiscoverypublisher-getxmlcontext))], [])
    HRESULT GetXMLContext(IWSDXMLContext* ppContext);
}

@GUID("e67651b0-337a-4b3c-9758-733388568251")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsddisco/nn-wsddisco-iwsdiscoverypublishernotify))], [])
interface IWSDiscoveryPublisherNotify : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsddisco/nf-wsddisco-iwsdiscoverypublishernotify-probehandler))], [])
    HRESULT ProbeHandler(const(WSD_SOAP_MESSAGE)* pSoap, IWSDMessageParameters pMessageParameters);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsddisco/nf-wsddisco-iwsdiscoverypublishernotify-resolvehandler))], [])
    HRESULT ResolveHandler(const(WSD_SOAP_MESSAGE)* pSoap, IWSDMessageParameters pMessageParameters);
}

@GUID("fcafe424-fef5-481a-bd9f-33ce0574256f")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsddisco/nn-wsddisco-iwsdscopematchingrule))], [])
interface IWSDScopeMatchingRule : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsddisco/nf-wsddisco-iwsdscopematchingrule-getscoperule))], [])
    HRESULT GetScopeRule(const(PWSTR)* ppszScopeMatchingRule);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsddisco/nf-wsddisco-iwsdscopematchingrule-matchscopes))], [])
    HRESULT MatchScopes(const(PWSTR) pszScope1, const(PWSTR) pszScope2, BOOL* pfMatch);
}

@GUID("1860d430-b24c-4975-9f90-dbb39baa24ec")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nn-wsdclient-iwsdendpointproxy))], [])
interface IWSDEndpointProxy : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nf-wsdclient-iwsdendpointproxy-sendonewayrequest))], [])
    HRESULT SendOneWayRequest(const(void)* pBody, const(WSD_OPERATION)* pOperation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nf-wsdclient-iwsdendpointproxy-sendtwowayrequest))], [])
    HRESULT SendTwoWayRequest(const(void)* pBody, const(WSD_OPERATION)* pOperation, 
                              const(WSD_SYNCHRONOUS_RESPONSE_CONTEXT)* pResponseContext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nf-wsdclient-iwsdendpointproxy-sendtwowayrequestasync))], [])
    HRESULT SendTwoWayRequestAsync(const(void)* pBody, const(WSD_OPERATION)* pOperation, IUnknown pAsyncState, 
                                   IWSDAsyncCallback pCallback, IWSDAsyncResult* pResult);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nf-wsdclient-iwsdendpointproxy-abortasyncoperation))], [])
    HRESULT AbortAsyncOperation(IWSDAsyncResult pAsyncResult);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nf-wsdclient-iwsdendpointproxy-processfault))], [])
    HRESULT ProcessFault(const(WSD_SOAP_FAULT)* pFault);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nf-wsdclient-iwsdendpointproxy-geterrorinfo))], [])
    HRESULT GetErrorInfo(const(PWSTR)* ppszErrorInfo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nf-wsdclient-iwsdendpointproxy-getfaultinfo))], [])
    HRESULT GetFaultInfo(WSD_SOAP_FAULT** ppFault);
}

@GUID("06996d57-1d67-4928-9307-3d7833fdb846")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nn-wsdclient-iwsdmetadataexchange))], [])
interface IWSDMetadataExchange : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nf-wsdclient-iwsdmetadataexchange-getmetadata))], [])
    HRESULT GetMetadata(WSD_METADATA_SECTION_LIST** MetadataOut);
}

@GUID("d4c7fb9c-03ab-4175-9d67-094fafebf487")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nn-wsdclient-iwsdserviceproxy))], [])
interface IWSDServiceProxy : IWSDMetadataExchange
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nf-wsdclient-iwsdserviceproxy-begingetmetadata))], [])
    HRESULT BeginGetMetadata(IWSDAsyncResult* ppResult);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nf-wsdclient-iwsdserviceproxy-endgetmetadata))], [])
    HRESULT EndGetMetadata(IWSDAsyncResult pResult, WSD_METADATA_SECTION_LIST** ppMetadata);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nf-wsdclient-iwsdserviceproxy-getservicemetadata))], [])
    HRESULT GetServiceMetadata(WSD_SERVICE_METADATA** ppServiceMetadata);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nf-wsdclient-iwsdserviceproxy-subscribetooperation))], [])
    HRESULT SubscribeToOperation(const(WSD_OPERATION)* pOperation, IUnknown pUnknown, const(WSDXML_ELEMENT)* pAny, 
                                 WSDXML_ELEMENT** ppAny);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nf-wsdclient-iwsdserviceproxy-unsubscribetooperation))], [])
    HRESULT UnsubscribeToOperation(const(WSD_OPERATION)* pOperation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nf-wsdclient-iwsdserviceproxy-seteventingstatuscallback))], [])
    HRESULT SetEventingStatusCallback(IWSDEventingStatus pStatus);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nf-wsdclient-iwsdserviceproxy-getendpointproxy))], [])
    HRESULT GetEndpointProxy(IWSDEndpointProxy* ppProxy);
}

@GUID("f9279d6d-1012-4a94-b8cc-fd35d2202bfe")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nn-wsdclient-iwsdserviceproxyeventing))], [])
interface IWSDServiceProxyEventing : IWSDServiceProxy
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nf-wsdclient-iwsdserviceproxyeventing-subscribetomultipleoperations))], [])
    HRESULT SubscribeToMultipleOperations(const(WSD_OPERATION)* pOperations, uint dwOperationCount, 
                                          IUnknown pUnknown, const(WSD_EVENTING_EXPIRES)* pExpires, 
                                          const(WSDXML_ELEMENT)* pAny, WSD_EVENTING_EXPIRES** ppExpires, 
                                          WSDXML_ELEMENT** ppAny);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nf-wsdclient-iwsdserviceproxyeventing-beginsubscribetomultipleoperations))], [])
    HRESULT BeginSubscribeToMultipleOperations(const(WSD_OPERATION)* pOperations, uint dwOperationCount, 
                                               IUnknown pUnknown, const(WSD_EVENTING_EXPIRES)* pExpires, 
                                               const(WSDXML_ELEMENT)* pAny, IUnknown pAsyncState, 
                                               IWSDAsyncCallback pAsyncCallback, IWSDAsyncResult* ppResult);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nf-wsdclient-iwsdserviceproxyeventing-endsubscribetomultipleoperations))], [])
    HRESULT EndSubscribeToMultipleOperations(const(WSD_OPERATION)* pOperations, uint dwOperationCount, 
                                             IWSDAsyncResult pResult, WSD_EVENTING_EXPIRES** ppExpires, 
                                             WSDXML_ELEMENT** ppAny);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nf-wsdclient-iwsdserviceproxyeventing-unsubscribetomultipleoperations))], [])
    HRESULT UnsubscribeToMultipleOperations(const(WSD_OPERATION)* pOperations, uint dwOperationCount, 
                                            const(WSDXML_ELEMENT)* pAny);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nf-wsdclient-iwsdserviceproxyeventing-beginunsubscribetomultipleoperations))], [])
    HRESULT BeginUnsubscribeToMultipleOperations(const(WSD_OPERATION)* pOperations, uint dwOperationCount, 
                                                 const(WSDXML_ELEMENT)* pAny, IUnknown pAsyncState, 
                                                 IWSDAsyncCallback pAsyncCallback, IWSDAsyncResult* ppResult);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nf-wsdclient-iwsdserviceproxyeventing-endunsubscribetomultipleoperations))], [])
    HRESULT EndUnsubscribeToMultipleOperations(const(WSD_OPERATION)* pOperations, uint dwOperationCount, 
                                               IWSDAsyncResult pResult);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nf-wsdclient-iwsdserviceproxyeventing-renewmultipleoperations))], [])
    HRESULT RenewMultipleOperations(const(WSD_OPERATION)* pOperations, uint dwOperationCount, 
                                    const(WSD_EVENTING_EXPIRES)* pExpires, const(WSDXML_ELEMENT)* pAny, 
                                    WSD_EVENTING_EXPIRES** ppExpires, WSDXML_ELEMENT** ppAny);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nf-wsdclient-iwsdserviceproxyeventing-beginrenewmultipleoperations))], [])
    HRESULT BeginRenewMultipleOperations(const(WSD_OPERATION)* pOperations, uint dwOperationCount, 
                                         const(WSD_EVENTING_EXPIRES)* pExpires, const(WSDXML_ELEMENT)* pAny, 
                                         IUnknown pAsyncState, IWSDAsyncCallback pAsyncCallback, 
                                         IWSDAsyncResult* ppResult);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nf-wsdclient-iwsdserviceproxyeventing-endrenewmultipleoperations))], [])
    HRESULT EndRenewMultipleOperations(const(WSD_OPERATION)* pOperations, uint dwOperationCount, 
                                       IWSDAsyncResult pResult, WSD_EVENTING_EXPIRES** ppExpires, 
                                       WSDXML_ELEMENT** ppAny);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nf-wsdclient-iwsdserviceproxyeventing-getstatusformultipleoperations))], [])
    HRESULT GetStatusForMultipleOperations(const(WSD_OPERATION)* pOperations, uint dwOperationCount, 
                                           const(WSDXML_ELEMENT)* pAny, WSD_EVENTING_EXPIRES** ppExpires, 
                                           WSDXML_ELEMENT** ppAny);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nf-wsdclient-iwsdserviceproxyeventing-begingetstatusformultipleoperations))], [])
    HRESULT BeginGetStatusForMultipleOperations(const(WSD_OPERATION)* pOperations, uint dwOperationCount, 
                                                const(WSDXML_ELEMENT)* pAny, IUnknown pAsyncState, 
                                                IWSDAsyncCallback pAsyncCallback, IWSDAsyncResult* ppResult);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nf-wsdclient-iwsdserviceproxyeventing-endgetstatusformultipleoperations))], [])
    HRESULT EndGetStatusForMultipleOperations(const(WSD_OPERATION)* pOperations, uint dwOperationCount, 
                                              IWSDAsyncResult pResult, WSD_EVENTING_EXPIRES** ppExpires, 
                                              WSDXML_ELEMENT** ppAny);
}

@GUID("eee0c031-c578-4c0e-9a3b-973c35f409db")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nn-wsdclient-iwsddeviceproxy))], [])
interface IWSDDeviceProxy : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nf-wsdclient-iwsddeviceproxy-init))], [])
    HRESULT Init(const(PWSTR) pszDeviceId, IWSDAddress pDeviceAddress, const(PWSTR) pszLocalId, 
                 IWSDXMLContext pContext, IWSDDeviceProxy pSponsor);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nf-wsdclient-iwsddeviceproxy-begingetmetadata))], [])
    HRESULT BeginGetMetadata(IWSDAsyncResult* ppResult);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nf-wsdclient-iwsddeviceproxy-endgetmetadata))], [])
    HRESULT EndGetMetadata(IWSDAsyncResult pResult);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nf-wsdclient-iwsddeviceproxy-gethostmetadata))], [])
    HRESULT GetHostMetadata(WSD_HOST_METADATA** ppHostMetadata);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nf-wsdclient-iwsddeviceproxy-getthismodelmetadata))], [])
    HRESULT GetThisModelMetadata(WSD_THIS_MODEL_METADATA** ppManufacturerMetadata);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nf-wsdclient-iwsddeviceproxy-getthisdevicemetadata))], [])
    HRESULT GetThisDeviceMetadata(WSD_THIS_DEVICE_METADATA** ppThisDeviceMetadata);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nf-wsdclient-iwsddeviceproxy-getallmetadata))], [])
    HRESULT GetAllMetadata(WSD_METADATA_SECTION_LIST** ppMetadata);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nf-wsdclient-iwsddeviceproxy-getserviceproxybyid))], [])
    HRESULT GetServiceProxyById(const(PWSTR) pszServiceId, IWSDServiceProxy* ppServiceProxy);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nf-wsdclient-iwsddeviceproxy-getserviceproxybytype))], [])
    HRESULT GetServiceProxyByType(const(WSDXML_NAME)* pType, IWSDServiceProxy* ppServiceProxy);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nf-wsdclient-iwsddeviceproxy-getendpointproxy))], [])
    HRESULT GetEndpointProxy(IWSDEndpointProxy* ppProxy);
}

@GUID("11a9852a-8dd8-423e-b537-9356db4fbfb8")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nn-wsdclient-iwsdasyncresult))], [])
interface IWSDAsyncResult : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nf-wsdclient-iwsdasyncresult-setcallback))], [])
    HRESULT SetCallback(IWSDAsyncCallback pCallback, IUnknown pAsyncState);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nf-wsdclient-iwsdasyncresult-setwaithandle))], [])
    HRESULT SetWaitHandle(HANDLE hWaitHandle);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nf-wsdclient-iwsdasyncresult-hascompleted))], [])
    HRESULT HasCompleted();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nf-wsdclient-iwsdasyncresult-getasyncstate))], [])
    HRESULT GetAsyncState(IUnknown* ppAsyncState);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nf-wsdclient-iwsdasyncresult-abort))], [])
    HRESULT Abort();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nf-wsdclient-iwsdasyncresult-getevent))], [])
    HRESULT GetEvent(WSD_EVENT* pEvent);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nf-wsdclient-iwsdasyncresult-getendpointproxy))], [])
    HRESULT GetEndpointProxy(IWSDEndpointProxy* ppEndpoint);
}

@GUID("a63e109d-ce72-49e2-ba98-e845f5ee1666")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nn-wsdclient-iwsdasynccallback))], [])
interface IWSDAsyncCallback : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nf-wsdclient-iwsdasynccallback-asyncoperationcomplete))], [])
    HRESULT AsyncOperationComplete(IWSDAsyncResult pAsyncResult, IUnknown pAsyncState);
}

@GUID("49b17f52-637a-407a-ae99-fbe82a4d38c0")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nn-wsdclient-iwsdeventingstatus))], [])
interface IWSDEventingStatus : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nf-wsdclient-iwsdeventingstatus-subscriptionrenewed))], [])
    void SubscriptionRenewed(const(PWSTR) pszSubscriptionAction);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nf-wsdclient-iwsdeventingstatus-subscriptionrenewalfailed))], [])
    void SubscriptionRenewalFailed(const(PWSTR) pszSubscriptionAction, HRESULT hr);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdclient/nf-wsdclient-iwsdeventingstatus-subscriptionended))], [])
    void SubscriptionEnded(const(PWSTR) pszSubscriptionAction);
}

@GUID("917fe891-3d13-4138-9809-934c8abeb12c")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdhost/nn-wsdhost-iwsddevicehost))], [])
interface IWSDDeviceHost : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdhost/nf-wsdhost-iwsddevicehost-init))], [])
    HRESULT Init(const(PWSTR) pszLocalId, IWSDXMLContext pContext, IWSDAddress* ppHostAddresses, 
                 uint dwHostAddressCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdhost/nf-wsdhost-iwsddevicehost-start))], [])
    HRESULT Start(ulong ullInstanceId, const(WSD_URI_LIST)* pScopeList, IWSDDeviceHostNotify pNotificationSink);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdhost/nf-wsdhost-iwsddevicehost-stop))], [])
    HRESULT Stop();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdhost/nf-wsdhost-iwsddevicehost-terminate))], [])
    HRESULT Terminate();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdhost/nf-wsdhost-iwsddevicehost-registerporttype))], [])
    HRESULT RegisterPortType(const(WSD_PORT_TYPE)* pPortType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdhost/nf-wsdhost-iwsddevicehost-setmetadata))], [])
    HRESULT SetMetadata(const(WSD_THIS_MODEL_METADATA)* pThisModelMetadata, 
                        const(WSD_THIS_DEVICE_METADATA)* pThisDeviceMetadata, 
                        const(WSD_HOST_METADATA)* pHostMetadata, const(WSD_METADATA_SECTION_LIST)* pCustomMetadata);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdhost/nf-wsdhost-iwsddevicehost-registerservice))], [])
    HRESULT RegisterService(const(PWSTR) pszServiceId, IUnknown pService);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdhost/nf-wsdhost-iwsddevicehost-retireservice))], [])
    HRESULT RetireService(const(PWSTR) pszServiceId);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdhost/nf-wsdhost-iwsddevicehost-adddynamicservice))], [])
    HRESULT AddDynamicService(const(PWSTR) pszServiceId, const(PWSTR) pszEndpointAddress, 
                              const(WSD_PORT_TYPE)* pPortType, const(WSDXML_NAME)* pPortName, 
                              const(WSDXML_ELEMENT)* pAny, IUnknown pService);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdhost/nf-wsdhost-iwsddevicehost-removedynamicservice))], [])
    HRESULT RemoveDynamicService(const(PWSTR) pszServiceId);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdhost/nf-wsdhost-iwsddevicehost-setservicediscoverable))], [])
    HRESULT SetServiceDiscoverable(const(PWSTR) pszServiceId, BOOL fDiscoverable);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdhost/nf-wsdhost-iwsddevicehost-signalevent))], [])
    HRESULT SignalEvent(const(PWSTR) pszServiceId, const(void)* pBody, const(WSD_OPERATION)* pOperation);
}

@GUID("b5bee9f9-eeda-41fe-96f7-f45e14990fb0")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdhost/nn-wsdhost-iwsddevicehostnotify))], [])
interface IWSDDeviceHostNotify : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdhost/nf-wsdhost-iwsddevicehostnotify-getservice))], [])
    HRESULT GetService(const(PWSTR) pszServiceId, IUnknown* ppService);
}

@GUID("94974cf4-0cab-460d-a3f6-7a0ad623c0e6")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdhost/nn-wsdhost-iwsdservicemessaging))], [])
interface IWSDServiceMessaging : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdhost/nf-wsdhost-iwsdservicemessaging-sendresponse))], [])
    HRESULT SendResponse(void* pBody, WSD_OPERATION* pOperation, IWSDMessageParameters pMessageParameters);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsdhost/nf-wsdhost-iwsdservicemessaging-faultrequest))], [])
    HRESULT FaultRequest(WSD_SOAP_HEADER* pRequestHeader, IWSDMessageParameters pMessageParameters, 
                         WSD_SOAP_FAULT* pFault);
}


// GUIDs


const GUID IID_IWSDAddress                 = GUIDOF!IWSDAddress;
const GUID IID_IWSDAsyncCallback           = GUIDOF!IWSDAsyncCallback;
const GUID IID_IWSDAsyncResult             = GUIDOF!IWSDAsyncResult;
const GUID IID_IWSDAttachment              = GUIDOF!IWSDAttachment;
const GUID IID_IWSDDeviceHost              = GUIDOF!IWSDDeviceHost;
const GUID IID_IWSDDeviceHostNotify        = GUIDOF!IWSDDeviceHostNotify;
const GUID IID_IWSDDeviceProxy             = GUIDOF!IWSDDeviceProxy;
const GUID IID_IWSDEndpointProxy           = GUIDOF!IWSDEndpointProxy;
const GUID IID_IWSDEventingStatus          = GUIDOF!IWSDEventingStatus;
const GUID IID_IWSDHttpAddress             = GUIDOF!IWSDHttpAddress;
const GUID IID_IWSDHttpAuthParameters      = GUIDOF!IWSDHttpAuthParameters;
const GUID IID_IWSDHttpMessageParameters   = GUIDOF!IWSDHttpMessageParameters;
const GUID IID_IWSDInboundAttachment       = GUIDOF!IWSDInboundAttachment;
const GUID IID_IWSDMessageParameters       = GUIDOF!IWSDMessageParameters;
const GUID IID_IWSDMetadataExchange        = GUIDOF!IWSDMetadataExchange;
const GUID IID_IWSDOutboundAttachment      = GUIDOF!IWSDOutboundAttachment;
const GUID IID_IWSDSSLClientCertificate    = GUIDOF!IWSDSSLClientCertificate;
const GUID IID_IWSDScopeMatchingRule       = GUIDOF!IWSDScopeMatchingRule;
const GUID IID_IWSDServiceMessaging        = GUIDOF!IWSDServiceMessaging;
const GUID IID_IWSDServiceProxy            = GUIDOF!IWSDServiceProxy;
const GUID IID_IWSDServiceProxyEventing    = GUIDOF!IWSDServiceProxyEventing;
const GUID IID_IWSDSignatureProperty       = GUIDOF!IWSDSignatureProperty;
const GUID IID_IWSDTransportAddress        = GUIDOF!IWSDTransportAddress;
const GUID IID_IWSDUdpAddress              = GUIDOF!IWSDUdpAddress;
const GUID IID_IWSDUdpMessageParameters    = GUIDOF!IWSDUdpMessageParameters;
const GUID IID_IWSDXMLContext              = GUIDOF!IWSDXMLContext;
const GUID IID_IWSDiscoveredService        = GUIDOF!IWSDiscoveredService;
const GUID IID_IWSDiscoveryProvider        = GUIDOF!IWSDiscoveryProvider;
const GUID IID_IWSDiscoveryProviderNotify  = GUIDOF!IWSDiscoveryProviderNotify;
const GUID IID_IWSDiscoveryPublisher       = GUIDOF!IWSDiscoveryPublisher;
const GUID IID_IWSDiscoveryPublisherNotify = GUIDOF!IWSDiscoveryPublisherNotify;
