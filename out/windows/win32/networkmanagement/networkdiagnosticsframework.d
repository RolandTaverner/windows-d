// Written in the D programming language.

module windows.win32.networkmanagement.networkdiagnosticsframework;

public import windows.core;
public import system : Guid;
public import windows.win32.foundation : BOOL, CHAR, FILETIME, HRESULT, HWND, PWSTR;
public import windows.win32.networking.winsock : SOCKET, SOCKET_ADDRESS_LIST;
public import windows.win32.security : SID;
public import windows.win32.system.com : IUnknown;

extern(Windows) @nogc nothrow:


// Enums

//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ndattrib/ne-ndattrib-attribute_type))], [])
alias ATTRIBUTE_TYPE = int;
enum : int
{
    AT_INVALID      = 0x00000000,
    AT_BOOLEAN      = 0x00000001,
    AT_INT8         = 0x00000002,
    AT_UINT8        = 0x00000003,
    AT_INT16        = 0x00000004,
    AT_UINT16       = 0x00000005,
    AT_INT32        = 0x00000006,
    AT_UINT32       = 0x00000007,
    AT_INT64        = 0x00000008,
    AT_UINT64       = 0x00000009,
    AT_STRING       = 0x0000000a,
    AT_GUID         = 0x0000000b,
    AT_LIFE_TIME    = 0x0000000c,
    AT_SOCKADDR     = 0x0000000d,
    AT_OCTET_STRING = 0x0000000e,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ndattrib/ne-ndattrib-repair_scope))], [])
alias REPAIR_SCOPE = int;
enum : int
{
    RS_SYSTEM      = 0x00000000,
    RS_USER        = 0x00000001,
    RS_APPLICATION = 0x00000002,
    RS_PROCESS     = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ndattrib/ne-ndattrib-repair_risk))], [])
alias REPAIR_RISK = int;
enum : int
{
    RR_NOROLLBACK = 0x00000000,
    RR_ROLLBACK   = 0x00000001,
    RR_NORISK     = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ndattrib/ne-ndattrib-ui_info_type))], [])
alias UI_INFO_TYPE = int;
enum : int
{
    UIT_INVALID       = 0x00000000,
    UIT_NONE          = 0x00000001,
    UIT_SHELL_COMMAND = 0x00000002,
    UIT_HELP_PANE     = 0x00000003,
    UIT_DUI           = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ndhelper/ne-ndhelper-diagnosis_status))], [])
alias DIAGNOSIS_STATUS = int;
enum : int
{
    DS_NOT_IMPLEMENTED = 0x00000000,
    DS_CONFIRMED       = 0x00000001,
    DS_REJECTED        = 0x00000002,
    DS_INDETERMINATE   = 0x00000003,
    DS_DEFERRED        = 0x00000004,
    DS_PASSTHROUGH     = 0x00000005,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ndhelper/ne-ndhelper-repair_status))], [])
alias REPAIR_STATUS = int;
enum : int
{
    RS_NOT_IMPLEMENTED = 0x00000000,
    RS_REPAIRED        = 0x00000001,
    RS_UNREPAIRED      = 0x00000002,
    RS_DEFERRED        = 0x00000003,
    RS_USER_ACTION     = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ndhelper/ne-ndhelper-problem_type))], [])
alias PROBLEM_TYPE = int;
enum : int
{
    PT_INVALID               = 0x00000000,
    PT_LOW_HEALTH            = 0x00000001,
    PT_LOWER_HEALTH          = 0x00000002,
    PT_DOWN_STREAM_HEALTH    = 0x00000004,
    PT_HIGH_UTILIZATION      = 0x00000008,
    PT_HIGHER_UTILIZATION    = 0x00000010,
    PT_UP_STREAM_UTILIZATION = 0x00000020,
}

// Constants


enum uint NDF_ERROR_START = 0x0000f900;
enum HRESULT NDF_E_LENGTH_EXCEEDED = HRESULT(0x8008f900);
enum HRESULT NDF_E_NOHELPERCLASS = HRESULT(0x8008f901);
enum HRESULT NDF_E_CANCELLED = HRESULT(0x8008f902);

enum : HRESULT
{
    NDF_E_DISABLED  = HRESULT(0x8008f904),
    NDF_E_BAD_PARAM = HRESULT(0x8008f905),
}

enum HRESULT NDF_E_VALIDATION = HRESULT(0x8008f906);

enum : HRESULT
{
    NDF_E_UNKNOWN         = HRESULT(0x8008f907),
    NDF_E_PROBLEM_PRESENT = HRESULT(0x8008f908),
}

enum uint RF_WORKAROUND = 0x20000000;

enum : uint
{
    RF_USER_ACTION       = 0x10000000,
    RF_USER_CONFIRMATION = 0x08000000,
}

enum uint RF_INFORMATION_ONLY = 0x02000000;
enum uint RF_UI_ONLY = 0x01000000;
enum uint RF_SHOW_EVENTS = 0x00800000;
enum uint RF_VALIDATE_HELPTOPIC = 0x00400000;
enum uint RF_REPRO = 0x00200000;
enum uint RF_CONTACT_ADMIN = 0x00020000;

enum : uint
{
    RF_RESERVED     = 0x40000000,
    RF_RESERVED_CA  = 0x80000000,
    RF_RESERVED_LNI = 0x00010000,
}

enum : uint
{
    RCF_ISLEAF      = 0x00000001,
    RCF_ISCONFIRMED = 0x00000002,
}

enum uint RCF_ISTHIRDPARTY = 0x00000004;
enum uint DF_IMPERSONATION = 0x80000000;
enum uint DF_TRACELESS = 0x40000000;

enum : uint
{
    NDF_INBOUND_FLAG_EDGETRAVERSAL = 0x00000001,
    NDF_INBOUND_FLAG_HEALTHCHECK   = 0x00000002,
}

enum uint NDF_ADD_CAPTURE_TRACE = 0x00000001;
enum uint NDF_APPLY_INCLUSION_LIST_FILTER = 0x00000002;

// Structs


//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ndattrib/ns-ndattrib-octet_string))], [])
struct OCTET_STRING
{
    uint   dwLength;
    ubyte* lpValue;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ndattrib/ns-ndattrib-life_time))], [])
struct LIFE_TIME
{
    FILETIME startTime;
    FILETIME endTime;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ndattrib/ns-ndattrib-diag_sockaddr))], [])
struct DIAG_SOCKADDR
{
    ushort    family;
    CHAR[126] data;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ndattrib/ns-ndattrib-helper_attribute))], [])
struct HELPER_ATTRIBUTE
{
    PWSTR               pwszName;
    ATTRIBUTE_TYPE      type;
    _Anonymous_e__Union Anonymous;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ndattrib/ns-ndattrib-shellcommandinfo))], [])
struct ShellCommandInfo
{
    PWSTR pwszOperation;
    PWSTR pwszFile;
    PWSTR pwszParameters;
    PWSTR pwszDirectory;
    uint  nShowCmd;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ndattrib/ns-ndattrib-uiinfo))], [])
struct UiInfo
{
    UI_INFO_TYPE        type;
    _Anonymous_e__Union Anonymous;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ndattrib/ns-ndattrib-repairinfo))], [])
struct RepairInfo
{
    GUID         guid;
    PWSTR        pwszClassName;
    PWSTR        pwszDescription;
    uint         sidType;
    int          cost;
    uint         flags;
    REPAIR_SCOPE scope_;
    REPAIR_RISK  risk;
    UiInfo       UiInfo57;
    int          rootCauseIndex;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ndattrib/ns-ndattrib-repairinfoex))], [])
struct RepairInfoEx
{
    RepairInfo repair;
    ushort     repairRank;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ndattrib/ns-ndattrib-rootcauseinfo))], [])
struct RootCauseInfo
{
    PWSTR         pwszDescription;
    GUID          rootCauseID;
    uint          rootCauseFlags;
    GUID          networkInterfaceID;
    RepairInfoEx* pRepairs;
    ushort        repairCount;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ndhelper/ns-ndhelper-hypothesis))], [])
struct HYPOTHESIS
{
    PWSTR             pwszClassName;
    PWSTR             pwszDescription;
    uint              celt;
    HELPER_ATTRIBUTE* rgAttributes;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ndhelper/ns-ndhelper-helperattributeinfo))], [])
struct HelperAttributeInfo
{
    PWSTR          pwszName;
    ATTRIBUTE_TYPE type;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ndhelper/ns-ndhelper-diagnosticsinfo))], [])
struct DiagnosticsInfo
{
    int  cost;
    uint flags;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ndhelper/ns-ndhelper-hypothesisresult))], [])
struct HypothesisResult
{
    HYPOTHESIS       hypothesis;
    DIAGNOSIS_STATUS pathStatus;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NDFAPI.dll")
HRESULT NdfCreateIncident(const(PWSTR) helperClassName, uint celt, HELPER_ATTRIBUTE* attributes, void** handle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NDFAPI.dll")
HRESULT NdfCreateWinSockIncident(SOCKET sock, const(PWSTR) host, ushort port, const(PWSTR) appId, SID* userId, 
                                 void** handle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NDFAPI.dll")
HRESULT NdfCreateWebIncident(const(PWSTR) url, void** handle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NDFAPI.dll")
HRESULT NdfCreateWebIncidentEx(const(PWSTR) url, BOOL useWinHTTP, PWSTR moduleName, void** handle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NDFAPI.dll")
HRESULT NdfCreateSharingIncident(const(PWSTR) UNCPath, void** handle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NDFAPI.dll")
HRESULT NdfCreateDNSIncident(const(PWSTR) hostname, ushort queryType, void** handle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NDFAPI.dll")
HRESULT NdfCreateConnectivityIncident(void** handle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("NDFAPI.dll")
HRESULT NdfCreateNetConnectionIncident(void** handle, GUID id);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("NDFAPI.dll")
HRESULT NdfCreatePnrpIncident(const(PWSTR) cloudname, const(PWSTR) peername, BOOL diagnosePublish, 
                              const(PWSTR) appId, void** handle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("NDFAPI.dll")
HRESULT NdfCreateGroupingIncident(const(PWSTR) CloudName, const(PWSTR) GroupName, const(PWSTR) Identity, 
                                  const(PWSTR) Invitation, SOCKET_ADDRESS_LIST* Addresses, const(PWSTR) appId, 
                                  void** handle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NDFAPI.dll")
HRESULT NdfExecuteDiagnosis(void* handle, HWND hwnd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NDFAPI.dll")
HRESULT NdfCloseIncident(void* handle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("NDFAPI.dll")
HRESULT NdfDiagnoseIncident(void* Handle, uint* RootCauseCount, RootCauseInfo** RootCauses, uint dwWait, 
                            uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("NDFAPI.dll")
HRESULT NdfRepairIncident(void* Handle, RepairInfoEx* RepairEx, uint dwWait);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("NDFAPI.dll")
HRESULT NdfCancelIncident(void* Handle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("NDFAPI.dll")
HRESULT NdfGetTraceFile(void* Handle, const(PWSTR)* TraceFileLocation);


// Interfaces

@GUID("c0b35746-ebf5-11d8-bbe9-505054503030")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ndhelper/nn-ndhelper-inetdiaghelper))], [])
interface INetDiagHelper : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ndhelper/nf-ndhelper-inetdiaghelper-initialize))], [])
    HRESULT Initialize(uint celt, HELPER_ATTRIBUTE* rgAttributes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ndhelper/nf-ndhelper-inetdiaghelper-getdiagnosticsinfo))], [])
    HRESULT GetDiagnosticsInfo(DiagnosticsInfo** ppInfo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ndhelper/nf-ndhelper-inetdiaghelper-getkeyattributes))], [])
    HRESULT GetKeyAttributes(uint* pcelt, HELPER_ATTRIBUTE** pprgAttributes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ndhelper/nf-ndhelper-inetdiaghelper-lowhealth))], [])
    HRESULT LowHealth(const(PWSTR) pwszInstanceDescription, PWSTR* ppwszDescription, int* pDeferredTime, 
                      DIAGNOSIS_STATUS* pStatus);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ndhelper/nf-ndhelper-inetdiaghelper-highutilization))], [])
    HRESULT HighUtilization(const(PWSTR) pwszInstanceDescription, PWSTR* ppwszDescription, int* pDeferredTime, 
                            DIAGNOSIS_STATUS* pStatus);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ndhelper/nf-ndhelper-inetdiaghelper-getlowerhypotheses))], [])
    HRESULT GetLowerHypotheses(uint* pcelt, HYPOTHESIS** pprgHypotheses);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ndhelper/nf-ndhelper-inetdiaghelper-getdownstreamhypotheses))], [])
    HRESULT GetDownStreamHypotheses(uint* pcelt, HYPOTHESIS** pprgHypotheses);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ndhelper/nf-ndhelper-inetdiaghelper-gethigherhypotheses))], [])
    HRESULT GetHigherHypotheses(uint* pcelt, HYPOTHESIS** pprgHypotheses);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ndhelper/nf-ndhelper-inetdiaghelper-getupstreamhypotheses))], [])
    HRESULT GetUpStreamHypotheses(uint* pcelt, HYPOTHESIS** pprgHypotheses);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ndhelper/nf-ndhelper-inetdiaghelper-repair))], [])
    HRESULT Repair(RepairInfo* pInfo, int* pDeferredTime, REPAIR_STATUS* pStatus);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ndhelper/nf-ndhelper-inetdiaghelper-validate))], [])
    HRESULT Validate(PROBLEM_TYPE problem, int* pDeferredTime, REPAIR_STATUS* pStatus);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ndhelper/nf-ndhelper-inetdiaghelper-getrepairinfo))], [])
    HRESULT GetRepairInfo(PROBLEM_TYPE problem, uint* pcelt, RepairInfo** ppInfo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ndhelper/nf-ndhelper-inetdiaghelper-getlifetime))], [])
    HRESULT GetLifeTime(LIFE_TIME* pLifeTime);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ndhelper/nf-ndhelper-inetdiaghelper-setlifetime))], [])
    HRESULT SetLifeTime(LIFE_TIME lifeTime);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ndhelper/nf-ndhelper-inetdiaghelper-getcachetime))], [])
    HRESULT GetCacheTime(FILETIME* pCacheTime);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ndhelper/nf-ndhelper-inetdiaghelper-getattributes))], [])
    HRESULT GetAttributes(uint* pcelt, HELPER_ATTRIBUTE** pprgAttributes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ndhelper/nf-ndhelper-inetdiaghelper-cancel))], [])
    HRESULT Cancel();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ndhelper/nf-ndhelper-inetdiaghelper-cleanup))], [])
    HRESULT Cleanup();
}

@GUID("104613fb-bc57-4178-95ba-88809698354a")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ndhelper/nn-ndhelper-inetdiaghelperutilfactory))], [])
interface INetDiagHelperUtilFactory : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ndhelper/nf-ndhelper-inetdiaghelperutilfactory-createutilityinstance))], [])
    HRESULT CreateUtilityInstance(const(GUID)* riid, void** ppvObject);
}

@GUID("972dab4d-e4e3-4fc6-ae54-5f65ccde4a15")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ndhelper/nn-ndhelper-inetdiaghelperex))], [])
interface INetDiagHelperEx : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ndhelper/nf-ndhelper-inetdiaghelperex-reconfirmlowhealth))], [])
    HRESULT ReconfirmLowHealth(uint celt, HypothesisResult* pResults, PWSTR* ppwszUpdatedDescription, 
                               DIAGNOSIS_STATUS* pUpdatedStatus);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ndhelper/nf-ndhelper-inetdiaghelperex-setutilities))], [])
    HRESULT SetUtilities(INetDiagHelperUtilFactory pUtilities);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ndhelper/nf-ndhelper-inetdiaghelperex-reproducefailure))], [])
    HRESULT ReproduceFailure();
}

@GUID("c0b35747-ebf5-11d8-bbe9-505054503030")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ndhelper/nn-ndhelper-inetdiaghelperinfo))], [])
interface INetDiagHelperInfo : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ndhelper/nf-ndhelper-inetdiaghelperinfo-getattributeinfo))], [])
    HRESULT GetAttributeInfo(uint* pcelt, HelperAttributeInfo** pprgAttributeInfos);
}

@GUID("c0b35748-ebf5-11d8-bbe9-505054503030")
interface INetDiagExtensibleHelper : IUnknown
{
    HRESULT ResolveAttributes(uint celt, HELPER_ATTRIBUTE* rgKeyAttributes, uint* pcelt, 
                              HELPER_ATTRIBUTE** prgMatchValues);
}


// GUIDs


const GUID IID_INetDiagExtensibleHelper  = GUIDOF!INetDiagExtensibleHelper;
const GUID IID_INetDiagHelper            = GUIDOF!INetDiagHelper;
const GUID IID_INetDiagHelperEx          = GUIDOF!INetDiagHelperEx;
const GUID IID_INetDiagHelperInfo        = GUIDOF!INetDiagHelperInfo;
const GUID IID_INetDiagHelperUtilFactory = GUIDOF!INetDiagHelperUtilFactory;
