// Written in the D programming language.

module windows.win32.storage.datadeduplication;

public import windows.core;
public import system : Guid;
public import windows.win32.foundation : BSTR, HRESULT;
public import windows.win32.system.com : IStream, IUnknown;
public import windows.win32.system.variant : VARIANT;

extern(Windows) @nogc nothrow:


// Enums

//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ddpbackup/ne-ddpbackup-dedup_backup_support_param_type))], [])
alias DEDUP_BACKUP_SUPPORT_PARAM_TYPE = int;
enum : int
{
    DEDUP_RECONSTRUCT_UNOPTIMIZED = 0x00000001,
    DEDUP_RECONSTRUCT_OPTIMIZED   = 0x00000002,
}
alias DEDUP_SET_PARAM_TYPE = int;
enum : int
{
    DEDUP_PT_MinChunkSizeBytes            = 0x00000001,
    DEDUP_PT_MaxChunkSizeBytes            = 0x00000002,
    DEDUP_PT_AvgChunkSizeBytes            = 0x00000003,
    DEDUP_PT_InvariantChunking            = 0x00000004,
    DEDUP_PT_DisableStrongHashComputation = 0x00000005,
}
enum DedupDataPortManagerOption : int
{
    DedupDataPortManagerOption_None               = 0x00000000,
    DedupDataPortManagerOption_AutoStart          = 0x00000001,
    DedupDataPortManagerOption_SkipReconciliation = 0x00000002,
}
enum DedupDataPortVolumeStatus : int
{
    DedupDataPortVolumeStatus_Unknown      = 0x00000000,
    DedupDataPortVolumeStatus_NotEnabled   = 0x00000001,
    DedupDataPortVolumeStatus_NotAvailable = 0x00000002,
    DedupDataPortVolumeStatus_Initializing = 0x00000003,
    DedupDataPortVolumeStatus_Ready        = 0x00000004,
    DedupDataPortVolumeStatus_Maintenance  = 0x00000005,
    DedupDataPortVolumeStatus_Shutdown     = 0x00000006,
}
enum DedupDataPortRequestStatus : int
{
    DedupDataPortRequestStatus_Unknown    = 0x00000000,
    DedupDataPortRequestStatus_Queued     = 0x00000001,
    DedupDataPortRequestStatus_Processing = 0x00000002,
    DedupDataPortRequestStatus_Partial    = 0x00000003,
    DedupDataPortRequestStatus_Complete   = 0x00000004,
    DedupDataPortRequestStatus_Failed     = 0x00000005,
}
enum DedupChunkFlags : int
{
    DedupChunkFlags_None       = 0x00000000,
    DedupChunkFlags_Compressed = 0x00000001,
}
enum DedupChunkingAlgorithm : int
{
    DedupChunkingAlgorithm_Unknonwn = 0x00000000,
    DedupChunkingAlgorithm_V1       = 0x00000001,
}
enum DedupHashingAlgorithm : int
{
    DedupHashingAlgorithm_Unknonwn = 0x00000000,
    DedupHashingAlgorithm_V1       = 0x00000001,
}
enum DedupCompressionAlgorithm : int
{
    DedupCompressionAlgorithm_Unknonwn = 0x00000000,
    DedupCompressionAlgorithm_Xpress   = 0x00000001,
}

// Constants


enum uint DEDUP_CHUNKLIB_MAX_CHUNKS_ENUM = 0x00000400;

// Structs


//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ddpbackup/ns-ddpbackup-dedup_container_extent))], [])
struct DEDUP_CONTAINER_EXTENT
{
    uint ContainerIndex;
    long StartOffset;
    long Length;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ddpbackup/ns-ddpbackup-ddp_file_extent))], [])
struct DDP_FILE_EXTENT
{
    long Length;
    long Offset;
}

struct DEDUP_CHUNK_INFO_HASH32
{
    uint      ChunkFlags;
    ulong     ChunkOffsetInStream;
    ulong     ChunkSize;
    ubyte[32] HashVal;
}

struct DedupHash
{
    ubyte[32] Hash;
}

struct DedupChunk
{
    DedupHash       Hash;
    DedupChunkFlags Flags;
    uint            LogicalSize;
    uint            DataSize;
}

struct DedupStreamEntry
{
    DedupHash Hash;
    uint      LogicalSize;
    ulong     Offset;
}

struct DedupStream
{
    BSTR  Path;
    ulong Offset;
    ulong Length;
    uint  ChunkCount;
}

// Interfaces

@GUID("73d6b2ad-2984-4715-b2e3-924c149744dd")
struct DedupBackupSupport;

@GUID("8f107207-1829-48b2-a64b-e61f8e0d9acb")
struct DedupDataPort;

@GUID("7bacc67a-2f1d-42d0-897e-6ff62dd533bb")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ddpbackup/nn-ddpbackup-idedupreadfilecallback))], [])
interface IDedupReadFileCallback : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ddpbackup/nf-ddpbackup-idedupreadfilecallback-readbackupfile))], [])
    HRESULT ReadBackupFile(BSTR FileFullPath, long FileOffset, uint SizeToRead, ubyte* FileBuffer, 
                           uint* ReturnedSize, uint Flags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ddpbackup/nf-ddpbackup-idedupreadfilecallback-ordercontainersrestore))], [])
    HRESULT OrderContainersRestore(uint NumberOfContainers, BSTR* ContainerPaths, uint* ReadPlanEntries, 
                                   DEDUP_CONTAINER_EXTENT** ReadPlan);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ddpbackup/nf-ddpbackup-idedupreadfilecallback-previewcontainerread))], [])
    HRESULT PreviewContainerRead(BSTR FileFullPath, uint NumberOfReads, DDP_FILE_EXTENT* ReadOffsets);
}

@GUID("c719d963-2b2d-415e-acf7-7eb7ca596ff4")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ddpbackup/nn-ddpbackup-idedupbackupsupport))], [])
interface IDedupBackupSupport : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ddpbackup/nf-ddpbackup-idedupbackupsupport-restorefiles))], [])
    HRESULT RestoreFiles(uint NumberOfFiles, BSTR* FileFullPaths, IDedupReadFileCallback Store, uint Flags, 
                         HRESULT* FileResults);
}

@GUID("bb5144d7-2720-4dcc-8777-78597416ec23")
interface IDedupChunkLibrary : IUnknown
{
    HRESULT InitializeForPushBuffers();
    HRESULT Uninitialize();
    HRESULT SetParameter(uint dwParamType, VARIANT vParamValue);
    HRESULT StartChunking(GUID iidIteratorInterfaceID, IUnknown* ppChunksEnum);
}

@GUID("90b584d3-72aa-400f-9767-cad866a5a2d8")
interface IDedupIterateChunksHash32 : IUnknown
{
    HRESULT PushBuffer(ubyte* pBuffer, uint ulBufferLength);
    HRESULT Next(uint ulMaxChunks, DEDUP_CHUNK_INFO_HASH32* pArrChunks, uint* pulFetched);
    HRESULT Drain();
    HRESULT Reset();
}

@GUID("7963d734-40a9-4ea3-bbf6-5a89d26f7ae8")
interface IDedupDataPort : IUnknown
{
    HRESULT GetStatus(DedupDataPortVolumeStatus* pStatus, uint* pDataHeadroomMb);
    HRESULT LookupChunks(uint Count, DedupHash* pHashes, GUID* pRequestId);
    HRESULT InsertChunks(uint ChunkCount, DedupChunk* pChunkMetadata, uint DataByteCount, ubyte* pChunkData, 
                         GUID* pRequestId);
    HRESULT InsertChunksWithStream(uint ChunkCount, DedupChunk* pChunkMetadata, uint DataByteCount, 
                                   IStream pChunkDataStream, GUID* pRequestId);
    HRESULT CommitStreams(uint StreamCount, DedupStream* pStreams, uint EntryCount, DedupStreamEntry* pEntries, 
                          GUID* pRequestId);
    HRESULT CommitStreamsWithStream(uint StreamCount, DedupStream* pStreams, uint EntryCount, 
                                    IStream pEntriesStream, GUID* pRequestId);
    HRESULT GetStreams(uint StreamCount, BSTR* pStreamPaths, GUID* pRequestId);
    HRESULT GetStreamsResults(GUID RequestId, uint MaxWaitMs, uint StreamEntryIndex, uint* pStreamCount, 
                              DedupStream** ppStreams, uint* pEntryCount, DedupStreamEntry** ppEntries, 
                              DedupDataPortRequestStatus* pStatus, HRESULT** ppItemResults);
    HRESULT GetChunks(uint Count, DedupHash* pHashes, GUID* pRequestId);
    HRESULT GetChunksResults(GUID RequestId, uint MaxWaitMs, uint ChunkIndex, uint* pChunkCount, 
                             DedupChunk** ppChunkMetadata, uint* pDataByteCount, ubyte** ppChunkData, 
                             DedupDataPortRequestStatus* pStatus, HRESULT** ppItemResults);
    HRESULT GetRequestStatus(GUID RequestId, DedupDataPortRequestStatus* pStatus);
    HRESULT GetRequestResults(GUID RequestId, uint MaxWaitMs, HRESULT* pBatchResult, uint* pBatchCount, 
                              DedupDataPortRequestStatus* pStatus, HRESULT** ppItemResults);
}

@GUID("44677452-b90a-445e-8192-cdcfe81511fb")
interface IDedupDataPortManager : IUnknown
{
    HRESULT GetConfiguration(uint* pMinChunkSize, uint* pMaxChunkSize, DedupChunkingAlgorithm* pChunkingAlgorithm, 
                             DedupHashingAlgorithm* pHashingAlgorithm, 
                             DedupCompressionAlgorithm* pCompressionAlgorithm);
    HRESULT GetVolumeStatus(uint Options, BSTR Path, DedupDataPortVolumeStatus* pStatus);
    HRESULT GetVolumeDataPort(uint Options, BSTR Path, IDedupDataPort* ppDataPort);
}


// GUIDs

const GUID CLSID_DedupBackupSupport = GUIDOF!DedupBackupSupport;
const GUID CLSID_DedupDataPort      = GUIDOF!DedupDataPort;

const GUID IID_IDedupBackupSupport       = GUIDOF!IDedupBackupSupport;
const GUID IID_IDedupChunkLibrary        = GUIDOF!IDedupChunkLibrary;
const GUID IID_IDedupDataPort            = GUIDOF!IDedupDataPort;
const GUID IID_IDedupDataPortManager     = GUIDOF!IDedupDataPortManager;
const GUID IID_IDedupIterateChunksHash32 = GUIDOF!IDedupIterateChunksHash32;
const GUID IID_IDedupReadFileCallback    = GUIDOF!IDedupReadFileCallback;
