// Written in the D programming language.

module windows.win32.system.com.structuredstorage;

public import windows.core;
public import windows.win32.foundation.foundation : BOOL, BOOLEAN, BSTR, CHAR, DECIMAL,
                                                    FILETIME, HGLOBAL, HINSTANCE,
                                                    HRESULT, PSTR, PWSTR, VARIANT_BOOL;
public import windows.win32.security.security : PSECURITY_DESCRIPTOR;
public import windows.win32.system.com.com : BLOB, CLSCTX, COSERVERINFO, CY, DVTARGETDEVICE,
                                             IDispatch, IErrorLog, IPersist, IStream,
                                             IUnknown, MULTI_QI, SAFEARRAY, STATSTG,
                                             STGM, STGMEDIUM, StorageLayout;
public import windows.win32.system.variant : PSTIME_FLAGS, VARENUM, VARIANT;

extern(Windows) @nogc nothrow:


// Enums


alias PROPSPEC_KIND = uint;
enum : uint
{
    PRSPEC_LPWSTR = 0x00000000U,
    PRSPEC_PROPID = 0x00000001U,
}

alias STGFMT = uint;
enum : uint
{
    STGFMT_STORAGE  = 0x00000000U,
    STGFMT_NATIVE   = 0x00000001U,
    STGFMT_FILE     = 0x00000003U,
    STGFMT_ANY      = 0x00000004U,
    STGFMT_DOCFILE  = 0x00000005U,
    STGFMT_DOCUMENT = 0x00000000U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtypes/ne-wtypes-stgmove
alias STGMOVE = int;
enum : int
{
    STGMOVE_MOVE        = 0x00000000,
    STGMOVE_COPY        = 0x00000001,
    STGMOVE_SHALLOWCOPY = 0x00000002,
}

alias PIDMSI_STATUS_VALUE = int;
enum : int
{
    PIDMSI_STATUS_NORMAL     = 0x00000000,
    PIDMSI_STATUS_NEW        = 0x00000001,
    PIDMSI_STATUS_PRELIM     = 0x00000002,
    PIDMSI_STATUS_DRAFT      = 0x00000003,
    PIDMSI_STATUS_INPROGRESS = 0x00000004,
    PIDMSI_STATUS_EDIT       = 0x00000005,
    PIDMSI_STATUS_REVIEW     = 0x00000006,
    PIDMSI_STATUS_PROOF      = 0x00000007,
    PIDMSI_STATUS_FINAL      = 0x00000008,
    PIDMSI_STATUS_OTHER      = 0x00007fff,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/propvarutil/ne-propvarutil-propvar_compare_unit
alias PROPVAR_COMPARE_UNIT = int;
enum : int
{
    PVCU_DEFAULT = 0x00000000,
    PVCU_SECOND  = 0x00000001,
    PVCU_MINUTE  = 0x00000002,
    PVCU_HOUR    = 0x00000003,
    PVCU_DAY     = 0x00000004,
    PVCU_MONTH   = 0x00000005,
    PVCU_YEAR    = 0x00000006,
}

alias PROPVAR_COMPARE_FLAGS = int;
enum : int
{
    PVCF_DEFAULT                       = 0x00000000,
    PVCF_TREATEMPTYASGREATERTHAN       = 0x00000001,
    PVCF_USESTRCMP                     = 0x00000002,
    PVCF_USESTRCMPC                    = 0x00000004,
    PVCF_USESTRCMPI                    = 0x00000008,
    PVCF_USESTRCMPIC                   = 0x00000010,
    PVCF_DIGITSASNUMBERS_CASESENSITIVE = 0x00000020,
}

alias PROPVAR_CHANGE_FLAGS = int;
enum : int
{
    PVCHF_DEFAULT        = 0x00000000,
    PVCHF_NOVALUEPROP    = 0x00000001,
    PVCHF_ALPHABOOL      = 0x00000002,
    PVCHF_NOUSEROVERRIDE = 0x00000004,
    PVCHF_LOCALBOOL      = 0x00000008,
    PVCHF_NOHEXSTRING    = 0x00000010,
}

// Constants


enum : uint
{
    PROPSETFLAG_DEFAULT        = 0x00000000U,
    PROPSETFLAG_NONSIMPLE      = 0x00000001U,
    PROPSETFLAG_ANSI           = 0x00000002U,
    PROPSETFLAG_UNBUFFERED     = 0x00000004U,
    PROPSETFLAG_CASE_SENSITIVE = 0x00000008U,
}

enum uint PROPSET_BEHAVIOR_CASE_SENSITIVE = 0x00000001U;
enum uint PID_DICTIONARY = 0x00000000U;
enum uint PID_CODEPAGE = 0x00000001U;

enum : uint
{
    PID_FIRST_USABLE       = 0x00000002U,
    PID_FIRST_NAME_DEFAULT = 0x00000fffU,
}

enum uint PID_LOCALE = 0x80000000U;
enum uint PID_MODIFY_TIME = 0x80000001U;
enum uint PID_SECURITY = 0x80000002U;
enum uint PID_BEHAVIOR = 0x80000003U;
enum uint PID_ILLEGAL = 0xffffffffU;
enum uint PID_MIN_READONLY = 0x80000000U;
enum uint PID_MAX_READONLY = 0xbfffffffU;
enum uint PRSPEC_INVALID = 0xffffffffU;
enum uint PROPSETHDR_OSVERSION_UNKNOWN = 0xffffffffU;
enum int PIDDI_THUMBNAIL = 0x00000002;

enum : int
{
    PIDSI_TITLE      = 0x00000002,
    PIDSI_SUBJECT    = 0x00000003,
    PIDSI_AUTHOR     = 0x00000004,
    PIDSI_KEYWORDS   = 0x00000005,
    PIDSI_COMMENTS   = 0x00000006,
    PIDSI_TEMPLATE   = 0x00000007,
    PIDSI_LASTAUTHOR = 0x00000008,
}

enum int PIDSI_REVNUMBER = 0x00000009;

enum : int
{
    PIDSI_EDITTIME    = 0x0000000a,
    PIDSI_LASTPRINTED = 0x0000000b,
}

enum int PIDSI_CREATE_DTM = 0x0000000c;
enum int PIDSI_LASTSAVE_DTM = 0x0000000d;
enum int PIDSI_PAGECOUNT = 0x0000000e;
enum int PIDSI_WORDCOUNT = 0x0000000f;
enum int PIDSI_CHARCOUNT = 0x00000010;
enum int PIDSI_THUMBNAIL = 0x00000011;

enum : int
{
    PIDSI_APPNAME      = 0x00000012,
    PIDSI_DOC_SECURITY = 0x00000013,
}

enum : uint
{
    PIDDSI_CATEGORY    = 0x00000002U,
    PIDDSI_PRESFORMAT  = 0x00000003U,
    PIDDSI_BYTECOUNT   = 0x00000004U,
    PIDDSI_LINECOUNT   = 0x00000005U,
    PIDDSI_PARCOUNT    = 0x00000006U,
    PIDDSI_SLIDECOUNT  = 0x00000007U,
    PIDDSI_NOTECOUNT   = 0x00000008U,
    PIDDSI_HIDDENCOUNT = 0x00000009U,
}

enum uint PIDDSI_MMCLIPCOUNT = 0x0000000aU;

enum : uint
{
    PIDDSI_SCALE       = 0x0000000bU,
    PIDDSI_HEADINGPAIR = 0x0000000cU,
}

enum : uint
{
    PIDDSI_DOCPARTS   = 0x0000000dU,
    PIDDSI_MANAGER    = 0x0000000eU,
    PIDDSI_COMPANY    = 0x0000000fU,
    PIDDSI_LINKSDIRTY = 0x00000010U,
}

enum : int
{
    PIDMSI_EDITOR      = 0x00000002,
    PIDMSI_SUPPLIER    = 0x00000003,
    PIDMSI_SOURCE      = 0x00000004,
    PIDMSI_SEQUENCE_NO = 0x00000005,
}

enum : int
{
    PIDMSI_PROJECT    = 0x00000006,
    PIDMSI_STATUS     = 0x00000007,
    PIDMSI_OWNER      = 0x00000008,
    PIDMSI_RATING     = 0x00000009,
    PIDMSI_PRODUCTION = 0x0000000a,
    PIDMSI_COPYRIGHT  = 0x0000000b,
}

enum uint CWCSTORAGENAME = 0x00000020U;
enum uint STGOPTIONS_VERSION = 0x00000001U;
enum uint CCH_MAX_PROPSTG_NAME = 0x0000001fU;

// Structs


struct BSTRBLOB
{
    uint   cbSize;
    ubyte* pData;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct CLIPDATA
{
    uint   cbSize;
    int    ulClipFmt;
    ubyte* pClipData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/ns-objidl-remsnb
struct RemSNB
{
    uint ulCntStr;
    uint ulCntChar;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/wchar[1] rgString;
}

struct VERSIONEDSTREAM
{
    GUID    guidVersion;
    IStream pStream;
}

struct CAC
{
    uint cElems;
    PSTR pElems;
}

struct CAUB
{
    uint   cElems;
    ubyte* pElems;
}

struct CAI
{
    uint   cElems;
    short* pElems;
}

struct CAUI
{
    uint    cElems;
    ushort* pElems;
}

struct CAL
{
    uint cElems;
    int* pElems;
}

struct CAUL
{
    uint  cElems;
    uint* pElems;
}

struct CAFLT
{
    uint   cElems;
    float* pElems;
}

struct CADBL
{
    uint    cElems;
    double* pElems;
}

struct CACY
{
    uint cElems;
    CY*  pElems;
}

struct CADATE
{
    uint    cElems;
    double* pElems;
}

struct CABSTR
{
    uint  cElems;
    BSTR* pElems;
}

struct CABSTRBLOB
{
    uint      cElems;
    BSTRBLOB* pElems;
}

struct CABOOL
{
    uint          cElems;
    VARIANT_BOOL* pElems;
}

struct CASCODE
{
    uint cElems;
    int* pElems;
}

struct CAPROPVARIANT
{
    uint         cElems;
    PROPVARIANT* pElems;
}

struct CAH
{
    uint  cElems;
    long* pElems;
}

struct CAUH
{
    uint   cElems;
    ulong* pElems;
}

struct CALPSTR
{
    uint  cElems;
    PSTR* pElems;
}

struct CALPWSTR
{
    uint   cElems;
    PWSTR* pElems;
}

struct CAFILETIME
{
    uint      cElems;
    FILETIME* pElems;
}

struct CACLIPDATA
{
    uint      cElems;
    CLIPDATA* pElems;
}

struct CACLSID
{
    uint  cElems;
    GUID* pElems;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/propidlbase/ns-propidlbase-propvariant
struct PROPVARIANT
{
    union
    {
        struct
        {
            VARENUM vt;
            ushort  wReserved1;
            ushort  wReserved2;
            ushort  wReserved3;
            union
            {
                CHAR             cVal;
                ubyte            bVal;
                short            iVal;
                ushort           uiVal;
                int              lVal;
                uint             ulVal;
                int              intVal;
                uint             uintVal;
                long             hVal;
                ulong            uhVal;
                float            fltVal;
                double           dblVal;
                VARIANT_BOOL     boolVal;
                VARIANT_BOOL     __OBSOLETE__VARIANT_BOOL;
                int              scode;
                CY               cyVal;
                double           date;
                FILETIME         filetime;
                GUID*            puuid;
                CLIPDATA*        pclipdata;
                BSTR             bstrVal;
                BSTRBLOB         bstrblobVal;
                BLOB             blob;
                PSTR             pszVal;
                PWSTR            pwszVal;
                IUnknown         punkVal;
                IDispatch        pdispVal;
                IStream          pStream;
                IStorage         pStorage;
                VERSIONEDSTREAM* pVersionedStream;
                SAFEARRAY*       parray;
                CAC              cac;
                CAUB             caub;
                CAI              cai;
                CAUI             caui;
                CAL              cal;
                CAUL             caul;
                CAH              cah;
                CAUH             cauh;
                CAFLT            caflt;
                CADBL            cadbl;
                CABOOL           cabool;
                CASCODE          cascode;
                CACY             cacy;
                CADATE           cadate;
                CAFILETIME       cafiletime;
                CACLSID          cauuid;
                CACLIPDATA       caclipdata;
                CABSTR           cabstr;
                CABSTRBLOB       cabstrblob;
                CALPSTR          calpstr;
                CALPWSTR         calpwstr;
                CAPROPVARIANT    capropvar;
                PSTR             pcVal;
                ubyte*           pbVal;
                short*           piVal;
                ushort*          puiVal;
                int*             plVal;
                uint*            pulVal;
                int*             pintVal;
                uint*            puintVal;
                float*           pfltVal;
                double*          pdblVal;
                VARIANT_BOOL*    pboolVal;
                DECIMAL*         pdecVal;
                int*             pscode;
                CY*              pcyVal;
                double*          pdate;
                BSTR*            pbstrVal;
                IUnknown*        ppunkVal;
                IDispatch*       ppdispVal;
                SAFEARRAY**      pparray;
                PROPVARIANT*     pvarVal;
            }
        }
        DECIMAL decVal;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/propidlbase/ns-propidlbase-propspec
struct PROPSPEC
{
    PROPSPEC_KIND ulKind;
    union
    {
        uint  propid;
        PWSTR lpwstr;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/propidlbase/ns-propidlbase-statpropstg
struct STATPROPSTG
{
    PWSTR   lpwstrName;
    uint    propid;
    VARENUM vt;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/propidlbase/ns-propidlbase-statpropsetstg
struct STATPROPSETSTG
{
    GUID     fmtid;
    GUID     clsid;
    uint     grfFlags;
    FILETIME mtime;
    FILETIME ctime;
    FILETIME atime;
    uint     dwOSVersion;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/coml2api/ns-coml2api-stgoptions
struct STGOPTIONS
{
    ushort       usVersion;
    ushort       reserved;
    uint         ulSectorSize;
    const(PWSTR) pwcsTemplateFile;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/propidl/ns-propidl-serializedpropertyvalue
struct SERIALIZEDPROPERTYVALUE
{
    uint dwType;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] rgb;
}

struct OLESTREAMVTBL
{
    ptrdiff_t Get;
    ptrdiff_t Put;
}

struct OLESTREAM
{
    OLESTREAMVTBL* lpstbl;
}

struct PROPBAG2
{
    uint    dwType;
    VARENUM vt;
    ushort  cfType;
    uint    dwHint;
    PWSTR   pstrName;
    GUID    clsid;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT CoGetInstanceFromFile(COSERVERINFO* pServerInfo, GUID* pClsid, IUnknown punkOuter, CLSCTX dwClsCtx, 
                              uint grfMode, PWSTR pwszName, uint dwCount, MULTI_QI* pResults);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT CoGetInstanceFromIStorage(COSERVERINFO* pServerInfo, GUID* pClsid, IUnknown punkOuter, CLSCTX dwClsCtx, 
                                  IStorage pstg, uint dwCount, MULTI_QI* pResults);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objbase/nf-objbase-stgopenasyncdocfileonifilllockbytes
@DllImport("ole32.dll")
HRESULT StgOpenAsyncDocfileOnIFillLockBytes(IFillLockBytes pflb, uint grfMode, uint asyncFlags, 
                                            IStorage* ppstgOpen);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objbase/nf-objbase-stggetifilllockbytesonilockbytes
@DllImport("ole32.dll")
HRESULT StgGetIFillLockBytesOnILockBytes(ILockBytes pilb, IFillLockBytes* ppflb);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objbase/nf-objbase-stggetifilllockbytesonfile
@DllImport("ole32.dll")
HRESULT StgGetIFillLockBytesOnFile(const(PWSTR) pwcsName, IFillLockBytes* ppflb);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objbase/nf-objbase-stgopenlayoutdocfile
@DllImport("dflayout.dll")
HRESULT StgOpenLayoutDocfile(const(PWSTR) pwcsDfName, uint grfMode, uint reserved, IStorage* ppstgOpen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT CreateStreamOnHGlobal(HGLOBAL hGlobal, BOOL fDeleteOnRelease, IStream* ppstm);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT GetHGlobalFromStream(IStream pstm, HGLOBAL* phglobal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT CoGetInterfaceAndReleaseStream(IStream pStm, const(GUID)* iid, void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT PropVariantCopy(PROPVARIANT* pvarDest, const(PROPVARIANT)* pvarSrc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT PropVariantClear(PROPVARIANT* pvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT FreePropVariantArray(uint cVariants, PROPVARIANT* rgvars);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT StgCreateDocfile(const(PWSTR) pwcsName, STGM grfMode, 
                         /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint reserved, 
                         IStorage* ppstgOpen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT StgCreateDocfileOnILockBytes(ILockBytes plkbyt, STGM grfMode, uint reserved, IStorage* ppstgOpen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT StgOpenStorage(const(PWSTR) pwcsName, IStorage pstgPriority, STGM grfMode, ushort** snbExclude, 
                       uint reserved, IStorage* ppstgOpen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT StgOpenStorageOnILockBytes(ILockBytes plkbyt, IStorage pstgPriority, STGM grfMode, ushort** snbExclude, 
                                   /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint reserved, 
                                   IStorage* ppstgOpen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT StgIsStorageFile(const(PWSTR) pwcsName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT StgIsStorageILockBytes(ILockBytes plkbyt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT StgSetTimes(const(PWSTR) lpszName, const(FILETIME)* pctime, const(FILETIME)* patime, 
                    const(FILETIME)* pmtime);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT StgCreateStorageEx(const(PWSTR) pwcsName, STGM grfMode, STGFMT stgfmt, uint grfAttrs, 
                           STGOPTIONS* pStgOptions, PSECURITY_DESCRIPTOR pSecurityDescriptor, const(GUID)* riid, 
                           void** ppObjectOpen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT StgOpenStorageEx(const(PWSTR) pwcsName, STGM grfMode, STGFMT stgfmt, uint grfAttrs, 
                         STGOPTIONS* pStgOptions, PSECURITY_DESCRIPTOR pSecurityDescriptor, const(GUID)* riid, 
                         void** ppObjectOpen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT StgCreatePropStg(IUnknown pUnk, const(GUID)* fmtid, const(GUID)* pclsid, uint grfFlags, 
                         /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwReserved, 
                         IPropertyStorage* ppPropStg);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT StgOpenPropStg(IUnknown pUnk, const(GUID)* fmtid, uint grfFlags, 
                       /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwReserved, 
                       IPropertyStorage* ppPropStg);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT StgCreatePropSetStg(IStorage pStorage, 
                            /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwReserved, 
                            IPropertySetStorage* ppPropSetStg);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT FmtIdToPropStgName(const(GUID)* pfmtid, PWSTR oszName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT PropStgNameToFmtId(const(PWSTR) oszName, GUID* pfmtid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT ReadClassStg(IStorage pStg, GUID* pclsid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT WriteClassStg(IStorage pStg, const(GUID)* rclsid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT ReadClassStm(IStream pStm, GUID* pclsid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT WriteClassStm(IStream pStm, const(GUID)* rclsid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT GetHGlobalFromILockBytes(ILockBytes plkbyt, HGLOBAL* phglobal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT CreateILockBytesOnHGlobal(HGLOBAL hGlobal, BOOL fDeleteOnRelease, ILockBytes* pplkbyt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT GetConvertStg(IStorage pStg);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ole32.dll")
SERIALIZEDPROPERTYVALUE* StgConvertVariantToProperty(const(PROPVARIANT)* pvar, ushort CodePage, 
                                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/SERIALIZEDPROPERTYVALUE* pprop, 
                                                     uint* pcb, uint pid, 
                                                     /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/BOOLEAN fReserved, 
                                                     uint* pcIndirect);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ole32.dll")
BOOLEAN StgConvertPropertyToVariant(const(SERIALIZEDPROPERTYVALUE)* pprop, ushort CodePage, PROPVARIANT* pvar, 
                                    IMemoryAllocator pma);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ole32.dll")
uint StgPropertyLengthAsVariant(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(SERIALIZEDPROPERTYVALUE)* pProp, 
                                uint cbProp, ushort CodePage, 
                                /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/ubyte bReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT WriteFmtUserTypeStg(IStorage pstg, ushort cf, PWSTR lpszUserType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT ReadFmtUserTypeStg(IStorage pstg, ushort* pcf, PWSTR* lplpszUserType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ole32.dll")
HRESULT OleConvertOLESTREAMToIStorage(OLESTREAM* lpolestream, IStorage pstg, const(DVTARGETDEVICE)* ptd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ole32.dll")
HRESULT OleConvertIStorageToOLESTREAM(IStorage pstg, OLESTREAM* lpolestream);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT SetConvertStg(IStorage pStg, BOOL fConvert);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ole32.dll")
HRESULT OleConvertIStorageToOLESTREAMEx(IStorage pstg, ushort cfFormat, int lWidth, int lHeight, uint dwSize, 
                                        STGMEDIUM* pmedium, OLESTREAM* polestm);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ole32.dll")
HRESULT OleConvertOLESTREAMToIStorageEx(OLESTREAM* polestm, IStorage pstg, ushort* pcfFormat, int* plwWidth, 
                                        int* plHeight, uint* pdwSize, STGMEDIUM* pmedium);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToWinRTPropertyValue(const(PROPVARIANT)* propvar, const(GUID)* riid, void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("PROPSYS.dll")
HRESULT WinRTPropertyValueToPropVariant(IUnknown punkPropertyValue, PROPVARIANT* ppropvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromResource(HINSTANCE hinst, uint id, PROPVARIANT* ppropvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromBuffer(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pv, 
                                  uint cb, PROPVARIANT* ppropvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromCLSID(const(GUID)* clsid, PROPVARIANT* ppropvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromGUIDAsString(const(GUID)* guid, PROPVARIANT* ppropvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromFileTime(const(FILETIME)* pftIn, PROPVARIANT* ppropvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromPropVariantVectorElem(const(PROPVARIANT)* propvarIn, uint iElem, PROPVARIANT* ppropvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT InitPropVariantVectorFromPropVariant(const(PROPVARIANT)* propvarSingle, PROPVARIANT* ppropvarVector);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromBooleanVector(const(BOOL)* prgf, uint cElems, PROPVARIANT* ppropvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromInt16Vector(const(short)* prgn, uint cElems, PROPVARIANT* ppropvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromUInt16Vector(const(ushort)* prgn, uint cElems, PROPVARIANT* ppropvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromInt32Vector(const(int)* prgn, uint cElems, PROPVARIANT* ppropvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromUInt32Vector(const(uint)* prgn, uint cElems, PROPVARIANT* ppropvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromInt64Vector(const(long)* prgn, uint cElems, PROPVARIANT* ppropvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromUInt64Vector(const(ulong)* prgn, uint cElems, PROPVARIANT* ppropvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromDoubleVector(const(double)* prgn, uint cElems, PROPVARIANT* ppropvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromFileTimeVector(const(FILETIME)* prgft, uint cElems, PROPVARIANT* ppropvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromStringVector(const(PWSTR)* prgsz, uint cElems, PROPVARIANT* ppropvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromStringAsVector(const(PWSTR) psz, PROPVARIANT* ppropvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
BOOL PropVariantToBooleanWithDefault(const(PROPVARIANT)* propvarIn, BOOL fDefault);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
short PropVariantToInt16WithDefault(const(PROPVARIANT)* propvarIn, short iDefault);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
ushort PropVariantToUInt16WithDefault(const(PROPVARIANT)* propvarIn, ushort uiDefault);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
int PropVariantToInt32WithDefault(const(PROPVARIANT)* propvarIn, int lDefault);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
uint PropVariantToUInt32WithDefault(const(PROPVARIANT)* propvarIn, uint ulDefault);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
long PropVariantToInt64WithDefault(const(PROPVARIANT)* propvarIn, long llDefault);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
ulong PropVariantToUInt64WithDefault(const(PROPVARIANT)* propvarIn, ulong ullDefault);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
double PropVariantToDoubleWithDefault(const(PROPVARIANT)* propvarIn, double dblDefault);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
PWSTR PropVariantToStringWithDefault(const(PROPVARIANT)* propvarIn, const(PWSTR) pszDefault);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToBoolean(const(PROPVARIANT)* propvarIn, BOOL* pfRet);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToInt16(const(PROPVARIANT)* propvarIn, short* piRet);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToUInt16(const(PROPVARIANT)* propvarIn, ushort* puiRet);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToInt32(const(PROPVARIANT)* propvarIn, int* plRet);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToUInt32(const(PROPVARIANT)* propvarIn, uint* pulRet);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToInt64(const(PROPVARIANT)* propvarIn, long* pllRet);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToUInt64(const(PROPVARIANT)* propvarIn, ulong* pullRet);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToDouble(const(PROPVARIANT)* propvarIn, double* pdblRet);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToBuffer(const(PROPVARIANT)* propvar, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pv, 
                            uint cb);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToString(const(PROPVARIANT)* propvar, PWSTR psz, uint cch);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToGUID(const(PROPVARIANT)* propvar, GUID* pguid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToStringAlloc(const(PROPVARIANT)* propvar, PWSTR* ppszOut);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToBSTR(const(PROPVARIANT)* propvar, BSTR* pbstrOut);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToFileTime(const(PROPVARIANT)* propvar, PSTIME_FLAGS pstfOut, FILETIME* pftOut);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
uint PropVariantGetElementCount(const(PROPVARIANT)* propvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToBooleanVector(const(PROPVARIANT)* propvar, BOOL* prgf, uint crgf, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToInt16Vector(const(PROPVARIANT)* propvar, short* prgn, uint crgn, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToUInt16Vector(const(PROPVARIANT)* propvar, ushort* prgn, uint crgn, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToInt32Vector(const(PROPVARIANT)* propvar, int* prgn, uint crgn, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToUInt32Vector(const(PROPVARIANT)* propvar, uint* prgn, uint crgn, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToInt64Vector(const(PROPVARIANT)* propvar, long* prgn, uint crgn, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToUInt64Vector(const(PROPVARIANT)* propvar, ulong* prgn, uint crgn, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToDoubleVector(const(PROPVARIANT)* propvar, double* prgn, uint crgn, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToFileTimeVector(const(PROPVARIANT)* propvar, FILETIME* prgft, uint crgft, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToStringVector(const(PROPVARIANT)* propvar, PWSTR* prgsz, uint crgsz, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToBooleanVectorAlloc(const(PROPVARIANT)* propvar, BOOL** pprgf, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToInt16VectorAlloc(const(PROPVARIANT)* propvar, short** pprgn, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToUInt16VectorAlloc(const(PROPVARIANT)* propvar, ushort** pprgn, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToInt32VectorAlloc(const(PROPVARIANT)* propvar, int** pprgn, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToUInt32VectorAlloc(const(PROPVARIANT)* propvar, uint** pprgn, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToInt64VectorAlloc(const(PROPVARIANT)* propvar, long** pprgn, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToUInt64VectorAlloc(const(PROPVARIANT)* propvar, ulong** pprgn, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToDoubleVectorAlloc(const(PROPVARIANT)* propvar, double** pprgn, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToFileTimeVectorAlloc(const(PROPVARIANT)* propvar, FILETIME** pprgft, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToStringVectorAlloc(const(PROPVARIANT)* propvar, PWSTR** pprgsz, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantGetBooleanElem(const(PROPVARIANT)* propvar, uint iElem, BOOL* pfVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantGetInt16Elem(const(PROPVARIANT)* propvar, uint iElem, short* pnVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantGetUInt16Elem(const(PROPVARIANT)* propvar, uint iElem, ushort* pnVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantGetInt32Elem(const(PROPVARIANT)* propvar, uint iElem, int* pnVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantGetUInt32Elem(const(PROPVARIANT)* propvar, uint iElem, uint* pnVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantGetInt64Elem(const(PROPVARIANT)* propvar, uint iElem, long* pnVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantGetUInt64Elem(const(PROPVARIANT)* propvar, uint iElem, ulong* pnVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantGetDoubleElem(const(PROPVARIANT)* propvar, uint iElem, double* pnVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantGetFileTimeElem(const(PROPVARIANT)* propvar, uint iElem, FILETIME* pftVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantGetStringElem(const(PROPVARIANT)* propvar, uint iElem, PWSTR* ppszVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
void ClearPropVariantArray(PROPVARIANT* rgPropVar, uint cVars);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
int PropVariantCompareEx(const(PROPVARIANT)* propvar1, const(PROPVARIANT)* propvar2, PROPVAR_COMPARE_UNIT unit, 
                         PROPVAR_COMPARE_FLAGS flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantChangeType(PROPVARIANT* ppropvarDest, const(PROPVARIANT)* propvarSrc, 
                              PROPVAR_CHANGE_FLAGS flags, VARENUM vt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToVariant(const(PROPVARIANT)* pPropVar, VARIANT* pVar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("PROPSYS.dll")
HRESULT VariantToPropVariant(const(VARIANT)* pVar, PROPVARIANT* pPropVar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("PROPSYS.dll")
HRESULT StgSerializePropVariant(const(PROPVARIANT)* ppropvar, SERIALIZEDPROPERTYVALUE** ppProp, uint* pcb);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("PROPSYS.dll")
HRESULT StgDeserializePropVariant(const(SERIALIZEDPROPERTYVALUE)* pprop, uint cbMax, PROPVARIANT* ppropvar);


// Interfaces

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nn-objidl-ienumstatstg
@GUID("0000000d-0000-0000-c000-000000000046")
interface IEnumSTATSTG : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ienumstatstg-next
    HRESULT Next(uint celt, STATSTG* rgelt, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ienumstatstg-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ienumstatstg-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ienumstatstg-clone
    HRESULT Clone(IEnumSTATSTG* ppenum);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nn-objidl-istorage
@GUID("0000000b-0000-0000-c000-000000000046")
interface IStorage : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-istorage-createstream
    HRESULT CreateStream(const(PWSTR) pwcsName, STGM grfMode, uint reserved1, uint reserved2, IStream* ppstm);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-istorage-openstream
    HRESULT OpenStream(const(PWSTR) pwcsName, 
                       /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* reserved1, STGM grfMode, 
                       uint reserved2, IStream* ppstm);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-istorage-createstorage
    HRESULT CreateStorage(const(PWSTR) pwcsName, STGM grfMode, uint reserved1, uint reserved2, IStorage* ppstg);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-istorage-openstorage
    HRESULT OpenStorage(const(PWSTR) pwcsName, IStorage pstgPriority, STGM grfMode, ushort** snbExclude, 
                        uint reserved, IStorage* ppstg);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-istorage-copyto
    HRESULT CopyTo(uint ciidExclude, const(GUID)* rgiidExclude, ushort** snbExclude, IStorage pstgDest);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-istorage-moveelementto
    HRESULT MoveElementTo(const(PWSTR) pwcsName, IStorage pstgDest, const(PWSTR) pwcsNewName, 
                          /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(STGMOVE))], [])*/uint grfFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-istorage-commit
    HRESULT Commit(uint grfCommitFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-istorage-revert
    HRESULT Revert();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-istorage-enumelements
    HRESULT EnumElements(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint reserved1, 
                         /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* reserved2, 
                         /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint reserved3, 
                         IEnumSTATSTG* ppenum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-istorage-destroyelement
    HRESULT DestroyElement(const(PWSTR) pwcsName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-istorage-renameelement
    HRESULT RenameElement(const(PWSTR) pwcsOldName, const(PWSTR) pwcsNewName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-istorage-setelementtimes
    HRESULT SetElementTimes(const(PWSTR) pwcsName, const(FILETIME)* pctime, const(FILETIME)* patime, 
                            const(FILETIME)* pmtime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-istorage-setclass
    HRESULT SetClass(const(GUID)* clsid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-istorage-setstatebits
    HRESULT SetStateBits(uint grfStateBits, uint grfMask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-istorage-stat
    HRESULT Stat(STATSTG* pstatstg, uint grfStatFlag);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nn-objidl-ipersiststorage
@GUID("0000010a-0000-0000-c000-000000000046")
interface IPersistStorage : IPersist
{
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT IsDirty();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ipersiststorage-initnew
    HRESULT InitNew(IStorage pStg);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ipersiststorage-load
    HRESULT Load(IStorage pStg);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ipersiststorage-save
    HRESULT Save(IStorage pStgSave, BOOL fSameAsLoad);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ipersiststorage-savecompleted
    HRESULT SaveCompleted(IStorage pStgNew);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ipersiststorage-handsoffstorage
    HRESULT HandsOffStorage();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nn-objidl-ilockbytes
@GUID("0000000a-0000-0000-c000-000000000046")
interface ILockBytes : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ilockbytes-readat
    HRESULT ReadAt(ulong ulOffset, 
                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pv, 
                   uint cb, uint* pcbRead);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ilockbytes-writeat
    HRESULT WriteAt(ulong ulOffset, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(void)* pv, 
                    uint cb, uint* pcbWritten);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ilockbytes-flush
    HRESULT Flush();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ilockbytes-setsize
    HRESULT SetSize(ulong cb);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ilockbytes-lockregion
    HRESULT LockRegion(ulong libOffset, ulong cb, uint dwLockType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ilockbytes-unlockregion
    HRESULT UnlockRegion(ulong libOffset, ulong cb, uint dwLockType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ilockbytes-stat
    HRESULT Stat(STATSTG* pstatstg, uint grfStatFlag);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nn-objidl-irootstorage
@GUID("00000012-0000-0000-c000-000000000046")
interface IRootStorage : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-irootstorage-switchtofile
    HRESULT SwitchToFile(PWSTR pszFile);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nn-objidl-ifilllockbytes
@GUID("99caf010-415e-11cf-8814-00aa00b569f5")
interface IFillLockBytes : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ifilllockbytes-fillappend
    HRESULT FillAppend(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pv, 
                       uint cb, uint* pcbWritten);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ifilllockbytes-fillat
    HRESULT FillAt(ulong ulOffset, 
                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(void)* pv, 
                   uint cb, uint* pcbWritten);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ifilllockbytes-setfillsize
    HRESULT SetFillSize(ulong ulSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ifilllockbytes-terminate
    HRESULT Terminate(BOOL bCanceled);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nn-objidl-ilayoutstorage
@GUID("0e6d4d90-6738-11cf-9608-00aa00680db4")
interface ILayoutStorage : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ilayoutstorage-layoutscript
    HRESULT LayoutScript(StorageLayout* pStorageLayout, uint nEntries, 
                         /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint glfInterleavedFlag);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ilayoutstorage-beginmonitor
    HRESULT BeginMonitor();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ilayoutstorage-endmonitor
    HRESULT EndMonitor();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ilayoutstorage-relayoutdocfile
    HRESULT ReLayoutDocfile(PWSTR pwcsNewDfName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ilayoutstorage-relayoutdocfileonilockbytes
    HRESULT ReLayoutDocfileOnILockBytes(ILockBytes pILockBytes);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nn-objidl-idirectwriterlock
@GUID("0e6d4d92-6738-11cf-9608-00aa00680db4")
interface IDirectWriterLock : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-idirectwriterlock-waitforwriteaccess
    HRESULT WaitForWriteAccess(uint dwTimeout);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-idirectwriterlock-releasewriteaccess
    HRESULT ReleaseWriteAccess();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-idirectwriterlock-havewriteaccess
    HRESULT HaveWriteAccess();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/propidlbase/nn-propidlbase-ipropertystorage
@GUID("00000138-0000-0000-c000-000000000046")
interface IPropertyStorage : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/propidlbase/nf-propidlbase-ipropertystorage-readmultiple
    HRESULT ReadMultiple(uint cpspec, const(PROPSPEC)* rgpspec, PROPVARIANT* rgpropvar);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/propidlbase/nf-propidlbase-ipropertystorage-writemultiple
    HRESULT WriteMultiple(uint cpspec, const(PROPSPEC)* rgpspec, const(PROPVARIANT)* rgpropvar, 
                          uint propidNameFirst);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/propidlbase/nf-propidlbase-ipropertystorage-deletemultiple
    HRESULT DeleteMultiple(uint cpspec, const(PROPSPEC)* rgpspec);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/propidlbase/nf-propidlbase-ipropertystorage-readpropertynames
    HRESULT ReadPropertyNames(uint cpropid, const(uint)* rgpropid, PWSTR* rglpwstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/propidlbase/nf-propidlbase-ipropertystorage-writepropertynames
    HRESULT WritePropertyNames(uint cpropid, const(uint)* rgpropid, const(PWSTR)* rglpwstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/propidlbase/nf-propidlbase-ipropertystorage-deletepropertynames
    HRESULT DeletePropertyNames(uint cpropid, const(uint)* rgpropid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/propidlbase/nf-propidlbase-ipropertystorage-commit
    HRESULT Commit(uint grfCommitFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/propidlbase/nf-propidlbase-ipropertystorage-revert
    HRESULT Revert();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/propidlbase/nf-propidlbase-ipropertystorage-enum
    HRESULT Enum(IEnumSTATPROPSTG* ppenum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/propidlbase/nf-propidlbase-ipropertystorage-settimes
    HRESULT SetTimes(const(FILETIME)* pctime, const(FILETIME)* patime, const(FILETIME)* pmtime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/propidlbase/nf-propidlbase-ipropertystorage-setclass
    HRESULT SetClass(const(GUID)* clsid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/propidlbase/nf-propidlbase-ipropertystorage-stat
    HRESULT Stat(STATPROPSETSTG* pstatpsstg);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/propidl/nn-propidl-ipropertysetstorage
@GUID("0000013a-0000-0000-c000-000000000046")
interface IPropertySetStorage : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/propidl/nf-propidl-ipropertysetstorage-create
    HRESULT Create(const(GUID)* rfmtid, const(GUID)* pclsid, uint grfFlags, uint grfMode, 
                   IPropertyStorage* ppprstg);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/propidl/nf-propidl-ipropertysetstorage-open
    HRESULT Open(const(GUID)* rfmtid, uint grfMode, IPropertyStorage* ppprstg);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/propidl/nf-propidl-ipropertysetstorage-delete
    HRESULT Delete(const(GUID)* rfmtid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/propidl/nf-propidl-ipropertysetstorage-enum
    HRESULT Enum(IEnumSTATPROPSETSTG* ppenum);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/propidlbase/nn-propidlbase-ienumstatpropstg
@GUID("00000139-0000-0000-c000-000000000046")
interface IEnumSTATPROPSTG : IUnknown
{
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT Next(uint celt, STATPROPSTG* rgelt, uint* pceltFetched);
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/propidlbase/nf-propidlbase-ienumstatpropstg-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/propidlbase/nf-propidlbase-ienumstatpropstg-clone
    HRESULT Clone(IEnumSTATPROPSTG* ppenum);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/propidlbase/nn-propidlbase-ienumstatpropsetstg
@GUID("0000013b-0000-0000-c000-000000000046")
interface IEnumSTATPROPSETSTG : IUnknown
{
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT Next(uint celt, STATPROPSETSTG* rgelt, uint* pceltFetched);
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/propidlbase/nf-propidlbase-ienumstatpropsetstg-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/propidlbase/nf-propidlbase-ienumstatpropsetstg-clone
    HRESULT Clone(IEnumSTATPROPSETSTG* ppenum);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/Stg/imemoryallocator
interface IMemoryAllocator
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Stg/imemoryallocator-allocate
    void* Allocate(uint cbSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Stg/imemoryallocator-free
    void  Free(void* pv);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nn-oaidl-ipropertybag
@GUID("55272a00-42cb-11ce-8135-00aa004bb851")
interface IPropertyBag : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-ipropertybag-read
    HRESULT Read(const(PWSTR) pszPropName, VARIANT* pVar, IErrorLog pErrorLog);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-ipropertybag-write
    HRESULT Write(const(PWSTR) pszPropName, VARIANT* pVar);
}

@GUID("22f55882-280b-11d0-a8a9-00a0c90c2004")
interface IPropertyBag2 : IUnknown
{
    HRESULT Read(uint cProperties, PROPBAG2* pPropBag, IErrorLog pErrLog, VARIANT* pvarValue, HRESULT* phrError);
    HRESULT Write(uint cProperties, PROPBAG2* pPropBag, VARIANT* pvarValue);
    HRESULT CountProperties(uint* pcProperties);
    HRESULT GetPropertyInfo(uint iProperty, uint cProperties, PROPBAG2* pPropBag, uint* pcProperties);
    HRESULT LoadObject(const(PWSTR) pstrName, uint dwHint, IUnknown pUnkObject, IErrorLog pErrLog);
}


// GUIDs


const GUID IID_IDirectWriterLock   = GUIDOF!IDirectWriterLock;
const GUID IID_IEnumSTATPROPSETSTG = GUIDOF!IEnumSTATPROPSETSTG;
const GUID IID_IEnumSTATPROPSTG    = GUIDOF!IEnumSTATPROPSTG;
const GUID IID_IEnumSTATSTG        = GUIDOF!IEnumSTATSTG;
const GUID IID_IFillLockBytes      = GUIDOF!IFillLockBytes;
const GUID IID_ILayoutStorage      = GUIDOF!ILayoutStorage;
const GUID IID_ILockBytes          = GUIDOF!ILockBytes;
const GUID IID_IPersistStorage     = GUIDOF!IPersistStorage;
const GUID IID_IPropertyBag        = GUIDOF!IPropertyBag;
const GUID IID_IPropertyBag2       = GUIDOF!IPropertyBag2;
const GUID IID_IPropertySetStorage = GUIDOF!IPropertySetStorage;
const GUID IID_IPropertyStorage    = GUIDOF!IPropertyStorage;
const GUID IID_IRootStorage        = GUIDOF!IRootStorage;
const GUID IID_IStorage            = GUIDOF!IStorage;
