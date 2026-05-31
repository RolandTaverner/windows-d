// Written in the D programming language.

module windows.win32.networkmanagement.snmp;

public import windows.core;
public import windows.win32.foundation : BOOL, CHAR, HANDLE, HWND, LPARAM, PSTR,
                                         WPARAM;

extern(Windows) @nogc nothrow:


// Enums

alias SNMP_PDU_TYPE = uint;
enum : uint
{
    SNMP_PDU_GET      = 0x000000a0,
    SNMP_PDU_GETNEXT  = 0x000000a1,
    SNMP_PDU_RESPONSE = 0x000000a2,
    SNMP_PDU_SET      = 0x000000a3,
    SNMP_PDU_GETBULK  = 0x000000a5,
    SNMP_PDU_TRAP     = 0x000000a7,
}
alias SNMP_EXTENSION_REQUEST_TYPE = uint;
enum : uint
{
    SNMP_EXTENSION_GET         = 0x000000a0,
    SNMP_EXTENSION_GET_NEXT    = 0x000000a1,
    SNMP_EXTENSION_SET_TEST    = 0x000000e0,
    SNMP_EXTENSION_SET_COMMIT  = 0x000000a3,
    SNMP_EXTENSION_SET_UNDO    = 0x000000e1,
    SNMP_EXTENSION_SET_CLEANUP = 0x000000e2,
}
alias SNMP_API_TRANSLATE_MODE = uint;
enum : uint
{
    SNMPAPI_TRANSLATED      = 0x00000000,
    SNMPAPI_UNTRANSLATED_V1 = 0x00000001,
    SNMPAPI_UNTRANSLATED_V2 = 0x00000002,
}
alias SNMP_GENERICTRAP = uint;
enum : uint
{
    SNMP_GENERICTRAP_COLDSTART     = 0x00000000,
    SNMP_GENERICTRAP_WARMSTART     = 0x00000001,
    SNMP_GENERICTRAP_LINKDOWN      = 0x00000002,
    SNMP_GENERICTRAP_LINKUP        = 0x00000003,
    SNMP_GENERICTRAP_AUTHFAILURE   = 0x00000004,
    SNMP_GENERICTRAP_EGPNEIGHLOSS  = 0x00000005,
    SNMP_GENERICTRAP_ENTERSPECIFIC = 0x00000006,
}
alias SNMP_ERROR_STATUS = uint;
enum : uint
{
    SNMP_ERRORSTATUS_NOERROR             = 0x00000000,
    SNMP_ERRORSTATUS_TOOBIG              = 0x00000001,
    SNMP_ERRORSTATUS_NOSUCHNAME          = 0x00000002,
    SNMP_ERRORSTATUS_BADVALUE            = 0x00000003,
    SNMP_ERRORSTATUS_READONLY            = 0x00000004,
    SNMP_ERRORSTATUS_GENERR              = 0x00000005,
    SNMP_ERRORSTATUS_NOACCESS            = 0x00000006,
    SNMP_ERRORSTATUS_WRONGTYPE           = 0x00000007,
    SNMP_ERRORSTATUS_WRONGLENGTH         = 0x00000008,
    SNMP_ERRORSTATUS_WRONGENCODING       = 0x00000009,
    SNMP_ERRORSTATUS_WRONGVALUE          = 0x0000000a,
    SNMP_ERRORSTATUS_NOCREATION          = 0x0000000b,
    SNMP_ERRORSTATUS_INCONSISTENTVALUE   = 0x0000000c,
    SNMP_ERRORSTATUS_RESOURCEUNAVAILABLE = 0x0000000d,
    SNMP_ERRORSTATUS_COMMITFAILED        = 0x0000000e,
    SNMP_ERRORSTATUS_UNDOFAILED          = 0x0000000f,
    SNMP_ERRORSTATUS_AUTHORIZATIONERROR  = 0x00000010,
    SNMP_ERRORSTATUS_NOTWRITABLE         = 0x00000011,
    SNMP_ERRORSTATUS_INCONSISTENTNAME    = 0x00000012,
}
alias SNMP_STATUS = uint;
enum : uint
{
    SNMPAPI_ON  = 0x00000001,
    SNMPAPI_OFF = 0x00000000,
}
alias SNMP_OUTPUT_LOG_TYPE = uint;
enum : uint
{
    SNMP_OUTPUT_TO_CONSOLE  = 0x00000001,
    SNMP_OUTPUT_TO_LOGFILE  = 0x00000002,
    SNMP_OUTPUT_TO_DEBUGGER = 0x00000008,
}
alias SNMP_LOG = int;
enum : int
{
    SNMP_LOG_SILENT  = 0x00000000,
    SNMP_LOG_FATAL   = 0x00000001,
    SNMP_LOG_ERROR   = 0x00000002,
    SNMP_LOG_WARNING = 0x00000003,
    SNMP_LOG_TRACE   = 0x00000004,
    SNMP_LOG_VERBOSE = 0x00000005,
}
alias SNMP_ERROR = uint;
enum : uint
{
    SNMP_ERROR_NOERROR             = 0x00000000,
    SNMP_ERROR_TOOBIG              = 0x00000001,
    SNMP_ERROR_NOSUCHNAME          = 0x00000002,
    SNMP_ERROR_BADVALUE            = 0x00000003,
    SNMP_ERROR_READONLY            = 0x00000004,
    SNMP_ERROR_GENERR              = 0x00000005,
    SNMP_ERROR_NOACCESS            = 0x00000006,
    SNMP_ERROR_WRONGTYPE           = 0x00000007,
    SNMP_ERROR_WRONGLENGTH         = 0x00000008,
    SNMP_ERROR_WRONGENCODING       = 0x00000009,
    SNMP_ERROR_WRONGVALUE          = 0x0000000a,
    SNMP_ERROR_NOCREATION          = 0x0000000b,
    SNMP_ERROR_INCONSISTENTVALUE   = 0x0000000c,
    SNMP_ERROR_RESOURCEUNAVAILABLE = 0x0000000d,
    SNMP_ERROR_COMMITFAILED        = 0x0000000e,
    SNMP_ERROR_UNDOFAILED          = 0x0000000f,
    SNMP_ERROR_AUTHORIZATIONERROR  = 0x00000010,
    SNMP_ERROR_NOTWRITABLE         = 0x00000011,
    SNMP_ERROR_INCONSISTENTNAME    = 0x00000012,
}

// Constants


enum uint ASN_UNIVERSAL = 0x00000000;
enum uint ASN_APPLICATION = 0x00000040;
enum uint ASN_CONTEXT = 0x00000080;

enum : uint
{
    ASN_PRIVATE   = 0x000000c0,
    ASN_PRIMITIVE = 0x00000000,
}

enum uint ASN_CONSTRUCTOR = 0x00000020;

enum : uint
{
    SNMP_ACCESS_NONE        = 0x00000000,
    SNMP_ACCESS_NOTIFY      = 0x00000001,
    SNMP_ACCESS_READ_ONLY   = 0x00000002,
    SNMP_ACCESS_READ_WRITE  = 0x00000003,
    SNMP_ACCESS_READ_CREATE = 0x00000004,
}

enum : uint
{
    SNMPAPI_NOERROR = 0x00000001,
    SNMPAPI_ERROR   = 0x00000000,
}

enum uint SNMP_OUTPUT_TO_EVENTLOG = 0x00000004;

enum : uint
{
    DEFAULT_SNMP_PORT_UDP     = 0x000000a1,
    DEFAULT_SNMP_PORT_IPX     = 0x0000900f,
    DEFAULT_SNMPTRAP_PORT_UDP = 0x000000a2,
    DEFAULT_SNMPTRAP_PORT_IPX = 0x00009010,
}

enum uint SNMP_MAX_OID_LEN = 0x00000080;
enum uint SNMP_MEM_ALLOC_ERROR = 0x00000001;

enum : uint
{
    SNMP_BERAPI_INVALID_LENGTH  = 0x0000000a,
    SNMP_BERAPI_INVALID_TAG     = 0x0000000b,
    SNMP_BERAPI_OVERFLOW        = 0x0000000c,
    SNMP_BERAPI_SHORT_BUFFER    = 0x0000000d,
    SNMP_BERAPI_INVALID_OBJELEM = 0x0000000e,
}

enum : uint
{
    SNMP_PDUAPI_UNRECOGNIZED_PDU = 0x00000014,
    SNMP_PDUAPI_INVALID_ES       = 0x00000015,
    SNMP_PDUAPI_INVALID_GT       = 0x00000016,
}

enum : uint
{
    SNMP_AUTHAPI_INVALID_VERSION  = 0x0000001e,
    SNMP_AUTHAPI_INVALID_MSG_TYPE = 0x0000001f,
    SNMP_AUTHAPI_TRIV_AUTH_FAILED = 0x00000020,
}

enum uint ASN_CONTEXTSPECIFIC = 0x00000080;
enum uint ASN_PRIMATIVE = 0x00000000;

enum : uint
{
    SNMP_MGMTAPI_TIMEOUT         = 0x00000028,
    SNMP_MGMTAPI_SELECT_FDERRORS = 0x00000029,
    SNMP_MGMTAPI_TRAP_ERRORS     = 0x0000002a,
    SNMP_MGMTAPI_TRAP_DUPINIT    = 0x0000002b,
    SNMP_MGMTAPI_NOTRAPS         = 0x0000002c,
    SNMP_MGMTAPI_AGAIN           = 0x0000002d,
    SNMP_MGMTAPI_INVALID_CTL     = 0x0000002e,
    SNMP_MGMTAPI_INVALID_SESSION = 0x0000002f,
    SNMP_MGMTAPI_INVALID_BUFFER  = 0x00000030,
}

enum uint MGMCTL_SETAGENTPORT = 0x00000001;

enum : uint
{
    MAXOBJIDSIZE    = 0x00000080,
    MAXOBJIDSTRSIZE = 0x00000580,
}

enum : uint
{
    SNMPLISTEN_USEENTITY_ADDR = 0x00000000,
    SNMPLISTEN_ALL_ADDR       = 0x00000001,
}

enum : uint
{
    SNMP_TRAP_COLDSTART          = 0x00000000,
    SNMP_TRAP_WARMSTART          = 0x00000001,
    SNMP_TRAP_LINKDOWN           = 0x00000002,
    SNMP_TRAP_LINKUP             = 0x00000003,
    SNMP_TRAP_AUTHFAIL           = 0x00000004,
    SNMP_TRAP_EGPNEIGHBORLOSS    = 0x00000005,
    SNMP_TRAP_ENTERPRISESPECIFIC = 0x00000006,
}

enum : uint
{
    SNMPAPI_NO_SUPPORT      = 0x00000000,
    SNMPAPI_V1_SUPPORT      = 0x00000001,
    SNMPAPI_V2_SUPPORT      = 0x00000002,
    SNMPAPI_M2M_SUPPORT     = 0x00000003,
    SNMPAPI_FAILURE         = 0x00000000,
    SNMPAPI_SUCCESS         = 0x00000001,
    SNMPAPI_ALLOC_ERROR     = 0x00000002,
    SNMPAPI_CONTEXT_INVALID = 0x00000003,
    SNMPAPI_CONTEXT_UNKNOWN = 0x00000004,
}

enum : uint
{
    SNMPAPI_ENTITY_INVALID = 0x00000005,
    SNMPAPI_ENTITY_UNKNOWN = 0x00000006,
}

enum uint SNMPAPI_INDEX_INVALID = 0x00000007;

enum : uint
{
    SNMPAPI_NOOP              = 0x00000008,
    SNMPAPI_OID_INVALID       = 0x00000009,
    SNMPAPI_OPERATION_INVALID = 0x0000000a,
}

enum uint SNMPAPI_OUTPUT_TRUNCATED = 0x0000000b;

enum : uint
{
    SNMPAPI_PDU_INVALID     = 0x0000000c,
    SNMPAPI_SESSION_INVALID = 0x0000000d,
}

enum uint SNMPAPI_SYNTAX_INVALID = 0x0000000e;

enum : uint
{
    SNMPAPI_VBL_INVALID  = 0x0000000f,
    SNMPAPI_MODE_INVALID = 0x00000010,
}

enum uint SNMPAPI_SIZE_INVALID = 0x00000011;
enum uint SNMPAPI_NOT_INITIALIZED = 0x00000012;
enum uint SNMPAPI_MESSAGE_INVALID = 0x00000013;
enum uint SNMPAPI_HWND_INVALID = 0x00000014;

enum : uint
{
    SNMPAPI_OTHER_ERROR        = 0x00000063,
    SNMPAPI_TL_NOT_INITIALIZED = 0x00000064,
    SNMPAPI_TL_NOT_SUPPORTED   = 0x00000065,
    SNMPAPI_TL_NOT_AVAILABLE   = 0x00000066,
    SNMPAPI_TL_RESOURCE_ERROR  = 0x00000067,
    SNMPAPI_TL_UNDELIVERABLE   = 0x00000068,
    SNMPAPI_TL_SRC_INVALID     = 0x00000069,
    SNMPAPI_TL_INVALID_PARAM   = 0x0000006a,
    SNMPAPI_TL_IN_USE          = 0x0000006b,
    SNMPAPI_TL_TIMEOUT         = 0x0000006c,
    SNMPAPI_TL_PDU_TOO_BIG     = 0x0000006d,
    SNMPAPI_TL_OTHER           = 0x000000c7,
}

enum uint MAXVENDORINFO = 0x00000020;

// Callbacks

alias PFNSNMPEXTENSIONINIT = BOOL function(uint dwUpTimeReference, HANDLE* phSubagentTrapEvent, 
                                           AsnObjectIdentifier* pFirstSupportedRegion);
alias PFNSNMPEXTENSIONINITEX = BOOL function(AsnObjectIdentifier* pNextSupportedRegion);
alias PFNSNMPEXTENSIONMONITOR = BOOL function(void* pAgentMgmtData);
alias PFNSNMPEXTENSIONQUERY = BOOL function(ubyte bPduType, SnmpVarBindList* pVarBindList, int* pErrorStatus, 
                                            int* pErrorIndex);
alias PFNSNMPEXTENSIONQUERYEX = BOOL function(uint nRequestType, uint nTransactionId, 
                                              SnmpVarBindList* pVarBindList, AsnOctetString* pContextInfo, 
                                              int* pErrorStatus, int* pErrorIndex);
alias PFNSNMPEXTENSIONTRAP = BOOL function(AsnObjectIdentifier* pEnterpriseOid, int* pGenericTrapId, 
                                           int* pSpecificTrapId, uint* pTimeStamp, SnmpVarBindList* pVarBindList);
alias PFNSNMPEXTENSIONCLOSE = void function();
alias SNMPAPI_CALLBACK = uint function(ptrdiff_t hSession, HWND hWnd, uint wMsg, WPARAM wParam, LPARAM lParam, 
                                       void* lpClientData);
alias PFNSNMPSTARTUPEX = uint function(uint* param0, uint* param1, uint* param2, uint* param3, uint* param4);
alias PFNSNMPCLEANUPEX = uint function();

// Structs


//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/snmp/ns-snmp-asnoctetstring))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(6))], [])
struct AsnOctetString
{
align (4):
    ubyte* stream;
    uint   length;
    BOOL   dynamic;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/snmp/ns-snmp-asnobjectidentifier))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(6))], [])
struct AsnObjectIdentifier
{
align (4):
    uint  idLength;
    uint* ids;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/snmp/ns-snmp-snmpvarbindlist))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(6))], [])
struct SnmpVarBindList
{
align (4):
    SnmpVarBind* list;
    uint         len;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/snmp/ns-snmp-asnoctetstring))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(1))], [])
struct AsnOctetString
{
    ubyte* stream;
    uint   length;
    BOOL   dynamic;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/snmp/ns-snmp-asnobjectidentifier))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(1))], [])
struct AsnObjectIdentifier
{
    uint  idLength;
    uint* ids;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/snmp/ns-snmp-asnany))], [])
struct AsnAny
{
align (4):
    ubyte              asnType;
    _asnValue_e__Union asnValue;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/snmp/ns-snmp-snmpvarbind))], [])
struct SnmpVarBind
{
align (4):
    AsnObjectIdentifier name;
    AsnAny              value;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/snmp/ns-snmp-snmpvarbindlist))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(1))], [])
struct SnmpVarBindList
{
    SnmpVarBind* list;
    uint         len;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsnmp/ns-winsnmp-smioctets))], [])
struct smiOCTETS
{
    uint   len;
    ubyte* ptr;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsnmp/ns-winsnmp-smioid))], [])
struct smiOID
{
    uint  len;
    uint* ptr;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsnmp/ns-winsnmp-smicntr64))], [])
struct smiCNTR64
{
    uint hipart;
    uint lopart;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsnmp/ns-winsnmp-smivalue))], [])
struct smiVALUE
{
    uint            syntax;
    _value_e__Union value;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsnmp/ns-winsnmp-smivendorinfo))], [])
struct smiVENDORINFO
{
    CHAR[64] vendorName;
    CHAR[64] vendorContact;
    CHAR[32] vendorVersionId;
    CHAR[32] vendorVersionDate;
    uint     vendorEnterprise;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("snmpapi.dll")
int SnmpUtilOidCpy(AsnObjectIdentifier* pOidDst, AsnObjectIdentifier* pOidSrc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("snmpapi.dll")
int SnmpUtilOidAppend(AsnObjectIdentifier* pOidDst, AsnObjectIdentifier* pOidSrc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("snmpapi.dll")
int SnmpUtilOidNCmp(AsnObjectIdentifier* pOid1, AsnObjectIdentifier* pOid2, uint nSubIds);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("snmpapi.dll")
int SnmpUtilOidCmp(AsnObjectIdentifier* pOid1, AsnObjectIdentifier* pOid2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("snmpapi.dll")
void SnmpUtilOidFree(AsnObjectIdentifier* pOid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("snmpapi.dll")
int SnmpUtilOctetsCmp(AsnOctetString* pOctets1, AsnOctetString* pOctets2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("snmpapi.dll")
int SnmpUtilOctetsNCmp(AsnOctetString* pOctets1, AsnOctetString* pOctets2, uint nChars);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("snmpapi.dll")
int SnmpUtilOctetsCpy(AsnOctetString* pOctetsDst, AsnOctetString* pOctetsSrc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("snmpapi.dll")
void SnmpUtilOctetsFree(AsnOctetString* pOctets);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("snmpapi.dll")
int SnmpUtilAsnAnyCpy(AsnAny* pAnyDst, AsnAny* pAnySrc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("snmpapi.dll")
void SnmpUtilAsnAnyFree(AsnAny* pAny);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("snmpapi.dll")
int SnmpUtilVarBindCpy(SnmpVarBind* pVbDst, SnmpVarBind* pVbSrc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("snmpapi.dll")
void SnmpUtilVarBindFree(SnmpVarBind* pVb);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("snmpapi.dll")
int SnmpUtilVarBindListCpy(SnmpVarBindList* pVblDst, SnmpVarBindList* pVblSrc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("snmpapi.dll")
void SnmpUtilVarBindListFree(SnmpVarBindList* pVbl);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("snmpapi.dll")
void SnmpUtilMemFree(void* pMem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("snmpapi.dll")
void* SnmpUtilMemAlloc(uint nBytes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("snmpapi.dll")
void* SnmpUtilMemReAlloc(void* pMem, uint nBytes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("snmpapi.dll")
PSTR SnmpUtilOidToA(AsnObjectIdentifier* Oid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("snmpapi.dll")
PSTR SnmpUtilIdsToA(uint* Ids, uint IdLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("snmpapi.dll")
void SnmpUtilPrintOid(AsnObjectIdentifier* Oid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("snmpapi.dll")
void SnmpUtilPrintAsnAny(AsnAny* pAny);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("snmpapi.dll")
uint SnmpSvcGetUptime();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("snmpapi.dll")
void SnmpSvcSetLogLevel(SNMP_LOG nLogLevel);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("snmpapi.dll")
void SnmpSvcSetLogType(/*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(SNMP_OUTPUT_LOG_TYPE))], [])*/int nLogType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("snmpapi.dll")
void SnmpUtilDbgPrint(SNMP_LOG nLogLevel, PSTR szFormat);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("mgmtapi.dll")
void* SnmpMgrOpen(PSTR lpAgentAddress, PSTR lpAgentCommunity, int nTimeOut, int nRetries);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("mgmtapi.dll")
BOOL SnmpMgrCtl(void* session, uint dwCtlCode, void* lpvInBuffer, uint cbInBuffer, void* lpvOUTBuffer, 
                uint cbOUTBuffer, uint* lpcbBytesReturned);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("mgmtapi.dll")
BOOL SnmpMgrClose(void* session);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("mgmtapi.dll")
int SnmpMgrRequest(void* session, ubyte requestType, SnmpVarBindList* variableBindings, 
                   SNMP_ERROR_STATUS* errorStatus, int* errorIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("mgmtapi.dll")
BOOL SnmpMgrStrToOid(PSTR string, AsnObjectIdentifier* oid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("mgmtapi.dll")
BOOL SnmpMgrOidToStr(AsnObjectIdentifier* oid, PSTR* string);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("mgmtapi.dll")
BOOL SnmpMgrTrapListen(HANDLE* phTrapAvailable);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("mgmtapi.dll")
BOOL SnmpMgrGetTrap(AsnObjectIdentifier* enterprise, AsnOctetString* IPAddress, SNMP_GENERICTRAP* genericTrap, 
                    int* specificTrap, uint* timeStamp, SnmpVarBindList* variableBindings);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("mgmtapi.dll")
BOOL SnmpMgrGetTrapEx(AsnObjectIdentifier* enterprise, AsnOctetString* agentAddress, AsnOctetString* sourceAddress, 
                      SNMP_GENERICTRAP* genericTrap, int* specificTrap, AsnOctetString* community, uint* timeStamp, 
                      SnmpVarBindList* variableBindings);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("wsnmp32.dll")
uint SnmpGetTranslateMode(SNMP_API_TRANSLATE_MODE* nTranslateMode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("wsnmp32.dll")
uint SnmpSetTranslateMode(SNMP_API_TRANSLATE_MODE nTranslateMode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("wsnmp32.dll")
uint SnmpGetRetransmitMode(SNMP_STATUS* nRetransmitMode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("wsnmp32.dll")
uint SnmpSetRetransmitMode(SNMP_STATUS nRetransmitMode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("wsnmp32.dll")
uint SnmpGetTimeout(ptrdiff_t hEntity, uint* nPolicyTimeout, uint* nActualTimeout);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("wsnmp32.dll")
uint SnmpSetTimeout(ptrdiff_t hEntity, uint nPolicyTimeout);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("wsnmp32.dll")
uint SnmpGetRetry(ptrdiff_t hEntity, uint* nPolicyRetry, uint* nActualRetry);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("wsnmp32.dll")
uint SnmpSetRetry(ptrdiff_t hEntity, uint nPolicyRetry);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("wsnmp32.dll")
uint SnmpGetVendorInfo(smiVENDORINFO* vendorInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("wsnmp32.dll")
uint SnmpStartup(uint* nMajorVersion, uint* nMinorVersion, uint* nLevel, SNMP_API_TRANSLATE_MODE* nTranslateMode, 
                 SNMP_STATUS* nRetransmitMode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("wsnmp32.dll")
uint SnmpCleanup();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("wsnmp32.dll")
ptrdiff_t SnmpOpen(HWND hWnd, uint wMsg);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("wsnmp32.dll")
uint SnmpClose(ptrdiff_t session);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("wsnmp32.dll")
uint SnmpSendMsg(ptrdiff_t session, ptrdiff_t srcEntity, ptrdiff_t dstEntity, ptrdiff_t context, ptrdiff_t PDU);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("wsnmp32.dll")
uint SnmpRecvMsg(ptrdiff_t session, ptrdiff_t* srcEntity, ptrdiff_t* dstEntity, ptrdiff_t* context, ptrdiff_t* PDU);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("wsnmp32.dll")
uint SnmpRegister(ptrdiff_t session, ptrdiff_t srcEntity, ptrdiff_t dstEntity, ptrdiff_t context, 
                  smiOID* notification, SNMP_STATUS state);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("wsnmp32.dll")
ptrdiff_t SnmpCreateSession(HWND hWnd, uint wMsg, SNMPAPI_CALLBACK fCallBack, void* lpClientData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("wsnmp32.dll")
uint SnmpListen(ptrdiff_t hEntity, SNMP_STATUS lStatus);

@DllImport("wsnmp32.dll")
uint SnmpListenEx(ptrdiff_t hEntity, uint lStatus, uint nUseEntityAddr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("wsnmp32.dll")
uint SnmpCancelMsg(ptrdiff_t session, int reqId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("wsnmp32.dll")
uint SnmpStartupEx(uint* nMajorVersion, uint* nMinorVersion, uint* nLevel, SNMP_API_TRANSLATE_MODE* nTranslateMode, 
                   SNMP_STATUS* nRetransmitMode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("wsnmp32.dll")
uint SnmpCleanupEx();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("wsnmp32.dll")
ptrdiff_t SnmpStrToEntity(ptrdiff_t session, const(PSTR) string);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("wsnmp32.dll")
uint SnmpEntityToStr(ptrdiff_t entity, uint size, PSTR string);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("wsnmp32.dll")
uint SnmpFreeEntity(ptrdiff_t entity);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("wsnmp32.dll")
ptrdiff_t SnmpStrToContext(ptrdiff_t session, smiOCTETS* string);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("wsnmp32.dll")
uint SnmpContextToStr(ptrdiff_t context, smiOCTETS* string);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("wsnmp32.dll")
uint SnmpFreeContext(ptrdiff_t context);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("wsnmp32.dll")
uint SnmpSetPort(ptrdiff_t hEntity, uint nPort);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("wsnmp32.dll")
ptrdiff_t SnmpCreatePdu(ptrdiff_t session, SNMP_PDU_TYPE PDU_type, int request_id, int error_status, 
                        int error_index, ptrdiff_t varbindlist);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("wsnmp32.dll")
uint SnmpGetPduData(ptrdiff_t PDU, SNMP_PDU_TYPE* PDU_type, int* request_id, SNMP_ERROR* error_status, 
                    int* error_index, ptrdiff_t* varbindlist);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("wsnmp32.dll")
uint SnmpSetPduData(ptrdiff_t PDU, const(int)* PDU_type, const(int)* request_id, const(int)* non_repeaters, 
                    const(int)* max_repetitions, const(ptrdiff_t)* varbindlist);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("wsnmp32.dll")
ptrdiff_t SnmpDuplicatePdu(ptrdiff_t session, ptrdiff_t PDU);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("wsnmp32.dll")
uint SnmpFreePdu(ptrdiff_t PDU);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("wsnmp32.dll")
ptrdiff_t SnmpCreateVbl(ptrdiff_t session, smiOID* name, smiVALUE* value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("wsnmp32.dll")
ptrdiff_t SnmpDuplicateVbl(ptrdiff_t session, ptrdiff_t vbl);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("wsnmp32.dll")
uint SnmpFreeVbl(ptrdiff_t vbl);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("wsnmp32.dll")
uint SnmpCountVbl(ptrdiff_t vbl);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("wsnmp32.dll")
uint SnmpGetVb(ptrdiff_t vbl, uint index, smiOID* name, smiVALUE* value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("wsnmp32.dll")
uint SnmpSetVb(ptrdiff_t vbl, uint index, smiOID* name, smiVALUE* value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("wsnmp32.dll")
uint SnmpDeleteVb(ptrdiff_t vbl, uint index);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("wsnmp32.dll")
uint SnmpGetLastError(ptrdiff_t session);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("wsnmp32.dll")
uint SnmpStrToOid(const(PSTR) string, smiOID* dstOID);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("wsnmp32.dll")
uint SnmpOidToStr(smiOID* srcOID, uint size, PSTR string);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("wsnmp32.dll")
uint SnmpOidCopy(smiOID* srcOID, smiOID* dstOID);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("wsnmp32.dll")
uint SnmpOidCompare(smiOID* xOID, smiOID* yOID, uint maxlen, int* result);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("wsnmp32.dll")
uint SnmpEncodeMsg(ptrdiff_t session, ptrdiff_t srcEntity, ptrdiff_t dstEntity, ptrdiff_t context, ptrdiff_t pdu, 
                   smiOCTETS* msgBufDesc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("wsnmp32.dll")
uint SnmpDecodeMsg(ptrdiff_t session, ptrdiff_t* srcEntity, ptrdiff_t* dstEntity, ptrdiff_t* context, 
                   ptrdiff_t* pdu, smiOCTETS* msgBufDesc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("wsnmp32.dll")
uint SnmpFreeDescriptor(uint syntax, smiOCTETS* descriptor);


