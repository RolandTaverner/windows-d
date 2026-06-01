// Written in the D programming language.

module windows.win32.media.mediaplayer;

public import windows.core;
public import system.system : Guid;
public import windows.win32.foundation.foundation : BOOL, BSTR, HRESULT, HWND, LPARAM,
                                                    LRESULT, PWSTR, RECT, SIZE,
                                                    SYSTEMTIME, VARIANT_BOOL, WPARAM;
public import windows.win32.graphics.gdi : HDC;
public import windows.win32.media.mediafoundation : IMFActivate;
public import windows.win32.system.com.com : BLOB, IDispatch, IStream, IUnknown;
public import windows.win32.system.ole : IEnumVARIANT;
public import windows.win32.system.variant : VARIANT;
public import windows.win32.ui.windowsandmessaging : MSG;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/ne-wmp-wmpopenstate
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/ne-wmp-wmpplaystate
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/ne-wmp-wmpplaylistchangeeventtype
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/ne-wmp-wmpsyncstate
enum WMPSyncState : int
{
    wmpssUnknown       = 0x00000000,
    wmpssSynchronizing = 0x00000001,
    wmpssStopped       = 0x00000002,
    wmpssEstimating    = 0x00000003,
    wmpssLast          = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/ne-wmp-wmpdevicestatus
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/ne-wmp-wmpripstate
enum WMPRipState : int
{
    wmprsUnknown = 0x00000000,
    wmprsRipping = 0x00000001,
    wmprsStopped = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/ne-wmp-wmpburnformat
enum WMPBurnFormat : int
{
    wmpbfAudioCD = 0x00000000,
    wmpbfDataCD  = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/ne-wmp-wmpburnstate
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/ne-wmp-wmpstringcollectionchangeeventtype
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/ne-wmp-wmplibrarytype
enum WMPLibraryType : int
{
    wmpltUnknown        = 0x00000000,
    wmpltAll            = 0x00000001,
    wmpltLocal          = 0x00000002,
    wmpltRemote         = 0x00000003,
    wmpltDisc           = 0x00000004,
    wmpltPortableDevice = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/ne-wmp-wmpfolderscanstate
enum WMPFolderScanState : int
{
    wmpfssUnknown  = 0x00000000,
    wmpfssScanning = 0x00000001,
    wmpfssUpdating = 0x00000002,
    wmpfssStopped  = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmpservices/ne-wmpservices-wmpservices_streamstate
alias WMPServices_StreamState = int;
enum : int
{
    WMPServices_StreamState_Stop  = 0x00000000,
    WMPServices_StreamState_Pause = 0x00000001,
    WMPServices_StreamState_Play  = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmpservices/ne-wmpservices-wmpplugin_caps
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/effects/ne-effects-playerstate
enum PlayerState : int
{
    stop_state  = 0x00000000,
    pause_state = 0x00000001,
    play_state  = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/ne-contentpartner-wmppartnernotification
enum WMPPartnerNotification : int
{
    wmpsnBackgroundProcessingBegin = 0x00000001,
    wmpsnBackgroundProcessingEnd   = 0x00000002,
    wmpsnCatalogDownloadFailure    = 0x00000003,
    wmpsnCatalogDownloadComplete   = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/ne-contentpartner-wmpcallbacknotification
enum WMPCallbackNotification : int
{
    wmpcnLoginStateChange     = 0x00000001,
    wmpcnAuthResult           = 0x00000002,
    wmpcnLicenseUpdated       = 0x00000003,
    wmpcnNewCatalogAvailable  = 0x00000004,
    wmpcnNewPluginAvailable   = 0x00000005,
    wmpcnDisableRadioSkipping = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/ne-contentpartner-wmptasktype
enum WMPTaskType : int
{
    wmpttBrowse  = 0x00000001,
    wmpttSync    = 0x00000002,
    wmpttBurn    = 0x00000003,
    wmpttCurrent = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/ne-contentpartner-wmptransactiontype
enum WMPTransactionType : int
{
    wmpttNoTransaction = 0x00000000,
    wmpttDownload      = 0x00000001,
    wmpttBuy           = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/ne-contentpartner-wmptemplatesize
enum WMPTemplateSize : int
{
    wmptsSmall  = 0x00000000,
    wmptsMedium = 0x00000001,
    wmptsLarge  = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/ne-contentpartner-wmpstreamingtype
enum WMPStreamingType : int
{
    wmpstUnknown = 0x00000000,
    wmpstMusic   = 0x00000001,
    wmpstVideo   = 0x00000002,
    wmpstRadio   = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/ne-contentpartner-wmpaccounttype
enum WMPAccountType : int
{
    wmpatBuyOnly      = 0x00000001,
    wmpatSubscription = 0x00000002,
    wmpatJanus        = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/subscriptionservices/ne-subscriptionservices-wmpsubscriptionserviceevent
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
    WMPGC_FLAGS_ALLOW_PREROLL    = 0x00000001U,
    WMPGC_FLAGS_SUPPRESS_DIALOGS = 0x00000002U,
    WMPGC_FLAGS_IGNORE_AV_SYNC   = 0x00000004U,
    WMPGC_FLAGS_DISABLE_PLUGINS  = 0x00000008U,
    WMPGC_FLAGS_USE_CUSTOM_GRAPH = 0x00000010U,
}

enum uint WMPUE_EC_USER = 0x00008100U;

enum : uint
{
    WMP_MDRT_FLAGS_UNREPORTED_DELETED_ITEMS = 0x00000001U,
    WMP_MDRT_FLAGS_UNREPORTED_ADDED_ITEMS   = 0x00000002U,
}

enum uint IOCTL_WMP_METADATA_ROUND_TRIP = 0x31504d57U;
enum uint IOCTL_WMP_DEVICE_CAN_SYNC = 0x32504d57U;
enum uint EFFECT_CANGOFULLSCREEN = 0x00000001U;
enum uint EFFECT_HASPROPERTYPAGE = 0x00000002U;
enum uint EFFECT_VARIABLEFREQSTEP = 0x00000004U;
enum uint EFFECT_WINDOWEDONLY = 0x00000008U;
enum uint EFFECT2_FULLSCREENEXCLUSIVE = 0x00000010U;
enum uint SA_BUFFER_SIZE = 0x00000400U;

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
    PLUGIN_TYPE_BACKGROUND     = 0x00000001U,
    PLUGIN_TYPE_SEPARATEWINDOW = 0x00000002U,
    PLUGIN_TYPE_DISPLAYAREA    = 0x00000003U,
    PLUGIN_TYPE_SETTINGSAREA   = 0x00000004U,
    PLUGIN_TYPE_METADATAAREA   = 0x00000005U,
}

enum : uint
{
    PLUGIN_FLAGS_HASPROPERTYPAGE    = 0x80000000U,
    PLUGIN_FLAGS_INSTALLAUTORUN     = 0x40000000U,
    PLUGIN_FLAGS_LAUNCHPROPERTYPAGE = 0x20000000U,
    PLUGIN_FLAGS_ACCEPTSMEDIA       = 0x10000000U,
    PLUGIN_FLAGS_ACCEPTSPLAYLISTS   = 0x08000000U,
    PLUGIN_FLAGS_HASPRESETS         = 0x04000000U,
    PLUGIN_FLAGS_HIDDEN             = 0x02000000U,
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
    SUBSCRIPTION_CAP_DEVICEAVAILABLE      = 0x00000010U,
    SUBSCRIPTION_CAP_BACKGROUNDPROCESSING = 0x00000008U,
    SUBSCRIPTION_CAP_IS_CONTENTPARTNER    = 0x00000040U,
    SUBSCRIPTION_CAP_ALTLOGIN             = 0x00000080U,
    SUBSCRIPTION_CAP_ALLOWPLAY            = 0x00000001U,
    SUBSCRIPTION_CAP_ALLOWCDBURN          = 0x00000002U,
    SUBSCRIPTION_CAP_ALLOWPDATRANSFER     = 0x00000004U,
    SUBSCRIPTION_CAP_PREPAREFORSYNC       = 0x00000020U,
    SUBSCRIPTION_V1_CAPS                  = 0x0000000fU,
    SUBSCRIPTION_CAP_UILESSMODE_ALLOWPLAY = 0x00000100U,
}

enum : const(wchar)*
{
    WMP_SUBSCR_DL_TYPE_BACKGROUND = "background",
    WMP_SUBSCR_DL_TYPE_REALTIME   = "real time",
}

enum : uint
{
    DISPID_FEEDS_RootFolder           = 0x00001000U,
    DISPID_FEEDS_IsSubscribed         = 0x00001001U,
    DISPID_FEEDS_ExistsFeed           = 0x00001002U,
    DISPID_FEEDS_GetFeed              = 0x00001003U,
    DISPID_FEEDS_ExistsFolder         = 0x00001004U,
    DISPID_FEEDS_GetFolder            = 0x00001005U,
    DISPID_FEEDS_DeleteFeed           = 0x00001006U,
    DISPID_FEEDS_DeleteFolder         = 0x00001007U,
    DISPID_FEEDS_GetFeedByUrl         = 0x00001008U,
    DISPID_FEEDS_BackgroundSync       = 0x00001009U,
    DISPID_FEEDS_BackgroundSyncStatus = 0x0000100aU,
}

enum : uint
{
    DISPID_FEEDS_DefaultInterval           = 0x0000100bU,
    DISPID_FEEDS_AsyncSyncAll              = 0x0000100cU,
    DISPID_FEEDS_Normalize                 = 0x0000100dU,
    DISPID_FEEDS_ItemCountLimit            = 0x0000100eU,
    DISPID_FEEDSENUM_Count                 = 0x00002000U,
    DISPID_FEEDSENUM_Item                  = 0x00002001U,
    DISPID_FEEDFOLDER_Feeds                = 0x00003000U,
    DISPID_FEEDFOLDER_Subfolders           = 0x00003001U,
    DISPID_FEEDFOLDER_CreateFeed           = 0x00003002U,
    DISPID_FEEDFOLDER_CreateSubfolder      = 0x00003003U,
    DISPID_FEEDFOLDER_ExistsFeed           = 0x00003004U,
    DISPID_FEEDFOLDER_GetFeed              = 0x00003005U,
    DISPID_FEEDFOLDER_ExistsSubfolder      = 0x00003006U,
    DISPID_FEEDFOLDER_GetSubfolder         = 0x00003007U,
    DISPID_FEEDFOLDER_Delete               = 0x00003008U,
    DISPID_FEEDFOLDER_Name                 = 0x00003009U,
    DISPID_FEEDFOLDER_Rename               = 0x0000300aU,
    DISPID_FEEDFOLDER_Path                 = 0x0000300bU,
    DISPID_FEEDFOLDER_Move                 = 0x0000300cU,
    DISPID_FEEDFOLDER_Parent               = 0x0000300dU,
    DISPID_FEEDFOLDER_IsRoot               = 0x0000300eU,
    DISPID_FEEDFOLDER_TotalUnreadItemCount = 0x0000300fU,
    DISPID_FEEDFOLDER_TotalItemCount       = 0x00003010U,
    DISPID_FEEDFOLDER_GetWatcher           = 0x00003011U,
}

enum : uint
{
    DISPID_FEED_Xml                 = 0x00004000U,
    DISPID_FEED_Name                = 0x00004001U,
    DISPID_FEED_Rename              = 0x00004002U,
    DISPID_FEED_Url                 = 0x00004003U,
    DISPID_FEED_LocalId             = 0x00004004U,
    DISPID_FEED_Path                = 0x00004005U,
    DISPID_FEED_Move                = 0x00004006U,
    DISPID_FEED_Parent              = 0x00004007U,
    DISPID_FEED_LastWriteTime       = 0x00004008U,
    DISPID_FEED_Delete              = 0x00004009U,
    DISPID_FEED_Download            = 0x0000400aU,
    DISPID_FEED_AsyncDownload       = 0x0000400bU,
    DISPID_FEED_CancelAsyncDownload = 0x0000400cU,
}

enum : uint
{
    DISPID_FEED_Interval           = 0x0000400dU,
    DISPID_FEED_SyncSetting        = 0x0000400eU,
    DISPID_FEED_LastDownloadTime   = 0x0000400fU,
    DISPID_FEED_LocalEnclosurePath = 0x00004010U,
}

enum : uint
{
    DISPID_FEED_Items                           = 0x00004011U,
    DISPID_FEED_GetItem                         = 0x00004012U,
    DISPID_FEED_Title                           = 0x00004013U,
    DISPID_FEED_Description                     = 0x00004014U,
    DISPID_FEED_Link                            = 0x00004015U,
    DISPID_FEED_Image                           = 0x00004016U,
    DISPID_FEED_LastBuildDate                   = 0x00004017U,
    DISPID_FEED_PubDate                         = 0x00004018U,
    DISPID_FEED_Ttl                             = 0x00004019U,
    DISPID_FEED_Language                        = 0x0000401aU,
    DISPID_FEED_Copyright                       = 0x0000401bU,
    DISPID_FEED_DownloadEnclosuresAutomatically = 0x0000401cU,
    DISPID_FEED_DownloadStatus                  = 0x0000401dU,
    DISPID_FEED_LastDownloadError               = 0x0000401eU,
    DISPID_FEED_Merge                           = 0x0000401fU,
    DISPID_FEED_DownloadUrl                     = 0x00004020U,
    DISPID_FEED_IsList                          = 0x00004021U,
    DISPID_FEED_MarkAllItemsRead                = 0x00004022U,
    DISPID_FEED_GetWatcher                      = 0x00004023U,
    DISPID_FEED_UnreadItemCount                 = 0x00004024U,
    DISPID_FEED_ItemCount                       = 0x00004025U,
    DISPID_FEED_MaxItemCount                    = 0x00004026U,
    DISPID_FEED_GetItemByEffectiveId            = 0x00004027U,
}

enum uint DISPID_FEED_LastItemDownloadTime = 0x00004028U;

enum : uint
{
    DISPID_FEED_Username         = 0x00004029U,
    DISPID_FEED_Password         = 0x0000402aU,
    DISPID_FEED_SetCredentials   = 0x0000402bU,
    DISPID_FEED_ClearCredentials = 0x0000402cU,
}

enum : uint
{
    DISPID_FEEDITEM_Xml                      = 0x00005000U,
    DISPID_FEEDITEM_Title                    = 0x00005001U,
    DISPID_FEEDITEM_Link                     = 0x00005002U,
    DISPID_FEEDITEM_Guid                     = 0x00005003U,
    DISPID_FEEDITEM_Description              = 0x00005004U,
    DISPID_FEEDITEM_PubDate                  = 0x00005005U,
    DISPID_FEEDITEM_Comments                 = 0x00005006U,
    DISPID_FEEDITEM_Author                   = 0x00005007U,
    DISPID_FEEDITEM_Enclosure                = 0x00005008U,
    DISPID_FEEDITEM_IsRead                   = 0x00005009U,
    DISPID_FEEDITEM_LocalId                  = 0x0000500aU,
    DISPID_FEEDITEM_Parent                   = 0x0000500bU,
    DISPID_FEEDITEM_Delete                   = 0x0000500cU,
    DISPID_FEEDITEM_DownloadUrl              = 0x0000500dU,
    DISPID_FEEDITEM_LastDownloadTime         = 0x0000500eU,
    DISPID_FEEDITEM_Modified                 = 0x0000500fU,
    DISPID_FEEDITEM_EffectiveId              = 0x00005010U,
    DISPID_FEEDENCLOSURE_Url                 = 0x00006000U,
    DISPID_FEEDENCLOSURE_Type                = 0x00006001U,
    DISPID_FEEDENCLOSURE_Length              = 0x00006002U,
    DISPID_FEEDENCLOSURE_AsyncDownload       = 0x00006003U,
    DISPID_FEEDENCLOSURE_CancelAsyncDownload = 0x00006004U,
    DISPID_FEEDENCLOSURE_DownloadStatus      = 0x00006005U,
    DISPID_FEEDENCLOSURE_LastDownloadError   = 0x00006006U,
    DISPID_FEEDENCLOSURE_LocalPath           = 0x00006007U,
    DISPID_FEEDENCLOSURE_Parent              = 0x00006008U,
    DISPID_FEEDENCLOSURE_DownloadUrl         = 0x00006009U,
    DISPID_FEEDENCLOSURE_DownloadMimeType    = 0x0000600aU,
    DISPID_FEEDENCLOSURE_RemoveFile          = 0x0000600bU,
    DISPID_FEEDENCLOSURE_SetFile             = 0x0000600cU,
}

enum : uint
{
    DISPID_FEEDFOLDEREVENTS_Error                  = 0x00007000U,
    DISPID_FEEDFOLDEREVENTS_FolderAdded            = 0x00007001U,
    DISPID_FEEDFOLDEREVENTS_FolderDeleted          = 0x00007002U,
    DISPID_FEEDFOLDEREVENTS_FolderRenamed          = 0x00007003U,
    DISPID_FEEDFOLDEREVENTS_FolderMovedFrom        = 0x00007004U,
    DISPID_FEEDFOLDEREVENTS_FolderMovedTo          = 0x00007005U,
    DISPID_FEEDFOLDEREVENTS_FolderItemCountChanged = 0x00007006U,
    DISPID_FEEDFOLDEREVENTS_FeedAdded              = 0x00007007U,
    DISPID_FEEDFOLDEREVENTS_FeedDeleted            = 0x00007008U,
    DISPID_FEEDFOLDEREVENTS_FeedRenamed            = 0x00007009U,
    DISPID_FEEDFOLDEREVENTS_FeedUrlChanged         = 0x0000700aU,
    DISPID_FEEDFOLDEREVENTS_FeedMovedFrom          = 0x0000700bU,
    DISPID_FEEDFOLDEREVENTS_FeedMovedTo            = 0x0000700cU,
    DISPID_FEEDFOLDEREVENTS_FeedDownloading        = 0x0000700dU,
    DISPID_FEEDFOLDEREVENTS_FeedDownloadCompleted  = 0x0000700eU,
    DISPID_FEEDFOLDEREVENTS_FeedItemCountChanged   = 0x0000700fU,
}

enum : uint
{
    DISPID_FEEDEVENTS_Error                 = 0x00008000U,
    DISPID_FEEDEVENTS_FeedDeleted           = 0x00008001U,
    DISPID_FEEDEVENTS_FeedRenamed           = 0x00008002U,
    DISPID_FEEDEVENTS_FeedUrlChanged        = 0x00008003U,
    DISPID_FEEDEVENTS_FeedMoved             = 0x00008004U,
    DISPID_FEEDEVENTS_FeedDownloading       = 0x00008005U,
    DISPID_FEEDEVENTS_FeedDownloadCompleted = 0x00008006U,
    DISPID_FEEDEVENTS_FeedItemCountChanged  = 0x00008007U,
}

enum : uint
{
    DISPID_DELTA                      = 0x00000032U,
    DISPID_WMPCORE_BASE               = 0x00000000U,
    DISPID_WMPCORE_URL                = 0x00000001U,
    DISPID_WMPCORE_OPENSTATE          = 0x00000002U,
    DISPID_WMPCORE_CLOSE              = 0x00000003U,
    DISPID_WMPCORE_CONTROLS           = 0x00000004U,
    DISPID_WMPCORE_SETTINGS           = 0x00000005U,
    DISPID_WMPCORE_CURRENTMEDIA       = 0x00000006U,
    DISPID_WMPCORE_NETWORK            = 0x00000007U,
    DISPID_WMPCORE_MEDIACOLLECTION    = 0x00000008U,
    DISPID_WMPCORE_PLAYLISTCOLLECTION = 0x00000009U,
    DISPID_WMPCORE_PLAYSTATE          = 0x0000000aU,
    DISPID_WMPCORE_VERSIONINFO        = 0x0000000bU,
    DISPID_WMPCORE_LAUNCHURL          = 0x0000000cU,
    DISPID_WMPCORE_CURRENTPLAYLIST    = 0x0000000dU,
    DISPID_WMPCORE_CDROMCOLLECTION    = 0x0000000eU,
    DISPID_WMPCORE_CLOSEDCAPTION      = 0x0000000fU,
    DISPID_WMPCORE_ISONLINE           = 0x00000010U,
    DISPID_WMPCORE_ERROR              = 0x00000011U,
    DISPID_WMPCORE_STATUS             = 0x00000012U,
    DISPID_WMPCORE_LAST               = 0x00000012U,
    DISPID_WMPOCX_BASE                = 0x00000012U,
    DISPID_WMPOCX_ENABLED             = 0x00000013U,
    DISPID_WMPOCX_TRANSPARENTATSTART  = 0x00000014U,
    DISPID_WMPOCX_FULLSCREEN          = 0x00000015U,
    DISPID_WMPOCX_ENABLECONTEXTMENU   = 0x00000016U,
    DISPID_WMPOCX_UIMODE              = 0x00000017U,
    DISPID_WMPOCX_LAST                = 0x00000017U,
    DISPID_WMPOCX2_BASE               = 0x00000017U,
    DISPID_WMPOCX2_STRETCHTOFIT       = 0x00000018U,
    DISPID_WMPOCX2_WINDOWLESSVIDEO    = 0x00000019U,
    DISPID_WMPOCX4_ISREMOTE           = 0x0000001aU,
    DISPID_WMPOCX4_PLAYERAPPLICATION  = 0x0000001bU,
    DISPID_WMPOCX4_OPENPLAYER         = 0x0000001cU,
}

enum : uint
{
    DISPID_WMPCORE2_BASE                          = 0x00000027U,
    DISPID_WMPCORE2_DVD                           = 0x00000028U,
    DISPID_WMPCORE3_NEWPLAYLIST                   = 0x00000029U,
    DISPID_WMPCORE3_NEWMEDIA                      = 0x0000002aU,
    DISPID_WMPCONTROLS_PLAY                       = 0x00000033U,
    DISPID_WMPCONTROLS_STOP                       = 0x00000034U,
    DISPID_WMPCONTROLS_PAUSE                      = 0x00000035U,
    DISPID_WMPCONTROLS_FASTFORWARD                = 0x00000036U,
    DISPID_WMPCONTROLS_FASTREVERSE                = 0x00000037U,
    DISPID_WMPCONTROLS_CURRENTPOSITION            = 0x00000038U,
    DISPID_WMPCONTROLS_CURRENTPOSITIONSTRING      = 0x00000039U,
    DISPID_WMPCONTROLS_NEXT                       = 0x0000003aU,
    DISPID_WMPCONTROLS_PREVIOUS                   = 0x0000003bU,
    DISPID_WMPCONTROLS_CURRENTITEM                = 0x0000003cU,
    DISPID_WMPCONTROLS_CURRENTMARKER              = 0x0000003dU,
    DISPID_WMPCONTROLS_ISAVAILABLE                = 0x0000003eU,
    DISPID_WMPCONTROLS_PLAYITEM                   = 0x0000003fU,
    DISPID_WMPCONTROLS2_STEP                      = 0x00000040U,
    DISPID_WMPCONTROLS3_AUDIOLANGUAGECOUNT        = 0x00000041U,
    DISPID_WMPCONTROLS3_GETAUDIOLANGUAGEID        = 0x00000042U,
    DISPID_WMPCONTROLS3_GETAUDIOLANGUAGEDESC      = 0x00000043U,
    DISPID_WMPCONTROLS3_CURRENTAUDIOLANGUAGE      = 0x00000044U,
    DISPID_WMPCONTROLS3_CURRENTAUDIOLANGUAGEINDEX = 0x00000045U,
    DISPID_WMPCONTROLS3_GETLANGUAGENAME           = 0x00000046U,
    DISPID_WMPCONTROLS3_CURRENTPOSITIONTIMECODE   = 0x00000047U,
    DISPID_WMPCONTROLSFAKE_TIMECOMPRESSION        = 0x00000048U,
}

enum : uint
{
    DISPID_WMPSETTINGS_AUTOSTART                   = 0x00000065U,
    DISPID_WMPSETTINGS_BALANCE                     = 0x00000066U,
    DISPID_WMPSETTINGS_INVOKEURLS                  = 0x00000067U,
    DISPID_WMPSETTINGS_MUTE                        = 0x00000068U,
    DISPID_WMPSETTINGS_PLAYCOUNT                   = 0x00000069U,
    DISPID_WMPSETTINGS_RATE                        = 0x0000006aU,
    DISPID_WMPSETTINGS_VOLUME                      = 0x0000006bU,
    DISPID_WMPSETTINGS_BASEURL                     = 0x0000006cU,
    DISPID_WMPSETTINGS_DEFAULTFRAME                = 0x0000006dU,
    DISPID_WMPSETTINGS_GETMODE                     = 0x0000006eU,
    DISPID_WMPSETTINGS_SETMODE                     = 0x0000006fU,
    DISPID_WMPSETTINGS_ENABLEERRORDIALOGS          = 0x00000070U,
    DISPID_WMPSETTINGS_ISAVAILABLE                 = 0x00000071U,
    DISPID_WMPSETTINGS2_DEFAULTAUDIOLANGUAGE       = 0x00000072U,
    DISPID_WMPSETTINGS2_LIBRARYACCESSRIGHTS        = 0x00000073U,
    DISPID_WMPSETTINGS2_REQUESTLIBRARYACCESSRIGHTS = 0x00000074U,
}

enum : uint
{
    DISPID_WMPPLAYLIST_COUNT          = 0x000000c9U,
    DISPID_WMPPLAYLIST_NAME           = 0x000000caU,
    DISPID_WMPPLAYLIST_GETITEMINFO    = 0x000000cbU,
    DISPID_WMPPLAYLIST_SETITEMINFO    = 0x000000ccU,
    DISPID_WMPPLAYLIST_CLEAR          = 0x000000cdU,
    DISPID_WMPPLAYLIST_INSERTITEM     = 0x000000ceU,
    DISPID_WMPPLAYLIST_APPENDITEM     = 0x000000cfU,
    DISPID_WMPPLAYLIST_REMOVEITEM     = 0x000000d0U,
    DISPID_WMPPLAYLIST_MOVEITEM       = 0x000000d1U,
    DISPID_WMPPLAYLIST_ATTRIBUTECOUNT = 0x000000d2U,
    DISPID_WMPPLAYLIST_ATTRIBUTENAME  = 0x000000d3U,
    DISPID_WMPPLAYLIST_ITEM           = 0x000000d4U,
    DISPID_WMPPLAYLIST_ISIDENTICAL    = 0x000000d5U,
}

enum : uint
{
    DISPID_WMPCDROM_DRIVESPECIFIER                  = 0x000000fbU,
    DISPID_WMPCDROM_PLAYLIST                        = 0x000000fcU,
    DISPID_WMPCDROM_EJECT                           = 0x000000fdU,
    DISPID_WMPCDROMCOLLECTION_COUNT                 = 0x0000012dU,
    DISPID_WMPCDROMCOLLECTION_ITEM                  = 0x0000012eU,
    DISPID_WMPCDROMCOLLECTION_GETBYDRIVESPECIFIER   = 0x0000012fU,
    DISPID_WMPCDROMCOLLECTION_STARTMONITORINGCDROMS = 0x00000130U,
    DISPID_WMPCDROMCOLLECTION_STOPMONITORINGCDROMS  = 0x00000131U,
}

enum : uint
{
    DISPID_WMPSTRINGCOLLECTION_COUNT = 0x00000191U,
    DISPID_WMPSTRINGCOLLECTION_ITEM  = 0x00000192U,
}

enum : uint
{
    DISPID_WMPMEDIACOLLECTION_ADD                          = 0x000001c4U,
    DISPID_WMPMEDIACOLLECTION_GETALL                       = 0x000001c5U,
    DISPID_WMPMEDIACOLLECTION_GETBYNAME                    = 0x000001c6U,
    DISPID_WMPMEDIACOLLECTION_GETBYGENRE                   = 0x000001c7U,
    DISPID_WMPMEDIACOLLECTION_GETBYAUTHOR                  = 0x000001c8U,
    DISPID_WMPMEDIACOLLECTION_GETBYALBUM                   = 0x000001c9U,
    DISPID_WMPMEDIACOLLECTION_GETBYATTRIBUTE               = 0x000001caU,
    DISPID_WMPMEDIACOLLECTION_REMOVE                       = 0x000001cbU,
    DISPID_WMPMEDIACOLLECTION_GETATTRIBUTESTRINGCOLLECTION = 0x000001cdU,
    DISPID_WMPMEDIACOLLECTION_NEWQUERY                     = 0x000001ceU,
    DISPID_WMPMEDIACOLLECTION_STARTMONITORING              = 0x000001cfU,
    DISPID_WMPMEDIACOLLECTION_STOPMONITORING               = 0x000001d0U,
    DISPID_WMPMEDIACOLLECTION_STARTCONTENTSCAN             = 0x000001d1U,
    DISPID_WMPMEDIACOLLECTION_STOPCONTENTSCAN              = 0x000001d2U,
    DISPID_WMPMEDIACOLLECTION_STARTSEARCH                  = 0x000001d3U,
    DISPID_WMPMEDIACOLLECTION_STOPSEARCH                   = 0x000001d4U,
    DISPID_WMPMEDIACOLLECTION_UPDATEMETADATA               = 0x000001d5U,
    DISPID_WMPMEDIACOLLECTION_GETMEDIAATOM                 = 0x000001d6U,
    DISPID_WMPMEDIACOLLECTION_SETDELETED                   = 0x000001d7U,
    DISPID_WMPMEDIACOLLECTION_ISDELETED                    = 0x000001d8U,
    DISPID_WMPMEDIACOLLECTION_GETBYQUERYDESCRIPTION        = 0x000001d9U,
    DISPID_WMPMEDIACOLLECTION_FREEZECOLLECTIONCHANGE       = 0x000001daU,
    DISPID_WMPMEDIACOLLECTION_UNFREEZECOLLECTIONCHANGE     = 0x000001dbU,
    DISPID_WMPMEDIACOLLECTION_POSTCOLLECTIONCHANGE         = 0x000001dcU,
}

enum : uint
{
    DISPID_WMPPLAYLISTARRAY_COUNT                      = 0x000001f5U,
    DISPID_WMPPLAYLISTARRAY_ITEM                       = 0x000001f6U,
    DISPID_WMPPLAYLISTCOLLECTION_NEWPLAYLIST           = 0x00000228U,
    DISPID_WMPPLAYLISTCOLLECTION_GETALL                = 0x00000229U,
    DISPID_WMPPLAYLISTCOLLECTION_GETBYNAME             = 0x0000022aU,
    DISPID_WMPPLAYLISTCOLLECTION_GETBYQUERYDESCRIPTION = 0x0000022bU,
    DISPID_WMPPLAYLISTCOLLECTION_REMOVE                = 0x0000022cU,
    DISPID_WMPPLAYLISTCOLLECTION_NEWQUERY              = 0x0000022dU,
    DISPID_WMPPLAYLISTCOLLECTION_STARTMONITORING       = 0x0000022eU,
    DISPID_WMPPLAYLISTCOLLECTION_STOPMONITORING        = 0x0000022fU,
    DISPID_WMPPLAYLISTCOLLECTION_SETDELETED            = 0x00000230U,
    DISPID_WMPPLAYLISTCOLLECTION_ISDELETED             = 0x00000231U,
    DISPID_WMPPLAYLISTCOLLECTION_IMPORTPLAYLIST        = 0x00000232U,
}

enum : uint
{
    DISPID_WMPMEDIA_SOURCEURL                = 0x000002efU,
    DISPID_WMPMEDIA_IMAGESOURCEWIDTH         = 0x000002f0U,
    DISPID_WMPMEDIA_IMAGESOURCEHEIGHT        = 0x000002f1U,
    DISPID_WMPMEDIA_MARKERCOUNT              = 0x000002f2U,
    DISPID_WMPMEDIA_GETMARKERTIME            = 0x000002f3U,
    DISPID_WMPMEDIA_GETMARKERNAME            = 0x000002f4U,
    DISPID_WMPMEDIA_DURATION                 = 0x000002f5U,
    DISPID_WMPMEDIA_DURATIONSTRING           = 0x000002f6U,
    DISPID_WMPMEDIA_ATTRIBUTECOUNT           = 0x000002f7U,
    DISPID_WMPMEDIA_GETATTRIBUTENAME         = 0x000002f8U,
    DISPID_WMPMEDIA_GETITEMINFO              = 0x000002f9U,
    DISPID_WMPMEDIA_SETITEMINFO              = 0x000002faU,
    DISPID_WMPMEDIA_ISIDENTICAL              = 0x000002fbU,
    DISPID_WMPMEDIA_NAME                     = 0x000002fcU,
    DISPID_WMPMEDIA_GETITEMINFOBYATOM        = 0x000002fdU,
    DISPID_WMPMEDIA_ISMEMBEROF               = 0x000002feU,
    DISPID_WMPMEDIA_ISREADONLYITEM           = 0x000002ffU,
    DISPID_WMPMEDIA2_ERROR                   = 0x00000300U,
    DISPID_WMPMEDIA3_GETATTRIBUTECOUNTBYTYPE = 0x00000301U,
    DISPID_WMPMEDIA3_GETITEMINFOBYTYPE       = 0x00000302U,
}

enum : uint
{
    DISPID_WMPNETWORK_BANDWIDTH              = 0x00000321U,
    DISPID_WMPNETWORK_RECOVEREDPACKETS       = 0x00000322U,
    DISPID_WMPNETWORK_SOURCEPROTOCOL         = 0x00000323U,
    DISPID_WMPNETWORK_RECEIVEDPACKETS        = 0x00000324U,
    DISPID_WMPNETWORK_LOSTPACKETS            = 0x00000325U,
    DISPID_WMPNETWORK_RECEPTIONQUALITY       = 0x00000326U,
    DISPID_WMPNETWORK_BUFFERINGCOUNT         = 0x00000327U,
    DISPID_WMPNETWORK_BUFFERINGPROGRESS      = 0x00000328U,
    DISPID_WMPNETWORK_BUFFERINGTIME          = 0x00000329U,
    DISPID_WMPNETWORK_FRAMERATE              = 0x0000032aU,
    DISPID_WMPNETWORK_MAXBITRATE             = 0x0000032bU,
    DISPID_WMPNETWORK_BITRATE                = 0x0000032cU,
    DISPID_WMPNETWORK_GETPROXYSETTINGS       = 0x0000032dU,
    DISPID_WMPNETWORK_SETPROXYSETTINGS       = 0x0000032eU,
    DISPID_WMPNETWORK_GETPROXYNAME           = 0x0000032fU,
    DISPID_WMPNETWORK_SETPROXYNAME           = 0x00000330U,
    DISPID_WMPNETWORK_GETPROXYPORT           = 0x00000331U,
    DISPID_WMPNETWORK_SETPROXYPORT           = 0x00000332U,
    DISPID_WMPNETWORK_GETPROXYEXCEPTIONLIST  = 0x00000333U,
    DISPID_WMPNETWORK_SETPROXYEXCEPTIONLIST  = 0x00000334U,
    DISPID_WMPNETWORK_GETPROXYBYPASSFORLOCAL = 0x00000335U,
    DISPID_WMPNETWORK_SETPROXYBYPASSFORLOCAL = 0x00000336U,
    DISPID_WMPNETWORK_MAXBANDWIDTH           = 0x00000337U,
    DISPID_WMPNETWORK_DOWNLOADPROGRESS       = 0x00000338U,
    DISPID_WMPNETWORK_ENCODEDFRAMERATE       = 0x00000339U,
    DISPID_WMPNETWORK_FRAMESSKIPPED          = 0x0000033aU,
}

enum : uint
{
    DISPID_WMPERROR_CLEARERRORQUEUE      = 0x00000353U,
    DISPID_WMPERROR_ERRORCOUNT           = 0x00000354U,
    DISPID_WMPERROR_ITEM                 = 0x00000355U,
    DISPID_WMPERROR_WEBHELP              = 0x00000356U,
    DISPID_WMPERRORITEM_ERRORCODE        = 0x00000385U,
    DISPID_WMPERRORITEM_ERRORDESCRIPTION = 0x00000386U,
    DISPID_WMPERRORITEM_ERRORCONTEXT     = 0x00000387U,
    DISPID_WMPERRORITEM_REMEDY           = 0x00000388U,
    DISPID_WMPERRORITEM_CUSTOMURL        = 0x00000389U,
    DISPID_WMPERRORITEM2_CONDITION       = 0x0000038aU,
}

enum : uint
{
    DISPID_WMPCLOSEDCAPTION_SAMISTYLE      = 0x000003b7U,
    DISPID_WMPCLOSEDCAPTION_SAMILANG       = 0x000003b8U,
    DISPID_WMPCLOSEDCAPTION_SAMIFILENAME   = 0x000003b9U,
    DISPID_WMPCLOSEDCAPTION_CAPTIONINGID   = 0x000003baU,
    DISPID_WMPCLOSEDCAPTION2_GETLANGCOUNT  = 0x000003bbU,
    DISPID_WMPCLOSEDCAPTION2_GETLANGNAME   = 0x000003bcU,
    DISPID_WMPCLOSEDCAPTION2_GETLANGID     = 0x000003bdU,
    DISPID_WMPCLOSEDCAPTION2_GETSTYLECOUNT = 0x000003beU,
    DISPID_WMPCLOSEDCAPTION2_GETSTYLENAME  = 0x000003bfU,
}

enum : uint
{
    DISPID_WMPDVD_ISAVAILABLE              = 0x000003e9U,
    DISPID_WMPDVD_DOMAIN                   = 0x000003eaU,
    DISPID_WMPDVD_TOPMENU                  = 0x000003ebU,
    DISPID_WMPDVD_TITLEMENU                = 0x000003ecU,
    DISPID_WMPDVD_BACK                     = 0x000003edU,
    DISPID_WMPDVD_RESUME                   = 0x000003eeU,
    DISPID_WMPMETADATA_PICTURE_MIMETYPE    = 0x0000041bU,
    DISPID_WMPMETADATA_PICTURE_PICTURETYPE = 0x0000041cU,
    DISPID_WMPMETADATA_PICTURE_DESCRIPTION = 0x0000041dU,
    DISPID_WMPMETADATA_PICTURE_URL         = 0x0000041eU,
    DISPID_WMPMETADATA_TEXT_TEXT           = 0x0000041fU,
    DISPID_WMPMETADATA_TEXT_DESCRIPTION    = 0x00000420U,
}

enum : uint
{
    DISPID_WMPPLAYERAPP_SWITCHTOPLAYERAPPLICATION = 0x0000044dU,
    DISPID_WMPPLAYERAPP_SWITCHTOCONTROL           = 0x0000044eU,
    DISPID_WMPPLAYERAPP_PLAYERDOCKED              = 0x0000044fU,
    DISPID_WMPPLAYERAPP_HASDISPLAY                = 0x00000450U,
    DISPID_WMPPLAYERAPP_REMOTESTATUS              = 0x00000451U,
}

enum : uint
{
    DISPID_WMPDOWNLOADMANAGER_GETDOWNLOADCOLLECTION    = 0x0000047fU,
    DISPID_WMPDOWNLOADMANAGER_CREATEDOWNLOADCOLLECTION = 0x00000480U,
}

enum : uint
{
    DISPID_WMPDOWNLOADCOLLECTION_ID            = 0x000004b1U,
    DISPID_WMPDOWNLOADCOLLECTION_COUNT         = 0x000004b2U,
    DISPID_WMPDOWNLOADCOLLECTION_ITEM          = 0x000004b3U,
    DISPID_WMPDOWNLOADCOLLECTION_STARTDOWNLOAD = 0x000004b4U,
    DISPID_WMPDOWNLOADCOLLECTION_REMOVEITEM    = 0x000004b5U,
    DISPID_WMPDOWNLOADCOLLECTION_CLEAR         = 0x000004b6U,
    DISPID_WMPDOWNLOADITEM_SOURCEURL           = 0x000004e3U,
    DISPID_WMPDOWNLOADITEM_SIZE                = 0x000004e4U,
    DISPID_WMPDOWNLOADITEM_TYPE                = 0x000004e5U,
    DISPID_WMPDOWNLOADITEM_PROGRESS            = 0x000004e6U,
    DISPID_WMPDOWNLOADITEM_DOWNLOADSTATE       = 0x000004e7U,
    DISPID_WMPDOWNLOADITEM_PAUSE               = 0x000004e8U,
    DISPID_WMPDOWNLOADITEM_RESUME              = 0x000004e9U,
    DISPID_WMPDOWNLOADITEM_CANCEL              = 0x000004eaU,
    DISPID_WMPDOWNLOADITEM2_GETITEMINFO        = 0x00000515U,
}

enum : uint
{
    DISPID_WMPQUERY_ADDCONDITION   = 0x00000547U,
    DISPID_WMPQUERY_BEGINNEXTGROUP = 0x00000548U,
}

enum : uint
{
    DISPID_WMPMEDIACOLLECTION2_CREATEQUERY           = 0x00000579U,
    DISPID_WMPMEDIACOLLECTION2_GETPLAYLISTBYQUERY    = 0x0000057aU,
    DISPID_WMPMEDIACOLLECTION2_GETSTRINGCOLLBYQUERY  = 0x0000057bU,
    DISPID_WMPMEDIACOLLECTION2_GETBYATTRANDMEDIATYPE = 0x0000057cU,
}

enum : uint
{
    DISPID_WMPSTRINGCOLLECTION2_ISIDENTICAL        = 0x000005abU,
    DISPID_WMPSTRINGCOLLECTION2_GETITEMINFO        = 0x000005acU,
    DISPID_WMPSTRINGCOLLECTION2_GETATTRCOUNTBYTYPE = 0x000005adU,
    DISPID_WMPSTRINGCOLLECTION2_GETITEMINFOBYTYPE  = 0x000005aeU,
}

enum : uint
{
    DISPID_WMPCORE_MIN = 0x00000001U,
    DISPID_WMPCORE_MAX = 0x000005aeU,
}

enum uint WMPCOREEVENT_BASE = 0x00001388U;

enum : uint
{
    DISPID_WMPCOREEVENT_OPENSTATECHANGE = 0x00001389U,
    DISPID_WMPCOREEVENT_STATUSCHANGE    = 0x0000138aU,
}

enum uint WMPCOREEVENT_CONTROL_BASE = 0x000013ecU;

enum : uint
{
    DISPID_WMPCOREEVENT_PLAYSTATECHANGE     = 0x000013edU,
    DISPID_WMPCOREEVENT_AUDIOLANGUAGECHANGE = 0x000013eeU,
}

enum uint WMPCOREEVENT_SEEK_BASE = 0x00001450U;

enum : uint
{
    DISPID_WMPCOREEVENT_ENDOFSTREAM        = 0x00001451U,
    DISPID_WMPCOREEVENT_POSITIONCHANGE     = 0x00001452U,
    DISPID_WMPCOREEVENT_MARKERHIT          = 0x00001453U,
    DISPID_WMPCOREEVENT_DURATIONUNITCHANGE = 0x00001454U,
}

enum uint WMPCOREEVENT_CONTENT_BASE = 0x000014b4U;
enum uint DISPID_WMPCOREEVENT_SCRIPTCOMMAND = 0x000014b5U;
enum uint WMPCOREEVENT_NETWORK_BASE = 0x00001518U;

enum : uint
{
    DISPID_WMPCOREEVENT_DISCONNECT = 0x00001519U,
    DISPID_WMPCOREEVENT_BUFFERING  = 0x0000151aU,
    DISPID_WMPCOREEVENT_NEWSTREAM  = 0x0000151bU,
}

enum uint WMPCOREEVENT_ERROR_BASE = 0x0000157cU;
enum uint DISPID_WMPCOREEVENT_ERROR = 0x0000157dU;
enum uint WMPCOREEVENT_WARNING_BASE = 0x000015e0U;
enum uint DISPID_WMPCOREEVENT_WARNING = 0x000015e1U;
enum uint WMPCOREEVENT_CDROM_BASE = 0x00001644U;
enum uint DISPID_WMPCOREEVENT_CDROMMEDIACHANGE = 0x00001645U;
enum uint WMPCOREEVENT_PLAYLIST_BASE = 0x000016a8U;

enum : uint
{
    DISPID_WMPCOREEVENT_PLAYLISTCHANGE                        = 0x000016a9U,
    DISPID_WMPCOREEVENT_MEDIACHANGE                           = 0x000016aaU,
    DISPID_WMPCOREEVENT_CURRENTMEDIAITEMAVAILABLE             = 0x000016abU,
    DISPID_WMPCOREEVENT_CURRENTPLAYLISTCHANGE                 = 0x000016acU,
    DISPID_WMPCOREEVENT_CURRENTPLAYLISTITEMAVAILABLE          = 0x000016adU,
    DISPID_WMPCOREEVENT_CURRENTITEMCHANGE                     = 0x000016aeU,
    DISPID_WMPCOREEVENT_MEDIACOLLECTIONCHANGE                 = 0x000016afU,
    DISPID_WMPCOREEVENT_MEDIACOLLECTIONATTRIBUTESTRINGADDED   = 0x000016b0U,
    DISPID_WMPCOREEVENT_MEDIACOLLECTIONATTRIBUTESTRINGREMOVED = 0x000016b1U,
}

enum : uint
{
    DISPID_WMPCOREEVENT_PLAYLISTCOLLECTIONCHANGE          = 0x000016b2U,
    DISPID_WMPCOREEVENT_PLAYLISTCOLLECTIONPLAYLISTADDED   = 0x000016b3U,
    DISPID_WMPCOREEVENT_PLAYLISTCOLLECTIONPLAYLISTREMOVED = 0x000016b4U,
}

enum : uint
{
    DISPID_WMPCOREEVENT_MEDIACOLLECTIONCONTENTSCANADDEDITEM    = 0x000016b5U,
    DISPID_WMPCOREEVENT_MEDIACOLLECTIONCONTENTSCANPROGRESS     = 0x000016b6U,
    DISPID_WMPCOREEVENT_MEDIACOLLECTIONSEARCHFOUNDITEM         = 0x000016b7U,
    DISPID_WMPCOREEVENT_MEDIACOLLECTIONSEARCHPROGRESS          = 0x000016b8U,
    DISPID_WMPCOREEVENT_MEDIACOLLECTIONSEARCHCOMPLETE          = 0x000016b9U,
    DISPID_WMPCOREEVENT_PLAYLISTCOLLECTIONPLAYLISTSETASDELETED = 0x000016baU,
}

enum : uint
{
    DISPID_WMPCOREEVENT_MODECHANGE                            = 0x000016bbU,
    DISPID_WMPCOREEVENT_MEDIACOLLECTIONATTRIBUTESTRINGCHANGED = 0x000016bcU,
    DISPID_WMPCOREEVENT_MEDIAERROR                            = 0x000016bdU,
    DISPID_WMPCOREEVENT_DOMAINCHANGE                          = 0x000016beU,
    DISPID_WMPCOREEVENT_OPENPLAYLISTSWITCH                    = 0x000016bfU,
    DISPID_WMPCOREEVENT_STRINGCOLLECTIONCHANGE                = 0x000016c0U,
    DISPID_WMPCOREEVENT_MEDIACOLLECTIONMEDIAADDED             = 0x000016c1U,
    DISPID_WMPCOREEVENT_MEDIACOLLECTIONMEDIAREMOVED           = 0x000016c2U,
}

enum uint WMPOCXEVENT_BASE = 0x00001964U;

enum : uint
{
    DISPID_WMPOCXEVENT_SWITCHEDTOPLAYERAPPLICATION = 0x00001965U,
    DISPID_WMPOCXEVENT_SWITCHEDTOCONTROL           = 0x00001966U,
    DISPID_WMPOCXEVENT_PLAYERDOCKEDSTATECHANGE     = 0x00001967U,
    DISPID_WMPOCXEVENT_PLAYERRECONNECT             = 0x00001968U,
    DISPID_WMPOCXEVENT_CLICK                       = 0x00001969U,
    DISPID_WMPOCXEVENT_DOUBLECLICK                 = 0x0000196aU,
    DISPID_WMPOCXEVENT_KEYDOWN                     = 0x0000196bU,
    DISPID_WMPOCXEVENT_KEYPRESS                    = 0x0000196cU,
    DISPID_WMPOCXEVENT_KEYUP                       = 0x0000196dU,
    DISPID_WMPOCXEVENT_MOUSEDOWN                   = 0x0000196eU,
    DISPID_WMPOCXEVENT_MOUSEMOVE                   = 0x0000196fU,
    DISPID_WMPOCXEVENT_MOUSEUP                     = 0x00001970U,
    DISPID_WMPOCXEVENT_DEVICECONNECT               = 0x00001971U,
    DISPID_WMPOCXEVENT_DEVICEDISCONNECT            = 0x00001972U,
    DISPID_WMPOCXEVENT_DEVICESTATUSCHANGE          = 0x00001973U,
    DISPID_WMPOCXEVENT_DEVICESYNCSTATECHANGE       = 0x00001974U,
    DISPID_WMPOCXEVENT_DEVICESYNCERROR             = 0x00001975U,
    DISPID_WMPOCXEVENT_CREATEPARTNERSHIPCOMPLETE   = 0x00001976U,
    DISPID_WMPOCXEVENT_CDROMRIPSTATECHANGE         = 0x00001977U,
    DISPID_WMPOCXEVENT_CDROMRIPMEDIAERROR          = 0x00001978U,
    DISPID_WMPOCXEVENT_CDROMBURNSTATECHANGE        = 0x00001979U,
    DISPID_WMPOCXEVENT_CDROMBURNMEDIAERROR         = 0x0000197aU,
    DISPID_WMPOCXEVENT_CDROMBURNERROR              = 0x0000197bU,
    DISPID_WMPOCXEVENT_LIBRARYCONNECT              = 0x0000197cU,
    DISPID_WMPOCXEVENT_LIBRARYDISCONNECT           = 0x0000197dU,
    DISPID_WMPOCXEVENT_FOLDERSCANSTATECHANGE       = 0x0000197eU,
    DISPID_WMPOCXEVENT_DEVICEESTIMATION            = 0x0000197fU,
}

enum : uint
{
    DISPID_WMPCONTROLS_BASE        = 0x00000032U,
    DISPID_WMPSETTINGS_BASE        = 0x00000064U,
    DISPID_WMPPLAYLIST_BASE        = 0x000000c8U,
    DISPID_WMPCDROM_BASE           = 0x000000faU,
    DISPID_WMPCDROMCOLLECTION_BASE = 0x0000012cU,
}

enum uint DISPID_WMPSTRINGCOLLECTION_BASE = 0x00000190U;
enum uint DISPID_WMPMEDIACOLLECTION_BASE = 0x000001c2U;

enum : uint
{
    DISPID_WMPPLAYLISTARRAY_BASE      = 0x000001f4U,
    DISPID_WMPPLAYLISTCOLLECTION_BASE = 0x00000226U,
}

enum : uint
{
    DISPID_WMPMEDIA_BASE         = 0x000002eeU,
    DISPID_WMPNETWORK_BASE       = 0x00000320U,
    DISPID_WMPERROR_BASE         = 0x00000352U,
    DISPID_WMPERRORITEM_BASE     = 0x00000384U,
    DISPID_WMPCLOSEDCAPTION_BASE = 0x000003b6U,
}

enum : uint
{
    DISPID_WMPDVD_BASE                = 0x000003e8U,
    DISPID_WMPMETADATA_BASE           = 0x0000041aU,
    DISPID_WMPPLAYERAPP_BASE          = 0x0000044cU,
    DISPID_WMPDOWNLOADMANAGER_BASE    = 0x0000047eU,
    DISPID_WMPDOWNLOADCOLLECTION_BASE = 0x000004b0U,
    DISPID_WMPDOWNLOADITEM_BASE       = 0x000004e2U,
    DISPID_WMPDOWNLOADITEM2_BASE      = 0x00000514U,
}

enum : uint
{
    DISPID_WMPQUERY_BASE            = 0x00000546U,
    DISPID_WMPMEDIACOLLECTION2_BASE = 0x00000578U,
}

enum uint DISPID_WMPSTRINGCOLLECTION2_BASE = 0x000005aaU;

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


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/effects/ns-effects-timedlevel
struct TimedLevel
{
    ubyte[2048] frequency;
    ubyte[2048] waveform;
    int         state;
    long        timeStamp;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/ns-contentpartner-wmpcontextmenuinfo
struct WMPContextMenuInfo
{
    uint dwID;
    BSTR bstrMenuText;
    BSTR bstrHelpText;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmpdevices/ns-wmpdevices-wmp_wmdm_metadata_round_trip_pc2device
struct WMP_WMDM_METADATA_ROUND_TRIP_PC2DEVICE
{
align (1):
    uint dwChangesSinceTransactionID;
    uint dwResultSetStartingIndex;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmpdevices/ns-wmpdevices-wmp_wmdm_metadata_round_trip_device2pc
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmperroritem
@GUID("3614c646-3b3b-4de7-a81e-930e3f2127b3")
interface IWMPErrorItem : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmperroritem-get_errorcode
    HRESULT get_errorCode(int* phr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmperroritem-get_errordescription
    HRESULT get_errorDescription(BSTR* pbstrDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmperroritem-get_errorcontext
    HRESULT get_errorContext(VARIANT* pvarContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmperroritem-get_remedy
    HRESULT get_remedy(int* plRemedy);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmperroritem-get_customurl
    HRESULT get_customUrl(BSTR* pbstrCustomUrl);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmperror
@GUID("a12dcf7d-14ab-4c1b-a8cd-63909f06025b")
interface IWMPError : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmperror-clearerrorqueue
    HRESULT clearErrorQueue();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmperror-get_errorcount
    HRESULT get_errorCount(int* plNumErrors);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmperror-get_item
    HRESULT get_item(int dwIndex, IWMPErrorItem* ppErrorItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmperror-webhelp
    HRESULT webHelp();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpmedia
@GUID("94d55e95-3fac-11d3-b155-00c04f79faa6")
interface IWMPMedia : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmedia-get_isidentical
    HRESULT get_isIdentical(IWMPMedia pIWMPMedia, VARIANT_BOOL* pvbool);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmedia-get_sourceurl
    HRESULT get_sourceURL(BSTR* pbstrSourceURL);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmedia-get_name
    HRESULT get_name(BSTR* pbstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmedia-put_name
    HRESULT put_name(BSTR bstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmedia-get_imagesourcewidth
    HRESULT get_imageSourceWidth(int* pWidth);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmedia-get_imagesourceheight
    HRESULT get_imageSourceHeight(int* pHeight);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmedia-get_markercount
    HRESULT get_markerCount(int* pMarkerCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmedia-getmarkertime
    HRESULT getMarkerTime(int MarkerNum, double* pMarkerTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmedia-getmarkername
    HRESULT getMarkerName(int MarkerNum, BSTR* pbstrMarkerName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmedia-get_duration
    HRESULT get_duration(double* pDuration);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmedia-get_durationstring
    HRESULT get_durationString(BSTR* pbstrDuration);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmedia-get_attributecount
    HRESULT get_attributeCount(int* plCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmedia-getattributename
    HRESULT getAttributeName(int lIndex, BSTR* pbstrItemName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmedia-getiteminfo
    HRESULT getItemInfo(BSTR bstrItemName, BSTR* pbstrVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmedia-setiteminfo
    HRESULT setItemInfo(BSTR bstrItemName, BSTR bstrVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmedia-getiteminfobyatom
    HRESULT getItemInfoByAtom(int lAtom, BSTR* pbstrVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmedia-ismemberof
    HRESULT isMemberOf(IWMPPlaylist pPlaylist, VARIANT_BOOL* pvarfIsMemberOf);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmedia-isreadonlyitem
    HRESULT isReadOnlyItem(BSTR bstrItemName, VARIANT_BOOL* pvarfIsReadOnly);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpcontrols
@GUID("74c09e02-f828-11d2-a74b-00a0c905f36e")
interface IWMPControls : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols-get_isavailable
    HRESULT get_isAvailable(BSTR bstrItem, VARIANT_BOOL* pIsAvailable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols-play
    HRESULT play();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols-stop
    HRESULT stop();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols-pause
    HRESULT pause();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols-fastforward
    HRESULT fastForward();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols-fastreverse
    HRESULT fastReverse();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols-get_currentposition
    HRESULT get_currentPosition(double* pdCurrentPosition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols-put_currentposition
    HRESULT put_currentPosition(double dCurrentPosition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols-get_currentpositionstring
    HRESULT get_currentPositionString(BSTR* pbstrCurrentPosition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols-next
    HRESULT next();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols-previous
    HRESULT previous();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols-get_currentitem
    HRESULT get_currentItem(IWMPMedia* ppIWMPMedia);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols-put_currentitem
    HRESULT put_currentItem(IWMPMedia pIWMPMedia);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols-get_currentmarker
    HRESULT get_currentMarker(int* plMarker);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols-put_currentmarker
    HRESULT put_currentMarker(int lMarker);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols-playitem
    HRESULT playItem(IWMPMedia pIWMPMedia);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpsettings
@GUID("9104d1ab-80c9-4fed-abf0-2e6417a6df14")
interface IWMPSettings : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings-get_isavailable
    HRESULT get_isAvailable(BSTR bstrItem, VARIANT_BOOL* pIsAvailable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings-get_autostart
    HRESULT get_autoStart(VARIANT_BOOL* pfAutoStart);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings-put_autostart
    HRESULT put_autoStart(VARIANT_BOOL fAutoStart);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings-get_baseurl
    HRESULT get_baseURL(BSTR* pbstrBaseURL);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings-put_baseurl
    HRESULT put_baseURL(BSTR bstrBaseURL);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings-get_defaultframe
    HRESULT get_defaultFrame(BSTR* pbstrDefaultFrame);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings-put_defaultframe
    HRESULT put_defaultFrame(BSTR bstrDefaultFrame);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings-get_invokeurls
    HRESULT get_invokeURLs(VARIANT_BOOL* pfInvokeURLs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings-put_invokeurls
    HRESULT put_invokeURLs(VARIANT_BOOL fInvokeURLs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings-get_mute
    HRESULT get_mute(VARIANT_BOOL* pfMute);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings-put_mute
    HRESULT put_mute(VARIANT_BOOL fMute);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings-get_playcount
    HRESULT get_playCount(int* plCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings-put_playcount
    HRESULT put_playCount(int lCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings-get_rate
    HRESULT get_rate(double* pdRate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings-put_rate
    HRESULT put_rate(double dRate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings-get_balance
    HRESULT get_balance(int* plBalance);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings-put_balance
    HRESULT put_balance(int lBalance);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings-get_volume
    HRESULT get_volume(int* plVolume);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings-put_volume
    HRESULT put_volume(int lVolume);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings-getmode
    HRESULT getMode(BSTR bstrMode, VARIANT_BOOL* pvarfMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings-setmode
    HRESULT setMode(BSTR bstrMode, VARIANT_BOOL varfMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings-get_enableerrordialogs
    HRESULT get_enableErrorDialogs(VARIANT_BOOL* pfEnableErrorDialogs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings-put_enableerrordialogs
    HRESULT put_enableErrorDialogs(VARIANT_BOOL fEnableErrorDialogs);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpclosedcaption
@GUID("4f2df574-c588-11d3-9ed0-00c04fb6e937")
interface IWMPClosedCaption : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpclosedcaption-get_samistyle
    HRESULT get_SAMIStyle(BSTR* pbstrSAMIStyle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpclosedcaption-put_samistyle
    HRESULT put_SAMIStyle(BSTR bstrSAMIStyle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpclosedcaption-get_samilang
    HRESULT get_SAMILang(BSTR* pbstrSAMILang);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpclosedcaption-put_samilang
    HRESULT put_SAMILang(BSTR bstrSAMILang);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpclosedcaption-get_samifilename
    HRESULT get_SAMIFileName(BSTR* pbstrSAMIFileName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpclosedcaption-put_samifilename
    HRESULT put_SAMIFileName(BSTR bstrSAMIFileName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpclosedcaption-get_captioningid
    HRESULT get_captioningId(BSTR* pbstrCaptioningID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpclosedcaption-put_captioningid
    HRESULT put_captioningId(BSTR bstrCaptioningID);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpplaylist
@GUID("d5f0f4f1-130c-11d3-b14e-00c04f79faa6")
interface IWMPPlaylist : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplaylist-get_count
    HRESULT get_count(int* plCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplaylist-get_name
    HRESULT get_name(BSTR* pbstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplaylist-put_name
    HRESULT put_name(BSTR bstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplaylist-get_attributecount
    HRESULT get_attributeCount(int* plCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplaylist-get_attributename
    HRESULT get_attributeName(int lIndex, BSTR* pbstrAttributeName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplaylist-get_item
    HRESULT get_item(int lIndex, IWMPMedia* ppIWMPMedia);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplaylist-getiteminfo
    HRESULT getItemInfo(BSTR bstrName, BSTR* pbstrVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplaylist-setiteminfo
    HRESULT setItemInfo(BSTR bstrName, BSTR bstrValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplaylist-get_isidentical
    HRESULT get_isIdentical(IWMPPlaylist pIWMPPlaylist, VARIANT_BOOL* pvbool);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplaylist-clear
    HRESULT clear();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplaylist-insertitem
    HRESULT insertItem(int lIndex, IWMPMedia pIWMPMedia);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplaylist-appenditem
    HRESULT appendItem(IWMPMedia pIWMPMedia);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplaylist-removeitem
    HRESULT removeItem(IWMPMedia pIWMPMedia);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplaylist-moveitem
    HRESULT moveItem(int lIndexOld, int lIndexNew);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpcdrom
@GUID("cfab6e98-8730-11d3-b388-00c04f68574b")
interface IWMPCdrom : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcdrom-get_drivespecifier
    HRESULT get_driveSpecifier(BSTR* pbstrDrive);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcdrom-get_playlist
    HRESULT get_playlist(IWMPPlaylist* ppPlaylist);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcdrom-eject
    HRESULT eject();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpcdromcollection
@GUID("ee4c8fe2-34b2-11d3-a3bf-006097c9b344")
interface IWMPCdromCollection : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcdromcollection-get_count
    HRESULT get_count(int* plCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcdromcollection-item
    HRESULT item(int lIndex, IWMPCdrom* ppItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcdromcollection-getbydrivespecifier
    HRESULT getByDriveSpecifier(BSTR bstrDriveSpecifier, IWMPCdrom* ppCdrom);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpstringcollection
@GUID("4a976298-8c0d-11d3-b389-00c04f68574b")
interface IWMPStringCollection : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpstringcollection-get_count
    HRESULT get_count(int* plCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpstringcollection-item
    HRESULT item(int lIndex, BSTR* pbstrString);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpmediacollection
@GUID("8363bc22-b4b4-4b19-989d-1cd765749dd1")
interface IWMPMediaCollection : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmediacollection-add
    HRESULT add(BSTR bstrURL, IWMPMedia* ppItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmediacollection-getall
    HRESULT getAll(IWMPPlaylist* ppMediaItems);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmediacollection-getbyname
    HRESULT getByName(BSTR bstrName, IWMPPlaylist* ppMediaItems);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmediacollection-getbygenre
    HRESULT getByGenre(BSTR bstrGenre, IWMPPlaylist* ppMediaItems);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmediacollection-getbyauthor
    HRESULT getByAuthor(BSTR bstrAuthor, IWMPPlaylist* ppMediaItems);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmediacollection-getbyalbum
    HRESULT getByAlbum(BSTR bstrAlbum, IWMPPlaylist* ppMediaItems);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmediacollection-getbyattribute
    HRESULT getByAttribute(BSTR bstrAttribute, BSTR bstrValue, IWMPPlaylist* ppMediaItems);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmediacollection-remove
    HRESULT remove(IWMPMedia pItem, VARIANT_BOOL varfDeleteFile);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmediacollection-getattributestringcollection
    HRESULT getAttributeStringCollection(BSTR bstrAttribute, BSTR bstrMediaType, 
                                         IWMPStringCollection* ppStringCollection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmediacollection-getmediaatom
    HRESULT getMediaAtom(BSTR bstrItemName, int* plAtom);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmediacollection-setdeleted
    HRESULT setDeleted(IWMPMedia pItem, VARIANT_BOOL varfIsDeleted);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpmediacollection
    HRESULT isDeleted(IWMPMedia pItem, VARIANT_BOOL* pvarfIsDeleted);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpplaylistarray
@GUID("679409c0-99f7-11d3-9fb7-00105aa620bb")
interface IWMPPlaylistArray : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplaylistarray-get_count
    HRESULT get_count(int* plCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplaylistarray-item
    HRESULT item(int lIndex, IWMPPlaylist* ppItem);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpplaylistcollection
@GUID("10a13217-23a7-439b-b1c0-d847c79b7774")
interface IWMPPlaylistCollection : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplaylistcollection-newplaylist
    HRESULT newPlaylist(BSTR bstrName, IWMPPlaylist* ppItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplaylistcollection-getall
    HRESULT getAll(IWMPPlaylistArray* ppPlaylistArray);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplaylistcollection-getbyname
    HRESULT getByName(BSTR bstrName, IWMPPlaylistArray* ppPlaylistArray);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplaylistcollection-remove
    HRESULT remove(IWMPPlaylist pItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpplaylistcollection
    HRESULT setDeleted(IWMPPlaylist pItem, VARIANT_BOOL varfIsDeleted);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplaylistcollection-isdeleted
    HRESULT isDeleted(IWMPPlaylist pItem, VARIANT_BOOL* pvarfIsDeleted);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplaylistcollection-importplaylist
    HRESULT importPlaylist(IWMPPlaylist pItem, IWMPPlaylist* ppImportedItem);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpnetwork
@GUID("ec21b779-edef-462d-bba4-ad9dde2b29a7")
interface IWMPNetwork : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-get_bandwidth
    HRESULT get_bandWidth(int* plBandwidth);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-get_recoveredpackets
    HRESULT get_recoveredPackets(int* plRecoveredPackets);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-get_sourceprotocol
    HRESULT get_sourceProtocol(BSTR* pbstrSourceProtocol);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-get_receivedpackets
    HRESULT get_receivedPackets(int* plReceivedPackets);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-get_lostpackets
    HRESULT get_lostPackets(int* plLostPackets);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-get_receptionquality
    HRESULT get_receptionQuality(int* plReceptionQuality);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-get_bufferingcount
    HRESULT get_bufferingCount(int* plBufferingCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-get_bufferingprogress
    HRESULT get_bufferingProgress(int* plBufferingProgress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-get_bufferingtime
    HRESULT get_bufferingTime(int* plBufferingTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-put_bufferingtime
    HRESULT put_bufferingTime(int lBufferingTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-get_framerate
    HRESULT get_frameRate(int* plFrameRate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-get_maxbitrate
    HRESULT get_maxBitRate(int* plBitRate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-get_bitrate
    HRESULT get_bitRate(int* plBitRate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-getproxysettings
    HRESULT getProxySettings(BSTR bstrProtocol, int* plProxySetting);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-setproxysettings
    HRESULT setProxySettings(BSTR bstrProtocol, int lProxySetting);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-getproxyname
    HRESULT getProxyName(BSTR bstrProtocol, BSTR* pbstrProxyName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-setproxyname
    HRESULT setProxyName(BSTR bstrProtocol, BSTR bstrProxyName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-getproxyport
    HRESULT getProxyPort(BSTR bstrProtocol, int* lProxyPort);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-setproxyport
    HRESULT setProxyPort(BSTR bstrProtocol, int lProxyPort);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-getproxyexceptionlist
    HRESULT getProxyExceptionList(BSTR bstrProtocol, BSTR* pbstrExceptionList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-setproxyexceptionlist
    HRESULT setProxyExceptionList(BSTR bstrProtocol, BSTR pbstrExceptionList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-getproxybypassforlocal
    HRESULT getProxyBypassForLocal(BSTR bstrProtocol, VARIANT_BOOL* pfBypassForLocal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-setproxybypassforlocal
    HRESULT setProxyBypassForLocal(BSTR bstrProtocol, VARIANT_BOOL fBypassForLocal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-get_maxbandwidth
    HRESULT get_maxBandwidth(int* lMaxBandwidth);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-put_maxbandwidth
    HRESULT put_maxBandwidth(int lMaxBandwidth);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-get_downloadprogress
    HRESULT get_downloadProgress(int* plDownloadProgress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-get_encodedframerate
    HRESULT get_encodedFrameRate(int* plFrameRate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpnetwork-get_framesskipped
    HRESULT get_framesSkipped(int* plFrames);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpcore
@GUID("d84cca99-cce2-11d2-9ecc-0000f8085981")
interface IWMPCore : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcore-close
    HRESULT close();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcore-get_url
    HRESULT get_URL(BSTR* pbstrURL);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcore-put_url
    HRESULT put_URL(BSTR bstrURL);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcore-get_openstate
    HRESULT get_openState(WMPOpenState* pwmpos);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcore-get_playstate
    HRESULT get_playState(WMPPlayState* pwmpps);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcore-get_controls
    HRESULT get_controls(IWMPControls* ppControl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcore-get_settings
    HRESULT get_settings(IWMPSettings* ppSettings);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcore-get_currentmedia
    HRESULT get_currentMedia(IWMPMedia* ppMedia);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcore-put_currentmedia
    HRESULT put_currentMedia(IWMPMedia pMedia);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcore-get_mediacollection
    HRESULT get_mediaCollection(IWMPMediaCollection* ppMediaCollection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcore-get_playlistcollection
    HRESULT get_playlistCollection(IWMPPlaylistCollection* ppPlaylistCollection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcore-get_versioninfo
    HRESULT get_versionInfo(BSTR* pbstrVersionInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcore-launchurl
    HRESULT launchURL(BSTR bstrURL);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcore-get_network
    HRESULT get_network(IWMPNetwork* ppQNI);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcore-get_currentplaylist
    HRESULT get_currentPlaylist(IWMPPlaylist* ppPL);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcore-put_currentplaylist
    HRESULT put_currentPlaylist(IWMPPlaylist pPL);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcore-get_cdromcollection
    HRESULT get_cdromCollection(IWMPCdromCollection* ppCdromCollection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcore-get_closedcaption
    HRESULT get_closedCaption(IWMPClosedCaption* ppClosedCaption);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcore-get_isonline
    HRESULT get_isOnline(VARIANT_BOOL* pfOnline);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcore-get_error
    HRESULT get_error(IWMPError* ppError);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcore-get_status
    HRESULT get_status(BSTR* pbstrStatus);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpplayer
@GUID("6bf52a4f-394a-11d3-b153-00c04f79faa6")
interface IWMPPlayer : IWMPCore
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplayer-get_enabled
    HRESULT get_enabled(VARIANT_BOOL* pbEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplayer-put_enabled
    HRESULT put_enabled(VARIANT_BOOL bEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplayer-get_fullscreen
    HRESULT get_fullScreen(VARIANT_BOOL* pbFullScreen);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplayer-put_fullscreen
    HRESULT put_fullScreen(VARIANT_BOOL bFullScreen);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplayer-get_enablecontextmenu
    HRESULT get_enableContextMenu(VARIANT_BOOL* pbEnableContextMenu);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplayer-put_enablecontextmenu
    HRESULT put_enableContextMenu(VARIANT_BOOL bEnableContextMenu);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplayer-put_uimode
    HRESULT put_uiMode(BSTR bstrMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplayer-get_uimode
    HRESULT get_uiMode(BSTR* pbstrMode);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpplayer2
@GUID("0e6b01d1-d407-4c85-bf5f-1c01f6150280")
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
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplayer2-get_stretchtofit
    HRESULT get_stretchToFit(VARIANT_BOOL* pbEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplayer2-put_stretchtofit
    HRESULT put_stretchToFit(VARIANT_BOOL bEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplayer2-get_windowlessvideo
    HRESULT get_windowlessVideo(VARIANT_BOOL* pbEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplayer2-put_windowlessvideo
    HRESULT put_windowlessVideo(VARIANT_BOOL bEnabled);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpmedia2
@GUID("ab7c88bb-143e-4ea4-acc3-e4350b2106c3")
interface IWMPMedia2 : IWMPMedia
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmedia2-get_error
    HRESULT get_error(IWMPErrorItem* ppIWMPErrorItem);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpcontrols2
@GUID("6f030d25-0890-480f-9775-1f7e40ab5b8e")
interface IWMPControls2 : IWMPControls
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols2-step
    HRESULT step(int lStep);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpdvd
@GUID("8da61686-4668-4a5c-ae5d-803193293dbe")
interface IWMPDVD : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpdvd-get_isavailable
    HRESULT get_isAvailable(BSTR bstrItem, VARIANT_BOOL* pIsAvailable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpdvd-get_domain
    HRESULT get_domain(BSTR* strDomain);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpdvd-topmenu
    HRESULT topMenu();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpdvd-titlemenu
    HRESULT titleMenu();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpdvd-back
    HRESULT back();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpdvd-resume
    HRESULT resume();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpcore2
@GUID("bc17e5b7-7561-4c18-bb90-17d485775659")
interface IWMPCore2 : IWMPCore
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcore2-get_dvd
    HRESULT get_dvd(IWMPDVD* ppDVD);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpplayer3
@GUID("54062b68-052a-4c25-a39f-8b63346511d4")
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmperroritem2
@GUID("f75ccec0-c67c-475c-931e-8719870bee7d")
interface IWMPErrorItem2 : IWMPErrorItem
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmperroritem2-get_condition
    HRESULT get_condition(int* plCondition);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpremotemediaservices
@GUID("cbb92747-741f-44fe-ab5b-f1a48f3b2a59")
interface IWMPRemoteMediaServices : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpremotemediaservices-getservicetype
    HRESULT GetServiceType(BSTR* pbstrType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpremotemediaservices-getapplicationname
    HRESULT GetApplicationName(BSTR* pbstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpremotemediaservices-getscriptableobject
    HRESULT GetScriptableObject(BSTR* pbstrName, IDispatch* ppDispatch);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpremotemediaservices-getcustomuimode
    HRESULT GetCustomUIMode(BSTR* pbstrFile);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpskinmanager
@GUID("076f2fa6-ed30-448b-8cc5-3f3ef3529c7a")
interface IWMPSkinManager : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpskinmanager-setvisualstyle
    HRESULT SetVisualStyle(BSTR bstrPath);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpmetadatapicture
@GUID("5c29bbe0-f87d-4c45-aa28-a70f0230ffa9")
interface IWMPMetadataPicture : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmetadatapicture-get_mimetype
    HRESULT get_mimeType(BSTR* pbstrMimeType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmetadatapicture-get_picturetype
    HRESULT get_pictureType(BSTR* pbstrPictureType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmetadatapicture-get_description
    HRESULT get_description(BSTR* pbstrDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmetadatapicture-get_url
    HRESULT get_URL(BSTR* pbstrURL);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpmetadatatext
@GUID("769a72db-13d2-45e2-9c48-53ca9d5b7450")
interface IWMPMetadataText : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmetadatatext-get_description
    HRESULT get_description(BSTR* pbstrDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmetadatatext-get_text
    HRESULT get_text(BSTR* pbstrText);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpmedia3
@GUID("f118efc7-f03a-4fb4-99c9-1c02a5c1065b")
interface IWMPMedia3 : IWMPMedia2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmedia3-getattributecountbytype
    HRESULT getAttributeCountByType(BSTR bstrType, BSTR bstrLanguage, int* plCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmedia3-getiteminfobytype
    HRESULT getItemInfoByType(BSTR bstrType, BSTR bstrLanguage, int lIndex, VARIANT* pvarValue);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpsettings2
@GUID("fda937a4-eece-4da5-a0b6-39bf89ade2c2")
interface IWMPSettings2 : IWMPSettings
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings2-get_defaultaudiolanguage
    HRESULT get_defaultAudioLanguage(int* plLangID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings2-get_mediaaccessrights
    HRESULT get_mediaAccessRights(BSTR* pbstrRights);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsettings2-requestmediaaccessrights
    HRESULT requestMediaAccessRights(BSTR bstrDesiredAccess, VARIANT_BOOL* pvbAccepted);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpcontrols3
@GUID("a1d1110e-d545-476a-9a78-ac3e4cb1e6bd")
interface IWMPControls3 : IWMPControls2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols3-get_audiolanguagecount
    HRESULT get_audioLanguageCount(int* plCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols3-getaudiolanguageid
    HRESULT getAudioLanguageID(int lIndex, int* plLangID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols3-getaudiolanguagedescription
    HRESULT getAudioLanguageDescription(int lIndex, BSTR* pbstrLangDesc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols3-get_currentaudiolanguage
    HRESULT get_currentAudioLanguage(int* plLangID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols3-put_currentaudiolanguage
    HRESULT put_currentAudioLanguage(int lLangID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols3-get_currentaudiolanguageindex
    HRESULT get_currentAudioLanguageIndex(int* plIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols3-put_currentaudiolanguageindex
    HRESULT put_currentAudioLanguageIndex(int lIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols3-getlanguagename
    HRESULT getLanguageName(int lLangID, BSTR* pbstrLangName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols3-get_currentpositiontimecode
    HRESULT get_currentPositionTimecode(BSTR* bstrTimecode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcontrols3-put_currentpositiontimecode
    HRESULT put_currentPositionTimecode(BSTR bstrTimecode);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpclosedcaption2
@GUID("350ba78b-6bc8-4113-a5f5-312056934eb6")
interface IWMPClosedCaption2 : IWMPClosedCaption
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpclosedcaption2-get_samilangcount
    HRESULT get_SAMILangCount(int* plCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpclosedcaption2-getsamilangname
    HRESULT getSAMILangName(int nIndex, BSTR* pbstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpclosedcaption2-getsamilangid
    HRESULT getSAMILangID(int nIndex, int* plLangID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpclosedcaption2-get_samistylecount
    HRESULT get_SAMIStyleCount(int* plCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpclosedcaption2-getsamistylename
    HRESULT getSAMIStyleName(int nIndex, BSTR* pbstrName);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpplayerapplication
@GUID("40897764-ceab-47be-ad4a-8e28537f9bbf")
interface IWMPPlayerApplication : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplayerapplication-switchtoplayerapplication
    HRESULT switchToPlayerApplication();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplayerapplication-switchtocontrol
    HRESULT switchToControl();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplayerapplication-get_playerdocked
    HRESULT get_playerDocked(VARIANT_BOOL* pbPlayerDocked);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplayerapplication-get_hasdisplay
    HRESULT get_hasDisplay(VARIANT_BOOL* pbHasDisplay);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpcore3
@GUID("7587c667-628f-499f-88e7-6a6f4e888464")
interface IWMPCore3 : IWMPCore2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcore3-newplaylist
    HRESULT newPlaylist(BSTR bstrName, BSTR bstrURL, IWMPPlaylist* ppPlaylist);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcore3-newmedia
    HRESULT newMedia(BSTR bstrURL, IWMPMedia* ppMedia);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpplayer4
@GUID("6c497d62-8919-413c-82db-e935fb3ec584")
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
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplayer4-get_isremote
    HRESULT get_isRemote(VARIANT_BOOL* pvarfIsRemote);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplayer4-get_playerapplication
    HRESULT get_playerApplication(IWMPPlayerApplication* ppIWMPPlayerApplication);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplayer4-openplayer
    HRESULT openPlayer(BSTR bstrURL);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpplayerservices
@GUID("1d01fbdb-ade2-4c8d-9842-c190b95c3306")
interface IWMPPlayerServices : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplayerservices-activateuiplugin
    HRESULT activateUIPlugin(BSTR bstrPlugin);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplayerservices-settaskpane
    HRESULT setTaskPane(BSTR bstrTaskPane);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplayerservices-settaskpaneurl
    HRESULT setTaskPaneURL(BSTR bstrTaskPane, BSTR bstrURL, BSTR bstrFriendlyName);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpsyncdevice
@GUID("82a2986c-0293-4fd0-b279-b21b86c058be")
interface IWMPSyncDevice : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsyncdevice-get_friendlyname
    HRESULT get_friendlyName(BSTR* pbstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsyncdevice-put_friendlyname
    HRESULT put_friendlyName(BSTR bstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsyncdevice-get_devicename
    HRESULT get_deviceName(BSTR* pbstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsyncdevice-get_deviceid
    HRESULT get_deviceId(BSTR* pbstrDeviceId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsyncdevice-get_partnershipindex
    HRESULT get_partnershipIndex(int* plIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsyncdevice-get_connected
    HRESULT get_connected(VARIANT_BOOL* pvbConnected);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsyncdevice-get_status
    HRESULT get_status(WMPDeviceStatus* pwmpds);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsyncdevice-get_syncstate
    HRESULT get_syncState(WMPSyncState* pwmpss);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsyncdevice-get_progress
    HRESULT get_progress(int* plProgress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsyncdevice-getiteminfo
    HRESULT getItemInfo(BSTR bstrItemName, BSTR* pbstrVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsyncdevice-createpartnership
    HRESULT createPartnership(VARIANT_BOOL vbShowUI);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsyncdevice-deletepartnership
    HRESULT deletePartnership();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsyncdevice-start
    HRESULT start();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsyncdevice-stop
    HRESULT stop();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsyncdevice-showsettings
    HRESULT showSettings();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsyncdevice-isidentical
    HRESULT isIdentical(IWMPSyncDevice pDevice, VARIANT_BOOL* pvbool);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpsyncservices
@GUID("8b5050ff-e0a4-4808-b3a8-893a9e1ed894")
interface IWMPSyncServices : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsyncservices-get_devicecount
    HRESULT get_deviceCount(int* plCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsyncservices-getdevice
    HRESULT getDevice(int lIndex, IWMPSyncDevice* ppDevice);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpplayerservices2
@GUID("1bb1592f-f040-418a-9f71-17c7512b4d70")
interface IWMPPlayerServices2 : IWMPPlayerServices
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpplayerservices2-setbackgroundprocessingpriority
    HRESULT setBackgroundProcessingPriority(BSTR bstrPriority);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpcdromrip
@GUID("56e2294f-69ed-4629-a869-aea72c0dcc2c")
interface IWMPCdromRip : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcdromrip-get_ripstate
    HRESULT get_ripState(WMPRipState* pwmprs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcdromrip-get_ripprogress
    HRESULT get_ripProgress(int* plProgress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcdromrip-startrip
    HRESULT startRip();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcdromrip-stoprip
    HRESULT stopRip();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpcdromburn
@GUID("bd94dbeb-417f-4928-aa06-087d56ed9b59")
interface IWMPCdromBurn : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcdromburn-isavailable
    HRESULT isAvailable(BSTR bstrItem, VARIANT_BOOL* pIsAvailable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcdromburn-getiteminfo
    HRESULT getItemInfo(BSTR bstrItem, BSTR* pbstrVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcdromburn-get_label
    HRESULT get_label(BSTR* pbstrLabel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcdromburn-put_label
    HRESULT put_label(BSTR bstrLabel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcdromburn-get_burnformat
    HRESULT get_burnFormat(WMPBurnFormat* pwmpbf);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcdromburn-put_burnformat
    HRESULT put_burnFormat(WMPBurnFormat wmpbf);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcdromburn-get_burnplaylist
    HRESULT get_burnPlaylist(IWMPPlaylist* ppPlaylist);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcdromburn-put_burnplaylist
    HRESULT put_burnPlaylist(IWMPPlaylist pPlaylist);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcdromburn-refreshstatus
    HRESULT refreshStatus();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcdromburn-get_burnstate
    HRESULT get_burnState(WMPBurnState* pwmpbs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcdromburn-get_burnprogress
    HRESULT get_burnProgress(int* plProgress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcdromburn-startburn
    HRESULT startBurn();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcdromburn-stopburn
    HRESULT stopBurn();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpcdromburn-erase
    HRESULT erase();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpquery
@GUID("a00918f3-a6b0-4bfb-9189-fd834c7bc5a5")
interface IWMPQuery : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpquery-addcondition
    HRESULT addCondition(BSTR bstrAttribute, BSTR bstrOperator, BSTR bstrValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpquery-beginnextgroup
    HRESULT beginNextGroup();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpmediacollection2
@GUID("8ba957f5-fd8c-4791-b82d-f840401ee474")
interface IWMPMediaCollection2 : IWMPMediaCollection
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmediacollection2-createquery
    HRESULT createQuery(IWMPQuery* ppQuery);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmediacollection2-getplaylistbyquery
    HRESULT getPlaylistByQuery(IWMPQuery pQuery, BSTR bstrMediaType, BSTR bstrSortAttribute, 
                               VARIANT_BOOL fSortAscending, IWMPPlaylist* ppPlaylist);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmediacollection2-getstringcollectionbyquery
    HRESULT getStringCollectionByQuery(BSTR bstrAttribute, IWMPQuery pQuery, BSTR bstrMediaType, 
                                       BSTR bstrSortAttribute, VARIANT_BOOL fSortAscending, 
                                       IWMPStringCollection* ppStringCollection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpmediacollection2-getbyattributeandmediatype
    HRESULT getByAttributeAndMediaType(BSTR bstrAttribute, BSTR bstrValue, BSTR bstrMediaType, 
                                       IWMPPlaylist* ppMediaItems);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpstringcollection2
@GUID("46ad648d-53f1-4a74-92e2-2a1b68d63fd4")
interface IWMPStringCollection2 : IWMPStringCollection
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpstringcollection2-isidentical
    HRESULT isIdentical(IWMPStringCollection2 pIWMPStringCollection2, VARIANT_BOOL* pvbool);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpstringcollection2-getiteminfo
    HRESULT getItemInfo(int lCollectionIndex, BSTR bstrItemName, BSTR* pbstrValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpstringcollection2-getattributecountbytype
    HRESULT getAttributeCountByType(int lCollectionIndex, BSTR bstrType, BSTR bstrLanguage, int* plCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpstringcollection2-getiteminfobytype
    HRESULT getItemInfoByType(int lCollectionIndex, BSTR bstrType, BSTR bstrLanguage, int lAttributeIndex, 
                              VARIANT* pvarValue);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmplibrary
@GUID("3df47861-7df1-4c1f-a81b-4c26f0f7a7c6")
interface IWMPLibrary : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmplibrary-get_name
    HRESULT get_name(BSTR* pbstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmplibrary-get_type
    HRESULT get_type(WMPLibraryType* pwmplt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmplibrary-get_mediacollection
    HRESULT get_mediaCollection(IWMPMediaCollection* ppIWMPMediaCollection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmplibrary-isidentical
    HRESULT isIdentical(IWMPLibrary pIWMPLibrary, VARIANT_BOOL* pvbool);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmplibraryservices
@GUID("39c2f8d5-1cf2-4d5e-ae09-d73492cf9eaa")
interface IWMPLibraryServices : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmplibraryservices-getcountbytype
    HRESULT getCountByType(WMPLibraryType wmplt, int* plCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmplibraryservices-getlibrarybytype
    HRESULT getLibraryByType(WMPLibraryType wmplt, int lIndex, IWMPLibrary* ppIWMPLibrary);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmplibrarysharingservices
@GUID("82cba86b-9f04-474b-a365-d6dd1466e541")
interface IWMPLibrarySharingServices : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmplibrarysharingservices-islibraryshared
    HRESULT isLibraryShared(VARIANT_BOOL* pvbShared);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmplibrarysharingservices-islibrarysharingenabled
    HRESULT isLibrarySharingEnabled(VARIANT_BOOL* pvbEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmplibrarysharingservices-showlibrarysharing
    HRESULT showLibrarySharing();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpfoldermonitorservices
@GUID("788c8743-e57f-439d-a468-5bc77f2e59c6")
interface IWMPFolderMonitorServices : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpfoldermonitorservices-get_count
    HRESULT get_count(int* plCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpfoldermonitorservices-item
    HRESULT item(int lIndex, BSTR* pbstrFolder);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpfoldermonitorservices-add
    HRESULT add(BSTR bstrFolder);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpfoldermonitorservices-remove
    HRESULT remove(int lIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpfoldermonitorservices-get_scanstate
    HRESULT get_scanState(WMPFolderScanState* pwmpfss);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpfoldermonitorservices-get_currentfolder
    HRESULT get_currentFolder(BSTR* pbstrFolder);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpfoldermonitorservices-get_scannedfilescount
    HRESULT get_scannedFilesCount(int* plCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpfoldermonitorservices-get_addedfilescount
    HRESULT get_addedFilesCount(int* plCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpfoldermonitorservices-get_updateprogress
    HRESULT get_updateProgress(int* plProgress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpfoldermonitorservices-startscan
    HRESULT startScan();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpfoldermonitorservices-stopscan
    HRESULT stopScan();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpsyncdevice2
@GUID("88afb4b2-140a-44d2-91e6-4543da467cd1")
interface IWMPSyncDevice2 : IWMPSyncDevice
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsyncdevice2-setiteminfo
    HRESULT setItemInfo(BSTR bstrItemName, BSTR bstrVal);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpsyncdevice3
@GUID("b22c85f9-263c-4372-a0da-b518db9b4098")
interface IWMPSyncDevice3 : IWMPSyncDevice2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsyncdevice3-estimatesyncsize
    HRESULT estimateSyncSize(IWMPPlaylist pNonRulePlaylist, IWMPPlaylist pRulesPlaylist);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpsyncdevice3-cancelestimation
    HRESULT cancelEstimation();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmplibrary2
@GUID("dd578a4e-79b1-426c-bf8f-3add9072500b")
interface IWMPLibrary2 : IWMPLibrary
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmplibrary2-getiteminfo
    HRESULT getItemInfo(BSTR bstrItemName, BSTR* pbstrVal);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpevents
@GUID("19a6627b-da9e-47c1-bb23-00b5e668236a")
interface IWMPEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-openstatechange
    void OpenStateChange(int NewState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-playstatechange
    void PlayStateChange(int NewState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-audiolanguagechange
    void AudioLanguageChange(int LangID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-statuschange
    void StatusChange();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-scriptcommand
    void ScriptCommand(BSTR scType, BSTR Param);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-newstream
    void NewStream();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-disconnect
    void Disconnect(int Result);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-buffering
    void Buffering(VARIANT_BOOL Start);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-error
    void Error();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-warning
    void Warning(int WarningType, int Param, BSTR Description);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-endofstream
    void EndOfStream(int Result);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-positionchange
    void PositionChange(double oldPosition, double newPosition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-markerhit
    void MarkerHit(int MarkerNum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-durationunitchange
    void DurationUnitChange(int NewDurationUnit);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-cdrommediachange
    void CdromMediaChange(int CdromNum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-playlistchange
    void PlaylistChange(IDispatch Playlist, WMPPlaylistChangeEventType change);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-currentplaylistchange
    void CurrentPlaylistChange(WMPPlaylistChangeEventType change);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-currentplaylistitemavailable
    void CurrentPlaylistItemAvailable(BSTR bstrItemName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-mediachange
    void MediaChange(IDispatch Item);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-currentmediaitemavailable
    void CurrentMediaItemAvailable(BSTR bstrItemName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-currentitemchange
    void CurrentItemChange(IDispatch pdispMedia);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-mediacollectionchange
    void MediaCollectionChange();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-mediacollectionattributestringadded
    void MediaCollectionAttributeStringAdded(BSTR bstrAttribName, BSTR bstrAttribVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-mediacollectionattributestringremoved
    void MediaCollectionAttributeStringRemoved(BSTR bstrAttribName, BSTR bstrAttribVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-mediacollectionattributestringchanged
    void MediaCollectionAttributeStringChanged(BSTR bstrAttribName, BSTR bstrOldAttribVal, BSTR bstrNewAttribVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-playlistcollectionchange
    void PlaylistCollectionChange();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-playlistcollectionplaylistadded
    void PlaylistCollectionPlaylistAdded(BSTR bstrPlaylistName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-playlistcollectionplaylistremoved
    void PlaylistCollectionPlaylistRemoved(BSTR bstrPlaylistName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-playlistcollectionplaylistsetasdeleted
    void PlaylistCollectionPlaylistSetAsDeleted(BSTR bstrPlaylistName, VARIANT_BOOL varfIsDeleted);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-modechange
    void ModeChange(BSTR ModeName, VARIANT_BOOL NewValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-mediaerror
    void MediaError(IDispatch pMediaObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-openplaylistswitch
    void OpenPlaylistSwitch(IDispatch pItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-domainchange
    void DomainChange(BSTR strDomain);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-switchedtoplayerapplication
    void SwitchedToPlayerApplication();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-switchedtocontrol
    void SwitchedToControl();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-playerdockedstatechange
    void PlayerDockedStateChange();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-playerreconnect
    void PlayerReconnect();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-click
    void Click(short nButton, short nShiftState, int fX, int fY);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-doubleclick
    void DoubleClick(short nButton, short nShiftState, int fX, int fY);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-keydown
    void KeyDown(short nKeyCode, short nShiftState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-keypress
    void KeyPress(short nKeyAscii);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-keyup
    void KeyUp(short nKeyCode, short nShiftState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-mousedown
    void MouseDown(short nButton, short nShiftState, int fX, int fY);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-mousemove
    void MouseMove(short nButton, short nShiftState, int fX, int fY);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents-mouseup
    void MouseUp(short nButton, short nShiftState, int fX, int fY);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpevents2
@GUID("1e7601fa-47ea-4107-9ea9-9004ed9684ff")
interface IWMPEvents2 : IWMPEvents
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents2-deviceconnect
    void DeviceConnect(IWMPSyncDevice pDevice);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents2-devicedisconnect
    void DeviceDisconnect(IWMPSyncDevice pDevice);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents2-devicestatuschange
    void DeviceStatusChange(IWMPSyncDevice pDevice, WMPDeviceStatus NewStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents2-devicesyncstatechange
    void DeviceSyncStateChange(IWMPSyncDevice pDevice, WMPSyncState NewState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents2-devicesyncerror
    void DeviceSyncError(IWMPSyncDevice pDevice, IDispatch pMedia);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents2-createpartnershipcomplete
    void CreatePartnershipComplete(IWMPSyncDevice pDevice, HRESULT hrResult);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpevents3
@GUID("1f504270-a66b-4223-8e96-26a06c63d69f")
interface IWMPEvents3 : IWMPEvents2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents3-cdromripstatechange
    void CdromRipStateChange(IWMPCdromRip pCdromRip, WMPRipState wmprs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents3-cdromripmediaerror
    void CdromRipMediaError(IWMPCdromRip pCdromRip, IDispatch pMedia);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents3-cdromburnstatechange
    void CdromBurnStateChange(IWMPCdromBurn pCdromBurn, WMPBurnState wmpbs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents3-cdromburnmediaerror
    void CdromBurnMediaError(IWMPCdromBurn pCdromBurn, IDispatch pMedia);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents3-cdromburnerror
    void CdromBurnError(IWMPCdromBurn pCdromBurn, HRESULT hrError);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents3-libraryconnect
    void LibraryConnect(IWMPLibrary pLibrary);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents3-librarydisconnect
    void LibraryDisconnect(IWMPLibrary pLibrary);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents3-folderscanstatechange
    void FolderScanStateChange(WMPFolderScanState wmpfss);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents3-stringcollectionchange
    void StringCollectionChange(IDispatch pdispStringCollection, WMPStringCollectionChangeEventType change, 
                                int lCollectionIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents3-mediacollectionmediaadded
    void MediaCollectionMediaAdded(IDispatch pdispMedia);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nf-wmp-iwmpevents3-mediacollectionmediaremoved
    void MediaCollectionMediaRemoved(IDispatch pdispMedia);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmp/nn-wmp-iwmpevents4
@GUID("26dabcfa-306b-404d-9a6f-630a8405048d")
interface IWMPEvents4 : IWMPEvents3
{
    void DeviceEstimation(IWMPSyncDevice pDevice, HRESULT hrResult, long qwEstimatedUsedSpace, 
                          long qwEstimatedSpace);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/WMP/-wmpocxevents-interface
@GUID("6bf52a51-394a-11d3-b153-00c04f79faa6")
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmprealestate/nn-wmprealestate-iwmpvideorenderconfig
@GUID("6d6cf803-1ec0-4c8d-b3ca-f18e27282074")
interface IWMPVideoRenderConfig : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmprealestate/nf-wmprealestate-iwmpvideorenderconfig-put_presenteractivate
    HRESULT put_presenterActivate(IMFActivate pActivate);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmprealestate/nn-wmprealestate-iwmpaudiorenderconfig
@GUID("e79c6349-5997-4ce4-917c-22a3391ec564")
interface IWMPAudioRenderConfig : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmprealestate/nf-wmprealestate-iwmpaudiorenderconfig-get_audiooutputdevice
    HRESULT get_audioOutputDevice(BSTR* pbstrOutputDevice);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmprealestate/nf-wmprealestate-iwmpaudiorenderconfig-put_audiooutputdevice
    HRESULT put_audioOutputDevice(BSTR bstrOutputDevice);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmprealestate/nn-wmprealestate-iwmprenderconfig
@GUID("959506c1-0314-4ec5-9e61-8528db5e5478")
interface IWMPRenderConfig : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmprealestate/nf-wmprealestate-iwmprenderconfig-put_inproconly
    HRESULT put_inProcOnly(BOOL fInProc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmprealestate/nf-wmprealestate-iwmprenderconfig-get_inproconly
    HRESULT get_inProcOnly(BOOL* pfInProc);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmpservices/nn-wmpservices-iwmpservices
@GUID("afb6b76b-1e20-4198-83b3-191db6e0b149")
interface IWMPServices : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmpservices/nf-wmpservices-iwmpservices-getstreamtime
    HRESULT GetStreamTime(long* prt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmpservices/nf-wmpservices-iwmpservices-getstreamstate
    HRESULT GetStreamState(WMPServices_StreamState* pState);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmpservices/nn-wmpservices-iwmpmediapluginregistrar
@GUID("68e27045-05bd-40b2-9720-23088c78e390")
interface IWMPMediaPluginRegistrar : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmpservices/nf-wmpservices-iwmpmediapluginregistrar-wmpregisterplayerplugin
    HRESULT WMPRegisterPlayerPlugin(PWSTR pwszFriendlyName, PWSTR pwszDescription, PWSTR pwszUninstallString, 
                                    uint dwPriority, GUID guidPluginType, GUID clsid, uint cMediaTypes, 
                                    void* pMediaTypes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmpservices/nf-wmpservices-iwmpmediapluginregistrar-wmpunregisterplayerplugin
    HRESULT WMPUnRegisterPlayerPlugin(GUID guidPluginType, GUID clsid);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmpservices/nn-wmpservices-iwmpplugin
@GUID("f1392a70-024c-42bb-a998-73dfdfe7d5a7")
interface IWMPPlugin : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmpservices/nf-wmpservices-iwmpplugin-init
    HRESULT Init(size_t dwPlaybackContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmpservices/nf-wmpservices-iwmpplugin-shutdown
    HRESULT Shutdown();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmpservices/nf-wmpservices-iwmpplugin-getid
    HRESULT GetID(GUID* pGUID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmpservices/nf-wmpservices-iwmpplugin-getcaps
    HRESULT GetCaps(uint* pdwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmpservices/nf-wmpservices-iwmpplugin-advisewmpservices
    HRESULT AdviseWMPServices(IWMPServices pWMPServices);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmpservices/nf-wmpservices-iwmpplugin-unadvisewmpservices
    HRESULT UnAdviseWMPServices();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmpservices/nn-wmpservices-iwmppluginenable
@GUID("5fca444c-7ad1-479d-a4ef-40566a5309d6")
interface IWMPPluginEnable : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmpservices/nf-wmpservices-iwmppluginenable-setenable
    HRESULT SetEnable(BOOL fEnable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmpservices/nf-wmpservices-iwmppluginenable-getenable
    HRESULT GetEnable(BOOL* pfEnable);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmpservices/nn-wmpservices-iwmpgraphcreation
@GUID("bfb377e5-c594-4369-a970-de896d5ece74")
interface IWMPGraphCreation : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmpservices/nf-wmpservices-iwmpgraphcreation-graphcreationprerender
    HRESULT GraphCreationPreRender(IUnknown pFilterGraph, IUnknown pReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmpservices/nf-wmpservices-iwmpgraphcreation-graphcreationpostrender
    HRESULT GraphCreationPostRender(IUnknown pFilterGraph);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmpservices/nf-wmpservices-iwmpgraphcreation-getgraphcreationflags
    HRESULT GetGraphCreationFlags(uint* pdwFlags);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmpservices/nn-wmpservices-iwmpconvert
@GUID("d683162f-57d4-4108-8373-4a9676d1c2e9")
interface IWMPConvert : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmpservices/nf-wmpservices-iwmpconvert-convertfile
    HRESULT ConvertFile(BSTR bstrInputFile, BSTR bstrDestinationFolder, BSTR* pbstrOutputFile);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmpservices/nf-wmpservices-iwmpconvert-geterrorurl
    HRESULT GetErrorURL(BSTR* pbstrURL);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmpservices/nn-wmpservices-iwmptranscodepolicy
@GUID("b64cbac3-401c-4327-a3e8-b9feb3a8c25c")
interface IWMPTranscodePolicy : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmpservices/nf-wmpservices-iwmptranscodepolicy-allowtranscode
    HRESULT allowTranscode(VARIANT_BOOL* pvbAllow);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmpservices/nn-wmpservices-iwmpusereventsink
@GUID("cfccfa72-c343-48c3-a2de-b7a4402e39f2")
interface IWMPUserEventSink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmpservices/nf-wmpservices-iwmpusereventsink-notifyuserevent
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/effects/nn-effects-iwmpeffects
@GUID("d3984c13-c3cb-48e2-8be5-5168340b4f35")
interface IWMPEffects : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/effects/nf-effects-iwmpeffects-render
    HRESULT Render(TimedLevel* pLevels, HDC hdc, RECT* prc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/effects/nf-effects-iwmpeffects-mediainfo
    HRESULT MediaInfo(int lChannelCount, int lSampleRate, BSTR bstrTitle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/effects/nf-effects-iwmpeffects-getcapabilities
    HRESULT GetCapabilities(uint* pdwCapabilities);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/effects/nf-effects-iwmpeffects-gettitle
    HRESULT GetTitle(BSTR* bstrTitle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/effects/nf-effects-iwmpeffects-getpresettitle
    HRESULT GetPresetTitle(int nPreset, BSTR* bstrPresetTitle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/effects/nf-effects-iwmpeffects-getpresetcount
    HRESULT GetPresetCount(int* pnPresetCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/effects/nf-effects-iwmpeffects-setcurrentpreset
    HRESULT SetCurrentPreset(int nPreset);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/effects/nf-effects-iwmpeffects-getcurrentpreset
    HRESULT GetCurrentPreset(int* pnPreset);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/effects/nf-effects-iwmpeffects-displaypropertypage
    HRESULT DisplayPropertyPage(HWND hwndOwner);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/effects/nf-effects-iwmpeffects-gofullscreen
    HRESULT GoFullscreen(BOOL fFullScreen);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/effects/nf-effects-iwmpeffects-renderfullscreen
    HRESULT RenderFullScreen(TimedLevel* pLevels);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/effects/nn-effects-iwmpeffects2
@GUID("695386ec-aa3c-4618-a5e1-dd9a8b987632")
interface IWMPEffects2 : IWMPEffects
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/effects/nf-effects-iwmpeffects2-setcore
    HRESULT SetCore(IWMPCore pPlayer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/effects/nf-effects-iwmpeffects2-create
    HRESULT Create(HWND hwndParent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/effects/nf-effects-iwmpeffects2-destroy
    HRESULT Destroy();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/effects/nf-effects-iwmpeffects2-notifynewmedia
    HRESULT NotifyNewMedia(IWMPMedia pMedia);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/effects/nf-effects-iwmpeffects2-onwindowmessage
    HRESULT OnWindowMessage(uint msg, WPARAM WParam, LPARAM LParam, LRESULT* plResultParam);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/effects/nf-effects-iwmpeffects2-renderwindowed
    HRESULT RenderWindowed(TimedLevel* pData, BOOL fRequiredRender);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmpplug/nn-wmpplug-iwmppluginui
@GUID("4c5e8f9f-ad3e-4bf9-9753-fcd30d6d38dd")
interface IWMPPluginUI : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmpplug/nf-wmpplug-iwmppluginui-setcore
    HRESULT SetCore(IWMPCore pCore);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmpplug/nf-wmpplug-iwmppluginui-create
    HRESULT Create(HWND hwndParent, HWND* phwndWindow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmpplug/nf-wmpplug-iwmppluginui-destroy
    HRESULT Destroy();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmpplug/nf-wmpplug-iwmppluginui-displaypropertypage
    HRESULT DisplayPropertyPage(HWND hwndParent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmpplug/nf-wmpplug-iwmppluginui-getproperty
    HRESULT GetProperty(const(PWSTR) pwszName, VARIANT* pvarProperty);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmpplug/nf-wmpplug-iwmppluginui-setproperty
    HRESULT SetProperty(const(PWSTR) pwszName, const(VARIANT)* pvarProperty);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmpplug/nf-wmpplug-iwmppluginui-translateaccelerator
    HRESULT TranslateAccelerator(MSG* lpmsg);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/nn-contentpartner-iwmpcontentcontainer
@GUID("ad7f4d9c-1a9f-4ed2-9815-ecc0b58cb616")
interface IWMPContentContainer : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentcontainer-getid
    HRESULT GetID(uint* pContentID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentcontainer-getprice
    HRESULT GetPrice(BSTR* pbstrPrice);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentcontainer-gettype
    HRESULT GetType(BSTR* pbstrType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentcontainer-getcontentcount
    HRESULT GetContentCount(uint* pcContent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentcontainer-getcontentprice
    HRESULT GetContentPrice(uint idxContent, BSTR* pbstrPrice);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentcontainer-getcontentid
    HRESULT GetContentID(uint idxContent, uint* pContentID);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/nn-contentpartner-iwmpcontentcontainerlist
@GUID("a9937f78-0802-4af8-8b8d-e3f045bc8ab5")
interface IWMPContentContainerList : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentcontainerlist-gettransactiontype
    HRESULT GetTransactionType(WMPTransactionType* pwmptt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentcontainerlist-getcontainercount
    HRESULT GetContainerCount(uint* pcContainer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentcontainerlist-getcontainer
    HRESULT GetContainer(uint idxContainer, IWMPContentContainer* ppContent);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/nn-contentpartner-iwmpcontentpartnercallback
@GUID("9e8f7da2-0695-403c-b697-da10fafaa676")
interface IWMPContentPartnerCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartnercallback-notify
    HRESULT Notify(WMPCallbackNotification type, VARIANT* pContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartnercallback-buycomplete
    HRESULT BuyComplete(HRESULT hrResult, uint dwBuyCookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartnercallback-downloadtrack
    HRESULT DownloadTrack(uint cookie, BSTR bstrTrackURL, uint dwServiceTrackID, BSTR bstrDownloadParams, 
                          HRESULT hrDownload);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartnercallback-getcatalogversion
    HRESULT GetCatalogVersion(uint* pdwVersion, uint* pdwSchemaVersion, uint* plcid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartnercallback-updatedevicecomplete
    HRESULT UpdateDeviceComplete(BSTR bstrDeviceName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartnercallback-changeview
    HRESULT ChangeView(BSTR bstrType, BSTR bstrID, BSTR bstrFilter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartnercallback-addlistcontents
    HRESULT AddListContents(uint dwListCookie, uint cItems, uint* prgItems);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartnercallback-listcontentscomplete
    HRESULT ListContentsComplete(uint dwListCookie, HRESULT hrSuccess);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartnercallback-sendmessagecomplete
    HRESULT SendMessageComplete(BSTR bstrMsg, BSTR bstrParam, BSTR bstrResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartnercallback-getcontentidsinlibrary
    HRESULT GetContentIDsInLibrary(uint* pcContentIDs, uint** pprgIDs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartnercallback-refreshlicensecomplete
    HRESULT RefreshLicenseComplete(uint dwCookie, uint contentID, HRESULT hrRefresh);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartnercallback-showpopup
    HRESULT ShowPopup(int lIndex, BSTR bstrParameters);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartnercallback-verifypermissioncomplete
    HRESULT VerifyPermissionComplete(BSTR bstrPermission, VARIANT* pContext, HRESULT hrPermission);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/nn-contentpartner-iwmpcontentpartner
@GUID("55455073-41b5-4e75-87b8-f13bdb291d08")
interface IWMPContentPartner : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartner-setcallback
    HRESULT SetCallback(IWMPContentPartnerCallback pCallback);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartner-notify
    HRESULT Notify(WMPPartnerNotification type, VARIANT* pContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartner-getiteminfo
    HRESULT GetItemInfo(BSTR bstrInfoName, VARIANT* pContext, VARIANT* pData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartner-getcontentpartnerinfo
    HRESULT GetContentPartnerInfo(BSTR bstrInfoName, VARIANT* pData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartner-getcommands
    HRESULT GetCommands(BSTR location, VARIANT* pLocationContext, BSTR itemLocation, uint cItemIDs, 
                        uint* prgItemIDs, uint* pcItemIDs, WMPContextMenuInfo** pprgItems);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartner-invokecommand
    HRESULT InvokeCommand(uint dwCommandID, BSTR location, VARIANT* pLocationContext, BSTR itemLocation, 
                          uint cItemIDs, uint* rgItemIDs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartner-canbuysilent
    HRESULT CanBuySilent(IWMPContentContainerList pInfo, BSTR* pbstrTotalPrice, VARIANT_BOOL* pSilentOK);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartner-buy
    HRESULT Buy(IWMPContentContainerList pInfo, uint cookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartner-getstreamingurl
    HRESULT GetStreamingURL(WMPStreamingType st, VARIANT* pStreamContext, BSTR* pbstrURL);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartner-download
    HRESULT Download(IWMPContentContainerList pInfo, uint cookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartner-downloadtrackcomplete
    HRESULT DownloadTrackComplete(HRESULT hrResult, uint contentID, BSTR downloadTrackParam);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartner-refreshlicense
    HRESULT RefreshLicense(uint dwCookie, VARIANT_BOOL fLocal, BSTR bstrURL, WMPStreamingType type, uint contentID, 
                           BSTR bstrRefreshReason, VARIANT* pReasonContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartner-getcatalogurl
    HRESULT GetCatalogURL(uint dwCatalogVersion, uint dwCatalogSchemaVersion, uint catalogLCID, 
                          uint* pdwNewCatalogVersion, BSTR* pbstrCatalogURL, VARIANT* pExpirationDate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartner-gettemplate
    HRESULT GetTemplate(WMPTaskType task, BSTR location, VARIANT* pContext, BSTR clickLocation, 
                        VARIANT* pClickContext, BSTR bstrFilter, BSTR bstrViewParams, BSTR* pbstrTemplateURL, 
                        WMPTemplateSize* pTemplateSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartner-updatedevice
    HRESULT UpdateDevice(BSTR bstrDeviceName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartner-getlistcontents
    HRESULT GetListContents(BSTR location, VARIANT* pContext, BSTR bstrListType, BSTR bstrParams, 
                            uint dwListCookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartner-login
    HRESULT Login(BLOB userInfo, BLOB pwdInfo, VARIANT_BOOL fUsedCachedCreds, VARIANT_BOOL fOkToCache);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartner-authenticate
    HRESULT Authenticate(BLOB userInfo, BLOB pwdInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartner-logout
    HRESULT Logout();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartner-sendmessage
    HRESULT SendMessage(BSTR bstrMsg, BSTR bstrParam);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartner-stationevent
    HRESULT StationEvent(BSTR bstrStationEventType, uint StationId, uint PlaylistIndex, uint TrackID, 
                         BSTR TrackData, uint dwSecondsPlayed);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartner-comparecontainerlistprices
    HRESULT CompareContainerListPrices(IWMPContentContainerList pListBase, IWMPContentContainerList pListCompare, 
                                       int* pResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/contentpartner/nf-contentpartner-iwmpcontentpartner-verifypermission
    HRESULT VerifyPermission(BSTR bstrPermission, VARIANT* pContext);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/subscriptionservices/nn-subscriptionservices-iwmpsubscriptionservice
@GUID("376055f8-2a59-4a73-9501-dca5273a7a10")
interface IWMPSubscriptionService : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/subscriptionservices/nf-subscriptionservices-iwmpsubscriptionservice-allowplay
    HRESULT allowPlay(HWND hwnd, IWMPMedia pMedia, BOOL* pfAllowPlay);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/subscriptionservices/nf-subscriptionservices-iwmpsubscriptionservice-allowcdburn
    HRESULT allowCDBurn(HWND hwnd, IWMPPlaylist pPlaylist, BOOL* pfAllowBurn);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/subscriptionservices/nf-subscriptionservices-iwmpsubscriptionservice-allowpdatransfer
    HRESULT allowPDATransfer(HWND hwnd, IWMPPlaylist pPlaylist, BOOL* pfAllowTransfer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/subscriptionservices/nf-subscriptionservices-iwmpsubscriptionservice-startbackgroundprocessing
    HRESULT startBackgroundProcessing(HWND hwnd);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/subscriptionservices/nn-subscriptionservices-iwmpsubscriptionservicecallback
@GUID("dd01d127-2dc2-4c3a-876e-63312079f9b0")
interface IWMPSubscriptionServiceCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/subscriptionservices/nf-subscriptionservices-iwmpsubscriptionservicecallback-oncomplete
    HRESULT onComplete(HRESULT hrResult);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/subscriptionservices/nn-subscriptionservices-iwmpsubscriptionservice2
@GUID("a94c120e-d600-4ec6-b05e-ec9d56d84de0")
interface IWMPSubscriptionService2 : IWMPSubscriptionService
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/subscriptionservices/nf-subscriptionservices-iwmpsubscriptionservice2-stopbackgroundprocessing
    HRESULT stopBackgroundProcessing();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/subscriptionservices/nf-subscriptionservices-iwmpsubscriptionservice2-serviceevent
    HRESULT serviceEvent(WMPSubscriptionServiceEvent event);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/subscriptionservices/nf-subscriptionservices-iwmpsubscriptionservice2-deviceavailable
    HRESULT deviceAvailable(BSTR bstrDeviceName, IWMPSubscriptionServiceCallback pCB);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/subscriptionservices/nf-subscriptionservices-iwmpsubscriptionservice2-prepareforsync
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
