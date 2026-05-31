// Written in the D programming language.

module windows.win32.security.networkaccessprotection;

public import windows.core;
public import system : Guid;
public import windows.win32.foundation : BOOL, FILETIME, HRESULT, PWSTR;

extern(Windows) @nogc nothrow:


// Enums

//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/naptypes/ne-naptypes-isolationstate))], [])
enum IsolationState : int
{
    isolationStateNotRestricted    = 0x00000001,
    isolationStateInProbation      = 0x00000002,
    isolationStateRestrictedAccess = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/naptypes/ne-naptypes-extendedisolationstate))], [])
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
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/naptypes/ne-naptypes-failurecategory))], [])
enum FailureCategory : int
{
    failureCategoryNone                = 0x00000000,
    failureCategoryOther               = 0x00000001,
    failureCategoryClientComponent     = 0x00000002,
    failureCategoryClientCommunication = 0x00000003,
    failureCategoryServerComponent     = 0x00000004,
    failureCategoryServerCommunication = 0x00000005,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/naptypes/ne-naptypes-fixupstate))], [])
enum FixupState : int
{
    fixupStateSuccess        = 0x00000000,
    fixupStateInProgress     = 0x00000001,
    fixupStateCouldNotUpdate = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/naptypes/ne-naptypes-napnotifytype))], [])
enum NapNotifyType : int
{
    napNotifyTypeUnknown      = 0x00000000,
    napNotifyTypeServiceState = 0x00000001,
    napNotifyTypeQuarState    = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/naptypes/ne-naptypes-remoteconfigurationtype))], [])
enum RemoteConfigurationType : int
{
    remoteConfigTypeMachine    = 0x00000001,
    remoteConfigTypeConfigBlob = 0x00000002,
}

// Constants


enum : uint
{
    maxSoHAttributeCount = 0x00000064,
    maxSoHAttributeSize  = 0x00000fa0,
}

enum uint minNetworkSoHSize = 0x0000000c;
enum uint maxNetworkSoHSize = 0x00000fa0;
enum uint maxStringLength = 0x00000400;
enum uint maxSystemHealthEntityCount = 0x00000014;
enum uint maxEnforcerCount = 0x00000014;
enum uint maxPrivateDataSize = 0x000000c8;
enum uint maxConnectionCountPerEnforcer = 0x00000014;
enum uint freshSoHRequest = 0x00000001;
enum uint shaFixup = 0x00000001;
enum uint failureCategoryCount = 0x00000005;

enum : uint
{
    ComponentTypeEnforcementClientSoH = 0x00000001,
    ComponentTypeEnforcementClientRp  = 0x00000002,
}

enum uint percentageNotSupported = 0x00000065;

// Structs


//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/naptypes/ns-naptypes-countedstring))], [])
struct CountedString
{
    ushort length;
    PWSTR  string;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/naptypes/ns-naptypes-isolationinfo))], [])
struct IsolationInfo
{
    IsolationState isolationState;
    FILETIME       probEndTime;
    CountedString  failureUrl;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/naptypes/ns-naptypes-isolationinfoex))], [])
struct IsolationInfoEx
{
    IsolationState isolationState;
    ExtendedIsolationState extendedIsolationState;
    FILETIME       probEndTime;
    CountedString  failureUrl;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/naptypes/ns-naptypes-failurecategorymapping))], [])
struct FailureCategoryMapping
{
    BOOL[5] mappingCompliance;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/naptypes/ns-naptypes-correlationid))], [])
struct CorrelationId
{
    GUID     connId;
    FILETIME timeStamp;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/naptypes/ns-naptypes-resultcodes))], [])
struct ResultCodes
{
    ushort   count;
    HRESULT* results;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/naptypes/ns-naptypes-ipv4address))], [])
struct Ipv4Address
{
    ubyte[4] addr;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/naptypes/ns-naptypes-ipv6address))], [])
struct Ipv6Address
{
    ubyte[16] addr;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/naptypes/ns-naptypes-fixupinfo))], [])
struct FixupInfo
{
    FixupState  state;
    ubyte       percentage;
    ResultCodes resultCodes;
    uint        fixupMsgId;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/naptypes/ns-naptypes-systemhealthagentstate))], [])
struct SystemHealthAgentState
{
    uint            id;
    ResultCodes     shaResultCodes;
    FailureCategory failureCategory;
    FixupInfo       fixupInfo;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/naptypes/ns-naptypes-sohattribute))], [])
struct SoHAttribute
{
    ushort type;
    ushort size;
    ubyte* value;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/naptypes/ns-naptypes-soh))], [])
struct SoH
{
    ushort        count;
    SoHAttribute* attributes;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/naptypes/ns-naptypes-networksoh))], [])
struct NetworkSoH
{
    ushort size;
    ubyte* data;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/naptypes/ns-naptypes-privatedata))], [])
struct PrivateData
{
    ushort size;
    ubyte* data;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/naptypes/ns-naptypes-napcomponentregistrationinfo))], [])
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

