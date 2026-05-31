// Written in the D programming language.

module windows.win32.system.applicationinstallationandservicing;

public import windows.core;
public import system.system : Guid;
public import windows.win32.foundation.foundation : BOOL, BSTR, FILETIME, HANDLE, HMODULE,
                                                    HRESULT, HWND, PSTR, PWSTR,
                                                    VARIANT_BOOL;
public import windows.win32.security.cryptography.cryptography : ALG_ID, CERT_CONTEXT;
public import windows.win32.system.com.com : IDispatch, IStream, IUnknown, SAFEARRAY;
public import windows.win32.system.registry : HKEY;
public import windows.win32.system.windowsprogramming : ACTCTX_SECTION_KEYED_DATA_ASSEMBLY_METADATA;

extern(Windows) @nogc nothrow:


// Enums


alias MSIASSEMBLYINFO = uint;
enum : uint
{
    MSIASSEMBLYINFO_NETASSEMBLY   = 0x00000000U,
    MSIASSEMBLYINFO_WIN32ASSEMBLY = 0x00000001U,
}

alias IASSEMBLYCACHE_UNINSTALL_DISPOSITION = uint;
enum : uint
{
    IASSEMBLYCACHE_UNINSTALL_DISPOSITION_UNINSTALLED         = 0x00000001U,
    IASSEMBLYCACHE_UNINSTALL_DISPOSITION_STILL_IN_USE        = 0x00000002U,
    IASSEMBLYCACHE_UNINSTALL_DISPOSITION_ALREADY_UNINSTALLED = 0x00000003U,
    IASSEMBLYCACHE_UNINSTALL_DISPOSITION_DELETE_PENDING      = 0x00000004U,
}

alias QUERYASMINFO_FLAGS = uint;
enum : uint
{
    QUERYASMINFO_FLAG_VALIDATE = 0x00000001U,
}

alias RESULTTYPES = int;
enum : int
{
    ieUnknown = 0x00000000,
    ieError   = 0x00000001,
    ieWarning = 0x00000002,
    ieInfo    = 0x00000003,
}

alias STATUSTYPES = int;
enum : int
{
    ieStatusGetCUB       = 0x00000000,
    ieStatusICECount     = 0x00000001,
    ieStatusMerge        = 0x00000002,
    ieStatusSummaryInfo  = 0x00000003,
    ieStatusCreateEngine = 0x00000004,
    ieStatusStarting     = 0x00000005,
    ieStatusRunICE       = 0x00000006,
    ieStatusShutdown     = 0x00000007,
    ieStatusSuccess      = 0x00000008,
    ieStatusFail         = 0x00000009,
    ieStatusCancel       = 0x0000000a,
}

alias msmErrorType = int;
enum : int
{
    msmErrorLanguageUnsupported = 0x00000001,
    msmErrorLanguageFailed      = 0x00000002,
    msmErrorExclusion           = 0x00000003,
    msmErrorTableMerge          = 0x00000004,
    msmErrorResequenceMerge     = 0x00000005,
    msmErrorFileCreate          = 0x00000006,
    msmErrorDirCreate           = 0x00000007,
    msmErrorFeatureRequired     = 0x00000008,
}

alias INSTALLMESSAGE = int;
enum : int
{
    INSTALLMESSAGE_FATALEXIT      = 0x00000000,
    INSTALLMESSAGE_ERROR          = 0x01000000,
    INSTALLMESSAGE_WARNING        = 0x02000000,
    INSTALLMESSAGE_USER           = 0x03000000,
    INSTALLMESSAGE_INFO           = 0x04000000,
    INSTALLMESSAGE_FILESINUSE     = 0x05000000,
    INSTALLMESSAGE_RESOLVESOURCE  = 0x06000000,
    INSTALLMESSAGE_OUTOFDISKSPACE = 0x07000000,
    INSTALLMESSAGE_ACTIONSTART    = 0x08000000,
    INSTALLMESSAGE_ACTIONDATA     = 0x09000000,
    INSTALLMESSAGE_PROGRESS       = 0x0a000000,
    INSTALLMESSAGE_COMMONDATA     = 0x0b000000,
    INSTALLMESSAGE_INITIALIZE     = 0x0c000000,
    INSTALLMESSAGE_TERMINATE      = 0x0d000000,
    INSTALLMESSAGE_SHOWDIALOG     = 0x0e000000,
    INSTALLMESSAGE_PERFORMANCE    = 0x0f000000,
    INSTALLMESSAGE_RMFILESINUSE   = 0x19000000,
    INSTALLMESSAGE_INSTALLSTART   = 0x1a000000,
    INSTALLMESSAGE_INSTALLEND     = 0x1b000000,
}

alias INSTALLUILEVEL = int;
enum : int
{
    INSTALLUILEVEL_NOCHANGE      = 0x00000000,
    INSTALLUILEVEL_DEFAULT       = 0x00000001,
    INSTALLUILEVEL_NONE          = 0x00000002,
    INSTALLUILEVEL_BASIC         = 0x00000003,
    INSTALLUILEVEL_REDUCED       = 0x00000004,
    INSTALLUILEVEL_FULL          = 0x00000005,
    INSTALLUILEVEL_ENDDIALOG     = 0x00000080,
    INSTALLUILEVEL_PROGRESSONLY  = 0x00000040,
    INSTALLUILEVEL_HIDECANCEL    = 0x00000020,
    INSTALLUILEVEL_SOURCERESONLY = 0x00000100,
    INSTALLUILEVEL_UACONLY       = 0x00000200,
}

alias INSTALLSTATE = int;
enum : int
{
    INSTALLSTATE_NOTUSED      = 0xfffffff9,
    INSTALLSTATE_BADCONFIG    = 0xfffffffa,
    INSTALLSTATE_INCOMPLETE   = 0xfffffffb,
    INSTALLSTATE_SOURCEABSENT = 0xfffffffc,
    INSTALLSTATE_MOREDATA     = 0xfffffffd,
    INSTALLSTATE_INVALIDARG   = 0xfffffffe,
    INSTALLSTATE_UNKNOWN      = 0xffffffff,
    INSTALLSTATE_BROKEN       = 0x00000000,
    INSTALLSTATE_ADVERTISED   = 0x00000001,
    INSTALLSTATE_REMOVED      = 0x00000001,
    INSTALLSTATE_ABSENT       = 0x00000002,
    INSTALLSTATE_LOCAL        = 0x00000003,
    INSTALLSTATE_SOURCE       = 0x00000004,
    INSTALLSTATE_DEFAULT      = 0x00000005,
}

alias USERINFOSTATE = int;
enum : int
{
    USERINFOSTATE_MOREDATA   = 0xfffffffd,
    USERINFOSTATE_INVALIDARG = 0xfffffffe,
    USERINFOSTATE_UNKNOWN    = 0xffffffff,
    USERINFOSTATE_ABSENT     = 0x00000000,
    USERINFOSTATE_PRESENT    = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/Msi/installlevel
alias INSTALLLEVEL = int;
enum : int
{
    INSTALLLEVEL_DEFAULT = 0x00000000,
    INSTALLLEVEL_MINIMUM = 0x00000001,
    INSTALLLEVEL_MAXIMUM = 0x0000ffff,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/Msi/reinstallmode
alias REINSTALLMODE = int;
enum : int
{
    REINSTALLMODE_REPAIR           = 0x00000001,
    REINSTALLMODE_FILEMISSING      = 0x00000002,
    REINSTALLMODE_FILEOLDERVERSION = 0x00000004,
    REINSTALLMODE_FILEEQUALVERSION = 0x00000008,
    REINSTALLMODE_FILEEXACT        = 0x00000010,
    REINSTALLMODE_FILEVERIFY       = 0x00000020,
    REINSTALLMODE_FILEREPLACE      = 0x00000040,
    REINSTALLMODE_MACHINEDATA      = 0x00000080,
    REINSTALLMODE_USERDATA         = 0x00000100,
    REINSTALLMODE_SHORTCUT         = 0x00000200,
    REINSTALLMODE_PACKAGE          = 0x00000400,
}

alias INSTALLLOGMODE = int;
enum : int
{
    INSTALLLOGMODE_FATALEXIT      = 0x00000001,
    INSTALLLOGMODE_ERROR          = 0x00000002,
    INSTALLLOGMODE_WARNING        = 0x00000004,
    INSTALLLOGMODE_USER           = 0x00000008,
    INSTALLLOGMODE_INFO           = 0x00000010,
    INSTALLLOGMODE_RESOLVESOURCE  = 0x00000040,
    INSTALLLOGMODE_OUTOFDISKSPACE = 0x00000080,
    INSTALLLOGMODE_ACTIONSTART    = 0x00000100,
    INSTALLLOGMODE_ACTIONDATA     = 0x00000200,
    INSTALLLOGMODE_COMMONDATA     = 0x00000800,
    INSTALLLOGMODE_PROPERTYDUMP   = 0x00000400,
    INSTALLLOGMODE_VERBOSE        = 0x00001000,
    INSTALLLOGMODE_EXTRADEBUG     = 0x00002000,
    INSTALLLOGMODE_LOGONLYONERROR = 0x00004000,
    INSTALLLOGMODE_LOGPERFORMANCE = 0x00008000,
    INSTALLLOGMODE_PROGRESS       = 0x00000400,
    INSTALLLOGMODE_INITIALIZE     = 0x00001000,
    INSTALLLOGMODE_TERMINATE      = 0x00002000,
    INSTALLLOGMODE_SHOWDIALOG     = 0x00004000,
    INSTALLLOGMODE_FILESINUSE     = 0x00000020,
    INSTALLLOGMODE_RMFILESINUSE   = 0x02000000,
    INSTALLLOGMODE_INSTALLSTART   = 0x04000000,
    INSTALLLOGMODE_INSTALLEND     = 0x08000000,
}

alias INSTALLLOGATTRIBUTES = int;
enum : int
{
    INSTALLLOGATTRIBUTES_APPEND        = 0x00000001,
    INSTALLLOGATTRIBUTES_FLUSHEACHLINE = 0x00000002,
}

alias INSTALLFEATUREATTRIBUTE = int;
enum : int
{
    INSTALLFEATUREATTRIBUTE_FAVORLOCAL             = 0x00000001,
    INSTALLFEATUREATTRIBUTE_FAVORSOURCE            = 0x00000002,
    INSTALLFEATUREATTRIBUTE_FOLLOWPARENT           = 0x00000004,
    INSTALLFEATUREATTRIBUTE_FAVORADVERTISE         = 0x00000008,
    INSTALLFEATUREATTRIBUTE_DISALLOWADVERTISE      = 0x00000010,
    INSTALLFEATUREATTRIBUTE_NOUNSUPPORTEDADVERTISE = 0x00000020,
}

alias INSTALLMODE = int;
enum : int
{
    INSTALLMODE_NODETECTION_ANY    = 0xfffffffc,
    INSTALLMODE_NOSOURCERESOLUTION = 0xfffffffd,
    INSTALLMODE_NODETECTION        = 0xfffffffe,
    INSTALLMODE_EXISTING           = 0xffffffff,
    INSTALLMODE_DEFAULT            = 0x00000000,
}

alias MSIPATCHSTATE = int;
enum : int
{
    MSIPATCHSTATE_INVALID    = 0x00000000,
    MSIPATCHSTATE_APPLIED    = 0x00000001,
    MSIPATCHSTATE_SUPERSEDED = 0x00000002,
    MSIPATCHSTATE_OBSOLETED  = 0x00000004,
    MSIPATCHSTATE_REGISTERED = 0x00000008,
    MSIPATCHSTATE_ALL        = 0x0000000f,
}

alias MSIINSTALLCONTEXT = int;
enum : int
{
    MSIINSTALLCONTEXT_FIRSTVISIBLE   = 0x00000000,
    MSIINSTALLCONTEXT_NONE           = 0x00000000,
    MSIINSTALLCONTEXT_USERMANAGED    = 0x00000001,
    MSIINSTALLCONTEXT_USERUNMANAGED  = 0x00000002,
    MSIINSTALLCONTEXT_MACHINE        = 0x00000004,
    MSIINSTALLCONTEXT_ALL            = 0x00000007,
    MSIINSTALLCONTEXT_ALLUSERMANAGED = 0x00000008,
}

alias MSIPATCHDATATYPE = int;
enum : int
{
    MSIPATCH_DATATYPE_PATCHFILE = 0x00000000,
    MSIPATCH_DATATYPE_XMLPATH   = 0x00000001,
    MSIPATCH_DATATYPE_XMLBLOB   = 0x00000002,
}

alias SCRIPTFLAGS = int;
enum : int
{
    SCRIPTFLAGS_CACHEINFO                = 0x00000001,
    SCRIPTFLAGS_SHORTCUTS                = 0x00000004,
    SCRIPTFLAGS_MACHINEASSIGN            = 0x00000008,
    SCRIPTFLAGS_REGDATA_CNFGINFO         = 0x00000020,
    SCRIPTFLAGS_VALIDATE_TRANSFORMS_LIST = 0x00000040,
    SCRIPTFLAGS_REGDATA_CLASSINFO        = 0x00000080,
    SCRIPTFLAGS_REGDATA_EXTENSIONINFO    = 0x00000100,
    SCRIPTFLAGS_REGDATA_APPINFO          = 0x00000180,
    SCRIPTFLAGS_REGDATA                  = 0x000001a0,
}

alias ADVERTISEFLAGS = int;
enum : int
{
    ADVERTISEFLAGS_MACHINEASSIGN = 0x00000000,
    ADVERTISEFLAGS_USERASSIGN    = 0x00000001,
}

alias INSTALLTYPE = int;
enum : int
{
    INSTALLTYPE_DEFAULT         = 0x00000000,
    INSTALLTYPE_NETWORK_IMAGE   = 0x00000001,
    INSTALLTYPE_SINGLE_INSTANCE = 0x00000002,
}

alias MSIARCHITECTUREFLAGS = int;
enum : int
{
    MSIARCHITECTUREFLAGS_X86   = 0x00000001,
    MSIARCHITECTUREFLAGS_IA64  = 0x00000002,
    MSIARCHITECTUREFLAGS_AMD64 = 0x00000004,
    MSIARCHITECTUREFLAGS_ARM   = 0x00000008,
}

alias MSIOPENPACKAGEFLAGS = int;
enum : int
{
    MSIOPENPACKAGEFLAGS_IGNOREMACHINESTATE = 0x00000001,
}

alias MSIADVERTISEOPTIONFLAGS = int;
enum : int
{
    MSIADVERTISEOPTIONFLAGS_INSTANCE = 0x00000001,
}

alias MSISOURCETYPE = int;
enum : int
{
    MSISOURCETYPE_UNKNOWN = 0x00000000,
    MSISOURCETYPE_NETWORK = 0x00000001,
    MSISOURCETYPE_URL     = 0x00000002,
    MSISOURCETYPE_MEDIA   = 0x00000004,
}

alias MSICODE = int;
enum : int
{
    MSICODE_PRODUCT = 0x00000000,
    MSICODE_PATCH   = 0x40000000,
}

alias MSITRANSACTION = int;
enum : int
{
    MSITRANSACTION_CHAIN_EMBEDDEDUI         = 0x00000001,
    MSITRANSACTION_JOIN_EXISTING_EMBEDDEDUI = 0x00000002,
}

alias MSITRANSACTIONSTATE = uint;
enum : uint
{
    MSITRANSACTIONSTATE_ROLLBACK = 0x00000000U,
    MSITRANSACTIONSTATE_COMMIT   = 0x00000001U,
}

alias MSIDBSTATE = int;
enum : int
{
    MSIDBSTATE_ERROR = 0xffffffff,
    MSIDBSTATE_READ  = 0x00000000,
    MSIDBSTATE_WRITE = 0x00000001,
}

alias MSIMODIFY = int;
enum : int
{
    MSIMODIFY_SEEK             = 0xffffffff,
    MSIMODIFY_REFRESH          = 0x00000000,
    MSIMODIFY_INSERT           = 0x00000001,
    MSIMODIFY_UPDATE           = 0x00000002,
    MSIMODIFY_ASSIGN           = 0x00000003,
    MSIMODIFY_REPLACE          = 0x00000004,
    MSIMODIFY_MERGE            = 0x00000005,
    MSIMODIFY_DELETE           = 0x00000006,
    MSIMODIFY_INSERT_TEMPORARY = 0x00000007,
    MSIMODIFY_VALIDATE         = 0x00000008,
    MSIMODIFY_VALIDATE_NEW     = 0x00000009,
    MSIMODIFY_VALIDATE_FIELD   = 0x0000000a,
    MSIMODIFY_VALIDATE_DELETE  = 0x0000000b,
}

alias MSICOLINFO = int;
enum : int
{
    MSICOLINFO_NAMES = 0x00000000,
    MSICOLINFO_TYPES = 0x00000001,
}

alias MSICONDITION = int;
enum : int
{
    MSICONDITION_FALSE = 0x00000000,
    MSICONDITION_TRUE  = 0x00000001,
    MSICONDITION_NONE  = 0x00000002,
    MSICONDITION_ERROR = 0x00000003,
}

alias MSICOSTTREE = int;
enum : int
{
    MSICOSTTREE_SELFONLY = 0x00000000,
    MSICOSTTREE_CHILDREN = 0x00000001,
    MSICOSTTREE_PARENTS  = 0x00000002,
    MSICOSTTREE_RESERVED = 0x00000003,
}

alias MSIDBERROR = int;
enum : int
{
    MSIDBERROR_INVALIDARG        = 0xfffffffd,
    MSIDBERROR_MOREDATA          = 0xfffffffe,
    MSIDBERROR_FUNCTIONERROR     = 0xffffffff,
    MSIDBERROR_NOERROR           = 0x00000000,
    MSIDBERROR_DUPLICATEKEY      = 0x00000001,
    MSIDBERROR_REQUIRED          = 0x00000002,
    MSIDBERROR_BADLINK           = 0x00000003,
    MSIDBERROR_OVERFLOW          = 0x00000004,
    MSIDBERROR_UNDERFLOW         = 0x00000005,
    MSIDBERROR_NOTINSET          = 0x00000006,
    MSIDBERROR_BADVERSION        = 0x00000007,
    MSIDBERROR_BADCASE           = 0x00000008,
    MSIDBERROR_BADGUID           = 0x00000009,
    MSIDBERROR_BADWILDCARD       = 0x0000000a,
    MSIDBERROR_BADIDENTIFIER     = 0x0000000b,
    MSIDBERROR_BADLANGUAGE       = 0x0000000c,
    MSIDBERROR_BADFILENAME       = 0x0000000d,
    MSIDBERROR_BADPATH           = 0x0000000e,
    MSIDBERROR_BADCONDITION      = 0x0000000f,
    MSIDBERROR_BADFORMATTED      = 0x00000010,
    MSIDBERROR_BADTEMPLATE       = 0x00000011,
    MSIDBERROR_BADDEFAULTDIR     = 0x00000012,
    MSIDBERROR_BADREGPATH        = 0x00000013,
    MSIDBERROR_BADCUSTOMSOURCE   = 0x00000014,
    MSIDBERROR_BADPROPERTY       = 0x00000015,
    MSIDBERROR_MISSINGDATA       = 0x00000016,
    MSIDBERROR_BADCATEGORY       = 0x00000017,
    MSIDBERROR_BADKEYTABLE       = 0x00000018,
    MSIDBERROR_BADMAXMINVALUES   = 0x00000019,
    MSIDBERROR_BADCABINET        = 0x0000001a,
    MSIDBERROR_BADSHORTCUT       = 0x0000001b,
    MSIDBERROR_STRINGOVERFLOW    = 0x0000001c,
    MSIDBERROR_BADLOCALIZEATTRIB = 0x0000001d,
}

alias MSIRUNMODE = int;
enum : int
{
    MSIRUNMODE_ADMIN            = 0x00000000,
    MSIRUNMODE_ADVERTISE        = 0x00000001,
    MSIRUNMODE_MAINTENANCE      = 0x00000002,
    MSIRUNMODE_ROLLBACKENABLED  = 0x00000003,
    MSIRUNMODE_LOGENABLED       = 0x00000004,
    MSIRUNMODE_OPERATIONS       = 0x00000005,
    MSIRUNMODE_REBOOTATEND      = 0x00000006,
    MSIRUNMODE_REBOOTNOW        = 0x00000007,
    MSIRUNMODE_CABINET          = 0x00000008,
    MSIRUNMODE_SOURCESHORTNAMES = 0x00000009,
    MSIRUNMODE_TARGETSHORTNAMES = 0x0000000a,
    MSIRUNMODE_RESERVED11       = 0x0000000b,
    MSIRUNMODE_WINDOWS9X        = 0x0000000c,
    MSIRUNMODE_ZAWENABLED       = 0x0000000d,
    MSIRUNMODE_RESERVED14       = 0x0000000e,
    MSIRUNMODE_RESERVED15       = 0x0000000f,
    MSIRUNMODE_SCHEDULED        = 0x00000010,
    MSIRUNMODE_ROLLBACK         = 0x00000011,
    MSIRUNMODE_COMMIT           = 0x00000012,
}

alias MSITRANSFORM_ERROR = int;
enum : int
{
    MSITRANSFORM_ERROR_ADDEXISTINGROW   = 0x00000001,
    MSITRANSFORM_ERROR_DELMISSINGROW    = 0x00000002,
    MSITRANSFORM_ERROR_ADDEXISTINGTABLE = 0x00000004,
    MSITRANSFORM_ERROR_DELMISSINGTABLE  = 0x00000008,
    MSITRANSFORM_ERROR_UPDATEMISSINGROW = 0x00000010,
    MSITRANSFORM_ERROR_CHANGECODEPAGE   = 0x00000020,
    MSITRANSFORM_ERROR_VIEWTRANSFORM    = 0x00000100,
    MSITRANSFORM_ERROR_NONE             = 0x00000000,
}

alias MSITRANSFORM_VALIDATE = int;
enum : int
{
    MSITRANSFORM_VALIDATE_LANGUAGE                   = 0x00000001,
    MSITRANSFORM_VALIDATE_PRODUCT                    = 0x00000002,
    MSITRANSFORM_VALIDATE_PLATFORM                   = 0x00000004,
    MSITRANSFORM_VALIDATE_MAJORVERSION               = 0x00000008,
    MSITRANSFORM_VALIDATE_MINORVERSION               = 0x00000010,
    MSITRANSFORM_VALIDATE_UPDATEVERSION              = 0x00000020,
    MSITRANSFORM_VALIDATE_NEWLESSBASEVERSION         = 0x00000040,
    MSITRANSFORM_VALIDATE_NEWLESSEQUALBASEVERSION    = 0x00000080,
    MSITRANSFORM_VALIDATE_NEWEQUALBASEVERSION        = 0x00000100,
    MSITRANSFORM_VALIDATE_NEWGREATEREQUALBASEVERSION = 0x00000200,
    MSITRANSFORM_VALIDATE_NEWGREATERBASEVERSION      = 0x00000400,
    MSITRANSFORM_VALIDATE_UPGRADECODE                = 0x00000800,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsxs/ne-winsxs-asm_name
alias ASM_NAME = int;
enum : int
{
    ASM_NAME_PUBLIC_KEY            = 0x00000000,
    ASM_NAME_PUBLIC_KEY_TOKEN      = 0x00000001,
    ASM_NAME_HASH_VALUE            = 0x00000002,
    ASM_NAME_NAME                  = 0x00000003,
    ASM_NAME_MAJOR_VERSION         = 0x00000004,
    ASM_NAME_MINOR_VERSION         = 0x00000005,
    ASM_NAME_BUILD_NUMBER          = 0x00000006,
    ASM_NAME_REVISION_NUMBER       = 0x00000007,
    ASM_NAME_CULTURE               = 0x00000008,
    ASM_NAME_PROCESSOR_ID_ARRAY    = 0x00000009,
    ASM_NAME_OSINFO_ARRAY          = 0x0000000a,
    ASM_NAME_HASH_ALGID            = 0x0000000b,
    ASM_NAME_ALIAS                 = 0x0000000c,
    ASM_NAME_CODEBASE_URL          = 0x0000000d,
    ASM_NAME_CODEBASE_LASTMOD      = 0x0000000e,
    ASM_NAME_NULL_PUBLIC_KEY       = 0x0000000f,
    ASM_NAME_NULL_PUBLIC_KEY_TOKEN = 0x00000010,
    ASM_NAME_CUSTOM                = 0x00000011,
    ASM_NAME_NULL_CUSTOM           = 0x00000012,
    ASM_NAME_MVID                  = 0x00000013,
    ASM_NAME_MAX_PARAMS            = 0x00000014,
}

alias ASM_BIND_FLAGS = int;
enum : int
{
    ASM_BINDF_FORCE_CACHE_INSTALL = 0x00000001,
    ASM_BINDF_RFS_INTEGRITY_CHECK = 0x00000002,
    ASM_BINDF_RFS_MODULE_CHECK    = 0x00000004,
    ASM_BINDF_BINPATH_PROBE_ONLY  = 0x00000008,
    ASM_BINDF_SHARED_BINPATH_HINT = 0x00000010,
    ASM_BINDF_PARENT_ASM_HINT     = 0x00000020,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsxs/ne-winsxs-asm_display_flags
alias ASM_DISPLAY_FLAGS = int;
enum : int
{
    ASM_DISPLAYF_VERSION               = 0x00000001,
    ASM_DISPLAYF_CULTURE               = 0x00000002,
    ASM_DISPLAYF_PUBLIC_KEY_TOKEN      = 0x00000004,
    ASM_DISPLAYF_PUBLIC_KEY            = 0x00000008,
    ASM_DISPLAYF_CUSTOM                = 0x00000010,
    ASM_DISPLAYF_PROCESSORARCHITECTURE = 0x00000020,
    ASM_DISPLAYF_LANGUAGEID            = 0x00000040,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsxs/ne-winsxs-asm_cmp_flags
alias ASM_CMP_FLAGS = int;
enum : int
{
    ASM_CMPF_NAME             = 0x00000001,
    ASM_CMPF_MAJOR_VERSION    = 0x00000002,
    ASM_CMPF_MINOR_VERSION    = 0x00000004,
    ASM_CMPF_BUILD_NUMBER     = 0x00000008,
    ASM_CMPF_REVISION_NUMBER  = 0x00000010,
    ASM_CMPF_PUBLIC_KEY_TOKEN = 0x00000020,
    ASM_CMPF_CULTURE          = 0x00000040,
    ASM_CMPF_CUSTOM           = 0x00000080,
    ASM_CMPF_ALL              = 0x000000ff,
    ASM_CMPF_DEFAULT          = 0x00000100,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsxs/ne-winsxs-create_asm_name_obj_flags
alias CREATE_ASM_NAME_OBJ_FLAGS = int;
enum : int
{
    CANOF_PARSE_DISPLAY_NAME = 0x00000001,
    CANOF_SET_DEFAULT_VALUES = 0x00000002,
}

alias msidbControlAttributes = int;
enum : int
{
    msidbControlAttributesVisible         = 0x00000001,
    msidbControlAttributesEnabled         = 0x00000002,
    msidbControlAttributesSunken          = 0x00000004,
    msidbControlAttributesIndirect        = 0x00000008,
    msidbControlAttributesInteger         = 0x00000010,
    msidbControlAttributesRTLRO           = 0x00000020,
    msidbControlAttributesRightAligned    = 0x00000040,
    msidbControlAttributesLeftScroll      = 0x00000080,
    msidbControlAttributesBiDi            = 0x000000e0,
    msidbControlAttributesTransparent     = 0x00010000,
    msidbControlAttributesNoPrefix        = 0x00020000,
    msidbControlAttributesNoWrap          = 0x00040000,
    msidbControlAttributesFormatSize      = 0x00080000,
    msidbControlAttributesUsersLanguage   = 0x00100000,
    msidbControlAttributesMultiline       = 0x00010000,
    msidbControlAttributesPasswordInput   = 0x00200000,
    msidbControlAttributesProgress95      = 0x00010000,
    msidbControlAttributesRemovableVolume = 0x00010000,
    msidbControlAttributesFixedVolume     = 0x00020000,
    msidbControlAttributesRemoteVolume    = 0x00040000,
    msidbControlAttributesCDROMVolume     = 0x00080000,
    msidbControlAttributesRAMDiskVolume   = 0x00100000,
    msidbControlAttributesFloppyVolume    = 0x00200000,
    msidbControlShowRollbackCost          = 0x00400000,
    msidbControlAttributesSorted          = 0x00010000,
    msidbControlAttributesComboList       = 0x00020000,
    msidbControlAttributesImageHandle     = 0x00010000,
    msidbControlAttributesPushLike        = 0x00020000,
    msidbControlAttributesBitmap          = 0x00040000,
    msidbControlAttributesIcon            = 0x00080000,
    msidbControlAttributesFixedSize       = 0x00100000,
    msidbControlAttributesIconSize16      = 0x00200000,
    msidbControlAttributesIconSize32      = 0x00400000,
    msidbControlAttributesIconSize48      = 0x00600000,
    msidbControlAttributesElevationShield = 0x00800000,
    msidbControlAttributesHasBorder       = 0x01000000,
}

alias msidbLocatorType = int;
enum : int
{
    msidbLocatorTypeDirectory = 0x00000000,
    msidbLocatorTypeFileName  = 0x00000001,
    msidbLocatorTypeRawValue  = 0x00000002,
    msidbLocatorType64bit     = 0x00000010,
}

alias msidbComponentAttributes = int;
enum : int
{
    msidbComponentAttributesLocalOnly                 = 0x00000000,
    msidbComponentAttributesSourceOnly                = 0x00000001,
    msidbComponentAttributesOptional                  = 0x00000002,
    msidbComponentAttributesRegistryKeyPath           = 0x00000004,
    msidbComponentAttributesSharedDllRefCount         = 0x00000008,
    msidbComponentAttributesPermanent                 = 0x00000010,
    msidbComponentAttributesODBCDataSource            = 0x00000020,
    msidbComponentAttributesTransitive                = 0x00000040,
    msidbComponentAttributesNeverOverwrite            = 0x00000080,
    msidbComponentAttributes64bit                     = 0x00000100,
    msidbComponentAttributesDisableRegistryReflection = 0x00000200,
    msidbComponentAttributesUninstallOnSupersedence   = 0x00000400,
    msidbComponentAttributesShared                    = 0x00000800,
}

alias msidbAssemblyAttributes = int;
enum : int
{
    msidbAssemblyAttributesURT   = 0x00000000,
    msidbAssemblyAttributesWin32 = 0x00000001,
}

alias msidbCustomActionType = int;
enum : int
{
    msidbCustomActionTypeDll            = 0x00000001,
    msidbCustomActionTypeExe            = 0x00000002,
    msidbCustomActionTypeTextData       = 0x00000003,
    msidbCustomActionTypeJScript        = 0x00000005,
    msidbCustomActionTypeVBScript       = 0x00000006,
    msidbCustomActionTypeInstall        = 0x00000007,
    msidbCustomActionTypeBinaryData     = 0x00000000,
    msidbCustomActionTypeSourceFile     = 0x00000010,
    msidbCustomActionTypeDirectory      = 0x00000020,
    msidbCustomActionTypeProperty       = 0x00000030,
    msidbCustomActionTypeContinue       = 0x00000040,
    msidbCustomActionTypeAsync          = 0x00000080,
    msidbCustomActionTypeFirstSequence  = 0x00000100,
    msidbCustomActionTypeOncePerProcess = 0x00000200,
    msidbCustomActionTypeClientRepeat   = 0x00000300,
    msidbCustomActionTypeInScript       = 0x00000400,
    msidbCustomActionTypeRollback       = 0x00000100,
    msidbCustomActionTypeCommit         = 0x00000200,
    msidbCustomActionTypeNoImpersonate  = 0x00000800,
    msidbCustomActionTypeTSAware        = 0x00004000,
    msidbCustomActionType64BitScript    = 0x00001000,
    msidbCustomActionTypeHideTarget     = 0x00002000,
    msidbCustomActionTypePatchUninstall = 0x00008000,
}

alias msidbDialogAttributes = int;
enum : int
{
    msidbDialogAttributesVisible          = 0x00000001,
    msidbDialogAttributesModal            = 0x00000002,
    msidbDialogAttributesMinimize         = 0x00000004,
    msidbDialogAttributesSysModal         = 0x00000008,
    msidbDialogAttributesKeepModeless     = 0x00000010,
    msidbDialogAttributesTrackDiskSpace   = 0x00000020,
    msidbDialogAttributesUseCustomPalette = 0x00000040,
    msidbDialogAttributesRTLRO            = 0x00000080,
    msidbDialogAttributesRightAligned     = 0x00000100,
    msidbDialogAttributesLeftScroll       = 0x00000200,
    msidbDialogAttributesBiDi             = 0x00000380,
    msidbDialogAttributesError            = 0x00010000,
}

alias msidbFeatureAttributes = int;
enum : int
{
    msidbFeatureAttributesFavorLocal             = 0x00000000,
    msidbFeatureAttributesFavorSource            = 0x00000001,
    msidbFeatureAttributesFollowParent           = 0x00000002,
    msidbFeatureAttributesFavorAdvertise         = 0x00000004,
    msidbFeatureAttributesDisallowAdvertise      = 0x00000008,
    msidbFeatureAttributesUIDisallowAbsent       = 0x00000010,
    msidbFeatureAttributesNoUnsupportedAdvertise = 0x00000020,
}

alias msidbFileAttributes = int;
enum : int
{
    msidbFileAttributesReadOnly      = 0x00000001,
    msidbFileAttributesHidden        = 0x00000002,
    msidbFileAttributesSystem        = 0x00000004,
    msidbFileAttributesReserved0     = 0x00000008,
    msidbFileAttributesIsolatedComp  = 0x00000010,
    msidbFileAttributesReserved1     = 0x00000040,
    msidbFileAttributesReserved2     = 0x00000080,
    msidbFileAttributesReserved3     = 0x00000100,
    msidbFileAttributesVital         = 0x00000200,
    msidbFileAttributesChecksum      = 0x00000400,
    msidbFileAttributesPatchAdded    = 0x00001000,
    msidbFileAttributesNoncompressed = 0x00002000,
    msidbFileAttributesCompressed    = 0x00004000,
    msidbFileAttributesReserved4     = 0x00008000,
}

alias msidbIniFileAction = int;
enum : int
{
    msidbIniFileActionAddLine    = 0x00000000,
    msidbIniFileActionCreateLine = 0x00000001,
    msidbIniFileActionRemoveLine = 0x00000002,
    msidbIniFileActionAddTag     = 0x00000003,
    msidbIniFileActionRemoveTag  = 0x00000004,
}

alias msidbMoveFileOptions = int;
enum : int
{
    msidbMoveFileOptionsMove = 0x00000001,
}

alias msidbODBCDataSourceRegistration = int;
enum : int
{
    msidbODBCDataSourceRegistrationPerMachine = 0x00000000,
    msidbODBCDataSourceRegistrationPerUser    = 0x00000001,
}

alias msidbClassAttributes = int;
enum : int
{
    msidbClassAttributesRelativePath = 0x00000001,
}

alias msidbPatchAttributes = int;
enum : int
{
    msidbPatchAttributesNonVital = 0x00000001,
}

alias msidbRegistryRoot = int;
enum : int
{
    msidbRegistryRootClassesRoot  = 0x00000000,
    msidbRegistryRootCurrentUser  = 0x00000001,
    msidbRegistryRootLocalMachine = 0x00000002,
    msidbRegistryRootUsers        = 0x00000003,
}

alias msidbRemoveFileInstallMode = int;
enum : int
{
    msidbRemoveFileInstallModeOnInstall = 0x00000001,
    msidbRemoveFileInstallModeOnRemove  = 0x00000002,
    msidbRemoveFileInstallModeOnBoth    = 0x00000003,
}

alias msidbServiceControlEvent = int;
enum : int
{
    msidbServiceControlEventStart           = 0x00000001,
    msidbServiceControlEventStop            = 0x00000002,
    msidbServiceControlEventDelete          = 0x00000008,
    msidbServiceControlEventUninstallStart  = 0x00000010,
    msidbServiceControlEventUninstallStop   = 0x00000020,
    msidbServiceControlEventUninstallDelete = 0x00000080,
}

alias msidbServiceConfigEvent = int;
enum : int
{
    msidbServiceConfigEventInstall   = 0x00000001,
    msidbServiceConfigEventUninstall = 0x00000002,
    msidbServiceConfigEventReinstall = 0x00000004,
}

alias msidbServiceInstallErrorControl = int;
enum : int
{
    msidbServiceInstallErrorControlVital = 0x00008000,
}

alias msidbTextStyleStyleBits = int;
enum : int
{
    msidbTextStyleStyleBitsBold      = 0x00000001,
    msidbTextStyleStyleBitsItalic    = 0x00000002,
    msidbTextStyleStyleBitsUnderline = 0x00000004,
    msidbTextStyleStyleBitsStrike    = 0x00000008,
}

alias msidbUpgradeAttributes = int;
enum : int
{
    msidbUpgradeAttributesMigrateFeatures     = 0x00000001,
    msidbUpgradeAttributesOnlyDetect          = 0x00000002,
    msidbUpgradeAttributesIgnoreRemoveFailure = 0x00000004,
    msidbUpgradeAttributesVersionMinInclusive = 0x00000100,
    msidbUpgradeAttributesVersionMaxInclusive = 0x00000200,
    msidbUpgradeAttributesLanguagesExclusive  = 0x00000400,
}

alias msidbEmbeddedUIAttributes = int;
enum : int
{
    msidbEmbeddedUI           = 0x00000001,
    msidbEmbeddedHandlesBasic = 0x00000002,
}

alias msidbSumInfoSourceType = int;
enum : int
{
    msidbSumInfoSourceTypeSFN        = 0x00000001,
    msidbSumInfoSourceTypeCompressed = 0x00000002,
    msidbSumInfoSourceTypeAdminImage = 0x00000004,
    msidbSumInfoSourceTypeLUAPackage = 0x00000008,
}

alias msirbRebootType = int;
enum : int
{
    msirbRebootImmediate = 0x00000001,
    msirbRebootDeferred  = 0x00000002,
}

alias msirbRebootReason = int;
enum : int
{
    msirbRebootUndeterminedReason   = 0x00000000,
    msirbRebootInUseFilesReason     = 0x00000001,
    msirbRebootScheduleRebootReason = 0x00000002,
    msirbRebootForceRebootReason    = 0x00000003,
    msirbRebootCustomActionReason   = 0x00000004,
}

alias msifiFastInstallBits = int;
enum : int
{
    msifiFastInstallNoSR         = 0x00000001,
    msifiFastInstallQuickCosting = 0x00000002,
    msifiFastInstallLessPrgMsg   = 0x00000004,
}

alias TILE_TEMPLATE_TYPE = int;
enum : int
{
    TILE_TEMPLATE_INVALID               = 0x00000000,
    TILE_TEMPLATE_FLIP                  = 0x00000005,
    TILE_TEMPLATE_DEEPLINK              = 0x0000000d,
    TILE_TEMPLATE_CYCLE                 = 0x0000000e,
    TILE_TEMPLATE_METROCOUNT            = 0x00000001,
    TILE_TEMPLATE_AGILESTORE            = 0x00000002,
    TILE_TEMPLATE_GAMES                 = 0x00000003,
    TILE_TEMPLATE_CALENDAR              = 0x00000004,
    TILE_TEMPLATE_MUSICVIDEO            = 0x00000007,
    TILE_TEMPLATE_PEOPLE                = 0x0000000a,
    TILE_TEMPLATE_CONTACT               = 0x0000000b,
    TILE_TEMPLATE_GROUP                 = 0x0000000c,
    TILE_TEMPLATE_DEFAULT               = 0x0000000f,
    TILE_TEMPLATE_BADGE                 = 0x00000010,
    TILE_TEMPLATE_BLOCK                 = 0x00000011,
    TILE_TEMPLATE_TEXT01                = 0x00000012,
    TILE_TEMPLATE_TEXT02                = 0x00000013,
    TILE_TEMPLATE_TEXT03                = 0x00000014,
    TILE_TEMPLATE_TEXT04                = 0x00000015,
    TILE_TEMPLATE_TEXT05                = 0x00000016,
    TILE_TEMPLATE_TEXT06                = 0x00000017,
    TILE_TEMPLATE_TEXT07                = 0x00000018,
    TILE_TEMPLATE_TEXT08                = 0x00000019,
    TILE_TEMPLATE_TEXT09                = 0x0000001a,
    TILE_TEMPLATE_TEXT10                = 0x0000001b,
    TILE_TEMPLATE_TEXT11                = 0x0000001c,
    TILE_TEMPLATE_IMAGE                 = 0x0000001d,
    TILE_TEMPLATE_IMAGECOLLECTION       = 0x0000001e,
    TILE_TEMPLATE_IMAGEANDTEXT01        = 0x0000001f,
    TILE_TEMPLATE_IMAGEANDTEXT02        = 0x00000020,
    TILE_TEMPLATE_BLOCKANDTEXT01        = 0x00000021,
    TILE_TEMPLATE_BLOCKANDTEXT02        = 0x00000022,
    TILE_TEMPLATE_PEEKIMAGEANDTEXT01    = 0x00000023,
    TILE_TEMPLATE_PEEKIMAGEANDTEXT02    = 0x00000024,
    TILE_TEMPLATE_PEEKIMAGEANDTEXT03    = 0x00000025,
    TILE_TEMPLATE_PEEKIMAGEANDTEXT04    = 0x00000026,
    TILE_TEMPLATE_PEEKIMAGE01           = 0x00000027,
    TILE_TEMPLATE_PEEKIMAGE02           = 0x00000028,
    TILE_TEMPLATE_PEEKIMAGE03           = 0x00000029,
    TILE_TEMPLATE_PEEKIMAGE04           = 0x0000002a,
    TILE_TEMPLATE_PEEKIMAGE05           = 0x0000002b,
    TILE_TEMPLATE_PEEKIMAGE06           = 0x0000002c,
    TILE_TEMPLATE_PEEKIMAGECOLLECTION01 = 0x0000002d,
    TILE_TEMPLATE_PEEKIMAGECOLLECTION02 = 0x0000002e,
    TILE_TEMPLATE_PEEKIMAGECOLLECTION03 = 0x0000002f,
    TILE_TEMPLATE_PEEKIMAGECOLLECTION04 = 0x00000030,
    TILE_TEMPLATE_PEEKIMAGECOLLECTION05 = 0x00000031,
    TILE_TEMPLATE_PEEKIMAGECOLLECTION06 = 0x00000032,
    TILE_TEMPLATE_SMALLIMAGEANDTEXT01   = 0x00000033,
    TILE_TEMPLATE_SMALLIMAGEANDTEXT02   = 0x00000034,
    TILE_TEMPLATE_SMALLIMAGEANDTEXT03   = 0x00000035,
    TILE_TEMPLATE_SMALLIMAGEANDTEXT04   = 0x00000036,
    TILE_TEMPLATE_SMALLIMAGEANDTEXT05   = 0x00000037,
    TILE_TEMPLATE_METROCOUNTQUEUE       = 0x00000038,
    TILE_TEMPLATE_SEARCH                = 0x00000039,
    TILE_TEMPLATE_TILEFLYOUT01          = 0x0000003a,
    TILE_TEMPLATE_FOLDER                = 0x0000003b,
    TILE_TEMPLATE_ALL                   = 0x00000064,
}

alias PM_APP_GENRE = int;
enum : int
{
    PM_APP_GENRE_GAMES   = 0x00000000,
    PM_APP_GENRE_OTHER   = 0x00000001,
    PM_APP_GENRE_INVALID = 0x00000002,
}

alias PM_APPLICATION_INSTALL_TYPE = int;
enum : int
{
    PM_APPLICATION_INSTALL_NORMAL     = 0x00000000,
    PM_APPLICATION_INSTALL_IN_ROM     = 0x00000001,
    PM_APPLICATION_INSTALL_PA         = 0x00000002,
    PM_APPLICATION_INSTALL_DEBUG      = 0x00000003,
    PM_APPLICATION_INSTALL_ENTERPRISE = 0x00000004,
    PM_APPLICATION_INSTALL_INVALID    = 0x00000005,
}

alias PM_APPLICATION_STATE = int;
enum : int
{
    PM_APPLICATION_STATE_MIN                   = 0x00000000,
    PM_APPLICATION_STATE_INSTALLED             = 0x00000001,
    PM_APPLICATION_STATE_INSTALLING            = 0x00000002,
    PM_APPLICATION_STATE_UPDATING              = 0x00000003,
    PM_APPLICATION_STATE_UNINSTALLING          = 0x00000004,
    PM_APPLICATION_STATE_LICENSE_UPDATING      = 0x00000005,
    PM_APPLICATION_STATE_MOVING                = 0x00000006,
    PM_APPLICATION_STATE_DISABLED_SD_CARD      = 0x00000007,
    PM_APPLICATION_STATE_DISABLED_ENTERPRISE   = 0x00000008,
    PM_APPLICATION_STATE_DISABLED_BACKING_UP   = 0x00000009,
    PM_APPLICATION_STATE_DISABLED_MDIL_BINDING = 0x0000000a,
    PM_APPLICATION_STATE_MAX                   = 0x0000000a,
    PM_APPLICATION_STATE_INVALID               = 0x0000000b,
}

alias PM_APPLICATION_HUBTYPE = int;
enum : int
{
    PM_APPLICATION_HUBTYPE_NONMUSIC = 0x00000000,
    PM_APPLICATION_HUBTYPE_MUSIC    = 0x00000001,
    PM_APPLICATION_HUBTYPE_INVALID  = 0x00000002,
}

alias PM_TILE_HUBTYPE = int;
enum : int
{
    PM_TILE_HUBTYPE_MUSIC      = 0x00000001,
    PM_TILE_HUBTYPE_MOSETTINGS = 0x10000000,
    PM_TILE_HUBTYPE_GAMES      = 0x20000000,
    PM_TILE_HUBTYPE_APPLIST    = 0x40000000,
    PM_TILE_HUBTYPE_STARTMENU  = 0x80000000,
    PM_TILE_HUBTYPE_LOCKSCREEN = 0x01000000,
    PM_TILE_HUBTYPE_KIDZONE    = 0x02000000,
    PM_TILE_HUBTYPE_CACHED     = 0x04000000,
    PM_TILE_HUBTYPE_INVALID    = 0x04000001,
}

alias PM_STARTTILE_TYPE = int;
enum : int
{
    PM_STARTTILE_TYPE_PRIMARY        = 0x00000001,
    PM_STARTTILE_TYPE_SECONDARY      = 0x00000002,
    PM_STARTTILE_TYPE_APPLIST        = 0x00000003,
    PM_STARTTILE_TYPE_APPLISTPRIMARY = 0x00000004,
    PM_STARTTILE_TYPE_INVALID        = 0x00000005,
}

alias PM_TASK_TYPE = int;
enum : int
{
    PM_TASK_TYPE_NORMAL                 = 0x00000000,
    PM_TASK_TYPE_DEFAULT                = 0x00000001,
    PM_TASK_TYPE_SETTINGS               = 0x00000002,
    PM_TASK_TYPE_BACKGROUNDSERVICEAGENT = 0x00000003,
    PM_TASK_TYPE_BACKGROUNDWORKER       = 0x00000004,
    PM_TASK_TYPE_INVALID                = 0x00000005,
}

alias PACKMAN_RUNTIME = int;
enum : int
{
    PACKMAN_RUNTIME_NATIVE            = 0x00000001,
    PACKMAN_RUNTIME_SILVERLIGHTMOBILE = 0x00000002,
    PACKMAN_RUNTIME_XNA               = 0x00000003,
    PACKMAN_RUNTIME_MODERN_NATIVE     = 0x00000004,
    PACKMAN_RUNTIME_JUPITER           = 0x00000005,
    PACKMAN_RUNTIME_INVALID           = 0x00000006,
}

alias PM_ACTIVATION_POLICY = int;
enum : int
{
    PM_ACTIVATION_POLICY_RESUME                   = 0x00000000,
    PM_ACTIVATION_POLICY_RESUMESAMEPARAMS         = 0x00000001,
    PM_ACTIVATION_POLICY_REPLACE                  = 0x00000002,
    PM_ACTIVATION_POLICY_REPLACESAMEPARAMS        = 0x00000003,
    PM_ACTIVATION_POLICY_MULTISESSION             = 0x00000004,
    PM_ACTIVATION_POLICY_REPLACE_IGNOREFOREGROUND = 0x00000005,
    PM_ACTIVATION_POLICY_UNKNOWN                  = 0x00000006,
    PM_ACTIVATION_POLICY_INVALID                  = 0x00000007,
}

alias PM_TASK_TRANSITION = int;
enum : int
{
    PM_TASK_TRANSITION_DEFAULT     = 0x00000000,
    PM_TASK_TRANSITION_NONE        = 0x00000001,
    PM_TASK_TRANSITION_TURNSTILE   = 0x00000002,
    PM_TASK_TRANSITION_SLIDE       = 0x00000003,
    PM_TASK_TRANSITION_SWIVEL      = 0x00000004,
    PM_TASK_TRANSITION_READERBOARD = 0x00000005,
    PM_TASK_TRANSITION_CUSTOM      = 0x00000006,
    PM_TASK_TRANSITION_INVALID     = 0x00000007,
}

alias PM_ENUM_APP_FILTER = int;
enum : int
{
    PM_APP_FILTER_ALL                = 0x00000000,
    PM_APP_FILTER_VISIBLE            = 0x00000001,
    PM_APP_FILTER_GENRE              = 0x00000002,
    PM_APP_FILTER_NONGAMES           = 0x00000003,
    PM_APP_FILTER_HUBTYPE            = 0x00000004,
    PM_APP_FILTER_PINABLEONKIDZONE   = 0x00000005,
    PM_APP_FILTER_ALL_INCLUDE_MODERN = 0x00000006,
    PM_APP_FILTER_FRAMEWORK          = 0x00000007,
    PM_APP_FILTER_MAX                = 0x00000008,
}

alias PM_ENUM_TILE_FILTER = int;
enum : int
{
    PM_TILE_FILTER_APPLIST = 0x00000008,
    PM_TILE_FILTER_PINNED  = 0x00000009,
    PM_TILE_FILTER_HUBTYPE = 0x0000000a,
    PM_TILE_FILTER_APP_ALL = 0x0000000b,
    PM_TILE_FILTER_MAX     = 0x0000000c,
}

alias PM_ENUM_TASK_FILTER = int;
enum : int
{
    PM_TASK_FILTER_APP_ALL          = 0x0000000c,
    PM_TASK_FILTER_TASK_TYPE        = 0x0000000d,
    PM_TASK_FILTER_DEHYD_SUPRESSING = 0x0000000e,
    PM_TASK_FILTER_APP_TASK_TYPE    = 0x0000000f,
    PM_TASK_FILTER_BGEXECUTION      = 0x00000010,
    PM_TASK_FILTER_MAX              = 0x00000011,
}

alias PM_ENUM_EXTENSION_FILTER = int;
enum : int
{
    PM_ENUM_EXTENSION_FILTER_BY_CONSUMER             = 0x00000011,
    PM_ENUM_EXTENSION_FILTER_APPCONNECT              = 0x00000011,
    PM_ENUM_EXTENSION_FILTER_PROTOCOL_ALL            = 0x00000012,
    PM_ENUM_EXTENSION_FILTER_FTASSOC_FILETYPE_ALL    = 0x00000013,
    PM_ENUM_EXTENSION_FILTER_FTASSOC_CONTENTTYPE_ALL = 0x00000014,
    PM_ENUM_EXTENSION_FILTER_FTASSOC_APPLICATION_ALL = 0x00000015,
    PM_ENUM_EXTENSION_FILTER_SHARETARGET_ALL         = 0x00000016,
    PM_ENUM_EXTENSION_FILTER_FILEOPENPICKER_ALL      = 0x00000017,
    PM_ENUM_EXTENSION_FILTER_FILESAVEPICKER_ALL      = 0x00000018,
    PM_ENUM_EXTENSION_FILTER_CACHEDFILEUPDATER_ALL   = 0x00000019,
    PM_ENUM_EXTENSION_FILTER_MAX                     = 0x0000001a,
}

alias PM_ENUM_BSA_FILTER = int;
enum : int
{
    PM_ENUM_BSA_FILTER_ALL                 = 0x0000001a,
    PM_ENUM_BSA_FILTER_BY_TASKID           = 0x0000001b,
    PM_ENUM_BSA_FILTER_BY_PRODUCTID        = 0x0000001c,
    PM_ENUM_BSA_FILTER_BY_PERIODIC         = 0x0000001d,
    PM_ENUM_BSA_FILTER_BY_ALL_LAUNCHONBOOT = 0x0000001e,
    PM_ENUM_BSA_FILTER_MAX                 = 0x0000001f,
}

alias PM_ENUM_BW_FILTER = int;
enum : int
{
    PM_ENUM_BW_FILTER_BOOTWORKER_ALL = 0x0000001f,
    PM_ENUM_BW_FILTER_BY_TASKID      = 0x00000020,
    PM_ENUM_BW_FILTER_MAX            = 0x00000021,
}

alias PM_LIVETILE_RECURRENCE_TYPE = int;
enum : int
{
    PM_LIVETILE_RECURRENCE_TYPE_INSTANT  = 0x00000000,
    PM_LIVETILE_RECURRENCE_TYPE_ONETIME  = 0x00000001,
    PM_LIVETILE_RECURRENCE_TYPE_INTERVAL = 0x00000002,
    PM_LIVETILE_RECURRENCE_TYPE_MAX      = 0x00000002,
}

alias PM_TILE_SIZE = int;
enum : int
{
    PM_TILE_SIZE_SMALL         = 0x00000000,
    PM_TILE_SIZE_MEDIUM        = 0x00000001,
    PM_TILE_SIZE_LARGE         = 0x00000002,
    PM_TILE_SIZE_SQUARE310X310 = 0x00000003,
    PM_TILE_SIZE_TALL150X310   = 0x00000004,
    PM_TILE_SIZE_INVALID       = 0x00000005,
}

alias PM_LOGO_SIZE = int;
enum : int
{
    PM_LOGO_SIZE_SMALL   = 0x00000000,
    PM_LOGO_SIZE_MEDIUM  = 0x00000001,
    PM_LOGO_SIZE_LARGE   = 0x00000002,
    PM_LOGO_SIZE_INVALID = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ne-winnt-actctx_requested_run_level
alias ACTCTX_REQUESTED_RUN_LEVEL = int;
enum : int
{
    ACTCTX_RUN_LEVEL_UNSPECIFIED       = 0x00000000,
    ACTCTX_RUN_LEVEL_AS_INVOKER        = 0x00000001,
    ACTCTX_RUN_LEVEL_HIGHEST_AVAILABLE = 0x00000002,
    ACTCTX_RUN_LEVEL_REQUIRE_ADMIN     = 0x00000003,
    ACTCTX_RUN_LEVEL_NUMBERS           = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ne-winnt-actctx_compatibility_element_type
alias ACTCTX_COMPATIBILITY_ELEMENT_TYPE = int;
enum : int
{
    ACTCTX_COMPATIBILITY_ELEMENT_TYPE_UNKNOWN          = 0x00000000,
    ACTCTX_COMPATIBILITY_ELEMENT_TYPE_OS               = 0x00000001,
    ACTCTX_COMPATIBILITY_ELEMENT_TYPE_MITIGATION       = 0x00000002,
    ACTCTX_COMPATIBILITY_ELEMENT_TYPE_MAXVERSIONTESTED = 0x00000003,
}

// Constants


enum : PWSTR
{
    MSIDBOPEN_READONLY     = PWSTR(0x00000000),
    MSIDBOPEN_TRANSACT     = PWSTR(0x00000001),
    MSIDBOPEN_DIRECT       = PWSTR(0x00000002),
    MSIDBOPEN_CREATE       = PWSTR(0x00000003),
    MSIDBOPEN_CREATEDIRECT = PWSTR(0x00000004),
}

enum int MSIDBOPEN_PATCHFILE = 0x00000010;
enum uint UIALL = 0x00008000U;

enum : uint
{
    LOGTOKEN_TYPE_MASK       = 0x00000003U,
    LOGTOKEN_UNSPECIFIED     = 0x00000000U,
    LOGTOKEN_NO_LOG          = 0x00000001U,
    LOGTOKEN_SETUPAPI_APPLOG = 0x00000002U,
    LOGTOKEN_SETUPAPI_DEVLOG = 0x00000003U,
}

enum : uint
{
    TXTLOG_SETUPAPI_DEVLOG  = 0x00000001U,
    TXTLOG_SETUPAPI_CMDLINE = 0x00000002U,
    TXTLOG_SETUPAPI_BITS    = 0x00000003U,
}

enum : uint
{
    TXTLOG_ERROR               = 0x00000001U,
    TXTLOG_WARNING             = 0x00000002U,
    TXTLOG_SYSTEM_STATE_CHANGE = 0x00000003U,
}

enum : uint
{
    TXTLOG_SUMMARY      = 0x00000004U,
    TXTLOG_DETAILS      = 0x00000005U,
    TXTLOG_VERBOSE      = 0x00000006U,
    TXTLOG_VERY_VERBOSE = 0x00000007U,
}

enum uint TXTLOG_RESERVED_FLAGS = 0x0000fff0U;

enum : uint
{
    TXTLOG_TIMESTAMP    = 0x00010000U,
    TXTLOG_DEPTH_INCR   = 0x00020000U,
    TXTLOG_DEPTH_DECR   = 0x00040000U,
    TXTLOG_TAB_1        = 0x00080000U,
    TXTLOG_FLUSH_FILE   = 0x00100000U,
    TXTLOG_DEVINST      = 0x00000001U,
    TXTLOG_INF          = 0x00000002U,
    TXTLOG_FILEQ        = 0x00000004U,
    TXTLOG_COPYFILES    = 0x00000008U,
    TXTLOG_SIGVERIF     = 0x00000020U,
    TXTLOG_BACKUP       = 0x00000080U,
    TXTLOG_UI           = 0x00000100U,
    TXTLOG_UTIL         = 0x00000200U,
    TXTLOG_INFDB        = 0x00000400U,
    TXTLOG_DRVSETUP     = 0x00400000U,
    TXTLOG_POLICY       = 0x00800000U,
    TXTLOG_NEWDEV       = 0x01000000U,
    TXTLOG_UMPNPMGR     = 0x02000000U,
    TXTLOG_DRIVER_STORE = 0x04000000U,
}

enum : uint
{
    TXTLOG_SETUP     = 0x08000000U,
    TXTLOG_CMI       = 0x10000000U,
    TXTLOG_DEVMGR    = 0x20000000U,
    TXTLOG_INSTALLER = 0x40000000U,
    TXTLOG_VENDOR    = 0x80000000U,
}

enum GUID CLSID_EvalCom2 = GUID("6e5e1910-8053-4660-b795-6b612e29bc58");
enum uint _WIN32_MSM = 0x00000064U;
enum GUID LIBID_MsmMergeTypeLib = GUID("0adda82f-2c26-11d2-ad65-00a0c9af11a6");
enum GUID CLSID_MsmMerge2 = GUID("f94985d5-29f9-4743-9805-99bc3f35b678");
enum uint _WIN32_MSI = 0x000001f4U;
enum uint MAX_GUID_CHARS = 0x00000026U;
enum uint MAX_FEATURE_CHARS = 0x00000026U;

enum : const(wchar)*
{
    INSTALLPROPERTY_PACKAGENAME          = "PackageName",
    INSTALLPROPERTY_TRANSFORMS           = "Transforms",
    INSTALLPROPERTY_LANGUAGE             = "Language",
    INSTALLPROPERTY_PRODUCTNAME          = "ProductName",
    INSTALLPROPERTY_ASSIGNMENTTYPE       = "AssignmentType",
    INSTALLPROPERTY_INSTANCETYPE         = "InstanceType",
    INSTALLPROPERTY_AUTHORIZED_LUA_APP   = "AuthorizedLUAApp",
    INSTALLPROPERTY_PACKAGECODE          = "PackageCode",
    INSTALLPROPERTY_VERSION              = "Version",
    INSTALLPROPERTY_PRODUCTICON          = "ProductIcon",
    INSTALLPROPERTY_INSTALLEDPRODUCTNAME = "InstalledProductName",
    INSTALLPROPERTY_VERSIONSTRING        = "VersionString",
    INSTALLPROPERTY_HELPLINK             = "HelpLink",
    INSTALLPROPERTY_HELPTELEPHONE        = "HelpTelephone",
    INSTALLPROPERTY_INSTALLLOCATION      = "InstallLocation",
    INSTALLPROPERTY_INSTALLSOURCE        = "InstallSource",
    INSTALLPROPERTY_INSTALLDATE          = "InstallDate",
    INSTALLPROPERTY_PUBLISHER            = "Publisher",
    INSTALLPROPERTY_LOCALPACKAGE         = "LocalPackage",
    INSTALLPROPERTY_URLINFOABOUT         = "URLInfoAbout",
    INSTALLPROPERTY_URLUPDATEINFO        = "URLUpdateInfo",
    INSTALLPROPERTY_VERSIONMINOR         = "VersionMinor",
    INSTALLPROPERTY_VERSIONMAJOR         = "VersionMajor",
    INSTALLPROPERTY_PRODUCTID            = "ProductID",
    INSTALLPROPERTY_REGCOMPANY           = "RegCompany",
    INSTALLPROPERTY_REGOWNER             = "RegOwner",
    INSTALLPROPERTY_INSTALLEDLANGUAGE    = "InstalledLanguage",
    INSTALLPROPERTY_UNINSTALLABLE        = "Uninstallable",
    INSTALLPROPERTY_PRODUCTSTATE         = "State",
    INSTALLPROPERTY_PATCHSTATE           = "State",
    INSTALLPROPERTY_PATCHTYPE            = "PatchType",
    INSTALLPROPERTY_LUAENABLED           = "LUAEnabled",
    INSTALLPROPERTY_DISPLAYNAME          = "DisplayName",
    INSTALLPROPERTY_MOREINFOURL          = "MoreInfoURL",
    INSTALLPROPERTY_LASTUSEDSOURCE       = "LastUsedSource",
    INSTALLPROPERTY_LASTUSEDTYPE         = "LastUsedType",
    INSTALLPROPERTY_MEDIAPACKAGEPATH     = "MediaPackagePath",
    INSTALLPROPERTY_DISKPROMPT           = "DiskPrompt",
}

enum uint MSI_INVALID_HASH_IS_FATAL = 0x00000001U;
enum uint ERROR_ROLLBACK_DISABLED = 0x00000675U;
enum uint MSI_NULL_INTEGER = 0x80000000U;
enum int INSTALLMESSAGE_TYPEMASK = 0xff000000;

enum : uint
{
    STREAM_FORMAT_COMPLIB_MODULE   = 0x00000000U,
    STREAM_FORMAT_COMPLIB_MANIFEST = 0x00000001U,
    STREAM_FORMAT_WIN32_MODULE     = 0x00000002U,
    STREAM_FORMAT_WIN32_MANIFEST   = 0x00000004U,
}

enum uint IASSEMBLYCACHEITEM_COMMIT_FLAG_REFRESH = 0x00000001U;

enum : uint
{
    ASSEMBLYINFO_FLAG_INSTALLED       = 0x00000001U,
    ASSEMBLYINFO_FLAG_PAYLOADRESIDENT = 0x00000002U,
}

enum : uint
{
    IASSEMBLYCACHEITEM_COMMIT_DISPOSITION_INSTALLED         = 0x00000001U,
    IASSEMBLYCACHEITEM_COMMIT_DISPOSITION_REFRESHED         = 0x00000002U,
    IASSEMBLYCACHEITEM_COMMIT_DISPOSITION_ALREADY_INSTALLED = 0x00000003U,
}

enum : GUID
{
    FUSION_REFCOUNT_UNINSTALL_SUBKEY_GUID = GUID("8cedc215-ac4b-488b-93c0-a50a49cb2fb8"),
    FUSION_REFCOUNT_FILEPATH_GUID         = GUID("b02f9d65-fb77-4f7a-afa5-b391309f11c9"),
    FUSION_REFCOUNT_OPAQUE_STRING_GUID    = GUID("2ec93463-b0c3-45e1-8364-327e96aea856"),
}

enum : uint
{
    SFC_DISABLE_NORMAL   = 0x00000000U,
    SFC_DISABLE_ASK      = 0x00000001U,
    SFC_DISABLE_ONCE     = 0x00000002U,
    SFC_DISABLE_SETUP    = 0x00000003U,
    SFC_DISABLE_NOPOPUPS = 0x00000004U,
}

enum : uint
{
    SFC_SCAN_NORMAL    = 0x00000000U,
    SFC_SCAN_ALWAYS    = 0x00000001U,
    SFC_SCAN_ONCE      = 0x00000002U,
    SFC_SCAN_IMMEDIATE = 0x00000003U,
}

enum uint SFC_QUOTA_DEFAULT = 0x00000032U;
enum const(wchar)* SFC_IDLE_TRIGGER = "WFP_IDLE_TRIGGER";

enum : const(wchar)*
{
    IPROPNAME_PRODUCTNAME     = "ProductName",
    IPROPNAME_PRODUCTCODE     = "ProductCode",
    IPROPNAME_PRODUCTVERSION  = "ProductVersion",
    IPROPNAME_INSTALLLANGUAGE = "ProductLanguage",
}

enum : const(wchar)*
{
    IPROPNAME_MANUFACTURER     = "Manufacturer",
    IPROPNAME_UPGRADECODE      = "UpgradeCode",
    IPROPNAME_PIDTEMPLATE      = "PIDTemplate",
    IPROPNAME_DISKPROMPT       = "DiskPrompt",
    IPROPNAME_LEFTUNIT         = "LeftUnit",
    IPROPNAME_ADMIN_PROPERTIES = "AdminProperties",
}

enum : const(wchar)*
{
    IPROPNAME_DEFAULTUIFONT     = "DefaultUIFont",
    IPROPNAME_ALLOWEDPROPERTIES = "SecureCustomProperties",
}

enum const(wchar)* IPROPNAME_ENABLEUSERCONTROL = "EnableUserControl";
enum const(wchar)* IPROPNAME_HIDDEN_PROPERTIES = "MsiHiddenProperties";

enum : const(wchar)*
{
    IPROPNAME_USERNAME       = "USERNAME",
    IPROPNAME_COMPANYNAME    = "COMPANYNAME",
    IPROPNAME_PIDKEY         = "PIDKEY",
    IPROPNAME_PATCH          = "PATCH",
    IPROPNAME_MSIPATCHREMOVE = "MSIPATCHREMOVE",
    IPROPNAME_TARGETDIR      = "TARGETDIR",
    IPROPNAME_ACTION         = "ACTION",
    IPROPNAME_LIMITUI        = "LIMITUI",
    IPROPNAME_LOGACTION      = "LOGACTION",
    IPROPNAME_ALLUSERS       = "ALLUSERS",
    IPROPNAME_INSTALLLEVEL   = "INSTALLLEVEL",
    IPROPNAME_REBOOT         = "REBOOT",
    IPROPNAME_REBOOTPROMPT   = "REBOOTPROMPT",
    IPROPNAME_EXECUTEMODE    = "EXECUTEMODE",
}

enum : const(wchar)*
{
    IPROPVALUE_EXECUTEMODE_NONE   = "NONE",
    IPROPVALUE_EXECUTEMODE_SCRIPT = "SCRIPT",
}

enum : const(wchar)*
{
    IPROPNAME_EXECUTEACTION      = "EXECUTEACTION",
    IPROPNAME_SOURCELIST         = "SOURCELIST",
    IPROPNAME_ROOTDRIVE          = "ROOTDRIVE",
    IPROPNAME_TRANSFORMS         = "TRANSFORMS",
    IPROPNAME_TRANSFORMSATSOURCE = "TRANSFORMSATSOURCE",
    IPROPNAME_TRANSFORMSSECURE   = "TRANSFORMSSECURE",
}

enum : const(wchar)*
{
    IPROPNAME_SEQUENCE        = "SEQUENCE",
    IPROPNAME_SHORTFILENAMES  = "SHORTFILENAMES",
    IPROPNAME_PRIMARYFOLDER   = "PRIMARYFOLDER",
    IPROPNAME_AFTERREBOOT     = "AFTERREBOOT",
    IPROPNAME_NOCOMPANYNAME   = "NOCOMPANYNAME",
    IPROPNAME_NOUSERNAME      = "NOUSERNAME",
    IPROPNAME_DISABLEROLLBACK = "DISABLEROLLBACK",
}

enum const(wchar)* IPROPNAME_AVAILABLEFREEREG = "AVAILABLEFREEREG";
enum const(wchar)* IPROPNAME_DISABLEADVTSHORTCUTS = "DISABLEADVTSHORTCUTS";

enum : const(wchar)*
{
    IPROPNAME_PATCHNEWPACKAGECODE     = "PATCHNEWPACKAGECODE",
    IPROPNAME_PATCHNEWSUMMARYSUBJECT  = "PATCHNEWSUMMARYSUBJECT",
    IPROPNAME_PATCHNEWSUMMARYCOMMENTS = "PATCHNEWSUMMARYCOMMENTS",
}

enum const(wchar)* IPROPNAME_PRODUCTLANGUAGE = "PRODUCTLANGUAGE";

enum : const(wchar)*
{
    IPROPNAME_CHECKCRCS         = "MSICHECKCRCS",
    IPROPNAME_MSINODISABLEMEDIA = "MSINODISABLEMEDIA",
}

enum const(wchar)* IPROPNAME_CARRYINGNDP = "CARRYINGNDP";

enum : const(wchar)*
{
    IPROPVALUE__CARRYINGNDP_URTREINSTALL = "URTREINSTALL",
    IPROPVALUE__CARRYINGNDP_URTUPGRADE   = "URTUPGRADE",
}

enum const(wchar)* IPROPNAME_ENFORCE_UPGRADE_COMPONENT_RULES = "MSIENFORCEUPGRADECOMPONENTRULES";

enum : const(wchar)*
{
    IPROPNAME_MSINEWINSTANCE              = "MSINEWINSTANCE",
    IPROPNAME_MSIINSTANCEGUID             = "MSIINSTANCEGUID",
    IPROPNAME_MSIPACKAGEDOWNLOADLOCALCOPY = "MSIPACKAGEDOWNLOADLOCALCOPY",
    IPROPNAME_MSIPATCHDOWNLOADLOCALCOPY   = "MSIPATCHDOWNLOADLOCALCOPY",
}

enum : const(wchar)*
{
    IPROPNAME_MSIDISABLELUAPATCHING = "MSIDISABLELUAPATCHING",
    IPROPNAME_MSILOGGINGMODE        = "MsiLogging",
    IPROPNAME_MSILOGFILELOCATION    = "MsiLogFileLocation",
    IPROPNAME_MSI_RM_CONTROL        = "MSIRESTARTMANAGERCONTROL",
}

enum : const(wchar)*
{
    IPROPVALUE_MSI_RM_CONTROL_DISABLE         = "Disable",
    IPROPVALUE_MSI_RM_CONTROL_DISABLESHUTDOWN = "DisableShutdown",
}

enum : const(wchar)*
{
    IPROPNAME_MSI_RM_SESSION_KEY           = "MsiRestartManagerSessionKey",
    IPROPNAME_MSI_REBOOT_PENDING           = "MsiSystemRebootPending",
    IPROPNAME_MSI_RM_SHUTDOWN              = "MSIRMSHUTDOWN",
    IPROPNAME_MSI_RM_DISABLE_RESTART       = "MSIDISABLERMRESTART",
    IPROPNAME_MSI_UAC_DEPLOYMENT_COMPLIANT = "MSIDEPLOYMENTCOMPLIANT",
}

enum const(wchar)* IPROPNAME_MSI_USE_REAL_ADMIN_DETECTION = "MSIUSEREALADMINDETECTION";
enum const(wchar)* IPROPNAME_MSI_UNINSTALL_SUPERSEDED_COMPONENTS = "MSIUNINSTALLSUPERSEDEDCOMPONENTS";

enum : const(wchar)*
{
    IPROPNAME_MSIDISABLEEEUI  = "MSIDISABLEEEUI",
    IPROPNAME_MSI_FASTINSTALL = "MSIFASTINSTALL",
}

enum : const(wchar)*
{
    IPROPNAME_INSTALLPERUSER           = "MSIINSTALLPERUSER",
    IPROPNAME_INTERNALINSTALLEDPERUSER = "MSIINTERNALINSTALLEDPERUSER",
}

enum : const(wchar)*
{
    IPROPNAME_ARPAUTHORIZEDCDFPREFIX  = "ARPAUTHORIZEDCDFPREFIX",
    IPROPNAME_ARPCOMMENTS             = "ARPCOMMENTS",
    IPROPNAME_ARPCONTACT              = "ARPCONTACT",
    IPROPNAME_ARPHELPLINK             = "ARPHELPLINK",
    IPROPNAME_ARPHELPTELEPHONE        = "ARPHELPTELEPHONE",
    IPROPNAME_ARPINSTALLLOCATION      = "ARPINSTALLLOCATION",
    IPROPNAME_ARPNOMODIFY             = "ARPNOMODIFY",
    IPROPNAME_ARPNOREMOVE             = "ARPNOREMOVE",
    IPROPNAME_ARPNOREPAIR             = "ARPNOREPAIR",
    IPROPNAME_ARPREADME               = "ARPREADME",
    IPROPNAME_ARPSIZE                 = "ARPSIZE",
    IPROPNAME_ARPSYSTEMCOMPONENT      = "ARPSYSTEMCOMPONENT",
    IPROPNAME_ARPURLINFOABOUT         = "ARPURLINFOABOUT",
    IPROPNAME_ARPURLUPDATEINFO        = "ARPURLUPDATEINFO",
    IPROPNAME_ARPPRODUCTICON          = "ARPPRODUCTICON",
    IPROPNAME_ARPSETTINGSIDENTIFIER   = "MSIARPSETTINGSIDENTIFIER",
    IPROPNAME_ARPSHIMFLAGS            = "SHIMFLAGS",
    IPROPNAME_ARPSHIMVERSIONNT        = "SHIMVERSIONNT",
    IPROPNAME_ARPSHIMSERVICEPACKLEVEL = "SHIMSERVICEPACKLEVEL",
}

enum : const(wchar)*
{
    IPROPNAME_INSTALLED          = "Installed",
    IPROPNAME_PRODUCTSTATE       = "ProductState",
    IPROPNAME_PRESELECTED        = "Preselected",
    IPROPNAME_RESUME             = "RESUME",
    IPROPNAME_UPDATESTARTED      = "UpdateStarted",
    IPROPNAME_PRODUCTID          = "ProductID",
    IPROPNAME_OUTOFDISKSPACE     = "OutOfDiskSpace",
    IPROPNAME_OUTOFNORBDISKSPACE = "OutOfNoRbDiskSpace",
}

enum const(wchar)* IPROPNAME_COSTINGCOMPLETE = "CostingComplete";

enum : const(wchar)*
{
    IPROPNAME_SOURCEDIR          = "SourceDir",
    IPROPNAME_REPLACEDINUSEFILES = "ReplacedInUseFiles",
}

enum : const(wchar)*
{
    IPROPNAME_PRIMARYFOLDER_PATH           = "PrimaryVolumePath",
    IPROPNAME_PRIMARYFOLDER_SPACEAVAILABLE = "PrimaryVolumeSpaceAvailable",
    IPROPNAME_PRIMARYFOLDER_SPACEREQUIRED  = "PrimaryVolumeSpaceRequired",
    IPROPNAME_PRIMARYFOLDER_SPACEREMAINING = "PrimaryVolumeSpaceRemaining",
}

enum : const(wchar)*
{
    IPROPNAME_ISADMINPACKAGE        = "IsAdminPackage",
    IPROPNAME_ROLLBACKDISABLED      = "RollbackDisabled",
    IPROPNAME_RESTRICTEDUSERCONTROL = "RestrictedUserControl",
}

enum : const(wchar)*
{
    IPROPNAME_SOURCERESONLY       = "MsiUISourceResOnly",
    IPROPNAME_HIDECANCEL          = "MsiUIHideCancel",
    IPROPNAME_PROGRESSONLY        = "MsiUIProgressOnly",
    IPROPNAME_UACONLY             = "MsiUIUACOnly",
    IPROPNAME_TIME                = "Time",
    IPROPNAME_DATE                = "Date",
    IPROPNAME_DATETIME            = "DateTime",
    IPROPNAME_ARM                 = "Arm",
    IPROPNAME_ARM64               = "Arm64",
    IPROPNAME_INTEL               = "Intel",
    IPROPNAME_TEMPLATE_AMD64      = "AMD64",
    IPROPNAME_TEMPLATE_X64        = "x64",
    IPROPNAME_MSIAMD64            = "MsiAMD64",
    IPROPNAME_MSIX64              = "Msix64",
    IPROPNAME_INTEL64             = "Intel64",
    IPROPNAME_IA64                = "IA64",
    IPROPNAME_TEXTHEIGHT          = "TextHeight",
    IPROPNAME_TEXTINTERNALLEADING = "TextInternalLeading",
}

enum : const(wchar)*
{
    IPROPNAME_SCREENX               = "ScreenX",
    IPROPNAME_SCREENY               = "ScreenY",
    IPROPNAME_CAPTIONHEIGHT         = "CaptionHeight",
    IPROPNAME_BORDERTOP             = "BorderTop",
    IPROPNAME_BORDERSIDE            = "BorderSide",
    IPROPNAME_COLORBITS             = "ColorBits",
    IPROPNAME_PHYSICALMEMORY        = "PhysicalMemory",
    IPROPNAME_VIRTUALMEMORY         = "VirtualMemory",
    IPROPNAME_TEXTHEIGHT_CORRECTION = "TextHeightCorrection",
}

enum : const(wchar)*
{
    IPROPNAME_MSITABLETPC           = "MsiTabletPC",
    IPROPNAME_VERSIONNT             = "VersionNT",
    IPROPNAME_VERSION9X             = "Version9X",
    IPROPNAME_VERSIONNT64           = "VersionNT64",
    IPROPNAME_WINDOWSBUILD          = "WindowsBuild",
    IPROPNAME_SERVICEPACKLEVEL      = "ServicePackLevel",
    IPROPNAME_SERVICEPACKLEVELMINOR = "ServicePackLevelMinor",
}

enum : const(wchar)*
{
    IPROPNAME_SHAREDWINDOWS    = "SharedWindows",
    IPROPNAME_COMPUTERNAME     = "ComputerName",
    IPROPNAME_SHELLADVTSUPPORT = "ShellAdvtSupport",
}

enum : const(wchar)*
{
    IPROPNAME_OLEADVTSUPPORT   = "OLEAdvtSupport",
    IPROPNAME_SYSTEMLANGUAGEID = "SystemLanguageID",
}

enum : const(wchar)*
{
    IPROPNAME_TTCSUPPORT           = "TTCSupport",
    IPROPNAME_TERMSERVER           = "TerminalServer",
    IPROPNAME_REMOTEADMINTS        = "RemoteAdminTS",
    IPROPNAME_REDIRECTEDDLLSUPPORT = "RedirectedDllSupport",
}

enum : const(wchar)*
{
    IPROPNAME_NTPRODUCTTYPE                  = "MsiNTProductType",
    IPROPNAME_NTSUITEBACKOFFICE              = "MsiNTSuiteBackOffice",
    IPROPNAME_NTSUITEDATACENTER              = "MsiNTSuiteDataCenter",
    IPROPNAME_NTSUITEENTERPRISE              = "MsiNTSuiteEnterprise",
    IPROPNAME_NTSUITESMALLBUSINESS           = "MsiNTSuiteSmallBusiness",
    IPROPNAME_NTSUITESMALLBUSINESSRESTRICTED = "MsiNTSuiteSmallBusinessRestricted",
    IPROPNAME_NTSUITEPERSONAL                = "MsiNTSuitePersonal",
    IPROPNAME_NTSUITEWEBSERVER               = "MsiNTSuiteWebServer",
    IPROPNAME_NETASSEMBLYSUPPORT             = "MsiNetAssemblySupport",
}

enum const(wchar)* IPROPNAME_WIN32ASSEMBLYSUPPORT = "MsiWin32AssemblySupport";

enum : const(wchar)*
{
    IPROPNAME_LOGONUSER       = "LogonUser",
    IPROPNAME_USERSID         = "UserSID",
    IPROPNAME_ADMINUSER       = "AdminUser",
    IPROPNAME_USERLANGUAGEID  = "UserLanguageID",
    IPROPNAME_PRIVILEGED      = "Privileged",
    IPROPNAME_RUNNINGELEVATED = "MsiRunningElevated",
}

enum : const(wchar)*
{
    IPROPNAME_TRUEADMINUSER   = "MsiTrueAdminUser",
    IPROPNAME_WINDOWS_FOLDER  = "WindowsFolder",
    IPROPNAME_SYSTEM_FOLDER   = "SystemFolder",
    IPROPNAME_SYSTEM16_FOLDER = "System16Folder",
}

enum : const(wchar)*
{
    IPROPNAME_WINDOWS_VOLUME      = "WindowsVolume",
    IPROPNAME_TEMP_FOLDER         = "TempFolder",
    IPROPNAME_PROGRAMFILES_FOLDER = "ProgramFilesFolder",
}

enum const(wchar)* IPROPNAME_COMMONFILES_FOLDER = "CommonFilesFolder";
enum const(wchar)* IPROPNAME_SYSTEM64_FOLDER = "System64Folder";
enum const(wchar)* IPROPNAME_PROGRAMFILES64_FOLDER = "ProgramFiles64Folder";
enum const(wchar)* IPROPNAME_COMMONFILES64_FOLDER = "CommonFiles64Folder";
enum const(wchar)* IPROPNAME_STARTMENU_FOLDER = "StartMenuFolder";
enum const(wchar)* IPROPNAME_PROGRAMMENU_FOLDER = "ProgramMenuFolder";

enum : const(wchar)*
{
    IPROPNAME_STARTUP_FOLDER  = "StartupFolder",
    IPROPNAME_NETHOOD_FOLDER  = "NetHoodFolder",
    IPROPNAME_PERSONAL_FOLDER = "PersonalFolder",
}

enum : const(wchar)*
{
    IPROPNAME_SENDTO_FOLDER   = "SendToFolder",
    IPROPNAME_DESKTOP_FOLDER  = "DesktopFolder",
    IPROPNAME_TEMPLATE_FOLDER = "TemplateFolder",
}

enum : const(wchar)*
{
    IPROPNAME_FONTS_FOLDER     = "FontsFolder",
    IPROPNAME_FAVORITES_FOLDER = "FavoritesFolder",
}

enum : const(wchar)*
{
    IPROPNAME_RECENT_FOLDER    = "RecentFolder",
    IPROPNAME_APPDATA_FOLDER   = "AppDataFolder",
    IPROPNAME_PRINTHOOD_FOLDER = "PrintHoodFolder",
}

enum const(wchar)* IPROPNAME_ADMINTOOLS_FOLDER = "AdminToolsFolder";
enum const(wchar)* IPROPNAME_COMMONAPPDATA_FOLDER = "CommonAppDataFolder";
enum const(wchar)* IPROPNAME_LOCALAPPDATA_FOLDER = "LocalAppDataFolder";
enum const(wchar)* IPROPNAME_MYPICTURES_FOLDER = "MyPicturesFolder";

enum : const(wchar)*
{
    IPROPNAME_FEATUREADDLOCAL   = "ADDLOCAL",
    IPROPNAME_FEATUREADDSOURCE  = "ADDSOURCE",
    IPROPNAME_FEATUREADDDEFAULT = "ADDDEFAULT",
    IPROPNAME_FEATUREREMOVE     = "REMOVE",
    IPROPNAME_FEATUREADVERTISE  = "ADVERTISE",
}

enum const(wchar)* IPROPVALUE_FEATURE_ALL = "ALL";

enum : const(wchar)*
{
    IPROPNAME_COMPONENTADDLOCAL   = "COMPADDLOCAL",
    IPROPNAME_COMPONENTADDSOURCE  = "COMPADDSOURCE",
    IPROPNAME_COMPONENTADDDEFAULT = "COMPADDDEFAULT",
}

enum : const(wchar)*
{
    IPROPNAME_FILEADDLOCAL       = "FILEADDLOCAL",
    IPROPNAME_FILEADDSOURCE      = "FILEADDSOURCE",
    IPROPNAME_FILEADDDEFAULT     = "FILEADDDEFAULT",
    IPROPNAME_REINSTALL          = "REINSTALL",
    IPROPNAME_REINSTALLMODE      = "REINSTALLMODE",
    IPROPNAME_PROMPTROLLBACKCOST = "PROMPTROLLBACKCOST",
}

enum : const(wchar)*
{
    IPROPVALUE_RBCOST_PROMPT = "P",
    IPROPVALUE_RBCOST_SILENT = "D",
    IPROPVALUE_RBCOST_FAIL   = "F",
}

enum const(wchar)* IPROPNAME_CUSTOMACTIONDATA = "CustomActionData";

enum : const(wchar)*
{
    IACTIONNAME_INSTALL         = "INSTALL",
    IACTIONNAME_ADVERTISE       = "ADVERTISE",
    IACTIONNAME_ADMIN           = "ADMIN",
    IACTIONNAME_SEQUENCE        = "SEQUENCE",
    IACTIONNAME_COLLECTUSERINFO = "CollectUserInfo",
    IACTIONNAME_FIRSTRUN        = "FirstRun",
}

enum : uint
{
    PID_TITLE   = 0x00000002U,
    PID_SUBJECT = 0x00000003U,
}

enum uint PID_AUTHOR = 0x00000004U;
enum uint PID_KEYWORDS = 0x00000005U;
enum uint PID_COMMENTS = 0x00000006U;
enum uint PID_TEMPLATE = 0x00000007U;
enum uint PID_LASTAUTHOR = 0x00000008U;
enum uint PID_REVNUMBER = 0x00000009U;
enum uint PID_EDITTIME = 0x0000000aU;
enum uint PID_LASTPRINTED = 0x0000000bU;
enum uint PID_CREATE_DTM = 0x0000000cU;
enum uint PID_LASTSAVE_DTM = 0x0000000dU;
enum uint PID_PAGECOUNT = 0x0000000eU;
enum uint PID_WORDCOUNT = 0x0000000fU;
enum uint PID_CHARCOUNT = 0x00000010U;
enum uint PID_THUMBNAIL = 0x00000011U;
enum uint PID_APPNAME = 0x00000012U;

enum : uint
{
    PID_MSIVERSION  = 0x0000000eU,
    PID_MSISOURCE   = 0x0000000fU,
    PID_MSIRESTRICT = 0x00000010U,
}

enum : uint
{
    PATCH_OPTION_USE_BEST          = 0x00000000U,
    PATCH_OPTION_USE_LZX_BEST      = 0x00000003U,
    PATCH_OPTION_USE_LZX_A         = 0x00000001U,
    PATCH_OPTION_USE_LZX_B         = 0x00000002U,
    PATCH_OPTION_USE_LZX_LARGE     = 0x00000004U,
    PATCH_OPTION_NO_BINDFIX        = 0x00010000U,
    PATCH_OPTION_NO_LOCKFIX        = 0x00020000U,
    PATCH_OPTION_NO_REBASE         = 0x00040000U,
    PATCH_OPTION_FAIL_IF_SAME_FILE = 0x00080000U,
    PATCH_OPTION_FAIL_IF_BIGGER    = 0x00100000U,
    PATCH_OPTION_NO_CHECKSUM       = 0x00200000U,
    PATCH_OPTION_NO_RESTIMEFIX     = 0x00400000U,
    PATCH_OPTION_NO_TIMESTAMP      = 0x00800000U,
    PATCH_OPTION_SIGNATURE_MD5     = 0x01000000U,
    PATCH_OPTION_INTERLEAVE_FILES  = 0x40000000U,
    PATCH_OPTION_RESERVED1         = 0x80000000U,
    PATCH_OPTION_VALID_FLAGS       = 0xc0ff0007U,
}

enum : uint
{
    PATCH_SYMBOL_NO_IMAGEHLP     = 0x00000001U,
    PATCH_SYMBOL_NO_FAILURES     = 0x00000002U,
    PATCH_SYMBOL_UNDECORATED_TOO = 0x00000004U,
    PATCH_SYMBOL_RESERVED1       = 0x80000000U,
}

enum : uint
{
    PATCH_TRANSFORM_PE_RESOURCE_2 = 0x00000100U,
    PATCH_TRANSFORM_PE_IRELOC_2   = 0x00000200U,
}

enum : uint
{
    APPLY_OPTION_FAIL_IF_EXACT = 0x00000001U,
    APPLY_OPTION_FAIL_IF_CLOSE = 0x00000002U,
    APPLY_OPTION_TEST_ONLY     = 0x00000004U,
    APPLY_OPTION_VALID_FLAGS   = 0x00000007U,
}

enum : uint
{
    ERROR_PATCH_ENCODE_FAILURE       = 0xc00e3101U,
    ERROR_PATCH_INVALID_OPTIONS      = 0xc00e3102U,
    ERROR_PATCH_SAME_FILE            = 0xc00e3103U,
    ERROR_PATCH_RETAIN_RANGES_DIFFER = 0xc00e3104U,
}

enum uint ERROR_PATCH_BIGGER_THAN_COMPRESSED = 0xc00e3105U;

enum : uint
{
    ERROR_PATCH_IMAGEHLP_FAILURE = 0xc00e3106U,
    ERROR_PATCH_DECODE_FAILURE   = 0xc00e4101U,
    ERROR_PATCH_CORRUPT          = 0xc00e4102U,
    ERROR_PATCH_NEWER_FORMAT     = 0xc00e4103U,
    ERROR_PATCH_WRONG_FILE       = 0xc00e4104U,
    ERROR_PATCH_NOT_NECESSARY    = 0xc00e4105U,
    ERROR_PATCH_NOT_AVAILABLE    = 0xc00e4106U,
}

enum : uint
{
    ERROR_PCW_BASE                    = 0xc00e5101U,
    ERROR_PCW_PCP_DOESNT_EXIST        = 0xc00e5101U,
    ERROR_PCW_PCP_BAD_FORMAT          = 0xc00e5102U,
    ERROR_PCW_CANT_CREATE_TEMP_FOLDER = 0xc00e5103U,
}

enum uint ERROR_PCW_MISSING_PATCH_PATH = 0xc00e5104U;

enum : uint
{
    ERROR_PCW_CANT_OVERWRITE_PATCH   = 0xc00e5105U,
    ERROR_PCW_CANT_CREATE_PATCH_FILE = 0xc00e5106U,
}

enum uint ERROR_PCW_MISSING_PATCH_GUID = 0xc00e5107U;

enum : uint
{
    ERROR_PCW_BAD_PATCH_GUID               = 0xc00e5108U,
    ERROR_PCW_BAD_GUIDS_TO_REPLACE         = 0xc00e5109U,
    ERROR_PCW_BAD_TARGET_PRODUCT_CODE_LIST = 0xc00e510aU,
}

enum uint ERROR_PCW_NO_UPGRADED_IMAGES_TO_PATCH = 0xc00e510bU;
enum uint ERROR_PCW_BAD_API_PATCHING_SYMBOL_FLAGS = 0xc00e510dU;
enum uint ERROR_PCW_OODS_COPYING_MSI = 0xc00e510eU;
enum uint ERROR_PCW_UPGRADED_IMAGE_NAME_TOO_LONG = 0xc00e510fU;
enum uint ERROR_PCW_BAD_UPGRADED_IMAGE_NAME = 0xc00e5110U;
enum uint ERROR_PCW_DUP_UPGRADED_IMAGE_NAME = 0xc00e5111U;

enum : uint
{
    ERROR_PCW_UPGRADED_IMAGE_PATH_TOO_LONG  = 0xc00e5112U,
    ERROR_PCW_UPGRADED_IMAGE_PATH_EMPTY     = 0xc00e5113U,
    ERROR_PCW_UPGRADED_IMAGE_PATH_NOT_EXIST = 0xc00e5114U,
    ERROR_PCW_UPGRADED_IMAGE_PATH_NOT_MSI   = 0xc00e5115U,
    ERROR_PCW_UPGRADED_IMAGE_COMPRESSED     = 0xc00e5116U,
}

enum uint ERROR_PCW_TARGET_IMAGE_NAME_TOO_LONG = 0xc00e5117U;
enum uint ERROR_PCW_BAD_TARGET_IMAGE_NAME = 0xc00e5118U;
enum uint ERROR_PCW_DUP_TARGET_IMAGE_NAME = 0xc00e5119U;

enum : uint
{
    ERROR_PCW_TARGET_IMAGE_PATH_TOO_LONG  = 0xc00e511aU,
    ERROR_PCW_TARGET_IMAGE_PATH_EMPTY     = 0xc00e511bU,
    ERROR_PCW_TARGET_IMAGE_PATH_NOT_EXIST = 0xc00e511cU,
    ERROR_PCW_TARGET_IMAGE_PATH_NOT_MSI   = 0xc00e511dU,
    ERROR_PCW_TARGET_IMAGE_COMPRESSED     = 0xc00e511eU,
    ERROR_PCW_TARGET_BAD_PROD_VALIDATE    = 0xc00e511fU,
    ERROR_PCW_TARGET_BAD_PROD_CODE_VAL    = 0xc00e5120U,
}

enum uint ERROR_PCW_UPGRADED_MISSING_SRC_FILES = 0xc00e5121U;
enum uint ERROR_PCW_TARGET_MISSING_SRC_FILES = 0xc00e5122U;
enum uint ERROR_PCW_IMAGE_FAMILY_NAME_TOO_LONG = 0xc00e5123U;
enum uint ERROR_PCW_BAD_IMAGE_FAMILY_NAME = 0xc00e5124U;
enum uint ERROR_PCW_DUP_IMAGE_FAMILY_NAME = 0xc00e5125U;
enum uint ERROR_PCW_BAD_IMAGE_FAMILY_SRC_PROP = 0xc00e5126U;

enum : uint
{
    ERROR_PCW_UFILEDATA_LONG_FILE_TABLE_KEY    = 0xc00e5127U,
    ERROR_PCW_UFILEDATA_BLANK_FILE_TABLE_KEY   = 0xc00e5128U,
    ERROR_PCW_UFILEDATA_MISSING_FILE_TABLE_KEY = 0xc00e5129U,
}

enum : uint
{
    ERROR_PCW_EXTFILE_LONG_FILE_TABLE_KEY  = 0xc00e512aU,
    ERROR_PCW_EXTFILE_BLANK_FILE_TABLE_KEY = 0xc00e512bU,
    ERROR_PCW_EXTFILE_BAD_FAMILY_FIELD     = 0xc00e512cU,
    ERROR_PCW_EXTFILE_LONG_PATH_TO_FILE    = 0xc00e512dU,
    ERROR_PCW_EXTFILE_BLANK_PATH_TO_FILE   = 0xc00e512eU,
    ERROR_PCW_EXTFILE_MISSING_FILE         = 0xc00e512fU,
}

enum uint ERROR_PCW_BAD_FILE_SEQUENCE_START = 0xc00e513aU;

enum : uint
{
    ERROR_PCW_CANT_COPY_FILE_TO_TEMP_FOLDER = 0xc00e513bU,
    ERROR_PCW_CANT_CREATE_ONE_PATCH_FILE    = 0xc00e513cU,
}

enum : uint
{
    ERROR_PCW_BAD_IMAGE_FAMILY_DISKID       = 0xc00e513dU,
    ERROR_PCW_BAD_IMAGE_FAMILY_FILESEQSTART = 0xc00e513eU,
}

enum uint ERROR_PCW_BAD_UPGRADED_IMAGE_FAMILY = 0xc00e513fU;
enum uint ERROR_PCW_BAD_TARGET_IMAGE_UPGRADED = 0xc00e5140U;
enum uint ERROR_PCW_DUP_TARGET_IMAGE_PACKCODE = 0xc00e5141U;
enum uint ERROR_PCW_UFILEDATA_BAD_UPGRADED_FIELD = 0xc00e5142U;

enum : uint
{
    ERROR_PCW_MISMATCHED_PRODUCT_CODES    = 0xc00e5143U,
    ERROR_PCW_MISMATCHED_PRODUCT_VERSIONS = 0xc00e5144U,
}

enum : uint
{
    ERROR_PCW_CANNOT_WRITE_DDF   = 0xc00e5145U,
    ERROR_PCW_CANNOT_RUN_MAKECAB = 0xc00e5146U,
}

enum uint ERROR_PCW_WRITE_SUMMARY_PROPERTIES = 0xc00e514bU;

enum : uint
{
    ERROR_PCW_TFILEDATA_LONG_FILE_TABLE_KEY    = 0xc00e514cU,
    ERROR_PCW_TFILEDATA_BLANK_FILE_TABLE_KEY   = 0xc00e514dU,
    ERROR_PCW_TFILEDATA_MISSING_FILE_TABLE_KEY = 0xc00e514eU,
    ERROR_PCW_TFILEDATA_BAD_TARGET_FIELD       = 0xc00e514fU,
}

enum : uint
{
    ERROR_PCW_UPGRADED_IMAGE_PATCH_PATH_TOO_LONG  = 0xc00e5150U,
    ERROR_PCW_UPGRADED_IMAGE_PATCH_PATH_NOT_EXIST = 0xc00e5151U,
    ERROR_PCW_UPGRADED_IMAGE_PATCH_PATH_NOT_MSI   = 0xc00e5152U,
}

enum uint ERROR_PCW_DUP_UPGRADED_IMAGE_PACKCODE = 0xc00e5153U;

enum : uint
{
    ERROR_PCW_UFILEIGNORE_BAD_UPGRADED_FIELD   = 0xc00e5154U,
    ERROR_PCW_UFILEIGNORE_LONG_FILE_TABLE_KEY  = 0xc00e5155U,
    ERROR_PCW_UFILEIGNORE_BLANK_FILE_TABLE_KEY = 0xc00e5156U,
    ERROR_PCW_UFILEIGNORE_BAD_FILE_TABLE_KEY   = 0xc00e5157U,
}

enum uint ERROR_PCW_FAMILY_RANGE_NAME_TOO_LONG = 0xc00e5158U;
enum uint ERROR_PCW_BAD_FAMILY_RANGE_NAME = 0xc00e5159U;

enum : uint
{
    ERROR_PCW_FAMILY_RANGE_LONG_FILE_TABLE_KEY  = 0xc00e515aU,
    ERROR_PCW_FAMILY_RANGE_BLANK_FILE_TABLE_KEY = 0xc00e515bU,
    ERROR_PCW_FAMILY_RANGE_LONG_RETAIN_OFFSETS  = 0xc00e515cU,
    ERROR_PCW_FAMILY_RANGE_BLANK_RETAIN_OFFSETS = 0xc00e515dU,
    ERROR_PCW_FAMILY_RANGE_BAD_RETAIN_OFFSETS   = 0xc00e515eU,
    ERROR_PCW_FAMILY_RANGE_LONG_RETAIN_LENGTHS  = 0xc00e515fU,
    ERROR_PCW_FAMILY_RANGE_BLANK_RETAIN_LENGTHS = 0xc00e5160U,
    ERROR_PCW_FAMILY_RANGE_BAD_RETAIN_LENGTHS   = 0xc00e5161U,
    ERROR_PCW_FAMILY_RANGE_COUNT_MISMATCH       = 0xc00e5162U,
}

enum : uint
{
    ERROR_PCW_EXTFILE_LONG_IGNORE_OFFSETS   = 0xc00e5163U,
    ERROR_PCW_EXTFILE_BAD_IGNORE_OFFSETS    = 0xc00e5164U,
    ERROR_PCW_EXTFILE_LONG_IGNORE_LENGTHS   = 0xc00e5165U,
    ERROR_PCW_EXTFILE_BAD_IGNORE_LENGTHS    = 0xc00e5166U,
    ERROR_PCW_EXTFILE_IGNORE_COUNT_MISMATCH = 0xc00e5167U,
    ERROR_PCW_EXTFILE_LONG_RETAIN_OFFSETS   = 0xc00e5168U,
    ERROR_PCW_EXTFILE_BAD_RETAIN_OFFSETS    = 0xc00e5169U,
}

enum : uint
{
    ERROR_PCW_TFILEDATA_LONG_IGNORE_OFFSETS   = 0xc00e516bU,
    ERROR_PCW_TFILEDATA_BAD_IGNORE_OFFSETS    = 0xc00e516cU,
    ERROR_PCW_TFILEDATA_LONG_IGNORE_LENGTHS   = 0xc00e516dU,
    ERROR_PCW_TFILEDATA_BAD_IGNORE_LENGTHS    = 0xc00e516eU,
    ERROR_PCW_TFILEDATA_IGNORE_COUNT_MISMATCH = 0xc00e516fU,
    ERROR_PCW_TFILEDATA_LONG_RETAIN_OFFSETS   = 0xc00e5170U,
    ERROR_PCW_TFILEDATA_BAD_RETAIN_OFFSETS    = 0xc00e5171U,
}

enum : uint
{
    ERROR_PCW_CANT_GENERATE_TRANSFORM       = 0xc00e5173U,
    ERROR_PCW_CANT_CREATE_SUMMARY_INFO      = 0xc00e5174U,
    ERROR_PCW_CANT_GENERATE_TRANSFORM_POUND = 0xc00e5175U,
}

enum uint ERROR_PCW_CANT_CREATE_SUMMARY_INFO_POUND = 0xc00e5176U;

enum : uint
{
    ERROR_PCW_BAD_UPGRADED_IMAGE_PRODUCT_CODE    = 0xc00e5177U,
    ERROR_PCW_BAD_UPGRADED_IMAGE_PRODUCT_VERSION = 0xc00e5178U,
    ERROR_PCW_BAD_UPGRADED_IMAGE_UPGRADE_CODE    = 0xc00e5179U,
}

enum : uint
{
    ERROR_PCW_BAD_TARGET_IMAGE_PRODUCT_CODE    = 0xc00e517aU,
    ERROR_PCW_BAD_TARGET_IMAGE_PRODUCT_VERSION = 0xc00e517bU,
    ERROR_PCW_BAD_TARGET_IMAGE_UPGRADE_CODE    = 0xc00e517cU,
}

enum uint ERROR_PCW_MATCHED_PRODUCT_VERSIONS = 0xc00e517dU;

enum : uint
{
    ERROR_PCW_OBSOLETION_WITH_SEQUENCE_DATA = 0xc00e517eU,
    ERROR_PCW_OBSOLETION_WITH_MSI30         = 0xc00e517fU,
    ERROR_PCW_OBSOLETION_WITH_PATCHSEQUENCE = 0xc00e5180U,
}

enum : uint
{
    ERROR_PCW_CANNOT_CREATE_TABLE                  = 0xc00e5181U,
    ERROR_PCW_CANT_GENERATE_SEQUENCEINFO_MAJORUPGD = 0xc00e5182U,
}

enum uint ERROR_PCW_MAJOR_UPGD_WITHOUT_SEQUENCING = 0xc00e5183U;
enum uint ERROR_PCW_BAD_PRODUCTVERSION_VALIDATION = 0xc00e5184U;

enum : uint
{
    ERROR_PCW_BAD_TRANSFORMSET     = 0xc00e5185U,
    ERROR_PCW_BAD_TGT_UPD_IMAGES   = 0xc00e5186U,
    ERROR_PCW_BAD_SUPERCEDENCE     = 0xc00e5187U,
    ERROR_PCW_BAD_SEQUENCE         = 0xc00e5188U,
    ERROR_PCW_BAD_TARGET           = 0xc00e5189U,
    ERROR_PCW_NULL_PATCHFAMILY     = 0xc00e518aU,
    ERROR_PCW_NULL_SEQUENCE_NUMBER = 0xc00e518bU,
}

enum : uint
{
    ERROR_PCW_BAD_VERSION_STRING = 0xc00e518cU,
    ERROR_PCW_BAD_MAJOR_VERSION  = 0xc00e518dU,
}

enum uint ERROR_PCW_SEQUENCING_BAD_TARGET = 0xc00e518eU;
enum uint ERROR_PCW_PATCHMETADATA_PROP_NOT_SET = 0xc00e518fU;

enum : uint
{
    ERROR_PCW_INVALID_PATCHMETADATA_PROP = 0xc00e5190U,
    ERROR_PCW_INVALID_SUPERCEDENCE       = 0xc00e5191U,
}

enum uint ERROR_PCW_DUPLICATE_SEQUENCE_RECORD = 0xc00e5192U;
enum uint ERROR_PCW_WRONG_PATCHMETADATA_STRD_PROP = 0xc00e5193U;
enum uint ERROR_PCW_INVALID_PARAMETER = 0xc00e5194U;
enum uint ERROR_PCW_CREATEFILE_LOG_FAILED = 0xc00e5195U;

enum : uint
{
    ERROR_PCW_INVALID_LOG_LEVEL = 0xc00e5196U,
    ERROR_PCW_INVALID_UI_LEVEL  = 0xc00e5197U,
}

enum uint ERROR_PCW_ERROR_WRITING_TO_LOG = 0xc00e5198U;

enum : uint
{
    ERROR_PCW_OUT_OF_MEMORY      = 0xc00e5199U,
    ERROR_PCW_UNKNOWN_ERROR      = 0xc00e519aU,
    ERROR_PCW_UNKNOWN_INFO       = 0xc00e519bU,
    ERROR_PCW_UNKNOWN_WARN       = 0xc00e519cU,
    ERROR_PCW_OPEN_VIEW          = 0xc00e519dU,
    ERROR_PCW_EXECUTE_VIEW       = 0xc00e519eU,
    ERROR_PCW_VIEW_FETCH         = 0xc00e519fU,
    ERROR_PCW_FAILED_EXPAND_PATH = 0xc00e51a0U,
}

enum : uint
{
    ERROR_PCW_INTERNAL_ERROR           = 0xc00e5201U,
    ERROR_PCW_INVALID_PCP_PROPERTY     = 0xc00e5202U,
    ERROR_PCW_INVALID_PCP_TARGETIMAGES = 0xc00e5203U,
}

enum uint ERROR_PCW_LAX_VALIDATION_FLAGS = 0xc00e5204U;
enum uint ERROR_PCW_FAILED_CREATE_TRANSFORM = 0xc00e5205U;
enum uint ERROR_PCW_CANT_DELETE_TEMP_FOLDER = 0xc00e5206U;
enum uint ERROR_PCW_MISSING_DIRECTORY_TABLE = 0xc00e5207U;

enum : uint
{
    ERROR_PCW_INVALID_SUPERSEDENCE_VALUE    = 0xc00e5208U,
    ERROR_PCW_INVALID_PATCH_TYPE_SEQUENCING = 0xc00e5209U,
}

enum : uint
{
    ERROR_PCW_CANT_READ_FILE                    = 0xc00e520aU,
    ERROR_PCW_TARGET_WRONG_PRODUCT_VERSION_COMP = 0xc00e520bU,
}

enum : uint
{
    ERROR_PCW_INVALID_PCP_UPGRADEDFILESTOIGNORE      = 0xc00e520cU,
    ERROR_PCW_INVALID_PCP_UPGRADEDIMAGES             = 0xc00e520dU,
    ERROR_PCW_INVALID_PCP_EXTERNALFILES              = 0xc00e520eU,
    ERROR_PCW_INVALID_PCP_IMAGEFAMILIES              = 0xc00e520fU,
    ERROR_PCW_INVALID_PCP_PATCHSEQUENCE              = 0xc00e5210U,
    ERROR_PCW_INVALID_PCP_TARGETFILES_OPTIONALDATA   = 0xc00e5211U,
    ERROR_PCW_INVALID_PCP_UPGRADEDFILES_OPTIONALDATA = 0xc00e5212U,
}

enum uint ERROR_PCW_MISSING_PATCHMETADATA = 0xc00e5213U;
enum uint ERROR_PCW_IMAGE_PATH_NOT_EXIST = 0xc00e5214U;

enum : uint
{
    ERROR_PCW_INVALID_RANGE_ELEMENT        = 0xc00e5215U,
    ERROR_PCW_INVALID_MAJOR_VERSION        = 0xc00e5216U,
    ERROR_PCW_INVALID_PCP_PROPERTIES       = 0xc00e5217U,
    ERROR_PCW_INVALID_PCP_FAMILYFILERANGES = 0xc00e5218U,
}

enum : uint
{
    INFO_BASE                = 0xc00f5101U,
    INFO_PASSED_MAIN_CONTROL = 0xc00f5101U,
}

enum : uint
{
    INFO_ENTERING_PHASE_I_VALIDATION = 0xc00f5102U,
    INFO_ENTERING_PHASE_I            = 0xc00f5103U,
}

enum uint INFO_PCP_PATH = 0xc00f5104U;
enum uint INFO_TEMP_DIR = 0xc00f5105U;
enum uint INFO_SET_OPTIONS = 0xc00f5106U;
enum uint INFO_PROPERTY = 0xc00f5107U;

enum : uint
{
    INFO_ENTERING_PHASE_II  = 0xc00f5108U,
    INFO_ENTERING_PHASE_III = 0xc00f5109U,
    INFO_ENTERING_PHASE_IV  = 0xc00f510aU,
    INFO_ENTERING_PHASE_V   = 0xc00f510bU,
}

enum uint INFO_GENERATING_METADATA = 0xc00f5111U;
enum uint INFO_TEMP_DIR_CLEANUP = 0xc00f5112U;

enum : uint
{
    INFO_PATCHCACHE_FILEINFO_FAILURE = 0xc00f5113U,
    INFO_PATCHCACHE_PCI_READFAILURE  = 0xc00f5114U,
    INFO_PATCHCACHE_PCI_WRITEFAILURE = 0xc00f5115U,
}

enum uint INFO_USING_USER_MSI_FOR_PATCH_TABLES = 0xc00f5116U;
enum uint INFO_SUCCESSFUL_PATCH_CREATION = 0xc00f5117U;

enum : uint
{
    WARN_BASE                = 0xc0105101U,
    WARN_MAJOR_UPGRADE_PATCH = 0xc0105101U,
}

enum : uint
{
    WARN_SEQUENCE_DATA_GENERATION_DISABLED  = 0xc0105102U,
    WARN_SEQUENCE_DATA_SUPERSEDENCE_IGNORED = 0xc0105103U,
}

enum uint WARN_IMPROPER_TRANSFORM_VALIDATION = 0xc0105104U;

enum : uint
{
    WARN_PCW_MISMATCHED_PRODUCT_CODES    = 0xc0105105U,
    WARN_PCW_MISMATCHED_PRODUCT_VERSIONS = 0xc0105106U,
}

enum uint WARN_INVALID_TRANSFORM_VALIDATION = 0xc0105107U;
enum uint WARN_BAD_MAJOR_VERSION = 0xc0105108U;
enum uint WARN_FILE_VERSION_DOWNREV = 0xc0105109U;
enum uint WARN_EQUAL_FILE_VERSION = 0xc010510aU;
enum uint WARN_PATCHPROPERTYNOTSET = 0xc010510bU;

enum : uint
{
    WARN_OBSOLETION_WITH_SEQUENCE_DATA = 0xc0105112U,
    WARN_OBSOLETION_WITH_MSI30         = 0xc0105111U,
    WARN_OBSOLETION_WITH_PATCHSEQUENCE = 0xc0105113U,
}

enum uint DELTA_MAX_HASH_SIZE = 0x00000020U;
enum int cchMaxInteger = 0x0000000c;

enum : uint
{
    LOGNONE         = 0x00000000U,
    LOGINFO         = 0x00000001U,
    LOGWARN         = 0x00000002U,
    LOGERR          = 0x00000004U,
    LOGPERFMESSAGES = 0x00000008U,
}

enum uint LOGALL = 0x0000000fU;
enum uint UINONE = 0x00000000U;
enum uint UILOGBITS = 0x0000000fU;
enum uint DEFAULT_MINIMUM_REQUIRED_MSI_VERSION = 0x00000064U;
enum uint DEFAULT_FILE_SEQUENCE_START = 0x00000002U;
enum uint DEFAULT_DISK_ID = 0x00000002U;

// Callbacks

alias LPDISPLAYVAL = BOOL function(void* pContext, RESULTTYPES uiType, const(PWSTR) szwVal, 
                                   const(PWSTR) szwDescription, const(PWSTR) szwLocation);
alias LPEVALCOMCALLBACK = BOOL function(STATUSTYPES iStatus, const(PWSTR) szData, void* pContext);
//DELEGATE ATTR: AnsiAttribute : CustomAttributeSig([], [])
alias INSTALLUI_HANDLERA = int function(void* pvContext, uint iMessageType, const(PSTR) szMessage);
//DELEGATE ATTR: UnicodeAttribute : CustomAttributeSig([], [])
alias INSTALLUI_HANDLERW = int function(void* pvContext, uint iMessageType, const(PWSTR) szMessage);
alias PINSTALLUI_HANDLER_RECORD = int function(void* pvContext, uint iMessageType, MSIHANDLE hRecord);
alias PPATCH_PROGRESS_CALLBACK = BOOL function(void* CallbackContext, uint CurrentPosition, uint MaximumPosition);
alias PPATCH_SYMLOAD_CALLBACK = BOOL function(uint WhichFile, const(PSTR) SymbolFileName, uint SymType, 
                                              uint SymbolFileCheckSum, uint SymbolFileTimeDate, 
                                              uint ImageFileCheckSum, uint ImageFileTimeDate, void* CallbackContext);

// Structs


@RAIIFree!MsiCloseHandle
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct MSIHANDLE
{
    uint Value;
}

struct PMSIHANDLE
{
    MSIHANDLE m_h;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msi/ns-msi-msipatchsequenceinfoa
struct MSIPATCHSEQUENCEINFOA
{
    const(PSTR)      szPatchData;
    MSIPATCHDATATYPE ePatchDataType;
    uint             dwOrder;
    uint             uStatus;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msi/ns-msi-msipatchsequenceinfow
struct MSIPATCHSEQUENCEINFOW
{
    const(PWSTR)     szPatchData;
    MSIPATCHDATATYPE ePatchDataType;
    uint             dwOrder;
    uint             uStatus;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msi/ns-msi-msifilehashinfo
struct MSIFILEHASHINFO
{
    uint    dwFileHashInfoSize;
    uint[4] dwData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsxs/ns-winsxs-assembly_info
struct ASSEMBLY_INFO
{
    uint  cbAssemblyInfo;
    uint  dwAssemblyFlags;
    ulong uliAssemblySizeInKB;
    PWSTR pszCurrentAssemblyPathBuf;
    uint  cchBuf;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsxs/ns-winsxs-fusion_install_reference
struct FUSION_INSTALL_REFERENCE
{
    uint         cbSize;
    uint         dwFlags;
    GUID         guidScheme;
    const(PWSTR) szIdentifier;
    const(PWSTR) szNonCannonicalData;
}

struct PROTECTED_FILE_DATA
{
    wchar[260] FileName;
    uint       FileNumber;
}

struct PM_APPTASKTYPE
{
    GUID         ProductID;
    PM_TASK_TYPE TaskType;
}

struct PM_EXTENSIONCONSUMER
{
    GUID ConsumerPID;
    BSTR ExtensionID;
}

struct PM_BSATASKID
{
    GUID ProductID;
    BSTR TaskID;
}

struct PM_BWTASKID
{
    GUID ProductID;
    BSTR TaskID;
}

struct PM_ENUM_FILTER
{
    int FilterType;
    union FilterParameter
    {
        int                  Dummy;
        PM_APP_GENRE         Genre;
        PM_APPLICATION_HUBTYPE AppHubType;
        PM_TILE_HUBTYPE      HubType;
        PM_TASK_TYPE         Tasktype;
        GUID                 TaskProductID;
        GUID                 TileProductID;
        PM_APPTASKTYPE       AppTaskType;
        PM_EXTENSIONCONSUMER Consumer;
        PM_BSATASKID         BSATask;
        GUID                 BSAProductID;
        PM_BWTASKID          BWTask;
        BSTR                 ProtocolName;
        BSTR                 FileType;
        BSTR                 ContentType;
        GUID                 AppSupportedFileExtPID;
        BSTR                 ShareTargetFileType;
    }
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct PM_STARTAPPBLOB
{
    uint                 cbSize;
    GUID                 ProductID;
    BSTR                 AppTitle;
    BSTR                 IconPath;
    BOOL                 IsUninstallable;
    PM_APPLICATION_INSTALL_TYPE AppInstallType;
    GUID                 InstanceID;
    PM_APPLICATION_STATE State;
    BOOL                 IsModern;
    BOOL                 IsModernLightUp;
    ushort               LightUpSupportMask;
}

struct PM_INVOCATIONINFO
{
    BSTR URIBaseOrAUMID;
    BSTR URIFragmentOrArgs;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct PM_STARTTILEBLOB
{
    uint               cbSize;
    GUID               ProductID;
    BSTR               TileID;
    TILE_TEMPLATE_TYPE TemplateType;
    uint[32]           HubPosition;
    uint               HubVisibilityBitmask;
    BOOL               IsDefault;
    PM_STARTTILE_TYPE  TileType;
    ubyte*             pbPropBlob;
    uint               cbPropBlob;
    BOOL               IsRestoring;
    BOOL               IsModern;
    PM_INVOCATIONINFO  InvocationInfo;
}

struct PM_INSTALLINFO
{
    GUID   ProductID;
    BSTR   PackagePath;
    GUID   InstanceID;
    ubyte* pbLicense;
    uint   cbLicense;
    BOOL   IsUninstallDisabled;
    uint   DeploymentOptions;
    GUID   OfferID;
    BSTR   MarketplaceAppVersion;
}

struct PM_UPDATEINFO_LEGACY
{
    GUID   ProductID;
    BSTR   PackagePath;
    GUID   InstanceID;
    ubyte* pbLicense;
    uint   cbLicense;
    BSTR   MarketplaceAppVersion;
}

struct PM_UPDATEINFO
{
    GUID   ProductID;
    BSTR   PackagePath;
    GUID   InstanceID;
    ubyte* pbLicense;
    uint   cbLicense;
    BSTR   MarketplaceAppVersion;
    uint   DeploymentOptions;
}

struct PATCH_IGNORE_RANGE
{
    uint OffsetInOldFile;
    uint LengthInBytes;
}

struct PATCH_RETAIN_RANGE
{
    uint OffsetInOldFile;
    uint LengthInBytes;
    uint OffsetInNewFile;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
struct PATCH_OLD_FILE_INFO_A
{
    uint                SizeOfThisStruct;
    const(PSTR)         OldFileName;
    uint                IgnoreRangeCount;
    PATCH_IGNORE_RANGE* IgnoreRangeArray;
    uint                RetainRangeCount;
    PATCH_RETAIN_RANGE* RetainRangeArray;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
struct PATCH_OLD_FILE_INFO_W
{
    uint                SizeOfThisStruct;
    const(PWSTR)        OldFileName;
    uint                IgnoreRangeCount;
    PATCH_IGNORE_RANGE* IgnoreRangeArray;
    uint                RetainRangeCount;
    PATCH_RETAIN_RANGE* RetainRangeArray;
}

struct PATCH_OLD_FILE_INFO_H
{
    uint                SizeOfThisStruct;
    HANDLE              OldFileHandle;
    uint                IgnoreRangeCount;
    PATCH_IGNORE_RANGE* IgnoreRangeArray;
    uint                RetainRangeCount;
    PATCH_RETAIN_RANGE* RetainRangeArray;
}

struct PATCH_OLD_FILE_INFO
{
    uint                SizeOfThisStruct;
    union
    {
        const(PSTR)  OldFileNameA;
        const(PWSTR) OldFileNameW;
        HANDLE       OldFileHandle;
    }
    uint                IgnoreRangeCount;
    PATCH_IGNORE_RANGE* IgnoreRangeArray;
    uint                RetainRangeCount;
    PATCH_RETAIN_RANGE* RetainRangeArray;
}

struct PATCH_INTERLEAVE_MAP
{
    uint CountRanges;
    struct
    {
        uint OldOffset;
        uint OldLength;
        uint NewLength;
    }
}

struct PATCH_OPTION_DATA
{
    uint         SizeOfThisStruct;
    uint         SymbolOptionFlags;
    const(PSTR)  NewFileSymbolPath;
    const(PSTR)* OldFileSymbolPathArray;
    uint         ExtendedOptionFlags;
    PPATCH_SYMLOAD_CALLBACK SymLoadCallback;
    void*        SymLoadContext;
    PATCH_INTERLEAVE_MAP** InterleaveMapArray;
    uint         MaxLzxWindowSize;
}

struct DELTA_INPUT
{
    union
    {
        const(void)* lpcStart;
        void*        lpStart;
    }
    size_t uSize;
    BOOL   Editable;
}

struct DELTA_OUTPUT
{
    void*  lpStart;
    size_t uSize;
}

struct DELTA_HASH
{
    uint      HashSize;
    ubyte[32] HashValue;
}

struct DELTA_HEADER_INFO
{
    long       FileTypeSet;
    long       FileType;
    long       Flags;
    size_t     TargetSize;
    FILETIME   TargetFileTime;
    ALG_ID     TargetHashAlgId;
    DELTA_HASH TargetHash;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-activation_context_query_index
struct ACTIVATION_CONTEXT_QUERY_INDEX
{
    uint ulAssemblyIndex;
    uint ulFileIndexInAssembly;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-assembly_file_detailed_information
struct ASSEMBLY_FILE_DETAILED_INFORMATION
{
    uint         ulFlags;
    uint         ulFilenameLength;
    uint         ulPathLength;
    const(PWSTR) lpFileName;
    const(PWSTR) lpFilePath;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-activation_context_assembly_detailed_information
struct ACTIVATION_CONTEXT_ASSEMBLY_DETAILED_INFORMATION
{
    uint         ulFlags;
    uint         ulEncodedAssemblyIdentityLength;
    uint         ulManifestPathType;
    uint         ulManifestPathLength;
    long         liManifestLastWriteTime;
    uint         ulPolicyPathType;
    uint         ulPolicyPathLength;
    long         liPolicyLastWriteTime;
    uint         ulMetadataSatelliteRosterIndex;
    uint         ulManifestVersionMajor;
    uint         ulManifestVersionMinor;
    uint         ulPolicyVersionMajor;
    uint         ulPolicyVersionMinor;
    uint         ulAssemblyDirectoryNameLength;
    const(PWSTR) lpAssemblyEncodedAssemblyIdentity;
    const(PWSTR) lpAssemblyManifestPath;
    const(PWSTR) lpAssemblyPolicyPath;
    const(PWSTR) lpAssemblyDirectoryName;
    uint         ulFileCount;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-activation_context_run_level_information
struct ACTIVATION_CONTEXT_RUN_LEVEL_INFORMATION
{
    uint ulFlags;
    ACTCTX_REQUESTED_RUN_LEVEL RunLevel;
    uint UiAccess;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-compatibility_context_element
struct COMPATIBILITY_CONTEXT_ELEMENT
{
    GUID  Id;
    ACTCTX_COMPATIBILITY_ELEMENT_TYPE Type;
    ulong MaxVersionTested;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-activation_context_compatibility_information
struct ACTIVATION_CONTEXT_COMPATIBILITY_INFORMATION
{
    uint ElementCount;
    COMPATIBILITY_CONTEXT_ELEMENT[1] Elements;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-activation_context_detailed_information
struct ACTIVATION_CONTEXT_DETAILED_INFORMATION
{
    uint         dwFlags;
    uint         ulFormatVersion;
    uint         ulAssemblyCount;
    uint         ulRootManifestPathType;
    uint         ulRootManifestPathChars;
    uint         ulRootConfigurationPathType;
    uint         ulRootConfigurationPathChars;
    uint         ulAppDirPathType;
    uint         ulAppDirPathChars;
    const(PWSTR) lpRootManifestPath;
    const(PWSTR) lpRootConfigurationPath;
    const(PWSTR) lpAppDirPath;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/ns-winbase-actctxa
struct ACTCTXA
{
    uint        cbSize;
    uint        dwFlags;
    const(PSTR) lpSource;
    ushort      wProcessorArchitecture;
    ushort      wLangId;
    const(PSTR) lpAssemblyDirectory;
    const(PSTR) lpResourceName;
    const(PSTR) lpApplicationName;
    HMODULE     hModule;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/ns-winbase-actctxw
struct ACTCTXW
{
    uint         cbSize;
    uint         dwFlags;
    const(PWSTR) lpSource;
    ushort       wProcessorArchitecture;
    ushort       wLangId;
    const(PWSTR) lpAssemblyDirectory;
    const(PWSTR) lpResourceName;
    const(PWSTR) lpApplicationName;
    HMODULE      hModule;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/ns-winbase-actctx_section_keyed_data
struct ACTCTX_SECTION_KEYED_DATA
{
    uint   cbSize;
    uint   ulDataFormatVersion;
    void*  lpData;
    uint   ulLength;
    void*  lpSectionGlobalData;
    uint   ulSectionGlobalDataLength;
    void*  lpSectionBase;
    uint   ulSectionTotalLength;
    HANDLE hActCtx;
    uint   ulAssemblyRosterIndex;
    uint   ulFlags;
    ACTCTX_SECTION_KEYED_DATA_ASSEMBLY_METADATA AssemblyMetadata;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiCloseHandle(MSIHANDLE hAny);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiCloseAllHandles();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
INSTALLUILEVEL MsiSetInternalUI(INSTALLUILEVEL dwUILevel, HWND* phWnd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
INSTALLUI_HANDLERA MsiSetExternalUIA(INSTALLUI_HANDLERA puiHandler, uint dwMessageFilter, void* pvContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
INSTALLUI_HANDLERW MsiSetExternalUIW(INSTALLUI_HANDLERW puiHandler, uint dwMessageFilter, void* pvContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiSetExternalUIRecord(PINSTALLUI_HANDLER_RECORD puiHandler, uint dwMessageFilter, void* pvContext, 
                            PINSTALLUI_HANDLER_RECORD ppuiPrevHandler);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiEnableLogA(/*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(INSTALLLOGMODE))], [])*/uint dwLogMode, 
                   const(PSTR) szLogFile, uint dwLogAttributes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiEnableLogW(/*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(INSTALLLOGMODE))], [])*/uint dwLogMode, 
                   const(PWSTR) szLogFile, uint dwLogAttributes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
INSTALLSTATE MsiQueryProductStateA(const(PSTR) szProduct);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
INSTALLSTATE MsiQueryProductStateW(const(PWSTR) szProduct);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiGetProductInfoA(const(PSTR) szProduct, const(PSTR) szAttribute, PSTR lpValueBuf, uint* pcchValueBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiGetProductInfoW(const(PWSTR) szProduct, const(PWSTR) szAttribute, PWSTR lpValueBuf, uint* pcchValueBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiGetProductInfoExA(const(PSTR) szProductCode, const(PSTR) szUserSid, MSIINSTALLCONTEXT dwContext, 
                          const(PSTR) szProperty, PSTR szValue, uint* pcchValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiGetProductInfoExW(const(PWSTR) szProductCode, const(PWSTR) szUserSid, MSIINSTALLCONTEXT dwContext, 
                          const(PWSTR) szProperty, PWSTR szValue, uint* pcchValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiInstallProductA(const(PSTR) szPackagePath, const(PSTR) szCommandLine);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiInstallProductW(const(PWSTR) szPackagePath, const(PWSTR) szCommandLine);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiConfigureProductA(const(PSTR) szProduct, INSTALLLEVEL iInstallLevel, INSTALLSTATE eInstallState);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiConfigureProductW(const(PWSTR) szProduct, INSTALLLEVEL iInstallLevel, INSTALLSTATE eInstallState);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiConfigureProductExA(const(PSTR) szProduct, INSTALLLEVEL iInstallLevel, INSTALLSTATE eInstallState, 
                            const(PSTR) szCommandLine);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiConfigureProductExW(const(PWSTR) szProduct, INSTALLLEVEL iInstallLevel, INSTALLSTATE eInstallState, 
                            const(PWSTR) szCommandLine);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiReinstallProductA(const(PSTR) szProduct, 
                          /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(REINSTALLMODE))], [])*/uint szReinstallMode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiReinstallProductW(const(PWSTR) szProduct, 
                          /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(REINSTALLMODE))], [])*/uint szReinstallMode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiAdvertiseProductExA(const(PSTR) szPackagePath, const(PSTR) szScriptfilePath, const(PSTR) szTransforms, 
                            ushort lgidLanguage, uint dwPlatform, uint dwOptions);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiAdvertiseProductExW(const(PWSTR) szPackagePath, const(PWSTR) szScriptfilePath, const(PWSTR) szTransforms, 
                            ushort lgidLanguage, uint dwPlatform, uint dwOptions);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiAdvertiseProductA(const(PSTR) szPackagePath, const(PSTR) szScriptfilePath, const(PSTR) szTransforms, 
                          ushort lgidLanguage);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiAdvertiseProductW(const(PWSTR) szPackagePath, const(PWSTR) szScriptfilePath, const(PWSTR) szTransforms, 
                          ushort lgidLanguage);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiProcessAdvertiseScriptA(const(PSTR) szScriptFile, const(PSTR) szIconFolder, HKEY hRegData, BOOL fShortcuts, 
                                BOOL fRemoveItems);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiProcessAdvertiseScriptW(const(PWSTR) szScriptFile, const(PWSTR) szIconFolder, HKEY hRegData, 
                                BOOL fShortcuts, BOOL fRemoveItems);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiAdvertiseScriptA(const(PSTR) szScriptFile, uint dwFlags, HKEY* phRegData, BOOL fRemoveItems);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiAdvertiseScriptW(const(PWSTR) szScriptFile, uint dwFlags, HKEY* phRegData, BOOL fRemoveItems);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiGetProductInfoFromScriptA(const(PSTR) szScriptFile, PSTR lpProductBuf39, ushort* plgidLanguage, 
                                  uint* pdwVersion, PSTR lpNameBuf, uint* pcchNameBuf, PSTR lpPackageBuf, 
                                  uint* pcchPackageBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiGetProductInfoFromScriptW(const(PWSTR) szScriptFile, PWSTR lpProductBuf39, ushort* plgidLanguage, 
                                  uint* pdwVersion, PWSTR lpNameBuf, uint* pcchNameBuf, PWSTR lpPackageBuf, 
                                  uint* pcchPackageBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiGetProductCodeA(const(PSTR) szComponent, PSTR lpBuf39);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiGetProductCodeW(const(PWSTR) szComponent, PWSTR lpBuf39);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
USERINFOSTATE MsiGetUserInfoA(const(PSTR) szProduct, PSTR lpUserNameBuf, uint* pcchUserNameBuf, PSTR lpOrgNameBuf, 
                              uint* pcchOrgNameBuf, PSTR lpSerialBuf, uint* pcchSerialBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
USERINFOSTATE MsiGetUserInfoW(const(PWSTR) szProduct, PWSTR lpUserNameBuf, uint* pcchUserNameBuf, 
                              PWSTR lpOrgNameBuf, uint* pcchOrgNameBuf, PWSTR lpSerialBuf, uint* pcchSerialBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiCollectUserInfoA(const(PSTR) szProduct);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiCollectUserInfoW(const(PWSTR) szProduct);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiApplyPatchA(const(PSTR) szPatchPackage, const(PSTR) szInstallPackage, INSTALLTYPE eInstallType, 
                    const(PSTR) szCommandLine);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiApplyPatchW(const(PWSTR) szPatchPackage, const(PWSTR) szInstallPackage, INSTALLTYPE eInstallType, 
                    const(PWSTR) szCommandLine);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiGetPatchInfoA(const(PSTR) szPatch, const(PSTR) szAttribute, PSTR lpValueBuf, uint* pcchValueBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiGetPatchInfoW(const(PWSTR) szPatch, const(PWSTR) szAttribute, PWSTR lpValueBuf, uint* pcchValueBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiEnumPatchesA(const(PSTR) szProduct, uint iPatchIndex, PSTR lpPatchBuf, PSTR lpTransformsBuf, 
                     uint* pcchTransformsBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiEnumPatchesW(const(PWSTR) szProduct, uint iPatchIndex, PWSTR lpPatchBuf, PWSTR lpTransformsBuf, 
                     uint* pcchTransformsBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiRemovePatchesA(const(PSTR) szPatchList, const(PSTR) szProductCode, INSTALLTYPE eUninstallType, 
                       const(PSTR) szPropertyList);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiRemovePatchesW(const(PWSTR) szPatchList, const(PWSTR) szProductCode, INSTALLTYPE eUninstallType, 
                       const(PWSTR) szPropertyList);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("msi.dll")
uint MsiExtractPatchXMLDataA(const(PSTR) szPatchPath, 
                             /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwReserved, 
                             PSTR szXMLData, uint* pcchXMLData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("msi.dll")
uint MsiExtractPatchXMLDataW(const(PWSTR) szPatchPath, 
                             /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwReserved, 
                             PWSTR szXMLData, uint* pcchXMLData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiGetPatchInfoExA(const(PSTR) szPatchCode, const(PSTR) szProductCode, const(PSTR) szUserSid, 
                        MSIINSTALLCONTEXT dwContext, const(PSTR) szProperty, PSTR lpValue, uint* pcchValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiGetPatchInfoExW(const(PWSTR) szPatchCode, const(PWSTR) szProductCode, const(PWSTR) szUserSid, 
                        MSIINSTALLCONTEXT dwContext, const(PWSTR) szProperty, PWSTR lpValue, uint* pcchValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiApplyMultiplePatchesA(const(PSTR) szPatchPackages, const(PSTR) szProductCode, const(PSTR) szPropertiesList);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiApplyMultiplePatchesW(const(PWSTR) szPatchPackages, const(PWSTR) szProductCode, 
                              const(PWSTR) szPropertiesList);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiDeterminePatchSequenceA(const(PSTR) szProductCode, const(PSTR) szUserSid, MSIINSTALLCONTEXT dwContext, 
                                uint cPatchInfo, MSIPATCHSEQUENCEINFOA* pPatchInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiDeterminePatchSequenceW(const(PWSTR) szProductCode, const(PWSTR) szUserSid, MSIINSTALLCONTEXT dwContext, 
                                uint cPatchInfo, MSIPATCHSEQUENCEINFOW* pPatchInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiDetermineApplicablePatchesA(const(PSTR) szProductPackagePath, uint cPatchInfo, 
                                    MSIPATCHSEQUENCEINFOA* pPatchInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiDetermineApplicablePatchesW(const(PWSTR) szProductPackagePath, uint cPatchInfo, 
                                    MSIPATCHSEQUENCEINFOW* pPatchInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiEnumPatchesExA(const(PSTR) szProductCode, const(PSTR) szUserSid, uint dwContext, uint dwFilter, 
                       uint dwIndex, PSTR szPatchCode, PSTR szTargetProductCode, 
                       MSIINSTALLCONTEXT* pdwTargetProductContext, PSTR szTargetUserSid, uint* pcchTargetUserSid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiEnumPatchesExW(const(PWSTR) szProductCode, const(PWSTR) szUserSid, uint dwContext, uint dwFilter, 
                       uint dwIndex, PWSTR szPatchCode, PWSTR szTargetProductCode, 
                       MSIINSTALLCONTEXT* pdwTargetProductContext, PWSTR szTargetUserSid, uint* pcchTargetUserSid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
INSTALLSTATE MsiQueryFeatureStateA(const(PSTR) szProduct, const(PSTR) szFeature);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
INSTALLSTATE MsiQueryFeatureStateW(const(PWSTR) szProduct, const(PWSTR) szFeature);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiQueryFeatureStateExA(const(PSTR) szProductCode, const(PSTR) szUserSid, MSIINSTALLCONTEXT dwContext, 
                             const(PSTR) szFeature, INSTALLSTATE* pdwState);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiQueryFeatureStateExW(const(PWSTR) szProductCode, const(PWSTR) szUserSid, MSIINSTALLCONTEXT dwContext, 
                             const(PWSTR) szFeature, INSTALLSTATE* pdwState);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
INSTALLSTATE MsiUseFeatureA(const(PSTR) szProduct, const(PSTR) szFeature);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
INSTALLSTATE MsiUseFeatureW(const(PWSTR) szProduct, const(PWSTR) szFeature);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
INSTALLSTATE MsiUseFeatureExA(const(PSTR) szProduct, const(PSTR) szFeature, uint dwInstallMode, 
                              /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
INSTALLSTATE MsiUseFeatureExW(const(PWSTR) szProduct, const(PWSTR) szFeature, uint dwInstallMode, 
                              /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiGetFeatureUsageA(const(PSTR) szProduct, const(PSTR) szFeature, uint* pdwUseCount, ushort* pwDateUsed);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiGetFeatureUsageW(const(PWSTR) szProduct, const(PWSTR) szFeature, uint* pdwUseCount, ushort* pwDateUsed);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiConfigureFeatureA(const(PSTR) szProduct, const(PSTR) szFeature, INSTALLSTATE eInstallState);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiConfigureFeatureW(const(PWSTR) szProduct, const(PWSTR) szFeature, INSTALLSTATE eInstallState);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiReinstallFeatureA(const(PSTR) szProduct, const(PSTR) szFeature, 
                          /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(REINSTALLMODE))], [])*/uint dwReinstallMode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiReinstallFeatureW(const(PWSTR) szProduct, const(PWSTR) szFeature, 
                          /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(REINSTALLMODE))], [])*/uint dwReinstallMode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiProvideComponentA(const(PSTR) szProduct, const(PSTR) szFeature, const(PSTR) szComponent, 
                          /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(INSTALLMODE))], [])*/uint dwInstallMode, 
                          PSTR lpPathBuf, uint* pcchPathBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiProvideComponentW(const(PWSTR) szProduct, const(PWSTR) szFeature, const(PWSTR) szComponent, 
                          /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(INSTALLMODE))], [])*/uint dwInstallMode, 
                          PWSTR lpPathBuf, uint* pcchPathBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiProvideQualifiedComponentA(const(PSTR) szCategory, const(PSTR) szQualifier, 
                                   /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(INSTALLMODE))], [])*/uint dwInstallMode, 
                                   PSTR lpPathBuf, uint* pcchPathBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiProvideQualifiedComponentW(const(PWSTR) szCategory, const(PWSTR) szQualifier, 
                                   /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(INSTALLMODE))], [])*/uint dwInstallMode, 
                                   PWSTR lpPathBuf, uint* pcchPathBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiProvideQualifiedComponentExA(const(PSTR) szCategory, const(PSTR) szQualifier, 
                                     /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(INSTALLMODE))], [])*/uint dwInstallMode, 
                                     const(PSTR) szProduct, 
                                     /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwUnused1, 
                                     /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwUnused2, 
                                     PSTR lpPathBuf, uint* pcchPathBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiProvideQualifiedComponentExW(const(PWSTR) szCategory, const(PWSTR) szQualifier, 
                                     /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(INSTALLMODE))], [])*/uint dwInstallMode, 
                                     const(PWSTR) szProduct, 
                                     /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwUnused1, 
                                     /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwUnused2, 
                                     PWSTR lpPathBuf, uint* pcchPathBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
INSTALLSTATE MsiGetComponentPathA(const(PSTR) szProduct, const(PSTR) szComponent, PSTR lpPathBuf, uint* pcchBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
INSTALLSTATE MsiGetComponentPathW(const(PWSTR) szProduct, const(PWSTR) szComponent, PWSTR lpPathBuf, uint* pcchBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
INSTALLSTATE MsiGetComponentPathExA(const(PSTR) szProductCode, const(PSTR) szComponentCode, const(PSTR) szUserSid, 
                                    MSIINSTALLCONTEXT dwContext, PSTR lpOutPathBuffer, uint* pcchOutPathBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
INSTALLSTATE MsiGetComponentPathExW(const(PWSTR) szProductCode, const(PWSTR) szComponentCode, 
                                    const(PWSTR) szUserSid, MSIINSTALLCONTEXT dwContext, PWSTR lpOutPathBuffer, 
                                    uint* pcchOutPathBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiProvideAssemblyA(const(PSTR) szAssemblyName, const(PSTR) szAppContext, 
                         /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(INSTALLMODE))], [])*/uint dwInstallMode, 
                         MSIASSEMBLYINFO dwAssemblyInfo, PSTR lpPathBuf, uint* pcchPathBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiProvideAssemblyW(const(PWSTR) szAssemblyName, const(PWSTR) szAppContext, 
                         /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(INSTALLMODE))], [])*/uint dwInstallMode, 
                         MSIASSEMBLYINFO dwAssemblyInfo, PWSTR lpPathBuf, uint* pcchPathBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiQueryComponentStateA(const(PSTR) szProductCode, const(PSTR) szUserSid, MSIINSTALLCONTEXT dwContext, 
                             const(PSTR) szComponentCode, INSTALLSTATE* pdwState);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiQueryComponentStateW(const(PWSTR) szProductCode, const(PWSTR) szUserSid, MSIINSTALLCONTEXT dwContext, 
                             const(PWSTR) szComponentCode, INSTALLSTATE* pdwState);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiEnumProductsA(uint iProductIndex, PSTR lpProductBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiEnumProductsW(uint iProductIndex, PWSTR lpProductBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiEnumProductsExA(const(PSTR) szProductCode, const(PSTR) szUserSid, uint dwContext, uint dwIndex, 
                        PSTR szInstalledProductCode, MSIINSTALLCONTEXT* pdwInstalledContext, PSTR szSid, 
                        uint* pcchSid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiEnumProductsExW(const(PWSTR) szProductCode, const(PWSTR) szUserSid, uint dwContext, uint dwIndex, 
                        PWSTR szInstalledProductCode, MSIINSTALLCONTEXT* pdwInstalledContext, PWSTR szSid, 
                        uint* pcchSid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiEnumRelatedProductsA(const(PSTR) lpUpgradeCode, 
                             /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwReserved, 
                             uint iProductIndex, PSTR lpProductBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiEnumRelatedProductsW(const(PWSTR) lpUpgradeCode, 
                             /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwReserved, 
                             uint iProductIndex, PWSTR lpProductBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiEnumFeaturesA(const(PSTR) szProduct, uint iFeatureIndex, PSTR lpFeatureBuf, PSTR lpParentBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiEnumFeaturesW(const(PWSTR) szProduct, uint iFeatureIndex, PWSTR lpFeatureBuf, PWSTR lpParentBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiEnumComponentsA(uint iComponentIndex, PSTR lpComponentBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiEnumComponentsW(uint iComponentIndex, PWSTR lpComponentBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiEnumComponentsExA(const(PSTR) szUserSid, uint dwContext, uint dwIndex, PSTR szInstalledComponentCode, 
                          MSIINSTALLCONTEXT* pdwInstalledContext, PSTR szSid, uint* pcchSid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiEnumComponentsExW(const(PWSTR) szUserSid, uint dwContext, uint dwIndex, PWSTR szInstalledComponentCode, 
                          MSIINSTALLCONTEXT* pdwInstalledContext, PWSTR szSid, uint* pcchSid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiEnumClientsA(const(PSTR) szComponent, uint iProductIndex, PSTR lpProductBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiEnumClientsW(const(PWSTR) szComponent, uint iProductIndex, PWSTR lpProductBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiEnumClientsExA(const(PSTR) szComponent, const(PSTR) szUserSid, 
                       /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(MSIINSTALLCONTEXT))], [])*/uint dwContext, 
                       uint dwProductIndex, PSTR szProductBuf, MSIINSTALLCONTEXT* pdwInstalledContext, PSTR szSid, 
                       uint* pcchSid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiEnumClientsExW(const(PWSTR) szComponent, const(PWSTR) szUserSid, 
                       /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(MSIINSTALLCONTEXT))], [])*/uint dwContext, 
                       uint dwProductIndex, PWSTR szProductBuf, MSIINSTALLCONTEXT* pdwInstalledContext, PWSTR szSid, 
                       uint* pcchSid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiEnumComponentQualifiersA(const(PSTR) szComponent, uint iIndex, PSTR lpQualifierBuf, uint* pcchQualifierBuf, 
                                 PSTR lpApplicationDataBuf, uint* pcchApplicationDataBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiEnumComponentQualifiersW(const(PWSTR) szComponent, uint iIndex, PWSTR lpQualifierBuf, 
                                 uint* pcchQualifierBuf, PWSTR lpApplicationDataBuf, uint* pcchApplicationDataBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiOpenProductA(const(PSTR) szProduct, MSIHANDLE* hProduct);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiOpenProductW(const(PWSTR) szProduct, MSIHANDLE* hProduct);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiOpenPackageA(const(PSTR) szPackagePath, MSIHANDLE* hProduct);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiOpenPackageW(const(PWSTR) szPackagePath, MSIHANDLE* hProduct);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiOpenPackageExA(const(PSTR) szPackagePath, uint dwOptions, MSIHANDLE* hProduct);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiOpenPackageExW(const(PWSTR) szPackagePath, uint dwOptions, MSIHANDLE* hProduct);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiGetPatchFileListA(const(PSTR) szProductCode, const(PSTR) szPatchPackages, uint* pcFiles, 
                          MSIHANDLE** pphFileRecords);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiGetPatchFileListW(const(PWSTR) szProductCode, const(PWSTR) szPatchPackages, uint* pcFiles, 
                          MSIHANDLE** pphFileRecords);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiGetProductPropertyA(MSIHANDLE hProduct, const(PSTR) szProperty, PSTR lpValueBuf, uint* pcchValueBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiGetProductPropertyW(MSIHANDLE hProduct, const(PWSTR) szProperty, PWSTR lpValueBuf, uint* pcchValueBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiVerifyPackageA(const(PSTR) szPackagePath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiVerifyPackageW(const(PWSTR) szPackagePath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiGetFeatureInfoA(MSIHANDLE hProduct, const(PSTR) szFeature, uint* lpAttributes, PSTR lpTitleBuf, 
                        uint* pcchTitleBuf, PSTR lpHelpBuf, uint* pcchHelpBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiGetFeatureInfoW(MSIHANDLE hProduct, const(PWSTR) szFeature, uint* lpAttributes, PWSTR lpTitleBuf, 
                        uint* pcchTitleBuf, PWSTR lpHelpBuf, uint* pcchHelpBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiInstallMissingComponentA(const(PSTR) szProduct, const(PSTR) szComponent, INSTALLSTATE eInstallState);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiInstallMissingComponentW(const(PWSTR) szProduct, const(PWSTR) szComponent, INSTALLSTATE eInstallState);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiInstallMissingFileA(const(PSTR) szProduct, const(PSTR) szFile);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiInstallMissingFileW(const(PWSTR) szProduct, const(PWSTR) szFile);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
INSTALLSTATE MsiLocateComponentA(const(PSTR) szComponent, PSTR lpPathBuf, uint* pcchBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
INSTALLSTATE MsiLocateComponentW(const(PWSTR) szComponent, PWSTR lpPathBuf, uint* pcchBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiSourceListClearAllA(const(PSTR) szProduct, const(PSTR) szUserName, 
                            /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiSourceListClearAllW(const(PWSTR) szProduct, const(PWSTR) szUserName, 
                            /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiSourceListAddSourceA(const(PSTR) szProduct, const(PSTR) szUserName, 
                             /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwReserved, 
                             const(PSTR) szSource);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiSourceListAddSourceW(const(PWSTR) szProduct, const(PWSTR) szUserName, 
                             /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwReserved, 
                             const(PWSTR) szSource);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiSourceListForceResolutionA(const(PSTR) szProduct, const(PSTR) szUserName, 
                                   /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiSourceListForceResolutionW(const(PWSTR) szProduct, const(PWSTR) szUserName, 
                                   /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiSourceListAddSourceExA(const(PSTR) szProductCodeOrPatchCode, const(PSTR) szUserSid, 
                               MSIINSTALLCONTEXT dwContext, uint dwOptions, const(PSTR) szSource, uint dwIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiSourceListAddSourceExW(const(PWSTR) szProductCodeOrPatchCode, const(PWSTR) szUserSid, 
                               MSIINSTALLCONTEXT dwContext, uint dwOptions, const(PWSTR) szSource, uint dwIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiSourceListAddMediaDiskA(const(PSTR) szProductCodeOrPatchCode, const(PSTR) szUserSid, 
                                MSIINSTALLCONTEXT dwContext, uint dwOptions, uint dwDiskId, 
                                const(PSTR) szVolumeLabel, const(PSTR) szDiskPrompt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiSourceListAddMediaDiskW(const(PWSTR) szProductCodeOrPatchCode, const(PWSTR) szUserSid, 
                                MSIINSTALLCONTEXT dwContext, uint dwOptions, uint dwDiskId, 
                                const(PWSTR) szVolumeLabel, const(PWSTR) szDiskPrompt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiSourceListClearSourceA(const(PSTR) szProductCodeOrPatchCode, const(PSTR) szUserSid, 
                               MSIINSTALLCONTEXT dwContext, uint dwOptions, const(PSTR) szSource);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiSourceListClearSourceW(const(PWSTR) szProductCodeOrPatchCode, const(PWSTR) szUserSid, 
                               MSIINSTALLCONTEXT dwContext, uint dwOptions, const(PWSTR) szSource);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiSourceListClearMediaDiskA(const(PSTR) szProductCodeOrPatchCode, const(PSTR) szUserSid, 
                                  MSIINSTALLCONTEXT dwContext, uint dwOptions, uint dwDiskId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiSourceListClearMediaDiskW(const(PWSTR) szProductCodeOrPatchCode, const(PWSTR) szUserSid, 
                                  MSIINSTALLCONTEXT dwContext, uint dwOptions, uint dwDiskId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiSourceListClearAllExA(const(PSTR) szProductCodeOrPatchCode, const(PSTR) szUserSid, 
                              MSIINSTALLCONTEXT dwContext, uint dwOptions);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiSourceListClearAllExW(const(PWSTR) szProductCodeOrPatchCode, const(PWSTR) szUserSid, 
                              MSIINSTALLCONTEXT dwContext, uint dwOptions);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiSourceListForceResolutionExA(const(PSTR) szProductCodeOrPatchCode, const(PSTR) szUserSid, 
                                     MSIINSTALLCONTEXT dwContext, uint dwOptions);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiSourceListForceResolutionExW(const(PWSTR) szProductCodeOrPatchCode, const(PWSTR) szUserSid, 
                                     MSIINSTALLCONTEXT dwContext, uint dwOptions);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiSourceListSetInfoA(const(PSTR) szProductCodeOrPatchCode, const(PSTR) szUserSid, 
                           MSIINSTALLCONTEXT dwContext, uint dwOptions, const(PSTR) szProperty, const(PSTR) szValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiSourceListSetInfoW(const(PWSTR) szProductCodeOrPatchCode, const(PWSTR) szUserSid, 
                           MSIINSTALLCONTEXT dwContext, uint dwOptions, const(PWSTR) szProperty, 
                           const(PWSTR) szValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiSourceListGetInfoA(const(PSTR) szProductCodeOrPatchCode, const(PSTR) szUserSid, 
                           MSIINSTALLCONTEXT dwContext, uint dwOptions, const(PSTR) szProperty, PSTR szValue, 
                           uint* pcchValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiSourceListGetInfoW(const(PWSTR) szProductCodeOrPatchCode, const(PWSTR) szUserSid, 
                           MSIINSTALLCONTEXT dwContext, uint dwOptions, const(PWSTR) szProperty, PWSTR szValue, 
                           uint* pcchValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiSourceListEnumSourcesA(const(PSTR) szProductCodeOrPatchCode, const(PSTR) szUserSid, 
                               MSIINSTALLCONTEXT dwContext, uint dwOptions, uint dwIndex, PSTR szSource, 
                               uint* pcchSource);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiSourceListEnumSourcesW(const(PWSTR) szProductCodeOrPatchCode, const(PWSTR) szUserSid, 
                               MSIINSTALLCONTEXT dwContext, uint dwOptions, uint dwIndex, PWSTR szSource, 
                               uint* pcchSource);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiSourceListEnumMediaDisksA(const(PSTR) szProductCodeOrPatchCode, const(PSTR) szUserSid, 
                                  MSIINSTALLCONTEXT dwContext, uint dwOptions, uint dwIndex, uint* pdwDiskId, 
                                  PSTR szVolumeLabel, uint* pcchVolumeLabel, PSTR szDiskPrompt, uint* pcchDiskPrompt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiSourceListEnumMediaDisksW(const(PWSTR) szProductCodeOrPatchCode, const(PWSTR) szUserSid, 
                                  MSIINSTALLCONTEXT dwContext, uint dwOptions, uint dwIndex, uint* pdwDiskId, 
                                  PWSTR szVolumeLabel, uint* pcchVolumeLabel, PWSTR szDiskPrompt, 
                                  uint* pcchDiskPrompt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiGetFileVersionA(const(PSTR) szFilePath, PSTR lpVersionBuf, uint* pcchVersionBuf, PSTR lpLangBuf, 
                        uint* pcchLangBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiGetFileVersionW(const(PWSTR) szFilePath, PWSTR lpVersionBuf, uint* pcchVersionBuf, PWSTR lpLangBuf, 
                        uint* pcchLangBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiGetFileHashA(const(PSTR) szFilePath, uint dwOptions, MSIFILEHASHINFO* pHash);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiGetFileHashW(const(PWSTR) szFilePath, uint dwOptions, MSIFILEHASHINFO* pHash);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
HRESULT MsiGetFileSignatureInformationA(const(PSTR) szSignedObjectPath, uint dwFlags, 
                                        CERT_CONTEXT** ppcCertContext, 
                                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* pbHashData, 
                                        uint* pcbHashData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
HRESULT MsiGetFileSignatureInformationW(const(PWSTR) szSignedObjectPath, uint dwFlags, 
                                        CERT_CONTEXT** ppcCertContext, 
                                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* pbHashData, 
                                        uint* pcbHashData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiGetShortcutTargetA(const(PSTR) szShortcutPath, PSTR szProductCode, PSTR szFeatureId, PSTR szComponentCode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiGetShortcutTargetW(const(PWSTR) szShortcutPath, PWSTR szProductCode, PWSTR szFeatureId, 
                           PWSTR szComponentCode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiIsProductElevatedA(const(PSTR) szProduct, BOOL* pfElevated);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiIsProductElevatedW(const(PWSTR) szProduct, BOOL* pfElevated);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiNotifySidChangeA(const(PSTR) pOldSid, const(PSTR) pNewSid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiNotifySidChangeW(const(PWSTR) pOldSid, const(PWSTR) pNewSid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiBeginTransactionA(const(PSTR) szName, uint dwTransactionAttributes, MSIHANDLE* phTransactionHandle, 
                          HANDLE* phChangeOfOwnerEvent);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiBeginTransactionW(const(PWSTR) szName, uint dwTransactionAttributes, MSIHANDLE* phTransactionHandle, 
                          HANDLE* phChangeOfOwnerEvent);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiEndTransaction(MSITRANSACTIONSTATE dwTransactionState);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiJoinTransaction(MSIHANDLE hTransactionHandle, uint dwTransactionAttributes, HANDLE* phChangeOfOwnerEvent);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiDatabaseOpenViewA(MSIHANDLE hDatabase, const(PSTR) szQuery, MSIHANDLE* phView);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiDatabaseOpenViewW(MSIHANDLE hDatabase, const(PWSTR) szQuery, MSIHANDLE* phView);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
MSIDBERROR MsiViewGetErrorA(MSIHANDLE hView, PSTR szColumnNameBuffer, uint* pcchBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
MSIDBERROR MsiViewGetErrorW(MSIHANDLE hView, PWSTR szColumnNameBuffer, uint* pcchBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiViewExecute(MSIHANDLE hView, MSIHANDLE hRecord);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiViewFetch(MSIHANDLE hView, MSIHANDLE* phRecord);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiViewModify(MSIHANDLE hView, MSIMODIFY eModifyMode, MSIHANDLE hRecord);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiViewGetColumnInfo(MSIHANDLE hView, MSICOLINFO eColumnInfo, MSIHANDLE* phRecord);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiViewClose(MSIHANDLE hView);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiDatabaseGetPrimaryKeysA(MSIHANDLE hDatabase, const(PSTR) szTableName, MSIHANDLE* phRecord);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiDatabaseGetPrimaryKeysW(MSIHANDLE hDatabase, const(PWSTR) szTableName, MSIHANDLE* phRecord);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
MSICONDITION MsiDatabaseIsTablePersistentA(MSIHANDLE hDatabase, const(PSTR) szTableName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
MSICONDITION MsiDatabaseIsTablePersistentW(MSIHANDLE hDatabase, const(PWSTR) szTableName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiGetSummaryInformationA(MSIHANDLE hDatabase, const(PSTR) szDatabasePath, uint uiUpdateCount, 
                               MSIHANDLE* phSummaryInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiGetSummaryInformationW(MSIHANDLE hDatabase, const(PWSTR) szDatabasePath, uint uiUpdateCount, 
                               MSIHANDLE* phSummaryInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiSummaryInfoGetPropertyCount(MSIHANDLE hSummaryInfo, uint* puiPropertyCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiSummaryInfoSetPropertyA(MSIHANDLE hSummaryInfo, uint uiProperty, uint uiDataType, int iValue, 
                                FILETIME* pftValue, const(PSTR) szValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiSummaryInfoSetPropertyW(MSIHANDLE hSummaryInfo, uint uiProperty, uint uiDataType, int iValue, 
                                FILETIME* pftValue, const(PWSTR) szValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiSummaryInfoGetPropertyA(MSIHANDLE hSummaryInfo, uint uiProperty, uint* puiDataType, int* piValue, 
                                FILETIME* pftValue, PSTR szValueBuf, uint* pcchValueBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiSummaryInfoGetPropertyW(MSIHANDLE hSummaryInfo, uint uiProperty, uint* puiDataType, int* piValue, 
                                FILETIME* pftValue, PWSTR szValueBuf, uint* pcchValueBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiSummaryInfoPersist(MSIHANDLE hSummaryInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiOpenDatabaseA(const(PSTR) szDatabasePath, const(PSTR) szPersist, MSIHANDLE* phDatabase);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiOpenDatabaseW(const(PWSTR) szDatabasePath, const(PWSTR) szPersist, MSIHANDLE* phDatabase);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiDatabaseImportA(MSIHANDLE hDatabase, const(PSTR) szFolderPath, const(PSTR) szFileName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiDatabaseImportW(MSIHANDLE hDatabase, const(PWSTR) szFolderPath, const(PWSTR) szFileName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiDatabaseExportA(MSIHANDLE hDatabase, const(PSTR) szTableName, const(PSTR) szFolderPath, 
                        const(PSTR) szFileName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiDatabaseExportW(MSIHANDLE hDatabase, const(PWSTR) szTableName, const(PWSTR) szFolderPath, 
                        const(PWSTR) szFileName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiDatabaseMergeA(MSIHANDLE hDatabase, MSIHANDLE hDatabaseMerge, const(PSTR) szTableName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiDatabaseMergeW(MSIHANDLE hDatabase, MSIHANDLE hDatabaseMerge, const(PWSTR) szTableName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiDatabaseGenerateTransformA(MSIHANDLE hDatabase, MSIHANDLE hDatabaseReference, const(PSTR) szTransformFile, 
                                   int iReserved1, int iReserved2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiDatabaseGenerateTransformW(MSIHANDLE hDatabase, MSIHANDLE hDatabaseReference, const(PWSTR) szTransformFile, 
                                   int iReserved1, int iReserved2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiDatabaseApplyTransformA(MSIHANDLE hDatabase, const(PSTR) szTransformFile, 
                                MSITRANSFORM_ERROR iErrorConditions);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiDatabaseApplyTransformW(MSIHANDLE hDatabase, const(PWSTR) szTransformFile, 
                                MSITRANSFORM_ERROR iErrorConditions);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiCreateTransformSummaryInfoA(MSIHANDLE hDatabase, MSIHANDLE hDatabaseReference, const(PSTR) szTransformFile, 
                                    MSITRANSFORM_ERROR iErrorConditions, MSITRANSFORM_VALIDATE iValidation);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiCreateTransformSummaryInfoW(MSIHANDLE hDatabase, MSIHANDLE hDatabaseReference, 
                                    const(PWSTR) szTransformFile, MSITRANSFORM_ERROR iErrorConditions, 
                                    MSITRANSFORM_VALIDATE iValidation);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiDatabaseCommit(MSIHANDLE hDatabase);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
MSIDBSTATE MsiGetDatabaseState(MSIHANDLE hDatabase);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
MSIHANDLE MsiCreateRecord(uint cParams);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
BOOL MsiRecordIsNull(MSIHANDLE hRecord, uint iField);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiRecordDataSize(MSIHANDLE hRecord, uint iField);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiRecordSetInteger(MSIHANDLE hRecord, uint iField, int iValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiRecordSetStringA(MSIHANDLE hRecord, uint iField, const(PSTR) szValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiRecordSetStringW(MSIHANDLE hRecord, uint iField, const(PWSTR) szValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
int MsiRecordGetInteger(MSIHANDLE hRecord, uint iField);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiRecordGetStringA(MSIHANDLE hRecord, uint iField, PSTR szValueBuf, uint* pcchValueBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiRecordGetStringW(MSIHANDLE hRecord, uint iField, PWSTR szValueBuf, uint* pcchValueBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiRecordGetFieldCount(MSIHANDLE hRecord);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiRecordSetStreamA(MSIHANDLE hRecord, uint iField, const(PSTR) szFilePath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiRecordSetStreamW(MSIHANDLE hRecord, uint iField, const(PWSTR) szFilePath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiRecordReadStream(MSIHANDLE hRecord, uint iField, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/PSTR szDataBuf, 
                         uint* pcbDataBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiRecordClearData(MSIHANDLE hRecord);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
MSIHANDLE MsiGetActiveDatabase(MSIHANDLE hInstall);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiSetPropertyA(MSIHANDLE hInstall, const(PSTR) szName, const(PSTR) szValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiSetPropertyW(MSIHANDLE hInstall, const(PWSTR) szName, const(PWSTR) szValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiGetPropertyA(MSIHANDLE hInstall, const(PSTR) szName, PSTR szValueBuf, uint* pcchValueBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiGetPropertyW(MSIHANDLE hInstall, const(PWSTR) szName, PWSTR szValueBuf, uint* pcchValueBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
ushort MsiGetLanguage(MSIHANDLE hInstall);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
BOOL MsiGetMode(MSIHANDLE hInstall, MSIRUNMODE eRunMode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiSetMode(MSIHANDLE hInstall, MSIRUNMODE eRunMode, BOOL fState);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiFormatRecordA(MSIHANDLE hInstall, MSIHANDLE hRecord, PSTR szResultBuf, uint* pcchResultBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiFormatRecordW(MSIHANDLE hInstall, MSIHANDLE hRecord, PWSTR szResultBuf, uint* pcchResultBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiDoActionA(MSIHANDLE hInstall, const(PSTR) szAction);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiDoActionW(MSIHANDLE hInstall, const(PWSTR) szAction);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiSequenceA(MSIHANDLE hInstall, const(PSTR) szTable, int iSequenceMode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiSequenceW(MSIHANDLE hInstall, const(PWSTR) szTable, int iSequenceMode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
int MsiProcessMessage(MSIHANDLE hInstall, INSTALLMESSAGE eMessageType, MSIHANDLE hRecord);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
MSICONDITION MsiEvaluateConditionA(MSIHANDLE hInstall, const(PSTR) szCondition);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
MSICONDITION MsiEvaluateConditionW(MSIHANDLE hInstall, const(PWSTR) szCondition);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiGetFeatureStateA(MSIHANDLE hInstall, const(PSTR) szFeature, INSTALLSTATE* piInstalled, 
                         INSTALLSTATE* piAction);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiGetFeatureStateW(MSIHANDLE hInstall, const(PWSTR) szFeature, INSTALLSTATE* piInstalled, 
                         INSTALLSTATE* piAction);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiSetFeatureStateA(MSIHANDLE hInstall, const(PSTR) szFeature, INSTALLSTATE iState);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiSetFeatureStateW(MSIHANDLE hInstall, const(PWSTR) szFeature, INSTALLSTATE iState);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiSetFeatureAttributesA(MSIHANDLE hInstall, const(PSTR) szFeature, uint dwAttributes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiSetFeatureAttributesW(MSIHANDLE hInstall, const(PWSTR) szFeature, uint dwAttributes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiGetComponentStateA(MSIHANDLE hInstall, const(PSTR) szComponent, INSTALLSTATE* piInstalled, 
                           INSTALLSTATE* piAction);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiGetComponentStateW(MSIHANDLE hInstall, const(PWSTR) szComponent, INSTALLSTATE* piInstalled, 
                           INSTALLSTATE* piAction);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiSetComponentStateA(MSIHANDLE hInstall, const(PSTR) szComponent, INSTALLSTATE iState);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiSetComponentStateW(MSIHANDLE hInstall, const(PWSTR) szComponent, INSTALLSTATE iState);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiGetFeatureCostA(MSIHANDLE hInstall, const(PSTR) szFeature, MSICOSTTREE iCostTree, INSTALLSTATE iState, 
                        int* piCost);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiGetFeatureCostW(MSIHANDLE hInstall, const(PWSTR) szFeature, MSICOSTTREE iCostTree, INSTALLSTATE iState, 
                        int* piCost);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiEnumComponentCostsA(MSIHANDLE hInstall, const(PSTR) szComponent, uint dwIndex, INSTALLSTATE iState, 
                            PSTR szDriveBuf, uint* pcchDriveBuf, int* piCost, int* piTempCost);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiEnumComponentCostsW(MSIHANDLE hInstall, const(PWSTR) szComponent, uint dwIndex, INSTALLSTATE iState, 
                            PWSTR szDriveBuf, uint* pcchDriveBuf, int* piCost, int* piTempCost);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiSetInstallLevel(MSIHANDLE hInstall, int iInstallLevel);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiGetFeatureValidStatesA(MSIHANDLE hInstall, const(PSTR) szFeature, uint* lpInstallStates);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiGetFeatureValidStatesW(MSIHANDLE hInstall, const(PWSTR) szFeature, uint* lpInstallStates);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiGetSourcePathA(MSIHANDLE hInstall, const(PSTR) szFolder, PSTR szPathBuf, uint* pcchPathBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiGetSourcePathW(MSIHANDLE hInstall, const(PWSTR) szFolder, PWSTR szPathBuf, uint* pcchPathBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiGetTargetPathA(MSIHANDLE hInstall, const(PSTR) szFolder, PSTR szPathBuf, uint* pcchPathBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiGetTargetPathW(MSIHANDLE hInstall, const(PWSTR) szFolder, PWSTR szPathBuf, uint* pcchPathBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiSetTargetPathA(MSIHANDLE hInstall, const(PSTR) szFolder, const(PSTR) szFolderPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiSetTargetPathW(MSIHANDLE hInstall, const(PWSTR) szFolder, const(PWSTR) szFolderPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiVerifyDiskSpace(MSIHANDLE hInstall);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiEnableUIPreview(MSIHANDLE hDatabase, MSIHANDLE* phPreview);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiPreviewDialogA(MSIHANDLE hPreview, const(PSTR) szDialogName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiPreviewDialogW(MSIHANDLE hPreview, const(PWSTR) szDialogName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiPreviewBillboardA(MSIHANDLE hPreview, const(PSTR) szControlName, const(PSTR) szBillboard);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
uint MsiPreviewBillboardW(MSIHANDLE hPreview, const(PWSTR) szControlName, const(PWSTR) szBillboard);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("msi.dll")
MSIHANDLE MsiGetLastErrorRecord();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("sfc.dll")
BOOL SfcGetNextProtectedFile(HANDLE RpcHandle, PROTECTED_FILE_DATA* ProtFileData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("sfc.dll")
BOOL SfcIsFileProtected(HANDLE RpcHandle, const(PWSTR) ProtFileName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("sfc.dll")
BOOL SfcIsKeyProtected(HKEY KeyHandle, const(PWSTR) SubKeyName, uint KeySam);

@DllImport("sfc.dll")
BOOL SfpVerifyFile(const(PSTR) pszFileName, PSTR pszError, uint dwErrSize);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("mspatchc.dll")
BOOL CreatePatchFileA(const(PSTR) OldFileName, const(PSTR) NewFileName, const(PSTR) PatchFileName, 
                      uint OptionFlags, PATCH_OPTION_DATA* OptionData);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("mspatchc.dll")
BOOL CreatePatchFileW(const(PWSTR) OldFileName, const(PWSTR) NewFileName, const(PWSTR) PatchFileName, 
                      uint OptionFlags, PATCH_OPTION_DATA* OptionData);

@DllImport("mspatchc.dll")
BOOL CreatePatchFileByHandles(HANDLE OldFileHandle, HANDLE NewFileHandle, HANDLE PatchFileHandle, uint OptionFlags, 
                              PATCH_OPTION_DATA* OptionData);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("mspatchc.dll")
BOOL CreatePatchFileExA(uint OldFileCount, PATCH_OLD_FILE_INFO_A* OldFileInfoArray, const(PSTR) NewFileName, 
                        const(PSTR) PatchFileName, uint OptionFlags, PATCH_OPTION_DATA* OptionData, 
                        PPATCH_PROGRESS_CALLBACK ProgressCallback, void* CallbackContext);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("mspatchc.dll")
BOOL CreatePatchFileExW(uint OldFileCount, PATCH_OLD_FILE_INFO_W* OldFileInfoArray, const(PWSTR) NewFileName, 
                        const(PWSTR) PatchFileName, uint OptionFlags, PATCH_OPTION_DATA* OptionData, 
                        PPATCH_PROGRESS_CALLBACK ProgressCallback, void* CallbackContext);

@DllImport("mspatchc.dll")
BOOL CreatePatchFileByHandlesEx(uint OldFileCount, PATCH_OLD_FILE_INFO_H* OldFileInfoArray, HANDLE NewFileHandle, 
                                HANDLE PatchFileHandle, uint OptionFlags, PATCH_OPTION_DATA* OptionData, 
                                PPATCH_PROGRESS_CALLBACK ProgressCallback, void* CallbackContext);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("mspatchc.dll")
BOOL ExtractPatchHeaderToFileA(const(PSTR) PatchFileName, const(PSTR) PatchHeaderFileName);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("mspatchc.dll")
BOOL ExtractPatchHeaderToFileW(const(PWSTR) PatchFileName, const(PWSTR) PatchHeaderFileName);

@DllImport("mspatchc.dll")
BOOL ExtractPatchHeaderToFileByHandles(HANDLE PatchFileHandle, HANDLE PatchHeaderFileHandle);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("mspatcha.dll")
BOOL TestApplyPatchToFileA(const(PSTR) PatchFileName, const(PSTR) OldFileName, uint ApplyOptionFlags);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("mspatcha.dll")
BOOL TestApplyPatchToFileW(const(PWSTR) PatchFileName, const(PWSTR) OldFileName, uint ApplyOptionFlags);

@DllImport("mspatcha.dll")
BOOL TestApplyPatchToFileByHandles(HANDLE PatchFileHandle, HANDLE OldFileHandle, uint ApplyOptionFlags);

@DllImport("mspatcha.dll")
BOOL TestApplyPatchToFileByBuffers(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/ubyte* PatchFileBuffer, 
                                   uint PatchFileSize, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* OldFileBuffer, 
                                   uint OldFileSize, uint* NewFileSize, uint ApplyOptionFlags);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("mspatcha.dll")
BOOL ApplyPatchToFileA(const(PSTR) PatchFileName, const(PSTR) OldFileName, const(PSTR) NewFileName, 
                       uint ApplyOptionFlags);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("mspatcha.dll")
BOOL ApplyPatchToFileW(const(PWSTR) PatchFileName, const(PWSTR) OldFileName, const(PWSTR) NewFileName, 
                       uint ApplyOptionFlags);

@DllImport("mspatcha.dll")
BOOL ApplyPatchToFileByHandles(HANDLE PatchFileHandle, HANDLE OldFileHandle, HANDLE NewFileHandle, 
                               uint ApplyOptionFlags);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("mspatcha.dll")
BOOL ApplyPatchToFileExA(const(PSTR) PatchFileName, const(PSTR) OldFileName, const(PSTR) NewFileName, 
                         uint ApplyOptionFlags, PPATCH_PROGRESS_CALLBACK ProgressCallback, void* CallbackContext);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("mspatcha.dll")
BOOL ApplyPatchToFileExW(const(PWSTR) PatchFileName, const(PWSTR) OldFileName, const(PWSTR) NewFileName, 
                         uint ApplyOptionFlags, PPATCH_PROGRESS_CALLBACK ProgressCallback, void* CallbackContext);

@DllImport("mspatcha.dll")
BOOL ApplyPatchToFileByHandlesEx(HANDLE PatchFileHandle, HANDLE OldFileHandle, HANDLE NewFileHandle, 
                                 uint ApplyOptionFlags, PPATCH_PROGRESS_CALLBACK ProgressCallback, 
                                 void* CallbackContext);

@DllImport("mspatcha.dll")
BOOL ApplyPatchToFileByBuffers(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/ubyte* PatchFileMapped, 
                               uint PatchFileSize, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* OldFileMapped, 
                               uint OldFileSize, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte** NewFileBuffer, 
                               uint NewFileBufferSize, uint* NewFileActualSize, FILETIME* NewFileTime, 
                               uint ApplyOptionFlags, PPATCH_PROGRESS_CALLBACK ProgressCallback, 
                               void* CallbackContext);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("mspatcha.dll")
BOOL GetFilePatchSignatureA(const(PSTR) FileName, uint OptionFlags, void* OptionData, uint IgnoreRangeCount, 
                            PATCH_IGNORE_RANGE* IgnoreRangeArray, uint RetainRangeCount, 
                            PATCH_RETAIN_RANGE* RetainRangeArray, uint SignatureBufferSize, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(7)))])*/PSTR SignatureBuffer);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("mspatcha.dll")
BOOL GetFilePatchSignatureW(const(PWSTR) FileName, uint OptionFlags, void* OptionData, uint IgnoreRangeCount, 
                            PATCH_IGNORE_RANGE* IgnoreRangeArray, uint RetainRangeCount, 
                            PATCH_RETAIN_RANGE* RetainRangeArray, uint SignatureBufferSize, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(7)))])*/PWSTR SignatureBuffer);

@DllImport("mspatcha.dll")
BOOL GetFilePatchSignatureByHandle(HANDLE FileHandle, uint OptionFlags, void* OptionData, uint IgnoreRangeCount, 
                                   PATCH_IGNORE_RANGE* IgnoreRangeArray, uint RetainRangeCount, 
                                   PATCH_RETAIN_RANGE* RetainRangeArray, uint SignatureBufferSize, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(7)))])*/PSTR SignatureBuffer);

@DllImport("mspatcha.dll")
BOOL GetFilePatchSignatureByBuffer(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/ubyte* FileBufferWritable, 
                                   uint FileSize, uint OptionFlags, void* OptionData, uint IgnoreRangeCount, 
                                   PATCH_IGNORE_RANGE* IgnoreRangeArray, uint RetainRangeCount, 
                                   PATCH_RETAIN_RANGE* RetainRangeArray, uint SignatureBufferSize, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(8)))])*/PSTR SignatureBuffer);

@DllImport("mspatcha.dll")
int NormalizeFileForPatchSignature(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* FileBuffer, 
                                   uint FileSize, uint OptionFlags, PATCH_OPTION_DATA* OptionData, 
                                   uint NewFileCoffBase, uint NewFileCoffTime, uint IgnoreRangeCount, 
                                   PATCH_IGNORE_RANGE* IgnoreRangeArray, uint RetainRangeCount, 
                                   PATCH_RETAIN_RANGE* RetainRangeArray);

@DllImport("msdelta.dll")
BOOL GetDeltaInfoB(DELTA_INPUT Delta, DELTA_HEADER_INFO* lpHeaderInfo);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("msdelta.dll")
BOOL GetDeltaInfoA(const(PSTR) lpDeltaName, DELTA_HEADER_INFO* lpHeaderInfo);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("msdelta.dll")
BOOL GetDeltaInfoW(const(PWSTR) lpDeltaName, DELTA_HEADER_INFO* lpHeaderInfo);

@DllImport("msdelta.dll")
BOOL ApplyDeltaGetReverseB(long ApplyFlags, DELTA_INPUT Source, DELTA_INPUT Delta, 
                           const(FILETIME)* lpReverseFileTime, DELTA_OUTPUT* lpTarget, DELTA_OUTPUT* lpTargetReverse);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/DevNotes/msdelta-applydeltab
@DllImport("msdelta.dll")
BOOL ApplyDeltaB(long ApplyFlags, DELTA_INPUT Source, DELTA_INPUT Delta, DELTA_OUTPUT* lpTarget);

@DllImport("msdelta.dll")
BOOL ApplyDeltaProvidedB(long ApplyFlags, DELTA_INPUT Source, DELTA_INPUT Delta, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* lpTarget, 
                         size_t uTargetSize);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("msdelta.dll")
BOOL ApplyDeltaA(long ApplyFlags, const(PSTR) lpSourceName, const(PSTR) lpDeltaName, const(PSTR) lpTargetName);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("msdelta.dll")
BOOL ApplyDeltaW(long ApplyFlags, const(PWSTR) lpSourceName, const(PWSTR) lpDeltaName, const(PWSTR) lpTargetName);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/DevNotes/msdelta-createdeltab
@DllImport("msdelta.dll")
BOOL CreateDeltaB(long FileTypeSet, long SetFlags, long ResetFlags, DELTA_INPUT Source, DELTA_INPUT Target, 
                  DELTA_INPUT SourceOptions, DELTA_INPUT TargetOptions, DELTA_INPUT GlobalOptions, 
                  const(FILETIME)* lpTargetFileTime, ALG_ID HashAlgId, DELTA_OUTPUT* lpDelta);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("msdelta.dll")
BOOL CreateDeltaA(long FileTypeSet, long SetFlags, long ResetFlags, const(PSTR) lpSourceName, 
                  const(PSTR) lpTargetName, const(PSTR) lpSourceOptionsName, const(PSTR) lpTargetOptionsName, 
                  DELTA_INPUT GlobalOptions, const(FILETIME)* lpTargetFileTime, ALG_ID HashAlgId, 
                  const(PSTR) lpDeltaName);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("msdelta.dll")
BOOL CreateDeltaW(long FileTypeSet, long SetFlags, long ResetFlags, const(PWSTR) lpSourceName, 
                  const(PWSTR) lpTargetName, const(PWSTR) lpSourceOptionsName, const(PWSTR) lpTargetOptionsName, 
                  DELTA_INPUT GlobalOptions, const(FILETIME)* lpTargetFileTime, ALG_ID HashAlgId, 
                  const(PWSTR) lpDeltaName);

@DllImport("msdelta.dll")
BOOL GetDeltaSignatureB(long FileTypeSet, ALG_ID HashAlgId, DELTA_INPUT Source, DELTA_HASH* lpHash);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("msdelta.dll")
BOOL GetDeltaSignatureA(long FileTypeSet, ALG_ID HashAlgId, const(PSTR) lpSourceName, DELTA_HASH* lpHash);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("msdelta.dll")
BOOL GetDeltaSignatureW(long FileTypeSet, ALG_ID HashAlgId, const(PWSTR) lpSourceName, DELTA_HASH* lpHash);

@DllImport("msdelta.dll")
BOOL DeltaNormalizeProvidedB(long FileTypeSet, long NormalizeFlags, DELTA_INPUT NormalizeOptions, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* lpSource, 
                             size_t uSourceSize);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/DevNotes/msdelta-deltafree
@DllImport("msdelta.dll")
BOOL DeltaFree(void* lpMemory);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
HANDLE CreateActCtxA(ACTCTXA* pActCtx);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
HANDLE CreateActCtxW(ACTCTXW* pActCtx);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
void AddRefActCtx(HANDLE hActCtx);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
void ReleaseActCtx(HANDLE hActCtx);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL ZombifyActCtx(HANDLE hActCtx);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL ActivateActCtx(HANDLE hActCtx, size_t* lpCookie);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL DeactivateActCtx(uint dwFlags, size_t ulCookie);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL GetCurrentActCtx(HANDLE* lphActCtx);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL FindActCtxSectionStringA(uint dwFlags, 
                              /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/const(GUID)* lpExtensionGuid, 
                              uint ulSectionId, const(PSTR) lpStringToFind, ACTCTX_SECTION_KEYED_DATA* ReturnedData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL FindActCtxSectionStringW(uint dwFlags, 
                              /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/const(GUID)* lpExtensionGuid, 
                              uint ulSectionId, const(PWSTR) lpStringToFind, ACTCTX_SECTION_KEYED_DATA* ReturnedData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL FindActCtxSectionGuid(uint dwFlags, 
                           /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/const(GUID)* lpExtensionGuid, 
                           uint ulSectionId, const(GUID)* lpGuidToFind, ACTCTX_SECTION_KEYED_DATA* ReturnedData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL QueryActCtxW(uint dwFlags, HANDLE hActCtx, void* pvSubInstance, uint ulInfoClass, 
                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* pvBuffer, 
                  size_t cbBuffer, size_t* pcbWrittenOrRequired);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL QueryActCtxSettingsW(uint dwFlags, HANDLE hActCtx, const(PWSTR) settingsNameSpace, const(PWSTR) settingName, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/PWSTR pvBuffer, 
                          size_t dwBuffer, size_t* pdwWrittenOrRequired);


// Interfaces

@GUID("0adda830-2c26-11d2-ad65-00a0c9af11a6")
struct MsmMerge;

@GUID("b9e511fc-e364-497a-a121-b7b3612cedce")
struct PMSvc;

@GUID("e482e5c6-e31e-4143-a2e6-dbc3d8e4b8d3")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/evalcom2/nn-evalcom2-ivalidate
interface IValidate : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/evalcom2/nf-evalcom2-ivalidate-opendatabase
    HRESULT OpenDatabase(const(PWSTR) szDatabase);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/evalcom2/nf-evalcom2-ivalidate-opencub
    HRESULT OpenCUB(const(PWSTR) szCUBFile);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/evalcom2/nf-evalcom2-ivalidate-closedatabase
    HRESULT CloseDatabase();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/evalcom2/nf-evalcom2-ivalidate-closecub
    HRESULT CloseCUB();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/evalcom2/nf-evalcom2-ivalidate-setdisplay
    HRESULT SetDisplay(LPDISPLAYVAL pDisplayFunction, void* pContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/evalcom2/nf-evalcom2-ivalidate-setstatus
    HRESULT SetStatus(LPEVALCOMCALLBACK pStatusFunction, void* pContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/evalcom2/nf-evalcom2-ivalidate-validate
    HRESULT Validate(const(PWSTR) wzICEs);
}

@GUID("0adda826-2c26-11d2-ad65-00a0c9af11a6")
interface IEnumMsmString : IUnknown
{
    HRESULT Next(uint cFetch, BSTR* rgbstrStrings, uint* pcFetched);
    HRESULT Skip(uint cSkip);
    HRESULT Reset();
    HRESULT Clone(IEnumMsmString* pemsmStrings);
}

@GUID("0adda827-2c26-11d2-ad65-00a0c9af11a6")
interface IMsmStrings : IDispatch
{
    HRESULT get_Item(int Item, BSTR* Return);
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IUnknown* NewEnum);
}

@GUID("0adda828-2c26-11d2-ad65-00a0c9af11a6")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mergemod/nn-mergemod-imsmerror
interface IMsmError : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mergemod/nf-mergemod-imsmerror-get_type
    HRESULT get_Type(msmErrorType* ErrorType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mergemod/nf-mergemod-imsmerror-get_path
    HRESULT get_Path(BSTR* ErrorPath);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mergemod/nf-mergemod-imsmerror-get_language
    HRESULT get_Language(short* ErrorLanguage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mergemod/nf-mergemod-imsmerror-get_databasetable
    HRESULT get_DatabaseTable(BSTR* ErrorTable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mergemod/nf-mergemod-imsmerror-get_databasekeys
    HRESULT get_DatabaseKeys(IMsmStrings* ErrorKeys);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mergemod/nf-mergemod-imsmerror-get_moduletable
    HRESULT get_ModuleTable(BSTR* ErrorTable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mergemod/nf-mergemod-imsmerror-get_modulekeys
    HRESULT get_ModuleKeys(IMsmStrings* ErrorKeys);
}

@GUID("0adda829-2c26-11d2-ad65-00a0c9af11a6")
interface IEnumMsmError : IUnknown
{
    HRESULT Next(uint cFetch, IMsmError* rgmsmErrors, uint* pcFetched);
    HRESULT Skip(uint cSkip);
    HRESULT Reset();
    HRESULT Clone(IEnumMsmError* pemsmErrors);
}

@GUID("0adda82a-2c26-11d2-ad65-00a0c9af11a6")
interface IMsmErrors : IDispatch
{
    HRESULT get_Item(int Item, IMsmError* Return);
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IUnknown* NewEnum);
}

@GUID("0adda82b-2c26-11d2-ad65-00a0c9af11a6")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mergemod/nn-mergemod-imsmdependency
interface IMsmDependency : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mergemod/nf-mergemod-imsmdependency-get_module
    HRESULT get_Module(BSTR* Module);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mergemod/nf-mergemod-imsmdependency-get_language
    HRESULT get_Language(short* Language);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mergemod/nf-mergemod-imsmdependency-get_version
    HRESULT get_Version(BSTR* Version);
}

@GUID("0adda82c-2c26-11d2-ad65-00a0c9af11a6")
interface IEnumMsmDependency : IUnknown
{
    HRESULT Next(uint cFetch, IMsmDependency* rgmsmDependencies, uint* pcFetched);
    HRESULT Skip(uint cSkip);
    HRESULT Reset();
    HRESULT Clone(IEnumMsmDependency* pemsmDependencies);
}

@GUID("0adda82d-2c26-11d2-ad65-00a0c9af11a6")
interface IMsmDependencies : IDispatch
{
    HRESULT get_Item(int Item, IMsmDependency* Return);
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IUnknown* NewEnum);
}

@GUID("0adda82e-2c26-11d2-ad65-00a0c9af11a6")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mergemod/nn-mergemod-imsmmerge
interface IMsmMerge : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mergemod/nf-mergemod-imsmmerge-opendatabase
    HRESULT OpenDatabase(const(BSTR) Path);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mergemod/nf-mergemod-imsmmerge-openmodule
    HRESULT OpenModule(const(BSTR) Path, const(short) Language);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mergemod/nf-mergemod-imsmmerge-closedatabase
    HRESULT CloseDatabase(const(VARIANT_BOOL) Commit);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mergemod/nf-mergemod-imsmmerge-closemodule
    HRESULT CloseModule();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mergemod/nf-mergemod-imsmmerge-openlog
    HRESULT OpenLog(const(BSTR) Path);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mergemod/nf-mergemod-imsmmerge-closelog
    HRESULT CloseLog();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mergemod/nf-mergemod-imsmmerge-log
    HRESULT Log(const(BSTR) Message);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mergemod/nf-mergemod-imsmmerge-get_errors
    HRESULT get_Errors(IMsmErrors* Errors);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mergemod/nf-mergemod-imsmmerge-get_dependencies
    HRESULT get_Dependencies(IMsmDependencies* Dependencies);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mergemod/nf-mergemod-imsmmerge-merge
    HRESULT Merge(const(BSTR) Feature, const(BSTR) RedirectDir);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mergemod/nf-mergemod-imsmmerge-connect
    HRESULT Connect(const(BSTR) Feature);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mergemod/nf-mergemod-imsmmerge-extractcab
    HRESULT ExtractCAB(const(BSTR) FileName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mergemod/nf-mergemod-imsmmerge-extractfiles
    HRESULT ExtractFiles(const(BSTR) Path);
}

@GUID("7041ae26-2d78-11d2-888a-00a0c981b015")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mergemod/nn-mergemod-imsmgetfiles
interface IMsmGetFiles : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mergemod/nf-mergemod-imsmgetfiles-get_modulefiles
    HRESULT get_ModuleFiles(IMsmStrings* Files);
}

@GUID("cd193bc0-b4bc-11d2-9833-00c04fc31d2e")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsxs/nn-winsxs-iassemblyname
interface IAssemblyName : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsxs/nf-winsxs-iassemblyname-setproperty
    HRESULT SetProperty(uint PropertyId, void* pvProperty, uint cbProperty);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsxs/nf-winsxs-iassemblyname-getproperty
    HRESULT GetProperty(uint PropertyId, void* pvProperty, uint* pcbProperty);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsxs/nf-winsxs-iassemblyname-finalize
    HRESULT Finalize();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsxs/nf-winsxs-iassemblyname-getdisplayname
    HRESULT GetDisplayName(PWSTR szDisplayName, uint* pccDisplayName, uint dwDisplayFlags);
    HRESULT Reserved(const(GUID)* refIID, IUnknown pUnkReserved1, IUnknown pUnkReserved2, const(PWSTR) szReserved, 
                     long llReserved, void* pvReserved, uint cbReserved, void** ppReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsxs/nf-winsxs-iassemblyname-getname
    HRESULT GetName(uint* lpcwBuffer, PWSTR pwzName);
    HRESULT GetVersion(uint* pdwVersionHi, uint* pdwVersionLow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsxs/nf-winsxs-iassemblyname-isequal
    HRESULT IsEqual(IAssemblyName pName, uint dwCmpFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsxs/nf-winsxs-iassemblyname-clone
    HRESULT Clone(IAssemblyName* pName);
}

@GUID("9e3aaeb4-d1cd-11d2-bab9-00c04f8eceae")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsxs/nn-winsxs-iassemblycacheitem
interface IAssemblyCacheItem : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsxs/nf-winsxs-iassemblycacheitem-createstream
    HRESULT CreateStream(uint dwFlags, const(PWSTR) pszStreamName, uint dwFormat, uint dwFormatFlags, 
                         IStream* ppIStream, ulong* puliMaxSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsxs/nf-winsxs-iassemblycacheitem-commit
    HRESULT Commit(uint dwFlags, uint* pulDisposition);
    HRESULT AbortItem();
}

@GUID("e707dcde-d1cd-11d2-bab9-00c04f8eceae")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsxs/nn-winsxs-iassemblycache
interface IAssemblyCache : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsxs/nf-winsxs-iassemblycache-uninstallassembly
    HRESULT UninstallAssembly(uint dwFlags, const(PWSTR) pszAssemblyName, FUSION_INSTALL_REFERENCE* pRefData, 
                              IASSEMBLYCACHE_UNINSTALL_DISPOSITION* pulDisposition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsxs/nf-winsxs-iassemblycache-queryassemblyinfo
    HRESULT QueryAssemblyInfo(QUERYASMINFO_FLAGS dwFlags, const(PWSTR) pszAssemblyName, ASSEMBLY_INFO* pAsmInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsxs/nf-winsxs-iassemblycache-createassemblycacheitem
    HRESULT CreateAssemblyCacheItem(uint dwFlags, void* pvReserved, IAssemblyCacheItem* ppAsmItem, 
                                    const(PWSTR) pszAssemblyName);
    HRESULT Reserved(IUnknown* ppUnk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsxs/nf-winsxs-iassemblycache-installassembly
    HRESULT InstallAssembly(uint dwFlags, const(PWSTR) pszManifestFilePath, FUSION_INSTALL_REFERENCE* pRefData);
}

@GUID("50afb58a-438c-4088-9789-f8c4899829c7")
interface IPMApplicationInfo : IUnknown
{
    HRESULT get_ProductID(GUID* pProductID);
    HRESULT get_InstanceID(GUID* pInstanceID);
    HRESULT get_OfferID(GUID* pOfferID);
    HRESULT get_DefaultTask(BSTR* pDefaultTask);
    HRESULT get_AppTitle(BSTR* pAppTitle);
    HRESULT get_IconPath(BSTR* pAppIconPath);
    HRESULT get_NotificationState(BOOL* pIsNotified);
    HRESULT get_AppInstallType(PM_APPLICATION_INSTALL_TYPE* pAppInstallType);
    HRESULT get_State(PM_APPLICATION_STATE* pState);
    HRESULT get_IsRevoked(BOOL* pIsRevoked);
    HRESULT get_UpdateAvailable(BOOL* pIsUpdateAvailable);
    HRESULT get_InstallDate(FILETIME* pInstallDate);
    HRESULT get_IsUninstallable(BOOL* pIsUninstallable);
    HRESULT get_IsThemable(BOOL* pIsThemable);
    HRESULT get_IsTrial(BOOL* pIsTrial);
    HRESULT get_InstallPath(BSTR* pInstallPath);
    HRESULT get_DataRoot(BSTR* pDataRoot);
    HRESULT get_Genre(PM_APP_GENRE* pGenre);
    HRESULT get_Publisher(BSTR* pPublisher);
    HRESULT get_Author(BSTR* pAuthor);
    HRESULT get_Description(BSTR* pDescription);
    HRESULT get_Version(BSTR* pVersion);
    HRESULT get_InvocationInfo(BSTR* pImageUrn, BSTR* pParameters);
    HRESULT get_AppPlatMajorVersion(ubyte* pMajorVer);
    HRESULT get_AppPlatMinorVersion(ubyte* pMinorVer);
    HRESULT get_PublisherID(GUID* pPublisherID);
    HRESULT get_IsMultiCore(BOOL* pIsMultiCore);
    HRESULT get_SID(BSTR* pSID);
    HRESULT get_AppPlatMajorVersionLightUp(ubyte* pMajorVer);
    HRESULT get_AppPlatMinorVersionLightUp(ubyte* pMinorVer);
    HRESULT set_UpdateAvailable(BOOL IsUpdateAvailable);
    HRESULT set_NotificationState(BOOL IsNotified);
    HRESULT set_IconPath(BSTR AppIconPath);
    HRESULT set_UninstallableState(BOOL IsUninstallable);
    HRESULT get_IsPinableOnKidZone(BOOL* pIsPinable);
    HRESULT get_IsOriginallyPreInstalled(BOOL* pIsPreinstalled);
    HRESULT get_IsInstallOnSD(BOOL* pIsInstallOnSD);
    HRESULT get_IsOptoutOnSD(BOOL* pIsOptoutOnSD);
    HRESULT get_IsOptoutBackupRestore(BOOL* pIsOptoutBackupRestore);
    HRESULT set_EnterpriseDisabled(BOOL IsDisabled);
    HRESULT set_EnterpriseUninstallable(BOOL IsUninstallable);
    HRESULT get_EnterpriseDisabled(BOOL* IsDisabled);
    HRESULT get_EnterpriseUninstallable(BOOL* IsUninstallable);
    HRESULT get_IsVisibleOnAppList(BOOL* pIsVisible);
    HRESULT get_IsInboxApp(BOOL* pIsInboxApp);
    HRESULT get_StorageID(GUID* pStorageID);
    HRESULT get_StartAppBlob(PM_STARTAPPBLOB* pBlob);
    HRESULT get_IsMovable(BOOL* pIsMovable);
    HRESULT get_DeploymentAppEnumerationHubFilter(PM_TILE_HUBTYPE* HubType);
    HRESULT get_ModifiedDate(FILETIME* pModifiedDate);
    HRESULT get_IsOriginallyRestored(BOOL* pIsRestored);
    HRESULT get_ShouldDeferMdilBind(BOOL* pfDeferMdilBind);
    HRESULT get_IsFullyPreInstall(BOOL* pfIsFullyPreInstall);
    HRESULT set_IsMdilMaintenanceNeeded(BOOL fIsMdilMaintenanceNeeded);
    HRESULT set_Title(BSTR AppTitle);
}

@GUID("6c2b8017-1efa-42a7-86c0-6d4b640bf528")
interface IPMTilePropertyInfo : IUnknown
{
    HRESULT get_PropertyID(uint* pPropID);
    HRESULT get_PropertyValue(BSTR* pPropValue);
    HRESULT set_Property(BSTR PropValue);
}

@GUID("cc4cd629-9047-4250-aac8-930e47812421")
interface IPMTilePropertyEnumerator : IUnknown
{
    HRESULT get_Next(IPMTilePropertyInfo* ppPropInfo);
}

@GUID("d1604833-2b08-4001-82cd-183ad734f752")
interface IPMTileInfo : IUnknown
{
    HRESULT get_ProductID(GUID* pProductID);
    HRESULT get_TileID(BSTR* pTileID);
    HRESULT get_TemplateType(TILE_TEMPLATE_TYPE* pTemplateType);
    HRESULT get_HubPinnedState(PM_TILE_HUBTYPE HubType, BOOL* pPinned);
    HRESULT get_HubPosition(PM_TILE_HUBTYPE HubType, uint* pPosition);
    HRESULT get_IsNotified(BOOL* pIsNotified);
    HRESULT get_IsDefault(BOOL* pIsDefault);
    HRESULT get_TaskID(BSTR* pTaskID);
    HRESULT get_TileType(PM_STARTTILE_TYPE* pStartTileType);
    HRESULT get_IsThemable(BOOL* pIsThemable);
    HRESULT get_PropertyById(uint PropID, IPMTilePropertyInfo* ppPropInfo);
    HRESULT get_InvocationInfo(BSTR* pImageUrn, BSTR* pParameters);
    HRESULT get_PropertyEnum(IPMTilePropertyEnumerator* ppTilePropEnum);
    HRESULT get_HubTileSize(PM_TILE_HUBTYPE HubType, PM_TILE_SIZE* pSize);
    HRESULT set_HubPosition(PM_TILE_HUBTYPE HubType, uint Position);
    HRESULT set_NotifiedState(BOOL Notified);
    HRESULT set_HubPinnedState(PM_TILE_HUBTYPE HubType, BOOL Pinned);
    HRESULT set_HubTileSize(PM_TILE_HUBTYPE HubType, PM_TILE_SIZE Size);
    HRESULT set_InvocationInfo(BSTR TaskName, BSTR TaskParameters);
    HRESULT get_StartTileBlob(PM_STARTTILEBLOB* pBlob);
    HRESULT get_IsRestoring(BOOL* pIsRestoring);
    HRESULT get_IsAutoRestoreDisabled(BOOL* pIsAutoRestoreDisabled);
    HRESULT set_IsRestoring(BOOL Restoring);
    HRESULT set_IsAutoRestoreDisabled(BOOL AutoRestoreDisabled);
}

@GUID("ded83065-e462-4b2c-acb5-e39cea61c874")
interface IPMTileInfoEnumerator : IUnknown
{
    HRESULT get_Next(IPMTileInfo* ppTileInfo);
}

@GUID("0ec42a96-4d46-4dc6-a3d9-a7acaac0f5fa")
interface IPMApplicationInfoEnumerator : IUnknown
{
    HRESULT get_Next(IPMApplicationInfo* ppAppInfo);
}

@GUID("6009a81f-4710-4697-b5f6-2208f6057b8e")
interface IPMLiveTileJobInfo : IUnknown
{
    HRESULT get_ProductID(GUID* pProductID);
    HRESULT get_TileID(BSTR* pTileID);
    HRESULT get_NextSchedule(FILETIME* pNextSchedule);
    HRESULT set_NextSchedule(FILETIME ftNextSchedule);
    HRESULT get_StartSchedule(FILETIME* pStartSchedule);
    HRESULT set_StartSchedule(FILETIME ftStartSchedule);
    HRESULT get_IntervalDuration(uint* pIntervalDuration);
    HRESULT set_IntervalDuration(uint ulIntervalDuration);
    HRESULT get_RunForever(BOOL* IsRunForever);
    HRESULT set_RunForever(BOOL fRunForever);
    HRESULT get_MaxRunCount(uint* pMaxRunCount);
    HRESULT set_MaxRunCount(uint ulMaxRunCount);
    HRESULT get_RunCount(uint* pRunCount);
    HRESULT set_RunCount(uint ulRunCount);
    HRESULT get_RecurrenceType(uint* pRecurrenceType);
    HRESULT set_RecurrenceType(uint ulRecurrenceType);
    HRESULT get_TileXML(ubyte** pTileXml, uint* pcbTileXml);
    HRESULT set_TileXML(ubyte* pTileXml, uint cbTileXml);
    HRESULT get_UrlXML(ubyte** pUrlXML, uint* pcbUrlXML);
    HRESULT set_UrlXML(ubyte* pUrlXML, uint cbUrlXML);
    HRESULT get_AttemptCount(uint* pAttemptCount);
    HRESULT set_AttemptCount(uint ulAttemptCount);
    HRESULT get_DownloadState(uint* pDownloadState);
    HRESULT set_DownloadState(uint ulDownloadState);
}

@GUID("bc042582-9415-4f36-9f99-06f104c07c03")
interface IPMLiveTileJobInfoEnumerator : IUnknown
{
    HRESULT get_Next(IPMLiveTileJobInfo* ppLiveTileJobInfo);
}

@GUID("35f785fa-1979-4a8b-bc8f-fd70eb0d1544")
interface IPMDeploymentManager : IUnknown
{
    HRESULT ReportDownloadBegin(GUID productID);
    HRESULT ReportDownloadProgress(GUID productID, ushort usProgress);
    HRESULT ReportDownloadComplete(GUID productID, HRESULT hrResult);
    HRESULT BeginInstall(PM_INSTALLINFO* pInstallInfo);
    HRESULT BeginUpdate(PM_UPDATEINFO* pUpdateInfo);
    HRESULT BeginDeployPackage(PM_INSTALLINFO* pInstallInfo);
    HRESULT BeginUpdateDeployedPackageLegacy(PM_UPDATEINFO_LEGACY* pUpdateInfo);
    HRESULT BeginUninstall(GUID productID);
    HRESULT BeginEnterpriseAppInstall(PM_INSTALLINFO* pInstallInfo);
    HRESULT BeginEnterpriseAppUpdate(PM_UPDATEINFO* pUpdateInfo);
    HRESULT BeginUpdateLicense(GUID productID, GUID offerID, ubyte* pbLicense, uint cbLicense);
    HRESULT GetLicenseChallenge(BSTR PackagePath, ubyte** ppbChallenge, uint* pcbChallenge, ubyte** ppbKID, 
                                uint* pcbKID, ubyte** ppbDeviceID, uint* pcbDeviceID, ubyte** ppbSaltValue, 
                                uint* pcbSaltValue, ubyte** ppbKGVValue, uint* pcbKGVValue);
    HRESULT GetLicenseChallengeByProductID(GUID ProductID, ubyte** ppbChallenge, uint* pcbLicense);
    HRESULT GetLicenseChallengeByProductID2(GUID ProductID, ubyte** ppbChallenge, uint* pcbLicense, ubyte** ppbKID, 
                                            uint* pcbKID, ubyte** ppbDeviceID, uint* pcbDeviceID, 
                                            ubyte** ppbSaltValue, uint* pcbSaltValue, ubyte** ppbKGVValue, 
                                            uint* pcbKGVValue);
    HRESULT RevokeLicense(GUID productID);
    HRESULT RebindMdilBinaries(GUID ProductID, SAFEARRAY* FileNames);
    HRESULT RebindAllMdilBinaries(GUID ProductID, GUID InstanceID);
    HRESULT RegenerateXbf(GUID ProductID, SAFEARRAY* AssemblyPaths);
    HRESULT GenerateXbfForCurrentLocale(GUID ProductID);
    HRESULT BeginProvision(GUID ProductID, BSTR XMLpath);
    HRESULT BeginDeprovision(GUID ProductID);
    HRESULT ReindexSQLCEDatabases(GUID ProductID);
    HRESULT SetApplicationsNeedMaintenance(uint RequiredMaintenanceOperations, uint* pcApplications);
    HRESULT UpdateChamberProfile(GUID ProductID);
    HRESULT EnterprisePolicyIsApplicationAllowed(GUID productId, const(PWSTR) publisherName, BOOL* pIsAllowed);
    HRESULT BeginUpdateDeployedPackage(PM_UPDATEINFO* pUpdateInfo);
    HRESULT ReportRestoreCancelled(GUID productID);
    HRESULT ResolveResourceString(const(PWSTR) resourceString, BSTR* pResolvedResourceString);
    HRESULT UpdateCapabilitiesForModernApps();
    HRESULT ReportDownloadStatusUpdate(GUID productId);
    HRESULT BeginUninstallWithOptions(GUID productID, uint removalOptions);
    HRESULT BindDeferredMdilBinaries();
    HRESULT GenerateXamlLightupXbfForCurrentLocale(BSTR PackageFamilyName);
    HRESULT AddLicenseForAppx(GUID productID, ubyte* pbLicense, uint cbLicense, ubyte* pbPlayReadyHeader, 
                              uint cbPlayReadyHeader);
    HRESULT FixJunctionsForAppsOnSDCard();
}

@GUID("698d57c2-292d-4cf3-b73c-d95a6922ed9a")
interface IPMEnumerationManager : IUnknown
{
    HRESULT get_AllApplications(IPMApplicationInfoEnumerator* ppAppEnum, PM_ENUM_FILTER Filter);
    HRESULT get_AllTiles(IPMTileInfoEnumerator* ppTileEnum, PM_ENUM_FILTER Filter);
    HRESULT get_AllTasks(IPMTaskInfoEnumerator* ppTaskEnum, PM_ENUM_FILTER Filter);
    HRESULT get_AllExtensions(IPMExtensionInfoEnumerator* ppExtensionEnum, PM_ENUM_FILTER Filter);
    HRESULT get_AllBackgroundServiceAgents(IPMBackgroundServiceAgentInfoEnumerator* ppBSAEnum, 
                                           PM_ENUM_FILTER Filter);
    HRESULT get_AllBackgroundWorkers(IPMBackgroundWorkerInfoEnumerator* ppBSWEnum, PM_ENUM_FILTER Filter);
    HRESULT get_ApplicationInfo(GUID ProductID, IPMApplicationInfo* ppAppInfo);
    HRESULT get_TileInfo(GUID ProductID, BSTR TileID, IPMTileInfo* ppTileInfo);
    HRESULT get_TaskInfo(GUID ProductID, BSTR TaskID, IPMTaskInfo* ppTaskInfo);
    HRESULT get_TaskInfoEx(GUID ProductID, const(PWSTR) TaskID, IPMTaskInfo* ppTaskInfo);
    HRESULT get_BackgroundServiceAgentInfo(uint BSAID, IPMBackgroundServiceAgentInfo* ppTaskInfo);
    HRESULT get_AllLiveTileJobs(IPMLiveTileJobInfoEnumerator* ppLiveTileJobEnum);
    HRESULT get_LiveTileJob(GUID ProductID, BSTR TileID, PM_LIVETILE_RECURRENCE_TYPE RecurrenceType, 
                            IPMLiveTileJobInfo* ppLiveTileJobInfo);
    HRESULT get_ApplicationInfoExternal(GUID ProductID, IPMApplicationInfo* ppAppInfo);
    HRESULT get_FileHandlerGenericLogo(BSTR FileType, PM_LOGO_SIZE LogoSize, BSTR* pLogo);
    HRESULT get_ApplicationInfoFromAccessClaims(BSTR SysAppID0, BSTR SysAppID1, IPMApplicationInfo* ppAppInfo);
    HRESULT get_StartTileEnumeratorBlob(PM_ENUM_FILTER Filter, uint* pcTiles, PM_STARTTILEBLOB** ppTileBlobs);
    HRESULT get_StartAppEnumeratorBlob(PM_ENUM_FILTER Filter, uint* pcApps, PM_STARTAPPBLOB** ppAppBlobs);
}

@GUID("bf1d8c33-1bf5-4ee0-b549-6b9dd3834942")
interface IPMTaskInfo : IUnknown
{
    HRESULT get_ProductID(GUID* pProductID);
    HRESULT get_TaskID(BSTR* pTaskID);
    HRESULT get_NavigationPage(BSTR* pNavigationPage);
    HRESULT get_TaskTransition(PM_TASK_TRANSITION* pTaskTransition);
    HRESULT get_RuntimeType(PACKMAN_RUNTIME* pRuntimetype);
    HRESULT get_ActivationPolicy(PM_ACTIVATION_POLICY* pActivationPolicy);
    HRESULT get_TaskType(PM_TASK_TYPE* pTaskType);
    HRESULT get_InvocationInfo(BSTR* pImageUrn, BSTR* pParameters);
    HRESULT get_ImagePath(BSTR* pImagePath);
    HRESULT get_ImageParams(BSTR* pImageParams);
    HRESULT get_InstallRootFolder(BSTR* pInstallRootFolder);
    HRESULT get_DataRootFolder(BSTR* pDataRootFolder);
    HRESULT get_IsSingleInstanceHost(BOOL* pIsSingleInstanceHost);
    HRESULT get_IsInteropEnabled(BOOL* pIsInteropEnabled);
    HRESULT get_ApplicationState(PM_APPLICATION_STATE* pApplicationState);
    HRESULT get_InstallType(PM_APPLICATION_INSTALL_TYPE* pInstallType);
    HRESULT get_Version(ubyte* pTargetMajorVersion, ubyte* pTargetMinorVersion);
    HRESULT get_BitsPerPixel(ushort* pBitsPerPixel);
    HRESULT get_SuppressesDehydration(BOOL* pSuppressesDehydration);
    HRESULT get_BackgroundExecutionAbilities(BSTR* pBackgroundExecutionAbilities);
    HRESULT get_IsOptedForExtendedMem(BOOL* pIsOptedIn);
}

@GUID("0630b0f8-0bbc-4821-be74-c7995166ed2a")
interface IPMTaskInfoEnumerator : IUnknown
{
    HRESULT get_Next(IPMTaskInfo* ppTaskInfo);
}

@GUID("49acde79-9788-4d0a-8aa0-1746afdb9e9d")
interface IPMExtensionInfo : IUnknown
{
    HRESULT get_SupplierPID(GUID* pSupplierPID);
    HRESULT get_SupplierTaskID(BSTR* pSupplierTID);
    HRESULT get_Title(BSTR* pTitle);
    HRESULT get_IconPath(BSTR* pIconPath);
    HRESULT get_ExtraFile(BSTR* pFilePath);
    HRESULT get_InvocationInfo(BSTR* pImageUrn, BSTR* pParameters);
}

@GUID("6b87cb6c-0b88-4989-a4ec-033714f710d4")
interface IPMExtensionFileExtensionInfo : IUnknown
{
    HRESULT get_Name(BSTR* pName);
    HRESULT get_DisplayName(BSTR* pDisplayName);
    HRESULT get_Logo(PM_LOGO_SIZE LogoSize, BSTR* pLogo);
    HRESULT get_ContentType(BSTR FileType, BSTR* pContentType);
    HRESULT get_FileType(BSTR ContentType, BSTR* pFileType);
    HRESULT get_InvocationInfo(BSTR* pImageUrn, BSTR* pParameters);
    HRESULT get_AllFileTypes(uint* pcbTypes, BSTR** ppTypes);
}

@GUID("1e3fa036-51eb-4453-baff-b8d8e4b46c8e")
interface IPMExtensionProtocolInfo : IUnknown
{
    HRESULT get_Protocol(BSTR* pProtocol);
    HRESULT get_InvocationInfo(BSTR* pImageUrn, BSTR* pParameters);
}

@GUID("5471f48b-c65c-4656-8c70-242e31195fea")
interface IPMExtensionShareTargetInfo : IUnknown
{
    HRESULT get_AllFileTypes(uint* pcTypes, BSTR** ppTypes);
    HRESULT get_AllDataFormats(uint* pcDataFormats, BSTR** ppDataFormats);
    HRESULT get_SupportsAllFileTypes(BOOL* pSupportsAllTypes);
}

@GUID("e5666373-7ba1-467c-b819-b175db1c295b")
interface IPMExtensionContractInfo : IUnknown
{
    HRESULT get_InvocationInfo(BSTR* pAUMID, BSTR* pArgs);
}

@GUID("6dc91d25-9606-420c-9a78-e034a3418345")
interface IPMExtensionFileOpenPickerInfo : IUnknown
{
    HRESULT get_AllFileTypes(uint* pcTypes, BSTR** ppTypes);
    HRESULT get_SupportsAllFileTypes(BOOL* pSupportsAllTypes);
}

@GUID("38005cba-f81a-493e-a0f8-922c8680da43")
interface IPMExtensionFileSavePickerInfo : IUnknown
{
    HRESULT get_AllFileTypes(uint* pcTypes, BSTR** ppTypes);
    HRESULT get_SupportsAllFileTypes(BOOL* pSupportsAllTypes);
}

@GUID("e2d77509-4e58-4ba9-af7e-b642e370e1b0")
interface IPMExtensionCachedFileUpdaterInfo : IUnknown
{
    HRESULT get_SupportsUpdates(BOOL* pSupportsUpdates);
}

@GUID("403b9e82-1171-4573-8e6f-6f33f39b83dd")
interface IPMExtensionInfoEnumerator : IUnknown
{
    HRESULT get_Next(IPMExtensionInfo* ppExtensionInfo);
}

@GUID("3a8b46da-928c-4879-998c-09dc96f3d490")
interface IPMBackgroundServiceAgentInfo : IUnknown
{
    HRESULT get_ProductID(GUID* pProductID);
    HRESULT get_TaskID(BSTR* pTaskID);
    HRESULT get_BSAID(uint* pBSAID);
    HRESULT get_BGSpecifier(BSTR* pBGSpecifier);
    HRESULT get_BGName(BSTR* pBGName);
    HRESULT get_BGSource(BSTR* pBGSource);
    HRESULT get_BGType(BSTR* pBGType);
    HRESULT get_IsPeriodic(BOOL* pIsPeriodic);
    HRESULT get_IsScheduled(BOOL* pIsScheduled);
    HRESULT get_IsScheduleAllowed(BOOL* pIsScheduleAllowed);
    HRESULT get_Description(BSTR* pDescription);
    HRESULT get_IsLaunchOnBoot(BOOL* pLaunchOnBoot);
    HRESULT set_IsScheduled(BOOL IsScheduled);
    HRESULT set_IsScheduleAllowed(BOOL IsScheduleAllowed);
}

@GUID("7dd4531b-d3bf-4b6b-94f3-69c098b1497d")
interface IPMBackgroundWorkerInfo : IUnknown
{
    HRESULT get_ProductID(GUID* pProductID);
    HRESULT get_TaskID(BSTR* pTaskID);
    HRESULT get_BGName(BSTR* pBGName);
    HRESULT get_MaxStartupLatency(uint* pMaxStartupLatency);
    HRESULT get_ExpectedRuntime(uint* pExpectedRuntime);
    HRESULT get_IsBootWorker(BOOL* pIsBootWorker);
}

@GUID("18eb2072-ab56-43b3-872c-beafb7a6b391")
interface IPMBackgroundServiceAgentInfoEnumerator : IUnknown
{
    HRESULT get_Next(IPMBackgroundServiceAgentInfo* ppBSAInfo);
}

@GUID("87f479f8-90d8-4ec7-92b9-72787e2f636b")
interface IPMBackgroundWorkerInfoEnumerator : IUnknown
{
    HRESULT get_Next(IPMBackgroundWorkerInfo* ppBWInfo);
}


// GUIDs

const GUID CLSID_MsmMerge = GUIDOF!MsmMerge;
const GUID CLSID_PMSvc    = GUIDOF!PMSvc;

const GUID IID_IAssemblyCache                          = GUIDOF!IAssemblyCache;
const GUID IID_IAssemblyCacheItem                      = GUIDOF!IAssemblyCacheItem;
const GUID IID_IAssemblyName                           = GUIDOF!IAssemblyName;
const GUID IID_IEnumMsmDependency                      = GUIDOF!IEnumMsmDependency;
const GUID IID_IEnumMsmError                           = GUIDOF!IEnumMsmError;
const GUID IID_IEnumMsmString                          = GUIDOF!IEnumMsmString;
const GUID IID_IMsmDependencies                        = GUIDOF!IMsmDependencies;
const GUID IID_IMsmDependency                          = GUIDOF!IMsmDependency;
const GUID IID_IMsmError                               = GUIDOF!IMsmError;
const GUID IID_IMsmErrors                              = GUIDOF!IMsmErrors;
const GUID IID_IMsmGetFiles                            = GUIDOF!IMsmGetFiles;
const GUID IID_IMsmMerge                               = GUIDOF!IMsmMerge;
const GUID IID_IMsmStrings                             = GUIDOF!IMsmStrings;
const GUID IID_IPMApplicationInfo                      = GUIDOF!IPMApplicationInfo;
const GUID IID_IPMApplicationInfoEnumerator            = GUIDOF!IPMApplicationInfoEnumerator;
const GUID IID_IPMBackgroundServiceAgentInfo           = GUIDOF!IPMBackgroundServiceAgentInfo;
const GUID IID_IPMBackgroundServiceAgentInfoEnumerator = GUIDOF!IPMBackgroundServiceAgentInfoEnumerator;
const GUID IID_IPMBackgroundWorkerInfo                 = GUIDOF!IPMBackgroundWorkerInfo;
const GUID IID_IPMBackgroundWorkerInfoEnumerator       = GUIDOF!IPMBackgroundWorkerInfoEnumerator;
const GUID IID_IPMDeploymentManager                    = GUIDOF!IPMDeploymentManager;
const GUID IID_IPMEnumerationManager                   = GUIDOF!IPMEnumerationManager;
const GUID IID_IPMExtensionCachedFileUpdaterInfo       = GUIDOF!IPMExtensionCachedFileUpdaterInfo;
const GUID IID_IPMExtensionContractInfo                = GUIDOF!IPMExtensionContractInfo;
const GUID IID_IPMExtensionFileExtensionInfo           = GUIDOF!IPMExtensionFileExtensionInfo;
const GUID IID_IPMExtensionFileOpenPickerInfo          = GUIDOF!IPMExtensionFileOpenPickerInfo;
const GUID IID_IPMExtensionFileSavePickerInfo          = GUIDOF!IPMExtensionFileSavePickerInfo;
const GUID IID_IPMExtensionInfo                        = GUIDOF!IPMExtensionInfo;
const GUID IID_IPMExtensionInfoEnumerator              = GUIDOF!IPMExtensionInfoEnumerator;
const GUID IID_IPMExtensionProtocolInfo                = GUIDOF!IPMExtensionProtocolInfo;
const GUID IID_IPMExtensionShareTargetInfo             = GUIDOF!IPMExtensionShareTargetInfo;
const GUID IID_IPMLiveTileJobInfo                      = GUIDOF!IPMLiveTileJobInfo;
const GUID IID_IPMLiveTileJobInfoEnumerator            = GUIDOF!IPMLiveTileJobInfoEnumerator;
const GUID IID_IPMTaskInfo                             = GUIDOF!IPMTaskInfo;
const GUID IID_IPMTaskInfoEnumerator                   = GUIDOF!IPMTaskInfoEnumerator;
const GUID IID_IPMTileInfo                             = GUIDOF!IPMTileInfo;
const GUID IID_IPMTileInfoEnumerator                   = GUIDOF!IPMTileInfoEnumerator;
const GUID IID_IPMTilePropertyEnumerator               = GUIDOF!IPMTilePropertyEnumerator;
const GUID IID_IPMTilePropertyInfo                     = GUIDOF!IPMTilePropertyInfo;
const GUID IID_IValidate                               = GUIDOF!IValidate;
