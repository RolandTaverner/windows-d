// Written in the D programming language.

module windows.win32.networkmanagement.windowsnetworkvirtualization;

public import windows.core;
public import windows.win32.foundation.foundation : HANDLE;
public import windows.win32.networking.winsock : ADDRESS_FAMILY, DL_EUI48, IN6_ADDR, IN_ADDR,
                                                 NL_DAD_STATE;
public import windows.win32.system.io : OVERLAPPED;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wnvapi/ne-wnvapi-wnv_notification_type
alias WNV_NOTIFICATION_TYPE = int;
enum : int
{
    WnvPolicyMismatchType  = 0x00000000,
    WnvRedirectType        = 0x00000001,
    WnvObjectChangeType    = 0x00000002,
    WnvNotificationTypeMax = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wnvapi/ne-wnvapi-wnv_object_type
alias WNV_OBJECT_TYPE = int;
enum : int
{
    WnvProviderAddressType = 0x00000000,
    WnvCustomerAddressType = 0x00000001,
    WnvObjectTypeMax       = 0x00000002,
}

alias WNV_CA_NOTIFICATION_TYPE = int;
enum : int
{
    WnvCustomerAddressAdded   = 0x00000000,
    WnvCustomerAddressDeleted = 0x00000001,
    WnvCustomerAddressMoved   = 0x00000002,
    WnvCustomerAddressMax     = 0x00000003,
}

// Constants


enum uint WNV_API_MAJOR_VERSION_1 = 0x00000001U;
enum uint WNV_API_MINOR_VERSION_0 = 0x00000000U;

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wnvapi/ns-wnvapi-wnv_object_header
struct WNV_OBJECT_HEADER
{
    ubyte MajorVersion;
    ubyte MinorVersion;
    uint  Size;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wnvapi/ns-wnvapi-wnv_notification_param
struct WNV_NOTIFICATION_PARAM
{
    WNV_OBJECT_HEADER Header;
    WNV_NOTIFICATION_TYPE NotificationType;
    uint              PendingNotifications;
    ubyte*            Buffer;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wnvapi/ns-wnvapi-wnv_ip_address
struct WNV_IP_ADDRESS
{
    union IP
    {
        IN_ADDR   v4;
        IN6_ADDR  v6;
        ubyte[16] Addr;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wnvapi/ns-wnvapi-wnv_policy_mismatch_param
struct WNV_POLICY_MISMATCH_PARAM
{
    ADDRESS_FAMILY CAFamily;
    ADDRESS_FAMILY PAFamily;
    uint           VirtualSubnetId;
    WNV_IP_ADDRESS CA;
    WNV_IP_ADDRESS PA;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wnvapi/ns-wnvapi-wnv_provider_address_change_param
struct WNV_PROVIDER_ADDRESS_CHANGE_PARAM
{
    ADDRESS_FAMILY PAFamily;
    WNV_IP_ADDRESS PA;
    NL_DAD_STATE   AddressState;
}

struct WNV_CUSTOMER_ADDRESS_CHANGE_PARAM
{
    DL_EUI48       MACAddress;
    ADDRESS_FAMILY CAFamily;
    WNV_IP_ADDRESS CA;
    uint           VirtualSubnetId;
    ADDRESS_FAMILY PAFamily;
    WNV_IP_ADDRESS PA;
    WNV_CA_NOTIFICATION_TYPE NotificationReason;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wnvapi/ns-wnvapi-wnv_object_change_param
struct WNV_OBJECT_CHANGE_PARAM
{
    WNV_OBJECT_TYPE ObjectType;
    union ObjectParam
    {
        WNV_PROVIDER_ADDRESS_CHANGE_PARAM ProviderAddressChange;
        WNV_CUSTOMER_ADDRESS_CHANGE_PARAM CustomerAddressChange;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wnvapi/ns-wnvapi-wnv_redirect_param
struct WNV_REDIRECT_PARAM
{
    ADDRESS_FAMILY CAFamily;
    ADDRESS_FAMILY PAFamily;
    ADDRESS_FAMILY NewPAFamily;
    uint           VirtualSubnetId;
    WNV_IP_ADDRESS CA;
    WNV_IP_ADDRESS PA;
    WNV_IP_ADDRESS NewPA;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("wnvapi.dll")
HANDLE WnvOpen();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("wnvapi.dll")
uint WnvRequestNotification(HANDLE WnvHandle, WNV_NOTIFICATION_PARAM* NotificationParam, OVERLAPPED* Overlapped, 
                            uint* BytesTransferred);


