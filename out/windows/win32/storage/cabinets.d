// Written in the D programming language.

module windows.win32.storage.cabinets;

public import windows.core;
public import windows.win32.foundation.foundation : BOOL, CHAR, PSTR;

extern(Windows) @nogc nothrow:


// Enums


alias FDICREATE_CPU_TYPE = int;
enum : int
{
    cpuUNKNOWN = 0xffffffff,
    cpu80286   = 0x00000000,
    cpu80386   = 0x00000001,
}

alias FCIERROR = int;
enum : int
{
    FCIERR_NONE             = 0x00000000,
    FCIERR_OPEN_SRC         = 0x00000001,
    FCIERR_READ_SRC         = 0x00000002,
    FCIERR_ALLOC_FAIL       = 0x00000003,
    FCIERR_TEMP_FILE        = 0x00000004,
    FCIERR_BAD_COMPR_TYPE   = 0x00000005,
    FCIERR_CAB_FILE         = 0x00000006,
    FCIERR_USER_ABORT       = 0x00000007,
    FCIERR_MCI_FAIL         = 0x00000008,
    FCIERR_CAB_FORMAT_LIMIT = 0x00000009,
}

alias FDIERROR = int;
enum : int
{
    FDIERROR_NONE                    = 0x00000000,
    FDIERROR_CABINET_NOT_FOUND       = 0x00000001,
    FDIERROR_NOT_A_CABINET           = 0x00000002,
    FDIERROR_UNKNOWN_CABINET_VERSION = 0x00000003,
    FDIERROR_CORRUPT_CABINET         = 0x00000004,
    FDIERROR_ALLOC_FAIL              = 0x00000005,
    FDIERROR_BAD_COMPR_TYPE          = 0x00000006,
    FDIERROR_MDI_FAIL                = 0x00000007,
    FDIERROR_TARGET_FILE             = 0x00000008,
    FDIERROR_RESERVE_MISMATCH        = 0x00000009,
    FDIERROR_WRONG_CABINET           = 0x0000000a,
    FDIERROR_USER_ABORT              = 0x0000000b,
    FDIERROR_EOF                     = 0x0000000c,
}

alias FDIDECRYPTTYPE = int;
enum : int
{
    fdidtNEW_CABINET = 0x00000000,
    fdidtNEW_FOLDER  = 0x00000001,
    fdidtDECRYPT     = 0x00000002,
}

alias FDINOTIFICATIONTYPE = int;
enum : int
{
    fdintCABINET_INFO    = 0x00000000,
    fdintPARTIAL_FILE    = 0x00000001,
    fdintCOPY_FILE       = 0x00000002,
    fdintCLOSE_FILE_INFO = 0x00000003,
    fdintNEXT_CABINET    = 0x00000004,
    fdintENUMERATE       = 0x00000005,
}

// Constants


enum uint INCLUDED_FCI = 0x00000001U;
enum uint _A_NAME_IS_UTF = 0x00000080U;
enum uint _A_EXEC = 0x00000040U;

enum : uint
{
    statusFile    = 0x00000000U,
    statusFolder  = 0x00000001U,
    statusCabinet = 0x00000002U,
}

enum uint INCLUDED_TYPES_FCI_FDI = 0x00000001U;
enum int CB_MAX_DISK = 0x7fffffff;

enum : uint
{
    CB_MAX_FILENAME     = 0x00000100U,
    CB_MAX_CABINET_NAME = 0x00000100U,
    CB_MAX_CAB_PATH     = 0x00000100U,
    CB_MAX_DISK_NAME    = 0x00000100U,
}

enum uint tcompMASK_TYPE = 0x0000000fU;

enum : uint
{
    tcompTYPE_NONE    = 0x00000000U,
    tcompTYPE_MSZIP   = 0x00000001U,
    tcompTYPE_QUANTUM = 0x00000002U,
    tcompTYPE_LZX     = 0x00000003U,
}

enum : uint
{
    tcompBAD             = 0x0000000fU,
    tcompMASK_LZX_WINDOW = 0x00001f00U,
}

enum : uint
{
    tcompLZX_WINDOW_LO = 0x00000f00U,
    tcompLZX_WINDOW_HI = 0x00001500U,
}

enum uint tcompSHIFT_LZX_WINDOW = 0x00000008U;
enum uint tcompMASK_QUANTUM_LEVEL = 0x000000f0U;

enum : uint
{
    tcompQUANTUM_LEVEL_LO = 0x00000010U,
    tcompQUANTUM_LEVEL_HI = 0x00000070U,
}

enum uint tcompSHIFT_QUANTUM_LEVEL = 0x00000004U;
enum uint tcompMASK_QUANTUM_MEM = 0x00001f00U;

enum : uint
{
    tcompQUANTUM_MEM_LO = 0x00000a00U,
    tcompQUANTUM_MEM_HI = 0x00001500U,
}

enum uint tcompSHIFT_QUANTUM_MEM = 0x00000008U;
enum uint tcompMASK_RESERVED = 0x0000e000U;
enum uint INCLUDED_FDI = 0x00000001U;

// Callbacks

alias PFNFCIALLOC = void* function(uint cb);
alias PFNFCIFREE = void function(void* memory);
alias PFNFCIOPEN = ptrdiff_t function(PSTR pszFile, int oflag, int pmode, int* err, void* pv);
alias PFNFCIREAD = uint function(ptrdiff_t hf, void* memory, uint cb, int* err, void* pv);
alias PFNFCIWRITE = uint function(ptrdiff_t hf, void* memory, uint cb, int* err, void* pv);
alias PFNFCICLOSE = int function(ptrdiff_t hf, int* err, void* pv);
alias PFNFCISEEK = int function(ptrdiff_t hf, int dist, int seektype, int* err, void* pv);
alias PFNFCIDELETE = int function(PSTR pszFile, int* err, void* pv);
alias PFNFCIGETNEXTCABINET = BOOL function(CCAB* pccab, uint cbPrevCab, void* pv);
alias PFNFCIFILEPLACED = int function(CCAB* pccab, PSTR pszFile, int cbFile, BOOL fContinuation, void* pv);
alias PFNFCIGETOPENINFO = ptrdiff_t function(PSTR pszName, ushort* pdate, ushort* ptime, ushort* pattribs, 
                                             int* err, void* pv);
alias PFNFCISTATUS = int function(uint typeStatus, uint cb1, uint cb2, void* pv);
alias PFNFCIGETTEMPFILE = BOOL function(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/PSTR pszTempName, 
                                        int cbTempName, void* pv);
alias PFNALLOC = void* function(uint cb);
alias PFNFREE = void function(void* pv);
alias PFNOPEN = ptrdiff_t function(PSTR pszFile, int oflag, int pmode);
alias PFNREAD = uint function(ptrdiff_t hf, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pv, 
                              uint cb);
alias PFNWRITE = uint function(ptrdiff_t hf, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pv, 
                               uint cb);
alias PFNCLOSE = int function(ptrdiff_t hf);
alias PFNSEEK = int function(ptrdiff_t hf, int dist, int seektype);
alias PFNFDIDECRYPT = int function(FDIDECRYPT* pfdid);
alias PFNFDINOTIFY = ptrdiff_t function(FDINOTIFICATIONTYPE fdint, FDINOTIFICATION* pfdin);

// Structs


version(X86_64)
{
    struct FDISPILLFILE
    {
        CHAR[2] ach;
        int     cbFile;
    }
}

version(AArch64)
{
    struct FDISPILLFILE
    {
        CHAR[2] ach;
        int     cbFile;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fdi_fci_types/ns-fdi_fci_types-erf
struct ERF
{
    int  erfOper;
    int  erfType;
    BOOL fError;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fci/ns-fci-ccab
struct CCAB
{
    uint      cb;
    uint      cbFolderThresh;
    uint      cbReserveCFHeader;
    uint      cbReserveCFFolder;
    uint      cbReserveCFData;
    int       iCab;
    int       iDisk;
    int       fFailOnIncompressible;
    ushort    setID;
    CHAR[256] szDisk;
    CHAR[256] szCab;
    CHAR[256] szCabPath;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fdi/ns-fdi-fdicabinetinfo
struct FDICABINETINFO
{
    int    cbCabinet;
    ushort cFolders;
    ushort cFiles;
    ushort setID;
    ushort iCabinet;
    BOOL   fReserve;
    BOOL   hasprev;
    BOOL   hasnext;
}

struct FDIDECRYPT
{
    FDIDECRYPTTYPE fdidt;
    void*          pvUser;
    union
    {
        struct cabinet
        {
            void*  pHeaderReserve;
            ushort cbHeaderReserve;
            ushort setID;
            int    iCabinet;
        }
        struct folder
        {
            void*  pFolderReserve;
            ushort cbFolderReserve;
            ushort iFolder;
        }
        struct decrypt
        {
            void*  pDataReserve;
            ushort cbDataReserve;
            void*  pbData;
            ushort cbData;
            BOOL   fSplit;
            ushort cbPartial;
        }
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fdi/ns-fdi-fdinotification
struct FDINOTIFICATION
{
    int       cb;
    PSTR      psz1;
    PSTR      psz2;
    PSTR      psz3;
    void*     pv;
    ptrdiff_t hf;
    ushort    date;
    ushort    time;
    ushort    attribs;
    ushort    setID;
    ushort    iCabinet;
    ushort    iFolder;
    FDIERROR  fdie;
}

version(X86)
{
    struct FDISPILLFILE
    {
    align (1):
        CHAR[2] ach;
        int     cbFile;
    }
}

// Functions

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fci/nf-fci-fcicreate
@DllImport("Cabinet.dll")
void* FCICreate(ERF* perf, PFNFCIFILEPLACED pfnfcifp, PFNFCIALLOC pfna, PFNFCIFREE pfnf, PFNFCIOPEN pfnopen, 
                PFNFCIREAD pfnread, PFNFCIWRITE pfnwrite, PFNFCICLOSE pfnclose, PFNFCISEEK pfnseek, 
                PFNFCIDELETE pfndelete, PFNFCIGETTEMPFILE pfnfcigtf, CCAB* pccab, void* pv);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fci/nf-fci-fciaddfile
@DllImport("Cabinet.dll")
BOOL FCIAddFile(void* hfci, PSTR pszSourceFile, PSTR pszFileName, BOOL fExecute, PFNFCIGETNEXTCABINET pfnfcignc, 
                PFNFCISTATUS pfnfcis, PFNFCIGETOPENINFO pfnfcigoi, ushort typeCompress);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fci/nf-fci-fciflushcabinet
@DllImport("Cabinet.dll")
BOOL FCIFlushCabinet(void* hfci, BOOL fGetNextCab, PFNFCIGETNEXTCABINET pfnfcignc, PFNFCISTATUS pfnfcis);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fci/nf-fci-fciflushfolder
@DllImport("Cabinet.dll")
BOOL FCIFlushFolder(void* hfci, PFNFCIGETNEXTCABINET pfnfcignc, PFNFCISTATUS pfnfcis);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fci/nf-fci-fcidestroy
@DllImport("Cabinet.dll")
BOOL FCIDestroy(void* hfci);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("Cabinet.dll")
void* FDICreate(PFNALLOC pfnalloc, PFNFREE pfnfree, PFNOPEN pfnopen, PFNREAD pfnread, PFNWRITE pfnwrite, 
                PFNCLOSE pfnclose, PFNSEEK pfnseek, FDICREATE_CPU_TYPE cpuType, ERF* perf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("Cabinet.dll")
BOOL FDIIsCabinet(void* hfdi, ptrdiff_t hf, FDICABINETINFO* pfdici);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("Cabinet.dll")
BOOL FDICopy(void* hfdi, PSTR pszCabinet, PSTR pszCabPath, int flags, PFNFDINOTIFY pfnfdin, PFNFDIDECRYPT pfnfdid, 
             void* pvUser);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("Cabinet.dll")
BOOL FDIDestroy(void* hfdi);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fdi/nf-fdi-fditruncatecabinet
@DllImport("Cabinet.dll")
BOOL FDITruncateCabinet(void* hfdi, PSTR pszCabinetName, ushort iFolderToDelete);


