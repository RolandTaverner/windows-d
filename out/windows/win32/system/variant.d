// Written in the D programming language.

module windows.win32.system.variant;

public import windows.core;
public import system : Guid;
public import windows.win32.foundation : BOOL, BSTR, CHAR, DECIMAL, FILETIME, HINSTANCE,
                                         HRESULT, PSTR, PWSTR, SYSTEMTIME,
                                         VARIANT_BOOL;
public import windows.win32.system.com : CY, IDispatch, IUnknown, SAFEARRAY;
public import windows.win32.system.ole : IRecordInfo;

extern(Windows) @nogc nothrow:


// Enums

alias VAR_CHANGE_FLAGS = ushort;
enum : ushort
{
    VARIANT_NOVALUEPROP        = 0x0001,
    VARIANT_ALPHABOOL          = 0x0002,
    VARIANT_NOUSEROVERRIDE     = 0x0004,
    VARIANT_CALENDAR_HIJRI     = 0x0008,
    VARIANT_LOCALBOOL          = 0x0010,
    VARIANT_CALENDAR_THAI      = 0x0020,
    VARIANT_CALENDAR_GREGORIAN = 0x0040,
    VARIANT_USE_NLS            = 0x0080,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wtypes/ne-wtypes-varenum))], [])
alias VARENUM = ushort;
enum : ushort
{
    VT_EMPTY            = 0x0000,
    VT_NULL             = 0x0001,
    VT_I2               = 0x0002,
    VT_I4               = 0x0003,
    VT_R4               = 0x0004,
    VT_R8               = 0x0005,
    VT_CY               = 0x0006,
    VT_DATE             = 0x0007,
    VT_BSTR             = 0x0008,
    VT_DISPATCH         = 0x0009,
    VT_ERROR            = 0x000a,
    VT_BOOL             = 0x000b,
    VT_VARIANT          = 0x000c,
    VT_UNKNOWN          = 0x000d,
    VT_DECIMAL          = 0x000e,
    VT_I1               = 0x0010,
    VT_UI1              = 0x0011,
    VT_UI2              = 0x0012,
    VT_UI4              = 0x0013,
    VT_I8               = 0x0014,
    VT_UI8              = 0x0015,
    VT_INT              = 0x0016,
    VT_UINT             = 0x0017,
    VT_VOID             = 0x0018,
    VT_HRESULT          = 0x0019,
    VT_PTR              = 0x001a,
    VT_SAFEARRAY        = 0x001b,
    VT_CARRAY           = 0x001c,
    VT_USERDEFINED      = 0x001d,
    VT_LPSTR            = 0x001e,
    VT_LPWSTR           = 0x001f,
    VT_RECORD           = 0x0024,
    VT_INT_PTR          = 0x0025,
    VT_UINT_PTR         = 0x0026,
    VT_FILETIME         = 0x0040,
    VT_BLOB             = 0x0041,
    VT_STREAM           = 0x0042,
    VT_STORAGE          = 0x0043,
    VT_STREAMED_OBJECT  = 0x0044,
    VT_STORED_OBJECT    = 0x0045,
    VT_BLOB_OBJECT      = 0x0046,
    VT_CF               = 0x0047,
    VT_CLSID            = 0x0048,
    VT_VERSIONED_STREAM = 0x0049,
    VT_BSTR_BLOB        = 0x0fff,
    VT_VECTOR           = 0x1000,
    VT_ARRAY            = 0x2000,
    VT_BYREF            = 0x4000,
    VT_RESERVED         = 0x8000,
    VT_ILLEGAL          = 0xffff,
    VT_ILLEGALMASKED    = 0x0fff,
    VT_TYPEMASK         = 0x0fff,
}
alias PSTIME_FLAGS = int;
enum : int
{
    PSTF_UTC   = 0x00000000,
    PSTF_LOCAL = 0x00000001,
}
alias DRAWPROGRESSFLAGS = int;
enum : int
{
    DPF_NONE             = 0x00000000,
    DPF_MARQUEE          = 0x00000001,
    DPF_MARQUEE_COMPLETE = 0x00000002,
    DPF_ERROR            = 0x00000004,
    DPF_WARNING          = 0x00000008,
    DPF_STOPPED          = 0x00000010,
}

// Structs


//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/ns-oaidl-variant))], [])
struct VARIANT
{
    _Anonymous_e__Union Anonymous;
}

// Functions

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-variant_usersize))], [])
@DllImport("OLEAUT32.dll")
uint VARIANT_UserSize(uint* param0, uint param1, VARIANT* param2);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-variant_usermarshal))], [])
@DllImport("OLEAUT32.dll")
ubyte* VARIANT_UserMarshal(uint* param0, ubyte* param1, VARIANT* param2);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-variant_userunmarshal))], [])
@DllImport("OLEAUT32.dll")
ubyte* VARIANT_UserUnmarshal(uint* param0, ubyte* param1, VARIANT* param2);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-variant_userfree))], [])
@DllImport("OLEAUT32.dll")
void VARIANT_UserFree(uint* param0, VARIANT* param1);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("OLEAUT32.dll")
uint VARIANT_UserSize64(uint* param0, uint param1, VARIANT* param2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("OLEAUT32.dll")
ubyte* VARIANT_UserMarshal64(uint* param0, ubyte* param1, VARIANT* param2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("OLEAUT32.dll")
ubyte* VARIANT_UserUnmarshal64(uint* param0, ubyte* param1, VARIANT* param2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("OLEAUT32.dll")
void VARIANT_UserFree64(uint* param0, VARIANT* param1);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-dosdatetimetovarianttime))], [])
@DllImport("OLEAUT32.dll")
int DosDateTimeToVariantTime(ushort wDosDate, ushort wDosTime, double* pvtime);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varianttimetodosdatetime))], [])
@DllImport("OLEAUT32.dll")
int VariantTimeToDosDateTime(double vtime, ushort* pwDosDate, ushort* pwDosTime);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-systemtimetovarianttime))], [])
@DllImport("OLEAUT32.dll")
int SystemTimeToVariantTime(SYSTEMTIME* lpSystemTime, double* pvtime);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varianttimetosystemtime))], [])
@DllImport("OLEAUT32.dll")
int VariantTimeToSystemTime(double vtime, SYSTEMTIME* lpSystemTime);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-variantinit))], [])
@DllImport("OLEAUT32.dll")
void VariantInit(VARIANT* pvarg);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-variantclear))], [])
@DllImport("OLEAUT32.dll")
HRESULT VariantClear(VARIANT* pvarg);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-variantcopy))], [])
@DllImport("OLEAUT32.dll")
HRESULT VariantCopy(VARIANT* pvargDest, const(VARIANT)* pvargSrc);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-variantcopyind))], [])
@DllImport("OLEAUT32.dll")
HRESULT VariantCopyInd(VARIANT* pvarDest, const(VARIANT)* pvargSrc);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-variantchangetype))], [])
@DllImport("OLEAUT32.dll")
HRESULT VariantChangeType(VARIANT* pvargDest, const(VARIANT)* pvarSrc, VAR_CHANGE_FLAGS wFlags, VARENUM vt);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-variantchangetypeex))], [])
@DllImport("OLEAUT32.dll")
HRESULT VariantChangeTypeEx(VARIANT* pvargDest, const(VARIANT)* pvarSrc, uint lcid, VAR_CHANGE_FLAGS wFlags, 
                            VARENUM vt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT InitVariantFromResource(HINSTANCE hinst, uint id, VARIANT* pvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT InitVariantFromBuffer(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pv, 
                              uint cb, VARIANT* pvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT InitVariantFromGUIDAsString(const(GUID)* guid, VARIANT* pvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT InitVariantFromFileTime(const(FILETIME)* pft, VARIANT* pvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT InitVariantFromFileTimeArray(const(FILETIME)* prgft, uint cElems, VARIANT* pvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT InitVariantFromVariantArrayElem(const(VARIANT)* varIn, uint iElem, VARIANT* pvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT InitVariantFromBooleanArray(const(BOOL)* prgf, uint cElems, VARIANT* pvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT InitVariantFromInt16Array(const(short)* prgn, uint cElems, VARIANT* pvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT InitVariantFromUInt16Array(const(ushort)* prgn, uint cElems, VARIANT* pvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT InitVariantFromInt32Array(const(int)* prgn, uint cElems, VARIANT* pvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT InitVariantFromUInt32Array(const(uint)* prgn, uint cElems, VARIANT* pvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT InitVariantFromInt64Array(const(long)* prgn, uint cElems, VARIANT* pvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT InitVariantFromUInt64Array(const(ulong)* prgn, uint cElems, VARIANT* pvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT InitVariantFromDoubleArray(const(double)* prgn, uint cElems, VARIANT* pvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT InitVariantFromStringArray(const(PWSTR)* prgsz, uint cElems, VARIANT* pvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
BOOL VariantToBooleanWithDefault(const(VARIANT)* varIn, BOOL fDefault);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
short VariantToInt16WithDefault(const(VARIANT)* varIn, short iDefault);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
ushort VariantToUInt16WithDefault(const(VARIANT)* varIn, ushort uiDefault);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
int VariantToInt32WithDefault(const(VARIANT)* varIn, int lDefault);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
uint VariantToUInt32WithDefault(const(VARIANT)* varIn, uint ulDefault);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
long VariantToInt64WithDefault(const(VARIANT)* varIn, long llDefault);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
ulong VariantToUInt64WithDefault(const(VARIANT)* varIn, ulong ullDefault);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
double VariantToDoubleWithDefault(const(VARIANT)* varIn, double dblDefault);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
PWSTR VariantToStringWithDefault(const(VARIANT)* varIn, const(PWSTR) pszDefault);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT VariantToBoolean(const(VARIANT)* varIn, BOOL* pfRet);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT VariantToInt16(const(VARIANT)* varIn, short* piRet);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT VariantToUInt16(const(VARIANT)* varIn, ushort* puiRet);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT VariantToInt32(const(VARIANT)* varIn, int* plRet);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT VariantToUInt32(const(VARIANT)* varIn, uint* pulRet);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT VariantToInt64(const(VARIANT)* varIn, long* pllRet);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT VariantToUInt64(const(VARIANT)* varIn, ulong* pullRet);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT VariantToDouble(const(VARIANT)* varIn, double* pdblRet);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT VariantToBuffer(const(VARIANT)* varIn, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pv, 
                        uint cb);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT VariantToGUID(const(VARIANT)* varIn, GUID* pguid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT VariantToString(const(VARIANT)* varIn, PWSTR pszBuf, uint cchBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT VariantToStringAlloc(const(VARIANT)* varIn, PWSTR* ppszBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT VariantToDosDateTime(const(VARIANT)* varIn, ushort* pwDate, ushort* pwTime);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT VariantToFileTime(const(VARIANT)* varIn, PSTIME_FLAGS stfOut, FILETIME* pftOut);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
uint VariantGetElementCount(const(VARIANT)* varIn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT VariantToBooleanArray(const(VARIANT)* var, BOOL* prgf, uint crgn, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT VariantToInt16Array(const(VARIANT)* var, short* prgn, uint crgn, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT VariantToUInt16Array(const(VARIANT)* var, ushort* prgn, uint crgn, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT VariantToInt32Array(const(VARIANT)* var, int* prgn, uint crgn, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT VariantToUInt32Array(const(VARIANT)* var, uint* prgn, uint crgn, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT VariantToInt64Array(const(VARIANT)* var, long* prgn, uint crgn, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT VariantToUInt64Array(const(VARIANT)* var, ulong* prgn, uint crgn, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT VariantToDoubleArray(const(VARIANT)* var, double* prgn, uint crgn, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT VariantToStringArray(const(VARIANT)* var, PWSTR* prgsz, uint crgsz, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT VariantToBooleanArrayAlloc(const(VARIANT)* var, BOOL** pprgf, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT VariantToInt16ArrayAlloc(const(VARIANT)* var, short** pprgn, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT VariantToUInt16ArrayAlloc(const(VARIANT)* var, ushort** pprgn, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT VariantToInt32ArrayAlloc(const(VARIANT)* var, int** pprgn, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT VariantToUInt32ArrayAlloc(const(VARIANT)* var, uint** pprgn, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT VariantToInt64ArrayAlloc(const(VARIANT)* var, long** pprgn, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT VariantToUInt64ArrayAlloc(const(VARIANT)* var, ulong** pprgn, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT VariantToDoubleArrayAlloc(const(VARIANT)* var, double** pprgn, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT VariantToStringArrayAlloc(const(VARIANT)* var, PWSTR** pprgsz, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT VariantGetBooleanElem(const(VARIANT)* var, uint iElem, BOOL* pfVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT VariantGetInt16Elem(const(VARIANT)* var, uint iElem, short* pnVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT VariantGetUInt16Elem(const(VARIANT)* var, uint iElem, ushort* pnVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT VariantGetInt32Elem(const(VARIANT)* var, uint iElem, int* pnVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT VariantGetUInt32Elem(const(VARIANT)* var, uint iElem, uint* pnVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT VariantGetInt64Elem(const(VARIANT)* var, uint iElem, long* pnVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT VariantGetUInt64Elem(const(VARIANT)* var, uint iElem, ulong* pnVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT VariantGetDoubleElem(const(VARIANT)* var, uint iElem, double* pnVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT VariantGetStringElem(const(VARIANT)* var, uint iElem, PWSTR* ppszVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
void ClearVariantArray(VARIANT* pvars, uint cvars);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
int VariantCompare(const(VARIANT)* var1, const(VARIANT)* var2);


