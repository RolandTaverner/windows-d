// Written in the D programming language.

module windows.win32.storage.packaging.appx;

public import windows.core;
public import windows.win32.data.xml.msxml : IXMLDOMDocument;
public import windows.win32.foundation : BOOL, FILETIME, HANDLE, HRESULT, PSTR, PWSTR,
                                         WIN32_ERROR;
public import windows.win32.security : PSID;
public import windows.win32.system.com : IStream, IUnknown, IUri;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/ne-appxpackaging-appx_compression_option
alias APPX_COMPRESSION_OPTION = int;
enum : int
{
    APPX_COMPRESSION_OPTION_NONE      = 0x00000000,
    APPX_COMPRESSION_OPTION_NORMAL    = 0x00000001,
    APPX_COMPRESSION_OPTION_MAXIMUM   = 0x00000002,
    APPX_COMPRESSION_OPTION_FAST      = 0x00000003,
    APPX_COMPRESSION_OPTION_SUPERFAST = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/ne-appxpackaging-appx_footprint_file_type
alias APPX_FOOTPRINT_FILE_TYPE = int;
enum : int
{
    APPX_FOOTPRINT_FILE_TYPE_MANIFEST        = 0x00000000,
    APPX_FOOTPRINT_FILE_TYPE_BLOCKMAP        = 0x00000001,
    APPX_FOOTPRINT_FILE_TYPE_SIGNATURE       = 0x00000002,
    APPX_FOOTPRINT_FILE_TYPE_CODEINTEGRITY   = 0x00000003,
    APPX_FOOTPRINT_FILE_TYPE_CONTENTGROUPMAP = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/ne-appxpackaging-appx_bundle_footprint_file_type
alias APPX_BUNDLE_FOOTPRINT_FILE_TYPE = int;
enum : int
{
    APPX_BUNDLE_FOOTPRINT_FILE_TYPE_FIRST     = 0x00000000,
    APPX_BUNDLE_FOOTPRINT_FILE_TYPE_MANIFEST  = 0x00000000,
    APPX_BUNDLE_FOOTPRINT_FILE_TYPE_BLOCKMAP  = 0x00000001,
    APPX_BUNDLE_FOOTPRINT_FILE_TYPE_SIGNATURE = 0x00000002,
    APPX_BUNDLE_FOOTPRINT_FILE_TYPE_LAST      = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/ne-appxpackaging-appx_capabilities
alias APPX_CAPABILITIES = int;
enum : int
{
    APPX_CAPABILITY_INTERNET_CLIENT               = 0x00000001,
    APPX_CAPABILITY_INTERNET_CLIENT_SERVER        = 0x00000002,
    APPX_CAPABILITY_PRIVATE_NETWORK_CLIENT_SERVER = 0x00000004,
    APPX_CAPABILITY_DOCUMENTS_LIBRARY             = 0x00000008,
    APPX_CAPABILITY_PICTURES_LIBRARY              = 0x00000010,
    APPX_CAPABILITY_VIDEOS_LIBRARY                = 0x00000020,
    APPX_CAPABILITY_MUSIC_LIBRARY                 = 0x00000040,
    APPX_CAPABILITY_ENTERPRISE_AUTHENTICATION     = 0x00000080,
    APPX_CAPABILITY_SHARED_USER_CERTIFICATES      = 0x00000100,
    APPX_CAPABILITY_REMOVABLE_STORAGE             = 0x00000200,
    APPX_CAPABILITY_APPOINTMENTS                  = 0x00000400,
    APPX_CAPABILITY_CONTACTS                      = 0x00000800,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/ne-appxpackaging-appx_package_architecture
alias APPX_PACKAGE_ARCHITECTURE = int;
enum : int
{
    APPX_PACKAGE_ARCHITECTURE_X86     = 0x00000000,
    APPX_PACKAGE_ARCHITECTURE_ARM     = 0x00000005,
    APPX_PACKAGE_ARCHITECTURE_X64     = 0x00000009,
    APPX_PACKAGE_ARCHITECTURE_NEUTRAL = 0x0000000b,
    APPX_PACKAGE_ARCHITECTURE_ARM64   = 0x0000000c,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/ne-appxpackaging-appx_package_architecture2
alias APPX_PACKAGE_ARCHITECTURE2 = int;
enum : int
{
    APPX_PACKAGE_ARCHITECTURE2_X86          = 0x00000000,
    APPX_PACKAGE_ARCHITECTURE2_ARM          = 0x00000005,
    APPX_PACKAGE_ARCHITECTURE2_X64          = 0x00000009,
    APPX_PACKAGE_ARCHITECTURE2_NEUTRAL      = 0x0000000b,
    APPX_PACKAGE_ARCHITECTURE2_ARM64        = 0x0000000c,
    APPX_PACKAGE_ARCHITECTURE2_X86_ON_ARM64 = 0x0000000e,
    APPX_PACKAGE_ARCHITECTURE2_UNKNOWN      = 0x0000ffff,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/ne-appxpackaging-appx_bundle_payload_package_type
alias APPX_BUNDLE_PAYLOAD_PACKAGE_TYPE = int;
enum : int
{
    APPX_BUNDLE_PAYLOAD_PACKAGE_TYPE_APPLICATION = 0x00000000,
    APPX_BUNDLE_PAYLOAD_PACKAGE_TYPE_RESOURCE    = 0x00000001,
}

alias DX_FEATURE_LEVEL = int;
enum : int
{
    DX_FEATURE_LEVEL_UNSPECIFIED = 0x00000000,
    DX_FEATURE_LEVEL_9           = 0x00000001,
    DX_FEATURE_LEVEL_10          = 0x00000002,
    DX_FEATURE_LEVEL_11          = 0x00000003,
}

alias APPX_CAPABILITY_CLASS_TYPE = int;
enum : int
{
    APPX_CAPABILITY_CLASS_DEFAULT    = 0x00000000,
    APPX_CAPABILITY_CLASS_GENERAL    = 0x00000001,
    APPX_CAPABILITY_CLASS_RESTRICTED = 0x00000002,
    APPX_CAPABILITY_CLASS_WINDOWS    = 0x00000004,
    APPX_CAPABILITY_CLASS_ALL        = 0x00000007,
    APPX_CAPABILITY_CLASS_CUSTOM     = 0x00000008,
}

alias APPX_PACKAGING_CONTEXT_CHANGE_TYPE = int;
enum : int
{
    APPX_PACKAGING_CONTEXT_CHANGE_TYPE_START   = 0x00000000,
    APPX_PACKAGING_CONTEXT_CHANGE_TYPE_CHANGE  = 0x00000001,
    APPX_PACKAGING_CONTEXT_CHANGE_TYPE_DETAILS = 0x00000002,
    APPX_PACKAGING_CONTEXT_CHANGE_TYPE_END     = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/ne-appxpackaging-appx_encrypted_package_options
alias APPX_ENCRYPTED_PACKAGE_OPTIONS = int;
enum : int
{
    APPX_ENCRYPTED_PACKAGE_OPTION_NONE         = 0x00000000,
    APPX_ENCRYPTED_PACKAGE_OPTION_DIFFUSION    = 0x00000001,
    APPX_ENCRYPTED_PACKAGE_OPTION_PAGE_HASHING = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/ne-appxpackaging-appx_package_editor_update_package_option
alias APPX_PACKAGE_EDITOR_UPDATE_PACKAGE_OPTION = int;
enum : int
{
    APPX_PACKAGE_EDITOR_UPDATE_PACKAGE_OPTION_APPEND_DELTA = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/ne-appxpackaging-appx_package_editor_update_package_manifest_options
alias APPX_PACKAGE_EDITOR_UPDATE_PACKAGE_MANIFEST_OPTIONS = int;
enum : int
{
    APPX_PACKAGE_EDITOR_UPDATE_PACKAGE_MANIFEST_OPTION_NONE            = 0x00000000,
    APPX_PACKAGE_EDITOR_UPDATE_PACKAGE_MANIFEST_OPTION_SKIP_VALIDATION = 0x00000001,
    APPX_PACKAGE_EDITOR_UPDATE_PACKAGE_MANIFEST_OPTION_LOCALIZED       = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appmodel/ne-appmodel-packagepathtype
enum PackagePathType : int
{
    PackagePathType_Install           = 0x00000000,
    PackagePathType_Mutable           = 0x00000001,
    PackagePathType_Effective         = 0x00000002,
    PackagePathType_MachineExternal   = 0x00000003,
    PackagePathType_UserExternal      = 0x00000004,
    PackagePathType_EffectiveExternal = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appmodel/ne-appmodel-packageorigin
enum PackageOrigin : int
{
    PackageOrigin_Unknown           = 0x00000000,
    PackageOrigin_Unsigned          = 0x00000001,
    PackageOrigin_Inbox             = 0x00000002,
    PackageOrigin_Store             = 0x00000003,
    PackageOrigin_DeveloperUnsigned = 0x00000004,
    PackageOrigin_DeveloperSigned   = 0x00000005,
    PackageOrigin_LineOfBusiness    = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appmodel/ne-appmodel-createpackagedependencyoptions
enum CreatePackageDependencyOptions : int
{
    CreatePackageDependencyOptions_None                            = 0x00000000,
    CreatePackageDependencyOptions_DoNotVerifyDependencyResolution = 0x00000001,
    CreatePackageDependencyOptions_ScopeIsSystem                   = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appmodel/ne-appmodel-packagedependencylifetimekind
enum PackageDependencyLifetimeKind : int
{
    PackageDependencyLifetimeKind_Process     = 0x00000000,
    PackageDependencyLifetimeKind_FilePath    = 0x00000001,
    PackageDependencyLifetimeKind_RegistryKey = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appmodel/ne-appmodel-addpackagedependencyoptions
enum AddPackageDependencyOptions : int
{
    AddPackageDependencyOptions_None                   = 0x00000000,
    AddPackageDependencyOptions_PrependIfRankCollision = 0x00000001,
}

alias AddPackageDependencyOptions2 = int;
enum : int
{
    AddPackageDependencyOptions2_None                       = 0x00000000,
    AddPackageDependencyOptions2_PrependIfRankCollision     = 0x00000001,
    AddPackageDependencyOptions2_SpecifiedPackageFamilyOnly = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appmodel/ne-appmodel-packagedependencyprocessorarchitectures
enum PackageDependencyProcessorArchitectures : int
{
    PackageDependencyProcessorArchitectures_None    = 0x00000000,
    PackageDependencyProcessorArchitectures_Neutral = 0x00000001,
    PackageDependencyProcessorArchitectures_X86     = 0x00000002,
    PackageDependencyProcessorArchitectures_X64     = 0x00000004,
    PackageDependencyProcessorArchitectures_Arm     = 0x00000008,
    PackageDependencyProcessorArchitectures_Arm64   = 0x00000010,
    PackageDependencyProcessorArchitectures_X86A64  = 0x00000020,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appmodel/ne-appmodel-apppolicylifecyclemanagement
enum AppPolicyLifecycleManagement : int
{
    AppPolicyLifecycleManagement_Unmanaged = 0x00000000,
    AppPolicyLifecycleManagement_Managed   = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appmodel/ne-appmodel-apppolicywindowingmodel
enum AppPolicyWindowingModel : int
{
    AppPolicyWindowingModel_None           = 0x00000000,
    AppPolicyWindowingModel_Universal      = 0x00000001,
    AppPolicyWindowingModel_ClassicDesktop = 0x00000002,
    AppPolicyWindowingModel_ClassicPhone   = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appmodel/ne-appmodel-apppolicymediafoundationcodecloading
enum AppPolicyMediaFoundationCodecLoading : int
{
    AppPolicyMediaFoundationCodecLoading_All       = 0x00000000,
    AppPolicyMediaFoundationCodecLoading_InboxOnly = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appmodel/ne-appmodel-apppolicyclrcompat
enum AppPolicyClrCompat : int
{
    AppPolicyClrCompat_Other           = 0x00000000,
    AppPolicyClrCompat_ClassicDesktop  = 0x00000001,
    AppPolicyClrCompat_Universal       = 0x00000002,
    AppPolicyClrCompat_PackagedDesktop = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appmodel/ne-appmodel-apppolicythreadinitializationtype
enum AppPolicyThreadInitializationType : int
{
    AppPolicyThreadInitializationType_None            = 0x00000000,
    AppPolicyThreadInitializationType_InitializeWinRT = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appmodel/ne-appmodel-apppolicyshowdeveloperdiagnostic
enum AppPolicyShowDeveloperDiagnostic : int
{
    AppPolicyShowDeveloperDiagnostic_None   = 0x00000000,
    AppPolicyShowDeveloperDiagnostic_ShowUI = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appmodel/ne-appmodel-apppolicyprocessterminationmethod
enum AppPolicyProcessTerminationMethod : int
{
    AppPolicyProcessTerminationMethod_ExitProcess      = 0x00000000,
    AppPolicyProcessTerminationMethod_TerminateProcess = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appmodel/ne-appmodel-apppolicycreatefileaccess
enum AppPolicyCreateFileAccess : int
{
    AppPolicyCreateFileAccess_Full    = 0x00000000,
    AppPolicyCreateFileAccess_Limited = 0x00000001,
}

enum PackageInfo3Type : int
{
    PackageInfo3Type_PackageInfoGeneration = 0x00000010,
}

// Constants


enum : uint
{
    PACKAGE_FULL_NAME_MIN_LENGTH = 0x0000001eU,
    PACKAGE_FULL_NAME_MAX_LENGTH = 0x0000007fU,
}

enum : uint
{
    PACKAGE_FAMILY_NAME_MIN_LENGTH = 0x00000011U,
    PACKAGE_FAMILY_NAME_MAX_LENGTH = 0x00000040U,
}

enum uint PACKAGE_GRAPH_MAX_SIZE = 0x00000281U;

enum : uint
{
    APPLICATION_USER_MODEL_ID_MIN_LENGTH = 0x00000014U,
    APPLICATION_USER_MODEL_ID_MAX_LENGTH = 0x00000082U,
}

enum : uint
{
    PACKAGE_PROPERTY_FRAMEWORK = 0x00000001U,
    PACKAGE_PROPERTY_RESOURCE  = 0x00000002U,
    PACKAGE_PROPERTY_BUNDLE    = 0x00000004U,
    PACKAGE_PROPERTY_OPTIONAL  = 0x00000008U,
}

enum : uint
{
    PACKAGE_FILTER_HEAD     = 0x00000010U,
    PACKAGE_FILTER_DIRECT   = 0x00000020U,
    PACKAGE_FILTER_RESOURCE = 0x00000040U,
    PACKAGE_FILTER_BUNDLE   = 0x00000080U,
}

enum : uint
{
    PACKAGE_INFORMATION_BASIC = 0x00000000U,
    PACKAGE_INFORMATION_FULL  = 0x00000100U,
}

enum uint PACKAGE_PROPERTY_DEVELOPMENT_MODE = 0x00010000U;
enum uint PACKAGE_FILTER_OPTIONAL = 0x00020000U;
enum uint PACKAGE_PROPERTY_IS_IN_RELATED_SET = 0x00040000U;
enum uint PACKAGE_FILTER_IS_IN_RELATED_SET = 0x00040000U;
enum uint PACKAGE_PROPERTY_STATIC = 0x00080000U;
enum uint PACKAGE_FILTER_STATIC = 0x00080000U;
enum uint PACKAGE_PROPERTY_DYNAMIC = 0x00100000U;
enum uint PACKAGE_FILTER_DYNAMIC = 0x00100000U;
enum uint PACKAGE_PROPERTY_HOSTRUNTIME = 0x00200000U;

enum : uint
{
    PACKAGE_FILTER_HOSTRUNTIME = 0x00200000U,
    PACKAGE_FILTER_ALL_LOADED  = 0x00000000U,
}

enum uint PACKAGE_DEPENDENCY_RANK_DEFAULT = 0x00000000U;

enum : uint
{
    PACKAGE_ARCHITECTURE_MIN_LENGTH = 0x00000003U,
    PACKAGE_ARCHITECTURE_MAX_LENGTH = 0x00000007U,
}

enum : uint
{
    PACKAGE_VERSION_MIN_LENGTH = 0x00000007U,
    PACKAGE_VERSION_MAX_LENGTH = 0x00000017U,
}

enum : uint
{
    PACKAGE_NAME_MIN_LENGTH = 0x00000003U,
    PACKAGE_NAME_MAX_LENGTH = 0x00000032U,
}

enum : uint
{
    PACKAGE_PUBLISHER_MIN_LENGTH   = 0x00000003U,
    PACKAGE_PUBLISHER_MAX_LENGTH   = 0x00002000U,
    PACKAGE_PUBLISHERID_MIN_LENGTH = 0x0000000dU,
    PACKAGE_PUBLISHERID_MAX_LENGTH = 0x0000000dU,
}

enum : uint
{
    PACKAGE_RESOURCEID_MIN_LENGTH = 0x00000000U,
    PACKAGE_RESOURCEID_MAX_LENGTH = 0x0000001eU,
}

enum uint PACKAGE_MIN_DEPENDENCIES = 0x00000000U;
enum uint PACKAGE_MAX_DEPENDENCIES = 0x00000080U;

enum : uint
{
    PACKAGE_FAMILY_MIN_RESOURCE_PACKAGES = 0x00000000U,
    PACKAGE_FAMILY_MAX_RESOURCE_PACKAGES = 0x00000200U,
}

enum uint PACKAGE_GRAPH_MIN_SIZE = 0x00000001U;

enum : uint
{
    PACKAGE_APPLICATIONS_MIN_COUNT = 0x00000000U,
    PACKAGE_APPLICATIONS_MAX_COUNT = 0x00000064U,
}

enum : uint
{
    PACKAGE_RELATIVE_APPLICATION_ID_MIN_LENGTH = 0x00000002U,
    PACKAGE_RELATIVE_APPLICATION_ID_MAX_LENGTH = 0x00000041U,
}

// Structs


struct PACKAGE_VIRTUALIZATION_CONTEXT_HANDLE
{
    void* Value;
}

struct PACKAGEDEPENDENCY_CONTEXT
{
    void* Value;
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appmodel/ns-appmodel-package_id
    struct PACKAGE_ID
    {
    align (4):
        uint            reserved;
        uint            processorArchitecture;
        PACKAGE_VERSION version_;
        PWSTR           name;
        PWSTR           publisher;
        PWSTR           resourceId;
        PWSTR           publisherId;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appmodel/ns-appmodel-package_id
    struct PACKAGE_ID
    {
    align (4):
        uint            reserved;
        uint            processorArchitecture;
        PACKAGE_VERSION version_;
        PWSTR           name;
        PWSTR           publisher;
        PWSTR           resourceId;
        PWSTR           publisherId;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appmodel/ns-appmodel-package_info
    struct PACKAGE_INFO
    {
    align (4):
        uint       reserved;
        uint       flags;
        PWSTR      path;
        PWSTR      packageFullName;
        PWSTR      packageFamilyName;
        PACKAGE_ID packageId;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appmodel/ns-appmodel-package_info
    struct PACKAGE_INFO
    {
    align (4):
        uint       reserved;
        uint       flags;
        PWSTR      path;
        PWSTR      packageFullName;
        PWSTR      packageFamilyName;
        PACKAGE_ID packageId;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/ns-appxpackaging-appx_package_settings
struct APPX_PACKAGE_SETTINGS
{
    BOOL forceZip32;
    IUri hashMethod;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/ns-appxpackaging-appx_package_writer_payload_stream
struct APPX_PACKAGE_WRITER_PAYLOAD_STREAM
{
    IStream      inputStream;
    const(PWSTR) fileName;
    const(PWSTR) contentType;
    APPX_COMPRESSION_OPTION compressionOption;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/ns-appxpackaging-appx_encrypted_package_settings
struct APPX_ENCRYPTED_PACKAGE_SETTINGS
{
    uint         keyLength;
    const(PWSTR) encryptionAlgorithm;
    BOOL         useDiffusion;
    IUri         blockMapHashAlgorithm;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/ns-appxpackaging-appx_encrypted_package_settings2
struct APPX_ENCRYPTED_PACKAGE_SETTINGS2
{
    uint         keyLength;
    const(PWSTR) encryptionAlgorithm;
    IUri         blockMapHashAlgorithm;
    uint         options;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/ns-appxpackaging-appx_key_info
struct APPX_KEY_INFO
{
    uint   keyLength;
    uint   keyIdLength;
    ubyte* key;
    ubyte* keyId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/ns-appxpackaging-appx_encrypted_exemptions
struct APPX_ENCRYPTED_EXEMPTIONS
{
    uint          count;
    const(PWSTR)* plainTextFiles;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appmodel/ns-appmodel-package_version
struct PACKAGE_VERSION
{
    union
    {
    align (4):
        ulong Version;
        struct
        {
            ushort Revision;
            ushort Build;
            ushort Minor;
            ushort Major;
        }
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appmodel/ns-appmodel-package_id
    struct PACKAGE_ID
    {
        uint            reserved;
        uint            processorArchitecture;
        PACKAGE_VERSION version_;
        PWSTR           name;
        PWSTR           publisher;
        PWSTR           resourceId;
        PWSTR           publisherId;
    }
}

struct _PACKAGE_INFO_REFERENCE
{
    void* reserved;
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appmodel/ns-appmodel-package_info
    struct PACKAGE_INFO
    {
        uint       reserved;
        uint       flags;
        PWSTR      path;
        PWSTR      packageFullName;
        PWSTR      packageFamilyName;
        PACKAGE_ID packageId;
    }
}

struct FindPackageDependencyCriteria
{
    PSID         User;
    BOOL         ScopeIsSystem;
    const(PWSTR) PackageFamilyName;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("KERNEL32.dll")
WIN32_ERROR GetCurrentPackageId(uint* bufferLength, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/ubyte* buffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("KERNEL32.dll")
WIN32_ERROR GetCurrentPackageFullName(uint* packageFullNameLength, PWSTR packageFullName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("KERNEL32.dll")
WIN32_ERROR GetCurrentPackageFamilyName(uint* packageFamilyNameLength, PWSTR packageFamilyName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("KERNEL32.dll")
WIN32_ERROR GetCurrentPackagePath(uint* pathLength, PWSTR path);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("KERNEL32.dll")
WIN32_ERROR GetPackageId(HANDLE hProcess, uint* bufferLength, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/ubyte* buffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("KERNEL32.dll")
WIN32_ERROR GetPackageFullName(HANDLE hProcess, uint* packageFullNameLength, PWSTR packageFullName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-appmodel-runtime-l1-1-1.dll")
WIN32_ERROR GetPackageFullNameFromToken(HANDLE token, uint* packageFullNameLength, PWSTR packageFullName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("KERNEL32.dll")
WIN32_ERROR GetPackageFamilyName(HANDLE hProcess, uint* packageFamilyNameLength, PWSTR packageFamilyName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-appmodel-runtime-l1-1-1.dll")
WIN32_ERROR GetPackageFamilyNameFromToken(HANDLE token, uint* packageFamilyNameLength, PWSTR packageFamilyName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("KERNEL32.dll")
WIN32_ERROR GetPackagePath(const(PACKAGE_ID)* packageId, 
                           /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/const(uint) reserved, 
                           uint* pathLength, PWSTR path);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("KERNEL32.dll")
WIN32_ERROR GetPackagePathByFullName(const(PWSTR) packageFullName, uint* pathLength, PWSTR path);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("KERNEL32.dll")
WIN32_ERROR GetStagedPackagePathByFullName(const(PWSTR) packageFullName, uint* pathLength, PWSTR path);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("api-ms-win-appmodel-runtime-l1-1-3.dll")
WIN32_ERROR GetPackagePathByFullName2(const(PWSTR) packageFullName, PackagePathType packagePathType, 
                                      uint* pathLength, PWSTR path);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("api-ms-win-appmodel-runtime-l1-1-3.dll")
WIN32_ERROR GetStagedPackagePathByFullName2(const(PWSTR) packageFullName, PackagePathType packagePathType, 
                                            uint* pathLength, PWSTR path);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("api-ms-win-appmodel-runtime-l1-1-3.dll")
WIN32_ERROR GetCurrentPackageInfo2(const(uint) flags, PackagePathType packagePathType, uint* bufferLength, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ubyte* buffer, 
                                   uint* count);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("api-ms-win-appmodel-runtime-l1-1-3.dll")
WIN32_ERROR GetCurrentPackagePath2(PackagePathType packagePathType, uint* pathLength, PWSTR path);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appmodel/nf-appmodel-getcurrentapplicationusermodelid
@DllImport("KERNEL32.dll")
WIN32_ERROR GetCurrentApplicationUserModelId(uint* applicationUserModelIdLength, PWSTR applicationUserModelId);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appmodel/nf-appmodel-getapplicationusermodelid
@DllImport("KERNEL32.dll")
WIN32_ERROR GetApplicationUserModelId(HANDLE hProcess, uint* applicationUserModelIdLength, 
                                      PWSTR applicationUserModelId);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appmodel/nf-appmodel-getapplicationusermodelidfromtoken
@DllImport("api-ms-win-appmodel-runtime-l1-1-1.dll")
WIN32_ERROR GetApplicationUserModelIdFromToken(HANDLE token, uint* applicationUserModelIdLength, 
                                               PWSTR applicationUserModelId);

@DllImport("api-ms-win-appmodel-runtime-l1-1-1.dll")
WIN32_ERROR VerifyPackageFullName(const(PWSTR) packageFullName);

@DllImport("api-ms-win-appmodel-runtime-l1-1-1.dll")
WIN32_ERROR VerifyPackageFamilyName(const(PWSTR) packageFamilyName);

@DllImport("api-ms-win-appmodel-runtime-l1-1-1.dll")
WIN32_ERROR VerifyPackageId(const(PACKAGE_ID)* packageId);

@DllImport("api-ms-win-appmodel-runtime-l1-1-1.dll")
WIN32_ERROR VerifyApplicationUserModelId(const(PWSTR) applicationUserModelId);

@DllImport("api-ms-win-appmodel-runtime-l1-1-1.dll")
WIN32_ERROR VerifyPackageRelativeApplicationId(const(PWSTR) packageRelativeApplicationId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("KERNEL32.dll")
WIN32_ERROR PackageIdFromFullName(const(PWSTR) packageFullName, const(uint) flags, uint* bufferLength, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ubyte* buffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("KERNEL32.dll")
WIN32_ERROR PackageFullNameFromId(const(PACKAGE_ID)* packageId, uint* packageFullNameLength, PWSTR packageFullName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("KERNEL32.dll")
WIN32_ERROR PackageFamilyNameFromId(const(PACKAGE_ID)* packageId, uint* packageFamilyNameLength, 
                                    PWSTR packageFamilyName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("KERNEL32.dll")
WIN32_ERROR PackageFamilyNameFromFullName(const(PWSTR) packageFullName, uint* packageFamilyNameLength, 
                                          PWSTR packageFamilyName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("KERNEL32.dll")
WIN32_ERROR PackageNameAndPublisherIdFromFamilyName(const(PWSTR) packageFamilyName, uint* packageNameLength, 
                                                    PWSTR packageName, uint* packagePublisherIdLength, 
                                                    PWSTR packagePublisherId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("KERNEL32.dll")
WIN32_ERROR FormatApplicationUserModelId(const(PWSTR) packageFamilyName, const(PWSTR) packageRelativeApplicationId, 
                                         uint* applicationUserModelIdLength, PWSTR applicationUserModelId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("KERNEL32.dll")
WIN32_ERROR ParseApplicationUserModelId(const(PWSTR) applicationUserModelId, uint* packageFamilyNameLength, 
                                        PWSTR packageFamilyName, uint* packageRelativeApplicationIdLength, 
                                        PWSTR packageRelativeApplicationId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("KERNEL32.dll")
WIN32_ERROR GetPackagesByPackageFamily(const(PWSTR) packageFamilyName, uint* count, PWSTR* packageFullNames, 
                                       uint* bufferLength, PWSTR buffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("KERNEL32.dll")
WIN32_ERROR FindPackagesByPackageFamily(const(PWSTR) packageFamilyName, uint packageFilters, uint* count, 
                                        PWSTR* packageFullNames, uint* bufferLength, PWSTR buffer, 
                                        uint* packageProperties);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("api-ms-win-appmodel-runtime-l1-1-1.dll")
WIN32_ERROR GetStagedPackageOrigin(const(PWSTR) packageFullName, PackageOrigin* origin);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("KERNEL32.dll")
WIN32_ERROR GetCurrentPackageInfo(const(uint) flags, uint* bufferLength, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/ubyte* buffer, 
                                  uint* count);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("KERNEL32.dll")
WIN32_ERROR OpenPackageInfoByFullName(const(PWSTR) packageFullName, 
                                      /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/const(uint) reserved, 
                                      _PACKAGE_INFO_REFERENCE** packageInfoReference);

@DllImport("api-ms-win-appmodel-runtime-l1-1-1.dll")
WIN32_ERROR OpenPackageInfoByFullNameForUser(PSID userSid, const(PWSTR) packageFullName, 
                                             /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/const(uint) reserved, 
                                             _PACKAGE_INFO_REFERENCE** packageInfoReference);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("KERNEL32.dll")
WIN32_ERROR ClosePackageInfo(_PACKAGE_INFO_REFERENCE* packageInfoReference);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("KERNEL32.dll")
WIN32_ERROR GetPackageInfo(_PACKAGE_INFO_REFERENCE* packageInfoReference, const(uint) flags, uint* bufferLength, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ubyte* buffer, 
                           uint* count);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("KERNEL32.dll")
WIN32_ERROR GetPackageApplicationIds(_PACKAGE_INFO_REFERENCE* packageInfoReference, uint* bufferLength, 
                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/ubyte* buffer, 
                                     uint* count);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("api-ms-win-appmodel-runtime-l1-1-3.dll")
WIN32_ERROR GetPackageInfo2(_PACKAGE_INFO_REFERENCE* packageInfoReference, const(uint) flags, 
                            PackagePathType packagePathType, uint* bufferLength, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* buffer, 
                            uint* count);

@DllImport("KERNEL32.dll")
HRESULT CheckIsMSIXPackage(const(PWSTR) packageFullName, BOOL* isMSIXPackage);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appmodel/nf-appmodel-trycreatepackagedependency
@DllImport("KERNELBASE.dll")
HRESULT TryCreatePackageDependency(PSID user, const(PWSTR) packageFamilyName, PACKAGE_VERSION minVersion, 
                                   PackageDependencyProcessorArchitectures packageDependencyProcessorArchitectures, 
                                   PackageDependencyLifetimeKind lifetimeKind, const(PWSTR) lifetimeArtifact, 
                                   CreatePackageDependencyOptions options, PWSTR* packageDependencyId);

@DllImport("api-ms-win-appmodel-runtime-l1-1-7.dll")
HRESULT TryCreatePackageDependency2(PSID user, const(PWSTR) packageFamilyName, PACKAGE_VERSION minVersion, 
                                    PackageDependencyProcessorArchitectures packageDependencyProcessorArchitectures, 
                                    PackageDependencyLifetimeKind lifetimeKind, const(PWSTR) lifetimeArtifact, 
                                    CreatePackageDependencyOptions options, const(FILETIME)* lifetimeExpiration, 
                                    PWSTR* packageDependencyId);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appmodel/nf-appmodel-deletepackagedependency
@DllImport("KERNELBASE.dll")
HRESULT DeletePackageDependency(const(PWSTR) packageDependencyId);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appmodel/nf-appmodel-addpackagedependency
@DllImport("KERNELBASE.dll")
HRESULT AddPackageDependency(const(PWSTR) packageDependencyId, int rank, AddPackageDependencyOptions options, 
                             PACKAGEDEPENDENCY_CONTEXT* packageDependencyContext, PWSTR* packageFullName);

@DllImport("api-ms-win-appmodel-runtime-l1-1-7.dll")
HRESULT AddPackageDependency2(const(PWSTR) packageDependencyId, int rank, AddPackageDependencyOptions2 options, 
                              PACKAGEDEPENDENCY_CONTEXT* packageDependencyContext, PWSTR* packageFullName);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appmodel/nf-appmodel-removepackagedependency
@DllImport("KERNELBASE.dll")
HRESULT RemovePackageDependency(PACKAGEDEPENDENCY_CONTEXT packageDependencyContext);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appmodel/nf-appmodel-getresolvedpackagefullnameforpackagedependency
@DllImport("KERNELBASE.dll")
HRESULT GetResolvedPackageFullNameForPackageDependency(const(PWSTR) packageDependencyId, PWSTR* packageFullName);

@DllImport("api-ms-win-appmodel-runtime-l1-1-7.dll")
HRESULT GetResolvedPackageFullNameForPackageDependency2(const(PWSTR) packageDependencyId, PWSTR* packageFullName);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appmodel/nf-appmodel-getidforpackagedependencycontext
@DllImport("KERNELBASE.dll")
HRESULT GetIdForPackageDependencyContext(PACKAGEDEPENDENCY_CONTEXT packageDependencyContext, 
                                         PWSTR* packageDependencyId);

@DllImport("api-ms-win-appmodel-runtime-l1-1-6.dll")
uint GetPackageGraphRevisionId();

@DllImport("api-ms-win-appmodel-runtime-l1-1-7.dll")
HRESULT FindPackageDependency(const(FindPackageDependencyCriteria)* findPackageDependencyCriteria, 
                              uint* packageDependencyIdsCount, PWSTR** packageDependencyIds);

@DllImport("api-ms-win-appmodel-runtime-l1-1-7.dll")
HRESULT GetPackageDependencyInformation(const(PWSTR) packageDependencyId, PSID* user, PWSTR* packageFamilyName, 
                                        PACKAGE_VERSION* minVersion, 
                                        PackageDependencyProcessorArchitectures* packageDependencyProcessorArchitectures, 
                                        PackageDependencyLifetimeKind* lifetimeKind, PWSTR* lifetimeArtifact, 
                                        CreatePackageDependencyOptions* options, FILETIME* lifetimeExpiration);

@DllImport("api-ms-win-appmodel-runtime-l1-1-7.dll")
HRESULT GetProcessesUsingPackageDependency(const(PWSTR) packageDependencyId, PSID user, BOOL scopeIsSystem, 
                                           uint* processIdsCount, uint** processIds);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appmodel/nf-appmodel-apppolicygetlifecyclemanagement
@DllImport("KERNEL32.dll")
WIN32_ERROR AppPolicyGetLifecycleManagement(HANDLE processToken, AppPolicyLifecycleManagement* policy);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appmodel/nf-appmodel-apppolicygetwindowingmodel
@DllImport("KERNEL32.dll")
WIN32_ERROR AppPolicyGetWindowingModel(HANDLE processToken, AppPolicyWindowingModel* policy);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appmodel/nf-appmodel-apppolicygetmediafoundationcodecloading
@DllImport("KERNEL32.dll")
WIN32_ERROR AppPolicyGetMediaFoundationCodecLoading(HANDLE processToken, 
                                                    AppPolicyMediaFoundationCodecLoading* policy);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appmodel/nf-appmodel-apppolicygetclrcompat
@DllImport("KERNEL32.dll")
WIN32_ERROR AppPolicyGetClrCompat(HANDLE processToken, AppPolicyClrCompat* policy);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appmodel/nf-appmodel-apppolicygetthreadinitializationtype
@DllImport("KERNEL32.dll")
WIN32_ERROR AppPolicyGetThreadInitializationType(HANDLE processToken, AppPolicyThreadInitializationType* policy);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appmodel/nf-appmodel-apppolicygetshowdeveloperdiagnostic
@DllImport("KERNEL32.dll")
WIN32_ERROR AppPolicyGetShowDeveloperDiagnostic(HANDLE processToken, AppPolicyShowDeveloperDiagnostic* policy);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appmodel/nf-appmodel-apppolicygetprocessterminationmethod
@DllImport("KERNEL32.dll")
WIN32_ERROR AppPolicyGetProcessTerminationMethod(HANDLE processToken, AppPolicyProcessTerminationMethod* policy);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appmodel/nf-appmodel-apppolicygetcreatefileaccess
@DllImport("KERNEL32.dll")
WIN32_ERROR AppPolicyGetCreateFileAccess(HANDLE processToken, AppPolicyCreateFileAccess* policy);

@DllImport("KERNEL32.dll")
HRESULT CreatePackageVirtualizationContext(const(PWSTR) packageFamilyName, 
                                           PACKAGE_VIRTUALIZATION_CONTEXT_HANDLE* context);

@DllImport("KERNEL32.dll")
HRESULT ActivatePackageVirtualizationContext(PACKAGE_VIRTUALIZATION_CONTEXT_HANDLE context, size_t* cookie);

@DllImport("KERNEL32.dll")
void ReleasePackageVirtualizationContext(PACKAGE_VIRTUALIZATION_CONTEXT_HANDLE context);

@DllImport("KERNEL32.dll")
void DeactivatePackageVirtualizationContext(size_t cookie);

@DllImport("KERNEL32.dll")
HRESULT DuplicatePackageVirtualizationContext(PACKAGE_VIRTUALIZATION_CONTEXT_HANDLE sourceContext, 
                                              PACKAGE_VIRTUALIZATION_CONTEXT_HANDLE* destContext);

@DllImport("KERNEL32.dll")
PACKAGE_VIRTUALIZATION_CONTEXT_HANDLE GetCurrentPackageVirtualizationContext();

@DllImport("KERNEL32.dll")
HRESULT GetProcessesInVirtualizationContext(const(PWSTR) packageFamilyName, uint* count, HANDLE** processes);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/appxpkg/appmodel/nf-appmodel-getcurrentpackageinfo3
@DllImport("KERNEL32.dll")
HRESULT GetCurrentPackageInfo3(uint flags, PackageInfo3Type packageInfoType, uint* bufferLength, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* buffer, 
                               uint* count);


// Interfaces

@GUID("5842a140-ff9f-4166-8f5c-62f5b7b0c781")
struct AppxFactory;

@GUID("378e0446-5384-43b7-8877-e7dbdd883446")
struct AppxBundleFactory;

@GUID("50ca0a46-1588-4161-8ed2-ef9e469ced5d")
struct AppxPackagingDiagnosticEventSinkManager;

@GUID("fb1b3839-09da-404f-b002-9cbb8da5ca4f")
struct AppxPackagingServiceProvider;

@GUID("dc664fdd-d868-46ee-8780-8d196cb739f7")
struct AppxEncryptionFactory;

@GUID("f004f2ca-aebc-4b0d-bf58-e516d5bcc0ab")
struct AppxPackageEditor;

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxfactory
@GUID("beb94909-e451-438b-b5a7-d79e767b75d8")
interface IAppxFactory : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxfactory-createpackagewriter
    HRESULT CreatePackageWriter(IStream outputStream, APPX_PACKAGE_SETTINGS* settings, 
                                IAppxPackageWriter* packageWriter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxfactory-createpackagereader
    HRESULT CreatePackageReader(IStream inputStream, IAppxPackageReader* packageReader);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxfactory-createmanifestreader
    HRESULT CreateManifestReader(IStream inputStream, IAppxManifestReader* manifestReader);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxfactory-createblockmapreader
    HRESULT CreateBlockMapReader(IStream inputStream, IAppxBlockMapReader* blockMapReader);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxfactory-createvalidatedblockmapreader
    HRESULT CreateValidatedBlockMapReader(IStream blockMapStream, const(PWSTR) signatureFileName, 
                                          IAppxBlockMapReader* blockMapReader);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxfactory2
@GUID("f1346df2-c282-4e22-b918-743a929a8d55")
interface IAppxFactory2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxfactory2-createcontentgroupmapreader
    HRESULT CreateContentGroupMapReader(IStream inputStream, IAppxContentGroupMapReader* contentGroupMapReader);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxfactory2-createsourcecontentgroupmapreader
    HRESULT CreateSourceContentGroupMapReader(IStream inputStream, IAppxSourceContentGroupMapReader* reader);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxfactory2-createcontentgroupmapwriter
    HRESULT CreateContentGroupMapWriter(IStream stream, IAppxContentGroupMapWriter* contentGroupMapWriter);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxfactory3
@GUID("776b2c05-e21d-4e24-ba1a-cd529a8bfdbb")
interface IAppxFactory3 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxfactory3-createpackagereader2
    HRESULT CreatePackageReader2(IStream inputStream, const(PWSTR) expectedDigest, 
                                 IAppxPackageReader* packageReader);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxfactory3-createmanifestreader2
    HRESULT CreateManifestReader2(IStream inputStream, const(PWSTR) expectedDigest, 
                                  IAppxManifestReader* manifestReader);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxfactory3-createappinstallerreader
    HRESULT CreateAppInstallerReader(IStream inputStream, const(PWSTR) expectedDigest, 
                                     IAppxAppInstallerReader* appInstallerReader);
}

@GUID("92e50000-6934-4c8d-b472-229d431daddf")
interface IAppxFactory4 : IUnknown
{
    HRESULT CreatePackageReaderFromSourceUri(const(PWSTR) uri, const(PWSTR) expectedDigest, 
                                             IAppxPackageReader* packageReader);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxpackagereader
@GUID("b5c49650-99bc-481c-9a34-3d53a4106708")
interface IAppxPackageReader : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxpackagereader-getblockmap
    HRESULT GetBlockMap(IAppxBlockMapReader* blockMapReader);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxpackagereader-getfootprintfile
    HRESULT GetFootprintFile(APPX_FOOTPRINT_FILE_TYPE type, IAppxFile* file);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxpackagereader-getpayloadfile
    HRESULT GetPayloadFile(const(PWSTR) fileName, IAppxFile* file);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxpackagereader-getpayloadfiles
    HRESULT GetPayloadFiles(IAppxFilesEnumerator* filesEnumerator);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxpackagereader-getmanifest
    HRESULT GetManifest(IAppxManifestReader* manifestReader);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxpackagewriter
@GUID("9099e33b-246f-41e4-881a-008eb613f858")
interface IAppxPackageWriter : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxpackagewriter-addpayloadfile
    HRESULT AddPayloadFile(const(PWSTR) fileName, const(PWSTR) contentType, 
                           APPX_COMPRESSION_OPTION compressionOption, IStream inputStream);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxpackagewriter-close
    HRESULT Close(IStream manifest);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxpackagewriter2
@GUID("2cf5c4fd-e54c-4ea5-ba4e-f8c4b105a8c8")
interface IAppxPackageWriter2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxpackagewriter2-close
    HRESULT Close(IStream manifest, IStream contentGroupMap);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxpackagewriter3
@GUID("a83aacd3-41c0-4501-b8a3-74164f50b2fd")
interface IAppxPackageWriter3 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxpackagewriter3-addpayloadfiles
    HRESULT AddPayloadFiles(uint fileCount, APPX_PACKAGE_WRITER_PAYLOAD_STREAM* payloadFiles, ulong memoryLimit);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxfile
@GUID("91df827b-94fd-468f-827b-57f41b2f6f2e")
interface IAppxFile : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxfile-getcompressionoption
    HRESULT GetCompressionOption(APPX_COMPRESSION_OPTION* compressionOption);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxfile-getcontenttype
    HRESULT GetContentType(PWSTR* contentType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxfile-getname
    HRESULT GetName(PWSTR* fileName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxfile-getsize
    HRESULT GetSize(ulong* size);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxfile-getstream
    HRESULT GetStream(IStream* stream);
}

@GUID("0c830b3c-40e9-11ee-be56-0242ac120002")
interface IAppxFile2 : IAppxFile
{
    HRESULT GetBlockSize(ulong* blockSize);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxfilesenumerator
@GUID("f007eeaf-9831-411c-9847-917cdc62d1fe")
interface IAppxFilesEnumerator : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxfilesenumerator-getcurrent
    HRESULT GetCurrent(IAppxFile* file);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxfilesenumerator-gethascurrent
    HRESULT GetHasCurrent(BOOL* hasCurrent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxfilesenumerator-movenext
    HRESULT MoveNext(BOOL* hasNext);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxblockmapreader
@GUID("5efec991-bca3-42d1-9ec2-e92d609ec22a")
interface IAppxBlockMapReader : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxblockmapreader-getfile
    HRESULT GetFile(const(PWSTR) filename, IAppxBlockMapFile* file);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxblockmapreader-getfiles
    HRESULT GetFiles(IAppxBlockMapFilesEnumerator* enumerator);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxblockmapreader-gethashmethod
    HRESULT GetHashMethod(IUri* hashMethod);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxblockmapreader-getstream
    HRESULT GetStream(IStream* blockMapStream);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxblockmapfile
@GUID("277672ac-4f63-42c1-8abc-beae3600eb59")
interface IAppxBlockMapFile : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxblockmapfile-getblocks
    HRESULT GetBlocks(IAppxBlockMapBlocksEnumerator* blocks);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxblockmapfile-getlocalfileheadersize
    HRESULT GetLocalFileHeaderSize(uint* lfhSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxblockmapfile-getname
    HRESULT GetName(PWSTR* name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxblockmapfile-getuncompressedsize
    HRESULT GetUncompressedSize(ulong* size);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxblockmapfile-validatefilehash
    HRESULT ValidateFileHash(IStream fileStream, BOOL* isValid);
}

@GUID("54785f78-40e9-11ee-be56-0242ac120002")
interface IAppxBlockMapFile2 : IAppxBlockMapFile
{
    HRESULT GetBlockSize(ulong* blockSize);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxblockmapfilesenumerator
@GUID("02b856a2-4262-4070-bacb-1a8cbbc42305")
interface IAppxBlockMapFilesEnumerator : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxblockmapfilesenumerator-getcurrent
    HRESULT GetCurrent(IAppxBlockMapFile* file);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxblockmapfilesenumerator-gethascurrent
    HRESULT GetHasCurrent(BOOL* hasCurrent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxblockmapfilesenumerator-movenext
    HRESULT MoveNext(BOOL* hasCurrent);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxblockmapblock
@GUID("75cf3930-3244-4fe0-a8c8-e0bcb270b889")
interface IAppxBlockMapBlock : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxblockmapblock-gethash
    HRESULT GetHash(uint* bufferSize, ubyte** buffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxblockmapblock-getcompressedsize
    HRESULT GetCompressedSize(uint* size);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxblockmapblocksenumerator
@GUID("6b429b5b-36ef-479e-b9eb-0c1482b49e16")
interface IAppxBlockMapBlocksEnumerator : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxblockmapblocksenumerator-getcurrent
    HRESULT GetCurrent(IAppxBlockMapBlock* block);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxblockmapblocksenumerator-gethascurrent
    HRESULT GetHasCurrent(BOOL* hasCurrent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxblockmapblocksenumerator-movenext
    HRESULT MoveNext(BOOL* hasNext);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxmanifestreader
@GUID("4e1bd148-55a0-4480-a3d1-15544710637c")
interface IAppxManifestReader : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifestreader-getpackageid
    HRESULT GetPackageId(IAppxManifestPackageId* packageId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifestreader-getproperties
    HRESULT GetProperties(IAppxManifestProperties* packageProperties);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifestreader-getpackagedependencies
    HRESULT GetPackageDependencies(IAppxManifestPackageDependenciesEnumerator* dependencies);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifestreader-getcapabilities
    HRESULT GetCapabilities(APPX_CAPABILITIES* capabilities);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifestreader-getresources
    HRESULT GetResources(IAppxManifestResourcesEnumerator* resources);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifestreader-getdevicecapabilities
    HRESULT GetDeviceCapabilities(IAppxManifestDeviceCapabilitiesEnumerator* deviceCapabilities);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifestreader-getprerequisite
    HRESULT GetPrerequisite(const(PWSTR) name, ulong* value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifestreader-getapplications
    HRESULT GetApplications(IAppxManifestApplicationsEnumerator* applications);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifestreader-getstream
    HRESULT GetStream(IStream* manifestStream);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxmanifestreader2
@GUID("d06f67bc-b31d-4eba-a8af-638e73e77b4d")
interface IAppxManifestReader2 : IAppxManifestReader
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifestreader2-getqualifiedresources
    HRESULT GetQualifiedResources(IAppxManifestQualifiedResourcesEnumerator* resources);
}

@GUID("c43825ab-69b7-400a-9709-cc37f5a72d24")
interface IAppxManifestReader3 : IAppxManifestReader2
{
    HRESULT GetCapabilitiesByCapabilityClass(APPX_CAPABILITY_CLASS_TYPE capabilityClass, 
                                             IAppxManifestCapabilitiesEnumerator* capabilities);
    HRESULT GetTargetDeviceFamilies(IAppxManifestTargetDeviceFamiliesEnumerator* targetDeviceFamilies);
}

@GUID("4579bb7c-741d-4161-b5a1-47bd3b78ad9b")
interface IAppxManifestReader4 : IAppxManifestReader3
{
    HRESULT GetOptionalPackageInfo(IAppxManifestOptionalPackageInfo* optionalPackageInfo);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxmanifestreader5
@GUID("8d7ae132-a690-4c00-b75a-6aae1feaac80")
interface IAppxManifestReader5 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifestreader5-getmainpackagedependencies
    HRESULT GetMainPackageDependencies(IAppxManifestMainPackageDependenciesEnumerator* mainPackageDependencies);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxmanifestreader6
@GUID("34deaca4-d3c0-4e3e-b312-e42625e3807e")
interface IAppxManifestReader6 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifestreader6-getisnonqualifiedresourcepackage
    HRESULT GetIsNonQualifiedResourcePackage(BOOL* isNonQualifiedResourcePackage);
}

@GUID("8efe6f27-0ce0-4988-b32d-738eb63db3b7")
interface IAppxManifestReader7 : IUnknown
{
    HRESULT GetDriverDependencies(IAppxManifestDriverDependenciesEnumerator* driverDependencies);
    HRESULT GetOSPackageDependencies(IAppxManifestOSPackageDependenciesEnumerator* osPackageDependencies);
    HRESULT GetHostRuntimeDependencies(IAppxManifestHostRuntimeDependenciesEnumerator* hostRuntimeDependencies);
}

@GUID("fe039db2-467f-4755-8404-8f5eb6865b33")
interface IAppxManifestDriverDependenciesEnumerator : IUnknown
{
    HRESULT GetCurrent(IAppxManifestDriverDependency* driverDependency);
    HRESULT GetHasCurrent(BOOL* hasCurrent);
    HRESULT MoveNext(BOOL* hasNext);
}

@GUID("1210cb94-5a92-4602-be24-79f318af4af9")
interface IAppxManifestDriverDependency : IUnknown
{
    HRESULT GetDriverConstraints(IAppxManifestDriverConstraintsEnumerator* driverConstraints);
}

@GUID("d402b2d1-f600-49e0-95e6-975d8da13d89")
interface IAppxManifestDriverConstraintsEnumerator : IUnknown
{
    HRESULT GetCurrent(IAppxManifestDriverConstraint* driverConstraint);
    HRESULT GetHasCurrent(BOOL* hasCurrent);
    HRESULT MoveNext(BOOL* hasNext);
}

@GUID("c031bee4-bbcc-48ea-a237-c34045c80a07")
interface IAppxManifestDriverConstraint : IUnknown
{
    HRESULT GetName(PWSTR* name);
    HRESULT GetMinVersion(ulong* minVersion);
    HRESULT GetMinDate(PWSTR* minDate);
}

@GUID("b84e2fc3-f8ec-4bc1-8ae2-156346f5ffea")
interface IAppxManifestOSPackageDependenciesEnumerator : IUnknown
{
    HRESULT GetCurrent(IAppxManifestOSPackageDependency* osPackageDependency);
    HRESULT GetHasCurrent(BOOL* hasCurrent);
    HRESULT MoveNext(BOOL* hasNext);
}

@GUID("154995ee-54a6-4f14-ac97-d8cf0519644b")
interface IAppxManifestOSPackageDependency : IUnknown
{
    HRESULT GetName(PWSTR* name);
    HRESULT GetVersion(ulong* version_);
}

@GUID("6427a646-7f49-433e-b1a6-0da309f6885a")
interface IAppxManifestHostRuntimeDependenciesEnumerator : IUnknown
{
    HRESULT GetCurrent(IAppxManifestHostRuntimeDependency* hostRuntimeDependency);
    HRESULT GetHasCurrent(BOOL* hasCurrent);
    HRESULT MoveNext(BOOL* hasNext);
}

@GUID("3455d234-8414-410d-95c7-7b35255b8391")
interface IAppxManifestHostRuntimeDependency : IUnknown
{
    HRESULT GetName(PWSTR* name);
    HRESULT GetPublisher(PWSTR* publisher);
    HRESULT GetMinVersion(ulong* minVersion);
}

@GUID("c26f23a8-ee10-4ad6-b898-2b4d7aebfe6a")
interface IAppxManifestHostRuntimeDependency2 : IUnknown
{
    HRESULT GetPackageFamilyName(PWSTR* packageFamilyName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxmanifestoptionalpackageinfo
@GUID("2634847d-5b5d-4fe5-a243-002ff95edc7e")
interface IAppxManifestOptionalPackageInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifestoptionalpackageinfo-getisoptionalpackage
    HRESULT GetIsOptionalPackage(BOOL* isOptionalPackage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifestoptionalpackageinfo-getmainpackagename
    HRESULT GetMainPackageName(PWSTR* mainPackageName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxmanifestmainpackagedependenciesenumerator
@GUID("a99c4f00-51d2-4f0f-ba46-7ed5255ebdff")
interface IAppxManifestMainPackageDependenciesEnumerator : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifestmainpackagedependenciesenumerator-getcurrent
    HRESULT GetCurrent(IAppxManifestMainPackageDependency* mainPackageDependency);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifestmainpackagedependenciesenumerator-gethascurrent
    HRESULT GetHasCurrent(BOOL* hasCurrent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifestmainpackagedependenciesenumerator-movenext
    HRESULT MoveNext(BOOL* hasNext);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxmanifestmainpackagedependency
@GUID("05d0611c-bc29-46d5-97e2-84b9c79bd8ae")
interface IAppxManifestMainPackageDependency : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifestmainpackagedependency-getname
    HRESULT GetName(PWSTR* name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifestmainpackagedependency-getpublisher
    HRESULT GetPublisher(PWSTR* publisher);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifestmainpackagedependency-getpackagefamilyname
    HRESULT GetPackageFamilyName(PWSTR* packageFamilyName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxmanifestpackageid
@GUID("283ce2d7-7153-4a91-9649-7a0f7240945f")
interface IAppxManifestPackageId : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifestpackageid-getname
    HRESULT GetName(PWSTR* name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifestpackageid-getarchitecture
    HRESULT GetArchitecture(APPX_PACKAGE_ARCHITECTURE* architecture);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifestpackageid-getpublisher
    HRESULT GetPublisher(PWSTR* publisher);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifestpackageid-getversion
    HRESULT GetVersion(ulong* packageVersion);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifestpackageid-getresourceid
    HRESULT GetResourceId(PWSTR* resourceId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifestpackageid-comparepublisher
    HRESULT ComparePublisher(const(PWSTR) other, BOOL* isSame);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifestpackageid-getpackagefullname
    HRESULT GetPackageFullName(PWSTR* packageFullName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifestpackageid-getpackagefamilyname
    HRESULT GetPackageFamilyName(PWSTR* packageFamilyName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxmanifestpackageid2
@GUID("2256999d-d617-42f1-880e-0ba4542319d5")
interface IAppxManifestPackageId2 : IAppxManifestPackageId
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifestpackageid2-getarchitecture2
    HRESULT GetArchitecture2(APPX_PACKAGE_ARCHITECTURE2* architecture);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxmanifestproperties
@GUID("03faf64d-f26f-4b2c-aaf7-8fe7789b8bca")
interface IAppxManifestProperties : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifestproperties-getboolvalue
    HRESULT GetBoolValue(const(PWSTR) name, BOOL* value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifestproperties-getstringvalue
    HRESULT GetStringValue(const(PWSTR) name, PWSTR* value);
}

@GUID("36537f36-27a4-4788-88c0-733819575017")
interface IAppxManifestTargetDeviceFamiliesEnumerator : IUnknown
{
    HRESULT GetCurrent(IAppxManifestTargetDeviceFamily* targetDeviceFamily);
    HRESULT GetHasCurrent(BOOL* hasCurrent);
    HRESULT MoveNext(BOOL* hasNext);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxmanifesttargetdevicefamily
@GUID("9091b09b-c8d5-4f31-8687-a338259faefb")
interface IAppxManifestTargetDeviceFamily : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifesttargetdevicefamily-getname
    HRESULT GetName(PWSTR* name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifesttargetdevicefamily-getminversion
    HRESULT GetMinVersion(ulong* minVersion);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifesttargetdevicefamily-getmaxversiontested
    HRESULT GetMaxVersionTested(ulong* maxVersionTested);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxmanifestpackagedependenciesenumerator
@GUID("b43bbcf9-65a6-42dd-bac0-8c6741e7f5a4")
interface IAppxManifestPackageDependenciesEnumerator : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifestpackagedependenciesenumerator-getcurrent
    HRESULT GetCurrent(IAppxManifestPackageDependency* dependency);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifestpackagedependenciesenumerator-gethascurrent
    HRESULT GetHasCurrent(BOOL* hasCurrent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifestpackagedependenciesenumerator-movenext
    HRESULT MoveNext(BOOL* hasNext);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxmanifestpackagedependency
@GUID("e4946b59-733e-43f0-a724-3bde4c1285a0")
interface IAppxManifestPackageDependency : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifestpackagedependency-getname
    HRESULT GetName(PWSTR* name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifestpackagedependency-getpublisher
    HRESULT GetPublisher(PWSTR* publisher);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifestpackagedependency-getminversion
    HRESULT GetMinVersion(ulong* minVersion);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxmanifestpackagedependency2
@GUID("dda0b713-f3ff-49d3-898a-2786780c5d98")
interface IAppxManifestPackageDependency2 : IAppxManifestPackageDependency
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifestpackagedependency2-getmaxmajorversiontested
    HRESULT GetMaxMajorVersionTested(ushort* maxMajorVersionTested);
}

@GUID("1ac56374-6198-4d6b-92e4-749d5ab8a895")
interface IAppxManifestPackageDependency3 : IUnknown
{
    HRESULT GetIsOptional(BOOL* isOptional);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxmanifestresourcesenumerator
@GUID("de4dfbbd-881a-48bb-858c-d6f2baeae6ed")
interface IAppxManifestResourcesEnumerator : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifestresourcesenumerator-getcurrent
    HRESULT GetCurrent(PWSTR* resource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifestresourcesenumerator-gethascurrent
    HRESULT GetHasCurrent(BOOL* hasCurrent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifestresourcesenumerator-movenext
    HRESULT MoveNext(BOOL* hasNext);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxmanifestdevicecapabilitiesenumerator
@GUID("30204541-427b-4a1c-bacf-655bf463a540")
interface IAppxManifestDeviceCapabilitiesEnumerator : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifestdevicecapabilitiesenumerator-getcurrent
    HRESULT GetCurrent(PWSTR* deviceCapability);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifestdevicecapabilitiesenumerator-gethascurrent
    HRESULT GetHasCurrent(BOOL* hasCurrent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifestdevicecapabilitiesenumerator-movenext
    HRESULT MoveNext(BOOL* hasNext);
}

@GUID("11d22258-f470-42c1-b291-8361c5437e41")
interface IAppxManifestCapabilitiesEnumerator : IUnknown
{
    HRESULT GetCurrent(PWSTR* capability);
    HRESULT GetHasCurrent(BOOL* hasCurrent);
    HRESULT MoveNext(BOOL* hasNext);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxmanifestapplicationsenumerator
@GUID("9eb8a55a-f04b-4d0d-808d-686185d4847a")
interface IAppxManifestApplicationsEnumerator : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifestapplicationsenumerator-getcurrent
    HRESULT GetCurrent(IAppxManifestApplication* application);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifestapplicationsenumerator-gethascurrent
    HRESULT GetHasCurrent(BOOL* hasCurrent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifestapplicationsenumerator-movenext
    HRESULT MoveNext(BOOL* hasNext);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxmanifestapplication
@GUID("5da89bf4-3773-46be-b650-7e744863b7e8")
interface IAppxManifestApplication : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifestapplication-getstringvalue
    HRESULT GetStringValue(const(PWSTR) name, PWSTR* value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxmanifestapplication-getappusermodelid
    HRESULT GetAppUserModelId(PWSTR* appUserModelId);
}

@GUID("8ef6adfe-3762-4a8f-9373-2fc5d444c8d2")
interface IAppxManifestQualifiedResourcesEnumerator : IUnknown
{
    HRESULT GetCurrent(IAppxManifestQualifiedResource* resource);
    HRESULT GetHasCurrent(BOOL* hasCurrent);
    HRESULT MoveNext(BOOL* hasNext);
}

@GUID("3b53a497-3c5c-48d1-9ea3-bb7eac8cd7d4")
interface IAppxManifestQualifiedResource : IUnknown
{
    HRESULT GetLanguage(PWSTR* language);
    HRESULT GetScale(uint* scale);
    HRESULT GetDXFeatureLevel(DX_FEATURE_LEVEL* dxFeatureLevel);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxbundlefactory
@GUID("bba65864-965f-4a5f-855f-f074bdbf3a7b")
interface IAppxBundleFactory : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxbundlefactory-createbundlewriter
    HRESULT CreateBundleWriter(IStream outputStream, ulong bundleVersion, IAppxBundleWriter* bundleWriter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxbundlefactory-createbundlereader
    HRESULT CreateBundleReader(IStream inputStream, IAppxBundleReader* bundleReader);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxbundlefactory-createbundlemanifestreader
    HRESULT CreateBundleManifestReader(IStream inputStream, IAppxBundleManifestReader* manifestReader);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxbundlefactory2
@GUID("7325b83d-0185-42c4-82ac-be34ab1a2a8a")
interface IAppxBundleFactory2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxbundlefactory2-createbundlereader2
    HRESULT CreateBundleReader2(IStream inputStream, const(PWSTR) expectedDigest, IAppxBundleReader* bundleReader);
}

@GUID("d11ea6b6-3909-4376-b7c4-10d50f5cf3ae")
interface IAppxBundleFactory3 : IUnknown
{
    HRESULT CreateBundleReaderFromSourceUri(const(PWSTR) uri, const(PWSTR) expectedDigest, 
                                            IAppxBundleReader* bundleReader);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxbundlewriter
@GUID("ec446fe8-bfec-4c64-ab4f-49f038f0c6d2")
interface IAppxBundleWriter : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxbundlewriter-addpayloadpackage
    HRESULT AddPayloadPackage(const(PWSTR) fileName, IStream packageStream);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxbundlewriter-close
    HRESULT Close();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxbundlewriter2
@GUID("6d8fe971-01cc-49a0-b685-233851279962")
interface IAppxBundleWriter2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxbundlewriter2-addexternalpackagereference
    HRESULT AddExternalPackageReference(const(PWSTR) fileName, IStream inputStream);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxbundlewriter3
@GUID("ad711152-f969-4193-82d5-9ddf2786d21a")
interface IAppxBundleWriter3 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxbundlewriter3-addpackagereference
    HRESULT AddPackageReference(const(PWSTR) fileName, IStream inputStream);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxbundlewriter3-close
    HRESULT Close(const(PWSTR) hashMethodString);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxbundlewriter4
@GUID("9cd9d523-5009-4c01-9882-dc029fbd47a3")
interface IAppxBundleWriter4 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxbundlewriter4-addpayloadpackage
    HRESULT AddPayloadPackage(const(PWSTR) fileName, IStream packageStream, BOOL isDefaultApplicablePackage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxbundlewriter4-addpackagereference
    HRESULT AddPackageReference(const(PWSTR) fileName, IStream inputStream, BOOL isDefaultApplicablePackage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxbundlewriter4-addexternalpackagereference
    HRESULT AddExternalPackageReference(const(PWSTR) fileName, IStream inputStream, 
                                        BOOL isDefaultApplicablePackage);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxbundlereader
@GUID("dd75b8c0-ba76-43b0-ae0f-68656a1dc5c8")
interface IAppxBundleReader : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxbundlereader-getfootprintfile
    HRESULT GetFootprintFile(APPX_BUNDLE_FOOTPRINT_FILE_TYPE fileType, IAppxFile* footprintFile);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxbundlereader-getblockmap
    HRESULT GetBlockMap(IAppxBlockMapReader* blockMapReader);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxbundlereader-getmanifest
    HRESULT GetManifest(IAppxBundleManifestReader* manifestReader);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxbundlereader-getpayloadpackages
    HRESULT GetPayloadPackages(IAppxFilesEnumerator* payloadPackages);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxbundlereader-getpayloadpackage
    HRESULT GetPayloadPackage(const(PWSTR) fileName, IAppxFile* payloadPackage);
}

@GUID("98262195-d63a-4c10-b4cf-dd72e061ba87")
interface IAppxBundleReader2 : IUnknown
{
    HRESULT GetPayloadPackageReader(const(PWSTR) fileName, IAppxPackageReader* payloadPackageReader);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxbundlemanifestreader
@GUID("cf0ebbc1-cc99-4106-91eb-e67462e04fb0")
interface IAppxBundleManifestReader : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxbundlemanifestreader-getpackageid
    HRESULT GetPackageId(IAppxManifestPackageId* packageId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxbundlemanifestreader-getpackageinfoitems
    HRESULT GetPackageInfoItems(IAppxBundleManifestPackageInfoEnumerator* packageInfoItems);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxbundlemanifestreader-getstream
    HRESULT GetStream(IStream* manifestStream);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxbundlemanifestreader2
@GUID("5517df70-033f-4af2-8213-87d766805c02")
interface IAppxBundleManifestReader2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxbundlemanifestreader2-getoptionalbundles
    HRESULT GetOptionalBundles(IAppxBundleManifestOptionalBundleInfoEnumerator* optionalBundles);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxbundlemanifestpackageinfoenumerator
@GUID("f9b856ee-49a6-4e19-b2b0-6a2406d63a32")
interface IAppxBundleManifestPackageInfoEnumerator : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxbundlemanifestpackageinfoenumerator-getcurrent
    HRESULT GetCurrent(IAppxBundleManifestPackageInfo* packageInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxbundlemanifestpackageinfoenumerator-gethascurrent
    HRESULT GetHasCurrent(BOOL* hasCurrent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxbundlemanifestpackageinfoenumerator-movenext
    HRESULT MoveNext(BOOL* hasNext);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxbundlemanifestpackageinfo
@GUID("54cd06c1-268f-40bb-8ed2-757a9ebaec8d")
interface IAppxBundleManifestPackageInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxbundlemanifestpackageinfo-getpackagetype
    HRESULT GetPackageType(APPX_BUNDLE_PAYLOAD_PACKAGE_TYPE* packageType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxbundlemanifestpackageinfo-getpackageid
    HRESULT GetPackageId(IAppxManifestPackageId* packageId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxbundlemanifestpackageinfo-getfilename
    HRESULT GetFileName(PWSTR* fileName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxbundlemanifestpackageinfo-getoffset
    HRESULT GetOffset(ulong* offset);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxbundlemanifestpackageinfo-getsize
    HRESULT GetSize(ulong* size);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxbundlemanifestpackageinfo-getresources
    HRESULT GetResources(IAppxManifestQualifiedResourcesEnumerator* resources);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxbundlemanifestpackageinfo2
@GUID("44c2acbc-b2cf-4ccb-bbdb-9c6da8c3bc9e")
interface IAppxBundleManifestPackageInfo2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxbundlemanifestpackageinfo2-getispackagereference
    HRESULT GetIsPackageReference(BOOL* isPackageReference);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxbundlemanifestpackageinfo2-getisnonqualifiedresourcepackage
    HRESULT GetIsNonQualifiedResourcePackage(BOOL* isNonQualifiedResourcePackage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxbundlemanifestpackageinfo2-getisdefaultapplicablepackage
    HRESULT GetIsDefaultApplicablePackage(BOOL* isDefaultApplicablePackage);
}

@GUID("6ba74b98-bb74-4296-80d0-5f4256a99675")
interface IAppxBundleManifestPackageInfo3 : IUnknown
{
    HRESULT GetTargetDeviceFamilies(IAppxManifestTargetDeviceFamiliesEnumerator* targetDeviceFamilies);
}

@GUID("5da6f13d-a8a7-4532-857c-1393d659371d")
interface IAppxBundleManifestPackageInfo4 : IUnknown
{
    HRESULT GetIsStub(BOOL* isStub);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxbundlemanifestoptionalbundleinfoenumerator
@GUID("9a178793-f97e-46ac-aaca-dd5ba4c177c8")
interface IAppxBundleManifestOptionalBundleInfoEnumerator : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxbundlemanifestoptionalbundleinfoenumerator-getcurrent
    HRESULT GetCurrent(IAppxBundleManifestOptionalBundleInfo* optionalBundle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxbundlemanifestoptionalbundleinfoenumerator-gethascurrent
    HRESULT GetHasCurrent(BOOL* hasCurrent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxbundlemanifestoptionalbundleinfoenumerator-movenext
    HRESULT MoveNext(BOOL* hasNext);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxbundlemanifestoptionalbundleinfo
@GUID("515bf2e8-bcb0-4d69-8c48-e383147b6e12")
interface IAppxBundleManifestOptionalBundleInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxbundlemanifestoptionalbundleinfo-getpackageid
    HRESULT GetPackageId(IAppxManifestPackageId* packageId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxbundlemanifestoptionalbundleinfo-getfilename
    HRESULT GetFileName(PWSTR* fileName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxbundlemanifestoptionalbundleinfo-getpackageinfoitems
    HRESULT GetPackageInfoItems(IAppxBundleManifestPackageInfoEnumerator* packageInfoItems);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxcontentgroupfilesenumerator
@GUID("1a09a2fd-7440-44eb-8c84-848205a6a1cc")
interface IAppxContentGroupFilesEnumerator : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxcontentgroupfilesenumerator-getcurrent
    HRESULT GetCurrent(PWSTR* file);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxcontentgroupfilesenumerator-gethascurrent
    HRESULT GetHasCurrent(BOOL* hasCurrent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxcontentgroupfilesenumerator-movenext
    HRESULT MoveNext(BOOL* hasNext);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxcontentgroup
@GUID("328f6468-c04f-4e3c-b6fa-6b8d27f3003a")
interface IAppxContentGroup : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxcontentgroup-getname
    HRESULT GetName(PWSTR* groupName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxcontentgroup-getfiles
    HRESULT GetFiles(IAppxContentGroupFilesEnumerator* enumerator);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxcontentgroupsenumerator
@GUID("3264e477-16d1-4d63-823e-7d2984696634")
interface IAppxContentGroupsEnumerator : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxcontentgroupsenumerator-getcurrent
    HRESULT GetCurrent(IAppxContentGroup* stream);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxcontentgroupsenumerator-gethascurrent
    HRESULT GetHasCurrent(BOOL* hasCurrent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxcontentgroupsenumerator-movenext
    HRESULT MoveNext(BOOL* hasNext);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxcontentgroupmapreader
@GUID("418726d8-dd99-4f5d-9886-157add20de01")
interface IAppxContentGroupMapReader : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxcontentgroupmapreader-getrequiredgroup
    HRESULT GetRequiredGroup(IAppxContentGroup* requiredGroup);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxcontentgroupmapreader-getautomaticgroups
    HRESULT GetAutomaticGroups(IAppxContentGroupsEnumerator* automaticGroupsEnumerator);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxsourcecontentgroupmapreader
@GUID("f329791d-540b-4a9f-bc75-3282b7d73193")
interface IAppxSourceContentGroupMapReader : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxsourcecontentgroupmapreader-getrequiredgroup
    HRESULT GetRequiredGroup(IAppxContentGroup* requiredGroup);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxsourcecontentgroupmapreader-getautomaticgroups
    HRESULT GetAutomaticGroups(IAppxContentGroupsEnumerator* automaticGroupsEnumerator);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxcontentgroupmapwriter
@GUID("d07ab776-a9de-4798-8c14-3db31e687c78")
interface IAppxContentGroupMapWriter : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxcontentgroupmapwriter-addautomaticgroup
    HRESULT AddAutomaticGroup(const(PWSTR) groupName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxcontentgroupmapwriter-addautomaticfile
    HRESULT AddAutomaticFile(const(PWSTR) fileName);
    HRESULT Close();
}

@GUID("17239d47-6adb-45d2-80f6-f9cbc3bf059d")
interface IAppxPackagingDiagnosticEventSink : IUnknown
{
    HRESULT ReportContextChange(APPX_PACKAGING_CONTEXT_CHANGE_TYPE changeType, int contextId, 
                                const(PSTR) contextName, const(PWSTR) contextMessage, const(PWSTR) detailsMessage);
    HRESULT ReportError(const(PWSTR) errorMessage);
}

@GUID("369648fa-a7eb-4909-a15d-6954a078f18a")
interface IAppxPackagingDiagnosticEventSinkManager : IUnknown
{
    HRESULT SetSinkForProcess(IAppxPackagingDiagnosticEventSink sink);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxappinstallerreader
@GUID("f35bc38c-1d2f-43db-a1f4-586430d1fed2")
interface IAppxAppInstallerReader : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxappinstallerreader-getxmldom
    HRESULT GetXmlDom(IXMLDOMDocument* dom);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxdigestprovider
@GUID("9fe2702b-7640-4659-8e6c-349e43c4cdbd")
interface IAppxDigestProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxdigestprovider-getdigest
    HRESULT GetDigest(PWSTR* digest);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.14393))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxencryptionfactory
@GUID("80e8e04d-8c88-44ae-a011-7cadf6fb2e72")
interface IAppxEncryptionFactory : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxencryptionfactory-encryptpackage
    HRESULT EncryptPackage(IStream inputStream, IStream outputStream, 
                           const(APPX_ENCRYPTED_PACKAGE_SETTINGS)* settings, const(APPX_KEY_INFO)* keyInfo, 
                           const(APPX_ENCRYPTED_EXEMPTIONS)* exemptedFiles);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxencryptionfactory-decryptpackage
    HRESULT DecryptPackage(IStream inputStream, IStream outputStream, const(APPX_KEY_INFO)* keyInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxencryptionfactory-createencryptedpackagewriter
    HRESULT CreateEncryptedPackageWriter(IStream outputStream, IStream manifestStream, 
                                         const(APPX_ENCRYPTED_PACKAGE_SETTINGS)* settings, 
                                         const(APPX_KEY_INFO)* keyInfo, 
                                         const(APPX_ENCRYPTED_EXEMPTIONS)* exemptedFiles, 
                                         IAppxEncryptedPackageWriter* packageWriter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxencryptionfactory-createencryptedpackagereader
    HRESULT CreateEncryptedPackageReader(IStream inputStream, const(APPX_KEY_INFO)* keyInfo, 
                                         IAppxPackageReader* packageReader);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxencryptionfactory-encryptbundle
    HRESULT EncryptBundle(IStream inputStream, IStream outputStream, 
                          const(APPX_ENCRYPTED_PACKAGE_SETTINGS)* settings, const(APPX_KEY_INFO)* keyInfo, 
                          const(APPX_ENCRYPTED_EXEMPTIONS)* exemptedFiles);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxencryptionfactory-decryptbundle
    HRESULT DecryptBundle(IStream inputStream, IStream outputStream, const(APPX_KEY_INFO)* keyInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxencryptionfactory-createencryptedbundlewriter
    HRESULT CreateEncryptedBundleWriter(IStream outputStream, ulong bundleVersion, 
                                        const(APPX_ENCRYPTED_PACKAGE_SETTINGS)* settings, 
                                        const(APPX_KEY_INFO)* keyInfo, 
                                        const(APPX_ENCRYPTED_EXEMPTIONS)* exemptedFiles, 
                                        IAppxEncryptedBundleWriter* bundleWriter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxencryptionfactory-createencryptedbundlereader
    HRESULT CreateEncryptedBundleReader(IStream inputStream, const(APPX_KEY_INFO)* keyInfo, 
                                        IAppxBundleReader* bundleReader);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxencryptionfactory2
@GUID("c1b11eee-c4ba-4ab2-a55d-d015fe8ff64f")
interface IAppxEncryptionFactory2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxencryptionfactory2-createencryptedpackagewriter
    HRESULT CreateEncryptedPackageWriter(IStream outputStream, IStream manifestStream, 
                                         IStream contentGroupMapStream, 
                                         const(APPX_ENCRYPTED_PACKAGE_SETTINGS)* settings, 
                                         const(APPX_KEY_INFO)* keyInfo, 
                                         const(APPX_ENCRYPTED_EXEMPTIONS)* exemptedFiles, 
                                         IAppxEncryptedPackageWriter* packageWriter);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxencryptionfactory3
@GUID("09edca37-cd64-47d6-b7e8-1cb11d4f7e05")
interface IAppxEncryptionFactory3 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxencryptionfactory3-encryptpackage
    HRESULT EncryptPackage(IStream inputStream, IStream outputStream, 
                           const(APPX_ENCRYPTED_PACKAGE_SETTINGS2)* settings, const(APPX_KEY_INFO)* keyInfo, 
                           const(APPX_ENCRYPTED_EXEMPTIONS)* exemptedFiles);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxencryptionfactory3-createencryptedpackagewriter
    HRESULT CreateEncryptedPackageWriter(IStream outputStream, IStream manifestStream, 
                                         IStream contentGroupMapStream, 
                                         const(APPX_ENCRYPTED_PACKAGE_SETTINGS2)* settings, 
                                         const(APPX_KEY_INFO)* keyInfo, 
                                         const(APPX_ENCRYPTED_EXEMPTIONS)* exemptedFiles, 
                                         IAppxEncryptedPackageWriter* packageWriter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxencryptionfactory3-encryptbundle
    HRESULT EncryptBundle(IStream inputStream, IStream outputStream, 
                          const(APPX_ENCRYPTED_PACKAGE_SETTINGS2)* settings, const(APPX_KEY_INFO)* keyInfo, 
                          const(APPX_ENCRYPTED_EXEMPTIONS)* exemptedFiles);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxencryptionfactory3-createencryptedbundlewriter
    HRESULT CreateEncryptedBundleWriter(IStream outputStream, ulong bundleVersion, 
                                        const(APPX_ENCRYPTED_PACKAGE_SETTINGS2)* settings, 
                                        const(APPX_KEY_INFO)* keyInfo, 
                                        const(APPX_ENCRYPTED_EXEMPTIONS)* exemptedFiles, 
                                        IAppxEncryptedBundleWriter* bundleWriter);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxencryptionfactory4
@GUID("a879611f-12fd-41fe-85d5-06ae779bbaf5")
interface IAppxEncryptionFactory4 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxencryptionfactory4-encryptpackage
    HRESULT EncryptPackage(IStream inputStream, IStream outputStream, 
                           const(APPX_ENCRYPTED_PACKAGE_SETTINGS2)* settings, const(APPX_KEY_INFO)* keyInfo, 
                           const(APPX_ENCRYPTED_EXEMPTIONS)* exemptedFiles, ulong memoryLimit);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxencryptionfactory5
@GUID("68d6e77a-f446-480f-b0f0-d91a24c60746")
interface IAppxEncryptionFactory5 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxencryptionfactory5-createencryptedpackagereader2
    HRESULT CreateEncryptedPackageReader2(IStream inputStream, const(APPX_KEY_INFO)* keyInfo, 
                                          const(PWSTR) expectedDigest, IAppxPackageReader* packageReader);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxencryptionfactory5-createencryptedbundlereader2
    HRESULT CreateEncryptedBundleReader2(IStream inputStream, const(APPX_KEY_INFO)* keyInfo, 
                                         const(PWSTR) expectedDigest, IAppxBundleReader* bundleReader);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.14393))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxencryptedpackagewriter
@GUID("f43d0b0b-1379-40e2-9b29-682ea2bf42af")
interface IAppxEncryptedPackageWriter : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxencryptedpackagewriter-addpayloadfileencrypted
    HRESULT AddPayloadFileEncrypted(const(PWSTR) fileName, APPX_COMPRESSION_OPTION compressionOption, 
                                    IStream inputStream);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxencryptedpackagewriter-close
    HRESULT Close();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.14393))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxencryptedpackagewriter2
@GUID("3e475447-3a25-40b5-8ad2-f953ae50c92d")
interface IAppxEncryptedPackageWriter2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxencryptedpackagewriter2-addpayloadfilesencrypted
    HRESULT AddPayloadFilesEncrypted(uint fileCount, APPX_PACKAGE_WRITER_PAYLOAD_STREAM* payloadFiles, 
                                     ulong memoryLimit);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.14393))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxencryptedbundlewriter
@GUID("80b0902f-7bf0-4117-b8c6-4279ef81ee77")
interface IAppxEncryptedBundleWriter : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxencryptedbundlewriter-addpayloadpackageencrypted
    HRESULT AddPayloadPackageEncrypted(const(PWSTR) fileName, IStream packageStream);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxencryptedbundlewriter-close
    HRESULT Close();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxencryptedbundlewriter2
@GUID("e644be82-f0fa-42b8-a956-8d1cb48ee379")
interface IAppxEncryptedBundleWriter2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxencryptedbundlewriter2-addexternalpackagereference
    HRESULT AddExternalPackageReference(const(PWSTR) fileName, IStream inputStream);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxencryptedbundlewriter3
@GUID("0d34deb3-5cae-4dd3-977c-504932a51d31")
interface IAppxEncryptedBundleWriter3 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxencryptedbundlewriter3-addpayloadpackageencrypted
    HRESULT AddPayloadPackageEncrypted(const(PWSTR) fileName, IStream packageStream, 
                                       BOOL isDefaultApplicablePackage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxencryptedbundlewriter3-addexternalpackagereference
    HRESULT AddExternalPackageReference(const(PWSTR) fileName, IStream inputStream, 
                                        BOOL isDefaultApplicablePackage);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nn-appxpackaging-iappxpackageeditor
@GUID("e2adb6dc-5e71-4416-86b6-86e5f5291a6b")
interface IAppxPackageEditor : IUnknown
{
    HRESULT SetWorkingDirectory(const(PWSTR) workingDirectory);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxpackageeditor-createdeltapackage
    HRESULT CreateDeltaPackage(IStream updatedPackageStream, IStream baselinePackageStream, 
                               IStream deltaPackageStream);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxpackageeditor-createdeltapackageusingbaselineblockmap
    HRESULT CreateDeltaPackageUsingBaselineBlockMap(IStream updatedPackageStream, IStream baselineBlockMapStream, 
                                                    const(PWSTR) baselinePackageFullName, IStream deltaPackageStream);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxpackageeditor-updatepackage
    HRESULT UpdatePackage(IStream baselinePackageStream, IStream deltaPackageStream, 
                          APPX_PACKAGE_EDITOR_UPDATE_PACKAGE_OPTION updateOption);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxpackageeditor-updateencryptedpackage
    HRESULT UpdateEncryptedPackage(IStream baselineEncryptedPackageStream, IStream deltaPackageStream, 
                                   APPX_PACKAGE_EDITOR_UPDATE_PACKAGE_OPTION updateOption, 
                                   const(APPX_ENCRYPTED_PACKAGE_SETTINGS2)* settings, const(APPX_KEY_INFO)* keyInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appxpackaging/nf-appxpackaging-iappxpackageeditor-updatepackagemanifest
    HRESULT UpdatePackageManifest(IStream packageStream, IStream updatedManifestStream, BOOL isPackageEncrypted, 
                                  APPX_PACKAGE_EDITOR_UPDATE_PACKAGE_MANIFEST_OPTIONS options);
}


// GUIDs

const GUID CLSID_AppxBundleFactory                       = GUIDOF!AppxBundleFactory;
const GUID CLSID_AppxEncryptionFactory                   = GUIDOF!AppxEncryptionFactory;
const GUID CLSID_AppxFactory                             = GUIDOF!AppxFactory;
const GUID CLSID_AppxPackageEditor                       = GUIDOF!AppxPackageEditor;
const GUID CLSID_AppxPackagingDiagnosticEventSinkManager = GUIDOF!AppxPackagingDiagnosticEventSinkManager;
const GUID CLSID_AppxPackagingServiceProvider            = GUIDOF!AppxPackagingServiceProvider;

const GUID IID_IAppxAppInstallerReader                         = GUIDOF!IAppxAppInstallerReader;
const GUID IID_IAppxBlockMapBlock                              = GUIDOF!IAppxBlockMapBlock;
const GUID IID_IAppxBlockMapBlocksEnumerator                   = GUIDOF!IAppxBlockMapBlocksEnumerator;
const GUID IID_IAppxBlockMapFile                               = GUIDOF!IAppxBlockMapFile;
const GUID IID_IAppxBlockMapFile2                              = GUIDOF!IAppxBlockMapFile2;
const GUID IID_IAppxBlockMapFilesEnumerator                    = GUIDOF!IAppxBlockMapFilesEnumerator;
const GUID IID_IAppxBlockMapReader                             = GUIDOF!IAppxBlockMapReader;
const GUID IID_IAppxBundleFactory                              = GUIDOF!IAppxBundleFactory;
const GUID IID_IAppxBundleFactory2                             = GUIDOF!IAppxBundleFactory2;
const GUID IID_IAppxBundleFactory3                             = GUIDOF!IAppxBundleFactory3;
const GUID IID_IAppxBundleManifestOptionalBundleInfo           = GUIDOF!IAppxBundleManifestOptionalBundleInfo;
const GUID IID_IAppxBundleManifestOptionalBundleInfoEnumerator = GUIDOF!IAppxBundleManifestOptionalBundleInfoEnumerator;
const GUID IID_IAppxBundleManifestPackageInfo                  = GUIDOF!IAppxBundleManifestPackageInfo;
const GUID IID_IAppxBundleManifestPackageInfo2                 = GUIDOF!IAppxBundleManifestPackageInfo2;
const GUID IID_IAppxBundleManifestPackageInfo3                 = GUIDOF!IAppxBundleManifestPackageInfo3;
const GUID IID_IAppxBundleManifestPackageInfo4                 = GUIDOF!IAppxBundleManifestPackageInfo4;
const GUID IID_IAppxBundleManifestPackageInfoEnumerator        = GUIDOF!IAppxBundleManifestPackageInfoEnumerator;
const GUID IID_IAppxBundleManifestReader                       = GUIDOF!IAppxBundleManifestReader;
const GUID IID_IAppxBundleManifestReader2                      = GUIDOF!IAppxBundleManifestReader2;
const GUID IID_IAppxBundleReader                               = GUIDOF!IAppxBundleReader;
const GUID IID_IAppxBundleReader2                              = GUIDOF!IAppxBundleReader2;
const GUID IID_IAppxBundleWriter                               = GUIDOF!IAppxBundleWriter;
const GUID IID_IAppxBundleWriter2                              = GUIDOF!IAppxBundleWriter2;
const GUID IID_IAppxBundleWriter3                              = GUIDOF!IAppxBundleWriter3;
const GUID IID_IAppxBundleWriter4                              = GUIDOF!IAppxBundleWriter4;
const GUID IID_IAppxContentGroup                               = GUIDOF!IAppxContentGroup;
const GUID IID_IAppxContentGroupFilesEnumerator                = GUIDOF!IAppxContentGroupFilesEnumerator;
const GUID IID_IAppxContentGroupMapReader                      = GUIDOF!IAppxContentGroupMapReader;
const GUID IID_IAppxContentGroupMapWriter                      = GUIDOF!IAppxContentGroupMapWriter;
const GUID IID_IAppxContentGroupsEnumerator                    = GUIDOF!IAppxContentGroupsEnumerator;
const GUID IID_IAppxDigestProvider                             = GUIDOF!IAppxDigestProvider;
const GUID IID_IAppxEncryptedBundleWriter                      = GUIDOF!IAppxEncryptedBundleWriter;
const GUID IID_IAppxEncryptedBundleWriter2                     = GUIDOF!IAppxEncryptedBundleWriter2;
const GUID IID_IAppxEncryptedBundleWriter3                     = GUIDOF!IAppxEncryptedBundleWriter3;
const GUID IID_IAppxEncryptedPackageWriter                     = GUIDOF!IAppxEncryptedPackageWriter;
const GUID IID_IAppxEncryptedPackageWriter2                    = GUIDOF!IAppxEncryptedPackageWriter2;
const GUID IID_IAppxEncryptionFactory                          = GUIDOF!IAppxEncryptionFactory;
const GUID IID_IAppxEncryptionFactory2                         = GUIDOF!IAppxEncryptionFactory2;
const GUID IID_IAppxEncryptionFactory3                         = GUIDOF!IAppxEncryptionFactory3;
const GUID IID_IAppxEncryptionFactory4                         = GUIDOF!IAppxEncryptionFactory4;
const GUID IID_IAppxEncryptionFactory5                         = GUIDOF!IAppxEncryptionFactory5;
const GUID IID_IAppxFactory                                    = GUIDOF!IAppxFactory;
const GUID IID_IAppxFactory2                                   = GUIDOF!IAppxFactory2;
const GUID IID_IAppxFactory3                                   = GUIDOF!IAppxFactory3;
const GUID IID_IAppxFactory4                                   = GUIDOF!IAppxFactory4;
const GUID IID_IAppxFile                                       = GUIDOF!IAppxFile;
const GUID IID_IAppxFile2                                      = GUIDOF!IAppxFile2;
const GUID IID_IAppxFilesEnumerator                            = GUIDOF!IAppxFilesEnumerator;
const GUID IID_IAppxManifestApplication                        = GUIDOF!IAppxManifestApplication;
const GUID IID_IAppxManifestApplicationsEnumerator             = GUIDOF!IAppxManifestApplicationsEnumerator;
const GUID IID_IAppxManifestCapabilitiesEnumerator             = GUIDOF!IAppxManifestCapabilitiesEnumerator;
const GUID IID_IAppxManifestDeviceCapabilitiesEnumerator       = GUIDOF!IAppxManifestDeviceCapabilitiesEnumerator;
const GUID IID_IAppxManifestDriverConstraint                   = GUIDOF!IAppxManifestDriverConstraint;
const GUID IID_IAppxManifestDriverConstraintsEnumerator        = GUIDOF!IAppxManifestDriverConstraintsEnumerator;
const GUID IID_IAppxManifestDriverDependenciesEnumerator       = GUIDOF!IAppxManifestDriverDependenciesEnumerator;
const GUID IID_IAppxManifestDriverDependency                   = GUIDOF!IAppxManifestDriverDependency;
const GUID IID_IAppxManifestHostRuntimeDependenciesEnumerator  = GUIDOF!IAppxManifestHostRuntimeDependenciesEnumerator;
const GUID IID_IAppxManifestHostRuntimeDependency              = GUIDOF!IAppxManifestHostRuntimeDependency;
const GUID IID_IAppxManifestHostRuntimeDependency2             = GUIDOF!IAppxManifestHostRuntimeDependency2;
const GUID IID_IAppxManifestMainPackageDependenciesEnumerator  = GUIDOF!IAppxManifestMainPackageDependenciesEnumerator;
const GUID IID_IAppxManifestMainPackageDependency              = GUIDOF!IAppxManifestMainPackageDependency;
const GUID IID_IAppxManifestOSPackageDependenciesEnumerator    = GUIDOF!IAppxManifestOSPackageDependenciesEnumerator;
const GUID IID_IAppxManifestOSPackageDependency                = GUIDOF!IAppxManifestOSPackageDependency;
const GUID IID_IAppxManifestOptionalPackageInfo                = GUIDOF!IAppxManifestOptionalPackageInfo;
const GUID IID_IAppxManifestPackageDependenciesEnumerator      = GUIDOF!IAppxManifestPackageDependenciesEnumerator;
const GUID IID_IAppxManifestPackageDependency                  = GUIDOF!IAppxManifestPackageDependency;
const GUID IID_IAppxManifestPackageDependency2                 = GUIDOF!IAppxManifestPackageDependency2;
const GUID IID_IAppxManifestPackageDependency3                 = GUIDOF!IAppxManifestPackageDependency3;
const GUID IID_IAppxManifestPackageId                          = GUIDOF!IAppxManifestPackageId;
const GUID IID_IAppxManifestPackageId2                         = GUIDOF!IAppxManifestPackageId2;
const GUID IID_IAppxManifestProperties                         = GUIDOF!IAppxManifestProperties;
const GUID IID_IAppxManifestQualifiedResource                  = GUIDOF!IAppxManifestQualifiedResource;
const GUID IID_IAppxManifestQualifiedResourcesEnumerator       = GUIDOF!IAppxManifestQualifiedResourcesEnumerator;
const GUID IID_IAppxManifestReader                             = GUIDOF!IAppxManifestReader;
const GUID IID_IAppxManifestReader2                            = GUIDOF!IAppxManifestReader2;
const GUID IID_IAppxManifestReader3                            = GUIDOF!IAppxManifestReader3;
const GUID IID_IAppxManifestReader4                            = GUIDOF!IAppxManifestReader4;
const GUID IID_IAppxManifestReader5                            = GUIDOF!IAppxManifestReader5;
const GUID IID_IAppxManifestReader6                            = GUIDOF!IAppxManifestReader6;
const GUID IID_IAppxManifestReader7                            = GUIDOF!IAppxManifestReader7;
const GUID IID_IAppxManifestResourcesEnumerator                = GUIDOF!IAppxManifestResourcesEnumerator;
const GUID IID_IAppxManifestTargetDeviceFamiliesEnumerator     = GUIDOF!IAppxManifestTargetDeviceFamiliesEnumerator;
const GUID IID_IAppxManifestTargetDeviceFamily                 = GUIDOF!IAppxManifestTargetDeviceFamily;
const GUID IID_IAppxPackageEditor                              = GUIDOF!IAppxPackageEditor;
const GUID IID_IAppxPackageReader                              = GUIDOF!IAppxPackageReader;
const GUID IID_IAppxPackageWriter                              = GUIDOF!IAppxPackageWriter;
const GUID IID_IAppxPackageWriter2                             = GUIDOF!IAppxPackageWriter2;
const GUID IID_IAppxPackageWriter3                             = GUIDOF!IAppxPackageWriter3;
const GUID IID_IAppxPackagingDiagnosticEventSink               = GUIDOF!IAppxPackagingDiagnosticEventSink;
const GUID IID_IAppxPackagingDiagnosticEventSinkManager        = GUIDOF!IAppxPackagingDiagnosticEventSinkManager;
const GUID IID_IAppxSourceContentGroupMapReader                = GUIDOF!IAppxSourceContentGroupMapReader;
