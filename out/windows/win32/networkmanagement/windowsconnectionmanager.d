// Written in the D programming language.

module windows.win32.networkmanagement.windowsconnectionmanager;

public import windows.core;
public import windows.win32.foundation : BOOL, FILETIME, HANDLE, HRESULT, PWSTR;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wcmapi/ne-wcmapi-wcm_property
alias WCM_PROPERTY = int;
enum : int
{
    wcm_global_property_domain_policy          = 0x00000000,
    wcm_global_property_minimize_policy        = 0x00000001,
    wcm_global_property_roaming_policy         = 0x00000002,
    wcm_global_property_powermanagement_policy = 0x00000003,
    wcm_intf_property_connection_cost          = 0x00000004,
    wcm_intf_property_dataplan_status          = 0x00000005,
    wcm_intf_property_hotspot_profile          = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wcmapi/ne-wcmapi-wcm_media_type
alias WCM_MEDIA_TYPE = int;
enum : int
{
    wcm_media_unknown  = 0x00000000,
    wcm_media_ethernet = 0x00000001,
    wcm_media_wlan     = 0x00000002,
    wcm_media_mbn      = 0x00000003,
    wcm_media_invalid  = 0x00000004,
    wcm_media_max      = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wcmapi/ne-wcmapi-wcm_connection_cost
alias WCM_CONNECTION_COST = int;
enum : int
{
    WCM_CONNECTION_COST_UNKNOWN              = 0x00000000,
    WCM_CONNECTION_COST_UNRESTRICTED         = 0x00000001,
    WCM_CONNECTION_COST_FIXED                = 0x00000002,
    WCM_CONNECTION_COST_VARIABLE             = 0x00000004,
    WCM_CONNECTION_COST_OVERDATALIMIT        = 0x00010000,
    WCM_CONNECTION_COST_CONGESTED            = 0x00020000,
    WCM_CONNECTION_COST_ROAMING              = 0x00040000,
    WCM_CONNECTION_COST_APPROACHINGDATALIMIT = 0x00080000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wcmapi/ne-wcmapi-wcm_connection_cost_source
alias WCM_CONNECTION_COST_SOURCE = int;
enum : int
{
    WCM_CONNECTION_COST_SOURCE_DEFAULT  = 0x00000000,
    WCM_CONNECTION_COST_SOURCE_GP       = 0x00000001,
    WCM_CONNECTION_COST_SOURCE_USER     = 0x00000002,
    WCM_CONNECTION_COST_SOURCE_OPERATOR = 0x00000003,
}

// Constants


enum : uint
{
    WCM_API_VERSION_1_0 = 0x00000001U,
    WCM_API_VERSION     = 0x00000001U,
}

enum uint WCM_UNKNOWN_DATAPLAN_STATUS = 0xffffffffU;
enum uint WCM_MAX_PROFILE_NAME = 0x00000100U;

enum : uint
{
    NET_INTERFACE_FLAG_NONE              = 0x00000000U,
    NET_INTERFACE_FLAG_CONNECT_IF_NEEDED = 0x00000001U,
}

// Callbacks

alias ONDEMAND_NOTIFICATION_CALLBACK = void function(void* param0);

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wcmapi/ns-wcmapi-wcm_policy_value
struct WCM_POLICY_VALUE
{
    BOOL fValue;
    BOOL fIsGroupPolicy;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wcmapi/ns-wcmapi-wcm_profile_info
struct WCM_PROFILE_INFO
{
    wchar[256]     strProfileName;
    GUID           AdapterGUID;
    WCM_MEDIA_TYPE Media;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wcmapi/ns-wcmapi-wcm_profile_info_list
struct WCM_PROFILE_INFO_LIST
{
    uint                dwNumberOfItems;
    WCM_PROFILE_INFO[1] ProfileInfo; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wcmapi/ns-wcmapi-wcm_connection_cost_data
struct WCM_CONNECTION_COST_DATA
{
    uint ConnectionCost;
    WCM_CONNECTION_COST_SOURCE CostSource;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wcmapi/ns-wcmapi-wcm_time_interval
struct WCM_TIME_INTERVAL
{
    ushort wYear;
    ushort wMonth;
    ushort wDay;
    ushort wHour;
    ushort wMinute;
    ushort wSecond;
    ushort wMilliseconds;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wcmapi/ns-wcmapi-wcm_usage_data
struct WCM_USAGE_DATA
{
    uint     UsageInMegabytes;
    FILETIME LastSyncTime;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wcmapi/ns-wcmapi-wcm_billing_cycle_info
struct WCM_BILLING_CYCLE_INFO
{
    FILETIME          StartDate;
    WCM_TIME_INTERVAL Duration;
    BOOL              Reset;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wcmapi/ns-wcmapi-wcm_dataplan_status
struct WCM_DATAPLAN_STATUS
{
    WCM_USAGE_DATA UsageData;
    uint           DataLimitInMegabytes;
    uint           InboundBandwidthInKbps;
    uint           OutboundBandwidthInKbps;
    WCM_BILLING_CYCLE_INFO BillingCycle;
    uint           MaxTransferSizeInMegabytes;
    uint           Reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ondemandconnroutehelper/ns-ondemandconnroutehelper-net_interface_context
struct NET_INTERFACE_CONTEXT
{
    uint  InterfaceIndex;
    PWSTR ConfigurationName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ondemandconnroutehelper/ns-ondemandconnroutehelper-net_interface_context_table
struct NET_INTERFACE_CONTEXT_TABLE
{
    HANDLE InterfaceContextHandle;
    uint   NumberOfEntries;
    NET_INTERFACE_CONTEXT* InterfaceContextArray;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("wcmapi.dll")
uint WcmQueryProperty(const(GUID)* pInterface, const(PWSTR) strProfileName, WCM_PROPERTY Property, 
                      /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pReserved, 
                      uint* pdwDataSize, ubyte** ppData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("wcmapi.dll")
uint WcmSetProperty(const(GUID)* pInterface, const(PWSTR) strProfileName, WCM_PROPERTY Property, 
                    /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pReserved, uint dwDataSize, 
                    const(ubyte)* pbData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("wcmapi.dll")
uint WcmGetProfileList(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pReserved, 
                       WCM_PROFILE_INFO_LIST** ppProfileList);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("wcmapi.dll")
uint WcmSetProfileList(WCM_PROFILE_INFO_LIST* pProfileList, uint dwPosition, BOOL fIgnoreUnknownProfiles, 
                       /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("wcmapi.dll")
void WcmFreeMemory(void* pMemory);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("OnDemandConnRouteHelper.dll")
HRESULT OnDemandGetRoutingHint(const(PWSTR) destinationHostName, uint* interfaceIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("OnDemandConnRouteHelper.dll")
HRESULT OnDemandRegisterNotification(ONDEMAND_NOTIFICATION_CALLBACK callback, void* callbackContext, 
                                     HANDLE* registrationHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("OnDemandConnRouteHelper.dll")
HRESULT OnDemandUnRegisterNotification(HANDLE registrationHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("OnDemandConnRouteHelper.dll")
HRESULT GetInterfaceContextTableForHostName(const(PWSTR) HostName, const(PWSTR) ProxyName, uint Flags, 
                                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* ConnectionProfileFilterRawData, 
                                            uint ConnectionProfileFilterRawDataSize, 
                                            NET_INTERFACE_CONTEXT_TABLE** InterfaceContextTable);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("OnDemandConnRouteHelper.dll")
void FreeInterfaceContextTable(NET_INTERFACE_CONTEXT_TABLE* InterfaceContextTable);


