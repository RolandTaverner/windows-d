// Written in the D programming language.

module windows.win32.system.mmc;

public import windows.core;
public import system.system : Guid;
public import windows.win32.foundation.foundation : BOOL, BSTR, COLORREF, HRESULT, HWND,
                                                    LPARAM, LRESULT, PWSTR, VARIANT_BOOL;
public import windows.win32.graphics.gdi : HBITMAP, HPALETTE;
public import windows.win32.system.com.com : IDataObject, IDispatch, IEnumString, IUnknown;
public import windows.win32.system.variant : VARIANT;
public import windows.win32.ui.controls.controls : HPROPSHEETPAGE;
public import windows.win32.ui.windowsandmessaging : HICON;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmcobj/ne-mmcobj-mmc_property_action
alias MMC_PROPERTY_ACTION = int;
enum : int
{
    MMC_PROPACT_DELETING    = 0x00000001,
    MMC_PROPACT_CHANGING    = 0x00000002,
    MMC_PROPACT_INITIALIZED = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmcobj/ne-mmcobj-_documentmode
alias _DocumentMode = int;
enum : int
{
    DocumentMode_Author   = 0x00000000,
    DocumentMode_User     = 0x00000001,
    DocumentMode_User_MDI = 0x00000002,
    DocumentMode_User_SDI = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmcobj/ne-mmcobj-_listviewmode
alias _ListViewMode = int;
enum : int
{
    ListMode_Small_Icons = 0x00000000,
    ListMode_Large_Icons = 0x00000001,
    ListMode_List        = 0x00000002,
    ListMode_Detail      = 0x00000003,
    ListMode_Filtered    = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmcobj/ne-mmcobj-_viewoptions
alias _ViewOptions = int;
enum : int
{
    ViewOption_Default          = 0x00000000,
    ViewOption_ScopeTreeHidden  = 0x00000001,
    ViewOption_NoToolBars       = 0x00000002,
    ViewOption_NotPersistable   = 0x00000004,
    ViewOption_ActionPaneHidden = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmcobj/ne-mmcobj-_exportlistoptions
alias _ExportListOptions = int;
enum : int
{
    ExportListOptions_Default           = 0x00000000,
    ExportListOptions_Unicode           = 0x00000001,
    ExportListOptions_TabDelimited      = 0x00000002,
    ExportListOptions_SelectedItemsOnly = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmcobj/ne-mmcobj-_columnsortorder
alias _ColumnSortOrder = int;
enum : int
{
    SortOrder_Ascending  = 0x00000000,
    SortOrder_Descending = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/ne-mmc-mmc_result_view_style
alias MMC_RESULT_VIEW_STYLE = int;
enum : int
{
    MMC_SINGLESEL          = 0x00000001,
    MMC_SHOWSELALWAYS      = 0x00000002,
    MMC_NOSORTHEADER       = 0x00000004,
    MMC_ENSUREFOCUSVISIBLE = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/ne-mmc-mmc_control_type
alias MMC_CONTROL_TYPE = int;
enum : int
{
    TOOLBAR     = 0x00000000,
    MENUBUTTON  = 0x00000001,
    COMBOBOXBAR = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/ne-mmc-mmc_console_verb
alias MMC_CONSOLE_VERB = int;
enum : int
{
    MMC_VERB_NONE       = 0x00000000,
    MMC_VERB_OPEN       = 0x00008000,
    MMC_VERB_COPY       = 0x00008001,
    MMC_VERB_PASTE      = 0x00008002,
    MMC_VERB_DELETE     = 0x00008003,
    MMC_VERB_PROPERTIES = 0x00008004,
    MMC_VERB_RENAME     = 0x00008005,
    MMC_VERB_REFRESH    = 0x00008006,
    MMC_VERB_PRINT      = 0x00008007,
    MMC_VERB_CUT        = 0x00008008,
    MMC_VERB_MAX        = 0x00008009,
    MMC_VERB_FIRST      = 0x00008000,
    MMC_VERB_LAST       = 0x00008008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/ne-mmc-mmc_button_state
alias MMC_BUTTON_STATE = int;
enum : int
{
    ENABLED       = 0x00000001,
    CHECKED       = 0x00000002,
    HIDDEN        = 0x00000004,
    INDETERMINATE = 0x00000008,
    BUTTONPRESSED = 0x00000010,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/ne-mmc-mmc_scope_item_state
alias MMC_SCOPE_ITEM_STATE = int;
enum : int
{
    MMC_SCOPE_ITEM_STATE_NORMAL       = 0x00000001,
    MMC_SCOPE_ITEM_STATE_BOLD         = 0x00000002,
    MMC_SCOPE_ITEM_STATE_EXPANDEDONCE = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/ne-mmc-mmc_menu_command_ids
alias MMC_MENU_COMMAND_IDS = int;
enum : int
{
    MMCC_STANDARD_VIEW_SELECT = 0xffffffff,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/ne-mmc-mmc_filter_type
alias MMC_FILTER_TYPE = int;
enum : int
{
    MMC_STRING_FILTER  = 0x00000000,
    MMC_INT_FILTER     = 0x00000001,
    MMC_FILTER_NOVALUE = 0x00008000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/ne-mmc-mmc_filter_change_code
alias MMC_FILTER_CHANGE_CODE = int;
enum : int
{
    MFCC_DISABLE      = 0x00000000,
    MFCC_ENABLE       = 0x00000001,
    MFCC_VALUE_CHANGE = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/ne-mmc-mmc_notify_type
alias MMC_NOTIFY_TYPE = int;
enum : int
{
    MMCN_ACTIVATE           = 0x00008001,
    MMCN_ADD_IMAGES         = 0x00008002,
    MMCN_BTN_CLICK          = 0x00008003,
    MMCN_CLICK              = 0x00008004,
    MMCN_COLUMN_CLICK       = 0x00008005,
    MMCN_CONTEXTMENU        = 0x00008006,
    MMCN_CUTORMOVE          = 0x00008007,
    MMCN_DBLCLICK           = 0x00008008,
    MMCN_DELETE             = 0x00008009,
    MMCN_DESELECT_ALL       = 0x0000800a,
    MMCN_EXPAND             = 0x0000800b,
    MMCN_HELP               = 0x0000800c,
    MMCN_MENU_BTNCLICK      = 0x0000800d,
    MMCN_MINIMIZED          = 0x0000800e,
    MMCN_PASTE              = 0x0000800f,
    MMCN_PROPERTY_CHANGE    = 0x00008010,
    MMCN_QUERY_PASTE        = 0x00008011,
    MMCN_REFRESH            = 0x00008012,
    MMCN_REMOVE_CHILDREN    = 0x00008013,
    MMCN_RENAME             = 0x00008014,
    MMCN_SELECT             = 0x00008015,
    MMCN_SHOW               = 0x00008016,
    MMCN_VIEW_CHANGE        = 0x00008017,
    MMCN_SNAPINHELP         = 0x00008018,
    MMCN_CONTEXTHELP        = 0x00008019,
    MMCN_INITOCX            = 0x0000801a,
    MMCN_FILTER_CHANGE      = 0x0000801b,
    MMCN_FILTERBTN_CLICK    = 0x0000801c,
    MMCN_RESTORE_VIEW       = 0x0000801d,
    MMCN_PRINT              = 0x0000801e,
    MMCN_PRELOAD            = 0x0000801f,
    MMCN_LISTPAD            = 0x00008020,
    MMCN_EXPANDSYNC         = 0x00008021,
    MMCN_COLUMNS_CHANGED    = 0x00008022,
    MMCN_CANPASTE_OUTOFPROC = 0x00008023,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/ne-mmc-data_object_types
alias DATA_OBJECT_TYPES = int;
enum : int
{
    CCT_SCOPE          = 0x00008000,
    CCT_RESULT         = 0x00008001,
    CCT_SNAPIN_MANAGER = 0x00008002,
    CCT_UNINITIALIZED  = 0x0000ffff,
}

alias CCM_INSERTIONPOINTID = int;
enum : int
{
    CCM_INSERTIONPOINTID_MASK_SPECIAL        = 0xffff0000,
    CCM_INSERTIONPOINTID_MASK_SHARED         = 0x80000000,
    CCM_INSERTIONPOINTID_MASK_CREATE_PRIMARY = 0x40000000,
    CCM_INSERTIONPOINTID_MASK_ADD_PRIMARY    = 0x20000000,
    CCM_INSERTIONPOINTID_MASK_ADD_3RDPARTY   = 0x10000000,
    CCM_INSERTIONPOINTID_MASK_RESERVED       = 0x0fff0000,
    CCM_INSERTIONPOINTID_MASK_FLAGINDEX      = 0x0000001f,
    CCM_INSERTIONPOINTID_PRIMARY_TOP         = 0xa0000000,
    CCM_INSERTIONPOINTID_PRIMARY_NEW         = 0xa0000001,
    CCM_INSERTIONPOINTID_PRIMARY_TASK        = 0xa0000002,
    CCM_INSERTIONPOINTID_PRIMARY_VIEW        = 0xa0000003,
    CCM_INSERTIONPOINTID_PRIMARY_HELP        = 0xa0000004,
    CCM_INSERTIONPOINTID_3RDPARTY_NEW        = 0x90000001,
    CCM_INSERTIONPOINTID_3RDPARTY_TASK       = 0x90000002,
    CCM_INSERTIONPOINTID_ROOT_MENU           = 0x80000000,
}

alias CCM_INSERTIONALLOWED = int;
enum : int
{
    CCM_INSERTIONALLOWED_TOP  = 0x00000001,
    CCM_INSERTIONALLOWED_NEW  = 0x00000002,
    CCM_INSERTIONALLOWED_TASK = 0x00000004,
    CCM_INSERTIONALLOWED_VIEW = 0x00000008,
}

alias CCM_COMMANDID_MASK_CONSTANTS = uint;
enum : uint
{
    CCM_COMMANDID_MASK_RESERVED = 0xffff0000U,
}

alias CCM_SPECIAL = int;
enum : int
{
    CCM_SPECIAL_SEPARATOR       = 0x00000001,
    CCM_SPECIAL_SUBMENU         = 0x00000002,
    CCM_SPECIAL_DEFAULT_ITEM    = 0x00000004,
    CCM_SPECIAL_INSERTION_POINT = 0x00000008,
    CCM_SPECIAL_TESTONLY        = 0x00000010,
    CCM_SPECIAL_ELEVATION_ICON  = 0x00000020,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/ne-mmc-mmc_task_display_type
alias MMC_TASK_DISPLAY_TYPE = int;
enum : int
{
    MMC_TASK_DISPLAY_UNINITIALIZED      = 0x00000000,
    MMC_TASK_DISPLAY_TYPE_SYMBOL        = 0x00000001,
    MMC_TASK_DISPLAY_TYPE_VANILLA_GIF   = 0x00000002,
    MMC_TASK_DISPLAY_TYPE_CHOCOLATE_GIF = 0x00000003,
    MMC_TASK_DISPLAY_TYPE_BITMAP        = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/ne-mmc-mmc_action_type
alias MMC_ACTION_TYPE = int;
enum : int
{
    MMC_ACTION_UNINITIALIZED = 0xffffffff,
    MMC_ACTION_ID            = 0x00000000,
    MMC_ACTION_LINK          = 0x00000001,
    MMC_ACTION_SCRIPT        = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/ne-mmc-iconidentifier
enum IconIdentifier : int
{
    Icon_None        = 0x00000000,
    Icon_Error       = 0x00007f01,
    Icon_Question    = 0x00007f02,
    Icon_Warning     = 0x00007f03,
    Icon_Information = 0x00007f04,
    Icon_First       = 0x00007f01,
    Icon_Last        = 0x00007f04,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/ne-mmc-mmc_view_type
alias MMC_VIEW_TYPE = int;
enum : int
{
    MMC_VIEW_TYPE_LIST = 0x00000000,
    MMC_VIEW_TYPE_HTML = 0x00000001,
    MMC_VIEW_TYPE_OCX  = 0x00000002,
}

// Constants


enum : uint
{
    MMC_VER                  = 0x00000200U,
    MMC_PROP_CHANGEAFFECTSUI = 0x00000001U,
}

enum : uint
{
    MMC_PROP_MODIFIABLE = 0x00000002U,
    MMC_PROP_REMOVABLE  = 0x00000004U,
    MMC_PROP_PERSIST    = 0x00000008U,
}

enum : int
{
    MMCLV_AUTO    = 0xffffffff,
    MMCLV_NOPARAM = 0xfffffffe,
    MMCLV_NOICON  = 0xffffffff,
}

enum : uint
{
    MMCLV_VIEWSTYLE_ICON      = 0x00000000U,
    MMCLV_VIEWSTYLE_SMALLICON = 0x00000002U,
    MMCLV_VIEWSTYLE_LIST      = 0x00000003U,
    MMCLV_VIEWSTYLE_REPORT    = 0x00000001U,
    MMCLV_VIEWSTYLE_FILTERED  = 0x00000004U,
}

enum : uint
{
    MMCLV_NOPTR                  = 0x00000000U,
    MMCLV_UPDATE_NOINVALIDATEALL = 0x00000001U,
    MMCLV_UPDATE_NOSCROLL        = 0x00000002U,
}

enum int MMC_IMAGECALLBACK = 0xffffffff;

enum : uint
{
    RDI_STR    = 0x00000002U,
    RDI_IMAGE  = 0x00000004U,
    RDI_STATE  = 0x00000008U,
    RDI_PARAM  = 0x00000010U,
    RDI_INDEX  = 0x00000020U,
    RDI_INDENT = 0x00000040U,
}

enum : uint
{
    MMC_VIEW_OPTIONS_NONE                          = 0x00000000U,
    MMC_VIEW_OPTIONS_NOLISTVIEWS                   = 0x00000001U,
    MMC_VIEW_OPTIONS_MULTISELECT                   = 0x00000002U,
    MMC_VIEW_OPTIONS_OWNERDATALIST                 = 0x00000004U,
    MMC_VIEW_OPTIONS_FILTERED                      = 0x00000008U,
    MMC_VIEW_OPTIONS_CREATENEW                     = 0x00000010U,
    MMC_VIEW_OPTIONS_USEFONTLINKING                = 0x00000020U,
    MMC_VIEW_OPTIONS_EXCLUDE_SCOPE_ITEMS_FROM_LIST = 0x00000040U,
}

enum uint MMC_VIEW_OPTIONS_LEXICAL_SORT = 0x00000080U;

enum : uint
{
    MMC_PSO_NOAPPLYNOW    = 0x00000001U,
    MMC_PSO_HASHELP       = 0x00000002U,
    MMC_PSO_NEWWIZARDTYPE = 0x00000004U,
    MMC_PSO_NO_PROPTITLE  = 0x00000008U,
}

enum uint RFI_PARTIAL = 0x00000001U;
enum uint RFI_WRAP = 0x00000002U;
enum uint RSI_DESCENDING = 0x00000001U;
enum uint RSI_NOSORTICON = 0x00000002U;

enum : uint
{
    SDI_STR       = 0x00000002U,
    SDI_IMAGE     = 0x00000004U,
    SDI_OPENIMAGE = 0x00000008U,
}

enum : uint
{
    SDI_STATE    = 0x00000010U,
    SDI_PARAM    = 0x00000020U,
    SDI_CHILDREN = 0x00000040U,
}

enum : uint
{
    SDI_PARENT   = 0x00000000U,
    SDI_PREVIOUS = 0x10000000U,
}

enum : uint
{
    SDI_NEXT  = 0x20000000U,
    SDI_FIRST = 0x08000000U,
}

enum int MMC_MULTI_SELECT_COOKIE = 0xfffffffe;
enum int MMC_WINDOW_COOKIE = 0xfffffffd;

enum : int
{
    SPECIAL_COOKIE_MIN = 0xfffffff6,
    SPECIAL_COOKIE_MAX = 0xffffffff,
}

enum : uint
{
    MMC_NW_OPTION_NONE         = 0x00000000U,
    MMC_NW_OPTION_NOSCOPEPANE  = 0x00000001U,
    MMC_NW_OPTION_NOTOOLBARS   = 0x00000002U,
    MMC_NW_OPTION_SHORTTITLE   = 0x00000004U,
    MMC_NW_OPTION_CUSTOMTITLE  = 0x00000008U,
    MMC_NW_OPTION_NOPERSIST    = 0x00000010U,
    MMC_NW_OPTION_NOACTIONPANE = 0x00000020U,
}

enum uint MMC_NODEID_SLOW_RETRIEVAL = 0x00000001U;
enum int SPECIAL_DOBJ_MIN = 0xfffffff6;
enum uint SPECIAL_DOBJ_MAX = 0x00000000U;
enum int AUTO_WIDTH = 0xffffffff;
enum int HIDE_COLUMN = 0xfffffffc;

enum : uint
{
    ILSIF_LEAVE_LARGE_ICON = 0x40000000U,
    ILSIF_LEAVE_SMALL_ICON = 0x20000000U,
}

enum uint HDI_HIDDEN = 0x00000001U;
enum uint RDCI_ScopeItem = 0x80000000U;
enum uint RVTI_MISC_OPTIONS_NOLISTVIEWS = 0x00000001U;

enum : uint
{
    RVTI_LIST_OPTIONS_NONE                          = 0x00000000U,
    RVTI_LIST_OPTIONS_OWNERDATALIST                 = 0x00000002U,
    RVTI_LIST_OPTIONS_MULTISELECT                   = 0x00000004U,
    RVTI_LIST_OPTIONS_FILTERED                      = 0x00000008U,
    RVTI_LIST_OPTIONS_USEFONTLINKING                = 0x00000020U,
    RVTI_LIST_OPTIONS_EXCLUDE_SCOPE_ITEMS_FROM_LIST = 0x00000040U,
}

enum : uint
{
    RVTI_LIST_OPTIONS_LEXICAL_SORT = 0x00000080U,
    RVTI_LIST_OPTIONS_ALLOWPASTE   = 0x00000100U,
}

enum : uint
{
    RVTI_HTML_OPTIONS_NONE       = 0x00000000U,
    RVTI_HTML_OPTIONS_NOLISTVIEW = 0x00000001U,
}

enum : uint
{
    RVTI_OCX_OPTIONS_NONE       = 0x00000000U,
    RVTI_OCX_OPTIONS_NOLISTVIEW = 0x00000001U,
    RVTI_OCX_OPTIONS_CACHE_OCX  = 0x00000002U,
}

enum uint MMC_DEFAULT_OPERATION_COPY = 0x00000001U;

enum : uint
{
    MMC_ITEM_OVERLAY_STATE_MASK  = 0x00000f00U,
    MMC_ITEM_OVERLAY_STATE_SHIFT = 0x00000008U,
}

enum uint MMC_ITEM_STATE_MASK = 0x000000ffU;

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmcobj/ns-mmcobj-mmc_snapin_property
struct MMC_SNAPIN_PROPERTY
{
    const(PWSTR)        pszPropName;
    VARIANT             varValue;
    MMC_PROPERTY_ACTION eAction;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/ns-mmc-mmcbutton
struct MMCBUTTON
{
    int   nBitmap;
    int   idCommand;
    ubyte fsState;
    ubyte fsType;
    PWSTR lpButtonText;
    PWSTR lpTooltipText;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/ns-mmc-resultdataitem
struct RESULTDATAITEM
{
    uint      mask;
    BOOL      bScopeItem;
    ptrdiff_t itemID;
    int       nIndex;
    int       nCol;
    PWSTR     str;
    int       nImage;
    uint      nState;
    LPARAM    lParam;
    int       iIndent;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/ns-mmc-resultfindinfo
struct RESULTFINDINFO
{
    PWSTR psz;
    int   nStart;
    uint  dwOptions;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/ns-mmc-scopedataitem
struct SCOPEDATAITEM
{
    uint      mask;
    PWSTR     displayname;
    int       nImage;
    int       nOpenImage;
    uint      nState;
    int       cChildren;
    LPARAM    lParam;
    ptrdiff_t relativeID;
    ptrdiff_t ID;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/ns-mmc-contextmenuitem
struct CONTEXTMENUITEM
{
    PWSTR strName;
    PWSTR strStatusBarText;
    int   lCommandID;
    int   lInsertionPointID;
    int   fFlags;
    int   fSpecialFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/ns-mmc-menubuttondata
struct MENUBUTTONDATA
{
    int idCommand;
    int x;
    int y;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/ns-mmc-mmc_filterdata
struct MMC_FILTERDATA
{
    PWSTR pszText;
    int   cchTextMax;
    int   lValue;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/ns-mmc-mmc_restore_view
struct MMC_RESTORE_VIEW
{
    uint      dwSize;
    ptrdiff_t cookie;
    PWSTR     pViewType;
    int       lViewOptions;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/ns-mmc-mmc_expandsync_struct
struct MMC_EXPANDSYNC_STRUCT
{
    BOOL      bHandled;
    BOOL      bExpanding;
    ptrdiff_t hItem;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/ns-mmc-mmc_visible_columns
struct MMC_VISIBLE_COLUMNS
{
    int nVisibleColumns;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/int[1] rgVisibleCols;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/ns-mmc-smmcdataobjects
struct SMMCDataObjects
{
    uint count;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/IDataObject[1] lpDataObject;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/ns-mmc-smmcobjecttypes
struct SMMCObjectTypes
{
    uint count;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/GUID[1] guid;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/ns-mmc-snodeid
struct SNodeID
{
    uint cBytes;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] id;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/ns-mmc-snodeid2
struct SNodeID2
{
    uint dwFlags;
    uint cBytes;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] id;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/ns-mmc-scolumnsetid
struct SColumnSetID
{
    uint dwFlags;
    uint cBytes;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] id;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/ns-mmc-mmc_task_display_symbol
struct MMC_TASK_DISPLAY_SYMBOL
{
    PWSTR szFontFamilyName;
    PWSTR szURLtoEOT;
    PWSTR szSymbolString;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/ns-mmc-mmc_task_display_bitmap
struct MMC_TASK_DISPLAY_BITMAP
{
    PWSTR szMouseOverBitmap;
    PWSTR szMouseOffBitmap;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/ns-mmc-mmc_task_display_object
struct MMC_TASK_DISPLAY_OBJECT
{
    MMC_TASK_DISPLAY_TYPE eDisplayType;
    union
    {
        MMC_TASK_DISPLAY_BITMAP uBitmap;
        MMC_TASK_DISPLAY_SYMBOL uSymbol;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/ns-mmc-mmc_task
struct MMC_TASK
{
    MMC_TASK_DISPLAY_OBJECT sDisplayObject;
    PWSTR           szText;
    PWSTR           szHelpString;
    MMC_ACTION_TYPE eActionType;
    union
    {
        ptrdiff_t nCommandID;
        PWSTR     szActionURL;
        PWSTR     szScript;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/ns-mmc-mmc_listpad_info
struct MMC_LISTPAD_INFO
{
    PWSTR     szTitle;
    PWSTR     szButtonText;
    ptrdiff_t nCommandID;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/ns-mmc-mmc_column_data
struct MMC_COLUMN_DATA
{
    int    nColIndex;
    uint   dwFlags;
    int    nWidth;
    size_t ulReserved;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/ns-mmc-mmc_column_set_data
struct MMC_COLUMN_SET_DATA
{
    int              cbSize;
    int              nNumCols;
    MMC_COLUMN_DATA* pColData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/ns-mmc-mmc_sort_data
struct MMC_SORT_DATA
{
    int    nColIndex;
    uint   dwSortOptions;
    size_t ulReserved;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/ns-mmc-mmc_sort_set_data
struct MMC_SORT_SET_DATA
{
    int            cbSize;
    int            nNumItems;
    MMC_SORT_DATA* pSortData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/ns-mmc-rditemhdr
struct RDITEMHDR
{
    uint      dwFlags;
    ptrdiff_t cookie;
    LPARAM    lpReserved;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/ns-mmc-rdcompare
struct RDCOMPARE
{
    uint       cbSize;
    uint       dwFlags;
    int        nColumn;
    LPARAM     lUserParam;
    RDITEMHDR* prdch1;
    RDITEMHDR* prdch2;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/ns-mmc-result_view_type_info
struct RESULT_VIEW_TYPE_INFO
{
    PWSTR         pstrPersistableViewDescription;
    MMC_VIEW_TYPE eViewType;
    uint          dwMiscOptions;
    union
    {
        uint dwListOptions;
        struct
        {
            uint  dwHTMLOptions;
            PWSTR pstrURL;
        }
        struct
        {
            uint     dwOCXOptions;
            IUnknown pUnkControl;
        }
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/ns-mmc-contextmenuitem2
struct CONTEXTMENUITEM2
{
    PWSTR strName;
    PWSTR strStatusBarText;
    int   lCommandID;
    int   lInsertionPointID;
    int   fFlags;
    int   fSpecialFlags;
    PWSTR strLanguageIndependentName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/ns-mmc-mmc_ext_view_data
struct MMC_EXT_VIEW_DATA
{
    GUID         viewID;
    const(PWSTR) pszURL;
    const(PWSTR) pszViewTitle;
    const(PWSTR) pszTooltipText;
    BOOL         bReplacesDefaultView;
}

// Interfaces

// Microsoft documentation: https://learn.microsoft.com/windows/win32/windowsribbon/windowsribbon-element-application
@GUID("49b2791a-b1ae-4c90-9b8e-e860ba07f889")
struct Application;

@GUID("ade6444b-c91f-4e37-92a4-5bb430a33340")
struct AppEventsDHTMLConnector;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nn-mmc-immcversioninfo
@GUID("d6fedb1d-cf21-4bd9-af3b-c5468e9c6684")
struct MMCVersionInfo;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nn-mmc-iconsolepower
@GUID("f0285374-dff1-11d3-b433-00c04f8ecd78")
struct ConsolePower;

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmcobj/nn-mmcobj-isnapinproperties
@GUID("f7889da9-4a02-4837-bf89-1a6f2a021010")
interface ISnapinProperties : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmcobj/nf-mmcobj-isnapinproperties-initialize
    HRESULT Initialize(Properties pProperties);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmcobj/nf-mmcobj-isnapinproperties-querypropertynames
    HRESULT QueryPropertyNames(ISnapinPropertiesCallback pCallback);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmcobj/nf-mmcobj-isnapinproperties-propertieschanged
    HRESULT PropertiesChanged(int cProperties, MMC_SNAPIN_PROPERTY* pProperties);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmcobj/nn-mmcobj-isnapinpropertiescallback
@GUID("a50fa2e5-7e61-45eb-a8d4-9a07b3e851a8")
interface ISnapinPropertiesCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmcobj/nf-mmcobj-isnapinpropertiescallback-addpropertyname
    HRESULT AddPropertyName(const(PWSTR) pszPropName, uint dwFlags);
}

@GUID("a3afb9cc-b653-4741-86ab-f0470ec1384c")
interface _Application : IDispatch
{
    void    Help();
    void    Quit();
    HRESULT get_Document(Document* Document);
    HRESULT Load(BSTR Filename);
    HRESULT get_Frame(Frame* Frame);
    HRESULT get_Visible(BOOL* Visible);
    HRESULT Show();
    HRESULT Hide();
    HRESULT get_UserControl(BOOL* UserControl);
    HRESULT put_UserControl(BOOL UserControl);
    HRESULT get_VersionMajor(int* VersionMajor);
    HRESULT get_VersionMinor(int* VersionMinor);
}

@GUID("de46cbdd-53f5-4635-af54-4fe71e923d3f")
interface _AppEvents : IDispatch
{
    HRESULT OnQuit(_Application Application);
    HRESULT OnDocumentOpen(Document Document, BOOL New);
    HRESULT OnDocumentClose(Document Document);
    HRESULT OnSnapInAdded(Document Document, SnapIn SnapIn);
    HRESULT OnSnapInRemoved(Document Document, SnapIn SnapIn);
    HRESULT OnNewView(View View);
    HRESULT OnViewClose(View View);
    HRESULT OnViewChange(View View, Node NewOwnerNode);
    HRESULT OnSelectionChange(View View, Nodes NewNodes);
    HRESULT OnContextMenuExecuted(MenuItem MenuItem);
    HRESULT OnToolbarButtonClicked();
    HRESULT OnListUpdated(View View);
}

@GUID("fc7a4252-78ac-4532-8c5a-563cfe138863")
interface AppEvents : IDispatch
{
}

@GUID("c0bccd30-de44-4528-8403-a05a6a1cc8ea")
interface _EventConnector : IDispatch
{
    HRESULT ConnectTo(_Application Application);
    HRESULT Disconnect();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/medfound/framerateconverter
@GUID("e5e2d970-5bb3-4306-8804-b0968a31c8e6")
interface Frame : IDispatch
{
    HRESULT Maximize();
    HRESULT Minimize();
    HRESULT Restore();
    HRESULT get_Top(int* Top);
    HRESULT put_Top(int top);
    HRESULT get_Bottom(int* Bottom);
    HRESULT put_Bottom(int bottom);
    HRESULT get_Left(int* Left);
    HRESULT put_Left(int left);
    HRESULT get_Right(int* Right);
    HRESULT put_Right(int right);
}

@GUID("f81ed800-7839-4447-945d-8e15da59ca55")
interface Node : IDispatch
{
    HRESULT get_Name(BSTR* Name);
    HRESULT get_Property(BSTR PropertyName, BSTR* PropertyValue);
    HRESULT get_Bookmark(BSTR* Bookmark);
    HRESULT IsScopeNode(BOOL* IsScopeNode);
    HRESULT get_Nodetype(BSTR* Nodetype);
}

@GUID("ebbb48dc-1a3b-4d86-b786-c21b28389012")
interface ScopeNamespace : IDispatch
{
    HRESULT GetParent(Node Node, Node* Parent);
    HRESULT GetChild(Node Node, Node* Child);
    HRESULT GetNext(Node Node, Node* Next);
    HRESULT GetRoot(Node* Root);
    HRESULT Expand(Node Node);
}

@GUID("225120d6-1e0f-40a3-93fe-1079e6a8017b")
interface Document : IDispatch
{
    HRESULT Save();
    HRESULT SaveAs(BSTR Filename);
    HRESULT Close(BOOL SaveChanges);
    HRESULT get_Views(Views* Views);
    HRESULT get_SnapIns(SnapIns* SnapIns);
    HRESULT get_ActiveView(View* View);
    HRESULT get_Name(BSTR* Name);
    HRESULT put_Name(BSTR Name);
    HRESULT get_Location(BSTR* Location);
    HRESULT get_IsSaved(BOOL* IsSaved);
    HRESULT get_Mode(_DocumentMode* Mode);
    HRESULT put_Mode(_DocumentMode Mode);
    HRESULT get_RootNode(Node* Node);
    HRESULT get_ScopeNamespace(ScopeNamespace* ScopeNamespace);
    HRESULT CreateProperties(Properties* Properties);
    HRESULT get_Application(_Application* Application);
}

@GUID("3be910f6-3459-49c6-a1bb-41e6be9df3ea")
interface SnapIn : IDispatch
{
    HRESULT get_Name(BSTR* Name);
    HRESULT get_Vendor(BSTR* Vendor);
    HRESULT get_Version(BSTR* Version);
    HRESULT get_Extensions(Extensions* Extensions);
    HRESULT get_SnapinCLSID(BSTR* SnapinCLSID);
    HRESULT get_Properties(Properties* Properties);
    HRESULT EnableAllExtensions(BOOL Enable);
}

@GUID("2ef3de1d-b12a-49d1-92c5-0b00798768f1")
interface SnapIns : IDispatch
{
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Item(int Index, SnapIn* SnapIn);
    HRESULT get_Count(int* Count);
    HRESULT Add(BSTR SnapinNameOrCLSID, VARIANT ParentSnapin, VARIANT Properties, SnapIn* SnapIn);
    HRESULT Remove(SnapIn SnapIn);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/SecCrypto/extension
@GUID("ad4d6ca6-912f-409b-a26e-7fd234aef542")
interface Extension : IDispatch
{
    HRESULT get_Name(BSTR* Name);
    HRESULT get_Vendor(BSTR* Vendor);
    HRESULT get_Version(BSTR* Version);
    HRESULT get_Extensions(Extensions* Extensions);
    HRESULT get_SnapinCLSID(BSTR* SnapinCLSID);
    HRESULT EnableAllExtensions(BOOL Enable);
    HRESULT Enable(BOOL Enable);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/SecCertEnroll/extensions
@GUID("82dbea43-8ca4-44bc-a2ca-d18741059ec8")
interface Extensions : IDispatch
{
    HRESULT get__NewEnum(IUnknown* retval);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/SecCrypto/extensions-item
    HRESULT Item(int Index, Extension* Extension);
    HRESULT get_Count(int* Count);
}

@GUID("383d4d97-fc44-478b-b139-6323dc48611c")
interface Columns : IDispatch
{
    HRESULT Item(int Index, Column* Column);
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IUnknown* retval);
}

@GUID("fd1c5f63-2b16-4d06-9ab3-f45350b940ab")
interface Column : IDispatch
{
    HRESULT Name(BSTR* Name);
    HRESULT get_Width(int* Width);
    HRESULT put_Width(int Width);
    HRESULT get_DisplayPosition(int* DisplayPosition);
    HRESULT put_DisplayPosition(int Index);
    HRESULT get_Hidden(BOOL* Hidden);
    HRESULT put_Hidden(BOOL Hidden);
    HRESULT SetAsSortColumn(_ColumnSortOrder SortOrder);
    HRESULT IsSortColumn(BOOL* IsSortColumn);
}

@GUID("d6b8c29d-a1ff-4d72-aab0-e381e9b9338d")
interface Views : IDispatch
{
    HRESULT Item(int Index, View* View);
    HRESULT get_Count(int* Count);
    HRESULT Add(Node Node, _ViewOptions viewOptions);
    HRESULT get__NewEnum(IUnknown* retval);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/Msi/view-object
@GUID("6efc2da2-b38c-457e-9abb-ed2d189b8c38")
interface View : IDispatch
{
    HRESULT get_ActiveScopeNode(Node* Node);
    HRESULT put_ActiveScopeNode(Node Node);
    HRESULT get_Selection(Nodes* Nodes);
    HRESULT get_ListItems(Nodes* Nodes);
    HRESULT SnapinScopeObject(VARIANT ScopeNode, IDispatch* ScopeNodeObject);
    HRESULT SnapinSelectionObject(IDispatch* SelectionObject);
    HRESULT Is(View View, VARIANT_BOOL* TheSame);
    HRESULT get_Document(Document* Document);
    HRESULT SelectAll();
    HRESULT Select(Node Node);
    HRESULT Deselect(Node Node);
    HRESULT IsSelected(Node Node, BOOL* IsSelected);
    HRESULT DisplayScopeNodePropertySheet(VARIANT ScopeNode);
    HRESULT DisplaySelectionPropertySheet();
    HRESULT CopyScopeNode(VARIANT ScopeNode);
    HRESULT CopySelection();
    HRESULT DeleteScopeNode(VARIANT ScopeNode);
    HRESULT DeleteSelection();
    HRESULT RenameScopeNode(BSTR NewName, VARIANT ScopeNode);
    HRESULT RenameSelectedItem(BSTR NewName);
    HRESULT get_ScopeNodeContextMenu(VARIANT ScopeNode, ContextMenu* ContextMenu);
    HRESULT get_SelectionContextMenu(ContextMenu* ContextMenu);
    HRESULT RefreshScopeNode(VARIANT ScopeNode);
    HRESULT RefreshSelection();
    HRESULT ExecuteSelectionMenuItem(BSTR MenuItemPath);
    HRESULT ExecuteScopeNodeMenuItem(BSTR MenuItemPath, VARIANT ScopeNode);
    HRESULT ExecuteShellCommand(BSTR Command, BSTR Directory, BSTR Parameters, BSTR WindowState);
    HRESULT get_Frame(Frame* Frame);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Msi/view-close
    HRESULT Close();
    HRESULT get_ScopeTreeVisible(BOOL* Visible);
    HRESULT put_ScopeTreeVisible(BOOL Visible);
    HRESULT Back();
    HRESULT Forward();
    HRESULT put_StatusBarText(BSTR StatusBarText);
    HRESULT get_Memento(BSTR* Memento);
    HRESULT ViewMemento(BSTR Memento);
    HRESULT get_Columns(Columns* Columns);
    HRESULT get_CellContents(Node Node, int Column, BSTR* CellContents);
    HRESULT ExportList(BSTR File, _ExportListOptions exportoptions);
    HRESULT get_ListViewMode(_ListViewMode* Mode);
    HRESULT put_ListViewMode(_ListViewMode mode);
    HRESULT get_ControlObject(IDispatch* Control);
}

@GUID("313b01df-b22f-4d42-b1b8-483cdcf51d35")
interface Nodes : IDispatch
{
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Item(int Index, Node* Node);
    HRESULT get_Count(int* Count);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/windowsribbon/windowsribbon-element-contextmenu
@GUID("dab39ce0-25e6-4e07-8362-ba9c95706545")
interface ContextMenu : IDispatch
{
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT get_Item(VARIANT IndexOrPath, MenuItem* MenuItem);
    HRESULT get_Count(int* Count);
}

@GUID("0178fad1-b361-4b27-96ad-67c57ebf2e1d")
interface MenuItem : IDispatch
{
    HRESULT get_DisplayName(BSTR* DisplayName);
    HRESULT get_LanguageIndependentName(BSTR* LanguageIndependentName);
    HRESULT get_Path(BSTR* Path);
    HRESULT get_LanguageIndependentPath(BSTR* LanguageIndependentPath);
    HRESULT Execute();
    HRESULT get_Enabled(BOOL* Enabled);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/com/properties-and-methods
@GUID("2886abc2-a425-42b2-91c6-e25c0e04581c")
interface Properties : IDispatch
{
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Item(BSTR Name, Property* Property);
    HRESULT get_Count(int* Count);
    HRESULT Remove(BSTR Name);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/wpd_sdk/attributes
@GUID("4600c3a5-e301-41d8-b6d0-ef2e4212e0ca")
interface Property : IDispatch
{
    HRESULT get_Value(VARIANT* Value);
    HRESULT put_Value(VARIANT Value);
    HRESULT get_Name(BSTR* Name);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nn-mmc-icomponentdata
@GUID("955ab28a-5218-11d0-a985-00c04fd8d565")
interface IComponentData : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-icomponentdata-initialize
    HRESULT Initialize(IUnknown pUnknown);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-icomponentdata-createcomponent
    HRESULT CreateComponent(IComponent* ppComponent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-icomponentdata-notify
    HRESULT Notify(IDataObject lpDataObject, MMC_NOTIFY_TYPE event, LPARAM arg, LPARAM param3);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-icomponentdata-destroy
    HRESULT Destroy();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-icomponentdata-querydataobject
    HRESULT QueryDataObject(ptrdiff_t cookie, DATA_OBJECT_TYPES type, IDataObject* ppDataObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-icomponentdata-getdisplayinfo
    HRESULT GetDisplayInfo(SCOPEDATAITEM* pScopeDataItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-icomponentdata-compareobjects
    HRESULT CompareObjects(IDataObject lpDataObjectA, IDataObject lpDataObjectB);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-icomponent
@GUID("43136eb2-d36c-11cf-adbc-00aa00a80033")
interface IComponent : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-icomponent-initialize
    HRESULT Initialize(IConsole lpConsole);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-icomponent-notify
    HRESULT Notify(IDataObject lpDataObject, MMC_NOTIFY_TYPE event, LPARAM arg, LPARAM param3);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-icomponent-destroy
    HRESULT Destroy(ptrdiff_t cookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-icomponent-querydataobject
    HRESULT QueryDataObject(ptrdiff_t cookie, DATA_OBJECT_TYPES type, IDataObject* ppDataObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-icomponent-getresultviewtype
    HRESULT GetResultViewType(ptrdiff_t cookie, PWSTR* ppViewType, int* pViewOptions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-icomponent-getdisplayinfo
    HRESULT GetDisplayInfo(RESULTDATAITEM* pResultDataItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-icomponent-compareobjects
    HRESULT CompareObjects(IDataObject lpDataObjectA, IDataObject lpDataObjectB);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nn-mmc-iresultdatacompare
@GUID("e8315a52-7a1a-11d0-a2d2-00c04fd909dd")
interface IResultDataCompare : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iresultdatacompare-compare
    HRESULT Compare(LPARAM lUserParam, ptrdiff_t cookieA, ptrdiff_t cookieB, int* pnResult);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nn-mmc-iresultownerdata
@GUID("9cb396d8-ea83-11d0-aef1-00c04fb6dd2c")
interface IResultOwnerData : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iresultownerdata-finditem
    HRESULT FindItem(RESULTFINDINFO* pFindInfo, int* pnFoundIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iresultownerdata-cachehint
    HRESULT CacheHint(int nStartIndex, int nEndIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iresultownerdata-sortitems
    HRESULT SortItems(int nColumn, uint dwSortOptions, LPARAM lUserParam);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nn-mmc-iconsole
@GUID("43136eb1-d36c-11cf-adbc-00aa00a80033")
interface IConsole : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iconsole-setheader
    HRESULT SetHeader(IHeaderCtrl pHeader);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iconsole-settoolbar
    HRESULT SetToolbar(IToolbar pToolbar);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iconsole-queryresultview
    HRESULT QueryResultView(IUnknown* pUnknown);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iconsole-queryscopeimagelist
    HRESULT QueryScopeImageList(IImageList* ppImageList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iconsole-queryresultimagelist
    HRESULT QueryResultImageList(IImageList* ppImageList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iconsole-updateallviews
    HRESULT UpdateAllViews(IDataObject lpDataObject, LPARAM data, ptrdiff_t hint);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iconsole-messagebox
    HRESULT MessageBox(const(PWSTR) lpszText, const(PWSTR) lpszTitle, uint fuStyle, int* piRetval);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iconsole-queryconsoleverb
    HRESULT QueryConsoleVerb(IConsoleVerb* ppConsoleVerb);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iconsole-selectscopeitem
    HRESULT SelectScopeItem(ptrdiff_t hScopeItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iconsole-getmainwindow
    HRESULT GetMainWindow(HWND* phwnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iconsole-newwindow
    HRESULT NewWindow(ptrdiff_t hScopeItem, uint lOptions);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nn-mmc-iheaderctrl
@GUID("43136eb3-d36c-11cf-adbc-00aa00a80033")
interface IHeaderCtrl : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iheaderctrl-insertcolumn
    HRESULT InsertColumn(int nCol, const(PWSTR) title, int nFormat, int nWidth);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iheaderctrl-deletecolumn
    HRESULT DeleteColumn(int nCol);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iheaderctrl-setcolumntext
    HRESULT SetColumnText(int nCol, const(PWSTR) title);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iheaderctrl-getcolumntext
    HRESULT GetColumnText(int nCol, PWSTR* pText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iheaderctrl-setcolumnwidth
    HRESULT SetColumnWidth(int nCol, int nWidth);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iheaderctrl-getcolumnwidth
    HRESULT GetColumnWidth(int nCol, int* pWidth);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nn-mmc-icontextmenucallback
@GUID("43136eb7-d36c-11cf-adbc-00aa00a80033")
interface IContextMenuCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-icontextmenucallback-additem
    HRESULT AddItem(CONTEXTMENUITEM* pItem);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nn-mmc-icontextmenuprovider
@GUID("43136eb6-d36c-11cf-adbc-00aa00a80033")
interface IContextMenuProvider : IContextMenuCallback
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-icontextmenuprovider-emptymenulist
    HRESULT EmptyMenuList();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-icontextmenuprovider-addprimaryextensionitems
    HRESULT AddPrimaryExtensionItems(IUnknown piExtension, IDataObject piDataObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-icontextmenuprovider-addthirdpartyextensionitems
    HRESULT AddThirdPartyExtensionItems(IDataObject piDataObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-icontextmenuprovider-showcontextmenu
    HRESULT ShowContextMenu(HWND hwndParent, int xPos, int yPos, int* plSelected);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nn-mmc-iextendcontextmenu
@GUID("4f3b7a4f-cfac-11cf-b8e3-00c04fd8d5b0")
interface IExtendContextMenu : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iextendcontextmenu-addmenuitems
    HRESULT AddMenuItems(IDataObject piDataObject, IContextMenuCallback piCallback, int* pInsertionAllowed);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iextendcontextmenu-command
    HRESULT Command(int lCommandID, IDataObject piDataObject);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commoncontrols/nn-commoncontrols-iimagelist
@GUID("43136eb8-d36c-11cf-adbc-00aa00a80033")
interface IImageList : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iimagelist-imagelistseticon
    HRESULT ImageListSetIcon(ptrdiff_t* pIcon, int nLoc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iimagelist-imagelistsetstrip
    HRESULT ImageListSetStrip(ptrdiff_t* pBMapSm, ptrdiff_t* pBMapLg, int nStartLoc, COLORREF cMask);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nn-mmc-iresultdata
@GUID("31da5fa0-e0eb-11cf-9f21-00aa003ca9f6")
interface IResultData : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iresultdata-insertitem
    HRESULT InsertItem(RESULTDATAITEM* item);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iresultdata-deleteitem
    HRESULT DeleteItem(ptrdiff_t itemID, int nCol);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iresultdata-finditembylparam
    HRESULT FindItemByLParam(LPARAM lParam, ptrdiff_t* pItemID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iresultdata-deleteallrsltitems
    HRESULT DeleteAllRsltItems();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iresultdata-setitem
    HRESULT SetItem(RESULTDATAITEM* item);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iresultdata-getitem
    HRESULT GetItem(RESULTDATAITEM* item);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iresultdata-getnextitem
    HRESULT GetNextItem(RESULTDATAITEM* item);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iresultdata-modifyitemstate
    HRESULT ModifyItemState(int nIndex, ptrdiff_t itemID, uint uAdd, uint uRemove);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iresultdata-modifyviewstyle
    HRESULT ModifyViewStyle(MMC_RESULT_VIEW_STYLE add, MMC_RESULT_VIEW_STYLE remove);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iresultdata-setviewmode
    HRESULT SetViewMode(int lViewMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iresultdata-getviewmode
    HRESULT GetViewMode(int* lViewMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iresultdata-updateitem
    HRESULT UpdateItem(ptrdiff_t itemID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iresultdata-sort
    HRESULT Sort(int nColumn, uint dwSortOptions, LPARAM lUserParam);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iresultdata-setdescbartext
    HRESULT SetDescBarText(PWSTR DescText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iresultdata-setitemcount
    HRESULT SetItemCount(int nItemCount, uint dwOptions);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nn-mmc-iconsolenamespace
@GUID("bedeb620-f24d-11cf-8afc-00aa003ca9f6")
interface IConsoleNameSpace : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iconsolenamespace-insertitem
    HRESULT InsertItem(SCOPEDATAITEM* item);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iconsolenamespace-deleteitem
    HRESULT DeleteItem(ptrdiff_t hItem, int fDeleteThis);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iconsolenamespace-setitem
    HRESULT SetItem(SCOPEDATAITEM* item);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iconsolenamespace-getitem
    HRESULT GetItem(SCOPEDATAITEM* item);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iconsolenamespace-getchilditem
    HRESULT GetChildItem(ptrdiff_t item, ptrdiff_t* pItemChild, ptrdiff_t* pCookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iconsolenamespace-getnextitem
    HRESULT GetNextItem(ptrdiff_t item, ptrdiff_t* pItemNext, ptrdiff_t* pCookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iconsolenamespace-getparentitem
    HRESULT GetParentItem(ptrdiff_t item, ptrdiff_t* pItemParent, ptrdiff_t* pCookie);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nn-mmc-iconsolenamespace2
@GUID("255f18cc-65db-11d1-a7dc-00c04fd8d565")
interface IConsoleNameSpace2 : IConsoleNameSpace
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iconsolenamespace2-expand
    HRESULT Expand(ptrdiff_t hItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iconsolenamespace2-addextension
    HRESULT AddExtension(ptrdiff_t hItem, GUID* lpClsid);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nn-mmc-ipropertysheetcallback
@GUID("85de64dd-ef21-11cf-a285-00c04fd8dbe6")
interface IPropertySheetCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-ipropertysheetcallback-addpage
    HRESULT AddPage(HPROPSHEETPAGE hPage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-ipropertysheetcallback-removepage
    HRESULT RemovePage(HPROPSHEETPAGE hPage);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nn-mmc-ipropertysheetprovider
@GUID("85de64de-ef21-11cf-a285-00c04fd8dbe6")
interface IPropertySheetProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-ipropertysheetprovider-createpropertysheet
    HRESULT CreatePropertySheet(const(PWSTR) title, ubyte type, ptrdiff_t cookie, IDataObject pIDataObjectm, 
                                uint dwOptions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-ipropertysheetprovider-findpropertysheet
    HRESULT FindPropertySheet(ptrdiff_t hItem, IComponent lpComponent, IDataObject lpDataObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-ipropertysheetprovider-addprimarypages
    HRESULT AddPrimaryPages(IUnknown lpUnknown, BOOL bCreateHandle, HWND hNotifyWindow, BOOL bScopePane);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-ipropertysheetprovider-addextensionpages
    HRESULT AddExtensionPages();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-ipropertysheetprovider-show
    HRESULT Show(ptrdiff_t window, int page);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nn-mmc-iextendpropertysheet
@GUID("85de64dc-ef21-11cf-a285-00c04fd8dbe6")
interface IExtendPropertySheet : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iextendpropertysheet-createpropertypages
    HRESULT CreatePropertyPages(IPropertySheetCallback lpProvider, ptrdiff_t handle, IDataObject lpIDataObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iextendpropertysheet-querypagesfor
    HRESULT QueryPagesFor(IDataObject lpDataObject);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nn-mmc-icontrolbar
@GUID("69fb811e-6c1c-11d0-a2cb-00c04fd909dd")
interface IControlbar : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-icontrolbar-create
    HRESULT Create(MMC_CONTROL_TYPE nType, IExtendControlbar pExtendControlbar, IUnknown* ppUnknown);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-icontrolbar-attach
    HRESULT Attach(MMC_CONTROL_TYPE nType, IUnknown lpUnknown);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-icontrolbar-detach
    HRESULT Detach(IUnknown lpUnknown);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nn-mmc-iextendcontrolbar
@GUID("49506520-6f40-11d0-a98b-00c04fd8d565")
interface IExtendControlbar : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iextendcontrolbar-setcontrolbar
    HRESULT SetControlbar(IControlbar pControlbar);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iextendcontrolbar-controlbarnotify
    HRESULT ControlbarNotify(MMC_NOTIFY_TYPE event, LPARAM arg, LPARAM param2);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nn-mmc-itoolbar
@GUID("43136eb9-d36c-11cf-adbc-00aa00a80033")
interface IToolbar : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-itoolbar-addbitmap
    HRESULT AddBitmap(int nImages, HBITMAP hbmp, int cxSize, int cySize, COLORREF crMask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-itoolbar-addbuttons
    HRESULT AddButtons(int nButtons, MMCBUTTON* lpButtons);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-itoolbar-insertbutton
    HRESULT InsertButton(int nIndex, MMCBUTTON* lpButton);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-itoolbar-deletebutton
    HRESULT DeleteButton(int nIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-itoolbar-getbuttonstate
    HRESULT GetButtonState(int idCommand, MMC_BUTTON_STATE nState, BOOL* pState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-itoolbar-setbuttonstate
    HRESULT SetButtonState(int idCommand, MMC_BUTTON_STATE nState, BOOL bState);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nn-mmc-iconsoleverb
@GUID("e49f7a60-74af-11d0-a286-00c04fd8fe93")
interface IConsoleVerb : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iconsoleverb-getverbstate
    HRESULT GetVerbState(MMC_CONSOLE_VERB eCmdID, MMC_BUTTON_STATE nState, BOOL* pState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iconsoleverb-setverbstate
    HRESULT SetVerbState(MMC_CONSOLE_VERB eCmdID, MMC_BUTTON_STATE nState, BOOL bState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iconsoleverb-setdefaultverb
    HRESULT SetDefaultVerb(MMC_CONSOLE_VERB eCmdID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iconsoleverb-getdefaultverb
    HRESULT GetDefaultVerb(MMC_CONSOLE_VERB* peCmdID);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nn-mmc-isnapinabout
@GUID("1245208c-a151-11d0-a7d7-00c04fd909dd")
interface ISnapinAbout : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-isnapinabout-getsnapindescription
    HRESULT GetSnapinDescription(PWSTR* lpDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-isnapinabout-getprovider
    HRESULT GetProvider(PWSTR* lpName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-isnapinabout-getsnapinversion
    HRESULT GetSnapinVersion(PWSTR* lpVersion);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-isnapinabout-getsnapinimage
    HRESULT GetSnapinImage(HICON* hAppIcon);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-isnapinabout-getstaticfolderimage
    HRESULT GetStaticFolderImage(HBITMAP* hSmallImage, HBITMAP* hSmallImageOpen, HBITMAP* hLargeImage, 
                                 COLORREF* cMask);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nn-mmc-imenubutton
@GUID("951ed750-d080-11d0-b197-000000000000")
interface IMenuButton : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-imenubutton-addbutton
    HRESULT AddButton(int idCommand, PWSTR lpButtonText, PWSTR lpTooltipText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-imenubutton-setbutton
    HRESULT SetButton(int idCommand, PWSTR lpButtonText, PWSTR lpTooltipText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-imenubutton-setbuttonstate
    HRESULT SetButtonState(int idCommand, MMC_BUTTON_STATE nState, BOOL bState);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nn-mmc-isnapinhelp
@GUID("a6b15ace-df59-11d0-a7dd-00c04fd909dd")
interface ISnapinHelp : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-isnapinhelp-gethelptopic
    HRESULT GetHelpTopic(PWSTR* lpCompiledHelpFile);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nn-mmc-iextendpropertysheet2
@GUID("b7a87232-4a51-11d1-a7ea-00c04fd909dd")
interface IExtendPropertySheet2 : IExtendPropertySheet
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iextendpropertysheet2-getwatermarks
    HRESULT GetWatermarks(IDataObject lpIDataObject, HBITMAP* lphWatermark, HBITMAP* lphHeader, 
                          HPALETTE* lphPalette, BOOL* bStretch);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nn-mmc-iheaderctrl2
@GUID("9757abb8-1b32-11d1-a7ce-00c04fd8d565")
interface IHeaderCtrl2 : IHeaderCtrl
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iheaderctrl2-setchangetimeout
    HRESULT SetChangeTimeOut(uint uTimeout);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iheaderctrl2-setcolumnfilter
    HRESULT SetColumnFilter(uint nColumn, uint dwType, MMC_FILTERDATA* pFilterData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iheaderctrl2-getcolumnfilter
    HRESULT GetColumnFilter(uint nColumn, uint* pdwType, MMC_FILTERDATA* pFilterData);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nn-mmc-isnapinhelp2
@GUID("4861a010-20f9-11d2-a510-00c04fb6dd2c")
interface ISnapinHelp2 : ISnapinHelp
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-isnapinhelp2-getlinkedtopics
    HRESULT GetLinkedTopics(PWSTR* lpCompiledHelpFiles);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nn-mmc-ienumtask
@GUID("338698b1-5a02-11d1-9fec-00600832db4a")
interface IEnumTASK : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-ienumtask-next
    HRESULT Next(uint celt, MMC_TASK* rgelt, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-ienumtask-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-ienumtask-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-ienumtask-clone
    HRESULT Clone(IEnumTASK* ppenum);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nn-mmc-iextendtaskpad
@GUID("8dee6511-554d-11d1-9fea-00600832db4a")
interface IExtendTaskPad : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iextendtaskpad-tasknotify
    HRESULT TaskNotify(IDataObject pdo, VARIANT* arg, VARIANT* param2);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iextendtaskpad-enumtasks
    HRESULT EnumTasks(IDataObject pdo, PWSTR szTaskGroup, IEnumTASK* ppEnumTASK);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iextendtaskpad-gettitle
    HRESULT GetTitle(PWSTR pszGroup, PWSTR* pszTitle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iextendtaskpad-getdescriptivetext
    HRESULT GetDescriptiveText(PWSTR pszGroup, PWSTR* pszDescriptiveText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iextendtaskpad-getbackground
    HRESULT GetBackground(PWSTR pszGroup, MMC_TASK_DISPLAY_OBJECT* pTDO);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iextendtaskpad-getlistpadinfo
    HRESULT GetListPadInfo(PWSTR pszGroup, MMC_LISTPAD_INFO* lpListPadInfo);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nn-mmc-iconsole2
@GUID("103d842a-aa63-11d1-a7e1-00c04fd8d565")
interface IConsole2 : IConsole
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iconsole2-expand
    HRESULT Expand(ptrdiff_t hItem, BOOL bExpand);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iconsole2-istaskpadviewpreferred
    HRESULT IsTaskpadViewPreferred();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iconsole2-setstatustext
    HRESULT SetStatusText(PWSTR pszStatusText);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nn-mmc-idisplayhelp
@GUID("cc593830-b926-11d1-8063-0000f875a9ce")
interface IDisplayHelp : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-idisplayhelp-showtopic
    HRESULT ShowTopic(PWSTR pszHelpTopic);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nn-mmc-irequiredextensions
@GUID("72782d7a-a4a0-11d1-af0f-00c04fb6dd2c")
interface IRequiredExtensions : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-irequiredextensions-enableallextensions
    HRESULT EnableAllExtensions();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-irequiredextensions-getfirstextension
    HRESULT GetFirstExtension(GUID* pExtCLSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-irequiredextensions-getnextextension
    HRESULT GetNextExtension(GUID* pExtCLSID);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nn-mmc-istringtable
@GUID("de40b7a4-0f65-11d2-8e25-00c04f8ecd78")
interface IStringTable : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-istringtable-addstring
    HRESULT AddString(const(PWSTR) pszAdd, uint* pStringID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-istringtable-getstring
    HRESULT GetString(uint StringID, uint cchBuffer, PWSTR lpBuffer, uint* pcchOut);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-istringtable-getstringlength
    HRESULT GetStringLength(uint StringID, uint* pcchString);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-istringtable-deletestring
    HRESULT DeleteString(uint StringID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-istringtable-deleteallstrings
    HRESULT DeleteAllStrings();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-istringtable-findstring
    HRESULT FindString(const(PWSTR) pszFind, uint* pStringID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-istringtable-enumerate
    HRESULT Enumerate(IEnumString* ppEnum);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nn-mmc-icolumndata
@GUID("547c1354-024d-11d3-a707-00c04f8ef4cb")
interface IColumnData : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-icolumndata-setcolumnconfigdata
    HRESULT SetColumnConfigData(SColumnSetID* pColID, MMC_COLUMN_SET_DATA* pColSetData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-icolumndata-getcolumnconfigdata
    HRESULT GetColumnConfigData(SColumnSetID* pColID, MMC_COLUMN_SET_DATA** ppColSetData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-icolumndata-setcolumnsortdata
    HRESULT SetColumnSortData(SColumnSetID* pColID, MMC_SORT_SET_DATA* pColSortData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-icolumndata-getcolumnsortdata
    HRESULT GetColumnSortData(SColumnSetID* pColID, MMC_SORT_SET_DATA** ppColSortData);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nn-mmc-imessageview
@GUID("80f94174-fccc-11d2-b991-00c04f8ecd78")
interface IMessageView : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-imessageview-settitletext
    HRESULT SetTitleText(const(PWSTR) pszTitleText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-imessageview-setbodytext
    HRESULT SetBodyText(const(PWSTR) pszBodyText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-imessageview-seticon
    HRESULT SetIcon(IconIdentifier id);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-imessageview-clear
    HRESULT Clear();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nn-mmc-iresultdatacompareex
@GUID("96933476-0251-11d3-aeb0-00c04f8ecd78")
interface IResultDataCompareEx : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iresultdatacompareex-compare
    HRESULT Compare(RDCOMPARE* prdc, int* pnResult);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nn-mmc-icomponentdata2
@GUID("cca0f2d2-82de-41b5-bf47-3b2076273d5c")
interface IComponentData2 : IComponentData
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-icomponentdata2-querydispatch
    HRESULT QueryDispatch(ptrdiff_t cookie, DATA_OBJECT_TYPES type, IDispatch* ppDispatch);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nn-mmc-icomponent2
@GUID("79a2d615-4a10-4ed4-8c65-8633f9335095")
interface IComponent2 : IComponent
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-icomponent2-querydispatch
    HRESULT QueryDispatch(ptrdiff_t cookie, DATA_OBJECT_TYPES type, IDispatch* ppDispatch);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-icomponent2-getresultviewtype2
    HRESULT GetResultViewType2(ptrdiff_t cookie, RESULT_VIEW_TYPE_INFO* pResultViewType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-icomponent2-restoreresultview
    HRESULT RestoreResultView(ptrdiff_t cookie, RESULT_VIEW_TYPE_INFO* pResultViewType);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nn-mmc-icontextmenucallback2
@GUID("e178bc0e-2ed0-4b5e-8097-42c9087e8b33")
interface IContextMenuCallback2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-icontextmenucallback2-additem
    HRESULT AddItem(CONTEXTMENUITEM2* pItem);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nn-mmc-immcversioninfo
@GUID("a8d2c5fe-cdcb-4b9d-bde5-a27343ff54bc")
interface IMMCVersionInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-immcversioninfo-getmmcversion
    HRESULT GetMMCVersion(int* pVersionMajor, int* pVersionMinor);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nn-mmc-iextendview
@GUID("89995cee-d2ed-4c0e-ae5e-df7e76f3fa53")
interface IExtendView : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iextendview-getviews
    HRESULT GetViews(IDataObject pDataObject, IViewExtensionCallback pViewExtensionCallback);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nn-mmc-iviewextensioncallback
@GUID("34dd928a-7599-41e5-9f5e-d6bc3062c2da")
interface IViewExtensionCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iviewextensioncallback-addview
    HRESULT AddView(MMC_EXT_VIEW_DATA* pExtViewData);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nn-mmc-iconsolepower
@GUID("1cfbdd0e-62ca-49ce-a3af-dbb2de61b068")
interface IConsolePower : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iconsolepower-setexecutionstate
    HRESULT SetExecutionState(uint dwAdd, uint dwRemove);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iconsolepower-resetidletimer
    HRESULT ResetIdleTimer(uint dwFlags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nn-mmc-iconsolepowersink
@GUID("3333759f-fe4f-4975-b143-fec0a5dd6d65")
interface IConsolePowerSink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iconsolepowersink-onpowerbroadcast
    HRESULT OnPowerBroadcast(uint nEvent, LPARAM lParam, LRESULT* plReturn);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nn-mmc-inodeproperties
@GUID("15bc4d24-a522-4406-aa55-0749537a6865")
interface INodeProperties : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-inodeproperties-getproperty
    HRESULT GetProperty(IDataObject pDataObject, BSTR szPropertyName, BSTR* pbstrProperty);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nn-mmc-iconsole3
@GUID("4f85efdb-d0e1-498c-8d4a-d010dfdd404f")
interface IConsole3 : IConsole2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iconsole3-renamescopeitem
    HRESULT RenameScopeItem(ptrdiff_t hScopeItem);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nn-mmc-iresultdata2
@GUID("0f36e0eb-a7f1-4a81-be5a-9247f7de4b1b")
interface IResultData2 : IResultData
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmc/nf-mmc-iresultdata2-renameresultitem
    HRESULT RenameResultItem(ptrdiff_t itemID);
}


// GUIDs

const GUID CLSID_AppEventsDHTMLConnector = GUIDOF!AppEventsDHTMLConnector;
const GUID CLSID_Application             = GUIDOF!Application;
const GUID CLSID_ConsolePower            = GUIDOF!ConsolePower;
const GUID CLSID_MMCVersionInfo          = GUIDOF!MMCVersionInfo;

const GUID IID_AppEvents                 = GUIDOF!AppEvents;
const GUID IID_Column                    = GUIDOF!Column;
const GUID IID_Columns                   = GUIDOF!Columns;
const GUID IID_ContextMenu               = GUIDOF!ContextMenu;
const GUID IID_Document                  = GUIDOF!Document;
const GUID IID_Extension                 = GUIDOF!Extension;
const GUID IID_Extensions                = GUIDOF!Extensions;
const GUID IID_Frame                     = GUIDOF!Frame;
const GUID IID_IColumnData               = GUIDOF!IColumnData;
const GUID IID_IComponent                = GUIDOF!IComponent;
const GUID IID_IComponent2               = GUIDOF!IComponent2;
const GUID IID_IComponentData            = GUIDOF!IComponentData;
const GUID IID_IComponentData2           = GUIDOF!IComponentData2;
const GUID IID_IConsole                  = GUIDOF!IConsole;
const GUID IID_IConsole2                 = GUIDOF!IConsole2;
const GUID IID_IConsole3                 = GUIDOF!IConsole3;
const GUID IID_IConsoleNameSpace         = GUIDOF!IConsoleNameSpace;
const GUID IID_IConsoleNameSpace2        = GUIDOF!IConsoleNameSpace2;
const GUID IID_IConsolePower             = GUIDOF!IConsolePower;
const GUID IID_IConsolePowerSink         = GUIDOF!IConsolePowerSink;
const GUID IID_IConsoleVerb              = GUIDOF!IConsoleVerb;
const GUID IID_IContextMenuCallback      = GUIDOF!IContextMenuCallback;
const GUID IID_IContextMenuCallback2     = GUIDOF!IContextMenuCallback2;
const GUID IID_IContextMenuProvider      = GUIDOF!IContextMenuProvider;
const GUID IID_IControlbar               = GUIDOF!IControlbar;
const GUID IID_IDisplayHelp              = GUIDOF!IDisplayHelp;
const GUID IID_IEnumTASK                 = GUIDOF!IEnumTASK;
const GUID IID_IExtendContextMenu        = GUIDOF!IExtendContextMenu;
const GUID IID_IExtendControlbar         = GUIDOF!IExtendControlbar;
const GUID IID_IExtendPropertySheet      = GUIDOF!IExtendPropertySheet;
const GUID IID_IExtendPropertySheet2     = GUIDOF!IExtendPropertySheet2;
const GUID IID_IExtendTaskPad            = GUIDOF!IExtendTaskPad;
const GUID IID_IExtendView               = GUIDOF!IExtendView;
const GUID IID_IHeaderCtrl               = GUIDOF!IHeaderCtrl;
const GUID IID_IHeaderCtrl2              = GUIDOF!IHeaderCtrl2;
const GUID IID_IImageList                = GUIDOF!IImageList;
const GUID IID_IMMCVersionInfo           = GUIDOF!IMMCVersionInfo;
const GUID IID_IMenuButton               = GUIDOF!IMenuButton;
const GUID IID_IMessageView              = GUIDOF!IMessageView;
const GUID IID_INodeProperties           = GUIDOF!INodeProperties;
const GUID IID_IPropertySheetCallback    = GUIDOF!IPropertySheetCallback;
const GUID IID_IPropertySheetProvider    = GUIDOF!IPropertySheetProvider;
const GUID IID_IRequiredExtensions       = GUIDOF!IRequiredExtensions;
const GUID IID_IResultData               = GUIDOF!IResultData;
const GUID IID_IResultData2              = GUIDOF!IResultData2;
const GUID IID_IResultDataCompare        = GUIDOF!IResultDataCompare;
const GUID IID_IResultDataCompareEx      = GUIDOF!IResultDataCompareEx;
const GUID IID_IResultOwnerData          = GUIDOF!IResultOwnerData;
const GUID IID_ISnapinAbout              = GUIDOF!ISnapinAbout;
const GUID IID_ISnapinHelp               = GUIDOF!ISnapinHelp;
const GUID IID_ISnapinHelp2              = GUIDOF!ISnapinHelp2;
const GUID IID_ISnapinProperties         = GUIDOF!ISnapinProperties;
const GUID IID_ISnapinPropertiesCallback = GUIDOF!ISnapinPropertiesCallback;
const GUID IID_IStringTable              = GUIDOF!IStringTable;
const GUID IID_IToolbar                  = GUIDOF!IToolbar;
const GUID IID_IViewExtensionCallback    = GUIDOF!IViewExtensionCallback;
const GUID IID_MenuItem                  = GUIDOF!MenuItem;
const GUID IID_Node                      = GUIDOF!Node;
const GUID IID_Nodes                     = GUIDOF!Nodes;
const GUID IID_Properties                = GUIDOF!Properties;
const GUID IID_Property                  = GUIDOF!Property;
const GUID IID_ScopeNamespace            = GUIDOF!ScopeNamespace;
const GUID IID_SnapIn                    = GUIDOF!SnapIn;
const GUID IID_SnapIns                   = GUIDOF!SnapIns;
const GUID IID_View                      = GUIDOF!View;
const GUID IID_Views                     = GUIDOF!Views;
const GUID IID__AppEvents                = GUIDOF!_AppEvents;
const GUID IID__Application              = GUIDOF!_Application;
const GUID IID__EventConnector           = GUIDOF!_EventConnector;
