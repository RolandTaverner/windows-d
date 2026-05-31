// Written in the D programming language.

module windows.win32.security.applocker;

public import windows.core;
public import system : Guid;
public import windows.win32.foundation : BOOL, BOOLEAN, FILETIME, HANDLE, HWND, PWSTR;
public import windows.win32.security.cryptography : ALG_ID;
public import windows.win32.security : SAFER_LEVEL_HANDLE;

extern(Windows) @nogc nothrow:


// Enums

alias SAFER_COMPUTE_TOKEN_FROM_LEVEL_FLAGS = uint;
enum : uint
{
    SAFER_TOKEN_NULL_IF_EQUAL = 0x00000001,
    SAFER_TOKEN_COMPARE_ONLY  = 0x00000002,
    SAFER_TOKEN_MAKE_INERT    = 0x00000004,
    SAFER_TOKEN_WANT_FLAGS    = 0x00000008,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsafer/ne-winsafer-safer_policy_info_class))], [])
alias SAFER_POLICY_INFO_CLASS = int;
enum : int
{
    SaferPolicyLevelList                    = 0x00000001,
    SaferPolicyEnableTransparentEnforcement = 0x00000002,
    SaferPolicyDefaultLevel                 = 0x00000003,
    SaferPolicyEvaluateUserScope            = 0x00000004,
    SaferPolicyScopeFlags                   = 0x00000005,
    SaferPolicyDefaultLevelFlags            = 0x00000006,
    SaferPolicyAuthenticodeEnabled          = 0x00000007,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsafer/ne-winsafer-safer_object_info_class))], [])
alias SAFER_OBJECT_INFO_CLASS = int;
enum : int
{
    SaferObjectLevelId                 = 0x00000001,
    SaferObjectScopeId                 = 0x00000002,
    SaferObjectFriendlyName            = 0x00000003,
    SaferObjectDescription             = 0x00000004,
    SaferObjectBuiltin                 = 0x00000005,
    SaferObjectDisallowed              = 0x00000006,
    SaferObjectDisableMaxPrivilege     = 0x00000007,
    SaferObjectInvertDeletedPrivileges = 0x00000008,
    SaferObjectDeletedPrivileges       = 0x00000009,
    SaferObjectDefaultOwner            = 0x0000000a,
    SaferObjectSidsToDisable           = 0x0000000b,
    SaferObjectRestrictedSidsInverted  = 0x0000000c,
    SaferObjectRestrictedSidsAdded     = 0x0000000d,
    SaferObjectAllIdentificationGuids  = 0x0000000e,
    SaferObjectSingleIdentification    = 0x0000000f,
    SaferObjectExtendedError           = 0x00000010,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsafer/ne-winsafer-safer_identification_types))], [])
alias SAFER_IDENTIFICATION_TYPES = int;
enum : int
{
    SaferIdentityDefault         = 0x00000000,
    SaferIdentityTypeImageName   = 0x00000001,
    SaferIdentityTypeImageHash   = 0x00000002,
    SaferIdentityTypeUrlZone     = 0x00000003,
    SaferIdentityTypeCertificate = 0x00000004,
}

// Constants


enum : uint
{
    SAFER_SCOPEID_MACHINE = 0x00000001,
    SAFER_SCOPEID_USER    = 0x00000002,
}

enum : uint
{
    SAFER_LEVELID_FULLYTRUSTED = 0x00040000,
    SAFER_LEVELID_NORMALUSER   = 0x00020000,
    SAFER_LEVELID_CONSTRAINED  = 0x00010000,
    SAFER_LEVELID_UNTRUSTED    = 0x00001000,
    SAFER_LEVELID_DISALLOWED   = 0x00000000,
    SAFER_LEVEL_OPEN           = 0x00000001,
}

enum uint SAFER_MAX_FRIENDLYNAME_SIZE = 0x00000100;
enum uint SAFER_MAX_DESCRIPTION_SIZE = 0x00000100;
enum uint SAFER_MAX_HASH_SIZE = 0x00000040;

enum : uint
{
    SAFER_CRITERIA_IMAGEPATH    = 0x00000001,
    SAFER_CRITERIA_NOSIGNEDHASH = 0x00000002,
    SAFER_CRITERIA_IMAGEHASH    = 0x00000004,
    SAFER_CRITERIA_AUTHENTICODE = 0x00000008,
    SAFER_CRITERIA_URLZONE      = 0x00000010,
    SAFER_CRITERIA_APPX_PACKAGE = 0x00000020,
    SAFER_CRITERIA_IMAGEPATH_NT = 0x00001000,
}

enum : uint
{
    SAFER_POLICY_JOBID_MASK                 = 0xff000000,
    SAFER_POLICY_JOBID_CONSTRAINED          = 0x04000000,
    SAFER_POLICY_JOBID_UNTRUSTED            = 0x03000000,
    SAFER_POLICY_ONLY_EXES                  = 0x00010000,
    SAFER_POLICY_SANDBOX_INERT              = 0x00020000,
    SAFER_POLICY_HASH_DUPLICATE             = 0x00040000,
    SAFER_POLICY_ONLY_AUDIT                 = 0x00001000,
    SAFER_POLICY_BLOCK_CLIENT_UI            = 0x00002000,
    SAFER_POLICY_UIFLAGS_MASK               = 0x000000ff,
    SAFER_POLICY_UIFLAGS_INFORMATION_PROMPT = 0x00000001,
    SAFER_POLICY_UIFLAGS_OPTION_PROMPT      = 0x00000002,
    SAFER_POLICY_UIFLAGS_HIDDEN             = 0x00000004,
}

enum : const(wchar)*
{
    SRP_POLICY_EXE              = "EXE",
    SRP_POLICY_DLL              = "DLL",
    SRP_POLICY_MSI              = "MSI",
    SRP_POLICY_SCRIPT           = "SCRIPT",
    SRP_POLICY_SHELL            = "SHELL",
    SRP_POLICY_NOV2             = "IGNORESRPV2",
    SRP_POLICY_APPX             = "APPX",
    SRP_POLICY_WLDPMSI          = "WLDPMSI",
    SRP_POLICY_WLDPSCRIPT       = "WLDPSCRIPT",
    SRP_POLICY_WLDPCONFIGCI     = "WLDPCONFIGCI",
    SRP_POLICY_MANAGEDINSTALLER = "MANAGEDINSTALLER",
}

// Structs


//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsafer/ns-winsafer-safer_code_properties_v1))], [])
struct SAFER_CODE_PROPERTIES_V1
{
    uint         cbSize;
    uint         dwCheckFlags;
    const(PWSTR) ImagePath;
    HANDLE       hImageFileHandle;
    uint         UrlZoneId;
    ubyte[64]    ImageHash;
    uint         dwImageHashSize;
    long         ImageSize;
    ALG_ID       HashAlgorithm;
    ubyte*       pByteBlock;
    HWND         hWndParent;
    uint         dwWVTUIChoice;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsafer/ns-winsafer-safer_code_properties_v2))], [])
struct SAFER_CODE_PROPERTIES_V2
{
    uint         cbSize;
    uint         dwCheckFlags;
    const(PWSTR) ImagePath;
    HANDLE       hImageFileHandle;
    uint         UrlZoneId;
    ubyte[64]    ImageHash;
    uint         dwImageHashSize;
    long         ImageSize;
    ALG_ID       HashAlgorithm;
    ubyte*       pByteBlock;
    HWND         hWndParent;
    uint         dwWVTUIChoice;
    const(PWSTR) PackageMoniker;
    const(PWSTR) PackagePublisher;
    const(PWSTR) PackageName;
    ulong        PackageVersion;
    BOOL         PackageIsFramework;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsafer/ns-winsafer-safer_identification_header))], [])
struct SAFER_IDENTIFICATION_HEADER
{
    SAFER_IDENTIFICATION_TYPES dwIdentificationType;
    uint     cbStructSize;
    GUID     IdentificationGuid;
    FILETIME lastModified;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsafer/ns-winsafer-safer_pathname_identification))], [])
struct SAFER_PATHNAME_IDENTIFICATION
{
    SAFER_IDENTIFICATION_HEADER header;
    wchar[256] Description;
    /*FIELD ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PWSTR ImageName;
    uint       dwSaferFlags;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsafer/ns-winsafer-safer_hash_identification))], [])
struct SAFER_HASH_IDENTIFICATION
{
    SAFER_IDENTIFICATION_HEADER header;
    wchar[256] Description;
    wchar[256] FriendlyName;
    uint       HashSize;
    ubyte[64]  ImageHash;
    ALG_ID     HashAlgorithm;
    long       ImageSize;
    uint       dwSaferFlags;
}

struct SAFER_HASH_IDENTIFICATION2
{
    SAFER_HASH_IDENTIFICATION hashIdentification;
    uint      HashSize;
    ubyte[64] ImageHash;
    ALG_ID    HashAlgorithm;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsafer/ns-winsafer-safer_urlzone_identification))], [])
struct SAFER_URLZONE_IDENTIFICATION
{
    SAFER_IDENTIFICATION_HEADER header;
    uint UrlZoneId;
    uint dwSaferFlags;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL SaferGetPolicyInformation(uint dwScopeId, SAFER_POLICY_INFO_CLASS SaferPolicyInfoClass, uint InfoBufferSize, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* InfoBuffer, 
                               uint* InfoBufferRetSize, 
                               /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* lpReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL SaferSetPolicyInformation(uint dwScopeId, SAFER_POLICY_INFO_CLASS SaferPolicyInfoClass, uint InfoBufferSize, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* InfoBuffer, 
                               /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* lpReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL SaferCreateLevel(uint dwScopeId, uint dwLevelId, uint OpenFlags, SAFER_LEVEL_HANDLE* pLevelHandle, 
                      /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* lpReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL SaferCloseLevel(SAFER_LEVEL_HANDLE hLevelHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL SaferIdentifyLevel(uint dwNumProperties, SAFER_CODE_PROPERTIES_V2* pCodeProperties, 
                        SAFER_LEVEL_HANDLE* pLevelHandle, void* lpReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL SaferComputeTokenFromLevel(SAFER_LEVEL_HANDLE LevelHandle, HANDLE InAccessToken, HANDLE* OutAccessToken, 
                                SAFER_COMPUTE_TOKEN_FROM_LEVEL_FLAGS dwFlags, void* lpReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL SaferGetLevelInformation(SAFER_LEVEL_HANDLE LevelHandle, SAFER_OBJECT_INFO_CLASS dwInfoType, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpQueryBuffer, 
                              uint dwInBufferSize, uint* lpdwOutBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL SaferSetLevelInformation(SAFER_LEVEL_HANDLE LevelHandle, SAFER_OBJECT_INFO_CLASS dwInfoType, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpQueryBuffer, 
                              uint dwInBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL SaferRecordEventLogEntry(SAFER_LEVEL_HANDLE hLevel, const(PWSTR) szTargetPath, 
                              /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* lpReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL SaferiIsExecutableFileType(const(PWSTR) szFullPathname, BOOLEAN bFromShellExecute);


