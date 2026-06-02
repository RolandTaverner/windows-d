// Written in the D programming language.

module windows.win32.foundation;

public import windows.core;

extern(Windows) @nogc nothrow:


// Enums


alias WIN32_ERROR = uint;
enum : uint
{
    NO_ERROR                                                                       = 0x00000000U,
    ERROR_EXPECTED_SECTION_NAME                                                    = 0xe0000000U,
    ERROR_BAD_SECTION_NAME_LINE                                                    = 0xe0000001U,
    ERROR_SECTION_NAME_TOO_LONG                                                    = 0xe0000002U,
    ERROR_GENERAL_SYNTAX                                                           = 0xe0000003U,
    ERROR_WRONG_INF_STYLE                                                          = 0xe0000100U,
    ERROR_SECTION_NOT_FOUND                                                        = 0xe0000101U,
    ERROR_LINE_NOT_FOUND                                                           = 0xe0000102U,
    ERROR_NO_BACKUP                                                                = 0xe0000103U,
    ERROR_NO_ASSOCIATED_CLASS                                                      = 0xe0000200U,
    ERROR_CLASS_MISMATCH                                                           = 0xe0000201U,
    ERROR_DUPLICATE_FOUND                                                          = 0xe0000202U,
    ERROR_NO_DRIVER_SELECTED                                                       = 0xe0000203U,
    ERROR_KEY_DOES_NOT_EXIST                                                       = 0xe0000204U,
    ERROR_INVALID_DEVINST_NAME                                                     = 0xe0000205U,
    ERROR_INVALID_CLASS                                                            = 0xe0000206U,
    ERROR_DEVINST_ALREADY_EXISTS                                                   = 0xe0000207U,
    ERROR_DEVINFO_NOT_REGISTERED                                                   = 0xe0000208U,
    ERROR_INVALID_REG_PROPERTY                                                     = 0xe0000209U,
    ERROR_NO_INF                                                                   = 0xe000020aU,
    ERROR_NO_SUCH_DEVINST                                                          = 0xe000020bU,
    ERROR_CANT_LOAD_CLASS_ICON                                                     = 0xe000020cU,
    ERROR_INVALID_CLASS_INSTALLER                                                  = 0xe000020dU,
    ERROR_DI_DO_DEFAULT                                                            = 0xe000020eU,
    ERROR_DI_NOFILECOPY                                                            = 0xe000020fU,
    ERROR_INVALID_HWPROFILE                                                        = 0xe0000210U,
    ERROR_NO_DEVICE_SELECTED                                                       = 0xe0000211U,
    ERROR_DEVINFO_LIST_LOCKED                                                      = 0xe0000212U,
    ERROR_DEVINFO_DATA_LOCKED                                                      = 0xe0000213U,
    ERROR_DI_BAD_PATH                                                              = 0xe0000214U,
    ERROR_NO_CLASSINSTALL_PARAMS                                                   = 0xe0000215U,
    ERROR_FILEQUEUE_LOCKED                                                         = 0xe0000216U,
    ERROR_BAD_SERVICE_INSTALLSECT                                                  = 0xe0000217U,
    ERROR_NO_CLASS_DRIVER_LIST                                                     = 0xe0000218U,
    ERROR_NO_ASSOCIATED_SERVICE                                                    = 0xe0000219U,
    ERROR_NO_DEFAULT_DEVICE_INTERFACE                                              = 0xe000021aU,
    ERROR_DEVICE_INTERFACE_ACTIVE                                                  = 0xe000021bU,
    ERROR_DEVICE_INTERFACE_REMOVED                                                 = 0xe000021cU,
    ERROR_BAD_INTERFACE_INSTALLSECT                                                = 0xe000021dU,
    ERROR_NO_SUCH_INTERFACE_CLASS                                                  = 0xe000021eU,
    ERROR_INVALID_REFERENCE_STRING                                                 = 0xe000021fU,
    ERROR_INVALID_MACHINENAME                                                      = 0xe0000220U,
    ERROR_REMOTE_COMM_FAILURE                                                      = 0xe0000221U,
    ERROR_MACHINE_UNAVAILABLE                                                      = 0xe0000222U,
    ERROR_NO_CONFIGMGR_SERVICES                                                    = 0xe0000223U,
    ERROR_INVALID_PROPPAGE_PROVIDER                                                = 0xe0000224U,
    ERROR_NO_SUCH_DEVICE_INTERFACE                                                 = 0xe0000225U,
    ERROR_DI_POSTPROCESSING_REQUIRED                                               = 0xe0000226U,
    ERROR_INVALID_COINSTALLER                                                      = 0xe0000227U,
    ERROR_NO_COMPAT_DRIVERS                                                        = 0xe0000228U,
    ERROR_NO_DEVICE_ICON                                                           = 0xe0000229U,
    ERROR_INVALID_INF_LOGCONFIG                                                    = 0xe000022aU,
    ERROR_DI_DONT_INSTALL                                                          = 0xe000022bU,
    ERROR_INVALID_FILTER_DRIVER                                                    = 0xe000022cU,
    ERROR_NON_WINDOWS_NT_DRIVER                                                    = 0xe000022dU,
    ERROR_NON_WINDOWS_DRIVER                                                       = 0xe000022eU,
    ERROR_NO_CATALOG_FOR_OEM_INF                                                   = 0xe000022fU,
    ERROR_DEVINSTALL_QUEUE_NONNATIVE                                               = 0xe0000230U,
    ERROR_NOT_DISABLEABLE                                                          = 0xe0000231U,
    ERROR_CANT_REMOVE_DEVINST                                                      = 0xe0000232U,
    ERROR_INVALID_TARGET                                                           = 0xe0000233U,
    ERROR_DRIVER_NONNATIVE                                                         = 0xe0000234U,
    ERROR_IN_WOW64                                                                 = 0xe0000235U,
    ERROR_SET_SYSTEM_RESTORE_POINT                                                 = 0xe0000236U,
    ERROR_SCE_DISABLED                                                             = 0xe0000238U,
    ERROR_UNKNOWN_EXCEPTION                                                        = 0xe0000239U,
    ERROR_PNP_REGISTRY_ERROR                                                       = 0xe000023aU,
    ERROR_REMOTE_REQUEST_UNSUPPORTED                                               = 0xe000023bU,
    ERROR_NOT_AN_INSTALLED_OEM_INF                                                 = 0xe000023cU,
    ERROR_INF_IN_USE_BY_DEVICES                                                    = 0xe000023dU,
    ERROR_DI_FUNCTION_OBSOLETE                                                     = 0xe000023eU,
    ERROR_NO_AUTHENTICODE_CATALOG                                                  = 0xe000023fU,
    ERROR_AUTHENTICODE_DISALLOWED                                                  = 0xe0000240U,
    ERROR_AUTHENTICODE_TRUSTED_PUBLISHER                                           = 0xe0000241U,
    ERROR_AUTHENTICODE_TRUST_NOT_ESTABLISHED                                       = 0xe0000242U,
    ERROR_AUTHENTICODE_PUBLISHER_NOT_TRUSTED                                       = 0xe0000243U,
    ERROR_SIGNATURE_OSATTRIBUTE_MISMATCH                                           = 0xe0000244U,
    ERROR_ONLY_VALIDATE_VIA_AUTHENTICODE                                           = 0xe0000245U,
    ERROR_DEVICE_INSTALLER_NOT_READY                                               = 0xe0000246U,
    ERROR_DRIVER_STORE_ADD_FAILED                                                  = 0xe0000247U,
    ERROR_DEVICE_INSTALL_BLOCKED                                                   = 0xe0000248U,
    ERROR_DRIVER_INSTALL_BLOCKED                                                   = 0xe0000249U,
    ERROR_WRONG_INF_TYPE                                                           = 0xe000024aU,
    ERROR_FILE_HASH_NOT_IN_CATALOG                                                 = 0xe000024bU,
    ERROR_DRIVER_STORE_DELETE_FAILED                                               = 0xe000024cU,
    ERROR_UNRECOVERABLE_STACK_OVERFLOW                                             = 0xe0000300U,
    ERROR_NO_DEFAULT_INTERFACE_DEVICE                                              = 0xe000021aU,
    ERROR_INTERFACE_DEVICE_ACTIVE                                                  = 0xe000021bU,
    ERROR_INTERFACE_DEVICE_REMOVED                                                 = 0xe000021cU,
    ERROR_NO_SUCH_INTERFACE_DEVICE                                                 = 0xe0000225U,
    ERROR_NOT_INSTALLED                                                            = 0xe0001000U,
    ERROR_SUCCESS                                                                  = 0x00000000U,
    ERROR_INVALID_FUNCTION                                                         = 0x00000001U,
    ERROR_FILE_NOT_FOUND                                                           = 0x00000002U,
    ERROR_PATH_NOT_FOUND                                                           = 0x00000003U,
    ERROR_TOO_MANY_OPEN_FILES                                                      = 0x00000004U,
    ERROR_ACCESS_DENIED                                                            = 0x00000005U,
    ERROR_INVALID_HANDLE                                                           = 0x00000006U,
    ERROR_ARENA_TRASHED                                                            = 0x00000007U,
    ERROR_NOT_ENOUGH_MEMORY                                                        = 0x00000008U,
    ERROR_INVALID_BLOCK                                                            = 0x00000009U,
    ERROR_BAD_ENVIRONMENT                                                          = 0x0000000aU,
    ERROR_BAD_FORMAT                                                               = 0x0000000bU,
    ERROR_INVALID_ACCESS                                                           = 0x0000000cU,
    ERROR_INVALID_DATA                                                             = 0x0000000dU,
    ERROR_OUTOFMEMORY                                                              = 0x0000000eU,
    ERROR_INVALID_DRIVE                                                            = 0x0000000fU,
    ERROR_CURRENT_DIRECTORY                                                        = 0x00000010U,
    ERROR_NOT_SAME_DEVICE                                                          = 0x00000011U,
    ERROR_NO_MORE_FILES                                                            = 0x00000012U,
    ERROR_WRITE_PROTECT                                                            = 0x00000013U,
    ERROR_BAD_UNIT                                                                 = 0x00000014U,
    ERROR_NOT_READY                                                                = 0x00000015U,
    ERROR_BAD_COMMAND                                                              = 0x00000016U,
    ERROR_CRC                                                                      = 0x00000017U,
    ERROR_BAD_LENGTH                                                               = 0x00000018U,
    ERROR_SEEK                                                                     = 0x00000019U,
    ERROR_NOT_DOS_DISK                                                             = 0x0000001aU,
    ERROR_SECTOR_NOT_FOUND                                                         = 0x0000001bU,
    ERROR_OUT_OF_PAPER                                                             = 0x0000001cU,
    ERROR_WRITE_FAULT                                                              = 0x0000001dU,
    ERROR_READ_FAULT                                                               = 0x0000001eU,
    ERROR_GEN_FAILURE                                                              = 0x0000001fU,
    ERROR_SHARING_VIOLATION                                                        = 0x00000020U,
    ERROR_LOCK_VIOLATION                                                           = 0x00000021U,
    ERROR_WRONG_DISK                                                               = 0x00000022U,
    ERROR_SHARING_BUFFER_EXCEEDED                                                  = 0x00000024U,
    ERROR_HANDLE_EOF                                                               = 0x00000026U,
    ERROR_HANDLE_DISK_FULL                                                         = 0x00000027U,
    ERROR_NOT_SUPPORTED                                                            = 0x00000032U,
    ERROR_REM_NOT_LIST                                                             = 0x00000033U,
    ERROR_DUP_NAME                                                                 = 0x00000034U,
    ERROR_BAD_NETPATH                                                              = 0x00000035U,
    ERROR_NETWORK_BUSY                                                             = 0x00000036U,
    ERROR_DEV_NOT_EXIST                                                            = 0x00000037U,
    ERROR_TOO_MANY_CMDS                                                            = 0x00000038U,
    ERROR_ADAP_HDW_ERR                                                             = 0x00000039U,
    ERROR_BAD_NET_RESP                                                             = 0x0000003aU,
    ERROR_UNEXP_NET_ERR                                                            = 0x0000003bU,
    ERROR_BAD_REM_ADAP                                                             = 0x0000003cU,
    ERROR_PRINTQ_FULL                                                              = 0x0000003dU,
    ERROR_NO_SPOOL_SPACE                                                           = 0x0000003eU,
    ERROR_PRINT_CANCELLED                                                          = 0x0000003fU,
    ERROR_NETNAME_DELETED                                                          = 0x00000040U,
    ERROR_NETWORK_ACCESS_DENIED                                                    = 0x00000041U,
    ERROR_BAD_DEV_TYPE                                                             = 0x00000042U,
    ERROR_BAD_NET_NAME                                                             = 0x00000043U,
    ERROR_TOO_MANY_NAMES                                                           = 0x00000044U,
    ERROR_TOO_MANY_SESS                                                            = 0x00000045U,
    ERROR_SHARING_PAUSED                                                           = 0x00000046U,
    ERROR_REQ_NOT_ACCEP                                                            = 0x00000047U,
    ERROR_REDIR_PAUSED                                                             = 0x00000048U,
    ERROR_FILE_EXISTS                                                              = 0x00000050U,
    ERROR_CANNOT_MAKE                                                              = 0x00000052U,
    ERROR_FAIL_I24                                                                 = 0x00000053U,
    ERROR_OUT_OF_STRUCTURES                                                        = 0x00000054U,
    ERROR_ALREADY_ASSIGNED                                                         = 0x00000055U,
    ERROR_INVALID_PASSWORD                                                         = 0x00000056U,
    ERROR_INVALID_PARAMETER                                                        = 0x00000057U,
    ERROR_NET_WRITE_FAULT                                                          = 0x00000058U,
    ERROR_NO_PROC_SLOTS                                                            = 0x00000059U,
    ERROR_TOO_MANY_SEMAPHORES                                                      = 0x00000064U,
    ERROR_EXCL_SEM_ALREADY_OWNED                                                   = 0x00000065U,
    ERROR_SEM_IS_SET                                                               = 0x00000066U,
    ERROR_TOO_MANY_SEM_REQUESTS                                                    = 0x00000067U,
    ERROR_INVALID_AT_INTERRUPT_TIME                                                = 0x00000068U,
    ERROR_SEM_OWNER_DIED                                                           = 0x00000069U,
    ERROR_SEM_USER_LIMIT                                                           = 0x0000006aU,
    ERROR_DISK_CHANGE                                                              = 0x0000006bU,
    ERROR_DRIVE_LOCKED                                                             = 0x0000006cU,
    ERROR_BROKEN_PIPE                                                              = 0x0000006dU,
    ERROR_OPEN_FAILED                                                              = 0x0000006eU,
    ERROR_BUFFER_OVERFLOW                                                          = 0x0000006fU,
    ERROR_DISK_FULL                                                                = 0x00000070U,
    ERROR_NO_MORE_SEARCH_HANDLES                                                   = 0x00000071U,
    ERROR_INVALID_TARGET_HANDLE                                                    = 0x00000072U,
    ERROR_INVALID_CATEGORY                                                         = 0x00000075U,
    ERROR_INVALID_VERIFY_SWITCH                                                    = 0x00000076U,
    ERROR_BAD_DRIVER_LEVEL                                                         = 0x00000077U,
    ERROR_CALL_NOT_IMPLEMENTED                                                     = 0x00000078U,
    ERROR_SEM_TIMEOUT                                                              = 0x00000079U,
    ERROR_INSUFFICIENT_BUFFER                                                      = 0x0000007aU,
    ERROR_INVALID_NAME                                                             = 0x0000007bU,
    ERROR_INVALID_LEVEL                                                            = 0x0000007cU,
    ERROR_NO_VOLUME_LABEL                                                          = 0x0000007dU,
    ERROR_MOD_NOT_FOUND                                                            = 0x0000007eU,
    ERROR_PROC_NOT_FOUND                                                           = 0x0000007fU,
    ERROR_WAIT_NO_CHILDREN                                                         = 0x00000080U,
    ERROR_CHILD_NOT_COMPLETE                                                       = 0x00000081U,
    ERROR_DIRECT_ACCESS_HANDLE                                                     = 0x00000082U,
    ERROR_NEGATIVE_SEEK                                                            = 0x00000083U,
    ERROR_SEEK_ON_DEVICE                                                           = 0x00000084U,
    ERROR_IS_JOIN_TARGET                                                           = 0x00000085U,
    ERROR_IS_JOINED                                                                = 0x00000086U,
    ERROR_IS_SUBSTED                                                               = 0x00000087U,
    ERROR_NOT_JOINED                                                               = 0x00000088U,
    ERROR_NOT_SUBSTED                                                              = 0x00000089U,
    ERROR_JOIN_TO_JOIN                                                             = 0x0000008aU,
    ERROR_SUBST_TO_SUBST                                                           = 0x0000008bU,
    ERROR_JOIN_TO_SUBST                                                            = 0x0000008cU,
    ERROR_SUBST_TO_JOIN                                                            = 0x0000008dU,
    ERROR_BUSY_DRIVE                                                               = 0x0000008eU,
    ERROR_SAME_DRIVE                                                               = 0x0000008fU,
    ERROR_DIR_NOT_ROOT                                                             = 0x00000090U,
    ERROR_DIR_NOT_EMPTY                                                            = 0x00000091U,
    ERROR_IS_SUBST_PATH                                                            = 0x00000092U,
    ERROR_IS_JOIN_PATH                                                             = 0x00000093U,
    ERROR_PATH_BUSY                                                                = 0x00000094U,
    ERROR_IS_SUBST_TARGET                                                          = 0x00000095U,
    ERROR_SYSTEM_TRACE                                                             = 0x00000096U,
    ERROR_INVALID_EVENT_COUNT                                                      = 0x00000097U,
    ERROR_TOO_MANY_MUXWAITERS                                                      = 0x00000098U,
    ERROR_INVALID_LIST_FORMAT                                                      = 0x00000099U,
    ERROR_LABEL_TOO_LONG                                                           = 0x0000009aU,
    ERROR_TOO_MANY_TCBS                                                            = 0x0000009bU,
    ERROR_SIGNAL_REFUSED                                                           = 0x0000009cU,
    ERROR_DISCARDED                                                                = 0x0000009dU,
    ERROR_NOT_LOCKED                                                               = 0x0000009eU,
    ERROR_BAD_THREADID_ADDR                                                        = 0x0000009fU,
    ERROR_BAD_ARGUMENTS                                                            = 0x000000a0U,
    ERROR_BAD_PATHNAME                                                             = 0x000000a1U,
    ERROR_SIGNAL_PENDING                                                           = 0x000000a2U,
    ERROR_MAX_THRDS_REACHED                                                        = 0x000000a4U,
    ERROR_LOCK_FAILED                                                              = 0x000000a7U,
    ERROR_BUSY                                                                     = 0x000000aaU,
    ERROR_DEVICE_SUPPORT_IN_PROGRESS                                               = 0x000000abU,
    ERROR_CANCEL_VIOLATION                                                         = 0x000000adU,
    ERROR_ATOMIC_LOCKS_NOT_SUPPORTED                                               = 0x000000aeU,
    ERROR_INVALID_SEGMENT_NUMBER                                                   = 0x000000b4U,
    ERROR_INVALID_ORDINAL                                                          = 0x000000b6U,
    ERROR_ALREADY_EXISTS                                                           = 0x000000b7U,
    ERROR_INVALID_FLAG_NUMBER                                                      = 0x000000baU,
    ERROR_SEM_NOT_FOUND                                                            = 0x000000bbU,
    ERROR_INVALID_STARTING_CODESEG                                                 = 0x000000bcU,
    ERROR_INVALID_STACKSEG                                                         = 0x000000bdU,
    ERROR_INVALID_MODULETYPE                                                       = 0x000000beU,
    ERROR_INVALID_EXE_SIGNATURE                                                    = 0x000000bfU,
    ERROR_EXE_MARKED_INVALID                                                       = 0x000000c0U,
    ERROR_BAD_EXE_FORMAT                                                           = 0x000000c1U,
    ERROR_ITERATED_DATA_EXCEEDS_64k                                                = 0x000000c2U,
    ERROR_INVALID_MINALLOCSIZE                                                     = 0x000000c3U,
    ERROR_DYNLINK_FROM_INVALID_RING                                                = 0x000000c4U,
    ERROR_IOPL_NOT_ENABLED                                                         = 0x000000c5U,
    ERROR_INVALID_SEGDPL                                                           = 0x000000c6U,
    ERROR_AUTODATASEG_EXCEEDS_64k                                                  = 0x000000c7U,
    ERROR_RING2SEG_MUST_BE_MOVABLE                                                 = 0x000000c8U,
    ERROR_RELOC_CHAIN_XEEDS_SEGLIM                                                 = 0x000000c9U,
    ERROR_INFLOOP_IN_RELOC_CHAIN                                                   = 0x000000caU,
    ERROR_ENVVAR_NOT_FOUND                                                         = 0x000000cbU,
    ERROR_NO_SIGNAL_SENT                                                           = 0x000000cdU,
    ERROR_FILENAME_EXCED_RANGE                                                     = 0x000000ceU,
    ERROR_RING2_STACK_IN_USE                                                       = 0x000000cfU,
    ERROR_META_EXPANSION_TOO_LONG                                                  = 0x000000d0U,
    ERROR_INVALID_SIGNAL_NUMBER                                                    = 0x000000d1U,
    ERROR_THREAD_1_INACTIVE                                                        = 0x000000d2U,
    ERROR_LOCKED                                                                   = 0x000000d4U,
    ERROR_TOO_MANY_MODULES                                                         = 0x000000d6U,
    ERROR_NESTING_NOT_ALLOWED                                                      = 0x000000d7U,
    ERROR_EXE_MACHINE_TYPE_MISMATCH                                                = 0x000000d8U,
    ERROR_EXE_CANNOT_MODIFY_SIGNED_BINARY                                          = 0x000000d9U,
    ERROR_EXE_CANNOT_MODIFY_STRONG_SIGNED_BINARY                                   = 0x000000daU,
    ERROR_FILE_CHECKED_OUT                                                         = 0x000000dcU,
    ERROR_CHECKOUT_REQUIRED                                                        = 0x000000ddU,
    ERROR_BAD_FILE_TYPE                                                            = 0x000000deU,
    ERROR_FILE_TOO_LARGE                                                           = 0x000000dfU,
    ERROR_FORMS_AUTH_REQUIRED                                                      = 0x000000e0U,
    ERROR_VIRUS_INFECTED                                                           = 0x000000e1U,
    ERROR_VIRUS_DELETED                                                            = 0x000000e2U,
    ERROR_PIPE_LOCAL                                                               = 0x000000e5U,
    ERROR_BAD_PIPE                                                                 = 0x000000e6U,
    ERROR_PIPE_BUSY                                                                = 0x000000e7U,
    ERROR_NO_DATA                                                                  = 0x000000e8U,
    ERROR_PIPE_NOT_CONNECTED                                                       = 0x000000e9U,
    ERROR_MORE_DATA                                                                = 0x000000eaU,
    ERROR_NO_WORK_DONE                                                             = 0x000000ebU,
    ERROR_VC_DISCONNECTED                                                          = 0x000000f0U,
    ERROR_INVALID_EA_NAME                                                          = 0x000000feU,
    ERROR_EA_LIST_INCONSISTENT                                                     = 0x000000ffU,
    ERROR_NO_MORE_ITEMS                                                            = 0x00000103U,
    ERROR_CANNOT_COPY                                                              = 0x0000010aU,
    ERROR_DIRECTORY                                                                = 0x0000010bU,
    ERROR_EAS_DIDNT_FIT                                                            = 0x00000113U,
    ERROR_EA_FILE_CORRUPT                                                          = 0x00000114U,
    ERROR_EA_TABLE_FULL                                                            = 0x00000115U,
    ERROR_INVALID_EA_HANDLE                                                        = 0x00000116U,
    ERROR_EAS_NOT_SUPPORTED                                                        = 0x0000011aU,
    ERROR_NOT_OWNER                                                                = 0x00000120U,
    ERROR_TOO_MANY_POSTS                                                           = 0x0000012aU,
    ERROR_PARTIAL_COPY                                                             = 0x0000012bU,
    ERROR_OPLOCK_NOT_GRANTED                                                       = 0x0000012cU,
    ERROR_INVALID_OPLOCK_PROTOCOL                                                  = 0x0000012dU,
    ERROR_DISK_TOO_FRAGMENTED                                                      = 0x0000012eU,
    ERROR_DELETE_PENDING                                                           = 0x0000012fU,
    ERROR_INCOMPATIBLE_WITH_GLOBAL_SHORT_NAME_REGISTRY_SETTING                     = 0x00000130U,
    ERROR_SHORT_NAMES_NOT_ENABLED_ON_VOLUME                                        = 0x00000131U,
    ERROR_SECURITY_STREAM_IS_INCONSISTENT                                          = 0x00000132U,
    ERROR_INVALID_LOCK_RANGE                                                       = 0x00000133U,
    ERROR_IMAGE_SUBSYSTEM_NOT_PRESENT                                              = 0x00000134U,
    ERROR_NOTIFICATION_GUID_ALREADY_DEFINED                                        = 0x00000135U,
    ERROR_INVALID_EXCEPTION_HANDLER                                                = 0x00000136U,
    ERROR_DUPLICATE_PRIVILEGES                                                     = 0x00000137U,
    ERROR_NO_RANGES_PROCESSED                                                      = 0x00000138U,
    ERROR_NOT_ALLOWED_ON_SYSTEM_FILE                                               = 0x00000139U,
    ERROR_DISK_RESOURCES_EXHAUSTED                                                 = 0x0000013aU,
    ERROR_INVALID_TOKEN                                                            = 0x0000013bU,
    ERROR_DEVICE_FEATURE_NOT_SUPPORTED                                             = 0x0000013cU,
    ERROR_MR_MID_NOT_FOUND                                                         = 0x0000013dU,
    ERROR_SCOPE_NOT_FOUND                                                          = 0x0000013eU,
    ERROR_UNDEFINED_SCOPE                                                          = 0x0000013fU,
    ERROR_INVALID_CAP                                                              = 0x00000140U,
    ERROR_DEVICE_UNREACHABLE                                                       = 0x00000141U,
    ERROR_DEVICE_NO_RESOURCES                                                      = 0x00000142U,
    ERROR_DATA_CHECKSUM_ERROR                                                      = 0x00000143U,
    ERROR_INTERMIXED_KERNEL_EA_OPERATION                                           = 0x00000144U,
    ERROR_FILE_LEVEL_TRIM_NOT_SUPPORTED                                            = 0x00000146U,
    ERROR_OFFSET_ALIGNMENT_VIOLATION                                               = 0x00000147U,
    ERROR_INVALID_FIELD_IN_PARAMETER_LIST                                          = 0x00000148U,
    ERROR_OPERATION_IN_PROGRESS                                                    = 0x00000149U,
    ERROR_BAD_DEVICE_PATH                                                          = 0x0000014aU,
    ERROR_TOO_MANY_DESCRIPTORS                                                     = 0x0000014bU,
    ERROR_SCRUB_DATA_DISABLED                                                      = 0x0000014cU,
    ERROR_NOT_REDUNDANT_STORAGE                                                    = 0x0000014dU,
    ERROR_RESIDENT_FILE_NOT_SUPPORTED                                              = 0x0000014eU,
    ERROR_COMPRESSED_FILE_NOT_SUPPORTED                                            = 0x0000014fU,
    ERROR_DIRECTORY_NOT_SUPPORTED                                                  = 0x00000150U,
    ERROR_NOT_READ_FROM_COPY                                                       = 0x00000151U,
    ERROR_FT_WRITE_FAILURE                                                         = 0x00000152U,
    ERROR_FT_DI_SCAN_REQUIRED                                                      = 0x00000153U,
    ERROR_INVALID_KERNEL_INFO_VERSION                                              = 0x00000154U,
    ERROR_INVALID_PEP_INFO_VERSION                                                 = 0x00000155U,
    ERROR_OBJECT_NOT_EXTERNALLY_BACKED                                             = 0x00000156U,
    ERROR_EXTERNAL_BACKING_PROVIDER_UNKNOWN                                        = 0x00000157U,
    ERROR_COMPRESSION_NOT_BENEFICIAL                                               = 0x00000158U,
    ERROR_STORAGE_TOPOLOGY_ID_MISMATCH                                             = 0x00000159U,
    ERROR_BLOCKED_BY_PARENTAL_CONTROLS                                             = 0x0000015aU,
    ERROR_BLOCK_TOO_MANY_REFERENCES                                                = 0x0000015bU,
    ERROR_MARKED_TO_DISALLOW_WRITES                                                = 0x0000015cU,
    ERROR_ENCLAVE_FAILURE                                                          = 0x0000015dU,
    ERROR_FAIL_NOACTION_REBOOT                                                     = 0x0000015eU,
    ERROR_FAIL_SHUTDOWN                                                            = 0x0000015fU,
    ERROR_FAIL_RESTART                                                             = 0x00000160U,
    ERROR_MAX_SESSIONS_REACHED                                                     = 0x00000161U,
    ERROR_NETWORK_ACCESS_DENIED_EDP                                                = 0x00000162U,
    ERROR_DEVICE_HINT_NAME_BUFFER_TOO_SMALL                                        = 0x00000163U,
    ERROR_EDP_POLICY_DENIES_OPERATION                                              = 0x00000164U,
    ERROR_EDP_DPL_POLICY_CANT_BE_SATISFIED                                         = 0x00000165U,
    ERROR_CLOUD_FILE_SYNC_ROOT_METADATA_CORRUPT                                    = 0x00000166U,
    ERROR_DEVICE_IN_MAINTENANCE                                                    = 0x00000167U,
    ERROR_NOT_SUPPORTED_ON_DAX                                                     = 0x00000168U,
    ERROR_DAX_MAPPING_EXISTS                                                       = 0x00000169U,
    ERROR_CLOUD_FILE_PROVIDER_NOT_RUNNING                                          = 0x0000016aU,
    ERROR_CLOUD_FILE_METADATA_CORRUPT                                              = 0x0000016bU,
    ERROR_CLOUD_FILE_METADATA_TOO_LARGE                                            = 0x0000016cU,
    ERROR_CLOUD_FILE_PROPERTY_BLOB_TOO_LARGE                                       = 0x0000016dU,
    ERROR_CLOUD_FILE_PROPERTY_BLOB_CHECKSUM_MISMATCH                               = 0x0000016eU,
    ERROR_CHILD_PROCESS_BLOCKED                                                    = 0x0000016fU,
    ERROR_STORAGE_LOST_DATA_PERSISTENCE                                            = 0x00000170U,
    ERROR_FILE_SYSTEM_VIRTUALIZATION_UNAVAILABLE                                   = 0x00000171U,
    ERROR_FILE_SYSTEM_VIRTUALIZATION_METADATA_CORRUPT                              = 0x00000172U,
    ERROR_FILE_SYSTEM_VIRTUALIZATION_BUSY                                          = 0x00000173U,
    ERROR_FILE_SYSTEM_VIRTUALIZATION_PROVIDER_UNKNOWN                              = 0x00000174U,
    ERROR_GDI_HANDLE_LEAK                                                          = 0x00000175U,
    ERROR_CLOUD_FILE_TOO_MANY_PROPERTY_BLOBS                                       = 0x00000176U,
    ERROR_CLOUD_FILE_PROPERTY_VERSION_NOT_SUPPORTED                                = 0x00000177U,
    ERROR_NOT_A_CLOUD_FILE                                                         = 0x00000178U,
    ERROR_CLOUD_FILE_NOT_IN_SYNC                                                   = 0x00000179U,
    ERROR_CLOUD_FILE_ALREADY_CONNECTED                                             = 0x0000017aU,
    ERROR_CLOUD_FILE_NOT_SUPPORTED                                                 = 0x0000017bU,
    ERROR_CLOUD_FILE_INVALID_REQUEST                                               = 0x0000017cU,
    ERROR_CLOUD_FILE_READ_ONLY_VOLUME                                              = 0x0000017dU,
    ERROR_CLOUD_FILE_CONNECTED_PROVIDER_ONLY                                       = 0x0000017eU,
    ERROR_CLOUD_FILE_VALIDATION_FAILED                                             = 0x0000017fU,
    ERROR_SMB1_NOT_AVAILABLE                                                       = 0x00000180U,
    ERROR_FILE_SYSTEM_VIRTUALIZATION_INVALID_OPERATION                             = 0x00000181U,
    ERROR_CLOUD_FILE_AUTHENTICATION_FAILED                                         = 0x00000182U,
    ERROR_CLOUD_FILE_INSUFFICIENT_RESOURCES                                        = 0x00000183U,
    ERROR_CLOUD_FILE_NETWORK_UNAVAILABLE                                           = 0x00000184U,
    ERROR_CLOUD_FILE_UNSUCCESSFUL                                                  = 0x00000185U,
    ERROR_CLOUD_FILE_NOT_UNDER_SYNC_ROOT                                           = 0x00000186U,
    ERROR_CLOUD_FILE_IN_USE                                                        = 0x00000187U,
    ERROR_CLOUD_FILE_PINNED                                                        = 0x00000188U,
    ERROR_CLOUD_FILE_REQUEST_ABORTED                                               = 0x00000189U,
    ERROR_CLOUD_FILE_PROPERTY_CORRUPT                                              = 0x0000018aU,
    ERROR_CLOUD_FILE_ACCESS_DENIED                                                 = 0x0000018bU,
    ERROR_CLOUD_FILE_INCOMPATIBLE_HARDLINKS                                        = 0x0000018cU,
    ERROR_CLOUD_FILE_PROPERTY_LOCK_CONFLICT                                        = 0x0000018dU,
    ERROR_CLOUD_FILE_REQUEST_CANCELED                                              = 0x0000018eU,
    ERROR_EXTERNAL_SYSKEY_NOT_SUPPORTED                                            = 0x0000018fU,
    ERROR_THREAD_MODE_ALREADY_BACKGROUND                                           = 0x00000190U,
    ERROR_THREAD_MODE_NOT_BACKGROUND                                               = 0x00000191U,
    ERROR_PROCESS_MODE_ALREADY_BACKGROUND                                          = 0x00000192U,
    ERROR_PROCESS_MODE_NOT_BACKGROUND                                              = 0x00000193U,
    ERROR_CLOUD_FILE_PROVIDER_TERMINATED                                           = 0x00000194U,
    ERROR_NOT_A_CLOUD_SYNC_ROOT                                                    = 0x00000195U,
    ERROR_FILE_PROTECTED_UNDER_DPL                                                 = 0x00000196U,
    ERROR_VOLUME_NOT_CLUSTER_ALIGNED                                               = 0x00000197U,
    ERROR_NO_PHYSICALLY_ALIGNED_FREE_SPACE_FOUND                                   = 0x00000198U,
    ERROR_APPX_FILE_NOT_ENCRYPTED                                                  = 0x00000199U,
    ERROR_RWRAW_ENCRYPTED_FILE_NOT_ENCRYPTED                                       = 0x0000019aU,
    ERROR_RWRAW_ENCRYPTED_INVALID_EDATAINFO_FILEOFFSET                             = 0x0000019bU,
    ERROR_RWRAW_ENCRYPTED_INVALID_EDATAINFO_FILERANGE                              = 0x0000019cU,
    ERROR_RWRAW_ENCRYPTED_INVALID_EDATAINFO_PARAMETER                              = 0x0000019dU,
    ERROR_LINUX_SUBSYSTEM_NOT_PRESENT                                              = 0x0000019eU,
    ERROR_FT_READ_FAILURE                                                          = 0x0000019fU,
    ERROR_STORAGE_RESERVE_ID_INVALID                                               = 0x000001a0U,
    ERROR_STORAGE_RESERVE_DOES_NOT_EXIST                                           = 0x000001a1U,
    ERROR_STORAGE_RESERVE_ALREADY_EXISTS                                           = 0x000001a2U,
    ERROR_STORAGE_RESERVE_NOT_EMPTY                                                = 0x000001a3U,
    ERROR_NOT_A_DAX_VOLUME                                                         = 0x000001a4U,
    ERROR_NOT_DAX_MAPPABLE                                                         = 0x000001a5U,
    ERROR_TIME_SENSITIVE_THREAD                                                    = 0x000001a6U,
    ERROR_DPL_NOT_SUPPORTED_FOR_USER                                               = 0x000001a7U,
    ERROR_CASE_DIFFERING_NAMES_IN_DIR                                              = 0x000001a8U,
    ERROR_FILE_NOT_SUPPORTED                                                       = 0x000001a9U,
    ERROR_CLOUD_FILE_REQUEST_TIMEOUT                                               = 0x000001aaU,
    ERROR_NO_TASK_QUEUE                                                            = 0x000001abU,
    ERROR_SRC_SRV_DLL_LOAD_FAILED                                                  = 0x000001acU,
    ERROR_NOT_SUPPORTED_WITH_BTT                                                   = 0x000001adU,
    ERROR_ENCRYPTION_DISABLED                                                      = 0x000001aeU,
    ERROR_ENCRYPTING_METADATA_DISALLOWED                                           = 0x000001afU,
    ERROR_CANT_CLEAR_ENCRYPTION_FLAG                                               = 0x000001b0U,
    ERROR_NO_SUCH_DEVICE                                                           = 0x000001b1U,
    ERROR_CLOUD_FILE_DEHYDRATION_DISALLOWED                                        = 0x000001b2U,
    ERROR_FILE_SNAP_IN_PROGRESS                                                    = 0x000001b3U,
    ERROR_FILE_SNAP_USER_SECTION_NOT_SUPPORTED                                     = 0x000001b4U,
    ERROR_FILE_SNAP_MODIFY_NOT_SUPPORTED                                           = 0x000001b5U,
    ERROR_FILE_SNAP_IO_NOT_COORDINATED                                             = 0x000001b6U,
    ERROR_FILE_SNAP_UNEXPECTED_ERROR                                               = 0x000001b7U,
    ERROR_FILE_SNAP_INVALID_PARAMETER                                              = 0x000001b8U,
    ERROR_UNSATISFIED_DEPENDENCIES                                                 = 0x000001b9U,
    ERROR_CASE_SENSITIVE_PATH                                                      = 0x000001baU,
    ERROR_UNEXPECTED_NTCACHEMANAGER_ERROR                                          = 0x000001bbU,
    ERROR_LINUX_SUBSYSTEM_UPDATE_REQUIRED                                          = 0x000001bcU,
    ERROR_DLP_POLICY_WARNS_AGAINST_OPERATION                                       = 0x000001bdU,
    ERROR_DLP_POLICY_DENIES_OPERATION                                              = 0x000001beU,
    ERROR_SECURITY_DENIES_OPERATION                                                = 0x000001bfU,
    ERROR_UNTRUSTED_MOUNT_POINT                                                    = 0x000001c0U,
    ERROR_DLP_POLICY_SILENTLY_FAIL                                                 = 0x000001c1U,
    ERROR_CAPAUTHZ_NOT_DEVUNLOCKED                                                 = 0x000001c2U,
    ERROR_CAPAUTHZ_CHANGE_TYPE                                                     = 0x000001c3U,
    ERROR_CAPAUTHZ_NOT_PROVISIONED                                                 = 0x000001c4U,
    ERROR_CAPAUTHZ_NOT_AUTHORIZED                                                  = 0x000001c5U,
    ERROR_CAPAUTHZ_NO_POLICY                                                       = 0x000001c6U,
    ERROR_CAPAUTHZ_DB_CORRUPTED                                                    = 0x000001c7U,
    ERROR_CAPAUTHZ_SCCD_INVALID_CATALOG                                            = 0x000001c8U,
    ERROR_CAPAUTHZ_SCCD_NO_AUTH_ENTITY                                             = 0x000001c9U,
    ERROR_CAPAUTHZ_SCCD_PARSE_ERROR                                                = 0x000001caU,
    ERROR_CAPAUTHZ_SCCD_DEV_MODE_REQUIRED                                          = 0x000001cbU,
    ERROR_CAPAUTHZ_SCCD_NO_CAPABILITY_MATCH                                        = 0x000001ccU,
    ERROR_CIMFS_IMAGE_CORRUPT                                                      = 0x000001d6U,
    ERROR_CIMFS_IMAGE_VERSION_NOT_SUPPORTED                                        = 0x000001d7U,
    ERROR_STORAGE_STACK_ACCESS_DENIED                                              = 0x000001d8U,
    ERROR_INSUFFICIENT_VIRTUAL_ADDR_RESOURCES                                      = 0x000001d9U,
    ERROR_INDEX_OUT_OF_BOUNDS                                                      = 0x000001daU,
    ERROR_CLOUD_FILE_US_MESSAGE_TIMEOUT                                            = 0x000001dbU,
    ERROR_NOT_A_DEV_VOLUME                                                         = 0x000001dcU,
    ERROR_FS_GUID_MISMATCH                                                         = 0x000001ddU,
    ERROR_CANT_ATTACH_TO_DEV_VOLUME                                                = 0x000001deU,
    ERROR_MEMORY_DECOMPRESSION_FAILURE                                             = 0x000001dfU,
    ERROR_PNP_QUERY_REMOVE_DEVICE_TIMEOUT                                          = 0x000001e0U,
    ERROR_PNP_QUERY_REMOVE_RELATED_DEVICE_TIMEOUT                                  = 0x000001e1U,
    ERROR_PNP_QUERY_REMOVE_UNRELATED_DEVICE_TIMEOUT                                = 0x000001e2U,
    ERROR_DEVICE_HARDWARE_ERROR                                                    = 0x000001e3U,
    ERROR_INVALID_ADDRESS                                                          = 0x000001e7U,
    ERROR_HAS_SYSTEM_CRITICAL_FILES                                                = 0x000001e8U,
    ERROR_ENCRYPTED_FILE_NOT_SUPPORTED                                             = 0x000001e9U,
    ERROR_SPARSE_FILE_NOT_SUPPORTED                                                = 0x000001eaU,
    ERROR_PAGEFILE_NOT_SUPPORTED                                                   = 0x000001ebU,
    ERROR_VOLUME_NOT_SUPPORTED                                                     = 0x000001ecU,
    ERROR_NOT_SUPPORTED_WITH_BYPASSIO                                              = 0x000001edU,
    ERROR_NO_BYPASSIO_DRIVER_SUPPORT                                               = 0x000001eeU,
    ERROR_NOT_SUPPORTED_WITH_ENCRYPTION                                            = 0x000001efU,
    ERROR_NOT_SUPPORTED_WITH_COMPRESSION                                           = 0x000001f0U,
    ERROR_NOT_SUPPORTED_WITH_REPLICATION                                           = 0x000001f1U,
    ERROR_NOT_SUPPORTED_WITH_DEDUPLICATION                                         = 0x000001f2U,
    ERROR_NOT_SUPPORTED_WITH_AUDITING                                              = 0x000001f3U,
    ERROR_USER_PROFILE_LOAD                                                        = 0x000001f4U,
    ERROR_SESSION_KEY_TOO_SHORT                                                    = 0x000001f5U,
    ERROR_ACCESS_DENIED_APPDATA                                                    = 0x000001f6U,
    ERROR_NOT_SUPPORTED_WITH_MONITORING                                            = 0x000001f7U,
    ERROR_NOT_SUPPORTED_WITH_SNAPSHOT                                              = 0x000001f8U,
    ERROR_NOT_SUPPORTED_WITH_VIRTUALIZATION                                        = 0x000001f9U,
    ERROR_BYPASSIO_FLT_NOT_SUPPORTED                                               = 0x000001faU,
    ERROR_DEVICE_RESET_REQUIRED                                                    = 0x000001fbU,
    ERROR_VOLUME_WRITE_ACCESS_DENIED                                               = 0x000001fcU,
    ERROR_NOT_SUPPORTED_WITH_CACHED_HANDLE                                         = 0x000001fdU,
    ERROR_FS_METADATA_INCONSISTENT                                                 = 0x000001feU,
    ERROR_BLOCK_WEAK_REFERENCE_INVALID                                             = 0x000001ffU,
    ERROR_BLOCK_SOURCE_WEAK_REFERENCE_INVALID                                      = 0x00000200U,
    ERROR_BLOCK_TARGET_WEAK_REFERENCE_INVALID                                      = 0x00000201U,
    ERROR_BLOCK_SHARED                                                             = 0x00000202U,
    ERROR_VOLUME_UPGRADE_NOT_NEEDED                                                = 0x00000203U,
    ERROR_VOLUME_UPGRADE_PENDING                                                   = 0x00000204U,
    ERROR_VOLUME_UPGRADE_DISABLED                                                  = 0x00000205U,
    ERROR_VOLUME_UPGRADE_DISABLED_TILL_OS_DOWNGRADE_EXPIRED                        = 0x00000206U,
    ERROR_INVALID_CONFIG_VALUE                                                     = 0x00000207U,
    ERROR_MEMORY_DECOMPRESSION_HW_ERROR                                            = 0x00000208U,
    ERROR_VOLUME_ROLLBACK_DETECTED                                                 = 0x00000209U,
    ERROR_CLOUD_FILE_HYDRATION_NOT_AVAILABLE                                       = 0x0000020bU,
    ERROR_SYSTEM_FILE_NOT_SUPPORTED                                                = 0x0000020dU,
    ERROR_ARITHMETIC_OVERFLOW                                                      = 0x00000216U,
    ERROR_PIPE_CONNECTED                                                           = 0x00000217U,
    ERROR_PIPE_LISTENING                                                           = 0x00000218U,
    ERROR_VERIFIER_STOP                                                            = 0x00000219U,
    ERROR_ABIOS_ERROR                                                              = 0x0000021aU,
    ERROR_WX86_WARNING                                                             = 0x0000021bU,
    ERROR_WX86_ERROR                                                               = 0x0000021cU,
    ERROR_TIMER_NOT_CANCELED                                                       = 0x0000021dU,
    ERROR_UNWIND                                                                   = 0x0000021eU,
    ERROR_BAD_STACK                                                                = 0x0000021fU,
    ERROR_INVALID_UNWIND_TARGET                                                    = 0x00000220U,
    ERROR_INVALID_PORT_ATTRIBUTES                                                  = 0x00000221U,
    ERROR_PORT_MESSAGE_TOO_LONG                                                    = 0x00000222U,
    ERROR_INVALID_QUOTA_LOWER                                                      = 0x00000223U,
    ERROR_DEVICE_ALREADY_ATTACHED                                                  = 0x00000224U,
    ERROR_INSTRUCTION_MISALIGNMENT                                                 = 0x00000225U,
    ERROR_PROFILING_NOT_STARTED                                                    = 0x00000226U,
    ERROR_PROFILING_NOT_STOPPED                                                    = 0x00000227U,
    ERROR_COULD_NOT_INTERPRET                                                      = 0x00000228U,
    ERROR_PROFILING_AT_LIMIT                                                       = 0x00000229U,
    ERROR_CANT_WAIT                                                                = 0x0000022aU,
    ERROR_CANT_TERMINATE_SELF                                                      = 0x0000022bU,
    ERROR_UNEXPECTED_MM_CREATE_ERR                                                 = 0x0000022cU,
    ERROR_UNEXPECTED_MM_MAP_ERROR                                                  = 0x0000022dU,
    ERROR_UNEXPECTED_MM_EXTEND_ERR                                                 = 0x0000022eU,
    ERROR_BAD_FUNCTION_TABLE                                                       = 0x0000022fU,
    ERROR_NO_GUID_TRANSLATION                                                      = 0x00000230U,
    ERROR_INVALID_LDT_SIZE                                                         = 0x00000231U,
    ERROR_INVALID_LDT_OFFSET                                                       = 0x00000233U,
    ERROR_INVALID_LDT_DESCRIPTOR                                                   = 0x00000234U,
    ERROR_TOO_MANY_THREADS                                                         = 0x00000235U,
    ERROR_THREAD_NOT_IN_PROCESS                                                    = 0x00000236U,
    ERROR_PAGEFILE_QUOTA_EXCEEDED                                                  = 0x00000237U,
    ERROR_LOGON_SERVER_CONFLICT                                                    = 0x00000238U,
    ERROR_SYNCHRONIZATION_REQUIRED                                                 = 0x00000239U,
    ERROR_NET_OPEN_FAILED                                                          = 0x0000023aU,
    ERROR_IO_PRIVILEGE_FAILED                                                      = 0x0000023bU,
    ERROR_CONTROL_C_EXIT                                                           = 0x0000023cU,
    ERROR_MISSING_SYSTEMFILE                                                       = 0x0000023dU,
    ERROR_UNHANDLED_EXCEPTION                                                      = 0x0000023eU,
    ERROR_APP_INIT_FAILURE                                                         = 0x0000023fU,
    ERROR_PAGEFILE_CREATE_FAILED                                                   = 0x00000240U,
    ERROR_INVALID_IMAGE_HASH                                                       = 0x00000241U,
    ERROR_NO_PAGEFILE                                                              = 0x00000242U,
    ERROR_ILLEGAL_FLOAT_CONTEXT                                                    = 0x00000243U,
    ERROR_NO_EVENT_PAIR                                                            = 0x00000244U,
    ERROR_DOMAIN_CTRLR_CONFIG_ERROR                                                = 0x00000245U,
    ERROR_ILLEGAL_CHARACTER                                                        = 0x00000246U,
    ERROR_UNDEFINED_CHARACTER                                                      = 0x00000247U,
    ERROR_FLOPPY_VOLUME                                                            = 0x00000248U,
    ERROR_BIOS_FAILED_TO_CONNECT_INTERRUPT                                         = 0x00000249U,
    ERROR_BACKUP_CONTROLLER                                                        = 0x0000024aU,
    ERROR_MUTANT_LIMIT_EXCEEDED                                                    = 0x0000024bU,
    ERROR_FS_DRIVER_REQUIRED                                                       = 0x0000024cU,
    ERROR_CANNOT_LOAD_REGISTRY_FILE                                                = 0x0000024dU,
    ERROR_DEBUG_ATTACH_FAILED                                                      = 0x0000024eU,
    ERROR_SYSTEM_PROCESS_TERMINATED                                                = 0x0000024fU,
    ERROR_DATA_NOT_ACCEPTED                                                        = 0x00000250U,
    ERROR_VDM_HARD_ERROR                                                           = 0x00000251U,
    ERROR_DRIVER_CANCEL_TIMEOUT                                                    = 0x00000252U,
    ERROR_REPLY_MESSAGE_MISMATCH                                                   = 0x00000253U,
    ERROR_LOST_WRITEBEHIND_DATA                                                    = 0x00000254U,
    ERROR_CLIENT_SERVER_PARAMETERS_INVALID                                         = 0x00000255U,
    ERROR_NOT_TINY_STREAM                                                          = 0x00000256U,
    ERROR_STACK_OVERFLOW_READ                                                      = 0x00000257U,
    ERROR_CONVERT_TO_LARGE                                                         = 0x00000258U,
    ERROR_FOUND_OUT_OF_SCOPE                                                       = 0x00000259U,
    ERROR_ALLOCATE_BUCKET                                                          = 0x0000025aU,
    ERROR_MARSHALL_OVERFLOW                                                        = 0x0000025bU,
    ERROR_INVALID_VARIANT                                                          = 0x0000025cU,
    ERROR_BAD_COMPRESSION_BUFFER                                                   = 0x0000025dU,
    ERROR_AUDIT_FAILED                                                             = 0x0000025eU,
    ERROR_TIMER_RESOLUTION_NOT_SET                                                 = 0x0000025fU,
    ERROR_INSUFFICIENT_LOGON_INFO                                                  = 0x00000260U,
    ERROR_BAD_DLL_ENTRYPOINT                                                       = 0x00000261U,
    ERROR_BAD_SERVICE_ENTRYPOINT                                                   = 0x00000262U,
    ERROR_IP_ADDRESS_CONFLICT1                                                     = 0x00000263U,
    ERROR_IP_ADDRESS_CONFLICT2                                                     = 0x00000264U,
    ERROR_REGISTRY_QUOTA_LIMIT                                                     = 0x00000265U,
    ERROR_NO_CALLBACK_ACTIVE                                                       = 0x00000266U,
    ERROR_PWD_TOO_SHORT                                                            = 0x00000267U,
    ERROR_PWD_TOO_RECENT                                                           = 0x00000268U,
    ERROR_PWD_HISTORY_CONFLICT                                                     = 0x00000269U,
    ERROR_UNSUPPORTED_COMPRESSION                                                  = 0x0000026aU,
    ERROR_INVALID_HW_PROFILE                                                       = 0x0000026bU,
    ERROR_INVALID_PLUGPLAY_DEVICE_PATH                                             = 0x0000026cU,
    ERROR_QUOTA_LIST_INCONSISTENT                                                  = 0x0000026dU,
    ERROR_EVALUATION_EXPIRATION                                                    = 0x0000026eU,
    ERROR_ILLEGAL_DLL_RELOCATION                                                   = 0x0000026fU,
    ERROR_DLL_INIT_FAILED_LOGOFF                                                   = 0x00000270U,
    ERROR_VALIDATE_CONTINUE                                                        = 0x00000271U,
    ERROR_NO_MORE_MATCHES                                                          = 0x00000272U,
    ERROR_RANGE_LIST_CONFLICT                                                      = 0x00000273U,
    ERROR_SERVER_SID_MISMATCH                                                      = 0x00000274U,
    ERROR_CANT_ENABLE_DENY_ONLY                                                    = 0x00000275U,
    ERROR_FLOAT_MULTIPLE_FAULTS                                                    = 0x00000276U,
    ERROR_FLOAT_MULTIPLE_TRAPS                                                     = 0x00000277U,
    ERROR_NOINTERFACE                                                              = 0x00000278U,
    ERROR_DRIVER_FAILED_SLEEP                                                      = 0x00000279U,
    ERROR_CORRUPT_SYSTEM_FILE                                                      = 0x0000027aU,
    ERROR_COMMITMENT_MINIMUM                                                       = 0x0000027bU,
    ERROR_PNP_RESTART_ENUMERATION                                                  = 0x0000027cU,
    ERROR_SYSTEM_IMAGE_BAD_SIGNATURE                                               = 0x0000027dU,
    ERROR_PNP_REBOOT_REQUIRED                                                      = 0x0000027eU,
    ERROR_INSUFFICIENT_POWER                                                       = 0x0000027fU,
    ERROR_MULTIPLE_FAULT_VIOLATION                                                 = 0x00000280U,
    ERROR_SYSTEM_SHUTDOWN                                                          = 0x00000281U,
    ERROR_PORT_NOT_SET                                                             = 0x00000282U,
    ERROR_DS_VERSION_CHECK_FAILURE                                                 = 0x00000283U,
    ERROR_RANGE_NOT_FOUND                                                          = 0x00000284U,
    ERROR_NOT_SAFE_MODE_DRIVER                                                     = 0x00000286U,
    ERROR_FAILED_DRIVER_ENTRY                                                      = 0x00000287U,
    ERROR_DEVICE_ENUMERATION_ERROR                                                 = 0x00000288U,
    ERROR_MOUNT_POINT_NOT_RESOLVED                                                 = 0x00000289U,
    ERROR_INVALID_DEVICE_OBJECT_PARAMETER                                          = 0x0000028aU,
    ERROR_MCA_OCCURED                                                              = 0x0000028bU,
    ERROR_DRIVER_DATABASE_ERROR                                                    = 0x0000028cU,
    ERROR_SYSTEM_HIVE_TOO_LARGE                                                    = 0x0000028dU,
    ERROR_DRIVER_FAILED_PRIOR_UNLOAD                                               = 0x0000028eU,
    ERROR_VOLSNAP_PREPARE_HIBERNATE                                                = 0x0000028fU,
    ERROR_HIBERNATION_FAILURE                                                      = 0x00000290U,
    ERROR_PWD_TOO_LONG                                                             = 0x00000291U,
    ERROR_FILE_SYSTEM_LIMITATION                                                   = 0x00000299U,
    ERROR_ASSERTION_FAILURE                                                        = 0x0000029cU,
    ERROR_ACPI_ERROR                                                               = 0x0000029dU,
    ERROR_WOW_ASSERTION                                                            = 0x0000029eU,
    ERROR_PNP_BAD_MPS_TABLE                                                        = 0x0000029fU,
    ERROR_PNP_TRANSLATION_FAILED                                                   = 0x000002a0U,
    ERROR_PNP_IRQ_TRANSLATION_FAILED                                               = 0x000002a1U,
    ERROR_PNP_INVALID_ID                                                           = 0x000002a2U,
    ERROR_WAKE_SYSTEM_DEBUGGER                                                     = 0x000002a3U,
    ERROR_HANDLES_CLOSED                                                           = 0x000002a4U,
    ERROR_EXTRANEOUS_INFORMATION                                                   = 0x000002a5U,
    ERROR_RXACT_COMMIT_NECESSARY                                                   = 0x000002a6U,
    ERROR_MEDIA_CHECK                                                              = 0x000002a7U,
    ERROR_GUID_SUBSTITUTION_MADE                                                   = 0x000002a8U,
    ERROR_STOPPED_ON_SYMLINK                                                       = 0x000002a9U,
    ERROR_LONGJUMP                                                                 = 0x000002aaU,
    ERROR_PLUGPLAY_QUERY_VETOED                                                    = 0x000002abU,
    ERROR_UNWIND_CONSOLIDATE                                                       = 0x000002acU,
    ERROR_REGISTRY_HIVE_RECOVERED                                                  = 0x000002adU,
    ERROR_DLL_MIGHT_BE_INSECURE                                                    = 0x000002aeU,
    ERROR_DLL_MIGHT_BE_INCOMPATIBLE                                                = 0x000002afU,
    ERROR_DBG_EXCEPTION_NOT_HANDLED                                                = 0x000002b0U,
    ERROR_DBG_REPLY_LATER                                                          = 0x000002b1U,
    ERROR_DBG_UNABLE_TO_PROVIDE_HANDLE                                             = 0x000002b2U,
    ERROR_DBG_TERMINATE_THREAD                                                     = 0x000002b3U,
    ERROR_DBG_TERMINATE_PROCESS                                                    = 0x000002b4U,
    ERROR_DBG_CONTROL_C                                                            = 0x000002b5U,
    ERROR_DBG_PRINTEXCEPTION_C                                                     = 0x000002b6U,
    ERROR_DBG_RIPEXCEPTION                                                         = 0x000002b7U,
    ERROR_DBG_CONTROL_BREAK                                                        = 0x000002b8U,
    ERROR_DBG_COMMAND_EXCEPTION                                                    = 0x000002b9U,
    ERROR_OBJECT_NAME_EXISTS                                                       = 0x000002baU,
    ERROR_THREAD_WAS_SUSPENDED                                                     = 0x000002bbU,
    ERROR_IMAGE_NOT_AT_BASE                                                        = 0x000002bcU,
    ERROR_RXACT_STATE_CREATED                                                      = 0x000002bdU,
    ERROR_SEGMENT_NOTIFICATION                                                     = 0x000002beU,
    ERROR_BAD_CURRENT_DIRECTORY                                                    = 0x000002bfU,
    ERROR_FT_READ_RECOVERY_FROM_BACKUP                                             = 0x000002c0U,
    ERROR_FT_WRITE_RECOVERY                                                        = 0x000002c1U,
    ERROR_IMAGE_MACHINE_TYPE_MISMATCH                                              = 0x000002c2U,
    ERROR_RECEIVE_PARTIAL                                                          = 0x000002c3U,
    ERROR_RECEIVE_EXPEDITED                                                        = 0x000002c4U,
    ERROR_RECEIVE_PARTIAL_EXPEDITED                                                = 0x000002c5U,
    ERROR_EVENT_DONE                                                               = 0x000002c6U,
    ERROR_EVENT_PENDING                                                            = 0x000002c7U,
    ERROR_CHECKING_FILE_SYSTEM                                                     = 0x000002c8U,
    ERROR_FATAL_APP_EXIT                                                           = 0x000002c9U,
    ERROR_PREDEFINED_HANDLE                                                        = 0x000002caU,
    ERROR_WAS_UNLOCKED                                                             = 0x000002cbU,
    ERROR_SERVICE_NOTIFICATION                                                     = 0x000002ccU,
    ERROR_WAS_LOCKED                                                               = 0x000002cdU,
    ERROR_LOG_HARD_ERROR                                                           = 0x000002ceU,
    ERROR_ALREADY_WIN32                                                            = 0x000002cfU,
    ERROR_IMAGE_MACHINE_TYPE_MISMATCH_EXE                                          = 0x000002d0U,
    ERROR_NO_YIELD_PERFORMED                                                       = 0x000002d1U,
    ERROR_TIMER_RESUME_IGNORED                                                     = 0x000002d2U,
    ERROR_ARBITRATION_UNHANDLED                                                    = 0x000002d3U,
    ERROR_CARDBUS_NOT_SUPPORTED                                                    = 0x000002d4U,
    ERROR_MP_PROCESSOR_MISMATCH                                                    = 0x000002d5U,
    ERROR_HIBERNATED                                                               = 0x000002d6U,
    ERROR_RESUME_HIBERNATION                                                       = 0x000002d7U,
    ERROR_FIRMWARE_UPDATED                                                         = 0x000002d8U,
    ERROR_DRIVERS_LEAKING_LOCKED_PAGES                                             = 0x000002d9U,
    ERROR_WAKE_SYSTEM                                                              = 0x000002daU,
    ERROR_WAIT_1                                                                   = 0x000002dbU,
    ERROR_WAIT_2                                                                   = 0x000002dcU,
    ERROR_WAIT_3                                                                   = 0x000002ddU,
    ERROR_WAIT_63                                                                  = 0x000002deU,
    ERROR_ABANDONED_WAIT_0                                                         = 0x000002dfU,
    ERROR_ABANDONED_WAIT_63                                                        = 0x000002e0U,
    ERROR_USER_APC                                                                 = 0x000002e1U,
    ERROR_KERNEL_APC                                                               = 0x000002e2U,
    ERROR_ALERTED                                                                  = 0x000002e3U,
    ERROR_ELEVATION_REQUIRED                                                       = 0x000002e4U,
    ERROR_REPARSE                                                                  = 0x000002e5U,
    ERROR_OPLOCK_BREAK_IN_PROGRESS                                                 = 0x000002e6U,
    ERROR_VOLUME_MOUNTED                                                           = 0x000002e7U,
    ERROR_RXACT_COMMITTED                                                          = 0x000002e8U,
    ERROR_NOTIFY_CLEANUP                                                           = 0x000002e9U,
    ERROR_PRIMARY_TRANSPORT_CONNECT_FAILED                                         = 0x000002eaU,
    ERROR_PAGE_FAULT_TRANSITION                                                    = 0x000002ebU,
    ERROR_PAGE_FAULT_DEMAND_ZERO                                                   = 0x000002ecU,
    ERROR_PAGE_FAULT_COPY_ON_WRITE                                                 = 0x000002edU,
    ERROR_PAGE_FAULT_GUARD_PAGE                                                    = 0x000002eeU,
    ERROR_PAGE_FAULT_PAGING_FILE                                                   = 0x000002efU,
    ERROR_CACHE_PAGE_LOCKED                                                        = 0x000002f0U,
    ERROR_CRASH_DUMP                                                               = 0x000002f1U,
    ERROR_BUFFER_ALL_ZEROS                                                         = 0x000002f2U,
    ERROR_REPARSE_OBJECT                                                           = 0x000002f3U,
    ERROR_RESOURCE_REQUIREMENTS_CHANGED                                            = 0x000002f4U,
    ERROR_TRANSLATION_COMPLETE                                                     = 0x000002f5U,
    ERROR_NOTHING_TO_TERMINATE                                                     = 0x000002f6U,
    ERROR_PROCESS_NOT_IN_JOB                                                       = 0x000002f7U,
    ERROR_PROCESS_IN_JOB                                                           = 0x000002f8U,
    ERROR_VOLSNAP_HIBERNATE_READY                                                  = 0x000002f9U,
    ERROR_FSFILTER_OP_COMPLETED_SUCCESSFULLY                                       = 0x000002faU,
    ERROR_INTERRUPT_VECTOR_ALREADY_CONNECTED                                       = 0x000002fbU,
    ERROR_INTERRUPT_STILL_CONNECTED                                                = 0x000002fcU,
    ERROR_WAIT_FOR_OPLOCK                                                          = 0x000002fdU,
    ERROR_DBG_EXCEPTION_HANDLED                                                    = 0x000002feU,
    ERROR_DBG_CONTINUE                                                             = 0x000002ffU,
    ERROR_CALLBACK_POP_STACK                                                       = 0x00000300U,
    ERROR_COMPRESSION_DISABLED                                                     = 0x00000301U,
    ERROR_CANTFETCHBACKWARDS                                                       = 0x00000302U,
    ERROR_CANTSCROLLBACKWARDS                                                      = 0x00000303U,
    ERROR_ROWSNOTRELEASED                                                          = 0x00000304U,
    ERROR_BAD_ACCESSOR_FLAGS                                                       = 0x00000305U,
    ERROR_ERRORS_ENCOUNTERED                                                       = 0x00000306U,
    ERROR_NOT_CAPABLE                                                              = 0x00000307U,
    ERROR_REQUEST_OUT_OF_SEQUENCE                                                  = 0x00000308U,
    ERROR_VERSION_PARSE_ERROR                                                      = 0x00000309U,
    ERROR_BADSTARTPOSITION                                                         = 0x0000030aU,
    ERROR_MEMORY_HARDWARE                                                          = 0x0000030bU,
    ERROR_DISK_REPAIR_DISABLED                                                     = 0x0000030cU,
    ERROR_INSUFFICIENT_RESOURCE_FOR_SPECIFIED_SHARED_SECTION_SIZE                  = 0x0000030dU,
    ERROR_SYSTEM_POWERSTATE_TRANSITION                                             = 0x0000030eU,
    ERROR_SYSTEM_POWERSTATE_COMPLEX_TRANSITION                                     = 0x0000030fU,
    ERROR_MCA_EXCEPTION                                                            = 0x00000310U,
    ERROR_ACCESS_AUDIT_BY_POLICY                                                   = 0x00000311U,
    ERROR_ACCESS_DISABLED_NO_SAFER_UI_BY_POLICY                                    = 0x00000312U,
    ERROR_ABANDON_HIBERFILE                                                        = 0x00000313U,
    ERROR_LOST_WRITEBEHIND_DATA_NETWORK_DISCONNECTED                               = 0x00000314U,
    ERROR_LOST_WRITEBEHIND_DATA_NETWORK_SERVER_ERROR                               = 0x00000315U,
    ERROR_LOST_WRITEBEHIND_DATA_LOCAL_DISK_ERROR                                   = 0x00000316U,
    ERROR_BAD_MCFG_TABLE                                                           = 0x00000317U,
    ERROR_DISK_REPAIR_REDIRECTED                                                   = 0x00000318U,
    ERROR_DISK_REPAIR_UNSUCCESSFUL                                                 = 0x00000319U,
    ERROR_CORRUPT_LOG_OVERFULL                                                     = 0x0000031aU,
    ERROR_CORRUPT_LOG_CORRUPTED                                                    = 0x0000031bU,
    ERROR_CORRUPT_LOG_UNAVAILABLE                                                  = 0x0000031cU,
    ERROR_CORRUPT_LOG_DELETED_FULL                                                 = 0x0000031dU,
    ERROR_CORRUPT_LOG_CLEARED                                                      = 0x0000031eU,
    ERROR_ORPHAN_NAME_EXHAUSTED                                                    = 0x0000031fU,
    ERROR_OPLOCK_SWITCHED_TO_NEW_HANDLE                                            = 0x00000320U,
    ERROR_CANNOT_GRANT_REQUESTED_OPLOCK                                            = 0x00000321U,
    ERROR_CANNOT_BREAK_OPLOCK                                                      = 0x00000322U,
    ERROR_OPLOCK_HANDLE_CLOSED                                                     = 0x00000323U,
    ERROR_NO_ACE_CONDITION                                                         = 0x00000324U,
    ERROR_INVALID_ACE_CONDITION                                                    = 0x00000325U,
    ERROR_FILE_HANDLE_REVOKED                                                      = 0x00000326U,
    ERROR_IMAGE_AT_DIFFERENT_BASE                                                  = 0x00000327U,
    ERROR_ENCRYPTED_IO_NOT_POSSIBLE                                                = 0x00000328U,
    ERROR_FILE_METADATA_OPTIMIZATION_IN_PROGRESS                                   = 0x00000329U,
    ERROR_QUOTA_ACTIVITY                                                           = 0x0000032aU,
    ERROR_HANDLE_REVOKED                                                           = 0x0000032bU,
    ERROR_CALLBACK_INVOKE_INLINE                                                   = 0x0000032cU,
    ERROR_CPU_SET_INVALID                                                          = 0x0000032dU,
    ERROR_ENCLAVE_NOT_TERMINATED                                                   = 0x0000032eU,
    ERROR_ENCLAVE_VIOLATION                                                        = 0x0000032fU,
    ERROR_SERVER_TRANSPORT_CONFLICT                                                = 0x00000330U,
    ERROR_CERTIFICATE_VALIDATION_PREFERENCE_CONFLICT                               = 0x00000331U,
    ERROR_FT_READ_FROM_COPY_FAILURE                                                = 0x00000332U,
    ERROR_SECTION_DIRECT_MAP_ONLY                                                  = 0x00000333U,
    ERROR_EA_ACCESS_DENIED                                                         = 0x000003e2U,
    ERROR_OPERATION_ABORTED                                                        = 0x000003e3U,
    ERROR_IO_INCOMPLETE                                                            = 0x000003e4U,
    ERROR_IO_PENDING                                                               = 0x000003e5U,
    ERROR_NOACCESS                                                                 = 0x000003e6U,
    ERROR_SWAPERROR                                                                = 0x000003e7U,
    ERROR_STACK_OVERFLOW                                                           = 0x000003e9U,
    ERROR_INVALID_MESSAGE                                                          = 0x000003eaU,
    ERROR_CAN_NOT_COMPLETE                                                         = 0x000003ebU,
    ERROR_INVALID_FLAGS                                                            = 0x000003ecU,
    ERROR_UNRECOGNIZED_VOLUME                                                      = 0x000003edU,
    ERROR_FILE_INVALID                                                             = 0x000003eeU,
    ERROR_FULLSCREEN_MODE                                                          = 0x000003efU,
    ERROR_NO_TOKEN                                                                 = 0x000003f0U,
    ERROR_BADDB                                                                    = 0x000003f1U,
    ERROR_BADKEY                                                                   = 0x000003f2U,
    ERROR_CANTOPEN                                                                 = 0x000003f3U,
    ERROR_CANTREAD                                                                 = 0x000003f4U,
    ERROR_CANTWRITE                                                                = 0x000003f5U,
    ERROR_REGISTRY_RECOVERED                                                       = 0x000003f6U,
    ERROR_REGISTRY_CORRUPT                                                         = 0x000003f7U,
    ERROR_REGISTRY_IO_FAILED                                                       = 0x000003f8U,
    ERROR_NOT_REGISTRY_FILE                                                        = 0x000003f9U,
    ERROR_KEY_DELETED                                                              = 0x000003faU,
    ERROR_NO_LOG_SPACE                                                             = 0x000003fbU,
    ERROR_KEY_HAS_CHILDREN                                                         = 0x000003fcU,
    ERROR_CHILD_MUST_BE_VOLATILE                                                   = 0x000003fdU,
    ERROR_NOTIFY_ENUM_DIR                                                          = 0x000003feU,
    ERROR_DEPENDENT_SERVICES_RUNNING                                               = 0x0000041bU,
    ERROR_INVALID_SERVICE_CONTROL                                                  = 0x0000041cU,
    ERROR_SERVICE_REQUEST_TIMEOUT                                                  = 0x0000041dU,
    ERROR_SERVICE_NO_THREAD                                                        = 0x0000041eU,
    ERROR_SERVICE_DATABASE_LOCKED                                                  = 0x0000041fU,
    ERROR_SERVICE_ALREADY_RUNNING                                                  = 0x00000420U,
    ERROR_INVALID_SERVICE_ACCOUNT                                                  = 0x00000421U,
    ERROR_SERVICE_DISABLED                                                         = 0x00000422U,
    ERROR_CIRCULAR_DEPENDENCY                                                      = 0x00000423U,
    ERROR_SERVICE_DOES_NOT_EXIST                                                   = 0x00000424U,
    ERROR_SERVICE_CANNOT_ACCEPT_CTRL                                               = 0x00000425U,
    ERROR_SERVICE_NOT_ACTIVE                                                       = 0x00000426U,
    ERROR_FAILED_SERVICE_CONTROLLER_CONNECT                                        = 0x00000427U,
    ERROR_EXCEPTION_IN_SERVICE                                                     = 0x00000428U,
    ERROR_DATABASE_DOES_NOT_EXIST                                                  = 0x00000429U,
    ERROR_SERVICE_SPECIFIC_ERROR                                                   = 0x0000042aU,
    ERROR_PROCESS_ABORTED                                                          = 0x0000042bU,
    ERROR_SERVICE_DEPENDENCY_FAIL                                                  = 0x0000042cU,
    ERROR_SERVICE_LOGON_FAILED                                                     = 0x0000042dU,
    ERROR_SERVICE_START_HANG                                                       = 0x0000042eU,
    ERROR_INVALID_SERVICE_LOCK                                                     = 0x0000042fU,
    ERROR_SERVICE_MARKED_FOR_DELETE                                                = 0x00000430U,
    ERROR_SERVICE_EXISTS                                                           = 0x00000431U,
    ERROR_ALREADY_RUNNING_LKG                                                      = 0x00000432U,
    ERROR_SERVICE_DEPENDENCY_DELETED                                               = 0x00000433U,
    ERROR_BOOT_ALREADY_ACCEPTED                                                    = 0x00000434U,
    ERROR_SERVICE_NEVER_STARTED                                                    = 0x00000435U,
    ERROR_DUPLICATE_SERVICE_NAME                                                   = 0x00000436U,
    ERROR_DIFFERENT_SERVICE_ACCOUNT                                                = 0x00000437U,
    ERROR_CANNOT_DETECT_DRIVER_FAILURE                                             = 0x00000438U,
    ERROR_CANNOT_DETECT_PROCESS_ABORT                                              = 0x00000439U,
    ERROR_NO_RECOVERY_PROGRAM                                                      = 0x0000043aU,
    ERROR_SERVICE_NOT_IN_EXE                                                       = 0x0000043bU,
    ERROR_NOT_SAFEBOOT_SERVICE                                                     = 0x0000043cU,
    ERROR_END_OF_MEDIA                                                             = 0x0000044cU,
    ERROR_FILEMARK_DETECTED                                                        = 0x0000044dU,
    ERROR_BEGINNING_OF_MEDIA                                                       = 0x0000044eU,
    ERROR_SETMARK_DETECTED                                                         = 0x0000044fU,
    ERROR_NO_DATA_DETECTED                                                         = 0x00000450U,
    ERROR_PARTITION_FAILURE                                                        = 0x00000451U,
    ERROR_INVALID_BLOCK_LENGTH                                                     = 0x00000452U,
    ERROR_DEVICE_NOT_PARTITIONED                                                   = 0x00000453U,
    ERROR_UNABLE_TO_LOCK_MEDIA                                                     = 0x00000454U,
    ERROR_UNABLE_TO_UNLOAD_MEDIA                                                   = 0x00000455U,
    ERROR_MEDIA_CHANGED                                                            = 0x00000456U,
    ERROR_BUS_RESET                                                                = 0x00000457U,
    ERROR_NO_MEDIA_IN_DRIVE                                                        = 0x00000458U,
    ERROR_NO_UNICODE_TRANSLATION                                                   = 0x00000459U,
    ERROR_DLL_INIT_FAILED                                                          = 0x0000045aU,
    ERROR_SHUTDOWN_IN_PROGRESS                                                     = 0x0000045bU,
    ERROR_NO_SHUTDOWN_IN_PROGRESS                                                  = 0x0000045cU,
    ERROR_IO_DEVICE                                                                = 0x0000045dU,
    ERROR_SERIAL_NO_DEVICE                                                         = 0x0000045eU,
    ERROR_IRQ_BUSY                                                                 = 0x0000045fU,
    ERROR_MORE_WRITES                                                              = 0x00000460U,
    ERROR_COUNTER_TIMEOUT                                                          = 0x00000461U,
    ERROR_FLOPPY_ID_MARK_NOT_FOUND                                                 = 0x00000462U,
    ERROR_FLOPPY_WRONG_CYLINDER                                                    = 0x00000463U,
    ERROR_FLOPPY_UNKNOWN_ERROR                                                     = 0x00000464U,
    ERROR_FLOPPY_BAD_REGISTERS                                                     = 0x00000465U,
    ERROR_DISK_RECALIBRATE_FAILED                                                  = 0x00000466U,
    ERROR_DISK_OPERATION_FAILED                                                    = 0x00000467U,
    ERROR_DISK_RESET_FAILED                                                        = 0x00000468U,
    ERROR_EOM_OVERFLOW                                                             = 0x00000469U,
    ERROR_NOT_ENOUGH_SERVER_MEMORY                                                 = 0x0000046aU,
    ERROR_POSSIBLE_DEADLOCK                                                        = 0x0000046bU,
    ERROR_MAPPED_ALIGNMENT                                                         = 0x0000046cU,
    ERROR_SET_POWER_STATE_VETOED                                                   = 0x00000474U,
    ERROR_SET_POWER_STATE_FAILED                                                   = 0x00000475U,
    ERROR_TOO_MANY_LINKS                                                           = 0x00000476U,
    ERROR_OLD_WIN_VERSION                                                          = 0x0000047eU,
    ERROR_APP_WRONG_OS                                                             = 0x0000047fU,
    ERROR_SINGLE_INSTANCE_APP                                                      = 0x00000480U,
    ERROR_RMODE_APP                                                                = 0x00000481U,
    ERROR_INVALID_DLL                                                              = 0x00000482U,
    ERROR_NO_ASSOCIATION                                                           = 0x00000483U,
    ERROR_DDE_FAIL                                                                 = 0x00000484U,
    ERROR_DLL_NOT_FOUND                                                            = 0x00000485U,
    ERROR_NO_MORE_USER_HANDLES                                                     = 0x00000486U,
    ERROR_MESSAGE_SYNC_ONLY                                                        = 0x00000487U,
    ERROR_SOURCE_ELEMENT_EMPTY                                                     = 0x00000488U,
    ERROR_DESTINATION_ELEMENT_FULL                                                 = 0x00000489U,
    ERROR_ILLEGAL_ELEMENT_ADDRESS                                                  = 0x0000048aU,
    ERROR_MAGAZINE_NOT_PRESENT                                                     = 0x0000048bU,
    ERROR_DEVICE_REINITIALIZATION_NEEDED                                           = 0x0000048cU,
    ERROR_DEVICE_REQUIRES_CLEANING                                                 = 0x0000048dU,
    ERROR_DEVICE_DOOR_OPEN                                                         = 0x0000048eU,
    ERROR_DEVICE_NOT_CONNECTED                                                     = 0x0000048fU,
    ERROR_NOT_FOUND                                                                = 0x00000490U,
    ERROR_NO_MATCH                                                                 = 0x00000491U,
    ERROR_SET_NOT_FOUND                                                            = 0x00000492U,
    ERROR_POINT_NOT_FOUND                                                          = 0x00000493U,
    ERROR_NO_TRACKING_SERVICE                                                      = 0x00000494U,
    ERROR_NO_VOLUME_ID                                                             = 0x00000495U,
    ERROR_UNABLE_TO_REMOVE_REPLACED                                                = 0x00000497U,
    ERROR_UNABLE_TO_MOVE_REPLACEMENT                                               = 0x00000498U,
    ERROR_UNABLE_TO_MOVE_REPLACEMENT_2                                             = 0x00000499U,
    ERROR_JOURNAL_DELETE_IN_PROGRESS                                               = 0x0000049aU,
    ERROR_JOURNAL_NOT_ACTIVE                                                       = 0x0000049bU,
    ERROR_POTENTIAL_FILE_FOUND                                                     = 0x0000049cU,
    ERROR_JOURNAL_ENTRY_DELETED                                                    = 0x0000049dU,
    ERROR_PARTITION_TERMINATING                                                    = 0x000004a0U,
    ERROR_SHUTDOWN_IS_SCHEDULED                                                    = 0x000004a6U,
    ERROR_SHUTDOWN_USERS_LOGGED_ON                                                 = 0x000004a7U,
    ERROR_SHUTDOWN_DISKS_NOT_IN_MAINTENANCE_MODE                                   = 0x000004a8U,
    ERROR_BAD_DEVICE                                                               = 0x000004b0U,
    ERROR_CONNECTION_UNAVAIL                                                       = 0x000004b1U,
    ERROR_DEVICE_ALREADY_REMEMBERED                                                = 0x000004b2U,
    ERROR_NO_NET_OR_BAD_PATH                                                       = 0x000004b3U,
    ERROR_BAD_PROVIDER                                                             = 0x000004b4U,
    ERROR_CANNOT_OPEN_PROFILE                                                      = 0x000004b5U,
    ERROR_BAD_PROFILE                                                              = 0x000004b6U,
    ERROR_NOT_CONTAINER                                                            = 0x000004b7U,
    ERROR_EXTENDED_ERROR                                                           = 0x000004b8U,
    ERROR_INVALID_GROUPNAME                                                        = 0x000004b9U,
    ERROR_INVALID_COMPUTERNAME                                                     = 0x000004baU,
    ERROR_INVALID_EVENTNAME                                                        = 0x000004bbU,
    ERROR_INVALID_DOMAINNAME                                                       = 0x000004bcU,
    ERROR_INVALID_SERVICENAME                                                      = 0x000004bdU,
    ERROR_INVALID_NETNAME                                                          = 0x000004beU,
    ERROR_INVALID_SHARENAME                                                        = 0x000004bfU,
    ERROR_INVALID_PASSWORDNAME                                                     = 0x000004c0U,
    ERROR_INVALID_MESSAGENAME                                                      = 0x000004c1U,
    ERROR_INVALID_MESSAGEDEST                                                      = 0x000004c2U,
    ERROR_SESSION_CREDENTIAL_CONFLICT                                              = 0x000004c3U,
    ERROR_REMOTE_SESSION_LIMIT_EXCEEDED                                            = 0x000004c4U,
    ERROR_DUP_DOMAINNAME                                                           = 0x000004c5U,
    ERROR_NO_NETWORK                                                               = 0x000004c6U,
    ERROR_CANCELLED                                                                = 0x000004c7U,
    ERROR_USER_MAPPED_FILE                                                         = 0x000004c8U,
    ERROR_CONNECTION_REFUSED                                                       = 0x000004c9U,
    ERROR_GRACEFUL_DISCONNECT                                                      = 0x000004caU,
    ERROR_ADDRESS_ALREADY_ASSOCIATED                                               = 0x000004cbU,
    ERROR_ADDRESS_NOT_ASSOCIATED                                                   = 0x000004ccU,
    ERROR_CONNECTION_INVALID                                                       = 0x000004cdU,
    ERROR_CONNECTION_ACTIVE                                                        = 0x000004ceU,
    ERROR_NETWORK_UNREACHABLE                                                      = 0x000004cfU,
    ERROR_HOST_UNREACHABLE                                                         = 0x000004d0U,
    ERROR_PROTOCOL_UNREACHABLE                                                     = 0x000004d1U,
    ERROR_PORT_UNREACHABLE                                                         = 0x000004d2U,
    ERROR_REQUEST_ABORTED                                                          = 0x000004d3U,
    ERROR_CONNECTION_ABORTED                                                       = 0x000004d4U,
    ERROR_RETRY                                                                    = 0x000004d5U,
    ERROR_CONNECTION_COUNT_LIMIT                                                   = 0x000004d6U,
    ERROR_LOGIN_TIME_RESTRICTION                                                   = 0x000004d7U,
    ERROR_LOGIN_WKSTA_RESTRICTION                                                  = 0x000004d8U,
    ERROR_INCORRECT_ADDRESS                                                        = 0x000004d9U,
    ERROR_ALREADY_REGISTERED                                                       = 0x000004daU,
    ERROR_SERVICE_NOT_FOUND                                                        = 0x000004dbU,
    ERROR_NOT_AUTHENTICATED                                                        = 0x000004dcU,
    ERROR_NOT_LOGGED_ON                                                            = 0x000004ddU,
    ERROR_CONTINUE                                                                 = 0x000004deU,
    ERROR_ALREADY_INITIALIZED                                                      = 0x000004dfU,
    ERROR_NO_MORE_DEVICES                                                          = 0x000004e0U,
    ERROR_NO_SUCH_SITE                                                             = 0x000004e1U,
    ERROR_DOMAIN_CONTROLLER_EXISTS                                                 = 0x000004e2U,
    ERROR_ONLY_IF_CONNECTED                                                        = 0x000004e3U,
    ERROR_OVERRIDE_NOCHANGES                                                       = 0x000004e4U,
    ERROR_BAD_USER_PROFILE                                                         = 0x000004e5U,
    ERROR_NOT_SUPPORTED_ON_SBS                                                     = 0x000004e6U,
    ERROR_SERVER_SHUTDOWN_IN_PROGRESS                                              = 0x000004e7U,
    ERROR_HOST_DOWN                                                                = 0x000004e8U,
    ERROR_NON_ACCOUNT_SID                                                          = 0x000004e9U,
    ERROR_NON_DOMAIN_SID                                                           = 0x000004eaU,
    ERROR_APPHELP_BLOCK                                                            = 0x000004ebU,
    ERROR_ACCESS_DISABLED_BY_POLICY                                                = 0x000004ecU,
    ERROR_REG_NAT_CONSUMPTION                                                      = 0x000004edU,
    ERROR_CSCSHARE_OFFLINE                                                         = 0x000004eeU,
    ERROR_PKINIT_FAILURE                                                           = 0x000004efU,
    ERROR_SMARTCARD_SUBSYSTEM_FAILURE                                              = 0x000004f0U,
    ERROR_DOWNGRADE_DETECTED                                                       = 0x000004f1U,
    ERROR_MACHINE_LOCKED                                                           = 0x000004f7U,
    ERROR_SMB_GUEST_LOGON_BLOCKED                                                  = 0x000004f8U,
    ERROR_CALLBACK_SUPPLIED_INVALID_DATA                                           = 0x000004f9U,
    ERROR_SYNC_FOREGROUND_REFRESH_REQUIRED                                         = 0x000004faU,
    ERROR_DRIVER_BLOCKED                                                           = 0x000004fbU,
    ERROR_INVALID_IMPORT_OF_NON_DLL                                                = 0x000004fcU,
    ERROR_ACCESS_DISABLED_WEBBLADE                                                 = 0x000004fdU,
    ERROR_ACCESS_DISABLED_WEBBLADE_TAMPER                                          = 0x000004feU,
    ERROR_RECOVERY_FAILURE                                                         = 0x000004ffU,
    ERROR_ALREADY_FIBER                                                            = 0x00000500U,
    ERROR_ALREADY_THREAD                                                           = 0x00000501U,
    ERROR_STACK_BUFFER_OVERRUN                                                     = 0x00000502U,
    ERROR_PARAMETER_QUOTA_EXCEEDED                                                 = 0x00000503U,
    ERROR_DEBUGGER_INACTIVE                                                        = 0x00000504U,
    ERROR_DELAY_LOAD_FAILED                                                        = 0x00000505U,
    ERROR_VDM_DISALLOWED                                                           = 0x00000506U,
    ERROR_UNIDENTIFIED_ERROR                                                       = 0x00000507U,
    ERROR_INVALID_CRUNTIME_PARAMETER                                               = 0x00000508U,
    ERROR_BEYOND_VDL                                                               = 0x00000509U,
    ERROR_INCOMPATIBLE_SERVICE_SID_TYPE                                            = 0x0000050aU,
    ERROR_DRIVER_PROCESS_TERMINATED                                                = 0x0000050bU,
    ERROR_IMPLEMENTATION_LIMIT                                                     = 0x0000050cU,
    ERROR_PROCESS_IS_PROTECTED                                                     = 0x0000050dU,
    ERROR_SERVICE_NOTIFY_CLIENT_LAGGING                                            = 0x0000050eU,
    ERROR_DISK_QUOTA_EXCEEDED                                                      = 0x0000050fU,
    ERROR_CONTENT_BLOCKED                                                          = 0x00000510U,
    ERROR_INCOMPATIBLE_SERVICE_PRIVILEGE                                           = 0x00000511U,
    ERROR_APP_HANG                                                                 = 0x00000512U,
    ERROR_INVALID_LABEL                                                            = 0x00000513U,
    ERROR_NOT_ALL_ASSIGNED                                                         = 0x00000514U,
    ERROR_SOME_NOT_MAPPED                                                          = 0x00000515U,
    ERROR_NO_QUOTAS_FOR_ACCOUNT                                                    = 0x00000516U,
    ERROR_LOCAL_USER_SESSION_KEY                                                   = 0x00000517U,
    ERROR_NULL_LM_PASSWORD                                                         = 0x00000518U,
    ERROR_UNKNOWN_REVISION                                                         = 0x00000519U,
    ERROR_REVISION_MISMATCH                                                        = 0x0000051aU,
    ERROR_INVALID_OWNER                                                            = 0x0000051bU,
    ERROR_INVALID_PRIMARY_GROUP                                                    = 0x0000051cU,
    ERROR_NO_IMPERSONATION_TOKEN                                                   = 0x0000051dU,
    ERROR_CANT_DISABLE_MANDATORY                                                   = 0x0000051eU,
    ERROR_NO_LOGON_SERVERS                                                         = 0x0000051fU,
    ERROR_NO_SUCH_LOGON_SESSION                                                    = 0x00000520U,
    ERROR_NO_SUCH_PRIVILEGE                                                        = 0x00000521U,
    ERROR_PRIVILEGE_NOT_HELD                                                       = 0x00000522U,
    ERROR_INVALID_ACCOUNT_NAME                                                     = 0x00000523U,
    ERROR_USER_EXISTS                                                              = 0x00000524U,
    ERROR_NO_SUCH_USER                                                             = 0x00000525U,
    ERROR_GROUP_EXISTS                                                             = 0x00000526U,
    ERROR_NO_SUCH_GROUP                                                            = 0x00000527U,
    ERROR_MEMBER_IN_GROUP                                                          = 0x00000528U,
    ERROR_MEMBER_NOT_IN_GROUP                                                      = 0x00000529U,
    ERROR_LAST_ADMIN                                                               = 0x0000052aU,
    ERROR_WRONG_PASSWORD                                                           = 0x0000052bU,
    ERROR_ILL_FORMED_PASSWORD                                                      = 0x0000052cU,
    ERROR_PASSWORD_RESTRICTION                                                     = 0x0000052dU,
    ERROR_LOGON_FAILURE                                                            = 0x0000052eU,
    ERROR_ACCOUNT_RESTRICTION                                                      = 0x0000052fU,
    ERROR_INVALID_LOGON_HOURS                                                      = 0x00000530U,
    ERROR_INVALID_WORKSTATION                                                      = 0x00000531U,
    ERROR_PASSWORD_EXPIRED                                                         = 0x00000532U,
    ERROR_ACCOUNT_DISABLED                                                         = 0x00000533U,
    ERROR_NONE_MAPPED                                                              = 0x00000534U,
    ERROR_TOO_MANY_LUIDS_REQUESTED                                                 = 0x00000535U,
    ERROR_LUIDS_EXHAUSTED                                                          = 0x00000536U,
    ERROR_INVALID_SUB_AUTHORITY                                                    = 0x00000537U,
    ERROR_INVALID_ACL                                                              = 0x00000538U,
    ERROR_INVALID_SID                                                              = 0x00000539U,
    ERROR_INVALID_SECURITY_DESCR                                                   = 0x0000053aU,
    ERROR_BAD_INHERITANCE_ACL                                                      = 0x0000053cU,
    ERROR_SERVER_DISABLED                                                          = 0x0000053dU,
    ERROR_SERVER_NOT_DISABLED                                                      = 0x0000053eU,
    ERROR_INVALID_ID_AUTHORITY                                                     = 0x0000053fU,
    ERROR_ALLOTTED_SPACE_EXCEEDED                                                  = 0x00000540U,
    ERROR_INVALID_GROUP_ATTRIBUTES                                                 = 0x00000541U,
    ERROR_BAD_IMPERSONATION_LEVEL                                                  = 0x00000542U,
    ERROR_CANT_OPEN_ANONYMOUS                                                      = 0x00000543U,
    ERROR_BAD_VALIDATION_CLASS                                                     = 0x00000544U,
    ERROR_BAD_TOKEN_TYPE                                                           = 0x00000545U,
    ERROR_NO_SECURITY_ON_OBJECT                                                    = 0x00000546U,
    ERROR_CANT_ACCESS_DOMAIN_INFO                                                  = 0x00000547U,
    ERROR_INVALID_SERVER_STATE                                                     = 0x00000548U,
    ERROR_INVALID_DOMAIN_STATE                                                     = 0x00000549U,
    ERROR_INVALID_DOMAIN_ROLE                                                      = 0x0000054aU,
    ERROR_NO_SUCH_DOMAIN                                                           = 0x0000054bU,
    ERROR_DOMAIN_EXISTS                                                            = 0x0000054cU,
    ERROR_DOMAIN_LIMIT_EXCEEDED                                                    = 0x0000054dU,
    ERROR_INTERNAL_DB_CORRUPTION                                                   = 0x0000054eU,
    ERROR_INTERNAL_ERROR                                                           = 0x0000054fU,
    ERROR_GENERIC_NOT_MAPPED                                                       = 0x00000550U,
    ERROR_BAD_DESCRIPTOR_FORMAT                                                    = 0x00000551U,
    ERROR_NOT_LOGON_PROCESS                                                        = 0x00000552U,
    ERROR_LOGON_SESSION_EXISTS                                                     = 0x00000553U,
    ERROR_NO_SUCH_PACKAGE                                                          = 0x00000554U,
    ERROR_BAD_LOGON_SESSION_STATE                                                  = 0x00000555U,
    ERROR_LOGON_SESSION_COLLISION                                                  = 0x00000556U,
    ERROR_INVALID_LOGON_TYPE                                                       = 0x00000557U,
    ERROR_CANNOT_IMPERSONATE                                                       = 0x00000558U,
    ERROR_RXACT_INVALID_STATE                                                      = 0x00000559U,
    ERROR_RXACT_COMMIT_FAILURE                                                     = 0x0000055aU,
    ERROR_SPECIAL_ACCOUNT                                                          = 0x0000055bU,
    ERROR_SPECIAL_GROUP                                                            = 0x0000055cU,
    ERROR_SPECIAL_USER                                                             = 0x0000055dU,
    ERROR_MEMBERS_PRIMARY_GROUP                                                    = 0x0000055eU,
    ERROR_TOKEN_ALREADY_IN_USE                                                     = 0x0000055fU,
    ERROR_NO_SUCH_ALIAS                                                            = 0x00000560U,
    ERROR_MEMBER_NOT_IN_ALIAS                                                      = 0x00000561U,
    ERROR_MEMBER_IN_ALIAS                                                          = 0x00000562U,
    ERROR_ALIAS_EXISTS                                                             = 0x00000563U,
    ERROR_LOGON_NOT_GRANTED                                                        = 0x00000564U,
    ERROR_TOO_MANY_SECRETS                                                         = 0x00000565U,
    ERROR_SECRET_TOO_LONG                                                          = 0x00000566U,
    ERROR_INTERNAL_DB_ERROR                                                        = 0x00000567U,
    ERROR_TOO_MANY_CONTEXT_IDS                                                     = 0x00000568U,
    ERROR_LOGON_TYPE_NOT_GRANTED                                                   = 0x00000569U,
    ERROR_NT_CROSS_ENCRYPTION_REQUIRED                                             = 0x0000056aU,
    ERROR_NO_SUCH_MEMBER                                                           = 0x0000056bU,
    ERROR_INVALID_MEMBER                                                           = 0x0000056cU,
    ERROR_TOO_MANY_SIDS                                                            = 0x0000056dU,
    ERROR_LM_CROSS_ENCRYPTION_REQUIRED                                             = 0x0000056eU,
    ERROR_NO_INHERITANCE                                                           = 0x0000056fU,
    ERROR_FILE_CORRUPT                                                             = 0x00000570U,
    ERROR_DISK_CORRUPT                                                             = 0x00000571U,
    ERROR_NO_USER_SESSION_KEY                                                      = 0x00000572U,
    ERROR_LICENSE_QUOTA_EXCEEDED                                                   = 0x00000573U,
    ERROR_WRONG_TARGET_NAME                                                        = 0x00000574U,
    ERROR_MUTUAL_AUTH_FAILED                                                       = 0x00000575U,
    ERROR_TIME_SKEW                                                                = 0x00000576U,
    ERROR_CURRENT_DOMAIN_NOT_ALLOWED                                               = 0x00000577U,
    ERROR_INVALID_WINDOW_HANDLE                                                    = 0x00000578U,
    ERROR_INVALID_MENU_HANDLE                                                      = 0x00000579U,
    ERROR_INVALID_CURSOR_HANDLE                                                    = 0x0000057aU,
    ERROR_INVALID_ACCEL_HANDLE                                                     = 0x0000057bU,
    ERROR_INVALID_HOOK_HANDLE                                                      = 0x0000057cU,
    ERROR_INVALID_DWP_HANDLE                                                       = 0x0000057dU,
    ERROR_TLW_WITH_WSCHILD                                                         = 0x0000057eU,
    ERROR_CANNOT_FIND_WND_CLASS                                                    = 0x0000057fU,
    ERROR_WINDOW_OF_OTHER_THREAD                                                   = 0x00000580U,
    ERROR_HOTKEY_ALREADY_REGISTERED                                                = 0x00000581U,
    ERROR_CLASS_ALREADY_EXISTS                                                     = 0x00000582U,
    ERROR_CLASS_DOES_NOT_EXIST                                                     = 0x00000583U,
    ERROR_CLASS_HAS_WINDOWS                                                        = 0x00000584U,
    ERROR_INVALID_INDEX                                                            = 0x00000585U,
    ERROR_INVALID_ICON_HANDLE                                                      = 0x00000586U,
    ERROR_PRIVATE_DIALOG_INDEX                                                     = 0x00000587U,
    ERROR_LISTBOX_ID_NOT_FOUND                                                     = 0x00000588U,
    ERROR_NO_WILDCARD_CHARACTERS                                                   = 0x00000589U,
    ERROR_CLIPBOARD_NOT_OPEN                                                       = 0x0000058aU,
    ERROR_HOTKEY_NOT_REGISTERED                                                    = 0x0000058bU,
    ERROR_WINDOW_NOT_DIALOG                                                        = 0x0000058cU,
    ERROR_CONTROL_ID_NOT_FOUND                                                     = 0x0000058dU,
    ERROR_INVALID_COMBOBOX_MESSAGE                                                 = 0x0000058eU,
    ERROR_WINDOW_NOT_COMBOBOX                                                      = 0x0000058fU,
    ERROR_INVALID_EDIT_HEIGHT                                                      = 0x00000590U,
    ERROR_DC_NOT_FOUND                                                             = 0x00000591U,
    ERROR_INVALID_HOOK_FILTER                                                      = 0x00000592U,
    ERROR_INVALID_FILTER_PROC                                                      = 0x00000593U,
    ERROR_HOOK_NEEDS_HMOD                                                          = 0x00000594U,
    ERROR_GLOBAL_ONLY_HOOK                                                         = 0x00000595U,
    ERROR_JOURNAL_HOOK_SET                                                         = 0x00000596U,
    ERROR_HOOK_NOT_INSTALLED                                                       = 0x00000597U,
    ERROR_INVALID_LB_MESSAGE                                                       = 0x00000598U,
    ERROR_SETCOUNT_ON_BAD_LB                                                       = 0x00000599U,
    ERROR_LB_WITHOUT_TABSTOPS                                                      = 0x0000059aU,
    ERROR_DESTROY_OBJECT_OF_OTHER_THREAD                                           = 0x0000059bU,
    ERROR_CHILD_WINDOW_MENU                                                        = 0x0000059cU,
    ERROR_NO_SYSTEM_MENU                                                           = 0x0000059dU,
    ERROR_INVALID_MSGBOX_STYLE                                                     = 0x0000059eU,
    ERROR_INVALID_SPI_VALUE                                                        = 0x0000059fU,
    ERROR_SCREEN_ALREADY_LOCKED                                                    = 0x000005a0U,
    ERROR_HWNDS_HAVE_DIFF_PARENT                                                   = 0x000005a1U,
    ERROR_NOT_CHILD_WINDOW                                                         = 0x000005a2U,
    ERROR_INVALID_GW_COMMAND                                                       = 0x000005a3U,
    ERROR_INVALID_THREAD_ID                                                        = 0x000005a4U,
    ERROR_NON_MDICHILD_WINDOW                                                      = 0x000005a5U,
    ERROR_POPUP_ALREADY_ACTIVE                                                     = 0x000005a6U,
    ERROR_NO_SCROLLBARS                                                            = 0x000005a7U,
    ERROR_INVALID_SCROLLBAR_RANGE                                                  = 0x000005a8U,
    ERROR_INVALID_SHOWWIN_COMMAND                                                  = 0x000005a9U,
    ERROR_NO_SYSTEM_RESOURCES                                                      = 0x000005aaU,
    ERROR_NONPAGED_SYSTEM_RESOURCES                                                = 0x000005abU,
    ERROR_PAGED_SYSTEM_RESOURCES                                                   = 0x000005acU,
    ERROR_WORKING_SET_QUOTA                                                        = 0x000005adU,
    ERROR_PAGEFILE_QUOTA                                                           = 0x000005aeU,
    ERROR_COMMITMENT_LIMIT                                                         = 0x000005afU,
    ERROR_MENU_ITEM_NOT_FOUND                                                      = 0x000005b0U,
    ERROR_INVALID_KEYBOARD_HANDLE                                                  = 0x000005b1U,
    ERROR_HOOK_TYPE_NOT_ALLOWED                                                    = 0x000005b2U,
    ERROR_REQUIRES_INTERACTIVE_WINDOWSTATION                                       = 0x000005b3U,
    ERROR_TIMEOUT                                                                  = 0x000005b4U,
    ERROR_INVALID_MONITOR_HANDLE                                                   = 0x000005b5U,
    ERROR_INCORRECT_SIZE                                                           = 0x000005b6U,
    ERROR_SYMLINK_CLASS_DISABLED                                                   = 0x000005b7U,
    ERROR_SYMLINK_NOT_SUPPORTED                                                    = 0x000005b8U,
    ERROR_XML_PARSE_ERROR                                                          = 0x000005b9U,
    ERROR_XMLDSIG_ERROR                                                            = 0x000005baU,
    ERROR_RESTART_APPLICATION                                                      = 0x000005bbU,
    ERROR_WRONG_COMPARTMENT                                                        = 0x000005bcU,
    ERROR_AUTHIP_FAILURE                                                           = 0x000005bdU,
    ERROR_NO_NVRAM_RESOURCES                                                       = 0x000005beU,
    ERROR_NOT_GUI_PROCESS                                                          = 0x000005bfU,
    ERROR_EVENTLOG_FILE_CORRUPT                                                    = 0x000005dcU,
    ERROR_EVENTLOG_CANT_START                                                      = 0x000005ddU,
    ERROR_LOG_FILE_FULL                                                            = 0x000005deU,
    ERROR_EVENTLOG_FILE_CHANGED                                                    = 0x000005dfU,
    ERROR_CONTAINER_ASSIGNED                                                       = 0x000005e0U,
    ERROR_JOB_NO_CONTAINER                                                         = 0x000005e1U,
    ERROR_INVALID_TASK_NAME                                                        = 0x0000060eU,
    ERROR_INVALID_TASK_INDEX                                                       = 0x0000060fU,
    ERROR_THREAD_ALREADY_IN_TASK                                                   = 0x00000610U,
    ERROR_INSTALL_SERVICE_FAILURE                                                  = 0x00000641U,
    ERROR_INSTALL_USEREXIT                                                         = 0x00000642U,
    ERROR_INSTALL_FAILURE                                                          = 0x00000643U,
    ERROR_INSTALL_SUSPEND                                                          = 0x00000644U,
    ERROR_UNKNOWN_PRODUCT                                                          = 0x00000645U,
    ERROR_UNKNOWN_FEATURE                                                          = 0x00000646U,
    ERROR_UNKNOWN_COMPONENT                                                        = 0x00000647U,
    ERROR_UNKNOWN_PROPERTY                                                         = 0x00000648U,
    ERROR_INVALID_HANDLE_STATE                                                     = 0x00000649U,
    ERROR_BAD_CONFIGURATION                                                        = 0x0000064aU,
    ERROR_INDEX_ABSENT                                                             = 0x0000064bU,
    ERROR_INSTALL_SOURCE_ABSENT                                                    = 0x0000064cU,
    ERROR_INSTALL_PACKAGE_VERSION                                                  = 0x0000064dU,
    ERROR_PRODUCT_UNINSTALLED                                                      = 0x0000064eU,
    ERROR_BAD_QUERY_SYNTAX                                                         = 0x0000064fU,
    ERROR_INVALID_FIELD                                                            = 0x00000650U,
    ERROR_DEVICE_REMOVED                                                           = 0x00000651U,
    ERROR_INSTALL_ALREADY_RUNNING                                                  = 0x00000652U,
    ERROR_INSTALL_PACKAGE_OPEN_FAILED                                              = 0x00000653U,
    ERROR_INSTALL_PACKAGE_INVALID                                                  = 0x00000654U,
    ERROR_INSTALL_UI_FAILURE                                                       = 0x00000655U,
    ERROR_INSTALL_LOG_FAILURE                                                      = 0x00000656U,
    ERROR_INSTALL_LANGUAGE_UNSUPPORTED                                             = 0x00000657U,
    ERROR_INSTALL_TRANSFORM_FAILURE                                                = 0x00000658U,
    ERROR_INSTALL_PACKAGE_REJECTED                                                 = 0x00000659U,
    ERROR_FUNCTION_NOT_CALLED                                                      = 0x0000065aU,
    ERROR_FUNCTION_FAILED                                                          = 0x0000065bU,
    ERROR_INVALID_TABLE                                                            = 0x0000065cU,
    ERROR_DATATYPE_MISMATCH                                                        = 0x0000065dU,
    ERROR_UNSUPPORTED_TYPE                                                         = 0x0000065eU,
    ERROR_CREATE_FAILED                                                            = 0x0000065fU,
    ERROR_INSTALL_TEMP_UNWRITABLE                                                  = 0x00000660U,
    ERROR_INSTALL_PLATFORM_UNSUPPORTED                                             = 0x00000661U,
    ERROR_INSTALL_NOTUSED                                                          = 0x00000662U,
    ERROR_PATCH_PACKAGE_OPEN_FAILED                                                = 0x00000663U,
    ERROR_PATCH_PACKAGE_INVALID                                                    = 0x00000664U,
    ERROR_PATCH_PACKAGE_UNSUPPORTED                                                = 0x00000665U,
    ERROR_PRODUCT_VERSION                                                          = 0x00000666U,
    ERROR_INVALID_COMMAND_LINE                                                     = 0x00000667U,
    ERROR_INSTALL_REMOTE_DISALLOWED                                                = 0x00000668U,
    ERROR_SUCCESS_REBOOT_INITIATED                                                 = 0x00000669U,
    ERROR_PATCH_TARGET_NOT_FOUND                                                   = 0x0000066aU,
    ERROR_PATCH_PACKAGE_REJECTED                                                   = 0x0000066bU,
    ERROR_INSTALL_TRANSFORM_REJECTED                                               = 0x0000066cU,
    ERROR_INSTALL_REMOTE_PROHIBITED                                                = 0x0000066dU,
    ERROR_PATCH_REMOVAL_UNSUPPORTED                                                = 0x0000066eU,
    ERROR_UNKNOWN_PATCH                                                            = 0x0000066fU,
    ERROR_PATCH_NO_SEQUENCE                                                        = 0x00000670U,
    ERROR_PATCH_REMOVAL_DISALLOWED                                                 = 0x00000671U,
    ERROR_INVALID_PATCH_XML                                                        = 0x00000672U,
    ERROR_PATCH_MANAGED_ADVERTISED_PRODUCT                                         = 0x00000673U,
    ERROR_INSTALL_SERVICE_SAFEBOOT                                                 = 0x00000674U,
    ERROR_FAIL_FAST_EXCEPTION                                                      = 0x00000675U,
    ERROR_INSTALL_REJECTED                                                         = 0x00000676U,
    ERROR_DYNAMIC_CODE_BLOCKED                                                     = 0x00000677U,
    ERROR_NOT_SAME_OBJECT                                                          = 0x00000678U,
    ERROR_STRICT_CFG_VIOLATION                                                     = 0x00000679U,
    ERROR_SET_CONTEXT_DENIED                                                       = 0x0000067cU,
    ERROR_CROSS_PARTITION_VIOLATION                                                = 0x0000067dU,
    ERROR_RETURN_ADDRESS_HIJACK_ATTEMPT                                            = 0x0000067eU,
    ERROR_INVALID_USER_BUFFER                                                      = 0x000006f8U,
    ERROR_UNRECOGNIZED_MEDIA                                                       = 0x000006f9U,
    ERROR_NO_TRUST_LSA_SECRET                                                      = 0x000006faU,
    ERROR_NO_TRUST_SAM_ACCOUNT                                                     = 0x000006fbU,
    ERROR_TRUSTED_DOMAIN_FAILURE                                                   = 0x000006fcU,
    ERROR_TRUSTED_RELATIONSHIP_FAILURE                                             = 0x000006fdU,
    ERROR_TRUST_FAILURE                                                            = 0x000006feU,
    ERROR_NETLOGON_NOT_STARTED                                                     = 0x00000700U,
    ERROR_ACCOUNT_EXPIRED                                                          = 0x00000701U,
    ERROR_REDIRECTOR_HAS_OPEN_HANDLES                                              = 0x00000702U,
    ERROR_PRINTER_DRIVER_ALREADY_INSTALLED                                         = 0x00000703U,
    ERROR_UNKNOWN_PORT                                                             = 0x00000704U,
    ERROR_UNKNOWN_PRINTER_DRIVER                                                   = 0x00000705U,
    ERROR_UNKNOWN_PRINTPROCESSOR                                                   = 0x00000706U,
    ERROR_INVALID_SEPARATOR_FILE                                                   = 0x00000707U,
    ERROR_INVALID_PRIORITY                                                         = 0x00000708U,
    ERROR_INVALID_PRINTER_NAME                                                     = 0x00000709U,
    ERROR_PRINTER_ALREADY_EXISTS                                                   = 0x0000070aU,
    ERROR_INVALID_PRINTER_COMMAND                                                  = 0x0000070bU,
    ERROR_INVALID_DATATYPE                                                         = 0x0000070cU,
    ERROR_INVALID_ENVIRONMENT                                                      = 0x0000070dU,
    ERROR_NOLOGON_INTERDOMAIN_TRUST_ACCOUNT                                        = 0x0000070fU,
    ERROR_NOLOGON_WORKSTATION_TRUST_ACCOUNT                                        = 0x00000710U,
    ERROR_NOLOGON_SERVER_TRUST_ACCOUNT                                             = 0x00000711U,
    ERROR_DOMAIN_TRUST_INCONSISTENT                                                = 0x00000712U,
    ERROR_SERVER_HAS_OPEN_HANDLES                                                  = 0x00000713U,
    ERROR_RESOURCE_DATA_NOT_FOUND                                                  = 0x00000714U,
    ERROR_RESOURCE_TYPE_NOT_FOUND                                                  = 0x00000715U,
    ERROR_RESOURCE_NAME_NOT_FOUND                                                  = 0x00000716U,
    ERROR_RESOURCE_LANG_NOT_FOUND                                                  = 0x00000717U,
    ERROR_NOT_ENOUGH_QUOTA                                                         = 0x00000718U,
    ERROR_INVALID_TIME                                                             = 0x0000076dU,
    ERROR_INVALID_FORM_NAME                                                        = 0x0000076eU,
    ERROR_INVALID_FORM_SIZE                                                        = 0x0000076fU,
    ERROR_ALREADY_WAITING                                                          = 0x00000770U,
    ERROR_PRINTER_DELETED                                                          = 0x00000771U,
    ERROR_INVALID_PRINTER_STATE                                                    = 0x00000772U,
    ERROR_PASSWORD_MUST_CHANGE                                                     = 0x00000773U,
    ERROR_DOMAIN_CONTROLLER_NOT_FOUND                                              = 0x00000774U,
    ERROR_ACCOUNT_LOCKED_OUT                                                       = 0x00000775U,
    ERROR_NO_SITENAME                                                              = 0x0000077fU,
    ERROR_CANT_ACCESS_FILE                                                         = 0x00000780U,
    ERROR_CANT_RESOLVE_FILENAME                                                    = 0x00000781U,
    ERROR_KM_DRIVER_BLOCKED                                                        = 0x0000078aU,
    ERROR_CONTEXT_EXPIRED                                                          = 0x0000078bU,
    ERROR_PER_USER_TRUST_QUOTA_EXCEEDED                                            = 0x0000078cU,
    ERROR_ALL_USER_TRUST_QUOTA_EXCEEDED                                            = 0x0000078dU,
    ERROR_USER_DELETE_TRUST_QUOTA_EXCEEDED                                         = 0x0000078eU,
    ERROR_AUTHENTICATION_FIREWALL_FAILED                                           = 0x0000078fU,
    ERROR_REMOTE_PRINT_CONNECTIONS_BLOCKED                                         = 0x00000790U,
    ERROR_NTLM_BLOCKED                                                             = 0x00000791U,
    ERROR_PASSWORD_CHANGE_REQUIRED                                                 = 0x00000792U,
    ERROR_LOST_MODE_LOGON_RESTRICTION                                              = 0x00000793U,
    ERROR_INVALID_PIXEL_FORMAT                                                     = 0x000007d0U,
    ERROR_BAD_DRIVER                                                               = 0x000007d1U,
    ERROR_INVALID_WINDOW_STYLE                                                     = 0x000007d2U,
    ERROR_METAFILE_NOT_SUPPORTED                                                   = 0x000007d3U,
    ERROR_TRANSFORM_NOT_SUPPORTED                                                  = 0x000007d4U,
    ERROR_CLIPPING_NOT_SUPPORTED                                                   = 0x000007d5U,
    ERROR_INVALID_CMM                                                              = 0x000007daU,
    ERROR_INVALID_PROFILE                                                          = 0x000007dbU,
    ERROR_TAG_NOT_FOUND                                                            = 0x000007dcU,
    ERROR_TAG_NOT_PRESENT                                                          = 0x000007ddU,
    ERROR_DUPLICATE_TAG                                                            = 0x000007deU,
    ERROR_PROFILE_NOT_ASSOCIATED_WITH_DEVICE                                       = 0x000007dfU,
    ERROR_PROFILE_NOT_FOUND                                                        = 0x000007e0U,
    ERROR_INVALID_COLORSPACE                                                       = 0x000007e1U,
    ERROR_ICM_NOT_ENABLED                                                          = 0x000007e2U,
    ERROR_DELETING_ICM_XFORM                                                       = 0x000007e3U,
    ERROR_INVALID_TRANSFORM                                                        = 0x000007e4U,
    ERROR_COLORSPACE_MISMATCH                                                      = 0x000007e5U,
    ERROR_INVALID_COLORINDEX                                                       = 0x000007e6U,
    ERROR_PROFILE_DOES_NOT_MATCH_DEVICE                                            = 0x000007e7U,
    ERROR_CONNECTED_OTHER_PASSWORD                                                 = 0x0000083cU,
    ERROR_CONNECTED_OTHER_PASSWORD_DEFAULT                                         = 0x0000083dU,
    ERROR_BAD_USERNAME                                                             = 0x0000089aU,
    ERROR_NOT_CONNECTED                                                            = 0x000008caU,
    ERROR_OPEN_FILES                                                               = 0x00000961U,
    ERROR_ACTIVE_CONNECTIONS                                                       = 0x00000962U,
    ERROR_DEVICE_IN_USE                                                            = 0x00000964U,
    ERROR_UNKNOWN_PRINT_MONITOR                                                    = 0x00000bb8U,
    ERROR_PRINTER_DRIVER_IN_USE                                                    = 0x00000bb9U,
    ERROR_SPOOL_FILE_NOT_FOUND                                                     = 0x00000bbaU,
    ERROR_SPL_NO_STARTDOC                                                          = 0x00000bbbU,
    ERROR_SPL_NO_ADDJOB                                                            = 0x00000bbcU,
    ERROR_PRINT_PROCESSOR_ALREADY_INSTALLED                                        = 0x00000bbdU,
    ERROR_PRINT_MONITOR_ALREADY_INSTALLED                                          = 0x00000bbeU,
    ERROR_INVALID_PRINT_MONITOR                                                    = 0x00000bbfU,
    ERROR_PRINT_MONITOR_IN_USE                                                     = 0x00000bc0U,
    ERROR_PRINTER_HAS_JOBS_QUEUED                                                  = 0x00000bc1U,
    ERROR_SUCCESS_REBOOT_REQUIRED                                                  = 0x00000bc2U,
    ERROR_SUCCESS_RESTART_REQUIRED                                                 = 0x00000bc3U,
    ERROR_PRINTER_NOT_FOUND                                                        = 0x00000bc4U,
    ERROR_PRINTER_DRIVER_WARNED                                                    = 0x00000bc5U,
    ERROR_PRINTER_DRIVER_BLOCKED                                                   = 0x00000bc6U,
    ERROR_PRINTER_DRIVER_PACKAGE_IN_USE                                            = 0x00000bc7U,
    ERROR_CORE_DRIVER_PACKAGE_NOT_FOUND                                            = 0x00000bc8U,
    ERROR_FAIL_REBOOT_REQUIRED                                                     = 0x00000bc9U,
    ERROR_FAIL_REBOOT_INITIATED                                                    = 0x00000bcaU,
    ERROR_PRINTER_DRIVER_DOWNLOAD_NEEDED                                           = 0x00000bcbU,
    ERROR_PRINT_JOB_RESTART_REQUIRED                                               = 0x00000bccU,
    ERROR_INVALID_PRINTER_DRIVER_MANIFEST                                          = 0x00000bcdU,
    ERROR_PRINTER_NOT_SHAREABLE                                                    = 0x00000bceU,
    ERROR_SERVER_SERVICE_CALL_REQUIRES_SMB1                                        = 0x00000bcfU,
    ERROR_NETWORK_AUTHENTICATION_PROMPT_CANCELED                                   = 0x00000bd0U,
    ERROR_REMOTE_MAILSLOTS_DEPRECATED                                              = 0x00000bd1U,
    ERROR_REQUEST_PAUSED                                                           = 0x00000beaU,
    ERROR_APPEXEC_CONDITION_NOT_SATISFIED                                          = 0x00000bf4U,
    ERROR_APPEXEC_HANDLE_INVALIDATED                                               = 0x00000bf5U,
    ERROR_APPEXEC_INVALID_HOST_GENERATION                                          = 0x00000bf6U,
    ERROR_APPEXEC_UNEXPECTED_PROCESS_REGISTRATION                                  = 0x00000bf7U,
    ERROR_APPEXEC_INVALID_HOST_STATE                                               = 0x00000bf8U,
    ERROR_APPEXEC_NO_DONOR                                                         = 0x00000bf9U,
    ERROR_APPEXEC_HOST_ID_MISMATCH                                                 = 0x00000bfaU,
    ERROR_APPEXEC_UNKNOWN_USER                                                     = 0x00000bfbU,
    ERROR_APPEXEC_APP_COMPAT_BLOCK                                                 = 0x00000bfcU,
    ERROR_APPEXEC_CALLER_WAIT_TIMEOUT                                              = 0x00000bfdU,
    ERROR_APPEXEC_CALLER_WAIT_TIMEOUT_TERMINATION                                  = 0x00000bfeU,
    ERROR_APPEXEC_CALLER_WAIT_TIMEOUT_LICENSING                                    = 0x00000bffU,
    ERROR_APPEXEC_CALLER_WAIT_TIMEOUT_RESOURCES                                    = 0x00000c00U,
    ERROR_VRF_VOLATILE_CFG_AND_IO_ENABLED                                          = 0x00000c08U,
    ERROR_VRF_VOLATILE_NOT_STOPPABLE                                               = 0x00000c09U,
    ERROR_VRF_VOLATILE_SAFE_MODE                                                   = 0x00000c0aU,
    ERROR_VRF_VOLATILE_NOT_RUNNABLE_SYSTEM                                         = 0x00000c0bU,
    ERROR_VRF_VOLATILE_NOT_SUPPORTED_RULECLASS                                     = 0x00000c0cU,
    ERROR_VRF_VOLATILE_PROTECTED_DRIVER                                            = 0x00000c0dU,
    ERROR_VRF_VOLATILE_NMI_REGISTERED                                              = 0x00000c0eU,
    ERROR_VRF_VOLATILE_SETTINGS_CONFLICT                                           = 0x00000c0fU,
    ERROR_CAR_LKD_IN_PROGRESS                                                      = 0x00000c10U,
    ERROR_DIF_ZERO_SIZE_INFORMATION                                                = 0x00000c73U,
    ERROR_DIF_DRIVER_PLUGIN_MISMATCH                                               = 0x00000c74U,
    ERROR_DIF_DRIVER_THUNKS_NOT_ALLOWED                                            = 0x00000c75U,
    ERROR_DIF_IOCALLBACK_NOT_REPLACED                                              = 0x00000c76U,
    ERROR_DIF_LIVEDUMP_LIMIT_EXCEEDED                                              = 0x00000c77U,
    ERROR_DIF_VOLATILE_SECTION_NOT_LOCKED                                          = 0x00000c78U,
    ERROR_DIF_VOLATILE_DRIVER_HOTPATCHED                                           = 0x00000c79U,
    ERROR_DIF_VOLATILE_INVALID_INFO                                                = 0x00000c7aU,
    ERROR_DIF_VOLATILE_DRIVER_IS_NOT_RUNNING                                       = 0x00000c7bU,
    ERROR_DIF_VOLATILE_PLUGIN_IS_NOT_RUNNING                                       = 0x00000c7cU,
    ERROR_DIF_VOLATILE_PLUGIN_CHANGE_NOT_ALLOWED                                   = 0x00000c7dU,
    ERROR_DIF_VOLATILE_NOT_ALLOWED                                                 = 0x00000c7eU,
    ERROR_DIF_BINDING_API_NOT_FOUND                                                = 0x00000c7fU,
    ERROR_IO_REISSUE_AS_CACHED                                                     = 0x00000f6eU,
    ERROR_WINS_INTERNAL                                                            = 0x00000fa0U,
    ERROR_CAN_NOT_DEL_LOCAL_WINS                                                   = 0x00000fa1U,
    ERROR_STATIC_INIT                                                              = 0x00000fa2U,
    ERROR_INC_BACKUP                                                               = 0x00000fa3U,
    ERROR_FULL_BACKUP                                                              = 0x00000fa4U,
    ERROR_REC_NON_EXISTENT                                                         = 0x00000fa5U,
    ERROR_RPL_NOT_ALLOWED                                                          = 0x00000fa6U,
    ERROR_DHCP_ADDRESS_CONFLICT                                                    = 0x00001004U,
    ERROR_WMI_GUID_NOT_FOUND                                                       = 0x00001068U,
    ERROR_WMI_INSTANCE_NOT_FOUND                                                   = 0x00001069U,
    ERROR_WMI_ITEMID_NOT_FOUND                                                     = 0x0000106aU,
    ERROR_WMI_TRY_AGAIN                                                            = 0x0000106bU,
    ERROR_WMI_DP_NOT_FOUND                                                         = 0x0000106cU,
    ERROR_WMI_UNRESOLVED_INSTANCE_REF                                              = 0x0000106dU,
    ERROR_WMI_ALREADY_ENABLED                                                      = 0x0000106eU,
    ERROR_WMI_GUID_DISCONNECTED                                                    = 0x0000106fU,
    ERROR_WMI_SERVER_UNAVAILABLE                                                   = 0x00001070U,
    ERROR_WMI_DP_FAILED                                                            = 0x00001071U,
    ERROR_WMI_INVALID_MOF                                                          = 0x00001072U,
    ERROR_WMI_INVALID_REGINFO                                                      = 0x00001073U,
    ERROR_WMI_ALREADY_DISABLED                                                     = 0x00001074U,
    ERROR_WMI_READ_ONLY                                                            = 0x00001075U,
    ERROR_WMI_SET_FAILURE                                                          = 0x00001076U,
    ERROR_NOT_APPCONTAINER                                                         = 0x0000109aU,
    ERROR_APPCONTAINER_REQUIRED                                                    = 0x0000109bU,
    ERROR_NOT_SUPPORTED_IN_APPCONTAINER                                            = 0x0000109cU,
    ERROR_INVALID_PACKAGE_SID_LENGTH                                               = 0x0000109dU,
    ERROR_INVALID_MEDIA                                                            = 0x000010ccU,
    ERROR_INVALID_LIBRARY                                                          = 0x000010cdU,
    ERROR_INVALID_MEDIA_POOL                                                       = 0x000010ceU,
    ERROR_DRIVE_MEDIA_MISMATCH                                                     = 0x000010cfU,
    ERROR_MEDIA_OFFLINE                                                            = 0x000010d0U,
    ERROR_LIBRARY_OFFLINE                                                          = 0x000010d1U,
    ERROR_EMPTY                                                                    = 0x000010d2U,
    ERROR_NOT_EMPTY                                                                = 0x000010d3U,
    ERROR_MEDIA_UNAVAILABLE                                                        = 0x000010d4U,
    ERROR_RESOURCE_DISABLED                                                        = 0x000010d5U,
    ERROR_INVALID_CLEANER                                                          = 0x000010d6U,
    ERROR_UNABLE_TO_CLEAN                                                          = 0x000010d7U,
    ERROR_OBJECT_NOT_FOUND                                                         = 0x000010d8U,
    ERROR_DATABASE_FAILURE                                                         = 0x000010d9U,
    ERROR_DATABASE_FULL                                                            = 0x000010daU,
    ERROR_MEDIA_INCOMPATIBLE                                                       = 0x000010dbU,
    ERROR_RESOURCE_NOT_PRESENT                                                     = 0x000010dcU,
    ERROR_INVALID_OPERATION                                                        = 0x000010ddU,
    ERROR_MEDIA_NOT_AVAILABLE                                                      = 0x000010deU,
    ERROR_DEVICE_NOT_AVAILABLE                                                     = 0x000010dfU,
    ERROR_REQUEST_REFUSED                                                          = 0x000010e0U,
    ERROR_INVALID_DRIVE_OBJECT                                                     = 0x000010e1U,
    ERROR_LIBRARY_FULL                                                             = 0x000010e2U,
    ERROR_MEDIUM_NOT_ACCESSIBLE                                                    = 0x000010e3U,
    ERROR_UNABLE_TO_LOAD_MEDIUM                                                    = 0x000010e4U,
    ERROR_UNABLE_TO_INVENTORY_DRIVE                                                = 0x000010e5U,
    ERROR_UNABLE_TO_INVENTORY_SLOT                                                 = 0x000010e6U,
    ERROR_UNABLE_TO_INVENTORY_TRANSPORT                                            = 0x000010e7U,
    ERROR_TRANSPORT_FULL                                                           = 0x000010e8U,
    ERROR_CONTROLLING_IEPORT                                                       = 0x000010e9U,
    ERROR_UNABLE_TO_EJECT_MOUNTED_MEDIA                                            = 0x000010eaU,
    ERROR_CLEANER_SLOT_SET                                                         = 0x000010ebU,
    ERROR_CLEANER_SLOT_NOT_SET                                                     = 0x000010ecU,
    ERROR_CLEANER_CARTRIDGE_SPENT                                                  = 0x000010edU,
    ERROR_UNEXPECTED_OMID                                                          = 0x000010eeU,
    ERROR_CANT_DELETE_LAST_ITEM                                                    = 0x000010efU,
    ERROR_MESSAGE_EXCEEDS_MAX_SIZE                                                 = 0x000010f0U,
    ERROR_VOLUME_CONTAINS_SYS_FILES                                                = 0x000010f1U,
    ERROR_INDIGENOUS_TYPE                                                          = 0x000010f2U,
    ERROR_NO_SUPPORTING_DRIVES                                                     = 0x000010f3U,
    ERROR_CLEANER_CARTRIDGE_INSTALLED                                              = 0x000010f4U,
    ERROR_IEPORT_FULL                                                              = 0x000010f5U,
    ERROR_FILE_OFFLINE                                                             = 0x000010feU,
    ERROR_REMOTE_STORAGE_NOT_ACTIVE                                                = 0x000010ffU,
    ERROR_REMOTE_STORAGE_MEDIA_ERROR                                               = 0x00001100U,
    ERROR_NOT_A_REPARSE_POINT                                                      = 0x00001126U,
    ERROR_REPARSE_ATTRIBUTE_CONFLICT                                               = 0x00001127U,
    ERROR_INVALID_REPARSE_DATA                                                     = 0x00001128U,
    ERROR_REPARSE_TAG_INVALID                                                      = 0x00001129U,
    ERROR_REPARSE_TAG_MISMATCH                                                     = 0x0000112aU,
    ERROR_REPARSE_POINT_ENCOUNTERED                                                = 0x0000112bU,
    ERROR_APP_DATA_NOT_FOUND                                                       = 0x00001130U,
    ERROR_APP_DATA_EXPIRED                                                         = 0x00001131U,
    ERROR_APP_DATA_CORRUPT                                                         = 0x00001132U,
    ERROR_APP_DATA_LIMIT_EXCEEDED                                                  = 0x00001133U,
    ERROR_APP_DATA_REBOOT_REQUIRED                                                 = 0x00001134U,
    ERROR_SECUREBOOT_ROLLBACK_DETECTED                                             = 0x00001144U,
    ERROR_SECUREBOOT_POLICY_VIOLATION                                              = 0x00001145U,
    ERROR_SECUREBOOT_INVALID_POLICY                                                = 0x00001146U,
    ERROR_SECUREBOOT_POLICY_PUBLISHER_NOT_FOUND                                    = 0x00001147U,
    ERROR_SECUREBOOT_POLICY_NOT_SIGNED                                             = 0x00001148U,
    ERROR_SECUREBOOT_NOT_ENABLED                                                   = 0x00001149U,
    ERROR_SECUREBOOT_FILE_REPLACED                                                 = 0x0000114aU,
    ERROR_SECUREBOOT_POLICY_NOT_AUTHORIZED                                         = 0x0000114bU,
    ERROR_SECUREBOOT_POLICY_UNKNOWN                                                = 0x0000114cU,
    ERROR_SECUREBOOT_POLICY_MISSING_ANTIROLLBACKVERSION                            = 0x0000114dU,
    ERROR_SECUREBOOT_PLATFORM_ID_MISMATCH                                          = 0x0000114eU,
    ERROR_SECUREBOOT_POLICY_ROLLBACK_DETECTED                                      = 0x0000114fU,
    ERROR_SECUREBOOT_POLICY_UPGRADE_MISMATCH                                       = 0x00001150U,
    ERROR_SECUREBOOT_REQUIRED_POLICY_FILE_MISSING                                  = 0x00001151U,
    ERROR_SECUREBOOT_NOT_BASE_POLICY                                               = 0x00001152U,
    ERROR_SECUREBOOT_NOT_SUPPLEMENTAL_POLICY                                       = 0x00001153U,
    ERROR_OFFLOAD_READ_FLT_NOT_SUPPORTED                                           = 0x00001158U,
    ERROR_OFFLOAD_WRITE_FLT_NOT_SUPPORTED                                          = 0x00001159U,
    ERROR_OFFLOAD_READ_FILE_NOT_SUPPORTED                                          = 0x0000115aU,
    ERROR_OFFLOAD_WRITE_FILE_NOT_SUPPORTED                                         = 0x0000115bU,
    ERROR_ALREADY_HAS_STREAM_ID                                                    = 0x0000115cU,
    ERROR_SMR_GARBAGE_COLLECTION_REQUIRED                                          = 0x0000115dU,
    ERROR_WOF_WIM_HEADER_CORRUPT                                                   = 0x0000115eU,
    ERROR_WOF_WIM_RESOURCE_TABLE_CORRUPT                                           = 0x0000115fU,
    ERROR_WOF_FILE_RESOURCE_TABLE_CORRUPT                                          = 0x00001160U,
    ERROR_OBJECT_IS_IMMUTABLE                                                      = 0x00001161U,
    ERROR_VOLUME_NOT_SIS_ENABLED                                                   = 0x00001194U,
    ERROR_SYSTEM_INTEGRITY_ROLLBACK_DETECTED                                       = 0x000011c6U,
    ERROR_SYSTEM_INTEGRITY_POLICY_VIOLATION                                        = 0x000011c7U,
    ERROR_SYSTEM_INTEGRITY_INVALID_POLICY                                          = 0x000011c8U,
    ERROR_SYSTEM_INTEGRITY_POLICY_NOT_SIGNED                                       = 0x000011c9U,
    ERROR_SYSTEM_INTEGRITY_TOO_MANY_POLICIES                                       = 0x000011caU,
    ERROR_SYSTEM_INTEGRITY_SUPPLEMENTAL_POLICY_NOT_AUTHORIZED                      = 0x000011cbU,
    ERROR_SYSTEM_INTEGRITY_REPUTATION_MALICIOUS                                    = 0x000011ccU,
    ERROR_SYSTEM_INTEGRITY_REPUTATION_PUA                                          = 0x000011cdU,
    ERROR_SYSTEM_INTEGRITY_REPUTATION_DANGEROUS_EXT                                = 0x000011ceU,
    ERROR_SYSTEM_INTEGRITY_REPUTATION_OFFLINE                                      = 0x000011cfU,
    ERROR_VSM_NOT_INITIALIZED                                                      = 0x000011d0U,
    ERROR_VSM_DMA_PROTECTION_NOT_IN_USE                                            = 0x000011d1U,
    ERROR_VSM_KEY_CI_POLICY_ROLLBACK_DETECTED                                      = 0x000011d2U,
    ERROR_VSMIDK_KEYGEN_FAILURE                                                    = 0x000011d3U,
    ERROR_VSMIDK_EXPORT_FAILURE                                                    = 0x000011d4U,
    ERROR_VSMIDK_MODULUS_MISMATCH                                                  = 0x000011d5U,
    ERROR_PLATFORM_MANIFEST_NOT_AUTHORIZED                                         = 0x000011daU,
    ERROR_PLATFORM_MANIFEST_INVALID                                                = 0x000011dbU,
    ERROR_PLATFORM_MANIFEST_FILE_NOT_AUTHORIZED                                    = 0x000011dcU,
    ERROR_PLATFORM_MANIFEST_CATALOG_NOT_AUTHORIZED                                 = 0x000011ddU,
    ERROR_PLATFORM_MANIFEST_BINARY_ID_NOT_FOUND                                    = 0x000011deU,
    ERROR_PLATFORM_MANIFEST_NOT_ACTIVE                                             = 0x000011dfU,
    ERROR_PLATFORM_MANIFEST_NOT_SIGNED                                             = 0x000011e0U,
    ERROR_SYSTEM_INTEGRITY_REPUTATION_UNFRIENDLY_FILE                              = 0x000011e4U,
    ERROR_SYSTEM_INTEGRITY_REPUTATION_UNATTAINABLE                                 = 0x000011e5U,
    ERROR_SYSTEM_INTEGRITY_REPUTATION_EXPLICIT_DENY_FILE                           = 0x000011e6U,
    ERROR_SYSTEM_INTEGRITY_WHQL_NOT_SATISFIED                                      = 0x000011e7U,
    ERROR_DEPENDENT_RESOURCE_EXISTS                                                = 0x00001389U,
    ERROR_DEPENDENCY_NOT_FOUND                                                     = 0x0000138aU,
    ERROR_DEPENDENCY_ALREADY_EXISTS                                                = 0x0000138bU,
    ERROR_RESOURCE_NOT_ONLINE                                                      = 0x0000138cU,
    ERROR_HOST_NODE_NOT_AVAILABLE                                                  = 0x0000138dU,
    ERROR_RESOURCE_NOT_AVAILABLE                                                   = 0x0000138eU,
    ERROR_RESOURCE_NOT_FOUND                                                       = 0x0000138fU,
    ERROR_SHUTDOWN_CLUSTER                                                         = 0x00001390U,
    ERROR_CANT_EVICT_ACTIVE_NODE                                                   = 0x00001391U,
    ERROR_OBJECT_ALREADY_EXISTS                                                    = 0x00001392U,
    ERROR_OBJECT_IN_LIST                                                           = 0x00001393U,
    ERROR_GROUP_NOT_AVAILABLE                                                      = 0x00001394U,
    ERROR_GROUP_NOT_FOUND                                                          = 0x00001395U,
    ERROR_GROUP_NOT_ONLINE                                                         = 0x00001396U,
    ERROR_HOST_NODE_NOT_RESOURCE_OWNER                                             = 0x00001397U,
    ERROR_HOST_NODE_NOT_GROUP_OWNER                                                = 0x00001398U,
    ERROR_RESMON_CREATE_FAILED                                                     = 0x00001399U,
    ERROR_RESMON_ONLINE_FAILED                                                     = 0x0000139aU,
    ERROR_RESOURCE_ONLINE                                                          = 0x0000139bU,
    ERROR_QUORUM_RESOURCE                                                          = 0x0000139cU,
    ERROR_NOT_QUORUM_CAPABLE                                                       = 0x0000139dU,
    ERROR_CLUSTER_SHUTTING_DOWN                                                    = 0x0000139eU,
    ERROR_INVALID_STATE                                                            = 0x0000139fU,
    ERROR_RESOURCE_PROPERTIES_STORED                                               = 0x000013a0U,
    ERROR_NOT_QUORUM_CLASS                                                         = 0x000013a1U,
    ERROR_CORE_RESOURCE                                                            = 0x000013a2U,
    ERROR_QUORUM_RESOURCE_ONLINE_FAILED                                            = 0x000013a3U,
    ERROR_QUORUMLOG_OPEN_FAILED                                                    = 0x000013a4U,
    ERROR_CLUSTERLOG_CORRUPT                                                       = 0x000013a5U,
    ERROR_CLUSTERLOG_RECORD_EXCEEDS_MAXSIZE                                        = 0x000013a6U,
    ERROR_CLUSTERLOG_EXCEEDS_MAXSIZE                                               = 0x000013a7U,
    ERROR_CLUSTERLOG_CHKPOINT_NOT_FOUND                                            = 0x000013a8U,
    ERROR_CLUSTERLOG_NOT_ENOUGH_SPACE                                              = 0x000013a9U,
    ERROR_QUORUM_OWNER_ALIVE                                                       = 0x000013aaU,
    ERROR_NETWORK_NOT_AVAILABLE                                                    = 0x000013abU,
    ERROR_NODE_NOT_AVAILABLE                                                       = 0x000013acU,
    ERROR_ALL_NODES_NOT_AVAILABLE                                                  = 0x000013adU,
    ERROR_RESOURCE_FAILED                                                          = 0x000013aeU,
    ERROR_CLUSTER_INVALID_NODE                                                     = 0x000013afU,
    ERROR_CLUSTER_NODE_EXISTS                                                      = 0x000013b0U,
    ERROR_CLUSTER_JOIN_IN_PROGRESS                                                 = 0x000013b1U,
    ERROR_CLUSTER_NODE_NOT_FOUND                                                   = 0x000013b2U,
    ERROR_CLUSTER_LOCAL_NODE_NOT_FOUND                                             = 0x000013b3U,
    ERROR_CLUSTER_NETWORK_EXISTS                                                   = 0x000013b4U,
    ERROR_CLUSTER_NETWORK_NOT_FOUND                                                = 0x000013b5U,
    ERROR_CLUSTER_NETINTERFACE_EXISTS                                              = 0x000013b6U,
    ERROR_CLUSTER_NETINTERFACE_NOT_FOUND                                           = 0x000013b7U,
    ERROR_CLUSTER_INVALID_REQUEST                                                  = 0x000013b8U,
    ERROR_CLUSTER_INVALID_NETWORK_PROVIDER                                         = 0x000013b9U,
    ERROR_CLUSTER_NODE_DOWN                                                        = 0x000013baU,
    ERROR_CLUSTER_NODE_UNREACHABLE                                                 = 0x000013bbU,
    ERROR_CLUSTER_NODE_NOT_MEMBER                                                  = 0x000013bcU,
    ERROR_CLUSTER_JOIN_NOT_IN_PROGRESS                                             = 0x000013bdU,
    ERROR_CLUSTER_INVALID_NETWORK                                                  = 0x000013beU,
    ERROR_CLUSTER_NODE_UP                                                          = 0x000013c0U,
    ERROR_CLUSTER_IPADDR_IN_USE                                                    = 0x000013c1U,
    ERROR_CLUSTER_NODE_NOT_PAUSED                                                  = 0x000013c2U,
    ERROR_CLUSTER_NO_SECURITY_CONTEXT                                              = 0x000013c3U,
    ERROR_CLUSTER_NETWORK_NOT_INTERNAL                                             = 0x000013c4U,
    ERROR_CLUSTER_NODE_ALREADY_UP                                                  = 0x000013c5U,
    ERROR_CLUSTER_NODE_ALREADY_DOWN                                                = 0x000013c6U,
    ERROR_CLUSTER_NETWORK_ALREADY_ONLINE                                           = 0x000013c7U,
    ERROR_CLUSTER_NETWORK_ALREADY_OFFLINE                                          = 0x000013c8U,
    ERROR_CLUSTER_NODE_ALREADY_MEMBER                                              = 0x000013c9U,
    ERROR_CLUSTER_LAST_INTERNAL_NETWORK                                            = 0x000013caU,
    ERROR_CLUSTER_NETWORK_HAS_DEPENDENTS                                           = 0x000013cbU,
    ERROR_INVALID_OPERATION_ON_QUORUM                                              = 0x000013ccU,
    ERROR_DEPENDENCY_NOT_ALLOWED                                                   = 0x000013cdU,
    ERROR_CLUSTER_NODE_PAUSED                                                      = 0x000013ceU,
    ERROR_NODE_CANT_HOST_RESOURCE                                                  = 0x000013cfU,
    ERROR_CLUSTER_NODE_NOT_READY                                                   = 0x000013d0U,
    ERROR_CLUSTER_NODE_SHUTTING_DOWN                                               = 0x000013d1U,
    ERROR_CLUSTER_JOIN_ABORTED                                                     = 0x000013d2U,
    ERROR_CLUSTER_INCOMPATIBLE_VERSIONS                                            = 0x000013d3U,
    ERROR_CLUSTER_MAXNUM_OF_RESOURCES_EXCEEDED                                     = 0x000013d4U,
    ERROR_CLUSTER_SYSTEM_CONFIG_CHANGED                                            = 0x000013d5U,
    ERROR_CLUSTER_RESOURCE_TYPE_NOT_FOUND                                          = 0x000013d6U,
    ERROR_CLUSTER_RESTYPE_NOT_SUPPORTED                                            = 0x000013d7U,
    ERROR_CLUSTER_RESNAME_NOT_FOUND                                                = 0x000013d8U,
    ERROR_CLUSTER_NO_RPC_PACKAGES_REGISTERED                                       = 0x000013d9U,
    ERROR_CLUSTER_OWNER_NOT_IN_PREFLIST                                            = 0x000013daU,
    ERROR_CLUSTER_DATABASE_SEQMISMATCH                                             = 0x000013dbU,
    ERROR_RESMON_INVALID_STATE                                                     = 0x000013dcU,
    ERROR_CLUSTER_GUM_NOT_LOCKER                                                   = 0x000013ddU,
    ERROR_QUORUM_DISK_NOT_FOUND                                                    = 0x000013deU,
    ERROR_DATABASE_BACKUP_CORRUPT                                                  = 0x000013dfU,
    ERROR_CLUSTER_NODE_ALREADY_HAS_DFS_ROOT                                        = 0x000013e0U,
    ERROR_RESOURCE_PROPERTY_UNCHANGEABLE                                           = 0x000013e1U,
    ERROR_NO_ADMIN_ACCESS_POINT                                                    = 0x000013e2U,
    ERROR_CLUSTER_MEMBERSHIP_INVALID_STATE                                         = 0x00001702U,
    ERROR_CLUSTER_QUORUMLOG_NOT_FOUND                                              = 0x00001703U,
    ERROR_CLUSTER_MEMBERSHIP_HALT                                                  = 0x00001704U,
    ERROR_CLUSTER_INSTANCE_ID_MISMATCH                                             = 0x00001705U,
    ERROR_CLUSTER_NETWORK_NOT_FOUND_FOR_IP                                         = 0x00001706U,
    ERROR_CLUSTER_PROPERTY_DATA_TYPE_MISMATCH                                      = 0x00001707U,
    ERROR_CLUSTER_EVICT_WITHOUT_CLEANUP                                            = 0x00001708U,
    ERROR_CLUSTER_PARAMETER_MISMATCH                                               = 0x00001709U,
    ERROR_NODE_CANNOT_BE_CLUSTERED                                                 = 0x0000170aU,
    ERROR_CLUSTER_WRONG_OS_VERSION                                                 = 0x0000170bU,
    ERROR_CLUSTER_CANT_CREATE_DUP_CLUSTER_NAME                                     = 0x0000170cU,
    ERROR_CLUSCFG_ALREADY_COMMITTED                                                = 0x0000170dU,
    ERROR_CLUSCFG_ROLLBACK_FAILED                                                  = 0x0000170eU,
    ERROR_CLUSCFG_SYSTEM_DISK_DRIVE_LETTER_CONFLICT                                = 0x0000170fU,
    ERROR_CLUSTER_OLD_VERSION                                                      = 0x00001710U,
    ERROR_CLUSTER_MISMATCHED_COMPUTER_ACCT_NAME                                    = 0x00001711U,
    ERROR_CLUSTER_NO_NET_ADAPTERS                                                  = 0x00001712U,
    ERROR_CLUSTER_POISONED                                                         = 0x00001713U,
    ERROR_CLUSTER_GROUP_MOVING                                                     = 0x00001714U,
    ERROR_CLUSTER_RESOURCE_TYPE_BUSY                                               = 0x00001715U,
    ERROR_RESOURCE_CALL_TIMED_OUT                                                  = 0x00001716U,
    ERROR_INVALID_CLUSTER_IPV6_ADDRESS                                             = 0x00001717U,
    ERROR_CLUSTER_INTERNAL_INVALID_FUNCTION                                        = 0x00001718U,
    ERROR_CLUSTER_PARAMETER_OUT_OF_BOUNDS                                          = 0x00001719U,
    ERROR_CLUSTER_PARTIAL_SEND                                                     = 0x0000171aU,
    ERROR_CLUSTER_REGISTRY_INVALID_FUNCTION                                        = 0x0000171bU,
    ERROR_CLUSTER_INVALID_STRING_TERMINATION                                       = 0x0000171cU,
    ERROR_CLUSTER_INVALID_STRING_FORMAT                                            = 0x0000171dU,
    ERROR_CLUSTER_DATABASE_TRANSACTION_IN_PROGRESS                                 = 0x0000171eU,
    ERROR_CLUSTER_DATABASE_TRANSACTION_NOT_IN_PROGRESS                             = 0x0000171fU,
    ERROR_CLUSTER_NULL_DATA                                                        = 0x00001720U,
    ERROR_CLUSTER_PARTIAL_READ                                                     = 0x00001721U,
    ERROR_CLUSTER_PARTIAL_WRITE                                                    = 0x00001722U,
    ERROR_CLUSTER_CANT_DESERIALIZE_DATA                                            = 0x00001723U,
    ERROR_DEPENDENT_RESOURCE_PROPERTY_CONFLICT                                     = 0x00001724U,
    ERROR_CLUSTER_NO_QUORUM                                                        = 0x00001725U,
    ERROR_CLUSTER_INVALID_IPV6_NETWORK                                             = 0x00001726U,
    ERROR_CLUSTER_INVALID_IPV6_TUNNEL_NETWORK                                      = 0x00001727U,
    ERROR_QUORUM_NOT_ALLOWED_IN_THIS_GROUP                                         = 0x00001728U,
    ERROR_DEPENDENCY_TREE_TOO_COMPLEX                                              = 0x00001729U,
    ERROR_EXCEPTION_IN_RESOURCE_CALL                                               = 0x0000172aU,
    ERROR_CLUSTER_RHS_FAILED_INITIALIZATION                                        = 0x0000172bU,
    ERROR_CLUSTER_NOT_INSTALLED                                                    = 0x0000172cU,
    ERROR_CLUSTER_RESOURCES_MUST_BE_ONLINE_ON_THE_SAME_NODE                        = 0x0000172dU,
    ERROR_CLUSTER_MAX_NODES_IN_CLUSTER                                             = 0x0000172eU,
    ERROR_CLUSTER_TOO_MANY_NODES                                                   = 0x0000172fU,
    ERROR_CLUSTER_OBJECT_ALREADY_USED                                              = 0x00001730U,
    ERROR_NONCORE_GROUPS_FOUND                                                     = 0x00001731U,
    ERROR_FILE_SHARE_RESOURCE_CONFLICT                                             = 0x00001732U,
    ERROR_CLUSTER_EVICT_INVALID_REQUEST                                            = 0x00001733U,
    ERROR_CLUSTER_SINGLETON_RESOURCE                                               = 0x00001734U,
    ERROR_CLUSTER_GROUP_SINGLETON_RESOURCE                                         = 0x00001735U,
    ERROR_CLUSTER_RESOURCE_PROVIDER_FAILED                                         = 0x00001736U,
    ERROR_CLUSTER_RESOURCE_CONFIGURATION_ERROR                                     = 0x00001737U,
    ERROR_CLUSTER_GROUP_BUSY                                                       = 0x00001738U,
    ERROR_CLUSTER_NOT_SHARED_VOLUME                                                = 0x00001739U,
    ERROR_CLUSTER_INVALID_SECURITY_DESCRIPTOR                                      = 0x0000173aU,
    ERROR_CLUSTER_SHARED_VOLUMES_IN_USE                                            = 0x0000173bU,
    ERROR_CLUSTER_USE_SHARED_VOLUMES_API                                           = 0x0000173cU,
    ERROR_CLUSTER_BACKUP_IN_PROGRESS                                               = 0x0000173dU,
    ERROR_NON_CSV_PATH                                                             = 0x0000173eU,
    ERROR_CSV_VOLUME_NOT_LOCAL                                                     = 0x0000173fU,
    ERROR_CLUSTER_WATCHDOG_TERMINATING                                             = 0x00001740U,
    ERROR_CLUSTER_RESOURCE_VETOED_MOVE_INCOMPATIBLE_NODES                          = 0x00001741U,
    ERROR_CLUSTER_INVALID_NODE_WEIGHT                                              = 0x00001742U,
    ERROR_CLUSTER_RESOURCE_VETOED_CALL                                             = 0x00001743U,
    ERROR_RESMON_SYSTEM_RESOURCES_LACKING                                          = 0x00001744U,
    ERROR_CLUSTER_RESOURCE_VETOED_MOVE_NOT_ENOUGH_RESOURCES_ON_DESTINATION         = 0x00001745U,
    ERROR_CLUSTER_RESOURCE_VETOED_MOVE_NOT_ENOUGH_RESOURCES_ON_SOURCE              = 0x00001746U,
    ERROR_CLUSTER_GROUP_QUEUED                                                     = 0x00001747U,
    ERROR_CLUSTER_RESOURCE_LOCKED_STATUS                                           = 0x00001748U,
    ERROR_CLUSTER_SHARED_VOLUME_FAILOVER_NOT_ALLOWED                               = 0x00001749U,
    ERROR_CLUSTER_NODE_DRAIN_IN_PROGRESS                                           = 0x0000174aU,
    ERROR_CLUSTER_DISK_NOT_CONNECTED                                               = 0x0000174bU,
    ERROR_DISK_NOT_CSV_CAPABLE                                                     = 0x0000174cU,
    ERROR_RESOURCE_NOT_IN_AVAILABLE_STORAGE                                        = 0x0000174dU,
    ERROR_CLUSTER_SHARED_VOLUME_REDIRECTED                                         = 0x0000174eU,
    ERROR_CLUSTER_SHARED_VOLUME_NOT_REDIRECTED                                     = 0x0000174fU,
    ERROR_CLUSTER_CANNOT_RETURN_PROPERTIES                                         = 0x00001750U,
    ERROR_CLUSTER_RESOURCE_CONTAINS_UNSUPPORTED_DIFF_AREA_FOR_SHARED_VOLUMES       = 0x00001751U,
    ERROR_CLUSTER_RESOURCE_IS_IN_MAINTENANCE_MODE                                  = 0x00001752U,
    ERROR_CLUSTER_AFFINITY_CONFLICT                                                = 0x00001753U,
    ERROR_CLUSTER_RESOURCE_IS_REPLICA_VIRTUAL_MACHINE                              = 0x00001754U,
    ERROR_CLUSTER_UPGRADE_INCOMPATIBLE_VERSIONS                                    = 0x00001755U,
    ERROR_CLUSTER_UPGRADE_FIX_QUORUM_NOT_SUPPORTED                                 = 0x00001756U,
    ERROR_CLUSTER_UPGRADE_RESTART_REQUIRED                                         = 0x00001757U,
    ERROR_CLUSTER_UPGRADE_IN_PROGRESS                                              = 0x00001758U,
    ERROR_CLUSTER_UPGRADE_INCOMPLETE                                               = 0x00001759U,
    ERROR_CLUSTER_NODE_IN_GRACE_PERIOD                                             = 0x0000175aU,
    ERROR_CLUSTER_CSV_IO_PAUSE_TIMEOUT                                             = 0x0000175bU,
    ERROR_NODE_NOT_ACTIVE_CLUSTER_MEMBER                                           = 0x0000175cU,
    ERROR_CLUSTER_RESOURCE_NOT_MONITORED                                           = 0x0000175dU,
    ERROR_CLUSTER_RESOURCE_DOES_NOT_SUPPORT_UNMONITORED                            = 0x0000175eU,
    ERROR_CLUSTER_RESOURCE_IS_REPLICATED                                           = 0x0000175fU,
    ERROR_CLUSTER_NODE_ISOLATED                                                    = 0x00001760U,
    ERROR_CLUSTER_NODE_QUARANTINED                                                 = 0x00001761U,
    ERROR_CLUSTER_DATABASE_UPDATE_CONDITION_FAILED                                 = 0x00001762U,
    ERROR_CLUSTER_SPACE_DEGRADED                                                   = 0x00001763U,
    ERROR_CLUSTER_TOKEN_DELEGATION_NOT_SUPPORTED                                   = 0x00001764U,
    ERROR_CLUSTER_CSV_INVALID_HANDLE                                               = 0x00001765U,
    ERROR_CLUSTER_CSV_SUPPORTED_ONLY_ON_COORDINATOR                                = 0x00001766U,
    ERROR_GROUPSET_NOT_AVAILABLE                                                   = 0x00001767U,
    ERROR_GROUPSET_NOT_FOUND                                                       = 0x00001768U,
    ERROR_GROUPSET_CANT_PROVIDE                                                    = 0x00001769U,
    ERROR_CLUSTER_FAULT_DOMAIN_PARENT_NOT_FOUND                                    = 0x0000176aU,
    ERROR_CLUSTER_FAULT_DOMAIN_INVALID_HIERARCHY                                   = 0x0000176bU,
    ERROR_CLUSTER_FAULT_DOMAIN_FAILED_S2D_VALIDATION                               = 0x0000176cU,
    ERROR_CLUSTER_FAULT_DOMAIN_S2D_CONNECTIVITY_LOSS                               = 0x0000176dU,
    ERROR_CLUSTER_INVALID_INFRASTRUCTURE_FILESERVER_NAME                           = 0x0000176eU,
    ERROR_CLUSTERSET_MANAGEMENT_CLUSTER_UNREACHABLE                                = 0x0000176fU,
    ERROR_ENCRYPTION_FAILED                                                        = 0x00001770U,
    ERROR_DECRYPTION_FAILED                                                        = 0x00001771U,
    ERROR_FILE_ENCRYPTED                                                           = 0x00001772U,
    ERROR_NO_RECOVERY_POLICY                                                       = 0x00001773U,
    ERROR_NO_EFS                                                                   = 0x00001774U,
    ERROR_WRONG_EFS                                                                = 0x00001775U,
    ERROR_NO_USER_KEYS                                                             = 0x00001776U,
    ERROR_FILE_NOT_ENCRYPTED                                                       = 0x00001777U,
    ERROR_NOT_EXPORT_FORMAT                                                        = 0x00001778U,
    ERROR_FILE_READ_ONLY                                                           = 0x00001779U,
    ERROR_DIR_EFS_DISALLOWED                                                       = 0x0000177aU,
    ERROR_EFS_SERVER_NOT_TRUSTED                                                   = 0x0000177bU,
    ERROR_BAD_RECOVERY_POLICY                                                      = 0x0000177cU,
    ERROR_EFS_ALG_BLOB_TOO_BIG                                                     = 0x0000177dU,
    ERROR_VOLUME_NOT_SUPPORT_EFS                                                   = 0x0000177eU,
    ERROR_EFS_DISABLED                                                             = 0x0000177fU,
    ERROR_EFS_VERSION_NOT_SUPPORT                                                  = 0x00001780U,
    ERROR_CS_ENCRYPTION_INVALID_SERVER_RESPONSE                                    = 0x00001781U,
    ERROR_CS_ENCRYPTION_UNSUPPORTED_SERVER                                         = 0x00001782U,
    ERROR_CS_ENCRYPTION_EXISTING_ENCRYPTED_FILE                                    = 0x00001783U,
    ERROR_CS_ENCRYPTION_NEW_ENCRYPTED_FILE                                         = 0x00001784U,
    ERROR_CS_ENCRYPTION_FILE_NOT_CSE                                               = 0x00001785U,
    ERROR_ENCRYPTION_POLICY_DENIES_OPERATION                                       = 0x00001786U,
    ERROR_WIP_ENCRYPTION_FAILED                                                    = 0x00001787U,
    ERROR_PDE_ENCRYPTION_UNAVAILABLE_FAILURE                                       = 0x00001788U,
    ERROR_PDE_DECRYPTION_UNAVAILABLE_FAILURE                                       = 0x00001789U,
    ERROR_PDE_DECRYPTION_UNAVAILABLE                                               = 0x0000178aU,
    ERROR_NO_BROWSER_SERVERS_FOUND                                                 = 0x000017e6U,
    ERROR_CLUSTER_OBJECT_IS_CLUSTER_SET_VM                                         = 0x0000186aU,
    ERROR_CNU_TEMPLATE_ALREADY_EXISTS                                              = 0x0000186bU,
    ERROR_CNU_TEMPLATE_NAME_NOT_FOUND                                              = 0x0000186cU,
    ERROR_CNU_RUN_NAME_NOT_FOUND                                                   = 0x0000186dU,
    ERROR_CNU_RUN_ALREADY_IN_PROGRESS                                              = 0x0000186eU,
    ERROR_CNU_RUN_NOT_IN_PROGRESS                                                  = 0x0000186fU,
    ERROR_CNU_NOT_READY                                                            = 0x00001870U,
    ERROR_CAMERA_INVALID_CONFIGURATION                                             = 0x000018ceU,
    ERROR_CAMERA_INSUFFICIENT_BANDWIDTH                                            = 0x000018cfU,
    ERROR_LOG_SECTOR_INVALID                                                       = 0x000019c8U,
    ERROR_LOG_SECTOR_PARITY_INVALID                                                = 0x000019c9U,
    ERROR_LOG_SECTOR_REMAPPED                                                      = 0x000019caU,
    ERROR_LOG_BLOCK_INCOMPLETE                                                     = 0x000019cbU,
    ERROR_LOG_INVALID_RANGE                                                        = 0x000019ccU,
    ERROR_LOG_BLOCKS_EXHAUSTED                                                     = 0x000019cdU,
    ERROR_LOG_READ_CONTEXT_INVALID                                                 = 0x000019ceU,
    ERROR_LOG_RESTART_INVALID                                                      = 0x000019cfU,
    ERROR_LOG_BLOCK_VERSION                                                        = 0x000019d0U,
    ERROR_LOG_BLOCK_INVALID                                                        = 0x000019d1U,
    ERROR_LOG_READ_MODE_INVALID                                                    = 0x000019d2U,
    ERROR_LOG_NO_RESTART                                                           = 0x000019d3U,
    ERROR_LOG_METADATA_CORRUPT                                                     = 0x000019d4U,
    ERROR_LOG_METADATA_INVALID                                                     = 0x000019d5U,
    ERROR_LOG_METADATA_INCONSISTENT                                                = 0x000019d6U,
    ERROR_LOG_RESERVATION_INVALID                                                  = 0x000019d7U,
    ERROR_LOG_CANT_DELETE                                                          = 0x000019d8U,
    ERROR_LOG_CONTAINER_LIMIT_EXCEEDED                                             = 0x000019d9U,
    ERROR_LOG_START_OF_LOG                                                         = 0x000019daU,
    ERROR_LOG_POLICY_ALREADY_INSTALLED                                             = 0x000019dbU,
    ERROR_LOG_POLICY_NOT_INSTALLED                                                 = 0x000019dcU,
    ERROR_LOG_POLICY_INVALID                                                       = 0x000019ddU,
    ERROR_LOG_POLICY_CONFLICT                                                      = 0x000019deU,
    ERROR_LOG_PINNED_ARCHIVE_TAIL                                                  = 0x000019dfU,
    ERROR_LOG_RECORD_NONEXISTENT                                                   = 0x000019e0U,
    ERROR_LOG_RECORDS_RESERVED_INVALID                                             = 0x000019e1U,
    ERROR_LOG_SPACE_RESERVED_INVALID                                               = 0x000019e2U,
    ERROR_LOG_TAIL_INVALID                                                         = 0x000019e3U,
    ERROR_LOG_FULL                                                                 = 0x000019e4U,
    ERROR_COULD_NOT_RESIZE_LOG                                                     = 0x000019e5U,
    ERROR_LOG_MULTIPLEXED                                                          = 0x000019e6U,
    ERROR_LOG_DEDICATED                                                            = 0x000019e7U,
    ERROR_LOG_ARCHIVE_NOT_IN_PROGRESS                                              = 0x000019e8U,
    ERROR_LOG_ARCHIVE_IN_PROGRESS                                                  = 0x000019e9U,
    ERROR_LOG_EPHEMERAL                                                            = 0x000019eaU,
    ERROR_LOG_NOT_ENOUGH_CONTAINERS                                                = 0x000019ebU,
    ERROR_LOG_CLIENT_ALREADY_REGISTERED                                            = 0x000019ecU,
    ERROR_LOG_CLIENT_NOT_REGISTERED                                                = 0x000019edU,
    ERROR_LOG_FULL_HANDLER_IN_PROGRESS                                             = 0x000019eeU,
    ERROR_LOG_CONTAINER_READ_FAILED                                                = 0x000019efU,
    ERROR_LOG_CONTAINER_WRITE_FAILED                                               = 0x000019f0U,
    ERROR_LOG_CONTAINER_OPEN_FAILED                                                = 0x000019f1U,
    ERROR_LOG_CONTAINER_STATE_INVALID                                              = 0x000019f2U,
    ERROR_LOG_STATE_INVALID                                                        = 0x000019f3U,
    ERROR_LOG_PINNED                                                               = 0x000019f4U,
    ERROR_LOG_METADATA_FLUSH_FAILED                                                = 0x000019f5U,
    ERROR_LOG_INCONSISTENT_SECURITY                                                = 0x000019f6U,
    ERROR_LOG_APPENDED_FLUSH_FAILED                                                = 0x000019f7U,
    ERROR_LOG_PINNED_RESERVATION                                                   = 0x000019f8U,
    ERROR_INVALID_TRANSACTION                                                      = 0x00001a2cU,
    ERROR_TRANSACTION_NOT_ACTIVE                                                   = 0x00001a2dU,
    ERROR_TRANSACTION_REQUEST_NOT_VALID                                            = 0x00001a2eU,
    ERROR_TRANSACTION_NOT_REQUESTED                                                = 0x00001a2fU,
    ERROR_TRANSACTION_ALREADY_ABORTED                                              = 0x00001a30U,
    ERROR_TRANSACTION_ALREADY_COMMITTED                                            = 0x00001a31U,
    ERROR_TM_INITIALIZATION_FAILED                                                 = 0x00001a32U,
    ERROR_RESOURCEMANAGER_READ_ONLY                                                = 0x00001a33U,
    ERROR_TRANSACTION_NOT_JOINED                                                   = 0x00001a34U,
    ERROR_TRANSACTION_SUPERIOR_EXISTS                                              = 0x00001a35U,
    ERROR_CRM_PROTOCOL_ALREADY_EXISTS                                              = 0x00001a36U,
    ERROR_TRANSACTION_PROPAGATION_FAILED                                           = 0x00001a37U,
    ERROR_CRM_PROTOCOL_NOT_FOUND                                                   = 0x00001a38U,
    ERROR_TRANSACTION_INVALID_MARSHALL_BUFFER                                      = 0x00001a39U,
    ERROR_CURRENT_TRANSACTION_NOT_VALID                                            = 0x00001a3aU,
    ERROR_TRANSACTION_NOT_FOUND                                                    = 0x00001a3bU,
    ERROR_RESOURCEMANAGER_NOT_FOUND                                                = 0x00001a3cU,
    ERROR_ENLISTMENT_NOT_FOUND                                                     = 0x00001a3dU,
    ERROR_TRANSACTIONMANAGER_NOT_FOUND                                             = 0x00001a3eU,
    ERROR_TRANSACTIONMANAGER_NOT_ONLINE                                            = 0x00001a3fU,
    ERROR_TRANSACTIONMANAGER_RECOVERY_NAME_COLLISION                               = 0x00001a40U,
    ERROR_TRANSACTION_NOT_ROOT                                                     = 0x00001a41U,
    ERROR_TRANSACTION_OBJECT_EXPIRED                                               = 0x00001a42U,
    ERROR_TRANSACTION_RESPONSE_NOT_ENLISTED                                        = 0x00001a43U,
    ERROR_TRANSACTION_RECORD_TOO_LONG                                              = 0x00001a44U,
    ERROR_IMPLICIT_TRANSACTION_NOT_SUPPORTED                                       = 0x00001a45U,
    ERROR_TRANSACTION_INTEGRITY_VIOLATED                                           = 0x00001a46U,
    ERROR_TRANSACTIONMANAGER_IDENTITY_MISMATCH                                     = 0x00001a47U,
    ERROR_RM_CANNOT_BE_FROZEN_FOR_SNAPSHOT                                         = 0x00001a48U,
    ERROR_TRANSACTION_MUST_WRITETHROUGH                                            = 0x00001a49U,
    ERROR_TRANSACTION_NO_SUPERIOR                                                  = 0x00001a4aU,
    ERROR_HEURISTIC_DAMAGE_POSSIBLE                                                = 0x00001a4bU,
    ERROR_TRANSACTIONAL_CONFLICT                                                   = 0x00001a90U,
    ERROR_RM_NOT_ACTIVE                                                            = 0x00001a91U,
    ERROR_RM_METADATA_CORRUPT                                                      = 0x00001a92U,
    ERROR_DIRECTORY_NOT_RM                                                         = 0x00001a93U,
    ERROR_TRANSACTIONS_UNSUPPORTED_REMOTE                                          = 0x00001a95U,
    ERROR_LOG_RESIZE_INVALID_SIZE                                                  = 0x00001a96U,
    ERROR_OBJECT_NO_LONGER_EXISTS                                                  = 0x00001a97U,
    ERROR_STREAM_MINIVERSION_NOT_FOUND                                             = 0x00001a98U,
    ERROR_STREAM_MINIVERSION_NOT_VALID                                             = 0x00001a99U,
    ERROR_MINIVERSION_INACCESSIBLE_FROM_SPECIFIED_TRANSACTION                      = 0x00001a9aU,
    ERROR_CANT_OPEN_MINIVERSION_WITH_MODIFY_INTENT                                 = 0x00001a9bU,
    ERROR_CANT_CREATE_MORE_STREAM_MINIVERSIONS                                     = 0x00001a9cU,
    ERROR_REMOTE_FILE_VERSION_MISMATCH                                             = 0x00001a9eU,
    ERROR_HANDLE_NO_LONGER_VALID                                                   = 0x00001a9fU,
    ERROR_NO_TXF_METADATA                                                          = 0x00001aa0U,
    ERROR_LOG_CORRUPTION_DETECTED                                                  = 0x00001aa1U,
    ERROR_CANT_RECOVER_WITH_HANDLE_OPEN                                            = 0x00001aa2U,
    ERROR_RM_DISCONNECTED                                                          = 0x00001aa3U,
    ERROR_ENLISTMENT_NOT_SUPERIOR                                                  = 0x00001aa4U,
    ERROR_RECOVERY_NOT_NEEDED                                                      = 0x00001aa5U,
    ERROR_RM_ALREADY_STARTED                                                       = 0x00001aa6U,
    ERROR_FILE_IDENTITY_NOT_PERSISTENT                                             = 0x00001aa7U,
    ERROR_CANT_BREAK_TRANSACTIONAL_DEPENDENCY                                      = 0x00001aa8U,
    ERROR_CANT_CROSS_RM_BOUNDARY                                                   = 0x00001aa9U,
    ERROR_TXF_DIR_NOT_EMPTY                                                        = 0x00001aaaU,
    ERROR_INDOUBT_TRANSACTIONS_EXIST                                               = 0x00001aabU,
    ERROR_TM_VOLATILE                                                              = 0x00001aacU,
    ERROR_ROLLBACK_TIMER_EXPIRED                                                   = 0x00001aadU,
    ERROR_TXF_ATTRIBUTE_CORRUPT                                                    = 0x00001aaeU,
    ERROR_EFS_NOT_ALLOWED_IN_TRANSACTION                                           = 0x00001aafU,
    ERROR_TRANSACTIONAL_OPEN_NOT_ALLOWED                                           = 0x00001ab0U,
    ERROR_LOG_GROWTH_FAILED                                                        = 0x00001ab1U,
    ERROR_TRANSACTED_MAPPING_UNSUPPORTED_REMOTE                                    = 0x00001ab2U,
    ERROR_TXF_METADATA_ALREADY_PRESENT                                             = 0x00001ab3U,
    ERROR_TRANSACTION_SCOPE_CALLBACKS_NOT_SET                                      = 0x00001ab4U,
    ERROR_TRANSACTION_REQUIRED_PROMOTION                                           = 0x00001ab5U,
    ERROR_CANNOT_EXECUTE_FILE_IN_TRANSACTION                                       = 0x00001ab6U,
    ERROR_TRANSACTIONS_NOT_FROZEN                                                  = 0x00001ab7U,
    ERROR_TRANSACTION_FREEZE_IN_PROGRESS                                           = 0x00001ab8U,
    ERROR_NOT_SNAPSHOT_VOLUME                                                      = 0x00001ab9U,
    ERROR_NO_SAVEPOINT_WITH_OPEN_FILES                                             = 0x00001abaU,
    ERROR_DATA_LOST_REPAIR                                                         = 0x00001abbU,
    ERROR_SPARSE_NOT_ALLOWED_IN_TRANSACTION                                        = 0x00001abcU,
    ERROR_TM_IDENTITY_MISMATCH                                                     = 0x00001abdU,
    ERROR_FLOATED_SECTION                                                          = 0x00001abeU,
    ERROR_CANNOT_ACCEPT_TRANSACTED_WORK                                            = 0x00001abfU,
    ERROR_CANNOT_ABORT_TRANSACTIONS                                                = 0x00001ac0U,
    ERROR_BAD_CLUSTERS                                                             = 0x00001ac1U,
    ERROR_COMPRESSION_NOT_ALLOWED_IN_TRANSACTION                                   = 0x00001ac2U,
    ERROR_VOLUME_DIRTY                                                             = 0x00001ac3U,
    ERROR_NO_LINK_TRACKING_IN_TRANSACTION                                          = 0x00001ac4U,
    ERROR_OPERATION_NOT_SUPPORTED_IN_TRANSACTION                                   = 0x00001ac5U,
    ERROR_EXPIRED_HANDLE                                                           = 0x00001ac6U,
    ERROR_TRANSACTION_NOT_ENLISTED                                                 = 0x00001ac7U,
    ERROR_ENLISTMENT_NOT_INITIALIZED                                               = 0x00001ac8U,
    ERROR_CTX_WINSTATION_NAME_INVALID                                              = 0x00001b59U,
    ERROR_CTX_INVALID_PD                                                           = 0x00001b5aU,
    ERROR_CTX_PD_NOT_FOUND                                                         = 0x00001b5bU,
    ERROR_CTX_WD_NOT_FOUND                                                         = 0x00001b5cU,
    ERROR_CTX_CANNOT_MAKE_EVENTLOG_ENTRY                                           = 0x00001b5dU,
    ERROR_CTX_SERVICE_NAME_COLLISION                                               = 0x00001b5eU,
    ERROR_CTX_CLOSE_PENDING                                                        = 0x00001b5fU,
    ERROR_CTX_NO_OUTBUF                                                            = 0x00001b60U,
    ERROR_CTX_MODEM_INF_NOT_FOUND                                                  = 0x00001b61U,
    ERROR_CTX_INVALID_MODEMNAME                                                    = 0x00001b62U,
    ERROR_CTX_MODEM_RESPONSE_ERROR                                                 = 0x00001b63U,
    ERROR_CTX_MODEM_RESPONSE_TIMEOUT                                               = 0x00001b64U,
    ERROR_CTX_MODEM_RESPONSE_NO_CARRIER                                            = 0x00001b65U,
    ERROR_CTX_MODEM_RESPONSE_NO_DIALTONE                                           = 0x00001b66U,
    ERROR_CTX_MODEM_RESPONSE_BUSY                                                  = 0x00001b67U,
    ERROR_CTX_MODEM_RESPONSE_VOICE                                                 = 0x00001b68U,
    ERROR_CTX_TD_ERROR                                                             = 0x00001b69U,
    ERROR_CTX_WINSTATION_NOT_FOUND                                                 = 0x00001b6eU,
    ERROR_CTX_WINSTATION_ALREADY_EXISTS                                            = 0x00001b6fU,
    ERROR_CTX_WINSTATION_BUSY                                                      = 0x00001b70U,
    ERROR_CTX_BAD_VIDEO_MODE                                                       = 0x00001b71U,
    ERROR_CTX_GRAPHICS_INVALID                                                     = 0x00001b7bU,
    ERROR_CTX_LOGON_DISABLED                                                       = 0x00001b7dU,
    ERROR_CTX_NOT_CONSOLE                                                          = 0x00001b7eU,
    ERROR_CTX_CLIENT_QUERY_TIMEOUT                                                 = 0x00001b80U,
    ERROR_CTX_CONSOLE_DISCONNECT                                                   = 0x00001b81U,
    ERROR_CTX_CONSOLE_CONNECT                                                      = 0x00001b82U,
    ERROR_CTX_SHADOW_DENIED                                                        = 0x00001b84U,
    ERROR_CTX_WINSTATION_ACCESS_DENIED                                             = 0x00001b85U,
    ERROR_CTX_INVALID_WD                                                           = 0x00001b89U,
    ERROR_CTX_SHADOW_INVALID                                                       = 0x00001b8aU,
    ERROR_CTX_SHADOW_DISABLED                                                      = 0x00001b8bU,
    ERROR_CTX_CLIENT_LICENSE_IN_USE                                                = 0x00001b8cU,
    ERROR_CTX_CLIENT_LICENSE_NOT_SET                                               = 0x00001b8dU,
    ERROR_CTX_LICENSE_NOT_AVAILABLE                                                = 0x00001b8eU,
    ERROR_CTX_LICENSE_CLIENT_INVALID                                               = 0x00001b8fU,
    ERROR_CTX_LICENSE_EXPIRED                                                      = 0x00001b90U,
    ERROR_CTX_SHADOW_NOT_RUNNING                                                   = 0x00001b91U,
    ERROR_CTX_SHADOW_ENDED_BY_MODE_CHANGE                                          = 0x00001b92U,
    ERROR_ACTIVATION_COUNT_EXCEEDED                                                = 0x00001b93U,
    ERROR_CTX_WINSTATIONS_DISABLED                                                 = 0x00001b94U,
    ERROR_CTX_ENCRYPTION_LEVEL_REQUIRED                                            = 0x00001b95U,
    ERROR_CTX_SESSION_IN_USE                                                       = 0x00001b96U,
    ERROR_CTX_NO_FORCE_LOGOFF                                                      = 0x00001b97U,
    ERROR_CTX_ACCOUNT_RESTRICTION                                                  = 0x00001b98U,
    ERROR_RDP_PROTOCOL_ERROR                                                       = 0x00001b99U,
    ERROR_CTX_CDM_CONNECT                                                          = 0x00001b9aU,
    ERROR_CTX_CDM_DISCONNECT                                                       = 0x00001b9bU,
    ERROR_CTX_SECURITY_LAYER_ERROR                                                 = 0x00001b9cU,
    ERROR_TS_INCOMPATIBLE_SESSIONS                                                 = 0x00001b9dU,
    ERROR_TS_VIDEO_SUBSYSTEM_ERROR                                                 = 0x00001b9eU,
    ERROR_DS_NOT_INSTALLED                                                         = 0x00002008U,
    ERROR_DS_MEMBERSHIP_EVALUATED_LOCALLY                                          = 0x00002009U,
    ERROR_DS_NO_ATTRIBUTE_OR_VALUE                                                 = 0x0000200aU,
    ERROR_DS_INVALID_ATTRIBUTE_SYNTAX                                              = 0x0000200bU,
    ERROR_DS_ATTRIBUTE_TYPE_UNDEFINED                                              = 0x0000200cU,
    ERROR_DS_ATTRIBUTE_OR_VALUE_EXISTS                                             = 0x0000200dU,
    ERROR_DS_BUSY                                                                  = 0x0000200eU,
    ERROR_DS_UNAVAILABLE                                                           = 0x0000200fU,
    ERROR_DS_NO_RIDS_ALLOCATED                                                     = 0x00002010U,
    ERROR_DS_NO_MORE_RIDS                                                          = 0x00002011U,
    ERROR_DS_INCORRECT_ROLE_OWNER                                                  = 0x00002012U,
    ERROR_DS_RIDMGR_INIT_ERROR                                                     = 0x00002013U,
    ERROR_DS_OBJ_CLASS_VIOLATION                                                   = 0x00002014U,
    ERROR_DS_CANT_ON_NON_LEAF                                                      = 0x00002015U,
    ERROR_DS_CANT_ON_RDN                                                           = 0x00002016U,
    ERROR_DS_CANT_MOD_OBJ_CLASS                                                    = 0x00002017U,
    ERROR_DS_CROSS_DOM_MOVE_ERROR                                                  = 0x00002018U,
    ERROR_DS_GC_NOT_AVAILABLE                                                      = 0x00002019U,
    ERROR_SHARED_POLICY                                                            = 0x0000201aU,
    ERROR_POLICY_OBJECT_NOT_FOUND                                                  = 0x0000201bU,
    ERROR_POLICY_ONLY_IN_DS                                                        = 0x0000201cU,
    ERROR_PROMOTION_ACTIVE                                                         = 0x0000201dU,
    ERROR_NO_PROMOTION_ACTIVE                                                      = 0x0000201eU,
    ERROR_DS_OPERATIONS_ERROR                                                      = 0x00002020U,
    ERROR_DS_PROTOCOL_ERROR                                                        = 0x00002021U,
    ERROR_DS_TIMELIMIT_EXCEEDED                                                    = 0x00002022U,
    ERROR_DS_SIZELIMIT_EXCEEDED                                                    = 0x00002023U,
    ERROR_DS_ADMIN_LIMIT_EXCEEDED                                                  = 0x00002024U,
    ERROR_DS_COMPARE_FALSE                                                         = 0x00002025U,
    ERROR_DS_COMPARE_TRUE                                                          = 0x00002026U,
    ERROR_DS_AUTH_METHOD_NOT_SUPPORTED                                             = 0x00002027U,
    ERROR_DS_STRONG_AUTH_REQUIRED                                                  = 0x00002028U,
    ERROR_DS_INAPPROPRIATE_AUTH                                                    = 0x00002029U,
    ERROR_DS_AUTH_UNKNOWN                                                          = 0x0000202aU,
    ERROR_DS_REFERRAL                                                              = 0x0000202bU,
    ERROR_DS_UNAVAILABLE_CRIT_EXTENSION                                            = 0x0000202cU,
    ERROR_DS_CONFIDENTIALITY_REQUIRED                                              = 0x0000202dU,
    ERROR_DS_INAPPROPRIATE_MATCHING                                                = 0x0000202eU,
    ERROR_DS_CONSTRAINT_VIOLATION                                                  = 0x0000202fU,
    ERROR_DS_NO_SUCH_OBJECT                                                        = 0x00002030U,
    ERROR_DS_ALIAS_PROBLEM                                                         = 0x00002031U,
    ERROR_DS_INVALID_DN_SYNTAX                                                     = 0x00002032U,
    ERROR_DS_IS_LEAF                                                               = 0x00002033U,
    ERROR_DS_ALIAS_DEREF_PROBLEM                                                   = 0x00002034U,
    ERROR_DS_UNWILLING_TO_PERFORM                                                  = 0x00002035U,
    ERROR_DS_LOOP_DETECT                                                           = 0x00002036U,
    ERROR_DS_NAMING_VIOLATION                                                      = 0x00002037U,
    ERROR_DS_OBJECT_RESULTS_TOO_LARGE                                              = 0x00002038U,
    ERROR_DS_AFFECTS_MULTIPLE_DSAS                                                 = 0x00002039U,
    ERROR_DS_SERVER_DOWN                                                           = 0x0000203aU,
    ERROR_DS_LOCAL_ERROR                                                           = 0x0000203bU,
    ERROR_DS_ENCODING_ERROR                                                        = 0x0000203cU,
    ERROR_DS_DECODING_ERROR                                                        = 0x0000203dU,
    ERROR_DS_FILTER_UNKNOWN                                                        = 0x0000203eU,
    ERROR_DS_PARAM_ERROR                                                           = 0x0000203fU,
    ERROR_DS_NOT_SUPPORTED                                                         = 0x00002040U,
    ERROR_DS_NO_RESULTS_RETURNED                                                   = 0x00002041U,
    ERROR_DS_CONTROL_NOT_FOUND                                                     = 0x00002042U,
    ERROR_DS_CLIENT_LOOP                                                           = 0x00002043U,
    ERROR_DS_REFERRAL_LIMIT_EXCEEDED                                               = 0x00002044U,
    ERROR_DS_SORT_CONTROL_MISSING                                                  = 0x00002045U,
    ERROR_DS_OFFSET_RANGE_ERROR                                                    = 0x00002046U,
    ERROR_DS_RIDMGR_DISABLED                                                       = 0x00002047U,
    ERROR_DS_ROOT_MUST_BE_NC                                                       = 0x0000206dU,
    ERROR_DS_ADD_REPLICA_INHIBITED                                                 = 0x0000206eU,
    ERROR_DS_ATT_NOT_DEF_IN_SCHEMA                                                 = 0x0000206fU,
    ERROR_DS_MAX_OBJ_SIZE_EXCEEDED                                                 = 0x00002070U,
    ERROR_DS_OBJ_STRING_NAME_EXISTS                                                = 0x00002071U,
    ERROR_DS_NO_RDN_DEFINED_IN_SCHEMA                                              = 0x00002072U,
    ERROR_DS_RDN_DOESNT_MATCH_SCHEMA                                               = 0x00002073U,
    ERROR_DS_NO_REQUESTED_ATTS_FOUND                                               = 0x00002074U,
    ERROR_DS_USER_BUFFER_TO_SMALL                                                  = 0x00002075U,
    ERROR_DS_ATT_IS_NOT_ON_OBJ                                                     = 0x00002076U,
    ERROR_DS_ILLEGAL_MOD_OPERATION                                                 = 0x00002077U,
    ERROR_DS_OBJ_TOO_LARGE                                                         = 0x00002078U,
    ERROR_DS_BAD_INSTANCE_TYPE                                                     = 0x00002079U,
    ERROR_DS_MASTERDSA_REQUIRED                                                    = 0x0000207aU,
    ERROR_DS_OBJECT_CLASS_REQUIRED                                                 = 0x0000207bU,
    ERROR_DS_MISSING_REQUIRED_ATT                                                  = 0x0000207cU,
    ERROR_DS_ATT_NOT_DEF_FOR_CLASS                                                 = 0x0000207dU,
    ERROR_DS_ATT_ALREADY_EXISTS                                                    = 0x0000207eU,
    ERROR_DS_CANT_ADD_ATT_VALUES                                                   = 0x00002080U,
    ERROR_DS_SINGLE_VALUE_CONSTRAINT                                               = 0x00002081U,
    ERROR_DS_RANGE_CONSTRAINT                                                      = 0x00002082U,
    ERROR_DS_ATT_VAL_ALREADY_EXISTS                                                = 0x00002083U,
    ERROR_DS_CANT_REM_MISSING_ATT                                                  = 0x00002084U,
    ERROR_DS_CANT_REM_MISSING_ATT_VAL                                              = 0x00002085U,
    ERROR_DS_ROOT_CANT_BE_SUBREF                                                   = 0x00002086U,
    ERROR_DS_NO_CHAINING                                                           = 0x00002087U,
    ERROR_DS_NO_CHAINED_EVAL                                                       = 0x00002088U,
    ERROR_DS_NO_PARENT_OBJECT                                                      = 0x00002089U,
    ERROR_DS_PARENT_IS_AN_ALIAS                                                    = 0x0000208aU,
    ERROR_DS_CANT_MIX_MASTER_AND_REPS                                              = 0x0000208bU,
    ERROR_DS_CHILDREN_EXIST                                                        = 0x0000208cU,
    ERROR_DS_OBJ_NOT_FOUND                                                         = 0x0000208dU,
    ERROR_DS_ALIASED_OBJ_MISSING                                                   = 0x0000208eU,
    ERROR_DS_BAD_NAME_SYNTAX                                                       = 0x0000208fU,
    ERROR_DS_ALIAS_POINTS_TO_ALIAS                                                 = 0x00002090U,
    ERROR_DS_CANT_DEREF_ALIAS                                                      = 0x00002091U,
    ERROR_DS_OUT_OF_SCOPE                                                          = 0x00002092U,
    ERROR_DS_OBJECT_BEING_REMOVED                                                  = 0x00002093U,
    ERROR_DS_CANT_DELETE_DSA_OBJ                                                   = 0x00002094U,
    ERROR_DS_GENERIC_ERROR                                                         = 0x00002095U,
    ERROR_DS_DSA_MUST_BE_INT_MASTER                                                = 0x00002096U,
    ERROR_DS_CLASS_NOT_DSA                                                         = 0x00002097U,
    ERROR_DS_INSUFF_ACCESS_RIGHTS                                                  = 0x00002098U,
    ERROR_DS_ILLEGAL_SUPERIOR                                                      = 0x00002099U,
    ERROR_DS_ATTRIBUTE_OWNED_BY_SAM                                                = 0x0000209aU,
    ERROR_DS_NAME_TOO_MANY_PARTS                                                   = 0x0000209bU,
    ERROR_DS_NAME_TOO_LONG                                                         = 0x0000209cU,
    ERROR_DS_NAME_VALUE_TOO_LONG                                                   = 0x0000209dU,
    ERROR_DS_NAME_UNPARSEABLE                                                      = 0x0000209eU,
    ERROR_DS_NAME_TYPE_UNKNOWN                                                     = 0x0000209fU,
    ERROR_DS_NOT_AN_OBJECT                                                         = 0x000020a0U,
    ERROR_DS_SEC_DESC_TOO_SHORT                                                    = 0x000020a1U,
    ERROR_DS_SEC_DESC_INVALID                                                      = 0x000020a2U,
    ERROR_DS_NO_DELETED_NAME                                                       = 0x000020a3U,
    ERROR_DS_SUBREF_MUST_HAVE_PARENT                                               = 0x000020a4U,
    ERROR_DS_NCNAME_MUST_BE_NC                                                     = 0x000020a5U,
    ERROR_DS_CANT_ADD_SYSTEM_ONLY                                                  = 0x000020a6U,
    ERROR_DS_CLASS_MUST_BE_CONCRETE                                                = 0x000020a7U,
    ERROR_DS_INVALID_DMD                                                           = 0x000020a8U,
    ERROR_DS_OBJ_GUID_EXISTS                                                       = 0x000020a9U,
    ERROR_DS_NOT_ON_BACKLINK                                                       = 0x000020aaU,
    ERROR_DS_NO_CROSSREF_FOR_NC                                                    = 0x000020abU,
    ERROR_DS_SHUTTING_DOWN                                                         = 0x000020acU,
    ERROR_DS_UNKNOWN_OPERATION                                                     = 0x000020adU,
    ERROR_DS_INVALID_ROLE_OWNER                                                    = 0x000020aeU,
    ERROR_DS_COULDNT_CONTACT_FSMO                                                  = 0x000020afU,
    ERROR_DS_CROSS_NC_DN_RENAME                                                    = 0x000020b0U,
    ERROR_DS_CANT_MOD_SYSTEM_ONLY                                                  = 0x000020b1U,
    ERROR_DS_REPLICATOR_ONLY                                                       = 0x000020b2U,
    ERROR_DS_OBJ_CLASS_NOT_DEFINED                                                 = 0x000020b3U,
    ERROR_DS_OBJ_CLASS_NOT_SUBCLASS                                                = 0x000020b4U,
    ERROR_DS_NAME_REFERENCE_INVALID                                                = 0x000020b5U,
    ERROR_DS_CROSS_REF_EXISTS                                                      = 0x000020b6U,
    ERROR_DS_CANT_DEL_MASTER_CROSSREF                                              = 0x000020b7U,
    ERROR_DS_SUBTREE_NOTIFY_NOT_NC_HEAD                                            = 0x000020b8U,
    ERROR_DS_NOTIFY_FILTER_TOO_COMPLEX                                             = 0x000020b9U,
    ERROR_DS_DUP_RDN                                                               = 0x000020baU,
    ERROR_DS_DUP_OID                                                               = 0x000020bbU,
    ERROR_DS_DUP_MAPI_ID                                                           = 0x000020bcU,
    ERROR_DS_DUP_SCHEMA_ID_GUID                                                    = 0x000020bdU,
    ERROR_DS_DUP_LDAP_DISPLAY_NAME                                                 = 0x000020beU,
    ERROR_DS_SEMANTIC_ATT_TEST                                                     = 0x000020bfU,
    ERROR_DS_SYNTAX_MISMATCH                                                       = 0x000020c0U,
    ERROR_DS_EXISTS_IN_MUST_HAVE                                                   = 0x000020c1U,
    ERROR_DS_EXISTS_IN_MAY_HAVE                                                    = 0x000020c2U,
    ERROR_DS_NONEXISTENT_MAY_HAVE                                                  = 0x000020c3U,
    ERROR_DS_NONEXISTENT_MUST_HAVE                                                 = 0x000020c4U,
    ERROR_DS_AUX_CLS_TEST_FAIL                                                     = 0x000020c5U,
    ERROR_DS_NONEXISTENT_POSS_SUP                                                  = 0x000020c6U,
    ERROR_DS_SUB_CLS_TEST_FAIL                                                     = 0x000020c7U,
    ERROR_DS_BAD_RDN_ATT_ID_SYNTAX                                                 = 0x000020c8U,
    ERROR_DS_EXISTS_IN_AUX_CLS                                                     = 0x000020c9U,
    ERROR_DS_EXISTS_IN_SUB_CLS                                                     = 0x000020caU,
    ERROR_DS_EXISTS_IN_POSS_SUP                                                    = 0x000020cbU,
    ERROR_DS_RECALCSCHEMA_FAILED                                                   = 0x000020ccU,
    ERROR_DS_TREE_DELETE_NOT_FINISHED                                              = 0x000020cdU,
    ERROR_DS_CANT_DELETE                                                           = 0x000020ceU,
    ERROR_DS_ATT_SCHEMA_REQ_ID                                                     = 0x000020cfU,
    ERROR_DS_BAD_ATT_SCHEMA_SYNTAX                                                 = 0x000020d0U,
    ERROR_DS_CANT_CACHE_ATT                                                        = 0x000020d1U,
    ERROR_DS_CANT_CACHE_CLASS                                                      = 0x000020d2U,
    ERROR_DS_CANT_REMOVE_ATT_CACHE                                                 = 0x000020d3U,
    ERROR_DS_CANT_REMOVE_CLASS_CACHE                                               = 0x000020d4U,
    ERROR_DS_CANT_RETRIEVE_DN                                                      = 0x000020d5U,
    ERROR_DS_MISSING_SUPREF                                                        = 0x000020d6U,
    ERROR_DS_CANT_RETRIEVE_INSTANCE                                                = 0x000020d7U,
    ERROR_DS_CODE_INCONSISTENCY                                                    = 0x000020d8U,
    ERROR_DS_DATABASE_ERROR                                                        = 0x000020d9U,
    ERROR_DS_GOVERNSID_MISSING                                                     = 0x000020daU,
    ERROR_DS_MISSING_EXPECTED_ATT                                                  = 0x000020dbU,
    ERROR_DS_NCNAME_MISSING_CR_REF                                                 = 0x000020dcU,
    ERROR_DS_SECURITY_CHECKING_ERROR                                               = 0x000020ddU,
    ERROR_DS_SCHEMA_NOT_LOADED                                                     = 0x000020deU,
    ERROR_DS_SCHEMA_ALLOC_FAILED                                                   = 0x000020dfU,
    ERROR_DS_ATT_SCHEMA_REQ_SYNTAX                                                 = 0x000020e0U,
    ERROR_DS_GCVERIFY_ERROR                                                        = 0x000020e1U,
    ERROR_DS_DRA_SCHEMA_MISMATCH                                                   = 0x000020e2U,
    ERROR_DS_CANT_FIND_DSA_OBJ                                                     = 0x000020e3U,
    ERROR_DS_CANT_FIND_EXPECTED_NC                                                 = 0x000020e4U,
    ERROR_DS_CANT_FIND_NC_IN_CACHE                                                 = 0x000020e5U,
    ERROR_DS_CANT_RETRIEVE_CHILD                                                   = 0x000020e6U,
    ERROR_DS_SECURITY_ILLEGAL_MODIFY                                               = 0x000020e7U,
    ERROR_DS_CANT_REPLACE_HIDDEN_REC                                               = 0x000020e8U,
    ERROR_DS_BAD_HIERARCHY_FILE                                                    = 0x000020e9U,
    ERROR_DS_BUILD_HIERARCHY_TABLE_FAILED                                          = 0x000020eaU,
    ERROR_DS_CONFIG_PARAM_MISSING                                                  = 0x000020ebU,
    ERROR_DS_COUNTING_AB_INDICES_FAILED                                            = 0x000020ecU,
    ERROR_DS_HIERARCHY_TABLE_MALLOC_FAILED                                         = 0x000020edU,
    ERROR_DS_INTERNAL_FAILURE                                                      = 0x000020eeU,
    ERROR_DS_UNKNOWN_ERROR                                                         = 0x000020efU,
    ERROR_DS_ROOT_REQUIRES_CLASS_TOP                                               = 0x000020f0U,
    ERROR_DS_REFUSING_FSMO_ROLES                                                   = 0x000020f1U,
    ERROR_DS_MISSING_FSMO_SETTINGS                                                 = 0x000020f2U,
    ERROR_DS_UNABLE_TO_SURRENDER_ROLES                                             = 0x000020f3U,
    ERROR_DS_DRA_GENERIC                                                           = 0x000020f4U,
    ERROR_DS_DRA_INVALID_PARAMETER                                                 = 0x000020f5U,
    ERROR_DS_DRA_BUSY                                                              = 0x000020f6U,
    ERROR_DS_DRA_BAD_DN                                                            = 0x000020f7U,
    ERROR_DS_DRA_BAD_NC                                                            = 0x000020f8U,
    ERROR_DS_DRA_DN_EXISTS                                                         = 0x000020f9U,
    ERROR_DS_DRA_INTERNAL_ERROR                                                    = 0x000020faU,
    ERROR_DS_DRA_INCONSISTENT_DIT                                                  = 0x000020fbU,
    ERROR_DS_DRA_CONNECTION_FAILED                                                 = 0x000020fcU,
    ERROR_DS_DRA_BAD_INSTANCE_TYPE                                                 = 0x000020fdU,
    ERROR_DS_DRA_OUT_OF_MEM                                                        = 0x000020feU,
    ERROR_DS_DRA_MAIL_PROBLEM                                                      = 0x000020ffU,
    ERROR_DS_DRA_REF_ALREADY_EXISTS                                                = 0x00002100U,
    ERROR_DS_DRA_REF_NOT_FOUND                                                     = 0x00002101U,
    ERROR_DS_DRA_OBJ_IS_REP_SOURCE                                                 = 0x00002102U,
    ERROR_DS_DRA_DB_ERROR                                                          = 0x00002103U,
    ERROR_DS_DRA_NO_REPLICA                                                        = 0x00002104U,
    ERROR_DS_DRA_ACCESS_DENIED                                                     = 0x00002105U,
    ERROR_DS_DRA_NOT_SUPPORTED                                                     = 0x00002106U,
    ERROR_DS_DRA_RPC_CANCELLED                                                     = 0x00002107U,
    ERROR_DS_DRA_SOURCE_DISABLED                                                   = 0x00002108U,
    ERROR_DS_DRA_SINK_DISABLED                                                     = 0x00002109U,
    ERROR_DS_DRA_NAME_COLLISION                                                    = 0x0000210aU,
    ERROR_DS_DRA_SOURCE_REINSTALLED                                                = 0x0000210bU,
    ERROR_DS_DRA_MISSING_PARENT                                                    = 0x0000210cU,
    ERROR_DS_DRA_PREEMPTED                                                         = 0x0000210dU,
    ERROR_DS_DRA_ABANDON_SYNC                                                      = 0x0000210eU,
    ERROR_DS_DRA_SHUTDOWN                                                          = 0x0000210fU,
    ERROR_DS_DRA_INCOMPATIBLE_PARTIAL_SET                                          = 0x00002110U,
    ERROR_DS_DRA_SOURCE_IS_PARTIAL_REPLICA                                         = 0x00002111U,
    ERROR_DS_DRA_EXTN_CONNECTION_FAILED                                            = 0x00002112U,
    ERROR_DS_INSTALL_SCHEMA_MISMATCH                                               = 0x00002113U,
    ERROR_DS_DUP_LINK_ID                                                           = 0x00002114U,
    ERROR_DS_NAME_ERROR_RESOLVING                                                  = 0x00002115U,
    ERROR_DS_NAME_ERROR_NOT_FOUND                                                  = 0x00002116U,
    ERROR_DS_NAME_ERROR_NOT_UNIQUE                                                 = 0x00002117U,
    ERROR_DS_NAME_ERROR_NO_MAPPING                                                 = 0x00002118U,
    ERROR_DS_NAME_ERROR_DOMAIN_ONLY                                                = 0x00002119U,
    ERROR_DS_NAME_ERROR_NO_SYNTACTICAL_MAPPING                                     = 0x0000211aU,
    ERROR_DS_CONSTRUCTED_ATT_MOD                                                   = 0x0000211bU,
    ERROR_DS_WRONG_OM_OBJ_CLASS                                                    = 0x0000211cU,
    ERROR_DS_DRA_REPL_PENDING                                                      = 0x0000211dU,
    ERROR_DS_DS_REQUIRED                                                           = 0x0000211eU,
    ERROR_DS_INVALID_LDAP_DISPLAY_NAME                                             = 0x0000211fU,
    ERROR_DS_NON_BASE_SEARCH                                                       = 0x00002120U,
    ERROR_DS_CANT_RETRIEVE_ATTS                                                    = 0x00002121U,
    ERROR_DS_BACKLINK_WITHOUT_LINK                                                 = 0x00002122U,
    ERROR_DS_EPOCH_MISMATCH                                                        = 0x00002123U,
    ERROR_DS_SRC_NAME_MISMATCH                                                     = 0x00002124U,
    ERROR_DS_SRC_AND_DST_NC_IDENTICAL                                              = 0x00002125U,
    ERROR_DS_DST_NC_MISMATCH                                                       = 0x00002126U,
    ERROR_DS_NOT_AUTHORITIVE_FOR_DST_NC                                            = 0x00002127U,
    ERROR_DS_SRC_GUID_MISMATCH                                                     = 0x00002128U,
    ERROR_DS_CANT_MOVE_DELETED_OBJECT                                              = 0x00002129U,
    ERROR_DS_PDC_OPERATION_IN_PROGRESS                                             = 0x0000212aU,
    ERROR_DS_CROSS_DOMAIN_CLEANUP_REQD                                             = 0x0000212bU,
    ERROR_DS_ILLEGAL_XDOM_MOVE_OPERATION                                           = 0x0000212cU,
    ERROR_DS_CANT_WITH_ACCT_GROUP_MEMBERSHPS                                       = 0x0000212dU,
    ERROR_DS_NC_MUST_HAVE_NC_PARENT                                                = 0x0000212eU,
    ERROR_DS_CR_IMPOSSIBLE_TO_VALIDATE                                             = 0x0000212fU,
    ERROR_DS_DST_DOMAIN_NOT_NATIVE                                                 = 0x00002130U,
    ERROR_DS_MISSING_INFRASTRUCTURE_CONTAINER                                      = 0x00002131U,
    ERROR_DS_CANT_MOVE_ACCOUNT_GROUP                                               = 0x00002132U,
    ERROR_DS_CANT_MOVE_RESOURCE_GROUP                                              = 0x00002133U,
    ERROR_DS_INVALID_SEARCH_FLAG                                                   = 0x00002134U,
    ERROR_DS_NO_TREE_DELETE_ABOVE_NC                                               = 0x00002135U,
    ERROR_DS_COULDNT_LOCK_TREE_FOR_DELETE                                          = 0x00002136U,
    ERROR_DS_COULDNT_IDENTIFY_OBJECTS_FOR_TREE_DELETE                              = 0x00002137U,
    ERROR_DS_SAM_INIT_FAILURE                                                      = 0x00002138U,
    ERROR_DS_SENSITIVE_GROUP_VIOLATION                                             = 0x00002139U,
    ERROR_DS_CANT_MOD_PRIMARYGROUPID                                               = 0x0000213aU,
    ERROR_DS_ILLEGAL_BASE_SCHEMA_MOD                                               = 0x0000213bU,
    ERROR_DS_NONSAFE_SCHEMA_CHANGE                                                 = 0x0000213cU,
    ERROR_DS_SCHEMA_UPDATE_DISALLOWED                                              = 0x0000213dU,
    ERROR_DS_CANT_CREATE_UNDER_SCHEMA                                              = 0x0000213eU,
    ERROR_DS_INSTALL_NO_SRC_SCH_VERSION                                            = 0x0000213fU,
    ERROR_DS_INSTALL_NO_SCH_VERSION_IN_INIFILE                                     = 0x00002140U,
    ERROR_DS_INVALID_GROUP_TYPE                                                    = 0x00002141U,
    ERROR_DS_NO_NEST_GLOBALGROUP_IN_MIXEDDOMAIN                                    = 0x00002142U,
    ERROR_DS_NO_NEST_LOCALGROUP_IN_MIXEDDOMAIN                                     = 0x00002143U,
    ERROR_DS_GLOBAL_CANT_HAVE_LOCAL_MEMBER                                         = 0x00002144U,
    ERROR_DS_GLOBAL_CANT_HAVE_UNIVERSAL_MEMBER                                     = 0x00002145U,
    ERROR_DS_UNIVERSAL_CANT_HAVE_LOCAL_MEMBER                                      = 0x00002146U,
    ERROR_DS_GLOBAL_CANT_HAVE_CROSSDOMAIN_MEMBER                                   = 0x00002147U,
    ERROR_DS_LOCAL_CANT_HAVE_CROSSDOMAIN_LOCAL_MEMBER                              = 0x00002148U,
    ERROR_DS_HAVE_PRIMARY_MEMBERS                                                  = 0x00002149U,
    ERROR_DS_STRING_SD_CONVERSION_FAILED                                           = 0x0000214aU,
    ERROR_DS_NAMING_MASTER_GC                                                      = 0x0000214bU,
    ERROR_DS_DNS_LOOKUP_FAILURE                                                    = 0x0000214cU,
    ERROR_DS_COULDNT_UPDATE_SPNS                                                   = 0x0000214dU,
    ERROR_DS_CANT_RETRIEVE_SD                                                      = 0x0000214eU,
    ERROR_DS_KEY_NOT_UNIQUE                                                        = 0x0000214fU,
    ERROR_DS_WRONG_LINKED_ATT_SYNTAX                                               = 0x00002150U,
    ERROR_DS_SAM_NEED_BOOTKEY_PASSWORD                                             = 0x00002151U,
    ERROR_DS_SAM_NEED_BOOTKEY_FLOPPY                                               = 0x00002152U,
    ERROR_DS_CANT_START                                                            = 0x00002153U,
    ERROR_DS_INIT_FAILURE                                                          = 0x00002154U,
    ERROR_DS_NO_PKT_PRIVACY_ON_CONNECTION                                          = 0x00002155U,
    ERROR_DS_SOURCE_DOMAIN_IN_FOREST                                               = 0x00002156U,
    ERROR_DS_DESTINATION_DOMAIN_NOT_IN_FOREST                                      = 0x00002157U,
    ERROR_DS_DESTINATION_AUDITING_NOT_ENABLED                                      = 0x00002158U,
    ERROR_DS_CANT_FIND_DC_FOR_SRC_DOMAIN                                           = 0x00002159U,
    ERROR_DS_SRC_OBJ_NOT_GROUP_OR_USER                                             = 0x0000215aU,
    ERROR_DS_SRC_SID_EXISTS_IN_FOREST                                              = 0x0000215bU,
    ERROR_DS_SRC_AND_DST_OBJECT_CLASS_MISMATCH                                     = 0x0000215cU,
    ERROR_SAM_INIT_FAILURE                                                         = 0x0000215dU,
    ERROR_DS_DRA_SCHEMA_INFO_SHIP                                                  = 0x0000215eU,
    ERROR_DS_DRA_SCHEMA_CONFLICT                                                   = 0x0000215fU,
    ERROR_DS_DRA_EARLIER_SCHEMA_CONFLICT                                           = 0x00002160U,
    ERROR_DS_DRA_OBJ_NC_MISMATCH                                                   = 0x00002161U,
    ERROR_DS_NC_STILL_HAS_DSAS                                                     = 0x00002162U,
    ERROR_DS_GC_REQUIRED                                                           = 0x00002163U,
    ERROR_DS_LOCAL_MEMBER_OF_LOCAL_ONLY                                            = 0x00002164U,
    ERROR_DS_NO_FPO_IN_UNIVERSAL_GROUPS                                            = 0x00002165U,
    ERROR_DS_CANT_ADD_TO_GC                                                        = 0x00002166U,
    ERROR_DS_NO_CHECKPOINT_WITH_PDC                                                = 0x00002167U,
    ERROR_DS_SOURCE_AUDITING_NOT_ENABLED                                           = 0x00002168U,
    ERROR_DS_CANT_CREATE_IN_NONDOMAIN_NC                                           = 0x00002169U,
    ERROR_DS_INVALID_NAME_FOR_SPN                                                  = 0x0000216aU,
    ERROR_DS_FILTER_USES_CONTRUCTED_ATTRS                                          = 0x0000216bU,
    ERROR_DS_UNICODEPWD_NOT_IN_QUOTES                                              = 0x0000216cU,
    ERROR_DS_MACHINE_ACCOUNT_QUOTA_EXCEEDED                                        = 0x0000216dU,
    ERROR_DS_MUST_BE_RUN_ON_DST_DC                                                 = 0x0000216eU,
    ERROR_DS_SRC_DC_MUST_BE_SP4_OR_GREATER                                         = 0x0000216fU,
    ERROR_DS_CANT_TREE_DELETE_CRITICAL_OBJ                                         = 0x00002170U,
    ERROR_DS_INIT_FAILURE_CONSOLE                                                  = 0x00002171U,
    ERROR_DS_SAM_INIT_FAILURE_CONSOLE                                              = 0x00002172U,
    ERROR_DS_FOREST_VERSION_TOO_HIGH                                               = 0x00002173U,
    ERROR_DS_DOMAIN_VERSION_TOO_HIGH                                               = 0x00002174U,
    ERROR_DS_FOREST_VERSION_TOO_LOW                                                = 0x00002175U,
    ERROR_DS_DOMAIN_VERSION_TOO_LOW                                                = 0x00002176U,
    ERROR_DS_INCOMPATIBLE_VERSION                                                  = 0x00002177U,
    ERROR_DS_LOW_DSA_VERSION                                                       = 0x00002178U,
    ERROR_DS_NO_BEHAVIOR_VERSION_IN_MIXEDDOMAIN                                    = 0x00002179U,
    ERROR_DS_NOT_SUPPORTED_SORT_ORDER                                              = 0x0000217aU,
    ERROR_DS_NAME_NOT_UNIQUE                                                       = 0x0000217bU,
    ERROR_DS_MACHINE_ACCOUNT_CREATED_PRENT4                                        = 0x0000217cU,
    ERROR_DS_OUT_OF_VERSION_STORE                                                  = 0x0000217dU,
    ERROR_DS_INCOMPATIBLE_CONTROLS_USED                                            = 0x0000217eU,
    ERROR_DS_NO_REF_DOMAIN                                                         = 0x0000217fU,
    ERROR_DS_RESERVED_LINK_ID                                                      = 0x00002180U,
    ERROR_DS_LINK_ID_NOT_AVAILABLE                                                 = 0x00002181U,
    ERROR_DS_AG_CANT_HAVE_UNIVERSAL_MEMBER                                         = 0x00002182U,
    ERROR_DS_MODIFYDN_DISALLOWED_BY_INSTANCE_TYPE                                  = 0x00002183U,
    ERROR_DS_NO_OBJECT_MOVE_IN_SCHEMA_NC                                           = 0x00002184U,
    ERROR_DS_MODIFYDN_DISALLOWED_BY_FLAG                                           = 0x00002185U,
    ERROR_DS_MODIFYDN_WRONG_GRANDPARENT                                            = 0x00002186U,
    ERROR_DS_NAME_ERROR_TRUST_REFERRAL                                             = 0x00002187U,
    ERROR_NOT_SUPPORTED_ON_STANDARD_SERVER                                         = 0x00002188U,
    ERROR_DS_CANT_ACCESS_REMOTE_PART_OF_AD                                         = 0x00002189U,
    ERROR_DS_CR_IMPOSSIBLE_TO_VALIDATE_V2                                          = 0x0000218aU,
    ERROR_DS_THREAD_LIMIT_EXCEEDED                                                 = 0x0000218bU,
    ERROR_DS_NOT_CLOSEST                                                           = 0x0000218cU,
    ERROR_DS_CANT_DERIVE_SPN_WITHOUT_SERVER_REF                                    = 0x0000218dU,
    ERROR_DS_SINGLE_USER_MODE_FAILED                                               = 0x0000218eU,
    ERROR_DS_NTDSCRIPT_SYNTAX_ERROR                                                = 0x0000218fU,
    ERROR_DS_NTDSCRIPT_PROCESS_ERROR                                               = 0x00002190U,
    ERROR_DS_DIFFERENT_REPL_EPOCHS                                                 = 0x00002191U,
    ERROR_DS_DRS_EXTENSIONS_CHANGED                                                = 0x00002192U,
    ERROR_DS_REPLICA_SET_CHANGE_NOT_ALLOWED_ON_DISABLED_CR                         = 0x00002193U,
    ERROR_DS_NO_MSDS_INTID                                                         = 0x00002194U,
    ERROR_DS_DUP_MSDS_INTID                                                        = 0x00002195U,
    ERROR_DS_EXISTS_IN_RDNATTID                                                    = 0x00002196U,
    ERROR_DS_AUTHORIZATION_FAILED                                                  = 0x00002197U,
    ERROR_DS_INVALID_SCRIPT                                                        = 0x00002198U,
    ERROR_DS_REMOTE_CROSSREF_OP_FAILED                                             = 0x00002199U,
    ERROR_DS_CROSS_REF_BUSY                                                        = 0x0000219aU,
    ERROR_DS_CANT_DERIVE_SPN_FOR_DELETED_DOMAIN                                    = 0x0000219bU,
    ERROR_DS_CANT_DEMOTE_WITH_WRITEABLE_NC                                         = 0x0000219cU,
    ERROR_DS_DUPLICATE_ID_FOUND                                                    = 0x0000219dU,
    ERROR_DS_INSUFFICIENT_ATTR_TO_CREATE_OBJECT                                    = 0x0000219eU,
    ERROR_DS_GROUP_CONVERSION_ERROR                                                = 0x0000219fU,
    ERROR_DS_CANT_MOVE_APP_BASIC_GROUP                                             = 0x000021a0U,
    ERROR_DS_CANT_MOVE_APP_QUERY_GROUP                                             = 0x000021a1U,
    ERROR_DS_ROLE_NOT_VERIFIED                                                     = 0x000021a2U,
    ERROR_DS_WKO_CONTAINER_CANNOT_BE_SPECIAL                                       = 0x000021a3U,
    ERROR_DS_DOMAIN_RENAME_IN_PROGRESS                                             = 0x000021a4U,
    ERROR_DS_EXISTING_AD_CHILD_NC                                                  = 0x000021a5U,
    ERROR_DS_REPL_LIFETIME_EXCEEDED                                                = 0x000021a6U,
    ERROR_DS_DISALLOWED_IN_SYSTEM_CONTAINER                                        = 0x000021a7U,
    ERROR_DS_LDAP_SEND_QUEUE_FULL                                                  = 0x000021a8U,
    ERROR_DS_DRA_OUT_SCHEDULE_WINDOW                                               = 0x000021a9U,
    ERROR_DS_POLICY_NOT_KNOWN                                                      = 0x000021aaU,
    ERROR_NO_SITE_SETTINGS_OBJECT                                                  = 0x000021abU,
    ERROR_NO_SECRETS                                                               = 0x000021acU,
    ERROR_NO_WRITABLE_DC_FOUND                                                     = 0x000021adU,
    ERROR_DS_NO_SERVER_OBJECT                                                      = 0x000021aeU,
    ERROR_DS_NO_NTDSA_OBJECT                                                       = 0x000021afU,
    ERROR_DS_NON_ASQ_SEARCH                                                        = 0x000021b0U,
    ERROR_DS_AUDIT_FAILURE                                                         = 0x000021b1U,
    ERROR_DS_INVALID_SEARCH_FLAG_SUBTREE                                           = 0x000021b2U,
    ERROR_DS_INVALID_SEARCH_FLAG_TUPLE                                             = 0x000021b3U,
    ERROR_DS_HIERARCHY_TABLE_TOO_DEEP                                              = 0x000021b4U,
    ERROR_DS_DRA_CORRUPT_UTD_VECTOR                                                = 0x000021b5U,
    ERROR_DS_DRA_SECRETS_DENIED                                                    = 0x000021b6U,
    ERROR_DS_RESERVED_MAPI_ID                                                      = 0x000021b7U,
    ERROR_DS_MAPI_ID_NOT_AVAILABLE                                                 = 0x000021b8U,
    ERROR_DS_DRA_MISSING_KRBTGT_SECRET                                             = 0x000021b9U,
    ERROR_DS_DOMAIN_NAME_EXISTS_IN_FOREST                                          = 0x000021baU,
    ERROR_DS_FLAT_NAME_EXISTS_IN_FOREST                                            = 0x000021bbU,
    ERROR_INVALID_USER_PRINCIPAL_NAME                                              = 0x000021bcU,
    ERROR_DS_OID_MAPPED_GROUP_CANT_HAVE_MEMBERS                                    = 0x000021bdU,
    ERROR_DS_OID_NOT_FOUND                                                         = 0x000021beU,
    ERROR_DS_DRA_RECYCLED_TARGET                                                   = 0x000021bfU,
    ERROR_DS_DISALLOWED_NC_REDIRECT                                                = 0x000021c0U,
    ERROR_DS_HIGH_ADLDS_FFL                                                        = 0x000021c1U,
    ERROR_DS_HIGH_DSA_VERSION                                                      = 0x000021c2U,
    ERROR_DS_LOW_ADLDS_FFL                                                         = 0x000021c3U,
    ERROR_DOMAIN_SID_SAME_AS_LOCAL_WORKSTATION                                     = 0x000021c4U,
    ERROR_DS_UNDELETE_SAM_VALIDATION_FAILED                                        = 0x000021c5U,
    ERROR_INCORRECT_ACCOUNT_TYPE                                                   = 0x000021c6U,
    ERROR_DS_SPN_VALUE_NOT_UNIQUE_IN_FOREST                                        = 0x000021c7U,
    ERROR_DS_UPN_VALUE_NOT_UNIQUE_IN_FOREST                                        = 0x000021c8U,
    ERROR_DS_MISSING_FOREST_TRUST                                                  = 0x000021c9U,
    ERROR_DS_VALUE_KEY_NOT_UNIQUE                                                  = 0x000021caU,
    ERROR_WEAK_WHFBKEY_BLOCKED                                                     = 0x000021cbU,
    ERROR_DS_PER_ATTRIBUTE_AUTHZ_FAILED_DURING_ADD                                 = 0x000021ccU,
    ERROR_LOCAL_POLICY_MODIFICATION_NOT_SUPPORTED                                  = 0x000021cdU,
    ERROR_POLICY_CONTROLLED_ACCOUNT                                                = 0x000021ceU,
    ERROR_LAPS_LEGACY_SCHEMA_MISSING                                               = 0x000021cfU,
    ERROR_LAPS_SCHEMA_MISSING                                                      = 0x000021d0U,
    ERROR_LAPS_ENCRYPTION_REQUIRES_2016_DFL                                        = 0x000021d1U,
    ERROR_LAPS_PROCESS_TERMINATED                                                  = 0x000021d2U,
    ERROR_DS_JET_RECORD_TOO_BIG                                                    = 0x000021d3U,
    ERROR_DS_REPLICA_PAGE_SIZE_MISMATCH                                            = 0x000021d4U,
    DNS_ERROR_RESPONSE_CODES_BASE                                                  = 0x00002328U,
    DNS_ERROR_RCODE_NO_ERROR                                                       = 0x00000000U,
    DNS_ERROR_MASK                                                                 = 0x00002328U,
    DNS_ERROR_RCODE_FORMAT_ERROR                                                   = 0x00002329U,
    DNS_ERROR_RCODE_SERVER_FAILURE                                                 = 0x0000232aU,
    DNS_ERROR_RCODE_NAME_ERROR                                                     = 0x0000232bU,
    DNS_ERROR_RCODE_NOT_IMPLEMENTED                                                = 0x0000232cU,
    DNS_ERROR_RCODE_REFUSED                                                        = 0x0000232dU,
    DNS_ERROR_RCODE_YXDOMAIN                                                       = 0x0000232eU,
    DNS_ERROR_RCODE_YXRRSET                                                        = 0x0000232fU,
    DNS_ERROR_RCODE_NXRRSET                                                        = 0x00002330U,
    DNS_ERROR_RCODE_NOTAUTH                                                        = 0x00002331U,
    DNS_ERROR_RCODE_NOTZONE                                                        = 0x00002332U,
    DNS_ERROR_RCODE_BADSIG                                                         = 0x00002338U,
    DNS_ERROR_RCODE_BADKEY                                                         = 0x00002339U,
    DNS_ERROR_RCODE_BADTIME                                                        = 0x0000233aU,
    DNS_ERROR_RCODE_LAST                                                           = 0x0000233aU,
    DNS_ERROR_DNSSEC_BASE                                                          = 0x0000238cU,
    DNS_ERROR_KEYMASTER_REQUIRED                                                   = 0x0000238dU,
    DNS_ERROR_NOT_ALLOWED_ON_SIGNED_ZONE                                           = 0x0000238eU,
    DNS_ERROR_NSEC3_INCOMPATIBLE_WITH_RSA_SHA1                                     = 0x0000238fU,
    DNS_ERROR_NOT_ENOUGH_SIGNING_KEY_DESCRIPTORS                                   = 0x00002390U,
    DNS_ERROR_UNSUPPORTED_ALGORITHM                                                = 0x00002391U,
    DNS_ERROR_INVALID_KEY_SIZE                                                     = 0x00002392U,
    DNS_ERROR_SIGNING_KEY_NOT_ACCESSIBLE                                           = 0x00002393U,
    DNS_ERROR_KSP_DOES_NOT_SUPPORT_PROTECTION                                      = 0x00002394U,
    DNS_ERROR_UNEXPECTED_DATA_PROTECTION_ERROR                                     = 0x00002395U,
    DNS_ERROR_UNEXPECTED_CNG_ERROR                                                 = 0x00002396U,
    DNS_ERROR_UNKNOWN_SIGNING_PARAMETER_VERSION                                    = 0x00002397U,
    DNS_ERROR_KSP_NOT_ACCESSIBLE                                                   = 0x00002398U,
    DNS_ERROR_TOO_MANY_SKDS                                                        = 0x00002399U,
    DNS_ERROR_INVALID_ROLLOVER_PERIOD                                              = 0x0000239aU,
    DNS_ERROR_INVALID_INITIAL_ROLLOVER_OFFSET                                      = 0x0000239bU,
    DNS_ERROR_ROLLOVER_IN_PROGRESS                                                 = 0x0000239cU,
    DNS_ERROR_STANDBY_KEY_NOT_PRESENT                                              = 0x0000239dU,
    DNS_ERROR_NOT_ALLOWED_ON_ZSK                                                   = 0x0000239eU,
    DNS_ERROR_NOT_ALLOWED_ON_ACTIVE_SKD                                            = 0x0000239fU,
    DNS_ERROR_ROLLOVER_ALREADY_QUEUED                                              = 0x000023a0U,
    DNS_ERROR_NOT_ALLOWED_ON_UNSIGNED_ZONE                                         = 0x000023a1U,
    DNS_ERROR_BAD_KEYMASTER                                                        = 0x000023a2U,
    DNS_ERROR_INVALID_SIGNATURE_VALIDITY_PERIOD                                    = 0x000023a3U,
    DNS_ERROR_INVALID_NSEC3_ITERATION_COUNT                                        = 0x000023a4U,
    DNS_ERROR_DNSSEC_IS_DISABLED                                                   = 0x000023a5U,
    DNS_ERROR_INVALID_XML                                                          = 0x000023a6U,
    DNS_ERROR_NO_VALID_TRUST_ANCHORS                                               = 0x000023a7U,
    DNS_ERROR_ROLLOVER_NOT_POKEABLE                                                = 0x000023a8U,
    DNS_ERROR_NSEC3_NAME_COLLISION                                                 = 0x000023a9U,
    DNS_ERROR_NSEC_INCOMPATIBLE_WITH_NSEC3_RSA_SHA1                                = 0x000023aaU,
    DNS_ERROR_PACKET_FMT_BASE                                                      = 0x0000251cU,
    DNS_ERROR_BAD_PACKET                                                           = 0x0000251eU,
    DNS_ERROR_NO_PACKET                                                            = 0x0000251fU,
    DNS_ERROR_RCODE                                                                = 0x00002520U,
    DNS_ERROR_UNSECURE_PACKET                                                      = 0x00002521U,
    DNS_ERROR_NO_MEMORY                                                            = 0x0000000eU,
    DNS_ERROR_INVALID_NAME                                                         = 0x0000007bU,
    DNS_ERROR_INVALID_DATA                                                         = 0x0000000dU,
    DNS_ERROR_GENERAL_API_BASE                                                     = 0x0000254eU,
    DNS_ERROR_INVALID_TYPE                                                         = 0x0000254fU,
    DNS_ERROR_INVALID_IP_ADDRESS                                                   = 0x00002550U,
    DNS_ERROR_INVALID_PROPERTY                                                     = 0x00002551U,
    DNS_ERROR_TRY_AGAIN_LATER                                                      = 0x00002552U,
    DNS_ERROR_NOT_UNIQUE                                                           = 0x00002553U,
    DNS_ERROR_NON_RFC_NAME                                                         = 0x00002554U,
    DNS_ERROR_INVALID_NAME_CHAR                                                    = 0x00002558U,
    DNS_ERROR_NUMERIC_NAME                                                         = 0x00002559U,
    DNS_ERROR_NOT_ALLOWED_ON_ROOT_SERVER                                           = 0x0000255aU,
    DNS_ERROR_NOT_ALLOWED_UNDER_DELEGATION                                         = 0x0000255bU,
    DNS_ERROR_CANNOT_FIND_ROOT_HINTS                                               = 0x0000255cU,
    DNS_ERROR_INCONSISTENT_ROOT_HINTS                                              = 0x0000255dU,
    DNS_ERROR_DWORD_VALUE_TOO_SMALL                                                = 0x0000255eU,
    DNS_ERROR_DWORD_VALUE_TOO_LARGE                                                = 0x0000255fU,
    DNS_ERROR_BACKGROUND_LOADING                                                   = 0x00002560U,
    DNS_ERROR_NOT_ALLOWED_ON_RODC                                                  = 0x00002561U,
    DNS_ERROR_NOT_ALLOWED_UNDER_DNAME                                              = 0x00002562U,
    DNS_ERROR_DELEGATION_REQUIRED                                                  = 0x00002563U,
    DNS_ERROR_INVALID_POLICY_TABLE                                                 = 0x00002564U,
    DNS_ERROR_ADDRESS_REQUIRED                                                     = 0x00002565U,
    DNS_ERROR_ZONE_BASE                                                            = 0x00002580U,
    DNS_ERROR_ZONE_DOES_NOT_EXIST                                                  = 0x00002581U,
    DNS_ERROR_NO_ZONE_INFO                                                         = 0x00002582U,
    DNS_ERROR_INVALID_ZONE_OPERATION                                               = 0x00002583U,
    DNS_ERROR_ZONE_CONFIGURATION_ERROR                                             = 0x00002584U,
    DNS_ERROR_ZONE_HAS_NO_SOA_RECORD                                               = 0x00002585U,
    DNS_ERROR_ZONE_HAS_NO_NS_RECORDS                                               = 0x00002586U,
    DNS_ERROR_ZONE_LOCKED                                                          = 0x00002587U,
    DNS_ERROR_ZONE_CREATION_FAILED                                                 = 0x00002588U,
    DNS_ERROR_ZONE_ALREADY_EXISTS                                                  = 0x00002589U,
    DNS_ERROR_AUTOZONE_ALREADY_EXISTS                                              = 0x0000258aU,
    DNS_ERROR_INVALID_ZONE_TYPE                                                    = 0x0000258bU,
    DNS_ERROR_SECONDARY_REQUIRES_MASTER_IP                                         = 0x0000258cU,
    DNS_ERROR_ZONE_NOT_SECONDARY                                                   = 0x0000258dU,
    DNS_ERROR_NEED_SECONDARY_ADDRESSES                                             = 0x0000258eU,
    DNS_ERROR_WINS_INIT_FAILED                                                     = 0x0000258fU,
    DNS_ERROR_NEED_WINS_SERVERS                                                    = 0x00002590U,
    DNS_ERROR_NBSTAT_INIT_FAILED                                                   = 0x00002591U,
    DNS_ERROR_SOA_DELETE_INVALID                                                   = 0x00002592U,
    DNS_ERROR_FORWARDER_ALREADY_EXISTS                                             = 0x00002593U,
    DNS_ERROR_ZONE_REQUIRES_MASTER_IP                                              = 0x00002594U,
    DNS_ERROR_ZONE_IS_SHUTDOWN                                                     = 0x00002595U,
    DNS_ERROR_ZONE_LOCKED_FOR_SIGNING                                              = 0x00002596U,
    DNS_ERROR_DATAFILE_BASE                                                        = 0x000025b2U,
    DNS_ERROR_PRIMARY_REQUIRES_DATAFILE                                            = 0x000025b3U,
    DNS_ERROR_INVALID_DATAFILE_NAME                                                = 0x000025b4U,
    DNS_ERROR_DATAFILE_OPEN_FAILURE                                                = 0x000025b5U,
    DNS_ERROR_FILE_WRITEBACK_FAILED                                                = 0x000025b6U,
    DNS_ERROR_DATAFILE_PARSING                                                     = 0x000025b7U,
    DNS_ERROR_DATABASE_BASE                                                        = 0x000025e4U,
    DNS_ERROR_RECORD_DOES_NOT_EXIST                                                = 0x000025e5U,
    DNS_ERROR_RECORD_FORMAT                                                        = 0x000025e6U,
    DNS_ERROR_NODE_CREATION_FAILED                                                 = 0x000025e7U,
    DNS_ERROR_UNKNOWN_RECORD_TYPE                                                  = 0x000025e8U,
    DNS_ERROR_RECORD_TIMED_OUT                                                     = 0x000025e9U,
    DNS_ERROR_NAME_NOT_IN_ZONE                                                     = 0x000025eaU,
    DNS_ERROR_CNAME_LOOP                                                           = 0x000025ebU,
    DNS_ERROR_NODE_IS_CNAME                                                        = 0x000025ecU,
    DNS_ERROR_CNAME_COLLISION                                                      = 0x000025edU,
    DNS_ERROR_RECORD_ONLY_AT_ZONE_ROOT                                             = 0x000025eeU,
    DNS_ERROR_RECORD_ALREADY_EXISTS                                                = 0x000025efU,
    DNS_ERROR_SECONDARY_DATA                                                       = 0x000025f0U,
    DNS_ERROR_NO_CREATE_CACHE_DATA                                                 = 0x000025f1U,
    DNS_ERROR_NAME_DOES_NOT_EXIST                                                  = 0x000025f2U,
    DNS_ERROR_DS_UNAVAILABLE                                                       = 0x000025f5U,
    DNS_ERROR_DS_ZONE_ALREADY_EXISTS                                               = 0x000025f6U,
    DNS_ERROR_NO_BOOTFILE_IF_DS_ZONE                                               = 0x000025f7U,
    DNS_ERROR_NODE_IS_DNAME                                                        = 0x000025f8U,
    DNS_ERROR_DNAME_COLLISION                                                      = 0x000025f9U,
    DNS_ERROR_ALIAS_LOOP                                                           = 0x000025faU,
    DNS_ERROR_OPERATION_BASE                                                       = 0x00002616U,
    DNS_ERROR_AXFR                                                                 = 0x00002618U,
    DNS_ERROR_SECURE_BASE                                                          = 0x00002648U,
    DNS_ERROR_SETUP_BASE                                                           = 0x0000267aU,
    DNS_ERROR_NO_TCPIP                                                             = 0x0000267bU,
    DNS_ERROR_NO_DNS_SERVERS                                                       = 0x0000267cU,
    DNS_ERROR_DP_BASE                                                              = 0x000026acU,
    DNS_ERROR_DP_DOES_NOT_EXIST                                                    = 0x000026adU,
    DNS_ERROR_DP_ALREADY_EXISTS                                                    = 0x000026aeU,
    DNS_ERROR_DP_NOT_ENLISTED                                                      = 0x000026afU,
    DNS_ERROR_DP_ALREADY_ENLISTED                                                  = 0x000026b0U,
    DNS_ERROR_DP_NOT_AVAILABLE                                                     = 0x000026b1U,
    DNS_ERROR_DP_FSMO_ERROR                                                        = 0x000026b2U,
    DNS_ERROR_RRL_NOT_ENABLED                                                      = 0x000026b7U,
    DNS_ERROR_RRL_INVALID_WINDOW_SIZE                                              = 0x000026b8U,
    DNS_ERROR_RRL_INVALID_IPV4_PREFIX                                              = 0x000026b9U,
    DNS_ERROR_RRL_INVALID_IPV6_PREFIX                                              = 0x000026baU,
    DNS_ERROR_RRL_INVALID_TC_RATE                                                  = 0x000026bbU,
    DNS_ERROR_RRL_INVALID_LEAK_RATE                                                = 0x000026bcU,
    DNS_ERROR_RRL_LEAK_RATE_LESSTHAN_TC_RATE                                       = 0x000026bdU,
    DNS_ERROR_VIRTUALIZATION_INSTANCE_ALREADY_EXISTS                               = 0x000026c1U,
    DNS_ERROR_VIRTUALIZATION_INSTANCE_DOES_NOT_EXIST                               = 0x000026c2U,
    DNS_ERROR_VIRTUALIZATION_TREE_LOCKED                                           = 0x000026c3U,
    DNS_ERROR_INVAILD_VIRTUALIZATION_INSTANCE_NAME                                 = 0x000026c4U,
    DNS_ERROR_DEFAULT_VIRTUALIZATION_INSTANCE                                      = 0x000026c5U,
    DNS_ERROR_ZONESCOPE_ALREADY_EXISTS                                             = 0x000026dfU,
    DNS_ERROR_ZONESCOPE_DOES_NOT_EXIST                                             = 0x000026e0U,
    DNS_ERROR_DEFAULT_ZONESCOPE                                                    = 0x000026e1U,
    DNS_ERROR_INVALID_ZONESCOPE_NAME                                               = 0x000026e2U,
    DNS_ERROR_NOT_ALLOWED_WITH_ZONESCOPES                                          = 0x000026e3U,
    DNS_ERROR_LOAD_ZONESCOPE_FAILED                                                = 0x000026e4U,
    DNS_ERROR_ZONESCOPE_FILE_WRITEBACK_FAILED                                      = 0x000026e5U,
    DNS_ERROR_INVALID_SCOPE_NAME                                                   = 0x000026e6U,
    DNS_ERROR_SCOPE_DOES_NOT_EXIST                                                 = 0x000026e7U,
    DNS_ERROR_DEFAULT_SCOPE                                                        = 0x000026e8U,
    DNS_ERROR_INVALID_SCOPE_OPERATION                                              = 0x000026e9U,
    DNS_ERROR_SCOPE_LOCKED                                                         = 0x000026eaU,
    DNS_ERROR_SCOPE_ALREADY_EXISTS                                                 = 0x000026ebU,
    DNS_ERROR_POLICY_ALREADY_EXISTS                                                = 0x000026f3U,
    DNS_ERROR_POLICY_DOES_NOT_EXIST                                                = 0x000026f4U,
    DNS_ERROR_POLICY_INVALID_CRITERIA                                              = 0x000026f5U,
    DNS_ERROR_POLICY_INVALID_SETTINGS                                              = 0x000026f6U,
    DNS_ERROR_CLIENT_SUBNET_IS_ACCESSED                                            = 0x000026f7U,
    DNS_ERROR_CLIENT_SUBNET_DOES_NOT_EXIST                                         = 0x000026f8U,
    DNS_ERROR_CLIENT_SUBNET_ALREADY_EXISTS                                         = 0x000026f9U,
    DNS_ERROR_SUBNET_DOES_NOT_EXIST                                                = 0x000026faU,
    DNS_ERROR_SUBNET_ALREADY_EXISTS                                                = 0x000026fbU,
    DNS_ERROR_POLICY_LOCKED                                                        = 0x000026fcU,
    DNS_ERROR_POLICY_INVALID_WEIGHT                                                = 0x000026fdU,
    DNS_ERROR_POLICY_INVALID_NAME                                                  = 0x000026feU,
    DNS_ERROR_POLICY_MISSING_CRITERIA                                              = 0x000026ffU,
    DNS_ERROR_INVALID_CLIENT_SUBNET_NAME                                           = 0x00002700U,
    DNS_ERROR_POLICY_PROCESSING_ORDER_INVALID                                      = 0x00002701U,
    DNS_ERROR_POLICY_SCOPE_MISSING                                                 = 0x00002702U,
    DNS_ERROR_POLICY_SCOPE_NOT_ALLOWED                                             = 0x00002703U,
    DNS_ERROR_SERVERSCOPE_IS_REFERENCED                                            = 0x00002704U,
    DNS_ERROR_ZONESCOPE_IS_REFERENCED                                              = 0x00002705U,
    DNS_ERROR_POLICY_INVALID_CRITERIA_CLIENT_SUBNET                                = 0x00002706U,
    DNS_ERROR_POLICY_INVALID_CRITERIA_TRANSPORT_PROTOCOL                           = 0x00002707U,
    DNS_ERROR_POLICY_INVALID_CRITERIA_NETWORK_PROTOCOL                             = 0x00002708U,
    DNS_ERROR_POLICY_INVALID_CRITERIA_INTERFACE                                    = 0x00002709U,
    DNS_ERROR_POLICY_INVALID_CRITERIA_FQDN                                         = 0x0000270aU,
    DNS_ERROR_POLICY_INVALID_CRITERIA_QUERY_TYPE                                   = 0x0000270bU,
    DNS_ERROR_POLICY_INVALID_CRITERIA_TIME_OF_DAY                                  = 0x0000270cU,
    ERROR_IPSEC_QM_POLICY_EXISTS                                                   = 0x000032c8U,
    ERROR_IPSEC_QM_POLICY_NOT_FOUND                                                = 0x000032c9U,
    ERROR_IPSEC_QM_POLICY_IN_USE                                                   = 0x000032caU,
    ERROR_IPSEC_MM_POLICY_EXISTS                                                   = 0x000032cbU,
    ERROR_IPSEC_MM_POLICY_NOT_FOUND                                                = 0x000032ccU,
    ERROR_IPSEC_MM_POLICY_IN_USE                                                   = 0x000032cdU,
    ERROR_IPSEC_MM_FILTER_EXISTS                                                   = 0x000032ceU,
    ERROR_IPSEC_MM_FILTER_NOT_FOUND                                                = 0x000032cfU,
    ERROR_IPSEC_TRANSPORT_FILTER_EXISTS                                            = 0x000032d0U,
    ERROR_IPSEC_TRANSPORT_FILTER_NOT_FOUND                                         = 0x000032d1U,
    ERROR_IPSEC_MM_AUTH_EXISTS                                                     = 0x000032d2U,
    ERROR_IPSEC_MM_AUTH_NOT_FOUND                                                  = 0x000032d3U,
    ERROR_IPSEC_MM_AUTH_IN_USE                                                     = 0x000032d4U,
    ERROR_IPSEC_DEFAULT_MM_POLICY_NOT_FOUND                                        = 0x000032d5U,
    ERROR_IPSEC_DEFAULT_MM_AUTH_NOT_FOUND                                          = 0x000032d6U,
    ERROR_IPSEC_DEFAULT_QM_POLICY_NOT_FOUND                                        = 0x000032d7U,
    ERROR_IPSEC_TUNNEL_FILTER_EXISTS                                               = 0x000032d8U,
    ERROR_IPSEC_TUNNEL_FILTER_NOT_FOUND                                            = 0x000032d9U,
    ERROR_IPSEC_MM_FILTER_PENDING_DELETION                                         = 0x000032daU,
    ERROR_IPSEC_TRANSPORT_FILTER_PENDING_DELETION                                  = 0x000032dbU,
    ERROR_IPSEC_TUNNEL_FILTER_PENDING_DELETION                                     = 0x000032dcU,
    ERROR_IPSEC_MM_POLICY_PENDING_DELETION                                         = 0x000032ddU,
    ERROR_IPSEC_MM_AUTH_PENDING_DELETION                                           = 0x000032deU,
    ERROR_IPSEC_QM_POLICY_PENDING_DELETION                                         = 0x000032dfU,
    ERROR_IPSEC_IKE_NEG_STATUS_BEGIN                                               = 0x000035e8U,
    ERROR_IPSEC_IKE_AUTH_FAIL                                                      = 0x000035e9U,
    ERROR_IPSEC_IKE_ATTRIB_FAIL                                                    = 0x000035eaU,
    ERROR_IPSEC_IKE_NEGOTIATION_PENDING                                            = 0x000035ebU,
    ERROR_IPSEC_IKE_GENERAL_PROCESSING_ERROR                                       = 0x000035ecU,
    ERROR_IPSEC_IKE_TIMED_OUT                                                      = 0x000035edU,
    ERROR_IPSEC_IKE_NO_CERT                                                        = 0x000035eeU,
    ERROR_IPSEC_IKE_SA_DELETED                                                     = 0x000035efU,
    ERROR_IPSEC_IKE_SA_REAPED                                                      = 0x000035f0U,
    ERROR_IPSEC_IKE_MM_ACQUIRE_DROP                                                = 0x000035f1U,
    ERROR_IPSEC_IKE_QM_ACQUIRE_DROP                                                = 0x000035f2U,
    ERROR_IPSEC_IKE_QUEUE_DROP_MM                                                  = 0x000035f3U,
    ERROR_IPSEC_IKE_QUEUE_DROP_NO_MM                                               = 0x000035f4U,
    ERROR_IPSEC_IKE_DROP_NO_RESPONSE                                               = 0x000035f5U,
    ERROR_IPSEC_IKE_MM_DELAY_DROP                                                  = 0x000035f6U,
    ERROR_IPSEC_IKE_QM_DELAY_DROP                                                  = 0x000035f7U,
    ERROR_IPSEC_IKE_ERROR                                                          = 0x000035f8U,
    ERROR_IPSEC_IKE_CRL_FAILED                                                     = 0x000035f9U,
    ERROR_IPSEC_IKE_INVALID_KEY_USAGE                                              = 0x000035faU,
    ERROR_IPSEC_IKE_INVALID_CERT_TYPE                                              = 0x000035fbU,
    ERROR_IPSEC_IKE_NO_PRIVATE_KEY                                                 = 0x000035fcU,
    ERROR_IPSEC_IKE_SIMULTANEOUS_REKEY                                             = 0x000035fdU,
    ERROR_IPSEC_IKE_DH_FAIL                                                        = 0x000035feU,
    ERROR_IPSEC_IKE_CRITICAL_PAYLOAD_NOT_RECOGNIZED                                = 0x000035ffU,
    ERROR_IPSEC_IKE_INVALID_HEADER                                                 = 0x00003600U,
    ERROR_IPSEC_IKE_NO_POLICY                                                      = 0x00003601U,
    ERROR_IPSEC_IKE_INVALID_SIGNATURE                                              = 0x00003602U,
    ERROR_IPSEC_IKE_KERBEROS_ERROR                                                 = 0x00003603U,
    ERROR_IPSEC_IKE_NO_PUBLIC_KEY                                                  = 0x00003604U,
    ERROR_IPSEC_IKE_PROCESS_ERR                                                    = 0x00003605U,
    ERROR_IPSEC_IKE_PROCESS_ERR_SA                                                 = 0x00003606U,
    ERROR_IPSEC_IKE_PROCESS_ERR_PROP                                               = 0x00003607U,
    ERROR_IPSEC_IKE_PROCESS_ERR_TRANS                                              = 0x00003608U,
    ERROR_IPSEC_IKE_PROCESS_ERR_KE                                                 = 0x00003609U,
    ERROR_IPSEC_IKE_PROCESS_ERR_ID                                                 = 0x0000360aU,
    ERROR_IPSEC_IKE_PROCESS_ERR_CERT                                               = 0x0000360bU,
    ERROR_IPSEC_IKE_PROCESS_ERR_CERT_REQ                                           = 0x0000360cU,
    ERROR_IPSEC_IKE_PROCESS_ERR_HASH                                               = 0x0000360dU,
    ERROR_IPSEC_IKE_PROCESS_ERR_SIG                                                = 0x0000360eU,
    ERROR_IPSEC_IKE_PROCESS_ERR_NONCE                                              = 0x0000360fU,
    ERROR_IPSEC_IKE_PROCESS_ERR_NOTIFY                                             = 0x00003610U,
    ERROR_IPSEC_IKE_PROCESS_ERR_DELETE                                             = 0x00003611U,
    ERROR_IPSEC_IKE_PROCESS_ERR_VENDOR                                             = 0x00003612U,
    ERROR_IPSEC_IKE_INVALID_PAYLOAD                                                = 0x00003613U,
    ERROR_IPSEC_IKE_LOAD_SOFT_SA                                                   = 0x00003614U,
    ERROR_IPSEC_IKE_SOFT_SA_TORN_DOWN                                              = 0x00003615U,
    ERROR_IPSEC_IKE_INVALID_COOKIE                                                 = 0x00003616U,
    ERROR_IPSEC_IKE_NO_PEER_CERT                                                   = 0x00003617U,
    ERROR_IPSEC_IKE_PEER_CRL_FAILED                                                = 0x00003618U,
    ERROR_IPSEC_IKE_POLICY_CHANGE                                                  = 0x00003619U,
    ERROR_IPSEC_IKE_NO_MM_POLICY                                                   = 0x0000361aU,
    ERROR_IPSEC_IKE_NOTCBPRIV                                                      = 0x0000361bU,
    ERROR_IPSEC_IKE_SECLOADFAIL                                                    = 0x0000361cU,
    ERROR_IPSEC_IKE_FAILSSPINIT                                                    = 0x0000361dU,
    ERROR_IPSEC_IKE_FAILQUERYSSP                                                   = 0x0000361eU,
    ERROR_IPSEC_IKE_SRVACQFAIL                                                     = 0x0000361fU,
    ERROR_IPSEC_IKE_SRVQUERYCRED                                                   = 0x00003620U,
    ERROR_IPSEC_IKE_GETSPIFAIL                                                     = 0x00003621U,
    ERROR_IPSEC_IKE_INVALID_FILTER                                                 = 0x00003622U,
    ERROR_IPSEC_IKE_OUT_OF_MEMORY                                                  = 0x00003623U,
    ERROR_IPSEC_IKE_ADD_UPDATE_KEY_FAILED                                          = 0x00003624U,
    ERROR_IPSEC_IKE_INVALID_POLICY                                                 = 0x00003625U,
    ERROR_IPSEC_IKE_UNKNOWN_DOI                                                    = 0x00003626U,
    ERROR_IPSEC_IKE_INVALID_SITUATION                                              = 0x00003627U,
    ERROR_IPSEC_IKE_DH_FAILURE                                                     = 0x00003628U,
    ERROR_IPSEC_IKE_INVALID_GROUP                                                  = 0x00003629U,
    ERROR_IPSEC_IKE_ENCRYPT                                                        = 0x0000362aU,
    ERROR_IPSEC_IKE_DECRYPT                                                        = 0x0000362bU,
    ERROR_IPSEC_IKE_POLICY_MATCH                                                   = 0x0000362cU,
    ERROR_IPSEC_IKE_UNSUPPORTED_ID                                                 = 0x0000362dU,
    ERROR_IPSEC_IKE_INVALID_HASH                                                   = 0x0000362eU,
    ERROR_IPSEC_IKE_INVALID_HASH_ALG                                               = 0x0000362fU,
    ERROR_IPSEC_IKE_INVALID_HASH_SIZE                                              = 0x00003630U,
    ERROR_IPSEC_IKE_INVALID_ENCRYPT_ALG                                            = 0x00003631U,
    ERROR_IPSEC_IKE_INVALID_AUTH_ALG                                               = 0x00003632U,
    ERROR_IPSEC_IKE_INVALID_SIG                                                    = 0x00003633U,
    ERROR_IPSEC_IKE_LOAD_FAILED                                                    = 0x00003634U,
    ERROR_IPSEC_IKE_RPC_DELETE                                                     = 0x00003635U,
    ERROR_IPSEC_IKE_BENIGN_REINIT                                                  = 0x00003636U,
    ERROR_IPSEC_IKE_INVALID_RESPONDER_LIFETIME_NOTIFY                              = 0x00003637U,
    ERROR_IPSEC_IKE_INVALID_MAJOR_VERSION                                          = 0x00003638U,
    ERROR_IPSEC_IKE_INVALID_CERT_KEYLEN                                            = 0x00003639U,
    ERROR_IPSEC_IKE_MM_LIMIT                                                       = 0x0000363aU,
    ERROR_IPSEC_IKE_NEGOTIATION_DISABLED                                           = 0x0000363bU,
    ERROR_IPSEC_IKE_QM_LIMIT                                                       = 0x0000363cU,
    ERROR_IPSEC_IKE_MM_EXPIRED                                                     = 0x0000363dU,
    ERROR_IPSEC_IKE_PEER_MM_ASSUMED_INVALID                                        = 0x0000363eU,
    ERROR_IPSEC_IKE_CERT_CHAIN_POLICY_MISMATCH                                     = 0x0000363fU,
    ERROR_IPSEC_IKE_UNEXPECTED_MESSAGE_ID                                          = 0x00003640U,
    ERROR_IPSEC_IKE_INVALID_AUTH_PAYLOAD                                           = 0x00003641U,
    ERROR_IPSEC_IKE_DOS_COOKIE_SENT                                                = 0x00003642U,
    ERROR_IPSEC_IKE_SHUTTING_DOWN                                                  = 0x00003643U,
    ERROR_IPSEC_IKE_CGA_AUTH_FAILED                                                = 0x00003644U,
    ERROR_IPSEC_IKE_PROCESS_ERR_NATOA                                              = 0x00003645U,
    ERROR_IPSEC_IKE_INVALID_MM_FOR_QM                                              = 0x00003646U,
    ERROR_IPSEC_IKE_QM_EXPIRED                                                     = 0x00003647U,
    ERROR_IPSEC_IKE_TOO_MANY_FILTERS                                               = 0x00003648U,
    ERROR_IPSEC_IKE_NEG_STATUS_END                                                 = 0x00003649U,
    ERROR_IPSEC_IKE_KILL_DUMMY_NAP_TUNNEL                                          = 0x0000364aU,
    ERROR_IPSEC_IKE_INNER_IP_ASSIGNMENT_FAILURE                                    = 0x0000364bU,
    ERROR_IPSEC_IKE_REQUIRE_CP_PAYLOAD_MISSING                                     = 0x0000364cU,
    ERROR_IPSEC_KEY_MODULE_IMPERSONATION_NEGOTIATION_PENDING                       = 0x0000364dU,
    ERROR_IPSEC_IKE_COEXISTENCE_SUPPRESS                                           = 0x0000364eU,
    ERROR_IPSEC_IKE_RATELIMIT_DROP                                                 = 0x0000364fU,
    ERROR_IPSEC_IKE_PEER_DOESNT_SUPPORT_MOBIKE                                     = 0x00003650U,
    ERROR_IPSEC_IKE_AUTHORIZATION_FAILURE                                          = 0x00003651U,
    ERROR_IPSEC_IKE_STRONG_CRED_AUTHORIZATION_FAILURE                              = 0x00003652U,
    ERROR_IPSEC_IKE_AUTHORIZATION_FAILURE_WITH_OPTIONAL_RETRY                      = 0x00003653U,
    ERROR_IPSEC_IKE_STRONG_CRED_AUTHORIZATION_AND_CERTMAP_FAILURE                  = 0x00003654U,
    ERROR_IPSEC_IKE_NEG_STATUS_EXTENDED_END                                        = 0x00003655U,
    ERROR_IPSEC_BAD_SPI                                                            = 0x00003656U,
    ERROR_IPSEC_SA_LIFETIME_EXPIRED                                                = 0x00003657U,
    ERROR_IPSEC_WRONG_SA                                                           = 0x00003658U,
    ERROR_IPSEC_REPLAY_CHECK_FAILED                                                = 0x00003659U,
    ERROR_IPSEC_INVALID_PACKET                                                     = 0x0000365aU,
    ERROR_IPSEC_INTEGRITY_CHECK_FAILED                                             = 0x0000365bU,
    ERROR_IPSEC_CLEAR_TEXT_DROP                                                    = 0x0000365cU,
    ERROR_IPSEC_AUTH_FIREWALL_DROP                                                 = 0x0000365dU,
    ERROR_IPSEC_THROTTLE_DROP                                                      = 0x0000365eU,
    ERROR_IPSEC_DOSP_BLOCK                                                         = 0x00003665U,
    ERROR_IPSEC_DOSP_RECEIVED_MULTICAST                                            = 0x00003666U,
    ERROR_IPSEC_DOSP_INVALID_PACKET                                                = 0x00003667U,
    ERROR_IPSEC_DOSP_STATE_LOOKUP_FAILED                                           = 0x00003668U,
    ERROR_IPSEC_DOSP_MAX_ENTRIES                                                   = 0x00003669U,
    ERROR_IPSEC_DOSP_KEYMOD_NOT_ALLOWED                                            = 0x0000366aU,
    ERROR_IPSEC_DOSP_NOT_INSTALLED                                                 = 0x0000366bU,
    ERROR_IPSEC_DOSP_MAX_PER_IP_RATELIMIT_QUEUES                                   = 0x0000366cU,
    ERROR_SXS_SECTION_NOT_FOUND                                                    = 0x000036b0U,
    ERROR_SXS_CANT_GEN_ACTCTX                                                      = 0x000036b1U,
    ERROR_SXS_INVALID_ACTCTXDATA_FORMAT                                            = 0x000036b2U,
    ERROR_SXS_ASSEMBLY_NOT_FOUND                                                   = 0x000036b3U,
    ERROR_SXS_MANIFEST_FORMAT_ERROR                                                = 0x000036b4U,
    ERROR_SXS_MANIFEST_PARSE_ERROR                                                 = 0x000036b5U,
    ERROR_SXS_ACTIVATION_CONTEXT_DISABLED                                          = 0x000036b6U,
    ERROR_SXS_KEY_NOT_FOUND                                                        = 0x000036b7U,
    ERROR_SXS_VERSION_CONFLICT                                                     = 0x000036b8U,
    ERROR_SXS_WRONG_SECTION_TYPE                                                   = 0x000036b9U,
    ERROR_SXS_THREAD_QUERIES_DISABLED                                              = 0x000036baU,
    ERROR_SXS_PROCESS_DEFAULT_ALREADY_SET                                          = 0x000036bbU,
    ERROR_SXS_UNKNOWN_ENCODING_GROUP                                               = 0x000036bcU,
    ERROR_SXS_UNKNOWN_ENCODING                                                     = 0x000036bdU,
    ERROR_SXS_INVALID_XML_NAMESPACE_URI                                            = 0x000036beU,
    ERROR_SXS_ROOT_MANIFEST_DEPENDENCY_NOT_INSTALLED                               = 0x000036bfU,
    ERROR_SXS_LEAF_MANIFEST_DEPENDENCY_NOT_INSTALLED                               = 0x000036c0U,
    ERROR_SXS_INVALID_ASSEMBLY_IDENTITY_ATTRIBUTE                                  = 0x000036c1U,
    ERROR_SXS_MANIFEST_MISSING_REQUIRED_DEFAULT_NAMESPACE                          = 0x000036c2U,
    ERROR_SXS_MANIFEST_INVALID_REQUIRED_DEFAULT_NAMESPACE                          = 0x000036c3U,
    ERROR_SXS_PRIVATE_MANIFEST_CROSS_PATH_WITH_REPARSE_POINT                       = 0x000036c4U,
    ERROR_SXS_DUPLICATE_DLL_NAME                                                   = 0x000036c5U,
    ERROR_SXS_DUPLICATE_WINDOWCLASS_NAME                                           = 0x000036c6U,
    ERROR_SXS_DUPLICATE_CLSID                                                      = 0x000036c7U,
    ERROR_SXS_DUPLICATE_IID                                                        = 0x000036c8U,
    ERROR_SXS_DUPLICATE_TLBID                                                      = 0x000036c9U,
    ERROR_SXS_DUPLICATE_PROGID                                                     = 0x000036caU,
    ERROR_SXS_DUPLICATE_ASSEMBLY_NAME                                              = 0x000036cbU,
    ERROR_SXS_FILE_HASH_MISMATCH                                                   = 0x000036ccU,
    ERROR_SXS_POLICY_PARSE_ERROR                                                   = 0x000036cdU,
    ERROR_SXS_XML_E_MISSINGQUOTE                                                   = 0x000036ceU,
    ERROR_SXS_XML_E_COMMENTSYNTAX                                                  = 0x000036cfU,
    ERROR_SXS_XML_E_BADSTARTNAMECHAR                                               = 0x000036d0U,
    ERROR_SXS_XML_E_BADNAMECHAR                                                    = 0x000036d1U,
    ERROR_SXS_XML_E_BADCHARINSTRING                                                = 0x000036d2U,
    ERROR_SXS_XML_E_XMLDECLSYNTAX                                                  = 0x000036d3U,
    ERROR_SXS_XML_E_BADCHARDATA                                                    = 0x000036d4U,
    ERROR_SXS_XML_E_MISSINGWHITESPACE                                              = 0x000036d5U,
    ERROR_SXS_XML_E_EXPECTINGTAGEND                                                = 0x000036d6U,
    ERROR_SXS_XML_E_MISSINGSEMICOLON                                               = 0x000036d7U,
    ERROR_SXS_XML_E_UNBALANCEDPAREN                                                = 0x000036d8U,
    ERROR_SXS_XML_E_INTERNALERROR                                                  = 0x000036d9U,
    ERROR_SXS_XML_E_UNEXPECTED_WHITESPACE                                          = 0x000036daU,
    ERROR_SXS_XML_E_INCOMPLETE_ENCODING                                            = 0x000036dbU,
    ERROR_SXS_XML_E_MISSING_PAREN                                                  = 0x000036dcU,
    ERROR_SXS_XML_E_EXPECTINGCLOSEQUOTE                                            = 0x000036ddU,
    ERROR_SXS_XML_E_MULTIPLE_COLONS                                                = 0x000036deU,
    ERROR_SXS_XML_E_INVALID_DECIMAL                                                = 0x000036dfU,
    ERROR_SXS_XML_E_INVALID_HEXIDECIMAL                                            = 0x000036e0U,
    ERROR_SXS_XML_E_INVALID_UNICODE                                                = 0x000036e1U,
    ERROR_SXS_XML_E_WHITESPACEORQUESTIONMARK                                       = 0x000036e2U,
    ERROR_SXS_XML_E_UNEXPECTEDENDTAG                                               = 0x000036e3U,
    ERROR_SXS_XML_E_UNCLOSEDTAG                                                    = 0x000036e4U,
    ERROR_SXS_XML_E_DUPLICATEATTRIBUTE                                             = 0x000036e5U,
    ERROR_SXS_XML_E_MULTIPLEROOTS                                                  = 0x000036e6U,
    ERROR_SXS_XML_E_INVALIDATROOTLEVEL                                             = 0x000036e7U,
    ERROR_SXS_XML_E_BADXMLDECL                                                     = 0x000036e8U,
    ERROR_SXS_XML_E_MISSINGROOT                                                    = 0x000036e9U,
    ERROR_SXS_XML_E_UNEXPECTEDEOF                                                  = 0x000036eaU,
    ERROR_SXS_XML_E_BADPEREFINSUBSET                                               = 0x000036ebU,
    ERROR_SXS_XML_E_UNCLOSEDSTARTTAG                                               = 0x000036ecU,
    ERROR_SXS_XML_E_UNCLOSEDENDTAG                                                 = 0x000036edU,
    ERROR_SXS_XML_E_UNCLOSEDSTRING                                                 = 0x000036eeU,
    ERROR_SXS_XML_E_UNCLOSEDCOMMENT                                                = 0x000036efU,
    ERROR_SXS_XML_E_UNCLOSEDDECL                                                   = 0x000036f0U,
    ERROR_SXS_XML_E_UNCLOSEDCDATA                                                  = 0x000036f1U,
    ERROR_SXS_XML_E_RESERVEDNAMESPACE                                              = 0x000036f2U,
    ERROR_SXS_XML_E_INVALIDENCODING                                                = 0x000036f3U,
    ERROR_SXS_XML_E_INVALIDSWITCH                                                  = 0x000036f4U,
    ERROR_SXS_XML_E_BADXMLCASE                                                     = 0x000036f5U,
    ERROR_SXS_XML_E_INVALID_STANDALONE                                             = 0x000036f6U,
    ERROR_SXS_XML_E_UNEXPECTED_STANDALONE                                          = 0x000036f7U,
    ERROR_SXS_XML_E_INVALID_VERSION                                                = 0x000036f8U,
    ERROR_SXS_XML_E_MISSINGEQUALS                                                  = 0x000036f9U,
    ERROR_SXS_PROTECTION_RECOVERY_FAILED                                           = 0x000036faU,
    ERROR_SXS_PROTECTION_PUBLIC_KEY_TOO_SHORT                                      = 0x000036fbU,
    ERROR_SXS_PROTECTION_CATALOG_NOT_VALID                                         = 0x000036fcU,
    ERROR_SXS_UNTRANSLATABLE_HRESULT                                               = 0x000036fdU,
    ERROR_SXS_PROTECTION_CATALOG_FILE_MISSING                                      = 0x000036feU,
    ERROR_SXS_MISSING_ASSEMBLY_IDENTITY_ATTRIBUTE                                  = 0x000036ffU,
    ERROR_SXS_INVALID_ASSEMBLY_IDENTITY_ATTRIBUTE_NAME                             = 0x00003700U,
    ERROR_SXS_ASSEMBLY_MISSING                                                     = 0x00003701U,
    ERROR_SXS_CORRUPT_ACTIVATION_STACK                                             = 0x00003702U,
    ERROR_SXS_CORRUPTION                                                           = 0x00003703U,
    ERROR_SXS_EARLY_DEACTIVATION                                                   = 0x00003704U,
    ERROR_SXS_INVALID_DEACTIVATION                                                 = 0x00003705U,
    ERROR_SXS_MULTIPLE_DEACTIVATION                                                = 0x00003706U,
    ERROR_SXS_PROCESS_TERMINATION_REQUESTED                                        = 0x00003707U,
    ERROR_SXS_RELEASE_ACTIVATION_CONTEXT                                           = 0x00003708U,
    ERROR_SXS_SYSTEM_DEFAULT_ACTIVATION_CONTEXT_EMPTY                              = 0x00003709U,
    ERROR_SXS_INVALID_IDENTITY_ATTRIBUTE_VALUE                                     = 0x0000370aU,
    ERROR_SXS_INVALID_IDENTITY_ATTRIBUTE_NAME                                      = 0x0000370bU,
    ERROR_SXS_IDENTITY_DUPLICATE_ATTRIBUTE                                         = 0x0000370cU,
    ERROR_SXS_IDENTITY_PARSE_ERROR                                                 = 0x0000370dU,
    ERROR_MALFORMED_SUBSTITUTION_STRING                                            = 0x0000370eU,
    ERROR_SXS_INCORRECT_PUBLIC_KEY_TOKEN                                           = 0x0000370fU,
    ERROR_UNMAPPED_SUBSTITUTION_STRING                                             = 0x00003710U,
    ERROR_SXS_ASSEMBLY_NOT_LOCKED                                                  = 0x00003711U,
    ERROR_SXS_COMPONENT_STORE_CORRUPT                                              = 0x00003712U,
    ERROR_ADVANCED_INSTALLER_FAILED                                                = 0x00003713U,
    ERROR_XML_ENCODING_MISMATCH                                                    = 0x00003714U,
    ERROR_SXS_MANIFEST_IDENTITY_SAME_BUT_CONTENTS_DIFFERENT                        = 0x00003715U,
    ERROR_SXS_IDENTITIES_DIFFERENT                                                 = 0x00003716U,
    ERROR_SXS_ASSEMBLY_IS_NOT_A_DEPLOYMENT                                         = 0x00003717U,
    ERROR_SXS_FILE_NOT_PART_OF_ASSEMBLY                                            = 0x00003718U,
    ERROR_SXS_MANIFEST_TOO_BIG                                                     = 0x00003719U,
    ERROR_SXS_SETTING_NOT_REGISTERED                                               = 0x0000371aU,
    ERROR_SXS_TRANSACTION_CLOSURE_INCOMPLETE                                       = 0x0000371bU,
    ERROR_SMI_PRIMITIVE_INSTALLER_FAILED                                           = 0x0000371cU,
    ERROR_GENERIC_COMMAND_FAILED                                                   = 0x0000371dU,
    ERROR_SXS_FILE_HASH_MISSING                                                    = 0x0000371eU,
    ERROR_SXS_DUPLICATE_ACTIVATABLE_CLASS                                          = 0x0000371fU,
    ERROR_EVT_INVALID_CHANNEL_PATH                                                 = 0x00003a98U,
    ERROR_EVT_INVALID_QUERY                                                        = 0x00003a99U,
    ERROR_EVT_PUBLISHER_METADATA_NOT_FOUND                                         = 0x00003a9aU,
    ERROR_EVT_EVENT_TEMPLATE_NOT_FOUND                                             = 0x00003a9bU,
    ERROR_EVT_INVALID_PUBLISHER_NAME                                               = 0x00003a9cU,
    ERROR_EVT_INVALID_EVENT_DATA                                                   = 0x00003a9dU,
    ERROR_EVT_CHANNEL_NOT_FOUND                                                    = 0x00003a9fU,
    ERROR_EVT_MALFORMED_XML_TEXT                                                   = 0x00003aa0U,
    ERROR_EVT_SUBSCRIPTION_TO_DIRECT_CHANNEL                                       = 0x00003aa1U,
    ERROR_EVT_CONFIGURATION_ERROR                                                  = 0x00003aa2U,
    ERROR_EVT_QUERY_RESULT_STALE                                                   = 0x00003aa3U,
    ERROR_EVT_QUERY_RESULT_INVALID_POSITION                                        = 0x00003aa4U,
    ERROR_EVT_NON_VALIDATING_MSXML                                                 = 0x00003aa5U,
    ERROR_EVT_FILTER_ALREADYSCOPED                                                 = 0x00003aa6U,
    ERROR_EVT_FILTER_NOTELTSET                                                     = 0x00003aa7U,
    ERROR_EVT_FILTER_INVARG                                                        = 0x00003aa8U,
    ERROR_EVT_FILTER_INVTEST                                                       = 0x00003aa9U,
    ERROR_EVT_FILTER_INVTYPE                                                       = 0x00003aaaU,
    ERROR_EVT_FILTER_PARSEERR                                                      = 0x00003aabU,
    ERROR_EVT_FILTER_UNSUPPORTEDOP                                                 = 0x00003aacU,
    ERROR_EVT_FILTER_UNEXPECTEDTOKEN                                               = 0x00003aadU,
    ERROR_EVT_INVALID_OPERATION_OVER_ENABLED_DIRECT_CHANNEL                        = 0x00003aaeU,
    ERROR_EVT_INVALID_CHANNEL_PROPERTY_VALUE                                       = 0x00003aafU,
    ERROR_EVT_INVALID_PUBLISHER_PROPERTY_VALUE                                     = 0x00003ab0U,
    ERROR_EVT_CHANNEL_CANNOT_ACTIVATE                                              = 0x00003ab1U,
    ERROR_EVT_FILTER_TOO_COMPLEX                                                   = 0x00003ab2U,
    ERROR_EVT_MESSAGE_NOT_FOUND                                                    = 0x00003ab3U,
    ERROR_EVT_MESSAGE_ID_NOT_FOUND                                                 = 0x00003ab4U,
    ERROR_EVT_UNRESOLVED_VALUE_INSERT                                              = 0x00003ab5U,
    ERROR_EVT_UNRESOLVED_PARAMETER_INSERT                                          = 0x00003ab6U,
    ERROR_EVT_MAX_INSERTS_REACHED                                                  = 0x00003ab7U,
    ERROR_EVT_EVENT_DEFINITION_NOT_FOUND                                           = 0x00003ab8U,
    ERROR_EVT_MESSAGE_LOCALE_NOT_FOUND                                             = 0x00003ab9U,
    ERROR_EVT_VERSION_TOO_OLD                                                      = 0x00003abaU,
    ERROR_EVT_VERSION_TOO_NEW                                                      = 0x00003abbU,
    ERROR_EVT_CANNOT_OPEN_CHANNEL_OF_QUERY                                         = 0x00003abcU,
    ERROR_EVT_PUBLISHER_DISABLED                                                   = 0x00003abdU,
    ERROR_EVT_FILTER_OUT_OF_RANGE                                                  = 0x00003abeU,
    ERROR_EC_SUBSCRIPTION_CANNOT_ACTIVATE                                          = 0x00003ae8U,
    ERROR_EC_LOG_DISABLED                                                          = 0x00003ae9U,
    ERROR_EC_CIRCULAR_FORWARDING                                                   = 0x00003aeaU,
    ERROR_EC_CREDSTORE_FULL                                                        = 0x00003aebU,
    ERROR_EC_CRED_NOT_FOUND                                                        = 0x00003aecU,
    ERROR_EC_NO_ACTIVE_CHANNEL                                                     = 0x00003aedU,
    ERROR_MUI_FILE_NOT_FOUND                                                       = 0x00003afcU,
    ERROR_MUI_INVALID_FILE                                                         = 0x00003afdU,
    ERROR_MUI_INVALID_RC_CONFIG                                                    = 0x00003afeU,
    ERROR_MUI_INVALID_LOCALE_NAME                                                  = 0x00003affU,
    ERROR_MUI_INVALID_ULTIMATEFALLBACK_NAME                                        = 0x00003b00U,
    ERROR_MUI_FILE_NOT_LOADED                                                      = 0x00003b01U,
    ERROR_RESOURCE_ENUM_USER_STOP                                                  = 0x00003b02U,
    ERROR_MUI_INTLSETTINGS_UILANG_NOT_INSTALLED                                    = 0x00003b03U,
    ERROR_MUI_INTLSETTINGS_INVALID_LOCALE_NAME                                     = 0x00003b04U,
    ERROR_MRM_RUNTIME_NO_DEFAULT_OR_NEUTRAL_RESOURCE                               = 0x00003b06U,
    ERROR_MRM_INVALID_PRICONFIG                                                    = 0x00003b07U,
    ERROR_MRM_INVALID_FILE_TYPE                                                    = 0x00003b08U,
    ERROR_MRM_UNKNOWN_QUALIFIER                                                    = 0x00003b09U,
    ERROR_MRM_INVALID_QUALIFIER_VALUE                                              = 0x00003b0aU,
    ERROR_MRM_NO_CANDIDATE                                                         = 0x00003b0bU,
    ERROR_MRM_NO_MATCH_OR_DEFAULT_CANDIDATE                                        = 0x00003b0cU,
    ERROR_MRM_RESOURCE_TYPE_MISMATCH                                               = 0x00003b0dU,
    ERROR_MRM_DUPLICATE_MAP_NAME                                                   = 0x00003b0eU,
    ERROR_MRM_DUPLICATE_ENTRY                                                      = 0x00003b0fU,
    ERROR_MRM_INVALID_RESOURCE_IDENTIFIER                                          = 0x00003b10U,
    ERROR_MRM_FILEPATH_TOO_LONG                                                    = 0x00003b11U,
    ERROR_MRM_UNSUPPORTED_DIRECTORY_TYPE                                           = 0x00003b12U,
    ERROR_MRM_INVALID_PRI_FILE                                                     = 0x00003b16U,
    ERROR_MRM_NAMED_RESOURCE_NOT_FOUND                                             = 0x00003b17U,
    ERROR_MRM_MAP_NOT_FOUND                                                        = 0x00003b1fU,
    ERROR_MRM_UNSUPPORTED_PROFILE_TYPE                                             = 0x00003b20U,
    ERROR_MRM_INVALID_QUALIFIER_OPERATOR                                           = 0x00003b21U,
    ERROR_MRM_INDETERMINATE_QUALIFIER_VALUE                                        = 0x00003b22U,
    ERROR_MRM_AUTOMERGE_ENABLED                                                    = 0x00003b23U,
    ERROR_MRM_TOO_MANY_RESOURCES                                                   = 0x00003b24U,
    ERROR_MRM_UNSUPPORTED_FILE_TYPE_FOR_MERGE                                      = 0x00003b25U,
    ERROR_MRM_UNSUPPORTED_FILE_TYPE_FOR_LOAD_UNLOAD_PRI_FILE                       = 0x00003b26U,
    ERROR_MRM_NO_CURRENT_VIEW_ON_THREAD                                            = 0x00003b27U,
    ERROR_DIFFERENT_PROFILE_RESOURCE_MANAGER_EXIST                                 = 0x00003b28U,
    ERROR_OPERATION_NOT_ALLOWED_FROM_SYSTEM_COMPONENT                              = 0x00003b29U,
    ERROR_MRM_DIRECT_REF_TO_NON_DEFAULT_RESOURCE                                   = 0x00003b2aU,
    ERROR_MRM_GENERATION_COUNT_MISMATCH                                            = 0x00003b2bU,
    ERROR_PRI_MERGE_VERSION_MISMATCH                                               = 0x00003b2cU,
    ERROR_PRI_MERGE_MISSING_SCHEMA                                                 = 0x00003b2dU,
    ERROR_PRI_MERGE_LOAD_FILE_FAILED                                               = 0x00003b2eU,
    ERROR_PRI_MERGE_ADD_FILE_FAILED                                                = 0x00003b2fU,
    ERROR_PRI_MERGE_WRITE_FILE_FAILED                                              = 0x00003b30U,
    ERROR_PRI_MERGE_MULTIPLE_PACKAGE_FAMILIES_NOT_ALLOWED                          = 0x00003b31U,
    ERROR_PRI_MERGE_MULTIPLE_MAIN_PACKAGES_NOT_ALLOWED                             = 0x00003b32U,
    ERROR_PRI_MERGE_BUNDLE_PACKAGES_NOT_ALLOWED                                    = 0x00003b33U,
    ERROR_PRI_MERGE_MAIN_PACKAGE_REQUIRED                                          = 0x00003b34U,
    ERROR_PRI_MERGE_RESOURCE_PACKAGE_REQUIRED                                      = 0x00003b35U,
    ERROR_PRI_MERGE_INVALID_FILE_NAME                                              = 0x00003b36U,
    ERROR_MRM_PACKAGE_NOT_FOUND                                                    = 0x00003b37U,
    ERROR_MRM_MISSING_DEFAULT_LANGUAGE                                             = 0x00003b38U,
    ERROR_MRM_SCOPE_ITEM_CONFLICT                                                  = 0x00003b39U,
    ERROR_MCA_INVALID_CAPABILITIES_STRING                                          = 0x00003b60U,
    ERROR_MCA_INVALID_VCP_VERSION                                                  = 0x00003b61U,
    ERROR_MCA_MONITOR_VIOLATES_MCCS_SPECIFICATION                                  = 0x00003b62U,
    ERROR_MCA_MCCS_VERSION_MISMATCH                                                = 0x00003b63U,
    ERROR_MCA_UNSUPPORTED_MCCS_VERSION                                             = 0x00003b64U,
    ERROR_MCA_INTERNAL_ERROR                                                       = 0x00003b65U,
    ERROR_MCA_INVALID_TECHNOLOGY_TYPE_RETURNED                                     = 0x00003b66U,
    ERROR_MCA_UNSUPPORTED_COLOR_TEMPERATURE                                        = 0x00003b67U,
    ERROR_AMBIGUOUS_SYSTEM_DEVICE                                                  = 0x00003b92U,
    ERROR_SYSTEM_DEVICE_NOT_FOUND                                                  = 0x00003bc3U,
    ERROR_HASH_NOT_SUPPORTED                                                       = 0x00003bc4U,
    ERROR_HASH_NOT_PRESENT                                                         = 0x00003bc5U,
    ERROR_SECONDARY_IC_PROVIDER_NOT_REGISTERED                                     = 0x00003bd9U,
    ERROR_GPIO_CLIENT_INFORMATION_INVALID                                          = 0x00003bdaU,
    ERROR_GPIO_VERSION_NOT_SUPPORTED                                               = 0x00003bdbU,
    ERROR_GPIO_INVALID_REGISTRATION_PACKET                                         = 0x00003bdcU,
    ERROR_GPIO_OPERATION_DENIED                                                    = 0x00003bddU,
    ERROR_GPIO_INCOMPATIBLE_CONNECT_MODE                                           = 0x00003bdeU,
    ERROR_GPIO_INTERRUPT_ALREADY_UNMASKED                                          = 0x00003bdfU,
    ERROR_CANNOT_COMPOSE_APISET_EXTENSION                                          = 0x00003c14U,
    ERROR_APISET_SCHEMA_VERSION_NOT_SUPPORTED                                      = 0x00003c15U,
    ERROR_CANNOT_SWITCH_RUNLEVEL                                                   = 0x00003c28U,
    ERROR_INVALID_RUNLEVEL_SETTING                                                 = 0x00003c29U,
    ERROR_RUNLEVEL_SWITCH_TIMEOUT                                                  = 0x00003c2aU,
    ERROR_RUNLEVEL_SWITCH_AGENT_TIMEOUT                                            = 0x00003c2bU,
    ERROR_RUNLEVEL_SWITCH_IN_PROGRESS                                              = 0x00003c2cU,
    ERROR_SERVICES_FAILED_AUTOSTART                                                = 0x00003c2dU,
    ERROR_COM_TASK_STOP_PENDING                                                    = 0x00003c8dU,
    ERROR_INSTALL_OPEN_PACKAGE_FAILED                                              = 0x00003cf0U,
    ERROR_INSTALL_PACKAGE_NOT_FOUND                                                = 0x00003cf1U,
    ERROR_INSTALL_INVALID_PACKAGE                                                  = 0x00003cf2U,
    ERROR_INSTALL_RESOLVE_DEPENDENCY_FAILED                                        = 0x00003cf3U,
    ERROR_INSTALL_OUT_OF_DISK_SPACE                                                = 0x00003cf4U,
    ERROR_INSTALL_NETWORK_FAILURE                                                  = 0x00003cf5U,
    ERROR_INSTALL_REGISTRATION_FAILURE                                             = 0x00003cf6U,
    ERROR_INSTALL_DEREGISTRATION_FAILURE                                           = 0x00003cf7U,
    ERROR_INSTALL_CANCEL                                                           = 0x00003cf8U,
    ERROR_INSTALL_FAILED                                                           = 0x00003cf9U,
    ERROR_REMOVE_FAILED                                                            = 0x00003cfaU,
    ERROR_PACKAGE_ALREADY_EXISTS                                                   = 0x00003cfbU,
    ERROR_NEEDS_REMEDIATION                                                        = 0x00003cfcU,
    ERROR_INSTALL_PREREQUISITE_FAILED                                              = 0x00003cfdU,
    ERROR_PACKAGE_REPOSITORY_CORRUPTED                                             = 0x00003cfeU,
    ERROR_INSTALL_POLICY_FAILURE                                                   = 0x00003cffU,
    ERROR_PACKAGE_UPDATING                                                         = 0x00003d00U,
    ERROR_DEPLOYMENT_BLOCKED_BY_POLICY                                             = 0x00003d01U,
    ERROR_PACKAGES_IN_USE                                                          = 0x00003d02U,
    ERROR_RECOVERY_FILE_CORRUPT                                                    = 0x00003d03U,
    ERROR_INVALID_STAGED_SIGNATURE                                                 = 0x00003d04U,
    ERROR_DELETING_EXISTING_APPLICATIONDATA_STORE_FAILED                           = 0x00003d05U,
    ERROR_INSTALL_PACKAGE_DOWNGRADE                                                = 0x00003d06U,
    ERROR_SYSTEM_NEEDS_REMEDIATION                                                 = 0x00003d07U,
    ERROR_APPX_INTEGRITY_FAILURE_CLR_NGEN                                          = 0x00003d08U,
    ERROR_RESILIENCY_FILE_CORRUPT                                                  = 0x00003d09U,
    ERROR_INSTALL_FIREWALL_SERVICE_NOT_RUNNING                                     = 0x00003d0aU,
    ERROR_PACKAGE_MOVE_FAILED                                                      = 0x00003d0bU,
    ERROR_INSTALL_VOLUME_NOT_EMPTY                                                 = 0x00003d0cU,
    ERROR_INSTALL_VOLUME_OFFLINE                                                   = 0x00003d0dU,
    ERROR_INSTALL_VOLUME_CORRUPT                                                   = 0x00003d0eU,
    ERROR_NEEDS_REGISTRATION                                                       = 0x00003d0fU,
    ERROR_INSTALL_WRONG_PROCESSOR_ARCHITECTURE                                     = 0x00003d10U,
    ERROR_DEV_SIDELOAD_LIMIT_EXCEEDED                                              = 0x00003d11U,
    ERROR_INSTALL_OPTIONAL_PACKAGE_REQUIRES_MAIN_PACKAGE                           = 0x00003d12U,
    ERROR_PACKAGE_NOT_SUPPORTED_ON_FILESYSTEM                                      = 0x00003d13U,
    ERROR_PACKAGE_MOVE_BLOCKED_BY_STREAMING                                        = 0x00003d14U,
    ERROR_INSTALL_OPTIONAL_PACKAGE_APPLICATIONID_NOT_UNIQUE                        = 0x00003d15U,
    ERROR_PACKAGE_STAGING_ONHOLD                                                   = 0x00003d16U,
    ERROR_INSTALL_INVALID_RELATED_SET_UPDATE                                       = 0x00003d17U,
    ERROR_INSTALL_OPTIONAL_PACKAGE_REQUIRES_MAIN_PACKAGE_FULLTRUST_CAPABILITY      = 0x00003d18U,
    ERROR_DEPLOYMENT_BLOCKED_BY_USER_LOG_OFF                                       = 0x00003d19U,
    ERROR_PROVISION_OPTIONAL_PACKAGE_REQUIRES_MAIN_PACKAGE_PROVISIONED             = 0x00003d1aU,
    ERROR_PACKAGES_REPUTATION_CHECK_FAILED                                         = 0x00003d1bU,
    ERROR_PACKAGES_REPUTATION_CHECK_TIMEDOUT                                       = 0x00003d1cU,
    ERROR_DEPLOYMENT_OPTION_NOT_SUPPORTED                                          = 0x00003d1dU,
    ERROR_APPINSTALLER_ACTIVATION_BLOCKED                                          = 0x00003d1eU,
    ERROR_REGISTRATION_FROM_REMOTE_DRIVE_NOT_SUPPORTED                             = 0x00003d1fU,
    ERROR_APPX_RAW_DATA_WRITE_FAILED                                               = 0x00003d20U,
    ERROR_DEPLOYMENT_BLOCKED_BY_VOLUME_POLICY_PACKAGE                              = 0x00003d21U,
    ERROR_DEPLOYMENT_BLOCKED_BY_VOLUME_POLICY_MACHINE                              = 0x00003d22U,
    ERROR_DEPLOYMENT_BLOCKED_BY_PROFILE_POLICY                                     = 0x00003d23U,
    ERROR_DEPLOYMENT_FAILED_CONFLICTING_MUTABLE_PACKAGE_DIRECTORY                  = 0x00003d24U,
    ERROR_SINGLETON_RESOURCE_INSTALLED_IN_ACTIVE_USER                              = 0x00003d25U,
    ERROR_DIFFERENT_VERSION_OF_PACKAGED_SERVICE_INSTALLED                          = 0x00003d26U,
    ERROR_SERVICE_EXISTS_AS_NON_PACKAGED_SERVICE                                   = 0x00003d27U,
    ERROR_PACKAGED_SERVICE_REQUIRES_ADMIN_PRIVILEGES                               = 0x00003d28U,
    ERROR_REDIRECTION_TO_DEFAULT_ACCOUNT_NOT_ALLOWED                               = 0x00003d29U,
    ERROR_PACKAGE_LACKS_CAPABILITY_TO_DEPLOY_ON_HOST                               = 0x00003d2aU,
    ERROR_UNSIGNED_PACKAGE_INVALID_CONTENT                                         = 0x00003d2bU,
    ERROR_UNSIGNED_PACKAGE_INVALID_PUBLISHER_NAMESPACE                             = 0x00003d2cU,
    ERROR_SIGNED_PACKAGE_INVALID_PUBLISHER_NAMESPACE                               = 0x00003d2dU,
    ERROR_PACKAGE_EXTERNAL_LOCATION_NOT_ALLOWED                                    = 0x00003d2eU,
    ERROR_INSTALL_FULLTRUST_HOSTRUNTIME_REQUIRES_MAIN_PACKAGE_FULLTRUST_CAPABILITY = 0x00003d2fU,
    ERROR_PACKAGE_LACKS_CAPABILITY_FOR_MANDATORY_STARTUPTASKS                      = 0x00003d30U,
    ERROR_INSTALL_RESOLVE_HOSTRUNTIME_DEPENDENCY_FAILED                            = 0x00003d31U,
    ERROR_MACHINE_SCOPE_NOT_ALLOWED                                                = 0x00003d32U,
    ERROR_CLASSIC_COMPAT_MODE_NOT_ALLOWED                                          = 0x00003d33U,
    ERROR_STAGEFROMUPDATEAGENT_PACKAGE_NOT_APPLICABLE                              = 0x00003d34U,
    ERROR_PACKAGE_NOT_REGISTERED_FOR_USER                                          = 0x00003d35U,
    ERROR_PACKAGE_NAME_MISMATCH                                                    = 0x00003d36U,
    ERROR_APPINSTALLER_URI_IN_USE                                                  = 0x00003d37U,
    ERROR_APPINSTALLER_IS_MANAGED_BY_SYSTEM                                        = 0x00003d38U,
    ERROR_SERVICE_BLOCKED_BY_SYSPREP_IN_PROGRESS                                   = 0x00003d39U,
    ERROR_UNSUPPORTED_ARM32_PACKAGE_REQUIRES_REMEDIAITON                           = 0x00003d3aU,
    ERROR_UUP_PRODUCT_NOT_APPLICABLE                                               = 0x00003d3bU,
    ERROR_BLOCKED_BY_PENDING_PACKAGE_REMOVAL                                       = 0x00003d3cU,
    ERROR_PACKAGE_REPOSITORY_ROOT_CORRUPTED                                        = 0x00003d3dU,
    ERROR_PACKAGE_MANIFEST_NOT_FOUND                                               = 0x00003d3eU,
    ERROR_DEPLOYMENT_BLOCKED_BY_REMOVEDEFAULTPACKAGES_POLICY                       = 0x00003d3fU,
    ERROR_URI_BLOCKED_BY_POLICY_MSIXALLOWEDZONES                                   = 0x00003d40U,
    ERROR_URI_RECOMMENDED_BLOCK_BY_SMARTSCREEN                                     = 0x00003d41U,
    APPMODEL_ERROR_NO_PACKAGE                                                      = 0x00003d54U,
    APPMODEL_ERROR_PACKAGE_RUNTIME_CORRUPT                                         = 0x00003d55U,
    APPMODEL_ERROR_PACKAGE_IDENTITY_CORRUPT                                        = 0x00003d56U,
    APPMODEL_ERROR_NO_APPLICATION                                                  = 0x00003d57U,
    APPMODEL_ERROR_DYNAMIC_PROPERTY_READ_FAILED                                    = 0x00003d58U,
    APPMODEL_ERROR_DYNAMIC_PROPERTY_INVALID                                        = 0x00003d59U,
    APPMODEL_ERROR_PACKAGE_NOT_AVAILABLE                                           = 0x00003d5aU,
    APPMODEL_ERROR_NO_MUTABLE_DIRECTORY                                            = 0x00003d5bU,
    ERROR_STATE_LOAD_STORE_FAILED                                                  = 0x00003db8U,
    ERROR_STATE_GET_VERSION_FAILED                                                 = 0x00003db9U,
    ERROR_STATE_SET_VERSION_FAILED                                                 = 0x00003dbaU,
    ERROR_STATE_STRUCTURED_RESET_FAILED                                            = 0x00003dbbU,
    ERROR_STATE_OPEN_CONTAINER_FAILED                                              = 0x00003dbcU,
    ERROR_STATE_CREATE_CONTAINER_FAILED                                            = 0x00003dbdU,
    ERROR_STATE_DELETE_CONTAINER_FAILED                                            = 0x00003dbeU,
    ERROR_STATE_READ_SETTING_FAILED                                                = 0x00003dbfU,
    ERROR_STATE_WRITE_SETTING_FAILED                                               = 0x00003dc0U,
    ERROR_STATE_DELETE_SETTING_FAILED                                              = 0x00003dc1U,
    ERROR_STATE_QUERY_SETTING_FAILED                                               = 0x00003dc2U,
    ERROR_STATE_READ_COMPOSITE_SETTING_FAILED                                      = 0x00003dc3U,
    ERROR_STATE_WRITE_COMPOSITE_SETTING_FAILED                                     = 0x00003dc4U,
    ERROR_STATE_ENUMERATE_CONTAINER_FAILED                                         = 0x00003dc5U,
    ERROR_STATE_ENUMERATE_SETTINGS_FAILED                                          = 0x00003dc6U,
    ERROR_STATE_COMPOSITE_SETTING_VALUE_SIZE_LIMIT_EXCEEDED                        = 0x00003dc7U,
    ERROR_STATE_SETTING_VALUE_SIZE_LIMIT_EXCEEDED                                  = 0x00003dc8U,
    ERROR_STATE_SETTING_NAME_SIZE_LIMIT_EXCEEDED                                   = 0x00003dc9U,
    ERROR_STATE_CONTAINER_NAME_SIZE_LIMIT_EXCEEDED                                 = 0x00003dcaU,
    ERROR_API_UNAVAILABLE                                                          = 0x00003de1U,
    ERROR_NDIS_INTERFACE_CLOSING                                                   = 0x80340002U,
    ERROR_NDIS_BAD_VERSION                                                         = 0x80340004U,
    ERROR_NDIS_BAD_CHARACTERISTICS                                                 = 0x80340005U,
    ERROR_NDIS_ADAPTER_NOT_FOUND                                                   = 0x80340006U,
    ERROR_NDIS_OPEN_FAILED                                                         = 0x80340007U,
    ERROR_NDIS_DEVICE_FAILED                                                       = 0x80340008U,
    ERROR_NDIS_MULTICAST_FULL                                                      = 0x80340009U,
    ERROR_NDIS_MULTICAST_EXISTS                                                    = 0x8034000aU,
    ERROR_NDIS_MULTICAST_NOT_FOUND                                                 = 0x8034000bU,
    ERROR_NDIS_REQUEST_ABORTED                                                     = 0x8034000cU,
    ERROR_NDIS_RESET_IN_PROGRESS                                                   = 0x8034000dU,
    ERROR_NDIS_NOT_SUPPORTED                                                       = 0x803400bbU,
    ERROR_NDIS_INVALID_PACKET                                                      = 0x8034000fU,
    ERROR_NDIS_ADAPTER_NOT_READY                                                   = 0x80340011U,
    ERROR_NDIS_INVALID_LENGTH                                                      = 0x80340014U,
    ERROR_NDIS_INVALID_DATA                                                        = 0x80340015U,
    ERROR_NDIS_BUFFER_TOO_SHORT                                                    = 0x80340016U,
    ERROR_NDIS_INVALID_OID                                                         = 0x80340017U,
    ERROR_NDIS_ADAPTER_REMOVED                                                     = 0x80340018U,
    ERROR_NDIS_UNSUPPORTED_MEDIA                                                   = 0x80340019U,
    ERROR_NDIS_GROUP_ADDRESS_IN_USE                                                = 0x8034001aU,
    ERROR_NDIS_FILE_NOT_FOUND                                                      = 0x8034001bU,
    ERROR_NDIS_ERROR_READING_FILE                                                  = 0x8034001cU,
    ERROR_NDIS_ALREADY_MAPPED                                                      = 0x8034001dU,
    ERROR_NDIS_RESOURCE_CONFLICT                                                   = 0x8034001eU,
    ERROR_NDIS_MEDIA_DISCONNECTED                                                  = 0x8034001fU,
    ERROR_NDIS_INVALID_ADDRESS                                                     = 0x80340022U,
    ERROR_NDIS_INVALID_DEVICE_REQUEST                                              = 0x80340010U,
    ERROR_NDIS_PAUSED                                                              = 0x8034002aU,
    ERROR_NDIS_INTERFACE_NOT_FOUND                                                 = 0x8034002bU,
    ERROR_NDIS_UNSUPPORTED_REVISION                                                = 0x8034002cU,
    ERROR_NDIS_INVALID_PORT                                                        = 0x8034002dU,
    ERROR_NDIS_INVALID_PORT_STATE                                                  = 0x8034002eU,
    ERROR_NDIS_LOW_POWER_STATE                                                     = 0x8034002fU,
    ERROR_NDIS_REINIT_REQUIRED                                                     = 0x80340030U,
    ERROR_NDIS_NO_QUEUES                                                           = 0x80340031U,
    ERROR_NDIS_DOT11_AUTO_CONFIG_ENABLED                                           = 0x80342000U,
    ERROR_NDIS_DOT11_MEDIA_IN_USE                                                  = 0x80342001U,
    ERROR_NDIS_DOT11_POWER_STATE_INVALID                                           = 0x80342002U,
    ERROR_NDIS_PM_WOL_PATTERN_LIST_FULL                                            = 0x80342003U,
    ERROR_NDIS_PM_PROTOCOL_OFFLOAD_LIST_FULL                                       = 0x80342004U,
    ERROR_NDIS_DOT11_AP_CHANNEL_CURRENTLY_NOT_AVAILABLE                            = 0x80342005U,
    ERROR_NDIS_DOT11_AP_BAND_CURRENTLY_NOT_AVAILABLE                               = 0x80342006U,
    ERROR_NDIS_DOT11_AP_CHANNEL_NOT_ALLOWED                                        = 0x80342007U,
    ERROR_NDIS_DOT11_AP_BAND_NOT_ALLOWED                                           = 0x80342008U,
    ERROR_NDIS_DOT11_AP_RADIO_RESTRICTION                                          = 0x80342009U,
    ERROR_NDIS_INDICATION_REQUIRED                                                 = 0x00340001U,
    ERROR_NDIS_OFFLOAD_POLICY                                                      = 0xc034100fU,
    ERROR_NDIS_OFFLOAD_CONNECTION_REJECTED                                         = 0xc0341012U,
    ERROR_NDIS_OFFLOAD_PATH_REJECTED                                               = 0xc0341013U,
    ERROR_HV_INVALID_HYPERCALL_CODE                                                = 0xc0350002U,
    ERROR_HV_INVALID_HYPERCALL_INPUT                                               = 0xc0350003U,
    ERROR_HV_INVALID_ALIGNMENT                                                     = 0xc0350004U,
    ERROR_HV_INVALID_PARAMETER                                                     = 0xc0350005U,
    ERROR_HV_ACCESS_DENIED                                                         = 0xc0350006U,
    ERROR_HV_INVALID_PARTITION_STATE                                               = 0xc0350007U,
    ERROR_HV_OPERATION_DENIED                                                      = 0xc0350008U,
    ERROR_HV_UNKNOWN_PROPERTY                                                      = 0xc0350009U,
    ERROR_HV_PROPERTY_VALUE_OUT_OF_RANGE                                           = 0xc035000aU,
    ERROR_HV_INSUFFICIENT_MEMORY                                                   = 0xc035000bU,
    ERROR_HV_PARTITION_TOO_DEEP                                                    = 0xc035000cU,
    ERROR_HV_INVALID_PARTITION_ID                                                  = 0xc035000dU,
    ERROR_HV_INVALID_VP_INDEX                                                      = 0xc035000eU,
    ERROR_HV_INVALID_PORT_ID                                                       = 0xc0350011U,
    ERROR_HV_INVALID_CONNECTION_ID                                                 = 0xc0350012U,
    ERROR_HV_INSUFFICIENT_BUFFERS                                                  = 0xc0350013U,
    ERROR_HV_NOT_ACKNOWLEDGED                                                      = 0xc0350014U,
    ERROR_HV_INVALID_VP_STATE                                                      = 0xc0350015U,
    ERROR_HV_ACKNOWLEDGED                                                          = 0xc0350016U,
    ERROR_HV_INVALID_SAVE_RESTORE_STATE                                            = 0xc0350017U,
    ERROR_HV_INVALID_SYNIC_STATE                                                   = 0xc0350018U,
    ERROR_HV_OBJECT_IN_USE                                                         = 0xc0350019U,
    ERROR_HV_INVALID_PROXIMITY_DOMAIN_INFO                                         = 0xc035001aU,
    ERROR_HV_NO_DATA                                                               = 0xc035001bU,
    ERROR_HV_INACTIVE                                                              = 0xc035001cU,
    ERROR_HV_NO_RESOURCES                                                          = 0xc035001dU,
    ERROR_HV_FEATURE_UNAVAILABLE                                                   = 0xc035001eU,
    ERROR_HV_INSUFFICIENT_BUFFER                                                   = 0xc0350033U,
    ERROR_HV_INSUFFICIENT_DEVICE_DOMAINS                                           = 0xc0350038U,
    ERROR_HV_CPUID_FEATURE_VALIDATION                                              = 0xc035003cU,
    ERROR_HV_CPUID_XSAVE_FEATURE_VALIDATION                                        = 0xc035003dU,
    ERROR_HV_PROCESSOR_STARTUP_TIMEOUT                                             = 0xc035003eU,
    ERROR_HV_SMX_ENABLED                                                           = 0xc035003fU,
    ERROR_HV_INVALID_LP_INDEX                                                      = 0xc0350041U,
    ERROR_HV_INVALID_REGISTER_VALUE                                                = 0xc0350050U,
    ERROR_HV_INVALID_VTL_STATE                                                     = 0xc0350051U,
    ERROR_HV_NX_NOT_DETECTED                                                       = 0xc0350055U,
    ERROR_HV_INVALID_DEVICE_ID                                                     = 0xc0350057U,
    ERROR_HV_INVALID_DEVICE_STATE                                                  = 0xc0350058U,
    ERROR_HV_PENDING_PAGE_REQUESTS                                                 = 0x00350059U,
    ERROR_HV_PAGE_REQUEST_INVALID                                                  = 0xc0350060U,
    ERROR_HV_INVALID_CPU_GROUP_ID                                                  = 0xc035006fU,
    ERROR_HV_INVALID_CPU_GROUP_STATE                                               = 0xc0350070U,
    ERROR_HV_OPERATION_FAILED                                                      = 0xc0350071U,
    ERROR_HV_NOT_ALLOWED_WITH_NESTED_VIRT_ACTIVE                                   = 0xc0350072U,
    ERROR_HV_INSUFFICIENT_ROOT_MEMORY                                              = 0xc0350073U,
    ERROR_HV_EVENT_BUFFER_ALREADY_FREED                                            = 0xc0350074U,
    ERROR_HV_INSUFFICIENT_CONTIGUOUS_MEMORY                                        = 0xc0350075U,
    ERROR_HV_DEVICE_NOT_IN_DOMAIN                                                  = 0xc0350076U,
    ERROR_HV_NESTED_VM_EXIT                                                        = 0xc0350077U,
    ERROR_HV_MSR_ACCESS_FAILED                                                     = 0xc0350080U,
    ERROR_HV_INSUFFICIENT_MEMORY_MIRRORING                                         = 0xc0350081U,
    ERROR_HV_INSUFFICIENT_CONTIGUOUS_MEMORY_MIRRORING                              = 0xc0350082U,
    ERROR_HV_INSUFFICIENT_CONTIGUOUS_ROOT_MEMORY                                   = 0xc0350083U,
    ERROR_HV_INSUFFICIENT_ROOT_MEMORY_MIRRORING                                    = 0xc0350084U,
    ERROR_HV_INSUFFICIENT_CONTIGUOUS_ROOT_MEMORY_MIRRORING                         = 0xc0350085U,
    ERROR_HV_VTL_ALREADY_ENABLED                                                   = 0xc0350086U,
    ERROR_HV_SPDM_REQUEST                                                          = 0xc0350088U,
    ERROR_HV_NOT_PRESENT                                                           = 0xc0351000U,
    ERROR_VID_DUPLICATE_HANDLER                                                    = 0xc0370001U,
    ERROR_VID_TOO_MANY_HANDLERS                                                    = 0xc0370002U,
    ERROR_VID_QUEUE_FULL                                                           = 0xc0370003U,
    ERROR_VID_HANDLER_NOT_PRESENT                                                  = 0xc0370004U,
    ERROR_VID_INVALID_OBJECT_NAME                                                  = 0xc0370005U,
    ERROR_VID_PARTITION_NAME_TOO_LONG                                              = 0xc0370006U,
    ERROR_VID_MESSAGE_QUEUE_NAME_TOO_LONG                                          = 0xc0370007U,
    ERROR_VID_PARTITION_ALREADY_EXISTS                                             = 0xc0370008U,
    ERROR_VID_PARTITION_DOES_NOT_EXIST                                             = 0xc0370009U,
    ERROR_VID_PARTITION_NAME_NOT_FOUND                                             = 0xc037000aU,
    ERROR_VID_MESSAGE_QUEUE_ALREADY_EXISTS                                         = 0xc037000bU,
    ERROR_VID_EXCEEDED_MBP_ENTRY_MAP_LIMIT                                         = 0xc037000cU,
    ERROR_VID_MB_STILL_REFERENCED                                                  = 0xc037000dU,
    ERROR_VID_CHILD_GPA_PAGE_SET_CORRUPTED                                         = 0xc037000eU,
    ERROR_VID_INVALID_NUMA_SETTINGS                                                = 0xc037000fU,
    ERROR_VID_INVALID_NUMA_NODE_INDEX                                              = 0xc0370010U,
    ERROR_VID_NOTIFICATION_QUEUE_ALREADY_ASSOCIATED                                = 0xc0370011U,
    ERROR_VID_INVALID_MEMORY_BLOCK_HANDLE                                          = 0xc0370012U,
    ERROR_VID_PAGE_RANGE_OVERFLOW                                                  = 0xc0370013U,
    ERROR_VID_INVALID_MESSAGE_QUEUE_HANDLE                                         = 0xc0370014U,
    ERROR_VID_INVALID_GPA_RANGE_HANDLE                                             = 0xc0370015U,
    ERROR_VID_NO_MEMORY_BLOCK_NOTIFICATION_QUEUE                                   = 0xc0370016U,
    ERROR_VID_MEMORY_BLOCK_LOCK_COUNT_EXCEEDED                                     = 0xc0370017U,
    ERROR_VID_INVALID_PPM_HANDLE                                                   = 0xc0370018U,
    ERROR_VID_MBPS_ARE_LOCKED                                                      = 0xc0370019U,
    ERROR_VID_MESSAGE_QUEUE_CLOSED                                                 = 0xc037001aU,
    ERROR_VID_VIRTUAL_PROCESSOR_LIMIT_EXCEEDED                                     = 0xc037001bU,
    ERROR_VID_STOP_PENDING                                                         = 0xc037001cU,
    ERROR_VID_INVALID_PROCESSOR_STATE                                              = 0xc037001dU,
    ERROR_VID_EXCEEDED_KM_CONTEXT_COUNT_LIMIT                                      = 0xc037001eU,
    ERROR_VID_KM_INTERFACE_ALREADY_INITIALIZED                                     = 0xc037001fU,
    ERROR_VID_MB_PROPERTY_ALREADY_SET_RESET                                        = 0xc0370020U,
    ERROR_VID_MMIO_RANGE_DESTROYED                                                 = 0xc0370021U,
    ERROR_VID_INVALID_CHILD_GPA_PAGE_SET                                           = 0xc0370022U,
    ERROR_VID_RESERVE_PAGE_SET_IS_BEING_USED                                       = 0xc0370023U,
    ERROR_VID_RESERVE_PAGE_SET_TOO_SMALL                                           = 0xc0370024U,
    ERROR_VID_MBP_ALREADY_LOCKED_USING_RESERVED_PAGE                               = 0xc0370025U,
    ERROR_VID_MBP_COUNT_EXCEEDED_LIMIT                                             = 0xc0370026U,
    ERROR_VID_SAVED_STATE_CORRUPT                                                  = 0xc0370027U,
    ERROR_VID_SAVED_STATE_UNRECOGNIZED_ITEM                                        = 0xc0370028U,
    ERROR_VID_SAVED_STATE_INCOMPATIBLE                                             = 0xc0370029U,
    ERROR_VID_VTL_ACCESS_DENIED                                                    = 0xc037002aU,
    ERROR_VID_INSUFFICIENT_RESOURCES_RESERVE                                       = 0xc037002bU,
    ERROR_VID_INSUFFICIENT_RESOURCES_PHYSICAL_BUFFER                               = 0xc037002cU,
    ERROR_VID_INSUFFICIENT_RESOURCES_HV_DEPOSIT                                    = 0xc037002dU,
    ERROR_VID_MEMORY_TYPE_NOT_SUPPORTED                                            = 0xc037002eU,
    ERROR_VID_INSUFFICIENT_RESOURCES_WITHDRAW                                      = 0xc037002fU,
    ERROR_VID_PROCESS_ALREADY_SET                                                  = 0xc0370030U,
    ERROR_VMCOMPUTE_TERMINATED_DURING_START                                        = 0xc0370100U,
    ERROR_VMCOMPUTE_IMAGE_MISMATCH                                                 = 0xc0370101U,
    ERROR_VMCOMPUTE_HYPERV_NOT_INSTALLED                                           = 0xc0370102U,
    ERROR_VMCOMPUTE_OPERATION_PENDING                                              = 0xc0370103U,
    ERROR_VMCOMPUTE_TOO_MANY_NOTIFICATIONS                                         = 0xc0370104U,
    ERROR_VMCOMPUTE_INVALID_STATE                                                  = 0xc0370105U,
    ERROR_VMCOMPUTE_UNEXPECTED_EXIT                                                = 0xc0370106U,
    ERROR_VMCOMPUTE_TERMINATED                                                     = 0xc0370107U,
    ERROR_VMCOMPUTE_CONNECT_FAILED                                                 = 0xc0370108U,
    ERROR_VMCOMPUTE_TIMEOUT                                                        = 0xc0370109U,
    ERROR_VMCOMPUTE_CONNECTION_CLOSED                                              = 0xc037010aU,
    ERROR_VMCOMPUTE_UNKNOWN_MESSAGE                                                = 0xc037010bU,
    ERROR_VMCOMPUTE_UNSUPPORTED_PROTOCOL_VERSION                                   = 0xc037010cU,
    ERROR_VMCOMPUTE_INVALID_JSON                                                   = 0xc037010dU,
    ERROR_VMCOMPUTE_SYSTEM_NOT_FOUND                                               = 0xc037010eU,
    ERROR_VMCOMPUTE_SYSTEM_ALREADY_EXISTS                                          = 0xc037010fU,
    ERROR_VMCOMPUTE_SYSTEM_ALREADY_STOPPED                                         = 0xc0370110U,
    ERROR_VMCOMPUTE_PROTOCOL_ERROR                                                 = 0xc0370111U,
    ERROR_VMCOMPUTE_INVALID_LAYER                                                  = 0xc0370112U,
    ERROR_VMCOMPUTE_WINDOWS_INSIDER_REQUIRED                                       = 0xc0370113U,
    ERROR_VNET_VIRTUAL_SWITCH_NAME_NOT_FOUND                                       = 0xc0370200U,
    ERROR_VID_REMOTE_NODE_PARENT_GPA_PAGES_USED                                    = 0x80370001U,
    ERROR_VSMB_SAVED_STATE_FILE_NOT_FOUND                                          = 0xc0370400U,
    ERROR_VSMB_SAVED_STATE_CORRUPT                                                 = 0xc0370401U,
    ERROR_VOLMGR_INCOMPLETE_REGENERATION                                           = 0x80380001U,
    ERROR_VOLMGR_INCOMPLETE_DISK_MIGRATION                                         = 0x80380002U,
    ERROR_VOLMGR_DATABASE_FULL                                                     = 0xc0380001U,
    ERROR_VOLMGR_DISK_CONFIGURATION_CORRUPTED                                      = 0xc0380002U,
    ERROR_VOLMGR_DISK_CONFIGURATION_NOT_IN_SYNC                                    = 0xc0380003U,
    ERROR_VOLMGR_PACK_CONFIG_UPDATE_FAILED                                         = 0xc0380004U,
    ERROR_VOLMGR_DISK_CONTAINS_NON_SIMPLE_VOLUME                                   = 0xc0380005U,
    ERROR_VOLMGR_DISK_DUPLICATE                                                    = 0xc0380006U,
    ERROR_VOLMGR_DISK_DYNAMIC                                                      = 0xc0380007U,
    ERROR_VOLMGR_DISK_ID_INVALID                                                   = 0xc0380008U,
    ERROR_VOLMGR_DISK_INVALID                                                      = 0xc0380009U,
    ERROR_VOLMGR_DISK_LAST_VOTER                                                   = 0xc038000aU,
    ERROR_VOLMGR_DISK_LAYOUT_INVALID                                               = 0xc038000bU,
    ERROR_VOLMGR_DISK_LAYOUT_NON_BASIC_BETWEEN_BASIC_PARTITIONS                    = 0xc038000cU,
    ERROR_VOLMGR_DISK_LAYOUT_NOT_CYLINDER_ALIGNED                                  = 0xc038000dU,
    ERROR_VOLMGR_DISK_LAYOUT_PARTITIONS_TOO_SMALL                                  = 0xc038000eU,
    ERROR_VOLMGR_DISK_LAYOUT_PRIMARY_BETWEEN_LOGICAL_PARTITIONS                    = 0xc038000fU,
    ERROR_VOLMGR_DISK_LAYOUT_TOO_MANY_PARTITIONS                                   = 0xc0380010U,
    ERROR_VOLMGR_DISK_MISSING                                                      = 0xc0380011U,
    ERROR_VOLMGR_DISK_NOT_EMPTY                                                    = 0xc0380012U,
    ERROR_VOLMGR_DISK_NOT_ENOUGH_SPACE                                             = 0xc0380013U,
    ERROR_VOLMGR_DISK_REVECTORING_FAILED                                           = 0xc0380014U,
    ERROR_VOLMGR_DISK_SECTOR_SIZE_INVALID                                          = 0xc0380015U,
    ERROR_VOLMGR_DISK_SET_NOT_CONTAINED                                            = 0xc0380016U,
    ERROR_VOLMGR_DISK_USED_BY_MULTIPLE_MEMBERS                                     = 0xc0380017U,
    ERROR_VOLMGR_DISK_USED_BY_MULTIPLE_PLEXES                                      = 0xc0380018U,
    ERROR_VOLMGR_DYNAMIC_DISK_NOT_SUPPORTED                                        = 0xc0380019U,
    ERROR_VOLMGR_EXTENT_ALREADY_USED                                               = 0xc038001aU,
    ERROR_VOLMGR_EXTENT_NOT_CONTIGUOUS                                             = 0xc038001bU,
    ERROR_VOLMGR_EXTENT_NOT_IN_PUBLIC_REGION                                       = 0xc038001cU,
    ERROR_VOLMGR_EXTENT_NOT_SECTOR_ALIGNED                                         = 0xc038001dU,
    ERROR_VOLMGR_EXTENT_OVERLAPS_EBR_PARTITION                                     = 0xc038001eU,
    ERROR_VOLMGR_EXTENT_VOLUME_LENGTHS_DO_NOT_MATCH                                = 0xc038001fU,
    ERROR_VOLMGR_FAULT_TOLERANT_NOT_SUPPORTED                                      = 0xc0380020U,
    ERROR_VOLMGR_INTERLEAVE_LENGTH_INVALID                                         = 0xc0380021U,
    ERROR_VOLMGR_MAXIMUM_REGISTERED_USERS                                          = 0xc0380022U,
    ERROR_VOLMGR_MEMBER_IN_SYNC                                                    = 0xc0380023U,
    ERROR_VOLMGR_MEMBER_INDEX_DUPLICATE                                            = 0xc0380024U,
    ERROR_VOLMGR_MEMBER_INDEX_INVALID                                              = 0xc0380025U,
    ERROR_VOLMGR_MEMBER_MISSING                                                    = 0xc0380026U,
    ERROR_VOLMGR_MEMBER_NOT_DETACHED                                               = 0xc0380027U,
    ERROR_VOLMGR_MEMBER_REGENERATING                                               = 0xc0380028U,
    ERROR_VOLMGR_ALL_DISKS_FAILED                                                  = 0xc0380029U,
    ERROR_VOLMGR_NO_REGISTERED_USERS                                               = 0xc038002aU,
    ERROR_VOLMGR_NO_SUCH_USER                                                      = 0xc038002bU,
    ERROR_VOLMGR_NOTIFICATION_RESET                                                = 0xc038002cU,
    ERROR_VOLMGR_NUMBER_OF_MEMBERS_INVALID                                         = 0xc038002dU,
    ERROR_VOLMGR_NUMBER_OF_PLEXES_INVALID                                          = 0xc038002eU,
    ERROR_VOLMGR_PACK_DUPLICATE                                                    = 0xc038002fU,
    ERROR_VOLMGR_PACK_ID_INVALID                                                   = 0xc0380030U,
    ERROR_VOLMGR_PACK_INVALID                                                      = 0xc0380031U,
    ERROR_VOLMGR_PACK_NAME_INVALID                                                 = 0xc0380032U,
    ERROR_VOLMGR_PACK_OFFLINE                                                      = 0xc0380033U,
    ERROR_VOLMGR_PACK_HAS_QUORUM                                                   = 0xc0380034U,
    ERROR_VOLMGR_PACK_WITHOUT_QUORUM                                               = 0xc0380035U,
    ERROR_VOLMGR_PARTITION_STYLE_INVALID                                           = 0xc0380036U,
    ERROR_VOLMGR_PARTITION_UPDATE_FAILED                                           = 0xc0380037U,
    ERROR_VOLMGR_PLEX_IN_SYNC                                                      = 0xc0380038U,
    ERROR_VOLMGR_PLEX_INDEX_DUPLICATE                                              = 0xc0380039U,
    ERROR_VOLMGR_PLEX_INDEX_INVALID                                                = 0xc038003aU,
    ERROR_VOLMGR_PLEX_LAST_ACTIVE                                                  = 0xc038003bU,
    ERROR_VOLMGR_PLEX_MISSING                                                      = 0xc038003cU,
    ERROR_VOLMGR_PLEX_REGENERATING                                                 = 0xc038003dU,
    ERROR_VOLMGR_PLEX_TYPE_INVALID                                                 = 0xc038003eU,
    ERROR_VOLMGR_PLEX_NOT_RAID5                                                    = 0xc038003fU,
    ERROR_VOLMGR_PLEX_NOT_SIMPLE                                                   = 0xc0380040U,
    ERROR_VOLMGR_STRUCTURE_SIZE_INVALID                                            = 0xc0380041U,
    ERROR_VOLMGR_TOO_MANY_NOTIFICATION_REQUESTS                                    = 0xc0380042U,
    ERROR_VOLMGR_TRANSACTION_IN_PROGRESS                                           = 0xc0380043U,
    ERROR_VOLMGR_UNEXPECTED_DISK_LAYOUT_CHANGE                                     = 0xc0380044U,
    ERROR_VOLMGR_VOLUME_CONTAINS_MISSING_DISK                                      = 0xc0380045U,
    ERROR_VOLMGR_VOLUME_ID_INVALID                                                 = 0xc0380046U,
    ERROR_VOLMGR_VOLUME_LENGTH_INVALID                                             = 0xc0380047U,
    ERROR_VOLMGR_VOLUME_LENGTH_NOT_SECTOR_SIZE_MULTIPLE                            = 0xc0380048U,
    ERROR_VOLMGR_VOLUME_NOT_MIRRORED                                               = 0xc0380049U,
    ERROR_VOLMGR_VOLUME_NOT_RETAINED                                               = 0xc038004aU,
    ERROR_VOLMGR_VOLUME_OFFLINE                                                    = 0xc038004bU,
    ERROR_VOLMGR_VOLUME_RETAINED                                                   = 0xc038004cU,
    ERROR_VOLMGR_NUMBER_OF_EXTENTS_INVALID                                         = 0xc038004dU,
    ERROR_VOLMGR_DIFFERENT_SECTOR_SIZE                                             = 0xc038004eU,
    ERROR_VOLMGR_BAD_BOOT_DISK                                                     = 0xc038004fU,
    ERROR_VOLMGR_PACK_CONFIG_OFFLINE                                               = 0xc0380050U,
    ERROR_VOLMGR_PACK_CONFIG_ONLINE                                                = 0xc0380051U,
    ERROR_VOLMGR_NOT_PRIMARY_PACK                                                  = 0xc0380052U,
    ERROR_VOLMGR_PACK_LOG_UPDATE_FAILED                                            = 0xc0380053U,
    ERROR_VOLMGR_NUMBER_OF_DISKS_IN_PLEX_INVALID                                   = 0xc0380054U,
    ERROR_VOLMGR_NUMBER_OF_DISKS_IN_MEMBER_INVALID                                 = 0xc0380055U,
    ERROR_VOLMGR_VOLUME_MIRRORED                                                   = 0xc0380056U,
    ERROR_VOLMGR_PLEX_NOT_SIMPLE_SPANNED                                           = 0xc0380057U,
    ERROR_VOLMGR_NO_VALID_LOG_COPIES                                               = 0xc0380058U,
    ERROR_VOLMGR_PRIMARY_PACK_PRESENT                                              = 0xc0380059U,
    ERROR_VOLMGR_NUMBER_OF_DISKS_INVALID                                           = 0xc038005aU,
    ERROR_VOLMGR_MIRROR_NOT_SUPPORTED                                              = 0xc038005bU,
    ERROR_VOLMGR_RAID5_NOT_SUPPORTED                                               = 0xc038005cU,
    ERROR_BCD_NOT_ALL_ENTRIES_IMPORTED                                             = 0x80390001U,
    ERROR_BCD_TOO_MANY_ELEMENTS                                                    = 0xc0390002U,
    ERROR_BCD_NOT_ALL_ENTRIES_SYNCHRONIZED                                         = 0x80390003U,
    ERROR_VHD_DRIVE_FOOTER_MISSING                                                 = 0xc03a0001U,
    ERROR_VHD_DRIVE_FOOTER_CHECKSUM_MISMATCH                                       = 0xc03a0002U,
    ERROR_VHD_DRIVE_FOOTER_CORRUPT                                                 = 0xc03a0003U,
    ERROR_VHD_FORMAT_UNKNOWN                                                       = 0xc03a0004U,
    ERROR_VHD_FORMAT_UNSUPPORTED_VERSION                                           = 0xc03a0005U,
    ERROR_VHD_SPARSE_HEADER_CHECKSUM_MISMATCH                                      = 0xc03a0006U,
    ERROR_VHD_SPARSE_HEADER_UNSUPPORTED_VERSION                                    = 0xc03a0007U,
    ERROR_VHD_SPARSE_HEADER_CORRUPT                                                = 0xc03a0008U,
    ERROR_VHD_BLOCK_ALLOCATION_FAILURE                                             = 0xc03a0009U,
    ERROR_VHD_BLOCK_ALLOCATION_TABLE_CORRUPT                                       = 0xc03a000aU,
    ERROR_VHD_INVALID_BLOCK_SIZE                                                   = 0xc03a000bU,
    ERROR_VHD_BITMAP_MISMATCH                                                      = 0xc03a000cU,
    ERROR_VHD_PARENT_VHD_NOT_FOUND                                                 = 0xc03a000dU,
    ERROR_VHD_CHILD_PARENT_ID_MISMATCH                                             = 0xc03a000eU,
    ERROR_VHD_CHILD_PARENT_TIMESTAMP_MISMATCH                                      = 0xc03a000fU,
    ERROR_VHD_METADATA_READ_FAILURE                                                = 0xc03a0010U,
    ERROR_VHD_METADATA_WRITE_FAILURE                                               = 0xc03a0011U,
    ERROR_VHD_INVALID_SIZE                                                         = 0xc03a0012U,
    ERROR_VHD_INVALID_FILE_SIZE                                                    = 0xc03a0013U,
    ERROR_VIRTDISK_PROVIDER_NOT_FOUND                                              = 0xc03a0014U,
    ERROR_VIRTDISK_NOT_VIRTUAL_DISK                                                = 0xc03a0015U,
    ERROR_VHD_PARENT_VHD_ACCESS_DENIED                                             = 0xc03a0016U,
    ERROR_VHD_CHILD_PARENT_SIZE_MISMATCH                                           = 0xc03a0017U,
    ERROR_VHD_DIFFERENCING_CHAIN_CYCLE_DETECTED                                    = 0xc03a0018U,
    ERROR_VHD_DIFFERENCING_CHAIN_ERROR_IN_PARENT                                   = 0xc03a0019U,
    ERROR_VIRTUAL_DISK_LIMITATION                                                  = 0xc03a001aU,
    ERROR_VHD_INVALID_TYPE                                                         = 0xc03a001bU,
    ERROR_VHD_INVALID_STATE                                                        = 0xc03a001cU,
    ERROR_VIRTDISK_UNSUPPORTED_DISK_SECTOR_SIZE                                    = 0xc03a001dU,
    ERROR_VIRTDISK_DISK_ALREADY_OWNED                                              = 0xc03a001eU,
    ERROR_VIRTDISK_DISK_ONLINE_AND_WRITABLE                                        = 0xc03a001fU,
    ERROR_CTLOG_TRACKING_NOT_INITIALIZED                                           = 0xc03a0020U,
    ERROR_CTLOG_LOGFILE_SIZE_EXCEEDED_MAXSIZE                                      = 0xc03a0021U,
    ERROR_CTLOG_VHD_CHANGED_OFFLINE                                                = 0xc03a0022U,
    ERROR_CTLOG_INVALID_TRACKING_STATE                                             = 0xc03a0023U,
    ERROR_CTLOG_INCONSISTENT_TRACKING_FILE                                         = 0xc03a0024U,
    ERROR_VHD_RESIZE_WOULD_TRUNCATE_DATA                                           = 0xc03a0025U,
    ERROR_VHD_COULD_NOT_COMPUTE_MINIMUM_VIRTUAL_SIZE                               = 0xc03a0026U,
    ERROR_VHD_ALREADY_AT_OR_BELOW_MINIMUM_VIRTUAL_SIZE                             = 0xc03a0027U,
    ERROR_VHD_METADATA_FULL                                                        = 0xc03a0028U,
    ERROR_VHD_INVALID_CHANGE_TRACKING_ID                                           = 0xc03a0029U,
    ERROR_VHD_CHANGE_TRACKING_DISABLED                                             = 0xc03a002aU,
    ERROR_VHD_MISSING_CHANGE_TRACKING_INFORMATION                                  = 0xc03a0030U,
    ERROR_VHD_UNEXPECTED_ID                                                        = 0xc03a0034U,
    ERROR_QUERY_STORAGE_ERROR                                                      = 0x803a0001U,
}

alias WAIT_EVENT = uint;
enum : uint
{
    WAIT_OBJECT_0      = 0x00000000U,
    WAIT_ABANDONED     = 0x00000080U,
    WAIT_ABANDONED_0   = 0x00000080U,
    WAIT_IO_COMPLETION = 0x000000c0U,
    WAIT_TIMEOUT       = 0x00000102U,
    WAIT_FAILED        = 0xffffffffU,
}

alias NTSTATUS_FACILITY_CODE = uint;
enum : uint
{
    FACILITY_MCA_ERROR_CODE             = 0x00000005U,
    FACILITY_DEBUGGER                   = 0x00000001U,
    FACILITY_RPC_RUNTIME                = 0x00000002U,
    FACILITY_RPC_STUBS                  = 0x00000003U,
    FACILITY_IO_ERROR_CODE              = 0x00000004U,
    FACILITY_CODCLASS_ERROR_CODE        = 0x00000006U,
    FACILITY_NTWIN32                    = 0x00000007U,
    FACILITY_NTCERT                     = 0x00000008U,
    FACILITY_NTSSPI                     = 0x00000009U,
    FACILITY_TERMINAL_SERVER            = 0x0000000aU,
    FACILITY_USB_ERROR_CODE             = 0x00000010U,
    FACILITY_HID_ERROR_CODE             = 0x00000011U,
    FACILITY_FIREWIRE_ERROR_CODE        = 0x00000012U,
    FACILITY_CLUSTER_ERROR_CODE         = 0x00000013U,
    FACILITY_ACPI_ERROR_CODE            = 0x00000014U,
    FACILITY_SXS_ERROR_CODE             = 0x00000015U,
    FACILITY_TRANSACTION                = 0x00000019U,
    FACILITY_COMMONLOG                  = 0x0000001aU,
    FACILITY_VIDEO                      = 0x0000001bU,
    FACILITY_FILTER_MANAGER             = 0x0000001cU,
    FACILITY_MONITOR                    = 0x0000001dU,
    FACILITY_GRAPHICS_KERNEL            = 0x0000001eU,
    FACILITY_CAMERA                     = 0x0000001fU,
    FACILITY_DRIVER_FRAMEWORK           = 0x00000020U,
    FACILITY_FVE_ERROR_CODE             = 0x00000021U,
    FACILITY_FWP_ERROR_CODE             = 0x00000022U,
    FACILITY_NDIS_ERROR_CODE            = 0x00000023U,
    FACILITY_QUIC_ERROR_CODE            = 0x00000024U,
    FACILITY_TPM                        = 0x00000029U,
    FACILITY_RTPM                       = 0x0000002aU,
    FACILITY_HYPERVISOR                 = 0x00000035U,
    FACILITY_IPSEC                      = 0x00000036U,
    FACILITY_VIRTUALIZATION             = 0x00000037U,
    FACILITY_VOLMGR                     = 0x00000038U,
    FACILITY_BCD_ERROR_CODE             = 0x00000039U,
    FACILITY_WIN32K_NTUSER              = 0x0000003eU,
    FACILITY_WIN32K_NTGDI               = 0x0000003fU,
    FACILITY_RESUME_KEY_FILTER          = 0x00000040U,
    FACILITY_RDBSS                      = 0x00000041U,
    FACILITY_BTH_ATT                    = 0x00000042U,
    FACILITY_SECUREBOOT                 = 0x00000043U,
    FACILITY_AUDIO_KERNEL               = 0x00000044U,
    FACILITY_VSM                        = 0x00000045U,
    FACILITY_NT_IORING                  = 0x00000046U,
    FACILITY_VOLSNAP                    = 0x00000050U,
    FACILITY_SDBUS                      = 0x00000051U,
    FACILITY_SHARED_VHDX                = 0x0000005cU,
    FACILITY_SMB                        = 0x0000005dU,
    FACILITY_XVS                        = 0x0000005eU,
    FACILITY_INTERIX                    = 0x00000099U,
    FACILITY_SPACES                     = 0x000000e7U,
    FACILITY_SECURITY_CORE              = 0x000000e8U,
    FACILITY_SYSTEM_INTEGRITY           = 0x000000e9U,
    FACILITY_LICENSING                  = 0x000000eaU,
    FACILITY_PLATFORM_MANIFEST          = 0x000000ebU,
    FACILITY_APP_EXEC                   = 0x000000ecU,
    FACILITY_UNIONFS                    = 0x000000edU,
    FACILITY_PLATFORM_RUNTIME_MECHANISM = 0x000000eeU,
    FACILITY_WIN_ACCEL                  = 0x000000efU,
    FACILITY_MAXIMUM_VALUE              = 0x000000f0U,
}

alias NTSTATUS_SEVERITY_CODE = uint;
enum : uint
{
    STATUS_SEVERITY_SUCCESS       = 0x00000000U,
    STATUS_SEVERITY_INFORMATIONAL = 0x00000001U,
    STATUS_SEVERITY_WARNING       = 0x00000002U,
    STATUS_SEVERITY_ERROR         = 0x00000003U,
}

alias DUPLICATE_HANDLE_OPTIONS = uint;
enum : uint
{
    DUPLICATE_CLOSE_SOURCE = 0x00000001U,
    DUPLICATE_SAME_ACCESS  = 0x00000002U,
}

alias HANDLE_FLAGS = uint;
enum : uint
{
    HANDLE_FLAG_INHERIT            = 0x00000001U,
    HANDLE_FLAG_PROTECT_FROM_CLOSE = 0x00000002U,
}

alias GENERIC_ACCESS_RIGHTS = uint;
enum : uint
{
    GENERIC_READ    = 0x80000000U,
    GENERIC_WRITE   = 0x40000000U,
    GENERIC_EXECUTE = 0x20000000U,
    GENERIC_ALL     = 0x10000000U,
}

alias OBJECT_ATTRIBUTE_FLAGS = uint;
enum : uint
{
    OBJ_INHERIT                       = 0x00000002U,
    OBJ_PERMANENT                     = 0x00000010U,
    OBJ_EXCLUSIVE                     = 0x00000020U,
    OBJ_CASE_INSENSITIVE              = 0x00000040U,
    OBJ_OPENIF                        = 0x00000080U,
    OBJ_OPENLINK                      = 0x00000100U,
    OBJ_KERNEL_HANDLE                 = 0x00000200U,
    OBJ_FORCE_ACCESS_CHECK            = 0x00000400U,
    OBJ_IGNORE_IMPERSONATED_DEVICEMAP = 0x00000800U,
    OBJ_DONT_REPARSE                  = 0x00001000U,
    OBJ_VALID_ATTRIBUTES              = 0x00001ff2U,
}

// Constants


enum BOOL TRUE = BOOL(0x00000001);
enum BOOL FALSE = BOOL(0x00000000);

enum : VARIANT_BOOL
{
    VARIANT_TRUE  = VARIANT_BOOL(cast(short) 0xffff),
    VARIANT_FALSE = VARIANT_BOOL(cast(short) 0x0000),
}

enum HANDLE INVALID_HANDLE_VALUE = HANDLE(cast(void*) 0xffffffff);
enum HRESULT CO_E_NOTINITIALIZED = HRESULT(0x800401f0);
enum NTSTATUS STILL_ACTIVE = NTSTATUS(0x00000103);
enum NTSTATUS EXCEPTION_ACCESS_VIOLATION = NTSTATUS(0xc0000005);
enum NTSTATUS EXCEPTION_DATATYPE_MISALIGNMENT = NTSTATUS(0x80000002);

enum : NTSTATUS
{
    EXCEPTION_BREAKPOINT            = NTSTATUS(0x80000003),
    EXCEPTION_SINGLE_STEP           = NTSTATUS(0x80000004),
    EXCEPTION_ARRAY_BOUNDS_EXCEEDED = NTSTATUS(0xc000008c),
}

enum : NTSTATUS
{
    EXCEPTION_FLT_DENORMAL_OPERAND  = NTSTATUS(0xc000008d),
    EXCEPTION_FLT_DIVIDE_BY_ZERO    = NTSTATUS(0xc000008e),
    EXCEPTION_FLT_INEXACT_RESULT    = NTSTATUS(0xc000008f),
    EXCEPTION_FLT_INVALID_OPERATION = NTSTATUS(0xc0000090),
    EXCEPTION_FLT_OVERFLOW          = NTSTATUS(0xc0000091),
    EXCEPTION_FLT_STACK_CHECK       = NTSTATUS(0xc0000092),
    EXCEPTION_FLT_UNDERFLOW         = NTSTATUS(0xc0000093),
    EXCEPTION_INT_DIVIDE_BY_ZERO    = NTSTATUS(0xc0000094),
    EXCEPTION_INT_OVERFLOW          = NTSTATUS(0xc0000095),
    EXCEPTION_PRIV_INSTRUCTION      = NTSTATUS(0xc0000096),
}

enum : NTSTATUS
{
    EXCEPTION_IN_PAGE_ERROR       = NTSTATUS(0xc0000006),
    EXCEPTION_ILLEGAL_INSTRUCTION = NTSTATUS(0xc000001d),
}

enum NTSTATUS EXCEPTION_NONCONTINUABLE_EXCEPTION = NTSTATUS(0xc0000025);

enum : NTSTATUS
{
    EXCEPTION_STACK_OVERFLOW      = NTSTATUS(0xc00000fd),
    EXCEPTION_INVALID_DISPOSITION = NTSTATUS(0xc0000026),
}

enum : NTSTATUS
{
    EXCEPTION_GUARD_PAGE        = NTSTATUS(0x80000001),
    EXCEPTION_INVALID_HANDLE    = NTSTATUS(0xc0000008),
    EXCEPTION_POSSIBLE_DEADLOCK = NTSTATUS(0xc0000194),
}

enum NTSTATUS EXCEPTION_SPAPI_UNRECOVERABLE_STACK_OVERFLOW = NTSTATUS(0xe0000300);
enum NTSTATUS CONTROL_C_EXIT = NTSTATUS(0xc000013a);
enum NTSTATUS STATUS_ACCESS_DENIED = NTSTATUS(0xc0000022);
enum HRESULT E_NOTIMPL = HRESULT(0x80004001);
enum HRESULT E_OUTOFMEMORY = HRESULT(0x8007000e);
enum HRESULT E_INVALIDARG = HRESULT(0x80070057);
enum HRESULT E_FAIL = HRESULT(0x80004005);
enum uint STRICT = 0x00000001U;
enum uint MAX_PATH = 0x00000104U;
enum NTSTATUS IO_ERR_INSUFFICIENT_RESOURCES = NTSTATUS(0xc0040002);
enum NTSTATUS IO_ERR_DRIVER_ERROR = NTSTATUS(0xc0040004);

enum : NTSTATUS
{
    IO_ERR_SEEK_ERROR       = NTSTATUS(0xc0040006),
    IO_ERR_BAD_BLOCK        = NTSTATUS(0xc0040007),
    IO_ERR_TIMEOUT          = NTSTATUS(0xc0040009),
    IO_ERR_CONTROLLER_ERROR = NTSTATUS(0xc004000b),
}

enum : NTSTATUS
{
    IO_ERR_NOT_READY       = NTSTATUS(0xc004000f),
    IO_ERR_INVALID_REQUEST = NTSTATUS(0xc0040010),
}

enum : NTSTATUS
{
    IO_ERR_RESET        = NTSTATUS(0xc0040013),
    IO_ERR_BAD_FIRMWARE = NTSTATUS(0xc0040019),
}

enum NTSTATUS IO_WRN_BAD_FIRMWARE = NTSTATUS(0x8004001a);
enum NTSTATUS IO_WRITE_CACHE_ENABLED = NTSTATUS(0x80040020);
enum NTSTATUS IO_RECOVERED_VIA_ECC = NTSTATUS(0x80040021);
enum NTSTATUS IO_WRITE_CACHE_DISABLED = NTSTATUS(0x80040022);
enum NTSTATUS IO_WARNING_PAGING_FAILURE = NTSTATUS(0x80040033);
enum NTSTATUS IO_WRN_FAILURE_PREDICTED = NTSTATUS(0x80040034);
enum NTSTATUS IO_WARNING_ALLOCATION_FAILED = NTSTATUS(0x80040038);

enum : NTSTATUS
{
    IO_WARNING_DUPLICATE_SIGNATURE = NTSTATUS(0x8004003a),
    IO_WARNING_DUPLICATE_PATH      = NTSTATUS(0x8004003b),
    IO_WARNING_WRITE_FUA_PROBLEM   = NTSTATUS(0x80040084),
}

enum NTSTATUS IO_WARNING_VOLUME_LOST_DISK_EXTENT = NTSTATUS(0x8004008e);
enum NTSTATUS IO_WARNING_DEVICE_HAS_INTERNAL_DUMP = NTSTATUS(0x8004008f);

enum : NTSTATUS
{
    IO_WARNING_SOFT_THRESHOLD_REACHED              = NTSTATUS(0x80040090),
    IO_WARNING_SOFT_THRESHOLD_REACHED_EX           = NTSTATUS(0x80040091),
    IO_WARNING_SOFT_THRESHOLD_REACHED_EX_LUN_LUN   = NTSTATUS(0x80040092),
    IO_WARNING_SOFT_THRESHOLD_REACHED_EX_LUN_POOL  = NTSTATUS(0x80040093),
    IO_WARNING_SOFT_THRESHOLD_REACHED_EX_POOL_LUN  = NTSTATUS(0x80040094),
    IO_WARNING_SOFT_THRESHOLD_REACHED_EX_POOL_POOL = NTSTATUS(0x80040095),
}

enum NTSTATUS IO_ERROR_DISK_RESOURCES_EXHAUSTED = NTSTATUS(0xc0040096);

enum : NTSTATUS
{
    IO_WARNING_DISK_CAPACITY_CHANGED          = NTSTATUS(0x80040097),
    IO_WARNING_DISK_PROVISIONING_TYPE_CHANGED = NTSTATUS(0x80040098),
}

enum NTSTATUS IO_WARNING_IO_OPERATION_RETRIED = NTSTATUS(0x80040099);
enum NTSTATUS IO_ERROR_IO_HARDWARE_ERROR = NTSTATUS(0xc004009a);

enum : NTSTATUS
{
    IO_WARNING_COMPLETION_TIME       = NTSTATUS(0x8004009b),
    IO_WARNING_DISK_SURPRISE_REMOVED = NTSTATUS(0x8004009d),
}

enum NTSTATUS IO_WARNING_REPEATED_DISK_GUID = NTSTATUS(0x8004009e);
enum NTSTATUS IO_WARNING_DISK_FIRMWARE_UPDATED = NTSTATUS(0x4004009f);
enum NTSTATUS IO_ERR_RETRY_SUCCEEDED = NTSTATUS(0x00040001);
enum NTSTATUS IO_DUMP_CREATION_SUCCESS = NTSTATUS(0x000400a2);

enum : NTSTATUS
{
    IO_FILE_QUOTA_THRESHOLD = NTSTATUS(0x40040024),
    IO_FILE_QUOTA_LIMIT     = NTSTATUS(0x40040025),
    IO_FILE_QUOTA_STARTED   = NTSTATUS(0x40040026),
    IO_FILE_QUOTA_SUCCEEDED = NTSTATUS(0x40040027),
}

enum NTSTATUS IO_INFO_THROTTLE_COMPLETE = NTSTATUS(0x40040077);
enum NTSTATUS IO_CDROM_EXCLUSIVE_LOCK = NTSTATUS(0x40040085);
enum NTSTATUS IO_WARNING_ADAPTER_FIRMWARE_UPDATED = NTSTATUS(0x400400a0);
enum NTSTATUS IO_FILE_QUOTA_FAILED = NTSTATUS(0x80040028);
enum NTSTATUS IO_LOST_DELAYED_WRITE = NTSTATUS(0x80040032);
enum NTSTATUS IO_WARNING_INTERRUPT_STILL_PENDING = NTSTATUS(0x80040035);
enum NTSTATUS IO_DRIVER_CANCEL_TIMEOUT = NTSTATUS(0x80040036);

enum : NTSTATUS
{
    IO_WARNING_LOG_FLUSH_FAILED = NTSTATUS(0x80040039),
    IO_WARNING_BUS_RESET        = NTSTATUS(0x80040076),
    IO_WARNING_RESET            = NTSTATUS(0x80040081),
}

enum : NTSTATUS
{
    IO_LOST_DELAYED_WRITE_NETWORK_DISCONNECTED     = NTSTATUS(0x8004008b),
    IO_LOST_DELAYED_WRITE_NETWORK_SERVER_ERROR     = NTSTATUS(0x8004008c),
    IO_LOST_DELAYED_WRITE_NETWORK_LOCAL_DISK_ERROR = NTSTATUS(0x8004008d),
}

enum NTSTATUS IO_WARNING_DUMP_DISABLED_DEVICE_GONE = NTSTATUS(0x8004009c);
enum NTSTATUS IO_ERR_CONFIGURATION_ERROR = NTSTATUS(0xc0040003);

enum : NTSTATUS
{
    IO_ERR_PARITY        = NTSTATUS(0xc0040005),
    IO_ERR_OVERRUN_ERROR = NTSTATUS(0xc0040008),
}

enum : NTSTATUS
{
    IO_ERR_SEQUENCE       = NTSTATUS(0xc004000a),
    IO_ERR_INTERNAL_ERROR = NTSTATUS(0xc004000c),
    IO_ERR_INCORRECT_IRQL = NTSTATUS(0xc004000d),
    IO_ERR_INVALID_IOBASE = NTSTATUS(0xc004000e),
}

enum : NTSTATUS
{
    IO_ERR_VERSION         = NTSTATUS(0xc0040011),
    IO_ERR_LAYERED_FAILURE = NTSTATUS(0xc0040012),
}

enum : NTSTATUS
{
    IO_ERR_PROTOCOL                 = NTSTATUS(0xc0040014),
    IO_ERR_MEMORY_CONFLICT_DETECTED = NTSTATUS(0xc0040015),
}

enum NTSTATUS IO_ERR_PORT_CONFLICT_DETECTED = NTSTATUS(0xc0040016);
enum NTSTATUS IO_ERR_DMA_CONFLICT_DETECTED = NTSTATUS(0xc0040017);
enum NTSTATUS IO_ERR_IRQ_CONFLICT_DETECTED = NTSTATUS(0xc0040018);
enum NTSTATUS IO_ERR_DMA_RESOURCE_CONFLICT = NTSTATUS(0xc004001b);
enum NTSTATUS IO_ERR_INTERRUPT_RESOURCE_CONFLICT = NTSTATUS(0xc004001c);
enum NTSTATUS IO_ERR_MEMORY_RESOURCE_CONFLICT = NTSTATUS(0xc004001d);
enum NTSTATUS IO_ERR_PORT_RESOURCE_CONFLICT = NTSTATUS(0xc004001e);
enum NTSTATUS IO_BAD_BLOCK_WITH_NAME = NTSTATUS(0xc004001f);
enum NTSTATUS IO_FILE_SYSTEM_CORRUPT = NTSTATUS(0xc0040029);
enum NTSTATUS IO_FILE_QUOTA_CORRUPT = NTSTATUS(0xc004002a);
enum NTSTATUS IO_SYSTEM_SLEEP_FAILED = NTSTATUS(0xc004002b);
enum NTSTATUS IO_DUMP_POINTER_FAILURE = NTSTATUS(0xc004002c);
enum NTSTATUS IO_DUMP_DRIVER_LOAD_FAILURE = NTSTATUS(0xc004002d);
enum NTSTATUS IO_DUMP_INITIALIZATION_FAILURE = NTSTATUS(0xc004002e);
enum NTSTATUS IO_DUMP_DUMPFILE_CONFLICT = NTSTATUS(0xc004002f);
enum NTSTATUS IO_DUMP_DIRECT_CONFIG_FAILED = NTSTATUS(0xc0040030);
enum NTSTATUS IO_DUMP_PAGE_CONFIG_FAILED = NTSTATUS(0xc0040031);
enum NTSTATUS IO_FILE_SYSTEM_CORRUPT_WITH_NAME = NTSTATUS(0xc0040037);
enum NTSTATUS IO_ERR_THREAD_STUCK_IN_DEVICE_DRIVER = NTSTATUS(0xc004006c);
enum NTSTATUS IO_ERR_PORT_TIMEOUT = NTSTATUS(0xc0040075);
enum NTSTATUS IO_ERROR_DUMP_CREATION_ERROR = NTSTATUS(0xc00400a1);
enum NTSTATUS IO_DUMP_CALLBACK_EXCEPTION = NTSTATUS(0xc00400a3);
enum NTSTATUS IO_DUMP_INIT_DEDICATED_DUMP_FAILURE = NTSTATUS(0xc00400a4);
enum NTSTATUS MCA_INFO_CPU_THERMAL_THROTTLING_REMOVED = NTSTATUS(0x40050070);
enum NTSTATUS MCA_INFO_NO_MORE_CORRECTED_ERROR_LOGS = NTSTATUS(0x40050073);
enum NTSTATUS MCA_INFO_MEMORY_PAGE_MARKED_BAD = NTSTATUS(0x40050074);

enum : NTSTATUS
{
    MCA_WARNING_CACHE                        = NTSTATUS(0x8005003c),
    MCA_WARNING_TLB                          = NTSTATUS(0x8005003e),
    MCA_WARNING_CPU_BUS                      = NTSTATUS(0x80050040),
    MCA_WARNING_REGISTER_FILE                = NTSTATUS(0x80050042),
    MCA_WARNING_MAS                          = NTSTATUS(0x80050044),
    MCA_WARNING_MEM_UNKNOWN                  = NTSTATUS(0x80050046),
    MCA_WARNING_MEM_1_2                      = NTSTATUS(0x80050048),
    MCA_WARNING_MEM_1_2_5                    = NTSTATUS(0x8005004a),
    MCA_WARNING_MEM_1_2_5_4                  = NTSTATUS(0x8005004c),
    MCA_WARNING_SYSTEM_EVENT                 = NTSTATUS(0x8005004e),
    MCA_WARNING_PCI_BUS_PARITY               = NTSTATUS(0x80050050),
    MCA_WARNING_PCI_BUS_PARITY_NO_INFO       = NTSTATUS(0x80050052),
    MCA_WARNING_PCI_BUS_SERR                 = NTSTATUS(0x80050054),
    MCA_WARNING_PCI_BUS_SERR_NO_INFO         = NTSTATUS(0x80050056),
    MCA_WARNING_PCI_BUS_MASTER_ABORT         = NTSTATUS(0x80050058),
    MCA_WARNING_PCI_BUS_MASTER_ABORT_NO_INFO = NTSTATUS(0x8005005a),
    MCA_WARNING_PCI_BUS_TIMEOUT              = NTSTATUS(0x8005005c),
    MCA_WARNING_PCI_BUS_TIMEOUT_NO_INFO      = NTSTATUS(0x8005005e),
    MCA_WARNING_PCI_BUS_UNKNOWN              = NTSTATUS(0x80050060),
    MCA_WARNING_PCI_DEVICE                   = NTSTATUS(0x80050062),
    MCA_WARNING_SMBIOS                       = NTSTATUS(0x80050064),
    MCA_WARNING_PLATFORM_SPECIFIC            = NTSTATUS(0x80050066),
    MCA_WARNING_UNKNOWN                      = NTSTATUS(0x80050068),
    MCA_WARNING_UNKNOWN_NO_CPU               = NTSTATUS(0x8005006a),
    MCA_WARNING_CMC_THRESHOLD_EXCEEDED       = NTSTATUS(0x8005006d),
}

enum : NTSTATUS
{
    MCA_WARNING_CPE_THRESHOLD_EXCEEDED = NTSTATUS(0x8005006e),
    MCA_WARNING_CPU_THERMAL_THROTTLED  = NTSTATUS(0x8005006f),
    MCA_WARNING_CPU                    = NTSTATUS(0x80050071),
}

enum : NTSTATUS
{
    MCA_ERROR_CACHE                        = NTSTATUS(0xc005003d),
    MCA_ERROR_TLB                          = NTSTATUS(0xc005003f),
    MCA_ERROR_CPU_BUS                      = NTSTATUS(0xc0050041),
    MCA_ERROR_REGISTER_FILE                = NTSTATUS(0xc0050043),
    MCA_ERROR_MAS                          = NTSTATUS(0xc0050045),
    MCA_ERROR_MEM_UNKNOWN                  = NTSTATUS(0xc0050047),
    MCA_ERROR_MEM_1_2                      = NTSTATUS(0xc0050049),
    MCA_ERROR_MEM_1_2_5                    = NTSTATUS(0xc005004b),
    MCA_ERROR_MEM_1_2_5_4                  = NTSTATUS(0xc005004d),
    MCA_ERROR_SYSTEM_EVENT                 = NTSTATUS(0xc005004f),
    MCA_ERROR_PCI_BUS_PARITY               = NTSTATUS(0xc0050051),
    MCA_ERROR_PCI_BUS_PARITY_NO_INFO       = NTSTATUS(0xc0050053),
    MCA_ERROR_PCI_BUS_SERR                 = NTSTATUS(0xc0050055),
    MCA_ERROR_PCI_BUS_SERR_NO_INFO         = NTSTATUS(0xc0050057),
    MCA_ERROR_PCI_BUS_MASTER_ABORT         = NTSTATUS(0xc0050059),
    MCA_ERROR_PCI_BUS_MASTER_ABORT_NO_INFO = NTSTATUS(0xc005005b),
    MCA_ERROR_PCI_BUS_TIMEOUT              = NTSTATUS(0xc005005d),
    MCA_ERROR_PCI_BUS_TIMEOUT_NO_INFO      = NTSTATUS(0xc005005f),
    MCA_ERROR_PCI_BUS_UNKNOWN              = NTSTATUS(0xc0050061),
    MCA_ERROR_PCI_DEVICE                   = NTSTATUS(0xc0050063),
    MCA_ERROR_SMBIOS                       = NTSTATUS(0xc0050065),
    MCA_ERROR_PLATFORM_SPECIFIC            = NTSTATUS(0xc0050067),
}

enum : NTSTATUS
{
    MCA_ERROR_UNKNOWN        = NTSTATUS(0xc0050069),
    MCA_ERROR_UNKNOWN_NO_CPU = NTSTATUS(0xc005006b),
    MCA_ERROR_CPU            = NTSTATUS(0xc0050072),
}

enum NTSTATUS MCA_MEMORYHIERARCHY_ERROR = NTSTATUS(0xc0050078);
enum NTSTATUS MCA_TLB_ERROR = NTSTATUS(0xc0050079);

enum : NTSTATUS
{
    MCA_BUS_ERROR         = NTSTATUS(0xc005007a),
    MCA_BUS_TIMEOUT_ERROR = NTSTATUS(0xc005007b),
}

enum NTSTATUS MCA_INTERNALTIMER_ERROR = NTSTATUS(0xc005007c);
enum NTSTATUS MCA_MICROCODE_ROM_PARITY_ERROR = NTSTATUS(0xc005007e);
enum NTSTATUS MCA_EXTERNAL_ERROR = NTSTATUS(0xc005007f);
enum NTSTATUS MCA_FRC_ERROR = NTSTATUS(0xc0050080);

enum : NTSTATUS
{
    VOLMGR_KSR_ERROR      = NTSTATUS(0x80380001),
    VOLMGR_KSR_READ_ERROR = NTSTATUS(0x80380002),
    VOLMGR_KSR_BYPASS     = NTSTATUS(0x80380003),
}

enum NTSTATUS STATUS_WAIT_0 = NTSTATUS(0x00000000);
enum uint FACILTIY_MUI_ERROR_CODE = 0x0000000bU;

enum : NTSTATUS
{
    STATUS_SUCCESS           = NTSTATUS(0x00000000),
    STATUS_WAIT_1            = NTSTATUS(0x00000001),
    STATUS_WAIT_2            = NTSTATUS(0x00000002),
    STATUS_WAIT_3            = NTSTATUS(0x00000003),
    STATUS_WAIT_63           = NTSTATUS(0x0000003f),
    STATUS_ABANDONED         = NTSTATUS(0x00000080),
    STATUS_ABANDONED_WAIT_0  = NTSTATUS(0x00000080),
    STATUS_ABANDONED_WAIT_63 = NTSTATUS(0x000000bf),
}

enum : NTSTATUS
{
    STATUS_USER_APC         = NTSTATUS(0x000000c0),
    STATUS_ALREADY_COMPLETE = NTSTATUS(0x000000ff),
}

enum : NTSTATUS
{
    STATUS_KERNEL_APC   = NTSTATUS(0x00000100),
    STATUS_ALERTED      = NTSTATUS(0x00000101),
    STATUS_TIMEOUT      = NTSTATUS(0x00000102),
    STATUS_PENDING      = NTSTATUS(0x00000103),
    STATUS_REPARSE      = NTSTATUS(0x00000104),
    STATUS_MORE_ENTRIES = NTSTATUS(0x00000105),
}

enum NTSTATUS STATUS_NOT_ALL_ASSIGNED = NTSTATUS(0x00000106);
enum NTSTATUS STATUS_SOME_NOT_MAPPED = NTSTATUS(0x00000107);
enum NTSTATUS STATUS_OPLOCK_BREAK_IN_PROGRESS = NTSTATUS(0x00000108);
enum NTSTATUS STATUS_VOLUME_MOUNTED = NTSTATUS(0x00000109);
enum NTSTATUS STATUS_RXACT_COMMITTED = NTSTATUS(0x0000010a);

enum : NTSTATUS
{
    STATUS_NOTIFY_CLEANUP        = NTSTATUS(0x0000010b),
    STATUS_NOTIFY_ENUM_DIR       = NTSTATUS(0x0000010c),
    STATUS_NO_QUOTAS_FOR_ACCOUNT = NTSTATUS(0x0000010d),
}

enum NTSTATUS STATUS_PRIMARY_TRANSPORT_CONNECT_FAILED = NTSTATUS(0x0000010e);

enum : NTSTATUS
{
    STATUS_PAGE_FAULT_TRANSITION    = NTSTATUS(0x00000110),
    STATUS_PAGE_FAULT_DEMAND_ZERO   = NTSTATUS(0x00000111),
    STATUS_PAGE_FAULT_COPY_ON_WRITE = NTSTATUS(0x00000112),
    STATUS_PAGE_FAULT_GUARD_PAGE    = NTSTATUS(0x00000113),
    STATUS_PAGE_FAULT_PAGING_FILE   = NTSTATUS(0x00000114),
}

enum NTSTATUS STATUS_CACHE_PAGE_LOCKED = NTSTATUS(0x00000115);

enum : NTSTATUS
{
    STATUS_CRASH_DUMP       = NTSTATUS(0x00000116),
    STATUS_BUFFER_ALL_ZEROS = NTSTATUS(0x00000117),
}

enum : NTSTATUS
{
    STATUS_REPARSE_OBJECT                = NTSTATUS(0x00000118),
    STATUS_RESOURCE_REQUIREMENTS_CHANGED = NTSTATUS(0x00000119),
}

enum NTSTATUS STATUS_TRANSLATION_COMPLETE = NTSTATUS(0x00000120);
enum NTSTATUS STATUS_DS_MEMBERSHIP_EVALUATED_LOCALLY = NTSTATUS(0x00000121);
enum NTSTATUS STATUS_NOTHING_TO_TERMINATE = NTSTATUS(0x00000122);

enum : NTSTATUS
{
    STATUS_PROCESS_NOT_IN_JOB = NTSTATUS(0x00000123),
    STATUS_PROCESS_IN_JOB     = NTSTATUS(0x00000124),
}

enum NTSTATUS STATUS_VOLSNAP_HIBERNATE_READY = NTSTATUS(0x00000125);
enum NTSTATUS STATUS_FSFILTER_OP_COMPLETED_SUCCESSFULLY = NTSTATUS(0x00000126);

enum : NTSTATUS
{
    STATUS_INTERRUPT_VECTOR_ALREADY_CONNECTED = NTSTATUS(0x00000127),
    STATUS_INTERRUPT_STILL_CONNECTED          = NTSTATUS(0x00000128),
}

enum NTSTATUS STATUS_PROCESS_CLONED = NTSTATUS(0x00000129);

enum : NTSTATUS
{
    STATUS_FILE_LOCKED_WITH_ONLY_READERS = NTSTATUS(0x0000012a),
    STATUS_FILE_LOCKED_WITH_WRITERS      = NTSTATUS(0x0000012b),
}

enum : NTSTATUS
{
    STATUS_VALID_IMAGE_HASH       = NTSTATUS(0x0000012c),
    STATUS_VALID_CATALOG_HASH     = NTSTATUS(0x0000012d),
    STATUS_VALID_STRONG_CODE_HASH = NTSTATUS(0x0000012e),
}

enum : NTSTATUS
{
    STATUS_GHOSTED          = NTSTATUS(0x0000012f),
    STATUS_DATA_OVERWRITTEN = NTSTATUS(0x00000130),
}

enum NTSTATUS STATUS_RESOURCEMANAGER_READ_ONLY = NTSTATUS(0x00000202);

enum : NTSTATUS
{
    STATUS_RING_PREVIOUSLY_EMPTY       = NTSTATUS(0x00000210),
    STATUS_RING_PREVIOUSLY_FULL        = NTSTATUS(0x00000211),
    STATUS_RING_PREVIOUSLY_ABOVE_QUOTA = NTSTATUS(0x00000212),
}

enum : NTSTATUS
{
    STATUS_RING_NEWLY_EMPTY              = NTSTATUS(0x00000213),
    STATUS_RING_SIGNAL_OPPOSITE_ENDPOINT = NTSTATUS(0x00000214),
}

enum NTSTATUS STATUS_OPLOCK_SWITCHED_TO_NEW_HANDLE = NTSTATUS(0x00000215);
enum NTSTATUS STATUS_OPLOCK_HANDLE_CLOSED = NTSTATUS(0x00000216);
enum NTSTATUS STATUS_WAIT_FOR_OPLOCK = NTSTATUS(0x00000367);
enum NTSTATUS STATUS_REPARSE_GLOBAL = NTSTATUS(0x00000368);
enum NTSTATUS STATUS_PAGE_FAULT_RETRY = NTSTATUS(0x00000369);
enum NTSTATUS DBG_EXCEPTION_HANDLED = NTSTATUS(0x00010001);
enum NTSTATUS DBG_CONTINUE = NTSTATUS(0x00010002);
enum NTSTATUS STATUS_FLT_IO_COMPLETE = NTSTATUS(0x001c0001);
enum NTSTATUS STATUS_OBJECT_NAME_EXISTS = NTSTATUS(0x40000000);
enum NTSTATUS STATUS_THREAD_WAS_SUSPENDED = NTSTATUS(0x40000001);
enum NTSTATUS STATUS_WORKING_SET_LIMIT_RANGE = NTSTATUS(0x40000002);
enum NTSTATUS STATUS_IMAGE_NOT_AT_BASE = NTSTATUS(0x40000003);
enum NTSTATUS STATUS_RXACT_STATE_CREATED = NTSTATUS(0x40000004);
enum NTSTATUS STATUS_SEGMENT_NOTIFICATION = NTSTATUS(0x40000005);
enum NTSTATUS STATUS_LOCAL_USER_SESSION_KEY = NTSTATUS(0x40000006);
enum NTSTATUS STATUS_BAD_CURRENT_DIRECTORY = NTSTATUS(0x40000007);
enum NTSTATUS STATUS_SERIAL_MORE_WRITES = NTSTATUS(0x40000008);
enum NTSTATUS STATUS_REGISTRY_RECOVERED = NTSTATUS(0x40000009);
enum NTSTATUS STATUS_FT_READ_RECOVERY_FROM_BACKUP = NTSTATUS(0x4000000a);
enum NTSTATUS STATUS_FT_WRITE_RECOVERY = NTSTATUS(0x4000000b);
enum NTSTATUS STATUS_SERIAL_COUNTER_TIMEOUT = NTSTATUS(0x4000000c);
enum NTSTATUS STATUS_NULL_LM_PASSWORD = NTSTATUS(0x4000000d);
enum NTSTATUS STATUS_IMAGE_MACHINE_TYPE_MISMATCH = NTSTATUS(0x4000000e);

enum : NTSTATUS
{
    STATUS_RECEIVE_PARTIAL           = NTSTATUS(0x4000000f),
    STATUS_RECEIVE_EXPEDITED         = NTSTATUS(0x40000010),
    STATUS_RECEIVE_PARTIAL_EXPEDITED = NTSTATUS(0x40000011),
}

enum : NTSTATUS
{
    STATUS_EVENT_DONE    = NTSTATUS(0x40000012),
    STATUS_EVENT_PENDING = NTSTATUS(0x40000013),
}

enum NTSTATUS STATUS_CHECKING_FILE_SYSTEM = NTSTATUS(0x40000014);
enum NTSTATUS STATUS_FATAL_APP_EXIT = NTSTATUS(0x40000015);
enum NTSTATUS STATUS_PREDEFINED_HANDLE = NTSTATUS(0x40000016);
enum NTSTATUS STATUS_WAS_UNLOCKED = NTSTATUS(0x40000017);
enum NTSTATUS STATUS_SERVICE_NOTIFICATION = NTSTATUS(0x40000018);

enum : NTSTATUS
{
    STATUS_WAS_LOCKED     = NTSTATUS(0x40000019),
    STATUS_LOG_HARD_ERROR = NTSTATUS(0x4000001a),
}

enum NTSTATUS STATUS_ALREADY_WIN32 = NTSTATUS(0x4000001b);

enum : NTSTATUS
{
    STATUS_WX86_UNSIMULATE           = NTSTATUS(0x4000001c),
    STATUS_WX86_CONTINUE             = NTSTATUS(0x4000001d),
    STATUS_WX86_SINGLE_STEP          = NTSTATUS(0x4000001e),
    STATUS_WX86_BREAKPOINT           = NTSTATUS(0x4000001f),
    STATUS_WX86_EXCEPTION_CONTINUE   = NTSTATUS(0x40000020),
    STATUS_WX86_EXCEPTION_LASTCHANCE = NTSTATUS(0x40000021),
    STATUS_WX86_EXCEPTION_CHAIN      = NTSTATUS(0x40000022),
}

enum NTSTATUS STATUS_IMAGE_MACHINE_TYPE_MISMATCH_EXE = NTSTATUS(0x40000023);
enum NTSTATUS STATUS_NO_YIELD_PERFORMED = NTSTATUS(0x40000024);
enum NTSTATUS STATUS_TIMER_RESUME_IGNORED = NTSTATUS(0x40000025);
enum NTSTATUS STATUS_ARBITRATION_UNHANDLED = NTSTATUS(0x40000026);
enum NTSTATUS STATUS_CARDBUS_NOT_SUPPORTED = NTSTATUS(0x40000027);
enum NTSTATUS STATUS_WX86_CREATEWX86TIB = NTSTATUS(0x40000028);
enum NTSTATUS STATUS_MP_PROCESSOR_MISMATCH = NTSTATUS(0x40000029);

enum : NTSTATUS
{
    STATUS_HIBERNATED         = NTSTATUS(0x4000002a),
    STATUS_RESUME_HIBERNATION = NTSTATUS(0x4000002b),
}

enum NTSTATUS STATUS_FIRMWARE_UPDATED = NTSTATUS(0x4000002c);
enum NTSTATUS STATUS_DRIVERS_LEAKING_LOCKED_PAGES = NTSTATUS(0x4000002d);
enum NTSTATUS STATUS_MESSAGE_RETRIEVED = NTSTATUS(0x4000002e);
enum NTSTATUS STATUS_SYSTEM_POWERSTATE_TRANSITION = NTSTATUS(0x4000002f);
enum NTSTATUS STATUS_ALPC_CHECK_COMPLETION_LIST = NTSTATUS(0x40000030);
enum NTSTATUS STATUS_SYSTEM_POWERSTATE_COMPLEX_TRANSITION = NTSTATUS(0x40000031);
enum NTSTATUS STATUS_ACCESS_AUDIT_BY_POLICY = NTSTATUS(0x40000032);
enum NTSTATUS STATUS_ABANDON_HIBERFILE = NTSTATUS(0x40000033);
enum NTSTATUS STATUS_BIZRULES_NOT_ENABLED = NTSTATUS(0x40000034);
enum NTSTATUS STATUS_FT_READ_FROM_COPY = NTSTATUS(0x40000035);
enum NTSTATUS STATUS_IMAGE_AT_DIFFERENT_BASE = NTSTATUS(0x40000036);
enum NTSTATUS STATUS_PATCH_DEFERRED = NTSTATUS(0x40000037);

enum : NTSTATUS
{
    STATUS_EMULATION_BREAKPOINT      = NTSTATUS(0x40000038),
    STATUS_EMULATION_SYSCALL         = NTSTATUS(0x40000039),
    STATUS_EMULATION_FLOAT_EXCEPTION = NTSTATUS(0x4000003a),
}

enum NTSTATUS DBG_REPLY_LATER = NTSTATUS(0x40010001);
enum NTSTATUS DBG_UNABLE_TO_PROVIDE_HANDLE = NTSTATUS(0x40010002);

enum : NTSTATUS
{
    DBG_TERMINATE_THREAD  = NTSTATUS(0x40010003),
    DBG_TERMINATE_PROCESS = NTSTATUS(0x40010004),
}

enum NTSTATUS DBG_CONTROL_C = NTSTATUS(0x40010005);
enum NTSTATUS DBG_PRINTEXCEPTION_C = NTSTATUS(0x40010006);
enum NTSTATUS DBG_RIPEXCEPTION = NTSTATUS(0x40010007);
enum NTSTATUS DBG_CONTROL_BREAK = NTSTATUS(0x40010008);
enum NTSTATUS DBG_COMMAND_EXCEPTION = NTSTATUS(0x40010009);
enum NTSTATUS DBG_PRINTEXCEPTION_WIDE_C = NTSTATUS(0x4001000a);
enum NTSTATUS STATUS_HEURISTIC_DAMAGE_POSSIBLE = NTSTATUS(0x40190001);
enum NTSTATUS STATUS_GUARD_PAGE_VIOLATION = NTSTATUS(0x80000001);
enum NTSTATUS STATUS_DATATYPE_MISALIGNMENT = NTSTATUS(0x80000002);

enum : NTSTATUS
{
    STATUS_BREAKPOINT  = NTSTATUS(0x80000003),
    STATUS_SINGLE_STEP = NTSTATUS(0x80000004),
}

enum NTSTATUS STATUS_BUFFER_OVERFLOW = NTSTATUS(0x80000005);
enum NTSTATUS STATUS_NO_MORE_FILES = NTSTATUS(0x80000006);
enum NTSTATUS STATUS_WAKE_SYSTEM_DEBUGGER = NTSTATUS(0x80000007);
enum NTSTATUS STATUS_HANDLES_CLOSED = NTSTATUS(0x8000000a);
enum NTSTATUS STATUS_NO_INHERITANCE = NTSTATUS(0x8000000b);
enum NTSTATUS STATUS_GUID_SUBSTITUTION_MADE = NTSTATUS(0x8000000c);
enum NTSTATUS STATUS_PARTIAL_COPY = NTSTATUS(0x8000000d);

enum : NTSTATUS
{
    STATUS_DEVICE_PAPER_EMPTY = NTSTATUS(0x8000000e),
    STATUS_DEVICE_POWERED_OFF = NTSTATUS(0x8000000f),
    STATUS_DEVICE_OFF_LINE    = NTSTATUS(0x80000010),
    STATUS_DEVICE_BUSY        = NTSTATUS(0x80000011),
}

enum NTSTATUS STATUS_NO_MORE_EAS = NTSTATUS(0x80000012);
enum NTSTATUS STATUS_INVALID_EA_NAME = NTSTATUS(0x80000013);
enum NTSTATUS STATUS_EA_LIST_INCONSISTENT = NTSTATUS(0x80000014);
enum NTSTATUS STATUS_INVALID_EA_FLAG = NTSTATUS(0x80000015);
enum NTSTATUS STATUS_VERIFY_REQUIRED = NTSTATUS(0x80000016);
enum NTSTATUS STATUS_EXTRANEOUS_INFORMATION = NTSTATUS(0x80000017);
enum NTSTATUS STATUS_RXACT_COMMIT_NECESSARY = NTSTATUS(0x80000018);
enum NTSTATUS STATUS_NO_MORE_ENTRIES = NTSTATUS(0x8000001a);
enum NTSTATUS STATUS_FILEMARK_DETECTED = NTSTATUS(0x8000001b);
enum NTSTATUS STATUS_MEDIA_CHANGED = NTSTATUS(0x8000001c);

enum : NTSTATUS
{
    STATUS_BUS_RESET    = NTSTATUS(0x8000001d),
    STATUS_END_OF_MEDIA = NTSTATUS(0x8000001e),
}

enum NTSTATUS STATUS_BEGINNING_OF_MEDIA = NTSTATUS(0x8000001f);
enum NTSTATUS STATUS_MEDIA_CHECK = NTSTATUS(0x80000020);
enum NTSTATUS STATUS_SETMARK_DETECTED = NTSTATUS(0x80000021);
enum NTSTATUS STATUS_NO_DATA_DETECTED = NTSTATUS(0x80000022);
enum NTSTATUS STATUS_REDIRECTOR_HAS_OPEN_HANDLES = NTSTATUS(0x80000023);
enum NTSTATUS STATUS_SERVER_HAS_OPEN_HANDLES = NTSTATUS(0x80000024);
enum NTSTATUS STATUS_ALREADY_DISCONNECTED = NTSTATUS(0x80000025);

enum : NTSTATUS
{
    STATUS_LONGJUMP                    = NTSTATUS(0x80000026),
    STATUS_CLEANER_CARTRIDGE_INSTALLED = NTSTATUS(0x80000027),
}

enum NTSTATUS STATUS_PLUGPLAY_QUERY_VETOED = NTSTATUS(0x80000028);
enum NTSTATUS STATUS_UNWIND_CONSOLIDATE = NTSTATUS(0x80000029);
enum NTSTATUS STATUS_REGISTRY_HIVE_RECOVERED = NTSTATUS(0x8000002a);

enum : NTSTATUS
{
    STATUS_DLL_MIGHT_BE_INSECURE     = NTSTATUS(0x8000002b),
    STATUS_DLL_MIGHT_BE_INCOMPATIBLE = NTSTATUS(0x8000002c),
}

enum NTSTATUS STATUS_STOPPED_ON_SYMLINK = NTSTATUS(0x8000002d);
enum NTSTATUS STATUS_CANNOT_GRANT_REQUESTED_OPLOCK = NTSTATUS(0x8000002e);
enum NTSTATUS STATUS_NO_ACE_CONDITION = NTSTATUS(0x8000002f);

enum : NTSTATUS
{
    STATUS_DEVICE_SUPPORT_IN_PROGRESS  = NTSTATUS(0x80000030),
    STATUS_DEVICE_POWER_CYCLE_REQUIRED = NTSTATUS(0x80000031),
}

enum NTSTATUS STATUS_NO_WORK_DONE = NTSTATUS(0x80000032);
enum NTSTATUS STATUS_RETURN_ADDRESS_HIJACK_ATTEMPT = NTSTATUS(0x80000033);
enum NTSTATUS STATUS_RECOVERABLE_BUGCHECK = NTSTATUS(0x80000034);
enum NTSTATUS STATUS_PTE_CHANGE_NOT_COMPLETED = NTSTATUS(0x80000035);
enum NTSTATUS DBG_EXCEPTION_NOT_HANDLED = NTSTATUS(0x80010001);

enum : NTSTATUS
{
    STATUS_CLUSTER_NODE_ALREADY_UP         = NTSTATUS(0x80130001),
    STATUS_CLUSTER_NODE_ALREADY_DOWN       = NTSTATUS(0x80130002),
    STATUS_CLUSTER_NETWORK_ALREADY_ONLINE  = NTSTATUS(0x80130003),
    STATUS_CLUSTER_NETWORK_ALREADY_OFFLINE = NTSTATUS(0x80130004),
    STATUS_CLUSTER_NODE_ALREADY_MEMBER     = NTSTATUS(0x80130005),
}

enum NTSTATUS STATUS_FLT_BUFFER_TOO_SMALL = NTSTATUS(0x801c0001);
enum NTSTATUS STATUS_GRAPHICS_LINK_CONFIGURATION_IN_PROGRESS = NTSTATUS(0x801e0000);

enum : NTSTATUS
{
    STATUS_FVE_PARTIAL_METADATA = NTSTATUS(0x80210001),
    STATUS_FVE_TRANSIENT_STATE  = NTSTATUS(0x80210002),
}

enum NTSTATUS STATUS_CLOUD_FILE_PROPERTY_BLOB_CHECKSUM_MISMATCH = NTSTATUS(0x8000cf00);
enum NTSTATUS STATUS_UNSUCCESSFUL = NTSTATUS(0xc0000001);
enum NTSTATUS STATUS_NOT_IMPLEMENTED = NTSTATUS(0xc0000002);
enum NTSTATUS STATUS_INVALID_INFO_CLASS = NTSTATUS(0xc0000003);
enum NTSTATUS STATUS_INFO_LENGTH_MISMATCH = NTSTATUS(0xc0000004);
enum NTSTATUS STATUS_ACCESS_VIOLATION = NTSTATUS(0xc0000005);
enum NTSTATUS STATUS_IN_PAGE_ERROR = NTSTATUS(0xc0000006);
enum NTSTATUS STATUS_PAGEFILE_QUOTA = NTSTATUS(0xc0000007);
enum NTSTATUS STATUS_INVALID_HANDLE = NTSTATUS(0xc0000008);

enum : NTSTATUS
{
    STATUS_BAD_INITIAL_STACK = NTSTATUS(0xc0000009),
    STATUS_BAD_INITIAL_PC    = NTSTATUS(0xc000000a),
}

enum NTSTATUS STATUS_INVALID_CID = NTSTATUS(0xc000000b);
enum NTSTATUS STATUS_TIMER_NOT_CANCELED = NTSTATUS(0xc000000c);
enum NTSTATUS STATUS_INVALID_PARAMETER = NTSTATUS(0xc000000d);

enum : NTSTATUS
{
    STATUS_NO_SUCH_DEVICE = NTSTATUS(0xc000000e),
    STATUS_NO_SUCH_FILE   = NTSTATUS(0xc000000f),
}

enum NTSTATUS STATUS_INVALID_DEVICE_REQUEST = NTSTATUS(0xc0000010);
enum NTSTATUS STATUS_END_OF_FILE = NTSTATUS(0xc0000011);
enum NTSTATUS STATUS_WRONG_VOLUME = NTSTATUS(0xc0000012);
enum NTSTATUS STATUS_NO_MEDIA_IN_DEVICE = NTSTATUS(0xc0000013);
enum NTSTATUS STATUS_UNRECOGNIZED_MEDIA = NTSTATUS(0xc0000014);
enum NTSTATUS STATUS_NONEXISTENT_SECTOR = NTSTATUS(0xc0000015);
enum NTSTATUS STATUS_MORE_PROCESSING_REQUIRED = NTSTATUS(0xc0000016);

enum : NTSTATUS
{
    STATUS_NO_MEMORY             = NTSTATUS(0xc0000017),
    STATUS_CONFLICTING_ADDRESSES = NTSTATUS(0xc0000018),
}

enum NTSTATUS STATUS_NOT_MAPPED_VIEW = NTSTATUS(0xc0000019);

enum : NTSTATUS
{
    STATUS_UNABLE_TO_FREE_VM        = NTSTATUS(0xc000001a),
    STATUS_UNABLE_TO_DELETE_SECTION = NTSTATUS(0xc000001b),
}

enum NTSTATUS STATUS_INVALID_SYSTEM_SERVICE = NTSTATUS(0xc000001c);
enum NTSTATUS STATUS_ILLEGAL_INSTRUCTION = NTSTATUS(0xc000001d);

enum : NTSTATUS
{
    STATUS_INVALID_LOCK_SEQUENCE    = NTSTATUS(0xc000001e),
    STATUS_INVALID_VIEW_SIZE        = NTSTATUS(0xc000001f),
    STATUS_INVALID_FILE_FOR_SECTION = NTSTATUS(0xc0000020),
}

enum NTSTATUS STATUS_ALREADY_COMMITTED = NTSTATUS(0xc0000021);
enum NTSTATUS STATUS_BUFFER_TOO_SMALL = NTSTATUS(0xc0000023);
enum NTSTATUS STATUS_OBJECT_TYPE_MISMATCH = NTSTATUS(0xc0000024);
enum NTSTATUS STATUS_NONCONTINUABLE_EXCEPTION = NTSTATUS(0xc0000025);
enum NTSTATUS STATUS_INVALID_DISPOSITION = NTSTATUS(0xc0000026);

enum : NTSTATUS
{
    STATUS_UNWIND                = NTSTATUS(0xc0000027),
    STATUS_BAD_STACK             = NTSTATUS(0xc0000028),
    STATUS_INVALID_UNWIND_TARGET = NTSTATUS(0xc0000029),
}

enum : NTSTATUS
{
    STATUS_NOT_LOCKED   = NTSTATUS(0xc000002a),
    STATUS_PARITY_ERROR = NTSTATUS(0xc000002b),
}

enum NTSTATUS STATUS_UNABLE_TO_DECOMMIT_VM = NTSTATUS(0xc000002c);
enum NTSTATUS STATUS_NOT_COMMITTED = NTSTATUS(0xc000002d);
enum NTSTATUS STATUS_INVALID_PORT_ATTRIBUTES = NTSTATUS(0xc000002e);
enum NTSTATUS STATUS_PORT_MESSAGE_TOO_LONG = NTSTATUS(0xc000002f);

enum : NTSTATUS
{
    STATUS_INVALID_PARAMETER_MIX = NTSTATUS(0xc0000030),
    STATUS_INVALID_QUOTA_LOWER   = NTSTATUS(0xc0000031),
}

enum NTSTATUS STATUS_DISK_CORRUPT_ERROR = NTSTATUS(0xc0000032);

enum : NTSTATUS
{
    STATUS_OBJECT_NAME_INVALID   = NTSTATUS(0xc0000033),
    STATUS_OBJECT_NAME_NOT_FOUND = NTSTATUS(0xc0000034),
    STATUS_OBJECT_NAME_COLLISION = NTSTATUS(0xc0000035),
}

enum : NTSTATUS
{
    STATUS_PORT_DO_NOT_DISTURB = NTSTATUS(0xc0000036),
    STATUS_PORT_DISCONNECTED   = NTSTATUS(0xc0000037),
}

enum NTSTATUS STATUS_DEVICE_ALREADY_ATTACHED = NTSTATUS(0xc0000038);

enum : NTSTATUS
{
    STATUS_OBJECT_PATH_INVALID    = NTSTATUS(0xc0000039),
    STATUS_OBJECT_PATH_NOT_FOUND  = NTSTATUS(0xc000003a),
    STATUS_OBJECT_PATH_SYNTAX_BAD = NTSTATUS(0xc000003b),
}

enum : NTSTATUS
{
    STATUS_DATA_OVERRUN    = NTSTATUS(0xc000003c),
    STATUS_DATA_LATE_ERROR = NTSTATUS(0xc000003d),
    STATUS_DATA_ERROR      = NTSTATUS(0xc000003e),
    STATUS_CRC_ERROR       = NTSTATUS(0xc000003f),
    STATUS_SECTION_TOO_BIG = NTSTATUS(0xc0000040),
}

enum NTSTATUS STATUS_PORT_CONNECTION_REFUSED = NTSTATUS(0xc0000041);
enum NTSTATUS STATUS_INVALID_PORT_HANDLE = NTSTATUS(0xc0000042);
enum NTSTATUS STATUS_SHARING_VIOLATION = NTSTATUS(0xc0000043);
enum NTSTATUS STATUS_QUOTA_EXCEEDED = NTSTATUS(0xc0000044);
enum NTSTATUS STATUS_INVALID_PAGE_PROTECTION = NTSTATUS(0xc0000045);
enum NTSTATUS STATUS_MUTANT_NOT_OWNED = NTSTATUS(0xc0000046);
enum NTSTATUS STATUS_SEMAPHORE_LIMIT_EXCEEDED = NTSTATUS(0xc0000047);
enum NTSTATUS STATUS_PORT_ALREADY_SET = NTSTATUS(0xc0000048);
enum NTSTATUS STATUS_SECTION_NOT_IMAGE = NTSTATUS(0xc0000049);
enum NTSTATUS STATUS_SUSPEND_COUNT_EXCEEDED = NTSTATUS(0xc000004a);
enum NTSTATUS STATUS_THREAD_IS_TERMINATING = NTSTATUS(0xc000004b);
enum NTSTATUS STATUS_BAD_WORKING_SET_LIMIT = NTSTATUS(0xc000004c);
enum NTSTATUS STATUS_INCOMPATIBLE_FILE_MAP = NTSTATUS(0xc000004d);
enum NTSTATUS STATUS_SECTION_PROTECTION = NTSTATUS(0xc000004e);
enum NTSTATUS STATUS_EAS_NOT_SUPPORTED = NTSTATUS(0xc000004f);
enum NTSTATUS STATUS_EA_TOO_LARGE = NTSTATUS(0xc0000050);
enum NTSTATUS STATUS_NONEXISTENT_EA_ENTRY = NTSTATUS(0xc0000051);
enum NTSTATUS STATUS_NO_EAS_ON_FILE = NTSTATUS(0xc0000052);
enum NTSTATUS STATUS_EA_CORRUPT_ERROR = NTSTATUS(0xc0000053);
enum NTSTATUS STATUS_FILE_LOCK_CONFLICT = NTSTATUS(0xc0000054);
enum NTSTATUS STATUS_LOCK_NOT_GRANTED = NTSTATUS(0xc0000055);
enum NTSTATUS STATUS_DELETE_PENDING = NTSTATUS(0xc0000056);
enum NTSTATUS STATUS_CTL_FILE_NOT_SUPPORTED = NTSTATUS(0xc0000057);
enum NTSTATUS STATUS_UNKNOWN_REVISION = NTSTATUS(0xc0000058);
enum NTSTATUS STATUS_REVISION_MISMATCH = NTSTATUS(0xc0000059);

enum : NTSTATUS
{
    STATUS_INVALID_OWNER         = NTSTATUS(0xc000005a),
    STATUS_INVALID_PRIMARY_GROUP = NTSTATUS(0xc000005b),
}

enum NTSTATUS STATUS_NO_IMPERSONATION_TOKEN = NTSTATUS(0xc000005c);
enum NTSTATUS STATUS_CANT_DISABLE_MANDATORY = NTSTATUS(0xc000005d);

enum : NTSTATUS
{
    STATUS_NO_LOGON_SERVERS  = NTSTATUS(0xc000005e),
    STATUS_NO_SUCH_PRIVILEGE = NTSTATUS(0xc0000060),
}

enum NTSTATUS STATUS_PRIVILEGE_NOT_HELD = NTSTATUS(0xc0000061);
enum NTSTATUS STATUS_INVALID_ACCOUNT_NAME = NTSTATUS(0xc0000062);
enum NTSTATUS STATUS_USER_EXISTS = NTSTATUS(0xc0000063);
enum NTSTATUS STATUS_GROUP_EXISTS = NTSTATUS(0xc0000065);
enum NTSTATUS STATUS_NO_SUCH_GROUP = NTSTATUS(0xc0000066);

enum : NTSTATUS
{
    STATUS_MEMBER_IN_GROUP     = NTSTATUS(0xc0000067),
    STATUS_MEMBER_NOT_IN_GROUP = NTSTATUS(0xc0000068),
}

enum : NTSTATUS
{
    STATUS_LAST_ADMIN          = NTSTATUS(0xc0000069),
    STATUS_ILL_FORMED_PASSWORD = NTSTATUS(0xc000006b),
}

enum NTSTATUS STATUS_PASSWORD_RESTRICTION = NTSTATUS(0xc000006c);

enum : NTSTATUS
{
    STATUS_INVALID_LOGON_HOURS = NTSTATUS(0xc000006f),
    STATUS_INVALID_WORKSTATION = NTSTATUS(0xc0000070),
}

enum NTSTATUS STATUS_NONE_MAPPED = NTSTATUS(0xc0000073);
enum NTSTATUS STATUS_TOO_MANY_LUIDS_REQUESTED = NTSTATUS(0xc0000074);
enum NTSTATUS STATUS_LUIDS_EXHAUSTED = NTSTATUS(0xc0000075);

enum : NTSTATUS
{
    STATUS_INVALID_SUB_AUTHORITY  = NTSTATUS(0xc0000076),
    STATUS_INVALID_ACL            = NTSTATUS(0xc0000077),
    STATUS_INVALID_SID            = NTSTATUS(0xc0000078),
    STATUS_INVALID_SECURITY_DESCR = NTSTATUS(0xc0000079),
}

enum NTSTATUS STATUS_PROCEDURE_NOT_FOUND = NTSTATUS(0xc000007a);
enum NTSTATUS STATUS_INVALID_IMAGE_FORMAT = NTSTATUS(0xc000007b);

enum : NTSTATUS
{
    STATUS_NO_TOKEN            = NTSTATUS(0xc000007c),
    STATUS_BAD_INHERITANCE_ACL = NTSTATUS(0xc000007d),
}

enum NTSTATUS STATUS_RANGE_NOT_LOCKED = NTSTATUS(0xc000007e);

enum : NTSTATUS
{
    STATUS_DISK_FULL           = NTSTATUS(0xc000007f),
    STATUS_SERVER_DISABLED     = NTSTATUS(0xc0000080),
    STATUS_SERVER_NOT_DISABLED = NTSTATUS(0xc0000081),
}

enum NTSTATUS STATUS_TOO_MANY_GUIDS_REQUESTED = NTSTATUS(0xc0000082);
enum NTSTATUS STATUS_GUIDS_EXHAUSTED = NTSTATUS(0xc0000083);
enum NTSTATUS STATUS_INVALID_ID_AUTHORITY = NTSTATUS(0xc0000084);
enum NTSTATUS STATUS_AGENTS_EXHAUSTED = NTSTATUS(0xc0000085);
enum NTSTATUS STATUS_INVALID_VOLUME_LABEL = NTSTATUS(0xc0000086);
enum NTSTATUS STATUS_SECTION_NOT_EXTENDED = NTSTATUS(0xc0000087);
enum NTSTATUS STATUS_NOT_MAPPED_DATA = NTSTATUS(0xc0000088);

enum : NTSTATUS
{
    STATUS_RESOURCE_DATA_NOT_FOUND = NTSTATUS(0xc0000089),
    STATUS_RESOURCE_TYPE_NOT_FOUND = NTSTATUS(0xc000008a),
    STATUS_RESOURCE_NAME_NOT_FOUND = NTSTATUS(0xc000008b),
}

enum NTSTATUS STATUS_ARRAY_BOUNDS_EXCEEDED = NTSTATUS(0xc000008c);

enum : NTSTATUS
{
    STATUS_FLOAT_DENORMAL_OPERAND  = NTSTATUS(0xc000008d),
    STATUS_FLOAT_DIVIDE_BY_ZERO    = NTSTATUS(0xc000008e),
    STATUS_FLOAT_INEXACT_RESULT    = NTSTATUS(0xc000008f),
    STATUS_FLOAT_INVALID_OPERATION = NTSTATUS(0xc0000090),
    STATUS_FLOAT_OVERFLOW          = NTSTATUS(0xc0000091),
    STATUS_FLOAT_STACK_CHECK       = NTSTATUS(0xc0000092),
    STATUS_FLOAT_UNDERFLOW         = NTSTATUS(0xc0000093),
}

enum : NTSTATUS
{
    STATUS_INTEGER_DIVIDE_BY_ZERO = NTSTATUS(0xc0000094),
    STATUS_INTEGER_OVERFLOW       = NTSTATUS(0xc0000095),
}

enum NTSTATUS STATUS_PRIVILEGED_INSTRUCTION = NTSTATUS(0xc0000096);
enum NTSTATUS STATUS_TOO_MANY_PAGING_FILES = NTSTATUS(0xc0000097);
enum NTSTATUS STATUS_FILE_INVALID = NTSTATUS(0xc0000098);
enum NTSTATUS STATUS_ALLOTTED_SPACE_EXCEEDED = NTSTATUS(0xc0000099);
enum NTSTATUS STATUS_INSUFFICIENT_RESOURCES = NTSTATUS(0xc000009a);
enum NTSTATUS STATUS_DFS_EXIT_PATH_FOUND = NTSTATUS(0xc000009b);

enum : NTSTATUS
{
    STATUS_DEVICE_DATA_ERROR    = NTSTATUS(0xc000009c),
    STATUS_DEVICE_NOT_CONNECTED = NTSTATUS(0xc000009d),
    STATUS_DEVICE_POWER_FAILURE = NTSTATUS(0xc000009e),
}

enum NTSTATUS STATUS_FREE_VM_NOT_AT_BASE = NTSTATUS(0xc000009f);
enum NTSTATUS STATUS_MEMORY_NOT_ALLOCATED = NTSTATUS(0xc00000a0);
enum NTSTATUS STATUS_WORKING_SET_QUOTA = NTSTATUS(0xc00000a1);
enum NTSTATUS STATUS_MEDIA_WRITE_PROTECTED = NTSTATUS(0xc00000a2);
enum NTSTATUS STATUS_DEVICE_NOT_READY = NTSTATUS(0xc00000a3);
enum NTSTATUS STATUS_INVALID_GROUP_ATTRIBUTES = NTSTATUS(0xc00000a4);
enum NTSTATUS STATUS_BAD_IMPERSONATION_LEVEL = NTSTATUS(0xc00000a5);
enum NTSTATUS STATUS_CANT_OPEN_ANONYMOUS = NTSTATUS(0xc00000a6);

enum : NTSTATUS
{
    STATUS_BAD_VALIDATION_CLASS   = NTSTATUS(0xc00000a7),
    STATUS_BAD_TOKEN_TYPE         = NTSTATUS(0xc00000a8),
    STATUS_BAD_MASTER_BOOT_RECORD = NTSTATUS(0xc00000a9),
}

enum NTSTATUS STATUS_INSTRUCTION_MISALIGNMENT = NTSTATUS(0xc00000aa);
enum NTSTATUS STATUS_INSTANCE_NOT_AVAILABLE = NTSTATUS(0xc00000ab);
enum NTSTATUS STATUS_PIPE_NOT_AVAILABLE = NTSTATUS(0xc00000ac);
enum NTSTATUS STATUS_INVALID_PIPE_STATE = NTSTATUS(0xc00000ad);

enum : NTSTATUS
{
    STATUS_PIPE_BUSY        = NTSTATUS(0xc00000ae),
    STATUS_ILLEGAL_FUNCTION = NTSTATUS(0xc00000af),
}

enum : NTSTATUS
{
    STATUS_PIPE_DISCONNECTED = NTSTATUS(0xc00000b0),
    STATUS_PIPE_CLOSING      = NTSTATUS(0xc00000b1),
    STATUS_PIPE_CONNECTED    = NTSTATUS(0xc00000b2),
    STATUS_PIPE_LISTENING    = NTSTATUS(0xc00000b3),
}

enum NTSTATUS STATUS_INVALID_READ_MODE = NTSTATUS(0xc00000b4);

enum : NTSTATUS
{
    STATUS_IO_TIMEOUT         = NTSTATUS(0xc00000b5),
    STATUS_FILE_FORCED_CLOSED = NTSTATUS(0xc00000b6),
}

enum : NTSTATUS
{
    STATUS_PROFILING_NOT_STARTED = NTSTATUS(0xc00000b7),
    STATUS_PROFILING_NOT_STOPPED = NTSTATUS(0xc00000b8),
}

enum NTSTATUS STATUS_COULD_NOT_INTERPRET = NTSTATUS(0xc00000b9);
enum NTSTATUS STATUS_FILE_IS_A_DIRECTORY = NTSTATUS(0xc00000ba);
enum NTSTATUS STATUS_NOT_SUPPORTED = NTSTATUS(0xc00000bb);
enum NTSTATUS STATUS_REMOTE_NOT_LISTENING = NTSTATUS(0xc00000bc);
enum NTSTATUS STATUS_DUPLICATE_NAME = NTSTATUS(0xc00000bd);
enum NTSTATUS STATUS_BAD_NETWORK_PATH = NTSTATUS(0xc00000be);
enum NTSTATUS STATUS_NETWORK_BUSY = NTSTATUS(0xc00000bf);
enum NTSTATUS STATUS_DEVICE_DOES_NOT_EXIST = NTSTATUS(0xc00000c0);
enum NTSTATUS STATUS_TOO_MANY_COMMANDS = NTSTATUS(0xc00000c1);
enum NTSTATUS STATUS_ADAPTER_HARDWARE_ERROR = NTSTATUS(0xc00000c2);
enum NTSTATUS STATUS_INVALID_NETWORK_RESPONSE = NTSTATUS(0xc00000c3);
enum NTSTATUS STATUS_UNEXPECTED_NETWORK_ERROR = NTSTATUS(0xc00000c4);
enum NTSTATUS STATUS_BAD_REMOTE_ADAPTER = NTSTATUS(0xc00000c5);
enum NTSTATUS STATUS_PRINT_QUEUE_FULL = NTSTATUS(0xc00000c6);
enum NTSTATUS STATUS_NO_SPOOL_SPACE = NTSTATUS(0xc00000c7);
enum NTSTATUS STATUS_PRINT_CANCELLED = NTSTATUS(0xc00000c8);

enum : NTSTATUS
{
    STATUS_NETWORK_NAME_DELETED  = NTSTATUS(0xc00000c9),
    STATUS_NETWORK_ACCESS_DENIED = NTSTATUS(0xc00000ca),
}

enum : NTSTATUS
{
    STATUS_BAD_DEVICE_TYPE  = NTSTATUS(0xc00000cb),
    STATUS_BAD_NETWORK_NAME = NTSTATUS(0xc00000cc),
}

enum : NTSTATUS
{
    STATUS_TOO_MANY_NAMES    = NTSTATUS(0xc00000cd),
    STATUS_TOO_MANY_SESSIONS = NTSTATUS(0xc00000ce),
}

enum NTSTATUS STATUS_SHARING_PAUSED = NTSTATUS(0xc00000cf);
enum NTSTATUS STATUS_REQUEST_NOT_ACCEPTED = NTSTATUS(0xc00000d0);
enum NTSTATUS STATUS_REDIRECTOR_PAUSED = NTSTATUS(0xc00000d1);
enum NTSTATUS STATUS_NET_WRITE_FAULT = NTSTATUS(0xc00000d2);
enum NTSTATUS STATUS_PROFILING_AT_LIMIT = NTSTATUS(0xc00000d3);
enum NTSTATUS STATUS_NOT_SAME_DEVICE = NTSTATUS(0xc00000d4);
enum NTSTATUS STATUS_FILE_RENAMED = NTSTATUS(0xc00000d5);
enum NTSTATUS STATUS_VIRTUAL_CIRCUIT_CLOSED = NTSTATUS(0xc00000d6);
enum NTSTATUS STATUS_NO_SECURITY_ON_OBJECT = NTSTATUS(0xc00000d7);

enum : NTSTATUS
{
    STATUS_CANT_WAIT               = NTSTATUS(0xc00000d8),
    STATUS_PIPE_EMPTY              = NTSTATUS(0xc00000d9),
    STATUS_CANT_ACCESS_DOMAIN_INFO = NTSTATUS(0xc00000da),
}

enum NTSTATUS STATUS_CANT_TERMINATE_SELF = NTSTATUS(0xc00000db);

enum : NTSTATUS
{
    STATUS_INVALID_SERVER_STATE = NTSTATUS(0xc00000dc),
    STATUS_INVALID_DOMAIN_STATE = NTSTATUS(0xc00000dd),
    STATUS_INVALID_DOMAIN_ROLE  = NTSTATUS(0xc00000de),
}

enum NTSTATUS STATUS_NO_SUCH_DOMAIN = NTSTATUS(0xc00000df);

enum : NTSTATUS
{
    STATUS_DOMAIN_EXISTS         = NTSTATUS(0xc00000e0),
    STATUS_DOMAIN_LIMIT_EXCEEDED = NTSTATUS(0xc00000e1),
}

enum NTSTATUS STATUS_OPLOCK_NOT_GRANTED = NTSTATUS(0xc00000e2);
enum NTSTATUS STATUS_INVALID_OPLOCK_PROTOCOL = NTSTATUS(0xc00000e3);

enum : NTSTATUS
{
    STATUS_INTERNAL_DB_CORRUPTION = NTSTATUS(0xc00000e4),
    STATUS_INTERNAL_ERROR         = NTSTATUS(0xc00000e5),
}

enum NTSTATUS STATUS_GENERIC_NOT_MAPPED = NTSTATUS(0xc00000e6);
enum NTSTATUS STATUS_BAD_DESCRIPTOR_FORMAT = NTSTATUS(0xc00000e7);
enum NTSTATUS STATUS_INVALID_USER_BUFFER = NTSTATUS(0xc00000e8);

enum : NTSTATUS
{
    STATUS_UNEXPECTED_IO_ERROR      = NTSTATUS(0xc00000e9),
    STATUS_UNEXPECTED_MM_CREATE_ERR = NTSTATUS(0xc00000ea),
    STATUS_UNEXPECTED_MM_MAP_ERROR  = NTSTATUS(0xc00000eb),
    STATUS_UNEXPECTED_MM_EXTEND_ERR = NTSTATUS(0xc00000ec),
}

enum NTSTATUS STATUS_NOT_LOGON_PROCESS = NTSTATUS(0xc00000ed);
enum NTSTATUS STATUS_LOGON_SESSION_EXISTS = NTSTATUS(0xc00000ee);

enum : NTSTATUS
{
    STATUS_INVALID_PARAMETER_1  = NTSTATUS(0xc00000ef),
    STATUS_INVALID_PARAMETER_2  = NTSTATUS(0xc00000f0),
    STATUS_INVALID_PARAMETER_3  = NTSTATUS(0xc00000f1),
    STATUS_INVALID_PARAMETER_4  = NTSTATUS(0xc00000f2),
    STATUS_INVALID_PARAMETER_5  = NTSTATUS(0xc00000f3),
    STATUS_INVALID_PARAMETER_6  = NTSTATUS(0xc00000f4),
    STATUS_INVALID_PARAMETER_7  = NTSTATUS(0xc00000f5),
    STATUS_INVALID_PARAMETER_8  = NTSTATUS(0xc00000f6),
    STATUS_INVALID_PARAMETER_9  = NTSTATUS(0xc00000f7),
    STATUS_INVALID_PARAMETER_10 = NTSTATUS(0xc00000f8),
    STATUS_INVALID_PARAMETER_11 = NTSTATUS(0xc00000f9),
    STATUS_INVALID_PARAMETER_12 = NTSTATUS(0xc00000fa),
}

enum : NTSTATUS
{
    STATUS_REDIRECTOR_NOT_STARTED = NTSTATUS(0xc00000fb),
    STATUS_REDIRECTOR_STARTED     = NTSTATUS(0xc00000fc),
}

enum NTSTATUS STATUS_STACK_OVERFLOW = NTSTATUS(0xc00000fd);
enum NTSTATUS STATUS_NO_SUCH_PACKAGE = NTSTATUS(0xc00000fe);
enum NTSTATUS STATUS_BAD_FUNCTION_TABLE = NTSTATUS(0xc00000ff);
enum NTSTATUS STATUS_VARIABLE_NOT_FOUND = NTSTATUS(0xc0000100);
enum NTSTATUS STATUS_DIRECTORY_NOT_EMPTY = NTSTATUS(0xc0000101);
enum NTSTATUS STATUS_FILE_CORRUPT_ERROR = NTSTATUS(0xc0000102);
enum NTSTATUS STATUS_NOT_A_DIRECTORY = NTSTATUS(0xc0000103);
enum NTSTATUS STATUS_BAD_LOGON_SESSION_STATE = NTSTATUS(0xc0000104);
enum NTSTATUS STATUS_LOGON_SESSION_COLLISION = NTSTATUS(0xc0000105);
enum NTSTATUS STATUS_NAME_TOO_LONG = NTSTATUS(0xc0000106);

enum : NTSTATUS
{
    STATUS_FILES_OPEN        = NTSTATUS(0xc0000107),
    STATUS_CONNECTION_IN_USE = NTSTATUS(0xc0000108),
}

enum NTSTATUS STATUS_MESSAGE_NOT_FOUND = NTSTATUS(0xc0000109);
enum NTSTATUS STATUS_PROCESS_IS_TERMINATING = NTSTATUS(0xc000010a);
enum NTSTATUS STATUS_INVALID_LOGON_TYPE = NTSTATUS(0xc000010b);
enum NTSTATUS STATUS_NO_GUID_TRANSLATION = NTSTATUS(0xc000010c);
enum NTSTATUS STATUS_CANNOT_IMPERSONATE = NTSTATUS(0xc000010d);
enum NTSTATUS STATUS_IMAGE_ALREADY_LOADED = NTSTATUS(0xc000010e);

enum : NTSTATUS
{
    STATUS_ABIOS_NOT_PRESENT            = NTSTATUS(0xc000010f),
    STATUS_ABIOS_LID_NOT_EXIST          = NTSTATUS(0xc0000110),
    STATUS_ABIOS_LID_ALREADY_OWNED      = NTSTATUS(0xc0000111),
    STATUS_ABIOS_NOT_LID_OWNER          = NTSTATUS(0xc0000112),
    STATUS_ABIOS_INVALID_COMMAND        = NTSTATUS(0xc0000113),
    STATUS_ABIOS_INVALID_LID            = NTSTATUS(0xc0000114),
    STATUS_ABIOS_SELECTOR_NOT_AVAILABLE = NTSTATUS(0xc0000115),
}

enum NTSTATUS STATUS_ABIOS_INVALID_SELECTOR = NTSTATUS(0xc0000116);

enum : NTSTATUS
{
    STATUS_NO_LDT                  = NTSTATUS(0xc0000117),
    STATUS_INVALID_LDT_SIZE        = NTSTATUS(0xc0000118),
    STATUS_INVALID_LDT_OFFSET      = NTSTATUS(0xc0000119),
    STATUS_INVALID_LDT_DESCRIPTOR  = NTSTATUS(0xc000011a),
    STATUS_INVALID_IMAGE_NE_FORMAT = NTSTATUS(0xc000011b),
}

enum : NTSTATUS
{
    STATUS_RXACT_INVALID_STATE  = NTSTATUS(0xc000011c),
    STATUS_RXACT_COMMIT_FAILURE = NTSTATUS(0xc000011d),
}

enum NTSTATUS STATUS_MAPPED_FILE_SIZE_ZERO = NTSTATUS(0xc000011e);
enum NTSTATUS STATUS_TOO_MANY_OPENED_FILES = NTSTATUS(0xc000011f);

enum : NTSTATUS
{
    STATUS_CANCELLED     = NTSTATUS(0xc0000120),
    STATUS_CANNOT_DELETE = NTSTATUS(0xc0000121),
}

enum NTSTATUS STATUS_INVALID_COMPUTER_NAME = NTSTATUS(0xc0000122);
enum NTSTATUS STATUS_FILE_DELETED = NTSTATUS(0xc0000123);

enum : NTSTATUS
{
    STATUS_SPECIAL_ACCOUNT = NTSTATUS(0xc0000124),
    STATUS_SPECIAL_GROUP   = NTSTATUS(0xc0000125),
    STATUS_SPECIAL_USER    = NTSTATUS(0xc0000126),
}

enum NTSTATUS STATUS_MEMBERS_PRIMARY_GROUP = NTSTATUS(0xc0000127);
enum NTSTATUS STATUS_FILE_CLOSED = NTSTATUS(0xc0000128);
enum NTSTATUS STATUS_TOO_MANY_THREADS = NTSTATUS(0xc0000129);
enum NTSTATUS STATUS_THREAD_NOT_IN_PROCESS = NTSTATUS(0xc000012a);
enum NTSTATUS STATUS_TOKEN_ALREADY_IN_USE = NTSTATUS(0xc000012b);
enum NTSTATUS STATUS_PAGEFILE_QUOTA_EXCEEDED = NTSTATUS(0xc000012c);
enum NTSTATUS STATUS_COMMITMENT_LIMIT = NTSTATUS(0xc000012d);

enum : NTSTATUS
{
    STATUS_INVALID_IMAGE_LE_FORMAT = NTSTATUS(0xc000012e),
    STATUS_INVALID_IMAGE_NOT_MZ    = NTSTATUS(0xc000012f),
    STATUS_INVALID_IMAGE_PROTECT   = NTSTATUS(0xc0000130),
    STATUS_INVALID_IMAGE_WIN_16    = NTSTATUS(0xc0000131),
}

enum NTSTATUS STATUS_LOGON_SERVER_CONFLICT = NTSTATUS(0xc0000132);
enum NTSTATUS STATUS_TIME_DIFFERENCE_AT_DC = NTSTATUS(0xc0000133);
enum NTSTATUS STATUS_SYNCHRONIZATION_REQUIRED = NTSTATUS(0xc0000134);
enum NTSTATUS STATUS_DLL_NOT_FOUND = NTSTATUS(0xc0000135);
enum NTSTATUS STATUS_OPEN_FAILED = NTSTATUS(0xc0000136);
enum NTSTATUS STATUS_IO_PRIVILEGE_FAILED = NTSTATUS(0xc0000137);
enum NTSTATUS STATUS_ORDINAL_NOT_FOUND = NTSTATUS(0xc0000138);
enum NTSTATUS STATUS_ENTRYPOINT_NOT_FOUND = NTSTATUS(0xc0000139);
enum NTSTATUS STATUS_CONTROL_C_EXIT = NTSTATUS(0xc000013a);
enum NTSTATUS STATUS_LOCAL_DISCONNECT = NTSTATUS(0xc000013b);

enum : NTSTATUS
{
    STATUS_REMOTE_DISCONNECT = NTSTATUS(0xc000013c),
    STATUS_REMOTE_RESOURCES  = NTSTATUS(0xc000013d),
}

enum : NTSTATUS
{
    STATUS_LINK_FAILED  = NTSTATUS(0xc000013e),
    STATUS_LINK_TIMEOUT = NTSTATUS(0xc000013f),
}

enum : NTSTATUS
{
    STATUS_INVALID_CONNECTION = NTSTATUS(0xc0000140),
    STATUS_INVALID_ADDRESS    = NTSTATUS(0xc0000141),
}

enum NTSTATUS STATUS_DLL_INIT_FAILED = NTSTATUS(0xc0000142);
enum NTSTATUS STATUS_MISSING_SYSTEMFILE = NTSTATUS(0xc0000143);
enum NTSTATUS STATUS_UNHANDLED_EXCEPTION = NTSTATUS(0xc0000144);
enum NTSTATUS STATUS_APP_INIT_FAILURE = NTSTATUS(0xc0000145);
enum NTSTATUS STATUS_PAGEFILE_CREATE_FAILED = NTSTATUS(0xc0000146);
enum NTSTATUS STATUS_NO_PAGEFILE = NTSTATUS(0xc0000147);
enum NTSTATUS STATUS_INVALID_LEVEL = NTSTATUS(0xc0000148);
enum NTSTATUS STATUS_WRONG_PASSWORD_CORE = NTSTATUS(0xc0000149);
enum NTSTATUS STATUS_ILLEGAL_FLOAT_CONTEXT = NTSTATUS(0xc000014a);
enum NTSTATUS STATUS_PIPE_BROKEN = NTSTATUS(0xc000014b);

enum : NTSTATUS
{
    STATUS_REGISTRY_CORRUPT   = NTSTATUS(0xc000014c),
    STATUS_REGISTRY_IO_FAILED = NTSTATUS(0xc000014d),
}

enum NTSTATUS STATUS_NO_EVENT_PAIR = NTSTATUS(0xc000014e);
enum NTSTATUS STATUS_UNRECOGNIZED_VOLUME = NTSTATUS(0xc000014f);
enum NTSTATUS STATUS_SERIAL_NO_DEVICE_INITED = NTSTATUS(0xc0000150);
enum NTSTATUS STATUS_NO_SUCH_ALIAS = NTSTATUS(0xc0000151);

enum : NTSTATUS
{
    STATUS_MEMBER_NOT_IN_ALIAS = NTSTATUS(0xc0000152),
    STATUS_MEMBER_IN_ALIAS     = NTSTATUS(0xc0000153),
}

enum NTSTATUS STATUS_ALIAS_EXISTS = NTSTATUS(0xc0000154);
enum NTSTATUS STATUS_LOGON_NOT_GRANTED = NTSTATUS(0xc0000155);
enum NTSTATUS STATUS_TOO_MANY_SECRETS = NTSTATUS(0xc0000156);
enum NTSTATUS STATUS_SECRET_TOO_LONG = NTSTATUS(0xc0000157);
enum NTSTATUS STATUS_INTERNAL_DB_ERROR = NTSTATUS(0xc0000158);
enum NTSTATUS STATUS_FULLSCREEN_MODE = NTSTATUS(0xc0000159);
enum NTSTATUS STATUS_TOO_MANY_CONTEXT_IDS = NTSTATUS(0xc000015a);
enum NTSTATUS STATUS_NOT_REGISTRY_FILE = NTSTATUS(0xc000015c);
enum NTSTATUS STATUS_NT_CROSS_ENCRYPTION_REQUIRED = NTSTATUS(0xc000015d);
enum NTSTATUS STATUS_DOMAIN_CTRLR_CONFIG_ERROR = NTSTATUS(0xc000015e);
enum NTSTATUS STATUS_FT_MISSING_MEMBER = NTSTATUS(0xc000015f);
enum NTSTATUS STATUS_ILL_FORMED_SERVICE_ENTRY = NTSTATUS(0xc0000160);
enum NTSTATUS STATUS_ILLEGAL_CHARACTER = NTSTATUS(0xc0000161);
enum NTSTATUS STATUS_UNMAPPABLE_CHARACTER = NTSTATUS(0xc0000162);
enum NTSTATUS STATUS_UNDEFINED_CHARACTER = NTSTATUS(0xc0000163);

enum : NTSTATUS
{
    STATUS_FLOPPY_VOLUME            = NTSTATUS(0xc0000164),
    STATUS_FLOPPY_ID_MARK_NOT_FOUND = NTSTATUS(0xc0000165),
    STATUS_FLOPPY_WRONG_CYLINDER    = NTSTATUS(0xc0000166),
    STATUS_FLOPPY_UNKNOWN_ERROR     = NTSTATUS(0xc0000167),
    STATUS_FLOPPY_BAD_REGISTERS     = NTSTATUS(0xc0000168),
}

enum NTSTATUS STATUS_DISK_RECALIBRATE_FAILED = NTSTATUS(0xc0000169);

enum : NTSTATUS
{
    STATUS_DISK_OPERATION_FAILED = NTSTATUS(0xc000016a),
    STATUS_DISK_RESET_FAILED     = NTSTATUS(0xc000016b),
}

enum NTSTATUS STATUS_SHARED_IRQ_BUSY = NTSTATUS(0xc000016c);
enum NTSTATUS STATUS_FT_ORPHANING = NTSTATUS(0xc000016d);
enum NTSTATUS STATUS_BIOS_FAILED_TO_CONNECT_INTERRUPT = NTSTATUS(0xc000016e);
enum NTSTATUS STATUS_PARTITION_FAILURE = NTSTATUS(0xc0000172);
enum NTSTATUS STATUS_INVALID_BLOCK_LENGTH = NTSTATUS(0xc0000173);
enum NTSTATUS STATUS_DEVICE_NOT_PARTITIONED = NTSTATUS(0xc0000174);

enum : NTSTATUS
{
    STATUS_UNABLE_TO_LOCK_MEDIA   = NTSTATUS(0xc0000175),
    STATUS_UNABLE_TO_UNLOAD_MEDIA = NTSTATUS(0xc0000176),
}

enum NTSTATUS STATUS_EOM_OVERFLOW = NTSTATUS(0xc0000177);

enum : NTSTATUS
{
    STATUS_NO_MEDIA       = NTSTATUS(0xc0000178),
    STATUS_NO_SUCH_MEMBER = NTSTATUS(0xc000017a),
}

enum NTSTATUS STATUS_INVALID_MEMBER = NTSTATUS(0xc000017b);
enum NTSTATUS STATUS_KEY_DELETED = NTSTATUS(0xc000017c);
enum NTSTATUS STATUS_NO_LOG_SPACE = NTSTATUS(0xc000017d);
enum NTSTATUS STATUS_TOO_MANY_SIDS = NTSTATUS(0xc000017e);
enum NTSTATUS STATUS_LM_CROSS_ENCRYPTION_REQUIRED = NTSTATUS(0xc000017f);
enum NTSTATUS STATUS_KEY_HAS_CHILDREN = NTSTATUS(0xc0000180);
enum NTSTATUS STATUS_CHILD_MUST_BE_VOLATILE = NTSTATUS(0xc0000181);
enum NTSTATUS STATUS_DEVICE_CONFIGURATION_ERROR = NTSTATUS(0xc0000182);
enum NTSTATUS STATUS_DRIVER_INTERNAL_ERROR = NTSTATUS(0xc0000183);
enum NTSTATUS STATUS_INVALID_DEVICE_STATE = NTSTATUS(0xc0000184);
enum NTSTATUS STATUS_IO_DEVICE_ERROR = NTSTATUS(0xc0000185);
enum NTSTATUS STATUS_DEVICE_PROTOCOL_ERROR = NTSTATUS(0xc0000186);
enum NTSTATUS STATUS_BACKUP_CONTROLLER = NTSTATUS(0xc0000187);
enum NTSTATUS STATUS_LOG_FILE_FULL = NTSTATUS(0xc0000188);

enum : NTSTATUS
{
    STATUS_TOO_LATE             = NTSTATUS(0xc0000189),
    STATUS_NO_TRUST_LSA_SECRET  = NTSTATUS(0xc000018a),
    STATUS_NO_TRUST_SAM_ACCOUNT = NTSTATUS(0xc000018b),
}

enum : NTSTATUS
{
    STATUS_TRUSTED_DOMAIN_FAILURE       = NTSTATUS(0xc000018c),
    STATUS_TRUSTED_RELATIONSHIP_FAILURE = NTSTATUS(0xc000018d),
}

enum : NTSTATUS
{
    STATUS_EVENTLOG_FILE_CORRUPT = NTSTATUS(0xc000018e),
    STATUS_EVENTLOG_CANT_START   = NTSTATUS(0xc000018f),
}

enum NTSTATUS STATUS_TRUST_FAILURE = NTSTATUS(0xc0000190);
enum NTSTATUS STATUS_MUTANT_LIMIT_EXCEEDED = NTSTATUS(0xc0000191);
enum NTSTATUS STATUS_NETLOGON_NOT_STARTED = NTSTATUS(0xc0000192);
enum NTSTATUS STATUS_POSSIBLE_DEADLOCK = NTSTATUS(0xc0000194);
enum NTSTATUS STATUS_NETWORK_CREDENTIAL_CONFLICT = NTSTATUS(0xc0000195);
enum NTSTATUS STATUS_REMOTE_SESSION_LIMIT = NTSTATUS(0xc0000196);
enum NTSTATUS STATUS_EVENTLOG_FILE_CHANGED = NTSTATUS(0xc0000197);
enum NTSTATUS STATUS_NOLOGON_INTERDOMAIN_TRUST_ACCOUNT = NTSTATUS(0xc0000198);
enum NTSTATUS STATUS_NOLOGON_WORKSTATION_TRUST_ACCOUNT = NTSTATUS(0xc0000199);
enum NTSTATUS STATUS_NOLOGON_SERVER_TRUST_ACCOUNT = NTSTATUS(0xc000019a);
enum NTSTATUS STATUS_DOMAIN_TRUST_INCONSISTENT = NTSTATUS(0xc000019b);
enum NTSTATUS STATUS_FS_DRIVER_REQUIRED = NTSTATUS(0xc000019c);
enum NTSTATUS STATUS_IMAGE_ALREADY_LOADED_AS_DLL = NTSTATUS(0xc000019d);
enum NTSTATUS STATUS_INCOMPATIBLE_WITH_GLOBAL_SHORT_NAME_REGISTRY_SETTING = NTSTATUS(0xc000019e);
enum NTSTATUS STATUS_SHORT_NAMES_NOT_ENABLED_ON_VOLUME = NTSTATUS(0xc000019f);
enum NTSTATUS STATUS_SECURITY_STREAM_IS_INCONSISTENT = NTSTATUS(0xc00001a0);

enum : NTSTATUS
{
    STATUS_INVALID_LOCK_RANGE    = NTSTATUS(0xc00001a1),
    STATUS_INVALID_ACE_CONDITION = NTSTATUS(0xc00001a2),
}

enum NTSTATUS STATUS_IMAGE_SUBSYSTEM_NOT_PRESENT = NTSTATUS(0xc00001a3);
enum NTSTATUS STATUS_NOTIFICATION_GUID_ALREADY_DEFINED = NTSTATUS(0xc00001a4);
enum NTSTATUS STATUS_INVALID_EXCEPTION_HANDLER = NTSTATUS(0xc00001a5);
enum NTSTATUS STATUS_DUPLICATE_PRIVILEGES = NTSTATUS(0xc00001a6);
enum NTSTATUS STATUS_NOT_ALLOWED_ON_SYSTEM_FILE = NTSTATUS(0xc00001a7);
enum NTSTATUS STATUS_REPAIR_NEEDED = NTSTATUS(0xc00001a8);
enum NTSTATUS STATUS_QUOTA_NOT_ENABLED = NTSTATUS(0xc00001a9);
enum NTSTATUS STATUS_NO_APPLICATION_PACKAGE = NTSTATUS(0xc00001aa);
enum NTSTATUS STATUS_FILE_METADATA_OPTIMIZATION_IN_PROGRESS = NTSTATUS(0xc00001ab);
enum NTSTATUS STATUS_NOT_SAME_OBJECT = NTSTATUS(0xc00001ac);
enum NTSTATUS STATUS_FATAL_MEMORY_EXHAUSTION = NTSTATUS(0xc00001ad);
enum NTSTATUS STATUS_ERROR_PROCESS_NOT_IN_JOB = NTSTATUS(0xc00001ae);
enum NTSTATUS STATUS_CPU_SET_INVALID = NTSTATUS(0xc00001af);
enum NTSTATUS STATUS_IO_DEVICE_INVALID_DATA = NTSTATUS(0xc00001b0);
enum NTSTATUS STATUS_IO_UNALIGNED_WRITE = NTSTATUS(0xc00001b1);
enum NTSTATUS STATUS_CONTROL_STACK_VIOLATION = NTSTATUS(0xc00001b2);
enum NTSTATUS STATUS_WEAK_WHFBKEY_BLOCKED = NTSTATUS(0xc00001b3);
enum NTSTATUS STATUS_SERVER_TRANSPORT_CONFLICT = NTSTATUS(0xc00001b4);
enum NTSTATUS STATUS_CERTIFICATE_VALIDATION_PREFERENCE_CONFLICT = NTSTATUS(0xc00001b5);
enum NTSTATUS STATUS_DEVICE_RESET_REQUIRED = NTSTATUS(0x800001b6);
enum NTSTATUS STATUS_NETWORK_OPEN_RESTRICTION = NTSTATUS(0xc0000201);
enum NTSTATUS STATUS_NO_USER_SESSION_KEY = NTSTATUS(0xc0000202);
enum NTSTATUS STATUS_USER_SESSION_DELETED = NTSTATUS(0xc0000203);
enum NTSTATUS STATUS_RESOURCE_LANG_NOT_FOUND = NTSTATUS(0xc0000204);
enum NTSTATUS STATUS_INSUFF_SERVER_RESOURCES = NTSTATUS(0xc0000205);

enum : NTSTATUS
{
    STATUS_INVALID_BUFFER_SIZE       = NTSTATUS(0xc0000206),
    STATUS_INVALID_ADDRESS_COMPONENT = NTSTATUS(0xc0000207),
    STATUS_INVALID_ADDRESS_WILDCARD  = NTSTATUS(0xc0000208),
}

enum NTSTATUS STATUS_TOO_MANY_ADDRESSES = NTSTATUS(0xc0000209);

enum : NTSTATUS
{
    STATUS_ADDRESS_ALREADY_EXISTS = NTSTATUS(0xc000020a),
    STATUS_ADDRESS_CLOSED         = NTSTATUS(0xc000020b),
}

enum : NTSTATUS
{
    STATUS_CONNECTION_DISCONNECTED = NTSTATUS(0xc000020c),
    STATUS_CONNECTION_RESET        = NTSTATUS(0xc000020d),
}

enum NTSTATUS STATUS_TOO_MANY_NODES = NTSTATUS(0xc000020e);

enum : NTSTATUS
{
    STATUS_TRANSACTION_ABORTED      = NTSTATUS(0xc000020f),
    STATUS_TRANSACTION_TIMED_OUT    = NTSTATUS(0xc0000210),
    STATUS_TRANSACTION_NO_RELEASE   = NTSTATUS(0xc0000211),
    STATUS_TRANSACTION_NO_MATCH     = NTSTATUS(0xc0000212),
    STATUS_TRANSACTION_RESPONDED    = NTSTATUS(0xc0000213),
    STATUS_TRANSACTION_INVALID_ID   = NTSTATUS(0xc0000214),
    STATUS_TRANSACTION_INVALID_TYPE = NTSTATUS(0xc0000215),
}

enum : NTSTATUS
{
    STATUS_NOT_SERVER_SESSION = NTSTATUS(0xc0000216),
    STATUS_NOT_CLIENT_SESSION = NTSTATUS(0xc0000217),
}

enum NTSTATUS STATUS_CANNOT_LOAD_REGISTRY_FILE = NTSTATUS(0xc0000218);
enum NTSTATUS STATUS_DEBUG_ATTACH_FAILED = NTSTATUS(0xc0000219);
enum NTSTATUS STATUS_SYSTEM_PROCESS_TERMINATED = NTSTATUS(0xc000021a);
enum NTSTATUS STATUS_DATA_NOT_ACCEPTED = NTSTATUS(0xc000021b);
enum NTSTATUS STATUS_NO_BROWSER_SERVERS_FOUND = NTSTATUS(0xc000021c);
enum NTSTATUS STATUS_VDM_HARD_ERROR = NTSTATUS(0xc000021d);
enum NTSTATUS STATUS_DRIVER_CANCEL_TIMEOUT = NTSTATUS(0xc000021e);
enum NTSTATUS STATUS_REPLY_MESSAGE_MISMATCH = NTSTATUS(0xc000021f);
enum NTSTATUS STATUS_MAPPED_ALIGNMENT = NTSTATUS(0xc0000220);
enum NTSTATUS STATUS_IMAGE_CHECKSUM_MISMATCH = NTSTATUS(0xc0000221);
enum NTSTATUS STATUS_LOST_WRITEBEHIND_DATA = NTSTATUS(0xc0000222);
enum NTSTATUS STATUS_CLIENT_SERVER_PARAMETERS_INVALID = NTSTATUS(0xc0000223);

enum : NTSTATUS
{
    STATUS_NOT_FOUND       = NTSTATUS(0xc0000225),
    STATUS_NOT_TINY_STREAM = NTSTATUS(0xc0000226),
}

enum NTSTATUS STATUS_RECOVERY_FAILURE = NTSTATUS(0xc0000227);
enum NTSTATUS STATUS_STACK_OVERFLOW_READ = NTSTATUS(0xc0000228);

enum : NTSTATUS
{
    STATUS_FAIL_CHECK         = NTSTATUS(0xc0000229),
    STATUS_DUPLICATE_OBJECTID = NTSTATUS(0xc000022a),
}

enum NTSTATUS STATUS_OBJECTID_EXISTS = NTSTATUS(0xc000022b);
enum NTSTATUS STATUS_CONVERT_TO_LARGE = NTSTATUS(0xc000022c);

enum : NTSTATUS
{
    STATUS_RETRY              = NTSTATUS(0xc000022d),
    STATUS_FOUND_OUT_OF_SCOPE = NTSTATUS(0xc000022e),
}

enum NTSTATUS STATUS_ALLOCATE_BUCKET = NTSTATUS(0xc000022f);
enum NTSTATUS STATUS_PROPSET_NOT_FOUND = NTSTATUS(0xc0000230);
enum NTSTATUS STATUS_MARSHALL_OVERFLOW = NTSTATUS(0xc0000231);
enum NTSTATUS STATUS_INVALID_VARIANT = NTSTATUS(0xc0000232);
enum NTSTATUS STATUS_DOMAIN_CONTROLLER_NOT_FOUND = NTSTATUS(0xc0000233);
enum NTSTATUS STATUS_HANDLE_NOT_CLOSABLE = NTSTATUS(0xc0000235);
enum NTSTATUS STATUS_CONNECTION_REFUSED = NTSTATUS(0xc0000236);
enum NTSTATUS STATUS_GRACEFUL_DISCONNECT = NTSTATUS(0xc0000237);

enum : NTSTATUS
{
    STATUS_ADDRESS_ALREADY_ASSOCIATED = NTSTATUS(0xc0000238),
    STATUS_ADDRESS_NOT_ASSOCIATED     = NTSTATUS(0xc0000239),
}

enum : NTSTATUS
{
    STATUS_CONNECTION_INVALID = NTSTATUS(0xc000023a),
    STATUS_CONNECTION_ACTIVE  = NTSTATUS(0xc000023b),
}

enum NTSTATUS STATUS_NETWORK_UNREACHABLE = NTSTATUS(0xc000023c);
enum NTSTATUS STATUS_HOST_UNREACHABLE = NTSTATUS(0xc000023d);
enum NTSTATUS STATUS_PROTOCOL_UNREACHABLE = NTSTATUS(0xc000023e);
enum NTSTATUS STATUS_PORT_UNREACHABLE = NTSTATUS(0xc000023f);
enum NTSTATUS STATUS_REQUEST_ABORTED = NTSTATUS(0xc0000240);
enum NTSTATUS STATUS_CONNECTION_ABORTED = NTSTATUS(0xc0000241);
enum NTSTATUS STATUS_BAD_COMPRESSION_BUFFER = NTSTATUS(0xc0000242);
enum NTSTATUS STATUS_USER_MAPPED_FILE = NTSTATUS(0xc0000243);
enum NTSTATUS STATUS_AUDIT_FAILED = NTSTATUS(0xc0000244);
enum NTSTATUS STATUS_TIMER_RESOLUTION_NOT_SET = NTSTATUS(0xc0000245);
enum NTSTATUS STATUS_CONNECTION_COUNT_LIMIT = NTSTATUS(0xc0000246);

enum : NTSTATUS
{
    STATUS_LOGIN_TIME_RESTRICTION  = NTSTATUS(0xc0000247),
    STATUS_LOGIN_WKSTA_RESTRICTION = NTSTATUS(0xc0000248),
}

enum NTSTATUS STATUS_IMAGE_MP_UP_MISMATCH = NTSTATUS(0xc0000249);
enum NTSTATUS STATUS_INSUFFICIENT_LOGON_INFO = NTSTATUS(0xc0000250);

enum : NTSTATUS
{
    STATUS_BAD_DLL_ENTRYPOINT     = NTSTATUS(0xc0000251),
    STATUS_BAD_SERVICE_ENTRYPOINT = NTSTATUS(0xc0000252),
}

enum NTSTATUS STATUS_LPC_REPLY_LOST = NTSTATUS(0xc0000253);

enum : NTSTATUS
{
    STATUS_IP_ADDRESS_CONFLICT1 = NTSTATUS(0xc0000254),
    STATUS_IP_ADDRESS_CONFLICT2 = NTSTATUS(0xc0000255),
}

enum NTSTATUS STATUS_REGISTRY_QUOTA_LIMIT = NTSTATUS(0xc0000256);
enum NTSTATUS STATUS_PATH_NOT_COVERED = NTSTATUS(0xc0000257);
enum NTSTATUS STATUS_NO_CALLBACK_ACTIVE = NTSTATUS(0xc0000258);
enum NTSTATUS STATUS_LICENSE_QUOTA_EXCEEDED = NTSTATUS(0xc0000259);

enum : NTSTATUS
{
    STATUS_PWD_TOO_SHORT        = NTSTATUS(0xc000025a),
    STATUS_PWD_TOO_RECENT       = NTSTATUS(0xc000025b),
    STATUS_PWD_HISTORY_CONFLICT = NTSTATUS(0xc000025c),
}

enum NTSTATUS STATUS_PLUGPLAY_NO_DEVICE = NTSTATUS(0xc000025e);
enum NTSTATUS STATUS_UNSUPPORTED_COMPRESSION = NTSTATUS(0xc000025f);

enum : NTSTATUS
{
    STATUS_INVALID_HW_PROFILE           = NTSTATUS(0xc0000260),
    STATUS_INVALID_PLUGPLAY_DEVICE_PATH = NTSTATUS(0xc0000261),
}

enum : NTSTATUS
{
    STATUS_DRIVER_ORDINAL_NOT_FOUND    = NTSTATUS(0xc0000262),
    STATUS_DRIVER_ENTRYPOINT_NOT_FOUND = NTSTATUS(0xc0000263),
}

enum NTSTATUS STATUS_RESOURCE_NOT_OWNED = NTSTATUS(0xc0000264);
enum NTSTATUS STATUS_TOO_MANY_LINKS = NTSTATUS(0xc0000265);
enum NTSTATUS STATUS_QUOTA_LIST_INCONSISTENT = NTSTATUS(0xc0000266);
enum NTSTATUS STATUS_FILE_IS_OFFLINE = NTSTATUS(0xc0000267);
enum NTSTATUS STATUS_EVALUATION_EXPIRATION = NTSTATUS(0xc0000268);
enum NTSTATUS STATUS_ILLEGAL_DLL_RELOCATION = NTSTATUS(0xc0000269);
enum NTSTATUS STATUS_LICENSE_VIOLATION = NTSTATUS(0xc000026a);
enum NTSTATUS STATUS_DLL_INIT_FAILED_LOGOFF = NTSTATUS(0xc000026b);
enum NTSTATUS STATUS_DRIVER_UNABLE_TO_LOAD = NTSTATUS(0xc000026c);
enum NTSTATUS STATUS_DFS_UNAVAILABLE = NTSTATUS(0xc000026d);
enum NTSTATUS STATUS_VOLUME_DISMOUNTED = NTSTATUS(0xc000026e);

enum : NTSTATUS
{
    STATUS_WX86_INTERNAL_ERROR    = NTSTATUS(0xc000026f),
    STATUS_WX86_FLOAT_STACK_CHECK = NTSTATUS(0xc0000270),
}

enum NTSTATUS STATUS_VALIDATE_CONTINUE = NTSTATUS(0xc0000271);

enum : NTSTATUS
{
    STATUS_NO_MATCH            = NTSTATUS(0xc0000272),
    STATUS_NO_MORE_MATCHES     = NTSTATUS(0xc0000273),
    STATUS_NOT_A_REPARSE_POINT = NTSTATUS(0xc0000275),
}

enum : NTSTATUS
{
    STATUS_IO_REPARSE_TAG_INVALID     = NTSTATUS(0xc0000276),
    STATUS_IO_REPARSE_TAG_MISMATCH    = NTSTATUS(0xc0000277),
    STATUS_IO_REPARSE_DATA_INVALID    = NTSTATUS(0xc0000278),
    STATUS_IO_REPARSE_TAG_NOT_HANDLED = NTSTATUS(0xc0000279),
}

enum NTSTATUS STATUS_PWD_TOO_LONG = NTSTATUS(0xc000027a);
enum NTSTATUS STATUS_STOWED_EXCEPTION = NTSTATUS(0xc000027b);
enum NTSTATUS STATUS_CONTEXT_STOWED_EXCEPTION = NTSTATUS(0xc000027c);
enum NTSTATUS STATUS_REPARSE_POINT_NOT_RESOLVED = NTSTATUS(0xc0000280);
enum NTSTATUS STATUS_DIRECTORY_IS_A_REPARSE_POINT = NTSTATUS(0xc0000281);
enum NTSTATUS STATUS_RANGE_LIST_CONFLICT = NTSTATUS(0xc0000282);
enum NTSTATUS STATUS_SOURCE_ELEMENT_EMPTY = NTSTATUS(0xc0000283);
enum NTSTATUS STATUS_DESTINATION_ELEMENT_FULL = NTSTATUS(0xc0000284);
enum NTSTATUS STATUS_ILLEGAL_ELEMENT_ADDRESS = NTSTATUS(0xc0000285);
enum NTSTATUS STATUS_MAGAZINE_NOT_PRESENT = NTSTATUS(0xc0000286);
enum NTSTATUS STATUS_REINITIALIZATION_NEEDED = NTSTATUS(0xc0000287);

enum : NTSTATUS
{
    STATUS_DEVICE_REQUIRES_CLEANING = NTSTATUS(0x80000288),
    STATUS_DEVICE_DOOR_OPEN         = NTSTATUS(0x80000289),
}

enum NTSTATUS STATUS_ENCRYPTION_FAILED = NTSTATUS(0xc000028a);
enum NTSTATUS STATUS_DECRYPTION_FAILED = NTSTATUS(0xc000028b);
enum NTSTATUS STATUS_RANGE_NOT_FOUND = NTSTATUS(0xc000028c);
enum NTSTATUS STATUS_NO_RECOVERY_POLICY = NTSTATUS(0xc000028d);

enum : NTSTATUS
{
    STATUS_NO_EFS       = NTSTATUS(0xc000028e),
    STATUS_WRONG_EFS    = NTSTATUS(0xc000028f),
    STATUS_NO_USER_KEYS = NTSTATUS(0xc0000290),
}

enum NTSTATUS STATUS_FILE_NOT_ENCRYPTED = NTSTATUS(0xc0000291);
enum NTSTATUS STATUS_NOT_EXPORT_FORMAT = NTSTATUS(0xc0000292);
enum NTSTATUS STATUS_FILE_ENCRYPTED = NTSTATUS(0xc0000293);

enum : NTSTATUS
{
    STATUS_WAKE_SYSTEM            = NTSTATUS(0x40000294),
    STATUS_WMI_GUID_NOT_FOUND     = NTSTATUS(0xc0000295),
    STATUS_WMI_INSTANCE_NOT_FOUND = NTSTATUS(0xc0000296),
    STATUS_WMI_ITEMID_NOT_FOUND   = NTSTATUS(0xc0000297),
    STATUS_WMI_TRY_AGAIN          = NTSTATUS(0xc0000298),
}

enum NTSTATUS STATUS_SHARED_POLICY = NTSTATUS(0xc0000299);

enum : NTSTATUS
{
    STATUS_POLICY_OBJECT_NOT_FOUND = NTSTATUS(0xc000029a),
    STATUS_POLICY_ONLY_IN_DS       = NTSTATUS(0xc000029b),
}

enum NTSTATUS STATUS_VOLUME_NOT_UPGRADED = NTSTATUS(0xc000029c);

enum : NTSTATUS
{
    STATUS_REMOTE_STORAGE_NOT_ACTIVE  = NTSTATUS(0xc000029d),
    STATUS_REMOTE_STORAGE_MEDIA_ERROR = NTSTATUS(0xc000029e),
}

enum NTSTATUS STATUS_NO_TRACKING_SERVICE = NTSTATUS(0xc000029f);
enum NTSTATUS STATUS_SERVER_SID_MISMATCH = NTSTATUS(0xc00002a0);
enum NTSTATUS STATUS_DS_NO_ATTRIBUTE_OR_VALUE = NTSTATUS(0xc00002a1);
enum NTSTATUS STATUS_DS_INVALID_ATTRIBUTE_SYNTAX = NTSTATUS(0xc00002a2);

enum : NTSTATUS
{
    STATUS_DS_ATTRIBUTE_TYPE_UNDEFINED  = NTSTATUS(0xc00002a3),
    STATUS_DS_ATTRIBUTE_OR_VALUE_EXISTS = NTSTATUS(0xc00002a4),
}

enum : NTSTATUS
{
    STATUS_DS_BUSY                 = NTSTATUS(0xc00002a5),
    STATUS_DS_UNAVAILABLE          = NTSTATUS(0xc00002a6),
    STATUS_DS_NO_RIDS_ALLOCATED    = NTSTATUS(0xc00002a7),
    STATUS_DS_NO_MORE_RIDS         = NTSTATUS(0xc00002a8),
    STATUS_DS_INCORRECT_ROLE_OWNER = NTSTATUS(0xc00002a9),
}

enum NTSTATUS STATUS_DS_RIDMGR_INIT_ERROR = NTSTATUS(0xc00002aa);
enum NTSTATUS STATUS_DS_OBJ_CLASS_VIOLATION = NTSTATUS(0xc00002ab);

enum : NTSTATUS
{
    STATUS_DS_CANT_ON_NON_LEAF   = NTSTATUS(0xc00002ac),
    STATUS_DS_CANT_ON_RDN        = NTSTATUS(0xc00002ad),
    STATUS_DS_CANT_MOD_OBJ_CLASS = NTSTATUS(0xc00002ae),
}

enum NTSTATUS STATUS_DS_CROSS_DOM_MOVE_FAILED = NTSTATUS(0xc00002af);
enum NTSTATUS STATUS_DS_GC_NOT_AVAILABLE = NTSTATUS(0xc00002b0);
enum NTSTATUS STATUS_DIRECTORY_SERVICE_REQUIRED = NTSTATUS(0xc00002b1);
enum NTSTATUS STATUS_REPARSE_ATTRIBUTE_CONFLICT = NTSTATUS(0xc00002b2);
enum NTSTATUS STATUS_CANT_ENABLE_DENY_ONLY = NTSTATUS(0xc00002b3);

enum : NTSTATUS
{
    STATUS_FLOAT_MULTIPLE_FAULTS = NTSTATUS(0xc00002b4),
    STATUS_FLOAT_MULTIPLE_TRAPS  = NTSTATUS(0xc00002b5),
}

enum NTSTATUS STATUS_DEVICE_REMOVED = NTSTATUS(0xc00002b6);

enum : NTSTATUS
{
    STATUS_JOURNAL_DELETE_IN_PROGRESS = NTSTATUS(0xc00002b7),
    STATUS_JOURNAL_NOT_ACTIVE         = NTSTATUS(0xc00002b8),
}

enum NTSTATUS STATUS_NOINTERFACE = NTSTATUS(0xc00002b9);
enum NTSTATUS STATUS_DS_RIDMGR_DISABLED = NTSTATUS(0xc00002ba);
enum NTSTATUS STATUS_DS_ADMIN_LIMIT_EXCEEDED = NTSTATUS(0xc00002c1);
enum NTSTATUS STATUS_DRIVER_FAILED_SLEEP = NTSTATUS(0xc00002c2);
enum NTSTATUS STATUS_MUTUAL_AUTHENTICATION_FAILED = NTSTATUS(0xc00002c3);
enum NTSTATUS STATUS_CORRUPT_SYSTEM_FILE = NTSTATUS(0xc00002c4);
enum NTSTATUS STATUS_DATATYPE_MISALIGNMENT_ERROR = NTSTATUS(0xc00002c5);

enum : NTSTATUS
{
    STATUS_WMI_READ_ONLY   = NTSTATUS(0xc00002c6),
    STATUS_WMI_SET_FAILURE = NTSTATUS(0xc00002c7),
}

enum NTSTATUS STATUS_COMMITMENT_MINIMUM = NTSTATUS(0xc00002c8);
enum NTSTATUS STATUS_REG_NAT_CONSUMPTION = NTSTATUS(0xc00002c9);
enum NTSTATUS STATUS_TRANSPORT_FULL = NTSTATUS(0xc00002ca);
enum NTSTATUS STATUS_DS_SAM_INIT_FAILURE = NTSTATUS(0xc00002cb);
enum NTSTATUS STATUS_ONLY_IF_CONNECTED = NTSTATUS(0xc00002cc);
enum NTSTATUS STATUS_DS_SENSITIVE_GROUP_VIOLATION = NTSTATUS(0xc00002cd);
enum NTSTATUS STATUS_PNP_RESTART_ENUMERATION = NTSTATUS(0xc00002ce);
enum NTSTATUS STATUS_JOURNAL_ENTRY_DELETED = NTSTATUS(0xc00002cf);
enum NTSTATUS STATUS_DS_CANT_MOD_PRIMARYGROUPID = NTSTATUS(0xc00002d0);
enum NTSTATUS STATUS_SYSTEM_IMAGE_BAD_SIGNATURE = NTSTATUS(0xc00002d1);
enum NTSTATUS STATUS_PNP_REBOOT_REQUIRED = NTSTATUS(0xc00002d2);
enum NTSTATUS STATUS_POWER_STATE_INVALID = NTSTATUS(0xc00002d3);
enum NTSTATUS STATUS_DS_INVALID_GROUP_TYPE = NTSTATUS(0xc00002d4);

enum : NTSTATUS
{
    STATUS_DS_NO_NEST_GLOBALGROUP_IN_MIXEDDOMAIN = NTSTATUS(0xc00002d5),
    STATUS_DS_NO_NEST_LOCALGROUP_IN_MIXEDDOMAIN  = NTSTATUS(0xc00002d6),
}

enum : NTSTATUS
{
    STATUS_DS_GLOBAL_CANT_HAVE_LOCAL_MEMBER     = NTSTATUS(0xc00002d7),
    STATUS_DS_GLOBAL_CANT_HAVE_UNIVERSAL_MEMBER = NTSTATUS(0xc00002d8),
}

enum NTSTATUS STATUS_DS_UNIVERSAL_CANT_HAVE_LOCAL_MEMBER = NTSTATUS(0xc00002d9);
enum NTSTATUS STATUS_DS_GLOBAL_CANT_HAVE_CROSSDOMAIN_MEMBER = NTSTATUS(0xc00002da);
enum NTSTATUS STATUS_DS_LOCAL_CANT_HAVE_CROSSDOMAIN_LOCAL_MEMBER = NTSTATUS(0xc00002db);
enum NTSTATUS STATUS_DS_HAVE_PRIMARY_MEMBERS = NTSTATUS(0xc00002dc);
enum NTSTATUS STATUS_WMI_NOT_SUPPORTED = NTSTATUS(0xc00002dd);
enum NTSTATUS STATUS_INSUFFICIENT_POWER = NTSTATUS(0xc00002de);

enum : NTSTATUS
{
    STATUS_SAM_NEED_BOOTKEY_PASSWORD = NTSTATUS(0xc00002df),
    STATUS_SAM_NEED_BOOTKEY_FLOPPY   = NTSTATUS(0xc00002e0),
}

enum : NTSTATUS
{
    STATUS_DS_CANT_START   = NTSTATUS(0xc00002e1),
    STATUS_DS_INIT_FAILURE = NTSTATUS(0xc00002e2),
}

enum NTSTATUS STATUS_SAM_INIT_FAILURE = NTSTATUS(0xc00002e3);

enum : NTSTATUS
{
    STATUS_DS_GC_REQUIRED                = NTSTATUS(0xc00002e4),
    STATUS_DS_LOCAL_MEMBER_OF_LOCAL_ONLY = NTSTATUS(0xc00002e5),
}

enum NTSTATUS STATUS_DS_NO_FPO_IN_UNIVERSAL_GROUPS = NTSTATUS(0xc00002e6);
enum NTSTATUS STATUS_DS_MACHINE_ACCOUNT_QUOTA_EXCEEDED = NTSTATUS(0xc00002e7);
enum NTSTATUS STATUS_MULTIPLE_FAULT_VIOLATION = NTSTATUS(0xc00002e8);
enum NTSTATUS STATUS_CURRENT_DOMAIN_NOT_ALLOWED = NTSTATUS(0xc00002e9);
enum NTSTATUS STATUS_CANNOT_MAKE = NTSTATUS(0xc00002ea);
enum NTSTATUS STATUS_SYSTEM_SHUTDOWN = NTSTATUS(0xc00002eb);
enum NTSTATUS STATUS_DS_INIT_FAILURE_CONSOLE = NTSTATUS(0xc00002ec);
enum NTSTATUS STATUS_DS_SAM_INIT_FAILURE_CONSOLE = NTSTATUS(0xc00002ed);
enum NTSTATUS STATUS_UNFINISHED_CONTEXT_DELETED = NTSTATUS(0xc00002ee);
enum NTSTATUS STATUS_NO_TGT_REPLY = NTSTATUS(0xc00002ef);
enum NTSTATUS STATUS_OBJECTID_NOT_FOUND = NTSTATUS(0xc00002f0);
enum NTSTATUS STATUS_NO_IP_ADDRESSES = NTSTATUS(0xc00002f1);
enum NTSTATUS STATUS_WRONG_CREDENTIAL_HANDLE = NTSTATUS(0xc00002f2);
enum NTSTATUS STATUS_CRYPTO_SYSTEM_INVALID = NTSTATUS(0xc00002f3);
enum NTSTATUS STATUS_MAX_REFERRALS_EXCEEDED = NTSTATUS(0xc00002f4);
enum NTSTATUS STATUS_MUST_BE_KDC = NTSTATUS(0xc00002f5);
enum NTSTATUS STATUS_STRONG_CRYPTO_NOT_SUPPORTED = NTSTATUS(0xc00002f6);
enum NTSTATUS STATUS_TOO_MANY_PRINCIPALS = NTSTATUS(0xc00002f7);

enum : NTSTATUS
{
    STATUS_NO_PA_DATA           = NTSTATUS(0xc00002f8),
    STATUS_PKINIT_NAME_MISMATCH = NTSTATUS(0xc00002f9),
}

enum NTSTATUS STATUS_SMARTCARD_LOGON_REQUIRED = NTSTATUS(0xc00002fa);

enum : NTSTATUS
{
    STATUS_KDC_INVALID_REQUEST = NTSTATUS(0xc00002fb),
    STATUS_KDC_UNABLE_TO_REFER = NTSTATUS(0xc00002fc),
    STATUS_KDC_UNKNOWN_ETYPE   = NTSTATUS(0xc00002fd),
}

enum NTSTATUS STATUS_SHUTDOWN_IN_PROGRESS = NTSTATUS(0xc00002fe);
enum NTSTATUS STATUS_SERVER_SHUTDOWN_IN_PROGRESS = NTSTATUS(0xc00002ff);
enum NTSTATUS STATUS_NOT_SUPPORTED_ON_SBS = NTSTATUS(0xc0000300);
enum NTSTATUS STATUS_WMI_GUID_DISCONNECTED = NTSTATUS(0xc0000301);

enum : NTSTATUS
{
    STATUS_WMI_ALREADY_DISABLED = NTSTATUS(0xc0000302),
    STATUS_WMI_ALREADY_ENABLED  = NTSTATUS(0xc0000303),
}

enum NTSTATUS STATUS_MFT_TOO_FRAGMENTED = NTSTATUS(0xc0000304);
enum NTSTATUS STATUS_COPY_PROTECTION_FAILURE = NTSTATUS(0xc0000305);
enum NTSTATUS STATUS_CSS_AUTHENTICATION_FAILURE = NTSTATUS(0xc0000306);

enum : NTSTATUS
{
    STATUS_CSS_KEY_NOT_PRESENT     = NTSTATUS(0xc0000307),
    STATUS_CSS_KEY_NOT_ESTABLISHED = NTSTATUS(0xc0000308),
}

enum : NTSTATUS
{
    STATUS_CSS_SCRAMBLED_SECTOR = NTSTATUS(0xc0000309),
    STATUS_CSS_REGION_MISMATCH  = NTSTATUS(0xc000030a),
    STATUS_CSS_RESETS_EXHAUSTED = NTSTATUS(0xc000030b),
}

enum NTSTATUS STATUS_PASSWORD_CHANGE_REQUIRED = NTSTATUS(0xc000030c);
enum NTSTATUS STATUS_LOST_MODE_LOGON_RESTRICTION = NTSTATUS(0xc000030d);
enum NTSTATUS STATUS_PKINIT_FAILURE = NTSTATUS(0xc0000320);
enum NTSTATUS STATUS_SMARTCARD_SUBSYSTEM_FAILURE = NTSTATUS(0xc0000321);
enum NTSTATUS STATUS_NO_KERB_KEY = NTSTATUS(0xc0000322);

enum : NTSTATUS
{
    STATUS_HOST_DOWN           = NTSTATUS(0xc0000350),
    STATUS_UNSUPPORTED_PREAUTH = NTSTATUS(0xc0000351),
}

enum NTSTATUS STATUS_EFS_ALG_BLOB_TOO_BIG = NTSTATUS(0xc0000352);
enum NTSTATUS STATUS_PORT_NOT_SET = NTSTATUS(0xc0000353);
enum NTSTATUS STATUS_DEBUGGER_INACTIVE = NTSTATUS(0xc0000354);
enum NTSTATUS STATUS_DS_VERSION_CHECK_FAILURE = NTSTATUS(0xc0000355);
enum NTSTATUS STATUS_AUDITING_DISABLED = NTSTATUS(0xc0000356);
enum NTSTATUS STATUS_PRENT4_MACHINE_ACCOUNT = NTSTATUS(0xc0000357);
enum NTSTATUS STATUS_DS_AG_CANT_HAVE_UNIVERSAL_MEMBER = NTSTATUS(0xc0000358);

enum : NTSTATUS
{
    STATUS_INVALID_IMAGE_WIN_32 = NTSTATUS(0xc0000359),
    STATUS_INVALID_IMAGE_WIN_64 = NTSTATUS(0xc000035a),
}

enum NTSTATUS STATUS_BAD_BINDINGS = NTSTATUS(0xc000035b);
enum NTSTATUS STATUS_NETWORK_SESSION_EXPIRED = NTSTATUS(0xc000035c);
enum NTSTATUS STATUS_APPHELP_BLOCK = NTSTATUS(0xc000035d);
enum NTSTATUS STATUS_ALL_SIDS_FILTERED = NTSTATUS(0xc000035e);
enum NTSTATUS STATUS_NOT_SAFE_MODE_DRIVER = NTSTATUS(0xc000035f);

enum : NTSTATUS
{
    STATUS_ACCESS_DISABLED_BY_POLICY_DEFAULT   = NTSTATUS(0xc0000361),
    STATUS_ACCESS_DISABLED_BY_POLICY_PATH      = NTSTATUS(0xc0000362),
    STATUS_ACCESS_DISABLED_BY_POLICY_PUBLISHER = NTSTATUS(0xc0000363),
    STATUS_ACCESS_DISABLED_BY_POLICY_OTHER     = NTSTATUS(0xc0000364),
}

enum NTSTATUS STATUS_FAILED_DRIVER_ENTRY = NTSTATUS(0xc0000365);
enum NTSTATUS STATUS_DEVICE_ENUMERATION_ERROR = NTSTATUS(0xc0000366);
enum NTSTATUS STATUS_MOUNT_POINT_NOT_RESOLVED = NTSTATUS(0xc0000368);
enum NTSTATUS STATUS_INVALID_DEVICE_OBJECT_PARAMETER = NTSTATUS(0xc0000369);
enum NTSTATUS STATUS_MCA_OCCURED = NTSTATUS(0xc000036a);

enum : NTSTATUS
{
    STATUS_DRIVER_BLOCKED_CRITICAL = NTSTATUS(0xc000036b),
    STATUS_DRIVER_BLOCKED          = NTSTATUS(0xc000036c),
    STATUS_DRIVER_DATABASE_ERROR   = NTSTATUS(0xc000036d),
}

enum NTSTATUS STATUS_SYSTEM_HIVE_TOO_LARGE = NTSTATUS(0xc000036e);
enum NTSTATUS STATUS_INVALID_IMPORT_OF_NON_DLL = NTSTATUS(0xc000036f);
enum NTSTATUS STATUS_DS_SHUTTING_DOWN = NTSTATUS(0x40000370);

enum : NTSTATUS
{
    STATUS_NO_SECRETS                            = NTSTATUS(0xc0000371),
    STATUS_ACCESS_DISABLED_NO_SAFER_UI_BY_POLICY = NTSTATUS(0xc0000372),
}

enum NTSTATUS STATUS_FAILED_STACK_SWITCH = NTSTATUS(0xc0000373);
enum NTSTATUS STATUS_HEAP_CORRUPTION = NTSTATUS(0xc0000374);

enum : NTSTATUS
{
    STATUS_SMARTCARD_WRONG_PIN              = NTSTATUS(0xc0000380),
    STATUS_SMARTCARD_CARD_BLOCKED           = NTSTATUS(0xc0000381),
    STATUS_SMARTCARD_CARD_NOT_AUTHENTICATED = NTSTATUS(0xc0000382),
    STATUS_SMARTCARD_NO_CARD                = NTSTATUS(0xc0000383),
    STATUS_SMARTCARD_NO_KEY_CONTAINER       = NTSTATUS(0xc0000384),
    STATUS_SMARTCARD_NO_CERTIFICATE         = NTSTATUS(0xc0000385),
    STATUS_SMARTCARD_NO_KEYSET              = NTSTATUS(0xc0000386),
    STATUS_SMARTCARD_IO_ERROR               = NTSTATUS(0xc0000387),
    STATUS_SMARTCARD_CERT_REVOKED           = NTSTATUS(0xc0000389),
}

enum NTSTATUS STATUS_ISSUING_CA_UNTRUSTED = NTSTATUS(0xc000038a);
enum NTSTATUS STATUS_REVOCATION_OFFLINE_C = NTSTATUS(0xc000038b);
enum NTSTATUS STATUS_PKINIT_CLIENT_FAILURE = NTSTATUS(0xc000038c);
enum NTSTATUS STATUS_SMARTCARD_CERT_EXPIRED = NTSTATUS(0xc000038d);
enum NTSTATUS STATUS_DRIVER_FAILED_PRIOR_UNLOAD = NTSTATUS(0xc000038e);
enum NTSTATUS STATUS_SMARTCARD_SILENT_CONTEXT = NTSTATUS(0xc000038f);
enum NTSTATUS STATUS_PER_USER_TRUST_QUOTA_EXCEEDED = NTSTATUS(0xc0000401);
enum NTSTATUS STATUS_ALL_USER_TRUST_QUOTA_EXCEEDED = NTSTATUS(0xc0000402);
enum NTSTATUS STATUS_USER_DELETE_TRUST_QUOTA_EXCEEDED = NTSTATUS(0xc0000403);
enum NTSTATUS STATUS_DS_NAME_NOT_UNIQUE = NTSTATUS(0xc0000404);
enum NTSTATUS STATUS_DS_DUPLICATE_ID_FOUND = NTSTATUS(0xc0000405);
enum NTSTATUS STATUS_DS_GROUP_CONVERSION_ERROR = NTSTATUS(0xc0000406);
enum NTSTATUS STATUS_VOLSNAP_PREPARE_HIBERNATE = NTSTATUS(0xc0000407);
enum NTSTATUS STATUS_USER2USER_REQUIRED = NTSTATUS(0xc0000408);
enum NTSTATUS STATUS_STACK_BUFFER_OVERRUN = NTSTATUS(0xc0000409);
enum NTSTATUS STATUS_NO_S4U_PROT_SUPPORT = NTSTATUS(0xc000040a);
enum NTSTATUS STATUS_CROSSREALM_DELEGATION_FAILURE = NTSTATUS(0xc000040b);
enum NTSTATUS STATUS_REVOCATION_OFFLINE_KDC = NTSTATUS(0xc000040c);
enum NTSTATUS STATUS_ISSUING_CA_UNTRUSTED_KDC = NTSTATUS(0xc000040d);

enum : NTSTATUS
{
    STATUS_KDC_CERT_EXPIRED = NTSTATUS(0xc000040e),
    STATUS_KDC_CERT_REVOKED = NTSTATUS(0xc000040f),
}

enum NTSTATUS STATUS_PARAMETER_QUOTA_EXCEEDED = NTSTATUS(0xc0000410);
enum NTSTATUS STATUS_HIBERNATION_FAILURE = NTSTATUS(0xc0000411);
enum NTSTATUS STATUS_DELAY_LOAD_FAILED = NTSTATUS(0xc0000412);
enum NTSTATUS STATUS_VDM_DISALLOWED = NTSTATUS(0xc0000414);
enum NTSTATUS STATUS_HUNG_DISPLAY_DRIVER_THREAD = NTSTATUS(0xc0000415);
enum NTSTATUS STATUS_INSUFFICIENT_RESOURCE_FOR_SPECIFIED_SHARED_SECTION_SIZE = NTSTATUS(0xc0000416);
enum NTSTATUS STATUS_INVALID_CRUNTIME_PARAMETER = NTSTATUS(0xc0000417);
enum NTSTATUS STATUS_NTLM_BLOCKED = NTSTATUS(0xc0000418);
enum NTSTATUS STATUS_DS_SRC_SID_EXISTS_IN_FOREST = NTSTATUS(0xc0000419);
enum NTSTATUS STATUS_DS_DOMAIN_NAME_EXISTS_IN_FOREST = NTSTATUS(0xc000041a);
enum NTSTATUS STATUS_DS_FLAT_NAME_EXISTS_IN_FOREST = NTSTATUS(0xc000041b);
enum NTSTATUS STATUS_INVALID_USER_PRINCIPAL_NAME = NTSTATUS(0xc000041c);
enum NTSTATUS STATUS_FATAL_USER_CALLBACK_EXCEPTION = NTSTATUS(0xc000041d);
enum NTSTATUS STATUS_ASSERTION_FAILURE = NTSTATUS(0xc0000420);
enum NTSTATUS STATUS_VERIFIER_STOP = NTSTATUS(0xc0000421);
enum NTSTATUS STATUS_CALLBACK_POP_STACK = NTSTATUS(0xc0000423);
enum NTSTATUS STATUS_INCOMPATIBLE_DRIVER_BLOCKED = NTSTATUS(0xc0000424);
enum NTSTATUS STATUS_HIVE_UNLOADED = NTSTATUS(0xc0000425);
enum NTSTATUS STATUS_COMPRESSION_DISABLED = NTSTATUS(0xc0000426);
enum NTSTATUS STATUS_FILE_SYSTEM_LIMITATION = NTSTATUS(0xc0000427);
enum NTSTATUS STATUS_INVALID_IMAGE_HASH = NTSTATUS(0xc0000428);
enum NTSTATUS STATUS_NOT_CAPABLE = NTSTATUS(0xc0000429);
enum NTSTATUS STATUS_REQUEST_OUT_OF_SEQUENCE = NTSTATUS(0xc000042a);
enum NTSTATUS STATUS_IMPLEMENTATION_LIMIT = NTSTATUS(0xc000042b);
enum NTSTATUS STATUS_ELEVATION_REQUIRED = NTSTATUS(0xc000042c);
enum NTSTATUS STATUS_NO_SECURITY_CONTEXT = NTSTATUS(0xc000042d);
enum NTSTATUS STATUS_PKU2U_CERT_FAILURE = NTSTATUS(0xc000042f);

enum : NTSTATUS
{
    STATUS_BEYOND_VDL                    = NTSTATUS(0xc0000432),
    STATUS_ENCOUNTERED_WRITE_IN_PROGRESS = NTSTATUS(0xc0000433),
}

enum : NTSTATUS
{
    STATUS_PTE_CHANGED  = NTSTATUS(0xc0000434),
    STATUS_PURGE_FAILED = NTSTATUS(0xc0000435),
}

enum NTSTATUS STATUS_CRED_REQUIRES_CONFIRMATION = NTSTATUS(0xc0000440);

enum : NTSTATUS
{
    STATUS_CS_ENCRYPTION_INVALID_SERVER_RESPONSE = NTSTATUS(0xc0000441),
    STATUS_CS_ENCRYPTION_UNSUPPORTED_SERVER      = NTSTATUS(0xc0000442),
    STATUS_CS_ENCRYPTION_EXISTING_ENCRYPTED_FILE = NTSTATUS(0xc0000443),
    STATUS_CS_ENCRYPTION_NEW_ENCRYPTED_FILE      = NTSTATUS(0xc0000444),
    STATUS_CS_ENCRYPTION_FILE_NOT_CSE            = NTSTATUS(0xc0000445),
}

enum NTSTATUS STATUS_INVALID_LABEL = NTSTATUS(0xc0000446);
enum NTSTATUS STATUS_DRIVER_PROCESS_TERMINATED = NTSTATUS(0xc0000450);
enum NTSTATUS STATUS_AMBIGUOUS_SYSTEM_DEVICE = NTSTATUS(0xc0000451);
enum NTSTATUS STATUS_SYSTEM_DEVICE_NOT_FOUND = NTSTATUS(0xc0000452);
enum NTSTATUS STATUS_RESTART_BOOT_APPLICATION = NTSTATUS(0xc0000453);
enum NTSTATUS STATUS_INSUFFICIENT_NVRAM_RESOURCES = NTSTATUS(0xc0000454);
enum NTSTATUS STATUS_INVALID_SESSION = NTSTATUS(0xc0000455);

enum : NTSTATUS
{
    STATUS_THREAD_ALREADY_IN_SESSION = NTSTATUS(0xc0000456),
    STATUS_THREAD_NOT_IN_SESSION     = NTSTATUS(0xc0000457),
}

enum NTSTATUS STATUS_INVALID_WEIGHT = NTSTATUS(0xc0000458);
enum NTSTATUS STATUS_REQUEST_PAUSED = NTSTATUS(0xc0000459);
enum NTSTATUS STATUS_NO_RANGES_PROCESSED = NTSTATUS(0xc0000460);
enum NTSTATUS STATUS_DISK_RESOURCES_EXHAUSTED = NTSTATUS(0xc0000461);
enum NTSTATUS STATUS_NEEDS_REMEDIATION = NTSTATUS(0xc0000462);
enum NTSTATUS STATUS_DEVICE_FEATURE_NOT_SUPPORTED = NTSTATUS(0xc0000463);
enum NTSTATUS STATUS_DEVICE_UNREACHABLE = NTSTATUS(0xc0000464);
enum NTSTATUS STATUS_INVALID_TOKEN = NTSTATUS(0xc0000465);
enum NTSTATUS STATUS_SERVER_UNAVAILABLE = NTSTATUS(0xc0000466);
enum NTSTATUS STATUS_FILE_NOT_AVAILABLE = NTSTATUS(0xc0000467);
enum NTSTATUS STATUS_DEVICE_INSUFFICIENT_RESOURCES = NTSTATUS(0xc0000468);
enum NTSTATUS STATUS_PACKAGE_UPDATING = NTSTATUS(0xc0000469);
enum NTSTATUS STATUS_NOT_READ_FROM_COPY = NTSTATUS(0xc000046a);

enum : NTSTATUS
{
    STATUS_FT_WRITE_FAILURE    = NTSTATUS(0xc000046b),
    STATUS_FT_DI_SCAN_REQUIRED = NTSTATUS(0xc000046c),
}

enum NTSTATUS STATUS_OBJECT_NOT_EXTERNALLY_BACKED = NTSTATUS(0xc000046d);
enum NTSTATUS STATUS_EXTERNAL_BACKING_PROVIDER_UNKNOWN = NTSTATUS(0xc000046e);
enum NTSTATUS STATUS_COMPRESSION_NOT_BENEFICIAL = NTSTATUS(0xc000046f);
enum NTSTATUS STATUS_DATA_CHECKSUM_ERROR = NTSTATUS(0xc0000470);
enum NTSTATUS STATUS_INTERMIXED_KERNEL_EA_OPERATION = NTSTATUS(0xc0000471);
enum NTSTATUS STATUS_TRIM_READ_ZERO_NOT_SUPPORTED = NTSTATUS(0xc0000472);
enum NTSTATUS STATUS_TOO_MANY_SEGMENT_DESCRIPTORS = NTSTATUS(0xc0000473);

enum : NTSTATUS
{
    STATUS_INVALID_OFFSET_ALIGNMENT        = NTSTATUS(0xc0000474),
    STATUS_INVALID_FIELD_IN_PARAMETER_LIST = NTSTATUS(0xc0000475),
}

enum NTSTATUS STATUS_OPERATION_IN_PROGRESS = NTSTATUS(0xc0000476);
enum NTSTATUS STATUS_INVALID_INITIATOR_TARGET_PATH = NTSTATUS(0xc0000477);
enum NTSTATUS STATUS_SCRUB_DATA_DISABLED = NTSTATUS(0xc0000478);
enum NTSTATUS STATUS_NOT_REDUNDANT_STORAGE = NTSTATUS(0xc0000479);
enum NTSTATUS STATUS_RESIDENT_FILE_NOT_SUPPORTED = NTSTATUS(0xc000047a);
enum NTSTATUS STATUS_COMPRESSED_FILE_NOT_SUPPORTED = NTSTATUS(0xc000047b);
enum NTSTATUS STATUS_DIRECTORY_NOT_SUPPORTED = NTSTATUS(0xc000047c);
enum NTSTATUS STATUS_IO_OPERATION_TIMEOUT = NTSTATUS(0xc000047d);
enum NTSTATUS STATUS_SYSTEM_NEEDS_REMEDIATION = NTSTATUS(0xc000047e);
enum NTSTATUS STATUS_APPX_INTEGRITY_FAILURE_CLR_NGEN = NTSTATUS(0xc000047f);
enum NTSTATUS STATUS_SHARE_UNAVAILABLE = NTSTATUS(0xc0000480);

enum : NTSTATUS
{
    STATUS_APISET_NOT_HOSTED  = NTSTATUS(0xc0000481),
    STATUS_APISET_NOT_PRESENT = NTSTATUS(0xc0000482),
}

enum NTSTATUS STATUS_DEVICE_HARDWARE_ERROR = NTSTATUS(0xc0000483);

enum : NTSTATUS
{
    STATUS_FIRMWARE_SLOT_INVALID  = NTSTATUS(0xc0000484),
    STATUS_FIRMWARE_IMAGE_INVALID = NTSTATUS(0xc0000485),
}

enum NTSTATUS STATUS_STORAGE_TOPOLOGY_ID_MISMATCH = NTSTATUS(0xc0000486);
enum NTSTATUS STATUS_WIM_NOT_BOOTABLE = NTSTATUS(0xc0000487);
enum NTSTATUS STATUS_BLOCKED_BY_PARENTAL_CONTROLS = NTSTATUS(0xc0000488);
enum NTSTATUS STATUS_NEEDS_REGISTRATION = NTSTATUS(0xc0000489);
enum NTSTATUS STATUS_QUOTA_ACTIVITY = NTSTATUS(0xc000048a);
enum NTSTATUS STATUS_CALLBACK_INVOKE_INLINE = NTSTATUS(0xc000048b);
enum NTSTATUS STATUS_BLOCK_TOO_MANY_REFERENCES = NTSTATUS(0xc000048c);
enum NTSTATUS STATUS_MARKED_TO_DISALLOW_WRITES = NTSTATUS(0xc000048d);
enum NTSTATUS STATUS_NETWORK_ACCESS_DENIED_EDP = NTSTATUS(0xc000048e);
enum NTSTATUS STATUS_ENCLAVE_FAILURE = NTSTATUS(0xc000048f);
enum NTSTATUS STATUS_PNP_NO_COMPAT_DRIVERS = NTSTATUS(0xc0000490);

enum : NTSTATUS
{
    STATUS_PNP_DRIVER_PACKAGE_NOT_FOUND        = NTSTATUS(0xc0000491),
    STATUS_PNP_DRIVER_CONFIGURATION_NOT_FOUND  = NTSTATUS(0xc0000492),
    STATUS_PNP_DRIVER_CONFIGURATION_INCOMPLETE = NTSTATUS(0xc0000493),
}

enum NTSTATUS STATUS_PNP_FUNCTION_DRIVER_REQUIRED = NTSTATUS(0xc0000494);
enum NTSTATUS STATUS_PNP_DEVICE_CONFIGURATION_PENDING = NTSTATUS(0xc0000495);
enum NTSTATUS STATUS_DEVICE_HINT_NAME_BUFFER_TOO_SMALL = NTSTATUS(0xc0000496);
enum NTSTATUS STATUS_PACKAGE_NOT_AVAILABLE = NTSTATUS(0xc0000497);
enum NTSTATUS STATUS_DEVICE_IN_MAINTENANCE = NTSTATUS(0xc0000499);
enum NTSTATUS STATUS_NOT_SUPPORTED_ON_DAX = NTSTATUS(0xc000049a);
enum NTSTATUS STATUS_FREE_SPACE_TOO_FRAGMENTED = NTSTATUS(0xc000049b);
enum NTSTATUS STATUS_DAX_MAPPING_EXISTS = NTSTATUS(0xc000049c);
enum NTSTATUS STATUS_CHILD_PROCESS_BLOCKED = NTSTATUS(0xc000049d);
enum NTSTATUS STATUS_STORAGE_LOST_DATA_PERSISTENCE = NTSTATUS(0xc000049e);
enum NTSTATUS STATUS_PARTITION_TERMINATING = NTSTATUS(0xc00004a0);
enum NTSTATUS STATUS_EXTERNAL_SYSKEY_NOT_SUPPORTED = NTSTATUS(0xc00004a1);
enum NTSTATUS STATUS_ENCLAVE_VIOLATION = NTSTATUS(0xc00004a2);
enum NTSTATUS STATUS_FILE_PROTECTED_UNDER_DPL = NTSTATUS(0xc00004a3);
enum NTSTATUS STATUS_VOLUME_NOT_CLUSTER_ALIGNED = NTSTATUS(0xc00004a4);
enum NTSTATUS STATUS_NO_PHYSICALLY_ALIGNED_FREE_SPACE_FOUND = NTSTATUS(0xc00004a5);
enum NTSTATUS STATUS_APPX_FILE_NOT_ENCRYPTED = NTSTATUS(0xc00004a6);

enum : NTSTATUS
{
    STATUS_RWRAW_ENCRYPTED_FILE_NOT_ENCRYPTED           = NTSTATUS(0xc00004a7),
    STATUS_RWRAW_ENCRYPTED_INVALID_EDATAINFO_FILEOFFSET = NTSTATUS(0xc00004a8),
    STATUS_RWRAW_ENCRYPTED_INVALID_EDATAINFO_FILERANGE  = NTSTATUS(0xc00004a9),
    STATUS_RWRAW_ENCRYPTED_INVALID_EDATAINFO_PARAMETER  = NTSTATUS(0xc00004aa),
}

enum NTSTATUS STATUS_FT_READ_FAILURE = NTSTATUS(0xc00004ab);
enum NTSTATUS STATUS_PATCH_CONFLICT = NTSTATUS(0xc00004ac);

enum : NTSTATUS
{
    STATUS_STORAGE_RESERVE_ID_INVALID     = NTSTATUS(0xc00004ad),
    STATUS_STORAGE_RESERVE_DOES_NOT_EXIST = NTSTATUS(0xc00004ae),
    STATUS_STORAGE_RESERVE_ALREADY_EXISTS = NTSTATUS(0xc00004af),
    STATUS_STORAGE_RESERVE_NOT_EMPTY      = NTSTATUS(0xc00004b0),
}

enum : NTSTATUS
{
    STATUS_NOT_A_DAX_VOLUME = NTSTATUS(0xc00004b1),
    STATUS_NOT_DAX_MAPPABLE = NTSTATUS(0xc00004b2),
}

enum NTSTATUS STATUS_CASE_DIFFERING_NAMES_IN_DIR = NTSTATUS(0xc00004b3);
enum NTSTATUS STATUS_FILE_NOT_SUPPORTED = NTSTATUS(0xc00004b4);
enum NTSTATUS STATUS_NOT_SUPPORTED_WITH_BTT = NTSTATUS(0xc00004b5);

enum : NTSTATUS
{
    STATUS_ENCRYPTION_DISABLED            = NTSTATUS(0xc00004b6),
    STATUS_ENCRYPTING_METADATA_DISALLOWED = NTSTATUS(0xc00004b7),
}

enum NTSTATUS STATUS_CANT_CLEAR_ENCRYPTION_FLAG = NTSTATUS(0xc00004b8);
enum NTSTATUS STATUS_UNSATISFIED_DEPENDENCIES = NTSTATUS(0xc00004b9);
enum NTSTATUS STATUS_CASE_SENSITIVE_PATH = NTSTATUS(0xc00004ba);
enum NTSTATUS STATUS_UNSUPPORTED_PAGING_MODE = NTSTATUS(0xc00004bb);
enum NTSTATUS STATUS_UNTRUSTED_MOUNT_POINT = NTSTATUS(0xc00004bc);
enum NTSTATUS STATUS_HAS_SYSTEM_CRITICAL_FILES = NTSTATUS(0xc00004bd);
enum NTSTATUS STATUS_OBJECT_IS_IMMUTABLE = NTSTATUS(0xc00004be);
enum NTSTATUS STATUS_FT_READ_FROM_COPY_FAILURE = NTSTATUS(0xc00004bf);
enum NTSTATUS STATUS_IMAGE_LOADED_AS_PATCH_IMAGE = NTSTATUS(0xc00004c0);
enum NTSTATUS STATUS_STORAGE_STACK_ACCESS_DENIED = NTSTATUS(0xc00004c1);
enum NTSTATUS STATUS_INSUFFICIENT_VIRTUAL_ADDR_RESOURCES = NTSTATUS(0xc00004c2);
enum NTSTATUS STATUS_ENCRYPTED_FILE_NOT_SUPPORTED = NTSTATUS(0xc00004c3);
enum NTSTATUS STATUS_SPARSE_FILE_NOT_SUPPORTED = NTSTATUS(0xc00004c4);
enum NTSTATUS STATUS_PAGEFILE_NOT_SUPPORTED = NTSTATUS(0xc00004c5);
enum NTSTATUS STATUS_VOLUME_NOT_SUPPORTED = NTSTATUS(0xc00004c6);
enum NTSTATUS STATUS_NOT_SUPPORTED_WITH_BYPASSIO = NTSTATUS(0xc00004c7);
enum NTSTATUS STATUS_NO_BYPASSIO_DRIVER_SUPPORT = NTSTATUS(0xc00004c8);

enum : NTSTATUS
{
    STATUS_NOT_SUPPORTED_WITH_ENCRYPTION     = NTSTATUS(0xc00004c9),
    STATUS_NOT_SUPPORTED_WITH_COMPRESSION    = NTSTATUS(0xc00004ca),
    STATUS_NOT_SUPPORTED_WITH_REPLICATION    = NTSTATUS(0xc00004cb),
    STATUS_NOT_SUPPORTED_WITH_DEDUPLICATION  = NTSTATUS(0xc00004cc),
    STATUS_NOT_SUPPORTED_WITH_AUDITING       = NTSTATUS(0xc00004cd),
    STATUS_NOT_SUPPORTED_WITH_MONITORING     = NTSTATUS(0xc00004ce),
    STATUS_NOT_SUPPORTED_WITH_SNAPSHOT       = NTSTATUS(0xc00004cf),
    STATUS_NOT_SUPPORTED_WITH_VIRTUALIZATION = NTSTATUS(0xc00004d0),
}

enum NTSTATUS STATUS_INDEX_OUT_OF_BOUNDS = NTSTATUS(0xc00004d1);
enum NTSTATUS STATUS_BYPASSIO_FLT_NOT_SUPPORTED = NTSTATUS(0xc00004d2);
enum NTSTATUS STATUS_VOLUME_WRITE_ACCESS_DENIED = NTSTATUS(0xc00004d3);
enum NTSTATUS STATUS_PATCH_NOT_REGISTERED = NTSTATUS(0xc00004d4);
enum NTSTATUS STATUS_NOT_SUPPORTED_WITH_CACHED_HANDLE = NTSTATUS(0xc00004d5);
enum NTSTATUS STATUS_PDE_ENCRYPTION_UNAVAILABLE_FAILURE = NTSTATUS(0xc00004d6);

enum : NTSTATUS
{
    STATUS_PDE_DECRYPTION_UNAVAILABLE_FAILURE = NTSTATUS(0xc00004d7),
    STATUS_PDE_DECRYPTION_UNAVAILABLE         = NTSTATUS(0xc00004d8),
}

enum : NTSTATUS
{
    STATUS_VOLUME_UPGRADE_NOT_NEEDED                         = NTSTATUS(0x400004d9),
    STATUS_VOLUME_UPGRADE_PENDING                            = NTSTATUS(0x400004da),
    STATUS_VOLUME_UPGRADE_DISABLED                           = NTSTATUS(0xc00004db),
    STATUS_VOLUME_UPGRADE_DISABLED_TILL_OS_DOWNGRADE_EXPIRED = NTSTATUS(0xc00004dc),
}

enum NTSTATUS STATUS_NOT_A_DEV_VOLUME = NTSTATUS(0xc00004dd);
enum NTSTATUS STATUS_FS_GUID_MISMATCH = NTSTATUS(0xc00004de);
enum NTSTATUS STATUS_CANT_ATTACH_TO_DEV_VOLUME = NTSTATUS(0xc00004df);
enum NTSTATUS STATUS_MEMORY_DECOMPRESSION_FAILURE = NTSTATUS(0xc00004e0);
enum NTSTATUS STATUS_INVALID_CONFIG_VALUE = NTSTATUS(0xc00004e1);
enum NTSTATUS STATUS_MEMORY_DECOMPRESSION_HW_ERROR = NTSTATUS(0xc00004e2);
enum NTSTATUS STATUS_VOLUME_ROLLBACK_DETECTED = NTSTATUS(0xc00004e3);

enum : NTSTATUS
{
    STATUS_INVALID_TASK_NAME  = NTSTATUS(0xc0000500),
    STATUS_INVALID_TASK_INDEX = NTSTATUS(0xc0000501),
}

enum NTSTATUS STATUS_THREAD_ALREADY_IN_TASK = NTSTATUS(0xc0000502);
enum NTSTATUS STATUS_CALLBACK_BYPASS = NTSTATUS(0xc0000503);
enum NTSTATUS STATUS_UNDEFINED_SCOPE = NTSTATUS(0xc0000504);
enum NTSTATUS STATUS_INVALID_CAP = NTSTATUS(0xc0000505);
enum NTSTATUS STATUS_NOT_GUI_PROCESS = NTSTATUS(0xc0000506);
enum NTSTATUS STATUS_DEVICE_HUNG = NTSTATUS(0xc0000507);
enum NTSTATUS STATUS_CONTAINER_ASSIGNED = NTSTATUS(0xc0000508);
enum NTSTATUS STATUS_JOB_NO_CONTAINER = NTSTATUS(0xc0000509);
enum NTSTATUS STATUS_DEVICE_UNRESPONSIVE = NTSTATUS(0xc000050a);
enum NTSTATUS STATUS_REPARSE_POINT_ENCOUNTERED = NTSTATUS(0xc000050b);
enum NTSTATUS STATUS_ATTRIBUTE_NOT_PRESENT = NTSTATUS(0xc000050c);
enum NTSTATUS STATUS_NOT_A_TIERED_VOLUME = NTSTATUS(0xc000050d);
enum NTSTATUS STATUS_ALREADY_HAS_STREAM_ID = NTSTATUS(0xc000050e);
enum NTSTATUS STATUS_JOB_NOT_EMPTY = NTSTATUS(0xc000050f);
enum NTSTATUS STATUS_ALREADY_INITIALIZED = NTSTATUS(0xc0000510);

enum : NTSTATUS
{
    STATUS_ENCLAVE_NOT_TERMINATED = NTSTATUS(0xc0000511),
    STATUS_ENCLAVE_IS_TERMINATING = NTSTATUS(0xc0000512),
}

enum NTSTATUS STATUS_SMB1_NOT_AVAILABLE = NTSTATUS(0xc0000513);
enum NTSTATUS STATUS_SMR_GARBAGE_COLLECTION_REQUIRED = NTSTATUS(0xc0000514);
enum NTSTATUS STATUS_INTERRUPTED = NTSTATUS(0xc0000515);
enum NTSTATUS STATUS_THREAD_NOT_RUNNING = NTSTATUS(0xc0000516);
enum NTSTATUS STATUS_SESSION_KEY_TOO_SHORT = NTSTATUS(0xc0000517);
enum NTSTATUS STATUS_FS_METADATA_INCONSISTENT = NTSTATUS(0xc0000518);
enum NTSTATUS STATUS_FAIL_FAST_EXCEPTION = NTSTATUS(0xc0000602);
enum NTSTATUS STATUS_IMAGE_CERT_REVOKED = NTSTATUS(0xc0000603);
enum NTSTATUS STATUS_DYNAMIC_CODE_BLOCKED = NTSTATUS(0xc0000604);
enum NTSTATUS STATUS_IMAGE_CERT_EXPIRED = NTSTATUS(0xc0000605);
enum NTSTATUS STATUS_STRICT_CFG_VIOLATION = NTSTATUS(0xc0000606);
enum NTSTATUS STATUS_SET_CONTEXT_DENIED = NTSTATUS(0xc000060a);
enum NTSTATUS STATUS_CROSS_PARTITION_VIOLATION = NTSTATUS(0xc000060b);
enum NTSTATUS STATUS_PORT_CLOSED = NTSTATUS(0xc0000700);
enum NTSTATUS STATUS_MESSAGE_LOST = NTSTATUS(0xc0000701);
enum NTSTATUS STATUS_INVALID_MESSAGE = NTSTATUS(0xc0000702);
enum NTSTATUS STATUS_REQUEST_CANCELED = NTSTATUS(0xc0000703);
enum NTSTATUS STATUS_RECURSIVE_DISPATCH = NTSTATUS(0xc0000704);
enum NTSTATUS STATUS_LPC_RECEIVE_BUFFER_EXPECTED = NTSTATUS(0xc0000705);
enum NTSTATUS STATUS_LPC_INVALID_CONNECTION_USAGE = NTSTATUS(0xc0000706);
enum NTSTATUS STATUS_LPC_REQUESTS_NOT_ALLOWED = NTSTATUS(0xc0000707);
enum NTSTATUS STATUS_RESOURCE_IN_USE = NTSTATUS(0xc0000708);
enum NTSTATUS STATUS_HARDWARE_MEMORY_ERROR = NTSTATUS(0xc0000709);

enum : NTSTATUS
{
    STATUS_THREADPOOL_HANDLE_EXCEPTION               = NTSTATUS(0xc000070a),
    STATUS_THREADPOOL_SET_EVENT_ON_COMPLETION_FAILED = NTSTATUS(0xc000070b),
}

enum : NTSTATUS
{
    STATUS_THREADPOOL_RELEASE_SEMAPHORE_ON_COMPLETION_FAILED = NTSTATUS(0xc000070c),
    STATUS_THREADPOOL_RELEASE_MUTEX_ON_COMPLETION_FAILED     = NTSTATUS(0xc000070d),
}

enum NTSTATUS STATUS_THREADPOOL_FREE_LIBRARY_ON_COMPLETION_FAILED = NTSTATUS(0xc000070e);
enum NTSTATUS STATUS_THREADPOOL_RELEASED_DURING_OPERATION = NTSTATUS(0xc000070f);
enum NTSTATUS STATUS_CALLBACK_RETURNED_WHILE_IMPERSONATING = NTSTATUS(0xc0000710);
enum NTSTATUS STATUS_APC_RETURNED_WHILE_IMPERSONATING = NTSTATUS(0xc0000711);
enum NTSTATUS STATUS_PROCESS_IS_PROTECTED = NTSTATUS(0xc0000712);
enum NTSTATUS STATUS_MCA_EXCEPTION = NTSTATUS(0xc0000713);
enum NTSTATUS STATUS_CERTIFICATE_MAPPING_NOT_UNIQUE = NTSTATUS(0xc0000714);
enum NTSTATUS STATUS_SYMLINK_CLASS_DISABLED = NTSTATUS(0xc0000715);
enum NTSTATUS STATUS_INVALID_IDN_NORMALIZATION = NTSTATUS(0xc0000716);
enum NTSTATUS STATUS_NO_UNICODE_TRANSLATION = NTSTATUS(0xc0000717);
enum NTSTATUS STATUS_ALREADY_REGISTERED = NTSTATUS(0xc0000718);
enum NTSTATUS STATUS_CONTEXT_MISMATCH = NTSTATUS(0xc0000719);
enum NTSTATUS STATUS_PORT_ALREADY_HAS_COMPLETION_LIST = NTSTATUS(0xc000071a);
enum NTSTATUS STATUS_CALLBACK_RETURNED_THREAD_PRIORITY = NTSTATUS(0xc000071b);
enum NTSTATUS STATUS_INVALID_THREAD = NTSTATUS(0xc000071c);

enum : NTSTATUS
{
    STATUS_CALLBACK_RETURNED_TRANSACTION     = NTSTATUS(0xc000071d),
    STATUS_CALLBACK_RETURNED_LDR_LOCK        = NTSTATUS(0xc000071e),
    STATUS_CALLBACK_RETURNED_LANG            = NTSTATUS(0xc000071f),
    STATUS_CALLBACK_RETURNED_PRI_BACK        = NTSTATUS(0xc0000720),
    STATUS_CALLBACK_RETURNED_THREAD_AFFINITY = NTSTATUS(0xc0000721),
}

enum NTSTATUS STATUS_LPC_HANDLE_COUNT_EXCEEDED = NTSTATUS(0xc0000722);
enum NTSTATUS STATUS_EXECUTABLE_MEMORY_WRITE = NTSTATUS(0xc0000723);
enum NTSTATUS STATUS_KERNEL_EXECUTABLE_MEMORY_WRITE = NTSTATUS(0xc0000724);
enum NTSTATUS STATUS_ATTACHED_EXECUTABLE_MEMORY_WRITE = NTSTATUS(0xc0000725);
enum NTSTATUS STATUS_TRIGGERED_EXECUTABLE_MEMORY_WRITE = NTSTATUS(0xc0000726);
enum NTSTATUS STATUS_DISK_REPAIR_DISABLED = NTSTATUS(0xc0000800);
enum NTSTATUS STATUS_DS_DOMAIN_RENAME_IN_PROGRESS = NTSTATUS(0xc0000801);
enum NTSTATUS STATUS_DISK_QUOTA_EXCEEDED = NTSTATUS(0xc0000802);
enum NTSTATUS STATUS_DATA_LOST_REPAIR = NTSTATUS(0x80000803);
enum NTSTATUS STATUS_CONTENT_BLOCKED = NTSTATUS(0xc0000804);
enum NTSTATUS STATUS_BAD_CLUSTERS = NTSTATUS(0xc0000805);
enum NTSTATUS STATUS_VOLUME_DIRTY = NTSTATUS(0xc0000806);

enum : NTSTATUS
{
    STATUS_DISK_REPAIR_REDIRECTED   = NTSTATUS(0x40000807),
    STATUS_DISK_REPAIR_UNSUCCESSFUL = NTSTATUS(0xc0000808),
}

enum : NTSTATUS
{
    STATUS_CORRUPT_LOG_OVERFULL     = NTSTATUS(0xc0000809),
    STATUS_CORRUPT_LOG_CORRUPTED    = NTSTATUS(0xc000080a),
    STATUS_CORRUPT_LOG_UNAVAILABLE  = NTSTATUS(0xc000080b),
    STATUS_CORRUPT_LOG_DELETED_FULL = NTSTATUS(0xc000080c),
    STATUS_CORRUPT_LOG_CLEARED      = NTSTATUS(0xc000080d),
}

enum NTSTATUS STATUS_ORPHAN_NAME_EXHAUSTED = NTSTATUS(0xc000080e);
enum NTSTATUS STATUS_PROACTIVE_SCAN_IN_PROGRESS = NTSTATUS(0xc000080f);
enum NTSTATUS STATUS_ENCRYPTED_IO_NOT_POSSIBLE = NTSTATUS(0xc0000810);
enum NTSTATUS STATUS_CORRUPT_LOG_UPLEVEL_RECORDS = NTSTATUS(0xc0000811);
enum NTSTATUS STATUS_FILE_CHECKED_OUT = NTSTATUS(0xc0000901);
enum NTSTATUS STATUS_CHECKOUT_REQUIRED = NTSTATUS(0xc0000902);
enum NTSTATUS STATUS_BAD_FILE_TYPE = NTSTATUS(0xc0000903);
enum NTSTATUS STATUS_FILE_TOO_LARGE = NTSTATUS(0xc0000904);
enum NTSTATUS STATUS_FORMS_AUTH_REQUIRED = NTSTATUS(0xc0000905);

enum : NTSTATUS
{
    STATUS_VIRUS_INFECTED = NTSTATUS(0xc0000906),
    STATUS_VIRUS_DELETED  = NTSTATUS(0xc0000907),
}

enum NTSTATUS STATUS_BAD_MCFG_TABLE = NTSTATUS(0xc0000908);
enum NTSTATUS STATUS_CANNOT_BREAK_OPLOCK = NTSTATUS(0xc0000909);

enum : NTSTATUS
{
    STATUS_BAD_KEY             = NTSTATUS(0xc000090a),
    STATUS_BAD_DATA            = NTSTATUS(0xc000090b),
    STATUS_NO_KEY              = NTSTATUS(0xc000090c),
    STATUS_FILE_HANDLE_REVOKED = NTSTATUS(0xc0000910),
}

enum NTSTATUS STATUS_SECTION_DIRECT_MAP_ONLY = NTSTATUS(0xc0000911);
enum NTSTATUS STATUS_BLOCK_WEAK_REFERENCE_INVALID = NTSTATUS(0xc0000912);
enum NTSTATUS STATUS_BLOCK_SOURCE_WEAK_REFERENCE_INVALID = NTSTATUS(0xc0000913);
enum NTSTATUS STATUS_BLOCK_TARGET_WEAK_REFERENCE_INVALID = NTSTATUS(0xc0000914);
enum NTSTATUS STATUS_BLOCK_SHARED = NTSTATUS(0xc0000915);
enum NTSTATUS STATUS_SYSTEM_FILE_NOT_SUPPORTED = NTSTATUS(0xc0000916);

enum : NTSTATUS
{
    STATUS_VRF_VOLATILE_CFG_AND_IO_ENABLED      = NTSTATUS(0xc0000c08),
    STATUS_VRF_VOLATILE_NOT_STOPPABLE           = NTSTATUS(0xc0000c09),
    STATUS_VRF_VOLATILE_SAFE_MODE               = NTSTATUS(0xc0000c0a),
    STATUS_VRF_VOLATILE_NOT_RUNNABLE_SYSTEM     = NTSTATUS(0xc0000c0b),
    STATUS_VRF_VOLATILE_NOT_SUPPORTED_RULECLASS = NTSTATUS(0xc0000c0c),
    STATUS_VRF_VOLATILE_PROTECTED_DRIVER        = NTSTATUS(0xc0000c0d),
    STATUS_VRF_VOLATILE_NMI_REGISTERED          = NTSTATUS(0xc0000c0e),
    STATUS_VRF_VOLATILE_SETTINGS_CONFLICT       = NTSTATUS(0xc0000c0f),
}

enum NTSTATUS STATUS_CAR_LKD_IN_PROGRESS = NTSTATUS(0xc0000c10);
enum NTSTATUS STATUS_DIF_ZERO_SIZE_INFORMATION = NTSTATUS(0xc0000c73);

enum : NTSTATUS
{
    STATUS_DIF_DRIVER_PLUGIN_MISMATCH    = NTSTATUS(0xc0000c74),
    STATUS_DIF_DRIVER_THUNKS_NOT_ALLOWED = NTSTATUS(0xc0000c75),
}

enum NTSTATUS STATUS_DIF_IOCALLBACK_NOT_REPLACED = NTSTATUS(0xc0000c76);
enum NTSTATUS STATUS_DIF_LIVEDUMP_LIMIT_EXCEEDED = NTSTATUS(0xc0000c77);

enum : NTSTATUS
{
    STATUS_DIF_VOLATILE_SECTION_NOT_LOCKED        = NTSTATUS(0xc0000c78),
    STATUS_DIF_VOLATILE_DRIVER_HOTPATCHED         = NTSTATUS(0xc0000c79),
    STATUS_DIF_VOLATILE_INVALID_INFO              = NTSTATUS(0xc0000c7a),
    STATUS_DIF_VOLATILE_DRIVER_IS_NOT_RUNNING     = NTSTATUS(0xc0000c7b),
    STATUS_DIF_VOLATILE_PLUGIN_IS_NOT_RUNNING     = NTSTATUS(0xc0000c7c),
    STATUS_DIF_VOLATILE_PLUGIN_CHANGE_NOT_ALLOWED = NTSTATUS(0xc0000c7d),
    STATUS_DIF_VOLATILE_NOT_ALLOWED               = NTSTATUS(0xc0000c7e),
}

enum NTSTATUS STATUS_DIF_BINDING_API_NOT_FOUND = NTSTATUS(0xc0000c7f);
enum NTSTATUS STATUS_WOW_ASSERTION = NTSTATUS(0xc0009898);
enum NTSTATUS STATUS_INVALID_SIGNATURE = NTSTATUS(0xc000a000);
enum NTSTATUS STATUS_HMAC_NOT_SUPPORTED = NTSTATUS(0xc000a001);
enum NTSTATUS STATUS_AUTH_TAG_MISMATCH = NTSTATUS(0xc000a002);

enum : NTSTATUS
{
    STATUS_INVALID_STATE_TRANSITION    = NTSTATUS(0xc000a003),
    STATUS_INVALID_KERNEL_INFO_VERSION = NTSTATUS(0xc000a004),
    STATUS_INVALID_PEP_INFO_VERSION    = NTSTATUS(0xc000a005),
}

enum NTSTATUS STATUS_HANDLE_REVOKED = NTSTATUS(0xc000a006);
enum NTSTATUS STATUS_EOF_ON_GHOSTED_RANGE = NTSTATUS(0xc000a007);
enum NTSTATUS STATUS_CC_NEEDS_CALLBACK_SECTION_DRAIN = NTSTATUS(0xc000a008);
enum NTSTATUS STATUS_IPSEC_QUEUE_OVERFLOW = NTSTATUS(0xc000a010);
enum NTSTATUS STATUS_ND_QUEUE_OVERFLOW = NTSTATUS(0xc000a011);
enum NTSTATUS STATUS_HOPLIMIT_EXCEEDED = NTSTATUS(0xc000a012);
enum NTSTATUS STATUS_PROTOCOL_NOT_SUPPORTED = NTSTATUS(0xc000a013);
enum NTSTATUS STATUS_FASTPATH_REJECTED = NTSTATUS(0xc000a014);

enum : NTSTATUS
{
    STATUS_LOST_WRITEBEHIND_DATA_NETWORK_DISCONNECTED = NTSTATUS(0xc000a080),
    STATUS_LOST_WRITEBEHIND_DATA_NETWORK_SERVER_ERROR = NTSTATUS(0xc000a081),
    STATUS_LOST_WRITEBEHIND_DATA_LOCAL_DISK_ERROR     = NTSTATUS(0xc000a082),
}

enum : NTSTATUS
{
    STATUS_XML_PARSE_ERROR = NTSTATUS(0xc000a083),
    STATUS_XMLDSIG_ERROR   = NTSTATUS(0xc000a084),
}

enum NTSTATUS STATUS_WRONG_COMPARTMENT = NTSTATUS(0xc000a085);
enum NTSTATUS STATUS_AUTHIP_FAILURE = NTSTATUS(0xc000a086);
enum NTSTATUS STATUS_DS_OID_MAPPED_GROUP_CANT_HAVE_MEMBERS = NTSTATUS(0xc000a087);
enum NTSTATUS STATUS_DS_OID_NOT_FOUND = NTSTATUS(0xc000a088);
enum NTSTATUS STATUS_INCORRECT_ACCOUNT_TYPE = NTSTATUS(0xc000a089);
enum NTSTATUS STATUS_LOCAL_POLICY_MODIFICATION_NOT_SUPPORTED = NTSTATUS(0xc000a08a);
enum NTSTATUS STATUS_POLICY_CONTROLLED_ACCOUNT = NTSTATUS(0xc000a08b);
enum NTSTATUS STATUS_LAPS_LEGACY_SCHEMA_MISSING = NTSTATUS(0xc000a08c);

enum : NTSTATUS
{
    STATUS_LAPS_SCHEMA_MISSING               = NTSTATUS(0xc000a08d),
    STATUS_LAPS_ENCRYPTION_REQUIRES_2016_DFL = NTSTATUS(0xc000a08e),
}

enum NTSTATUS STATUS_LAPS_PROCESS_TERMINATED = NTSTATUS(0x8000a08f);
enum NTSTATUS STATUS_DS_JET_RECORD_TOO_BIG = NTSTATUS(0xc000a090);
enum NTSTATUS STATUS_DS_REPLICA_PAGE_SIZE_MISMATCH = NTSTATUS(0xc000a091);

enum : NTSTATUS
{
    STATUS_HASH_NOT_SUPPORTED = NTSTATUS(0xc000a100),
    STATUS_HASH_NOT_PRESENT   = NTSTATUS(0xc000a101),
}

enum NTSTATUS STATUS_SECONDARY_IC_PROVIDER_NOT_REGISTERED = NTSTATUS(0xc000a121);
enum NTSTATUS STATUS_GPIO_CLIENT_INFORMATION_INVALID = NTSTATUS(0xc000a122);
enum NTSTATUS STATUS_GPIO_VERSION_NOT_SUPPORTED = NTSTATUS(0xc000a123);
enum NTSTATUS STATUS_GPIO_INVALID_REGISTRATION_PACKET = NTSTATUS(0xc000a124);

enum : NTSTATUS
{
    STATUS_GPIO_OPERATION_DENIED          = NTSTATUS(0xc000a125),
    STATUS_GPIO_INCOMPATIBLE_CONNECT_MODE = NTSTATUS(0xc000a126),
}

enum NTSTATUS STATUS_GPIO_INTERRUPT_ALREADY_UNMASKED = NTSTATUS(0x8000a127);
enum NTSTATUS STATUS_CANNOT_SWITCH_RUNLEVEL = NTSTATUS(0xc000a141);
enum NTSTATUS STATUS_INVALID_RUNLEVEL_SETTING = NTSTATUS(0xc000a142);
enum NTSTATUS STATUS_RUNLEVEL_SWITCH_TIMEOUT = NTSTATUS(0xc000a143);
enum NTSTATUS STATUS_SERVICES_FAILED_AUTOSTART = NTSTATUS(0x4000a144);

enum : NTSTATUS
{
    STATUS_RUNLEVEL_SWITCH_AGENT_TIMEOUT = NTSTATUS(0xc000a145),
    STATUS_RUNLEVEL_SWITCH_IN_PROGRESS   = NTSTATUS(0xc000a146),
}

enum : NTSTATUS
{
    STATUS_APISET_COMPOSE_FAILURE              = NTSTATUS(0xc000a161),
    STATUS_APISET_SCHEMA_VERSION_NOT_SUPPORTED = NTSTATUS(0xc000a162),
}

enum : NTSTATUS
{
    STATUS_NOT_APPCONTAINER              = NTSTATUS(0xc000a200),
    STATUS_NOT_SUPPORTED_IN_APPCONTAINER = NTSTATUS(0xc000a201),
}

enum NTSTATUS STATUS_INVALID_PACKAGE_SID_LENGTH = NTSTATUS(0xc000a202);
enum NTSTATUS STATUS_LPAC_ACCESS_DENIED = NTSTATUS(0xc000a203);
enum NTSTATUS STATUS_ADMINLESS_ACCESS_DENIED = NTSTATUS(0xc000a204);

enum : NTSTATUS
{
    STATUS_APP_DATA_NOT_FOUND       = NTSTATUS(0xc000a281),
    STATUS_APP_DATA_EXPIRED         = NTSTATUS(0xc000a282),
    STATUS_APP_DATA_CORRUPT         = NTSTATUS(0xc000a283),
    STATUS_APP_DATA_LIMIT_EXCEEDED  = NTSTATUS(0xc000a284),
    STATUS_APP_DATA_REBOOT_REQUIRED = NTSTATUS(0xc000a285),
}

enum : NTSTATUS
{
    STATUS_OFFLOAD_READ_FLT_NOT_SUPPORTED  = NTSTATUS(0xc000a2a1),
    STATUS_OFFLOAD_WRITE_FLT_NOT_SUPPORTED = NTSTATUS(0xc000a2a2),
}

enum NTSTATUS STATUS_OFFLOAD_READ_FILE_NOT_SUPPORTED = NTSTATUS(0xc000a2a3);
enum NTSTATUS STATUS_OFFLOAD_WRITE_FILE_NOT_SUPPORTED = NTSTATUS(0xc000a2a4);

enum : NTSTATUS
{
    STATUS_WOF_WIM_HEADER_CORRUPT         = NTSTATUS(0xc000a2a5),
    STATUS_WOF_WIM_RESOURCE_TABLE_CORRUPT = NTSTATUS(0xc000a2a6),
}

enum NTSTATUS STATUS_WOF_FILE_RESOURCE_TABLE_CORRUPT = NTSTATUS(0xc000a2a7);

enum : NTSTATUS
{
    STATUS_CIMFS_IMAGE_CORRUPT               = NTSTATUS(0xc000c001),
    STATUS_CIMFS_IMAGE_VERSION_NOT_SUPPORTED = NTSTATUS(0xc000c002),
}

enum : NTSTATUS
{
    STATUS_FILE_SYSTEM_VIRTUALIZATION_UNAVAILABLE       = NTSTATUS(0xc000ce01),
    STATUS_FILE_SYSTEM_VIRTUALIZATION_METADATA_CORRUPT  = NTSTATUS(0xc000ce02),
    STATUS_FILE_SYSTEM_VIRTUALIZATION_BUSY              = NTSTATUS(0xc000ce03),
    STATUS_FILE_SYSTEM_VIRTUALIZATION_PROVIDER_UNKNOWN  = NTSTATUS(0xc000ce04),
    STATUS_FILE_SYSTEM_VIRTUALIZATION_INVALID_OPERATION = NTSTATUS(0xc000ce05),
}

enum : NTSTATUS
{
    STATUS_CLOUD_FILE_SYNC_ROOT_METADATA_CORRUPT     = NTSTATUS(0xc000cf00),
    STATUS_CLOUD_FILE_PROVIDER_NOT_RUNNING           = NTSTATUS(0xc000cf01),
    STATUS_CLOUD_FILE_METADATA_CORRUPT               = NTSTATUS(0xc000cf02),
    STATUS_CLOUD_FILE_METADATA_TOO_LARGE             = NTSTATUS(0xc000cf03),
    STATUS_CLOUD_FILE_PROPERTY_BLOB_TOO_LARGE        = NTSTATUS(0x8000cf04),
    STATUS_CLOUD_FILE_TOO_MANY_PROPERTY_BLOBS        = NTSTATUS(0x8000cf05),
    STATUS_CLOUD_FILE_PROPERTY_VERSION_NOT_SUPPORTED = NTSTATUS(0xc000cf06),
}

enum NTSTATUS STATUS_NOT_A_CLOUD_FILE = NTSTATUS(0xc000cf07);

enum : NTSTATUS
{
    STATUS_CLOUD_FILE_NOT_IN_SYNC             = NTSTATUS(0xc000cf08),
    STATUS_CLOUD_FILE_ALREADY_CONNECTED       = NTSTATUS(0xc000cf09),
    STATUS_CLOUD_FILE_NOT_SUPPORTED           = NTSTATUS(0xc000cf0a),
    STATUS_CLOUD_FILE_INVALID_REQUEST         = NTSTATUS(0xc000cf0b),
    STATUS_CLOUD_FILE_READ_ONLY_VOLUME        = NTSTATUS(0xc000cf0c),
    STATUS_CLOUD_FILE_CONNECTED_PROVIDER_ONLY = NTSTATUS(0xc000cf0d),
    STATUS_CLOUD_FILE_VALIDATION_FAILED       = NTSTATUS(0xc000cf0e),
    STATUS_CLOUD_FILE_AUTHENTICATION_FAILED   = NTSTATUS(0xc000cf0f),
    STATUS_CLOUD_FILE_INSUFFICIENT_RESOURCES  = NTSTATUS(0xc000cf10),
    STATUS_CLOUD_FILE_NETWORK_UNAVAILABLE     = NTSTATUS(0xc000cf11),
    STATUS_CLOUD_FILE_UNSUCCESSFUL            = NTSTATUS(0xc000cf12),
    STATUS_CLOUD_FILE_NOT_UNDER_SYNC_ROOT     = NTSTATUS(0xc000cf13),
    STATUS_CLOUD_FILE_IN_USE                  = NTSTATUS(0xc000cf14),
    STATUS_CLOUD_FILE_PINNED                  = NTSTATUS(0xc000cf15),
    STATUS_CLOUD_FILE_REQUEST_ABORTED         = NTSTATUS(0xc000cf16),
    STATUS_CLOUD_FILE_PROPERTY_CORRUPT        = NTSTATUS(0xc000cf17),
    STATUS_CLOUD_FILE_ACCESS_DENIED           = NTSTATUS(0xc000cf18),
    STATUS_CLOUD_FILE_INCOMPATIBLE_HARDLINKS  = NTSTATUS(0xc000cf19),
    STATUS_CLOUD_FILE_PROPERTY_LOCK_CONFLICT  = NTSTATUS(0xc000cf1a),
    STATUS_CLOUD_FILE_REQUEST_CANCELED        = NTSTATUS(0xc000cf1b),
    STATUS_CLOUD_FILE_PROVIDER_TERMINATED     = NTSTATUS(0xc000cf1d),
}

enum NTSTATUS STATUS_NOT_A_CLOUD_SYNC_ROOT = NTSTATUS(0xc000cf1e);

enum : NTSTATUS
{
    STATUS_CLOUD_FILE_REQUEST_TIMEOUT         = NTSTATUS(0xc000cf1f),
    STATUS_CLOUD_FILE_DEHYDRATION_DISALLOWED  = NTSTATUS(0xc000cf20),
    STATUS_CLOUD_FILE_US_MESSAGE_TIMEOUT      = NTSTATUS(0xc000cf21),
    STATUS_CLOUD_FILE_HYDRATION_NOT_AVAILABLE = NTSTATUS(0xc000cf22),
}

enum : NTSTATUS
{
    STATUS_FILE_SNAP_IN_PROGRESS                = NTSTATUS(0xc000f500),
    STATUS_FILE_SNAP_USER_SECTION_NOT_SUPPORTED = NTSTATUS(0xc000f501),
}

enum : NTSTATUS
{
    STATUS_FILE_SNAP_MODIFY_NOT_SUPPORTED = NTSTATUS(0xc000f502),
    STATUS_FILE_SNAP_IO_NOT_COORDINATED   = NTSTATUS(0xc000f503),
    STATUS_FILE_SNAP_UNEXPECTED_ERROR     = NTSTATUS(0xc000f504),
    STATUS_FILE_SNAP_INVALID_PARAMETER    = NTSTATUS(0xc000f505),
}

enum : NTSTATUS
{
    STATUS_UNIONFS_CANNOT_CROSS_UNION      = NTSTATUS(0xc0ed0001),
    STATUS_UNIONFS_CANNOT_EXIT_UNION       = NTSTATUS(0xc0ed0002),
    STATUS_UNIONFS_CANNOT_PRESERVE_LINK    = NTSTATUS(0xc0ed0003),
    STATUS_UNIONFS_INVALID_TOMBSTONE_STATE = NTSTATUS(0xc0ed0004),
}

enum : NTSTATUS
{
    STATUS_UNIONFS_LAYERS_PRESENT           = NTSTATUS(0xc0ed0005),
    STATUS_UNIONFS_NESTED_LAYER             = NTSTATUS(0xc0ed0006),
    STATUS_UNIONFS_UNION_DUPLICATE_ID       = NTSTATUS(0xc0ed0007),
    STATUS_UNIONFS_INACTIVE_UNION           = NTSTATUS(0xc0ed0008),
    STATUS_UNIONFS_TOO_MANY_LAYERS          = NTSTATUS(0xc0ed0009),
    STATUS_UNIONFS_TOO_LATE                 = NTSTATUS(0xc0ed000a),
    STATUS_UNIONFS_NESTED_UNION             = NTSTATUS(0xc0ed000b),
    STATUS_UNIONFS_NESTED_UNION_NOT_ALLOWED = NTSTATUS(0xc0ed000c),
}

enum NTSTATUS DBG_NO_STATE_CHANGE = NTSTATUS(0xc0010001);
enum NTSTATUS DBG_APP_NOT_IDLE = NTSTATUS(0xc0010002);
enum NTSTATUS RPC_NT_INVALID_STRING_BINDING = NTSTATUS(0xc0020001);
enum NTSTATUS RPC_NT_WRONG_KIND_OF_BINDING = NTSTATUS(0xc0020002);
enum NTSTATUS RPC_NT_INVALID_BINDING = NTSTATUS(0xc0020003);
enum NTSTATUS RPC_NT_PROTSEQ_NOT_SUPPORTED = NTSTATUS(0xc0020004);

enum : NTSTATUS
{
    RPC_NT_INVALID_RPC_PROTSEQ     = NTSTATUS(0xc0020005),
    RPC_NT_INVALID_STRING_UUID     = NTSTATUS(0xc0020006),
    RPC_NT_INVALID_ENDPOINT_FORMAT = NTSTATUS(0xc0020007),
    RPC_NT_INVALID_NET_ADDR        = NTSTATUS(0xc0020008),
}

enum NTSTATUS RPC_NT_NO_ENDPOINT_FOUND = NTSTATUS(0xc0020009);
enum NTSTATUS RPC_NT_INVALID_TIMEOUT = NTSTATUS(0xc002000a);
enum NTSTATUS RPC_NT_OBJECT_NOT_FOUND = NTSTATUS(0xc002000b);
enum NTSTATUS RPC_NT_ALREADY_REGISTERED = NTSTATUS(0xc002000c);
enum NTSTATUS RPC_NT_TYPE_ALREADY_REGISTERED = NTSTATUS(0xc002000d);
enum NTSTATUS RPC_NT_ALREADY_LISTENING = NTSTATUS(0xc002000e);
enum NTSTATUS RPC_NT_NO_PROTSEQS_REGISTERED = NTSTATUS(0xc002000f);
enum NTSTATUS RPC_NT_NOT_LISTENING = NTSTATUS(0xc0020010);

enum : NTSTATUS
{
    RPC_NT_UNKNOWN_MGR_TYPE = NTSTATUS(0xc0020011),
    RPC_NT_UNKNOWN_IF       = NTSTATUS(0xc0020012),
    RPC_NT_NO_BINDINGS      = NTSTATUS(0xc0020013),
    RPC_NT_NO_PROTSEQS      = NTSTATUS(0xc0020014),
}

enum NTSTATUS RPC_NT_CANT_CREATE_ENDPOINT = NTSTATUS(0xc0020015);
enum NTSTATUS RPC_NT_OUT_OF_RESOURCES = NTSTATUS(0xc0020016);

enum : NTSTATUS
{
    RPC_NT_SERVER_UNAVAILABLE = NTSTATUS(0xc0020017),
    RPC_NT_SERVER_TOO_BUSY    = NTSTATUS(0xc0020018),
}

enum NTSTATUS RPC_NT_INVALID_NETWORK_OPTIONS = NTSTATUS(0xc0020019);
enum NTSTATUS RPC_NT_NO_CALL_ACTIVE = NTSTATUS(0xc002001a);

enum : NTSTATUS
{
    RPC_NT_CALL_FAILED     = NTSTATUS(0xc002001b),
    RPC_NT_CALL_FAILED_DNE = NTSTATUS(0xc002001c),
}

enum NTSTATUS RPC_NT_PROTOCOL_ERROR = NTSTATUS(0xc002001d);

enum : NTSTATUS
{
    RPC_NT_UNSUPPORTED_TRANS_SYN = NTSTATUS(0xc002001f),
    RPC_NT_UNSUPPORTED_TYPE      = NTSTATUS(0xc0020021),
}

enum : NTSTATUS
{
    RPC_NT_INVALID_TAG   = NTSTATUS(0xc0020022),
    RPC_NT_INVALID_BOUND = NTSTATUS(0xc0020023),
}

enum NTSTATUS RPC_NT_NO_ENTRY_NAME = NTSTATUS(0xc0020024);
enum NTSTATUS RPC_NT_INVALID_NAME_SYNTAX = NTSTATUS(0xc0020025);
enum NTSTATUS RPC_NT_UNSUPPORTED_NAME_SYNTAX = NTSTATUS(0xc0020026);
enum NTSTATUS RPC_NT_UUID_NO_ADDRESS = NTSTATUS(0xc0020028);
enum NTSTATUS RPC_NT_DUPLICATE_ENDPOINT = NTSTATUS(0xc0020029);
enum NTSTATUS RPC_NT_UNKNOWN_AUTHN_TYPE = NTSTATUS(0xc002002a);
enum NTSTATUS RPC_NT_MAX_CALLS_TOO_SMALL = NTSTATUS(0xc002002b);
enum NTSTATUS RPC_NT_STRING_TOO_LONG = NTSTATUS(0xc002002c);

enum : NTSTATUS
{
    RPC_NT_PROTSEQ_NOT_FOUND    = NTSTATUS(0xc002002d),
    RPC_NT_PROCNUM_OUT_OF_RANGE = NTSTATUS(0xc002002e),
}

enum NTSTATUS RPC_NT_BINDING_HAS_NO_AUTH = NTSTATUS(0xc002002f);

enum : NTSTATUS
{
    RPC_NT_UNKNOWN_AUTHN_SERVICE = NTSTATUS(0xc0020030),
    RPC_NT_UNKNOWN_AUTHN_LEVEL   = NTSTATUS(0xc0020031),
}

enum NTSTATUS RPC_NT_INVALID_AUTH_IDENTITY = NTSTATUS(0xc0020032);
enum NTSTATUS RPC_NT_UNKNOWN_AUTHZ_SERVICE = NTSTATUS(0xc0020033);
enum NTSTATUS EPT_NT_INVALID_ENTRY = NTSTATUS(0xc0020034);
enum NTSTATUS EPT_NT_CANT_PERFORM_OP = NTSTATUS(0xc0020035);
enum NTSTATUS EPT_NT_NOT_REGISTERED = NTSTATUS(0xc0020036);
enum NTSTATUS RPC_NT_NOTHING_TO_EXPORT = NTSTATUS(0xc0020037);

enum : NTSTATUS
{
    RPC_NT_INCOMPLETE_NAME     = NTSTATUS(0xc0020038),
    RPC_NT_INVALID_VERS_OPTION = NTSTATUS(0xc0020039),
}

enum : NTSTATUS
{
    RPC_NT_NO_MORE_MEMBERS         = NTSTATUS(0xc002003a),
    RPC_NT_NOT_ALL_OBJS_UNEXPORTED = NTSTATUS(0xc002003b),
}

enum NTSTATUS RPC_NT_INTERFACE_NOT_FOUND = NTSTATUS(0xc002003c);

enum : NTSTATUS
{
    RPC_NT_ENTRY_ALREADY_EXISTS = NTSTATUS(0xc002003d),
    RPC_NT_ENTRY_NOT_FOUND      = NTSTATUS(0xc002003e),
}

enum NTSTATUS RPC_NT_NAME_SERVICE_UNAVAILABLE = NTSTATUS(0xc002003f);
enum NTSTATUS RPC_NT_INVALID_NAF_ID = NTSTATUS(0xc0020040);
enum NTSTATUS RPC_NT_CANNOT_SUPPORT = NTSTATUS(0xc0020041);
enum NTSTATUS RPC_NT_NO_CONTEXT_AVAILABLE = NTSTATUS(0xc0020042);
enum NTSTATUS RPC_NT_INTERNAL_ERROR = NTSTATUS(0xc0020043);
enum NTSTATUS RPC_NT_ZERO_DIVIDE = NTSTATUS(0xc0020044);
enum NTSTATUS RPC_NT_ADDRESS_ERROR = NTSTATUS(0xc0020045);

enum : NTSTATUS
{
    RPC_NT_FP_DIV_ZERO  = NTSTATUS(0xc0020046),
    RPC_NT_FP_UNDERFLOW = NTSTATUS(0xc0020047),
    RPC_NT_FP_OVERFLOW  = NTSTATUS(0xc0020048),
}

enum NTSTATUS RPC_NT_NO_MORE_ENTRIES = NTSTATUS(0xc0030001);

enum : NTSTATUS
{
    RPC_NT_SS_CHAR_TRANS_OPEN_FAIL  = NTSTATUS(0xc0030002),
    RPC_NT_SS_CHAR_TRANS_SHORT_FILE = NTSTATUS(0xc0030003),
}

enum NTSTATUS RPC_NT_SS_IN_NULL_CONTEXT = NTSTATUS(0xc0030004);

enum : NTSTATUS
{
    RPC_NT_SS_CONTEXT_MISMATCH = NTSTATUS(0xc0030005),
    RPC_NT_SS_CONTEXT_DAMAGED  = NTSTATUS(0xc0030006),
}

enum NTSTATUS RPC_NT_SS_HANDLES_MISMATCH = NTSTATUS(0xc0030007);
enum NTSTATUS RPC_NT_SS_CANNOT_GET_CALL_HANDLE = NTSTATUS(0xc0030008);
enum NTSTATUS RPC_NT_NULL_REF_POINTER = NTSTATUS(0xc0030009);
enum NTSTATUS RPC_NT_ENUM_VALUE_OUT_OF_RANGE = NTSTATUS(0xc003000a);
enum NTSTATUS RPC_NT_BYTE_COUNT_TOO_SMALL = NTSTATUS(0xc003000b);
enum NTSTATUS RPC_NT_BAD_STUB_DATA = NTSTATUS(0xc003000c);
enum NTSTATUS RPC_NT_CALL_IN_PROGRESS = NTSTATUS(0xc0020049);
enum NTSTATUS RPC_NT_NO_MORE_BINDINGS = NTSTATUS(0xc002004a);
enum NTSTATUS RPC_NT_GROUP_MEMBER_NOT_FOUND = NTSTATUS(0xc002004b);
enum NTSTATUS EPT_NT_CANT_CREATE = NTSTATUS(0xc002004c);
enum NTSTATUS RPC_NT_INVALID_OBJECT = NTSTATUS(0xc002004d);
enum NTSTATUS RPC_NT_NO_INTERFACES = NTSTATUS(0xc002004f);
enum NTSTATUS RPC_NT_CALL_CANCELLED = NTSTATUS(0xc0020050);
enum NTSTATUS RPC_NT_BINDING_INCOMPLETE = NTSTATUS(0xc0020051);
enum NTSTATUS RPC_NT_COMM_FAILURE = NTSTATUS(0xc0020052);
enum NTSTATUS RPC_NT_UNSUPPORTED_AUTHN_LEVEL = NTSTATUS(0xc0020053);

enum : NTSTATUS
{
    RPC_NT_NO_PRINC_NAME = NTSTATUS(0xc0020054),
    RPC_NT_NOT_RPC_ERROR = NTSTATUS(0xc0020055),
}

enum NTSTATUS RPC_NT_UUID_LOCAL_ONLY = NTSTATUS(0x40020056);
enum NTSTATUS RPC_NT_SEC_PKG_ERROR = NTSTATUS(0xc0020057);
enum NTSTATUS RPC_NT_NOT_CANCELLED = NTSTATUS(0xc0020058);
enum NTSTATUS RPC_NT_INVALID_ES_ACTION = NTSTATUS(0xc0030059);

enum : NTSTATUS
{
    RPC_NT_WRONG_ES_VERSION   = NTSTATUS(0xc003005a),
    RPC_NT_WRONG_STUB_VERSION = NTSTATUS(0xc003005b),
}

enum : NTSTATUS
{
    RPC_NT_INVALID_PIPE_OBJECT    = NTSTATUS(0xc003005c),
    RPC_NT_INVALID_PIPE_OPERATION = NTSTATUS(0xc003005d),
}

enum NTSTATUS RPC_NT_WRONG_PIPE_VERSION = NTSTATUS(0xc003005e);

enum : NTSTATUS
{
    RPC_NT_PIPE_CLOSED           = NTSTATUS(0xc003005f),
    RPC_NT_PIPE_DISCIPLINE_ERROR = NTSTATUS(0xc0030060),
    RPC_NT_PIPE_EMPTY            = NTSTATUS(0xc0030061),
    RPC_NT_INVALID_ASYNC_HANDLE  = NTSTATUS(0xc0020062),
    RPC_NT_INVALID_ASYNC_CALL    = NTSTATUS(0xc0020063),
}

enum NTSTATUS RPC_NT_PROXY_ACCESS_DENIED = NTSTATUS(0xc0020064);
enum NTSTATUS RPC_NT_COOKIE_AUTH_FAILED = NTSTATUS(0xc0020065);
enum NTSTATUS RPC_NT_SEND_INCOMPLETE = NTSTATUS(0x400200af);

enum : NTSTATUS
{
    STATUS_ACPI_INVALID_OPCODE           = NTSTATUS(0xc0140001),
    STATUS_ACPI_STACK_OVERFLOW           = NTSTATUS(0xc0140002),
    STATUS_ACPI_ASSERT_FAILED            = NTSTATUS(0xc0140003),
    STATUS_ACPI_INVALID_INDEX            = NTSTATUS(0xc0140004),
    STATUS_ACPI_INVALID_ARGUMENT         = NTSTATUS(0xc0140005),
    STATUS_ACPI_FATAL                    = NTSTATUS(0xc0140006),
    STATUS_ACPI_INVALID_SUPERNAME        = NTSTATUS(0xc0140007),
    STATUS_ACPI_INVALID_ARGTYPE          = NTSTATUS(0xc0140008),
    STATUS_ACPI_INVALID_OBJTYPE          = NTSTATUS(0xc0140009),
    STATUS_ACPI_INVALID_TARGETTYPE       = NTSTATUS(0xc014000a),
    STATUS_ACPI_INCORRECT_ARGUMENT_COUNT = NTSTATUS(0xc014000b),
}

enum NTSTATUS STATUS_ACPI_ADDRESS_NOT_MAPPED = NTSTATUS(0xc014000c);

enum : NTSTATUS
{
    STATUS_ACPI_INVALID_EVENTTYPE   = NTSTATUS(0xc014000d),
    STATUS_ACPI_HANDLER_COLLISION   = NTSTATUS(0xc014000e),
    STATUS_ACPI_INVALID_DATA        = NTSTATUS(0xc014000f),
    STATUS_ACPI_INVALID_REGION      = NTSTATUS(0xc0140010),
    STATUS_ACPI_INVALID_ACCESS_SIZE = NTSTATUS(0xc0140011),
}

enum : NTSTATUS
{
    STATUS_ACPI_ACQUIRE_GLOBAL_LOCK = NTSTATUS(0xc0140012),
    STATUS_ACPI_ALREADY_INITIALIZED = NTSTATUS(0xc0140013),
}

enum : NTSTATUS
{
    STATUS_ACPI_NOT_INITIALIZED     = NTSTATUS(0xc0140014),
    STATUS_ACPI_INVALID_MUTEX_LEVEL = NTSTATUS(0xc0140015),
}

enum : NTSTATUS
{
    STATUS_ACPI_MUTEX_NOT_OWNED    = NTSTATUS(0xc0140016),
    STATUS_ACPI_MUTEX_NOT_OWNER    = NTSTATUS(0xc0140017),
    STATUS_ACPI_RS_ACCESS          = NTSTATUS(0xc0140018),
    STATUS_ACPI_INVALID_TABLE      = NTSTATUS(0xc0140019),
    STATUS_ACPI_REG_HANDLER_FAILED = NTSTATUS(0xc0140020),
}

enum NTSTATUS STATUS_ACPI_POWER_REQUEST_FAILED = NTSTATUS(0xc0140021);
enum NTSTATUS STATUS_CTX_WINSTATION_NAME_INVALID = NTSTATUS(0xc00a0001);

enum : NTSTATUS
{
    STATUS_CTX_INVALID_PD          = NTSTATUS(0xc00a0002),
    STATUS_CTX_PD_NOT_FOUND        = NTSTATUS(0xc00a0003),
    STATUS_CTX_CDM_CONNECT         = NTSTATUS(0x400a0004),
    STATUS_CTX_CDM_DISCONNECT      = NTSTATUS(0x400a0005),
    STATUS_CTX_CLOSE_PENDING       = NTSTATUS(0xc00a0006),
    STATUS_CTX_NO_OUTBUF           = NTSTATUS(0xc00a0007),
    STATUS_CTX_MODEM_INF_NOT_FOUND = NTSTATUS(0xc00a0008),
}

enum NTSTATUS STATUS_CTX_INVALID_MODEMNAME = NTSTATUS(0xc00a0009);

enum : NTSTATUS
{
    STATUS_CTX_RESPONSE_ERROR             = NTSTATUS(0xc00a000a),
    STATUS_CTX_MODEM_RESPONSE_TIMEOUT     = NTSTATUS(0xc00a000b),
    STATUS_CTX_MODEM_RESPONSE_NO_CARRIER  = NTSTATUS(0xc00a000c),
    STATUS_CTX_MODEM_RESPONSE_NO_DIALTONE = NTSTATUS(0xc00a000d),
    STATUS_CTX_MODEM_RESPONSE_BUSY        = NTSTATUS(0xc00a000e),
    STATUS_CTX_MODEM_RESPONSE_VOICE       = NTSTATUS(0xc00a000f),
}

enum : NTSTATUS
{
    STATUS_CTX_TD_ERROR                  = NTSTATUS(0xc00a0010),
    STATUS_CTX_LICENSE_CLIENT_INVALID    = NTSTATUS(0xc00a0012),
    STATUS_CTX_LICENSE_NOT_AVAILABLE     = NTSTATUS(0xc00a0013),
    STATUS_CTX_LICENSE_EXPIRED           = NTSTATUS(0xc00a0014),
    STATUS_CTX_WINSTATION_NOT_FOUND      = NTSTATUS(0xc00a0015),
    STATUS_CTX_WINSTATION_NAME_COLLISION = NTSTATUS(0xc00a0016),
    STATUS_CTX_WINSTATION_BUSY           = NTSTATUS(0xc00a0017),
    STATUS_CTX_BAD_VIDEO_MODE            = NTSTATUS(0xc00a0018),
    STATUS_CTX_GRAPHICS_INVALID          = NTSTATUS(0xc00a0022),
    STATUS_CTX_NOT_CONSOLE               = NTSTATUS(0xc00a0024),
    STATUS_CTX_CLIENT_QUERY_TIMEOUT      = NTSTATUS(0xc00a0026),
}

enum : NTSTATUS
{
    STATUS_CTX_CONSOLE_DISCONNECT       = NTSTATUS(0xc00a0027),
    STATUS_CTX_CONSOLE_CONNECT          = NTSTATUS(0xc00a0028),
    STATUS_CTX_SHADOW_DENIED            = NTSTATUS(0xc00a002a),
    STATUS_CTX_WINSTATION_ACCESS_DENIED = NTSTATUS(0xc00a002b),
}

enum : NTSTATUS
{
    STATUS_CTX_INVALID_WD      = NTSTATUS(0xc00a002e),
    STATUS_CTX_WD_NOT_FOUND    = NTSTATUS(0xc00a002f),
    STATUS_CTX_SHADOW_INVALID  = NTSTATUS(0xc00a0030),
    STATUS_CTX_SHADOW_DISABLED = NTSTATUS(0xc00a0031),
}

enum NTSTATUS STATUS_RDP_PROTOCOL_ERROR = NTSTATUS(0xc00a0032);

enum : NTSTATUS
{
    STATUS_CTX_CLIENT_LICENSE_NOT_SET = NTSTATUS(0xc00a0033),
    STATUS_CTX_CLIENT_LICENSE_IN_USE  = NTSTATUS(0xc00a0034),
}

enum : NTSTATUS
{
    STATUS_CTX_SHADOW_ENDED_BY_MODE_CHANGE = NTSTATUS(0xc00a0035),
    STATUS_CTX_SHADOW_NOT_RUNNING          = NTSTATUS(0xc00a0036),
}

enum : NTSTATUS
{
    STATUS_CTX_LOGON_DISABLED       = NTSTATUS(0xc00a0037),
    STATUS_CTX_SECURITY_LAYER_ERROR = NTSTATUS(0xc00a0038),
}

enum NTSTATUS STATUS_TS_INCOMPATIBLE_SESSIONS = NTSTATUS(0xc00a0039);
enum NTSTATUS STATUS_TS_VIDEO_SUBSYSTEM_ERROR = NTSTATUS(0xc00a003a);

enum : NTSTATUS
{
    STATUS_PNP_BAD_MPS_TABLE      = NTSTATUS(0xc0040035),
    STATUS_PNP_TRANSLATION_FAILED = NTSTATUS(0xc0040036),
}

enum NTSTATUS STATUS_PNP_IRQ_TRANSLATION_FAILED = NTSTATUS(0xc0040037);
enum NTSTATUS STATUS_PNP_INVALID_ID = NTSTATUS(0xc0040038);
enum NTSTATUS STATUS_IO_REISSUE_AS_CACHED = NTSTATUS(0xc0040039);

enum : NTSTATUS
{
    STATUS_MUI_FILE_NOT_FOUND                = NTSTATUS(0xc00b0001),
    STATUS_MUI_INVALID_FILE                  = NTSTATUS(0xc00b0002),
    STATUS_MUI_INVALID_RC_CONFIG             = NTSTATUS(0xc00b0003),
    STATUS_MUI_INVALID_LOCALE_NAME           = NTSTATUS(0xc00b0004),
    STATUS_MUI_INVALID_ULTIMATEFALLBACK_NAME = NTSTATUS(0xc00b0005),
}

enum NTSTATUS STATUS_MUI_FILE_NOT_LOADED = NTSTATUS(0xc00b0006);
enum NTSTATUS STATUS_RESOURCE_ENUM_USER_STOP = NTSTATUS(0xc00b0007);
enum NTSTATUS STATUS_FLT_NO_HANDLER_DEFINED = NTSTATUS(0xc01c0001);
enum NTSTATUS STATUS_FLT_CONTEXT_ALREADY_DEFINED = NTSTATUS(0xc01c0002);
enum NTSTATUS STATUS_FLT_INVALID_ASYNCHRONOUS_REQUEST = NTSTATUS(0xc01c0003);
enum NTSTATUS STATUS_FLT_DISALLOW_FAST_IO = NTSTATUS(0xc01c0004);
enum int STATUS_FLT_DISALLOW_FSFILTER_IO = 0xc01c0004;
enum NTSTATUS STATUS_FLT_INVALID_NAME_REQUEST = NTSTATUS(0xc01c0005);

enum : NTSTATUS
{
    STATUS_FLT_NOT_SAFE_TO_POST_OPERATION = NTSTATUS(0xc01c0006),
    STATUS_FLT_NOT_INITIALIZED            = NTSTATUS(0xc01c0007),
    STATUS_FLT_FILTER_NOT_READY           = NTSTATUS(0xc01c0008),
    STATUS_FLT_POST_OPERATION_CLEANUP     = NTSTATUS(0xc01c0009),
}

enum : NTSTATUS
{
    STATUS_FLT_INTERNAL_ERROR        = NTSTATUS(0xc01c000a),
    STATUS_FLT_DELETING_OBJECT       = NTSTATUS(0xc01c000b),
    STATUS_FLT_MUST_BE_NONPAGED_POOL = NTSTATUS(0xc01c000c),
}

enum : NTSTATUS
{
    STATUS_FLT_DUPLICATE_ENTRY             = NTSTATUS(0xc01c000d),
    STATUS_FLT_CBDQ_DISABLED               = NTSTATUS(0xc01c000e),
    STATUS_FLT_DO_NOT_ATTACH               = NTSTATUS(0xc01c000f),
    STATUS_FLT_DO_NOT_DETACH               = NTSTATUS(0xc01c0010),
    STATUS_FLT_INSTANCE_ALTITUDE_COLLISION = NTSTATUS(0xc01c0011),
    STATUS_FLT_INSTANCE_NAME_COLLISION     = NTSTATUS(0xc01c0012),
}

enum : NTSTATUS
{
    STATUS_FLT_FILTER_NOT_FOUND   = NTSTATUS(0xc01c0013),
    STATUS_FLT_VOLUME_NOT_FOUND   = NTSTATUS(0xc01c0014),
    STATUS_FLT_INSTANCE_NOT_FOUND = NTSTATUS(0xc01c0015),
}

enum NTSTATUS STATUS_FLT_CONTEXT_ALLOCATION_NOT_FOUND = NTSTATUS(0xc01c0016);
enum NTSTATUS STATUS_FLT_INVALID_CONTEXT_REGISTRATION = NTSTATUS(0xc01c0017);

enum : NTSTATUS
{
    STATUS_FLT_NAME_CACHE_MISS        = NTSTATUS(0xc01c0018),
    STATUS_FLT_NO_DEVICE_OBJECT       = NTSTATUS(0xc01c0019),
    STATUS_FLT_VOLUME_ALREADY_MOUNTED = NTSTATUS(0xc01c001a),
}

enum : NTSTATUS
{
    STATUS_FLT_ALREADY_ENLISTED       = NTSTATUS(0xc01c001b),
    STATUS_FLT_CONTEXT_ALREADY_LINKED = NTSTATUS(0xc01c001c),
}

enum NTSTATUS STATUS_FLT_NO_WAITER_FOR_REPLY = NTSTATUS(0xc01c0020);
enum NTSTATUS STATUS_FLT_REGISTRATION_BUSY = NTSTATUS(0xc01c0023);
enum NTSTATUS STATUS_FLT_WCOS_NOT_SUPPORTED = NTSTATUS(0xc01c0024);
enum NTSTATUS STATUS_SXS_SECTION_NOT_FOUND = NTSTATUS(0xc0150001);

enum : NTSTATUS
{
    STATUS_SXS_CANT_GEN_ACTCTX           = NTSTATUS(0xc0150002),
    STATUS_SXS_INVALID_ACTCTXDATA_FORMAT = NTSTATUS(0xc0150003),
}

enum NTSTATUS STATUS_SXS_ASSEMBLY_NOT_FOUND = NTSTATUS(0xc0150004);

enum : NTSTATUS
{
    STATUS_SXS_MANIFEST_FORMAT_ERROR = NTSTATUS(0xc0150005),
    STATUS_SXS_MANIFEST_PARSE_ERROR  = NTSTATUS(0xc0150006),
}

enum NTSTATUS STATUS_SXS_ACTIVATION_CONTEXT_DISABLED = NTSTATUS(0xc0150007);

enum : NTSTATUS
{
    STATUS_SXS_KEY_NOT_FOUND      = NTSTATUS(0xc0150008),
    STATUS_SXS_VERSION_CONFLICT   = NTSTATUS(0xc0150009),
    STATUS_SXS_WRONG_SECTION_TYPE = NTSTATUS(0xc015000a),
}

enum NTSTATUS STATUS_SXS_THREAD_QUERIES_DISABLED = NTSTATUS(0xc015000b);

enum : NTSTATUS
{
    STATUS_SXS_ASSEMBLY_MISSING           = NTSTATUS(0xc015000c),
    STATUS_SXS_RELEASE_ACTIVATION_CONTEXT = NTSTATUS(0x4015000d),
}

enum NTSTATUS STATUS_SXS_PROCESS_DEFAULT_ALREADY_SET = NTSTATUS(0xc015000e);
enum NTSTATUS STATUS_SXS_EARLY_DEACTIVATION = NTSTATUS(0xc015000f);
enum NTSTATUS STATUS_SXS_INVALID_DEACTIVATION = NTSTATUS(0xc0150010);
enum NTSTATUS STATUS_SXS_MULTIPLE_DEACTIVATION = NTSTATUS(0xc0150011);
enum NTSTATUS STATUS_SXS_SYSTEM_DEFAULT_ACTIVATION_CONTEXT_EMPTY = NTSTATUS(0xc0150012);
enum NTSTATUS STATUS_SXS_PROCESS_TERMINATION_REQUESTED = NTSTATUS(0xc0150013);

enum : NTSTATUS
{
    STATUS_SXS_CORRUPT_ACTIVATION_STACK         = NTSTATUS(0xc0150014),
    STATUS_SXS_CORRUPTION                       = NTSTATUS(0xc0150015),
    STATUS_SXS_INVALID_IDENTITY_ATTRIBUTE_VALUE = NTSTATUS(0xc0150016),
    STATUS_SXS_INVALID_IDENTITY_ATTRIBUTE_NAME  = NTSTATUS(0xc0150017),
}

enum : NTSTATUS
{
    STATUS_SXS_IDENTITY_DUPLICATE_ATTRIBUTE = NTSTATUS(0xc0150018),
    STATUS_SXS_IDENTITY_PARSE_ERROR         = NTSTATUS(0xc0150019),
}

enum NTSTATUS STATUS_SXS_COMPONENT_STORE_CORRUPT = NTSTATUS(0xc015001a);
enum NTSTATUS STATUS_SXS_FILE_HASH_MISMATCH = NTSTATUS(0xc015001b);
enum NTSTATUS STATUS_SXS_MANIFEST_IDENTITY_SAME_BUT_CONTENTS_DIFFERENT = NTSTATUS(0xc015001c);
enum NTSTATUS STATUS_SXS_IDENTITIES_DIFFERENT = NTSTATUS(0xc015001d);
enum NTSTATUS STATUS_SXS_ASSEMBLY_IS_NOT_A_DEPLOYMENT = NTSTATUS(0xc015001e);
enum NTSTATUS STATUS_SXS_FILE_NOT_PART_OF_ASSEMBLY = NTSTATUS(0xc015001f);
enum NTSTATUS STATUS_ADVANCED_INSTALLER_FAILED = NTSTATUS(0xc0150020);
enum NTSTATUS STATUS_XML_ENCODING_MISMATCH = NTSTATUS(0xc0150021);

enum : NTSTATUS
{
    STATUS_SXS_MANIFEST_TOO_BIG       = NTSTATUS(0xc0150022),
    STATUS_SXS_SETTING_NOT_REGISTERED = NTSTATUS(0xc0150023),
}

enum NTSTATUS STATUS_SXS_TRANSACTION_CLOSURE_INCOMPLETE = NTSTATUS(0xc0150024);
enum NTSTATUS STATUS_SMI_PRIMITIVE_INSTALLER_FAILED = NTSTATUS(0xc0150025);
enum NTSTATUS STATUS_GENERIC_COMMAND_FAILED = NTSTATUS(0xc0150026);
enum NTSTATUS STATUS_SXS_FILE_HASH_MISSING = NTSTATUS(0xc0150027);

enum : NTSTATUS
{
    STATUS_CLUSTER_INVALID_NODE             = NTSTATUS(0xc0130001),
    STATUS_CLUSTER_NODE_EXISTS              = NTSTATUS(0xc0130002),
    STATUS_CLUSTER_JOIN_IN_PROGRESS         = NTSTATUS(0xc0130003),
    STATUS_CLUSTER_NODE_NOT_FOUND           = NTSTATUS(0xc0130004),
    STATUS_CLUSTER_LOCAL_NODE_NOT_FOUND     = NTSTATUS(0xc0130005),
    STATUS_CLUSTER_NETWORK_EXISTS           = NTSTATUS(0xc0130006),
    STATUS_CLUSTER_NETWORK_NOT_FOUND        = NTSTATUS(0xc0130007),
    STATUS_CLUSTER_NETINTERFACE_EXISTS      = NTSTATUS(0xc0130008),
    STATUS_CLUSTER_NETINTERFACE_NOT_FOUND   = NTSTATUS(0xc0130009),
    STATUS_CLUSTER_INVALID_REQUEST          = NTSTATUS(0xc013000a),
    STATUS_CLUSTER_INVALID_NETWORK_PROVIDER = NTSTATUS(0xc013000b),
}

enum : NTSTATUS
{
    STATUS_CLUSTER_NODE_DOWN                         = NTSTATUS(0xc013000c),
    STATUS_CLUSTER_NODE_UNREACHABLE                  = NTSTATUS(0xc013000d),
    STATUS_CLUSTER_NODE_NOT_MEMBER                   = NTSTATUS(0xc013000e),
    STATUS_CLUSTER_JOIN_NOT_IN_PROGRESS              = NTSTATUS(0xc013000f),
    STATUS_CLUSTER_INVALID_NETWORK                   = NTSTATUS(0xc0130010),
    STATUS_CLUSTER_NO_NET_ADAPTERS                   = NTSTATUS(0xc0130011),
    STATUS_CLUSTER_NODE_UP                           = NTSTATUS(0xc0130012),
    STATUS_CLUSTER_NODE_PAUSED                       = NTSTATUS(0xc0130013),
    STATUS_CLUSTER_NODE_NOT_PAUSED                   = NTSTATUS(0xc0130014),
    STATUS_CLUSTER_NO_SECURITY_CONTEXT               = NTSTATUS(0xc0130015),
    STATUS_CLUSTER_NETWORK_NOT_INTERNAL              = NTSTATUS(0xc0130016),
    STATUS_CLUSTER_POISONED                          = NTSTATUS(0xc0130017),
    STATUS_CLUSTER_NON_CSV_PATH                      = NTSTATUS(0xc0130018),
    STATUS_CLUSTER_CSV_VOLUME_NOT_LOCAL              = NTSTATUS(0xc0130019),
    STATUS_CLUSTER_CSV_READ_OPLOCK_BREAK_IN_PROGRESS = NTSTATUS(0xc0130020),
}

enum : NTSTATUS
{
    STATUS_CLUSTER_CSV_AUTO_PAUSE_ERROR              = NTSTATUS(0xc0130021),
    STATUS_CLUSTER_CSV_REDIRECTED                    = NTSTATUS(0xc0130022),
    STATUS_CLUSTER_CSV_NOT_REDIRECTED                = NTSTATUS(0xc0130023),
    STATUS_CLUSTER_CSV_VOLUME_DRAINING               = NTSTATUS(0xc0130024),
    STATUS_CLUSTER_CSV_SNAPSHOT_CREATION_IN_PROGRESS = NTSTATUS(0xc0130025),
}

enum NTSTATUS STATUS_CLUSTER_CSV_VOLUME_DRAINING_SUCCEEDED_DOWNLEVEL = NTSTATUS(0xc0130026);
enum NTSTATUS STATUS_CLUSTER_CSV_NO_SNAPSHOTS = NTSTATUS(0xc0130027);
enum NTSTATUS STATUS_CSV_IO_PAUSE_TIMEOUT = NTSTATUS(0xc0130028);

enum : NTSTATUS
{
    STATUS_CLUSTER_CSV_INVALID_HANDLE                = NTSTATUS(0xc0130029),
    STATUS_CLUSTER_CSV_SUPPORTED_ONLY_ON_COORDINATOR = NTSTATUS(0xc0130030),
}

enum NTSTATUS STATUS_CLUSTER_CAM_TICKET_REPLAY_DETECTED = NTSTATUS(0xc0130031);
enum NTSTATUS STATUS_TRANSACTIONAL_CONFLICT = NTSTATUS(0xc0190001);
enum NTSTATUS STATUS_INVALID_TRANSACTION = NTSTATUS(0xc0190002);
enum NTSTATUS STATUS_TRANSACTION_NOT_ACTIVE = NTSTATUS(0xc0190003);
enum NTSTATUS STATUS_TM_INITIALIZATION_FAILED = NTSTATUS(0xc0190004);

enum : NTSTATUS
{
    STATUS_RM_NOT_ACTIVE       = NTSTATUS(0xc0190005),
    STATUS_RM_METADATA_CORRUPT = NTSTATUS(0xc0190006),
}

enum NTSTATUS STATUS_TRANSACTION_NOT_JOINED = NTSTATUS(0xc0190007);
enum NTSTATUS STATUS_DIRECTORY_NOT_RM = NTSTATUS(0xc0190008);
enum NTSTATUS STATUS_COULD_NOT_RESIZE_LOG = NTSTATUS(0x80190009);
enum NTSTATUS STATUS_TRANSACTIONS_UNSUPPORTED_REMOTE = NTSTATUS(0xc019000a);
enum NTSTATUS STATUS_LOG_RESIZE_INVALID_SIZE = NTSTATUS(0xc019000b);
enum NTSTATUS STATUS_REMOTE_FILE_VERSION_MISMATCH = NTSTATUS(0xc019000c);
enum NTSTATUS STATUS_CRM_PROTOCOL_ALREADY_EXISTS = NTSTATUS(0xc019000f);
enum NTSTATUS STATUS_TRANSACTION_PROPAGATION_FAILED = NTSTATUS(0xc0190010);
enum NTSTATUS STATUS_CRM_PROTOCOL_NOT_FOUND = NTSTATUS(0xc0190011);

enum : NTSTATUS
{
    STATUS_TRANSACTION_SUPERIOR_EXISTS         = NTSTATUS(0xc0190012),
    STATUS_TRANSACTION_REQUEST_NOT_VALID       = NTSTATUS(0xc0190013),
    STATUS_TRANSACTION_NOT_REQUESTED           = NTSTATUS(0xc0190014),
    STATUS_TRANSACTION_ALREADY_ABORTED         = NTSTATUS(0xc0190015),
    STATUS_TRANSACTION_ALREADY_COMMITTED       = NTSTATUS(0xc0190016),
    STATUS_TRANSACTION_INVALID_MARSHALL_BUFFER = NTSTATUS(0xc0190017),
}

enum NTSTATUS STATUS_CURRENT_TRANSACTION_NOT_VALID = NTSTATUS(0xc0190018);
enum NTSTATUS STATUS_LOG_GROWTH_FAILED = NTSTATUS(0xc0190019);
enum NTSTATUS STATUS_OBJECT_NO_LONGER_EXISTS = NTSTATUS(0xc0190021);

enum : NTSTATUS
{
    STATUS_STREAM_MINIVERSION_NOT_FOUND = NTSTATUS(0xc0190022),
    STATUS_STREAM_MINIVERSION_NOT_VALID = NTSTATUS(0xc0190023),
}

enum NTSTATUS STATUS_MINIVERSION_INACCESSIBLE_FROM_SPECIFIED_TRANSACTION = NTSTATUS(0xc0190024);
enum NTSTATUS STATUS_CANT_OPEN_MINIVERSION_WITH_MODIFY_INTENT = NTSTATUS(0xc0190025);
enum NTSTATUS STATUS_CANT_CREATE_MORE_STREAM_MINIVERSIONS = NTSTATUS(0xc0190026);
enum NTSTATUS STATUS_HANDLE_NO_LONGER_VALID = NTSTATUS(0xc0190028);
enum NTSTATUS STATUS_NO_TXF_METADATA = NTSTATUS(0x80190029);
enum NTSTATUS STATUS_LOG_CORRUPTION_DETECTED = NTSTATUS(0xc0190030);
enum NTSTATUS STATUS_CANT_RECOVER_WITH_HANDLE_OPEN = NTSTATUS(0x80190031);
enum NTSTATUS STATUS_RM_DISCONNECTED = NTSTATUS(0xc0190032);
enum NTSTATUS STATUS_ENLISTMENT_NOT_SUPERIOR = NTSTATUS(0xc0190033);
enum NTSTATUS STATUS_RECOVERY_NOT_NEEDED = NTSTATUS(0x40190034);
enum NTSTATUS STATUS_RM_ALREADY_STARTED = NTSTATUS(0x40190035);
enum NTSTATUS STATUS_FILE_IDENTITY_NOT_PERSISTENT = NTSTATUS(0xc0190036);
enum NTSTATUS STATUS_CANT_BREAK_TRANSACTIONAL_DEPENDENCY = NTSTATUS(0xc0190037);
enum NTSTATUS STATUS_CANT_CROSS_RM_BOUNDARY = NTSTATUS(0xc0190038);
enum NTSTATUS STATUS_TXF_DIR_NOT_EMPTY = NTSTATUS(0xc0190039);
enum NTSTATUS STATUS_INDOUBT_TRANSACTIONS_EXIST = NTSTATUS(0xc019003a);
enum NTSTATUS STATUS_TM_VOLATILE = NTSTATUS(0xc019003b);
enum NTSTATUS STATUS_ROLLBACK_TIMER_EXPIRED = NTSTATUS(0xc019003c);
enum NTSTATUS STATUS_TXF_ATTRIBUTE_CORRUPT = NTSTATUS(0xc019003d);
enum NTSTATUS STATUS_EFS_NOT_ALLOWED_IN_TRANSACTION = NTSTATUS(0xc019003e);

enum : NTSTATUS
{
    STATUS_TRANSACTIONAL_OPEN_NOT_ALLOWED        = NTSTATUS(0xc019003f),
    STATUS_TRANSACTED_MAPPING_UNSUPPORTED_REMOTE = NTSTATUS(0xc0190040),
}

enum NTSTATUS STATUS_TXF_METADATA_ALREADY_PRESENT = NTSTATUS(0x80190041);

enum : NTSTATUS
{
    STATUS_TRANSACTION_SCOPE_CALLBACKS_NOT_SET = NTSTATUS(0x80190042),
    STATUS_TRANSACTION_REQUIRED_PROMOTION      = NTSTATUS(0xc0190043),
}

enum NTSTATUS STATUS_CANNOT_EXECUTE_FILE_IN_TRANSACTION = NTSTATUS(0xc0190044);

enum : NTSTATUS
{
    STATUS_TRANSACTIONS_NOT_FROZEN        = NTSTATUS(0xc0190045),
    STATUS_TRANSACTION_FREEZE_IN_PROGRESS = NTSTATUS(0xc0190046),
}

enum NTSTATUS STATUS_NOT_SNAPSHOT_VOLUME = NTSTATUS(0xc0190047);
enum NTSTATUS STATUS_NO_SAVEPOINT_WITH_OPEN_FILES = NTSTATUS(0xc0190048);
enum NTSTATUS STATUS_SPARSE_NOT_ALLOWED_IN_TRANSACTION = NTSTATUS(0xc0190049);
enum NTSTATUS STATUS_TM_IDENTITY_MISMATCH = NTSTATUS(0xc019004a);
enum NTSTATUS STATUS_FLOATED_SECTION = NTSTATUS(0xc019004b);

enum : NTSTATUS
{
    STATUS_CANNOT_ACCEPT_TRANSACTED_WORK = NTSTATUS(0xc019004c),
    STATUS_CANNOT_ABORT_TRANSACTIONS     = NTSTATUS(0xc019004d),
}

enum NTSTATUS STATUS_TRANSACTION_NOT_FOUND = NTSTATUS(0xc019004e);
enum NTSTATUS STATUS_RESOURCEMANAGER_NOT_FOUND = NTSTATUS(0xc019004f);
enum NTSTATUS STATUS_ENLISTMENT_NOT_FOUND = NTSTATUS(0xc0190050);

enum : NTSTATUS
{
    STATUS_TRANSACTIONMANAGER_NOT_FOUND               = NTSTATUS(0xc0190051),
    STATUS_TRANSACTIONMANAGER_NOT_ONLINE              = NTSTATUS(0xc0190052),
    STATUS_TRANSACTIONMANAGER_RECOVERY_NAME_COLLISION = NTSTATUS(0xc0190053),
}

enum : NTSTATUS
{
    STATUS_TRANSACTION_NOT_ROOT       = NTSTATUS(0xc0190054),
    STATUS_TRANSACTION_OBJECT_EXPIRED = NTSTATUS(0xc0190055),
}

enum NTSTATUS STATUS_COMPRESSION_NOT_ALLOWED_IN_TRANSACTION = NTSTATUS(0xc0190056);

enum : NTSTATUS
{
    STATUS_TRANSACTION_RESPONSE_NOT_ENLISTED = NTSTATUS(0xc0190057),
    STATUS_TRANSACTION_RECORD_TOO_LONG       = NTSTATUS(0xc0190058),
}

enum NTSTATUS STATUS_NO_LINK_TRACKING_IN_TRANSACTION = NTSTATUS(0xc0190059);
enum NTSTATUS STATUS_OPERATION_NOT_SUPPORTED_IN_TRANSACTION = NTSTATUS(0xc019005a);

enum : NTSTATUS
{
    STATUS_TRANSACTION_INTEGRITY_VIOLATED       = NTSTATUS(0xc019005b),
    STATUS_TRANSACTIONMANAGER_IDENTITY_MISMATCH = NTSTATUS(0xc019005c),
}

enum NTSTATUS STATUS_RM_CANNOT_BE_FROZEN_FOR_SNAPSHOT = NTSTATUS(0xc019005d);

enum : NTSTATUS
{
    STATUS_TRANSACTION_MUST_WRITETHROUGH = NTSTATUS(0xc019005e),
    STATUS_TRANSACTION_NO_SUPERIOR       = NTSTATUS(0xc019005f),
}

enum NTSTATUS STATUS_EXPIRED_HANDLE = NTSTATUS(0xc0190060);
enum NTSTATUS STATUS_TRANSACTION_NOT_ENLISTED = NTSTATUS(0xc0190061);
enum NTSTATUS STATUS_ENLISTMENT_NOT_INITIALIZED = NTSTATUS(0xc0190062);

enum : NTSTATUS
{
    STATUS_LOG_SECTOR_INVALID        = NTSTATUS(0xc01a0001),
    STATUS_LOG_SECTOR_PARITY_INVALID = NTSTATUS(0xc01a0002),
    STATUS_LOG_SECTOR_REMAPPED       = NTSTATUS(0xc01a0003),
    STATUS_LOG_BLOCK_INCOMPLETE      = NTSTATUS(0xc01a0004),
    STATUS_LOG_INVALID_RANGE         = NTSTATUS(0xc01a0005),
    STATUS_LOG_BLOCKS_EXHAUSTED      = NTSTATUS(0xc01a0006),
    STATUS_LOG_READ_CONTEXT_INVALID  = NTSTATUS(0xc01a0007),
    STATUS_LOG_RESTART_INVALID       = NTSTATUS(0xc01a0008),
    STATUS_LOG_BLOCK_VERSION         = NTSTATUS(0xc01a0009),
    STATUS_LOG_BLOCK_INVALID         = NTSTATUS(0xc01a000a),
    STATUS_LOG_READ_MODE_INVALID     = NTSTATUS(0xc01a000b),
}

enum : NTSTATUS
{
    STATUS_LOG_NO_RESTART            = NTSTATUS(0x401a000c),
    STATUS_LOG_METADATA_CORRUPT      = NTSTATUS(0xc01a000d),
    STATUS_LOG_METADATA_INVALID      = NTSTATUS(0xc01a000e),
    STATUS_LOG_METADATA_INCONSISTENT = NTSTATUS(0xc01a000f),
}

enum NTSTATUS STATUS_LOG_RESERVATION_INVALID = NTSTATUS(0xc01a0010);

enum : NTSTATUS
{
    STATUS_LOG_CANT_DELETE              = NTSTATUS(0xc01a0011),
    STATUS_LOG_CONTAINER_LIMIT_EXCEEDED = NTSTATUS(0xc01a0012),
}

enum : NTSTATUS
{
    STATUS_LOG_START_OF_LOG             = NTSTATUS(0xc01a0013),
    STATUS_LOG_POLICY_ALREADY_INSTALLED = NTSTATUS(0xc01a0014),
    STATUS_LOG_POLICY_NOT_INSTALLED     = NTSTATUS(0xc01a0015),
    STATUS_LOG_POLICY_INVALID           = NTSTATUS(0xc01a0016),
    STATUS_LOG_POLICY_CONFLICT          = NTSTATUS(0xc01a0017),
    STATUS_LOG_PINNED_ARCHIVE_TAIL      = NTSTATUS(0xc01a0018),
}

enum : NTSTATUS
{
    STATUS_LOG_RECORD_NONEXISTENT       = NTSTATUS(0xc01a0019),
    STATUS_LOG_RECORDS_RESERVED_INVALID = NTSTATUS(0xc01a001a),
}

enum NTSTATUS STATUS_LOG_SPACE_RESERVED_INVALID = NTSTATUS(0xc01a001b);

enum : NTSTATUS
{
    STATUS_LOG_TAIL_INVALID            = NTSTATUS(0xc01a001c),
    STATUS_LOG_FULL                    = NTSTATUS(0xc01a001d),
    STATUS_LOG_MULTIPLEXED             = NTSTATUS(0xc01a001e),
    STATUS_LOG_DEDICATED               = NTSTATUS(0xc01a001f),
    STATUS_LOG_ARCHIVE_NOT_IN_PROGRESS = NTSTATUS(0xc01a0020),
    STATUS_LOG_ARCHIVE_IN_PROGRESS     = NTSTATUS(0xc01a0021),
}

enum : NTSTATUS
{
    STATUS_LOG_EPHEMERAL             = NTSTATUS(0xc01a0022),
    STATUS_LOG_NOT_ENOUGH_CONTAINERS = NTSTATUS(0xc01a0023),
}

enum : NTSTATUS
{
    STATUS_LOG_CLIENT_ALREADY_REGISTERED = NTSTATUS(0xc01a0024),
    STATUS_LOG_CLIENT_NOT_REGISTERED     = NTSTATUS(0xc01a0025),
}

enum NTSTATUS STATUS_LOG_FULL_HANDLER_IN_PROGRESS = NTSTATUS(0xc01a0026);

enum : NTSTATUS
{
    STATUS_LOG_CONTAINER_READ_FAILED   = NTSTATUS(0xc01a0027),
    STATUS_LOG_CONTAINER_WRITE_FAILED  = NTSTATUS(0xc01a0028),
    STATUS_LOG_CONTAINER_OPEN_FAILED   = NTSTATUS(0xc01a0029),
    STATUS_LOG_CONTAINER_STATE_INVALID = NTSTATUS(0xc01a002a),
}

enum : NTSTATUS
{
    STATUS_LOG_STATE_INVALID         = NTSTATUS(0xc01a002b),
    STATUS_LOG_PINNED                = NTSTATUS(0xc01a002c),
    STATUS_LOG_METADATA_FLUSH_FAILED = NTSTATUS(0xc01a002d),
}

enum NTSTATUS STATUS_LOG_INCONSISTENT_SECURITY = NTSTATUS(0xc01a002e);
enum NTSTATUS STATUS_LOG_APPENDED_FLUSH_FAILED = NTSTATUS(0xc01a002f);
enum NTSTATUS STATUS_LOG_PINNED_RESERVATION = NTSTATUS(0xc01a0030);

enum : NTSTATUS
{
    STATUS_VIDEO_HUNG_DISPLAY_DRIVER_THREAD           = NTSTATUS(0xc01b00ea),
    STATUS_VIDEO_HUNG_DISPLAY_DRIVER_THREAD_RECOVERED = NTSTATUS(0x801b00eb),
}

enum NTSTATUS STATUS_VIDEO_DRIVER_DEBUG_REPORT_REQUEST = NTSTATUS(0x401b00ec);

enum : NTSTATUS
{
    STATUS_MONITOR_NO_DESCRIPTOR             = NTSTATUS(0xc01d0001),
    STATUS_MONITOR_UNKNOWN_DESCRIPTOR_FORMAT = NTSTATUS(0xc01d0002),
}

enum : NTSTATUS
{
    STATUS_MONITOR_INVALID_DESCRIPTOR_CHECKSUM   = NTSTATUS(0xc01d0003),
    STATUS_MONITOR_INVALID_STANDARD_TIMING_BLOCK = NTSTATUS(0xc01d0004),
}

enum NTSTATUS STATUS_MONITOR_WMI_DATABLOCK_REGISTRATION_FAILED = NTSTATUS(0xc01d0005);

enum : NTSTATUS
{
    STATUS_MONITOR_INVALID_SERIAL_NUMBER_MONDSC_BLOCK = NTSTATUS(0xc01d0006),
    STATUS_MONITOR_INVALID_USER_FRIENDLY_MONDSC_BLOCK = NTSTATUS(0xc01d0007),
}

enum NTSTATUS STATUS_MONITOR_NO_MORE_DESCRIPTOR_DATA = NTSTATUS(0xc01d0008);

enum : NTSTATUS
{
    STATUS_MONITOR_INVALID_DETAILED_TIMING_BLOCK = NTSTATUS(0xc01d0009),
    STATUS_MONITOR_INVALID_MANUFACTURE_DATE      = NTSTATUS(0xc01d000a),
}

enum NTSTATUS STATUS_GRAPHICS_NOT_EXCLUSIVE_MODE_OWNER = NTSTATUS(0xc01e0000);

enum : NTSTATUS
{
    STATUS_GRAPHICS_INSUFFICIENT_DMA_BUFFER      = NTSTATUS(0xc01e0001),
    STATUS_GRAPHICS_INVALID_DISPLAY_ADAPTER      = NTSTATUS(0xc01e0002),
    STATUS_GRAPHICS_ADAPTER_WAS_RESET            = NTSTATUS(0xc01e0003),
    STATUS_GRAPHICS_INVALID_DRIVER_MODEL         = NTSTATUS(0xc01e0004),
    STATUS_GRAPHICS_PRESENT_MODE_CHANGED         = NTSTATUS(0xc01e0005),
    STATUS_GRAPHICS_PRESENT_OCCLUDED             = NTSTATUS(0xc01e0006),
    STATUS_GRAPHICS_PRESENT_DENIED               = NTSTATUS(0xc01e0007),
    STATUS_GRAPHICS_CANNOTCOLORCONVERT           = NTSTATUS(0xc01e0008),
    STATUS_GRAPHICS_DRIVER_MISMATCH              = NTSTATUS(0xc01e0009),
    STATUS_GRAPHICS_PARTIAL_DATA_POPULATED       = NTSTATUS(0x401e000a),
    STATUS_GRAPHICS_PRESENT_REDIRECTION_DISABLED = NTSTATUS(0xc01e000b),
    STATUS_GRAPHICS_PRESENT_UNOCCLUDED           = NTSTATUS(0xc01e000c),
    STATUS_GRAPHICS_WINDOWDC_NOT_AVAILABLE       = NTSTATUS(0xc01e000d),
    STATUS_GRAPHICS_WINDOWLESS_PRESENT_DISABLED  = NTSTATUS(0xc01e000e),
}

enum : NTSTATUS
{
    STATUS_GRAPHICS_PRESENT_INVALID_WINDOW   = NTSTATUS(0xc01e000f),
    STATUS_GRAPHICS_PRESENT_BUFFER_NOT_BOUND = NTSTATUS(0xc01e0010),
}

enum : NTSTATUS
{
    STATUS_GRAPHICS_VAIL_STATE_CHANGED                 = NTSTATUS(0xc01e0011),
    STATUS_GRAPHICS_INDIRECT_DISPLAY_ABANDON_SWAPCHAIN = NTSTATUS(0xc01e0012),
    STATUS_GRAPHICS_INDIRECT_DISPLAY_DEVICE_STOPPED    = NTSTATUS(0xc01e0013),
}

enum : NTSTATUS
{
    STATUS_GRAPHICS_MPO_ALLOCATION_UNPINNED          = NTSTATUS(0xc01e0018),
    STATUS_GRAPHICS_SETDISPLAYMODE_REQUIRED          = NTSTATUS(0xc01e0019),
    STATUS_GRAPHICS_NO_VIDEO_MEMORY                  = NTSTATUS(0xc01e0100),
    STATUS_GRAPHICS_CANT_LOCK_MEMORY                 = NTSTATUS(0xc01e0101),
    STATUS_GRAPHICS_ALLOCATION_BUSY                  = NTSTATUS(0xc01e0102),
    STATUS_GRAPHICS_TOO_MANY_REFERENCES              = NTSTATUS(0xc01e0103),
    STATUS_GRAPHICS_TRY_AGAIN_LATER                  = NTSTATUS(0xc01e0104),
    STATUS_GRAPHICS_TRY_AGAIN_NOW                    = NTSTATUS(0xc01e0105),
    STATUS_GRAPHICS_ALLOCATION_INVALID               = NTSTATUS(0xc01e0106),
    STATUS_GRAPHICS_UNSWIZZLING_APERTURE_UNAVAILABLE = NTSTATUS(0xc01e0107),
    STATUS_GRAPHICS_UNSWIZZLING_APERTURE_UNSUPPORTED = NTSTATUS(0xc01e0108),
}

enum NTSTATUS STATUS_GRAPHICS_CANT_EVICT_PINNED_ALLOCATION = NTSTATUS(0xc01e0109);
enum NTSTATUS STATUS_GRAPHICS_INVALID_ALLOCATION_USAGE = NTSTATUS(0xc01e0110);
enum NTSTATUS STATUS_GRAPHICS_CANT_RENDER_LOCKED_ALLOCATION = NTSTATUS(0xc01e0111);

enum : NTSTATUS
{
    STATUS_GRAPHICS_ALLOCATION_CLOSED           = NTSTATUS(0xc01e0112),
    STATUS_GRAPHICS_INVALID_ALLOCATION_INSTANCE = NTSTATUS(0xc01e0113),
    STATUS_GRAPHICS_INVALID_ALLOCATION_HANDLE   = NTSTATUS(0xc01e0114),
}

enum : NTSTATUS
{
    STATUS_GRAPHICS_WRONG_ALLOCATION_DEVICE     = NTSTATUS(0xc01e0115),
    STATUS_GRAPHICS_ALLOCATION_CONTENT_LOST     = NTSTATUS(0xc01e0116),
    STATUS_GRAPHICS_GPU_EXCEPTION_ON_DEVICE     = NTSTATUS(0xc01e0200),
    STATUS_GRAPHICS_SKIP_ALLOCATION_PREPARATION = NTSTATUS(0x401e0201),
}

enum : NTSTATUS
{
    STATUS_GRAPHICS_INVALID_VIDPN_TOPOLOGY                 = NTSTATUS(0xc01e0300),
    STATUS_GRAPHICS_VIDPN_TOPOLOGY_NOT_SUPPORTED           = NTSTATUS(0xc01e0301),
    STATUS_GRAPHICS_VIDPN_TOPOLOGY_CURRENTLY_NOT_SUPPORTED = NTSTATUS(0xc01e0302),
}

enum : NTSTATUS
{
    STATUS_GRAPHICS_INVALID_VIDPN                = NTSTATUS(0xc01e0303),
    STATUS_GRAPHICS_INVALID_VIDEO_PRESENT_SOURCE = NTSTATUS(0xc01e0304),
    STATUS_GRAPHICS_INVALID_VIDEO_PRESENT_TARGET = NTSTATUS(0xc01e0305),
}

enum NTSTATUS STATUS_GRAPHICS_VIDPN_MODALITY_NOT_SUPPORTED = NTSTATUS(0xc01e0306);

enum : NTSTATUS
{
    STATUS_GRAPHICS_MODE_NOT_PINNED                   = NTSTATUS(0x401e0307),
    STATUS_GRAPHICS_INVALID_VIDPN_SOURCEMODESET       = NTSTATUS(0xc01e0308),
    STATUS_GRAPHICS_INVALID_VIDPN_TARGETMODESET       = NTSTATUS(0xc01e0309),
    STATUS_GRAPHICS_INVALID_FREQUENCY                 = NTSTATUS(0xc01e030a),
    STATUS_GRAPHICS_INVALID_ACTIVE_REGION             = NTSTATUS(0xc01e030b),
    STATUS_GRAPHICS_INVALID_TOTAL_REGION              = NTSTATUS(0xc01e030c),
    STATUS_GRAPHICS_INVALID_VIDEO_PRESENT_SOURCE_MODE = NTSTATUS(0xc01e0310),
    STATUS_GRAPHICS_INVALID_VIDEO_PRESENT_TARGET_MODE = NTSTATUS(0xc01e0311),
}

enum NTSTATUS STATUS_GRAPHICS_PINNED_MODE_MUST_REMAIN_IN_SET = NTSTATUS(0xc01e0312);
enum NTSTATUS STATUS_GRAPHICS_PATH_ALREADY_IN_TOPOLOGY = NTSTATUS(0xc01e0313);

enum : NTSTATUS
{
    STATUS_GRAPHICS_MODE_ALREADY_IN_MODESET       = NTSTATUS(0xc01e0314),
    STATUS_GRAPHICS_INVALID_VIDEOPRESENTSOURCESET = NTSTATUS(0xc01e0315),
    STATUS_GRAPHICS_INVALID_VIDEOPRESENTTARGETSET = NTSTATUS(0xc01e0316),
}

enum : NTSTATUS
{
    STATUS_GRAPHICS_SOURCE_ALREADY_IN_SET      = NTSTATUS(0xc01e0317),
    STATUS_GRAPHICS_TARGET_ALREADY_IN_SET      = NTSTATUS(0xc01e0318),
    STATUS_GRAPHICS_INVALID_VIDPN_PRESENT_PATH = NTSTATUS(0xc01e0319),
}

enum NTSTATUS STATUS_GRAPHICS_NO_RECOMMENDED_VIDPN_TOPOLOGY = NTSTATUS(0xc01e031a);

enum : NTSTATUS
{
    STATUS_GRAPHICS_INVALID_MONITOR_FREQUENCYRANGESET = NTSTATUS(0xc01e031b),
    STATUS_GRAPHICS_INVALID_MONITOR_FREQUENCYRANGE    = NTSTATUS(0xc01e031c),
}

enum NTSTATUS STATUS_GRAPHICS_FREQUENCYRANGE_NOT_IN_SET = NTSTATUS(0xc01e031d);

enum : NTSTATUS
{
    STATUS_GRAPHICS_NO_PREFERRED_MODE             = NTSTATUS(0x401e031e),
    STATUS_GRAPHICS_FREQUENCYRANGE_ALREADY_IN_SET = NTSTATUS(0xc01e031f),
}

enum : NTSTATUS
{
    STATUS_GRAPHICS_STALE_MODESET                 = NTSTATUS(0xc01e0320),
    STATUS_GRAPHICS_INVALID_MONITOR_SOURCEMODESET = NTSTATUS(0xc01e0321),
    STATUS_GRAPHICS_INVALID_MONITOR_SOURCE_MODE   = NTSTATUS(0xc01e0322),
}

enum NTSTATUS STATUS_GRAPHICS_NO_RECOMMENDED_FUNCTIONAL_VIDPN = NTSTATUS(0xc01e0323);

enum : NTSTATUS
{
    STATUS_GRAPHICS_MODE_ID_MUST_BE_UNIQUE                          = NTSTATUS(0xc01e0324),
    STATUS_GRAPHICS_EMPTY_ADAPTER_MONITOR_MODE_SUPPORT_INTERSECTION = NTSTATUS(0xc01e0325),
}

enum NTSTATUS STATUS_GRAPHICS_VIDEO_PRESENT_TARGETS_LESS_THAN_SOURCES = NTSTATUS(0xc01e0326);

enum : NTSTATUS
{
    STATUS_GRAPHICS_PATH_NOT_IN_TOPOLOGY                  = NTSTATUS(0xc01e0327),
    STATUS_GRAPHICS_ADAPTER_MUST_HAVE_AT_LEAST_ONE_SOURCE = NTSTATUS(0xc01e0328),
    STATUS_GRAPHICS_ADAPTER_MUST_HAVE_AT_LEAST_ONE_TARGET = NTSTATUS(0xc01e0329),
}

enum : NTSTATUS
{
    STATUS_GRAPHICS_INVALID_MONITORDESCRIPTORSET = NTSTATUS(0xc01e032a),
    STATUS_GRAPHICS_INVALID_MONITORDESCRIPTOR    = NTSTATUS(0xc01e032b),
}

enum : NTSTATUS
{
    STATUS_GRAPHICS_MONITORDESCRIPTOR_NOT_IN_SET        = NTSTATUS(0xc01e032c),
    STATUS_GRAPHICS_MONITORDESCRIPTOR_ALREADY_IN_SET    = NTSTATUS(0xc01e032d),
    STATUS_GRAPHICS_MONITORDESCRIPTOR_ID_MUST_BE_UNIQUE = NTSTATUS(0xc01e032e),
}

enum NTSTATUS STATUS_GRAPHICS_INVALID_VIDPN_TARGET_SUBSET_TYPE = NTSTATUS(0xc01e032f);

enum : NTSTATUS
{
    STATUS_GRAPHICS_RESOURCES_NOT_RELATED    = NTSTATUS(0xc01e0330),
    STATUS_GRAPHICS_SOURCE_ID_MUST_BE_UNIQUE = NTSTATUS(0xc01e0331),
}

enum NTSTATUS STATUS_GRAPHICS_TARGET_ID_MUST_BE_UNIQUE = NTSTATUS(0xc01e0332);
enum NTSTATUS STATUS_GRAPHICS_NO_AVAILABLE_VIDPN_TARGET = NTSTATUS(0xc01e0333);
enum NTSTATUS STATUS_GRAPHICS_MONITOR_COULD_NOT_BE_ASSOCIATED_WITH_ADAPTER = NTSTATUS(0xc01e0334);

enum : NTSTATUS
{
    STATUS_GRAPHICS_NO_VIDPNMGR                  = NTSTATUS(0xc01e0335),
    STATUS_GRAPHICS_NO_ACTIVE_VIDPN              = NTSTATUS(0xc01e0336),
    STATUS_GRAPHICS_STALE_VIDPN_TOPOLOGY         = NTSTATUS(0xc01e0337),
    STATUS_GRAPHICS_MONITOR_NOT_CONNECTED        = NTSTATUS(0xc01e0338),
    STATUS_GRAPHICS_SOURCE_NOT_IN_TOPOLOGY       = NTSTATUS(0xc01e0339),
    STATUS_GRAPHICS_INVALID_PRIMARYSURFACE_SIZE  = NTSTATUS(0xc01e033a),
    STATUS_GRAPHICS_INVALID_VISIBLEREGION_SIZE   = NTSTATUS(0xc01e033b),
    STATUS_GRAPHICS_INVALID_STRIDE               = NTSTATUS(0xc01e033c),
    STATUS_GRAPHICS_INVALID_PIXELFORMAT          = NTSTATUS(0xc01e033d),
    STATUS_GRAPHICS_INVALID_COLORBASIS           = NTSTATUS(0xc01e033e),
    STATUS_GRAPHICS_INVALID_PIXELVALUEACCESSMODE = NTSTATUS(0xc01e033f),
}

enum : NTSTATUS
{
    STATUS_GRAPHICS_TARGET_NOT_IN_TOPOLOGY             = NTSTATUS(0xc01e0340),
    STATUS_GRAPHICS_NO_DISPLAY_MODE_MANAGEMENT_SUPPORT = NTSTATUS(0xc01e0341),
}

enum : NTSTATUS
{
    STATUS_GRAPHICS_VIDPN_SOURCE_IN_USE      = NTSTATUS(0xc01e0342),
    STATUS_GRAPHICS_CANT_ACCESS_ACTIVE_VIDPN = NTSTATUS(0xc01e0343),
}

enum : NTSTATUS
{
    STATUS_GRAPHICS_INVALID_PATH_IMPORTANCE_ORDINAL              = NTSTATUS(0xc01e0344),
    STATUS_GRAPHICS_INVALID_PATH_CONTENT_GEOMETRY_TRANSFORMATION = NTSTATUS(0xc01e0345),
}

enum NTSTATUS STATUS_GRAPHICS_PATH_CONTENT_GEOMETRY_TRANSFORMATION_NOT_SUPPORTED = NTSTATUS(0xc01e0346);

enum : NTSTATUS
{
    STATUS_GRAPHICS_INVALID_GAMMA_RAMP       = NTSTATUS(0xc01e0347),
    STATUS_GRAPHICS_GAMMA_RAMP_NOT_SUPPORTED = NTSTATUS(0xc01e0348),
}

enum NTSTATUS STATUS_GRAPHICS_MULTISAMPLING_NOT_SUPPORTED = NTSTATUS(0xc01e0349);

enum : NTSTATUS
{
    STATUS_GRAPHICS_MODE_NOT_IN_MODESET         = NTSTATUS(0xc01e034a),
    STATUS_GRAPHICS_DATASET_IS_EMPTY            = NTSTATUS(0x401e034b),
    STATUS_GRAPHICS_NO_MORE_ELEMENTS_IN_DATASET = NTSTATUS(0x401e034c),
}

enum NTSTATUS STATUS_GRAPHICS_INVALID_VIDPN_TOPOLOGY_RECOMMENDATION_REASON = NTSTATUS(0xc01e034d);

enum : NTSTATUS
{
    STATUS_GRAPHICS_INVALID_PATH_CONTENT_TYPE   = NTSTATUS(0xc01e034e),
    STATUS_GRAPHICS_INVALID_COPYPROTECTION_TYPE = NTSTATUS(0xc01e034f),
}

enum NTSTATUS STATUS_GRAPHICS_UNASSIGNED_MODESET_ALREADY_EXISTS = NTSTATUS(0xc01e0350);
enum NTSTATUS STATUS_GRAPHICS_PATH_CONTENT_GEOMETRY_TRANSFORMATION_NOT_PINNED = NTSTATUS(0x401e0351);
enum NTSTATUS STATUS_GRAPHICS_INVALID_SCANLINE_ORDERING = NTSTATUS(0xc01e0352);
enum NTSTATUS STATUS_GRAPHICS_TOPOLOGY_CHANGES_NOT_ALLOWED = NTSTATUS(0xc01e0353);
enum NTSTATUS STATUS_GRAPHICS_NO_AVAILABLE_IMPORTANCE_ORDINALS = NTSTATUS(0xc01e0354);

enum : NTSTATUS
{
    STATUS_GRAPHICS_INCOMPATIBLE_PRIVATE_FORMAT               = NTSTATUS(0xc01e0355),
    STATUS_GRAPHICS_INVALID_MODE_PRUNING_ALGORITHM            = NTSTATUS(0xc01e0356),
    STATUS_GRAPHICS_INVALID_MONITOR_CAPABILITY_ORIGIN         = NTSTATUS(0xc01e0357),
    STATUS_GRAPHICS_INVALID_MONITOR_FREQUENCYRANGE_CONSTRAINT = NTSTATUS(0xc01e0358),
}

enum : NTSTATUS
{
    STATUS_GRAPHICS_MAX_NUM_PATHS_REACHED              = NTSTATUS(0xc01e0359),
    STATUS_GRAPHICS_CANCEL_VIDPN_TOPOLOGY_AUGMENTATION = NTSTATUS(0xc01e035a),
}

enum : NTSTATUS
{
    STATUS_GRAPHICS_INVALID_CLIENT_TYPE               = NTSTATUS(0xc01e035b),
    STATUS_GRAPHICS_CLIENTVIDPN_NOT_SET               = NTSTATUS(0xc01e035c),
    STATUS_GRAPHICS_SPECIFIED_CHILD_ALREADY_CONNECTED = NTSTATUS(0xc01e0400),
}

enum NTSTATUS STATUS_GRAPHICS_CHILD_DESCRIPTOR_NOT_SUPPORTED = NTSTATUS(0xc01e0401);

enum : NTSTATUS
{
    STATUS_GRAPHICS_UNKNOWN_CHILD_STATUS      = NTSTATUS(0x401e042f),
    STATUS_GRAPHICS_NOT_A_LINKED_ADAPTER      = NTSTATUS(0xc01e0430),
    STATUS_GRAPHICS_LEADLINK_NOT_ENUMERATED   = NTSTATUS(0xc01e0431),
    STATUS_GRAPHICS_CHAINLINKS_NOT_ENUMERATED = NTSTATUS(0xc01e0432),
}

enum : NTSTATUS
{
    STATUS_GRAPHICS_ADAPTER_CHAIN_NOT_READY   = NTSTATUS(0xc01e0433),
    STATUS_GRAPHICS_CHAINLINKS_NOT_STARTED    = NTSTATUS(0xc01e0434),
    STATUS_GRAPHICS_CHAINLINKS_NOT_POWERED_ON = NTSTATUS(0xc01e0435),
}

enum NTSTATUS STATUS_GRAPHICS_INCONSISTENT_DEVICE_LINK_STATE = NTSTATUS(0xc01e0436);

enum : NTSTATUS
{
    STATUS_GRAPHICS_LEADLINK_START_DEFERRED     = NTSTATUS(0x401e0437),
    STATUS_GRAPHICS_NOT_POST_DEVICE_DRIVER      = NTSTATUS(0xc01e0438),
    STATUS_GRAPHICS_POLLING_TOO_FREQUENTLY      = NTSTATUS(0x401e0439),
    STATUS_GRAPHICS_START_DEFERRED              = NTSTATUS(0x401e043a),
    STATUS_GRAPHICS_ADAPTER_ACCESS_NOT_EXCLUDED = NTSTATUS(0xc01e043b),
}

enum : NTSTATUS
{
    STATUS_GRAPHICS_DEPENDABLE_CHILD_STATUS          = NTSTATUS(0x401e043c),
    STATUS_GRAPHICS_OPM_NOT_SUPPORTED                = NTSTATUS(0xc01e0500),
    STATUS_GRAPHICS_COPP_NOT_SUPPORTED               = NTSTATUS(0xc01e0501),
    STATUS_GRAPHICS_UAB_NOT_SUPPORTED                = NTSTATUS(0xc01e0502),
    STATUS_GRAPHICS_OPM_INVALID_ENCRYPTED_PARAMETERS = NTSTATUS(0xc01e0503),
    STATUS_GRAPHICS_OPM_NO_PROTECTED_OUTPUTS_EXIST   = NTSTATUS(0xc01e0505),
    STATUS_GRAPHICS_OPM_INTERNAL_ERROR               = NTSTATUS(0xc01e050b),
    STATUS_GRAPHICS_OPM_INVALID_HANDLE               = NTSTATUS(0xc01e050c),
    STATUS_GRAPHICS_PVP_INVALID_CERTIFICATE_LENGTH   = NTSTATUS(0xc01e050e),
}

enum : NTSTATUS
{
    STATUS_GRAPHICS_OPM_SPANNING_MODE_ENABLED = NTSTATUS(0xc01e050f),
    STATUS_GRAPHICS_OPM_THEATER_MODE_ENABLED  = NTSTATUS(0xc01e0510),
}

enum : NTSTATUS
{
    STATUS_GRAPHICS_PVP_HFS_FAILED                       = NTSTATUS(0xc01e0511),
    STATUS_GRAPHICS_OPM_INVALID_SRM                      = NTSTATUS(0xc01e0512),
    STATUS_GRAPHICS_OPM_OUTPUT_DOES_NOT_SUPPORT_HDCP     = NTSTATUS(0xc01e0513),
    STATUS_GRAPHICS_OPM_OUTPUT_DOES_NOT_SUPPORT_ACP      = NTSTATUS(0xc01e0514),
    STATUS_GRAPHICS_OPM_OUTPUT_DOES_NOT_SUPPORT_CGMSA    = NTSTATUS(0xc01e0515),
    STATUS_GRAPHICS_OPM_HDCP_SRM_NEVER_SET               = NTSTATUS(0xc01e0516),
    STATUS_GRAPHICS_OPM_RESOLUTION_TOO_HIGH              = NTSTATUS(0xc01e0517),
    STATUS_GRAPHICS_OPM_ALL_HDCP_HARDWARE_ALREADY_IN_USE = NTSTATUS(0xc01e0518),
}

enum : NTSTATUS
{
    STATUS_GRAPHICS_OPM_PROTECTED_OUTPUT_NO_LONGER_EXISTS             = NTSTATUS(0xc01e051a),
    STATUS_GRAPHICS_OPM_PROTECTED_OUTPUT_DOES_NOT_HAVE_COPP_SEMANTICS = NTSTATUS(0xc01e051c),
}

enum : NTSTATUS
{
    STATUS_GRAPHICS_OPM_INVALID_INFORMATION_REQUEST                  = NTSTATUS(0xc01e051d),
    STATUS_GRAPHICS_OPM_DRIVER_INTERNAL_ERROR                        = NTSTATUS(0xc01e051e),
    STATUS_GRAPHICS_OPM_PROTECTED_OUTPUT_DOES_NOT_HAVE_OPM_SEMANTICS = NTSTATUS(0xc01e051f),
}

enum : NTSTATUS
{
    STATUS_GRAPHICS_OPM_SIGNALING_NOT_SUPPORTED       = NTSTATUS(0xc01e0520),
    STATUS_GRAPHICS_OPM_INVALID_CONFIGURATION_REQUEST = NTSTATUS(0xc01e0521),
}

enum : NTSTATUS
{
    STATUS_GRAPHICS_I2C_NOT_SUPPORTED           = NTSTATUS(0xc01e0580),
    STATUS_GRAPHICS_I2C_DEVICE_DOES_NOT_EXIST   = NTSTATUS(0xc01e0581),
    STATUS_GRAPHICS_I2C_ERROR_TRANSMITTING_DATA = NTSTATUS(0xc01e0582),
    STATUS_GRAPHICS_I2C_ERROR_RECEIVING_DATA    = NTSTATUS(0xc01e0583),
}

enum : NTSTATUS
{
    STATUS_GRAPHICS_DDCCI_VCP_NOT_SUPPORTED                           = NTSTATUS(0xc01e0584),
    STATUS_GRAPHICS_DDCCI_INVALID_DATA                                = NTSTATUS(0xc01e0585),
    STATUS_GRAPHICS_DDCCI_MONITOR_RETURNED_INVALID_TIMING_STATUS_BYTE = NTSTATUS(0xc01e0586),
}

enum NTSTATUS STATUS_GRAPHICS_DDCCI_INVALID_CAPABILITIES_STRING = NTSTATUS(0xc01e0587);

enum : NTSTATUS
{
    STATUS_GRAPHICS_MCA_INTERNAL_ERROR             = NTSTATUS(0xc01e0588),
    STATUS_GRAPHICS_DDCCI_INVALID_MESSAGE_COMMAND  = NTSTATUS(0xc01e0589),
    STATUS_GRAPHICS_DDCCI_INVALID_MESSAGE_LENGTH   = NTSTATUS(0xc01e058a),
    STATUS_GRAPHICS_DDCCI_INVALID_MESSAGE_CHECKSUM = NTSTATUS(0xc01e058b),
}

enum NTSTATUS STATUS_GRAPHICS_INVALID_PHYSICAL_MONITOR_HANDLE = NTSTATUS(0xc01e058c);
enum NTSTATUS STATUS_GRAPHICS_MONITOR_NO_LONGER_EXISTS = NTSTATUS(0xc01e058d);
enum NTSTATUS STATUS_GRAPHICS_ONLY_CONSOLE_SESSION_SUPPORTED = NTSTATUS(0xc01e05e0);
enum NTSTATUS STATUS_GRAPHICS_NO_DISPLAY_DEVICE_CORRESPONDS_TO_NAME = NTSTATUS(0xc01e05e1);
enum NTSTATUS STATUS_GRAPHICS_DISPLAY_DEVICE_NOT_ATTACHED_TO_DESKTOP = NTSTATUS(0xc01e05e2);
enum NTSTATUS STATUS_GRAPHICS_MIRRORING_DEVICES_NOT_SUPPORTED = NTSTATUS(0xc01e05e3);

enum : NTSTATUS
{
    STATUS_GRAPHICS_INVALID_POINTER                          = NTSTATUS(0xc01e05e4),
    STATUS_GRAPHICS_NO_MONITORS_CORRESPOND_TO_DISPLAY_DEVICE = NTSTATUS(0xc01e05e5),
}

enum NTSTATUS STATUS_GRAPHICS_PARAMETER_ARRAY_TOO_SMALL = NTSTATUS(0xc01e05e6);

enum : NTSTATUS
{
    STATUS_GRAPHICS_INTERNAL_ERROR                  = NTSTATUS(0xc01e05e7),
    STATUS_GRAPHICS_SESSION_TYPE_CHANGE_IN_PROGRESS = NTSTATUS(0xc01e05e8),
}

enum NTSTATUS STATUS_GRAPHICS_UNKNOWN_BIOS_FRAME_BUFFER_NOT_FOUND = NTSTATUS(0xc01e0600);
enum NTSTATUS STATUS_GRAPHICS_UEFI_FRAME_BUFFER_NOT_FOUND = NTSTATUS(0xc01e0601);

enum : NTSTATUS
{
    STATUS_CAMERA_INVALID_CONFIGURATION  = NTSTATUS(0xc01f0000),
    STATUS_CAMERA_INSUFFICIENT_BANDWIDTH = NTSTATUS(0xc01f0001),
}

enum : NTSTATUS
{
    STATUS_FVE_LOCKED_VOLUME      = NTSTATUS(0xc0210000),
    STATUS_FVE_NOT_ENCRYPTED      = NTSTATUS(0xc0210001),
    STATUS_FVE_BAD_INFORMATION    = NTSTATUS(0xc0210002),
    STATUS_FVE_TOO_SMALL          = NTSTATUS(0xc0210003),
    STATUS_FVE_FAILED_WRONG_FS    = NTSTATUS(0xc0210004),
    STATUS_FVE_BAD_PARTITION_SIZE = NTSTATUS(0xc0210005),
}

enum : NTSTATUS
{
    STATUS_FVE_FS_NOT_EXTENDED    = NTSTATUS(0xc0210006),
    STATUS_FVE_FS_MOUNTED         = NTSTATUS(0xc0210007),
    STATUS_FVE_NO_LICENSE         = NTSTATUS(0xc0210008),
    STATUS_FVE_ACTION_NOT_ALLOWED = NTSTATUS(0xc0210009),
}

enum : NTSTATUS
{
    STATUS_FVE_BAD_DATA          = NTSTATUS(0xc021000a),
    STATUS_FVE_VOLUME_NOT_BOUND  = NTSTATUS(0xc021000b),
    STATUS_FVE_NOT_DATA_VOLUME   = NTSTATUS(0xc021000c),
    STATUS_FVE_CONV_READ_ERROR   = NTSTATUS(0xc021000d),
    STATUS_FVE_CONV_WRITE_ERROR  = NTSTATUS(0xc021000e),
    STATUS_FVE_OVERLAPPED_UPDATE = NTSTATUS(0xc021000f),
}

enum : NTSTATUS
{
    STATUS_FVE_FAILED_SECTOR_SIZE    = NTSTATUS(0xc0210010),
    STATUS_FVE_FAILED_AUTHENTICATION = NTSTATUS(0xc0210011),
}

enum : NTSTATUS
{
    STATUS_FVE_NOT_OS_VOLUME            = NTSTATUS(0xc0210012),
    STATUS_FVE_KEYFILE_NOT_FOUND        = NTSTATUS(0xc0210013),
    STATUS_FVE_KEYFILE_INVALID          = NTSTATUS(0xc0210014),
    STATUS_FVE_KEYFILE_NO_VMK           = NTSTATUS(0xc0210015),
    STATUS_FVE_TPM_DISABLED             = NTSTATUS(0xc0210016),
    STATUS_FVE_TPM_SRK_AUTH_NOT_ZERO    = NTSTATUS(0xc0210017),
    STATUS_FVE_TPM_INVALID_PCR          = NTSTATUS(0xc0210018),
    STATUS_FVE_TPM_NO_VMK               = NTSTATUS(0xc0210019),
    STATUS_FVE_PIN_INVALID              = NTSTATUS(0xc021001a),
    STATUS_FVE_AUTH_INVALID_APPLICATION = NTSTATUS(0xc021001b),
    STATUS_FVE_AUTH_INVALID_CONFIG      = NTSTATUS(0xc021001c),
}

enum : NTSTATUS
{
    STATUS_FVE_DEBUGGER_ENABLED     = NTSTATUS(0xc021001d),
    STATUS_FVE_DRY_RUN_FAILED       = NTSTATUS(0xc021001e),
    STATUS_FVE_BAD_METADATA_POINTER = NTSTATUS(0xc021001f),
}

enum NTSTATUS STATUS_FVE_OLD_METADATA_COPY = NTSTATUS(0xc0210020);

enum : NTSTATUS
{
    STATUS_FVE_REBOOT_REQUIRED          = NTSTATUS(0xc0210021),
    STATUS_FVE_RAW_ACCESS               = NTSTATUS(0xc0210022),
    STATUS_FVE_RAW_BLOCKED              = NTSTATUS(0xc0210023),
    STATUS_FVE_NO_AUTOUNLOCK_MASTER_KEY = NTSTATUS(0xc0210024),
}

enum : NTSTATUS
{
    STATUS_FVE_MOR_FAILED         = NTSTATUS(0xc0210025),
    STATUS_FVE_NO_FEATURE_LICENSE = NTSTATUS(0xc0210026),
}

enum NTSTATUS STATUS_FVE_POLICY_USER_DISABLE_RDV_NOT_ALLOWED = NTSTATUS(0xc0210027);
enum NTSTATUS STATUS_FVE_CONV_RECOVERY_FAILED = NTSTATUS(0xc0210028);
enum NTSTATUS STATUS_FVE_VIRTUALIZED_SPACE_TOO_BIG = NTSTATUS(0xc0210029);
enum NTSTATUS STATUS_FVE_INVALID_DATUM_TYPE = NTSTATUS(0xc021002a);

enum : NTSTATUS
{
    STATUS_FVE_VOLUME_TOO_SMALL                          = NTSTATUS(0xc0210030),
    STATUS_FVE_ENH_PIN_INVALID                           = NTSTATUS(0xc0210031),
    STATUS_FVE_FULL_ENCRYPTION_NOT_ALLOWED_ON_TP_STORAGE = NTSTATUS(0xc0210032),
}

enum NTSTATUS STATUS_FVE_WIPE_NOT_ALLOWED_ON_TP_STORAGE = NTSTATUS(0xc0210033);

enum : NTSTATUS
{
    STATUS_FVE_NOT_ALLOWED_ON_CSV_STACK                = NTSTATUS(0xc0210034),
    STATUS_FVE_NOT_ALLOWED_ON_CLUSTER                  = NTSTATUS(0xc0210035),
    STATUS_FVE_NOT_ALLOWED_TO_UPGRADE_WHILE_CONVERTING = NTSTATUS(0xc0210036),
}

enum NTSTATUS STATUS_FVE_WIPE_CANCEL_NOT_APPLICABLE = NTSTATUS(0xc0210037);
enum NTSTATUS STATUS_FVE_EDRIVE_DRY_RUN_FAILED = NTSTATUS(0xc0210038);

enum : NTSTATUS
{
    STATUS_FVE_SECUREBOOT_DISABLED      = NTSTATUS(0xc0210039),
    STATUS_FVE_SECUREBOOT_CONFIG_CHANGE = NTSTATUS(0xc021003a),
}

enum : NTSTATUS
{
    STATUS_FVE_DEVICE_LOCKEDOUT                   = NTSTATUS(0xc021003b),
    STATUS_FVE_VOLUME_EXTEND_PREVENTS_EOW_DECRYPT = NTSTATUS(0xc021003c),
}

enum : NTSTATUS
{
    STATUS_FVE_NOT_DE_VOLUME                 = NTSTATUS(0xc021003d),
    STATUS_FVE_PROTECTION_DISABLED           = NTSTATUS(0xc021003e),
    STATUS_FVE_PROTECTION_CANNOT_BE_DISABLED = NTSTATUS(0xc021003f),
}

enum NTSTATUS STATUS_FVE_OSV_KSR_NOT_ALLOWED = NTSTATUS(0xc0210040);
enum NTSTATUS STATUS_FVE_EDRIVE_BAND_ENUMERATION_FAILED = NTSTATUS(0xc0210041);
enum NTSTATUS STATUS_FVE_POLICY_ON_RDV_EXCLUSION_LIST = NTSTATUS(0xc0210042);

enum : NTSTATUS
{
    STATUS_FVE_DATASET_FULL                   = NTSTATUS(0xc0210043),
    STATUS_FVE_METADATA_FULL                  = NTSTATUS(0xc0210044),
    STATUS_FVE_SUSPEND_PROTECTION_NOT_ALLOWED = NTSTATUS(0xc0210045),
}

enum : NTSTATUS
{
    STATUS_FVE_DATUM_PARTIALLY_INVALID         = NTSTATUS(0xc0210046),
    STATUS_FVE_DATASET_TPM_DATUMS_INCONSISTENT = NTSTATUS(0xc0210047),
}

enum : NTSTATUS
{
    STATUS_FVE_SECURE_BOOT_BINDINGS_OUT_OF_SYNC     = NTSTATUS(0xc0210048),
    STATUS_FVE_SECURE_BOOT_BINDING_DATA_OUT_OF_SYNC = NTSTATUS(0xc0210049),
}

enum NTSTATUS STATUS_FVE_ORPHANED_TPM_BINDING_DATUM = NTSTATUS(0xc021004a);
enum NTSTATUS STATUS_FVE_BAD_TPM_DATUM_ASSOCIATION = NTSTATUS(0xc021004b);
enum NTSTATUS STATUS_FVE_FINAL_TPM_PCR_VALUES_MATCH = NTSTATUS(0xc021004c);
enum NTSTATUS STATUS_FVE_MATCHING_PCRS_TPM_FAILURE = NTSTATUS(0xc021004d);
enum NTSTATUS STATUS_FVE_GENERAL_TPM_FAILURE = NTSTATUS(0xc021004e);

enum : NTSTATUS
{
    STATUS_FVE_TPM_NONEXISTENT           = NTSTATUS(0xc021004f),
    STATUS_FVE_NO_PCR_BOOT_LOCK_BOUNDARY = NTSTATUS(0xc0210050),
}

enum NTSTATUS STATUS_FVE_PCR_BOOT_LOCK_BOUNDARY = NTSTATUS(0xc0210051);
enum NTSTATUS STATUS_FVE_FW_UPDATE_TPM_BINDINGS_NOT_REFRESHED = NTSTATUS(0xc0210052);
enum NTSTATUS STATUS_FVE_INVALID_TPM_BINDING_CONFIGURATION = NTSTATUS(0xc0210053);
enum NTSTATUS STATUS_FVE_TOO_MANY_TPM_BINDINGS = NTSTATUS(0xc0210054);
enum NTSTATUS STATUS_FVE_TPM_BINDING_ASSOCIATION_FAILURE = NTSTATUS(0xc0210055);
enum NTSTATUS STATUS_FVE_ORPHANED_PCR_DIGEST_DATUM = NTSTATUS(0xc0210056);
enum NTSTATUS STATUS_FVE_HW_ACCELERATED_ENCRYPTION_NOT_ALLOWED = NTSTATUS(0xc0210057);
enum NTSTATUS STATUS_FVE_NO_MATCHING_TPM_BINDINGS = NTSTATUS(0xc0210058);
enum NTSTATUS STATUS_FVE_TPMPV2_USED_FAILURE = NTSTATUS(0xc0210059);

enum : NTSTATUS
{
    STATUS_FVE_NO_TPM_BINDINGS             = NTSTATUS(0xc021005a),
    STATUS_FVE_FW_UPDATE_PCRS_BLOCK        = NTSTATUS(0xc021005c),
    STATUS_FVE_FW_UPDATE_PCRS_NOT_EXCLUDED = NTSTATUS(0xc021005d),
}

enum NTSTATUS STATUS_FVE_FAILED_TO_UNWRAP_HW_WRAPPED_KEY = NTSTATUS(0xc021005e);

enum : NTSTATUS
{
    STATUS_FVE_HARDWARE_CRYPTO_ACCELERATOR_NOT_FIPS_COMPLIANT = NTSTATUS(0xc021005f),
    STATUS_FVE_HARDWARE_CRYPTO_KEY_MANAGER_NOT_FIPS_COMPLIANT = NTSTATUS(0xc0210060),
}

enum NTSTATUS STATUS_FVE_TPM_PCRS_DO_NOT_MATCH_LOG = NTSTATUS(0xc0210061);

enum : NTSTATUS
{
    STATUS_FWP_CALLOUT_NOT_FOUND   = NTSTATUS(0xc0220001),
    STATUS_FWP_CONDITION_NOT_FOUND = NTSTATUS(0xc0220002),
}

enum : NTSTATUS
{
    STATUS_FWP_FILTER_NOT_FOUND           = NTSTATUS(0xc0220003),
    STATUS_FWP_LAYER_NOT_FOUND            = NTSTATUS(0xc0220004),
    STATUS_FWP_PROVIDER_NOT_FOUND         = NTSTATUS(0xc0220005),
    STATUS_FWP_PROVIDER_CONTEXT_NOT_FOUND = NTSTATUS(0xc0220006),
}

enum NTSTATUS STATUS_FWP_SUBLAYER_NOT_FOUND = NTSTATUS(0xc0220007);

enum : NTSTATUS
{
    STATUS_FWP_NOT_FOUND                   = NTSTATUS(0xc0220008),
    STATUS_FWP_ALREADY_EXISTS              = NTSTATUS(0xc0220009),
    STATUS_FWP_IN_USE                      = NTSTATUS(0xc022000a),
    STATUS_FWP_DYNAMIC_SESSION_IN_PROGRESS = NTSTATUS(0xc022000b),
}

enum : NTSTATUS
{
    STATUS_FWP_WRONG_SESSION      = NTSTATUS(0xc022000c),
    STATUS_FWP_NO_TXN_IN_PROGRESS = NTSTATUS(0xc022000d),
}

enum : NTSTATUS
{
    STATUS_FWP_TXN_IN_PROGRESS     = NTSTATUS(0xc022000e),
    STATUS_FWP_TXN_ABORTED         = NTSTATUS(0xc022000f),
    STATUS_FWP_SESSION_ABORTED     = NTSTATUS(0xc0220010),
    STATUS_FWP_INCOMPATIBLE_TXN    = NTSTATUS(0xc0220011),
    STATUS_FWP_TIMEOUT             = NTSTATUS(0xc0220012),
    STATUS_FWP_NET_EVENTS_DISABLED = NTSTATUS(0xc0220013),
}

enum NTSTATUS STATUS_FWP_INCOMPATIBLE_LAYER = NTSTATUS(0xc0220014);

enum : NTSTATUS
{
    STATUS_FWP_KM_CLIENTS_ONLY   = NTSTATUS(0xc0220015),
    STATUS_FWP_LIFETIME_MISMATCH = NTSTATUS(0xc0220016),
}

enum : NTSTATUS
{
    STATUS_FWP_BUILTIN_OBJECT    = NTSTATUS(0xc0220017),
    STATUS_FWP_TOO_MANY_CALLOUTS = NTSTATUS(0xc0220018),
}

enum NTSTATUS STATUS_FWP_NOTIFICATION_DROPPED = NTSTATUS(0xc0220019);

enum : NTSTATUS
{
    STATUS_FWP_TRAFFIC_MISMATCH      = NTSTATUS(0xc022001a),
    STATUS_FWP_INCOMPATIBLE_SA_STATE = NTSTATUS(0xc022001b),
}

enum : NTSTATUS
{
    STATUS_FWP_NULL_POINTER       = NTSTATUS(0xc022001c),
    STATUS_FWP_INVALID_ENUMERATOR = NTSTATUS(0xc022001d),
    STATUS_FWP_INVALID_FLAGS      = NTSTATUS(0xc022001e),
    STATUS_FWP_INVALID_NET_MASK   = NTSTATUS(0xc022001f),
    STATUS_FWP_INVALID_RANGE      = NTSTATUS(0xc0220020),
    STATUS_FWP_INVALID_INTERVAL   = NTSTATUS(0xc0220021),
    STATUS_FWP_ZERO_LENGTH_ARRAY  = NTSTATUS(0xc0220022),
}

enum NTSTATUS STATUS_FWP_NULL_DISPLAY_NAME = NTSTATUS(0xc0220023);

enum : NTSTATUS
{
    STATUS_FWP_INVALID_ACTION_TYPE = NTSTATUS(0xc0220024),
    STATUS_FWP_INVALID_WEIGHT      = NTSTATUS(0xc0220025),
    STATUS_FWP_MATCH_TYPE_MISMATCH = NTSTATUS(0xc0220026),
}

enum : NTSTATUS
{
    STATUS_FWP_TYPE_MISMATCH                     = NTSTATUS(0xc0220027),
    STATUS_FWP_OUT_OF_BOUNDS                     = NTSTATUS(0xc0220028),
    STATUS_FWP_RESERVED                          = NTSTATUS(0xc0220029),
    STATUS_FWP_DUPLICATE_CONDITION               = NTSTATUS(0xc022002a),
    STATUS_FWP_DUPLICATE_KEYMOD                  = NTSTATUS(0xc022002b),
    STATUS_FWP_ACTION_INCOMPATIBLE_WITH_LAYER    = NTSTATUS(0xc022002c),
    STATUS_FWP_ACTION_INCOMPATIBLE_WITH_SUBLAYER = NTSTATUS(0xc022002d),
}

enum : NTSTATUS
{
    STATUS_FWP_CONTEXT_INCOMPATIBLE_WITH_LAYER   = NTSTATUS(0xc022002e),
    STATUS_FWP_CONTEXT_INCOMPATIBLE_WITH_CALLOUT = NTSTATUS(0xc022002f),
}

enum : NTSTATUS
{
    STATUS_FWP_INCOMPATIBLE_AUTH_METHOD = NTSTATUS(0xc0220030),
    STATUS_FWP_INCOMPATIBLE_DH_GROUP    = NTSTATUS(0xc0220031),
}

enum : NTSTATUS
{
    STATUS_FWP_EM_NOT_SUPPORTED          = NTSTATUS(0xc0220032),
    STATUS_FWP_NEVER_MATCH               = NTSTATUS(0xc0220033),
    STATUS_FWP_PROVIDER_CONTEXT_MISMATCH = NTSTATUS(0xc0220034),
}

enum NTSTATUS STATUS_FWP_INVALID_PARAMETER = NTSTATUS(0xc0220035);
enum NTSTATUS STATUS_FWP_TOO_MANY_SUBLAYERS = NTSTATUS(0xc0220036);
enum NTSTATUS STATUS_FWP_CALLOUT_NOTIFICATION_FAILED = NTSTATUS(0xc0220037);

enum : NTSTATUS
{
    STATUS_FWP_INVALID_AUTH_TRANSFORM   = NTSTATUS(0xc0220038),
    STATUS_FWP_INVALID_CIPHER_TRANSFORM = NTSTATUS(0xc0220039),
}

enum NTSTATUS STATUS_FWP_INCOMPATIBLE_CIPHER_TRANSFORM = NTSTATUS(0xc022003a);
enum NTSTATUS STATUS_FWP_INVALID_TRANSFORM_COMBINATION = NTSTATUS(0xc022003b);
enum NTSTATUS STATUS_FWP_DUPLICATE_AUTH_METHOD = NTSTATUS(0xc022003c);
enum NTSTATUS STATUS_FWP_INVALID_TUNNEL_ENDPOINT = NTSTATUS(0xc022003d);
enum NTSTATUS STATUS_FWP_L2_DRIVER_NOT_READY = NTSTATUS(0xc022003e);

enum : NTSTATUS
{
    STATUS_FWP_KEY_DICTATOR_ALREADY_REGISTERED       = NTSTATUS(0xc022003f),
    STATUS_FWP_KEY_DICTATION_INVALID_KEYING_MATERIAL = NTSTATUS(0xc0220040),
}

enum NTSTATUS STATUS_FWP_CONNECTIONS_DISABLED = NTSTATUS(0xc0220041);

enum : NTSTATUS
{
    STATUS_FWP_INVALID_DNS_NAME   = NTSTATUS(0xc0220042),
    STATUS_FWP_STILL_ON           = NTSTATUS(0xc0220043),
    STATUS_FWP_IKEEXT_NOT_RUNNING = NTSTATUS(0xc0220044),
}

enum : NTSTATUS
{
    STATUS_FWP_TCPIP_NOT_READY       = NTSTATUS(0xc0220100),
    STATUS_FWP_INJECT_HANDLE_CLOSING = NTSTATUS(0xc0220101),
    STATUS_FWP_INJECT_HANDLE_STALE   = NTSTATUS(0xc0220102),
}

enum : NTSTATUS
{
    STATUS_FWP_CANNOT_PEND = NTSTATUS(0xc0220103),
    STATUS_FWP_DROP_NOICMP = NTSTATUS(0xc0220104),
}

enum : NTSTATUS
{
    STATUS_NDIS_CLOSING             = NTSTATUS(0xc0230002),
    STATUS_NDIS_BAD_VERSION         = NTSTATUS(0xc0230004),
    STATUS_NDIS_BAD_CHARACTERISTICS = NTSTATUS(0xc0230005),
}

enum : NTSTATUS
{
    STATUS_NDIS_ADAPTER_NOT_FOUND   = NTSTATUS(0xc0230006),
    STATUS_NDIS_OPEN_FAILED         = NTSTATUS(0xc0230007),
    STATUS_NDIS_DEVICE_FAILED       = NTSTATUS(0xc0230008),
    STATUS_NDIS_MULTICAST_FULL      = NTSTATUS(0xc0230009),
    STATUS_NDIS_MULTICAST_EXISTS    = NTSTATUS(0xc023000a),
    STATUS_NDIS_MULTICAST_NOT_FOUND = NTSTATUS(0xc023000b),
}

enum : NTSTATUS
{
    STATUS_NDIS_REQUEST_ABORTED      = NTSTATUS(0xc023000c),
    STATUS_NDIS_RESET_IN_PROGRESS    = NTSTATUS(0xc023000d),
    STATUS_NDIS_NOT_SUPPORTED        = NTSTATUS(0xc02300bb),
    STATUS_NDIS_INVALID_PACKET       = NTSTATUS(0xc023000f),
    STATUS_NDIS_ADAPTER_NOT_READY    = NTSTATUS(0xc0230011),
    STATUS_NDIS_INVALID_LENGTH       = NTSTATUS(0xc0230014),
    STATUS_NDIS_INVALID_DATA         = NTSTATUS(0xc0230015),
    STATUS_NDIS_BUFFER_TOO_SHORT     = NTSTATUS(0xc0230016),
    STATUS_NDIS_INVALID_OID          = NTSTATUS(0xc0230017),
    STATUS_NDIS_ADAPTER_REMOVED      = NTSTATUS(0xc0230018),
    STATUS_NDIS_UNSUPPORTED_MEDIA    = NTSTATUS(0xc0230019),
    STATUS_NDIS_GROUP_ADDRESS_IN_USE = NTSTATUS(0xc023001a),
}

enum : NTSTATUS
{
    STATUS_NDIS_FILE_NOT_FOUND     = NTSTATUS(0xc023001b),
    STATUS_NDIS_ERROR_READING_FILE = NTSTATUS(0xc023001c),
}

enum : NTSTATUS
{
    STATUS_NDIS_ALREADY_MAPPED     = NTSTATUS(0xc023001d),
    STATUS_NDIS_RESOURCE_CONFLICT  = NTSTATUS(0xc023001e),
    STATUS_NDIS_MEDIA_DISCONNECTED = NTSTATUS(0xc023001f),
}

enum : NTSTATUS
{
    STATUS_NDIS_INVALID_ADDRESS        = NTSTATUS(0xc0230022),
    STATUS_NDIS_INVALID_DEVICE_REQUEST = NTSTATUS(0xc0230010),
}

enum : NTSTATUS
{
    STATUS_NDIS_PAUSED              = NTSTATUS(0xc023002a),
    STATUS_NDIS_INTERFACE_NOT_FOUND = NTSTATUS(0xc023002b),
}

enum NTSTATUS STATUS_NDIS_UNSUPPORTED_REVISION = NTSTATUS(0xc023002c);

enum : NTSTATUS
{
    STATUS_NDIS_INVALID_PORT       = NTSTATUS(0xc023002d),
    STATUS_NDIS_INVALID_PORT_STATE = NTSTATUS(0xc023002e),
}

enum : NTSTATUS
{
    STATUS_NDIS_LOW_POWER_STATE           = NTSTATUS(0xc023002f),
    STATUS_NDIS_REINIT_REQUIRED           = NTSTATUS(0xc0230030),
    STATUS_NDIS_NO_QUEUES                 = NTSTATUS(0xc0230031),
    STATUS_NDIS_DOT11_AUTO_CONFIG_ENABLED = NTSTATUS(0xc0232000),
    STATUS_NDIS_DOT11_MEDIA_IN_USE        = NTSTATUS(0xc0232001),
    STATUS_NDIS_DOT11_POWER_STATE_INVALID = NTSTATUS(0xc0232002),
}

enum : NTSTATUS
{
    STATUS_NDIS_PM_WOL_PATTERN_LIST_FULL      = NTSTATUS(0xc0232003),
    STATUS_NDIS_PM_PROTOCOL_OFFLOAD_LIST_FULL = NTSTATUS(0xc0232004),
}

enum : NTSTATUS
{
    STATUS_NDIS_DOT11_AP_CHANNEL_CURRENTLY_NOT_AVAILABLE = NTSTATUS(0xc0232005),
    STATUS_NDIS_DOT11_AP_BAND_CURRENTLY_NOT_AVAILABLE    = NTSTATUS(0xc0232006),
    STATUS_NDIS_DOT11_AP_CHANNEL_NOT_ALLOWED             = NTSTATUS(0xc0232007),
    STATUS_NDIS_DOT11_AP_BAND_NOT_ALLOWED                = NTSTATUS(0xc0232008),
    STATUS_NDIS_DOT11_AP_RADIO_RESTRICTION               = NTSTATUS(0xc0232009),
}

enum NTSTATUS STATUS_NDIS_INDICATION_REQUIRED = NTSTATUS(0x40230001);

enum : NTSTATUS
{
    STATUS_NDIS_OFFLOAD_POLICY              = NTSTATUS(0xc023100f),
    STATUS_NDIS_OFFLOAD_CONNECTION_REJECTED = NTSTATUS(0xc0231012),
    STATUS_NDIS_OFFLOAD_PATH_REJECTED       = NTSTATUS(0xc0231013),
}

enum : NTSTATUS
{
    STATUS_TPM_ERROR_MASK        = NTSTATUS(0xc0290000),
    STATUS_TPM_AUTHFAIL          = NTSTATUS(0xc0290001),
    STATUS_TPM_BADINDEX          = NTSTATUS(0xc0290002),
    STATUS_TPM_BAD_PARAMETER     = NTSTATUS(0xc0290003),
    STATUS_TPM_AUDITFAILURE      = NTSTATUS(0xc0290004),
    STATUS_TPM_CLEAR_DISABLED    = NTSTATUS(0xc0290005),
    STATUS_TPM_DEACTIVATED       = NTSTATUS(0xc0290006),
    STATUS_TPM_DISABLED          = NTSTATUS(0xc0290007),
    STATUS_TPM_DISABLED_CMD      = NTSTATUS(0xc0290008),
    STATUS_TPM_FAIL              = NTSTATUS(0xc0290009),
    STATUS_TPM_BAD_ORDINAL       = NTSTATUS(0xc029000a),
    STATUS_TPM_INSTALL_DISABLED  = NTSTATUS(0xc029000b),
    STATUS_TPM_INVALID_KEYHANDLE = NTSTATUS(0xc029000c),
}

enum : NTSTATUS
{
    STATUS_TPM_KEYNOTFOUND       = NTSTATUS(0xc029000d),
    STATUS_TPM_INAPPROPRIATE_ENC = NTSTATUS(0xc029000e),
}

enum : NTSTATUS
{
    STATUS_TPM_MIGRATEFAIL        = NTSTATUS(0xc029000f),
    STATUS_TPM_INVALID_PCR_INFO   = NTSTATUS(0xc0290010),
    STATUS_TPM_NOSPACE            = NTSTATUS(0xc0290011),
    STATUS_TPM_NOSRK              = NTSTATUS(0xc0290012),
    STATUS_TPM_NOTSEALED_BLOB     = NTSTATUS(0xc0290013),
    STATUS_TPM_OWNER_SET          = NTSTATUS(0xc0290014),
    STATUS_TPM_RESOURCES          = NTSTATUS(0xc0290015),
    STATUS_TPM_SHORTRANDOM        = NTSTATUS(0xc0290016),
    STATUS_TPM_SIZE               = NTSTATUS(0xc0290017),
    STATUS_TPM_WRONGPCRVAL        = NTSTATUS(0xc0290018),
    STATUS_TPM_BAD_PARAM_SIZE     = NTSTATUS(0xc0290019),
    STATUS_TPM_SHA_THREAD         = NTSTATUS(0xc029001a),
    STATUS_TPM_SHA_ERROR          = NTSTATUS(0xc029001b),
    STATUS_TPM_FAILEDSELFTEST     = NTSTATUS(0xc029001c),
    STATUS_TPM_AUTH2FAIL          = NTSTATUS(0xc029001d),
    STATUS_TPM_BADTAG             = NTSTATUS(0xc029001e),
    STATUS_TPM_IOERROR            = NTSTATUS(0xc029001f),
    STATUS_TPM_ENCRYPT_ERROR      = NTSTATUS(0xc0290020),
    STATUS_TPM_DECRYPT_ERROR      = NTSTATUS(0xc0290021),
    STATUS_TPM_INVALID_AUTHHANDLE = NTSTATUS(0xc0290022),
}

enum : NTSTATUS
{
    STATUS_TPM_NO_ENDORSEMENT    = NTSTATUS(0xc0290023),
    STATUS_TPM_INVALID_KEYUSAGE  = NTSTATUS(0xc0290024),
    STATUS_TPM_WRONG_ENTITYTYPE  = NTSTATUS(0xc0290025),
    STATUS_TPM_INVALID_POSTINIT  = NTSTATUS(0xc0290026),
    STATUS_TPM_INAPPROPRIATE_SIG = NTSTATUS(0xc0290027),
}

enum : NTSTATUS
{
    STATUS_TPM_BAD_KEY_PROPERTY  = NTSTATUS(0xc0290028),
    STATUS_TPM_BAD_MIGRATION     = NTSTATUS(0xc0290029),
    STATUS_TPM_BAD_SCHEME        = NTSTATUS(0xc029002a),
    STATUS_TPM_BAD_DATASIZE      = NTSTATUS(0xc029002b),
    STATUS_TPM_BAD_MODE          = NTSTATUS(0xc029002c),
    STATUS_TPM_BAD_PRESENCE      = NTSTATUS(0xc029002d),
    STATUS_TPM_BAD_VERSION       = NTSTATUS(0xc029002e),
    STATUS_TPM_NO_WRAP_TRANSPORT = NTSTATUS(0xc029002f),
}

enum : NTSTATUS
{
    STATUS_TPM_AUDITFAIL_UNSUCCESSFUL = NTSTATUS(0xc0290030),
    STATUS_TPM_AUDITFAIL_SUCCESSFUL   = NTSTATUS(0xc0290031),
}

enum : NTSTATUS
{
    STATUS_TPM_NOTRESETABLE      = NTSTATUS(0xc0290032),
    STATUS_TPM_NOTLOCAL          = NTSTATUS(0xc0290033),
    STATUS_TPM_BAD_TYPE          = NTSTATUS(0xc0290034),
    STATUS_TPM_INVALID_RESOURCE  = NTSTATUS(0xc0290035),
    STATUS_TPM_NOTFIPS           = NTSTATUS(0xc0290036),
    STATUS_TPM_INVALID_FAMILY    = NTSTATUS(0xc0290037),
    STATUS_TPM_NO_NV_PERMISSION  = NTSTATUS(0xc0290038),
    STATUS_TPM_REQUIRES_SIGN     = NTSTATUS(0xc0290039),
    STATUS_TPM_KEY_NOTSUPPORTED  = NTSTATUS(0xc029003a),
    STATUS_TPM_AUTH_CONFLICT     = NTSTATUS(0xc029003b),
    STATUS_TPM_AREA_LOCKED       = NTSTATUS(0xc029003c),
    STATUS_TPM_BAD_LOCALITY      = NTSTATUS(0xc029003d),
    STATUS_TPM_READ_ONLY         = NTSTATUS(0xc029003e),
    STATUS_TPM_PER_NOWRITE       = NTSTATUS(0xc029003f),
    STATUS_TPM_FAMILYCOUNT       = NTSTATUS(0xc0290040),
    STATUS_TPM_WRITE_LOCKED      = NTSTATUS(0xc0290041),
    STATUS_TPM_BAD_ATTRIBUTES    = NTSTATUS(0xc0290042),
    STATUS_TPM_INVALID_STRUCTURE = NTSTATUS(0xc0290043),
}

enum NTSTATUS STATUS_TPM_KEY_OWNER_CONTROL = NTSTATUS(0xc0290044);

enum : NTSTATUS
{
    STATUS_TPM_BAD_COUNTER            = NTSTATUS(0xc0290045),
    STATUS_TPM_NOT_FULLWRITE          = NTSTATUS(0xc0290046),
    STATUS_TPM_CONTEXT_GAP            = NTSTATUS(0xc0290047),
    STATUS_TPM_MAXNVWRITES            = NTSTATUS(0xc0290048),
    STATUS_TPM_NOOPERATOR             = NTSTATUS(0xc0290049),
    STATUS_TPM_RESOURCEMISSING        = NTSTATUS(0xc029004a),
    STATUS_TPM_DELEGATE_LOCK          = NTSTATUS(0xc029004b),
    STATUS_TPM_DELEGATE_FAMILY        = NTSTATUS(0xc029004c),
    STATUS_TPM_DELEGATE_ADMIN         = NTSTATUS(0xc029004d),
    STATUS_TPM_TRANSPORT_NOTEXCLUSIVE = NTSTATUS(0xc029004e),
}

enum : NTSTATUS
{
    STATUS_TPM_OWNER_CONTROL          = NTSTATUS(0xc029004f),
    STATUS_TPM_DAA_RESOURCES          = NTSTATUS(0xc0290050),
    STATUS_TPM_DAA_INPUT_DATA0        = NTSTATUS(0xc0290051),
    STATUS_TPM_DAA_INPUT_DATA1        = NTSTATUS(0xc0290052),
    STATUS_TPM_DAA_ISSUER_SETTINGS    = NTSTATUS(0xc0290053),
    STATUS_TPM_DAA_TPM_SETTINGS       = NTSTATUS(0xc0290054),
    STATUS_TPM_DAA_STAGE              = NTSTATUS(0xc0290055),
    STATUS_TPM_DAA_ISSUER_VALIDITY    = NTSTATUS(0xc0290056),
    STATUS_TPM_DAA_WRONG_W            = NTSTATUS(0xc0290057),
    STATUS_TPM_BAD_HANDLE             = NTSTATUS(0xc0290058),
    STATUS_TPM_BAD_DELEGATE           = NTSTATUS(0xc0290059),
    STATUS_TPM_BADCONTEXT             = NTSTATUS(0xc029005a),
    STATUS_TPM_TOOMANYCONTEXTS        = NTSTATUS(0xc029005b),
    STATUS_TPM_MA_TICKET_SIGNATURE    = NTSTATUS(0xc029005c),
    STATUS_TPM_MA_DESTINATION         = NTSTATUS(0xc029005d),
    STATUS_TPM_MA_SOURCE              = NTSTATUS(0xc029005e),
    STATUS_TPM_MA_AUTHORITY           = NTSTATUS(0xc029005f),
    STATUS_TPM_PERMANENTEK            = NTSTATUS(0xc0290061),
    STATUS_TPM_BAD_SIGNATURE          = NTSTATUS(0xc0290062),
    STATUS_TPM_NOCONTEXTSPACE         = NTSTATUS(0xc0290063),
    STATUS_TPM_20_E_ASYMMETRIC        = NTSTATUS(0xc0290081),
    STATUS_TPM_20_E_ATTRIBUTES        = NTSTATUS(0xc0290082),
    STATUS_TPM_20_E_HASH              = NTSTATUS(0xc0290083),
    STATUS_TPM_20_E_VALUE             = NTSTATUS(0xc0290084),
    STATUS_TPM_20_E_HIERARCHY         = NTSTATUS(0xc0290085),
    STATUS_TPM_20_E_KEY_SIZE          = NTSTATUS(0xc0290087),
    STATUS_TPM_20_E_MGF               = NTSTATUS(0xc0290088),
    STATUS_TPM_20_E_MODE              = NTSTATUS(0xc0290089),
    STATUS_TPM_20_E_TYPE              = NTSTATUS(0xc029008a),
    STATUS_TPM_20_E_HANDLE            = NTSTATUS(0xc029008b),
    STATUS_TPM_20_E_KDF               = NTSTATUS(0xc029008c),
    STATUS_TPM_20_E_RANGE             = NTSTATUS(0xc029008d),
    STATUS_TPM_20_E_AUTH_FAIL         = NTSTATUS(0xc029008e),
    STATUS_TPM_20_E_NONCE             = NTSTATUS(0xc029008f),
    STATUS_TPM_20_E_PP                = NTSTATUS(0xc0290090),
    STATUS_TPM_20_E_SCHEME            = NTSTATUS(0xc0290092),
    STATUS_TPM_20_E_SIZE              = NTSTATUS(0xc0290095),
    STATUS_TPM_20_E_SYMMETRIC         = NTSTATUS(0xc0290096),
    STATUS_TPM_20_E_TAG               = NTSTATUS(0xc0290097),
    STATUS_TPM_20_E_SELECTOR          = NTSTATUS(0xc0290098),
    STATUS_TPM_20_E_INSUFFICIENT      = NTSTATUS(0xc029009a),
    STATUS_TPM_20_E_SIGNATURE         = NTSTATUS(0xc029009b),
    STATUS_TPM_20_E_KEY               = NTSTATUS(0xc029009c),
    STATUS_TPM_20_E_POLICY_FAIL       = NTSTATUS(0xc029009d),
    STATUS_TPM_20_E_INTEGRITY         = NTSTATUS(0xc029009f),
    STATUS_TPM_20_E_TICKET            = NTSTATUS(0xc02900a0),
    STATUS_TPM_20_E_RESERVED_BITS     = NTSTATUS(0xc02900a1),
    STATUS_TPM_20_E_BAD_AUTH          = NTSTATUS(0xc02900a2),
    STATUS_TPM_20_E_EXPIRED           = NTSTATUS(0xc02900a3),
    STATUS_TPM_20_E_POLICY_CC         = NTSTATUS(0xc02900a4),
    STATUS_TPM_20_E_BINDING           = NTSTATUS(0xc02900a5),
    STATUS_TPM_20_E_CURVE             = NTSTATUS(0xc02900a6),
    STATUS_TPM_20_E_ECC_POINT         = NTSTATUS(0xc02900a7),
    STATUS_TPM_20_E_INITIALIZE        = NTSTATUS(0xc0290100),
    STATUS_TPM_20_E_FAILURE           = NTSTATUS(0xc0290101),
    STATUS_TPM_20_E_SEQUENCE          = NTSTATUS(0xc0290103),
    STATUS_TPM_20_E_PRIVATE           = NTSTATUS(0xc029010b),
    STATUS_TPM_20_E_HMAC              = NTSTATUS(0xc0290119),
    STATUS_TPM_20_E_DISABLED          = NTSTATUS(0xc0290120),
    STATUS_TPM_20_E_EXCLUSIVE         = NTSTATUS(0xc0290121),
    STATUS_TPM_20_E_ECC_CURVE         = NTSTATUS(0xc0290123),
    STATUS_TPM_20_E_AUTH_TYPE         = NTSTATUS(0xc0290124),
    STATUS_TPM_20_E_AUTH_MISSING      = NTSTATUS(0xc0290125),
    STATUS_TPM_20_E_POLICY            = NTSTATUS(0xc0290126),
    STATUS_TPM_20_E_PCR               = NTSTATUS(0xc0290127),
    STATUS_TPM_20_E_PCR_CHANGED       = NTSTATUS(0xc0290128),
    STATUS_TPM_20_E_UPGRADE           = NTSTATUS(0xc029012d),
    STATUS_TPM_20_E_TOO_MANY_CONTEXTS = NTSTATUS(0xc029012e),
    STATUS_TPM_20_E_AUTH_UNAVAILABLE  = NTSTATUS(0xc029012f),
    STATUS_TPM_20_E_REBOOT            = NTSTATUS(0xc0290130),
    STATUS_TPM_20_E_UNBALANCED        = NTSTATUS(0xc0290131),
    STATUS_TPM_20_E_COMMAND_SIZE      = NTSTATUS(0xc0290142),
    STATUS_TPM_20_E_COMMAND_CODE      = NTSTATUS(0xc0290143),
    STATUS_TPM_20_E_AUTHSIZE          = NTSTATUS(0xc0290144),
    STATUS_TPM_20_E_AUTH_CONTEXT      = NTSTATUS(0xc0290145),
    STATUS_TPM_20_E_NV_RANGE          = NTSTATUS(0xc0290146),
    STATUS_TPM_20_E_NV_SIZE           = NTSTATUS(0xc0290147),
    STATUS_TPM_20_E_NV_LOCKED         = NTSTATUS(0xc0290148),
    STATUS_TPM_20_E_NV_AUTHORIZATION  = NTSTATUS(0xc0290149),
    STATUS_TPM_20_E_NV_UNINITIALIZED  = NTSTATUS(0xc029014a),
    STATUS_TPM_20_E_NV_SPACE          = NTSTATUS(0xc029014b),
    STATUS_TPM_20_E_NV_DEFINED        = NTSTATUS(0xc029014c),
    STATUS_TPM_20_E_BAD_CONTEXT       = NTSTATUS(0xc0290150),
    STATUS_TPM_20_E_CPHASH            = NTSTATUS(0xc0290151),
    STATUS_TPM_20_E_PARENT            = NTSTATUS(0xc0290152),
    STATUS_TPM_20_E_NEEDS_TEST        = NTSTATUS(0xc0290153),
    STATUS_TPM_20_E_NO_RESULT         = NTSTATUS(0xc0290154),
    STATUS_TPM_20_E_SENSITIVE         = NTSTATUS(0xc0290155),
    STATUS_TPM_COMMAND_BLOCKED        = NTSTATUS(0xc0290400),
    STATUS_TPM_INVALID_HANDLE         = NTSTATUS(0xc0290401),
    STATUS_TPM_DUPLICATE_VHANDLE      = NTSTATUS(0xc0290402),
}

enum : NTSTATUS
{
    STATUS_TPM_EMBEDDED_COMMAND_BLOCKED     = NTSTATUS(0xc0290403),
    STATUS_TPM_EMBEDDED_COMMAND_UNSUPPORTED = NTSTATUS(0xc0290404),
}

enum : NTSTATUS
{
    STATUS_TPM_RETRY               = NTSTATUS(0xc0290800),
    STATUS_TPM_NEEDS_SELFTEST      = NTSTATUS(0xc0290801),
    STATUS_TPM_DOING_SELFTEST      = NTSTATUS(0xc0290802),
    STATUS_TPM_DEFEND_LOCK_RUNNING = NTSTATUS(0xc0290803),
}

enum : NTSTATUS
{
    STATUS_TPM_COMMAND_CANCELED  = NTSTATUS(0xc0291001),
    STATUS_TPM_TOO_MANY_CONTEXTS = NTSTATUS(0xc0291002),
}

enum : NTSTATUS
{
    STATUS_TPM_NOT_FOUND           = NTSTATUS(0xc0291003),
    STATUS_TPM_ACCESS_DENIED       = NTSTATUS(0xc0291004),
    STATUS_TPM_INSUFFICIENT_BUFFER = NTSTATUS(0xc0291005),
}

enum NTSTATUS STATUS_TPM_PPI_FUNCTION_UNSUPPORTED = NTSTATUS(0xc0291006);
enum NTSTATUS STATUS_TPM_IN_EXCLUSIVE_MODE = NTSTATUS(0xc0291007);
enum NTSTATUS STATUS_TPM_REBOOT_REQUIRED = NTSTATUS(0xc0291008);

enum : NTSTATUS
{
    STATUS_PCP_ERROR_MASK        = NTSTATUS(0xc0292000),
    STATUS_PCP_DEVICE_NOT_READY  = NTSTATUS(0xc0292001),
    STATUS_PCP_INVALID_HANDLE    = NTSTATUS(0xc0292002),
    STATUS_PCP_INVALID_PARAMETER = NTSTATUS(0xc0292003),
}

enum NTSTATUS STATUS_PCP_FLAG_NOT_SUPPORTED = NTSTATUS(0xc0292004);

enum : NTSTATUS
{
    STATUS_PCP_NOT_SUPPORTED          = NTSTATUS(0xc0292005),
    STATUS_PCP_BUFFER_TOO_SMALL       = NTSTATUS(0xc0292006),
    STATUS_PCP_INTERNAL_ERROR         = NTSTATUS(0xc0292007),
    STATUS_PCP_AUTHENTICATION_FAILED  = NTSTATUS(0xc0292008),
    STATUS_PCP_AUTHENTICATION_IGNORED = NTSTATUS(0xc0292009),
}

enum : NTSTATUS
{
    STATUS_PCP_POLICY_NOT_FOUND  = NTSTATUS(0xc029200a),
    STATUS_PCP_PROFILE_NOT_FOUND = NTSTATUS(0xc029200b),
}

enum NTSTATUS STATUS_PCP_VALIDATION_FAILED = NTSTATUS(0xc029200c);

enum : NTSTATUS
{
    STATUS_PCP_DEVICE_NOT_FOUND     = NTSTATUS(0xc029200d),
    STATUS_PCP_WRONG_PARENT         = NTSTATUS(0xc029200e),
    STATUS_PCP_KEY_NOT_LOADED       = NTSTATUS(0xc029200f),
    STATUS_PCP_NO_KEY_CERTIFICATION = NTSTATUS(0xc0292010),
}

enum NTSTATUS STATUS_PCP_KEY_NOT_FINALIZED = NTSTATUS(0xc0292011);
enum NTSTATUS STATUS_PCP_ATTESTATION_CHALLENGE_NOT_SET = NTSTATUS(0xc0292012);

enum : NTSTATUS
{
    STATUS_PCP_NOT_PCR_BOUND                  = NTSTATUS(0xc0292013),
    STATUS_PCP_KEY_ALREADY_FINALIZED          = NTSTATUS(0xc0292014),
    STATUS_PCP_KEY_USAGE_POLICY_NOT_SUPPORTED = NTSTATUS(0xc0292015),
    STATUS_PCP_KEY_USAGE_POLICY_INVALID       = NTSTATUS(0xc0292016),
}

enum : NTSTATUS
{
    STATUS_PCP_SOFT_KEY_ERROR        = NTSTATUS(0xc0292017),
    STATUS_PCP_KEY_NOT_AUTHENTICATED = NTSTATUS(0xc0292018),
    STATUS_PCP_KEY_NOT_AIK           = NTSTATUS(0xc0292019),
    STATUS_PCP_KEY_NOT_SIGNING_KEY   = NTSTATUS(0xc029201a),
}

enum : NTSTATUS
{
    STATUS_PCP_LOCKED_OUT               = NTSTATUS(0xc029201b),
    STATUS_PCP_CLAIM_TYPE_NOT_SUPPORTED = NTSTATUS(0xc029201c),
}

enum NTSTATUS STATUS_PCP_TPM_VERSION_NOT_SUPPORTED = NTSTATUS(0xc029201d);
enum NTSTATUS STATUS_PCP_BUFFER_LENGTH_MISMATCH = NTSTATUS(0xc029201e);
enum NTSTATUS STATUS_PCP_IFX_RSA_KEY_CREATION_BLOCKED = NTSTATUS(0xc029201f);

enum : NTSTATUS
{
    STATUS_PCP_TICKET_MISSING           = NTSTATUS(0xc0292020),
    STATUS_PCP_RAW_POLICY_NOT_SUPPORTED = NTSTATUS(0xc0292021),
}

enum NTSTATUS STATUS_PCP_KEY_HANDLE_INVALIDATED = NTSTATUS(0xc0292022);
enum NTSTATUS STATUS_PCP_UNSUPPORTED_PSS_SALT = NTSTATUS(0x40292023);

enum : NTSTATUS
{
    STATUS_RTPM_CONTEXT_CONTINUE    = NTSTATUS(0x00293000),
    STATUS_RTPM_CONTEXT_COMPLETE    = NTSTATUS(0x00293001),
    STATUS_RTPM_NO_RESULT           = NTSTATUS(0xc0293002),
    STATUS_RTPM_PCR_READ_INCOMPLETE = NTSTATUS(0xc0293003),
}

enum : NTSTATUS
{
    STATUS_RTPM_INVALID_CONTEXT = NTSTATUS(0xc0293004),
    STATUS_RTPM_UNSUPPORTED_CMD = NTSTATUS(0xc0293005),
}

enum NTSTATUS STATUS_TPM_ZERO_EXHAUST_ENABLED = NTSTATUS(0xc0294000);
enum NTSTATUS STATUS_DRTM_ENVIRONMENT_UNSAFE = NTSTATUS(0xc0295000);
enum NTSTATUS STATUS_DRTM_NO_DIRECT_AUTH_FOR_CURRENT_MLE = NTSTATUS(0xc0295001);

enum : NTSTATUS
{
    STATUS_HV_INVALID_HYPERCALL_CODE  = NTSTATUS(0xc0350002),
    STATUS_HV_INVALID_HYPERCALL_INPUT = NTSTATUS(0xc0350003),
    STATUS_HV_INVALID_ALIGNMENT       = NTSTATUS(0xc0350004),
    STATUS_HV_INVALID_PARAMETER       = NTSTATUS(0xc0350005),
}

enum : NTSTATUS
{
    STATUS_HV_ACCESS_DENIED           = NTSTATUS(0xc0350006),
    STATUS_HV_INVALID_PARTITION_STATE = NTSTATUS(0xc0350007),
}

enum NTSTATUS STATUS_HV_OPERATION_DENIED = NTSTATUS(0xc0350008);
enum NTSTATUS STATUS_HV_UNKNOWN_PROPERTY = NTSTATUS(0xc0350009);
enum NTSTATUS STATUS_HV_PROPERTY_VALUE_OUT_OF_RANGE = NTSTATUS(0xc035000a);
enum NTSTATUS STATUS_HV_INSUFFICIENT_MEMORY = NTSTATUS(0xc035000b);
enum NTSTATUS STATUS_HV_PARTITION_TOO_DEEP = NTSTATUS(0xc035000c);

enum : NTSTATUS
{
    STATUS_HV_INVALID_PARTITION_ID  = NTSTATUS(0xc035000d),
    STATUS_HV_INVALID_VP_INDEX      = NTSTATUS(0xc035000e),
    STATUS_HV_INVALID_PORT_ID       = NTSTATUS(0xc0350011),
    STATUS_HV_INVALID_CONNECTION_ID = NTSTATUS(0xc0350012),
}

enum NTSTATUS STATUS_HV_INSUFFICIENT_BUFFERS = NTSTATUS(0xc0350013);
enum NTSTATUS STATUS_HV_NOT_ACKNOWLEDGED = NTSTATUS(0xc0350014);
enum NTSTATUS STATUS_HV_INVALID_VP_STATE = NTSTATUS(0xc0350015);

enum : NTSTATUS
{
    STATUS_HV_ACKNOWLEDGED               = NTSTATUS(0xc0350016),
    STATUS_HV_INVALID_SAVE_RESTORE_STATE = NTSTATUS(0xc0350017),
    STATUS_HV_INVALID_SYNIC_STATE        = NTSTATUS(0xc0350018),
}

enum : NTSTATUS
{
    STATUS_HV_OBJECT_IN_USE                 = NTSTATUS(0xc0350019),
    STATUS_HV_INVALID_PROXIMITY_DOMAIN_INFO = NTSTATUS(0xc035001a),
}

enum : NTSTATUS
{
    STATUS_HV_NO_DATA             = NTSTATUS(0xc035001b),
    STATUS_HV_INACTIVE            = NTSTATUS(0xc035001c),
    STATUS_HV_NO_RESOURCES        = NTSTATUS(0xc035001d),
    STATUS_HV_FEATURE_UNAVAILABLE = NTSTATUS(0xc035001e),
}

enum : NTSTATUS
{
    STATUS_HV_INSUFFICIENT_BUFFER         = NTSTATUS(0xc0350033),
    STATUS_HV_INSUFFICIENT_DEVICE_DOMAINS = NTSTATUS(0xc0350038),
}

enum NTSTATUS STATUS_HV_CPUID_FEATURE_VALIDATION_ERROR = NTSTATUS(0xc035003c);
enum NTSTATUS STATUS_HV_CPUID_XSAVE_FEATURE_VALIDATION_ERROR = NTSTATUS(0xc035003d);
enum NTSTATUS STATUS_HV_PROCESSOR_STARTUP_TIMEOUT = NTSTATUS(0xc035003e);

enum : NTSTATUS
{
    STATUS_HV_SMX_ENABLED            = NTSTATUS(0xc035003f),
    STATUS_HV_INVALID_LP_INDEX       = NTSTATUS(0xc0350041),
    STATUS_HV_INVALID_REGISTER_VALUE = NTSTATUS(0xc0350050),
    STATUS_HV_INVALID_VTL_STATE      = NTSTATUS(0xc0350051),
}

enum NTSTATUS STATUS_HV_NX_NOT_DETECTED = NTSTATUS(0xc0350055);

enum : NTSTATUS
{
    STATUS_HV_INVALID_DEVICE_ID    = NTSTATUS(0xc0350057),
    STATUS_HV_INVALID_DEVICE_STATE = NTSTATUS(0xc0350058),
}

enum NTSTATUS STATUS_HV_PENDING_PAGE_REQUESTS = NTSTATUS(0x00350059);
enum NTSTATUS STATUS_HV_PAGE_REQUEST_INVALID = NTSTATUS(0xc0350060);

enum : NTSTATUS
{
    STATUS_HV_INVALID_CPU_GROUP_ID    = NTSTATUS(0xc035006f),
    STATUS_HV_INVALID_CPU_GROUP_STATE = NTSTATUS(0xc0350070),
}

enum NTSTATUS STATUS_HV_OPERATION_FAILED = NTSTATUS(0xc0350071);
enum NTSTATUS STATUS_HV_NOT_ALLOWED_WITH_NESTED_VIRT_ACTIVE = NTSTATUS(0xc0350072);
enum NTSTATUS STATUS_HV_INSUFFICIENT_ROOT_MEMORY = NTSTATUS(0xc0350073);
enum NTSTATUS STATUS_HV_EVENT_BUFFER_ALREADY_FREED = NTSTATUS(0xc0350074);
enum NTSTATUS STATUS_HV_INSUFFICIENT_CONTIGUOUS_MEMORY = NTSTATUS(0xc0350075);
enum NTSTATUS STATUS_HV_DEVICE_NOT_IN_DOMAIN = NTSTATUS(0xc0350076);

enum : NTSTATUS
{
    STATUS_HV_NESTED_VM_EXIT    = NTSTATUS(0xc0350077),
    STATUS_HV_CALL_PENDING      = NTSTATUS(0xc0350079),
    STATUS_HV_MSR_ACCESS_FAILED = NTSTATUS(0xc0350080),
}

enum : NTSTATUS
{
    STATUS_HV_INSUFFICIENT_MEMORY_MIRRORING                 = NTSTATUS(0xc0350081),
    STATUS_HV_INSUFFICIENT_CONTIGUOUS_MEMORY_MIRRORING      = NTSTATUS(0xc0350082),
    STATUS_HV_INSUFFICIENT_CONTIGUOUS_ROOT_MEMORY           = NTSTATUS(0xc0350083),
    STATUS_HV_INSUFFICIENT_ROOT_MEMORY_MIRRORING            = NTSTATUS(0xc0350084),
    STATUS_HV_INSUFFICIENT_CONTIGUOUS_ROOT_MEMORY_MIRRORING = NTSTATUS(0xc0350085),
}

enum NTSTATUS STATUS_HV_VTL_ALREADY_ENABLED = NTSTATUS(0xc0350086);

enum : NTSTATUS
{
    STATUS_HV_SPDM_REQUEST = NTSTATUS(0xc0350088),
    STATUS_HV_NOT_PRESENT  = NTSTATUS(0xc0351000),
}

enum NTSTATUS STATUS_VID_DUPLICATE_HANDLER = NTSTATUS(0xc0370001);
enum NTSTATUS STATUS_VID_TOO_MANY_HANDLERS = NTSTATUS(0xc0370002);

enum : NTSTATUS
{
    STATUS_VID_QUEUE_FULL          = NTSTATUS(0xc0370003),
    STATUS_VID_HANDLER_NOT_PRESENT = NTSTATUS(0xc0370004),
}

enum NTSTATUS STATUS_VID_INVALID_OBJECT_NAME = NTSTATUS(0xc0370005);
enum NTSTATUS STATUS_VID_PARTITION_NAME_TOO_LONG = NTSTATUS(0xc0370006);
enum NTSTATUS STATUS_VID_MESSAGE_QUEUE_NAME_TOO_LONG = NTSTATUS(0xc0370007);

enum : NTSTATUS
{
    STATUS_VID_PARTITION_ALREADY_EXISTS = NTSTATUS(0xc0370008),
    STATUS_VID_PARTITION_DOES_NOT_EXIST = NTSTATUS(0xc0370009),
    STATUS_VID_PARTITION_NAME_NOT_FOUND = NTSTATUS(0xc037000a),
}

enum NTSTATUS STATUS_VID_MESSAGE_QUEUE_ALREADY_EXISTS = NTSTATUS(0xc037000b);
enum NTSTATUS STATUS_VID_EXCEEDED_MBP_ENTRY_MAP_LIMIT = NTSTATUS(0xc037000c);
enum NTSTATUS STATUS_VID_MB_STILL_REFERENCED = NTSTATUS(0xc037000d);
enum NTSTATUS STATUS_VID_CHILD_GPA_PAGE_SET_CORRUPTED = NTSTATUS(0xc037000e);

enum : NTSTATUS
{
    STATUS_VID_INVALID_NUMA_SETTINGS   = NTSTATUS(0xc037000f),
    STATUS_VID_INVALID_NUMA_NODE_INDEX = NTSTATUS(0xc0370010),
}

enum NTSTATUS STATUS_VID_NOTIFICATION_QUEUE_ALREADY_ASSOCIATED = NTSTATUS(0xc0370011);
enum NTSTATUS STATUS_VID_INVALID_MEMORY_BLOCK_HANDLE = NTSTATUS(0xc0370012);
enum NTSTATUS STATUS_VID_PAGE_RANGE_OVERFLOW = NTSTATUS(0xc0370013);

enum : NTSTATUS
{
    STATUS_VID_INVALID_MESSAGE_QUEUE_HANDLE = NTSTATUS(0xc0370014),
    STATUS_VID_INVALID_GPA_RANGE_HANDLE     = NTSTATUS(0xc0370015),
}

enum NTSTATUS STATUS_VID_NO_MEMORY_BLOCK_NOTIFICATION_QUEUE = NTSTATUS(0xc0370016);
enum NTSTATUS STATUS_VID_MEMORY_BLOCK_LOCK_COUNT_EXCEEDED = NTSTATUS(0xc0370017);
enum NTSTATUS STATUS_VID_INVALID_PPM_HANDLE = NTSTATUS(0xc0370018);

enum : NTSTATUS
{
    STATUS_VID_MBPS_ARE_LOCKED      = NTSTATUS(0xc0370019),
    STATUS_VID_MESSAGE_QUEUE_CLOSED = NTSTATUS(0xc037001a),
}

enum NTSTATUS STATUS_VID_VIRTUAL_PROCESSOR_LIMIT_EXCEEDED = NTSTATUS(0xc037001b);

enum : NTSTATUS
{
    STATUS_VID_STOP_PENDING            = NTSTATUS(0xc037001c),
    STATUS_VID_INVALID_PROCESSOR_STATE = NTSTATUS(0xc037001d),
}

enum NTSTATUS STATUS_VID_EXCEEDED_KM_CONTEXT_COUNT_LIMIT = NTSTATUS(0xc037001e);
enum NTSTATUS STATUS_VID_KM_INTERFACE_ALREADY_INITIALIZED = NTSTATUS(0xc037001f);
enum NTSTATUS STATUS_VID_MB_PROPERTY_ALREADY_SET_RESET = NTSTATUS(0xc0370020);
enum NTSTATUS STATUS_VID_MMIO_RANGE_DESTROYED = NTSTATUS(0xc0370021);
enum NTSTATUS STATUS_VID_INVALID_CHILD_GPA_PAGE_SET = NTSTATUS(0xc0370022);

enum : NTSTATUS
{
    STATUS_VID_RESERVE_PAGE_SET_IS_BEING_USED = NTSTATUS(0xc0370023),
    STATUS_VID_RESERVE_PAGE_SET_TOO_SMALL     = NTSTATUS(0xc0370024),
}

enum NTSTATUS STATUS_VID_MBP_ALREADY_LOCKED_USING_RESERVED_PAGE = NTSTATUS(0xc0370025);
enum NTSTATUS STATUS_VID_MBP_COUNT_EXCEEDED_LIMIT = NTSTATUS(0xc0370026);

enum : NTSTATUS
{
    STATUS_VID_SAVED_STATE_CORRUPT           = NTSTATUS(0xc0370027),
    STATUS_VID_SAVED_STATE_UNRECOGNIZED_ITEM = NTSTATUS(0xc0370028),
    STATUS_VID_SAVED_STATE_INCOMPATIBLE      = NTSTATUS(0xc0370029),
}

enum NTSTATUS STATUS_VID_VTL_ACCESS_DENIED = NTSTATUS(0xc037002a);

enum : NTSTATUS
{
    STATUS_VID_INSUFFICIENT_RESOURCES_RESERVE         = NTSTATUS(0xc037002b),
    STATUS_VID_INSUFFICIENT_RESOURCES_PHYSICAL_BUFFER = NTSTATUS(0xc037002c),
    STATUS_VID_INSUFFICIENT_RESOURCES_HV_DEPOSIT      = NTSTATUS(0xc037002d),
}

enum NTSTATUS STATUS_VID_MEMORY_TYPE_NOT_SUPPORTED = NTSTATUS(0xc037002e);
enum NTSTATUS STATUS_VID_INSUFFICIENT_RESOURCES_WITHDRAW = NTSTATUS(0xc037002f);
enum NTSTATUS STATUS_VID_PROCESS_ALREADY_SET = NTSTATUS(0xc0370030);
enum NTSTATUS STATUS_DM_OPERATION_LIMIT_EXCEEDED = NTSTATUS(0xc0370600);
enum NTSTATUS STATUS_VID_REMOTE_NODE_PARENT_GPA_PAGES_USED = NTSTATUS(0x80370001);

enum : NTSTATUS
{
    STATUS_IPSEC_BAD_SPI                = NTSTATUS(0xc0360001),
    STATUS_IPSEC_SA_LIFETIME_EXPIRED    = NTSTATUS(0xc0360002),
    STATUS_IPSEC_WRONG_SA               = NTSTATUS(0xc0360003),
    STATUS_IPSEC_REPLAY_CHECK_FAILED    = NTSTATUS(0xc0360004),
    STATUS_IPSEC_INVALID_PACKET         = NTSTATUS(0xc0360005),
    STATUS_IPSEC_INTEGRITY_CHECK_FAILED = NTSTATUS(0xc0360006),
}

enum : NTSTATUS
{
    STATUS_IPSEC_CLEAR_TEXT_DROP                  = NTSTATUS(0xc0360007),
    STATUS_IPSEC_AUTH_FIREWALL_DROP               = NTSTATUS(0xc0360008),
    STATUS_IPSEC_THROTTLE_DROP                    = NTSTATUS(0xc0360009),
    STATUS_IPSEC_DOSP_BLOCK                       = NTSTATUS(0xc0368000),
    STATUS_IPSEC_DOSP_RECEIVED_MULTICAST          = NTSTATUS(0xc0368001),
    STATUS_IPSEC_DOSP_INVALID_PACKET              = NTSTATUS(0xc0368002),
    STATUS_IPSEC_DOSP_STATE_LOOKUP_FAILED         = NTSTATUS(0xc0368003),
    STATUS_IPSEC_DOSP_MAX_ENTRIES                 = NTSTATUS(0xc0368004),
    STATUS_IPSEC_DOSP_KEYMOD_NOT_ALLOWED          = NTSTATUS(0xc0368005),
    STATUS_IPSEC_DOSP_MAX_PER_IP_RATELIMIT_QUEUES = NTSTATUS(0xc0368006),
}

enum : NTSTATUS
{
    STATUS_VOLMGR_INCOMPLETE_REGENERATION   = NTSTATUS(0x80380001),
    STATUS_VOLMGR_INCOMPLETE_DISK_MIGRATION = NTSTATUS(0x80380002),
}

enum : NTSTATUS
{
    STATUS_VOLMGR_DATABASE_FULL                  = NTSTATUS(0xc0380001),
    STATUS_VOLMGR_DISK_CONFIGURATION_CORRUPTED   = NTSTATUS(0xc0380002),
    STATUS_VOLMGR_DISK_CONFIGURATION_NOT_IN_SYNC = NTSTATUS(0xc0380003),
}

enum NTSTATUS STATUS_VOLMGR_PACK_CONFIG_UPDATE_FAILED = NTSTATUS(0xc0380004);

enum : NTSTATUS
{
    STATUS_VOLMGR_DISK_CONTAINS_NON_SIMPLE_VOLUME                = NTSTATUS(0xc0380005),
    STATUS_VOLMGR_DISK_DUPLICATE                                 = NTSTATUS(0xc0380006),
    STATUS_VOLMGR_DISK_DYNAMIC                                   = NTSTATUS(0xc0380007),
    STATUS_VOLMGR_DISK_ID_INVALID                                = NTSTATUS(0xc0380008),
    STATUS_VOLMGR_DISK_INVALID                                   = NTSTATUS(0xc0380009),
    STATUS_VOLMGR_DISK_LAST_VOTER                                = NTSTATUS(0xc038000a),
    STATUS_VOLMGR_DISK_LAYOUT_INVALID                            = NTSTATUS(0xc038000b),
    STATUS_VOLMGR_DISK_LAYOUT_NON_BASIC_BETWEEN_BASIC_PARTITIONS = NTSTATUS(0xc038000c),
    STATUS_VOLMGR_DISK_LAYOUT_NOT_CYLINDER_ALIGNED               = NTSTATUS(0xc038000d),
    STATUS_VOLMGR_DISK_LAYOUT_PARTITIONS_TOO_SMALL               = NTSTATUS(0xc038000e),
    STATUS_VOLMGR_DISK_LAYOUT_PRIMARY_BETWEEN_LOGICAL_PARTITIONS = NTSTATUS(0xc038000f),
    STATUS_VOLMGR_DISK_LAYOUT_TOO_MANY_PARTITIONS                = NTSTATUS(0xc0380010),
    STATUS_VOLMGR_DISK_MISSING                                   = NTSTATUS(0xc0380011),
    STATUS_VOLMGR_DISK_NOT_EMPTY                                 = NTSTATUS(0xc0380012),
    STATUS_VOLMGR_DISK_NOT_ENOUGH_SPACE                          = NTSTATUS(0xc0380013),
    STATUS_VOLMGR_DISK_REVECTORING_FAILED                        = NTSTATUS(0xc0380014),
    STATUS_VOLMGR_DISK_SECTOR_SIZE_INVALID                       = NTSTATUS(0xc0380015),
    STATUS_VOLMGR_DISK_SET_NOT_CONTAINED                         = NTSTATUS(0xc0380016),
    STATUS_VOLMGR_DISK_USED_BY_MULTIPLE_MEMBERS                  = NTSTATUS(0xc0380017),
    STATUS_VOLMGR_DISK_USED_BY_MULTIPLE_PLEXES                   = NTSTATUS(0xc0380018),
}

enum NTSTATUS STATUS_VOLMGR_DYNAMIC_DISK_NOT_SUPPORTED = NTSTATUS(0xc0380019);

enum : NTSTATUS
{
    STATUS_VOLMGR_EXTENT_ALREADY_USED                = NTSTATUS(0xc038001a),
    STATUS_VOLMGR_EXTENT_NOT_CONTIGUOUS              = NTSTATUS(0xc038001b),
    STATUS_VOLMGR_EXTENT_NOT_IN_PUBLIC_REGION        = NTSTATUS(0xc038001c),
    STATUS_VOLMGR_EXTENT_NOT_SECTOR_ALIGNED          = NTSTATUS(0xc038001d),
    STATUS_VOLMGR_EXTENT_OVERLAPS_EBR_PARTITION      = NTSTATUS(0xc038001e),
    STATUS_VOLMGR_EXTENT_VOLUME_LENGTHS_DO_NOT_MATCH = NTSTATUS(0xc038001f),
}

enum NTSTATUS STATUS_VOLMGR_FAULT_TOLERANT_NOT_SUPPORTED = NTSTATUS(0xc0380020);
enum NTSTATUS STATUS_VOLMGR_INTERLEAVE_LENGTH_INVALID = NTSTATUS(0xc0380021);
enum NTSTATUS STATUS_VOLMGR_MAXIMUM_REGISTERED_USERS = NTSTATUS(0xc0380022);

enum : NTSTATUS
{
    STATUS_VOLMGR_MEMBER_IN_SYNC            = NTSTATUS(0xc0380023),
    STATUS_VOLMGR_MEMBER_INDEX_DUPLICATE    = NTSTATUS(0xc0380024),
    STATUS_VOLMGR_MEMBER_INDEX_INVALID      = NTSTATUS(0xc0380025),
    STATUS_VOLMGR_MEMBER_MISSING            = NTSTATUS(0xc0380026),
    STATUS_VOLMGR_MEMBER_NOT_DETACHED       = NTSTATUS(0xc0380027),
    STATUS_VOLMGR_MEMBER_REGENERATING       = NTSTATUS(0xc0380028),
    STATUS_VOLMGR_ALL_DISKS_FAILED          = NTSTATUS(0xc0380029),
    STATUS_VOLMGR_NO_REGISTERED_USERS       = NTSTATUS(0xc038002a),
    STATUS_VOLMGR_NO_SUCH_USER              = NTSTATUS(0xc038002b),
    STATUS_VOLMGR_NOTIFICATION_RESET        = NTSTATUS(0xc038002c),
    STATUS_VOLMGR_NUMBER_OF_MEMBERS_INVALID = NTSTATUS(0xc038002d),
    STATUS_VOLMGR_NUMBER_OF_PLEXES_INVALID  = NTSTATUS(0xc038002e),
}

enum : NTSTATUS
{
    STATUS_VOLMGR_PACK_DUPLICATE          = NTSTATUS(0xc038002f),
    STATUS_VOLMGR_PACK_ID_INVALID         = NTSTATUS(0xc0380030),
    STATUS_VOLMGR_PACK_INVALID            = NTSTATUS(0xc0380031),
    STATUS_VOLMGR_PACK_NAME_INVALID       = NTSTATUS(0xc0380032),
    STATUS_VOLMGR_PACK_OFFLINE            = NTSTATUS(0xc0380033),
    STATUS_VOLMGR_PACK_HAS_QUORUM         = NTSTATUS(0xc0380034),
    STATUS_VOLMGR_PACK_WITHOUT_QUORUM     = NTSTATUS(0xc0380035),
    STATUS_VOLMGR_PARTITION_STYLE_INVALID = NTSTATUS(0xc0380036),
    STATUS_VOLMGR_PARTITION_UPDATE_FAILED = NTSTATUS(0xc0380037),
    STATUS_VOLMGR_PLEX_IN_SYNC            = NTSTATUS(0xc0380038),
    STATUS_VOLMGR_PLEX_INDEX_DUPLICATE    = NTSTATUS(0xc0380039),
    STATUS_VOLMGR_PLEX_INDEX_INVALID      = NTSTATUS(0xc038003a),
    STATUS_VOLMGR_PLEX_LAST_ACTIVE        = NTSTATUS(0xc038003b),
    STATUS_VOLMGR_PLEX_MISSING            = NTSTATUS(0xc038003c),
    STATUS_VOLMGR_PLEX_REGENERATING       = NTSTATUS(0xc038003d),
    STATUS_VOLMGR_PLEX_TYPE_INVALID       = NTSTATUS(0xc038003e),
    STATUS_VOLMGR_PLEX_NOT_RAID5          = NTSTATUS(0xc038003f),
    STATUS_VOLMGR_PLEX_NOT_SIMPLE         = NTSTATUS(0xc0380040),
    STATUS_VOLMGR_STRUCTURE_SIZE_INVALID  = NTSTATUS(0xc0380041),
}

enum NTSTATUS STATUS_VOLMGR_TOO_MANY_NOTIFICATION_REQUESTS = NTSTATUS(0xc0380042);
enum NTSTATUS STATUS_VOLMGR_TRANSACTION_IN_PROGRESS = NTSTATUS(0xc0380043);
enum NTSTATUS STATUS_VOLMGR_UNEXPECTED_DISK_LAYOUT_CHANGE = NTSTATUS(0xc0380044);

enum : NTSTATUS
{
    STATUS_VOLMGR_VOLUME_CONTAINS_MISSING_DISK           = NTSTATUS(0xc0380045),
    STATUS_VOLMGR_VOLUME_ID_INVALID                      = NTSTATUS(0xc0380046),
    STATUS_VOLMGR_VOLUME_LENGTH_INVALID                  = NTSTATUS(0xc0380047),
    STATUS_VOLMGR_VOLUME_LENGTH_NOT_SECTOR_SIZE_MULTIPLE = NTSTATUS(0xc0380048),
    STATUS_VOLMGR_VOLUME_NOT_MIRRORED                    = NTSTATUS(0xc0380049),
    STATUS_VOLMGR_VOLUME_NOT_RETAINED                    = NTSTATUS(0xc038004a),
    STATUS_VOLMGR_VOLUME_OFFLINE                         = NTSTATUS(0xc038004b),
    STATUS_VOLMGR_VOLUME_RETAINED                        = NTSTATUS(0xc038004c),
    STATUS_VOLMGR_NUMBER_OF_EXTENTS_INVALID              = NTSTATUS(0xc038004d),
}

enum NTSTATUS STATUS_VOLMGR_DIFFERENT_SECTOR_SIZE = NTSTATUS(0xc038004e);

enum : NTSTATUS
{
    STATUS_VOLMGR_BAD_BOOT_DISK          = NTSTATUS(0xc038004f),
    STATUS_VOLMGR_PACK_CONFIG_OFFLINE    = NTSTATUS(0xc0380050),
    STATUS_VOLMGR_PACK_CONFIG_ONLINE     = NTSTATUS(0xc0380051),
    STATUS_VOLMGR_NOT_PRIMARY_PACK       = NTSTATUS(0xc0380052),
    STATUS_VOLMGR_PACK_LOG_UPDATE_FAILED = NTSTATUS(0xc0380053),
}

enum : NTSTATUS
{
    STATUS_VOLMGR_NUMBER_OF_DISKS_IN_PLEX_INVALID   = NTSTATUS(0xc0380054),
    STATUS_VOLMGR_NUMBER_OF_DISKS_IN_MEMBER_INVALID = NTSTATUS(0xc0380055),
}

enum : NTSTATUS
{
    STATUS_VOLMGR_VOLUME_MIRRORED         = NTSTATUS(0xc0380056),
    STATUS_VOLMGR_PLEX_NOT_SIMPLE_SPANNED = NTSTATUS(0xc0380057),
}

enum : NTSTATUS
{
    STATUS_VOLMGR_NO_VALID_LOG_COPIES     = NTSTATUS(0xc0380058),
    STATUS_VOLMGR_PRIMARY_PACK_PRESENT    = NTSTATUS(0xc0380059),
    STATUS_VOLMGR_NUMBER_OF_DISKS_INVALID = NTSTATUS(0xc038005a),
}

enum : NTSTATUS
{
    STATUS_VOLMGR_MIRROR_NOT_SUPPORTED = NTSTATUS(0xc038005b),
    STATUS_VOLMGR_RAID5_NOT_SUPPORTED  = NTSTATUS(0xc038005c),
}

enum NTSTATUS STATUS_BCD_NOT_ALL_ENTRIES_IMPORTED = NTSTATUS(0x80390001);
enum NTSTATUS STATUS_BCD_TOO_MANY_ELEMENTS = NTSTATUS(0xc0390002);
enum NTSTATUS STATUS_BCD_NOT_ALL_ENTRIES_SYNCHRONIZED = NTSTATUS(0x80390003);

enum : NTSTATUS
{
    STATUS_VHD_DRIVE_FOOTER_MISSING           = NTSTATUS(0xc03a0001),
    STATUS_VHD_DRIVE_FOOTER_CHECKSUM_MISMATCH = NTSTATUS(0xc03a0002),
    STATUS_VHD_DRIVE_FOOTER_CORRUPT           = NTSTATUS(0xc03a0003),
}

enum : NTSTATUS
{
    STATUS_VHD_FORMAT_UNKNOWN             = NTSTATUS(0xc03a0004),
    STATUS_VHD_FORMAT_UNSUPPORTED_VERSION = NTSTATUS(0xc03a0005),
}

enum : NTSTATUS
{
    STATUS_VHD_SPARSE_HEADER_CHECKSUM_MISMATCH   = NTSTATUS(0xc03a0006),
    STATUS_VHD_SPARSE_HEADER_UNSUPPORTED_VERSION = NTSTATUS(0xc03a0007),
    STATUS_VHD_SPARSE_HEADER_CORRUPT             = NTSTATUS(0xc03a0008),
}

enum : NTSTATUS
{
    STATUS_VHD_BLOCK_ALLOCATION_FAILURE       = NTSTATUS(0xc03a0009),
    STATUS_VHD_BLOCK_ALLOCATION_TABLE_CORRUPT = NTSTATUS(0xc03a000a),
}

enum NTSTATUS STATUS_VHD_INVALID_BLOCK_SIZE = NTSTATUS(0xc03a000b);

enum : NTSTATUS
{
    STATUS_VHD_BITMAP_MISMATCH      = NTSTATUS(0xc03a000c),
    STATUS_VHD_PARENT_VHD_NOT_FOUND = NTSTATUS(0xc03a000d),
}

enum : NTSTATUS
{
    STATUS_VHD_CHILD_PARENT_ID_MISMATCH        = NTSTATUS(0xc03a000e),
    STATUS_VHD_CHILD_PARENT_TIMESTAMP_MISMATCH = NTSTATUS(0xc03a000f),
}

enum : NTSTATUS
{
    STATUS_VHD_METADATA_READ_FAILURE  = NTSTATUS(0xc03a0010),
    STATUS_VHD_METADATA_WRITE_FAILURE = NTSTATUS(0xc03a0011),
}

enum : NTSTATUS
{
    STATUS_VHD_INVALID_SIZE      = NTSTATUS(0xc03a0012),
    STATUS_VHD_INVALID_FILE_SIZE = NTSTATUS(0xc03a0013),
}

enum : NTSTATUS
{
    STATUS_VIRTDISK_PROVIDER_NOT_FOUND = NTSTATUS(0xc03a0014),
    STATUS_VIRTDISK_NOT_VIRTUAL_DISK   = NTSTATUS(0xc03a0015),
}

enum NTSTATUS STATUS_VHD_PARENT_VHD_ACCESS_DENIED = NTSTATUS(0xc03a0016);
enum NTSTATUS STATUS_VHD_CHILD_PARENT_SIZE_MISMATCH = NTSTATUS(0xc03a0017);

enum : NTSTATUS
{
    STATUS_VHD_DIFFERENCING_CHAIN_CYCLE_DETECTED  = NTSTATUS(0xc03a0018),
    STATUS_VHD_DIFFERENCING_CHAIN_ERROR_IN_PARENT = NTSTATUS(0xc03a0019),
}

enum NTSTATUS STATUS_VIRTUAL_DISK_LIMITATION = NTSTATUS(0xc03a001a);

enum : NTSTATUS
{
    STATUS_VHD_INVALID_TYPE  = NTSTATUS(0xc03a001b),
    STATUS_VHD_INVALID_STATE = NTSTATUS(0xc03a001c),
}

enum NTSTATUS STATUS_VIRTDISK_UNSUPPORTED_DISK_SECTOR_SIZE = NTSTATUS(0xc03a001d);

enum : NTSTATUS
{
    STATUS_VIRTDISK_DISK_ALREADY_OWNED       = NTSTATUS(0xc03a001e),
    STATUS_VIRTDISK_DISK_ONLINE_AND_WRITABLE = NTSTATUS(0xc03a001f),
}

enum NTSTATUS STATUS_CTLOG_TRACKING_NOT_INITIALIZED = NTSTATUS(0xc03a0020);
enum NTSTATUS STATUS_CTLOG_LOGFILE_SIZE_EXCEEDED_MAXSIZE = NTSTATUS(0xc03a0021);

enum : NTSTATUS
{
    STATUS_CTLOG_VHD_CHANGED_OFFLINE        = NTSTATUS(0xc03a0022),
    STATUS_CTLOG_INVALID_TRACKING_STATE     = NTSTATUS(0xc03a0023),
    STATUS_CTLOG_INCONSISTENT_TRACKING_FILE = NTSTATUS(0xc03a0024),
}

enum : NTSTATUS
{
    STATUS_VHD_METADATA_FULL              = NTSTATUS(0xc03a0028),
    STATUS_VHD_INVALID_CHANGE_TRACKING_ID = NTSTATUS(0xc03a0029),
}

enum NTSTATUS STATUS_VHD_CHANGE_TRACKING_DISABLED = NTSTATUS(0xc03a002a);
enum NTSTATUS STATUS_VHD_MISSING_CHANGE_TRACKING_INFORMATION = NTSTATUS(0xc03a0030);
enum NTSTATUS STATUS_VHD_RESIZE_WOULD_TRUNCATE_DATA = NTSTATUS(0xc03a0031);
enum NTSTATUS STATUS_VHD_COULD_NOT_COMPUTE_MINIMUM_VIRTUAL_SIZE = NTSTATUS(0xc03a0032);
enum NTSTATUS STATUS_VHD_ALREADY_AT_OR_BELOW_MINIMUM_VIRTUAL_SIZE = NTSTATUS(0xc03a0033);
enum NTSTATUS STATUS_VHD_UNEXPECTED_ID = NTSTATUS(0xc03a0034);
enum NTSTATUS STATUS_QUERY_STORAGE_ERROR = NTSTATUS(0x803a0001);
enum NTSTATUS STATUS_GDI_HANDLE_LEAK = NTSTATUS(0x803f0001);

enum : NTSTATUS
{
    STATUS_RKF_KEY_NOT_FOUND = NTSTATUS(0xc0400001),
    STATUS_RKF_DUPLICATE_KEY = NTSTATUS(0xc0400002),
    STATUS_RKF_BLOB_FULL     = NTSTATUS(0xc0400003),
    STATUS_RKF_STORE_FULL    = NTSTATUS(0xc0400004),
    STATUS_RKF_FILE_BLOCKED  = NTSTATUS(0xc0400005),
    STATUS_RKF_ACTIVE_KEY    = NTSTATUS(0xc0400006),
}

enum : NTSTATUS
{
    STATUS_RDBSS_RESTART_OPERATION  = NTSTATUS(0xc0410001),
    STATUS_RDBSS_CONTINUE_OPERATION = NTSTATUS(0xc0410002),
    STATUS_RDBSS_POST_OPERATION     = NTSTATUS(0xc0410003),
    STATUS_RDBSS_RETRY_LOOKUP       = NTSTATUS(0xc0410004),
}

enum : NTSTATUS
{
    STATUS_BTH_ATT_INVALID_HANDLE              = NTSTATUS(0xc0420001),
    STATUS_BTH_ATT_READ_NOT_PERMITTED          = NTSTATUS(0xc0420002),
    STATUS_BTH_ATT_WRITE_NOT_PERMITTED         = NTSTATUS(0xc0420003),
    STATUS_BTH_ATT_INVALID_PDU                 = NTSTATUS(0xc0420004),
    STATUS_BTH_ATT_INSUFFICIENT_AUTHENTICATION = NTSTATUS(0xc0420005),
}

enum : NTSTATUS
{
    STATUS_BTH_ATT_REQUEST_NOT_SUPPORTED      = NTSTATUS(0xc0420006),
    STATUS_BTH_ATT_INVALID_OFFSET             = NTSTATUS(0xc0420007),
    STATUS_BTH_ATT_INSUFFICIENT_AUTHORIZATION = NTSTATUS(0xc0420008),
}

enum : NTSTATUS
{
    STATUS_BTH_ATT_PREPARE_QUEUE_FULL               = NTSTATUS(0xc0420009),
    STATUS_BTH_ATT_ATTRIBUTE_NOT_FOUND              = NTSTATUS(0xc042000a),
    STATUS_BTH_ATT_ATTRIBUTE_NOT_LONG               = NTSTATUS(0xc042000b),
    STATUS_BTH_ATT_INSUFFICIENT_ENCRYPTION_KEY_SIZE = NTSTATUS(0xc042000c),
}

enum NTSTATUS STATUS_BTH_ATT_INVALID_ATTRIBUTE_VALUE_LENGTH = NTSTATUS(0xc042000d);

enum : NTSTATUS
{
    STATUS_BTH_ATT_UNLIKELY                = NTSTATUS(0xc042000e),
    STATUS_BTH_ATT_INSUFFICIENT_ENCRYPTION = NTSTATUS(0xc042000f),
}

enum : NTSTATUS
{
    STATUS_BTH_ATT_UNSUPPORTED_GROUP_TYPE = NTSTATUS(0xc0420010),
    STATUS_BTH_ATT_INSUFFICIENT_RESOURCES = NTSTATUS(0xc0420011),
    STATUS_BTH_ATT_UNKNOWN_ERROR          = NTSTATUS(0xc0421000),
}

enum : NTSTATUS
{
    STATUS_SECUREBOOT_ROLLBACK_DETECTED                  = NTSTATUS(0xc0430001),
    STATUS_SECUREBOOT_POLICY_VIOLATION                   = NTSTATUS(0xc0430002),
    STATUS_SECUREBOOT_INVALID_POLICY                     = NTSTATUS(0xc0430003),
    STATUS_SECUREBOOT_POLICY_PUBLISHER_NOT_FOUND         = NTSTATUS(0xc0430004),
    STATUS_SECUREBOOT_POLICY_NOT_SIGNED                  = NTSTATUS(0xc0430005),
    STATUS_SECUREBOOT_NOT_ENABLED                        = NTSTATUS(0x80430006),
    STATUS_SECUREBOOT_FILE_REPLACED                      = NTSTATUS(0xc0430007),
    STATUS_SECUREBOOT_POLICY_NOT_AUTHORIZED              = NTSTATUS(0xc0430008),
    STATUS_SECUREBOOT_POLICY_UNKNOWN                     = NTSTATUS(0xc0430009),
    STATUS_SECUREBOOT_POLICY_MISSING_ANTIROLLBACKVERSION = NTSTATUS(0xc043000a),
}

enum : NTSTATUS
{
    STATUS_SECUREBOOT_PLATFORM_ID_MISMATCH         = NTSTATUS(0xc043000b),
    STATUS_SECUREBOOT_POLICY_ROLLBACK_DETECTED     = NTSTATUS(0xc043000c),
    STATUS_SECUREBOOT_POLICY_UPGRADE_MISMATCH      = NTSTATUS(0xc043000d),
    STATUS_SECUREBOOT_REQUIRED_POLICY_FILE_MISSING = NTSTATUS(0xc043000e),
}

enum : NTSTATUS
{
    STATUS_SECUREBOOT_NOT_BASE_POLICY         = NTSTATUS(0xc043000f),
    STATUS_SECUREBOOT_NOT_SUPPLEMENTAL_POLICY = NTSTATUS(0xc0430010),
}

enum : NTSTATUS
{
    STATUS_PLATFORM_MANIFEST_NOT_AUTHORIZED         = NTSTATUS(0xc0eb0001),
    STATUS_PLATFORM_MANIFEST_INVALID                = NTSTATUS(0xc0eb0002),
    STATUS_PLATFORM_MANIFEST_FILE_NOT_AUTHORIZED    = NTSTATUS(0xc0eb0003),
    STATUS_PLATFORM_MANIFEST_CATALOG_NOT_AUTHORIZED = NTSTATUS(0xc0eb0004),
    STATUS_PLATFORM_MANIFEST_BINARY_ID_NOT_FOUND    = NTSTATUS(0xc0eb0005),
    STATUS_PLATFORM_MANIFEST_NOT_ACTIVE             = NTSTATUS(0xc0eb0006),
    STATUS_PLATFORM_MANIFEST_NOT_SIGNED             = NTSTATUS(0xc0eb0007),
}

enum : NTSTATUS
{
    STATUS_SYSTEM_INTEGRITY_ROLLBACK_DETECTED                  = NTSTATUS(0xc0e90001),
    STATUS_SYSTEM_INTEGRITY_POLICY_VIOLATION                   = NTSTATUS(0xc0e90002),
    STATUS_SYSTEM_INTEGRITY_INVALID_POLICY                     = NTSTATUS(0xc0e90003),
    STATUS_SYSTEM_INTEGRITY_POLICY_NOT_SIGNED                  = NTSTATUS(0xc0e90004),
    STATUS_SYSTEM_INTEGRITY_TOO_MANY_POLICIES                  = NTSTATUS(0xc0e90005),
    STATUS_SYSTEM_INTEGRITY_SUPPLEMENTAL_POLICY_NOT_AUTHORIZED = NTSTATUS(0xc0e90006),
    STATUS_SYSTEM_INTEGRITY_REPUTATION_MALICIOUS               = NTSTATUS(0xc0e90007),
    STATUS_SYSTEM_INTEGRITY_REPUTATION_PUA                     = NTSTATUS(0xc0e90008),
    STATUS_SYSTEM_INTEGRITY_REPUTATION_DANGEROUS_EXT           = NTSTATUS(0xc0e90009),
    STATUS_SYSTEM_INTEGRITY_REPUTATION_OFFLINE                 = NTSTATUS(0xc0e9000a),
    STATUS_SYSTEM_INTEGRITY_REPUTATION_UNFRIENDLY_FILE         = NTSTATUS(0xc0e9000b),
    STATUS_SYSTEM_INTEGRITY_REPUTATION_UNATTAINABLE            = NTSTATUS(0xc0e9000c),
    STATUS_SYSTEM_INTEGRITY_REPUTATION_EXPLICIT_DENY_FILE      = NTSTATUS(0xc0e9000d),
    STATUS_SYSTEM_INTEGRITY_WHQL_NOT_SATISFIED                 = NTSTATUS(0xc0e9000e),
}

enum NTSTATUS STATUS_NO_APPLICABLE_APP_LICENSES_FOUND = NTSTATUS(0xc0ea0001);

enum : NTSTATUS
{
    STATUS_CLIP_LICENSE_NOT_FOUND      = NTSTATUS(0xc0ea0002),
    STATUS_CLIP_DEVICE_LICENSE_MISSING = NTSTATUS(0xc0ea0003),
}

enum NTSTATUS STATUS_CLIP_LICENSE_INVALID_SIGNATURE = NTSTATUS(0xc0ea0004);
enum NTSTATUS STATUS_CLIP_KEYHOLDER_LICENSE_MISSING_OR_INVALID = NTSTATUS(0xc0ea0005);

enum : NTSTATUS
{
    STATUS_CLIP_LICENSE_EXPIRED                      = NTSTATUS(0xc0ea0006),
    STATUS_CLIP_LICENSE_SIGNED_BY_UNKNOWN_SOURCE     = NTSTATUS(0xc0ea0007),
    STATUS_CLIP_LICENSE_NOT_SIGNED                   = NTSTATUS(0xc0ea0008),
    STATUS_CLIP_LICENSE_HARDWARE_ID_OUT_OF_TOLERANCE = NTSTATUS(0xc0ea0009),
    STATUS_CLIP_LICENSE_DEVICE_ID_MISMATCH           = NTSTATUS(0xc0ea000a),
}

enum NTSTATUS STATUS_AUDIO_ENGINE_NODE_NOT_FOUND = NTSTATUS(0xc0440001);

enum : NTSTATUS
{
    STATUS_HDAUDIO_EMPTY_CONNECTION_LIST         = NTSTATUS(0xc0440002),
    STATUS_HDAUDIO_CONNECTION_LIST_NOT_SUPPORTED = NTSTATUS(0xc0440003),
}

enum NTSTATUS STATUS_HDAUDIO_NO_LOGICAL_DEVICES_CREATED = NTSTATUS(0xc0440004);
enum NTSTATUS STATUS_HDAUDIO_NULL_LINKED_LIST_ENTRY = NTSTATUS(0xc0440005);

enum : NTSTATUS
{
    STATUS_SOUNDWIRE_COMMAND_ABORTED = NTSTATUS(0xc0440006),
    STATUS_SOUNDWIRE_COMMAND_IGNORED = NTSTATUS(0xc0440007),
    STATUS_SOUNDWIRE_COMMAND_FAILED  = NTSTATUS(0xc0440008),
}

enum : NTSTATUS
{
    STATUS_SPACES_REPAIRED                  = NTSTATUS(0x00e70000),
    STATUS_SPACES_PAUSE                     = NTSTATUS(0x00e70001),
    STATUS_SPACES_COMPLETE                  = NTSTATUS(0x00e70002),
    STATUS_SPACES_REDIRECT                  = NTSTATUS(0x00e70003),
    STATUS_SPACES_FAULT_DOMAIN_TYPE_INVALID = NTSTATUS(0xc0e70001),
}

enum NTSTATUS STATUS_SPACES_RESILIENCY_TYPE_INVALID = NTSTATUS(0xc0e70003);

enum : NTSTATUS
{
    STATUS_SPACES_DRIVE_SECTOR_SIZE_INVALID = NTSTATUS(0xc0e70004),
    STATUS_SPACES_DRIVE_REDUNDANCY_INVALID  = NTSTATUS(0xc0e70006),
}

enum NTSTATUS STATUS_SPACES_NUMBER_OF_DATA_COPIES_INVALID = NTSTATUS(0xc0e70007);
enum NTSTATUS STATUS_SPACES_INTERLEAVE_LENGTH_INVALID = NTSTATUS(0xc0e70009);
enum NTSTATUS STATUS_SPACES_NUMBER_OF_COLUMNS_INVALID = NTSTATUS(0xc0e7000a);

enum : NTSTATUS
{
    STATUS_SPACES_NOT_ENOUGH_DRIVES         = NTSTATUS(0xc0e7000b),
    STATUS_SPACES_EXTENDED_ERROR            = NTSTATUS(0xc0e7000c),
    STATUS_SPACES_PROVISIONING_TYPE_INVALID = NTSTATUS(0xc0e7000d),
}

enum NTSTATUS STATUS_SPACES_ALLOCATION_SIZE_INVALID = NTSTATUS(0xc0e7000e);
enum NTSTATUS STATUS_SPACES_ENCLOSURE_AWARE_INVALID = NTSTATUS(0xc0e7000f);
enum NTSTATUS STATUS_SPACES_WRITE_CACHE_SIZE_INVALID = NTSTATUS(0xc0e70010);
enum NTSTATUS STATUS_SPACES_NUMBER_OF_GROUPS_INVALID = NTSTATUS(0xc0e70011);
enum NTSTATUS STATUS_SPACES_DRIVE_OPERATIONAL_STATE_INVALID = NTSTATUS(0xc0e70012);

enum : NTSTATUS
{
    STATUS_SPACES_UPDATE_COLUMN_STATE    = NTSTATUS(0xc0e70013),
    STATUS_SPACES_MAP_REQUIRED           = NTSTATUS(0xc0e70014),
    STATUS_SPACES_UNSUPPORTED_VERSION    = NTSTATUS(0xc0e70015),
    STATUS_SPACES_CORRUPT_METADATA       = NTSTATUS(0xc0e70016),
    STATUS_SPACES_DRT_FULL               = NTSTATUS(0xc0e70017),
    STATUS_SPACES_INCONSISTENCY          = NTSTATUS(0xc0e70018),
    STATUS_SPACES_LOG_NOT_READY          = NTSTATUS(0xc0e70019),
    STATUS_SPACES_NO_REDUNDANCY          = NTSTATUS(0xc0e7001a),
    STATUS_SPACES_DRIVE_NOT_READY        = NTSTATUS(0xc0e7001b),
    STATUS_SPACES_DRIVE_SPLIT            = NTSTATUS(0xc0e7001c),
    STATUS_SPACES_DRIVE_LOST_DATA        = NTSTATUS(0xc0e7001d),
    STATUS_SPACES_ENTRY_INCOMPLETE       = NTSTATUS(0xc0e7001e),
    STATUS_SPACES_ENTRY_INVALID          = NTSTATUS(0xc0e7001f),
    STATUS_SPACES_MARK_DIRTY             = NTSTATUS(0xc0e70020),
    STATUS_SPACES_PD_NOT_FOUND           = NTSTATUS(0xc0e70021),
    STATUS_SPACES_PD_LENGTH_MISMATCH     = NTSTATUS(0xc0e70022),
    STATUS_SPACES_PD_UNSUPPORTED_VERSION = NTSTATUS(0xc0e70023),
    STATUS_SPACES_PD_INVALID_DATA        = NTSTATUS(0xc0e70024),
    STATUS_SPACES_FLUSH_METADATA         = NTSTATUS(0xc0e70025),
    STATUS_SPACES_CACHE_FULL             = NTSTATUS(0xc0e70026),
    STATUS_SPACES_REPAIR_IN_PROGRESS     = NTSTATUS(0xc0e70027),
}

enum : NTSTATUS
{
    STATUS_VOLSNAP_BOOTFILE_NOT_VALID        = NTSTATUS(0xc0500003),
    STATUS_VOLSNAP_ACTIVATION_TIMEOUT        = NTSTATUS(0xc0500004),
    STATUS_VOLSNAP_NO_BYPASSIO_WITH_SNAPSHOT = NTSTATUS(0xc0500005),
}

enum NTSTATUS STATUS_IO_PREEMPTED = NTSTATUS(0xc0510001);

enum : NTSTATUS
{
    STATUS_SVHDX_ERROR_STORED                                = NTSTATUS(0xc05c0000),
    STATUS_SVHDX_ERROR_NOT_AVAILABLE                         = NTSTATUS(0xc05cff00),
    STATUS_SVHDX_UNIT_ATTENTION_AVAILABLE                    = NTSTATUS(0xc05cff01),
    STATUS_SVHDX_UNIT_ATTENTION_CAPACITY_DATA_CHANGED        = NTSTATUS(0xc05cff02),
    STATUS_SVHDX_UNIT_ATTENTION_RESERVATIONS_PREEMPTED       = NTSTATUS(0xc05cff03),
    STATUS_SVHDX_UNIT_ATTENTION_RESERVATIONS_RELEASED        = NTSTATUS(0xc05cff04),
    STATUS_SVHDX_UNIT_ATTENTION_REGISTRATIONS_PREEMPTED      = NTSTATUS(0xc05cff05),
    STATUS_SVHDX_UNIT_ATTENTION_OPERATING_DEFINITION_CHANGED = NTSTATUS(0xc05cff06),
}

enum NTSTATUS STATUS_SVHDX_RESERVATION_CONFLICT = NTSTATUS(0xc05cff07);

enum : NTSTATUS
{
    STATUS_SVHDX_WRONG_FILE_TYPE  = NTSTATUS(0xc05cff08),
    STATUS_SVHDX_VERSION_MISMATCH = NTSTATUS(0xc05cff09),
}

enum : NTSTATUS
{
    STATUS_VHD_SHARED         = NTSTATUS(0xc05cff0a),
    STATUS_SVHDX_NO_INITIATOR = NTSTATUS(0xc05cff0b),
}

enum NTSTATUS STATUS_VHDSET_BACKING_STORAGE_NOT_FOUND = NTSTATUS(0xc05cff0c);
enum NTSTATUS STATUS_SMB_NO_PREAUTH_INTEGRITY_HASH_OVERLAP = NTSTATUS(0xc05d0000);
enum NTSTATUS STATUS_SMB_BAD_CLUSTER_DIALECT = NTSTATUS(0xc05d0001);
enum NTSTATUS STATUS_SMB_GUEST_LOGON_BLOCKED = NTSTATUS(0xc05d0002);
enum NTSTATUS STATUS_SMB_NO_SIGNING_ALGORITHM_OVERLAP = NTSTATUS(0xc05d0003);
enum NTSTATUS STATUS_NETWORK_AUTHENTICATION_PROMPT_CANCELED = NTSTATUS(0xc05d0004);
enum NTSTATUS STATUS_REMOTE_MAILSLOTS_DEPRECATED = NTSTATUS(0xc05d0005);
enum NTSTATUS STATUS_SMB_GUEST_LOGON_BLOCKED_SIGNING_REQUIRED = NTSTATUS(0xc05d0006);
enum NTSTATUS STATUS_SMB_GUEST_ENCRYPTION_NOT_SUPPORTED = NTSTATUS(0xc05d0007);
enum NTSTATUS STATUS_SMB_ENCRYPTION_NOT_SUPPORTED_BY_PEER = NTSTATUS(0xc05d0008);
enum NTSTATUS STATUS_SMB_TLS_ACCESS_DENIED = NTSTATUS(0xc05d0009);
enum NTSTATUS STATUS_SECCORE_INVALID_COMMAND = NTSTATUS(0xc0e80000);

enum : NTSTATUS
{
    STATUS_VSM_NOT_INITIALIZED           = NTSTATUS(0xc0450000),
    STATUS_VSM_DMA_PROTECTION_NOT_IN_USE = NTSTATUS(0xc0450001),
}

enum NTSTATUS STATUS_VSM_KEY_CI_POLICY_ROLLBACK_DETECTED = NTSTATUS(0xc0450002);

enum : NTSTATUS
{
    STATUS_VSMIDK_KEYGEN_FAILURE   = NTSTATUS(0xc0450003),
    STATUS_VSMIDK_EXPORT_FAILURE   = NTSTATUS(0xc0450004),
    STATUS_VSMIDK_MODULUS_MISMATCH = NTSTATUS(0xc0450005),
}

enum NTSTATUS STATUS_APPEXEC_CONDITION_NOT_SATISFIED = NTSTATUS(0xc0ec0000);

enum : NTSTATUS
{
    STATUS_APPEXEC_HANDLE_INVALIDATED      = NTSTATUS(0xc0ec0001),
    STATUS_APPEXEC_INVALID_HOST_GENERATION = NTSTATUS(0xc0ec0002),
}

enum NTSTATUS STATUS_APPEXEC_UNEXPECTED_PROCESS_REGISTRATION = NTSTATUS(0xc0ec0003);

enum : NTSTATUS
{
    STATUS_APPEXEC_INVALID_HOST_STATE              = NTSTATUS(0xc0ec0004),
    STATUS_APPEXEC_NO_DONOR                        = NTSTATUS(0xc0ec0005),
    STATUS_APPEXEC_HOST_ID_MISMATCH                = NTSTATUS(0xc0ec0006),
    STATUS_APPEXEC_UNKNOWN_USER                    = NTSTATUS(0xc0ec0007),
    STATUS_APPEXEC_APP_COMPAT_BLOCK                = NTSTATUS(0xc0ec0008),
    STATUS_APPEXEC_CALLER_WAIT_TIMEOUT             = NTSTATUS(0xc0ec0009),
    STATUS_APPEXEC_CALLER_WAIT_TIMEOUT_TERMINATION = NTSTATUS(0xc0ec000a),
    STATUS_APPEXEC_CALLER_WAIT_TIMEOUT_LICENSING   = NTSTATUS(0xc0ec000b),
    STATUS_APPEXEC_CALLER_WAIT_TIMEOUT_RESOURCES   = NTSTATUS(0xc0ec000c),
}

enum : NTSTATUS
{
    STATUS_QUIC_HANDSHAKE_FAILURE  = NTSTATUS(0xc0240000),
    STATUS_QUIC_VER_NEG_FAILURE    = NTSTATUS(0xc0240001),
    STATUS_QUIC_USER_CANCELED      = NTSTATUS(0xc0240002),
    STATUS_QUIC_INTERNAL_ERROR     = NTSTATUS(0xc0240003),
    STATUS_QUIC_PROTOCOL_VIOLATION = NTSTATUS(0xc0240004),
}

enum : NTSTATUS
{
    STATUS_QUIC_CONNECTION_IDLE    = NTSTATUS(0xc0240005),
    STATUS_QUIC_CONNECTION_TIMEOUT = NTSTATUS(0xc0240006),
}

enum : NTSTATUS
{
    STATUS_QUIC_ALPN_NEG_FAILURE     = NTSTATUS(0xc0240007),
    STATUS_QUIC_STREAM_LIMIT_REACHED = NTSTATUS(0xc0240008),
}

enum : NTSTATUS
{
    STATUS_QUIC_ALPN_IN_USE                 = NTSTATUS(0xc0240009),
    STATUS_QUIC_TLS_UNEXPECTED_MESSAGE      = NTSTATUS(0xc024010a),
    STATUS_QUIC_TLS_BAD_CERTIFICATE         = NTSTATUS(0xc024012a),
    STATUS_QUIC_TLS_UNSUPPORTED_CERTIFICATE = NTSTATUS(0xc024012b),
    STATUS_QUIC_TLS_CERTIFICATE_REVOKED     = NTSTATUS(0xc024012c),
    STATUS_QUIC_TLS_CERTIFICATE_EXPIRED     = NTSTATUS(0xc024012d),
    STATUS_QUIC_TLS_CERTIFICATE_UNKNOWN     = NTSTATUS(0xc024012e),
    STATUS_QUIC_TLS_ILLEGAL_PARAMETER       = NTSTATUS(0xc024012f),
    STATUS_QUIC_TLS_UNKNOWN_CA              = NTSTATUS(0xc0240130),
    STATUS_QUIC_TLS_ACCESS_DENIED           = NTSTATUS(0xc0240131),
    STATUS_QUIC_TLS_INSUFFICIENT_SECURITY   = NTSTATUS(0xc0240147),
    STATUS_QUIC_TLS_INTERNAL_ERROR          = NTSTATUS(0xc0240150),
    STATUS_QUIC_TLS_USER_CANCELED           = NTSTATUS(0xc024015a),
    STATUS_QUIC_TLS_CERTIFICATE_REQUIRED    = NTSTATUS(0xc0240174),
}

enum NTSTATUS STATUS_IORING_REQUIRED_FLAG_NOT_SUPPORTED = NTSTATUS(0xc0460001);
enum NTSTATUS STATUS_IORING_SUBMISSION_QUEUE_FULL = NTSTATUS(0xc0460002);
enum NTSTATUS STATUS_IORING_VERSION_NOT_SUPPORTED = NTSTATUS(0xc0460003);
enum NTSTATUS STATUS_IORING_SUBMISSION_QUEUE_TOO_BIG = NTSTATUS(0xc0460004);
enum NTSTATUS STATUS_IORING_COMPLETION_QUEUE_TOO_BIG = NTSTATUS(0xc0460005);

enum : NTSTATUS
{
    STATUS_IORING_SUBMIT_IN_PROGRESS        = NTSTATUS(0xc0460006),
    STATUS_IORING_CORRUPT                   = NTSTATUS(0xc0460007),
    STATUS_IORING_COMPLETION_QUEUE_TOO_FULL = NTSTATUS(0xc0460008),
}

enum NTSTATUS STATUS_PRM_HANDLER_NOT_FOUND = NTSTATUS(0xc0ee0200);
enum NTSTATUS STATUS_PRM_CONCURRENT_OPERATION = NTSTATUS(0xc0ee0202);

enum : NTSTATUS
{
    STATUS_PRM_MODULE_UPDATE_PENDING       = NTSTATUS(0xc0ee0203),
    STATUS_PRM_MODULE_LOCKED               = NTSTATUS(0xc0ee0204),
    STATUS_PRM_UPDATE_INCOMPATIBLE_VERSION = NTSTATUS(0xc0ee0205),
    STATUS_PRM_UPDATE_MODULE_MISMATCH      = NTSTATUS(0xc0ee0206),
    STATUS_PRM_UPDATE_MODULE_NOT_FOUND     = NTSTATUS(0xc0ee0207),
    STATUS_PRM_UPDATE_MISSING_EXPORT       = NTSTATUS(0xc0ee0208),
    STATUS_PRM_UPDATE_MODULE_LOCKED        = NTSTATUS(0xc0ee0209),
    STATUS_PRM_UPDATE_BAD_SIGNATURE        = NTSTATUS(0xc0ee020a),
    STATUS_PRM_UPDATE_VERSION_MISMATCH     = NTSTATUS(0xc0ee020b),
}

enum : NTSTATUS
{
    STATUS_PRM_MODULE_UNLOCKED        = NTSTATUS(0xc0ee020c),
    STATUS_PRM_INTERFACE_INACCESSIBLE = NTSTATUS(0xc0ee020d),
}

enum NTSTATUS STATUS_ACCELERATOR_SUBMISSION_QUEUE_FULL = NTSTATUS(0xc0ef0001);

enum : NTSTATUS
{
    STATUS_AAD_CLOUDAP_E_APNONCE_INVALID                = NTSTATUS(0xc0048550),
    STATUS_AAD_CLOUDAP_E_BAD_DEVICE_ACCESS_TOKEN_FORMAT = NTSTATUS(0xc0048551),
    STATUS_AAD_CLOUDAP_E_ASSERTION_MALFORMED            = NTSTATUS(0xc0048552),
    STATUS_AAD_CLOUDAP_E_INVALID_TENANT                 = NTSTATUS(0xc0048553),
    STATUS_AAD_CLOUDAP_E_INVALID_DEVICE                 = NTSTATUS(0xc0048554),
    STATUS_AAD_CLOUDAP_E_INVALID_ACCESS_TOKEN           = NTSTATUS(0xc0048556),
    STATUS_AAD_CLOUDAP_E_INVALID_BINDING_KEY_ID         = NTSTATUS(0xc0048557),
    STATUS_AAD_CLOUDAP_E_CANT_FIND_ROOT_CERT            = NTSTATUS(0xc0048559),
    STATUS_AAD_CLOUDAP_E_ASSERTION_INVALID              = NTSTATUS(0xc004855a),
    STATUS_AAD_CLOUDAP_E_CALLER_MISMATCH                = NTSTATUS(0xc004855b),
}

enum uint WINVER = 0x00000500U;
enum uint APP_LOCAL_DEVICE_ID_SIZE = 0x00000020U;
enum HRESULT SEC_E_OK = HRESULT(0x00000000);
enum int RPC_X_NO_MORE_ENTRIES = 0x000006ec;

enum : int
{
    RPC_X_SS_CHAR_TRANS_OPEN_FAIL  = 0x000006ed,
    RPC_X_SS_CHAR_TRANS_SHORT_FILE = 0x000006ee,
}

enum int RPC_X_SS_IN_NULL_CONTEXT = 0x000006ef;
enum int RPC_X_SS_CONTEXT_DAMAGED = 0x000006f1;
enum int RPC_X_SS_HANDLES_MISMATCH = 0x000006f2;
enum int RPC_X_SS_CANNOT_GET_CALL_HANDLE = 0x000006f3;
enum int RPC_X_NULL_REF_POINTER = 0x000006f4;
enum int RPC_X_ENUM_VALUE_OUT_OF_RANGE = 0x000006f5;
enum int RPC_X_BYTE_COUNT_TOO_SMALL = 0x000006f6;
enum int RPC_X_BAD_STUB_DATA = 0x000006f7;
enum int RPC_X_INVALID_ES_ACTION = 0x00000723;

enum : int
{
    RPC_X_WRONG_ES_VERSION   = 0x00000724,
    RPC_X_WRONG_STUB_VERSION = 0x00000725,
}

enum int RPC_X_INVALID_PIPE_OBJECT = 0x00000726;

enum : int
{
    RPC_X_WRONG_PIPE_ORDER   = 0x00000727,
    RPC_X_WRONG_PIPE_VERSION = 0x00000728,
}

enum : int
{
    OR_INVALID_OXID = 0x00000776,
    OR_INVALID_OID  = 0x00000777,
    OR_INVALID_SET  = 0x00000778,
}

enum : int
{
    RPC_X_PIPE_CLOSED           = 0x0000077c,
    RPC_X_PIPE_DISCIPLINE_ERROR = 0x0000077d,
    RPC_X_PIPE_EMPTY            = 0x0000077e,
}

enum int PEERDIST_ERROR_CONTENTINFO_VERSION_UNSUPPORTED = 0x00000fd2;
enum int PEERDIST_ERROR_CANNOT_PARSE_CONTENTINFO = 0x00000fd3;

enum : int
{
    PEERDIST_ERROR_MISSING_DATA          = 0x00000fd4,
    PEERDIST_ERROR_NO_MORE               = 0x00000fd5,
    PEERDIST_ERROR_NOT_INITIALIZED       = 0x00000fd6,
    PEERDIST_ERROR_ALREADY_INITIALIZED   = 0x00000fd7,
    PEERDIST_ERROR_SHUTDOWN_IN_PROGRESS  = 0x00000fd8,
    PEERDIST_ERROR_INVALIDATED           = 0x00000fd9,
    PEERDIST_ERROR_ALREADY_EXISTS        = 0x00000fda,
    PEERDIST_ERROR_OPERATION_NOTFOUND    = 0x00000fdb,
    PEERDIST_ERROR_ALREADY_COMPLETED     = 0x00000fdc,
    PEERDIST_ERROR_OUT_OF_BOUNDS         = 0x00000fdd,
    PEERDIST_ERROR_VERSION_UNSUPPORTED   = 0x00000fde,
    PEERDIST_ERROR_INVALID_CONFIGURATION = 0x00000fdf,
    PEERDIST_ERROR_NOT_LICENSED          = 0x00000fe0,
    PEERDIST_ERROR_SERVICE_UNAVAILABLE   = 0x00000fe1,
    PEERDIST_ERROR_TRUST_FAILURE         = 0x00000fe2,
}

enum int SCHED_E_SERVICE_NOT_LOCALSYSTEM = 0x00001838;
enum int FRS_ERR_INVALID_API_SEQUENCE = 0x00001f41;

enum : int
{
    FRS_ERR_STARTING_SERVICE = 0x00001f42,
    FRS_ERR_STOPPING_SERVICE = 0x00001f43,
}

enum : int
{
    FRS_ERR_INTERNAL_API = 0x00001f44,
    FRS_ERR_INTERNAL     = 0x00001f45,
    FRS_ERR_SERVICE_COMM = 0x00001f46,
}

enum int FRS_ERR_INSUFFICIENT_PRIV = 0x00001f47;
enum int FRS_ERR_AUTHENTICATION = 0x00001f48;

enum : int
{
    FRS_ERR_PARENT_INSUFFICIENT_PRIV = 0x00001f49,
    FRS_ERR_PARENT_AUTHENTICATION    = 0x00001f4a,
}

enum int FRS_ERR_CHILD_TO_PARENT_COMM = 0x00001f4b;
enum int FRS_ERR_PARENT_TO_CHILD_COMM = 0x00001f4c;

enum : int
{
    FRS_ERR_SYSVOL_POPULATE         = 0x00001f4d,
    FRS_ERR_SYSVOL_POPULATE_TIMEOUT = 0x00001f4e,
    FRS_ERR_SYSVOL_IS_BUSY          = 0x00001f4f,
    FRS_ERR_SYSVOL_DEMOTE           = 0x00001f50,
}

enum int FRS_ERR_INVALID_SERVICE_PARAMETER = 0x00001f51;
enum int DNS_INFO_NO_RECORDS = 0x0000251d;
enum int DNS_REQUEST_PENDING = 0x00002522;

enum : int
{
    DNS_STATUS_FQDN             = 0x00002555,
    DNS_STATUS_DOTTED_NAME      = 0x00002556,
    DNS_STATUS_SINGLE_PART_NAME = 0x00002557,
}

enum : int
{
    DNS_WARNING_PTR_CREATE_FAILED = 0x000025f3,
    DNS_WARNING_DOMAIN_UNDELETED  = 0x000025f4,
}

enum : int
{
    DNS_INFO_AXFR_COMPLETE    = 0x00002617,
    DNS_INFO_ADDED_LOCAL_WINS = 0x00002619,
}

enum int DNS_STATUS_CONTINUE_NEEDED = 0x00002649;

enum : int
{
    WARNING_IPSEC_MM_POLICY_PRUNED = 0x000032e0,
    WARNING_IPSEC_QM_POLICY_PRUNED = 0x000032e1,
}

enum : int
{
    STORE_ERROR_UNLICENSED              = 0x00003df5,
    STORE_ERROR_UNLICENSED_USER         = 0x00003df6,
    STORE_ERROR_PENDING_COM_TRANSACTION = 0x00003df7,
}

enum int STORE_ERROR_LICENSE_REVOKED = 0x00003df8;

enum : uint
{
    SEVERITY_SUCCESS = 0x00000000U,
    SEVERITY_ERROR   = 0x00000001U,
}

enum uint NOERROR = 0x00000000U;
enum HRESULT E_UNEXPECTED = HRESULT(0x8000ffff);
enum HRESULT E_NOINTERFACE = HRESULT(0x80004002);
enum HRESULT E_POINTER = HRESULT(0x80004003);
enum HRESULT E_HANDLE = HRESULT(0x80070006);

enum : HRESULT
{
    E_ABORT        = HRESULT(0x80004004),
    E_ACCESSDENIED = HRESULT(0x80070005),
}

enum HRESULT E_BOUNDS = HRESULT(0x8000000b);
enum HRESULT E_CHANGED_STATE = HRESULT(0x8000000c);

enum : HRESULT
{
    E_ILLEGAL_STATE_CHANGE = HRESULT(0x8000000d),
    E_ILLEGAL_METHOD_CALL  = HRESULT(0x8000000e),
}

enum : HRESULT
{
    RO_E_METADATA_NAME_NOT_FOUND      = HRESULT(0x8000000f),
    RO_E_METADATA_NAME_IS_NAMESPACE   = HRESULT(0x80000010),
    RO_E_METADATA_INVALID_TYPE_FORMAT = HRESULT(0x80000011),
}

enum HRESULT RO_E_INVALID_METADATA_FILE = HRESULT(0x80000012);

enum : HRESULT
{
    RO_E_CLOSED          = HRESULT(0x80000013),
    RO_E_EXCLUSIVE_WRITE = HRESULT(0x80000014),
}

enum HRESULT RO_E_CHANGE_NOTIFICATION_IN_PROGRESS = HRESULT(0x80000015);
enum HRESULT RO_E_ERROR_STRING_NOT_FOUND = HRESULT(0x80000016);
enum HRESULT E_STRING_NOT_NULL_TERMINATED = HRESULT(0x80000017);
enum HRESULT E_ILLEGAL_DELEGATE_ASSIGNMENT = HRESULT(0x80000018);
enum HRESULT E_ASYNC_OPERATION_NOT_STARTED = HRESULT(0x80000019);

enum : HRESULT
{
    E_APPLICATION_EXITING      = HRESULT(0x8000001a),
    E_APPLICATION_VIEW_EXITING = HRESULT(0x8000001b),
}

enum HRESULT RO_E_MUST_BE_AGILE = HRESULT(0x8000001c);
enum HRESULT RO_E_UNSUPPORTED_FROM_MTA = HRESULT(0x8000001d);
enum HRESULT RO_E_COMMITTED = HRESULT(0x8000001e);
enum HRESULT RO_E_BLOCKED_CROSS_ASTA_CALL = HRESULT(0x8000001f);

enum : HRESULT
{
    RO_E_CANNOT_ACTIVATE_FULL_TRUST_SERVER            = HRESULT(0x80000020),
    RO_E_CANNOT_ACTIVATE_UNIVERSAL_APPLICATION_SERVER = HRESULT(0x80000021),
}

enum : HRESULT
{
    CO_E_INIT_TLS              = HRESULT(0x80004006),
    CO_E_INIT_SHARED_ALLOCATOR = HRESULT(0x80004007),
}

enum HRESULT CO_E_INIT_MEMORY_ALLOCATOR = HRESULT(0x80004008);

enum : HRESULT
{
    CO_E_INIT_CLASS_CACHE             = HRESULT(0x80004009),
    CO_E_INIT_RPC_CHANNEL             = HRESULT(0x8000400a),
    CO_E_INIT_TLS_SET_CHANNEL_CONTROL = HRESULT(0x8000400b),
    CO_E_INIT_TLS_CHANNEL_CONTROL     = HRESULT(0x8000400c),
}

enum HRESULT CO_E_INIT_UNACCEPTED_USER_ALLOCATOR = HRESULT(0x8000400d);

enum : HRESULT
{
    CO_E_INIT_SCM_MUTEX_EXISTS        = HRESULT(0x8000400e),
    CO_E_INIT_SCM_FILE_MAPPING_EXISTS = HRESULT(0x8000400f),
    CO_E_INIT_SCM_MAP_VIEW_OF_FILE    = HRESULT(0x80004010),
    CO_E_INIT_SCM_EXEC_FAILURE        = HRESULT(0x80004011),
}

enum HRESULT CO_E_INIT_ONLY_SINGLE_THREADED = HRESULT(0x80004012);
enum HRESULT CO_E_CANT_REMOTE = HRESULT(0x80004013);
enum HRESULT CO_E_BAD_SERVER_NAME = HRESULT(0x80004014);
enum HRESULT CO_E_WRONG_SERVER_IDENTITY = HRESULT(0x80004015);
enum HRESULT CO_E_OLE1DDE_DISABLED = HRESULT(0x80004016);
enum HRESULT CO_E_RUNAS_SYNTAX = HRESULT(0x80004017);
enum HRESULT CO_E_CREATEPROCESS_FAILURE = HRESULT(0x80004018);
enum HRESULT CO_E_RUNAS_CREATEPROCESS_FAILURE = HRESULT(0x80004019);
enum HRESULT CO_E_RUNAS_LOGON_FAILURE = HRESULT(0x8000401a);
enum HRESULT CO_E_LAUNCH_PERMSSION_DENIED = HRESULT(0x8000401b);
enum HRESULT CO_E_START_SERVICE_FAILURE = HRESULT(0x8000401c);
enum HRESULT CO_E_REMOTE_COMMUNICATION_FAILURE = HRESULT(0x8000401d);
enum HRESULT CO_E_SERVER_START_TIMEOUT = HRESULT(0x8000401e);
enum HRESULT CO_E_CLSREG_INCONSISTENT = HRESULT(0x8000401f);
enum HRESULT CO_E_IIDREG_INCONSISTENT = HRESULT(0x80004020);
enum HRESULT CO_E_NOT_SUPPORTED = HRESULT(0x80004021);
enum HRESULT CO_E_RELOAD_DLL = HRESULT(0x80004022);
enum HRESULT CO_E_MSI_ERROR = HRESULT(0x80004023);
enum HRESULT CO_E_ATTEMPT_TO_CREATE_OUTSIDE_CLIENT_CONTEXT = HRESULT(0x80004024);

enum : HRESULT
{
    CO_E_SERVER_PAUSED     = HRESULT(0x80004025),
    CO_E_SERVER_NOT_PAUSED = HRESULT(0x80004026),
}

enum HRESULT CO_E_CLASS_DISABLED = HRESULT(0x80004027);
enum HRESULT CO_E_CLRNOTAVAILABLE = HRESULT(0x80004028);
enum HRESULT CO_E_ASYNC_WORK_REJECTED = HRESULT(0x80004029);
enum HRESULT CO_E_SERVER_INIT_TIMEOUT = HRESULT(0x8000402a);
enum HRESULT CO_E_NO_SECCTX_IN_ACTIVATE = HRESULT(0x8000402b);
enum HRESULT CO_E_TRACKER_CONFIG = HRESULT(0x80004030);
enum HRESULT CO_E_THREADPOOL_CONFIG = HRESULT(0x80004031);
enum HRESULT CO_E_SXS_CONFIG = HRESULT(0x80004032);
enum HRESULT CO_E_MALFORMED_SPN = HRESULT(0x80004033);
enum HRESULT CO_E_UNREVOKED_REGISTRATION_ON_APARTMENT_SHUTDOWN = HRESULT(0x80004034);
enum HRESULT CO_E_PREMATURE_STUB_RUNDOWN = HRESULT(0x80004035);

enum : HRESULT
{
    S_OK    = HRESULT(0x00000000),
    S_FALSE = HRESULT(0x00000001),
}

enum : HRESULT
{
    OLE_E_FIRST = HRESULT(0x80040000),
    OLE_E_LAST  = HRESULT(0x800400ff),
}

enum : HRESULT
{
    OLE_S_FIRST = HRESULT(0x00040000),
    OLE_S_LAST  = HRESULT(0x000400ff),
}

enum : HRESULT
{
    OLE_E_OLEVERB     = HRESULT(0x80040000),
    OLE_E_ADVF        = HRESULT(0x80040001),
    OLE_E_ENUM_NOMORE = HRESULT(0x80040002),
}

enum HRESULT OLE_E_ADVISENOTSUPPORTED = HRESULT(0x80040003);

enum : HRESULT
{
    OLE_E_NOCONNECTION      = HRESULT(0x80040004),
    OLE_E_NOTRUNNING        = HRESULT(0x80040005),
    OLE_E_NOCACHE           = HRESULT(0x80040006),
    OLE_E_BLANK             = HRESULT(0x80040007),
    OLE_E_CLASSDIFF         = HRESULT(0x80040008),
    OLE_E_CANT_GETMONIKER   = HRESULT(0x80040009),
    OLE_E_CANT_BINDTOSOURCE = HRESULT(0x8004000a),
}

enum : HRESULT
{
    OLE_E_STATIC              = HRESULT(0x8004000b),
    OLE_E_PROMPTSAVECANCELLED = HRESULT(0x8004000c),
}

enum HRESULT OLE_E_INVALIDRECT = HRESULT(0x8004000d);
enum HRESULT OLE_E_WRONGCOMPOBJ = HRESULT(0x8004000e);
enum HRESULT OLE_E_INVALIDHWND = HRESULT(0x8004000f);
enum HRESULT OLE_E_NOT_INPLACEACTIVE = HRESULT(0x80040010);
enum HRESULT OLE_E_CANTCONVERT = HRESULT(0x80040011);
enum HRESULT OLE_E_NOSTORAGE = HRESULT(0x80040012);
enum HRESULT DV_E_FORMATETC = HRESULT(0x80040064);
enum HRESULT DV_E_DVTARGETDEVICE = HRESULT(0x80040065);

enum : HRESULT
{
    DV_E_STGMEDIUM = HRESULT(0x80040066),
    DV_E_STATDATA  = HRESULT(0x80040067),
}

enum : HRESULT
{
    DV_E_LINDEX     = HRESULT(0x80040068),
    DV_E_TYMED      = HRESULT(0x80040069),
    DV_E_CLIPFORMAT = HRESULT(0x8004006a),
}

enum : HRESULT
{
    DV_E_DVASPECT            = HRESULT(0x8004006b),
    DV_E_DVTARGETDEVICE_SIZE = HRESULT(0x8004006c),
}

enum HRESULT DV_E_NOIVIEWOBJECT = HRESULT(0x8004006d);

enum : int
{
    DRAGDROP_E_FIRST = 0x80040100,
    DRAGDROP_E_LAST  = 0x8004010f,
    DRAGDROP_S_FIRST = 0x00040100,
    DRAGDROP_S_LAST  = 0x0004010f,
}

enum : HRESULT
{
    DRAGDROP_E_NOTREGISTERED     = HRESULT(0x80040100),
    DRAGDROP_E_ALREADYREGISTERED = HRESULT(0x80040101),
}

enum : HRESULT
{
    DRAGDROP_E_INVALIDHWND               = HRESULT(0x80040102),
    DRAGDROP_E_CONCURRENT_DRAG_ATTEMPTED = HRESULT(0x80040103),
}

enum : int
{
    CLASSFACTORY_E_FIRST = 0x80040110,
    CLASSFACTORY_E_LAST  = 0x8004011f,
    CLASSFACTORY_S_FIRST = 0x00040110,
    CLASSFACTORY_S_LAST  = 0x0004011f,
}

enum HRESULT CLASS_E_NOAGGREGATION = HRESULT(0x80040110);
enum HRESULT CLASS_E_CLASSNOTAVAILABLE = HRESULT(0x80040111);
enum HRESULT CLASS_E_NOTLICENSED = HRESULT(0x80040112);

enum : int
{
    MARSHAL_E_FIRST = 0x80040120,
    MARSHAL_E_LAST  = 0x8004012f,
    MARSHAL_S_FIRST = 0x00040120,
    MARSHAL_S_LAST  = 0x0004012f,
}

enum : int
{
    DATA_E_FIRST = 0x80040130,
    DATA_E_LAST  = 0x8004013f,
    DATA_S_FIRST = 0x00040130,
    DATA_S_LAST  = 0x0004013f,
}

enum : int
{
    VIEW_E_FIRST = 0x80040140,
    VIEW_E_LAST  = 0x8004014f,
    VIEW_S_FIRST = 0x00040140,
    VIEW_S_LAST  = 0x0004014f,
}

enum HRESULT VIEW_E_DRAW = HRESULT(0x80040140);

enum : int
{
    REGDB_E_FIRST = 0x80040150,
    REGDB_E_LAST  = 0x8004015f,
    REGDB_S_FIRST = 0x00040150,
    REGDB_S_LAST  = 0x0004015f,
}

enum : HRESULT
{
    REGDB_E_READREGDB    = HRESULT(0x80040150),
    REGDB_E_WRITEREGDB   = HRESULT(0x80040151),
    REGDB_E_KEYMISSING   = HRESULT(0x80040152),
    REGDB_E_INVALIDVALUE = HRESULT(0x80040153),
}

enum : HRESULT
{
    REGDB_E_CLASSNOTREG       = HRESULT(0x80040154),
    REGDB_E_IIDNOTREG         = HRESULT(0x80040155),
    REGDB_E_BADTHREADINGMODEL = HRESULT(0x80040156),
}

enum HRESULT REGDB_E_PACKAGEPOLICYVIOLATION = HRESULT(0x80040157);

enum : int
{
    CAT_E_FIRST = 0x80040160,
    CAT_E_LAST  = 0x80040161,
}

enum HRESULT CAT_E_CATIDNOEXIST = HRESULT(0x80040160);
enum HRESULT CAT_E_NODESCRIPTION = HRESULT(0x80040161);

enum : int
{
    CS_E_FIRST = 0x80040164,
    CS_E_LAST  = 0x8004016f,
}

enum HRESULT CS_E_PACKAGE_NOTFOUND = HRESULT(0x80040164);
enum HRESULT CS_E_NOT_DELETABLE = HRESULT(0x80040165);
enum HRESULT CS_E_CLASS_NOTFOUND = HRESULT(0x80040166);
enum HRESULT CS_E_INVALID_VERSION = HRESULT(0x80040167);
enum HRESULT CS_E_NO_CLASSSTORE = HRESULT(0x80040168);

enum : HRESULT
{
    CS_E_OBJECT_NOTFOUND       = HRESULT(0x80040169),
    CS_E_OBJECT_ALREADY_EXISTS = HRESULT(0x8004016a),
}

enum HRESULT CS_E_INVALID_PATH = HRESULT(0x8004016b);
enum HRESULT CS_E_NETWORK_ERROR = HRESULT(0x8004016c);
enum HRESULT CS_E_ADMIN_LIMIT_EXCEEDED = HRESULT(0x8004016d);
enum HRESULT CS_E_SCHEMA_MISMATCH = HRESULT(0x8004016e);
enum HRESULT CS_E_INTERNAL_ERROR = HRESULT(0x8004016f);

enum : int
{
    CACHE_E_FIRST = 0x80040170,
    CACHE_E_LAST  = 0x8004017f,
    CACHE_S_FIRST = 0x00040170,
    CACHE_S_LAST  = 0x0004017f,
}

enum HRESULT CACHE_E_NOCACHE_UPDATED = HRESULT(0x80040170);

enum : int
{
    OLEOBJ_E_FIRST = 0x80040180,
    OLEOBJ_E_LAST  = 0x8004018f,
    OLEOBJ_S_FIRST = 0x00040180,
    OLEOBJ_S_LAST  = 0x0004018f,
}

enum : HRESULT
{
    OLEOBJ_E_NOVERBS     = HRESULT(0x80040180),
    OLEOBJ_E_INVALIDVERB = HRESULT(0x80040181),
}

enum : int
{
    CLIENTSITE_E_FIRST = 0x80040190,
    CLIENTSITE_E_LAST  = 0x8004019f,
    CLIENTSITE_S_FIRST = 0x00040190,
    CLIENTSITE_S_LAST  = 0x0004019f,
}

enum : HRESULT
{
    INPLACE_E_NOTUNDOABLE = HRESULT(0x800401a0),
    INPLACE_E_NOTOOLSPACE = HRESULT(0x800401a1),
}

enum : int
{
    INPLACE_E_FIRST = 0x800401a0,
    INPLACE_E_LAST  = 0x800401af,
    INPLACE_S_FIRST = 0x000401a0,
    INPLACE_S_LAST  = 0x000401af,
}

enum : int
{
    ENUM_E_FIRST = 0x800401b0,
    ENUM_E_LAST  = 0x800401bf,
    ENUM_S_FIRST = 0x000401b0,
    ENUM_S_LAST  = 0x000401bf,
}

enum : int
{
    CONVERT10_E_FIRST = 0x800401c0,
    CONVERT10_E_LAST  = 0x800401cf,
    CONVERT10_S_FIRST = 0x000401c0,
    CONVERT10_S_LAST  = 0x000401cf,
}

enum : HRESULT
{
    CONVERT10_E_OLESTREAM_GET           = HRESULT(0x800401c0),
    CONVERT10_E_OLESTREAM_PUT           = HRESULT(0x800401c1),
    CONVERT10_E_OLESTREAM_FMT           = HRESULT(0x800401c2),
    CONVERT10_E_OLESTREAM_BITMAP_TO_DIB = HRESULT(0x800401c3),
}

enum : HRESULT
{
    CONVERT10_E_STG_FMT           = HRESULT(0x800401c4),
    CONVERT10_E_STG_NO_STD_STREAM = HRESULT(0x800401c5),
    CONVERT10_E_STG_DIB_TO_BITMAP = HRESULT(0x800401c6),
    CONVERT10_E_OLELINK_DISABLED  = HRESULT(0x800401c7),
}

enum : int
{
    CLIPBRD_E_FIRST = 0x800401d0,
    CLIPBRD_E_LAST  = 0x800401df,
    CLIPBRD_S_FIRST = 0x000401d0,
    CLIPBRD_S_LAST  = 0x000401df,
}

enum : HRESULT
{
    CLIPBRD_E_CANT_OPEN  = HRESULT(0x800401d0),
    CLIPBRD_E_CANT_EMPTY = HRESULT(0x800401d1),
    CLIPBRD_E_CANT_SET   = HRESULT(0x800401d2),
    CLIPBRD_E_BAD_DATA   = HRESULT(0x800401d3),
    CLIPBRD_E_CANT_CLOSE = HRESULT(0x800401d4),
}

enum : int
{
    MK_E_FIRST = 0x800401e0,
    MK_E_LAST  = 0x800401ef,
}

enum : int
{
    MK_S_FIRST = 0x000401e0,
    MK_S_LAST  = 0x000401ef,
}

enum HRESULT MK_E_CONNECTMANUALLY = HRESULT(0x800401e0);
enum HRESULT MK_E_EXCEEDEDDEADLINE = HRESULT(0x800401e1);
enum HRESULT MK_E_NEEDGENERIC = HRESULT(0x800401e2);
enum HRESULT MK_E_UNAVAILABLE = HRESULT(0x800401e3);

enum : HRESULT
{
    MK_E_SYNTAX   = HRESULT(0x800401e4),
    MK_E_NOOBJECT = HRESULT(0x800401e5),
}

enum HRESULT MK_E_INVALIDEXTENSION = HRESULT(0x800401e6);
enum HRESULT MK_E_INTERMEDIATEINTERFACENOTSUPPORTED = HRESULT(0x800401e7);

enum : HRESULT
{
    MK_E_NOTBINDABLE = HRESULT(0x800401e8),
    MK_E_NOTBOUND    = HRESULT(0x800401e9),
}

enum HRESULT MK_E_CANTOPENFILE = HRESULT(0x800401ea);
enum HRESULT MK_E_MUSTBOTHERUSER = HRESULT(0x800401eb);

enum : HRESULT
{
    MK_E_NOINVERSE = HRESULT(0x800401ec),
    MK_E_NOSTORAGE = HRESULT(0x800401ed),
    MK_E_NOPREFIX  = HRESULT(0x800401ee),
}

enum HRESULT MK_E_ENUMERATION_FAILED = HRESULT(0x800401ef);

enum : int
{
    CO_E_FIRST = 0x800401f0,
    CO_E_LAST  = 0x800401ff,
}

enum : int
{
    CO_S_FIRST = 0x000401f0,
    CO_S_LAST  = 0x000401ff,
}

enum HRESULT CO_E_ALREADYINITIALIZED = HRESULT(0x800401f1);
enum HRESULT CO_E_CANTDETERMINECLASS = HRESULT(0x800401f2);
enum HRESULT CO_E_CLASSSTRING = HRESULT(0x800401f3);
enum HRESULT CO_E_IIDSTRING = HRESULT(0x800401f4);

enum : HRESULT
{
    CO_E_APPNOTFOUND  = HRESULT(0x800401f5),
    CO_E_APPSINGLEUSE = HRESULT(0x800401f6),
}

enum HRESULT CO_E_ERRORINAPP = HRESULT(0x800401f7);
enum HRESULT CO_E_DLLNOTFOUND = HRESULT(0x800401f8);
enum HRESULT CO_E_ERRORINDLL = HRESULT(0x800401f9);
enum HRESULT CO_E_WRONGOSFORAPP = HRESULT(0x800401fa);

enum : HRESULT
{
    CO_E_OBJNOTREG       = HRESULT(0x800401fb),
    CO_E_OBJISREG        = HRESULT(0x800401fc),
    CO_E_OBJNOTCONNECTED = HRESULT(0x800401fd),
}

enum HRESULT CO_E_APPDIDNTREG = HRESULT(0x800401fe);
enum HRESULT CO_E_RELEASED = HRESULT(0x800401ff);

enum : int
{
    EVENT_E_FIRST = 0x80040200,
    EVENT_E_LAST  = 0x8004021f,
    EVENT_S_FIRST = 0x00040200,
    EVENT_S_LAST  = 0x0004021f,
}

enum HRESULT EVENT_S_SOME_SUBSCRIBERS_FAILED = HRESULT(0x00040200);
enum HRESULT EVENT_E_ALL_SUBSCRIBERS_FAILED = HRESULT(0x80040201);
enum HRESULT EVENT_S_NOSUBSCRIBERS = HRESULT(0x00040202);

enum : HRESULT
{
    EVENT_E_QUERYSYNTAX          = HRESULT(0x80040203),
    EVENT_E_QUERYFIELD           = HRESULT(0x80040204),
    EVENT_E_INTERNALEXCEPTION    = HRESULT(0x80040205),
    EVENT_E_INTERNALERROR        = HRESULT(0x80040206),
    EVENT_E_INVALID_PER_USER_SID = HRESULT(0x80040207),
}

enum HRESULT EVENT_E_USER_EXCEPTION = HRESULT(0x80040208);
enum HRESULT EVENT_E_TOO_MANY_METHODS = HRESULT(0x80040209);
enum HRESULT EVENT_E_MISSING_EVENTCLASS = HRESULT(0x8004020a);
enum HRESULT EVENT_E_NOT_ALL_REMOVED = HRESULT(0x8004020b);
enum HRESULT EVENT_E_COMPLUS_NOT_INSTALLED = HRESULT(0x8004020c);

enum : HRESULT
{
    EVENT_E_CANT_MODIFY_OR_DELETE_UNCONFIGURED_OBJECT = HRESULT(0x8004020d),
    EVENT_E_CANT_MODIFY_OR_DELETE_CONFIGURED_OBJECT   = HRESULT(0x8004020e),
}

enum HRESULT EVENT_E_INVALID_EVENT_CLASS_PARTITION = HRESULT(0x8004020f);
enum HRESULT EVENT_E_PER_USER_SID_NOT_LOGGED_ON = HRESULT(0x80040210);
enum HRESULT TPC_E_INVALID_PROPERTY = HRESULT(0x80040241);
enum HRESULT TPC_E_NO_DEFAULT_TABLET = HRESULT(0x80040212);
enum HRESULT TPC_E_UNKNOWN_PROPERTY = HRESULT(0x8004021b);

enum : HRESULT
{
    TPC_E_INVALID_INPUT_RECT = HRESULT(0x80040219),
    TPC_E_INVALID_STROKE     = HRESULT(0x80040222),
}

enum HRESULT TPC_E_INITIALIZE_FAIL = HRESULT(0x80040223);
enum HRESULT TPC_E_NOT_RELEVANT = HRESULT(0x80040232);
enum HRESULT TPC_E_INVALID_PACKET_DESCRIPTION = HRESULT(0x80040233);
enum HRESULT TPC_E_RECOGNIZER_NOT_REGISTERED = HRESULT(0x80040235);
enum HRESULT TPC_E_INVALID_RIGHTS = HRESULT(0x80040236);
enum HRESULT TPC_E_OUT_OF_ORDER_CALL = HRESULT(0x80040237);
enum HRESULT TPC_E_QUEUE_FULL = HRESULT(0x80040238);

enum : HRESULT
{
    TPC_E_INVALID_CONFIGURATION        = HRESULT(0x80040239),
    TPC_E_INVALID_DATA_FROM_RECOGNIZER = HRESULT(0x8004023a),
}

enum HRESULT TPC_S_TRUNCATED = HRESULT(0x00040252);
enum HRESULT TPC_S_INTERRUPTED = HRESULT(0x00040253);
enum HRESULT TPC_S_NO_DATA_TO_PROCESS = HRESULT(0x00040254);

enum : uint
{
    XACT_E_FIRST = 0x8004d000U,
    XACT_E_LAST  = 0x8004d02bU,
    XACT_S_FIRST = 0x0004d000U,
    XACT_S_LAST  = 0x0004d010U,
}

enum HRESULT XACT_E_ALREADYOTHERSINGLEPHASE = HRESULT(0x8004d000);

enum : HRESULT
{
    XACT_E_CANTRETAIN      = HRESULT(0x8004d001),
    XACT_E_COMMITFAILED    = HRESULT(0x8004d002),
    XACT_E_COMMITPREVENTED = HRESULT(0x8004d003),
}

enum : HRESULT
{
    XACT_E_HEURISTICABORT  = HRESULT(0x8004d004),
    XACT_E_HEURISTICCOMMIT = HRESULT(0x8004d005),
    XACT_E_HEURISTICDAMAGE = HRESULT(0x8004d006),
    XACT_E_HEURISTICDANGER = HRESULT(0x8004d007),
}

enum HRESULT XACT_E_ISOLATIONLEVEL = HRESULT(0x8004d008);

enum : HRESULT
{
    XACT_E_NOASYNC       = HRESULT(0x8004d009),
    XACT_E_NOENLIST      = HRESULT(0x8004d00a),
    XACT_E_NOISORETAIN   = HRESULT(0x8004d00b),
    XACT_E_NORESOURCE    = HRESULT(0x8004d00c),
    XACT_E_NOTCURRENT    = HRESULT(0x8004d00d),
    XACT_E_NOTRANSACTION = HRESULT(0x8004d00e),
    XACT_E_NOTSUPPORTED  = HRESULT(0x8004d00f),
}

enum HRESULT XACT_E_UNKNOWNRMGRID = HRESULT(0x8004d010);

enum : HRESULT
{
    XACT_E_WRONGSTATE  = HRESULT(0x8004d011),
    XACT_E_WRONGUOW    = HRESULT(0x8004d012),
    XACT_E_XTIONEXISTS = HRESULT(0x8004d013),
}

enum HRESULT XACT_E_NOIMPORTOBJECT = HRESULT(0x8004d014);

enum : HRESULT
{
    XACT_E_INVALIDCOOKIE     = HRESULT(0x8004d015),
    XACT_E_INDOUBT           = HRESULT(0x8004d016),
    XACT_E_NOTIMEOUT         = HRESULT(0x8004d017),
    XACT_E_ALREADYINPROGRESS = HRESULT(0x8004d018),
}

enum : HRESULT
{
    XACT_E_ABORTED        = HRESULT(0x8004d019),
    XACT_E_LOGFULL        = HRESULT(0x8004d01a),
    XACT_E_TMNOTAVAILABLE = HRESULT(0x8004d01b),
}

enum : HRESULT
{
    XACT_E_CONNECTION_DOWN   = HRESULT(0x8004d01c),
    XACT_E_CONNECTION_DENIED = HRESULT(0x8004d01d),
}

enum HRESULT XACT_E_REENLISTTIMEOUT = HRESULT(0x8004d01e);

enum : HRESULT
{
    XACT_E_TIP_CONNECT_FAILED = HRESULT(0x8004d01f),
    XACT_E_TIP_PROTOCOL_ERROR = HRESULT(0x8004d020),
    XACT_E_TIP_PULL_FAILED    = HRESULT(0x8004d021),
}

enum HRESULT XACT_E_DEST_TMNOTAVAILABLE = HRESULT(0x8004d022);
enum HRESULT XACT_E_TIP_DISABLED = HRESULT(0x8004d023);
enum HRESULT XACT_E_NETWORK_TX_DISABLED = HRESULT(0x8004d024);
enum HRESULT XACT_E_PARTNER_NETWORK_TX_DISABLED = HRESULT(0x8004d025);
enum HRESULT XACT_E_XA_TX_DISABLED = HRESULT(0x8004d026);

enum : HRESULT
{
    XACT_E_UNABLE_TO_READ_DTC_CONFIG = HRESULT(0x8004d027),
    XACT_E_UNABLE_TO_LOAD_DTC_PROXY  = HRESULT(0x8004d028),
}

enum : HRESULT
{
    XACT_E_ABORTING          = HRESULT(0x8004d029),
    XACT_E_PUSH_COMM_FAILURE = HRESULT(0x8004d02a),
}

enum HRESULT XACT_E_PULL_COMM_FAILURE = HRESULT(0x8004d02b);
enum HRESULT XACT_E_LU_TX_DISABLED = HRESULT(0x8004d02c);

enum : HRESULT
{
    XACT_E_CLERKNOTFOUND = HRESULT(0x8004d080),
    XACT_E_CLERKEXISTS   = HRESULT(0x8004d081),
}

enum HRESULT XACT_E_RECOVERYINPROGRESS = HRESULT(0x8004d082);
enum HRESULT XACT_E_TRANSACTIONCLOSED = HRESULT(0x8004d083);

enum : HRESULT
{
    XACT_E_INVALIDLSN    = HRESULT(0x8004d084),
    XACT_E_REPLAYREQUEST = HRESULT(0x8004d085),
}

enum : HRESULT
{
    XACT_S_ASYNC        = HRESULT(0x0004d000),
    XACT_S_DEFECT       = HRESULT(0x0004d001),
    XACT_S_READONLY     = HRESULT(0x0004d002),
    XACT_S_SOMENORETAIN = HRESULT(0x0004d003),
}

enum : HRESULT
{
    XACT_S_OKINFORM           = HRESULT(0x0004d004),
    XACT_S_MADECHANGESCONTENT = HRESULT(0x0004d005),
    XACT_S_MADECHANGESINFORM  = HRESULT(0x0004d006),
}

enum : HRESULT
{
    XACT_S_ALLNORETAIN = HRESULT(0x0004d007),
    XACT_S_ABORTING    = HRESULT(0x0004d008),
    XACT_S_SINGLEPHASE = HRESULT(0x0004d009),
}

enum : HRESULT
{
    XACT_S_LOCALLY_OK          = HRESULT(0x0004d00a),
    XACT_S_LASTRESOURCEMANAGER = HRESULT(0x0004d010),
}

enum : int
{
    CONTEXT_E_FIRST = 0x8004e000,
    CONTEXT_E_LAST  = 0x8004e02f,
    CONTEXT_S_FIRST = 0x0004e000,
    CONTEXT_S_LAST  = 0x0004e02f,
}

enum : HRESULT
{
    CONTEXT_E_ABORTED        = HRESULT(0x8004e002),
    CONTEXT_E_ABORTING       = HRESULT(0x8004e003),
    CONTEXT_E_NOCONTEXT      = HRESULT(0x8004e004),
    CONTEXT_E_WOULD_DEADLOCK = HRESULT(0x8004e005),
    CONTEXT_E_SYNCH_TIMEOUT  = HRESULT(0x8004e006),
    CONTEXT_E_OLDREF         = HRESULT(0x8004e007),
    CONTEXT_E_ROLENOTFOUND   = HRESULT(0x8004e00c),
    CONTEXT_E_TMNOTAVAILABLE = HRESULT(0x8004e00f),
}

enum : HRESULT
{
    CO_E_ACTIVATIONFAILED              = HRESULT(0x8004e021),
    CO_E_ACTIVATIONFAILED_EVENTLOGGED  = HRESULT(0x8004e022),
    CO_E_ACTIVATIONFAILED_CATALOGERROR = HRESULT(0x8004e023),
    CO_E_ACTIVATIONFAILED_TIMEOUT      = HRESULT(0x8004e024),
}

enum HRESULT CO_E_INITIALIZATIONFAILED = HRESULT(0x8004e025);

enum : HRESULT
{
    CONTEXT_E_NOJIT         = HRESULT(0x8004e026),
    CONTEXT_E_NOTRANSACTION = HRESULT(0x8004e027),
}

enum HRESULT CO_E_THREADINGMODEL_CHANGED = HRESULT(0x8004e028);
enum HRESULT CO_E_NOIISINTRINSICS = HRESULT(0x8004e029);
enum HRESULT CO_E_NOCOOKIES = HRESULT(0x8004e02a);

enum : HRESULT
{
    CO_E_DBERROR        = HRESULT(0x8004e02b),
    CO_E_NOTPOOLED      = HRESULT(0x8004e02c),
    CO_E_NOTCONSTRUCTED = HRESULT(0x8004e02d),
}

enum HRESULT CO_E_NOSYNCHRONIZATION = HRESULT(0x8004e02e);
enum HRESULT CO_E_ISOLEVELMISMATCH = HRESULT(0x8004e02f);
enum HRESULT CO_E_CALL_OUT_OF_TX_SCOPE_NOT_ALLOWED = HRESULT(0x8004e030);
enum HRESULT CO_E_EXIT_TRANSACTION_SCOPE_NOT_CALLED = HRESULT(0x8004e031);

enum : HRESULT
{
    OLE_S_USEREG         = HRESULT(0x00040000),
    OLE_S_STATIC         = HRESULT(0x00040001),
    OLE_S_MAC_CLIPFORMAT = HRESULT(0x00040002),
}

enum : HRESULT
{
    DRAGDROP_S_DROP              = HRESULT(0x00040100),
    DRAGDROP_S_CANCEL            = HRESULT(0x00040101),
    DRAGDROP_S_USEDEFAULTCURSORS = HRESULT(0x00040102),
}

enum HRESULT DATA_S_SAMEFORMATETC = HRESULT(0x00040130);
enum HRESULT VIEW_S_ALREADY_FROZEN = HRESULT(0x00040140);
enum HRESULT CACHE_S_FORMATETC_NOTSUPPORTED = HRESULT(0x00040170);

enum : HRESULT
{
    CACHE_S_SAMECACHE             = HRESULT(0x00040171),
    CACHE_S_SOMECACHES_NOTUPDATED = HRESULT(0x00040172),
}

enum : HRESULT
{
    OLEOBJ_S_INVALIDVERB       = HRESULT(0x00040180),
    OLEOBJ_S_CANNOT_DOVERB_NOW = HRESULT(0x00040181),
}

enum HRESULT OLEOBJ_S_INVALIDHWND = HRESULT(0x00040182);
enum HRESULT INPLACE_S_TRUNCATED = HRESULT(0x000401a0);
enum HRESULT CONVERT10_S_NO_PRESENTATION = HRESULT(0x000401c0);
enum HRESULT MK_S_REDUCED_TO_SELF = HRESULT(0x000401e2);

enum : HRESULT
{
    MK_S_ME                       = HRESULT(0x000401e4),
    MK_S_HIM                      = HRESULT(0x000401e5),
    MK_S_US                       = HRESULT(0x000401e6),
    MK_S_MONIKERALREADYREGISTERED = HRESULT(0x000401e7),
}

enum : HRESULT
{
    SCHED_S_TASK_READY             = HRESULT(0x00041300),
    SCHED_S_TASK_RUNNING           = HRESULT(0x00041301),
    SCHED_S_TASK_DISABLED          = HRESULT(0x00041302),
    SCHED_S_TASK_HAS_NOT_RUN       = HRESULT(0x00041303),
    SCHED_S_TASK_NO_MORE_RUNS      = HRESULT(0x00041304),
    SCHED_S_TASK_NOT_SCHEDULED     = HRESULT(0x00041305),
    SCHED_S_TASK_TERMINATED        = HRESULT(0x00041306),
    SCHED_S_TASK_NO_VALID_TRIGGERS = HRESULT(0x00041307),
}

enum HRESULT SCHED_S_EVENT_TRIGGER = HRESULT(0x00041308);
enum HRESULT SCHED_E_TRIGGER_NOT_FOUND = HRESULT(0x80041309);

enum : HRESULT
{
    SCHED_E_TASK_NOT_READY   = HRESULT(0x8004130a),
    SCHED_E_TASK_NOT_RUNNING = HRESULT(0x8004130b),
}

enum HRESULT SCHED_E_SERVICE_NOT_INSTALLED = HRESULT(0x8004130c);
enum HRESULT SCHED_E_CANNOT_OPEN_TASK = HRESULT(0x8004130d);
enum HRESULT SCHED_E_INVALID_TASK = HRESULT(0x8004130e);

enum : HRESULT
{
    SCHED_E_ACCOUNT_INFORMATION_NOT_SET = HRESULT(0x8004130f),
    SCHED_E_ACCOUNT_NAME_NOT_FOUND      = HRESULT(0x80041310),
    SCHED_E_ACCOUNT_DBASE_CORRUPT       = HRESULT(0x80041311),
}

enum HRESULT SCHED_E_NO_SECURITY_SERVICES = HRESULT(0x80041312);
enum HRESULT SCHED_E_UNKNOWN_OBJECT_VERSION = HRESULT(0x80041313);
enum HRESULT SCHED_E_UNSUPPORTED_ACCOUNT_OPTION = HRESULT(0x80041314);
enum HRESULT SCHED_E_SERVICE_NOT_RUNNING = HRESULT(0x80041315);
enum HRESULT SCHED_E_UNEXPECTEDNODE = HRESULT(0x80041316);

enum : HRESULT
{
    SCHED_E_NAMESPACE    = HRESULT(0x80041317),
    SCHED_E_INVALIDVALUE = HRESULT(0x80041318),
}

enum : HRESULT
{
    SCHED_E_MISSINGNODE  = HRESULT(0x80041319),
    SCHED_E_MALFORMEDXML = HRESULT(0x8004131a),
}

enum HRESULT SCHED_S_SOME_TRIGGERS_FAILED = HRESULT(0x0004131b);
enum HRESULT SCHED_S_BATCH_LOGON_PROBLEM = HRESULT(0x0004131c);
enum HRESULT SCHED_E_TOO_MANY_NODES = HRESULT(0x8004131d);
enum HRESULT SCHED_E_PAST_END_BOUNDARY = HRESULT(0x8004131e);
enum HRESULT SCHED_E_ALREADY_RUNNING = HRESULT(0x8004131f);
enum HRESULT SCHED_E_USER_NOT_LOGGED_ON = HRESULT(0x80041320);
enum HRESULT SCHED_E_INVALID_TASK_HASH = HRESULT(0x80041321);

enum : HRESULT
{
    SCHED_E_SERVICE_NOT_AVAILABLE = HRESULT(0x80041322),
    SCHED_E_SERVICE_TOO_BUSY      = HRESULT(0x80041323),
}

enum HRESULT SCHED_E_TASK_ATTEMPTED = HRESULT(0x80041324);
enum HRESULT SCHED_S_TASK_QUEUED = HRESULT(0x00041325);

enum : HRESULT
{
    SCHED_E_TASK_DISABLED      = HRESULT(0x80041326),
    SCHED_E_TASK_NOT_V1_COMPAT = HRESULT(0x80041327),
}

enum HRESULT SCHED_E_START_ON_DEMAND = HRESULT(0x80041328);
enum HRESULT SCHED_E_TASK_NOT_UBPM_COMPAT = HRESULT(0x80041329);
enum HRESULT SCHED_E_DEPRECATED_FEATURE_USED = HRESULT(0x80041330);
enum HRESULT CO_E_CLASS_CREATE_FAILED = HRESULT(0x80080001);

enum : HRESULT
{
    CO_E_SCM_ERROR       = HRESULT(0x80080002),
    CO_E_SCM_RPC_FAILURE = HRESULT(0x80080003),
}

enum HRESULT CO_E_BAD_PATH = HRESULT(0x80080004);
enum HRESULT CO_E_SERVER_EXEC_FAILURE = HRESULT(0x80080005);
enum HRESULT CO_E_OBJSRV_RPC_FAILURE = HRESULT(0x80080006);
enum HRESULT MK_E_NO_NORMALIZED = HRESULT(0x80080007);
enum HRESULT CO_E_SERVER_STOPPING = HRESULT(0x80080008);

enum : HRESULT
{
    MEM_E_INVALID_ROOT = HRESULT(0x80080009),
    MEM_E_INVALID_LINK = HRESULT(0x80080010),
    MEM_E_INVALID_SIZE = HRESULT(0x80080011),
}

enum HRESULT CO_S_NOTALLINTERFACES = HRESULT(0x00080012);
enum HRESULT CO_S_MACHINENAMENOTFOUND = HRESULT(0x00080013);
enum HRESULT CO_E_MISSING_DISPLAYNAME = HRESULT(0x80080015);
enum HRESULT CO_E_RUNAS_VALUE_MUST_BE_AAA = HRESULT(0x80080016);
enum HRESULT CO_E_ELEVATION_DISABLED = HRESULT(0x80080017);
enum HRESULT APPX_E_PACKAGING_INTERNAL = HRESULT(0x80080200);
enum HRESULT APPX_E_INTERLEAVING_NOT_ALLOWED = HRESULT(0x80080201);
enum HRESULT APPX_E_RELATIONSHIPS_NOT_ALLOWED = HRESULT(0x80080202);
enum HRESULT APPX_E_MISSING_REQUIRED_FILE = HRESULT(0x80080203);

enum : HRESULT
{
    APPX_E_INVALID_MANIFEST = HRESULT(0x80080204),
    APPX_E_INVALID_BLOCKMAP = HRESULT(0x80080205),
}

enum HRESULT APPX_E_CORRUPT_CONTENT = HRESULT(0x80080206);
enum HRESULT APPX_E_BLOCK_HASH_INVALID = HRESULT(0x80080207);
enum HRESULT APPX_E_REQUESTED_RANGE_TOO_LARGE = HRESULT(0x80080208);

enum : HRESULT
{
    APPX_E_INVALID_SIP_CLIENT_DATA = HRESULT(0x80080209),
    APPX_E_INVALID_KEY_INFO        = HRESULT(0x8008020a),
    APPX_E_INVALID_CONTENTGROUPMAP = HRESULT(0x8008020b),
    APPX_E_INVALID_APPINSTALLER    = HRESULT(0x8008020c),
}

enum HRESULT APPX_E_DELTA_BASELINE_VERSION_MISMATCH = HRESULT(0x8008020d);
enum HRESULT APPX_E_DELTA_PACKAGE_MISSING_FILE = HRESULT(0x8008020e);
enum HRESULT APPX_E_INVALID_DELTA_PACKAGE = HRESULT(0x8008020f);
enum HRESULT APPX_E_DELTA_APPENDED_PACKAGE_NOT_ALLOWED = HRESULT(0x80080210);

enum : HRESULT
{
    APPX_E_INVALID_PACKAGING_LAYOUT  = HRESULT(0x80080211),
    APPX_E_INVALID_PACKAGESIGNCONFIG = HRESULT(0x80080212),
}

enum HRESULT APPX_E_RESOURCESPRI_NOT_ALLOWED = HRESULT(0x80080213);
enum HRESULT APPX_E_FILE_COMPRESSION_MISMATCH = HRESULT(0x80080214);
enum HRESULT APPX_E_INVALID_PAYLOAD_PACKAGE_EXTENSION = HRESULT(0x80080215);
enum HRESULT APPX_E_INVALID_ENCRYPTION_EXCLUSION_FILE_LIST = HRESULT(0x80080216);

enum : HRESULT
{
    APPX_E_INVALID_PACKAGE_FOLDER_ACLS = HRESULT(0x80080217),
    APPX_E_INVALID_PUBLISHER_BRIDGING  = HRESULT(0x80080218),
}

enum HRESULT APPX_E_DIGEST_MISMATCH = HRESULT(0x80080219);
enum HRESULT BT_E_SPURIOUS_ACTIVATION = HRESULT(0x80080300);
enum HRESULT DISP_E_UNKNOWNINTERFACE = HRESULT(0x80020001);
enum HRESULT DISP_E_MEMBERNOTFOUND = HRESULT(0x80020003);
enum HRESULT DISP_E_PARAMNOTFOUND = HRESULT(0x80020004);
enum HRESULT DISP_E_TYPEMISMATCH = HRESULT(0x80020005);
enum HRESULT DISP_E_UNKNOWNNAME = HRESULT(0x80020006);
enum HRESULT DISP_E_NONAMEDARGS = HRESULT(0x80020007);

enum : HRESULT
{
    DISP_E_BADVARTYPE  = HRESULT(0x80020008),
    DISP_E_EXCEPTION   = HRESULT(0x80020009),
    DISP_E_OVERFLOW    = HRESULT(0x8002000a),
    DISP_E_BADINDEX    = HRESULT(0x8002000b),
    DISP_E_UNKNOWNLCID = HRESULT(0x8002000c),
}

enum HRESULT DISP_E_ARRAYISLOCKED = HRESULT(0x8002000d);
enum HRESULT DISP_E_BADPARAMCOUNT = HRESULT(0x8002000e);
enum HRESULT DISP_E_PARAMNOTOPTIONAL = HRESULT(0x8002000f);

enum : HRESULT
{
    DISP_E_BADCALLEE      = HRESULT(0x80020010),
    DISP_E_NOTACOLLECTION = HRESULT(0x80020011),
}

enum : HRESULT
{
    DISP_E_DIVBYZERO      = HRESULT(0x80020012),
    DISP_E_BUFFERTOOSMALL = HRESULT(0x80020013),
}

enum HRESULT TYPE_E_BUFFERTOOSMALL = HRESULT(0x80028016);
enum HRESULT TYPE_E_FIELDNOTFOUND = HRESULT(0x80028017);
enum HRESULT TYPE_E_INVDATAREAD = HRESULT(0x80028018);
enum HRESULT TYPE_E_UNSUPFORMAT = HRESULT(0x80028019);
enum HRESULT TYPE_E_REGISTRYACCESS = HRESULT(0x8002801c);
enum HRESULT TYPE_E_LIBNOTREGISTERED = HRESULT(0x8002801d);
enum HRESULT TYPE_E_UNDEFINEDTYPE = HRESULT(0x80028027);
enum HRESULT TYPE_E_QUALIFIEDNAMEDISALLOWED = HRESULT(0x80028028);
enum HRESULT TYPE_E_INVALIDSTATE = HRESULT(0x80028029);
enum HRESULT TYPE_E_WRONGTYPEKIND = HRESULT(0x8002802a);
enum HRESULT TYPE_E_ELEMENTNOTFOUND = HRESULT(0x8002802b);
enum HRESULT TYPE_E_AMBIGUOUSNAME = HRESULT(0x8002802c);
enum HRESULT TYPE_E_NAMECONFLICT = HRESULT(0x8002802d);
enum HRESULT TYPE_E_UNKNOWNLCID = HRESULT(0x8002802e);
enum HRESULT TYPE_E_DLLFUNCTIONNOTFOUND = HRESULT(0x8002802f);
enum HRESULT TYPE_E_BADMODULEKIND = HRESULT(0x800288bd);

enum : HRESULT
{
    TYPE_E_SIZETOOBIG  = HRESULT(0x800288c5),
    TYPE_E_DUPLICATEID = HRESULT(0x800288c6),
}

enum : HRESULT
{
    TYPE_E_INVALIDID    = HRESULT(0x800288cf),
    TYPE_E_TYPEMISMATCH = HRESULT(0x80028ca0),
}

enum HRESULT TYPE_E_OUTOFBOUNDS = HRESULT(0x80028ca1);

enum : HRESULT
{
    TYPE_E_IOERROR           = HRESULT(0x80028ca2),
    TYPE_E_CANTCREATETMPFILE = HRESULT(0x80028ca3),
    TYPE_E_CANTLOADLIBRARY   = HRESULT(0x80029c4a),
}

enum HRESULT TYPE_E_INCONSISTENTPROPFUNCS = HRESULT(0x80029c83);
enum HRESULT TYPE_E_CIRCULARTYPE = HRESULT(0x80029c84);
enum HRESULT STG_E_INVALIDFUNCTION = HRESULT(0x80030001);
enum HRESULT STG_E_FILENOTFOUND = HRESULT(0x80030002);
enum HRESULT STG_E_PATHNOTFOUND = HRESULT(0x80030003);
enum HRESULT STG_E_TOOMANYOPENFILES = HRESULT(0x80030004);
enum HRESULT STG_E_ACCESSDENIED = HRESULT(0x80030005);

enum : HRESULT
{
    STG_E_INVALIDHANDLE      = HRESULT(0x80030006),
    STG_E_INSUFFICIENTMEMORY = HRESULT(0x80030008),
}

enum HRESULT STG_E_INVALIDPOINTER = HRESULT(0x80030009);
enum HRESULT STG_E_NOMOREFILES = HRESULT(0x80030012);
enum HRESULT STG_E_DISKISWRITEPROTECTED = HRESULT(0x80030013);
enum HRESULT STG_E_SEEKERROR = HRESULT(0x80030019);
enum HRESULT STG_E_WRITEFAULT = HRESULT(0x8003001d);
enum HRESULT STG_E_READFAULT = HRESULT(0x8003001e);
enum HRESULT STG_E_SHAREVIOLATION = HRESULT(0x80030020);
enum HRESULT STG_E_LOCKVIOLATION = HRESULT(0x80030021);
enum HRESULT STG_E_FILEALREADYEXISTS = HRESULT(0x80030050);
enum HRESULT STG_E_INVALIDPARAMETER = HRESULT(0x80030057);
enum HRESULT STG_E_MEDIUMFULL = HRESULT(0x80030070);
enum HRESULT STG_E_PROPSETMISMATCHED = HRESULT(0x800300f0);
enum HRESULT STG_E_ABNORMALAPIEXIT = HRESULT(0x800300fa);

enum : HRESULT
{
    STG_E_INVALIDHEADER = HRESULT(0x800300fb),
    STG_E_INVALIDNAME   = HRESULT(0x800300fc),
}

enum : HRESULT
{
    STG_E_UNKNOWN               = HRESULT(0x800300fd),
    STG_E_UNIMPLEMENTEDFUNCTION = HRESULT(0x800300fe),
}

enum : HRESULT
{
    STG_E_INVALIDFLAG = HRESULT(0x800300ff),
    STG_E_INUSE       = HRESULT(0x80030100),
    STG_E_NOTCURRENT  = HRESULT(0x80030101),
}

enum : HRESULT
{
    STG_E_REVERTED      = HRESULT(0x80030102),
    STG_E_CANTSAVE      = HRESULT(0x80030103),
    STG_E_OLDFORMAT     = HRESULT(0x80030104),
    STG_E_OLDDLL        = HRESULT(0x80030105),
    STG_E_SHAREREQUIRED = HRESULT(0x80030106),
}

enum HRESULT STG_E_NOTFILEBASEDSTORAGE = HRESULT(0x80030107);
enum HRESULT STG_E_EXTANTMARSHALLINGS = HRESULT(0x80030108);
enum HRESULT STG_E_DOCFILECORRUPT = HRESULT(0x80030109);
enum HRESULT STG_E_BADBASEADDRESS = HRESULT(0x80030110);
enum HRESULT STG_E_DOCFILETOOLARGE = HRESULT(0x80030111);
enum HRESULT STG_E_NOTSIMPLEFORMAT = HRESULT(0x80030112);
enum HRESULT STG_E_INCOMPLETE = HRESULT(0x80030201);
enum HRESULT STG_E_TERMINATED = HRESULT(0x80030202);
enum HRESULT STG_S_CONVERTED = HRESULT(0x00030200);

enum : HRESULT
{
    STG_S_BLOCK         = HRESULT(0x00030201),
    STG_S_RETRYNOW      = HRESULT(0x00030202),
    STG_S_MONITORING    = HRESULT(0x00030203),
    STG_S_MULTIPLEOPENS = HRESULT(0x00030204),
}

enum HRESULT STG_S_CONSOLIDATIONFAILED = HRESULT(0x00030205);
enum HRESULT STG_S_CANNOTCONSOLIDATE = HRESULT(0x00030206);
enum HRESULT STG_S_POWER_CYCLE_REQUIRED = HRESULT(0x00030207);

enum : HRESULT
{
    STG_E_FIRMWARE_SLOT_INVALID  = HRESULT(0x80030208),
    STG_E_FIRMWARE_IMAGE_INVALID = HRESULT(0x80030209),
}

enum HRESULT STG_E_DEVICE_UNRESPONSIVE = HRESULT(0x8003020a);
enum HRESULT STG_E_STATUS_COPY_PROTECTION_FAILURE = HRESULT(0x80030305);
enum HRESULT STG_E_CSS_AUTHENTICATION_FAILURE = HRESULT(0x80030306);

enum : HRESULT
{
    STG_E_CSS_KEY_NOT_PRESENT     = HRESULT(0x80030307),
    STG_E_CSS_KEY_NOT_ESTABLISHED = HRESULT(0x80030308),
}

enum HRESULT STG_E_CSS_SCRAMBLED_SECTOR = HRESULT(0x80030309);
enum HRESULT STG_E_CSS_REGION_MISMATCH = HRESULT(0x8003030a);
enum HRESULT STG_E_RESETS_EXHAUSTED = HRESULT(0x8003030b);

enum : HRESULT
{
    RPC_E_CALL_REJECTED       = HRESULT(0x80010001),
    RPC_E_CALL_CANCELED       = HRESULT(0x80010002),
    RPC_E_CANTPOST_INSENDCALL = HRESULT(0x80010003),
}

enum : HRESULT
{
    RPC_E_CANTCALLOUT_INASYNCCALL    = HRESULT(0x80010004),
    RPC_E_CANTCALLOUT_INEXTERNALCALL = HRESULT(0x80010005),
}

enum HRESULT RPC_E_CONNECTION_TERMINATED = HRESULT(0x80010006);
enum HRESULT RPC_E_SERVER_DIED = HRESULT(0x80010007);
enum HRESULT RPC_E_CLIENT_DIED = HRESULT(0x80010008);
enum HRESULT RPC_E_INVALID_DATAPACKET = HRESULT(0x80010009);
enum HRESULT RPC_E_CANTTRANSMIT_CALL = HRESULT(0x8001000a);

enum : HRESULT
{
    RPC_E_CLIENT_CANTMARSHAL_DATA   = HRESULT(0x8001000b),
    RPC_E_CLIENT_CANTUNMARSHAL_DATA = HRESULT(0x8001000c),
}

enum : HRESULT
{
    RPC_E_SERVER_CANTMARSHAL_DATA   = HRESULT(0x8001000d),
    RPC_E_SERVER_CANTUNMARSHAL_DATA = HRESULT(0x8001000e),
}

enum : HRESULT
{
    RPC_E_INVALID_DATA      = HRESULT(0x8001000f),
    RPC_E_INVALID_PARAMETER = HRESULT(0x80010010),
}

enum HRESULT RPC_E_CANTCALLOUT_AGAIN = HRESULT(0x80010011);
enum HRESULT RPC_E_SERVER_DIED_DNE = HRESULT(0x80010012);
enum HRESULT RPC_E_SYS_CALL_FAILED = HRESULT(0x80010100);
enum HRESULT RPC_E_OUT_OF_RESOURCES = HRESULT(0x80010101);
enum HRESULT RPC_E_ATTEMPTED_MULTITHREAD = HRESULT(0x80010102);
enum HRESULT RPC_E_NOT_REGISTERED = HRESULT(0x80010103);

enum : HRESULT
{
    RPC_E_FAULT       = HRESULT(0x80010104),
    RPC_E_SERVERFAULT = HRESULT(0x80010105),
}

enum HRESULT RPC_E_CHANGED_MODE = HRESULT(0x80010106);
enum HRESULT RPC_E_INVALIDMETHOD = HRESULT(0x80010107);
enum HRESULT RPC_E_DISCONNECTED = HRESULT(0x80010108);

enum : HRESULT
{
    RPC_E_RETRY                 = HRESULT(0x80010109),
    RPC_E_SERVERCALL_RETRYLATER = HRESULT(0x8001010a),
    RPC_E_SERVERCALL_REJECTED   = HRESULT(0x8001010b),
}

enum HRESULT RPC_E_INVALID_CALLDATA = HRESULT(0x8001010c);
enum HRESULT RPC_E_CANTCALLOUT_ININPUTSYNCCALL = HRESULT(0x8001010d);
enum HRESULT RPC_E_WRONG_THREAD = HRESULT(0x8001010e);
enum HRESULT RPC_E_THREAD_NOT_INIT = HRESULT(0x8001010f);
enum HRESULT RPC_E_VERSION_MISMATCH = HRESULT(0x80010110);

enum : HRESULT
{
    RPC_E_INVALID_HEADER    = HRESULT(0x80010111),
    RPC_E_INVALID_EXTENSION = HRESULT(0x80010112),
    RPC_E_INVALID_IPID      = HRESULT(0x80010113),
    RPC_E_INVALID_OBJECT    = HRESULT(0x80010114),
}

enum HRESULT RPC_S_CALLPENDING = HRESULT(0x80010115);
enum HRESULT RPC_S_WAITONTIMER = HRESULT(0x80010116);
enum HRESULT RPC_E_CALL_COMPLETE = HRESULT(0x80010117);
enum HRESULT RPC_E_UNSECURE_CALL = HRESULT(0x80010118);

enum : HRESULT
{
    RPC_E_TOO_LATE                  = HRESULT(0x80010119),
    RPC_E_NO_GOOD_SECURITY_PACKAGES = HRESULT(0x8001011a),
}

enum HRESULT RPC_E_ACCESS_DENIED = HRESULT(0x8001011b);
enum HRESULT RPC_E_REMOTE_DISABLED = HRESULT(0x8001011c);
enum HRESULT RPC_E_INVALID_OBJREF = HRESULT(0x8001011d);
enum HRESULT RPC_E_NO_CONTEXT = HRESULT(0x8001011e);

enum : HRESULT
{
    RPC_E_TIMEOUT          = HRESULT(0x8001011f),
    RPC_E_NO_SYNC          = HRESULT(0x80010120),
    RPC_E_FULLSIC_REQUIRED = HRESULT(0x80010121),
}

enum HRESULT RPC_E_INVALID_STD_NAME = HRESULT(0x80010122);

enum : HRESULT
{
    CO_E_FAILEDTOIMPERSONATE     = HRESULT(0x80010123),
    CO_E_FAILEDTOGETSECCTX       = HRESULT(0x80010124),
    CO_E_FAILEDTOOPENTHREADTOKEN = HRESULT(0x80010125),
    CO_E_FAILEDTOGETTOKENINFO    = HRESULT(0x80010126),
}

enum HRESULT CO_E_TRUSTEEDOESNTMATCHCLIENT = HRESULT(0x80010127);

enum : HRESULT
{
    CO_E_FAILEDTOQUERYCLIENTBLANKET = HRESULT(0x80010128),
    CO_E_FAILEDTOSETDACL            = HRESULT(0x80010129),
}

enum HRESULT CO_E_ACCESSCHECKFAILED = HRESULT(0x8001012a);
enum HRESULT CO_E_NETACCESSAPIFAILED = HRESULT(0x8001012b);
enum HRESULT CO_E_WRONGTRUSTEENAMESYNTAX = HRESULT(0x8001012c);
enum HRESULT CO_E_INVALIDSID = HRESULT(0x8001012d);
enum HRESULT CO_E_CONVERSIONFAILED = HRESULT(0x8001012e);
enum HRESULT CO_E_NOMATCHINGSIDFOUND = HRESULT(0x8001012f);
enum HRESULT CO_E_LOOKUPACCSIDFAILED = HRESULT(0x80010130);
enum HRESULT CO_E_NOMATCHINGNAMEFOUND = HRESULT(0x80010131);
enum HRESULT CO_E_LOOKUPACCNAMEFAILED = HRESULT(0x80010132);
enum HRESULT CO_E_SETSERLHNDLFAILED = HRESULT(0x80010133);
enum HRESULT CO_E_FAILEDTOGETWINDIR = HRESULT(0x80010134);
enum HRESULT CO_E_PATHTOOLONG = HRESULT(0x80010135);

enum : HRESULT
{
    CO_E_FAILEDTOGENUUID     = HRESULT(0x80010136),
    CO_E_FAILEDTOCREATEFILE  = HRESULT(0x80010137),
    CO_E_FAILEDTOCLOSEHANDLE = HRESULT(0x80010138),
}

enum HRESULT CO_E_EXCEEDSYSACLLIMIT = HRESULT(0x80010139);
enum HRESULT CO_E_ACESINWRONGORDER = HRESULT(0x8001013a);
enum HRESULT CO_E_INCOMPATIBLESTREAMVERSION = HRESULT(0x8001013b);
enum HRESULT CO_E_FAILEDTOOPENPROCESSTOKEN = HRESULT(0x8001013c);
enum HRESULT CO_E_DECODEFAILED = HRESULT(0x8001013d);
enum HRESULT CO_E_ACNOTINITIALIZED = HRESULT(0x8001013f);
enum HRESULT CO_E_CANCEL_DISABLED = HRESULT(0x80010140);
enum HRESULT CO_E_SERVER_CANNOT_BE_EQUAL_OR_GREATER_PRIVILEGE = HRESULT(0x80010141);
enum HRESULT CO_E_CANNOT_ACTIVATE_CROSS_PACKAGE_IN_SESSION_0 = HRESULT(0x80010142);
enum HRESULT RPC_E_UNEXPECTED = HRESULT(0x8001ffff);
enum HRESULT ERROR_AUDITING_DISABLED = HRESULT(0xc0090001);
enum HRESULT ERROR_ALL_SIDS_FILTERED = HRESULT(0xc0090002);
enum HRESULT ERROR_BIZRULES_NOT_ENABLED = HRESULT(0xc0090003);

enum : HRESULT
{
    NTE_BAD_UID        = HRESULT(0x80090001),
    NTE_BAD_HASH       = HRESULT(0x80090002),
    NTE_BAD_KEY        = HRESULT(0x80090003),
    NTE_BAD_LEN        = HRESULT(0x80090004),
    NTE_BAD_DATA       = HRESULT(0x80090005),
    NTE_BAD_SIGNATURE  = HRESULT(0x80090006),
    NTE_BAD_VER        = HRESULT(0x80090007),
    NTE_BAD_ALGID      = HRESULT(0x80090008),
    NTE_BAD_FLAGS      = HRESULT(0x80090009),
    NTE_BAD_TYPE       = HRESULT(0x8009000a),
    NTE_BAD_KEY_STATE  = HRESULT(0x8009000b),
    NTE_BAD_HASH_STATE = HRESULT(0x8009000c),
}

enum : HRESULT
{
    NTE_NO_KEY    = HRESULT(0x8009000d),
    NTE_NO_MEMORY = HRESULT(0x8009000e),
}

enum HRESULT NTE_EXISTS = HRESULT(0x8009000f);

enum : HRESULT
{
    NTE_PERM      = HRESULT(0x80090010),
    NTE_NOT_FOUND = HRESULT(0x80090011),
}

enum HRESULT NTE_DOUBLE_ENCRYPT = HRESULT(0x80090012);

enum : HRESULT
{
    NTE_BAD_PROVIDER   = HRESULT(0x80090013),
    NTE_BAD_PROV_TYPE  = HRESULT(0x80090014),
    NTE_BAD_PUBLIC_KEY = HRESULT(0x80090015),
    NTE_BAD_KEYSET     = HRESULT(0x80090016),
}

enum : HRESULT
{
    NTE_PROV_TYPE_NOT_DEF   = HRESULT(0x80090017),
    NTE_PROV_TYPE_ENTRY_BAD = HRESULT(0x80090018),
}

enum : HRESULT
{
    NTE_KEYSET_NOT_DEF   = HRESULT(0x80090019),
    NTE_KEYSET_ENTRY_BAD = HRESULT(0x8009001a),
}

enum HRESULT NTE_PROV_TYPE_NO_MATCH = HRESULT(0x8009001b);
enum HRESULT NTE_SIGNATURE_FILE_BAD = HRESULT(0x8009001c);
enum HRESULT NTE_PROVIDER_DLL_FAIL = HRESULT(0x8009001d);
enum HRESULT NTE_PROV_DLL_NOT_FOUND = HRESULT(0x8009001e);
enum HRESULT NTE_BAD_KEYSET_PARAM = HRESULT(0x8009001f);

enum : HRESULT
{
    NTE_FAIL           = HRESULT(0x80090020),
    NTE_SYS_ERR        = HRESULT(0x80090021),
    NTE_SILENT_CONTEXT = HRESULT(0x80090022),
}

enum HRESULT NTE_TOKEN_KEYSET_STORAGE_FULL = HRESULT(0x80090023);
enum HRESULT NTE_TEMPORARY_PROFILE = HRESULT(0x80090024);
enum HRESULT NTE_FIXEDPARAMETER = HRESULT(0x80090025);

enum : HRESULT
{
    NTE_INVALID_HANDLE    = HRESULT(0x80090026),
    NTE_INVALID_PARAMETER = HRESULT(0x80090027),
}

enum HRESULT NTE_BUFFER_TOO_SMALL = HRESULT(0x80090028);
enum HRESULT NTE_NOT_SUPPORTED = HRESULT(0x80090029);
enum HRESULT NTE_NO_MORE_ITEMS = HRESULT(0x8009002a);
enum HRESULT NTE_BUFFERS_OVERLAP = HRESULT(0x8009002b);
enum HRESULT NTE_DECRYPTION_FAILURE = HRESULT(0x8009002c);
enum HRESULT NTE_INTERNAL_ERROR = HRESULT(0x8009002d);
enum HRESULT NTE_UI_REQUIRED = HRESULT(0x8009002e);
enum HRESULT NTE_HMAC_NOT_SUPPORTED = HRESULT(0x8009002f);
enum HRESULT NTE_DEVICE_NOT_READY = HRESULT(0x80090030);
enum HRESULT NTE_AUTHENTICATION_IGNORED = HRESULT(0x80090031);
enum HRESULT NTE_VALIDATION_FAILED = HRESULT(0x80090032);
enum HRESULT NTE_INCORRECT_PASSWORD = HRESULT(0x80090033);
enum HRESULT NTE_ENCRYPTION_FAILURE = HRESULT(0x80090034);
enum HRESULT NTE_DEVICE_NOT_FOUND = HRESULT(0x80090035);
enum HRESULT NTE_USER_CANCELLED = HRESULT(0x80090036);
enum HRESULT NTE_PASSWORD_CHANGE_REQUIRED = HRESULT(0x80090037);
enum HRESULT NTE_NOT_ACTIVE_CONSOLE = HRESULT(0x80090038);

enum : HRESULT
{
    NTE_VBS_UNAVAILABLE        = HRESULT(0x80090039),
    NTE_VBS_CANNOT_DECRYPT_KEY = HRESULT(0x8009003a),
}

enum HRESULT SEC_E_INSUFFICIENT_MEMORY = HRESULT(0x80090300);
enum HRESULT SEC_E_INVALID_HANDLE = HRESULT(0x80090301);
enum HRESULT SEC_E_UNSUPPORTED_FUNCTION = HRESULT(0x80090302);
enum HRESULT SEC_E_TARGET_UNKNOWN = HRESULT(0x80090303);
enum HRESULT SEC_E_INTERNAL_ERROR = HRESULT(0x80090304);
enum HRESULT SEC_E_SECPKG_NOT_FOUND = HRESULT(0x80090305);
enum HRESULT SEC_E_NOT_OWNER = HRESULT(0x80090306);
enum HRESULT SEC_E_CANNOT_INSTALL = HRESULT(0x80090307);
enum HRESULT SEC_E_INVALID_TOKEN = HRESULT(0x80090308);
enum HRESULT SEC_E_CANNOT_PACK = HRESULT(0x80090309);
enum HRESULT SEC_E_QOP_NOT_SUPPORTED = HRESULT(0x8009030a);
enum HRESULT SEC_E_NO_IMPERSONATION = HRESULT(0x8009030b);
enum HRESULT SEC_E_LOGON_DENIED = HRESULT(0x8009030c);
enum HRESULT SEC_E_UNKNOWN_CREDENTIALS = HRESULT(0x8009030d);
enum HRESULT SEC_E_NO_CREDENTIALS = HRESULT(0x8009030e);
enum HRESULT SEC_E_MESSAGE_ALTERED = HRESULT(0x8009030f);
enum HRESULT SEC_E_OUT_OF_SEQUENCE = HRESULT(0x80090310);
enum HRESULT SEC_E_NO_AUTHENTICATING_AUTHORITY = HRESULT(0x80090311);
enum HRESULT SEC_I_CONTINUE_NEEDED = HRESULT(0x00090312);

enum : HRESULT
{
    SEC_I_COMPLETE_NEEDED       = HRESULT(0x00090313),
    SEC_I_COMPLETE_AND_CONTINUE = HRESULT(0x00090314),
}

enum HRESULT SEC_I_LOCAL_LOGON = HRESULT(0x00090315);
enum HRESULT SEC_I_GENERIC_EXTENSION_RECEIVED = HRESULT(0x00090316);
enum HRESULT SEC_E_BAD_PKGID = HRESULT(0x80090316);
enum HRESULT SEC_E_CONTEXT_EXPIRED = HRESULT(0x80090317);
enum HRESULT SEC_I_CONTEXT_EXPIRED = HRESULT(0x00090317);

enum : HRESULT
{
    SEC_E_INCOMPLETE_MESSAGE     = HRESULT(0x80090318),
    SEC_E_INCOMPLETE_CREDENTIALS = HRESULT(0x80090320),
}

enum HRESULT SEC_E_BUFFER_TOO_SMALL = HRESULT(0x80090321);
enum HRESULT SEC_I_INCOMPLETE_CREDENTIALS = HRESULT(0x00090320);
enum HRESULT SEC_I_RENEGOTIATE = HRESULT(0x00090321);
enum HRESULT SEC_E_WRONG_PRINCIPAL = HRESULT(0x80090322);
enum HRESULT SEC_I_NO_LSA_CONTEXT = HRESULT(0x00090323);
enum HRESULT SEC_E_TIME_SKEW = HRESULT(0x80090324);
enum HRESULT SEC_E_UNTRUSTED_ROOT = HRESULT(0x80090325);
enum HRESULT SEC_E_ILLEGAL_MESSAGE = HRESULT(0x80090326);

enum : HRESULT
{
    SEC_E_CERT_UNKNOWN = HRESULT(0x80090327),
    SEC_E_CERT_EXPIRED = HRESULT(0x80090328),
}

enum HRESULT SEC_E_ENCRYPT_FAILURE = HRESULT(0x80090329);
enum HRESULT SEC_E_DECRYPT_FAILURE = HRESULT(0x80090330);
enum HRESULT SEC_E_ALGORITHM_MISMATCH = HRESULT(0x80090331);
enum HRESULT SEC_E_SECURITY_QOS_FAILED = HRESULT(0x80090332);
enum HRESULT SEC_E_UNFINISHED_CONTEXT_DELETED = HRESULT(0x80090333);

enum : HRESULT
{
    SEC_E_NO_TGT_REPLY    = HRESULT(0x80090334),
    SEC_E_NO_IP_ADDRESSES = HRESULT(0x80090335),
}

enum HRESULT SEC_E_WRONG_CREDENTIAL_HANDLE = HRESULT(0x80090336);
enum HRESULT SEC_E_CRYPTO_SYSTEM_INVALID = HRESULT(0x80090337);
enum HRESULT SEC_E_MAX_REFERRALS_EXCEEDED = HRESULT(0x80090338);
enum HRESULT SEC_E_MUST_BE_KDC = HRESULT(0x80090339);
enum HRESULT SEC_E_STRONG_CRYPTO_NOT_SUPPORTED = HRESULT(0x8009033a);
enum HRESULT SEC_E_TOO_MANY_PRINCIPALS = HRESULT(0x8009033b);
enum HRESULT SEC_E_NO_PA_DATA = HRESULT(0x8009033c);
enum HRESULT SEC_E_PKINIT_NAME_MISMATCH = HRESULT(0x8009033d);
enum HRESULT SEC_E_SMARTCARD_LOGON_REQUIRED = HRESULT(0x8009033e);
enum HRESULT SEC_E_SHUTDOWN_IN_PROGRESS = HRESULT(0x8009033f);
enum HRESULT SEC_E_KDC_INVALID_REQUEST = HRESULT(0x80090340);

enum : HRESULT
{
    SEC_E_KDC_UNABLE_TO_REFER = HRESULT(0x80090341),
    SEC_E_KDC_UNKNOWN_ETYPE   = HRESULT(0x80090342),
}

enum HRESULT SEC_E_UNSUPPORTED_PREAUTH = HRESULT(0x80090343);
enum HRESULT SEC_E_DELEGATION_REQUIRED = HRESULT(0x80090345);
enum HRESULT SEC_E_BAD_BINDINGS = HRESULT(0x80090346);
enum HRESULT SEC_E_MULTIPLE_ACCOUNTS = HRESULT(0x80090347);
enum HRESULT SEC_E_NO_KERB_KEY = HRESULT(0x80090348);
enum HRESULT SEC_E_CERT_WRONG_USAGE = HRESULT(0x80090349);
enum HRESULT SEC_E_DOWNGRADE_DETECTED = HRESULT(0x80090350);
enum HRESULT SEC_E_SMARTCARD_CERT_REVOKED = HRESULT(0x80090351);
enum HRESULT SEC_E_ISSUING_CA_UNTRUSTED = HRESULT(0x80090352);
enum HRESULT SEC_E_REVOCATION_OFFLINE_C = HRESULT(0x80090353);
enum HRESULT SEC_E_PKINIT_CLIENT_FAILURE = HRESULT(0x80090354);
enum HRESULT SEC_E_SMARTCARD_CERT_EXPIRED = HRESULT(0x80090355);
enum HRESULT SEC_E_NO_S4U_PROT_SUPPORT = HRESULT(0x80090356);
enum HRESULT SEC_E_CROSSREALM_DELEGATION_FAILURE = HRESULT(0x80090357);
enum HRESULT SEC_E_REVOCATION_OFFLINE_KDC = HRESULT(0x80090358);
enum HRESULT SEC_E_ISSUING_CA_UNTRUSTED_KDC = HRESULT(0x80090359);

enum : HRESULT
{
    SEC_E_KDC_CERT_EXPIRED = HRESULT(0x8009035a),
    SEC_E_KDC_CERT_REVOKED = HRESULT(0x8009035b),
}

enum HRESULT SEC_I_SIGNATURE_NEEDED = HRESULT(0x0009035c);
enum HRESULT SEC_E_INVALID_PARAMETER = HRESULT(0x8009035d);
enum HRESULT SEC_E_DELEGATION_POLICY = HRESULT(0x8009035e);
enum HRESULT SEC_E_POLICY_NLTM_ONLY = HRESULT(0x8009035f);
enum HRESULT SEC_I_NO_RENEGOTIATION = HRESULT(0x00090360);
enum HRESULT SEC_E_NO_CONTEXT = HRESULT(0x80090361);
enum HRESULT SEC_E_PKU2U_CERT_FAILURE = HRESULT(0x80090362);
enum HRESULT SEC_E_MUTUAL_AUTH_FAILED = HRESULT(0x80090363);
enum HRESULT SEC_I_MESSAGE_FRAGMENT = HRESULT(0x00090364);
enum HRESULT SEC_E_ONLY_HTTPS_ALLOWED = HRESULT(0x80090365);
enum HRESULT SEC_I_CONTINUE_NEEDED_MESSAGE_OK = HRESULT(0x00090366);
enum HRESULT SEC_E_APPLICATION_PROTOCOL_MISMATCH = HRESULT(0x80090367);
enum HRESULT SEC_I_ASYNC_CALL_PENDING = HRESULT(0x00090368);
enum HRESULT SEC_E_INVALID_UPN_NAME = HRESULT(0x80090369);
enum HRESULT SEC_E_EXT_BUFFER_TOO_SMALL = HRESULT(0x8009036a);
enum HRESULT SEC_E_INSUFFICIENT_BUFFERS = HRESULT(0x8009036b);
enum HRESULT SEC_I_INVALID_SESSION_STATE = HRESULT(0x8009036c);

enum : int
{
    SEC_E_NO_SPM        = 0x80090304,
    SEC_E_NOT_SUPPORTED = 0x80090302,
}

enum : HRESULT
{
    CRYPT_E_MSG_ERROR    = HRESULT(0x80091001),
    CRYPT_E_UNKNOWN_ALGO = HRESULT(0x80091002),
}

enum : HRESULT
{
    CRYPT_E_OID_FORMAT       = HRESULT(0x80091003),
    CRYPT_E_INVALID_MSG_TYPE = HRESULT(0x80091004),
}

enum HRESULT CRYPT_E_UNEXPECTED_ENCODING = HRESULT(0x80091005);
enum HRESULT CRYPT_E_AUTH_ATTR_MISSING = HRESULT(0x80091006);

enum : HRESULT
{
    CRYPT_E_HASH_VALUE    = HRESULT(0x80091007),
    CRYPT_E_INVALID_INDEX = HRESULT(0x80091008),
}

enum HRESULT CRYPT_E_ALREADY_DECRYPTED = HRESULT(0x80091009);
enum HRESULT CRYPT_E_NOT_DECRYPTED = HRESULT(0x8009100a);
enum HRESULT CRYPT_E_RECIPIENT_NOT_FOUND = HRESULT(0x8009100b);
enum HRESULT CRYPT_E_CONTROL_TYPE = HRESULT(0x8009100c);
enum HRESULT CRYPT_E_ISSUER_SERIALNUMBER = HRESULT(0x8009100d);
enum HRESULT CRYPT_E_SIGNER_NOT_FOUND = HRESULT(0x8009100e);
enum HRESULT CRYPT_E_ATTRIBUTES_MISSING = HRESULT(0x8009100f);

enum : HRESULT
{
    CRYPT_E_STREAM_MSG_NOT_READY     = HRESULT(0x80091010),
    CRYPT_E_STREAM_INSUFFICIENT_DATA = HRESULT(0x80091011),
}

enum HRESULT CRYPT_I_NEW_PROTECTION_REQUIRED = HRESULT(0x00091012);

enum : HRESULT
{
    CRYPT_E_BAD_LEN      = HRESULT(0x80092001),
    CRYPT_E_BAD_ENCODE   = HRESULT(0x80092002),
    CRYPT_E_FILE_ERROR   = HRESULT(0x80092003),
    CRYPT_E_NOT_FOUND    = HRESULT(0x80092004),
    CRYPT_E_EXISTS       = HRESULT(0x80092005),
    CRYPT_E_NO_PROVIDER  = HRESULT(0x80092006),
    CRYPT_E_SELF_SIGNED  = HRESULT(0x80092007),
    CRYPT_E_DELETED_PREV = HRESULT(0x80092008),
}

enum : HRESULT
{
    CRYPT_E_NO_MATCH            = HRESULT(0x80092009),
    CRYPT_E_UNEXPECTED_MSG_TYPE = HRESULT(0x8009200a),
}

enum : HRESULT
{
    CRYPT_E_NO_KEY_PROPERTY = HRESULT(0x8009200b),
    CRYPT_E_NO_DECRYPT_CERT = HRESULT(0x8009200c),
}

enum : HRESULT
{
    CRYPT_E_BAD_MSG       = HRESULT(0x8009200d),
    CRYPT_E_NO_SIGNER     = HRESULT(0x8009200e),
    CRYPT_E_PENDING_CLOSE = HRESULT(0x8009200f),
}

enum : HRESULT
{
    CRYPT_E_REVOKED             = HRESULT(0x80092010),
    CRYPT_E_NO_REVOCATION_DLL   = HRESULT(0x80092011),
    CRYPT_E_NO_REVOCATION_CHECK = HRESULT(0x80092012),
}

enum HRESULT CRYPT_E_REVOCATION_OFFLINE = HRESULT(0x80092013);
enum HRESULT CRYPT_E_NOT_IN_REVOCATION_DATABASE = HRESULT(0x80092014);

enum : HRESULT
{
    CRYPT_E_INVALID_NUMERIC_STRING   = HRESULT(0x80092020),
    CRYPT_E_INVALID_PRINTABLE_STRING = HRESULT(0x80092021),
    CRYPT_E_INVALID_IA5_STRING       = HRESULT(0x80092022),
    CRYPT_E_INVALID_X500_STRING      = HRESULT(0x80092023),
}

enum HRESULT CRYPT_E_NOT_CHAR_STRING = HRESULT(0x80092024);

enum : HRESULT
{
    CRYPT_E_FILERESIZED       = HRESULT(0x80092025),
    CRYPT_E_SECURITY_SETTINGS = HRESULT(0x80092026),
}

enum : HRESULT
{
    CRYPT_E_NO_VERIFY_USAGE_DLL   = HRESULT(0x80092027),
    CRYPT_E_NO_VERIFY_USAGE_CHECK = HRESULT(0x80092028),
}

enum HRESULT CRYPT_E_VERIFY_USAGE_OFFLINE = HRESULT(0x80092029);

enum : HRESULT
{
    CRYPT_E_NOT_IN_CTL        = HRESULT(0x8009202a),
    CRYPT_E_NO_TRUSTED_SIGNER = HRESULT(0x8009202b),
}

enum HRESULT CRYPT_E_MISSING_PUBKEY_PARA = HRESULT(0x8009202c);
enum HRESULT CRYPT_E_OBJECT_LOCATOR_OBJECT_NOT_FOUND = HRESULT(0x8009202d);
enum HRESULT CRYPT_E_OSS_ERROR = HRESULT(0x80093000);
enum HRESULT OSS_MORE_BUF = HRESULT(0x80093001);
enum HRESULT OSS_NEGATIVE_UINTEGER = HRESULT(0x80093002);
enum HRESULT OSS_PDU_RANGE = HRESULT(0x80093003);
enum HRESULT OSS_MORE_INPUT = HRESULT(0x80093004);
enum HRESULT OSS_DATA_ERROR = HRESULT(0x80093005);

enum : HRESULT
{
    OSS_BAD_ARG     = HRESULT(0x80093006),
    OSS_BAD_VERSION = HRESULT(0x80093007),
}

enum HRESULT OSS_OUT_MEMORY = HRESULT(0x80093008);
enum HRESULT OSS_PDU_MISMATCH = HRESULT(0x80093009);
enum HRESULT OSS_LIMITED = HRESULT(0x8009300a);

enum : HRESULT
{
    OSS_BAD_PTR  = HRESULT(0x8009300b),
    OSS_BAD_TIME = HRESULT(0x8009300c),
}

enum HRESULT OSS_INDEFINITE_NOT_SUPPORTED = HRESULT(0x8009300d);
enum HRESULT OSS_MEM_ERROR = HRESULT(0x8009300e);
enum HRESULT OSS_BAD_TABLE = HRESULT(0x8009300f);
enum HRESULT OSS_TOO_LONG = HRESULT(0x80093010);
enum HRESULT OSS_CONSTRAINT_VIOLATED = HRESULT(0x80093011);
enum HRESULT OSS_FATAL_ERROR = HRESULT(0x80093012);
enum HRESULT OSS_ACCESS_SERIALIZATION_ERROR = HRESULT(0x80093013);

enum : HRESULT
{
    OSS_NULL_TBL = HRESULT(0x80093014),
    OSS_NULL_FCN = HRESULT(0x80093015),
}

enum HRESULT OSS_BAD_ENCRULES = HRESULT(0x80093016);
enum HRESULT OSS_UNAVAIL_ENCRULES = HRESULT(0x80093017);
enum HRESULT OSS_CANT_OPEN_TRACE_WINDOW = HRESULT(0x80093018);
enum HRESULT OSS_UNIMPLEMENTED = HRESULT(0x80093019);
enum HRESULT OSS_OID_DLL_NOT_LINKED = HRESULT(0x8009301a);
enum HRESULT OSS_CANT_OPEN_TRACE_FILE = HRESULT(0x8009301b);
enum HRESULT OSS_TRACE_FILE_ALREADY_OPEN = HRESULT(0x8009301c);
enum HRESULT OSS_TABLE_MISMATCH = HRESULT(0x8009301d);
enum HRESULT OSS_TYPE_NOT_SUPPORTED = HRESULT(0x8009301e);
enum HRESULT OSS_REAL_DLL_NOT_LINKED = HRESULT(0x8009301f);
enum HRESULT OSS_REAL_CODE_NOT_LINKED = HRESULT(0x80093020);
enum HRESULT OSS_OUT_OF_RANGE = HRESULT(0x80093021);
enum HRESULT OSS_COPIER_DLL_NOT_LINKED = HRESULT(0x80093022);
enum HRESULT OSS_CONSTRAINT_DLL_NOT_LINKED = HRESULT(0x80093023);

enum : HRESULT
{
    OSS_COMPARATOR_DLL_NOT_LINKED  = HRESULT(0x80093024),
    OSS_COMPARATOR_CODE_NOT_LINKED = HRESULT(0x80093025),
}

enum HRESULT OSS_MEM_MGR_DLL_NOT_LINKED = HRESULT(0x80093026);
enum HRESULT OSS_PDV_DLL_NOT_LINKED = HRESULT(0x80093027);
enum HRESULT OSS_PDV_CODE_NOT_LINKED = HRESULT(0x80093028);
enum HRESULT OSS_API_DLL_NOT_LINKED = HRESULT(0x80093029);
enum HRESULT OSS_BERDER_DLL_NOT_LINKED = HRESULT(0x8009302a);
enum HRESULT OSS_PER_DLL_NOT_LINKED = HRESULT(0x8009302b);
enum HRESULT OSS_OPEN_TYPE_ERROR = HRESULT(0x8009302c);
enum HRESULT OSS_MUTEX_NOT_CREATED = HRESULT(0x8009302d);
enum HRESULT OSS_CANT_CLOSE_TRACE_FILE = HRESULT(0x8009302e);

enum : HRESULT
{
    CRYPT_E_ASN1_ERROR      = HRESULT(0x80093100),
    CRYPT_E_ASN1_INTERNAL   = HRESULT(0x80093101),
    CRYPT_E_ASN1_EOD        = HRESULT(0x80093102),
    CRYPT_E_ASN1_CORRUPT    = HRESULT(0x80093103),
    CRYPT_E_ASN1_LARGE      = HRESULT(0x80093104),
    CRYPT_E_ASN1_CONSTRAINT = HRESULT(0x80093105),
    CRYPT_E_ASN1_MEMORY     = HRESULT(0x80093106),
    CRYPT_E_ASN1_OVERFLOW   = HRESULT(0x80093107),
    CRYPT_E_ASN1_BADPDU     = HRESULT(0x80093108),
    CRYPT_E_ASN1_BADARGS    = HRESULT(0x80093109),
    CRYPT_E_ASN1_BADREAL    = HRESULT(0x8009310a),
    CRYPT_E_ASN1_BADTAG     = HRESULT(0x8009310b),
    CRYPT_E_ASN1_CHOICE     = HRESULT(0x8009310c),
    CRYPT_E_ASN1_RULE       = HRESULT(0x8009310d),
    CRYPT_E_ASN1_UTF8       = HRESULT(0x8009310e),
    CRYPT_E_ASN1_PDU_TYPE   = HRESULT(0x80093133),
    CRYPT_E_ASN1_NYI        = HRESULT(0x80093134),
    CRYPT_E_ASN1_EXTENDED   = HRESULT(0x80093201),
    CRYPT_E_ASN1_NOEOD      = HRESULT(0x80093202),
}

enum HRESULT CERTSRV_E_BAD_REQUESTSUBJECT = HRESULT(0x80094001);

enum : HRESULT
{
    CERTSRV_E_NO_REQUEST        = HRESULT(0x80094002),
    CERTSRV_E_BAD_REQUESTSTATUS = HRESULT(0x80094003),
}

enum : HRESULT
{
    CERTSRV_E_PROPERTY_EMPTY         = HRESULT(0x80094004),
    CERTSRV_E_INVALID_CA_CERTIFICATE = HRESULT(0x80094005),
}

enum HRESULT CERTSRV_E_SERVER_SUSPENDED = HRESULT(0x80094006);
enum HRESULT CERTSRV_E_ENCODING_LENGTH = HRESULT(0x80094007);

enum : HRESULT
{
    CERTSRV_E_ROLECONFLICT      = HRESULT(0x80094008),
    CERTSRV_E_RESTRICTEDOFFICER = HRESULT(0x80094009),
}

enum HRESULT CERTSRV_E_KEY_ARCHIVAL_NOT_CONFIGURED = HRESULT(0x8009400a);

enum : HRESULT
{
    CERTSRV_E_NO_VALID_KRA             = HRESULT(0x8009400b),
    CERTSRV_E_BAD_REQUEST_KEY_ARCHIVAL = HRESULT(0x8009400c),
}

enum HRESULT CERTSRV_E_NO_CAADMIN_DEFINED = HRESULT(0x8009400d);
enum HRESULT CERTSRV_E_BAD_RENEWAL_CERT_ATTRIBUTE = HRESULT(0x8009400e);

enum : HRESULT
{
    CERTSRV_E_NO_DB_SESSIONS  = HRESULT(0x8009400f),
    CERTSRV_E_ALIGNMENT_FAULT = HRESULT(0x80094010),
}

enum : HRESULT
{
    CERTSRV_E_ENROLL_DENIED   = HRESULT(0x80094011),
    CERTSRV_E_TEMPLATE_DENIED = HRESULT(0x80094012),
}

enum HRESULT CERTSRV_E_DOWNLEVEL_DC_SSL_OR_UPGRADE = HRESULT(0x80094013);
enum HRESULT CERTSRV_E_ADMIN_DENIED_REQUEST = HRESULT(0x80094014);
enum HRESULT CERTSRV_E_NO_POLICY_SERVER = HRESULT(0x80094015);
enum HRESULT CERTSRV_E_WEAK_SIGNATURE_OR_KEY = HRESULT(0x80094016);
enum HRESULT CERTSRV_E_KEY_ATTESTATION_NOT_SUPPORTED = HRESULT(0x80094017);
enum HRESULT CERTSRV_E_ENCRYPTION_CERT_REQUIRED = HRESULT(0x80094018);
enum HRESULT CERTSRV_E_UNSUPPORTED_CERT_TYPE = HRESULT(0x80094800);

enum : HRESULT
{
    CERTSRV_E_NO_CERT_TYPE      = HRESULT(0x80094801),
    CERTSRV_E_TEMPLATE_CONFLICT = HRESULT(0x80094802),
}

enum HRESULT CERTSRV_E_SUBJECT_ALT_NAME_REQUIRED = HRESULT(0x80094803);
enum HRESULT CERTSRV_E_ARCHIVED_KEY_REQUIRED = HRESULT(0x80094804);

enum : HRESULT
{
    CERTSRV_E_SMIME_REQUIRED       = HRESULT(0x80094805),
    CERTSRV_E_BAD_RENEWAL_SUBJECT  = HRESULT(0x80094806),
    CERTSRV_E_BAD_TEMPLATE_VERSION = HRESULT(0x80094807),
}

enum HRESULT CERTSRV_E_TEMPLATE_POLICY_REQUIRED = HRESULT(0x80094808);

enum : HRESULT
{
    CERTSRV_E_SIGNATURE_POLICY_REQUIRED = HRESULT(0x80094809),
    CERTSRV_E_SIGNATURE_COUNT           = HRESULT(0x8009480a),
    CERTSRV_E_SIGNATURE_REJECTED        = HRESULT(0x8009480b),
}

enum HRESULT CERTSRV_E_ISSUANCE_POLICY_REQUIRED = HRESULT(0x8009480c);

enum : HRESULT
{
    CERTSRV_E_SUBJECT_UPN_REQUIRED            = HRESULT(0x8009480d),
    CERTSRV_E_SUBJECT_DIRECTORY_GUID_REQUIRED = HRESULT(0x8009480e),
    CERTSRV_E_SUBJECT_DNS_REQUIRED            = HRESULT(0x8009480f),
}

enum HRESULT CERTSRV_E_ARCHIVED_KEY_UNEXPECTED = HRESULT(0x80094810);

enum : HRESULT
{
    CERTSRV_E_KEY_LENGTH             = HRESULT(0x80094811),
    CERTSRV_E_SUBJECT_EMAIL_REQUIRED = HRESULT(0x80094812),
}

enum HRESULT CERTSRV_E_UNKNOWN_CERT_TYPE = HRESULT(0x80094813);
enum HRESULT CERTSRV_E_CERT_TYPE_OVERLAP = HRESULT(0x80094814);
enum HRESULT CERTSRV_E_TOO_MANY_SIGNATURES = HRESULT(0x80094815);
enum HRESULT CERTSRV_E_RENEWAL_BAD_PUBLIC_KEY = HRESULT(0x80094816);

enum : HRESULT
{
    CERTSRV_E_INVALID_EK          = HRESULT(0x80094817),
    CERTSRV_E_INVALID_IDBINDING   = HRESULT(0x80094818),
    CERTSRV_E_INVALID_ATTESTATION = HRESULT(0x80094819),
}

enum HRESULT CERTSRV_E_KEY_ATTESTATION = HRESULT(0x8009481a);
enum HRESULT CERTSRV_E_CORRUPT_KEY_ATTESTATION = HRESULT(0x8009481b);
enum HRESULT CERTSRV_E_EXPIRED_CHALLENGE = HRESULT(0x8009481c);

enum : HRESULT
{
    CERTSRV_E_INVALID_RESPONSE  = HRESULT(0x8009481d),
    CERTSRV_E_INVALID_REQUESTID = HRESULT(0x8009481e),
}

enum HRESULT CERTSRV_E_REQUEST_PRECERTIFICATE_MISMATCH = HRESULT(0x8009481f);
enum HRESULT CERTSRV_E_PENDING_CLIENT_RESPONSE = HRESULT(0x80094820);
enum HRESULT CERTSRV_E_SEC_EXT_DIRECTORY_SID_REQUIRED = HRESULT(0x80094821);
enum HRESULT XENROLL_E_KEY_NOT_EXPORTABLE = HRESULT(0x80095000);
enum HRESULT XENROLL_E_CANNOT_ADD_ROOT_CERT = HRESULT(0x80095001);

enum : HRESULT
{
    XENROLL_E_RESPONSE_KA_HASH_NOT_FOUND  = HRESULT(0x80095002),
    XENROLL_E_RESPONSE_UNEXPECTED_KA_HASH = HRESULT(0x80095003),
    XENROLL_E_RESPONSE_KA_HASH_MISMATCH   = HRESULT(0x80095004),
}

enum HRESULT XENROLL_E_KEYSPEC_SMIME_MISMATCH = HRESULT(0x80095005);
enum HRESULT TRUST_E_SYSTEM_ERROR = HRESULT(0x80096001);
enum HRESULT TRUST_E_NO_SIGNER_CERT = HRESULT(0x80096002);

enum : HRESULT
{
    TRUST_E_COUNTER_SIGNER = HRESULT(0x80096003),
    TRUST_E_CERT_SIGNATURE = HRESULT(0x80096004),
}

enum : HRESULT
{
    TRUST_E_TIME_STAMP          = HRESULT(0x80096005),
    TRUST_E_BAD_DIGEST          = HRESULT(0x80096010),
    TRUST_E_MALFORMED_SIGNATURE = HRESULT(0x80096011),
}

enum HRESULT TRUST_E_BASIC_CONSTRAINTS = HRESULT(0x80096019);
enum HRESULT TRUST_E_FINANCIAL_CRITERIA = HRESULT(0x8009601e);

enum : HRESULT
{
    MSSIPOTF_E_OUTOFMEMRANGE             = HRESULT(0x80097001),
    MSSIPOTF_E_CANTGETOBJECT             = HRESULT(0x80097002),
    MSSIPOTF_E_NOHEADTABLE               = HRESULT(0x80097003),
    MSSIPOTF_E_BAD_MAGICNUMBER           = HRESULT(0x80097004),
    MSSIPOTF_E_BAD_OFFSET_TABLE          = HRESULT(0x80097005),
    MSSIPOTF_E_TABLE_TAGORDER            = HRESULT(0x80097006),
    MSSIPOTF_E_TABLE_LONGWORD            = HRESULT(0x80097007),
    MSSIPOTF_E_BAD_FIRST_TABLE_PLACEMENT = HRESULT(0x80097008),
}

enum : HRESULT
{
    MSSIPOTF_E_TABLES_OVERLAP     = HRESULT(0x80097009),
    MSSIPOTF_E_TABLE_PADBYTES     = HRESULT(0x8009700a),
    MSSIPOTF_E_FILETOOSMALL       = HRESULT(0x8009700b),
    MSSIPOTF_E_TABLE_CHECKSUM     = HRESULT(0x8009700c),
    MSSIPOTF_E_FILE_CHECKSUM      = HRESULT(0x8009700d),
    MSSIPOTF_E_FAILED_POLICY      = HRESULT(0x80097010),
    MSSIPOTF_E_FAILED_HINTS_CHECK = HRESULT(0x80097011),
}

enum : HRESULT
{
    MSSIPOTF_E_NOT_OPENTYPE   = HRESULT(0x80097012),
    MSSIPOTF_E_FILE           = HRESULT(0x80097013),
    MSSIPOTF_E_CRYPT          = HRESULT(0x80097014),
    MSSIPOTF_E_BADVERSION     = HRESULT(0x80097015),
    MSSIPOTF_E_DSIG_STRUCTURE = HRESULT(0x80097016),
    MSSIPOTF_E_PCONST_CHECK   = HRESULT(0x80097017),
    MSSIPOTF_E_STRUCTURE      = HRESULT(0x80097018),
}

enum HRESULT ERROR_CRED_REQUIRES_CONFIRMATION = HRESULT(0x80097019);
enum uint NTE_OP_OK = 0x00000000U;
enum HRESULT TRUST_E_PROVIDER_UNKNOWN = HRESULT(0x800b0001);
enum HRESULT TRUST_E_ACTION_UNKNOWN = HRESULT(0x800b0002);

enum : HRESULT
{
    TRUST_E_SUBJECT_FORM_UNKNOWN = HRESULT(0x800b0003),
    TRUST_E_SUBJECT_NOT_TRUSTED  = HRESULT(0x800b0004),
}

enum : HRESULT
{
    DIGSIG_E_ENCODE        = HRESULT(0x800b0005),
    DIGSIG_E_DECODE        = HRESULT(0x800b0006),
    DIGSIG_E_EXTENSIBILITY = HRESULT(0x800b0007),
    DIGSIG_E_CRYPTO        = HRESULT(0x800b0008),
}

enum : HRESULT
{
    PERSIST_E_SIZEDEFINITE   = HRESULT(0x800b0009),
    PERSIST_E_SIZEINDEFINITE = HRESULT(0x800b000a),
    PERSIST_E_NOTSELFSIZING  = HRESULT(0x800b000b),
}

enum HRESULT TRUST_E_NOSIGNATURE = HRESULT(0x800b0100);

enum : HRESULT
{
    CERT_E_EXPIRED               = HRESULT(0x800b0101),
    CERT_E_VALIDITYPERIODNESTING = HRESULT(0x800b0102),
}

enum : HRESULT
{
    CERT_E_ROLE         = HRESULT(0x800b0103),
    CERT_E_PATHLENCONST = HRESULT(0x800b0104),
}

enum : HRESULT
{
    CERT_E_CRITICAL       = HRESULT(0x800b0105),
    CERT_E_PURPOSE        = HRESULT(0x800b0106),
    CERT_E_ISSUERCHAINING = HRESULT(0x800b0107),
}

enum : HRESULT
{
    CERT_E_MALFORMED     = HRESULT(0x800b0108),
    CERT_E_UNTRUSTEDROOT = HRESULT(0x800b0109),
}

enum HRESULT CERT_E_CHAINING = HRESULT(0x800b010a);
enum HRESULT TRUST_E_FAIL = HRESULT(0x800b010b);

enum : HRESULT
{
    CERT_E_REVOKED           = HRESULT(0x800b010c),
    CERT_E_UNTRUSTEDTESTROOT = HRESULT(0x800b010d),
}

enum HRESULT CERT_E_REVOCATION_FAILURE = HRESULT(0x800b010e);
enum HRESULT CERT_E_CN_NO_MATCH = HRESULT(0x800b010f);
enum HRESULT CERT_E_WRONG_USAGE = HRESULT(0x800b0110);
enum HRESULT TRUST_E_EXPLICIT_DISTRUST = HRESULT(0x800b0111);
enum HRESULT CERT_E_UNTRUSTEDCA = HRESULT(0x800b0112);

enum : HRESULT
{
    CERT_E_INVALID_POLICY = HRESULT(0x800b0113),
    CERT_E_INVALID_NAME   = HRESULT(0x800b0114),
}

enum HRESULT SPAPI_E_EXPECTED_SECTION_NAME = HRESULT(0x800f0000);
enum HRESULT SPAPI_E_BAD_SECTION_NAME_LINE = HRESULT(0x800f0001);
enum HRESULT SPAPI_E_SECTION_NAME_TOO_LONG = HRESULT(0x800f0002);
enum HRESULT SPAPI_E_GENERAL_SYNTAX = HRESULT(0x800f0003);
enum HRESULT SPAPI_E_WRONG_INF_STYLE = HRESULT(0x800f0100);
enum HRESULT SPAPI_E_SECTION_NOT_FOUND = HRESULT(0x800f0101);
enum HRESULT SPAPI_E_LINE_NOT_FOUND = HRESULT(0x800f0102);

enum : HRESULT
{
    SPAPI_E_NO_BACKUP           = HRESULT(0x800f0103),
    SPAPI_E_NO_ASSOCIATED_CLASS = HRESULT(0x800f0200),
}

enum HRESULT SPAPI_E_CLASS_MISMATCH = HRESULT(0x800f0201);
enum HRESULT SPAPI_E_DUPLICATE_FOUND = HRESULT(0x800f0202);
enum HRESULT SPAPI_E_NO_DRIVER_SELECTED = HRESULT(0x800f0203);
enum HRESULT SPAPI_E_KEY_DOES_NOT_EXIST = HRESULT(0x800f0204);

enum : HRESULT
{
    SPAPI_E_INVALID_DEVINST_NAME = HRESULT(0x800f0205),
    SPAPI_E_INVALID_CLASS        = HRESULT(0x800f0206),
}

enum : HRESULT
{
    SPAPI_E_DEVINST_ALREADY_EXISTS = HRESULT(0x800f0207),
    SPAPI_E_DEVINFO_NOT_REGISTERED = HRESULT(0x800f0208),
}

enum HRESULT SPAPI_E_INVALID_REG_PROPERTY = HRESULT(0x800f0209);

enum : HRESULT
{
    SPAPI_E_NO_INF          = HRESULT(0x800f020a),
    SPAPI_E_NO_SUCH_DEVINST = HRESULT(0x800f020b),
}

enum HRESULT SPAPI_E_CANT_LOAD_CLASS_ICON = HRESULT(0x800f020c);
enum HRESULT SPAPI_E_INVALID_CLASS_INSTALLER = HRESULT(0x800f020d);

enum : HRESULT
{
    SPAPI_E_DI_DO_DEFAULT = HRESULT(0x800f020e),
    SPAPI_E_DI_NOFILECOPY = HRESULT(0x800f020f),
}

enum HRESULT SPAPI_E_INVALID_HWPROFILE = HRESULT(0x800f0210);
enum HRESULT SPAPI_E_NO_DEVICE_SELECTED = HRESULT(0x800f0211);

enum : HRESULT
{
    SPAPI_E_DEVINFO_LIST_LOCKED = HRESULT(0x800f0212),
    SPAPI_E_DEVINFO_DATA_LOCKED = HRESULT(0x800f0213),
}

enum : HRESULT
{
    SPAPI_E_DI_BAD_PATH            = HRESULT(0x800f0214),
    SPAPI_E_NO_CLASSINSTALL_PARAMS = HRESULT(0x800f0215),
}

enum HRESULT SPAPI_E_FILEQUEUE_LOCKED = HRESULT(0x800f0216);
enum HRESULT SPAPI_E_BAD_SERVICE_INSTALLSECT = HRESULT(0x800f0217);
enum HRESULT SPAPI_E_NO_CLASS_DRIVER_LIST = HRESULT(0x800f0218);
enum HRESULT SPAPI_E_NO_ASSOCIATED_SERVICE = HRESULT(0x800f0219);
enum HRESULT SPAPI_E_NO_DEFAULT_DEVICE_INTERFACE = HRESULT(0x800f021a);

enum : HRESULT
{
    SPAPI_E_DEVICE_INTERFACE_ACTIVE  = HRESULT(0x800f021b),
    SPAPI_E_DEVICE_INTERFACE_REMOVED = HRESULT(0x800f021c),
}

enum HRESULT SPAPI_E_BAD_INTERFACE_INSTALLSECT = HRESULT(0x800f021d);
enum HRESULT SPAPI_E_NO_SUCH_INTERFACE_CLASS = HRESULT(0x800f021e);

enum : HRESULT
{
    SPAPI_E_INVALID_REFERENCE_STRING = HRESULT(0x800f021f),
    SPAPI_E_INVALID_MACHINENAME      = HRESULT(0x800f0220),
}

enum HRESULT SPAPI_E_REMOTE_COMM_FAILURE = HRESULT(0x800f0221);
enum HRESULT SPAPI_E_MACHINE_UNAVAILABLE = HRESULT(0x800f0222);
enum HRESULT SPAPI_E_NO_CONFIGMGR_SERVICES = HRESULT(0x800f0223);
enum HRESULT SPAPI_E_INVALID_PROPPAGE_PROVIDER = HRESULT(0x800f0224);
enum HRESULT SPAPI_E_NO_SUCH_DEVICE_INTERFACE = HRESULT(0x800f0225);
enum HRESULT SPAPI_E_DI_POSTPROCESSING_REQUIRED = HRESULT(0x800f0226);
enum HRESULT SPAPI_E_INVALID_COINSTALLER = HRESULT(0x800f0227);

enum : HRESULT
{
    SPAPI_E_NO_COMPAT_DRIVERS = HRESULT(0x800f0228),
    SPAPI_E_NO_DEVICE_ICON    = HRESULT(0x800f0229),
}

enum HRESULT SPAPI_E_INVALID_INF_LOGCONFIG = HRESULT(0x800f022a);
enum HRESULT SPAPI_E_DI_DONT_INSTALL = HRESULT(0x800f022b);
enum HRESULT SPAPI_E_INVALID_FILTER_DRIVER = HRESULT(0x800f022c);

enum : HRESULT
{
    SPAPI_E_NON_WINDOWS_NT_DRIVER = HRESULT(0x800f022d),
    SPAPI_E_NON_WINDOWS_DRIVER    = HRESULT(0x800f022e),
}

enum HRESULT SPAPI_E_NO_CATALOG_FOR_OEM_INF = HRESULT(0x800f022f);
enum HRESULT SPAPI_E_DEVINSTALL_QUEUE_NONNATIVE = HRESULT(0x800f0230);
enum HRESULT SPAPI_E_NOT_DISABLEABLE = HRESULT(0x800f0231);
enum HRESULT SPAPI_E_CANT_REMOVE_DEVINST = HRESULT(0x800f0232);
enum HRESULT SPAPI_E_INVALID_TARGET = HRESULT(0x800f0233);
enum HRESULT SPAPI_E_DRIVER_NONNATIVE = HRESULT(0x800f0234);

enum : HRESULT
{
    SPAPI_E_IN_WOW64                 = HRESULT(0x800f0235),
    SPAPI_E_SET_SYSTEM_RESTORE_POINT = HRESULT(0x800f0236),
}

enum HRESULT SPAPI_E_INCORRECTLY_COPIED_INF = HRESULT(0x800f0237);
enum HRESULT SPAPI_E_SCE_DISABLED = HRESULT(0x800f0238);
enum HRESULT SPAPI_E_UNKNOWN_EXCEPTION = HRESULT(0x800f0239);
enum HRESULT SPAPI_E_PNP_REGISTRY_ERROR = HRESULT(0x800f023a);
enum HRESULT SPAPI_E_REMOTE_REQUEST_UNSUPPORTED = HRESULT(0x800f023b);
enum HRESULT SPAPI_E_NOT_AN_INSTALLED_OEM_INF = HRESULT(0x800f023c);
enum HRESULT SPAPI_E_INF_IN_USE_BY_DEVICES = HRESULT(0x800f023d);
enum HRESULT SPAPI_E_DI_FUNCTION_OBSOLETE = HRESULT(0x800f023e);
enum HRESULT SPAPI_E_NO_AUTHENTICODE_CATALOG = HRESULT(0x800f023f);

enum : HRESULT
{
    SPAPI_E_AUTHENTICODE_DISALLOWED            = HRESULT(0x800f0240),
    SPAPI_E_AUTHENTICODE_TRUSTED_PUBLISHER     = HRESULT(0x800f0241),
    SPAPI_E_AUTHENTICODE_TRUST_NOT_ESTABLISHED = HRESULT(0x800f0242),
    SPAPI_E_AUTHENTICODE_PUBLISHER_NOT_TRUSTED = HRESULT(0x800f0243),
}

enum HRESULT SPAPI_E_SIGNATURE_OSATTRIBUTE_MISMATCH = HRESULT(0x800f0244);
enum HRESULT SPAPI_E_ONLY_VALIDATE_VIA_AUTHENTICODE = HRESULT(0x800f0245);
enum HRESULT SPAPI_E_DEVICE_INSTALLER_NOT_READY = HRESULT(0x800f0246);
enum HRESULT SPAPI_E_DRIVER_STORE_ADD_FAILED = HRESULT(0x800f0247);
enum HRESULT SPAPI_E_DEVICE_INSTALL_BLOCKED = HRESULT(0x800f0248);
enum HRESULT SPAPI_E_DRIVER_INSTALL_BLOCKED = HRESULT(0x800f0249);
enum HRESULT SPAPI_E_WRONG_INF_TYPE = HRESULT(0x800f024a);
enum HRESULT SPAPI_E_FILE_HASH_NOT_IN_CATALOG = HRESULT(0x800f024b);
enum HRESULT SPAPI_E_DRIVER_STORE_DELETE_FAILED = HRESULT(0x800f024c);
enum HRESULT SPAPI_E_UNRECOVERABLE_STACK_OVERFLOW = HRESULT(0x800f0300);
enum HRESULT SPAPI_E_ERROR_NOT_INSTALLED = HRESULT(0x800f1000);
enum HRESULT SCARD_F_INTERNAL_ERROR = HRESULT(0x80100001);

enum : HRESULT
{
    SCARD_E_CANCELLED         = HRESULT(0x80100002),
    SCARD_E_INVALID_HANDLE    = HRESULT(0x80100003),
    SCARD_E_INVALID_PARAMETER = HRESULT(0x80100004),
    SCARD_E_INVALID_TARGET    = HRESULT(0x80100005),
}

enum HRESULT SCARD_E_NO_MEMORY = HRESULT(0x80100006);
enum HRESULT SCARD_F_WAITED_TOO_LONG = HRESULT(0x80100007);
enum HRESULT SCARD_E_INSUFFICIENT_BUFFER = HRESULT(0x80100008);
enum HRESULT SCARD_E_UNKNOWN_READER = HRESULT(0x80100009);

enum : HRESULT
{
    SCARD_E_TIMEOUT           = HRESULT(0x8010000a),
    SCARD_E_SHARING_VIOLATION = HRESULT(0x8010000b),
}

enum HRESULT SCARD_E_NO_SMARTCARD = HRESULT(0x8010000c);
enum HRESULT SCARD_E_UNKNOWN_CARD = HRESULT(0x8010000d);
enum HRESULT SCARD_E_CANT_DISPOSE = HRESULT(0x8010000e);
enum HRESULT SCARD_E_PROTO_MISMATCH = HRESULT(0x8010000f);

enum : HRESULT
{
    SCARD_E_NOT_READY     = HRESULT(0x80100010),
    SCARD_E_INVALID_VALUE = HRESULT(0x80100011),
}

enum HRESULT SCARD_E_SYSTEM_CANCELLED = HRESULT(0x80100012);

enum : HRESULT
{
    SCARD_F_COMM_ERROR    = HRESULT(0x80100013),
    SCARD_F_UNKNOWN_ERROR = HRESULT(0x80100014),
}

enum : HRESULT
{
    SCARD_E_INVALID_ATR    = HRESULT(0x80100015),
    SCARD_E_NOT_TRANSACTED = HRESULT(0x80100016),
}

enum HRESULT SCARD_E_READER_UNAVAILABLE = HRESULT(0x80100017);
enum HRESULT SCARD_P_SHUTDOWN = HRESULT(0x80100018);
enum HRESULT SCARD_E_PCI_TOO_SMALL = HRESULT(0x80100019);
enum HRESULT SCARD_E_READER_UNSUPPORTED = HRESULT(0x8010001a);
enum HRESULT SCARD_E_DUPLICATE_READER = HRESULT(0x8010001b);
enum HRESULT SCARD_E_CARD_UNSUPPORTED = HRESULT(0x8010001c);

enum : HRESULT
{
    SCARD_E_NO_SERVICE      = HRESULT(0x8010001d),
    SCARD_E_SERVICE_STOPPED = HRESULT(0x8010001e),
}

enum : HRESULT
{
    SCARD_E_UNEXPECTED       = HRESULT(0x8010001f),
    SCARD_E_ICC_INSTALLATION = HRESULT(0x80100020),
    SCARD_E_ICC_CREATEORDER  = HRESULT(0x80100021),
}

enum HRESULT SCARD_E_UNSUPPORTED_FEATURE = HRESULT(0x80100022);
enum HRESULT SCARD_E_DIR_NOT_FOUND = HRESULT(0x80100023);
enum HRESULT SCARD_E_FILE_NOT_FOUND = HRESULT(0x80100024);

enum : HRESULT
{
    SCARD_E_NO_DIR         = HRESULT(0x80100025),
    SCARD_E_NO_FILE        = HRESULT(0x80100026),
    SCARD_E_NO_ACCESS      = HRESULT(0x80100027),
    SCARD_E_WRITE_TOO_MANY = HRESULT(0x80100028),
}

enum : HRESULT
{
    SCARD_E_BAD_SEEK        = HRESULT(0x80100029),
    SCARD_E_INVALID_CHV     = HRESULT(0x8010002a),
    SCARD_E_UNKNOWN_RES_MNG = HRESULT(0x8010002b),
}

enum HRESULT SCARD_E_NO_SUCH_CERTIFICATE = HRESULT(0x8010002c);
enum HRESULT SCARD_E_CERTIFICATE_UNAVAILABLE = HRESULT(0x8010002d);
enum HRESULT SCARD_E_NO_READERS_AVAILABLE = HRESULT(0x8010002e);
enum HRESULT SCARD_E_COMM_DATA_LOST = HRESULT(0x8010002f);
enum HRESULT SCARD_E_NO_KEY_CONTAINER = HRESULT(0x80100030);
enum HRESULT SCARD_E_SERVER_TOO_BUSY = HRESULT(0x80100031);
enum HRESULT SCARD_E_PIN_CACHE_EXPIRED = HRESULT(0x80100032);
enum HRESULT SCARD_E_NO_PIN_CACHE = HRESULT(0x80100033);
enum HRESULT SCARD_E_READ_ONLY_CARD = HRESULT(0x80100034);

enum : HRESULT
{
    SCARD_W_UNSUPPORTED_CARD  = HRESULT(0x80100065),
    SCARD_W_UNRESPONSIVE_CARD = HRESULT(0x80100066),
}

enum HRESULT SCARD_W_UNPOWERED_CARD = HRESULT(0x80100067);

enum : HRESULT
{
    SCARD_W_RESET_CARD   = HRESULT(0x80100068),
    SCARD_W_REMOVED_CARD = HRESULT(0x80100069),
}

enum HRESULT SCARD_W_SECURITY_VIOLATION = HRESULT(0x8010006a);

enum : HRESULT
{
    SCARD_W_WRONG_CHV         = HRESULT(0x8010006b),
    SCARD_W_CHV_BLOCKED       = HRESULT(0x8010006c),
    SCARD_W_EOF               = HRESULT(0x8010006d),
    SCARD_W_CANCELLED_BY_USER = HRESULT(0x8010006e),
}

enum HRESULT SCARD_W_CARD_NOT_AUTHENTICATED = HRESULT(0x8010006f);

enum : HRESULT
{
    SCARD_W_CACHE_ITEM_NOT_FOUND = HRESULT(0x80100070),
    SCARD_W_CACHE_ITEM_STALE     = HRESULT(0x80100071),
    SCARD_W_CACHE_ITEM_TOO_BIG   = HRESULT(0x80100072),
}

enum : HRESULT
{
    COMADMIN_E_OBJECTERRORS       = HRESULT(0x80110401),
    COMADMIN_E_OBJECTINVALID      = HRESULT(0x80110402),
    COMADMIN_E_KEYMISSING         = HRESULT(0x80110403),
    COMADMIN_E_ALREADYINSTALLED   = HRESULT(0x80110404),
    COMADMIN_E_APP_FILE_WRITEFAIL = HRESULT(0x80110407),
    COMADMIN_E_APP_FILE_READFAIL  = HRESULT(0x80110408),
    COMADMIN_E_APP_FILE_VERSION   = HRESULT(0x80110409),
    COMADMIN_E_BADPATH            = HRESULT(0x8011040a),
    COMADMIN_E_APPLICATIONEXISTS  = HRESULT(0x8011040b),
}

enum : HRESULT
{
    COMADMIN_E_ROLEEXISTS        = HRESULT(0x8011040c),
    COMADMIN_E_CANTCOPYFILE      = HRESULT(0x8011040d),
    COMADMIN_E_NOUSER            = HRESULT(0x8011040f),
    COMADMIN_E_INVALIDUSERIDS    = HRESULT(0x80110410),
    COMADMIN_E_NOREGISTRYCLSID   = HRESULT(0x80110411),
    COMADMIN_E_BADREGISTRYPROGID = HRESULT(0x80110412),
}

enum HRESULT COMADMIN_E_AUTHENTICATIONLEVEL = HRESULT(0x80110413);
enum HRESULT COMADMIN_E_USERPASSWDNOTVALID = HRESULT(0x80110414);
enum HRESULT COMADMIN_E_CLSIDORIIDMISMATCH = HRESULT(0x80110418);

enum : HRESULT
{
    COMADMIN_E_REMOTEINTERFACE   = HRESULT(0x80110419),
    COMADMIN_E_DLLREGISTERSERVER = HRESULT(0x8011041a),
}

enum : HRESULT
{
    COMADMIN_E_NOSERVERSHARE           = HRESULT(0x8011041b),
    COMADMIN_E_DLLLOADFAILED           = HRESULT(0x8011041d),
    COMADMIN_E_BADREGISTRYLIBID        = HRESULT(0x8011041e),
    COMADMIN_E_APPDIRNOTFOUND          = HRESULT(0x8011041f),
    COMADMIN_E_REGISTRARFAILED         = HRESULT(0x80110423),
    COMADMIN_E_COMPFILE_DOESNOTEXIST   = HRESULT(0x80110424),
    COMADMIN_E_COMPFILE_LOADDLLFAIL    = HRESULT(0x80110425),
    COMADMIN_E_COMPFILE_GETCLASSOBJ    = HRESULT(0x80110426),
    COMADMIN_E_COMPFILE_CLASSNOTAVAIL  = HRESULT(0x80110427),
    COMADMIN_E_COMPFILE_BADTLB         = HRESULT(0x80110428),
    COMADMIN_E_COMPFILE_NOTINSTALLABLE = HRESULT(0x80110429),
}

enum : HRESULT
{
    COMADMIN_E_NOTCHANGEABLE      = HRESULT(0x8011042a),
    COMADMIN_E_NOTDELETEABLE      = HRESULT(0x8011042b),
    COMADMIN_E_SESSION            = HRESULT(0x8011042c),
    COMADMIN_E_COMP_MOVE_LOCKED   = HRESULT(0x8011042d),
    COMADMIN_E_COMP_MOVE_BAD_DEST = HRESULT(0x8011042e),
}

enum : HRESULT
{
    COMADMIN_E_REGISTERTLB          = HRESULT(0x80110430),
    COMADMIN_E_SYSTEMAPP            = HRESULT(0x80110433),
    COMADMIN_E_COMPFILE_NOREGISTRAR = HRESULT(0x80110434),
    COMADMIN_E_COREQCOMPINSTALLED   = HRESULT(0x80110435),
}

enum HRESULT COMADMIN_E_SERVICENOTINSTALLED = HRESULT(0x80110436);
enum HRESULT COMADMIN_E_PROPERTYSAVEFAILED = HRESULT(0x80110437);

enum : HRESULT
{
    COMADMIN_E_OBJECTEXISTS      = HRESULT(0x80110438),
    COMADMIN_E_COMPONENTEXISTS   = HRESULT(0x80110439),
    COMADMIN_E_REGFILE_CORRUPT   = HRESULT(0x8011043b),
    COMADMIN_E_PROPERTY_OVERFLOW = HRESULT(0x8011043c),
}

enum : HRESULT
{
    COMADMIN_E_NOTINREGISTRY     = HRESULT(0x8011043e),
    COMADMIN_E_OBJECTNOTPOOLABLE = HRESULT(0x8011043f),
}

enum HRESULT COMADMIN_E_APPLID_MATCHES_CLSID = HRESULT(0x80110446);
enum HRESULT COMADMIN_E_ROLE_DOES_NOT_EXIST = HRESULT(0x80110447);
enum HRESULT COMADMIN_E_START_APP_NEEDS_COMPONENTS = HRESULT(0x80110448);
enum HRESULT COMADMIN_E_REQUIRES_DIFFERENT_PLATFORM = HRESULT(0x80110449);

enum : HRESULT
{
    COMADMIN_E_CAN_NOT_EXPORT_APP_PROXY    = HRESULT(0x8011044a),
    COMADMIN_E_CAN_NOT_START_APP           = HRESULT(0x8011044b),
    COMADMIN_E_CAN_NOT_EXPORT_SYS_APP      = HRESULT(0x8011044c),
    COMADMIN_E_CANT_SUBSCRIBE_TO_COMPONENT = HRESULT(0x8011044d),
}

enum HRESULT COMADMIN_E_EVENTCLASS_CANT_BE_SUBSCRIBER = HRESULT(0x8011044e);
enum HRESULT COMADMIN_E_LIB_APP_PROXY_INCOMPATIBLE = HRESULT(0x8011044f);
enum HRESULT COMADMIN_E_BASE_PARTITION_ONLY = HRESULT(0x80110450);
enum HRESULT COMADMIN_E_START_APP_DISABLED = HRESULT(0x80110451);
enum HRESULT COMADMIN_E_CAT_DUPLICATE_PARTITION_NAME = HRESULT(0x80110457);

enum : HRESULT
{
    COMADMIN_E_CAT_INVALID_PARTITION_NAME = HRESULT(0x80110458),
    COMADMIN_E_CAT_PARTITION_IN_USE       = HRESULT(0x80110459),
}

enum HRESULT COMADMIN_E_FILE_PARTITION_DUPLICATE_FILES = HRESULT(0x8011045a);
enum HRESULT COMADMIN_E_CAT_IMPORTED_COMPONENTS_NOT_ALLOWED = HRESULT(0x8011045b);

enum : HRESULT
{
    COMADMIN_E_AMBIGUOUS_APPLICATION_NAME = HRESULT(0x8011045c),
    COMADMIN_E_AMBIGUOUS_PARTITION_NAME   = HRESULT(0x8011045d),
}

enum : HRESULT
{
    COMADMIN_E_REGDB_NOTINITIALIZED = HRESULT(0x80110472),
    COMADMIN_E_REGDB_NOTOPEN        = HRESULT(0x80110473),
    COMADMIN_E_REGDB_SYSTEMERR      = HRESULT(0x80110474),
    COMADMIN_E_REGDB_ALREADYRUNNING = HRESULT(0x80110475),
}

enum : HRESULT
{
    COMADMIN_E_MIG_VERSIONNOTSUPPORTED = HRESULT(0x80110480),
    COMADMIN_E_MIG_SCHEMANOTFOUND      = HRESULT(0x80110481),
}

enum : HRESULT
{
    COMADMIN_E_CAT_BITNESSMISMATCH            = HRESULT(0x80110482),
    COMADMIN_E_CAT_UNACCEPTABLEBITNESS        = HRESULT(0x80110483),
    COMADMIN_E_CAT_WRONGAPPBITNESS            = HRESULT(0x80110484),
    COMADMIN_E_CAT_PAUSE_RESUME_NOT_SUPPORTED = HRESULT(0x80110485),
}

enum HRESULT COMADMIN_E_CAT_SERVERFAULT = HRESULT(0x80110486);
enum HRESULT COMQC_E_APPLICATION_NOT_QUEUED = HRESULT(0x80110600);
enum HRESULT COMQC_E_NO_QUEUEABLE_INTERFACES = HRESULT(0x80110601);
enum HRESULT COMQC_E_QUEUING_SERVICE_NOT_AVAILABLE = HRESULT(0x80110602);
enum HRESULT COMQC_E_NO_IPERSISTSTREAM = HRESULT(0x80110603);

enum : HRESULT
{
    COMQC_E_BAD_MESSAGE        = HRESULT(0x80110604),
    COMQC_E_UNAUTHENTICATED    = HRESULT(0x80110605),
    COMQC_E_UNTRUSTED_ENQUEUER = HRESULT(0x80110606),
}

enum HRESULT MSDTC_E_DUPLICATE_RESOURCE = HRESULT(0x80110701);

enum : HRESULT
{
    COMADMIN_E_OBJECT_PARENT_MISSING = HRESULT(0x80110808),
    COMADMIN_E_OBJECT_DOES_NOT_EXIST = HRESULT(0x80110809),
}

enum : HRESULT
{
    COMADMIN_E_APP_NOT_RUNNING   = HRESULT(0x8011080a),
    COMADMIN_E_INVALID_PARTITION = HRESULT(0x8011080b),
}

enum HRESULT COMADMIN_E_SVCAPP_NOT_POOLABLE_OR_RECYCLABLE = HRESULT(0x8011080d);

enum : HRESULT
{
    COMADMIN_E_USER_IN_SET            = HRESULT(0x8011080e),
    COMADMIN_E_CANTRECYCLELIBRARYAPPS = HRESULT(0x8011080f),
    COMADMIN_E_CANTRECYCLESERVICEAPPS = HRESULT(0x80110811),
}

enum HRESULT COMADMIN_E_PROCESSALREADYRECYCLED = HRESULT(0x80110812);
enum HRESULT COMADMIN_E_PAUSEDPROCESSMAYNOTBERECYCLED = HRESULT(0x80110813);
enum HRESULT COMADMIN_E_CANTMAKEINPROCSERVICE = HRESULT(0x80110814);
enum HRESULT COMADMIN_E_PROGIDINUSEBYCLSID = HRESULT(0x80110815);
enum HRESULT COMADMIN_E_DEFAULT_PARTITION_NOT_IN_SET = HRESULT(0x80110816);
enum HRESULT COMADMIN_E_RECYCLEDPROCESSMAYNOTBEPAUSED = HRESULT(0x80110817);

enum : HRESULT
{
    COMADMIN_E_PARTITION_ACCESSDENIED = HRESULT(0x80110818),
    COMADMIN_E_PARTITION_MSI_ONLY     = HRESULT(0x80110819),
}

enum : HRESULT
{
    COMADMIN_E_LEGACYCOMPS_NOT_ALLOWED_IN_1_0_FORMAT         = HRESULT(0x8011081a),
    COMADMIN_E_LEGACYCOMPS_NOT_ALLOWED_IN_NONBASE_PARTITIONS = HRESULT(0x8011081b),
}

enum : HRESULT
{
    COMADMIN_E_COMP_MOVE_SOURCE  = HRESULT(0x8011081c),
    COMADMIN_E_COMP_MOVE_DEST    = HRESULT(0x8011081d),
    COMADMIN_E_COMP_MOVE_PRIVATE = HRESULT(0x8011081e),
}

enum HRESULT COMADMIN_E_BASEPARTITION_REQUIRED_IN_SET = HRESULT(0x8011081f);
enum HRESULT COMADMIN_E_CANNOT_ALIAS_EVENTCLASS = HRESULT(0x80110820);
enum HRESULT COMADMIN_E_PRIVATE_ACCESSDENIED = HRESULT(0x80110821);

enum : HRESULT
{
    COMADMIN_E_SAFERINVALID          = HRESULT(0x80110822),
    COMADMIN_E_REGISTRY_ACCESSDENIED = HRESULT(0x80110823),
}

enum HRESULT COMADMIN_E_PARTITIONS_DISABLED = HRESULT(0x80110824);
enum HRESULT MENROLL_S_ENROLLMENT_SUSPENDED = HRESULT(0x00180011);

enum : HRESULT
{
    WER_S_REPORT_DEBUG    = HRESULT(0x001b0000),
    WER_S_REPORT_UPLOADED = HRESULT(0x001b0001),
    WER_S_REPORT_QUEUED   = HRESULT(0x001b0002),
}

enum : HRESULT
{
    WER_S_DISABLED         = HRESULT(0x001b0003),
    WER_S_SUSPENDED_UPLOAD = HRESULT(0x001b0004),
}

enum : HRESULT
{
    WER_S_DISABLED_QUEUE   = HRESULT(0x001b0005),
    WER_S_DISABLED_ARCHIVE = HRESULT(0x001b0006),
}

enum HRESULT WER_S_REPORT_ASYNC = HRESULT(0x001b0007);

enum : HRESULT
{
    WER_S_IGNORE_ASSERT_INSTANCE = HRESULT(0x001b0008),
    WER_S_IGNORE_ALL_ASSERTS     = HRESULT(0x001b0009),
}

enum HRESULT WER_S_ASSERT_CONTINUE = HRESULT(0x001b000a);
enum HRESULT WER_S_THROTTLED = HRESULT(0x001b000b);
enum HRESULT WER_S_REPORT_UPLOADED_CAB = HRESULT(0x001b000c);
enum HRESULT WER_E_CRASH_FAILURE = HRESULT(0x801b8000);

enum : HRESULT
{
    WER_E_CANCELED        = HRESULT(0x801b8001),
    WER_E_NETWORK_FAILURE = HRESULT(0x801b8002),
}

enum HRESULT WER_E_NOT_INITIALIZED = HRESULT(0x801b8003);
enum HRESULT WER_E_ALREADY_REPORTING = HRESULT(0x801b8004);
enum HRESULT WER_E_DUMP_THROTTLED = HRESULT(0x801b8005);
enum HRESULT WER_E_INSUFFICIENT_CONSENT = HRESULT(0x801b8006);
enum HRESULT WER_E_TOO_HEAVY = HRESULT(0x801b8007);

enum : HRESULT
{
    ERROR_FLT_IO_COMPLETE        = HRESULT(0x001f0001),
    ERROR_FLT_NO_HANDLER_DEFINED = HRESULT(0x801f0001),
}

enum HRESULT ERROR_FLT_CONTEXT_ALREADY_DEFINED = HRESULT(0x801f0002);
enum HRESULT ERROR_FLT_INVALID_ASYNCHRONOUS_REQUEST = HRESULT(0x801f0003);
enum HRESULT ERROR_FLT_DISALLOW_FAST_IO = HRESULT(0x801f0004);
enum HRESULT ERROR_FLT_INVALID_NAME_REQUEST = HRESULT(0x801f0005);
enum HRESULT ERROR_FLT_NOT_SAFE_TO_POST_OPERATION = HRESULT(0x801f0006);
enum HRESULT ERROR_FLT_NOT_INITIALIZED = HRESULT(0x801f0007);
enum HRESULT ERROR_FLT_FILTER_NOT_READY = HRESULT(0x801f0008);
enum HRESULT ERROR_FLT_POST_OPERATION_CLEANUP = HRESULT(0x801f0009);

enum : HRESULT
{
    ERROR_FLT_INTERNAL_ERROR  = HRESULT(0x801f000a),
    ERROR_FLT_DELETING_OBJECT = HRESULT(0x801f000b),
}

enum HRESULT ERROR_FLT_MUST_BE_NONPAGED_POOL = HRESULT(0x801f000c);
enum HRESULT ERROR_FLT_DUPLICATE_ENTRY = HRESULT(0x801f000d);

enum : HRESULT
{
    ERROR_FLT_CBDQ_DISABLED               = HRESULT(0x801f000e),
    ERROR_FLT_DO_NOT_ATTACH               = HRESULT(0x801f000f),
    ERROR_FLT_DO_NOT_DETACH               = HRESULT(0x801f0010),
    ERROR_FLT_INSTANCE_ALTITUDE_COLLISION = HRESULT(0x801f0011),
    ERROR_FLT_INSTANCE_NAME_COLLISION     = HRESULT(0x801f0012),
}

enum HRESULT ERROR_FLT_FILTER_NOT_FOUND = HRESULT(0x801f0013);
enum HRESULT ERROR_FLT_VOLUME_NOT_FOUND = HRESULT(0x801f0014);
enum HRESULT ERROR_FLT_INSTANCE_NOT_FOUND = HRESULT(0x801f0015);
enum HRESULT ERROR_FLT_CONTEXT_ALLOCATION_NOT_FOUND = HRESULT(0x801f0016);
enum HRESULT ERROR_FLT_INVALID_CONTEXT_REGISTRATION = HRESULT(0x801f0017);

enum : HRESULT
{
    ERROR_FLT_NAME_CACHE_MISS  = HRESULT(0x801f0018),
    ERROR_FLT_NO_DEVICE_OBJECT = HRESULT(0x801f0019),
}

enum HRESULT ERROR_FLT_VOLUME_ALREADY_MOUNTED = HRESULT(0x801f001a);
enum HRESULT ERROR_FLT_ALREADY_ENLISTED = HRESULT(0x801f001b);
enum HRESULT ERROR_FLT_CONTEXT_ALREADY_LINKED = HRESULT(0x801f001c);
enum HRESULT ERROR_FLT_NO_WAITER_FOR_REPLY = HRESULT(0x801f0020);
enum HRESULT ERROR_FLT_REGISTRATION_BUSY = HRESULT(0x801f0023);
enum HRESULT ERROR_FLT_WCOS_NOT_SUPPORTED = HRESULT(0x801f0024);
enum HRESULT ERROR_HUNG_DISPLAY_DRIVER_THREAD = HRESULT(0x80260001);
enum HRESULT DWM_E_COMPOSITIONDISABLED = HRESULT(0x80263001);
enum HRESULT DWM_E_REMOTING_NOT_SUPPORTED = HRESULT(0x80263002);
enum HRESULT DWM_E_NO_REDIRECTION_SURFACE_AVAILABLE = HRESULT(0x80263003);
enum HRESULT DWM_E_NOT_QUEUING_PRESENTS = HRESULT(0x80263004);
enum HRESULT DWM_E_ADAPTER_NOT_FOUND = HRESULT(0x80263005);
enum HRESULT DWM_S_GDI_REDIRECTION_SURFACE = HRESULT(0x00263005);
enum HRESULT DWM_E_TEXTURE_TOO_LARGE = HRESULT(0x80263007);
enum HRESULT DWM_S_GDI_REDIRECTION_SURFACE_BLT_VIA_GDI = HRESULT(0x00263008);

enum : HRESULT
{
    ERROR_MONITOR_NO_DESCRIPTOR             = HRESULT(0x00261001),
    ERROR_MONITOR_UNKNOWN_DESCRIPTOR_FORMAT = HRESULT(0x00261002),
}

enum : HRESULT
{
    ERROR_MONITOR_INVALID_DESCRIPTOR_CHECKSUM   = HRESULT(0xc0261003),
    ERROR_MONITOR_INVALID_STANDARD_TIMING_BLOCK = HRESULT(0xc0261004),
}

enum HRESULT ERROR_MONITOR_WMI_DATABLOCK_REGISTRATION_FAILED = HRESULT(0xc0261005);

enum : HRESULT
{
    ERROR_MONITOR_INVALID_SERIAL_NUMBER_MONDSC_BLOCK = HRESULT(0xc0261006),
    ERROR_MONITOR_INVALID_USER_FRIENDLY_MONDSC_BLOCK = HRESULT(0xc0261007),
}

enum HRESULT ERROR_MONITOR_NO_MORE_DESCRIPTOR_DATA = HRESULT(0xc0261008);

enum : HRESULT
{
    ERROR_MONITOR_INVALID_DETAILED_TIMING_BLOCK = HRESULT(0xc0261009),
    ERROR_MONITOR_INVALID_MANUFACTURE_DATE      = HRESULT(0xc026100a),
}

enum HRESULT ERROR_GRAPHICS_NOT_EXCLUSIVE_MODE_OWNER = HRESULT(0xc0262000);

enum : HRESULT
{
    ERROR_GRAPHICS_INSUFFICIENT_DMA_BUFFER = HRESULT(0xc0262001),
    ERROR_GRAPHICS_INVALID_DISPLAY_ADAPTER = HRESULT(0xc0262002),
}

enum : HRESULT
{
    ERROR_GRAPHICS_ADAPTER_WAS_RESET            = HRESULT(0xc0262003),
    ERROR_GRAPHICS_INVALID_DRIVER_MODEL         = HRESULT(0xc0262004),
    ERROR_GRAPHICS_PRESENT_MODE_CHANGED         = HRESULT(0xc0262005),
    ERROR_GRAPHICS_PRESENT_OCCLUDED             = HRESULT(0xc0262006),
    ERROR_GRAPHICS_PRESENT_DENIED               = HRESULT(0xc0262007),
    ERROR_GRAPHICS_CANNOTCOLORCONVERT           = HRESULT(0xc0262008),
    ERROR_GRAPHICS_DRIVER_MISMATCH              = HRESULT(0xc0262009),
    ERROR_GRAPHICS_PARTIAL_DATA_POPULATED       = HRESULT(0x4026200a),
    ERROR_GRAPHICS_PRESENT_REDIRECTION_DISABLED = HRESULT(0xc026200b),
    ERROR_GRAPHICS_PRESENT_UNOCCLUDED           = HRESULT(0xc026200c),
    ERROR_GRAPHICS_WINDOWDC_NOT_AVAILABLE       = HRESULT(0xc026200d),
    ERROR_GRAPHICS_WINDOWLESS_PRESENT_DISABLED  = HRESULT(0xc026200e),
}

enum : HRESULT
{
    ERROR_GRAPHICS_PRESENT_INVALID_WINDOW   = HRESULT(0xc026200f),
    ERROR_GRAPHICS_PRESENT_BUFFER_NOT_BOUND = HRESULT(0xc0262010),
}

enum : HRESULT
{
    ERROR_GRAPHICS_VAIL_STATE_CHANGED                 = HRESULT(0xc0262011),
    ERROR_GRAPHICS_INDIRECT_DISPLAY_ABANDON_SWAPCHAIN = HRESULT(0xc0262012),
    ERROR_GRAPHICS_INDIRECT_DISPLAY_DEVICE_STOPPED    = HRESULT(0xc0262013),
}

enum : HRESULT
{
    ERROR_GRAPHICS_VAIL_FAILED_TO_SEND_CREATE_SUPERWETINK_MESSAGE     = HRESULT(0xc0262014),
    ERROR_GRAPHICS_VAIL_FAILED_TO_SEND_DESTROY_SUPERWETINK_MESSAGE    = HRESULT(0xc0262015),
    ERROR_GRAPHICS_VAIL_FAILED_TO_SEND_COMPOSITION_WINDOW_DPI_MESSAGE = HRESULT(0xc0262016),
}

enum HRESULT ERROR_GRAPHICS_LINK_CONFIGURATION_IN_PROGRESS = HRESULT(0xc0262017);
enum HRESULT ERROR_GRAPHICS_MPO_ALLOCATION_UNPINNED = HRESULT(0xc0262018);
enum HRESULT ERROR_GRAPHICS_SETDISPLAYMODE_REQUIRED = HRESULT(0xc0262019);

enum : HRESULT
{
    ERROR_GRAPHICS_NO_VIDEO_MEMORY                  = HRESULT(0xc0262100),
    ERROR_GRAPHICS_CANT_LOCK_MEMORY                 = HRESULT(0xc0262101),
    ERROR_GRAPHICS_ALLOCATION_BUSY                  = HRESULT(0xc0262102),
    ERROR_GRAPHICS_TOO_MANY_REFERENCES              = HRESULT(0xc0262103),
    ERROR_GRAPHICS_TRY_AGAIN_LATER                  = HRESULT(0xc0262104),
    ERROR_GRAPHICS_TRY_AGAIN_NOW                    = HRESULT(0xc0262105),
    ERROR_GRAPHICS_ALLOCATION_INVALID               = HRESULT(0xc0262106),
    ERROR_GRAPHICS_UNSWIZZLING_APERTURE_UNAVAILABLE = HRESULT(0xc0262107),
    ERROR_GRAPHICS_UNSWIZZLING_APERTURE_UNSUPPORTED = HRESULT(0xc0262108),
}

enum HRESULT ERROR_GRAPHICS_CANT_EVICT_PINNED_ALLOCATION = HRESULT(0xc0262109);
enum HRESULT ERROR_GRAPHICS_INVALID_ALLOCATION_USAGE = HRESULT(0xc0262110);
enum HRESULT ERROR_GRAPHICS_CANT_RENDER_LOCKED_ALLOCATION = HRESULT(0xc0262111);

enum : HRESULT
{
    ERROR_GRAPHICS_ALLOCATION_CLOSED           = HRESULT(0xc0262112),
    ERROR_GRAPHICS_INVALID_ALLOCATION_INSTANCE = HRESULT(0xc0262113),
    ERROR_GRAPHICS_INVALID_ALLOCATION_HANDLE   = HRESULT(0xc0262114),
}

enum HRESULT ERROR_GRAPHICS_WRONG_ALLOCATION_DEVICE = HRESULT(0xc0262115);
enum HRESULT ERROR_GRAPHICS_ALLOCATION_CONTENT_LOST = HRESULT(0xc0262116);
enum HRESULT ERROR_GRAPHICS_GPU_EXCEPTION_ON_DEVICE = HRESULT(0xc0262200);
enum HRESULT ERROR_GRAPHICS_SKIP_ALLOCATION_PREPARATION = HRESULT(0x40262201);

enum : HRESULT
{
    ERROR_GRAPHICS_INVALID_VIDPN_TOPOLOGY                 = HRESULT(0xc0262300),
    ERROR_GRAPHICS_VIDPN_TOPOLOGY_NOT_SUPPORTED           = HRESULT(0xc0262301),
    ERROR_GRAPHICS_VIDPN_TOPOLOGY_CURRENTLY_NOT_SUPPORTED = HRESULT(0xc0262302),
}

enum : HRESULT
{
    ERROR_GRAPHICS_INVALID_VIDPN                = HRESULT(0xc0262303),
    ERROR_GRAPHICS_INVALID_VIDEO_PRESENT_SOURCE = HRESULT(0xc0262304),
    ERROR_GRAPHICS_INVALID_VIDEO_PRESENT_TARGET = HRESULT(0xc0262305),
}

enum HRESULT ERROR_GRAPHICS_VIDPN_MODALITY_NOT_SUPPORTED = HRESULT(0xc0262306);

enum : HRESULT
{
    ERROR_GRAPHICS_MODE_NOT_PINNED                   = HRESULT(0x00262307),
    ERROR_GRAPHICS_INVALID_VIDPN_SOURCEMODESET       = HRESULT(0xc0262308),
    ERROR_GRAPHICS_INVALID_VIDPN_TARGETMODESET       = HRESULT(0xc0262309),
    ERROR_GRAPHICS_INVALID_FREQUENCY                 = HRESULT(0xc026230a),
    ERROR_GRAPHICS_INVALID_ACTIVE_REGION             = HRESULT(0xc026230b),
    ERROR_GRAPHICS_INVALID_TOTAL_REGION              = HRESULT(0xc026230c),
    ERROR_GRAPHICS_INVALID_VIDEO_PRESENT_SOURCE_MODE = HRESULT(0xc0262310),
    ERROR_GRAPHICS_INVALID_VIDEO_PRESENT_TARGET_MODE = HRESULT(0xc0262311),
}

enum HRESULT ERROR_GRAPHICS_PINNED_MODE_MUST_REMAIN_IN_SET = HRESULT(0xc0262312);
enum HRESULT ERROR_GRAPHICS_PATH_ALREADY_IN_TOPOLOGY = HRESULT(0xc0262313);
enum HRESULT ERROR_GRAPHICS_MODE_ALREADY_IN_MODESET = HRESULT(0xc0262314);

enum : HRESULT
{
    ERROR_GRAPHICS_INVALID_VIDEOPRESENTSOURCESET = HRESULT(0xc0262315),
    ERROR_GRAPHICS_INVALID_VIDEOPRESENTTARGETSET = HRESULT(0xc0262316),
}

enum : HRESULT
{
    ERROR_GRAPHICS_SOURCE_ALREADY_IN_SET      = HRESULT(0xc0262317),
    ERROR_GRAPHICS_TARGET_ALREADY_IN_SET      = HRESULT(0xc0262318),
    ERROR_GRAPHICS_INVALID_VIDPN_PRESENT_PATH = HRESULT(0xc0262319),
}

enum HRESULT ERROR_GRAPHICS_NO_RECOMMENDED_VIDPN_TOPOLOGY = HRESULT(0xc026231a);

enum : HRESULT
{
    ERROR_GRAPHICS_INVALID_MONITOR_FREQUENCYRANGESET = HRESULT(0xc026231b),
    ERROR_GRAPHICS_INVALID_MONITOR_FREQUENCYRANGE    = HRESULT(0xc026231c),
}

enum HRESULT ERROR_GRAPHICS_FREQUENCYRANGE_NOT_IN_SET = HRESULT(0xc026231d);

enum : HRESULT
{
    ERROR_GRAPHICS_NO_PREFERRED_MODE             = HRESULT(0x0026231e),
    ERROR_GRAPHICS_FREQUENCYRANGE_ALREADY_IN_SET = HRESULT(0xc026231f),
}

enum : HRESULT
{
    ERROR_GRAPHICS_STALE_MODESET                 = HRESULT(0xc0262320),
    ERROR_GRAPHICS_INVALID_MONITOR_SOURCEMODESET = HRESULT(0xc0262321),
    ERROR_GRAPHICS_INVALID_MONITOR_SOURCE_MODE   = HRESULT(0xc0262322),
}

enum HRESULT ERROR_GRAPHICS_NO_RECOMMENDED_FUNCTIONAL_VIDPN = HRESULT(0xc0262323);

enum : HRESULT
{
    ERROR_GRAPHICS_MODE_ID_MUST_BE_UNIQUE                          = HRESULT(0xc0262324),
    ERROR_GRAPHICS_EMPTY_ADAPTER_MONITOR_MODE_SUPPORT_INTERSECTION = HRESULT(0xc0262325),
}

enum HRESULT ERROR_GRAPHICS_VIDEO_PRESENT_TARGETS_LESS_THAN_SOURCES = HRESULT(0xc0262326);

enum : HRESULT
{
    ERROR_GRAPHICS_PATH_NOT_IN_TOPOLOGY                  = HRESULT(0xc0262327),
    ERROR_GRAPHICS_ADAPTER_MUST_HAVE_AT_LEAST_ONE_SOURCE = HRESULT(0xc0262328),
    ERROR_GRAPHICS_ADAPTER_MUST_HAVE_AT_LEAST_ONE_TARGET = HRESULT(0xc0262329),
}

enum : HRESULT
{
    ERROR_GRAPHICS_INVALID_MONITORDESCRIPTORSET = HRESULT(0xc026232a),
    ERROR_GRAPHICS_INVALID_MONITORDESCRIPTOR    = HRESULT(0xc026232b),
}

enum : HRESULT
{
    ERROR_GRAPHICS_MONITORDESCRIPTOR_NOT_IN_SET        = HRESULT(0xc026232c),
    ERROR_GRAPHICS_MONITORDESCRIPTOR_ALREADY_IN_SET    = HRESULT(0xc026232d),
    ERROR_GRAPHICS_MONITORDESCRIPTOR_ID_MUST_BE_UNIQUE = HRESULT(0xc026232e),
}

enum HRESULT ERROR_GRAPHICS_INVALID_VIDPN_TARGET_SUBSET_TYPE = HRESULT(0xc026232f);

enum : HRESULT
{
    ERROR_GRAPHICS_RESOURCES_NOT_RELATED    = HRESULT(0xc0262330),
    ERROR_GRAPHICS_SOURCE_ID_MUST_BE_UNIQUE = HRESULT(0xc0262331),
}

enum HRESULT ERROR_GRAPHICS_TARGET_ID_MUST_BE_UNIQUE = HRESULT(0xc0262332);
enum HRESULT ERROR_GRAPHICS_NO_AVAILABLE_VIDPN_TARGET = HRESULT(0xc0262333);
enum HRESULT ERROR_GRAPHICS_MONITOR_COULD_NOT_BE_ASSOCIATED_WITH_ADAPTER = HRESULT(0xc0262334);

enum : HRESULT
{
    ERROR_GRAPHICS_NO_VIDPNMGR                  = HRESULT(0xc0262335),
    ERROR_GRAPHICS_NO_ACTIVE_VIDPN              = HRESULT(0xc0262336),
    ERROR_GRAPHICS_STALE_VIDPN_TOPOLOGY         = HRESULT(0xc0262337),
    ERROR_GRAPHICS_MONITOR_NOT_CONNECTED        = HRESULT(0xc0262338),
    ERROR_GRAPHICS_SOURCE_NOT_IN_TOPOLOGY       = HRESULT(0xc0262339),
    ERROR_GRAPHICS_INVALID_PRIMARYSURFACE_SIZE  = HRESULT(0xc026233a),
    ERROR_GRAPHICS_INVALID_VISIBLEREGION_SIZE   = HRESULT(0xc026233b),
    ERROR_GRAPHICS_INVALID_STRIDE               = HRESULT(0xc026233c),
    ERROR_GRAPHICS_INVALID_PIXELFORMAT          = HRESULT(0xc026233d),
    ERROR_GRAPHICS_INVALID_COLORBASIS           = HRESULT(0xc026233e),
    ERROR_GRAPHICS_INVALID_PIXELVALUEACCESSMODE = HRESULT(0xc026233f),
}

enum : HRESULT
{
    ERROR_GRAPHICS_TARGET_NOT_IN_TOPOLOGY             = HRESULT(0xc0262340),
    ERROR_GRAPHICS_NO_DISPLAY_MODE_MANAGEMENT_SUPPORT = HRESULT(0xc0262341),
}

enum : HRESULT
{
    ERROR_GRAPHICS_VIDPN_SOURCE_IN_USE      = HRESULT(0xc0262342),
    ERROR_GRAPHICS_CANT_ACCESS_ACTIVE_VIDPN = HRESULT(0xc0262343),
}

enum : HRESULT
{
    ERROR_GRAPHICS_INVALID_PATH_IMPORTANCE_ORDINAL              = HRESULT(0xc0262344),
    ERROR_GRAPHICS_INVALID_PATH_CONTENT_GEOMETRY_TRANSFORMATION = HRESULT(0xc0262345),
}

enum HRESULT ERROR_GRAPHICS_PATH_CONTENT_GEOMETRY_TRANSFORMATION_NOT_SUPPORTED = HRESULT(0xc0262346);

enum : HRESULT
{
    ERROR_GRAPHICS_INVALID_GAMMA_RAMP       = HRESULT(0xc0262347),
    ERROR_GRAPHICS_GAMMA_RAMP_NOT_SUPPORTED = HRESULT(0xc0262348),
}

enum HRESULT ERROR_GRAPHICS_MULTISAMPLING_NOT_SUPPORTED = HRESULT(0xc0262349);

enum : HRESULT
{
    ERROR_GRAPHICS_MODE_NOT_IN_MODESET         = HRESULT(0xc026234a),
    ERROR_GRAPHICS_DATASET_IS_EMPTY            = HRESULT(0x0026234b),
    ERROR_GRAPHICS_NO_MORE_ELEMENTS_IN_DATASET = HRESULT(0x0026234c),
}

enum HRESULT ERROR_GRAPHICS_INVALID_VIDPN_TOPOLOGY_RECOMMENDATION_REASON = HRESULT(0xc026234d);

enum : HRESULT
{
    ERROR_GRAPHICS_INVALID_PATH_CONTENT_TYPE   = HRESULT(0xc026234e),
    ERROR_GRAPHICS_INVALID_COPYPROTECTION_TYPE = HRESULT(0xc026234f),
}

enum HRESULT ERROR_GRAPHICS_UNASSIGNED_MODESET_ALREADY_EXISTS = HRESULT(0xc0262350);
enum HRESULT ERROR_GRAPHICS_PATH_CONTENT_GEOMETRY_TRANSFORMATION_NOT_PINNED = HRESULT(0x00262351);
enum HRESULT ERROR_GRAPHICS_INVALID_SCANLINE_ORDERING = HRESULT(0xc0262352);
enum HRESULT ERROR_GRAPHICS_TOPOLOGY_CHANGES_NOT_ALLOWED = HRESULT(0xc0262353);
enum HRESULT ERROR_GRAPHICS_NO_AVAILABLE_IMPORTANCE_ORDINALS = HRESULT(0xc0262354);

enum : HRESULT
{
    ERROR_GRAPHICS_INCOMPATIBLE_PRIVATE_FORMAT               = HRESULT(0xc0262355),
    ERROR_GRAPHICS_INVALID_MODE_PRUNING_ALGORITHM            = HRESULT(0xc0262356),
    ERROR_GRAPHICS_INVALID_MONITOR_CAPABILITY_ORIGIN         = HRESULT(0xc0262357),
    ERROR_GRAPHICS_INVALID_MONITOR_FREQUENCYRANGE_CONSTRAINT = HRESULT(0xc0262358),
}

enum : HRESULT
{
    ERROR_GRAPHICS_MAX_NUM_PATHS_REACHED              = HRESULT(0xc0262359),
    ERROR_GRAPHICS_CANCEL_VIDPN_TOPOLOGY_AUGMENTATION = HRESULT(0xc026235a),
}

enum : HRESULT
{
    ERROR_GRAPHICS_INVALID_CLIENT_TYPE               = HRESULT(0xc026235b),
    ERROR_GRAPHICS_CLIENTVIDPN_NOT_SET               = HRESULT(0xc026235c),
    ERROR_GRAPHICS_SPECIFIED_CHILD_ALREADY_CONNECTED = HRESULT(0xc0262400),
}

enum HRESULT ERROR_GRAPHICS_CHILD_DESCRIPTOR_NOT_SUPPORTED = HRESULT(0xc0262401);

enum : HRESULT
{
    ERROR_GRAPHICS_UNKNOWN_CHILD_STATUS    = HRESULT(0x4026242f),
    ERROR_GRAPHICS_NOT_A_LINKED_ADAPTER    = HRESULT(0xc0262430),
    ERROR_GRAPHICS_LEADLINK_NOT_ENUMERATED = HRESULT(0xc0262431),
}

enum HRESULT ERROR_GRAPHICS_CHAINLINKS_NOT_ENUMERATED = HRESULT(0xc0262432);
enum HRESULT ERROR_GRAPHICS_ADAPTER_CHAIN_NOT_READY = HRESULT(0xc0262433);

enum : HRESULT
{
    ERROR_GRAPHICS_CHAINLINKS_NOT_STARTED    = HRESULT(0xc0262434),
    ERROR_GRAPHICS_CHAINLINKS_NOT_POWERED_ON = HRESULT(0xc0262435),
}

enum HRESULT ERROR_GRAPHICS_INCONSISTENT_DEVICE_LINK_STATE = HRESULT(0xc0262436);
enum HRESULT ERROR_GRAPHICS_LEADLINK_START_DEFERRED = HRESULT(0x40262437);

enum : HRESULT
{
    ERROR_GRAPHICS_NOT_POST_DEVICE_DRIVER      = HRESULT(0xc0262438),
    ERROR_GRAPHICS_POLLING_TOO_FREQUENTLY      = HRESULT(0x40262439),
    ERROR_GRAPHICS_START_DEFERRED              = HRESULT(0x4026243a),
    ERROR_GRAPHICS_ADAPTER_ACCESS_NOT_EXCLUDED = HRESULT(0xc026243b),
}

enum HRESULT ERROR_GRAPHICS_DEPENDABLE_CHILD_STATUS = HRESULT(0x4026243c);

enum : HRESULT
{
    ERROR_GRAPHICS_OPM_NOT_SUPPORTED                = HRESULT(0xc0262500),
    ERROR_GRAPHICS_COPP_NOT_SUPPORTED               = HRESULT(0xc0262501),
    ERROR_GRAPHICS_UAB_NOT_SUPPORTED                = HRESULT(0xc0262502),
    ERROR_GRAPHICS_OPM_INVALID_ENCRYPTED_PARAMETERS = HRESULT(0xc0262503),
    ERROR_GRAPHICS_OPM_NO_VIDEO_OUTPUTS_EXIST       = HRESULT(0xc0262505),
    ERROR_GRAPHICS_OPM_INTERNAL_ERROR               = HRESULT(0xc026250b),
    ERROR_GRAPHICS_OPM_INVALID_HANDLE               = HRESULT(0xc026250c),
    ERROR_GRAPHICS_PVP_INVALID_CERTIFICATE_LENGTH   = HRESULT(0xc026250e),
}

enum : HRESULT
{
    ERROR_GRAPHICS_OPM_SPANNING_MODE_ENABLED = HRESULT(0xc026250f),
    ERROR_GRAPHICS_OPM_THEATER_MODE_ENABLED  = HRESULT(0xc0262510),
}

enum : HRESULT
{
    ERROR_GRAPHICS_PVP_HFS_FAILED                    = HRESULT(0xc0262511),
    ERROR_GRAPHICS_OPM_INVALID_SRM                   = HRESULT(0xc0262512),
    ERROR_GRAPHICS_OPM_OUTPUT_DOES_NOT_SUPPORT_HDCP  = HRESULT(0xc0262513),
    ERROR_GRAPHICS_OPM_OUTPUT_DOES_NOT_SUPPORT_ACP   = HRESULT(0xc0262514),
    ERROR_GRAPHICS_OPM_OUTPUT_DOES_NOT_SUPPORT_CGMSA = HRESULT(0xc0262515),
}

enum : HRESULT
{
    ERROR_GRAPHICS_OPM_HDCP_SRM_NEVER_SET               = HRESULT(0xc0262516),
    ERROR_GRAPHICS_OPM_RESOLUTION_TOO_HIGH              = HRESULT(0xc0262517),
    ERROR_GRAPHICS_OPM_ALL_HDCP_HARDWARE_ALREADY_IN_USE = HRESULT(0xc0262518),
}

enum HRESULT ERROR_GRAPHICS_OPM_VIDEO_OUTPUT_NO_LONGER_EXISTS = HRESULT(0xc026251a);
enum HRESULT ERROR_GRAPHICS_OPM_SESSION_TYPE_CHANGE_IN_PROGRESS = HRESULT(0xc026251b);
enum HRESULT ERROR_GRAPHICS_OPM_VIDEO_OUTPUT_DOES_NOT_HAVE_COPP_SEMANTICS = HRESULT(0xc026251c);

enum : HRESULT
{
    ERROR_GRAPHICS_OPM_INVALID_INFORMATION_REQUEST              = HRESULT(0xc026251d),
    ERROR_GRAPHICS_OPM_DRIVER_INTERNAL_ERROR                    = HRESULT(0xc026251e),
    ERROR_GRAPHICS_OPM_VIDEO_OUTPUT_DOES_NOT_HAVE_OPM_SEMANTICS = HRESULT(0xc026251f),
}

enum : HRESULT
{
    ERROR_GRAPHICS_OPM_SIGNALING_NOT_SUPPORTED       = HRESULT(0xc0262520),
    ERROR_GRAPHICS_OPM_INVALID_CONFIGURATION_REQUEST = HRESULT(0xc0262521),
}

enum : HRESULT
{
    ERROR_GRAPHICS_I2C_NOT_SUPPORTED           = HRESULT(0xc0262580),
    ERROR_GRAPHICS_I2C_DEVICE_DOES_NOT_EXIST   = HRESULT(0xc0262581),
    ERROR_GRAPHICS_I2C_ERROR_TRANSMITTING_DATA = HRESULT(0xc0262582),
    ERROR_GRAPHICS_I2C_ERROR_RECEIVING_DATA    = HRESULT(0xc0262583),
}

enum : HRESULT
{
    ERROR_GRAPHICS_DDCCI_VCP_NOT_SUPPORTED                           = HRESULT(0xc0262584),
    ERROR_GRAPHICS_DDCCI_INVALID_DATA                                = HRESULT(0xc0262585),
    ERROR_GRAPHICS_DDCCI_MONITOR_RETURNED_INVALID_TIMING_STATUS_BYTE = HRESULT(0xc0262586),
}

enum : HRESULT
{
    ERROR_GRAPHICS_MCA_INVALID_CAPABILITIES_STRING = HRESULT(0xc0262587),
    ERROR_GRAPHICS_MCA_INTERNAL_ERROR              = HRESULT(0xc0262588),
    ERROR_GRAPHICS_DDCCI_INVALID_MESSAGE_COMMAND   = HRESULT(0xc0262589),
    ERROR_GRAPHICS_DDCCI_INVALID_MESSAGE_LENGTH    = HRESULT(0xc026258a),
    ERROR_GRAPHICS_DDCCI_INVALID_MESSAGE_CHECKSUM  = HRESULT(0xc026258b),
}

enum HRESULT ERROR_GRAPHICS_INVALID_PHYSICAL_MONITOR_HANDLE = HRESULT(0xc026258c);
enum HRESULT ERROR_GRAPHICS_MONITOR_NO_LONGER_EXISTS = HRESULT(0xc026258d);
enum HRESULT ERROR_GRAPHICS_DDCCI_CURRENT_CURRENT_VALUE_GREATER_THAN_MAXIMUM_VALUE = HRESULT(0xc02625d8);

enum : HRESULT
{
    ERROR_GRAPHICS_MCA_INVALID_VCP_VERSION                 = HRESULT(0xc02625d9),
    ERROR_GRAPHICS_MCA_MONITOR_VIOLATES_MCCS_SPECIFICATION = HRESULT(0xc02625da),
}

enum : HRESULT
{
    ERROR_GRAPHICS_MCA_MCCS_VERSION_MISMATCH            = HRESULT(0xc02625db),
    ERROR_GRAPHICS_MCA_UNSUPPORTED_MCCS_VERSION         = HRESULT(0xc02625dc),
    ERROR_GRAPHICS_MCA_INVALID_TECHNOLOGY_TYPE_RETURNED = HRESULT(0xc02625de),
}

enum HRESULT ERROR_GRAPHICS_MCA_UNSUPPORTED_COLOR_TEMPERATURE = HRESULT(0xc02625df);
enum HRESULT ERROR_GRAPHICS_ONLY_CONSOLE_SESSION_SUPPORTED = HRESULT(0xc02625e0);
enum HRESULT ERROR_GRAPHICS_NO_DISPLAY_DEVICE_CORRESPONDS_TO_NAME = HRESULT(0xc02625e1);
enum HRESULT ERROR_GRAPHICS_DISPLAY_DEVICE_NOT_ATTACHED_TO_DESKTOP = HRESULT(0xc02625e2);
enum HRESULT ERROR_GRAPHICS_MIRRORING_DEVICES_NOT_SUPPORTED = HRESULT(0xc02625e3);

enum : HRESULT
{
    ERROR_GRAPHICS_INVALID_POINTER                          = HRESULT(0xc02625e4),
    ERROR_GRAPHICS_NO_MONITORS_CORRESPOND_TO_DISPLAY_DEVICE = HRESULT(0xc02625e5),
}

enum HRESULT ERROR_GRAPHICS_PARAMETER_ARRAY_TOO_SMALL = HRESULT(0xc02625e6);

enum : HRESULT
{
    ERROR_GRAPHICS_INTERNAL_ERROR                  = HRESULT(0xc02625e7),
    ERROR_GRAPHICS_SESSION_TYPE_CHANGE_IN_PROGRESS = HRESULT(0xc02605e8),
}

enum HRESULT ERROR_GRAPHICS_UNKNOWN_BIOS_FRAME_BUFFER_NOT_FOUND = HRESULT(0xc0262600);
enum HRESULT ERROR_GRAPHICS_UEFI_FRAME_BUFFER_NOT_FOUND = HRESULT(0xc0262601);
enum HRESULT NAP_E_INVALID_PACKET = HRESULT(0x80270001);
enum HRESULT NAP_E_MISSING_SOH = HRESULT(0x80270002);
enum HRESULT NAP_E_CONFLICTING_ID = HRESULT(0x80270003);
enum HRESULT NAP_E_NO_CACHED_SOH = HRESULT(0x80270004);
enum HRESULT NAP_E_STILL_BOUND = HRESULT(0x80270005);

enum : HRESULT
{
    NAP_E_NOT_REGISTERED  = HRESULT(0x80270006),
    NAP_E_NOT_INITIALIZED = HRESULT(0x80270007),
}

enum HRESULT NAP_E_MISMATCHED_ID = HRESULT(0x80270008);
enum HRESULT NAP_E_NOT_PENDING = HRESULT(0x80270009);
enum HRESULT NAP_E_ID_NOT_FOUND = HRESULT(0x8027000a);
enum HRESULT NAP_E_MAXSIZE_TOO_SMALL = HRESULT(0x8027000b);
enum HRESULT NAP_E_SERVICE_NOT_RUNNING = HRESULT(0x8027000c);
enum HRESULT NAP_S_CERT_ALREADY_PRESENT = HRESULT(0x0027000d);
enum HRESULT NAP_E_ENTITY_DISABLED = HRESULT(0x8027000e);
enum HRESULT NAP_E_NETSH_GROUPPOLICY_ERROR = HRESULT(0x8027000f);
enum HRESULT NAP_E_TOO_MANY_CALLS = HRESULT(0x80270010);

enum : HRESULT
{
    NAP_E_SHV_CONFIG_EXISTED   = HRESULT(0x80270011),
    NAP_E_SHV_CONFIG_NOT_FOUND = HRESULT(0x80270012),
}

enum HRESULT NAP_E_SHV_TIMEOUT = HRESULT(0x80270013);
enum HRESULT TPM_E_ERROR_MASK = HRESULT(0x80280000);

enum : HRESULT
{
    TPM_E_AUTHFAIL      = HRESULT(0x80280001),
    TPM_E_BADINDEX      = HRESULT(0x80280002),
    TPM_E_BAD_PARAMETER = HRESULT(0x80280003),
}

enum HRESULT TPM_E_AUDITFAILURE = HRESULT(0x80280004);
enum HRESULT TPM_E_CLEAR_DISABLED = HRESULT(0x80280005);

enum : HRESULT
{
    TPM_E_DEACTIVATED  = HRESULT(0x80280006),
    TPM_E_DISABLED     = HRESULT(0x80280007),
    TPM_E_DISABLED_CMD = HRESULT(0x80280008),
}

enum : HRESULT
{
    TPM_E_FAIL        = HRESULT(0x80280009),
    TPM_E_BAD_ORDINAL = HRESULT(0x8028000a),
}

enum HRESULT TPM_E_INSTALL_DISABLED = HRESULT(0x8028000b);
enum HRESULT TPM_E_INVALID_KEYHANDLE = HRESULT(0x8028000c);
enum HRESULT TPM_E_KEYNOTFOUND = HRESULT(0x8028000d);
enum HRESULT TPM_E_INAPPROPRIATE_ENC = HRESULT(0x8028000e);
enum HRESULT TPM_E_MIGRATEFAIL = HRESULT(0x8028000f);
enum HRESULT TPM_E_INVALID_PCR_INFO = HRESULT(0x80280010);

enum : HRESULT
{
    TPM_E_NOSPACE        = HRESULT(0x80280011),
    TPM_E_NOSRK          = HRESULT(0x80280012),
    TPM_E_NOTSEALED_BLOB = HRESULT(0x80280013),
}

enum HRESULT TPM_E_OWNER_SET = HRESULT(0x80280014);
enum HRESULT TPM_E_RESOURCES = HRESULT(0x80280015);

enum : HRESULT
{
    TPM_E_SHORTRANDOM = HRESULT(0x80280016),
    TPM_E_SIZE        = HRESULT(0x80280017),
    TPM_E_WRONGPCRVAL = HRESULT(0x80280018),
}

enum HRESULT TPM_E_BAD_PARAM_SIZE = HRESULT(0x80280019);

enum : HRESULT
{
    TPM_E_SHA_THREAD = HRESULT(0x8028001a),
    TPM_E_SHA_ERROR  = HRESULT(0x8028001b),
}

enum HRESULT TPM_E_FAILEDSELFTEST = HRESULT(0x8028001c);
enum HRESULT TPM_E_AUTH2FAIL = HRESULT(0x8028001d);

enum : HRESULT
{
    TPM_E_BADTAG        = HRESULT(0x8028001e),
    TPM_E_IOERROR       = HRESULT(0x8028001f),
    TPM_E_ENCRYPT_ERROR = HRESULT(0x80280020),
}

enum HRESULT TPM_E_DECRYPT_ERROR = HRESULT(0x80280021);
enum HRESULT TPM_E_INVALID_AUTHHANDLE = HRESULT(0x80280022);
enum HRESULT TPM_E_NO_ENDORSEMENT = HRESULT(0x80280023);
enum HRESULT TPM_E_INVALID_KEYUSAGE = HRESULT(0x80280024);
enum HRESULT TPM_E_WRONG_ENTITYTYPE = HRESULT(0x80280025);
enum HRESULT TPM_E_INVALID_POSTINIT = HRESULT(0x80280026);
enum HRESULT TPM_E_INAPPROPRIATE_SIG = HRESULT(0x80280027);

enum : HRESULT
{
    TPM_E_BAD_KEY_PROPERTY = HRESULT(0x80280028),
    TPM_E_BAD_MIGRATION    = HRESULT(0x80280029),
    TPM_E_BAD_SCHEME       = HRESULT(0x8028002a),
    TPM_E_BAD_DATASIZE     = HRESULT(0x8028002b),
    TPM_E_BAD_MODE         = HRESULT(0x8028002c),
    TPM_E_BAD_PRESENCE     = HRESULT(0x8028002d),
    TPM_E_BAD_VERSION      = HRESULT(0x8028002e),
}

enum HRESULT TPM_E_NO_WRAP_TRANSPORT = HRESULT(0x8028002f);

enum : HRESULT
{
    TPM_E_AUDITFAIL_UNSUCCESSFUL = HRESULT(0x80280030),
    TPM_E_AUDITFAIL_SUCCESSFUL   = HRESULT(0x80280031),
}

enum : HRESULT
{
    TPM_E_NOTRESETABLE     = HRESULT(0x80280032),
    TPM_E_NOTLOCAL         = HRESULT(0x80280033),
    TPM_E_BAD_TYPE         = HRESULT(0x80280034),
    TPM_E_INVALID_RESOURCE = HRESULT(0x80280035),
}

enum : HRESULT
{
    TPM_E_NOTFIPS        = HRESULT(0x80280036),
    TPM_E_INVALID_FAMILY = HRESULT(0x80280037),
}

enum HRESULT TPM_E_NO_NV_PERMISSION = HRESULT(0x80280038);
enum HRESULT TPM_E_REQUIRES_SIGN = HRESULT(0x80280039);
enum HRESULT TPM_E_KEY_NOTSUPPORTED = HRESULT(0x8028003a);
enum HRESULT TPM_E_AUTH_CONFLICT = HRESULT(0x8028003b);
enum HRESULT TPM_E_AREA_LOCKED = HRESULT(0x8028003c);
enum HRESULT TPM_E_BAD_LOCALITY = HRESULT(0x8028003d);
enum HRESULT TPM_E_READ_ONLY = HRESULT(0x8028003e);
enum HRESULT TPM_E_PER_NOWRITE = HRESULT(0x8028003f);
enum HRESULT TPM_E_FAMILYCOUNT = HRESULT(0x80280040);
enum HRESULT TPM_E_WRITE_LOCKED = HRESULT(0x80280041);
enum HRESULT TPM_E_BAD_ATTRIBUTES = HRESULT(0x80280042);
enum HRESULT TPM_E_INVALID_STRUCTURE = HRESULT(0x80280043);
enum HRESULT TPM_E_KEY_OWNER_CONTROL = HRESULT(0x80280044);
enum HRESULT TPM_E_BAD_COUNTER = HRESULT(0x80280045);
enum HRESULT TPM_E_NOT_FULLWRITE = HRESULT(0x80280046);
enum HRESULT TPM_E_CONTEXT_GAP = HRESULT(0x80280047);
enum HRESULT TPM_E_MAXNVWRITES = HRESULT(0x80280048);
enum HRESULT TPM_E_NOOPERATOR = HRESULT(0x80280049);
enum HRESULT TPM_E_RESOURCEMISSING = HRESULT(0x8028004a);

enum : HRESULT
{
    TPM_E_DELEGATE_LOCK   = HRESULT(0x8028004b),
    TPM_E_DELEGATE_FAMILY = HRESULT(0x8028004c),
    TPM_E_DELEGATE_ADMIN  = HRESULT(0x8028004d),
}

enum HRESULT TPM_E_TRANSPORT_NOTEXCLUSIVE = HRESULT(0x8028004e);
enum HRESULT TPM_E_OWNER_CONTROL = HRESULT(0x8028004f);

enum : HRESULT
{
    TPM_E_DAA_RESOURCES       = HRESULT(0x80280050),
    TPM_E_DAA_INPUT_DATA0     = HRESULT(0x80280051),
    TPM_E_DAA_INPUT_DATA1     = HRESULT(0x80280052),
    TPM_E_DAA_ISSUER_SETTINGS = HRESULT(0x80280053),
}

enum : HRESULT
{
    TPM_E_DAA_TPM_SETTINGS    = HRESULT(0x80280054),
    TPM_E_DAA_STAGE           = HRESULT(0x80280055),
    TPM_E_DAA_ISSUER_VALIDITY = HRESULT(0x80280056),
}

enum HRESULT TPM_E_DAA_WRONG_W = HRESULT(0x80280057);

enum : HRESULT
{
    TPM_E_BAD_HANDLE   = HRESULT(0x80280058),
    TPM_E_BAD_DELEGATE = HRESULT(0x80280059),
    TPM_E_BADCONTEXT   = HRESULT(0x8028005a),
}

enum HRESULT TPM_E_TOOMANYCONTEXTS = HRESULT(0x8028005b);
enum HRESULT TPM_E_MA_TICKET_SIGNATURE = HRESULT(0x8028005c);

enum : HRESULT
{
    TPM_E_MA_DESTINATION = HRESULT(0x8028005d),
    TPM_E_MA_SOURCE      = HRESULT(0x8028005e),
    TPM_E_MA_AUTHORITY   = HRESULT(0x8028005f),
}

enum HRESULT TPM_E_PERMANENTEK = HRESULT(0x80280061);
enum HRESULT TPM_E_BAD_SIGNATURE = HRESULT(0x80280062);
enum HRESULT TPM_E_NOCONTEXTSPACE = HRESULT(0x80280063);

enum : HRESULT
{
    TPM_20_E_ASYMMETRIC        = HRESULT(0x80280081),
    TPM_20_E_ATTRIBUTES        = HRESULT(0x80280082),
    TPM_20_E_HASH              = HRESULT(0x80280083),
    TPM_20_E_VALUE             = HRESULT(0x80280084),
    TPM_20_E_HIERARCHY         = HRESULT(0x80280085),
    TPM_20_E_KEY_SIZE          = HRESULT(0x80280087),
    TPM_20_E_MGF               = HRESULT(0x80280088),
    TPM_20_E_MODE              = HRESULT(0x80280089),
    TPM_20_E_TYPE              = HRESULT(0x8028008a),
    TPM_20_E_HANDLE            = HRESULT(0x8028008b),
    TPM_20_E_KDF               = HRESULT(0x8028008c),
    TPM_20_E_RANGE             = HRESULT(0x8028008d),
    TPM_20_E_AUTH_FAIL         = HRESULT(0x8028008e),
    TPM_20_E_NONCE             = HRESULT(0x8028008f),
    TPM_20_E_PP                = HRESULT(0x80280090),
    TPM_20_E_SCHEME            = HRESULT(0x80280092),
    TPM_20_E_SIZE              = HRESULT(0x80280095),
    TPM_20_E_SYMMETRIC         = HRESULT(0x80280096),
    TPM_20_E_TAG               = HRESULT(0x80280097),
    TPM_20_E_SELECTOR          = HRESULT(0x80280098),
    TPM_20_E_INSUFFICIENT      = HRESULT(0x8028009a),
    TPM_20_E_SIGNATURE         = HRESULT(0x8028009b),
    TPM_20_E_KEY               = HRESULT(0x8028009c),
    TPM_20_E_POLICY_FAIL       = HRESULT(0x8028009d),
    TPM_20_E_INTEGRITY         = HRESULT(0x8028009f),
    TPM_20_E_TICKET            = HRESULT(0x802800a0),
    TPM_20_E_RESERVED_BITS     = HRESULT(0x802800a1),
    TPM_20_E_BAD_AUTH          = HRESULT(0x802800a2),
    TPM_20_E_EXPIRED           = HRESULT(0x802800a3),
    TPM_20_E_POLICY_CC         = HRESULT(0x802800a4),
    TPM_20_E_BINDING           = HRESULT(0x802800a5),
    TPM_20_E_CURVE             = HRESULT(0x802800a6),
    TPM_20_E_ECC_POINT         = HRESULT(0x802800a7),
    TPM_20_E_INITIALIZE        = HRESULT(0x80280100),
    TPM_20_E_FAILURE           = HRESULT(0x80280101),
    TPM_20_E_SEQUENCE          = HRESULT(0x80280103),
    TPM_20_E_PRIVATE           = HRESULT(0x8028010b),
    TPM_20_E_HMAC              = HRESULT(0x80280119),
    TPM_20_E_DISABLED          = HRESULT(0x80280120),
    TPM_20_E_EXCLUSIVE         = HRESULT(0x80280121),
    TPM_20_E_ECC_CURVE         = HRESULT(0x80280123),
    TPM_20_E_AUTH_TYPE         = HRESULT(0x80280124),
    TPM_20_E_AUTH_MISSING      = HRESULT(0x80280125),
    TPM_20_E_POLICY            = HRESULT(0x80280126),
    TPM_20_E_PCR               = HRESULT(0x80280127),
    TPM_20_E_PCR_CHANGED       = HRESULT(0x80280128),
    TPM_20_E_UPGRADE           = HRESULT(0x8028012d),
    TPM_20_E_TOO_MANY_CONTEXTS = HRESULT(0x8028012e),
}

enum HRESULT TPM_20_E_AUTH_UNAVAILABLE = HRESULT(0x8028012f);

enum : HRESULT
{
    TPM_20_E_REBOOT           = HRESULT(0x80280130),
    TPM_20_E_UNBALANCED       = HRESULT(0x80280131),
    TPM_20_E_COMMAND_SIZE     = HRESULT(0x80280142),
    TPM_20_E_COMMAND_CODE     = HRESULT(0x80280143),
    TPM_20_E_AUTHSIZE         = HRESULT(0x80280144),
    TPM_20_E_AUTH_CONTEXT     = HRESULT(0x80280145),
    TPM_20_E_NV_RANGE         = HRESULT(0x80280146),
    TPM_20_E_NV_SIZE          = HRESULT(0x80280147),
    TPM_20_E_NV_LOCKED        = HRESULT(0x80280148),
    TPM_20_E_NV_AUTHORIZATION = HRESULT(0x80280149),
    TPM_20_E_NV_UNINITIALIZED = HRESULT(0x8028014a),
    TPM_20_E_NV_SPACE         = HRESULT(0x8028014b),
    TPM_20_E_NV_DEFINED       = HRESULT(0x8028014c),
    TPM_20_E_BAD_CONTEXT      = HRESULT(0x80280150),
    TPM_20_E_CPHASH           = HRESULT(0x80280151),
    TPM_20_E_PARENT           = HRESULT(0x80280152),
    TPM_20_E_NEEDS_TEST       = HRESULT(0x80280153),
    TPM_20_E_NO_RESULT        = HRESULT(0x80280154),
    TPM_20_E_SENSITIVE        = HRESULT(0x80280155),
}

enum HRESULT TPM_E_COMMAND_BLOCKED = HRESULT(0x80280400);
enum HRESULT TPM_E_INVALID_HANDLE = HRESULT(0x80280401);
enum HRESULT TPM_E_DUPLICATE_VHANDLE = HRESULT(0x80280402);

enum : HRESULT
{
    TPM_E_EMBEDDED_COMMAND_BLOCKED     = HRESULT(0x80280403),
    TPM_E_EMBEDDED_COMMAND_UNSUPPORTED = HRESULT(0x80280404),
}

enum : HRESULT
{
    TPM_E_RETRY          = HRESULT(0x80280800),
    TPM_E_NEEDS_SELFTEST = HRESULT(0x80280801),
}

enum HRESULT TPM_E_DOING_SELFTEST = HRESULT(0x80280802);
enum HRESULT TPM_E_DEFEND_LOCK_RUNNING = HRESULT(0x80280803);

enum : HRESULT
{
    TPM_20_E_CONTEXT_GAP    = HRESULT(0x80280901),
    TPM_20_E_OBJECT_MEMORY  = HRESULT(0x80280902),
    TPM_20_E_SESSION_MEMORY = HRESULT(0x80280903),
}

enum : HRESULT
{
    TPM_20_E_MEMORY          = HRESULT(0x80280904),
    TPM_20_E_SESSION_HANDLES = HRESULT(0x80280905),
}

enum HRESULT TPM_20_E_OBJECT_HANDLES = HRESULT(0x80280906);

enum : HRESULT
{
    TPM_20_E_LOCALITY       = HRESULT(0x80280907),
    TPM_20_E_YIELDED        = HRESULT(0x80280908),
    TPM_20_E_CANCELED       = HRESULT(0x80280909),
    TPM_20_E_TESTING        = HRESULT(0x8028090a),
    TPM_20_E_NV_RATE        = HRESULT(0x80280920),
    TPM_20_E_LOCKOUT        = HRESULT(0x80280921),
    TPM_20_E_RETRY          = HRESULT(0x80280922),
    TPM_20_E_NV_UNAVAILABLE = HRESULT(0x80280923),
}

enum HRESULT TBS_E_INTERNAL_ERROR = HRESULT(0x80284001);
enum HRESULT TBS_E_BAD_PARAMETER = HRESULT(0x80284002);

enum : HRESULT
{
    TBS_E_INVALID_OUTPUT_POINTER = HRESULT(0x80284003),
    TBS_E_INVALID_CONTEXT        = HRESULT(0x80284004),
}

enum HRESULT TBS_E_INSUFFICIENT_BUFFER = HRESULT(0x80284005);

enum : HRESULT
{
    TBS_E_IOERROR               = HRESULT(0x80284006),
    TBS_E_INVALID_CONTEXT_PARAM = HRESULT(0x80284007),
}

enum HRESULT TBS_E_SERVICE_NOT_RUNNING = HRESULT(0x80284008);

enum : HRESULT
{
    TBS_E_TOO_MANY_TBS_CONTEXTS = HRESULT(0x80284009),
    TBS_E_TOO_MANY_RESOURCES    = HRESULT(0x8028400a),
}

enum HRESULT TBS_E_SERVICE_START_PENDING = HRESULT(0x8028400b);
enum HRESULT TBS_E_PPI_NOT_SUPPORTED = HRESULT(0x8028400c);
enum HRESULT TBS_E_COMMAND_CANCELED = HRESULT(0x8028400d);
enum HRESULT TBS_E_BUFFER_TOO_LARGE = HRESULT(0x8028400e);
enum HRESULT TBS_E_TPM_NOT_FOUND = HRESULT(0x8028400f);
enum HRESULT TBS_E_SERVICE_DISABLED = HRESULT(0x80284010);
enum HRESULT TBS_E_NO_EVENT_LOG = HRESULT(0x80284011);
enum HRESULT TBS_E_ACCESS_DENIED = HRESULT(0x80284012);
enum HRESULT TBS_E_PROVISIONING_NOT_ALLOWED = HRESULT(0x80284013);
enum HRESULT TBS_E_PPI_FUNCTION_UNSUPPORTED = HRESULT(0x80284014);
enum HRESULT TBS_E_OWNERAUTH_NOT_FOUND = HRESULT(0x80284015);
enum HRESULT TBS_E_PROVISIONING_INCOMPLETE = HRESULT(0x80284016);
enum HRESULT TBS_E_TPM_IN_EXCLUSIVE_MODE = HRESULT(0x80284017);
enum HRESULT TBS_E_TPM_REBOOT_REQUIRED = HRESULT(0x80284018);

enum : HRESULT
{
    TPMAPI_E_INVALID_STATE   = HRESULT(0x80290100),
    TPMAPI_E_NOT_ENOUGH_DATA = HRESULT(0x80290101),
}

enum : HRESULT
{
    TPMAPI_E_TOO_MUCH_DATA          = HRESULT(0x80290102),
    TPMAPI_E_INVALID_OUTPUT_POINTER = HRESULT(0x80290103),
    TPMAPI_E_INVALID_PARAMETER      = HRESULT(0x80290104),
}

enum : HRESULT
{
    TPMAPI_E_OUT_OF_MEMORY    = HRESULT(0x80290105),
    TPMAPI_E_BUFFER_TOO_SMALL = HRESULT(0x80290106),
}

enum HRESULT TPMAPI_E_INTERNAL_ERROR = HRESULT(0x80290107);

enum : HRESULT
{
    TPMAPI_E_ACCESS_DENIED        = HRESULT(0x80290108),
    TPMAPI_E_AUTHORIZATION_FAILED = HRESULT(0x80290109),
}

enum HRESULT TPMAPI_E_INVALID_CONTEXT_HANDLE = HRESULT(0x8029010a);
enum HRESULT TPMAPI_E_TBS_COMMUNICATION_ERROR = HRESULT(0x8029010b);
enum HRESULT TPMAPI_E_TPM_COMMAND_ERROR = HRESULT(0x8029010c);
enum HRESULT TPMAPI_E_MESSAGE_TOO_LARGE = HRESULT(0x8029010d);

enum : HRESULT
{
    TPMAPI_E_INVALID_ENCODING = HRESULT(0x8029010e),
    TPMAPI_E_INVALID_KEY_SIZE = HRESULT(0x8029010f),
}

enum HRESULT TPMAPI_E_ENCRYPTION_FAILED = HRESULT(0x80290110);

enum : HRESULT
{
    TPMAPI_E_INVALID_KEY_PARAMS                   = HRESULT(0x80290111),
    TPMAPI_E_INVALID_MIGRATION_AUTHORIZATION_BLOB = HRESULT(0x80290112),
}

enum : HRESULT
{
    TPMAPI_E_INVALID_PCR_INDEX      = HRESULT(0x80290113),
    TPMAPI_E_INVALID_DELEGATE_BLOB  = HRESULT(0x80290114),
    TPMAPI_E_INVALID_CONTEXT_PARAMS = HRESULT(0x80290115),
    TPMAPI_E_INVALID_KEY_BLOB       = HRESULT(0x80290116),
    TPMAPI_E_INVALID_PCR_DATA       = HRESULT(0x80290117),
    TPMAPI_E_INVALID_OWNER_AUTH     = HRESULT(0x80290118),
}

enum HRESULT TPMAPI_E_FIPS_RNG_CHECK_FAILED = HRESULT(0x80290119);

enum : HRESULT
{
    TPMAPI_E_EMPTY_TCG_LOG         = HRESULT(0x8029011a),
    TPMAPI_E_INVALID_TCG_LOG_ENTRY = HRESULT(0x8029011b),
}

enum : HRESULT
{
    TPMAPI_E_TCG_SEPARATOR_ABSENT     = HRESULT(0x8029011c),
    TPMAPI_E_TCG_INVALID_DIGEST_ENTRY = HRESULT(0x8029011d),
}

enum HRESULT TPMAPI_E_POLICY_DENIES_OPERATION = HRESULT(0x8029011e);

enum : HRESULT
{
    TPMAPI_E_NV_BITS_NOT_DEFINED = HRESULT(0x8029011f),
    TPMAPI_E_NV_BITS_NOT_READY   = HRESULT(0x80290120),
}

enum HRESULT TPMAPI_E_SEALING_KEY_NOT_AVAILABLE = HRESULT(0x80290121);
enum HRESULT TPMAPI_E_NO_AUTHORIZATION_CHAIN_FOUND = HRESULT(0x80290122);
enum HRESULT TPMAPI_E_SVN_COUNTER_NOT_AVAILABLE = HRESULT(0x80290123);
enum HRESULT TPMAPI_E_OWNER_AUTH_NOT_NULL = HRESULT(0x80290124);
enum HRESULT TPMAPI_E_ENDORSEMENT_AUTH_NOT_NULL = HRESULT(0x80290125);
enum HRESULT TPMAPI_E_AUTHORIZATION_REVOKED = HRESULT(0x80290126);
enum HRESULT TPMAPI_E_MALFORMED_AUTHORIZATION_KEY = HRESULT(0x80290127);
enum HRESULT TPMAPI_E_AUTHORIZING_KEY_NOT_SUPPORTED = HRESULT(0x80290128);
enum HRESULT TPMAPI_E_INVALID_AUTHORIZATION_SIGNATURE = HRESULT(0x80290129);

enum : HRESULT
{
    TPMAPI_E_MALFORMED_AUTHORIZATION_POLICY = HRESULT(0x8029012a),
    TPMAPI_E_MALFORMED_AUTHORIZATION_OTHER  = HRESULT(0x8029012b),
}

enum HRESULT TPMAPI_E_SEALING_KEY_CHANGED = HRESULT(0x8029012c);

enum : HRESULT
{
    TPMAPI_E_INVALID_TPM_VERSION          = HRESULT(0x8029012d),
    TPMAPI_E_INVALID_POLICYAUTH_BLOB_TYPE = HRESULT(0x8029012e),
    TPMAPI_E_INVALID_TAG                  = HRESULT(0x80290130),
    TPMAPI_E_INVALID_STRUCT_SIZE          = HRESULT(0x80290131),
}

enum HRESULT TPMAPI_E_AUTH_CHAIN_ERROR = HRESULT(0x80290132);
enum HRESULT TPMAPI_E_COUNTER_CORRUPTED = HRESULT(0x80290133);
enum HRESULT TPMAPI_E_INVALID_ALGORITHM = HRESULT(0x80290134);
enum HRESULT TBSIMP_E_BUFFER_TOO_SMALL = HRESULT(0x80290200);
enum HRESULT TBSIMP_E_CLEANUP_FAILED = HRESULT(0x80290201);

enum : HRESULT
{
    TBSIMP_E_INVALID_CONTEXT_HANDLE = HRESULT(0x80290202),
    TBSIMP_E_INVALID_CONTEXT_PARAM  = HRESULT(0x80290203),
}

enum : HRESULT
{
    TBSIMP_E_TPM_ERROR         = HRESULT(0x80290204),
    TBSIMP_E_HASH_BAD_KEY      = HRESULT(0x80290205),
    TBSIMP_E_DUPLICATE_VHANDLE = HRESULT(0x80290206),
}

enum : HRESULT
{
    TBSIMP_E_INVALID_OUTPUT_POINTER = HRESULT(0x80290207),
    TBSIMP_E_INVALID_PARAMETER      = HRESULT(0x80290208),
}

enum HRESULT TBSIMP_E_RPC_INIT_FAILED = HRESULT(0x80290209);
enum HRESULT TBSIMP_E_SCHEDULER_NOT_RUNNING = HRESULT(0x8029020a);
enum HRESULT TBSIMP_E_COMMAND_CANCELED = HRESULT(0x8029020b);

enum : HRESULT
{
    TBSIMP_E_OUT_OF_MEMORY      = HRESULT(0x8029020c),
    TBSIMP_E_LIST_NO_MORE_ITEMS = HRESULT(0x8029020d),
    TBSIMP_E_LIST_NOT_FOUND     = HRESULT(0x8029020e),
}

enum : HRESULT
{
    TBSIMP_E_NOT_ENOUGH_SPACE        = HRESULT(0x8029020f),
    TBSIMP_E_NOT_ENOUGH_TPM_CONTEXTS = HRESULT(0x80290210),
}

enum HRESULT TBSIMP_E_COMMAND_FAILED = HRESULT(0x80290211);
enum HRESULT TBSIMP_E_UNKNOWN_ORDINAL = HRESULT(0x80290212);
enum HRESULT TBSIMP_E_RESOURCE_EXPIRED = HRESULT(0x80290213);
enum HRESULT TBSIMP_E_INVALID_RESOURCE = HRESULT(0x80290214);
enum HRESULT TBSIMP_E_NOTHING_TO_UNLOAD = HRESULT(0x80290215);
enum HRESULT TBSIMP_E_HASH_TABLE_FULL = HRESULT(0x80290216);

enum : HRESULT
{
    TBSIMP_E_TOO_MANY_TBS_CONTEXTS = HRESULT(0x80290217),
    TBSIMP_E_TOO_MANY_RESOURCES    = HRESULT(0x80290218),
}

enum HRESULT TBSIMP_E_PPI_NOT_SUPPORTED = HRESULT(0x80290219);
enum HRESULT TBSIMP_E_TPM_INCOMPATIBLE = HRESULT(0x8029021a);
enum HRESULT TBSIMP_E_NO_EVENT_LOG = HRESULT(0x8029021b);

enum : HRESULT
{
    TPM_E_PPI_ACPI_FAILURE    = HRESULT(0x80290300),
    TPM_E_PPI_USER_ABORT      = HRESULT(0x80290301),
    TPM_E_PPI_BIOS_FAILURE    = HRESULT(0x80290302),
    TPM_E_PPI_NOT_SUPPORTED   = HRESULT(0x80290303),
    TPM_E_PPI_BLOCKED_IN_BIOS = HRESULT(0x80290304),
}

enum : HRESULT
{
    TPM_E_PCP_ERROR_MASK       = HRESULT(0x80290400),
    TPM_E_PCP_DEVICE_NOT_READY = HRESULT(0x80290401),
}

enum : HRESULT
{
    TPM_E_PCP_INVALID_HANDLE    = HRESULT(0x80290402),
    TPM_E_PCP_INVALID_PARAMETER = HRESULT(0x80290403),
}

enum HRESULT TPM_E_PCP_FLAG_NOT_SUPPORTED = HRESULT(0x80290404);

enum : HRESULT
{
    TPM_E_PCP_NOT_SUPPORTED    = HRESULT(0x80290405),
    TPM_E_PCP_BUFFER_TOO_SMALL = HRESULT(0x80290406),
}

enum : HRESULT
{
    TPM_E_PCP_INTERNAL_ERROR         = HRESULT(0x80290407),
    TPM_E_PCP_AUTHENTICATION_FAILED  = HRESULT(0x80290408),
    TPM_E_PCP_AUTHENTICATION_IGNORED = HRESULT(0x80290409),
}

enum : HRESULT
{
    TPM_E_PCP_POLICY_NOT_FOUND  = HRESULT(0x8029040a),
    TPM_E_PCP_PROFILE_NOT_FOUND = HRESULT(0x8029040b),
}

enum HRESULT TPM_E_PCP_VALIDATION_FAILED = HRESULT(0x8029040c);
enum HRESULT TPM_E_PCP_WRONG_PARENT = HRESULT(0x8029040e);
enum HRESULT TPM_E_KEY_NOT_LOADED = HRESULT(0x8029040f);
enum HRESULT TPM_E_NO_KEY_CERTIFICATION = HRESULT(0x80290410);
enum HRESULT TPM_E_KEY_NOT_FINALIZED = HRESULT(0x80290411);
enum HRESULT TPM_E_ATTESTATION_CHALLENGE_NOT_SET = HRESULT(0x80290412);
enum HRESULT TPM_E_NOT_PCR_BOUND = HRESULT(0x80290413);
enum HRESULT TPM_E_KEY_ALREADY_FINALIZED = HRESULT(0x80290414);

enum : HRESULT
{
    TPM_E_KEY_USAGE_POLICY_NOT_SUPPORTED = HRESULT(0x80290415),
    TPM_E_KEY_USAGE_POLICY_INVALID       = HRESULT(0x80290416),
}

enum HRESULT TPM_E_SOFT_KEY_ERROR = HRESULT(0x80290417);
enum HRESULT TPM_E_KEY_NOT_AUTHENTICATED = HRESULT(0x80290418);
enum HRESULT TPM_E_PCP_KEY_NOT_AIK = HRESULT(0x80290419);
enum HRESULT TPM_E_KEY_NOT_SIGNING_KEY = HRESULT(0x8029041a);
enum HRESULT TPM_E_LOCKED_OUT = HRESULT(0x8029041b);
enum HRESULT TPM_E_CLAIM_TYPE_NOT_SUPPORTED = HRESULT(0x8029041c);
enum HRESULT TPM_E_VERSION_NOT_SUPPORTED = HRESULT(0x8029041d);
enum HRESULT TPM_E_BUFFER_LENGTH_MISMATCH = HRESULT(0x8029041e);
enum HRESULT TPM_E_PCP_IFX_RSA_KEY_CREATION_BLOCKED = HRESULT(0x8029041f);

enum : HRESULT
{
    TPM_E_PCP_TICKET_MISSING           = HRESULT(0x80290420),
    TPM_E_PCP_RAW_POLICY_NOT_SUPPORTED = HRESULT(0x80290421),
}

enum HRESULT TPM_E_PCP_KEY_HANDLE_INVALIDATED = HRESULT(0x80290422);
enum HRESULT TPM_E_PCP_UNSUPPORTED_PSS_SALT = HRESULT(0x40290423);

enum : HRESULT
{
    TPM_E_PCP_PLATFORM_CLAIM_MAY_BE_OUTDATED = HRESULT(0x40290424),
    TPM_E_PCP_PLATFORM_CLAIM_OUTDATED        = HRESULT(0x40290425),
    TPM_E_PCP_PLATFORM_CLAIM_REBOOT          = HRESULT(0x40290426),
}

enum HRESULT TPM_E_ZERO_EXHAUST_ENABLED = HRESULT(0x80290500);
enum HRESULT DRTM_E_ENVIRONMENT_UNSAFE = HRESULT(0x80290501);
enum HRESULT DRTM_E_NO_DIRECT_AUTH_FOR_CURRENT_MLE = HRESULT(0x80290502);
enum HRESULT TPM_E_PROVISIONING_INCOMPLETE = HRESULT(0x80290600);
enum HRESULT TPM_E_INVALID_OWNER_AUTH = HRESULT(0x80290601);
enum HRESULT TPM_E_TOO_MUCH_DATA = HRESULT(0x80290602);
enum HRESULT TPM_E_TPM_GENERATED_EPS = HRESULT(0x80290603);

enum : HRESULT
{
    PLA_E_DCS_NOT_FOUND = HRESULT(0x80300002),
    PLA_E_DCS_IN_USE    = HRESULT(0x803000aa),
}

enum HRESULT PLA_E_TOO_MANY_FOLDERS = HRESULT(0x80300045);
enum HRESULT PLA_E_NO_MIN_DISK = HRESULT(0x80300070);
enum HRESULT PLA_E_DCS_ALREADY_EXISTS = HRESULT(0x803000b7);
enum HRESULT PLA_S_PROPERTY_IGNORED = HRESULT(0x00300100);
enum HRESULT PLA_E_PROPERTY_CONFLICT = HRESULT(0x80300101);
enum HRESULT PLA_E_DCS_SINGLETON_REQUIRED = HRESULT(0x80300102);
enum HRESULT PLA_E_CREDENTIALS_REQUIRED = HRESULT(0x80300103);
enum HRESULT PLA_E_DCS_NOT_RUNNING = HRESULT(0x80300104);
enum HRESULT PLA_E_CONFLICT_INCL_EXCL_API = HRESULT(0x80300105);
enum HRESULT PLA_E_NETWORK_EXE_NOT_VALID = HRESULT(0x80300106);
enum HRESULT PLA_E_EXE_ALREADY_CONFIGURED = HRESULT(0x80300107);
enum HRESULT PLA_E_EXE_PATH_NOT_VALID = HRESULT(0x80300108);
enum HRESULT PLA_E_DC_ALREADY_EXISTS = HRESULT(0x80300109);
enum HRESULT PLA_E_DCS_START_WAIT_TIMEOUT = HRESULT(0x8030010a);
enum HRESULT PLA_E_DC_START_WAIT_TIMEOUT = HRESULT(0x8030010b);
enum HRESULT PLA_E_REPORT_WAIT_TIMEOUT = HRESULT(0x8030010c);
enum HRESULT PLA_E_NO_DUPLICATES = HRESULT(0x8030010d);
enum HRESULT PLA_E_EXE_FULL_PATH_REQUIRED = HRESULT(0x8030010e);
enum HRESULT PLA_E_INVALID_SESSION_NAME = HRESULT(0x8030010f);
enum HRESULT PLA_E_PLA_CHANNEL_NOT_ENABLED = HRESULT(0x80300110);
enum HRESULT PLA_E_TASKSCHED_CHANNEL_NOT_ENABLED = HRESULT(0x80300111);
enum HRESULT PLA_E_RULES_MANAGER_FAILED = HRESULT(0x80300112);
enum HRESULT PLA_E_CABAPI_FAILURE = HRESULT(0x80300113);
enum HRESULT FVE_E_LOCKED_VOLUME = HRESULT(0x80310000);

enum : HRESULT
{
    FVE_E_NOT_ENCRYPTED        = HRESULT(0x80310001),
    FVE_E_NO_TPM_BIOS          = HRESULT(0x80310002),
    FVE_E_NO_MBR_METRIC        = HRESULT(0x80310003),
    FVE_E_NO_BOOTSECTOR_METRIC = HRESULT(0x80310004),
    FVE_E_NO_BOOTMGR_METRIC    = HRESULT(0x80310005),
}

enum HRESULT FVE_E_WRONG_BOOTMGR = HRESULT(0x80310006);
enum HRESULT FVE_E_SECURE_KEY_REQUIRED = HRESULT(0x80310007);
enum HRESULT FVE_E_NOT_ACTIVATED = HRESULT(0x80310008);
enum HRESULT FVE_E_ACTION_NOT_ALLOWED = HRESULT(0x80310009);
enum HRESULT FVE_E_AD_SCHEMA_NOT_INSTALLED = HRESULT(0x8031000a);

enum : HRESULT
{
    FVE_E_AD_INVALID_DATATYPE = HRESULT(0x8031000b),
    FVE_E_AD_INVALID_DATASIZE = HRESULT(0x8031000c),
}

enum : HRESULT
{
    FVE_E_AD_NO_VALUES      = HRESULT(0x8031000d),
    FVE_E_AD_ATTR_NOT_SET   = HRESULT(0x8031000e),
    FVE_E_AD_GUID_NOT_FOUND = HRESULT(0x8031000f),
}

enum HRESULT FVE_E_BAD_INFORMATION = HRESULT(0x80310010);
enum HRESULT FVE_E_TOO_SMALL = HRESULT(0x80310011);
enum HRESULT FVE_E_SYSTEM_VOLUME = HRESULT(0x80310012);
enum HRESULT FVE_E_FAILED_WRONG_FS = HRESULT(0x80310013);
enum HRESULT FVE_E_BAD_PARTITION_SIZE = HRESULT(0x80310014);
enum HRESULT FVE_E_NOT_SUPPORTED = HRESULT(0x80310015);

enum : HRESULT
{
    FVE_E_BAD_DATA         = HRESULT(0x80310016),
    FVE_E_VOLUME_NOT_BOUND = HRESULT(0x80310017),
}

enum HRESULT FVE_E_TPM_NOT_OWNED = HRESULT(0x80310018);
enum HRESULT FVE_E_NOT_DATA_VOLUME = HRESULT(0x80310019);
enum HRESULT FVE_E_AD_INSUFFICIENT_BUFFER = HRESULT(0x8031001a);

enum : HRESULT
{
    FVE_E_CONV_READ  = HRESULT(0x8031001b),
    FVE_E_CONV_WRITE = HRESULT(0x8031001c),
}

enum HRESULT FVE_E_KEY_REQUIRED = HRESULT(0x8031001d);
enum HRESULT FVE_E_CLUSTERING_NOT_SUPPORTED = HRESULT(0x8031001e);
enum HRESULT FVE_E_VOLUME_BOUND_ALREADY = HRESULT(0x8031001f);
enum HRESULT FVE_E_OS_NOT_PROTECTED = HRESULT(0x80310020);
enum HRESULT FVE_E_PROTECTION_DISABLED = HRESULT(0x80310021);
enum HRESULT FVE_E_RECOVERY_KEY_REQUIRED = HRESULT(0x80310022);
enum HRESULT FVE_E_FOREIGN_VOLUME = HRESULT(0x80310023);
enum HRESULT FVE_E_OVERLAPPED_UPDATE = HRESULT(0x80310024);
enum HRESULT FVE_E_TPM_SRK_AUTH_NOT_ZERO = HRESULT(0x80310025);

enum : HRESULT
{
    FVE_E_FAILED_SECTOR_SIZE    = HRESULT(0x80310026),
    FVE_E_FAILED_AUTHENTICATION = HRESULT(0x80310027),
}

enum HRESULT FVE_E_NOT_OS_VOLUME = HRESULT(0x80310028);
enum HRESULT FVE_E_AUTOUNLOCK_ENABLED = HRESULT(0x80310029);

enum : HRESULT
{
    FVE_E_WRONG_BOOTSECTOR = HRESULT(0x8031002a),
    FVE_E_WRONG_SYSTEM_FS  = HRESULT(0x8031002b),
}

enum HRESULT FVE_E_POLICY_PASSWORD_REQUIRED = HRESULT(0x8031002c);

enum : HRESULT
{
    FVE_E_CANNOT_SET_FVEK_ENCRYPTED = HRESULT(0x8031002d),
    FVE_E_CANNOT_ENCRYPT_NO_KEY     = HRESULT(0x8031002e),
}

enum HRESULT FVE_E_BOOTABLE_CDDVD = HRESULT(0x80310030);
enum HRESULT FVE_E_PROTECTOR_EXISTS = HRESULT(0x80310031);
enum HRESULT FVE_E_RELATIVE_PATH = HRESULT(0x80310032);
enum HRESULT FVE_E_PROTECTOR_NOT_FOUND = HRESULT(0x80310033);

enum : HRESULT
{
    FVE_E_INVALID_KEY_FORMAT      = HRESULT(0x80310034),
    FVE_E_INVALID_PASSWORD_FORMAT = HRESULT(0x80310035),
}

enum : HRESULT
{
    FVE_E_FIPS_RNG_CHECK_FAILED             = HRESULT(0x80310036),
    FVE_E_FIPS_PREVENTS_RECOVERY_PASSWORD   = HRESULT(0x80310037),
    FVE_E_FIPS_PREVENTS_EXTERNAL_KEY_EXPORT = HRESULT(0x80310038),
}

enum HRESULT FVE_E_NOT_DECRYPTED = HRESULT(0x80310039);
enum HRESULT FVE_E_INVALID_PROTECTOR_TYPE = HRESULT(0x8031003a);
enum HRESULT FVE_E_NO_PROTECTORS_TO_TEST = HRESULT(0x8031003b);

enum : HRESULT
{
    FVE_E_KEYFILE_NOT_FOUND = HRESULT(0x8031003c),
    FVE_E_KEYFILE_INVALID   = HRESULT(0x8031003d),
    FVE_E_KEYFILE_NO_VMK    = HRESULT(0x8031003e),
}

enum HRESULT FVE_E_TPM_DISABLED = HRESULT(0x8031003f);
enum HRESULT FVE_E_NOT_ALLOWED_IN_SAFE_MODE = HRESULT(0x80310040);

enum : HRESULT
{
    FVE_E_TPM_INVALID_PCR = HRESULT(0x80310041),
    FVE_E_TPM_NO_VMK      = HRESULT(0x80310042),
}

enum HRESULT FVE_E_PIN_INVALID = HRESULT(0x80310043);

enum : HRESULT
{
    FVE_E_AUTH_INVALID_APPLICATION = HRESULT(0x80310044),
    FVE_E_AUTH_INVALID_CONFIG      = HRESULT(0x80310045),
}

enum HRESULT FVE_E_FIPS_DISABLE_PROTECTION_NOT_ALLOWED = HRESULT(0x80310046);
enum HRESULT FVE_E_FS_NOT_EXTENDED = HRESULT(0x80310047);
enum HRESULT FVE_E_FIRMWARE_TYPE_NOT_SUPPORTED = HRESULT(0x80310048);

enum : HRESULT
{
    FVE_E_NO_LICENSE   = HRESULT(0x80310049),
    FVE_E_NOT_ON_STACK = HRESULT(0x8031004a),
}

enum HRESULT FVE_E_FS_MOUNTED = HRESULT(0x8031004b);
enum HRESULT FVE_E_TOKEN_NOT_IMPERSONATED = HRESULT(0x8031004c);
enum HRESULT FVE_E_DRY_RUN_FAILED = HRESULT(0x8031004d);
enum HRESULT FVE_E_REBOOT_REQUIRED = HRESULT(0x8031004e);
enum HRESULT FVE_E_DEBUGGER_ENABLED = HRESULT(0x8031004f);

enum : HRESULT
{
    FVE_E_RAW_ACCESS  = HRESULT(0x80310050),
    FVE_E_RAW_BLOCKED = HRESULT(0x80310051),
}

enum HRESULT FVE_E_BCD_APPLICATIONS_PATH_INCORRECT = HRESULT(0x80310052);
enum HRESULT FVE_E_NOT_ALLOWED_IN_VERSION = HRESULT(0x80310053);
enum HRESULT FVE_E_NO_AUTOUNLOCK_MASTER_KEY = HRESULT(0x80310054);
enum HRESULT FVE_E_MOR_FAILED = HRESULT(0x80310055);
enum HRESULT FVE_E_HIDDEN_VOLUME = HRESULT(0x80310056);
enum HRESULT FVE_E_TRANSIENT_STATE = HRESULT(0x80310057);
enum HRESULT FVE_E_PUBKEY_NOT_ALLOWED = HRESULT(0x80310058);
enum HRESULT FVE_E_VOLUME_HANDLE_OPEN = HRESULT(0x80310059);
enum HRESULT FVE_E_NO_FEATURE_LICENSE = HRESULT(0x8031005a);
enum HRESULT FVE_E_INVALID_STARTUP_OPTIONS = HRESULT(0x8031005b);

enum : HRESULT
{
    FVE_E_POLICY_RECOVERY_PASSWORD_NOT_ALLOWED = HRESULT(0x8031005c),
    FVE_E_POLICY_RECOVERY_PASSWORD_REQUIRED    = HRESULT(0x8031005d),
    FVE_E_POLICY_RECOVERY_KEY_NOT_ALLOWED      = HRESULT(0x8031005e),
    FVE_E_POLICY_RECOVERY_KEY_REQUIRED         = HRESULT(0x8031005f),
}

enum : HRESULT
{
    FVE_E_POLICY_STARTUP_PIN_NOT_ALLOWED     = HRESULT(0x80310060),
    FVE_E_POLICY_STARTUP_PIN_REQUIRED        = HRESULT(0x80310061),
    FVE_E_POLICY_STARTUP_KEY_NOT_ALLOWED     = HRESULT(0x80310062),
    FVE_E_POLICY_STARTUP_KEY_REQUIRED        = HRESULT(0x80310063),
    FVE_E_POLICY_STARTUP_PIN_KEY_NOT_ALLOWED = HRESULT(0x80310064),
    FVE_E_POLICY_STARTUP_PIN_KEY_REQUIRED    = HRESULT(0x80310065),
    FVE_E_POLICY_STARTUP_TPM_NOT_ALLOWED     = HRESULT(0x80310066),
    FVE_E_POLICY_STARTUP_TPM_REQUIRED        = HRESULT(0x80310067),
}

enum HRESULT FVE_E_POLICY_INVALID_PIN_LENGTH = HRESULT(0x80310068);
enum HRESULT FVE_E_KEY_PROTECTOR_NOT_SUPPORTED = HRESULT(0x80310069);

enum : HRESULT
{
    FVE_E_POLICY_PASSPHRASE_NOT_ALLOWED = HRESULT(0x8031006a),
    FVE_E_POLICY_PASSPHRASE_REQUIRED    = HRESULT(0x8031006b),
}

enum HRESULT FVE_E_FIPS_PREVENTS_PASSPHRASE = HRESULT(0x8031006c);
enum HRESULT FVE_E_OS_VOLUME_PASSPHRASE_NOT_ALLOWED = HRESULT(0x8031006d);
enum HRESULT FVE_E_INVALID_BITLOCKER_OID = HRESULT(0x8031006e);
enum HRESULT FVE_E_VOLUME_TOO_SMALL = HRESULT(0x8031006f);

enum : HRESULT
{
    FVE_E_DV_NOT_SUPPORTED_ON_FS = HRESULT(0x80310070),
    FVE_E_DV_NOT_ALLOWED_BY_GP   = HRESULT(0x80310071),
}

enum : HRESULT
{
    FVE_E_POLICY_USER_CERTIFICATE_NOT_ALLOWED              = HRESULT(0x80310072),
    FVE_E_POLICY_USER_CERTIFICATE_REQUIRED                 = HRESULT(0x80310073),
    FVE_E_POLICY_USER_CERT_MUST_BE_HW                      = HRESULT(0x80310074),
    FVE_E_POLICY_USER_CONFIGURE_FDV_AUTOUNLOCK_NOT_ALLOWED = HRESULT(0x80310075),
    FVE_E_POLICY_USER_CONFIGURE_RDV_AUTOUNLOCK_NOT_ALLOWED = HRESULT(0x80310076),
    FVE_E_POLICY_USER_CONFIGURE_RDV_NOT_ALLOWED            = HRESULT(0x80310077),
    FVE_E_POLICY_USER_ENABLE_RDV_NOT_ALLOWED               = HRESULT(0x80310078),
    FVE_E_POLICY_USER_DISABLE_RDV_NOT_ALLOWED              = HRESULT(0x80310079),
}

enum HRESULT FVE_E_POLICY_INVALID_PASSPHRASE_LENGTH = HRESULT(0x80310080);
enum HRESULT FVE_E_POLICY_PASSPHRASE_TOO_SIMPLE = HRESULT(0x80310081);
enum HRESULT FVE_E_RECOVERY_PARTITION = HRESULT(0x80310082);

enum : HRESULT
{
    FVE_E_POLICY_CONFLICT_FDV_RK_OFF_AUK_ON = HRESULT(0x80310083),
    FVE_E_POLICY_CONFLICT_RDV_RK_OFF_AUK_ON = HRESULT(0x80310084),
}

enum HRESULT FVE_E_NON_BITLOCKER_OID = HRESULT(0x80310085);
enum HRESULT FVE_E_POLICY_PROHIBITS_SELFSIGNED = HRESULT(0x80310086);
enum HRESULT FVE_E_POLICY_CONFLICT_RO_AND_STARTUP_KEY_REQUIRED = HRESULT(0x80310087);
enum HRESULT FVE_E_CONV_RECOVERY_FAILED = HRESULT(0x80310088);
enum HRESULT FVE_E_VIRTUALIZED_SPACE_TOO_BIG = HRESULT(0x80310089);

enum : HRESULT
{
    FVE_E_POLICY_CONFLICT_OSV_RP_OFF_ADB_ON = HRESULT(0x80310090),
    FVE_E_POLICY_CONFLICT_FDV_RP_OFF_ADB_ON = HRESULT(0x80310091),
    FVE_E_POLICY_CONFLICT_RDV_RP_OFF_ADB_ON = HRESULT(0x80310092),
}

enum HRESULT FVE_E_NON_BITLOCKER_KU = HRESULT(0x80310093);
enum HRESULT FVE_E_PRIVATEKEY_AUTH_FAILED = HRESULT(0x80310094);
enum HRESULT FVE_E_REMOVAL_OF_DRA_FAILED = HRESULT(0x80310095);
enum HRESULT FVE_E_OPERATION_NOT_SUPPORTED_ON_VISTA_VOLUME = HRESULT(0x80310096);
enum HRESULT FVE_E_CANT_LOCK_AUTOUNLOCK_ENABLED_VOLUME = HRESULT(0x80310097);
enum HRESULT FVE_E_FIPS_HASH_KDF_NOT_ALLOWED = HRESULT(0x80310098);
enum HRESULT FVE_E_ENH_PIN_INVALID = HRESULT(0x80310099);

enum : HRESULT
{
    FVE_E_INVALID_PIN_CHARS  = HRESULT(0x8031009a),
    FVE_E_INVALID_DATUM_TYPE = HRESULT(0x8031009b),
}

enum : HRESULT
{
    FVE_E_EFI_ONLY           = HRESULT(0x8031009c),
    FVE_E_MULTIPLE_NKP_CERTS = HRESULT(0x8031009d),
}

enum HRESULT FVE_E_REMOVAL_OF_NKP_FAILED = HRESULT(0x8031009e);
enum HRESULT FVE_E_INVALID_NKP_CERT = HRESULT(0x8031009f);
enum HRESULT FVE_E_NO_EXISTING_PIN = HRESULT(0x803100a0);
enum HRESULT FVE_E_PROTECTOR_CHANGE_PIN_MISMATCH = HRESULT(0x803100a1);
enum HRESULT FVE_E_PIN_PROTECTOR_CHANGE_BY_STD_USER_DISALLOWED = HRESULT(0x803100a2);
enum HRESULT FVE_E_PROTECTOR_CHANGE_MAX_PIN_CHANGE_ATTEMPTS_REACHED = HRESULT(0x803100a3);
enum HRESULT FVE_E_POLICY_PASSPHRASE_REQUIRES_ASCII = HRESULT(0x803100a4);
enum HRESULT FVE_E_FULL_ENCRYPTION_NOT_ALLOWED_ON_TP_STORAGE = HRESULT(0x803100a5);
enum HRESULT FVE_E_WIPE_NOT_ALLOWED_ON_TP_STORAGE = HRESULT(0x803100a6);
enum HRESULT FVE_E_KEY_LENGTH_NOT_SUPPORTED_BY_EDRIVE = HRESULT(0x803100a7);
enum HRESULT FVE_E_NO_EXISTING_PASSPHRASE = HRESULT(0x803100a8);
enum HRESULT FVE_E_PROTECTOR_CHANGE_PASSPHRASE_MISMATCH = HRESULT(0x803100a9);
enum HRESULT FVE_E_PASSPHRASE_TOO_LONG = HRESULT(0x803100aa);
enum HRESULT FVE_E_NO_PASSPHRASE_WITH_TPM = HRESULT(0x803100ab);
enum HRESULT FVE_E_NO_TPM_WITH_PASSPHRASE = HRESULT(0x803100ac);

enum : HRESULT
{
    FVE_E_NOT_ALLOWED_ON_CSV_STACK = HRESULT(0x803100ad),
    FVE_E_NOT_ALLOWED_ON_CLUSTER   = HRESULT(0x803100ae),
}

enum : HRESULT
{
    FVE_E_EDRIVE_NO_FAILOVER_TO_SW   = HRESULT(0x803100af),
    FVE_E_EDRIVE_BAND_IN_USE         = HRESULT(0x803100b0),
    FVE_E_EDRIVE_DISALLOWED_BY_GP    = HRESULT(0x803100b1),
    FVE_E_EDRIVE_INCOMPATIBLE_VOLUME = HRESULT(0x803100b2),
}

enum HRESULT FVE_E_NOT_ALLOWED_TO_UPGRADE_WHILE_CONVERTING = HRESULT(0x803100b3);
enum HRESULT FVE_E_EDRIVE_DV_NOT_SUPPORTED = HRESULT(0x803100b4);

enum : HRESULT
{
    FVE_E_NO_PREBOOT_KEYBOARD_DETECTED          = HRESULT(0x803100b5),
    FVE_E_NO_PREBOOT_KEYBOARD_OR_WINRE_DETECTED = HRESULT(0x803100b6),
}

enum : HRESULT
{
    FVE_E_POLICY_REQUIRES_STARTUP_PIN_ON_TOUCH_DEVICE       = HRESULT(0x803100b7),
    FVE_E_POLICY_REQUIRES_RECOVERY_PASSWORD_ON_TOUCH_DEVICE = HRESULT(0x803100b8),
}

enum HRESULT FVE_E_WIPE_CANCEL_NOT_APPLICABLE = HRESULT(0x803100b9);

enum : HRESULT
{
    FVE_E_SECUREBOOT_DISABLED              = HRESULT(0x803100ba),
    FVE_E_SECUREBOOT_CONFIGURATION_INVALID = HRESULT(0x803100bb),
}

enum HRESULT FVE_E_EDRIVE_DRY_RUN_FAILED = HRESULT(0x803100bc);
enum HRESULT FVE_E_SHADOW_COPY_PRESENT = HRESULT(0x803100bd);
enum HRESULT FVE_E_POLICY_INVALID_ENHANCED_BCD_SETTINGS = HRESULT(0x803100be);
enum HRESULT FVE_E_EDRIVE_INCOMPATIBLE_FIRMWARE = HRESULT(0x803100bf);
enum HRESULT FVE_E_PROTECTOR_CHANGE_MAX_PASSPHRASE_CHANGE_ATTEMPTS_REACHED = HRESULT(0x803100c0);
enum HRESULT FVE_E_PASSPHRASE_PROTECTOR_CHANGE_BY_STD_USER_DISALLOWED = HRESULT(0x803100c1);

enum : HRESULT
{
    FVE_E_LIVEID_ACCOUNT_SUSPENDED = HRESULT(0x803100c2),
    FVE_E_LIVEID_ACCOUNT_BLOCKED   = HRESULT(0x803100c3),
}

enum HRESULT FVE_E_NOT_PROVISIONED_ON_ALL_VOLUMES = HRESULT(0x803100c4);
enum HRESULT FVE_E_DE_FIXED_DATA_NOT_SUPPORTED = HRESULT(0x803100c5);
enum HRESULT FVE_E_DE_HARDWARE_NOT_COMPLIANT = HRESULT(0x803100c6);
enum HRESULT FVE_E_DE_WINRE_NOT_CONFIGURED = HRESULT(0x803100c7);
enum HRESULT FVE_E_DE_PROTECTION_SUSPENDED = HRESULT(0x803100c8);
enum HRESULT FVE_E_DE_OS_VOLUME_NOT_PROTECTED = HRESULT(0x803100c9);
enum HRESULT FVE_E_DE_DEVICE_LOCKEDOUT = HRESULT(0x803100ca);
enum HRESULT FVE_E_DE_PROTECTION_NOT_YET_ENABLED = HRESULT(0x803100cb);
enum HRESULT FVE_E_INVALID_PIN_CHARS_DETAILED = HRESULT(0x803100cc);
enum HRESULT FVE_E_DEVICE_LOCKOUT_COUNTER_UNAVAILABLE = HRESULT(0x803100cd);
enum HRESULT FVE_E_DEVICELOCKOUT_COUNTER_MISMATCH = HRESULT(0x803100ce);
enum HRESULT FVE_E_BUFFER_TOO_LARGE = HRESULT(0x803100cf);
enum HRESULT FVE_E_NO_SUCH_CAPABILITY_ON_TARGET = HRESULT(0x803100d0);
enum HRESULT FVE_E_DE_PREVENTED_FOR_OS = HRESULT(0x803100d1);

enum : HRESULT
{
    FVE_E_DE_VOLUME_OPTED_OUT     = HRESULT(0x803100d2),
    FVE_E_DE_VOLUME_NOT_SUPPORTED = HRESULT(0x803100d3),
}

enum HRESULT FVE_E_EOW_NOT_SUPPORTED_IN_VERSION = HRESULT(0x803100d4);
enum HRESULT FVE_E_ADBACKUP_NOT_ENABLED = HRESULT(0x803100d5);
enum HRESULT FVE_E_VOLUME_EXTEND_PREVENTS_EOW_DECRYPT = HRESULT(0x803100d6);
enum HRESULT FVE_E_NOT_DE_VOLUME = HRESULT(0x803100d7);
enum HRESULT FVE_E_PROTECTION_CANNOT_BE_DISABLED = HRESULT(0x803100d8);
enum HRESULT FVE_E_OSV_KSR_NOT_ALLOWED = HRESULT(0x803100d9);

enum : HRESULT
{
    FVE_E_AD_BACKUP_REQUIRED_POLICY_NOT_SET_OS_DRIVE        = HRESULT(0x803100da),
    FVE_E_AD_BACKUP_REQUIRED_POLICY_NOT_SET_FIXED_DRIVE     = HRESULT(0x803100db),
    FVE_E_AD_BACKUP_REQUIRED_POLICY_NOT_SET_REMOVABLE_DRIVE = HRESULT(0x803100dc),
}

enum HRESULT FVE_E_KEY_ROTATION_NOT_SUPPORTED = HRESULT(0x803100dd);
enum HRESULT FVE_E_EXECUTE_REQUEST_SENT_TOO_SOON = HRESULT(0x803100de);
enum HRESULT FVE_E_KEY_ROTATION_NOT_ENABLED = HRESULT(0x803100df);
enum HRESULT FVE_E_DEVICE_NOT_JOINED_AAD = HRESULT(0x803100e0);
enum HRESULT FVE_E_AAD_ENDPOINT_BUSY = HRESULT(0x803100e1);
enum HRESULT FVE_E_INVALID_NBP_CERT = HRESULT(0x803100e2);
enum HRESULT FVE_E_EDRIVE_BAND_ENUMERATION_FAILED = HRESULT(0x803100e3);
enum HRESULT FVE_E_POLICY_ON_RDV_EXCLUSION_LIST = HRESULT(0x803100e4);
enum HRESULT FVE_E_PREDICTED_TPM_PROTECTOR_NOT_SUPPORTED = HRESULT(0x803100e5);
enum HRESULT FVE_E_SETUP_TPM_CALLBACK_NOT_SUPPORTED = HRESULT(0x803100e6);
enum HRESULT FVE_E_TPM_CONTEXT_SETUP_NOT_SUPPORTED = HRESULT(0x803100e7);
enum HRESULT FVE_E_UPDATE_INVALID_CONFIG = HRESULT(0x803100e8);

enum : HRESULT
{
    FVE_E_AAD_SERVER_FAIL_RETRY_AFTER_AAD = HRESULT(0x803100e9),
    FVE_E_AAD_SERVER_FAIL_BACKOFF_AAD     = HRESULT(0x803100ea),
}

enum HRESULT FVE_E_DATASET_FULL = HRESULT(0x803100eb);
enum HRESULT FVE_E_METADATA_FULL = HRESULT(0x803100ec);
enum HRESULT FVE_E_DISCOVERY_VOLUME_NOT_SUPPORTED = HRESULT(0x803100ed);
enum HRESULT FVE_E_EXCEED_LIMIT_RP = HRESULT(0x803100ee);
enum HRESULT FVE_E_NO_BACKUP_ACCOUNT = HRESULT(0x803100ef);
enum HRESULT FVE_E_SUSPEND_PROTECTION_NOT_ALLOWED = HRESULT(0x803100f0);
enum HRESULT FVE_E_CANNOT_PREDICT_PCR7 = HRESULT(0x803100f1);

enum : HRESULT
{
    FVE_E_ENTRY_ALREADY_EXISTS = HRESULT(0x803100f2),
    FVE_E_ENTRY_NOT_FOUND      = HRESULT(0x803100f3),
}

enum HRESULT FVE_E_DATUM_PARTIALLY_INVALID = HRESULT(0x803100f4);
enum HRESULT FVE_E_DATASET_TPM_DATUMS_INCONSISTENT = HRESULT(0x803100f5);

enum : HRESULT
{
    FVE_E_SECURE_BOOT_BINDINGS_OUT_OF_SYNC     = HRESULT(0x803100f6),
    FVE_E_SECURE_BOOT_BINDING_DATA_OUT_OF_SYNC = HRESULT(0x803100f7),
}

enum HRESULT FVE_E_ORPHANED_TPM_BINDING_DATUM = HRESULT(0x803100f8);
enum HRESULT FVE_E_BAD_TPM_DATUM_ASSOCIATION = HRESULT(0x803100f9);
enum HRESULT FVE_E_FINAL_TPM_PCR_VALUES_MATCH = HRESULT(0x803100fa);
enum HRESULT FVE_E_MATCHING_PCRS_TPM_FAILURE = HRESULT(0x803100fb);
enum HRESULT FVE_E_BACKUP_CACHE_NOT_ALLOCATED = HRESULT(0x803100fc);
enum HRESULT FVE_E_MSA_BACKUP_CACHE_NOT_ALLOCATED = HRESULT(0x803100fd);
enum HRESULT FVE_E_AD_BACKUP_CACHE_NOT_ALLOCATED = HRESULT(0x803100fe);
enum HRESULT FVE_E_GENERAL_TPM_FAILURE = HRESULT(0x803100ff);
enum HRESULT FVE_E_TPM_NONEXISTENT = HRESULT(0x80310100);
enum HRESULT FVE_E_NO_PCR_BOOT_LOCK_BOUNDARY = HRESULT(0xc0310101);
enum HRESULT FVE_E_PCR_BOOT_LOCK_BOUNDARY = HRESULT(0xc0310102);
enum HRESULT FVE_E_FW_UPDATE_TPM_BINDINGS_NOT_REFRESHED = HRESULT(0xc0310103);
enum HRESULT FVE_E_EXCEED_MAX_LIMIT_RP_IN_MEID = HRESULT(0xc0310104);
enum HRESULT FVE_E_INVALID_TPM_BINDING_CONFIGURATION = HRESULT(0xc0310105);
enum HRESULT FVE_E_TOO_MANY_TPM_BINDINGS = HRESULT(0xc0310106);
enum HRESULT FVE_E_TPM_BINDING_ASSOCIATION_FAILURE = HRESULT(0xc0310107);
enum HRESULT FVE_E_ORPHANED_PCR_DIGEST_DATUM = HRESULT(0xc0310108);
enum HRESULT FVE_E_HW_ACCELERATED_ENCRYPTION_NOT_ALLOWED = HRESULT(0xc0310109);
enum HRESULT FVE_E_NO_MATCHING_TPM_BINDINGS = HRESULT(0xc031010a);
enum HRESULT FVE_E_TPMPV2_USED_FAILURE = HRESULT(0xc031010b);
enum HRESULT FVE_E_NO_TPM_BINDINGS = HRESULT(0xc031010c);

enum : HRESULT
{
    FVE_E_FW_UPDATE_PCRS_BLOCK        = HRESULT(0xc031010e),
    FVE_E_FW_UPDATE_PCRS_NOT_EXCLUDED = HRESULT(0xc031010f),
}

enum HRESULT FVE_E_DEVICE_NOT_JOINED = HRESULT(0x80310110);

enum : HRESULT
{
    FVE_E_AAD_SERVER_FAIL_RETRY_AFTER = HRESULT(0x80310111),
    FVE_E_AAD_SERVER_FAIL_BACKOFF     = HRESULT(0x80310112),
}

enum HRESULT FVE_E_FAILED_TO_UNWRAP_HW_WRAPPED_KEY = HRESULT(0xc0310113);

enum : HRESULT
{
    FVE_E_HARDWARE_CRYPTO_ACCELERATOR_NOT_FIPS_COMPLIANT = HRESULT(0xc0310114),
    FVE_E_HARDWARE_CRYPTO_KEY_MANAGER_NOT_FIPS_COMPLIANT = HRESULT(0xc0310115),
}

enum HRESULT FVE_E_TPM_PCRS_DO_NOT_MATCH_LOG = HRESULT(0xc0310116);
enum HRESULT FWP_E_CALLOUT_NOT_FOUND = HRESULT(0x80320001);
enum HRESULT FWP_E_CONDITION_NOT_FOUND = HRESULT(0x80320002);
enum HRESULT FWP_E_FILTER_NOT_FOUND = HRESULT(0x80320003);
enum HRESULT FWP_E_LAYER_NOT_FOUND = HRESULT(0x80320004);

enum : HRESULT
{
    FWP_E_PROVIDER_NOT_FOUND         = HRESULT(0x80320005),
    FWP_E_PROVIDER_CONTEXT_NOT_FOUND = HRESULT(0x80320006),
}

enum HRESULT FWP_E_SUBLAYER_NOT_FOUND = HRESULT(0x80320007);
enum HRESULT FWP_E_NOT_FOUND = HRESULT(0x80320008);
enum HRESULT FWP_E_ALREADY_EXISTS = HRESULT(0x80320009);

enum : HRESULT
{
    FWP_E_IN_USE                      = HRESULT(0x8032000a),
    FWP_E_DYNAMIC_SESSION_IN_PROGRESS = HRESULT(0x8032000b),
}

enum HRESULT FWP_E_WRONG_SESSION = HRESULT(0x8032000c);
enum HRESULT FWP_E_NO_TXN_IN_PROGRESS = HRESULT(0x8032000d);

enum : HRESULT
{
    FWP_E_TXN_IN_PROGRESS = HRESULT(0x8032000e),
    FWP_E_TXN_ABORTED     = HRESULT(0x8032000f),
}

enum HRESULT FWP_E_SESSION_ABORTED = HRESULT(0x80320010);
enum HRESULT FWP_E_INCOMPATIBLE_TXN = HRESULT(0x80320011);

enum : HRESULT
{
    FWP_E_TIMEOUT             = HRESULT(0x80320012),
    FWP_E_NET_EVENTS_DISABLED = HRESULT(0x80320013),
}

enum HRESULT FWP_E_INCOMPATIBLE_LAYER = HRESULT(0x80320014);
enum HRESULT FWP_E_KM_CLIENTS_ONLY = HRESULT(0x80320015);
enum HRESULT FWP_E_LIFETIME_MISMATCH = HRESULT(0x80320016);
enum HRESULT FWP_E_BUILTIN_OBJECT = HRESULT(0x80320017);
enum HRESULT FWP_E_TOO_MANY_CALLOUTS = HRESULT(0x80320018);
enum HRESULT FWP_E_NOTIFICATION_DROPPED = HRESULT(0x80320019);
enum HRESULT FWP_E_TRAFFIC_MISMATCH = HRESULT(0x8032001a);
enum HRESULT FWP_E_INCOMPATIBLE_SA_STATE = HRESULT(0x8032001b);
enum HRESULT FWP_E_NULL_POINTER = HRESULT(0x8032001c);

enum : HRESULT
{
    FWP_E_INVALID_ENUMERATOR = HRESULT(0x8032001d),
    FWP_E_INVALID_FLAGS      = HRESULT(0x8032001e),
    FWP_E_INVALID_NET_MASK   = HRESULT(0x8032001f),
    FWP_E_INVALID_RANGE      = HRESULT(0x80320020),
    FWP_E_INVALID_INTERVAL   = HRESULT(0x80320021),
}

enum HRESULT FWP_E_ZERO_LENGTH_ARRAY = HRESULT(0x80320022);
enum HRESULT FWP_E_NULL_DISPLAY_NAME = HRESULT(0x80320023);

enum : HRESULT
{
    FWP_E_INVALID_ACTION_TYPE = HRESULT(0x80320024),
    FWP_E_INVALID_WEIGHT      = HRESULT(0x80320025),
}

enum HRESULT FWP_E_MATCH_TYPE_MISMATCH = HRESULT(0x80320026);
enum HRESULT FWP_E_TYPE_MISMATCH = HRESULT(0x80320027);
enum HRESULT FWP_E_OUT_OF_BOUNDS = HRESULT(0x80320028);

enum : HRESULT
{
    FWP_E_RESERVED            = HRESULT(0x80320029),
    FWP_E_DUPLICATE_CONDITION = HRESULT(0x8032002a),
    FWP_E_DUPLICATE_KEYMOD    = HRESULT(0x8032002b),
}

enum : HRESULT
{
    FWP_E_ACTION_INCOMPATIBLE_WITH_LAYER    = HRESULT(0x8032002c),
    FWP_E_ACTION_INCOMPATIBLE_WITH_SUBLAYER = HRESULT(0x8032002d),
}

enum : HRESULT
{
    FWP_E_CONTEXT_INCOMPATIBLE_WITH_LAYER   = HRESULT(0x8032002e),
    FWP_E_CONTEXT_INCOMPATIBLE_WITH_CALLOUT = HRESULT(0x8032002f),
}

enum : HRESULT
{
    FWP_E_INCOMPATIBLE_AUTH_METHOD = HRESULT(0x80320030),
    FWP_E_INCOMPATIBLE_DH_GROUP    = HRESULT(0x80320031),
}

enum HRESULT FWP_E_EM_NOT_SUPPORTED = HRESULT(0x80320032);
enum HRESULT FWP_E_NEVER_MATCH = HRESULT(0x80320033);
enum HRESULT FWP_E_PROVIDER_CONTEXT_MISMATCH = HRESULT(0x80320034);
enum HRESULT FWP_E_INVALID_PARAMETER = HRESULT(0x80320035);
enum HRESULT FWP_E_TOO_MANY_SUBLAYERS = HRESULT(0x80320036);
enum HRESULT FWP_E_CALLOUT_NOTIFICATION_FAILED = HRESULT(0x80320037);

enum : HRESULT
{
    FWP_E_INVALID_AUTH_TRANSFORM   = HRESULT(0x80320038),
    FWP_E_INVALID_CIPHER_TRANSFORM = HRESULT(0x80320039),
}

enum HRESULT FWP_E_INCOMPATIBLE_CIPHER_TRANSFORM = HRESULT(0x8032003a);
enum HRESULT FWP_E_INVALID_TRANSFORM_COMBINATION = HRESULT(0x8032003b);
enum HRESULT FWP_E_DUPLICATE_AUTH_METHOD = HRESULT(0x8032003c);
enum HRESULT FWP_E_INVALID_TUNNEL_ENDPOINT = HRESULT(0x8032003d);
enum HRESULT FWP_E_L2_DRIVER_NOT_READY = HRESULT(0x8032003e);

enum : HRESULT
{
    FWP_E_KEY_DICTATOR_ALREADY_REGISTERED       = HRESULT(0x8032003f),
    FWP_E_KEY_DICTATION_INVALID_KEYING_MATERIAL = HRESULT(0x80320040),
}

enum HRESULT FWP_E_CONNECTIONS_DISABLED = HRESULT(0x80320041);
enum HRESULT FWP_E_INVALID_DNS_NAME = HRESULT(0x80320042);

enum : HRESULT
{
    FWP_E_STILL_ON           = HRESULT(0x80320043),
    FWP_E_IKEEXT_NOT_RUNNING = HRESULT(0x80320044),
}

enum HRESULT FWP_E_DROP_NOICMP = HRESULT(0x80320104);

enum : HRESULT
{
    WS_S_ASYNC = HRESULT(0x003d0000),
    WS_S_END   = HRESULT(0x003d0001),
}

enum HRESULT WS_E_INVALID_FORMAT = HRESULT(0x803d0000);
enum HRESULT WS_E_OBJECT_FAULTED = HRESULT(0x803d0001);
enum HRESULT WS_E_NUMERIC_OVERFLOW = HRESULT(0x803d0002);
enum HRESULT WS_E_INVALID_OPERATION = HRESULT(0x803d0003);
enum HRESULT WS_E_OPERATION_ABORTED = HRESULT(0x803d0004);
enum HRESULT WS_E_ENDPOINT_ACCESS_DENIED = HRESULT(0x803d0005);

enum : HRESULT
{
    WS_E_OPERATION_TIMED_OUT = HRESULT(0x803d0006),
    WS_E_OPERATION_ABANDONED = HRESULT(0x803d0007),
}

enum HRESULT WS_E_QUOTA_EXCEEDED = HRESULT(0x803d0008);
enum HRESULT WS_E_NO_TRANSLATION_AVAILABLE = HRESULT(0x803d0009);
enum HRESULT WS_E_SECURITY_VERIFICATION_FAILURE = HRESULT(0x803d000a);

enum : HRESULT
{
    WS_E_ADDRESS_IN_USE        = HRESULT(0x803d000b),
    WS_E_ADDRESS_NOT_AVAILABLE = HRESULT(0x803d000c),
}

enum : HRESULT
{
    WS_E_ENDPOINT_NOT_FOUND            = HRESULT(0x803d000d),
    WS_E_ENDPOINT_NOT_AVAILABLE        = HRESULT(0x803d000e),
    WS_E_ENDPOINT_FAILURE              = HRESULT(0x803d000f),
    WS_E_ENDPOINT_UNREACHABLE          = HRESULT(0x803d0010),
    WS_E_ENDPOINT_ACTION_NOT_SUPPORTED = HRESULT(0x803d0011),
    WS_E_ENDPOINT_TOO_BUSY             = HRESULT(0x803d0012),
    WS_E_ENDPOINT_FAULT_RECEIVED       = HRESULT(0x803d0013),
    WS_E_ENDPOINT_DISCONNECTED         = HRESULT(0x803d0014),
}

enum : HRESULT
{
    WS_E_PROXY_FAILURE       = HRESULT(0x803d0015),
    WS_E_PROXY_ACCESS_DENIED = HRESULT(0x803d0016),
}

enum HRESULT WS_E_NOT_SUPPORTED = HRESULT(0x803d0017);

enum : HRESULT
{
    WS_E_PROXY_REQUIRES_BASIC_AUTH     = HRESULT(0x803d0018),
    WS_E_PROXY_REQUIRES_DIGEST_AUTH    = HRESULT(0x803d0019),
    WS_E_PROXY_REQUIRES_NTLM_AUTH      = HRESULT(0x803d001a),
    WS_E_PROXY_REQUIRES_NEGOTIATE_AUTH = HRESULT(0x803d001b),
}

enum : HRESULT
{
    WS_E_SERVER_REQUIRES_BASIC_AUTH     = HRESULT(0x803d001c),
    WS_E_SERVER_REQUIRES_DIGEST_AUTH    = HRESULT(0x803d001d),
    WS_E_SERVER_REQUIRES_NTLM_AUTH      = HRESULT(0x803d001e),
    WS_E_SERVER_REQUIRES_NEGOTIATE_AUTH = HRESULT(0x803d001f),
}

enum HRESULT WS_E_INVALID_ENDPOINT_URL = HRESULT(0x803d0020);

enum : HRESULT
{
    WS_E_OTHER                   = HRESULT(0x803d0021),
    WS_E_SECURITY_TOKEN_EXPIRED  = HRESULT(0x803d0022),
    WS_E_SECURITY_SYSTEM_FAILURE = HRESULT(0x803d0023),
}

enum HRESULT HCS_E_TERMINATED_DURING_START = HRESULT(0x80370100);
enum HRESULT HCS_E_IMAGE_MISMATCH = HRESULT(0x80370101);
enum HRESULT HCS_E_HYPERV_NOT_INSTALLED = HRESULT(0x80370102);
enum HRESULT HCS_E_INVALID_STATE = HRESULT(0x80370105);
enum HRESULT HCS_E_UNEXPECTED_EXIT = HRESULT(0x80370106);
enum HRESULT HCS_E_TERMINATED = HRESULT(0x80370107);

enum : HRESULT
{
    HCS_E_CONNECT_FAILED     = HRESULT(0x80370108),
    HCS_E_CONNECTION_TIMEOUT = HRESULT(0x80370109),
    HCS_E_CONNECTION_CLOSED  = HRESULT(0x8037010a),
}

enum HRESULT HCS_E_UNKNOWN_MESSAGE = HRESULT(0x8037010b);
enum HRESULT HCS_E_UNSUPPORTED_PROTOCOL_VERSION = HRESULT(0x8037010c);
enum HRESULT HCS_E_INVALID_JSON = HRESULT(0x8037010d);

enum : HRESULT
{
    HCS_E_SYSTEM_NOT_FOUND       = HRESULT(0x8037010e),
    HCS_E_SYSTEM_ALREADY_EXISTS  = HRESULT(0x8037010f),
    HCS_E_SYSTEM_ALREADY_STOPPED = HRESULT(0x80370110),
}

enum HRESULT HCS_E_PROTOCOL_ERROR = HRESULT(0x80370111);
enum HRESULT HCS_E_INVALID_LAYER = HRESULT(0x80370112);
enum HRESULT HCS_E_WINDOWS_INSIDER_REQUIRED = HRESULT(0x80370113);
enum HRESULT HCS_E_SERVICE_NOT_AVAILABLE = HRESULT(0x80370114);

enum : HRESULT
{
    HCS_E_OPERATION_NOT_STARTED                 = HRESULT(0x80370115),
    HCS_E_OPERATION_ALREADY_STARTED             = HRESULT(0x80370116),
    HCS_E_OPERATION_PENDING                     = HRESULT(0x80370117),
    HCS_E_OPERATION_TIMEOUT                     = HRESULT(0x80370118),
    HCS_E_OPERATION_SYSTEM_CALLBACK_ALREADY_SET = HRESULT(0x80370119),
}

enum HRESULT HCS_E_OPERATION_RESULT_ALLOCATION_FAILED = HRESULT(0x8037011a);
enum HRESULT HCS_E_ACCESS_DENIED = HRESULT(0x8037011b);
enum HRESULT HCS_E_GUEST_CRITICAL_ERROR = HRESULT(0x8037011c);
enum HRESULT HCS_E_PROCESS_INFO_NOT_AVAILABLE = HRESULT(0x8037011d);
enum HRESULT HCS_E_SERVICE_DISCONNECT = HRESULT(0x8037011e);
enum HRESULT HCS_E_PROCESS_ALREADY_STOPPED = HRESULT(0x8037011f);
enum HRESULT HCS_E_SYSTEM_NOT_CONFIGURED_FOR_OPERATION = HRESULT(0x80370120);
enum HRESULT HCS_E_OPERATION_ALREADY_CANCELLED = HRESULT(0x80370121);
enum HRESULT WHV_E_UNKNOWN_CAPABILITY = HRESULT(0x80370300);
enum HRESULT WHV_E_INSUFFICIENT_BUFFER = HRESULT(0x80370301);
enum HRESULT WHV_E_UNKNOWN_PROPERTY = HRESULT(0x80370302);
enum HRESULT WHV_E_UNSUPPORTED_HYPERVISOR_CONFIG = HRESULT(0x80370303);
enum HRESULT WHV_E_INVALID_PARTITION_CONFIG = HRESULT(0x80370304);
enum HRESULT WHV_E_GPA_RANGE_NOT_FOUND = HRESULT(0x80370305);
enum HRESULT WHV_E_VP_ALREADY_EXISTS = HRESULT(0x80370306);
enum HRESULT WHV_E_VP_DOES_NOT_EXIST = HRESULT(0x80370307);

enum : HRESULT
{
    WHV_E_INVALID_VP_STATE         = HRESULT(0x80370308),
    WHV_E_INVALID_VP_REGISTER_NAME = HRESULT(0x80370309),
}

enum HRESULT WHV_E_UNSUPPORTED_PROCESSOR_CONFIG = HRESULT(0x80370310);

enum : HRESULT
{
    VM_SAVED_STATE_DUMP_E_PARTITION_STATE_NOT_FOUND           = HRESULT(0xc0370500),
    VM_SAVED_STATE_DUMP_E_GUEST_MEMORY_NOT_FOUND              = HRESULT(0xc0370501),
    VM_SAVED_STATE_DUMP_E_NO_VP_FOUND_IN_PARTITION_STATE      = HRESULT(0xc0370502),
    VM_SAVED_STATE_DUMP_E_NESTED_VIRTUALIZATION_NOT_SUPPORTED = HRESULT(0xc0370503),
}

enum : HRESULT
{
    VM_SAVED_STATE_DUMP_E_WINDOWS_KERNEL_IMAGE_NOT_FOUND = HRESULT(0xc0370504),
    VM_SAVED_STATE_DUMP_E_VA_NOT_MAPPED                  = HRESULT(0xc0370505),
    VM_SAVED_STATE_DUMP_E_INVALID_VP_STATE               = HRESULT(0xc0370506),
    VM_SAVED_STATE_DUMP_E_VP_VTL_NOT_ENABLED             = HRESULT(0xc0370509),
}

enum HRESULT ERROR_DM_OPERATION_LIMIT_EXCEEDED = HRESULT(0xc0370600);
enum HRESULT VM_E_CLIENT_NAME_REQUIRED = HRESULT(0xc0370700);
enum HRESULT VM_E_MODIFY_VTL2_SETTINGS_CONFLICT = HRESULT(0xc0370701);
enum HRESULT VM_E_VTL2_NOT_AVAILABLE = HRESULT(0xc0370702);

enum : HRESULT
{
    VM_E_MANAGEMENT_VTL_RELOAD_IN_PROGRESS                           = HRESULT(0xc0370800),
    VM_E_MANAGEMENT_VTL_RELOAD_INVALID_PROTOCOL_RESPONSE             = HRESULT(0xc0370801),
    VM_E_MANAGEMENT_VTL_RELOAD_SAVE_FAILURE                          = HRESULT(0xc0370802),
    VM_E_MANAGEMENT_VTL_RELOAD_RESTORE_FAILURE                       = HRESULT(0xc0370803),
    VM_E_MANAGEMENT_VTL_RELOAD_NO_SAVED_STATE                        = HRESULT(0xc0370804),
    VM_E_MANAGEMENT_VTL_RELOAD_INVALID_SAVE_NOTIFICATION_RECEIVED    = HRESULT(0xc0370805),
    VM_E_MANAGEMENT_VTL_RELOAD_INVALID_RESTORE_REQUEST_RECEIVED      = HRESULT(0xc0370806),
    VM_E_MANAGEMENT_VTL_RELOAD_INVALID_RESTORE_NOTIFICATION_RECEIVED = HRESULT(0xc0370807),
    VM_E_MANAGEMENT_VTL_RELOAD_NO_IGVM_FILE                          = HRESULT(0xc0370808),
    VM_E_MANAGEMENT_VTL_RELOAD_UNSUPPORTED                           = HRESULT(0xc0370809),
    VM_E_MANAGEMENT_VTL_PROTOCOL_ESTABLISHMENT_TIMEOUT               = HRESULT(0xc037080a),
}

enum HRESULT HCN_E_NETWORK_NOT_FOUND = HRESULT(0x803b0001);
enum HRESULT HCN_E_ENDPOINT_NOT_FOUND = HRESULT(0x803b0002);
enum HRESULT HCN_E_LAYER_NOT_FOUND = HRESULT(0x803b0003);
enum HRESULT HCN_E_SWITCH_NOT_FOUND = HRESULT(0x803b0004);
enum HRESULT HCN_E_SUBNET_NOT_FOUND = HRESULT(0x803b0005);
enum HRESULT HCN_E_ADAPTER_NOT_FOUND = HRESULT(0x803b0006);
enum HRESULT HCN_E_PORT_NOT_FOUND = HRESULT(0x803b0007);
enum HRESULT HCN_E_POLICY_NOT_FOUND = HRESULT(0x803b0008);
enum HRESULT HCN_E_VFP_PORTSETTING_NOT_FOUND = HRESULT(0x803b0009);

enum : HRESULT
{
    HCN_E_INVALID_NETWORK                   = HRESULT(0x803b000a),
    HCN_E_INVALID_NETWORK_TYPE              = HRESULT(0x803b000b),
    HCN_E_INVALID_ENDPOINT                  = HRESULT(0x803b000c),
    HCN_E_INVALID_POLICY                    = HRESULT(0x803b000d),
    HCN_E_INVALID_POLICY_TYPE               = HRESULT(0x803b000e),
    HCN_E_INVALID_REMOTE_ENDPOINT_OPERATION = HRESULT(0x803b000f),
}

enum HRESULT HCN_E_NETWORK_ALREADY_EXISTS = HRESULT(0x803b0010);
enum HRESULT HCN_E_LAYER_ALREADY_EXISTS = HRESULT(0x803b0011);
enum HRESULT HCN_E_POLICY_ALREADY_EXISTS = HRESULT(0x803b0012);
enum HRESULT HCN_E_PORT_ALREADY_EXISTS = HRESULT(0x803b0013);
enum HRESULT HCN_E_ENDPOINT_ALREADY_ATTACHED = HRESULT(0x803b0014);
enum HRESULT HCN_E_REQUEST_UNSUPPORTED = HRESULT(0x803b0015);
enum HRESULT HCN_E_MAPPING_NOT_SUPPORTED = HRESULT(0x803b0016);
enum HRESULT HCN_E_DEGRADED_OPERATION = HRESULT(0x803b0017);
enum HRESULT HCN_E_SHARED_SWITCH_MODIFICATION = HRESULT(0x803b0018);
enum HRESULT HCN_E_GUID_CONVERSION_FAILURE = HRESULT(0x803b0019);
enum HRESULT HCN_E_REGKEY_FAILURE = HRESULT(0x803b001a);

enum : HRESULT
{
    HCN_E_INVALID_JSON           = HRESULT(0x803b001b),
    HCN_E_INVALID_JSON_REFERENCE = HRESULT(0x803b001c),
}

enum HRESULT HCN_E_ENDPOINT_SHARING_DISABLED = HRESULT(0x803b001d);
enum HRESULT HCN_E_INVALID_IP = HRESULT(0x803b001e);
enum HRESULT HCN_E_SWITCH_EXTENSION_NOT_FOUND = HRESULT(0x803b001f);
enum HRESULT HCN_E_MANAGER_STOPPED = HRESULT(0x803b0020);
enum HRESULT GCN_E_MODULE_NOT_FOUND = HRESULT(0x803b0021);
enum HRESULT GCN_E_NO_REQUEST_HANDLERS = HRESULT(0x803b0022);
enum HRESULT GCN_E_REQUEST_UNSUPPORTED = HRESULT(0x803b0023);
enum HRESULT GCN_E_RUNTIMEKEYS_FAILED = HRESULT(0x803b0024);

enum : HRESULT
{
    GCN_E_NETADAPTER_TIMEOUT   = HRESULT(0x803b0025),
    GCN_E_NETADAPTER_NOT_FOUND = HRESULT(0x803b0026),
}

enum HRESULT GCN_E_NETCOMPARTMENT_NOT_FOUND = HRESULT(0x803b0027);
enum HRESULT GCN_E_NETINTERFACE_NOT_FOUND = HRESULT(0x803b0028);
enum HRESULT GCN_E_DEFAULTNAMESPACE_EXISTS = HRESULT(0x803b0029);
enum HRESULT HCN_E_ICS_DISABLED = HRESULT(0x803b002a);
enum HRESULT HCN_E_ENDPOINT_NAMESPACE_ALREADY_EXISTS = HRESULT(0x803b002b);
enum HRESULT HCN_E_ENTITY_HAS_REFERENCES = HRESULT(0x803b002c);
enum HRESULT HCN_E_INVALID_INTERNAL_PORT = HRESULT(0x803b002d);
enum HRESULT HCN_E_NAMESPACE_ATTACH_FAILED = HRESULT(0x803b002e);
enum HRESULT HCN_E_ADDR_INVALID_OR_RESERVED = HRESULT(0x803b002f);
enum HRESULT HCN_E_INVALID_PREFIX = HRESULT(0x803b0030);
enum HRESULT HCN_E_OBJECT_USED_AFTER_UNLOAD = HRESULT(0x803b0031);

enum : HRESULT
{
    HCN_E_INVALID_SUBNET    = HRESULT(0x803b0032),
    HCN_E_INVALID_IP_SUBNET = HRESULT(0x803b0033),
}

enum : HRESULT
{
    HCN_E_ENDPOINT_NOT_ATTACHED = HRESULT(0x803b0034),
    HCN_E_ENDPOINT_NOT_LOCAL    = HRESULT(0x803b0035),
}

enum HRESULT HCN_INTERFACEPARAMETERS_ALREADY_APPLIED = HRESULT(0x803b0036);
enum HRESULT HCN_E_VFP_NOT_ALLOWED = HRESULT(0x803b0037);

enum : int
{
    SDIAG_E_CANCELLED   = 0x803c0100,
    SDIAG_E_SCRIPT      = 0x803c0101,
    SDIAG_E_POWERSHELL  = 0x803c0102,
    SDIAG_E_MANAGEDHOST = 0x803c0103,
    SDIAG_E_NOVERIFIER  = 0x803c0104,
}

enum int SDIAG_S_CANNOTRUN = 0x003c0105;

enum : int
{
    SDIAG_E_DISABLED  = 0x803c0106,
    SDIAG_E_TRUST     = 0x803c0107,
    SDIAG_E_CANNOTRUN = 0x803c0108,
    SDIAG_E_VERSION   = 0x803c0109,
    SDIAG_E_RESOURCE  = 0x803c010a,
    SDIAG_E_ROOTCAUSE = 0x803c010b,
}

enum : HRESULT
{
    WPN_E_CHANNEL_CLOSED               = HRESULT(0x803e0100),
    WPN_E_CHANNEL_REQUEST_NOT_COMPLETE = HRESULT(0x803e0101),
}

enum HRESULT WPN_E_INVALID_APP = HRESULT(0x803e0102);
enum HRESULT WPN_E_OUTSTANDING_CHANNEL_REQUEST = HRESULT(0x803e0103);
enum HRESULT WPN_E_DUPLICATE_CHANNEL = HRESULT(0x803e0104);
enum HRESULT WPN_E_PLATFORM_UNAVAILABLE = HRESULT(0x803e0105);

enum : HRESULT
{
    WPN_E_NOTIFICATION_POSTED     = HRESULT(0x803e0106),
    WPN_E_NOTIFICATION_HIDDEN     = HRESULT(0x803e0107),
    WPN_E_NOTIFICATION_NOT_POSTED = HRESULT(0x803e0108),
}

enum : HRESULT
{
    WPN_E_CLOUD_DISABLED            = HRESULT(0x803e0109),
    WPN_E_CLOUD_INCAPABLE           = HRESULT(0x803e0110),
    WPN_E_CLOUD_AUTH_UNAVAILABLE    = HRESULT(0x803e011a),
    WPN_E_CLOUD_SERVICE_UNAVAILABLE = HRESULT(0x803e011b),
}

enum HRESULT WPN_E_FAILED_LOCK_SCREEN_UPDATE_INTIALIZATION = HRESULT(0x803e011c);

enum : HRESULT
{
    WPN_E_NOTIFICATION_DISABLED  = HRESULT(0x803e0111),
    WPN_E_NOTIFICATION_INCAPABLE = HRESULT(0x803e0112),
}

enum HRESULT WPN_E_INTERNET_INCAPABLE = HRESULT(0x803e0113);

enum : HRESULT
{
    WPN_E_NOTIFICATION_TYPE_DISABLED = HRESULT(0x803e0114),
    WPN_E_NOTIFICATION_SIZE          = HRESULT(0x803e0115),
}

enum : HRESULT
{
    WPN_E_TAG_SIZE      = HRESULT(0x803e0116),
    WPN_E_ACCESS_DENIED = HRESULT(0x803e0117),
}

enum HRESULT WPN_E_DUPLICATE_REGISTRATION = HRESULT(0x803e0118);
enum HRESULT WPN_E_PUSH_NOTIFICATION_INCAPABLE = HRESULT(0x803e0119);
enum HRESULT WPN_E_DEV_ID_SIZE = HRESULT(0x803e0120);
enum HRESULT WPN_E_TAG_ALPHANUMERIC = HRESULT(0x803e012a);
enum HRESULT WPN_E_INVALID_HTTP_STATUS_CODE = HRESULT(0x803e012b);
enum HRESULT WPN_E_OUT_OF_SESSION = HRESULT(0x803e0200);
enum HRESULT WPN_E_POWER_SAVE = HRESULT(0x803e0201);
enum HRESULT WPN_E_IMAGE_NOT_FOUND_IN_CACHE = HRESULT(0x803e0202);
enum HRESULT WPN_E_ALL_URL_NOT_COMPLETED = HRESULT(0x803e0203);
enum HRESULT WPN_E_INVALID_CLOUD_IMAGE = HRESULT(0x803e0204);
enum HRESULT WPN_E_NOTIFICATION_ID_MATCHED = HRESULT(0x803e0205);
enum HRESULT WPN_E_CALLBACK_ALREADY_REGISTERED = HRESULT(0x803e0206);
enum HRESULT WPN_E_TOAST_NOTIFICATION_DROPPED = HRESULT(0x803e0207);
enum HRESULT WPN_E_STORAGE_LOCKED = HRESULT(0x803e0208);

enum : HRESULT
{
    WPN_E_GROUP_SIZE         = HRESULT(0x803e0209),
    WPN_E_GROUP_ALPHANUMERIC = HRESULT(0x803e020a),
}

enum HRESULT WPN_E_CLOUD_DISABLED_FOR_APP = HRESULT(0x803e020b);
enum HRESULT E_MBN_CONTEXT_NOT_ACTIVATED = HRESULT(0x80548201);

enum : HRESULT
{
    E_MBN_BAD_SIM                  = HRESULT(0x80548202),
    E_MBN_DATA_CLASS_NOT_AVAILABLE = HRESULT(0x80548203),
}

enum HRESULT E_MBN_INVALID_ACCESS_STRING = HRESULT(0x80548204);
enum HRESULT E_MBN_MAX_ACTIVATED_CONTEXTS = HRESULT(0x80548205);
enum HRESULT E_MBN_PACKET_SVC_DETACHED = HRESULT(0x80548206);
enum HRESULT E_MBN_PROVIDER_NOT_VISIBLE = HRESULT(0x80548207);
enum HRESULT E_MBN_RADIO_POWER_OFF = HRESULT(0x80548208);
enum HRESULT E_MBN_SERVICE_NOT_ACTIVATED = HRESULT(0x80548209);
enum HRESULT E_MBN_SIM_NOT_INSERTED = HRESULT(0x8054820a);
enum HRESULT E_MBN_VOICE_CALL_IN_PROGRESS = HRESULT(0x8054820b);
enum HRESULT E_MBN_INVALID_CACHE = HRESULT(0x8054820c);
enum HRESULT E_MBN_NOT_REGISTERED = HRESULT(0x8054820d);
enum HRESULT E_MBN_PROVIDERS_NOT_FOUND = HRESULT(0x8054820e);

enum : HRESULT
{
    E_MBN_PIN_NOT_SUPPORTED = HRESULT(0x8054820f),
    E_MBN_PIN_REQUIRED      = HRESULT(0x80548210),
    E_MBN_PIN_DISABLED      = HRESULT(0x80548211),
}

enum : HRESULT
{
    E_MBN_FAILURE         = HRESULT(0x80548212),
    E_MBN_INVALID_PROFILE = HRESULT(0x80548218),
}

enum HRESULT E_MBN_DEFAULT_PROFILE_EXIST = HRESULT(0x80548219);
enum HRESULT E_MBN_SMS_ENCODING_NOT_SUPPORTED = HRESULT(0x80548220);
enum HRESULT E_MBN_SMS_FILTER_NOT_SUPPORTED = HRESULT(0x80548221);
enum HRESULT E_MBN_SMS_INVALID_MEMORY_INDEX = HRESULT(0x80548222);
enum HRESULT E_MBN_SMS_LANG_NOT_SUPPORTED = HRESULT(0x80548223);

enum : HRESULT
{
    E_MBN_SMS_MEMORY_FAILURE  = HRESULT(0x80548224),
    E_MBN_SMS_NETWORK_TIMEOUT = HRESULT(0x80548225),
}

enum HRESULT E_MBN_SMS_UNKNOWN_SMSC_ADDRESS = HRESULT(0x80548226);
enum HRESULT E_MBN_SMS_FORMAT_NOT_SUPPORTED = HRESULT(0x80548227);
enum HRESULT E_MBN_SMS_OPERATION_NOT_ALLOWED = HRESULT(0x80548228);
enum HRESULT E_MBN_SMS_MEMORY_FULL = HRESULT(0x80548229);
enum HRESULT PEER_E_IPV6_NOT_INSTALLED = HRESULT(0x80630001);
enum HRESULT PEER_E_NOT_INITIALIZED = HRESULT(0x80630002);
enum HRESULT PEER_E_CANNOT_START_SERVICE = HRESULT(0x80630003);
enum HRESULT PEER_E_NOT_LICENSED = HRESULT(0x80630004);
enum HRESULT PEER_E_INVALID_GRAPH = HRESULT(0x80630010);
enum HRESULT PEER_E_DBNAME_CHANGED = HRESULT(0x80630011);
enum HRESULT PEER_E_DUPLICATE_GRAPH = HRESULT(0x80630012);

enum : HRESULT
{
    PEER_E_GRAPH_NOT_READY     = HRESULT(0x80630013),
    PEER_E_GRAPH_SHUTTING_DOWN = HRESULT(0x80630014),
    PEER_E_GRAPH_IN_USE        = HRESULT(0x80630015),
}

enum HRESULT PEER_E_INVALID_DATABASE = HRESULT(0x80630016);
enum HRESULT PEER_E_TOO_MANY_ATTRIBUTES = HRESULT(0x80630017);

enum : HRESULT
{
    PEER_E_CONNECTION_NOT_FOUND = HRESULT(0x80630103),
    PEER_E_CONNECT_SELF         = HRESULT(0x80630106),
}

enum HRESULT PEER_E_ALREADY_LISTENING = HRESULT(0x80630107);
enum HRESULT PEER_E_NODE_NOT_FOUND = HRESULT(0x80630108);

enum : HRESULT
{
    PEER_E_CONNECTION_FAILED            = HRESULT(0x80630109),
    PEER_E_CONNECTION_NOT_AUTHENTICATED = HRESULT(0x8063010a),
    PEER_E_CONNECTION_REFUSED           = HRESULT(0x8063010b),
}

enum HRESULT PEER_E_CLASSIFIER_TOO_LONG = HRESULT(0x80630201);
enum HRESULT PEER_E_TOO_MANY_IDENTITIES = HRESULT(0x80630202);
enum HRESULT PEER_E_NO_KEY_ACCESS = HRESULT(0x80630203);
enum HRESULT PEER_E_GROUPS_EXIST = HRESULT(0x80630204);
enum HRESULT PEER_E_RECORD_NOT_FOUND = HRESULT(0x80630301);
enum HRESULT PEER_E_DATABASE_ACCESSDENIED = HRESULT(0x80630302);
enum HRESULT PEER_E_DBINITIALIZATION_FAILED = HRESULT(0x80630303);
enum HRESULT PEER_E_MAX_RECORD_SIZE_EXCEEDED = HRESULT(0x80630304);

enum : HRESULT
{
    PEER_E_DATABASE_ALREADY_PRESENT = HRESULT(0x80630305),
    PEER_E_DATABASE_NOT_PRESENT     = HRESULT(0x80630306),
}

enum HRESULT PEER_E_IDENTITY_NOT_FOUND = HRESULT(0x80630401);
enum HRESULT PEER_E_EVENT_HANDLE_NOT_FOUND = HRESULT(0x80630501);

enum : HRESULT
{
    PEER_E_INVALID_SEARCH     = HRESULT(0x80630601),
    PEER_E_INVALID_ATTRIBUTES = HRESULT(0x80630602),
}

enum HRESULT PEER_E_INVITATION_NOT_TRUSTED = HRESULT(0x80630701);
enum HRESULT PEER_E_CHAIN_TOO_LONG = HRESULT(0x80630703);
enum HRESULT PEER_E_INVALID_TIME_PERIOD = HRESULT(0x80630705);
enum HRESULT PEER_E_CIRCULAR_CHAIN_DETECTED = HRESULT(0x80630706);
enum HRESULT PEER_E_CERT_STORE_CORRUPTED = HRESULT(0x80630801);

enum : HRESULT
{
    PEER_E_NO_CLOUD             = HRESULT(0x80631001),
    PEER_E_CLOUD_NAME_AMBIGUOUS = HRESULT(0x80631005),
}

enum HRESULT PEER_E_INVALID_RECORD = HRESULT(0x80632010);
enum HRESULT PEER_E_NOT_AUTHORIZED = HRESULT(0x80632020);
enum HRESULT PEER_E_PASSWORD_DOES_NOT_MEET_POLICY = HRESULT(0x80632021);
enum HRESULT PEER_E_DEFERRED_VALIDATION = HRESULT(0x80632030);

enum : HRESULT
{
    PEER_E_INVALID_GROUP_PROPERTIES    = HRESULT(0x80632040),
    PEER_E_INVALID_PEER_NAME           = HRESULT(0x80632050),
    PEER_E_INVALID_CLASSIFIER          = HRESULT(0x80632060),
    PEER_E_INVALID_FRIENDLY_NAME       = HRESULT(0x80632070),
    PEER_E_INVALID_ROLE_PROPERTY       = HRESULT(0x80632071),
    PEER_E_INVALID_CLASSIFIER_PROPERTY = HRESULT(0x80632072),
    PEER_E_INVALID_RECORD_EXPIRATION   = HRESULT(0x80632080),
    PEER_E_INVALID_CREDENTIAL_INFO     = HRESULT(0x80632081),
    PEER_E_INVALID_CREDENTIAL          = HRESULT(0x80632082),
    PEER_E_INVALID_RECORD_SIZE         = HRESULT(0x80632083),
}

enum HRESULT PEER_E_UNSUPPORTED_VERSION = HRESULT(0x80632090);

enum : HRESULT
{
    PEER_E_GROUP_NOT_READY = HRESULT(0x80632091),
    PEER_E_GROUP_IN_USE    = HRESULT(0x80632092),
}

enum HRESULT PEER_E_INVALID_GROUP = HRESULT(0x80632093);

enum : HRESULT
{
    PEER_E_NO_MEMBERS_FOUND      = HRESULT(0x80632094),
    PEER_E_NO_MEMBER_CONNECTIONS = HRESULT(0x80632095),
}

enum HRESULT PEER_E_UNABLE_TO_LISTEN = HRESULT(0x80632096);
enum HRESULT PEER_E_IDENTITY_DELETED = HRESULT(0x806320a0);
enum HRESULT PEER_E_SERVICE_NOT_AVAILABLE = HRESULT(0x806320a1);
enum HRESULT PEER_E_CONTACT_NOT_FOUND = HRESULT(0x80636001);
enum HRESULT PEER_S_GRAPH_DATA_CREATED = HRESULT(0x00630001);
enum HRESULT PEER_S_NO_EVENT_DATA = HRESULT(0x00630002);
enum HRESULT PEER_S_ALREADY_CONNECTED = HRESULT(0x00632000);
enum HRESULT PEER_S_SUBSCRIPTION_EXISTS = HRESULT(0x00636000);
enum HRESULT PEER_S_NO_CONNECTIVITY = HRESULT(0x00630005);
enum HRESULT PEER_S_ALREADY_A_MEMBER = HRESULT(0x00630006);
enum HRESULT PEER_E_CANNOT_CONVERT_PEER_NAME = HRESULT(0x80634001);
enum HRESULT PEER_E_INVALID_PEER_HOST_NAME = HRESULT(0x80634002);

enum : HRESULT
{
    PEER_E_NO_MORE                  = HRESULT(0x80634003),
    PEER_E_PNRP_DUPLICATE_PEER_NAME = HRESULT(0x80634005),
}

enum : HRESULT
{
    PEER_E_INVITE_CANCELLED              = HRESULT(0x80637000),
    PEER_E_INVITE_RESPONSE_NOT_AVAILABLE = HRESULT(0x80637001),
}

enum HRESULT PEER_E_NOT_SIGNED_IN = HRESULT(0x80637003);
enum HRESULT PEER_E_PRIVACY_DECLINED = HRESULT(0x80637004);

enum : HRESULT
{
    PEER_E_TIMEOUT         = HRESULT(0x80637005),
    PEER_E_INVALID_ADDRESS = HRESULT(0x80637007),
}

enum HRESULT PEER_E_FW_EXCEPTION_DISABLED = HRESULT(0x80637008);

enum : HRESULT
{
    PEER_E_FW_BLOCKED_BY_POLICY     = HRESULT(0x80637009),
    PEER_E_FW_BLOCKED_BY_SHIELDS_UP = HRESULT(0x8063700a),
}

enum HRESULT PEER_E_FW_DECLINED = HRESULT(0x8063700b);
enum HRESULT UI_E_CREATE_FAILED = HRESULT(0x802a0001);
enum HRESULT UI_E_SHUTDOWN_CALLED = HRESULT(0x802a0002);
enum HRESULT UI_E_ILLEGAL_REENTRANCY = HRESULT(0x802a0003);
enum HRESULT UI_E_OBJECT_SEALED = HRESULT(0x802a0004);

enum : HRESULT
{
    UI_E_VALUE_NOT_SET        = HRESULT(0x802a0005),
    UI_E_VALUE_NOT_DETERMINED = HRESULT(0x802a0006),
}

enum HRESULT UI_E_INVALID_OUTPUT = HRESULT(0x802a0007);
enum HRESULT UI_E_BOOLEAN_EXPECTED = HRESULT(0x802a0008);
enum HRESULT UI_E_DIFFERENT_OWNER = HRESULT(0x802a0009);
enum HRESULT UI_E_AMBIGUOUS_MATCH = HRESULT(0x802a000a);
enum HRESULT UI_E_FP_OVERFLOW = HRESULT(0x802a000b);
enum HRESULT UI_E_WRONG_THREAD = HRESULT(0x802a000c);

enum : HRESULT
{
    UI_E_STORYBOARD_ACTIVE      = HRESULT(0x802a0101),
    UI_E_STORYBOARD_NOT_PLAYING = HRESULT(0x802a0102),
}

enum HRESULT UI_E_START_KEYFRAME_AFTER_END = HRESULT(0x802a0103);
enum HRESULT UI_E_END_KEYFRAME_NOT_DETERMINED = HRESULT(0x802a0104);
enum HRESULT UI_E_LOOPS_OVERLAP = HRESULT(0x802a0105);

enum : HRESULT
{
    UI_E_TRANSITION_ALREADY_USED      = HRESULT(0x802a0106),
    UI_E_TRANSITION_NOT_IN_STORYBOARD = HRESULT(0x802a0107),
    UI_E_TRANSITION_ECLIPSED          = HRESULT(0x802a0108),
}

enum HRESULT UI_E_TIME_BEFORE_LAST_UPDATE = HRESULT(0x802a0109);
enum HRESULT UI_E_TIMER_CLIENT_ALREADY_CONNECTED = HRESULT(0x802a010a);
enum HRESULT UI_E_INVALID_DIMENSION = HRESULT(0x802a010b);
enum HRESULT UI_E_PRIMITIVE_OUT_OF_BOUNDS = HRESULT(0x802a010c);
enum HRESULT UI_E_WINDOW_CLOSED = HRESULT(0x802a0201);

enum : HRESULT
{
    E_BLUETOOTH_ATT_INVALID_HANDLE              = HRESULT(0x80650001),
    E_BLUETOOTH_ATT_READ_NOT_PERMITTED          = HRESULT(0x80650002),
    E_BLUETOOTH_ATT_WRITE_NOT_PERMITTED         = HRESULT(0x80650003),
    E_BLUETOOTH_ATT_INVALID_PDU                 = HRESULT(0x80650004),
    E_BLUETOOTH_ATT_INSUFFICIENT_AUTHENTICATION = HRESULT(0x80650005),
}

enum : HRESULT
{
    E_BLUETOOTH_ATT_REQUEST_NOT_SUPPORTED      = HRESULT(0x80650006),
    E_BLUETOOTH_ATT_INVALID_OFFSET             = HRESULT(0x80650007),
    E_BLUETOOTH_ATT_INSUFFICIENT_AUTHORIZATION = HRESULT(0x80650008),
}

enum : HRESULT
{
    E_BLUETOOTH_ATT_PREPARE_QUEUE_FULL               = HRESULT(0x80650009),
    E_BLUETOOTH_ATT_ATTRIBUTE_NOT_FOUND              = HRESULT(0x8065000a),
    E_BLUETOOTH_ATT_ATTRIBUTE_NOT_LONG               = HRESULT(0x8065000b),
    E_BLUETOOTH_ATT_INSUFFICIENT_ENCRYPTION_KEY_SIZE = HRESULT(0x8065000c),
}

enum HRESULT E_BLUETOOTH_ATT_INVALID_ATTRIBUTE_VALUE_LENGTH = HRESULT(0x8065000d);

enum : HRESULT
{
    E_BLUETOOTH_ATT_UNLIKELY                = HRESULT(0x8065000e),
    E_BLUETOOTH_ATT_INSUFFICIENT_ENCRYPTION = HRESULT(0x8065000f),
    E_BLUETOOTH_ATT_UNSUPPORTED_GROUP_TYPE  = HRESULT(0x80650010),
    E_BLUETOOTH_ATT_INSUFFICIENT_RESOURCES  = HRESULT(0x80650011),
    E_BLUETOOTH_ATT_UNKNOWN_ERROR           = HRESULT(0x80651000),
}

enum HRESULT E_AUDIO_ENGINE_NODE_NOT_FOUND = HRESULT(0x80660001);
enum HRESULT E_HDAUDIO_EMPTY_CONNECTION_LIST = HRESULT(0x80660002);
enum HRESULT E_HDAUDIO_CONNECTION_LIST_NOT_SUPPORTED = HRESULT(0x80660003);
enum HRESULT E_HDAUDIO_NO_LOGICAL_DEVICES_CREATED = HRESULT(0x80660004);
enum HRESULT E_HDAUDIO_NULL_LINKED_LIST_ENTRY = HRESULT(0x80660005);

enum : HRESULT
{
    E_SOUNDWIRE_COMMAND_ABORTED = HRESULT(0x80660006),
    E_SOUNDWIRE_COMMAND_IGNORED = HRESULT(0x80660007),
    E_SOUNDWIRE_COMMAND_FAILED  = HRESULT(0x80660008),
}

enum HRESULT STATEREPOSITORY_E_CONCURRENCY_LOCKING_FAILURE = HRESULT(0x80670001);

enum : HRESULT
{
    STATEREPOSITORY_E_STATEMENT_INPROGRESS           = HRESULT(0x80670002),
    STATEREPOSITORY_E_CONFIGURATION_INVALID          = HRESULT(0x80670003),
    STATEREPOSITORY_E_UNKNOWN_SCHEMA_VERSION         = HRESULT(0x80670004),
    STATEREPOSITORY_ERROR_DICTIONARY_CORRUPTED       = HRESULT(0x80670005),
    STATEREPOSITORY_E_BLOCKED                        = HRESULT(0x80670006),
    STATEREPOSITORY_E_BUSY_RETRY                     = HRESULT(0x80670007),
    STATEREPOSITORY_E_BUSY_RECOVERY_RETRY            = HRESULT(0x80670008),
    STATEREPOSITORY_E_LOCKED_RETRY                   = HRESULT(0x80670009),
    STATEREPOSITORY_E_LOCKED_SHAREDCACHE_RETRY       = HRESULT(0x8067000a),
    STATEREPOSITORY_E_TRANSACTION_REQUIRED           = HRESULT(0x8067000b),
    STATEREPOSITORY_E_BUSY_TIMEOUT_EXCEEDED          = HRESULT(0x8067000c),
    STATEREPOSITORY_E_BUSY_RECOVERY_TIMEOUT_EXCEEDED = HRESULT(0x8067000d),
}

enum : HRESULT
{
    STATEREPOSITORY_E_LOCKED_TIMEOUT_EXCEEDED             = HRESULT(0x8067000e),
    STATEREPOSITORY_E_LOCKED_SHAREDCACHE_TIMEOUT_EXCEEDED = HRESULT(0x8067000f),
}

enum HRESULT STATEREPOSITORY_E_SERVICE_STOP_IN_PROGRESS = HRESULT(0x80670010);
enum HRESULT STATEREPOSTORY_E_NESTED_TRANSACTION_NOT_SUPPORTED = HRESULT(0x80670011);

enum : HRESULT
{
    STATEREPOSITORY_ERROR_CACHE_CORRUPTED         = HRESULT(0x80670012),
    STATEREPOSITORY_TRANSACTION_CALLER_ID_CHANGED = HRESULT(0x00670013),
    STATEREPOSITORY_TRANSACTION_IN_PROGRESS       = HRESULT(0x80670014),
    STATEREPOSITORY_E_CACHE_NOT_INIITALIZED       = HRESULT(0x80670015),
    STATEREPOSITORY_E_DEPENDENCY_NOT_RESOLVED     = HRESULT(0x80670016),
}

enum : HRESULT
{
    ERROR_SPACES_POOL_WAS_DELETED          = HRESULT(0x00e70001),
    ERROR_SPACES_FAULT_DOMAIN_TYPE_INVALID = HRESULT(0x80e70001),
}

enum : HRESULT
{
    ERROR_SPACES_INTERNAL_ERROR          = HRESULT(0x80e70002),
    ERROR_SPACES_RESILIENCY_TYPE_INVALID = HRESULT(0x80e70003),
}

enum : HRESULT
{
    ERROR_SPACES_DRIVE_SECTOR_SIZE_INVALID = HRESULT(0x80e70004),
    ERROR_SPACES_DRIVE_REDUNDANCY_INVALID  = HRESULT(0x80e70006),
}

enum HRESULT ERROR_SPACES_NUMBER_OF_DATA_COPIES_INVALID = HRESULT(0x80e70007);
enum HRESULT ERROR_SPACES_PARITY_LAYOUT_INVALID = HRESULT(0x80e70008);
enum HRESULT ERROR_SPACES_INTERLEAVE_LENGTH_INVALID = HRESULT(0x80e70009);
enum HRESULT ERROR_SPACES_NUMBER_OF_COLUMNS_INVALID = HRESULT(0x80e7000a);

enum : HRESULT
{
    ERROR_SPACES_NOT_ENOUGH_DRIVES         = HRESULT(0x80e7000b),
    ERROR_SPACES_EXTENDED_ERROR            = HRESULT(0x80e7000c),
    ERROR_SPACES_PROVISIONING_TYPE_INVALID = HRESULT(0x80e7000d),
}

enum HRESULT ERROR_SPACES_ALLOCATION_SIZE_INVALID = HRESULT(0x80e7000e);
enum HRESULT ERROR_SPACES_ENCLOSURE_AWARE_INVALID = HRESULT(0x80e7000f);
enum HRESULT ERROR_SPACES_WRITE_CACHE_SIZE_INVALID = HRESULT(0x80e70010);
enum HRESULT ERROR_SPACES_NUMBER_OF_GROUPS_INVALID = HRESULT(0x80e70011);
enum HRESULT ERROR_SPACES_DRIVE_OPERATIONAL_STATE_INVALID = HRESULT(0x80e70012);

enum : HRESULT
{
    ERROR_SPACES_ENTRY_INCOMPLETE    = HRESULT(0x80e70013),
    ERROR_SPACES_ENTRY_INVALID       = HRESULT(0x80e70014),
    ERROR_SPACES_UPDATE_COLUMN_STATE = HRESULT(0x80e70015),
    ERROR_SPACES_MAP_REQUIRED        = HRESULT(0x80e70016),
    ERROR_SPACES_UNSUPPORTED_VERSION = HRESULT(0x80e70017),
    ERROR_SPACES_CORRUPT_METADATA    = HRESULT(0x80e70018),
    ERROR_SPACES_DRT_FULL            = HRESULT(0x80e70019),
    ERROR_SPACES_INCONSISTENCY       = HRESULT(0x80e7001a),
    ERROR_SPACES_LOG_NOT_READY       = HRESULT(0x80e7001b),
    ERROR_SPACES_NO_REDUNDANCY       = HRESULT(0x80e7001c),
    ERROR_SPACES_DRIVE_NOT_READY     = HRESULT(0x80e7001d),
    ERROR_SPACES_DRIVE_SPLIT         = HRESULT(0x80e7001e),
    ERROR_SPACES_DRIVE_LOST_DATA     = HRESULT(0x80e7001f),
    ERROR_SPACES_MARK_DIRTY          = HRESULT(0x80e70020),
    ERROR_SPACES_FLUSH_METADATA      = HRESULT(0x80e70025),
    ERROR_SPACES_CACHE_FULL          = HRESULT(0x80e70026),
    ERROR_SPACES_REPAIR_IN_PROGRESS  = HRESULT(0x80e70027),
}

enum : HRESULT
{
    ERROR_VOLSNAP_BOOTFILE_NOT_VALID        = HRESULT(0x80820001),
    ERROR_VOLSNAP_ACTIVATION_TIMEOUT        = HRESULT(0x80820002),
    ERROR_VOLSNAP_NO_BYPASSIO_WITH_SNAPSHOT = HRESULT(0x80820003),
}

enum HRESULT ERROR_TIERING_NOT_SUPPORTED_ON_VOLUME = HRESULT(0x80830001);
enum HRESULT ERROR_TIERING_VOLUME_DISMOUNT_IN_PROGRESS = HRESULT(0x80830002);
enum HRESULT ERROR_TIERING_STORAGE_TIER_NOT_FOUND = HRESULT(0x80830003);

enum : HRESULT
{
    ERROR_TIERING_INVALID_FILE_ID    = HRESULT(0x80830004),
    ERROR_TIERING_WRONG_CLUSTER_NODE = HRESULT(0x80830005),
    ERROR_TIERING_ALREADY_PROCESSING = HRESULT(0x80830006),
    ERROR_TIERING_CANNOT_PIN_OBJECT  = HRESULT(0x80830007),
    ERROR_TIERING_FILE_IS_NOT_PINNED = HRESULT(0x80830008),
}

enum HRESULT ERROR_NOT_A_TIERED_VOLUME = HRESULT(0x80830009);
enum HRESULT ERROR_ATTRIBUTE_NOT_PRESENT = HRESULT(0x8083000a);
enum HRESULT ERROR_SECCORE_INVALID_COMMAND = HRESULT(0xc0e80000);
enum HRESULT ERROR_NO_APPLICABLE_APP_LICENSES_FOUND = HRESULT(0xc0ea0001);
enum HRESULT ERROR_CLIP_LICENSE_NOT_FOUND = HRESULT(0xc0ea0002);
enum HRESULT ERROR_CLIP_DEVICE_LICENSE_MISSING = HRESULT(0xc0ea0003);
enum HRESULT ERROR_CLIP_LICENSE_INVALID_SIGNATURE = HRESULT(0xc0ea0004);
enum HRESULT ERROR_CLIP_KEYHOLDER_LICENSE_MISSING_OR_INVALID = HRESULT(0xc0ea0005);

enum : HRESULT
{
    ERROR_CLIP_LICENSE_EXPIRED                      = HRESULT(0xc0ea0006),
    ERROR_CLIP_LICENSE_SIGNED_BY_UNKNOWN_SOURCE     = HRESULT(0xc0ea0007),
    ERROR_CLIP_LICENSE_NOT_SIGNED                   = HRESULT(0xc0ea0008),
    ERROR_CLIP_LICENSE_HARDWARE_ID_OUT_OF_TOLERANCE = HRESULT(0xc0ea0009),
    ERROR_CLIP_LICENSE_DEVICE_ID_MISMATCH           = HRESULT(0xc0ea000a),
}

enum : HRESULT
{
    DXGI_STATUS_OCCLUDED                     = HRESULT(0x087a0001),
    DXGI_STATUS_CLIPPED                      = HRESULT(0x087a0002),
    DXGI_STATUS_NO_REDIRECTION               = HRESULT(0x087a0004),
    DXGI_STATUS_NO_DESKTOP_ACCESS            = HRESULT(0x087a0005),
    DXGI_STATUS_GRAPHICS_VIDPN_SOURCE_IN_USE = HRESULT(0x087a0006),
}

enum : HRESULT
{
    DXGI_STATUS_MODE_CHANGED            = HRESULT(0x087a0007),
    DXGI_STATUS_MODE_CHANGE_IN_PROGRESS = HRESULT(0x087a0008),
}

enum HRESULT DXCORE_ERROR_EVENT_NOT_UNREGISTERED = HRESULT(0x88800001);
enum HRESULT PRESENTATION_ERROR_LOST = HRESULT(0x88810001);

enum : HRESULT
{
    DXGI_STATUS_UNOCCLUDED            = HRESULT(0x087a0009),
    DXGI_STATUS_DDA_WAS_STILL_DRAWING = HRESULT(0x087a000a),
}

enum HRESULT DXGI_STATUS_PRESENT_REQUIRED = HRESULT(0x087a002f);

enum : HRESULT
{
    DXGI_DDI_ERR_WASSTILLDRAWING = HRESULT(0x887b0001),
    DXGI_DDI_ERR_UNSUPPORTED     = HRESULT(0x887b0002),
    DXGI_DDI_ERR_NONEXCLUSIVE    = HRESULT(0x887b0003),
}

enum HRESULT D3D10_ERROR_TOO_MANY_UNIQUE_STATE_OBJECTS = HRESULT(0x88790001);
enum HRESULT D3D10_ERROR_FILE_NOT_FOUND = HRESULT(0x88790002);
enum HRESULT D3D11_ERROR_TOO_MANY_UNIQUE_STATE_OBJECTS = HRESULT(0x887c0001);

enum : HRESULT
{
    D3D11_ERROR_FILE_NOT_FOUND               = HRESULT(0x887c0002),
    D3D11_ERROR_TOO_MANY_UNIQUE_VIEW_OBJECTS = HRESULT(0x887c0003),
}

enum HRESULT D3D11_ERROR_DEFERRED_CONTEXT_MAP_WITHOUT_INITIAL_DISCARD = HRESULT(0x887c0004);

enum : HRESULT
{
    D3D12_ERROR_ADAPTER_NOT_FOUND       = HRESULT(0x887e0001),
    D3D12_ERROR_DRIVER_VERSION_MISMATCH = HRESULT(0x887e0002),
}

enum HRESULT D3D12_ERROR_INVALID_REDIST = HRESULT(0x887e0003);
enum HRESULT D2DERR_WRONG_STATE = HRESULT(0x88990001);
enum HRESULT D2DERR_NOT_INITIALIZED = HRESULT(0x88990002);
enum HRESULT D2DERR_UNSUPPORTED_OPERATION = HRESULT(0x88990003);

enum : HRESULT
{
    D2DERR_SCANNER_FAILED       = HRESULT(0x88990004),
    D2DERR_SCREEN_ACCESS_DENIED = HRESULT(0x88990005),
}

enum HRESULT D2DERR_DISPLAY_STATE_INVALID = HRESULT(0x88990006);
enum HRESULT D2DERR_ZERO_VECTOR = HRESULT(0x88990007);
enum HRESULT D2DERR_INTERNAL_ERROR = HRESULT(0x88990008);
enum HRESULT D2DERR_DISPLAY_FORMAT_NOT_SUPPORTED = HRESULT(0x88990009);
enum HRESULT D2DERR_INVALID_CALL = HRESULT(0x8899000a);
enum HRESULT D2DERR_NO_HARDWARE_DEVICE = HRESULT(0x8899000b);
enum HRESULT D2DERR_RECREATE_TARGET = HRESULT(0x8899000c);
enum HRESULT D2DERR_TOO_MANY_SHADER_ELEMENTS = HRESULT(0x8899000d);
enum HRESULT D2DERR_SHADER_COMPILE_FAILED = HRESULT(0x8899000e);
enum HRESULT D2DERR_MAX_TEXTURE_SIZE_EXCEEDED = HRESULT(0x8899000f);
enum HRESULT D2DERR_UNSUPPORTED_VERSION = HRESULT(0x88990010);

enum : HRESULT
{
    D2DERR_BAD_NUMBER    = HRESULT(0x88990011),
    D2DERR_WRONG_FACTORY = HRESULT(0x88990012),
}

enum HRESULT D2DERR_LAYER_ALREADY_IN_USE = HRESULT(0x88990013);
enum HRESULT D2DERR_POP_CALL_DID_NOT_MATCH_PUSH = HRESULT(0x88990014);
enum HRESULT D2DERR_WRONG_RESOURCE_DOMAIN = HRESULT(0x88990015);
enum HRESULT D2DERR_PUSH_POP_UNBALANCED = HRESULT(0x88990016);
enum HRESULT D2DERR_RENDER_TARGET_HAS_LAYER_OR_CLIPRECT = HRESULT(0x88990017);
enum HRESULT D2DERR_INCOMPATIBLE_BRUSH_TYPES = HRESULT(0x88990018);
enum HRESULT D2DERR_WIN32_ERROR = HRESULT(0x88990019);
enum HRESULT D2DERR_TARGET_NOT_GDI_COMPATIBLE = HRESULT(0x8899001a);
enum HRESULT D2DERR_TEXT_EFFECT_IS_WRONG_TYPE = HRESULT(0x8899001b);
enum HRESULT D2DERR_TEXT_RENDERER_NOT_RELEASED = HRESULT(0x8899001c);
enum HRESULT D2DERR_EXCEEDS_MAX_BITMAP_SIZE = HRESULT(0x8899001d);

enum : HRESULT
{
    D2DERR_INVALID_GRAPH_CONFIGURATION          = HRESULT(0x8899001e),
    D2DERR_INVALID_INTERNAL_GRAPH_CONFIGURATION = HRESULT(0x8899001f),
}

enum HRESULT D2DERR_CYCLIC_GRAPH = HRESULT(0x88990020);
enum HRESULT D2DERR_BITMAP_CANNOT_DRAW = HRESULT(0x88990021);
enum HRESULT D2DERR_OUTSTANDING_BITMAP_REFERENCES = HRESULT(0x88990022);
enum HRESULT D2DERR_ORIGINAL_TARGET_NOT_BOUND = HRESULT(0x88990023);
enum HRESULT D2DERR_INVALID_TARGET = HRESULT(0x88990024);
enum HRESULT D2DERR_BITMAP_BOUND_AS_TARGET = HRESULT(0x88990025);
enum HRESULT D2DERR_INSUFFICIENT_DEVICE_CAPABILITIES = HRESULT(0x88990026);
enum HRESULT D2DERR_INTERMEDIATE_TOO_LARGE = HRESULT(0x88990027);
enum HRESULT D2DERR_EFFECT_IS_NOT_REGISTERED = HRESULT(0x88990028);
enum HRESULT D2DERR_INVALID_PROPERTY = HRESULT(0x88990029);
enum HRESULT D2DERR_NO_SUBPROPERTIES = HRESULT(0x8899002a);

enum : HRESULT
{
    D2DERR_PRINT_JOB_CLOSED           = HRESULT(0x8899002b),
    D2DERR_PRINT_FORMAT_NOT_SUPPORTED = HRESULT(0x8899002c),
}

enum HRESULT D2DERR_TOO_MANY_TRANSFORM_INPUTS = HRESULT(0x8899002d);
enum HRESULT D2DERR_INVALID_GLYPH_IMAGE = HRESULT(0x8899002e);

enum : HRESULT
{
    DWRITE_E_FILEFORMAT             = HRESULT(0x88985000),
    DWRITE_E_UNEXPECTED             = HRESULT(0x88985001),
    DWRITE_E_NOFONT                 = HRESULT(0x88985002),
    DWRITE_E_FILENOTFOUND           = HRESULT(0x88985003),
    DWRITE_E_FILEACCESS             = HRESULT(0x88985004),
    DWRITE_E_FONTCOLLECTIONOBSOLETE = HRESULT(0x88985005),
}

enum HRESULT DWRITE_E_ALREADYREGISTERED = HRESULT(0x88985006);

enum : HRESULT
{
    DWRITE_E_CACHEFORMAT          = HRESULT(0x88985007),
    DWRITE_E_CACHEVERSION         = HRESULT(0x88985008),
    DWRITE_E_UNSUPPORTEDOPERATION = HRESULT(0x88985009),
}

enum HRESULT DWRITE_E_TEXTRENDERERINCOMPATIBLE = HRESULT(0x8898500a);
enum HRESULT DWRITE_E_FLOWDIRECTIONCONFLICTS = HRESULT(0x8898500b);
enum HRESULT DWRITE_E_NOCOLOR = HRESULT(0x8898500c);

enum : HRESULT
{
    WINCODEC_ERR_WRONGSTATE            = HRESULT(0x88982f04),
    WINCODEC_ERR_VALUEOUTOFRANGE       = HRESULT(0x88982f05),
    WINCODEC_ERR_UNKNOWNIMAGEFORMAT    = HRESULT(0x88982f07),
    WINCODEC_ERR_UNSUPPORTEDVERSION    = HRESULT(0x88982f0b),
    WINCODEC_ERR_NOTINITIALIZED        = HRESULT(0x88982f0c),
    WINCODEC_ERR_ALREADYLOCKED         = HRESULT(0x88982f0d),
    WINCODEC_ERR_PROPERTYNOTFOUND      = HRESULT(0x88982f40),
    WINCODEC_ERR_PROPERTYNOTSUPPORTED  = HRESULT(0x88982f41),
    WINCODEC_ERR_PROPERTYSIZE          = HRESULT(0x88982f42),
    WINCODEC_ERR_CODECPRESENT          = HRESULT(0x88982f43),
    WINCODEC_ERR_CODECNOTHUMBNAIL      = HRESULT(0x88982f44),
    WINCODEC_ERR_PALETTEUNAVAILABLE    = HRESULT(0x88982f45),
    WINCODEC_ERR_CODECTOOMANYSCANLINES = HRESULT(0x88982f46),
}

enum : HRESULT
{
    WINCODEC_ERR_INTERNALERROR                    = HRESULT(0x88982f48),
    WINCODEC_ERR_SOURCERECTDOESNOTMATCHDIMENSIONS = HRESULT(0x88982f49),
}

enum : HRESULT
{
    WINCODEC_ERR_COMPONENTNOTFOUND      = HRESULT(0x88982f50),
    WINCODEC_ERR_IMAGESIZEOUTOFRANGE    = HRESULT(0x88982f51),
    WINCODEC_ERR_TOOMUCHMETADATA        = HRESULT(0x88982f52),
    WINCODEC_ERR_BADIMAGE               = HRESULT(0x88982f60),
    WINCODEC_ERR_BADHEADER              = HRESULT(0x88982f61),
    WINCODEC_ERR_FRAMEMISSING           = HRESULT(0x88982f62),
    WINCODEC_ERR_BADMETADATAHEADER      = HRESULT(0x88982f63),
    WINCODEC_ERR_BADSTREAMDATA          = HRESULT(0x88982f70),
    WINCODEC_ERR_STREAMWRITE            = HRESULT(0x88982f71),
    WINCODEC_ERR_STREAMREAD             = HRESULT(0x88982f72),
    WINCODEC_ERR_STREAMNOTAVAILABLE     = HRESULT(0x88982f73),
    WINCODEC_ERR_UNSUPPORTEDPIXELFORMAT = HRESULT(0x88982f80),
    WINCODEC_ERR_UNSUPPORTEDOPERATION   = HRESULT(0x88982f81),
}

enum : HRESULT
{
    WINCODEC_ERR_INVALIDREGISTRATION        = HRESULT(0x88982f8a),
    WINCODEC_ERR_COMPONENTINITIALIZEFAILURE = HRESULT(0x88982f8b),
}

enum : HRESULT
{
    WINCODEC_ERR_INSUFFICIENTBUFFER       = HRESULT(0x88982f8c),
    WINCODEC_ERR_DUPLICATEMETADATAPRESENT = HRESULT(0x88982f8d),
}

enum HRESULT WINCODEC_ERR_PROPERTYUNEXPECTEDTYPE = HRESULT(0x88982f8e);

enum : HRESULT
{
    WINCODEC_ERR_UNEXPECTEDSIZE         = HRESULT(0x88982f8f),
    WINCODEC_ERR_INVALIDQUERYREQUEST    = HRESULT(0x88982f90),
    WINCODEC_ERR_UNEXPECTEDMETADATATYPE = HRESULT(0x88982f91),
}

enum HRESULT WINCODEC_ERR_REQUESTONLYVALIDATMETADATAROOT = HRESULT(0x88982f92);
enum HRESULT WINCODEC_ERR_INVALIDQUERYCHARACTER = HRESULT(0x88982f93);

enum : HRESULT
{
    WINCODEC_ERR_WIN32ERROR              = HRESULT(0x88982f94),
    WINCODEC_ERR_INVALIDPROGRESSIVELEVEL = HRESULT(0x88982f95),
    WINCODEC_ERR_INVALIDJPEGSCANINDEX    = HRESULT(0x88982f96),
}

enum HRESULT WINCODEC_ERR_UNSUPPORTEDTONEMAPPING = HRESULT(0x88982f97);

enum : HRESULT
{
    MILERR_OBJECTBUSY         = HRESULT(0x88980001),
    MILERR_INSUFFICIENTBUFFER = HRESULT(0x88980002),
}

enum : HRESULT
{
    MILERR_WIN32ERROR         = HRESULT(0x88980003),
    MILERR_SCANNER_FAILED     = HRESULT(0x88980004),
    MILERR_SCREENACCESSDENIED = HRESULT(0x88980005),
}

enum HRESULT MILERR_DISPLAYSTATEINVALID = HRESULT(0x88980006);
enum HRESULT MILERR_NONINVERTIBLEMATRIX = HRESULT(0x88980007);

enum : HRESULT
{
    MILERR_ZEROVECTOR    = HRESULT(0x88980008),
    MILERR_TERMINATED    = HRESULT(0x88980009),
    MILERR_BADNUMBER     = HRESULT(0x8898000a),
    MILERR_INTERNALERROR = HRESULT(0x88980080),
}

enum HRESULT MILERR_DISPLAYFORMATNOTSUPPORTED = HRESULT(0x88980084);
enum HRESULT MILERR_INVALIDCALL = HRESULT(0x88980085);
enum HRESULT MILERR_ALREADYLOCKED = HRESULT(0x88980086);

enum : HRESULT
{
    MILERR_NOTLOCKED              = HRESULT(0x88980087),
    MILERR_DEVICECANNOTRENDERTEXT = HRESULT(0x88980088),
}

enum HRESULT MILERR_GLYPHBITMAPMISSED = HRESULT(0x88980089);
enum HRESULT MILERR_MALFORMEDGLYPHCACHE = HRESULT(0x8898008a);
enum HRESULT MILERR_GENERIC_IGNORE = HRESULT(0x8898008b);
enum HRESULT MILERR_MALFORMED_GUIDELINE_DATA = HRESULT(0x8898008c);
enum HRESULT MILERR_NO_HARDWARE_DEVICE = HRESULT(0x8898008d);
enum HRESULT MILERR_NEED_RECREATE_AND_PRESENT = HRESULT(0x8898008e);
enum HRESULT MILERR_ALREADY_INITIALIZED = HRESULT(0x8898008f);
enum HRESULT MILERR_MISMATCHED_SIZE = HRESULT(0x88980090);
enum HRESULT MILERR_NO_REDIRECTION_SURFACE_AVAILABLE = HRESULT(0x88980091);
enum HRESULT MILERR_REMOTING_NOT_SUPPORTED = HRESULT(0x88980092);
enum HRESULT MILERR_QUEUED_PRESENT_NOT_SUPPORTED = HRESULT(0x88980093);
enum HRESULT MILERR_NOT_QUEUING_PRESENTS = HRESULT(0x88980094);
enum HRESULT MILERR_NO_REDIRECTION_SURFACE_RETRY_LATER = HRESULT(0x88980095);
enum HRESULT MILERR_TOOMANYSHADERELEMNTS = HRESULT(0x88980096);

enum : HRESULT
{
    MILERR_MROW_READLOCK_FAILED = HRESULT(0x88980097),
    MILERR_MROW_UPDATE_FAILED   = HRESULT(0x88980098),
}

enum HRESULT MILERR_SHADER_COMPILE_FAILED = HRESULT(0x88980099);
enum HRESULT MILERR_MAX_TEXTURE_SIZE_EXCEEDED = HRESULT(0x8898009a);
enum HRESULT MILERR_QPC_TIME_WENT_BACKWARD = HRESULT(0x8898009b);
enum HRESULT MILERR_DXGI_ENUMERATION_OUT_OF_SYNC = HRESULT(0x8898009d);
enum HRESULT MILERR_ADAPTER_NOT_FOUND = HRESULT(0x8898009e);
enum HRESULT MILERR_COLORSPACE_NOT_SUPPORTED = HRESULT(0x8898009f);
enum HRESULT MILERR_PREFILTER_NOT_SUPPORTED = HRESULT(0x889800a0);
enum HRESULT MILERR_DISPLAYID_ACCESS_DENIED = HRESULT(0x889800a1);
enum HRESULT MILERR_DEVICE_CREATION_FAILURE = HRESULT(0x889800b0);
enum HRESULT MILERR_INTEL_DEVICE_CREATION_FAILURE = HRESULT(0x889800b1);
enum HRESULT MILERR_AMD_DEVICE_CREATION_FAILURE = HRESULT(0x889800b2);
enum HRESULT MILERR_NVIDIA_DEVICE_CREATION_FAILURE = HRESULT(0x889800b3);
enum HRESULT MILERR_QC_DEVICE_CREATION_FAILURE = HRESULT(0x889800b4);
enum HRESULT MILERR_SWAPCHAIN_CREATION_FAILURE = HRESULT(0x889800c0);
enum HRESULT MILERR_INTEL_SWAPCHAIN_CREATION_FAILURE = HRESULT(0x889800c1);
enum HRESULT MILERR_AMD_SWAPCHAIN_CREATION_FAILURE = HRESULT(0x889800c2);
enum HRESULT MILERR_NVIDIA_SWAPCHAIN_CREATION_FAILURE = HRESULT(0x889800c3);
enum HRESULT MILERR_QC_SWAPCHAIN_CREATION_FAILURE = HRESULT(0x889800c4);
enum HRESULT MILERR_IDD_SWAPCHAIN_CREATION_FAILURE = HRESULT(0x889800c5);
enum HRESULT MILERR_PRESENT_FAILURE = HRESULT(0x889800d0);
enum HRESULT MILERR_INTEL_PRESENT_FAILURE = HRESULT(0x889800d1);
enum HRESULT MILERR_AMD_PRESENT_FAILURE = HRESULT(0x889800d2);
enum HRESULT MILERR_NVIDIA_PRESENT_FAILURE = HRESULT(0x889800d3);
enum HRESULT MILERR_QC_PRESENT_FAILURE = HRESULT(0x889800d4);
enum HRESULT MILERR_IDD_PRESENT_FAILURE = HRESULT(0x889800d5);
enum HRESULT UCEERR_INVALIDPACKETHEADER = HRESULT(0x88980400);
enum HRESULT UCEERR_UNKNOWNPACKET = HRESULT(0x88980401);
enum HRESULT UCEERR_ILLEGALPACKET = HRESULT(0x88980402);
enum HRESULT UCEERR_MALFORMEDPACKET = HRESULT(0x88980403);
enum HRESULT UCEERR_ILLEGALHANDLE = HRESULT(0x88980404);
enum HRESULT UCEERR_HANDLELOOKUPFAILED = HRESULT(0x88980405);
enum HRESULT UCEERR_RENDERTHREADFAILURE = HRESULT(0x88980406);
enum HRESULT UCEERR_CTXSTACKFRSTTARGETNULL = HRESULT(0x88980407);
enum HRESULT UCEERR_CONNECTIONIDLOOKUPFAILED = HRESULT(0x88980408);

enum : HRESULT
{
    UCEERR_BLOCKSFULL    = HRESULT(0x88980409),
    UCEERR_MEMORYFAILURE = HRESULT(0x8898040a),
}

enum HRESULT UCEERR_PACKETRECORDOUTOFRANGE = HRESULT(0x8898040b);
enum HRESULT UCEERR_ILLEGALRECORDTYPE = HRESULT(0x8898040c);
enum HRESULT UCEERR_OUTOFHANDLES = HRESULT(0x8898040d);
enum HRESULT UCEERR_UNCHANGABLE_UPDATE_ATTEMPTED = HRESULT(0x8898040e);
enum HRESULT UCEERR_NO_MULTIPLE_WORKER_THREADS = HRESULT(0x8898040f);
enum HRESULT UCEERR_REMOTINGNOTSUPPORTED = HRESULT(0x88980410);

enum : HRESULT
{
    UCEERR_MISSINGENDCOMMAND   = HRESULT(0x88980411),
    UCEERR_MISSINGBEGINCOMMAND = HRESULT(0x88980412),
}

enum : HRESULT
{
    UCEERR_CHANNELSYNCTIMEDOUT  = HRESULT(0x88980413),
    UCEERR_CHANNELSYNCABANDONED = HRESULT(0x88980414),
}

enum HRESULT UCEERR_UNSUPPORTEDTRANSPORTVERSION = HRESULT(0x88980415);
enum HRESULT UCEERR_TRANSPORTUNAVAILABLE = HRESULT(0x88980416);
enum HRESULT UCEERR_FEEDBACK_UNSUPPORTED = HRESULT(0x88980417);
enum HRESULT UCEERR_COMMANDTRANSPORTDENIED = HRESULT(0x88980418);

enum : HRESULT
{
    UCEERR_GRAPHICSSTREAMUNAVAILABLE = HRESULT(0x88980419),
    UCEERR_GRAPHICSSTREAMALREADYOPEN = HRESULT(0x88980420),
}

enum : HRESULT
{
    UCEERR_TRANSPORTDISCONNECTED = HRESULT(0x88980421),
    UCEERR_TRANSPORTOVERLOADED   = HRESULT(0x88980422),
}

enum HRESULT UCEERR_PARTITION_ZOMBIED = HRESULT(0x88980423);

enum : HRESULT
{
    MILAVERR_NOCLOCK          = HRESULT(0x88980500),
    MILAVERR_NOMEDIATYPE      = HRESULT(0x88980501),
    MILAVERR_NOVIDEOMIXER     = HRESULT(0x88980502),
    MILAVERR_NOVIDEOPRESENTER = HRESULT(0x88980503),
    MILAVERR_NOREADYFRAMES    = HRESULT(0x88980504),
    MILAVERR_MODULENOTLOADED  = HRESULT(0x88980505),
}

enum HRESULT MILAVERR_WMPFACTORYNOTREGISTERED = HRESULT(0x88980506);

enum : HRESULT
{
    MILAVERR_INVALIDWMPVERSION          = HRESULT(0x88980507),
    MILAVERR_INSUFFICIENTVIDEORESOURCES = HRESULT(0x88980508),
}

enum HRESULT MILAVERR_VIDEOACCELERATIONNOTAVAILABLE = HRESULT(0x88980509);
enum HRESULT MILAVERR_REQUESTEDTEXTURETOOBIG = HRESULT(0x8898050a);

enum : HRESULT
{
    MILAVERR_SEEKFAILED           = HRESULT(0x8898050b),
    MILAVERR_UNEXPECTEDWMPFAILURE = HRESULT(0x8898050c),
}

enum HRESULT MILAVERR_MEDIAPLAYERCLOSED = HRESULT(0x8898050d);
enum HRESULT MILAVERR_UNKNOWNHARDWAREERROR = HRESULT(0x8898050e);

enum : HRESULT
{
    MILEFFECTSERR_UNKNOWNPROPERTY       = HRESULT(0x8898060e),
    MILEFFECTSERR_EFFECTNOTPARTOFGROUP  = HRESULT(0x8898060f),
    MILEFFECTSERR_NOINPUTSOURCEATTACHED = HRESULT(0x88980610),
}

enum : HRESULT
{
    MILEFFECTSERR_CONNECTORNOTCONNECTED            = HRESULT(0x88980611),
    MILEFFECTSERR_CONNECTORNOTASSOCIATEDWITHEFFECT = HRESULT(0x88980612),
}

enum : HRESULT
{
    MILEFFECTSERR_RESERVED                  = HRESULT(0x88980613),
    MILEFFECTSERR_CYCLEDETECTED             = HRESULT(0x88980614),
    MILEFFECTSERR_EFFECTINMORETHANONEGRAPH  = HRESULT(0x88980615),
    MILEFFECTSERR_EFFECTALREADYINAGRAPH     = HRESULT(0x88980616),
    MILEFFECTSERR_EFFECTHASNOCHILDREN       = HRESULT(0x88980617),
    MILEFFECTSERR_ALREADYATTACHEDTOLISTENER = HRESULT(0x88980618),
}

enum : HRESULT
{
    MILEFFECTSERR_NOTAFFINETRANSFORM = HRESULT(0x88980619),
    MILEFFECTSERR_EMPTYBOUNDS        = HRESULT(0x8898061a),
    MILEFFECTSERR_OUTPUTSIZETOOLARGE = HRESULT(0x8898061b),
}

enum HRESULT DWMERR_STATE_TRANSITION_FAILED = HRESULT(0x88980700);
enum HRESULT DWMERR_THEME_FAILED = HRESULT(0x88980701);
enum HRESULT DWMERR_CATASTROPHIC_FAILURE = HRESULT(0x88980702);

enum : HRESULT
{
    DCOMPOSITION_ERROR_WINDOW_ALREADY_COMPOSED    = HRESULT(0x88980800),
    DCOMPOSITION_ERROR_SURFACE_BEING_RENDERED     = HRESULT(0x88980801),
    DCOMPOSITION_ERROR_SURFACE_NOT_BEING_RENDERED = HRESULT(0x88980802),
}

enum HRESULT ONL_E_INVALID_AUTHENTICATION_TARGET = HRESULT(0x80860001);
enum HRESULT ONL_E_ACCESS_DENIED_BY_TOU = HRESULT(0x80860002);
enum HRESULT ONL_E_INVALID_APPLICATION = HRESULT(0x80860003);
enum HRESULT ONL_E_PASSWORD_UPDATE_REQUIRED = HRESULT(0x80860004);
enum HRESULT ONL_E_ACCOUNT_UPDATE_REQUIRED = HRESULT(0x80860005);
enum HRESULT ONL_E_FORCESIGNIN = HRESULT(0x80860006);
enum HRESULT ONL_E_ACCOUNT_LOCKED = HRESULT(0x80860007);
enum HRESULT ONL_E_PARENTAL_CONSENT_REQUIRED = HRESULT(0x80860008);
enum HRESULT ONL_E_EMAIL_VERIFICATION_REQUIRED = HRESULT(0x80860009);

enum : HRESULT
{
    ONL_E_ACCOUNT_SUSPENDED_COMPROIMISE = HRESULT(0x8086000a),
    ONL_E_ACCOUNT_SUSPENDED_ABUSE       = HRESULT(0x8086000b),
}

enum HRESULT ONL_E_ACTION_REQUIRED = HRESULT(0x8086000c);
enum HRESULT ONL_CONNECTION_COUNT_LIMIT = HRESULT(0x8086000d);
enum HRESULT ONL_E_CONNECTED_ACCOUNT_CAN_NOT_SIGNOUT = HRESULT(0x8086000e);
enum HRESULT ONL_E_USER_AUTHENTICATION_REQUIRED = HRESULT(0x8086000f);
enum HRESULT ONL_E_REQUEST_THROTTLED = HRESULT(0x80860010);
enum HRESULT FA_E_MAX_PERSISTED_ITEMS_REACHED = HRESULT(0x80270220);
enum HRESULT FA_E_HOMEGROUP_NOT_AVAILABLE = HRESULT(0x80270222);
enum HRESULT E_MONITOR_RESOLUTION_TOO_LOW = HRESULT(0x80270250);
enum HRESULT E_ELEVATED_ACTIVATION_NOT_SUPPORTED = HRESULT(0x80270251);
enum HRESULT E_UAC_DISABLED = HRESULT(0x80270252);
enum HRESULT E_FULL_ADMIN_NOT_SUPPORTED = HRESULT(0x80270253);
enum HRESULT E_APPLICATION_NOT_REGISTERED = HRESULT(0x80270254);
enum HRESULT E_MULTIPLE_EXTENSIONS_FOR_APPLICATION = HRESULT(0x80270255);
enum HRESULT E_MULTIPLE_PACKAGES_FOR_FAMILY = HRESULT(0x80270256);
enum HRESULT E_APPLICATION_MANAGER_NOT_RUNNING = HRESULT(0x80270257);
enum HRESULT S_STORE_LAUNCHED_FOR_REMEDIATION = HRESULT(0x00270258);
enum HRESULT S_APPLICATION_ACTIVATION_ERROR_HANDLED_BY_DIALOG = HRESULT(0x00270259);

enum : HRESULT
{
    E_APPLICATION_ACTIVATION_TIMED_OUT    = HRESULT(0x8027025a),
    E_APPLICATION_ACTIVATION_EXEC_FAILURE = HRESULT(0x8027025b),
}

enum : HRESULT
{
    E_APPLICATION_TEMPORARY_LICENSE_ERROR = HRESULT(0x8027025c),
    E_APPLICATION_TRIAL_LICENSE_EXPIRED   = HRESULT(0x8027025d),
}

enum : HRESULT
{
    E_SKYDRIVE_ROOT_TARGET_FILE_SYSTEM_NOT_SUPPORTED = HRESULT(0x80270260),
    E_SKYDRIVE_ROOT_TARGET_OVERLAP                   = HRESULT(0x80270261),
    E_SKYDRIVE_ROOT_TARGET_CANNOT_INDEX              = HRESULT(0x80270262),
}

enum HRESULT E_SKYDRIVE_FILE_NOT_UPLOADED = HRESULT(0x80270263);
enum HRESULT E_SKYDRIVE_UPDATE_AVAILABILITY_FAIL = HRESULT(0x80270264);
enum HRESULT E_SKYDRIVE_ROOT_TARGET_VOLUME_ROOT_NOT_SUPPORTED = HRESULT(0x80270265);

enum : HRESULT
{
    E_SYNCENGINE_FILE_SIZE_OVER_LIMIT              = HRESULT(0x8802b001),
    E_SYNCENGINE_FILE_SIZE_EXCEEDS_REMAINING_QUOTA = HRESULT(0x8802b002),
}

enum HRESULT E_SYNCENGINE_UNSUPPORTED_FILE_NAME = HRESULT(0x8802b003);
enum HRESULT E_SYNCENGINE_FOLDER_ITEM_COUNT_LIMIT_EXCEEDED = HRESULT(0x8802b004);
enum HRESULT E_SYNCENGINE_FILE_SYNC_PARTNER_ERROR = HRESULT(0x8802b005);
enum HRESULT E_SYNCENGINE_SYNC_PAUSED_BY_SERVICE = HRESULT(0x8802b006);
enum HRESULT E_SYNCENGINE_FILE_IDENTIFIER_UNKNOWN = HRESULT(0x8802c002);
enum HRESULT E_SYNCENGINE_SERVICE_AUTHENTICATION_FAILED = HRESULT(0x8802c003);
enum HRESULT E_SYNCENGINE_UNKNOWN_SERVICE_ERROR = HRESULT(0x8802c004);
enum HRESULT E_SYNCENGINE_SERVICE_RETURNED_UNEXPECTED_SIZE = HRESULT(0x8802c005);

enum : HRESULT
{
    E_SYNCENGINE_REQUEST_BLOCKED_BY_SERVICE          = HRESULT(0x8802c006),
    E_SYNCENGINE_REQUEST_BLOCKED_DUE_TO_CLIENT_ERROR = HRESULT(0x8802c007),
}

enum : HRESULT
{
    E_SYNCENGINE_FOLDER_INACCESSIBLE        = HRESULT(0x8802d001),
    E_SYNCENGINE_UNSUPPORTED_FOLDER_NAME    = HRESULT(0x8802d002),
    E_SYNCENGINE_UNSUPPORTED_MARKET         = HRESULT(0x8802d003),
    E_SYNCENGINE_PATH_LENGTH_LIMIT_EXCEEDED = HRESULT(0x8802d004),
}

enum HRESULT E_SYNCENGINE_REMOTE_PATH_LENGTH_LIMIT_EXCEEDED = HRESULT(0x8802d005);
enum HRESULT E_SYNCENGINE_CLIENT_UPDATE_NEEDED = HRESULT(0x8802d006);
enum HRESULT E_SYNCENGINE_PROXY_AUTHENTICATION_REQUIRED = HRESULT(0x8802d007);
enum HRESULT E_SYNCENGINE_STORAGE_SERVICE_PROVISIONING_FAILED = HRESULT(0x8802d008);
enum HRESULT E_SYNCENGINE_UNSUPPORTED_REPARSE_POINT = HRESULT(0x8802d009);
enum HRESULT E_SYNCENGINE_STORAGE_SERVICE_BLOCKED = HRESULT(0x8802d00a);
enum HRESULT E_SYNCENGINE_FOLDER_IN_REDIRECTION = HRESULT(0x8802d00b);

enum : HRESULT
{
    EAS_E_POLICY_NOT_MANAGED_BY_OS      = HRESULT(0x80550001),
    EAS_E_POLICY_COMPLIANT_WITH_ACTIONS = HRESULT(0x80550002),
}

enum HRESULT EAS_E_REQUESTED_POLICY_NOT_ENFORCEABLE = HRESULT(0x80550003);
enum HRESULT EAS_E_CURRENT_USER_HAS_BLANK_PASSWORD = HRESULT(0x80550004);
enum HRESULT EAS_E_REQUESTED_POLICY_PASSWORD_EXPIRATION_INCOMPATIBLE = HRESULT(0x80550005);
enum HRESULT EAS_E_USER_CANNOT_CHANGE_PASSWORD = HRESULT(0x80550006);

enum : HRESULT
{
    EAS_E_ADMINS_HAVE_BLANK_PASSWORD    = HRESULT(0x80550007),
    EAS_E_ADMINS_CANNOT_CHANGE_PASSWORD = HRESULT(0x80550008),
}

enum HRESULT EAS_E_LOCAL_CONTROLLED_USERS_CANNOT_CHANGE_PASSWORD = HRESULT(0x80550009);
enum HRESULT EAS_E_PASSWORD_POLICY_NOT_ENFORCEABLE_FOR_CONNECTED_ADMINS = HRESULT(0x8055000a);
enum HRESULT EAS_E_CONNECTED_ADMINS_NEED_TO_CHANGE_PASSWORD = HRESULT(0x8055000b);
enum HRESULT EAS_E_PASSWORD_POLICY_NOT_ENFORCEABLE_FOR_CURRENT_CONNECTED_USER = HRESULT(0x8055000c);
enum HRESULT EAS_E_CURRENT_CONNECTED_USER_NEED_TO_CHANGE_PASSWORD = HRESULT(0x8055000d);
enum HRESULT WEB_E_UNSUPPORTED_FORMAT = HRESULT(0x83750001);
enum HRESULT WEB_E_INVALID_XML = HRESULT(0x83750002);

enum : HRESULT
{
    WEB_E_MISSING_REQUIRED_ELEMENT   = HRESULT(0x83750003),
    WEB_E_MISSING_REQUIRED_ATTRIBUTE = HRESULT(0x83750004),
}

enum HRESULT WEB_E_UNEXPECTED_CONTENT = HRESULT(0x83750005);
enum HRESULT WEB_E_RESOURCE_TOO_LARGE = HRESULT(0x83750006);

enum : HRESULT
{
    WEB_E_INVALID_JSON_STRING = HRESULT(0x83750007),
    WEB_E_INVALID_JSON_NUMBER = HRESULT(0x83750008),
}

enum HRESULT WEB_E_JSON_VALUE_NOT_FOUND = HRESULT(0x83750009);

enum : HRESULT
{
    HTTP_E_STATUS_UNEXPECTED              = HRESULT(0x80190001),
    HTTP_E_STATUS_UNEXPECTED_REDIRECTION  = HRESULT(0x80190003),
    HTTP_E_STATUS_UNEXPECTED_CLIENT_ERROR = HRESULT(0x80190004),
    HTTP_E_STATUS_UNEXPECTED_SERVER_ERROR = HRESULT(0x80190005),
}

enum : HRESULT
{
    HTTP_E_STATUS_AMBIGUOUS             = HRESULT(0x8019012c),
    HTTP_E_STATUS_MOVED                 = HRESULT(0x8019012d),
    HTTP_E_STATUS_REDIRECT              = HRESULT(0x8019012e),
    HTTP_E_STATUS_REDIRECT_METHOD       = HRESULT(0x8019012f),
    HTTP_E_STATUS_NOT_MODIFIED          = HRESULT(0x80190130),
    HTTP_E_STATUS_USE_PROXY             = HRESULT(0x80190131),
    HTTP_E_STATUS_REDIRECT_KEEP_VERB    = HRESULT(0x80190133),
    HTTP_E_STATUS_BAD_REQUEST           = HRESULT(0x80190190),
    HTTP_E_STATUS_DENIED                = HRESULT(0x80190191),
    HTTP_E_STATUS_PAYMENT_REQ           = HRESULT(0x80190192),
    HTTP_E_STATUS_FORBIDDEN             = HRESULT(0x80190193),
    HTTP_E_STATUS_NOT_FOUND             = HRESULT(0x80190194),
    HTTP_E_STATUS_BAD_METHOD            = HRESULT(0x80190195),
    HTTP_E_STATUS_NONE_ACCEPTABLE       = HRESULT(0x80190196),
    HTTP_E_STATUS_PROXY_AUTH_REQ        = HRESULT(0x80190197),
    HTTP_E_STATUS_REQUEST_TIMEOUT       = HRESULT(0x80190198),
    HTTP_E_STATUS_CONFLICT              = HRESULT(0x80190199),
    HTTP_E_STATUS_GONE                  = HRESULT(0x8019019a),
    HTTP_E_STATUS_LENGTH_REQUIRED       = HRESULT(0x8019019b),
    HTTP_E_STATUS_PRECOND_FAILED        = HRESULT(0x8019019c),
    HTTP_E_STATUS_REQUEST_TOO_LARGE     = HRESULT(0x8019019d),
    HTTP_E_STATUS_URI_TOO_LONG          = HRESULT(0x8019019e),
    HTTP_E_STATUS_UNSUPPORTED_MEDIA     = HRESULT(0x8019019f),
    HTTP_E_STATUS_RANGE_NOT_SATISFIABLE = HRESULT(0x801901a0),
}

enum : HRESULT
{
    HTTP_E_STATUS_EXPECTATION_FAILED = HRESULT(0x801901a1),
    HTTP_E_STATUS_SERVER_ERROR       = HRESULT(0x801901f4),
    HTTP_E_STATUS_NOT_SUPPORTED      = HRESULT(0x801901f5),
    HTTP_E_STATUS_BAD_GATEWAY        = HRESULT(0x801901f6),
    HTTP_E_STATUS_SERVICE_UNAVAIL    = HRESULT(0x801901f7),
    HTTP_E_STATUS_GATEWAY_TIMEOUT    = HRESULT(0x801901f8),
    HTTP_E_STATUS_VERSION_NOT_SUP    = HRESULT(0x801901f9),
}

enum : HRESULT
{
    E_INVALID_PROTOCOL_OPERATION = HRESULT(0x83760001),
    E_INVALID_PROTOCOL_FORMAT    = HRESULT(0x83760002),
}

enum HRESULT E_PROTOCOL_EXTENSIONS_NOT_SUPPORTED = HRESULT(0x83760003);
enum HRESULT E_SUBPROTOCOL_NOT_SUPPORTED = HRESULT(0x83760004);
enum HRESULT E_PROTOCOL_VERSION_NOT_SUPPORTED = HRESULT(0x83760005);
enum HRESULT INPUT_E_OUT_OF_ORDER = HRESULT(0x80400000);

enum : HRESULT
{
    INPUT_E_REENTRANCY      = HRESULT(0x80400001),
    INPUT_E_MULTIMODAL      = HRESULT(0x80400002),
    INPUT_E_PACKET          = HRESULT(0x80400003),
    INPUT_E_FRAME           = HRESULT(0x80400004),
    INPUT_E_HISTORY         = HRESULT(0x80400005),
    INPUT_E_DEVICE_INFO     = HRESULT(0x80400006),
    INPUT_E_TRANSFORM       = HRESULT(0x80400007),
    INPUT_E_DEVICE_PROPERTY = HRESULT(0x80400008),
}

enum HRESULT ERROR_DBG_CREATE_PROCESS_FAILURE_LOCKDOWN = HRESULT(0x80b00001);
enum HRESULT ERROR_DBG_ATTACH_PROCESS_FAILURE_LOCKDOWN = HRESULT(0x80b00002);
enum HRESULT ERROR_DBG_CONNECT_SERVER_FAILURE_LOCKDOWN = HRESULT(0x80b00003);
enum HRESULT ERROR_DBG_START_SERVER_FAILURE_LOCKDOWN = HRESULT(0x80b00004);
enum HRESULT HSP_E_ERROR_MASK = HRESULT(0x81280000);
enum HRESULT HSP_E_INTERNAL_ERROR = HRESULT(0x81280fff);

enum : HRESULT
{
    HSP_BS_ERROR_MASK     = HRESULT(0x81281000),
    HSP_BS_INTERNAL_ERROR = HRESULT(0x812810ff),
}

enum : HRESULT
{
    HSP_DRV_ERROR_MASK     = HRESULT(0x81290000),
    HSP_DRV_INTERNAL_ERROR = HRESULT(0x812900ff),
}

enum : HRESULT
{
    HSP_BASE_ERROR_MASK     = HRESULT(0x81290100),
    HSP_BASE_INTERNAL_ERROR = HRESULT(0x812901ff),
}

enum : HRESULT
{
    HSP_KSP_ERROR_MASK       = HRESULT(0x81290200),
    HSP_KSP_DEVICE_NOT_READY = HRESULT(0x81290201),
}

enum : HRESULT
{
    HSP_KSP_INVALID_PROVIDER_HANDLE = HRESULT(0x81290202),
    HSP_KSP_INVALID_KEY_HANDLE      = HRESULT(0x81290203),
    HSP_KSP_INVALID_PARAMETER       = HRESULT(0x81290204),
}

enum HRESULT HSP_KSP_BUFFER_TOO_SMALL = HRESULT(0x81290205);
enum HRESULT HSP_KSP_NOT_SUPPORTED = HRESULT(0x81290206);

enum : HRESULT
{
    HSP_KSP_INVALID_DATA  = HRESULT(0x81290207),
    HSP_KSP_INVALID_FLAGS = HRESULT(0x81290208),
}

enum HRESULT HSP_KSP_ALGORITHM_NOT_SUPPORTED = HRESULT(0x81290209);

enum : HRESULT
{
    HSP_KSP_KEY_ALREADY_FINALIZED = HRESULT(0x8129020a),
    HSP_KSP_KEY_NOT_FINALIZED     = HRESULT(0x8129020b),
}

enum HRESULT HSP_KSP_INVALID_KEY_TYPE = HRESULT(0x8129020c);

enum : HRESULT
{
    HSP_KSP_NO_MEMORY         = HRESULT(0x81290210),
    HSP_KSP_PARAMETER_NOT_SET = HRESULT(0x81290211),
}

enum : HRESULT
{
    HSP_KSP_KEY_EXISTS    = HRESULT(0x81290215),
    HSP_KSP_KEY_MISSING   = HRESULT(0x81290216),
    HSP_KSP_KEY_LOAD_FAIL = HRESULT(0x81290217),
}

enum HRESULT HSP_KSP_NO_MORE_ITEMS = HRESULT(0x81290218);
enum HRESULT HSP_KSP_INTERNAL_ERROR = HRESULT(0x812902ff);
enum HRESULT ERROR_IO_PREEMPTED = HRESULT(0x89010001);
enum HRESULT JSCRIPT_E_CANTEXECUTE = HRESULT(0x89020001);
enum HRESULT WEP_E_NOT_PROVISIONED_ON_ALL_VOLUMES = HRESULT(0x88010001);
enum HRESULT WEP_E_FIXED_DATA_NOT_SUPPORTED = HRESULT(0x88010002);
enum HRESULT WEP_E_HARDWARE_NOT_COMPLIANT = HRESULT(0x88010003);
enum HRESULT WEP_E_LOCK_NOT_CONFIGURED = HRESULT(0x88010004);
enum HRESULT WEP_E_PROTECTION_SUSPENDED = HRESULT(0x88010005);
enum HRESULT WEP_E_NO_LICENSE = HRESULT(0x88010006);
enum HRESULT WEP_E_OS_NOT_PROTECTED = HRESULT(0x88010007);
enum HRESULT WEP_E_UNEXPECTED_FAIL = HRESULT(0x88010008);
enum HRESULT WEP_E_BUFFER_TOO_LARGE = HRESULT(0x88010009);

enum : HRESULT
{
    ERROR_SVHDX_ERROR_STORED        = HRESULT(0xc05c0000),
    ERROR_SVHDX_ERROR_NOT_AVAILABLE = HRESULT(0xc05cff00),
}

enum : HRESULT
{
    ERROR_SVHDX_UNIT_ATTENTION_AVAILABLE                    = HRESULT(0xc05cff01),
    ERROR_SVHDX_UNIT_ATTENTION_CAPACITY_DATA_CHANGED        = HRESULT(0xc05cff02),
    ERROR_SVHDX_UNIT_ATTENTION_RESERVATIONS_PREEMPTED       = HRESULT(0xc05cff03),
    ERROR_SVHDX_UNIT_ATTENTION_RESERVATIONS_RELEASED        = HRESULT(0xc05cff04),
    ERROR_SVHDX_UNIT_ATTENTION_REGISTRATIONS_PREEMPTED      = HRESULT(0xc05cff05),
    ERROR_SVHDX_UNIT_ATTENTION_OPERATING_DEFINITION_CHANGED = HRESULT(0xc05cff06),
}

enum HRESULT ERROR_SVHDX_RESERVATION_CONFLICT = HRESULT(0xc05cff07);

enum : HRESULT
{
    ERROR_SVHDX_WRONG_FILE_TYPE  = HRESULT(0xc05cff08),
    ERROR_SVHDX_VERSION_MISMATCH = HRESULT(0xc05cff09),
}

enum HRESULT ERROR_VHD_SHARED = HRESULT(0xc05cff0a);
enum HRESULT ERROR_SVHDX_NO_INITIATOR = HRESULT(0xc05cff0b);
enum HRESULT ERROR_VHDSET_BACKING_STORAGE_NOT_FOUND = HRESULT(0xc05cff0c);
enum HRESULT ERROR_SMB_NO_PREAUTH_INTEGRITY_HASH_OVERLAP = HRESULT(0xc05d0000);
enum HRESULT ERROR_SMB_BAD_CLUSTER_DIALECT = HRESULT(0xc05d0001);
enum HRESULT ERROR_SMB_NO_SIGNING_ALGORITHM_OVERLAP = HRESULT(0xc05d0002);
enum HRESULT ERROR_SMB_GUEST_LOGON_BLOCKED_SIGNING_REQUIRED = HRESULT(0xc05d0003);
enum HRESULT ERROR_SMB_GUEST_ENCRYPTION_NOT_SUPPORTED = HRESULT(0xc05d0004);
enum HRESULT ERROR_SMB_ENCRYPTION_NOT_SUPPORTED_BY_PEER = HRESULT(0xc05d0005);
enum HRESULT ERROR_SMB_CERT_NO_PRIVATE_KEY = HRESULT(0xc05d0006);
enum HRESULT ERROR_SMB_TLS_ACCESS_DENIED = HRESULT(0xc05d0007);

enum : HRESULT
{
    WININET_E_OUT_OF_HANDLES      = HRESULT(0x80072ee1),
    WININET_E_TIMEOUT             = HRESULT(0x80072ee2),
    WININET_E_EXTENDED_ERROR      = HRESULT(0x80072ee3),
    WININET_E_INTERNAL_ERROR      = HRESULT(0x80072ee4),
    WININET_E_INVALID_URL         = HRESULT(0x80072ee5),
    WININET_E_UNRECOGNIZED_SCHEME = HRESULT(0x80072ee6),
}

enum HRESULT WININET_E_NAME_NOT_RESOLVED = HRESULT(0x80072ee7);
enum HRESULT WININET_E_PROTOCOL_NOT_FOUND = HRESULT(0x80072ee8);

enum : HRESULT
{
    WININET_E_INVALID_OPTION    = HRESULT(0x80072ee9),
    WININET_E_BAD_OPTION_LENGTH = HRESULT(0x80072eea),
}

enum HRESULT WININET_E_OPTION_NOT_SETTABLE = HRESULT(0x80072eeb);

enum : HRESULT
{
    WININET_E_SHUTDOWN            = HRESULT(0x80072eec),
    WININET_E_INCORRECT_USER_NAME = HRESULT(0x80072eed),
    WININET_E_INCORRECT_PASSWORD  = HRESULT(0x80072eee),
}

enum : HRESULT
{
    WININET_E_LOGIN_FAILURE     = HRESULT(0x80072eef),
    WININET_E_INVALID_OPERATION = HRESULT(0x80072ef0),
}

enum HRESULT WININET_E_OPERATION_CANCELLED = HRESULT(0x80072ef1);

enum : HRESULT
{
    WININET_E_INCORRECT_HANDLE_TYPE  = HRESULT(0x80072ef2),
    WININET_E_INCORRECT_HANDLE_STATE = HRESULT(0x80072ef3),
}

enum HRESULT WININET_E_NOT_PROXY_REQUEST = HRESULT(0x80072ef4);
enum HRESULT WININET_E_REGISTRY_VALUE_NOT_FOUND = HRESULT(0x80072ef5);
enum HRESULT WININET_E_BAD_REGISTRY_PARAMETER = HRESULT(0x80072ef6);

enum : HRESULT
{
    WININET_E_NO_DIRECT_ACCESS = HRESULT(0x80072ef7),
    WININET_E_NO_CONTEXT       = HRESULT(0x80072ef8),
    WININET_E_NO_CALLBACK      = HRESULT(0x80072ef9),
    WININET_E_REQUEST_PENDING  = HRESULT(0x80072efa),
}

enum : HRESULT
{
    WININET_E_INCORRECT_FORMAT   = HRESULT(0x80072efb),
    WININET_E_ITEM_NOT_FOUND     = HRESULT(0x80072efc),
    WININET_E_CANNOT_CONNECT     = HRESULT(0x80072efd),
    WININET_E_CONNECTION_ABORTED = HRESULT(0x80072efe),
    WININET_E_CONNECTION_RESET   = HRESULT(0x80072eff),
}

enum : HRESULT
{
    WININET_E_FORCE_RETRY           = HRESULT(0x80072f00),
    WININET_E_INVALID_PROXY_REQUEST = HRESULT(0x80072f01),
}

enum : HRESULT
{
    WININET_E_NEED_UI               = HRESULT(0x80072f02),
    WININET_E_HANDLE_EXISTS         = HRESULT(0x80072f04),
    WININET_E_SEC_CERT_DATE_INVALID = HRESULT(0x80072f05),
    WININET_E_SEC_CERT_CN_INVALID   = HRESULT(0x80072f06),
}

enum : HRESULT
{
    WININET_E_HTTP_TO_HTTPS_ON_REDIR = HRESULT(0x80072f07),
    WININET_E_HTTPS_TO_HTTP_ON_REDIR = HRESULT(0x80072f08),
}

enum : HRESULT
{
    WININET_E_MIXED_SECURITY         = HRESULT(0x80072f09),
    WININET_E_CHG_POST_IS_NON_SECURE = HRESULT(0x80072f0a),
}

enum HRESULT WININET_E_POST_IS_NON_SECURE = HRESULT(0x80072f0b);
enum HRESULT WININET_E_CLIENT_AUTH_CERT_NEEDED = HRESULT(0x80072f0c);

enum : HRESULT
{
    WININET_E_INVALID_CA            = HRESULT(0x80072f0d),
    WININET_E_CLIENT_AUTH_NOT_SETUP = HRESULT(0x80072f0e),
}

enum HRESULT WININET_E_ASYNC_THREAD_FAILED = HRESULT(0x80072f0f);
enum HRESULT WININET_E_REDIRECT_SCHEME_CHANGE = HRESULT(0x80072f10);

enum : HRESULT
{
    WININET_E_DIALOG_PENDING    = HRESULT(0x80072f11),
    WININET_E_RETRY_DIALOG      = HRESULT(0x80072f12),
    WININET_E_NO_NEW_CONTAINERS = HRESULT(0x80072f13),
}

enum HRESULT WININET_E_HTTPS_HTTP_SUBMIT_REDIR = HRESULT(0x80072f14);

enum : HRESULT
{
    WININET_E_SEC_CERT_ERRORS     = HRESULT(0x80072f17),
    WININET_E_SEC_CERT_REV_FAILED = HRESULT(0x80072f19),
}

enum HRESULT WININET_E_HEADER_NOT_FOUND = HRESULT(0x80072f76);
enum HRESULT WININET_E_DOWNLEVEL_SERVER = HRESULT(0x80072f77);

enum : HRESULT
{
    WININET_E_INVALID_SERVER_RESPONSE = HRESULT(0x80072f78),
    WININET_E_INVALID_HEADER          = HRESULT(0x80072f79),
    WININET_E_INVALID_QUERY_REQUEST   = HRESULT(0x80072f7a),
}

enum HRESULT WININET_E_HEADER_ALREADY_EXISTS = HRESULT(0x80072f7b);
enum HRESULT WININET_E_REDIRECT_FAILED = HRESULT(0x80072f7c);
enum HRESULT WININET_E_SECURITY_CHANNEL_ERROR = HRESULT(0x80072f7d);
enum HRESULT WININET_E_UNABLE_TO_CACHE_FILE = HRESULT(0x80072f7e);
enum HRESULT WININET_E_TCPIP_NOT_INSTALLED = HRESULT(0x80072f7f);

enum : HRESULT
{
    WININET_E_DISCONNECTED       = HRESULT(0x80072f83),
    WININET_E_SERVER_UNREACHABLE = HRESULT(0x80072f84),
}

enum HRESULT WININET_E_PROXY_SERVER_UNREACHABLE = HRESULT(0x80072f85);
enum HRESULT WININET_E_BAD_AUTO_PROXY_SCRIPT = HRESULT(0x80072f86);
enum HRESULT WININET_E_UNABLE_TO_DOWNLOAD_SCRIPT = HRESULT(0x80072f87);

enum : HRESULT
{
    WININET_E_SEC_INVALID_CERT = HRESULT(0x80072f89),
    WININET_E_SEC_CERT_REVOKED = HRESULT(0x80072f8a),
}

enum HRESULT WININET_E_FAILED_DUETOSECURITYCHECK = HRESULT(0x80072f8b);
enum HRESULT WININET_E_NOT_INITIALIZED = HRESULT(0x80072f8c);
enum HRESULT WININET_E_LOGIN_FAILURE_DISPLAY_ENTITY_BODY = HRESULT(0x80072f8e);
enum HRESULT WININET_E_DECODING_FAILED = HRESULT(0x80072f8f);

enum : HRESULT
{
    WININET_E_NOT_REDIRECTED            = HRESULT(0x80072f80),
    WININET_E_COOKIE_NEEDS_CONFIRMATION = HRESULT(0x80072f81),
    WININET_E_COOKIE_DECLINED           = HRESULT(0x80072f82),
}

enum HRESULT WININET_E_REDIRECT_NEEDS_CONFIRMATION = HRESULT(0x80072f88);

enum : HRESULT
{
    SQLITE_E_ERROR                   = HRESULT(0x87af0001),
    SQLITE_E_INTERNAL                = HRESULT(0x87af0002),
    SQLITE_E_PERM                    = HRESULT(0x87af0003),
    SQLITE_E_ABORT                   = HRESULT(0x87af0004),
    SQLITE_E_BUSY                    = HRESULT(0x87af0005),
    SQLITE_E_LOCKED                  = HRESULT(0x87af0006),
    SQLITE_E_NOMEM                   = HRESULT(0x87af0007),
    SQLITE_E_READONLY                = HRESULT(0x87af0008),
    SQLITE_E_INTERRUPT               = HRESULT(0x87af0009),
    SQLITE_E_IOERR                   = HRESULT(0x87af000a),
    SQLITE_E_CORRUPT                 = HRESULT(0x87af000b),
    SQLITE_E_NOTFOUND                = HRESULT(0x87af000c),
    SQLITE_E_FULL                    = HRESULT(0x87af000d),
    SQLITE_E_CANTOPEN                = HRESULT(0x87af000e),
    SQLITE_E_PROTOCOL                = HRESULT(0x87af000f),
    SQLITE_E_EMPTY                   = HRESULT(0x87af0010),
    SQLITE_E_SCHEMA                  = HRESULT(0x87af0011),
    SQLITE_E_TOOBIG                  = HRESULT(0x87af0012),
    SQLITE_E_CONSTRAINT              = HRESULT(0x87af0013),
    SQLITE_E_MISMATCH                = HRESULT(0x87af0014),
    SQLITE_E_MISUSE                  = HRESULT(0x87af0015),
    SQLITE_E_NOLFS                   = HRESULT(0x87af0016),
    SQLITE_E_AUTH                    = HRESULT(0x87af0017),
    SQLITE_E_FORMAT                  = HRESULT(0x87af0018),
    SQLITE_E_RANGE                   = HRESULT(0x87af0019),
    SQLITE_E_NOTADB                  = HRESULT(0x87af001a),
    SQLITE_E_NOTICE                  = HRESULT(0x87af001b),
    SQLITE_E_WARNING                 = HRESULT(0x87af001c),
    SQLITE_E_ROW                     = HRESULT(0x87af0064),
    SQLITE_E_DONE                    = HRESULT(0x87af0065),
    SQLITE_E_IOERR_READ              = HRESULT(0x87af010a),
    SQLITE_E_IOERR_SHORT_READ        = HRESULT(0x87af020a),
    SQLITE_E_IOERR_WRITE             = HRESULT(0x87af030a),
    SQLITE_E_IOERR_FSYNC             = HRESULT(0x87af040a),
    SQLITE_E_IOERR_DIR_FSYNC         = HRESULT(0x87af050a),
    SQLITE_E_IOERR_TRUNCATE          = HRESULT(0x87af060a),
    SQLITE_E_IOERR_FSTAT             = HRESULT(0x87af070a),
    SQLITE_E_IOERR_UNLOCK            = HRESULT(0x87af080a),
    SQLITE_E_IOERR_RDLOCK            = HRESULT(0x87af090a),
    SQLITE_E_IOERR_DELETE            = HRESULT(0x87af0a0a),
    SQLITE_E_IOERR_BLOCKED           = HRESULT(0x87af0b0a),
    SQLITE_E_IOERR_NOMEM             = HRESULT(0x87af0c0a),
    SQLITE_E_IOERR_ACCESS            = HRESULT(0x87af0d0a),
    SQLITE_E_IOERR_CHECKRESERVEDLOCK = HRESULT(0x87af0e0a),
    SQLITE_E_IOERR_LOCK              = HRESULT(0x87af0f0a),
    SQLITE_E_IOERR_CLOSE             = HRESULT(0x87af100a),
    SQLITE_E_IOERR_DIR_CLOSE         = HRESULT(0x87af110a),
    SQLITE_E_IOERR_SHMOPEN           = HRESULT(0x87af120a),
    SQLITE_E_IOERR_SHMSIZE           = HRESULT(0x87af130a),
    SQLITE_E_IOERR_SHMLOCK           = HRESULT(0x87af140a),
    SQLITE_E_IOERR_SHMMAP            = HRESULT(0x87af150a),
    SQLITE_E_IOERR_SEEK              = HRESULT(0x87af160a),
    SQLITE_E_IOERR_DELETE_NOENT      = HRESULT(0x87af170a),
    SQLITE_E_IOERR_MMAP              = HRESULT(0x87af180a),
    SQLITE_E_IOERR_GETTEMPPATH       = HRESULT(0x87af190a),
    SQLITE_E_IOERR_CONVPATH          = HRESULT(0x87af1a0a),
    SQLITE_E_IOERR_VNODE             = HRESULT(0x87af1b0a),
    SQLITE_E_IOERR_AUTH              = HRESULT(0x87af1c0a),
    SQLITE_E_IOERR_BEGIN_ATOMIC      = HRESULT(0x87af1d0a),
    SQLITE_E_IOERR_COMMIT_ATOMIC     = HRESULT(0x87af1e0a),
    SQLITE_E_IOERR_ROLLBACK_ATOMIC   = HRESULT(0x87af1f0a),
    SQLITE_E_IOERR_DATA              = HRESULT(0x87af200a),
    SQLITE_E_IOERR_CORRUPTFS         = HRESULT(0x87af210a),
    SQLITE_E_IOERR_IN_PAGE           = HRESULT(0x87af220a),
    SQLITE_E_LOCKED_SHAREDCACHE      = HRESULT(0x87af0106),
    SQLITE_E_LOCKED_VTAB             = HRESULT(0x87af0206),
    SQLITE_E_BUSY_RECOVERY           = HRESULT(0x87af0105),
    SQLITE_E_BUSY_SNAPSHOT           = HRESULT(0x87af0205),
    SQLITE_E_BUSY_TIMEOUT            = HRESULT(0x87af0305),
    SQLITE_E_CANTOPEN_NOTEMPDIR      = HRESULT(0x87af010e),
    SQLITE_E_CANTOPEN_ISDIR          = HRESULT(0x87af020e),
    SQLITE_E_CANTOPEN_FULLPATH       = HRESULT(0x87af030e),
    SQLITE_E_CANTOPEN_CONVPATH       = HRESULT(0x87af040e),
    SQLITE_E_CANTOPEN_DIRTYWAL       = HRESULT(0x87af050e),
    SQLITE_E_CANTOPEN_SYMLINK        = HRESULT(0x87af060e),
}

enum : HRESULT
{
    SQLITE_E_CORRUPT_VTAB       = HRESULT(0x87af010b),
    SQLITE_E_CORRUPT_SEQUENCE   = HRESULT(0x87af020b),
    SQLITE_E_CORRUPT_INDEX      = HRESULT(0x87af030b),
    SQLITE_E_READONLY_RECOVERY  = HRESULT(0x87af0108),
    SQLITE_E_READONLY_CANTLOCK  = HRESULT(0x87af0208),
    SQLITE_E_READONLY_ROLLBACK  = HRESULT(0x87af0308),
    SQLITE_E_READONLY_DBMOVED   = HRESULT(0x87af0408),
    SQLITE_E_READONLY_CANTINIT  = HRESULT(0x87af0508),
    SQLITE_E_READONLY_DIRECTORY = HRESULT(0x87af0608),
}

enum HRESULT SQLITE_E_ABORT_ROLLBACK = HRESULT(0x87af0204);

enum : HRESULT
{
    SQLITE_E_CONSTRAINT_CHECK      = HRESULT(0x87af0113),
    SQLITE_E_CONSTRAINT_COMMITHOOK = HRESULT(0x87af0213),
    SQLITE_E_CONSTRAINT_FOREIGNKEY = HRESULT(0x87af0313),
    SQLITE_E_CONSTRAINT_FUNCTION   = HRESULT(0x87af0413),
    SQLITE_E_CONSTRAINT_NOTNULL    = HRESULT(0x87af0513),
    SQLITE_E_CONSTRAINT_PRIMARYKEY = HRESULT(0x87af0613),
    SQLITE_E_CONSTRAINT_TRIGGER    = HRESULT(0x87af0713),
    SQLITE_E_CONSTRAINT_UNIQUE     = HRESULT(0x87af0813),
    SQLITE_E_CONSTRAINT_VTAB       = HRESULT(0x87af0913),
    SQLITE_E_CONSTRAINT_ROWID      = HRESULT(0x87af0a13),
    SQLITE_E_CONSTRAINT_PINNED     = HRESULT(0x87af0b13),
    SQLITE_E_CONSTRAINT_DATATYPE   = HRESULT(0x87af0c13),
}

enum : HRESULT
{
    SQLITE_E_NOTICE_RECOVER_WAL      = HRESULT(0x87af011b),
    SQLITE_E_NOTICE_RECOVER_ROLLBACK = HRESULT(0x87af021b),
    SQLITE_E_NOTICE_RECOVER_RBU      = HRESULT(0x87af031b),
}

enum HRESULT SQLITE_E_WARNING_AUTOINDEX = HRESULT(0x87af011c);
enum HRESULT SQLITE_E_AUTH_USER = HRESULT(0x87af0117);
enum HRESULT UTC_E_TOGGLE_TRACE_STARTED = HRESULT(0x87c51001);
enum HRESULT UTC_E_ALTERNATIVE_TRACE_CANNOT_PREEMPT = HRESULT(0x87c51002);
enum HRESULT UTC_E_AOT_NOT_RUNNING = HRESULT(0x87c51003);
enum HRESULT UTC_E_SCRIPT_TYPE_INVALID = HRESULT(0x87c51004);
enum HRESULT UTC_E_SCENARIODEF_NOT_FOUND = HRESULT(0x87c51005);
enum HRESULT UTC_E_TRACEPROFILE_NOT_FOUND = HRESULT(0x87c51006);

enum : HRESULT
{
    UTC_E_FORWARDER_ALREADY_ENABLED  = HRESULT(0x87c51007),
    UTC_E_FORWARDER_ALREADY_DISABLED = HRESULT(0x87c51008),
}

enum HRESULT UTC_E_EVENTLOG_ENTRY_MALFORMED = HRESULT(0x87c51009);
enum HRESULT UTC_E_DIAGRULES_SCHEMAVERSION_MISMATCH = HRESULT(0x87c5100a);
enum HRESULT UTC_E_SCRIPT_TERMINATED = HRESULT(0x87c5100b);
enum HRESULT UTC_E_INVALID_CUSTOM_FILTER = HRESULT(0x87c5100c);
enum HRESULT UTC_E_TRACE_NOT_RUNNING = HRESULT(0x87c5100d);
enum HRESULT UTC_E_REESCALATED_TOO_QUICKLY = HRESULT(0x87c5100e);
enum HRESULT UTC_E_ESCALATION_ALREADY_RUNNING = HRESULT(0x87c5100f);
enum HRESULT UTC_E_PERFTRACK_ALREADY_TRACING = HRESULT(0x87c51010);
enum HRESULT UTC_E_REACHED_MAX_ESCALATIONS = HRESULT(0x87c51011);
enum HRESULT UTC_E_FORWARDER_PRODUCER_MISMATCH = HRESULT(0x87c51012);
enum HRESULT UTC_E_INTENTIONAL_SCRIPT_FAILURE = HRESULT(0x87c51013);
enum HRESULT UTC_E_SQM_INIT_FAILED = HRESULT(0x87c51014);
enum HRESULT UTC_E_NO_WER_LOGGER_SUPPORTED = HRESULT(0x87c51015);
enum HRESULT UTC_E_TRACERS_DONT_EXIST = HRESULT(0x87c51016);
enum HRESULT UTC_E_WINRT_INIT_FAILED = HRESULT(0x87c51017);
enum HRESULT UTC_E_SCENARIODEF_SCHEMAVERSION_MISMATCH = HRESULT(0x87c51018);
enum HRESULT UTC_E_INVALID_FILTER = HRESULT(0x87c51019);
enum HRESULT UTC_E_EXE_TERMINATED = HRESULT(0x87c5101a);
enum HRESULT UTC_E_ESCALATION_NOT_AUTHORIZED = HRESULT(0x87c5101b);
enum HRESULT UTC_E_SETUP_NOT_AUTHORIZED = HRESULT(0x87c5101c);
enum HRESULT UTC_E_CHILD_PROCESS_FAILED = HRESULT(0x87c5101d);
enum HRESULT UTC_E_COMMAND_LINE_NOT_AUTHORIZED = HRESULT(0x87c5101e);
enum HRESULT UTC_E_CANNOT_LOAD_SCENARIO_EDITOR_XML = HRESULT(0x87c5101f);
enum HRESULT UTC_E_ESCALATION_TIMED_OUT = HRESULT(0x87c51020);
enum HRESULT UTC_E_SETUP_TIMED_OUT = HRESULT(0x87c51021);

enum : HRESULT
{
    UTC_E_TRIGGER_MISMATCH  = HRESULT(0x87c51022),
    UTC_E_TRIGGER_NOT_FOUND = HRESULT(0x87c51023),
}

enum HRESULT UTC_E_SIF_NOT_SUPPORTED = HRESULT(0x87c51024);
enum HRESULT UTC_E_DELAY_TERMINATED = HRESULT(0x87c51025);
enum HRESULT UTC_E_DEVICE_TICKET_ERROR = HRESULT(0x87c51026);
enum HRESULT UTC_E_TRACE_BUFFER_LIMIT_EXCEEDED = HRESULT(0x87c51027);
enum HRESULT UTC_E_API_RESULT_UNAVAILABLE = HRESULT(0x87c51028);

enum : HRESULT
{
    UTC_E_RPC_TIMEOUT     = HRESULT(0x87c51029),
    UTC_E_RPC_WAIT_FAILED = HRESULT(0x87c5102a),
}

enum : HRESULT
{
    UTC_E_API_BUSY                               = HRESULT(0x87c5102b),
    UTC_E_TRACE_MIN_DURATION_REQUIREMENT_NOT_MET = HRESULT(0x87c5102c),
}

enum HRESULT UTC_E_EXCLUSIVITY_NOT_AVAILABLE = HRESULT(0x87c5102d);
enum HRESULT UTC_E_GETFILE_FILE_PATH_NOT_APPROVED = HRESULT(0x87c5102e);
enum HRESULT UTC_E_ESCALATION_DIRECTORY_ALREADY_EXISTS = HRESULT(0x87c5102f);

enum : HRESULT
{
    UTC_E_TIME_TRIGGER_ON_START_INVALID                = HRESULT(0x87c51030),
    UTC_E_TIME_TRIGGER_ONLY_VALID_ON_SINGLE_TRANSITION = HRESULT(0x87c51031),
}

enum HRESULT UTC_E_TIME_TRIGGER_INVALID_TIME_RANGE = HRESULT(0x87c51032);
enum HRESULT UTC_E_MULTIPLE_TIME_TRIGGER_ON_SINGLE_STATE = HRESULT(0x87c51033);
enum HRESULT UTC_E_BINARY_MISSING = HRESULT(0x87c51034);
enum HRESULT UTC_E_FAILED_TO_RESOLVE_CONTAINER_ID = HRESULT(0x87c51036);
enum HRESULT UTC_E_UNABLE_TO_RESOLVE_SESSION = HRESULT(0x87c51037);
enum HRESULT UTC_E_THROTTLED = HRESULT(0x87c51038);
enum HRESULT UTC_E_UNAPPROVED_SCRIPT = HRESULT(0x87c51039);
enum HRESULT UTC_E_SCRIPT_MISSING = HRESULT(0x87c5103a);
enum HRESULT UTC_E_SCENARIO_THROTTLED = HRESULT(0x87c5103b);
enum HRESULT UTC_E_API_NOT_SUPPORTED = HRESULT(0x87c5103c);
enum HRESULT UTC_E_GETFILE_EXTERNAL_PATH_NOT_APPROVED = HRESULT(0x87c5103d);
enum HRESULT UTC_E_TRY_GET_SCENARIO_TIMEOUT_EXCEEDED = HRESULT(0x87c5103e);
enum HRESULT UTC_E_CERT_REV_FAILED = HRESULT(0x87c5103f);
enum HRESULT UTC_E_FAILED_TO_START_NDISCAP = HRESULT(0x87c51040);
enum HRESULT UTC_E_KERNELDUMP_LIMIT_REACHED = HRESULT(0x87c51041);
enum HRESULT UTC_E_MISSING_AGGREGATE_EVENT_TAG = HRESULT(0x87c51042);
enum HRESULT UTC_E_INVALID_AGGREGATION_STRUCT = HRESULT(0x87c51043);
enum HRESULT UTC_E_ACTION_NOT_SUPPORTED_IN_DESTINATION = HRESULT(0x87c51044);

enum : HRESULT
{
    UTC_E_FILTER_MISSING_ATTRIBUTE       = HRESULT(0x87c51045),
    UTC_E_FILTER_INVALID_TYPE            = HRESULT(0x87c51046),
    UTC_E_FILTER_VARIABLE_NOT_FOUND      = HRESULT(0x87c51047),
    UTC_E_FILTER_FUNCTION_RESTRICTED     = HRESULT(0x87c51048),
    UTC_E_FILTER_VERSION_MISMATCH        = HRESULT(0x87c51049),
    UTC_E_FILTER_INVALID_FUNCTION        = HRESULT(0x87c51050),
    UTC_E_FILTER_INVALID_FUNCTION_PARAMS = HRESULT(0x87c51051),
    UTC_E_FILTER_INVALID_COMMAND         = HRESULT(0x87c51052),
    UTC_E_FILTER_ILLEGAL_EVAL            = HRESULT(0x87c51053),
}

enum HRESULT UTC_E_TTTRACER_RETURNED_ERROR = HRESULT(0x87c51054);
enum HRESULT UTC_E_AGENT_DIAGNOSTICS_TOO_LARGE = HRESULT(0x87c51055);
enum HRESULT UTC_E_FAILED_TO_RECEIVE_AGENT_DIAGNOSTICS = HRESULT(0x87c51056);
enum HRESULT UTC_E_SCENARIO_HAS_NO_ACTIONS = HRESULT(0x87c51057);
enum HRESULT UTC_E_TTTRACER_STORAGE_FULL = HRESULT(0x87c51058);
enum HRESULT UTC_E_INSUFFICIENT_SPACE_TO_START_TRACE = HRESULT(0x87c51059);
enum HRESULT UTC_E_ESCALATION_CANCELLED_AT_SHUTDOWN = HRESULT(0x87c5105a);
enum HRESULT UTC_E_GETFILEINFOACTION_FILE_NOT_APPROVED = HRESULT(0x87c5105b);
enum HRESULT UTC_E_SETREGKEYACTION_TYPE_NOT_APPROVED = HRESULT(0x87c5105c);
enum HRESULT UTC_E_TRACE_THROTTLED = HRESULT(0x87c5105d);

enum : HRESULT
{
    WINML_ERR_INVALID_DEVICE  = HRESULT(0x88900001),
    WINML_ERR_INVALID_BINDING = HRESULT(0x88900002),
}

enum : HRESULT
{
    WINML_ERR_VALUE_NOTFOUND = HRESULT(0x88900003),
    WINML_ERR_SIZE_MISMATCH  = HRESULT(0x88900004),
}

enum HRESULT ERROR_QUIC_HANDSHAKE_FAILURE = HRESULT(0x80410000);

enum : HRESULT
{
    ERROR_QUIC_VER_NEG_FAILURE    = HRESULT(0x80410001),
    ERROR_QUIC_USER_CANCELED      = HRESULT(0x80410002),
    ERROR_QUIC_INTERNAL_ERROR     = HRESULT(0x80410003),
    ERROR_QUIC_PROTOCOL_VIOLATION = HRESULT(0x80410004),
}

enum : HRESULT
{
    ERROR_QUIC_CONNECTION_IDLE    = HRESULT(0x80410005),
    ERROR_QUIC_CONNECTION_TIMEOUT = HRESULT(0x80410006),
}

enum : HRESULT
{
    ERROR_QUIC_ALPN_NEG_FAILURE     = HRESULT(0x80410007),
    ERROR_QUIC_STREAM_LIMIT_REACHED = HRESULT(0x80410008),
}

enum : HRESULT
{
    ERROR_QUIC_ALPN_IN_USE                 = HRESULT(0x80410009),
    ERROR_QUIC_TLS_UNEXPECTED_MESSAGE      = HRESULT(0x8041010a),
    ERROR_QUIC_TLS_BAD_CERTIFICATE         = HRESULT(0x8041012a),
    ERROR_QUIC_TLS_UNSUPPORTED_CERTIFICATE = HRESULT(0x8041012b),
}

enum : HRESULT
{
    ERROR_QUIC_TLS_CERTIFICATE_REVOKED   = HRESULT(0x8041012c),
    ERROR_QUIC_TLS_CERTIFICATE_EXPIRED   = HRESULT(0x8041012d),
    ERROR_QUIC_TLS_CERTIFICATE_UNKNOWN   = HRESULT(0x8041012e),
    ERROR_QUIC_TLS_ILLEGAL_PARAMETER     = HRESULT(0x8041012f),
    ERROR_QUIC_TLS_UNKNOWN_CA            = HRESULT(0x80410130),
    ERROR_QUIC_TLS_ACCESS_DENIED         = HRESULT(0x80410131),
    ERROR_QUIC_TLS_INSUFFICIENT_SECURITY = HRESULT(0x80410147),
    ERROR_QUIC_TLS_INTERNAL_ERROR        = HRESULT(0x80410150),
    ERROR_QUIC_TLS_USER_CANCELED         = HRESULT(0x8041015a),
    ERROR_QUIC_TLS_CERTIFICATE_REQUIRED  = HRESULT(0x80410174),
}

enum HRESULT IORING_E_REQUIRED_FLAG_NOT_SUPPORTED = HRESULT(0x80460001);
enum HRESULT IORING_E_SUBMISSION_QUEUE_FULL = HRESULT(0x80460002);
enum HRESULT IORING_E_VERSION_NOT_SUPPORTED = HRESULT(0x80460003);
enum HRESULT IORING_E_SUBMISSION_QUEUE_TOO_BIG = HRESULT(0x80460004);
enum HRESULT IORING_E_COMPLETION_QUEUE_TOO_BIG = HRESULT(0x80460005);
enum HRESULT IORING_E_SUBMIT_IN_PROGRESS = HRESULT(0x80460006);

enum : HRESULT
{
    IORING_E_CORRUPT                   = HRESULT(0x80460007),
    IORING_E_COMPLETION_QUEUE_TOO_FULL = HRESULT(0x80460008),
}

enum : HRESULT
{
    UNIONFS_E_CANNOT_CROSS_UNION   = HRESULT(0x89250001),
    UNIONFS_E_CANNOT_EXIT_UNION    = HRESULT(0x89250002),
    UNIONFS_E_CANNOT_PRESERVE_LINK = HRESULT(0x89250003),
}

enum HRESULT UNIONFS_E_INVALID_TOMBSTONE_STATE = HRESULT(0x89250004);

enum : HRESULT
{
    UNIONFS_E_LAYERS_PRESENT     = HRESULT(0x89250005),
    UNIONFS_E_NESTED_LAYER       = HRESULT(0x89250006),
    UNIONFS_E_UNION_DUPLICATE_ID = HRESULT(0x89250007),
}

enum : HRESULT
{
    UNIONFS_E_INACTIVE_UNION           = HRESULT(0x89250008),
    UNIONFS_E_TOO_MANY_LAYERS          = HRESULT(0x89250009),
    UNIONFS_E_TOO_LATE                 = HRESULT(0x8925000a),
    UNIONFS_E_NESTED_UNION             = HRESULT(0x8925000b),
    UNIONFS_E_NESTED_UNION_NOT_ALLOWED = HRESULT(0x8925000c),
}

enum HRESULT ERROR_PRM_HANDLER_NOT_FOUND = HRESULT(0xc9260200);
enum HRESULT ERROR_PRM_CONCURRENT_OPERATION = HRESULT(0xc9260202);

enum : HRESULT
{
    ERROR_PRM_MODULE_UPDATE_PENDING       = HRESULT(0xc9260203),
    ERROR_PRM_MODULE_LOCKED               = HRESULT(0xc9260204),
    ERROR_PRM_UPDATE_INCOMPATIBLE_VERSION = HRESULT(0xc9260205),
    ERROR_PRM_UPDATE_MODULE_MISMATCH      = HRESULT(0xc9260206),
    ERROR_PRM_UPDATE_MODULE_NOT_FOUND     = HRESULT(0xc9260207),
    ERROR_PRM_UPDATE_MISSING_EXPORT       = HRESULT(0xc9260208),
    ERROR_PRM_UPDATE_MODULE_LOCKED        = HRESULT(0xc9260209),
    ERROR_PRM_UPDATE_BAD_SIGNATURE        = HRESULT(0xc926020a),
    ERROR_PRM_UPDATE_VERSION_MISMATCH     = HRESULT(0xc926020b),
}

enum HRESULT ERROR_PRM_MODULE_UNLOCKED = HRESULT(0xc926020c);
enum HRESULT ERROR_PRM_INTERFACE_INACCESSIBLE = HRESULT(0xc926020d);
enum HRESULT ERROR_ACCELERATOR_SUBMISSION_QUEUE_FULL = HRESULT(0xc9270000);
enum HRESULT PPF_E_TRANSFORM_DIGEST_ALGO_NOT_SUPPORTED = HRESULT(0xc9280000);

enum : HRESULT
{
    PPF_E_TRANSFORM_CONFLICT                = HRESULT(0xc9280001),
    PPF_E_TRANSFORM_CLEANED_UP_NA           = HRESULT(0xc9280002),
    PPF_E_TRANSFORM_CLEANED_UP_STATE_CHANGE = HRESULT(0xc9280003),
    PPF_E_TRANSFORM_DIGEST_ALGO_NOT_PRESENT = HRESULT(0xc9280004),
}

enum int RPC_X_ENUM_VALUE_TOO_LARGE = 0x000006f5;
enum int RPC_X_INVALID_PIPE_OPERATION = 0x00000727;
enum int RPC_X_SS_CONTEXT_MISMATCH = 0xc0030005;
enum int RPC_X_NO_MEMORY = 0xc0000017;

enum : int
{
    RPC_X_INVALID_BOUND  = 0xc0020023,
    RPC_X_INVALID_TAG    = 0xc0020022,
    RPC_X_INVALID_BUFFER = 0xc0000206,
}

enum int RPC_X_PIPE_APP_MEMORY = 0xc0000017;

enum : uint
{
    STATUS_SEVERITY_COERROR = 0x00000002U,
    STATUS_SEVERITY_COFAIL  = 0x00000003U,
}

enum HRESULT NOT_AN_ERROR1 = HRESULT(0x00081600);

enum : HRESULT
{
    QUERY_E_FAILED             = HRESULT(0x80041600),
    QUERY_E_INVALIDQUERY       = HRESULT(0x80041601),
    QUERY_E_INVALIDRESTRICTION = HRESULT(0x80041602),
    QUERY_E_INVALIDSORT        = HRESULT(0x80041603),
    QUERY_E_INVALIDCATEGORIZE  = HRESULT(0x80041604),
}

enum : HRESULT
{
    QUERY_E_ALLNOISE                = HRESULT(0x80041605),
    QUERY_E_TOOCOMPLEX              = HRESULT(0x80041606),
    QUERY_E_TIMEDOUT                = HRESULT(0x80041607),
    QUERY_E_DUPLICATE_OUTPUT_COLUMN = HRESULT(0x80041608),
}

enum : HRESULT
{
    QUERY_E_INVALID_OUTPUT_COLUMN = HRESULT(0x80041609),
    QUERY_E_INVALID_DIRECTORY     = HRESULT(0x8004160a),
}

enum HRESULT QUERY_E_DIR_ON_REMOVABLE_DRIVE = HRESULT(0x8004160b);
enum HRESULT QUERY_S_NO_QUERY = HRESULT(0x8004160c);
enum HRESULT QPLIST_E_CANT_OPEN_FILE = HRESULT(0x80041651);

enum : HRESULT
{
    QPLIST_E_READ_ERROR     = HRESULT(0x80041652),
    QPLIST_E_EXPECTING_NAME = HRESULT(0x80041653),
    QPLIST_E_EXPECTING_TYPE = HRESULT(0x80041654),
}

enum HRESULT QPLIST_E_UNRECOGNIZED_TYPE = HRESULT(0x80041655);

enum : HRESULT
{
    QPLIST_E_EXPECTING_INTEGER     = HRESULT(0x80041656),
    QPLIST_E_EXPECTING_CLOSE_PAREN = HRESULT(0x80041657),
    QPLIST_E_EXPECTING_GUID        = HRESULT(0x80041658),
}

enum : HRESULT
{
    QPLIST_E_BAD_GUID            = HRESULT(0x80041659),
    QPLIST_E_EXPECTING_PROP_SPEC = HRESULT(0x8004165a),
}

enum HRESULT QPLIST_E_CANT_SET_PROPERTY = HRESULT(0x8004165b);

enum : HRESULT
{
    QPLIST_E_DUPLICATE              = HRESULT(0x8004165c),
    QPLIST_E_VECTORBYREF_USED_ALONE = HRESULT(0x8004165d),
}

enum HRESULT QPLIST_E_BYREF_USED_WITHOUT_PTRTYPE = HRESULT(0x8004165e);
enum HRESULT QPARSE_E_UNEXPECTED_NOT = HRESULT(0x80041660);

enum : HRESULT
{
    QPARSE_E_EXPECTING_INTEGER  = HRESULT(0x80041661),
    QPARSE_E_EXPECTING_REAL     = HRESULT(0x80041662),
    QPARSE_E_EXPECTING_DATE     = HRESULT(0x80041663),
    QPARSE_E_EXPECTING_CURRENCY = HRESULT(0x80041664),
    QPARSE_E_EXPECTING_GUID     = HRESULT(0x80041665),
    QPARSE_E_EXPECTING_BRACE    = HRESULT(0x80041666),
    QPARSE_E_EXPECTING_PAREN    = HRESULT(0x80041667),
    QPARSE_E_EXPECTING_PROPERTY = HRESULT(0x80041668),
}

enum HRESULT QPARSE_E_NOT_YET_IMPLEMENTED = HRESULT(0x80041669);
enum HRESULT QPARSE_E_EXPECTING_PHRASE = HRESULT(0x8004166a);
enum HRESULT QPARSE_E_UNSUPPORTED_PROPERTY_TYPE = HRESULT(0x8004166b);

enum : HRESULT
{
    QPARSE_E_EXPECTING_REGEX          = HRESULT(0x8004166c),
    QPARSE_E_EXPECTING_REGEX_PROPERTY = HRESULT(0x8004166d),
}

enum HRESULT QPARSE_E_INVALID_LITERAL = HRESULT(0x8004166e);
enum HRESULT QPARSE_E_NO_SUCH_PROPERTY = HRESULT(0x8004166f);

enum : HRESULT
{
    QPARSE_E_EXPECTING_EOS   = HRESULT(0x80041670),
    QPARSE_E_EXPECTING_COMMA = HRESULT(0x80041671),
}

enum HRESULT QPARSE_E_UNEXPECTED_EOS = HRESULT(0x80041672);
enum HRESULT QPARSE_E_WEIGHT_OUT_OF_RANGE = HRESULT(0x80041673);
enum HRESULT QPARSE_E_NO_SUCH_SORT_PROPERTY = HRESULT(0x80041674);
enum HRESULT QPARSE_E_INVALID_SORT_ORDER = HRESULT(0x80041675);
enum HRESULT QUTIL_E_CANT_CONVERT_VROOT = HRESULT(0x80041676);
enum HRESULT QPARSE_E_INVALID_GROUPING = HRESULT(0x80041677);
enum HRESULT QUTIL_E_INVALID_CODEPAGE = HRESULT(0xc0041678);
enum HRESULT QPLIST_S_DUPLICATE = HRESULT(0x00041679);

enum : HRESULT
{
    QPARSE_E_INVALID_QUERY      = HRESULT(0x8004167a),
    QPARSE_E_INVALID_RANKMETHOD = HRESULT(0x8004167b),
}

enum HRESULT FDAEMON_W_WORDLISTFULL = HRESULT(0x00041680);

enum : HRESULT
{
    FDAEMON_E_LOWRESOURCE      = HRESULT(0x80041681),
    FDAEMON_E_FATALERROR       = HRESULT(0x80041682),
    FDAEMON_E_PARTITIONDELETED = HRESULT(0x80041683),
}

enum HRESULT FDAEMON_E_CHANGEUPDATEFAILED = HRESULT(0x80041684);
enum HRESULT FDAEMON_W_EMPTYWORDLIST = HRESULT(0x00041685);
enum HRESULT FDAEMON_E_WORDLISTCOMMITFAILED = HRESULT(0x80041686);

enum : HRESULT
{
    FDAEMON_E_NOWORDLIST            = HRESULT(0x80041687),
    FDAEMON_E_TOOMANYFILTEREDBLOCKS = HRESULT(0x80041688),
}

enum HRESULT SEARCH_S_NOMOREHITS = HRESULT(0x000416a0);

enum : HRESULT
{
    SEARCH_E_NOMONIKER = HRESULT(0x800416a1),
    SEARCH_E_NOREGION  = HRESULT(0x800416a2),
}

enum : HRESULT
{
    FILTER_E_TOO_BIG                       = HRESULT(0x80041730),
    FILTER_S_PARTIAL_CONTENTSCAN_IMMEDIATE = HRESULT(0x00041731),
}

enum HRESULT FILTER_S_FULL_CONTENTSCAN_IMMEDIATE = HRESULT(0x00041732);
enum HRESULT FILTER_S_CONTENTSCAN_DELAYED = HRESULT(0x00041733);
enum HRESULT FILTER_E_CONTENTINDEXCORRUPT = HRESULT(0xc0041734);
enum HRESULT FILTER_S_DISK_FULL = HRESULT(0x00041735);

enum : HRESULT
{
    FILTER_E_ALREADY_OPEN = HRESULT(0x80041736),
    FILTER_E_UNREACHABLE  = HRESULT(0x80041737),
    FILTER_E_IN_USE       = HRESULT(0x80041738),
    FILTER_E_NOT_OPEN     = HRESULT(0x80041739),
    FILTER_S_NO_PROPSETS  = HRESULT(0x0004173a),
}

enum HRESULT FILTER_E_NO_SUCH_PROPERTY = HRESULT(0x8004173b);
enum HRESULT FILTER_S_NO_SECURITY_DESCRIPTOR = HRESULT(0x0004173c);

enum : HRESULT
{
    FILTER_E_OFFLINE            = HRESULT(0x8004173d),
    FILTER_E_PARTIALLY_FILTERED = HRESULT(0x8004173e),
}

enum HRESULT WBREAK_E_END_OF_TEXT = HRESULT(0x80041780);
enum HRESULT LANGUAGE_S_LARGE_WORD = HRESULT(0x00041781);

enum : HRESULT
{
    WBREAK_E_QUERY_ONLY       = HRESULT(0x80041782),
    WBREAK_E_BUFFER_TOO_SMALL = HRESULT(0x80041783),
}

enum HRESULT LANGUAGE_E_DATABASE_NOT_FOUND = HRESULT(0x80041784);
enum HRESULT WBREAK_E_INIT_FAILED = HRESULT(0x80041785);

enum : HRESULT
{
    PSINK_E_QUERY_ONLY       = HRESULT(0x80041790),
    PSINK_E_INDEX_ONLY       = HRESULT(0x80041791),
    PSINK_E_LARGE_ATTACHMENT = HRESULT(0x80041792),
}

enum HRESULT PSINK_S_LARGE_WORD = HRESULT(0x00041793);

enum : HRESULT
{
    CI_CORRUPT_DATABASE = HRESULT(0xc0041800),
    CI_CORRUPT_CATALOG  = HRESULT(0xc0041801),
}

enum : HRESULT
{
    CI_INVALID_PARTITION = HRESULT(0xc0041802),
    CI_INVALID_PRIORITY  = HRESULT(0xc0041803),
}

enum HRESULT CI_NO_STARTING_KEY = HRESULT(0xc0041804);
enum HRESULT CI_OUT_OF_INDEX_IDS = HRESULT(0xc0041805);
enum HRESULT CI_NO_CATALOG = HRESULT(0xc0041806);
enum HRESULT CI_CORRUPT_FILTER_BUFFER = HRESULT(0xc0041807);
enum HRESULT CI_INVALID_INDEX = HRESULT(0xc0041808);
enum HRESULT CI_PROPSTORE_INCONSISTENCY = HRESULT(0xc0041809);
enum HRESULT CI_E_ALREADY_INITIALIZED = HRESULT(0x8004180a);
enum HRESULT CI_E_NOT_INITIALIZED = HRESULT(0x8004180b);
enum HRESULT CI_E_BUFFERTOOSMALL = HRESULT(0x8004180c);
enum HRESULT CI_E_PROPERTY_NOT_CACHED = HRESULT(0x8004180d);
enum HRESULT CI_S_WORKID_DELETED = HRESULT(0x0004180e);
enum HRESULT CI_E_INVALID_STATE = HRESULT(0x8004180f);
enum HRESULT CI_E_FILTERING_DISABLED = HRESULT(0x80041810);
enum HRESULT CI_E_DISK_FULL = HRESULT(0x80041811);
enum HRESULT CI_E_SHUTDOWN = HRESULT(0x80041812);
enum HRESULT CI_E_WORKID_NOTVALID = HRESULT(0x80041813);
enum HRESULT CI_S_END_OF_ENUMERATION = HRESULT(0x00041814);
enum HRESULT CI_E_NOT_FOUND = HRESULT(0x80041815);
enum HRESULT CI_E_USE_DEFAULT_PID = HRESULT(0x80041816);
enum HRESULT CI_E_DUPLICATE_NOTIFICATION = HRESULT(0x80041817);
enum HRESULT CI_E_UPDATES_DISABLED = HRESULT(0x80041818);
enum HRESULT CI_E_INVALID_FLAGS_COMBINATION = HRESULT(0x80041819);
enum HRESULT CI_E_OUTOFSEQ_INCREMENT_DATA = HRESULT(0x8004181a);
enum HRESULT CI_E_SHARING_VIOLATION = HRESULT(0x8004181b);
enum HRESULT CI_E_LOGON_FAILURE = HRESULT(0x8004181c);
enum HRESULT CI_E_NO_CATALOG = HRESULT(0x8004181d);
enum HRESULT CI_E_STRANGE_PAGEORSECTOR_SIZE = HRESULT(0x8004181e);

enum : HRESULT
{
    CI_E_TIMEOUT     = HRESULT(0x8004181f),
    CI_E_NOT_RUNNING = HRESULT(0x80041820),
}

enum HRESULT CI_INCORRECT_VERSION = HRESULT(0xc0041821);
enum HRESULT CI_E_ENUMERATION_STARTED = HRESULT(0xc0041822);
enum HRESULT CI_E_PROPERTY_TOOLARGE = HRESULT(0xc0041823);
enum HRESULT CI_E_CLIENT_FILTER_ABORT = HRESULT(0xc0041824);
enum HRESULT CI_S_NO_DOCSTORE = HRESULT(0x00041825);
enum HRESULT CI_S_CAT_STOPPED = HRESULT(0x00041826);
enum HRESULT CI_E_CARDINALITY_MISMATCH = HRESULT(0x80041827);
enum HRESULT CI_E_CONFIG_DISK_FULL = HRESULT(0x80041828);
enum HRESULT CI_E_DISTRIBUTED_GROUPBY_UNSUPPORTED = HRESULT(0x80041829);
enum uint ROUTEBASE = 0x00000384U;
enum uint SUCCESS = 0x00000000U;
enum uint ERROR_ROUTER_STOPPED = 0x00000384U;
enum uint ERROR_ALREADY_CONNECTED = 0x00000385U;
enum uint ERROR_UNKNOWN_PROTOCOL_ID = 0x00000386U;
enum uint ERROR_DDM_NOT_RUNNING = 0x00000387U;
enum uint ERROR_INTERFACE_ALREADY_EXISTS = 0x00000388U;
enum uint ERROR_NO_SUCH_INTERFACE = 0x00000389U;
enum uint ERROR_INTERFACE_NOT_CONNECTED = 0x0000038aU;
enum uint ERROR_PROTOCOL_STOP_PENDING = 0x0000038bU;
enum uint ERROR_INTERFACE_CONNECTED = 0x0000038cU;
enum uint ERROR_NO_INTERFACE_CREDENTIALS_SET = 0x0000038dU;
enum uint ERROR_ALREADY_CONNECTING = 0x0000038eU;
enum uint ERROR_UPDATE_IN_PROGRESS = 0x0000038fU;
enum uint ERROR_INTERFACE_CONFIGURATION = 0x00000390U;

enum : uint
{
    ERROR_NOT_CLIENT_PORT = 0x00000391U,
    ERROR_NOT_ROUTER_PORT = 0x00000392U,
}

enum uint ERROR_CLIENT_INTERFACE_ALREADY_EXISTS = 0x00000393U;
enum uint ERROR_INTERFACE_DISABLED = 0x00000394U;
enum uint ERROR_AUTH_PROTOCOL_REJECTED = 0x00000395U;
enum uint ERROR_NO_AUTH_PROTOCOL_AVAILABLE = 0x00000396U;
enum uint ERROR_PEER_REFUSED_AUTH = 0x00000397U;
enum uint ERROR_REMOTE_NO_DIALIN_PERMISSION = 0x00000398U;

enum : uint
{
    ERROR_REMOTE_PASSWD_EXPIRED         = 0x00000399U,
    ERROR_REMOTE_ACCT_DISABLED          = 0x0000039aU,
    ERROR_REMOTE_RESTRICTED_LOGON_HOURS = 0x0000039bU,
}

enum uint ERROR_REMOTE_AUTHENTICATION_FAILURE = 0x0000039cU;
enum uint ERROR_INTERFACE_HAS_NO_DEVICES = 0x0000039dU;
enum uint ERROR_IDLE_DISCONNECTED = 0x0000039eU;
enum uint ERROR_INTERFACE_UNREACHABLE = 0x0000039fU;
enum uint ERROR_SERVICE_IS_PAUSED = 0x000003a0U;
enum uint ERROR_INTERFACE_DISCONNECTED = 0x000003a1U;
enum uint ERROR_AUTH_SERVER_TIMEOUT = 0x000003a2U;
enum uint ERROR_PORT_LIMIT_REACHED = 0x000003a3U;
enum uint ERROR_PPP_SESSION_TIMEOUT = 0x000003a4U;
enum uint ERROR_MAX_LAN_INTERFACE_LIMIT = 0x000003a5U;
enum uint ERROR_MAX_WAN_INTERFACE_LIMIT = 0x000003a6U;
enum uint ERROR_MAX_CLIENT_INTERFACE_LIMIT = 0x000003a7U;
enum uint ERROR_BAP_DISCONNECTED = 0x000003a8U;
enum uint ERROR_USER_LIMIT = 0x000003a9U;
enum uint ERROR_NO_RADIUS_SERVERS = 0x000003aaU;
enum uint ERROR_INVALID_RADIUS_RESPONSE = 0x000003abU;
enum uint ERROR_DIALIN_HOURS_RESTRICTION = 0x000003acU;
enum uint ERROR_ALLOWED_PORT_TYPE_RESTRICTION = 0x000003adU;
enum uint ERROR_AUTH_PROTOCOL_RESTRICTION = 0x000003aeU;
enum uint ERROR_BAP_REQUIRED = 0x000003afU;
enum uint ERROR_DIALOUT_HOURS_RESTRICTION = 0x000003b0U;
enum uint ERROR_ROUTER_CONFIG_INCOMPATIBLE = 0x000003b1U;
enum uint WARNING_NO_MD5_MIGRATION = 0x000003b2U;
enum uint ERROR_PROTOCOL_ALREADY_INSTALLED = 0x000003b4U;

enum : uint
{
    ERROR_INVALID_SIGNATURE_LENGTH = 0x000003b5U,
    ERROR_INVALID_SIGNATURE        = 0x000003b6U,
}

enum uint ERROR_NO_SIGNATURE = 0x000003b7U;

enum : uint
{
    ERROR_INVALID_PACKET_LENGTH_OR_ID = 0x000003b8U,
    ERROR_INVALID_ATTRIBUTE_LENGTH    = 0x000003b9U,
    ERROR_INVALID_PACKET              = 0x000003baU,
}

enum uint ERROR_AUTHENTICATOR_MISMATCH = 0x000003bbU;
enum uint ERROR_REMOTEACCESS_NOT_CONFIGURED = 0x000003bcU;
enum uint ROUTEBASEEND = 0x000003bdU;

enum : uint
{
    _WIN32_MAXVER         = 0x00000a00U,
    _WIN32_WINDOWS_MAXVER = 0x00000a00U,
}

enum uint NTDDI_MAXVER = 0x00000a00U;

enum : uint
{
    _WIN32_IE_MAXVER    = 0x00000a00U,
    _WIN32_WINNT_MAXVER = 0x00000a00U,
}

enum uint WINVER_MAXVER = 0x00000a00U;

// Callbacks

alias FARPROC = ptrdiff_t function();
alias NEARPROC = ptrdiff_t function();
alias PROC = ptrdiff_t function();
alias PAPCFUNC = void function(size_t Parameter);

// Structs


@RAIIFree!SysFreeString
struct BSTR
{
    wchar* Value;
}

@RAIIFree!CloseHandle
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HANDLE
{
    void* Value;
}

struct BOOL
{
    int Value;
}

struct BOOLEAN
{
    ubyte Value;
}

struct VARIANT_BOOL
{
    short Value;
}

@RAIIFree!FreeLibrary
//STRUCT ATTR: AlsoUsableForAttribute : CustomAttributeSig([FixedArgSig(ElementSig(HINSTANCE))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HMODULE
{
    void* Value;
}

@RAIIFree!FreeLibrary
//STRUCT ATTR: AlsoUsableForAttribute : CustomAttributeSig([FixedArgSig(ElementSig(HMODULE))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HINSTANCE
{
    void* Value;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/hresult
struct HRESULT
{
    int Value;
}

//STRUCT ATTR: AlsoUsableForAttribute : CustomAttributeSig([FixedArgSig(ElementSig(HANDLE))], [])
struct HWND
{
    void* Value;
}

struct LPARAM
{
    ptrdiff_t Value;
}

struct LRESULT
{
    ptrdiff_t Value;
}

struct NTSTATUS
{
    int Value;
}

struct PSTR
{
    ubyte* Value;
}

struct PWSTR
{
    wchar* Value;
}

struct WPARAM
{
    size_t Value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/gdi/colorref
struct COLORREF
{
    uint Value;
}

//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HRSRC
{
    void* Value;
}

//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HTASK
{
    void* Value;
}

@RAIIFree!LocalFree
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HLOCAL
{
    void* Value;
}

@RAIIFree!GlobalFree
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HGLOBAL
{
    void* Value;
}

struct CHAR
{
    byte Value;
}

struct SHANDLE_PTR
{
    ptrdiff_t Value;
}

struct HANDLE_PTR
{
    size_t Value;
}

struct HSPRITE
{
    void* Value;
}

struct HSTR
{
    void* Value;
}

struct HUMPD
{
    void* Value;
}

struct HLSURF
{
    void* Value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minwinbase/ns-minwinbase-systemtime
struct SYSTEMTIME
{
    ushort wYear;
    ushort wMonth;
    ushort wDayOfWeek;
    ushort wDay;
    ushort wHour;
    ushort wMinute;
    ushort wSecond;
    ushort wMilliseconds;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtypes/ns-wtypes-decimal~r1
struct DECIMAL
{
    ushort wReserved;
    union
    {
        struct
        {
            ubyte scale;
            ubyte sign;
        }
        ushort signscale;
    }
    uint   Hi32;
    union
    {
        struct
        {
            uint Lo32;
            uint Mid32;
        }
        ulong Lo64;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtypes/ns-wtypes-propertykey
struct PROPERTYKEY
{
    GUID fmtid;
    uint pid;
}

//STRUCT ATTR: AlsoUsableForAttribute : CustomAttributeSig([FixedArgSig(ElementSig(PROPERTYKEY))], [])
struct DEVPROPKEY
{
    GUID fmtid;
    uint pid;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/filetime
struct FILETIME
{
    uint dwLowDateTime;
    uint dwHighDateTime;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windef/ns-windef-rect
struct RECT
{
    int left;
    int top;
    int right;
    int bottom;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windef/ns-windef-rectl
struct RECTL
{
    int left;
    int top;
    int right;
    int bottom;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windef/ns-windef-point
struct POINT
{
    int x;
    int y;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windef/ns-windef-pointl
struct POINTL
{
    int x;
    int y;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windef/ns-windef-size
struct SIZE
{
    int cx;
    int cy;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windef/ns-windef-points
struct POINTS
{
    short x;
    short y;
}

struct APP_LOCAL_DEVICE_ID
{
    ubyte[32] value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/subauth/ns-subauth-unicode_string
struct UNICODE_STRING
{
    ushort Length;
    ushort MaximumLength;
    PWSTR  Buffer;
}

struct FLOAT128
{
    long LowPart;
    long HighPart;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdef/ns-ntdef-luid
struct LUID
{
    uint LowPart;
    int  HighPart;
}

// Functions

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-sysallocstring
@DllImport("OLEAUT32.dll")
BSTR SysAllocString(const(PWSTR) psz);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-sysreallocstring
@DllImport("OLEAUT32.dll")
int SysReAllocString(BSTR* pbstr, const(PWSTR) psz);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-sysallocstringlen
@DllImport("OLEAUT32.dll")
BSTR SysAllocStringLen(const(PWSTR) strIn, uint ui);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-sysreallocstringlen
@DllImport("OLEAUT32.dll")
int SysReAllocStringLen(BSTR* pbstr, const(PWSTR) psz, uint len);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("OLEAUT32.dll")
HRESULT SysAddRefString(BSTR bstrString);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("OLEAUT32.dll")
void SysReleaseString(BSTR bstrString);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-sysfreestring
@DllImport("OLEAUT32.dll")
void SysFreeString(BSTR bstrString);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-sysstringlen
@DllImport("OLEAUT32.dll")
uint SysStringLen(BSTR pbstr);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-sysstringbytelen
@DllImport("OLEAUT32.dll")
uint SysStringByteLen(BSTR bstr);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-sysallocstringbytelen
@DllImport("OLEAUT32.dll")
BSTR SysAllocStringByteLen(const(PSTR) psz, uint len);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL CloseHandle(HANDLE hObject);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL DuplicateHandle(HANDLE hSourceProcessHandle, HANDLE hSourceHandle, HANDLE hTargetProcessHandle, 
                     HANDLE* lpTargetHandle, uint dwDesiredAccess, BOOL bInheritHandle, 
                     DUPLICATE_HANDLE_OPTIONS dwOptions);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("api-ms-win-core-handle-l1-1-0.dll")
BOOL CompareObjectHandles(HANDLE hFirstObjectHandle, HANDLE hSecondObjectHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL GetHandleInformation(HANDLE hObject, uint* lpdwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL SetHandleInformation(HANDLE hObject, uint dwMask, HANDLE_FLAGS dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL FreeLibrary(HMODULE hLibModule);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
WIN32_ERROR GetLastError();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
void SetLastError(WIN32_ERROR dwErrCode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("USER32.dll")
void SetLastErrorEx(WIN32_ERROR dwErrCode, uint dwType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
HGLOBAL GlobalFree(HGLOBAL hMem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
HLOCAL LocalFree(HLOCAL hMem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ntdll.dll")
uint RtlNtStatusToDosError(NTSTATUS Status);


