// Written in the D programming language.

module windows.win32.networking.remotedifferentialcompression;

public import windows.core;
public import windows.win32.foundation.foundation : BOOL, HRESULT, PWSTR;
public import windows.win32.system.com.com : IUnknown;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/ne-msrdc-rdc_errorcode
alias RDC_ErrorCode = int;
enum : int
{
    RDC_NoError                = 0x00000000,
    RDC_HeaderVersionNewer     = 0x00000001,
    RDC_HeaderVersionOlder     = 0x00000002,
    RDC_HeaderMissingOrCorrupt = 0x00000003,
    RDC_HeaderWrongType        = 0x00000004,
    RDC_DataMissingOrCorrupt   = 0x00000005,
    RDC_DataTooManyRecords     = 0x00000006,
    RDC_FileChecksumMismatch   = 0x00000007,
    RDC_ApplicationError       = 0x00000008,
    RDC_Aborted                = 0x00000009,
    RDC_Win32Error             = 0x0000000a,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/ne-msrdc-generatorparameterstype
enum GeneratorParametersType : int
{
    RDCGENTYPE_Unused    = 0x00000000,
    RDCGENTYPE_FilterMax = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/ne-msrdc-rdcneedtype
enum RdcNeedType : int
{
    RDCNEED_SOURCE   = 0x00000000,
    RDCNEED_TARGET   = 0x00000001,
    RDCNEED_SEED     = 0x00000002,
    RDCNEED_SEED_MAX = 0x000000ff,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/ne-msrdc-rdccreatedtables
enum RdcCreatedTables : int
{
    RDCTABLE_InvalidOrUnknown = 0x00000000,
    RDCTABLE_Existing         = 0x00000001,
    RDCTABLE_New              = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/ne-msrdc-rdcmappingaccessmode
enum RdcMappingAccessMode : int
{
    RDCMAPPING_Undefined = 0x00000000,
    RDCMAPPING_ReadOnly  = 0x00000001,
    RDCMAPPING_ReadWrite = 0x00000002,
}

// Constants


enum : uint
{
    RDCE_TABLE_FULL    = 0x80040001U,
    RDCE_TABLE_CORRUPT = 0x80040002U,
}

enum uint MSRDC_SIGNATURE_HASHSIZE = 0x00000010U;

enum : uint
{
    SimilarityFileIdMinSize = 0x00000004U,
    SimilarityFileIdMaxSize = 0x00000020U,
}

enum : uint
{
    MSRDC_VERSION                        = 0x00010000U,
    MSRDC_MINIMUM_COMPATIBLE_APP_VERSION = 0x00010000U,
}

enum uint MSRDC_MINIMUM_DEPTH = 0x00000001U;
enum uint MSRDC_MAXIMUM_DEPTH = 0x00000008U;
enum uint MSRDC_MINIMUM_COMPAREBUFFER = 0x000186a0U;
enum uint MSRDC_MAXIMUM_COMPAREBUFFER = 0x40000000U;
enum uint MSRDC_DEFAULT_COMPAREBUFFER = 0x0030d400U;

enum : uint
{
    MSRDC_MINIMUM_INPUTBUFFERSIZE = 0x00000400U,
    MSRDC_MINIMUM_HORIZONSIZE     = 0x00000080U,
}

enum uint MSRDC_MAXIMUM_HORIZONSIZE = 0x00004000U;
enum uint MSRDC_MINIMUM_HASHWINDOWSIZE = 0x00000002U;
enum uint MSRDC_MAXIMUM_HASHWINDOWSIZE = 0x00000060U;

enum : uint
{
    MSRDC_DEFAULT_HASHWINDOWSIZE_1 = 0x00000030U,
    MSRDC_DEFAULT_HORIZONSIZE_1    = 0x00000400U,
    MSRDC_DEFAULT_HASHWINDOWSIZE_N = 0x00000002U,
    MSRDC_DEFAULT_HORIZONSIZE_N    = 0x00000080U,
}

enum uint MSRDC_MAXIMUM_TRAITVALUE = 0x0000003fU;
enum uint MSRDC_MINIMUM_MATCHESREQUIRED = 0x00000001U;
enum uint MSRDC_MAXIMUM_MATCHESREQUIRED = 0x00000010U;

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/ns-msrdc-rdcneed
struct RdcNeed
{
    RdcNeedType m_BlockType;
    ulong       m_FileOffset;
    ulong       m_BlockLength;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/ns-msrdc-rdcbufferpointer
struct RdcBufferPointer
{
    uint   m_Size;
    uint   m_Used;
    ubyte* m_Data;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/ns-msrdc-rdcneedpointer
struct RdcNeedPointer
{
    uint     m_Size;
    uint     m_Used;
    RdcNeed* m_Data;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/ns-msrdc-rdcsignature
struct RdcSignature
{
    ubyte[16] m_Signature;
    ushort    m_BlockLength;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/ns-msrdc-rdcsignaturepointer
struct RdcSignaturePointer
{
    uint          m_Size;
    uint          m_Used;
    RdcSignature* m_Data;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/ns-msrdc-similaritymappedviewinfo
struct SimilarityMappedViewInfo
{
    ubyte* m_Data;
    uint   m_Length;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/ns-msrdc-similaritydata
struct SimilarityData
{
    ubyte[16] m_Data;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/ns-msrdc-findsimilarfileindexresults
struct FindSimilarFileIndexResults
{
    uint m_FileIndex;
    uint m_MatchCount;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/ns-msrdc-similaritydumpdata
struct SimilarityDumpData
{
    uint           m_FileIndex;
    SimilarityData m_Data;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/ns-msrdc-similarityfileid
struct SimilarityFileId
{
    ubyte[32] m_FileId;
}

// Interfaces

@GUID("96236a85-9dbc-11da-9e3f-0011114ae311")
struct RdcLibrary;

@GUID("96236a86-9dbc-11da-9e3f-0011114ae311")
struct RdcGeneratorParameters;

@GUID("96236a87-9dbc-11da-9e3f-0011114ae311")
struct RdcGeneratorFilterMaxParameters;

@GUID("96236a88-9dbc-11da-9e3f-0011114ae311")
struct RdcGenerator;

@GUID("96236a89-9dbc-11da-9e3f-0011114ae311")
struct RdcFileReader;

@GUID("96236a8a-9dbc-11da-9e3f-0011114ae311")
struct RdcSignatureReader;

@GUID("96236a8b-9dbc-11da-9e3f-0011114ae311")
struct RdcComparator;

@GUID("96236a8d-9dbc-11da-9e3f-0011114ae311")
struct SimilarityReportProgress;

@GUID("96236a8e-9dbc-11da-9e3f-0011114ae311")
struct SimilarityTableDumpState;

@GUID("96236a8f-9dbc-11da-9e3f-0011114ae311")
struct SimilarityTraitsTable;

@GUID("96236a90-9dbc-11da-9e3f-0011114ae311")
struct SimilarityFileIdTable;

@GUID("96236a91-9dbc-11da-9e3f-0011114ae311")
struct Similarity;

@GUID("96236a92-9dbc-11da-9e3f-0011114ae311")
struct RdcSimilarityGenerator;

@GUID("96236a93-9dbc-11da-9e3f-0011114ae311")
struct FindSimilarResults;

@GUID("96236a94-9dbc-11da-9e3f-0011114ae311")
struct SimilarityTraitsMapping;

@GUID("96236a95-9dbc-11da-9e3f-0011114ae311")
struct SimilarityTraitsMappedView;

@GUID("96236a71-9dbc-11da-9e3f-0011114ae311")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nn-msrdc-irdcgeneratorparameters
interface IRdcGeneratorParameters : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-irdcgeneratorparameters-getgeneratorparameterstype
    HRESULT GetGeneratorParametersType(GeneratorParametersType* parametersType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-irdcgeneratorparameters-getparametersversion
    HRESULT GetParametersVersion(uint* currentVersion, uint* minimumCompatibleAppVersion);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-irdcgeneratorparameters-getserializesize
    HRESULT GetSerializeSize(uint* size);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-irdcgeneratorparameters-serialize
    HRESULT Serialize(uint size, ubyte* parametersBlob, uint* bytesWritten);
}

@GUID("96236a72-9dbc-11da-9e3f-0011114ae311")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nn-msrdc-irdcgeneratorfiltermaxparameters
interface IRdcGeneratorFilterMaxParameters : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-irdcgeneratorfiltermaxparameters-gethorizonsize
    HRESULT GetHorizonSize(uint* horizonSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-irdcgeneratorfiltermaxparameters-sethorizonsize
    HRESULT SetHorizonSize(uint horizonSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-irdcgeneratorfiltermaxparameters-gethashwindowsize
    HRESULT GetHashWindowSize(uint* hashWindowSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-irdcgeneratorfiltermaxparameters-sethashwindowsize
    HRESULT SetHashWindowSize(uint hashWindowSize);
}

@GUID("96236a73-9dbc-11da-9e3f-0011114ae311")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nn-msrdc-irdcgenerator
interface IRdcGenerator : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-irdcgenerator-getgeneratorparameters
    HRESULT GetGeneratorParameters(uint level, IRdcGeneratorParameters* iGeneratorParameters);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-irdcgenerator-process
    HRESULT Process(BOOL endOfInput, BOOL* endOfOutput, RdcBufferPointer* inputBuffer, uint depth, 
                    RdcBufferPointer** outputBuffers, RDC_ErrorCode* rdc_ErrorCode);
}

@GUID("96236a74-9dbc-11da-9e3f-0011114ae311")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nn-msrdc-irdcfilereader
interface IRdcFileReader : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-irdcfilereader-getfilesize
    HRESULT GetFileSize(ulong* fileSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-irdcfilereader-read
    HRESULT Read(ulong offsetFileStart, uint bytesToRead, uint* bytesActuallyRead, ubyte* buffer, BOOL* eof);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-irdcfilereader-getfileposition
    HRESULT GetFilePosition(ulong* offsetFromStart);
}

@GUID("96236a75-9dbc-11da-9e3f-0011114ae311")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nn-msrdc-irdcfilewriter
interface IRdcFileWriter : IRdcFileReader
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-irdcfilewriter-write
    HRESULT Write(ulong offsetFileStart, uint bytesToWrite, ubyte* buffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-irdcfilewriter-truncate
    HRESULT Truncate();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-irdcfilewriter-deleteonclose
    HRESULT DeleteOnClose();
}

@GUID("96236a76-9dbc-11da-9e3f-0011114ae311")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nn-msrdc-irdcsignaturereader
interface IRdcSignatureReader : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-irdcsignaturereader-readheader
    HRESULT ReadHeader(RDC_ErrorCode* rdc_ErrorCode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-irdcsignaturereader-readsignatures
    HRESULT ReadSignatures(RdcSignaturePointer* rdcSignaturePointer, BOOL* endOfOutput);
}

@GUID("96236a77-9dbc-11da-9e3f-0011114ae311")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nn-msrdc-irdccomparator
interface IRdcComparator : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-irdccomparator-process
    HRESULT Process(BOOL endOfInput, BOOL* endOfOutput, RdcBufferPointer* inputBuffer, 
                    RdcNeedPointer* outputBuffer, RDC_ErrorCode* rdc_ErrorCode);
}

@GUID("96236a78-9dbc-11da-9e3f-0011114ae311")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nn-msrdc-irdclibrary
interface IRdcLibrary : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-irdclibrary-computedefaultrecursiondepth
    HRESULT ComputeDefaultRecursionDepth(ulong fileSize, uint* depth);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-irdclibrary-creategeneratorparameters
    HRESULT CreateGeneratorParameters(GeneratorParametersType parametersType, uint level, 
                                      IRdcGeneratorParameters* iGeneratorParameters);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-irdclibrary-opengeneratorparameters
    HRESULT OpenGeneratorParameters(uint size, const(ubyte)* parametersBlob, 
                                    IRdcGeneratorParameters* iGeneratorParameters);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-irdclibrary-creategenerator
    HRESULT CreateGenerator(uint depth, IRdcGeneratorParameters* iGeneratorParametersArray, 
                            IRdcGenerator* iGenerator);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-irdclibrary-createcomparator
    HRESULT CreateComparator(IRdcFileReader iSeedSignaturesFile, uint comparatorBufferSize, 
                             IRdcComparator* iComparator);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-irdclibrary-createsignaturereader
    HRESULT CreateSignatureReader(IRdcFileReader iFileReader, IRdcSignatureReader* iSignatureReader);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-irdclibrary-getrdcversion
    HRESULT GetRDCVersion(uint* currentVersion, uint* minimumCompatibleAppVersion);
}

@GUID("96236a7a-9dbc-11da-9e3f-0011114ae311")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nn-msrdc-isimilarityreportprogress
interface ISimilarityReportProgress : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-isimilarityreportprogress-reportprogress
    HRESULT ReportProgress(uint percentCompleted);
}

@GUID("96236a7b-9dbc-11da-9e3f-0011114ae311")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nn-msrdc-isimilaritytabledumpstate
interface ISimilarityTableDumpState : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-isimilaritytabledumpstate-getnextdata
    HRESULT GetNextData(uint resultsSize, uint* resultsUsed, BOOL* eof, SimilarityDumpData* results);
}

@GUID("96236a7c-9dbc-11da-9e3f-0011114ae311")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nn-msrdc-isimilaritytraitsmappedview
interface ISimilarityTraitsMappedView : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-isimilaritytraitsmappedview-flush
    HRESULT Flush();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-isimilaritytraitsmappedview-unmap
    HRESULT Unmap();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-isimilaritytraitsmappedview-get
    HRESULT Get(ulong index, BOOL dirty, uint numElements, SimilarityMappedViewInfo* viewInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-isimilaritytraitsmappedview-getview
    void    GetView(const(ubyte)** mappedPageBegin, const(ubyte)** mappedPageEnd);
}

@GUID("96236a7d-9dbc-11da-9e3f-0011114ae311")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nn-msrdc-isimilaritytraitsmapping
interface ISimilarityTraitsMapping : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-isimilaritytraitsmapping-closemapping
    void    CloseMapping();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-isimilaritytraitsmapping-setfilesize
    HRESULT SetFileSize(ulong fileSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-isimilaritytraitsmapping-getfilesize
    HRESULT GetFileSize(ulong* fileSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-isimilaritytraitsmapping-openmapping
    HRESULT OpenMapping(RdcMappingAccessMode accessMode, ulong begin, ulong end, ulong* actualEnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-isimilaritytraitsmapping-resizemapping
    HRESULT ResizeMapping(RdcMappingAccessMode accessMode, ulong begin, ulong end, ulong* actualEnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-isimilaritytraitsmapping-getpagesize
    void    GetPageSize(uint* pageSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-isimilaritytraitsmapping-createview
    HRESULT CreateView(uint minimumMappedPages, RdcMappingAccessMode accessMode, 
                       ISimilarityTraitsMappedView* mappedView);
}

@GUID("96236a7e-9dbc-11da-9e3f-0011114ae311")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nn-msrdc-isimilaritytraitstable
interface ISimilarityTraitsTable : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-isimilaritytraitstable-createtable
    HRESULT CreateTable(PWSTR path, BOOL truncate, ubyte* securityDescriptor, RdcCreatedTables* isNew);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-isimilaritytraitstable-createtableindirect
    HRESULT CreateTableIndirect(ISimilarityTraitsMapping mapping, BOOL truncate, RdcCreatedTables* isNew);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-isimilaritytraitstable-closetable
    HRESULT CloseTable(BOOL isValid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-isimilaritytraitstable-append
    HRESULT Append(SimilarityData* data, uint fileIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-isimilaritytraitstable-findsimilarfileindex
    HRESULT FindSimilarFileIndex(SimilarityData* similarityData, ushort numberOfMatchesRequired, 
                                 FindSimilarFileIndexResults* findSimilarFileIndexResults, uint resultsSize, 
                                 uint* resultsUsed);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-isimilaritytraitstable-begindump
    HRESULT BeginDump(ISimilarityTableDumpState* similarityTableDumpState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-isimilaritytraitstable-getlastindex
    HRESULT GetLastIndex(uint* fileIndex);
}

@GUID("96236a7f-9dbc-11da-9e3f-0011114ae311")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nn-msrdc-isimilarityfileidtable
interface ISimilarityFileIdTable : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-isimilarityfileidtable-createtable
    HRESULT CreateTable(PWSTR path, BOOL truncate, ubyte* securityDescriptor, uint recordSize, 
                        RdcCreatedTables* isNew);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-isimilarityfileidtable-createtableindirect
    HRESULT CreateTableIndirect(IRdcFileWriter fileIdFile, BOOL truncate, uint recordSize, RdcCreatedTables* isNew);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-isimilarityfileidtable-closetable
    HRESULT CloseTable(BOOL isValid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-isimilarityfileidtable-append
    HRESULT Append(SimilarityFileId* similarityFileId, uint* similarityFileIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-isimilarityfileidtable-lookup
    HRESULT Lookup(uint similarityFileIndex, SimilarityFileId* similarityFileId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-isimilarityfileidtable-invalidate
    HRESULT Invalidate(uint similarityFileIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-isimilarityfileidtable-getrecordcount
    HRESULT GetRecordCount(uint* recordCount);
}

@GUID("96236a80-9dbc-11da-9e3f-0011114ae311")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nn-msrdc-irdcsimilaritygenerator
interface IRdcSimilarityGenerator : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-irdcsimilaritygenerator-enablesimilarity
    HRESULT EnableSimilarity();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-irdcsimilaritygenerator-results
    HRESULT Results(SimilarityData* similarityData);
}

@GUID("96236a81-9dbc-11da-9e3f-0011114ae311")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nn-msrdc-ifindsimilarresults
interface IFindSimilarResults : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-ifindsimilarresults-getsize
    HRESULT GetSize(uint* size);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-ifindsimilarresults-getnextfileid
    HRESULT GetNextFileId(uint* numTraitsMatched, SimilarityFileId* similarityFileId);
}

@GUID("96236a83-9dbc-11da-9e3f-0011114ae311")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nn-msrdc-isimilarity
interface ISimilarity : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-isimilarity-createtable
    HRESULT CreateTable(PWSTR path, BOOL truncate, ubyte* securityDescriptor, uint recordSize, 
                        RdcCreatedTables* isNew);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-isimilarity-createtableindirect
    HRESULT CreateTableIndirect(ISimilarityTraitsMapping mapping, IRdcFileWriter fileIdFile, BOOL truncate, 
                                uint recordSize, RdcCreatedTables* isNew);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-isimilarity-closetable
    HRESULT CloseTable(BOOL isValid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-isimilarity-append
    HRESULT Append(SimilarityFileId* similarityFileId, SimilarityData* similarityData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-isimilarity-findsimilarfileid
    HRESULT FindSimilarFileId(SimilarityData* similarityData, ushort numberOfMatchesRequired, uint resultsSize, 
                              IFindSimilarResults* findSimilarResults);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-isimilarity-copyandswap
    HRESULT CopyAndSwap(ISimilarity newSimilarityTables, ISimilarityReportProgress reportProgress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msrdc/nf-msrdc-isimilarity-getrecordcount
    HRESULT GetRecordCount(uint* recordCount);
}


// GUIDs

const GUID CLSID_FindSimilarResults              = GUIDOF!FindSimilarResults;
const GUID CLSID_RdcComparator                   = GUIDOF!RdcComparator;
const GUID CLSID_RdcFileReader                   = GUIDOF!RdcFileReader;
const GUID CLSID_RdcGenerator                    = GUIDOF!RdcGenerator;
const GUID CLSID_RdcGeneratorFilterMaxParameters = GUIDOF!RdcGeneratorFilterMaxParameters;
const GUID CLSID_RdcGeneratorParameters          = GUIDOF!RdcGeneratorParameters;
const GUID CLSID_RdcLibrary                      = GUIDOF!RdcLibrary;
const GUID CLSID_RdcSignatureReader              = GUIDOF!RdcSignatureReader;
const GUID CLSID_RdcSimilarityGenerator          = GUIDOF!RdcSimilarityGenerator;
const GUID CLSID_Similarity                      = GUIDOF!Similarity;
const GUID CLSID_SimilarityFileIdTable           = GUIDOF!SimilarityFileIdTable;
const GUID CLSID_SimilarityReportProgress        = GUIDOF!SimilarityReportProgress;
const GUID CLSID_SimilarityTableDumpState        = GUIDOF!SimilarityTableDumpState;
const GUID CLSID_SimilarityTraitsMappedView      = GUIDOF!SimilarityTraitsMappedView;
const GUID CLSID_SimilarityTraitsMapping         = GUIDOF!SimilarityTraitsMapping;
const GUID CLSID_SimilarityTraitsTable           = GUIDOF!SimilarityTraitsTable;

const GUID IID_IFindSimilarResults              = GUIDOF!IFindSimilarResults;
const GUID IID_IRdcComparator                   = GUIDOF!IRdcComparator;
const GUID IID_IRdcFileReader                   = GUIDOF!IRdcFileReader;
const GUID IID_IRdcFileWriter                   = GUIDOF!IRdcFileWriter;
const GUID IID_IRdcGenerator                    = GUIDOF!IRdcGenerator;
const GUID IID_IRdcGeneratorFilterMaxParameters = GUIDOF!IRdcGeneratorFilterMaxParameters;
const GUID IID_IRdcGeneratorParameters          = GUIDOF!IRdcGeneratorParameters;
const GUID IID_IRdcLibrary                      = GUIDOF!IRdcLibrary;
const GUID IID_IRdcSignatureReader              = GUIDOF!IRdcSignatureReader;
const GUID IID_IRdcSimilarityGenerator          = GUIDOF!IRdcSimilarityGenerator;
const GUID IID_ISimilarity                      = GUIDOF!ISimilarity;
const GUID IID_ISimilarityFileIdTable           = GUIDOF!ISimilarityFileIdTable;
const GUID IID_ISimilarityReportProgress        = GUIDOF!ISimilarityReportProgress;
const GUID IID_ISimilarityTableDumpState        = GUIDOF!ISimilarityTableDumpState;
const GUID IID_ISimilarityTraitsMappedView      = GUIDOF!ISimilarityTraitsMappedView;
const GUID IID_ISimilarityTraitsMapping         = GUIDOF!ISimilarityTraitsMapping;
const GUID IID_ISimilarityTraitsTable           = GUIDOF!ISimilarityTraitsTable;
