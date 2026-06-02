// Written in the D programming language.

module windows.win32.storage.installablefilesystems;

public import windows.core;
public import windows.win32.foundation : HANDLE, HRESULT, NTSTATUS, PWSTR;
public import windows.win32.security : SECURITY_ATTRIBUTES;
public import windows.win32.system.io : OVERLAPPED;

extern(Windows) @nogc nothrow:


// Enums


alias FLT_FILESYSTEM_TYPE = int;
enum : int
{
    FLT_FSTYPE_UNKNOWN    = 0x00000000,
    FLT_FSTYPE_RAW        = 0x00000001,
    FLT_FSTYPE_NTFS       = 0x00000002,
    FLT_FSTYPE_FAT        = 0x00000003,
    FLT_FSTYPE_CDFS       = 0x00000004,
    FLT_FSTYPE_UDFS       = 0x00000005,
    FLT_FSTYPE_LANMAN     = 0x00000006,
    FLT_FSTYPE_WEBDAV     = 0x00000007,
    FLT_FSTYPE_RDPDR      = 0x00000008,
    FLT_FSTYPE_NFS        = 0x00000009,
    FLT_FSTYPE_MS_NETWARE = 0x0000000a,
    FLT_FSTYPE_NETWARE    = 0x0000000b,
    FLT_FSTYPE_BSUDF      = 0x0000000c,
    FLT_FSTYPE_MUP        = 0x0000000d,
    FLT_FSTYPE_RSFX       = 0x0000000e,
    FLT_FSTYPE_ROXIO_UDF1 = 0x0000000f,
    FLT_FSTYPE_ROXIO_UDF2 = 0x00000010,
    FLT_FSTYPE_ROXIO_UDF3 = 0x00000011,
    FLT_FSTYPE_TACIT      = 0x00000012,
    FLT_FSTYPE_FS_REC     = 0x00000013,
    FLT_FSTYPE_INCD       = 0x00000014,
    FLT_FSTYPE_INCD_FAT   = 0x00000015,
    FLT_FSTYPE_EXFAT      = 0x00000016,
    FLT_FSTYPE_PSFS       = 0x00000017,
    FLT_FSTYPE_GPFS       = 0x00000018,
    FLT_FSTYPE_NPFS       = 0x00000019,
    FLT_FSTYPE_MSFS       = 0x0000001a,
    FLT_FSTYPE_CSVFS      = 0x0000001b,
    FLT_FSTYPE_REFS       = 0x0000001c,
    FLT_FSTYPE_OPENAFS    = 0x0000001d,
    FLT_FSTYPE_CIMFS      = 0x0000001e,
}

alias FILTER_INFORMATION_CLASS = int;
enum : int
{
    FilterFullInformation              = 0x00000000,
    FilterAggregateBasicInformation    = 0x00000001,
    FilterAggregateStandardInformation = 0x00000002,
}

alias FILTER_VOLUME_INFORMATION_CLASS = int;
enum : int
{
    FilterVolumeBasicInformation    = 0x00000000,
    FilterVolumeStandardInformation = 0x00000001,
}

alias INSTANCE_INFORMATION_CLASS = int;
enum : int
{
    InstanceBasicInformation             = 0x00000000,
    InstancePartialInformation           = 0x00000001,
    InstanceFullInformation              = 0x00000002,
    InstanceAggregateStandardInformation = 0x00000003,
}

// Constants


enum uint FILTER_NAME_MAX_CHARS = 0x000000ffU;
enum uint VOLUME_NAME_MAX_CHARS = 0x00000400U;
enum uint INSTANCE_NAME_MAX_CHARS = 0x000000ffU;

enum : uint
{
    FLTFL_AGGREGATE_INFO_IS_MINIFILTER   = 0x00000001U,
    FLTFL_AGGREGATE_INFO_IS_LEGACYFILTER = 0x00000002U,
}

enum : uint
{
    FLTFL_ASI_IS_MINIFILTER   = 0x00000001U,
    FLTFL_ASI_IS_LEGACYFILTER = 0x00000002U,
}

enum uint FLTFL_VSI_DETACHED_VOLUME = 0x00000001U;

enum : uint
{
    FLTFL_IASI_IS_MINIFILTER   = 0x00000001U,
    FLTFL_IASI_IS_LEGACYFILTER = 0x00000002U,
}

enum uint FLTFL_IASIM_DETACHED_VOLUME = 0x00000001U;
enum uint FLTFL_IASIL_DETACHED_VOLUME = 0x00000001U;
enum uint FLT_PORT_FLAG_SYNC_HANDLE = 0x00000001U;

enum : uint
{
    WNNC_NET_MSNET       = 0x00010000U,
    WNNC_NET_SMB         = 0x00020000U,
    WNNC_NET_NETWARE     = 0x00030000U,
    WNNC_NET_VINES       = 0x00040000U,
    WNNC_NET_10NET       = 0x00050000U,
    WNNC_NET_LOCUS       = 0x00060000U,
    WNNC_NET_SUN_PC_NFS  = 0x00070000U,
    WNNC_NET_LANSTEP     = 0x00080000U,
    WNNC_NET_9TILES      = 0x00090000U,
    WNNC_NET_LANTASTIC   = 0x000a0000U,
    WNNC_NET_AS400       = 0x000b0000U,
    WNNC_NET_FTP_NFS     = 0x000c0000U,
    WNNC_NET_PATHWORKS   = 0x000d0000U,
    WNNC_NET_LIFENET     = 0x000e0000U,
    WNNC_NET_POWERLAN    = 0x000f0000U,
    WNNC_NET_BWNFS       = 0x00100000U,
    WNNC_NET_COGENT      = 0x00110000U,
    WNNC_NET_FARALLON    = 0x00120000U,
    WNNC_NET_APPLETALK   = 0x00130000U,
    WNNC_NET_INTERGRAPH  = 0x00140000U,
    WNNC_NET_SYMFONET    = 0x00150000U,
    WNNC_NET_CLEARCASE   = 0x00160000U,
    WNNC_NET_FRONTIER    = 0x00170000U,
    WNNC_NET_BMC         = 0x00180000U,
    WNNC_NET_DCE         = 0x00190000U,
    WNNC_NET_AVID        = 0x001a0000U,
    WNNC_NET_DOCUSPACE   = 0x001b0000U,
    WNNC_NET_MANGOSOFT   = 0x001c0000U,
    WNNC_NET_SERNET      = 0x001d0000U,
    WNNC_NET_RIVERFRONT1 = 0x001e0000U,
    WNNC_NET_RIVERFRONT2 = 0x001f0000U,
    WNNC_NET_DECORB      = 0x00200000U,
    WNNC_NET_PROTSTOR    = 0x00210000U,
    WNNC_NET_FJ_REDIR    = 0x00220000U,
    WNNC_NET_DISTINCT    = 0x00230000U,
    WNNC_NET_TWINS       = 0x00240000U,
    WNNC_NET_RDR2SAMPLE  = 0x00250000U,
    WNNC_NET_CSC         = 0x00260000U,
    WNNC_NET_3IN1        = 0x00270000U,
    WNNC_NET_EXTENDNET   = 0x00290000U,
    WNNC_NET_STAC        = 0x002a0000U,
    WNNC_NET_FOXBAT      = 0x002b0000U,
    WNNC_NET_YAHOO       = 0x002c0000U,
    WNNC_NET_EXIFS       = 0x002d0000U,
    WNNC_NET_DAV         = 0x002e0000U,
    WNNC_NET_KNOWARE     = 0x002f0000U,
    WNNC_NET_OBJECT_DIRE = 0x00300000U,
    WNNC_NET_MASFAX      = 0x00310000U,
    WNNC_NET_HOB_NFS     = 0x00320000U,
    WNNC_NET_SHIVA       = 0x00330000U,
    WNNC_NET_IBMAL       = 0x00340000U,
    WNNC_NET_LOCK        = 0x00350000U,
    WNNC_NET_TERMSRV     = 0x00360000U,
    WNNC_NET_SRT         = 0x00370000U,
    WNNC_NET_QUINCY      = 0x00380000U,
    WNNC_NET_OPENAFS     = 0x00390000U,
    WNNC_NET_AVID1       = 0x003a0000U,
    WNNC_NET_DFS         = 0x003b0000U,
    WNNC_NET_KWNP        = 0x003c0000U,
    WNNC_NET_ZENWORKS    = 0x003d0000U,
    WNNC_NET_DRIVEONWEB  = 0x003e0000U,
    WNNC_NET_VMWARE      = 0x003f0000U,
    WNNC_NET_RSFX        = 0x00400000U,
    WNNC_NET_MFILES      = 0x00410000U,
    WNNC_NET_MS_NFS      = 0x00420000U,
    WNNC_NET_GOOGLE      = 0x00430000U,
    WNNC_NET_NDFS        = 0x00440000U,
    WNNC_NET_DOCUSHARE   = 0x00450000U,
    WNNC_NET_AURISTOR_FS = 0x00460000U,
    WNNC_NET_SECUREAGENT = 0x00470000U,
    WNNC_NET_9P          = 0x00480000U,
    WNNC_CRED_MANAGER    = 0xffff0000U,
}

enum uint WNNC_NET_LANMAN = 0x00020000U;

// Structs


@RAIIFree!FilterClose
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HFILTER
{
    ptrdiff_t Value;
}

@RAIIFree!FilterInstanceClose
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HFILTER_INSTANCE
{
    ptrdiff_t Value;
}

struct FILTER_FULL_INFORMATION
{
    uint     NextEntryOffset;
    uint     FrameID;
    uint     NumberOfInstances;
    ushort   FilterNameLength;
    wchar[1] FilterNameBuffer; // Flexible array
}

struct FILTER_AGGREGATE_BASIC_INFORMATION
{
    uint NextEntryOffset;
    uint Flags;
    union Type
    {
        struct MiniFilter
        {
            uint   FrameID;
            uint   NumberOfInstances;
            ushort FilterNameLength;
            ushort FilterNameBufferOffset;
            ushort FilterAltitudeLength;
            ushort FilterAltitudeBufferOffset;
        }
        struct LegacyFilter
        {
            ushort FilterNameLength;
            ushort FilterNameBufferOffset;
        }
    }
}

struct FILTER_AGGREGATE_STANDARD_INFORMATION
{
    uint NextEntryOffset;
    uint Flags;
    union Type
    {
        struct MiniFilter
        {
            uint   Flags;
            uint   FrameID;
            uint   NumberOfInstances;
            ushort FilterNameLength;
            ushort FilterNameBufferOffset;
            ushort FilterAltitudeLength;
            ushort FilterAltitudeBufferOffset;
        }
        struct LegacyFilter
        {
            uint   Flags;
            ushort FilterNameLength;
            ushort FilterNameBufferOffset;
            ushort FilterAltitudeLength;
            ushort FilterAltitudeBufferOffset;
        }
    }
}

struct FILTER_VOLUME_BASIC_INFORMATION
{
    ushort   FilterVolumeNameLength;
    wchar[1] FilterVolumeName; // Flexible array
}

struct FILTER_VOLUME_STANDARD_INFORMATION
{
    uint                NextEntryOffset;
    uint                Flags;
    uint                FrameID;
    FLT_FILESYSTEM_TYPE FileSystemType;
    ushort              FilterVolumeNameLength;
    wchar[1]            FilterVolumeName; // Flexible array
}

struct INSTANCE_BASIC_INFORMATION
{
    uint   NextEntryOffset;
    ushort InstanceNameLength;
    ushort InstanceNameBufferOffset;
}

struct INSTANCE_PARTIAL_INFORMATION
{
    uint   NextEntryOffset;
    ushort InstanceNameLength;
    ushort InstanceNameBufferOffset;
    ushort AltitudeLength;
    ushort AltitudeBufferOffset;
}

struct INSTANCE_FULL_INFORMATION
{
    uint   NextEntryOffset;
    ushort InstanceNameLength;
    ushort InstanceNameBufferOffset;
    ushort AltitudeLength;
    ushort AltitudeBufferOffset;
    ushort VolumeNameLength;
    ushort VolumeNameBufferOffset;
    ushort FilterNameLength;
    ushort FilterNameBufferOffset;
}

struct INSTANCE_AGGREGATE_STANDARD_INFORMATION
{
    uint NextEntryOffset;
    uint Flags;
    union Type
    {
        struct MiniFilter
        {
            uint                Flags;
            uint                FrameID;
            FLT_FILESYSTEM_TYPE VolumeFileSystemType;
            ushort              InstanceNameLength;
            ushort              InstanceNameBufferOffset;
            ushort              AltitudeLength;
            ushort              AltitudeBufferOffset;
            ushort              VolumeNameLength;
            ushort              VolumeNameBufferOffset;
            ushort              FilterNameLength;
            ushort              FilterNameBufferOffset;
            uint                SupportedFeatures;
        }
        struct LegacyFilter
        {
            uint   Flags;
            ushort AltitudeLength;
            ushort AltitudeBufferOffset;
            ushort VolumeNameLength;
            ushort VolumeNameBufferOffset;
            ushort FilterNameLength;
            ushort FilterNameBufferOffset;
            uint   SupportedFeatures;
        }
    }
}

struct FILTER_MESSAGE_HEADER
{
    uint  ReplyLength;
    ulong MessageId;
}

struct FILTER_REPLY_HEADER
{
    NTSTATUS Status;
    ulong    MessageId;
}

// Functions

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fltuser/nf-fltuser-filterload
@DllImport("FLTLIB.dll")
HRESULT FilterLoad(const(PWSTR) lpFilterName);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fltuser/nf-fltuser-filterunload
@DllImport("FLTLIB.dll")
HRESULT FilterUnload(const(PWSTR) lpFilterName);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fltuser/nf-fltuser-filtercreate
@DllImport("FLTLIB.dll")
HRESULT FilterCreate(const(PWSTR) lpFilterName, HFILTER* hFilter);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fltuser/nf-fltuser-filterclose
@DllImport("FLTLIB.dll")
HRESULT FilterClose(HFILTER hFilter);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fltuser/nf-fltuser-filterinstancecreate
@DllImport("FLTLIB.dll")
HRESULT FilterInstanceCreate(const(PWSTR) lpFilterName, const(PWSTR) lpVolumeName, const(PWSTR) lpInstanceName, 
                             HFILTER_INSTANCE* hInstance);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fltuser/nf-fltuser-filterinstanceclose
@DllImport("FLTLIB.dll")
HRESULT FilterInstanceClose(HFILTER_INSTANCE hInstance);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fltuser/nf-fltuser-filterattach
@DllImport("FLTLIB.dll")
HRESULT FilterAttach(const(PWSTR) lpFilterName, const(PWSTR) lpVolumeName, const(PWSTR) lpInstanceName, 
                     uint dwCreatedInstanceNameLength, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/PWSTR lpCreatedInstanceName);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fltuser/nf-fltuser-filterattachataltitude
@DllImport("FLTLIB.dll")
HRESULT FilterAttachAtAltitude(const(PWSTR) lpFilterName, const(PWSTR) lpVolumeName, const(PWSTR) lpAltitude, 
                               const(PWSTR) lpInstanceName, uint dwCreatedInstanceNameLength, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/PWSTR lpCreatedInstanceName);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fltuser/nf-fltuser-filterdetach
@DllImport("FLTLIB.dll")
HRESULT FilterDetach(const(PWSTR) lpFilterName, const(PWSTR) lpVolumeName, const(PWSTR) lpInstanceName);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fltuser/nf-fltuser-filterfindfirst
@DllImport("FLTLIB.dll")
HRESULT FilterFindFirst(FILTER_INFORMATION_CLASS dwInformationClass, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* lpBuffer, 
                        uint dwBufferSize, uint* lpBytesReturned, 
                        /*PARAM ATTR: RAIIFreeAttribute : CustomAttributeSig([FixedArgSig(ElementSig(FilterFindClose))], [])*/HANDLE* lpFilterFind);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fltuser/nf-fltuser-filterfindnext
@DllImport("FLTLIB.dll")
HRESULT FilterFindNext(HANDLE hFilterFind, FILTER_INFORMATION_CLASS dwInformationClass, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpBuffer, 
                       uint dwBufferSize, uint* lpBytesReturned);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fltuser/nf-fltuser-filterfindclose
@DllImport("FLTLIB.dll")
HRESULT FilterFindClose(HANDLE hFilterFind);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fltuser/nf-fltuser-filtervolumefindfirst
@DllImport("FLTLIB.dll")
HRESULT FilterVolumeFindFirst(FILTER_VOLUME_INFORMATION_CLASS dwInformationClass, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* lpBuffer, 
                              uint dwBufferSize, uint* lpBytesReturned, 
                              /*PARAM ATTR: RAIIFreeAttribute : CustomAttributeSig([FixedArgSig(ElementSig(FilterVolumeFindClose))], [])*/HANDLE* lpVolumeFind);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fltuser/nf-fltuser-filtervolumefindnext
@DllImport("FLTLIB.dll")
HRESULT FilterVolumeFindNext(HANDLE hVolumeFind, FILTER_VOLUME_INFORMATION_CLASS dwInformationClass, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpBuffer, 
                             uint dwBufferSize, uint* lpBytesReturned);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fltuser/nf-fltuser-filtervolumefindclose
@DllImport("FLTLIB.dll")
HRESULT FilterVolumeFindClose(HANDLE hVolumeFind);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fltuser/nf-fltuser-filterinstancefindfirst
@DllImport("FLTLIB.dll")
HRESULT FilterInstanceFindFirst(const(PWSTR) lpFilterName, INSTANCE_INFORMATION_CLASS dwInformationClass, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpBuffer, 
                                uint dwBufferSize, uint* lpBytesReturned, 
                                /*PARAM ATTR: RAIIFreeAttribute : CustomAttributeSig([FixedArgSig(ElementSig(FilterInstanceFindClose))], [])*/HANDLE* lpFilterInstanceFind);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fltuser/nf-fltuser-filterinstancefindnext
@DllImport("FLTLIB.dll")
HRESULT FilterInstanceFindNext(HANDLE hFilterInstanceFind, INSTANCE_INFORMATION_CLASS dwInformationClass, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpBuffer, 
                               uint dwBufferSize, uint* lpBytesReturned);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fltuser/nf-fltuser-filterinstancefindclose
@DllImport("FLTLIB.dll")
HRESULT FilterInstanceFindClose(HANDLE hFilterInstanceFind);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fltuser/nf-fltuser-filtervolumeinstancefindfirst
@DllImport("FLTLIB.dll")
HRESULT FilterVolumeInstanceFindFirst(const(PWSTR) lpVolumeName, INSTANCE_INFORMATION_CLASS dwInformationClass, 
                                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpBuffer, 
                                      uint dwBufferSize, uint* lpBytesReturned, 
                                      /*PARAM ATTR: RAIIFreeAttribute : CustomAttributeSig([FixedArgSig(ElementSig(FilterVolumeInstanceFindClose))], [])*/HANDLE* lpVolumeInstanceFind);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fltuser/nf-fltuser-filtervolumeinstancefindnext
@DllImport("FLTLIB.dll")
HRESULT FilterVolumeInstanceFindNext(HANDLE hVolumeInstanceFind, INSTANCE_INFORMATION_CLASS dwInformationClass, 
                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpBuffer, 
                                     uint dwBufferSize, uint* lpBytesReturned);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fltuser/nf-fltuser-filtervolumeinstancefindclose
@DllImport("FLTLIB.dll")
HRESULT FilterVolumeInstanceFindClose(HANDLE hVolumeInstanceFind);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fltuser/nf-fltuser-filtergetinformation
@DllImport("FLTLIB.dll")
HRESULT FilterGetInformation(HFILTER hFilter, FILTER_INFORMATION_CLASS dwInformationClass, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpBuffer, 
                             uint dwBufferSize, uint* lpBytesReturned);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fltuser/nf-fltuser-filterinstancegetinformation
@DllImport("FLTLIB.dll")
HRESULT FilterInstanceGetInformation(HFILTER_INSTANCE hInstance, INSTANCE_INFORMATION_CLASS dwInformationClass, 
                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpBuffer, 
                                     uint dwBufferSize, uint* lpBytesReturned);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fltuser/nf-fltuser-filterconnectcommunicationport
@DllImport("FLTLIB.dll")
HRESULT FilterConnectCommunicationPort(const(PWSTR) lpPortName, uint dwOptions, 
                                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/const(void)* lpContext, 
                                       ushort wSizeOfContext, SECURITY_ATTRIBUTES* lpSecurityAttributes, 
                                       HANDLE* hPort);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fltuser/nf-fltuser-filtersendmessage
@DllImport("FLTLIB.dll")
HRESULT FilterSendMessage(HANDLE hPort, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* lpInBuffer, 
                          uint dwInBufferSize, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* lpOutBuffer, 
                          uint dwOutBufferSize, uint* lpBytesReturned);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fltuser/nf-fltuser-filtergetmessage
@DllImport("FLTLIB.dll")
HRESULT FilterGetMessage(HANDLE hPort, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/FILTER_MESSAGE_HEADER* lpMessageBuffer, 
                         uint dwMessageBufferSize, OVERLAPPED* lpOverlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("FLTLIB.dll")
HRESULT FilterReplyMessage(HANDLE hPort, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/FILTER_REPLY_HEADER* lpReplyBuffer, 
                           uint dwReplyBufferSize);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fltuser/nf-fltuser-filtergetdosname
@DllImport("FLTLIB.dll")
HRESULT FilterGetDosName(const(PWSTR) lpVolumeName, PWSTR lpDosName, uint dwDosNameBufferSize);


