// Written in the D programming language.

module windows.win32.networkmanagement.multicast;

public import windows.core;
public import windows.win32.foundation : BOOL, UNICODE_STRING;

extern(Windows) @nogc nothrow:


// Constants


enum uint MCAST_CLIENT_ID_LEN = 0x00000011;
enum int MCAST_API_CURRENT_VERSION = 0x00000001;

enum : int
{
    MCAST_API_VERSION_0 = 0x00000000,
    MCAST_API_VERSION_1 = 0x00000001,
}

// Structs


//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/madcapcl/ns-madcapcl-ipng_address))], [])
union IPNG_ADDRESS
{
    uint      IpAddrV4;
    ubyte[16] IpAddrV6;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/madcapcl/ns-madcapcl-mcast_client_uid))], [])
struct MCAST_CLIENT_UID
{
    ubyte* ClientUID;
    uint   ClientUIDLength;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/madcapcl/ns-madcapcl-mcast_scope_ctx))], [])
struct MCAST_SCOPE_CTX
{
    IPNG_ADDRESS ScopeID;
    IPNG_ADDRESS Interface;
    IPNG_ADDRESS ServerID;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/madcapcl/ns-madcapcl-mcast_scope_entry))], [])
struct MCAST_SCOPE_ENTRY
{
    MCAST_SCOPE_CTX ScopeCtx;
    IPNG_ADDRESS    LastAddr;
    uint            TTL;
    UNICODE_STRING  ScopeDesc;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/madcapcl/ns-madcapcl-mcast_lease_request))], [])
struct MCAST_LEASE_REQUEST
{
    int          LeaseStartTime;
    int          MaxLeaseStartTime;
    uint         LeaseDuration;
    uint         MinLeaseDuration;
    IPNG_ADDRESS ServerAddress;
    ushort       MinAddrCount;
    ushort       AddrCount;
    ubyte*       pAddrBuf;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/madcapcl/ns-madcapcl-mcast_lease_response))], [])
struct MCAST_LEASE_RESPONSE
{
    int          LeaseStartTime;
    int          LeaseEndTime;
    IPNG_ADDRESS ServerAddress;
    ushort       AddrCount;
    ubyte*       pAddrBuf;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("dhcpcsvc.dll")
uint McastApiStartup(uint* Version);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("dhcpcsvc.dll")
void McastApiCleanup();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("dhcpcsvc.dll")
uint McastGenUID(MCAST_CLIENT_UID* pRequestID);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("dhcpcsvc.dll")
uint McastEnumerateScopes(ushort AddrFamily, BOOL ReQuery, MCAST_SCOPE_ENTRY* pScopeList, uint* pScopeLen, 
                          uint* pScopeCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("dhcpcsvc.dll")
uint McastRequestAddress(ushort AddrFamily, MCAST_CLIENT_UID* pRequestID, MCAST_SCOPE_CTX* pScopeCtx, 
                         MCAST_LEASE_REQUEST* pAddrRequest, MCAST_LEASE_RESPONSE* pAddrResponse);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("dhcpcsvc.dll")
uint McastRenewAddress(ushort AddrFamily, MCAST_CLIENT_UID* pRequestID, MCAST_LEASE_REQUEST* pRenewRequest, 
                       MCAST_LEASE_RESPONSE* pRenewResponse);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("dhcpcsvc.dll")
uint McastReleaseAddress(ushort AddrFamily, MCAST_CLIENT_UID* pRequestID, MCAST_LEASE_REQUEST* pReleaseRequest);


