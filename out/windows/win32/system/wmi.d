// Written in the D programming language.

module windows.win32.system.wmi;

public import windows.core;
public import system.system : Guid;
public import windows.win32.foundation.foundation : BOOL, BSTR, HRESULT, PWSTR, VARIANT_BOOL;
public import windows.win32.system.com.com : IDispatch, IUnknown, SAFEARRAY;
public import windows.win32.system.variant : VARIANT;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ne-mi-mi_result
alias MI_Result = int;
enum : int
{
    MI_RESULT_OK                                  = 0x00000000,
    MI_RESULT_FAILED                              = 0x00000001,
    MI_RESULT_ACCESS_DENIED                       = 0x00000002,
    MI_RESULT_INVALID_NAMESPACE                   = 0x00000003,
    MI_RESULT_INVALID_PARAMETER                   = 0x00000004,
    MI_RESULT_INVALID_CLASS                       = 0x00000005,
    MI_RESULT_NOT_FOUND                           = 0x00000006,
    MI_RESULT_NOT_SUPPORTED                       = 0x00000007,
    MI_RESULT_CLASS_HAS_CHILDREN                  = 0x00000008,
    MI_RESULT_CLASS_HAS_INSTANCES                 = 0x00000009,
    MI_RESULT_INVALID_SUPERCLASS                  = 0x0000000a,
    MI_RESULT_ALREADY_EXISTS                      = 0x0000000b,
    MI_RESULT_NO_SUCH_PROPERTY                    = 0x0000000c,
    MI_RESULT_TYPE_MISMATCH                       = 0x0000000d,
    MI_RESULT_QUERY_LANGUAGE_NOT_SUPPORTED        = 0x0000000e,
    MI_RESULT_INVALID_QUERY                       = 0x0000000f,
    MI_RESULT_METHOD_NOT_AVAILABLE                = 0x00000010,
    MI_RESULT_METHOD_NOT_FOUND                    = 0x00000011,
    MI_RESULT_NAMESPACE_NOT_EMPTY                 = 0x00000014,
    MI_RESULT_INVALID_ENUMERATION_CONTEXT         = 0x00000015,
    MI_RESULT_INVALID_OPERATION_TIMEOUT           = 0x00000016,
    MI_RESULT_PULL_HAS_BEEN_ABANDONED             = 0x00000017,
    MI_RESULT_PULL_CANNOT_BE_ABANDONED            = 0x00000018,
    MI_RESULT_FILTERED_ENUMERATION_NOT_SUPPORTED  = 0x00000019,
    MI_RESULT_CONTINUATION_ON_ERROR_NOT_SUPPORTED = 0x0000001a,
    MI_RESULT_SERVER_LIMITS_EXCEEDED              = 0x0000001b,
    MI_RESULT_SERVER_IS_SHUTTING_DOWN             = 0x0000001c,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ne-mi-mi_errorcategory
alias MI_ErrorCategory = int;
enum : int
{
    MI_ERRORCATEGORY_NOT_SPECIFIED        = 0x00000000,
    MI_ERRORCATEGORY_OPEN_ERROR           = 0x00000001,
    MI_ERRORCATEGORY_CLOS_EERROR          = 0x00000002,
    MI_ERRORCATEGORY_DEVICE_ERROR         = 0x00000003,
    MI_ERRORCATEGORY_DEADLOCK_DETECTED    = 0x00000004,
    MI_ERRORCATEGORY_INVALID_ARGUMENT     = 0x00000005,
    MI_ERRORCATEGORY_INVALID_DATA         = 0x00000006,
    MI_ERRORCATEGORY_INVALID_OPERATION    = 0x00000007,
    MI_ERRORCATEGORY_INVALID_RESULT       = 0x00000008,
    MI_ERRORCATEGORY_INVALID_TYPE         = 0x00000009,
    MI_ERRORCATEGORY_METADATA_ERROR       = 0x0000000a,
    MI_ERRORCATEGORY_NOT_IMPLEMENTED      = 0x0000000b,
    MI_ERRORCATEGORY_NOT_INSTALLED        = 0x0000000c,
    MI_ERRORCATEGORY_OBJECT_NOT_FOUND     = 0x0000000d,
    MI_ERRORCATEGORY_OPERATION_STOPPED    = 0x0000000e,
    MI_ERRORCATEGORY_OPERATION_TIMEOUT    = 0x0000000f,
    MI_ERRORCATEGORY_SYNTAX_ERROR         = 0x00000010,
    MI_ERRORCATEGORY_PARSER_ERROR         = 0x00000011,
    MI_ERRORCATEGORY_ACCESS_DENIED        = 0x00000012,
    MI_ERRORCATEGORY_RESOURCE_BUSY        = 0x00000013,
    MI_ERRORCATEGORY_RESOURCE_EXISTS      = 0x00000014,
    MI_ERRORCATEGORY_RESOURCE_UNAVAILABLE = 0x00000015,
    MI_ERRORCATEGORY_READ_ERROR           = 0x00000016,
    MI_ERRORCATEGORY_WRITE_ERROR          = 0x00000017,
    MI_ERRORCATEGORY_FROM_STDERR          = 0x00000018,
    MI_ERRORCATEGORY_SECURITY_ERROR       = 0x00000019,
    MI_ERRORCATEGORY_PROTOCOL_ERROR       = 0x0000001a,
    MI_ERRORCATEGORY_CONNECTION_ERROR     = 0x0000001b,
    MI_ERRORCATEGORY_AUTHENTICATION_ERROR = 0x0000001c,
    MI_ERRORCATEGORY_LIMITS_EXCEEDED      = 0x0000001d,
    MI_ERRORCATEGORY_QUOTA_EXCEEDED       = 0x0000001e,
    MI_ERRORCATEGORY_NOT_ENABLED          = 0x0000001f,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ne-mi-mi_prompttype
alias MI_PromptType = int;
enum : int
{
    MI_PROMPTTYPE_NORMAL   = 0x00000000,
    MI_PROMPTTYPE_CRITICAL = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ne-mi-mi_callbackmode
alias MI_CallbackMode = int;
enum : int
{
    MI_CALLBACKMODE_REPORT  = 0x00000000,
    MI_CALLBACKMODE_INQUIRE = 0x00000001,
    MI_CALLBACKMODE_IGNORE  = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ne-mi-mi_providerarchitecture
alias MI_ProviderArchitecture = int;
enum : int
{
    MI_PROVIDER_ARCHITECTURE_32BIT = 0x00000000,
    MI_PROVIDER_ARCHITECTURE_64BIT = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ne-mi-mi_type
alias MI_Type = int;
enum : int
{
    MI_BOOLEAN    = 0x00000000,
    MI_UINT8      = 0x00000001,
    MI_SINT8      = 0x00000002,
    MI_UINT16     = 0x00000003,
    MI_SINT16     = 0x00000004,
    MI_UINT32     = 0x00000005,
    MI_SINT32     = 0x00000006,
    MI_UINT64     = 0x00000007,
    MI_SINT64     = 0x00000008,
    MI_REAL32     = 0x00000009,
    MI_REAL64     = 0x0000000a,
    MI_CHAR16     = 0x0000000b,
    MI_DATETIME   = 0x0000000c,
    MI_STRING     = 0x0000000d,
    MI_REFERENCE  = 0x0000000e,
    MI_INSTANCE   = 0x0000000f,
    MI_BOOLEANA   = 0x00000010,
    MI_UINT8A     = 0x00000011,
    MI_SINT8A     = 0x00000012,
    MI_UINT16A    = 0x00000013,
    MI_SINT16A    = 0x00000014,
    MI_UINT32A    = 0x00000015,
    MI_SINT32A    = 0x00000016,
    MI_UINT64A    = 0x00000017,
    MI_SINT64A    = 0x00000018,
    MI_REAL32A    = 0x00000019,
    MI_REAL64A    = 0x0000001a,
    MI_CHAR16A    = 0x0000001b,
    MI_DATETIMEA  = 0x0000001c,
    MI_STRINGA    = 0x0000001d,
    MI_REFERENCEA = 0x0000001e,
    MI_INSTANCEA  = 0x0000001f,
    MI_ARRAY      = 0x00000010,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ne-mi-mi_localetype
alias MI_LocaleType = int;
enum : int
{
    MI_LOCALE_TYPE_REQUESTED_UI   = 0x00000000,
    MI_LOCALE_TYPE_REQUESTED_DATA = 0x00000001,
    MI_LOCALE_TYPE_CLOSEST_UI     = 0x00000002,
    MI_LOCALE_TYPE_CLOSEST_DATA   = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ne-mi-mi_cancellationreason
alias MI_CancellationReason = int;
enum : int
{
    MI_REASON_NONE        = 0x00000000,
    MI_REASON_TIMEOUT     = 0x00000001,
    MI_REASON_SHUTDOWN    = 0x00000002,
    MI_REASON_SERVICESTOP = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ne-mi-mi_operationcallback_responsetype
alias MI_OperationCallback_ResponseType = int;
enum : int
{
    MI_OperationCallback_ResponseType_No       = 0x00000000,
    MI_OperationCallback_ResponseType_Yes      = 0x00000001,
    MI_OperationCallback_ResponseType_NoToAll  = 0x00000002,
    MI_OperationCallback_ResponseType_YesToAll = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ne-mi-mi_subscriptiondeliverytype
alias MI_SubscriptionDeliveryType = int;
enum : int
{
    MI_SubscriptionDeliveryType_Pull = 0x00000001,
    MI_SubscriptionDeliveryType_Push = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ne-mi-mi_destinationoptions_impersonationtype
alias MI_DestinationOptions_ImpersonationType = int;
enum : int
{
    MI_DestinationOptions_ImpersonationType_Default     = 0x00000000,
    MI_DestinationOptions_ImpersonationType_None        = 0x00000001,
    MI_DestinationOptions_ImpersonationType_Identify    = 0x00000002,
    MI_DestinationOptions_ImpersonationType_Impersonate = 0x00000003,
    MI_DestinationOptions_ImpersonationType_Delegate    = 0x00000004,
}

alias WBEM_PATH_STATUS_FLAG = int;
enum : int
{
    WBEMPATH_INFO_ANON_LOCAL_MACHINE    = 0x00000001,
    WBEMPATH_INFO_HAS_MACHINE_NAME      = 0x00000002,
    WBEMPATH_INFO_IS_CLASS_REF          = 0x00000004,
    WBEMPATH_INFO_IS_INST_REF           = 0x00000008,
    WBEMPATH_INFO_HAS_SUBSCOPES         = 0x00000010,
    WBEMPATH_INFO_IS_COMPOUND           = 0x00000020,
    WBEMPATH_INFO_HAS_V2_REF_PATHS      = 0x00000040,
    WBEMPATH_INFO_HAS_IMPLIED_KEY       = 0x00000080,
    WBEMPATH_INFO_CONTAINS_SINGLETON    = 0x00000100,
    WBEMPATH_INFO_V1_COMPLIANT          = 0x00000200,
    WBEMPATH_INFO_V2_COMPLIANT          = 0x00000400,
    WBEMPATH_INFO_CIM_COMPLIANT         = 0x00000800,
    WBEMPATH_INFO_IS_SINGLETON          = 0x00001000,
    WBEMPATH_INFO_IS_PARENT             = 0x00002000,
    WBEMPATH_INFO_SERVER_NAMESPACE_ONLY = 0x00004000,
    WBEMPATH_INFO_NATIVE_PATH           = 0x00008000,
    WBEMPATH_INFO_WMI_PATH              = 0x00010000,
    WBEMPATH_INFO_PATH_HAD_SERVER       = 0x00020000,
}

alias WBEM_PATH_CREATE_FLAG = int;
enum : int
{
    WBEMPATH_CREATE_ACCEPT_RELATIVE   = 0x00000001,
    WBEMPATH_CREATE_ACCEPT_ABSOLUTE   = 0x00000002,
    WBEMPATH_CREATE_ACCEPT_ALL        = 0x00000004,
    WBEMPATH_TREAT_SINGLE_IDENT_AS_NS = 0x00000008,
}

alias WBEM_GET_TEXT_FLAGS = int;
enum : int
{
    WBEMPATH_COMPRESSED                    = 0x00000001,
    WBEMPATH_GET_RELATIVE_ONLY             = 0x00000002,
    WBEMPATH_GET_SERVER_TOO                = 0x00000004,
    WBEMPATH_GET_SERVER_AND_NAMESPACE_ONLY = 0x00000008,
    WBEMPATH_GET_NAMESPACE_ONLY            = 0x00000010,
    WBEMPATH_GET_ORIGINAL                  = 0x00000020,
}

alias WBEM_GET_KEY_FLAGS = int;
enum : int
{
    WBEMPATH_TEXT       = 0x00000001,
    WBEMPATH_QUOTEDTEXT = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/ne-wmiutils-wmiq_analysis_type
alias WMIQ_ANALYSIS_TYPE = int;
enum : int
{
    WMIQ_ANALYSIS_RPN_SEQUENCE         = 0x00000001,
    WMIQ_ANALYSIS_ASSOC_QUERY          = 0x00000002,
    WMIQ_ANALYSIS_PROP_ANALYSIS_MATRIX = 0x00000003,
    WMIQ_ANALYSIS_QUERY_TEXT           = 0x00000004,
    WMIQ_ANALYSIS_RESERVED             = 0x08000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/ne-wmiutils-wmiq_rpn_token_flags
alias WMIQ_RPN_TOKEN_FLAGS = int;
enum : int
{
    WMIQ_RPN_TOKEN_EXPRESSION    = 0x00000001,
    WMIQ_RPN_TOKEN_AND           = 0x00000002,
    WMIQ_RPN_TOKEN_OR            = 0x00000003,
    WMIQ_RPN_TOKEN_NOT           = 0x00000004,
    WMIQ_RPN_OP_UNDEFINED        = 0x00000000,
    WMIQ_RPN_OP_EQ               = 0x00000001,
    WMIQ_RPN_OP_NE               = 0x00000002,
    WMIQ_RPN_OP_GE               = 0x00000003,
    WMIQ_RPN_OP_LE               = 0x00000004,
    WMIQ_RPN_OP_LT               = 0x00000005,
    WMIQ_RPN_OP_GT               = 0x00000006,
    WMIQ_RPN_OP_LIKE             = 0x00000007,
    WMIQ_RPN_OP_ISA              = 0x00000008,
    WMIQ_RPN_OP_ISNOTA           = 0x00000009,
    WMIQ_RPN_OP_ISNULL           = 0x0000000a,
    WMIQ_RPN_OP_ISNOTNULL        = 0x0000000b,
    WMIQ_RPN_LEFT_PROPERTY_NAME  = 0x00000001,
    WMIQ_RPN_RIGHT_PROPERTY_NAME = 0x00000002,
    WMIQ_RPN_CONST2              = 0x00000004,
    WMIQ_RPN_CONST               = 0x00000008,
    WMIQ_RPN_RELOP               = 0x00000010,
    WMIQ_RPN_LEFT_FUNCTION       = 0x00000020,
    WMIQ_RPN_RIGHT_FUNCTION      = 0x00000040,
    WMIQ_RPN_GET_TOKEN_TYPE      = 0x00000001,
    WMIQ_RPN_GET_EXPR_SHAPE      = 0x00000002,
    WMIQ_RPN_GET_LEFT_FUNCTION   = 0x00000003,
    WMIQ_RPN_GET_RIGHT_FUNCTION  = 0x00000004,
    WMIQ_RPN_GET_RELOP           = 0x00000005,
    WMIQ_RPN_NEXT_TOKEN          = 0x00000001,
    WMIQ_RPN_FROM_UNARY          = 0x00000001,
    WMIQ_RPN_FROM_PATH           = 0x00000002,
    WMIQ_RPN_FROM_CLASS_LIST     = 0x00000004,
    WMIQ_RPN_FROM_MULTIPLE       = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/ne-wmiutils-wmiq_assocq_flags
alias WMIQ_ASSOCQ_FLAGS = int;
enum : int
{
    WMIQ_ASSOCQ_ASSOCIATORS            = 0x00000001,
    WMIQ_ASSOCQ_REFERENCES             = 0x00000002,
    WMIQ_ASSOCQ_RESULTCLASS            = 0x00000004,
    WMIQ_ASSOCQ_ASSOCCLASS             = 0x00000008,
    WMIQ_ASSOCQ_ROLE                   = 0x00000010,
    WMIQ_ASSOCQ_RESULTROLE             = 0x00000020,
    WMIQ_ASSOCQ_REQUIREDQUALIFIER      = 0x00000040,
    WMIQ_ASSOCQ_REQUIREDASSOCQUALIFIER = 0x00000080,
    WMIQ_ASSOCQ_CLASSDEFSONLY          = 0x00000100,
    WMIQ_ASSOCQ_KEYSONLY               = 0x00000200,
    WMIQ_ASSOCQ_SCHEMAONLY             = 0x00000400,
    WMIQ_ASSOCQ_CLASSREFSONLY          = 0x00000800,
}

alias WMIQ_LANGUAGE_FEATURES = int;
enum : int
{
    WMIQ_LF1_BASIC_SELECT                = 0x00000001,
    WMIQ_LF2_CLASS_NAME_IN_QUERY         = 0x00000002,
    WMIQ_LF3_STRING_CASE_FUNCTIONS       = 0x00000003,
    WMIQ_LF4_PROP_TO_PROP_TESTS          = 0x00000004,
    WMIQ_LF5_COUNT_STAR                  = 0x00000005,
    WMIQ_LF6_ORDER_BY                    = 0x00000006,
    WMIQ_LF7_DISTINCT                    = 0x00000007,
    WMIQ_LF8_ISA                         = 0x00000008,
    WMIQ_LF9_THIS                        = 0x00000009,
    WMIQ_LF10_COMPEX_SUBEXPRESSIONS      = 0x0000000a,
    WMIQ_LF11_ALIASING                   = 0x0000000b,
    WMIQ_LF12_GROUP_BY_HAVING            = 0x0000000c,
    WMIQ_LF13_WMI_WITHIN                 = 0x0000000d,
    WMIQ_LF14_SQL_WRITE_OPERATIONS       = 0x0000000e,
    WMIQ_LF15_GO                         = 0x0000000f,
    WMIQ_LF16_SINGLE_LEVEL_TRANSACTIONS  = 0x00000010,
    WMIQ_LF17_QUALIFIED_NAMES            = 0x00000011,
    WMIQ_LF18_ASSOCIATONS                = 0x00000012,
    WMIQ_LF19_SYSTEM_PROPERTIES          = 0x00000013,
    WMIQ_LF20_EXTENDED_SYSTEM_PROPERTIES = 0x00000014,
    WMIQ_LF21_SQL89_JOINS                = 0x00000015,
    WMIQ_LF22_SQL92_JOINS                = 0x00000016,
    WMIQ_LF23_SUBSELECTS                 = 0x00000017,
    WMIQ_LF24_UMI_EXTENSIONS             = 0x00000018,
    WMIQ_LF25_DATEPART                   = 0x00000019,
    WMIQ_LF26_LIKE                       = 0x0000001a,
    WMIQ_LF27_CIM_TEMPORAL_CONSTRUCTS    = 0x0000001b,
    WMIQ_LF28_STANDARD_AGGREGATES        = 0x0000001c,
    WMIQ_LF29_MULTI_LEVEL_ORDER_BY       = 0x0000001d,
    WMIQ_LF30_WMI_PRAGMAS                = 0x0000001e,
    WMIQ_LF31_QUALIFIER_TESTS            = 0x0000001f,
    WMIQ_LF32_SP_EXECUTE                 = 0x00000020,
    WMIQ_LF33_ARRAY_ACCESS               = 0x00000021,
    WMIQ_LF34_UNION                      = 0x00000022,
    WMIQ_LF35_COMPLEX_SELECT_TARGET      = 0x00000023,
    WMIQ_LF36_REFERENCE_TESTS            = 0x00000024,
    WMIQ_LF37_SELECT_INTO                = 0x00000025,
    WMIQ_LF38_BASIC_DATETIME_TESTS       = 0x00000026,
    WMIQ_LF39_COUNT_COLUMN               = 0x00000027,
    WMIQ_LF40_BETWEEN                    = 0x00000028,
    WMIQ_LF_LAST                         = 0x00000028,
}

alias WMIQ_RPNF_FEATURE = int;
enum : int
{
    WMIQ_RPNF_WHERE_CLAUSE_PRESENT = 0x00000001,
    WMIQ_RPNF_QUERY_IS_CONJUNCTIVE = 0x00000002,
    WMIQ_RPNF_QUERY_IS_DISJUNCTIVE = 0x00000004,
    WMIQ_RPNF_PROJECTION           = 0x00000008,
    WMIQ_RPNF_FEATURE_SELECT_STAR  = 0x00000010,
    WMIQ_RPNF_EQUALITY_TESTS_ONLY  = 0x00000020,
    WMIQ_RPNF_COUNT_STAR           = 0x00000040,
    WMIQ_RPNF_QUALIFIED_NAMES_USED = 0x00000080,
    WMIQ_RPNF_SYSPROP_CLASS_USED   = 0x00000100,
    WMIQ_RPNF_PROP_TO_PROP_TESTS   = 0x00000200,
    WMIQ_RPNF_ORDER_BY             = 0x00000400,
    WMIQ_RPNF_ISA_USED             = 0x00000800,
    WMIQ_RPNF_GROUP_BY_HAVING      = 0x00001000,
    WMIQ_RPNF_ARRAY_ACCESS_USED    = 0x00002000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/ne-wbemcli-wbem_genus_type
alias WBEM_GENUS_TYPE = int;
enum : int
{
    WBEM_GENUS_CLASS    = 0x00000001,
    WBEM_GENUS_INSTANCE = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/ne-wbemcli-wbem_change_flag_type
alias WBEM_CHANGE_FLAG_TYPE = int;
enum : int
{
    WBEM_FLAG_CREATE_OR_UPDATE  = 0x00000000,
    WBEM_FLAG_UPDATE_ONLY       = 0x00000001,
    WBEM_FLAG_CREATE_ONLY       = 0x00000002,
    WBEM_FLAG_UPDATE_COMPATIBLE = 0x00000000,
    WBEM_FLAG_UPDATE_SAFE_MODE  = 0x00000020,
    WBEM_FLAG_UPDATE_FORCE_MODE = 0x00000040,
    WBEM_MASK_UPDATE_MODE       = 0x00000060,
    WBEM_FLAG_ADVISORY          = 0x00010000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/ne-wbemcli-wbem_generic_flag_type
alias WBEM_GENERIC_FLAG_TYPE = int;
enum : int
{
    WBEM_FLAG_RETURN_IMMEDIATELY     = 0x00000010,
    WBEM_FLAG_RETURN_WBEM_COMPLETE   = 0x00000000,
    WBEM_FLAG_BIDIRECTIONAL          = 0x00000000,
    WBEM_FLAG_FORWARD_ONLY           = 0x00000020,
    WBEM_FLAG_NO_ERROR_OBJECT        = 0x00000040,
    WBEM_FLAG_RETURN_ERROR_OBJECT    = 0x00000000,
    WBEM_FLAG_SEND_STATUS            = 0x00000080,
    WBEM_FLAG_DONT_SEND_STATUS       = 0x00000000,
    WBEM_FLAG_ENSURE_LOCATABLE       = 0x00000100,
    WBEM_FLAG_DIRECT_READ            = 0x00000200,
    WBEM_FLAG_SEND_ONLY_SELECTED     = 0x00000000,
    WBEM_RETURN_WHEN_COMPLETE        = 0x00000000,
    WBEM_RETURN_IMMEDIATELY          = 0x00000010,
    WBEM_MASK_RESERVED_FLAGS         = 0x0001f000,
    WBEM_FLAG_USE_AMENDED_QUALIFIERS = 0x00020000,
    WBEM_FLAG_STRONG_VALIDATION      = 0x00100000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/ne-wbemcli-wbem_status_type
alias WBEM_STATUS_TYPE = int;
enum : int
{
    WBEM_STATUS_COMPLETE                       = 0x00000000,
    WBEM_STATUS_REQUIREMENTS                   = 0x00000001,
    WBEM_STATUS_PROGRESS                       = 0x00000002,
    WBEM_STATUS_LOGGING_INFORMATION            = 0x00000100,
    WBEM_STATUS_LOGGING_INFORMATION_PROVIDER   = 0x00000200,
    WBEM_STATUS_LOGGING_INFORMATION_HOST       = 0x00000400,
    WBEM_STATUS_LOGGING_INFORMATION_REPOSITORY = 0x00000800,
    WBEM_STATUS_LOGGING_INFORMATION_ESS        = 0x00001000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/ne-wbemcli-wbem_condition_flag_type
alias WBEM_CONDITION_FLAG_TYPE = int;
enum : int
{
    WBEM_FLAG_ALWAYS                    = 0x00000000,
    WBEM_FLAG_ONLY_IF_TRUE              = 0x00000001,
    WBEM_FLAG_ONLY_IF_FALSE             = 0x00000002,
    WBEM_FLAG_ONLY_IF_IDENTICAL         = 0x00000003,
    WBEM_MASK_PRIMARY_CONDITION         = 0x00000003,
    WBEM_FLAG_KEYS_ONLY                 = 0x00000004,
    WBEM_FLAG_REFS_ONLY                 = 0x00000008,
    WBEM_FLAG_LOCAL_ONLY                = 0x00000010,
    WBEM_FLAG_PROPAGATED_ONLY           = 0x00000020,
    WBEM_FLAG_SYSTEM_ONLY               = 0x00000030,
    WBEM_FLAG_NONSYSTEM_ONLY            = 0x00000040,
    WBEM_MASK_CONDITION_ORIGIN          = 0x00000070,
    WBEM_FLAG_CLASS_OVERRIDES_ONLY      = 0x00000100,
    WBEM_FLAG_CLASS_LOCAL_AND_OVERRIDES = 0x00000200,
    WBEM_MASK_CLASS_CONDITION           = 0x00000300,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/ne-wbemcli-wbem_flavor_type
alias WBEM_FLAVOR_TYPE = int;
enum : int
{
    WBEM_FLAVOR_DONT_PROPAGATE                  = 0x00000000,
    WBEM_FLAVOR_FLAG_PROPAGATE_TO_INSTANCE      = 0x00000001,
    WBEM_FLAVOR_FLAG_PROPAGATE_TO_DERIVED_CLASS = 0x00000002,
    WBEM_FLAVOR_MASK_PROPAGATION                = 0x0000000f,
    WBEM_FLAVOR_OVERRIDABLE                     = 0x00000000,
    WBEM_FLAVOR_NOT_OVERRIDABLE                 = 0x00000010,
    WBEM_FLAVOR_MASK_PERMISSIONS                = 0x00000010,
    WBEM_FLAVOR_ORIGIN_LOCAL                    = 0x00000000,
    WBEM_FLAVOR_ORIGIN_PROPAGATED               = 0x00000020,
    WBEM_FLAVOR_ORIGIN_SYSTEM                   = 0x00000040,
    WBEM_FLAVOR_MASK_ORIGIN                     = 0x00000060,
    WBEM_FLAVOR_NOT_AMENDED                     = 0x00000000,
    WBEM_FLAVOR_AMENDED                         = 0x00000080,
    WBEM_FLAVOR_MASK_AMENDED                    = 0x00000080,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/ne-wbemcli-wbem_query_flag_type
alias WBEM_QUERY_FLAG_TYPE = int;
enum : int
{
    WBEM_FLAG_DEEP      = 0x00000000,
    WBEM_FLAG_SHALLOW   = 0x00000001,
    WBEM_FLAG_PROTOTYPE = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/ne-wbemcli-wbem_security_flags
alias WBEM_SECURITY_FLAGS = int;
enum : int
{
    WBEM_ENABLE            = 0x00000001,
    WBEM_METHOD_EXECUTE    = 0x00000002,
    WBEM_FULL_WRITE_REP    = 0x00000004,
    WBEM_PARTIAL_WRITE_REP = 0x00000008,
    WBEM_WRITE_PROVIDER    = 0x00000010,
    WBEM_REMOTE_ACCESS     = 0x00000020,
    WBEM_RIGHT_SUBSCRIBE   = 0x00000040,
    WBEM_RIGHT_PUBLISH     = 0x00000080,
}

alias WBEM_LIMITATION_FLAG_TYPE = int;
enum : int
{
    WBEM_FLAG_EXCLUDE_OBJECT_QUALIFIERS   = 0x00000010,
    WBEM_FLAG_EXCLUDE_PROPERTY_QUALIFIERS = 0x00000020,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/ne-wbemcli-wbem_text_flag_type
alias WBEM_TEXT_FLAG_TYPE = int;
enum : int
{
    WBEM_FLAG_NO_FLAVORS = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/ne-wbemcli-wbem_comparison_flag
alias WBEM_COMPARISON_FLAG = int;
enum : int
{
    WBEM_COMPARISON_INCLUDE_ALL     = 0x00000000,
    WBEM_FLAG_IGNORE_QUALIFIERS     = 0x00000001,
    WBEM_FLAG_IGNORE_OBJECT_SOURCE  = 0x00000002,
    WBEM_FLAG_IGNORE_DEFAULT_VALUES = 0x00000004,
    WBEM_FLAG_IGNORE_CLASS          = 0x00000008,
    WBEM_FLAG_IGNORE_CASE           = 0x00000010,
    WBEM_FLAG_IGNORE_FLAVOR         = 0x00000020,
}

alias WBEM_LOCKING_FLAG_TYPE = int;
enum : int
{
    WBEM_FLAG_ALLOW_READ = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/ne-wbemcli-cimtype_enumeration
alias CIMTYPE_ENUMERATION = int;
enum : int
{
    CIM_ILLEGAL    = 0x00000fff,
    CIM_EMPTY      = 0x00000000,
    CIM_SINT8      = 0x00000010,
    CIM_UINT8      = 0x00000011,
    CIM_SINT16     = 0x00000002,
    CIM_UINT16     = 0x00000012,
    CIM_SINT32     = 0x00000003,
    CIM_UINT32     = 0x00000013,
    CIM_SINT64     = 0x00000014,
    CIM_UINT64     = 0x00000015,
    CIM_REAL32     = 0x00000004,
    CIM_REAL64     = 0x00000005,
    CIM_BOOLEAN    = 0x0000000b,
    CIM_STRING     = 0x00000008,
    CIM_DATETIME   = 0x00000065,
    CIM_REFERENCE  = 0x00000066,
    CIM_CHAR16     = 0x00000067,
    CIM_OBJECT     = 0x0000000d,
    CIM_FLAG_ARRAY = 0x00002000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/ne-wbemcli-wbem_backup_restore_flags
alias WBEM_BACKUP_RESTORE_FLAGS = int;
enum : int
{
    WBEM_FLAG_BACKUP_RESTORE_DEFAULT        = 0x00000000,
    WBEM_FLAG_BACKUP_RESTORE_FORCE_SHUTDOWN = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/ne-wbemcli-wbem_refresher_flags
alias WBEM_REFRESHER_FLAGS = int;
enum : int
{
    WBEM_FLAG_REFRESH_AUTO_RECONNECT    = 0x00000000,
    WBEM_FLAG_REFRESH_NO_AUTO_RECONNECT = 0x00000001,
}

alias WBEM_SHUTDOWN_FLAGS = int;
enum : int
{
    WBEM_SHUTDOWN_UNLOAD_COMPONENT = 0x00000001,
    WBEM_SHUTDOWN_WMI              = 0x00000002,
    WBEM_SHUTDOWN_OS               = 0x00000003,
}

alias WBEMSTATUS_FORMAT = int;
enum : int
{
    WBEMSTATUS_FORMAT_NEWLINE    = 0x00000000,
    WBEMSTATUS_FORMAT_NO_NEWLINE = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/ne-wbemcli-wbem_limits
alias WBEM_LIMITS = int;
enum : int
{
    WBEM_MAX_IDENTIFIER      = 0x00001000,
    WBEM_MAX_QUERY           = 0x00004000,
    WBEM_MAX_PATH            = 0x00002000,
    WBEM_MAX_OBJECT_NESTING  = 0x00000040,
    WBEM_MAX_USER_PROPERTIES = 0x00000400,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/ne-wbemcli-wbemstatus
alias WBEMSTATUS = int;
enum : int
{
    WBEM_NO_ERROR                             = 0x00000000,
    WBEM_S_NO_ERROR                           = 0x00000000,
    WBEM_S_SAME                               = 0x00000000,
    WBEM_S_FALSE                              = 0x00000001,
    WBEM_S_ALREADY_EXISTS                     = 0x00040001,
    WBEM_S_RESET_TO_DEFAULT                   = 0x00040002,
    WBEM_S_DIFFERENT                          = 0x00040003,
    WBEM_S_TIMEDOUT                           = 0x00040004,
    WBEM_S_NO_MORE_DATA                       = 0x00040005,
    WBEM_S_OPERATION_CANCELLED                = 0x00040006,
    WBEM_S_PENDING                            = 0x00040007,
    WBEM_S_DUPLICATE_OBJECTS                  = 0x00040008,
    WBEM_S_ACCESS_DENIED                      = 0x00040009,
    WBEM_S_PARTIAL_RESULTS                    = 0x00040010,
    WBEM_S_SOURCE_NOT_AVAILABLE               = 0x00040017,
    WBEM_E_FAILED                             = 0x80041001,
    WBEM_E_NOT_FOUND                          = 0x80041002,
    WBEM_E_ACCESS_DENIED                      = 0x80041003,
    WBEM_E_PROVIDER_FAILURE                   = 0x80041004,
    WBEM_E_TYPE_MISMATCH                      = 0x80041005,
    WBEM_E_OUT_OF_MEMORY                      = 0x80041006,
    WBEM_E_INVALID_CONTEXT                    = 0x80041007,
    WBEM_E_INVALID_PARAMETER                  = 0x80041008,
    WBEM_E_NOT_AVAILABLE                      = 0x80041009,
    WBEM_E_CRITICAL_ERROR                     = 0x8004100a,
    WBEM_E_INVALID_STREAM                     = 0x8004100b,
    WBEM_E_NOT_SUPPORTED                      = 0x8004100c,
    WBEM_E_INVALID_SUPERCLASS                 = 0x8004100d,
    WBEM_E_INVALID_NAMESPACE                  = 0x8004100e,
    WBEM_E_INVALID_OBJECT                     = 0x8004100f,
    WBEM_E_INVALID_CLASS                      = 0x80041010,
    WBEM_E_PROVIDER_NOT_FOUND                 = 0x80041011,
    WBEM_E_INVALID_PROVIDER_REGISTRATION      = 0x80041012,
    WBEM_E_PROVIDER_LOAD_FAILURE              = 0x80041013,
    WBEM_E_INITIALIZATION_FAILURE             = 0x80041014,
    WBEM_E_TRANSPORT_FAILURE                  = 0x80041015,
    WBEM_E_INVALID_OPERATION                  = 0x80041016,
    WBEM_E_INVALID_QUERY                      = 0x80041017,
    WBEM_E_INVALID_QUERY_TYPE                 = 0x80041018,
    WBEM_E_ALREADY_EXISTS                     = 0x80041019,
    WBEM_E_OVERRIDE_NOT_ALLOWED               = 0x8004101a,
    WBEM_E_PROPAGATED_QUALIFIER               = 0x8004101b,
    WBEM_E_PROPAGATED_PROPERTY                = 0x8004101c,
    WBEM_E_UNEXPECTED                         = 0x8004101d,
    WBEM_E_ILLEGAL_OPERATION                  = 0x8004101e,
    WBEM_E_CANNOT_BE_KEY                      = 0x8004101f,
    WBEM_E_INCOMPLETE_CLASS                   = 0x80041020,
    WBEM_E_INVALID_SYNTAX                     = 0x80041021,
    WBEM_E_NONDECORATED_OBJECT                = 0x80041022,
    WBEM_E_READ_ONLY                          = 0x80041023,
    WBEM_E_PROVIDER_NOT_CAPABLE               = 0x80041024,
    WBEM_E_CLASS_HAS_CHILDREN                 = 0x80041025,
    WBEM_E_CLASS_HAS_INSTANCES                = 0x80041026,
    WBEM_E_QUERY_NOT_IMPLEMENTED              = 0x80041027,
    WBEM_E_ILLEGAL_NULL                       = 0x80041028,
    WBEM_E_INVALID_QUALIFIER_TYPE             = 0x80041029,
    WBEM_E_INVALID_PROPERTY_TYPE              = 0x8004102a,
    WBEM_E_VALUE_OUT_OF_RANGE                 = 0x8004102b,
    WBEM_E_CANNOT_BE_SINGLETON                = 0x8004102c,
    WBEM_E_INVALID_CIM_TYPE                   = 0x8004102d,
    WBEM_E_INVALID_METHOD                     = 0x8004102e,
    WBEM_E_INVALID_METHOD_PARAMETERS          = 0x8004102f,
    WBEM_E_SYSTEM_PROPERTY                    = 0x80041030,
    WBEM_E_INVALID_PROPERTY                   = 0x80041031,
    WBEM_E_CALL_CANCELLED                     = 0x80041032,
    WBEM_E_SHUTTING_DOWN                      = 0x80041033,
    WBEM_E_PROPAGATED_METHOD                  = 0x80041034,
    WBEM_E_UNSUPPORTED_PARAMETER              = 0x80041035,
    WBEM_E_MISSING_PARAMETER_ID               = 0x80041036,
    WBEM_E_INVALID_PARAMETER_ID               = 0x80041037,
    WBEM_E_NONCONSECUTIVE_PARAMETER_IDS       = 0x80041038,
    WBEM_E_PARAMETER_ID_ON_RETVAL             = 0x80041039,
    WBEM_E_INVALID_OBJECT_PATH                = 0x8004103a,
    WBEM_E_OUT_OF_DISK_SPACE                  = 0x8004103b,
    WBEM_E_BUFFER_TOO_SMALL                   = 0x8004103c,
    WBEM_E_UNSUPPORTED_PUT_EXTENSION          = 0x8004103d,
    WBEM_E_UNKNOWN_OBJECT_TYPE                = 0x8004103e,
    WBEM_E_UNKNOWN_PACKET_TYPE                = 0x8004103f,
    WBEM_E_MARSHAL_VERSION_MISMATCH           = 0x80041040,
    WBEM_E_MARSHAL_INVALID_SIGNATURE          = 0x80041041,
    WBEM_E_INVALID_QUALIFIER                  = 0x80041042,
    WBEM_E_INVALID_DUPLICATE_PARAMETER        = 0x80041043,
    WBEM_E_TOO_MUCH_DATA                      = 0x80041044,
    WBEM_E_SERVER_TOO_BUSY                    = 0x80041045,
    WBEM_E_INVALID_FLAVOR                     = 0x80041046,
    WBEM_E_CIRCULAR_REFERENCE                 = 0x80041047,
    WBEM_E_UNSUPPORTED_CLASS_UPDATE           = 0x80041048,
    WBEM_E_CANNOT_CHANGE_KEY_INHERITANCE      = 0x80041049,
    WBEM_E_CANNOT_CHANGE_INDEX_INHERITANCE    = 0x80041050,
    WBEM_E_TOO_MANY_PROPERTIES                = 0x80041051,
    WBEM_E_UPDATE_TYPE_MISMATCH               = 0x80041052,
    WBEM_E_UPDATE_OVERRIDE_NOT_ALLOWED        = 0x80041053,
    WBEM_E_UPDATE_PROPAGATED_METHOD           = 0x80041054,
    WBEM_E_METHOD_NOT_IMPLEMENTED             = 0x80041055,
    WBEM_E_METHOD_DISABLED                    = 0x80041056,
    WBEM_E_REFRESHER_BUSY                     = 0x80041057,
    WBEM_E_UNPARSABLE_QUERY                   = 0x80041058,
    WBEM_E_NOT_EVENT_CLASS                    = 0x80041059,
    WBEM_E_MISSING_GROUP_WITHIN               = 0x8004105a,
    WBEM_E_MISSING_AGGREGATION_LIST           = 0x8004105b,
    WBEM_E_PROPERTY_NOT_AN_OBJECT             = 0x8004105c,
    WBEM_E_AGGREGATING_BY_OBJECT              = 0x8004105d,
    WBEM_E_UNINTERPRETABLE_PROVIDER_QUERY     = 0x8004105f,
    WBEM_E_BACKUP_RESTORE_WINMGMT_RUNNING     = 0x80041060,
    WBEM_E_QUEUE_OVERFLOW                     = 0x80041061,
    WBEM_E_PRIVILEGE_NOT_HELD                 = 0x80041062,
    WBEM_E_INVALID_OPERATOR                   = 0x80041063,
    WBEM_E_LOCAL_CREDENTIALS                  = 0x80041064,
    WBEM_E_CANNOT_BE_ABSTRACT                 = 0x80041065,
    WBEM_E_AMENDED_OBJECT                     = 0x80041066,
    WBEM_E_CLIENT_TOO_SLOW                    = 0x80041067,
    WBEM_E_NULL_SECURITY_DESCRIPTOR           = 0x80041068,
    WBEM_E_TIMED_OUT                          = 0x80041069,
    WBEM_E_INVALID_ASSOCIATION                = 0x8004106a,
    WBEM_E_AMBIGUOUS_OPERATION                = 0x8004106b,
    WBEM_E_QUOTA_VIOLATION                    = 0x8004106c,
    WBEM_E_RESERVED_001                       = 0x8004106d,
    WBEM_E_RESERVED_002                       = 0x8004106e,
    WBEM_E_UNSUPPORTED_LOCALE                 = 0x8004106f,
    WBEM_E_HANDLE_OUT_OF_DATE                 = 0x80041070,
    WBEM_E_CONNECTION_FAILED                  = 0x80041071,
    WBEM_E_INVALID_HANDLE_REQUEST             = 0x80041072,
    WBEM_E_PROPERTY_NAME_TOO_WIDE             = 0x80041073,
    WBEM_E_CLASS_NAME_TOO_WIDE                = 0x80041074,
    WBEM_E_METHOD_NAME_TOO_WIDE               = 0x80041075,
    WBEM_E_QUALIFIER_NAME_TOO_WIDE            = 0x80041076,
    WBEM_E_RERUN_COMMAND                      = 0x80041077,
    WBEM_E_DATABASE_VER_MISMATCH              = 0x80041078,
    WBEM_E_VETO_DELETE                        = 0x80041079,
    WBEM_E_VETO_PUT                           = 0x8004107a,
    WBEM_E_INVALID_LOCALE                     = 0x80041080,
    WBEM_E_PROVIDER_SUSPENDED                 = 0x80041081,
    WBEM_E_SYNCHRONIZATION_REQUIRED           = 0x80041082,
    WBEM_E_NO_SCHEMA                          = 0x80041083,
    WBEM_E_PROVIDER_ALREADY_REGISTERED        = 0x80041084,
    WBEM_E_PROVIDER_NOT_REGISTERED            = 0x80041085,
    WBEM_E_FATAL_TRANSPORT_ERROR              = 0x80041086,
    WBEM_E_ENCRYPTED_CONNECTION_REQUIRED      = 0x80041087,
    WBEM_E_PROVIDER_TIMED_OUT                 = 0x80041088,
    WBEM_E_NO_KEY                             = 0x80041089,
    WBEM_E_PROVIDER_DISABLED                  = 0x8004108a,
    WBEMESS_E_REGISTRATION_TOO_BROAD          = 0x80042001,
    WBEMESS_E_REGISTRATION_TOO_PRECISE        = 0x80042002,
    WBEMESS_E_AUTHZ_NOT_PRIVILEGED            = 0x80042003,
    WBEMMOF_E_EXPECTED_QUALIFIER_NAME         = 0x80044001,
    WBEMMOF_E_EXPECTED_SEMI                   = 0x80044002,
    WBEMMOF_E_EXPECTED_OPEN_BRACE             = 0x80044003,
    WBEMMOF_E_EXPECTED_CLOSE_BRACE            = 0x80044004,
    WBEMMOF_E_EXPECTED_CLOSE_BRACKET          = 0x80044005,
    WBEMMOF_E_EXPECTED_CLOSE_PAREN            = 0x80044006,
    WBEMMOF_E_ILLEGAL_CONSTANT_VALUE          = 0x80044007,
    WBEMMOF_E_EXPECTED_TYPE_IDENTIFIER        = 0x80044008,
    WBEMMOF_E_EXPECTED_OPEN_PAREN             = 0x80044009,
    WBEMMOF_E_UNRECOGNIZED_TOKEN              = 0x8004400a,
    WBEMMOF_E_UNRECOGNIZED_TYPE               = 0x8004400b,
    WBEMMOF_E_EXPECTED_PROPERTY_NAME          = 0x8004400c,
    WBEMMOF_E_TYPEDEF_NOT_SUPPORTED           = 0x8004400d,
    WBEMMOF_E_UNEXPECTED_ALIAS                = 0x8004400e,
    WBEMMOF_E_UNEXPECTED_ARRAY_INIT           = 0x8004400f,
    WBEMMOF_E_INVALID_AMENDMENT_SYNTAX        = 0x80044010,
    WBEMMOF_E_INVALID_DUPLICATE_AMENDMENT     = 0x80044011,
    WBEMMOF_E_INVALID_PRAGMA                  = 0x80044012,
    WBEMMOF_E_INVALID_NAMESPACE_SYNTAX        = 0x80044013,
    WBEMMOF_E_EXPECTED_CLASS_NAME             = 0x80044014,
    WBEMMOF_E_TYPE_MISMATCH                   = 0x80044015,
    WBEMMOF_E_EXPECTED_ALIAS_NAME             = 0x80044016,
    WBEMMOF_E_INVALID_CLASS_DECLARATION       = 0x80044017,
    WBEMMOF_E_INVALID_INSTANCE_DECLARATION    = 0x80044018,
    WBEMMOF_E_EXPECTED_DOLLAR                 = 0x80044019,
    WBEMMOF_E_CIMTYPE_QUALIFIER               = 0x8004401a,
    WBEMMOF_E_DUPLICATE_PROPERTY              = 0x8004401b,
    WBEMMOF_E_INVALID_NAMESPACE_SPECIFICATION = 0x8004401c,
    WBEMMOF_E_OUT_OF_RANGE                    = 0x8004401d,
    WBEMMOF_E_INVALID_FILE                    = 0x8004401e,
    WBEMMOF_E_ALIASES_IN_EMBEDDED             = 0x8004401f,
    WBEMMOF_E_NULL_ARRAY_ELEM                 = 0x80044020,
    WBEMMOF_E_DUPLICATE_QUALIFIER             = 0x80044021,
    WBEMMOF_E_EXPECTED_FLAVOR_TYPE            = 0x80044022,
    WBEMMOF_E_INCOMPATIBLE_FLAVOR_TYPES       = 0x80044023,
    WBEMMOF_E_MULTIPLE_ALIASES                = 0x80044024,
    WBEMMOF_E_INCOMPATIBLE_FLAVOR_TYPES2      = 0x80044025,
    WBEMMOF_E_NO_ARRAYS_RETURNED              = 0x80044026,
    WBEMMOF_E_MUST_BE_IN_OR_OUT               = 0x80044027,
    WBEMMOF_E_INVALID_FLAGS_SYNTAX            = 0x80044028,
    WBEMMOF_E_EXPECTED_BRACE_OR_BAD_TYPE      = 0x80044029,
    WBEMMOF_E_UNSUPPORTED_CIMV22_QUAL_VALUE   = 0x8004402a,
    WBEMMOF_E_UNSUPPORTED_CIMV22_DATA_TYPE    = 0x8004402b,
    WBEMMOF_E_INVALID_DELETEINSTANCE_SYNTAX   = 0x8004402c,
    WBEMMOF_E_INVALID_QUALIFIER_SYNTAX        = 0x8004402d,
    WBEMMOF_E_QUALIFIER_USED_OUTSIDE_SCOPE    = 0x8004402e,
    WBEMMOF_E_ERROR_CREATING_TEMP_FILE        = 0x8004402f,
    WBEMMOF_E_ERROR_INVALID_INCLUDE_FILE      = 0x80044030,
    WBEMMOF_E_INVALID_DELETECLASS_SYNTAX      = 0x80044031,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/ne-wbemcli-wmi_obj_text
alias WMI_OBJ_TEXT = int;
enum : int
{
    WMI_OBJ_TEXT_CIM_DTD_2_0 = 0x00000001,
    WMI_OBJ_TEXT_WMI_DTD_2_0 = 0x00000002,
    WMI_OBJ_TEXT_WMI_EXT1    = 0x00000003,
    WMI_OBJ_TEXT_WMI_EXT2    = 0x00000004,
    WMI_OBJ_TEXT_WMI_EXT3    = 0x00000005,
    WMI_OBJ_TEXT_WMI_EXT4    = 0x00000006,
    WMI_OBJ_TEXT_WMI_EXT5    = 0x00000007,
    WMI_OBJ_TEXT_WMI_EXT6    = 0x00000008,
    WMI_OBJ_TEXT_WMI_EXT7    = 0x00000009,
    WMI_OBJ_TEXT_WMI_EXT8    = 0x0000000a,
    WMI_OBJ_TEXT_WMI_EXT9    = 0x0000000b,
    WMI_OBJ_TEXT_WMI_EXT10   = 0x0000000c,
    WMI_OBJ_TEXT_LAST        = 0x0000000d,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/ne-wbemcli-wbem_compiler_options
alias WBEM_COMPILER_OPTIONS = int;
enum : int
{
    WBEM_FLAG_CHECK_ONLY       = 0x00000001,
    WBEM_FLAG_AUTORECOVER      = 0x00000002,
    WBEM_FLAG_WMI_CHECK        = 0x00000004,
    WBEM_FLAG_CONSOLE_PRINT    = 0x00000008,
    WBEM_FLAG_DONT_ADD_TO_LIST = 0x00000010,
    WBEM_FLAG_SPLIT_FILES      = 0x00000020,
    WBEM_FLAG_STORE_FILE       = 0x00000100,
}

alias WBEM_CONNECT_OPTIONS = int;
enum : int
{
    WBEM_FLAG_CONNECT_REPOSITORY_ONLY = 0x00000040,
    WBEM_FLAG_CONNECT_USE_MAX_WAIT    = 0x00000080,
    WBEM_FLAG_CONNECT_PROVIDERS       = 0x00000100,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/ne-wbemcli-wbem_unsecapp_flag_type
alias WBEM_UNSECAPP_FLAG_TYPE = int;
enum : int
{
    WBEM_FLAG_UNSECAPP_DEFAULT_CHECK_ACCESS = 0x00000000,
    WBEM_FLAG_UNSECAPP_CHECK_ACCESS         = 0x00000001,
    WBEM_FLAG_UNSECAPP_DONT_CHECK_ACCESS    = 0x00000002,
}

alias WBEM_INFORMATION_FLAG_TYPE = int;
enum : int
{
    WBEM_FLAG_SHORT_NAME = 0x00000001,
    WBEM_FLAG_LONG_NAME  = 0x00000002,
}

alias WBEM_PROVIDER_REQUIREMENTS_TYPE = int;
enum : int
{
    WBEM_REQUIREMENTS_START_POSTFILTER      = 0x00000000,
    WBEM_REQUIREMENTS_STOP_POSTFILTER       = 0x00000001,
    WBEM_REQUIREMENTS_RECHECK_SUBSCRIPTIONS = 0x00000002,
}

alias WBEM_EXTRA_RETURN_CODES = int;
enum : int
{
    WBEM_S_INITIALIZED         = 0x00000000,
    WBEM_S_LIMITED_SERVICE     = 0x00043001,
    WBEM_S_INDIRECTLY_UPDATED  = 0x00043002,
    WBEM_S_SUBJECT_TO_SDS      = 0x00043003,
    WBEM_E_RETRY_LATER         = 0x80043001,
    WBEM_E_RESOURCE_CONTENTION = 0x80043002,
}

alias WBEM_PROVIDER_FLAGS = int;
enum : int
{
    WBEM_FLAG_OWNER_UPDATE = 0x00010000,
}

alias WBEM_BATCH_TYPE = int;
enum : int
{
    WBEM_FLAG_BATCH_IF_NEEDED = 0x00000000,
    WBEM_FLAG_MUST_BATCH      = 0x00000001,
    WBEM_FLAG_MUST_NOT_BATCH  = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemdisp/ne-wbemdisp-wbemchangeflagenum
enum WbemChangeFlagEnum : int
{
    wbemChangeFlagCreateOrUpdate   = 0x00000000,
    wbemChangeFlagUpdateOnly       = 0x00000001,
    wbemChangeFlagCreateOnly       = 0x00000002,
    wbemChangeFlagUpdateCompatible = 0x00000000,
    wbemChangeFlagUpdateSafeMode   = 0x00000020,
    wbemChangeFlagUpdateForceMode  = 0x00000040,
    wbemChangeFlagStrongValidation = 0x00000080,
    wbemChangeFlagAdvisory         = 0x00010000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemdisp/ne-wbemdisp-wbemflagenum
enum WbemFlagEnum : int
{
    wbemFlagReturnImmediately    = 0x00000010,
    wbemFlagReturnWhenComplete   = 0x00000000,
    wbemFlagBidirectional        = 0x00000000,
    wbemFlagForwardOnly          = 0x00000020,
    wbemFlagNoErrorObject        = 0x00000040,
    wbemFlagReturnErrorObject    = 0x00000000,
    wbemFlagSendStatus           = 0x00000080,
    wbemFlagDontSendStatus       = 0x00000000,
    wbemFlagEnsureLocatable      = 0x00000100,
    wbemFlagDirectRead           = 0x00000200,
    wbemFlagSendOnlySelected     = 0x00000000,
    wbemFlagUseAmendedQualifiers = 0x00020000,
    wbemFlagGetDefault           = 0x00000000,
    wbemFlagSpawnInstance        = 0x00000001,
    wbemFlagUseCurrentTime       = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemdisp/ne-wbemdisp-wbemqueryflagenum
enum WbemQueryFlagEnum : int
{
    wbemQueryFlagDeep      = 0x00000000,
    wbemQueryFlagShallow   = 0x00000001,
    wbemQueryFlagPrototype = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemdisp/ne-wbemdisp-wbemtextflagenum
enum WbemTextFlagEnum : int
{
    wbemTextFlagNoFlavors = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemdisp/ne-wbemdisp-wbemtimeout
enum WbemTimeout : int
{
    wbemTimeoutInfinite = 0xffffffff,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemdisp/ne-wbemdisp-wbemcomparisonflagenum
enum WbemComparisonFlagEnum : int
{
    wbemComparisonFlagIncludeAll          = 0x00000000,
    wbemComparisonFlagIgnoreQualifiers    = 0x00000001,
    wbemComparisonFlagIgnoreObjectSource  = 0x00000002,
    wbemComparisonFlagIgnoreDefaultValues = 0x00000004,
    wbemComparisonFlagIgnoreClass         = 0x00000008,
    wbemComparisonFlagIgnoreCase          = 0x00000010,
    wbemComparisonFlagIgnoreFlavor        = 0x00000020,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemdisp/ne-wbemdisp-wbemcimtypeenum
enum WbemCimtypeEnum : int
{
    wbemCimtypeSint8     = 0x00000010,
    wbemCimtypeUint8     = 0x00000011,
    wbemCimtypeSint16    = 0x00000002,
    wbemCimtypeUint16    = 0x00000012,
    wbemCimtypeSint32    = 0x00000003,
    wbemCimtypeUint32    = 0x00000013,
    wbemCimtypeSint64    = 0x00000014,
    wbemCimtypeUint64    = 0x00000015,
    wbemCimtypeReal32    = 0x00000004,
    wbemCimtypeReal64    = 0x00000005,
    wbemCimtypeBoolean   = 0x0000000b,
    wbemCimtypeString    = 0x00000008,
    wbemCimtypeDatetime  = 0x00000065,
    wbemCimtypeReference = 0x00000066,
    wbemCimtypeChar16    = 0x00000067,
    wbemCimtypeObject    = 0x0000000d,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemdisp/ne-wbemdisp-wbemerrorenum
enum WbemErrorEnum : int
{
    wbemNoErr                           = 0x00000000,
    wbemErrFailed                       = 0x80041001,
    wbemErrNotFound                     = 0x80041002,
    wbemErrAccessDenied                 = 0x80041003,
    wbemErrProviderFailure              = 0x80041004,
    wbemErrTypeMismatch                 = 0x80041005,
    wbemErrOutOfMemory                  = 0x80041006,
    wbemErrInvalidContext               = 0x80041007,
    wbemErrInvalidParameter             = 0x80041008,
    wbemErrNotAvailable                 = 0x80041009,
    wbemErrCriticalError                = 0x8004100a,
    wbemErrInvalidStream                = 0x8004100b,
    wbemErrNotSupported                 = 0x8004100c,
    wbemErrInvalidSuperclass            = 0x8004100d,
    wbemErrInvalidNamespace             = 0x8004100e,
    wbemErrInvalidObject                = 0x8004100f,
    wbemErrInvalidClass                 = 0x80041010,
    wbemErrProviderNotFound             = 0x80041011,
    wbemErrInvalidProviderRegistration  = 0x80041012,
    wbemErrProviderLoadFailure          = 0x80041013,
    wbemErrInitializationFailure        = 0x80041014,
    wbemErrTransportFailure             = 0x80041015,
    wbemErrInvalidOperation             = 0x80041016,
    wbemErrInvalidQuery                 = 0x80041017,
    wbemErrInvalidQueryType             = 0x80041018,
    wbemErrAlreadyExists                = 0x80041019,
    wbemErrOverrideNotAllowed           = 0x8004101a,
    wbemErrPropagatedQualifier          = 0x8004101b,
    wbemErrPropagatedProperty           = 0x8004101c,
    wbemErrUnexpected                   = 0x8004101d,
    wbemErrIllegalOperation             = 0x8004101e,
    wbemErrCannotBeKey                  = 0x8004101f,
    wbemErrIncompleteClass              = 0x80041020,
    wbemErrInvalidSyntax                = 0x80041021,
    wbemErrNondecoratedObject           = 0x80041022,
    wbemErrReadOnly                     = 0x80041023,
    wbemErrProviderNotCapable           = 0x80041024,
    wbemErrClassHasChildren             = 0x80041025,
    wbemErrClassHasInstances            = 0x80041026,
    wbemErrQueryNotImplemented          = 0x80041027,
    wbemErrIllegalNull                  = 0x80041028,
    wbemErrInvalidQualifierType         = 0x80041029,
    wbemErrInvalidPropertyType          = 0x8004102a,
    wbemErrValueOutOfRange              = 0x8004102b,
    wbemErrCannotBeSingleton            = 0x8004102c,
    wbemErrInvalidCimType               = 0x8004102d,
    wbemErrInvalidMethod                = 0x8004102e,
    wbemErrInvalidMethodParameters      = 0x8004102f,
    wbemErrSystemProperty               = 0x80041030,
    wbemErrInvalidProperty              = 0x80041031,
    wbemErrCallCancelled                = 0x80041032,
    wbemErrShuttingDown                 = 0x80041033,
    wbemErrPropagatedMethod             = 0x80041034,
    wbemErrUnsupportedParameter         = 0x80041035,
    wbemErrMissingParameter             = 0x80041036,
    wbemErrInvalidParameterId           = 0x80041037,
    wbemErrNonConsecutiveParameterIds   = 0x80041038,
    wbemErrParameterIdOnRetval          = 0x80041039,
    wbemErrInvalidObjectPath            = 0x8004103a,
    wbemErrOutOfDiskSpace               = 0x8004103b,
    wbemErrBufferTooSmall               = 0x8004103c,
    wbemErrUnsupportedPutExtension      = 0x8004103d,
    wbemErrUnknownObjectType            = 0x8004103e,
    wbemErrUnknownPacketType            = 0x8004103f,
    wbemErrMarshalVersionMismatch       = 0x80041040,
    wbemErrMarshalInvalidSignature      = 0x80041041,
    wbemErrInvalidQualifier             = 0x80041042,
    wbemErrInvalidDuplicateParameter    = 0x80041043,
    wbemErrTooMuchData                  = 0x80041044,
    wbemErrServerTooBusy                = 0x80041045,
    wbemErrInvalidFlavor                = 0x80041046,
    wbemErrCircularReference            = 0x80041047,
    wbemErrUnsupportedClassUpdate       = 0x80041048,
    wbemErrCannotChangeKeyInheritance   = 0x80041049,
    wbemErrCannotChangeIndexInheritance = 0x80041050,
    wbemErrTooManyProperties            = 0x80041051,
    wbemErrUpdateTypeMismatch           = 0x80041052,
    wbemErrUpdateOverrideNotAllowed     = 0x80041053,
    wbemErrUpdatePropagatedMethod       = 0x80041054,
    wbemErrMethodNotImplemented         = 0x80041055,
    wbemErrMethodDisabled               = 0x80041056,
    wbemErrRefresherBusy                = 0x80041057,
    wbemErrUnparsableQuery              = 0x80041058,
    wbemErrNotEventClass                = 0x80041059,
    wbemErrMissingGroupWithin           = 0x8004105a,
    wbemErrMissingAggregationList       = 0x8004105b,
    wbemErrPropertyNotAnObject          = 0x8004105c,
    wbemErrAggregatingByObject          = 0x8004105d,
    wbemErrUninterpretableProviderQuery = 0x8004105f,
    wbemErrBackupRestoreWinmgmtRunning  = 0x80041060,
    wbemErrQueueOverflow                = 0x80041061,
    wbemErrPrivilegeNotHeld             = 0x80041062,
    wbemErrInvalidOperator              = 0x80041063,
    wbemErrLocalCredentials             = 0x80041064,
    wbemErrCannotBeAbstract             = 0x80041065,
    wbemErrAmendedObject                = 0x80041066,
    wbemErrClientTooSlow                = 0x80041067,
    wbemErrNullSecurityDescriptor       = 0x80041068,
    wbemErrTimeout                      = 0x80041069,
    wbemErrInvalidAssociation           = 0x8004106a,
    wbemErrAmbiguousOperation           = 0x8004106b,
    wbemErrQuotaViolation               = 0x8004106c,
    wbemErrTransactionConflict          = 0x8004106d,
    wbemErrForcedRollback               = 0x8004106e,
    wbemErrUnsupportedLocale            = 0x8004106f,
    wbemErrHandleOutOfDate              = 0x80041070,
    wbemErrConnectionFailed             = 0x80041071,
    wbemErrInvalidHandleRequest         = 0x80041072,
    wbemErrPropertyNameTooWide          = 0x80041073,
    wbemErrClassNameTooWide             = 0x80041074,
    wbemErrMethodNameTooWide            = 0x80041075,
    wbemErrQualifierNameTooWide         = 0x80041076,
    wbemErrRerunCommand                 = 0x80041077,
    wbemErrDatabaseVerMismatch          = 0x80041078,
    wbemErrVetoPut                      = 0x80041079,
    wbemErrVetoDelete                   = 0x8004107a,
    wbemErrInvalidLocale                = 0x80041080,
    wbemErrProviderSuspended            = 0x80041081,
    wbemErrSynchronizationRequired      = 0x80041082,
    wbemErrNoSchema                     = 0x80041083,
    wbemErrProviderAlreadyRegistered    = 0x80041084,
    wbemErrProviderNotRegistered        = 0x80041085,
    wbemErrFatalTransportError          = 0x80041086,
    wbemErrEncryptedConnectionRequired  = 0x80041087,
    wbemErrRegistrationTooBroad         = 0x80042001,
    wbemErrRegistrationTooPrecise       = 0x80042002,
    wbemErrTimedout                     = 0x80043001,
    wbemErrResetToDefault               = 0x80043002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemdisp/ne-wbemdisp-wbemauthenticationlevelenum
enum WbemAuthenticationLevelEnum : int
{
    wbemAuthenticationLevelDefault      = 0x00000000,
    wbemAuthenticationLevelNone         = 0x00000001,
    wbemAuthenticationLevelConnect      = 0x00000002,
    wbemAuthenticationLevelCall         = 0x00000003,
    wbemAuthenticationLevelPkt          = 0x00000004,
    wbemAuthenticationLevelPktIntegrity = 0x00000005,
    wbemAuthenticationLevelPktPrivacy   = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemdisp/ne-wbemdisp-wbemimpersonationlevelenum
enum WbemImpersonationLevelEnum : int
{
    wbemImpersonationLevelAnonymous   = 0x00000001,
    wbemImpersonationLevelIdentify    = 0x00000002,
    wbemImpersonationLevelImpersonate = 0x00000003,
    wbemImpersonationLevelDelegate    = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemdisp/ne-wbemdisp-wbemprivilegeenum
enum WbemPrivilegeEnum : int
{
    wbemPrivilegeCreateToken          = 0x00000001,
    wbemPrivilegePrimaryToken         = 0x00000002,
    wbemPrivilegeLockMemory           = 0x00000003,
    wbemPrivilegeIncreaseQuota        = 0x00000004,
    wbemPrivilegeMachineAccount       = 0x00000005,
    wbemPrivilegeTcb                  = 0x00000006,
    wbemPrivilegeSecurity             = 0x00000007,
    wbemPrivilegeTakeOwnership        = 0x00000008,
    wbemPrivilegeLoadDriver           = 0x00000009,
    wbemPrivilegeSystemProfile        = 0x0000000a,
    wbemPrivilegeSystemtime           = 0x0000000b,
    wbemPrivilegeProfileSingleProcess = 0x0000000c,
    wbemPrivilegeIncreaseBasePriority = 0x0000000d,
    wbemPrivilegeCreatePagefile       = 0x0000000e,
    wbemPrivilegeCreatePermanent      = 0x0000000f,
    wbemPrivilegeBackup               = 0x00000010,
    wbemPrivilegeRestore              = 0x00000011,
    wbemPrivilegeShutdown             = 0x00000012,
    wbemPrivilegeDebug                = 0x00000013,
    wbemPrivilegeAudit                = 0x00000014,
    wbemPrivilegeSystemEnvironment    = 0x00000015,
    wbemPrivilegeChangeNotify         = 0x00000016,
    wbemPrivilegeRemoteShutdown       = 0x00000017,
    wbemPrivilegeUndock               = 0x00000018,
    wbemPrivilegeSyncAgent            = 0x00000019,
    wbemPrivilegeEnableDelegation     = 0x0000001a,
    wbemPrivilegeManageVolume         = 0x0000001b,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemdisp/ne-wbemdisp-wbemobjecttextformatenum
enum WbemObjectTextFormatEnum : int
{
    wbemObjectTextFormatCIMDTD20 = 0x00000001,
    wbemObjectTextFormatWMIDTD20 = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemdisp/ne-wbemdisp-wbemconnectoptionsenum
enum WbemConnectOptionsEnum : int
{
    wbemConnectFlagUseMaxWait = 0x00000080,
}

alias WBEM_LOGIN_TYPE = int;
enum : int
{
    WBEM_FLAG_INPROC_LOGIN            = 0x00000000,
    WBEM_FLAG_LOCAL_LOGIN             = 0x00000001,
    WBEM_FLAG_REMOTE_LOGIN            = 0x00000002,
    WBEM_AUTHENTICATION_METHOD_MASK   = 0x0000000f,
    WBEM_FLAG_USE_MULTIPLE_CHALLENGES = 0x00000010,
}

// Constants


enum : uint
{
    MI_FLAG_ANY     = 0x0000007fU,
    MI_FLAG_VERSION = 0x1c000000U,
    MI_FLAG_ADOPT   = 0x80000000U,
}

enum uint MI_CHAR_TYPE = 0x00000002U;

enum : uint
{
    MI_FLAG_CLASS          = 0x00000001U,
    MI_FLAG_METHOD         = 0x00000002U,
    MI_FLAG_PROPERTY       = 0x00000004U,
    MI_FLAG_PARAMETER      = 0x00000008U,
    MI_FLAG_ASSOCIATION    = 0x00000010U,
    MI_FLAG_INDICATION     = 0x00000020U,
    MI_FLAG_REFERENCE      = 0x00000040U,
    MI_FLAG_ENABLEOVERRIDE = 0x00000080U,
}

enum uint MI_FLAG_DISABLEOVERRIDE = 0x00000100U;

enum : uint
{
    MI_FLAG_RESTRICTED   = 0x00000200U,
    MI_FLAG_TOSUBCLASS   = 0x00000400U,
    MI_FLAG_TRANSLATABLE = 0x00000800U,
}

enum : uint
{
    MI_FLAG_KEY          = 0x00001000U,
    MI_FLAG_IN           = 0x00002000U,
    MI_FLAG_OUT          = 0x00004000U,
    MI_FLAG_REQUIRED     = 0x00008000U,
    MI_FLAG_STATIC       = 0x00010000U,
    MI_FLAG_ABSTRACT     = 0x00020000U,
    MI_FLAG_TERMINAL     = 0x00040000U,
    MI_FLAG_EXPENSIVE    = 0x00080000U,
    MI_FLAG_STREAM       = 0x00100000U,
    MI_FLAG_READONLY     = 0x00200000U,
    MI_FLAG_EXTENDED     = 0x00001000U,
    MI_FLAG_NOT_MODIFIED = 0x02000000U,
    MI_FLAG_NULL         = 0x20000000U,
    MI_FLAG_BORROW       = 0x40000000U,
}

enum : uint
{
    MI_MODULE_FLAG_STANDARD_QUALIFIERS = 0x00000001U,
    MI_MODULE_FLAG_DESCRIPTIONS        = 0x00000002U,
    MI_MODULE_FLAG_VALUES              = 0x00000004U,
    MI_MODULE_FLAG_MAPPING_STRINGS     = 0x00000008U,
    MI_MODULE_FLAG_BOOLEANS            = 0x00000010U,
    MI_MODULE_FLAG_CPLUSPLUS           = 0x00000020U,
    MI_MODULE_FLAG_LOCALIZED           = 0x00000040U,
    MI_MODULE_FLAG_FILTER_SUPPORT      = 0x00000080U,
}

enum uint MI_MAX_LOCALE_SIZE = 0x00000080U;

enum : uint
{
    MI_WRITEMESSAGE_CHANNEL_WARNING = 0x00000000U,
    MI_WRITEMESSAGE_CHANNEL_VERBOSE = 0x00000001U,
    MI_WRITEMESSAGE_CHANNEL_DEBUG   = 0x00000002U,
}

enum uint MI_CALL_VERSION = 0x00000001U;

enum : uint
{
    MI_OPERATIONFLAGS_MANUAL_ACK_RESULTS                = 0x00000001U,
    MI_OPERATIONFLAGS_NO_RTTI                           = 0x00000400U,
    MI_OPERATIONFLAGS_BASIC_RTTI                        = 0x00000002U,
    MI_OPERATIONFLAGS_STANDARD_RTTI                     = 0x00000800U,
    MI_OPERATIONFLAGS_FULL_RTTI                         = 0x00000004U,
    MI_OPERATIONFLAGS_DEFAULT_RTTI                      = 0x00000000U,
    MI_OPERATIONFLAGS_LOCALIZED_QUALIFIERS              = 0x00000008U,
    MI_OPERATIONFLAGS_EXPENSIVE_PROPERTIES              = 0x00000040U,
    MI_OPERATIONFLAGS_POLYMORPHISM_SHALLOW              = 0x00000080U,
    MI_OPERATIONFLAGS_POLYMORPHISM_DEEP_BASE_PROPS_ONLY = 0x00000180U,
}

enum uint MI_OPERATIONFLAGS_REPORT_OPERATION_STARTED = 0x00000200U;

enum : const(wchar)*
{
    MI_SUBSCRIBE_BOOKMARK_OLDEST = "MI_SUBSCRIBE_BOOKMARK_OLDEST",
    MI_SUBSCRIBE_BOOKMARK_NEWEST = "MI_SUBSCRIBE_BOOKMARK_NEWEST",
}

enum : uint
{
    MI_SERIALIZER_FLAGS_CLASS_DEEP          = 0x00000001U,
    MI_SERIALIZER_FLAGS_INSTANCE_WITH_CLASS = 0x00000001U,
}

enum : uint
{
    WBEMS_DISPID_DERIVATION       = 0x00000017U,
    WBEMS_DISPID_OBJECT_READY     = 0x00000001U,
    WBEMS_DISPID_COMPLETED        = 0x00000002U,
    WBEMS_DISPID_PROGRESS         = 0x00000003U,
    WBEMS_DISPID_OBJECT_PUT       = 0x00000004U,
    WBEMS_DISPID_CONNECTION_READY = 0x00000005U,
}

enum : int
{
    WBEM_NO_WAIT  = 0x00000000,
    WBEM_INFINITE = 0xffffffff,
}

// Callbacks

alias MI_MethodDecl_Invoke = void function(void* self, MI_Context* context, const(ushort)* nameSpace, 
                                           const(ushort)* className, const(ushort)* methodName, 
                                           const(MI_Instance)* instanceName, const(MI_Instance)* parameters);
alias MI_ProviderFT_Load = void function(void** self, MI_Module_Self* selfModule, MI_Context* context);
alias MI_ProviderFT_Unload = void function(void* self, MI_Context* context);
alias MI_ProviderFT_GetInstance = void function(void* self, MI_Context* context, const(ushort)* nameSpace, 
                                                const(ushort)* className, const(MI_Instance)* instanceName, 
                                                const(MI_PropertySet)* propertySet);
alias MI_ProviderFT_EnumerateInstances = void function(void* self, MI_Context* context, const(ushort)* nameSpace, 
                                                       const(ushort)* className, const(MI_PropertySet)* propertySet, 
                                                       ubyte keysOnly, const(MI_Filter)* filter);
alias MI_ProviderFT_CreateInstance = void function(void* self, MI_Context* context, const(ushort)* nameSpace, 
                                                   const(ushort)* className, const(MI_Instance)* newInstance);
alias MI_ProviderFT_ModifyInstance = void function(void* self, MI_Context* context, const(ushort)* nameSpace, 
                                                   const(ushort)* className, const(MI_Instance)* modifiedInstance, 
                                                   const(MI_PropertySet)* propertySet);
alias MI_ProviderFT_DeleteInstance = void function(void* self, MI_Context* context, const(ushort)* nameSpace, 
                                                   const(ushort)* className, const(MI_Instance)* instanceName);
alias MI_ProviderFT_AssociatorInstances = void function(void* self, MI_Context* context, const(ushort)* nameSpace, 
                                                        const(ushort)* className, const(MI_Instance)* instanceName, 
                                                        const(ushort)* resultClass, const(ushort)* role, 
                                                        const(ushort)* resultRole, 
                                                        const(MI_PropertySet)* propertySet, ubyte keysOnly, 
                                                        const(MI_Filter)* filter);
alias MI_ProviderFT_ReferenceInstances = void function(void* self, MI_Context* context, const(ushort)* nameSpace, 
                                                       const(ushort)* className, const(MI_Instance)* instanceName, 
                                                       const(ushort)* role, const(MI_PropertySet)* propertySet, 
                                                       ubyte keysOnly, const(MI_Filter)* filter);
alias MI_ProviderFT_EnableIndications = void function(void* self, MI_Context* indicationsContext, 
                                                      const(ushort)* nameSpace, const(ushort)* className);
alias MI_ProviderFT_DisableIndications = void function(void* self, MI_Context* indicationsContext, 
                                                       const(ushort)* nameSpace, const(ushort)* className);
alias MI_ProviderFT_Subscribe = void function(void* self, MI_Context* context, const(ushort)* nameSpace, 
                                              const(ushort)* className, const(MI_Filter)* filter, 
                                              const(ushort)* bookmark, ulong subscriptionID, void** subscriptionSelf);
alias MI_ProviderFT_Unsubscribe = void function(void* self, MI_Context* context, const(ushort)* nameSpace, 
                                                const(ushort)* className, ulong subscriptionID, 
                                                void* subscriptionSelf);
alias MI_ProviderFT_Invoke = void function(void* self, MI_Context* context, const(ushort)* nameSpace, 
                                           const(ushort)* className, const(ushort)* methodName, 
                                           const(MI_Instance)* instanceName, const(MI_Instance)* inputParameters);
alias MI_Module_Load = void function(MI_Module_Self** self, MI_Context* context);
alias MI_Module_Unload = void function(MI_Module_Self* self, MI_Context* context);
alias MI_CancelCallback = void function(MI_CancellationReason reason, void* callbackData);
alias MI_MainFunction = MI_Module* function(MI_Server* server);
alias MI_OperationCallback_PromptUser = void function(MI_Operation* operation, void* callbackContext, 
                                                      const(ushort)* message, MI_PromptType promptType, 
                                                      ptrdiff_t promptUserResult);
alias MI_OperationCallback_WriteError = void function(MI_Operation* operation, void* callbackContext, 
                                                      MI_Instance* instance, ptrdiff_t writeErrorResult);
alias MI_OperationCallback_WriteMessage = void function(MI_Operation* operation, void* callbackContext, 
                                                        uint channel, const(ushort)* message);
alias MI_OperationCallback_WriteProgress = void function(MI_Operation* operation, void* callbackContext, 
                                                         const(ushort)* activity, const(ushort)* currentOperation, 
                                                         const(ushort)* statusDescription, uint percentageComplete, 
                                                         uint secondsRemaining);
alias MI_OperationCallback_Instance = void function(MI_Operation* operation, void* callbackContext, 
                                                    const(MI_Instance)* instance, ubyte moreResults, 
                                                    MI_Result resultCode, const(ushort)* errorString, 
                                                    const(MI_Instance)* errorDetails, 
                                                    ptrdiff_t resultAcknowledgement);
alias MI_OperationCallback_StreamedParameter = void function(MI_Operation* operation, void* callbackContext, 
                                                             const(ushort)* parameterName, MI_Type resultType, 
                                                             const(MI_Value)* result, 
                                                             ptrdiff_t resultAcknowledgement);
alias MI_OperationCallback_Indication = void function(MI_Operation* operation, void* callbackContext, 
                                                      const(MI_Instance)* instance, const(ushort)* bookmark, 
                                                      const(ushort)* machineID, ubyte moreResults, 
                                                      MI_Result resultCode, const(ushort)* errorString, 
                                                      const(MI_Instance)* errorDetails, 
                                                      ptrdiff_t resultAcknowledgement);
alias MI_OperationCallback_Class = void function(MI_Operation* operation, void* callbackContext, 
                                                 const(MI_Class)* classResult, ubyte moreResults, 
                                                 MI_Result resultCode, const(ushort)* errorString, 
                                                 const(MI_Instance)* errorDetails, ptrdiff_t resultAcknowledgement);
alias MI_Deserializer_ClassObjectNeeded = MI_Result function(void* context, const(ushort)* serverName, 
                                                             const(ushort)* namespaceName, const(ushort)* className, 
                                                             MI_Class** requestedClassObject);

// Structs


struct MI_Module_Self
{
    ptrdiff_t Value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_timestamp
struct MI_Timestamp
{
    uint year;
    uint month;
    uint day;
    uint hour;
    uint minute;
    uint second;
    uint microseconds;
    int  utc;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_interval
struct MI_Interval
{
    uint days;
    uint hours;
    uint minutes;
    uint seconds;
    uint microseconds;
    uint __padding1;
    uint __padding2;
    uint __padding3;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_datetime
struct MI_Datetime
{
    uint isTimestamp;
    union u
    {
        MI_Timestamp timestamp;
        MI_Interval  interval;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_booleana
struct MI_BooleanA
{
    ubyte* data;
    uint   size;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_uint8a
struct MI_Uint8A
{
    ubyte* data;
    uint   size;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_sint8a
struct MI_Sint8A
{
    byte* data;
    uint  size;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_uint16a
struct MI_Uint16A
{
    ushort* data;
    uint    size;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_sint16a
struct MI_Sint16A
{
    short* data;
    uint   size;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_uint32a
struct MI_Uint32A
{
    uint* data;
    uint  size;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_sint32a
struct MI_Sint32A
{
    int* data;
    uint size;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_uint64a
struct MI_Uint64A
{
    ulong* data;
    uint   size;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_sint64a
struct MI_Sint64A
{
    long* data;
    uint  size;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_real32a
struct MI_Real32A
{
    float* data;
    uint   size;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_real64a
struct MI_Real64A
{
    double* data;
    uint    size;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_char16a
struct MI_Char16A
{
    ushort* data;
    uint    size;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_datetimea
struct MI_DatetimeA
{
    MI_Datetime* data;
    uint         size;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_stringa
struct MI_StringA
{
    ushort** data;
    uint     size;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_referencea
struct MI_ReferenceA
{
    MI_Instance** data;
    uint          size;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_instancea
struct MI_InstanceA
{
    MI_Instance** data;
    uint          size;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_array
struct MI_Array
{
    void* data;
    uint  size;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_constbooleana
struct MI_ConstBooleanA
{
    const(ubyte)* data;
    uint          size;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_constuint8a
struct MI_ConstUint8A
{
    const(ubyte)* data;
    uint          size;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_constsint8a
struct MI_ConstSint8A
{
    const(byte)* data;
    uint         size;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_constuint16a
struct MI_ConstUint16A
{
    const(ushort)* data;
    uint           size;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_constsint16a
struct MI_ConstSint16A
{
    const(short)* data;
    uint          size;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_constuint32a
struct MI_ConstUint32A
{
    const(uint)* data;
    uint         size;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_constsint32a
struct MI_ConstSint32A
{
    const(int)* data;
    uint        size;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_constuint64a
struct MI_ConstUint64A
{
    const(ulong)* data;
    uint          size;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_constsint64a
struct MI_ConstSint64A
{
    const(long)* data;
    uint         size;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_constreal32a
struct MI_ConstReal32A
{
    const(float)* data;
    uint          size;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_constreal64a
struct MI_ConstReal64A
{
    const(double)* data;
    uint           size;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_constchar16a
struct MI_ConstChar16A
{
    const(ushort)* data;
    uint           size;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_constdatetimea
struct MI_ConstDatetimeA
{
    const(MI_Datetime)* data;
    uint                size;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_conststringa
struct MI_ConstStringA
{
    const(ushort)** data;
    uint            size;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_constreferencea
struct MI_ConstReferenceA
{
    const(MI_Instance)** data;
    uint                 size;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_constinstancea
struct MI_ConstInstanceA
{
    const(MI_Instance)** data;
    uint                 size;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_value
union MI_Value
{
    ubyte         boolean;
    ubyte         uint8;
    byte          sint8;
    ushort        uint16;
    short         sint16;
    uint          uint32;
    int           sint32;
    ulong         uint64;
    long          sint64;
    float         real32;
    double        real64;
    ushort        char16;
    MI_Datetime   datetime;
    ushort*       string;
    MI_Instance*  instance;
    MI_Instance*  reference;
    MI_BooleanA   booleana;
    MI_Uint8A     uint8a;
    MI_Sint8A     sint8a;
    MI_Uint16A    uint16a;
    MI_Sint16A    sint16a;
    MI_Uint32A    uint32a;
    MI_Sint32A    sint32a;
    MI_Uint64A    uint64a;
    MI_Sint64A    sint64a;
    MI_Real32A    real32a;
    MI_Real64A    real64a;
    MI_Char16A    char16a;
    MI_DatetimeA  datetimea;
    MI_StringA    stringa;
    MI_ReferenceA referencea;
    MI_InstanceA  instancea;
    MI_Array      array;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_booleanfield
struct MI_BooleanField
{
    ubyte value;
    ubyte exists;
    ubyte flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_sint8field
struct MI_Sint8Field
{
    byte  value;
    ubyte exists;
    ubyte flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_uint8field
struct MI_Uint8Field
{
    ubyte value;
    ubyte exists;
    ubyte flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_sint16field
struct MI_Sint16Field
{
    short value;
    ubyte exists;
    ubyte flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_uint16field
struct MI_Uint16Field
{
    ushort value;
    ubyte  exists;
    ubyte  flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_sint32field
struct MI_Sint32Field
{
    int   value;
    ubyte exists;
    ubyte flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_uint32field
struct MI_Uint32Field
{
    uint  value;
    ubyte exists;
    ubyte flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_sint64field
struct MI_Sint64Field
{
    long  value;
    ubyte exists;
    ubyte flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_uint64field
struct MI_Uint64Field
{
    ulong value;
    ubyte exists;
    ubyte flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_real32field
struct MI_Real32Field
{
    float value;
    ubyte exists;
    ubyte flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_real64field
struct MI_Real64Field
{
    double value;
    ubyte  exists;
    ubyte  flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_char16field
struct MI_Char16Field
{
    ushort value;
    ubyte  exists;
    ubyte  flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_datetimefield
struct MI_DatetimeField
{
    MI_Datetime value;
    ubyte       exists;
    ubyte       flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_stringfield
struct MI_StringField
{
    ushort* value;
    ubyte   exists;
    ubyte   flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_referencefield
struct MI_ReferenceField
{
    MI_Instance* value;
    ubyte        exists;
    ubyte        flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_instancefield
struct MI_InstanceField
{
    MI_Instance* value;
    ubyte        exists;
    ubyte        flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_booleanafield
struct MI_BooleanAField
{
    MI_BooleanA value;
    ubyte       exists;
    ubyte       flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_uint8afield
struct MI_Uint8AField
{
    MI_Uint8A value;
    ubyte     exists;
    ubyte     flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_sint8afield
struct MI_Sint8AField
{
    MI_Sint8A value;
    ubyte     exists;
    ubyte     flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_uint16afield
struct MI_Uint16AField
{
    MI_Uint16A value;
    ubyte      exists;
    ubyte      flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_sint16afield
struct MI_Sint16AField
{
    MI_Sint16A value;
    ubyte      exists;
    ubyte      flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_uint32afield
struct MI_Uint32AField
{
    MI_Uint32A value;
    ubyte      exists;
    ubyte      flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_sint32afield
struct MI_Sint32AField
{
    MI_Sint32A value;
    ubyte      exists;
    ubyte      flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_uint64afield
struct MI_Uint64AField
{
    MI_Uint64A value;
    ubyte      exists;
    ubyte      flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_sint64afield
struct MI_Sint64AField
{
    MI_Sint64A value;
    ubyte      exists;
    ubyte      flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_real32afield
struct MI_Real32AField
{
    MI_Real32A value;
    ubyte      exists;
    ubyte      flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_real64afield
struct MI_Real64AField
{
    MI_Real64A value;
    ubyte      exists;
    ubyte      flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_char16afield
struct MI_Char16AField
{
    MI_Char16A value;
    ubyte      exists;
    ubyte      flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_datetimeafield
struct MI_DatetimeAField
{
    MI_DatetimeA value;
    ubyte        exists;
    ubyte        flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_stringafield
struct MI_StringAField
{
    MI_StringA value;
    ubyte      exists;
    ubyte      flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_referenceafield
struct MI_ReferenceAField
{
    MI_ReferenceA value;
    ubyte         exists;
    ubyte         flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_instanceafield
struct MI_InstanceAField
{
    MI_InstanceA value;
    ubyte        exists;
    ubyte        flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_arrayfield
struct MI_ArrayField
{
    MI_Array value;
    ubyte    exists;
    ubyte    flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_constbooleanfield
struct MI_ConstBooleanField
{
    ubyte value;
    ubyte exists;
    ubyte flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_constsint8field
struct MI_ConstSint8Field
{
    byte  value;
    ubyte exists;
    ubyte flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_constuint8field
struct MI_ConstUint8Field
{
    ubyte value;
    ubyte exists;
    ubyte flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_constsint16field
struct MI_ConstSint16Field
{
    short value;
    ubyte exists;
    ubyte flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_constuint16field
struct MI_ConstUint16Field
{
    ushort value;
    ubyte  exists;
    ubyte  flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_constsint32field
struct MI_ConstSint32Field
{
    int   value;
    ubyte exists;
    ubyte flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_constuint32field
struct MI_ConstUint32Field
{
    uint  value;
    ubyte exists;
    ubyte flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_constsint64field
struct MI_ConstSint64Field
{
    long  value;
    ubyte exists;
    ubyte flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_constuint64field
struct MI_ConstUint64Field
{
    ulong value;
    ubyte exists;
    ubyte flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_constreal32field
struct MI_ConstReal32Field
{
    float value;
    ubyte exists;
    ubyte flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_constreal64field
struct MI_ConstReal64Field
{
    double value;
    ubyte  exists;
    ubyte  flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_constchar16field
struct MI_ConstChar16Field
{
    ushort value;
    ubyte  exists;
    ubyte  flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_constdatetimefield
struct MI_ConstDatetimeField
{
    MI_Datetime value;
    ubyte       exists;
    ubyte       flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_conststringfield
struct MI_ConstStringField
{
    const(ushort)* value;
    ubyte          exists;
    ubyte          flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_constreferencefield
struct MI_ConstReferenceField
{
    const(MI_Instance)* value;
    ubyte               exists;
    ubyte               flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_constinstancefield
struct MI_ConstInstanceField
{
    const(MI_Instance)* value;
    ubyte               exists;
    ubyte               flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_constbooleanafield
struct MI_ConstBooleanAField
{
    MI_ConstBooleanA value;
    ubyte            exists;
    ubyte            flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_constuint8afield
struct MI_ConstUint8AField
{
    MI_ConstUint8A value;
    ubyte          exists;
    ubyte          flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_constsint8afield
struct MI_ConstSint8AField
{
    MI_ConstSint8A value;
    ubyte          exists;
    ubyte          flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_constuint16afield
struct MI_ConstUint16AField
{
    MI_ConstUint16A value;
    ubyte           exists;
    ubyte           flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_constsint16afield
struct MI_ConstSint16AField
{
    MI_ConstSint16A value;
    ubyte           exists;
    ubyte           flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_constuint32afield
struct MI_ConstUint32AField
{
    MI_ConstUint32A value;
    ubyte           exists;
    ubyte           flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_constsint32afield
struct MI_ConstSint32AField
{
    MI_ConstSint32A value;
    ubyte           exists;
    ubyte           flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_constuint64afield
struct MI_ConstUint64AField
{
    MI_ConstUint64A value;
    ubyte           exists;
    ubyte           flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_constsint64afield
struct MI_ConstSint64AField
{
    MI_ConstSint64A value;
    ubyte           exists;
    ubyte           flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_constreal32afield
struct MI_ConstReal32AField
{
    MI_ConstReal32A value;
    ubyte           exists;
    ubyte           flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_constreal64afield
struct MI_ConstReal64AField
{
    MI_ConstReal64A value;
    ubyte           exists;
    ubyte           flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_constchar16afield
struct MI_ConstChar16AField
{
    MI_ConstChar16A value;
    ubyte           exists;
    ubyte           flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_constdatetimeafield
struct MI_ConstDatetimeAField
{
    MI_ConstDatetimeA value;
    ubyte             exists;
    ubyte             flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_conststringafield
struct MI_ConstStringAField
{
    MI_ConstStringA value;
    ubyte           exists;
    ubyte           flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_constreferenceafield
struct MI_ConstReferenceAField
{
    MI_ConstReferenceA value;
    ubyte              exists;
    ubyte              flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_constinstanceafield
struct MI_ConstInstanceAField
{
    MI_ConstInstanceA value;
    ubyte             exists;
    ubyte             flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_serverft
struct MI_ServerFT
{
    ptrdiff_t GetVersion;
    ptrdiff_t GetSystemName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_server
struct MI_Server
{
    const(MI_ServerFT)*  serverFT;
    const(MI_ContextFT)* contextFT;
    const(MI_InstanceFT)* instanceFT;
    const(MI_PropertySetFT)* propertySetFT;
    const(MI_FilterFT)*  filterFT;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_filterft
struct MI_FilterFT
{
    ptrdiff_t Evaluate;
    ptrdiff_t GetExpression;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_filter
struct MI_Filter
{
    const(MI_FilterFT)* ft;
    ptrdiff_t[3]        reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_propertysetft
struct MI_PropertySetFT
{
    ptrdiff_t GetElementCount;
    ptrdiff_t ContainsElement;
    ptrdiff_t AddElement;
    ptrdiff_t GetElementAt;
    ptrdiff_t Clear;
    ptrdiff_t Destruct;
    ptrdiff_t Delete;
    ptrdiff_t Clone;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_propertyset
struct MI_PropertySet
{
    const(MI_PropertySetFT)* ft;
    ptrdiff_t[3] reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_objectdecl
struct MI_ObjectDecl
{
    uint           flags;
    uint           code;
    const(ushort)* name;
    const(MI_Qualifier)** qualifiers;
    uint           numQualifiers;
    const(MI_PropertyDecl)** properties;
    uint           numProperties;
    uint           size;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_classdecl
struct MI_ClassDecl
{
    uint                 flags;
    uint                 code;
    const(ushort)*       name;
    const(MI_Qualifier)** qualifiers;
    uint                 numQualifiers;
    const(MI_PropertyDecl)** properties;
    uint                 numProperties;
    uint                 size;
    const(ushort)*       superClass;
    const(MI_ClassDecl)* superClassDecl;
    const(MI_MethodDecl)** methods;
    uint                 numMethods;
    const(MI_SchemaDecl)* schema;
    const(MI_ProviderFT)* providerFT;
    MI_Class*            owningClass;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_featuredecl
struct MI_FeatureDecl
{
    uint           flags;
    uint           code;
    const(ushort)* name;
    const(MI_Qualifier)** qualifiers;
    uint           numQualifiers;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_parameterdecl
struct MI_ParameterDecl
{
    uint           flags;
    uint           code;
    const(ushort)* name;
    const(MI_Qualifier)** qualifiers;
    uint           numQualifiers;
    uint           type;
    const(ushort)* className;
    uint           subscript;
    uint           offset;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_propertydecl
struct MI_PropertyDecl
{
    uint           flags;
    uint           code;
    const(ushort)* name;
    const(MI_Qualifier)** qualifiers;
    uint           numQualifiers;
    uint           type;
    const(ushort)* className;
    uint           subscript;
    uint           offset;
    const(ushort)* origin;
    const(ushort)* propagator;
    const(void)*   value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_methoddecl
struct MI_MethodDecl
{
    uint                 flags;
    uint                 code;
    const(ushort)*       name;
    const(MI_Qualifier)** qualifiers;
    uint                 numQualifiers;
    const(MI_ParameterDecl)** parameters;
    uint                 numParameters;
    uint                 size;
    uint                 returnType;
    const(ushort)*       origin;
    const(ushort)*       propagator;
    const(MI_SchemaDecl)* schema;
    MI_MethodDecl_Invoke function_;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_qualifierdecl
struct MI_QualifierDecl
{
    const(ushort)* name;
    uint           type;
    uint           scope_;
    uint           flavor;
    uint           subscript;
    const(void)*   value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_qualifier
struct MI_Qualifier
{
    const(ushort)* name;
    uint           type;
    uint           flavor;
    const(void)*   value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_schemadecl
struct MI_SchemaDecl
{
    const(MI_QualifierDecl)** qualifierDecls;
    uint numQualifierDecls;
    const(MI_ClassDecl)** classDecls;
    uint numClassDecls;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_providerft
struct MI_ProviderFT
{
    MI_ProviderFT_Load   Load;
    MI_ProviderFT_Unload Unload;
    MI_ProviderFT_GetInstance GetInstance;
    MI_ProviderFT_EnumerateInstances EnumerateInstances;
    MI_ProviderFT_CreateInstance CreateInstance;
    MI_ProviderFT_ModifyInstance ModifyInstance;
    MI_ProviderFT_DeleteInstance DeleteInstance;
    MI_ProviderFT_AssociatorInstances AssociatorInstances;
    MI_ProviderFT_ReferenceInstances ReferenceInstances;
    MI_ProviderFT_EnableIndications EnableIndications;
    MI_ProviderFT_DisableIndications DisableIndications;
    MI_ProviderFT_Subscribe Subscribe;
    MI_ProviderFT_Unsubscribe Unsubscribe;
    MI_ProviderFT_Invoke Invoke;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_module
struct MI_Module
{
    uint             version_;
    uint             generatorVersion;
    uint             flags;
    uint             charSize;
    MI_SchemaDecl*   schemaDecl;
    MI_Module_Load   Load;
    MI_Module_Unload Unload;
    const(MI_ProviderFT)* dynamicProviderFT;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_instanceft
struct MI_InstanceFT
{
    ptrdiff_t Clone;
    ptrdiff_t Destruct;
    ptrdiff_t Delete;
    ptrdiff_t IsA;
    ptrdiff_t GetClassNameA;
    ptrdiff_t SetNameSpace;
    ptrdiff_t GetNameSpace;
    ptrdiff_t GetElementCount;
    ptrdiff_t AddElement;
    ptrdiff_t SetElement;
    ptrdiff_t SetElementAt;
    ptrdiff_t GetElement;
    ptrdiff_t GetElementAt;
    ptrdiff_t ClearElement;
    ptrdiff_t ClearElementAt;
    ptrdiff_t GetServerName;
    ptrdiff_t SetServerName;
    ptrdiff_t GetClass;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_instanceexft
struct MI_InstanceExFT
{
    MI_InstanceFT parent;
    ptrdiff_t     Normalize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_instance
struct MI_Instance
{
    const(MI_InstanceFT)* ft;
    const(MI_ClassDecl)* classDecl;
    const(ushort)*       serverName;
    const(ushort)*       nameSpace;
    ptrdiff_t[4]         reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_contextft
struct MI_ContextFT
{
    ptrdiff_t PostResult;
    ptrdiff_t PostInstance;
    ptrdiff_t PostIndication;
    ptrdiff_t ConstructInstance;
    ptrdiff_t ConstructParameters;
    ptrdiff_t NewInstance;
    ptrdiff_t NewDynamicInstance;
    ptrdiff_t NewParameters;
    ptrdiff_t Canceled;
    ptrdiff_t GetLocale;
    ptrdiff_t RegisterCancel;
    ptrdiff_t RequestUnload;
    ptrdiff_t RefuseUnload;
    ptrdiff_t GetLocalSession;
    ptrdiff_t SetStringOption;
    ptrdiff_t GetStringOption;
    ptrdiff_t GetNumberOption;
    ptrdiff_t GetCustomOption;
    ptrdiff_t GetCustomOptionCount;
    ptrdiff_t GetCustomOptionAt;
    ptrdiff_t WriteMessage;
    ptrdiff_t WriteProgress;
    ptrdiff_t WriteStreamParameter;
    ptrdiff_t WriteCimError;
    ptrdiff_t PromptUser;
    ptrdiff_t ShouldProcess;
    ptrdiff_t ShouldContinue;
    ptrdiff_t PostError;
    ptrdiff_t PostCimError;
    ptrdiff_t WriteError;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_context
struct MI_Context
{
    const(MI_ContextFT)* ft;
    ptrdiff_t[3]         reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_qualifiersetft
struct MI_QualifierSetFT
{
    ptrdiff_t GetQualifierCount;
    ptrdiff_t GetQualifierAt;
    ptrdiff_t GetQualifier;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_qualifierset
struct MI_QualifierSet
{
    ulong     reserved1;
    ptrdiff_t reserved2;
    const(MI_QualifierSetFT)* ft;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_parametersetft
struct MI_ParameterSetFT
{
    ptrdiff_t GetMethodReturnType;
    ptrdiff_t GetParameterCount;
    ptrdiff_t GetParameterAt;
    ptrdiff_t GetParameter;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_parameterset
struct MI_ParameterSet
{
    ulong     reserved1;
    ptrdiff_t reserved2;
    const(MI_ParameterSetFT)* ft;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_classft
struct MI_ClassFT
{
    ptrdiff_t GetClassNameA;
    ptrdiff_t GetNameSpace;
    ptrdiff_t GetServerName;
    ptrdiff_t GetElementCount;
    ptrdiff_t GetElement;
    ptrdiff_t GetElementAt;
    ptrdiff_t GetClassQualifierSet;
    ptrdiff_t GetMethodCount;
    ptrdiff_t GetMethodAt;
    ptrdiff_t GetMethod;
    ptrdiff_t GetParentClassName;
    ptrdiff_t GetParentClass;
    ptrdiff_t Delete;
    ptrdiff_t Clone;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_class
struct MI_Class
{
    const(MI_ClassFT)*   ft;
    const(MI_ClassDecl)* classDecl;
    const(ushort)*       namespaceName;
    const(ushort)*       serverName;
    ptrdiff_t[4]         reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_operationcallbacks
struct MI_OperationCallbacks
{
    void* callbackContext;
    MI_OperationCallback_PromptUser promptUser;
    MI_OperationCallback_WriteError writeError;
    MI_OperationCallback_WriteMessage writeMessage;
    MI_OperationCallback_WriteProgress writeProgress;
    MI_OperationCallback_Instance instanceResult;
    MI_OperationCallback_Indication indicationResult;
    MI_OperationCallback_Class classResult;
    MI_OperationCallback_StreamedParameter streamedParameterResult;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_sessioncallbacks
struct MI_SessionCallbacks
{
    void*     callbackContext;
    ptrdiff_t writeMessage;
    ptrdiff_t writeError;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_usernamepasswordcreds
struct MI_UsernamePasswordCreds
{
    const(ushort)* domain;
    const(ushort)* username;
    const(ushort)* password;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_usercredentials
struct MI_UserCredentials
{
    const(ushort)* authenticationType;
    union credentials
    {
        MI_UsernamePasswordCreds usernamePassword;
        const(ushort)* certificateThumbprint;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_subscriptiondeliveryoptionsft
struct MI_SubscriptionDeliveryOptionsFT
{
    ptrdiff_t SetString;
    ptrdiff_t SetNumber;
    ptrdiff_t SetDateTime;
    ptrdiff_t SetInterval;
    ptrdiff_t AddCredentials;
    ptrdiff_t Delete;
    ptrdiff_t GetString;
    ptrdiff_t GetNumber;
    ptrdiff_t GetDateTime;
    ptrdiff_t GetInterval;
    ptrdiff_t GetOptionCount;
    ptrdiff_t GetOptionAt;
    ptrdiff_t GetOption;
    ptrdiff_t GetCredentialsCount;
    ptrdiff_t GetCredentialsAt;
    ptrdiff_t GetCredentialsPasswordAt;
    ptrdiff_t Clone;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_subscriptiondeliveryoptions
struct MI_SubscriptionDeliveryOptions
{
    ulong     reserved1;
    ptrdiff_t reserved2;
    const(MI_SubscriptionDeliveryOptionsFT)* ft;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_serializer
struct MI_Serializer
{
    ulong     reserved1;
    ptrdiff_t reserved2;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_deserializer
struct MI_Deserializer
{
    ulong     reserved1;
    ptrdiff_t reserved2;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_serializerft
struct MI_SerializerFT
{
    ptrdiff_t Close;
    ptrdiff_t SerializeClass;
    ptrdiff_t SerializeInstance;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_deserializerft
struct MI_DeserializerFT
{
    ptrdiff_t Close;
    ptrdiff_t DeserializeClass;
    ptrdiff_t Class_GetClassName;
    ptrdiff_t Class_GetParentClassName;
    ptrdiff_t DeserializeInstance;
    ptrdiff_t Instance_GetClassName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_applicationft
struct MI_ApplicationFT
{
    ptrdiff_t Close;
    ptrdiff_t NewSession;
    ptrdiff_t NewHostedProvider;
    ptrdiff_t NewInstance;
    ptrdiff_t NewDestinationOptions;
    ptrdiff_t NewOperationOptions;
    ptrdiff_t NewSubscriptionDeliveryOptions;
    ptrdiff_t NewSerializer;
    ptrdiff_t NewDeserializer;
    ptrdiff_t NewInstanceFromClass;
    ptrdiff_t NewClass;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_hostedproviderft
struct MI_HostedProviderFT
{
    ptrdiff_t Close;
    ptrdiff_t GetApplication;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_sessionft
struct MI_SessionFT
{
    ptrdiff_t Close;
    ptrdiff_t GetApplication;
    ptrdiff_t GetInstance;
    ptrdiff_t ModifyInstance;
    ptrdiff_t CreateInstance;
    ptrdiff_t DeleteInstance;
    ptrdiff_t Invoke;
    ptrdiff_t EnumerateInstances;
    ptrdiff_t QueryInstances;
    ptrdiff_t AssociatorInstances;
    ptrdiff_t ReferenceInstances;
    ptrdiff_t Subscribe;
    ptrdiff_t GetClass;
    ptrdiff_t EnumerateClasses;
    ptrdiff_t TestConnection;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_operationft
struct MI_OperationFT
{
    ptrdiff_t Close;
    ptrdiff_t Cancel;
    ptrdiff_t GetSession;
    ptrdiff_t GetInstance;
    ptrdiff_t GetIndication;
    ptrdiff_t GetClass;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_destinationoptionsft
struct MI_DestinationOptionsFT
{
    ptrdiff_t Delete;
    ptrdiff_t SetString;
    ptrdiff_t SetNumber;
    ptrdiff_t AddCredentials;
    ptrdiff_t GetString;
    ptrdiff_t GetNumber;
    ptrdiff_t GetOptionCount;
    ptrdiff_t GetOptionAt;
    ptrdiff_t GetOption;
    ptrdiff_t GetCredentialsCount;
    ptrdiff_t GetCredentialsAt;
    ptrdiff_t GetCredentialsPasswordAt;
    ptrdiff_t Clone;
    ptrdiff_t SetInterval;
    ptrdiff_t GetInterval;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_operationoptionsft
struct MI_OperationOptionsFT
{
    ptrdiff_t Delete;
    ptrdiff_t SetString;
    ptrdiff_t SetNumber;
    ptrdiff_t SetCustomOption;
    ptrdiff_t GetString;
    ptrdiff_t GetNumber;
    ptrdiff_t GetOptionCount;
    ptrdiff_t GetOptionAt;
    ptrdiff_t GetOption;
    ptrdiff_t GetEnabledChannels;
    ptrdiff_t Clone;
    ptrdiff_t SetInterval;
    ptrdiff_t GetInterval;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_application
struct MI_Application
{
    ulong     reserved1;
    ptrdiff_t reserved2;
    const(MI_ApplicationFT)* ft;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_session
struct MI_Session
{
    ulong                reserved1;
    ptrdiff_t            reserved2;
    const(MI_SessionFT)* ft;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_operation
struct MI_Operation
{
    ulong     reserved1;
    ptrdiff_t reserved2;
    const(MI_OperationFT)* ft;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_hostedprovider
struct MI_HostedProvider
{
    ulong     reserved1;
    ptrdiff_t reserved2;
    const(MI_HostedProviderFT)* ft;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_destinationoptions
struct MI_DestinationOptions
{
    ulong     reserved1;
    ptrdiff_t reserved2;
    const(MI_DestinationOptionsFT)* ft;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_operationoptions
struct MI_OperationOptions
{
    ulong     reserved1;
    ptrdiff_t reserved2;
    const(MI_OperationOptionsFT)* ft;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_utilitiesft
struct MI_UtilitiesFT
{
    ptrdiff_t MapErrorToMiErrorCategory;
    ptrdiff_t CimErrorFromErrorCode;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mi/ns-mi-mi_clientft_v1
struct MI_ClientFT_V1
{
    const(MI_ApplicationFT)* applicationFT;
    const(MI_SessionFT)* sessionFT;
    const(MI_OperationFT)* operationFT;
    const(MI_HostedProviderFT)* hostedProviderFT;
    const(MI_SerializerFT)* serializerFT;
    const(MI_DeserializerFT)* deserializerFT;
    const(MI_SubscriptionDeliveryOptionsFT)* subscribeDeliveryOptionsFT;
    const(MI_DestinationOptionsFT)* destinationOptionsFT;
    const(MI_OperationOptionsFT)* operationOptionsFT;
    const(MI_UtilitiesFT)* utilitiesFT;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/ns-wmiutils-swbemqueryqualifiedname
struct SWbemQueryQualifiedName
{
    uint          m_uVersion;
    uint          m_uTokenType;
    uint          m_uNameListSize;
    const(PWSTR)* m_ppszNameList;
    BOOL          m_bArraysUsed;
    BOOL*         m_pbArrayElUsed;
    uint*         m_puArrayIndex;
}

union SWbemRpnConst
{
    const(PWSTR) m_pszStrVal;
    BOOL         m_bBoolVal;
    int          m_lLongVal;
    uint         m_uLongVal;
    double       m_dblVal;
    long         m_lVal64;
    long         m_uVal64;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/ns-wmiutils-swbemrpnquerytoken
struct SWbemRpnQueryToken
{
    uint          m_uVersion;
    uint          m_uTokenType;
    uint          m_uSubexpressionShape;
    uint          m_uOperator;
    SWbemQueryQualifiedName* m_pRightIdent;
    SWbemQueryQualifiedName* m_pLeftIdent;
    uint          m_uConstApparentType;
    SWbemRpnConst m_Const;
    uint          m_uConst2ApparentType;
    SWbemRpnConst m_Const2;
    const(PWSTR)  m_pszRightFunc;
    const(PWSTR)  m_pszLeftFunc;
}

struct SWbemRpnTokenList
{
    uint m_uVersion;
    uint m_uTokenType;
    uint m_uNumTokens;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/ns-wmiutils-swbemrpnencodedquery
struct SWbemRpnEncodedQuery
{
    uint                 m_uVersion;
    uint                 m_uTokenType;
    ulong                m_uParsedFeatureMask;
    uint                 m_uDetectedArraySize;
    uint*                m_puDetectedFeatures;
    uint                 m_uSelectListSize;
    SWbemQueryQualifiedName** m_ppSelectList;
    uint                 m_uFromTargetType;
    const(PWSTR)         m_pszOptionalFromPath;
    uint                 m_uFromListSize;
    const(PWSTR)*        m_ppszFromList;
    uint                 m_uWhereClauseSize;
    SWbemRpnQueryToken** m_ppRpnWhereClause;
    double               m_dblWithinPolling;
    double               m_dblWithinWindow;
    uint                 m_uOrderByListSize;
    const(PWSTR)*        m_ppszOrderByList;
    uint*                m_uOrderDirectionEl;
}

struct SWbemAnalysisMatrix
{
    uint         m_uVersion;
    uint         m_uMatrixType;
    const(PWSTR) m_pszProperty;
    uint         m_uPropertyType;
    uint         m_uEntries;
    void**       m_pValues;
    BOOL*        m_pbTruthTable;
}

struct SWbemAnalysisMatrixList
{
    uint                 m_uVersion;
    uint                 m_uMatrixType;
    uint                 m_uNumMatrices;
    SWbemAnalysisMatrix* m_pMatrices;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/ns-wmiutils-swbemassocqueryinf
struct SWbemAssocQueryInf
{
    uint      m_uVersion;
    uint      m_uAnalysisType;
    uint      m_uFeatureMask;
    IWbemPath m_pPath;
    PWSTR     m_pszPath;
    PWSTR     m_pszQueryText;
    PWSTR     m_pszResultClass;
    PWSTR     m_pszAssocClass;
    PWSTR     m_pszRole;
    PWSTR     m_pszResultRole;
    PWSTR     m_pszRequiredQualifier;
    PWSTR     m_pszRequiredAssocQualifier;
}

struct WBEM_COMPILE_STATUS_INFO
{
    int     lPhaseError;
    HRESULT hRes;
    int     ObjectNum;
    int     FirstLine;
    int     LastLine;
    uint    dwOutFlags;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("mi.dll")
MI_Result MI_Application_InitializeV1(uint flags, const(ushort)* applicationID, MI_Instance** extendedError, 
                                      MI_Application* application);


// Interfaces

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/nn-wmiutils-iwbempath
@GUID("cf4cc405-e2c5-4ddd-b3ce-5e7582d8c9fa")
struct WbemDefPath;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/nn-wmiutils-iwbemquery
@GUID("eac8a024-21e2-4523-ad73-a71a0aa2f56a")
struct WbemQuery;

@GUID("4590f811-1d3a-11d0-891f-00aa004b2e24")
struct WbemLocator;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nn-wbemcli-iwbemcontext
@GUID("674b6698-ee92-11d0-ad71-00c04fd8fdff")
struct WbemContext;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nn-wbemcli-iunsecuredapartment
@GUID("49bd2028-1523-11d1-ad79-00c04fd8fdff")
struct UnsecuredApartment;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nn-wbemcli-iwbemclassobject
@GUID("9a653086-174f-11d2-b5f9-00104b703efd")
struct WbemClassObject;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nn-wbemcli-imofcompiler
@GUID("6daf9757-2e37-11d2-aec9-00c04fb68820")
struct MofCompiler;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nn-wbemcli-iwbemstatuscodetext
@GUID("eb87e1bd-3233-11d2-aec9-00c04fb68820")
struct WbemStatusCodeText;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nn-wbemcli-iwbembackuprestore
@GUID("c49e32c6-bc8b-11d2-85d4-00105a1f8304")
struct WbemBackupRestore;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nn-wbemcli-iwbemrefresher
@GUID("c71566f2-561e-11d1-ad87-00c04fd8fdff")
struct WbemRefresher;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nn-wbemcli-iwbemobjecttextsrc
@GUID("8d1c559d-84f0-4bb3-a7d5-56a7435a9ba6")
struct WbemObjectTextSrc;

@GUID("cb8555cc-9128-11d1-ad9b-00c04fd8fdff")
struct WbemAdministrativeLocator;

@GUID("cd184336-9128-11d1-ad9b-00c04fd8fdff")
struct WbemAuthenticatedLocator;

@GUID("443e7b79-de31-11d2-b340-00104bcc4b4a")
struct WbemUnauthenticatedLocator;

@GUID("4cfc7932-0f9d-4bef-9c32-8ea2a6b56fcb")
struct WbemDecoupledRegistrar;

@GUID("f5f75737-2843-4f22-933d-c76a97cda62f")
struct WbemDecoupledBasicEventProvider;

@GUID("76a64158-cb41-11d1-8b02-00600806d9b6")
struct SWbemLocator;

@GUID("9aed384e-ce8b-11d1-8b05-00600806d9b6")
struct SWbemNamedValueSet;

@GUID("5791bc26-ce9c-11d1-97bf-0000f81e849c")
struct SWbemObjectPath;

@GUID("c2feeeac-cfcd-11d1-8b05-00600806d9b6")
struct SWbemLastError;

@GUID("75718c9a-f029-11d1-a1ac-00c04fb6c223")
struct SWbemSink;

@GUID("47dfbe54-cf76-11d3-b38f-00105a1f473a")
struct SWbemDateTime;

@GUID("d269bf5c-d9c1-11d3-b38f-00105a1f473a")
struct SWbemRefresher;

@GUID("04b83d63-21ae-11d2-8b33-00600806d9b6")
struct SWbemServices;

@GUID("62e522dc-8cf3-40a8-8b2e-37d595651e40")
struct SWbemServicesEx;

@GUID("04b83d62-21ae-11d2-8b33-00600806d9b6")
struct SWbemObject;

@GUID("d6bdafb2-9435-491f-bb87-6aa0f0bc31a2")
struct SWbemObjectEx;

@GUID("04b83d61-21ae-11d2-8b33-00600806d9b6")
struct SWbemObjectSet;

@GUID("04b83d60-21ae-11d2-8b33-00600806d9b6")
struct SWbemNamedValue;

@GUID("04b83d5f-21ae-11d2-8b33-00600806d9b6")
struct SWbemQualifier;

@GUID("04b83d5e-21ae-11d2-8b33-00600806d9b6")
struct SWbemQualifierSet;

@GUID("04b83d5d-21ae-11d2-8b33-00600806d9b6")
struct SWbemProperty;

@GUID("04b83d5c-21ae-11d2-8b33-00600806d9b6")
struct SWbemPropertySet;

@GUID("04b83d5b-21ae-11d2-8b33-00600806d9b6")
struct SWbemMethod;

@GUID("04b83d5a-21ae-11d2-8b33-00600806d9b6")
struct SWbemMethodSet;

@GUID("04b83d58-21ae-11d2-8b33-00600806d9b6")
struct SWbemEventSource;

@GUID("b54d66e9-2287-11d2-8b33-00600806d9b6")
struct SWbemSecurity;

@GUID("26ee67bc-5804-11d2-8b4a-00600806d9b6")
struct SWbemPrivilege;

@GUID("26ee67be-5804-11d2-8b4a-00600806d9b6")
struct SWbemPrivilegeSet;

@GUID("8c6854bc-de4b-11d3-b390-00105a1f473a")
struct SWbemRefreshableItem;

@GUID("f0975afe-5c7f-11d2-8b74-00104b2afb41")
struct WMIExtension;

@GUID("8bc3f05e-d86b-11d0-a075-00c04fb68820")
struct WbemLevel1Login;

@GUID("a1044801-8f7e-11d1-9e7c-00c04fc324a8")
struct WbemLocalAddrRes;

@GUID("7a0227f6-7108-11d1-ad90-00c04fd8fdff")
struct WbemUninitializedClassObject;

@GUID("f7ce2e13-8c90-11d1-9e7b-00c04fc324a8")
struct WbemDCOMTransport;

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/nn-wmiutils-iwbempathkeylist
@GUID("9ae62877-7544-4bb0-aa26-a13824659ed6")
interface IWbemPathKeyList : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/nf-wmiutils-iwbempathkeylist-getcount
    HRESULT GetCount(uint* puKeyCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/nf-wmiutils-iwbempathkeylist-setkey
    HRESULT SetKey(const(PWSTR) wszName, uint uFlags, uint uCimType, void* pKeyVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/nf-wmiutils-iwbempathkeylist-setkey2
    HRESULT SetKey2(const(PWSTR) wszName, uint uFlags, uint uCimType, VARIANT* pKeyVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/nf-wmiutils-iwbempathkeylist-getkey
    HRESULT GetKey(uint uKeyIx, uint uFlags, uint* puNameBufSize, PWSTR pszKeyName, uint* puKeyValBufSize, 
                   void* pKeyVal, uint* puApparentCimType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/nf-wmiutils-iwbempathkeylist-getkey2
    HRESULT GetKey2(uint uKeyIx, uint uFlags, uint* puNameBufSize, PWSTR pszKeyName, VARIANT* pKeyValue, 
                    uint* puApparentCimType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/nf-wmiutils-iwbempathkeylist-removekey
    HRESULT RemoveKey(const(PWSTR) wszName, uint uFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/nf-wmiutils-iwbempathkeylist-removeallkeys
    HRESULT RemoveAllKeys(uint uFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/nf-wmiutils-iwbempathkeylist-makesingleton
    HRESULT MakeSingleton(ubyte bSet);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/nf-wmiutils-iwbempathkeylist-getinfo
    HRESULT GetInfo(uint uRequestedInfo, ulong* puResponse);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/nf-wmiutils-iwbempathkeylist-gettext
    HRESULT GetText(int lFlags, uint* puBuffLength, PWSTR pszText);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/nn-wmiutils-iwbempath
@GUID("3bc15af2-736c-477e-9e51-238af8667dcc")
interface IWbemPath : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/nf-wmiutils-iwbempath-settext
    HRESULT SetText(uint uMode, const(PWSTR) pszPath);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/nf-wmiutils-iwbempath-gettext
    HRESULT GetText(int lFlags, uint* puBuffLength, PWSTR pszText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/nf-wmiutils-iwbempath-getinfo
    HRESULT GetInfo(uint uRequestedInfo, ulong* puResponse);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/nf-wmiutils-iwbempath-setserver
    HRESULT SetServer(const(PWSTR) Name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/nf-wmiutils-iwbempath-getserver
    HRESULT GetServer(uint* puNameBufLength, PWSTR pName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/nf-wmiutils-iwbempath-getnamespacecount
    HRESULT GetNamespaceCount(uint* puCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/nf-wmiutils-iwbempath-setnamespaceat
    HRESULT SetNamespaceAt(uint uIndex, const(PWSTR) pszName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/nf-wmiutils-iwbempath-getnamespaceat
    HRESULT GetNamespaceAt(uint uIndex, uint* puNameBufLength, PWSTR pName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/nf-wmiutils-iwbempath-removenamespaceat
    HRESULT RemoveNamespaceAt(uint uIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/nf-wmiutils-iwbempath-removeallnamespaces
    HRESULT RemoveAllNamespaces();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/nf-wmiutils-iwbempath-getscopecount
    HRESULT GetScopeCount(uint* puCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/nf-wmiutils-iwbempath-setscope
    HRESULT SetScope(uint uIndex, PWSTR pszClass);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/nn-wmiutils-iwbempath
    HRESULT SetScopeFromText(uint uIndex, PWSTR pszText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/nf-wmiutils-iwbempath-getscope
    HRESULT GetScope(uint uIndex, uint* puClassNameBufSize, PWSTR pszClass, IWbemPathKeyList* pKeyList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/nf-wmiutils-iwbempath-getscopeastext
    HRESULT GetScopeAsText(uint uIndex, uint* puTextBufSize, PWSTR pszText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/nf-wmiutils-iwbempath-removescope
    HRESULT RemoveScope(uint uIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/nf-wmiutils-iwbempath-removeallscopes
    HRESULT RemoveAllScopes();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/nf-wmiutils-iwbempath-setclassname
    HRESULT SetClassName(const(PWSTR) Name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/nf-wmiutils-iwbempath-getclassname
    HRESULT GetClassName(uint* puBuffLength, PWSTR pszName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/nf-wmiutils-iwbempath-getkeylist
    HRESULT GetKeyList(IWbemPathKeyList* pOut);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/nf-wmiutils-iwbempath-createclasspart
    HRESULT CreateClassPart(int lFlags, const(PWSTR) Name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/nf-wmiutils-iwbempath-deleteclasspart
    HRESULT DeleteClassPart(int lFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/nf-wmiutils-iwbempath-isrelative
    BOOL    IsRelative(PWSTR wszMachine, PWSTR wszNamespace);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/nf-wmiutils-iwbempath-isrelativeorchild
    BOOL    IsRelativeOrChild(PWSTR wszMachine, PWSTR wszNamespace, int lFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/nf-wmiutils-iwbempath-islocal
    BOOL    IsLocal(const(PWSTR) wszMachine);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/nf-wmiutils-iwbempath-issameclassname
    BOOL    IsSameClassName(const(PWSTR) wszClass);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/nn-wmiutils-iwbemquery
@GUID("81166f58-dd98-11d3-a120-00105a1f515a")
interface IWbemQuery : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/nf-wmiutils-iwbemquery-empty
    HRESULT Empty();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/nn-wmiutils-iwbemquery
    HRESULT SetLanguageFeatures(uint uFlags, uint uArraySize, uint* puFeatures);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/nn-wmiutils-iwbemquery
    HRESULT TestLanguageFeatures(uint uFlags, uint* uArraySize, uint* puFeatures);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/nf-wmiutils-iwbemquery-parse
    HRESULT Parse(const(PWSTR) pszLang, const(PWSTR) pszQuery, uint uFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/nf-wmiutils-iwbemquery-getanalysis
    HRESULT GetAnalysis(uint uAnalysisType, uint uFlags, void** pAnalysis);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/nf-wmiutils-iwbemquery-freememory
    HRESULT FreeMemory(void* pMem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmiutils/nn-wmiutils-iwbemquery
    HRESULT GetQueryInfo(uint uAnalysisType, uint uInfoId, uint uBufSize, void* pDestBuf);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nn-wbemcli-iwbemclassobject
@GUID("dc12a681-737f-11cf-884d-00aa004b2e24")
interface IWbemClassObject : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemclassobject-getqualifierset
    HRESULT GetQualifierSet(IWbemQualifierSet* ppQualSet);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemclassobject-get
    HRESULT Get(const(PWSTR) wszName, int lFlags, VARIANT* pVal, int* pType, int* plFlavor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemclassobject-put
    HRESULT Put(const(PWSTR) wszName, int lFlags, VARIANT* pVal, int Type);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemclassobject-delete
    HRESULT Delete(const(PWSTR) wszName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemclassobject-getnames
    HRESULT GetNames(const(PWSTR) wszQualifierName, WBEM_CONDITION_FLAG_TYPE lFlags, VARIANT* pQualifierVal, 
                     SAFEARRAY** pNames);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemclassobject-beginenumeration
    HRESULT BeginEnumeration(int lEnumFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemclassobject-next
    HRESULT Next(int lFlags, BSTR* strName, VARIANT* pVal, int* pType, int* plFlavor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemclassobject-endenumeration
    HRESULT EndEnumeration();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemclassobject-getpropertyqualifierset
    HRESULT GetPropertyQualifierSet(const(PWSTR) wszProperty, IWbemQualifierSet* ppQualSet);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemclassobject-clone
    HRESULT Clone(IWbemClassObject* ppCopy);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemclassobject-getobjecttext
    HRESULT GetObjectText(int lFlags, BSTR* pstrObjectText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemclassobject-spawnderivedclass
    HRESULT SpawnDerivedClass(int lFlags, IWbemClassObject* ppNewClass);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemclassobject-spawninstance
    HRESULT SpawnInstance(int lFlags, IWbemClassObject* ppNewInstance);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemclassobject-compareto
    HRESULT CompareTo(WBEM_COMPARISON_FLAG lFlags, IWbemClassObject pCompareTo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemclassobject-getpropertyorigin
    HRESULT GetPropertyOrigin(const(PWSTR) wszName, BSTR* pstrClassName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemclassobject-inheritsfrom
    HRESULT InheritsFrom(const(PWSTR) strAncestor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemclassobject-getmethod
    HRESULT GetMethod(const(PWSTR) wszName, int lFlags, IWbemClassObject* ppInSignature, 
                      IWbemClassObject* ppOutSignature);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemclassobject-putmethod
    HRESULT PutMethod(const(PWSTR) wszName, int lFlags, IWbemClassObject pInSignature, 
                      IWbemClassObject pOutSignature);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemclassobject-deletemethod
    HRESULT DeleteMethod(const(PWSTR) wszName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemclassobject-beginmethodenumeration
    HRESULT BeginMethodEnumeration(int lEnumFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemclassobject-nextmethod
    HRESULT NextMethod(int lFlags, BSTR* pstrName, IWbemClassObject* ppInSignature, 
                       IWbemClassObject* ppOutSignature);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemclassobject-endmethodenumeration
    HRESULT EndMethodEnumeration();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemclassobject-getmethodqualifierset
    HRESULT GetMethodQualifierSet(const(PWSTR) wszMethod, IWbemQualifierSet* ppQualSet);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemclassobject-getmethodorigin
    HRESULT GetMethodOrigin(const(PWSTR) wszMethodName, BSTR* pstrClassName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nn-wbemcli-iwbemobjectaccess
@GUID("49353c9a-516b-11d1-aea6-00c04fb68820")
interface IWbemObjectAccess : IWbemClassObject
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemobjectaccess-getpropertyhandle
    HRESULT GetPropertyHandle(const(PWSTR) wszPropertyName, int* pType, int* plHandle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemobjectaccess-writepropertyvalue
    HRESULT WritePropertyValue(int lHandle, int lNumBytes, const(ubyte)* aData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemobjectaccess-readpropertyvalue
    HRESULT ReadPropertyValue(int lHandle, int lBufferSize, int* plNumBytes, ubyte* aData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemobjectaccess-readdword
    HRESULT ReadDWORD(int lHandle, uint* pdw);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemobjectaccess-writedword
    HRESULT WriteDWORD(int lHandle, uint dw);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemobjectaccess-readqword
    HRESULT ReadQWORD(int lHandle, ulong* pqw);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemobjectaccess-writeqword
    HRESULT WriteQWORD(int lHandle, ulong pw);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemobjectaccess-getpropertyinfobyhandle
    HRESULT GetPropertyInfoByHandle(int lHandle, BSTR* pstrName, int* pType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemobjectaccess-lock
    HRESULT Lock(int lFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemobjectaccess-unlock
    HRESULT Unlock(int lFlags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nn-wbemcli-iwbemqualifierset
@GUID("dc12a680-737f-11cf-884d-00aa004b2e24")
interface IWbemQualifierSet : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemqualifierset-get
    HRESULT Get(const(PWSTR) wszName, int lFlags, VARIANT* pVal, int* plFlavor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemqualifierset-put
    HRESULT Put(const(PWSTR) wszName, VARIANT* pVal, int lFlavor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemqualifierset-delete
    HRESULT Delete(const(PWSTR) wszName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemqualifierset-getnames
    HRESULT GetNames(int lFlags, SAFEARRAY** pNames);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemqualifierset-beginenumeration
    HRESULT BeginEnumeration(int lFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemqualifierset-next
    HRESULT Next(int lFlags, BSTR* pstrName, VARIANT* pVal, int* plFlavor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemqualifierset-endenumeration
    HRESULT EndEnumeration();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nn-wbemcli-iwbemservices
@GUID("9556dc99-828c-11cf-a37e-00aa003240c7")
interface IWbemServices : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemservices-opennamespace
    HRESULT OpenNamespace(const(BSTR) strNamespace, WBEM_GENERIC_FLAG_TYPE lFlags, IWbemContext pCtx, 
                          IWbemServices* ppWorkingNamespace, IWbemCallResult* ppResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemservices-cancelasynccall
    HRESULT CancelAsyncCall(IWbemObjectSink pSink);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemservices-queryobjectsink
    HRESULT QueryObjectSink(WBEM_GENERIC_FLAG_TYPE lFlags, IWbemObjectSink* ppResponseHandler);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemservices-getobject
    HRESULT GetObject(const(BSTR) strObjectPath, WBEM_GENERIC_FLAG_TYPE lFlags, IWbemContext pCtx, 
                      IWbemClassObject* ppObject, IWbemCallResult* ppCallResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemservices-getobjectasync
    HRESULT GetObjectAsync(const(BSTR) strObjectPath, WBEM_GENERIC_FLAG_TYPE lFlags, IWbemContext pCtx, 
                           IWbemObjectSink pResponseHandler);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemservices-putclass
    HRESULT PutClass(IWbemClassObject pObject, WBEM_GENERIC_FLAG_TYPE lFlags, IWbemContext pCtx, 
                     IWbemCallResult* ppCallResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemservices-putclassasync
    HRESULT PutClassAsync(IWbemClassObject pObject, WBEM_GENERIC_FLAG_TYPE lFlags, IWbemContext pCtx, 
                          IWbemObjectSink pResponseHandler);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemservices-deleteclass
    HRESULT DeleteClass(const(BSTR) strClass, WBEM_GENERIC_FLAG_TYPE lFlags, IWbemContext pCtx, 
                        IWbemCallResult* ppCallResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemservices-deleteclassasync
    HRESULT DeleteClassAsync(const(BSTR) strClass, WBEM_GENERIC_FLAG_TYPE lFlags, IWbemContext pCtx, 
                             IWbemObjectSink pResponseHandler);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemservices-createclassenum
    HRESULT CreateClassEnum(const(BSTR) strSuperclass, WBEM_GENERIC_FLAG_TYPE lFlags, IWbemContext pCtx, 
                            IEnumWbemClassObject* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemservices-createclassenumasync
    HRESULT CreateClassEnumAsync(const(BSTR) strSuperclass, WBEM_GENERIC_FLAG_TYPE lFlags, IWbemContext pCtx, 
                                 IWbemObjectSink pResponseHandler);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemservices-putinstance
    HRESULT PutInstance(IWbemClassObject pInst, WBEM_GENERIC_FLAG_TYPE lFlags, IWbemContext pCtx, 
                        IWbemCallResult* ppCallResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemservices-putinstanceasync
    HRESULT PutInstanceAsync(IWbemClassObject pInst, WBEM_GENERIC_FLAG_TYPE lFlags, IWbemContext pCtx, 
                             IWbemObjectSink pResponseHandler);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemservices-deleteinstance
    HRESULT DeleteInstance(const(BSTR) strObjectPath, WBEM_GENERIC_FLAG_TYPE lFlags, IWbemContext pCtx, 
                           IWbemCallResult* ppCallResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemservices-deleteinstanceasync
    HRESULT DeleteInstanceAsync(const(BSTR) strObjectPath, WBEM_GENERIC_FLAG_TYPE lFlags, IWbemContext pCtx, 
                                IWbemObjectSink pResponseHandler);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemservices-createinstanceenum
    HRESULT CreateInstanceEnum(const(BSTR) strFilter, WBEM_GENERIC_FLAG_TYPE lFlags, IWbemContext pCtx, 
                               IEnumWbemClassObject* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemservices-createinstanceenumasync
    HRESULT CreateInstanceEnumAsync(const(BSTR) strFilter, WBEM_GENERIC_FLAG_TYPE lFlags, IWbemContext pCtx, 
                                    IWbemObjectSink pResponseHandler);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemservices-execquery
    HRESULT ExecQuery(const(BSTR) strQueryLanguage, const(BSTR) strQuery, WBEM_GENERIC_FLAG_TYPE lFlags, 
                      IWbemContext pCtx, IEnumWbemClassObject* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemservices-execqueryasync
    HRESULT ExecQueryAsync(const(BSTR) strQueryLanguage, const(BSTR) strQuery, WBEM_GENERIC_FLAG_TYPE lFlags, 
                           IWbemContext pCtx, IWbemObjectSink pResponseHandler);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemservices-execnotificationquery
    HRESULT ExecNotificationQuery(const(BSTR) strQueryLanguage, const(BSTR) strQuery, 
                                  WBEM_GENERIC_FLAG_TYPE lFlags, IWbemContext pCtx, IEnumWbemClassObject* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemservices-execnotificationqueryasync
    HRESULT ExecNotificationQueryAsync(const(BSTR) strQueryLanguage, const(BSTR) strQuery, 
                                       WBEM_GENERIC_FLAG_TYPE lFlags, IWbemContext pCtx, 
                                       IWbemObjectSink pResponseHandler);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemservices-execmethod
    HRESULT ExecMethod(const(BSTR) strObjectPath, const(BSTR) strMethodName, WBEM_GENERIC_FLAG_TYPE lFlags, 
                       IWbemContext pCtx, IWbemClassObject pInParams, IWbemClassObject* ppOutParams, 
                       IWbemCallResult* ppCallResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemservices-execmethodasync
    HRESULT ExecMethodAsync(const(BSTR) strObjectPath, const(BSTR) strMethodName, WBEM_GENERIC_FLAG_TYPE lFlags, 
                            IWbemContext pCtx, IWbemClassObject pInParams, IWbemObjectSink pResponseHandler);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nn-wbemcli-iwbemlocator
@GUID("dc12a687-737f-11cf-884d-00aa004b2e24")
interface IWbemLocator : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemlocator-connectserver
    HRESULT ConnectServer(const(BSTR) strNetworkResource, const(BSTR) strUser, const(BSTR) strPassword, 
                          const(BSTR) strLocale, int lSecurityFlags, const(BSTR) strAuthority, IWbemContext pCtx, 
                          IWbemServices* ppNamespace);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nn-wbemcli-iwbemobjectsink
@GUID("7c857801-7381-11cf-884d-00aa004b2e24")
interface IWbemObjectSink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemobjectsink-indicate
    HRESULT Indicate(int lObjectCount, IWbemClassObject* apObjArray);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemobjectsink-setstatus
    HRESULT SetStatus(int lFlags, HRESULT hResult, BSTR strParam, IWbemClassObject pObjParam);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nn-wbemcli-ienumwbemclassobject
@GUID("027947e1-d731-11ce-a357-000000000001")
interface IEnumWbemClassObject : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-ienumwbemclassobject-reset
    HRESULT Reset();
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT Next(int lTimeout, uint uCount, IWbemClassObject* apObjects, uint* puReturned);
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT NextAsync(uint uCount, IWbemObjectSink pSink);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-ienumwbemclassobject-clone
    HRESULT Clone(IEnumWbemClassObject* ppEnum);
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT Skip(int lTimeout, uint nCount);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nn-wbemcli-iwbemcallresult
@GUID("44aca675-e8fc-11d0-a07c-00c04fb68820")
interface IWbemCallResult : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemcallresult-getresultobject
    HRESULT GetResultObject(int lTimeout, IWbemClassObject* ppResultObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemcallresult-getresultstring
    HRESULT GetResultString(int lTimeout, BSTR* pstrResultString);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemcallresult-getresultservices
    HRESULT GetResultServices(int lTimeout, IWbemServices* ppServices);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemcallresult-getcallstatus
    HRESULT GetCallStatus(int lTimeout, int* plStatus);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nn-wbemcli-iwbemcontext
@GUID("44aca674-e8fc-11d0-a07c-00c04fb68820")
interface IWbemContext : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemcontext-clone
    HRESULT Clone(IWbemContext* ppNewCopy);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemcontext-getnames
    HRESULT GetNames(int lFlags, SAFEARRAY** pNames);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemcontext-beginenumeration
    HRESULT BeginEnumeration(int lFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemcontext-next
    HRESULT Next(int lFlags, BSTR* pstrName, VARIANT* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemcontext-endenumeration
    HRESULT EndEnumeration();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemcontext-setvalue
    HRESULT SetValue(const(PWSTR) wszName, int lFlags, VARIANT* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemcontext-getvalue
    HRESULT GetValue(const(PWSTR) wszName, int lFlags, VARIANT* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemcontext-deletevalue
    HRESULT DeleteValue(const(PWSTR) wszName, int lFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemcontext-deleteall
    HRESULT DeleteAll();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nn-wbemcli-iunsecuredapartment
@GUID("1cfaba8c-1523-11d1-ad79-00c04fd8fdff")
interface IUnsecuredApartment : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iunsecuredapartment-createobjectstub
    HRESULT CreateObjectStub(IUnknown pObject, IUnknown* ppStub);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nn-wbemcli-iwbemunsecuredapartment
@GUID("31739d04-3471-4cf4-9a7c-57a44ae71956")
interface IWbemUnsecuredApartment : IUnsecuredApartment
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemunsecuredapartment-createsinkstub
    HRESULT CreateSinkStub(IWbemObjectSink pSink, uint dwFlags, const(PWSTR) wszReserved, IWbemObjectSink* ppStub);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nn-wbemcli-iwbemstatuscodetext
@GUID("eb87e1bc-3233-11d2-aec9-00c04fb68820")
interface IWbemStatusCodeText : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemstatuscodetext-geterrorcodetext
    HRESULT GetErrorCodeText(HRESULT hRes, uint LocaleId, int lFlags, BSTR* MessageText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemstatuscodetext-getfacilitycodetext
    HRESULT GetFacilityCodeText(HRESULT hRes, uint LocaleId, int lFlags, BSTR* MessageText);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nn-wbemcli-iwbembackuprestore
@GUID("c49e32c7-bc8b-11d2-85d4-00105a1f8304")
interface IWbemBackupRestore : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbembackuprestore-backup
    HRESULT Backup(const(PWSTR) strBackupToFile, int lFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbembackuprestore-restore
    HRESULT Restore(const(PWSTR) strRestoreFromFile, int lFlags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nn-wbemcli-iwbembackuprestoreex
@GUID("a359dec5-e813-4834-8a2a-ba7f1d777d76")
interface IWbemBackupRestoreEx : IWbemBackupRestore
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbembackuprestoreex-pause
    HRESULT Pause();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbembackuprestoreex-resume
    HRESULT Resume();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nn-wbemcli-iwbemrefresher
@GUID("49353c99-516b-11d1-aea6-00c04fb68820")
interface IWbemRefresher : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemrefresher-refresh
    HRESULT Refresh(int lFlags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nn-wbemcli-iwbemhiperfenum
@GUID("2705c288-79ae-11d2-b348-00105a1f8177")
interface IWbemHiPerfEnum : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemhiperfenum-addobjects
    HRESULT AddObjects(int lFlags, uint uNumObjects, int* apIds, IWbemObjectAccess* apObj);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemhiperfenum-removeobjects
    HRESULT RemoveObjects(int lFlags, uint uNumObjects, int* apIds);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemhiperfenum-getobjects
    HRESULT GetObjects(int lFlags, uint uNumObjects, IWbemObjectAccess* apObj, uint* puReturned);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemhiperfenum-removeall
    HRESULT RemoveAll(int lFlags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nn-wbemcli-iwbemconfigurerefresher
@GUID("49353c92-516b-11d1-aea6-00c04fb68820")
interface IWbemConfigureRefresher : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemconfigurerefresher-addobjectbypath
    HRESULT AddObjectByPath(IWbemServices pNamespace, const(PWSTR) wszPath, int lFlags, IWbemContext pContext, 
                            IWbemClassObject* ppRefreshable, int* plId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemconfigurerefresher-addobjectbytemplate
    HRESULT AddObjectByTemplate(IWbemServices pNamespace, IWbemClassObject pTemplate, int lFlags, 
                                IWbemContext pContext, IWbemClassObject* ppRefreshable, int* plId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemconfigurerefresher-addrefresher
    HRESULT AddRefresher(IWbemRefresher pRefresher, int lFlags, int* plId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemconfigurerefresher-remove
    HRESULT Remove(int lId, int lFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemconfigurerefresher-addenum
    HRESULT AddEnum(IWbemServices pNamespace, const(PWSTR) wszClassName, int lFlags, IWbemContext pContext, 
                    IWbemHiPerfEnum* ppEnum, int* plId);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@GUID("e7d35cfa-348b-485e-b524-252725d697ca")
interface IWbemObjectSinkEx : IWbemObjectSink
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemobjectsinkex-writemessage
    HRESULT WriteMessage(uint uChannel, const(BSTR) strMessage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemobjectsinkex-writeerror
    HRESULT WriteError(IWbemClassObject pObjError, ubyte* puReturned);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemobjectsinkex-promptuser
    HRESULT PromptUser(const(BSTR) strMessage, ubyte uPromptType, ubyte* puReturned);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemobjectsinkex-writeprogress
    HRESULT WriteProgress(const(BSTR) strActivity, const(BSTR) strCurrentOperation, 
                          const(BSTR) strStatusDescription, uint uPercentComplete, uint uSecondsRemaining);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemobjectsinkex-writestreamparameter
    HRESULT WriteStreamParameter(const(BSTR) strName, VARIANT* vtValue, uint ulType, uint ulFlags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nn-wbemcli-iwbemshutdown
@GUID("b7b31df9-d515-11d3-a11c-00105a1f515a")
interface IWbemShutdown : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemshutdown-shutdown
    HRESULT Shutdown(int uReason, uint uMaxMilliseconds, IWbemContext pCtx);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nn-wbemcli-iwbemobjecttextsrc
@GUID("bfbf883a-cad7-11d3-a11b-00105a1f515a")
interface IWbemObjectTextSrc : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-iwbemobjecttextsrc-gettext
    HRESULT GetText(int lFlags, IWbemClassObject pObj, uint uObjTextFormat, IWbemContext pCtx, BSTR* strText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nn-wbemcli-iwbemobjecttextsrc
    HRESULT CreateFromText(int lFlags, BSTR strText, uint uObjTextFormat, IWbemContext pCtx, 
                           IWbemClassObject* pNewObj);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nn-wbemcli-imofcompiler
@GUID("6daf974e-2e37-11d2-aec9-00c04fb68820")
interface IMofCompiler : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-imofcompiler-compilefile
    HRESULT CompileFile(PWSTR FileName, PWSTR ServerAndNamespace, PWSTR User, PWSTR Authority, PWSTR Password, 
                        int lOptionFlags, int lClassFlags, int lInstanceFlags, WBEM_COMPILE_STATUS_INFO* pInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-imofcompiler-compilebuffer
    HRESULT CompileBuffer(int BuffSize, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/ubyte* pBuffer, 
                          PWSTR ServerAndNamespace, PWSTR User, PWSTR Authority, PWSTR Password, int lOptionFlags, 
                          int lClassFlags, int lInstanceFlags, WBEM_COMPILE_STATUS_INFO* pInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemcli/nf-wbemcli-imofcompiler-createbmof
    HRESULT CreateBMOF(PWSTR TextFileName, PWSTR BMOFFileName, PWSTR ServerAndNamespace, int lOptionFlags, 
                       int lClassFlags, int lInstanceFlags, WBEM_COMPILE_STATUS_INFO* pInfo);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemprov/nn-wbemprov-iwbempropertyprovider
@GUID("ce61e841-65bc-11d0-b6bd-00aa003240c7")
interface IWbemPropertyProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemprov/nf-wbemprov-iwbempropertyprovider-getproperty
    HRESULT GetProperty(int lFlags, const(BSTR) strLocale, const(BSTR) strClassMapping, const(BSTR) strInstMapping, 
                        const(BSTR) strPropMapping, VARIANT* pvValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemprov/nf-wbemprov-iwbempropertyprovider-putproperty
    HRESULT PutProperty(int lFlags, const(BSTR) strLocale, const(BSTR) strClassMapping, const(BSTR) strInstMapping, 
                        const(BSTR) strPropMapping, const(VARIANT)* pvValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemprov/nn-wbemprov-iwbemunboundobjectsink
@GUID("e246107b-b06e-11d0-ad61-00c04fd8fdff")
interface IWbemUnboundObjectSink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemprov/nf-wbemprov-iwbemunboundobjectsink-indicatetoconsumer
    HRESULT IndicateToConsumer(IWbemClassObject pLogicalConsumer, int lNumObjects, IWbemClassObject* apObjects);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemprov/nn-wbemprov-iwbemeventprovider
@GUID("e245105b-b06e-11d0-ad61-00c04fd8fdff")
interface IWbemEventProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemprov/nf-wbemprov-iwbemeventprovider-provideevents
    HRESULT ProvideEvents(IWbemObjectSink pSink, int lFlags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemprov/nn-wbemprov-iwbemeventproviderquerysink
@GUID("580acaf8-fa1c-11d0-ad72-00c04fd8fdff")
interface IWbemEventProviderQuerySink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemprov/nf-wbemprov-iwbemeventproviderquerysink-newquery
    HRESULT NewQuery(uint dwId, ushort* wszQueryLanguage, ushort* wszQuery);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemprov/nf-wbemprov-iwbemeventproviderquerysink-cancelquery
    HRESULT CancelQuery(uint dwId);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemprov/nn-wbemprov-iwbemeventprovidersecurity
@GUID("631f7d96-d993-11d2-b339-00105a1f4aaf")
interface IWbemEventProviderSecurity : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemprov/nf-wbemprov-iwbemeventprovidersecurity-accesscheck
    HRESULT AccessCheck(ushort* wszQueryLanguage, ushort* wszQuery, int lSidLength, const(ubyte)* pSid);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemprov/nn-wbemprov-iwbemeventconsumerprovider
@GUID("e246107a-b06e-11d0-ad61-00c04fd8fdff")
interface IWbemEventConsumerProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemprov/nf-wbemprov-iwbemeventconsumerprovider-findconsumer
    HRESULT FindConsumer(IWbemClassObject pLogicalConsumer, IWbemUnboundObjectSink* ppConsumer);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemprov/nn-wbemprov-iwbemproviderinitsink
@GUID("1be41571-91dd-11d1-aeb2-00c04fb68820")
interface IWbemProviderInitSink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemprov/nf-wbemprov-iwbemproviderinitsink-setstatus
    HRESULT SetStatus(int lStatus, int lFlags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemprov/nn-wbemprov-iwbemproviderinit
@GUID("1be41572-91dd-11d1-aeb2-00c04fb68820")
interface IWbemProviderInit : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemprov/nf-wbemprov-iwbemproviderinit-initialize
    HRESULT Initialize(PWSTR wszUser, int lFlags, PWSTR wszNamespace, PWSTR wszLocale, IWbemServices pNamespace, 
                       IWbemContext pCtx, IWbemProviderInitSink pInitSink);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemprov/nn-wbemprov-iwbemhiperfprovider
@GUID("49353c93-516b-11d1-aea6-00c04fb68820")
interface IWbemHiPerfProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemprov/nf-wbemprov-iwbemhiperfprovider-queryinstances
    HRESULT QueryInstances(IWbemServices pNamespace, PWSTR wszClass, int lFlags, IWbemContext pCtx, 
                           IWbemObjectSink pSink);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemprov/nf-wbemprov-iwbemhiperfprovider-createrefresher
    HRESULT CreateRefresher(IWbemServices pNamespace, int lFlags, IWbemRefresher* ppRefresher);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemprov/nf-wbemprov-iwbemhiperfprovider-createrefreshableobject
    HRESULT CreateRefreshableObject(IWbemServices pNamespace, IWbemObjectAccess pTemplate, 
                                    IWbemRefresher pRefresher, int lFlags, IWbemContext pContext, 
                                    IWbemObjectAccess* ppRefreshable, int* plId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemprov/nf-wbemprov-iwbemhiperfprovider-stoprefreshing
    HRESULT StopRefreshing(IWbemRefresher pRefresher, int lId, int lFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemprov/nf-wbemprov-iwbemhiperfprovider-createrefreshableenum
    HRESULT CreateRefreshableEnum(IWbemServices pNamespace, const(PWSTR) wszClass, IWbemRefresher pRefresher, 
                                  int lFlags, IWbemContext pContext, IWbemHiPerfEnum pHiPerfEnum, int* plId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemprov/nf-wbemprov-iwbemhiperfprovider-getobjects
    HRESULT GetObjects(IWbemServices pNamespace, int lNumObjects, IWbemObjectAccess* apObj, int lFlags, 
                       IWbemContext pContext);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemprov/nn-wbemprov-iwbemdecoupledregistrar
@GUID("1005cbcf-e64f-4646-bcd3-3a089d8a84b4")
interface IWbemDecoupledRegistrar : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemprov/nf-wbemprov-iwbemdecoupledregistrar-register
    HRESULT Register(int a_Flags, IWbemContext a_Context, const(PWSTR) a_User, const(PWSTR) a_Locale, 
                     const(PWSTR) a_Scope, const(PWSTR) a_Registration, IUnknown pIUnknown);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemprov/nf-wbemprov-iwbemdecoupledregistrar-unregister
    HRESULT UnRegister();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemprov/nn-wbemprov-iwbemprovideridentity
@GUID("631f7d97-d993-11d2-b339-00105a1f4aaf")
interface IWbemProviderIdentity : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemprov/nf-wbemprov-iwbemprovideridentity-setregistrationobject
    HRESULT SetRegistrationObject(int lFlags, IWbemClassObject pProvReg);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemprov/nn-wbemprov-iwbemdecoupledbasiceventprovider
@GUID("86336d20-ca11-4786-9ef1-bc8a946b42fc")
interface IWbemDecoupledBasicEventProvider : IWbemDecoupledRegistrar
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemprov/nf-wbemprov-iwbemdecoupledbasiceventprovider-getsink
    HRESULT GetSink(int a_Flags, IWbemContext a_Context, IWbemObjectSink* a_Sink);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemprov/nf-wbemprov-iwbemdecoupledbasiceventprovider-getservice
    HRESULT GetService(int a_Flags, IWbemContext a_Context, IWbemServices* a_Service);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemprov/nn-wbemprov-iwbemeventsink
@GUID("3ae0080a-7e3a-4366-bf89-0feedc931659")
interface IWbemEventSink : IWbemObjectSink
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemprov/nf-wbemprov-iwbemeventsink-setsinksecurity
    HRESULT SetSinkSecurity(int lSDLength, ubyte* pSD);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemprov/nf-wbemprov-iwbemeventsink-isactive
    HRESULT IsActive();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemprov/nf-wbemprov-iwbemeventsink-getrestrictedsink
    HRESULT GetRestrictedSink(int lNumQueries, const(PWSTR)* awszQueries, IUnknown pCallback, 
                              IWbemEventSink* ppSink);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wbemprov/nf-wbemprov-iwbemeventsink-setbatchingparameters
    HRESULT SetBatchingParameters(int lFlags, uint dwMaxBufferSize, uint dwMaxSendLatency);
}

@GUID("76a6415c-cb41-11d1-8b02-00600806d9b6")
interface ISWbemServices : IDispatch
{
    HRESULT Get(BSTR strObjectPath, int iFlags, IDispatch objWbemNamedValueSet, ISWbemObject* objWbemObject);
    HRESULT GetAsync(IDispatch objWbemSink, BSTR strObjectPath, int iFlags, IDispatch objWbemNamedValueSet, 
                     IDispatch objWbemAsyncContext);
    HRESULT Delete(BSTR strObjectPath, int iFlags, IDispatch objWbemNamedValueSet);
    HRESULT DeleteAsync(IDispatch objWbemSink, BSTR strObjectPath, int iFlags, IDispatch objWbemNamedValueSet, 
                        IDispatch objWbemAsyncContext);
    HRESULT InstancesOf(BSTR strClass, int iFlags, IDispatch objWbemNamedValueSet, 
                        ISWbemObjectSet* objWbemObjectSet);
    HRESULT InstancesOfAsync(IDispatch objWbemSink, BSTR strClass, int iFlags, IDispatch objWbemNamedValueSet, 
                             IDispatch objWbemAsyncContext);
    HRESULT SubclassesOf(BSTR strSuperclass, int iFlags, IDispatch objWbemNamedValueSet, 
                         ISWbemObjectSet* objWbemObjectSet);
    HRESULT SubclassesOfAsync(IDispatch objWbemSink, BSTR strSuperclass, int iFlags, 
                              IDispatch objWbemNamedValueSet, IDispatch objWbemAsyncContext);
    HRESULT ExecQuery(BSTR strQuery, BSTR strQueryLanguage, int iFlags, IDispatch objWbemNamedValueSet, 
                      ISWbemObjectSet* objWbemObjectSet);
    HRESULT ExecQueryAsync(IDispatch objWbemSink, BSTR strQuery, BSTR strQueryLanguage, int lFlags, 
                           IDispatch objWbemNamedValueSet, IDispatch objWbemAsyncContext);
    HRESULT AssociatorsOf(BSTR strObjectPath, BSTR strAssocClass, BSTR strResultClass, BSTR strResultRole, 
                          BSTR strRole, VARIANT_BOOL bClassesOnly, VARIANT_BOOL bSchemaOnly, 
                          BSTR strRequiredAssocQualifier, BSTR strRequiredQualifier, int iFlags, 
                          IDispatch objWbemNamedValueSet, ISWbemObjectSet* objWbemObjectSet);
    HRESULT AssociatorsOfAsync(IDispatch objWbemSink, BSTR strObjectPath, BSTR strAssocClass, BSTR strResultClass, 
                               BSTR strResultRole, BSTR strRole, VARIANT_BOOL bClassesOnly, VARIANT_BOOL bSchemaOnly, 
                               BSTR strRequiredAssocQualifier, BSTR strRequiredQualifier, int iFlags, 
                               IDispatch objWbemNamedValueSet, IDispatch objWbemAsyncContext);
    HRESULT ReferencesTo(BSTR strObjectPath, BSTR strResultClass, BSTR strRole, VARIANT_BOOL bClassesOnly, 
                         VARIANT_BOOL bSchemaOnly, BSTR strRequiredQualifier, int iFlags, 
                         IDispatch objWbemNamedValueSet, ISWbemObjectSet* objWbemObjectSet);
    HRESULT ReferencesToAsync(IDispatch objWbemSink, BSTR strObjectPath, BSTR strResultClass, BSTR strRole, 
                              VARIANT_BOOL bClassesOnly, VARIANT_BOOL bSchemaOnly, BSTR strRequiredQualifier, 
                              int iFlags, IDispatch objWbemNamedValueSet, IDispatch objWbemAsyncContext);
    HRESULT ExecNotificationQuery(BSTR strQuery, BSTR strQueryLanguage, int iFlags, IDispatch objWbemNamedValueSet, 
                                  ISWbemEventSource* objWbemEventSource);
    HRESULT ExecNotificationQueryAsync(IDispatch objWbemSink, BSTR strQuery, BSTR strQueryLanguage, int iFlags, 
                                       IDispatch objWbemNamedValueSet, IDispatch objWbemAsyncContext);
    HRESULT ExecMethod(BSTR strObjectPath, BSTR strMethodName, IDispatch objWbemInParameters, int iFlags, 
                       IDispatch objWbemNamedValueSet, ISWbemObject* objWbemOutParameters);
    HRESULT ExecMethodAsync(IDispatch objWbemSink, BSTR strObjectPath, BSTR strMethodName, 
                            IDispatch objWbemInParameters, int iFlags, IDispatch objWbemNamedValueSet, 
                            IDispatch objWbemAsyncContext);
    HRESULT get_Security_(ISWbemSecurity* objWbemSecurity);
}

@GUID("76a6415b-cb41-11d1-8b02-00600806d9b6")
interface ISWbemLocator : IDispatch
{
    HRESULT ConnectServer(BSTR strServer, BSTR strNamespace, BSTR strUser, BSTR strPassword, BSTR strLocale, 
                          BSTR strAuthority, int iSecurityFlags, IDispatch objWbemNamedValueSet, 
                          ISWbemServices* objWbemServices);
    HRESULT get_Security_(ISWbemSecurity* objWbemSecurity);
}

@GUID("76a6415a-cb41-11d1-8b02-00600806d9b6")
interface ISWbemObject : IDispatch
{
    HRESULT Put_(int iFlags, IDispatch objWbemNamedValueSet, ISWbemObjectPath* objWbemObjectPath);
    HRESULT PutAsync_(IDispatch objWbemSink, int iFlags, IDispatch objWbemNamedValueSet, 
                      IDispatch objWbemAsyncContext);
    HRESULT Delete_(int iFlags, IDispatch objWbemNamedValueSet);
    HRESULT DeleteAsync_(IDispatch objWbemSink, int iFlags, IDispatch objWbemNamedValueSet, 
                         IDispatch objWbemAsyncContext);
    HRESULT Instances_(int iFlags, IDispatch objWbemNamedValueSet, ISWbemObjectSet* objWbemObjectSet);
    HRESULT InstancesAsync_(IDispatch objWbemSink, int iFlags, IDispatch objWbemNamedValueSet, 
                            IDispatch objWbemAsyncContext);
    HRESULT Subclasses_(int iFlags, IDispatch objWbemNamedValueSet, ISWbemObjectSet* objWbemObjectSet);
    HRESULT SubclassesAsync_(IDispatch objWbemSink, int iFlags, IDispatch objWbemNamedValueSet, 
                             IDispatch objWbemAsyncContext);
    HRESULT Associators_(BSTR strAssocClass, BSTR strResultClass, BSTR strResultRole, BSTR strRole, 
                         VARIANT_BOOL bClassesOnly, VARIANT_BOOL bSchemaOnly, BSTR strRequiredAssocQualifier, 
                         BSTR strRequiredQualifier, int iFlags, IDispatch objWbemNamedValueSet, 
                         ISWbemObjectSet* objWbemObjectSet);
    HRESULT AssociatorsAsync_(IDispatch objWbemSink, BSTR strAssocClass, BSTR strResultClass, BSTR strResultRole, 
                              BSTR strRole, VARIANT_BOOL bClassesOnly, VARIANT_BOOL bSchemaOnly, 
                              BSTR strRequiredAssocQualifier, BSTR strRequiredQualifier, int iFlags, 
                              IDispatch objWbemNamedValueSet, IDispatch objWbemAsyncContext);
    HRESULT References_(BSTR strResultClass, BSTR strRole, VARIANT_BOOL bClassesOnly, VARIANT_BOOL bSchemaOnly, 
                        BSTR strRequiredQualifier, int iFlags, IDispatch objWbemNamedValueSet, 
                        ISWbemObjectSet* objWbemObjectSet);
    HRESULT ReferencesAsync_(IDispatch objWbemSink, BSTR strResultClass, BSTR strRole, VARIANT_BOOL bClassesOnly, 
                             VARIANT_BOOL bSchemaOnly, BSTR strRequiredQualifier, int iFlags, 
                             IDispatch objWbemNamedValueSet, IDispatch objWbemAsyncContext);
    HRESULT ExecMethod_(BSTR strMethodName, IDispatch objWbemInParameters, int iFlags, 
                        IDispatch objWbemNamedValueSet, ISWbemObject* objWbemOutParameters);
    HRESULT ExecMethodAsync_(IDispatch objWbemSink, BSTR strMethodName, IDispatch objWbemInParameters, int iFlags, 
                             IDispatch objWbemNamedValueSet, IDispatch objWbemAsyncContext);
    HRESULT Clone_(ISWbemObject* objWbemObject);
    HRESULT GetObjectText_(int iFlags, BSTR* strObjectText);
    HRESULT SpawnDerivedClass_(int iFlags, ISWbemObject* objWbemObject);
    HRESULT SpawnInstance_(int iFlags, ISWbemObject* objWbemObject);
    HRESULT CompareTo_(IDispatch objWbemObject, int iFlags, VARIANT_BOOL* bResult);
    HRESULT get_Qualifiers_(ISWbemQualifierSet* objWbemQualifierSet);
    HRESULT get_Properties_(ISWbemPropertySet* objWbemPropertySet);
    HRESULT get_Methods_(ISWbemMethodSet* objWbemMethodSet);
    HRESULT get_Derivation_(VARIANT* strClassNameArray);
    HRESULT get_Path_(ISWbemObjectPath* objWbemObjectPath);
    HRESULT get_Security_(ISWbemSecurity* objWbemSecurity);
}

@GUID("76a6415f-cb41-11d1-8b02-00600806d9b6")
interface ISWbemObjectSet : IDispatch
{
    HRESULT get__NewEnum(IUnknown* pUnk);
    HRESULT Item(BSTR strObjectPath, int iFlags, ISWbemObject* objWbemObject);
    HRESULT get_Count(int* iCount);
    HRESULT get_Security_(ISWbemSecurity* objWbemSecurity);
    HRESULT ItemIndex(int lIndex, ISWbemObject* objWbemObject);
}

@GUID("76a64164-cb41-11d1-8b02-00600806d9b6")
interface ISWbemNamedValue : IDispatch
{
    HRESULT get_Value(VARIANT* varValue);
    HRESULT put_Value(VARIANT* varValue);
    HRESULT get_Name(BSTR* strName);
}

@GUID("cf2376ea-ce8c-11d1-8b05-00600806d9b6")
interface ISWbemNamedValueSet : IDispatch
{
    HRESULT get__NewEnum(IUnknown* pUnk);
    HRESULT Item(BSTR strName, int iFlags, ISWbemNamedValue* objWbemNamedValue);
    HRESULT get_Count(int* iCount);
    HRESULT Add(BSTR strName, VARIANT* varValue, int iFlags, ISWbemNamedValue* objWbemNamedValue);
    HRESULT Remove(BSTR strName, int iFlags);
    HRESULT Clone(ISWbemNamedValueSet* objWbemNamedValueSet);
    HRESULT DeleteAll();
}

@GUID("79b05932-d3b7-11d1-8b06-00600806d9b6")
interface ISWbemQualifier : IDispatch
{
    HRESULT get_Value(VARIANT* varValue);
    HRESULT put_Value(VARIANT* varValue);
    HRESULT get_Name(BSTR* strName);
    HRESULT get_IsLocal(VARIANT_BOOL* bIsLocal);
    HRESULT get_PropagatesToSubclass(VARIANT_BOOL* bPropagatesToSubclass);
    HRESULT put_PropagatesToSubclass(VARIANT_BOOL bPropagatesToSubclass);
    HRESULT get_PropagatesToInstance(VARIANT_BOOL* bPropagatesToInstance);
    HRESULT put_PropagatesToInstance(VARIANT_BOOL bPropagatesToInstance);
    HRESULT get_IsOverridable(VARIANT_BOOL* bIsOverridable);
    HRESULT put_IsOverridable(VARIANT_BOOL bIsOverridable);
    HRESULT get_IsAmended(VARIANT_BOOL* bIsAmended);
}

@GUID("9b16ed16-d3df-11d1-8b08-00600806d9b6")
interface ISWbemQualifierSet : IDispatch
{
    HRESULT get__NewEnum(IUnknown* pUnk);
    HRESULT Item(BSTR name, int iFlags, ISWbemQualifier* objWbemQualifier);
    HRESULT get_Count(int* iCount);
    HRESULT Add(BSTR strName, VARIANT* varVal, VARIANT_BOOL bPropagatesToSubclass, 
                VARIANT_BOOL bPropagatesToInstance, VARIANT_BOOL bIsOverridable, int iFlags, 
                ISWbemQualifier* objWbemQualifier);
    HRESULT Remove(BSTR strName, int iFlags);
}

@GUID("1a388f98-d4ba-11d1-8b09-00600806d9b6")
interface ISWbemProperty : IDispatch
{
    HRESULT get_Value(VARIANT* varValue);
    HRESULT put_Value(VARIANT* varValue);
    HRESULT get_Name(BSTR* strName);
    HRESULT get_IsLocal(VARIANT_BOOL* bIsLocal);
    HRESULT get_Origin(BSTR* strOrigin);
    HRESULT get_CIMType(WbemCimtypeEnum* iCimType);
    HRESULT get_Qualifiers_(ISWbemQualifierSet* objWbemQualifierSet);
    HRESULT get_IsArray(VARIANT_BOOL* bIsArray);
}

@GUID("dea0a7b2-d4ba-11d1-8b09-00600806d9b6")
interface ISWbemPropertySet : IDispatch
{
    HRESULT get__NewEnum(IUnknown* pUnk);
    HRESULT Item(BSTR strName, int iFlags, ISWbemProperty* objWbemProperty);
    HRESULT get_Count(int* iCount);
    HRESULT Add(BSTR strName, WbemCimtypeEnum iCIMType, VARIANT_BOOL bIsArray, int iFlags, 
                ISWbemProperty* objWbemProperty);
    HRESULT Remove(BSTR strName, int iFlags);
}

@GUID("422e8e90-d955-11d1-8b09-00600806d9b6")
interface ISWbemMethod : IDispatch
{
    HRESULT get_Name(BSTR* strName);
    HRESULT get_Origin(BSTR* strOrigin);
    HRESULT get_InParameters(ISWbemObject* objWbemInParameters);
    HRESULT get_OutParameters(ISWbemObject* objWbemOutParameters);
    HRESULT get_Qualifiers_(ISWbemQualifierSet* objWbemQualifierSet);
}

@GUID("c93ba292-d955-11d1-8b09-00600806d9b6")
interface ISWbemMethodSet : IDispatch
{
    HRESULT get__NewEnum(IUnknown* pUnk);
    HRESULT Item(BSTR strName, int iFlags, ISWbemMethod* objWbemMethod);
    HRESULT get_Count(int* iCount);
}

@GUID("27d54d92-0ebe-11d2-8b22-00600806d9b6")
interface ISWbemEventSource : IDispatch
{
    HRESULT NextEvent(int iTimeoutMs, ISWbemObject* objWbemObject);
    HRESULT get_Security_(ISWbemSecurity* objWbemSecurity);
}

@GUID("5791bc27-ce9c-11d1-97bf-0000f81e849c")
interface ISWbemObjectPath : IDispatch
{
    HRESULT get_Path(BSTR* strPath);
    HRESULT put_Path(BSTR strPath);
    HRESULT get_RelPath(BSTR* strRelPath);
    HRESULT put_RelPath(BSTR strRelPath);
    HRESULT get_Server(BSTR* strServer);
    HRESULT put_Server(BSTR strServer);
    HRESULT get_Namespace(BSTR* strNamespace);
    HRESULT put_Namespace(BSTR strNamespace);
    HRESULT get_ParentNamespace(BSTR* strParentNamespace);
    HRESULT get_DisplayName(BSTR* strDisplayName);
    HRESULT put_DisplayName(BSTR strDisplayName);
    HRESULT get_Class(BSTR* strClass);
    HRESULT put_Class(BSTR strClass);
    HRESULT get_IsClass(VARIANT_BOOL* bIsClass);
    HRESULT SetAsClass();
    HRESULT get_IsSingleton(VARIANT_BOOL* bIsSingleton);
    HRESULT SetAsSingleton();
    HRESULT get_Keys(ISWbemNamedValueSet* objWbemNamedValueSet);
    HRESULT get_Security_(ISWbemSecurity* objWbemSecurity);
    HRESULT get_Locale(BSTR* strLocale);
    HRESULT put_Locale(BSTR strLocale);
    HRESULT get_Authority(BSTR* strAuthority);
    HRESULT put_Authority(BSTR strAuthority);
}

@GUID("d962db84-d4bb-11d1-8b09-00600806d9b6")
interface ISWbemLastError : ISWbemObject
{
}

@GUID("75718ca0-f029-11d1-a1ac-00c04fb6c223")
interface ISWbemSinkEvents : IDispatch
{
}

@GUID("75718c9f-f029-11d1-a1ac-00c04fb6c223")
interface ISWbemSink : IDispatch
{
    HRESULT Cancel();
}

@GUID("b54d66e6-2287-11d2-8b33-00600806d9b6")
interface ISWbemSecurity : IDispatch
{
    HRESULT get_ImpersonationLevel(WbemImpersonationLevelEnum* iImpersonationLevel);
    HRESULT put_ImpersonationLevel(WbemImpersonationLevelEnum iImpersonationLevel);
    HRESULT get_AuthenticationLevel(WbemAuthenticationLevelEnum* iAuthenticationLevel);
    HRESULT put_AuthenticationLevel(WbemAuthenticationLevelEnum iAuthenticationLevel);
    HRESULT get_Privileges(ISWbemPrivilegeSet* objWbemPrivilegeSet);
}

@GUID("26ee67bd-5804-11d2-8b4a-00600806d9b6")
interface ISWbemPrivilege : IDispatch
{
    HRESULT get_IsEnabled(VARIANT_BOOL* bIsEnabled);
    HRESULT put_IsEnabled(VARIANT_BOOL bIsEnabled);
    HRESULT get_Name(BSTR* strDisplayName);
    HRESULT get_DisplayName(BSTR* strDisplayName);
    HRESULT get_Identifier(WbemPrivilegeEnum* iPrivilege);
}

@GUID("26ee67bf-5804-11d2-8b4a-00600806d9b6")
interface ISWbemPrivilegeSet : IDispatch
{
    HRESULT get__NewEnum(IUnknown* pUnk);
    HRESULT Item(WbemPrivilegeEnum iPrivilege, ISWbemPrivilege* objWbemPrivilege);
    HRESULT get_Count(int* iCount);
    HRESULT Add(WbemPrivilegeEnum iPrivilege, VARIANT_BOOL bIsEnabled, ISWbemPrivilege* objWbemPrivilege);
    HRESULT Remove(WbemPrivilegeEnum iPrivilege);
    HRESULT DeleteAll();
    HRESULT AddAsString(BSTR strPrivilege, VARIANT_BOOL bIsEnabled, ISWbemPrivilege* objWbemPrivilege);
}

@GUID("d2f68443-85dc-427e-91d8-366554cc754c")
interface ISWbemServicesEx : ISWbemServices
{
    HRESULT Put(ISWbemObjectEx objWbemObject, int iFlags, IDispatch objWbemNamedValueSet, 
                ISWbemObjectPath* objWbemObjectPath);
    HRESULT PutAsync(ISWbemSink objWbemSink, ISWbemObjectEx objWbemObject, int iFlags, 
                     IDispatch objWbemNamedValueSet, IDispatch objWbemAsyncContext);
}

@GUID("269ad56a-8a67-4129-bc8c-0506dcfe9880")
interface ISWbemObjectEx : ISWbemObject
{
    HRESULT Refresh_(int iFlags, IDispatch objWbemNamedValueSet);
    HRESULT get_SystemProperties_(ISWbemPropertySet* objWbemPropertySet);
    HRESULT GetText_(WbemObjectTextFormatEnum iObjectTextFormat, int iFlags, IDispatch objWbemNamedValueSet, 
                     BSTR* bsText);
    HRESULT SetFromText_(BSTR bsText, WbemObjectTextFormatEnum iObjectTextFormat, int iFlags, 
                         IDispatch objWbemNamedValueSet);
}

@GUID("5e97458a-cf77-11d3-b38f-00105a1f473a")
interface ISWbemDateTime : IDispatch
{
    HRESULT get_Value(BSTR* strValue);
    HRESULT put_Value(BSTR strValue);
    HRESULT get_Year(int* iYear);
    HRESULT put_Year(int iYear);
    HRESULT get_YearSpecified(VARIANT_BOOL* bYearSpecified);
    HRESULT put_YearSpecified(VARIANT_BOOL bYearSpecified);
    HRESULT get_Month(int* iMonth);
    HRESULT put_Month(int iMonth);
    HRESULT get_MonthSpecified(VARIANT_BOOL* bMonthSpecified);
    HRESULT put_MonthSpecified(VARIANT_BOOL bMonthSpecified);
    HRESULT get_Day(int* iDay);
    HRESULT put_Day(int iDay);
    HRESULT get_DaySpecified(VARIANT_BOOL* bDaySpecified);
    HRESULT put_DaySpecified(VARIANT_BOOL bDaySpecified);
    HRESULT get_Hours(int* iHours);
    HRESULT put_Hours(int iHours);
    HRESULT get_HoursSpecified(VARIANT_BOOL* bHoursSpecified);
    HRESULT put_HoursSpecified(VARIANT_BOOL bHoursSpecified);
    HRESULT get_Minutes(int* iMinutes);
    HRESULT put_Minutes(int iMinutes);
    HRESULT get_MinutesSpecified(VARIANT_BOOL* bMinutesSpecified);
    HRESULT put_MinutesSpecified(VARIANT_BOOL bMinutesSpecified);
    HRESULT get_Seconds(int* iSeconds);
    HRESULT put_Seconds(int iSeconds);
    HRESULT get_SecondsSpecified(VARIANT_BOOL* bSecondsSpecified);
    HRESULT put_SecondsSpecified(VARIANT_BOOL bSecondsSpecified);
    HRESULT get_Microseconds(int* iMicroseconds);
    HRESULT put_Microseconds(int iMicroseconds);
    HRESULT get_MicrosecondsSpecified(VARIANT_BOOL* bMicrosecondsSpecified);
    HRESULT put_MicrosecondsSpecified(VARIANT_BOOL bMicrosecondsSpecified);
    HRESULT get_UTC(int* iUTC);
    HRESULT put_UTC(int iUTC);
    HRESULT get_UTCSpecified(VARIANT_BOOL* bUTCSpecified);
    HRESULT put_UTCSpecified(VARIANT_BOOL bUTCSpecified);
    HRESULT get_IsInterval(VARIANT_BOOL* bIsInterval);
    HRESULT put_IsInterval(VARIANT_BOOL bIsInterval);
    HRESULT GetVarDate(VARIANT_BOOL bIsLocal, double* dVarDate);
    HRESULT SetVarDate(double dVarDate, VARIANT_BOOL bIsLocal);
    HRESULT GetFileTime(VARIANT_BOOL bIsLocal, BSTR* strFileTime);
    HRESULT SetFileTime(BSTR strFileTime, VARIANT_BOOL bIsLocal);
}

@GUID("14d8250e-d9c2-11d3-b38f-00105a1f473a")
interface ISWbemRefresher : IDispatch
{
    HRESULT get__NewEnum(IUnknown* pUnk);
    HRESULT Item(int iIndex, ISWbemRefreshableItem* objWbemRefreshableItem);
    HRESULT get_Count(int* iCount);
    HRESULT Add(ISWbemServicesEx objWbemServices, BSTR bsInstancePath, int iFlags, IDispatch objWbemNamedValueSet, 
                ISWbemRefreshableItem* objWbemRefreshableItem);
    HRESULT AddEnum(ISWbemServicesEx objWbemServices, BSTR bsClassName, int iFlags, IDispatch objWbemNamedValueSet, 
                    ISWbemRefreshableItem* objWbemRefreshableItem);
    HRESULT Remove(int iIndex, int iFlags);
    HRESULT Refresh(int iFlags);
    HRESULT get_AutoReconnect(VARIANT_BOOL* bCount);
    HRESULT put_AutoReconnect(VARIANT_BOOL bCount);
    HRESULT DeleteAll();
}

@GUID("5ad4bf92-daab-11d3-b38f-00105a1f473a")
interface ISWbemRefreshableItem : IDispatch
{
    HRESULT get_Index(int* iIndex);
    HRESULT get_Refresher(ISWbemRefresher* objWbemRefresher);
    HRESULT get_IsSet(VARIANT_BOOL* bIsSet);
    HRESULT get_Object(ISWbemObjectEx* objWbemObject);
    HRESULT get_ObjectSet(ISWbemObjectSet* objWbemObjectSet);
    HRESULT Remove(int iFlags);
}

@GUID("adc1f06e-5c7e-11d2-8b74-00104b2afb41")
interface IWMIExtension : IDispatch
{
    HRESULT get_WMIObjectPath(BSTR* strWMIObjectPath);
    HRESULT GetWMIObject(ISWbemObject* objWMIObject);
    HRESULT GetWMIServices(ISWbemServices* objWMIServices);
}

@GUID("553fe584-2156-11d0-b6ae-00aa003240c7")
interface IWbemTransport : IUnknown
{
    HRESULT Initialize();
}

@GUID("f309ad18-d86a-11d0-a075-00c04fb68820")
interface IWbemLevel1Login : IUnknown
{
    HRESULT EstablishPosition(PWSTR wszLocaleList, uint dwNumLocales, uint* reserved);
    HRESULT RequestChallenge(PWSTR wszNetworkResource, PWSTR wszUser, ubyte* Nonce);
    HRESULT WBEMLogin(PWSTR wszPreferredLocale, ubyte* AccessToken, int lFlags, IWbemContext pCtx, 
                      IWbemServices* ppNamespace);
    HRESULT NTLMLogin(PWSTR wszNetworkResource, PWSTR wszPreferredLocale, int lFlags, IWbemContext pCtx, 
                      IWbemServices* ppNamespace);
}

@GUID("d8ec9cb1-b135-4f10-8b1b-c7188bb0d186")
interface IWbemConnectorLogin : IUnknown
{
    HRESULT ConnectorLogin(PWSTR wszNetworkResource, PWSTR wszPreferredLocale, int lFlags, IWbemContext pCtx, 
                           const(GUID)* riid, void** pInterface);
}

@GUID("f7ce2e12-8c90-11d1-9e7b-00c04fc324a8")
interface IWbemAddressResolution : IUnknown
{
    HRESULT Resolve(PWSTR wszNamespacePath, PWSTR wszAddressType, uint* pdwAddressLength, ubyte** pabBinaryAddress);
}

@GUID("f7ce2e11-8c90-11d1-9e7b-00c04fc324a8")
interface IWbemClientTransport : IUnknown
{
    HRESULT ConnectServer(BSTR strAddressType, uint dwBinaryAddressLength, ubyte* abBinaryAddress, 
                          BSTR strNetworkResource, BSTR strUser, BSTR strPassword, BSTR strLocale, 
                          int lSecurityFlags, BSTR strAuthority, IWbemContext pCtx, IWbemServices* ppNamespace);
}

@GUID("a889c72a-fcc1-4a9e-af61-ed071333fb5b")
interface IWbemClientConnectionTransport : IUnknown
{
    HRESULT Open(BSTR strAddressType, uint dwBinaryAddressLength, ubyte* abBinaryAddress, const(BSTR) strObject, 
                 const(BSTR) strUser, const(BSTR) strPassword, const(BSTR) strLocale, int lFlags, IWbemContext pCtx, 
                 const(GUID)* riid, void** pInterface, IWbemCallResult* pCallRes);
    HRESULT OpenAsync(BSTR strAddressType, uint dwBinaryAddressLength, ubyte* abBinaryAddress, 
                      const(BSTR) strObject, const(BSTR) strUser, const(BSTR) strPassword, const(BSTR) strLocale, 
                      int lFlags, IWbemContext pCtx, const(GUID)* riid, IWbemObjectSink pResponseHandler);
    HRESULT Cancel(int lFlags, IWbemObjectSink pHandler);
}

@GUID("9ef76194-70d5-11d1-ad90-00c04fd8fdff")
interface IWbemConstructClassObject : IUnknown
{
    HRESULT SetInheritanceChain(int lNumAntecedents, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/PWSTR* awszAntecedents);
    HRESULT SetPropertyOrigin(const(PWSTR) wszPropertyName, int lOriginIndex);
    HRESULT SetMethodOrigin(const(PWSTR) wszMethodName, int lOriginIndex);
    HRESULT SetServerNamespace(const(PWSTR) wszServer, const(PWSTR) wszNamespace);
}


// GUIDs

const GUID CLSID_MofCompiler                     = GUIDOF!MofCompiler;
const GUID CLSID_SWbemDateTime                   = GUIDOF!SWbemDateTime;
const GUID CLSID_SWbemEventSource                = GUIDOF!SWbemEventSource;
const GUID CLSID_SWbemLastError                  = GUIDOF!SWbemLastError;
const GUID CLSID_SWbemLocator                    = GUIDOF!SWbemLocator;
const GUID CLSID_SWbemMethod                     = GUIDOF!SWbemMethod;
const GUID CLSID_SWbemMethodSet                  = GUIDOF!SWbemMethodSet;
const GUID CLSID_SWbemNamedValue                 = GUIDOF!SWbemNamedValue;
const GUID CLSID_SWbemNamedValueSet              = GUIDOF!SWbemNamedValueSet;
const GUID CLSID_SWbemObject                     = GUIDOF!SWbemObject;
const GUID CLSID_SWbemObjectEx                   = GUIDOF!SWbemObjectEx;
const GUID CLSID_SWbemObjectPath                 = GUIDOF!SWbemObjectPath;
const GUID CLSID_SWbemObjectSet                  = GUIDOF!SWbemObjectSet;
const GUID CLSID_SWbemPrivilege                  = GUIDOF!SWbemPrivilege;
const GUID CLSID_SWbemPrivilegeSet               = GUIDOF!SWbemPrivilegeSet;
const GUID CLSID_SWbemProperty                   = GUIDOF!SWbemProperty;
const GUID CLSID_SWbemPropertySet                = GUIDOF!SWbemPropertySet;
const GUID CLSID_SWbemQualifier                  = GUIDOF!SWbemQualifier;
const GUID CLSID_SWbemQualifierSet               = GUIDOF!SWbemQualifierSet;
const GUID CLSID_SWbemRefreshableItem            = GUIDOF!SWbemRefreshableItem;
const GUID CLSID_SWbemRefresher                  = GUIDOF!SWbemRefresher;
const GUID CLSID_SWbemSecurity                   = GUIDOF!SWbemSecurity;
const GUID CLSID_SWbemServices                   = GUIDOF!SWbemServices;
const GUID CLSID_SWbemServicesEx                 = GUIDOF!SWbemServicesEx;
const GUID CLSID_SWbemSink                       = GUIDOF!SWbemSink;
const GUID CLSID_UnsecuredApartment              = GUIDOF!UnsecuredApartment;
const GUID CLSID_WMIExtension                    = GUIDOF!WMIExtension;
const GUID CLSID_WbemAdministrativeLocator       = GUIDOF!WbemAdministrativeLocator;
const GUID CLSID_WbemAuthenticatedLocator        = GUIDOF!WbemAuthenticatedLocator;
const GUID CLSID_WbemBackupRestore               = GUIDOF!WbemBackupRestore;
const GUID CLSID_WbemClassObject                 = GUIDOF!WbemClassObject;
const GUID CLSID_WbemContext                     = GUIDOF!WbemContext;
const GUID CLSID_WbemDCOMTransport               = GUIDOF!WbemDCOMTransport;
const GUID CLSID_WbemDecoupledBasicEventProvider = GUIDOF!WbemDecoupledBasicEventProvider;
const GUID CLSID_WbemDecoupledRegistrar          = GUIDOF!WbemDecoupledRegistrar;
const GUID CLSID_WbemDefPath                     = GUIDOF!WbemDefPath;
const GUID CLSID_WbemLevel1Login                 = GUIDOF!WbemLevel1Login;
const GUID CLSID_WbemLocalAddrRes                = GUIDOF!WbemLocalAddrRes;
const GUID CLSID_WbemLocator                     = GUIDOF!WbemLocator;
const GUID CLSID_WbemObjectTextSrc               = GUIDOF!WbemObjectTextSrc;
const GUID CLSID_WbemQuery                       = GUIDOF!WbemQuery;
const GUID CLSID_WbemRefresher                   = GUIDOF!WbemRefresher;
const GUID CLSID_WbemStatusCodeText              = GUIDOF!WbemStatusCodeText;
const GUID CLSID_WbemUnauthenticatedLocator      = GUIDOF!WbemUnauthenticatedLocator;
const GUID CLSID_WbemUninitializedClassObject    = GUIDOF!WbemUninitializedClassObject;

const GUID IID_IEnumWbemClassObject             = GUIDOF!IEnumWbemClassObject;
const GUID IID_IMofCompiler                     = GUIDOF!IMofCompiler;
const GUID IID_ISWbemDateTime                   = GUIDOF!ISWbemDateTime;
const GUID IID_ISWbemEventSource                = GUIDOF!ISWbemEventSource;
const GUID IID_ISWbemLastError                  = GUIDOF!ISWbemLastError;
const GUID IID_ISWbemLocator                    = GUIDOF!ISWbemLocator;
const GUID IID_ISWbemMethod                     = GUIDOF!ISWbemMethod;
const GUID IID_ISWbemMethodSet                  = GUIDOF!ISWbemMethodSet;
const GUID IID_ISWbemNamedValue                 = GUIDOF!ISWbemNamedValue;
const GUID IID_ISWbemNamedValueSet              = GUIDOF!ISWbemNamedValueSet;
const GUID IID_ISWbemObject                     = GUIDOF!ISWbemObject;
const GUID IID_ISWbemObjectEx                   = GUIDOF!ISWbemObjectEx;
const GUID IID_ISWbemObjectPath                 = GUIDOF!ISWbemObjectPath;
const GUID IID_ISWbemObjectSet                  = GUIDOF!ISWbemObjectSet;
const GUID IID_ISWbemPrivilege                  = GUIDOF!ISWbemPrivilege;
const GUID IID_ISWbemPrivilegeSet               = GUIDOF!ISWbemPrivilegeSet;
const GUID IID_ISWbemProperty                   = GUIDOF!ISWbemProperty;
const GUID IID_ISWbemPropertySet                = GUIDOF!ISWbemPropertySet;
const GUID IID_ISWbemQualifier                  = GUIDOF!ISWbemQualifier;
const GUID IID_ISWbemQualifierSet               = GUIDOF!ISWbemQualifierSet;
const GUID IID_ISWbemRefreshableItem            = GUIDOF!ISWbemRefreshableItem;
const GUID IID_ISWbemRefresher                  = GUIDOF!ISWbemRefresher;
const GUID IID_ISWbemSecurity                   = GUIDOF!ISWbemSecurity;
const GUID IID_ISWbemServices                   = GUIDOF!ISWbemServices;
const GUID IID_ISWbemServicesEx                 = GUIDOF!ISWbemServicesEx;
const GUID IID_ISWbemSink                       = GUIDOF!ISWbemSink;
const GUID IID_ISWbemSinkEvents                 = GUIDOF!ISWbemSinkEvents;
const GUID IID_IUnsecuredApartment              = GUIDOF!IUnsecuredApartment;
const GUID IID_IWMIExtension                    = GUIDOF!IWMIExtension;
const GUID IID_IWbemAddressResolution           = GUIDOF!IWbemAddressResolution;
const GUID IID_IWbemBackupRestore               = GUIDOF!IWbemBackupRestore;
const GUID IID_IWbemBackupRestoreEx             = GUIDOF!IWbemBackupRestoreEx;
const GUID IID_IWbemCallResult                  = GUIDOF!IWbemCallResult;
const GUID IID_IWbemClassObject                 = GUIDOF!IWbemClassObject;
const GUID IID_IWbemClientConnectionTransport   = GUIDOF!IWbemClientConnectionTransport;
const GUID IID_IWbemClientTransport             = GUIDOF!IWbemClientTransport;
const GUID IID_IWbemConfigureRefresher          = GUIDOF!IWbemConfigureRefresher;
const GUID IID_IWbemConnectorLogin              = GUIDOF!IWbemConnectorLogin;
const GUID IID_IWbemConstructClassObject        = GUIDOF!IWbemConstructClassObject;
const GUID IID_IWbemContext                     = GUIDOF!IWbemContext;
const GUID IID_IWbemDecoupledBasicEventProvider = GUIDOF!IWbemDecoupledBasicEventProvider;
const GUID IID_IWbemDecoupledRegistrar          = GUIDOF!IWbemDecoupledRegistrar;
const GUID IID_IWbemEventConsumerProvider       = GUIDOF!IWbemEventConsumerProvider;
const GUID IID_IWbemEventProvider               = GUIDOF!IWbemEventProvider;
const GUID IID_IWbemEventProviderQuerySink      = GUIDOF!IWbemEventProviderQuerySink;
const GUID IID_IWbemEventProviderSecurity       = GUIDOF!IWbemEventProviderSecurity;
const GUID IID_IWbemEventSink                   = GUIDOF!IWbemEventSink;
const GUID IID_IWbemHiPerfEnum                  = GUIDOF!IWbemHiPerfEnum;
const GUID IID_IWbemHiPerfProvider              = GUIDOF!IWbemHiPerfProvider;
const GUID IID_IWbemLevel1Login                 = GUIDOF!IWbemLevel1Login;
const GUID IID_IWbemLocator                     = GUIDOF!IWbemLocator;
const GUID IID_IWbemObjectAccess                = GUIDOF!IWbemObjectAccess;
const GUID IID_IWbemObjectSink                  = GUIDOF!IWbemObjectSink;
const GUID IID_IWbemObjectSinkEx                = GUIDOF!IWbemObjectSinkEx;
const GUID IID_IWbemObjectTextSrc               = GUIDOF!IWbemObjectTextSrc;
const GUID IID_IWbemPath                        = GUIDOF!IWbemPath;
const GUID IID_IWbemPathKeyList                 = GUIDOF!IWbemPathKeyList;
const GUID IID_IWbemPropertyProvider            = GUIDOF!IWbemPropertyProvider;
const GUID IID_IWbemProviderIdentity            = GUIDOF!IWbemProviderIdentity;
const GUID IID_IWbemProviderInit                = GUIDOF!IWbemProviderInit;
const GUID IID_IWbemProviderInitSink            = GUIDOF!IWbemProviderInitSink;
const GUID IID_IWbemQualifierSet                = GUIDOF!IWbemQualifierSet;
const GUID IID_IWbemQuery                       = GUIDOF!IWbemQuery;
const GUID IID_IWbemRefresher                   = GUIDOF!IWbemRefresher;
const GUID IID_IWbemServices                    = GUIDOF!IWbemServices;
const GUID IID_IWbemShutdown                    = GUIDOF!IWbemShutdown;
const GUID IID_IWbemStatusCodeText              = GUIDOF!IWbemStatusCodeText;
const GUID IID_IWbemTransport                   = GUIDOF!IWbemTransport;
const GUID IID_IWbemUnboundObjectSink           = GUIDOF!IWbemUnboundObjectSink;
const GUID IID_IWbemUnsecuredApartment          = GUIDOF!IWbemUnsecuredApartment;
