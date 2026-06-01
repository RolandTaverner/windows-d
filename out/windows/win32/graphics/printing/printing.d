// Written in the D programming language.

module windows.win32.graphics.printing.printing;

public import windows.core;
public import windows.win32.data.xml.msxml : IXMLDOMDocument2;
public import windows.win32.devices.communication : COMMTIMEOUTS;
public import windows.win32.devices.display : FD_KERNINGPAIR;
public import windows.win32.foundation.foundation : BOOL, BSTR, CHAR, FARPROC, FILETIME,
                                                    HANDLE, HINSTANCE, HRESULT, HWND,
                                                    LPARAM, LRESULT, POINTL, PSTR,
                                                    PWSTR, RECT, RECTL, SIZE, SYSTEMTIME,
                                                    WPARAM;
public import windows.win32.graphics.dxgi.dxgi : IDXGISurface;
public import windows.win32.graphics.gdi : DEVMODEA, DEVMODEW, HDC, PANOSE;
public import windows.win32.graphics.imaging.imaging : IWICBitmap;
public import windows.win32.security.security : PSECURITY_DESCRIPTOR;
public import windows.win32.storage.xps.xps : DOCINFOW, IXpsOMPage;
public import windows.win32.system.com.com : IDispatch, IEnumUnknown, IErrorInfo, IStream,
                                             IUnknown, STREAM_SEEK;
public import windows.win32.system.ole : ICreateErrorInfo;
public import windows.win32.system.power : POWERBROADCAST_SETTING;
public import windows.win32.system.registry : HKEY;
public import windows.win32.system.variant : VARIANT;
public import windows.win32.ui.windowsandmessaging : DLGPROC, HICON;

extern(Windows) @nogc nothrow:


// Enums


alias PRINTER_ACCESS_RIGHTS = uint;
enum : uint
{
    PRINTER_ALL_ACCESS               = 0x000f000cU,
    PRINTER_READ                     = 0x00020008U,
    PRINTER_WRITE                    = 0x00020008U,
    PRINTER_EXECUTE                  = 0x00020008U,
    SERVER_ALL_ACCESS                = 0x000f0003U,
    SERVER_READ                      = 0x00020002U,
    SERVER_WRITE                     = 0x00020003U,
    SERVER_EXECUTE                   = 0x00020002U,
    PRINTER_DELETE                   = 0x00010000U,
    PRINTER_READ_CONTROL             = 0x00020000U,
    PRINTER_WRITE_DAC                = 0x00040000U,
    PRINTER_WRITE_OWNER              = 0x00080000U,
    PRINTER_SYNCHRONIZE              = 0x00100000U,
    PRINTER_STANDARD_RIGHTS_REQUIRED = 0x000f0000U,
    PRINTER_STANDARD_RIGHTS_READ     = 0x00020000U,
    PRINTER_STANDARD_RIGHTS_WRITE    = 0x00020000U,
    PRINTER_STANDARD_RIGHTS_EXECUTE  = 0x00020000U,
    SERVER_ACCESS_ADMINISTER         = 0x00000001U,
    SERVER_ACCESS_ENUMERATE          = 0x00000002U,
    PRINTER_ACCESS_ADMINISTER        = 0x00000004U,
    PRINTER_ACCESS_USE               = 0x00000008U,
    PRINTER_ACCESS_MANAGE_LIMITED    = 0x00000040U,
}

enum EXpsCompressionOptions : int
{
    Compression_NotCompressed = 0x00000000,
    Compression_Normal        = 0x00000001,
    Compression_Small         = 0x00000002,
    Compression_Fast          = 0x00000003,
}

enum EXpsFontOptions : int
{
    Font_Normal      = 0x00000000,
    Font_Obfusticate = 0x00000001,
}

enum EXpsJobConsumption : int
{
    XpsJob_DocumentSequenceAdded = 0x00000000,
    XpsJob_FixedDocumentAdded    = 0x00000001,
    XpsJob_FixedPageAdded        = 0x00000002,
}

enum EXpsFontRestriction : int
{
    Xps_Restricted_Font_Installable  = 0x00000000,
    Xps_Restricted_Font_NoEmbedding  = 0x00000002,
    Xps_Restricted_Font_PreviewPrint = 0x00000004,
    Xps_Restricted_Font_Editable     = 0x00000008,
}

alias BIDI_TYPE = int;
enum : int
{
    BIDI_NULL   = 0x00000000,
    BIDI_INT    = 0x00000001,
    BIDI_FLOAT  = 0x00000002,
    BIDI_BOOL   = 0x00000003,
    BIDI_STRING = 0x00000004,
    BIDI_TEXT   = 0x00000005,
    BIDI_ENUM   = 0x00000006,
    BIDI_BLOB   = 0x00000007,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/printer-option-flags
alias PRINTER_OPTION_FLAGS = int;
enum : int
{
    PRINTER_OPTION_NO_CACHE       = 0x00000001,
    PRINTER_OPTION_CACHE          = 0x00000002,
    PRINTER_OPTION_CLIENT_CHANGE  = 0x00000004,
    PRINTER_OPTION_NO_CLIENT_DATA = 0x00000008,
}

enum EPrintPropertyType : int
{
    kPropertyTypeString              = 0x00000001,
    kPropertyTypeInt32               = 0x00000002,
    kPropertyTypeInt64               = 0x00000003,
    kPropertyTypeByte                = 0x00000004,
    kPropertyTypeTime                = 0x00000005,
    kPropertyTypeDevMode             = 0x00000006,
    kPropertyTypeSD                  = 0x00000007,
    kPropertyTypeNotificationReply   = 0x00000008,
    kPropertyTypeNotificationOptions = 0x00000009,
    kPropertyTypeBuffer              = 0x0000000a,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/eprintxpsjobprogress
enum EPrintXPSJobProgress : int
{
    kAddingDocumentSequence = 0x00000000,
    kDocumentSequenceAdded  = 0x00000001,
    kAddingFixedDocument    = 0x00000002,
    kFixedDocumentAdded     = 0x00000003,
    kAddingFixedPage        = 0x00000004,
    kFixedPageAdded         = 0x00000005,
    kResourceAdded          = 0x00000006,
    kFontAdded              = 0x00000007,
    kImageAdded             = 0x00000008,
    kXpsDocumentCommitted   = 0x00000009,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/eprintxpsjoboperation
enum EPrintXPSJobOperation : int
{
    kJobProduction  = 0x00000001,
    kJobConsumption = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/print-execution-context
alias PRINT_EXECUTION_CONTEXT = int;
enum : int
{
    PRINT_EXECUTION_CONTEXT_APPLICATION            = 0x00000000,
    PRINT_EXECUTION_CONTEXT_SPOOLER_SERVICE        = 0x00000001,
    PRINT_EXECUTION_CONTEXT_SPOOLER_ISOLATION_HOST = 0x00000002,
    PRINT_EXECUTION_CONTEXT_FILTER_PIPELINE        = 0x00000003,
    PRINT_EXECUTION_CONTEXT_WOW64                  = 0x00000004,
}

alias MXDC_LANDSCAPE_ROTATION_ENUMS = int;
enum : int
{
    MXDC_LANDSCAPE_ROTATE_COUNTERCLOCKWISE_90_DEGREES  = 0x0000005a,
    MXDC_LANDSCAPE_ROTATE_NONE                         = 0x00000000,
    MXDC_LANDSCAPE_ROTATE_COUNTERCLOCKWISE_270_DEGREES = 0xffffffa6,
}

alias MXDC_IMAGE_TYPE_ENUMS = int;
enum : int
{
    MXDC_IMAGETYPE_JPEGHIGH_COMPRESSION   = 0x00000001,
    MXDC_IMAGETYPE_JPEGMEDIUM_COMPRESSION = 0x00000002,
    MXDC_IMAGETYPE_JPEGLOW_COMPRESSION    = 0x00000003,
    MXDC_IMAGETYPE_PNG                    = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/mxdcs0pageenums
alias MXDC_S0_PAGE_ENUMS = int;
enum : int
{
    MXDC_RESOURCE_TTF            = 0x00000000,
    MXDC_RESOURCE_JPEG           = 0x00000001,
    MXDC_RESOURCE_PNG            = 0x00000002,
    MXDC_RESOURCE_TIFF           = 0x00000003,
    MXDC_RESOURCE_WDP            = 0x00000004,
    MXDC_RESOURCE_DICTIONARY     = 0x00000005,
    MXDC_RESOURCE_ICC_PROFILE    = 0x00000006,
    MXDC_RESOURCE_JPEG_THUMBNAIL = 0x00000007,
    MXDC_RESOURCE_PNG_THUMBNAIL  = 0x00000008,
    MXDC_RESOURCE_MAX            = 0x00000009,
}

alias EATTRIBUTE_DATATYPE = int;
enum : int
{
    kADT_UNKNOWN          = 0x00000000,
    kADT_BOOL             = 0x00000001,
    kADT_INT              = 0x00000002,
    kADT_LONG             = 0x00000003,
    kADT_DWORD            = 0x00000004,
    kADT_ASCII            = 0x00000005,
    kADT_UNICODE          = 0x00000006,
    kADT_BINARY           = 0x00000007,
    kADT_SIZE             = 0x00000008,
    kADT_RECT             = 0x00000009,
    kADT_CUSTOMSIZEPARAMS = 0x0000000a,
}

alias SHIMOPTS = int;
enum : int
{
    PTSHIM_DEFAULT    = 0x00000000,
    PTSHIM_NOSNAPSHOT = 0x00000001,
}

enum PrintSchemaConstrainedSetting : int
{
    PrintSchemaConstrainedSetting_None        = 0x00000000,
    PrintSchemaConstrainedSetting_PrintTicket = 0x00000001,
    PrintSchemaConstrainedSetting_Admin       = 0x00000002,
    PrintSchemaConstrainedSetting_Device      = 0x00000003,
}

enum PrintSchemaSelectionType : int
{
    PrintSchemaSelectionType_PickOne  = 0x00000000,
    PrintSchemaSelectionType_PickMany = 0x00000001,
}

enum PrintSchemaParameterDataType : int
{
    PrintSchemaParameterDataType_Integer       = 0x00000000,
    PrintSchemaParameterDataType_NumericString = 0x00000001,
    PrintSchemaParameterDataType_String        = 0x00000002,
}

enum PrintJobStatus : int
{
    PrintJobStatus_Paused             = 0x00000001,
    PrintJobStatus_Error              = 0x00000002,
    PrintJobStatus_Deleting           = 0x00000004,
    PrintJobStatus_Spooling           = 0x00000008,
    PrintJobStatus_Printing           = 0x00000010,
    PrintJobStatus_Offline            = 0x00000020,
    PrintJobStatus_PaperOut           = 0x00000040,
    PrintJobStatus_Printed            = 0x00000080,
    PrintJobStatus_Deleted            = 0x00000100,
    PrintJobStatus_BlockedDeviceQueue = 0x00000200,
    PrintJobStatus_UserIntervention   = 0x00000400,
    PrintJobStatus_Restarted          = 0x00000800,
    PrintJobStatus_Complete           = 0x00001000,
    PrintJobStatus_Retained           = 0x00002000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/prnasnot/ne-prnasnot-printasyncnotifyuserfilter
enum PrintAsyncNotifyUserFilter : int
{
    kPerUser  = 0x00000000,
    kAllUsers = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/prnasnot/ne-prnasnot-printasyncnotifyconversationstyle
enum PrintAsyncNotifyConversationStyle : int
{
    kBiDirectional  = 0x00000000,
    kUniDirectional = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/prnasnot/ne-prnasnot-printasyncnotifyerror
enum PrintAsyncNotifyError : int
{
    CHANNEL_CLOSED_BY_SERVER                = 0x00000001,
    CHANNEL_CLOSED_BY_ANOTHER_LISTENER      = 0x00000002,
    CHANNEL_CLOSED_BY_SAME_LISTENER         = 0x00000003,
    CHANNEL_RELEASED_BY_LISTENER            = 0x00000004,
    UNIRECTIONAL_NOTIFICATION_LOST          = 0x00000005,
    ASYNC_NOTIFICATION_FAILURE              = 0x00000006,
    NO_LISTENERS                            = 0x00000007,
    CHANNEL_ALREADY_CLOSED                  = 0x00000008,
    CHANNEL_ALREADY_OPENED                  = 0x00000009,
    CHANNEL_WAITING_FOR_CLIENT_NOTIFICATION = 0x0000000a,
    CHANNEL_NOT_OPENED                      = 0x0000000b,
    ASYNC_CALL_ALREADY_PARKED               = 0x0000000c,
    NOT_REGISTERED                          = 0x0000000d,
    ALREADY_UNREGISTERED                    = 0x0000000e,
    ALREADY_REGISTERED                      = 0x0000000f,
    CHANNEL_ACQUIRED                        = 0x00000010,
    ASYNC_CALL_IN_PROGRESS                  = 0x00000011,
    MAX_NOTIFICATION_SIZE_EXCEEDED          = 0x00000012,
    INTERNAL_NOTIFICATION_QUEUE_IS_FULL     = 0x00000013,
    INVALID_NOTIFICATION_TYPE               = 0x00000014,
    MAX_REGISTRATION_COUNT_EXCEEDED         = 0x00000015,
    MAX_CHANNEL_COUNT_EXCEEDED              = 0x00000016,
    LOCAL_ONLY_REGISTRATION                 = 0x00000017,
    REMOTE_ONLY_REGISTRATION                = 0x00000018,
}

enum EBranchOfficeJobEventType : int
{
    kInvalidJobState     = 0x00000000,
    kLogJobPrinted       = 0x00000001,
    kLogJobRendered      = 0x00000002,
    kLogJobError         = 0x00000003,
    kLogJobPipelineError = 0x00000004,
    kLogOfflineFileFull  = 0x00000005,
}

alias NOTIFICATION_CALLBACK_COMMANDS = int;
enum : int
{
    NOTIFICATION_COMMAND_NOTIFY          = 0x00000000,
    NOTIFICATION_COMMAND_CONTEXT_ACQUIRE = 0x00000001,
    NOTIFICATION_COMMAND_CONTEXT_RELEASE = 0x00000002,
}

alias NOTIFICATION_CONFIG_FLAGS = int;
enum : int
{
    NOTIFICATION_CONFIG_CREATE_EVENT      = 0x00000001,
    NOTIFICATION_CONFIG_REGISTER_CALLBACK = 0x00000002,
    NOTIFICATION_CONFIG_EVENT_TRIGGER     = 0x00000004,
    NOTIFICATION_CONFIG_ASYNC_CHANNEL     = 0x00000008,
}

alias UI_TYPE = int;
enum : int
{
    kMessageBox = 0x00000000,
}

alias XPSRAS_RENDERING_MODE = int;
enum : int
{
    XPSRAS_RENDERING_MODE_ANTIALIASED = 0x00000000,
    XPSRAS_RENDERING_MODE_ALIASED     = 0x00000001,
}

alias XPSRAS_PIXEL_FORMAT = int;
enum : int
{
    XPSRAS_PIXEL_FORMAT_32BPP_PBGRA_UINT_SRGB    = 0x00000001,
    XPSRAS_PIXEL_FORMAT_64BPP_PRGBA_HALF_SCRGB   = 0x00000002,
    XPSRAS_PIXEL_FORMAT_128BPP_PRGBA_FLOAT_SCRGB = 0x00000003,
}

alias XPSRAS_BACKGROUND_COLOR = int;
enum : int
{
    XPSRAS_BACKGROUND_COLOR_TRANSPARENT = 0x00000000,
    XPSRAS_BACKGROUND_COLOR_OPAQUE      = 0x00000001,
}

enum PageCountType : int
{
    FinalPageCount        = 0x00000000,
    IntermediatePageCount = 0x00000001,
}

// Constants


enum : uint
{
    USB_PRINTER_INTERFACE_CLASSIC = 0x00000001U,
    USB_PRINTER_INTERFACE_IPP     = 0x00000002U,
    USB_PRINTER_INTERFACE_DUAL    = 0x00000003U,
}

enum : uint
{
    USB_PRINT_IPP_COMPAT_ID = 0x00000001U,
    USB_PRINT_IPP_FAXOUT    = 0x00000002U,
}

enum uint USBPRINT_IOCTL_INDEX = 0x00000000U;

enum : uint
{
    IOCTL_USBPRINT_GET_LPT_STATUS      = 0x00220030U,
    IOCTL_USBPRINT_GET_1284_ID         = 0x00220034U,
    IOCTL_USBPRINT_VENDOR_SET_COMMAND  = 0x00220038U,
    IOCTL_USBPRINT_VENDOR_GET_COMMAND  = 0x0022003cU,
    IOCTL_USBPRINT_SOFT_RESET          = 0x00220040U,
    IOCTL_USBPRINT_GET_PROTOCOL        = 0x00220044U,
    IOCTL_USBPRINT_SET_PROTOCOL        = 0x00220048U,
    IOCTL_USBPRINT_GET_INTERFACE_TYPE  = 0x0022004cU,
    IOCTL_USBPRINT_SET_PORT_NUMBER     = 0x00220050U,
    IOCTL_USBPRINT_ADD_MSIPP_COMPAT_ID = 0x00220054U,
    IOCTL_USBPRINT_SET_DEVICE_ID       = 0x00220058U,
    IOCTL_USBPRINT_ADD_CHILD_DEVICE    = 0x0022005cU,
    IOCTL_USBPRINT_CYCLE_PORT          = 0x00220060U,
    IOCTL_USBPRINT_GET_MFG_MDL_ID      = 0x00220064U,
}

enum : uint
{
    TVOT_2STATES  = 0x00000000U,
    TVOT_3STATES  = 0x00000001U,
    TVOT_UDARROW  = 0x00000002U,
    TVOT_TRACKBAR = 0x00000003U,
}

enum uint TVOT_SCROLLBAR = 0x00000004U;

enum : uint
{
    TVOT_LISTBOX  = 0x00000005U,
    TVOT_COMBOBOX = 0x00000006U,
}

enum : uint
{
    TVOT_EDITBOX    = 0x00000007U,
    TVOT_PUSHBUTTON = 0x00000008U,
}

enum : uint
{
    TVOT_CHKBOX     = 0x00000009U,
    TVOT_NSTATES_EX = 0x0000000aU,
}

enum : uint
{
    CHKBOXS_FALSE_TRUE  = 0x00000000U,
    CHKBOXS_NO_YES      = 0x00000001U,
    CHKBOXS_OFF_ON      = 0x00000002U,
    CHKBOXS_FALSE_PDATA = 0x00000003U,
    CHKBOXS_NO_PDATA    = 0x00000004U,
    CHKBOXS_OFF_PDATA   = 0x00000005U,
    CHKBOXS_NONE_PDATA  = 0x00000006U,
}

enum : uint
{
    PUSHBUTTON_TYPE_DLGPROC  = 0x00000000U,
    PUSHBUTTON_TYPE_CALLBACK = 0x00000001U,
    PUSHBUTTON_TYPE_HTCLRADJ = 0x00000002U,
    PUSHBUTTON_TYPE_HTSETUP  = 0x00000003U,
}

enum uint MAX_RES_STR_CHARS = 0x000000a0U;

enum : uint
{
    OPTPF_HIDE            = 0x00000001U,
    OPTPF_DISABLED        = 0x00000002U,
    OPTPF_ICONID_AS_HICON = 0x00000004U,
}

enum : uint
{
    OPTPF_OVERLAY_WARNING_ICON = 0x00000008U,
    OPTPF_OVERLAY_STOP_ICON    = 0x00000010U,
    OPTPF_OVERLAY_NO_ICON      = 0x00000020U,
}

enum uint OPTPF_USE_HDLGTEMPLATE = 0x00000040U;
enum uint OPTPF_MASK = 0x0000007fU;

enum : uint
{
    OPTCF_HIDE = 0x00000001U,
    OPTCF_MASK = 0x00000001U,
}

enum uint OPTTF_TYPE_DISABLED = 0x00000001U;
enum uint OPTTF_NOSPACE_BEFORE_POSTFIX = 0x00000002U;
enum uint OPTTF_MASK = 0x00000003U;

enum : uint
{
    OTS_LBCB_SORT             = 0x00000001U,
    OTS_LBCB_PROPPAGE_LBUSECB = 0x00000002U,
    OTS_LBCB_PROPPAGE_CBUSELB = 0x00000004U,
}

enum uint OTS_LBCB_INCL_ITEM_NONE = 0x00000008U;
enum uint OTS_LBCB_NO_ICON16_IN_ITEM = 0x00000010U;
enum uint OTS_PUSH_INCL_SETUP_TITLE = 0x00000020U;
enum uint OTS_PUSH_NO_DOT_DOT_DOT = 0x00000040U;
enum uint OTS_PUSH_ENABLE_ALWAYS = 0x00000080U;
enum uint OTS_MASK = 0x000000ffU;
enum uint EPF_PUSH_TYPE_DLGPROC = 0x00000001U;
enum uint EPF_INCL_SETUP_TITLE = 0x00000002U;
enum uint EPF_NO_DOT_DOT_DOT = 0x00000004U;
enum uint EPF_ICONID_AS_HICON = 0x00000008U;

enum : uint
{
    EPF_OVERLAY_WARNING_ICON = 0x00000010U,
    EPF_OVERLAY_STOP_ICON    = 0x00000020U,
    EPF_OVERLAY_NO_ICON      = 0x00000040U,
}

enum uint EPF_USE_HDLGTEMPLATE = 0x00000080U;
enum uint EPF_MASK = 0x000000ffU;

enum : uint
{
    ECBF_CHECKNAME_AT_FRONT     = 0x00000001U,
    ECBF_CHECKNAME_ONLY_ENABLED = 0x00000002U,
}

enum uint ECBF_ICONID_AS_HICON = 0x00000004U;

enum : uint
{
    ECBF_OVERLAY_WARNING_ICON       = 0x00000008U,
    ECBF_OVERLAY_ECBICON_IF_CHECKED = 0x00000010U,
    ECBF_OVERLAY_STOP_ICON          = 0x00000020U,
    ECBF_OVERLAY_NO_ICON            = 0x00000040U,
}

enum uint ECBF_CHECKNAME_ONLY = 0x00000080U;
enum uint ECBF_MASK = 0x000000ffU;

enum : int
{
    OPTIF_COLLAPSE   = 0x00000001,
    OPTIF_HIDE       = 0x00000002,
    OPTIF_CALLBACK   = 0x00000004,
    OPTIF_CHANGED    = 0x00000008,
    OPTIF_CHANGEONCE = 0x00000010,
}

enum : int
{
    OPTIF_DISABLED     = 0x00000020,
    OPTIF_ECB_CHECKED  = 0x00000040,
    OPTIF_EXT_HIDE     = 0x00000080,
    OPTIF_EXT_DISABLED = 0x00000100,
}

enum int OPTIF_SEL_AS_HICON = 0x00000200;
enum int OPTIF_EXT_IS_EXTPUSH = 0x00000400;
enum int OPTIF_NO_GROUPBOX_NAME = 0x00000800;

enum : int
{
    OPTIF_OVERLAY_WARNING_ICON = 0x00001000,
    OPTIF_OVERLAY_STOP_ICON    = 0x00002000,
    OPTIF_OVERLAY_NO_ICON      = 0x00004000,
}

enum int OPTIF_INITIAL_TVITEM = 0x00008000;
enum int OPTIF_HAS_POIEXT = 0x00010000;
enum int OPTIF_MASK = 0x0001ffff;

enum : uint
{
    DMPUB_NONE        = 0x00000000U,
    DMPUB_FIRST       = 0x00000001U,
    DMPUB_ORIENTATION = 0x00000001U,
}

enum : uint
{
    DMPUB_SCALE          = 0x00000002U,
    DMPUB_COPIES_COLLATE = 0x00000003U,
}

enum uint DMPUB_DEFSOURCE = 0x00000004U;
enum uint DMPUB_PRINTQUALITY = 0x00000005U;

enum : uint
{
    DMPUB_COLOR     = 0x00000006U,
    DMPUB_DUPLEX    = 0x00000007U,
    DMPUB_TTOPTION  = 0x00000008U,
    DMPUB_FORMNAME  = 0x00000009U,
    DMPUB_ICMMETHOD = 0x0000000aU,
    DMPUB_ICMINTENT = 0x0000000bU,
}

enum uint DMPUB_MEDIATYPE = 0x0000000cU;
enum uint DMPUB_DITHERTYPE = 0x0000000dU;
enum uint DMPUB_OUTPUTBIN = 0x0000000eU;

enum : uint
{
    DMPUB_QUALITY   = 0x0000000fU,
    DMPUB_NUP       = 0x00000010U,
    DMPUB_PAGEORDER = 0x00000011U,
}

enum uint DMPUB_NUP_DIRECTION = 0x00000012U;
enum uint DMPUB_MANUAL_DUPLEX = 0x00000013U;

enum : uint
{
    DMPUB_STAPLE       = 0x00000014U,
    DMPUB_BOOKLET_EDGE = 0x00000015U,
}

enum : uint
{
    DMPUB_LAST             = 0x00000015U,
    DMPUB_OEM_PAPER_ITEM   = 0x00000061U,
    DMPUB_OEM_GRAPHIC_ITEM = 0x00000062U,
    DMPUB_OEM_ROOT_ITEM    = 0x00000063U,
}

enum uint DMPUB_USER = 0x00000064U;
enum uint OIEXTF_ANSI_STRING = 0x00000001U;

enum : uint
{
    CPSUICB_REASON_SEL_CHANGED      = 0x00000000U,
    CPSUICB_REASON_PUSHBUTTON       = 0x00000001U,
    CPSUICB_REASON_ECB_CHANGED      = 0x00000002U,
    CPSUICB_REASON_DLGPROC          = 0x00000003U,
    CPSUICB_REASON_UNDO_CHANGES     = 0x00000004U,
    CPSUICB_REASON_EXTPUSH          = 0x00000005U,
    CPSUICB_REASON_APPLYNOW         = 0x00000006U,
    CPSUICB_REASON_OPTITEM_SETFOCUS = 0x00000007U,
    CPSUICB_REASON_ITEMS_REVERTED   = 0x00000008U,
    CPSUICB_REASON_ABOUT            = 0x00000009U,
    CPSUICB_REASON_SETACTIVE        = 0x0000000aU,
    CPSUICB_REASON_KILLACTIVE       = 0x0000000bU,
}

enum : uint
{
    CPSUICB_ACTION_NONE          = 0x00000000U,
    CPSUICB_ACTION_OPTIF_CHANGED = 0x00000001U,
    CPSUICB_ACTION_REINIT_ITEMS  = 0x00000002U,
    CPSUICB_ACTION_NO_APPLY_EXIT = 0x00000003U,
    CPSUICB_ACTION_ITEMS_APPLIED = 0x00000004U,
}

enum uint DP_STD_TREEVIEWPAGE = 0x0000ffffU;

enum : uint
{
    DP_STD_DOCPROPPAGE2 = 0x0000fffeU,
    DP_STD_DOCPROPPAGE1 = 0x0000fffdU,
}

enum uint DP_STD_RESERVED_START = 0x0000fff0U;
enum uint MAX_DLGPAGE_COUNT = 0x00000040U;
enum uint DPF_ICONID_AS_HICON = 0x00000001U;
enum uint DPF_USE_HDLGTEMPLATE = 0x00000002U;
enum uint CPSUIF_UPDATE_PERMISSION = 0x00000001U;
enum uint CPSUIF_ICONID_AS_HICON = 0x00000002U;
enum uint CPSUIF_ABOUT_CALLBACK = 0x00000004U;

enum : uint
{
    CPSFUNC_ADD_HPROPSHEETPAGE   = 0x00000000U,
    CPSFUNC_ADD_PROPSHEETPAGEW   = 0x00000001U,
    CPSFUNC_ADD_PCOMPROPSHEETUIA = 0x00000002U,
    CPSFUNC_ADD_PCOMPROPSHEETUIW = 0x00000003U,
    CPSFUNC_ADD_PFNPROPSHEETUIA  = 0x00000004U,
    CPSFUNC_ADD_PFNPROPSHEETUIW  = 0x00000005U,
}

enum uint CPSFUNC_DELETE_HCOMPROPSHEET = 0x00000006U;
enum uint CPSFUNC_SET_HSTARTPAGE = 0x00000007U;
enum uint CPSFUNC_GET_PAGECOUNT = 0x00000008U;

enum : uint
{
    CPSFUNC_SET_RESULT     = 0x00000009U,
    CPSFUNC_GET_HPSUIPAGES = 0x0000000aU,
}

enum : uint
{
    CPSFUNC_LOAD_CPSUI_STRINGA = 0x0000000bU,
    CPSFUNC_LOAD_CPSUI_STRINGW = 0x0000000cU,
    CPSFUNC_LOAD_CPSUI_ICON    = 0x0000000dU,
}

enum uint CPSFUNC_GET_PFNPROPSHEETUI_ICON = 0x0000000eU;
enum uint CPSFUNC_ADD_PROPSHEETPAGEA = 0x0000000fU;

enum : uint
{
    CPSFUNC_INSERT_PSUIPAGEA = 0x00000010U,
    CPSFUNC_INSERT_PSUIPAGEW = 0x00000011U,
}

enum : uint
{
    CPSFUNC_SET_PSUIPAGE_TITLEA = 0x00000012U,
    CPSFUNC_SET_PSUIPAGE_TITLEW = 0x00000013U,
    CPSFUNC_SET_PSUIPAGE_ICON   = 0x00000014U,
    CPSFUNC_SET_DATABLOCK       = 0x00000015U,
}

enum uint CPSFUNC_QUERY_DATABLOCK = 0x00000016U;
enum uint CPSFUNC_SET_DMPUB_HIDEBITS = 0x00000017U;
enum uint CPSFUNC_IGNORE_CPSUI_PSN_APPLY = 0x00000018U;
enum uint CPSFUNC_DO_APPLY_CPSUI = 0x00000019U;
enum uint CPSFUNC_SET_FUSION_CONTEXT = 0x0000001aU;
enum uint MAX_CPSFUNC_INDEX = 0x0000001aU;

enum : uint
{
    CPSFUNC_ADD_PCOMPROPSHEETUI = 0x00000003U,
    CPSFUNC_ADD_PFNPROPSHEETUI  = 0x00000005U,
}

enum uint CPSFUNC_LOAD_CPSUI_STRING = 0x0000000cU;
enum uint CPSFUNC_ADD_PROPSHEETPAGE = 0x00000001U;
enum uint CPSFUNC_INSERT_PSUIPAGE = 0x00000011U;
enum uint CPSFUNC_SET_PSUIPAGE_TITLE = 0x00000013U;

enum : uint
{
    SR_OWNER        = 0x00000000U,
    SR_OWNER_PARENT = 0x00000001U,
}

enum : uint
{
    PSUIPAGEINSERT_GROUP_PARENT    = 0x00000000U,
    PSUIPAGEINSERT_PCOMPROPSHEETUI = 0x00000001U,
    PSUIPAGEINSERT_PFNPROPSHEETUI  = 0x00000002U,
    PSUIPAGEINSERT_PROPSHEETPAGE   = 0x00000003U,
    PSUIPAGEINSERT_HPROPSHEETPAGE  = 0x00000004U,
    PSUIPAGEINSERT_DLL             = 0x00000005U,
}

enum uint MAX_PSUIPAGEINSERT_INDEX = 0x00000005U;

enum : uint
{
    INSPSUIPAGE_MODE_BEFORE      = 0x00000000U,
    INSPSUIPAGE_MODE_AFTER       = 0x00000001U,
    INSPSUIPAGE_MODE_FIRST_CHILD = 0x00000002U,
    INSPSUIPAGE_MODE_LAST_CHILD  = 0x00000003U,
    INSPSUIPAGE_MODE_INDEX       = 0x00000004U,
}

enum uint SSP_TVPAGE = 0x00002710U;

enum : uint
{
    SSP_STDPAGE1 = 0x00002711U,
    SSP_STDPAGE2 = 0x00002712U,
}

enum : uint
{
    APPLYCPSUI_NO_NEWDEF        = 0x00000001U,
    APPLYCPSUI_OK_CANCEL_BUTTON = 0x00000002U,
}

enum : uint
{
    PROPSHEETUI_REASON_INIT            = 0x00000000U,
    PROPSHEETUI_REASON_GET_INFO_HEADER = 0x00000001U,
    PROPSHEETUI_REASON_DESTROY         = 0x00000002U,
    PROPSHEETUI_REASON_SET_RESULT      = 0x00000003U,
    PROPSHEETUI_REASON_GET_ICON        = 0x00000004U,
    PROPSHEETUI_REASON_BEFORE_INIT     = 0x00000005U,
}

enum uint MAX_PROPSHEETUI_REASON_INDEX = 0x00000005U;
enum uint PROPSHEETUI_INFO_VERSION = 0x00000100U;
enum uint PSUIINFO_UNICODE = 0x00000001U;

enum : uint
{
    PSUIHDRF_OBSOLETE     = 0x00000001U,
    PSUIHDRF_NOAPPLYNOW   = 0x00000002U,
    PSUIHDRF_PROPTITLE    = 0x00000004U,
    PSUIHDRF_USEHICON     = 0x00000008U,
    PSUIHDRF_DEFTITLE     = 0x00000010U,
    PSUIHDRF_EXACT_PTITLE = 0x00000020U,
}

enum : uint
{
    CPSUI_CANCEL         = 0x00000000U,
    CPSUI_OK             = 0x00000001U,
    CPSUI_RESTARTWINDOWS = 0x00000002U,
}

enum uint CPSUI_REBOOTSYSTEM = 0x00000003U;

enum : int
{
    ERR_CPSUI_GETLASTERROR    = 0xffffffff,
    ERR_CPSUI_ALLOCMEM_FAILED = 0xfffffffe,
}

enum : int
{
    ERR_CPSUI_INVALID_PDATA    = 0xfffffffd,
    ERR_CPSUI_INVALID_LPARAM   = 0xfffffffc,
    ERR_CPSUI_NULL_HINST       = 0xfffffffb,
    ERR_CPSUI_NULL_CALLERNAME  = 0xfffffffa,
    ERR_CPSUI_NULL_OPTITEMNAME = 0xfffffff9,
    ERR_CPSUI_NO_PROPSHEETPAGE = 0xfffffff8,
}

enum int ERR_CPSUI_TOO_MANY_PROPSHEETPAGES = 0xfffffff7;
enum int ERR_CPSUI_CREATEPROPPAGE_FAILED = 0xfffffff6;

enum : int
{
    ERR_CPSUI_MORE_THAN_ONE_TVPAGE  = 0xfffffff5,
    ERR_CPSUI_MORE_THAN_ONE_STDPAGE = 0xfffffff4,
}

enum : int
{
    ERR_CPSUI_INVALID_PDLGPAGE       = 0xfffffff3,
    ERR_CPSUI_INVALID_DLGPAGE_CBSIZE = 0xfffffff2,
}

enum int ERR_CPSUI_TOO_MANY_DLGPAGES = 0xfffffff1;
enum int ERR_CPSUI_INVALID_DLGPAGEIDX = 0xfffffff0;
enum int ERR_CPSUI_SUBITEM_DIFF_DLGPAGEIDX = 0xffffffef;

enum : int
{
    ERR_CPSUI_NULL_POPTITEM          = 0xffffffee,
    ERR_CPSUI_INVALID_OPTITEM_CBSIZE = 0xffffffed,
    ERR_CPSUI_INVALID_OPTTYPE_CBSIZE = 0xffffffec,
    ERR_CPSUI_INVALID_OPTTYPE_COUNT  = 0xffffffeb,
}

enum : int
{
    ERR_CPSUI_NULL_POPTPARAM           = 0xffffffea,
    ERR_CPSUI_INVALID_OPTPARAM_CBSIZE  = 0xffffffe9,
    ERR_CPSUI_INVALID_EDITBOX_PSEL     = 0xffffffe8,
    ERR_CPSUI_INVALID_EDITBOX_BUF_SIZE = 0xffffffe7,
    ERR_CPSUI_INVALID_ECB_CBSIZE       = 0xffffffe6,
}

enum : int
{
    ERR_CPSUI_NULL_ECB_PTITLE       = 0xffffffe5,
    ERR_CPSUI_NULL_ECB_PCHECKEDNAME = 0xffffffe4,
}

enum : int
{
    ERR_CPSUI_INVALID_DMPUBID    = 0xffffffe3,
    ERR_CPSUI_INVALID_DMPUB_TVOT = 0xffffffe2,
}

enum : int
{
    ERR_CPSUI_CREATE_TRACKBAR_FAILED  = 0xffffffe1,
    ERR_CPSUI_CREATE_UDARROW_FAILED   = 0xffffffe0,
    ERR_CPSUI_CREATE_IMAGELIST_FAILED = 0xffffffdf,
}

enum : int
{
    ERR_CPSUI_INVALID_TVOT_TYPE = 0xffffffde,
    ERR_CPSUI_INVALID_LBCB_TYPE = 0xffffffdd,
}

enum int ERR_CPSUI_SUBITEM_DIFF_OPTIF_HIDE = 0xffffffdc;

enum : int
{
    ERR_CPSUI_INVALID_PUSHBUTTON_TYPE = 0xffffffda,
    ERR_CPSUI_INVALID_EXTPUSH_CBSIZE  = 0xffffffd9,
}

enum int ERR_CPSUI_NULL_EXTPUSH_DLGPROC = 0xffffffd8;
enum int ERR_CPSUI_NO_EXTPUSH_DLGTEMPLATEID = 0xffffffd7;
enum int ERR_CPSUI_NULL_EXTPUSH_CALLBACK = 0xffffffd6;
enum int ERR_CPSUI_DMCOPIES_USE_EXTPUSH = 0xffffffd5;

enum : int
{
    ERR_CPSUI_ZERO_OPTITEM             = 0xffffffd4,
    ERR_CPSUI_FUNCTION_NOT_IMPLEMENTED = 0xffffd8f1,
}

enum int ERR_CPSUI_INTERNAL_ERROR = 0xffffd8f0;

enum : uint
{
    IDI_CPSUI_ICONID_FIRST      = 0x0000fa00U,
    IDI_CPSUI_EMPTY             = 0x0000fa00U,
    IDI_CPSUI_SEL_NONE          = 0x0000fa01U,
    IDI_CPSUI_WARNING           = 0x0000fa02U,
    IDI_CPSUI_NO                = 0x0000fa03U,
    IDI_CPSUI_YES               = 0x0000fa04U,
    IDI_CPSUI_FALSE             = 0x0000fa05U,
    IDI_CPSUI_TRUE              = 0x0000fa06U,
    IDI_CPSUI_OFF               = 0x0000fa07U,
    IDI_CPSUI_ON                = 0x0000fa08U,
    IDI_CPSUI_PAPER_OUTPUT      = 0x0000fa09U,
    IDI_CPSUI_ENVELOPE          = 0x0000fa0aU,
    IDI_CPSUI_MEM               = 0x0000fa0bU,
    IDI_CPSUI_FONTCARTHDR       = 0x0000fa0cU,
    IDI_CPSUI_FONTCART          = 0x0000fa0dU,
    IDI_CPSUI_STAPLER_ON        = 0x0000fa0eU,
    IDI_CPSUI_STAPLER_OFF       = 0x0000fa0fU,
    IDI_CPSUI_HT_HOST           = 0x0000fa10U,
    IDI_CPSUI_HT_DEVICE         = 0x0000fa11U,
    IDI_CPSUI_TT_PRINTASGRAPHIC = 0x0000fa12U,
    IDI_CPSUI_TT_DOWNLOADSOFT   = 0x0000fa13U,
    IDI_CPSUI_TT_DOWNLOADVECT   = 0x0000fa14U,
    IDI_CPSUI_TT_SUBDEV         = 0x0000fa15U,
    IDI_CPSUI_PORTRAIT          = 0x0000fa16U,
    IDI_CPSUI_LANDSCAPE         = 0x0000fa17U,
    IDI_CPSUI_ROT_LAND          = 0x0000fa18U,
    IDI_CPSUI_AUTOSEL           = 0x0000fa19U,
    IDI_CPSUI_PAPER_TRAY        = 0x0000fa1aU,
    IDI_CPSUI_PAPER_TRAY2       = 0x0000fa1bU,
    IDI_CPSUI_PAPER_TRAY3       = 0x0000fa1cU,
    IDI_CPSUI_TRANSPARENT       = 0x0000fa1dU,
    IDI_CPSUI_COLLATE           = 0x0000fa1eU,
    IDI_CPSUI_DUPLEX_NONE       = 0x0000fa1fU,
    IDI_CPSUI_DUPLEX_HORZ       = 0x0000fa20U,
    IDI_CPSUI_DUPLEX_VERT       = 0x0000fa21U,
    IDI_CPSUI_RES_DRAFT         = 0x0000fa22U,
    IDI_CPSUI_RES_LOW           = 0x0000fa23U,
    IDI_CPSUI_RES_MEDIUM        = 0x0000fa24U,
    IDI_CPSUI_RES_HIGH          = 0x0000fa25U,
    IDI_CPSUI_RES_PRESENTATION  = 0x0000fa26U,
}

enum : uint
{
    IDI_CPSUI_MONO            = 0x0000fa27U,
    IDI_CPSUI_COLOR           = 0x0000fa28U,
    IDI_CPSUI_DITHER_NONE     = 0x0000fa29U,
    IDI_CPSUI_DITHER_COARSE   = 0x0000fa2aU,
    IDI_CPSUI_DITHER_FINE     = 0x0000fa2bU,
    IDI_CPSUI_DITHER_LINEART  = 0x0000fa2cU,
    IDI_CPSUI_SCALING         = 0x0000fa2dU,
    IDI_CPSUI_COPY            = 0x0000fa2eU,
    IDI_CPSUI_HTCLRADJ        = 0x0000fa2fU,
    IDI_CPSUI_HALFTONE_SETUP  = 0x0000fa30U,
    IDI_CPSUI_WATERMARK       = 0x0000fa31U,
    IDI_CPSUI_ERROR           = 0x0000fa32U,
    IDI_CPSUI_ICM_OPTION      = 0x0000fa33U,
    IDI_CPSUI_ICM_METHOD      = 0x0000fa34U,
    IDI_CPSUI_ICM_INTENT      = 0x0000fa35U,
    IDI_CPSUI_STD_FORM        = 0x0000fa36U,
    IDI_CPSUI_OUTBIN          = 0x0000fa37U,
    IDI_CPSUI_OUTPUT          = 0x0000fa38U,
    IDI_CPSUI_GRAPHIC         = 0x0000fa39U,
    IDI_CPSUI_ADVANCE         = 0x0000fa3aU,
    IDI_CPSUI_DOCUMENT        = 0x0000fa3bU,
    IDI_CPSUI_DEVICE          = 0x0000fa3cU,
    IDI_CPSUI_DEVICE2         = 0x0000fa3dU,
    IDI_CPSUI_PRINTER         = 0x0000fa3eU,
    IDI_CPSUI_PRINTER2        = 0x0000fa3fU,
    IDI_CPSUI_PRINTER3        = 0x0000fa40U,
    IDI_CPSUI_PRINTER4        = 0x0000fa41U,
    IDI_CPSUI_OPTION          = 0x0000fa42U,
    IDI_CPSUI_OPTION2         = 0x0000fa43U,
    IDI_CPSUI_STOP            = 0x0000fa44U,
    IDI_CPSUI_NOTINSTALLED    = 0x0000fa45U,
    IDI_CPSUI_WARNING_OVERLAY = 0x0000fa46U,
}

enum uint IDI_CPSUI_STOP_WARNING_OVERLAY = 0x0000fa47U;

enum : uint
{
    IDI_CPSUI_GENERIC_OPTION     = 0x0000fa48U,
    IDI_CPSUI_GENERIC_ITEM       = 0x0000fa49U,
    IDI_CPSUI_RUN_DIALOG         = 0x0000fa4aU,
    IDI_CPSUI_QUESTION           = 0x0000fa4bU,
    IDI_CPSUI_FORMTRAYASSIGN     = 0x0000fa4cU,
    IDI_CPSUI_PRINTER_FOLDER     = 0x0000fa4dU,
    IDI_CPSUI_INSTALLABLE_OPTION = 0x0000fa4eU,
}

enum uint IDI_CPSUI_PRINTER_FEATURE = 0x0000fa4fU;

enum : uint
{
    IDI_CPSUI_DEVICE_FEATURE    = 0x0000fa50U,
    IDI_CPSUI_FONTSUB           = 0x0000fa51U,
    IDI_CPSUI_POSTSCRIPT        = 0x0000fa52U,
    IDI_CPSUI_TELEPHONE         = 0x0000fa53U,
    IDI_CPSUI_DUPLEX_NONE_L     = 0x0000fa54U,
    IDI_CPSUI_DUPLEX_HORZ_L     = 0x0000fa55U,
    IDI_CPSUI_DUPLEX_VERT_L     = 0x0000fa56U,
    IDI_CPSUI_LF_PEN_PLOTTER    = 0x0000fa57U,
    IDI_CPSUI_SF_PEN_PLOTTER    = 0x0000fa58U,
    IDI_CPSUI_LF_RASTER_PLOTTER = 0x0000fa59U,
}

enum uint IDI_CPSUI_SF_RASTER_PLOTTER = 0x0000fa5aU;

enum : uint
{
    IDI_CPSUI_ROLL_PAPER             = 0x0000fa5bU,
    IDI_CPSUI_PEN_CARROUSEL          = 0x0000fa5cU,
    IDI_CPSUI_PLOTTER_PEN            = 0x0000fa5dU,
    IDI_CPSUI_MANUAL_FEED            = 0x0000fa5eU,
    IDI_CPSUI_FAX                    = 0x0000fa5fU,
    IDI_CPSUI_PAGE_PROTECT           = 0x0000fa60U,
    IDI_CPSUI_ENVELOPE_FEED          = 0x0000fa61U,
    IDI_CPSUI_FONTCART_SLOT          = 0x0000fa62U,
    IDI_CPSUI_LAYOUT_BMP_PORTRAIT    = 0x0000fa63U,
    IDI_CPSUI_LAYOUT_BMP_ARROWL      = 0x0000fa64U,
    IDI_CPSUI_LAYOUT_BMP_ARROWS      = 0x0000fa65U,
    IDI_CPSUI_LAYOUT_BMP_BOOKLETL    = 0x0000fa66U,
    IDI_CPSUI_LAYOUT_BMP_BOOKLETP    = 0x0000fa67U,
    IDI_CPSUI_LAYOUT_BMP_ARROWLR     = 0x0000fa68U,
    IDI_CPSUI_LAYOUT_BMP_ROT_PORT    = 0x0000fa69U,
    IDI_CPSUI_LAYOUT_BMP_BOOKLETL_NB = 0x0000fa6aU,
    IDI_CPSUI_LAYOUT_BMP_BOOKLETP_NB = 0x0000fa6bU,
}

enum : uint
{
    IDI_CPSUI_ROT_PORT    = 0x0000fa6eU,
    IDI_CPSUI_NUP_BORDER  = 0x0000fa6fU,
    IDI_CPSUI_ICONID_LAST = 0x0000fa6fU,
}

enum : uint
{
    IDS_CPSUI_STRID_FIRST     = 0x0000fcbcU,
    IDS_CPSUI_SETUP           = 0x0000fcbcU,
    IDS_CPSUI_MORE            = 0x0000fcbdU,
    IDS_CPSUI_CHANGE          = 0x0000fcbeU,
    IDS_CPSUI_OPTION          = 0x0000fcbfU,
    IDS_CPSUI_OF              = 0x0000fcc0U,
    IDS_CPSUI_RANGE_FROM      = 0x0000fcc1U,
    IDS_CPSUI_TO              = 0x0000fcc2U,
    IDS_CPSUI_COLON_SEP       = 0x0000fcc3U,
    IDS_CPSUI_LEFT_ANGLE      = 0x0000fcc4U,
    IDS_CPSUI_RIGHT_ANGLE     = 0x0000fcc5U,
    IDS_CPSUI_SLASH_SEP       = 0x0000fcc6U,
    IDS_CPSUI_PERCENT         = 0x0000fcc7U,
    IDS_CPSUI_LBCB_NOSEL      = 0x0000fcc8U,
    IDS_CPSUI_PROPERTIES      = 0x0000fcc9U,
    IDS_CPSUI_DEFAULTDOCUMENT = 0x0000fccaU,
    IDS_CPSUI_DOCUMENT        = 0x0000fccbU,
    IDS_CPSUI_ADVANCEDOCUMENT = 0x0000fcccU,
}

enum : uint
{
    IDS_CPSUI_PRINTER         = 0x0000fccdU,
    IDS_CPSUI_AUTOSELECT      = 0x0000fcceU,
    IDS_CPSUI_PAPER_OUTPUT    = 0x0000fccfU,
    IDS_CPSUI_GRAPHIC         = 0x0000fcd0U,
    IDS_CPSUI_OPTIONS         = 0x0000fcd1U,
    IDS_CPSUI_ADVANCED        = 0x0000fcd2U,
    IDS_CPSUI_STDDOCPROPTAB   = 0x0000fcd3U,
    IDS_CPSUI_STDDOCPROPTVTAB = 0x0000fcd4U,
}

enum : uint
{
    IDS_CPSUI_DEVICEOPTIONS   = 0x0000fcd5U,
    IDS_CPSUI_FALSE           = 0x0000fcd6U,
    IDS_CPSUI_TRUE            = 0x0000fcd7U,
    IDS_CPSUI_NO              = 0x0000fcd8U,
    IDS_CPSUI_YES             = 0x0000fcd9U,
    IDS_CPSUI_OFF             = 0x0000fcdaU,
    IDS_CPSUI_ON              = 0x0000fcdbU,
    IDS_CPSUI_DEFAULT         = 0x0000fcdcU,
    IDS_CPSUI_ERROR           = 0x0000fcddU,
    IDS_CPSUI_NONE            = 0x0000fcdeU,
    IDS_CPSUI_NOT             = 0x0000fcdfU,
    IDS_CPSUI_EXIST           = 0x0000fce0U,
    IDS_CPSUI_NOTINSTALLED    = 0x0000fce1U,
    IDS_CPSUI_ORIENTATION     = 0x0000fce2U,
    IDS_CPSUI_SCALING         = 0x0000fce3U,
    IDS_CPSUI_NUM_OF_COPIES   = 0x0000fce4U,
    IDS_CPSUI_SOURCE          = 0x0000fce5U,
    IDS_CPSUI_PRINTQUALITY    = 0x0000fce6U,
    IDS_CPSUI_RESOLUTION      = 0x0000fce7U,
    IDS_CPSUI_COLOR_APPERANCE = 0x0000fce8U,
}

enum : uint
{
    IDS_CPSUI_DUPLEX          = 0x0000fce9U,
    IDS_CPSUI_TTOPTION        = 0x0000fceaU,
    IDS_CPSUI_FORMNAME        = 0x0000fcebU,
    IDS_CPSUI_ICM             = 0x0000fcecU,
    IDS_CPSUI_ICMMETHOD       = 0x0000fcedU,
    IDS_CPSUI_ICMINTENT       = 0x0000fceeU,
    IDS_CPSUI_MEDIA           = 0x0000fcefU,
    IDS_CPSUI_DITHERING       = 0x0000fcf0U,
    IDS_CPSUI_PORTRAIT        = 0x0000fcf1U,
    IDS_CPSUI_LANDSCAPE       = 0x0000fcf2U,
    IDS_CPSUI_ROT_LAND        = 0x0000fcf3U,
    IDS_CPSUI_COLLATE         = 0x0000fcf4U,
    IDS_CPSUI_COLLATED        = 0x0000fcf5U,
    IDS_CPSUI_PRINTFLDSETTING = 0x0000fcf6U,
}

enum : uint
{
    IDS_CPSUI_DRAFT             = 0x0000fcf7U,
    IDS_CPSUI_LOW               = 0x0000fcf8U,
    IDS_CPSUI_MEDIUM            = 0x0000fcf9U,
    IDS_CPSUI_HIGH              = 0x0000fcfaU,
    IDS_CPSUI_PRESENTATION      = 0x0000fcfbU,
    IDS_CPSUI_COLOR             = 0x0000fcfcU,
    IDS_CPSUI_GRAYSCALE         = 0x0000fcfdU,
    IDS_CPSUI_MONOCHROME        = 0x0000fcfeU,
    IDS_CPSUI_SIMPLEX           = 0x0000fcffU,
    IDS_CPSUI_HORIZONTAL        = 0x0000fd00U,
    IDS_CPSUI_VERTICAL          = 0x0000fd01U,
    IDS_CPSUI_LONG_SIDE         = 0x0000fd02U,
    IDS_CPSUI_SHORT_SIDE        = 0x0000fd03U,
    IDS_CPSUI_TT_PRINTASGRAPHIC = 0x0000fd04U,
    IDS_CPSUI_TT_DOWNLOADSOFT   = 0x0000fd05U,
    IDS_CPSUI_TT_DOWNLOADVECT   = 0x0000fd06U,
    IDS_CPSUI_TT_SUBDEV         = 0x0000fd07U,
    IDS_CPSUI_ICM_BLACKWHITE    = 0x0000fd08U,
    IDS_CPSUI_ICM_NO            = 0x0000fd09U,
    IDS_CPSUI_ICM_YES           = 0x0000fd0aU,
    IDS_CPSUI_ICM_SATURATION    = 0x0000fd0bU,
    IDS_CPSUI_ICM_CONTRAST      = 0x0000fd0cU,
    IDS_CPSUI_ICM_COLORMETRIC   = 0x0000fd0dU,
}

enum : uint
{
    IDS_CPSUI_STANDARD        = 0x0000fd0eU,
    IDS_CPSUI_GLOSSY          = 0x0000fd0fU,
    IDS_CPSUI_TRANSPARENCY    = 0x0000fd10U,
    IDS_CPSUI_REGULAR         = 0x0000fd11U,
    IDS_CPSUI_BOND            = 0x0000fd12U,
    IDS_CPSUI_COARSE          = 0x0000fd13U,
    IDS_CPSUI_FINE            = 0x0000fd14U,
    IDS_CPSUI_LINEART         = 0x0000fd15U,
    IDS_CPSUI_ERRDIFFUSE      = 0x0000fd16U,
    IDS_CPSUI_HALFTONE        = 0x0000fd17U,
    IDS_CPSUI_HTCLRADJ        = 0x0000fd18U,
    IDS_CPSUI_USE_HOST_HT     = 0x0000fd19U,
    IDS_CPSUI_USE_DEVICE_HT   = 0x0000fd1aU,
    IDS_CPSUI_USE_PRINTER_HT  = 0x0000fd1bU,
    IDS_CPSUI_OUTBINASSIGN    = 0x0000fd1cU,
    IDS_CPSUI_WATERMARK       = 0x0000fd1dU,
    IDS_CPSUI_FORMTRAYASSIGN  = 0x0000fd1eU,
    IDS_CPSUI_UPPER_TRAY      = 0x0000fd1fU,
    IDS_CPSUI_ONLYONE         = 0x0000fd20U,
    IDS_CPSUI_LOWER_TRAY      = 0x0000fd21U,
    IDS_CPSUI_MIDDLE_TRAY     = 0x0000fd22U,
    IDS_CPSUI_MANUAL_TRAY     = 0x0000fd23U,
    IDS_CPSUI_ENVELOPE_TRAY   = 0x0000fd24U,
    IDS_CPSUI_ENVMANUAL_TRAY  = 0x0000fd25U,
    IDS_CPSUI_TRACTOR_TRAY    = 0x0000fd26U,
    IDS_CPSUI_SMALLFMT_TRAY   = 0x0000fd27U,
    IDS_CPSUI_LARGEFMT_TRAY   = 0x0000fd28U,
    IDS_CPSUI_LARGECAP_TRAY   = 0x0000fd29U,
    IDS_CPSUI_CASSETTE_TRAY   = 0x0000fd2aU,
    IDS_CPSUI_DEFAULT_TRAY    = 0x0000fd2bU,
    IDS_CPSUI_FORMSOURCE      = 0x0000fd2cU,
    IDS_CPSUI_MANUALFEED      = 0x0000fd2dU,
    IDS_CPSUI_PRINTERMEM_KB   = 0x0000fd2eU,
    IDS_CPSUI_PRINTERMEM_MB   = 0x0000fd2fU,
    IDS_CPSUI_PAGEPROTECT     = 0x0000fd30U,
    IDS_CPSUI_HALFTONE_SETUP  = 0x0000fd31U,
    IDS_CPSUI_INSTFONTCART    = 0x0000fd32U,
    IDS_CPSUI_SLOT1           = 0x0000fd33U,
    IDS_CPSUI_SLOT2           = 0x0000fd34U,
    IDS_CPSUI_SLOT3           = 0x0000fd35U,
    IDS_CPSUI_SLOT4           = 0x0000fd36U,
    IDS_CPSUI_LEFT_SLOT       = 0x0000fd37U,
    IDS_CPSUI_RIGHT_SLOT      = 0x0000fd38U,
    IDS_CPSUI_STAPLER         = 0x0000fd39U,
    IDS_CPSUI_STAPLER_ON      = 0x0000fd3aU,
    IDS_CPSUI_STAPLER_OFF     = 0x0000fd3bU,
    IDS_CPSUI_STACKER         = 0x0000fd3cU,
    IDS_CPSUI_MAILBOX         = 0x0000fd3dU,
    IDS_CPSUI_COPY            = 0x0000fd3eU,
    IDS_CPSUI_COPIES          = 0x0000fd3fU,
    IDS_CPSUI_TOTAL           = 0x0000fd40U,
    IDS_CPSUI_MAKE            = 0x0000fd41U,
    IDS_CPSUI_PRINT           = 0x0000fd42U,
    IDS_CPSUI_FAX             = 0x0000fd43U,
    IDS_CPSUI_PLOT            = 0x0000fd44U,
    IDS_CPSUI_SLOW            = 0x0000fd45U,
    IDS_CPSUI_FAST            = 0x0000fd46U,
    IDS_CPSUI_ROTATED         = 0x0000fd47U,
    IDS_CPSUI_RESET           = 0x0000fd48U,
    IDS_CPSUI_ALL             = 0x0000fd49U,
    IDS_CPSUI_DEVICE          = 0x0000fd4aU,
    IDS_CPSUI_SETTINGS        = 0x0000fd4bU,
    IDS_CPSUI_REVERT          = 0x0000fd4cU,
    IDS_CPSUI_CHANGES         = 0x0000fd4dU,
    IDS_CPSUI_CHANGED         = 0x0000fd4eU,
    IDS_CPSUI_WARNING         = 0x0000fd4fU,
    IDS_CPSUI_ABOUT           = 0x0000fd50U,
    IDS_CPSUI_VERSION         = 0x0000fd51U,
    IDS_CPSUI_NO_NAME         = 0x0000fd52U,
    IDS_CPSUI_SETTING         = 0x0000fd53U,
    IDS_CPSUI_DEVICE_SETTINGS = 0x0000fd54U,
}

enum : uint
{
    IDS_CPSUI_STDDOCPROPTAB1   = 0x0000fd55U,
    IDS_CPSUI_STDDOCPROPTAB2   = 0x0000fd56U,
    IDS_CPSUI_PAGEORDER        = 0x0000fd57U,
    IDS_CPSUI_FRONTTOBACK      = 0x0000fd58U,
    IDS_CPSUI_BACKTOFRONT      = 0x0000fd59U,
    IDS_CPSUI_QUALITY_SETTINGS = 0x0000fd5aU,
    IDS_CPSUI_QUALITY_DRAFT    = 0x0000fd5bU,
    IDS_CPSUI_QUALITY_BETTER   = 0x0000fd5cU,
    IDS_CPSUI_QUALITY_BEST     = 0x0000fd5dU,
    IDS_CPSUI_QUALITY_CUSTOM   = 0x0000fd5eU,
    IDS_CPSUI_OUTPUTBIN        = 0x0000fd5fU,
    IDS_CPSUI_NUP              = 0x0000fd60U,
    IDS_CPSUI_NUP_NORMAL       = 0x0000fd61U,
    IDS_CPSUI_NUP_TWOUP        = 0x0000fd62U,
    IDS_CPSUI_NUP_FOURUP       = 0x0000fd63U,
    IDS_CPSUI_NUP_SIXUP        = 0x0000fd64U,
    IDS_CPSUI_NUP_NINEUP       = 0x0000fd65U,
    IDS_CPSUI_NUP_SIXTEENUP    = 0x0000fd66U,
    IDS_CPSUI_SIDE1            = 0x0000fd67U,
    IDS_CPSUI_SIDE2            = 0x0000fd68U,
    IDS_CPSUI_BOOKLET          = 0x0000fd69U,
    IDS_CPSUI_POSTER           = 0x0000fd6aU,
    IDS_CPSUI_POSTER_2x2       = 0x0000fd6bU,
    IDS_CPSUI_POSTER_3x3       = 0x0000fd6cU,
    IDS_CPSUI_POSTER_4x4       = 0x0000fd6dU,
    IDS_CPSUI_NUP_DIRECTION    = 0x0000fd6eU,
    IDS_CPSUI_RIGHT_THEN_DOWN  = 0x0000fd6fU,
}

enum uint IDS_CPSUI_DOWN_THEN_RIGHT = 0x0000fd70U;

enum : uint
{
    IDS_CPSUI_LEFT_THEN_DOWN    = 0x0000fd71U,
    IDS_CPSUI_DOWN_THEN_LEFT    = 0x0000fd72U,
    IDS_CPSUI_MANUAL_DUPLEX     = 0x0000fd73U,
    IDS_CPSUI_MANUAL_DUPLEX_ON  = 0x0000fd74U,
    IDS_CPSUI_MANUAL_DUPLEX_OFF = 0x0000fd75U,
}

enum : uint
{
    IDS_CPSUI_ROT_PORT           = 0x0000fd76U,
    IDS_CPSUI_STAPLE             = 0x0000fd77U,
    IDS_CPSUI_BOOKLET_EDGE       = 0x0000fd78U,
    IDS_CPSUI_BOOKLET_EDGE_LEFT  = 0x0000fd79U,
    IDS_CPSUI_BOOKLET_EDGE_RIGHT = 0x0000fd7aU,
}

enum : uint
{
    IDS_CPSUI_NUP_BORDER   = 0x0000fd7bU,
    IDS_CPSUI_NUP_BORDERED = 0x0000fd7cU,
    IDS_CPSUI_STRID_LAST   = 0x0000fd7cU,
}

enum : const(wchar)*
{
    XPS_FP_PRINTER_NAME    = "PrinterName",
    XPS_FP_PROGRESS_REPORT = "ProgressReport",
    XPS_FP_PRINTER_HANDLE  = "PrinterHandle",
}

enum : const(wchar)*
{
    XPS_FP_USER_PRINT_TICKET   = "PerUserPrintTicket",
    XPS_FP_USER_TOKEN          = "UserSecurityToken",
    XPS_FP_JOB_ID              = "PrintJobId",
    XPS_FP_PRINT_CLASS_FACTORY = "PrintClassFactory",
}

enum const(wchar)* XPS_FP_OUTPUT_FILE = "PrintOutputFileName";

enum : const(wchar)*
{
    XPS_FP_MS_CONTENT_TYPE         = "DriverMultiContentType",
    XPS_FP_MS_CONTENT_TYPE_XPS     = "XPS",
    XPS_FP_MS_CONTENT_TYPE_OPENXPS = "OpenXPS",
}

enum const(wchar)* XPS_FP_DRIVER_PROPERTY_BAG = "DriverPropertyBag";
enum const(wchar)* XPS_FP_QUEUE_PROPERTY_BAG = "QueuePropertyBag";
enum const(wchar)* XPS_FP_MERGED_DATAFILE_PATH = "MergedDataFilePath";
enum const(wchar)* XPS_FP_RESOURCE_DLL_PATHS = "ResourceDLLPaths";
enum const(wchar)* XPS_FP_JOB_LEVEL_PRINTTICKET = "JobPrintTicket";
enum const(wchar)* XPS_FP_PRINTDEVICECAPABILITIES = "PrintDeviceCapabilities";
enum const(wchar)* XPS_FP_FAX_JOB_PROPERTIES = "JobFaxProperties";
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/printdocs/mxdc-escape))], [])*/uint MXDC_ESCAPE = 0x0000101aU;
enum uint MXDCOP_GET_FILENAME = 0x0000000eU;

enum : uint
{
    MXDCOP_PRINTTICKET_FIXED_DOC_SEQ = 0x00000016U,
    MXDCOP_PRINTTICKET_FIXED_DOC     = 0x00000018U,
    MXDCOP_PRINTTICKET_FIXED_PAGE    = 0x0000001aU,
}

enum : uint
{
    MXDCOP_SET_S0PAGE           = 0x0000001cU,
    MXDCOP_SET_S0PAGE_RESOURCE  = 0x0000001eU,
    MXDCOP_SET_XPSPASSTHRU_MODE = 0x00000020U,
}

enum : GUID
{
    CLSID_OEMRENDER     = GUID("6d6abf26-9f38-11d1-882a-00c04fb961ec"),
    CLSID_OEMUI         = GUID("abce80d7-9f46-11d1-882a-00c04fb961ec"),
    CLSID_OEMUIMXDC     = GUID("4e144300-5b43-4288-932a-5e4dd6d82bed"),
    CLSID_OEMPTPROVIDER = GUID("91723892-45d2-48e2-9ec9-562379daf992"),
}

enum HRESULT S_DEVCAP_OUTPUT_FULL_REPLACEMENT = HRESULT(0x0004dc01);
enum GUID CLSID_PTPROVIDER = GUID("46ac151b-8490-4531-96cc-55bf2bf19e11");
enum uint E_VERSION_NOT_SUPPORTED = 0x80040001U;
enum uint S_NO_CONFLICT = 0x00040001U;
enum uint S_CONFLICT_RESOLVED = 0x00040002U;
enum GUID PRINTER_EXTENSION_DETAILEDREASON_PRINTER_STATUS = GUID("5d5a1704-dfd1-4181-8eee-815c86edad31");

enum : GUID
{
    PRINTER_EXTENSION_REASON_PRINT_PREFERENCES = GUID("ec8f261f-267c-469f-b5d6-3933023c29cc"),
    PRINTER_EXTENSION_REASON_DRIVER_EVENT      = GUID("23bb1328-63de-4293-915b-a6a23d929acb"),
}

enum GUID FMTID_PrinterPropertyBag = GUID("75f9adca-097d-45c3-a6e4-bab29e276f3e");
enum uint PRINTER_OEMINTF_VERSION = 0x00010000U;
enum uint OEM_MODE_PUBLISHER = 0x00000001U;

enum : uint
{
    OEMGI_GETSIGNATURE        = 0x00000001U,
    OEMGI_GETINTERFACEVERSION = 0x00000002U,
}

enum : uint
{
    OEMGI_GETVERSION                   = 0x00000003U,
    OEMGI_GETPUBLISHERINFO             = 0x00000004U,
    OEMGI_GETREQUESTEDHELPERINTERFACES = 0x00000005U,
}

enum : uint
{
    OEMPUBLISH_DEFAULT          = 0x00000000U,
    OEMPUBLISH_IPRINTCOREHELPER = 0x00000001U,
}

enum : uint
{
    OEMDM_SIZE    = 0x00000001U,
    OEMDM_DEFAULT = 0x00000002U,
    OEMDM_CONVERT = 0x00000003U,
    OEMDM_MERGE   = 0x00000004U,
}

enum uint OEMGDS_MIN_DOCSTICKY = 0x00000001U;

enum : uint
{
    OEMGDS_PSDM_FLAGS      = 0x00000001U,
    OEMGDS_PSDM_DIALECT    = 0x00000002U,
    OEMGDS_PSDM_TTDLFMT    = 0x00000003U,
    OEMGDS_PSDM_NUP        = 0x00000004U,
    OEMGDS_PSDM_PSLEVEL    = 0x00000005U,
    OEMGDS_PSDM_CUSTOMSIZE = 0x00000006U,
}

enum : uint
{
    OEMGDS_UNIDM_GPDVER = 0x00004000U,
    OEMGDS_UNIDM_FLAGS  = 0x00004001U,
}

enum uint OEMGDS_MIN_PRINTERSTICKY = 0x00008000U;

enum : uint
{
    OEMGDS_PRINTFLAGS  = 0x00008000U,
    OEMGDS_FREEMEM     = 0x00008001U,
    OEMGDS_JOBTIMEOUT  = 0x00008002U,
    OEMGDS_WAITTIMEOUT = 0x00008003U,
}

enum : uint
{
    OEMGDS_PROTOCOL   = 0x00008004U,
    OEMGDS_MINOUTLINE = 0x00008005U,
    OEMGDS_MAXBITMAP  = 0x00008006U,
    OEMGDS_MAX        = 0x00010000U,
}

enum uint GPD_OEMCUSTOMDATA = 0x00000001U;
enum uint MV_UPDATE = 0x00000001U;
enum uint MV_RELATIVE = 0x00000002U;
enum uint MV_GRAPHICS = 0x00000004U;
enum uint MV_PHYSICAL = 0x00000008U;

enum : uint
{
    MV_SENDXMOVECMD = 0x00000010U,
    MV_SENDYMOVECMD = 0x00000020U,
}

enum : uint
{
    OEMTTY_INFO_MARGINS  = 0x00000001U,
    OEMTTY_INFO_CODEPAGE = 0x00000002U,
    OEMTTY_INFO_NUM_UFMS = 0x00000003U,
    OEMTTY_INFO_UFM_IDS  = 0x00000004U,
}

enum : uint
{
    UFOFLAG_TTFONT               = 0x00000001U,
    UFOFLAG_TTDOWNLOAD_BITMAP    = 0x00000002U,
    UFOFLAG_TTDOWNLOAD_TTOUTLINE = 0x00000004U,
}

enum : uint
{
    UFOFLAG_TTOUTLINE_BOLD_SIM   = 0x00000008U,
    UFOFLAG_TTOUTLINE_ITALIC_SIM = 0x00000010U,
    UFOFLAG_TTOUTLINE_VERTICAL   = 0x00000020U,
}

enum uint UFOFLAG_TTSUBSTITUTED = 0x00000040U;

enum : uint
{
    UFO_GETINFO_FONTOBJ     = 0x00000001U,
    UFO_GETINFO_GLYPHSTRING = 0x00000002U,
    UFO_GETINFO_GLYPHBITMAP = 0x00000003U,
    UFO_GETINFO_GLYPHWIDTH  = 0x00000004U,
    UFO_GETINFO_MEMORY      = 0x00000005U,
    UFO_GETINFO_STDVARIABLE = 0x00000006U,
}

enum uint FNT_INFO_PRINTDIRINCCDEGREES = 0x00000000U;
enum uint FNT_INFO_GRAYPERCENTAGE = 0x00000001U;

enum : uint
{
    FNT_INFO_NEXTFONTID     = 0x00000002U,
    FNT_INFO_NEXTGLYPH      = 0x00000003U,
    FNT_INFO_FONTHEIGHT     = 0x00000004U,
    FNT_INFO_FONTWIDTH      = 0x00000005U,
    FNT_INFO_FONTBOLD       = 0x00000006U,
    FNT_INFO_FONTITALIC     = 0x00000007U,
    FNT_INFO_FONTUNDERLINE  = 0x00000008U,
    FNT_INFO_FONTSTRIKETHRU = 0x00000009U,
}

enum : uint
{
    FNT_INFO_CURRENTFONTID = 0x0000000aU,
    FNT_INFO_TEXTYRES      = 0x0000000bU,
    FNT_INFO_TEXTXRES      = 0x0000000cU,
    FNT_INFO_FONTMAXWIDTH  = 0x0000000dU,
    FNT_INFO_MAX           = 0x0000000eU,
}

enum : uint
{
    TTDOWNLOAD_DONTCARE  = 0x00000000U,
    TTDOWNLOAD_GRAPHICS  = 0x00000001U,
    TTDOWNLOAD_BITMAP    = 0x00000002U,
    TTDOWNLOAD_TTOUTLINE = 0x00000003U,
}

enum : uint
{
    TYPE_UNICODE   = 0x00000001U,
    TYPE_TRANSDATA = 0x00000002U,
}

enum : uint
{
    TYPE_GLYPHHANDLE = 0x00000003U,
    TYPE_GLYPHID     = 0x00000004U,
}

enum uint PDEV_ADJUST_PAPER_MARGIN_TYPE = 0x00000001U;
enum uint PDEV_HOSTFONT_ENABLED_TYPE = 0x00000002U;
enum uint PDEV_USE_TRUE_COLOR_TYPE = 0x00000003U;
enum uint PDEV_ADJUST_GRAPHICS_RESOLUTION_TYPE = 0x00000004U;
enum uint PDEV_ADJUST_IMAGEABLE_ORIGIN_AREA_TYPE = 0x00000008U;
enum uint PDEV_ADJUST_PHYSICAL_PAPER_SIZE_TYPE = 0x00000010U;

enum : uint
{
    OEMCUIP_DOCPROP = 0x00000001U,
    OEMCUIP_PRNPROP = 0x00000002U,
}

enum : uint
{
    CUSTOMPARAM_WIDTH        = 0x00000000U,
    CUSTOMPARAM_HEIGHT       = 0x00000001U,
    CUSTOMPARAM_WIDTHOFFSET  = 0x00000002U,
    CUSTOMPARAM_HEIGHTOFFSET = 0x00000003U,
    CUSTOMPARAM_ORIENTATION  = 0x00000004U,
    CUSTOMPARAM_MAX          = 0x00000005U,
}

enum : uint
{
    SETOPTIONS_FLAG_RESOLVE_CONFLICT = 0x00000001U,
    SETOPTIONS_FLAG_KEEP_CONFLICT    = 0x00000002U,
}

enum : uint
{
    SETOPTIONS_RESULT_NO_CONFLICT       = 0x00000000U,
    SETOPTIONS_RESULT_CONFLICT_RESOLVED = 0x00000001U,
    SETOPTIONS_RESULT_CONFLICT_REMAINED = 0x00000002U,
}

enum uint UNIFM_VERSION_1_0 = 0x00010000U;

enum : uint
{
    UFM_SOFT     = 0x00000001U,
    UFM_CART     = 0x00000002U,
    UFM_SCALABLE = 0x00000004U,
}

enum uint DF_TYPE_HPINTELLIFONT = 0x00000000U;

enum : uint
{
    DF_TYPE_TRUETYPE = 0x00000001U,
    DF_TYPE_PST1     = 0x00000002U,
    DF_TYPE_CAPSL    = 0x00000003U,
    DF_TYPE_OEM1     = 0x00000004U,
    DF_TYPE_OEM2     = 0x00000005U,
}

enum : uint
{
    DF_NOITALIC = 0x00000001U,
    DF_NOUNDER  = 0x00000002U,
}

enum uint DF_XM_CR = 0x00000004U;

enum : uint
{
    DF_NO_BOLD             = 0x00000008U,
    DF_NO_DOUBLE_UNDERLINE = 0x00000010U,
}

enum uint DF_NO_STRIKETHRU = 0x00000020U;
enum uint DF_BKSP_OK = 0x00000040U;
enum uint UNI_GLYPHSETDATA_VERSION_1_0 = 0x00010000U;
enum uint MTYPE_FORMAT_MASK = 0x00000007U;

enum : uint
{
    MTYPE_COMPOSE             = 0x00000001U,
    MTYPE_DIRECT              = 0x00000002U,
    MTYPE_PAIRED              = 0x00000004U,
    MTYPE_DOUBLEBYTECHAR_MASK = 0x00000018U,
}

enum : uint
{
    MTYPE_SINGLE        = 0x00000008U,
    MTYPE_DOUBLE        = 0x00000010U,
    MTYPE_PREDEFIN_MASK = 0x000000e0U,
}

enum : uint
{
    MTYPE_REPLACE = 0x00000020U,
    MTYPE_ADD     = 0x00000040U,
    MTYPE_DISABLE = 0x00000080U,
}

enum uint CC_NOPRECNV = 0x0000ffffU;
enum uint CC_DEFAULT = 0x00000000U;

enum : int
{
    CC_CP437 = 0xffffffff,
    CC_CP850 = 0xfffffffe,
    CC_CP863 = 0xfffffffd,
}

enum : int
{
    CC_BIG5    = 0xfffffff6,
    CC_ISC     = 0xfffffff5,
    CC_JIS     = 0xfffffff4,
    CC_JIS_ANK = 0xfffffff3,
}

enum : int
{
    CC_NS86   = 0xfffffff2,
    CC_TCA    = 0xfffffff1,
    CC_GB2312 = 0xfffffff0,
}

enum : int
{
    CC_SJIS    = 0xffffffef,
    CC_WANSUNG = 0xffffffee,
}

enum uint UFF_VERSION_NUMBER = 0x00010001U;
enum uint FONT_DIR_SORTED = 0x00000001U;

enum : uint
{
    FONT_FL_UFM          = 0x00000001U,
    FONT_FL_IFI          = 0x00000002U,
    FONT_FL_SOFTFONT     = 0x00000004U,
    FONT_FL_PERMANENT_SF = 0x00000008U,
}

enum : uint
{
    FONT_FL_DEVICEFONT   = 0x00000010U,
    FONT_FL_GLYPHSET_GTT = 0x00000020U,
    FONT_FL_GLYPHSET_RLE = 0x00000040U,
}

enum uint FONT_FL_RESERVED = 0x00008000U;
enum uint FG_CANCHANGE = 0x00000080U;
enum uint WM_FI_FILENAME = 0x00000384U;
enum uint UNKNOWN_PROTOCOL = 0x00000000U;
enum uint PROTOCOL_UNKNOWN_TYPE = 0x00000000U;
enum uint RAWTCP = 0x00000001U;
enum uint PROTOCOL_RAWTCP_TYPE = 0x00000001U;
enum uint LPR = 0x00000002U;
enum uint PROTOCOL_LPR_TYPE = 0x00000002U;
enum uint MAX_PORTNAME_LEN = 0x00000040U;

enum : uint
{
    MAX_NETWORKNAME_LEN  = 0x00000031U,
    MAX_NETWORKNAME2_LEN = 0x00000080U,
}

enum uint MAX_SNMP_COMMUNITY_STR_LEN = 0x00000021U;
enum uint MAX_QUEUENAME_LEN = 0x00000021U;
enum uint MAX_IPADDR_STR_LEN = 0x00000010U;
enum uint MAX_ADDRESS_STR_LEN = 0x0000000dU;
enum uint MAX_DEVICEDESCRIPTION_STR_LEN = 0x00000101U;
enum uint DPS_NOPERMISSION = 0x00000001U;
enum uint DM_ADVANCED = 0x00000010U;
enum uint DM_NOPERMISSION = 0x00000020U;
enum uint DM_USER_DEFAULT = 0x00000040U;
enum uint DM_PROMPT_NON_MODAL = 0x40000000U;
enum uint DM_INVALIDATE_DRIVER_CACHE = 0x20000000U;
enum uint DM_RESERVED = 0x80000000U;

enum : uint
{
    CDM_CONVERT    = 0x00000001U,
    CDM_CONVERT351 = 0x00000002U,
}

enum uint CDM_DRIVER_DEFAULT = 0x00000004U;

enum : uint
{
    DOCUMENTEVENT_FIRST                                       = 0x00000001U,
    DOCUMENTEVENT_CREATEDCPRE                                 = 0x00000001U,
    DOCUMENTEVENT_CREATEDCPOST                                = 0x00000002U,
    DOCUMENTEVENT_RESETDCPRE                                  = 0x00000003U,
    DOCUMENTEVENT_RESETDCPOST                                 = 0x00000004U,
    DOCUMENTEVENT_STARTDOC                                    = 0x00000005U,
    DOCUMENTEVENT_STARTDOCPRE                                 = 0x00000005U,
    DOCUMENTEVENT_STARTPAGE                                   = 0x00000006U,
    DOCUMENTEVENT_ENDPAGE                                     = 0x00000007U,
    DOCUMENTEVENT_ENDDOC                                      = 0x00000008U,
    DOCUMENTEVENT_ENDDOCPRE                                   = 0x00000008U,
    DOCUMENTEVENT_ABORTDOC                                    = 0x00000009U,
    DOCUMENTEVENT_DELETEDC                                    = 0x0000000aU,
    DOCUMENTEVENT_ESCAPE                                      = 0x0000000bU,
    DOCUMENTEVENT_ENDDOCPOST                                  = 0x0000000cU,
    DOCUMENTEVENT_STARTDOCPOST                                = 0x0000000dU,
    DOCUMENTEVENT_QUERYFILTER                                 = 0x0000000eU,
    DOCUMENTEVENT_XPS_ADDFIXEDDOCUMENTSEQUENCEPRE             = 0x00000001U,
    DOCUMENTEVENT_XPS_ADDFIXEDDOCUMENTPRE                     = 0x00000002U,
    DOCUMENTEVENT_XPS_ADDFIXEDPAGEEPRE                        = 0x00000003U,
    DOCUMENTEVENT_XPS_ADDFIXEDPAGEPOST                        = 0x00000004U,
    DOCUMENTEVENT_XPS_ADDFIXEDDOCUMENTPOST                    = 0x00000005U,
    DOCUMENTEVENT_XPS_CANCELJOB                               = 0x00000006U,
    DOCUMENTEVENT_XPS_ADDFIXEDDOCUMENTSEQUENCEPRINTTICKETPRE  = 0x00000007U,
    DOCUMENTEVENT_XPS_ADDFIXEDDOCUMENTPRINTTICKETPRE          = 0x00000008U,
    DOCUMENTEVENT_XPS_ADDFIXEDPAGEPRINTTICKETPRE              = 0x00000009U,
    DOCUMENTEVENT_XPS_ADDFIXEDPAGEPRINTTICKETPOST             = 0x0000000aU,
    DOCUMENTEVENT_XPS_ADDFIXEDDOCUMENTPRINTTICKETPOST         = 0x0000000bU,
    DOCUMENTEVENT_XPS_ADDFIXEDDOCUMENTSEQUENCEPRINTTICKETPOST = 0x0000000cU,
    DOCUMENTEVENT_XPS_ADDFIXEDDOCUMENTSEQUENCEPOST            = 0x0000000dU,
}

enum : uint
{
    DOCUMENTEVENT_LAST        = 0x0000000fU,
    DOCUMENTEVENT_SPOOLED     = 0x00010000U,
    DOCUMENTEVENT_SUCCESS     = 0x00000001U,
    DOCUMENTEVENT_UNSUPPORTED = 0x00000000U,
}

enum int DOCUMENTEVENT_FAILURE = 0xffffffff;

enum : uint
{
    PRINTER_EVENT_CONFIGURATION_CHANGE    = 0x00000000U,
    PRINTER_EVENT_ADD_CONNECTION          = 0x00000001U,
    PRINTER_EVENT_DELETE_CONNECTION       = 0x00000002U,
    PRINTER_EVENT_INITIALIZE              = 0x00000003U,
    PRINTER_EVENT_DELETE                  = 0x00000004U,
    PRINTER_EVENT_CACHE_REFRESH           = 0x00000005U,
    PRINTER_EVENT_CACHE_DELETE            = 0x00000006U,
    PRINTER_EVENT_ATTRIBUTES_CHANGED      = 0x00000007U,
    PRINTER_EVENT_CONFIGURATION_UPDATE    = 0x00000008U,
    PRINTER_EVENT_ADD_CONNECTION_NO_UI    = 0x00000009U,
    PRINTER_EVENT_DELETE_CONNECTION_NO_UI = 0x0000000aU,
}

enum uint PRINTER_EVENT_FLAG_NO_UI = 0x00000001U;

enum : uint
{
    DRIVER_EVENT_INITIALIZE = 0x00000001U,
    DRIVER_EVENT_DELETE     = 0x00000002U,
}

enum uint BORDER_PRINT = 0x00000000U;
enum uint NO_BORDER_PRINT = 0x00000001U;
enum uint NORMAL_PRINT = 0x00000000U;
enum uint REVERSE_PRINT = 0x00000001U;
enum uint BOOKLET_PRINT = 0x00000002U;
enum uint NO_COLOR_OPTIMIZATION = 0x00000000U;
enum uint COLOR_OPTIMIZATION = 0x00000001U;
enum uint REVERSE_PAGES_FOR_REVERSE_DUPLEX = 0x00000001U;
enum uint DONT_SEND_EXTRA_PAGES_FOR_DUPLEX = 0x00000002U;
enum uint RIGHT_THEN_DOWN = 0x00000001U;
enum uint DOWN_THEN_RIGHT = 0x00000002U;
enum uint LEFT_THEN_DOWN = 0x00000004U;
enum uint DOWN_THEN_LEFT = 0x00000008U;

enum : uint
{
    BOOKLET_EDGE_LEFT  = 0x00000000U,
    BOOKLET_EDGE_RIGHT = 0x00000001U,
}

enum uint QCP_DEVICEPROFILE = 0x00000000U;
enum uint QCP_SOURCEPROFILE = 0x00000001U;

enum : uint
{
    QCP_PROFILEMEMORY = 0x00000001U,
    QCP_PROFILEDISK   = 0x00000002U,
}

enum const(wchar)* SPLPRINTER_USER_MODE_PRINTER_DRIVER = "SPLUserModePrinterDriver";
enum uint EMF_PP_COLOR_OPTIMIZATION = 0x00000001U;

enum : uint
{
    PRINTER_NOTIFY_STATUS_ENDPOINT = 0x00000001U,
    PRINTER_NOTIFY_STATUS_POLL     = 0x00000002U,
    PRINTER_NOTIFY_STATUS_INFO     = 0x00000004U,
}

enum : uint
{
    ROUTER_UNKNOWN      = 0x00000000U,
    ROUTER_SUCCESS      = 0x00000001U,
    ROUTER_STOP_ROUTING = 0x00000002U,
}

enum uint DOC_INFO_INTERNAL_LEVEL = 0x00000064U;
enum uint SPLCLIENT_INFO_INTERNAL_LEVEL = 0x00000064U;
enum uint FILL_WITH_DEFAULTS = 0x00000001U;
enum uint PRINTER_NOTIFY_INFO_DATA_COMPACT = 0x00000001U;

enum : uint
{
    COPYFILE_EVENT_SET_PRINTER_DATAEX        = 0x00000001U,
    COPYFILE_EVENT_DELETE_PRINTER            = 0x00000002U,
    COPYFILE_EVENT_ADD_PRINTER_CONNECTION    = 0x00000003U,
    COPYFILE_EVENT_DELETE_PRINTER_CONNECTION = 0x00000004U,
}

enum uint COPYFILE_EVENT_FILES_CHANGED = 0x00000005U;

enum : uint
{
    COPYFILE_FLAG_CLIENT_SPOOLER = 0x00000001U,
    COPYFILE_FLAG_SERVER_SPOOLER = 0x00000002U,
}

enum : uint
{
    DSPRINT_PUBLISH   = 0x00000001U,
    DSPRINT_UPDATE    = 0x00000002U,
    DSPRINT_UNPUBLISH = 0x00000004U,
    DSPRINT_REPUBLISH = 0x00000008U,
    DSPRINT_PENDING   = 0x80000000U,
}

enum : uint
{
    PRINTER_CONTROL_PAUSE      = 0x00000001U,
    PRINTER_CONTROL_RESUME     = 0x00000002U,
    PRINTER_CONTROL_PURGE      = 0x00000003U,
    PRINTER_CONTROL_SET_STATUS = 0x00000004U,
}

enum : uint
{
    PRINTER_STATUS_PAUSED               = 0x00000001U,
    PRINTER_STATUS_ERROR                = 0x00000002U,
    PRINTER_STATUS_PENDING_DELETION     = 0x00000004U,
    PRINTER_STATUS_PAPER_JAM            = 0x00000008U,
    PRINTER_STATUS_PAPER_OUT            = 0x00000010U,
    PRINTER_STATUS_MANUAL_FEED          = 0x00000020U,
    PRINTER_STATUS_PAPER_PROBLEM        = 0x00000040U,
    PRINTER_STATUS_OFFLINE              = 0x00000080U,
    PRINTER_STATUS_IO_ACTIVE            = 0x00000100U,
    PRINTER_STATUS_BUSY                 = 0x00000200U,
    PRINTER_STATUS_PRINTING             = 0x00000400U,
    PRINTER_STATUS_OUTPUT_BIN_FULL      = 0x00000800U,
    PRINTER_STATUS_NOT_AVAILABLE        = 0x00001000U,
    PRINTER_STATUS_WAITING              = 0x00002000U,
    PRINTER_STATUS_PROCESSING           = 0x00004000U,
    PRINTER_STATUS_INITIALIZING         = 0x00008000U,
    PRINTER_STATUS_WARMING_UP           = 0x00010000U,
    PRINTER_STATUS_TONER_LOW            = 0x00020000U,
    PRINTER_STATUS_NO_TONER             = 0x00040000U,
    PRINTER_STATUS_PAGE_PUNT            = 0x00080000U,
    PRINTER_STATUS_USER_INTERVENTION    = 0x00100000U,
    PRINTER_STATUS_OUT_OF_MEMORY        = 0x00200000U,
    PRINTER_STATUS_DOOR_OPEN            = 0x00400000U,
    PRINTER_STATUS_SERVER_UNKNOWN       = 0x00800000U,
    PRINTER_STATUS_POWER_SAVE           = 0x01000000U,
    PRINTER_STATUS_SERVER_OFFLINE       = 0x02000000U,
    PRINTER_STATUS_DRIVER_UPDATE_NEEDED = 0x04000000U,
}

enum : uint
{
    PRINTER_ATTRIBUTE_QUEUED            = 0x00000001U,
    PRINTER_ATTRIBUTE_DIRECT            = 0x00000002U,
    PRINTER_ATTRIBUTE_DEFAULT           = 0x00000004U,
    PRINTER_ATTRIBUTE_SHARED            = 0x00000008U,
    PRINTER_ATTRIBUTE_NETWORK           = 0x00000010U,
    PRINTER_ATTRIBUTE_HIDDEN            = 0x00000020U,
    PRINTER_ATTRIBUTE_LOCAL             = 0x00000040U,
    PRINTER_ATTRIBUTE_ENABLE_DEVQ       = 0x00000080U,
    PRINTER_ATTRIBUTE_KEEPPRINTEDJOBS   = 0x00000100U,
    PRINTER_ATTRIBUTE_DO_COMPLETE_FIRST = 0x00000200U,
    PRINTER_ATTRIBUTE_WORK_OFFLINE      = 0x00000400U,
    PRINTER_ATTRIBUTE_ENABLE_BIDI       = 0x00000800U,
    PRINTER_ATTRIBUTE_RAW_ONLY          = 0x00001000U,
    PRINTER_ATTRIBUTE_PUBLISHED         = 0x00002000U,
    PRINTER_ATTRIBUTE_FAX               = 0x00004000U,
    PRINTER_ATTRIBUTE_TS                = 0x00008000U,
    PRINTER_ATTRIBUTE_PUSHED_USER       = 0x00020000U,
    PRINTER_ATTRIBUTE_PUSHED_MACHINE    = 0x00040000U,
    PRINTER_ATTRIBUTE_MACHINE           = 0x00080000U,
    PRINTER_ATTRIBUTE_FRIENDLY_NAME     = 0x00100000U,
    PRINTER_ATTRIBUTE_TS_GENERIC_DRIVER = 0x00200000U,
    PRINTER_ATTRIBUTE_PER_USER          = 0x00400000U,
    PRINTER_ATTRIBUTE_ENTERPRISE_CLOUD  = 0x00800000U,
}

enum uint NO_PRIORITY = 0x00000000U;
enum uint MAX_PRIORITY = 0x00000063U;
enum uint MIN_PRIORITY = 0x00000001U;
enum uint DEF_PRIORITY = 0x00000001U;

enum : uint
{
    JOB_CONTROL_PAUSE             = 0x00000001U,
    JOB_CONTROL_RESUME            = 0x00000002U,
    JOB_CONTROL_CANCEL            = 0x00000003U,
    JOB_CONTROL_RESTART           = 0x00000004U,
    JOB_CONTROL_DELETE            = 0x00000005U,
    JOB_CONTROL_SENT_TO_PRINTER   = 0x00000006U,
    JOB_CONTROL_LAST_PAGE_EJECTED = 0x00000007U,
    JOB_CONTROL_RETAIN            = 0x00000008U,
    JOB_CONTROL_RELEASE           = 0x00000009U,
    JOB_CONTROL_SEND_TOAST        = 0x0000000aU,
    JOB_CONTROL_PENDING_ON_DEVICE = 0x0000000bU,
}

enum : uint
{
    JOB_STATUS_PAUSED            = 0x00000001U,
    JOB_STATUS_ERROR             = 0x00000002U,
    JOB_STATUS_DELETING          = 0x00000004U,
    JOB_STATUS_SPOOLING          = 0x00000008U,
    JOB_STATUS_PRINTING          = 0x00000010U,
    JOB_STATUS_OFFLINE           = 0x00000020U,
    JOB_STATUS_PAPEROUT          = 0x00000040U,
    JOB_STATUS_PRINTED           = 0x00000080U,
    JOB_STATUS_DELETED           = 0x00000100U,
    JOB_STATUS_BLOCKED_DEVQ      = 0x00000200U,
    JOB_STATUS_USER_INTERVENTION = 0x00000400U,
}

enum : uint
{
    JOB_STATUS_RESTART           = 0x00000800U,
    JOB_STATUS_COMPLETE          = 0x00001000U,
    JOB_STATUS_RETAINED          = 0x00002000U,
    JOB_STATUS_RENDERING_LOCALLY = 0x00004000U,
}

enum uint JOB_POSITION_UNSPECIFIED = 0x00000000U;

enum : uint
{
    PRINTER_DRIVER_PACKAGE_AWARE       = 0x00000001U,
    PRINTER_DRIVER_XPS                 = 0x00000002U,
    PRINTER_DRIVER_SANDBOX_ENABLED     = 0x00000004U,
    PRINTER_DRIVER_CLASS               = 0x00000008U,
    PRINTER_DRIVER_DERIVED             = 0x00000010U,
    PRINTER_DRIVER_NOT_SHAREABLE       = 0x00000020U,
    PRINTER_DRIVER_CATEGORY_FAX        = 0x00000040U,
    PRINTER_DRIVER_CATEGORY_FILE       = 0x00000080U,
    PRINTER_DRIVER_CATEGORY_VIRTUAL    = 0x00000100U,
    PRINTER_DRIVER_CATEGORY_SERVICE    = 0x00000200U,
    PRINTER_DRIVER_SOFT_RESET_REQUIRED = 0x00000400U,
    PRINTER_DRIVER_SANDBOX_DISABLED    = 0x00000800U,
    PRINTER_DRIVER_CATEGORY_3D         = 0x00001000U,
    PRINTER_DRIVER_CATEGORY_CLOUD      = 0x00002000U,
}

enum : uint
{
    DRIVER_KERNELMODE = 0x00000001U,
    DRIVER_USERMODE   = 0x00000002U,
}

enum : uint
{
    DPD_DELETE_UNUSED_FILES     = 0x00000001U,
    DPD_DELETE_SPECIFIC_VERSION = 0x00000002U,
    DPD_DELETE_ALL_FILES        = 0x00000004U,
}

enum : uint
{
    APD_STRICT_UPGRADE   = 0x00000001U,
    APD_STRICT_DOWNGRADE = 0x00000002U,
}

enum : uint
{
    APD_COPY_ALL_FILES      = 0x00000004U,
    APD_COPY_NEW_FILES      = 0x00000008U,
    APD_COPY_FROM_DIRECTORY = 0x00000010U,
}

enum : uint
{
    STRING_NONE     = 0x00000001U,
    STRING_MUIDLL   = 0x00000002U,
    STRING_LANGPAIR = 0x00000004U,
}

enum uint MAX_FORM_KEYWORD_LENGTH = 0x00000040U;
enum uint DI_CHANNEL = 0x00000001U;
enum uint DI_READ_SPOOL_JOB = 0x00000003U;
enum uint DI_MEMORYMAP_WRITE = 0x00000001U;

enum : uint
{
    FORM_USER    = 0x00000000U,
    FORM_BUILTIN = 0x00000001U,
    FORM_PRINTER = 0x00000002U,
}

enum uint PPCAPS_RIGHT_THEN_DOWN = 0x00000001U;
enum uint PPCAPS_DOWN_THEN_RIGHT = 0x00000002U;
enum uint PPCAPS_LEFT_THEN_DOWN = 0x00000004U;
enum uint PPCAPS_DOWN_THEN_LEFT = 0x00000008U;

enum : uint
{
    PPCAPS_BORDER_PRINT = 0x00000001U,
    PPCAPS_BOOKLET_EDGE = 0x00000001U,
}

enum uint PPCAPS_REVERSE_PAGES_FOR_REVERSE_DUPLEX = 0x00000001U;
enum uint PPCAPS_DONT_SEND_EXTRA_PAGES_FOR_DUPLEX = 0x00000002U;
enum uint PPCAPS_SQUARE_SCALING = 0x00000001U;

enum : uint
{
    PORT_TYPE_WRITE        = 0x00000001U,
    PORT_TYPE_READ         = 0x00000002U,
    PORT_TYPE_REDIRECTED   = 0x00000004U,
    PORT_TYPE_NET_ATTACHED = 0x00000008U,
}

enum : uint
{
    PORT_STATUS_TYPE_ERROR        = 0x00000001U,
    PORT_STATUS_TYPE_WARNING      = 0x00000002U,
    PORT_STATUS_TYPE_INFO         = 0x00000003U,
    PORT_STATUS_OFFLINE           = 0x00000001U,
    PORT_STATUS_PAPER_JAM         = 0x00000002U,
    PORT_STATUS_PAPER_OUT         = 0x00000003U,
    PORT_STATUS_OUTPUT_BIN_FULL   = 0x00000004U,
    PORT_STATUS_PAPER_PROBLEM     = 0x00000005U,
    PORT_STATUS_NO_TONER          = 0x00000006U,
    PORT_STATUS_DOOR_OPEN         = 0x00000007U,
    PORT_STATUS_USER_INTERVENTION = 0x00000008U,
    PORT_STATUS_OUT_OF_MEMORY     = 0x00000009U,
    PORT_STATUS_TONER_LOW         = 0x0000000aU,
    PORT_STATUS_WARMING_UP        = 0x0000000bU,
    PORT_STATUS_POWER_SAVE        = 0x0000000cU,
}

enum : uint
{
    PRINTER_ENUM_DEFAULT      = 0x00000001U,
    PRINTER_ENUM_LOCAL        = 0x00000002U,
    PRINTER_ENUM_CONNECTIONS  = 0x00000004U,
    PRINTER_ENUM_FAVORITE     = 0x00000004U,
    PRINTER_ENUM_NAME         = 0x00000008U,
    PRINTER_ENUM_REMOTE       = 0x00000010U,
    PRINTER_ENUM_SHARED       = 0x00000020U,
    PRINTER_ENUM_NETWORK      = 0x00000040U,
    PRINTER_ENUM_EXPAND       = 0x00004000U,
    PRINTER_ENUM_CONTAINER    = 0x00008000U,
    PRINTER_ENUM_ICONMASK     = 0x00ff0000U,
    PRINTER_ENUM_ICON1        = 0x00010000U,
    PRINTER_ENUM_ICON2        = 0x00020000U,
    PRINTER_ENUM_ICON3        = 0x00040000U,
    PRINTER_ENUM_ICON4        = 0x00080000U,
    PRINTER_ENUM_ICON5        = 0x00100000U,
    PRINTER_ENUM_ICON6        = 0x00200000U,
    PRINTER_ENUM_ICON7        = 0x00400000U,
    PRINTER_ENUM_ICON8        = 0x00800000U,
    PRINTER_ENUM_HIDE         = 0x01000000U,
    PRINTER_ENUM_CATEGORY_ALL = 0x02000000U,
    PRINTER_ENUM_CATEGORY_3D  = 0x04000000U,
}

enum : uint
{
    SPOOL_FILE_PERSISTENT = 0x00000001U,
    SPOOL_FILE_TEMPORARY  = 0x00000002U,
}

enum uint PRINTER_NOTIFY_TYPE = 0x00000000U;
enum uint JOB_NOTIFY_TYPE = 0x00000001U;
enum uint SERVER_NOTIFY_TYPE = 0x00000002U;

enum : uint
{
    PRINTER_NOTIFY_FIELD_SERVER_NAME            = 0x00000000U,
    PRINTER_NOTIFY_FIELD_PRINTER_NAME           = 0x00000001U,
    PRINTER_NOTIFY_FIELD_SHARE_NAME             = 0x00000002U,
    PRINTER_NOTIFY_FIELD_PORT_NAME              = 0x00000003U,
    PRINTER_NOTIFY_FIELD_DRIVER_NAME            = 0x00000004U,
    PRINTER_NOTIFY_FIELD_COMMENT                = 0x00000005U,
    PRINTER_NOTIFY_FIELD_LOCATION               = 0x00000006U,
    PRINTER_NOTIFY_FIELD_DEVMODE                = 0x00000007U,
    PRINTER_NOTIFY_FIELD_SEPFILE                = 0x00000008U,
    PRINTER_NOTIFY_FIELD_PRINT_PROCESSOR        = 0x00000009U,
    PRINTER_NOTIFY_FIELD_PARAMETERS             = 0x0000000aU,
    PRINTER_NOTIFY_FIELD_DATATYPE               = 0x0000000bU,
    PRINTER_NOTIFY_FIELD_SECURITY_DESCRIPTOR    = 0x0000000cU,
    PRINTER_NOTIFY_FIELD_ATTRIBUTES             = 0x0000000dU,
    PRINTER_NOTIFY_FIELD_PRIORITY               = 0x0000000eU,
    PRINTER_NOTIFY_FIELD_DEFAULT_PRIORITY       = 0x0000000fU,
    PRINTER_NOTIFY_FIELD_START_TIME             = 0x00000010U,
    PRINTER_NOTIFY_FIELD_UNTIL_TIME             = 0x00000011U,
    PRINTER_NOTIFY_FIELD_STATUS                 = 0x00000012U,
    PRINTER_NOTIFY_FIELD_STATUS_STRING          = 0x00000013U,
    PRINTER_NOTIFY_FIELD_CJOBS                  = 0x00000014U,
    PRINTER_NOTIFY_FIELD_AVERAGE_PPM            = 0x00000015U,
    PRINTER_NOTIFY_FIELD_TOTAL_PAGES            = 0x00000016U,
    PRINTER_NOTIFY_FIELD_PAGES_PRINTED          = 0x00000017U,
    PRINTER_NOTIFY_FIELD_TOTAL_BYTES            = 0x00000018U,
    PRINTER_NOTIFY_FIELD_BYTES_PRINTED          = 0x00000019U,
    PRINTER_NOTIFY_FIELD_OBJECT_GUID            = 0x0000001aU,
    PRINTER_NOTIFY_FIELD_FRIENDLY_NAME          = 0x0000001bU,
    PRINTER_NOTIFY_FIELD_BRANCH_OFFICE_PRINTING = 0x0000001cU,
}

enum : uint
{
    JOB_NOTIFY_FIELD_PRINTER_NAME        = 0x00000000U,
    JOB_NOTIFY_FIELD_MACHINE_NAME        = 0x00000001U,
    JOB_NOTIFY_FIELD_PORT_NAME           = 0x00000002U,
    JOB_NOTIFY_FIELD_USER_NAME           = 0x00000003U,
    JOB_NOTIFY_FIELD_NOTIFY_NAME         = 0x00000004U,
    JOB_NOTIFY_FIELD_DATATYPE            = 0x00000005U,
    JOB_NOTIFY_FIELD_PRINT_PROCESSOR     = 0x00000006U,
    JOB_NOTIFY_FIELD_PARAMETERS          = 0x00000007U,
    JOB_NOTIFY_FIELD_DRIVER_NAME         = 0x00000008U,
    JOB_NOTIFY_FIELD_DEVMODE             = 0x00000009U,
    JOB_NOTIFY_FIELD_STATUS              = 0x0000000aU,
    JOB_NOTIFY_FIELD_STATUS_STRING       = 0x0000000bU,
    JOB_NOTIFY_FIELD_SECURITY_DESCRIPTOR = 0x0000000cU,
    JOB_NOTIFY_FIELD_DOCUMENT            = 0x0000000dU,
    JOB_NOTIFY_FIELD_PRIORITY            = 0x0000000eU,
    JOB_NOTIFY_FIELD_POSITION            = 0x0000000fU,
    JOB_NOTIFY_FIELD_SUBMITTED           = 0x00000010U,
    JOB_NOTIFY_FIELD_START_TIME          = 0x00000011U,
    JOB_NOTIFY_FIELD_UNTIL_TIME          = 0x00000012U,
    JOB_NOTIFY_FIELD_TIME                = 0x00000013U,
    JOB_NOTIFY_FIELD_TOTAL_PAGES         = 0x00000014U,
    JOB_NOTIFY_FIELD_PAGES_PRINTED       = 0x00000015U,
    JOB_NOTIFY_FIELD_TOTAL_BYTES         = 0x00000016U,
    JOB_NOTIFY_FIELD_BYTES_PRINTED       = 0x00000017U,
    JOB_NOTIFY_FIELD_REMOTE_JOB_ID       = 0x00000018U,
}

enum uint SERVER_NOTIFY_FIELD_PRINT_DRIVER_ISOLATION_GROUP = 0x00000000U;

enum : uint
{
    PRINTER_NOTIFY_CATEGORY_ALL    = 0x00001000U,
    PRINTER_NOTIFY_CATEGORY_3D     = 0x00002000U,
    PRINTER_NOTIFY_OPTIONS_REFRESH = 0x00000001U,
    PRINTER_NOTIFY_INFO_DISCARDED  = 0x00000001U,
}

enum : const(wchar)*
{
    BIDI_ACTION_ENUM_SCHEMA       = "EnumSchema",
    BIDI_ACTION_GET               = "Get",
    BIDI_ACTION_SET               = "Set",
    BIDI_ACTION_GET_ALL           = "GetAll",
    BIDI_ACTION_GET_WITH_ARGUMENT = "GetWithArgument",
}

enum : uint
{
    BIDI_ACCESS_ADMINISTRATOR = 0x00000001U,
    BIDI_ACCESS_USER          = 0x00000002U,
}

enum : uint
{
    ERROR_BIDI_STATUS_OK            = 0x00000000U,
    ERROR_BIDI_ERROR_BASE           = 0x000032c8U,
    ERROR_BIDI_STATUS_WARNING       = 0x000032c9U,
    ERROR_BIDI_SCHEMA_READ_ONLY     = 0x000032caU,
    ERROR_BIDI_SERVER_OFFLINE       = 0x000032cbU,
    ERROR_BIDI_DEVICE_OFFLINE       = 0x000032ccU,
    ERROR_BIDI_SCHEMA_NOT_SUPPORTED = 0x000032cdU,
}

enum : uint
{
    ERROR_BIDI_SET_DIFFERENT_TYPE      = 0x000032ceU,
    ERROR_BIDI_SET_MULTIPLE_SCHEMAPATH = 0x000032cfU,
    ERROR_BIDI_SET_INVALID_SCHEMAPATH  = 0x000032d0U,
    ERROR_BIDI_SET_UNKNOWN_FAILURE     = 0x000032d1U,
}

enum uint ERROR_BIDI_SCHEMA_WRITE_ONLY = 0x000032d2U;

enum : uint
{
    ERROR_BIDI_GET_REQUIRES_ARGUMENT      = 0x000032d3U,
    ERROR_BIDI_GET_ARGUMENT_NOT_SUPPORTED = 0x000032d4U,
    ERROR_BIDI_GET_MISSING_ARGUMENT       = 0x000032d5U,
}

enum uint ERROR_BIDI_DEVICE_CONFIG_UNCHANGED = 0x000032d6U;

enum : uint
{
    ERROR_BIDI_NO_LOCALIZED_RESOURCES    = 0x000032d7U,
    ERROR_BIDI_NO_BIDI_SCHEMA_EXTENSIONS = 0x000032d8U,
}

enum : uint
{
    ERROR_BIDI_UNSUPPORTED_CLIENT_LANGUAGE = 0x000032d9U,
    ERROR_BIDI_UNSUPPORTED_RESOURCE_FORMAT = 0x000032daU,
}

enum : uint
{
    PRINTER_CHANGE_ADD_PRINTER               = 0x00000001U,
    PRINTER_CHANGE_SET_PRINTER               = 0x00000002U,
    PRINTER_CHANGE_DELETE_PRINTER            = 0x00000004U,
    PRINTER_CHANGE_FAILED_CONNECTION_PRINTER = 0x00000008U,
}

enum : uint
{
    PRINTER_CHANGE_PRINTER                = 0x000000ffU,
    PRINTER_CHANGE_ADD_JOB                = 0x00000100U,
    PRINTER_CHANGE_SET_JOB                = 0x00000200U,
    PRINTER_CHANGE_DELETE_JOB             = 0x00000400U,
    PRINTER_CHANGE_WRITE_JOB              = 0x00000800U,
    PRINTER_CHANGE_JOB                    = 0x0000ff00U,
    PRINTER_CHANGE_ADD_FORM               = 0x00010000U,
    PRINTER_CHANGE_SET_FORM               = 0x00020000U,
    PRINTER_CHANGE_DELETE_FORM            = 0x00040000U,
    PRINTER_CHANGE_FORM                   = 0x00070000U,
    PRINTER_CHANGE_ADD_PORT               = 0x00100000U,
    PRINTER_CHANGE_CONFIGURE_PORT         = 0x00200000U,
    PRINTER_CHANGE_DELETE_PORT            = 0x00400000U,
    PRINTER_CHANGE_PORT                   = 0x00700000U,
    PRINTER_CHANGE_ADD_PRINT_PROCESSOR    = 0x01000000U,
    PRINTER_CHANGE_DELETE_PRINT_PROCESSOR = 0x04000000U,
    PRINTER_CHANGE_PRINT_PROCESSOR        = 0x07000000U,
    PRINTER_CHANGE_SERVER                 = 0x08000000U,
    PRINTER_CHANGE_ADD_PRINTER_DRIVER     = 0x10000000U,
    PRINTER_CHANGE_SET_PRINTER_DRIVER     = 0x20000000U,
    PRINTER_CHANGE_DELETE_PRINTER_DRIVER  = 0x40000000U,
    PRINTER_CHANGE_PRINTER_DRIVER         = 0x70000000U,
    PRINTER_CHANGE_TIMEOUT                = 0x80000000U,
    PRINTER_CHANGE_ALL                    = 0x7f77ffffU,
    PRINTER_ERROR_INFORMATION             = 0x80000000U,
    PRINTER_ERROR_WARNING                 = 0x40000000U,
    PRINTER_ERROR_SEVERE                  = 0x20000000U,
    PRINTER_ERROR_OUTOFPAPER              = 0x00000001U,
    PRINTER_ERROR_JAM                     = 0x00000002U,
    PRINTER_ERROR_OUTOFTONER              = 0x00000004U,
}

enum const(wchar)* SPLREG_DEFAULT_SPOOL_DIRECTORY = "DefaultSpoolDirectory";

enum : const(wchar)*
{
    SPLREG_PORT_THREAD_PRIORITY_DEFAULT = "PortThreadPriorityDefault",
    SPLREG_PORT_THREAD_PRIORITY         = "PortThreadPriority",
}

enum : const(wchar)*
{
    SPLREG_SCHEDULER_THREAD_PRIORITY_DEFAULT = "SchedulerThreadPriorityDefault",
    SPLREG_SCHEDULER_THREAD_PRIORITY         = "SchedulerThreadPriority",
}

enum const(wchar)* SPLREG_BEEP_ENABLED = "BeepEnabled";

enum : const(wchar)*
{
    SPLREG_NET_POPUP   = "NetPopup",
    SPLREG_RETRY_POPUP = "RetryPopup",
}

enum const(wchar)* SPLREG_NET_POPUP_TO_COMPUTER = "NetPopupToComputer";

enum : const(wchar)*
{
    SPLREG_EVENT_LOG     = "EventLog",
    SPLREG_MAJOR_VERSION = "MajorVersion",
}

enum const(wchar)* SPLREG_MINOR_VERSION = "MinorVersion";
enum const(wchar)* SPLREG_ARCHITECTURE = "Architecture";

enum : const(wchar)*
{
    SPLREG_OS_VERSION   = "OSVersion",
    SPLREG_OS_VERSIONEX = "OSVersionEx",
}

enum : const(wchar)*
{
    SPLREG_DS_PRESENT          = "DsPresent",
    SPLREG_DS_PRESENT_FOR_USER = "DsPresentForUser",
}

enum : const(wchar)*
{
    SPLREG_REMOTE_FAX                  = "RemoteFax",
    SPLREG_RESTART_JOB_ON_POOL_ERROR   = "RestartJobOnPoolError",
    SPLREG_RESTART_JOB_ON_POOL_ENABLED = "RestartJobOnPoolEnabled",
}

enum const(wchar)* SPLREG_DNS_MACHINE_NAME = "DNSMachineName";
enum const(wchar)* SPLREG_ALLOW_USER_MANAGEFORMS = "AllowUserManageForms";
enum const(wchar)* SPLREG_WEBSHAREMGMT = "WebShareMgmt";

enum : const(wchar)*
{
    SPLREG_PRINT_DRIVER_ISOLATION_GROUPS                     = "PrintDriverIsolationGroups",
    SPLREG_PRINT_DRIVER_ISOLATION_TIME_BEFORE_RECYCLE        = "PrintDriverIsolationTimeBeforeRecycle",
    SPLREG_PRINT_DRIVER_ISOLATION_MAX_OBJECTS_BEFORE_RECYCLE = "PrintDriverIsolationMaxobjsBeforeRecycle",
    SPLREG_PRINT_DRIVER_ISOLATION_IDLE_TIMEOUT               = "PrintDriverIsolationIdleTimeout",
    SPLREG_PRINT_DRIVER_ISOLATION_EXECUTION_POLICY           = "PrintDriverIsolationExecutionPolicy",
    SPLREG_PRINT_DRIVER_ISOLATION_OVERRIDE_POLICY            = "PrintDriverIsolationOverrideCompat",
}

enum const(wchar)* SPLREG_PRINT_QUEUE_V4_DRIVER_DIRECTORY = "PrintQueueV4DriverDirectory";

enum : uint
{
    JOB_ACCESS_ADMINISTER = 0x00000010U,
    JOB_ACCESS_READ       = 0x00000020U,
}

enum const(wchar)* SPLDS_SPOOLER_KEY = "DsSpooler";
enum const(wchar)* SPLDS_DRIVER_KEY = "DsDriver";

enum : const(wchar)*
{
    SPLDS_USER_KEY     = "DsUser",
    SPLDS_ASSET_NUMBER = "assetNumber",
}

enum const(wchar)* SPLDS_BYTES_PER_MINUTE = "bytesPerMinute";

enum : const(wchar)*
{
    SPLDS_DESCRIPTION    = "description",
    SPLDS_DRIVER_NAME    = "driverName",
    SPLDS_DRIVER_VERSION = "driverVersion",
}

enum : const(wchar)*
{
    SPLDS_LOCATION                       = "location",
    SPLDS_PORT_NAME                      = "portName",
    SPLDS_PRINT_ATTRIBUTES               = "printAttributes",
    SPLDS_PRINT_BIN_NAMES                = "printBinNames",
    SPLDS_PRINT_COLLATE                  = "printCollate",
    SPLDS_PRINT_COLOR                    = "printColor",
    SPLDS_PRINT_DUPLEX_SUPPORTED         = "printDuplexSupported",
    SPLDS_PRINT_END_TIME                 = "printEndTime",
    SPLDS_PRINTER_CLASS                  = "printQueue",
    SPLDS_PRINTER_NAME                   = "printerName",
    SPLDS_PRINT_KEEP_PRINTED_JOBS        = "printKeepPrintedJobs",
    SPLDS_PRINT_LANGUAGE                 = "printLanguage",
    SPLDS_PRINT_MAC_ADDRESS              = "printMACAddress",
    SPLDS_PRINT_MAX_X_EXTENT             = "printMaxXExtent",
    SPLDS_PRINT_MAX_Y_EXTENT             = "printMaxYExtent",
    SPLDS_PRINT_MAX_RESOLUTION_SUPPORTED = "printMaxResolutionSupported",
}

enum : const(wchar)*
{
    SPLDS_PRINT_MEDIA_READY            = "printMediaReady",
    SPLDS_PRINT_MEDIA_SUPPORTED        = "printMediaSupported",
    SPLDS_PRINT_MEMORY                 = "printMemory",
    SPLDS_PRINT_MIN_X_EXTENT           = "printMinXExtent",
    SPLDS_PRINT_MIN_Y_EXTENT           = "printMinYExtent",
    SPLDS_PRINT_NETWORK_ADDRESS        = "printNetworkAddress",
    SPLDS_PRINT_NOTIFY                 = "printNotify",
    SPLDS_PRINT_NUMBER_UP              = "printNumberUp",
    SPLDS_PRINT_ORIENTATIONS_SUPPORTED = "printOrientationsSupported",
}

enum : const(wchar)*
{
    SPLDS_PRINT_OWNER              = "printOwner",
    SPLDS_PRINT_PAGES_PER_MINUTE   = "printPagesPerMinute",
    SPLDS_PRINT_RATE               = "printRate",
    SPLDS_PRINT_RATE_UNIT          = "printRateUnit",
    SPLDS_PRINT_SEPARATOR_FILE     = "printSeparatorFile",
    SPLDS_PRINT_SHARE_NAME         = "printShareName",
    SPLDS_PRINT_SPOOLING           = "printSpooling",
    SPLDS_PRINT_STAPLING_SUPPORTED = "printStaplingSupported",
    SPLDS_PRINT_START_TIME         = "printStartTime",
    SPLDS_PRINT_STATUS             = "printStatus",
    SPLDS_PRIORITY                 = "priority",
    SPLDS_SERVER_NAME              = "serverName",
    SPLDS_SHORT_SERVER_NAME        = "shortServerName",
}

enum : const(wchar)*
{
    SPLDS_UNC_NAME       = "uNCName",
    SPLDS_URL            = "url",
    SPLDS_FLAGS          = "flags",
    SPLDS_VERSION_NUMBER = "versionNumber",
}

enum const(wchar)* SPLDS_PRINT_IPP_COMPRESSION_SUPPORTED = "ippCompressionSupported";

enum : const(wchar)*
{
    SPLDS_PRINTER_NAME_ALIASES = "printerNameAliases",
    SPLDS_PRINTER_LOCATIONS    = "printerLocations",
    SPLDS_PRINTER_MODEL        = "printerModel",
}

enum : uint
{
    PRINTER_CONNECTION_MISMATCH = 0x00000020U,
    PRINTER_CONNECTION_NO_UI    = 0x00000040U,
}

enum uint IPDFP_COPY_ALL_FILES = 0x00000001U;
enum uint UPDP_SILENT_UPLOAD = 0x00000001U;
enum uint UPDP_UPLOAD_ALWAYS = 0x00000002U;
enum uint UPDP_CHECK_DRIVERSTORE = 0x00000004U;
enum const(wchar)* MS_PRINT_JOB_OUTPUT_FILE = "MsPrintJobOutputFile";

enum : uint
{
    DISPID_PRINTSCHEMA_ELEMENT                        = 0x00002710U,
    DISPID_PRINTSCHEMA_ELEMENT_XMLNODE                = 0x00002711U,
    DISPID_PRINTSCHEMA_ELEMENT_NAME                   = 0x00002712U,
    DISPID_PRINTSCHEMA_ELEMENT_NAMESPACEURI           = 0x00002713U,
    DISPID_PRINTSCHEMA_DISPLAYABLEELEMENT             = 0x00002774U,
    DISPID_PRINTSCHEMA_DISPLAYABLEELEMENT_DISPLAYNAME = 0x00002775U,
}

enum : uint
{
    DISPID_PRINTSCHEMA_OPTION                             = 0x000027d8U,
    DISPID_PRINTSCHEMA_OPTION_SELECTED                    = 0x000027d9U,
    DISPID_PRINTSCHEMA_OPTION_CONSTRAINED                 = 0x000027daU,
    DISPID_PRINTSCHEMA_OPTION_GETPROPERTYVALUE            = 0x000027dbU,
    DISPID_PRINTSCHEMA_PAGEMEDIASIZEOPTION                = 0x0000283cU,
    DISPID_PRINTSCHEMA_PAGEMEDIASIZEOPTION_WIDTH          = 0x0000283dU,
    DISPID_PRINTSCHEMA_PAGEMEDIASIZEOPTION_HEIGHT         = 0x0000283eU,
    DISPID_PRINTSCHEMA_NUPOPTION                          = 0x000028a0U,
    DISPID_PRINTSCHEMA_NUPOPTION_PAGESPERSHEET            = 0x000028a1U,
    DISPID_PRINTSCHEMA_OPTIONCOLLECTION                   = 0x00002904U,
    DISPID_PRINTSCHEMA_OPTIONCOLLECTION_COUNT             = 0x00002905U,
    DISPID_PRINTSCHEMA_OPTIONCOLLECTION_GETAT             = 0x00002906U,
    DISPID_PRINTSCHEMA_FEATURE                            = 0x00002968U,
    DISPID_PRINTSCHEMA_FEATURE_SELECTEDOPTION             = 0x00002969U,
    DISPID_PRINTSCHEMA_FEATURE_SELECTIONTYPE              = 0x0000296aU,
    DISPID_PRINTSCHEMA_FEATURE_GETOPTION                  = 0x0000296bU,
    DISPID_PRINTSCHEMA_FEATURE_DISPLAYUI                  = 0x0000296cU,
    DISPID_PRINTSCHEMA_PAGEIMAGEABLESIZE                  = 0x000029ccU,
    DISPID_PRINTSCHEMA_PAGEIMAGEABLESIZE_IMAGEABLE_WIDTH  = 0x000029cdU,
    DISPID_PRINTSCHEMA_PAGEIMAGEABLESIZE_IMAGEABLE_HEIGHT = 0x000029ceU,
    DISPID_PRINTSCHEMA_PAGEIMAGEABLESIZE_ORIGIN_WIDTH     = 0x000029cfU,
    DISPID_PRINTSCHEMA_PAGEIMAGEABLESIZE_ORIGIN_HEIGHT    = 0x000029d0U,
    DISPID_PRINTSCHEMA_PAGEIMAGEABLESIZE_EXTENT_WIDTH     = 0x000029d1U,
    DISPID_PRINTSCHEMA_PAGEIMAGEABLESIZE_EXTENT_HEIGHT    = 0x000029d2U,
}

enum : uint
{
    DISPID_PRINTSCHEMA_CAPABILITIES                        = 0x00002a30U,
    DISPID_PRINTSCHEMA_CAPABILITIES_GETFEATURE_KEYNAME     = 0x00002a31U,
    DISPID_PRINTSCHEMA_CAPABILITIES_GETFEATURE             = 0x00002a32U,
    DISPID_PRINTSCHEMA_CAPABILITIES_PAGEIMAGEABLESIZE      = 0x00002a33U,
    DISPID_PRINTSCHEMA_CAPABILITIES_JOBCOPIESMINVALUE      = 0x00002a34U,
    DISPID_PRINTSCHEMA_CAPABILITIES_JOBCOPIESMAXVALUE      = 0x00002a35U,
    DISPID_PRINTSCHEMA_CAPABILITIES_GETSELECTEDOPTION      = 0x00002a36U,
    DISPID_PRINTSCHEMA_CAPABILITIES_GETOPTIONS             = 0x00002a37U,
    DISPID_PRINTSCHEMA_CAPABILITIES_GETPARAMETERDEFINITION = 0x00002a38U,
}

enum : uint
{
    DISPID_PRINTSCHEMA_ASYNCOPERATION                 = 0x00002a94U,
    DISPID_PRINTSCHEMA_ASYNCOPERATION_START           = 0x00002a95U,
    DISPID_PRINTSCHEMA_ASYNCOPERATION_CANCEL          = 0x00002a96U,
    DISPID_PRINTSCHEMA_TICKET                         = 0x00002af8U,
    DISPID_PRINTSCHEMA_TICKET_GETFEATURE_KEYNAME      = 0x00002af9U,
    DISPID_PRINTSCHEMA_TICKET_GETFEATURE              = 0x00002afaU,
    DISPID_PRINTSCHEMA_TICKET_VALIDATEASYNC           = 0x00002afbU,
    DISPID_PRINTSCHEMA_TICKET_COMMITASYNC             = 0x00002afcU,
    DISPID_PRINTSCHEMA_TICKET_NOTIFYXMLCHANGED        = 0x00002afdU,
    DISPID_PRINTSCHEMA_TICKET_GETCAPABILITIES         = 0x00002afeU,
    DISPID_PRINTSCHEMA_TICKET_JOBCOPIESALLDOCUMENTS   = 0x00002affU,
    DISPID_PRINTSCHEMA_TICKET_GETPARAMETERINITIALIZER = 0x00002b00U,
}

enum : uint
{
    DISPID_PRINTSCHEMA_ASYNCOPERATIONEVENT           = 0x00002b5cU,
    DISPID_PRINTSCHEMA_ASYNCOPERATIONEVENT_COMPLETED = 0x00002b5dU,
}

enum : uint
{
    DISPID_PRINTERSCRIPTABLESEQUENTIALSTREAM       = 0x00002bc0U,
    DISPID_PRINTERSCRIPTABLESEQUENTIALSTREAM_READ  = 0x00002bc1U,
    DISPID_PRINTERSCRIPTABLESEQUENTIALSTREAM_WRITE = 0x00002bc2U,
    DISPID_PRINTERSCRIPTABLESTREAM                 = 0x00002c24U,
    DISPID_PRINTERSCRIPTABLESTREAM_COMMIT          = 0x00002c25U,
    DISPID_PRINTERSCRIPTABLESTREAM_SEEK            = 0x00002c26U,
    DISPID_PRINTERSCRIPTABLESTREAM_SETSIZE         = 0x00002c27U,
}

enum : uint
{
    DISPID_PRINTERPROPERTYBAG                = 0x00002c88U,
    DISPID_PRINTERPROPERTYBAG_GETBOOL        = 0x00002c89U,
    DISPID_PRINTERPROPERTYBAG_SETBOOL        = 0x00002c8aU,
    DISPID_PRINTERPROPERTYBAG_GETINT32       = 0x00002c8bU,
    DISPID_PRINTERPROPERTYBAG_SETINT32       = 0x00002c8cU,
    DISPID_PRINTERPROPERTYBAG_GETSTRING      = 0x00002c8dU,
    DISPID_PRINTERPROPERTYBAG_SETSTRING      = 0x00002c8eU,
    DISPID_PRINTERPROPERTYBAG_GETBYTES       = 0x00002c8fU,
    DISPID_PRINTERPROPERTYBAG_SETBYTES       = 0x00002c90U,
    DISPID_PRINTERPROPERTYBAG_GETREADSTREAM  = 0x00002c91U,
    DISPID_PRINTERPROPERTYBAG_GETWRITESTREAM = 0x00002c92U,
}

enum : uint
{
    DISPID_PRINTERSCRIPTABLEPROPERTYBAG_GETSTREAMASXML = 0x00002c93U,
    DISPID_PRINTERSCRIPTABLEPROPERTYBAG                = 0x00002cecU,
    DISPID_PRINTERSCRIPTABLEPROPERTYBAG_GETBOOL        = 0x00002cedU,
    DISPID_PRINTERSCRIPTABLEPROPERTYBAG_SETBOOL        = 0x00002ceeU,
    DISPID_PRINTERSCRIPTABLEPROPERTYBAG_GETINT32       = 0x00002cefU,
    DISPID_PRINTERSCRIPTABLEPROPERTYBAG_SETINT32       = 0x00002cf0U,
    DISPID_PRINTERSCRIPTABLEPROPERTYBAG_GETSTRING      = 0x00002cf1U,
    DISPID_PRINTERSCRIPTABLEPROPERTYBAG_SETSTRING      = 0x00002cf2U,
    DISPID_PRINTERSCRIPTABLEPROPERTYBAG_GETBYTES       = 0x00002cf3U,
    DISPID_PRINTERSCRIPTABLEPROPERTYBAG_SETBYTES       = 0x00002cf4U,
    DISPID_PRINTERSCRIPTABLEPROPERTYBAG_GETREADSTREAM  = 0x00002cf5U,
    DISPID_PRINTERSCRIPTABLEPROPERTYBAG_GETWRITESTREAM = 0x00002cf6U,
}

enum : uint
{
    DISPID_PRINTERQUEUE                             = 0x00002d50U,
    DISPID_PRINTERQUEUE_HANDLE                      = 0x00002d51U,
    DISPID_PRINTERQUEUE_NAME                        = 0x00002d52U,
    DISPID_PRINTERQUEUE_SENDBIDIQUERY               = 0x00002d53U,
    DISPID_PRINTERQUEUE_GETPROPERTIES               = 0x00002d54U,
    DISPID_PRINTERQUEUE_SENDBIDISETREQUESTASYNC     = 0x00002d55U,
    DISPID_PRINTERQUEUE_GETPRINTERQUEUEVIEW         = 0x00002d56U,
    DISPID_PRINTERQUEUEEVENT                        = 0x00002db4U,
    DISPID_PRINTERQUEUEEVENT_ONBIDIRESPONSERECEIVED = 0x00002db5U,
}

enum : uint
{
    DISPID_PRINTEREXTENSION_CONTEXT                         = 0x00002e18U,
    DISPID_PRINTEREXTENSION_CONTEXT_PRINTERQUEUE            = 0x00002e19U,
    DISPID_PRINTEREXTENSION_CONTEXT_PRINTSCHEMATICKET       = 0x00002e1aU,
    DISPID_PRINTEREXTENSION_CONTEXT_DRIVERPROPERTIES        = 0x00002e1bU,
    DISPID_PRINTEREXTENSION_CONTEXT_USERPROPERTIES          = 0x00002e1cU,
    DISPID_PRINTEREXTENSION_REQUEST                         = 0x00002e7cU,
    DISPID_PRINTEREXTENSION_REQUEST_CANCEL                  = 0x00002e7dU,
    DISPID_PRINTEREXTENSION_REQUEST_COMPLETE                = 0x00002e7eU,
    DISPID_PRINTEREXTENSION_EVENTARGS                       = 0x00002ee0U,
    DISPID_PRINTEREXTENSION_EVENTARGS_BIDINOTIFICATION      = 0x00002ee1U,
    DISPID_PRINTEREXTENSION_EVENTARGS_REASONID              = 0x00002ee2U,
    DISPID_PRINTEREXTENSION_EVENTARGS_REQUEST               = 0x00002ee3U,
    DISPID_PRINTEREXTENSION_EVENTARGS_SOURCEAPPLICATION     = 0x00002ee4U,
    DISPID_PRINTEREXTENSION_EVENTARGS_DETAILEDREASONID      = 0x00002ee5U,
    DISPID_PRINTEREXTENSION_EVENTARGS_WINDOWMODAL           = 0x00002ee6U,
    DISPID_PRINTEREXTENSION_EVENTARGS_WINDOWPARENT          = 0x00002ee7U,
    DISPID_PRINTEREXTENSION_CONTEXTCOLLECTION               = 0x00002f44U,
    DISPID_PRINTEREXTENSION_CONTEXTCOLLECTION_COUNT         = 0x00002f45U,
    DISPID_PRINTEREXTENSION_CONTEXTCOLLECTION_GETAT         = 0x00002f46U,
    DISPID_PRINTEREXTENSION_EVENT                           = 0x00002fa8U,
    DISPID_PRINTEREXTENSION_EVENT_ONDRIVEREVENT             = 0x00002fa9U,
    DISPID_PRINTEREXTENSION_EVENT_ONPRINTERQUEUESENUMERATED = 0x00002faaU,
}

enum : uint
{
    DISPID_PRINTERSCRIPTCONTEXT                  = 0x0000300cU,
    DISPID_PRINTERSCRIPTCONTEXT_DRIVERPROPERTIES = 0x0000300dU,
    DISPID_PRINTERSCRIPTCONTEXT_QUEUEPROPERTIES  = 0x0000300eU,
    DISPID_PRINTERSCRIPTCONTEXT_USERPROPERTIES   = 0x0000300fU,
}

enum : uint
{
    DISPID_PRINTSCHEMA_PARAMETERINITIALIZER                  = 0x00003070U,
    DISPID_PRINTSCHEMA_PARAMETERINITIALIZER_VALUE            = 0x00003071U,
    DISPID_PRINTSCHEMA_PARAMETERDEFINITION                   = 0x000030d4U,
    DISPID_PRINTSCHEMA_PARAMETERDEFINITION_USERINPUTREQUIRED = 0x000030d5U,
    DISPID_PRINTSCHEMA_PARAMETERDEFINITION_UNITTYPE          = 0x000030d6U,
    DISPID_PRINTSCHEMA_PARAMETERDEFINITION_DATATYPE          = 0x000030d7U,
    DISPID_PRINTSCHEMA_PARAMETERDEFINITION_RANGEMIN          = 0x000030d8U,
    DISPID_PRINTSCHEMA_PARAMETERDEFINITION_RANGEMAX          = 0x000030d9U,
}

enum : uint
{
    DISPID_PRINTJOBCOLLECTION       = 0x00003138U,
    DISPID_PRINTJOBCOLLECTION_COUNT = 0x00003139U,
    DISPID_PRINTJOBCOLLECTION_GETAT = 0x0000313aU,
}

enum : uint
{
    DISPID_PRINTERQUEUEVIEW                 = 0x0000319cU,
    DISPID_PRINTERQUEUEVIEW_SETVIEWRANGE    = 0x0000319dU,
    DISPID_PRINTERQUEUEVIEW_EVENT           = 0x00003200U,
    DISPID_PRINTERQUEUEVIEW_EVENT_ONCHANGED = 0x00003201U,
}

enum GUID NOTIFICATION_RELEASE = GUID("ba9a5027-a70e-4ae7-9b7d-eb3e06ad4157");
enum GUID PRINT_APP_BIDI_NOTIFY_CHANNEL = GUID("2abad223-b994-4aca-82fc-4571b1b585ac");
enum GUID PRINT_PORT_MONITOR_NOTIFY_CHANNEL = GUID("25df3b0e-74a9-47f5-80ce-79b4b1eb5c58");

enum : GUID
{
    GUID_DEVINTERFACE_USBPRINT     = GUID("28d78fad-5a12-11d1-ae5b-0000f803a8c2"),
    GUID_DEVINTERFACE_IPPUSB_PRINT = GUID("f2f40381-f46d-4e51-bce7-62de6cf2d098"),
}

enum GUID CLSID_XPSRASTERIZER_FACTORY = GUID("503e79bf-1d09-4764-9d72-1eb0c65967c6");

// Callbacks

alias PFN_PRINTING_ENUMPORTS = BOOL function(PWSTR param0, uint param1, ubyte* param2, uint param3, uint* param4, 
                                             uint* param5);
alias PFN_PRINTING_OPENPORT = BOOL function(PWSTR param0, HANDLE* param1);
alias PFN_PRINTING_OPENPORTEX = BOOL function(HANDLE param0, PWSTR param1, PWSTR param2, HANDLE* param3, 
                                              MONITOR2* param4);
alias PFN_PRINTING_STARTDOCPORT = BOOL function(HANDLE param0, PWSTR param1, uint param2, uint param3, 
                                                ubyte* param4);
alias PFN_PRINTING_WRITEPORT = BOOL function(HANDLE param0, ubyte* param1, uint param2, uint* param3);
alias PFN_PRINTING_READPORT = BOOL function(HANDLE param0, ubyte* param1, uint param2, uint* param3);
alias PFN_PRINTING_ENDDOCPORT = BOOL function(HANDLE param0);
alias PFN_PRINTING_CLOSEPORT = BOOL function(HANDLE param0);
alias PFN_PRINTING_ADDPORT = BOOL function(PWSTR param0, HWND param1, PWSTR param2);
alias PFN_PRINTING_ADDPORTEX = BOOL function(PWSTR param0, uint param1, ubyte* param2, PWSTR param3);
alias PFN_PRINTING_CONFIGUREPORT = BOOL function(PWSTR param0, HWND param1, PWSTR param2);
alias PFN_PRINTING_DELETEPORT = BOOL function(PWSTR param0, HWND param1, PWSTR param2);
alias PFN_PRINTING_GETPRINTERDATAFROMPORT = BOOL function(HANDLE param0, uint param1, PWSTR param2, PWSTR param3, 
                                                          uint param4, PWSTR param5, uint param6, uint* param7);
alias PFN_PRINTING_SETPORTTIMEOUTS = BOOL function(HANDLE param0, COMMTIMEOUTS* param1, 
                                                   /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint param2);
alias PFN_PRINTING_XCVOPENPORT = BOOL function(const(PWSTR) param0, uint param1, HANDLE* param2);
alias PFN_PRINTING_XCVDATAPORT = uint function(HANDLE param0, const(PWSTR) param1, ubyte* param2, uint param3, 
                                               ubyte* param4, uint param5, uint* param6);
alias PFN_PRINTING_XCVCLOSEPORT = BOOL function(HANDLE param0);
alias PFN_PRINTING_ENUMPORTS2 = BOOL function(HANDLE param0, PWSTR param1, uint param2, ubyte* param3, uint param4, 
                                              uint* param5, uint* param6);
alias PFN_PRINTING_OPENPORT2 = BOOL function(HANDLE param0, PWSTR param1, HANDLE* param2);
alias PFN_PRINTING_OPENPORTEX2 = BOOL function(HANDLE param0, HANDLE param1, PWSTR param2, PWSTR param3, 
                                               HANDLE* param4, MONITOR2* param5);
alias PFN_PRINTING_STARTDOCPORT2 = BOOL function(HANDLE param0, PWSTR param1, uint param2, uint param3, 
                                                 ubyte* param4);
alias PFN_PRINTING_WRITEPORT2 = BOOL function(HANDLE param0, ubyte* param1, uint param2, uint* param3);
alias PFN_PRINTING_READPORT2 = BOOL function(HANDLE param0, ubyte* param1, uint param2, uint* param3);
alias PFN_PRINTING_ENDDOCPORT2 = BOOL function(HANDLE param0);
alias PFN_PRINTING_CLOSEPORT2 = BOOL function(HANDLE param0);
alias PFN_PRINTING_ADDPORT2 = BOOL function(HANDLE param0, PWSTR param1, HWND param2, PWSTR param3);
alias PFN_PRINTING_ADDPORTEX2 = BOOL function(HANDLE param0, PWSTR param1, uint param2, ubyte* param3, 
                                              PWSTR param4);
alias PFN_PRINTING_CONFIGUREPORT2 = BOOL function(HANDLE param0, PWSTR param1, HWND param2, PWSTR param3);
alias PFN_PRINTING_DELETEPORT2 = BOOL function(HANDLE param0, PWSTR param1, HWND param2, PWSTR param3);
alias PFN_PRINTING_GETPRINTERDATAFROMPORT2 = BOOL function(HANDLE param0, uint param1, PWSTR param2, PWSTR param3, 
                                                           uint param4, PWSTR param5, uint param6, uint* param7);
alias PFN_PRINTING_SETPORTTIMEOUTS2 = BOOL function(HANDLE param0, COMMTIMEOUTS* param1, 
                                                    /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint param2);
alias PFN_PRINTING_XCVOPENPORT2 = BOOL function(HANDLE param0, const(PWSTR) param1, uint param2, HANDLE* param3);
alias PFN_PRINTING_XCVDATAPORT2 = uint function(HANDLE param0, const(PWSTR) param1, ubyte* param2, uint param3, 
                                                ubyte* param4, uint param5, uint* param6);
alias PFN_PRINTING_XCVCLOSEPORT2 = BOOL function(HANDLE param0);
alias PFN_PRINTING_SHUTDOWN2 = void function(HANDLE param0);
alias PFN_PRINTING_SENDRECVBIDIDATAFROMPORT2 = uint function(HANDLE param0, uint param1, const(PWSTR) param2, 
                                                             BIDI_REQUEST_CONTAINER* param3, 
                                                             BIDI_RESPONSE_CONTAINER** param4);
alias PFN_PRINTING_NOTIFYUSEDPORTS2 = uint function(HANDLE param0, uint param1, const(PWSTR) param2);
alias PFN_PRINTING_NOTIFYUNUSEDPORTS2 = uint function(HANDLE param0, uint param1, const(PWSTR) param2);
alias PFN_PRINTING_POWEREVENT2 = uint function(HANDLE param0, uint param1, POWERBROADCAST_SETTING* param2);
alias _CPSUICALLBACK = int function(CPSUICBPARAM* pCPSUICBParam);
alias PFNCOMPROPSHEET = ptrdiff_t function(HANDLE hComPropSheet, uint Function, LPARAM lParam1, LPARAM lParam2);
alias PFNPROPSHEETUI = int function(PROPSHEETUI_INFO* pPSUIInfo, LPARAM lParam);
alias PFN_DrvGetDriverSetting = BOOL function(void* pdriverobj, const(PSTR) Feature, 
                                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pOutput, 
                                              uint cbSize, uint* pcbNeeded, uint* pdwOptionsReturned);
alias PFN_DrvUpgradeRegistrySetting = BOOL function(HANDLE hPrinter, const(PSTR) pFeature, const(PSTR) pOption);
alias PFN_DrvUpdateUISetting = BOOL function(void* pdriverobj, void* pOptItem, uint dwPreviousSelection, 
                                             uint dwMode);
alias OEMCUIPCALLBACK = int function(CPSUICBPARAM* param0, OEMCUIPPARAM* param1);
alias EMFPLAYPROC = int function(HDC param0, int param1, HANDLE param2);
alias ROUTER_NOTIFY_CALLBACK = BOOL function(uint dwCommand, void* pContext, uint dwColor, 
                                             PRINTER_NOTIFY_INFO* pNofityInfo, uint fdwFlags, uint* pdwResult);

// Structs


@RAIIFree!ClosePrinter
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
//STRUCT ATTR: MetadataTypedefAttribute : CustomAttributeSig([], [])
struct PRINTER_HANDLE
{
    void* Value;
}

@RAIIFree!FindClosePrinterChangeNotification
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
//STRUCT ATTR: MetadataTypedefAttribute : CustomAttributeSig([], [])
struct FINDPRINTERCHANGENOTIFICATION_HANDLE
{
    void* Value;
}

version(X86_64)
{
    struct SPLCLIENT_INFO_2_WINXP
    {
        ulong hSplPrinter;
    }
}

version(AArch64)
{
    struct SPLCLIENT_INFO_2_WINXP
    {
        ulong hSplPrinter;
    }
}

struct ImgErrorInfo
{
    BSTR  description;
    GUID  guid;
    uint  helpContext;
    BSTR  helpFile;
    BSTR  source;
    BSTR  devDescription;
    GUID  errorID;
    uint  cUserParameters;
    BSTR* aUserParameters;
    BSTR  userFallback;
    uint  exceptionID;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct OPTPARAM
{
    ushort    cbSize;
    ubyte     Flags;
    ubyte     Style;
    byte*     pData;
    size_t    IconID;
    LPARAM    lParam;
    size_t[2] dwReserved;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct OPTCOMBO
{
    ushort    cbSize;
    ubyte     Flags;
    ushort    cListItem;
    OPTPARAM* pListItem;
    int       Sel;
    uint[3]   dwReserved;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct OPTTYPE
{
    ushort    cbSize;
    ubyte     Type;
    ubyte     Flags;
    ushort    Count;
    ushort    BegCtrlID;
    OPTPARAM* pOptParam;
    ushort    Style;
    ushort[3] wReserved;
    size_t[3] dwReserved;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct EXTPUSH
{
    ushort    cbSize;
    ushort    Flags;
    byte*     pTitle;
    union
    {
        DLGPROC DlgProc;
        FARPROC pfnCallBack;
    }
    size_t    IconID;
    union
    {
        ushort DlgTemplateID;
        HANDLE hDlgTemplate;
    }
    size_t[3] dwReserved;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct EXTCHKBOX
{
    ushort    cbSize;
    ushort    Flags;
    byte*     pTitle;
    byte*     pSeparator;
    byte*     pCheckedName;
    size_t    IconID;
    ushort[4] wReserved;
    size_t[2] dwReserved;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct OIEXT
{
    ushort    cbSize;
    ushort    Flags;
    HINSTANCE hInstCaller;
    byte*     pHelpFile;
    size_t[4] dwReserved;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct OPTITEM
{
    ushort    cbSize;
    ubyte     Level;
    ubyte     DlgPageIdx;
    uint      Flags;
    size_t    UserData;
    byte*     pName;
    union
    {
        int   Sel;
        byte* pSel;
    }
    union
    {
        EXTCHKBOX* pExtChkBox;
        EXTPUSH*   pExtPush;
    }
    OPTTYPE*  pOptType;
    uint      HelpIndex;
    ubyte     DMPubID;
    ubyte     UserItemID;
    ushort    wReserved;
    OIEXT*    pOIExt;
    size_t[3] dwReserved;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct CPSUICBPARAM
{
    ushort   cbSize;
    ushort   Reason;
    HWND     hDlg;
    OPTITEM* pOptItem;
    ushort   cOptItem;
    ushort   Flags;
    OPTITEM* pCurItem;
    union
    {
        int   OldSel;
        byte* pOldSel;
    }
    size_t   UserData;
    size_t   Result;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct DLGPAGE
{
    ushort  cbSize;
    ushort  Flags;
    DLGPROC DlgProc;
    byte*   pTabName;
    size_t  IconID;
    union
    {
        ushort DlgTemplateID;
        HANDLE hDlgTemplate;
    }
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct COMPROPSHEETUI
{
    ushort         cbSize;
    ushort         Flags;
    HINSTANCE      hInstCaller;
    byte*          pCallerName;
    size_t         UserData;
    byte*          pHelpFile;
    _CPSUICALLBACK pfnCallBack;
    OPTITEM*       pOptItem;
    DLGPAGE*       pDlgPage;
    ushort         cOptItem;
    ushort         cDlgPage;
    size_t         IconID;
    byte*          pOptItemName;
    ushort         CallerVersion;
    ushort         OptItemVersion;
    size_t[4]      dwReserved;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct SETRESULT_INFO
{
    ushort  cbSize;
    ushort  wReserved;
    HANDLE  hSetResult;
    LRESULT Result;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct INSERTPSUIPAGE_INFO
{
    ushort cbSize;
    ubyte  Type;
    ubyte  Mode;
    size_t dwData1;
    size_t dwData2;
    size_t dwData3;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct PSPINFO
{
    ushort          cbSize;
    ushort          wReserved;
    HANDLE          hComPropSheet;
    HANDLE          hCPSUIPage;
    PFNCOMPROPSHEET pfnComPropSheet;
}

struct CPSUIDATABLOCK
{
    uint   cbData;
    ubyte* pbData;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct PROPSHEETUI_INFO
{
    ushort          cbSize;
    ushort          Version;
    ushort          Flags;
    ushort          Reason;
    HANDLE          hComPropSheet;
    PFNCOMPROPSHEET pfnComPropSheet;
    LPARAM          lParamInit;
    size_t          UserData;
    size_t          Result;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct PROPSHEETUI_GETICON_INFO
{
    ushort cbSize;
    ushort Flags;
    ushort cxIcon;
    ushort cyIcon;
    HICON  hIcon;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct PROPSHEETUI_INFO_HEADER
{
    ushort    cbSize;
    ushort    Flags;
    byte*     pTitle;
    HWND      hWndParent;
    HINSTANCE hInst;
    union
    {
        HICON  hIcon;
        size_t IconID;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/printer-info-1
struct PRINTER_INFO_1A
{
    uint Flags;
    PSTR pDescription;
    PSTR pName;
    PSTR pComment;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/printer-info-1
struct PRINTER_INFO_1W
{
    uint  Flags;
    PWSTR pDescription;
    PWSTR pName;
    PWSTR pComment;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/printer-info-2
struct PRINTER_INFO_2A
{
    PSTR                 pServerName;
    PSTR                 pPrinterName;
    PSTR                 pShareName;
    PSTR                 pPortName;
    PSTR                 pDriverName;
    PSTR                 pComment;
    PSTR                 pLocation;
    DEVMODEA*            pDevMode;
    PSTR                 pSepFile;
    PSTR                 pPrintProcessor;
    PSTR                 pDatatype;
    PSTR                 pParameters;
    PSECURITY_DESCRIPTOR pSecurityDescriptor;
    uint                 Attributes;
    uint                 Priority;
    uint                 DefaultPriority;
    uint                 StartTime;
    uint                 UntilTime;
    uint                 Status;
    uint                 cJobs;
    uint                 AveragePPM;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/printer-info-2
struct PRINTER_INFO_2W
{
    PWSTR                pServerName;
    PWSTR                pPrinterName;
    PWSTR                pShareName;
    PWSTR                pPortName;
    PWSTR                pDriverName;
    PWSTR                pComment;
    PWSTR                pLocation;
    DEVMODEW*            pDevMode;
    PWSTR                pSepFile;
    PWSTR                pPrintProcessor;
    PWSTR                pDatatype;
    PWSTR                pParameters;
    PSECURITY_DESCRIPTOR pSecurityDescriptor;
    uint                 Attributes;
    uint                 Priority;
    uint                 DefaultPriority;
    uint                 StartTime;
    uint                 UntilTime;
    uint                 Status;
    uint                 cJobs;
    uint                 AveragePPM;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/printer-info-3
struct PRINTER_INFO_3
{
    PSECURITY_DESCRIPTOR pSecurityDescriptor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/printer-info-4
struct PRINTER_INFO_4A
{
    PSTR pPrinterName;
    PSTR pServerName;
    uint Attributes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/printer-info-4
struct PRINTER_INFO_4W
{
    PWSTR pPrinterName;
    PWSTR pServerName;
    uint  Attributes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/printer-info-5
struct PRINTER_INFO_5A
{
    PSTR pPrinterName;
    PSTR pPortName;
    uint Attributes;
    uint DeviceNotSelectedTimeout;
    uint TransmissionRetryTimeout;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/printer-info-5
struct PRINTER_INFO_5W
{
    PWSTR pPrinterName;
    PWSTR pPortName;
    uint  Attributes;
    uint  DeviceNotSelectedTimeout;
    uint  TransmissionRetryTimeout;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/printer-info-6
struct PRINTER_INFO_6
{
    uint dwStatus;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/printer-info-7
struct PRINTER_INFO_7A
{
    PSTR pszObjectGUID;
    uint dwAction;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/printer-info-7
struct PRINTER_INFO_7W
{
    PWSTR pszObjectGUID;
    uint  dwAction;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/printer-info-8
struct PRINTER_INFO_8A
{
    DEVMODEA* pDevMode;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/printer-info-8
struct PRINTER_INFO_8W
{
    DEVMODEW* pDevMode;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/printer-info-9
struct PRINTER_INFO_9A
{
    DEVMODEA* pDevMode;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/printer-info-9
struct PRINTER_INFO_9W
{
    DEVMODEW* pDevMode;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/job-info-1
struct JOB_INFO_1A
{
    uint       JobId;
    PSTR       pPrinterName;
    PSTR       pMachineName;
    PSTR       pUserName;
    PSTR       pDocument;
    PSTR       pDatatype;
    PSTR       pStatus;
    uint       Status;
    uint       Priority;
    uint       Position;
    uint       TotalPages;
    uint       PagesPrinted;
    SYSTEMTIME Submitted;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/job-info-1
struct JOB_INFO_1W
{
    uint       JobId;
    PWSTR      pPrinterName;
    PWSTR      pMachineName;
    PWSTR      pUserName;
    PWSTR      pDocument;
    PWSTR      pDatatype;
    PWSTR      pStatus;
    uint       Status;
    uint       Priority;
    uint       Position;
    uint       TotalPages;
    uint       PagesPrinted;
    SYSTEMTIME Submitted;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/job-info-2
struct JOB_INFO_2A
{
    uint                 JobId;
    PSTR                 pPrinterName;
    PSTR                 pMachineName;
    PSTR                 pUserName;
    PSTR                 pDocument;
    PSTR                 pNotifyName;
    PSTR                 pDatatype;
    PSTR                 pPrintProcessor;
    PSTR                 pParameters;
    PSTR                 pDriverName;
    DEVMODEA*            pDevMode;
    PSTR                 pStatus;
    PSECURITY_DESCRIPTOR pSecurityDescriptor;
    uint                 Status;
    uint                 Priority;
    uint                 Position;
    uint                 StartTime;
    uint                 UntilTime;
    uint                 TotalPages;
    uint                 Size;
    SYSTEMTIME           Submitted;
    uint                 Time;
    uint                 PagesPrinted;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/job-info-2
struct JOB_INFO_2W
{
    uint                 JobId;
    PWSTR                pPrinterName;
    PWSTR                pMachineName;
    PWSTR                pUserName;
    PWSTR                pDocument;
    PWSTR                pNotifyName;
    PWSTR                pDatatype;
    PWSTR                pPrintProcessor;
    PWSTR                pParameters;
    PWSTR                pDriverName;
    DEVMODEW*            pDevMode;
    PWSTR                pStatus;
    PSECURITY_DESCRIPTOR pSecurityDescriptor;
    uint                 Status;
    uint                 Priority;
    uint                 Position;
    uint                 StartTime;
    uint                 UntilTime;
    uint                 TotalPages;
    uint                 Size;
    SYSTEMTIME           Submitted;
    uint                 Time;
    uint                 PagesPrinted;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/job-info-3
struct JOB_INFO_3
{
    uint JobId;
    uint NextJobId;
    uint Reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/job-info-4
struct JOB_INFO_4A
{
    uint                 JobId;
    PSTR                 pPrinterName;
    PSTR                 pMachineName;
    PSTR                 pUserName;
    PSTR                 pDocument;
    PSTR                 pNotifyName;
    PSTR                 pDatatype;
    PSTR                 pPrintProcessor;
    PSTR                 pParameters;
    PSTR                 pDriverName;
    DEVMODEA*            pDevMode;
    PSTR                 pStatus;
    PSECURITY_DESCRIPTOR pSecurityDescriptor;
    uint                 Status;
    uint                 Priority;
    uint                 Position;
    uint                 StartTime;
    uint                 UntilTime;
    uint                 TotalPages;
    uint                 Size;
    SYSTEMTIME           Submitted;
    uint                 Time;
    uint                 PagesPrinted;
    int                  SizeHigh;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/job-info-4
struct JOB_INFO_4W
{
    uint                 JobId;
    PWSTR                pPrinterName;
    PWSTR                pMachineName;
    PWSTR                pUserName;
    PWSTR                pDocument;
    PWSTR                pNotifyName;
    PWSTR                pDatatype;
    PWSTR                pPrintProcessor;
    PWSTR                pParameters;
    PWSTR                pDriverName;
    DEVMODEW*            pDevMode;
    PWSTR                pStatus;
    PSECURITY_DESCRIPTOR pSecurityDescriptor;
    uint                 Status;
    uint                 Priority;
    uint                 Position;
    uint                 StartTime;
    uint                 UntilTime;
    uint                 TotalPages;
    uint                 Size;
    SYSTEMTIME           Submitted;
    uint                 Time;
    uint                 PagesPrinted;
    int                  SizeHigh;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/addjob-info-1
struct ADDJOB_INFO_1A
{
    PSTR Path;
    uint JobId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/addjob-info-1
struct ADDJOB_INFO_1W
{
    PWSTR Path;
    uint  JobId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/driver-info-1
struct DRIVER_INFO_1A
{
    PSTR pName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/driver-info-1
struct DRIVER_INFO_1W
{
    PWSTR pName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/driver-info-2
struct DRIVER_INFO_2A
{
    uint cVersion;
    PSTR pName;
    PSTR pEnvironment;
    PSTR pDriverPath;
    PSTR pDataFile;
    PSTR pConfigFile;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/driver-info-2
struct DRIVER_INFO_2W
{
    uint  cVersion;
    PWSTR pName;
    PWSTR pEnvironment;
    PWSTR pDriverPath;
    PWSTR pDataFile;
    PWSTR pConfigFile;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/driver-info-3
struct DRIVER_INFO_3A
{
    uint cVersion;
    PSTR pName;
    PSTR pEnvironment;
    PSTR pDriverPath;
    PSTR pDataFile;
    PSTR pConfigFile;
    PSTR pHelpFile;
    PSTR pDependentFiles;
    PSTR pMonitorName;
    PSTR pDefaultDataType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/driver-info-3
struct DRIVER_INFO_3W
{
    uint  cVersion;
    PWSTR pName;
    PWSTR pEnvironment;
    PWSTR pDriverPath;
    PWSTR pDataFile;
    PWSTR pConfigFile;
    PWSTR pHelpFile;
    PWSTR pDependentFiles;
    PWSTR pMonitorName;
    PWSTR pDefaultDataType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/driver-info-4
struct DRIVER_INFO_4A
{
    uint cVersion;
    PSTR pName;
    PSTR pEnvironment;
    PSTR pDriverPath;
    PSTR pDataFile;
    PSTR pConfigFile;
    PSTR pHelpFile;
    PSTR pDependentFiles;
    PSTR pMonitorName;
    PSTR pDefaultDataType;
    PSTR pszzPreviousNames;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/driver-info-4
struct DRIVER_INFO_4W
{
    uint  cVersion;
    PWSTR pName;
    PWSTR pEnvironment;
    PWSTR pDriverPath;
    PWSTR pDataFile;
    PWSTR pConfigFile;
    PWSTR pHelpFile;
    PWSTR pDependentFiles;
    PWSTR pMonitorName;
    PWSTR pDefaultDataType;
    PWSTR pszzPreviousNames;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/driver-info-5
struct DRIVER_INFO_5A
{
    uint cVersion;
    PSTR pName;
    PSTR pEnvironment;
    PSTR pDriverPath;
    PSTR pDataFile;
    PSTR pConfigFile;
    uint dwDriverAttributes;
    uint dwConfigVersion;
    uint dwDriverVersion;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/driver-info-5
struct DRIVER_INFO_5W
{
    uint  cVersion;
    PWSTR pName;
    PWSTR pEnvironment;
    PWSTR pDriverPath;
    PWSTR pDataFile;
    PWSTR pConfigFile;
    uint  dwDriverAttributes;
    uint  dwConfigVersion;
    uint  dwDriverVersion;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/driver-info-6
struct DRIVER_INFO_6A
{
    uint     cVersion;
    PSTR     pName;
    PSTR     pEnvironment;
    PSTR     pDriverPath;
    PSTR     pDataFile;
    PSTR     pConfigFile;
    PSTR     pHelpFile;
    PSTR     pDependentFiles;
    PSTR     pMonitorName;
    PSTR     pDefaultDataType;
    PSTR     pszzPreviousNames;
    FILETIME ftDriverDate;
    ulong    dwlDriverVersion;
    PSTR     pszMfgName;
    PSTR     pszOEMUrl;
    PSTR     pszHardwareID;
    PSTR     pszProvider;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/driver-info-6
struct DRIVER_INFO_6W
{
    uint     cVersion;
    PWSTR    pName;
    PWSTR    pEnvironment;
    PWSTR    pDriverPath;
    PWSTR    pDataFile;
    PWSTR    pConfigFile;
    PWSTR    pHelpFile;
    PWSTR    pDependentFiles;
    PWSTR    pMonitorName;
    PWSTR    pDefaultDataType;
    PWSTR    pszzPreviousNames;
    FILETIME ftDriverDate;
    ulong    dwlDriverVersion;
    PWSTR    pszMfgName;
    PWSTR    pszOEMUrl;
    PWSTR    pszHardwareID;
    PWSTR    pszProvider;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/driver-info-8
struct DRIVER_INFO_8A
{
    uint     cVersion;
    PSTR     pName;
    PSTR     pEnvironment;
    PSTR     pDriverPath;
    PSTR     pDataFile;
    PSTR     pConfigFile;
    PSTR     pHelpFile;
    PSTR     pDependentFiles;
    PSTR     pMonitorName;
    PSTR     pDefaultDataType;
    PSTR     pszzPreviousNames;
    FILETIME ftDriverDate;
    ulong    dwlDriverVersion;
    PSTR     pszMfgName;
    PSTR     pszOEMUrl;
    PSTR     pszHardwareID;
    PSTR     pszProvider;
    PSTR     pszPrintProcessor;
    PSTR     pszVendorSetup;
    PSTR     pszzColorProfiles;
    PSTR     pszInfPath;
    uint     dwPrinterDriverAttributes;
    PSTR     pszzCoreDriverDependencies;
    FILETIME ftMinInboxDriverVerDate;
    ulong    dwlMinInboxDriverVerVersion;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/driver-info-8
struct DRIVER_INFO_8W
{
    uint     cVersion;
    PWSTR    pName;
    PWSTR    pEnvironment;
    PWSTR    pDriverPath;
    PWSTR    pDataFile;
    PWSTR    pConfigFile;
    PWSTR    pHelpFile;
    PWSTR    pDependentFiles;
    PWSTR    pMonitorName;
    PWSTR    pDefaultDataType;
    PWSTR    pszzPreviousNames;
    FILETIME ftDriverDate;
    ulong    dwlDriverVersion;
    PWSTR    pszMfgName;
    PWSTR    pszOEMUrl;
    PWSTR    pszHardwareID;
    PWSTR    pszProvider;
    PWSTR    pszPrintProcessor;
    PWSTR    pszVendorSetup;
    PWSTR    pszzColorProfiles;
    PWSTR    pszInfPath;
    uint     dwPrinterDriverAttributes;
    PWSTR    pszzCoreDriverDependencies;
    FILETIME ftMinInboxDriverVerDate;
    ulong    dwlMinInboxDriverVerVersion;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/doc-info-1
struct DOC_INFO_1A
{
    PSTR pDocName;
    PSTR pOutputFile;
    PSTR pDatatype;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/doc-info-1
struct DOC_INFO_1W
{
    PWSTR pDocName;
    PWSTR pOutputFile;
    PWSTR pDatatype;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/form-info-1
struct FORM_INFO_1A
{
    uint  Flags;
    PSTR  pName;
    SIZE  Size;
    RECTL ImageableArea;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/form-info-1
struct FORM_INFO_1W
{
    uint  Flags;
    PWSTR pName;
    SIZE  Size;
    RECTL ImageableArea;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/form-info-2
struct FORM_INFO_2A
{
    uint        Flags;
    const(PSTR) pName;
    SIZE        Size;
    RECTL       ImageableArea;
    const(PSTR) pKeyword;
    uint        StringType;
    const(PSTR) pMuiDll;
    uint        dwResourceId;
    const(PSTR) pDisplayName;
    ushort      wLangId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/form-info-2
struct FORM_INFO_2W
{
    uint         Flags;
    const(PWSTR) pName;
    SIZE         Size;
    RECTL        ImageableArea;
    const(PSTR)  pKeyword;
    uint         StringType;
    const(PWSTR) pMuiDll;
    uint         dwResourceId;
    const(PWSTR) pDisplayName;
    ushort       wLangId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/doc-info-2
struct DOC_INFO_2A
{
    PSTR pDocName;
    PSTR pOutputFile;
    PSTR pDatatype;
    uint dwMode;
    uint JobId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/doc-info-2
struct DOC_INFO_2W
{
    PWSTR pDocName;
    PWSTR pOutputFile;
    PWSTR pDatatype;
    uint  dwMode;
    uint  JobId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/doc-info-3
struct DOC_INFO_3A
{
    PSTR pDocName;
    PSTR pOutputFile;
    PSTR pDatatype;
    uint dwFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/doc-info-3
struct DOC_INFO_3W
{
    PWSTR pDocName;
    PWSTR pOutputFile;
    PWSTR pDatatype;
    uint  dwFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/printprocessor-info-1
struct PRINTPROCESSOR_INFO_1A
{
    PSTR pName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/printprocessor-info-1
struct PRINTPROCESSOR_INFO_1W
{
    PWSTR pName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/printprocessor-caps-1
struct PRINTPROCESSOR_CAPS_1
{
    uint dwLevel;
    uint dwNupOptions;
    uint dwPageOrderFlags;
    uint dwNumberOfCopies;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/printprocessor-caps-2
struct PRINTPROCESSOR_CAPS_2
{
    uint dwLevel;
    uint dwNupOptions;
    uint dwPageOrderFlags;
    uint dwNumberOfCopies;
    uint dwDuplexHandlingCaps;
    uint dwNupDirectionCaps;
    uint dwNupBorderCaps;
    uint dwBookletHandlingCaps;
    uint dwScalingCaps;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/port-info-1
struct PORT_INFO_1A
{
    PSTR pName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/port-info-1
struct PORT_INFO_1W
{
    PWSTR pName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/port-info-2
struct PORT_INFO_2A
{
    PSTR pPortName;
    PSTR pMonitorName;
    PSTR pDescription;
    uint fPortType;
    uint Reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/port-info-2
struct PORT_INFO_2W
{
    PWSTR pPortName;
    PWSTR pMonitorName;
    PWSTR pDescription;
    uint  fPortType;
    uint  Reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/port-info-3
struct PORT_INFO_3A
{
    uint dwStatus;
    PSTR pszStatus;
    uint dwSeverity;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/port-info-3
struct PORT_INFO_3W
{
    uint  dwStatus;
    PWSTR pszStatus;
    uint  dwSeverity;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/monitor-info-1
struct MONITOR_INFO_1A
{
    PSTR pName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/monitor-info-1
struct MONITOR_INFO_1W
{
    PWSTR pName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/monitor-info-2
struct MONITOR_INFO_2A
{
    PSTR pName;
    PSTR pEnvironment;
    PSTR pDLLName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/monitor-info-2
struct MONITOR_INFO_2W
{
    PWSTR pName;
    PWSTR pEnvironment;
    PWSTR pDLLName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/datatypes-info-1
struct DATATYPES_INFO_1A
{
    PSTR pName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/datatypes-info-1
struct DATATYPES_INFO_1W
{
    PWSTR pName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/printer-defaults
struct PRINTER_DEFAULTSA
{
    PSTR      pDatatype;
    DEVMODEA* pDevMode;
    PRINTER_ACCESS_RIGHTS DesiredAccess;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/printer-defaults
struct PRINTER_DEFAULTSW
{
    PWSTR     pDatatype;
    DEVMODEW* pDevMode;
    PRINTER_ACCESS_RIGHTS DesiredAccess;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/printer-enum-values
struct PRINTER_ENUM_VALUESA
{
    PSTR   pValueName;
    uint   cbValueName;
    uint   dwType;
    ubyte* pData;
    uint   cbData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/printer-enum-values
struct PRINTER_ENUM_VALUESW
{
    PWSTR  pValueName;
    uint   cbValueName;
    uint   dwType;
    ubyte* pData;
    uint   cbData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/printer-notify-options-type
struct PRINTER_NOTIFY_OPTIONS_TYPE
{
    ushort  Type;
    ushort  Reserved0;
    uint    Reserved1;
    uint    Reserved2;
    uint    Count;
    ushort* pFields;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/printer-notify-options
struct PRINTER_NOTIFY_OPTIONS
{
    uint Version;
    uint Flags;
    uint Count;
    PRINTER_NOTIFY_OPTIONS_TYPE* pTypes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/printer-notify-info-data
struct PRINTER_NOTIFY_INFO_DATA
{
    ushort Type;
    ushort Field;
    uint   Reserved;
    uint   Id;
    union NotifyData
    {
        uint[2] adwData;
        struct Data
        {
            uint  cbBuf;
            void* pBuf;
        }
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/printer-notify-info
struct PRINTER_NOTIFY_INFO
{
    uint Version;
    uint Flags;
    uint Count;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/PRINTER_NOTIFY_INFO_DATA[1] aData;
}

struct BINARY_CONTAINER
{
    uint   cbBuf;
    ubyte* pData;
}

struct BIDI_DATA
{
    uint dwBidiType;
    union u
    {
        BOOL             bData;
        int              iData;
        PWSTR            sData;
        float            fData;
        BINARY_CONTAINER biData;
    }
}

struct BIDI_REQUEST_DATA
{
    uint      dwReqNumber;
    PWSTR     pSchema;
    BIDI_DATA data;
}

struct BIDI_REQUEST_CONTAINER
{
    uint Version;
    uint Flags;
    uint Count;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/BIDI_REQUEST_DATA[1] aData;
}

struct BIDI_RESPONSE_DATA
{
    uint      dwResult;
    uint      dwReqNumber;
    PWSTR     pSchema;
    BIDI_DATA data;
}

struct BIDI_RESPONSE_CONTAINER
{
    uint Version;
    uint Flags;
    uint Count;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/BIDI_RESPONSE_DATA[1] aData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/providor-info-1
struct PROVIDOR_INFO_1A
{
    PSTR pName;
    PSTR pEnvironment;
    PSTR pDLLName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/providor-info-1
struct PROVIDOR_INFO_1W
{
    PWSTR pName;
    PWSTR pEnvironment;
    PWSTR pDLLName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/providor-info-2
struct PROVIDOR_INFO_2A
{
    PSTR pOrder;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/providor-info-2
struct PROVIDOR_INFO_2W
{
    PWSTR pOrder;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct PRINTER_OPTIONSA
{
    uint cbSize;
    /*FIELD ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(PRINTER_OPTION_FLAGS))], [])*/uint dwFlags;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct PRINTER_OPTIONSW
{
    uint cbSize;
    /*FIELD ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(PRINTER_OPTION_FLAGS))], [])*/uint dwFlags;
}

struct PRINTER_CONNECTION_INFO_1A
{
    uint dwFlags;
    PSTR pszDriverName;
}

struct PRINTER_CONNECTION_INFO_1W
{
    uint  dwFlags;
    PWSTR pszDriverName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/core-printer-driver
struct CORE_PRINTER_DRIVERA
{
    GUID      CoreDriverGUID;
    FILETIME  ftDriverDate;
    ulong     dwlDriverVersion;
    CHAR[260] szPackageID;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/core-printer-driver
struct CORE_PRINTER_DRIVERW
{
    GUID       CoreDriverGUID;
    FILETIME   ftDriverDate;
    ulong      dwlDriverVersion;
    wchar[260] szPackageID;
}

struct PrintPropertyValue
{
    EPrintPropertyType ePropertyType;
    union value
    {
        ubyte propertyByte;
        PWSTR propertyString;
        int   propertyInt32;
        long  propertyInt64;
        struct propertyBlob
        {
            uint  cbBuf;
            void* pBuf;
        }
    }
}

struct PrintNamedProperty
{
    PWSTR              propertyName;
    PrintPropertyValue propertyValue;
}

struct PrintPropertiesCollection
{
    uint                numberOfProperties;
    PrintNamedProperty* propertiesCollection;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/print-execution-data
struct PRINT_EXECUTION_DATA
{
    PRINT_EXECUTION_CONTEXT context;
    uint clientAppPID;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/mxdcescapeheader
struct MXDC_ESCAPE_HEADER_T
{
align (1):
    uint cbInput;
    uint cbOutput;
    uint opCode;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/mxdcgetfilenamedata
struct MXDC_GET_FILENAME_DATA_T
{
align (1):
    uint cbOutput;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/wchar[1] wszData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/mxdcs0pagedata
struct MXDC_S0PAGE_DATA_T
{
align (1):
    uint dwSize;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] bData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/mxdcxpss0pageresource
struct MXDC_XPS_S0PAGE_RESOURCE_T
{
align (1):
    uint       dwSize;
    uint       dwResourceType;
    ubyte[260] szUri;
    uint       dwDataSize;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] bData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/mxdcprintticketpassthrough
struct MXDC_PRINTTICKET_DATA_T
{
align (1):
    uint dwDataSize;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] bData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/mxdcprintticketescape
struct MXDC_PRINTTICKET_ESCAPE_T
{
align (1):
    MXDC_ESCAPE_HEADER_T mxdcEscape;
    MXDC_PRINTTICKET_DATA_T printTicketData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/mxdcs0pagepassthroughescape
struct MXDC_S0PAGE_PASSTHROUGH_ESCAPE_T
{
align (1):
    MXDC_ESCAPE_HEADER_T mxdcEscape;
    MXDC_S0PAGE_DATA_T   xpsS0PageData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/mxdcs0pageresourceescape
struct MXDC_S0PAGE_RESOURCE_ESCAPE_T
{
align (1):
    MXDC_ESCAPE_HEADER_T mxdcEscape;
    MXDC_XPS_S0PAGE_RESOURCE_T xpsS0PageResourcePassthrough;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct DEVICEPROPERTYHEADER
{
    ushort cbSize;
    ushort Flags;
    HANDLE hPrinter;
    byte*  pszPrinterName;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct DOCUMENTPROPERTYHEADER
{
    ushort    cbSize;
    ushort    Reserved;
    HANDLE    hPrinter;
    byte*     pszPrinterName;
    DEVMODEA* pdmIn;
    DEVMODEA* pdmOut;
    uint      cbOut;
    uint      fMode;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct DEVQUERYPRINT_INFO
{
    ushort    cbSize;
    ushort    Level;
    HANDLE    hPrinter;
    DEVMODEA* pDevMode;
    PWSTR     pszErrorStr;
    uint      cchErrorStr;
    uint      cchNeeded;
}

struct DRIVER_UPGRADE_INFO_1
{
    byte* pPrinterName;
    byte* pOldDriverDirectory;
}

struct DRIVER_UPGRADE_INFO_2
{
    byte* pPrinterName;
    byte* pOldDriverDirectory;
    uint  cVersion;
    byte* pName;
    byte* pEnvironment;
    byte* pDriverPath;
    byte* pDataFile;
    byte* pConfigFile;
    byte* pHelpFile;
    byte* pDependentFiles;
    byte* pMonitorName;
    byte* pDefaultDataType;
    byte* pszzPreviousNames;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct DOCEVENT_FILTER
{
    uint cbSize;
    uint cElementsAllocated;
    uint cElementsNeeded;
    uint cElementsReturned;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/uint[1] aDocEventCall;
}

struct DOCEVENT_CREATEDCPRE
{
    PWSTR     pszDriver;
    PWSTR     pszDevice;
    DEVMODEW* pdm;
    BOOL      bIC;
}

struct DOCEVENT_ESCAPE
{
    int   iEscape;
    int   cjInput;
    void* pvInData;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct PRINTER_EVENT_ATTRIBUTES_INFO
{
    uint cbSize;
    uint dwOldAttributes;
    uint dwNewAttributes;
}

struct ATTRIBUTE_INFO_1
{
    uint dwJobNumberOfPagesPerSide;
    uint dwDrvNumberOfPagesPerSide;
    uint dwNupBorderFlags;
    uint dwJobPageOrderFlags;
    uint dwDrvPageOrderFlags;
    uint dwJobNumberOfCopies;
    uint dwDrvNumberOfCopies;
}

struct ATTRIBUTE_INFO_2
{
    uint dwJobNumberOfPagesPerSide;
    uint dwDrvNumberOfPagesPerSide;
    uint dwNupBorderFlags;
    uint dwJobPageOrderFlags;
    uint dwDrvPageOrderFlags;
    uint dwJobNumberOfCopies;
    uint dwDrvNumberOfCopies;
    uint dwColorOptimization;
}

struct ATTRIBUTE_INFO_3
{
    uint  dwJobNumberOfPagesPerSide;
    uint  dwDrvNumberOfPagesPerSide;
    uint  dwNupBorderFlags;
    uint  dwJobPageOrderFlags;
    uint  dwDrvPageOrderFlags;
    uint  dwJobNumberOfCopies;
    uint  dwDrvNumberOfCopies;
    uint  dwColorOptimization;
    short dmPrintQuality;
    short dmYResolution;
}

struct ATTRIBUTE_INFO_4
{
    uint  dwJobNumberOfPagesPerSide;
    uint  dwDrvNumberOfPagesPerSide;
    uint  dwNupBorderFlags;
    uint  dwJobPageOrderFlags;
    uint  dwDrvPageOrderFlags;
    uint  dwJobNumberOfCopies;
    uint  dwDrvNumberOfCopies;
    uint  dwColorOptimization;
    short dmPrintQuality;
    short dmYResolution;
    uint  dwDuplexFlags;
    uint  dwNupDirection;
    uint  dwBookletFlags;
    uint  dwScalingPercentX;
    uint  dwScalingPercentY;
}

struct PSCRIPT5_PRIVATE_DEVMODE
{
    ushort[57] wReserved;
    ushort     wSize;
}

struct UNIDRV_PRIVATE_DEVMODE
{
    ushort[4] wReserved;
    ushort    wSize;
}

struct PUBLISHERINFO
{
    uint   dwMode;
    ushort wMinoutlinePPEM;
    ushort wMaxbitmapPPEM;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct OEMDMPARAM
{
    uint      cbSize;
    void*     pdriverobj;
    HANDLE    hPrinter;
    HANDLE    hModule;
    DEVMODEA* pPublicDMIn;
    DEVMODEA* pPublicDMOut;
    void*     pOEMDMIn;
    void*     pOEMDMOut;
    uint      cbBufSize;
}

struct OEM_DMEXTRAHEADER
{
    uint dwSize;
    uint dwSignature;
    uint dwVersion;
}

struct USERDATA
{
    uint    dwSize;
    size_t  dwItemID;
    PSTR    pKeyWordName;
    uint[8] dwReserved;
}

struct SIMULATE_CAPS_1
{
    uint dwLevel;
    uint dwPageOrderFlags;
    uint dwNumberOfCopies;
    uint dwCollate;
    uint dwNupOptions;
}

struct OEMUIPROCS
{
    PFN_DrvGetDriverSetting DrvGetDriverSetting;
    PFN_DrvUpdateUISetting DrvUpdateUISetting;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct OEMUIOBJ
{
    uint        cbSize;
    OEMUIPROCS* pOemUIProcs;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct OEMCUIPPARAM
{
    uint            cbSize;
    OEMUIOBJ*       poemuiobj;
    HANDLE          hPrinter;
    PWSTR           pPrinterName;
    HANDLE          hModule;
    HANDLE          hOEMHeap;
    DEVMODEA*       pPublicDM;
    void*           pOEMDM;
    uint            dwFlags;
    OPTITEM*        pDrvOptItems;
    uint            cDrvOptItems;
    OPTITEM*        pOEMOptItems;
    uint            cOEMOptItems;
    void*           pOEMUserData;
    OEMCUIPCALLBACK OEMCUIPCallback;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct OEMUIPSPARAM
{
    uint      cbSize;
    OEMUIOBJ* poemuiobj;
    HANDLE    hPrinter;
    PWSTR     pPrinterName;
    HANDLE    hModule;
    HANDLE    hOEMHeap;
    DEVMODEA* pPublicDM;
    void*     pOEMDM;
    void*     pOEMUserData;
    uint      dwFlags;
    void*     pOemEntry;
}

struct CUSTOMSIZEPARAM
{
    int dwOrder;
    int lMinVal;
    int lMaxVal;
}

struct PRINT_FEATURE_OPTION
{
    const(PSTR) pszFeature;
    const(PSTR) pszOption;
}

struct UNIFM_HDR
{
    uint    dwSize;
    uint    dwVersion;
    uint    ulDefaultCodepage;
    int     lGlyphSetDataRCID;
    uint    loUnidrvInfo;
    uint    loIFIMetrics;
    uint    loExtTextMetric;
    uint    loWidthTable;
    uint    loKernPair;
    uint[2] dwReserved;
}

struct INVOC
{
    uint dwCount;
    uint loOffset;
}

struct UNIDRVINFO
{
    uint      dwSize;
    uint      flGenFlags;
    ushort    wType;
    ushort    fCaps;
    ushort    wXRes;
    ushort    wYRes;
    short     sYAdjust;
    short     sYMoved;
    ushort    wPrivateData;
    short     sShift;
    INVOC     SelectFont;
    INVOC     UnSelectFont;
    ushort[4] wReserved;
}

struct PRINTIFI32
{
    uint     cjThis;
    uint     cjIfiExtra;
    int      dpwszFamilyName;
    int      dpwszStyleName;
    int      dpwszFaceName;
    int      dpwszUniqueName;
    int      dpFontSim;
    int      lEmbedId;
    int      lItalicAngle;
    int      lCharBias;
    int      dpCharSets;
    ubyte    jWinCharSet;
    ubyte    jWinPitchAndFamily;
    ushort   usWinWeight;
    uint     flInfo;
    ushort   fsSelection;
    ushort   fsType;
    short    fwdUnitsPerEm;
    short    fwdLowestPPEm;
    short    fwdWinAscender;
    short    fwdWinDescender;
    short    fwdMacAscender;
    short    fwdMacDescender;
    short    fwdMacLineGap;
    short    fwdTypoAscender;
    short    fwdTypoDescender;
    short    fwdTypoLineGap;
    short    fwdAveCharWidth;
    short    fwdMaxCharInc;
    short    fwdCapHeight;
    short    fwdXHeight;
    short    fwdSubscriptXSize;
    short    fwdSubscriptYSize;
    short    fwdSubscriptXOffset;
    short    fwdSubscriptYOffset;
    short    fwdSuperscriptXSize;
    short    fwdSuperscriptYSize;
    short    fwdSuperscriptXOffset;
    short    fwdSuperscriptYOffset;
    short    fwdUnderscoreSize;
    short    fwdUnderscorePosition;
    short    fwdStrikeoutSize;
    short    fwdStrikeoutPosition;
    ubyte    chFirstChar;
    ubyte    chLastChar;
    ubyte    chDefaultChar;
    ubyte    chBreakChar;
    wchar    wcFirstChar;
    wchar    wcLastChar;
    wchar    wcDefaultChar;
    wchar    wcBreakChar;
    POINTL   ptlBaseline;
    POINTL   ptlAspect;
    POINTL   ptlCaret;
    RECTL    rclFontBox;
    ubyte[4] achVendId;
    uint     cKerningPairs;
    uint     ulPanoseCulture;
    PANOSE   panose;
}

struct EXTTEXTMETRIC
{
    short  emSize;
    short  emPointSize;
    short  emOrientation;
    short  emMasterHeight;
    short  emMinScale;
    short  emMaxScale;
    short  emMasterUnits;
    short  emCapHeight;
    short  emXHeight;
    short  emLowerCaseAscent;
    short  emLowerCaseDescent;
    short  emSlant;
    short  emSuperScript;
    short  emSubScript;
    short  emSuperScriptSize;
    short  emSubScriptSize;
    short  emUnderlineOffset;
    short  emUnderlineWidth;
    short  emDoubleUpperUnderlineOffset;
    short  emDoubleLowerUnderlineOffset;
    short  emDoubleUpperUnderlineWidth;
    short  emDoubleLowerUnderlineWidth;
    short  emStrikeOutOffset;
    short  emStrikeOutWidth;
    ushort emKernPairs;
    ushort emKernTracks;
}

struct WIDTHRUN
{
    ushort wStartGlyph;
    ushort wGlyphCount;
    uint   loCharWidthOffset;
}

struct WIDTHTABLE
{
    uint dwSize;
    uint dwRunNum;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/WIDTHRUN[1] WidthRun;
}

struct KERNDATA
{
    uint dwSize;
    uint dwKernPairNum;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/FD_KERNINGPAIR[1] KernPair;
}

struct UNI_GLYPHSETDATA
{
    uint    dwSize;
    uint    dwVersion;
    uint    dwFlags;
    int     lPredefinedID;
    uint    dwGlyphCount;
    uint    dwRunCount;
    uint    loRunOffset;
    uint    dwCodePageCount;
    uint    loCodePageOffset;
    uint    loMapTableOffset;
    uint[2] dwReserved;
}

struct UNI_CODEPAGEINFO
{
    uint  dwCodePage;
    INVOC SelectSymbolSet;
    INVOC UnSelectSymbolSet;
}

struct GLYPHRUN
{
    wchar  wcLow;
    ushort wGlyphCount;
}

struct TRANSDATA
{
    ubyte ubCodePageID;
    ubyte ubType;
    union uCode
    {
        short    sCode;
        ubyte    ubCode;
        ubyte[2] ubPairs;
    }
}

struct MAPTABLE
{
    uint dwSize;
    uint dwGlyphNum;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/TRANSDATA[1] Trans;
}

struct UFF_FILEHEADER
{
    uint    dwSignature;
    uint    dwVersion;
    uint    dwSize;
    uint    nFonts;
    uint    nGlyphSets;
    uint    nVarData;
    uint    offFontDir;
    uint    dwFlags;
    uint[4] dwReserved;
}

struct UFF_FONTDIRECTORY
{
    uint   dwSignature;
    ushort wSize;
    ushort wFontID;
    short  sGlyphID;
    ushort wFlags;
    uint   dwInstallerSig;
    uint   offFontName;
    uint   offCartridgeName;
    uint   offFontData;
    uint   offGlyphData;
    uint   offVarData;
}

struct DATA_HEADER
{
    uint   dwSignature;
    ushort wSize;
    ushort wDataID;
    uint   dwDataSize;
    uint   dwReserved;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct OEMFONTINSTPARAM
{
    uint   cbSize;
    HANDLE hPrinter;
    HANDLE hModule;
    HANDLE hHeap;
    uint   dwFlags;
    PWSTR  pFontInstallerName;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct PORT_DATA_1
{
    wchar[64]  sztPortName;
    uint       dwVersion;
    uint       dwProtocol;
    uint       cbSize;
    uint       dwReserved;
    wchar[49]  sztHostAddress;
    wchar[33]  sztSNMPCommunity;
    uint       dwDoubleSpool;
    wchar[33]  sztQueue;
    wchar[16]  sztIPAddress;
    ubyte[540] Reserved;
    uint       dwPortNumber;
    uint       dwSNMPEnabled;
    uint       dwSNMPDevIndex;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct PORT_DATA_2
{
    wchar[64]  sztPortName;
    uint       dwVersion;
    uint       dwProtocol;
    uint       cbSize;
    uint       dwReserved;
    wchar[128] sztHostAddress;
    wchar[33]  sztSNMPCommunity;
    uint       dwDoubleSpool;
    wchar[33]  sztQueue;
    ubyte[514] Reserved;
    uint       dwPortNumber;
    uint       dwSNMPEnabled;
    uint       dwSNMPDevIndex;
    uint       dwPortMonitorMibIndex;
}

struct PORT_DATA_LIST_1
{
    uint dwVersion;
    uint cPortData;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/PORT_DATA_2[1] pPortData;
}

struct DELETE_PORT_DATA_1
{
    wchar[64] psztPortName;
    ubyte[98] Reserved;
    uint      dwVersion;
    uint      dwReserved;
}

struct CONFIG_INFO_DATA_1
{
    ubyte[128] Reserved;
    uint       dwVersion;
}

struct BranchOfficeJobDataPrinted
{
    uint  Status;
    PWSTR pDocumentName;
    PWSTR pUserName;
    PWSTR pMachineName;
    PWSTR pPrinterName;
    PWSTR pPortName;
    long  Size;
    uint  TotalPages;
}

struct BranchOfficeJobDataError
{
    uint  LastError;
    PWSTR pDocumentName;
    PWSTR pUserName;
    PWSTR pPrinterName;
    PWSTR pDataType;
    long  TotalSize;
    long  PrintedSize;
    uint  TotalPages;
    uint  PrintedPages;
    PWSTR pMachineName;
    PWSTR pJobError;
    PWSTR pErrorDescription;
}

struct BranchOfficeJobDataRendered
{
    long  Size;
    uint  ICMMethod;
    short Color;
    short PrintQuality;
    short YResolution;
    short Copies;
    short TTOption;
}

struct BranchOfficeJobDataPipelineFailed
{
    PWSTR pDocumentName;
    PWSTR pPrinterName;
    PWSTR pExtraErrorInfo;
}

struct BranchOfficeLogOfflineFileFull
{
    PWSTR pMachineName;
}

struct BranchOfficeJobData
{
    EBranchOfficeJobEventType eEventType;
    uint JobId;
    union JobInfo
    {
        BranchOfficeJobDataPrinted LogJobPrinted;
        BranchOfficeJobDataRendered LogJobRendered;
        BranchOfficeJobDataError LogJobError;
        BranchOfficeJobDataPipelineFailed LogPipelineFailed;
        BranchOfficeLogOfflineFileFull LogOfflineFileFull;
    }
}

struct BranchOfficeJobDataContainer
{
    uint cJobDataEntries;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/BranchOfficeJobData[1] JobData;
}

struct PRINTER_NOTIFY_INIT
{
    uint Size;
    uint Reserved;
    uint PollTime;
}

struct SPLCLIENT_INFO_1
{
    uint   dwSize;
    PWSTR  pMachineName;
    PWSTR  pUserName;
    uint   dwBuildNum;
    uint   dwMajorVersion;
    uint   dwMinorVersion;
    ushort wProcessorArchitecture;
}

struct SPLCLIENT_INFO_2_W2K
{
    size_t hSplPrinter;
}

version(X86)
{
    struct SPLCLIENT_INFO_2_WINXP
    {
        uint hSplPrinter;
    }
}

struct _SPLCLIENT_INFO_2_V3
{
    ulong hSplPrinter;
}

struct DOC_INFO_INTERNAL
{
    byte*  pDocName;
    byte*  pOutputFile;
    byte*  pDatatype;
    BOOL   bLowILJob;
    HANDLE hTokenLowIL;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct SPLCLIENT_INFO_3_VISTA
{
    uint   cbSize;
    uint   dwFlags;
    uint   dwSize;
    PWSTR  pMachineName;
    PWSTR  pUserName;
    uint   dwBuildNum;
    uint   dwMajorVersion;
    uint   dwMinorVersion;
    ushort wProcessorArchitecture;
    ulong  hSplPrinter;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct SPLCLIENT_INFO_INTERNAL
{
    uint   cbSize;
    uint   dwFlags;
    uint   dwSize;
    PWSTR  pMachineName;
    PWSTR  pUserName;
    uint   dwBuildNum;
    uint   dwMajorVersion;
    uint   dwMinorVersion;
    ushort wProcessorArchitecture;
    ulong  hSplPrinter;
    uint   dwProcessId;
    uint   dwSessionId;
}

struct PRINTPROVIDOR
{
    ptrdiff_t fpOpenPrinter;
    ptrdiff_t fpSetJob;
    ptrdiff_t fpGetJob;
    ptrdiff_t fpEnumJobs;
    ptrdiff_t fpAddPrinter;
    ptrdiff_t fpDeletePrinter;
    ptrdiff_t fpSetPrinter;
    ptrdiff_t fpGetPrinter;
    ptrdiff_t fpEnumPrinters;
    ptrdiff_t fpAddPrinterDriver;
    ptrdiff_t fpEnumPrinterDrivers;
    ptrdiff_t fpGetPrinterDriver;
    ptrdiff_t fpGetPrinterDriverDirectory;
    ptrdiff_t fpDeletePrinterDriver;
    ptrdiff_t fpAddPrintProcessor;
    ptrdiff_t fpEnumPrintProcessors;
    ptrdiff_t fpGetPrintProcessorDirectory;
    ptrdiff_t fpDeletePrintProcessor;
    ptrdiff_t fpEnumPrintProcessorDatatypes;
    ptrdiff_t fpStartDocPrinter;
    ptrdiff_t fpStartPagePrinter;
    ptrdiff_t fpWritePrinter;
    ptrdiff_t fpEndPagePrinter;
    ptrdiff_t fpAbortPrinter;
    ptrdiff_t fpReadPrinter;
    ptrdiff_t fpEndDocPrinter;
    ptrdiff_t fpAddJob;
    ptrdiff_t fpScheduleJob;
    ptrdiff_t fpGetPrinterData;
    ptrdiff_t fpSetPrinterData;
    ptrdiff_t fpWaitForPrinterChange;
    ptrdiff_t fpClosePrinter;
    ptrdiff_t fpAddForm;
    ptrdiff_t fpDeleteForm;
    ptrdiff_t fpGetForm;
    ptrdiff_t fpSetForm;
    ptrdiff_t fpEnumForms;
    ptrdiff_t fpEnumMonitors;
    ptrdiff_t fpEnumPorts;
    ptrdiff_t fpAddPort;
    ptrdiff_t fpConfigurePort;
    ptrdiff_t fpDeletePort;
    ptrdiff_t fpCreatePrinterIC;
    ptrdiff_t fpPlayGdiScriptOnPrinterIC;
    ptrdiff_t fpDeletePrinterIC;
    ptrdiff_t fpAddPrinterConnection;
    ptrdiff_t fpDeletePrinterConnection;
    ptrdiff_t fpPrinterMessageBox;
    ptrdiff_t fpAddMonitor;
    ptrdiff_t fpDeleteMonitor;
    ptrdiff_t fpResetPrinter;
    ptrdiff_t fpGetPrinterDriverEx;
    ptrdiff_t fpFindFirstPrinterChangeNotification;
    ptrdiff_t fpFindClosePrinterChangeNotification;
    ptrdiff_t fpAddPortEx;
    ptrdiff_t fpShutDown;
    ptrdiff_t fpRefreshPrinterChangeNotification;
    ptrdiff_t fpOpenPrinterEx;
    ptrdiff_t fpAddPrinterEx;
    ptrdiff_t fpSetPort;
    ptrdiff_t fpEnumPrinterData;
    ptrdiff_t fpDeletePrinterData;
    ptrdiff_t fpClusterSplOpen;
    ptrdiff_t fpClusterSplClose;
    ptrdiff_t fpClusterSplIsAlive;
    ptrdiff_t fpSetPrinterDataEx;
    ptrdiff_t fpGetPrinterDataEx;
    ptrdiff_t fpEnumPrinterDataEx;
    ptrdiff_t fpEnumPrinterKey;
    ptrdiff_t fpDeletePrinterDataEx;
    ptrdiff_t fpDeletePrinterKey;
    ptrdiff_t fpSeekPrinter;
    ptrdiff_t fpDeletePrinterDriverEx;
    ptrdiff_t fpAddPerMachineConnection;
    ptrdiff_t fpDeletePerMachineConnection;
    ptrdiff_t fpEnumPerMachineConnections;
    ptrdiff_t fpXcvData;
    ptrdiff_t fpAddPrinterDriverEx;
    ptrdiff_t fpSplReadPrinter;
    ptrdiff_t fpDriverUnloadComplete;
    ptrdiff_t fpGetSpoolFileInfo;
    ptrdiff_t fpCommitSpoolData;
    ptrdiff_t fpCloseSpoolFileHandle;
    ptrdiff_t fpFlushPrinter;
    ptrdiff_t fpSendRecvBidiData;
    ptrdiff_t fpAddPrinterConnection2;
    ptrdiff_t fpGetPrintClassObject;
    ptrdiff_t fpReportJobProcessingProgress;
    ptrdiff_t fpEnumAndLogProvidorObjects;
    ptrdiff_t fpInternalGetPrinterDriver;
    ptrdiff_t fpFindCompatibleDriver;
    ptrdiff_t fpInstallPrinterDriverPackageFromConnection;
    ptrdiff_t fpGetJobNamedPropertyValue;
    ptrdiff_t fpSetJobNamedProperty;
    ptrdiff_t fpDeleteJobNamedProperty;
    ptrdiff_t fpEnumJobNamedProperties;
    ptrdiff_t fpPowerEvent;
    ptrdiff_t fpGetUserPropertyBag;
    ptrdiff_t fpCanShutdown;
    ptrdiff_t fpLogJobInfoForBranchOffice;
    ptrdiff_t fpRegeneratePrintDeviceCapabilities;
    ptrdiff_t fpPrintSupportOperation;
    ptrdiff_t fpIppCreateJobOnPrinter;
    ptrdiff_t fpIppGetJobAttributes;
    ptrdiff_t fpIppSetJobAttributes;
    ptrdiff_t fpIppGetPrinterAttributes;
    ptrdiff_t fpIppSetPrinterAttributes;
    ptrdiff_t fpIppCreateJobOnPrinterWithAttributes;
}

struct PRINTPROCESSOROPENDATA
{
    DEVMODEA* pDevMode;
    PWSTR     pDatatype;
    PWSTR     pParameters;
    PWSTR     pDocumentName;
    uint      JobId;
    PWSTR     pOutputFile;
    PWSTR     pPrinterName;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct MONITORREG
{
    uint      cbSize;
    ptrdiff_t fpCreateKey;
    ptrdiff_t fpOpenKey;
    ptrdiff_t fpCloseKey;
    ptrdiff_t fpDeleteKey;
    ptrdiff_t fpEnumKey;
    ptrdiff_t fpQueryInfoKey;
    ptrdiff_t fpSetValue;
    ptrdiff_t fpDeleteValue;
    ptrdiff_t fpEnumValue;
    ptrdiff_t fpQueryValue;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct MONITORINIT
{
    uint         cbSize;
    HANDLE       hSpooler;
    HKEY         hckRegistryRoot;
    MONITORREG*  pMonitorReg;
    BOOL         bLocal;
    const(PWSTR) pszServerName;
}

struct MONITOR
{
    PFN_PRINTING_ENUMPORTS pfnEnumPorts;
    PFN_PRINTING_OPENPORT pfnOpenPort;
    PFN_PRINTING_OPENPORTEX pfnOpenPortEx;
    PFN_PRINTING_STARTDOCPORT pfnStartDocPort;
    PFN_PRINTING_WRITEPORT pfnWritePort;
    PFN_PRINTING_READPORT pfnReadPort;
    PFN_PRINTING_ENDDOCPORT pfnEndDocPort;
    PFN_PRINTING_CLOSEPORT pfnClosePort;
    PFN_PRINTING_ADDPORT pfnAddPort;
    PFN_PRINTING_ADDPORTEX pfnAddPortEx;
    PFN_PRINTING_CONFIGUREPORT pfnConfigurePort;
    PFN_PRINTING_DELETEPORT pfnDeletePort;
    PFN_PRINTING_GETPRINTERDATAFROMPORT pfnGetPrinterDataFromPort;
    PFN_PRINTING_SETPORTTIMEOUTS pfnSetPortTimeOuts;
    PFN_PRINTING_XCVOPENPORT pfnXcvOpenPort;
    PFN_PRINTING_XCVDATAPORT pfnXcvDataPort;
    PFN_PRINTING_XCVCLOSEPORT pfnXcvClosePort;
}

struct MONITOREX
{
    uint    dwMonitorSize;
    MONITOR Monitor;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct MONITOR2
{
    uint cbSize;
    PFN_PRINTING_ENUMPORTS2 pfnEnumPorts;
    PFN_PRINTING_OPENPORT2 pfnOpenPort;
    PFN_PRINTING_OPENPORTEX2 pfnOpenPortEx;
    PFN_PRINTING_STARTDOCPORT2 pfnStartDocPort;
    PFN_PRINTING_WRITEPORT2 pfnWritePort;
    PFN_PRINTING_READPORT2 pfnReadPort;
    PFN_PRINTING_ENDDOCPORT2 pfnEndDocPort;
    PFN_PRINTING_CLOSEPORT2 pfnClosePort;
    PFN_PRINTING_ADDPORT2 pfnAddPort;
    PFN_PRINTING_ADDPORTEX2 pfnAddPortEx;
    PFN_PRINTING_CONFIGUREPORT2 pfnConfigurePort;
    PFN_PRINTING_DELETEPORT2 pfnDeletePort;
    PFN_PRINTING_GETPRINTERDATAFROMPORT2 pfnGetPrinterDataFromPort;
    PFN_PRINTING_SETPORTTIMEOUTS2 pfnSetPortTimeOuts;
    PFN_PRINTING_XCVOPENPORT2 pfnXcvOpenPort;
    PFN_PRINTING_XCVDATAPORT2 pfnXcvDataPort;
    PFN_PRINTING_XCVCLOSEPORT2 pfnXcvClosePort;
    PFN_PRINTING_SHUTDOWN2 pfnShutdown;
    PFN_PRINTING_SENDRECVBIDIDATAFROMPORT2 pfnSendRecvBidiDataFromPort;
    PFN_PRINTING_NOTIFYUSEDPORTS2 pfnNotifyUsedPorts;
    PFN_PRINTING_NOTIFYUNUSEDPORTS2 pfnNotifyUnusedPorts;
    PFN_PRINTING_POWEREVENT2 pfnPowerEvent;
}

struct MONITORUI
{
    uint      dwMonitorUISize;
    ptrdiff_t pfnAddPortUI;
    ptrdiff_t pfnConfigurePortUI;
    ptrdiff_t pfnDeletePortUI;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct NOTIFICATION_CONFIG_1
{
    uint  cbSize;
    uint  fdwFlags;
    ROUTER_NOTIFY_CALLBACK pfnNotifyCallback;
    void* pContext;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct MESSAGEBOX_PARAMS
{
    uint  cbSize;
    PWSTR pTitle;
    PWSTR pMessage;
    uint  Style;
    uint  dwTimeout;
    BOOL  bWait;
}

struct SHOWUIPARAMS
{
    UI_TYPE           UIType;
    MESSAGEBOX_PARAMS MessageBoxParams;
}

// Functions

@DllImport("COMPSTUI.dll")
int CommonPropertySheetUIA(HWND hWndOwner, PFNPROPSHEETUI pfnPropSheetUI, LPARAM lParam, uint* pResult);

@DllImport("COMPSTUI.dll")
int CommonPropertySheetUIW(HWND hWndOwner, PFNPROPSHEETUI pfnPropSheetUI, LPARAM lParam, uint* pResult);

@DllImport("COMPSTUI.dll")
size_t GetCPSUIUserData(HWND hDlg);

@DllImport("COMPSTUI.dll")
BOOL SetCPSUIUserData(HWND hDlg, size_t CPSUIUserData);

@DllImport("winspool.drv")
BOOL EnumPrintersA(uint Flags, const(PSTR) Name, uint Level, 
                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* pPrinterEnum, 
                   uint cbBuf, uint* pcbNeeded, uint* pcReturned);

@DllImport("winspool.drv")
BOOL EnumPrintersW(uint Flags, const(PWSTR) Name, uint Level, 
                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* pPrinterEnum, 
                   uint cbBuf, uint* pcbNeeded, uint* pcReturned);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/getspoolfilehandle
@DllImport("winspool.drv")
HANDLE GetSpoolFileHandle(PRINTER_HANDLE hPrinter);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/commitspooldata
@DllImport("winspool.drv")
HANDLE CommitSpoolData(PRINTER_HANDLE hPrinter, HANDLE hSpoolFile, uint cbCommit);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/closespoolfilehandle
@DllImport("winspool.drv")
BOOL CloseSpoolFileHandle(PRINTER_HANDLE hPrinter, HANDLE hSpoolFile);

@DllImport("winspool.drv")
BOOL OpenPrinterA(const(PSTR) pPrinterName, PRINTER_HANDLE* phPrinter, PRINTER_DEFAULTSA* pDefault);

@DllImport("winspool.drv")
BOOL OpenPrinterW(const(PWSTR) pPrinterName, PRINTER_HANDLE* phPrinter, PRINTER_DEFAULTSW* pDefault);

@DllImport("winspool.drv")
BOOL ResetPrinterA(PRINTER_HANDLE hPrinter, PRINTER_DEFAULTSA* pDefault);

@DllImport("winspool.drv")
BOOL ResetPrinterW(PRINTER_HANDLE hPrinter, PRINTER_DEFAULTSW* pDefault);

@DllImport("winspool.drv")
BOOL SetJobA(PRINTER_HANDLE hPrinter, uint JobId, uint Level, 
             /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/ubyte* pJob, uint Command);

@DllImport("winspool.drv")
BOOL SetJobW(PRINTER_HANDLE hPrinter, uint JobId, uint Level, 
             /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/ubyte* pJob, uint Command);

@DllImport("winspool.drv")
BOOL GetJobA(PRINTER_HANDLE hPrinter, uint JobId, uint Level, 
             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* pJob, 
             uint cbBuf, uint* pcbNeeded);

@DllImport("winspool.drv")
BOOL GetJobW(PRINTER_HANDLE hPrinter, uint JobId, uint Level, 
             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* pJob, 
             uint cbBuf, uint* pcbNeeded);

@DllImport("winspool.drv")
BOOL EnumJobsA(PRINTER_HANDLE hPrinter, uint FirstJob, uint NoJobs, uint Level, 
               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* pJob, 
               uint cbBuf, uint* pcbNeeded, uint* pcReturned);

@DllImport("winspool.drv")
BOOL EnumJobsW(PRINTER_HANDLE hPrinter, uint FirstJob, uint NoJobs, uint Level, 
               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* pJob, 
               uint cbBuf, uint* pcbNeeded, uint* pcReturned);

@DllImport("winspool.drv")
PRINTER_HANDLE AddPrinterA(const(PSTR) pName, uint Level, ubyte* pPrinter);

@DllImport("winspool.drv")
PRINTER_HANDLE AddPrinterW(const(PWSTR) pName, uint Level, ubyte* pPrinter);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/deleteprinter
@DllImport("winspool.drv")
BOOL DeletePrinter(PRINTER_HANDLE hPrinter);

@DllImport("winspool.drv")
BOOL SetPrinterA(PRINTER_HANDLE hPrinter, uint Level, ubyte* pPrinter, uint Command);

@DllImport("winspool.drv")
BOOL SetPrinterW(PRINTER_HANDLE hPrinter, uint Level, ubyte* pPrinter, uint Command);

@DllImport("winspool.drv")
BOOL GetPrinterA(PRINTER_HANDLE hPrinter, uint Level, 
                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* pPrinter, 
                 uint cbBuf, uint* pcbNeeded);

@DllImport("winspool.drv")
BOOL GetPrinterW(PRINTER_HANDLE hPrinter, uint Level, 
                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* pPrinter, 
                 uint cbBuf, uint* pcbNeeded);

@DllImport("winspool.drv")
BOOL AddPrinterDriverA(const(PSTR) pName, uint Level, ubyte* pDriverInfo);

@DllImport("winspool.drv")
BOOL AddPrinterDriverW(const(PWSTR) pName, uint Level, ubyte* pDriverInfo);

@DllImport("winspool.drv")
BOOL AddPrinterDriverExA(const(PSTR) pName, uint Level, ubyte* lpbDriverInfo, uint dwFileCopyFlags);

@DllImport("winspool.drv")
BOOL AddPrinterDriverExW(const(PWSTR) pName, uint Level, ubyte* lpbDriverInfo, uint dwFileCopyFlags);

@DllImport("winspool.drv")
BOOL EnumPrinterDriversA(const(PSTR) pName, const(PSTR) pEnvironment, uint Level, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* pDriverInfo, 
                         uint cbBuf, uint* pcbNeeded, uint* pcReturned);

@DllImport("winspool.drv")
BOOL EnumPrinterDriversW(const(PWSTR) pName, const(PWSTR) pEnvironment, uint Level, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* pDriverInfo, 
                         uint cbBuf, uint* pcbNeeded, uint* pcReturned);

@DllImport("winspool.drv")
BOOL GetPrinterDriverA(PRINTER_HANDLE hPrinter, const(PSTR) pEnvironment, uint Level, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* pDriverInfo, 
                       uint cbBuf, uint* pcbNeeded);

@DllImport("winspool.drv")
BOOL GetPrinterDriverW(PRINTER_HANDLE hPrinter, const(PWSTR) pEnvironment, uint Level, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* pDriverInfo, 
                       uint cbBuf, uint* pcbNeeded);

@DllImport("winspool.drv")
BOOL GetPrinterDriverDirectoryA(const(PSTR) pName, const(PSTR) pEnvironment, uint Level, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* pDriverDirectory, 
                                uint cbBuf, uint* pcbNeeded);

@DllImport("winspool.drv")
BOOL GetPrinterDriverDirectoryW(const(PWSTR) pName, const(PWSTR) pEnvironment, uint Level, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* pDriverDirectory, 
                                uint cbBuf, uint* pcbNeeded);

@DllImport("winspool.drv")
BOOL DeletePrinterDriverA(const(PSTR) pName, const(PSTR) pEnvironment, const(PSTR) pDriverName);

@DllImport("winspool.drv")
BOOL DeletePrinterDriverW(const(PWSTR) pName, const(PWSTR) pEnvironment, const(PWSTR) pDriverName);

@DllImport("winspool.drv")
BOOL DeletePrinterDriverExA(const(PSTR) pName, const(PSTR) pEnvironment, const(PSTR) pDriverName, 
                            uint dwDeleteFlag, uint dwVersionFlag);

@DllImport("winspool.drv")
BOOL DeletePrinterDriverExW(const(PWSTR) pName, const(PWSTR) pEnvironment, const(PWSTR) pDriverName, 
                            uint dwDeleteFlag, uint dwVersionFlag);

@DllImport("winspool.drv")
BOOL AddPrintProcessorA(const(PSTR) pName, const(PSTR) pEnvironment, const(PSTR) pPathName, 
                        const(PSTR) pPrintProcessorName);

@DllImport("winspool.drv")
BOOL AddPrintProcessorW(const(PWSTR) pName, const(PWSTR) pEnvironment, const(PWSTR) pPathName, 
                        const(PWSTR) pPrintProcessorName);

@DllImport("winspool.drv")
BOOL EnumPrintProcessorsA(const(PSTR) pName, const(PSTR) pEnvironment, uint Level, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* pPrintProcessorInfo, 
                          uint cbBuf, uint* pcbNeeded, uint* pcReturned);

@DllImport("winspool.drv")
BOOL EnumPrintProcessorsW(const(PWSTR) pName, const(PWSTR) pEnvironment, uint Level, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* pPrintProcessorInfo, 
                          uint cbBuf, uint* pcbNeeded, uint* pcReturned);

@DllImport("winspool.drv")
BOOL GetPrintProcessorDirectoryA(const(PSTR) pName, const(PSTR) pEnvironment, uint Level, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* pPrintProcessorInfo, 
                                 uint cbBuf, uint* pcbNeeded);

@DllImport("winspool.drv")
BOOL GetPrintProcessorDirectoryW(const(PWSTR) pName, const(PWSTR) pEnvironment, uint Level, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* pPrintProcessorInfo, 
                                 uint cbBuf, uint* pcbNeeded);

@DllImport("winspool.drv")
BOOL EnumPrintProcessorDatatypesA(const(PSTR) pName, const(PSTR) pPrintProcessorName, uint Level, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* pDatatypes, 
                                  uint cbBuf, uint* pcbNeeded, uint* pcReturned);

@DllImport("winspool.drv")
BOOL EnumPrintProcessorDatatypesW(const(PWSTR) pName, const(PWSTR) pPrintProcessorName, uint Level, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* pDatatypes, 
                                  uint cbBuf, uint* pcbNeeded, uint* pcReturned);

@DllImport("winspool.drv")
BOOL DeletePrintProcessorA(const(PSTR) pName, const(PSTR) pEnvironment, const(PSTR) pPrintProcessorName);

@DllImport("winspool.drv")
BOOL DeletePrintProcessorW(const(PWSTR) pName, const(PWSTR) pEnvironment, const(PWSTR) pPrintProcessorName);

@DllImport("winspool.drv")
uint StartDocPrinterA(PRINTER_HANDLE hPrinter, uint Level, DOC_INFO_1A* pDocInfo);

@DllImport("winspool.drv")
uint StartDocPrinterW(PRINTER_HANDLE hPrinter, uint Level, DOC_INFO_1W* pDocInfo);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/startpageprinter
@DllImport("winspool.drv")
BOOL StartPagePrinter(PRINTER_HANDLE hPrinter);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/writeprinter
@DllImport("winspool.drv")
BOOL WritePrinter(PRINTER_HANDLE hPrinter, 
                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pBuf, 
                  uint cbBuf, uint* pcWritten);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/flushprinter
@DllImport("winspool.drv")
BOOL FlushPrinter(PRINTER_HANDLE hPrinter, 
                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pBuf, 
                  uint cbBuf, uint* pcWritten, uint cSleep);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/endpageprinter
@DllImport("winspool.drv")
BOOL EndPagePrinter(PRINTER_HANDLE hPrinter);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/abortprinter
@DllImport("winspool.drv")
BOOL AbortPrinter(PRINTER_HANDLE hPrinter);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/readprinter
@DllImport("winspool.drv")
BOOL ReadPrinter(PRINTER_HANDLE hPrinter, 
                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pBuf, 
                 uint cbBuf, uint* pNoBytesRead);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/enddocprinter
@DllImport("winspool.drv")
BOOL EndDocPrinter(PRINTER_HANDLE hPrinter);

@DllImport("winspool.drv")
BOOL AddJobA(PRINTER_HANDLE hPrinter, uint Level, 
             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* pData, 
             uint cbBuf, uint* pcbNeeded);

@DllImport("winspool.drv")
BOOL AddJobW(PRINTER_HANDLE hPrinter, uint Level, 
             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* pData, 
             uint cbBuf, uint* pcbNeeded);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/schedulejob
@DllImport("winspool.drv")
BOOL ScheduleJob(PRINTER_HANDLE hPrinter, uint JobId);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/printerproperties
@DllImport("winspool.drv")
BOOL PrinterProperties(HWND hWnd, PRINTER_HANDLE hPrinter);

@DllImport("winspool.drv")
int DocumentPropertiesA(HWND hWnd, PRINTER_HANDLE hPrinter, PSTR pDeviceName, DEVMODEA* pDevModeOutput, 
                        DEVMODEA* pDevModeInput, uint fMode);

@DllImport("winspool.drv")
int DocumentPropertiesW(HWND hWnd, PRINTER_HANDLE hPrinter, PWSTR pDeviceName, DEVMODEW* pDevModeOutput, 
                        DEVMODEW* pDevModeInput, uint fMode);

@DllImport("winspool.drv")
int AdvancedDocumentPropertiesA(HWND hWnd, PRINTER_HANDLE hPrinter, PSTR pDeviceName, DEVMODEA* pDevModeOutput, 
                                DEVMODEA* pDevModeInput);

@DllImport("winspool.drv")
int AdvancedDocumentPropertiesW(HWND hWnd, PRINTER_HANDLE hPrinter, PWSTR pDeviceName, DEVMODEW* pDevModeOutput, 
                                DEVMODEW* pDevModeInput);

@DllImport("winspool.drv")
int ExtDeviceMode(HWND hWnd, HANDLE hInst, DEVMODEA* pDevModeOutput, PSTR pDeviceName, PSTR pPort, 
                  DEVMODEA* pDevModeInput, PSTR pProfile, uint fMode);

@DllImport("winspool.drv")
uint GetPrinterDataA(PRINTER_HANDLE hPrinter, const(PSTR) pValueName, uint* pType, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* pData, 
                     uint nSize, uint* pcbNeeded);

@DllImport("winspool.drv")
uint GetPrinterDataW(PRINTER_HANDLE hPrinter, const(PWSTR) pValueName, uint* pType, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* pData, 
                     uint nSize, uint* pcbNeeded);

@DllImport("winspool.drv")
uint GetPrinterDataExA(PRINTER_HANDLE hPrinter, const(PSTR) pKeyName, const(PSTR) pValueName, uint* pType, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* pData, 
                       uint nSize, uint* pcbNeeded);

@DllImport("winspool.drv")
uint GetPrinterDataExW(PRINTER_HANDLE hPrinter, const(PWSTR) pKeyName, const(PWSTR) pValueName, uint* pType, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* pData, 
                       uint nSize, uint* pcbNeeded);

@DllImport("winspool.drv")
uint EnumPrinterDataA(PRINTER_HANDLE hPrinter, uint dwIndex, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/PSTR pValueName, 
                      uint cbValueName, uint* pcbValueName, uint* pType, ubyte* pData, uint cbData, uint* pcbData);

@DllImport("winspool.drv")
uint EnumPrinterDataW(PRINTER_HANDLE hPrinter, uint dwIndex, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/PWSTR pValueName, 
                      uint cbValueName, uint* pcbValueName, uint* pType, ubyte* pData, uint cbData, uint* pcbData);

@DllImport("winspool.drv")
uint EnumPrinterDataExA(PRINTER_HANDLE hPrinter, const(PSTR) pKeyName, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* pEnumValues, 
                        uint cbEnumValues, uint* pcbEnumValues, uint* pnEnumValues);

@DllImport("winspool.drv")
uint EnumPrinterDataExW(PRINTER_HANDLE hPrinter, const(PWSTR) pKeyName, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* pEnumValues, 
                        uint cbEnumValues, uint* pcbEnumValues, uint* pnEnumValues);

@DllImport("winspool.drv")
uint EnumPrinterKeyA(PRINTER_HANDLE hPrinter, const(PSTR) pKeyName, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/PSTR pSubkey, 
                     uint cbSubkey, uint* pcbSubkey);

@DllImport("winspool.drv")
uint EnumPrinterKeyW(PRINTER_HANDLE hPrinter, const(PWSTR) pKeyName, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/PWSTR pSubkey, 
                     uint cbSubkey, uint* pcbSubkey);

@DllImport("winspool.drv")
uint SetPrinterDataA(PRINTER_HANDLE hPrinter, const(PSTR) pValueName, uint Type, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* pData, 
                     uint cbData);

@DllImport("winspool.drv")
uint SetPrinterDataW(PRINTER_HANDLE hPrinter, const(PWSTR) pValueName, uint Type, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* pData, 
                     uint cbData);

@DllImport("winspool.drv")
uint SetPrinterDataExA(PRINTER_HANDLE hPrinter, const(PSTR) pKeyName, const(PSTR) pValueName, uint Type, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* pData, 
                       uint cbData);

@DllImport("winspool.drv")
uint SetPrinterDataExW(PRINTER_HANDLE hPrinter, const(PWSTR) pKeyName, const(PWSTR) pValueName, uint Type, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* pData, 
                       uint cbData);

@DllImport("winspool.drv")
uint DeletePrinterDataA(PRINTER_HANDLE hPrinter, const(PSTR) pValueName);

@DllImport("winspool.drv")
uint DeletePrinterDataW(PRINTER_HANDLE hPrinter, const(PWSTR) pValueName);

@DllImport("winspool.drv")
uint DeletePrinterDataExA(PRINTER_HANDLE hPrinter, const(PSTR) pKeyName, const(PSTR) pValueName);

@DllImport("winspool.drv")
uint DeletePrinterDataExW(PRINTER_HANDLE hPrinter, const(PWSTR) pKeyName, const(PWSTR) pValueName);

@DllImport("winspool.drv")
uint DeletePrinterKeyA(PRINTER_HANDLE hPrinter, const(PSTR) pKeyName);

@DllImport("winspool.drv")
uint DeletePrinterKeyW(PRINTER_HANDLE hPrinter, const(PWSTR) pKeyName);

@DllImport("winspool.drv")
uint WaitForPrinterChange(PRINTER_HANDLE hPrinter, uint Flags);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/findfirstprinterchangenotification
@DllImport("winspool.drv")
FINDPRINTERCHANGENOTIFICATION_HANDLE FindFirstPrinterChangeNotification(PRINTER_HANDLE hPrinter, uint fdwFilter, 
                                                                        uint fdwOptions, void* pPrinterNotifyOptions);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/findnextprinterchangenotification
@DllImport("winspool.drv")
BOOL FindNextPrinterChangeNotification(FINDPRINTERCHANGENOTIFICATION_HANDLE hChange, uint* pdwChange, 
                                       void* pvReserved, void** ppPrinterNotifyInfo);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/freeprinternotifyinfo
@DllImport("winspool.drv")
BOOL FreePrinterNotifyInfo(PRINTER_NOTIFY_INFO* pPrinterNotifyInfo);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/findcloseprinterchangenotification
@DllImport("winspool.drv")
BOOL FindClosePrinterChangeNotification(FINDPRINTERCHANGENOTIFICATION_HANDLE hChange);

@DllImport("winspool.drv")
uint PrinterMessageBoxA(PRINTER_HANDLE hPrinter, uint Error, HWND hWnd, PSTR pText, PSTR pCaption, uint dwType);

@DllImport("winspool.drv")
uint PrinterMessageBoxW(PRINTER_HANDLE hPrinter, uint Error, HWND hWnd, PWSTR pText, PWSTR pCaption, uint dwType);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/closeprinter
@DllImport("winspool.drv")
BOOL ClosePrinter(PRINTER_HANDLE hPrinter);

@DllImport("winspool.drv")
BOOL AddFormA(PRINTER_HANDLE hPrinter, uint Level, ubyte* pForm);

@DllImport("winspool.drv")
BOOL AddFormW(PRINTER_HANDLE hPrinter, uint Level, ubyte* pForm);

@DllImport("winspool.drv")
BOOL DeleteFormA(PRINTER_HANDLE hPrinter, const(PSTR) pFormName);

@DllImport("winspool.drv")
BOOL DeleteFormW(PRINTER_HANDLE hPrinter, const(PWSTR) pFormName);

@DllImport("winspool.drv")
BOOL GetFormA(PRINTER_HANDLE hPrinter, const(PSTR) pFormName, uint Level, 
              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* pForm, 
              uint cbBuf, uint* pcbNeeded);

@DllImport("winspool.drv")
BOOL GetFormW(PRINTER_HANDLE hPrinter, const(PWSTR) pFormName, uint Level, 
              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* pForm, 
              uint cbBuf, uint* pcbNeeded);

@DllImport("winspool.drv")
BOOL SetFormA(PRINTER_HANDLE hPrinter, const(PSTR) pFormName, uint Level, ubyte* pForm);

@DllImport("winspool.drv")
BOOL SetFormW(PRINTER_HANDLE hPrinter, const(PWSTR) pFormName, uint Level, ubyte* pForm);

@DllImport("winspool.drv")
BOOL EnumFormsA(PRINTER_HANDLE hPrinter, uint Level, 
                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* pForm, 
                uint cbBuf, uint* pcbNeeded, uint* pcReturned);

@DllImport("winspool.drv")
BOOL EnumFormsW(PRINTER_HANDLE hPrinter, uint Level, 
                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* pForm, 
                uint cbBuf, uint* pcbNeeded, uint* pcReturned);

@DllImport("winspool.drv")
BOOL EnumMonitorsA(PSTR pName, uint Level, 
                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* pMonitor, 
                   uint cbBuf, uint* pcbNeeded, uint* pcReturned);

@DllImport("winspool.drv")
BOOL EnumMonitorsW(PWSTR pName, uint Level, 
                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* pMonitor, 
                   uint cbBuf, uint* pcbNeeded, uint* pcReturned);

@DllImport("winspool.drv")
BOOL AddMonitorA(const(PSTR) pName, uint Level, ubyte* pMonitors);

@DllImport("winspool.drv")
BOOL AddMonitorW(const(PWSTR) pName, uint Level, ubyte* pMonitors);

@DllImport("winspool.drv")
BOOL DeleteMonitorA(const(PSTR) pName, const(PSTR) pEnvironment, const(PSTR) pMonitorName);

@DllImport("winspool.drv")
BOOL DeleteMonitorW(const(PWSTR) pName, const(PWSTR) pEnvironment, const(PWSTR) pMonitorName);

@DllImport("winspool.drv")
BOOL EnumPortsA(PSTR pName, uint Level, 
                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* pPort, 
                uint cbBuf, uint* pcbNeeded, uint* pcReturned);

@DllImport("winspool.drv")
BOOL EnumPortsW(PWSTR pName, uint Level, 
                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* pPort, 
                uint cbBuf, uint* pcbNeeded, uint* pcReturned);

@DllImport("winspool.drv")
BOOL AddPortA(const(PSTR) pName, HWND hWnd, const(PSTR) pMonitorName);

@DllImport("winspool.drv")
BOOL AddPortW(const(PWSTR) pName, HWND hWnd, const(PWSTR) pMonitorName);

@DllImport("winspool.drv")
BOOL ConfigurePortA(const(PSTR) pName, HWND hWnd, const(PSTR) pPortName);

@DllImport("winspool.drv")
BOOL ConfigurePortW(const(PWSTR) pName, HWND hWnd, const(PWSTR) pPortName);

@DllImport("winspool.drv")
BOOL DeletePortA(const(PSTR) pName, HWND hWnd, const(PSTR) pPortName);

@DllImport("winspool.drv")
BOOL DeletePortW(const(PWSTR) pName, HWND hWnd, const(PWSTR) pPortName);

@DllImport("winspool.drv")
BOOL XcvDataW(HANDLE hXcv, const(PWSTR) pszDataName, 
              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* pInputData, 
              uint cbInputData, 
              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* pOutputData, 
              uint cbOutputData, uint* pcbOutputNeeded, uint* pdwStatus);

@DllImport("winspool.drv")
BOOL GetDefaultPrinterA(PSTR pszBuffer, uint* pcchBuffer);

@DllImport("winspool.drv")
BOOL GetDefaultPrinterW(PWSTR pszBuffer, uint* pcchBuffer);

@DllImport("winspool.drv")
BOOL SetDefaultPrinterA(const(PSTR) pszPrinter);

@DllImport("winspool.drv")
BOOL SetDefaultPrinterW(const(PWSTR) pszPrinter);

@DllImport("winspool.drv")
BOOL SetPortA(PSTR pName, PSTR pPortName, uint dwLevel, ubyte* pPortInfo);

@DllImport("winspool.drv")
BOOL SetPortW(PWSTR pName, PWSTR pPortName, uint dwLevel, ubyte* pPortInfo);

@DllImport("winspool.drv")
BOOL AddPrinterConnectionA(const(PSTR) pName);

@DllImport("winspool.drv")
BOOL AddPrinterConnectionW(const(PWSTR) pName);

@DllImport("winspool.drv")
BOOL DeletePrinterConnectionA(PSTR pName);

@DllImport("winspool.drv")
BOOL DeletePrinterConnectionW(PWSTR pName);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/connecttoprinterdlg
@DllImport("winspool.drv")
HANDLE ConnectToPrinterDlg(HWND hwnd, uint Flags);

@DllImport("winspool.drv")
BOOL AddPrintProvidorA(PSTR pName, uint Level, ubyte* pProvidorInfo);

@DllImport("winspool.drv")
BOOL AddPrintProvidorW(PWSTR pName, uint Level, ubyte* pProvidorInfo);

@DllImport("winspool.drv")
BOOL DeletePrintProvidorA(PSTR pName, PSTR pEnvironment, PSTR pPrintProvidorName);

@DllImport("winspool.drv")
BOOL DeletePrintProvidorW(PWSTR pName, PWSTR pEnvironment, PWSTR pPrintProvidorName);

@DllImport("winspool.drv")
BOOL IsValidDevmodeA(DEVMODEA* pDevmode, size_t DevmodeSize);

@DllImport("winspool.drv")
BOOL IsValidDevmodeW(DEVMODEW* pDevmode, size_t DevmodeSize);

@DllImport("winspool.drv")
BOOL OpenPrinter2A(const(PSTR) pPrinterName, PRINTER_HANDLE* phPrinter, PRINTER_DEFAULTSA* pDefault, 
                   PRINTER_OPTIONSA* pOptions);

@DllImport("winspool.drv")
BOOL OpenPrinter2W(const(PWSTR) pPrinterName, PRINTER_HANDLE* phPrinter, PRINTER_DEFAULTSW* pDefault, 
                   PRINTER_OPTIONSW* pOptions);

@DllImport("winspool.drv")
BOOL AddPrinterConnection2A(HWND hWnd, const(PSTR) pszName, uint dwLevel, void* pConnectionInfo);

@DllImport("winspool.drv")
BOOL AddPrinterConnection2W(HWND hWnd, const(PWSTR) pszName, uint dwLevel, void* pConnectionInfo);

@DllImport("winspool.drv")
HRESULT InstallPrinterDriverFromPackageA(const(PSTR) pszServer, const(PSTR) pszInfPath, const(PSTR) pszDriverName, 
                                         const(PSTR) pszEnvironment, uint dwFlags);

@DllImport("winspool.drv")
HRESULT InstallPrinterDriverFromPackageW(const(PWSTR) pszServer, const(PWSTR) pszInfPath, 
                                         const(PWSTR) pszDriverName, const(PWSTR) pszEnvironment, uint dwFlags);

@DllImport("winspool.drv")
HRESULT UploadPrinterDriverPackageA(const(PSTR) pszServer, const(PSTR) pszInfPath, const(PSTR) pszEnvironment, 
                                    uint dwFlags, HWND hwnd, PSTR pszDestInfPath, uint* pcchDestInfPath);

@DllImport("winspool.drv")
HRESULT UploadPrinterDriverPackageW(const(PWSTR) pszServer, const(PWSTR) pszInfPath, const(PWSTR) pszEnvironment, 
                                    uint dwFlags, HWND hwnd, PWSTR pszDestInfPath, uint* pcchDestInfPath);

@DllImport("winspool.drv")
HRESULT GetCorePrinterDriversA(const(PSTR) pszServer, const(PSTR) pszEnvironment, 
                               const(PSTR) pszzCoreDriverDependencies, uint cCorePrinterDrivers, 
                               CORE_PRINTER_DRIVERA* pCorePrinterDrivers);

@DllImport("winspool.drv")
HRESULT GetCorePrinterDriversW(const(PWSTR) pszServer, const(PWSTR) pszEnvironment, 
                               const(PWSTR) pszzCoreDriverDependencies, uint cCorePrinterDrivers, 
                               CORE_PRINTER_DRIVERW* pCorePrinterDrivers);

@DllImport("winspool.drv")
HRESULT CorePrinterDriverInstalledA(const(PSTR) pszServer, const(PSTR) pszEnvironment, GUID CoreDriverGUID, 
                                    FILETIME ftDriverDate, ulong dwlDriverVersion, BOOL* pbDriverInstalled);

@DllImport("winspool.drv")
HRESULT CorePrinterDriverInstalledW(const(PWSTR) pszServer, const(PWSTR) pszEnvironment, GUID CoreDriverGUID, 
                                    FILETIME ftDriverDate, ulong dwlDriverVersion, BOOL* pbDriverInstalled);

@DllImport("winspool.drv")
HRESULT GetPrinterDriverPackagePathA(const(PSTR) pszServer, const(PSTR) pszEnvironment, const(PSTR) pszLanguage, 
                                     const(PSTR) pszPackageID, PSTR pszDriverPackageCab, uint cchDriverPackageCab, 
                                     uint* pcchRequiredSize);

@DllImport("winspool.drv")
HRESULT GetPrinterDriverPackagePathW(const(PWSTR) pszServer, const(PWSTR) pszEnvironment, const(PWSTR) pszLanguage, 
                                     const(PWSTR) pszPackageID, PWSTR pszDriverPackageCab, uint cchDriverPackageCab, 
                                     uint* pcchRequiredSize);

@DllImport("winspool.drv")
HRESULT DeletePrinterDriverPackageA(const(PSTR) pszServer, const(PSTR) pszInfPath, const(PSTR) pszEnvironment);

@DllImport("winspool.drv")
HRESULT DeletePrinterDriverPackageW(const(PWSTR) pszServer, const(PWSTR) pszInfPath, const(PWSTR) pszEnvironment);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/reportjobprocessingprogress
@DllImport("winspool.drv")
HRESULT ReportJobProcessingProgress(HANDLE printerHandle, uint jobId, EPrintXPSJobOperation jobOperation, 
                                    EPrintXPSJobProgress jobProgress);

@DllImport("winspool.drv")
BOOL GetPrinterDriver2A(HWND hWnd, PRINTER_HANDLE hPrinter, PSTR pEnvironment, uint Level, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* pDriverInfo, 
                        uint cbBuf, uint* pcbNeeded);

@DllImport("winspool.drv")
BOOL GetPrinterDriver2W(HWND hWnd, PRINTER_HANDLE hPrinter, PWSTR pEnvironment, uint Level, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* pDriverInfo, 
                        uint cbBuf, uint* pcbNeeded);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/printdocs/getprintexecutiondata
@DllImport("winspool.drv")
BOOL GetPrintExecutionData(PRINT_EXECUTION_DATA* pData);

@DllImport("winspool.drv")
uint GetJobNamedPropertyValue(PRINTER_HANDLE hPrinter, uint JobId, const(PWSTR) pszName, 
                              PrintPropertyValue* pValue);

@DllImport("winspool.drv")
void FreePrintPropertyValue(PrintPropertyValue* pValue);

@DllImport("winspool.drv")
void FreePrintNamedPropertyArray(uint cProperties, PrintNamedProperty** ppProperties);

@DllImport("winspool.drv")
uint SetJobNamedProperty(PRINTER_HANDLE hPrinter, uint JobId, const(PrintNamedProperty)* pProperty);

@DllImport("winspool.drv")
uint DeleteJobNamedProperty(PRINTER_HANDLE hPrinter, uint JobId, const(PWSTR) pszName);

@DllImport("winspool.drv")
uint EnumJobNamedProperties(PRINTER_HANDLE hPrinter, uint JobId, uint* pcProperties, 
                            PrintNamedProperty** ppProperties);

@DllImport("winspool.drv")
HRESULT GetPrintOutputInfo(HWND hWnd, const(PWSTR) pszPrinter, HANDLE* phFile, PWSTR* ppszOutputFile);

@DllImport("winspool.drv")
BOOL DevQueryPrintEx(DEVQUERYPRINT_INFO* pDQPInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("winspool.drv")
HRESULT RegisterForPrintAsyncNotifications(const(PWSTR) pszName, GUID* pNotificationType, 
                                           PrintAsyncNotifyUserFilter eUserFilter, 
                                           PrintAsyncNotifyConversationStyle eConversationStyle, 
                                           IPrintAsyncNotifyCallback pCallback, HANDLE* phNotify);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("winspool.drv")
HRESULT UnRegisterForPrintAsyncNotifications(HANDLE param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("winspool.drv")
HRESULT CreatePrintAsyncNotifyChannel(const(PWSTR) pszName, GUID* pNotificationType, 
                                      PrintAsyncNotifyUserFilter eUserFilter, 
                                      PrintAsyncNotifyConversationStyle eConversationStyle, 
                                      IPrintAsyncNotifyCallback pCallback, 
                                      IPrintAsyncNotifyChannel* ppIAsynchNotification);

@DllImport("SPOOLSS.dll")
HRESULT RouterUnregisterForPrintAsyncNotifications(HANDLE hNotify);

@DllImport("SPOOLSS.dll")
HRESULT RouterCreatePrintAsyncNotificationChannel(const(PWSTR) pName, GUID* pNotificationType, 
                                                  PrintAsyncNotifyUserFilter eNotifyFilter, 
                                                  PrintAsyncNotifyConversationStyle eConversationStyle, 
                                                  IPrintAsyncNotifyCallback pCallback, 
                                                  IPrintAsyncNotifyChannel* ppIAsynchNotification);

@DllImport("SPOOLSS.dll")
HRESULT RouterGetPrintClassObject(const(PWSTR) pPrinter, const(GUID)* riid, void** ppv);

@DllImport("GDI32.dll")
HANDLE GdiGetSpoolFileHandle(PWSTR pwszPrinterName, DEVMODEW* pDevmode, PWSTR pwszDocName);

@DllImport("GDI32.dll")
BOOL GdiDeleteSpoolFileHandle(HANDLE SpoolFileHandle);

@DllImport("GDI32.dll")
uint GdiGetPageCount(HANDLE SpoolFileHandle);

@DllImport("GDI32.dll")
HDC GdiGetDC(HANDLE SpoolFileHandle);

@DllImport("GDI32.dll")
HANDLE GdiGetPageHandle(HANDLE SpoolFileHandle, uint Page, uint* pdwPageType);

@DllImport("GDI32.dll")
BOOL GdiStartDocEMF(HANDLE SpoolFileHandle, DOCINFOW* pDocInfo);

@DllImport("GDI32.dll")
BOOL GdiStartPageEMF(HANDLE SpoolFileHandle);

@DllImport("GDI32.dll")
BOOL GdiPlayPageEMF(HANDLE SpoolFileHandle, HANDLE hemf, RECT* prectDocument, RECT* prectBorder, RECT* prectClip);

@DllImport("GDI32.dll")
BOOL GdiEndPageEMF(HANDLE SpoolFileHandle, uint dwOptimization);

@DllImport("GDI32.dll")
BOOL GdiEndDocEMF(HANDLE SpoolFileHandle);

@DllImport("GDI32.dll")
BOOL GdiGetDevmodeForPage(HANDLE SpoolFileHandle, uint dwPageNumber, DEVMODEW** pCurrDM, DEVMODEW** pLastDM);

@DllImport("GDI32.dll")
BOOL GdiResetDCEMF(HANDLE SpoolFileHandle, DEVMODEW* pCurrDM);

@DllImport("SPOOLSS.dll")
BOOL GetJobAttributes(PWSTR pPrinterName, DEVMODEW* pDevmode, ATTRIBUTE_INFO_3* pAttributeInfo);

@DllImport("SPOOLSS.dll")
BOOL GetJobAttributesEx(PWSTR pPrinterName, DEVMODEW* pDevmode, uint dwLevel, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* pAttributeInfo, 
                        uint nSize, uint dwFlags);

@DllImport("winspool.drv")
HANDLE CreatePrinterIC(PRINTER_HANDLE hPrinter, DEVMODEW* pDevMode);

@DllImport("winspool.drv")
BOOL PlayGdiScriptOnPrinterIC(HANDLE hPrinterIC, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ubyte* pIn, 
                              uint cIn, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* pOut, 
                              uint cOut, uint ul);

@DllImport("winspool.drv")
BOOL DeletePrinterIC(HANDLE hPrinterIC);

@DllImport("winspool.drv")
BOOL DevQueryPrint(PRINTER_HANDLE hPrinter, DEVMODEA* pDevMode, uint* pResID);

@DllImport("SPOOLSS.dll")
HANDLE RevertToPrinterSelf();

@DllImport("SPOOLSS.dll")
BOOL ImpersonatePrinterClient(HANDLE hToken);

@DllImport("SPOOLSS.dll")
BOOL ReplyPrinterChangeNotification(PRINTER_HANDLE hPrinter, uint fdwChangeFlags, uint* pdwResult, 
                                    void* pPrinterNotifyInfo);

@DllImport("SPOOLSS.dll")
BOOL ReplyPrinterChangeNotificationEx(HANDLE hNotify, uint dwColor, uint fdwFlags, uint* pdwResult, 
                                      void* pPrinterNotifyInfo);

@DllImport("SPOOLSS.dll")
BOOL PartialReplyPrinterChangeNotification(PRINTER_HANDLE hPrinter, PRINTER_NOTIFY_INFO_DATA* pDataSrc);

@DllImport("SPOOLSS.dll")
PRINTER_NOTIFY_INFO* RouterAllocPrinterNotifyInfo(uint cPrinterNotifyInfoData);

@DllImport("SPOOLSS.dll")
BOOL RouterFreePrinterNotifyInfo(PRINTER_NOTIFY_INFO* pInfo);

@DllImport("SPOOLSS.dll")
BIDI_RESPONSE_CONTAINER* RouterAllocBidiResponseContainer(uint Count);

@DllImport("SPOOLSS.dll")
void* RouterAllocBidiMem(size_t NumBytes);

@DllImport("winspool.drv")
uint RouterFreeBidiResponseContainer(BIDI_RESPONSE_CONTAINER* pData);

@DllImport("SPOOLSS.dll")
void RouterFreeBidiMem(void* pMemPointer);

@DllImport("SPOOLSS.dll")
BOOL AppendPrinterNotifyInfoData(PRINTER_NOTIFY_INFO* pInfoDest, PRINTER_NOTIFY_INFO_DATA* pDataSrc, uint fdwFlags);

@DllImport("SPOOLSS.dll")
uint CallRouterFindFirstPrinterChangeNotification(HANDLE hPrinterRPC, uint fdwFilterFlags, uint fdwOptions, 
                                                  HANDLE hNotify, PRINTER_NOTIFY_OPTIONS* pPrinterNotifyOptions);

@DllImport("SPOOLSS.dll")
BOOL ProvidorFindFirstPrinterChangeNotification(PRINTER_HANDLE hPrinter, uint fdwFlags, uint fdwOptions, 
                                                HANDLE hNotify, void* pPrinterNotifyOptions, void* pvReserved1);

@DllImport("SPOOLSS.dll")
BOOL ProvidorFindClosePrinterChangeNotification(PRINTER_HANDLE hPrinter);

@DllImport("SPOOLSS.dll")
BOOL SpoolerFindFirstPrinterChangeNotification(PRINTER_HANDLE hPrinter, uint fdwFilterFlags, uint fdwOptions, 
                                               void* pPrinterNotifyOptions, void* pvReserved, 
                                               void* pNotificationConfig, HANDLE* phNotify, HANDLE* phEvent);

@DllImport("SPOOLSS.dll")
BOOL SpoolerFindNextPrinterChangeNotification(PRINTER_HANDLE hPrinter, uint* pfdwChange, 
                                              void* pPrinterNotifyOptions, void** ppPrinterNotifyInfo);

@DllImport("SPOOLSS.dll")
BOOL SpoolerRefreshPrinterChangeNotification(PRINTER_HANDLE hPrinter, uint dwColor, 
                                             PRINTER_NOTIFY_OPTIONS* pOptions, PRINTER_NOTIFY_INFO** ppInfo);

@DllImport("SPOOLSS.dll")
void SpoolerFreePrinterNotifyInfo(PRINTER_NOTIFY_INFO* pInfo);

@DllImport("SPOOLSS.dll")
BOOL SpoolerFindClosePrinterChangeNotification(PRINTER_HANDLE hPrinter);

@DllImport("mscms.dll")
BOOL SpoolerCopyFileEvent(PWSTR pszPrinterName, PWSTR pszKey, uint dwCopyFileEvent);

@DllImport("mscms.dll")
uint GenerateCopyFilePaths(const(PWSTR) pszPrinterName, const(PWSTR) pszDirectory, ubyte* pSplClientInfo, 
                           uint dwLevel, PWSTR pszSourceDir, uint* pcchSourceDirSize, PWSTR pszTargetDir, 
                           uint* pcchTargetDirSize, uint dwFlags);

@DllImport("SPOOLSS.dll")
BOOL SplPromptUIInUsersSession(PRINTER_HANDLE hPrinter, uint JobId, SHOWUIPARAMS* pUIParams, uint* pResponse);

@DllImport("SPOOLSS.dll")
uint SplIsSessionZero(PRINTER_HANDLE hPrinter, uint JobId, BOOL* pIsSessionZero);

@DllImport("SPOOLSS.dll")
HRESULT AddPrintDeviceObject(PRINTER_HANDLE hPrinter, HANDLE* phDeviceObject);

@DllImport("SPOOLSS.dll")
HRESULT UpdatePrintDeviceObject(PRINTER_HANDLE hPrinter, HANDLE hDeviceObject);

@DllImport("SPOOLSS.dll")
HRESULT RemovePrintDeviceObject(HANDLE hDeviceObject);


// Interfaces

@GUID("b9162a23-45f9-47cc-80f5-fe0fe9b9e1a2")
struct BidiRequest;

@GUID("fc5b8a24-db05-4a01-8388-22edf6c2bbba")
struct BidiRequestContainer;

@GUID("2a614240-a4c5-4c33-bd87-1bc709331639")
struct BidiSpl;

@GUID("eb54c230-798c-4c9e-b461-29fad04039b1")
struct PrinterQueue;

@GUID("eb54c231-798c-4c9e-b461-29fad04039b1")
struct PrinterQueueView;

@GUID("43b2f83d-10f2-48ab-831b-55fdbdbd34a4")
struct PrintSchemaAsyncOperation;

@GUID("331b60da-9e90-4dd0-9c84-eac4e659b61f")
struct PrinterExtensionManager;

@GUID("8f348bd7-4b47-4755-8a9d-0f422df3dc89")
interface IBidiRequest : IUnknown
{
    HRESULT SetSchema(const(PWSTR) pszSchema);
    HRESULT SetInputData(const(uint) dwType, const(ubyte)* pData, const(uint) uSize);
    HRESULT GetResult(HRESULT* phr);
    HRESULT GetOutputData(const(uint) dwIndex, PWSTR* ppszSchema, uint* pdwType, ubyte** ppData, uint* uSize);
    HRESULT GetEnumCount(uint* pdwTotal);
}

@GUID("d752f6c0-94a8-4275-a77d-8f1d1a1121ae")
interface IBidiRequestContainer : IUnknown
{
    HRESULT AddRequest(IBidiRequest pRequest);
    HRESULT GetEnumObject(IEnumUnknown* ppenum);
    HRESULT GetRequestCount(uint* puCount);
}

@GUID("d580dc0e-de39-4649-baa8-bf0b85a03a97")
interface IBidiSpl : IUnknown
{
    HRESULT BindDevice(const(PWSTR) pszDeviceName, const(uint) dwAccess);
    HRESULT UnbindDevice();
    HRESULT SendRecv(const(PWSTR) pszAction, IBidiRequest pRequest);
    HRESULT MultiSendRecv(const(PWSTR) pszAction, IBidiRequestContainer pRequestContainer);
}

@GUID("0e8f51b8-8273-4906-8e7b-be453ffd2e2b")
interface IBidiSpl2 : IUnknown
{
    HRESULT BindDevice(const(PWSTR) pszDeviceName, const(uint) dwAccess);
    HRESULT UnbindDevice();
    HRESULT SendRecvXMLString(BSTR bstrRequest, BSTR* pbstrResponse);
    HRESULT SendRecvXMLStream(IStream pSRequest, IStream* ppSResponse);
}

@GUID("2bce4ece-d30e-445a-9423-6829be945ad8")
interface IImgErrorInfo : IErrorInfo
{
    HRESULT GetDeveloperDescription(BSTR* pbstrDevDescription);
    HRESULT GetUserErrorId(GUID* pErrorId);
    HRESULT GetUserParameterCount(uint* pcUserParams);
    HRESULT GetUserParameter(uint cParam, BSTR* pbstrParam);
    HRESULT GetUserFallback(BSTR* pbstrFallback);
    HRESULT GetExceptionId(uint* pExceptionId);
    HRESULT DetachErrorInfo(ImgErrorInfo* pErrorInfo);
}

@GUID("1c55a64c-07cd-4fb5-90f7-b753d91f0c9e")
interface IImgCreateErrorInfo : ICreateErrorInfo
{
    HRESULT AttachToErrorInfo(ImgErrorInfo* pErrorInfo);
}

@GUID("4d47a67c-66cc-4430-850e-daf466fe5bc4")
interface IPrintReadStream : IUnknown
{
    HRESULT Seek(long dlibMove, uint dwOrigin, ulong* plibNewPosition);
    HRESULT ReadBytes(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* pvBuffer, 
                      uint cbRequested, uint* pcbRead, BOOL* pbEndOfFile);
}

@GUID("65bb7f1b-371e-4571-8ac7-912f510c1a38")
interface IPrintWriteStream : IUnknown
{
    HRESULT WriteBytes(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pvBuffer, 
                       uint cbBuffer, uint* pcbWritten);
    void    Close();
}

@GUID("07d11ff8-1753-4873-b749-6cdaf068e4c3")
interface IPrintWriteStreamFlush : IUnknown
{
    HRESULT FlushData();
}

@GUID("4daf1e69-81fd-462d-940f-8cd3ddf56fca")
interface IInterFilterCommunicator : IUnknown
{
    HRESULT RequestReader(void** ppIReader);
    HRESULT RequestWriter(void** ppIWriter);
}

@GUID("aa3e4910-5889-4681-91ef-823ad4ed4e44")
interface IPrintPipelineManagerControl : IUnknown
{
    HRESULT RequestShutdown(HRESULT hrReason, IImgErrorInfo pReason);
    HRESULT FilterFinished();
}

@GUID("8b8c99dc-7892-4a95-8a04-57422e9fbb47")
interface IPrintPipelinePropertyBag : IUnknown
{
    HRESULT AddProperty(const(PWSTR) pszName, const(VARIANT)* pVar);
    HRESULT GetProperty(const(PWSTR) pszName, VARIANT* pVar);
    BOOL    DeleteProperty(const(PWSTR) pszName);
}

@GUID("edc12c7c-ed40-4ea5-96a6-5e4397497a61")
interface IPrintPipelineProgressReport : IUnknown
{
    HRESULT ReportProgress(EXpsJobConsumption update);
}

@GUID("9af593dd-9b02-48a8-9bad-69ace423f88b")
interface IPrintClassObjectFactory : IUnknown
{
    HRESULT GetPrintClassObject(const(PWSTR) pszPrinterName, const(GUID)* riid, void** ppNewObject);
}

@GUID("cdb62fc0-8bed-434e-86fb-a2cae55f19ea")
interface IPrintPipelineFilter : IUnknown
{
    HRESULT InitializeFilter(IInterFilterCommunicator pINegotiation, IPrintPipelinePropertyBag pIPropertyBag, 
                             IPrintPipelineManagerControl pIPipelineControl);
    HRESULT ShutdownOperation();
    HRESULT StartOperation();
}

@GUID("b8cf8530-5562-47c4-ab67-b1f69ecf961e")
interface IXpsDocumentProvider : IUnknown
{
    HRESULT GetXpsPart(IUnknown* ppIXpsPart);
}

@GUID("4368d8a2-4181-4a9f-b295-3d9a38bb9ba0")
interface IXpsDocumentConsumer : IUnknown
{
    HRESULT SendXpsUnknown(IUnknown pUnknown);
    HRESULT SendXpsDocument(IXpsDocument pIXpsDocument);
    HRESULT SendFixedDocumentSequence(IFixedDocumentSequence pIFixedDocumentSequence);
    HRESULT SendFixedDocument(IFixedDocument pIFixedDocument);
    HRESULT SendFixedPage(IFixedPage pIFixedPage);
    HRESULT CloseSender();
    HRESULT GetNewEmptyPart(const(PWSTR) uri, const(GUID)* riid, void** ppNewObject, 
                            IPrintWriteStream* ppWriteStream);
}

@GUID("e8d907db-62a9-4a95-abe7-e01763dd30f8")
interface IXpsDocument : IUnknown
{
    HRESULT GetThumbnail(IPartThumbnail* ppThumbnail);
    HRESULT SetThumbnail(IPartThumbnail pThumbnail);
}

@GUID("8028d181-2c32-4249-8493-1bfb22045574")
interface IFixedDocumentSequence : IUnknown
{
    HRESULT GetUri(BSTR* uri);
    HRESULT GetPrintTicket(IPartPrintTicket* ppPrintTicket);
    HRESULT SetPrintTicket(IPartPrintTicket pPrintTicket);
}

@GUID("f222ca9f-9968-4db9-81bd-abaebf15f93f")
interface IFixedDocument : IUnknown
{
    HRESULT GetUri(BSTR* uri);
    HRESULT GetPrintTicket(IPartPrintTicket* ppPrintTicket);
    HRESULT SetPrintTicket(IPartPrintTicket pPrintTicket);
}

@GUID("36d51e28-369e-43ba-a666-9540c62c3f58")
interface IPartBase : IUnknown
{
    HRESULT GetUri(BSTR* uri);
    HRESULT GetStream(IPrintReadStream* ppStream);
    HRESULT GetPartCompression(EXpsCompressionOptions* pCompression);
    HRESULT SetPartCompression(EXpsCompressionOptions compression);
}

@GUID("3d9f6448-7e95-4cb5-94fb-0180c2883a57")
interface IFixedPage : IPartBase
{
    HRESULT GetPrintTicket(IPartPrintTicket* ppPrintTicket);
    HRESULT GetPagePart(const(PWSTR) uri, IUnknown* ppUnk);
    HRESULT GetWriteStream(IPrintWriteStream* ppWriteStream);
    HRESULT SetPrintTicket(IPartPrintTicket ppPrintTicket);
    HRESULT SetPagePart(IUnknown pUnk);
    HRESULT DeleteResource(const(PWSTR) uri);
    HRESULT GetXpsPartIterator(IXpsPartIterator* pXpsPartIt);
}

@GUID("725f2e3c-401a-4705-9de0-fe6f1353b87f")
interface IPartImage : IPartBase
{
    HRESULT GetImageProperties(BSTR* pContentType);
    HRESULT SetImageContent(const(PWSTR) pContentType);
}

@GUID("e07fe0ab-1124-43d0-a865-e8ffb6a3ea82")
interface IPartFont : IPartBase
{
    HRESULT GetFontProperties(BSTR* pContentType, EXpsFontOptions* pFontOptions);
    HRESULT SetFontContent(const(PWSTR) pContentType);
    HRESULT SetFontOptions(EXpsFontOptions options);
}

@GUID("511e025f-d6cb-43be-bf65-63fe88515a39")
interface IPartFont2 : IPartFont
{
    HRESULT GetFontRestriction(EXpsFontRestriction* pRestriction);
}

@GUID("027ed1c9-ba39-4cc5-aa55-7ec3a0de171a")
interface IPartThumbnail : IPartBase
{
    HRESULT GetThumbnailProperties(BSTR* pContentType);
    HRESULT SetThumbnailContent(const(PWSTR) pContentType);
}

@GUID("4a0f50f6-f9a2-41f0-99e7-5ae955be8e9e")
interface IPartPrintTicket : IPartBase
{
}

@GUID("63cca95b-7d18-4762-b15e-98658693d24a")
interface IPartColorProfile : IPartBase
{
}

@GUID("16cfce6d-e744-4fb3-b474-f1d54f024a01")
interface IPartResourceDictionary : IPartBase
{
}

@GUID("0021d3cd-af6f-42ab-9999-14bc82a62d2e")
interface IXpsPartIterator : IUnknown
{
    void    Reset();
    HRESULT Current(BSTR* pUri, IUnknown* ppXpsPart);
    BOOL    IsDone();
    void    Next();
}

@GUID("acb971e3-df8d-4fc2-bee6-0609d15f3cf9")
interface IPrintReadStreamFactory : IUnknown
{
    HRESULT GetStream(IPrintReadStream* ppStream);
}

@GUID("cc350c00-095b-42a5-bf0f-c8780edadb3c")
interface IPartDiscardControl : IUnknown
{
    HRESULT GetDiscardProperties(BSTR* uriSentinelPage, BSTR* uriPartToDiscard);
}

@GUID("a89ec53e-3905-49c6-9c1a-c0a88117fdb6")
interface IPrintCoreHelper : IUnknown
{
    HRESULT GetOption(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(DEVMODEA)* pDevmode, 
                      uint cbSize, const(PSTR) pszFeatureRequested, const(PSTR)* ppszOption);
    HRESULT SetOptions(DEVMODEA* pDevmode, uint cbSize, BOOL bResolveConflicts, 
                       const(PRINT_FEATURE_OPTION)* pFOPairs, uint cPairs, uint* pcPairsWritten, uint* pdwResult);
    HRESULT EnumConstrainedOptions(const(DEVMODEA)* pDevmode, uint cbSize, const(PSTR) pszFeatureKeyword, 
                                   const(PSTR)*** pConstrainedOptionList, uint* pdwNumOptions);
    HRESULT WhyConstrained(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(DEVMODEA)* pDevmode, 
                           uint cbSize, const(PSTR) pszFeatureKeyword, const(PSTR) pszOptionKeyword, 
                           const(PRINT_FEATURE_OPTION)** ppFOConstraints, uint* pdwNumOptions);
    HRESULT EnumFeatures(const(PSTR)*** pFeatureList, uint* pdwNumFeatures);
    HRESULT EnumOptions(const(PSTR) pszFeatureKeyword, const(PSTR)*** pOptionList, uint* pdwNumOptions);
    HRESULT GetFontSubstitution(const(PWSTR) pszTrueTypeFontName, const(PWSTR)* ppszDevFontName);
    HRESULT SetFontSubstitution(const(PWSTR) pszTrueTypeFontName, const(PWSTR) pszDevFontName);
    HRESULT CreateInstanceOfMSXMLObject(const(GUID)* rclsid, IUnknown pUnkOuter, uint dwClsContext, 
                                        const(GUID)* riid, void** ppv);
}

@GUID("7e8e51d6-e5ee-4426-817b-958b9444eb79")
interface IPrintCoreHelperUni : IPrintCoreHelper
{
    HRESULT CreateGDLSnapshot(DEVMODEA* pDevmode, uint cbSize, uint dwFlags, IStream* ppSnapshotStream);
    HRESULT CreateDefaultGDLSnapshot(uint dwFlags, IStream* ppSnapshotStream);
}

@GUID("6c8afdfc-ead0-4d2d-8071-9bf0175a6c3a")
interface IPrintCoreHelperUni2 : IPrintCoreHelperUni
{
    HRESULT GetNamedCommand(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/DEVMODEA* pDevmode, 
                            uint cbSize, const(PWSTR) pszCommandName, ubyte** ppCommandBytes, uint* pcbCommandSize);
}

@GUID("c2c14f6f-95d3-4d63-96cf-6bd9e6c907c2")
interface IPrintCoreHelperPS : IPrintCoreHelper
{
    HRESULT GetGlobalAttribute(const(PSTR) pszAttribute, uint* pdwDataType, ubyte** ppbData, uint* pcbSize);
    HRESULT GetFeatureAttribute(const(PSTR) pszFeatureKeyword, const(PSTR) pszAttribute, uint* pdwDataType, 
                                ubyte** ppbData, uint* pcbSize);
    HRESULT GetOptionAttribute(const(PSTR) pszFeatureKeyword, const(PSTR) pszOptionKeyword, 
                               const(PSTR) pszAttribute, uint* pdwDataType, ubyte** ppbData, uint* pcbSize);
}

@GUID("7f42285e-91d5-11d1-8820-00c04fb961ec")
interface IPrintOemCommon : IUnknown
{
    HRESULT GetInfo(uint dwMode, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pBuffer, 
                    uint cbSize, uint* pcbNeeded);
    HRESULT DevMode(uint dwMode, OEMDMPARAM* pOemDMParam);
}

@GUID("c6a7a9d0-774c-11d1-947f-00a0c90640b8")
interface IPrintOemUI : IPrintOemCommon
{
    HRESULT PublishDriverInterface(IUnknown pIUnknown);
    HRESULT CommonUIProp(uint dwMode, OEMCUIPPARAM* pOemCUIPParam);
    HRESULT DocumentPropertySheets(PROPSHEETUI_INFO* pPSUIInfo, LPARAM lParam);
    HRESULT DevicePropertySheets(PROPSHEETUI_INFO* pPSUIInfo, LPARAM lParam);
    HRESULT DevQueryPrintEx(OEMUIOBJ* poemuiobj, DEVQUERYPRINT_INFO* pDQPInfo, DEVMODEA* pPublicDM, void* pOEMDM);
    HRESULT DeviceCapabilitiesA(OEMUIOBJ* poemuiobj, HANDLE hPrinter, PWSTR pDeviceName, ushort wCapability, 
                                void* pOutput, DEVMODEA* pPublicDM, void* pOEMDM, uint dwOld, uint* dwResult);
    HRESULT UpgradePrinter(uint dwLevel, ubyte* pDriverUpgradeInfo);
    HRESULT PrinterEvent(PWSTR pPrinterName, int iDriverEvent, uint dwFlags, LPARAM lParam);
    HRESULT DriverEvent(uint dwDriverEvent, uint dwLevel, ubyte* pDriverInfo, LPARAM lParam);
    HRESULT QueryColorProfile(PRINTER_HANDLE hPrinter, OEMUIOBJ* poemuiobj, DEVMODEA* pPublicDM, void* pOEMDM, 
                              uint ulQueryMode, void* pvProfileData, uint* pcbProfileData, uint* pflProfileData);
    HRESULT FontInstallerDlgProc(HWND hWnd, uint usMsg, WPARAM wParam, LPARAM lParam);
    HRESULT UpdateExternalFonts(PRINTER_HANDLE hPrinter, HANDLE hHeap, PWSTR pwstrCartridges);
}

@GUID("292515f9-b54b-489b-9275-bab56821395e")
interface IPrintOemUI2 : IPrintOemUI
{
    HRESULT QueryJobAttributes(PRINTER_HANDLE hPrinter, DEVMODEA* pDevmode, uint dwLevel, ubyte* lpAttributeInfo);
    HRESULT HideStandardUI(uint dwMode);
    HRESULT DocumentEvent(PRINTER_HANDLE hPrinter, HDC hdc, int iEsc, uint cbIn, void* pvIn, uint cbOut, 
                          void* pvOut, int* piResult);
}

@GUID("7349d725-e2c1-4dca-afb5-c13e91bc9306")
interface IPrintOemUIMXDC : IUnknown
{
    HRESULT AdjustImageableArea(PRINTER_HANDLE hPrinter, uint cbDevMode, const(DEVMODEA)* pDevMode, uint cbOEMDM, 
                                const(void)* pOEMDM, RECTL* prclImageableArea);
    HRESULT AdjustImageCompression(PRINTER_HANDLE hPrinter, uint cbDevMode, const(DEVMODEA)* pDevMode, 
                                   uint cbOEMDM, const(void)* pOEMDM, int* pCompressionMode);
    HRESULT AdjustDPI(PRINTER_HANDLE hPrinter, uint cbDevMode, const(DEVMODEA)* pDevMode, uint cbOEMDM, 
                      const(void)* pOEMDM, int* pDPI);
}

@GUID("92b05d50-78bc-11d1-9480-00a0c90640b8")
interface IPrintOemDriverUI : IUnknown
{
    HRESULT DrvGetDriverSetting(void* pci, const(PSTR) Feature, void* pOutput, uint cbSize, uint* pcbNeeded, 
                                uint* pdwOptionsReturned);
    HRESULT DrvUpgradeRegistrySetting(HANDLE hPrinter, const(PSTR) pFeature, const(PSTR) pOption);
    HRESULT DrvUpdateUISetting(void* pci, void* pOptItem, uint dwPreviousSelection, uint dwMode);
}

@GUID("085ccfca-3adf-4c9e-b491-d851a6edc997")
interface IPrintCoreUI2 : IPrintOemDriverUI
{
    HRESULT GetOptions(OEMUIOBJ* poemuiobj, 
                       /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwFlags, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/byte* pmszFeaturesRequested, 
                       uint cbIn, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/PSTR pmszFeatureOptionBuf, 
                       uint cbSize, uint* pcbNeeded);
    HRESULT SetOptions(OEMUIOBJ* poemuiobj, uint dwFlags, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/byte* pmszFeatureOptionBuf, 
                       uint cbIn, uint* pdwResult);
    HRESULT EnumConstrainedOptions(OEMUIOBJ* poemuiobj, 
                                   /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwFlags, 
                                   const(PSTR) pszFeatureKeyword, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/PSTR pmszConstrainedOptionList, 
                                   uint cbSize, uint* pcbNeeded);
    HRESULT WhyConstrained(OEMUIOBJ* poemuiobj, 
                           /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwFlags, 
                           const(PSTR) pszFeatureKeyword, const(PSTR) pszOptionKeyword, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/PSTR pmszReasonList, 
                           uint cbSize, uint* pcbNeeded);
    HRESULT GetGlobalAttribute(OEMUIOBJ* poemuiobj, 
                               /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwFlags, 
                               const(PSTR) pszAttribute, uint* pdwDataType, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* pbData, 
                               uint cbSize, uint* pcbNeeded);
    HRESULT GetFeatureAttribute(OEMUIOBJ* poemuiobj, 
                                /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwFlags, 
                                const(PSTR) pszFeatureKeyword, const(PSTR) pszAttribute, uint* pdwDataType, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/ubyte* pbData, 
                                uint cbSize, uint* pcbNeeded);
    HRESULT GetOptionAttribute(OEMUIOBJ* poemuiobj, 
                               /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwFlags, 
                               const(PSTR) pszFeatureKeyword, const(PSTR) pszOptionKeyword, const(PSTR) pszAttribute, 
                               uint* pdwDataType, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(7)))])*/ubyte* pbData, 
                               uint cbSize, uint* pcbNeeded);
    HRESULT EnumFeatures(OEMUIOBJ* poemuiobj, 
                         /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwFlags, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/PSTR pmszFeatureList, 
                         uint cbSize, uint* pcbNeeded);
    HRESULT EnumOptions(OEMUIOBJ* poemuiobj, 
                        /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwFlags, 
                        const(PSTR) pszFeatureKeyword, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/PSTR pmszOptionList, 
                        uint cbSize, uint* pcbNeeded);
    HRESULT QuerySimulationSupport(HANDLE hPrinter, uint dwLevel, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* pCaps, 
                                   uint cbSize, uint* pcbNeeded);
}

@GUID("bb5116db-0a23-4c3a-a6b6-89e5558dfb5d")
interface IPrintTicketProvider : IUnknown
{
    HRESULT GetSupportedVersions(PRINTER_HANDLE hPrinter, int** ppVersions, int* cVersions);
    HRESULT BindPrinter(PRINTER_HANDLE hPrinter, int version_, SHIMOPTS* pOptions, uint* pDevModeFlags, 
                        int* cNamespaces, BSTR** ppNamespaces);
    HRESULT QueryDeviceNamespace(BSTR* pDefaultNamespace);
    HRESULT ConvertPrintTicketToDevMode(IXMLDOMDocument2 pPrintTicket, uint cbDevmodeIn, DEVMODEA* pDevmodeIn, 
                                        uint* pcbDevmodeOut, DEVMODEA** ppDevmodeOut);
    HRESULT ConvertDevModeToPrintTicket(uint cbDevmode, DEVMODEA* pDevmode, IXMLDOMDocument2 pPrintTicket);
    HRESULT GetPrintCapabilities(IXMLDOMDocument2 pPrintTicket, IXMLDOMDocument2* ppCapabilities);
    HRESULT ValidatePrintTicket(IXMLDOMDocument2 pBaseTicket);
}

@GUID("b8a70ab2-3dfc-4fec-a074-511b13c651cb")
interface IPrintTicketProvider2 : IPrintTicketProvider
{
    HRESULT GetPrintDeviceCapabilities(IXMLDOMDocument2 pPrintTicket, IXMLDOMDocument2* ppDeviceCapabilities);
    HRESULT GetPrintDeviceResources(const(PWSTR) pszLocaleName, IXMLDOMDocument2 pPrintTicket, 
                                    IXMLDOMDocument2* ppDeviceResources);
}

@GUID("724c1646-e64b-4bbf-8eb4-d45e4fd580da")
interface IPrintSchemaElement : IDispatch
{
    HRESULT get_XmlNode(IUnknown* ppXmlNode);
    HRESULT get_Name(BSTR* pbstrName);
    HRESULT get_NamespaceUri(BSTR* pbstrNamespaceUri);
}

@GUID("af45af49-d6aa-407d-bf87-3912236e9d94")
interface IPrintSchemaDisplayableElement : IPrintSchemaElement
{
    HRESULT get_DisplayName(BSTR* pbstrDisplayName);
}

@GUID("66bb2f51-5844-4997-8d70-4b7cc221cf92")
interface IPrintSchemaOption : IPrintSchemaDisplayableElement
{
    HRESULT get_Selected(BOOL* pbIsSelected);
    HRESULT get_Constrained(PrintSchemaConstrainedSetting* pSetting);
    HRESULT GetPropertyValue(BSTR bstrName, BSTR bstrNamespaceUri, IUnknown* ppXmlValueNode);
}

@GUID("68746729-f493-4830-a10f-69028774605d")
interface IPrintSchemaPageMediaSizeOption : IPrintSchemaOption
{
    HRESULT get_WidthInMicrons(uint* pulWidth);
    HRESULT get_HeightInMicrons(uint* pulHeight);
}

@GUID("1f6342f2-d848-42e3-8995-c10a9ef9a3ba")
interface IPrintSchemaNUpOption : IPrintSchemaOption
{
    HRESULT get_PagesPerSheet(uint* pulPagesPerSheet);
}

@GUID("baecb0bd-a946-4771-bc30-e8b24f8d45c1")
interface IPrintSchemaOptionCollection : IDispatch
{
    HRESULT get_Count(uint* pulCount);
    HRESULT GetAt(uint ulIndex, IPrintSchemaOption* ppOption);
    HRESULT get__NewEnum(IUnknown* ppUnk);
}

@GUID("ef189461-5d62-4626-8e57-ff83583c4826")
interface IPrintSchemaFeature : IPrintSchemaDisplayableElement
{
    HRESULT get_SelectedOption(IPrintSchemaOption* ppOption);
    HRESULT put_SelectedOption(IPrintSchemaOption pOption);
    HRESULT get_SelectionType(PrintSchemaSelectionType* pSelectionType);
    HRESULT GetOption(BSTR bstrName, BSTR bstrNamespaceUri, IPrintSchemaOption* ppOption);
    HRESULT get_DisplayUI(BOOL* pbShow);
}

@GUID("7c85bf5e-dc7c-4f61-839b-4107e1c9b68e")
interface IPrintSchemaPageImageableSize : IPrintSchemaElement
{
    HRESULT get_ImageableSizeWidthInMicrons(uint* pulImageableSizeWidth);
    HRESULT get_ImageableSizeHeightInMicrons(uint* pulImageableSizeHeight);
    HRESULT get_OriginWidthInMicrons(uint* pulOriginWidth);
    HRESULT get_OriginHeightInMicrons(uint* pulOriginHeight);
    HRESULT get_ExtentWidthInMicrons(uint* pulExtentWidth);
    HRESULT get_ExtentHeightInMicrons(uint* pulExtentHeight);
}

@GUID("b5ade81e-0e61-4fe1-81c6-c333e4ffe0f1")
interface IPrintSchemaParameterDefinition : IPrintSchemaDisplayableElement
{
    HRESULT get_UserInputRequired(BOOL* pbIsRequired);
    HRESULT get_UnitType(BSTR* pbstrUnitType);
    HRESULT get_DataType(PrintSchemaParameterDataType* pDataType);
    HRESULT get_RangeMin(int* pRangeMin);
    HRESULT get_RangeMax(int* pRangeMax);
}

@GUID("52027082-0b74-4648-9564-828cc6cb656c")
interface IPrintSchemaParameterInitializer : IPrintSchemaElement
{
    HRESULT get_Value(VARIANT* pVar);
    HRESULT put_Value(VARIANT* pVar);
}

@GUID("5a577640-501d-4927-bcd0-5ef57a7ed175")
interface IPrintSchemaCapabilities : IPrintSchemaElement
{
    HRESULT GetFeatureByKeyName(BSTR bstrKeyName, IPrintSchemaFeature* ppFeature);
    HRESULT GetFeature(BSTR bstrName, BSTR bstrNamespaceUri, IPrintSchemaFeature* ppFeature);
    HRESULT get_PageImageableSize(IPrintSchemaPageImageableSize* ppPageImageableSize);
    HRESULT get_JobCopiesAllDocumentsMinValue(uint* pulJobCopiesAllDocumentsMinValue);
    HRESULT get_JobCopiesAllDocumentsMaxValue(uint* pulJobCopiesAllDocumentsMaxValue);
    HRESULT GetSelectedOptionInPrintTicket(IPrintSchemaFeature pFeature, IPrintSchemaOption* ppOption);
    HRESULT GetOptions(IPrintSchemaFeature pFeature, IPrintSchemaOptionCollection* ppOptionCollection);
}

@GUID("b58845f4-9970-4d87-a636-169fb82ed642")
interface IPrintSchemaCapabilities2 : IPrintSchemaCapabilities
{
    HRESULT GetParameterDefinition(BSTR bstrName, BSTR bstrNamespaceUri, 
                                   IPrintSchemaParameterDefinition* ppParameterDefinition);
}

@GUID("143c8dcb-d37f-47f7-88e8-6b1d21f2c5f7")
interface IPrintSchemaAsyncOperation : IDispatch
{
    HRESULT Start();
    HRESULT Cancel();
}

@GUID("e480b861-4708-4e6d-a5b4-a2b4eeb9baa4")
interface IPrintSchemaTicket : IPrintSchemaElement
{
    HRESULT GetFeatureByKeyName(BSTR bstrKeyName, IPrintSchemaFeature* ppFeature);
    HRESULT GetFeature(BSTR bstrName, BSTR bstrNamespaceUri, IPrintSchemaFeature* ppFeature);
    HRESULT ValidateAsync(IPrintSchemaAsyncOperation* ppAsyncOperation);
    HRESULT CommitAsync(IPrintSchemaTicket pPrintTicketCommit, IPrintSchemaAsyncOperation* ppAsyncOperation);
    HRESULT NotifyXmlChanged();
    HRESULT GetCapabilities(IPrintSchemaCapabilities* ppCapabilities);
    HRESULT get_JobCopiesAllDocuments(uint* pulJobCopiesAllDocuments);
    HRESULT put_JobCopiesAllDocuments(uint ulJobCopiesAllDocuments);
}

@GUID("2ec1f844-766a-47a1-91f4-2eeb6190f80c")
interface IPrintSchemaTicket2 : IPrintSchemaTicket
{
    HRESULT GetParameterInitializer(BSTR bstrName, BSTR bstrNamespaceUri, 
                                    IPrintSchemaParameterInitializer* ppParameterInitializer);
}

@GUID("23adbb16-0133-4906-b29a-1dce1d026379")
interface IPrintSchemaAsyncOperationEvent : IDispatch
{
    HRESULT Completed(IPrintSchemaTicket pTicket, HRESULT hrOperation);
}

@GUID("2072838a-316f-467a-a949-27f68c44a854")
interface IPrinterScriptableSequentialStream : IDispatch
{
    HRESULT Read(int cbRead, IDispatch* ppArray);
    HRESULT Write(IDispatch pArray, int* pcbWritten);
}

@GUID("7edf9a92-4750-41a5-a17f-879a6f4f7dcb")
interface IPrinterScriptableStream : IPrinterScriptableSequentialStream
{
    HRESULT Commit();
    HRESULT Seek(int lOffset, STREAM_SEEK streamSeek, int* plPosition);
    HRESULT SetSize(int lSize);
}

@GUID("fea77364-df95-4a23-a905-019b79a8e481")
interface IPrinterPropertyBag : IDispatch
{
    HRESULT GetBool(BSTR bstrName, BOOL* pbValue);
    HRESULT SetBool(BSTR bstrName, BOOL bValue);
    HRESULT GetInt32(BSTR bstrName, int* pnValue);
    HRESULT SetInt32(BSTR bstrName, int nValue);
    HRESULT GetString(BSTR bstrName, BSTR* pbstrValue);
    HRESULT SetString(BSTR bstrName, BSTR bstrValue);
    HRESULT GetBytes(BSTR bstrName, uint* pcbValue, ubyte** ppValue);
    HRESULT SetBytes(BSTR bstrName, uint cbValue, ubyte* pValue);
    HRESULT GetReadStream(BSTR bstrName, IStream* ppValue);
    HRESULT GetWriteStream(BSTR bstrName, IStream* ppValue);
}

@GUID("91c7765f-ed57-49ad-8b01-dc24816a5294")
interface IPrinterScriptablePropertyBag : IDispatch
{
    HRESULT GetBool(BSTR bstrName, BOOL* pbValue);
    HRESULT SetBool(BSTR bstrName, BOOL bValue);
    HRESULT GetInt32(BSTR bstrName, int* pnValue);
    HRESULT SetInt32(BSTR bstrName, int nValue);
    HRESULT GetString(BSTR bstrName, BSTR* pbstrValue);
    HRESULT SetString(BSTR bstrName, BSTR bstrValue);
    HRESULT GetBytes(BSTR bstrName, IDispatch* ppArray);
    HRESULT SetBytes(BSTR bstrName, IDispatch pArray);
    HRESULT GetReadStream(BSTR bstrName, IPrinterScriptableStream* ppStream);
    HRESULT GetWriteStream(BSTR bstrName, IPrinterScriptableStream* ppStream);
}

@GUID("2a1c53c4-8638-4b3e-b518-2773c94556a3")
interface IPrinterScriptablePropertyBag2 : IPrinterScriptablePropertyBag
{
    HRESULT GetReadStreamAsXML(BSTR bstrName, IUnknown* ppXmlNode);
}

@GUID("3580a828-07fe-4b94-ac1a-757d9d2d3056")
interface IPrinterQueue : IDispatch
{
    HRESULT get_Handle(PRINTER_HANDLE* phPrinter);
    HRESULT get_Name(BSTR* pbstrName);
    HRESULT SendBidiQuery(BSTR bstrBidiQuery);
    HRESULT GetProperties(IPrinterPropertyBag* ppPropertyBag);
}

@GUID("b771dab8-1282-41b7-858c-f206e4d20577")
interface IPrintJob : IUnknown
{
    HRESULT get_Name(BSTR* pbstrName);
    HRESULT get_Id(uint* pulID);
    HRESULT get_PrintedPages(uint* pulPages);
    HRESULT get_TotalPages(uint* pulPages);
    HRESULT get_Status(PrintJobStatus* pStatus);
    HRESULT get_SubmissionTime(double* pSubmissionTime);
    HRESULT RequestCancel();
}

@GUID("72b82a24-a598-4e87-895f-cdb23a49e9dc")
interface IPrintJobCollection : IDispatch
{
    HRESULT get_Count(uint* pulCount);
    HRESULT GetAt(uint ulIndex, IPrintJob* ppJob);
    HRESULT get__NewEnum(IUnknown* ppUnk);
}

@GUID("c5b6042b-fd21-404a-a0ef-e2fbb52b9080")
interface IPrinterQueueViewEvent : IDispatch
{
    HRESULT OnChanged(IPrintJobCollection pCollection, uint ulViewOffset, uint ulViewSize, 
                      uint ulCountJobsInPrintQueue);
}

@GUID("476e2969-3b2b-4b3f-8277-cff6056042aa")
interface IPrinterQueueView : IDispatch
{
    HRESULT SetViewRange(uint ulViewOffset, uint ulViewSize);
}

@GUID("214685f6-7b78-4681-87e0-495f739273d1")
interface IPrinterQueueEvent : IDispatch
{
    HRESULT OnBidiResponseReceived(BSTR bstrResponse, HRESULT hrStatus);
}

@GUID("c52d32dd-f2b4-4052-8502-ec4305ecb71f")
interface IPrinterBidiSetRequestCallback : IUnknown
{
    HRESULT Completed(BSTR bstrResponse, HRESULT hrStatus);
}

@GUID("108d6a23-6a4b-4552-9448-68b427186acd")
interface IPrinterExtensionAsyncOperation : IUnknown
{
    HRESULT Cancel();
}

@GUID("8cd444e8-c9bb-49b3-8e38-e03209416131")
interface IPrinterQueue2 : IPrinterQueue
{
    HRESULT SendBidiSetRequestAsync(BSTR bstrBidiRequest, IPrinterBidiSetRequestCallback pCallback, 
                                    IPrinterExtensionAsyncOperation* ppAsyncOperation);
    HRESULT GetPrinterQueueView(uint ulViewOffset, uint ulViewSize, IPrinterQueueView* ppJobView);
}

@GUID("39843bf2-c4d2-41fd-b4b2-aedbee5e1900")
interface IPrinterExtensionContext : IDispatch
{
    HRESULT get_PrinterQueue(IPrinterQueue* ppQueue);
    HRESULT get_PrintSchemaTicket(IPrintSchemaTicket* ppTicket);
    HRESULT get_DriverProperties(IPrinterPropertyBag* ppPropertyBag);
    HRESULT get_UserProperties(IPrinterPropertyBag* ppPropertyBag);
}

@GUID("39843bf3-c4d2-41fd-b4b2-aedbee5e1900")
interface IPrinterExtensionRequest : IDispatch
{
    HRESULT Cancel(HRESULT hrStatus, BSTR bstrLogMessage);
    HRESULT Complete();
}

@GUID("39843bf4-c4d2-41fd-b4b2-aedbee5e1900")
interface IPrinterExtensionEventArgs : IPrinterExtensionContext
{
    HRESULT get_BidiNotification(BSTR* pbstrBidiNotification);
    HRESULT get_ReasonId(GUID* pReasonId);
    HRESULT get_Request(IPrinterExtensionRequest* ppRequest);
    HRESULT get_SourceApplication(BSTR* pbstrApplication);
    HRESULT get_DetailedReasonId(GUID* pDetailedReasonId);
    HRESULT get_WindowModal(BOOL* pbModal);
    HRESULT get_WindowParent(HANDLE* phwndParent);
}

@GUID("fb476970-9bab-4861-811e-3e98b0c5addf")
interface IPrinterExtensionContextCollection : IDispatch
{
    HRESULT get_Count(uint* pulCount);
    HRESULT GetAt(uint ulIndex, IPrinterExtensionContext* ppContext);
    HRESULT get__NewEnum(IUnknown* ppUnk);
}

@GUID("c093cb63-5ef5-4585-af8e-4d5637487b57")
interface IPrinterExtensionEvent : IDispatch
{
    HRESULT OnDriverEvent(IPrinterExtensionEventArgs pEventArgs);
    HRESULT OnPrinterQueuesEnumerated(IPrinterExtensionContextCollection pContextCollection);
}

@GUID("93c6eb8c-b001-4355-9629-8e8a1b3f8e77")
interface IPrinterExtensionManager : IUnknown
{
    HRESULT EnableEvents(GUID printerDriverId);
    HRESULT DisableEvents();
}

@GUID("066acbca-8881-49c9-bb98-fae16b4889e1")
interface IPrinterScriptContext : IDispatch
{
    HRESULT get_DriverProperties(IPrinterScriptablePropertyBag* ppPropertyBag);
    HRESULT get_QueueProperties(IPrinterScriptablePropertyBag* ppPropertyBag);
    HRESULT get_UserProperties(IPrinterScriptablePropertyBag* ppPropertyBag);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/prnasnot/nn-prnasnot-iprintasyncnotifydataobject
@GUID("77cf513e-5d49-4789-9f30-d0822b335c0d")
interface IPrintAsyncNotifyDataObject : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/prnasnot/nf-prnasnot-iprintasyncnotifydataobject-acquiredata
    HRESULT AcquireData(ubyte** ppNotificationData, uint* pSize, GUID** ppSchema);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/prnasnot/nf-prnasnot-iprintasyncnotifydataobject-releasedata
    HRESULT ReleaseData();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/prnasnot/nn-prnasnot-iprintasyncnotifychannel
@GUID("4a5031b1-1f3f-4db0-a462-4530ed8b0451")
interface IPrintAsyncNotifyChannel : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/prnasnot/nf-prnasnot-iprintasyncnotifychannel-sendnotification
    HRESULT SendNotification(IPrintAsyncNotifyDataObject pData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/prnasnot/nf-prnasnot-iprintasyncnotifychannel-closechannel
    HRESULT CloseChannel(IPrintAsyncNotifyDataObject pData);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/prnasnot/nn-prnasnot-iprintasyncnotifycallback
@GUID("7def34c1-9d92-4c99-b3b3-db94a9d4191b")
interface IPrintAsyncNotifyCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/prnasnot/nf-prnasnot-iprintasyncnotifycallback-oneventnotify
    HRESULT OnEventNotify(IPrintAsyncNotifyChannel pChannel, IPrintAsyncNotifyDataObject pData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/prnasnot/nf-prnasnot-iprintasyncnotifycallback-channelclosed
    HRESULT ChannelClosed(IPrintAsyncNotifyChannel pChannel, IPrintAsyncNotifyDataObject pData);
}

@GUID("0f6f27b6-6f86-4591-9203-64c3bfadedfe")
interface IPrintAsyncNotifyRegistration : IUnknown
{
    HRESULT RegisterForNotifications();
    HRESULT UnregisterForNotifications();
}

@GUID("532818f7-921b-4fb2-bff8-2f4fd52ebebf")
interface IPrintAsyncNotify : IUnknown
{
    HRESULT CreatePrintAsyncNotifyChannel(uint param0, GUID* param1, PrintAsyncNotifyUserFilter param2, 
                                          PrintAsyncNotifyConversationStyle param3, IPrintAsyncNotifyCallback param4, 
                                          IPrintAsyncNotifyChannel* param5);
    HRESULT CreatePrintAsyncNotifyRegistration(GUID* param0, PrintAsyncNotifyUserFilter param1, 
                                               PrintAsyncNotifyConversationStyle param2, 
                                               IPrintAsyncNotifyCallback param3, 
                                               IPrintAsyncNotifyRegistration* param4);
}

interface IPrintAsyncCookie : IUnknown
{
    HRESULT FinishAsyncCall(HRESULT param0);
    HRESULT CancelAsyncCall(HRESULT param0);
}

interface IPrintAsyncNewChannelCookie : IPrintAsyncCookie
{
    HRESULT FinishAsyncCallWithData(IPrintAsyncNotifyChannel* param0, uint param1);
}

interface IAsyncGetSendNotificationCookie : IPrintAsyncCookie
{
    HRESULT FinishAsyncCallWithData(IPrintAsyncNotifyDataObject param0, BOOL param1);
}

interface IAsyncGetSrvReferralCookie : IUnknown
{
    HRESULT FinishAsyncCall(HRESULT param0);
    HRESULT CancelAsyncCall(HRESULT param0);
    HRESULT FinishAsyncCallWithData(const(PWSTR) param0);
}

interface IPrintBidiAsyncNotifyRegistration : IPrintAsyncNotifyRegistration
{
    HRESULT AsyncGetNewChannel(IPrintAsyncNewChannelCookie param0);
}

interface IPrintUnidiAsyncNotifyRegistration : IPrintAsyncNotifyRegistration
{
    HRESULT AsyncGetNotification(IAsyncGetSendNotificationCookie param0);
}

interface IPrintAsyncNotifyServerReferral : IUnknown
{
    HRESULT GetServerReferral(PWSTR* param0);
    HRESULT AsyncGetServerReferral(IAsyncGetSrvReferralCookie param0);
    HRESULT SetServerReferral(const(PWSTR) pRmtServerReferral);
}

@GUID("532818f7-921b-4fb2-bff8-2f4fd52ebebf")
interface IBidiAsyncNotifyChannel : IPrintAsyncNotifyChannel
{
    HRESULT CreateNotificationChannel();
    HRESULT GetPrintName(IPrintAsyncNotifyDataObject* param0);
    HRESULT GetChannelNotificationType(IPrintAsyncNotifyDataObject* param0);
    HRESULT AsyncGetNotificationSendResponse(IPrintAsyncNotifyDataObject param0, 
                                             IAsyncGetSendNotificationCookie param1);
    HRESULT AsyncCloseChannel(IPrintAsyncNotifyDataObject param0, IPrintAsyncCookie param1);
}

@GUID("9ab8fd0d-cb94-49c2-9cb0-97ec1d5469d2")
interface IXpsRasterizerNotificationCallback : IUnknown
{
    HRESULT Continue();
}

@GUID("7567cfc8-c156-47a8-9dac-11a2ae5bdd6b")
interface IXpsRasterizer : IUnknown
{
    HRESULT RasterizeRect(int x, int y, int width, int height, 
                          IXpsRasterizerNotificationCallback notificationCallback, IWICBitmap* bitmap);
    HRESULT SetMinimalLineWidth(int width);
}

@GUID("e094808a-24c6-482b-a3a7-c21ac9b55f17")
interface IXpsRasterizationFactory : IUnknown
{
    HRESULT CreateRasterizer(IXpsOMPage xpsPage, float DPI, XPSRAS_RENDERING_MODE nonTextRenderingMode, 
                             XPSRAS_RENDERING_MODE textRenderingMode, IXpsRasterizer* ppIXPSRasterizer);
}

@GUID("2d6e5f77-6414-4a1e-a8e0-d4194ce6a26f")
interface IXpsRasterizationFactory1 : IUnknown
{
    HRESULT CreateRasterizer(IXpsOMPage xpsPage, float DPI, XPSRAS_RENDERING_MODE nonTextRenderingMode, 
                             XPSRAS_RENDERING_MODE textRenderingMode, XPSRAS_PIXEL_FORMAT pixelFormat, 
                             IXpsRasterizer* ppIXPSRasterizer);
}

@GUID("9c16ce3e-10f5-41fd-9ddc-6826669c2ff6")
interface IXpsRasterizationFactory2 : IUnknown
{
    HRESULT CreateRasterizer(IXpsOMPage xpsPage, float DPIX, float DPIY, 
                             XPSRAS_RENDERING_MODE nonTextRenderingMode, XPSRAS_RENDERING_MODE textRenderingMode, 
                             XPSRAS_PIXEL_FORMAT pixelFormat, XPSRAS_BACKGROUND_COLOR backgroundColor, 
                             IXpsRasterizer* ppIXpsRasterizer);
}

@GUID("1a6dd0ad-1e2a-4e99-a5ba-91f17818290e")
interface IPrintPreviewDxgiPackageTarget : IUnknown
{
    HRESULT SetJobPageCount(PageCountType countType, uint count);
    HRESULT DrawPage(uint jobPageNumber, IDXGISurface pageImage, float dpiX, float dpiY);
    HRESULT InvalidatePreview();
}


// GUIDs

const GUID CLSID_BidiRequest               = GUIDOF!BidiRequest;
const GUID CLSID_BidiRequestContainer      = GUIDOF!BidiRequestContainer;
const GUID CLSID_BidiSpl                   = GUIDOF!BidiSpl;
const GUID CLSID_PrintSchemaAsyncOperation = GUIDOF!PrintSchemaAsyncOperation;
const GUID CLSID_PrinterExtensionManager   = GUIDOF!PrinterExtensionManager;
const GUID CLSID_PrinterQueue              = GUIDOF!PrinterQueue;
const GUID CLSID_PrinterQueueView          = GUIDOF!PrinterQueueView;

const GUID IID_IBidiAsyncNotifyChannel            = GUIDOF!IBidiAsyncNotifyChannel;
const GUID IID_IBidiRequest                       = GUIDOF!IBidiRequest;
const GUID IID_IBidiRequestContainer              = GUIDOF!IBidiRequestContainer;
const GUID IID_IBidiSpl                           = GUIDOF!IBidiSpl;
const GUID IID_IBidiSpl2                          = GUIDOF!IBidiSpl2;
const GUID IID_IFixedDocument                     = GUIDOF!IFixedDocument;
const GUID IID_IFixedDocumentSequence             = GUIDOF!IFixedDocumentSequence;
const GUID IID_IFixedPage                         = GUIDOF!IFixedPage;
const GUID IID_IImgCreateErrorInfo                = GUIDOF!IImgCreateErrorInfo;
const GUID IID_IImgErrorInfo                      = GUIDOF!IImgErrorInfo;
const GUID IID_IInterFilterCommunicator           = GUIDOF!IInterFilterCommunicator;
const GUID IID_IPartBase                          = GUIDOF!IPartBase;
const GUID IID_IPartColorProfile                  = GUIDOF!IPartColorProfile;
const GUID IID_IPartDiscardControl                = GUIDOF!IPartDiscardControl;
const GUID IID_IPartFont                          = GUIDOF!IPartFont;
const GUID IID_IPartFont2                         = GUIDOF!IPartFont2;
const GUID IID_IPartImage                         = GUIDOF!IPartImage;
const GUID IID_IPartPrintTicket                   = GUIDOF!IPartPrintTicket;
const GUID IID_IPartResourceDictionary            = GUIDOF!IPartResourceDictionary;
const GUID IID_IPartThumbnail                     = GUIDOF!IPartThumbnail;
const GUID IID_IPrintAsyncNotify                  = GUIDOF!IPrintAsyncNotify;
const GUID IID_IPrintAsyncNotifyCallback          = GUIDOF!IPrintAsyncNotifyCallback;
const GUID IID_IPrintAsyncNotifyChannel           = GUIDOF!IPrintAsyncNotifyChannel;
const GUID IID_IPrintAsyncNotifyDataObject        = GUIDOF!IPrintAsyncNotifyDataObject;
const GUID IID_IPrintAsyncNotifyRegistration      = GUIDOF!IPrintAsyncNotifyRegistration;
const GUID IID_IPrintClassObjectFactory           = GUIDOF!IPrintClassObjectFactory;
const GUID IID_IPrintCoreHelper                   = GUIDOF!IPrintCoreHelper;
const GUID IID_IPrintCoreHelperPS                 = GUIDOF!IPrintCoreHelperPS;
const GUID IID_IPrintCoreHelperUni                = GUIDOF!IPrintCoreHelperUni;
const GUID IID_IPrintCoreHelperUni2               = GUIDOF!IPrintCoreHelperUni2;
const GUID IID_IPrintCoreUI2                      = GUIDOF!IPrintCoreUI2;
const GUID IID_IPrintJob                          = GUIDOF!IPrintJob;
const GUID IID_IPrintJobCollection                = GUIDOF!IPrintJobCollection;
const GUID IID_IPrintOemCommon                    = GUIDOF!IPrintOemCommon;
const GUID IID_IPrintOemDriverUI                  = GUIDOF!IPrintOemDriverUI;
const GUID IID_IPrintOemUI                        = GUIDOF!IPrintOemUI;
const GUID IID_IPrintOemUI2                       = GUIDOF!IPrintOemUI2;
const GUID IID_IPrintOemUIMXDC                    = GUIDOF!IPrintOemUIMXDC;
const GUID IID_IPrintPipelineFilter               = GUIDOF!IPrintPipelineFilter;
const GUID IID_IPrintPipelineManagerControl       = GUIDOF!IPrintPipelineManagerControl;
const GUID IID_IPrintPipelineProgressReport       = GUIDOF!IPrintPipelineProgressReport;
const GUID IID_IPrintPipelinePropertyBag          = GUIDOF!IPrintPipelinePropertyBag;
const GUID IID_IPrintPreviewDxgiPackageTarget     = GUIDOF!IPrintPreviewDxgiPackageTarget;
const GUID IID_IPrintReadStream                   = GUIDOF!IPrintReadStream;
const GUID IID_IPrintReadStreamFactory            = GUIDOF!IPrintReadStreamFactory;
const GUID IID_IPrintSchemaAsyncOperation         = GUIDOF!IPrintSchemaAsyncOperation;
const GUID IID_IPrintSchemaAsyncOperationEvent    = GUIDOF!IPrintSchemaAsyncOperationEvent;
const GUID IID_IPrintSchemaCapabilities           = GUIDOF!IPrintSchemaCapabilities;
const GUID IID_IPrintSchemaCapabilities2          = GUIDOF!IPrintSchemaCapabilities2;
const GUID IID_IPrintSchemaDisplayableElement     = GUIDOF!IPrintSchemaDisplayableElement;
const GUID IID_IPrintSchemaElement                = GUIDOF!IPrintSchemaElement;
const GUID IID_IPrintSchemaFeature                = GUIDOF!IPrintSchemaFeature;
const GUID IID_IPrintSchemaNUpOption              = GUIDOF!IPrintSchemaNUpOption;
const GUID IID_IPrintSchemaOption                 = GUIDOF!IPrintSchemaOption;
const GUID IID_IPrintSchemaOptionCollection       = GUIDOF!IPrintSchemaOptionCollection;
const GUID IID_IPrintSchemaPageImageableSize      = GUIDOF!IPrintSchemaPageImageableSize;
const GUID IID_IPrintSchemaPageMediaSizeOption    = GUIDOF!IPrintSchemaPageMediaSizeOption;
const GUID IID_IPrintSchemaParameterDefinition    = GUIDOF!IPrintSchemaParameterDefinition;
const GUID IID_IPrintSchemaParameterInitializer   = GUIDOF!IPrintSchemaParameterInitializer;
const GUID IID_IPrintSchemaTicket                 = GUIDOF!IPrintSchemaTicket;
const GUID IID_IPrintSchemaTicket2                = GUIDOF!IPrintSchemaTicket2;
const GUID IID_IPrintTicketProvider               = GUIDOF!IPrintTicketProvider;
const GUID IID_IPrintTicketProvider2              = GUIDOF!IPrintTicketProvider2;
const GUID IID_IPrintWriteStream                  = GUIDOF!IPrintWriteStream;
const GUID IID_IPrintWriteStreamFlush             = GUIDOF!IPrintWriteStreamFlush;
const GUID IID_IPrinterBidiSetRequestCallback     = GUIDOF!IPrinterBidiSetRequestCallback;
const GUID IID_IPrinterExtensionAsyncOperation    = GUIDOF!IPrinterExtensionAsyncOperation;
const GUID IID_IPrinterExtensionContext           = GUIDOF!IPrinterExtensionContext;
const GUID IID_IPrinterExtensionContextCollection = GUIDOF!IPrinterExtensionContextCollection;
const GUID IID_IPrinterExtensionEvent             = GUIDOF!IPrinterExtensionEvent;
const GUID IID_IPrinterExtensionEventArgs         = GUIDOF!IPrinterExtensionEventArgs;
const GUID IID_IPrinterExtensionManager           = GUIDOF!IPrinterExtensionManager;
const GUID IID_IPrinterExtensionRequest           = GUIDOF!IPrinterExtensionRequest;
const GUID IID_IPrinterPropertyBag                = GUIDOF!IPrinterPropertyBag;
const GUID IID_IPrinterQueue                      = GUIDOF!IPrinterQueue;
const GUID IID_IPrinterQueue2                     = GUIDOF!IPrinterQueue2;
const GUID IID_IPrinterQueueEvent                 = GUIDOF!IPrinterQueueEvent;
const GUID IID_IPrinterQueueView                  = GUIDOF!IPrinterQueueView;
const GUID IID_IPrinterQueueViewEvent             = GUIDOF!IPrinterQueueViewEvent;
const GUID IID_IPrinterScriptContext              = GUIDOF!IPrinterScriptContext;
const GUID IID_IPrinterScriptablePropertyBag      = GUIDOF!IPrinterScriptablePropertyBag;
const GUID IID_IPrinterScriptablePropertyBag2     = GUIDOF!IPrinterScriptablePropertyBag2;
const GUID IID_IPrinterScriptableSequentialStream = GUIDOF!IPrinterScriptableSequentialStream;
const GUID IID_IPrinterScriptableStream           = GUIDOF!IPrinterScriptableStream;
const GUID IID_IXpsDocument                       = GUIDOF!IXpsDocument;
const GUID IID_IXpsDocumentConsumer               = GUIDOF!IXpsDocumentConsumer;
const GUID IID_IXpsDocumentProvider               = GUIDOF!IXpsDocumentProvider;
const GUID IID_IXpsPartIterator                   = GUIDOF!IXpsPartIterator;
const GUID IID_IXpsRasterizationFactory           = GUIDOF!IXpsRasterizationFactory;
const GUID IID_IXpsRasterizationFactory1          = GUIDOF!IXpsRasterizationFactory1;
const GUID IID_IXpsRasterizationFactory2          = GUIDOF!IXpsRasterizationFactory2;
const GUID IID_IXpsRasterizer                     = GUIDOF!IXpsRasterizer;
const GUID IID_IXpsRasterizerNotificationCallback = GUIDOF!IXpsRasterizerNotificationCallback;
