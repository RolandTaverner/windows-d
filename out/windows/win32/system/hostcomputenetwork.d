// Written in the D programming language.

module windows.win32.system.hostcomputenetwork;

public import windows.core;
public import windows.win32.foundation.foundation : HANDLE, HRESULT, PWSTR;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcn/Reference/HCN_NOTIFICATIONS
alias HCN_NOTIFICATIONS = int;
enum : int
{
    HcnNotificationInvalid                                  = 0x00000000,
    HcnNotificationNetworkPreCreate                         = 0x00000001,
    HcnNotificationNetworkCreate                            = 0x00000002,
    HcnNotificationNetworkPreDelete                         = 0x00000003,
    HcnNotificationNetworkDelete                            = 0x00000004,
    HcnNotificationNamespaceCreate                          = 0x00000005,
    HcnNotificationNamespaceDelete                          = 0x00000006,
    HcnNotificationGuestNetworkServiceCreate                = 0x00000007,
    HcnNotificationGuestNetworkServiceDelete                = 0x00000008,
    HcnNotificationNetworkEndpointAttached                  = 0x00000009,
    HcnNotificationNetworkEndpointDetached                  = 0x00000010,
    HcnNotificationGuestNetworkServiceStateChanged          = 0x00000011,
    HcnNotificationGuestNetworkServiceInterfaceStateChanged = 0x00000012,
    HcnNotificationServiceDisconnect                        = 0x01000000,
    HcnNotificationFlagsReserved                            = 0xf0000000,
}

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcn/Reference/HCN_PORT_PROTOCOL
alias HCN_PORT_PROTOCOL = int;
enum : int
{
    HCN_PORT_PROTOCOL_TCP  = 0x00000001,
    HCN_PORT_PROTOCOL_UDP  = 0x00000002,
    HCN_PORT_PROTOCOL_BOTH = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcn/Reference/HCN_PORT_ACCESS
alias HCN_PORT_ACCESS = int;
enum : int
{
    HCN_PORT_ACCESS_EXCLUSIVE = 0x00000001,
    HCN_PORT_ACCESS_SHARED    = 0x00000002,
}

// Callbacks

alias HCN_NOTIFICATION_CALLBACK = void function(uint NotificationType, void* Context, HRESULT NotificationStatus, 
                                                const(PWSTR) NotificationData);

// Structs


// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcn/Reference/HCN_PORT_RANGE_RESERVATION
struct HCN_PORT_RANGE_RESERVATION
{
    ushort startingPort;
    ushort endingPort;
}

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcn/Reference/HCN_PORT_RANGE_ENTRY
struct HCN_PORT_RANGE_ENTRY
{
    GUID              OwningPartitionId;
    GUID              TargetPartitionId;
    HCN_PORT_PROTOCOL Protocol;
    ulong             Priority;
    uint              ReservationType;
    uint              SharingFlags;
    uint              DeliveryMode;
    ushort            StartingPort;
    ushort            EndingPort;
}

// Functions

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcn/Reference/HcnEnumerateNetworks
@DllImport("computenetwork.dll")
HRESULT HcnEnumerateNetworks(const(PWSTR) Query, PWSTR* Networks, PWSTR* ErrorRecord);

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcn/Reference/HcnCreateNetwork
@DllImport("computenetwork.dll")
HRESULT HcnCreateNetwork(const(GUID)* Id, const(PWSTR) Settings, void** Network, PWSTR* ErrorRecord);

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcn/Reference/HcnOpenNetwork
@DllImport("computenetwork.dll")
HRESULT HcnOpenNetwork(const(GUID)* Id, void** Network, PWSTR* ErrorRecord);

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcn/Reference/HcnModifyNetwork
@DllImport("computenetwork.dll")
HRESULT HcnModifyNetwork(void* Network, const(PWSTR) Settings, PWSTR* ErrorRecord);

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcn/Reference/HcnQueryNetworkProperties
@DllImport("computenetwork.dll")
HRESULT HcnQueryNetworkProperties(void* Network, const(PWSTR) Query, PWSTR* Properties, PWSTR* ErrorRecord);

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcn/Reference/HcnDeleteNetwork
@DllImport("computenetwork.dll")
HRESULT HcnDeleteNetwork(const(GUID)* Id, PWSTR* ErrorRecord);

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcn/Reference/HcnCloseNetwork
@DllImport("computenetwork.dll")
HRESULT HcnCloseNetwork(void* Network);

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcn/Reference/HcnEnumerateNamespaces
@DllImport("computenetwork.dll")
HRESULT HcnEnumerateNamespaces(const(PWSTR) Query, PWSTR* Namespaces, PWSTR* ErrorRecord);

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcn/Reference/HcnCreateNamespace
@DllImport("computenetwork.dll")
HRESULT HcnCreateNamespace(const(GUID)* Id, const(PWSTR) Settings, void** Namespace, PWSTR* ErrorRecord);

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcn/Reference/HcnOpenNamespace
@DllImport("computenetwork.dll")
HRESULT HcnOpenNamespace(const(GUID)* Id, void** Namespace, PWSTR* ErrorRecord);

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcn/Reference/HcnModifyNamespace
@DllImport("computenetwork.dll")
HRESULT HcnModifyNamespace(void* Namespace, const(PWSTR) Settings, PWSTR* ErrorRecord);

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcn/Reference/HcnQueryNamespaceProperties
@DllImport("computenetwork.dll")
HRESULT HcnQueryNamespaceProperties(void* Namespace, const(PWSTR) Query, PWSTR* Properties, PWSTR* ErrorRecord);

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcn/Reference/HcnDeleteNamespace
@DllImport("computenetwork.dll")
HRESULT HcnDeleteNamespace(const(GUID)* Id, PWSTR* ErrorRecord);

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcn/Reference/HcnCloseNamespace
@DllImport("computenetwork.dll")
HRESULT HcnCloseNamespace(void* Namespace);

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcn/Reference/HcnEnumerateEndpoints
@DllImport("computenetwork.dll")
HRESULT HcnEnumerateEndpoints(const(PWSTR) Query, PWSTR* Endpoints, PWSTR* ErrorRecord);

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcn/Reference/HcnCreateEndpoint
@DllImport("computenetwork.dll")
HRESULT HcnCreateEndpoint(void* Network, const(GUID)* Id, const(PWSTR) Settings, void** Endpoint, 
                          PWSTR* ErrorRecord);

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcn/Reference/HcnOpenEndpoint
@DllImport("computenetwork.dll")
HRESULT HcnOpenEndpoint(const(GUID)* Id, void** Endpoint, PWSTR* ErrorRecord);

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcn/Reference/HcnModifyEndpoint
@DllImport("computenetwork.dll")
HRESULT HcnModifyEndpoint(void* Endpoint, const(PWSTR) Settings, PWSTR* ErrorRecord);

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcn/Reference/HcnQueryEndpointProperties
@DllImport("computenetwork.dll")
HRESULT HcnQueryEndpointProperties(void* Endpoint, const(PWSTR) Query, PWSTR* Properties, PWSTR* ErrorRecord);

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcn/Reference/HcnDeleteEndpoint
@DllImport("computenetwork.dll")
HRESULT HcnDeleteEndpoint(const(GUID)* Id, PWSTR* ErrorRecord);

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcn/Reference/HcnCloseEndpoint
@DllImport("computenetwork.dll")
HRESULT HcnCloseEndpoint(void* Endpoint);

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcn/Reference/HcnEnumerateLoadBalancers
@DllImport("computenetwork.dll")
HRESULT HcnEnumerateLoadBalancers(const(PWSTR) Query, PWSTR* LoadBalancer, PWSTR* ErrorRecord);

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcn/Reference/HcnCreateLoadBalancer
@DllImport("computenetwork.dll")
HRESULT HcnCreateLoadBalancer(const(GUID)* Id, const(PWSTR) Settings, void** LoadBalancer, PWSTR* ErrorRecord);

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcn/Reference/HcnOpenLoadBalancer
@DllImport("computenetwork.dll")
HRESULT HcnOpenLoadBalancer(const(GUID)* Id, void** LoadBalancer, PWSTR* ErrorRecord);

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcn/Reference/HcnModifyLoadBalancer
@DllImport("computenetwork.dll")
HRESULT HcnModifyLoadBalancer(void* LoadBalancer, const(PWSTR) Settings, PWSTR* ErrorRecord);

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcn/Reference/HcnQueryLoadBalancerProperties
@DllImport("computenetwork.dll")
HRESULT HcnQueryLoadBalancerProperties(void* LoadBalancer, const(PWSTR) Query, PWSTR* Properties, 
                                       PWSTR* ErrorRecord);

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcn/Reference/HcnDeleteLoadBalancer
@DllImport("computenetwork.dll")
HRESULT HcnDeleteLoadBalancer(const(GUID)* Id, PWSTR* ErrorRecord);

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcn/Reference/HcnCloseLoadBalancer
@DllImport("computenetwork.dll")
HRESULT HcnCloseLoadBalancer(void* LoadBalancer);

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcn/Reference/HcnRegisterServiceCallback
@DllImport("computenetwork.dll")
HRESULT HcnRegisterServiceCallback(HCN_NOTIFICATION_CALLBACK Callback, void* Context, void** CallbackHandle);

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcn/Reference/HcnUnregisterServiceCallback
@DllImport("computenetwork.dll")
HRESULT HcnUnregisterServiceCallback(void* CallbackHandle);

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcn/Reference/HcnRegisterGuestNetworkServiceCallback
@DllImport("computenetwork.dll")
HRESULT HcnRegisterGuestNetworkServiceCallback(void* GuestNetworkService, HCN_NOTIFICATION_CALLBACK Callback, 
                                               void* Context, void** CallbackHandle);

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcn/Reference/HcnUnregisterGuestNetworkServiceCallback
@DllImport("computenetwork.dll")
HRESULT HcnUnregisterGuestNetworkServiceCallback(void* CallbackHandle);

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcn/Reference/HcnCreateGuestNetworkService
@DllImport("computenetwork.dll")
HRESULT HcnCreateGuestNetworkService(const(GUID)* Id, const(PWSTR) Settings, void** GuestNetworkService, 
                                     PWSTR* ErrorRecord);

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcn/Reference/HcnCloseGuestNetworkService
@DllImport("computenetwork.dll")
HRESULT HcnCloseGuestNetworkService(void* GuestNetworkService);

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcn/Reference/HcnModifyGuestNetworkService
@DllImport("computenetwork.dll")
HRESULT HcnModifyGuestNetworkService(void* GuestNetworkService, const(PWSTR) Settings, PWSTR* ErrorRecord);

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcn/Reference/HcnDeleteGuestNetworkService
@DllImport("computenetwork.dll")
HRESULT HcnDeleteGuestNetworkService(const(GUID)* Id, PWSTR* ErrorRecord);

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcn/Reference/HcnReserveGuestNetworkServicePort
@DllImport("computenetwork.dll")
HRESULT HcnReserveGuestNetworkServicePort(void* GuestNetworkService, HCN_PORT_PROTOCOL Protocol, 
                                          HCN_PORT_ACCESS Access, ushort Port, HANDLE* PortReservationHandle);

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcn/Reference/HcnReserveGuestNetworkServicePortRange
@DllImport("computenetwork.dll")
HRESULT HcnReserveGuestNetworkServicePortRange(void* GuestNetworkService, ushort PortCount, 
                                               HCN_PORT_RANGE_RESERVATION* PortRangeReservation, 
                                               HANDLE* PortReservationHandle);

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcn/Reference/HcnReleaseGuestNetworkServicePortReservationHandle
@DllImport("computenetwork.dll")
HRESULT HcnReleaseGuestNetworkServicePortReservationHandle(HANDLE PortReservationHandle);

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcn/Reference/HcnEnumerateGuestNetworkPortReservations
@DllImport("computenetwork.dll")
HRESULT HcnEnumerateGuestNetworkPortReservations(uint* ReturnCount, 
                                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/HCN_PORT_RANGE_ENTRY** PortEntries);

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcn/Reference/HcnFreeGuestNetworkPortReservations
@DllImport("computenetwork.dll")
void HcnFreeGuestNetworkPortReservations(HCN_PORT_RANGE_ENTRY* PortEntries);

@DllImport("computenetwork.dll")
HRESULT HcnQueryEndpointStats(void* Endpoint, const(PWSTR) Query, PWSTR* Stats, PWSTR* ErrorRecord);

@DllImport("computenetwork.dll")
HRESULT HcnQueryEndpointAddresses(void* Endpoint, const(PWSTR) Query, PWSTR* Addresses, PWSTR* ErrorRecord);


