// Written in the D programming language.

module windows.win32.networking.networklistmanager;

public import windows.core;
public import windows.win32.foundation.foundation : BOOL, BSTR, FILETIME, HRESULT,
                                                    VARIANT_BOOL;
public import windows.win32.system.com.com : IDispatch, IUnknown;
public import windows.win32.system.ole : IEnumVARIANT;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/ne-netlistmgr-nlm_connection_cost
alias NLM_CONNECTION_COST = int;
enum : int
{
    NLM_CONNECTION_COST_UNKNOWN              = 0x00000000,
    NLM_CONNECTION_COST_UNRESTRICTED         = 0x00000001,
    NLM_CONNECTION_COST_FIXED                = 0x00000002,
    NLM_CONNECTION_COST_VARIABLE             = 0x00000004,
    NLM_CONNECTION_COST_OVERDATALIMIT        = 0x00010000,
    NLM_CONNECTION_COST_CONGESTED            = 0x00020000,
    NLM_CONNECTION_COST_ROAMING              = 0x00040000,
    NLM_CONNECTION_COST_APPROACHINGDATALIMIT = 0x00080000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/ne-netlistmgr-nlm_network_class
alias NLM_NETWORK_CLASS = int;
enum : int
{
    NLM_NETWORK_IDENTIFYING  = 0x00000001,
    NLM_NETWORK_IDENTIFIED   = 0x00000002,
    NLM_NETWORK_UNIDENTIFIED = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/ne-netlistmgr-nlm_internet_connectivity
alias NLM_INTERNET_CONNECTIVITY = int;
enum : int
{
    NLM_INTERNET_CONNECTIVITY_WEBHIJACK = 0x00000001,
    NLM_INTERNET_CONNECTIVITY_PROXIED   = 0x00000002,
    NLM_INTERNET_CONNECTIVITY_CORPORATE = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/ne-netlistmgr-nlm_connectivity
alias NLM_CONNECTIVITY = int;
enum : int
{
    NLM_CONNECTIVITY_DISCONNECTED      = 0x00000000,
    NLM_CONNECTIVITY_IPV4_NOTRAFFIC    = 0x00000001,
    NLM_CONNECTIVITY_IPV6_NOTRAFFIC    = 0x00000002,
    NLM_CONNECTIVITY_IPV4_SUBNET       = 0x00000010,
    NLM_CONNECTIVITY_IPV4_LOCALNETWORK = 0x00000020,
    NLM_CONNECTIVITY_IPV4_INTERNET     = 0x00000040,
    NLM_CONNECTIVITY_IPV6_SUBNET       = 0x00000100,
    NLM_CONNECTIVITY_IPV6_LOCALNETWORK = 0x00000200,
    NLM_CONNECTIVITY_IPV6_INTERNET     = 0x00000400,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/ne-netlistmgr-nlm_domain_type
alias NLM_DOMAIN_TYPE = int;
enum : int
{
    NLM_DOMAIN_TYPE_NON_DOMAIN_NETWORK   = 0x00000000,
    NLM_DOMAIN_TYPE_DOMAIN_NETWORK       = 0x00000001,
    NLM_DOMAIN_TYPE_DOMAIN_AUTHENTICATED = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/ne-netlistmgr-nlm_domain_authentication_kind
alias NLM_DOMAIN_AUTHENTICATION_KIND = int;
enum : int
{
    NLM_DOMAIN_AUTHENTICATION_KIND_NONE = 0x00000000,
    NLM_DOMAIN_AUTHENTICATION_KIND_LDAP = 0x00000001,
    NLM_DOMAIN_AUTHENTICATION_KIND_TLS  = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/ne-netlistmgr-nlm_enum_network
alias NLM_ENUM_NETWORK = int;
enum : int
{
    NLM_ENUM_NETWORK_CONNECTED    = 0x00000001,
    NLM_ENUM_NETWORK_DISCONNECTED = 0x00000002,
    NLM_ENUM_NETWORK_ALL          = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/ne-netlistmgr-nlm_network_category
alias NLM_NETWORK_CATEGORY = int;
enum : int
{
    NLM_NETWORK_CATEGORY_PUBLIC               = 0x00000000,
    NLM_NETWORK_CATEGORY_PRIVATE              = 0x00000001,
    NLM_NETWORK_CATEGORY_DOMAIN_AUTHENTICATED = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/ne-netlistmgr-nlm_network_property_change
alias NLM_NETWORK_PROPERTY_CHANGE = int;
enum : int
{
    NLM_NETWORK_PROPERTY_CHANGE_CONNECTION     = 0x00000001,
    NLM_NETWORK_PROPERTY_CHANGE_DESCRIPTION    = 0x00000002,
    NLM_NETWORK_PROPERTY_CHANGE_NAME           = 0x00000004,
    NLM_NETWORK_PROPERTY_CHANGE_ICON           = 0x00000008,
    NLM_NETWORK_PROPERTY_CHANGE_CATEGORY_VALUE = 0x00000010,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/ne-netlistmgr-nlm_connection_property_change
alias NLM_CONNECTION_PROPERTY_CHANGE = int;
enum : int
{
    NLM_CONNECTION_PROPERTY_CHANGE_AUTHENTICATION = 0x00000001,
}

// Constants


enum const(wchar)* NA_DomainAuthenticationFailed = "NA_DomainAuthenticationFailed";
enum const(wchar)* NA_NetworkClass = "NA_NetworkClass";
enum const(wchar)* NA_NameSetByPolicy = "NA_NameSetByPolicy";
enum const(wchar)* NA_IconSetByPolicy = "NA_IconSetByPolicy";
enum const(wchar)* NA_DescriptionSetByPolicy = "NA_DescriptionSetByPolicy";
enum const(wchar)* NA_CategorySetByPolicy = "NA_CategorySetByPolicy";
enum const(wchar)* NA_NameReadOnly = "NA_NameReadOnly";
enum const(wchar)* NA_IconReadOnly = "NA_IconReadOnly";
enum const(wchar)* NA_DescriptionReadOnly = "NA_DescriptionReadOnly";
enum const(wchar)* NA_CategoryReadOnly = "NA_CategoryReadOnly";
enum const(wchar)* NA_AllowMerge = "NA_AllowMerge";

enum : const(wchar)*
{
    NA_InternetConnectivityV4 = "NA_InternetConnectivityV4",
    NA_InternetConnectivityV6 = "NA_InternetConnectivityV6",
}

enum uint NLM_MAX_ADDRESS_LIST_SIZE = 0x0000000aU;
enum uint NLM_UNKNOWN_DATAPLAN_STATUS = 0xffffffffU;

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/ns-netlistmgr-nlm_usage_data
struct NLM_USAGE_DATA
{
    uint     UsageInMegabytes;
    FILETIME LastSyncTime;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/ns-netlistmgr-nlm_dataplan_status
struct NLM_DATAPLAN_STATUS
{
    GUID           InterfaceGuid;
    NLM_USAGE_DATA UsageData;
    uint           DataLimitInMegabytes;
    uint           InboundBandwidthInKbps;
    uint           OutboundBandwidthInKbps;
    FILETIME       NextBillingCycle;
    uint           MaxTransferSizeInMegabytes;
    uint           Reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/ns-netlistmgr-nlm_sockaddr
struct NLM_SOCKADDR
{
    ubyte[128] data;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/ns-netlistmgr-nlm_simulated_profile_info
struct NLM_SIMULATED_PROFILE_INFO
{
    wchar[256]          ProfileName;
    NLM_CONNECTION_COST cost;
    uint                UsageInMegabytes;
    uint                DataLimitInMegabytes;
}

// Interfaces

@GUID("dcb00c01-570f-4a9b-8d69-199fdba5723b")
struct NetworkListManager;

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nn-netlistmgr-inetworklistmanager
@GUID("dcb00000-570f-4a9b-8d69-199fdba5723b")
interface INetworkListManager : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-inetworklistmanager-getnetworks
    HRESULT GetNetworks(NLM_ENUM_NETWORK Flags, IEnumNetworks* ppEnumNetwork);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-inetworklistmanager-getnetwork
    HRESULT GetNetwork(GUID gdNetworkId, INetwork* ppNetwork);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-inetworklistmanager-getnetworkconnections
    HRESULT GetNetworkConnections(IEnumNetworkConnections* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-inetworklistmanager-getnetworkconnection
    HRESULT GetNetworkConnection(GUID gdNetworkConnectionId, INetworkConnection* ppNetworkConnection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-inetworklistmanager-get_isconnectedtointernet
    HRESULT get_IsConnectedToInternet(VARIANT_BOOL* pbIsConnected);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-inetworklistmanager-get_isconnected
    HRESULT get_IsConnected(VARIANT_BOOL* pbIsConnected);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-inetworklistmanager-getconnectivity
    HRESULT GetConnectivity(NLM_CONNECTIVITY* pConnectivity);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-inetworklistmanager-setsimulatedprofileinfo
    HRESULT SetSimulatedProfileInfo(NLM_SIMULATED_PROFILE_INFO* pSimulatedInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-inetworklistmanager-clearsimulatedprofileinfo
    HRESULT ClearSimulatedProfileInfo();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nn-netlistmgr-inetworklistmanagerevents
@GUID("dcb00001-570f-4a9b-8d69-199fdba5723b")
interface INetworkListManagerEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-inetworklistmanagerevents-connectivitychanged
    HRESULT ConnectivityChanged(NLM_CONNECTIVITY newConnectivity);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nn-netlistmgr-inetwork
@GUID("dcb00002-570f-4a9b-8d69-199fdba5723b")
interface INetwork : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-inetwork-getname
    HRESULT GetName(BSTR* pszNetworkName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-inetwork-setname
    HRESULT SetName(BSTR szNetworkNewName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-inetwork-getdescription
    HRESULT GetDescription(BSTR* pszDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-inetwork-setdescription
    HRESULT SetDescription(BSTR szDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-inetwork-getnetworkid
    HRESULT GetNetworkId(GUID* pgdGuidNetworkId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-inetwork-getdomaintype
    HRESULT GetDomainType(NLM_DOMAIN_TYPE* pNetworkType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-inetwork-getnetworkconnections
    HRESULT GetNetworkConnections(IEnumNetworkConnections* ppEnumNetworkConnection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-inetwork-gettimecreatedandconnected
    HRESULT GetTimeCreatedAndConnected(uint* pdwLowDateTimeCreated, uint* pdwHighDateTimeCreated, 
                                       uint* pdwLowDateTimeConnected, uint* pdwHighDateTimeConnected);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-inetwork-get_isconnectedtointernet
    HRESULT get_IsConnectedToInternet(VARIANT_BOOL* pbIsConnected);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-inetwork-get_isconnected
    HRESULT get_IsConnected(VARIANT_BOOL* pbIsConnected);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-inetwork-getconnectivity
    HRESULT GetConnectivity(NLM_CONNECTIVITY* pConnectivity);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-inetwork-getcategory
    HRESULT GetCategory(NLM_NETWORK_CATEGORY* pCategory);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-inetwork-setcategory
    HRESULT SetCategory(NLM_NETWORK_CATEGORY NewCategory);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nn-netlistmgr-inetwork2
@GUID("b5550abb-3391-4310-804f-25dcc325ed81")
interface INetwork2 : INetwork
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-inetwork2-isdomainauthenticatedby
    HRESULT IsDomainAuthenticatedBy(NLM_DOMAIN_AUTHENTICATION_KIND domainAuthenticationKind, BOOL* pValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nn-netlistmgr-ienumnetworks
@GUID("dcb00003-570f-4a9b-8d69-199fdba5723b")
interface IEnumNetworks : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-ienumnetworks-get__newenum
    HRESULT get__NewEnum(IEnumVARIANT* ppEnumVar);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-ienumnetworks-next
    HRESULT Next(uint celt, INetwork* rgelt, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-ienumnetworks-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-ienumnetworks-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-ienumnetworks-clone
    HRESULT Clone(IEnumNetworks* ppEnumNetwork);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nn-netlistmgr-inetworkevents
@GUID("dcb00004-570f-4a9b-8d69-199fdba5723b")
interface INetworkEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-inetworkevents-networkadded
    HRESULT NetworkAdded(GUID networkId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-inetworkevents-networkdeleted
    HRESULT NetworkDeleted(GUID networkId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-inetworkevents-networkconnectivitychanged
    HRESULT NetworkConnectivityChanged(GUID networkId, NLM_CONNECTIVITY newConnectivity);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-inetworkevents-networkpropertychanged
    HRESULT NetworkPropertyChanged(GUID networkId, NLM_NETWORK_PROPERTY_CHANGE flags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nn-netlistmgr-inetworkconnection
@GUID("dcb00005-570f-4a9b-8d69-199fdba5723b")
interface INetworkConnection : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-inetworkconnection-getnetwork
    HRESULT GetNetwork(INetwork* ppNetwork);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-inetworkconnection-get_isconnectedtointernet
    HRESULT get_IsConnectedToInternet(VARIANT_BOOL* pbIsConnected);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-inetworkconnection-get_isconnected
    HRESULT get_IsConnected(VARIANT_BOOL* pbIsConnected);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-inetworkconnection-getconnectivity
    HRESULT GetConnectivity(NLM_CONNECTIVITY* pConnectivity);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-inetworkconnection-getconnectionid
    HRESULT GetConnectionId(GUID* pgdConnectionId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-inetworkconnection-getadapterid
    HRESULT GetAdapterId(GUID* pgdAdapterId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-inetworkconnection-getdomaintype
    HRESULT GetDomainType(NLM_DOMAIN_TYPE* pDomainType);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nn-netlistmgr-inetworkconnection2
@GUID("00e676ed-5a35-4738-92eb-8581738d0f0a")
interface INetworkConnection2 : INetworkConnection
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-inetworkconnection2-isdomainauthenticatedby
    HRESULT IsDomainAuthenticatedBy(NLM_DOMAIN_AUTHENTICATION_KIND domainAuthenticationKind, BOOL* pValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nn-netlistmgr-ienumnetworkconnections
@GUID("dcb00006-570f-4a9b-8d69-199fdba5723b")
interface IEnumNetworkConnections : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-ienumnetworkconnections-get__newenum
    HRESULT get__NewEnum(IEnumVARIANT* ppEnumVar);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-ienumnetworkconnections-next
    HRESULT Next(uint celt, INetworkConnection* rgelt, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-ienumnetworkconnections-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-ienumnetworkconnections-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-ienumnetworkconnections-clone
    HRESULT Clone(IEnumNetworkConnections* ppEnumNetwork);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nn-netlistmgr-inetworkconnectionevents
@GUID("dcb00007-570f-4a9b-8d69-199fdba5723b")
interface INetworkConnectionEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-inetworkconnectionevents-networkconnectionconnectivitychanged
    HRESULT NetworkConnectionConnectivityChanged(GUID connectionId, NLM_CONNECTIVITY newConnectivity);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-inetworkconnectionevents-networkconnectionpropertychanged
    HRESULT NetworkConnectionPropertyChanged(GUID connectionId, NLM_CONNECTION_PROPERTY_CHANGE flags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nn-netlistmgr-inetworkcostmanager
@GUID("dcb00008-570f-4a9b-8d69-199fdba5723b")
interface INetworkCostManager : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-inetworkcostmanager-getcost
    HRESULT GetCost(uint* pCost, NLM_SOCKADDR* pDestIPAddr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-inetworkcostmanager-getdataplanstatus
    HRESULT GetDataPlanStatus(NLM_DATAPLAN_STATUS* pDataPlanStatus, NLM_SOCKADDR* pDestIPAddr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-inetworkcostmanager-setdestinationaddresses
    HRESULT SetDestinationAddresses(uint length, NLM_SOCKADDR* pDestIPAddrList, VARIANT_BOOL bAppend);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nn-netlistmgr-inetworkcostmanagerevents
@GUID("dcb00009-570f-4a9b-8d69-199fdba5723b")
interface INetworkCostManagerEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-inetworkcostmanagerevents-costchanged
    HRESULT CostChanged(uint newCost, NLM_SOCKADDR* pDestAddr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-inetworkcostmanagerevents-dataplanstatuschanged
    HRESULT DataPlanStatusChanged(NLM_SOCKADDR* pDestAddr);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nn-netlistmgr-inetworkconnectioncost
@GUID("dcb0000a-570f-4a9b-8d69-199fdba5723b")
interface INetworkConnectionCost : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-inetworkconnectioncost-getcost
    HRESULT GetCost(uint* pCost);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-inetworkconnectioncost-getdataplanstatus
    HRESULT GetDataPlanStatus(NLM_DATAPLAN_STATUS* pDataPlanStatus);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nn-netlistmgr-inetworkconnectioncostevents
@GUID("dcb0000b-570f-4a9b-8d69-199fdba5723b")
interface INetworkConnectionCostEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-inetworkconnectioncostevents-connectioncostchanged
    HRESULT ConnectionCostChanged(GUID connectionId, uint newCost);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netlistmgr/nf-netlistmgr-inetworkconnectioncostevents-connectiondataplanstatuschanged
    HRESULT ConnectionDataPlanStatusChanged(GUID connectionId);
}


// GUIDs

const GUID CLSID_NetworkListManager = GUIDOF!NetworkListManager;

const GUID IID_IEnumNetworkConnections      = GUIDOF!IEnumNetworkConnections;
const GUID IID_IEnumNetworks                = GUIDOF!IEnumNetworks;
const GUID IID_INetwork                     = GUIDOF!INetwork;
const GUID IID_INetwork2                    = GUIDOF!INetwork2;
const GUID IID_INetworkConnection           = GUIDOF!INetworkConnection;
const GUID IID_INetworkConnection2          = GUIDOF!INetworkConnection2;
const GUID IID_INetworkConnectionCost       = GUIDOF!INetworkConnectionCost;
const GUID IID_INetworkConnectionCostEvents = GUIDOF!INetworkConnectionCostEvents;
const GUID IID_INetworkConnectionEvents     = GUIDOF!INetworkConnectionEvents;
const GUID IID_INetworkCostManager          = GUIDOF!INetworkCostManager;
const GUID IID_INetworkCostManagerEvents    = GUIDOF!INetworkCostManagerEvents;
const GUID IID_INetworkEvents               = GUIDOF!INetworkEvents;
const GUID IID_INetworkListManager          = GUIDOF!INetworkListManager;
const GUID IID_INetworkListManagerEvents    = GUIDOF!INetworkListManagerEvents;
