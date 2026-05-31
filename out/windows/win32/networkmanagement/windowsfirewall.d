// Written in the D programming language.

module windows.win32.networkmanagement.windowsfirewall;

public import windows.core;
public import system.system : Guid;
public import windows.win32.foundation.foundation : BOOL, BSTR, HANDLE, HRESULT, HWND,
                                                    PWSTR, VARIANT_BOOL;
public import windows.win32.security.security : PSID, SID, SID_AND_ATTRIBUTES;
public import windows.win32.system.com.com : IDispatch, IUnknown;
public import windows.win32.system.ole : IEnumVARIANT;
public import windows.win32.system.variant : VARIANT;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/ne-netcon-netcon_characteristic_flags
alias NETCON_CHARACTERISTIC_FLAGS = int;
enum : int
{
    NCCF_NONE              = 0x00000000,
    NCCF_ALL_USERS         = 0x00000001,
    NCCF_ALLOW_DUPLICATION = 0x00000002,
    NCCF_ALLOW_REMOVAL     = 0x00000004,
    NCCF_ALLOW_RENAME      = 0x00000008,
    NCCF_INCOMING_ONLY     = 0x00000020,
    NCCF_OUTGOING_ONLY     = 0x00000040,
    NCCF_BRANDED           = 0x00000080,
    NCCF_SHARED            = 0x00000100,
    NCCF_BRIDGED           = 0x00000200,
    NCCF_FIREWALLED        = 0x00000400,
    NCCF_DEFAULT           = 0x00000800,
    NCCF_HOMENET_CAPABLE   = 0x00001000,
    NCCF_SHARED_PRIVATE    = 0x00002000,
    NCCF_QUARANTINED       = 0x00004000,
    NCCF_RESERVED          = 0x00008000,
    NCCF_HOSTED_NETWORK    = 0x00010000,
    NCCF_VIRTUAL_STATION   = 0x00020000,
    NCCF_WIFI_DIRECT       = 0x00040000,
    NCCF_BLUETOOTH_MASK    = 0x000f0000,
    NCCF_LAN_MASK          = 0x00f00000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/ne-netcon-netcon_status
alias NETCON_STATUS = int;
enum : int
{
    NCS_DISCONNECTED             = 0x00000000,
    NCS_CONNECTING               = 0x00000001,
    NCS_CONNECTED                = 0x00000002,
    NCS_DISCONNECTING            = 0x00000003,
    NCS_HARDWARE_NOT_PRESENT     = 0x00000004,
    NCS_HARDWARE_DISABLED        = 0x00000005,
    NCS_HARDWARE_MALFUNCTION     = 0x00000006,
    NCS_MEDIA_DISCONNECTED       = 0x00000007,
    NCS_AUTHENTICATING           = 0x00000008,
    NCS_AUTHENTICATION_SUCCEEDED = 0x00000009,
    NCS_AUTHENTICATION_FAILED    = 0x0000000a,
    NCS_INVALID_ADDRESS          = 0x0000000b,
    NCS_CREDENTIALS_REQUIRED     = 0x0000000c,
    NCS_ACTION_REQUIRED          = 0x0000000d,
    NCS_ACTION_REQUIRED_RETRY    = 0x0000000e,
    NCS_CONNECT_FAILED           = 0x0000000f,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/ne-netcon-netcon_type
alias NETCON_TYPE = int;
enum : int
{
    NCT_DIRECT_CONNECT = 0x00000000,
    NCT_INBOUND        = 0x00000001,
    NCT_INTERNET       = 0x00000002,
    NCT_LAN            = 0x00000003,
    NCT_PHONE          = 0x00000004,
    NCT_TUNNEL         = 0x00000005,
    NCT_BRIDGE         = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/ne-netcon-netcon_mediatype
alias NETCON_MEDIATYPE = int;
enum : int
{
    NCM_NONE                 = 0x00000000,
    NCM_DIRECT               = 0x00000001,
    NCM_ISDN                 = 0x00000002,
    NCM_LAN                  = 0x00000003,
    NCM_PHONE                = 0x00000004,
    NCM_TUNNEL               = 0x00000005,
    NCM_PPPOE                = 0x00000006,
    NCM_BRIDGE               = 0x00000007,
    NCM_SHAREDACCESSHOST_LAN = 0x00000008,
    NCM_SHAREDACCESSHOST_RAS = 0x00000009,
}

alias NETCONMGR_ENUM_FLAGS = int;
enum : int
{
    NCME_DEFAULT = 0x00000000,
    NCME_HIDDEN  = 0x00000001,
}

alias NETCONUI_CONNECT_FLAGS = int;
enum : int
{
    NCUC_DEFAULT        = 0x00000000,
    NCUC_NO_UI          = 0x00000001,
    NCUC_ENABLE_DISABLE = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/ne-netcon-sharingconnectiontype
alias SHARINGCONNECTIONTYPE = int;
enum : int
{
    ICSSHARINGTYPE_PUBLIC  = 0x00000000,
    ICSSHARINGTYPE_PRIVATE = 0x00000001,
}

alias SHARINGCONNECTION_ENUM_FLAGS = int;
enum : int
{
    ICSSC_DEFAULT = 0x00000000,
    ICSSC_ENABLED = 0x00000001,
}

alias ICS_TARGETTYPE = int;
enum : int
{
    ICSTT_NAME      = 0x00000000,
    ICSTT_IPADDRESS = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icftypes/ne-icftypes-net_fw_policy_type
alias NET_FW_POLICY_TYPE = int;
enum : int
{
    NET_FW_POLICY_GROUP     = 0x00000000,
    NET_FW_POLICY_LOCAL     = 0x00000001,
    NET_FW_POLICY_EFFECTIVE = 0x00000002,
    NET_FW_POLICY_TYPE_MAX  = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icftypes/ne-icftypes-net_fw_profile_type
alias NET_FW_PROFILE_TYPE = int;
enum : int
{
    NET_FW_PROFILE_DOMAIN   = 0x00000000,
    NET_FW_PROFILE_STANDARD = 0x00000001,
    NET_FW_PROFILE_CURRENT  = 0x00000002,
    NET_FW_PROFILE_TYPE_MAX = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icftypes/ne-icftypes-net_fw_profile_type2
alias NET_FW_PROFILE_TYPE2 = int;
enum : int
{
    NET_FW_PROFILE2_DOMAIN  = 0x00000001,
    NET_FW_PROFILE2_PRIVATE = 0x00000002,
    NET_FW_PROFILE2_PUBLIC  = 0x00000004,
    NET_FW_PROFILE2_ALL     = 0x7fffffff,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icftypes/ne-icftypes-net_fw_ip_version
alias NET_FW_IP_VERSION = int;
enum : int
{
    NET_FW_IP_VERSION_V4  = 0x00000000,
    NET_FW_IP_VERSION_V6  = 0x00000001,
    NET_FW_IP_VERSION_ANY = 0x00000002,
    NET_FW_IP_VERSION_MAX = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icftypes/ne-icftypes-net_fw_scope
alias NET_FW_SCOPE = int;
enum : int
{
    NET_FW_SCOPE_ALL          = 0x00000000,
    NET_FW_SCOPE_LOCAL_SUBNET = 0x00000001,
    NET_FW_SCOPE_CUSTOM       = 0x00000002,
    NET_FW_SCOPE_MAX          = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icftypes/ne-icftypes-net_fw_ip_protocol
alias NET_FW_IP_PROTOCOL = int;
enum : int
{
    NET_FW_IP_PROTOCOL_TCP = 0x00000006,
    NET_FW_IP_PROTOCOL_UDP = 0x00000011,
    NET_FW_IP_PROTOCOL_ANY = 0x00000100,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icftypes/ne-icftypes-net_fw_service_type
alias NET_FW_SERVICE_TYPE = int;
enum : int
{
    NET_FW_SERVICE_FILE_AND_PRINT = 0x00000000,
    NET_FW_SERVICE_UPNP           = 0x00000001,
    NET_FW_SERVICE_REMOTE_DESKTOP = 0x00000002,
    NET_FW_SERVICE_NONE           = 0x00000003,
    NET_FW_SERVICE_TYPE_MAX       = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icftypes/ne-icftypes-net_fw_rule_direction
alias NET_FW_RULE_DIRECTION = int;
enum : int
{
    NET_FW_RULE_DIR_IN  = 0x00000001,
    NET_FW_RULE_DIR_OUT = 0x00000002,
    NET_FW_RULE_DIR_MAX = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icftypes/ne-icftypes-net_fw_action
alias NET_FW_ACTION = int;
enum : int
{
    NET_FW_ACTION_BLOCK = 0x00000000,
    NET_FW_ACTION_ALLOW = 0x00000001,
    NET_FW_ACTION_MAX   = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icftypes/ne-icftypes-net_fw_modify_state
alias NET_FW_MODIFY_STATE = int;
enum : int
{
    NET_FW_MODIFY_STATE_OK              = 0x00000000,
    NET_FW_MODIFY_STATE_GP_OVERRIDE     = 0x00000001,
    NET_FW_MODIFY_STATE_INBOUND_BLOCKED = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icftypes/ne-icftypes-net_fw_rule_category
alias NET_FW_RULE_CATEGORY = int;
enum : int
{
    NET_FW_RULE_CATEGORY_BOOT     = 0x00000000,
    NET_FW_RULE_CATEGORY_STEALTH  = 0x00000001,
    NET_FW_RULE_CATEGORY_FIREWALL = 0x00000002,
    NET_FW_RULE_CATEGORY_CONSEC   = 0x00000003,
    NET_FW_RULE_CATEGORY_MAX      = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icftypes/ne-icftypes-net_fw_edge_traversal_type
alias NET_FW_EDGE_TRAVERSAL_TYPE = int;
enum : int
{
    NET_FW_EDGE_TRAVERSAL_TYPE_DENY          = 0x00000000,
    NET_FW_EDGE_TRAVERSAL_TYPE_ALLOW         = 0x00000001,
    NET_FW_EDGE_TRAVERSAL_TYPE_DEFER_TO_APP  = 0x00000002,
    NET_FW_EDGE_TRAVERSAL_TYPE_DEFER_TO_USER = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icftypes/ne-icftypes-net_fw_authenticate_type
alias NET_FW_AUTHENTICATE_TYPE = int;
enum : int
{
    NET_FW_AUTHENTICATE_NONE                     = 0x00000000,
    NET_FW_AUTHENTICATE_NO_ENCAPSULATION         = 0x00000001,
    NET_FW_AUTHENTICATE_WITH_INTEGRITY           = 0x00000002,
    NET_FW_AUTHENTICATE_AND_NEGOTIATE_ENCRYPTION = 0x00000003,
    NET_FW_AUTHENTICATE_AND_ENCRYPT              = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/ne-netfw-netiso_flag
alias NETISO_FLAG = int;
enum : int
{
    NETISO_FLAG_FORCE_COMPUTE_BINARIES = 0x00000001,
    NETISO_FLAG_MAX                    = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/ne-netfw-inet_firewall_ac_creation_type
alias INET_FIREWALL_AC_CREATION_TYPE = int;
enum : int
{
    INET_FIREWALL_AC_NONE            = 0x00000000,
    INET_FIREWALL_AC_PACKAGE_ID_ONLY = 0x00000001,
    INET_FIREWALL_AC_BINARY          = 0x00000002,
    INET_FIREWALL_AC_MAX             = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/ne-netfw-inet_firewall_ac_change_type
alias INET_FIREWALL_AC_CHANGE_TYPE = int;
enum : int
{
    INET_FIREWALL_AC_CHANGE_INVALID = 0x00000000,
    INET_FIREWALL_AC_CHANGE_CREATE  = 0x00000001,
    INET_FIREWALL_AC_CHANGE_DELETE  = 0x00000002,
    INET_FIREWALL_AC_CHANGE_MAX     = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/ne-netfw-netiso_error_type
alias NETISO_ERROR_TYPE = int;
enum : int
{
    NETISO_ERROR_TYPE_NONE                   = 0x00000000,
    NETISO_ERROR_TYPE_PRIVATE_NETWORK        = 0x00000001,
    NETISO_ERROR_TYPE_INTERNET_CLIENT        = 0x00000002,
    NETISO_ERROR_TYPE_INTERNET_CLIENT_SERVER = 0x00000003,
    NETISO_ERROR_TYPE_MAX                    = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/ne-netfw-fw_dynamic_keyword_origin_type
alias FW_DYNAMIC_KEYWORD_ORIGIN_TYPE = int;
enum : int
{
    FW_DYNAMIC_KEYWORD_ORIGIN_INVALID = 0x00000000,
    FW_DYNAMIC_KEYWORD_ORIGIN_LOCAL   = 0x00000001,
    FW_DYNAMIC_KEYWORD_ORIGIN_MDM     = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/ne-netfw-fw_dynamic_keyword_address_flags
alias FW_DYNAMIC_KEYWORD_ADDRESS_FLAGS = int;
enum : int
{
    FW_DYNAMIC_KEYWORD_ADDRESS_FLAGS_AUTO_RESOLVE = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/ne-netfw-fw_dynamic_keyword_address_enum_flags
alias FW_DYNAMIC_KEYWORD_ADDRESS_ENUM_FLAGS = int;
enum : int
{
    FW_DYNAMIC_KEYWORD_ADDRESS_ENUM_FLAGS_AUTO_RESOLVE     = 0x00000001,
    FW_DYNAMIC_KEYWORD_ADDRESS_ENUM_FLAGS_NON_AUTO_RESOLVE = 0x00000002,
    FW_DYNAMIC_KEYWORD_ADDRESS_ENUM_FLAGS_ALL              = 0x00000003,
}

// Constants


enum uint NETCON_MAX_NAME_LEN = 0x00000100U;
enum HRESULT S_OBJECT_NO_LONGER_VALID = HRESULT(0x00000002);

enum : uint
{
    NETISO_GEID_FOR_WDAG          = 0x00000001U,
    NETISO_GEID_FOR_NEUTRAL_AWARE = 0x00000002U,
}

// Callbacks

alias PAC_CHANGES_CALLBACK_FN = void function(void* context, const(INET_FIREWALL_AC_CHANGE)* pChange);
alias PNETISO_EDP_ID_CALLBACK_FN = void function(void* context, const(PWSTR) wszEnterpriseId, uint dwErr);
alias PFN_FWADDDYNAMICKEYWORDADDRESS0 = uint function(const(FW_DYNAMIC_KEYWORD_ADDRESS0)* dynamicKeywordAddress);
alias PFN_FWDELETEDYNAMICKEYWORDADDRESS0 = uint function(GUID dynamicKeywordAddressId);
alias PFN_FWENUMDYNAMICKEYWORDADDRESSESBYTYPE0 = uint function(uint flags, 
                                                               FW_DYNAMIC_KEYWORD_ADDRESS_DATA0** dynamicKeywordAddressData);
alias PFN_FWENUMDYNAMICKEYWORDADDRESSBYID0 = uint function(GUID dynamicKeywordAddressId, 
                                                           FW_DYNAMIC_KEYWORD_ADDRESS_DATA0** dynamicKeywordAddressData);
alias PFN_FWFREEDYNAMICKEYWORDADDRESSDATA0 = uint function(FW_DYNAMIC_KEYWORD_ADDRESS_DATA0* dynamicKeywordAddressData);
alias PFN_FWUPDATEDYNAMICKEYWORDADDRESS0 = uint function(GUID dynamicKeywordAddressId, 
                                                         const(PWSTR) updatedAddresses, BOOL append);

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/ns-netcon-netcon_properties
struct NETCON_PROPERTIES
{
    GUID             guidId;
    PWSTR            pszwName;
    PWSTR            pszwDeviceName;
    NETCON_STATUS    Status;
    NETCON_MEDIATYPE MediaType;
    uint             dwCharacter;
    GUID             clsidThisObject;
    GUID             clsidUiObject;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/ns-netfw-inet_firewall_ac_capabilities
struct INET_FIREWALL_AC_CAPABILITIES
{
    uint                count;
    SID_AND_ATTRIBUTES* capabilities;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/ns-netfw-inet_firewall_ac_binaries
struct INET_FIREWALL_AC_BINARIES
{
    uint   count;
    PWSTR* binaries;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/ns-netfw-inet_firewall_ac_change
struct INET_FIREWALL_AC_CHANGE
{
    INET_FIREWALL_AC_CHANGE_TYPE changeType;
    INET_FIREWALL_AC_CREATION_TYPE createType;
    SID*  appContainerSid;
    SID*  userSid;
    PWSTR displayName;
    union
    {
        INET_FIREWALL_AC_CAPABILITIES capabilities;
        INET_FIREWALL_AC_BINARIES binaries;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/ns-netfw-inet_firewall_app_container
struct INET_FIREWALL_APP_CONTAINER
{
    SID*  appContainerSid;
    SID*  userSid;
    PWSTR appContainerName;
    PWSTR displayName;
    PWSTR description;
    INET_FIREWALL_AC_CAPABILITIES capabilities;
    INET_FIREWALL_AC_BINARIES binaries;
    PWSTR workingDirectory;
    PWSTR packageFullName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/ns-netfw-fw_dynamic_keyword_address0
struct FW_DYNAMIC_KEYWORD_ADDRESS0
{
    GUID         id;
    const(PWSTR) keyword;
    uint         flags;
    const(PWSTR) addresses;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/ns-netfw-fw_dynamic_keyword_address_data0
struct FW_DYNAMIC_KEYWORD_ADDRESS_DATA0
{
    FW_DYNAMIC_KEYWORD_ADDRESS0 dynamicKeywordAddress;
    FW_DYNAMIC_KEYWORD_ADDRESS_DATA0* next;
    ushort schemaVersion;
    FW_DYNAMIC_KEYWORD_ORIGIN_TYPE originType;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("Netshell.dll")
void NcFreeNetconProperties(NETCON_PROPERTIES* pProps);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("Netshell.dll")
BOOL NcIsValidConnectionName(const(PWSTR) pszwName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-net-isolation-l1-1-0.dll")
HRESULT NetworkIsolationSetupAppContainerBinaries(PSID applicationContainerSid, const(PWSTR) packageFullName, 
                                                  const(PWSTR) packageFolder, const(PWSTR) displayName, 
                                                  BOOL bBinariesFullyComputed, const(PWSTR)* binaries, 
                                                  uint binariesCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-net-isolation-l1-1-0.dll")
uint NetworkIsolationRegisterForAppContainerChanges(uint flags, PAC_CHANGES_CALLBACK_FN callback, void* context, 
                                                    HANDLE* registrationObject);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-net-isolation-l1-1-0.dll")
uint NetworkIsolationUnregisterForAppContainerChanges(HANDLE registrationObject);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("Firewallapi.dll")
HRESULT NetworkIsolationEnumerateAppContainerRules(IEnumVARIANT* newEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-net-isolation-l1-1-0.dll")
uint NetworkIsolationFreeAppContainers(INET_FIREWALL_APP_CONTAINER* pPublicAppCs);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-net-isolation-l1-1-0.dll")
uint NetworkIsolationEnumAppContainers(uint Flags, uint* pdwNumPublicAppCs, 
                                       INET_FIREWALL_APP_CONTAINER** ppPublicAppCs);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-net-isolation-l1-1-0.dll")
uint NetworkIsolationGetAppContainerConfig(uint* pdwNumPublicAppCs, SID_AND_ATTRIBUTES** appContainerSids);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-net-isolation-l1-1-0.dll")
uint NetworkIsolationSetAppContainerConfig(uint dwNumPublicAppCs, SID_AND_ATTRIBUTES* appContainerSids);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-net-isolation-l1-1-0.dll")
uint NetworkIsolationDiagnoseConnectFailureAndGetInfo(const(PWSTR) wszServerName, NETISO_ERROR_TYPE* netIsoError);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("Firewallapi.dll")
uint NetworkIsolationGetEnterpriseIdAsync(const(PWSTR) wszServerName, uint dwFlags, void* context, 
                                          PNETISO_EDP_ID_CALLBACK_FN callback, HANDLE* hOperation);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("Firewallapi.dll")
uint NetworkIsolationGetEnterpriseIdClose(HANDLE hOperation, BOOL bWaitForOperation);


// Interfaces

@GUID("ae1e00aa-3fd5-403c-8a27-2bbdc30cd0e1")
struct UPnPNAT;

@GUID("5c63c1ad-3956-4ff8-8486-40034758315b")
struct NetSharingManager;

@GUID("2c5bc43e-3369-4c33-ab0c-be9469677af4")
struct NetFwRule;

@GUID("0ca545c6-37ad-4a6c-bf92-9f7610067ef5")
struct NetFwOpenPort;

@GUID("ec9846b3-2762-4a6b-a214-6acb603462d2")
struct NetFwAuthorizedApplication;

@GUID("e2b3c97f-6ae1-41ac-817a-f6f92166d7dd")
struct NetFwPolicy2;

@GUID("9d745ed8-c514-4d1d-bf42-751fed2d5ac7")
struct NetFwProduct;

@GUID("cc19079b-8272-4d73-bb70-cdb533527b61")
struct NetFwProducts;

@GUID("304ce942-6e39-40d8-943a-b913c40c9cd4")
struct NetFwMgr;

@GUID("b171c812-cc76-485a-94d8-b6b3a2794e99")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/natupnp/nn-natupnp-iupnpnat
interface IUPnPNAT : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/natupnp/nf-natupnp-iupnpnat-get_staticportmappingcollection
    HRESULT get_StaticPortMappingCollection(IStaticPortMappingCollection* ppSPMs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/natupnp/nn-natupnp-iupnpnat
    HRESULT get_DynamicPortMappingCollection(IDynamicPortMappingCollection* ppDPMs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/natupnp/nf-natupnp-iupnpnat-get_nateventmanager
    HRESULT get_NATEventManager(INATEventManager* ppNEM);
}

@GUID("624bd588-9060-4109-b0b0-1adbbcac32df")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/natupnp/nn-natupnp-inateventmanager
interface INATEventManager : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/natupnp/nf-natupnp-inateventmanager-put_externalipaddresscallback
    HRESULT put_ExternalIPAddressCallback(IUnknown pUnk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/natupnp/nf-natupnp-inateventmanager-put_numberofentriescallback
    HRESULT put_NumberOfEntriesCallback(IUnknown pUnk);
}

@GUID("9c416740-a34e-446f-ba06-abd04c3149ae")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/natupnp/nn-natupnp-inatexternalipaddresscallback
interface INATExternalIPAddressCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/natupnp/nf-natupnp-inatexternalipaddresscallback-newexternalipaddress
    HRESULT NewExternalIPAddress(BSTR bstrNewExternalIPAddress);
}

@GUID("c83a0a74-91ee-41b6-b67a-67e0f00bbd78")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/natupnp/nn-natupnp-inatnumberofentriescallback
interface INATNumberOfEntriesCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/natupnp/nf-natupnp-inatnumberofentriescallback-newnumberofentries
    HRESULT NewNumberOfEntries(int lNewNumberOfEntries);
}

@GUID("b60de00f-156e-4e8d-9ec1-3a2342c10899")
interface IDynamicPortMappingCollection : IDispatch
{
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT get_Item(BSTR bstrRemoteHost, int lExternalPort, BSTR bstrProtocol, IDynamicPortMapping* ppDPM);
    HRESULT get_Count(int* pVal);
    HRESULT Remove(BSTR bstrRemoteHost, int lExternalPort, BSTR bstrProtocol);
    HRESULT Add(BSTR bstrRemoteHost, int lExternalPort, BSTR bstrProtocol, int lInternalPort, 
                BSTR bstrInternalClient, VARIANT_BOOL bEnabled, BSTR bstrDescription, int lLeaseDuration, 
                IDynamicPortMapping* ppDPM);
}

@GUID("4fc80282-23b6-4378-9a27-cd8f17c9400c")
interface IDynamicPortMapping : IDispatch
{
    HRESULT get_ExternalIPAddress(BSTR* pVal);
    HRESULT get_RemoteHost(BSTR* pVal);
    HRESULT get_ExternalPort(int* pVal);
    HRESULT get_Protocol(BSTR* pVal);
    HRESULT get_InternalPort(int* pVal);
    HRESULT get_InternalClient(BSTR* pVal);
    HRESULT get_Enabled(VARIANT_BOOL* pVal);
    HRESULT get_Description(BSTR* pVal);
    HRESULT get_LeaseDuration(int* pVal);
    HRESULT RenewLease(int lLeaseDurationDesired, int* pLeaseDurationReturned);
    HRESULT EditInternalClient(BSTR bstrInternalClient);
    HRESULT Enable(VARIANT_BOOL vb);
    HRESULT EditDescription(BSTR bstrDescription);
    HRESULT EditInternalPort(int lInternalPort);
}

@GUID("cd1f3e77-66d6-4664-82c7-36dbb641d0f1")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/natupnp/nn-natupnp-istaticportmappingcollection
interface IStaticPortMappingCollection : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/natupnp/nf-natupnp-istaticportmappingcollection-get__newenum
    HRESULT get__NewEnum(IUnknown* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/natupnp/nf-natupnp-istaticportmappingcollection-get_item
    HRESULT get_Item(int lExternalPort, BSTR bstrProtocol, IStaticPortMapping* ppSPM);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/natupnp/nf-natupnp-istaticportmappingcollection-get_count
    HRESULT get_Count(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/natupnp/nf-natupnp-istaticportmappingcollection-remove
    HRESULT Remove(int lExternalPort, BSTR bstrProtocol);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/natupnp/nf-natupnp-istaticportmappingcollection-add
    HRESULT Add(int lExternalPort, BSTR bstrProtocol, int lInternalPort, BSTR bstrInternalClient, 
                VARIANT_BOOL bEnabled, BSTR bstrDescription, IStaticPortMapping* ppSPM);
}

@GUID("6f10711f-729b-41e5-93b8-f21d0f818df1")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/natupnp/nn-natupnp-istaticportmapping
interface IStaticPortMapping : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/natupnp/nf-natupnp-istaticportmapping-get_externalipaddress
    HRESULT get_ExternalIPAddress(BSTR* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/natupnp/nf-natupnp-istaticportmapping-get_externalport
    HRESULT get_ExternalPort(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/natupnp/nf-natupnp-istaticportmapping-get_internalport
    HRESULT get_InternalPort(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/natupnp/nf-natupnp-istaticportmapping-get_protocol
    HRESULT get_Protocol(BSTR* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/natupnp/nf-natupnp-istaticportmapping-get_internalclient
    HRESULT get_InternalClient(BSTR* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/natupnp/nf-natupnp-istaticportmapping-get_enabled
    HRESULT get_Enabled(VARIANT_BOOL* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/natupnp/nf-natupnp-istaticportmapping-get_description
    HRESULT get_Description(BSTR* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/natupnp/nf-natupnp-istaticportmapping-editinternalclient
    HRESULT EditInternalClient(BSTR bstrInternalClient);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/natupnp/nf-natupnp-istaticportmapping-enable
    HRESULT Enable(VARIANT_BOOL vb);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/natupnp/nf-natupnp-istaticportmapping-editdescription
    HRESULT EditDescription(BSTR bstrDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/natupnp/nf-natupnp-istaticportmapping-editinternalport
    HRESULT EditInternalPort(int lInternalPort);
}

@GUID("c08956a0-1cd3-11d1-b1c5-00805fc1270e")
interface IEnumNetConnection : IUnknown
{
    HRESULT Next(uint celt, INetConnection* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumNetConnection* ppenum);
}

@GUID("c08956a1-1cd3-11d1-b1c5-00805fc1270e")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nn-netcon-inetconnection
interface INetConnection : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-inetconnection-connect
    HRESULT Connect();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-inetconnection-disconnect
    HRESULT Disconnect();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-inetconnection-delete
    HRESULT Delete();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-inetconnection-duplicate
    HRESULT Duplicate(const(PWSTR) pszwDuplicateName, INetConnection* ppCon);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-inetconnection-getproperties
    HRESULT GetProperties(NETCON_PROPERTIES** ppProps);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-inetconnection-getuiobjectclassid
    HRESULT GetUiObjectClassId(GUID* pclsid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-inetconnection-rename
    HRESULT Rename(const(PWSTR) pszwNewName);
}

@GUID("c08956a2-1cd3-11d1-b1c5-00805fc1270e")
interface INetConnectionManager : IUnknown
{
    HRESULT EnumConnections(NETCONMGR_ENUM_FLAGS Flags, IEnumNetConnection* ppEnum);
}

@GUID("c08956a3-1cd3-11d1-b1c5-00805fc1270e")
interface INetConnectionConnectUi : IUnknown
{
    HRESULT SetConnection(INetConnection pCon);
    HRESULT Connect(HWND hwndParent, uint dwFlags);
    HRESULT Disconnect(HWND hwndParent, uint dwFlags);
}

@GUID("c08956b0-1cd3-11d1-b1c5-00805fc1270e")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nn-netcon-ienumnetsharingportmapping
interface IEnumNetSharingPortMapping : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-ienumnetsharingportmapping-next
    HRESULT Next(uint celt, VARIANT* rgVar, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-ienumnetsharingportmapping-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-ienumnetsharingportmapping-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-ienumnetsharingportmapping-clone
    HRESULT Clone(IEnumNetSharingPortMapping* ppenum);
}

@GUID("24b7e9b5-e38f-4685-851b-00892cf5f940")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nn-netcon-inetsharingportmappingprops
interface INetSharingPortMappingProps : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-inetsharingportmappingprops-get_name
    HRESULT get_Name(BSTR* pbstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-inetsharingportmappingprops-get_ipprotocol
    HRESULT get_IPProtocol(ubyte* pucIPProt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-inetsharingportmappingprops-get_externalport
    HRESULT get_ExternalPort(int* pusPort);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-inetsharingportmappingprops-get_internalport
    HRESULT get_InternalPort(int* pusPort);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-inetsharingportmappingprops-get_options
    HRESULT get_Options(int* pdwOptions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-inetsharingportmappingprops-get_targetname
    HRESULT get_TargetName(BSTR* pbstrTargetName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-inetsharingportmappingprops-get_targetipaddress
    HRESULT get_TargetIPAddress(BSTR* pbstrTargetIPAddress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-inetsharingportmappingprops-get_enabled
    HRESULT get_Enabled(VARIANT_BOOL* pbool);
}

@GUID("c08956b1-1cd3-11d1-b1c5-00805fc1270e")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nn-netcon-inetsharingportmapping
interface INetSharingPortMapping : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-inetsharingportmapping-disable
    HRESULT Disable();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-inetsharingportmapping-enable
    HRESULT Enable();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-inetsharingportmapping-get_properties
    HRESULT get_Properties(INetSharingPortMappingProps* ppNSPMP);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-inetsharingportmapping-delete
    HRESULT Delete();
}

@GUID("c08956b8-1cd3-11d1-b1c5-00805fc1270e")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nn-netcon-ienumnetsharingeveryconnection
interface IEnumNetSharingEveryConnection : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-ienumnetsharingeveryconnection-next
    HRESULT Next(uint celt, VARIANT* rgVar, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-ienumnetsharingeveryconnection-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-ienumnetsharingeveryconnection-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-ienumnetsharingeveryconnection-clone
    HRESULT Clone(IEnumNetSharingEveryConnection* ppenum);
}

@GUID("c08956b4-1cd3-11d1-b1c5-00805fc1270e")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nn-netcon-ienumnetsharingpublicconnection
interface IEnumNetSharingPublicConnection : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-ienumnetsharingpublicconnection-next
    HRESULT Next(uint celt, VARIANT* rgVar, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-ienumnetsharingpublicconnection-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-ienumnetsharingpublicconnection-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-ienumnetsharingpublicconnection-clone
    HRESULT Clone(IEnumNetSharingPublicConnection* ppenum);
}

@GUID("c08956b5-1cd3-11d1-b1c5-00805fc1270e")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nn-netcon-ienumnetsharingprivateconnection
interface IEnumNetSharingPrivateConnection : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-ienumnetsharingprivateconnection-next
    HRESULT Next(uint celt, VARIANT* rgVar, uint* pCeltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-ienumnetsharingprivateconnection-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-ienumnetsharingprivateconnection-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-ienumnetsharingprivateconnection-clone
    HRESULT Clone(IEnumNetSharingPrivateConnection* ppenum);
}

@GUID("02e4a2de-da20-4e34-89c8-ac22275a010b")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nn-netcon-inetsharingportmappingcollection
interface INetSharingPortMappingCollection : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-inetsharingportmappingcollection-get__newenum
    HRESULT get__NewEnum(IUnknown* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-inetsharingportmappingcollection-get_count
    HRESULT get_Count(int* pVal);
}

@GUID("f4277c95-ce5b-463d-8167-5662d9bcaa72")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nn-netcon-inetconnectionprops
interface INetConnectionProps : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-inetconnectionprops-get_guid
    HRESULT get_Guid(BSTR* pbstrGuid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-inetconnectionprops-get_name
    HRESULT get_Name(BSTR* pbstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-inetconnectionprops-get_devicename
    HRESULT get_DeviceName(BSTR* pbstrDeviceName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-inetconnectionprops-get_status
    HRESULT get_Status(NETCON_STATUS* pStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-inetconnectionprops-get_mediatype
    HRESULT get_MediaType(NETCON_MEDIATYPE* pMediaType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-inetconnectionprops-get_characteristics
    HRESULT get_Characteristics(uint* pdwFlags);
}

@GUID("c08956b6-1cd3-11d1-b1c5-00805fc1270e")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nn-netcon-inetsharingconfiguration
interface INetSharingConfiguration : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-inetsharingconfiguration-get_sharingenabled
    HRESULT get_SharingEnabled(VARIANT_BOOL* pbEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-inetsharingconfiguration-get_sharingconnectiontype
    HRESULT get_SharingConnectionType(SHARINGCONNECTIONTYPE* pType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-inetsharingconfiguration-disablesharing
    HRESULT DisableSharing();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-inetsharingconfiguration-enablesharing
    HRESULT EnableSharing(SHARINGCONNECTIONTYPE Type);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-inetsharingconfiguration-get_internetfirewallenabled
    HRESULT get_InternetFirewallEnabled(VARIANT_BOOL* pbEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-inetsharingconfiguration-disableinternetfirewall
    HRESULT DisableInternetFirewall();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-inetsharingconfiguration-enableinternetfirewall
    HRESULT EnableInternetFirewall();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-inetsharingconfiguration-get_enumportmappings
    HRESULT get_EnumPortMappings(SHARINGCONNECTION_ENUM_FLAGS Flags, INetSharingPortMappingCollection* ppColl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-inetsharingconfiguration-addportmapping
    HRESULT AddPortMapping(BSTR bstrName, ubyte ucIPProtocol, ushort usExternalPort, ushort usInternalPort, 
                           uint dwOptions, BSTR bstrTargetNameOrIPAddress, ICS_TARGETTYPE eTargetType, 
                           INetSharingPortMapping* ppMapping);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-inetsharingconfiguration-removeportmapping
    HRESULT RemovePortMapping(INetSharingPortMapping pMapping);
}

@GUID("33c4643c-7811-46fa-a89a-768597bd7223")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nn-netcon-inetsharingeveryconnectioncollection
interface INetSharingEveryConnectionCollection : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-inetsharingeveryconnectioncollection-get__newenum
    HRESULT get__NewEnum(IUnknown* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-inetsharingeveryconnectioncollection-get_count
    HRESULT get_Count(int* pVal);
}

@GUID("7d7a6355-f372-4971-a149-bfc927be762a")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nn-netcon-inetsharingpublicconnectioncollection
interface INetSharingPublicConnectionCollection : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-inetsharingpublicconnectioncollection-get__newenum
    HRESULT get__NewEnum(IUnknown* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-inetsharingpublicconnectioncollection-get_count
    HRESULT get_Count(int* pVal);
}

@GUID("38ae69e0-4409-402a-a2cb-e965c727f840")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nn-netcon-inetsharingprivateconnectioncollection
interface INetSharingPrivateConnectionCollection : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-inetsharingprivateconnectioncollection-get__newenum
    HRESULT get__NewEnum(IUnknown* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-inetsharingprivateconnectioncollection-get_count
    HRESULT get_Count(int* pVal);
}

@GUID("c08956b7-1cd3-11d1-b1c5-00805fc1270e")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nn-netcon-inetsharingmanager
interface INetSharingManager : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-inetsharingmanager-get_sharinginstalled
    HRESULT get_SharingInstalled(VARIANT_BOOL* pbInstalled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-inetsharingmanager-get_enumpublicconnections
    HRESULT get_EnumPublicConnections(SHARINGCONNECTION_ENUM_FLAGS Flags, 
                                      INetSharingPublicConnectionCollection* ppColl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-inetsharingmanager-get_enumprivateconnections
    HRESULT get_EnumPrivateConnections(SHARINGCONNECTION_ENUM_FLAGS Flags, 
                                       INetSharingPrivateConnectionCollection* ppColl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-inetsharingmanager-get_inetsharingconfigurationforinetconnection
    HRESULT get_INetSharingConfigurationForINetConnection(INetConnection pNetConnection, 
                                                          INetSharingConfiguration* ppNetSharingConfiguration);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-inetsharingmanager-get_enumeveryconnection
    HRESULT get_EnumEveryConnection(INetSharingEveryConnectionCollection* ppColl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netcon/nf-netcon-inetsharingmanager-get_netconnectionprops
    HRESULT get_NetConnectionProps(INetConnection pNetConnection, INetConnectionProps* ppProps);
}

@GUID("d4becddf-6f73-4a83-b832-9c66874cd20e")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nn-netfw-inetfwremoteadminsettings
interface INetFwRemoteAdminSettings : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwremoteadminsettings-get_ipversion
    HRESULT get_IpVersion(NET_FW_IP_VERSION* ipVersion);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwremoteadminsettings-put_ipversion
    HRESULT put_IpVersion(NET_FW_IP_VERSION ipVersion);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwremoteadminsettings-get_scope
    HRESULT get_Scope(NET_FW_SCOPE* scope_);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwremoteadminsettings-put_scope
    HRESULT put_Scope(NET_FW_SCOPE scope_);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwremoteadminsettings-get_remoteaddresses
    HRESULT get_RemoteAddresses(BSTR* remoteAddrs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwremoteadminsettings-put_remoteaddresses
    HRESULT put_RemoteAddresses(BSTR remoteAddrs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwremoteadminsettings-get_enabled
    HRESULT get_Enabled(VARIANT_BOOL* enabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwremoteadminsettings-put_enabled
    HRESULT put_Enabled(VARIANT_BOOL enabled);
}

@GUID("a6207b2e-7cdd-426a-951e-5e1cbc5afead")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nn-netfw-inetfwicmpsettings
interface INetFwIcmpSettings : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwicmpsettings-get_allowoutbounddestinationunreachable
    HRESULT get_AllowOutboundDestinationUnreachable(VARIANT_BOOL* allow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwicmpsettings-put_allowoutbounddestinationunreachable
    HRESULT put_AllowOutboundDestinationUnreachable(VARIANT_BOOL allow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwicmpsettings-get_allowredirect
    HRESULT get_AllowRedirect(VARIANT_BOOL* allow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwicmpsettings-put_allowredirect
    HRESULT put_AllowRedirect(VARIANT_BOOL allow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwicmpsettings-get_allowinboundechorequest
    HRESULT get_AllowInboundEchoRequest(VARIANT_BOOL* allow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwicmpsettings-put_allowinboundechorequest
    HRESULT put_AllowInboundEchoRequest(VARIANT_BOOL allow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwicmpsettings-get_allowoutboundtimeexceeded
    HRESULT get_AllowOutboundTimeExceeded(VARIANT_BOOL* allow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwicmpsettings-put_allowoutboundtimeexceeded
    HRESULT put_AllowOutboundTimeExceeded(VARIANT_BOOL allow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwicmpsettings-get_allowoutboundparameterproblem
    HRESULT get_AllowOutboundParameterProblem(VARIANT_BOOL* allow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwicmpsettings-put_allowoutboundparameterproblem
    HRESULT put_AllowOutboundParameterProblem(VARIANT_BOOL allow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwicmpsettings-get_allowoutboundsourcequench
    HRESULT get_AllowOutboundSourceQuench(VARIANT_BOOL* allow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwicmpsettings-put_allowoutboundsourcequench
    HRESULT put_AllowOutboundSourceQuench(VARIANT_BOOL allow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwicmpsettings-get_allowinboundrouterrequest
    HRESULT get_AllowInboundRouterRequest(VARIANT_BOOL* allow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwicmpsettings-put_allowinboundrouterrequest
    HRESULT put_AllowInboundRouterRequest(VARIANT_BOOL allow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwicmpsettings-get_allowinboundtimestamprequest
    HRESULT get_AllowInboundTimestampRequest(VARIANT_BOOL* allow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwicmpsettings-put_allowinboundtimestamprequest
    HRESULT put_AllowInboundTimestampRequest(VARIANT_BOOL allow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwicmpsettings-get_allowinboundmaskrequest
    HRESULT get_AllowInboundMaskRequest(VARIANT_BOOL* allow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwicmpsettings-put_allowinboundmaskrequest
    HRESULT put_AllowInboundMaskRequest(VARIANT_BOOL allow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwicmpsettings-get_allowoutboundpackettoobig
    HRESULT get_AllowOutboundPacketTooBig(VARIANT_BOOL* allow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwicmpsettings-put_allowoutboundpackettoobig
    HRESULT put_AllowOutboundPacketTooBig(VARIANT_BOOL allow);
}

@GUID("e0483ba0-47ff-4d9c-a6d6-7741d0b195f7")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nn-netfw-inetfwopenport
interface INetFwOpenPort : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwopenport-get_name
    HRESULT get_Name(BSTR* name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwopenport-put_name
    HRESULT put_Name(BSTR name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwopenport-get_ipversion
    HRESULT get_IpVersion(NET_FW_IP_VERSION* ipVersion);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwopenport-put_ipversion
    HRESULT put_IpVersion(NET_FW_IP_VERSION ipVersion);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwopenport-get_protocol
    HRESULT get_Protocol(NET_FW_IP_PROTOCOL* ipProtocol);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwopenport-put_protocol
    HRESULT put_Protocol(NET_FW_IP_PROTOCOL ipProtocol);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwopenport-get_port
    HRESULT get_Port(int* portNumber);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwopenport-put_port
    HRESULT put_Port(int portNumber);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwopenport-get_scope
    HRESULT get_Scope(NET_FW_SCOPE* scope_);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwopenport-put_scope
    HRESULT put_Scope(NET_FW_SCOPE scope_);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwopenport-get_remoteaddresses
    HRESULT get_RemoteAddresses(BSTR* remoteAddrs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwopenport-put_remoteaddresses
    HRESULT put_RemoteAddresses(BSTR remoteAddrs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwopenport-get_enabled
    HRESULT get_Enabled(VARIANT_BOOL* enabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwopenport-put_enabled
    HRESULT put_Enabled(VARIANT_BOOL enabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwopenport-get_builtin
    HRESULT get_BuiltIn(VARIANT_BOOL* builtIn);
}

@GUID("c0e9d7fa-e07e-430a-b19a-090ce82d92e2")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nn-netfw-inetfwopenports
interface INetFwOpenPorts : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwopenports-get_count
    HRESULT get_Count(int* count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwopenports-add
    HRESULT Add(INetFwOpenPort port);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwopenports-remove
    HRESULT Remove(int portNumber, NET_FW_IP_PROTOCOL ipProtocol);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwopenports-item
    HRESULT Item(int portNumber, NET_FW_IP_PROTOCOL ipProtocol, INetFwOpenPort* openPort);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwopenports-get__newenum
    HRESULT get__NewEnum(IUnknown* newEnum);
}

@GUID("79fd57c8-908e-4a36-9888-d5b3f0a444cf")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nn-netfw-inetfwservice
interface INetFwService : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwservice-get_name
    HRESULT get_Name(BSTR* name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwservice-get_type
    HRESULT get_Type(NET_FW_SERVICE_TYPE* type);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwservice-get_customized
    HRESULT get_Customized(VARIANT_BOOL* customized);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwservice-get_ipversion
    HRESULT get_IpVersion(NET_FW_IP_VERSION* ipVersion);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwservice-put_ipversion
    HRESULT put_IpVersion(NET_FW_IP_VERSION ipVersion);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwservice-get_scope
    HRESULT get_Scope(NET_FW_SCOPE* scope_);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwservice-put_scope
    HRESULT put_Scope(NET_FW_SCOPE scope_);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwservice-get_remoteaddresses
    HRESULT get_RemoteAddresses(BSTR* remoteAddrs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwservice-put_remoteaddresses
    HRESULT put_RemoteAddresses(BSTR remoteAddrs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwservice-get_enabled
    HRESULT get_Enabled(VARIANT_BOOL* enabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwservice-put_enabled
    HRESULT put_Enabled(VARIANT_BOOL enabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwservice-get_globallyopenports
    HRESULT get_GloballyOpenPorts(INetFwOpenPorts* openPorts);
}

@GUID("79649bb4-903e-421b-94c9-79848e79f6ee")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nn-netfw-inetfwservices
interface INetFwServices : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwservices-get_count
    HRESULT get_Count(int* count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwservices-item
    HRESULT Item(NET_FW_SERVICE_TYPE svcType, INetFwService* service);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwservices-get__newenum
    HRESULT get__NewEnum(IUnknown* newEnum);
}

@GUID("b5e64ffa-c2c5-444e-a301-fb5e00018050")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nn-netfw-inetfwauthorizedapplication
interface INetFwAuthorizedApplication : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwauthorizedapplication-get_name
    HRESULT get_Name(BSTR* name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwauthorizedapplication-put_name
    HRESULT put_Name(BSTR name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwauthorizedapplication-get_processimagefilename
    HRESULT get_ProcessImageFileName(BSTR* imageFileName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwauthorizedapplication-put_processimagefilename
    HRESULT put_ProcessImageFileName(BSTR imageFileName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwauthorizedapplication-get_ipversion
    HRESULT get_IpVersion(NET_FW_IP_VERSION* ipVersion);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwauthorizedapplication-put_ipversion
    HRESULT put_IpVersion(NET_FW_IP_VERSION ipVersion);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwauthorizedapplication-get_scope
    HRESULT get_Scope(NET_FW_SCOPE* scope_);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwauthorizedapplication-put_scope
    HRESULT put_Scope(NET_FW_SCOPE scope_);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwauthorizedapplication-get_remoteaddresses
    HRESULT get_RemoteAddresses(BSTR* remoteAddrs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwauthorizedapplication-put_remoteaddresses
    HRESULT put_RemoteAddresses(BSTR remoteAddrs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwauthorizedapplication-get_enabled
    HRESULT get_Enabled(VARIANT_BOOL* enabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwauthorizedapplication-put_enabled
    HRESULT put_Enabled(VARIANT_BOOL enabled);
}

@GUID("644efd52-ccf9-486c-97a2-39f352570b30")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nn-netfw-inetfwauthorizedapplications
interface INetFwAuthorizedApplications : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwauthorizedapplications-get_count
    HRESULT get_Count(int* count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwauthorizedapplications-add
    HRESULT Add(INetFwAuthorizedApplication app);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwauthorizedapplications-remove
    HRESULT Remove(BSTR imageFileName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwauthorizedapplications-item
    HRESULT Item(BSTR imageFileName, INetFwAuthorizedApplication* app);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwauthorizedapplications-get__newenum
    HRESULT get__NewEnum(IUnknown* newEnum);
}

@GUID("af230d27-baba-4e42-aced-f524f22cfce2")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nn-netfw-inetfwrule
interface INetFwRule : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrule-get_name
    HRESULT get_Name(BSTR* name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrule-put_name
    HRESULT put_Name(BSTR name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrule-get_description
    HRESULT get_Description(BSTR* desc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrule-put_description
    HRESULT put_Description(BSTR desc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrule-get_applicationname
    HRESULT get_ApplicationName(BSTR* imageFileName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrule-put_applicationname
    HRESULT put_ApplicationName(BSTR imageFileName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrule-get_servicename
    HRESULT get_ServiceName(BSTR* serviceName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrule-put_servicename
    HRESULT put_ServiceName(BSTR serviceName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrule-get_protocol
    HRESULT get_Protocol(int* protocol);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrule-put_protocol
    HRESULT put_Protocol(int protocol);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrule-get_localports
    HRESULT get_LocalPorts(BSTR* portNumbers);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrule-put_localports
    HRESULT put_LocalPorts(BSTR portNumbers);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrule-get_remoteports
    HRESULT get_RemotePorts(BSTR* portNumbers);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrule-put_remoteports
    HRESULT put_RemotePorts(BSTR portNumbers);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrule-get_localaddresses
    HRESULT get_LocalAddresses(BSTR* localAddrs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrule-put_localaddresses
    HRESULT put_LocalAddresses(BSTR localAddrs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrule-get_remoteaddresses
    HRESULT get_RemoteAddresses(BSTR* remoteAddrs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrule-put_remoteaddresses
    HRESULT put_RemoteAddresses(BSTR remoteAddrs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrule-get_icmptypesandcodes
    HRESULT get_IcmpTypesAndCodes(BSTR* icmpTypesAndCodes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrule-put_icmptypesandcodes
    HRESULT put_IcmpTypesAndCodes(BSTR icmpTypesAndCodes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrule-get_direction
    HRESULT get_Direction(NET_FW_RULE_DIRECTION* dir);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrule-put_direction
    HRESULT put_Direction(NET_FW_RULE_DIRECTION dir);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrule-get_interfaces
    HRESULT get_Interfaces(VARIANT* interfaces);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrule-put_interfaces
    HRESULT put_Interfaces(VARIANT interfaces);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrule-get_interfacetypes
    HRESULT get_InterfaceTypes(BSTR* interfaceTypes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrule-put_interfacetypes
    HRESULT put_InterfaceTypes(BSTR interfaceTypes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrule-get_enabled
    HRESULT get_Enabled(VARIANT_BOOL* enabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrule-put_enabled
    HRESULT put_Enabled(VARIANT_BOOL enabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrule-get_grouping
    HRESULT get_Grouping(BSTR* context);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrule-put_grouping
    HRESULT put_Grouping(BSTR context);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrule-get_profiles
    HRESULT get_Profiles(int* profileTypesBitmask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrule-put_profiles
    HRESULT put_Profiles(int profileTypesBitmask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrule-get_edgetraversal
    HRESULT get_EdgeTraversal(VARIANT_BOOL* enabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrule-put_edgetraversal
    HRESULT put_EdgeTraversal(VARIANT_BOOL enabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrule-get_action
    HRESULT get_Action(NET_FW_ACTION* action);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrule-put_action
    HRESULT put_Action(NET_FW_ACTION action);
}

@GUID("9c27c8da-189b-4dde-89f7-8b39a316782c")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nn-netfw-inetfwrule2
interface INetFwRule2 : INetFwRule
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrule2-get_edgetraversaloptions
    HRESULT get_EdgeTraversalOptions(int* lOptions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrule2-put_edgetraversaloptions
    HRESULT put_EdgeTraversalOptions(int lOptions);
}

@GUID("b21563ff-d696-4222-ab46-4e89b73ab34a")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nn-netfw-inetfwrule3
interface INetFwRule3 : INetFwRule2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrule3-get_localapppackageid
    HRESULT get_LocalAppPackageId(BSTR* wszPackageId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrule3-put_localapppackageid
    HRESULT put_LocalAppPackageId(BSTR wszPackageId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrule3-get_localuserowner
    HRESULT get_LocalUserOwner(BSTR* wszUserOwner);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrule3-put_localuserowner
    HRESULT put_LocalUserOwner(BSTR wszUserOwner);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrule3-get_localuserauthorizedlist
    HRESULT get_LocalUserAuthorizedList(BSTR* wszUserAuthList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrule3-put_localuserauthorizedlist
    HRESULT put_LocalUserAuthorizedList(BSTR wszUserAuthList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrule3-get_remoteuserauthorizedlist
    HRESULT get_RemoteUserAuthorizedList(BSTR* wszUserAuthList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrule3-put_remoteuserauthorizedlist
    HRESULT put_RemoteUserAuthorizedList(BSTR wszUserAuthList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrule3-get_remotemachineauthorizedlist
    HRESULT get_RemoteMachineAuthorizedList(BSTR* wszUserAuthList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrule3-put_remotemachineauthorizedlist
    HRESULT put_RemoteMachineAuthorizedList(BSTR wszUserAuthList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrule3-get_secureflags
    HRESULT get_SecureFlags(int* lOptions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrule3-put_secureflags
    HRESULT put_SecureFlags(int lOptions);
}

@GUID("9c4c6277-5027-441e-afae-ca1f542da009")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nn-netfw-inetfwrules
interface INetFwRules : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrules-get_count
    HRESULT get_Count(int* count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrules-add
    HRESULT Add(INetFwRule rule);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrules-remove
    HRESULT Remove(BSTR name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrules-item
    HRESULT Item(BSTR name, INetFwRule* rule);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwrules-get__newenum
    HRESULT get__NewEnum(IUnknown* newEnum);
}

@GUID("8267bbe3-f890-491c-b7b6-2db1ef0e5d2b")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nn-netfw-inetfwservicerestriction
interface INetFwServiceRestriction : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwservicerestriction-restrictservice
    HRESULT RestrictService(BSTR serviceName, BSTR appName, VARIANT_BOOL restrictService, 
                            VARIANT_BOOL serviceSidRestricted);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwservicerestriction-servicerestricted
    HRESULT ServiceRestricted(BSTR serviceName, BSTR appName, VARIANT_BOOL* serviceRestricted);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwservicerestriction-get_rules
    HRESULT get_Rules(INetFwRules* rules);
}

@GUID("174a0dda-e9f9-449d-993b-21ab667ca456")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nn-netfw-inetfwprofile
interface INetFwProfile : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwprofile-get_type
    HRESULT get_Type(NET_FW_PROFILE_TYPE* type);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwprofile-get_firewallenabled
    HRESULT get_FirewallEnabled(VARIANT_BOOL* enabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwprofile-put_firewallenabled
    HRESULT put_FirewallEnabled(VARIANT_BOOL enabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwprofile-get_exceptionsnotallowed
    HRESULT get_ExceptionsNotAllowed(VARIANT_BOOL* notAllowed);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwprofile-put_exceptionsnotallowed
    HRESULT put_ExceptionsNotAllowed(VARIANT_BOOL notAllowed);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwprofile-get_notificationsdisabled
    HRESULT get_NotificationsDisabled(VARIANT_BOOL* disabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwprofile-put_notificationsdisabled
    HRESULT put_NotificationsDisabled(VARIANT_BOOL disabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwprofile-get_unicastresponsestomulticastbroadcastdisabled
    HRESULT get_UnicastResponsesToMulticastBroadcastDisabled(VARIANT_BOOL* disabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwprofile-put_unicastresponsestomulticastbroadcastdisabled
    HRESULT put_UnicastResponsesToMulticastBroadcastDisabled(VARIANT_BOOL disabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwprofile-get_remoteadminsettings
    HRESULT get_RemoteAdminSettings(INetFwRemoteAdminSettings* remoteAdminSettings);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwprofile-get_icmpsettings
    HRESULT get_IcmpSettings(INetFwIcmpSettings* icmpSettings);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwprofile-get_globallyopenports
    HRESULT get_GloballyOpenPorts(INetFwOpenPorts* openPorts);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwprofile-get_services
    HRESULT get_Services(INetFwServices* services);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwprofile-get_authorizedapplications
    HRESULT get_AuthorizedApplications(INetFwAuthorizedApplications* apps);
}

@GUID("d46d2478-9ac9-4008-9dc7-5563ce5536cc")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nn-netfw-inetfwpolicy
interface INetFwPolicy : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwpolicy-get_currentprofile
    HRESULT get_CurrentProfile(INetFwProfile* profile);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwpolicy-getprofilebytype
    HRESULT GetProfileByType(NET_FW_PROFILE_TYPE profileType, INetFwProfile* profile);
}

@GUID("98325047-c671-4174-8d81-defcd3f03186")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nn-netfw-inetfwpolicy2
interface INetFwPolicy2 : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwpolicy2-get_currentprofiletypes
    HRESULT get_CurrentProfileTypes(int* profileTypesBitmask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwpolicy2-get_firewallenabled
    HRESULT get_FirewallEnabled(NET_FW_PROFILE_TYPE2 profileType, VARIANT_BOOL* enabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwpolicy2-put_firewallenabled
    HRESULT put_FirewallEnabled(NET_FW_PROFILE_TYPE2 profileType, VARIANT_BOOL enabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwpolicy2-get_excludedinterfaces
    HRESULT get_ExcludedInterfaces(NET_FW_PROFILE_TYPE2 profileType, VARIANT* interfaces);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwpolicy2-put_excludedinterfaces
    HRESULT put_ExcludedInterfaces(NET_FW_PROFILE_TYPE2 profileType, VARIANT interfaces);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwpolicy2-get_blockallinboundtraffic
    HRESULT get_BlockAllInboundTraffic(NET_FW_PROFILE_TYPE2 profileType, VARIANT_BOOL* Block);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwpolicy2-put_blockallinboundtraffic
    HRESULT put_BlockAllInboundTraffic(NET_FW_PROFILE_TYPE2 profileType, VARIANT_BOOL Block);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwpolicy2-get_notificationsdisabled
    HRESULT get_NotificationsDisabled(NET_FW_PROFILE_TYPE2 profileType, VARIANT_BOOL* disabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwpolicy2-put_notificationsdisabled
    HRESULT put_NotificationsDisabled(NET_FW_PROFILE_TYPE2 profileType, VARIANT_BOOL disabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwpolicy2-get_unicastresponsestomulticastbroadcastdisabled
    HRESULT get_UnicastResponsesToMulticastBroadcastDisabled(NET_FW_PROFILE_TYPE2 profileType, 
                                                             VARIANT_BOOL* disabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwpolicy2-put_unicastresponsestomulticastbroadcastdisabled
    HRESULT put_UnicastResponsesToMulticastBroadcastDisabled(NET_FW_PROFILE_TYPE2 profileType, 
                                                             VARIANT_BOOL disabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwpolicy2-get_rules
    HRESULT get_Rules(INetFwRules* rules);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwpolicy2-get_servicerestriction
    HRESULT get_ServiceRestriction(INetFwServiceRestriction* ServiceRestriction);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwpolicy2-enablerulegroup
    HRESULT EnableRuleGroup(int profileTypesBitmask, BSTR group, VARIANT_BOOL enable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwpolicy2-isrulegroupenabled
    HRESULT IsRuleGroupEnabled(int profileTypesBitmask, BSTR group, VARIANT_BOOL* enabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwpolicy2-restorelocalfirewalldefaults
    HRESULT RestoreLocalFirewallDefaults();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwpolicy2-get_defaultinboundaction
    HRESULT get_DefaultInboundAction(NET_FW_PROFILE_TYPE2 profileType, NET_FW_ACTION* action);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwpolicy2-put_defaultinboundaction
    HRESULT put_DefaultInboundAction(NET_FW_PROFILE_TYPE2 profileType, NET_FW_ACTION action);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwpolicy2-get_defaultoutboundaction
    HRESULT get_DefaultOutboundAction(NET_FW_PROFILE_TYPE2 profileType, NET_FW_ACTION* action);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwpolicy2-put_defaultoutboundaction
    HRESULT put_DefaultOutboundAction(NET_FW_PROFILE_TYPE2 profileType, NET_FW_ACTION action);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwpolicy2-get_isrulegroupcurrentlyenabled
    HRESULT get_IsRuleGroupCurrentlyEnabled(BSTR group, VARIANT_BOOL* enabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwpolicy2-get_localpolicymodifystate
    HRESULT get_LocalPolicyModifyState(NET_FW_MODIFY_STATE* modifyState);
}

@GUID("f7898af5-cac4-4632-a2ec-da06e5111af2")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nn-netfw-inetfwmgr
interface INetFwMgr : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwmgr-get_localpolicy
    HRESULT get_LocalPolicy(INetFwPolicy* localPolicy);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwmgr-get_currentprofiletype
    HRESULT get_CurrentProfileType(NET_FW_PROFILE_TYPE* profileType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwmgr-restoredefaults
    HRESULT RestoreDefaults();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwmgr-isportallowed
    HRESULT IsPortAllowed(BSTR imageFileName, NET_FW_IP_VERSION ipVersion, int portNumber, BSTR localAddress, 
                          NET_FW_IP_PROTOCOL ipProtocol, VARIANT* allowed, VARIANT* restricted);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwmgr-isicmptypeallowed
    HRESULT IsIcmpTypeAllowed(NET_FW_IP_VERSION ipVersion, BSTR localAddress, ubyte type, VARIANT* allowed, 
                              VARIANT* restricted);
}

@GUID("71881699-18f4-458b-b892-3ffce5e07f75")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nn-netfw-inetfwproduct
interface INetFwProduct : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwproduct-get_rulecategories
    HRESULT get_RuleCategories(VARIANT* ruleCategories);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwproduct-put_rulecategories
    HRESULT put_RuleCategories(VARIANT ruleCategories);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwproduct-get_displayname
    HRESULT get_DisplayName(BSTR* displayName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwproduct-put_displayname
    HRESULT put_DisplayName(BSTR displayName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwproduct-get_pathtosignedproductexe
    HRESULT get_PathToSignedProductExe(BSTR* path);
}

@GUID("39eb36e0-2097-40bd-8af2-63a13b525362")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nn-netfw-inetfwproducts
interface INetFwProducts : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwproducts-get_count
    HRESULT get_Count(int* count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwproducts-register
    HRESULT Register(INetFwProduct product, IUnknown* registration);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwproducts-item
    HRESULT Item(int index, INetFwProduct* product);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netfw/nf-netfw-inetfwproducts-get__newenum
    HRESULT get__NewEnum(IUnknown* newEnum);
}


// GUIDs

const GUID CLSID_NetFwAuthorizedApplication = GUIDOF!NetFwAuthorizedApplication;
const GUID CLSID_NetFwMgr                   = GUIDOF!NetFwMgr;
const GUID CLSID_NetFwOpenPort              = GUIDOF!NetFwOpenPort;
const GUID CLSID_NetFwPolicy2               = GUIDOF!NetFwPolicy2;
const GUID CLSID_NetFwProduct               = GUIDOF!NetFwProduct;
const GUID CLSID_NetFwProducts              = GUIDOF!NetFwProducts;
const GUID CLSID_NetFwRule                  = GUIDOF!NetFwRule;
const GUID CLSID_NetSharingManager          = GUIDOF!NetSharingManager;
const GUID CLSID_UPnPNAT                    = GUIDOF!UPnPNAT;

const GUID IID_IDynamicPortMapping                    = GUIDOF!IDynamicPortMapping;
const GUID IID_IDynamicPortMappingCollection          = GUIDOF!IDynamicPortMappingCollection;
const GUID IID_IEnumNetConnection                     = GUIDOF!IEnumNetConnection;
const GUID IID_IEnumNetSharingEveryConnection         = GUIDOF!IEnumNetSharingEveryConnection;
const GUID IID_IEnumNetSharingPortMapping             = GUIDOF!IEnumNetSharingPortMapping;
const GUID IID_IEnumNetSharingPrivateConnection       = GUIDOF!IEnumNetSharingPrivateConnection;
const GUID IID_IEnumNetSharingPublicConnection        = GUIDOF!IEnumNetSharingPublicConnection;
const GUID IID_INATEventManager                       = GUIDOF!INATEventManager;
const GUID IID_INATExternalIPAddressCallback          = GUIDOF!INATExternalIPAddressCallback;
const GUID IID_INATNumberOfEntriesCallback            = GUIDOF!INATNumberOfEntriesCallback;
const GUID IID_INetConnection                         = GUIDOF!INetConnection;
const GUID IID_INetConnectionConnectUi                = GUIDOF!INetConnectionConnectUi;
const GUID IID_INetConnectionManager                  = GUIDOF!INetConnectionManager;
const GUID IID_INetConnectionProps                    = GUIDOF!INetConnectionProps;
const GUID IID_INetFwAuthorizedApplication            = GUIDOF!INetFwAuthorizedApplication;
const GUID IID_INetFwAuthorizedApplications           = GUIDOF!INetFwAuthorizedApplications;
const GUID IID_INetFwIcmpSettings                     = GUIDOF!INetFwIcmpSettings;
const GUID IID_INetFwMgr                              = GUIDOF!INetFwMgr;
const GUID IID_INetFwOpenPort                         = GUIDOF!INetFwOpenPort;
const GUID IID_INetFwOpenPorts                        = GUIDOF!INetFwOpenPorts;
const GUID IID_INetFwPolicy                           = GUIDOF!INetFwPolicy;
const GUID IID_INetFwPolicy2                          = GUIDOF!INetFwPolicy2;
const GUID IID_INetFwProduct                          = GUIDOF!INetFwProduct;
const GUID IID_INetFwProducts                         = GUIDOF!INetFwProducts;
const GUID IID_INetFwProfile                          = GUIDOF!INetFwProfile;
const GUID IID_INetFwRemoteAdminSettings              = GUIDOF!INetFwRemoteAdminSettings;
const GUID IID_INetFwRule                             = GUIDOF!INetFwRule;
const GUID IID_INetFwRule2                            = GUIDOF!INetFwRule2;
const GUID IID_INetFwRule3                            = GUIDOF!INetFwRule3;
const GUID IID_INetFwRules                            = GUIDOF!INetFwRules;
const GUID IID_INetFwService                          = GUIDOF!INetFwService;
const GUID IID_INetFwServiceRestriction               = GUIDOF!INetFwServiceRestriction;
const GUID IID_INetFwServices                         = GUIDOF!INetFwServices;
const GUID IID_INetSharingConfiguration               = GUIDOF!INetSharingConfiguration;
const GUID IID_INetSharingEveryConnectionCollection   = GUIDOF!INetSharingEveryConnectionCollection;
const GUID IID_INetSharingManager                     = GUIDOF!INetSharingManager;
const GUID IID_INetSharingPortMapping                 = GUIDOF!INetSharingPortMapping;
const GUID IID_INetSharingPortMappingCollection       = GUIDOF!INetSharingPortMappingCollection;
const GUID IID_INetSharingPortMappingProps            = GUIDOF!INetSharingPortMappingProps;
const GUID IID_INetSharingPrivateConnectionCollection = GUIDOF!INetSharingPrivateConnectionCollection;
const GUID IID_INetSharingPublicConnectionCollection  = GUIDOF!INetSharingPublicConnectionCollection;
const GUID IID_IStaticPortMapping                     = GUIDOF!IStaticPortMapping;
const GUID IID_IStaticPortMappingCollection           = GUIDOF!IStaticPortMappingCollection;
const GUID IID_IUPnPNAT                               = GUIDOF!IUPnPNAT;
