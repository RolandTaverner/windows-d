// Written in the D programming language.

module windows.data.htmlhelp;

public import windows.core;
public import windows.foundation : BOOL, COLORREF, HINSTANCE, HRESULT, HWND, POINT,
                                   PSTR, PWSTR, RECT;
public import windows.system.com : IPersistStreamInit, IStream, IUnknown;
public import windows.system.search : IStemmer;
public import windows.system.variant : VARIANT;
public import windows.ui.controls : NMHDR;

extern(Windows) @nogc nothrow:


// Enums


alias HTML_HELP_COMMAND = int;
enum : int
{
    HH_DISPLAY_TOPIC         = 0x00000000,
    HH_HELP_FINDER           = 0x00000000,
    HH_DISPLAY_TOC           = 0x00000001,
    HH_DISPLAY_INDEX         = 0x00000002,
    HH_DISPLAY_SEARCH        = 0x00000003,
    HH_SET_WIN_TYPE          = 0x00000004,
    HH_GET_WIN_TYPE          = 0x00000005,
    HH_GET_WIN_HANDLE        = 0x00000006,
    HH_ENUM_INFO_TYPE        = 0x00000007,
    HH_SET_INFO_TYPE         = 0x00000008,
    HH_SYNC                  = 0x00000009,
    HH_RESERVED1             = 0x0000000a,
    HH_RESERVED2             = 0x0000000b,
    HH_RESERVED3             = 0x0000000c,
    HH_KEYWORD_LOOKUP        = 0x0000000d,
    HH_DISPLAY_TEXT_POPUP    = 0x0000000e,
    HH_HELP_CONTEXT          = 0x0000000f,
    HH_TP_HELP_CONTEXTMENU   = 0x00000010,
    HH_TP_HELP_WM_HELP       = 0x00000011,
    HH_CLOSE_ALL             = 0x00000012,
    HH_ALINK_LOOKUP          = 0x00000013,
    HH_GET_LAST_ERROR        = 0x00000014,
    HH_ENUM_CATEGORY         = 0x00000015,
    HH_ENUM_CATEGORY_IT      = 0x00000016,
    HH_RESET_IT_FILTER       = 0x00000017,
    HH_SET_INCLUSIVE_FILTER  = 0x00000018,
    HH_SET_EXCLUSIVE_FILTER  = 0x00000019,
    HH_INITIALIZE            = 0x0000001c,
    HH_UNINITIALIZE          = 0x0000001d,
    HH_SET_QUERYSERVICE      = 0x0000001e,
    HH_PRETRANSLATEMESSAGE   = 0x000000fd,
    HH_SET_GLOBAL_PROPERTY   = 0x000000fc,
    HH_SAFE_DISPLAY_TOPIC    = 0x00000020,
    HH_MAX_TABS              = 0x00000013,
    HH_MAX_TABS_CUSTOM       = 0x00000009,
    HH_FTS_DEFAULT_PROXIMITY = 0xffffffff,
}

alias HH_GPROPID = int;
enum : int
{
    HH_GPROPID_SINGLETHREAD     = 0x00000001,
    HH_GPROPID_TOOLBAR_MARGIN   = 0x00000002,
    HH_GPROPID_UI_LANGUAGE      = 0x00000003,
    HH_GPROPID_CURRENT_SUBSET   = 0x00000004,
    HH_GPROPID_CONTENT_LANGUAGE = 0x00000005,
}

alias PRIORITY = int;
enum : int
{
    PRIORITY_LOW    = 0x00000000,
    PRIORITY_NORMAL = 0x00000001,
    PRIORITY_HIGH   = 0x00000002,
}

// Constants


enum : uint
{
    HHWIN_PROP_TAB_AUTOHIDESHOW = 0x00000001,
    HHWIN_PROP_ONTOP            = 0x00000002,
    HHWIN_PROP_NOTITLEBAR       = 0x00000004,
    HHWIN_PROP_NODEF_STYLES     = 0x00000008,
    HHWIN_PROP_NODEF_EXSTYLES   = 0x00000010,
    HHWIN_PROP_TRI_PANE         = 0x00000020,
    HHWIN_PROP_NOTB_TEXT        = 0x00000040,
    HHWIN_PROP_POST_QUIT        = 0x00000080,
    HHWIN_PROP_AUTO_SYNC        = 0x00000100,
    HHWIN_PROP_TRACKING         = 0x00000200,
    HHWIN_PROP_TAB_SEARCH       = 0x00000400,
    HHWIN_PROP_TAB_HISTORY      = 0x00000800,
    HHWIN_PROP_TAB_FAVORITES    = 0x00001000,
    HHWIN_PROP_CHANGE_TITLE     = 0x00002000,
    HHWIN_PROP_NAV_ONLY_WIN     = 0x00004000,
    HHWIN_PROP_NO_TOOLBAR       = 0x00008000,
    HHWIN_PROP_MENU             = 0x00010000,
    HHWIN_PROP_TAB_ADVSEARCH    = 0x00020000,
    HHWIN_PROP_USER_POS         = 0x00040000,
    HHWIN_PROP_TAB_CUSTOM1      = 0x00080000,
    HHWIN_PROP_TAB_CUSTOM2      = 0x00100000,
    HHWIN_PROP_TAB_CUSTOM3      = 0x00200000,
    HHWIN_PROP_TAB_CUSTOM4      = 0x00400000,
    HHWIN_PROP_TAB_CUSTOM5      = 0x00800000,
    HHWIN_PROP_TAB_CUSTOM6      = 0x01000000,
    HHWIN_PROP_TAB_CUSTOM7      = 0x02000000,
    HHWIN_PROP_TAB_CUSTOM8      = 0x04000000,
    HHWIN_PROP_TAB_CUSTOM9      = 0x08000000,
}

enum : uint
{
    HHWIN_PARAM_PROPERTIES    = 0x00000002,
    HHWIN_PARAM_STYLES        = 0x00000004,
    HHWIN_PARAM_EXSTYLES      = 0x00000008,
    HHWIN_PARAM_RECT          = 0x00000010,
    HHWIN_PARAM_NAV_WIDTH     = 0x00000020,
    HHWIN_PARAM_SHOWSTATE     = 0x00000040,
    HHWIN_PARAM_INFOTYPES     = 0x00000080,
    HHWIN_PARAM_TB_FLAGS      = 0x00000100,
    HHWIN_PARAM_EXPANSION     = 0x00000200,
    HHWIN_PARAM_TABPOS        = 0x00000400,
    HHWIN_PARAM_TABORDER      = 0x00000800,
    HHWIN_PARAM_HISTORY_COUNT = 0x00001000,
    HHWIN_PARAM_CUR_TAB       = 0x00002000,
}

enum : uint
{
    HHWIN_BUTTON_BACK       = 0x00000004,
    HHWIN_BUTTON_FORWARD    = 0x00000008,
    HHWIN_BUTTON_STOP       = 0x00000010,
    HHWIN_BUTTON_REFRESH    = 0x00000020,
    HHWIN_BUTTON_HOME       = 0x00000040,
    HHWIN_BUTTON_BROWSE_FWD = 0x00000080,
    HHWIN_BUTTON_BROWSE_BCK = 0x00000100,
    HHWIN_BUTTON_NOTES      = 0x00000200,
    HHWIN_BUTTON_CONTENTS   = 0x00000400,
    HHWIN_BUTTON_SYNC       = 0x00000800,
    HHWIN_BUTTON_OPTIONS    = 0x00001000,
    HHWIN_BUTTON_PRINT      = 0x00002000,
    HHWIN_BUTTON_INDEX      = 0x00004000,
    HHWIN_BUTTON_SEARCH     = 0x00008000,
    HHWIN_BUTTON_HISTORY    = 0x00010000,
    HHWIN_BUTTON_FAVORITES  = 0x00020000,
    HHWIN_BUTTON_JUMP1      = 0x00040000,
    HHWIN_BUTTON_JUMP2      = 0x00080000,
    HHWIN_BUTTON_ZOOM       = 0x00100000,
    HHWIN_BUTTON_TOC_NEXT   = 0x00200000,
    HHWIN_BUTTON_TOC_PREV   = 0x00400000,
}

enum uint IDTB_CONTRACT = 0x000000c9;

enum : uint
{
    IDTB_REFRESH     = 0x000000cb,
    IDTB_BACK        = 0x000000cc,
    IDTB_HOME        = 0x000000cd,
    IDTB_SYNC        = 0x000000ce,
    IDTB_PRINT       = 0x000000cf,
    IDTB_OPTIONS     = 0x000000d0,
    IDTB_FORWARD     = 0x000000d1,
    IDTB_NOTES       = 0x000000d2,
    IDTB_BROWSE_FWD  = 0x000000d3,
    IDTB_BROWSE_BACK = 0x000000d4,
}

enum : uint
{
    IDTB_INDEX     = 0x000000d6,
    IDTB_SEARCH    = 0x000000d7,
    IDTB_HISTORY   = 0x000000d8,
    IDTB_FAVORITES = 0x000000d9,
}

enum : uint
{
    IDTB_JUMP2     = 0x000000db,
    IDTB_CUSTOMIZE = 0x000000dd,
}

enum : uint
{
    IDTB_TOC_NEXT = 0x000000df,
    IDTB_TOC_PREV = 0x000000e0,
}

enum : uint
{
    HHN_LAST        = 0xfffffc91,
    HHN_NAVCOMPLETE = 0xfffffca4,
}

enum uint HHN_WINDOW_CREATE = 0xfffffca2;

enum : uint
{
    PROP_ADD    = 0x00000000,
    PROP_DELETE = 0x00000001,
    PROP_UPDATE = 0x00000002,
}

enum : uint
{
    TYPE_POINTER = 0x00000001,
    TYPE_STRING  = 0x00000002,
}

enum /*FIELD ATTR: GuidAttribute : CustomAttributeSig([FixedArgSig(ElementSig(1180883625)), FixedArgSig(ElementSig(54163)), FixedArgSig(ElementSig(4560)), FixedArgSig(ElementSig(154)), FixedArgSig(ElementSig(86)), FixedArgSig(ElementSig(0)), FixedArgSig(ElementSig(192)), FixedArgSig(ElementSig(79)), FixedArgSig(ElementSig(182)), FixedArgSig(ElementSig(139)), FixedArgSig(ElementSig(247))], [])*/GUID CLSID_IITDatabaseLocal = /*FIELD ATTR: GuidAttribute : CustomAttributeSig([FixedArgSig(ElementSig(1180883625)), FixedArgSig(ElementSig(54163)), FixedArgSig(ElementSig(4560)), FixedArgSig(ElementSig(154)), FixedArgSig(ElementSig(86)), FixedArgSig(ElementSig(0)), FixedArgSig(ElementSig(192)), FixedArgSig(ElementSig(79)), FixedArgSig(ElementSig(182)), FixedArgSig(ElementSig(139)), FixedArgSig(ElementSig(247))], [])*/GUID(