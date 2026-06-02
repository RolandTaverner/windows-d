// Written in the D programming language.

module windows.win32.security.networkaccessprotection;

public import windows.core;
public import windows.win32.foundation : BOOL, FILETIME, HRESULT, PWSTR;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/naptypes/ne-naptypes-isolationstate
enum IsolationState : int
{
    isolationStateNotRestricted    = 0x00000001,
    isolationStateInProbation      = 0x00000002,
    isolationStateRestrictedAccess = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/naptypes/ne-naptypes-extendedisolationstate
enum ExtendedIsolationState : int
{
    extendedIsolationStateNoData     = 0x00000000,
    extendedIsolationStateTransition = 0x00000001,
    extendedIsolationStateInfected   = 0x00000002,
    extendedIsolationStateUnknown    = 0x00000003,
}

enum NapTracingLevel : int
{
    tracingLevelUndefined = 0x00000000,
    tracingLevelBasic     = 0x00000001,
    tracingLevelAdvanced  = 0x00000002,
    tracingLevelDebug     = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/naptypes/ne-naptypes-failurecategory
enum FailureCategory : int
{
    failureCategoryNone                = 0x00000000,
    failureCategoryOther               = 0x00000001,
    failureCategoryClientComponent     = 0x00000002,
    failureCategoryClientCommunication = 0x00000003,
    failureCategoryServerComponent     = 0x00000004,
    failureCategoryServerCommunication = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/naptypes/ne-naptypes-fixupstate
enum FixupState : int
{
    fixupStateSuccess        = 0x00000000,
    fixupStateInProgress     = 0x00000001,
    fixupStateCouldNotUpdate = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/naptypes/ne-naptypes-napnotifytype
enum NapNotifyType : int
{
    napNotifyTypeUnknown      = 0x00000000,
    napNotifyTypeServiceState = 0x00000001,
    napNotifyTypeQuarState    = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/naptypes/ne-naptypes-remoteconfigurationtype
enum RemoteConfigurationType : int
{
    remoteConfigTypeMachine    = 0x00000001,
    remoteConfigTypeConfigBlob = 0x00000002,
}

// Constants


enum : uint
{
    maxSoHAttributeCount = 0x00000064U,
    maxSoHAttributeSize  = 0x00000fa0U,
}

enum uint minNetworkSoHSize = 0x0000000cU;
enum uint maxNetworkSoHSize = 0x00000fa0U;
enum uint maxStringLength = 0x00000400U;
enum uint maxSystemHealthEntityCount = 0x00000014U;
enum uint maxEnforcerCount = 0x00000014U;
enum uint maxPrivateDataSize = 0x000000c8U;
enum uint maxConnectionCountPerEnforcer = 0x00000014U;
enum uint freshSoHRequest = 0x00000001U;
enum uint shaFixup = 0x00000001U;
enum uint failureCategoryCount = 0x00000005U;

enum : uint
{
    ComponentTypeEnforcementClientSoH = 0x00000001U,
    ComponentTypeEnforcementClientRp  = 0x00000002U,
}

enum uint percentageNotSupported = 0x00000065U;

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/naptypes/ns-naptypes-countedstring
struct CountedString
{
    ushort length;
    PWSTR  string;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/naptypes/ns-naptypes-isolationinfo
struct IsolationInfo
{
    IsolationState isolationState;
    FILETIME       probEndTime;
    CountedString  failureUrl;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/naptypes/ns-naptypes-isolationinfoex
struct IsolationInfoEx
{
    IsolationState isolationState;
    ExtendedIsolationState extendedIsolationState;
    FILETIME       probEndTime;
    CountedString  failureUrl;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/naptypes/ns-naptypes-failurecategorymapping
struct FailureCategoryMapping
{
    BOOL[5] mappingCompliance;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/naptypes/ns-naptypes-correlationid
struct CorrelationId
{
    GUID     connId;
    FILETIME timeStamp;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/naptypes/ns-naptypes-resultcodes
struct ResultCodes
{
    ushort   count;
    HRESULT* results;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/naptypes/ns-naptypes-ipv4address
struct Ipv4Address
{
    ubyte[4] addr;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/naptypes/ns-naptypes-ipv6address
struct Ipv6Address
{
    ubyte[16] addr;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/naptypes/ns-naptypes-fixupinfo
struct FixupInfo
{
    FixupState  state;
    ubyte       percentage;
    ResultCodes resultCodes;
    uint        fixupMsgId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/naptypes/ns-naptypes-systemhealthagentstate
struct SystemHealthAgentState
{
    uint            id;
    ResultCodes     shaResultCodes;
    FailureCategory failureCategory;
    FixupInfo       fixupInfo;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/naptypes/ns-naptypes-sohattribute
struct SoHAttribute
{
    ushort type;
    ushort size;
    ubyte* value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/naptypes/ns-naptypes-soh
struct SoH
{
    ushort        count;
    SoHAttribute* attributes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/naptypes/ns-naptypes-networksoh
struct NetworkSoH
{
    ushort size;
    ubyte* data;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/naptypes/ns-naptypes-privatedata
struct PrivateData
{
    ushort size;
    ubyte* data;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/naptypes/ns-naptypes-napcomponentregistrationinfo
struct NapComponentRegistrationInfo
{
    uint          id;
    CountedString friendlyName;
    CountedString description;
    CountedString version_;
    CountedString vendorName;
    GUID          infoClsid;
    GUID          configClsid;
    FILETIME      registrationDate;
    uint          componentType;
}

