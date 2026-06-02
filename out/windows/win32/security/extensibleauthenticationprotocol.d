// Written in the D programming language.

module windows.win32.security.extensibleauthenticationprotocol;

public import windows.core;
public import windows.win32.data.xml.msxml : IXMLDOMDocument2, IXMLDOMNode;
public import windows.win32.foundation : BOOL, HANDLE, HRESULT, HWND, PWSTR;
public import windows.win32.security.cryptography : NCRYPT_KEY_HANDLE;
public import windows.win32.system.com : IUnknown;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/raseapif/ne-raseapif-ras_auth_attribute_type
alias RAS_AUTH_ATTRIBUTE_TYPE = int;
enum : int
{
    raatMinimum                = 0x00000000,
    raatUserName               = 0x00000001,
    raatUserPassword           = 0x00000002,
    raatMD5CHAPPassword        = 0x00000003,
    raatNASIPAddress           = 0x00000004,
    raatNASPort                = 0x00000005,
    raatServiceType            = 0x00000006,
    raatFramedProtocol         = 0x00000007,
    raatFramedIPAddress        = 0x00000008,
    raatFramedIPNetmask        = 0x00000009,
    raatFramedRouting          = 0x0000000a,
    raatFilterId               = 0x0000000b,
    raatFramedMTU              = 0x0000000c,
    raatFramedCompression      = 0x0000000d,
    raatLoginIPHost            = 0x0000000e,
    raatLoginService           = 0x0000000f,
    raatLoginTCPPort           = 0x00000010,
    raatUnassigned17           = 0x00000011,
    raatReplyMessage           = 0x00000012,
    raatCallbackNumber         = 0x00000013,
    raatCallbackId             = 0x00000014,
    raatUnassigned21           = 0x00000015,
    raatFramedRoute            = 0x00000016,
    raatFramedIPXNetwork       = 0x00000017,
    raatState                  = 0x00000018,
    raatClass                  = 0x00000019,
    raatVendorSpecific         = 0x0000001a,
    raatSessionTimeout         = 0x0000001b,
    raatIdleTimeout            = 0x0000001c,
    raatTerminationAction      = 0x0000001d,
    raatCalledStationId        = 0x0000001e,
    raatCallingStationId       = 0x0000001f,
    raatNASIdentifier          = 0x00000020,
    raatProxyState             = 0x00000021,
    raatLoginLATService        = 0x00000022,
    raatLoginLATNode           = 0x00000023,
    raatLoginLATGroup          = 0x00000024,
    raatFramedAppleTalkLink    = 0x00000025,
    raatFramedAppleTalkNetwork = 0x00000026,
    raatFramedAppleTalkZone    = 0x00000027,
    raatAcctStatusType         = 0x00000028,
    raatAcctDelayTime          = 0x00000029,
    raatAcctInputOctets        = 0x0000002a,
    raatAcctOutputOctets       = 0x0000002b,
    raatAcctSessionId          = 0x0000002c,
    raatAcctAuthentic          = 0x0000002d,
    raatAcctSessionTime        = 0x0000002e,
    raatAcctInputPackets       = 0x0000002f,
    raatAcctOutputPackets      = 0x00000030,
    raatAcctTerminateCause     = 0x00000031,
    raatAcctMultiSessionId     = 0x00000032,
    raatAcctLinkCount          = 0x00000033,
    raatAcctEventTimeStamp     = 0x00000037,
    raatMD5CHAPChallenge       = 0x0000003c,
    raatNASPortType            = 0x0000003d,
    raatPortLimit              = 0x0000003e,
    raatLoginLATPort           = 0x0000003f,
    raatTunnelType             = 0x00000040,
    raatTunnelMediumType       = 0x00000041,
    raatTunnelClientEndpoint   = 0x00000042,
    raatTunnelServerEndpoint   = 0x00000043,
    raatARAPPassword           = 0x00000046,
    raatARAPFeatures           = 0x00000047,
    raatARAPZoneAccess         = 0x00000048,
    raatARAPSecurity           = 0x00000049,
    raatARAPSecurityData       = 0x0000004a,
    raatPasswordRetry          = 0x0000004b,
    raatPrompt                 = 0x0000004c,
    raatConnectInfo            = 0x0000004d,
    raatConfigurationToken     = 0x0000004e,
    raatEAPMessage             = 0x0000004f,
    raatSignature              = 0x00000050,
    raatARAPChallengeResponse  = 0x00000054,
    raatAcctInterimInterval    = 0x00000055,
    raatNASIPv6Address         = 0x0000005f,
    raatFramedInterfaceId      = 0x00000060,
    raatFramedIPv6Prefix       = 0x00000061,
    raatLoginIPv6Host          = 0x00000062,
    raatFramedIPv6Route        = 0x00000063,
    raatFramedIPv6Pool         = 0x00000064,
    raatARAPGuestLogon         = 0x00001fa0,
    raatCertificateOID         = 0x00001fa1,
    raatEAPConfiguration       = 0x00001fa2,
    raatPEAPEmbeddedEAPTypeId  = 0x00001fa3,
    raatInnerEAPTypeId         = 0x00001fa3,
    raatPEAPFastRoamedSession  = 0x00001fa4,
    raatFastRoamedSession      = 0x00001fa4,
    raatEAPTLV                 = 0x00001fa6,
    raatCredentialsChanged     = 0x00001fa7,
    raatCertificateThumbprint  = 0x0000203a,
    raatPeerId                 = 0x00002328,
    raatServerId               = 0x00002329,
    raatMethodId               = 0x0000232a,
    raatEMSK                   = 0x0000232b,
    raatSessionId              = 0x0000232c,
    raatReserved               = 0xffffffff,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/raseapif/ne-raseapif-ppp_eap_action
alias PPP_EAP_ACTION = int;
enum : int
{
    EAPACTION_NoAction                   = 0x00000000,
    EAPACTION_Authenticate               = 0x00000001,
    EAPACTION_Done                       = 0x00000002,
    EAPACTION_SendAndDone                = 0x00000003,
    EAPACTION_Send                       = 0x00000004,
    EAPACTION_SendWithTimeout            = 0x00000005,
    EAPACTION_SendWithTimeoutInteractive = 0x00000006,
    EAPACTION_IndicateTLV                = 0x00000007,
    EAPACTION_IndicateIdentity           = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eaptypes/ne-eaptypes-eap_attribute_type
alias EAP_ATTRIBUTE_TYPE = int;
enum : int
{
    eatMinimum                = 0x00000000,
    eatUserName               = 0x00000001,
    eatUserPassword           = 0x00000002,
    eatMD5CHAPPassword        = 0x00000003,
    eatNASIPAddress           = 0x00000004,
    eatNASPort                = 0x00000005,
    eatServiceType            = 0x00000006,
    eatFramedProtocol         = 0x00000007,
    eatFramedIPAddress        = 0x00000008,
    eatFramedIPNetmask        = 0x00000009,
    eatFramedRouting          = 0x0000000a,
    eatFilterId               = 0x0000000b,
    eatFramedMTU              = 0x0000000c,
    eatFramedCompression      = 0x0000000d,
    eatLoginIPHost            = 0x0000000e,
    eatLoginService           = 0x0000000f,
    eatLoginTCPPort           = 0x00000010,
    eatUnassigned17           = 0x00000011,
    eatReplyMessage           = 0x00000012,
    eatCallbackNumber         = 0x00000013,
    eatCallbackId             = 0x00000014,
    eatUnassigned21           = 0x00000015,
    eatFramedRoute            = 0x00000016,
    eatFramedIPXNetwork       = 0x00000017,
    eatState                  = 0x00000018,
    eatClass                  = 0x00000019,
    eatVendorSpecific         = 0x0000001a,
    eatSessionTimeout         = 0x0000001b,
    eatIdleTimeout            = 0x0000001c,
    eatTerminationAction      = 0x0000001d,
    eatCalledStationId        = 0x0000001e,
    eatCallingStationId       = 0x0000001f,
    eatNASIdentifier          = 0x00000020,
    eatProxyState             = 0x00000021,
    eatLoginLATService        = 0x00000022,
    eatLoginLATNode           = 0x00000023,
    eatLoginLATGroup          = 0x00000024,
    eatFramedAppleTalkLink    = 0x00000025,
    eatFramedAppleTalkNetwork = 0x00000026,
    eatFramedAppleTalkZone    = 0x00000027,
    eatAcctStatusType         = 0x00000028,
    eatAcctDelayTime          = 0x00000029,
    eatAcctInputOctets        = 0x0000002a,
    eatAcctOutputOctets       = 0x0000002b,
    eatAcctSessionId          = 0x0000002c,
    eatAcctAuthentic          = 0x0000002d,
    eatAcctSessionTime        = 0x0000002e,
    eatAcctInputPackets       = 0x0000002f,
    eatAcctOutputPackets      = 0x00000030,
    eatAcctTerminateCause     = 0x00000031,
    eatAcctMultiSessionId     = 0x00000032,
    eatAcctLinkCount          = 0x00000033,
    eatAcctEventTimeStamp     = 0x00000037,
    eatMD5CHAPChallenge       = 0x0000003c,
    eatNASPortType            = 0x0000003d,
    eatPortLimit              = 0x0000003e,
    eatLoginLATPort           = 0x0000003f,
    eatTunnelType             = 0x00000040,
    eatTunnelMediumType       = 0x00000041,
    eatTunnelClientEndpoint   = 0x00000042,
    eatTunnelServerEndpoint   = 0x00000043,
    eatARAPPassword           = 0x00000046,
    eatARAPFeatures           = 0x00000047,
    eatARAPZoneAccess         = 0x00000048,
    eatARAPSecurity           = 0x00000049,
    eatARAPSecurityData       = 0x0000004a,
    eatPasswordRetry          = 0x0000004b,
    eatPrompt                 = 0x0000004c,
    eatConnectInfo            = 0x0000004d,
    eatConfigurationToken     = 0x0000004e,
    eatEAPMessage             = 0x0000004f,
    eatSignature              = 0x00000050,
    eatARAPChallengeResponse  = 0x00000054,
    eatAcctInterimInterval    = 0x00000055,
    eatNASIPv6Address         = 0x0000005f,
    eatFramedInterfaceId      = 0x00000060,
    eatFramedIPv6Prefix       = 0x00000061,
    eatLoginIPv6Host          = 0x00000062,
    eatFramedIPv6Route        = 0x00000063,
    eatFramedIPv6Pool         = 0x00000064,
    eatARAPGuestLogon         = 0x00001fa0,
    eatCertificateOID         = 0x00001fa1,
    eatEAPConfiguration       = 0x00001fa2,
    eatPEAPEmbeddedEAPTypeId  = 0x00001fa3,
    eatPEAPFastRoamedSession  = 0x00001fa4,
    eatFastRoamedSession      = 0x00001fa4,
    eatEAPTLV                 = 0x00001fa6,
    eatCredentialsChanged     = 0x00001fa7,
    eatInnerEapMethodType     = 0x00001fa8,
    eatClearTextPassword      = 0x00001fab,
    eatQuarantineSoH          = 0x00001fd6,
    eatCertificateThumbprint  = 0x0000203a,
    eatPeerId                 = 0x00002328,
    eatServerId               = 0x00002329,
    eatMethodId               = 0x0000232a,
    eatEMSK                   = 0x0000232b,
    eatSessionId              = 0x0000232c,
    eatReserved               = 0xffffffff,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eaptypes/ne-eaptypes-eap_config_input_field_type
alias EAP_CONFIG_INPUT_FIELD_TYPE = int;
enum : int
{
    EapConfigInputUsername        = 0x00000000,
    EapConfigInputPassword        = 0x00000001,
    EapConfigInputNetworkUsername = 0x00000002,
    EapConfigInputNetworkPassword = 0x00000003,
    EapConfigInputPin             = 0x00000004,
    EapConfigInputPSK             = 0x00000005,
    EapConfigInputEdit            = 0x00000006,
    EapConfigSmartCardUsername    = 0x00000007,
    EapConfigSmartCardError       = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eaptypes/ne-eaptypes-eap_interactive_ui_data_type
alias EAP_INTERACTIVE_UI_DATA_TYPE = int;
enum : int
{
    EapCredReq        = 0x00000000,
    EapCredResp       = 0x00000001,
    EapCredExpiryReq  = 0x00000002,
    EapCredExpiryResp = 0x00000003,
    EapCredLogonReq   = 0x00000004,
    EapCredLogonResp  = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eaptypes/ne-eaptypes-eap_method_property_type
alias EAP_METHOD_PROPERTY_TYPE = int;
enum : int
{
    emptPropCipherSuiteNegotiation     = 0x00000000,
    emptPropMutualAuth                 = 0x00000001,
    emptPropIntegrity                  = 0x00000002,
    emptPropReplayProtection           = 0x00000003,
    emptPropConfidentiality            = 0x00000004,
    emptPropKeyDerivation              = 0x00000005,
    emptPropKeyStrength64              = 0x00000006,
    emptPropKeyStrength128             = 0x00000007,
    emptPropKeyStrength256             = 0x00000008,
    emptPropKeyStrength512             = 0x00000009,
    emptPropKeyStrength1024            = 0x0000000a,
    emptPropDictionaryAttackResistance = 0x0000000b,
    emptPropFastReconnect              = 0x0000000c,
    emptPropCryptoBinding              = 0x0000000d,
    emptPropSessionIndependence        = 0x0000000e,
    emptPropFragmentation              = 0x0000000f,
    emptPropChannelBinding             = 0x00000010,
    emptPropNap                        = 0x00000011,
    emptPropStandalone                 = 0x00000012,
    emptPropMppeEncryption             = 0x00000013,
    emptPropTunnelMethod               = 0x00000014,
    emptPropSupportsConfig             = 0x00000015,
    emptPropCertifiedMethod            = 0x00000016,
    emptPropHiddenMethod               = 0x00000017,
    emptPropMachineAuth                = 0x00000018,
    emptPropUserAuth                   = 0x00000019,
    emptPropIdentityPrivacy            = 0x0000001a,
    emptPropMethodChaining             = 0x0000001b,
    emptPropSharedStateEquivalence     = 0x0000001c,
    emptLegacyMethodPropertyFlag       = 0x0000001f,
    emptPropVendorSpecific             = 0x000000ff,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eaptypes/ne-eaptypes-eap_method_property_value_type
alias EAP_METHOD_PROPERTY_VALUE_TYPE = int;
enum : int
{
    empvtBool   = 0x00000000,
    empvtDword  = 0x00000001,
    empvtString = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eaptypes/ne-eaptypes-eapcredentialtype
enum EapCredentialType : int
{
    EAP_EMPTY_CREDENTIAL             = 0x00000000,
    EAP_USERNAME_PASSWORD_CREDENTIAL = 0x00000001,
    EAP_WINLOGON_CREDENTIAL          = 0x00000002,
    EAP_CERTIFICATE_CREDENTIAL       = 0x00000003,
    EAP_SIM_CREDENTIAL               = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eaphostpeertypes/ne-eaphostpeertypes-eaphostpeermethodresultreason
enum EapHostPeerMethodResultReason : int
{
    EapHostPeerMethodResultAltSuccessReceived = 0x00000001,
    EapHostPeerMethodResultTimeout            = 0x00000002,
    EapHostPeerMethodResultFromMethod         = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eaphostpeertypes/ne-eaphostpeertypes-eaphostpeerresponseaction
enum EapHostPeerResponseAction : int
{
    EapHostPeerResponseDiscard             = 0x00000000,
    EapHostPeerResponseSend                = 0x00000001,
    EapHostPeerResponseResult              = 0x00000002,
    EapHostPeerResponseInvokeUi            = 0x00000003,
    EapHostPeerResponseRespond             = 0x00000004,
    EapHostPeerResponseStartAuthentication = 0x00000005,
    EapHostPeerResponseNone                = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eaphostpeertypes/ne-eaphostpeertypes-eaphostpeerauthparams
enum EapHostPeerAuthParams : int
{
    EapHostPeerAuthStatus           = 0x00000001,
    EapHostPeerIdentity             = 0x00000002,
    EapHostPeerIdentityExtendedInfo = 0x00000003,
    EapHostNapInfo                  = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eaphostpeertypes/ne-eaphostpeertypes-eaphost_auth_status
alias EAPHOST_AUTH_STATUS = int;
enum : int
{
    EapHostInvalidSession       = 0x00000000,
    EapHostAuthNotStarted       = 0x00000001,
    EapHostAuthIdentityExchange = 0x00000002,
    EapHostAuthNegotiatingType  = 0x00000003,
    EapHostAuthInProgress       = 0x00000004,
    EapHostAuthSucceeded        = 0x00000005,
    EapHostAuthFailed           = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eaphostpeertypes/ne-eaphostpeertypes-isolation_state
alias ISOLATION_STATE = int;
enum : int
{
    ISOLATION_STATE_UNKNOWN           = 0x00000000,
    ISOLATION_STATE_NOT_RESTRICTED    = 0x00000001,
    ISOLATION_STATE_IN_PROBATION      = 0x00000002,
    ISOLATION_STATE_RESTRICTED_ACCESS = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eapmethodtypes/ne-eapmethodtypes-eapcode
enum EapCode : int
{
    EapCodeMinimum  = 0x00000001,
    EapCodeRequest  = 0x00000001,
    EapCodeResponse = 0x00000002,
    EapCodeSuccess  = 0x00000003,
    EapCodeFailure  = 0x00000004,
    EapCodeMaximum  = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eapauthenticatoractiondefine/ne-eapauthenticatoractiondefine-eap_method_authenticator_response_action
alias EAP_METHOD_AUTHENTICATOR_RESPONSE_ACTION = int;
enum : int
{
    EAP_METHOD_AUTHENTICATOR_RESPONSE_DISCARD         = 0x00000000,
    EAP_METHOD_AUTHENTICATOR_RESPONSE_SEND            = 0x00000001,
    EAP_METHOD_AUTHENTICATOR_RESPONSE_RESULT          = 0x00000002,
    EAP_METHOD_AUTHENTICATOR_RESPONSE_RESPOND         = 0x00000003,
    EAP_METHOD_AUTHENTICATOR_RESPONSE_AUTHENTICATE    = 0x00000004,
    EAP_METHOD_AUTHENTICATOR_RESPONSE_HANDLE_IDENTITY = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eapauthenticatoractiondefine/ne-eapauthenticatoractiondefine-eappeermethodresponseaction
enum EapPeerMethodResponseAction : int
{
    EapPeerMethodResponseActionDiscard  = 0x00000000,
    EapPeerMethodResponseActionSend     = 0x00000001,
    EapPeerMethodResponseActionResult   = 0x00000002,
    EapPeerMethodResponseActionInvokeUI = 0x00000003,
    EapPeerMethodResponseActionRespond  = 0x00000004,
    EapPeerMethodResponseActionNone     = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eapauthenticatoractiondefine/ne-eapauthenticatoractiondefine-eappeermethodresultreason
enum EapPeerMethodResultReason : int
{
    EapPeerMethodResultUnknown = 0x00000001,
    EapPeerMethodResultSuccess = 0x00000002,
    EapPeerMethodResultFailure = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eapauthenticatortypes/ne-eapauthenticatortypes-eap_authenticator_send_timeout
alias EAP_AUTHENTICATOR_SEND_TIMEOUT = int;
enum : int
{
    EAP_AUTHENTICATOR_SEND_TIMEOUT_NONE        = 0x00000000,
    EAP_AUTHENTICATOR_SEND_TIMEOUT_BASIC       = 0x00000001,
    EAP_AUTHENTICATOR_SEND_TIMEOUT_INTERACTIVE = 0x00000002,
}

// Constants


enum uint FACILITY_EAP_MESSAGE = 0x00000842U;
enum int EAP_GROUP_MASK = 0x0000ff00;

enum : int
{
    EAP_E_EAPHOST_FIRST = 0x80420000,
    EAP_E_EAPHOST_LAST  = 0x804200ff,
}

enum : int
{
    EAP_I_EAPHOST_FIRST = 0x80420000,
    EAP_I_EAPHOST_LAST  = 0x804200ff,
}

enum uint EAP_E_CERT_STORE_INACCESSIBLE = 0x80420010U;

enum : uint
{
    EAP_E_EAPHOST_METHOD_NOT_INSTALLED         = 0x80420011U,
    EAP_E_EAPHOST_THIRDPARTY_METHOD_HOST_RESET = 0x80420012U,
}

enum : uint
{
    EAP_E_EAPHOST_EAPQEC_INACCESSIBLE = 0x80420013U,
    EAP_E_EAPHOST_IDENTITY_UNKNOWN    = 0x80420014U,
}

enum uint EAP_E_AUTHENTICATION_FAILED = 0x80420015U;
enum uint EAP_I_EAPHOST_EAP_NEGOTIATION_FAILED = 0x40420016U;
enum uint EAP_E_EAPHOST_METHOD_INVALID_PACKET = 0x80420017U;
enum uint EAP_E_EAPHOST_REMOTE_INVALID_PACKET = 0x80420018U;
enum uint EAP_E_EAPHOST_XML_MALFORMED = 0x80420019U;
enum uint EAP_E_METHOD_CONFIG_DOES_NOT_SUPPORT_SSO = 0x8042001aU;
enum uint EAP_E_EAPHOST_METHOD_OPERATION_NOT_SUPPORTED = 0x80420020U;

enum : int
{
    EAP_E_USER_FIRST = 0x80420100,
    EAP_E_USER_LAST  = 0x804201ff,
}

enum : int
{
    EAP_I_USER_FIRST = 0x40420100,
    EAP_I_USER_LAST  = 0x404201ff,
}

enum : uint
{
    EAP_E_USER_CERT_NOT_FOUND   = 0x80420100U,
    EAP_E_USER_CERT_INVALID     = 0x80420101U,
    EAP_E_USER_CERT_EXPIRED     = 0x80420102U,
    EAP_E_USER_CERT_REVOKED     = 0x80420103U,
    EAP_E_USER_CERT_OTHER_ERROR = 0x80420104U,
    EAP_E_USER_CERT_REJECTED    = 0x80420105U,
}

enum uint EAP_I_USER_ACCOUNT_OTHER_ERROR = 0x40420110U;
enum uint EAP_E_USER_CREDENTIALS_REJECTED = 0x80420111U;
enum uint EAP_E_USER_NAME_PASSWORD_REJECTED = 0x80420112U;
enum uint EAP_E_NO_SMART_CARD_READER = 0x80420113U;

enum : int
{
    EAP_E_SERVER_FIRST = 0x80420200,
    EAP_E_SERVER_LAST  = 0x804202ff,
}

enum : uint
{
    EAP_E_SERVER_CERT_NOT_FOUND   = 0x80420200U,
    EAP_E_SERVER_CERT_INVALID     = 0x80420201U,
    EAP_E_SERVER_CERT_EXPIRED     = 0x80420202U,
    EAP_E_SERVER_CERT_REVOKED     = 0x80420203U,
    EAP_E_SERVER_CERT_OTHER_ERROR = 0x80420204U,
}

enum : int
{
    EAP_E_USER_ROOT_CERT_FIRST = 0x80420300,
    EAP_E_USER_ROOT_CERT_LAST  = 0x804203ff,
}

enum : uint
{
    EAP_E_USER_ROOT_CERT_NOT_FOUND = 0x80420300U,
    EAP_E_USER_ROOT_CERT_INVALID   = 0x80420301U,
    EAP_E_USER_ROOT_CERT_EXPIRED   = 0x80420302U,
}

enum : int
{
    EAP_E_SERVER_ROOT_CERT_FIRST = 0x80420400,
    EAP_E_SERVER_ROOT_CERT_LAST  = 0x804204ff,
}

enum : uint
{
    EAP_E_SERVER_ROOT_CERT_NOT_FOUND     = 0x80420400U,
    EAP_E_SERVER_ROOT_CERT_INVALID       = 0x80420401U,
    EAP_E_SERVER_ROOT_CERT_NAME_REQUIRED = 0x80420406U,
}

enum uint EAP_E_SIM_NOT_VALID = 0x80420500U;
enum uint EAP_METHOD_INVALID_PACKET = 0x80420017U;
enum uint EAP_INVALID_PACKET = 0x80420018U;
enum uint EAP_PEER_FLAG_GUEST_ACCESS = 0x00000040U;
enum uint eapPropCipherSuiteNegotiation = 0x00000001U;

enum : uint
{
    eapPropMutualAuth       = 0x00000002U,
    eapPropIntegrity        = 0x00000004U,
    eapPropReplayProtection = 0x00000008U,
}

enum uint eapPropConfidentiality = 0x00000010U;

enum : uint
{
    eapPropKeyDerivation   = 0x00000020U,
    eapPropKeyStrength64   = 0x00000040U,
    eapPropKeyStrength128  = 0x00000080U,
    eapPropKeyStrength256  = 0x00000100U,
    eapPropKeyStrength512  = 0x00000200U,
    eapPropKeyStrength1024 = 0x00000400U,
}

enum uint eapPropDictionaryAttackResistance = 0x00000800U;
enum uint eapPropFastReconnect = 0x00001000U;
enum uint eapPropCryptoBinding = 0x00002000U;
enum uint eapPropSessionIndependence = 0x00004000U;
enum uint eapPropFragmentation = 0x00008000U;
enum uint eapPropChannelBinding = 0x00010000U;

enum : uint
{
    eapPropNap            = 0x00020000U,
    eapPropStandalone     = 0x00040000U,
    eapPropMppeEncryption = 0x00080000U,
}

enum uint eapPropTunnelMethod = 0x00100000U;
enum uint eapPropSupportsConfig = 0x00200000U;
enum uint eapPropCertifiedMethod = 0x00400000U;
enum uint eapPropHiddenMethod = 0x00800000U;
enum uint eapPropMachineAuth = 0x01000000U;

enum : uint
{
    eapPropUserAuth        = 0x02000000U,
    eapPropIdentityPrivacy = 0x04000000U,
}

enum uint eapPropMethodChaining = 0x08000000U;
enum uint eapPropSharedStateEquivalence = 0x10000000U;
enum uint eapPropReserved = 0x80000000U;
enum const(wchar)* EAP_VALUENAME_PROPERTIES = "Properties";

enum : uint
{
    EAP_FLAG_Reserved1       = 0x00000001U,
    EAP_FLAG_NON_INTERACTIVE = 0x00000002U,
}

enum : uint
{
    EAP_FLAG_LOGON                 = 0x00000004U,
    EAP_FLAG_PREVIEW               = 0x00000008U,
    EAP_FLAG_Reserved2             = 0x00000010U,
    EAP_FLAG_MACHINE_AUTH          = 0x00000020U,
    EAP_FLAG_GUEST_ACCESS          = 0x00000040U,
    EAP_FLAG_Reserved3             = 0x00000080U,
    EAP_FLAG_Reserved4             = 0x00000100U,
    EAP_FLAG_RESUME_FROM_HIBERNATE = 0x00000200U,
}

enum : uint
{
    EAP_FLAG_Reserved5              = 0x00000400U,
    EAP_FLAG_Reserved6              = 0x00000800U,
    EAP_FLAG_FULL_AUTH              = 0x00001000U,
    EAP_FLAG_PREFER_ALT_CREDENTIALS = 0x00002000U,
}

enum uint EAP_FLAG_Reserved7 = 0x00004000U;
enum uint EAP_PEER_FLAG_HEALTH_STATE_CHANGE = 0x00008000U;

enum : uint
{
    EAP_FLAG_SUPRESS_UI     = 0x00010000U,
    EAP_FLAG_PRE_LOGON      = 0x00020000U,
    EAP_FLAG_USER_AUTH      = 0x00040000U,
    EAP_FLAG_CONFG_READONLY = 0x00080000U,
}

enum : uint
{
    EAP_FLAG_Reserved8                  = 0x00100000U,
    EAP_FLAG_Reserved9                  = 0x00400000U,
    EAP_FLAG_VPN                        = 0x00800000U,
    EAP_FLAG_ONLY_EAP_TLS               = 0x01000000U,
    EAP_FLAG_SERVER_VALIDATION_REQUIRED = 0x02000000U,
}

enum : uint
{
    EAP_CONFIG_INPUT_FIELD_PROPS_DEFAULT         = 0x00000000U,
    EAP_CONFIG_INPUT_FIELD_PROPS_NON_DISPLAYABLE = 0x00000001U,
    EAP_CONFIG_INPUT_FIELD_PROPS_NON_PERSIST     = 0x00000002U,
}

enum : uint
{
    EAP_UI_INPUT_FIELD_PROPS_DEFAULT         = 0x00000000U,
    EAP_UI_INPUT_FIELD_PROPS_NON_DISPLAYABLE = 0x00000001U,
    EAP_UI_INPUT_FIELD_PROPS_NON_PERSIST     = 0x00000002U,
    EAP_UI_INPUT_FIELD_PROPS_READ_ONLY       = 0x00000004U,
}

enum uint EAP_CREDENTIAL_VERSION = 0x00000001U;
enum uint EAP_INTERACTIVE_UI_DATA_VERSION = 0x00000001U;
enum uint EAPHOST_PEER_API_VERSION = 0x00000001U;
enum uint EAPHOST_METHOD_API_VERSION = 0x00000001U;

enum : uint
{
    MAX_EAP_CONFIG_INPUT_FIELD_LENGTH       = 0x00000100U,
    MAX_EAP_CONFIG_INPUT_FIELD_VALUE_LENGTH = 0x00000400U,
}

enum uint CERTIFICATE_HASH_LENGTH = 0x00000014U;
enum uint NCRYPT_PIN_CACHE_PIN_BYTE_LENGTH = 0x0000005aU;
enum const(wchar)* EAP_REGISTRY_LOCATION = "System\\CurrentControlSet\\Services\\EapHost\\Methods";

enum : const(wchar)*
{
    EAP_PEER_VALUENAME_DLL_PATH         = "PeerDllPath",
    EAP_PEER_VALUENAME_FRIENDLY_NAME    = "PeerFriendlyName",
    EAP_PEER_VALUENAME_CONFIGUI         = "PeerConfigUIPath",
    EAP_PEER_VALUENAME_REQUIRE_CONFIGUI = "PeerRequireConfigUI",
    EAP_PEER_VALUENAME_IDENTITY         = "PeerIdentityPath",
    EAP_PEER_VALUENAME_INTERACTIVEUI    = "PeerInteractiveUIPath",
    EAP_PEER_VALUENAME_INVOKE_NAMEDLG   = "PeerInvokeUsernameDialog",
    EAP_PEER_VALUENAME_INVOKE_PWDDLG    = "PeerInvokePasswordDialog",
    EAP_PEER_VALUENAME_PROPERTIES       = "Properties",
}

enum : const(wchar)*
{
    EAP_AUTHENTICATOR_VALUENAME_DLL_PATH      = "AuthenticatorDllPath",
    EAP_AUTHENTICATOR_VALUENAME_FRIENDLY_NAME = "AuthenticatorFriendlyName",
    EAP_AUTHENTICATOR_VALUENAME_PROPERTIES    = "Properties",
    EAP_AUTHENTICATOR_VALUENAME_CONFIGUI      = "AuthenticatorConfigUIPath",
}

enum uint EAP_METHOD_AUTHENTICATOR_CONFIG_IS_IDENTITY_PRIVACY = 0x00000001U;
enum const(wchar)* RAS_EAP_REGISTRY_LOCATION = "System\\CurrentControlSet\\Services\\Rasman\\PPP\\EAP";

enum : const(wchar)*
{
    RAS_EAP_VALUENAME_PATH                 = "Path",
    RAS_EAP_VALUENAME_CONFIGUI             = "ConfigUIPath",
    RAS_EAP_VALUENAME_INTERACTIVEUI        = "InteractiveUIPath",
    RAS_EAP_VALUENAME_IDENTITY             = "IdentityPath",
    RAS_EAP_VALUENAME_FRIENDLY_NAME        = "FriendlyName",
    RAS_EAP_VALUENAME_DEFAULT_DATA         = "ConfigData",
    RAS_EAP_VALUENAME_REQUIRE_CONFIGUI     = "RequireConfigUI",
    RAS_EAP_VALUENAME_ENCRYPTION           = "MPPEEncryptionSupported",
    RAS_EAP_VALUENAME_INVOKE_NAMEDLG       = "InvokeUsernameDialog",
    RAS_EAP_VALUENAME_INVOKE_PWDDLG        = "InvokePasswordDialog",
    RAS_EAP_VALUENAME_CONFIG_CLSID         = "ConfigCLSID",
    RAS_EAP_VALUENAME_STANDALONE_SUPPORTED = "StandaloneSupported",
    RAS_EAP_VALUENAME_ROLES_SUPPORTED      = "RolesSupported",
    RAS_EAP_VALUENAME_PER_POLICY_CONFIG    = "PerPolicyConfig",
    RAS_EAP_VALUENAME_ISTUNNEL_METHOD      = "IsTunnelMethod",
    RAS_EAP_VALUENAME_FILTER_INNERMETHODS  = "FilterInnerMethods",
}

enum : uint
{
    RAS_EAP_ROLE_AUTHENTICATOR   = 0x00000001U,
    RAS_EAP_ROLE_AUTHENTICATEE   = 0x00000002U,
    RAS_EAP_ROLE_EXCLUDE_IN_EAP  = 0x00000004U,
    RAS_EAP_ROLE_EXCLUDE_IN_PEAP = 0x00000008U,
    RAS_EAP_ROLE_EXCLUDE_IN_VPN  = 0x00000010U,
}

enum : uint
{
    raatARAPChallenge            = 0x00000021U,
    raatARAPOldPassword          = 0x00000013U,
    raatARAPNewPassword          = 0x00000014U,
    raatARAPPasswordChangeReason = 0x00000015U,
}

enum : uint
{
    EAPCODE_Request  = 0x00000001U,
    EAPCODE_Response = 0x00000002U,
    EAPCODE_Success  = 0x00000003U,
    EAPCODE_Failure  = 0x00000004U,
}

enum uint MAXEAPCODE = 0x00000004U;

enum : uint
{
    RAS_EAP_FLAG_ROUTER                = 0x00000001U,
    RAS_EAP_FLAG_NON_INTERACTIVE       = 0x00000002U,
    RAS_EAP_FLAG_LOGON                 = 0x00000004U,
    RAS_EAP_FLAG_PREVIEW               = 0x00000008U,
    RAS_EAP_FLAG_FIRST_LINK            = 0x00000010U,
    RAS_EAP_FLAG_MACHINE_AUTH          = 0x00000020U,
    RAS_EAP_FLAG_GUEST_ACCESS          = 0x00000040U,
    RAS_EAP_FLAG_8021X_AUTH            = 0x00000080U,
    RAS_EAP_FLAG_HOSTED_IN_PEAP        = 0x00000100U,
    RAS_EAP_FLAG_RESUME_FROM_HIBERNATE = 0x00000200U,
}

enum : uint
{
    RAS_EAP_FLAG_PEAP_UPFRONT               = 0x00000400U,
    RAS_EAP_FLAG_ALTERNATIVE_USER_DB        = 0x00000800U,
    RAS_EAP_FLAG_PEAP_FORCE_FULL_AUTH       = 0x00001000U,
    RAS_EAP_FLAG_PRE_LOGON                  = 0x00020000U,
    RAS_EAP_FLAG_CONFG_READONLY             = 0x00080000U,
    RAS_EAP_FLAG_RESERVED                   = 0x00100000U,
    RAS_EAP_FLAG_SAVE_CREDMAN               = 0x00200000U,
    RAS_EAP_FLAG_SERVER_VALIDATION_REQUIRED = 0x02000000U,
}

enum : GUID
{
    GUID_EapHost_Default                 = GUID("00000000-0000-0000-0000-000000000000"),
    GUID_EapHost_Cause_MethodDLLNotFound = GUID("9612fc67-6150-4209-a85e-a8d800000001"),
}

enum GUID GUID_EapHost_Repair_ContactSysadmin = GUID("9612fc67-6150-4209-a85e-a8d800000002");

enum : GUID
{
    GUID_EapHost_Cause_CertStoreInaccessible        = GUID("9612fc67-6150-4209-a85e-a8d800000004"),
    GUID_EapHost_Cause_Generic_AuthFailure          = GUID("9612fc67-6150-4209-a85e-a8d800000104"),
    GUID_EapHost_Cause_IdentityUnknown              = GUID("9612fc67-6150-4209-a85e-a8d800000204"),
    GUID_EapHost_Cause_SimNotValid                  = GUID("9612fc67-6150-4209-a85e-a8d800000304"),
    GUID_EapHost_Cause_Server_CertExpired           = GUID("9612fc67-6150-4209-a85e-a8d800000005"),
    GUID_EapHost_Cause_Server_CertInvalid           = GUID("9612fc67-6150-4209-a85e-a8d800000006"),
    GUID_EapHost_Cause_Server_CertNotFound          = GUID("9612fc67-6150-4209-a85e-a8d800000007"),
    GUID_EapHost_Cause_Server_CertRevoked           = GUID("9612fc67-6150-4209-a85e-a8d800000008"),
    GUID_EapHost_Cause_Server_CertOtherError        = GUID("9612fc67-6150-4209-a85e-a8d800000108"),
    GUID_EapHost_Cause_User_CertExpired             = GUID("9612fc67-6150-4209-a85e-a8d800000009"),
    GUID_EapHost_Cause_User_CertInvalid             = GUID("9612fc67-6150-4209-a85e-a8d80000000a"),
    GUID_EapHost_Cause_User_CertNotFound            = GUID("9612fc67-6150-4209-a85e-a8d80000000b"),
    GUID_EapHost_Cause_User_CertOtherError          = GUID("9612fc67-6150-4209-a85e-a8d80000000c"),
    GUID_EapHost_Cause_User_CertRejected            = GUID("9612fc67-6150-4209-a85e-a8d80000000d"),
    GUID_EapHost_Cause_User_CertRevoked             = GUID("9612fc67-6150-4209-a85e-a8d80000000e"),
    GUID_EapHost_Cause_User_Account_OtherProblem    = GUID("9612fc67-6150-4209-a85e-a8d80000010e"),
    GUID_EapHost_Cause_User_CredsRejected           = GUID("9612fc67-6150-4209-a85e-a8d80000020e"),
    GUID_EapHost_Cause_User_Root_CertExpired        = GUID("9612fc67-6150-4209-a85e-a8d80000000f"),
    GUID_EapHost_Cause_User_Root_CertInvalid        = GUID("9612fc67-6150-4209-a85e-a8d800000010"),
    GUID_EapHost_Cause_User_Root_CertNotFound       = GUID("9612fc67-6150-4209-a85e-a8d800000011"),
    GUID_EapHost_Cause_Server_Root_CertNameRequired = GUID("9612fc67-6150-4209-a85e-a8d800000012"),
    GUID_EapHost_Cause_Server_Root_CertNotFound     = GUID("9612fc67-6150-4209-a85e-a8d800000112"),
    GUID_EapHost_Cause_ThirdPartyMethod_Host_Reset  = GUID("9612fc67-6150-4209-a85e-a8d800000212"),
    GUID_EapHost_Cause_EapQecInaccessible           = GUID("9612fc67-6150-4209-a85e-a8d800000312"),
}

enum : GUID
{
    GUID_EapHost_Repair_Server_ClientSelectServerCert = GUID("9612fc67-6150-4209-a85e-a8d800000018"),
    GUID_EapHost_Repair_User_AuthFailure              = GUID("9612fc67-6150-4209-a85e-a8d800000019"),
    GUID_EapHost_Repair_User_GetNewCert               = GUID("9612fc67-6150-4209-a85e-a8d80000001a"),
    GUID_EapHost_Repair_User_SelectValidCert          = GUID("9612fc67-6150-4209-a85e-a8d80000001b"),
    GUID_EapHost_Repair_Retry_Authentication          = GUID("9612fc67-6150-4209-a85e-a8d80000011b"),
}

enum : GUID
{
    GUID_EapHost_Cause_EapNegotiationFailed          = GUID("9612fc67-6150-4209-a85e-a8d80000001c"),
    GUID_EapHost_Cause_XmlMalformed                  = GUID("9612fc67-6150-4209-a85e-a8d80000001d"),
    GUID_EapHost_Cause_MethodDoesNotSupportOperation = GUID("9612fc67-6150-4209-a85e-a8d80000001e"),
}

enum : GUID
{
    GUID_EapHost_Repair_ContactAdmin_AuthFailure           = GUID("9612fc67-6150-4209-a85e-a8d80000001f"),
    GUID_EapHost_Repair_ContactAdmin_IdentityUnknown       = GUID("9612fc67-6150-4209-a85e-a8d800000020"),
    GUID_EapHost_Repair_ContactAdmin_NegotiationFailed     = GUID("9612fc67-6150-4209-a85e-a8d800000021"),
    GUID_EapHost_Repair_ContactAdmin_MethodNotFound        = GUID("9612fc67-6150-4209-a85e-a8d800000022"),
    GUID_EapHost_Repair_RestartNap                         = GUID("9612fc67-6150-4209-a85e-a8d800000023"),
    GUID_EapHost_Repair_ContactAdmin_CertStoreInaccessible = GUID("9612fc67-6150-4209-a85e-a8d800000024"),
    GUID_EapHost_Repair_ContactAdmin_InvalidUserAccount    = GUID("9612fc67-6150-4209-a85e-a8d800000025"),
    GUID_EapHost_Repair_ContactAdmin_RootCertInvalid       = GUID("9612fc67-6150-4209-a85e-a8d800000026"),
    GUID_EapHost_Repair_ContactAdmin_RootCertNotFound      = GUID("9612fc67-6150-4209-a85e-a8d800000027"),
    GUID_EapHost_Repair_ContactAdmin_RootExpired           = GUID("9612fc67-6150-4209-a85e-a8d800000028"),
    GUID_EapHost_Repair_ContactAdmin_CertNameAbsent        = GUID("9612fc67-6150-4209-a85e-a8d800000029"),
    GUID_EapHost_Repair_ContactAdmin_NoSmartCardReader     = GUID("9612fc67-6150-4209-a85e-a8d80000002a"),
}

enum GUID GUID_EapHost_Cause_No_SmartCardReader_Found = GUID("9612fc67-6150-4209-a85e-a8d80000002b");

enum : GUID
{
    GUID_EapHost_Repair_ContactAdmin_InvalidUserCert = GUID("9612fc67-6150-4209-a85e-a8d80000002c"),
    GUID_EapHost_Repair_Method_Not_Support_Sso       = GUID("9612fc67-6150-4209-a85e-a8d80000002d"),
    GUID_EapHost_Repair_No_ValidSim_Found            = GUID("9612fc67-6150-4209-a85e-a8d80000002e"),
}

enum : GUID
{
    GUID_EapHost_Help_ObtainingCerts  = GUID("f535eea3-1bdd-46ca-a2fc-a6655939b7e8"),
    GUID_EapHost_Help_Troubleshooting = GUID("33307acf-0698-41ba-b014-ea0a2eb8d0a8"),
}

enum GUID GUID_EapHost_Cause_Method_Config_Does_Not_Support_Sso = GUID("da18bd32-004f-41fa-ae08-0bc85e5845ac");

// Callbacks

alias NotificationHandler = void function(GUID connectionId, void* pContextData);

// Structs


struct NgcTicketContext
{
    wchar[45]         wszTicket;
    NCRYPT_KEY_HANDLE hKey;
    HANDLE            hImpersonateToken;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/raseapif/ns-raseapif-ras_auth_attribute
struct RAS_AUTH_ATTRIBUTE
{
    RAS_AUTH_ATTRIBUTE_TYPE raaType;
    uint  dwLength;
    void* Value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/raseapif/ns-raseapif-ppp_eap_packet
struct PPP_EAP_PACKET
{
    ubyte    Code;
    ubyte    Id;
    ubyte[2] Length;
    ubyte[1] Data; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/raseapif/ns-raseapif-ppp_eap_input
struct PPP_EAP_INPUT
{
    uint                dwSizeInBytes;
    uint                fFlags;
    BOOL                fAuthenticator;
    PWSTR               pwszIdentity;
    PWSTR               pwszPassword;
    ubyte               bInitialId;
    RAS_AUTH_ATTRIBUTE* pUserAttributes;
    BOOL                fAuthenticationComplete;
    uint                dwAuthResultCode;
    HANDLE              hTokenImpersonateUser;
    BOOL                fSuccessPacketReceived;
    BOOL                fDataReceivedFromInteractiveUI;
    ubyte*              pDataFromInteractiveUI;
    uint                dwSizeOfDataFromInteractiveUI;
    ubyte*              pConnectionData;
    uint                dwSizeOfConnectionData;
    ubyte*              pUserData;
    uint                dwSizeOfUserData;
    HANDLE              hReserved;
    GUID                guidConnectionId;
    BOOL                isVpn;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/raseapif/ns-raseapif-ppp_eap_output
struct PPP_EAP_OUTPUT
{
    uint                dwSizeInBytes;
    PPP_EAP_ACTION      Action;
    uint                dwAuthResultCode;
    RAS_AUTH_ATTRIBUTE* pUserAttributes;
    BOOL                fInvokeInteractiveUI;
    ubyte*              pUIContextData;
    uint                dwSizeOfUIContextData;
    BOOL                fSaveConnectionData;
    ubyte*              pConnectionData;
    uint                dwSizeOfConnectionData;
    BOOL                fSaveUserData;
    ubyte*              pUserData;
    uint                dwSizeOfUserData;
    NgcTicketContext*   pNgcKerbTicket;
    BOOL                fSaveToCredMan;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/raseapif/ns-raseapif-ppp_eap_info
struct PPP_EAP_INFO
{
    uint      dwSizeInBytes;
    uint      dwEapTypeId;
    ptrdiff_t RasEapInitialize;
    ptrdiff_t RasEapBegin;
    ptrdiff_t RasEapEnd;
    ptrdiff_t RasEapMakeMessage;
}

struct LEGACY_IDENTITY_UI_PARAMS
{
    uint   eapType;
    uint   dwFlags;
    uint   dwSizeofConnectionData;
    ubyte* pConnectionData;
    uint   dwSizeofUserData;
    ubyte* pUserData;
    uint   dwSizeofUserDataOut;
    ubyte* pUserDataOut;
    PWSTR  pwszIdentity;
    uint   dwError;
}

struct LEGACY_INTERACTIVE_UI_PARAMS
{
    uint   eapType;
    uint   dwSizeofContextData;
    ubyte* pContextData;
    uint   dwSizeofInteractiveUIData;
    ubyte* pInteractiveUIData;
    uint   dwError;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eaptypes/ns-eaptypes-eap_type
struct EAP_TYPE
{
    ubyte type;
    uint  dwVendorId;
    uint  dwVendorType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eaptypes/ns-eaptypes-eap_method_type
struct EAP_METHOD_TYPE
{
    EAP_TYPE eapType;
    uint     dwAuthorId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eaptypes/ns-eaptypes-eap_method_info
struct EAP_METHOD_INFO
{
    EAP_METHOD_TYPE  eaptype;
    PWSTR            pwszAuthorName;
    PWSTR            pwszFriendlyName;
    uint             eapProperties;
    EAP_METHOD_INFO* pInnerMethodInfo;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eaptypes/ns-eaptypes-eap_method_info_ex
struct EAP_METHOD_INFO_EX
{
    EAP_METHOD_TYPE eaptype;
    PWSTR           pwszAuthorName;
    PWSTR           pwszFriendlyName;
    uint            eapProperties;
    EAP_METHOD_INFO_ARRAY_EX* pInnerMethodInfoArray;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eaptypes/ns-eaptypes-eap_method_info_array
struct EAP_METHOD_INFO_ARRAY
{
    uint             dwNumberOfMethods;
    EAP_METHOD_INFO* pEapMethods;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eaptypes/ns-eaptypes-eap_method_info_array_ex
struct EAP_METHOD_INFO_ARRAY_EX
{
    uint                dwNumberOfMethods;
    EAP_METHOD_INFO_EX* pEapMethods;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eaptypes/ns-eaptypes-eap_error
struct EAP_ERROR
{
    uint            dwWinError;
    EAP_METHOD_TYPE type;
    uint            dwReasonCode;
    GUID            rootCauseGuid;
    GUID            repairGuid;
    GUID            helpLinkGuid;
    PWSTR           pRootCauseString;
    PWSTR           pRepairString;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eaptypes/ns-eaptypes-eap_attribute
struct EAP_ATTRIBUTE
{
    EAP_ATTRIBUTE_TYPE eaType;
    uint               dwLength;
    ubyte*             pValue;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eaptypes/ns-eaptypes-eap_attributes
struct EAP_ATTRIBUTES
{
    uint           dwNumberOfAttributes;
    EAP_ATTRIBUTE* pAttribs;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eaptypes/ns-eaptypes-eap_config_input_field_data
struct EAP_CONFIG_INPUT_FIELD_DATA
{
    uint  dwSize;
    EAP_CONFIG_INPUT_FIELD_TYPE Type;
    uint  dwFlagProps;
    PWSTR pwszLabel;
    PWSTR pwszData;
    uint  dwMinDataLength;
    uint  dwMaxDataLength;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eaptypes/ns-eaptypes-eap_config_input_field_array
struct EAP_CONFIG_INPUT_FIELD_ARRAY
{
    uint dwVersion;
    uint dwNumberOfFields;
    EAP_CONFIG_INPUT_FIELD_DATA* pFields;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eaptypes/ns-eaptypes-eap_cred_expiry_req
struct EAP_CRED_EXPIRY_REQ
{
    EAP_CONFIG_INPUT_FIELD_ARRAY curCreds;
    EAP_CONFIG_INPUT_FIELD_ARRAY newCreds;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eaptypes/ns-eaptypes-eap_ui_data_format
union EAP_UI_DATA_FORMAT
{
    EAP_CONFIG_INPUT_FIELD_ARRAY* credData;
    EAP_CRED_EXPIRY_REQ* credExpiryData;
    EAP_CONFIG_INPUT_FIELD_ARRAY* credLogonData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eaptypes/ns-eaptypes-eap_interactive_ui_data
struct EAP_INTERACTIVE_UI_DATA
{
    uint               dwVersion;
    uint               dwSize;
    EAP_INTERACTIVE_UI_DATA_TYPE dwDataType;
    uint               cbUiData;
    EAP_UI_DATA_FORMAT pbUiData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eaptypes/ns-eaptypes-eap_method_property_value_bool
struct EAP_METHOD_PROPERTY_VALUE_BOOL
{
    uint length;
    BOOL value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eaptypes/ns-eaptypes-eap_method_property_value_dword
struct EAP_METHOD_PROPERTY_VALUE_DWORD
{
    uint length;
    uint value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eaptypes/ns-eaptypes-eap_method_property_value_string
struct EAP_METHOD_PROPERTY_VALUE_STRING
{
    uint   length;
    ubyte* value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eaptypes/ns-eaptypes-eap_method_property_value
union EAP_METHOD_PROPERTY_VALUE
{
    EAP_METHOD_PROPERTY_VALUE_BOOL empvBool;
    EAP_METHOD_PROPERTY_VALUE_DWORD empvDword;
    EAP_METHOD_PROPERTY_VALUE_STRING empvString;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eaptypes/ns-eaptypes-eap_method_property
struct EAP_METHOD_PROPERTY
{
    EAP_METHOD_PROPERTY_TYPE eapMethodPropertyType;
    EAP_METHOD_PROPERTY_VALUE_TYPE eapMethodPropertyValueType;
    EAP_METHOD_PROPERTY_VALUE eapMethodPropertyValue;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eaptypes/ns-eaptypes-eap_method_property_array
struct EAP_METHOD_PROPERTY_ARRAY
{
    uint                 dwNumberOfProperties;
    EAP_METHOD_PROPERTY* pMethodProperty;
}

struct EAPHOST_IDENTITY_UI_PARAMS
{
    EAP_METHOD_TYPE eapMethodType;
    uint            dwFlags;
    uint            dwSizeofConnectionData;
    ubyte*          pConnectionData;
    uint            dwSizeofUserData;
    ubyte*          pUserData;
    uint            dwSizeofUserDataOut;
    ubyte*          pUserDataOut;
    PWSTR           pwszIdentity;
    uint            dwError;
    EAP_ERROR*      pEapError;
}

struct EAPHOST_INTERACTIVE_UI_PARAMS
{
    uint       dwSizeofContextData;
    ubyte*     pContextData;
    uint       dwSizeofInteractiveUIData;
    ubyte*     pInteractiveUIData;
    uint       dwError;
    EAP_ERROR* pEapError;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eaptypes/ns-eaptypes-eapusernamepasswordcredential
struct EapUsernamePasswordCredential
{
    PWSTR username;
    PWSTR password;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eaptypes/ns-eaptypes-eapcertificatecredential
struct EapCertificateCredential
{
    ubyte[20] certHash;
    PWSTR     password;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eaptypes/ns-eaptypes-eapsimcredential
struct EapSimCredential
{
    PWSTR iccID;
}

union EapCredentialTypeData
{
    EapUsernamePasswordCredential username_password;
    EapCertificateCredential certificate;
    EapSimCredential sim;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eaptypes/ns-eaptypes-eapcredential
struct EapCredential
{
    EapCredentialType credType;
    EapCredentialTypeData credData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eaphostpeertypes/ns-eaphostpeertypes-eaphost_auth_info
struct EAPHOST_AUTH_INFO
{
    EAPHOST_AUTH_STATUS status;
    uint                dwErrorCode;
    uint                dwReasonCode;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eaphostpeertypes/ns-eaphostpeertypes-eaphostpeermethodresult
struct EapHostPeerMethodResult
{
    BOOL             fIsSuccess;
    uint             dwFailureReasonCode;
    BOOL             fSaveConnectionData;
    uint             dwSizeofConnectionData;
    ubyte*           pConnectionData;
    BOOL             fSaveUserData;
    uint             dwSizeofUserData;
    ubyte*           pUserData;
    EAP_ATTRIBUTES*  pAttribArray;
    ISOLATION_STATE  isolationState;
    EAP_METHOD_INFO* pEapMethodInfo;
    EAP_ERROR*       pEapError;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eapmethodtypes/ns-eapmethodtypes-eappacket
struct EapPacket
{
    ubyte    Code;
    ubyte    Id;
    ubyte[2] Length;
    ubyte[1] Data; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eapauthenticatoractiondefine/ns-eapauthenticatoractiondefine-eap_method_authenticator_result
struct EAP_METHOD_AUTHENTICATOR_RESULT
{
    BOOL            fIsSuccess;
    uint            dwFailureReason;
    EAP_ATTRIBUTES* pAuthAttribs;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eapauthenticatoractiondefine/ns-eapauthenticatoractiondefine-eappeermethodoutput
struct EapPeerMethodOutput
{
    EapPeerMethodResponseAction action;
    BOOL fAllowNotifications;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eapmethodpeerapis/ns-eapmethodpeerapis-eappeermethodresult
struct EapPeerMethodResult
{
    BOOL              fIsSuccess;
    uint              dwFailureReasonCode;
    BOOL              fSaveConnectionData;
    uint              dwSizeofConnectionData;
    ubyte*            pConnectionData;
    BOOL              fSaveUserData;
    uint              dwSizeofUserData;
    ubyte*            pUserData;
    EAP_ATTRIBUTES*   pAttribArray;
    EAP_ERROR*        pEapError;
    NgcTicketContext* pNgcKerbTicket;
    BOOL              fSaveToCredMan;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eapmethodpeerapis/ns-eapmethodpeerapis-eap_peer_method_routines
struct EAP_PEER_METHOD_ROUTINES
{
    uint      dwVersion;
    EAP_TYPE* pEapType;
    ptrdiff_t EapPeerInitialize;
    ptrdiff_t EapPeerGetIdentity;
    ptrdiff_t EapPeerBeginSession;
    ptrdiff_t EapPeerSetCredentials;
    ptrdiff_t EapPeerProcessRequestPacket;
    ptrdiff_t EapPeerGetResponsePacket;
    ptrdiff_t EapPeerGetResult;
    ptrdiff_t EapPeerGetUIContext;
    ptrdiff_t EapPeerSetUIContext;
    ptrdiff_t EapPeerGetResponseAttributes;
    ptrdiff_t EapPeerSetResponseAttributes;
    ptrdiff_t EapPeerEndSession;
    ptrdiff_t EapPeerShutdown;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eapmethodauthenticatorapis/ns-eapmethodauthenticatorapis-eap_authenticator_method_routines
struct EAP_AUTHENTICATOR_METHOD_ROUTINES
{
    uint             dwSizeInBytes;
    EAP_METHOD_TYPE* pEapType;
    ptrdiff_t        EapMethodAuthenticatorInitialize;
    ptrdiff_t        EapMethodAuthenticatorBeginSession;
    ptrdiff_t        EapMethodAuthenticatorUpdateInnerMethodParams;
    ptrdiff_t        EapMethodAuthenticatorReceivePacket;
    ptrdiff_t        EapMethodAuthenticatorSendPacket;
    ptrdiff_t        EapMethodAuthenticatorGetAttributes;
    ptrdiff_t        EapMethodAuthenticatorSetAttributes;
    ptrdiff_t        EapMethodAuthenticatorGetResult;
    ptrdiff_t        EapMethodAuthenticatorEndSession;
    ptrdiff_t        EapMethodAuthenticatorShutdown;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("eappcfg.dll")
uint EapHostPeerGetMethods(EAP_METHOD_INFO_ARRAY* pEapMethodInfoArray, EAP_ERROR** ppEapError);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("eappcfg.dll")
uint EapHostPeerGetMethodProperties(uint dwVersion, uint dwFlags, EAP_METHOD_TYPE eapMethodType, 
                                    HANDLE hUserImpersonationToken, uint dwEapConnDataSize, 
                                    const(ubyte)* pbEapConnData, uint dwUserDataSize, const(ubyte)* pbUserData, 
                                    EAP_METHOD_PROPERTY_ARRAY* pMethodPropertyArray, EAP_ERROR** ppEapError);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("eappcfg.dll")
uint EapHostPeerInvokeConfigUI(HWND hwndParent, uint dwFlags, EAP_METHOD_TYPE eapMethodType, uint dwSizeOfConfigIn, 
                               const(ubyte)* pConfigIn, uint* pdwSizeOfConfigOut, ubyte** ppConfigOut, 
                               EAP_ERROR** ppEapError);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("eappcfg.dll")
uint EapHostPeerQueryCredentialInputFields(HANDLE hUserImpersonationToken, EAP_METHOD_TYPE eapMethodType, 
                                           uint dwFlags, uint dwEapConnDataSize, const(ubyte)* pbEapConnData, 
                                           EAP_CONFIG_INPUT_FIELD_ARRAY* pEapConfigInputFieldArray, 
                                           EAP_ERROR** ppEapError);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("eappcfg.dll")
uint EapHostPeerQueryUserBlobFromCredentialInputFields(HANDLE hUserImpersonationToken, 
                                                       EAP_METHOD_TYPE eapMethodType, uint dwFlags, 
                                                       uint dwEapConnDataSize, const(ubyte)* pbEapConnData, 
                                                       const(EAP_CONFIG_INPUT_FIELD_ARRAY)* pEapConfigInputFieldArray, 
                                                       uint* pdwUserBlobSize, ubyte** ppbUserBlob, 
                                                       EAP_ERROR** ppEapError);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("eappcfg.dll")
uint EapHostPeerInvokeIdentityUI(uint dwVersion, EAP_METHOD_TYPE eapMethodType, uint dwFlags, HWND hwndParent, 
                                 uint dwSizeofConnectionData, const(ubyte)* pConnectionData, uint dwSizeofUserData, 
                                 const(ubyte)* pUserData, uint* pdwSizeOfUserDataOut, ubyte** ppUserDataOut, 
                                 PWSTR* ppwszIdentity, EAP_ERROR** ppEapError, void** ppvReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("eappcfg.dll")
uint EapHostPeerInvokeInteractiveUI(HWND hwndParent, uint dwSizeofUIContextData, const(ubyte)* pUIContextData, 
                                    uint* pdwSizeOfDataFromInteractiveUI, ubyte** ppDataFromInteractiveUI, 
                                    EAP_ERROR** ppEapError);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("eappcfg.dll")
uint EapHostPeerQueryInteractiveUIInputFields(uint dwVersion, uint dwFlags, uint dwSizeofUIContextData, 
                                              const(ubyte)* pUIContextData, 
                                              EAP_INTERACTIVE_UI_DATA* pEapInteractiveUIData, EAP_ERROR** ppEapError, 
                                              void** ppvReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("eappcfg.dll")
uint EapHostPeerQueryUIBlobFromInteractiveUIInputFields(uint dwVersion, uint dwFlags, uint dwSizeofUIContextData, 
                                                        const(ubyte)* pUIContextData, 
                                                        const(EAP_INTERACTIVE_UI_DATA)* pEapInteractiveUIData, 
                                                        uint* pdwSizeOfDataFromInteractiveUI, 
                                                        ubyte** ppDataFromInteractiveUI, EAP_ERROR** ppEapError, 
                                                        void** ppvReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("eappcfg.dll")
uint EapHostPeerConfigXml2Blob(uint dwFlags, IXMLDOMNode pConfigDoc, uint* pdwSizeOfConfigOut, ubyte** ppConfigOut, 
                               EAP_METHOD_TYPE* pEapMethodType, EAP_ERROR** ppEapError);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("eappcfg.dll")
uint EapHostPeerCredentialsXml2Blob(uint dwFlags, IXMLDOMNode pCredentialsDoc, uint dwSizeOfConfigIn, 
                                    ubyte* pConfigIn, uint* pdwSizeOfCredentialsOut, ubyte** ppCredentialsOut, 
                                    EAP_METHOD_TYPE* pEapMethodType, EAP_ERROR** ppEapError);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("eappcfg.dll")
uint EapHostPeerConfigBlob2Xml(uint dwFlags, EAP_METHOD_TYPE eapMethodType, uint dwSizeOfConfigIn, 
                               ubyte* pConfigIn, IXMLDOMDocument2* ppConfigDoc, EAP_ERROR** ppEapError);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("eappcfg.dll")
void EapHostPeerFreeMemory(ubyte* pData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("eappcfg.dll")
void EapHostPeerFreeErrorMemory(EAP_ERROR* pEapError);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("eappprxy.dll")
uint EapHostPeerInitialize();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("eappprxy.dll")
void EapHostPeerUninitialize();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("eappprxy.dll")
uint EapHostPeerBeginSession(uint dwFlags, EAP_METHOD_TYPE eapType, const(EAP_ATTRIBUTES)* pAttributeArray, 
                             HANDLE hTokenImpersonateUser, uint dwSizeofConnectionData, 
                             const(ubyte)* pConnectionData, uint dwSizeofUserData, const(ubyte)* pUserData, 
                             uint dwMaxSendPacketSize, const(GUID)* pConnectionId, NotificationHandler func, 
                             void* pContextData, uint* pSessionId, EAP_ERROR** ppEapError);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("eappprxy.dll")
uint EapHostPeerProcessReceivedPacket(uint sessionHandle, uint cbReceivePacket, const(ubyte)* pReceivePacket, 
                                      EapHostPeerResponseAction* pEapOutput, EAP_ERROR** ppEapError);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("eappprxy.dll")
uint EapHostPeerGetSendPacket(uint sessionHandle, uint* pcbSendPacket, ubyte** ppSendPacket, 
                              EAP_ERROR** ppEapError);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("eappprxy.dll")
uint EapHostPeerGetResult(uint sessionHandle, EapHostPeerMethodResultReason reason, 
                          EapHostPeerMethodResult* ppResult, EAP_ERROR** ppEapError);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("eappprxy.dll")
uint EapHostPeerGetUIContext(uint sessionHandle, uint* pdwSizeOfUIContextData, ubyte** ppUIContextData, 
                             EAP_ERROR** ppEapError);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("eappprxy.dll")
uint EapHostPeerSetUIContext(uint sessionHandle, uint dwSizeOfUIContextData, const(ubyte)* pUIContextData, 
                             EapHostPeerResponseAction* pEapOutput, EAP_ERROR** ppEapError);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("eappprxy.dll")
uint EapHostPeerGetResponseAttributes(uint sessionHandle, EAP_ATTRIBUTES* pAttribs, EAP_ERROR** ppEapError);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("eappprxy.dll")
uint EapHostPeerSetResponseAttributes(uint sessionHandle, const(EAP_ATTRIBUTES)* pAttribs, 
                                      EapHostPeerResponseAction* pEapOutput, EAP_ERROR** ppEapError);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("eappprxy.dll")
uint EapHostPeerGetAuthStatus(uint sessionHandle, EapHostPeerAuthParams authParam, uint* pcbAuthData, 
                              ubyte** ppAuthData, EAP_ERROR** ppEapError);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("eappprxy.dll")
uint EapHostPeerEndSession(uint sessionHandle, EAP_ERROR** ppEapError);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("eappprxy.dll")
uint EapHostPeerGetDataToUnplumbCredentials(GUID* pConnectionIdThatLastSavedCreds, 
                                            ptrdiff_t* phCredentialImpersonationToken, uint sessionHandle, 
                                            EAP_ERROR** ppEapError, BOOL* fSaveToCredMan);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("eappprxy.dll")
uint EapHostPeerClearConnection(GUID* pConnectionId, EAP_ERROR** ppEapError);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("eappprxy.dll")
void EapHostPeerFreeEapError(EAP_ERROR* pEapError);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("eappprxy.dll")
uint EapHostPeerGetIdentity(uint dwVersion, uint dwFlags, EAP_METHOD_TYPE eapMethodType, 
                            uint dwSizeofConnectionData, const(ubyte)* pConnectionData, uint dwSizeofUserData, 
                            const(ubyte)* pUserData, HANDLE hTokenImpersonateUser, BOOL* pfInvokeUI, 
                            uint* pdwSizeOfUserDataOut, ubyte** ppUserDataOut, PWSTR* ppwszIdentity, 
                            EAP_ERROR** ppEapError, ubyte** ppvReserved);

@DllImport("eappprxy.dll")
uint EapHostPeerGetEncryptedPassword(uint dwSizeofPassword, 
                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/PWSTR szPassword, 
                                     PWSTR* ppszEncPassword);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("eappprxy.dll")
void EapHostPeerFreeRuntimeMemory(ubyte* pData);


// Interfaces

@GUID("66a2db16-d706-11d0-a37b-00c04fc9da04")
interface IRouterProtocolConfig : IUnknown
{
    HRESULT AddProtocol(const(PWSTR) pszMachineName, uint dwTransportId, uint dwProtocolId, HWND hWnd, 
                        uint dwFlags, IUnknown pRouter, size_t uReserved1);
    HRESULT RemoveProtocol(const(PWSTR) pszMachineName, uint dwTransportId, uint dwProtocolId, HWND hWnd, 
                           uint dwFlags, IUnknown pRouter, size_t uReserved1);
}

@GUID("66a2db17-d706-11d0-a37b-00c04fc9da04")
interface IAuthenticationProviderConfig : IUnknown
{
    HRESULT Initialize(const(PWSTR) pszMachineName, size_t* puConnectionParam);
    HRESULT Uninitialize(size_t uConnectionParam);
    HRESULT Configure(size_t uConnectionParam, HWND hWnd, uint dwFlags, size_t uReserved1, size_t uReserved2);
    HRESULT Activate(size_t uConnectionParam, size_t uReserved1, size_t uReserved2);
    HRESULT Deactivate(size_t uConnectionParam, size_t uReserved1, size_t uReserved2);
}

@GUID("66a2db18-d706-11d0-a37b-00c04fc9da04")
interface IAccountingProviderConfig : IUnknown
{
    HRESULT Initialize(const(PWSTR) pszMachineName, size_t* puConnectionParam);
    HRESULT Uninitialize(size_t uConnectionParam);
    HRESULT Configure(size_t uConnectionParam, HWND hWnd, uint dwFlags, size_t uReserved1, size_t uReserved2);
    HRESULT Activate(size_t uConnectionParam, size_t uReserved1, size_t uReserved2);
    HRESULT Deactivate(size_t uConnectionParam, size_t uReserved1, size_t uReserved2);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rrascfg/nn-rrascfg-ieapproviderconfig
@GUID("66a2db19-d706-11d0-a37b-00c04fc9da04")
interface IEAPProviderConfig : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rrascfg/nf-rrascfg-ieapproviderconfig-initialize
    HRESULT Initialize(const(PWSTR) pszMachineName, uint dwEapTypeId, size_t* puConnectionParam);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rrascfg/nf-rrascfg-ieapproviderconfig-uninitialize
    HRESULT Uninitialize(uint dwEapTypeId, size_t uConnectionParam);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rrascfg/nf-rrascfg-ieapproviderconfig-serverinvokeconfigui
    HRESULT ServerInvokeConfigUI(uint dwEapTypeId, size_t uConnectionParam, HWND hWnd, size_t uReserved1, 
                                 size_t uReserved2);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rrascfg/nf-rrascfg-ieapproviderconfig-routerinvokeconfigui
    HRESULT RouterInvokeConfigUI(uint dwEapTypeId, size_t uConnectionParam, HWND hwndParent, uint dwFlags, 
                                 ubyte* pConnectionDataIn, uint dwSizeOfConnectionDataIn, 
                                 ubyte** ppConnectionDataOut, uint* pdwSizeOfConnectionDataOut);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rrascfg/nf-rrascfg-ieapproviderconfig-routerinvokecredentialsui
    HRESULT RouterInvokeCredentialsUI(uint dwEapTypeId, size_t uConnectionParam, HWND hwndParent, uint dwFlags, 
                                      ubyte* pConnectionDataIn, uint dwSizeOfConnectionDataIn, ubyte* pUserDataIn, 
                                      uint dwSizeOfUserDataIn, ubyte** ppUserDataOut, uint* pdwSizeOfUserDataOut);
}

@GUID("d565917a-85c4-4466-856e-671c3742ea9a")
interface IEAPProviderConfig2 : IEAPProviderConfig
{
    HRESULT ServerInvokeConfigUI2(uint dwEapTypeId, size_t uConnectionParam, HWND hWnd, 
                                  const(ubyte)* pConfigDataIn, uint dwSizeOfConfigDataIn, ubyte** ppConfigDataOut, 
                                  uint* pdwSizeOfConfigDataOut);
    HRESULT GetGlobalConfig(uint dwEapTypeId, ubyte** ppConfigDataOut, uint* pdwSizeOfConfigDataOut);
}

@GUID("b78ecd12-68bb-4f86-9bf0-8438dd3be982")
interface IEAPProviderConfig3 : IEAPProviderConfig2
{
    HRESULT ServerInvokeCertificateConfigUI(uint dwEapTypeId, size_t uConnectionParam, HWND hWnd, 
                                            const(ubyte)* pConfigDataIn, uint dwSizeOfConfigDataIn, 
                                            ubyte** ppConfigDataOut, uint* pdwSizeOfConfigDataOut, size_t uReserved);
}


// GUIDs


const GUID IID_IAccountingProviderConfig     = GUIDOF!IAccountingProviderConfig;
const GUID IID_IAuthenticationProviderConfig = GUIDOF!IAuthenticationProviderConfig;
const GUID IID_IEAPProviderConfig            = GUIDOF!IEAPProviderConfig;
const GUID IID_IEAPProviderConfig2           = GUIDOF!IEAPProviderConfig2;
const GUID IID_IEAPProviderConfig3           = GUIDOF!IEAPProviderConfig3;
const GUID IID_IRouterProtocolConfig         = GUIDOF!IRouterProtocolConfig;
