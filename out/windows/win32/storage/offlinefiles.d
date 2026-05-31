// Written in the D programming language.

module windows.win32.storage.offlinefiles;

public import windows.core;
public import system.system : Guid;
public import windows.win32.foundation.foundation : BOOL, FILETIME, HRESULT, HWND, PWSTR;
public import windows.win32.system.com.com : BYTE_BLOB, IUnknown;
public import windows.win32.system.variant : VARIANT;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/ne-cscobj-offlinefiles_item_type
alias OFFLINEFILES_ITEM_TYPE = int;
enum : int
{
    OFFLINEFILES_ITEM_TYPE_FILE      = 0x00000000,
    OFFLINEFILES_ITEM_TYPE_DIRECTORY = 0x00000001,
    OFFLINEFILES_ITEM_TYPE_SHARE     = 0x00000002,
    OFFLINEFILES_ITEM_TYPE_SERVER    = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/ne-cscobj-offlinefiles_item_copy
alias OFFLINEFILES_ITEM_COPY = int;
enum : int
{
    OFFLINEFILES_ITEM_COPY_LOCAL    = 0x00000000,
    OFFLINEFILES_ITEM_COPY_REMOTE   = 0x00000001,
    OFFLINEFILES_ITEM_COPY_ORIGINAL = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/ne-cscobj-offlinefiles_connect_state
alias OFFLINEFILES_CONNECT_STATE = int;
enum : int
{
    OFFLINEFILES_CONNECT_STATE_UNKNOWN                     = 0x00000000,
    OFFLINEFILES_CONNECT_STATE_OFFLINE                     = 0x00000001,
    OFFLINEFILES_CONNECT_STATE_ONLINE                      = 0x00000002,
    OFFLINEFILES_CONNECT_STATE_TRANSPARENTLY_CACHED        = 0x00000003,
    OFFLINEFILES_CONNECT_STATE_PARTLY_TRANSPARENTLY_CACHED = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/ne-cscobj-offlinefiles_offline_reason
alias OFFLINEFILES_OFFLINE_REASON = int;
enum : int
{
    OFFLINEFILES_OFFLINE_REASON_UNKNOWN               = 0x00000000,
    OFFLINEFILES_OFFLINE_REASON_NOT_APPLICABLE        = 0x00000001,
    OFFLINEFILES_OFFLINE_REASON_CONNECTION_FORCED     = 0x00000002,
    OFFLINEFILES_OFFLINE_REASON_CONNECTION_SLOW       = 0x00000003,
    OFFLINEFILES_OFFLINE_REASON_CONNECTION_ERROR      = 0x00000004,
    OFFLINEFILES_OFFLINE_REASON_ITEM_VERSION_CONFLICT = 0x00000005,
    OFFLINEFILES_OFFLINE_REASON_ITEM_SUSPENDED        = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/ne-cscobj-offlinefiles_caching_mode
alias OFFLINEFILES_CACHING_MODE = int;
enum : int
{
    OFFLINEFILES_CACHING_MODE_NONE            = 0x00000000,
    OFFLINEFILES_CACHING_MODE_NOCACHING       = 0x00000001,
    OFFLINEFILES_CACHING_MODE_MANUAL          = 0x00000002,
    OFFLINEFILES_CACHING_MODE_AUTO_DOC        = 0x00000003,
    OFFLINEFILES_CACHING_MODE_AUTO_PROGANDDOC = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/ne-cscobj-offlinefiles_op_response
alias OFFLINEFILES_OP_RESPONSE = int;
enum : int
{
    OFFLINEFILES_OP_CONTINUE = 0x00000000,
    OFFLINEFILES_OP_RETRY    = 0x00000001,
    OFFLINEFILES_OP_ABORT    = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/ne-cscobj-offlinefiles_events
alias OFFLINEFILES_EVENTS = int;
enum : int
{
    OFFLINEFILES_EVENT_CACHEMOVED                 = 0x00000000,
    OFFLINEFILES_EVENT_CACHEISFULL                = 0x00000001,
    OFFLINEFILES_EVENT_CACHEISCORRUPTED           = 0x00000002,
    OFFLINEFILES_EVENT_ENABLED                    = 0x00000003,
    OFFLINEFILES_EVENT_ENCRYPTIONCHANGED          = 0x00000004,
    OFFLINEFILES_EVENT_SYNCBEGIN                  = 0x00000005,
    OFFLINEFILES_EVENT_SYNCFILERESULT             = 0x00000006,
    OFFLINEFILES_EVENT_SYNCCONFLICTRECADDED       = 0x00000007,
    OFFLINEFILES_EVENT_SYNCCONFLICTRECUPDATED     = 0x00000008,
    OFFLINEFILES_EVENT_SYNCCONFLICTRECREMOVED     = 0x00000009,
    OFFLINEFILES_EVENT_SYNCEND                    = 0x0000000a,
    OFFLINEFILES_EVENT_BACKGROUNDSYNCBEGIN        = 0x0000000b,
    OFFLINEFILES_EVENT_BACKGROUNDSYNCEND          = 0x0000000c,
    OFFLINEFILES_EVENT_NETTRANSPORTARRIVED        = 0x0000000d,
    OFFLINEFILES_EVENT_NONETTRANSPORTS            = 0x0000000e,
    OFFLINEFILES_EVENT_ITEMDISCONNECTED           = 0x0000000f,
    OFFLINEFILES_EVENT_ITEMRECONNECTED            = 0x00000010,
    OFFLINEFILES_EVENT_ITEMAVAILABLEOFFLINE       = 0x00000011,
    OFFLINEFILES_EVENT_ITEMNOTAVAILABLEOFFLINE    = 0x00000012,
    OFFLINEFILES_EVENT_ITEMPINNED                 = 0x00000013,
    OFFLINEFILES_EVENT_ITEMNOTPINNED              = 0x00000014,
    OFFLINEFILES_EVENT_ITEMMODIFIED               = 0x00000015,
    OFFLINEFILES_EVENT_ITEMADDEDTOCACHE           = 0x00000016,
    OFFLINEFILES_EVENT_ITEMDELETEDFROMCACHE       = 0x00000017,
    OFFLINEFILES_EVENT_ITEMRENAMED                = 0x00000018,
    OFFLINEFILES_EVENT_DATALOST                   = 0x00000019,
    OFFLINEFILES_EVENT_PING                       = 0x0000001a,
    OFFLINEFILES_EVENT_ITEMRECONNECTBEGIN         = 0x0000001b,
    OFFLINEFILES_EVENT_ITEMRECONNECTEND           = 0x0000001c,
    OFFLINEFILES_EVENT_CACHEEVICTBEGIN            = 0x0000001d,
    OFFLINEFILES_EVENT_CACHEEVICTEND              = 0x0000001e,
    OFFLINEFILES_EVENT_POLICYCHANGEDETECTED       = 0x0000001f,
    OFFLINEFILES_EVENT_PREFERENCECHANGEDETECTED   = 0x00000020,
    OFFLINEFILES_EVENT_SETTINGSCHANGESAPPLIED     = 0x00000021,
    OFFLINEFILES_EVENT_TRANSPARENTCACHEITEMNOTIFY = 0x00000022,
    OFFLINEFILES_EVENT_PREFETCHFILEBEGIN          = 0x00000023,
    OFFLINEFILES_EVENT_PREFETCHFILEEND            = 0x00000024,
    OFFLINEFILES_EVENT_PREFETCHCLOSEHANDLEBEGIN   = 0x00000025,
    OFFLINEFILES_EVENT_PREFETCHCLOSEHANDLEEND     = 0x00000026,
    OFFLINEFILES_NUM_EVENTS                       = 0x00000027,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/ne-cscobj-offlinefiles_pathfilter_match
alias OFFLINEFILES_PATHFILTER_MATCH = int;
enum : int
{
    OFFLINEFILES_PATHFILTER_SELF             = 0x00000000,
    OFFLINEFILES_PATHFILTER_CHILD            = 0x00000001,
    OFFLINEFILES_PATHFILTER_DESCENDENT       = 0x00000002,
    OFFLINEFILES_PATHFILTER_SELFORCHILD      = 0x00000003,
    OFFLINEFILES_PATHFILTER_SELFORDESCENDENT = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/ne-cscobj-offlinefiles_sync_conflict_resolve
alias OFFLINEFILES_SYNC_CONFLICT_RESOLVE = int;
enum : int
{
    OFFLINEFILES_SYNC_CONFLICT_RESOLVE_NONE           = 0x00000000,
    OFFLINEFILES_SYNC_CONFLICT_RESOLVE_KEEPLOCAL      = 0x00000001,
    OFFLINEFILES_SYNC_CONFLICT_RESOLVE_KEEPREMOTE     = 0x00000002,
    OFFLINEFILES_SYNC_CONFLICT_RESOLVE_KEEPALLCHANGES = 0x00000003,
    OFFLINEFILES_SYNC_CONFLICT_RESOLVE_KEEPLATEST     = 0x00000004,
    OFFLINEFILES_SYNC_CONFLICT_RESOLVE_LOG            = 0x00000005,
    OFFLINEFILES_SYNC_CONFLICT_RESOLVE_SKIP           = 0x00000006,
    OFFLINEFILES_SYNC_CONFLICT_ABORT                  = 0x00000007,
    OFFLINEFILES_SYNC_CONFLICT_RESOLVE_NUMCODES       = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/ne-cscobj-offlinefiles_item_time
alias OFFLINEFILES_ITEM_TIME = int;
enum : int
{
    OFFLINEFILES_ITEM_TIME_CREATION   = 0x00000000,
    OFFLINEFILES_ITEM_TIME_LASTACCESS = 0x00000001,
    OFFLINEFILES_ITEM_TIME_LASTWRITE  = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/ne-cscobj-offlinefiles_compare
alias OFFLINEFILES_COMPARE = int;
enum : int
{
    OFFLINEFILES_COMPARE_EQ  = 0x00000000,
    OFFLINEFILES_COMPARE_NEQ = 0x00000001,
    OFFLINEFILES_COMPARE_LT  = 0x00000002,
    OFFLINEFILES_COMPARE_GT  = 0x00000003,
    OFFLINEFILES_COMPARE_LTE = 0x00000004,
    OFFLINEFILES_COMPARE_GTE = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/ne-cscobj-offlinefiles_setting_value_type
alias OFFLINEFILES_SETTING_VALUE_TYPE = int;
enum : int
{
    OFFLINEFILES_SETTING_VALUE_UI4                  = 0x00000000,
    OFFLINEFILES_SETTING_VALUE_BSTR                 = 0x00000001,
    OFFLINEFILES_SETTING_VALUE_BSTR_DBLNULTERM      = 0x00000002,
    OFFLINEFILES_SETTING_VALUE_2DIM_ARRAY_BSTR_UI4  = 0x00000003,
    OFFLINEFILES_SETTING_VALUE_2DIM_ARRAY_BSTR_BSTR = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/ne-cscobj-offlinefiles_sync_operation
alias OFFLINEFILES_SYNC_OPERATION = int;
enum : int
{
    OFFLINEFILES_SYNC_OPERATION_CREATE_COPY_ON_SERVER = 0x00000000,
    OFFLINEFILES_SYNC_OPERATION_CREATE_COPY_ON_CLIENT = 0x00000001,
    OFFLINEFILES_SYNC_OPERATION_SYNC_TO_SERVER        = 0x00000002,
    OFFLINEFILES_SYNC_OPERATION_SYNC_TO_CLIENT        = 0x00000003,
    OFFLINEFILES_SYNC_OPERATION_DELETE_SERVER_COPY    = 0x00000004,
    OFFLINEFILES_SYNC_OPERATION_DELETE_CLIENT_COPY    = 0x00000005,
    OFFLINEFILES_SYNC_OPERATION_PIN                   = 0x00000006,
    OFFLINEFILES_SYNC_OPERATION_PREPARE               = 0x00000007,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/ne-cscobj-offlinefiles_sync_state
alias OFFLINEFILES_SYNC_STATE = int;
enum : int
{
    OFFLINEFILES_SYNC_STATE_Stable                                             = 0x00000000,
    OFFLINEFILES_SYNC_STATE_FileOnClient_DirOnServer                           = 0x00000001,
    OFFLINEFILES_SYNC_STATE_FileOnClient_NoServerCopy                          = 0x00000002,
    OFFLINEFILES_SYNC_STATE_DirOnClient_FileOnServer                           = 0x00000003,
    OFFLINEFILES_SYNC_STATE_DirOnClient_FileChangedOnServer                    = 0x00000004,
    OFFLINEFILES_SYNC_STATE_DirOnClient_NoServerCopy                           = 0x00000005,
    OFFLINEFILES_SYNC_STATE_FileCreatedOnClient_NoServerCopy                   = 0x00000006,
    OFFLINEFILES_SYNC_STATE_FileCreatedOnClient_FileChangedOnServer            = 0x00000007,
    OFFLINEFILES_SYNC_STATE_FileCreatedOnClient_DirChangedOnServer             = 0x00000008,
    OFFLINEFILES_SYNC_STATE_FileCreatedOnClient_FileOnServer                   = 0x00000009,
    OFFLINEFILES_SYNC_STATE_FileCreatedOnClient_DirOnServer                    = 0x0000000a,
    OFFLINEFILES_SYNC_STATE_FileCreatedOnClient_DeletedOnServer                = 0x0000000b,
    OFFLINEFILES_SYNC_STATE_FileChangedOnClient_ChangedOnServer                = 0x0000000c,
    OFFLINEFILES_SYNC_STATE_FileChangedOnClient_DirOnServer                    = 0x0000000d,
    OFFLINEFILES_SYNC_STATE_FileChangedOnClient_DirChangedOnServer             = 0x0000000e,
    OFFLINEFILES_SYNC_STATE_FileChangedOnClient_DeletedOnServer                = 0x0000000f,
    OFFLINEFILES_SYNC_STATE_FileSparseOnClient_ChangedOnServer                 = 0x00000010,
    OFFLINEFILES_SYNC_STATE_FileSparseOnClient_DeletedOnServer                 = 0x00000011,
    OFFLINEFILES_SYNC_STATE_FileSparseOnClient_DirOnServer                     = 0x00000012,
    OFFLINEFILES_SYNC_STATE_FileSparseOnClient_DirChangedOnServer              = 0x00000013,
    OFFLINEFILES_SYNC_STATE_DirCreatedOnClient_NoServerCopy                    = 0x00000014,
    OFFLINEFILES_SYNC_STATE_DirCreatedOnClient_DirOnServer                     = 0x00000015,
    OFFLINEFILES_SYNC_STATE_DirCreatedOnClient_FileOnServer                    = 0x00000016,
    OFFLINEFILES_SYNC_STATE_DirCreatedOnClient_FileChangedOnServer             = 0x00000017,
    OFFLINEFILES_SYNC_STATE_DirCreatedOnClient_DirChangedOnServer              = 0x00000018,
    OFFLINEFILES_SYNC_STATE_DirCreatedOnClient_DeletedOnServer                 = 0x00000019,
    OFFLINEFILES_SYNC_STATE_DirChangedOnClient_FileOnServer                    = 0x0000001a,
    OFFLINEFILES_SYNC_STATE_DirChangedOnClient_FileChangedOnServer             = 0x0000001b,
    OFFLINEFILES_SYNC_STATE_DirChangedOnClient_ChangedOnServer                 = 0x0000001c,
    OFFLINEFILES_SYNC_STATE_DirChangedOnClient_DeletedOnServer                 = 0x0000001d,
    OFFLINEFILES_SYNC_STATE_NoClientCopy_FileOnServer                          = 0x0000001e,
    OFFLINEFILES_SYNC_STATE_NoClientCopy_DirOnServer                           = 0x0000001f,
    OFFLINEFILES_SYNC_STATE_NoClientCopy_FileChangedOnServer                   = 0x00000020,
    OFFLINEFILES_SYNC_STATE_NoClientCopy_DirChangedOnServer                    = 0x00000021,
    OFFLINEFILES_SYNC_STATE_DeletedOnClient_FileOnServer                       = 0x00000022,
    OFFLINEFILES_SYNC_STATE_DeletedOnClient_DirOnServer                        = 0x00000023,
    OFFLINEFILES_SYNC_STATE_DeletedOnClient_FileChangedOnServer                = 0x00000024,
    OFFLINEFILES_SYNC_STATE_DeletedOnClient_DirChangedOnServer                 = 0x00000025,
    OFFLINEFILES_SYNC_STATE_FileSparseOnClient                                 = 0x00000026,
    OFFLINEFILES_SYNC_STATE_FileChangedOnClient                                = 0x00000027,
    OFFLINEFILES_SYNC_STATE_FileRenamedOnClient                                = 0x00000028,
    OFFLINEFILES_SYNC_STATE_DirSparseOnClient                                  = 0x00000029,
    OFFLINEFILES_SYNC_STATE_DirChangedOnClient                                 = 0x0000002a,
    OFFLINEFILES_SYNC_STATE_DirRenamedOnClient                                 = 0x0000002b,
    OFFLINEFILES_SYNC_STATE_FileChangedOnServer                                = 0x0000002c,
    OFFLINEFILES_SYNC_STATE_FileRenamedOnServer                                = 0x0000002d,
    OFFLINEFILES_SYNC_STATE_FileDeletedOnServer                                = 0x0000002e,
    OFFLINEFILES_SYNC_STATE_DirChangedOnServer                                 = 0x0000002f,
    OFFLINEFILES_SYNC_STATE_DirRenamedOnServer                                 = 0x00000030,
    OFFLINEFILES_SYNC_STATE_DirDeletedOnServer                                 = 0x00000031,
    OFFLINEFILES_SYNC_STATE_FileReplacedAndDeletedOnClient_FileOnServer        = 0x00000032,
    OFFLINEFILES_SYNC_STATE_FileReplacedAndDeletedOnClient_FileChangedOnServer = 0x00000033,
    OFFLINEFILES_SYNC_STATE_FileReplacedAndDeletedOnClient_DirOnServer         = 0x00000034,
    OFFLINEFILES_SYNC_STATE_FileReplacedAndDeletedOnClient_DirChangedOnServer  = 0x00000035,
    OFFLINEFILES_SYNC_STATE_NUMSTATES                                          = 0x00000036,
}

// Constants


enum : uint
{
    OFFLINEFILES_SYNC_STATE_LOCAL_KNOWN  = 0x00000001U,
    OFFLINEFILES_SYNC_STATE_REMOTE_KNOWN = 0x00000002U,
}

enum : uint
{
    OFFLINEFILES_CHANGES_NONE                         = 0x00000000U,
    OFFLINEFILES_CHANGES_LOCAL_SIZE                   = 0x00000001U,
    OFFLINEFILES_CHANGES_LOCAL_ATTRIBUTES             = 0x00000002U,
    OFFLINEFILES_CHANGES_LOCAL_TIME                   = 0x00000004U,
    OFFLINEFILES_CHANGES_REMOTE_SIZE                  = 0x00000008U,
    OFFLINEFILES_CHANGES_REMOTE_ATTRIBUTES            = 0x00000010U,
    OFFLINEFILES_CHANGES_REMOTE_TIME                  = 0x00000020U,
    OFFLINEFILES_ITEM_FILTER_FLAG_MODIFIED_DATA       = 0x00000001U,
    OFFLINEFILES_ITEM_FILTER_FLAG_MODIFIED_ATTRIBUTES = 0x00000002U,
    OFFLINEFILES_ITEM_FILTER_FLAG_MODIFIED            = 0x00000004U,
    OFFLINEFILES_ITEM_FILTER_FLAG_CREATED             = 0x00000008U,
    OFFLINEFILES_ITEM_FILTER_FLAG_DELETED             = 0x00000010U,
    OFFLINEFILES_ITEM_FILTER_FLAG_DIRTY               = 0x00000020U,
    OFFLINEFILES_ITEM_FILTER_FLAG_SPARSE              = 0x00000040U,
    OFFLINEFILES_ITEM_FILTER_FLAG_FILE                = 0x00000080U,
    OFFLINEFILES_ITEM_FILTER_FLAG_DIRECTORY           = 0x00000100U,
    OFFLINEFILES_ITEM_FILTER_FLAG_PINNED_USER         = 0x00000200U,
    OFFLINEFILES_ITEM_FILTER_FLAG_PINNED_OTHERS       = 0x00000400U,
    OFFLINEFILES_ITEM_FILTER_FLAG_PINNED_COMPUTER     = 0x00000800U,
    OFFLINEFILES_ITEM_FILTER_FLAG_PINNED              = 0x00001000U,
    OFFLINEFILES_ITEM_FILTER_FLAG_GHOST               = 0x00002000U,
    OFFLINEFILES_ITEM_FILTER_FLAG_SUSPENDED           = 0x00004000U,
    OFFLINEFILES_ITEM_FILTER_FLAG_OFFLINE             = 0x00008000U,
    OFFLINEFILES_ITEM_FILTER_FLAG_ONLINE              = 0x00010000U,
    OFFLINEFILES_ITEM_FILTER_FLAG_USER_WRITE          = 0x00020000U,
    OFFLINEFILES_ITEM_FILTER_FLAG_USER_READ           = 0x00040000U,
    OFFLINEFILES_ITEM_FILTER_FLAG_USER_ANYACCESS      = 0x00080000U,
    OFFLINEFILES_ITEM_FILTER_FLAG_OTHER_WRITE         = 0x00100000U,
    OFFLINEFILES_ITEM_FILTER_FLAG_OTHER_READ          = 0x00200000U,
    OFFLINEFILES_ITEM_FILTER_FLAG_OTHER_ANYACCESS     = 0x00400000U,
    OFFLINEFILES_ITEM_FILTER_FLAG_GUEST_WRITE         = 0x00800000U,
    OFFLINEFILES_ITEM_FILTER_FLAG_GUEST_READ          = 0x01000000U,
    OFFLINEFILES_ITEM_FILTER_FLAG_GUEST_ANYACCESS     = 0x02000000U,
}

enum : uint
{
    OFFLINEFILES_ITEM_QUERY_REMOTEINFO               = 0x00000001U,
    OFFLINEFILES_ITEM_QUERY_CONNECTIONSTATE          = 0x00000002U,
    OFFLINEFILES_ITEM_QUERY_LOCALDIRTYBYTECOUNT      = 0x00000004U,
    OFFLINEFILES_ITEM_QUERY_REMOTEDIRTYBYTECOUNT     = 0x00000008U,
    OFFLINEFILES_ITEM_QUERY_INCLUDETRANSPARENTCACHE  = 0x00000010U,
    OFFLINEFILES_ITEM_QUERY_ATTEMPT_TRANSITIONONLINE = 0x00000020U,
    OFFLINEFILES_ITEM_QUERY_ADMIN                    = 0x80000000U,
    OFFLINEFILES_ENUM_FLAT                           = 0x00000001U,
    OFFLINEFILES_ENUM_FLAT_FILESONLY                 = 0x00000002U,
    OFFLINEFILES_SETTING_SCOPE_USER                  = 0x00000001U,
    OFFLINEFILES_SETTING_SCOPE_COMPUTER              = 0x00000002U,
}

enum const(wchar)* OFFLINEFILES_SETTING_PinLinkTargets = "LinkTargetCaching";

enum : uint
{
    OFFLINEFILES_PINLINKTARGETS_NEVER    = 0x00000000U,
    OFFLINEFILES_PINLINKTARGETS_EXPLICIT = 0x00000001U,
    OFFLINEFILES_PINLINKTARGETS_ALWAYS   = 0x00000002U,
}

enum : uint
{
    OFFLINEFILES_SYNC_CONTROL_FLAG_FILLSPARSE        = 0x00000001U,
    OFFLINEFILES_SYNC_CONTROL_FLAG_SYNCIN            = 0x00000002U,
    OFFLINEFILES_SYNC_CONTROL_FLAG_SYNCOUT           = 0x00000004U,
    OFFLINEFILES_SYNC_CONTROL_FLAG_PINNEWFILES       = 0x00000008U,
    OFFLINEFILES_SYNC_CONTROL_FLAG_PINLINKTARGETS    = 0x00000010U,
    OFFLINEFILES_SYNC_CONTROL_FLAG_PINFORUSER        = 0x00000020U,
    OFFLINEFILES_SYNC_CONTROL_FLAG_PINFORUSER_POLICY = 0x00000040U,
    OFFLINEFILES_SYNC_CONTROL_FLAG_PINFORALL         = 0x00000080U,
    OFFLINEFILES_SYNC_CONTROL_FLAG_PINFORREDIR       = 0x00000100U,
    OFFLINEFILES_SYNC_CONTROL_FLAG_LOWPRIORITY       = 0x00000200U,
    OFFLINEFILES_SYNC_CONTROL_FLAG_ASYNCPROGRESS     = 0x00000400U,
    OFFLINEFILES_SYNC_CONTROL_FLAG_INTERACTIVE       = 0x00000800U,
    OFFLINEFILES_SYNC_CONTROL_FLAG_CONSOLE           = 0x00001000U,
    OFFLINEFILES_SYNC_CONTROL_FLAG_SKIPSUSPENDEDDIRS = 0x00002000U,
    OFFLINEFILES_SYNC_CONTROL_FLAG_BACKGROUND        = 0x00010000U,
    OFFLINEFILES_SYNC_CONTROL_FLAG_NONEWFILESOUT     = 0x00020000U,
    OFFLINEFILES_SYNC_CONTROL_CR_MASK                = 0xf0000000U,
    OFFLINEFILES_SYNC_CONTROL_CR_DEFAULT             = 0x00000000U,
    OFFLINEFILES_SYNC_CONTROL_CR_KEEPLOCAL           = 0x10000000U,
    OFFLINEFILES_SYNC_CONTROL_CR_KEEPREMOTE          = 0x20000000U,
    OFFLINEFILES_SYNC_CONTROL_CR_KEEPLATEST          = 0x30000000U,
}

enum : uint
{
    OFFLINEFILES_PIN_CONTROL_FLAG_FORUSER        = 0x00000020U,
    OFFLINEFILES_PIN_CONTROL_FLAG_FORUSER_POLICY = 0x00000040U,
    OFFLINEFILES_PIN_CONTROL_FLAG_FORALL         = 0x00000080U,
    OFFLINEFILES_PIN_CONTROL_FLAG_FORREDIR       = 0x00000100U,
    OFFLINEFILES_PIN_CONTROL_FLAG_FILL           = 0x00000001U,
    OFFLINEFILES_PIN_CONTROL_FLAG_LOWPRIORITY    = 0x00000200U,
    OFFLINEFILES_PIN_CONTROL_FLAG_ASYNCPROGRESS  = 0x00000400U,
    OFFLINEFILES_PIN_CONTROL_FLAG_INTERACTIVE    = 0x00000800U,
    OFFLINEFILES_PIN_CONTROL_FLAG_CONSOLE        = 0x00001000U,
    OFFLINEFILES_PIN_CONTROL_FLAG_PINLINKTARGETS = 0x00000010U,
    OFFLINEFILES_PIN_CONTROL_FLAG_BACKGROUND     = 0x00010000U,
}

enum : uint
{
    OFFLINEFILES_ENCRYPTION_CONTROL_FLAG_LOWPRIORITY   = 0x00000200U,
    OFFLINEFILES_ENCRYPTION_CONTROL_FLAG_ASYNCPROGRESS = 0x00000400U,
    OFFLINEFILES_ENCRYPTION_CONTROL_FLAG_INTERACTIVE   = 0x00000800U,
    OFFLINEFILES_ENCRYPTION_CONTROL_FLAG_CONSOLE       = 0x00001000U,
    OFFLINEFILES_ENCRYPTION_CONTROL_FLAG_BACKGROUND    = 0x00010000U,
}

enum : uint
{
    OFFLINEFILES_DELETE_FLAG_NOAUTOCACHED    = 0x00000001U,
    OFFLINEFILES_DELETE_FLAG_NOPINNED        = 0x00000002U,
    OFFLINEFILES_DELETE_FLAG_DELMODIFIED     = 0x00000004U,
    OFFLINEFILES_DELETE_FLAG_ADMIN           = 0x80000000U,
    OFFLINEFILES_TRANSITION_FLAG_INTERACTIVE = 0x00000001U,
    OFFLINEFILES_TRANSITION_FLAG_CONSOLE     = 0x00000002U,
}

enum : uint
{
    OFFLINEFILES_SYNC_ITEM_CHANGE_NONE       = 0x00000000U,
    OFFLINEFILES_SYNC_ITEM_CHANGE_CHANGETIME = 0x00000001U,
    OFFLINEFILES_SYNC_ITEM_CHANGE_WRITETIME  = 0x00000002U,
    OFFLINEFILES_SYNC_ITEM_CHANGE_FILESIZE   = 0x00000004U,
    OFFLINEFILES_SYNC_ITEM_CHANGE_ATTRIBUTES = 0x00000008U,
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("CSCAPI.dll")
uint OfflineFilesEnable(BOOL bEnable, BOOL* pbRebootRequired);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("CSCAPI.dll")
uint OfflineFilesStart();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("CSCAPI.dll")
uint OfflineFilesQueryStatus(BOOL* pbActive, BOOL* pbEnabled);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("CSCAPI.dll")
uint OfflineFilesQueryStatusEx(BOOL* pbActive, BOOL* pbEnabled, BOOL* pbAvailable);


// Interfaces

@GUID("fd3659e9-a920-4123-ad64-7fc76c7aacdf")
struct OfflineFilesSetting;

@GUID("48c6be7c-3871-43cc-b46f-1449a1bb2ff3")
struct OfflineFilesCache;

@GUID("e25585c1-0caa-4eb1-873b-1cae5b77c314")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nn-cscobj-iofflinefilesevents
interface IOfflineFilesEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesevents-cachemoved
    HRESULT CacheMoved(const(PWSTR) pszOldPath, const(PWSTR) pszNewPath);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesevents-cacheisfull
    HRESULT CacheIsFull();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesevents-cacheiscorrupted
    HRESULT CacheIsCorrupted();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesevents-enabled
    HRESULT Enabled(BOOL bEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesevents-encryptionchanged
    HRESULT EncryptionChanged(BOOL bWasEncrypted, BOOL bWasPartial, BOOL bIsEncrypted, BOOL bIsPartial);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesevents-syncbegin
    HRESULT SyncBegin(const(GUID)* rSyncId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesevents-syncfileresult
    HRESULT SyncFileResult(const(GUID)* rSyncId, const(PWSTR) pszFile, HRESULT hrResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesevents-syncconflictrecadded
    HRESULT SyncConflictRecAdded(const(PWSTR) pszConflictPath, const(FILETIME)* pftConflictDateTime, 
                                 OFFLINEFILES_SYNC_STATE ConflictSyncState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesevents-syncconflictrecupdated
    HRESULT SyncConflictRecUpdated(const(PWSTR) pszConflictPath, const(FILETIME)* pftConflictDateTime, 
                                   OFFLINEFILES_SYNC_STATE ConflictSyncState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesevents-syncconflictrecremoved
    HRESULT SyncConflictRecRemoved(const(PWSTR) pszConflictPath, const(FILETIME)* pftConflictDateTime, 
                                   OFFLINEFILES_SYNC_STATE ConflictSyncState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesevents-syncend
    HRESULT SyncEnd(const(GUID)* rSyncId, HRESULT hrResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesevents-nettransportarrived
    HRESULT NetTransportArrived();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesevents-nonettransports
    HRESULT NoNetTransports();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesevents-itemdisconnected
    HRESULT ItemDisconnected(const(PWSTR) pszPath, OFFLINEFILES_ITEM_TYPE ItemType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesevents-itemreconnected
    HRESULT ItemReconnected(const(PWSTR) pszPath, OFFLINEFILES_ITEM_TYPE ItemType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesevents-itemavailableoffline
    HRESULT ItemAvailableOffline(const(PWSTR) pszPath, OFFLINEFILES_ITEM_TYPE ItemType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesevents-itemnotavailableoffline
    HRESULT ItemNotAvailableOffline(const(PWSTR) pszPath, OFFLINEFILES_ITEM_TYPE ItemType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesevents-itempinned
    HRESULT ItemPinned(const(PWSTR) pszPath, OFFLINEFILES_ITEM_TYPE ItemType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesevents-itemnotpinned
    HRESULT ItemNotPinned(const(PWSTR) pszPath, OFFLINEFILES_ITEM_TYPE ItemType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesevents-itemmodified
    HRESULT ItemModified(const(PWSTR) pszPath, OFFLINEFILES_ITEM_TYPE ItemType, BOOL bModifiedData, 
                         BOOL bModifiedAttributes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesevents-itemaddedtocache
    HRESULT ItemAddedToCache(const(PWSTR) pszPath, OFFLINEFILES_ITEM_TYPE ItemType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesevents-itemdeletedfromcache
    HRESULT ItemDeletedFromCache(const(PWSTR) pszPath, OFFLINEFILES_ITEM_TYPE ItemType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesevents-itemrenamed
    HRESULT ItemRenamed(const(PWSTR) pszOldPath, const(PWSTR) pszNewPath, OFFLINEFILES_ITEM_TYPE ItemType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesevents-datalost
    HRESULT DataLost();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesevents-ping
    HRESULT Ping();
}

@GUID("1ead8f56-ff76-4faa-a795-6f6ef792498b")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nn-cscobj-iofflinefilesevents2
interface IOfflineFilesEvents2 : IOfflineFilesEvents
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesevents2-itemreconnectbegin
    HRESULT ItemReconnectBegin();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesevents2-itemreconnectend
    HRESULT ItemReconnectEnd();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesevents2-cacheevictbegin
    HRESULT CacheEvictBegin();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesevents2-cacheevictend
    HRESULT CacheEvictEnd();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesevents2-backgroundsyncbegin
    HRESULT BackgroundSyncBegin(uint dwSyncControlFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesevents2-backgroundsyncend
    HRESULT BackgroundSyncEnd(uint dwSyncControlFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesevents2-policychangedetected
    HRESULT PolicyChangeDetected();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesevents2-preferencechangedetected
    HRESULT PreferenceChangeDetected();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesevents2-settingschangesapplied
    HRESULT SettingsChangesApplied();
}

@GUID("9ba04a45-ee69-42f0-9ab1-7db5c8805808")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nn-cscobj-iofflinefilesevents3
interface IOfflineFilesEvents3 : IOfflineFilesEvents2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesevents3-transparentcacheitemnotify
    HRESULT TransparentCacheItemNotify(const(PWSTR) pszPath, OFFLINEFILES_EVENTS EventType, 
                                       OFFLINEFILES_ITEM_TYPE ItemType, BOOL bModifiedData, BOOL bModifiedAttributes, 
                                       const(PWSTR) pzsOldPath);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesevents3-prefetchfilebegin
    HRESULT PrefetchFileBegin(const(PWSTR) pszPath);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesevents3-prefetchfileend
    HRESULT PrefetchFileEnd(const(PWSTR) pszPath, HRESULT hrResult);
}

@GUID("dbd69b1e-c7d2-473e-b35f-9d8c24c0c484")
interface IOfflineFilesEvents4 : IOfflineFilesEvents3
{
    HRESULT PrefetchCloseHandleBegin();
    HRESULT PrefetchCloseHandleEnd(uint dwClosedHandleCount, uint dwOpenHandleCount, HRESULT hrResult);
}

@GUID("33fc4e1b-0716-40fa-ba65-6e62a84a846f")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nn-cscobj-iofflinefileseventsfilter
interface IOfflineFilesEventsFilter : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefileseventsfilter-getpathfilter
    HRESULT GetPathFilter(PWSTR* ppszFilter, OFFLINEFILES_PATHFILTER_MATCH* pMatch);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefileseventsfilter-getincludedevents
    HRESULT GetIncludedEvents(uint cElements, OFFLINEFILES_EVENTS* prgEvents, uint* pcEvents);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefileseventsfilter-getexcludedevents
    HRESULT GetExcludedEvents(uint cElements, OFFLINEFILES_EVENTS* prgEvents, uint* pcEvents);
}

@GUID("7112fa5f-7571-435a-8eb7-195c7c1429bc")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nn-cscobj-iofflinefileserrorinfo
interface IOfflineFilesErrorInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefileserrorinfo-getrawdata
    HRESULT GetRawData(BYTE_BLOB** ppBlob);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefileserrorinfo-getdescription
    HRESULT GetDescription(PWSTR* ppszDescription);
}

@GUID("ecdbaf0d-6a18-4d55-8017-108f7660ba44")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nn-cscobj-iofflinefilessyncerroriteminfo
interface IOfflineFilesSyncErrorItemInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilessyncerroriteminfo-getfileattributes
    HRESULT GetFileAttributes(uint* pdwAttributes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilessyncerroriteminfo-getfiletimes
    HRESULT GetFileTimes(FILETIME* pftLastWrite, FILETIME* pftChange);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilessyncerroriteminfo-getfilesize
    HRESULT GetFileSize(long* pSize);
}

@GUID("59f95e46-eb54-49d1-be76-de95458d01b0")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nn-cscobj-iofflinefilessyncerrorinfo
interface IOfflineFilesSyncErrorInfo : IOfflineFilesErrorInfo
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilessyncerrorinfo-getsyncoperation
    HRESULT GetSyncOperation(OFFLINEFILES_SYNC_OPERATION* pSyncOp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilessyncerrorinfo-getitemchangeflags
    HRESULT GetItemChangeFlags(uint* pdwItemChangeFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilessyncerrorinfo-infoenumerated
    HRESULT InfoEnumerated(BOOL* pbLocalEnumerated, BOOL* pbRemoteEnumerated, BOOL* pbOriginalEnumerated);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilessyncerrorinfo-infoavailable
    HRESULT InfoAvailable(BOOL* pbLocalInfo, BOOL* pbRemoteInfo, BOOL* pbOriginalInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilessyncerrorinfo-getlocalinfo
    HRESULT GetLocalInfo(IOfflineFilesSyncErrorItemInfo* ppInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilessyncerrorinfo-getremoteinfo
    HRESULT GetRemoteInfo(IOfflineFilesSyncErrorItemInfo* ppInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilessyncerrorinfo-getoriginalinfo
    HRESULT GetOriginalInfo(IOfflineFilesSyncErrorItemInfo* ppInfo);
}

@GUID("fad63237-c55b-4911-9850-bcf96d4c979e")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nn-cscobj-iofflinefilesprogress
interface IOfflineFilesProgress : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesprogress-begin
    HRESULT Begin(BOOL* pbAbort);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesprogress-queryabort
    HRESULT QueryAbort(BOOL* pbAbort);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesprogress-end
    HRESULT End(HRESULT hrResult);
}

@GUID("c34f7f9b-c43d-4f9d-a776-c0eb6de5d401")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nn-cscobj-iofflinefilessimpleprogress
interface IOfflineFilesSimpleProgress : IOfflineFilesProgress
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilessimpleprogress-itembegin
    HRESULT ItemBegin(const(PWSTR) pszFile, OFFLINEFILES_OP_RESPONSE* pResponse);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilessimpleprogress-itemresult
    HRESULT ItemResult(const(PWSTR) pszFile, HRESULT hrResult, OFFLINEFILES_OP_RESPONSE* pResponse);
}

@GUID("6931f49a-6fc7-4c1b-b265-56793fc451b7")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nn-cscobj-iofflinefilessyncprogress
interface IOfflineFilesSyncProgress : IOfflineFilesProgress
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilessyncprogress-syncitembegin
    HRESULT SyncItemBegin(const(PWSTR) pszFile, OFFLINEFILES_OP_RESPONSE* pResponse);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilessyncprogress-syncitemresult
    HRESULT SyncItemResult(const(PWSTR) pszFile, HRESULT hrResult, IOfflineFilesSyncErrorInfo pErrorInfo, 
                           OFFLINEFILES_OP_RESPONSE* pResponse);
}

@GUID("b6dd5092-c65c-46b6-97b8-fadd08e7e1be")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nn-cscobj-iofflinefilessyncconflicthandler
interface IOfflineFilesSyncConflictHandler : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilessyncconflicthandler-resolveconflict
    HRESULT ResolveConflict(const(PWSTR) pszPath, uint fStateKnown, OFFLINEFILES_SYNC_STATE state, 
                            uint fChangeDetails, OFFLINEFILES_SYNC_CONFLICT_RESOLVE* pConflictResolution, 
                            PWSTR* ppszNewName);
}

@GUID("f4b5a26c-dc05-4f20-ada4-551f1077be5c")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nn-cscobj-iofflinefilesitemfilter
interface IOfflineFilesItemFilter : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesitemfilter-getfilterflags
    HRESULT GetFilterFlags(ulong* pullFlags, ulong* pullMask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesitemfilter-gettimefilter
    HRESULT GetTimeFilter(FILETIME* pftTime, BOOL* pbEvalTimeOfDay, OFFLINEFILES_ITEM_TIME* pTimeType, 
                          OFFLINEFILES_COMPARE* pCompare);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesitemfilter-getpatternfilter
    HRESULT GetPatternFilter(PWSTR pszPattern, uint cchPattern);
}

@GUID("4a753da6-e044-4f12-a718-5d14d079a906")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nn-cscobj-iofflinefilesitem
interface IOfflineFilesItem : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesitem-getitemtype
    HRESULT GetItemType(OFFLINEFILES_ITEM_TYPE* pItemType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesitem-getpath
    HRESULT GetPath(PWSTR* ppszPath);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesitem-getparentitem
    HRESULT GetParentItem(IOfflineFilesItem* ppItem);
    HRESULT Refresh(uint dwQueryFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesitem-ismarkedfordeletion
    HRESULT IsMarkedForDeletion(BOOL* pbMarkedForDeletion);
}

@GUID("9b1c9576-a92b-4151-8e9e-7c7b3ec2e016")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nn-cscobj-iofflinefilesserveritem
interface IOfflineFilesServerItem : IOfflineFilesItem
{
}

@GUID("bab7e48d-4804-41b5-a44d-0f199b06b145")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nn-cscobj-iofflinefilesshareitem
interface IOfflineFilesShareItem : IOfflineFilesItem
{
}

@GUID("2273597a-a08c-4a00-a37a-c1ae4e9a1cfd")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nn-cscobj-iofflinefilesdirectoryitem
interface IOfflineFilesDirectoryItem : IOfflineFilesItem
{
}

@GUID("8dfadead-26c2-4eff-8a72-6b50723d9a00")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nn-cscobj-iofflinefilesfileitem
interface IOfflineFilesFileItem : IOfflineFilesItem
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesfileitem-issparse
    HRESULT IsSparse(BOOL* pbIsSparse);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesfileitem-isencrypted
    HRESULT IsEncrypted(BOOL* pbIsEncrypted);
}

@GUID("da70e815-c361-4407-bc0b-0d7046e5f2cd")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nn-cscobj-ienumofflinefilesitems
interface IEnumOfflineFilesItems : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-ienumofflinefilesitems-next
    HRESULT Next(uint celt, IOfflineFilesItem* rgelt, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-ienumofflinefilesitems-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-ienumofflinefilesitems-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-ienumofflinefilesitems-clone
    HRESULT Clone(IEnumOfflineFilesItems* ppenum);
}

@GUID("3836f049-9413-45dd-bf46-b5aaa82dc310")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nn-cscobj-iofflinefilesitemcontainer
interface IOfflineFilesItemContainer : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesitemcontainer-enumitems
    HRESULT EnumItems(uint dwQueryFlags, IEnumOfflineFilesItems* ppenum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesitemcontainer-enumitemsex
    HRESULT EnumItemsEx(IOfflineFilesItemFilter pIncludeFileFilter, IOfflineFilesItemFilter pIncludeDirFilter, 
                        IOfflineFilesItemFilter pExcludeFileFilter, IOfflineFilesItemFilter pExcludeDirFilter, 
                        uint dwEnumFlags, uint dwQueryFlags, IEnumOfflineFilesItems* ppenum);
}

@GUID("a96e6fa4-e0d1-4c29-960b-ee508fe68c72")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nn-cscobj-iofflinefileschangeinfo
interface IOfflineFilesChangeInfo : IUnknown
{
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT IsDirty(BOOL* pbDirty);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefileschangeinfo-isdeletedoffline
    HRESULT IsDeletedOffline(BOOL* pbDeletedOffline);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefileschangeinfo-iscreatedoffline
    HRESULT IsCreatedOffline(BOOL* pbCreatedOffline);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefileschangeinfo-islocallymodifieddata
    HRESULT IsLocallyModifiedData(BOOL* pbLocallyModifiedData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefileschangeinfo-islocallymodifiedattributes
    HRESULT IsLocallyModifiedAttributes(BOOL* pbLocallyModifiedAttributes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefileschangeinfo-islocallymodifiedtime
    HRESULT IsLocallyModifiedTime(BOOL* pbLocallyModifiedTime);
}

@GUID("0f50ce33-bac9-4eaa-a11d-da0e527d047d")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nn-cscobj-iofflinefilesdirtyinfo
interface IOfflineFilesDirtyInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesdirtyinfo-localdirtybytecount
    HRESULT LocalDirtyByteCount(long* pDirtyByteCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesdirtyinfo-remotedirtybytecount
    HRESULT RemoteDirtyByteCount(long* pDirtyByteCount);
}

@GUID("bc1a163f-7bfd-4d88-9c66-96ea9a6a3d6b")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nn-cscobj-iofflinefilesfilesysinfo
interface IOfflineFilesFileSysInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesfilesysinfo-getattributes
    HRESULT GetAttributes(OFFLINEFILES_ITEM_COPY copy, uint* pdwAttributes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesfilesysinfo-gettimes
    HRESULT GetTimes(OFFLINEFILES_ITEM_COPY copy, FILETIME* pftCreationTime, FILETIME* pftLastWriteTime, 
                     FILETIME* pftChangeTime, FILETIME* pftLastAccessTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesfilesysinfo-getfilesize
    HRESULT GetFileSize(OFFLINEFILES_ITEM_COPY copy, long* pSize);
}

@GUID("5b2b0655-b3fd-497d-adeb-bd156bc8355b")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nn-cscobj-iofflinefilespininfo
interface IOfflineFilesPinInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilespininfo-ispinned
    HRESULT IsPinned(BOOL* pbPinned);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilespininfo-ispinnedforuser
    HRESULT IsPinnedForUser(BOOL* pbPinnedForUser, BOOL* pbInherit);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilespininfo-ispinnedforuserbypolicy
    HRESULT IsPinnedForUserByPolicy(BOOL* pbPinnedForUser, BOOL* pbInherit);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilespininfo-ispinnedforcomputer
    HRESULT IsPinnedForComputer(BOOL* pbPinnedForComputer, BOOL* pbInherit);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilespininfo-ispinnedforfolderredirection
    HRESULT IsPinnedForFolderRedirection(BOOL* pbPinnedForFolderRedirection, BOOL* pbInherit);
}

@GUID("623c58a2-42ed-4ad7-b69a-0f1b30a72d0d")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nn-cscobj-iofflinefilespininfo2
interface IOfflineFilesPinInfo2 : IOfflineFilesPinInfo
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilespininfo2-ispartlypinned
    HRESULT IsPartlyPinned(BOOL* pbPartlyPinned);
}

@GUID("bcaf4a01-5b68-4b56-a6a1-8d2786ede8e3")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nn-cscobj-iofflinefilestransparentcacheinfo
interface IOfflineFilesTransparentCacheInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilestransparentcacheinfo-istransparentlycached
    HRESULT IsTransparentlyCached(BOOL* pbTransparentlyCached);
}

@GUID("2b09d48c-8ab5-464f-a755-a59d92f99429")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nn-cscobj-iofflinefilesghostinfo
interface IOfflineFilesGhostInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesghostinfo-isghosted
    HRESULT IsGhosted(BOOL* pbGhosted);
}

@GUID("efb23a09-a867-4be8-83a6-86969a7d0856")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nn-cscobj-iofflinefilesconnectioninfo
interface IOfflineFilesConnectionInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesconnectioninfo-getconnectstate
    HRESULT GetConnectState(OFFLINEFILES_CONNECT_STATE* pConnectState, OFFLINEFILES_OFFLINE_REASON* pOfflineReason);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesconnectioninfo-setconnectstate
    HRESULT SetConnectState(HWND hwndParent, uint dwFlags, OFFLINEFILES_CONNECT_STATE ConnectState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesconnectioninfo-transitiononline
    HRESULT TransitionOnline(HWND hwndParent, uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesconnectioninfo-transitionoffline
    HRESULT TransitionOffline(HWND hwndParent, uint dwFlags, BOOL bForceOpenFilesClosed, 
                              BOOL* pbOpenFilesPreventedTransition);
}

@GUID("7bcc43e7-31ce-4ca4-8ccd-1cff2dc494da")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nn-cscobj-iofflinefilesshareinfo
interface IOfflineFilesShareInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesshareinfo-getshareitem
    HRESULT GetShareItem(IOfflineFilesShareItem* ppShareItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesshareinfo-getsharecachingmode
    HRESULT GetShareCachingMode(OFFLINEFILES_CACHING_MODE* pCachingMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilesshareinfo-issharedfsjunction
    HRESULT IsShareDfsJunction(BOOL* pbIsDfsJunction);
}

@GUID("62c4560f-bc0b-48ca-ad9d-34cb528d99a9")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nn-cscobj-iofflinefilessuspend
interface IOfflineFilesSuspend : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilessuspend-suspendroot
    HRESULT SuspendRoot(BOOL bSuspend);
}

@GUID("a457c25b-4e9c-4b04-85af-8932ccd97889")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nn-cscobj-iofflinefilessuspendinfo
interface IOfflineFilesSuspendInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilessuspendinfo-issuspended
    HRESULT IsSuspended(BOOL* pbSuspended, BOOL* pbSuspendedRoot);
}

@GUID("d871d3f7-f613-48a1-827e-7a34e560fff6")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nn-cscobj-iofflinefilessetting
interface IOfflineFilesSetting : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilessetting-getname
    HRESULT GetName(PWSTR* ppszName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilessetting-getvaluetype
    HRESULT GetValueType(OFFLINEFILES_SETTING_VALUE_TYPE* pType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilessetting-getpreference
    HRESULT GetPreference(VARIANT* pvarValue, uint dwScope);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilessetting-getpreferencescope
    HRESULT GetPreferenceScope(uint* pdwScope);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilessetting-setpreference
    HRESULT SetPreference(const(VARIANT)* pvarValue, uint dwScope);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilessetting-deletepreference
    HRESULT DeletePreference(uint dwScope);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilessetting-getpolicy
    HRESULT GetPolicy(VARIANT* pvarValue, uint dwScope);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilessetting-getpolicyscope
    HRESULT GetPolicyScope(uint* pdwScope);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilessetting-getvalue
    HRESULT GetValue(VARIANT* pvarValue, BOOL* pbSetByPolicy);
}

@GUID("729680c4-1a38-47bc-9e5c-02c51562ac30")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nn-cscobj-ienumofflinefilessettings
interface IEnumOfflineFilesSettings : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-ienumofflinefilessettings-next
    HRESULT Next(uint celt, IOfflineFilesSetting* rgelt, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-ienumofflinefilessettings-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-ienumofflinefilessettings-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-ienumofflinefilessettings-clone
    HRESULT Clone(IEnumOfflineFilesSettings* ppenum);
}

@GUID("855d6203-7914-48b9-8d40-4c56f5acffc5")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nn-cscobj-iofflinefilescache
interface IOfflineFilesCache : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilescache-synchronize
    HRESULT Synchronize(HWND hwndParent, const(PWSTR)* rgpszPaths, uint cPaths, BOOL bAsync, uint dwSyncControl, 
                        IOfflineFilesSyncConflictHandler pISyncConflictHandler, IOfflineFilesSyncProgress pIProgress, 
                        GUID* pSyncId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilescache-deleteitems
    HRESULT DeleteItems(const(PWSTR)* rgpszPaths, uint cPaths, uint dwFlags, BOOL bAsync, 
                        IOfflineFilesSimpleProgress pIProgress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilescache-deleteitemsforuser
    HRESULT DeleteItemsForUser(const(PWSTR) pszUser, const(PWSTR)* rgpszPaths, uint cPaths, uint dwFlags, 
                               BOOL bAsync, IOfflineFilesSimpleProgress pIProgress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilescache-pin
    HRESULT Pin(HWND hwndParent, const(PWSTR)* rgpszPaths, uint cPaths, BOOL bDeep, BOOL bAsync, 
                uint dwPinControlFlags, IOfflineFilesSyncProgress pIProgress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilescache-unpin
    HRESULT Unpin(HWND hwndParent, const(PWSTR)* rgpszPaths, uint cPaths, BOOL bDeep, BOOL bAsync, 
                  uint dwPinControlFlags, IOfflineFilesSyncProgress pIProgress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilescache-getencryptionstatus
    HRESULT GetEncryptionStatus(BOOL* pbEncrypted, BOOL* pbPartial);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilescache-encrypt
    HRESULT Encrypt(HWND hwndParent, BOOL bEncrypt, uint dwEncryptionControlFlags, BOOL bAsync, 
                    IOfflineFilesSyncProgress pIProgress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilescache-finditem
    HRESULT FindItem(const(PWSTR) pszPath, uint dwQueryFlags, IOfflineFilesItem* ppItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilescache-finditemex
    HRESULT FindItemEx(const(PWSTR) pszPath, IOfflineFilesItemFilter pIncludeFileFilter, 
                       IOfflineFilesItemFilter pIncludeDirFilter, IOfflineFilesItemFilter pExcludeFileFilter, 
                       IOfflineFilesItemFilter pExcludeDirFilter, uint dwQueryFlags, IOfflineFilesItem* ppItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilescache-renameitem
    HRESULT RenameItem(const(PWSTR) pszPathOriginal, const(PWSTR) pszPathNew, BOOL bReplaceIfExists);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilescache-getlocation
    HRESULT GetLocation(PWSTR* ppszPath);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilescache-getdiskspaceinformation
    HRESULT GetDiskSpaceInformation(ulong* pcbVolumeTotal, ulong* pcbLimit, ulong* pcbUsed, 
                                    ulong* pcbUnpinnedLimit, ulong* pcbUnpinnedUsed);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilescache-setdiskspacelimits
    HRESULT SetDiskSpaceLimits(ulong cbLimit, ulong cbUnpinnedLimit);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilescache-processadminpinpolicy
    HRESULT ProcessAdminPinPolicy(IOfflineFilesSyncProgress pPinProgress, IOfflineFilesSyncProgress pUnpinProgress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilescache-getsettingobject
    HRESULT GetSettingObject(const(PWSTR) pszSettingName, IOfflineFilesSetting* ppSetting);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilescache-enumsettingobjects
    HRESULT EnumSettingObjects(IEnumOfflineFilesSettings* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilescache-ispathcacheable
    HRESULT IsPathCacheable(const(PWSTR) pszPath, BOOL* pbCacheable, OFFLINEFILES_CACHING_MODE* pShareCachingMode);
}

@GUID("8c075039-1551-4ed9-8781-56705c04d3c0")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nn-cscobj-iofflinefilescache2
interface IOfflineFilesCache2 : IOfflineFilesCache
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cscobj/nf-cscobj-iofflinefilescache2-renameitemex
    HRESULT RenameItemEx(const(PWSTR) pszPathOriginal, const(PWSTR) pszPathNew, BOOL bReplaceIfExists);
}


// GUIDs

const GUID CLSID_OfflineFilesCache   = GUIDOF!OfflineFilesCache;
const GUID CLSID_OfflineFilesSetting = GUIDOF!OfflineFilesSetting;

const GUID IID_IEnumOfflineFilesItems            = GUIDOF!IEnumOfflineFilesItems;
const GUID IID_IEnumOfflineFilesSettings         = GUIDOF!IEnumOfflineFilesSettings;
const GUID IID_IOfflineFilesCache                = GUIDOF!IOfflineFilesCache;
const GUID IID_IOfflineFilesCache2               = GUIDOF!IOfflineFilesCache2;
const GUID IID_IOfflineFilesChangeInfo           = GUIDOF!IOfflineFilesChangeInfo;
const GUID IID_IOfflineFilesConnectionInfo       = GUIDOF!IOfflineFilesConnectionInfo;
const GUID IID_IOfflineFilesDirectoryItem        = GUIDOF!IOfflineFilesDirectoryItem;
const GUID IID_IOfflineFilesDirtyInfo            = GUIDOF!IOfflineFilesDirtyInfo;
const GUID IID_IOfflineFilesErrorInfo            = GUIDOF!IOfflineFilesErrorInfo;
const GUID IID_IOfflineFilesEvents               = GUIDOF!IOfflineFilesEvents;
const GUID IID_IOfflineFilesEvents2              = GUIDOF!IOfflineFilesEvents2;
const GUID IID_IOfflineFilesEvents3              = GUIDOF!IOfflineFilesEvents3;
const GUID IID_IOfflineFilesEvents4              = GUIDOF!IOfflineFilesEvents4;
const GUID IID_IOfflineFilesEventsFilter         = GUIDOF!IOfflineFilesEventsFilter;
const GUID IID_IOfflineFilesFileItem             = GUIDOF!IOfflineFilesFileItem;
const GUID IID_IOfflineFilesFileSysInfo          = GUIDOF!IOfflineFilesFileSysInfo;
const GUID IID_IOfflineFilesGhostInfo            = GUIDOF!IOfflineFilesGhostInfo;
const GUID IID_IOfflineFilesItem                 = GUIDOF!IOfflineFilesItem;
const GUID IID_IOfflineFilesItemContainer        = GUIDOF!IOfflineFilesItemContainer;
const GUID IID_IOfflineFilesItemFilter           = GUIDOF!IOfflineFilesItemFilter;
const GUID IID_IOfflineFilesPinInfo              = GUIDOF!IOfflineFilesPinInfo;
const GUID IID_IOfflineFilesPinInfo2             = GUIDOF!IOfflineFilesPinInfo2;
const GUID IID_IOfflineFilesProgress             = GUIDOF!IOfflineFilesProgress;
const GUID IID_IOfflineFilesServerItem           = GUIDOF!IOfflineFilesServerItem;
const GUID IID_IOfflineFilesSetting              = GUIDOF!IOfflineFilesSetting;
const GUID IID_IOfflineFilesShareInfo            = GUIDOF!IOfflineFilesShareInfo;
const GUID IID_IOfflineFilesShareItem            = GUIDOF!IOfflineFilesShareItem;
const GUID IID_IOfflineFilesSimpleProgress       = GUIDOF!IOfflineFilesSimpleProgress;
const GUID IID_IOfflineFilesSuspend              = GUIDOF!IOfflineFilesSuspend;
const GUID IID_IOfflineFilesSuspendInfo          = GUIDOF!IOfflineFilesSuspendInfo;
const GUID IID_IOfflineFilesSyncConflictHandler  = GUIDOF!IOfflineFilesSyncConflictHandler;
const GUID IID_IOfflineFilesSyncErrorInfo        = GUIDOF!IOfflineFilesSyncErrorInfo;
const GUID IID_IOfflineFilesSyncErrorItemInfo    = GUIDOF!IOfflineFilesSyncErrorItemInfo;
const GUID IID_IOfflineFilesSyncProgress         = GUIDOF!IOfflineFilesSyncProgress;
const GUID IID_IOfflineFilesTransparentCacheInfo = GUIDOF!IOfflineFilesTransparentCacheInfo;
