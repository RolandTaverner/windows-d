// Written in the D programming language.

module windows.win32.media.mediaplayer;

public import windows.core;
public import system : Guid;
public import windows.win32.foundation : BOOL, BSTR, HRESULT, HWND, LPARAM, LRESULT,
                                         PWSTR, RECT, SIZE, SYSTEMTIME, VARIANT_BOOL,
                                         WPARAM;
public import windows.win32.graphics.gdi : HDC;
public import windows.win32.media.mediafoundation : IMFActivate;
public import windows.win32.system.com : BLOB, IDispatch, IStream, IUnknown;
public import windows.win32.system.ole : IEnumVARIANT;
public import windows.win32.system.variant : VARIANT;
public import windows.win32.ui.windowsandmessaging : MSG;

extern(Windows) @nogc nothrow:


// Enums

//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/ne-wmp-wmpopenstate))], [])
enum WMPOpenState : int
{
    wmposUndefined               = 0x00000000,
    wmposPlaylistChanging        = 0x00000001,
    wmposPlaylistLocating        = 0x00000002,
    wmposPlaylistConnecting      = 0x00000003,
    wmposPlaylistLoading         = 0x00000004,
    wmposPlaylistOpening         = 0x00000005,
    wmposPlaylistOpenNoMedia     = 0x00000006,
    wmposPlaylistChanged         = 0x00000007,
    wmposMediaChanging           = 0x00000008,
    wmposMediaLocating           = 0x00000009,
    wmposMediaConnecting         = 0x0000000a,
    wmposMediaLoading            = 0x0000000b,
    wmposMediaOpening            = 0x0000000c,
    wmposMediaOpen               = 0x0000000d,
    wmposBeginCodecAcquisition   = 0x0000000e,
    wmposEndCodecAcquisition     = 0x0000000f,
    wmposBeginLicenseAcquisition = 0x00000010,
    wmposEndLicenseAcquisition   = 0x00000011,
    wmposBeginIndividualization  = 0x00000012,
    wmposEndIndividualization    = 0x00000013,
    wmposMediaWaiting            = 0x00000014,
    wmposOpeningUnknownURL       = 0x00000015,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/ne-wmp-wmpplaystate))], [])
enum WMPPlayState : int
{
    wmppsUndefined     = 0x00000000,
    wmppsStopped       = 0x00000001,
    wmppsPaused        = 0x00000002,
    wmppsPlaying       = 0x00000003,
    wmppsScanForward   = 0x00000004,
    wmppsScanReverse   = 0x00000005,
    wmppsBuffering     = 0x00000006,
    wmppsWaiting       = 0x00000007,
    wmppsMediaEnded    = 0x00000008,
    wmppsTransitioning = 0x00000009,
    wmppsReady         = 0x0000000a,
    wmppsReconnecting  = 0x0000000b,
    wmppsLast          = 0x0000000c,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/ne-wmp-wmpplaylistchangeeventtype))], [])
enum WMPPlaylistChangeEventType : int
{
    wmplcUnknown    = 0x00000000,
    wmplcClear      = 0x00000001,
    wmplcInfoChange = 0x00000002,
    wmplcMove       = 0x00000003,
    wmplcDelete     = 0x00000004,
    wmplcInsert     = 0x00000005,
    wmplcAppend     = 0x00000006,
    wmplcPrivate    = 0x00000007,
    wmplcNameChange = 0x00000008,
    wmplcMorph      = 0x00000009,
    wmplcSort       = 0x0000000a,
    wmplcLast       = 0x0000000b,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/ne-wmp-wmpsyncstate))], [])
enum WMPSyncState : int
{
    wmpssUnknown       = 0x00000000,
    wmpssSynchronizing = 0x00000001,
    wmpssStopped       = 0x00000002,
    wmpssEstimating    = 0x00000003,
    wmpssLast          = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/ne-wmp-wmpdevicestatus))], [])
enum WMPDeviceStatus : int
{
    wmpdsUnknown             = 0x00000000,
    wmpdsPartnershipExists   = 0x00000001,
    wmpdsPartnershipDeclined = 0x00000002,
    wmpdsPartnershipAnother  = 0x00000003,
    wmpdsManualDevice        = 0x00000004,
    wmpdsNewDevice           = 0x00000005,
    wmpdsLast                = 0x00000006,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/ne-wmp-wmpripstate))], [])
enum WMPRipState : int
{
    wmprsUnknown = 0x00000000,
    wmprsRipping = 0x00000001,
    wmprsStopped = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/ne-wmp-wmpburnformat))], [])
enum WMPBurnFormat : int
{
    wmpbfAudioCD = 0x00000000,
    wmpbfDataCD  = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/ne-wmp-wmpburnstate))], [])
enum WMPBurnState : int
{
    wmpbsUnknown              = 0x00000000,
    wmpbsBusy                 = 0x00000001,
    wmpbsReady                = 0x00000002,
    wmpbsWaitingForDisc       = 0x00000003,
    wmpbsRefreshStatusPending = 0x00000004,
    wmpbsPreparingToBurn      = 0x00000005,
    wmpbsBurning              = 0x00000006,
    wmpbsStopped              = 0x00000007,
    wmpbsErasing              = 0x00000008,
    wmpbsDownloading          = 0x00000009,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/ne-wmp-wmpstringcollectionchangeeventtype))], [])
enum WMPStringCollectionChangeEventType : int
{
    wmpsccetUnknown      = 0x00000000,
    wmpsccetInsert       = 0x00000001,
    wmpsccetChange       = 0x00000002,
    wmpsccetDelete       = 0x00000003,
    wmpsccetClear        = 0x00000004,
    wmpsccetBeginUpdates = 0x00000005,
    wmpsccetEndUpdates   = 0x00000006,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/ne-wmp-wmplibrarytype))], [])
enum WMPLibraryType : int
{
    wmpltUnknown        = 0x00000000,
    wmpltAll            = 0x00000001,
    wmpltLocal          = 0x00000002,
    wmpltRemote         = 0x00000003,
    wmpltDisc           = 0x00000004,
    wmpltPortableDevice = 0x00000005,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/ne-wmp-wmpfolderscanstate))], [])
enum WMPFolderScanState : int
{
    wmpfssUnknown  = 0x00000000,
    wmpfssScanning = 0x00000001,
    wmpfssUpdating = 0x00000002,
    wmpfssStopped  = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmpservices/ne-wmpservices-wmpservices_streamstate))], [])
alias WMPServices_StreamState = int;
enum : int
{
    WMPServices_StreamState_Stop  = 0x00000000,
    WMPServices_StreamState_Pause = 0x00000001,
    WMPServices_StreamState_Play  = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmpservices/ne-wmpservices-wmpplugin_caps))], [])
alias WMPPlugin_Caps = int;
enum : int
{
    WMPPlugin_Caps_CannotConvertFormats = 0x00000001,
}
alias FEEDS_BACKGROUNDSYNC_ACTION = int;
enum : int
{
    FBSA_DISABLE = 0x00000000,
    FBSA_ENABLE  = 0x00000001,
    FBSA_RUNNOW  = 0x00000002,
}
alias FEEDS_BACKGROUNDSYNC_STATUS = int;
enum : int
{
    FBSS_DISABLED = 0x00000000,
    FBSS_ENABLED  = 0x00000001,
}
alias FEEDS_EVENTS_SCOPE = int;
enum : int
{
    FES_ALL                    = 0x00000000,
    FES_SELF_ONLY              = 0x00000001,
    FES_SELF_AND_CHILDREN_ONLY = 0x00000002,
}
alias FEEDS_EVENTS_MASK = int;
enum : int
{
    FEM_FOLDEREVENTS = 0x00000001,
    FEM_FEEDEVENTS   = 0x00000002,
}
alias FEEDS_XML_SORT_PROPERTY = int;
enum : int
{
    FXSP_NONE         = 0x00000000,
    FXSP_PUBDATE      = 0x00000001,
    FXSP_DOWNLOADTIME = 0x00000002,
}
alias FEEDS_XML_SORT_ORDER = int;
enum : int
{
    FXSO_NONE       = 0x00000000,
    FXSO_ASCENDING  = 0x00000001,
    FXSO_DESCENDING = 0x00000002,
}
alias FEEDS_XML_FILTER_FLAGS = int;
enum : int
{
    FXFF_ALL    = 0x00000000,
    FXFF_UNREAD = 0x00000001,
    FXFF_READ   = 0x00000002,
}
alias FEEDS_XML_INCLUDE_FLAGS = int;
enum : int
{
    FXIF_NONE          = 0x00000000,
    FXIF_CF_EXTENSIONS = 0x00000001,
}
alias FEEDS_DOWNLOAD_STATUS = int;
enum : int
{
    FDS_NONE            = 0x00000000,
    FDS_PENDING         = 0x00000001,
    FDS_DOWNLOADING     = 0x00000002,
    FDS_DOWNLOADED      = 0x00000003,
    FDS_DOWNLOAD_FAILED = 0x00000004,
}
alias FEEDS_SYNC_SETTING = int;
enum : int
{
    FSS_DEFAULT   = 0x00000000,
    FSS_INTERVAL  = 0x00000001,
    FSS_MANUAL    = 0x00000002,
    FSS_SUGGESTED = 0x00000003,
}
alias FEEDS_DOWNLOAD_ERROR = int;
enum : int
{
    FDE_NONE                         = 0x00000000,
    FDE_DOWNLOAD_FAILED              = 0x00000001,
    FDE_INVALID_FEED_FORMAT          = 0x00000002,
    FDE_NORMALIZATION_FAILED         = 0x00000003,
    FDE_PERSISTENCE_FAILED           = 0x00000004,
    FDE_DOWNLOAD_BLOCKED             = 0x00000005,
    FDE_CANCELED                     = 0x00000006,
    FDE_UNSUPPORTED_AUTH             = 0x00000007,
    FDE_BACKGROUND_DOWNLOAD_DISABLED = 0x00000008,
    FDE_NOT_EXIST                    = 0x00000009,
    FDE_UNSUPPORTED_MSXML            = 0x0000000a,
    FDE_UNSUPPORTED_DTD              = 0x0000000b,
    FDE_DOWNLOAD_SIZE_LIMIT_EXCEEDED = 0x0000000c,
    FDE_ACCESS_DENIED                = 0x0000000d,
    FDE_AUTH_FAILED                  = 0x0000000e,
    FDE_INVALID_AUTH                 = 0x0000000f,
}
alias FEEDS_EVENTS_ITEM_COUNT_FLAGS = int;
enum : int
{
    FEICF_READ_ITEM_COUNT_CHANGED   = 0x00000001,
    FEICF_UNREAD_ITEM_COUNT_CHANGED = 0x00000002,
}
alias FEEDS_ERROR_CODE = int;
enum : int
{
    FEC_E_ERRORBASE                 = 0xc0040200,
    FEC_E_INVALIDMSXMLPROPERTY      = 0xc0040200,
    FEC_E_DOWNLOADSIZELIMITEXCEEDED = 0xc0040201,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/effects/ne-effects-playerstate))], [])
enum PlayerState : int
{
    stop_state  = 0x00000000,
    pause_state = 0x00000001,
    play_state  = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/ne-contentpartner-wmppartnernotification))], [])
enum WMPPartnerNotification : int
{
    wmpsnBackgroundProcessingBegin = 0x00000001,
    wmpsnBackgroundProcessingEnd   = 0x00000002,
    wmpsnCatalogDownloadFailure    = 0x00000003,
    wmpsnCatalogDownloadComplete   = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/ne-contentpartner-wmpcallbacknotification))], [])
enum WMPCallbackNotification : int
{
    wmpcnLoginStateChange     = 0x00000001,
    wmpcnAuthResult           = 0x00000002,
    wmpcnLicenseUpdated       = 0x00000003,
    wmpcnNewCatalogAvailable  = 0x00000004,
    wmpcnNewPluginAvailable   = 0x00000005,
    wmpcnDisableRadioSkipping = 0x00000006,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/ne-contentpartner-wmptasktype))], [])
enum WMPTaskType : int
{
    wmpttBrowse  = 0x00000001,
    wmpttSync    = 0x00000002,
    wmpttBurn    = 0x00000003,
    wmpttCurrent = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/ne-contentpartner-wmptransactiontype))], [])
enum WMPTransactionType : int
{
    wmpttNoTransaction = 0x00000000,
    wmpttDownload      = 0x00000001,
    wmpttBuy           = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/ne-contentpartner-wmptemplatesize))], [])
enum WMPTemplateSize : int
{
    wmptsSmall  = 0x00000000,
    wmptsMedium = 0x00000001,
    wmptsLarge  = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/ne-contentpartner-wmpstreamingtype))], [])
enum WMPStreamingType : int
{
    wmpstUnknown = 0x00000000,
    wmpstMusic   = 0x00000001,
    wmpstVideo   = 0x00000002,
    wmpstRadio   = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/ne-contentpartner-wmpaccounttype))], [])
enum WMPAccountType : int
{
    wmpatBuyOnly      = 0x00000001,
    wmpatSubscription = 0x00000002,
    wmpatJanus        = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/subscriptionservices/ne-subscriptionservices-wmpsubscriptionserviceevent))], [])
enum WMPSubscriptionServiceEvent : int
{
    wmpsseCurrentBegin = 0x00000001,
    wmpsseCurrentEnd   = 0x00000002,
    wmpsseFullBegin    = 0x00000003,
    wmpsseFullEnd      = 0x00000004,
}
enum WMPSubscriptionDownloadState : int
{
    wmpsdlsDownloading = 0x00000000,
    wmpsdlsPaused      = 0x00000001,
    wmpsdlsProcessing  = 0x00000002,
    wmpsdlsCompleted   = 0x00000003,
    wmpsdlsCancelled   = 0x00000004,
}

// Constants


enum GUID CLSID_XFeedsManager = GUID("fe6b11c3-c72e-4061-86c6-9d163121f229");

enum : uint
{
    WMPGC_FLAGS_ALLOW_PREROLL    = 0x00000001,
    WMPGC_FLAGS_SUPPRESS_DIALOGS = 0x00000002,
    WMPGC_FLAGS_IGNORE_AV_SYNC   = 0x00000004,
    WMPGC_FLAGS_DISABLE_PLUGINS  = 0x00000008,
    WMPGC_FLAGS_USE_CUSTOM_GRAPH = 0x00000010,
}

enum uint WMPUE_EC_USER = 0x00008100;

enum : uint
{
    WMP_MDRT_FLAGS_UNREPORTED_DELETED_ITEMS = 0x00000001,
    WMP_MDRT_FLAGS_UNREPORTED_ADDED_ITEMS   = 0x00000002,
}

enum uint IOCTL_WMP_METADATA_ROUND_TRIP = 0x31504d57;
enum uint IOCTL_WMP_DEVICE_CAN_SYNC = 0x32504d57;
enum uint EFFECT_CANGOFULLSCREEN = 0x00000001;
enum uint EFFECT_HASPROPERTYPAGE = 0x00000002;
enum uint EFFECT_VARIABLEFREQSTEP = 0x00000004;
enum uint EFFECT_WINDOWEDONLY = 0x00000008;
enum uint EFFECT2_FULLSCREENEXCLUSIVE = 0x00000010;
enum uint SA_BUFFER_SIZE = 0x00000400;

enum : const(wchar)*
{
    PLUGIN_INSTALLREGKEY              = "Software\\Microsoft\\MediaPlayer\\UIPlugins",
    PLUGIN_INSTALLREGKEY_FRIENDLYNAME = "FriendlyName",
    PLUGIN_INSTALLREGKEY_DESCRIPTION  = "Description",
    PLUGIN_INSTALLREGKEY_CAPABILITIES = "Capabilities",
    PLUGIN_INSTALLREGKEY_UNINSTALL    = "UninstallPath",
}

enum : uint
{
    PLUGIN_TYPE_BACKGROUND     = 0x00000001,
    PLUGIN_TYPE_SEPARATEWINDOW = 0x00000002,
    PLUGIN_TYPE_DISPLAYAREA    = 0x00000003,
    PLUGIN_TYPE_SETTINGSAREA   = 0x00000004,
    PLUGIN_TYPE_METADATAAREA   = 0x00000005,
}

enum : uint
{
    PLUGIN_FLAGS_HASPROPERTYPAGE    = 0x80000000,
    PLUGIN_FLAGS_INSTALLAUTORUN     = 0x40000000,
    PLUGIN_FLAGS_LAUNCHPROPERTYPAGE = 0x20000000,
    PLUGIN_FLAGS_ACCEPTSMEDIA       = 0x10000000,
    PLUGIN_FLAGS_ACCEPTSPLAYLISTS   = 0x08000000,
    PLUGIN_FLAGS_HASPRESETS         = 0x04000000,
    PLUGIN_FLAGS_HIDDEN             = 0x02000000,
}

enum : const(wchar)*
{
    PLUGIN_MISC_PRESETCOUNT   = "PresetCount",
    PLUGIN_MISC_PRESETNAMES   = "PresetNames",
    PLUGIN_MISC_CURRENTPRESET = "CurrentPreset",
}

enum : const(wchar)*
{
    PLUGIN_SEPARATEWINDOW_RESIZABLE     = "Resizable",
    PLUGIN_SEPARATEWINDOW_DEFAULTWIDTH  = "DefaultWidth",
    PLUGIN_SEPARATEWINDOW_DEFAULTHEIGHT = "DefaultHeight",
    PLUGIN_SEPARATEWINDOW_MINWIDTH      = "MinWidth",
    PLUGIN_SEPARATEWINDOW_MINHEIGHT     = "MinHeight",
    PLUGIN_SEPARATEWINDOW_MAXWIDTH      = "MaxWidth",
    PLUGIN_SEPARATEWINDOW_MAXHEIGHT     = "MaxHeight",
}

enum const(wchar)* PLUGIN_MISC_QUERYDESTROY = "QueryDestroy";

enum : const(wchar)*
{
    PLUGIN_ALL_MEDIASENDTO    = "MediaSendTo",
    PLUGIN_ALL_PLAYLISTSENDTO = "PlaylistSendTo",
}

enum : uint
{
    SUBSCRIPTION_CAP_DEVICEAVAILABLE      = 0x00000010,
    SUBSCRIPTION_CAP_BACKGROUNDPROCESSING = 0x00000008,
    SUBSCRIPTION_CAP_IS_CONTENTPARTNER    = 0x00000040,
    SUBSCRIPTION_CAP_ALTLOGIN             = 0x00000080,
    SUBSCRIPTION_CAP_ALLOWPLAY            = 0x00000001,
    SUBSCRIPTION_CAP_ALLOWCDBURN          = 0x00000002,
    SUBSCRIPTION_CAP_ALLOWPDATRANSFER     = 0x00000004,
    SUBSCRIPTION_CAP_PREPAREFORSYNC       = 0x00000020,
    SUBSCRIPTION_V1_CAPS                  = 0x0000000f,
    SUBSCRIPTION_CAP_UILESSMODE_ALLOWPLAY = 0x00000100,
}

enum : const(wchar)*
{
    WMP_SUBSCR_DL_TYPE_BACKGROUND = "background",
    WMP_SUBSCR_DL_TYPE_REALTIME   = "real time",
}

enum : uint
{
    DISPID_FEEDS_RootFolder           = 0x00001000,
    DISPID_FEEDS_IsSubscribed         = 0x00001001,
    DISPID_FEEDS_ExistsFeed           = 0x00001002,
    DISPID_FEEDS_GetFeed              = 0x00001003,
    DISPID_FEEDS_ExistsFolder         = 0x00001004,
    DISPID_FEEDS_GetFolder            = 0x00001005,
    DISPID_FEEDS_DeleteFeed           = 0x00001006,
    DISPID_FEEDS_DeleteFolder         = 0x00001007,
    DISPID_FEEDS_GetFeedByUrl         = 0x00001008,
    DISPID_FEEDS_BackgroundSync       = 0x00001009,
    DISPID_FEEDS_BackgroundSyncStatus = 0x0000100a,
}

enum : uint
{
    DISPID_FEEDS_DefaultInterval           = 0x0000100b,
    DISPID_FEEDS_AsyncSyncAll              = 0x0000100c,
    DISPID_FEEDS_Normalize                 = 0x0000100d,
    DISPID_FEEDS_ItemCountLimit            = 0x0000100e,
    DISPID_FEEDSENUM_Count                 = 0x00002000,
    DISPID_FEEDSENUM_Item                  = 0x00002001,
    DISPID_FEEDFOLDER_Feeds                = 0x00003000,
    DISPID_FEEDFOLDER_Subfolders           = 0x00003001,
    DISPID_FEEDFOLDER_CreateFeed           = 0x00003002,
    DISPID_FEEDFOLDER_CreateSubfolder      = 0x00003003,
    DISPID_FEEDFOLDER_ExistsFeed           = 0x00003004,
    DISPID_FEEDFOLDER_GetFeed              = 0x00003005,
    DISPID_FEEDFOLDER_ExistsSubfolder      = 0x00003006,
    DISPID_FEEDFOLDER_GetSubfolder         = 0x00003007,
    DISPID_FEEDFOLDER_Delete               = 0x00003008,
    DISPID_FEEDFOLDER_Name                 = 0x00003009,
    DISPID_FEEDFOLDER_Rename               = 0x0000300a,
    DISPID_FEEDFOLDER_Path                 = 0x0000300b,
    DISPID_FEEDFOLDER_Move                 = 0x0000300c,
    DISPID_FEEDFOLDER_Parent               = 0x0000300d,
    DISPID_FEEDFOLDER_IsRoot               = 0x0000300e,
    DISPID_FEEDFOLDER_TotalUnreadItemCount = 0x0000300f,
    DISPID_FEEDFOLDER_TotalItemCount       = 0x00003010,
    DISPID_FEEDFOLDER_GetWatcher           = 0x00003011,
}

enum : uint
{
    DISPID_FEED_Xml                 = 0x00004000,
    DISPID_FEED_Name                = 0x00004001,
    DISPID_FEED_Rename              = 0x00004002,
    DISPID_FEED_Url                 = 0x00004003,
    DISPID_FEED_LocalId             = 0x00004004,
    DISPID_FEED_Path                = 0x00004005,
    DISPID_FEED_Move                = 0x00004006,
    DISPID_FEED_Parent              = 0x00004007,
    DISPID_FEED_LastWriteTime       = 0x00004008,
    DISPID_FEED_Delete              = 0x00004009,
    DISPID_FEED_Download            = 0x0000400a,
    DISPID_FEED_AsyncDownload       = 0x0000400b,
    DISPID_FEED_CancelAsyncDownload = 0x0000400c,
}

enum : uint
{
    DISPID_FEED_Interval           = 0x0000400d,
    DISPID_FEED_SyncSetting        = 0x0000400e,
    DISPID_FEED_LastDownloadTime   = 0x0000400f,
    DISPID_FEED_LocalEnclosurePath = 0x00004010,
}

enum : uint
{
    DISPID_FEED_Items                           = 0x00004011,
    DISPID_FEED_GetItem                         = 0x00004012,
    DISPID_FEED_Title                           = 0x00004013,
    DISPID_FEED_Description                     = 0x00004014,
    DISPID_FEED_Link                            = 0x00004015,
    DISPID_FEED_Image                           = 0x00004016,
    DISPID_FEED_LastBuildDate                   = 0x00004017,
    DISPID_FEED_PubDate                         = 0x00004018,
    DISPID_FEED_Ttl                             = 0x00004019,
    DISPID_FEED_Language                        = 0x0000401a,
    DISPID_FEED_Copyright                       = 0x0000401b,
    DISPID_FEED_DownloadEnclosuresAutomatically = 0x0000401c,
    DISPID_FEED_DownloadStatus                  = 0x0000401d,
    DISPID_FEED_LastDownloadError               = 0x0000401e,
    DISPID_FEED_Merge                           = 0x0000401f,
    DISPID_FEED_DownloadUrl                     = 0x00004020,
    DISPID_FEED_IsList                          = 0x00004021,
    DISPID_FEED_MarkAllItemsRead                = 0x00004022,
    DISPID_FEED_GetWatcher                      = 0x00004023,
    DISPID_FEED_UnreadItemCount                 = 0x00004024,
    DISPID_FEED_ItemCount                       = 0x00004025,
    DISPID_FEED_MaxItemCount                    = 0x00004026,
    DISPID_FEED_GetItemByEffectiveId            = 0x00004027,
}

enum uint DISPID_FEED_LastItemDownloadTime = 0x00004028;

enum : uint
{
    DISPID_FEED_Username         = 0x00004029,
    DISPID_FEED_Password         = 0x0000402a,
    DISPID_FEED_SetCredentials   = 0x0000402b,
    DISPID_FEED_ClearCredentials = 0x0000402c,
}

enum : uint
{
    DISPID_FEEDITEM_Xml                      = 0x00005000,
    DISPID_FEEDITEM_Title                    = 0x00005001,
    DISPID_FEEDITEM_Link                     = 0x00005002,
    DISPID_FEEDITEM_Guid                     = 0x00005003,
    DISPID_FEEDITEM_Description              = 0x00005004,
    DISPID_FEEDITEM_PubDate                  = 0x00005005,
    DISPID_FEEDITEM_Comments                 = 0x00005006,
    DISPID_FEEDITEM_Author                   = 0x00005007,
    DISPID_FEEDITEM_Enclosure                = 0x00005008,
    DISPID_FEEDITEM_IsRead                   = 0x00005009,
    DISPID_FEEDITEM_LocalId                  = 0x0000500a,
    DISPID_FEEDITEM_Parent                   = 0x0000500b,
    DISPID_FEEDITEM_Delete                   = 0x0000500c,
    DISPID_FEEDITEM_DownloadUrl              = 0x0000500d,
    DISPID_FEEDITEM_LastDownloadTime         = 0x0000500e,
    DISPID_FEEDITEM_Modified                 = 0x0000500f,
    DISPID_FEEDITEM_EffectiveId              = 0x00005010,
    DISPID_FEEDENCLOSURE_Url                 = 0x00006000,
    DISPID_FEEDENCLOSURE_Type                = 0x00006001,
    DISPID_FEEDENCLOSURE_Length              = 0x00006002,
    DISPID_FEEDENCLOSURE_AsyncDownload       = 0x00006003,
    DISPID_FEEDENCLOSURE_CancelAsyncDownload = 0x00006004,
    DISPID_FEEDENCLOSURE_DownloadStatus      = 0x00006005,
    DISPID_FEEDENCLOSURE_LastDownloadError   = 0x00006006,
    DISPID_FEEDENCLOSURE_LocalPath           = 0x00006007,
    DISPID_FEEDENCLOSURE_Parent              = 0x00006008,
    DISPID_FEEDENCLOSURE_DownloadUrl         = 0x00006009,
    DISPID_FEEDENCLOSURE_DownloadMimeType    = 0x0000600a,
    DISPID_FEEDENCLOSURE_RemoveFile          = 0x0000600b,
    DISPID_FEEDENCLOSURE_SetFile             = 0x0000600c,
}

enum : uint
{
    DISPID_FEEDFOLDEREVENTS_Error                  = 0x00007000,
    DISPID_FEEDFOLDEREVENTS_FolderAdded            = 0x00007001,
    DISPID_FEEDFOLDEREVENTS_FolderDeleted          = 0x00007002,
    DISPID_FEEDFOLDEREVENTS_FolderRenamed          = 0x00007003,
    DISPID_FEEDFOLDEREVENTS_FolderMovedFrom        = 0x00007004,
    DISPID_FEEDFOLDEREVENTS_FolderMovedTo          = 0x00007005,
    DISPID_FEEDFOLDEREVENTS_FolderItemCountChanged = 0x00007006,
    DISPID_FEEDFOLDEREVENTS_FeedAdded              = 0x00007007,
    DISPID_FEEDFOLDEREVENTS_FeedDeleted            = 0x00007008,
    DISPID_FEEDFOLDEREVENTS_FeedRenamed            = 0x00007009,
    DISPID_FEEDFOLDEREVENTS_FeedUrlChanged         = 0x0000700a,
    DISPID_FEEDFOLDEREVENTS_FeedMovedFrom          = 0x0000700b,
    DISPID_FEEDFOLDEREVENTS_FeedMovedTo            = 0x0000700c,
    DISPID_FEEDFOLDEREVENTS_FeedDownloading        = 0x0000700d,
    DISPID_FEEDFOLDEREVENTS_FeedDownloadCompleted  = 0x0000700e,
    DISPID_FEEDFOLDEREVENTS_FeedItemCountChanged   = 0x0000700f,
}

enum : uint
{
    DISPID_FEEDEVENTS_Error                 = 0x00008000,
    DISPID_FEEDEVENTS_FeedDeleted           = 0x00008001,
    DISPID_FEEDEVENTS_FeedRenamed           = 0x00008002,
    DISPID_FEEDEVENTS_FeedUrlChanged        = 0x00008003,
    DISPID_FEEDEVENTS_FeedMoved             = 0x00008004,
    DISPID_FEEDEVENTS_FeedDownloading       = 0x00008005,
    DISPID_FEEDEVENTS_FeedDownloadCompleted = 0x00008006,
    DISPID_FEEDEVENTS_FeedItemCountChanged  = 0x00008007,
}

enum : uint
{
    DISPID_DELTA                      = 0x00000032,
    DISPID_WMPCORE_BASE               = 0x00000000,
    DISPID_WMPCORE_URL                = 0x00000001,
    DISPID_WMPCORE_OPENSTATE          = 0x00000002,
    DISPID_WMPCORE_CLOSE              = 0x00000003,
    DISPID_WMPCORE_CONTROLS           = 0x00000004,
    DISPID_WMPCORE_SETTINGS           = 0x00000005,
    DISPID_WMPCORE_CURRENTMEDIA       = 0x00000006,
    DISPID_WMPCORE_NETWORK            = 0x00000007,
    DISPID_WMPCORE_MEDIACOLLECTION    = 0x00000008,
    DISPID_WMPCORE_PLAYLISTCOLLECTION = 0x00000009,
    DISPID_WMPCORE_PLAYSTATE          = 0x0000000a,
    DISPID_WMPCORE_VERSIONINFO        = 0x0000000b,
    DISPID_WMPCORE_LAUNCHURL          = 0x0000000c,
    DISPID_WMPCORE_CURRENTPLAYLIST    = 0x0000000d,
    DISPID_WMPCORE_CDROMCOLLECTION    = 0x0000000e,
    DISPID_WMPCORE_CLOSEDCAPTION      = 0x0000000f,
    DISPID_WMPCORE_ISONLINE           = 0x00000010,
    DISPID_WMPCORE_ERROR              = 0x00000011,
    DISPID_WMPCORE_STATUS             = 0x00000012,
    DISPID_WMPCORE_LAST               = 0x00000012,
    DISPID_WMPOCX_BASE                = 0x00000012,
    DISPID_WMPOCX_ENABLED             = 0x00000013,
    DISPID_WMPOCX_TRANSPARENTATSTART  = 0x00000014,
    DISPID_WMPOCX_FULLSCREEN          = 0x00000015,
    DISPID_WMPOCX_ENABLECONTEXTMENU   = 0x00000016,
    DISPID_WMPOCX_UIMODE              = 0x00000017,
    DISPID_WMPOCX_LAST                = 0x00000017,
    DISPID_WMPOCX2_BASE               = 0x00000017,
    DISPID_WMPOCX2_STRETCHTOFIT       = 0x00000018,
    DISPID_WMPOCX2_WINDOWLESSVIDEO    = 0x00000019,
    DISPID_WMPOCX4_ISREMOTE           = 0x0000001a,
    DISPID_WMPOCX4_PLAYERAPPLICATION  = 0x0000001b,
    DISPID_WMPOCX4_OPENPLAYER         = 0x0000001c,
}

enum : uint
{
    DISPID_WMPCORE2_BASE                          = 0x00000027,
    DISPID_WMPCORE2_DVD                           = 0x00000028,
    DISPID_WMPCORE3_NEWPLAYLIST                   = 0x00000029,
    DISPID_WMPCORE3_NEWMEDIA                      = 0x0000002a,
    DISPID_WMPCONTROLS_PLAY                       = 0x00000033,
    DISPID_WMPCONTROLS_STOP                       = 0x00000034,
    DISPID_WMPCONTROLS_PAUSE                      = 0x00000035,
    DISPID_WMPCONTROLS_FASTFORWARD                = 0x00000036,
    DISPID_WMPCONTROLS_FASTREVERSE                = 0x00000037,
    DISPID_WMPCONTROLS_CURRENTPOSITION            = 0x00000038,
    DISPID_WMPCONTROLS_CURRENTPOSITIONSTRING      = 0x00000039,
    DISPID_WMPCONTROLS_NEXT                       = 0x0000003a,
    DISPID_WMPCONTROLS_PREVIOUS                   = 0x0000003b,
    DISPID_WMPCONTROLS_CURRENTITEM                = 0x0000003c,
    DISPID_WMPCONTROLS_CURRENTMARKER              = 0x0000003d,
    DISPID_WMPCONTROLS_ISAVAILABLE                = 0x0000003e,
    DISPID_WMPCONTROLS_PLAYITEM                   = 0x0000003f,
    DISPID_WMPCONTROLS2_STEP                      = 0x00000040,
    DISPID_WMPCONTROLS3_AUDIOLANGUAGECOUNT        = 0x00000041,
    DISPID_WMPCONTROLS3_GETAUDIOLANGUAGEID        = 0x00000042,
    DISPID_WMPCONTROLS3_GETAUDIOLANGUAGEDESC      = 0x00000043,
    DISPID_WMPCONTROLS3_CURRENTAUDIOLANGUAGE      = 0x00000044,
    DISPID_WMPCONTROLS3_CURRENTAUDIOLANGUAGEINDEX = 0x00000045,
    DISPID_WMPCONTROLS3_GETLANGUAGENAME           = 0x00000046,
    DISPID_WMPCONTROLS3_CURRENTPOSITIONTIMECODE   = 0x00000047,
    DISPID_WMPCONTROLSFAKE_TIMECOMPRESSION        = 0x00000048,
}

enum : uint
{
    DISPID_WMPSETTINGS_AUTOSTART                   = 0x00000065,
    DISPID_WMPSETTINGS_BALANCE                     = 0x00000066,
    DISPID_WMPSETTINGS_INVOKEURLS                  = 0x00000067,
    DISPID_WMPSETTINGS_MUTE                        = 0x00000068,
    DISPID_WMPSETTINGS_PLAYCOUNT                   = 0x00000069,
    DISPID_WMPSETTINGS_RATE                        = 0x0000006a,
    DISPID_WMPSETTINGS_VOLUME                      = 0x0000006b,
    DISPID_WMPSETTINGS_BASEURL                     = 0x0000006c,
    DISPID_WMPSETTINGS_DEFAULTFRAME                = 0x0000006d,
    DISPID_WMPSETTINGS_GETMODE                     = 0x0000006e,
    DISPID_WMPSETTINGS_SETMODE                     = 0x0000006f,
    DISPID_WMPSETTINGS_ENABLEERRORDIALOGS          = 0x00000070,
    DISPID_WMPSETTINGS_ISAVAILABLE                 = 0x00000071,
    DISPID_WMPSETTINGS2_DEFAULTAUDIOLANGUAGE       = 0x00000072,
    DISPID_WMPSETTINGS2_LIBRARYACCESSRIGHTS        = 0x00000073,
    DISPID_WMPSETTINGS2_REQUESTLIBRARYACCESSRIGHTS = 0x00000074,
}

enum : uint
{
    DISPID_WMPPLAYLIST_COUNT          = 0x000000c9,
    DISPID_WMPPLAYLIST_NAME           = 0x000000ca,
    DISPID_WMPPLAYLIST_GETITEMINFO    = 0x000000cb,
    DISPID_WMPPLAYLIST_SETITEMINFO    = 0x000000cc,
    DISPID_WMPPLAYLIST_CLEAR          = 0x000000cd,
    DISPID_WMPPLAYLIST_INSERTITEM     = 0x000000ce,
    DISPID_WMPPLAYLIST_APPENDITEM     = 0x000000cf,
    DISPID_WMPPLAYLIST_REMOVEITEM     = 0x000000d0,
    DISPID_WMPPLAYLIST_MOVEITEM       = 0x000000d1,
    DISPID_WMPPLAYLIST_ATTRIBUTECOUNT = 0x000000d2,
    DISPID_WMPPLAYLIST_ATTRIBUTENAME  = 0x000000d3,
    DISPID_WMPPLAYLIST_ITEM           = 0x000000d4,
    DISPID_WMPPLAYLIST_ISIDENTICAL    = 0x000000d5,
}

enum : uint
{
    DISPID_WMPCDROM_DRIVESPECIFIER                  = 0x000000fb,
    DISPID_WMPCDROM_PLAYLIST                        = 0x000000fc,
    DISPID_WMPCDROM_EJECT                           = 0x000000fd,
    DISPID_WMPCDROMCOLLECTION_COUNT                 = 0x0000012d,
    DISPID_WMPCDROMCOLLECTION_ITEM                  = 0x0000012e,
    DISPID_WMPCDROMCOLLECTION_GETBYDRIVESPECIFIER   = 0x0000012f,
    DISPID_WMPCDROMCOLLECTION_STARTMONITORINGCDROMS = 0x00000130,
    DISPID_WMPCDROMCOLLECTION_STOPMONITORINGCDROMS  = 0x00000131,
}

enum : uint
{
    DISPID_WMPSTRINGCOLLECTION_COUNT = 0x00000191,
    DISPID_WMPSTRINGCOLLECTION_ITEM  = 0x00000192,
}

enum : uint
{
    DISPID_WMPMEDIACOLLECTION_ADD                          = 0x000001c4,
    DISPID_WMPMEDIACOLLECTION_GETALL                       = 0x000001c5,
    DISPID_WMPMEDIACOLLECTION_GETBYNAME                    = 0x000001c6,
    DISPID_WMPMEDIACOLLECTION_GETBYGENRE                   = 0x000001c7,
    DISPID_WMPMEDIACOLLECTION_GETBYAUTHOR                  = 0x000001c8,
    DISPID_WMPMEDIACOLLECTION_GETBYALBUM                   = 0x000001c9,
    DISPID_WMPMEDIACOLLECTION_GETBYATTRIBUTE               = 0x000001ca,
    DISPID_WMPMEDIACOLLECTION_REMOVE                       = 0x000001cb,
    DISPID_WMPMEDIACOLLECTION_GETATTRIBUTESTRINGCOLLECTION = 0x000001cd,
    DISPID_WMPMEDIACOLLECTION_NEWQUERY                     = 0x000001ce,
    DISPID_WMPMEDIACOLLECTION_STARTMONITORING              = 0x000001cf,
    DISPID_WMPMEDIACOLLECTION_STOPMONITORING               = 0x000001d0,
    DISPID_WMPMEDIACOLLECTION_STARTCONTENTSCAN             = 0x000001d1,
    DISPID_WMPMEDIACOLLECTION_STOPCONTENTSCAN              = 0x000001d2,
    DISPID_WMPMEDIACOLLECTION_STARTSEARCH                  = 0x000001d3,
    DISPID_WMPMEDIACOLLECTION_STOPSEARCH                   = 0x000001d4,
    DISPID_WMPMEDIACOLLECTION_UPDATEMETADATA               = 0x000001d5,
    DISPID_WMPMEDIACOLLECTION_GETMEDIAATOM                 = 0x000001d6,
    DISPID_WMPMEDIACOLLECTION_SETDELETED                   = 0x000001d7,
    DISPID_WMPMEDIACOLLECTION_ISDELETED                    = 0x000001d8,
    DISPID_WMPMEDIACOLLECTION_GETBYQUERYDESCRIPTION        = 0x000001d9,
    DISPID_WMPMEDIACOLLECTION_FREEZECOLLECTIONCHANGE       = 0x000001da,
    DISPID_WMPMEDIACOLLECTION_UNFREEZECOLLECTIONCHANGE     = 0x000001db,
    DISPID_WMPMEDIACOLLECTION_POSTCOLLECTIONCHANGE         = 0x000001dc,
}

enum : uint
{
    DISPID_WMPPLAYLISTARRAY_COUNT                      = 0x000001f5,
    DISPID_WMPPLAYLISTARRAY_ITEM                       = 0x000001f6,
    DISPID_WMPPLAYLISTCOLLECTION_NEWPLAYLIST           = 0x00000228,
    DISPID_WMPPLAYLISTCOLLECTION_GETALL                = 0x00000229,
    DISPID_WMPPLAYLISTCOLLECTION_GETBYNAME             = 0x0000022a,
    DISPID_WMPPLAYLISTCOLLECTION_GETBYQUERYDESCRIPTION = 0x0000022b,
    DISPID_WMPPLAYLISTCOLLECTION_REMOVE                = 0x0000022c,
    DISPID_WMPPLAYLISTCOLLECTION_NEWQUERY              = 0x0000022d,
    DISPID_WMPPLAYLISTCOLLECTION_STARTMONITORING       = 0x0000022e,
    DISPID_WMPPLAYLISTCOLLECTION_STOPMONITORING        = 0x0000022f,
    DISPID_WMPPLAYLISTCOLLECTION_SETDELETED            = 0x00000230,
    DISPID_WMPPLAYLISTCOLLECTION_ISDELETED             = 0x00000231,
    DISPID_WMPPLAYLISTCOLLECTION_IMPORTPLAYLIST        = 0x00000232,
}

enum : uint
{
    DISPID_WMPMEDIA_SOURCEURL                = 0x000002ef,
    DISPID_WMPMEDIA_IMAGESOURCEWIDTH         = 0x000002f0,
    DISPID_WMPMEDIA_IMAGESOURCEHEIGHT        = 0x000002f1,
    DISPID_WMPMEDIA_MARKERCOUNT              = 0x000002f2,
    DISPID_WMPMEDIA_GETMARKERTIME            = 0x000002f3,
    DISPID_WMPMEDIA_GETMARKERNAME            = 0x000002f4,
    DISPID_WMPMEDIA_DURATION                 = 0x000002f5,
    DISPID_WMPMEDIA_DURATIONSTRING           = 0x000002f6,
    DISPID_WMPMEDIA_ATTRIBUTECOUNT           = 0x000002f7,
    DISPID_WMPMEDIA_GETATTRIBUTENAME         = 0x000002f8,
    DISPID_WMPMEDIA_GETITEMINFO              = 0x000002f9,
    DISPID_WMPMEDIA_SETITEMINFO              = 0x000002fa,
    DISPID_WMPMEDIA_ISIDENTICAL              = 0x000002fb,
    DISPID_WMPMEDIA_NAME                     = 0x000002fc,
    DISPID_WMPMEDIA_GETITEMINFOBYATOM        = 0x000002fd,
    DISPID_WMPMEDIA_ISMEMBEROF               = 0x000002fe,
    DISPID_WMPMEDIA_ISREADONLYITEM           = 0x000002ff,
    DISPID_WMPMEDIA2_ERROR                   = 0x00000300,
    DISPID_WMPMEDIA3_GETATTRIBUTECOUNTBYTYPE = 0x00000301,
    DISPID_WMPMEDIA3_GETITEMINFOBYTYPE       = 0x00000302,
}

enum : uint
{
    DISPID_WMPNETWORK_BANDWIDTH              = 0x00000321,
    DISPID_WMPNETWORK_RECOVEREDPACKETS       = 0x00000322,
    DISPID_WMPNETWORK_SOURCEPROTOCOL         = 0x00000323,
    DISPID_WMPNETWORK_RECEIVEDPACKETS        = 0x00000324,
    DISPID_WMPNETWORK_LOSTPACKETS            = 0x00000325,
    DISPID_WMPNETWORK_RECEPTIONQUALITY       = 0x00000326,
    DISPID_WMPNETWORK_BUFFERINGCOUNT         = 0x00000327,
    DISPID_WMPNETWORK_BUFFERINGPROGRESS      = 0x00000328,
    DISPID_WMPNETWORK_BUFFERINGTIME          = 0x00000329,
    DISPID_WMPNETWORK_FRAMERATE              = 0x0000032a,
    DISPID_WMPNETWORK_MAXBITRATE             = 0x0000032b,
    DISPID_WMPNETWORK_BITRATE                = 0x0000032c,
    DISPID_WMPNETWORK_GETPROXYSETTINGS       = 0x0000032d,
    DISPID_WMPNETWORK_SETPROXYSETTINGS       = 0x0000032e,
    DISPID_WMPNETWORK_GETPROXYNAME           = 0x0000032f,
    DISPID_WMPNETWORK_SETPROXYNAME           = 0x00000330,
    DISPID_WMPNETWORK_GETPROXYPORT           = 0x00000331,
    DISPID_WMPNETWORK_SETPROXYPORT           = 0x00000332,
    DISPID_WMPNETWORK_GETPROXYEXCEPTIONLIST  = 0x00000333,
    DISPID_WMPNETWORK_SETPROXYEXCEPTIONLIST  = 0x00000334,
    DISPID_WMPNETWORK_GETPROXYBYPASSFORLOCAL = 0x00000335,
    DISPID_WMPNETWORK_SETPROXYBYPASSFORLOCAL = 0x00000336,
    DISPID_WMPNETWORK_MAXBANDWIDTH           = 0x00000337,
    DISPID_WMPNETWORK_DOWNLOADPROGRESS       = 0x00000338,
    DISPID_WMPNETWORK_ENCODEDFRAMERATE       = 0x00000339,
    DISPID_WMPNETWORK_FRAMESSKIPPED          = 0x0000033a,
}

enum : uint
{
    DISPID_WMPERROR_CLEARERRORQUEUE      = 0x00000353,
    DISPID_WMPERROR_ERRORCOUNT           = 0x00000354,
    DISPID_WMPERROR_ITEM                 = 0x00000355,
    DISPID_WMPERROR_WEBHELP              = 0x00000356,
    DISPID_WMPERRORITEM_ERRORCODE        = 0x00000385,
    DISPID_WMPERRORITEM_ERRORDESCRIPTION = 0x00000386,
    DISPID_WMPERRORITEM_ERRORCONTEXT     = 0x00000387,
    DISPID_WMPERRORITEM_REMEDY           = 0x00000388,
    DISPID_WMPERRORITEM_CUSTOMURL        = 0x00000389,
    DISPID_WMPERRORITEM2_CONDITION       = 0x0000038a,
}

enum : uint
{
    DISPID_WMPCLOSEDCAPTION_SAMISTYLE      = 0x000003b7,
    DISPID_WMPCLOSEDCAPTION_SAMILANG       = 0x000003b8,
    DISPID_WMPCLOSEDCAPTION_SAMIFILENAME   = 0x000003b9,
    DISPID_WMPCLOSEDCAPTION_CAPTIONINGID   = 0x000003ba,
    DISPID_WMPCLOSEDCAPTION2_GETLANGCOUNT  = 0x000003bb,
    DISPID_WMPCLOSEDCAPTION2_GETLANGNAME   = 0x000003bc,
    DISPID_WMPCLOSEDCAPTION2_GETLANGID     = 0x000003bd,
    DISPID_WMPCLOSEDCAPTION2_GETSTYLECOUNT = 0x000003be,
    DISPID_WMPCLOSEDCAPTION2_GETSTYLENAME  = 0x000003bf,
}

enum : uint
{
    DISPID_WMPDVD_ISAVAILABLE              = 0x000003e9,
    DISPID_WMPDVD_DOMAIN                   = 0x000003ea,
    DISPID_WMPDVD_TOPMENU                  = 0x000003eb,
    DISPID_WMPDVD_TITLEMENU                = 0x000003ec,
    DISPID_WMPDVD_BACK                     = 0x000003ed,
    DISPID_WMPDVD_RESUME                   = 0x000003ee,
    DISPID_WMPMETADATA_PICTURE_MIMETYPE    = 0x0000041b,
    DISPID_WMPMETADATA_PICTURE_PICTURETYPE = 0x0000041c,
    DISPID_WMPMETADATA_PICTURE_DESCRIPTION = 0x0000041d,
    DISPID_WMPMETADATA_PICTURE_URL         = 0x0000041e,
    DISPID_WMPMETADATA_TEXT_TEXT           = 0x0000041f,
    DISPID_WMPMETADATA_TEXT_DESCRIPTION    = 0x00000420,
}

enum : uint
{
    DISPID_WMPPLAYERAPP_SWITCHTOPLAYERAPPLICATION = 0x0000044d,
    DISPID_WMPPLAYERAPP_SWITCHTOCONTROL           = 0x0000044e,
    DISPID_WMPPLAYERAPP_PLAYERDOCKED              = 0x0000044f,
    DISPID_WMPPLAYERAPP_HASDISPLAY                = 0x00000450,
    DISPID_WMPPLAYERAPP_REMOTESTATUS              = 0x00000451,
}

enum : uint
{
    DISPID_WMPDOWNLOADMANAGER_GETDOWNLOADCOLLECTION    = 0x0000047f,
    DISPID_WMPDOWNLOADMANAGER_CREATEDOWNLOADCOLLECTION = 0x00000480,
}

enum : uint
{
    DISPID_WMPDOWNLOADCOLLECTION_ID            = 0x000004b1,
    DISPID_WMPDOWNLOADCOLLECTION_COUNT         = 0x000004b2,
    DISPID_WMPDOWNLOADCOLLECTION_ITEM          = 0x000004b3,
    DISPID_WMPDOWNLOADCOLLECTION_STARTDOWNLOAD = 0x000004b4,
    DISPID_WMPDOWNLOADCOLLECTION_REMOVEITEM    = 0x000004b5,
    DISPID_WMPDOWNLOADCOLLECTION_CLEAR         = 0x000004b6,
    DISPID_WMPDOWNLOADITEM_SOURCEURL           = 0x000004e3,
    DISPID_WMPDOWNLOADITEM_SIZE                = 0x000004e4,
    DISPID_WMPDOWNLOADITEM_TYPE                = 0x000004e5,
    DISPID_WMPDOWNLOADITEM_PROGRESS            = 0x000004e6,
    DISPID_WMPDOWNLOADITEM_DOWNLOADSTATE       = 0x000004e7,
    DISPID_WMPDOWNLOADITEM_PAUSE               = 0x000004e8,
    DISPID_WMPDOWNLOADITEM_RESUME              = 0x000004e9,
    DISPID_WMPDOWNLOADITEM_CANCEL              = 0x000004ea,
    DISPID_WMPDOWNLOADITEM2_GETITEMINFO        = 0x00000515,
}

enum : uint
{
    DISPID_WMPQUERY_ADDCONDITION   = 0x00000547,
    DISPID_WMPQUERY_BEGINNEXTGROUP = 0x00000548,
}

enum : uint
{
    DISPID_WMPMEDIACOLLECTION2_CREATEQUERY           = 0x00000579,
    DISPID_WMPMEDIACOLLECTION2_GETPLAYLISTBYQUERY    = 0x0000057a,
    DISPID_WMPMEDIACOLLECTION2_GETSTRINGCOLLBYQUERY  = 0x0000057b,
    DISPID_WMPMEDIACOLLECTION2_GETBYATTRANDMEDIATYPE = 0x0000057c,
}

enum : uint
{
    DISPID_WMPSTRINGCOLLECTION2_ISIDENTICAL        = 0x000005ab,
    DISPID_WMPSTRINGCOLLECTION2_GETITEMINFO        = 0x000005ac,
    DISPID_WMPSTRINGCOLLECTION2_GETATTRCOUNTBYTYPE = 0x000005ad,
    DISPID_WMPSTRINGCOLLECTION2_GETITEMINFOBYTYPE  = 0x000005ae,
}

enum : uint
{
    DISPID_WMPCORE_MIN = 0x00000001,
    DISPID_WMPCORE_MAX = 0x000005ae,
}

enum uint WMPCOREEVENT_BASE = 0x00001388;

enum : uint
{
    DISPID_WMPCOREEVENT_OPENSTATECHANGE = 0x00001389,
    DISPID_WMPCOREEVENT_STATUSCHANGE    = 0x0000138a,
}

enum uint WMPCOREEVENT_CONTROL_BASE = 0x000013ec;

enum : uint
{
    DISPID_WMPCOREEVENT_PLAYSTATECHANGE     = 0x000013ed,
    DISPID_WMPCOREEVENT_AUDIOLANGUAGECHANGE = 0x000013ee,
}

enum uint WMPCOREEVENT_SEEK_BASE = 0x00001450;

enum : uint
{
    DISPID_WMPCOREEVENT_ENDOFSTREAM        = 0x00001451,
    DISPID_WMPCOREEVENT_POSITIONCHANGE     = 0x00001452,
    DISPID_WMPCOREEVENT_MARKERHIT          = 0x00001453,
    DISPID_WMPCOREEVENT_DURATIONUNITCHANGE = 0x00001454,
}

enum uint WMPCOREEVENT_CONTENT_BASE = 0x000014b4;
enum uint DISPID_WMPCOREEVENT_SCRIPTCOMMAND = 0x000014b5;
enum uint WMPCOREEVENT_NETWORK_BASE = 0x00001518;

enum : uint
{
    DISPID_WMPCOREEVENT_DISCONNECT = 0x00001519,
    DISPID_WMPCOREEVENT_BUFFERING  = 0x0000151a,
    DISPID_WMPCOREEVENT_NEWSTREAM  = 0x0000151b,
}

enum uint WMPCOREEVENT_ERROR_BASE = 0x0000157c;
enum uint DISPID_WMPCOREEVENT_ERROR = 0x0000157d;
enum uint WMPCOREEVENT_WARNING_BASE = 0x000015e0;
enum uint DISPID_WMPCOREEVENT_WARNING = 0x000015e1;
enum uint WMPCOREEVENT_CDROM_BASE = 0x00001644;
enum uint DISPID_WMPCOREEVENT_CDROMMEDIACHANGE = 0x00001645;
enum uint WMPCOREEVENT_PLAYLIST_BASE = 0x000016a8;

enum : uint
{
    DISPID_WMPCOREEVENT_PLAYLISTCHANGE                        = 0x000016a9,
    DISPID_WMPCOREEVENT_MEDIACHANGE                           = 0x000016aa,
    DISPID_WMPCOREEVENT_CURRENTMEDIAITEMAVAILABLE             = 0x000016ab,
    DISPID_WMPCOREEVENT_CURRENTPLAYLISTCHANGE                 = 0x000016ac,
    DISPID_WMPCOREEVENT_CURRENTPLAYLISTITEMAVAILABLE          = 0x000016ad,
    DISPID_WMPCOREEVENT_CURRENTITEMCHANGE                     = 0x000016ae,
    DISPID_WMPCOREEVENT_MEDIACOLLECTIONCHANGE                 = 0x000016af,
    DISPID_WMPCOREEVENT_MEDIACOLLECTIONATTRIBUTESTRINGADDED   = 0x000016b0,
    DISPID_WMPCOREEVENT_MEDIACOLLECTIONATTRIBUTESTRINGREMOVED = 0x000016b1,
}

enum : uint
{
    DISPID_WMPCOREEVENT_PLAYLISTCOLLECTIONCHANGE          = 0x000016b2,
    DISPID_WMPCOREEVENT_PLAYLISTCOLLECTIONPLAYLISTADDED   = 0x000016b3,
    DISPID_WMPCOREEVENT_PLAYLISTCOLLECTIONPLAYLISTREMOVED = 0x000016b4,
}

enum : uint
{
    DISPID_WMPCOREEVENT_MEDIACOLLECTIONCONTENTSCANADDEDITEM    = 0x000016b5,
    DISPID_WMPCOREEVENT_MEDIACOLLECTIONCONTENTSCANPROGRESS     = 0x000016b6,
    DISPID_WMPCOREEVENT_MEDIACOLLECTIONSEARCHFOUNDITEM         = 0x000016b7,
    DISPID_WMPCOREEVENT_MEDIACOLLECTIONSEARCHPROGRESS          = 0x000016b8,
    DISPID_WMPCOREEVENT_MEDIACOLLECTIONSEARCHCOMPLETE          = 0x000016b9,
    DISPID_WMPCOREEVENT_PLAYLISTCOLLECTIONPLAYLISTSETASDELETED = 0x000016ba,
}

enum : uint
{
    DISPID_WMPCOREEVENT_MODECHANGE                            = 0x000016bb,
    DISPID_WMPCOREEVENT_MEDIACOLLECTIONATTRIBUTESTRINGCHANGED = 0x000016bc,
    DISPID_WMPCOREEVENT_MEDIAERROR                            = 0x000016bd,
    DISPID_WMPCOREEVENT_DOMAINCHANGE                          = 0x000016be,
    DISPID_WMPCOREEVENT_OPENPLAYLISTSWITCH                    = 0x000016bf,
    DISPID_WMPCOREEVENT_STRINGCOLLECTIONCHANGE                = 0x000016c0,
    DISPID_WMPCOREEVENT_MEDIACOLLECTIONMEDIAADDED             = 0x000016c1,
    DISPID_WMPCOREEVENT_MEDIACOLLECTIONMEDIAREMOVED           = 0x000016c2,
}

enum uint WMPOCXEVENT_BASE = 0x00001964;

enum : uint
{
    DISPID_WMPOCXEVENT_SWITCHEDTOPLAYERAPPLICATION = 0x00001965,
    DISPID_WMPOCXEVENT_SWITCHEDTOCONTROL           = 0x00001966,
    DISPID_WMPOCXEVENT_PLAYERDOCKEDSTATECHANGE     = 0x00001967,
    DISPID_WMPOCXEVENT_PLAYERRECONNECT             = 0x00001968,
    DISPID_WMPOCXEVENT_CLICK                       = 0x00001969,
    DISPID_WMPOCXEVENT_DOUBLECLICK                 = 0x0000196a,
    DISPID_WMPOCXEVENT_KEYDOWN                     = 0x0000196b,
    DISPID_WMPOCXEVENT_KEYPRESS                    = 0x0000196c,
    DISPID_WMPOCXEVENT_KEYUP                       = 0x0000196d,
    DISPID_WMPOCXEVENT_MOUSEDOWN                   = 0x0000196e,
    DISPID_WMPOCXEVENT_MOUSEMOVE                   = 0x0000196f,
    DISPID_WMPOCXEVENT_MOUSEUP                     = 0x00001970,
    DISPID_WMPOCXEVENT_DEVICECONNECT               = 0x00001971,
    DISPID_WMPOCXEVENT_DEVICEDISCONNECT            = 0x00001972,
    DISPID_WMPOCXEVENT_DEVICESTATUSCHANGE          = 0x00001973,
    DISPID_WMPOCXEVENT_DEVICESYNCSTATECHANGE       = 0x00001974,
    DISPID_WMPOCXEVENT_DEVICESYNCERROR             = 0x00001975,
    DISPID_WMPOCXEVENT_CREATEPARTNERSHIPCOMPLETE   = 0x00001976,
    DISPID_WMPOCXEVENT_CDROMRIPSTATECHANGE         = 0x00001977,
    DISPID_WMPOCXEVENT_CDROMRIPMEDIAERROR          = 0x00001978,
    DISPID_WMPOCXEVENT_CDROMBURNSTATECHANGE        = 0x00001979,
    DISPID_WMPOCXEVENT_CDROMBURNMEDIAERROR         = 0x0000197a,
    DISPID_WMPOCXEVENT_CDROMBURNERROR              = 0x0000197b,
    DISPID_WMPOCXEVENT_LIBRARYCONNECT              = 0x0000197c,
    DISPID_WMPOCXEVENT_LIBRARYDISCONNECT           = 0x0000197d,
    DISPID_WMPOCXEVENT_FOLDERSCANSTATECHANGE       = 0x0000197e,
    DISPID_WMPOCXEVENT_DEVICEESTIMATION            = 0x0000197f,
}

enum : uint
{
    DISPID_WMPCONTROLS_BASE        = 0x00000032,
    DISPID_WMPSETTINGS_BASE        = 0x00000064,
    DISPID_WMPPLAYLIST_BASE        = 0x000000c8,
    DISPID_WMPCDROM_BASE           = 0x000000fa,
    DISPID_WMPCDROMCOLLECTION_BASE = 0x0000012c,
}

enum uint DISPID_WMPSTRINGCOLLECTION_BASE = 0x00000190;
enum uint DISPID_WMPMEDIACOLLECTION_BASE = 0x000001c2;

enum : uint
{
    DISPID_WMPPLAYLISTARRAY_BASE      = 0x000001f4,
    DISPID_WMPPLAYLISTCOLLECTION_BASE = 0x00000226,
}

enum : uint
{
    DISPID_WMPMEDIA_BASE         = 0x000002ee,
    DISPID_WMPNETWORK_BASE       = 0x00000320,
    DISPID_WMPERROR_BASE         = 0x00000352,
    DISPID_WMPERRORITEM_BASE     = 0x00000384,
    DISPID_WMPCLOSEDCAPTION_BASE = 0x000003b6,
}

enum : uint
{
    DISPID_WMPDVD_BASE                = 0x000003e8,
    DISPID_WMPMETADATA_BASE           = 0x0000041a,
    DISPID_WMPPLAYERAPP_BASE          = 0x0000044c,
    DISPID_WMPDOWNLOADMANAGER_BASE    = 0x0000047e,
    DISPID_WMPDOWNLOADCOLLECTION_BASE = 0x000004b0,
    DISPID_WMPDOWNLOADITEM_BASE       = 0x000004e2,
    DISPID_WMPDOWNLOADITEM2_BASE      = 0x00000514,
}

enum : uint
{
    DISPID_WMPQUERY_BASE            = 0x00000546,
    DISPID_WMPMEDIACOLLECTION2_BASE = 0x00000578,
}

enum uint DISPID_WMPSTRINGCOLLECTION2_BASE = 0x000005aa;

enum : GUID
{
    CLSID_WMPSkinManager          = GUID("b2a7fd52-301f-4348-b93a-638c6de49229"),
    CLSID_WMPMediaPluginRegistrar = GUID("5569e7f5-424b-4b93-89ca-79d17924689a"),
}

enum : GUID
{
    WMP_PLUGINTYPE_DSP           = GUID("6434baea-4954-498d-abd5-2b07123e1f04"),
    WMP_PLUGINTYPE_DSP_OUTOFPROC = GUID("ef29b174-c347-44cc-9a4f-2399118ff38c"),
    WMP_PLUGINTYPE_RENDERING     = GUID("a8554541-115d-406a-a4c7-51111c330183"),
}

enum : float
{
    kfltTimedLevelMaximumFrequency = 0x1.5888p+14,
    kfltTimedLevelMinimumFrequency = 0x1.4p+4,
}

enum : const(wchar)*
{
    g_szContentPartnerInfo_LoginState                       = "LoginState",
    g_szContentPartnerInfo_MediaPlayerAccountType           = "MediaPlayerAccountType",
    g_szContentPartnerInfo_AccountType                      = "AccountType",
    g_szContentPartnerInfo_HasCachedCredentials             = "HasCachedCredentials",
    g_szContentPartnerInfo_LicenseRefreshAdvanceWarning     = "LicenseRefreshAdvanceWarning",
    g_szContentPartnerInfo_PurchasedTrackRequiresReDownload = "PurchasedTrackRequiresReDownload",
    g_szContentPartnerInfo_MaximumTrackPurchasePerPurchase  = "MaximumNumberOfTracksPerPurchase",
    g_szContentPartnerInfo_AccountBalance                   = "AccountBalance",
    g_szContentPartnerInfo_UserName                         = "UserName",
}

enum : const(wchar)*
{
    g_szMediaPlayerTask_Burn   = "Burn",
    g_szMediaPlayerTask_Browse = "Browse",
    g_szMediaPlayerTask_Sync   = "Sync",
}

enum : const(wchar)*
{
    g_szItemInfo_PopupURL                 = "Popup",
    g_szItemInfo_AuthenticationSuccessURL = "AuthenticationSuccessURL",
}

enum : const(wchar)*
{
    g_szItemInfo_LoginFailureURL   = "LoginFailureURL",
    g_szItemInfo_HTMLViewURL       = "HTMLViewURL",
    g_szItemInfo_PopupCaption      = "PopupCaption",
    g_szItemInfo_ALTLoginURL       = "ALTLoginURL",
    g_szItemInfo_ALTLoginCaption   = "ALTLoginCaption",
    g_szItemInfo_ForgetPasswordURL = "ForgotPassword",
    g_szItemInfo_CreateAccountURL  = "CreateAccount",
    g_szItemInfo_ArtistArtURL      = "ArtistArt",
    g_szItemInfo_AlbumArtURL       = "AlbumArt",
    g_szItemInfo_ListArtURL        = "ListArt",
    g_szItemInfo_GenreArtURL       = "GenreArt",
    g_szItemInfo_SubGenreArtURL    = "SubGenreArt",
    g_szItemInfo_RadioArtURL       = "RadioArt",
    g_szItemInfo_TreeListIconURL   = "CPListIDIcon",
    g_szItemInfo_ErrorDescription  = "CPErrorDescription",
    g_szItemInfo_ErrorURL          = "CPErrorURL",
    g_szItemInfo_ErrorURLLinkText  = "CPErrorURLLinkText",
}

enum const(wchar)* g_szUnknownLocation = "UnknownLocation";
enum const(wchar)* g_szRootLocation = "RootLocation";
enum const(wchar)* g_szFlyoutMenu = "FlyoutMenu";
enum const(wchar)* g_szOnlineStore = "OnlineStore";

enum : const(wchar)*
{
    g_szVideoRecent = "VideoRecent",
    g_szVideoRoot   = "VideoRoot",
}

enum const(wchar)* g_szCPListID = "CPListID";
enum const(wchar)* g_szAllCPListIDs = "AllCPListIDs";
enum const(wchar)* g_szCPTrackID = "CPTrackID";
enum const(wchar)* g_szAllCPTrackIDs = "AllCPTrackIDs";
enum const(wchar)* g_szCPArtistID = "CPArtistID";
enum const(wchar)* g_szAllCPArtistIDs = "AllCPArtistIDs";
enum const(wchar)* g_szCPAlbumID = "CPAlbumID";
enum const(wchar)* g_szAllCPAlbumIDs = "AllCPAlbumIDs";
enum const(wchar)* g_szCPGenreID = "CPGenreID";
enum const(wchar)* g_szAllCPGenreIDs = "AllCPGenreIDs";
enum const(wchar)* g_szCPAlbumSubGenreID = "CPAlbumSubGenreID";
enum const(wchar)* g_szAllCPAlbumSubGenreIDs = "AllCPAlbumSubGenreIDs";
enum const(wchar)* g_szReleaseDateYear = "ReleaseDateYear";
enum const(wchar)* g_szAllReleaseDateYears = "AllReleaseDateYears";
enum const(wchar)* g_szCPRadioID = "CPRadioID";
enum const(wchar)* g_szAllCPRadioIDs = "AllCPRadioIDs";

enum : const(wchar)*
{
    g_szAuthor     = "Author",
    g_szAllAuthors = "AllAuthors",
}

enum const(wchar)* g_szWMParentalRating = "WMParentalRating";
enum const(wchar)* g_szAllWMParentalRatings = "AllWMParentalRatings";
enum const(wchar)* g_szAllUserEffectiveRatingStarss = "AllUserEffectiveRatingStarss";
enum const(wchar)* g_szUserEffectiveRatingStars = "UserEffectiveRatingStars";
enum const(wchar)* g_szUserPlaylist = "UserPlaylist";

enum : const(wchar)*
{
    g_szViewMode_Report      = "ViewModeReport",
    g_szViewMode_Details     = "ViewModeDetails",
    g_szViewMode_Icon        = "ViewModeIcon",
    g_szViewMode_Tile        = "ViewModeTile",
    g_szViewMode_OrderedList = "ViewModeOrderedList",
}

enum : const(wchar)*
{
    g_szContentPrice_Unknown   = "PriceUnknown",
    g_szContentPrice_CannotBuy = "PriceCannotBuy",
    g_szContentPrice_Free      = "PriceFree",
}

enum : const(wchar)*
{
    g_szRefreshLicensePlay = "RefreshForPlay",
    g_szRefreshLicenseBurn = "RefreshForBurn",
    g_szRefreshLicenseSync = "RefreshForSync",
}

enum const(wchar)* g_szVerifyPermissionSync = "VerifyPermissionSync";

enum : const(wchar)*
{
    g_szStationEvent_Started  = "TrackStarted",
    g_szStationEvent_Complete = "TrackComplete",
    g_szStationEvent_Skipped  = "TrackSkipped",
}

enum : GUID
{
    WMProfile_V40_DialUpMBR              = GUID("fd7f47f1-72a6-45a4-80f0-3aecefc32c07"),
    WMProfile_V40_IntranetMBR            = GUID("82cd3321-a94a-4ffc-9c2b-092c10ca16e7"),
    WMProfile_V40_2856100MBR             = GUID("5a1c2206-dc5e-4186-beb2-4c5a994b132e"),
    WMProfile_V40_6VoiceAudio            = GUID("d508978a-11a0-4d15-b0da-acdc99d4f890"),
    WMProfile_V40_16AMRadio              = GUID("0f4be81f-d57d-41e1-b2e3-2fad986bfec2"),
    WMProfile_V40_288FMRadioMono         = GUID("7fa57fc8-6ea4-4645-8abf-b6e5a8f814a1"),
    WMProfile_V40_288FMRadioStereo       = GUID("22fcf466-aa40-431f-a289-06d0ea1a1e40"),
    WMProfile_V40_56DialUpStereo         = GUID("e8026f87-e905-4594-a3c7-00d00041d1d9"),
    WMProfile_V40_64Audio                = GUID("4820b3f7-cbec-41dc-9391-78598714c8e5"),
    WMProfile_V40_96Audio                = GUID("0efa0ee3-9e64-41e2-837f-3c0038f327ba"),
    WMProfile_V40_128Audio               = GUID("93ddbe12-13dc-4e32-a35e-40378e34279a"),
    WMProfile_V40_288VideoVoice          = GUID("bb2bc274-0eb6-4da9-b550-ecf7f2b9948f"),
    WMProfile_V40_288VideoAudio          = GUID("ac617f2d-6cbe-4e84-8e9a-ce151a12a354"),
    WMProfile_V40_288VideoWebServer      = GUID("abf2f00d-d555-4815-94ce-8275f3a70bfe"),
    WMProfile_V40_56DialUpVideo          = GUID("e21713bb-652f-4dab-99de-71e04400270f"),
    WMProfile_V40_56DialUpVideoWebServer = GUID("b756ff10-520f-4749-a399-b780e2fc9250"),
}

enum : GUID
{
    WMProfile_V40_100Video             = GUID("8f99ddd8-6684-456b-a0a3-33e1316895f0"),
    WMProfile_V40_250Video             = GUID("541841c3-9339-4f7b-9a22-b11540894e42"),
    WMProfile_V40_512Video             = GUID("70440e6d-c4ef-4f84-8cd0-d5c28686e784"),
    WMProfile_V40_1MBVideo             = GUID("b4482a4c-cc17-4b07-a94e-9818d5e0f13f"),
    WMProfile_V40_3MBVideo             = GUID("55374ac0-309b-4396-b88f-e6e292113f28"),
    WMProfile_V70_DialUpMBR            = GUID("5b16e74b-4068-45b5-b80e-7bf8c80d2c2f"),
    WMProfile_V70_IntranetMBR          = GUID("045880dc-34b6-4ca9-a326-73557ed143f3"),
    WMProfile_V70_2856100MBR           = GUID("07df7a25-3fe2-4a5b-8b1e-348b0721ca70"),
    WMProfile_V70_288VideoVoice        = GUID("b952f38e-7dbc-4533-a9ca-b00b1c6e9800"),
    WMProfile_V70_288VideoAudio        = GUID("58bba0ee-896a-4948-9953-85b736f83947"),
    WMProfile_V70_288VideoWebServer    = GUID("70a32e2b-e2df-4ebd-9105-d9ca194a2d50"),
    WMProfile_V70_56VideoWebServer     = GUID("def99e40-57bc-4ab3-b2d1-b6e3caf64257"),
    WMProfile_V70_64VideoISDN          = GUID("c2b7a7e9-7b8e-4992-a1a1-068217a3b311"),
    WMProfile_V70_100Video             = GUID("d9f3c932-5ea9-4c6d-89b4-2686e515426e"),
    WMProfile_V70_256Video             = GUID("afe69b3a-403f-4a1b-8007-0e21cfb3df84"),
    WMProfile_V70_384Video             = GUID("f3d45fbb-8782-44df-97c6-8678e2f9b13d"),
    WMProfile_V70_768Video             = GUID("0326ebb6-f76e-4964-b0db-e729978d35ee"),
    WMProfile_V70_1500Video            = GUID("0b89164a-5490-4686-9e37-5a80884e5146"),
    WMProfile_V70_2000Video            = GUID("aa980124-bf10-4e4f-9afd-4329a7395cff"),
    WMProfile_V70_700FilmContentVideo  = GUID("7a747920-2449-4d76-99cb-fdb0c90484d4"),
    WMProfile_V70_1500FilmContentVideo = GUID("f6a5f6df-ee3f-434c-a433-523ce55f516b"),
    WMProfile_V70_6VoiceAudio          = GUID("eaba9fbf-b64f-49b3-aa0c-73fbdd150ad0"),
    WMProfile_V70_288FMRadioMono       = GUID("c012a833-a03b-44a5-96dc-ed95cc65582d"),
    WMProfile_V70_288FMRadioStereo     = GUID("e96d67c9-1a39-4dc4-b900-b1184dc83620"),
    WMProfile_V70_56DialUpStereo       = GUID("674ee767-0949-4fac-875e-f4c9c292013b"),
    WMProfile_V70_64AudioISDN          = GUID("91dea458-9d60-4212-9c59-d40919c939e4"),
    WMProfile_V70_64Audio              = GUID("b29cffc6-f131-41db-b5e8-99d8b0b945f4"),
    WMProfile_V70_96Audio              = GUID("a9d4b819-16cc-4a59-9f37-693dbb0302d6"),
    WMProfile_V70_128Audio             = GUID("c64cf5da-df45-40d3-8027-de698d68dc66"),
    WMProfile_V70_225VideoPDA          = GUID("f55ea573-4c02-42b5-9026-a8260c438a9f"),
    WMProfile_V70_150VideoPDA          = GUID("0f472967-e3c6-4797-9694-f0304c5e2f17"),
    WMProfile_V80_255VideoPDA          = GUID("feedbcdf-3fac-4c93-ac0d-47941ec72c0b"),
    WMProfile_V80_150VideoPDA          = GUID("aee16dfa-2c14-4a2f-ad3f-a3034031784f"),
    WMProfile_V80_28856VideoMBR        = GUID("d66920c4-c21f-4ec8-a0b4-95cf2bd57fc4"),
    WMProfile_V80_100768VideoMBR       = GUID("5bdb5a0e-979e-47d3-9596-73b386392a55"),
    WMProfile_V80_288100VideoMBR       = GUID("d8722c69-2419-4b36-b4e0-6e17b60564e5"),
    WMProfile_V80_288Video             = GUID("3df678d9-1352-4186-bbf8-74f0c19b6ae2"),
    WMProfile_V80_56Video              = GUID("254e8a96-2612-405c-8039-f0bf725ced7d"),
    WMProfile_V80_100Video             = GUID("a2e300b4-c2d4-4fc0-b5dd-ecbd948dc0df"),
    WMProfile_V80_256Video             = GUID("bbc75500-33d2-4466-b86b-122b201cc9ae"),
    WMProfile_V80_384Video             = GUID("29b00c2b-09a9-48bd-ad09-cdae117d1da7"),
    WMProfile_V80_768Video             = GUID("74d01102-e71a-4820-8f0d-13d2ec1e4872"),
    WMProfile_V80_700NTSCVideo         = GUID("c8c2985f-e5d9-4538-9e23-9b21bf78f745"),
    WMProfile_V80_1400NTSCVideo        = GUID("931d1bee-617a-4bcd-9905-ccd0786683ee"),
    WMProfile_V80_384PALVideo          = GUID("9227c692-ae62-4f72-a7ea-736062d0e21e"),
    WMProfile_V80_700PALVideo          = GUID("ec298949-639b-45e2-96fd-4ab32d5919c2"),
    WMProfile_V80_288MonoAudio         = GUID("7ea3126d-e1ba-4716-89af-f65cee0c0c67"),
    WMProfile_V80_288StereoAudio       = GUID("7e4cab5c-35dc-45bb-a7c0-19b28070d0cc"),
    WMProfile_V80_32StereoAudio        = GUID("60907f9f-b352-47e5-b210-0ef1f47e9f9d"),
    WMProfile_V80_48StereoAudio        = GUID("5ee06be5-492b-480a-8a8f-12f373ecf9d4"),
    WMProfile_V80_64StereoAudio        = GUID("09bb5bc4-3176-457f-8dd6-3cd919123e2d"),
    WMProfile_V80_96StereoAudio        = GUID("1fc81930-61f2-436f-9d33-349f2a1c0f10"),
    WMProfile_V80_128StereoAudio       = GUID("407b9450-8bdc-4ee5-88b8-6f527bd941f2"),
    WMProfile_V80_288VideoOnly         = GUID("8c45b4c7-4aeb-4f78-a5ec-88420b9dadef"),
    WMProfile_V80_56VideoOnly          = GUID("6e2a6955-81df-4943-ba50-68a986a708f6"),
    WMProfile_V80_FAIRVBRVideo         = GUID("3510a862-5850-4886-835f-d78ec6a64042"),
    WMProfile_V80_HIGHVBRVideo         = GUID("0f10d9d3-3b04-4fb0-a3d3-88d4ac854acc"),
    WMProfile_V80_BESTVBRVideo         = GUID("048439ba-309c-440e-9cb4-3dcca3756423"),
}

// Structs


//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/effects/ns-effects-timedlevel))], [])
struct TimedLevel
{
    ubyte[2048] frequency;
    ubyte[2048] waveform;
    int         state;
    long        timeStamp;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/ns-contentpartner-wmpcontextmenuinfo))], [])
struct WMPContextMenuInfo
{
    uint dwID;
    BSTR bstrMenuText;
    BSTR bstrHelpText;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmpdevices/ns-wmpdevices-wmp_wmdm_metadata_round_trip_pc2device))], [])
struct WMP_WMDM_METADATA_ROUND_TRIP_PC2DEVICE
{
align (1):
    uint dwChangesSinceTransactionID;
    uint dwResultSetStartingIndex;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmpdevices/ns-wmpdevices-wmp_wmdm_metadata_round_trip_device2pc))], [])
struct WMP_WMDM_METADATA_ROUND_TRIP_DEVICE2PC
{
align (1):
    uint dwCurrentTransactionID;
    uint dwReturnedObjectCount;
    uint dwUnretrievedObjectCount;
    uint dwDeletedObjectStartingOffset;
    uint dwFlags;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/wchar[1] wsObjectPathnameList;
}

// Interfaces

@GUID("6bf52a50-394a-11d3-b153-00c04f79faa6")
struct WMPLib;

@GUID("df333473-2cf7-4be2-907f-9aad5661364f")
struct WMPRemoteMediaServices;

@GUID("6bf52a52-394a-11d3-b153-00c04f79faa6")
struct WindowsMediaPlayer;

@GUID("faeb54c4-f66f-4806-83a0-805299f5e3ad")
struct FeedsManager;

@GUID("281001ed-7765-4cb0-84af-e9b387af01ff")
struct FeedFolderWatcher;

@GUID("18a6737b-f433-4687-89bc-a1b4dfb9f123")
struct FeedWatcher;

@GUID("3614c646-3b3b-4de7-a81e-930e3f2127b3")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmperroritem))], [])
interface IWMPErrorItem : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmperroritem-get_errorcode))], [])
    HRESULT get_errorCode(int* phr);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmperroritem-get_errordescription))], [])
    HRESULT get_errorDescription(BSTR* pbstrDescription);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmperroritem-get_errorcontext))], [])
    HRESULT get_errorContext(VARIANT* pvarContext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmperroritem-get_remedy))], [])
    HRESULT get_remedy(int* plRemedy);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmperroritem-get_customurl))], [])
    HRESULT get_customUrl(BSTR* pbstrCustomUrl);
}

@GUID("a12dcf7d-14ab-4c1b-a8cd-63909f06025b")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmperror))], [])
interface IWMPError : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmperror-clearerrorqueue))], [])
    HRESULT clearErrorQueue();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmperror-get_errorcount))], [])
    HRESULT get_errorCount(int* plNumErrors);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmperror-get_item))], [])
    HRESULT get_item(int dwIndex, IWMPErrorItem* ppErrorItem);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmperror-webhelp))], [])
    HRESULT webHelp();
}

@GUID("94d55e95-3fac-11d3-b155-00c04f79faa6")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpmedia))], [])
interface IWMPMedia : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmedia-get_isidentical))], [])
    HRESULT get_isIdentical(IWMPMedia pIWMPMedia, VARIANT_BOOL* pvbool);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmedia-get_sourceurl))], [])
    HRESULT get_sourceURL(BSTR* pbstrSourceURL);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmedia-get_name))], [])
    HRESULT get_name(BSTR* pbstrName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmedia-put_name))], [])
    HRESULT put_name(BSTR bstrName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmedia-get_imagesourcewidth))], [])
    HRESULT get_imageSourceWidth(int* pWidth);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmedia-get_imagesourceheight))], [])
    HRESULT get_imageSourceHeight(int* pHeight);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmedia-get_markercount))], [])
    HRESULT get_markerCount(int* pMarkerCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmedia-getmarkertime))], [])
    HRESULT getMarkerTime(int MarkerNum, double* pMarkerTime);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmedia-getmarkername))], [])
    HRESULT getMarkerName(int MarkerNum, BSTR* pbstrMarkerName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmedia-get_duration))], [])
    HRESULT get_duration(double* pDuration);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmedia-get_durationstring))], [])
    HRESULT get_durationString(BSTR* pbstrDuration);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmedia-get_attributecount))], [])
    HRESULT get_attributeCount(int* plCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmedia-getattributename))], [])
    HRESULT getAttributeName(int lIndex, BSTR* pbstrItemName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmedia-getiteminfo))], [])
    HRESULT getItemInfo(BSTR bstrItemName, BSTR* pbstrVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmedia-setiteminfo))], [])
    HRESULT setItemInfo(BSTR bstrItemName, BSTR bstrVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmedia-getiteminfobyatom))], [])
    HRESULT getItemInfoByAtom(int lAtom, BSTR* pbstrVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmedia-ismemberof))], [])
    HRESULT isMemberOf(IWMPPlaylist pPlaylist, VARIANT_BOOL* pvarfIsMemberOf);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmedia-isreadonlyitem))], [])
    HRESULT isReadOnlyItem(BSTR bstrItemName, VARIANT_BOOL* pvarfIsReadOnly);
}

@GUID("74c09e02-f828-11d2-a74b-00a0c905f36e")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpcontrols))], [])
interface IWMPControls : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols-get_isavailable))], [])
    HRESULT get_isAvailable(BSTR bstrItem, VARIANT_BOOL* pIsAvailable);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols-play))], [])
    HRESULT play();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols-stop))], [])
    HRESULT stop();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols-pause))], [])
    HRESULT pause();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols-fastforward))], [])
    HRESULT fastForward();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols-fastreverse))], [])
    HRESULT fastReverse();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols-get_currentposition))], [])
    HRESULT get_currentPosition(double* pdCurrentPosition);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols-put_currentposition))], [])
    HRESULT put_currentPosition(double dCurrentPosition);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols-get_currentpositionstring))], [])
    HRESULT get_currentPositionString(BSTR* pbstrCurrentPosition);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols-next))], [])
    HRESULT next();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols-previous))], [])
    HRESULT previous();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols-get_currentitem))], [])
    HRESULT get_currentItem(IWMPMedia* ppIWMPMedia);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols-put_currentitem))], [])
    HRESULT put_currentItem(IWMPMedia pIWMPMedia);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols-get_currentmarker))], [])
    HRESULT get_currentMarker(int* plMarker);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols-put_currentmarker))], [])
    HRESULT put_currentMarker(int lMarker);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols-playitem))], [])
    HRESULT playItem(IWMPMedia pIWMPMedia);
}

@GUID("9104d1ab-80c9-4fed-abf0-2e6417a6df14")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpsettings))], [])
interface IWMPSettings : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings-get_isavailable))], [])
    HRESULT get_isAvailable(BSTR bstrItem, VARIANT_BOOL* pIsAvailable);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings-get_autostart))], [])
    HRESULT get_autoStart(VARIANT_BOOL* pfAutoStart);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings-put_autostart))], [])
    HRESULT put_autoStart(VARIANT_BOOL fAutoStart);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings-get_baseurl))], [])
    HRESULT get_baseURL(BSTR* pbstrBaseURL);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings-put_baseurl))], [])
    HRESULT put_baseURL(BSTR bstrBaseURL);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings-get_defaultframe))], [])
    HRESULT get_defaultFrame(BSTR* pbstrDefaultFrame);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings-put_defaultframe))], [])
    HRESULT put_defaultFrame(BSTR bstrDefaultFrame);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings-get_invokeurls))], [])
    HRESULT get_invokeURLs(VARIANT_BOOL* pfInvokeURLs);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings-put_invokeurls))], [])
    HRESULT put_invokeURLs(VARIANT_BOOL fInvokeURLs);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings-get_mute))], [])
    HRESULT get_mute(VARIANT_BOOL* pfMute);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings-put_mute))], [])
    HRESULT put_mute(VARIANT_BOOL fMute);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings-get_playcount))], [])
    HRESULT get_playCount(int* plCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings-put_playcount))], [])
    HRESULT put_playCount(int lCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings-get_rate))], [])
    HRESULT get_rate(double* pdRate);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings-put_rate))], [])
    HRESULT put_rate(double dRate);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings-get_balance))], [])
    HRESULT get_balance(int* plBalance);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings-put_balance))], [])
    HRESULT put_balance(int lBalance);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings-get_volume))], [])
    HRESULT get_volume(int* plVolume);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings-put_volume))], [])
    HRESULT put_volume(int lVolume);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings-getmode))], [])
    HRESULT getMode(BSTR bstrMode, VARIANT_BOOL* pvarfMode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings-setmode))], [])
    HRESULT setMode(BSTR bstrMode, VARIANT_BOOL varfMode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings-get_enableerrordialogs))], [])
    HRESULT get_enableErrorDialogs(VARIANT_BOOL* pfEnableErrorDialogs);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings-put_enableerrordialogs))], [])
    HRESULT put_enableErrorDialogs(VARIANT_BOOL fEnableErrorDialogs);
}

@GUID("4f2df574-c588-11d3-9ed0-00c04fb6e937")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpclosedcaption))], [])
interface IWMPClosedCaption : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpclosedcaption-get_samistyle))], [])
    HRESULT get_SAMIStyle(BSTR* pbstrSAMIStyle);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpclosedcaption-put_samistyle))], [])
    HRESULT put_SAMIStyle(BSTR bstrSAMIStyle);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpclosedcaption-get_samilang))], [])
    HRESULT get_SAMILang(BSTR* pbstrSAMILang);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpclosedcaption-put_samilang))], [])
    HRESULT put_SAMILang(BSTR bstrSAMILang);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpclosedcaption-get_samifilename))], [])
    HRESULT get_SAMIFileName(BSTR* pbstrSAMIFileName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpclosedcaption-put_samifilename))], [])
    HRESULT put_SAMIFileName(BSTR bstrSAMIFileName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpclosedcaption-get_captioningid))], [])
    HRESULT get_captioningId(BSTR* pbstrCaptioningID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpclosedcaption-put_captioningid))], [])
    HRESULT put_captioningId(BSTR bstrCaptioningID);
}

@GUID("d5f0f4f1-130c-11d3-b14e-00c04f79faa6")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpplaylist))], [])
interface IWMPPlaylist : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplaylist-get_count))], [])
    HRESULT get_count(int* plCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplaylist-get_name))], [])
    HRESULT get_name(BSTR* pbstrName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplaylist-put_name))], [])
    HRESULT put_name(BSTR bstrName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplaylist-get_attributecount))], [])
    HRESULT get_attributeCount(int* plCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplaylist-get_attributename))], [])
    HRESULT get_attributeName(int lIndex, BSTR* pbstrAttributeName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplaylist-get_item))], [])
    HRESULT get_item(int lIndex, IWMPMedia* ppIWMPMedia);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplaylist-getiteminfo))], [])
    HRESULT getItemInfo(BSTR bstrName, BSTR* pbstrVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplaylist-setiteminfo))], [])
    HRESULT setItemInfo(BSTR bstrName, BSTR bstrValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplaylist-get_isidentical))], [])
    HRESULT get_isIdentical(IWMPPlaylist pIWMPPlaylist, VARIANT_BOOL* pvbool);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplaylist-clear))], [])
    HRESULT clear();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplaylist-insertitem))], [])
    HRESULT insertItem(int lIndex, IWMPMedia pIWMPMedia);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplaylist-appenditem))], [])
    HRESULT appendItem(IWMPMedia pIWMPMedia);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplaylist-removeitem))], [])
    HRESULT removeItem(IWMPMedia pIWMPMedia);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplaylist-moveitem))], [])
    HRESULT moveItem(int lIndexOld, int lIndexNew);
}

@GUID("cfab6e98-8730-11d3-b388-00c04f68574b")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpcdrom))], [])
interface IWMPCdrom : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcdrom-get_drivespecifier))], [])
    HRESULT get_driveSpecifier(BSTR* pbstrDrive);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcdrom-get_playlist))], [])
    HRESULT get_playlist(IWMPPlaylist* ppPlaylist);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcdrom-eject))], [])
    HRESULT eject();
}

@GUID("ee4c8fe2-34b2-11d3-a3bf-006097c9b344")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpcdromcollection))], [])
interface IWMPCdromCollection : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcdromcollection-get_count))], [])
    HRESULT get_count(int* plCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcdromcollection-item))], [])
    HRESULT item(int lIndex, IWMPCdrom* ppItem);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcdromcollection-getbydrivespecifier))], [])
    HRESULT getByDriveSpecifier(BSTR bstrDriveSpecifier, IWMPCdrom* ppCdrom);
}

@GUID("4a976298-8c0d-11d3-b389-00c04f68574b")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpstringcollection))], [])
interface IWMPStringCollection : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpstringcollection-get_count))], [])
    HRESULT get_count(int* plCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpstringcollection-item))], [])
    HRESULT item(int lIndex, BSTR* pbstrString);
}

@GUID("8363bc22-b4b4-4b19-989d-1cd765749dd1")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpmediacollection))], [])
interface IWMPMediaCollection : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmediacollection-add))], [])
    HRESULT add(BSTR bstrURL, IWMPMedia* ppItem);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmediacollection-getall))], [])
    HRESULT getAll(IWMPPlaylist* ppMediaItems);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmediacollection-getbyname))], [])
    HRESULT getByName(BSTR bstrName, IWMPPlaylist* ppMediaItems);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmediacollection-getbygenre))], [])
    HRESULT getByGenre(BSTR bstrGenre, IWMPPlaylist* ppMediaItems);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmediacollection-getbyauthor))], [])
    HRESULT getByAuthor(BSTR bstrAuthor, IWMPPlaylist* ppMediaItems);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmediacollection-getbyalbum))], [])
    HRESULT getByAlbum(BSTR bstrAlbum, IWMPPlaylist* ppMediaItems);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmediacollection-getbyattribute))], [])
    HRESULT getByAttribute(BSTR bstrAttribute, BSTR bstrValue, IWMPPlaylist* ppMediaItems);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmediacollection-remove))], [])
    HRESULT remove(IWMPMedia pItem, VARIANT_BOOL varfDeleteFile);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmediacollection-getattributestringcollection))], [])
    HRESULT getAttributeStringCollection(BSTR bstrAttribute, BSTR bstrMediaType, 
                                         IWMPStringCollection* ppStringCollection);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmediacollection-getmediaatom))], [])
    HRESULT getMediaAtom(BSTR bstrItemName, int* plAtom);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmediacollection-setdeleted))], [])
    HRESULT setDeleted(IWMPMedia pItem, VARIANT_BOOL varfIsDeleted);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpmediacollection))], [])
    HRESULT isDeleted(IWMPMedia pItem, VARIANT_BOOL* pvarfIsDeleted);
}

@GUID("679409c0-99f7-11d3-9fb7-00105aa620bb")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpplaylistarray))], [])
interface IWMPPlaylistArray : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplaylistarray-get_count))], [])
    HRESULT get_count(int* plCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplaylistarray-item))], [])
    HRESULT item(int lIndex, IWMPPlaylist* ppItem);
}

@GUID("10a13217-23a7-439b-b1c0-d847c79b7774")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpplaylistcollection))], [])
interface IWMPPlaylistCollection : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplaylistcollection-newplaylist))], [])
    HRESULT newPlaylist(BSTR bstrName, IWMPPlaylist* ppItem);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplaylistcollection-getall))], [])
    HRESULT getAll(IWMPPlaylistArray* ppPlaylistArray);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplaylistcollection-getbyname))], [])
    HRESULT getByName(BSTR bstrName, IWMPPlaylistArray* ppPlaylistArray);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplaylistcollection-remove))], [])
    HRESULT remove(IWMPPlaylist pItem);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpplaylistcollection))], [])
    HRESULT setDeleted(IWMPPlaylist pItem, VARIANT_BOOL varfIsDeleted);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplaylistcollection-isdeleted))], [])
    HRESULT isDeleted(IWMPPlaylist pItem, VARIANT_BOOL* pvarfIsDeleted);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplaylistcollection-importplaylist))], [])
    HRESULT importPlaylist(IWMPPlaylist pItem, IWMPPlaylist* ppImportedItem);
}

@GUID("ec21b779-edef-462d-bba4-ad9dde2b29a7")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpnetwork))], [])
interface IWMPNetwork : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-get_bandwidth))], [])
    HRESULT get_bandWidth(int* plBandwidth);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-get_recoveredpackets))], [])
    HRESULT get_recoveredPackets(int* plRecoveredPackets);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-get_sourceprotocol))], [])
    HRESULT get_sourceProtocol(BSTR* pbstrSourceProtocol);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-get_receivedpackets))], [])
    HRESULT get_receivedPackets(int* plReceivedPackets);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-get_lostpackets))], [])
    HRESULT get_lostPackets(int* plLostPackets);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-get_receptionquality))], [])
    HRESULT get_receptionQuality(int* plReceptionQuality);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-get_bufferingcount))], [])
    HRESULT get_bufferingCount(int* plBufferingCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-get_bufferingprogress))], [])
    HRESULT get_bufferingProgress(int* plBufferingProgress);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-get_bufferingtime))], [])
    HRESULT get_bufferingTime(int* plBufferingTime);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-put_bufferingtime))], [])
    HRESULT put_bufferingTime(int lBufferingTime);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-get_framerate))], [])
    HRESULT get_frameRate(int* plFrameRate);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-get_maxbitrate))], [])
    HRESULT get_maxBitRate(int* plBitRate);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-get_bitrate))], [])
    HRESULT get_bitRate(int* plBitRate);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-getproxysettings))], [])
    HRESULT getProxySettings(BSTR bstrProtocol, int* plProxySetting);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-setproxysettings))], [])
    HRESULT setProxySettings(BSTR bstrProtocol, int lProxySetting);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-getproxyname))], [])
    HRESULT getProxyName(BSTR bstrProtocol, BSTR* pbstrProxyName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-setproxyname))], [])
    HRESULT setProxyName(BSTR bstrProtocol, BSTR bstrProxyName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-getproxyport))], [])
    HRESULT getProxyPort(BSTR bstrProtocol, int* lProxyPort);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-setproxyport))], [])
    HRESULT setProxyPort(BSTR bstrProtocol, int lProxyPort);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-getproxyexceptionlist))], [])
    HRESULT getProxyExceptionList(BSTR bstrProtocol, BSTR* pbstrExceptionList);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-setproxyexceptionlist))], [])
    HRESULT setProxyExceptionList(BSTR bstrProtocol, BSTR pbstrExceptionList);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-getproxybypassforlocal))], [])
    HRESULT getProxyBypassForLocal(BSTR bstrProtocol, VARIANT_BOOL* pfBypassForLocal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-setproxybypassforlocal))], [])
    HRESULT setProxyBypassForLocal(BSTR bstrProtocol, VARIANT_BOOL fBypassForLocal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-get_maxbandwidth))], [])
    HRESULT get_maxBandwidth(int* lMaxBandwidth);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-put_maxbandwidth))], [])
    HRESULT put_maxBandwidth(int lMaxBandwidth);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-get_downloadprogress))], [])
    HRESULT get_downloadProgress(int* plDownloadProgress);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-get_encodedframerate))], [])
    HRESULT get_encodedFrameRate(int* plFrameRate);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-get_framesskipped))], [])
    HRESULT get_framesSkipped(int* plFrames);
}

@GUID("d84cca99-cce2-11d2-9ecc-0000f8085981")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpcore))], [])
interface IWMPCore : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcore-close))], [])
    HRESULT close();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcore-get_url))], [])
    HRESULT get_URL(BSTR* pbstrURL);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcore-put_url))], [])
    HRESULT put_URL(BSTR bstrURL);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcore-get_openstate))], [])
    HRESULT get_openState(WMPOpenState* pwmpos);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcore-get_playstate))], [])
    HRESULT get_playState(WMPPlayState* pwmpps);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcore-get_controls))], [])
    HRESULT get_controls(IWMPControls* ppControl);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcore-get_settings))], [])
    HRESULT get_settings(IWMPSettings* ppSettings);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcore-get_currentmedia))], [])
    HRESULT get_currentMedia(IWMPMedia* ppMedia);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcore-put_currentmedia))], [])
    HRESULT put_currentMedia(IWMPMedia pMedia);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcore-get_mediacollection))], [])
    HRESULT get_mediaCollection(IWMPMediaCollection* ppMediaCollection);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcore-get_playlistcollection))], [])
    HRESULT get_playlistCollection(IWMPPlaylistCollection* ppPlaylistCollection);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcore-get_versioninfo))], [])
    HRESULT get_versionInfo(BSTR* pbstrVersionInfo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcore-launchurl))], [])
    HRESULT launchURL(BSTR bstrURL);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcore-get_network))], [])
    HRESULT get_network(IWMPNetwork* ppQNI);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcore-get_currentplaylist))], [])
    HRESULT get_currentPlaylist(IWMPPlaylist* ppPL);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcore-put_currentplaylist))], [])
    HRESULT put_currentPlaylist(IWMPPlaylist pPL);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcore-get_cdromcollection))], [])
    HRESULT get_cdromCollection(IWMPCdromCollection* ppCdromCollection);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcore-get_closedcaption))], [])
    HRESULT get_closedCaption(IWMPClosedCaption* ppClosedCaption);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcore-get_isonline))], [])
    HRESULT get_isOnline(VARIANT_BOOL* pfOnline);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcore-get_error))], [])
    HRESULT get_error(IWMPError* ppError);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcore-get_status))], [])
    HRESULT get_status(BSTR* pbstrStatus);
}

@GUID("6bf52a4f-394a-11d3-b153-00c04f79faa6")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpplayer))], [])
interface IWMPPlayer : IWMPCore
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplayer-get_enabled))], [])
    HRESULT get_enabled(VARIANT_BOOL* pbEnabled);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplayer-put_enabled))], [])
    HRESULT put_enabled(VARIANT_BOOL bEnabled);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplayer-get_fullscreen))], [])
    HRESULT get_fullScreen(VARIANT_BOOL* pbFullScreen);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplayer-put_fullscreen))], [])
    HRESULT put_fullScreen(VARIANT_BOOL bFullScreen);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplayer-get_enablecontextmenu))], [])
    HRESULT get_enableContextMenu(VARIANT_BOOL* pbEnableContextMenu);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplayer-put_enablecontextmenu))], [])
    HRESULT put_enableContextMenu(VARIANT_BOOL bEnableContextMenu);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplayer-put_uimode))], [])
    HRESULT put_uiMode(BSTR bstrMode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplayer-get_uimode))], [])
    HRESULT get_uiMode(BSTR* pbstrMode);
}

@GUID("0e6b01d1-d407-4c85-bf5f-1c01f6150280")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpplayer2))], [])
interface IWMPPlayer2 : IWMPCore
{
    HRESULT get_enabled(VARIANT_BOOL* pbEnabled);
    HRESULT put_enabled(VARIANT_BOOL bEnabled);
    HRESULT get_fullScreen(VARIANT_BOOL* pbFullScreen);
    HRESULT put_fullScreen(VARIANT_BOOL bFullScreen);
    HRESULT get_enableContextMenu(VARIANT_BOOL* pbEnableContextMenu);
    HRESULT put_enableContextMenu(VARIANT_BOOL bEnableContextMenu);
    HRESULT put_uiMode(BSTR bstrMode);
    HRESULT get_uiMode(BSTR* pbstrMode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplayer2-get_stretchtofit))], [])
    HRESULT get_stretchToFit(VARIANT_BOOL* pbEnabled);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplayer2-put_stretchtofit))], [])
    HRESULT put_stretchToFit(VARIANT_BOOL bEnabled);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplayer2-get_windowlessvideo))], [])
    HRESULT get_windowlessVideo(VARIANT_BOOL* pbEnabled);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplayer2-put_windowlessvideo))], [])
    HRESULT put_windowlessVideo(VARIANT_BOOL bEnabled);
}

@GUID("ab7c88bb-143e-4ea4-acc3-e4350b2106c3")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpmedia2))], [])
interface IWMPMedia2 : IWMPMedia
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmedia2-get_error))], [])
    HRESULT get_error(IWMPErrorItem* ppIWMPErrorItem);
}

@GUID("6f030d25-0890-480f-9775-1f7e40ab5b8e")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpcontrols2))], [])
interface IWMPControls2 : IWMPControls
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols2-step))], [])
    HRESULT step(int lStep);
}

@GUID("8da61686-4668-4a5c-ae5d-803193293dbe")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpdvd))], [])
interface IWMPDVD : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpdvd-get_isavailable))], [])
    HRESULT get_isAvailable(BSTR bstrItem, VARIANT_BOOL* pIsAvailable);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpdvd-get_domain))], [])
    HRESULT get_domain(BSTR* strDomain);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpdvd-topmenu))], [])
    HRESULT topMenu();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpdvd-titlemenu))], [])
    HRESULT titleMenu();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpdvd-back))], [])
    HRESULT back();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpdvd-resume))], [])
    HRESULT resume();
}

@GUID("bc17e5b7-7561-4c18-bb90-17d485775659")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpcore2))], [])
interface IWMPCore2 : IWMPCore
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcore2-get_dvd))], [])
    HRESULT get_dvd(IWMPDVD* ppDVD);
}

@GUID("54062b68-052a-4c25-a39f-8b63346511d4")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpplayer3))], [])
interface IWMPPlayer3 : IWMPCore2
{
    HRESULT get_enabled(VARIANT_BOOL* pbEnabled);
    HRESULT put_enabled(VARIANT_BOOL bEnabled);
    HRESULT get_fullScreen(VARIANT_BOOL* pbFullScreen);
    HRESULT put_fullScreen(VARIANT_BOOL bFullScreen);
    HRESULT get_enableContextMenu(VARIANT_BOOL* pbEnableContextMenu);
    HRESULT put_enableContextMenu(VARIANT_BOOL bEnableContextMenu);
    HRESULT put_uiMode(BSTR bstrMode);
    HRESULT get_uiMode(BSTR* pbstrMode);
    HRESULT get_stretchToFit(VARIANT_BOOL* pbEnabled);
    HRESULT put_stretchToFit(VARIANT_BOOL bEnabled);
    HRESULT get_windowlessVideo(VARIANT_BOOL* pbEnabled);
    HRESULT put_windowlessVideo(VARIANT_BOOL bEnabled);
}

@GUID("f75ccec0-c67c-475c-931e-8719870bee7d")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmperroritem2))], [])
interface IWMPErrorItem2 : IWMPErrorItem
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmperroritem2-get_condition))], [])
    HRESULT get_condition(int* plCondition);
}

@GUID("cbb92747-741f-44fe-ab5b-f1a48f3b2a59")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpremotemediaservices))], [])
interface IWMPRemoteMediaServices : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpremotemediaservices-getservicetype))], [])
    HRESULT GetServiceType(BSTR* pbstrType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpremotemediaservices-getapplicationname))], [])
    HRESULT GetApplicationName(BSTR* pbstrName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpremotemediaservices-getscriptableobject))], [])
    HRESULT GetScriptableObject(BSTR* pbstrName, IDispatch* ppDispatch);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpremotemediaservices-getcustomuimode))], [])
    HRESULT GetCustomUIMode(BSTR* pbstrFile);
}

@GUID("076f2fa6-ed30-448b-8cc5-3f3ef3529c7a")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpskinmanager))], [])
interface IWMPSkinManager : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpskinmanager-setvisualstyle))], [])
    HRESULT SetVisualStyle(BSTR bstrPath);
}

@GUID("5c29bbe0-f87d-4c45-aa28-a70f0230ffa9")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpmetadatapicture))], [])
interface IWMPMetadataPicture : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmetadatapicture-get_mimetype))], [])
    HRESULT get_mimeType(BSTR* pbstrMimeType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmetadatapicture-get_picturetype))], [])
    HRESULT get_pictureType(BSTR* pbstrPictureType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmetadatapicture-get_description))], [])
    HRESULT get_description(BSTR* pbstrDescription);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmetadatapicture-get_url))], [])
    HRESULT get_URL(BSTR* pbstrURL);
}

@GUID("769a72db-13d2-45e2-9c48-53ca9d5b7450")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpmetadatatext))], [])
interface IWMPMetadataText : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmetadatatext-get_description))], [])
    HRESULT get_description(BSTR* pbstrDescription);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmetadatatext-get_text))], [])
    HRESULT get_text(BSTR* pbstrText);
}

@GUID("f118efc7-f03a-4fb4-99c9-1c02a5c1065b")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpmedia3))], [])
interface IWMPMedia3 : IWMPMedia2
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmedia3-getattributecountbytype))], [])
    HRESULT getAttributeCountByType(BSTR bstrType, BSTR bstrLanguage, int* plCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmedia3-getiteminfobytype))], [])
    HRESULT getItemInfoByType(BSTR bstrType, BSTR bstrLanguage, int lIndex, VARIANT* pvarValue);
}

@GUID("fda937a4-eece-4da5-a0b6-39bf89ade2c2")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpsettings2))], [])
interface IWMPSettings2 : IWMPSettings
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings2-get_defaultaudiolanguage))], [])
    HRESULT get_defaultAudioLanguage(int* plLangID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings2-get_mediaaccessrights))], [])
    HRESULT get_mediaAccessRights(BSTR* pbstrRights);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings2-requestmediaaccessrights))], [])
    HRESULT requestMediaAccessRights(BSTR bstrDesiredAccess, VARIANT_BOOL* pvbAccepted);
}

@GUID("a1d1110e-d545-476a-9a78-ac3e4cb1e6bd")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpcontrols3))], [])
interface IWMPControls3 : IWMPControls2
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols3-get_audiolanguagecount))], [])
    HRESULT get_audioLanguageCount(int* plCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols3-getaudiolanguageid))], [])
    HRESULT getAudioLanguageID(int lIndex, int* plLangID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols3-getaudiolanguagedescription))], [])
    HRESULT getAudioLanguageDescription(int lIndex, BSTR* pbstrLangDesc);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols3-get_currentaudiolanguage))], [])
    HRESULT get_currentAudioLanguage(int* plLangID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols3-put_currentaudiolanguage))], [])
    HRESULT put_currentAudioLanguage(int lLangID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols3-get_currentaudiolanguageindex))], [])
    HRESULT get_currentAudioLanguageIndex(int* plIndex);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols3-put_currentaudiolanguageindex))], [])
    HRESULT put_currentAudioLanguageIndex(int lIndex);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols3-getlanguagename))], [])
    HRESULT getLanguageName(int lLangID, BSTR* pbstrLangName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols3-get_currentpositiontimecode))], [])
    HRESULT get_currentPositionTimecode(BSTR* bstrTimecode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols3-put_currentpositiontimecode))], [])
    HRESULT put_currentPositionTimecode(BSTR bstrTimecode);
}

@GUID("350ba78b-6bc8-4113-a5f5-312056934eb6")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpclosedcaption2))], [])
interface IWMPClosedCaption2 : IWMPClosedCaption
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpclosedcaption2-get_samilangcount))], [])
    HRESULT get_SAMILangCount(int* plCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpclosedcaption2-getsamilangname))], [])
    HRESULT getSAMILangName(int nIndex, BSTR* pbstrName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpclosedcaption2-getsamilangid))], [])
    HRESULT getSAMILangID(int nIndex, int* plLangID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpclosedcaption2-get_samistylecount))], [])
    HRESULT get_SAMIStyleCount(int* plCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpclosedcaption2-getsamistylename))], [])
    HRESULT getSAMIStyleName(int nIndex, BSTR* pbstrName);
}

@GUID("40897764-ceab-47be-ad4a-8e28537f9bbf")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpplayerapplication))], [])
interface IWMPPlayerApplication : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplayerapplication-switchtoplayerapplication))], [])
    HRESULT switchToPlayerApplication();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplayerapplication-switchtocontrol))], [])
    HRESULT switchToControl();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplayerapplication-get_playerdocked))], [])
    HRESULT get_playerDocked(VARIANT_BOOL* pbPlayerDocked);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplayerapplication-get_hasdisplay))], [])
    HRESULT get_hasDisplay(VARIANT_BOOL* pbHasDisplay);
}

@GUID("7587c667-628f-499f-88e7-6a6f4e888464")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpcore3))], [])
interface IWMPCore3 : IWMPCore2
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcore3-newplaylist))], [])
    HRESULT newPlaylist(BSTR bstrName, BSTR bstrURL, IWMPPlaylist* ppPlaylist);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcore3-newmedia))], [])
    HRESULT newMedia(BSTR bstrURL, IWMPMedia* ppMedia);
}

@GUID("6c497d62-8919-413c-82db-e935fb3ec584")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpplayer4))], [])
interface IWMPPlayer4 : IWMPCore3
{
    HRESULT get_enabled(VARIANT_BOOL* pbEnabled);
    HRESULT put_enabled(VARIANT_BOOL bEnabled);
    HRESULT get_fullScreen(VARIANT_BOOL* pbFullScreen);
    HRESULT put_fullScreen(VARIANT_BOOL bFullScreen);
    HRESULT get_enableContextMenu(VARIANT_BOOL* pbEnableContextMenu);
    HRESULT put_enableContextMenu(VARIANT_BOOL bEnableContextMenu);
    HRESULT put_uiMode(BSTR bstrMode);
    HRESULT get_uiMode(BSTR* pbstrMode);
    HRESULT get_stretchToFit(VARIANT_BOOL* pbEnabled);
    HRESULT put_stretchToFit(VARIANT_BOOL bEnabled);
    HRESULT get_windowlessVideo(VARIANT_BOOL* pbEnabled);
    HRESULT put_windowlessVideo(VARIANT_BOOL bEnabled);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplayer4-get_isremote))], [])
    HRESULT get_isRemote(VARIANT_BOOL* pvarfIsRemote);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplayer4-get_playerapplication))], [])
    HRESULT get_playerApplication(IWMPPlayerApplication* ppIWMPPlayerApplication);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplayer4-openplayer))], [])
    HRESULT openPlayer(BSTR bstrURL);
}

@GUID("1d01fbdb-ade2-4c8d-9842-c190b95c3306")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpplayerservices))], [])
interface IWMPPlayerServices : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplayerservices-activateuiplugin))], [])
    HRESULT activateUIPlugin(BSTR bstrPlugin);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplayerservices-settaskpane))], [])
    HRESULT setTaskPane(BSTR bstrTaskPane);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplayerservices-settaskpaneurl))], [])
    HRESULT setTaskPaneURL(BSTR bstrTaskPane, BSTR bstrURL, BSTR bstrFriendlyName);
}

@GUID("82a2986c-0293-4fd0-b279-b21b86c058be")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpsyncdevice))], [])
interface IWMPSyncDevice : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsyncdevice-get_friendlyname))], [])
    HRESULT get_friendlyName(BSTR* pbstrName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsyncdevice-put_friendlyname))], [])
    HRESULT put_friendlyName(BSTR bstrName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsyncdevice-get_devicename))], [])
    HRESULT get_deviceName(BSTR* pbstrName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsyncdevice-get_deviceid))], [])
    HRESULT get_deviceId(BSTR* pbstrDeviceId);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsyncdevice-get_partnershipindex))], [])
    HRESULT get_partnershipIndex(int* plIndex);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsyncdevice-get_connected))], [])
    HRESULT get_connected(VARIANT_BOOL* pvbConnected);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsyncdevice-get_status))], [])
    HRESULT get_status(WMPDeviceStatus* pwmpds);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsyncdevice-get_syncstate))], [])
    HRESULT get_syncState(WMPSyncState* pwmpss);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsyncdevice-get_progress))], [])
    HRESULT get_progress(int* plProgress);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsyncdevice-getiteminfo))], [])
    HRESULT getItemInfo(BSTR bstrItemName, BSTR* pbstrVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsyncdevice-createpartnership))], [])
    HRESULT createPartnership(VARIANT_BOOL vbShowUI);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsyncdevice-deletepartnership))], [])
    HRESULT deletePartnership();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsyncdevice-start))], [])
    HRESULT start();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsyncdevice-stop))], [])
    HRESULT stop();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsyncdevice-showsettings))], [])
    HRESULT showSettings();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsyncdevice-isidentical))], [])
    HRESULT isIdentical(IWMPSyncDevice pDevice, VARIANT_BOOL* pvbool);
}

@GUID("8b5050ff-e0a4-4808-b3a8-893a9e1ed894")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpsyncservices))], [])
interface IWMPSyncServices : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsyncservices-get_devicecount))], [])
    HRESULT get_deviceCount(int* plCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsyncservices-getdevice))], [])
    HRESULT getDevice(int lIndex, IWMPSyncDevice* ppDevice);
}

@GUID("1bb1592f-f040-418a-9f71-17c7512b4d70")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpplayerservices2))], [])
interface IWMPPlayerServices2 : IWMPPlayerServices
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplayerservices2-setbackgroundprocessingpriority))], [])
    HRESULT setBackgroundProcessingPriority(BSTR bstrPriority);
}

@GUID("56e2294f-69ed-4629-a869-aea72c0dcc2c")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpcdromrip))], [])
interface IWMPCdromRip : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcdromrip-get_ripstate))], [])
    HRESULT get_ripState(WMPRipState* pwmprs);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcdromrip-get_ripprogress))], [])
    HRESULT get_ripProgress(int* plProgress);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcdromrip-startrip))], [])
    HRESULT startRip();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcdromrip-stoprip))], [])
    HRESULT stopRip();
}

@GUID("bd94dbeb-417f-4928-aa06-087d56ed9b59")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpcdromburn))], [])
interface IWMPCdromBurn : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcdromburn-isavailable))], [])
    HRESULT isAvailable(BSTR bstrItem, VARIANT_BOOL* pIsAvailable);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcdromburn-getiteminfo))], [])
    HRESULT getItemInfo(BSTR bstrItem, BSTR* pbstrVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcdromburn-get_label))], [])
    HRESULT get_label(BSTR* pbstrLabel);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcdromburn-put_label))], [])
    HRESULT put_label(BSTR bstrLabel);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcdromburn-get_burnformat))], [])
    HRESULT get_burnFormat(WMPBurnFormat* pwmpbf);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcdromburn-put_burnformat))], [])
    HRESULT put_burnFormat(WMPBurnFormat wmpbf);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcdromburn-get_burnplaylist))], [])
    HRESULT get_burnPlaylist(IWMPPlaylist* ppPlaylist);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcdromburn-put_burnplaylist))], [])
    HRESULT put_burnPlaylist(IWMPPlaylist pPlaylist);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcdromburn-refreshstatus))], [])
    HRESULT refreshStatus();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcdromburn-get_burnstate))], [])
    HRESULT get_burnState(WMPBurnState* pwmpbs);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcdromburn-get_burnprogress))], [])
    HRESULT get_burnProgress(int* plProgress);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcdromburn-startburn))], [])
    HRESULT startBurn();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcdromburn-stopburn))], [])
    HRESULT stopBurn();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcdromburn-erase))], [])
    HRESULT erase();
}

@GUID("a00918f3-a6b0-4bfb-9189-fd834c7bc5a5")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpquery))], [])
interface IWMPQuery : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpquery-addcondition))], [])
    HRESULT addCondition(BSTR bstrAttribute, BSTR bstrOperator, BSTR bstrValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpquery-beginnextgroup))], [])
    HRESULT beginNextGroup();
}

@GUID("8ba957f5-fd8c-4791-b82d-f840401ee474")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpmediacollection2))], [])
interface IWMPMediaCollection2 : IWMPMediaCollection
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmediacollection2-createquery))], [])
    HRESULT createQuery(IWMPQuery* ppQuery);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmediacollection2-getplaylistbyquery))], [])
    HRESULT getPlaylistByQuery(IWMPQuery pQuery, BSTR bstrMediaType, BSTR bstrSortAttribute, 
                               VARIANT_BOOL fSortAscending, IWMPPlaylist* ppPlaylist);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmediacollection2-getstringcollectionbyquery))], [])
    HRESULT getStringCollectionByQuery(BSTR bstrAttribute, IWMPQuery pQuery, BSTR bstrMediaType, 
                                       BSTR bstrSortAttribute, VARIANT_BOOL fSortAscending, 
                                       IWMPStringCollection* ppStringCollection);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmediacollection2-getbyattributeandmediatype))], [])
    HRESULT getByAttributeAndMediaType(BSTR bstrAttribute, BSTR bstrValue, BSTR bstrMediaType, 
                                       IWMPPlaylist* ppMediaItems);
}

@GUID("46ad648d-53f1-4a74-92e2-2a1b68d63fd4")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpstringcollection2))], [])
interface IWMPStringCollection2 : IWMPStringCollection
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpstringcollection2-isidentical))], [])
    HRESULT isIdentical(IWMPStringCollection2 pIWMPStringCollection2, VARIANT_BOOL* pvbool);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpstringcollection2-getiteminfo))], [])
    HRESULT getItemInfo(int lCollectionIndex, BSTR bstrItemName, BSTR* pbstrValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpstringcollection2-getattributecountbytype))], [])
    HRESULT getAttributeCountByType(int lCollectionIndex, BSTR bstrType, BSTR bstrLanguage, int* plCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpstringcollection2-getiteminfobytype))], [])
    HRESULT getItemInfoByType(int lCollectionIndex, BSTR bstrType, BSTR bstrLanguage, int lAttributeIndex, 
                              VARIANT* pvarValue);
}

@GUID("3df47861-7df1-4c1f-a81b-4c26f0f7a7c6")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmplibrary))], [])
interface IWMPLibrary : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmplibrary-get_name))], [])
    HRESULT get_name(BSTR* pbstrName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmplibrary-get_type))], [])
    HRESULT get_type(WMPLibraryType* pwmplt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmplibrary-get_mediacollection))], [])
    HRESULT get_mediaCollection(IWMPMediaCollection* ppIWMPMediaCollection);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmplibrary-isidentical))], [])
    HRESULT isIdentical(IWMPLibrary pIWMPLibrary, VARIANT_BOOL* pvbool);
}

@GUID("39c2f8d5-1cf2-4d5e-ae09-d73492cf9eaa")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmplibraryservices))], [])
interface IWMPLibraryServices : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmplibraryservices-getcountbytype))], [])
    HRESULT getCountByType(WMPLibraryType wmplt, int* plCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmplibraryservices-getlibrarybytype))], [])
    HRESULT getLibraryByType(WMPLibraryType wmplt, int lIndex, IWMPLibrary* ppIWMPLibrary);
}

@GUID("82cba86b-9f04-474b-a365-d6dd1466e541")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmplibrarysharingservices))], [])
interface IWMPLibrarySharingServices : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmplibrarysharingservices-islibraryshared))], [])
    HRESULT isLibraryShared(VARIANT_BOOL* pvbShared);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmplibrarysharingservices-islibrarysharingenabled))], [])
    HRESULT isLibrarySharingEnabled(VARIANT_BOOL* pvbEnabled);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmplibrarysharingservices-showlibrarysharing))], [])
    HRESULT showLibrarySharing();
}

@GUID("788c8743-e57f-439d-a468-5bc77f2e59c6")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpfoldermonitorservices))], [])
interface IWMPFolderMonitorServices : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpfoldermonitorservices-get_count))], [])
    HRESULT get_count(int* plCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpfoldermonitorservices-item))], [])
    HRESULT item(int lIndex, BSTR* pbstrFolder);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpfoldermonitorservices-add))], [])
    HRESULT add(BSTR bstrFolder);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpfoldermonitorservices-remove))], [])
    HRESULT remove(int lIndex);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpfoldermonitorservices-get_scanstate))], [])
    HRESULT get_scanState(WMPFolderScanState* pwmpfss);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpfoldermonitorservices-get_currentfolder))], [])
    HRESULT get_currentFolder(BSTR* pbstrFolder);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpfoldermonitorservices-get_scannedfilescount))], [])
    HRESULT get_scannedFilesCount(int* plCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpfoldermonitorservices-get_addedfilescount))], [])
    HRESULT get_addedFilesCount(int* plCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpfoldermonitorservices-get_updateprogress))], [])
    HRESULT get_updateProgress(int* plProgress);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpfoldermonitorservices-startscan))], [])
    HRESULT startScan();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpfoldermonitorservices-stopscan))], [])
    HRESULT stopScan();
}

@GUID("88afb4b2-140a-44d2-91e6-4543da467cd1")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpsyncdevice2))], [])
interface IWMPSyncDevice2 : IWMPSyncDevice
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsyncdevice2-setiteminfo))], [])
    HRESULT setItemInfo(BSTR bstrItemName, BSTR bstrVal);
}

@GUID("b22c85f9-263c-4372-a0da-b518db9b4098")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpsyncdevice3))], [])
interface IWMPSyncDevice3 : IWMPSyncDevice2
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsyncdevice3-estimatesyncsize))], [])
    HRESULT estimateSyncSize(IWMPPlaylist pNonRulePlaylist, IWMPPlaylist pRulesPlaylist);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsyncdevice3-cancelestimation))], [])
    HRESULT cancelEstimation();
}

@GUID("dd578a4e-79b1-426c-bf8f-3add9072500b")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmplibrary2))], [])
interface IWMPLibrary2 : IWMPLibrary
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmplibrary2-getiteminfo))], [])
    HRESULT getItemInfo(BSTR bstrItemName, BSTR* pbstrVal);
}

@GUID("19a6627b-da9e-47c1-bb23-00b5e668236a")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpevents))], [])
interface IWMPEvents : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-openstatechange))], [])
    void OpenStateChange(int NewState);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-playstatechange))], [])
    void PlayStateChange(int NewState);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-audiolanguagechange))], [])
    void AudioLanguageChange(int LangID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-statuschange))], [])
    void StatusChange();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-scriptcommand))], [])
    void ScriptCommand(BSTR scType, BSTR Param);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-newstream))], [])
    void NewStream();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-disconnect))], [])
    void Disconnect(int Result);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-buffering))], [])
    void Buffering(VARIANT_BOOL Start);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-error))], [])
    void Error();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-warning))], [])
    void Warning(int WarningType, int Param, BSTR Description);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-endofstream))], [])
    void EndOfStream(int Result);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-positionchange))], [])
    void PositionChange(double oldPosition, double newPosition);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-markerhit))], [])
    void MarkerHit(int MarkerNum);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-durationunitchange))], [])
    void DurationUnitChange(int NewDurationUnit);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-cdrommediachange))], [])
    void CdromMediaChange(int CdromNum);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-playlistchange))], [])
    void PlaylistChange(IDispatch Playlist, WMPPlaylistChangeEventType change);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-currentplaylistchange))], [])
    void CurrentPlaylistChange(WMPPlaylistChangeEventType change);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-currentplaylistitemavailable))], [])
    void CurrentPlaylistItemAvailable(BSTR bstrItemName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-mediachange))], [])
    void MediaChange(IDispatch Item);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-currentmediaitemavailable))], [])
    void CurrentMediaItemAvailable(BSTR bstrItemName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-currentitemchange))], [])
    void CurrentItemChange(IDispatch pdispMedia);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-mediacollectionchange))], [])
    void MediaCollectionChange();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-mediacollectionattributestringadded))], [])
    void MediaCollectionAttributeStringAdded(BSTR bstrAttribName, BSTR bstrAttribVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-mediacollectionattributestringremoved))], [])
    void MediaCollectionAttributeStringRemoved(BSTR bstrAttribName, BSTR bstrAttribVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-mediacollectionattributestringchanged))], [])
    void MediaCollectionAttributeStringChanged(BSTR bstrAttribName, BSTR bstrOldAttribVal, BSTR bstrNewAttribVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-playlistcollectionchange))], [])
    void PlaylistCollectionChange();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-playlistcollectionplaylistadded))], [])
    void PlaylistCollectionPlaylistAdded(BSTR bstrPlaylistName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-playlistcollectionplaylistremoved))], [])
    void PlaylistCollectionPlaylistRemoved(BSTR bstrPlaylistName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-playlistcollectionplaylistsetasdeleted))], [])
    void PlaylistCollectionPlaylistSetAsDeleted(BSTR bstrPlaylistName, VARIANT_BOOL varfIsDeleted);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-modechange))], [])
    void ModeChange(BSTR ModeName, VARIANT_BOOL NewValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-mediaerror))], [])
    void MediaError(IDispatch pMediaObject);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-openplaylistswitch))], [])
    void OpenPlaylistSwitch(IDispatch pItem);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-domainchange))], [])
    void DomainChange(BSTR strDomain);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-switchedtoplayerapplication))], [])
    void SwitchedToPlayerApplication();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-switchedtocontrol))], [])
    void SwitchedToControl();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-playerdockedstatechange))], [])
    void PlayerDockedStateChange();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-playerreconnect))], [])
    void PlayerReconnect();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-click))], [])
    void Click(short nButton, short nShiftState, int fX, int fY);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-doubleclick))], [])
    void DoubleClick(short nButton, short nShiftState, int fX, int fY);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-keydown))], [])
    void KeyDown(short nKeyCode, short nShiftState);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-keypress))], [])
    void KeyPress(short nKeyAscii);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-keyup))], [])
    void KeyUp(short nKeyCode, short nShiftState);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-mousedown))], [])
    void MouseDown(short nButton, short nShiftState, int fX, int fY);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-mousemove))], [])
    void MouseMove(short nButton, short nShiftState, int fX, int fY);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-mouseup))], [])
    void MouseUp(short nButton, short nShiftState, int fX, int fY);
}

@GUID("1e7601fa-47ea-4107-9ea9-9004ed9684ff")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpevents2))], [])
interface IWMPEvents2 : IWMPEvents
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents2-deviceconnect))], [])
    void DeviceConnect(IWMPSyncDevice pDevice);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents2-devicedisconnect))], [])
    void DeviceDisconnect(IWMPSyncDevice pDevice);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents2-devicestatuschange))], [])
    void DeviceStatusChange(IWMPSyncDevice pDevice, WMPDeviceStatus NewStatus);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents2-devicesyncstatechange))], [])
    void DeviceSyncStateChange(IWMPSyncDevice pDevice, WMPSyncState NewState);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents2-devicesyncerror))], [])
    void DeviceSyncError(IWMPSyncDevice pDevice, IDispatch pMedia);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents2-createpartnershipcomplete))], [])
    void CreatePartnershipComplete(IWMPSyncDevice pDevice, HRESULT hrResult);
}

@GUID("1f504270-a66b-4223-8e96-26a06c63d69f")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpevents3))], [])
interface IWMPEvents3 : IWMPEvents2
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents3-cdromripstatechange))], [])
    void CdromRipStateChange(IWMPCdromRip pCdromRip, WMPRipState wmprs);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents3-cdromripmediaerror))], [])
    void CdromRipMediaError(IWMPCdromRip pCdromRip, IDispatch pMedia);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents3-cdromburnstatechange))], [])
    void CdromBurnStateChange(IWMPCdromBurn pCdromBurn, WMPBurnState wmpbs);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents3-cdromburnmediaerror))], [])
    void CdromBurnMediaError(IWMPCdromBurn pCdromBurn, IDispatch pMedia);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents3-cdromburnerror))], [])
    void CdromBurnError(IWMPCdromBurn pCdromBurn, HRESULT hrError);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents3-libraryconnect))], [])
    void LibraryConnect(IWMPLibrary pLibrary);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents3-librarydisconnect))], [])
    void LibraryDisconnect(IWMPLibrary pLibrary);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents3-folderscanstatechange))], [])
    void FolderScanStateChange(WMPFolderScanState wmpfss);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents3-stringcollectionchange))], [])
    void StringCollectionChange(IDispatch pdispStringCollection, WMPStringCollectionChangeEventType change, 
                                int lCollectionIndex);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents3-mediacollectionmediaadded))], [])
    void MediaCollectionMediaAdded(IDispatch pdispMedia);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents3-mediacollectionmediaremoved))], [])
    void MediaCollectionMediaRemoved(IDispatch pdispMedia);
}

@GUID("26dabcfa-306b-404d-9a6f-630a8405048d")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpevents4))], [])
interface IWMPEvents4 : IWMPEvents3
{
    void DeviceEstimation(IWMPSyncDevice pDevice, HRESULT hrResult, long qwEstimatedUsedSpace, 
                          long qwEstimatedSpace);
}

@GUID("6bf52a51-394a-11d3-b153-00c04f79faa6")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/WMP/-wmpocxevents-interface))], [])
interface _WMPOCXEvents : IDispatch
{
}

@GUID("42751198-5a50-4460-bcb4-709f8bdc8e59")
interface IWMPNodeRealEstate : IUnknown
{
    HRESULT GetDesiredSize(SIZE* pSize);
    HRESULT SetRects(const(RECT)* pSrc, const(RECT)* pDest, const(RECT)* pClip);
    HRESULT GetRects(RECT* pSrc, RECT* pDest, RECT* pClip);
    HRESULT SetWindowless(BOOL fWindowless);
    HRESULT GetWindowless(BOOL* pfWindowless);
    HRESULT SetFullScreen(BOOL fFullScreen);
    HRESULT GetFullScreen(BOOL* pfFullScreen);
}

@GUID("1491087d-2c6b-44c8-b019-b3c929d2ada9")
interface IWMPNodeRealEstateHost : IUnknown
{
    HRESULT OnDesiredSizeChange(SIZE* pSize);
    HRESULT OnFullScreenTransition(BOOL fFullScreen);
}

@GUID("96740bfa-c56a-45d1-a3a4-762914d4ade9")
interface IWMPNodeWindowed : IUnknown
{
    HRESULT SetOwnerWindow(ptrdiff_t hwnd);
    HRESULT GetOwnerWindow(ptrdiff_t* phwnd);
}

@GUID("a300415a-54aa-4081-adbf-3b13610d8958")
interface IWMPNodeWindowedHost : IUnknown
{
    HRESULT OnWindowMessageFromRenderer(uint uMsg, WPARAM wparam, LPARAM lparam, LRESULT* plRet, BOOL* pfHandled);
}

@GUID("3a0daa30-908d-4789-ba87-aed879b5c49b")
interface IWMPWindowMessageSink : IUnknown
{
    HRESULT OnWindowMessage(uint uMsg, WPARAM wparam, LPARAM lparam, LRESULT* plRet, BOOL* pfHandled);
}

@GUID("9b9199ad-780c-4eda-b816-261eba5d1575")
interface IWMPNodeWindowless : IWMPWindowMessageSink
{
    HRESULT OnDraw(ptrdiff_t hdc, const(RECT)* prcDraw);
}

@GUID("be7017c6-ce34-4901-8106-770381aa6e3e")
interface IWMPNodeWindowlessHost : IUnknown
{
    HRESULT InvalidateRect(const(RECT)* prc, BOOL fErase);
}

@GUID("6d6cf803-1ec0-4c8d-b3ca-f18e27282074")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmprealestate/nn-wmprealestate-iwmpvideorenderconfig))], [])
interface IWMPVideoRenderConfig : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmprealestate/nf-wmprealestate-iwmpvideorenderconfig-put_presenteractivate))], [])
    HRESULT put_presenterActivate(IMFActivate pActivate);
}

@GUID("e79c6349-5997-4ce4-917c-22a3391ec564")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmprealestate/nn-wmprealestate-iwmpaudiorenderconfig))], [])
interface IWMPAudioRenderConfig : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmprealestate/nf-wmprealestate-iwmpaudiorenderconfig-get_audiooutputdevice))], [])
    HRESULT get_audioOutputDevice(BSTR* pbstrOutputDevice);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmprealestate/nf-wmprealestate-iwmpaudiorenderconfig-put_audiooutputdevice))], [])
    HRESULT put_audioOutputDevice(BSTR bstrOutputDevice);
}

@GUID("959506c1-0314-4ec5-9e61-8528db5e5478")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmprealestate/nn-wmprealestate-iwmprenderconfig))], [])
interface IWMPRenderConfig : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmprealestate/nf-wmprealestate-iwmprenderconfig-put_inproconly))], [])
    HRESULT put_inProcOnly(BOOL fInProc);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmprealestate/nf-wmprealestate-iwmprenderconfig-get_inproconly))], [])
    HRESULT get_inProcOnly(BOOL* pfInProc);
}

@GUID("afb6b76b-1e20-4198-83b3-191db6e0b149")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmpservices/nn-wmpservices-iwmpservices))], [])
interface IWMPServices : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmpservices/nf-wmpservices-iwmpservices-getstreamtime))], [])
    HRESULT GetStreamTime(long* prt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmpservices/nf-wmpservices-iwmpservices-getstreamstate))], [])
    HRESULT GetStreamState(WMPServices_StreamState* pState);
}

@GUID("68e27045-05bd-40b2-9720-23088c78e390")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmpservices/nn-wmpservices-iwmpmediapluginregistrar))], [])
interface IWMPMediaPluginRegistrar : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmpservices/nf-wmpservices-iwmpmediapluginregistrar-wmpregisterplayerplugin))], [])
    HRESULT WMPRegisterPlayerPlugin(PWSTR pwszFriendlyName, PWSTR pwszDescription, PWSTR pwszUninstallString, 
                                    uint dwPriority, GUID guidPluginType, GUID clsid, uint cMediaTypes, 
                                    void* pMediaTypes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmpservices/nf-wmpservices-iwmpmediapluginregistrar-wmpunregisterplayerplugin))], [])
    HRESULT WMPUnRegisterPlayerPlugin(GUID guidPluginType, GUID clsid);
}

@GUID("f1392a70-024c-42bb-a998-73dfdfe7d5a7")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmpservices/nn-wmpservices-iwmpplugin))], [])
interface IWMPPlugin : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmpservices/nf-wmpservices-iwmpplugin-init))], [])
    HRESULT Init(size_t dwPlaybackContext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmpservices/nf-wmpservices-iwmpplugin-shutdown))], [])
    HRESULT Shutdown();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmpservices/nf-wmpservices-iwmpplugin-getid))], [])
    HRESULT GetID(GUID* pGUID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmpservices/nf-wmpservices-iwmpplugin-getcaps))], [])
    HRESULT GetCaps(uint* pdwFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmpservices/nf-wmpservices-iwmpplugin-advisewmpservices))], [])
    HRESULT AdviseWMPServices(IWMPServices pWMPServices);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmpservices/nf-wmpservices-iwmpplugin-unadvisewmpservices))], [])
    HRESULT UnAdviseWMPServices();
}

@GUID("5fca444c-7ad1-479d-a4ef-40566a5309d6")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmpservices/nn-wmpservices-iwmppluginenable))], [])
interface IWMPPluginEnable : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmpservices/nf-wmpservices-iwmppluginenable-setenable))], [])
    HRESULT SetEnable(BOOL fEnable);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmpservices/nf-wmpservices-iwmppluginenable-getenable))], [])
    HRESULT GetEnable(BOOL* pfEnable);
}

@GUID("bfb377e5-c594-4369-a970-de896d5ece74")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmpservices/nn-wmpservices-iwmpgraphcreation))], [])
interface IWMPGraphCreation : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmpservices/nf-wmpservices-iwmpgraphcreation-graphcreationprerender))], [])
    HRESULT GraphCreationPreRender(IUnknown pFilterGraph, IUnknown pReserved);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmpservices/nf-wmpservices-iwmpgraphcreation-graphcreationpostrender))], [])
    HRESULT GraphCreationPostRender(IUnknown pFilterGraph);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmpservices/nf-wmpservices-iwmpgraphcreation-getgraphcreationflags))], [])
    HRESULT GetGraphCreationFlags(uint* pdwFlags);
}

@GUID("d683162f-57d4-4108-8373-4a9676d1c2e9")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmpservices/nn-wmpservices-iwmpconvert))], [])
interface IWMPConvert : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmpservices/nf-wmpservices-iwmpconvert-convertfile))], [])
    HRESULT ConvertFile(BSTR bstrInputFile, BSTR bstrDestinationFolder, BSTR* pbstrOutputFile);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmpservices/nf-wmpservices-iwmpconvert-geterrorurl))], [])
    HRESULT GetErrorURL(BSTR* pbstrURL);
}

@GUID("b64cbac3-401c-4327-a3e8-b9feb3a8c25c")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmpservices/nn-wmpservices-iwmptranscodepolicy))], [])
interface IWMPTranscodePolicy : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmpservices/nf-wmpservices-iwmptranscodepolicy-allowtranscode))], [])
    HRESULT allowTranscode(VARIANT_BOOL* pvbAllow);
}

@GUID("cfccfa72-c343-48c3-a2de-b7a4402e39f2")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmpservices/nn-wmpservices-iwmpusereventsink))], [])
interface IWMPUserEventSink : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmpservices/nf-wmpservices-iwmpusereventsink-notifyuserevent))], [])
    HRESULT NotifyUserEvent(int EventCode);
}

@GUID("5357e238-fb12-4aca-a930-cab7832b84bf")
interface IXFeedsManager : IUnknown
{
    HRESULT RootFolder(const(GUID)* riid, void** ppv);
    HRESULT IsSubscribed(const(PWSTR) pszUrl, BOOL* pbSubscribed);
    HRESULT ExistsFeed(const(PWSTR) pszPath, BOOL* pbFeedExists);
    HRESULT GetFeed(const(PWSTR) pszPath, const(GUID)* riid, void** ppv);
    HRESULT GetFeedByUrl(const(PWSTR) pszUrl, const(GUID)* riid, void** ppv);
    HRESULT ExistsFolder(const(PWSTR) pszPath, BOOL* pbFolderExists);
    HRESULT GetFolder(const(PWSTR) pszPath, const(GUID)* riid, void** ppv);
    HRESULT DeleteFeed(const(PWSTR) pszPath);
    HRESULT DeleteFolder(const(PWSTR) pszPath);
    HRESULT BackgroundSync(FEEDS_BACKGROUNDSYNC_ACTION fbsa);
    HRESULT BackgroundSyncStatus(FEEDS_BACKGROUNDSYNC_STATUS* pfbss);
    HRESULT DefaultInterval(uint* puiInterval);
    HRESULT SetDefaultInterval(uint uiInterval);
    HRESULT AsyncSyncAll();
    HRESULT Normalize(IStream pStreamIn, IStream* ppStreamOut);
    HRESULT ItemCountLimit(uint* puiItemCountLimit);
}

@GUID("dc43a9d5-5015-4301-8c96-a47434b4d658")
interface IXFeedsEnum : IUnknown
{
    HRESULT Count(uint* puiCount);
    HRESULT Item(uint uiIndex, const(GUID)* riid, void** ppv);
}

@GUID("4c963678-3a51-4b88-8531-98b90b6508f2")
interface IXFeedFolder : IUnknown
{
    HRESULT Feeds(IXFeedsEnum* ppfe);
    HRESULT Subfolders(IXFeedsEnum* ppfe);
    HRESULT CreateFeed(const(PWSTR) pszName, const(PWSTR) pszUrl, const(GUID)* riid, void** ppv);
    HRESULT CreateSubfolder(const(PWSTR) pszName, const(GUID)* riid, void** ppv);
    HRESULT ExistsFeed(const(PWSTR) pszName, BOOL* pbFeedExists);
    HRESULT ExistsSubfolder(const(PWSTR) pszName, BOOL* pbSubfolderExists);
    HRESULT GetFeed(const(PWSTR) pszName, const(GUID)* riid, void** ppv);
    HRESULT GetSubfolder(const(PWSTR) pszName, const(GUID)* riid, void** ppv);
    HRESULT Delete();
    HRESULT Name(PWSTR* ppszName);
    HRESULT Rename(const(PWSTR) pszName);
    HRESULT Path(PWSTR* ppszPath);
    HRESULT Move(const(PWSTR) pszPath);
    HRESULT Parent(const(GUID)* riid, void** ppv);
    HRESULT IsRoot(BOOL* pbIsRootFeedFolder);
    HRESULT GetWatcher(FEEDS_EVENTS_SCOPE scope_, FEEDS_EVENTS_MASK mask, const(GUID)* riid, void** ppv);
    HRESULT TotalUnreadItemCount(uint* puiTotalUnreadItemCount);
    HRESULT TotalItemCount(uint* puiTotalItemCount);
}

@GUID("7964b769-234a-4bb1-a5f4-90454c8ad07e")
interface IXFeedFolderEvents : IUnknown
{
    HRESULT Error();
    HRESULT FolderAdded(const(PWSTR) pszPath);
    HRESULT FolderDeleted(const(PWSTR) pszPath);
    HRESULT FolderRenamed(const(PWSTR) pszPath, const(PWSTR) pszOldPath);
    HRESULT FolderMovedFrom(const(PWSTR) pszPath, const(PWSTR) pszOldPath);
    HRESULT FolderMovedTo(const(PWSTR) pszPath, const(PWSTR) pszOldPath);
    HRESULT FolderItemCountChanged(const(PWSTR) pszPath, int feicfFlags);
    HRESULT FeedAdded(const(PWSTR) pszPath);
    HRESULT FeedDeleted(const(PWSTR) pszPath);
    HRESULT FeedRenamed(const(PWSTR) pszPath, const(PWSTR) pszOldPath);
    HRESULT FeedUrlChanged(const(PWSTR) pszPath);
    HRESULT FeedMovedFrom(const(PWSTR) pszPath, const(PWSTR) pszOldPath);
    HRESULT FeedMovedTo(const(PWSTR) pszPath, const(PWSTR) pszOldPath);
    HRESULT FeedDownloading(const(PWSTR) pszPath);
    HRESULT FeedDownloadCompleted(const(PWSTR) pszPath, FEEDS_DOWNLOAD_ERROR fde);
    HRESULT FeedItemCountChanged(const(PWSTR) pszPath, int feicfFlags);
}

@GUID("a44179a4-e0f6-403b-af8d-d080f425a451")
interface IXFeed : IUnknown
{
    HRESULT Xml(uint uiItemCount, FEEDS_XML_SORT_PROPERTY sortProperty, FEEDS_XML_SORT_ORDER sortOrder, 
                FEEDS_XML_FILTER_FLAGS filterFlags, FEEDS_XML_INCLUDE_FLAGS includeFlags, IStream* pps);
    HRESULT Name(PWSTR* ppszName);
    HRESULT Rename(const(PWSTR) pszName);
    HRESULT Url(PWSTR* ppszUrl);
    HRESULT SetUrl(const(PWSTR) pszUrl);
    HRESULT LocalId(GUID* pguid);
    HRESULT Path(PWSTR* ppszPath);
    HRESULT Move(const(PWSTR) pszPath);
    HRESULT Parent(const(GUID)* riid, void** ppv);
    HRESULT LastWriteTime(SYSTEMTIME* pstLastWriteTime);
    HRESULT Delete();
    HRESULT Download();
    HRESULT AsyncDownload();
    HRESULT CancelAsyncDownload();
    HRESULT SyncSetting(FEEDS_SYNC_SETTING* pfss);
    HRESULT SetSyncSetting(FEEDS_SYNC_SETTING fss);
    HRESULT Interval(uint* puiInterval);
    HRESULT SetInterval(uint uiInterval);
    HRESULT LastDownloadTime(SYSTEMTIME* pstLastDownloadTime);
    HRESULT LocalEnclosurePath(PWSTR* ppszPath);
    HRESULT Items(IXFeedsEnum* ppfe);
    HRESULT GetItem(uint uiId, const(GUID)* riid, void** ppv);
    HRESULT MarkAllItemsRead();
    HRESULT MaxItemCount(uint* puiMaxItemCount);
    HRESULT SetMaxItemCount(uint uiMaxItemCount);
    HRESULT DownloadEnclosuresAutomatically(BOOL* pbDownloadEnclosuresAutomatically);
    HRESULT SetDownloadEnclosuresAutomatically(BOOL bDownloadEnclosuresAutomatically);
    HRESULT DownloadStatus(FEEDS_DOWNLOAD_STATUS* pfds);
    HRESULT LastDownloadError(FEEDS_DOWNLOAD_ERROR* pfde);
    HRESULT Merge(IStream pStream, const(PWSTR) pszUrl);
    HRESULT DownloadUrl(PWSTR* ppszUrl);
    HRESULT Title(PWSTR* ppszTitle);
    HRESULT Description(PWSTR* ppszDescription);
    HRESULT Link(PWSTR* ppszHomePage);
    HRESULT Image(PWSTR* ppszImageUrl);
    HRESULT LastBuildDate(SYSTEMTIME* pstLastBuildDate);
    HRESULT PubDate(SYSTEMTIME* pstPubDate);
    HRESULT Ttl(uint* puiTtl);
    HRESULT Language(PWSTR* ppszLanguage);
    HRESULT Copyright(PWSTR* ppszCopyright);
    HRESULT IsList(BOOL* pbIsList);
    HRESULT GetWatcher(FEEDS_EVENTS_SCOPE scope_, FEEDS_EVENTS_MASK mask, const(GUID)* riid, void** ppv);
    HRESULT UnreadItemCount(uint* puiUnreadItemCount);
    HRESULT ItemCount(uint* puiItemCount);
}

@GUID("ce528e77-3716-4eb7-956d-f5e37502e12a")
interface IXFeed2 : IXFeed
{
    HRESULT GetItemByEffectiveId(uint uiEffectiveId, const(GUID)* riid, void** ppv);
    HRESULT LastItemDownloadTime(SYSTEMTIME* pstLastItemDownloadTime);
    HRESULT Username(PWSTR* ppszUsername);
    HRESULT Password(PWSTR* ppszPassword);
    HRESULT SetCredentials(const(PWSTR) pszUsername, const(PWSTR) pszPassword);
    HRESULT ClearCredentials();
}

@GUID("1630852e-1263-465b-98e5-fe60ffec4ac2")
interface IXFeedEvents : IUnknown
{
    HRESULT Error();
    HRESULT FeedDeleted(const(PWSTR) pszPath);
    HRESULT FeedRenamed(const(PWSTR) pszPath, const(PWSTR) pszOldPath);
    HRESULT FeedUrlChanged(const(PWSTR) pszPath);
    HRESULT FeedMoved(const(PWSTR) pszPath, const(PWSTR) pszOldPath);
    HRESULT FeedDownloading(const(PWSTR) pszPath);
    HRESULT FeedDownloadCompleted(const(PWSTR) pszPath, FEEDS_DOWNLOAD_ERROR fde);
    HRESULT FeedItemCountChanged(const(PWSTR) pszPath, int feicfFlags);
}

@GUID("e757b2f5-e73e-434e-a1bf-2bd7c3e60fcb")
interface IXFeedItem : IUnknown
{
    HRESULT Xml(FEEDS_XML_INCLUDE_FLAGS fxif, IStream* pps);
    HRESULT Title(PWSTR* ppszTitle);
    HRESULT Link(PWSTR* ppszUrl);
    HRESULT Guid(PWSTR* ppszGuid);
    HRESULT Description(PWSTR* ppszDescription);
    HRESULT PubDate(SYSTEMTIME* pstPubDate);
    HRESULT Comments(PWSTR* ppszUrl);
    HRESULT Author(PWSTR* ppszAuthor);
    HRESULT Enclosure(const(GUID)* riid, void** ppv);
    HRESULT IsRead(BOOL* pbIsRead);
    HRESULT SetIsRead(BOOL bIsRead);
    HRESULT LocalId(uint* puiId);
    HRESULT Parent(const(GUID)* riid, void** ppv);
    HRESULT Delete();
    HRESULT DownloadUrl(PWSTR* ppszUrl);
    HRESULT LastDownloadTime(SYSTEMTIME* pstLastDownloadTime);
    HRESULT Modified(SYSTEMTIME* pstModifiedTime);
}

@GUID("6cda2dc7-9013-4522-9970-2a9dd9ead5a3")
interface IXFeedItem2 : IXFeedItem
{
    HRESULT EffectiveId(uint* puiEffectiveId);
}

@GUID("bfbfb953-644f-4792-b69c-dfaca4cbf89a")
interface IXFeedEnclosure : IUnknown
{
    HRESULT Url(PWSTR* ppszUrl);
    HRESULT Type(PWSTR* ppszMimeType);
    HRESULT Length(uint* puiLength);
    HRESULT AsyncDownload();
    HRESULT CancelAsyncDownload();
    HRESULT DownloadStatus(FEEDS_DOWNLOAD_STATUS* pfds);
    HRESULT LastDownloadError(FEEDS_DOWNLOAD_ERROR* pfde);
    HRESULT LocalPath(PWSTR* ppszPath);
    HRESULT Parent(const(GUID)* riid, void** ppv);
    HRESULT DownloadUrl(PWSTR* ppszUrl);
    HRESULT DownloadMimeType(PWSTR* ppszMimeType);
    HRESULT RemoveFile();
    HRESULT SetFile(const(PWSTR) pszDownloadUrl, const(PWSTR) pszDownloadFilePath, 
                    const(PWSTR) pszDownloadMimeType, const(PWSTR) pszEnclosureFilename);
}

@GUID("a74029cc-1f1a-4906-88f0-810638d86591")
interface IFeedsManager : IDispatch
{
    HRESULT get_RootFolder(IDispatch* disp);
    HRESULT IsSubscribed(BSTR feedUrl, VARIANT_BOOL* subscribed);
    HRESULT ExistsFeed(BSTR feedPath, VARIANT_BOOL* exists);
    HRESULT GetFeed(BSTR feedPath, IDispatch* disp);
    HRESULT GetFeedByUrl(BSTR feedUrl, IDispatch* disp);
    HRESULT ExistsFolder(BSTR folderPath, VARIANT_BOOL* exists);
    HRESULT GetFolder(BSTR folderPath, IDispatch* disp);
    HRESULT DeleteFeed(BSTR feedPath);
    HRESULT DeleteFolder(BSTR folderPath);
    HRESULT BackgroundSync(FEEDS_BACKGROUNDSYNC_ACTION action);
    HRESULT get_BackgroundSyncStatus(FEEDS_BACKGROUNDSYNC_STATUS* status);
    HRESULT get_DefaultInterval(int* minutes);
    HRESULT put_DefaultInterval(int minutes);
    HRESULT AsyncSyncAll();
    HRESULT Normalize(BSTR feedXmlIn, BSTR* feedXmlOut);
    HRESULT get_ItemCountLimit(int* itemCountLimit);
}

@GUID("e3cd0028-2eed-4c60-8fae-a3225309a836")
interface IFeedsEnum : IDispatch
{
    HRESULT get_Count(int* count);
    HRESULT Item(int index, IDispatch* disp);
    HRESULT get__NewEnum(IEnumVARIANT* enumVar);
}

@GUID("81f04ad1-4194-4d7d-86d6-11813cec163c")
interface IFeedFolder : IDispatch
{
    HRESULT get_Feeds(IDispatch* disp);
    HRESULT get_Subfolders(IDispatch* disp);
    HRESULT CreateFeed(BSTR feedName, BSTR feedUrl, IDispatch* disp);
    HRESULT CreateSubfolder(BSTR folderName, IDispatch* disp);
    HRESULT ExistsFeed(BSTR feedName, VARIANT_BOOL* exists);
    HRESULT GetFeed(BSTR feedName, IDispatch* disp);
    HRESULT ExistsSubfolder(BSTR folderName, VARIANT_BOOL* exists);
    HRESULT GetSubfolder(BSTR folderName, IDispatch* disp);
    HRESULT Delete();
    HRESULT get_Name(BSTR* folderName);
    HRESULT Rename(BSTR folderName);
    HRESULT get_Path(BSTR* folderPath);
    HRESULT Move(BSTR newParentPath);
    HRESULT get_Parent(IDispatch* disp);
    HRESULT get_IsRoot(VARIANT_BOOL* isRoot);
    HRESULT get_TotalUnreadItemCount(int* count);
    HRESULT get_TotalItemCount(int* count);
    HRESULT GetWatcher(FEEDS_EVENTS_SCOPE scope_, FEEDS_EVENTS_MASK mask, IDispatch* disp);
}

@GUID("20a59fa6-a844-4630-9e98-175f70b4d55b")
interface IFeedFolderEvents : IDispatch
{
    HRESULT Error();
    HRESULT FolderAdded(const(BSTR) path);
    HRESULT FolderDeleted(const(BSTR) path);
    HRESULT FolderRenamed(const(BSTR) path, const(BSTR) oldPath);
    HRESULT FolderMovedFrom(const(BSTR) path, const(BSTR) oldPath);
    HRESULT FolderMovedTo(const(BSTR) path, const(BSTR) oldPath);
    HRESULT FolderItemCountChanged(const(BSTR) path, int itemCountType);
    HRESULT FeedAdded(const(BSTR) path);
    HRESULT FeedDeleted(const(BSTR) path);
    HRESULT FeedRenamed(const(BSTR) path, const(BSTR) oldPath);
    HRESULT FeedUrlChanged(const(BSTR) path);
    HRESULT FeedMovedFrom(const(BSTR) path, const(BSTR) oldPath);
    HRESULT FeedMovedTo(const(BSTR) path, const(BSTR) oldPath);
    HRESULT FeedDownloading(const(BSTR) path);
    HRESULT FeedDownloadCompleted(const(BSTR) path, FEEDS_DOWNLOAD_ERROR error);
    HRESULT FeedItemCountChanged(const(BSTR) path, int itemCountType);
}

@GUID("f7f915d8-2ede-42bc-98e7-a5d05063a757")
interface IFeed : IDispatch
{
    HRESULT Xml(int count, FEEDS_XML_SORT_PROPERTY sortProperty, FEEDS_XML_SORT_ORDER sortOrder, 
                FEEDS_XML_FILTER_FLAGS filterFlags, FEEDS_XML_INCLUDE_FLAGS includeFlags, BSTR* xml);
    HRESULT get_Name(BSTR* name);
    HRESULT Rename(BSTR name);
    HRESULT get_Url(BSTR* feedUrl);
    HRESULT put_Url(BSTR feedUrl);
    HRESULT get_LocalId(BSTR* feedGuid);
    HRESULT get_Path(BSTR* path);
    HRESULT Move(BSTR newParentPath);
    HRESULT get_Parent(IDispatch* disp);
    HRESULT get_LastWriteTime(double* lastWrite);
    HRESULT Delete();
    HRESULT Download();
    HRESULT AsyncDownload();
    HRESULT CancelAsyncDownload();
    HRESULT get_SyncSetting(FEEDS_SYNC_SETTING* syncSetting);
    HRESULT put_SyncSetting(FEEDS_SYNC_SETTING syncSetting);
    HRESULT get_Interval(int* minutes);
    HRESULT put_Interval(int minutes);
    HRESULT get_LastDownloadTime(double* lastDownload);
    HRESULT get_LocalEnclosurePath(BSTR* path);
    HRESULT get_Items(IDispatch* disp);
    HRESULT GetItem(int itemId, IDispatch* disp);
    HRESULT get_Title(BSTR* title);
    HRESULT get_Description(BSTR* description);
    HRESULT get_Link(BSTR* homePage);
    HRESULT get_Image(BSTR* imageUrl);
    HRESULT get_LastBuildDate(double* lastBuildDate);
    HRESULT get_PubDate(double* lastPopulateDate);
    HRESULT get_Ttl(int* ttl);
    HRESULT get_Language(BSTR* language);
    HRESULT get_Copyright(BSTR* copyright);
    HRESULT get_MaxItemCount(int* count);
    HRESULT put_MaxItemCount(int count);
    HRESULT get_DownloadEnclosuresAutomatically(VARIANT_BOOL* downloadEnclosuresAutomatically);
    HRESULT put_DownloadEnclosuresAutomatically(VARIANT_BOOL downloadEnclosuresAutomatically);
    HRESULT get_DownloadStatus(FEEDS_DOWNLOAD_STATUS* status);
    HRESULT get_LastDownloadError(FEEDS_DOWNLOAD_ERROR* error);
    HRESULT Merge(BSTR feedXml, BSTR feedUrl);
    HRESULT get_DownloadUrl(BSTR* feedUrl);
    HRESULT get_IsList(VARIANT_BOOL* isList);
    HRESULT MarkAllItemsRead();
    HRESULT GetWatcher(FEEDS_EVENTS_SCOPE scope_, FEEDS_EVENTS_MASK mask, IDispatch* disp);
    HRESULT get_UnreadItemCount(int* count);
    HRESULT get_ItemCount(int* count);
}

@GUID("33f2ea09-1398-4ab9-b6a4-f94b49d0a42e")
interface IFeed2 : IFeed
{
    HRESULT GetItemByEffectiveId(int itemEffectiveId, IDispatch* disp);
    HRESULT get_LastItemDownloadTime(double* lastItemDownloadTime);
    HRESULT get_Username(BSTR* username);
    HRESULT get_Password(BSTR* password);
    HRESULT SetCredentials(BSTR username, BSTR password);
    HRESULT ClearCredentials();
}

@GUID("abf35c99-0681-47ea-9a8c-1436a375a99e")
interface IFeedEvents : IDispatch
{
    HRESULT Error();
    HRESULT FeedDeleted(const(BSTR) path);
    HRESULT FeedRenamed(const(BSTR) path, const(BSTR) oldPath);
    HRESULT FeedUrlChanged(const(BSTR) path);
    HRESULT FeedMoved(const(BSTR) path, const(BSTR) oldPath);
    HRESULT FeedDownloading(const(BSTR) path);
    HRESULT FeedDownloadCompleted(const(BSTR) path, FEEDS_DOWNLOAD_ERROR error);
    HRESULT FeedItemCountChanged(const(BSTR) path, int itemCountType);
}

@GUID("0a1e6cad-0a47-4da2-a13d-5baaa5c8bd4f")
interface IFeedItem : IDispatch
{
    HRESULT Xml(FEEDS_XML_INCLUDE_FLAGS includeFlags, BSTR* xml);
    HRESULT get_Title(BSTR* title);
    HRESULT get_Link(BSTR* linkUrl);
    HRESULT get_Guid(BSTR* itemGuid);
    HRESULT get_Description(BSTR* description);
    HRESULT get_PubDate(double* pubDate);
    HRESULT get_Comments(BSTR* comments);
    HRESULT get_Author(BSTR* author);
    HRESULT get_Enclosure(IDispatch* disp);
    HRESULT get_IsRead(VARIANT_BOOL* isRead);
    HRESULT put_IsRead(VARIANT_BOOL isRead);
    HRESULT get_LocalId(int* itemId);
    HRESULT get_Parent(IDispatch* disp);
    HRESULT Delete();
    HRESULT get_DownloadUrl(BSTR* itemUrl);
    HRESULT get_LastDownloadTime(double* lastDownload);
    HRESULT get_Modified(double* modified);
}

@GUID("79ac9ef4-f9c1-4d2b-a50b-a7ffba4dcf37")
interface IFeedItem2 : IFeedItem
{
    HRESULT get_EffectiveId(int* effectiveId);
}

@GUID("361c26f7-90a4-4e67-ae09-3a36a546436a")
interface IFeedEnclosure : IDispatch
{
    HRESULT get_Url(BSTR* enclosureUrl);
    HRESULT get_Type(BSTR* mimeType);
    HRESULT get_Length(int* length);
    HRESULT AsyncDownload();
    HRESULT CancelAsyncDownload();
    HRESULT get_DownloadStatus(FEEDS_DOWNLOAD_STATUS* status);
    HRESULT get_LastDownloadError(FEEDS_DOWNLOAD_ERROR* error);
    HRESULT get_LocalPath(BSTR* localPath);
    HRESULT get_Parent(IDispatch* disp);
    HRESULT get_DownloadUrl(BSTR* enclosureUrl);
    HRESULT get_DownloadMimeType(BSTR* mimeType);
    HRESULT RemoveFile();
    HRESULT SetFile(BSTR downloadUrl, BSTR downloadFilePath, BSTR downloadMimeType, BSTR enclosureFilename);
}

@GUID("d3984c13-c3cb-48e2-8be5-5168340b4f35")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/effects/nn-effects-iwmpeffects))], [])
interface IWMPEffects : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/effects/nf-effects-iwmpeffects-render))], [])
    HRESULT Render(TimedLevel* pLevels, HDC hdc, RECT* prc);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/effects/nf-effects-iwmpeffects-mediainfo))], [])
    HRESULT MediaInfo(int lChannelCount, int lSampleRate, BSTR bstrTitle);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/effects/nf-effects-iwmpeffects-getcapabilities))], [])
    HRESULT GetCapabilities(uint* pdwCapabilities);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/effects/nf-effects-iwmpeffects-gettitle))], [])
    HRESULT GetTitle(BSTR* bstrTitle);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/effects/nf-effects-iwmpeffects-getpresettitle))], [])
    HRESULT GetPresetTitle(int nPreset, BSTR* bstrPresetTitle);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/effects/nf-effects-iwmpeffects-getpresetcount))], [])
    HRESULT GetPresetCount(int* pnPresetCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/effects/nf-effects-iwmpeffects-setcurrentpreset))], [])
    HRESULT SetCurrentPreset(int nPreset);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/effects/nf-effects-iwmpeffects-getcurrentpreset))], [])
    HRESULT GetCurrentPreset(int* pnPreset);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/effects/nf-effects-iwmpeffects-displaypropertypage))], [])
    HRESULT DisplayPropertyPage(HWND hwndOwner);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/effects/nf-effects-iwmpeffects-gofullscreen))], [])
    HRESULT GoFullscreen(BOOL fFullScreen);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/effects/nf-effects-iwmpeffects-renderfullscreen))], [])
    HRESULT RenderFullScreen(TimedLevel* pLevels);
}

@GUID("695386ec-aa3c-4618-a5e1-dd9a8b987632")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/effects/nn-effects-iwmpeffects2))], [])
interface IWMPEffects2 : IWMPEffects
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/effects/nf-effects-iwmpeffects2-setcore))], [])
    HRESULT SetCore(IWMPCore pPlayer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/effects/nf-effects-iwmpeffects2-create))], [])
    HRESULT Create(HWND hwndParent);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/effects/nf-effects-iwmpeffects2-destroy))], [])
    HRESULT Destroy();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/effects/nf-effects-iwmpeffects2-notifynewmedia))], [])
    HRESULT NotifyNewMedia(IWMPMedia pMedia);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/effects/nf-effects-iwmpeffects2-onwindowmessage))], [])
    HRESULT OnWindowMessage(uint msg, WPARAM WParam, LPARAM LParam, LRESULT* plResultParam);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/effects/nf-effects-iwmpeffects2-renderwindowed))], [])
    HRESULT RenderWindowed(TimedLevel* pData, BOOL fRequiredRender);
}

@GUID("4c5e8f9f-ad3e-4bf9-9753-fcd30d6d38dd")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmpplug/nn-wmpplug-iwmppluginui))], [])
interface IWMPPluginUI : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmpplug/nf-wmpplug-iwmppluginui-setcore))], [])
    HRESULT SetCore(IWMPCore pCore);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmpplug/nf-wmpplug-iwmppluginui-create))], [])
    HRESULT Create(HWND hwndParent, HWND* phwndWindow);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmpplug/nf-wmpplug-iwmppluginui-destroy))], [])
    HRESULT Destroy();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmpplug/nf-wmpplug-iwmppluginui-displaypropertypage))], [])
    HRESULT DisplayPropertyPage(HWND hwndParent);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmpplug/nf-wmpplug-iwmppluginui-getproperty))], [])
    HRESULT GetProperty(const(PWSTR) pwszName, VARIANT* pvarProperty);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmpplug/nf-wmpplug-iwmppluginui-setproperty))], [])
    HRESULT SetProperty(const(PWSTR) pwszName, const(VARIANT)* pvarProperty);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wmpplug/nf-wmpplug-iwmppluginui-translateaccelerator))], [])
    HRESULT TranslateAccelerator(MSG* lpmsg);
}

@GUID("ad7f4d9c-1a9f-4ed2-9815-ecc0b58cb616")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/nn-contentpartner-iwmpcontentcontainer))], [])
interface IWMPContentContainer : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentcontainer-getid))], [])
    HRESULT GetID(uint* pContentID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentcontainer-getprice))], [])
    HRESULT GetPrice(BSTR* pbstrPrice);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentcontainer-gettype))], [])
    HRESULT GetType(BSTR* pbstrType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentcontainer-getcontentcount))], [])
    HRESULT GetContentCount(uint* pcContent);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentcontainer-getcontentprice))], [])
    HRESULT GetContentPrice(uint idxContent, BSTR* pbstrPrice);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentcontainer-getcontentid))], [])
    HRESULT GetContentID(uint idxContent, uint* pContentID);
}

@GUID("a9937f78-0802-4af8-8b8d-e3f045bc8ab5")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/nn-contentpartner-iwmpcontentcontainerlist))], [])
interface IWMPContentContainerList : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentcontainerlist-gettransactiontype))], [])
    HRESULT GetTransactionType(WMPTransactionType* pwmptt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentcontainerlist-getcontainercount))], [])
    HRESULT GetContainerCount(uint* pcContainer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentcontainerlist-getcontainer))], [])
    HRESULT GetContainer(uint idxContainer, IWMPContentContainer* ppContent);
}

@GUID("9e8f7da2-0695-403c-b697-da10fafaa676")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/nn-contentpartner-iwmpcontentpartnercallback))], [])
interface IWMPContentPartnerCallback : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartnercallback-notify))], [])
    HRESULT Notify(WMPCallbackNotification type, VARIANT* pContext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartnercallback-buycomplete))], [])
    HRESULT BuyComplete(HRESULT hrResult, uint dwBuyCookie);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartnercallback-downloadtrack))], [])
    HRESULT DownloadTrack(uint cookie, BSTR bstrTrackURL, uint dwServiceTrackID, BSTR bstrDownloadParams, 
                          HRESULT hrDownload);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartnercallback-getcatalogversion))], [])
    HRESULT GetCatalogVersion(uint* pdwVersion, uint* pdwSchemaVersion, uint* plcid);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartnercallback-updatedevicecomplete))], [])
    HRESULT UpdateDeviceComplete(BSTR bstrDeviceName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartnercallback-changeview))], [])
    HRESULT ChangeView(BSTR bstrType, BSTR bstrID, BSTR bstrFilter);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartnercallback-addlistcontents))], [])
    HRESULT AddListContents(uint dwListCookie, uint cItems, uint* prgItems);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartnercallback-listcontentscomplete))], [])
    HRESULT ListContentsComplete(uint dwListCookie, HRESULT hrSuccess);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartnercallback-sendmessagecomplete))], [])
    HRESULT SendMessageComplete(BSTR bstrMsg, BSTR bstrParam, BSTR bstrResult);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartnercallback-getcontentidsinlibrary))], [])
    HRESULT GetContentIDsInLibrary(uint* pcContentIDs, uint** pprgIDs);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartnercallback-refreshlicensecomplete))], [])
    HRESULT RefreshLicenseComplete(uint dwCookie, uint contentID, HRESULT hrRefresh);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartnercallback-showpopup))], [])
    HRESULT ShowPopup(int lIndex, BSTR bstrParameters);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartnercallback-verifypermissioncomplete))], [])
    HRESULT VerifyPermissionComplete(BSTR bstrPermission, VARIANT* pContext, HRESULT hrPermission);
}

@GUID("55455073-41b5-4e75-87b8-f13bdb291d08")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/nn-contentpartner-iwmpcontentpartner))], [])
interface IWMPContentPartner : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartner-setcallback))], [])
    HRESULT SetCallback(IWMPContentPartnerCallback pCallback);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartner-notify))], [])
    HRESULT Notify(WMPPartnerNotification type, VARIANT* pContext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartner-getiteminfo))], [])
    HRESULT GetItemInfo(BSTR bstrInfoName, VARIANT* pContext, VARIANT* pData);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartner-getcontentpartnerinfo))], [])
    HRESULT GetContentPartnerInfo(BSTR bstrInfoName, VARIANT* pData);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartner-getcommands))], [])
    HRESULT GetCommands(BSTR location, VARIANT* pLocationContext, BSTR itemLocation, uint cItemIDs, 
                        uint* prgItemIDs, uint* pcItemIDs, WMPContextMenuInfo** pprgItems);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartner-invokecommand))], [])
    HRESULT InvokeCommand(uint dwCommandID, BSTR location, VARIANT* pLocationContext, BSTR itemLocation, 
                          uint cItemIDs, uint* rgItemIDs);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartner-canbuysilent))], [])
    HRESULT CanBuySilent(IWMPContentContainerList pInfo, BSTR* pbstrTotalPrice, VARIANT_BOOL* pSilentOK);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartner-buy))], [])
    HRESULT Buy(IWMPContentContainerList pInfo, uint cookie);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartner-getstreamingurl))], [])
    HRESULT GetStreamingURL(WMPStreamingType st, VARIANT* pStreamContext, BSTR* pbstrURL);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartner-download))], [])
    HRESULT Download(IWMPContentContainerList pInfo, uint cookie);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartner-downloadtrackcomplete))], [])
    HRESULT DownloadTrackComplete(HRESULT hrResult, uint contentID, BSTR downloadTrackParam);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartner-refreshlicense))], [])
    HRESULT RefreshLicense(uint dwCookie, VARIANT_BOOL fLocal, BSTR bstrURL, WMPStreamingType type, uint contentID, 
                           BSTR bstrRefreshReason, VARIANT* pReasonContext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartner-getcatalogurl))], [])
    HRESULT GetCatalogURL(uint dwCatalogVersion, uint dwCatalogSchemaVersion, uint catalogLCID, 
                          uint* pdwNewCatalogVersion, BSTR* pbstrCatalogURL, VARIANT* pExpirationDate);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartner-gettemplate))], [])
    HRESULT GetTemplate(WMPTaskType task, BSTR location, VARIANT* pContext, BSTR clickLocation, 
                        VARIANT* pClickContext, BSTR bstrFilter, BSTR bstrViewParams, BSTR* pbstrTemplateURL, 
                        WMPTemplateSize* pTemplateSize);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartner-updatedevice))], [])
    HRESULT UpdateDevice(BSTR bstrDeviceName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartner-getlistcontents))], [])
    HRESULT GetListContents(BSTR location, VARIANT* pContext, BSTR bstrListType, BSTR bstrParams, 
                            uint dwListCookie);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartner-login))], [])
    HRESULT Login(BLOB userInfo, BLOB pwdInfo, VARIANT_BOOL fUsedCachedCreds, VARIANT_BOOL fOkToCache);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartner-authenticate))], [])
    HRESULT Authenticate(BLOB userInfo, BLOB pwdInfo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartner-logout))], [])
    HRESULT Logout();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartner-sendmessage))], [])
    HRESULT SendMessage(BSTR bstrMsg, BSTR bstrParam);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartner-stationevent))], [])
    HRESULT StationEvent(BSTR bstrStationEventType, uint StationId, uint PlaylistIndex, uint TrackID, 
                         BSTR TrackData, uint dwSecondsPlayed);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartner-comparecontainerlistprices))], [])
    HRESULT CompareContainerListPrices(IWMPContentContainerList pListBase, IWMPContentContainerList pListCompare, 
                                       int* pResult);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartner-verifypermission))], [])
    HRESULT VerifyPermission(BSTR bstrPermission, VARIANT* pContext);
}

@GUID("376055f8-2a59-4a73-9501-dca5273a7a10")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/subscriptionservices/nn-subscriptionservices-iwmpsubscriptionservice))], [])
interface IWMPSubscriptionService : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/subscriptionservices/nf-subscriptionservices-iwmpsubscriptionservice-allowplay))], [])
    HRESULT allowPlay(HWND hwnd, IWMPMedia pMedia, BOOL* pfAllowPlay);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/subscriptionservices/nf-subscriptionservices-iwmpsubscriptionservice-allowcdburn))], [])
    HRESULT allowCDBurn(HWND hwnd, IWMPPlaylist pPlaylist, BOOL* pfAllowBurn);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/subscriptionservices/nf-subscriptionservices-iwmpsubscriptionservice-allowpdatransfer))], [])
    HRESULT allowPDATransfer(HWND hwnd, IWMPPlaylist pPlaylist, BOOL* pfAllowTransfer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/subscriptionservices/nf-subscriptionservices-iwmpsubscriptionservice-startbackgroundprocessing))], [])
    HRESULT startBackgroundProcessing(HWND hwnd);
}

@GUID("dd01d127-2dc2-4c3a-876e-63312079f9b0")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/subscriptionservices/nn-subscriptionservices-iwmpsubscriptionservicecallback))], [])
interface IWMPSubscriptionServiceCallback : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/subscriptionservices/nf-subscriptionservices-iwmpsubscriptionservicecallback-oncomplete))], [])
    HRESULT onComplete(HRESULT hrResult);
}

@GUID("a94c120e-d600-4ec6-b05e-ec9d56d84de0")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/subscriptionservices/nn-subscriptionservices-iwmpsubscriptionservice2))], [])
interface IWMPSubscriptionService2 : IWMPSubscriptionService
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/subscriptionservices/nf-subscriptionservices-iwmpsubscriptionservice2-stopbackgroundprocessing))], [])
    HRESULT stopBackgroundProcessing();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/subscriptionservices/nf-subscriptionservices-iwmpsubscriptionservice2-serviceevent))], [])
    HRESULT serviceEvent(WMPSubscriptionServiceEvent event);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/subscriptionservices/nf-subscriptionservices-iwmpsubscriptionservice2-deviceavailable))], [])
    HRESULT deviceAvailable(BSTR bstrDeviceName, IWMPSubscriptionServiceCallback pCB);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/subscriptionservices/nf-subscriptionservices-iwmpsubscriptionservice2-prepareforsync))], [])
    HRESULT prepareForSync(BSTR bstrFilename, BSTR bstrDeviceName, IWMPSubscriptionServiceCallback pCB);
}

@GUID("c9470e8e-3f6b-46a9-a0a9-452815c34297")
interface IWMPDownloadItem : IDispatch
{
    HRESULT get_sourceURL(BSTR* pbstrURL);
    HRESULT get_size(int* plSize);
    HRESULT get_type(BSTR* pbstrType);
    HRESULT get_progress(int* plProgress);
    HRESULT get_downloadState(WMPSubscriptionDownloadState* pwmpsdls);
    HRESULT pause();
    HRESULT resume();
    HRESULT cancel();
}

@GUID("9fbb3336-6da3-479d-b8ff-67d46e20a987")
interface IWMPDownloadItem2 : IWMPDownloadItem
{
    HRESULT getItemInfo(BSTR bstrItemName, BSTR* pbstrVal);
}

@GUID("0a319c7f-85f9-436c-b88e-82fd88000e1c")
interface IWMPDownloadCollection : IDispatch
{
    HRESULT get_id(int* plId);
    HRESULT get_count(int* plCount);
    HRESULT item(int lItem, IWMPDownloadItem2* ppDownload);
    HRESULT startDownload(BSTR bstrSourceURL, BSTR bstrType, IWMPDownloadItem2* ppDownload);
    HRESULT removeItem(int lItem);
    HRESULT Clear();
}

@GUID("e15e9ad1-8f20-4cc4-9ec7-1a328ca86a0d")
interface IWMPDownloadManager : IDispatch
{
    HRESULT getDownloadCollection(int lCollectionId, IWMPDownloadCollection* ppCollection);
    HRESULT createDownloadCollection(IWMPDownloadCollection* ppCollection);
}


// GUIDs

const GUID CLSID_FeedFolderWatcher      = GUIDOF!FeedFolderWatcher;
const GUID CLSID_FeedWatcher            = GUIDOF!FeedWatcher;
const GUID CLSID_FeedsManager           = GUIDOF!FeedsManager;
const GUID CLSID_WMPLib                 = GUIDOF!WMPLib;
const GUID CLSID_WMPRemoteMediaServices = GUIDOF!WMPRemoteMediaServices;
const GUID CLSID_WindowsMediaPlayer     = GUIDOF!WindowsMediaPlayer;

const GUID IID_IFeed                           = GUIDOF!IFeed;
const GUID IID_IFeed2                          = GUIDOF!IFeed2;
const GUID IID_IFeedEnclosure                  = GUIDOF!IFeedEnclosure;
const GUID IID_IFeedEvents                     = GUIDOF!IFeedEvents;
const GUID IID_IFeedFolder                     = GUIDOF!IFeedFolder;
const GUID IID_IFeedFolderEvents               = GUIDOF!IFeedFolderEvents;
const GUID IID_IFeedItem                       = GUIDOF!IFeedItem;
const GUID IID_IFeedItem2                      = GUIDOF!IFeedItem2;
const GUID IID_IFeedsEnum                      = GUIDOF!IFeedsEnum;
const GUID IID_IFeedsManager                   = GUIDOF!IFeedsManager;
const GUID IID_IWMPAudioRenderConfig           = GUIDOF!IWMPAudioRenderConfig;
const GUID IID_IWMPCdrom                       = GUIDOF!IWMPCdrom;
const GUID IID_IWMPCdromBurn                   = GUIDOF!IWMPCdromBurn;
const GUID IID_IWMPCdromCollection             = GUIDOF!IWMPCdromCollection;
const GUID IID_IWMPCdromRip                    = GUIDOF!IWMPCdromRip;
const GUID IID_IWMPClosedCaption               = GUIDOF!IWMPClosedCaption;
const GUID IID_IWMPClosedCaption2              = GUIDOF!IWMPClosedCaption2;
const GUID IID_IWMPContentContainer            = GUIDOF!IWMPContentContainer;
const GUID IID_IWMPContentContainerList        = GUIDOF!IWMPContentContainerList;
const GUID IID_IWMPContentPartner              = GUIDOF!IWMPContentPartner;
const GUID IID_IWMPContentPartnerCallback      = GUIDOF!IWMPContentPartnerCallback;
const GUID IID_IWMPControls                    = GUIDOF!IWMPControls;
const GUID IID_IWMPControls2                   = GUIDOF!IWMPControls2;
const GUID IID_IWMPControls3                   = GUIDOF!IWMPControls3;
const GUID IID_IWMPConvert                     = GUIDOF!IWMPConvert;
const GUID IID_IWMPCore                        = GUIDOF!IWMPCore;
const GUID IID_IWMPCore2                       = GUIDOF!IWMPCore2;
const GUID IID_IWMPCore3                       = GUIDOF!IWMPCore3;
const GUID IID_IWMPDVD                         = GUIDOF!IWMPDVD;
const GUID IID_IWMPDownloadCollection          = GUIDOF!IWMPDownloadCollection;
const GUID IID_IWMPDownloadItem                = GUIDOF!IWMPDownloadItem;
const GUID IID_IWMPDownloadItem2               = GUIDOF!IWMPDownloadItem2;
const GUID IID_IWMPDownloadManager             = GUIDOF!IWMPDownloadManager;
const GUID IID_IWMPEffects                     = GUIDOF!IWMPEffects;
const GUID IID_IWMPEffects2                    = GUIDOF!IWMPEffects2;
const GUID IID_IWMPError                       = GUIDOF!IWMPError;
const GUID IID_IWMPErrorItem                   = GUIDOF!IWMPErrorItem;
const GUID IID_IWMPErrorItem2                  = GUIDOF!IWMPErrorItem2;
const GUID IID_IWMPEvents                      = GUIDOF!IWMPEvents;
const GUID IID_IWMPEvents2                     = GUIDOF!IWMPEvents2;
const GUID IID_IWMPEvents3                     = GUIDOF!IWMPEvents3;
const GUID IID_IWMPEvents4                     = GUIDOF!IWMPEvents4;
const GUID IID_IWMPFolderMonitorServices       = GUIDOF!IWMPFolderMonitorServices;
const GUID IID_IWMPGraphCreation               = GUIDOF!IWMPGraphCreation;
const GUID IID_IWMPLibrary                     = GUIDOF!IWMPLibrary;
const GUID IID_IWMPLibrary2                    = GUIDOF!IWMPLibrary2;
const GUID IID_IWMPLibraryServices             = GUIDOF!IWMPLibraryServices;
const GUID IID_IWMPLibrarySharingServices      = GUIDOF!IWMPLibrarySharingServices;
const GUID IID_IWMPMedia                       = GUIDOF!IWMPMedia;
const GUID IID_IWMPMedia2                      = GUIDOF!IWMPMedia2;
const GUID IID_IWMPMedia3                      = GUIDOF!IWMPMedia3;
const GUID IID_IWMPMediaCollection             = GUIDOF!IWMPMediaCollection;
const GUID IID_IWMPMediaCollection2            = GUIDOF!IWMPMediaCollection2;
const GUID IID_IWMPMediaPluginRegistrar        = GUIDOF!IWMPMediaPluginRegistrar;
const GUID IID_IWMPMetadataPicture             = GUIDOF!IWMPMetadataPicture;
const GUID IID_IWMPMetadataText                = GUIDOF!IWMPMetadataText;
const GUID IID_IWMPNetwork                     = GUIDOF!IWMPNetwork;
const GUID IID_IWMPNodeRealEstate              = GUIDOF!IWMPNodeRealEstate;
const GUID IID_IWMPNodeRealEstateHost          = GUIDOF!IWMPNodeRealEstateHost;
const GUID IID_IWMPNodeWindowed                = GUIDOF!IWMPNodeWindowed;
const GUID IID_IWMPNodeWindowedHost            = GUIDOF!IWMPNodeWindowedHost;
const GUID IID_IWMPNodeWindowless              = GUIDOF!IWMPNodeWindowless;
const GUID IID_IWMPNodeWindowlessHost          = GUIDOF!IWMPNodeWindowlessHost;
const GUID IID_IWMPPlayer                      = GUIDOF!IWMPPlayer;
const GUID IID_IWMPPlayer2                     = GUIDOF!IWMPPlayer2;
const GUID IID_IWMPPlayer3                     = GUIDOF!IWMPPlayer3;
const GUID IID_IWMPPlayer4                     = GUIDOF!IWMPPlayer4;
const GUID IID_IWMPPlayerApplication           = GUIDOF!IWMPPlayerApplication;
const GUID IID_IWMPPlayerServices              = GUIDOF!IWMPPlayerServices;
const GUID IID_IWMPPlayerServices2             = GUIDOF!IWMPPlayerServices2;
const GUID IID_IWMPPlaylist                    = GUIDOF!IWMPPlaylist;
const GUID IID_IWMPPlaylistArray               = GUIDOF!IWMPPlaylistArray;
const GUID IID_IWMPPlaylistCollection          = GUIDOF!IWMPPlaylistCollection;
const GUID IID_IWMPPlugin                      = GUIDOF!IWMPPlugin;
const GUID IID_IWMPPluginEnable                = GUIDOF!IWMPPluginEnable;
const GUID IID_IWMPPluginUI                    = GUIDOF!IWMPPluginUI;
const GUID IID_IWMPQuery                       = GUIDOF!IWMPQuery;
const GUID IID_IWMPRemoteMediaServices         = GUIDOF!IWMPRemoteMediaServices;
const GUID IID_IWMPRenderConfig                = GUIDOF!IWMPRenderConfig;
const GUID IID_IWMPServices                    = GUIDOF!IWMPServices;
const GUID IID_IWMPSettings                    = GUIDOF!IWMPSettings;
const GUID IID_IWMPSettings2                   = GUIDOF!IWMPSettings2;
const GUID IID_IWMPSkinManager                 = GUIDOF!IWMPSkinManager;
const GUID IID_IWMPStringCollection            = GUIDOF!IWMPStringCollection;
const GUID IID_IWMPStringCollection2           = GUIDOF!IWMPStringCollection2;
const GUID IID_IWMPSubscriptionService         = GUIDOF!IWMPSubscriptionService;
const GUID IID_IWMPSubscriptionService2        = GUIDOF!IWMPSubscriptionService2;
const GUID IID_IWMPSubscriptionServiceCallback = GUIDOF!IWMPSubscriptionServiceCallback;
const GUID IID_IWMPSyncDevice                  = GUIDOF!IWMPSyncDevice;
const GUID IID_IWMPSyncDevice2                 = GUIDOF!IWMPSyncDevice2;
const GUID IID_IWMPSyncDevice3                 = GUIDOF!IWMPSyncDevice3;
const GUID IID_IWMPSyncServices                = GUIDOF!IWMPSyncServices;
const GUID IID_IWMPTranscodePolicy             = GUIDOF!IWMPTranscodePolicy;
const GUID IID_IWMPUserEventSink               = GUIDOF!IWMPUserEventSink;
const GUID IID_IWMPVideoRenderConfig           = GUIDOF!IWMPVideoRenderConfig;
const GUID IID_IWMPWindowMessageSink           = GUIDOF!IWMPWindowMessageSink;
const GUID IID_IXFeed                          = GUIDOF!IXFeed;
const GUID IID_IXFeed2                         = GUIDOF!IXFeed2;
const GUID IID_IXFeedEnclosure                 = GUIDOF!IXFeedEnclosure;
const GUID IID_IXFeedEvents                    = GUIDOF!IXFeedEvents;
const GUID IID_IXFeedFolder                    = GUIDOF!IXFeedFolder;
const GUID IID_IXFeedFolderEvents              = GUIDOF!IXFeedFolderEvents;
const GUID IID_IXFeedItem                      = GUIDOF!IXFeedItem;
const GUID IID_IXFeedItem2                     = GUIDOF!IXFeedItem2;
const GUID IID_IXFeedsEnum                     = GUIDOF!IXFeedsEnum;
const GUID IID_IXFeedsManager                  = GUIDOF!IXFeedsManager;
const GUID IID__WMPOCXEvents                   = GUIDOF!_WMPOCXEvents;
