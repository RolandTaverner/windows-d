// Written in the D programming language.

module windows.win32.storage.xps.xps;

public import windows.core;
public import windows.win32.foundation.foundation : BOOL, HRESULT, HWND, POINT, PSTR, PWSTR,
                                                    SYSTEMTIME;
public import windows.win32.graphics.gdi : DEVMODEA, DEVMODEW, HDC;
public import windows.win32.security.cryptography.cryptography : CERT_CONTEXT;
public import windows.win32.security.security : SECURITY_ATTRIBUTES;
public import windows.win32.storage.packaging.opc : IOpcCertificateEnumerator, IOpcCertificateSet,
                                                    IOpcPartUri, IOpcSignatureCustomObjectEnumerator,
                                                    IOpcSignatureCustomObjectSet,
                                                    IOpcSignatureReferenceEnumerator,
                                                    IOpcSignatureReferenceSet,
                                                    OPC_SIGNATURE_TIME_FORMAT;
public import windows.win32.system.com.com : ISequentialStream, IStream, IUnknown, IUri;

extern(Windows) @nogc nothrow:


// Enums


alias PRINT_WINDOW_FLAGS = uint;
enum : uint
{
    PW_CLIENTONLY = 0x00000001U,
}

alias PRINTER_DEVICE_CAPABILITIES = ushort;
enum : ushort
{
    DC_BINNAMES         = cast(ushort) 0x000c,
    DC_BINS             = cast(ushort) 0x0006,
    DC_COLLATE          = cast(ushort) 0x0016,
    DC_COLORDEVICE      = cast(ushort) 0x0020,
    DC_COPIES           = cast(ushort) 0x0012,
    DC_DRIVER           = cast(ushort) 0x000b,
    DC_DUPLEX           = cast(ushort) 0x0007,
    DC_ENUMRESOLUTIONS  = cast(ushort) 0x000d,
    DC_EXTRA            = cast(ushort) 0x0009,
    DC_FIELDS           = cast(ushort) 0x0001,
    DC_FILEDEPENDENCIES = cast(ushort) 0x000e,
    DC_MAXEXTENT        = cast(ushort) 0x0005,
    DC_MEDIAREADY       = cast(ushort) 0x001d,
    DC_MEDIATYPENAMES   = cast(ushort) 0x0022,
    DC_MEDIATYPES       = cast(ushort) 0x0023,
    DC_MINEXTENT        = cast(ushort) 0x0004,
    DC_ORIENTATION      = cast(ushort) 0x0011,
    DC_NUP              = cast(ushort) 0x0021,
    DC_PAPERNAMES       = cast(ushort) 0x0010,
    DC_PAPERS           = cast(ushort) 0x0002,
    DC_PAPERSIZE        = cast(ushort) 0x0003,
    DC_PERSONALITY      = cast(ushort) 0x0019,
    DC_PRINTERMEM       = cast(ushort) 0x001c,
    DC_PRINTRATE        = cast(ushort) 0x001a,
    DC_PRINTRATEPPM     = cast(ushort) 0x001f,
    DC_PRINTRATEUNIT    = cast(ushort) 0x001b,
    DC_SIZE             = cast(ushort) 0x0008,
    DC_STAPLE           = cast(ushort) 0x001e,
    DC_TRUETYPE         = cast(ushort) 0x000f,
    DC_VERSION          = cast(ushort) 0x000a,
}

alias PSINJECT_POINT = ushort;
enum : ushort
{
    PSINJECT_BEGINSTREAM                = cast(ushort) 0x0001,
    PSINJECT_PSADOBE                    = cast(ushort) 0x0002,
    PSINJECT_PAGESATEND                 = cast(ushort) 0x0003,
    PSINJECT_PAGES                      = cast(ushort) 0x0004,
    PSINJECT_DOCNEEDEDRES               = cast(ushort) 0x0005,
    PSINJECT_DOCSUPPLIEDRES             = cast(ushort) 0x0006,
    PSINJECT_PAGEORDER                  = cast(ushort) 0x0007,
    PSINJECT_ORIENTATION                = cast(ushort) 0x0008,
    PSINJECT_BOUNDINGBOX                = cast(ushort) 0x0009,
    PSINJECT_DOCUMENTPROCESSCOLORS      = cast(ushort) 0x000a,
    PSINJECT_COMMENTS                   = cast(ushort) 0x000b,
    PSINJECT_BEGINDEFAULTS              = cast(ushort) 0x000c,
    PSINJECT_ENDDEFAULTS                = cast(ushort) 0x000d,
    PSINJECT_BEGINPROLOG                = cast(ushort) 0x000e,
    PSINJECT_ENDPROLOG                  = cast(ushort) 0x000f,
    PSINJECT_BEGINSETUP                 = cast(ushort) 0x0010,
    PSINJECT_ENDSETUP                   = cast(ushort) 0x0011,
    PSINJECT_TRAILER                    = cast(ushort) 0x0012,
    PSINJECT_EOF                        = cast(ushort) 0x0013,
    PSINJECT_ENDSTREAM                  = cast(ushort) 0x0014,
    PSINJECT_DOCUMENTPROCESSCOLORSATEND = cast(ushort) 0x0015,
    PSINJECT_PAGENUMBER                 = cast(ushort) 0x0064,
    PSINJECT_BEGINPAGESETUP             = cast(ushort) 0x0065,
    PSINJECT_ENDPAGESETUP               = cast(ushort) 0x0066,
    PSINJECT_PAGETRAILER                = cast(ushort) 0x0067,
    PSINJECT_PLATECOLOR                 = cast(ushort) 0x0068,
    PSINJECT_SHOWPAGE                   = cast(ushort) 0x0069,
    PSINJECT_PAGEBBOX                   = cast(ushort) 0x006a,
    PSINJECT_ENDPAGECOMMENTS            = cast(ushort) 0x006b,
    PSINJECT_VMSAVE                     = cast(ushort) 0x00c8,
    PSINJECT_VMRESTORE                  = cast(ushort) 0x00c9,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/ne-xpsobjectmodel-xps_tile_mode
alias XPS_TILE_MODE = int;
enum : int
{
    XPS_TILE_MODE_NONE   = 0x00000001,
    XPS_TILE_MODE_TILE   = 0x00000002,
    XPS_TILE_MODE_FLIPX  = 0x00000003,
    XPS_TILE_MODE_FLIPY  = 0x00000004,
    XPS_TILE_MODE_FLIPXY = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/ne-xpsobjectmodel-xps_color_interpolation
alias XPS_COLOR_INTERPOLATION = int;
enum : int
{
    XPS_COLOR_INTERPOLATION_SCRGBLINEAR = 0x00000001,
    XPS_COLOR_INTERPOLATION_SRGBLINEAR  = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/ne-xpsobjectmodel-xps_spread_method
alias XPS_SPREAD_METHOD = int;
enum : int
{
    XPS_SPREAD_METHOD_PAD     = 0x00000001,
    XPS_SPREAD_METHOD_REFLECT = 0x00000002,
    XPS_SPREAD_METHOD_REPEAT  = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/ne-xpsobjectmodel-xps_style_simulation
alias XPS_STYLE_SIMULATION = int;
enum : int
{
    XPS_STYLE_SIMULATION_NONE       = 0x00000001,
    XPS_STYLE_SIMULATION_ITALIC     = 0x00000002,
    XPS_STYLE_SIMULATION_BOLD       = 0x00000003,
    XPS_STYLE_SIMULATION_BOLDITALIC = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/ne-xpsobjectmodel-xps_line_cap
alias XPS_LINE_CAP = int;
enum : int
{
    XPS_LINE_CAP_FLAT     = 0x00000001,
    XPS_LINE_CAP_ROUND    = 0x00000002,
    XPS_LINE_CAP_SQUARE   = 0x00000003,
    XPS_LINE_CAP_TRIANGLE = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/ne-xpsobjectmodel-xps_dash_cap
alias XPS_DASH_CAP = int;
enum : int
{
    XPS_DASH_CAP_FLAT     = 0x00000001,
    XPS_DASH_CAP_ROUND    = 0x00000002,
    XPS_DASH_CAP_SQUARE   = 0x00000003,
    XPS_DASH_CAP_TRIANGLE = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/ne-xpsobjectmodel-xps_line_join
alias XPS_LINE_JOIN = int;
enum : int
{
    XPS_LINE_JOIN_MITER = 0x00000001,
    XPS_LINE_JOIN_BEVEL = 0x00000002,
    XPS_LINE_JOIN_ROUND = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/ne-xpsobjectmodel-xps_image_type
alias XPS_IMAGE_TYPE = int;
enum : int
{
    XPS_IMAGE_TYPE_JPEG = 0x00000001,
    XPS_IMAGE_TYPE_PNG  = 0x00000002,
    XPS_IMAGE_TYPE_TIFF = 0x00000003,
    XPS_IMAGE_TYPE_WDP  = 0x00000004,
    XPS_IMAGE_TYPE_JXR  = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/ne-xpsobjectmodel-xps_color_type
alias XPS_COLOR_TYPE = int;
enum : int
{
    XPS_COLOR_TYPE_SRGB    = 0x00000001,
    XPS_COLOR_TYPE_SCRGB   = 0x00000002,
    XPS_COLOR_TYPE_CONTEXT = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/ne-xpsobjectmodel-xps_fill_rule
alias XPS_FILL_RULE = int;
enum : int
{
    XPS_FILL_RULE_EVENODD = 0x00000001,
    XPS_FILL_RULE_NONZERO = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/ne-xpsobjectmodel-xps_segment_type
alias XPS_SEGMENT_TYPE = int;
enum : int
{
    XPS_SEGMENT_TYPE_ARC_LARGE_CLOCKWISE        = 0x00000001,
    XPS_SEGMENT_TYPE_ARC_LARGE_COUNTERCLOCKWISE = 0x00000002,
    XPS_SEGMENT_TYPE_ARC_SMALL_CLOCKWISE        = 0x00000003,
    XPS_SEGMENT_TYPE_ARC_SMALL_COUNTERCLOCKWISE = 0x00000004,
    XPS_SEGMENT_TYPE_BEZIER                     = 0x00000005,
    XPS_SEGMENT_TYPE_LINE                       = 0x00000006,
    XPS_SEGMENT_TYPE_QUADRATIC_BEZIER           = 0x00000007,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/ne-xpsobjectmodel-xps_segment_stroke_pattern
alias XPS_SEGMENT_STROKE_PATTERN = int;
enum : int
{
    XPS_SEGMENT_STROKE_PATTERN_ALL   = 0x00000001,
    XPS_SEGMENT_STROKE_PATTERN_NONE  = 0x00000002,
    XPS_SEGMENT_STROKE_PATTERN_MIXED = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/ne-xpsobjectmodel-xps_font_embedding
alias XPS_FONT_EMBEDDING = int;
enum : int
{
    XPS_FONT_EMBEDDING_NORMAL                  = 0x00000001,
    XPS_FONT_EMBEDDING_OBFUSCATED              = 0x00000002,
    XPS_FONT_EMBEDDING_RESTRICTED              = 0x00000003,
    XPS_FONT_EMBEDDING_RESTRICTED_UNOBFUSCATED = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/ne-xpsobjectmodel-xps_object_type
alias XPS_OBJECT_TYPE = int;
enum : int
{
    XPS_OBJECT_TYPE_CANVAS                = 0x00000001,
    XPS_OBJECT_TYPE_GLYPHS                = 0x00000002,
    XPS_OBJECT_TYPE_PATH                  = 0x00000003,
    XPS_OBJECT_TYPE_MATRIX_TRANSFORM      = 0x00000004,
    XPS_OBJECT_TYPE_GEOMETRY              = 0x00000005,
    XPS_OBJECT_TYPE_SOLID_COLOR_BRUSH     = 0x00000006,
    XPS_OBJECT_TYPE_IMAGE_BRUSH           = 0x00000007,
    XPS_OBJECT_TYPE_LINEAR_GRADIENT_BRUSH = 0x00000008,
    XPS_OBJECT_TYPE_RADIAL_GRADIENT_BRUSH = 0x00000009,
    XPS_OBJECT_TYPE_VISUAL_BRUSH          = 0x0000000a,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/ne-xpsobjectmodel-xps_thumbnail_size
alias XPS_THUMBNAIL_SIZE = int;
enum : int
{
    XPS_THUMBNAIL_SIZE_VERYSMALL = 0x00000001,
    XPS_THUMBNAIL_SIZE_SMALL     = 0x00000002,
    XPS_THUMBNAIL_SIZE_MEDIUM    = 0x00000003,
    XPS_THUMBNAIL_SIZE_LARGE     = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/ne-xpsobjectmodel-xps_interleaving
alias XPS_INTERLEAVING = int;
enum : int
{
    XPS_INTERLEAVING_OFF = 0x00000001,
    XPS_INTERLEAVING_ON  = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel_1/ne-xpsobjectmodel_1-xps_document_type
alias XPS_DOCUMENT_TYPE = int;
enum : int
{
    XPS_DOCUMENT_TYPE_UNSPECIFIED = 0x00000001,
    XPS_DOCUMENT_TYPE_XPS         = 0x00000002,
    XPS_DOCUMENT_TYPE_OPENXPS     = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/ne-xpsdigitalsignature-xps_signature_status
alias XPS_SIGNATURE_STATUS = int;
enum : int
{
    XPS_SIGNATURE_STATUS_INCOMPLIANT  = 0x00000001,
    XPS_SIGNATURE_STATUS_INCOMPLETE   = 0x00000002,
    XPS_SIGNATURE_STATUS_BROKEN       = 0x00000003,
    XPS_SIGNATURE_STATUS_QUESTIONABLE = 0x00000004,
    XPS_SIGNATURE_STATUS_VALID        = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/ne-xpsdigitalsignature-xps_sign_policy
alias XPS_SIGN_POLICY = int;
enum : int
{
    XPS_SIGN_POLICY_NONE                    = 0x00000000,
    XPS_SIGN_POLICY_CORE_PROPERTIES         = 0x00000001,
    XPS_SIGN_POLICY_SIGNATURE_RELATIONSHIPS = 0x00000002,
    XPS_SIGN_POLICY_PRINT_TICKET            = 0x00000004,
    XPS_SIGN_POLICY_DISCARD_CONTROL         = 0x00000008,
    XPS_SIGN_POLICY_ALL                     = 0x0000000f,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/ne-xpsdigitalsignature-xps_sign_flags
alias XPS_SIGN_FLAGS = int;
enum : int
{
    XPS_SIGN_FLAGS_NONE                        = 0x00000000,
    XPS_SIGN_FLAGS_IGNORE_MARKUP_COMPATIBILITY = 0x00000001,
}

// Constants


enum HRESULT XPS_E_SIGREQUESTID_DUP = HRESULT(0x80520385);

enum : HRESULT
{
    XPS_E_PACKAGE_NOT_OPENED     = HRESULT(0x80520386),
    XPS_E_PACKAGE_ALREADY_OPENED = HRESULT(0x80520387),
}

enum HRESULT XPS_E_SIGNATUREID_DUP = HRESULT(0x80520388);
enum HRESULT XPS_E_MARKUP_COMPATIBILITY_ELEMENTS = HRESULT(0x80520389);
enum HRESULT XPS_E_OBJECT_DETACHED = HRESULT(0x8052038a);
enum HRESULT XPS_E_INVALID_SIGNATUREBLOCK_MARKUP = HRESULT(0x8052038b);
enum HRESULT XPS_E_INVALID_NUMBER_OF_POINTS_IN_CURVE_SEGMENTS = HRESULT(0x80520600);
enum HRESULT XPS_E_ABSOLUTE_REFERENCE = HRESULT(0x80520601);
enum HRESULT XPS_E_INVALID_NUMBER_OF_COLOR_CHANNELS = HRESULT(0x80520602);

enum : HRESULT
{
    XPS_E_INVALID_LANGUAGE             = HRESULT(0x80520000),
    XPS_E_INVALID_NAME                 = HRESULT(0x80520001),
    XPS_E_INVALID_RESOURCE_KEY         = HRESULT(0x80520002),
    XPS_E_INVALID_PAGE_SIZE            = HRESULT(0x80520003),
    XPS_E_INVALID_BLEED_BOX            = HRESULT(0x80520004),
    XPS_E_INVALID_THUMBNAIL_IMAGE_TYPE = HRESULT(0x80520005),
    XPS_E_INVALID_LOOKUP_TYPE          = HRESULT(0x80520006),
    XPS_E_INVALID_FLOAT                = HRESULT(0x80520007),
}

enum HRESULT XPS_E_UNEXPECTED_CONTENT_TYPE = HRESULT(0x80520008);

enum : HRESULT
{
    XPS_E_INVALID_FONT_URI            = HRESULT(0x8052000a),
    XPS_E_INVALID_CONTENT_BOX         = HRESULT(0x8052000b),
    XPS_E_INVALID_MARKUP              = HRESULT(0x8052000c),
    XPS_E_INVALID_XML_ENCODING        = HRESULT(0x8052000d),
    XPS_E_INVALID_CONTENT_TYPE        = HRESULT(0x8052000e),
    XPS_E_INVALID_OBFUSCATED_FONT_URI = HRESULT(0x8052000f),
}

enum : HRESULT
{
    XPS_E_UNEXPECTED_RELATIONSHIP_TYPE            = HRESULT(0x80520010),
    XPS_E_UNEXPECTED_RESTRICTED_FONT_RELATIONSHIP = HRESULT(0x80520011),
}

enum : HRESULT
{
    XPS_E_MISSING_NAME                  = HRESULT(0x80520100),
    XPS_E_MISSING_LOOKUP                = HRESULT(0x80520101),
    XPS_E_MISSING_GLYPHS                = HRESULT(0x80520102),
    XPS_E_MISSING_SEGMENT_DATA          = HRESULT(0x80520103),
    XPS_E_MISSING_COLORPROFILE          = HRESULT(0x80520104),
    XPS_E_MISSING_RELATIONSHIP_TARGET   = HRESULT(0x80520105),
    XPS_E_MISSING_RESOURCE_RELATIONSHIP = HRESULT(0x80520106),
}

enum : HRESULT
{
    XPS_E_MISSING_FONTURI                       = HRESULT(0x80520107),
    XPS_E_MISSING_DOCUMENTSEQUENCE_RELATIONSHIP = HRESULT(0x80520108),
    XPS_E_MISSING_DOCUMENT                      = HRESULT(0x80520109),
    XPS_E_MISSING_REFERRED_DOCUMENT             = HRESULT(0x8052010a),
    XPS_E_MISSING_REFERRED_PAGE                 = HRESULT(0x8052010b),
    XPS_E_MISSING_PAGE_IN_DOCUMENT              = HRESULT(0x8052010c),
    XPS_E_MISSING_PAGE_IN_PAGEREFERENCE         = HRESULT(0x8052010d),
}

enum : HRESULT
{
    XPS_E_MISSING_IMAGE_IN_IMAGEBRUSH          = HRESULT(0x8052010e),
    XPS_E_MISSING_RESOURCE_KEY                 = HRESULT(0x8052010f),
    XPS_E_MISSING_PART_REFERENCE               = HRESULT(0x80520110),
    XPS_E_MISSING_RESTRICTED_FONT_RELATIONSHIP = HRESULT(0x80520111),
}

enum : HRESULT
{
    XPS_E_MISSING_DISCARDCONTROL = HRESULT(0x80520112),
    XPS_E_MISSING_PART_STREAM    = HRESULT(0x80520113),
}

enum HRESULT XPS_E_UNAVAILABLE_PACKAGE = HRESULT(0x80520114);
enum HRESULT XPS_E_DUPLICATE_RESOURCE_KEYS = HRESULT(0x80520200);

enum : HRESULT
{
    XPS_E_MULTIPLE_RESOURCES                      = HRESULT(0x80520201),
    XPS_E_MULTIPLE_DOCUMENTSEQUENCE_RELATIONSHIPS = HRESULT(0x80520202),
}

enum : HRESULT
{
    XPS_E_MULTIPLE_THUMBNAILS_ON_PAGE               = HRESULT(0x80520203),
    XPS_E_MULTIPLE_THUMBNAILS_ON_PACKAGE            = HRESULT(0x80520204),
    XPS_E_MULTIPLE_PRINTTICKETS_ON_PAGE             = HRESULT(0x80520205),
    XPS_E_MULTIPLE_PRINTTICKETS_ON_DOCUMENT         = HRESULT(0x80520206),
    XPS_E_MULTIPLE_PRINTTICKETS_ON_DOCUMENTSEQUENCE = HRESULT(0x80520207),
}

enum HRESULT XPS_E_MULTIPLE_REFERENCES_TO_PART = HRESULT(0x80520208);
enum HRESULT XPS_E_DUPLICATE_NAMES = HRESULT(0x80520209);
enum HRESULT XPS_E_STRING_TOO_LONG = HRESULT(0x80520300);
enum HRESULT XPS_E_TOO_MANY_INDICES = HRESULT(0x80520301);

enum : HRESULT
{
    XPS_E_MAPPING_OUT_OF_ORDER    = HRESULT(0x80520302),
    XPS_E_MAPPING_OUTSIDE_STRING  = HRESULT(0x80520303),
    XPS_E_MAPPING_OUTSIDE_INDICES = HRESULT(0x80520304),
}

enum : HRESULT
{
    XPS_E_CARET_OUTSIDE_STRING = HRESULT(0x80520305),
    XPS_E_CARET_OUT_OF_ORDER   = HRESULT(0x80520306),
}

enum HRESULT XPS_E_ODD_BIDILEVEL = HRESULT(0x80520307);
enum HRESULT XPS_E_ONE_TO_ONE_MAPPING_EXPECTED = HRESULT(0x80520308);
enum HRESULT XPS_E_RESTRICTED_FONT_NOT_OBFUSCATED = HRESULT(0x80520309);
enum HRESULT XPS_E_NEGATIVE_FLOAT = HRESULT(0x8052030a);
enum HRESULT XPS_E_XKEY_ATTR_PRESENT_OUTSIDE_RES_DICT = HRESULT(0x80520400);
enum HRESULT XPS_E_DICTIONARY_ITEM_NAMED = HRESULT(0x80520401);
enum HRESULT XPS_E_NESTED_REMOTE_DICTIONARY = HRESULT(0x80520402);
enum HRESULT XPS_E_INDEX_OUT_OF_RANGE = HRESULT(0x80520500);
enum HRESULT XPS_E_VISUAL_CIRCULAR_REF = HRESULT(0x80520501);
enum HRESULT XPS_E_NO_CUSTOM_OBJECTS = HRESULT(0x80520502);
enum HRESULT XPS_E_ALREADY_OWNED = HRESULT(0x80520503);
enum HRESULT XPS_E_RESOURCE_NOT_OWNED = HRESULT(0x80520504);
enum HRESULT XPS_E_UNEXPECTED_COLORPROFILE = HRESULT(0x80520505);
enum HRESULT XPS_E_COLOR_COMPONENT_OUT_OF_RANGE = HRESULT(0x80520506);
enum HRESULT XPS_E_BOTH_PATHFIGURE_AND_ABBR_SYNTAX_PRESENT = HRESULT(0x80520507);
enum HRESULT XPS_E_BOTH_RESOURCE_AND_SOURCEATTR_PRESENT = HRESULT(0x80520508);
enum HRESULT XPS_E_BLEED_BOX_PAGE_DIMENSIONS_NOT_IN_SYNC = HRESULT(0x80520509);
enum HRESULT XPS_E_RELATIONSHIP_EXTERNAL = HRESULT(0x8052050a);
enum HRESULT XPS_E_NOT_ENOUGH_GRADIENT_STOPS = HRESULT(0x8052050b);
enum HRESULT XPS_E_PACKAGE_WRITER_NOT_CLOSED = HRESULT(0x8052050c);

// Callbacks

alias ABORTPROC = BOOL function(HDC param0, int param1);

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-drawpatrect
struct DRAWPATRECT
{
    POINT  ptPosition;
    POINT  ptSize;
    ushort wStyle;
    ushort wPattern;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-psinjectdata
struct PSINJECTDATA
{
    uint           DataBytes;
    PSINJECT_POINT InjectionPoint;
    ushort         PageNumber;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-psfeature_output
struct PSFEATURE_OUTPUT
{
    BOOL bPageIndependent;
    BOOL bSetPageDevice;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-psfeature_custpaper
struct PSFEATURE_CUSTPAPER
{
    int lOrientation;
    int lWidth;
    int lHeight;
    int lWidthOffset;
    int lHeightOffset;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-docinfoa
struct DOCINFOA
{
    int         cbSize;
    const(PSTR) lpszDocName;
    const(PSTR) lpszOutput;
    const(PSTR) lpszDatatype;
    uint        fwType;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-docinfow
struct DOCINFOW
{
    int          cbSize;
    const(PWSTR) lpszDocName;
    const(PWSTR) lpszOutput;
    const(PWSTR) lpszDatatype;
    uint         fwType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/ns-xpsobjectmodel-xps_point
struct XPS_POINT
{
    float x;
    float y;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/ns-xpsobjectmodel-xps_size
struct XPS_SIZE
{
    float width;
    float height;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/ns-xpsobjectmodel-xps_rect
struct XPS_RECT
{
    float x;
    float y;
    float width;
    float height;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/ns-xpsobjectmodel-xps_dash
struct XPS_DASH
{
    float length;
    float gap;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/ns-xpsobjectmodel-xps_glyph_index
struct XPS_GLYPH_INDEX
{
    int   index;
    float advanceWidth;
    float horizontalOffset;
    float verticalOffset;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/ns-xpsobjectmodel-xps_glyph_mapping
struct XPS_GLYPH_MAPPING
{
    uint   unicodeStringStart;
    ushort unicodeStringLength;
    uint   glyphIndicesStart;
    ushort glyphIndicesLength;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/ns-xpsobjectmodel-xps_matrix
struct XPS_MATRIX
{
    float m11;
    float m12;
    float m21;
    float m22;
    float m31;
    float m32;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/ns-xpsobjectmodel-xps_color
struct XPS_COLOR
{
    XPS_COLOR_TYPE colorType;
    union value
    {
        struct sRGB
        {
            ubyte alpha;
            ubyte red;
            ubyte green;
            ubyte blue;
        }
        struct scRGB
        {
            float alpha;
            float red;
            float green;
            float blue;
        }
        struct context
        {
            ubyte    channelCount;
            float[9] channels;
        }
    }
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("winspool.drv")
int DeviceCapabilitiesA(const(PSTR) pDevice, const(PSTR) pPort, PRINTER_DEVICE_CAPABILITIES fwCapability, 
                        PSTR pOutput, const(DEVMODEA)* pDevMode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("winspool.drv")
int DeviceCapabilitiesW(const(PWSTR) pDevice, const(PWSTR) pPort, PRINTER_DEVICE_CAPABILITIES fwCapability, 
                        PWSTR pOutput, const(DEVMODEW)* pDevMode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("GDI32.dll")
int Escape(HDC hdc, int iEscape, int cjIn, 
           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(PSTR) pvIn, 
           void* pvOut);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("GDI32.dll")
int ExtEscape(HDC hdc, int iEscape, int cjInput, 
              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(PSTR) lpInData, 
              int cjOutput, 
              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/PSTR lpOutData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("GDI32.dll")
int StartDocA(HDC hdc, const(DOCINFOA)* lpdi);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("GDI32.dll")
int StartDocW(HDC hdc, const(DOCINFOW)* lpdi);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("GDI32.dll")
int EndDoc(HDC hdc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("GDI32.dll")
int StartPage(HDC hdc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("GDI32.dll")
int EndPage(HDC hdc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("GDI32.dll")
int AbortDoc(HDC hdc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("GDI32.dll")
int SetAbortProc(HDC hdc, ABORTPROC proc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("USER32.dll")
BOOL PrintWindow(HWND hwnd, HDC hdcBlt, PRINT_WINDOW_FLAGS nFlags);


// Interfaces

@GUID("e974d26d-3d9b-4d47-88cc-3872f2dc3585")
struct XpsOMObjectFactory;

@GUID("7e4a23e2-b969-4761-be35-1a8ced58e323")
struct XpsOMThumbnailGenerator;

@GUID("b0c43320-2315-44a2-b70a-0943a140a8ee")
struct XpsSignatureManager;

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsomshareable
@GUID("7137398f-2fc1-454d-8c6a-2c3115a16ece")
interface IXpsOMShareable : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomshareable-getowner
    HRESULT GetOwner(IUnknown* owner);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomshareable-gettype
    HRESULT GetType(XPS_OBJECT_TYPE* type);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsomvisual
@GUID("bc3e7333-fb0b-4af3-a819-0b4eaad0d2fd")
interface IXpsOMVisual : IXpsOMShareable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomvisual-gettransform
    HRESULT GetTransform(IXpsOMMatrixTransform* matrixTransform);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomvisual-gettransformlocal
    HRESULT GetTransformLocal(IXpsOMMatrixTransform* matrixTransform);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomvisual-settransformlocal
    HRESULT SetTransformLocal(IXpsOMMatrixTransform matrixTransform);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomvisual-gettransformlookup
    HRESULT GetTransformLookup(PWSTR* key);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomvisual-settransformlookup
    HRESULT SetTransformLookup(const(PWSTR) key);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomvisual-getclipgeometry
    HRESULT GetClipGeometry(IXpsOMGeometry* clipGeometry);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomvisual-getclipgeometrylocal
    HRESULT GetClipGeometryLocal(IXpsOMGeometry* clipGeometry);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomvisual-setclipgeometrylocal
    HRESULT SetClipGeometryLocal(IXpsOMGeometry clipGeometry);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomvisual-getclipgeometrylookup
    HRESULT GetClipGeometryLookup(PWSTR* key);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomvisual-setclipgeometrylookup
    HRESULT SetClipGeometryLookup(const(PWSTR) key);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomvisual-getopacity
    HRESULT GetOpacity(float* opacity);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomvisual-setopacity
    HRESULT SetOpacity(float opacity);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomvisual-getopacitymaskbrush
    HRESULT GetOpacityMaskBrush(IXpsOMBrush* opacityMaskBrush);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomvisual-getopacitymaskbrushlocal
    HRESULT GetOpacityMaskBrushLocal(IXpsOMBrush* opacityMaskBrush);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomvisual-setopacitymaskbrushlocal
    HRESULT SetOpacityMaskBrushLocal(IXpsOMBrush opacityMaskBrush);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomvisual-getopacitymaskbrushlookup
    HRESULT GetOpacityMaskBrushLookup(PWSTR* key);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomvisual-setopacitymaskbrushlookup
    HRESULT SetOpacityMaskBrushLookup(const(PWSTR) key);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomvisual-getname
    HRESULT GetName(PWSTR* name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomvisual-setname
    HRESULT SetName(const(PWSTR) name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomvisual-getishyperlinktarget
    HRESULT GetIsHyperlinkTarget(BOOL* isHyperlink);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomvisual-setishyperlinktarget
    HRESULT SetIsHyperlinkTarget(BOOL isHyperlink);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomvisual-gethyperlinknavigateuri
    HRESULT GetHyperlinkNavigateUri(IUri* hyperlinkUri);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomvisual-sethyperlinknavigateuri
    HRESULT SetHyperlinkNavigateUri(IUri hyperlinkUri);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomvisual-getlanguage
    HRESULT GetLanguage(PWSTR* language);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomvisual-setlanguage
    HRESULT SetLanguage(const(PWSTR) language);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsompart
@GUID("74eb2f0b-a91e-4486-afac-0fabeca3dfc6")
interface IXpsOMPart : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompart-getpartname
    HRESULT GetPartName(IOpcPartUri* partUri);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompart-setpartname
    HRESULT SetPartName(IOpcPartUri partUri);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsomglyphseditor
@GUID("a5ab8616-5b16-4b9f-9629-89b323ed7909")
interface IXpsOMGlyphsEditor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomglyphseditor-applyedits
    HRESULT ApplyEdits();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomglyphseditor-getunicodestring
    HRESULT GetUnicodeString(PWSTR* unicodeString);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomglyphseditor-setunicodestring
    HRESULT SetUnicodeString(const(PWSTR) unicodeString);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomglyphseditor-getglyphindexcount
    HRESULT GetGlyphIndexCount(uint* indexCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomglyphseditor-getglyphindices
    HRESULT GetGlyphIndices(uint* indexCount, XPS_GLYPH_INDEX* glyphIndices);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomglyphseditor-setglyphindices
    HRESULT SetGlyphIndices(uint indexCount, const(XPS_GLYPH_INDEX)* glyphIndices);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomglyphseditor-getglyphmappingcount
    HRESULT GetGlyphMappingCount(uint* glyphMappingCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomglyphseditor-getglyphmappings
    HRESULT GetGlyphMappings(uint* glyphMappingCount, XPS_GLYPH_MAPPING* glyphMappings);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomglyphseditor-setglyphmappings
    HRESULT SetGlyphMappings(uint glyphMappingCount, const(XPS_GLYPH_MAPPING)* glyphMappings);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomglyphseditor-getprohibitedcaretstopcount
    HRESULT GetProhibitedCaretStopCount(uint* prohibitedCaretStopCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomglyphseditor-getprohibitedcaretstops
    HRESULT GetProhibitedCaretStops(uint* count, uint* prohibitedCaretStops);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomglyphseditor-setprohibitedcaretstops
    HRESULT SetProhibitedCaretStops(uint count, const(uint)* prohibitedCaretStops);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomglyphseditor-getbidilevel
    HRESULT GetBidiLevel(uint* bidiLevel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomglyphseditor-setbidilevel
    HRESULT SetBidiLevel(uint bidiLevel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomglyphseditor-getissideways
    HRESULT GetIsSideways(BOOL* isSideways);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomglyphseditor-setissideways
    HRESULT SetIsSideways(BOOL isSideways);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomglyphseditor-getdevicefontname
    HRESULT GetDeviceFontName(PWSTR* deviceFontName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomglyphseditor-setdevicefontname
    HRESULT SetDeviceFontName(const(PWSTR) deviceFontName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsomglyphs
@GUID("819b3199-0a5a-4b64-bec7-a9e17e780de2")
interface IXpsOMGlyphs : IXpsOMVisual
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomglyphs-getunicodestring
    HRESULT GetUnicodeString(PWSTR* unicodeString);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomglyphs-getglyphindexcount
    HRESULT GetGlyphIndexCount(uint* indexCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomglyphs-getglyphindices
    HRESULT GetGlyphIndices(uint* indexCount, XPS_GLYPH_INDEX* glyphIndices);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomglyphs-getglyphmappingcount
    HRESULT GetGlyphMappingCount(uint* glyphMappingCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomglyphs-getglyphmappings
    HRESULT GetGlyphMappings(uint* glyphMappingCount, XPS_GLYPH_MAPPING* glyphMappings);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomglyphs-getprohibitedcaretstopcount
    HRESULT GetProhibitedCaretStopCount(uint* prohibitedCaretStopCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomglyphs-getprohibitedcaretstops
    HRESULT GetProhibitedCaretStops(uint* prohibitedCaretStopCount, uint* prohibitedCaretStops);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomglyphs-getbidilevel
    HRESULT GetBidiLevel(uint* bidiLevel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomglyphs-getissideways
    HRESULT GetIsSideways(BOOL* isSideways);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomglyphs-getdevicefontname
    HRESULT GetDeviceFontName(PWSTR* deviceFontName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomglyphs-getstylesimulations
    HRESULT GetStyleSimulations(XPS_STYLE_SIMULATION* styleSimulations);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomglyphs-setstylesimulations
    HRESULT SetStyleSimulations(XPS_STYLE_SIMULATION styleSimulations);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomglyphs-getorigin
    HRESULT GetOrigin(XPS_POINT* origin);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomglyphs-setorigin
    HRESULT SetOrigin(const(XPS_POINT)* origin);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomglyphs-getfontrenderingemsize
    HRESULT GetFontRenderingEmSize(float* fontRenderingEmSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomglyphs-setfontrenderingemsize
    HRESULT SetFontRenderingEmSize(float fontRenderingEmSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomglyphs-getfontresource
    HRESULT GetFontResource(IXpsOMFontResource* fontResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomglyphs-setfontresource
    HRESULT SetFontResource(IXpsOMFontResource fontResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomglyphs-getfontfaceindex
    HRESULT GetFontFaceIndex(short* fontFaceIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomglyphs-setfontfaceindex
    HRESULT SetFontFaceIndex(short fontFaceIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomglyphs-getfillbrush
    HRESULT GetFillBrush(IXpsOMBrush* fillBrush);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomglyphs-getfillbrushlocal
    HRESULT GetFillBrushLocal(IXpsOMBrush* fillBrush);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomglyphs-setfillbrushlocal
    HRESULT SetFillBrushLocal(IXpsOMBrush fillBrush);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomglyphs-getfillbrushlookup
    HRESULT GetFillBrushLookup(PWSTR* key);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomglyphs-setfillbrushlookup
    HRESULT SetFillBrushLookup(const(PWSTR) key);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomglyphs-getglyphseditor
    HRESULT GetGlyphsEditor(IXpsOMGlyphsEditor* editor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomglyphs-clone
    HRESULT Clone(IXpsOMGlyphs* glyphs);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsomdashcollection
@GUID("081613f4-74eb-48f2-83b3-37a9ce2d7dc6")
interface IXpsOMDashCollection : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomdashcollection-getcount
    HRESULT GetCount(uint* count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomdashcollection-getat
    HRESULT GetAt(uint index, XPS_DASH* dash);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomdashcollection-insertat
    HRESULT InsertAt(uint index, const(XPS_DASH)* dash);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomdashcollection-removeat
    HRESULT RemoveAt(uint index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomdashcollection-setat
    HRESULT SetAt(uint index, const(XPS_DASH)* dash);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomdashcollection-append
    HRESULT Append(const(XPS_DASH)* dash);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsommatrixtransform
@GUID("b77330ff-bb37-4501-a93e-f1b1e50bfc46")
interface IXpsOMMatrixTransform : IXpsOMShareable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsommatrixtransform-getmatrix
    HRESULT GetMatrix(XPS_MATRIX* matrix);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsommatrixtransform-setmatrix
    HRESULT SetMatrix(const(XPS_MATRIX)* matrix);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsommatrixtransform-clone
    HRESULT Clone(IXpsOMMatrixTransform* matrixTransform);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsomgeometry
@GUID("64fcf3d7-4d58-44ba-ad73-a13af6492072")
interface IXpsOMGeometry : IXpsOMShareable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgeometry-getfigures
    HRESULT GetFigures(IXpsOMGeometryFigureCollection* figures);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgeometry-getfillrule
    HRESULT GetFillRule(XPS_FILL_RULE* fillRule);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgeometry-setfillrule
    HRESULT SetFillRule(XPS_FILL_RULE fillRule);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgeometry-gettransform
    HRESULT GetTransform(IXpsOMMatrixTransform* transform);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgeometry-gettransformlocal
    HRESULT GetTransformLocal(IXpsOMMatrixTransform* transform);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgeometry-settransformlocal
    HRESULT SetTransformLocal(IXpsOMMatrixTransform transform);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgeometry-gettransformlookup
    HRESULT GetTransformLookup(PWSTR* lookup);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgeometry-settransformlookup
    HRESULT SetTransformLookup(const(PWSTR) lookup);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgeometry-clone
    HRESULT Clone(IXpsOMGeometry* geometry);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsomgeometryfigure
@GUID("d410dc83-908c-443e-8947-b1795d3c165a")
interface IXpsOMGeometryFigure : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgeometryfigure-getowner
    HRESULT GetOwner(IXpsOMGeometry* owner);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgeometryfigure-getsegmentdata
    HRESULT GetSegmentData(uint* dataCount, float* segmentData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgeometryfigure-getsegmenttypes
    HRESULT GetSegmentTypes(uint* segmentCount, XPS_SEGMENT_TYPE* segmentTypes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgeometryfigure-getsegmentstrokes
    HRESULT GetSegmentStrokes(uint* segmentCount, BOOL* segmentStrokes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgeometryfigure-setsegments
    HRESULT SetSegments(uint segmentCount, uint segmentDataCount, const(XPS_SEGMENT_TYPE)* segmentTypes, 
                        const(float)* segmentData, const(BOOL)* segmentStrokes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgeometryfigure-getstartpoint
    HRESULT GetStartPoint(XPS_POINT* startPoint);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgeometryfigure-setstartpoint
    HRESULT SetStartPoint(const(XPS_POINT)* startPoint);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgeometryfigure-getisclosed
    HRESULT GetIsClosed(BOOL* isClosed);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgeometryfigure-setisclosed
    HRESULT SetIsClosed(BOOL isClosed);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgeometryfigure-getisfilled
    HRESULT GetIsFilled(BOOL* isFilled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgeometryfigure-setisfilled
    HRESULT SetIsFilled(BOOL isFilled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgeometryfigure-getsegmentcount
    HRESULT GetSegmentCount(uint* segmentCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgeometryfigure-getsegmentdatacount
    HRESULT GetSegmentDataCount(uint* segmentDataCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgeometryfigure-getsegmentstrokepattern
    HRESULT GetSegmentStrokePattern(XPS_SEGMENT_STROKE_PATTERN* segmentStrokePattern);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgeometryfigure-clone
    HRESULT Clone(IXpsOMGeometryFigure* geometryFigure);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsomgeometryfigurecollection
@GUID("fd48c3f3-a58e-4b5a-8826-1de54abe72b2")
interface IXpsOMGeometryFigureCollection : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgeometryfigurecollection-getcount
    HRESULT GetCount(uint* count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgeometryfigurecollection-getat
    HRESULT GetAt(uint index, IXpsOMGeometryFigure* geometryFigure);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgeometryfigurecollection-insertat
    HRESULT InsertAt(uint index, IXpsOMGeometryFigure geometryFigure);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgeometryfigurecollection-removeat
    HRESULT RemoveAt(uint index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgeometryfigurecollection-setat
    HRESULT SetAt(uint index, IXpsOMGeometryFigure geometryFigure);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgeometryfigurecollection-append
    HRESULT Append(IXpsOMGeometryFigure geometryFigure);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsompath
@GUID("37d38bb6-3ee9-4110-9312-14b194163337")
interface IXpsOMPath : IXpsOMVisual
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompath-getgeometry
    HRESULT GetGeometry(IXpsOMGeometry* geometry);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompath-getgeometrylocal
    HRESULT GetGeometryLocal(IXpsOMGeometry* geometry);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompath-setgeometrylocal
    HRESULT SetGeometryLocal(IXpsOMGeometry geometry);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompath-getgeometrylookup
    HRESULT GetGeometryLookup(PWSTR* lookup);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompath-setgeometrylookup
    HRESULT SetGeometryLookup(const(PWSTR) lookup);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompath-getaccessibilityshortdescription
    HRESULT GetAccessibilityShortDescription(PWSTR* shortDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompath-setaccessibilityshortdescription
    HRESULT SetAccessibilityShortDescription(const(PWSTR) shortDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompath-getaccessibilitylongdescription
    HRESULT GetAccessibilityLongDescription(PWSTR* longDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompath-setaccessibilitylongdescription
    HRESULT SetAccessibilityLongDescription(const(PWSTR) longDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompath-getsnapstopixels
    HRESULT GetSnapsToPixels(BOOL* snapsToPixels);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompath-setsnapstopixels
    HRESULT SetSnapsToPixels(BOOL snapsToPixels);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompath-getstrokebrush
    HRESULT GetStrokeBrush(IXpsOMBrush* brush);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompath-getstrokebrushlocal
    HRESULT GetStrokeBrushLocal(IXpsOMBrush* brush);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompath-setstrokebrushlocal
    HRESULT SetStrokeBrushLocal(IXpsOMBrush brush);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompath-getstrokebrushlookup
    HRESULT GetStrokeBrushLookup(PWSTR* lookup);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompath-setstrokebrushlookup
    HRESULT SetStrokeBrushLookup(const(PWSTR) lookup);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompath-getstrokedashes
    HRESULT GetStrokeDashes(IXpsOMDashCollection* strokeDashes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompath-getstrokedashcap
    HRESULT GetStrokeDashCap(XPS_DASH_CAP* strokeDashCap);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompath-setstrokedashcap
    HRESULT SetStrokeDashCap(XPS_DASH_CAP strokeDashCap);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompath-getstrokedashoffset
    HRESULT GetStrokeDashOffset(float* strokeDashOffset);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompath-setstrokedashoffset
    HRESULT SetStrokeDashOffset(float strokeDashOffset);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompath-getstrokestartlinecap
    HRESULT GetStrokeStartLineCap(XPS_LINE_CAP* strokeStartLineCap);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompath-setstrokestartlinecap
    HRESULT SetStrokeStartLineCap(XPS_LINE_CAP strokeStartLineCap);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompath-getstrokeendlinecap
    HRESULT GetStrokeEndLineCap(XPS_LINE_CAP* strokeEndLineCap);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompath-setstrokeendlinecap
    HRESULT SetStrokeEndLineCap(XPS_LINE_CAP strokeEndLineCap);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompath-getstrokelinejoin
    HRESULT GetStrokeLineJoin(XPS_LINE_JOIN* strokeLineJoin);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompath-setstrokelinejoin
    HRESULT SetStrokeLineJoin(XPS_LINE_JOIN strokeLineJoin);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompath-getstrokemiterlimit
    HRESULT GetStrokeMiterLimit(float* strokeMiterLimit);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompath-setstrokemiterlimit
    HRESULT SetStrokeMiterLimit(float strokeMiterLimit);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompath-getstrokethickness
    HRESULT GetStrokeThickness(float* strokeThickness);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompath-setstrokethickness
    HRESULT SetStrokeThickness(float strokeThickness);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompath-getfillbrush
    HRESULT GetFillBrush(IXpsOMBrush* brush);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompath-getfillbrushlocal
    HRESULT GetFillBrushLocal(IXpsOMBrush* brush);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompath-setfillbrushlocal
    HRESULT SetFillBrushLocal(IXpsOMBrush brush);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompath-getfillbrushlookup
    HRESULT GetFillBrushLookup(PWSTR* lookup);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompath-setfillbrushlookup
    HRESULT SetFillBrushLookup(const(PWSTR) lookup);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompath-clone
    HRESULT Clone(IXpsOMPath* path);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsombrush
@GUID("56a3f80c-ea4c-4187-a57b-a2a473b2b42b")
interface IXpsOMBrush : IXpsOMShareable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsombrush-getopacity
    HRESULT GetOpacity(float* opacity);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsombrush-setopacity
    HRESULT SetOpacity(float opacity);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsomgradientstopcollection
@GUID("c9174c3a-3cd3-4319-bda4-11a39392ceef")
interface IXpsOMGradientStopCollection : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgradientstopcollection-getcount
    HRESULT GetCount(uint* count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgradientstopcollection-getat
    HRESULT GetAt(uint index, IXpsOMGradientStop* stop);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgradientstopcollection-insertat
    HRESULT InsertAt(uint index, IXpsOMGradientStop stop);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgradientstopcollection-removeat
    HRESULT RemoveAt(uint index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgradientstopcollection-setat
    HRESULT SetAt(uint index, IXpsOMGradientStop stop);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgradientstopcollection-append
    HRESULT Append(IXpsOMGradientStop stop);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsomsolidcolorbrush
@GUID("a06f9f05-3be9-4763-98a8-094fc672e488")
interface IXpsOMSolidColorBrush : IXpsOMBrush
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomsolidcolorbrush-getcolor
    HRESULT GetColor(XPS_COLOR* color, IXpsOMColorProfileResource* colorProfile);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomsolidcolorbrush-setcolor
    HRESULT SetColor(const(XPS_COLOR)* color, IXpsOMColorProfileResource colorProfile);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomsolidcolorbrush-clone
    HRESULT Clone(IXpsOMSolidColorBrush* solidColorBrush);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsomtilebrush
@GUID("0fc2328d-d722-4a54-b2ec-be90218a789e")
interface IXpsOMTileBrush : IXpsOMBrush
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomtilebrush-gettransform
    HRESULT GetTransform(IXpsOMMatrixTransform* transform);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomtilebrush-gettransformlocal
    HRESULT GetTransformLocal(IXpsOMMatrixTransform* transform);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomtilebrush-settransformlocal
    HRESULT SetTransformLocal(IXpsOMMatrixTransform transform);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomtilebrush-gettransformlookup
    HRESULT GetTransformLookup(PWSTR* key);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomtilebrush-settransformlookup
    HRESULT SetTransformLookup(const(PWSTR) key);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomtilebrush-getviewbox
    HRESULT GetViewbox(XPS_RECT* viewbox);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomtilebrush-setviewbox
    HRESULT SetViewbox(const(XPS_RECT)* viewbox);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomtilebrush-getviewport
    HRESULT GetViewport(XPS_RECT* viewport);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomtilebrush-setviewport
    HRESULT SetViewport(const(XPS_RECT)* viewport);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomtilebrush-gettilemode
    HRESULT GetTileMode(XPS_TILE_MODE* tileMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomtilebrush-settilemode
    HRESULT SetTileMode(XPS_TILE_MODE tileMode);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsomvisualbrush
@GUID("97e294af-5b37-46b4-8057-874d2f64119b")
interface IXpsOMVisualBrush : IXpsOMTileBrush
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomvisualbrush-getvisual
    HRESULT GetVisual(IXpsOMVisual* visual);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomvisualbrush-getvisuallocal
    HRESULT GetVisualLocal(IXpsOMVisual* visual);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomvisualbrush-setvisuallocal
    HRESULT SetVisualLocal(IXpsOMVisual visual);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomvisualbrush-getvisuallookup
    HRESULT GetVisualLookup(PWSTR* lookup);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomvisualbrush-setvisuallookup
    HRESULT SetVisualLookup(const(PWSTR) lookup);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomvisualbrush-clone
    HRESULT Clone(IXpsOMVisualBrush* visualBrush);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsomimagebrush
@GUID("3df0b466-d382-49ef-8550-dd94c80242e4")
interface IXpsOMImageBrush : IXpsOMTileBrush
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomimagebrush-getimageresource
    HRESULT GetImageResource(IXpsOMImageResource* imageResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomimagebrush-setimageresource
    HRESULT SetImageResource(IXpsOMImageResource imageResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomimagebrush-getcolorprofileresource
    HRESULT GetColorProfileResource(IXpsOMColorProfileResource* colorProfileResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomimagebrush-setcolorprofileresource
    HRESULT SetColorProfileResource(IXpsOMColorProfileResource colorProfileResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomimagebrush-clone
    HRESULT Clone(IXpsOMImageBrush* imageBrush);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsomgradientstop
@GUID("5cf4f5cc-3969-49b5-a70a-5550b618fe49")
interface IXpsOMGradientStop : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgradientstop-getowner
    HRESULT GetOwner(IXpsOMGradientBrush* owner);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgradientstop-getoffset
    HRESULT GetOffset(float* offset);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgradientstop-setoffset
    HRESULT SetOffset(float offset);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgradientstop-getcolor
    HRESULT GetColor(XPS_COLOR* color, IXpsOMColorProfileResource* colorProfile);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgradientstop-setcolor
    HRESULT SetColor(const(XPS_COLOR)* color, IXpsOMColorProfileResource colorProfile);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgradientstop-clone
    HRESULT Clone(IXpsOMGradientStop* gradientStop);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsomgradientbrush
@GUID("edb59622-61a2-42c3-bace-acf2286c06bf")
interface IXpsOMGradientBrush : IXpsOMBrush
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgradientbrush-getgradientstops
    HRESULT GetGradientStops(IXpsOMGradientStopCollection* gradientStops);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgradientbrush-gettransform
    HRESULT GetTransform(IXpsOMMatrixTransform* transform);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgradientbrush-gettransformlocal
    HRESULT GetTransformLocal(IXpsOMMatrixTransform* transform);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgradientbrush-settransformlocal
    HRESULT SetTransformLocal(IXpsOMMatrixTransform transform);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgradientbrush-gettransformlookup
    HRESULT GetTransformLookup(PWSTR* key);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgradientbrush-settransformlookup
    HRESULT SetTransformLookup(const(PWSTR) key);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgradientbrush-getspreadmethod
    HRESULT GetSpreadMethod(XPS_SPREAD_METHOD* spreadMethod);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgradientbrush-setspreadmethod
    HRESULT SetSpreadMethod(XPS_SPREAD_METHOD spreadMethod);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgradientbrush-getcolorinterpolationmode
    HRESULT GetColorInterpolationMode(XPS_COLOR_INTERPOLATION* colorInterpolationMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomgradientbrush-setcolorinterpolationmode
    HRESULT SetColorInterpolationMode(XPS_COLOR_INTERPOLATION colorInterpolationMode);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsomlineargradientbrush
@GUID("005e279f-c30d-40ff-93ec-1950d3c528db")
interface IXpsOMLinearGradientBrush : IXpsOMGradientBrush
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomlineargradientbrush-getstartpoint
    HRESULT GetStartPoint(XPS_POINT* startPoint);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomlineargradientbrush-setstartpoint
    HRESULT SetStartPoint(const(XPS_POINT)* startPoint);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomlineargradientbrush-getendpoint
    HRESULT GetEndPoint(XPS_POINT* endPoint);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomlineargradientbrush-setendpoint
    HRESULT SetEndPoint(const(XPS_POINT)* endPoint);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomlineargradientbrush-clone
    HRESULT Clone(IXpsOMLinearGradientBrush* linearGradientBrush);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsomradialgradientbrush
@GUID("75f207e5-08bf-413c-96b1-b82b4064176b")
interface IXpsOMRadialGradientBrush : IXpsOMGradientBrush
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomradialgradientbrush-getcenter
    HRESULT GetCenter(XPS_POINT* center);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomradialgradientbrush-setcenter
    HRESULT SetCenter(const(XPS_POINT)* center);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomradialgradientbrush-getradiisizes
    HRESULT GetRadiiSizes(XPS_SIZE* radiiSizes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomradialgradientbrush-setradiisizes
    HRESULT SetRadiiSizes(const(XPS_SIZE)* radiiSizes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomradialgradientbrush-getgradientorigin
    HRESULT GetGradientOrigin(XPS_POINT* origin);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomradialgradientbrush-setgradientorigin
    HRESULT SetGradientOrigin(const(XPS_POINT)* origin);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomradialgradientbrush-clone
    HRESULT Clone(IXpsOMRadialGradientBrush* radialGradientBrush);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsomresource
@GUID("da2ac0a2-73a2-4975-ad14-74097c3ff3a5")
interface IXpsOMResource : IXpsOMPart
{
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsompartresources
@GUID("f4cf7729-4864-4275-99b3-a8717163ecaf")
interface IXpsOMPartResources : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompartresources-getfontresources
    HRESULT GetFontResources(IXpsOMFontResourceCollection* fontResources);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompartresources-getimageresources
    HRESULT GetImageResources(IXpsOMImageResourceCollection* imageResources);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompartresources-getcolorprofileresources
    HRESULT GetColorProfileResources(IXpsOMColorProfileResourceCollection* colorProfileResources);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompartresources-getremotedictionaryresources
    HRESULT GetRemoteDictionaryResources(IXpsOMRemoteDictionaryResourceCollection* dictionaryResources);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsomdictionary
@GUID("897c86b8-8eaf-4ae3-bdde-56419fcf4236")
interface IXpsOMDictionary : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomdictionary-getowner
    HRESULT GetOwner(IUnknown* owner);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomdictionary-getcount
    HRESULT GetCount(uint* count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomdictionary-getat
    HRESULT GetAt(uint index, PWSTR* key, IXpsOMShareable* entry);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomdictionary-getbykey
    HRESULT GetByKey(const(PWSTR) key, IXpsOMShareable beforeEntry, IXpsOMShareable* entry);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomdictionary-getindex
    HRESULT GetIndex(IXpsOMShareable entry, uint* index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomdictionary-append
    HRESULT Append(const(PWSTR) key, IXpsOMShareable entry);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomdictionary-insertat
    HRESULT InsertAt(uint index, const(PWSTR) key, IXpsOMShareable entry);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomdictionary-removeat
    HRESULT RemoveAt(uint index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomdictionary-setat
    HRESULT SetAt(uint index, const(PWSTR) key, IXpsOMShareable entry);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomdictionary-clone
    HRESULT Clone(IXpsOMDictionary* dictionary);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsomfontresource
@GUID("a8c45708-47d9-4af4-8d20-33b48c9b8485")
interface IXpsOMFontResource : IXpsOMResource
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomfontresource-getstream
    HRESULT GetStream(IStream* readerStream);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomfontresource-setcontent
    HRESULT SetContent(IStream sourceStream, XPS_FONT_EMBEDDING embeddingOption, IOpcPartUri partName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomfontresource-getembeddingoption
    HRESULT GetEmbeddingOption(XPS_FONT_EMBEDDING* embeddingOption);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsomfontresourcecollection
@GUID("70b4a6bb-88d4-4fa8-aaf9-6d9c596fdbad")
interface IXpsOMFontResourceCollection : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomfontresourcecollection-getcount
    HRESULT GetCount(uint* count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomfontresourcecollection-getat
    HRESULT GetAt(uint index, IXpsOMFontResource* value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomfontresourcecollection-setat
    HRESULT SetAt(uint index, IXpsOMFontResource value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomfontresourcecollection-insertat
    HRESULT InsertAt(uint index, IXpsOMFontResource value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomfontresourcecollection-append
    HRESULT Append(IXpsOMFontResource value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomfontresourcecollection-removeat
    HRESULT RemoveAt(uint index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomfontresourcecollection-getbypartname
    HRESULT GetByPartName(IOpcPartUri partName, IXpsOMFontResource* part);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsomimageresource
@GUID("3db8417d-ae50-485e-9a44-d7758f78a23f")
interface IXpsOMImageResource : IXpsOMResource
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomimageresource-getstream
    HRESULT GetStream(IStream* readerStream);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomimageresource-setcontent
    HRESULT SetContent(IStream sourceStream, XPS_IMAGE_TYPE imageType, IOpcPartUri partName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomimageresource-getimagetype
    HRESULT GetImageType(XPS_IMAGE_TYPE* imageType);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsomimageresourcecollection
@GUID("7a4a1a71-9cde-4b71-b33f-62de843eabfe")
interface IXpsOMImageResourceCollection : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomimageresourcecollection-getcount
    HRESULT GetCount(uint* count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomimageresourcecollection-getat
    HRESULT GetAt(uint index, IXpsOMImageResource* object);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomimageresourcecollection-insertat
    HRESULT InsertAt(uint index, IXpsOMImageResource object);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomimageresourcecollection-removeat
    HRESULT RemoveAt(uint index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomimageresourcecollection-setat
    HRESULT SetAt(uint index, IXpsOMImageResource object);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomimageresourcecollection-append
    HRESULT Append(IXpsOMImageResource object);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomimageresourcecollection-getbypartname
    HRESULT GetByPartName(IOpcPartUri partName, IXpsOMImageResource* part);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsomcolorprofileresource
@GUID("67bd7d69-1eef-4bb1-b5e7-6f4f87be8abe")
interface IXpsOMColorProfileResource : IXpsOMResource
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcolorprofileresource-getstream
    HRESULT GetStream(IStream* stream);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcolorprofileresource-setcontent
    HRESULT SetContent(IStream sourceStream, IOpcPartUri partName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsomcolorprofileresourcecollection
@GUID("12759630-5fba-4283-8f7d-cca849809edb")
interface IXpsOMColorProfileResourceCollection : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcolorprofileresourcecollection-getcount
    HRESULT GetCount(uint* count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcolorprofileresourcecollection-getat
    HRESULT GetAt(uint index, IXpsOMColorProfileResource* object);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcolorprofileresourcecollection-insertat
    HRESULT InsertAt(uint index, IXpsOMColorProfileResource object);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcolorprofileresourcecollection-removeat
    HRESULT RemoveAt(uint index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcolorprofileresourcecollection-setat
    HRESULT SetAt(uint index, IXpsOMColorProfileResource object);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcolorprofileresourcecollection-append
    HRESULT Append(IXpsOMColorProfileResource object);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcolorprofileresourcecollection-getbypartname
    HRESULT GetByPartName(IOpcPartUri partName, IXpsOMColorProfileResource* part);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsomprintticketresource
@GUID("e7ff32d2-34aa-499b-bbe9-9cd4ee6c59f7")
interface IXpsOMPrintTicketResource : IXpsOMResource
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomprintticketresource-getstream
    HRESULT GetStream(IStream* stream);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomprintticketresource-setcontent
    HRESULT SetContent(IStream sourceStream, IOpcPartUri partName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsomremotedictionaryresource
@GUID("c9bd7cd4-e16a-4bf8-8c84-c950af7a3061")
interface IXpsOMRemoteDictionaryResource : IXpsOMResource
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomremotedictionaryresource-getdictionary
    HRESULT GetDictionary(IXpsOMDictionary* dictionary);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomremotedictionaryresource-setdictionary
    HRESULT SetDictionary(IXpsOMDictionary dictionary);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsomremotedictionaryresourcecollection
@GUID("5c38db61-7fec-464a-87bd-41e3bef018be")
interface IXpsOMRemoteDictionaryResourceCollection : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomremotedictionaryresourcecollection-getcount
    HRESULT GetCount(uint* count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomremotedictionaryresourcecollection-getat
    HRESULT GetAt(uint index, IXpsOMRemoteDictionaryResource* object);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomremotedictionaryresourcecollection-insertat
    HRESULT InsertAt(uint index, IXpsOMRemoteDictionaryResource object);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomremotedictionaryresourcecollection-removeat
    HRESULT RemoveAt(uint index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomremotedictionaryresourcecollection-setat
    HRESULT SetAt(uint index, IXpsOMRemoteDictionaryResource object);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomremotedictionaryresourcecollection-append
    HRESULT Append(IXpsOMRemoteDictionaryResource object);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomremotedictionaryresourcecollection-getbypartname
    HRESULT GetByPartName(IOpcPartUri partName, IXpsOMRemoteDictionaryResource* remoteDictionaryResource);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsomsignatureblockresourcecollection
@GUID("ab8f5d8e-351b-4d33-aaed-fa56f0022931")
interface IXpsOMSignatureBlockResourceCollection : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomsignatureblockresourcecollection-getcount
    HRESULT GetCount(uint* count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomsignatureblockresourcecollection-getat
    HRESULT GetAt(uint index, IXpsOMSignatureBlockResource* signatureBlockResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomsignatureblockresourcecollection-insertat
    HRESULT InsertAt(uint index, IXpsOMSignatureBlockResource signatureBlockResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomsignatureblockresourcecollection-removeat
    HRESULT RemoveAt(uint index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomsignatureblockresourcecollection-setat
    HRESULT SetAt(uint index, IXpsOMSignatureBlockResource signatureBlockResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomsignatureblockresourcecollection-append
    HRESULT Append(IXpsOMSignatureBlockResource signatureBlockResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomsignatureblockresourcecollection-getbypartname
    HRESULT GetByPartName(IOpcPartUri partName, IXpsOMSignatureBlockResource* signatureBlockResource);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsomdocumentstructureresource
@GUID("85febc8a-6b63-48a9-af07-7064e4ecff30")
interface IXpsOMDocumentStructureResource : IXpsOMResource
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomdocumentstructureresource-getowner
    HRESULT GetOwner(IXpsOMDocument* owner);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomdocumentstructureresource-getstream
    HRESULT GetStream(IStream* stream);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomdocumentstructureresource-setcontent
    HRESULT SetContent(IStream sourceStream, IOpcPartUri partName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsomstoryfragmentsresource
@GUID("c2b3ca09-0473-4282-87ae-1780863223f0")
interface IXpsOMStoryFragmentsResource : IXpsOMResource
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomstoryfragmentsresource-getowner
    HRESULT GetOwner(IXpsOMPageReference* owner);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomstoryfragmentsresource-getstream
    HRESULT GetStream(IStream* stream);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomstoryfragmentsresource-setcontent
    HRESULT SetContent(IStream sourceStream, IOpcPartUri partName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsomsignatureblockresource
@GUID("4776ad35-2e04-4357-8743-ebf6c171a905")
interface IXpsOMSignatureBlockResource : IXpsOMResource
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomsignatureblockresource-getowner
    HRESULT GetOwner(IXpsOMDocument* owner);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomsignatureblockresource-getstream
    HRESULT GetStream(IStream* stream);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomsignatureblockresource-setcontent
    HRESULT SetContent(IStream sourceStream, IOpcPartUri partName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsomvisualcollection
@GUID("94d8abde-ab91-46a8-82b7-f5b05ef01a96")
interface IXpsOMVisualCollection : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomvisualcollection-getcount
    HRESULT GetCount(uint* count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomvisualcollection-getat
    HRESULT GetAt(uint index, IXpsOMVisual* object);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomvisualcollection-insertat
    HRESULT InsertAt(uint index, IXpsOMVisual object);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomvisualcollection-removeat
    HRESULT RemoveAt(uint index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomvisualcollection-setat
    HRESULT SetAt(uint index, IXpsOMVisual object);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomvisualcollection-append
    HRESULT Append(IXpsOMVisual object);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsomcanvas
@GUID("221d1452-331e-47c6-87e9-6ccefb9b5ba3")
interface IXpsOMCanvas : IXpsOMVisual
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcanvas-getvisuals
    HRESULT GetVisuals(IXpsOMVisualCollection* visuals);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcanvas-getusealiasededgemode
    HRESULT GetUseAliasedEdgeMode(BOOL* useAliasedEdgeMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcanvas-setusealiasededgemode
    HRESULT SetUseAliasedEdgeMode(BOOL useAliasedEdgeMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcanvas-getaccessibilityshortdescription
    HRESULT GetAccessibilityShortDescription(PWSTR* shortDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcanvas-setaccessibilityshortdescription
    HRESULT SetAccessibilityShortDescription(const(PWSTR) shortDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcanvas-getaccessibilitylongdescription
    HRESULT GetAccessibilityLongDescription(PWSTR* longDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcanvas-setaccessibilitylongdescription
    HRESULT SetAccessibilityLongDescription(const(PWSTR) longDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcanvas-getdictionary
    HRESULT GetDictionary(IXpsOMDictionary* resourceDictionary);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcanvas-getdictionarylocal
    HRESULT GetDictionaryLocal(IXpsOMDictionary* resourceDictionary);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcanvas-setdictionarylocal
    HRESULT SetDictionaryLocal(IXpsOMDictionary resourceDictionary);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcanvas-getdictionaryresource
    HRESULT GetDictionaryResource(IXpsOMRemoteDictionaryResource* remoteDictionaryResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcanvas-setdictionaryresource
    HRESULT SetDictionaryResource(IXpsOMRemoteDictionaryResource remoteDictionaryResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcanvas-clone
    HRESULT Clone(IXpsOMCanvas* canvas);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsompage
@GUID("d3e18888-f120-4fee-8c68-35296eae91d4")
interface IXpsOMPage : IXpsOMPart
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompage-getowner
    HRESULT GetOwner(IXpsOMPageReference* pageReference);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompage-getvisuals
    HRESULT GetVisuals(IXpsOMVisualCollection* visuals);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompage-getpagedimensions
    HRESULT GetPageDimensions(XPS_SIZE* pageDimensions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompage-setpagedimensions
    HRESULT SetPageDimensions(const(XPS_SIZE)* pageDimensions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompage-getcontentbox
    HRESULT GetContentBox(XPS_RECT* contentBox);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompage-setcontentbox
    HRESULT SetContentBox(const(XPS_RECT)* contentBox);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompage-getbleedbox
    HRESULT GetBleedBox(XPS_RECT* bleedBox);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompage-setbleedbox
    HRESULT SetBleedBox(const(XPS_RECT)* bleedBox);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompage-getlanguage
    HRESULT GetLanguage(PWSTR* language);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompage-setlanguage
    HRESULT SetLanguage(const(PWSTR) language);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompage-getname
    HRESULT GetName(PWSTR* name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompage-setname
    HRESULT SetName(const(PWSTR) name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompage-getishyperlinktarget
    HRESULT GetIsHyperlinkTarget(BOOL* isHyperlinkTarget);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompage-setishyperlinktarget
    HRESULT SetIsHyperlinkTarget(BOOL isHyperlinkTarget);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompage-getdictionary
    HRESULT GetDictionary(IXpsOMDictionary* resourceDictionary);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompage-getdictionarylocal
    HRESULT GetDictionaryLocal(IXpsOMDictionary* resourceDictionary);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompage-setdictionarylocal
    HRESULT SetDictionaryLocal(IXpsOMDictionary resourceDictionary);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompage-getdictionaryresource
    HRESULT GetDictionaryResource(IXpsOMRemoteDictionaryResource* remoteDictionaryResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompage-setdictionaryresource
    HRESULT SetDictionaryResource(IXpsOMRemoteDictionaryResource remoteDictionaryResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompage-write
    HRESULT Write(ISequentialStream stream, BOOL optimizeMarkupSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompage-generateunusedlookupkey
    HRESULT GenerateUnusedLookupKey(XPS_OBJECT_TYPE type, PWSTR* key);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompage-clone
    HRESULT Clone(IXpsOMPage* page);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsompagereference
@GUID("ed360180-6f92-4998-890d-2f208531a0a0")
interface IXpsOMPageReference : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompagereference-getowner
    HRESULT GetOwner(IXpsOMDocument* document);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompagereference-getpage
    HRESULT GetPage(IXpsOMPage* page);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompagereference-setpage
    HRESULT SetPage(IXpsOMPage page);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompagereference-discardpage
    HRESULT DiscardPage();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompagereference-ispageloaded
    HRESULT IsPageLoaded(BOOL* isPageLoaded);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompagereference-getadvisorypagedimensions
    HRESULT GetAdvisoryPageDimensions(XPS_SIZE* pageDimensions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompagereference-setadvisorypagedimensions
    HRESULT SetAdvisoryPageDimensions(const(XPS_SIZE)* pageDimensions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompagereference-getstoryfragmentsresource
    HRESULT GetStoryFragmentsResource(IXpsOMStoryFragmentsResource* storyFragmentsResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompagereference-setstoryfragmentsresource
    HRESULT SetStoryFragmentsResource(IXpsOMStoryFragmentsResource storyFragmentsResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompagereference-getprintticketresource
    HRESULT GetPrintTicketResource(IXpsOMPrintTicketResource* printTicketResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompagereference-setprintticketresource
    HRESULT SetPrintTicketResource(IXpsOMPrintTicketResource printTicketResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompagereference-getthumbnailresource
    HRESULT GetThumbnailResource(IXpsOMImageResource* imageResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompagereference-setthumbnailresource
    HRESULT SetThumbnailResource(IXpsOMImageResource imageResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompagereference-collectlinktargets
    HRESULT CollectLinkTargets(IXpsOMNameCollection* linkTargets);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompagereference-collectpartresources
    HRESULT CollectPartResources(IXpsOMPartResources* partResources);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompagereference-hasrestrictedfonts
    HRESULT HasRestrictedFonts(BOOL* restrictedFonts);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompagereference-clone
    HRESULT Clone(IXpsOMPageReference* pageReference);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsompagereferencecollection
@GUID("ca16ba4d-e7b9-45c5-958b-f98022473745")
interface IXpsOMPageReferenceCollection : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompagereferencecollection-getcount
    HRESULT GetCount(uint* count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompagereferencecollection-getat
    HRESULT GetAt(uint index, IXpsOMPageReference* pageReference);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompagereferencecollection-insertat
    HRESULT InsertAt(uint index, IXpsOMPageReference pageReference);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompagereferencecollection-removeat
    HRESULT RemoveAt(uint index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompagereferencecollection-setat
    HRESULT SetAt(uint index, IXpsOMPageReference pageReference);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompagereferencecollection-append
    HRESULT Append(IXpsOMPageReference pageReference);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsomdocument
@GUID("2c2c94cb-ac5f-4254-8ee9-23948309d9f0")
interface IXpsOMDocument : IXpsOMPart
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomdocument-getowner
    HRESULT GetOwner(IXpsOMDocumentSequence* documentSequence);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomdocument-getpagereferences
    HRESULT GetPageReferences(IXpsOMPageReferenceCollection* pageReferences);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomdocument-getprintticketresource
    HRESULT GetPrintTicketResource(IXpsOMPrintTicketResource* printTicketResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomdocument-setprintticketresource
    HRESULT SetPrintTicketResource(IXpsOMPrintTicketResource printTicketResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomdocument-getdocumentstructureresource
    HRESULT GetDocumentStructureResource(IXpsOMDocumentStructureResource* documentStructureResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomdocument-setdocumentstructureresource
    HRESULT SetDocumentStructureResource(IXpsOMDocumentStructureResource documentStructureResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomdocument-getsignatureblockresources
    HRESULT GetSignatureBlockResources(IXpsOMSignatureBlockResourceCollection* signatureBlockResources);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomdocument-clone
    HRESULT Clone(IXpsOMDocument* document);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsomdocumentcollection
@GUID("d1c87f0d-e947-4754-8a25-971478f7e83e")
interface IXpsOMDocumentCollection : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomdocumentcollection-getcount
    HRESULT GetCount(uint* count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomdocumentcollection-getat
    HRESULT GetAt(uint index, IXpsOMDocument* document);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomdocumentcollection-insertat
    HRESULT InsertAt(uint index, IXpsOMDocument document);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomdocumentcollection-removeat
    HRESULT RemoveAt(uint index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomdocumentcollection-setat
    HRESULT SetAt(uint index, IXpsOMDocument document);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomdocumentcollection-append
    HRESULT Append(IXpsOMDocument document);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsomdocumentsequence
@GUID("56492eb4-d8d5-425e-8256-4c2b64ad0264")
interface IXpsOMDocumentSequence : IXpsOMPart
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomdocumentsequence-getowner
    HRESULT GetOwner(IXpsOMPackage* package_);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomdocumentsequence-getdocuments
    HRESULT GetDocuments(IXpsOMDocumentCollection* documents);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomdocumentsequence-getprintticketresource
    HRESULT GetPrintTicketResource(IXpsOMPrintTicketResource* printTicketResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomdocumentsequence-setprintticketresource
    HRESULT SetPrintTicketResource(IXpsOMPrintTicketResource printTicketResource);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsomcoreproperties
@GUID("3340fe8f-4027-4aa1-8f5f-d35ae45fe597")
interface IXpsOMCoreProperties : IXpsOMPart
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcoreproperties-getowner
    HRESULT GetOwner(IXpsOMPackage* package_);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcoreproperties-getcategory
    HRESULT GetCategory(PWSTR* category);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcoreproperties-setcategory
    HRESULT SetCategory(const(PWSTR) category);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcoreproperties-getcontentstatus
    HRESULT GetContentStatus(PWSTR* contentStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcoreproperties-setcontentstatus
    HRESULT SetContentStatus(const(PWSTR) contentStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcoreproperties-getcontenttype
    HRESULT GetContentType(PWSTR* contentType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcoreproperties-setcontenttype
    HRESULT SetContentType(const(PWSTR) contentType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcoreproperties-getcreated
    HRESULT GetCreated(SYSTEMTIME* created);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcoreproperties-setcreated
    HRESULT SetCreated(const(SYSTEMTIME)* created);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcoreproperties-getcreator
    HRESULT GetCreator(PWSTR* creator);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcoreproperties-setcreator
    HRESULT SetCreator(const(PWSTR) creator);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcoreproperties-getdescription
    HRESULT GetDescription(PWSTR* description);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcoreproperties-setdescription
    HRESULT SetDescription(const(PWSTR) description);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcoreproperties-getidentifier
    HRESULT GetIdentifier(PWSTR* identifier);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcoreproperties-setidentifier
    HRESULT SetIdentifier(const(PWSTR) identifier);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcoreproperties-getkeywords
    HRESULT GetKeywords(PWSTR* keywords);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcoreproperties-setkeywords
    HRESULT SetKeywords(const(PWSTR) keywords);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcoreproperties-getlanguage
    HRESULT GetLanguage(PWSTR* language);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcoreproperties-setlanguage
    HRESULT SetLanguage(const(PWSTR) language);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcoreproperties-getlastmodifiedby
    HRESULT GetLastModifiedBy(PWSTR* lastModifiedBy);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcoreproperties-setlastmodifiedby
    HRESULT SetLastModifiedBy(const(PWSTR) lastModifiedBy);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcoreproperties-getlastprinted
    HRESULT GetLastPrinted(SYSTEMTIME* lastPrinted);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcoreproperties-setlastprinted
    HRESULT SetLastPrinted(const(SYSTEMTIME)* lastPrinted);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcoreproperties-getmodified
    HRESULT GetModified(SYSTEMTIME* modified);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcoreproperties-setmodified
    HRESULT SetModified(const(SYSTEMTIME)* modified);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcoreproperties-getrevision
    HRESULT GetRevision(PWSTR* revision);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcoreproperties-setrevision
    HRESULT SetRevision(const(PWSTR) revision);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcoreproperties-getsubject
    HRESULT GetSubject(PWSTR* subject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcoreproperties-setsubject
    HRESULT SetSubject(const(PWSTR) subject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcoreproperties-gettitle
    HRESULT GetTitle(PWSTR* title);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcoreproperties-settitle
    HRESULT SetTitle(const(PWSTR) title);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcoreproperties-getversion
    HRESULT GetVersion(PWSTR* version_);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcoreproperties-setversion
    HRESULT SetVersion(const(PWSTR) version_);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomcoreproperties-clone
    HRESULT Clone(IXpsOMCoreProperties* coreProperties);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsompackage
@GUID("18c3df65-81e1-4674-91dc-fc452f5a416f")
interface IXpsOMPackage : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompackage-getdocumentsequence
    HRESULT GetDocumentSequence(IXpsOMDocumentSequence* documentSequence);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompackage-setdocumentsequence
    HRESULT SetDocumentSequence(IXpsOMDocumentSequence documentSequence);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompackage-getcoreproperties
    HRESULT GetCoreProperties(IXpsOMCoreProperties* coreProperties);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompackage-setcoreproperties
    HRESULT SetCoreProperties(IXpsOMCoreProperties coreProperties);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompackage-getdiscardcontrolpartname
    HRESULT GetDiscardControlPartName(IOpcPartUri* discardControlPartUri);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompackage-setdiscardcontrolpartname
    HRESULT SetDiscardControlPartName(IOpcPartUri discardControlPartUri);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompackage-getthumbnailresource
    HRESULT GetThumbnailResource(IXpsOMImageResource* imageResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompackage-setthumbnailresource
    HRESULT SetThumbnailResource(IXpsOMImageResource imageResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompackage-writetofile
    HRESULT WriteToFile(const(PWSTR) fileName, SECURITY_ATTRIBUTES* securityAttributes, uint flagsAndAttributes, 
                        BOOL optimizeMarkupSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompackage-writetostream
    HRESULT WriteToStream(ISequentialStream stream, BOOL optimizeMarkupSize);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsomobjectfactory
@GUID("f9b2a685-a50d-4fc2-b764-b56e093ea0ca")
interface IXpsOMObjectFactory : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomobjectfactory-createpackage
    HRESULT CreatePackage(IXpsOMPackage* package_);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomobjectfactory-createpackagefromfile
    HRESULT CreatePackageFromFile(const(PWSTR) filename, BOOL reuseObjects, IXpsOMPackage* package_);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomobjectfactory-createpackagefromstream
    HRESULT CreatePackageFromStream(IStream stream, BOOL reuseObjects, IXpsOMPackage* package_);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomobjectfactory-createstoryfragmentsresource
    HRESULT CreateStoryFragmentsResource(IStream acquiredStream, IOpcPartUri partUri, 
                                         IXpsOMStoryFragmentsResource* storyFragmentsResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomobjectfactory-createdocumentstructureresource
    HRESULT CreateDocumentStructureResource(IStream acquiredStream, IOpcPartUri partUri, 
                                            IXpsOMDocumentStructureResource* documentStructureResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomobjectfactory-createsignatureblockresource
    HRESULT CreateSignatureBlockResource(IStream acquiredStream, IOpcPartUri partUri, 
                                         IXpsOMSignatureBlockResource* signatureBlockResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomobjectfactory-createremotedictionaryresource
    HRESULT CreateRemoteDictionaryResource(IXpsOMDictionary dictionary, IOpcPartUri partUri, 
                                           IXpsOMRemoteDictionaryResource* remoteDictionaryResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomobjectfactory-createremotedictionaryresourcefromstream
    HRESULT CreateRemoteDictionaryResourceFromStream(IStream dictionaryMarkupStream, IOpcPartUri dictionaryPartUri, 
                                                     IXpsOMPartResources resources, 
                                                     IXpsOMRemoteDictionaryResource* dictionaryResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomobjectfactory-createpartresources
    HRESULT CreatePartResources(IXpsOMPartResources* partResources);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomobjectfactory-createdocumentsequence
    HRESULT CreateDocumentSequence(IOpcPartUri partUri, IXpsOMDocumentSequence* documentSequence);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomobjectfactory-createdocument
    HRESULT CreateDocument(IOpcPartUri partUri, IXpsOMDocument* document);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomobjectfactory-createpagereference
    HRESULT CreatePageReference(const(XPS_SIZE)* advisoryPageDimensions, IXpsOMPageReference* pageReference);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomobjectfactory-createpage
    HRESULT CreatePage(const(XPS_SIZE)* pageDimensions, const(PWSTR) language, IOpcPartUri partUri, 
                       IXpsOMPage* page);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomobjectfactory-createpagefromstream
    HRESULT CreatePageFromStream(IStream pageMarkupStream, IOpcPartUri partUri, IXpsOMPartResources resources, 
                                 BOOL reuseObjects, IXpsOMPage* page);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomobjectfactory-createcanvas
    HRESULT CreateCanvas(IXpsOMCanvas* canvas);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomobjectfactory-createglyphs
    HRESULT CreateGlyphs(IXpsOMFontResource fontResource, IXpsOMGlyphs* glyphs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomobjectfactory-createpath
    HRESULT CreatePath(IXpsOMPath* path);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomobjectfactory-creategeometry
    HRESULT CreateGeometry(IXpsOMGeometry* geometry);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomobjectfactory-creategeometryfigure
    HRESULT CreateGeometryFigure(const(XPS_POINT)* startPoint, IXpsOMGeometryFigure* figure);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomobjectfactory-creatematrixtransform
    HRESULT CreateMatrixTransform(const(XPS_MATRIX)* matrix, IXpsOMMatrixTransform* transform);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomobjectfactory-createsolidcolorbrush
    HRESULT CreateSolidColorBrush(const(XPS_COLOR)* color, IXpsOMColorProfileResource colorProfile, 
                                  IXpsOMSolidColorBrush* solidColorBrush);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomobjectfactory-createcolorprofileresource
    HRESULT CreateColorProfileResource(IStream acquiredStream, IOpcPartUri partUri, 
                                       IXpsOMColorProfileResource* colorProfileResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomobjectfactory-createimagebrush
    HRESULT CreateImageBrush(IXpsOMImageResource image, const(XPS_RECT)* viewBox, const(XPS_RECT)* viewPort, 
                             IXpsOMImageBrush* imageBrush);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomobjectfactory-createvisualbrush
    HRESULT CreateVisualBrush(const(XPS_RECT)* viewBox, const(XPS_RECT)* viewPort, IXpsOMVisualBrush* visualBrush);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomobjectfactory-createimageresource
    HRESULT CreateImageResource(IStream acquiredStream, XPS_IMAGE_TYPE contentType, IOpcPartUri partUri, 
                                IXpsOMImageResource* imageResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomobjectfactory-createprintticketresource
    HRESULT CreatePrintTicketResource(IStream acquiredStream, IOpcPartUri partUri, 
                                      IXpsOMPrintTicketResource* printTicketResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomobjectfactory-createfontresource
    HRESULT CreateFontResource(IStream acquiredStream, XPS_FONT_EMBEDDING fontEmbedding, IOpcPartUri partUri, 
                               BOOL isObfSourceStream, IXpsOMFontResource* fontResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomobjectfactory-creategradientstop
    HRESULT CreateGradientStop(const(XPS_COLOR)* color, IXpsOMColorProfileResource colorProfile, float offset, 
                               IXpsOMGradientStop* gradientStop);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomobjectfactory-createlineargradientbrush
    HRESULT CreateLinearGradientBrush(IXpsOMGradientStop gradStop1, IXpsOMGradientStop gradStop2, 
                                      const(XPS_POINT)* startPoint, const(XPS_POINT)* endPoint, 
                                      IXpsOMLinearGradientBrush* linearGradientBrush);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomobjectfactory-createradialgradientbrush
    HRESULT CreateRadialGradientBrush(IXpsOMGradientStop gradStop1, IXpsOMGradientStop gradStop2, 
                                      const(XPS_POINT)* centerPoint, const(XPS_POINT)* gradientOrigin, 
                                      const(XPS_SIZE)* radiiSizes, IXpsOMRadialGradientBrush* radialGradientBrush);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomobjectfactory-createcoreproperties
    HRESULT CreateCoreProperties(IOpcPartUri partUri, IXpsOMCoreProperties* coreProperties);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomobjectfactory-createdictionary
    HRESULT CreateDictionary(IXpsOMDictionary* dictionary);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomobjectfactory-createparturicollection
    HRESULT CreatePartUriCollection(IXpsOMPartUriCollection* partUriCollection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomobjectfactory-createpackagewriteronfile
    HRESULT CreatePackageWriterOnFile(const(PWSTR) fileName, SECURITY_ATTRIBUTES* securityAttributes, 
                                      uint flagsAndAttributes, BOOL optimizeMarkupSize, 
                                      XPS_INTERLEAVING interleaving, IOpcPartUri documentSequencePartName, 
                                      IXpsOMCoreProperties coreProperties, IXpsOMImageResource packageThumbnail, 
                                      IXpsOMPrintTicketResource documentSequencePrintTicket, 
                                      IOpcPartUri discardControlPartName, IXpsOMPackageWriter* packageWriter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomobjectfactory-createpackagewriteronstream
    HRESULT CreatePackageWriterOnStream(ISequentialStream outputStream, BOOL optimizeMarkupSize, 
                                        XPS_INTERLEAVING interleaving, IOpcPartUri documentSequencePartName, 
                                        IXpsOMCoreProperties coreProperties, IXpsOMImageResource packageThumbnail, 
                                        IXpsOMPrintTicketResource documentSequencePrintTicket, 
                                        IOpcPartUri discardControlPartName, IXpsOMPackageWriter* packageWriter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomobjectfactory-createparturi
    HRESULT CreatePartUri(const(PWSTR) uri, IOpcPartUri* partUri);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomobjectfactory-createreadonlystreamonfile
    HRESULT CreateReadOnlyStreamOnFile(const(PWSTR) filename, IStream* stream);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsomnamecollection
@GUID("4bddf8ec-c915-421b-a166-d173d25653d2")
interface IXpsOMNameCollection : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomnamecollection-getcount
    HRESULT GetCount(uint* count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomnamecollection-getat
    HRESULT GetAt(uint index, PWSTR* name);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsomparturicollection
@GUID("57c650d4-067c-4893-8c33-f62a0633730f")
interface IXpsOMPartUriCollection : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomparturicollection-getcount
    HRESULT GetCount(uint* count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomparturicollection-getat
    HRESULT GetAt(uint index, IOpcPartUri* partUri);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomparturicollection-insertat
    HRESULT InsertAt(uint index, IOpcPartUri partUri);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomparturicollection-removeat
    HRESULT RemoveAt(uint index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomparturicollection-setat
    HRESULT SetAt(uint index, IOpcPartUri partUri);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomparturicollection-append
    HRESULT Append(IOpcPartUri partUri);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsompackagewriter
@GUID("4e2aa182-a443-42c6-b41b-4f8e9de73ff9")
interface IXpsOMPackageWriter : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompackagewriter-startnewdocument
    HRESULT StartNewDocument(IOpcPartUri documentPartName, IXpsOMPrintTicketResource documentPrintTicket, 
                             IXpsOMDocumentStructureResource documentStructure, 
                             IXpsOMSignatureBlockResourceCollection signatureBlockResources, 
                             IXpsOMPartUriCollection restrictedFonts);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompackagewriter-addpage
    HRESULT AddPage(IXpsOMPage page, const(XPS_SIZE)* advisoryPageDimensions, 
                    IXpsOMPartUriCollection discardableResourceParts, IXpsOMStoryFragmentsResource storyFragments, 
                    IXpsOMPrintTicketResource pagePrintTicket, IXpsOMImageResource pageThumbnail);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompackagewriter-addresource
    HRESULT AddResource(IXpsOMResource resource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompackagewriter-close
    HRESULT Close();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompackagewriter-isclosed
    HRESULT IsClosed(BOOL* isClosed);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsompackagetarget
@GUID("219a9db0-4959-47d0-8034-b1ce84f41a4d")
interface IXpsOMPackageTarget : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsompackagetarget-createxpsompackagewriter
    HRESULT CreateXpsOMPackageWriter(IOpcPartUri documentSequencePartName, 
                                     IXpsOMPrintTicketResource documentSequencePrintTicket, 
                                     IOpcPartUri discardControlPartName, IXpsOMPackageWriter* packageWriter);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nn-xpsobjectmodel-ixpsomthumbnailgenerator
@GUID("15b873d5-1971-41e8-83a3-6578403064c7")
interface IXpsOMThumbnailGenerator : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel/nf-xpsobjectmodel-ixpsomthumbnailgenerator-generatethumbnail
    HRESULT GenerateThumbnail(IXpsOMPage page, XPS_IMAGE_TYPE thumbnailType, XPS_THUMBNAIL_SIZE thumbnailSize, 
                              IOpcPartUri imageResourcePartName, IXpsOMImageResource* imageResource);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel_1/nn-xpsobjectmodel_1-ixpsomobjectfactory1
@GUID("0a91b617-d612-4181-bf7c-be5824e9cc8f")
interface IXpsOMObjectFactory1 : IXpsOMObjectFactory
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel_1/nf-xpsobjectmodel_1-ixpsomobjectfactory1-getdocumenttypefromfile
    HRESULT GetDocumentTypeFromFile(const(PWSTR) filename, XPS_DOCUMENT_TYPE* documentType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel_1/nf-xpsobjectmodel_1-ixpsomobjectfactory1-getdocumenttypefromstream
    HRESULT GetDocumentTypeFromStream(IStream xpsDocumentStream, XPS_DOCUMENT_TYPE* documentType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel_1/nf-xpsobjectmodel_1-ixpsomobjectfactory1-converthdphototojpegxr
    HRESULT ConvertHDPhotoToJpegXR(IXpsOMImageResource imageResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel_1/nf-xpsobjectmodel_1-ixpsomobjectfactory1-convertjpegxrtohdphoto
    HRESULT ConvertJpegXRToHDPhoto(IXpsOMImageResource imageResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel_1/nf-xpsobjectmodel_1-ixpsomobjectfactory1-createpackagewriteronfile1
    HRESULT CreatePackageWriterOnFile1(const(PWSTR) fileName, SECURITY_ATTRIBUTES* securityAttributes, 
                                       uint flagsAndAttributes, BOOL optimizeMarkupSize, 
                                       XPS_INTERLEAVING interleaving, IOpcPartUri documentSequencePartName, 
                                       IXpsOMCoreProperties coreProperties, IXpsOMImageResource packageThumbnail, 
                                       IXpsOMPrintTicketResource documentSequencePrintTicket, 
                                       IOpcPartUri discardControlPartName, XPS_DOCUMENT_TYPE documentType, 
                                       IXpsOMPackageWriter* packageWriter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel_1/nf-xpsobjectmodel_1-ixpsomobjectfactory1-createpackagewriteronstream1
    HRESULT CreatePackageWriterOnStream1(ISequentialStream outputStream, BOOL optimizeMarkupSize, 
                                         XPS_INTERLEAVING interleaving, IOpcPartUri documentSequencePartName, 
                                         IXpsOMCoreProperties coreProperties, IXpsOMImageResource packageThumbnail, 
                                         IXpsOMPrintTicketResource documentSequencePrintTicket, 
                                         IOpcPartUri discardControlPartName, XPS_DOCUMENT_TYPE documentType, 
                                         IXpsOMPackageWriter* packageWriter);
    HRESULT CreatePackage1(IXpsOMPackage1* package_);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel_1/nf-xpsobjectmodel_1-ixpsomobjectfactory1-createpackagefromstream1
    HRESULT CreatePackageFromStream1(IStream stream, BOOL reuseObjects, IXpsOMPackage1* package_);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel_1/nf-xpsobjectmodel_1-ixpsomobjectfactory1-createpackagefromfile1
    HRESULT CreatePackageFromFile1(const(PWSTR) filename, BOOL reuseObjects, IXpsOMPackage1* package_);
    HRESULT CreatePage1(const(XPS_SIZE)* pageDimensions, const(PWSTR) language, IOpcPartUri partUri, 
                        IXpsOMPage1* page);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel_1/nf-xpsobjectmodel_1-ixpsomobjectfactory1-createpagefromstream1
    HRESULT CreatePageFromStream1(IStream pageMarkupStream, IOpcPartUri partUri, IXpsOMPartResources resources, 
                                  BOOL reuseObjects, IXpsOMPage1* page);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel_1/nf-xpsobjectmodel_1-ixpsomobjectfactory1-createremotedictionaryresourcefromstream1
    HRESULT CreateRemoteDictionaryResourceFromStream1(IStream dictionaryMarkupStream, IOpcPartUri partUri, 
                                                      IXpsOMPartResources resources, 
                                                      IXpsOMRemoteDictionaryResource* dictionaryResource);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel_1/nn-xpsobjectmodel_1-ixpsompackage1
@GUID("95a9435e-12bb-461b-8e7f-c6adb04cd96a")
interface IXpsOMPackage1 : IXpsOMPackage
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel_1/nf-xpsobjectmodel_1-ixpsompackage1-getdocumenttype
    HRESULT GetDocumentType(XPS_DOCUMENT_TYPE* documentType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel_1/nf-xpsobjectmodel_1-ixpsompackage1-writetofile1
    HRESULT WriteToFile1(const(PWSTR) fileName, SECURITY_ATTRIBUTES* securityAttributes, uint flagsAndAttributes, 
                         BOOL optimizeMarkupSize, XPS_DOCUMENT_TYPE documentType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel_1/nf-xpsobjectmodel_1-ixpsompackage1-writetostream1
    HRESULT WriteToStream1(ISequentialStream outputStream, BOOL optimizeMarkupSize, XPS_DOCUMENT_TYPE documentType);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel_1/nn-xpsobjectmodel_1-ixpsompage1
@GUID("305b60ef-6892-4dda-9cbb-3aa65974508a")
interface IXpsOMPage1 : IXpsOMPage
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel_1/nf-xpsobjectmodel_1-ixpsompage1-getdocumenttype
    HRESULT GetDocumentType(XPS_DOCUMENT_TYPE* documentType);
    HRESULT Write1(ISequentialStream stream, BOOL optimizeMarkupSize, XPS_DOCUMENT_TYPE documentType);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel_1/nn-xpsobjectmodel_1-ixpsdocumentpackagetarget
@GUID("3b0b6d38-53ad-41da-b212-d37637a6714e")
interface IXpsDocumentPackageTarget : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel_1/nf-xpsobjectmodel_1-ixpsdocumentpackagetarget-getxpsompackagewriter
    HRESULT GetXpsOMPackageWriter(IOpcPartUri documentSequencePartName, IOpcPartUri discardControlPartName, 
                                  IXpsOMPackageWriter* packageWriter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel_1/nf-xpsobjectmodel_1-ixpsdocumentpackagetarget-getxpsomfactory
    HRESULT GetXpsOMFactory(IXpsOMObjectFactory* xpsFactory);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel_1/nf-xpsobjectmodel_1-ixpsdocumentpackagetarget-getxpstype
    HRESULT GetXpsType(XPS_DOCUMENT_TYPE* documentType);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel_1/nn-xpsobjectmodel_1-ixpsomremotedictionaryresource1
@GUID("bf8fc1d4-9d46-4141-ba5f-94bb9250d041")
interface IXpsOMRemoteDictionaryResource1 : IXpsOMRemoteDictionaryResource
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel_1/nf-xpsobjectmodel_1-ixpsomremotedictionaryresource1-getdocumenttype
    HRESULT GetDocumentType(XPS_DOCUMENT_TYPE* documentType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel_1/nf-xpsobjectmodel_1-ixpsomremotedictionaryresource1-write1
    HRESULT Write1(ISequentialStream stream, XPS_DOCUMENT_TYPE documentType);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel_2/nn-xpsobjectmodel_2-ixpsompackagewriter3d
@GUID("e8a45033-640e-43fa-9bdf-fddeaa31c6a0")
interface IXpsOMPackageWriter3D : IXpsOMPackageWriter
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel_2/nf-xpsobjectmodel_2-ixpsompackagewriter3d-addmodeltexture
    HRESULT AddModelTexture(IOpcPartUri texturePartName, IStream textureData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel_2/nf-xpsobjectmodel_2-ixpsompackagewriter3d-setmodelprintticket
    HRESULT SetModelPrintTicket(IOpcPartUri printTicketPartName, IStream printTicketData);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel_2/nn-xpsobjectmodel_2-ixpsdocumentpackagetarget3d
@GUID("60ba71b8-3101-4984-9199-f4ea775ff01d")
interface IXpsDocumentPackageTarget3D : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel_2/nf-xpsobjectmodel_2-ixpsdocumentpackagetarget3d-getxpsompackagewriter3d
    HRESULT GetXpsOMPackageWriter3D(IOpcPartUri documentSequencePartName, IOpcPartUri discardControlPartName, 
                                    IOpcPartUri modelPartName, IStream modelData, 
                                    IXpsOMPackageWriter3D* packageWriter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsobjectmodel_2/nf-xpsobjectmodel_2-ixpsdocumentpackagetarget3d-getxpsomfactory
    HRESULT GetXpsOMFactory(IXpsOMObjectFactory* xpsFactory);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nn-xpsdigitalsignature-ixpssigningoptions
@GUID("7718eae4-3215-49be-af5b-594fef7fcfa6")
interface IXpsSigningOptions : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssigningoptions-getsignatureid
    HRESULT GetSignatureId(PWSTR* signatureId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssigningoptions-setsignatureid
    HRESULT SetSignatureId(const(PWSTR) signatureId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssigningoptions-getsignaturemethod
    HRESULT GetSignatureMethod(PWSTR* signatureMethod);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssigningoptions-setsignaturemethod
    HRESULT SetSignatureMethod(const(PWSTR) signatureMethod);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssigningoptions-getdigestmethod
    HRESULT GetDigestMethod(PWSTR* digestMethod);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssigningoptions-setdigestmethod
    HRESULT SetDigestMethod(const(PWSTR) digestMethod);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssigningoptions-getsignaturepartname
    HRESULT GetSignaturePartName(IOpcPartUri* signaturePartName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssigningoptions-setsignaturepartname
    HRESULT SetSignaturePartName(IOpcPartUri signaturePartName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssigningoptions-getpolicy
    HRESULT GetPolicy(XPS_SIGN_POLICY* policy);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssigningoptions-setpolicy
    HRESULT SetPolicy(XPS_SIGN_POLICY policy);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssigningoptions-getsigningtimeformat
    HRESULT GetSigningTimeFormat(OPC_SIGNATURE_TIME_FORMAT* timeFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssigningoptions-setsigningtimeformat
    HRESULT SetSigningTimeFormat(OPC_SIGNATURE_TIME_FORMAT timeFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssigningoptions-getcustomobjects
    HRESULT GetCustomObjects(IOpcSignatureCustomObjectSet* customObjectSet);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssigningoptions-getcustomreferences
    HRESULT GetCustomReferences(IOpcSignatureReferenceSet* customReferenceSet);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssigningoptions-getcertificateset
    HRESULT GetCertificateSet(IOpcCertificateSet* certificateSet);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssigningoptions-getflags
    HRESULT GetFlags(XPS_SIGN_FLAGS* flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssigningoptions-setflags
    HRESULT SetFlags(XPS_SIGN_FLAGS flags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nn-xpsdigitalsignature-ixpssignaturecollection
@GUID("a2d1d95d-add2-4dff-ab27-6b9c645ff322")
interface IXpsSignatureCollection : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssignaturecollection-getcount
    HRESULT GetCount(uint* count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssignaturecollection-getat
    HRESULT GetAt(uint index, IXpsSignature* signature);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssignaturecollection-removeat
    HRESULT RemoveAt(uint index);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nn-xpsdigitalsignature-ixpssignature
@GUID("6ae4c93e-1ade-42fb-898b-3a5658284857")
interface IXpsSignature : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssignature-getsignatureid
    HRESULT GetSignatureId(PWSTR* sigId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssignature-getsignaturevalue
    HRESULT GetSignatureValue(ubyte** signatureHashValue, uint* count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssignature-getcertificateenumerator
    HRESULT GetCertificateEnumerator(IOpcCertificateEnumerator* certificateEnumerator);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssignature-getsigningtime
    HRESULT GetSigningTime(PWSTR* sigDateTimeString);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssignature-getsigningtimeformat
    HRESULT GetSigningTimeFormat(OPC_SIGNATURE_TIME_FORMAT* timeFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssignature-getsignaturepartname
    HRESULT GetSignaturePartName(IOpcPartUri* signaturePartName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssignature-verify
    HRESULT Verify(const(CERT_CONTEXT)* x509Certificate, XPS_SIGNATURE_STATUS* sigStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssignature-getpolicy
    HRESULT GetPolicy(XPS_SIGN_POLICY* policy);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssignature-getcustomobjectenumerator
    HRESULT GetCustomObjectEnumerator(IOpcSignatureCustomObjectEnumerator* customObjectEnumerator);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssignature-getcustomreferenceenumerator
    HRESULT GetCustomReferenceEnumerator(IOpcSignatureReferenceEnumerator* customReferenceEnumerator);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssignature-getsignaturexml
    HRESULT GetSignatureXml(ubyte** signatureXml, uint* count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssignature-setsignaturexml
    HRESULT SetSignatureXml(const(ubyte)* signatureXml, uint count);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nn-xpsdigitalsignature-ixpssignatureblockcollection
@GUID("23397050-fe99-467a-8dce-9237f074ffe4")
interface IXpsSignatureBlockCollection : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssignatureblockcollection-getcount
    HRESULT GetCount(uint* count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssignatureblockcollection-getat
    HRESULT GetAt(uint index, IXpsSignatureBlock* signatureBlock);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssignatureblockcollection-removeat
    HRESULT RemoveAt(uint index);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nn-xpsdigitalsignature-ixpssignatureblock
@GUID("151fac09-0b97-4ac6-a323-5e4297d4322b")
interface IXpsSignatureBlock : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssignatureblock-getrequests
    HRESULT GetRequests(IXpsSignatureRequestCollection* requests);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssignatureblock-getpartname
    HRESULT GetPartName(IOpcPartUri* partName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssignatureblock-getdocumentindex
    HRESULT GetDocumentIndex(uint* fixedDocumentIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssignatureblock-getdocumentname
    HRESULT GetDocumentName(IOpcPartUri* fixedDocumentName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssignatureblock-createrequest
    HRESULT CreateRequest(const(PWSTR) requestId, IXpsSignatureRequest* signatureRequest);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nn-xpsdigitalsignature-ixpssignaturerequestcollection
@GUID("f0253e68-9f19-412e-9b4f-54d3b0ac6cd9")
interface IXpsSignatureRequestCollection : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssignaturerequestcollection-getcount
    HRESULT GetCount(uint* count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssignaturerequestcollection-getat
    HRESULT GetAt(uint index, IXpsSignatureRequest* signatureRequest);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssignaturerequestcollection-removeat
    HRESULT RemoveAt(uint index);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nn-xpsdigitalsignature-ixpssignaturerequest
@GUID("ac58950b-7208-4b2d-b2c4-951083d3b8eb")
interface IXpsSignatureRequest : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssignaturerequest-getintent
    HRESULT GetIntent(PWSTR* intent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssignaturerequest-setintent
    HRESULT SetIntent(const(PWSTR) intent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssignaturerequest-getrequestedsigner
    HRESULT GetRequestedSigner(PWSTR* signerName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssignaturerequest-setrequestedsigner
    HRESULT SetRequestedSigner(const(PWSTR) signerName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssignaturerequest-getrequestsignbydate
    HRESULT GetRequestSignByDate(PWSTR* dateString);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssignaturerequest-setrequestsignbydate
    HRESULT SetRequestSignByDate(const(PWSTR) dateString);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssignaturerequest-getsigninglocale
    HRESULT GetSigningLocale(PWSTR* place);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssignaturerequest-setsigninglocale
    HRESULT SetSigningLocale(const(PWSTR) place);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssignaturerequest-getspotlocation
    HRESULT GetSpotLocation(int* pageIndex, IOpcPartUri* pagePartName, float* x, float* y);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssignaturerequest-setspotlocation
    HRESULT SetSpotLocation(int pageIndex, float x, float y);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssignaturerequest-getrequestid
    HRESULT GetRequestId(PWSTR* requestId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssignaturerequest-getsignature
    HRESULT GetSignature(IXpsSignature* signature);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nn-xpsdigitalsignature-ixpssignaturemanager
@GUID("d3e8d338-fdc4-4afc-80b5-d532a1782ee1")
interface IXpsSignatureManager : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssignaturemanager-loadpackagefile
    HRESULT LoadPackageFile(const(PWSTR) fileName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssignaturemanager-loadpackagestream
    HRESULT LoadPackageStream(IStream stream);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssignaturemanager-sign
    HRESULT Sign(IXpsSigningOptions signOptions, const(CERT_CONTEXT)* x509Certificate, IXpsSignature* signature);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssignaturemanager-getsignatureoriginpartname
    HRESULT GetSignatureOriginPartName(IOpcPartUri* signatureOriginPartName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssignaturemanager-setsignatureoriginpartname
    HRESULT SetSignatureOriginPartName(IOpcPartUri signatureOriginPartName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssignaturemanager-getsignatures
    HRESULT GetSignatures(IXpsSignatureCollection* signatures);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssignaturemanager-addsignatureblock
    HRESULT AddSignatureBlock(IOpcPartUri partName, uint fixedDocumentIndex, IXpsSignatureBlock* signatureBlock);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssignaturemanager-getsignatureblocks
    HRESULT GetSignatureBlocks(IXpsSignatureBlockCollection* signatureBlocks);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssignaturemanager-createsigningoptions
    HRESULT CreateSigningOptions(IXpsSigningOptions* signingOptions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssignaturemanager-savepackagetofile
    HRESULT SavePackageToFile(const(PWSTR) fileName, SECURITY_ATTRIBUTES* securityAttributes, 
                              uint flagsAndAttributes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xpsdigitalsignature/nf-xpsdigitalsignature-ixpssignaturemanager-savepackagetostream
    HRESULT SavePackageToStream(IStream stream);
}


// GUIDs

const GUID CLSID_XpsOMObjectFactory      = GUIDOF!XpsOMObjectFactory;
const GUID CLSID_XpsOMThumbnailGenerator = GUIDOF!XpsOMThumbnailGenerator;
const GUID CLSID_XpsSignatureManager     = GUIDOF!XpsSignatureManager;

const GUID IID_IXpsDocumentPackageTarget                = GUIDOF!IXpsDocumentPackageTarget;
const GUID IID_IXpsDocumentPackageTarget3D              = GUIDOF!IXpsDocumentPackageTarget3D;
const GUID IID_IXpsOMBrush                              = GUIDOF!IXpsOMBrush;
const GUID IID_IXpsOMCanvas                             = GUIDOF!IXpsOMCanvas;
const GUID IID_IXpsOMColorProfileResource               = GUIDOF!IXpsOMColorProfileResource;
const GUID IID_IXpsOMColorProfileResourceCollection     = GUIDOF!IXpsOMColorProfileResourceCollection;
const GUID IID_IXpsOMCoreProperties                     = GUIDOF!IXpsOMCoreProperties;
const GUID IID_IXpsOMDashCollection                     = GUIDOF!IXpsOMDashCollection;
const GUID IID_IXpsOMDictionary                         = GUIDOF!IXpsOMDictionary;
const GUID IID_IXpsOMDocument                           = GUIDOF!IXpsOMDocument;
const GUID IID_IXpsOMDocumentCollection                 = GUIDOF!IXpsOMDocumentCollection;
const GUID IID_IXpsOMDocumentSequence                   = GUIDOF!IXpsOMDocumentSequence;
const GUID IID_IXpsOMDocumentStructureResource          = GUIDOF!IXpsOMDocumentStructureResource;
const GUID IID_IXpsOMFontResource                       = GUIDOF!IXpsOMFontResource;
const GUID IID_IXpsOMFontResourceCollection             = GUIDOF!IXpsOMFontResourceCollection;
const GUID IID_IXpsOMGeometry                           = GUIDOF!IXpsOMGeometry;
const GUID IID_IXpsOMGeometryFigure                     = GUIDOF!IXpsOMGeometryFigure;
const GUID IID_IXpsOMGeometryFigureCollection           = GUIDOF!IXpsOMGeometryFigureCollection;
const GUID IID_IXpsOMGlyphs                             = GUIDOF!IXpsOMGlyphs;
const GUID IID_IXpsOMGlyphsEditor                       = GUIDOF!IXpsOMGlyphsEditor;
const GUID IID_IXpsOMGradientBrush                      = GUIDOF!IXpsOMGradientBrush;
const GUID IID_IXpsOMGradientStop                       = GUIDOF!IXpsOMGradientStop;
const GUID IID_IXpsOMGradientStopCollection             = GUIDOF!IXpsOMGradientStopCollection;
const GUID IID_IXpsOMImageBrush                         = GUIDOF!IXpsOMImageBrush;
const GUID IID_IXpsOMImageResource                      = GUIDOF!IXpsOMImageResource;
const GUID IID_IXpsOMImageResourceCollection            = GUIDOF!IXpsOMImageResourceCollection;
const GUID IID_IXpsOMLinearGradientBrush                = GUIDOF!IXpsOMLinearGradientBrush;
const GUID IID_IXpsOMMatrixTransform                    = GUIDOF!IXpsOMMatrixTransform;
const GUID IID_IXpsOMNameCollection                     = GUIDOF!IXpsOMNameCollection;
const GUID IID_IXpsOMObjectFactory                      = GUIDOF!IXpsOMObjectFactory;
const GUID IID_IXpsOMObjectFactory1                     = GUIDOF!IXpsOMObjectFactory1;
const GUID IID_IXpsOMPackage                            = GUIDOF!IXpsOMPackage;
const GUID IID_IXpsOMPackage1                           = GUIDOF!IXpsOMPackage1;
const GUID IID_IXpsOMPackageTarget                      = GUIDOF!IXpsOMPackageTarget;
const GUID IID_IXpsOMPackageWriter                      = GUIDOF!IXpsOMPackageWriter;
const GUID IID_IXpsOMPackageWriter3D                    = GUIDOF!IXpsOMPackageWriter3D;
const GUID IID_IXpsOMPage                               = GUIDOF!IXpsOMPage;
const GUID IID_IXpsOMPage1                              = GUIDOF!IXpsOMPage1;
const GUID IID_IXpsOMPageReference                      = GUIDOF!IXpsOMPageReference;
const GUID IID_IXpsOMPageReferenceCollection            = GUIDOF!IXpsOMPageReferenceCollection;
const GUID IID_IXpsOMPart                               = GUIDOF!IXpsOMPart;
const GUID IID_IXpsOMPartResources                      = GUIDOF!IXpsOMPartResources;
const GUID IID_IXpsOMPartUriCollection                  = GUIDOF!IXpsOMPartUriCollection;
const GUID IID_IXpsOMPath                               = GUIDOF!IXpsOMPath;
const GUID IID_IXpsOMPrintTicketResource                = GUIDOF!IXpsOMPrintTicketResource;
const GUID IID_IXpsOMRadialGradientBrush                = GUIDOF!IXpsOMRadialGradientBrush;
const GUID IID_IXpsOMRemoteDictionaryResource           = GUIDOF!IXpsOMRemoteDictionaryResource;
const GUID IID_IXpsOMRemoteDictionaryResource1          = GUIDOF!IXpsOMRemoteDictionaryResource1;
const GUID IID_IXpsOMRemoteDictionaryResourceCollection = GUIDOF!IXpsOMRemoteDictionaryResourceCollection;
const GUID IID_IXpsOMResource                           = GUIDOF!IXpsOMResource;
const GUID IID_IXpsOMShareable                          = GUIDOF!IXpsOMShareable;
const GUID IID_IXpsOMSignatureBlockResource             = GUIDOF!IXpsOMSignatureBlockResource;
const GUID IID_IXpsOMSignatureBlockResourceCollection   = GUIDOF!IXpsOMSignatureBlockResourceCollection;
const GUID IID_IXpsOMSolidColorBrush                    = GUIDOF!IXpsOMSolidColorBrush;
const GUID IID_IXpsOMStoryFragmentsResource             = GUIDOF!IXpsOMStoryFragmentsResource;
const GUID IID_IXpsOMThumbnailGenerator                 = GUIDOF!IXpsOMThumbnailGenerator;
const GUID IID_IXpsOMTileBrush                          = GUIDOF!IXpsOMTileBrush;
const GUID IID_IXpsOMVisual                             = GUIDOF!IXpsOMVisual;
const GUID IID_IXpsOMVisualBrush                        = GUIDOF!IXpsOMVisualBrush;
const GUID IID_IXpsOMVisualCollection                   = GUIDOF!IXpsOMVisualCollection;
const GUID IID_IXpsSignature                            = GUIDOF!IXpsSignature;
const GUID IID_IXpsSignatureBlock                       = GUIDOF!IXpsSignatureBlock;
const GUID IID_IXpsSignatureBlockCollection             = GUIDOF!IXpsSignatureBlockCollection;
const GUID IID_IXpsSignatureCollection                  = GUIDOF!IXpsSignatureCollection;
const GUID IID_IXpsSignatureManager                     = GUIDOF!IXpsSignatureManager;
const GUID IID_IXpsSignatureRequest                     = GUIDOF!IXpsSignatureRequest;
const GUID IID_IXpsSignatureRequestCollection           = GUIDOF!IXpsSignatureRequestCollection;
const GUID IID_IXpsSigningOptions                       = GUIDOF!IXpsSigningOptions;
