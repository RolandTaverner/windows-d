// Written in the D programming language.

module windows.win32.storage.distributedfilesystem;

public import windows.core;
public import system : Guid;
public import windows.win32.foundation : PWSTR;
public import windows.win32.security : PSECURITY_DESCRIPTOR;

extern(Windows) @nogc nothrow:


// Enums

//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/lmdfs/ne-lmdfs-dfs_target_priority_class~r1))], [])
alias DFS_TARGET_PRIORITY_CLASS = int;
enum : int
{
    DfsInvalidPriorityClass        = 0xffffffff,
    DfsSiteCostNormalPriorityClass = 0x00000000,
    DfsGlobalHighPriorityClass     = 0x00000001,
    DfsSiteCostHighPriorityClass   = 0x00000002,
    DfsSiteCostLowPriorityClass    = 0x00000003,
    DfsGlobalLowPriorityClass      = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/lmdfs/ne-lmdfs-dfs_namespace_version_origin))], [])
alias DFS_NAMESPACE_VERSION_ORIGIN = int;
enum : int
{
    DFS_NAMESPACE_VERSION_ORIGIN_COMBINED = 0x00000000,
    DFS_NAMESPACE_VERSION_ORIGIN_SERVER   = 0x00000001,
    DFS_NAMESPACE_VERSION_ORIGIN_DOMAIN   = 0x00000002,
}

// Constants


enum uint FSCTL_DFS_BASE = 0x00000006;

enum : uint
{
    DFS_VOLUME_STATES              = 0x0000000f,
    DFS_VOLUME_STATE_OK            = 0x00000001,
    DFS_VOLUME_STATE_INCONSISTENT  = 0x00000002,
    DFS_VOLUME_STATE_OFFLINE       = 0x00000003,
    DFS_VOLUME_STATE_ONLINE        = 0x00000004,
    DFS_VOLUME_STATE_RESYNCHRONIZE = 0x00000010,
    DFS_VOLUME_STATE_STANDBY       = 0x00000020,
    DFS_VOLUME_STATE_FORCE_SYNC    = 0x00000040,
    DFS_VOLUME_FLAVORS             = 0x00000300,
    DFS_VOLUME_FLAVOR_UNUSED1      = 0x00000000,
    DFS_VOLUME_FLAVOR_STANDALONE   = 0x00000100,
    DFS_VOLUME_FLAVOR_AD_BLOB      = 0x00000200,
}

enum : uint
{
    DFS_STORAGE_FLAVOR_UNUSED2 = 0x00000300,
    DFS_STORAGE_STATES         = 0x0000000f,
    DFS_STORAGE_STATE_OFFLINE  = 0x00000001,
    DFS_STORAGE_STATE_ONLINE   = 0x00000002,
    DFS_STORAGE_STATE_ACTIVE   = 0x00000004,
}

enum : uint
{
    DFS_PROPERTY_FLAG_INSITE_REFERRALS = 0x00000001,
    DFS_PROPERTY_FLAG_ROOT_SCALABILITY = 0x00000002,
    DFS_PROPERTY_FLAG_SITE_COSTING     = 0x00000004,
    DFS_PROPERTY_FLAG_TARGET_FAILBACK  = 0x00000008,
    DFS_PROPERTY_FLAG_CLUSTER_ENABLED  = 0x00000010,
    DFS_PROPERTY_FLAG_ABDE             = 0x00000020,
}

enum uint DFS_ADD_VOLUME = 0x00000001;
enum uint DFS_RESTORE_VOLUME = 0x00000002;

enum : uint
{
    NET_DFS_SETDC_FLAGS   = 0x00000000,
    NET_DFS_SETDC_TIMEOUT = 0x00000001,
    NET_DFS_SETDC_INITPKT = 0x00000002,
}

enum uint DFS_SITE_PRIMARY = 0x00000001;
enum uint DFS_MOVE_FLAG_REPLACE_IF_EXISTS = 0x00000001;
enum uint DFS_FORCE_REMOVE = 0x80000000;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/dfs/fsctl-dfs-get-pkt-entry-state))], [])*/uint FSCTL_DFS_GET_PKT_ENTRY_STATE = 0x00061fbc;

// Structs


//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(6))], [])
struct DFS_INFO_1_32
{
    uint EntryPath;
}

//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(6))], [])
struct DFS_INFO_2_32
{
    uint EntryPath;
    uint Comment;
    uint State;
    uint NumberOfStorages;
}

//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(6))], [])
struct DFS_STORAGE_INFO_0_32
{
    uint State;
    uint ServerName;
    uint ShareName;
}

//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(6))], [])
struct DFS_INFO_3_32
{
    uint EntryPath;
    uint Comment;
    uint State;
    uint NumberOfStorages;
    uint Storage;
}

//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(6))], [])
struct DFS_INFO_4_32
{
    uint EntryPath;
    uint Comment;
    uint State;
    uint Timeout;
    GUID Guid;
    uint NumberOfStorages;
    uint Storage;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/lmdfs/ns-lmdfs-dfs_target_priority))], [])
struct DFS_TARGET_PRIORITY
{
    DFS_TARGET_PRIORITY_CLASS TargetPriorityClass;
    ushort TargetPriorityRank;
    ushort Reserved;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/lmdfs/ns-lmdfs-dfs_info_1))], [])
struct DFS_INFO_1
{
    PWSTR EntryPath;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/lmdfs/ns-lmdfs-dfs_info_2))], [])
struct DFS_INFO_2
{
    PWSTR EntryPath;
    PWSTR Comment;
    uint  State;
    uint  NumberOfStorages;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/lmdfs/ns-lmdfs-dfs_storage_info))], [])
struct DFS_STORAGE_INFO
{
    uint  State;
    PWSTR ServerName;
    PWSTR ShareName;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/lmdfs/ns-lmdfs-dfs_storage_info_1))], [])
struct DFS_STORAGE_INFO_1
{
    uint                State;
    PWSTR               ServerName;
    PWSTR               ShareName;
    DFS_TARGET_PRIORITY TargetPriority;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/lmdfs/ns-lmdfs-dfs_info_3))], [])
struct DFS_INFO_3
{
    PWSTR             EntryPath;
    PWSTR             Comment;
    uint              State;
    uint              NumberOfStorages;
    DFS_STORAGE_INFO* Storage;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/lmdfs/ns-lmdfs-dfs_info_4))], [])
struct DFS_INFO_4
{
    PWSTR             EntryPath;
    PWSTR             Comment;
    uint              State;
    uint              Timeout;
    GUID              Guid;
    uint              NumberOfStorages;
    DFS_STORAGE_INFO* Storage;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/lmdfs/ns-lmdfs-dfs_info_5))], [])
struct DFS_INFO_5
{
    PWSTR EntryPath;
    PWSTR Comment;
    uint  State;
    uint  Timeout;
    GUID  Guid;
    uint  PropertyFlags;
    uint  MetadataSize;
    uint  NumberOfStorages;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/lmdfs/ns-lmdfs-dfs_info_6))], [])
struct DFS_INFO_6
{
    PWSTR               EntryPath;
    PWSTR               Comment;
    uint                State;
    uint                Timeout;
    GUID                Guid;
    uint                PropertyFlags;
    uint                MetadataSize;
    uint                NumberOfStorages;
    DFS_STORAGE_INFO_1* Storage;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/lmdfs/ns-lmdfs-dfs_info_7))], [])
struct DFS_INFO_7
{
    GUID GenerationGuid;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/lmdfs/ns-lmdfs-dfs_info_8))], [])
struct DFS_INFO_8
{
    PWSTR                EntryPath;
    PWSTR                Comment;
    uint                 State;
    uint                 Timeout;
    GUID                 Guid;
    uint                 PropertyFlags;
    uint                 MetadataSize;
    uint                 SdLengthReserved;
    PSECURITY_DESCRIPTOR pSecurityDescriptor;
    uint                 NumberOfStorages;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/lmdfs/ns-lmdfs-dfs_info_9))], [])
struct DFS_INFO_9
{
    PWSTR                EntryPath;
    PWSTR                Comment;
    uint                 State;
    uint                 Timeout;
    GUID                 Guid;
    uint                 PropertyFlags;
    uint                 MetadataSize;
    uint                 SdLengthReserved;
    PSECURITY_DESCRIPTOR pSecurityDescriptor;
    uint                 NumberOfStorages;
    DFS_STORAGE_INFO_1*  Storage;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/lmdfs/ns-lmdfs-dfs_info_50))], [])
struct DFS_INFO_50
{
    uint  NamespaceMajorVersion;
    uint  NamespaceMinorVersion;
    ulong NamespaceCapabilities;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/lmdfs/ns-lmdfs-dfs_info_100))], [])
struct DFS_INFO_100
{
    PWSTR Comment;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/lmdfs/ns-lmdfs-dfs_info_101))], [])
struct DFS_INFO_101
{
    uint State;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/lmdfs/ns-lmdfs-dfs_info_102))], [])
struct DFS_INFO_102
{
    uint Timeout;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/lmdfs/ns-lmdfs-dfs_info_103))], [])
struct DFS_INFO_103
{
    uint PropertyFlagMask;
    uint PropertyFlags;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/lmdfs/ns-lmdfs-dfs_info_104))], [])
struct DFS_INFO_104
{
    DFS_TARGET_PRIORITY TargetPriority;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/lmdfs/ns-lmdfs-dfs_info_105))], [])
struct DFS_INFO_105
{
    PWSTR Comment;
    uint  State;
    uint  Timeout;
    uint  PropertyFlagMask;
    uint  PropertyFlags;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/lmdfs/ns-lmdfs-dfs_info_106))], [])
struct DFS_INFO_106
{
    uint                State;
    DFS_TARGET_PRIORITY TargetPriority;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/lmdfs/ns-lmdfs-dfs_info_107))], [])
struct DFS_INFO_107
{
    PWSTR                Comment;
    uint                 State;
    uint                 Timeout;
    uint                 PropertyFlagMask;
    uint                 PropertyFlags;
    uint                 SdLengthReserved;
    PSECURITY_DESCRIPTOR pSecurityDescriptor;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/lmdfs/ns-lmdfs-dfs_info_150))], [])
struct DFS_INFO_150
{
    uint                 SdLengthReserved;
    PSECURITY_DESCRIPTOR pSecurityDescriptor;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/lmdfs/ns-lmdfs-dfs_info_200))], [])
struct DFS_INFO_200
{
    PWSTR FtDfsName;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/lmdfs/ns-lmdfs-dfs_info_300))], [])
struct DFS_INFO_300
{
    uint  Flags;
    PWSTR DfsName;
}

struct DFS_SITENAME_INFO
{
    uint  SiteFlags;
    PWSTR SiteName;
}

struct DFS_SITELIST_INFO
{
    uint cSites;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/DFS_SITENAME_INFO[1] Site;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/lmdfs/ns-lmdfs-dfs_supported_namespace_version_info))], [])
struct DFS_SUPPORTED_NAMESPACE_VERSION_INFO
{
    uint  DomainDfsMajorVersion;
    uint  DomainDfsMinorVersion;
    ulong DomainDfsCapabilities;
    uint  StandaloneDfsMajorVersion;
    uint  StandaloneDfsMinorVersion;
    ulong StandaloneDfsCapabilities;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/lmdfs/ns-lmdfs-dfs_get_pkt_entry_state_arg))], [])
struct DFS_GET_PKT_ENTRY_STATE_ARG
{
    ushort DfsEntryPathLen;
    ushort ServerNameLen;
    ushort ShareNameLen;
    uint   Level;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/wchar[1] Buffer;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
uint NetDfsAdd(PWSTR DfsEntryPath, PWSTR ServerName, PWSTR ShareName, PWSTR Comment, uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
uint NetDfsAddStdRoot(PWSTR ServerName, PWSTR RootShare, PWSTR Comment, uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
uint NetDfsRemoveStdRoot(PWSTR ServerName, PWSTR RootShare, 
                         /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
uint NetDfsAddFtRoot(PWSTR ServerName, PWSTR RootShare, PWSTR FtDfsName, PWSTR Comment, uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
uint NetDfsRemoveFtRoot(PWSTR ServerName, PWSTR RootShare, PWSTR FtDfsName, 
                        /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
uint NetDfsRemoveFtRootForced(PWSTR DomainName, PWSTR ServerName, PWSTR RootShare, PWSTR FtDfsName, 
                              /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
uint NetDfsRemove(PWSTR DfsEntryPath, PWSTR ServerName, PWSTR ShareName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
uint NetDfsEnum(PWSTR DfsName, uint Level, uint PrefMaxLen, ubyte** Buffer, uint* EntriesRead, uint* ResumeHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
uint NetDfsGetInfo(PWSTR DfsEntryPath, PWSTR ServerName, PWSTR ShareName, uint Level, ubyte** Buffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
uint NetDfsSetInfo(PWSTR DfsEntryPath, PWSTR ServerName, PWSTR ShareName, uint Level, ubyte* Buffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
uint NetDfsGetClientInfo(PWSTR DfsEntryPath, PWSTR ServerName, PWSTR ShareName, uint Level, ubyte** Buffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
uint NetDfsSetClientInfo(PWSTR DfsEntryPath, PWSTR ServerName, PWSTR ShareName, uint Level, ubyte* Buffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
uint NetDfsMove(PWSTR OldDfsEntryPath, PWSTR NewDfsEntryPath, uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
uint NetDfsAddRootTarget(PWSTR pDfsPath, PWSTR pTargetPath, uint MajorVersion, PWSTR pComment, uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
uint NetDfsRemoveRootTarget(PWSTR pDfsPath, PWSTR pTargetPath, uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
uint NetDfsGetSecurity(PWSTR DfsEntryPath, uint SecurityInformation, PSECURITY_DESCRIPTOR* ppSecurityDescriptor, 
                       uint* lpcbSecurityDescriptor);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
uint NetDfsSetSecurity(PWSTR DfsEntryPath, uint SecurityInformation, PSECURITY_DESCRIPTOR pSecurityDescriptor);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
uint NetDfsGetStdContainerSecurity(PWSTR MachineName, uint SecurityInformation, 
                                   PSECURITY_DESCRIPTOR* ppSecurityDescriptor, uint* lpcbSecurityDescriptor);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
uint NetDfsSetStdContainerSecurity(PWSTR MachineName, uint SecurityInformation, 
                                   PSECURITY_DESCRIPTOR pSecurityDescriptor);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
uint NetDfsGetFtContainerSecurity(PWSTR DomainName, uint SecurityInformation, 
                                  PSECURITY_DESCRIPTOR* ppSecurityDescriptor, uint* lpcbSecurityDescriptor);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
uint NetDfsSetFtContainerSecurity(PWSTR DomainName, uint SecurityInformation, 
                                  PSECURITY_DESCRIPTOR pSecurityDescriptor);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
uint NetDfsGetSupportedNamespaceVersion(DFS_NAMESPACE_VERSION_ORIGIN Origin, PWSTR pName, 
                                        DFS_SUPPORTED_NAMESPACE_VERSION_INFO** ppVersionInfo);


