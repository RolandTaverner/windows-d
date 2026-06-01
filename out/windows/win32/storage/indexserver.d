// Written in the D programming language.

module windows.win32.storage.indexserver;

public import windows.core;
public import system.system : Guid;
public import windows.win32.foundation.foundation : HRESULT, PWSTR, RECT;
public import windows.win32.system.com.com : IStream, IUnknown;
public import windows.win32.system.com.structuredstorage : IStorage, PROPSPEC, PROPVARIANT;

extern(Windows) @nogc nothrow:


// Enums


alias IFILTER_INIT = int;
enum : int
{
    IFILTER_INIT_CANON_PARAGRAPHS        = 0x00000001,
    IFILTER_INIT_HARD_LINE_BREAKS        = 0x00000002,
    IFILTER_INIT_CANON_HYPHENS           = 0x00000004,
    IFILTER_INIT_CANON_SPACES            = 0x00000008,
    IFILTER_INIT_APPLY_INDEX_ATTRIBUTES  = 0x00000010,
    IFILTER_INIT_APPLY_OTHER_ATTRIBUTES  = 0x00000020,
    IFILTER_INIT_APPLY_CRAWL_ATTRIBUTES  = 0x00000100,
    IFILTER_INIT_INDEXING_ONLY           = 0x00000040,
    IFILTER_INIT_SEARCH_LINKS            = 0x00000080,
    IFILTER_INIT_FILTER_OWNED_VALUE_OK   = 0x00000200,
    IFILTER_INIT_FILTER_AGGRESSIVE_BREAK = 0x00000400,
    IFILTER_INIT_DISABLE_EMBEDDED        = 0x00000800,
    IFILTER_INIT_EMIT_FORMATTING         = 0x00001000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/filter/ne-filter-ifilter_flags
alias IFILTER_FLAGS = int;
enum : int
{
    IFILTER_FLAGS_OLE_PROPERTIES = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/filter/ne-filter-chunkstate
alias CHUNKSTATE = int;
enum : int
{
    CHUNK_TEXT               = 0x00000001,
    CHUNK_VALUE              = 0x00000002,
    CHUNK_FILTER_OWNED_VALUE = 0x00000004,
    CHUNK_IMAGE              = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/filter/ne-filter-chunk_breaktype
alias CHUNK_BREAKTYPE = int;
enum : int
{
    CHUNK_NO_BREAK = 0x00000000,
    CHUNK_EOW      = 0x00000001,
    CHUNK_EOS      = 0x00000002,
    CHUNK_EOP      = 0x00000003,
    CHUNK_EOC      = 0x00000004,
}

alias IMAGE_PIXELFORMAT = int;
enum : int
{
    FILTER_PIXELFORMAT_BGRA8  = 0x00000000,
    FILTER_PIXELFORMAT_PBGRA8 = 0x00000001,
    FILTER_PIXELFORMAT_BGR8   = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/indexsrv/ne-indexsrv-wordrep_break_type
alias WORDREP_BREAK_TYPE = int;
enum : int
{
    WORDREP_BREAK_EOW = 0x00000000,
    WORDREP_BREAK_EOS = 0x00000001,
    WORDREP_BREAK_EOP = 0x00000002,
    WORDREP_BREAK_EOC = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledbguid/ne-oledbguid-dbkindenum
alias DBKINDENUM = int;
enum : int
{
    DBKIND_GUID_NAME    = 0x00000000,
    DBKIND_GUID_PROPID  = 0x00000001,
    DBKIND_NAME         = 0x00000002,
    DBKIND_PGUID_NAME   = 0x00000003,
    DBKIND_PGUID_PROPID = 0x00000004,
    DBKIND_PROPID       = 0x00000005,
    DBKIND_GUID         = 0x00000006,
}

// Constants


enum : uint
{
    CI_VERSION_WDS30 = 0x00000102U,
    CI_VERSION_WDS40 = 0x00000109U,
    CI_VERSION_WIN70 = 0x00000700U,
}

enum const(wchar)* CINULLCATALOG = "::_noindex_::";
enum const(wchar)* CIADMIN = "::_nodocstore_::";
enum uint LIFF_LOAD_DEFINED_FILTER = 0x00000001U;
enum uint LIFF_IMPLEMENT_TEXT_FILTER_FALLBACK_POLICY = 0x00000002U;
enum uint LIFF_FORCE_TEXT_FILTER_FALLBACK = 0x00000003U;
enum GUID CLSID_INDEX_SERVER_DSO = GUID("f9ae8980-7e52-11d0-8964-00c04fd611d7");
enum GUID PSGUID_FILENAME = GUID("41cf5ae0-f75a-4806-bd87-59c7d9248eb9");
enum uint PID_FILENAME = 0x00000064U;
enum GUID DBPROPSET_FSCIFRMWRK_EXT = GUID("a9bd1526-6a80-11d0-8c9d-0020af1d740e");

enum : uint
{
    DBPROP_CI_CATALOG_NAME   = 0x00000002U,
    DBPROP_CI_INCLUDE_SCOPES = 0x00000003U,
    DBPROP_CI_DEPTHS         = 0x00000004U,
    DBPROP_CI_SCOPE_FLAGS    = 0x00000004U,
    DBPROP_CI_EXCLUDE_SCOPES = 0x00000005U,
    DBPROP_CI_SECURITY_ID    = 0x00000006U,
    DBPROP_CI_QUERY_TYPE     = 0x00000007U,
    DBPROP_CI_PROVIDER       = 0x00000008U,
}

enum : uint
{
    CI_PROVIDER_MSSEARCH         = 0x00000001U,
    CI_PROVIDER_INDEXING_SERVICE = 0x00000002U,
    CI_PROVIDER_ALL              = 0xffffffffU,
}

enum GUID DBPROPSET_SESS_QUERYEXT = GUID("63623309-2d8b-4d17-b152-6e2956c26a70");
enum uint DBPROP_DEFAULT_EQUALS_BEHAVIOR = 0x00000002U;
enum GUID DBPROPSET_QUERYEXT = GUID("a7ac77ed-f8d7-11ce-a798-0020f8008025");
enum uint DBPROP_USECONTENTINDEX = 0x00000002U;
enum uint DBPROP_DEFERNONINDEXEDTRIMMING = 0x00000003U;
enum uint DBPROP_USEEXTENDEDDBTYPES = 0x00000004U;
enum uint DBPROP_IGNORENOISEONLYCLAUSES = 0x00000005U;
enum uint DBPROP_GENERICOPTIONS_STRING = 0x00000006U;

enum : uint
{
    DBPROP_FIRSTROWS                = 0x00000007U,
    DBPROP_DEFERCATALOGVERIFICATION = 0x00000008U,
}

enum uint DBPROP_CATALOGLISTID = 0x00000009U;
enum uint DBPROP_GENERATEPARSETREE = 0x0000000aU;
enum uint DBPROP_APPLICATION_NAME = 0x0000000bU;

enum : uint
{
    DBPROP_FREETEXTANYTERM     = 0x0000000cU,
    DBPROP_FREETEXTUSESTEMMING = 0x0000000dU,
}

enum : uint
{
    DBPROP_IGNORESBRI                 = 0x0000000eU,
    DBPROP_DONOTCOMPUTEEXPENSIVEPROPS = 0x0000000fU,
}

enum uint DBPROP_ENABLEROWSETEVENTS = 0x00000010U;

enum : uint
{
    DBPROP_SESSION_ID = 0x00000011U,
    DBPROP_QUERY_ID   = 0x00000012U,
}

enum GUID DBPROPSET_CIFRMWRKCORE_EXT = GUID("afafaca5-b5d1-11d0-8c62-00c04fc2db8d");

enum : uint
{
    DBPROP_MACHINE      = 0x00000002U,
    DBPROP_CLIENT_CLSID = 0x00000003U,
}

enum GUID DBPROPSET_MSIDXS_ROWSETEXT = GUID("aa6ee6b0-e828-11d0-b23e-00aa0047fc01");
enum uint MSIDXSPROP_ROWSETQUERYSTATUS = 0x00000002U;
enum uint MSIDXSPROP_COMMAND_LOCALE_STRING = 0x00000003U;
enum uint MSIDXSPROP_QUERY_RESTRICTION = 0x00000004U;

enum : uint
{
    MSIDXSPROP_PARSE_TREE            = 0x00000005U,
    MSIDXSPROP_MAX_RANK              = 0x00000006U,
    MSIDXSPROP_RESULTS_FOUND         = 0x00000007U,
    MSIDXSPROP_WHEREID               = 0x00000008U,
    MSIDXSPROP_SERVER_VERSION        = 0x00000009U,
    MSIDXSPROP_SERVER_WINVER_MAJOR   = 0x0000000aU,
    MSIDXSPROP_SERVER_WINVER_MINOR   = 0x0000000bU,
    MSIDXSPROP_SERVER_NLSVERSION     = 0x0000000cU,
    MSIDXSPROP_SERVER_NLSVER_DEFINED = 0x0000000dU,
}

enum uint MSIDXSPROP_SAME_SORTORDER_USED = 0x0000000eU;

enum : uint
{
    STAT_BUSY          = 0x00000000U,
    STAT_ERROR         = 0x00000001U,
    STAT_DONE          = 0x00000002U,
    STAT_REFRESH       = 0x00000003U,
    STAT_PARTIAL_SCOPE = 0x00000008U,
}

enum uint STAT_NOISE_WORDS = 0x00000010U;
enum uint STAT_CONTENT_OUT_OF_DATE = 0x00000020U;
enum uint STAT_REFRESH_INCOMPLETE = 0x00000040U;
enum uint STAT_CONTENT_QUERY_INCOMPLETE = 0x00000080U;
enum uint STAT_TIME_LIMIT_EXCEEDED = 0x00000100U;
enum uint STAT_SHARING_VIOLATION = 0x00000200U;

enum : uint
{
    STAT_MISSING_RELDOC         = 0x00000400U,
    STAT_MISSING_PROP_IN_RELDOC = 0x00000800U,
}

enum uint STAT_RELDOC_ACCESS_DENIED = 0x00001000U;
enum uint STAT_COALESCE_COMP_ALL_NOISE = 0x00002000U;

enum : uint
{
    QUERY_SHALLOW       = 0x00000000U,
    QUERY_DEEP          = 0x00000001U,
    QUERY_PHYSICAL_PATH = 0x00000000U,
}

enum uint QUERY_VIRTUAL_PATH = 0x00000002U;

enum : uint
{
    PROPID_QUERY_WORKID       = 0x00000005U,
    PROPID_QUERY_UNFILTERED   = 0x00000007U,
    PROPID_QUERY_VIRTUALPATH  = 0x00000009U,
    PROPID_QUERY_LASTSEENTIME = 0x0000000aU,
}

enum : uint
{
    CICAT_STOPPED   = 0x00000001U,
    CICAT_READONLY  = 0x00000002U,
    CICAT_WRITABLE  = 0x00000004U,
    CICAT_NO_QUERY  = 0x00000008U,
    CICAT_GET_STATE = 0x00000010U,
}

enum uint CICAT_ALL_OPENED = 0x00000020U;

enum : uint
{
    CI_STATE_SHADOW_MERGE          = 0x00000001U,
    CI_STATE_MASTER_MERGE          = 0x00000002U,
    CI_STATE_CONTENT_SCAN_REQUIRED = 0x00000004U,
}

enum uint CI_STATE_ANNEALING_MERGE = 0x00000008U;

enum : uint
{
    CI_STATE_SCANNING              = 0x00000010U,
    CI_STATE_RECOVERING            = 0x00000020U,
    CI_STATE_INDEX_MIGRATION_MERGE = 0x00000040U,
}

enum : uint
{
    CI_STATE_LOW_MEMORY          = 0x00000080U,
    CI_STATE_HIGH_IO             = 0x00000100U,
    CI_STATE_MASTER_MERGE_PAUSED = 0x00000200U,
}

enum : uint
{
    CI_STATE_READ_ONLY      = 0x00000400U,
    CI_STATE_BATTERY_POWER  = 0x00000800U,
    CI_STATE_USER_ACTIVE    = 0x00001000U,
    CI_STATE_STARTING       = 0x00002000U,
    CI_STATE_READING_USNS   = 0x00004000U,
    CI_STATE_DELETION_MERGE = 0x00008000U,
}

enum : uint
{
    CI_STATE_LOW_DISK       = 0x00010000U,
    CI_STATE_HIGH_CPU       = 0x00020000U,
    CI_STATE_BATTERY_POLICY = 0x00040000U,
}

enum : uint
{
    GENERATE_METHOD_EXACT   = 0x00000000U,
    GENERATE_METHOD_PREFIX  = 0x00000001U,
    GENERATE_METHOD_INFLECT = 0x00000002U,
}

enum : uint
{
    SCOPE_FLAG_MASK    = 0x000000ffU,
    SCOPE_FLAG_INCLUDE = 0x00000001U,
    SCOPE_FLAG_DEEP    = 0x00000002U,
}

enum : uint
{
    SCOPE_TYPE_MASK    = 0xffffff00U,
    SCOPE_TYPE_WINPATH = 0x00000100U,
    SCOPE_TYPE_VPATH   = 0x00000200U,
}

enum : uint
{
    PROPID_QUERY_RANKVECTOR = 0x00000002U,
    PROPID_QUERY_RANK       = 0x00000003U,
    PROPID_QUERY_HITCOUNT   = 0x00000004U,
    PROPID_QUERY_ALL        = 0x00000006U,
    PROPID_STG_CONTENTS     = 0x00000013U,
}

enum : uint
{
    VECTOR_RANK_MIN     = 0x00000000U,
    VECTOR_RANK_MAX     = 0x00000001U,
    VECTOR_RANK_INNER   = 0x00000002U,
    VECTOR_RANK_DICE    = 0x00000003U,
    VECTOR_RANK_JACCARD = 0x00000004U,
}

enum : uint
{
    DBSETFUNC_NONE     = 0x00000000U,
    DBSETFUNC_ALL      = 0x00000001U,
    DBSETFUNC_DISTINCT = 0x00000002U,
}

enum : uint
{
    PROXIMITY_UNIT_WORD      = 0x00000000U,
    PROXIMITY_UNIT_SENTENCE  = 0x00000001U,
    PROXIMITY_UNIT_PARAGRAPH = 0x00000002U,
    PROXIMITY_UNIT_CHAPTER   = 0x00000003U,
}

enum HRESULT NOT_AN_ERROR = HRESULT(0x00080000);

enum : HRESULT
{
    FILTER_E_END_OF_CHUNKS  = HRESULT(0x80041700),
    FILTER_E_NO_MORE_TEXT   = HRESULT(0x80041701),
    FILTER_E_NO_MORE_VALUES = HRESULT(0x80041702),
}

enum : HRESULT
{
    FILTER_E_ACCESS          = HRESULT(0x80041703),
    FILTER_W_MONIKER_CLIPPED = HRESULT(0x00041704),
}

enum : HRESULT
{
    FILTER_E_NO_TEXT               = HRESULT(0x80041705),
    FILTER_E_NO_VALUES             = HRESULT(0x80041706),
    FILTER_E_EMBEDDING_UNAVAILABLE = HRESULT(0x80041707),
}

enum HRESULT FILTER_E_LINK_UNAVAILABLE = HRESULT(0x80041708);

enum : HRESULT
{
    FILTER_S_LAST_TEXT   = HRESULT(0x00041709),
    FILTER_S_LAST_VALUES = HRESULT(0x0004170a),
}

enum : HRESULT
{
    FILTER_E_PASSWORD      = HRESULT(0x8004170b),
    FILTER_E_UNKNOWNFORMAT = HRESULT(0x8004170c),
}

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntquery/ns-ntquery-ci_state
struct CI_STATE
{
    uint cbStruct;
    uint cWordList;
    uint cPersistentIndex;
    uint cQueries;
    uint cDocuments;
    uint cFreshTest;
    uint dwMergeProgress;
    uint eState;
    uint cFilteredDocuments;
    uint cTotalDocuments;
    uint cPendingScans;
    uint dwIndexSize;
    uint cUniqueKeys;
    uint cSecQDocuments;
    uint dwPropCacheSize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/filter/ns-filter-fullpropspec
struct FULLPROPSPEC
{
    GUID     guidPropSet;
    PROPSPEC psProperty;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/filter/ns-filter-filterregion
struct FILTERREGION
{
    uint idChunk;
    uint cwcStart;
    uint cwcExtent;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/filter/ns-filter-stat_chunk
struct STAT_CHUNK
{
    uint            idChunk;
    CHUNK_BREAKTYPE breakType;
    CHUNKSTATE      flags;
    uint            locale;
    FULLPROPSPEC    attribute;
    uint            idChunkSource;
    uint            cwcStartSource;
    uint            cwcLenSource;
}

struct IMAGE_INFO
{
    uint              Width;
    uint              Height;
    IMAGE_PIXELFORMAT Format;
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledbguid/ns-oledbguid-dbid
    struct DBID
    {
        union uGuid
        {
            GUID  guid;
            GUID* pguid;
        }
        uint eKind;
        union uName
        {
            PWSTR pwszName;
            uint  ulPropid;
        }
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledbguid/ns-oledbguid-dbid
    struct DBID
    {
        union uGuid
        {
            GUID  guid;
            GUID* pguid;
        }
        uint eKind;
        union uName
        {
            PWSTR pwszName;
            uint  ulPropid;
        }
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledbguid/ns-oledbguid-dbid
    struct DBID
    {
    align (2):
        _uGuid_e__Union uGuid;
        uint            eKind;
        _uName_e__Union uName;
    }
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("query.dll")
HRESULT LoadIFilter(const(PWSTR) pwcsPath, IUnknown pUnkOuter, void** ppIUnk);

@DllImport("query.dll")
HRESULT LoadIFilterEx(const(PWSTR) pwcsPath, uint dwFlags, const(GUID)* riid, void** ppIUnk);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("query.dll")
HRESULT BindIFilterFromStorage(IStorage pStg, IUnknown pUnkOuter, void** ppIUnk);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("query.dll")
HRESULT BindIFilterFromStream(IStream pStm, IUnknown pUnkOuter, void** ppIUnk);


// Interfaces

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/filter/nn-filter-ifilter
@GUID("89bcb740-6119-101a-bcb7-00dd010655af")
interface IFilter : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/filter/nf-filter-ifilter-init
    int Init(uint grfFlags, uint cAttributes, const(FULLPROPSPEC)* aAttributes, uint* pFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/filter/nf-filter-ifilter-getchunk
    int GetChunk(STAT_CHUNK* pStat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/filter/nf-filter-ifilter-gettext
    int GetText(uint* pcwcBuffer, PWSTR awcBuffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/filter/nf-filter-ifilter-getvalue
    int GetValue(PROPVARIANT** ppPropValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/filter/nf-filter-ifilter-bindregion
    int BindRegion(FILTERREGION origPos, const(GUID)* riid, void** ppunk);
}

@GUID("3d7df9a7-8da6-4fbf-a45b-7592f06d93a9")
interface IPixelFilter : IFilter
{
    HRESULT GetImageInfo(IMAGE_INFO* imageInfo);
    HRESULT GetPixelsForImage(float scalingFactor, const(RECT)* sourceRect, uint pixelBufferSize, 
                              ubyte* pixelBuffer);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/indexsrv/nn-indexsrv-iphrasesink
@GUID("cc906ff0-c058-101a-b554-08002b33b0e6")
interface IPhraseSink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/indexsrv/nf-indexsrv-iphrasesink-putsmallphrase
    HRESULT PutSmallPhrase(const(PWSTR) pwcNoun, uint cwcNoun, const(PWSTR) pwcModifier, uint cwcModifier, 
                           uint ulAttachmentType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/indexsrv/nf-indexsrv-iphrasesink-putphrase
    HRESULT PutPhrase(const(PWSTR) pwcPhrase, uint cwcPhrase);
}


// GUIDs


const GUID IID_IFilter      = GUIDOF!IFilter;
const GUID IID_IPhraseSink  = GUIDOF!IPhraseSink;
const GUID IID_IPixelFilter = GUIDOF!IPixelFilter;
