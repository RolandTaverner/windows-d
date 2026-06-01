// Written in the D programming language.

module windows.win32.data.htmlhelp;

public import windows.core;
public import system.system : Guid;
public import windows.win32.foundation.foundation : BOOL, COLORREF, HINSTANCE, HRESULT,
                                                    HWND, POINT, PSTR, PWSTR, RECT;
public import windows.win32.system.com.com : IPersistStreamInit, IStream, IUnknown;
public import windows.win32.system.search.search : IStemmer;
public import windows.win32.system.variant : VARIANT;
public import windows.win32.ui.controls.controls : NMHDR;

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
    HHWIN_PROP_TAB_AUTOHIDESHOW = 0x00000001U,
    HHWIN_PROP_ONTOP            = 0x00000002U,
    HHWIN_PROP_NOTITLEBAR       = 0x00000004U,
    HHWIN_PROP_NODEF_STYLES     = 0x00000008U,
    HHWIN_PROP_NODEF_EXSTYLES   = 0x00000010U,
    HHWIN_PROP_TRI_PANE         = 0x00000020U,
    HHWIN_PROP_NOTB_TEXT        = 0x00000040U,
    HHWIN_PROP_POST_QUIT        = 0x00000080U,
    HHWIN_PROP_AUTO_SYNC        = 0x00000100U,
    HHWIN_PROP_TRACKING         = 0x00000200U,
    HHWIN_PROP_TAB_SEARCH       = 0x00000400U,
    HHWIN_PROP_TAB_HISTORY      = 0x00000800U,
    HHWIN_PROP_TAB_FAVORITES    = 0x00001000U,
    HHWIN_PROP_CHANGE_TITLE     = 0x00002000U,
    HHWIN_PROP_NAV_ONLY_WIN     = 0x00004000U,
    HHWIN_PROP_NO_TOOLBAR       = 0x00008000U,
    HHWIN_PROP_MENU             = 0x00010000U,
    HHWIN_PROP_TAB_ADVSEARCH    = 0x00020000U,
    HHWIN_PROP_USER_POS         = 0x00040000U,
    HHWIN_PROP_TAB_CUSTOM1      = 0x00080000U,
    HHWIN_PROP_TAB_CUSTOM2      = 0x00100000U,
    HHWIN_PROP_TAB_CUSTOM3      = 0x00200000U,
    HHWIN_PROP_TAB_CUSTOM4      = 0x00400000U,
    HHWIN_PROP_TAB_CUSTOM5      = 0x00800000U,
    HHWIN_PROP_TAB_CUSTOM6      = 0x01000000U,
    HHWIN_PROP_TAB_CUSTOM7      = 0x02000000U,
    HHWIN_PROP_TAB_CUSTOM8      = 0x04000000U,
    HHWIN_PROP_TAB_CUSTOM9      = 0x08000000U,
}

enum uint HHWIN_TB_MARGIN = 0x10000000U;

enum : uint
{
    HHWIN_PARAM_PROPERTIES    = 0x00000002U,
    HHWIN_PARAM_STYLES        = 0x00000004U,
    HHWIN_PARAM_EXSTYLES      = 0x00000008U,
    HHWIN_PARAM_RECT          = 0x00000010U,
    HHWIN_PARAM_NAV_WIDTH     = 0x00000020U,
    HHWIN_PARAM_SHOWSTATE     = 0x00000040U,
    HHWIN_PARAM_INFOTYPES     = 0x00000080U,
    HHWIN_PARAM_TB_FLAGS      = 0x00000100U,
    HHWIN_PARAM_EXPANSION     = 0x00000200U,
    HHWIN_PARAM_TABPOS        = 0x00000400U,
    HHWIN_PARAM_TABORDER      = 0x00000800U,
    HHWIN_PARAM_HISTORY_COUNT = 0x00001000U,
    HHWIN_PARAM_CUR_TAB       = 0x00002000U,
}

enum : uint
{
    HHWIN_BUTTON_EXPAND     = 0x00000002U,
    HHWIN_BUTTON_BACK       = 0x00000004U,
    HHWIN_BUTTON_FORWARD    = 0x00000008U,
    HHWIN_BUTTON_STOP       = 0x00000010U,
    HHWIN_BUTTON_REFRESH    = 0x00000020U,
    HHWIN_BUTTON_HOME       = 0x00000040U,
    HHWIN_BUTTON_BROWSE_FWD = 0x00000080U,
    HHWIN_BUTTON_BROWSE_BCK = 0x00000100U,
    HHWIN_BUTTON_NOTES      = 0x00000200U,
    HHWIN_BUTTON_CONTENTS   = 0x00000400U,
    HHWIN_BUTTON_SYNC       = 0x00000800U,
    HHWIN_BUTTON_OPTIONS    = 0x00001000U,
    HHWIN_BUTTON_PRINT      = 0x00002000U,
    HHWIN_BUTTON_INDEX      = 0x00004000U,
    HHWIN_BUTTON_SEARCH     = 0x00008000U,
    HHWIN_BUTTON_HISTORY    = 0x00010000U,
    HHWIN_BUTTON_FAVORITES  = 0x00020000U,
    HHWIN_BUTTON_JUMP1      = 0x00040000U,
    HHWIN_BUTTON_JUMP2      = 0x00080000U,
    HHWIN_BUTTON_ZOOM       = 0x00100000U,
    HHWIN_BUTTON_TOC_NEXT   = 0x00200000U,
    HHWIN_BUTTON_TOC_PREV   = 0x00400000U,
}

enum : uint
{
    IDTB_EXPAND   = 0x000000c8U,
    IDTB_CONTRACT = 0x000000c9U,
}

enum : uint
{
    IDTB_STOP        = 0x000000caU,
    IDTB_REFRESH     = 0x000000cbU,
    IDTB_BACK        = 0x000000ccU,
    IDTB_HOME        = 0x000000cdU,
    IDTB_SYNC        = 0x000000ceU,
    IDTB_PRINT       = 0x000000cfU,
    IDTB_OPTIONS     = 0x000000d0U,
    IDTB_FORWARD     = 0x000000d1U,
    IDTB_NOTES       = 0x000000d2U,
    IDTB_BROWSE_FWD  = 0x000000d3U,
    IDTB_BROWSE_BACK = 0x000000d4U,
}

enum uint IDTB_CONTENTS = 0x000000d5U;

enum : uint
{
    IDTB_INDEX     = 0x000000d6U,
    IDTB_SEARCH    = 0x000000d7U,
    IDTB_HISTORY   = 0x000000d8U,
    IDTB_FAVORITES = 0x000000d9U,
}

enum : uint
{
    IDTB_JUMP1     = 0x000000daU,
    IDTB_JUMP2     = 0x000000dbU,
    IDTB_CUSTOMIZE = 0x000000ddU,
}

enum : uint
{
    IDTB_ZOOM     = 0x000000deU,
    IDTB_TOC_NEXT = 0x000000dfU,
    IDTB_TOC_PREV = 0x000000e0U,
}

enum : uint
{
    HHN_FIRST       = 0xfffffca4U,
    HHN_LAST        = 0xfffffc91U,
    HHN_NAVCOMPLETE = 0xfffffca4U,
}

enum : uint
{
    HHN_TRACK         = 0xfffffca3U,
    HHN_WINDOW_CREATE = 0xfffffca2U,
}

enum GUID CLSID_IITPropList = GUID("4662daae-d393-11d0-9a56-00c04fb68bf7");

enum : uint
{
    PROP_ADD    = 0x00000000U,
    PROP_DELETE = 0x00000001U,
    PROP_UPDATE = 0x00000002U,
}

enum : uint
{
    TYPE_VALUE   = 0x00000000U,
    TYPE_POINTER = 0x00000001U,
    TYPE_STRING  = 0x00000002U,
}

enum : GUID
{
    CLSID_IITDatabase      = GUID("66673452-8c23-11d0-a84e-00aa006c7d01"),
    CLSID_IITDatabaseLocal = GUID("4662daa9-d393-11d0-9a56-00c04fb68bf7"),
}

enum : uint
{
    STDPROP_UID                   = 0x00000001U,
    STDPROP_TITLE                 = 0x00000002U,
    STDPROP_USERDATA              = 0x00000003U,
    STDPROP_KEY                   = 0x00000004U,
    STDPROP_SORTKEY               = 0x00000064U,
    STDPROP_DISPLAYKEY            = 0x00000065U,
    STDPROP_SORTORDINAL           = 0x00000066U,
    STDPROP_INDEX_TEXT            = 0x000000c8U,
    STDPROP_INDEX_VFLD            = 0x000000c9U,
    STDPROP_INDEX_DTYPE           = 0x000000caU,
    STDPROP_INDEX_LENGTH          = 0x000000cbU,
    STDPROP_INDEX_BREAK           = 0x000000ccU,
    STDPROP_INDEX_TERM            = 0x000000d2U,
    STDPROP_INDEX_TERM_RAW_LENGTH = 0x000000d3U,
}

enum : uint
{
    STDPROP_USERPROP_BASE = 0x00010000U,
    STDPROP_USERPROP_MAX  = 0x7fffffffU,
}

enum : const(wchar)*
{
    SZ_WWDEST_GLOBAL = "GLOBAL",
    SZ_WWDEST_KEY    = "KEY",
    SZ_WWDEST_OCC    = "OCC",
}

enum : GUID
{
    CLSID_IITCmdInt          = GUID("4662daa2-d393-11d0-9a56-00c04fb68bf7"),
    CLSID_IITSvMgr           = GUID("4662daa3-d393-11d0-9a56-00c04fb68bf7"),
    CLSID_IITWordWheelUpdate = GUID("4662daa5-d393-11d0-9a56-00c04fb68bf7"),
}

enum : GUID
{
    CLSID_IITGroupUpdate    = GUID("4662daa4-d393-11d0-9a56-00c04fb68bf7"),
    CLSID_IITIndexBuild     = GUID("8fa0d5aa-dedf-11d0-9a61-00c04fb68bf7"),
    CLSID_IITWWFilterBuild  = GUID("8fa0d5ab-dedf-11d0-9a61-00c04fb68bf7"),
    CLSID_IITWordWheel      = GUID("d73725c2-8c12-11d0-a84e-00aa006c7d01"),
    CLSID_IITWordWheelLocal = GUID("4662daa8-d393-11d0-9a56-00c04fb68bf7"),
}

enum uint ITWW_OPEN_NOCONNECT = 0x00000001U;
enum uint ITWW_CBKEY_MAX = 0x00000400U;

enum : uint
{
    IITWBC_BREAK_ACCEPT_WILDCARDS = 0x00000001U,
    IITWBC_BREAK_AND_STEM         = 0x00000002U,
}

enum HRESULT E_NOTEXIST = HRESULT(0x80001000);
enum HRESULT E_DUPLICATE = HRESULT(0x80001001);

enum : HRESULT
{
    E_BADVERSION = HRESULT(0x80001002),
    E_BADFILE    = HRESULT(0x80001003),
    E_BADFORMAT  = HRESULT(0x80001004),
}

enum HRESULT E_NOPERMISSION = HRESULT(0x80001005);
enum HRESULT E_ASSERT = HRESULT(0x80001006);
enum HRESULT E_INTERRUPT = HRESULT(0x80001007);
enum HRESULT E_NOTSUPPORTED = HRESULT(0x80001008);
enum HRESULT E_OUTOFRANGE = HRESULT(0x80001009);
enum HRESULT E_GROUPIDTOOBIG = HRESULT(0x8000100a);
enum HRESULT E_TOOMANYTITLES = HRESULT(0x8000100b);
enum HRESULT E_NOMERGEDDATA = HRESULT(0x8000100c);
enum HRESULT E_NOTFOUND = HRESULT(0x8000100d);
enum HRESULT E_CANTFINDDLL = HRESULT(0x8000100e);
enum HRESULT E_NOHANDLE = HRESULT(0x8000100f);
enum HRESULT E_GETLASTERROR = HRESULT(0x80001010);
enum HRESULT E_BADPARAM = HRESULT(0x80001011);
enum HRESULT E_INVALIDSTATE = HRESULT(0x80001012);
enum HRESULT E_NOTOPEN = HRESULT(0x80001013);
enum HRESULT E_ALREADYOPEN = HRESULT(0x80001013);
enum HRESULT E_UNKNOWN_TRANSPORT = HRESULT(0x80001016);
enum HRESULT E_UNSUPPORTED_TRANSPORT = HRESULT(0x80001017);
enum HRESULT E_BADFILTERSIZE = HRESULT(0x80001018);
enum HRESULT E_TOOMANYOBJECTS = HRESULT(0x80001019);
enum HRESULT E_NAMETOOLONG = HRESULT(0x80001020);

enum : HRESULT
{
    E_FILECREATE   = HRESULT(0x80001030),
    E_FILECLOSE    = HRESULT(0x80001031),
    E_FILEREAD     = HRESULT(0x80001032),
    E_FILESEEK     = HRESULT(0x80001033),
    E_FILEWRITE    = HRESULT(0x80001034),
    E_FILEDELETE   = HRESULT(0x80001035),
    E_FILEINVALID  = HRESULT(0x80001036),
    E_FILENOTFOUND = HRESULT(0x80001037),
}

enum HRESULT E_DISKFULL = HRESULT(0x80001038);

enum : HRESULT
{
    E_TOOMANYTOPICS = HRESULT(0x80001050),
    E_TOOMANYDUPS   = HRESULT(0x80001051),
}

enum HRESULT E_TREETOOBIG = HRESULT(0x80001052);

enum : HRESULT
{
    E_BADBREAKER = HRESULT(0x80001053),
    E_BADVALUE   = HRESULT(0x80001054),
}

enum HRESULT E_ALL_WILD = HRESULT(0x80001055);
enum HRESULT E_TOODEEP = HRESULT(0x80001056);
enum HRESULT E_EXPECTEDTERM = HRESULT(0x80001057);

enum : HRESULT
{
    E_MISSLPAREN = HRESULT(0x80001058),
    E_MISSRPAREN = HRESULT(0x80001059),
    E_MISSQUOTE  = HRESULT(0x8000105a),
}

enum HRESULT E_NULLQUERY = HRESULT(0x8000105b);
enum HRESULT E_STOPWORD = HRESULT(0x8000105c);
enum HRESULT E_BADRANGEOP = HRESULT(0x8000105d);
enum HRESULT E_UNMATCHEDTYPE = HRESULT(0x8000105e);
enum HRESULT E_WORDTOOLONG = HRESULT(0x8000105f);
enum HRESULT E_BADINDEXFLAGS = HRESULT(0x80001060);
enum HRESULT E_WILD_IN_DTYPE = HRESULT(0x80001061);
enum HRESULT E_NOSTEMMER = HRESULT(0x80001062);
enum HRESULT E_MISSINGPROP = HRESULT(0x80001080);

enum : HRESULT
{
    E_PROPLISTNOTEMPTY = HRESULT(0x80001081),
    E_PROPLISTEMPTY    = HRESULT(0x80001082),
}

enum HRESULT E_ALREADYINIT = HRESULT(0x80001083);
enum HRESULT E_NOTINIT = HRESULT(0x80001084);
enum HRESULT E_RESULTSETEMPTY = HRESULT(0x80001085);
enum HRESULT E_TOOMANYCOLUMNS = HRESULT(0x80001086);
enum HRESULT E_NOKEYPROP = HRESULT(0x80001087);
enum GUID CLSID_IITResultSet = GUID("4662daa7-d393-11d0-9a56-00c04fb68bf7");
enum uint MAX_COLUMNS = 0x00000100U;

enum : GUID
{
    CLSID_ITStdBreaker = GUID("4662daaf-d393-11d0-9a56-00c04fb68bf7"),
    CLSID_ITEngStemmer = GUID("8fa0d5a8-dedf-11d0-9a61-00c04fb68bf7"),
}

enum : int
{
    HHWIN_NAVTYPE_TOC          = 0x00000000,
    HHWIN_NAVTYPE_INDEX        = 0x00000001,
    HHWIN_NAVTYPE_SEARCH       = 0x00000002,
    HHWIN_NAVTYPE_FAVORITES    = 0x00000003,
    HHWIN_NAVTYPE_HISTORY      = 0x00000004,
    HHWIN_NAVTYPE_AUTHOR       = 0x00000005,
    HHWIN_NAVTYPE_CUSTOM_FIRST = 0x0000000b,
}

enum int IT_INCLUSIVE = 0x00000000;
enum int IT_EXCLUSIVE = 0x00000001;
enum int IT_HIDDEN = 0x00000002;

enum : int
{
    HHWIN_NAVTAB_TOP    = 0x00000000,
    HHWIN_NAVTAB_LEFT   = 0x00000001,
    HHWIN_NAVTAB_BOTTOM = 0x00000002,
}

enum : int
{
    HH_TAB_CONTENTS     = 0x00000000,
    HH_TAB_INDEX        = 0x00000001,
    HH_TAB_SEARCH       = 0x00000002,
    HH_TAB_FAVORITES    = 0x00000003,
    HH_TAB_HISTORY      = 0x00000004,
    HH_TAB_AUTHOR       = 0x00000005,
    HH_TAB_CUSTOM_FIRST = 0x0000000b,
    HH_TAB_CUSTOM_LAST  = 0x00000013,
}

enum : int
{
    HHACT_TAB_CONTENTS  = 0x00000000,
    HHACT_TAB_INDEX     = 0x00000001,
    HHACT_TAB_SEARCH    = 0x00000002,
    HHACT_TAB_HISTORY   = 0x00000003,
    HHACT_TAB_FAVORITES = 0x00000004,
}

enum : int
{
    HHACT_EXPAND    = 0x00000005,
    HHACT_CONTRACT  = 0x00000006,
    HHACT_BACK      = 0x00000007,
    HHACT_FORWARD   = 0x00000008,
    HHACT_STOP      = 0x00000009,
    HHACT_REFRESH   = 0x0000000a,
    HHACT_HOME      = 0x0000000b,
    HHACT_SYNC      = 0x0000000c,
    HHACT_OPTIONS   = 0x0000000d,
    HHACT_PRINT     = 0x0000000e,
    HHACT_HIGHLIGHT = 0x0000000f,
}

enum int HHACT_CUSTOMIZE = 0x00000010;

enum : int
{
    HHACT_JUMP1     = 0x00000011,
    HHACT_JUMP2     = 0x00000012,
    HHACT_ZOOM      = 0x00000013,
    HHACT_TOC_NEXT  = 0x00000014,
    HHACT_TOC_PREV  = 0x00000015,
    HHACT_NOTES     = 0x00000016,
    HHACT_LAST_ENUM = 0x00000017,
}

// Callbacks

alias PFNCOLHEAPFREE = int function(void* param0);

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/htmlhelp/ns-htmlhelp-hhn_notify
struct HHN_NOTIFY
{
    NMHDR       hdr;
    const(PSTR) pszUrl;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/htmlhelp/ns-htmlhelp-hh_popup
struct HH_POPUP
{
    int       cbStruct;
    HINSTANCE hinst;
    uint      idString;
    byte*     pszText;
    POINT     pt;
    COLORREF  clrForeground;
    COLORREF  clrBackground;
    RECT      rcMargins;
    byte*     pszFont;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/htmlhelp/ns-htmlhelp-hh_aklink
struct HH_AKLINK
{
    int   cbStruct;
    BOOL  fReserved;
    byte* pszKeywords;
    byte* pszUrl;
    byte* pszMsgText;
    byte* pszMsgTitle;
    byte* pszWindow;
    BOOL  fIndexOnFail;
}

struct HH_ENUM_IT
{
    int         cbStruct;
    int         iType;
    const(PSTR) pszCatName;
    const(PSTR) pszITName;
    const(PSTR) pszITDescription;
}

struct HH_ENUM_CAT
{
    int         cbStruct;
    const(PSTR) pszCatName;
    const(PSTR) pszCatDescription;
}

struct HH_SET_INFOTYPE
{
    int         cbStruct;
    const(PSTR) pszCatName;
    const(PSTR) pszInfoTypeName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/htmlhelp/ns-htmlhelp-hh_fts_query
struct HH_FTS_QUERY
{
    int   cbStruct;
    BOOL  fUniCodeStrings;
    byte* pszSearchQuery;
    int   iProximity;
    BOOL  fStemmedSearch;
    BOOL  fTitleOnly;
    BOOL  fExecute;
    byte* pszWindow;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/htmlhelp/ns-htmlhelp-hh_wintype
struct HH_WINTYPE
{
    int       cbStruct;
    BOOL      fUniCodeStrings;
    byte*     pszType;
    uint      fsValidMembers;
    uint      fsWinProperties;
    byte*     pszCaption;
    uint      dwStyles;
    uint      dwExStyles;
    RECT      rcWindowPos;
    int       nShowState;
    HWND      hwndHelp;
    HWND      hwndCaller;
    uint*     paInfoTypes;
    HWND      hwndToolBar;
    HWND      hwndNavigation;
    HWND      hwndHTML;
    int       iNavWidth;
    RECT      rcHTML;
    byte*     pszToc;
    byte*     pszIndex;
    byte*     pszFile;
    byte*     pszHome;
    uint      fsToolBarFlags;
    BOOL      fNotExpanded;
    int       curNavType;
    int       tabpos;
    int       idNotify;
    ubyte[20] tabOrder;
    int       cHistory;
    byte*     pszJump1;
    byte*     pszJump2;
    byte*     pszUrlJump1;
    byte*     pszUrlJump2;
    RECT      rcMinSize;
    int       cbInfoTypes;
    byte*     pszCustomTabs;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/htmlhelp/ns-htmlhelp-hhntrack
struct HHNTRACK
{
    NMHDR       hdr;
    const(PSTR) pszCurUrl;
    int         idAction;
    HH_WINTYPE* phhWinType;
}

struct HH_GLOBAL_PROPERTY
{
    HH_GPROPID id;
    VARIANT    var;
}

struct CProperty
{
    uint dwPropID;
    uint cbData;
    uint dwType;
    union
    {
        PWSTR lpszwData;
        void* lpvData;
        uint  dwValue;
    }
    BOOL fPersist;
}

struct ROWSTATUS
{
    int lRowFirst;
    int cRows;
    int cProperties;
    int cRowsTotal;
}

struct COLUMNSTATUS
{
    int cPropCount;
    int cPropsLoaded;
}

// Functions

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("hhctrl.ocx")
HWND HtmlHelpA(HWND hwndCaller, const(PSTR) pszFile, 
               /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(HTML_HELP_COMMAND))], [])*/uint uCommand, 
               size_t dwData);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("hhctrl.ocx")
HWND HtmlHelpW(HWND hwndCaller, const(PWSTR) pszFile, 
               /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(HTML_HELP_COMMAND))], [])*/uint uCommand, 
               size_t dwData);


// Interfaces

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/infotech/nn-infotech-iitproplist
@GUID("1f403bb1-9997-11d0-a850-00aa006c7d01")
interface IITPropList : IPersistStreamInit
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/infotech/nf-infotech-iitproplist-set(propid_lpvoid_dword_dword)
    HRESULT Set(uint PropID, const(PWSTR) lpszwString, uint dwOperation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/infotech/nf-infotech-iitproplist-set(propid_lpvoid_dword_dword)
    HRESULT Set(uint PropID, void* lpvData, uint cbData, uint dwOperation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/infotech/nf-infotech-iitproplist-set(propid_lpvoid_dword_dword)
    HRESULT Set(uint PropID, uint dwData, uint dwOperation);
    HRESULT Add(CProperty* Prop);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/infotech/nf-infotech-iitproplist-get
    HRESULT Get(uint PropID, CProperty* Property);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/infotech/nf-infotech-iitproplist-clear
    HRESULT Clear();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/infotech/nf-infotech-iitproplist-setpersist(propid_bool)
    HRESULT SetPersist(BOOL fPersist);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/infotech/nf-infotech-iitproplist-setpersist(propid_bool)
    HRESULT SetPersist(uint PropID, BOOL fPersist);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/infotech/nf-infotech-iitproplist-getfirst
    HRESULT GetFirst(CProperty* Property);
    HRESULT GetNext(CProperty* Property);
    HRESULT GetPropCount(int* cProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/infotech/nf-infotech-iitproplist-saveheader
    HRESULT SaveHeader(void* lpvData, uint dwHdrSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/infotech/nf-infotech-iitproplist-savedata
    HRESULT SaveData(void* lpvHeader, uint dwHdrSize, void* lpvData, uint dwBufSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/infotech/nf-infotech-iitproplist-getheadersize
    HRESULT GetHeaderSize(uint* dwHdrSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/infotech/nf-infotech-iitproplist-getdatasize
    HRESULT GetDataSize(void* lpvHeader, uint dwHdrSize, uint* dwDataSize);
    HRESULT SaveDataToStream(void* lpvHeader, uint dwHdrSize, IStream pStream);
    HRESULT LoadFromMem(void* lpvData, uint dwBufSize);
    HRESULT SaveToMem(void* lpvData, uint dwBufSize);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/infotech/nn-infotech-iitdatabase
@GUID("8fa0d5a2-dedf-11d0-9a61-00c04fb68bf7")
interface IITDatabase : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/infotech/nf-infotech-iitdatabase-open
    HRESULT Open(const(PWSTR) lpszHost, const(PWSTR) lpszMoniker, uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/infotech/nf-infotech-iitdatabase-close
    HRESULT Close();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/infotech/nf-infotech-iitdatabase-createobject
    HRESULT CreateObject(const(GUID)* rclsid, uint* pdwObjInstance);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/infotech/nf-infotech-iitdatabase-getobject
    HRESULT GetObject(uint dwObjInstance, const(GUID)* riid, void** ppvObj);
    HRESULT GetObjectPersistence(const(PWSTR) lpwszObject, uint dwObjInstance, void** ppvPersistence, BOOL fStream);
}

@GUID("fe77c330-7f42-11ce-be57-00aa0051fe20")
interface IStemSink : IUnknown
{
    HRESULT PutAltWord(const(PWSTR) pwcInBuf, uint cwc);
    HRESULT PutWord(const(PWSTR) pwcInBuf, uint cwc);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/infotech/nn-infotech-istemmerconfig
@GUID("8fa0d5a7-dedf-11d0-9a61-00c04fb68bf7")
interface IStemmerConfig : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/infotech/nf-infotech-istemmerconfig-setlocaleinfo
    HRESULT SetLocaleInfo(uint dwCodePageID, uint lcid);
    HRESULT GetLocaleInfo(uint* pdwCodePageID, uint* plcid);
    HRESULT SetControlInfo(uint grfStemFlags, uint dwReserved);
    HRESULT GetControlInfo(uint* pgrfStemFlags, uint* pdwReserved);
    HRESULT LoadExternalStemmerData(IStream pStream, uint dwExtDataType);
}

@GUID("8fa0d5a6-dedf-11d0-9a61-00c04fb68bf7")
interface IWordBreakerConfig : IUnknown
{
    HRESULT SetLocaleInfo(uint dwCodePageID, uint lcid);
    HRESULT GetLocaleInfo(uint* pdwCodePageID, uint* plcid);
    HRESULT SetBreakWordType(uint dwBreakWordType);
    HRESULT GetBreakWordType(uint* pdwBreakWordType);
    HRESULT SetControlInfo(uint grfBreakFlags, uint dwReserved);
    HRESULT GetControlInfo(uint* pgrfBreakFlags, uint* pdwReserved);
    HRESULT LoadExternalBreakerData(IStream pStream, uint dwExtDataType);
    HRESULT SetWordStemmer(const(GUID)* rclsid, IStemmer pStemmer);
    HRESULT GetWordStemmer(IStemmer* ppStemmer);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/infotech/nn-infotech-iitresultset
@GUID("3bb91d41-998b-11d0-a850-00aa006c7d01")
interface IITResultSet : IUnknown
{
    HRESULT SetColumnPriority(int lColumnIndex, PRIORITY ColumnPriority);
    HRESULT SetColumnHeap(int lColumnIndex, void* lpvHeap, PFNCOLHEAPFREE pfnColHeapFree);
    HRESULT SetKeyProp(uint PropID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/infotech/nf-infotech-iitresultset-add(propid_lpvoid_dword_priority)
    HRESULT Add(uint PropID, uint dwDefaultData, PRIORITY Priority);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/infotech/nf-infotech-iitresultset-add(propid_lpvoid_dword_priority)
    HRESULT Add(uint PropID, const(PWSTR) lpszwDefault, PRIORITY Priority);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/infotech/nf-infotech-iitresultset-add(propid_lpvoid_dword_priority)
    HRESULT Add(uint PropID, void* lpvDefaultData, uint cbData, PRIORITY Priority);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/infotech/nf-infotech-iitresultset-add(propid_lpvoid_dword_priority)
    HRESULT Add(void* lpvHdr);
    HRESULT Append(void* lpvHdr, void* lpvData);
    HRESULT Set(int lRowIndex, int lColumnIndex, void* lpvData, uint cbData);
    HRESULT Set(int lRowIndex, int lColumnIndex, const(PWSTR) lpwStr);
    HRESULT Set(int lRowIndex, int lColumnIndex, size_t dwData);
    HRESULT Set(int lRowIndex, void* lpvHdr, void* lpvData);
    HRESULT Copy(IITResultSet pRSCopy);
    HRESULT AppendRows(IITResultSet pResSrc, int lRowSrcFirst, int cSrcRows, int* lRowFirstDest);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/infotech/nf-infotech-iitresultset-get
    HRESULT Get(int lRowIndex, int lColumnIndex, CProperty* Prop);
    HRESULT GetKeyProp(uint* KeyPropID);
    HRESULT GetColumnPriority(int lColumnIndex, PRIORITY* ColumnPriority);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/infotech/nf-infotech-iitresultset-getrowcount
    HRESULT GetRowCount(int* lNumberOfRows);
    HRESULT GetColumnCount(int* lNumberOfColumns);
    HRESULT GetColumn(int lColumnIndex, uint* PropID, uint* dwType, void** lpvDefaultValue, uint* cbSize, 
                      PRIORITY* ColumnPriority);
    HRESULT GetColumn(int lColumnIndex, uint* PropID);
    HRESULT GetColumnFromPropID(uint PropID, int* lColumnIndex);
    HRESULT Clear();
    HRESULT ClearRows();
    HRESULT Free();
    HRESULT IsCompleted();
    HRESULT Cancel();
    HRESULT Pause(BOOL fPause);
    HRESULT GetRowStatus(int lRowFirst, int cRows, ROWSTATUS* lpRowStatus);
    HRESULT GetColumnStatus(COLUMNSTATUS* lpColStatus);
}


// GUIDs


const GUID IID_IITDatabase        = GUIDOF!IITDatabase;
const GUID IID_IITPropList        = GUIDOF!IITPropList;
const GUID IID_IITResultSet       = GUIDOF!IITResultSet;
const GUID IID_IStemSink          = GUIDOF!IStemSink;
const GUID IID_IStemmerConfig     = GUIDOF!IStemmerConfig;
const GUID IID_IWordBreakerConfig = GUIDOF!IWordBreakerConfig;
