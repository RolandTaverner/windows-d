// Written in the D programming language.

module windows.win32.networking.backgroundintelligenttransferservice;

public import windows.core;
public import system : Guid;
public import windows.win32.foundation : BOOL, BSTR, FILETIME, HRESULT, PWSTR;
public import windows.win32.system.com : IDispatch, IUnknown;
public import windows.win32.system.variant : VARIANT;

extern(Windows) @nogc nothrow:


// Enums

alias BG_TOKEN = uint;
enum : uint
{
    BG_TOKEN_LOCAL_FILE = 0x00000001,
    BG_TOKEN_NETWORK    = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/ne-bits-bg_error_context))], [])
alias BG_ERROR_CONTEXT = int;
enum : int
{
    BG_ERROR_CONTEXT_NONE                        = 0x00000000,
    BG_ERROR_CONTEXT_UNKNOWN                     = 0x00000001,
    BG_ERROR_CONTEXT_GENERAL_QUEUE_MANAGER       = 0x00000002,
    BG_ERROR_CONTEXT_QUEUE_MANAGER_NOTIFICATION  = 0x00000003,
    BG_ERROR_CONTEXT_LOCAL_FILE                  = 0x00000004,
    BG_ERROR_CONTEXT_REMOTE_FILE                 = 0x00000005,
    BG_ERROR_CONTEXT_GENERAL_TRANSPORT           = 0x00000006,
    BG_ERROR_CONTEXT_REMOTE_APPLICATION          = 0x00000007,
    BG_ERROR_CONTEXT_SERVER_CERTIFICATE_CALLBACK = 0x00000008,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/ne-bits-bg_job_priority))], [])
alias BG_JOB_PRIORITY = int;
enum : int
{
    BG_JOB_PRIORITY_FOREGROUND = 0x00000000,
    BG_JOB_PRIORITY_HIGH       = 0x00000001,
    BG_JOB_PRIORITY_NORMAL     = 0x00000002,
    BG_JOB_PRIORITY_LOW        = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/ne-bits-bg_job_state))], [])
alias BG_JOB_STATE = int;
enum : int
{
    BG_JOB_STATE_QUEUED          = 0x00000000,
    BG_JOB_STATE_CONNECTING      = 0x00000001,
    BG_JOB_STATE_TRANSFERRING    = 0x00000002,
    BG_JOB_STATE_SUSPENDED       = 0x00000003,
    BG_JOB_STATE_ERROR           = 0x00000004,
    BG_JOB_STATE_TRANSIENT_ERROR = 0x00000005,
    BG_JOB_STATE_TRANSFERRED     = 0x00000006,
    BG_JOB_STATE_ACKNOWLEDGED    = 0x00000007,
    BG_JOB_STATE_CANCELLED       = 0x00000008,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/ne-bits-bg_job_type))], [])
alias BG_JOB_TYPE = int;
enum : int
{
    BG_JOB_TYPE_DOWNLOAD     = 0x00000000,
    BG_JOB_TYPE_UPLOAD       = 0x00000001,
    BG_JOB_TYPE_UPLOAD_REPLY = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/ne-bits-bg_job_proxy_usage))], [])
alias BG_JOB_PROXY_USAGE = int;
enum : int
{
    BG_JOB_PROXY_USAGE_PRECONFIG  = 0x00000000,
    BG_JOB_PROXY_USAGE_NO_PROXY   = 0x00000001,
    BG_JOB_PROXY_USAGE_OVERRIDE   = 0x00000002,
    BG_JOB_PROXY_USAGE_AUTODETECT = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits1_5/ne-bits1_5-bg_auth_target))], [])
alias BG_AUTH_TARGET = int;
enum : int
{
    BG_AUTH_TARGET_SERVER = 0x00000001,
    BG_AUTH_TARGET_PROXY  = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits1_5/ne-bits1_5-bg_auth_scheme))], [])
alias BG_AUTH_SCHEME = int;
enum : int
{
    BG_AUTH_SCHEME_BASIC     = 0x00000001,
    BG_AUTH_SCHEME_DIGEST    = 0x00000002,
    BG_AUTH_SCHEME_NTLM      = 0x00000003,
    BG_AUTH_SCHEME_NEGOTIATE = 0x00000004,
    BG_AUTH_SCHEME_PASSPORT  = 0x00000005,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits2_5/ne-bits2_5-bg_cert_store_location))], [])
alias BG_CERT_STORE_LOCATION = int;
enum : int
{
    BG_CERT_STORE_LOCATION_CURRENT_USER               = 0x00000000,
    BG_CERT_STORE_LOCATION_LOCAL_MACHINE              = 0x00000001,
    BG_CERT_STORE_LOCATION_CURRENT_SERVICE            = 0x00000002,
    BG_CERT_STORE_LOCATION_SERVICES                   = 0x00000003,
    BG_CERT_STORE_LOCATION_USERS                      = 0x00000004,
    BG_CERT_STORE_LOCATION_CURRENT_USER_GROUP_POLICY  = 0x00000005,
    BG_CERT_STORE_LOCATION_LOCAL_MACHINE_GROUP_POLICY = 0x00000006,
    BG_CERT_STORE_LOCATION_LOCAL_MACHINE_ENTERPRISE   = 0x00000007,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits5_0/ne-bits5_0-bits_job_transfer_policy))], [])
alias BITS_JOB_TRANSFER_POLICY = int;
enum : int
{
    BITS_JOB_TRANSFER_POLICY_ALWAYS       = 0x800000ff,
    BITS_JOB_TRANSFER_POLICY_NOT_ROAMING  = 0x8000007f,
    BITS_JOB_TRANSFER_POLICY_NO_SURCHARGE = 0x8000006f,
    BITS_JOB_TRANSFER_POLICY_STANDARD     = 0x80000067,
    BITS_JOB_TRANSFER_POLICY_UNRESTRICTED = 0x80000021,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits5_0/ne-bits5_0-bits_job_property_id))], [])
alias BITS_JOB_PROPERTY_ID = int;
enum : int
{
    BITS_JOB_PROPERTY_ID_COST_FLAGS                    = 0x00000001,
    BITS_JOB_PROPERTY_NOTIFICATION_CLSID               = 0x00000002,
    BITS_JOB_PROPERTY_DYNAMIC_CONTENT                  = 0x00000003,
    BITS_JOB_PROPERTY_HIGH_PERFORMANCE                 = 0x00000004,
    BITS_JOB_PROPERTY_MAX_DOWNLOAD_SIZE                = 0x00000005,
    BITS_JOB_PROPERTY_USE_STORED_CREDENTIALS           = 0x00000007,
    BITS_JOB_PROPERTY_MINIMUM_NOTIFICATION_INTERVAL_MS = 0x00000009,
    BITS_JOB_PROPERTY_ON_DEMAND_MODE                   = 0x0000000a,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits5_0/ne-bits5_0-bits_file_property_id))], [])
alias BITS_FILE_PROPERTY_ID = int;
enum : int
{
    BITS_FILE_PROPERTY_ID_HTTP_RESPONSE_HEADERS = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qmgr/ne-qmgr-groupprop))], [])
alias GROUPPROP = int;
enum : int
{
    GROUPPROP_PRIORITY        = 0x00000000,
    GROUPPROP_REMOTEUSERID    = 0x00000001,
    GROUPPROP_REMOTEUSERPWD   = 0x00000002,
    GROUPPROP_LOCALUSERID     = 0x00000003,
    GROUPPROP_LOCALUSERPWD    = 0x00000004,
    GROUPPROP_PROTOCOLFLAGS   = 0x00000005,
    GROUPPROP_NOTIFYFLAGS     = 0x00000006,
    GROUPPROP_NOTIFYCLSID     = 0x00000007,
    GROUPPROP_PROGRESSSIZE    = 0x00000008,
    GROUPPROP_PROGRESSPERCENT = 0x00000009,
    GROUPPROP_PROGRESSTIME    = 0x0000000a,
    GROUPPROP_DISPLAYNAME     = 0x0000000b,
    GROUPPROP_DESCRIPTION     = 0x0000000c,
}

// Constants


enum : uint
{
    BG_NOTIFY_JOB_TRANSFERRED  = 0x00000001,
    BG_NOTIFY_JOB_ERROR        = 0x00000002,
    BG_NOTIFY_DISABLE          = 0x00000004,
    BG_NOTIFY_JOB_MODIFICATION = 0x00000008,
}

enum : uint
{
    BG_NOTIFY_FILE_TRANSFERRED        = 0x00000010,
    BG_NOTIFY_FILE_RANGES_TRANSFERRED = 0x00000020,
}

enum uint BG_JOB_ENUM_ALL_USERS = 0x00000001;

enum : uint
{
    BG_COPY_FILE_OWNER = 0x00000001,
    BG_COPY_FILE_GROUP = 0x00000002,
    BG_COPY_FILE_DACL  = 0x00000004,
    BG_COPY_FILE_SACL  = 0x00000008,
    BG_COPY_FILE_ALL   = 0x0000000f,
}

enum uint BG_SSL_ENABLE_CRL_CHECK = 0x00000001;

enum : uint
{
    BG_SSL_IGNORE_CERT_CN_INVALID   = 0x00000002,
    BG_SSL_IGNORE_CERT_DATE_INVALID = 0x00000004,
    BG_SSL_IGNORE_UNKNOWN_CA        = 0x00000008,
    BG_SSL_IGNORE_CERT_WRONG_USAGE  = 0x00000010,
}

enum : uint
{
    BG_HTTP_REDIRECT_POLICY_MASK                = 0x00000700,
    BG_HTTP_REDIRECT_POLICY_ALLOW_SILENT        = 0x00000000,
    BG_HTTP_REDIRECT_POLICY_ALLOW_REPORT        = 0x00000100,
    BG_HTTP_REDIRECT_POLICY_DISALLOW            = 0x00000200,
    BG_HTTP_REDIRECT_POLICY_ALLOW_HTTPS_TO_HTTP = 0x00000800,
}

enum : uint
{
    BG_ENABLE_PEERCACHING_CLIENT = 0x00000001,
    BG_ENABLE_PEERCACHING_SERVER = 0x00000002,
}

enum uint BG_DISABLE_BRANCH_CACHE = 0x00000004;

enum : uint
{
    BG_JOB_ENABLE_PEERCACHING_CLIENT = 0x00000001,
    BG_JOB_ENABLE_PEERCACHING_SERVER = 0x00000002,
}

enum uint BG_JOB_DISABLE_BRANCH_CACHE = 0x00000004;

enum : uint
{
    BITS_COST_STATE_UNRESTRICTED         = 0x00000001,
    BITS_COST_STATE_CAPPED_USAGE_UNKNOWN = 0x00000002,
    BITS_COST_STATE_BELOW_CAP            = 0x00000004,
    BITS_COST_STATE_NEAR_CAP             = 0x00000008,
    BITS_COST_STATE_OVERCAP_CHARGED      = 0x00000010,
    BITS_COST_STATE_OVERCAP_THROTTLED    = 0x00000020,
    BITS_COST_STATE_USAGE_BASED          = 0x00000040,
    BITS_COST_STATE_ROAMING              = 0x00000080,
    BITS_COST_OPTION_IGNORE_CONGESTION   = 0x80000000,
}

enum uint BITS_COST_STATE_RESERVED = 0x40000000;

enum : uint
{
    QM_NOTIFY_FILE_DONE      = 0x00000001,
    QM_NOTIFY_JOB_DONE       = 0x00000002,
    QM_NOTIFY_GROUP_DONE     = 0x00000004,
    QM_NOTIFY_DISABLE_NOTIFY = 0x00000040,
    QM_NOTIFY_USE_PROGRESSEX = 0x00000080,
}

enum : uint
{
    QM_STATUS_FILE_COMPLETE   = 0x00000001,
    QM_STATUS_FILE_INCOMPLETE = 0x00000002,
}

enum : uint
{
    QM_STATUS_JOB_COMPLETE     = 0x00000004,
    QM_STATUS_JOB_INCOMPLETE   = 0x00000008,
    QM_STATUS_JOB_ERROR        = 0x00000010,
    QM_STATUS_JOB_FOREGROUND   = 0x00000020,
    QM_STATUS_GROUP_COMPLETE   = 0x00000040,
    QM_STATUS_GROUP_INCOMPLETE = 0x00000080,
    QM_STATUS_GROUP_SUSPENDED  = 0x00000100,
    QM_STATUS_GROUP_ERROR      = 0x00000200,
    QM_STATUS_GROUP_FOREGROUND = 0x00000400,
}

enum : uint
{
    QM_PROTOCOL_HTTP   = 0x00000001,
    QM_PROTOCOL_FTP    = 0x00000002,
    QM_PROTOCOL_SMB    = 0x00000003,
    QM_PROTOCOL_CUSTOM = 0x00000004,
}

enum : uint
{
    QM_PROGRESS_PERCENT_DONE = 0x00000001,
    QM_PROGRESS_TIME_DONE    = 0x00000002,
    QM_PROGRESS_SIZE_DONE    = 0x00000003,
}

enum uint QM_E_INVALID_STATE = 0x81001001;
enum uint QM_E_SERVICE_UNAVAILABLE = 0x81001002;
enum uint QM_E_DOWNLOADER_UNAVAILABLE = 0x81001003;
enum uint QM_E_ITEM_NOT_FOUND = 0x81001004;
enum int BG_E_NOT_FOUND = 0x80200001;
enum int BG_E_INVALID_STATE = 0x80200002;

enum : int
{
    BG_E_EMPTY              = 0x80200003,
    BG_E_FILE_NOT_AVAILABLE = 0x80200004,
}

enum int BG_E_PROTOCOL_NOT_AVAILABLE = 0x80200005;
enum int BG_S_ERROR_CONTEXT_NONE = 0x00200006;

enum : int
{
    BG_E_ERROR_CONTEXT_UNKNOWN                    = 0x80200007,
    BG_E_ERROR_CONTEXT_GENERAL_QUEUE_MANAGER      = 0x80200008,
    BG_E_ERROR_CONTEXT_LOCAL_FILE                 = 0x80200009,
    BG_E_ERROR_CONTEXT_REMOTE_FILE                = 0x8020000a,
    BG_E_ERROR_CONTEXT_GENERAL_TRANSPORT          = 0x8020000b,
    BG_E_ERROR_CONTEXT_QUEUE_MANAGER_NOTIFICATION = 0x8020000c,
}

enum int BG_E_DESTINATION_LOCKED = 0x8020000d;
enum int BG_E_VOLUME_CHANGED = 0x8020000e;
enum int BG_E_ERROR_INFORMATION_UNAVAILABLE = 0x8020000f;
enum int BG_E_NETWORK_DISCONNECTED = 0x80200010;
enum int BG_E_MISSING_FILE_SIZE = 0x80200011;

enum : int
{
    BG_E_INSUFFICIENT_HTTP_SUPPORT  = 0x80200012,
    BG_E_INSUFFICIENT_RANGE_SUPPORT = 0x80200013,
}

enum int BG_E_REMOTE_NOT_SUPPORTED = 0x80200014;

enum : int
{
    BG_E_NEW_OWNER_DIFF_MAPPING   = 0x80200015,
    BG_E_NEW_OWNER_NO_FILE_ACCESS = 0x80200016,
}

enum int BG_S_PARTIAL_COMPLETE = 0x00200017;

enum : int
{
    BG_E_PROXY_LIST_TOO_LARGE        = 0x80200018,
    BG_E_PROXY_BYPASS_LIST_TOO_LARGE = 0x80200019,
}

enum int BG_S_UNABLE_TO_DELETE_FILES = 0x0020001a;
enum int BG_E_INVALID_SERVER_RESPONSE = 0x8020001b;
enum int BG_E_TOO_MANY_FILES = 0x8020001c;
enum int BG_E_LOCAL_FILE_CHANGED = 0x8020001d;
enum int BG_E_ERROR_CONTEXT_REMOTE_APPLICATION = 0x8020001e;
enum int BG_E_SESSION_NOT_FOUND = 0x8020001f;
enum int BG_E_TOO_LARGE = 0x80200020;
enum int BG_E_STRING_TOO_LONG = 0x80200021;
enum int BG_E_CLIENT_SERVER_PROTOCOL_MISMATCH = 0x80200022;
enum int BG_E_SERVER_EXECUTE_ENABLE = 0x80200023;
enum int BG_E_NO_PROGRESS = 0x80200024;
enum int BG_E_USERNAME_TOO_LARGE = 0x80200025;
enum int BG_E_PASSWORD_TOO_LARGE = 0x80200026;

enum : int
{
    BG_E_INVALID_AUTH_TARGET = 0x80200027,
    BG_E_INVALID_AUTH_SCHEME = 0x80200028,
}

enum int BG_E_FILE_NOT_FOUND = 0x80200029;
enum int BG_S_PROXY_CHANGED = 0x0020002a;
enum int BG_E_INVALID_RANGE = 0x8020002b;
enum int BG_E_OVERLAPPING_RANGES = 0x8020002c;

enum : int
{
    BG_E_CONNECT_FAILURE   = 0x8020002d,
    BG_E_CONNECTION_CLOSED = 0x8020002e,
}

enum int BG_E_BLOCKED_BY_POLICY = 0x8020003e;

enum : int
{
    BG_E_INVALID_PROXY_INFO     = 0x8020003f,
    BG_E_INVALID_CREDENTIALS    = 0x80200040,
    BG_E_INVALID_HASH_ALGORITHM = 0x80200041,
}

enum int BG_E_RECORD_DELETED = 0x80200042;
enum int BG_E_COMMIT_IN_PROGRESS = 0x80200043;
enum int BG_E_DISCOVERY_IN_PROGRESS = 0x80200044;
enum int BG_E_UPNP_ERROR = 0x80200045;
enum int BG_E_TEST_OPTION_BLOCKED_DOWNLOAD = 0x80200046;
enum int BG_E_PEERCACHING_DISABLED = 0x80200047;
enum int BG_E_BUSYCACHERECORD = 0x80200048;

enum : int
{
    BG_E_TOO_MANY_JOBS_PER_USER    = 0x80200049,
    BG_E_TOO_MANY_JOBS_PER_MACHINE = 0x80200050,
    BG_E_TOO_MANY_FILES_IN_JOB     = 0x80200051,
    BG_E_TOO_MANY_RANGES_IN_FILE   = 0x80200052,
}

enum int BG_E_VALIDATION_FAILED = 0x80200053;
enum int BG_E_MAXDOWNLOAD_TIMEOUT = 0x80200054;
enum int BG_S_OVERRIDDEN_BY_POLICY = 0x00200055;
enum int BG_E_TOKEN_REQUIRED = 0x80200056;
enum int BG_E_UNKNOWN_PROPERTY_ID = 0x80200057;
enum int BG_E_READ_ONLY_PROPERTY = 0x80200058;
enum int BG_E_BLOCKED_BY_COST_TRANSFER_POLICY = 0x80200059;
enum int BG_E_PROPERTY_SUPPORTED_FOR_DOWNLOAD_JOBS_ONLY = 0x80200060;

enum : int
{
    BG_E_READ_ONLY_PROPERTY_AFTER_ADDFILE = 0x80200061,
    BG_E_READ_ONLY_PROPERTY_AFTER_RESUME  = 0x80200062,
}

enum : int
{
    BG_E_MAX_DOWNLOAD_SIZE_INVALID_VALUE = 0x80200063,
    BG_E_MAX_DOWNLOAD_SIZE_LIMIT_REACHED = 0x80200064,
}

enum int BG_E_STANDBY_MODE = 0x80200065;
enum int BG_E_USE_STORED_CREDENTIALS_NOT_SUPPORTED = 0x80200066;

enum : int
{
    BG_E_BLOCKED_BY_BATTERY_POLICY = 0x80200067,
    BG_E_BLOCKED_BY_BATTERY_SAVER  = 0x80200068,
}

enum int BG_E_WATCHDOG_TIMEOUT = 0x80200069;

enum : int
{
    BG_E_APP_PACKAGE_NOT_FOUND              = 0x8020006a,
    BG_E_APP_PACKAGE_SCENARIO_NOT_SUPPORTED = 0x8020006b,
}

enum int BG_E_DATABASE_CORRUPT = 0x8020006c;
enum int BG_E_RANDOM_ACCESS_NOT_SUPPORTED = 0x8020006d;
enum int BG_E_BLOCKED_BY_BACKGROUND_ACCESS_POLICY = 0x8020006e;

enum : int
{
    BG_E_BLOCKED_BY_GAME_MODE     = 0x8020006f,
    BG_E_BLOCKED_BY_SYSTEM_POLICY = 0x80200070,
}

enum int BG_E_NOT_SUPPORTED_WITH_CUSTOM_HTTP_METHOD = 0x80200071;
enum int BG_E_UNSUPPORTED_JOB_CONFIGURATION = 0x80200072;
enum int BG_E_REMOTE_FILE_CHANGED = 0x80200073;
enum int BG_E_SERVER_CERT_VALIDATION_INTERFACE_REQUIRED = 0x80200074;
enum int BG_E_READ_ONLY_WHEN_JOB_ACTIVE = 0x80200075;
enum int BG_E_ERROR_CONTEXT_SERVER_CERTIFICATE_CALLBACK = 0x80200076;

enum : int
{
    BG_E_HTTP_ERROR_100 = 0x80190064,
    BG_E_HTTP_ERROR_101 = 0x80190065,
    BG_E_HTTP_ERROR_200 = 0x801900c8,
    BG_E_HTTP_ERROR_201 = 0x801900c9,
    BG_E_HTTP_ERROR_202 = 0x801900ca,
    BG_E_HTTP_ERROR_203 = 0x801900cb,
    BG_E_HTTP_ERROR_204 = 0x801900cc,
    BG_E_HTTP_ERROR_205 = 0x801900cd,
    BG_E_HTTP_ERROR_206 = 0x801900ce,
    BG_E_HTTP_ERROR_300 = 0x8019012c,
    BG_E_HTTP_ERROR_301 = 0x8019012d,
    BG_E_HTTP_ERROR_302 = 0x8019012e,
    BG_E_HTTP_ERROR_303 = 0x8019012f,
    BG_E_HTTP_ERROR_304 = 0x80190130,
    BG_E_HTTP_ERROR_305 = 0x80190131,
    BG_E_HTTP_ERROR_307 = 0x80190133,
    BG_E_HTTP_ERROR_400 = 0x80190190,
    BG_E_HTTP_ERROR_401 = 0x80190191,
    BG_E_HTTP_ERROR_402 = 0x80190192,
    BG_E_HTTP_ERROR_403 = 0x80190193,
    BG_E_HTTP_ERROR_404 = 0x80190194,
    BG_E_HTTP_ERROR_405 = 0x80190195,
    BG_E_HTTP_ERROR_406 = 0x80190196,
    BG_E_HTTP_ERROR_407 = 0x80190197,
    BG_E_HTTP_ERROR_408 = 0x80190198,
    BG_E_HTTP_ERROR_409 = 0x80190199,
    BG_E_HTTP_ERROR_410 = 0x8019019a,
    BG_E_HTTP_ERROR_411 = 0x8019019b,
    BG_E_HTTP_ERROR_412 = 0x8019019c,
    BG_E_HTTP_ERROR_413 = 0x8019019d,
    BG_E_HTTP_ERROR_414 = 0x8019019e,
    BG_E_HTTP_ERROR_415 = 0x8019019f,
    BG_E_HTTP_ERROR_416 = 0x801901a0,
    BG_E_HTTP_ERROR_417 = 0x801901a1,
    BG_E_HTTP_ERROR_449 = 0x801901c1,
    BG_E_HTTP_ERROR_500 = 0x801901f4,
    BG_E_HTTP_ERROR_501 = 0x801901f5,
    BG_E_HTTP_ERROR_502 = 0x801901f6,
    BG_E_HTTP_ERROR_503 = 0x801901f7,
    BG_E_HTTP_ERROR_504 = 0x801901f8,
    BG_E_HTTP_ERROR_505 = 0x801901f9,
}

enum int BITS_MC_JOB_CANCELLED = 0x80194000;

enum : int
{
    BITS_MC_FILE_DELETION_FAILED      = 0x80194001,
    BITS_MC_FILE_DELETION_FAILED_MORE = 0x80194002,
}

enum : int
{
    BITS_MC_JOB_PROPERTY_CHANGE      = 0x80194003,
    BITS_MC_JOB_TAKE_OWNERSHIP       = 0x80194004,
    BITS_MC_JOB_SCAVENGED            = 0x80194005,
    BITS_MC_JOB_NOTIFICATION_FAILURE = 0x80194006,
}

enum int BITS_MC_STATE_FILE_CORRUPT = 0x80194007;

enum : int
{
    BITS_MC_FAILED_TO_START = 0x80194008,
    BITS_MC_FATAL_IGD_ERROR = 0x80194009,
}

enum int BITS_MC_PEERCACHING_PORT = 0x8019400a;
enum int BITS_MC_WSD_PORT = 0x8019400b;

// Structs


//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/ns-bits-bg_file_progress))], [])
struct BG_FILE_PROGRESS
{
    ulong BytesTotal;
    ulong BytesTransferred;
    BOOL  Completed;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/ns-bits-bg_file_info))], [])
struct BG_FILE_INFO
{
    PWSTR RemoteName;
    PWSTR LocalName;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/ns-bits-bg_job_progress))], [])
struct BG_JOB_PROGRESS
{
    ulong BytesTotal;
    ulong BytesTransferred;
    uint  FilesTotal;
    uint  FilesTransferred;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/ns-bits-bg_job_times))], [])
struct BG_JOB_TIMES
{
    FILETIME CreationTime;
    FILETIME ModificationTime;
    FILETIME TransferCompletionTime;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits1_5/ns-bits1_5-bg_job_reply_progress))], [])
struct BG_JOB_REPLY_PROGRESS
{
    ulong BytesTotal;
    ulong BytesTransferred;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits1_5/ns-bits1_5-bg_basic_credentials))], [])
struct BG_BASIC_CREDENTIALS
{
    PWSTR UserName;
    PWSTR Password;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits1_5/ns-bits1_5-bg_auth_credentials_union))], [])
union BG_AUTH_CREDENTIALS_UNION
{
    BG_BASIC_CREDENTIALS Basic;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits1_5/ns-bits1_5-bg_auth_credentials))], [])
struct BG_AUTH_CREDENTIALS
{
    BG_AUTH_TARGET Target;
    BG_AUTH_SCHEME Scheme;
    BG_AUTH_CREDENTIALS_UNION Credentials;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits2_0/ns-bits2_0-bg_file_range))], [])
struct BG_FILE_RANGE
{
    ulong InitialOffset;
    ulong Length;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits5_0/ns-bits5_0-bits_job_property_value))], [])
union BITS_JOB_PROPERTY_VALUE
{
    uint           Dword;
    GUID           ClsID;
    BOOL           Enable;
    ulong          Uint64;
    BG_AUTH_TARGET Target;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits5_0/ns-bits5_0-bits_file_property_value))], [])
union BITS_FILE_PROPERTY_VALUE
{
    PWSTR String;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qmgr/ns-qmgr-filesetinfo))], [])
struct FILESETINFO
{
    BSTR bstrRemoteFile;
    BSTR bstrLocalFile;
    uint dwSizeHint;
}

// Interfaces

@GUID("4991d34b-80a1-4291-83b6-3328366b9097")
struct BackgroundCopyManager;

@GUID("f087771f-d74f-4c1a-bb8a-e16aca9124ea")
struct BackgroundCopyManager1_5;

@GUID("6d18ad12-bde3-4393-b311-099c346e6df9")
struct BackgroundCopyManager2_0;

@GUID("03ca98d6-ff5d-49b8-abc6-03dd84127020")
struct BackgroundCopyManager2_5;

@GUID("659cdea7-489e-11d9-a9cd-000d56965251")
struct BackgroundCopyManager3_0;

@GUID("bb6df56b-cace-11dc-9992-0019b93a3a84")
struct BackgroundCopyManager4_0;

@GUID("1ecca34c-e88a-44e3-8d6a-8921bde9e452")
struct BackgroundCopyManager5_0;

@GUID("4bd3e4e1-7bd4-4a2b-9964-496400de5193")
struct BackgroundCopyManager10_1;

@GUID("4575438f-a6c8-4976-b0fe-2f26b80d959e")
struct BackgroundCopyManager10_2;

@GUID("5fd42ad5-c04e-4d36-adc7-e08ff15737ad")
struct BackgroundCopyManager10_3;

@GUID("efbbab68-7286-4783-94bf-9461d8b7e7e9")
struct BITSExtensionSetupFactory;

@GUID("69ad4aee-51be-439b-a92c-86ae490e8b30")
struct BackgroundCopyQMgr;

@GUID("01b7bd23-fb88-4a77-8490-5891d3e4653a")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nn-bits-ibackgroundcopyfile))], [])
interface IBackgroundCopyFile : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ibackgroundcopyfile-getremotename))], [])
    HRESULT GetRemoteName(PWSTR* pVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ibackgroundcopyfile-getlocalname))], [])
    HRESULT GetLocalName(PWSTR* pVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ibackgroundcopyfile-getprogress))], [])
    HRESULT GetProgress(BG_FILE_PROGRESS* pVal);
}

@GUID("ca51e165-c365-424c-8d41-24aaa4ff3c40")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nn-bits-ienumbackgroundcopyfiles))], [])
interface IEnumBackgroundCopyFiles : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ienumbackgroundcopyfiles-next))], [])
    HRESULT Next(uint celt, IBackgroundCopyFile* rgelt, uint* pceltFetched);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ienumbackgroundcopyfiles-skip))], [])
    HRESULT Skip(uint celt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ienumbackgroundcopyfiles-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ienumbackgroundcopyfiles-clone))], [])
    HRESULT Clone(IEnumBackgroundCopyFiles* ppenum);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ienumbackgroundcopyfiles-getcount))], [])
    HRESULT GetCount(uint* puCount);
}

@GUID("19c613a0-fcb8-4f28-81ae-897c3d078f81")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nn-bits-ibackgroundcopyerror))], [])
interface IBackgroundCopyError : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ibackgroundcopyerror-geterror))], [])
    HRESULT GetError(BG_ERROR_CONTEXT* pContext, HRESULT* pCode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ibackgroundcopyerror-getfile))], [])
    HRESULT GetFile(IBackgroundCopyFile* pVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ibackgroundcopyerror-geterrordescription))], [])
    HRESULT GetErrorDescription(uint LanguageId, PWSTR* pErrorDescription);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ibackgroundcopyerror-geterrorcontextdescription))], [])
    HRESULT GetErrorContextDescription(uint LanguageId, PWSTR* pContextDescription);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ibackgroundcopyerror-getprotocol))], [])
    HRESULT GetProtocol(PWSTR* pProtocol);
}

@GUID("37668d37-507e-4160-9316-26306d150b12")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nn-bits-ibackgroundcopyjob))], [])
interface IBackgroundCopyJob : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ibackgroundcopyjob-addfileset))], [])
    HRESULT AddFileSet(uint cFileCount, BG_FILE_INFO* pFileSet);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ibackgroundcopyjob-addfile))], [])
    HRESULT AddFile(const(PWSTR) RemoteUrl, const(PWSTR) LocalName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ibackgroundcopyjob-enumfiles))], [])
    HRESULT EnumFiles(IEnumBackgroundCopyFiles* pEnum);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ibackgroundcopyjob-suspend))], [])
    HRESULT Suspend();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ibackgroundcopyjob-resume))], [])
    HRESULT Resume();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ibackgroundcopyjob-cancel))], [])
    HRESULT Cancel();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ibackgroundcopyjob-complete))], [])
    HRESULT Complete();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ibackgroundcopyjob-getid))], [])
    HRESULT GetId(GUID* pVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ibackgroundcopyjob-gettype))], [])
    HRESULT GetType(BG_JOB_TYPE* pVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ibackgroundcopyjob-getprogress))], [])
    HRESULT GetProgress(BG_JOB_PROGRESS* pVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ibackgroundcopyjob-gettimes))], [])
    HRESULT GetTimes(BG_JOB_TIMES* pVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ibackgroundcopyjob-getstate))], [])
    HRESULT GetState(BG_JOB_STATE* pVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ibackgroundcopyjob-geterror))], [])
    HRESULT GetError(IBackgroundCopyError* ppError);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ibackgroundcopyjob-getowner))], [])
    HRESULT GetOwner(/*PARAM ATTR: FreeWithAttribute : CustomAttributeSig([FixedArgSig(ElementSig(CoTaskMemFree))], [])*/PWSTR* pVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ibackgroundcopyjob-setdisplayname))], [])
    HRESULT SetDisplayName(const(PWSTR) Val);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ibackgroundcopyjob-getdisplayname))], [])
    HRESULT GetDisplayName(/*PARAM ATTR: FreeWithAttribute : CustomAttributeSig([FixedArgSig(ElementSig(CoTaskMemFree))], [])*/PWSTR* pVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ibackgroundcopyjob-setdescription))], [])
    HRESULT SetDescription(const(PWSTR) Val);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ibackgroundcopyjob-getdescription))], [])
    HRESULT GetDescription(/*PARAM ATTR: FreeWithAttribute : CustomAttributeSig([FixedArgSig(ElementSig(CoTaskMemFree))], [])*/PWSTR* pVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ibackgroundcopyjob-setpriority))], [])
    HRESULT SetPriority(BG_JOB_PRIORITY Val);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ibackgroundcopyjob-getpriority))], [])
    HRESULT GetPriority(BG_JOB_PRIORITY* pVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ibackgroundcopyjob-setnotifyflags))], [])
    HRESULT SetNotifyFlags(uint Val);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ibackgroundcopyjob-getnotifyflags))], [])
    HRESULT GetNotifyFlags(uint* pVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ibackgroundcopyjob-setnotifyinterface))], [])
    HRESULT SetNotifyInterface(IUnknown Val);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ibackgroundcopyjob-getnotifyinterface))], [])
    HRESULT GetNotifyInterface(IUnknown* pVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ibackgroundcopyjob-setminimumretrydelay))], [])
    HRESULT SetMinimumRetryDelay(uint Seconds);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ibackgroundcopyjob-getminimumretrydelay))], [])
    HRESULT GetMinimumRetryDelay(uint* Seconds);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ibackgroundcopyjob-setnoprogresstimeout))], [])
    HRESULT SetNoProgressTimeout(uint Seconds);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ibackgroundcopyjob-getnoprogresstimeout))], [])
    HRESULT GetNoProgressTimeout(uint* Seconds);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ibackgroundcopyjob-geterrorcount))], [])
    HRESULT GetErrorCount(uint* Errors);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ibackgroundcopyjob-setproxysettings))], [])
    HRESULT SetProxySettings(BG_JOB_PROXY_USAGE ProxyUsage, const(PWSTR) ProxyList, const(PWSTR) ProxyBypassList);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ibackgroundcopyjob-getproxysettings))], [])
    HRESULT GetProxySettings(BG_JOB_PROXY_USAGE* pProxyUsage, 
                             /*PARAM ATTR: FreeWithAttribute : CustomAttributeSig([FixedArgSig(ElementSig(CoTaskMemFree))], [])*/PWSTR* pProxyList, 
                             /*PARAM ATTR: FreeWithAttribute : CustomAttributeSig([FixedArgSig(ElementSig(CoTaskMemFree))], [])*/PWSTR* pProxyBypassList);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ibackgroundcopyjob-takeownership))], [])
    HRESULT TakeOwnership();
}

@GUID("1af4f612-3b71-466f-8f58-7b6f73ac57ad")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nn-bits-ienumbackgroundcopyjobs))], [])
interface IEnumBackgroundCopyJobs : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ienumbackgroundcopyjobs-next))], [])
    HRESULT Next(uint celt, IBackgroundCopyJob* rgelt, uint* pceltFetched);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ienumbackgroundcopyjobs-skip))], [])
    HRESULT Skip(uint celt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ienumbackgroundcopyjobs-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ienumbackgroundcopyjobs-clone))], [])
    HRESULT Clone(IEnumBackgroundCopyJobs* ppenum);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ienumbackgroundcopyjobs-getcount))], [])
    HRESULT GetCount(uint* puCount);
}

@GUID("97ea99c7-0186-4ad4-8df9-c5b4e0ed6b22")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nn-bits-ibackgroundcopycallback))], [])
interface IBackgroundCopyCallback : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ibackgroundcopycallback-jobtransferred))], [])
    HRESULT JobTransferred(IBackgroundCopyJob pJob);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ibackgroundcopycallback-joberror))], [])
    HRESULT JobError(IBackgroundCopyJob pJob, IBackgroundCopyError pError);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ibackgroundcopycallback-jobmodification))], [])
    HRESULT JobModification(IBackgroundCopyJob pJob, uint dwReserved);
}

@GUID("ca29d251-b4bb-4679-a3d9-ae8006119d54")
interface AsyncIBackgroundCopyCallback : IUnknown
{
    HRESULT Begin_JobTransferred(IBackgroundCopyJob pJob);
    HRESULT Finish_JobTransferred();
    HRESULT Begin_JobError(IBackgroundCopyJob pJob, IBackgroundCopyError pError);
    HRESULT Finish_JobError();
    HRESULT Begin_JobModification(IBackgroundCopyJob pJob, uint dwReserved);
    HRESULT Finish_JobModification();
}

@GUID("5ce34c0d-0dc9-4c1f-897c-daa1b78cee7c")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nn-bits-ibackgroundcopymanager))], [])
interface IBackgroundCopyManager : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ibackgroundcopymanager-createjob))], [])
    HRESULT CreateJob(const(PWSTR) DisplayName, BG_JOB_TYPE Type, GUID* pJobId, IBackgroundCopyJob* ppJob);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ibackgroundcopymanager-getjob))], [])
    HRESULT GetJob(const(GUID)* jobID, IBackgroundCopyJob* ppJob);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ibackgroundcopymanager-enumjobs))], [])
    HRESULT EnumJobs(uint dwFlags, IEnumBackgroundCopyJobs* ppEnum);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits/nf-bits-ibackgroundcopymanager-geterrordescription))], [])
    HRESULT GetErrorDescription(HRESULT hResult, uint LanguageId, 
                                /*PARAM ATTR: FreeWithAttribute : CustomAttributeSig([FixedArgSig(ElementSig(CoTaskMemFree))], [])*/PWSTR* pErrorDescription);
}

@GUID("54b50739-686f-45eb-9dff-d6a9a0faa9af")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits1_5/nn-bits1_5-ibackgroundcopyjob2))], [])
interface IBackgroundCopyJob2 : IBackgroundCopyJob
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits1_5/nf-bits1_5-ibackgroundcopyjob2-setnotifycmdline))], [])
    HRESULT SetNotifyCmdLine(const(PWSTR) Program, const(PWSTR) Parameters);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits1_5/nf-bits1_5-ibackgroundcopyjob2-getnotifycmdline))], [])
    HRESULT GetNotifyCmdLine(PWSTR* pProgram, PWSTR* pParameters);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits1_5/nf-bits1_5-ibackgroundcopyjob2-getreplyprogress))], [])
    HRESULT GetReplyProgress(BG_JOB_REPLY_PROGRESS* pProgress);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits1_5/nf-bits1_5-ibackgroundcopyjob2-getreplydata))], [])
    HRESULT GetReplyData(ubyte** ppBuffer, ulong* pLength);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits1_5/nf-bits1_5-ibackgroundcopyjob2-setreplyfilename))], [])
    HRESULT SetReplyFileName(const(PWSTR) ReplyFileName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits1_5/nf-bits1_5-ibackgroundcopyjob2-getreplyfilename))], [])
    HRESULT GetReplyFileName(PWSTR* pReplyFileName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits1_5/nf-bits1_5-ibackgroundcopyjob2-setcredentials))], [])
    HRESULT SetCredentials(BG_AUTH_CREDENTIALS* credentials);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits1_5/nf-bits1_5-ibackgroundcopyjob2-removecredentials))], [])
    HRESULT RemoveCredentials(BG_AUTH_TARGET Target, BG_AUTH_SCHEME Scheme);
}

@GUID("443c8934-90ff-48ed-bcde-26f5c7450042")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits2_0/nn-bits2_0-ibackgroundcopyjob3))], [])
interface IBackgroundCopyJob3 : IBackgroundCopyJob2
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits2_0/nf-bits2_0-ibackgroundcopyjob3-replaceremoteprefix))], [])
    HRESULT ReplaceRemotePrefix(const(PWSTR) OldPrefix, const(PWSTR) NewPrefix);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits2_0/nf-bits2_0-ibackgroundcopyjob3-addfilewithranges))], [])
    HRESULT AddFileWithRanges(const(PWSTR) RemoteUrl, const(PWSTR) LocalName, uint RangeCount, 
                              BG_FILE_RANGE* Ranges);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits2_0/nf-bits2_0-ibackgroundcopyjob3-setfileaclflags))], [])
    HRESULT SetFileACLFlags(uint Flags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits2_0/nf-bits2_0-ibackgroundcopyjob3-getfileaclflags))], [])
    HRESULT GetFileACLFlags(uint* Flags);
}

@GUID("83e81b93-0873-474d-8a8c-f2018b1a939c")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits2_0/nn-bits2_0-ibackgroundcopyfile2))], [])
interface IBackgroundCopyFile2 : IBackgroundCopyFile
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits2_0/nf-bits2_0-ibackgroundcopyfile2-getfileranges))], [])
    HRESULT GetFileRanges(uint* RangeCount, 
                          /*PARAM ATTR: FreeWithAttribute : CustomAttributeSig([FixedArgSig(ElementSig(CoTaskMemFree))], [])*/BG_FILE_RANGE** Ranges);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits2_0/nf-bits2_0-ibackgroundcopyfile2-setremotename))], [])
    HRESULT SetRemoteName(const(PWSTR) Val);
}

@GUID("f1bd1079-9f01-4bdc-8036-f09b70095066")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits2_5/nn-bits2_5-ibackgroundcopyjobhttpoptions))], [])
interface IBackgroundCopyJobHttpOptions : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits2_5/nf-bits2_5-ibackgroundcopyjobhttpoptions-setclientcertificatebyid))], [])
    HRESULT SetClientCertificateByID(BG_CERT_STORE_LOCATION StoreLocation, const(PWSTR) StoreName, 
                                     ubyte* pCertHashBlob);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits2_5/nf-bits2_5-ibackgroundcopyjobhttpoptions-setclientcertificatebyname))], [])
    HRESULT SetClientCertificateByName(BG_CERT_STORE_LOCATION StoreLocation, const(PWSTR) StoreName, 
                                       const(PWSTR) SubjectName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits2_5/nf-bits2_5-ibackgroundcopyjobhttpoptions-removeclientcertificate))], [])
    HRESULT RemoveClientCertificate();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits2_5/nf-bits2_5-ibackgroundcopyjobhttpoptions-getclientcertificate))], [])
    HRESULT GetClientCertificate(BG_CERT_STORE_LOCATION* pStoreLocation, PWSTR* pStoreName, 
                                 /*PARAM ATTR: FreeWithAttribute : CustomAttributeSig([FixedArgSig(ElementSig(CoTaskMemFree))], [])*/ubyte** ppCertHashBlob, 
                                 /*PARAM ATTR: FreeWithAttribute : CustomAttributeSig([FixedArgSig(ElementSig(CoTaskMemFree))], [])*/PWSTR* pSubjectName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits2_5/nf-bits2_5-ibackgroundcopyjobhttpoptions-setcustomheaders))], [])
    HRESULT SetCustomHeaders(const(PWSTR) RequestHeaders);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits2_5/nf-bits2_5-ibackgroundcopyjobhttpoptions-getcustomheaders))], [])
    HRESULT GetCustomHeaders(/*PARAM ATTR: FreeWithAttribute : CustomAttributeSig([FixedArgSig(ElementSig(CoTaskMemFree))], [])*/PWSTR* pRequestHeaders);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits2_5/nf-bits2_5-ibackgroundcopyjobhttpoptions-setsecurityflags))], [])
    HRESULT SetSecurityFlags(uint Flags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits2_5/nf-bits2_5-ibackgroundcopyjobhttpoptions-getsecurityflags))], [])
    HRESULT GetSecurityFlags(uint* pFlags);
}

@GUID("659cdeaf-489e-11d9-a9cd-000d56965251")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nn-bits3_0-ibitspeercacherecord))], [])
interface IBitsPeerCacheRecord : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nf-bits3_0-ibitspeercacherecord-getid))], [])
    HRESULT GetId(GUID* pVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nf-bits3_0-ibitspeercacherecord-getoriginurl))], [])
    HRESULT GetOriginUrl(PWSTR* pVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nf-bits3_0-ibitspeercacherecord-getfilesize))], [])
    HRESULT GetFileSize(ulong* pVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nf-bits3_0-ibitspeercacherecord-getfilemodificationtime))], [])
    HRESULT GetFileModificationTime(FILETIME* pVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nf-bits3_0-ibitspeercacherecord-getlastaccesstime))], [])
    HRESULT GetLastAccessTime(FILETIME* pVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nf-bits3_0-ibitspeercacherecord-isfilevalidated))], [])
    HRESULT IsFileValidated();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nf-bits3_0-ibitspeercacherecord-getfileranges))], [])
    HRESULT GetFileRanges(uint* pRangeCount, BG_FILE_RANGE** ppRanges);
}

@GUID("659cdea4-489e-11d9-a9cd-000d56965251")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nn-bits3_0-ienumbitspeercacherecords))], [])
interface IEnumBitsPeerCacheRecords : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nf-bits3_0-ienumbitspeercacherecords-next))], [])
    HRESULT Next(uint celt, IBitsPeerCacheRecord* rgelt, uint* pceltFetched);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nf-bits3_0-ienumbitspeercacherecords-skip))], [])
    HRESULT Skip(uint celt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nf-bits3_0-ienumbitspeercacherecords-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nf-bits3_0-ienumbitspeercacherecords-clone))], [])
    HRESULT Clone(IEnumBitsPeerCacheRecords* ppenum);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nf-bits3_0-ienumbitspeercacherecords-getcount))], [])
    HRESULT GetCount(uint* puCount);
}

@GUID("659cdea2-489e-11d9-a9cd-000d56965251")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nn-bits3_0-ibitspeer))], [])
interface IBitsPeer : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nf-bits3_0-ibitspeer-getpeername))], [])
    HRESULT GetPeerName(PWSTR* pName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nf-bits3_0-ibitspeer-isauthenticated))], [])
    HRESULT IsAuthenticated(BOOL* pAuth);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nf-bits3_0-ibitspeer-isavailable))], [])
    HRESULT IsAvailable(BOOL* pOnline);
}

@GUID("659cdea5-489e-11d9-a9cd-000d56965251")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nn-bits3_0-ienumbitspeers))], [])
interface IEnumBitsPeers : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nf-bits3_0-ienumbitspeers-next))], [])
    HRESULT Next(uint celt, IBitsPeer* rgelt, uint* pceltFetched);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nf-bits3_0-ienumbitspeers-skip))], [])
    HRESULT Skip(uint celt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nf-bits3_0-ienumbitspeers-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nf-bits3_0-ienumbitspeers-clone))], [])
    HRESULT Clone(IEnumBitsPeers* ppenum);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nf-bits3_0-ienumbitspeers-getcount))], [])
    HRESULT GetCount(uint* puCount);
}

@GUID("659cdead-489e-11d9-a9cd-000d56965251")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nn-bits3_0-ibitspeercacheadministration))], [])
interface IBitsPeerCacheAdministration : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nf-bits3_0-ibitspeercacheadministration-getmaximumcachesize))], [])
    HRESULT GetMaximumCacheSize(uint* pBytes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nf-bits3_0-ibitspeercacheadministration-setmaximumcachesize))], [])
    HRESULT SetMaximumCacheSize(uint Bytes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nf-bits3_0-ibitspeercacheadministration-getmaximumcontentage))], [])
    HRESULT GetMaximumContentAge(uint* pSeconds);
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT SetMaximumContentAge(uint Seconds);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nf-bits3_0-ibitspeercacheadministration-getconfigurationflags))], [])
    HRESULT GetConfigurationFlags(uint* pFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nf-bits3_0-ibitspeercacheadministration-setconfigurationflags))], [])
    HRESULT SetConfigurationFlags(uint Flags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nf-bits3_0-ibitspeercacheadministration-enumrecords))], [])
    HRESULT EnumRecords(IEnumBitsPeerCacheRecords* ppEnum);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nf-bits3_0-ibitspeercacheadministration-getrecord))], [])
    HRESULT GetRecord(const(GUID)* id, IBitsPeerCacheRecord* ppRecord);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nf-bits3_0-ibitspeercacheadministration-clearrecords))], [])
    HRESULT ClearRecords();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nf-bits3_0-ibitspeercacheadministration-deleterecord))], [])
    HRESULT DeleteRecord(const(GUID)* id);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nf-bits3_0-ibitspeercacheadministration-deleteurl))], [])
    HRESULT DeleteUrl(const(PWSTR) url);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nf-bits3_0-ibitspeercacheadministration-enumpeers))], [])
    HRESULT EnumPeers(IEnumBitsPeers* ppEnum);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nf-bits3_0-ibitspeercacheadministration-clearpeers))], [])
    HRESULT ClearPeers();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nf-bits3_0-ibitspeercacheadministration-discoverpeers))], [])
    HRESULT DiscoverPeers();
}

@GUID("659cdeae-489e-11d9-a9cd-000d56965251")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nn-bits3_0-ibackgroundcopyjob4))], [])
interface IBackgroundCopyJob4 : IBackgroundCopyJob3
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nf-bits3_0-ibackgroundcopyjob4-setpeercachingflags))], [])
    HRESULT SetPeerCachingFlags(uint Flags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nf-bits3_0-ibackgroundcopyjob4-getpeercachingflags))], [])
    HRESULT GetPeerCachingFlags(uint* pFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nf-bits3_0-ibackgroundcopyjob4-getownerintegritylevel))], [])
    HRESULT GetOwnerIntegrityLevel(uint* pLevel);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nf-bits3_0-ibackgroundcopyjob4-getownerelevationstate))], [])
    HRESULT GetOwnerElevationState(BOOL* pElevated);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nf-bits3_0-ibackgroundcopyjob4-setmaximumdownloadtime))], [])
    HRESULT SetMaximumDownloadTime(uint Timeout);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nf-bits3_0-ibackgroundcopyjob4-getmaximumdownloadtime))], [])
    HRESULT GetMaximumDownloadTime(uint* pTimeout);
}

@GUID("659cdeaa-489e-11d9-a9cd-000d56965251")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nn-bits3_0-ibackgroundcopyfile3))], [])
interface IBackgroundCopyFile3 : IBackgroundCopyFile2
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nf-bits3_0-ibackgroundcopyfile3-gettemporaryname))], [])
    HRESULT GetTemporaryName(/*PARAM ATTR: FreeWithAttribute : CustomAttributeSig([FixedArgSig(ElementSig(CoTaskMemFree))], [])*/PWSTR* pFilename);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nf-bits3_0-ibackgroundcopyfile3-setvalidationstate))], [])
    HRESULT SetValidationState(BOOL state);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nf-bits3_0-ibackgroundcopyfile3-getvalidationstate))], [])
    HRESULT GetValidationState(BOOL* pState);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nf-bits3_0-ibackgroundcopyfile3-isdownloadedfrompeer))], [])
    HRESULT IsDownloadedFromPeer(BOOL* pVal);
}

@GUID("659cdeac-489e-11d9-a9cd-000d56965251")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nn-bits3_0-ibackgroundcopycallback2))], [])
interface IBackgroundCopyCallback2 : IBackgroundCopyCallback
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits3_0/nf-bits3_0-ibackgroundcopycallback2-filetransferred))], [])
    HRESULT FileTransferred(IBackgroundCopyJob pJob, IBackgroundCopyFile pFile);
}

@GUID("9a2584c3-f7d2-457a-9a5e-22b67bffc7d2")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits4_0/nn-bits4_0-ibitstokenoptions))], [])
interface IBitsTokenOptions : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits4_0/nf-bits4_0-ibitstokenoptions-sethelpertokenflags))], [])
    HRESULT SetHelperTokenFlags(BG_TOKEN UsageFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits4_0/nf-bits4_0-ibitstokenoptions-gethelpertokenflags))], [])
    HRESULT GetHelperTokenFlags(BG_TOKEN* pFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits4_0/nf-bits4_0-ibitstokenoptions-sethelpertoken))], [])
    HRESULT SetHelperToken();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits4_0/nf-bits4_0-ibitstokenoptions-clearhelpertoken))], [])
    HRESULT ClearHelperToken();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits4_0/nf-bits4_0-ibitstokenoptions-gethelpertokensid))], [])
    HRESULT GetHelperTokenSid(PWSTR* pSid);
}

@GUID("ef7e0655-7888-4960-b0e5-730846e03492")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits4_0/nn-bits4_0-ibackgroundcopyfile4))], [])
interface IBackgroundCopyFile4 : IBackgroundCopyFile3
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits4_0/nf-bits4_0-ibackgroundcopyfile4-getpeerdownloadstats))], [])
    HRESULT GetPeerDownloadStats(ulong* pFromOrigin, ulong* pFromPeers);
}

@GUID("e847030c-bbba-4657-af6d-484aa42bf1fe")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits5_0/nn-bits5_0-ibackgroundcopyjob5))], [])
interface IBackgroundCopyJob5 : IBackgroundCopyJob4
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits5_0/nf-bits5_0-ibackgroundcopyjob5-setproperty))], [])
    HRESULT SetProperty(BITS_JOB_PROPERTY_ID PropertyId, BITS_JOB_PROPERTY_VALUE PropertyValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits5_0/nf-bits5_0-ibackgroundcopyjob5-getproperty))], [])
    HRESULT GetProperty(BITS_JOB_PROPERTY_ID PropertyId, BITS_JOB_PROPERTY_VALUE* PropertyValue);
}

@GUID("85c1657f-dafc-40e8-8834-df18ea25717e")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits5_0/nn-bits5_0-ibackgroundcopyfile5))], [])
interface IBackgroundCopyFile5 : IBackgroundCopyFile4
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits5_0/nf-bits5_0-ibackgroundcopyfile5-setproperty))], [])
    HRESULT SetProperty(BITS_FILE_PROPERTY_ID PropertyId, BITS_FILE_PROPERTY_VALUE PropertyValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits5_0/nf-bits5_0-ibackgroundcopyfile5-getproperty))], [])
    HRESULT GetProperty(BITS_FILE_PROPERTY_ID PropertyId, BITS_FILE_PROPERTY_VALUE* PropertyValue);
}

@GUID("98c97bd2-e32b-4ad8-a528-95fd8b16bd42")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits10_1/nn-bits10_1-ibackgroundcopycallback3))], [])
interface IBackgroundCopyCallback3 : IBackgroundCopyCallback2
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits10_1/nf-bits10_1-ibackgroundcopycallback3-filerangestransferred))], [])
    HRESULT FileRangesTransferred(IBackgroundCopyJob job, IBackgroundCopyFile file, uint rangeCount, 
                                  const(BG_FILE_RANGE)* ranges);
}

@GUID("cf6784f7-d677-49fd-9368-cb47aee9d1ad")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits10_1/nn-bits10_1-ibackgroundcopyfile6))], [])
interface IBackgroundCopyFile6 : IBackgroundCopyFile5
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits10_1/nf-bits10_1-ibackgroundcopyfile6-updatedownloadposition))], [])
    HRESULT UpdateDownloadPosition(ulong offset);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits10_1/nf-bits10_1-ibackgroundcopyfile6-requestfileranges))], [])
    HRESULT RequestFileRanges(uint rangeCount, const(BG_FILE_RANGE)* ranges);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits10_1/nf-bits10_1-ibackgroundcopyfile6-getfilledfileranges))], [])
    HRESULT GetFilledFileRanges(uint* rangeCount, BG_FILE_RANGE** ranges);
}

@GUID("b591a192-a405-4fc3-8323-4c5c542578fc")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17763))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits10_2/nn-bits10_2-ibackgroundcopyjobhttpoptions2))], [])
interface IBackgroundCopyJobHttpOptions2 : IBackgroundCopyJobHttpOptions
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits10_2/nf-bits10_2-ibackgroundcopyjobhttpoptions2-sethttpmethod))], [])
    HRESULT SetHttpMethod(const(PWSTR) method);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits10_2/nf-bits10_2-ibackgroundcopyjobhttpoptions2-gethttpmethod))], [])
    HRESULT GetHttpMethod(/*PARAM ATTR: FreeWithAttribute : CustomAttributeSig([FixedArgSig(ElementSig(CoTaskMemFree))], [])*/PWSTR* method);
}

@GUID("4cec0d02-def7-4158-813a-c32a46945ff7")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits10_3/nn-bits10_3-ibackgroundcopyservercertificatevalidationcallback))], [])
interface IBackgroundCopyServerCertificateValidationCallback : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits10_3/nf-bits10_3-ibackgroundcopyservercertificatevalidationcallback-validateservercertificate))], [])
    HRESULT ValidateServerCertificate(IBackgroundCopyJob job, IBackgroundCopyFile file, uint certLength, 
                                      const(ubyte)* certData, uint certEncodingType, uint certStoreLength, 
                                      const(ubyte)* certStoreData);
}

@GUID("8a9263d3-fd4c-4eda-9b28-30132a4d4e3c")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits10_3/nn-bits10_3-ibackgroundcopyjobhttpoptions3))], [])
interface IBackgroundCopyJobHttpOptions3 : IBackgroundCopyJobHttpOptions2
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits10_3/nf-bits10_3-ibackgroundcopyjobhttpoptions3-setservercertificatevalidationinterface))], [])
    HRESULT SetServerCertificateValidationInterface(IUnknown certValidationCallback);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bits10_3/nf-bits10_3-ibackgroundcopyjobhttpoptions3-makecustomheaderswriteonly))], [])
    HRESULT MakeCustomHeadersWriteOnly();
}

@GUID("29cfbbf7-09e4-4b97-b0bc-f2287e3d8eb3")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bitscfg/nn-bitscfg-ibitsextensionsetup))], [])
interface IBITSExtensionSetup : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bitscfg/nf-bitscfg-ibitsextensionsetup-enablebitsuploads))], [])
    HRESULT EnableBITSUploads();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bitscfg/nf-bitscfg-ibitsextensionsetup-disablebitsuploads))], [])
    HRESULT DisableBITSUploads();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bitscfg/nf-bitscfg-ibitsextensionsetup-getcleanuptaskname))], [])
    HRESULT GetCleanupTaskName(BSTR* pTaskName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bitscfg/nf-bitscfg-ibitsextensionsetup-getcleanuptask))], [])
    HRESULT GetCleanupTask(const(GUID)* riid, IUnknown* ppUnk);
}

@GUID("d5d2d542-5503-4e64-8b48-72ef91a32ee1")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bitscfg/nn-bitscfg-ibitsextensionsetupfactory))], [])
interface IBITSExtensionSetupFactory : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/bitscfg/nf-bitscfg-ibitsextensionsetupfactory-getobject))], [])
    HRESULT GetObject(BSTR Path, IBITSExtensionSetup* ppExtensionSetup);
}

@GUID("59f5553c-2031-4629-bb18-2645a6970947")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qmgr/nn-qmgr-ibackgroundcopyjob1))], [])
interface IBackgroundCopyJob1 : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qmgr/nn-qmgr-ibackgroundcopyjob1))], [])
    HRESULT CancelJob();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qmgr/nf-qmgr-ibackgroundcopyjob1-getprogress))], [])
    HRESULT GetProgress(uint dwFlags, uint* pdwProgress);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qmgr/nf-qmgr-ibackgroundcopyjob1-getstatus))], [])
    HRESULT GetStatus(uint* pdwStatus, uint* pdwWin32Result, uint* pdwTransportResult, uint* pdwNumOfRetries);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qmgr/nf-qmgr-ibackgroundcopyjob1-addfiles))], [])
    HRESULT AddFiles(uint cFileCount, FILESETINFO** ppFileSet);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qmgr/nf-qmgr-ibackgroundcopyjob1-getfile))], [])
    HRESULT GetFile(uint cFileIndex, FILESETINFO* pFileInfo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qmgr/nf-qmgr-ibackgroundcopyjob1-getfilecount))], [])
    HRESULT GetFileCount(uint* pdwFileCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qmgr/nn-qmgr-ibackgroundcopyjob1))], [])
    HRESULT SwitchToForeground();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qmgr/nf-qmgr-ibackgroundcopyjob1-get_jobid))], [])
    HRESULT get_JobID(GUID* pguidJobID);
}

@GUID("8baeba9d-8f1c-42c4-b82c-09ae79980d25")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qmgr/nn-qmgr-ienumbackgroundcopyjobs1))], [])
interface IEnumBackgroundCopyJobs1 : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qmgr/nf-qmgr-ienumbackgroundcopyjobs1-next))], [])
    HRESULT Next(uint celt, GUID* rgelt, uint* pceltFetched);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qmgr/nf-qmgr-ienumbackgroundcopyjobs1-skip))], [])
    HRESULT Skip(uint celt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qmgr/nf-qmgr-ienumbackgroundcopyjobs1-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qmgr/nf-qmgr-ienumbackgroundcopyjobs1-clone))], [])
    HRESULT Clone(IEnumBackgroundCopyJobs1* ppenum);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qmgr/nf-qmgr-ienumbackgroundcopyjobs1-getcount))], [])
    HRESULT GetCount(uint* puCount);
}

@GUID("1ded80a7-53ea-424f-8a04-17fea9adc4f5")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qmgr/nn-qmgr-ibackgroundcopygroup))], [])
interface IBackgroundCopyGroup : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qmgr/nf-qmgr-ibackgroundcopygroup-getprop))], [])
    HRESULT GetProp(GROUPPROP propID, VARIANT* pvarVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qmgr/nf-qmgr-ibackgroundcopygroup-setprop))], [])
    HRESULT SetProp(GROUPPROP propID, VARIANT* pvarVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qmgr/nf-qmgr-ibackgroundcopygroup-getprogress))], [])
    HRESULT GetProgress(uint dwFlags, uint* pdwProgress);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qmgr/nf-qmgr-ibackgroundcopygroup-getstatus))], [])
    HRESULT GetStatus(uint* pdwStatus, uint* pdwJobIndex);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qmgr/nf-qmgr-ibackgroundcopygroup-getjob))], [])
    HRESULT GetJob(GUID jobID, IBackgroundCopyJob1* ppJob);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qmgr/nf-qmgr-ibackgroundcopygroup-suspendgroup))], [])
    HRESULT SuspendGroup();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qmgr/nf-qmgr-ibackgroundcopygroup-resumegroup))], [])
    HRESULT ResumeGroup();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qmgr/nf-qmgr-ibackgroundcopygroup-cancelgroup))], [])
    HRESULT CancelGroup();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qmgr/nf-qmgr-ibackgroundcopygroup-get_size))], [])
    HRESULT get_Size(uint* pdwSize);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qmgr/nf-qmgr-ibackgroundcopygroup-get_groupid))], [])
    HRESULT get_GroupID(GUID* pguidGroupID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qmgr/nf-qmgr-ibackgroundcopygroup-createjob))], [])
    HRESULT CreateJob(GUID guidJobID, IBackgroundCopyJob1* ppJob);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qmgr/nf-qmgr-ibackgroundcopygroup-enumjobs))], [])
    HRESULT EnumJobs(uint dwFlags, IEnumBackgroundCopyJobs1* ppEnumJobs);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qmgr/nf-qmgr-ibackgroundcopygroup-switchtoforeground))], [])
    HRESULT SwitchToForeground();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qmgr/nn-qmgr-ibackgroundcopygroup))], [])
    HRESULT QueryNewJobInterface(const(GUID)* iid, IUnknown* pUnk);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qmgr/nn-qmgr-ibackgroundcopygroup))], [])
    HRESULT SetNotificationPointer(const(GUID)* iid, IUnknown pUnk);
}

@GUID("d993e603-4aa4-47c5-8665-c20d39c2ba4f")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qmgr/nn-qmgr-ienumbackgroundcopygroups))], [])
interface IEnumBackgroundCopyGroups : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qmgr/nf-qmgr-ienumbackgroundcopygroups-next))], [])
    HRESULT Next(uint celt, GUID* rgelt, uint* pceltFetched);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qmgr/nf-qmgr-ienumbackgroundcopygroups-skip))], [])
    HRESULT Skip(uint celt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qmgr/nf-qmgr-ienumbackgroundcopygroups-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qmgr/nf-qmgr-ienumbackgroundcopygroups-clone))], [])
    HRESULT Clone(IEnumBackgroundCopyGroups* ppenum);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qmgr/nf-qmgr-ienumbackgroundcopygroups-getcount))], [])
    HRESULT GetCount(uint* puCount);
}

@GUID("084f6593-3800-4e08-9b59-99fa59addf82")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qmgr/nn-qmgr-ibackgroundcopycallback1))], [])
interface IBackgroundCopyCallback1 : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qmgr/nf-qmgr-ibackgroundcopycallback1-onstatus))], [])
    HRESULT OnStatus(IBackgroundCopyGroup pGroup, IBackgroundCopyJob1 pJob, uint dwFileIndex, uint dwStatus, 
                     uint dwNumOfRetries, uint dwWin32Result, uint dwTransportResult);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qmgr/nn-qmgr-ibackgroundcopycallback1))], [])
    HRESULT OnProgress(uint ProgressType, IBackgroundCopyGroup pGroup, IBackgroundCopyJob1 pJob, uint dwFileIndex, 
                       uint dwProgressValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qmgr/nn-qmgr-ibackgroundcopycallback1))], [])
    HRESULT OnProgressEx(uint ProgressType, IBackgroundCopyGroup pGroup, IBackgroundCopyJob1 pJob, 
                         uint dwFileIndex, uint dwProgressValue, uint dwByteArraySize, ubyte* pByte);
}

@GUID("16f41c69-09f5-41d2-8cd8-3c08c47bc8a8")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qmgr/nn-qmgr-ibackgroundcopyqmgr))], [])
interface IBackgroundCopyQMgr : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qmgr/nf-qmgr-ibackgroundcopyqmgr-creategroup))], [])
    HRESULT CreateGroup(GUID guidGroupID, IBackgroundCopyGroup* ppGroup);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qmgr/nf-qmgr-ibackgroundcopyqmgr-getgroup))], [])
    HRESULT GetGroup(GUID groupID, IBackgroundCopyGroup* ppGroup);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qmgr/nf-qmgr-ibackgroundcopyqmgr-enumgroups))], [])
    HRESULT EnumGroups(uint dwFlags, IEnumBackgroundCopyGroups* ppEnumGroups);
}


// GUIDs

const GUID CLSID_BITSExtensionSetupFactory = GUIDOF!BITSExtensionSetupFactory;
const GUID CLSID_BackgroundCopyManager     = GUIDOF!BackgroundCopyManager;
const GUID CLSID_BackgroundCopyManager10_1 = GUIDOF!BackgroundCopyManager10_1;
const GUID CLSID_BackgroundCopyManager10_2 = GUIDOF!BackgroundCopyManager10_2;
const GUID CLSID_BackgroundCopyManager10_3 = GUIDOF!BackgroundCopyManager10_3;
const GUID CLSID_BackgroundCopyManager1_5  = GUIDOF!BackgroundCopyManager1_5;
const GUID CLSID_BackgroundCopyManager2_0  = GUIDOF!BackgroundCopyManager2_0;
const GUID CLSID_BackgroundCopyManager2_5  = GUIDOF!BackgroundCopyManager2_5;
const GUID CLSID_BackgroundCopyManager3_0  = GUIDOF!BackgroundCopyManager3_0;
const GUID CLSID_BackgroundCopyManager4_0  = GUIDOF!BackgroundCopyManager4_0;
const GUID CLSID_BackgroundCopyManager5_0  = GUIDOF!BackgroundCopyManager5_0;
const GUID CLSID_BackgroundCopyQMgr        = GUIDOF!BackgroundCopyQMgr;

const GUID IID_AsyncIBackgroundCopyCallback                       = GUIDOF!AsyncIBackgroundCopyCallback;
const GUID IID_IBITSExtensionSetup                                = GUIDOF!IBITSExtensionSetup;
const GUID IID_IBITSExtensionSetupFactory                         = GUIDOF!IBITSExtensionSetupFactory;
const GUID IID_IBackgroundCopyCallback                            = GUIDOF!IBackgroundCopyCallback;
const GUID IID_IBackgroundCopyCallback1                           = GUIDOF!IBackgroundCopyCallback1;
const GUID IID_IBackgroundCopyCallback2                           = GUIDOF!IBackgroundCopyCallback2;
const GUID IID_IBackgroundCopyCallback3                           = GUIDOF!IBackgroundCopyCallback3;
const GUID IID_IBackgroundCopyError                               = GUIDOF!IBackgroundCopyError;
const GUID IID_IBackgroundCopyFile                                = GUIDOF!IBackgroundCopyFile;
const GUID IID_IBackgroundCopyFile2                               = GUIDOF!IBackgroundCopyFile2;
const GUID IID_IBackgroundCopyFile3                               = GUIDOF!IBackgroundCopyFile3;
const GUID IID_IBackgroundCopyFile4                               = GUIDOF!IBackgroundCopyFile4;
const GUID IID_IBackgroundCopyFile5                               = GUIDOF!IBackgroundCopyFile5;
const GUID IID_IBackgroundCopyFile6                               = GUIDOF!IBackgroundCopyFile6;
const GUID IID_IBackgroundCopyGroup                               = GUIDOF!IBackgroundCopyGroup;
const GUID IID_IBackgroundCopyJob                                 = GUIDOF!IBackgroundCopyJob;
const GUID IID_IBackgroundCopyJob1                                = GUIDOF!IBackgroundCopyJob1;
const GUID IID_IBackgroundCopyJob2                                = GUIDOF!IBackgroundCopyJob2;
const GUID IID_IBackgroundCopyJob3                                = GUIDOF!IBackgroundCopyJob3;
const GUID IID_IBackgroundCopyJob4                                = GUIDOF!IBackgroundCopyJob4;
const GUID IID_IBackgroundCopyJob5                                = GUIDOF!IBackgroundCopyJob5;
const GUID IID_IBackgroundCopyJobHttpOptions                      = GUIDOF!IBackgroundCopyJobHttpOptions;
const GUID IID_IBackgroundCopyJobHttpOptions2                     = GUIDOF!IBackgroundCopyJobHttpOptions2;
const GUID IID_IBackgroundCopyJobHttpOptions3                     = GUIDOF!IBackgroundCopyJobHttpOptions3;
const GUID IID_IBackgroundCopyManager                             = GUIDOF!IBackgroundCopyManager;
const GUID IID_IBackgroundCopyQMgr                                = GUIDOF!IBackgroundCopyQMgr;
const GUID IID_IBackgroundCopyServerCertificateValidationCallback = GUIDOF!IBackgroundCopyServerCertificateValidationCallback;
const GUID IID_IBitsPeer                                          = GUIDOF!IBitsPeer;
const GUID IID_IBitsPeerCacheAdministration                       = GUIDOF!IBitsPeerCacheAdministration;
const GUID IID_IBitsPeerCacheRecord                               = GUIDOF!IBitsPeerCacheRecord;
const GUID IID_IBitsTokenOptions                                  = GUIDOF!IBitsTokenOptions;
const GUID IID_IEnumBackgroundCopyFiles                           = GUIDOF!IEnumBackgroundCopyFiles;
const GUID IID_IEnumBackgroundCopyGroups                          = GUIDOF!IEnumBackgroundCopyGroups;
const GUID IID_IEnumBackgroundCopyJobs                            = GUIDOF!IEnumBackgroundCopyJobs;
const GUID IID_IEnumBackgroundCopyJobs1                           = GUIDOF!IEnumBackgroundCopyJobs1;
const GUID IID_IEnumBitsPeerCacheRecords                          = GUIDOF!IEnumBitsPeerCacheRecords;
const GUID IID_IEnumBitsPeers                                     = GUIDOF!IEnumBitsPeers;
