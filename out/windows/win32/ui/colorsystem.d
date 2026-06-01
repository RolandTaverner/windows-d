// Written in the D programming language.

module windows.win32.ui.colorsystem;

public import windows.core;
public import system.system : Guid;
public import windows.win32.foundation.foundation : BOOL, BSTR, CHAR, COLORREF, HRESULT,
                                                    HWND, LPARAM, LUID, PSTR, PWSTR;
public import windows.win32.graphics.gdi : CIEXYZ, CIEXYZTRIPLE, EMR, HDC, HPALETTE,
                                           RGBTRIPLE;
public import windows.win32.system.com.com : IUnknown;
public import windows.win32.ui.windowsandmessaging : DLGPROC;

extern(Windows) @nogc nothrow:


// Enums


alias ICM_COMMAND = uint;
enum : uint
{
    ICM_ADDPROFILE          = 0x00000001U,
    ICM_DELETEPROFILE       = 0x00000002U,
    ICM_QUERYPROFILE        = 0x00000003U,
    ICM_SETDEFAULTPROFILE   = 0x00000004U,
    ICM_REGISTERICMATCHER   = 0x00000005U,
    ICM_UNREGISTERICMATCHER = 0x00000006U,
    ICM_QUERYMATCH          = 0x00000007U,
}

alias ICM_MODE = int;
enum : int
{
    ICM_OFF            = 0x00000001,
    ICM_ON             = 0x00000002,
    ICM_QUERY          = 0x00000003,
    ICM_DONE_OUTSIDEDC = 0x00000004,
}

alias COLOR_MATCH_TO_TARGET_ACTION = uint;
enum : uint
{
    CS_ENABLE           = 0x00000001U,
    CS_DISABLE          = 0x00000002U,
    CS_DELETE_TRANSFORM = 0x00000003U,
}

alias LCSCSTYPE = int;
enum : int
{
    LCS_CALIBRATED_RGB      = 0x00000000,
    LCS_sRGB                = 0x73524742,
    LCS_WINDOWS_COLOR_SPACE = 0x57696e20,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/TSF/colortype
alias COLORTYPE = int;
enum : int
{
    COLOR_GRAY      = 0x00000001,
    COLOR_RGB       = 0x00000002,
    COLOR_XYZ       = 0x00000003,
    COLOR_Yxy       = 0x00000004,
    COLOR_Lab       = 0x00000005,
    COLOR_3_CHANNEL = 0x00000006,
    COLOR_CMYK      = 0x00000007,
    COLOR_5_CHANNEL = 0x00000008,
    COLOR_6_CHANNEL = 0x00000009,
    COLOR_7_CHANNEL = 0x0000000a,
    COLOR_8_CHANNEL = 0x0000000b,
    COLOR_NAMED     = 0x0000000c,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/ne-icm-colorprofiletype
alias COLORPROFILETYPE = int;
enum : int
{
    CPT_ICC  = 0x00000000,
    CPT_DMP  = 0x00000001,
    CPT_CAMP = 0x00000002,
    CPT_GMMP = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/ne-icm-colorprofilesubtype
alias COLORPROFILESUBTYPE = int;
enum : int
{
    CPST_PERCEPTUAL                  = 0x00000000,
    CPST_RELATIVE_COLORIMETRIC       = 0x00000001,
    CPST_SATURATION                  = 0x00000002,
    CPST_ABSOLUTE_COLORIMETRIC       = 0x00000003,
    CPST_NONE                        = 0x00000004,
    CPST_RGB_WORKING_SPACE           = 0x00000005,
    CPST_CUSTOM_WORKING_SPACE        = 0x00000006,
    CPST_STANDARD_DISPLAY_COLOR_MODE = 0x00000007,
    CPST_EXTENDED_DISPLAY_COLOR_MODE = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/ne-icm-colordatatype
alias COLORDATATYPE = int;
enum : int
{
    COLOR_BYTE               = 0x00000001,
    COLOR_WORD               = 0x00000002,
    COLOR_FLOAT              = 0x00000003,
    COLOR_S2DOT13FIXED       = 0x00000004,
    COLOR_10b_R10G10B10A2    = 0x00000005,
    COLOR_10b_R10G10B10A2_XR = 0x00000006,
    COLOR_FLOAT16            = 0x00000007,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/ne-icm-bmformat
alias BMFORMAT = int;
enum : int
{
    BM_x555RGB             = 0x00000000,
    BM_x555XYZ             = 0x00000101,
    BM_x555Yxy             = 0x00000102,
    BM_x555Lab             = 0x00000103,
    BM_x555G3CH            = 0x00000104,
    BM_RGBTRIPLETS         = 0x00000002,
    BM_BGRTRIPLETS         = 0x00000004,
    BM_XYZTRIPLETS         = 0x00000201,
    BM_YxyTRIPLETS         = 0x00000202,
    BM_LabTRIPLETS         = 0x00000203,
    BM_G3CHTRIPLETS        = 0x00000204,
    BM_5CHANNEL            = 0x00000205,
    BM_6CHANNEL            = 0x00000206,
    BM_7CHANNEL            = 0x00000207,
    BM_8CHANNEL            = 0x00000208,
    BM_GRAY                = 0x00000209,
    BM_xRGBQUADS           = 0x00000008,
    BM_xBGRQUADS           = 0x00000010,
    BM_xG3CHQUADS          = 0x00000304,
    BM_KYMCQUADS           = 0x00000305,
    BM_CMYKQUADS           = 0x00000020,
    BM_10b_RGB             = 0x00000009,
    BM_10b_XYZ             = 0x00000401,
    BM_10b_Yxy             = 0x00000402,
    BM_10b_Lab             = 0x00000403,
    BM_10b_G3CH            = 0x00000404,
    BM_NAMED_INDEX         = 0x00000405,
    BM_16b_RGB             = 0x0000000a,
    BM_16b_XYZ             = 0x00000501,
    BM_16b_Yxy             = 0x00000502,
    BM_16b_Lab             = 0x00000503,
    BM_16b_G3CH            = 0x00000504,
    BM_16b_GRAY            = 0x00000505,
    BM_565RGB              = 0x00000001,
    BM_32b_scRGB           = 0x00000601,
    BM_32b_scARGB          = 0x00000602,
    BM_S2DOT13FIXED_scRGB  = 0x00000603,
    BM_S2DOT13FIXED_scARGB = 0x00000604,
    BM_R10G10B10A2         = 0x00000701,
    BM_R10G10B10A2_XR      = 0x00000702,
    BM_R16G16B16A16_FLOAT  = 0x00000703,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/ne-icm-wcs_profile_management_scope
alias WCS_PROFILE_MANAGEMENT_SCOPE = int;
enum : int
{
    WCS_PROFILE_MANAGEMENT_SCOPE_SYSTEM_WIDE  = 0x00000000,
    WCS_PROFILE_MANAGEMENT_SCOPE_CURRENT_USER = 0x00000001,
}

alias WCS_DEVICE_CAPABILITIES_TYPE = int;
enum : int
{
    VideoCardGammaTable      = 0x00000001,
    MicrosoftHardwareColorV2 = 0x00000002,
}

// Constants


enum GUID CATID_WcsPlugin = GUID("a0b402e0-8240-405f-8a16-8a5b4df2f0dd");
enum uint MAX_COLOR_CHANNELS = 0x00000008U;

enum : uint
{
    INTENT_PERCEPTUAL            = 0x00000000U,
    INTENT_RELATIVE_COLORIMETRIC = 0x00000001U,
}

enum : uint
{
    INTENT_SATURATION            = 0x00000002U,
    INTENT_ABSOLUTE_COLORIMETRIC = 0x00000003U,
}

enum uint FLAG_EMBEDDEDPROFILE = 0x00000001U;
enum uint FLAG_DEPENDENTONDATA = 0x00000002U;
enum uint FLAG_ENABLE_CHROMATIC_ADAPTATION = 0x02000000U;
enum uint ATTRIB_TRANSPARENCY = 0x00000001U;
enum uint ATTRIB_MATTE = 0x00000002U;

enum : uint
{
    PROFILE_FILENAME  = 0x00000001U,
    PROFILE_MEMBUFFER = 0x00000002U,
    PROFILE_READ      = 0x00000001U,
    PROFILE_READWRITE = 0x00000002U,
}

enum uint INDEX_DONT_CARE = 0x00000000U;
enum uint CMM_FROM_PROFILE = 0x00000000U;
enum uint ENUM_TYPE_VERSION = 0x00000300U;
enum uint ET_DEVICENAME = 0x00000001U;
enum uint ET_MEDIATYPE = 0x00000002U;
enum uint ET_DITHERMODE = 0x00000004U;
enum uint ET_RESOLUTION = 0x00000008U;
enum uint ET_CMMTYPE = 0x00000010U;
enum uint ET_CLASS = 0x00000020U;
enum uint ET_DATACOLORSPACE = 0x00000040U;
enum uint ET_CONNECTIONSPACE = 0x00000080U;
enum uint ET_SIGNATURE = 0x00000100U;
enum uint ET_PLATFORM = 0x00000200U;
enum uint ET_PROFILEFLAGS = 0x00000400U;
enum uint ET_MANUFACTURER = 0x00000800U;
enum uint ET_MODEL = 0x00001000U;
enum uint ET_ATTRIBUTES = 0x00002000U;
enum uint ET_RENDERINGINTENT = 0x00004000U;
enum uint ET_CREATOR = 0x00008000U;
enum uint ET_DEVICECLASS = 0x00010000U;
enum uint ET_STANDARDDISPLAYCOLOR = 0x00020000U;
enum uint ET_EXTENDEDDISPLAYCOLOR = 0x00040000U;
enum uint PROOF_MODE = 0x00000001U;
enum uint NORMAL_MODE = 0x00000002U;
enum uint BEST_MODE = 0x00000003U;
enum uint ENABLE_GAMUT_CHECKING = 0x00010000U;
enum uint USE_RELATIVE_COLORIMETRIC = 0x00020000U;
enum uint FAST_TRANSLATE = 0x00040000U;
enum uint PRESERVEBLACK = 0x00100000U;
enum uint WCS_ALWAYS = 0x00200000U;
enum uint SEQUENTIAL_TRANSFORM = 0x80800000U;
enum uint RESERVED = 0x80000000U;

enum : uint
{
    CSA_A    = 0x00000001U,
    CSA_ABC  = 0x00000002U,
    CSA_DEF  = 0x00000003U,
    CSA_DEFG = 0x00000004U,
    CSA_GRAY = 0x00000005U,
    CSA_RGB  = 0x00000006U,
    CSA_CMYK = 0x00000007U,
    CSA_Lab  = 0x00000008U,
}

enum uint CMM_WIN_VERSION = 0x00000000U;

enum : uint
{
    CMM_IDENT          = 0x00000001U,
    CMM_DRIVER_VERSION = 0x00000002U,
}

enum uint CMM_DLL_VERSION = 0x00000003U;
enum uint CMM_VERSION = 0x00000004U;
enum uint CMM_DESCRIPTION = 0x00000005U;
enum uint CMM_LOGOICON = 0x00000006U;
enum uint CMS_FORWARD = 0x00000000U;
enum uint CMS_BACKWARD = 0x00000001U;
enum uint COLOR_MATCH_VERSION = 0x00000200U;
enum uint CMS_DISABLEICM = 0x00000001U;
enum uint CMS_ENABLEPROOFING = 0x00000002U;
enum uint CMS_SETRENDERINTENT = 0x00000004U;
enum uint CMS_SETPROOFINTENT = 0x00000008U;
enum uint CMS_SETMONITORPROFILE = 0x00000010U;
enum uint CMS_SETPRINTERPROFILE = 0x00000020U;
enum uint CMS_SETTARGETPROFILE = 0x00000040U;

enum : uint
{
    CMS_USEHOOK          = 0x00000080U,
    CMS_USEAPPLYCALLBACK = 0x00000100U,
}

enum uint CMS_USEDESCRIPTION = 0x00000200U;

enum : uint
{
    CMS_DISABLEINTENT       = 0x00000400U,
    CMS_DISABLERENDERINTENT = 0x00000800U,
}

enum int CMS_MONITOROVERFLOW = 0x80000000;
enum int CMS_PRINTEROVERFLOW = 0x40000000;
enum int CMS_TARGETOVERFLOW = 0x20000000;
enum int DONT_USE_EMBEDDED_WCS_PROFILES = 0x00000001;
enum int WCS_DEFAULT = 0x00000000;
enum int WCS_ICCONLY = 0x00010000;

// Callbacks

//DELEGATE ATTR: AnsiAttribute : CustomAttributeSig([], [])
alias ICMENUMPROCA = int function(PSTR param0, LPARAM param1);
//DELEGATE ATTR: UnicodeAttribute : CustomAttributeSig([], [])
alias ICMENUMPROCW = int function(PWSTR param0, LPARAM param1);
alias LPBMCALLBACKFN = BOOL function(uint param0, uint param1, LPARAM param2);
//DELEGATE ATTR: UnicodeAttribute : CustomAttributeSig([], [])
alias PCMSCALLBACKW = BOOL function(COLORMATCHSETUPW* param0, LPARAM param1);
//DELEGATE ATTR: AnsiAttribute : CustomAttributeSig([], [])
alias PCMSCALLBACKA = BOOL function(COLORMATCHSETUPA* param0, LPARAM param1);

// Structs


@RAIIFree!DeleteColorSpace
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HCOLORSPACE
{
    void* Value;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-logcolorspacea
struct LOGCOLORSPACEA
{
    uint         lcsSignature;
    uint         lcsVersion;
    uint         lcsSize;
    LCSCSTYPE    lcsCSType;
    int          lcsIntent;
    CIEXYZTRIPLE lcsEndpoints;
    uint         lcsGammaRed;
    uint         lcsGammaGreen;
    uint         lcsGammaBlue;
    CHAR[260]    lcsFilename;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-logcolorspacew
struct LOGCOLORSPACEW
{
    uint         lcsSignature;
    uint         lcsVersion;
    uint         lcsSize;
    LCSCSTYPE    lcsCSType;
    int          lcsIntent;
    CIEXYZTRIPLE lcsEndpoints;
    uint         lcsGammaRed;
    uint         lcsGammaGreen;
    uint         lcsGammaBlue;
    wchar[260]   lcsFilename;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrcreatecolorspace
struct EMRCREATECOLORSPACE
{
    EMR            emr;
    uint           ihCS;
    LOGCOLORSPACEA lcs;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrcreatecolorspacew
struct EMRCREATECOLORSPACEW
{
    EMR            emr;
    uint           ihCS;
    LOGCOLORSPACEW lcs;
    uint           dwFlags;
    uint           cbData;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] Data;
}

struct XYZColorF
{
    float X;
    float Y;
    float Z;
}

struct JChColorF
{
    float J;
    float C;
    float h;
}

struct JabColorF
{
    float J;
    float a;
    float b;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wcsplugin/ns-wcsplugin-gamutshelltriangle
struct GamutShellTriangle
{
    uint[3] aVertexIndex;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wcsplugin/ns-wcsplugin-gamutshell
struct GamutShell
{
    float               JMin;
    float               JMax;
    uint                cVertices;
    uint                cTriangles;
    JabColorF*          pVertices;
    GamutShellTriangle* pTriangles;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wcsplugin/ns-wcsplugin-primaryjabcolors
struct PrimaryJabColors
{
    JabColorF red;
    JabColorF yellow;
    JabColorF green;
    JabColorF cyan;
    JabColorF blue;
    JabColorF magenta;
    JabColorF black;
    JabColorF white;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wcsplugin/ns-wcsplugin-primaryxyzcolors
struct PrimaryXYZColors
{
    XYZColorF red;
    XYZColorF yellow;
    XYZColorF green;
    XYZColorF cyan;
    XYZColorF blue;
    XYZColorF magenta;
    XYZColorF black;
    XYZColorF white;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wcsplugin/ns-wcsplugin-gamutboundarydescription
struct GamutBoundaryDescription
{
    PrimaryJabColors* pPrimaries;
    uint              cNeutralSamples;
    JabColorF*        pNeutralSamples;
    GamutShell*       pReferenceShell;
    GamutShell*       pPlausibleShell;
    GamutShell*       pPossibleShell;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wcsplugin/ns-wcsplugin-blackinformation
struct BlackInformation
{
    BOOL  fBlackOnly;
    float blackWeight;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/ns-icm-named_profile_info
struct NAMED_PROFILE_INFO
{
    uint     dwFlags;
    uint     dwCount;
    uint     dwCountDevCoordinates;
    byte[32] szPrefix;
    byte[32] szSuffix;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/ns-icm-graycolor
struct GRAYCOLOR
{
    ushort gray;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/ns-icm-rgbcolor
struct RGBCOLOR
{
    ushort red;
    ushort green;
    ushort blue;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/ns-icm-cmykcolor
struct CMYKCOLOR
{
    ushort cyan;
    ushort magenta;
    ushort yellow;
    ushort black;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/ns-icm-xyzcolor
struct XYZCOLOR
{
    ushort X;
    ushort Y;
    ushort Z;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/ns-icm-yxycolor
struct YxyCOLOR
{
    ushort Y;
    ushort x;
    ushort y;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/ns-icm-labcolor
struct LabCOLOR
{
    ushort L;
    ushort a;
    ushort b;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/ns-icm-generic3channel
struct GENERIC3CHANNEL
{
    ushort ch1;
    ushort ch2;
    ushort ch3;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/ns-icm-namedcolor
struct NAMEDCOLOR
{
    uint dwIndex;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/ns-icm-hificolor
struct HiFiCOLOR
{
    ubyte[8] channel;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/ns-icm-color
union COLOR
{
    GRAYCOLOR       gray;
    RGBCOLOR        rgb;
    CMYKCOLOR       cmyk;
    XYZCOLOR        XYZ;
    YxyCOLOR        Yxy;
    LabCOLOR        Lab;
    GENERIC3CHANNEL gen3ch;
    NAMEDCOLOR      named;
    HiFiCOLOR       hifi;
    struct
    {
        uint  reserved1;
        void* reserved2;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/ns-icm-profileheader
struct PROFILEHEADER
{
    uint      phSize;
    uint      phCMMType;
    uint      phVersion;
    uint      phClass;
    uint      phDataColorSpace;
    uint      phConnectionSpace;
    uint[3]   phDateTime;
    uint      phSignature;
    uint      phPlatform;
    uint      phProfileFlags;
    uint      phManufacturer;
    uint      phModel;
    uint[2]   phAttributes;
    uint      phRenderingIntent;
    CIEXYZ    phIlluminant;
    uint      phCreator;
    ubyte[44] phReserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/ns-icm-profile
struct PROFILE
{
    uint  dwType;
    void* pProfileData;
    uint  cbDataSize;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/ns-icm-enumtypea
struct ENUMTYPEA
{
    uint        dwSize;
    uint        dwVersion;
    uint        dwFields;
    const(PSTR) pDeviceName;
    uint        dwMediaType;
    uint        dwDitheringMode;
    uint[2]     dwResolution;
    uint        dwCMMType;
    uint        dwClass;
    uint        dwDataColorSpace;
    uint        dwConnectionSpace;
    uint        dwSignature;
    uint        dwPlatform;
    uint        dwProfileFlags;
    uint        dwManufacturer;
    uint        dwModel;
    uint[2]     dwAttributes;
    uint        dwRenderingIntent;
    uint        dwCreator;
    uint        dwDeviceClass;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/ns-icm-enumtypew
struct ENUMTYPEW
{
    uint         dwSize;
    uint         dwVersion;
    uint         dwFields;
    const(PWSTR) pDeviceName;
    uint         dwMediaType;
    uint         dwDitheringMode;
    uint[2]      dwResolution;
    uint         dwCMMType;
    uint         dwClass;
    uint         dwDataColorSpace;
    uint         dwConnectionSpace;
    uint         dwSignature;
    uint         dwPlatform;
    uint         dwProfileFlags;
    uint         dwManufacturer;
    uint         dwModel;
    uint[2]      dwAttributes;
    uint         dwRenderingIntent;
    uint         dwCreator;
    uint         dwDeviceClass;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/ns-icm-colormatchsetupw
struct COLORMATCHSETUPW
{
    uint          dwSize;
    uint          dwVersion;
    uint          dwFlags;
    HWND          hwndOwner;
    const(PWSTR)  pSourceName;
    const(PWSTR)  pDisplayName;
    const(PWSTR)  pPrinterName;
    uint          dwRenderIntent;
    uint          dwProofingIntent;
    PWSTR         pMonitorProfile;
    uint          ccMonitorProfile;
    PWSTR         pPrinterProfile;
    uint          ccPrinterProfile;
    PWSTR         pTargetProfile;
    uint          ccTargetProfile;
    DLGPROC       lpfnHook;
    LPARAM        lParam;
    PCMSCALLBACKW lpfnApplyCallback;
    LPARAM        lParamApplyCallback;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/ns-icm-colormatchsetupa
struct COLORMATCHSETUPA
{
    uint          dwSize;
    uint          dwVersion;
    uint          dwFlags;
    HWND          hwndOwner;
    const(PSTR)   pSourceName;
    const(PSTR)   pDisplayName;
    const(PSTR)   pPrinterName;
    uint          dwRenderIntent;
    uint          dwProofingIntent;
    PSTR          pMonitorProfile;
    uint          ccMonitorProfile;
    PSTR          pPrinterProfile;
    uint          ccPrinterProfile;
    PSTR          pTargetProfile;
    uint          ccTargetProfile;
    DLGPROC       lpfnHook;
    LPARAM        lParam;
    PCMSCALLBACKA lpfnApplyCallback;
    LPARAM        lParamApplyCallback;
}

struct WCS_DEVICE_VCGT_CAPABILITIES
{
    uint Size;
    BOOL SupportsVcgt;
}

struct WCS_DEVICE_MHC2_CAPABILITIES
{
    uint Size;
    BOOL SupportsMhc2;
    uint RegammaLutEntryCount;
    uint CscXyzMatrixRows;
    uint CscXyzMatrixColumns;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("GDI32.dll")
int SetICMMode(HDC hdc, ICM_MODE mode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("GDI32.dll")
BOOL CheckColorsInGamut(HDC hdc, RGBTRIPLE* lpRGBTriple, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* dlpBuffer, 
                        uint nCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("GDI32.dll")
HCOLORSPACE GetColorSpace(HDC hdc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("GDI32.dll")
BOOL GetLogColorSpaceA(HCOLORSPACE hColorSpace, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/LOGCOLORSPACEA* lpBuffer, 
                       uint nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("GDI32.dll")
BOOL GetLogColorSpaceW(HCOLORSPACE hColorSpace, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/LOGCOLORSPACEW* lpBuffer, 
                       uint nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("GDI32.dll")
HCOLORSPACE CreateColorSpaceA(LOGCOLORSPACEA* lplcs);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("GDI32.dll")
HCOLORSPACE CreateColorSpaceW(LOGCOLORSPACEW* lplcs);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("GDI32.dll")
HCOLORSPACE SetColorSpace(HDC hdc, HCOLORSPACE hcs);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("GDI32.dll")
BOOL DeleteColorSpace(HCOLORSPACE hcs);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("GDI32.dll")
BOOL GetICMProfileA(HDC hdc, uint* pBufSize, PSTR pszFilename);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("GDI32.dll")
BOOL GetICMProfileW(HDC hdc, uint* pBufSize, PWSTR pszFilename);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("GDI32.dll")
BOOL SetICMProfileA(HDC hdc, PSTR lpFileName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("GDI32.dll")
BOOL SetICMProfileW(HDC hdc, PWSTR lpFileName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("GDI32.dll")
BOOL GetDeviceGammaRamp(HDC hdc, void* lpRamp);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("GDI32.dll")
BOOL SetDeviceGammaRamp(HDC hdc, void* lpRamp);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("GDI32.dll")
BOOL ColorMatchToTarget(HDC hdc, HDC hdcTarget, COLOR_MATCH_TO_TARGET_ACTION action);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("GDI32.dll")
int EnumICMProfilesA(HDC hdc, ICMENUMPROCA proc, LPARAM param2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("GDI32.dll")
int EnumICMProfilesW(HDC hdc, ICMENUMPROCW proc, LPARAM param2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("GDI32.dll")
BOOL UpdateICMRegKeyA(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint reserved, PSTR lpszCMID, 
                      PSTR lpszFileName, ICM_COMMAND command);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("GDI32.dll")
BOOL UpdateICMRegKeyW(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint reserved, PWSTR lpszCMID, 
                      PWSTR lpszFileName, ICM_COMMAND command);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("GDI32.dll")
BOOL ColorCorrectPalette(HDC hdc, HPALETTE hPal, uint deFirst, uint num);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("mscms.dll")
ptrdiff_t OpenColorProfileA(PROFILE* pProfile, uint dwDesiredAccess, uint dwShareMode, uint dwCreationMode);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("mscms.dll")
ptrdiff_t OpenColorProfileW(PROFILE* pProfile, uint dwDesiredAccess, uint dwShareMode, uint dwCreationMode);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-closecolorprofile
@DllImport("mscms.dll")
BOOL CloseColorProfile(ptrdiff_t hProfile);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-getcolorprofilefromhandle
@DllImport("mscms.dll")
BOOL GetColorProfileFromHandle(ptrdiff_t hProfile, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ubyte* pProfile, 
                               uint* pcbProfile);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-iscolorprofilevalid
@DllImport("mscms.dll")
BOOL IsColorProfileValid(ptrdiff_t hProfile, BOOL* pbValid);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("mscms.dll")
BOOL CreateProfileFromLogColorSpaceA(LOGCOLORSPACEA* pLogColorSpace, ubyte** pProfile);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("mscms.dll")
BOOL CreateProfileFromLogColorSpaceW(LOGCOLORSPACEW* pLogColorSpace, ubyte** pProfile);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-getcountcolorprofileelements
@DllImport("mscms.dll")
BOOL GetCountColorProfileElements(ptrdiff_t hProfile, uint* pnElementCount);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-getcolorprofileheader
@DllImport("mscms.dll")
BOOL GetColorProfileHeader(ptrdiff_t hProfile, PROFILEHEADER* pHeader);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-getcolorprofileelementtag
@DllImport("mscms.dll")
BOOL GetColorProfileElementTag(ptrdiff_t hProfile, uint dwIndex, uint* pTag);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-iscolorprofiletagpresent
@DllImport("mscms.dll")
BOOL IsColorProfileTagPresent(ptrdiff_t hProfile, uint tag, BOOL* pbPresent);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-getcolorprofileelement
@DllImport("mscms.dll")
BOOL GetColorProfileElement(ptrdiff_t hProfile, uint tag, uint dwOffset, uint* pcbElement, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pElement, 
                            BOOL* pbReference);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-setcolorprofileheader
@DllImport("mscms.dll")
BOOL SetColorProfileHeader(ptrdiff_t hProfile, PROFILEHEADER* pHeader);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-setcolorprofileelementsize
@DllImport("mscms.dll")
BOOL SetColorProfileElementSize(ptrdiff_t hProfile, uint tagType, uint pcbElement);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-setcolorprofileelement
@DllImport("mscms.dll")
BOOL SetColorProfileElement(ptrdiff_t hProfile, uint tag, uint dwOffset, uint* pcbElement, void* pElement);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-setcolorprofileelementreference
@DllImport("mscms.dll")
BOOL SetColorProfileElementReference(ptrdiff_t hProfile, uint newTag, uint refTag);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-getps2colorspacearray
@DllImport("mscms.dll")
BOOL GetPS2ColorSpaceArray(ptrdiff_t hProfile, uint dwIntent, uint dwCSAType, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* pPS2ColorSpaceArray, 
                           uint* pcbPS2ColorSpaceArray, BOOL* pbBinary);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-getps2colorrenderingintent
@DllImport("mscms.dll")
BOOL GetPS2ColorRenderingIntent(ptrdiff_t hProfile, uint dwIntent, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* pBuffer, 
                                uint* pcbPS2ColorRenderingIntent);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-getps2colorrenderingdictionary
@DllImport("mscms.dll")
BOOL GetPS2ColorRenderingDictionary(ptrdiff_t hProfile, uint dwIntent, 
                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* pPS2ColorRenderingDictionary, 
                                    uint* pcbPS2ColorRenderingDictionary, BOOL* pbBinary);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-getnamedprofileinfo
@DllImport("mscms.dll")
BOOL GetNamedProfileInfo(ptrdiff_t hProfile, NAMED_PROFILE_INFO* pNamedProfileInfo);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-convertcolornametoindex
@DllImport("mscms.dll")
BOOL ConvertColorNameToIndex(ptrdiff_t hProfile, byte** paColorName, uint* paIndex, uint dwCount);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-convertindextocolorname
@DllImport("mscms.dll")
BOOL ConvertIndexToColorName(ptrdiff_t hProfile, uint* paIndex, byte** paColorName, uint dwCount);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-createdevicelinkprofile
@DllImport("mscms.dll")
BOOL CreateDeviceLinkProfile(ptrdiff_t* hProfile, uint nProfiles, uint* padwIntent, uint nIntents, uint dwFlags, 
                             ubyte** pProfileData, uint indexPreferredCMM);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("mscms.dll")
ptrdiff_t CreateColorTransformA(LOGCOLORSPACEA* pLogColorSpace, ptrdiff_t hDestProfile, ptrdiff_t hTargetProfile, 
                                uint dwFlags);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("mscms.dll")
ptrdiff_t CreateColorTransformW(LOGCOLORSPACEW* pLogColorSpace, ptrdiff_t hDestProfile, ptrdiff_t hTargetProfile, 
                                uint dwFlags);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-createmultiprofiletransform
@DllImport("mscms.dll")
ptrdiff_t CreateMultiProfileTransform(ptrdiff_t* pahProfiles, uint nProfiles, uint* padwIntent, uint nIntents, 
                                      uint dwFlags, uint indexPreferredCMM);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-deletecolortransform
@DllImport("mscms.dll")
BOOL DeleteColorTransform(ptrdiff_t hxform);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-translatebitmapbits
@DllImport("mscms.dll")
BOOL TranslateBitmapBits(ptrdiff_t hColorTransform, void* pSrcBits, BMFORMAT bmInput, uint dwWidth, uint dwHeight, 
                         uint dwInputStride, void* pDestBits, BMFORMAT bmOutput, uint dwOutputStride, 
                         LPBMCALLBACKFN pfnCallBack, LPARAM ulCallbackData);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-checkbitmapbits
@DllImport("mscms.dll")
BOOL CheckBitmapBits(ptrdiff_t hColorTransform, void* pSrcBits, BMFORMAT bmInput, uint dwWidth, uint dwHeight, 
                     uint dwStride, ubyte* paResult, LPBMCALLBACKFN pfnCallback, LPARAM lpCallbackData);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-translatecolors
@DllImport("mscms.dll")
BOOL TranslateColors(ptrdiff_t hColorTransform, COLOR* paInputColors, uint nColors, COLORTYPE ctInput, 
                     COLOR* paOutputColors, COLORTYPE ctOutput);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-checkcolors
@DllImport("mscms.dll")
BOOL CheckColors(ptrdiff_t hColorTransform, COLOR* paInputColors, uint nColors, COLORTYPE ctInput, ubyte* paResult);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-getcmminfo
@DllImport("mscms.dll")
uint GetCMMInfo(ptrdiff_t hColorTransform, uint param1);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("mscms.dll")
BOOL RegisterCMMA(const(PSTR) pMachineName, uint cmmID, const(PSTR) pCMMdll);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("mscms.dll")
BOOL RegisterCMMW(const(PWSTR) pMachineName, uint cmmID, const(PWSTR) pCMMdll);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("mscms.dll")
BOOL UnregisterCMMA(const(PSTR) pMachineName, uint cmmID);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("mscms.dll")
BOOL UnregisterCMMW(const(PWSTR) pMachineName, uint cmmID);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-selectcmm
@DllImport("mscms.dll")
BOOL SelectCMM(uint dwCMMType);

//METH ATTR: ObsoleteAttribute : CustomAttributeSig([FixedArgSig(ElementSig(GetColorDirectoryW is deprecated and might not work on all platforms. For more info, see MSDN.))], [])
@DllImport("mscms.dll")
BOOL GetColorDirectoryA(const(PSTR) pMachineName, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/PSTR pBuffer, 
                        uint* pdwSize);

//METH ATTR: ObsoleteAttribute : CustomAttributeSig([FixedArgSig(ElementSig(GetColorDirectoryA is deprecated and might not work on all platforms. For more info, see MSDN.))], [])
@DllImport("mscms.dll")
BOOL GetColorDirectoryW(const(PWSTR) pMachineName, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/PWSTR pBuffer, 
                        uint* pdwSize);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("mscms.dll")
BOOL InstallColorProfileA(const(PSTR) pMachineName, const(PSTR) pProfileName);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("mscms.dll")
BOOL InstallColorProfileW(const(PWSTR) pMachineName, const(PWSTR) pProfileName);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("mscms.dll")
BOOL UninstallColorProfileA(const(PSTR) pMachineName, const(PSTR) pProfileName, BOOL bDelete);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("mscms.dll")
BOOL UninstallColorProfileW(const(PWSTR) pMachineName, const(PWSTR) pProfileName, BOOL bDelete);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("mscms.dll")
BOOL EnumColorProfilesA(const(PSTR) pMachineName, ENUMTYPEA* pEnumRecord, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* pEnumerationBuffer, 
                        uint* pdwSizeOfEnumerationBuffer, uint* pnProfiles);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("mscms.dll")
BOOL EnumColorProfilesW(const(PWSTR) pMachineName, ENUMTYPEW* pEnumRecord, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* pEnumerationBuffer, 
                        uint* pdwSizeOfEnumerationBuffer, uint* pnProfiles);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("mscms.dll")
BOOL SetStandardColorSpaceProfileA(const(PSTR) pMachineName, uint dwProfileID, const(PSTR) pProfilename);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("mscms.dll")
BOOL SetStandardColorSpaceProfileW(const(PWSTR) pMachineName, uint dwProfileID, const(PWSTR) pProfileName);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("mscms.dll")
BOOL GetStandardColorSpaceProfileA(const(PSTR) pMachineName, uint dwSCS, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/PSTR pBuffer, 
                                   uint* pcbSize);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("mscms.dll")
BOOL GetStandardColorSpaceProfileW(const(PWSTR) pMachineName, uint dwSCS, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/PWSTR pBuffer, 
                                   uint* pcbSize);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("mscms.dll")
BOOL AssociateColorProfileWithDeviceA(const(PSTR) pMachineName, const(PSTR) pProfileName, const(PSTR) pDeviceName);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("mscms.dll")
BOOL AssociateColorProfileWithDeviceW(const(PWSTR) pMachineName, const(PWSTR) pProfileName, 
                                      const(PWSTR) pDeviceName);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("mscms.dll")
BOOL DisassociateColorProfileFromDeviceA(const(PSTR) pMachineName, const(PSTR) pProfileName, 
                                         const(PSTR) pDeviceName);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("mscms.dll")
BOOL DisassociateColorProfileFromDeviceW(const(PWSTR) pMachineName, const(PWSTR) pProfileName, 
                                         const(PWSTR) pDeviceName);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("ICMUI.dll")
BOOL SetupColorMatchingW(COLORMATCHSETUPW* pcms);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("ICMUI.dll")
BOOL SetupColorMatchingA(COLORMATCHSETUPA* pcms);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-wcsassociatecolorprofilewithdevice
@DllImport("mscms.dll")
BOOL WcsAssociateColorProfileWithDevice(WCS_PROFILE_MANAGEMENT_SCOPE scope_, const(PWSTR) pProfileName, 
                                        const(PWSTR) pDeviceName);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-wcsdisassociatecolorprofilefromdevice
@DllImport("mscms.dll")
BOOL WcsDisassociateColorProfileFromDevice(WCS_PROFILE_MANAGEMENT_SCOPE scope_, const(PWSTR) pProfileName, 
                                           const(PWSTR) pDeviceName);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-wcsenumcolorprofilessize
@DllImport("mscms.dll")
BOOL WcsEnumColorProfilesSize(WCS_PROFILE_MANAGEMENT_SCOPE scope_, ENUMTYPEW* pEnumRecord, uint* pdwSize);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-wcsenumcolorprofiles
@DllImport("mscms.dll")
BOOL WcsEnumColorProfiles(WCS_PROFILE_MANAGEMENT_SCOPE scope_, ENUMTYPEW* pEnumRecord, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* pBuffer, 
                          uint dwSize, uint* pnProfiles);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-wcsgetdefaultcolorprofilesize
@DllImport("mscms.dll")
BOOL WcsGetDefaultColorProfileSize(WCS_PROFILE_MANAGEMENT_SCOPE scope_, const(PWSTR) pDeviceName, 
                                   COLORPROFILETYPE cptColorProfileType, COLORPROFILESUBTYPE cpstColorProfileSubType, 
                                   uint dwProfileID, uint* pcbProfileName);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-wcsgetdefaultcolorprofile
@DllImport("mscms.dll")
BOOL WcsGetDefaultColorProfile(WCS_PROFILE_MANAGEMENT_SCOPE scope_, const(PWSTR) pDeviceName, 
                               COLORPROFILETYPE cptColorProfileType, COLORPROFILESUBTYPE cpstColorProfileSubType, 
                               uint dwProfileID, uint cbProfileName, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/PWSTR pProfileName);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-wcssetdefaultcolorprofile
@DllImport("mscms.dll")
BOOL WcsSetDefaultColorProfile(WCS_PROFILE_MANAGEMENT_SCOPE scope_, const(PWSTR) pDeviceName, 
                               COLORPROFILETYPE cptColorProfileType, COLORPROFILESUBTYPE cpstColorProfileSubType, 
                               uint dwProfileID, const(PWSTR) pProfileName);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-wcssetdefaultrenderingintent
@DllImport("mscms.dll")
BOOL WcsSetDefaultRenderingIntent(WCS_PROFILE_MANAGEMENT_SCOPE scope_, uint dwRenderingIntent);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-wcsgetdefaultrenderingintent
@DllImport("mscms.dll")
BOOL WcsGetDefaultRenderingIntent(WCS_PROFILE_MANAGEMENT_SCOPE scope_, uint* pdwRenderingIntent);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-wcsgetuseperuserprofiles
@DllImport("mscms.dll")
BOOL WcsGetUsePerUserProfiles(const(PWSTR) pDeviceName, uint dwDeviceClass, BOOL* pUsePerUserProfiles);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-wcssetuseperuserprofiles
@DllImport("mscms.dll")
BOOL WcsSetUsePerUserProfiles(const(PWSTR) pDeviceName, uint dwDeviceClass, BOOL usePerUserProfiles);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-wcstranslatecolors
@DllImport("mscms.dll")
BOOL WcsTranslateColors(ptrdiff_t hColorTransform, uint nColors, uint nInputChannels, COLORDATATYPE cdtInput, 
                        uint cbInput, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* pInputData, 
                        uint nOutputChannels, COLORDATATYPE cdtOutput, uint cbOutput, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(8)))])*/void* pOutputData);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-wcscheckcolors
@DllImport("mscms.dll")
BOOL WcsCheckColors(ptrdiff_t hColorTransform, uint nColors, uint nInputChannels, COLORDATATYPE cdtInput, 
                    uint cbInput, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* pInputData, 
                    ubyte* paResult);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-cmcheckcolors
@DllImport("ICM32.dll")
BOOL CMCheckColors(ptrdiff_t hcmTransform, COLOR* lpaInputColors, uint nColors, COLORTYPE ctInput, 
                   ubyte* lpaResult);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-cmcheckrgbs
@DllImport("ICM32.dll")
BOOL CMCheckRGBs(ptrdiff_t hcmTransform, void* lpSrcBits, BMFORMAT bmInput, uint dwWidth, uint dwHeight, 
                 uint dwStride, ubyte* lpaResult, LPBMCALLBACKFN pfnCallback, LPARAM ulCallbackData);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-cmconvertcolornametoindex
@DllImport("ICM32.dll")
BOOL CMConvertColorNameToIndex(ptrdiff_t hProfile, byte** paColorName, uint* paIndex, uint dwCount);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-cmconvertindextocolorname
@DllImport("ICM32.dll")
BOOL CMConvertIndexToColorName(ptrdiff_t hProfile, uint* paIndex, byte** paColorName, uint dwCount);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-cmcreatedevicelinkprofile
@DllImport("ICM32.dll")
BOOL CMCreateDeviceLinkProfile(ptrdiff_t* pahProfiles, uint nProfiles, uint* padwIntents, uint nIntents, 
                               uint dwFlags, ubyte** lpProfileData);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-cmcreatemultiprofiletransform
@DllImport("ICM32.dll")
ptrdiff_t CMCreateMultiProfileTransform(ptrdiff_t* pahProfiles, uint nProfiles, uint* padwIntents, uint nIntents, 
                                        uint dwFlags);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("ICM32.dll")
BOOL CMCreateProfileW(LOGCOLORSPACEW* lpColorSpace, void** lpProfileData);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("ICM32.dll")
ptrdiff_t CMCreateTransform(LOGCOLORSPACEA* lpColorSpace, void* lpDevCharacter, void* lpTargetDevCharacter);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("ICM32.dll")
ptrdiff_t CMCreateTransformW(LOGCOLORSPACEW* lpColorSpace, void* lpDevCharacter, void* lpTargetDevCharacter);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("ICM32.dll")
ptrdiff_t CMCreateTransformExt(LOGCOLORSPACEA* lpColorSpace, void* lpDevCharacter, void* lpTargetDevCharacter, 
                               uint dwFlags);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-cmcheckcolorsingamut
@DllImport("ICM32.dll")
BOOL CMCheckColorsInGamut(ptrdiff_t hcmTransform, RGBTRIPLE* lpaRGBTriple, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* lpaResult, 
                          uint nCount);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("ICM32.dll")
BOOL CMCreateProfile(LOGCOLORSPACEA* lpColorSpace, void** lpProfileData);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-cmtranslatergb
@DllImport("ICM32.dll")
BOOL CMTranslateRGB(ptrdiff_t hcmTransform, COLORREF ColorRef, uint* lpColorRef, uint dwFlags);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-cmtranslatergbs
@DllImport("ICM32.dll")
BOOL CMTranslateRGBs(ptrdiff_t hcmTransform, void* lpSrcBits, BMFORMAT bmInput, uint dwWidth, uint dwHeight, 
                     uint dwStride, void* lpDestBits, BMFORMAT bmOutput, uint dwTranslateDirection);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("ICM32.dll")
ptrdiff_t CMCreateTransformExtW(LOGCOLORSPACEW* lpColorSpace, void* lpDevCharacter, void* lpTargetDevCharacter, 
                                uint dwFlags);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-cmdeletetransform
@DllImport("ICM32.dll")
BOOL CMDeleteTransform(ptrdiff_t hcmTransform);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-cmgetinfo
@DllImport("ICM32.dll")
uint CMGetInfo(uint dwInfo);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-cmgetnamedprofileinfo
@DllImport("ICM32.dll")
BOOL CMGetNamedProfileInfo(ptrdiff_t hProfile, NAMED_PROFILE_INFO* pNamedProfileInfo);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-cmisprofilevalid
@DllImport("ICM32.dll")
BOOL CMIsProfileValid(ptrdiff_t hProfile, BOOL* lpbValid);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-cmtranslatecolors
@DllImport("ICM32.dll")
BOOL CMTranslateColors(ptrdiff_t hcmTransform, COLOR* lpaInputColors, uint nColors, COLORTYPE ctInput, 
                       COLOR* lpaOutputColors, COLORTYPE ctOutput);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-cmtranslatergbsext
@DllImport("ICM32.dll")
BOOL CMTranslateRGBsExt(ptrdiff_t hcmTransform, void* lpSrcBits, BMFORMAT bmInput, uint dwWidth, uint dwHeight, 
                        uint dwInputStride, void* lpDestBits, BMFORMAT bmOutput, uint dwOutputStride, 
                        LPBMCALLBACKFN lpfnCallback, LPARAM ulCallbackData);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("mscms.dll")
ptrdiff_t WcsOpenColorProfileA(PROFILE* pCDMPProfile, PROFILE* pCAMPProfile, PROFILE* pGMMPProfile, 
                               uint dwDesireAccess, uint dwShareMode, uint dwCreationMode, uint dwFlags);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("mscms.dll")
ptrdiff_t WcsOpenColorProfileW(PROFILE* pCDMPProfile, PROFILE* pCAMPProfile, PROFILE* pGMMPProfile, 
                               uint dwDesireAccess, uint dwShareMode, uint dwCreationMode, uint dwFlags);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-wcscreateiccprofile
@DllImport("mscms.dll")
ptrdiff_t WcsCreateIccProfile(ptrdiff_t hWcsProfile, uint dwOptions);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-wcsgetcalibrationmanagementstate
@DllImport("mscms.dll")
BOOL WcsGetCalibrationManagementState(BOOL* pbIsEnabled);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-wcssetcalibrationmanagementstate
@DllImport("mscms.dll")
BOOL WcsSetCalibrationManagementState(BOOL bIsEnabled);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-colorprofileadddisplayassociation
@DllImport("mscms.dll")
HRESULT ColorProfileAddDisplayAssociation(WCS_PROFILE_MANAGEMENT_SCOPE scope_, const(PWSTR) profileName, 
                                          LUID targetAdapterID, uint sourceID, BOOL setAsDefault, 
                                          BOOL associateAsAdvancedColor);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-colorprofileremovedisplayassociation
@DllImport("mscms.dll")
HRESULT ColorProfileRemoveDisplayAssociation(WCS_PROFILE_MANAGEMENT_SCOPE scope_, const(PWSTR) profileName, 
                                             LUID targetAdapterID, uint sourceID, BOOL dissociateAdvancedColor);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-colorprofilesetdisplaydefaultassociation
@DllImport("mscms.dll")
HRESULT ColorProfileSetDisplayDefaultAssociation(WCS_PROFILE_MANAGEMENT_SCOPE scope_, const(PWSTR) profileName, 
                                                 COLORPROFILETYPE profileType, COLORPROFILESUBTYPE profileSubType, 
                                                 LUID targetAdapterID, uint sourceID);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-colorprofilegetdisplaylist
@DllImport("mscms.dll")
HRESULT ColorProfileGetDisplayList(WCS_PROFILE_MANAGEMENT_SCOPE scope_, LUID targetAdapterID, uint sourceID, 
                                   PWSTR** profileList, uint* profileCount);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-colorprofilegetdisplaydefault
@DllImport("mscms.dll")
HRESULT ColorProfileGetDisplayDefault(WCS_PROFILE_MANAGEMENT_SCOPE scope_, LUID targetAdapterID, uint sourceID, 
                                      COLORPROFILETYPE profileType, COLORPROFILESUBTYPE profileSubType, 
                                      PWSTR* profileName);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icm/nf-icm-colorprofilegetdisplayuserscope
@DllImport("mscms.dll")
HRESULT ColorProfileGetDisplayUserScope(LUID targetAdapterID, uint sourceID, WCS_PROFILE_MANAGEMENT_SCOPE* scope_);

@DllImport("mscms.dll")
HRESULT ColorProfileGetDeviceCapabilities(WCS_PROFILE_MANAGEMENT_SCOPE scope_, LUID targetAdapterID, uint sourceID, 
                                          WCS_DEVICE_CAPABILITIES_TYPE capsType, void* outputCapabilities);


// Interfaces

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wcsplugin/nn-wcsplugin-idevicemodelplugin
@GUID("1cd63475-07c4-46fe-a903-d655316d11fd")
interface IDeviceModelPlugIn : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wcsplugin/nf-wcsplugin-idevicemodelplugin-initialize
    HRESULT Initialize(BSTR bstrXml, uint cNumModels, uint iModelPosition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wcsplugin/nf-wcsplugin-idevicemodelplugin-getnumchannels
    HRESULT GetNumChannels(uint* pNumChannels);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wcsplugin/nf-wcsplugin-idevicemodelplugin-devicetocolorimetriccolors
    HRESULT DeviceToColorimetricColors(uint cColors, uint cChannels, const(float)* pDeviceValues, 
                                       XYZColorF* pXYZColors);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wcsplugin/nf-wcsplugin-idevicemodelplugin-colorimetrictodevicecolors
    HRESULT ColorimetricToDeviceColors(uint cColors, uint cChannels, const(XYZColorF)* pXYZColors, 
                                       float* pDeviceValues);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wcsplugin/nf-wcsplugin-idevicemodelplugin-colorimetrictodevicecolorswithblack
    HRESULT ColorimetricToDeviceColorsWithBlack(uint cColors, uint cChannels, const(XYZColorF)* pXYZColors, 
                                                const(BlackInformation)* pBlackInformation, float* pDeviceValues);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wcsplugin/nf-wcsplugin-idevicemodelplugin-settransformdevicemodelinfo
    HRESULT SetTransformDeviceModelInfo(uint iModelPosition, IDeviceModelPlugIn pIDeviceModelOther);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wcsplugin/nf-wcsplugin-idevicemodelplugin-getprimarysamples
    HRESULT GetPrimarySamples(PrimaryXYZColors* pPrimaryColor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wcsplugin/nf-wcsplugin-idevicemodelplugin-getgamutboundarymeshsize
    HRESULT GetGamutBoundaryMeshSize(uint* pNumVertices, uint* pNumTriangles);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wcsplugin/nf-wcsplugin-idevicemodelplugin-getgamutboundarymesh
    HRESULT GetGamutBoundaryMesh(uint cChannels, uint cVertices, uint cTriangles, float* pVertices, 
                                 GamutShellTriangle* pTriangles);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wcsplugin/nf-wcsplugin-idevicemodelplugin-getneutralaxissize
    HRESULT GetNeutralAxisSize(uint* pcColors);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wcsplugin/nf-wcsplugin-idevicemodelplugin-getneutralaxis
    HRESULT GetNeutralAxis(uint cColors, XYZColorF* pXYZColors);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wcsplugin/nn-wcsplugin-igamutmapmodelplugin
@GUID("2dd80115-ad1e-41f6-a219-a4f4b583d1f9")
interface IGamutMapModelPlugIn : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wcsplugin/nf-wcsplugin-igamutmapmodelplugin-initialize
    HRESULT Initialize(BSTR bstrXml, IDeviceModelPlugIn pSrcPlugIn, IDeviceModelPlugIn pDestPlugIn, 
                       GamutBoundaryDescription* pSrcGBD, GamutBoundaryDescription* pDestGBD);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wcsplugin/nf-wcsplugin-igamutmapmodelplugin-sourcetodestinationappearancecolors
    HRESULT SourceToDestinationAppearanceColors(uint cColors, const(JChColorF)* pInputColors, 
                                                JChColorF* pOutputColors);
}


// GUIDs


const GUID IID_IDeviceModelPlugIn   = GUIDOF!IDeviceModelPlugIn;
const GUID IID_IGamutMapModelPlugIn = GUIDOF!IGamutMapModelPlugIn;
