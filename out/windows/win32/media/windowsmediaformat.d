// Written in the D programming language.

module windows.win32.media.windowsmediaformat;

public import windows.core;
public import windows.win32.foundation : BOOL, BSTR, HRESULT, LPARAM, PWSTR, RECT;
public import windows.win32.graphics.gdi : BITMAPINFOHEADER;
public import windows.win32.system.com : IStream, IUnknown;
public import windows.win32.system.variant : VARIANT;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dshowasf/ne-dshowasf-_am_asfwriterconfig_param
alias _AM_ASFWRITERCONFIG_PARAM = int;
enum : int
{
    AM_CONFIGASFWRITER_PARAM_AUTOINDEX    = 0x00000001,
    AM_CONFIGASFWRITER_PARAM_MULTIPASS    = 0x00000002,
    AM_CONFIGASFWRITER_PARAM_DONTCOMPRESS = 0x00000003,
}

alias WEBSTREAM_SAMPLE_TYPE = int;
enum : int
{
    WEBSTREAM_SAMPLE_TYPE_FILE   = 0x00000001,
    WEBSTREAM_SAMPLE_TYPE_RENDER = 0x00000002,
}

alias WM_SF_TYPE = int;
enum : int
{
    WM_SF_CLEANPOINT    = 0x00000001,
    WM_SF_DISCONTINUITY = 0x00000002,
    WM_SF_DATALOSS      = 0x00000004,
}

alias WM_SFEX_TYPE = int;
enum : int
{
    WM_SFEX_NOTASYNCPOINT = 0x00000002,
    WM_SFEX_DATALOSS      = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ne-wmsdkidl-wmt_status
alias WMT_STATUS = int;
enum : int
{
    WMT_ERROR                       = 0x00000000,
    WMT_OPENED                      = 0x00000001,
    WMT_BUFFERING_START             = 0x00000002,
    WMT_BUFFERING_STOP              = 0x00000003,
    WMT_EOF                         = 0x00000004,
    WMT_END_OF_FILE                 = 0x00000004,
    WMT_END_OF_SEGMENT              = 0x00000005,
    WMT_END_OF_STREAMING            = 0x00000006,
    WMT_LOCATING                    = 0x00000007,
    WMT_CONNECTING                  = 0x00000008,
    WMT_NO_RIGHTS                   = 0x00000009,
    WMT_MISSING_CODEC               = 0x0000000a,
    WMT_STARTED                     = 0x0000000b,
    WMT_STOPPED                     = 0x0000000c,
    WMT_CLOSED                      = 0x0000000d,
    WMT_STRIDING                    = 0x0000000e,
    WMT_TIMER                       = 0x0000000f,
    WMT_INDEX_PROGRESS              = 0x00000010,
    WMT_SAVEAS_START                = 0x00000011,
    WMT_SAVEAS_STOP                 = 0x00000012,
    WMT_NEW_SOURCEFLAGS             = 0x00000013,
    WMT_NEW_METADATA                = 0x00000014,
    WMT_BACKUPRESTORE_BEGIN         = 0x00000015,
    WMT_SOURCE_SWITCH               = 0x00000016,
    WMT_ACQUIRE_LICENSE             = 0x00000017,
    WMT_INDIVIDUALIZE               = 0x00000018,
    WMT_NEEDS_INDIVIDUALIZATION     = 0x00000019,
    WMT_NO_RIGHTS_EX                = 0x0000001a,
    WMT_BACKUPRESTORE_END           = 0x0000001b,
    WMT_BACKUPRESTORE_CONNECTING    = 0x0000001c,
    WMT_BACKUPRESTORE_DISCONNECTING = 0x0000001d,
    WMT_ERROR_WITHURL               = 0x0000001e,
    WMT_RESTRICTED_LICENSE          = 0x0000001f,
    WMT_CLIENT_CONNECT              = 0x00000020,
    WMT_CLIENT_DISCONNECT           = 0x00000021,
    WMT_NATIVE_OUTPUT_PROPS_CHANGED = 0x00000022,
    WMT_RECONNECT_START             = 0x00000023,
    WMT_RECONNECT_END               = 0x00000024,
    WMT_CLIENT_CONNECT_EX           = 0x00000025,
    WMT_CLIENT_DISCONNECT_EX        = 0x00000026,
    WMT_SET_FEC_SPAN                = 0x00000027,
    WMT_PREROLL_READY               = 0x00000028,
    WMT_PREROLL_COMPLETE            = 0x00000029,
    WMT_CLIENT_PROPERTIES           = 0x0000002a,
    WMT_LICENSEURL_SIGNATURE_STATE  = 0x0000002b,
    WMT_INIT_PLAYLIST_BURN          = 0x0000002c,
    WMT_TRANSCRYPTOR_INIT           = 0x0000002d,
    WMT_TRANSCRYPTOR_SEEKED         = 0x0000002e,
    WMT_TRANSCRYPTOR_READ           = 0x0000002f,
    WMT_TRANSCRYPTOR_CLOSED         = 0x00000030,
    WMT_PROXIMITY_RESULT            = 0x00000031,
    WMT_PROXIMITY_COMPLETED         = 0x00000032,
    WMT_CONTENT_ENABLER             = 0x00000033,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ne-wmsdkidl-wmt_stream_selection
alias WMT_STREAM_SELECTION = int;
enum : int
{
    WMT_OFF             = 0x00000000,
    WMT_CLEANPOINT_ONLY = 0x00000001,
    WMT_ON              = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ne-wmsdkidl-wmt_image_type
alias WMT_IMAGE_TYPE = int;
enum : int
{
    WMT_IT_NONE   = 0x00000000,
    WMT_IT_BITMAP = 0x00000001,
    WMT_IT_JPEG   = 0x00000002,
    WMT_IT_GIF    = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ne-wmsdkidl-wmt_attr_datatype
alias WMT_ATTR_DATATYPE = int;
enum : int
{
    WMT_TYPE_DWORD  = 0x00000000,
    WMT_TYPE_STRING = 0x00000001,
    WMT_TYPE_BINARY = 0x00000002,
    WMT_TYPE_BOOL   = 0x00000003,
    WMT_TYPE_QWORD  = 0x00000004,
    WMT_TYPE_WORD   = 0x00000005,
    WMT_TYPE_GUID   = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ne-wmsdkidl-wmt_attr_imagetype
alias WMT_ATTR_IMAGETYPE = int;
enum : int
{
    WMT_IMAGETYPE_BITMAP = 0x00000001,
    WMT_IMAGETYPE_JPEG   = 0x00000002,
    WMT_IMAGETYPE_GIF    = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ne-wmsdkidl-wmt_version
alias WMT_VERSION = int;
enum : int
{
    WMT_VER_4_0 = 0x00040000,
    WMT_VER_7_0 = 0x00070000,
    WMT_VER_8_0 = 0x00080000,
    WMT_VER_9_0 = 0x00090000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ne-wmsdkidl-wmt_storage_format
alias WMT_STORAGE_FORMAT = int;
enum : int
{
    WMT_Storage_Format_MP3 = 0x00000000,
    WMT_Storage_Format_V1  = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ne-wmsdkidl-wmt_drmla_trust
alias WMT_DRMLA_TRUST = int;
enum : int
{
    WMT_DRMLA_UNTRUSTED = 0x00000000,
    WMT_DRMLA_TRUSTED   = 0x00000001,
    WMT_DRMLA_TAMPERED  = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ne-wmsdkidl-wmt_transport_type
alias WMT_TRANSPORT_TYPE = int;
enum : int
{
    WMT_Transport_Type_Unreliable = 0x00000000,
    WMT_Transport_Type_Reliable   = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ne-wmsdkidl-wmt_net_protocol
alias WMT_NET_PROTOCOL = int;
enum : int
{
    WMT_PROTOCOL_HTTP = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ne-wmsdkidl-wmt_play_mode
alias WMT_PLAY_MODE = int;
enum : int
{
    WMT_PLAY_MODE_AUTOSELECT = 0x00000000,
    WMT_PLAY_MODE_LOCAL      = 0x00000001,
    WMT_PLAY_MODE_DOWNLOAD   = 0x00000002,
    WMT_PLAY_MODE_STREAMING  = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ne-wmsdkidl-wmt_proxy_settings
alias WMT_PROXY_SETTINGS = int;
enum : int
{
    WMT_PROXY_SETTING_NONE    = 0x00000000,
    WMT_PROXY_SETTING_MANUAL  = 0x00000001,
    WMT_PROXY_SETTING_AUTO    = 0x00000002,
    WMT_PROXY_SETTING_BROWSER = 0x00000003,
    WMT_PROXY_SETTING_MAX     = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ne-wmsdkidl-wmt_codec_info_type
alias WMT_CODEC_INFO_TYPE = int;
enum : int
{
    WMT_CODECINFO_AUDIO   = 0x00000000,
    WMT_CODECINFO_VIDEO   = 0x00000001,
    WMT_CODECINFO_UNKNOWN = 0xffffffff,
}

alias WM_DM_INTERLACED_TYPE = int;
enum : int
{
    WM_DM_NOTINTERLACED                          = 0x00000000,
    WM_DM_DEINTERLACE_NORMAL                     = 0x00000001,
    WM_DM_DEINTERLACE_HALFSIZE                   = 0x00000002,
    WM_DM_DEINTERLACE_HALFSIZEDOUBLERATE         = 0x00000003,
    WM_DM_DEINTERLACE_INVERSETELECINE            = 0x00000004,
    WM_DM_DEINTERLACE_VERTICALHALFSIZEDOUBLERATE = 0x00000005,
}

alias WM_DM_IT_FIRST_FRAME_COHERENCY = int;
enum : int
{
    WM_DM_IT_DISABLE_COHERENT_MODE            = 0x00000000,
    WM_DM_IT_FIRST_FRAME_IN_CLIP_IS_AA_TOP    = 0x00000001,
    WM_DM_IT_FIRST_FRAME_IN_CLIP_IS_BB_TOP    = 0x00000002,
    WM_DM_IT_FIRST_FRAME_IN_CLIP_IS_BC_TOP    = 0x00000003,
    WM_DM_IT_FIRST_FRAME_IN_CLIP_IS_CD_TOP    = 0x00000004,
    WM_DM_IT_FIRST_FRAME_IN_CLIP_IS_DD_TOP    = 0x00000005,
    WM_DM_IT_FIRST_FRAME_IN_CLIP_IS_AA_BOTTOM = 0x00000006,
    WM_DM_IT_FIRST_FRAME_IN_CLIP_IS_BB_BOTTOM = 0x00000007,
    WM_DM_IT_FIRST_FRAME_IN_CLIP_IS_BC_BOTTOM = 0x00000008,
    WM_DM_IT_FIRST_FRAME_IN_CLIP_IS_CD_BOTTOM = 0x00000009,
    WM_DM_IT_FIRST_FRAME_IN_CLIP_IS_DD_BOTTOM = 0x0000000a,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ne-wmsdkidl-wmt_offset_format
alias WMT_OFFSET_FORMAT = int;
enum : int
{
    WMT_OFFSET_FORMAT_100NS             = 0x00000000,
    WMT_OFFSET_FORMAT_FRAME_NUMBERS     = 0x00000001,
    WMT_OFFSET_FORMAT_PLAYLIST_OFFSET   = 0x00000002,
    WMT_OFFSET_FORMAT_TIMECODE          = 0x00000003,
    WMT_OFFSET_FORMAT_100NS_APPROXIMATE = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ne-wmsdkidl-wmt_indexer_type
alias WMT_INDEXER_TYPE = int;
enum : int
{
    WMT_IT_PRESENTATION_TIME = 0x00000000,
    WMT_IT_FRAME_NUMBERS     = 0x00000001,
    WMT_IT_TIMECODE          = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ne-wmsdkidl-wmt_index_type
alias WMT_INDEX_TYPE = int;
enum : int
{
    WMT_IT_NEAREST_DATA_UNIT   = 0x00000001,
    WMT_IT_NEAREST_OBJECT      = 0x00000002,
    WMT_IT_NEAREST_CLEAN_POINT = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ne-wmsdkidl-wmt_filesink_mode
alias WMT_FILESINK_MODE = int;
enum : int
{
    WMT_FM_SINGLE_BUFFERS      = 0x00000001,
    WMT_FM_FILESINK_DATA_UNITS = 0x00000002,
    WMT_FM_FILESINK_UNBUFFERED = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ne-wmsdkidl-wmt_musicspeech_class_mode
alias WMT_MUSICSPEECH_CLASS_MODE = int;
enum : int
{
    WMT_MS_CLASS_MUSIC  = 0x00000000,
    WMT_MS_CLASS_SPEECH = 0x00000001,
    WMT_MS_CLASS_MIXED  = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ne-wmsdkidl-wmt_watermark_entry_type
alias WMT_WATERMARK_ENTRY_TYPE = int;
enum : int
{
    WMT_WMETYPE_AUDIO = 0x00000001,
    WMT_WMETYPE_VIDEO = 0x00000002,
}

alias WM_PLAYBACK_DRC_LEVEL = int;
enum : int
{
    WM_PLAYBACK_DRC_HIGH   = 0x00000000,
    WM_PLAYBACK_DRC_MEDIUM = 0x00000001,
    WM_PLAYBACK_DRC_LOW    = 0x00000002,
}

alias WMT_TIMECODE_FRAMERATE = int;
enum : int
{
    WMT_TIMECODE_FRAMERATE_30     = 0x00000000,
    WMT_TIMECODE_FRAMERATE_30DROP = 0x00000001,
    WMT_TIMECODE_FRAMERATE_25     = 0x00000002,
    WMT_TIMECODE_FRAMERATE_24     = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ne-wmsdkidl-wmt_credential_flags
alias WMT_CREDENTIAL_FLAGS = int;
enum : int
{
    WMT_CREDENTIAL_SAVE       = 0x00000001,
    WMT_CREDENTIAL_DONT_CACHE = 0x00000002,
    WMT_CREDENTIAL_CLEAR_TEXT = 0x00000004,
    WMT_CREDENTIAL_PROXY      = 0x00000008,
    WMT_CREDENTIAL_ENCRYPT    = 0x00000010,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ne-wmsdkidl-wm_aetype
alias WM_AETYPE = int;
enum : int
{
    WM_AETYPE_INCLUDE = 0x00000069,
    WM_AETYPE_EXCLUDE = 0x00000065,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ne-wmsdkidl-wmt_rights
alias WMT_RIGHTS = int;
enum : int
{
    WMT_RIGHT_PLAYBACK                = 0x00000001,
    WMT_RIGHT_COPY_TO_NON_SDMI_DEVICE = 0x00000002,
    WMT_RIGHT_COPY_TO_CD              = 0x00000008,
    WMT_RIGHT_COPY_TO_SDMI_DEVICE     = 0x00000010,
    WMT_RIGHT_ONE_TIME                = 0x00000020,
    WMT_RIGHT_SAVE_STREAM_PROTECTED   = 0x00000040,
    WMT_RIGHT_COPY                    = 0x00000080,
    WMT_RIGHT_COLLABORATIVE_PLAY      = 0x00000100,
    WMT_RIGHT_SDMI_TRIGGER            = 0x00010000,
    WMT_RIGHT_SDMI_NOMORECOPIES       = 0x00020000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsinternaladminnetsource/ne-wmsinternaladminnetsource-netsource_urlcredpolicy_settings
alias NETSOURCE_URLCREDPOLICY_SETTINGS = int;
enum : int
{
    NETSOURCE_URLCREDPOLICY_SETTING_SILENTLOGONOK  = 0x00000000,
    NETSOURCE_URLCREDPOLICY_SETTING_MUSTPROMPTUSER = 0x00000001,
    NETSOURCE_URLCREDPOLICY_SETTING_ANONYMOUSONLY  = 0x00000002,
}

// Constants


enum : uint
{
    WMT_VIDEOIMAGE_SAMPLE_INPUT_FRAME               = 0x00000001U,
    WMT_VIDEOIMAGE_SAMPLE_OUTPUT_FRAME              = 0x00000002U,
    WMT_VIDEOIMAGE_SAMPLE_USES_CURRENT_INPUT_FRAME  = 0x00000004U,
    WMT_VIDEOIMAGE_SAMPLE_USES_PREVIOUS_INPUT_FRAME = 0x00000008U,
    WMT_VIDEOIMAGE_SAMPLE_MOTION                    = 0x00000001U,
    WMT_VIDEOIMAGE_SAMPLE_ROTATION                  = 0x00000002U,
    WMT_VIDEOIMAGE_SAMPLE_BLENDING                  = 0x00000004U,
    WMT_VIDEOIMAGE_SAMPLE_ADV_BLENDING              = 0x00000008U,
}

enum int WMT_VIDEOIMAGE_INTEGER_DENOMINATOR = 0x00010000;

enum : uint
{
    WMT_VIDEOIMAGE_MAGIC_NUMBER             = 0x1d4a45f2U,
    WMT_VIDEOIMAGE_MAGIC_NUMBER_2           = 0x1d4a45f3U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wmformat/wmt-videoimage-transition-bow-tie
    WMT_VIDEOIMAGE_TRANSITION_BOW_TIE       = 0x0000000bU,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wmformat/wmt-videoimage-transition-circle
    WMT_VIDEOIMAGE_TRANSITION_CIRCLE        = 0x0000000cU,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wmformat/wmt-videoimage-transition-cross-fade
    WMT_VIDEOIMAGE_TRANSITION_CROSS_FADE    = 0x0000000dU,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wmformat/wmt-videoimage-transition-diagonal
    WMT_VIDEOIMAGE_TRANSITION_DIAGONAL      = 0x0000000eU,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wmformat/wmt-videoimage-transition-diamond
    WMT_VIDEOIMAGE_TRANSITION_DIAMOND       = 0x0000000fU,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wmformat/wmt-videoimage-transition-fade-to-color
    WMT_VIDEOIMAGE_TRANSITION_FADE_TO_COLOR = 0x00000010U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wmformat/wmt-videoimage-transition-filled-v
    WMT_VIDEOIMAGE_TRANSITION_FILLED_V      = 0x00000011U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wmformat/wmt-videoimage-transition-flip
    WMT_VIDEOIMAGE_TRANSITION_FLIP          = 0x00000012U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wmformat/wmt-videoimage-transition-inset
    WMT_VIDEOIMAGE_TRANSITION_INSET         = 0x00000013U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wmformat/wmt-videoimage-transition-iris
    WMT_VIDEOIMAGE_TRANSITION_IRIS          = 0x00000014U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wmformat/wmt-videoimage-transition-page-roll
    WMT_VIDEOIMAGE_TRANSITION_PAGE_ROLL     = 0x00000015U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wmformat/wmt-videoimage-transition-rectangle
    WMT_VIDEOIMAGE_TRANSITION_RECTANGLE     = 0x00000017U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wmformat/wmt-videoimage-transition-reveal
    WMT_VIDEOIMAGE_TRANSITION_REVEAL        = 0x00000018U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wmformat/wmt-videoimage-transition-slide
    WMT_VIDEOIMAGE_TRANSITION_SLIDE         = 0x0000001bU,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wmformat/wmt-videoimage-transition-split
    WMT_VIDEOIMAGE_TRANSITION_SPLIT         = 0x0000001dU,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wmformat/wmt-videoimage-transition-star
    WMT_VIDEOIMAGE_TRANSITION_STAR          = 0x0000001eU,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wmformat/wmt-videoimage-transition-wheel
    WMT_VIDEOIMAGE_TRANSITION_WHEEL         = 0x0000001fU,
}

enum : uint
{
    WM_SampleExtension_ContentType_Size      = 0x00000001U,
    WM_SampleExtension_PixelAspectRatio_Size = 0x00000002U,
    WM_SampleExtension_Timecode_Size         = 0x0000000eU,
    WM_SampleExtension_SampleDuration_Size   = 0x00000002U,
    WM_SampleExtension_ChromaLocation_Size   = 0x00000001U,
    WM_SampleExtension_ColorSpaceInfo_Size   = 0x00000003U,
}

enum uint WM_CT_REPEAT_FIRST_FIELD = 0x00000010U;
enum uint WM_CT_BOTTOM_FIELD_FIRST = 0x00000020U;
enum uint WM_CT_TOP_FIELD_FIRST = 0x00000040U;
enum uint WM_CT_INTERLACED = 0x00000080U;
enum uint WM_CL_INTERLACED420 = 0x00000000U;
enum uint WM_CL_PROGRESSIVE420 = 0x00000001U;
enum uint WM_MAX_VIDEO_STREAMS = 0x0000003fU;
enum uint WM_MAX_STREAMS = 0x0000003fU;
enum uint WMDRM_IMPORT_INIT_STRUCT_DEFINED = 0x00000001U;
enum uint DRM_OPL_TYPES = 0x00000001U;
enum uint g_dwWMSpecialAttributes = 0x00000014U;

enum : const(wchar)*
{
    g_wszWMDuration       = "Duration",
    g_wszWMBitrate        = "Bitrate",
    g_wszWMSeekable       = "Seekable",
    g_wszWMStridable      = "Stridable",
    g_wszWMBroadcast      = "Broadcast",
    g_wszWMProtected      = "Is_Protected",
    g_wszWMTrusted        = "Is_Trusted",
    g_wszWMSignature_Name = "Signature_Name",
}

enum : const(wchar)*
{
    g_wszWMHasAudio       = "HasAudio",
    g_wszWMHasImage       = "HasImage",
    g_wszWMHasScript      = "HasScript",
    g_wszWMHasVideo       = "HasVideo",
    g_wszWMCurrentBitrate = "CurrentBitrate",
}

enum const(wchar)* g_wszWMOptimalBitrate = "OptimalBitrate";
enum const(wchar)* g_wszWMHasAttachedImages = "HasAttachedImages";

enum : const(wchar)*
{
    g_wszWMSkipBackward = "Can_Skip_Backward",
    g_wszWMSkipForward  = "Can_Skip_Forward",
}

enum const(wchar)* g_wszWMNumberOfFrames = "NumberOfFrames";

enum : const(wchar)*
{
    g_wszWMFileSize               = "FileSize",
    g_wszWMHasArbitraryDataStream = "HasArbitraryDataStream",
}

enum const(wchar)* g_wszWMHasFileTransferStream = "HasFileTransferStream";
enum const(wchar)* g_wszWMContainerFormat = "WM/ContainerFormat";
enum uint g_dwWMContentAttributes = 0x00000005U;

enum : const(wchar)*
{
    g_wszWMTitle       = "Title",
    g_wszWMTitleSort   = "TitleSort",
    g_wszWMAuthor      = "Author",
    g_wszWMAuthorSort  = "AuthorSort",
    g_wszWMDescription = "Description",
}

enum : const(wchar)*
{
    g_wszWMRating           = "Rating",
    g_wszWMCopyright        = "Copyright",
    g_wszWMUse_DRM          = "Use_DRM",
    g_wszWMDRM_Flags        = "DRM_Flags",
    g_wszWMDRM_Level        = "DRM_Level",
    g_wszWMUse_Advanced_DRM = "Use_Advanced_DRM",
}

enum : const(wchar)*
{
    g_wszWMDRM_KeySeed               = "DRM_KeySeed",
    g_wszWMDRM_KeyID                 = "DRM_KeyID",
    g_wszWMDRM_ContentID             = "DRM_ContentID",
    g_wszWMDRM_SourceID              = "DRM_SourceID",
    g_wszWMDRM_IndividualizedVersion = "DRM_IndividualizedVersion",
}

enum : const(wchar)*
{
    g_wszWMDRM_LicenseAcqURL     = "DRM_LicenseAcqURL",
    g_wszWMDRM_V1LicenseAcqURL   = "DRM_V1LicenseAcqURL",
    g_wszWMDRM_HeaderSignPrivKey = "DRM_HeaderSignPrivKey",
}

enum : const(wchar)*
{
    g_wszWMDRM_LASignaturePrivKey    = "DRM_LASignaturePrivKey",
    g_wszWMDRM_LASignatureCert       = "DRM_LASignatureCert",
    g_wszWMDRM_LASignatureLicSrvCert = "DRM_LASignatureLicSrvCert",
    g_wszWMDRM_LASignatureRootCert   = "DRM_LASignatureRootCert",
}

enum : const(wchar)*
{
    g_wszWMAlbumTitle     = "WM/AlbumTitle",
    g_wszWMAlbumTitleSort = "WM/AlbumTitleSort",
}

enum : const(wchar)*
{
    g_wszWMTrack        = "WM/Track",
    g_wszWMPromotionURL = "WM/PromotionURL",
}

enum const(wchar)* g_wszWMAlbumCoverURL = "WM/AlbumCoverURL";

enum : const(wchar)*
{
    g_wszWMGenre        = "WM/Genre",
    g_wszWMYear         = "WM/Year",
    g_wszWMGenreID      = "WM/GenreID",
    g_wszWMMCDI         = "WM/MCDI",
    g_wszWMComposer     = "WM/Composer",
    g_wszWMComposerSort = "WM/ComposerSort",
}

enum : const(wchar)*
{
    g_wszWMLyrics      = "WM/Lyrics",
    g_wszWMTrackNumber = "WM/TrackNumber",
    g_wszWMToolName    = "WM/ToolName",
    g_wszWMToolVersion = "WM/ToolVersion",
}

enum : const(wchar)*
{
    g_wszWMIsVBR           = "IsVBR",
    g_wszWMAlbumArtist     = "WM/AlbumArtist",
    g_wszWMAlbumArtistSort = "WM/AlbumArtistSort",
}

enum : const(wchar)*
{
    g_wszWMBannerImageType = "BannerImageType",
    g_wszWMBannerImageData = "BannerImageData",
    g_wszWMBannerImageURL  = "BannerImageURL",
}

enum const(wchar)* g_wszWMCopyrightURL = "CopyrightURL";

enum : const(wchar)*
{
    g_wszWMAspectRatioX = "AspectRatioX",
    g_wszWMAspectRatioY = "AspectRatioY",
}

enum const(wchar)* g_wszASFLeakyBucketPairs = "ASFLeakyBucketPairs";
enum uint g_dwWMNSCAttributes = 0x00000005U;

enum : const(wchar)*
{
    g_wszWMNSCName        = "NSC_Name",
    g_wszWMNSCAddress     = "NSC_Address",
    g_wszWMNSCPhone       = "NSC_Phone",
    g_wszWMNSCEmail       = "NSC_Email",
    g_wszWMNSCDescription = "NSC_Description",
}

enum : const(wchar)*
{
    g_wszWMWriter                  = "WM/Writer",
    g_wszWMConductor               = "WM/Conductor",
    g_wszWMProducer                = "WM/Producer",
    g_wszWMDirector                = "WM/Director",
    g_wszWMContentGroupDescription = "WM/ContentGroupDescription",
}

enum : const(wchar)*
{
    g_wszWMSubTitle       = "WM/SubTitle",
    g_wszWMPartOfSet      = "WM/PartOfSet",
    g_wszWMProtectionType = "WM/ProtectionType",
}

enum : const(wchar)*
{
    g_wszWMVideoHeight    = "WM/VideoHeight",
    g_wszWMVideoWidth     = "WM/VideoWidth",
    g_wszWMVideoFrameRate = "WM/VideoFrameRate",
}

enum : const(wchar)*
{
    g_wszWMMediaClassPrimaryID   = "WM/MediaClassPrimaryID",
    g_wszWMMediaClassSecondaryID = "WM/MediaClassSecondaryID",
}

enum : const(wchar)*
{
    g_wszWMPeriod              = "WM/Period",
    g_wszWMCategory            = "WM/Category",
    g_wszWMPicture             = "WM/Picture",
    g_wszWMLyrics_Synchronised = "WM/Lyrics_Synchronised",
}

enum : const(wchar)*
{
    g_wszWMOriginalLyricist    = "WM/OriginalLyricist",
    g_wszWMOriginalArtist      = "WM/OriginalArtist",
    g_wszWMOriginalAlbumTitle  = "WM/OriginalAlbumTitle",
    g_wszWMOriginalReleaseYear = "WM/OriginalReleaseYear",
    g_wszWMOriginalFilename    = "WM/OriginalFilename",
}

enum : const(wchar)*
{
    g_wszWMPublisher        = "WM/Publisher",
    g_wszWMEncodedBy        = "WM/EncodedBy",
    g_wszWMEncodingSettings = "WM/EncodingSettings",
    g_wszWMEncodingTime     = "WM/EncodingTime",
}

enum : const(wchar)*
{
    g_wszWMAuthorURL      = "WM/AuthorURL",
    g_wszWMUserWebURL     = "WM/UserWebURL",
    g_wszWMAudioFileURL   = "WM/AudioFileURL",
    g_wszWMAudioSourceURL = "WM/AudioSourceURL",
}

enum : const(wchar)*
{
    g_wszWMLanguage       = "WM/Language",
    g_wszWMParentalRating = "WM/ParentalRating",
}

enum const(wchar)* g_wszWMBeatsPerMinute = "WM/BeatsPerMinute";

enum : const(wchar)*
{
    g_wszWMInitialKey          = "WM/InitialKey",
    g_wszWMMood                = "WM/Mood",
    g_wszWMText                = "WM/Text",
    g_wszWMDVDID               = "WM/DVDID",
    g_wszWMWMContentID         = "WM/WMContentID",
    g_wszWMWMCollectionID      = "WM/WMCollectionID",
    g_wszWMWMCollectionGroupID = "WM/WMCollectionGroupID",
}

enum const(wchar)* g_wszWMUniqueFileIdentifier = "WM/UniqueFileIdentifier";

enum : const(wchar)*
{
    g_wszWMModifiedBy        = "WM/ModifiedBy",
    g_wszWMRadioStationName  = "WM/RadioStationName",
    g_wszWMRadioStationOwner = "WM/RadioStationOwner",
}

enum const(wchar)* g_wszWMPlaylistDelay = "WM/PlaylistDelay";

enum : const(wchar)*
{
    g_wszWMCodec          = "WM/Codec",
    g_wszWMDRM            = "WM/DRM",
    g_wszWMISRC           = "WM/ISRC",
    g_wszWMProvider       = "WM/Provider",
    g_wszWMProviderRating = "WM/ProviderRating",
    g_wszWMProviderStyle  = "WM/ProviderStyle",
}

enum const(wchar)* g_wszWMContentDistributor = "WM/ContentDistributor";
enum const(wchar)* g_wszWMSubscriptionContentID = "WM/SubscriptionContentID";

enum : const(wchar)*
{
    g_wszWMWMADRCPeakReference    = "WM/WMADRCPeakReference",
    g_wszWMWMADRCPeakTarget       = "WM/WMADRCPeakTarget",
    g_wszWMWMADRCAverageReference = "WM/WMADRCAverageReference",
    g_wszWMWMADRCAverageTarget    = "WM/WMADRCAverageTarget",
}

enum const(wchar)* g_wszWMStreamTypeInfo = "WM/StreamTypeInfo";
enum const(wchar)* g_wszWMPeakBitrate = "WM/PeakBitrate";

enum : const(wchar)*
{
    g_wszWMASFPacketCount         = "WM/ASFPacketCount",
    g_wszWMASFSecurityObjectsSize = "WM/ASFSecurityObjectsSize",
}

enum const(wchar)* g_wszWMSharedUserRating = "WM/SharedUserRating";
enum const(wchar)* g_wszWMSubTitleDescription = "WM/SubTitleDescription";
enum const(wchar)* g_wszWMMediaCredits = "WM/MediaCredits";
enum const(wchar)* g_wszWMParentalRatingReason = "WM/ParentalRatingReason";
enum const(wchar)* g_wszWMOriginalReleaseTime = "WM/OriginalReleaseTime";

enum : const(wchar)*
{
    g_wszWMMediaStationCallSign    = "WM/MediaStationCallSign",
    g_wszWMMediaStationName        = "WM/MediaStationName",
    g_wszWMMediaNetworkAffiliation = "WM/MediaNetworkAffiliation",
}

enum : const(wchar)*
{
    g_wszWMMediaOriginalChannel           = "WM/MediaOriginalChannel",
    g_wszWMMediaOriginalBroadcastDateTime = "WM/MediaOriginalBroadcastDateTime",
}

enum const(wchar)* g_wszWMMediaIsStereo = "WM/MediaIsStereo";
enum const(wchar)* g_wszWMVideoClosedCaptioning = "WM/VideoClosedCaptioning";

enum : const(wchar)*
{
    g_wszWMMediaIsRepeat     = "WM/MediaIsRepeat",
    g_wszWMMediaIsLive       = "WM/MediaIsLive",
    g_wszWMMediaIsTape       = "WM/MediaIsTape",
    g_wszWMMediaIsDelay      = "WM/MediaIsDelay",
    g_wszWMMediaIsSubtitled  = "WM/MediaIsSubtitled",
    g_wszWMMediaIsPremiere   = "WM/MediaIsPremiere",
    g_wszWMMediaIsFinale     = "WM/MediaIsFinale",
    g_wszWMMediaIsSAP        = "WM/MediaIsSAP",
    g_wszWMProviderCopyright = "WM/ProviderCopyright",
}

enum : const(wchar)*
{
    g_wszWMISAN                       = "WM/ISAN",
    g_wszWMADID                       = "WM/ADID",
    g_wszWMWMShadowFileSourceFileType = "WM/WMShadowFileSourceFileType",
    g_wszWMWMShadowFileSourceDRMType  = "WM/WMShadowFileSourceDRMType",
}

enum : const(wchar)*
{
    g_wszWMWMCPDistributor   = "WM/WMCPDistributor",
    g_wszWMWMCPDistributorID = "WM/WMCPDistributorID",
}

enum const(wchar)* g_wszWMSeasonNumber = "WM/SeasonNumber";
enum const(wchar)* g_wszWMEpisodeNumber = "WM/EpisodeNumber";
enum const(wchar)* g_wszEarlyDataDelivery = "EarlyDataDelivery";
enum const(wchar)* g_wszJustInTimeDecode = "JustInTimeDecode";
enum const(wchar)* g_wszSingleOutputBuffer = "SingleOutputBuffer";
enum const(wchar)* g_wszSoftwareScaling = "SoftwareScaling";
enum const(wchar)* g_wszDeliverOnReceive = "DeliverOnReceive";
enum const(wchar)* g_wszScrambledAudio = "ScrambledAudio";
enum const(wchar)* g_wszDedicatedDeliveryThread = "DedicatedDeliveryThread";
enum const(wchar)* g_wszEnableDiscreteOutput = "EnableDiscreteOutput";
enum const(wchar)* g_wszSpeakerConfig = "SpeakerConfig";
enum const(wchar)* g_wszDynamicRangeControl = "DynamicRangeControl";
enum const(wchar)* g_wszAllowInterlacedOutput = "AllowInterlacedOutput";
enum const(wchar)* g_wszVideoSampleDurations = "VideoSampleDurations";
enum const(wchar)* g_wszStreamLanguage = "StreamLanguage";
enum const(wchar)* g_wszEnableWMAProSPDIFOutput = "EnableWMAProSPDIFOutput";
enum const(wchar)* g_wszDeinterlaceMode = "DeinterlaceMode";
enum const(wchar)* g_wszInitialPatternForInverseTelecine = "InitialPatternForInverseTelecine";
enum const(wchar)* g_wszJPEGCompressionQuality = "JPEGCompressionQuality";

enum : const(wchar)*
{
    g_wszWatermarkCLSID  = "WatermarkCLSID",
    g_wszWatermarkConfig = "WatermarkConfig",
}

enum const(wchar)* g_wszInterlacedCoding = "InterlacedCoding";
enum const(wchar)* g_wszFixedFrameRate = "FixedFrameRate";

enum : const(wchar)*
{
    g_wszOriginalSourceFormatTag = "_SOURCEFORMATTAG",
    g_wszOriginalWaveFormat      = "_ORIGINALWAVEFORMAT",
}

enum : const(wchar)*
{
    g_wszEDL        = "_EDL",
    g_wszComplexity = "_COMPLEXITYEX",
}

enum const(wchar)* g_wszDecoderComplexityRequested = "_DECODERCOMPLEXITYPROFILE";
enum const(wchar)* g_wszReloadIndexOnSeek = "ReloadIndexOnSeek";
enum const(wchar)* g_wszStreamNumIndexObjects = "StreamNumIndexObjects";
enum const(wchar)* g_wszFailSeekOnError = "FailSeekOnError";
enum const(wchar)* g_wszPermitSeeksBeyondEndOfStream = "PermitSeeksBeyondEndOfStream";
enum const(wchar)* g_wszUsePacketAtSeekPoint = "UsePacketAtSeekPoint";

enum : const(wchar)*
{
    g_wszSourceBufferTime     = "SourceBufferTime",
    g_wszSourceMaxBytesAtOnce = "SourceMaxBytesAtOnce",
}

enum : const(wchar)*
{
    g_wszVBREnabled         = "_VBRENABLED",
    g_wszVBRQuality         = "_VBRQUALITY",
    g_wszVBRBitrateMax      = "_RMAX",
    g_wszVBRBufferWindowMax = "_BMAX",
}

enum : const(wchar)*
{
    g_wszVBRPeak       = "VBR Peak",
    g_wszBufferAverage = "Buffer Average",
}

enum : const(wchar)*
{
    g_wszComplexityMax     = "_COMPLEXITYEXMAX",
    g_wszComplexityOffline = "_COMPLEXITYEXOFFLINE",
    g_wszComplexityLive    = "_COMPLEXITYEXLIVE",
}

enum const(wchar)* g_wszIsVBRSupported = "_ISVBRSUPPORTED";
enum const(wchar)* g_wszNumPasses = "_PASSESUSED";
enum const(wchar)* g_wszMusicSpeechClassMode = "MusicSpeechClassMode";
enum const(wchar)* g_wszMusicClassMode = "MusicClassMode";
enum const(wchar)* g_wszSpeechClassMode = "SpeechClassMode";
enum const(wchar)* g_wszMixedClassMode = "MixedClassMode";
enum const(wchar)* g_wszSpeechCaps = "SpeechFormatCap";
enum const(wchar)* g_wszPeakValue = "PeakValue";
enum const(wchar)* g_wszAverageLevel = "AverageLevel";

enum : const(wchar)*
{
    g_wszFold6To2Channels3      = "Fold6To2Channels3",
    g_wszFoldToChannelsTemplate = "Fold%luTo%luChannels%lu",
}

enum const(wchar)* g_wszDeviceConformanceTemplate = "DeviceConformanceTemplate";
enum const(wchar)* g_wszEnableFrameInterpolation = "EnableFrameInterpolation";
enum const(wchar)* g_wszNeedsPreviousSample = "NeedsPreviousSample";
enum const(wchar)* g_wszWMIsCompilation = "WM/IsCompilation";
enum GUID WMMEDIASUBTYPE_Base = GUID("00000000-0000-0010-8000-00aa00389b71");

enum : GUID
{
    WMMEDIATYPE_Video          = GUID("73646976-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_RGB1        = GUID("e436eb78-524f-11ce-9f53-0020af0ba770"),
    WMMEDIASUBTYPE_RGB4        = GUID("e436eb79-524f-11ce-9f53-0020af0ba770"),
    WMMEDIASUBTYPE_RGB8        = GUID("e436eb7a-524f-11ce-9f53-0020af0ba770"),
    WMMEDIASUBTYPE_RGB565      = GUID("e436eb7b-524f-11ce-9f53-0020af0ba770"),
    WMMEDIASUBTYPE_RGB555      = GUID("e436eb7c-524f-11ce-9f53-0020af0ba770"),
    WMMEDIASUBTYPE_RGB24       = GUID("e436eb7d-524f-11ce-9f53-0020af0ba770"),
    WMMEDIASUBTYPE_RGB32       = GUID("e436eb7e-524f-11ce-9f53-0020af0ba770"),
    WMMEDIASUBTYPE_I420        = GUID("30323449-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_IYUV        = GUID("56555949-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_YV12        = GUID("32315659-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_YUY2        = GUID("32595559-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_P422        = GUID("32323450-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_UYVY        = GUID("59565955-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_YVYU        = GUID("55595659-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_YVU9        = GUID("39555659-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_VIDEOIMAGE  = GUID("1d4a45f2-e5f6-4b44-8388-f0ae5c0e0c37"),
    WMMEDIASUBTYPE_MP43        = GUID("3334504d-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_MP4S        = GUID("5334504d-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_M4S2        = GUID("3253344d-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_WMV1        = GUID("31564d57-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_WMV2        = GUID("32564d57-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_MSS1        = GUID("3153534d-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_MPEG2_VIDEO = GUID("e06d8026-db46-11cf-b4d1-00805f6cbbea"),
}

enum : GUID
{
    WMMEDIATYPE_Audio               = GUID("73647561-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_PCM              = GUID("00000001-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_DRM              = GUID("00000009-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_WMAudioV9        = GUID("00000162-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_WMAudio_Lossless = GUID("00000163-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_MSS2             = GUID("3253534d-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_WMSP1            = GUID("0000000a-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_WMSP2            = GUID("0000000b-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_WMV3             = GUID("33564d57-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_WMVP             = GUID("50564d57-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_WVP2             = GUID("32505657-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_WMVA             = GUID("41564d57-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_WVC1             = GUID("31435657-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_WMAudioV8        = GUID("00000161-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_WMAudioV7        = GUID("00000161-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_WMAudioV2        = GUID("00000161-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_ACELPnet         = GUID("00000130-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_MP3              = GUID("00000055-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_WebStream        = GUID("776257d4-c627-41cb-8f81-7ac7ff1c40cc"),
}

enum : GUID
{
    WMMEDIATYPE_Script       = GUID("73636d64-0000-0010-8000-00aa00389b71"),
    WMMEDIATYPE_Image        = GUID("34a50fd8-8aa5-4386-81fe-a0efe0488e31"),
    WMMEDIATYPE_FileTransfer = GUID("d9e47579-930e-4427-adfc-ad80f290e470"),
    WMMEDIATYPE_Text         = GUID("9bba1ea7-5ab2-4829-ba57-0940209bcf3e"),
}

enum : GUID
{
    WMFORMAT_VideoInfo    = GUID("05589f80-c356-11ce-bf01-00aa0055595a"),
    WMFORMAT_MPEG2Video   = GUID("e06d80e3-db46-11cf-b4d1-00805f6cbbea"),
    WMFORMAT_WaveFormatEx = GUID("05589f81-c356-11ce-bf01-00aa0055595a"),
    WMFORMAT_Script       = GUID("5c8510f2-debe-4ca7-bba5-f07a104f8dff"),
    WMFORMAT_WebStream    = GUID("da1e6b13-8359-4050-b398-388e965bf00c"),
}

enum GUID WMSCRIPTTYPE_TwoStrings = GUID("82f38a70-c29f-11d1-97ad-00a0c95ea850");

enum : GUID
{
    WM_SampleExtensionGUID_OutputCleanPoint     = GUID("f72a3c6f-6eb4-4ebc-b192-09ad9759e828"),
    WM_SampleExtensionGUID_Timecode             = GUID("399595ec-8667-4e2d-8fdb-98814ce76c1e"),
    WM_SampleExtensionGUID_ChromaLocation       = GUID("4c5acca0-9276-4b2c-9e4c-a0edefdd217e"),
    WM_SampleExtensionGUID_ColorSpaceInfo       = GUID("f79ada56-30eb-4f2b-9f7a-f24b139a1157"),
    WM_SampleExtensionGUID_UserDataInfo         = GUID("732bb4fa-78be-4549-99bd-02db1a55b7a8"),
    WM_SampleExtensionGUID_FileName             = GUID("e165ec0e-19ed-45d7-b4a7-25cbd1e28e9b"),
    WM_SampleExtensionGUID_ContentType          = GUID("d590dc20-07bc-436c-9cf7-f3bbfbf1a4dc"),
    WM_SampleExtensionGUID_PixelAspectRatio     = GUID("1b1ee554-f9ea-4bc8-821a-376b74e4c4b8"),
    WM_SampleExtensionGUID_SampleDuration       = GUID("c6bd9450-867f-4907-83a3-c77921b733ad"),
    WM_SampleExtensionGUID_SampleProtectionSalt = GUID("5403deee-b9ee-438f-aa83-3804997e569d"),
}

enum : GUID
{
    CLSID_WMMUTEX_Language     = GUID("d6e22a00-35da-11d1-9034-00a0c90349be"),
    CLSID_WMMUTEX_Bitrate      = GUID("d6e22a01-35da-11d1-9034-00a0c90349be"),
    CLSID_WMMUTEX_Presentation = GUID("d6e22a02-35da-11d1-9034-00a0c90349be"),
    CLSID_WMMUTEX_Unknown      = GUID("d6e22a03-35da-11d1-9034-00a0c90349be"),
}

enum : GUID
{
    CLSID_WMBandwidthSharing_Exclusive = GUID("af6060aa-5197-11d2-b6af-00c04fd908e9"),
    CLSID_WMBandwidthSharing_Partial   = GUID("af6060ab-5197-11d2-b6af-00c04fd908e9"),
}

enum : GUID
{
    WMT_DMOCATEGORY_AUDIO_WATERMARK = GUID("65221c5a-fa75-4b39-b50c-06c336b6a3ef"),
    WMT_DMOCATEGORY_VIDEO_WATERMARK = GUID("187cc922-8efc-4404-9daf-63f4830df1bc"),
}

enum GUID CLSID_ClientNetManager = GUID("cd12a3ce-9c42-11d2-beed-0060082f2054");

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/evcode/ns-evcode-am_wmt_event_data
struct AM_WMT_EVENT_DATA
{
    HRESULT hrStatus;
    void*   pData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ns-wmsdkidl-wm_stream_priority_record
struct WM_STREAM_PRIORITY_RECORD
{
align (2):
    ushort wStreamNumber;
    BOOL   fMandatory;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ns-wmsdkidl-wm_writer_statistics
struct WM_WRITER_STATISTICS
{
    ulong qwSampleCount;
    ulong qwByteCount;
    ulong qwDroppedSampleCount;
    ulong qwDroppedByteCount;
    uint  dwCurrentBitrate;
    uint  dwAverageBitrate;
    uint  dwExpectedBitrate;
    uint  dwCurrentSampleRate;
    uint  dwAverageSampleRate;
    uint  dwExpectedSampleRate;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ns-wmsdkidl-wm_writer_statistics_ex
struct WM_WRITER_STATISTICS_EX
{
    uint dwBitratePlusOverhead;
    uint dwCurrentSampleDropRateInQueue;
    uint dwCurrentSampleDropRateInCodec;
    uint dwCurrentSampleDropRateInMultiplexer;
    uint dwTotalSampleDropsInQueue;
    uint dwTotalSampleDropsInCodec;
    uint dwTotalSampleDropsInMultiplexer;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ns-wmsdkidl-wm_reader_statistics
struct WM_READER_STATISTICS
{
    uint   cbSize;
    uint   dwBandwidth;
    uint   cPacketsReceived;
    uint   cPacketsRecovered;
    uint   cPacketsLost;
    ushort wQuality;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ns-wmsdkidl-wm_reader_clientinfo
struct WM_READER_CLIENTINFO
{
    uint    cbSize;
    PWSTR   wszLang;
    PWSTR   wszBrowserUserAgent;
    PWSTR   wszBrowserWebPage;
    ulong   qwReserved;
    LPARAM* pReserved;
    PWSTR   wszHostExe;
    ulong   qwHostVersion;
    PWSTR   wszPlayerUserAgent;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ns-wmsdkidl-wm_client_properties
struct WM_CLIENT_PROPERTIES
{
    uint dwIPAddress;
    uint dwPort;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ns-wmsdkidl-wm_client_properties_ex
struct WM_CLIENT_PROPERTIES_EX
{
    uint         cbSize;
    const(PWSTR) pwszIPAddress;
    const(PWSTR) pwszPort;
    const(PWSTR) pwszDNSName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ns-wmsdkidl-wm_port_number_range
struct WM_PORT_NUMBER_RANGE
{
    ushort wPortBegin;
    ushort wPortEnd;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ns-wmsdkidl-wmt_buffer_segment
struct WMT_BUFFER_SEGMENT
{
    INSSBuffer pBuffer;
    uint       cbOffset;
    uint       cbLength;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ns-wmsdkidl-wmt_payload_fragment
struct WMT_PAYLOAD_FRAGMENT
{
    uint               dwPayloadIndex;
    WMT_BUFFER_SEGMENT segmentData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ns-wmsdkidl-wmt_filesink_data_unit
struct WMT_FILESINK_DATA_UNIT
{
    WMT_BUFFER_SEGMENT  packetHeaderBuffer;
    uint                cPayloads;
    WMT_BUFFER_SEGMENT* pPayloadHeaderBuffers;
    uint                cPayloadDataFragments;
    WMT_PAYLOAD_FRAGMENT* pPayloadDataFragments;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ns-wmsdkidl-wmt_webstream_format
struct WMT_WEBSTREAM_FORMAT
{
    ushort cbSize;
    ushort cbSampleHeaderFixedData;
    ushort wVersion;
    ushort wReserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ns-wmsdkidl-wmt_webstream_sample_header
struct WMT_WEBSTREAM_SAMPLE_HEADER
{
    ushort   cbLength;
    ushort   wPart;
    ushort   cTotalParts;
    ushort   wSampleType;
    wchar[1] wszURL; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ns-wmsdkidl-wm_address_accessentry
struct WM_ADDRESS_ACCESSENTRY
{
    uint dwIPAddress;
    uint dwMask;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ns-wmsdkidl-wm_picture
struct WM_PICTURE
{
align (1):
    PWSTR  pwszMIMEType;
    ubyte  bPictureType;
    PWSTR  pwszDescription;
    uint   dwDataLen;
    ubyte* pbData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ns-wmsdkidl-wm_synchronised_lyrics
struct WM_SYNCHRONISED_LYRICS
{
align (1):
    ubyte  bTimeStampFormat;
    ubyte  bContentType;
    PWSTR  pwszContentDescriptor;
    uint   dwLyricsLen;
    ubyte* pbLyrics;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ns-wmsdkidl-wm_user_web_url
struct WM_USER_WEB_URL
{
align (1):
    PWSTR pwszDescription;
    PWSTR pwszURL;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ns-wmsdkidl-wm_user_text
struct WM_USER_TEXT
{
align (1):
    PWSTR pwszDescription;
    PWSTR pwszText;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ns-wmsdkidl-wm_leaky_bucket_pair
struct WM_LEAKY_BUCKET_PAIR
{
align (1):
    uint dwBitrate;
    uint msBufferWindow;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ns-wmsdkidl-wm_stream_type_info
struct WM_STREAM_TYPE_INFO
{
align (1):
    GUID guidMajorType;
    uint cbFormat;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ns-wmsdkidl-wmt_watermark_entry
struct WMT_WATERMARK_ENTRY
{
    WMT_WATERMARK_ENTRY_TYPE wmetType;
    GUID  clsid;
    uint  cbDisplayName;
    PWSTR pwszDisplayName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ns-wmsdkidl-wmt_videoimage_sample
struct WMT_VIDEOIMAGE_SAMPLE
{
    uint dwMagic;
    uint cbStruct;
    uint dwControlFlags;
    uint dwInputFlagsCur;
    int  lCurMotionXtoX;
    int  lCurMotionYtoX;
    int  lCurMotionXoffset;
    int  lCurMotionXtoY;
    int  lCurMotionYtoY;
    int  lCurMotionYoffset;
    int  lCurBlendCoef1;
    int  lCurBlendCoef2;
    uint dwInputFlagsPrev;
    int  lPrevMotionXtoX;
    int  lPrevMotionYtoX;
    int  lPrevMotionXoffset;
    int  lPrevMotionXtoY;
    int  lPrevMotionYtoY;
    int  lPrevMotionYoffset;
    int  lPrevBlendCoef1;
    int  lPrevBlendCoef2;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ns-wmsdkidl-wmt_videoimage_sample2
struct WMT_VIDEOIMAGE_SAMPLE2
{
    uint  dwMagic;
    uint  dwStructSize;
    uint  dwControlFlags;
    uint  dwViewportWidth;
    uint  dwViewportHeight;
    uint  dwCurrImageWidth;
    uint  dwCurrImageHeight;
    float fCurrRegionX0;
    float fCurrRegionY0;
    float fCurrRegionWidth;
    float fCurrRegionHeight;
    float fCurrBlendCoef;
    uint  dwPrevImageWidth;
    uint  dwPrevImageHeight;
    float fPrevRegionX0;
    float fPrevRegionY0;
    float fPrevRegionWidth;
    float fPrevRegionHeight;
    float fPrevBlendCoef;
    uint  dwEffectType;
    uint  dwNumEffectParas;
    float fEffectPara0;
    float fEffectPara1;
    float fEffectPara2;
    float fEffectPara3;
    float fEffectPara4;
    BOOL  bKeepPrevImage;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ns-wmsdkidl-wm_media_type
struct WM_MEDIA_TYPE
{
    GUID     majortype;
    GUID     subtype;
    BOOL     bFixedSizeSamples;
    BOOL     bTemporalCompression;
    uint     lSampleSize;
    GUID     formattype;
    IUnknown pUnk;
    uint     cbFormat;
    ubyte*   pbFormat;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ns-wmsdkidl-wmvideoinfoheader
struct WMVIDEOINFOHEADER
{
    RECT             rcSource;
    RECT             rcTarget;
    uint             dwBitRate;
    uint             dwBitErrorRate;
    long             AvgTimePerFrame;
    BITMAPINFOHEADER bmiHeader;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ns-wmsdkidl-wmvideoinfoheader2
struct WMVIDEOINFOHEADER2
{
    RECT             rcSource;
    RECT             rcTarget;
    uint             dwBitRate;
    uint             dwBitErrorRate;
    long             AvgTimePerFrame;
    uint             dwInterlaceFlags;
    uint             dwCopyProtectFlags;
    uint             dwPictAspectRatioX;
    uint             dwPictAspectRatioY;
    uint             dwReserved1;
    uint             dwReserved2;
    BITMAPINFOHEADER bmiHeader;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ns-wmsdkidl-wmmpeg2videoinfo
struct WMMPEG2VIDEOINFO
{
    WMVIDEOINFOHEADER2 hdr;
    uint               dwStartTimeCode;
    uint               cbSequenceHeader;
    uint               dwProfile;
    uint               dwLevel;
    uint               dwFlags;
    uint[1]            dwSequenceHeader; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ns-wmsdkidl-wmscriptformat
struct WMSCRIPTFORMAT
{
    GUID scriptType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ns-wmsdkidl-wmt_colorspaceinfo_extension_data
struct WMT_COLORSPACEINFO_EXTENSION_DATA
{
    ubyte ucColorPrimaries;
    ubyte ucColorTransferChar;
    ubyte ucColorMatrixCoef;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ns-wmsdkidl-wmt_timecode_extension_data
struct WMT_TIMECODE_EXTENSION_DATA
{
align (2):
    ushort wRange;
    uint   dwTimecode;
    uint   dwUserbits;
    uint   dwAmFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ns-wmsdkidl-drm_val16
struct DRM_VAL16
{
    ubyte[16] val;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ns-wmsdkidl-wmdrm_import_init_struct
struct WMDRM_IMPORT_INIT_STRUCT
{
    uint   dwVersion;
    uint   cbEncryptedSessionKeyMessage;
    ubyte* pbEncryptedSessionKeyMessage;
    uint   cbEncryptedKeyMessage;
    ubyte* pbEncryptedKeyMessage;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ns-wmsdkidl-drm_minimum_output_protection_levels
struct DRM_MINIMUM_OUTPUT_PROTECTION_LEVELS
{
    ushort wCompressedDigitalVideo;
    ushort wUncompressedDigitalVideo;
    ushort wAnalogVideo;
    ushort wCompressedDigitalAudio;
    ushort wUncompressedDigitalAudio;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ns-wmsdkidl-drm_opl_output_ids
struct DRM_OPL_OUTPUT_IDS
{
    ushort cIds;
    GUID*  rgIds;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ns-wmsdkidl-drm_output_protection
struct DRM_OUTPUT_PROTECTION
{
    GUID  guidId;
    ubyte bConfigData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ns-wmsdkidl-drm_video_output_protection_ids
struct DRM_VIDEO_OUTPUT_PROTECTION_IDS
{
    ushort cEntries;
    DRM_OUTPUT_PROTECTION* rgVop;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ns-wmsdkidl-drm_play_opl
struct DRM_PLAY_OPL
{
    DRM_MINIMUM_OUTPUT_PROTECTION_LEVELS minOPL;
    DRM_OPL_OUTPUT_IDS oplIdReserved;
    DRM_VIDEO_OUTPUT_PROTECTION_IDS vopi;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/ns-wmsdkidl-drm_copy_opl
struct DRM_COPY_OPL
{
    ushort             wMinimumCopyLevel;
    DRM_OPL_OUTPUT_IDS oplIdIncludes;
    DRM_OPL_OUTPUT_IDS oplIdExcludes;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WMVCore.dll")
HRESULT WMIsContentProtected(const(PWSTR) pwszFileName, BOOL* pfIsProtected);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WMVCore.dll")
HRESULT WMCreateWriter(IUnknown pUnkCert, IWMWriter* ppWriter);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WMVCore.dll")
HRESULT WMCreateReader(IUnknown pUnkCert, uint dwRights, IWMReader* ppReader);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WMVCore.dll")
HRESULT WMCreateSyncReader(IUnknown pUnkCert, uint dwRights, IWMSyncReader* ppSyncReader);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WMVCore.dll")
HRESULT WMCreateEditor(IWMMetadataEditor* ppEditor);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WMVCore.dll")
HRESULT WMCreateIndexer(IWMIndexer* ppIndexer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WMVCore.dll")
HRESULT WMCreateBackupRestorer(IUnknown pCallback, IWMLicenseBackup* ppBackup);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WMVCore.dll")
HRESULT WMCreateProfileManager(IWMProfileManager* ppProfileManager);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WMVCore.dll")
HRESULT WMCreateWriterFileSink(IWMWriterFileSink* ppSink);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WMVCore.dll")
HRESULT WMCreateWriterNetworkSink(IWMWriterNetworkSink* ppSink);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WMVCore.dll")
HRESULT WMCreateWriterPushSink(IWMWriterPushSink* ppSink);


// Interfaces

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsbuffer/nn-wmsbuffer-inssbuffer
@GUID("e1cd3524-03d7-11d2-9eed-006097d2d7cf")
interface INSSBuffer : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsbuffer/nf-wmsbuffer-inssbuffer-getlength
    HRESULT GetLength(uint* pdwLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsbuffer/nf-wmsbuffer-inssbuffer-setlength
    HRESULT SetLength(uint dwLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsbuffer/nf-wmsbuffer-inssbuffer-getmaxlength
    HRESULT GetMaxLength(uint* pdwLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsbuffer/nf-wmsbuffer-inssbuffer-getbuffer
    HRESULT GetBuffer(ubyte** ppdwBuffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsbuffer/nf-wmsbuffer-inssbuffer-getbufferandlength
    HRESULT GetBufferAndLength(ubyte** ppdwBuffer, uint* pdwLength);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsbuffer/nn-wmsbuffer-inssbuffer2
@GUID("4f528693-1035-43fe-b428-757561ad3a68")
interface INSSBuffer2 : INSSBuffer
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsbuffer/nn-wmsbuffer-inssbuffer2
    HRESULT GetSampleProperties(uint cbProperties, ubyte* pbProperties);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsbuffer/nn-wmsbuffer-inssbuffer2
    HRESULT SetSampleProperties(uint cbProperties, ubyte* pbProperties);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsbuffer/nn-wmsbuffer-inssbuffer3
@GUID("c87ceaaf-75be-4bc4-84eb-ac2798507672")
interface INSSBuffer3 : INSSBuffer2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsbuffer/nf-wmsbuffer-inssbuffer3-setproperty
    HRESULT SetProperty(GUID guidBufferProperty, void* pvBufferProperty, uint dwBufferPropertySize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsbuffer/nf-wmsbuffer-inssbuffer3-getproperty
    HRESULT GetProperty(GUID guidBufferProperty, void* pvBufferProperty, uint* pdwBufferPropertySize);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsbuffer/nn-wmsbuffer-inssbuffer4
@GUID("b6b8fd5a-32e2-49d4-a910-c26cc85465ed")
interface INSSBuffer4 : INSSBuffer3
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsbuffer/nf-wmsbuffer-inssbuffer4-getpropertycount
    HRESULT GetPropertyCount(uint* pcBufferProperties);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsbuffer/nf-wmsbuffer-inssbuffer4-getpropertybyindex
    HRESULT GetPropertyByIndex(uint dwBufferPropertyIndex, GUID* pguidBufferProperty, void* pvBufferProperty, 
                               uint* pdwBufferPropertySize);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsbuffer/nn-wmsbuffer-iwmsbufferallocator
@GUID("61103ca4-2033-11d2-9ef1-006097d2d7cf")
interface IWMSBufferAllocator : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsbuffer/nf-wmsbuffer-iwmsbufferallocator-allocatebuffer
    HRESULT AllocateBuffer(uint dwMaxBufferSize, INSSBuffer* ppBuffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsbuffer/nf-wmsbuffer-iwmsbufferallocator-allocatepagesizebuffer
    HRESULT AllocatePageSizeBuffer(uint dwMaxBufferSize, INSSBuffer* ppBuffer);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmmediaprops
@GUID("96406bce-2b2b-11d3-b36b-00c04f6108ff")
interface IWMMediaProps : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmmediaprops-gettype
    HRESULT GetType(GUID* pguidType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmmediaprops-getmediatype
    HRESULT GetMediaType(WM_MEDIA_TYPE* pType, uint* pcbType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmmediaprops-setmediatype
    HRESULT SetMediaType(WM_MEDIA_TYPE* pType);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmvideomediaprops
@GUID("96406bcf-2b2b-11d3-b36b-00c04f6108ff")
interface IWMVideoMediaProps : IWMMediaProps
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmvideomediaprops-getmaxkeyframespacing
    HRESULT GetMaxKeyFrameSpacing(long* pllTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmvideomediaprops-setmaxkeyframespacing
    HRESULT SetMaxKeyFrameSpacing(long llTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmvideomediaprops-getquality
    HRESULT GetQuality(uint* pdwQuality);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmvideomediaprops-setquality
    HRESULT SetQuality(uint dwQuality);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmwriter
@GUID("96406bd4-2b2b-11d3-b36b-00c04f6108ff")
interface IWMWriter : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriter-setprofilebyid
    HRESULT SetProfileByID(const(GUID)* guidProfile);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriter-setprofile
    HRESULT SetProfile(IWMProfile pProfile);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriter-setoutputfilename
    HRESULT SetOutputFilename(const(PWSTR) pwszFilename);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriter-getinputcount
    HRESULT GetInputCount(uint* pcInputs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriter-getinputprops
    HRESULT GetInputProps(uint dwInputNum, IWMInputMediaProps* ppInput);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriter-setinputprops
    HRESULT SetInputProps(uint dwInputNum, IWMInputMediaProps pInput);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriter-getinputformatcount
    HRESULT GetInputFormatCount(uint dwInputNumber, uint* pcFormats);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriter-getinputformat
    HRESULT GetInputFormat(uint dwInputNumber, uint dwFormatNumber, IWMInputMediaProps* pProps);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriter-beginwriting
    HRESULT BeginWriting();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriter-endwriting
    HRESULT EndWriting();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriter-allocatesample
    HRESULT AllocateSample(uint dwSampleSize, INSSBuffer* ppSample);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriter-writesample
    HRESULT WriteSample(uint dwInputNum, ulong cnsSampleTime, uint dwFlags, INSSBuffer pSample);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriter-flush
    HRESULT Flush();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmdrmwriter
@GUID("d6ea5dd0-12a0-43f4-90ab-a3fd451e6a07")
interface IWMDRMWriter : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmdrmwriter-generatekeyseed
    HRESULT GenerateKeySeed(PWSTR pwszKeySeed, uint* pcwchLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmdrmwriter-generatekeyid
    HRESULT GenerateKeyID(PWSTR pwszKeyID, uint* pcwchLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmdrmwriter-generatesigningkeypair
    HRESULT GenerateSigningKeyPair(PWSTR pwszPrivKey, uint* pcwchPrivKeyLength, PWSTR pwszPubKey, 
                                   uint* pcwchPubKeyLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmdrmwriter-setdrmattribute
    HRESULT SetDRMAttribute(ushort wStreamNum, const(PWSTR) pszName, WMT_ATTR_DATATYPE Type, const(ubyte)* pValue, 
                            ushort cbLength);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmdrmwriter2
@GUID("38ee7a94-40e2-4e10-aa3f-33fd3210ed5b")
interface IWMDRMWriter2 : IWMDRMWriter
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmdrmwriter2-setwmdrmnetencryption
    HRESULT SetWMDRMNetEncryption(BOOL fSamplesEncrypted, ubyte* pbKeyID, uint cbKeyID);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmdrmwriter3
@GUID("a7184082-a4aa-4dde-ac9c-e75dbd1117ce")
interface IWMDRMWriter3 : IWMDRMWriter2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmdrmwriter3-setprotectstreamsamples
    HRESULT SetProtectStreamSamples(WMDRM_IMPORT_INIT_STRUCT* pImportInitStruct);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwminputmediaprops
@GUID("96406bd5-2b2b-11d3-b36b-00c04f6108ff")
interface IWMInputMediaProps : IWMMediaProps
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwminputmediaprops-getconnectionname
    HRESULT GetConnectionName(PWSTR pwszName, ushort* pcchName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwminputmediaprops-getgroupname
    HRESULT GetGroupName(PWSTR pwszName, ushort* pcchName);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmpropertyvault
@GUID("72995a79-5090-42a4-9c8c-d9d0b6d34be5")
interface IWMPropertyVault : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmpropertyvault-getpropertycount
    HRESULT GetPropertyCount(uint* pdwCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmpropertyvault-getpropertybyname
    HRESULT GetPropertyByName(const(PWSTR) pszName, WMT_ATTR_DATATYPE* pType, ubyte* pValue, uint* pdwSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmpropertyvault-setproperty
    HRESULT SetProperty(const(PWSTR) pszName, WMT_ATTR_DATATYPE pType, ubyte* pValue, uint dwSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmpropertyvault-getpropertybyindex
    HRESULT GetPropertyByIndex(uint dwIndex, PWSTR pszName, uint* pdwNameLen, WMT_ATTR_DATATYPE* pType, 
                               ubyte* pValue, uint* pdwSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmpropertyvault-copypropertiesfrom
    HRESULT CopyPropertiesFrom(IWMPropertyVault pIWMPropertyVault);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmpropertyvault-clear
    HRESULT Clear();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmistreamprops
@GUID("6816dad3-2b4b-4c8e-8149-874c3483a753")
interface IWMIStreamProps : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmistreamprops-getproperty
    HRESULT GetProperty(const(PWSTR) pszName, WMT_ATTR_DATATYPE* pType, ubyte* pValue, uint* pdwSize);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmreader
@GUID("96406bd6-2b2b-11d3-b36b-00c04f6108ff")
interface IWMReader : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreader-open
    HRESULT Open(const(PWSTR) pwszURL, IWMReaderCallback pCallback, void* pvContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreader-close
    HRESULT Close();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreader-getoutputcount
    HRESULT GetOutputCount(uint* pcOutputs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreader-getoutputprops
    HRESULT GetOutputProps(uint dwOutputNum, IWMOutputMediaProps* ppOutput);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreader-setoutputprops
    HRESULT SetOutputProps(uint dwOutputNum, IWMOutputMediaProps pOutput);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreader-getoutputformatcount
    HRESULT GetOutputFormatCount(uint dwOutputNumber, uint* pcFormats);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreader-getoutputformat
    HRESULT GetOutputFormat(uint dwOutputNumber, uint dwFormatNumber, IWMOutputMediaProps* ppProps);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreader-start
    HRESULT Start(ulong cnsStart, ulong cnsDuration, float fRate, void* pvContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreader-stop
    HRESULT Stop();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreader-pause
    HRESULT Pause();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreader-resume
    HRESULT Resume();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmsyncreader
@GUID("9397f121-7705-4dc9-b049-98b698188414")
interface IWMSyncReader : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmsyncreader-open
    HRESULT Open(const(PWSTR) pwszFilename);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmsyncreader-close
    HRESULT Close();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmsyncreader-setrange
    HRESULT SetRange(ulong cnsStartTime, long cnsDuration);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmsyncreader-setrangebyframe
    HRESULT SetRangeByFrame(ushort wStreamNum, ulong qwFrameNumber, long cFramesToRead);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmsyncreader-getnextsample
    HRESULT GetNextSample(ushort wStreamNum, INSSBuffer* ppSample, ulong* pcnsSampleTime, ulong* pcnsDuration, 
                          uint* pdwFlags, uint* pdwOutputNum, ushort* pwStreamNum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmsyncreader-setstreamsselected
    HRESULT SetStreamsSelected(ushort cStreamCount, ushort* pwStreamNumbers, WMT_STREAM_SELECTION* pSelections);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmsyncreader-getstreamselected
    HRESULT GetStreamSelected(ushort wStreamNum, WMT_STREAM_SELECTION* pSelection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmsyncreader-setreadstreamsamples
    HRESULT SetReadStreamSamples(ushort wStreamNum, BOOL fCompressed);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmsyncreader-getreadstreamsamples
    HRESULT GetReadStreamSamples(ushort wStreamNum, BOOL* pfCompressed);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmsyncreader-getoutputsetting
    HRESULT GetOutputSetting(uint dwOutputNum, const(PWSTR) pszName, WMT_ATTR_DATATYPE* pType, ubyte* pValue, 
                             ushort* pcbLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmsyncreader-setoutputsetting
    HRESULT SetOutputSetting(uint dwOutputNum, const(PWSTR) pszName, WMT_ATTR_DATATYPE Type, const(ubyte)* pValue, 
                             ushort cbLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmsyncreader-getoutputcount
    HRESULT GetOutputCount(uint* pcOutputs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmsyncreader-getoutputprops
    HRESULT GetOutputProps(uint dwOutputNum, IWMOutputMediaProps* ppOutput);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmsyncreader-setoutputprops
    HRESULT SetOutputProps(uint dwOutputNum, IWMOutputMediaProps pOutput);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmsyncreader-getoutputformatcount
    HRESULT GetOutputFormatCount(uint dwOutputNum, uint* pcFormats);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmsyncreader-getoutputformat
    HRESULT GetOutputFormat(uint dwOutputNum, uint dwFormatNum, IWMOutputMediaProps* ppProps);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmsyncreader-getoutputnumberforstream
    HRESULT GetOutputNumberForStream(ushort wStreamNum, uint* pdwOutputNum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmsyncreader-getstreamnumberforoutput
    HRESULT GetStreamNumberForOutput(uint dwOutputNum, ushort* pwStreamNum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmsyncreader-getmaxoutputsamplesize
    HRESULT GetMaxOutputSampleSize(uint dwOutput, uint* pcbMax);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmsyncreader-getmaxstreamsamplesize
    HRESULT GetMaxStreamSampleSize(ushort wStream, uint* pcbMax);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmsyncreader-openstream
    HRESULT OpenStream(IStream pStream);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmsyncreader2
@GUID("faed3d21-1b6b-4af7-8cb6-3e189bbc187b")
interface IWMSyncReader2 : IWMSyncReader
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmsyncreader2-setrangebytimecode
    HRESULT SetRangeByTimecode(ushort wStreamNum, WMT_TIMECODE_EXTENSION_DATA* pStart, 
                               WMT_TIMECODE_EXTENSION_DATA* pEnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmsyncreader2-setrangebyframeex
    HRESULT SetRangeByFrameEx(ushort wStreamNum, ulong qwFrameNumber, long cFramesToRead, ulong* pcnsStartTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmsyncreader2-setallocateforoutput
    HRESULT SetAllocateForOutput(uint dwOutputNum, IWMReaderAllocatorEx pAllocator);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmsyncreader2-getallocateforoutput
    HRESULT GetAllocateForOutput(uint dwOutputNum, IWMReaderAllocatorEx* ppAllocator);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmsyncreader2-setallocateforstream
    HRESULT SetAllocateForStream(ushort wStreamNum, IWMReaderAllocatorEx pAllocator);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmsyncreader2-getallocateforstream
    HRESULT GetAllocateForStream(ushort dwSreamNum, IWMReaderAllocatorEx* ppAllocator);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmoutputmediaprops
@GUID("96406bd7-2b2b-11d3-b36b-00c04f6108ff")
interface IWMOutputMediaProps : IWMMediaProps
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmoutputmediaprops-getstreamgroupname
    HRESULT GetStreamGroupName(PWSTR pwszName, ushort* pcchName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmoutputmediaprops-getconnectionname
    HRESULT GetConnectionName(PWSTR pwszName, ushort* pcchName);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmstatuscallback
@GUID("6d7cdc70-9888-11d3-8edc-00c04f6109cf")
interface IWMStatusCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmstatuscallback-onstatus
    HRESULT OnStatus(WMT_STATUS Status, HRESULT hr, WMT_ATTR_DATATYPE dwType, ubyte* pValue, void* pvContext);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmreadercallback
@GUID("96406bd8-2b2b-11d3-b36b-00c04f6108ff")
interface IWMReaderCallback : IWMStatusCallback
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadercallback-onsample
    HRESULT OnSample(uint dwOutputNum, ulong cnsSampleTime, ulong cnsSampleDuration, uint dwFlags, 
                     INSSBuffer pSample, void* pvContext);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmcredentialcallback
@GUID("342e0eb7-e651-450c-975b-2ace2c90c48e")
interface IWMCredentialCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmcredentialcallback-acquirecredentials
    HRESULT AcquireCredentials(PWSTR pwszRealm, PWSTR pwszSite, PWSTR pwszUser, uint cchUser, PWSTR pwszPassword, 
                               uint cchPassword, HRESULT hrStatus, uint* pdwFlags);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmmetadataeditor
@GUID("96406bd9-2b2b-11d3-b36b-00c04f6108ff")
interface IWMMetadataEditor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmmetadataeditor-open
    HRESULT Open(const(PWSTR) pwszFilename);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmmetadataeditor-close
    HRESULT Close();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmmetadataeditor-flush
    HRESULT Flush();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmmetadataeditor2
@GUID("203cffe3-2e18-4fdf-b59d-6e71530534cf")
interface IWMMetadataEditor2 : IWMMetadataEditor
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmmetadataeditor2-openex
    HRESULT OpenEx(const(PWSTR) pwszFilename, uint dwDesiredAccess, uint dwShareMode);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmdrmeditor
@GUID("ff130ebc-a6c3-42a6-b401-c3382c3e08b3")
interface IWMDRMEditor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmdrmeditor-getdrmproperty
    HRESULT GetDRMProperty(const(PWSTR) pwstrName, WMT_ATTR_DATATYPE* pdwType, ubyte* pValue, ushort* pcbLength);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmheaderinfo
@GUID("96406bda-2b2b-11d3-b36b-00c04f6108ff")
interface IWMHeaderInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmheaderinfo-getattributecount
    HRESULT GetAttributeCount(ushort wStreamNum, ushort* pcAttributes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmheaderinfo-getattributebyindex
    HRESULT GetAttributeByIndex(ushort wIndex, ushort* pwStreamNum, PWSTR pwszName, ushort* pcchNameLen, 
                                WMT_ATTR_DATATYPE* pType, ubyte* pValue, ushort* pcbLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmheaderinfo-getattributebyname
    HRESULT GetAttributeByName(ushort* pwStreamNum, const(PWSTR) pszName, WMT_ATTR_DATATYPE* pType, ubyte* pValue, 
                               ushort* pcbLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmheaderinfo-setattribute
    HRESULT SetAttribute(ushort wStreamNum, const(PWSTR) pszName, WMT_ATTR_DATATYPE Type, const(ubyte)* pValue, 
                         ushort cbLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmheaderinfo-getmarkercount
    HRESULT GetMarkerCount(ushort* pcMarkers);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmheaderinfo-getmarker
    HRESULT GetMarker(ushort wIndex, PWSTR pwszMarkerName, ushort* pcchMarkerNameLen, ulong* pcnsMarkerTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmheaderinfo-addmarker
    HRESULT AddMarker(PWSTR pwszMarkerName, ulong cnsMarkerTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmheaderinfo-removemarker
    HRESULT RemoveMarker(ushort wIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmheaderinfo-getscriptcount
    HRESULT GetScriptCount(ushort* pcScripts);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmheaderinfo-getscript
    HRESULT GetScript(ushort wIndex, PWSTR pwszType, ushort* pcchTypeLen, PWSTR pwszCommand, 
                      ushort* pcchCommandLen, ulong* pcnsScriptTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmheaderinfo-addscript
    HRESULT AddScript(PWSTR pwszType, PWSTR pwszCommand, ulong cnsScriptTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmheaderinfo-removescript
    HRESULT RemoveScript(ushort wIndex);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmheaderinfo2
@GUID("15cf9781-454e-482e-b393-85fae487a810")
interface IWMHeaderInfo2 : IWMHeaderInfo
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmheaderinfo2-getcodecinfocount
    HRESULT GetCodecInfoCount(uint* pcCodecInfos);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmheaderinfo2-getcodecinfo
    HRESULT GetCodecInfo(uint wIndex, ushort* pcchName, PWSTR pwszName, ushort* pcchDescription, 
                         PWSTR pwszDescription, WMT_CODEC_INFO_TYPE* pCodecType, ushort* pcbCodecInfo, 
                         ubyte* pbCodecInfo);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmheaderinfo3
@GUID("15cc68e3-27cc-4ecd-b222-3f5d02d80bd5")
interface IWMHeaderInfo3 : IWMHeaderInfo2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmheaderinfo3-getattributecountex
    HRESULT GetAttributeCountEx(ushort wStreamNum, ushort* pcAttributes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmheaderinfo3-getattributeindices
    HRESULT GetAttributeIndices(ushort wStreamNum, const(PWSTR) pwszName, ushort* pwLangIndex, ushort* pwIndices, 
                                ushort* pwCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmheaderinfo3-getattributebyindexex
    HRESULT GetAttributeByIndexEx(ushort wStreamNum, ushort wIndex, PWSTR pwszName, ushort* pwNameLen, 
                                  WMT_ATTR_DATATYPE* pType, ushort* pwLangIndex, ubyte* pValue, uint* pdwDataLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmheaderinfo3-modifyattribute
    HRESULT ModifyAttribute(ushort wStreamNum, ushort wIndex, WMT_ATTR_DATATYPE Type, ushort wLangIndex, 
                            const(ubyte)* pValue, uint dwLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmheaderinfo3-addattribute
    HRESULT AddAttribute(ushort wStreamNum, const(PWSTR) pszName, ushort* pwIndex, WMT_ATTR_DATATYPE Type, 
                         ushort wLangIndex, const(ubyte)* pValue, uint dwLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmheaderinfo3-deleteattribute
    HRESULT DeleteAttribute(ushort wStreamNum, ushort wIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmheaderinfo3-addcodecinfo
    HRESULT AddCodecInfo(PWSTR pwszName, PWSTR pwszDescription, WMT_CODEC_INFO_TYPE codecType, ushort cbCodecInfo, 
                         ubyte* pbCodecInfo);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmprofilemanager
@GUID("d16679f2-6ca0-472d-8d31-2f5d55aee155")
interface IWMProfileManager : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmprofilemanager-createemptyprofile
    HRESULT CreateEmptyProfile(WMT_VERSION dwVersion, IWMProfile* ppProfile);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmprofilemanager-loadprofilebyid
    HRESULT LoadProfileByID(const(GUID)* guidProfile, IWMProfile* ppProfile);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmprofilemanager-loadprofilebydata
    HRESULT LoadProfileByData(const(PWSTR) pwszProfile, IWMProfile* ppProfile);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmprofilemanager-saveprofile
    HRESULT SaveProfile(IWMProfile pIWMProfile, PWSTR pwszProfile, uint* pdwLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmprofilemanager-getsystemprofilecount
    HRESULT GetSystemProfileCount(uint* pcProfiles);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmprofilemanager-loadsystemprofile
    HRESULT LoadSystemProfile(uint dwProfileIndex, IWMProfile* ppProfile);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmprofilemanager2
@GUID("7a924e51-73c1-494d-8019-23d37ed9b89a")
interface IWMProfileManager2 : IWMProfileManager
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmprofilemanager2-getsystemprofileversion
    HRESULT GetSystemProfileVersion(WMT_VERSION* pdwVersion);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmprofilemanager2-setsystemprofileversion
    HRESULT SetSystemProfileVersion(WMT_VERSION dwVersion);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmprofilemanagerlanguage
@GUID("ba4dcc78-7ee0-4ab8-b27a-dbce8bc51454")
interface IWMProfileManagerLanguage : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmprofilemanagerlanguage-getuserlanguageid
    HRESULT GetUserLanguageID(ushort* wLangID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmprofilemanagerlanguage-setuserlanguageid
    HRESULT SetUserLanguageID(ushort wLangID);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmprofile
@GUID("96406bdb-2b2b-11d3-b36b-00c04f6108ff")
interface IWMProfile : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmprofile-getversion
    HRESULT GetVersion(WMT_VERSION* pdwVersion);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmprofile-getname
    HRESULT GetName(PWSTR pwszName, uint* pcchName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmprofile-setname
    HRESULT SetName(const(PWSTR) pwszName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmprofile-getdescription
    HRESULT GetDescription(PWSTR pwszDescription, uint* pcchDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmprofile-setdescription
    HRESULT SetDescription(const(PWSTR) pwszDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmprofile-getstreamcount
    HRESULT GetStreamCount(uint* pcStreams);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmprofile-getstream
    HRESULT GetStream(uint dwStreamIndex, IWMStreamConfig* ppConfig);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmprofile-getstreambynumber
    HRESULT GetStreamByNumber(ushort wStreamNum, IWMStreamConfig* ppConfig);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmprofile-removestream
    HRESULT RemoveStream(IWMStreamConfig pConfig);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmprofile-removestreambynumber
    HRESULT RemoveStreamByNumber(ushort wStreamNum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmprofile-addstream
    HRESULT AddStream(IWMStreamConfig pConfig);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmprofile-reconfigstream
    HRESULT ReconfigStream(IWMStreamConfig pConfig);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmprofile-createnewstream
    HRESULT CreateNewStream(const(GUID)* guidStreamType, IWMStreamConfig* ppConfig);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmprofile-getmutualexclusioncount
    HRESULT GetMutualExclusionCount(uint* pcME);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmprofile-getmutualexclusion
    HRESULT GetMutualExclusion(uint dwMEIndex, IWMMutualExclusion* ppME);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmprofile-removemutualexclusion
    HRESULT RemoveMutualExclusion(IWMMutualExclusion pME);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmprofile-addmutualexclusion
    HRESULT AddMutualExclusion(IWMMutualExclusion pME);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmprofile-createnewmutualexclusion
    HRESULT CreateNewMutualExclusion(IWMMutualExclusion* ppME);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmprofile2
@GUID("07e72d33-d94e-4be7-8843-60ae5ff7e5f5")
interface IWMProfile2 : IWMProfile
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmprofile2-getprofileid
    HRESULT GetProfileID(GUID* pguidID);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmprofile3
@GUID("00ef96cc-a461-4546-8bcd-c9a28f0e06f5")
interface IWMProfile3 : IWMProfile2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmprofile3-getstorageformat
    HRESULT GetStorageFormat(WMT_STORAGE_FORMAT* pnStorageFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmprofile3-setstorageformat
    HRESULT SetStorageFormat(WMT_STORAGE_FORMAT nStorageFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmprofile3-getbandwidthsharingcount
    HRESULT GetBandwidthSharingCount(uint* pcBS);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmprofile3-getbandwidthsharing
    HRESULT GetBandwidthSharing(uint dwBSIndex, IWMBandwidthSharing* ppBS);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmprofile3-removebandwidthsharing
    HRESULT RemoveBandwidthSharing(IWMBandwidthSharing pBS);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmprofile3-addbandwidthsharing
    HRESULT AddBandwidthSharing(IWMBandwidthSharing pBS);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmprofile3-createnewbandwidthsharing
    HRESULT CreateNewBandwidthSharing(IWMBandwidthSharing* ppBS);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmprofile3-getstreamprioritization
    HRESULT GetStreamPrioritization(IWMStreamPrioritization* ppSP);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmprofile3-setstreamprioritization
    HRESULT SetStreamPrioritization(IWMStreamPrioritization pSP);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmprofile3-removestreamprioritization
    HRESULT RemoveStreamPrioritization();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmprofile3-createnewstreamprioritization
    HRESULT CreateNewStreamPrioritization(IWMStreamPrioritization* ppSP);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmprofile3-getexpectedpacketcount
    HRESULT GetExpectedPacketCount(ulong msDuration, ulong* pcPackets);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmstreamconfig
@GUID("96406bdc-2b2b-11d3-b36b-00c04f6108ff")
interface IWMStreamConfig : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmstreamconfig-getstreamtype
    HRESULT GetStreamType(GUID* pguidStreamType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmstreamconfig-getstreamnumber
    HRESULT GetStreamNumber(ushort* pwStreamNum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmstreamconfig-setstreamnumber
    HRESULT SetStreamNumber(ushort wStreamNum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmstreamconfig-getstreamname
    HRESULT GetStreamName(PWSTR pwszStreamName, ushort* pcchStreamName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmstreamconfig-setstreamname
    HRESULT SetStreamName(PWSTR pwszStreamName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmstreamconfig-getconnectionname
    HRESULT GetConnectionName(PWSTR pwszInputName, ushort* pcchInputName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmstreamconfig-setconnectionname
    HRESULT SetConnectionName(PWSTR pwszInputName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmstreamconfig-getbitrate
    HRESULT GetBitrate(uint* pdwBitrate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmstreamconfig-setbitrate
    HRESULT SetBitrate(uint pdwBitrate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmstreamconfig-getbufferwindow
    HRESULT GetBufferWindow(uint* pmsBufferWindow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmstreamconfig-setbufferwindow
    HRESULT SetBufferWindow(uint msBufferWindow);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmstreamconfig2
@GUID("7688d8cb-fc0d-43bd-9459-5a8dec200cfa")
interface IWMStreamConfig2 : IWMStreamConfig
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmstreamconfig2-gettransporttype
    HRESULT GetTransportType(WMT_TRANSPORT_TYPE* pnTransportType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmstreamconfig2-settransporttype
    HRESULT SetTransportType(WMT_TRANSPORT_TYPE nTransportType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmstreamconfig2-adddataunitextension
    HRESULT AddDataUnitExtension(GUID guidExtensionSystemID, ushort cbExtensionDataSize, 
                                 ubyte* pbExtensionSystemInfo, uint cbExtensionSystemInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmstreamconfig2-getdataunitextensioncount
    HRESULT GetDataUnitExtensionCount(ushort* pcDataUnitExtensions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmstreamconfig2-getdataunitextension
    HRESULT GetDataUnitExtension(ushort wDataUnitExtensionNumber, GUID* pguidExtensionSystemID, 
                                 ushort* pcbExtensionDataSize, ubyte* pbExtensionSystemInfo, 
                                 uint* pcbExtensionSystemInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmstreamconfig2-removealldataunitextensions
    HRESULT RemoveAllDataUnitExtensions();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmstreamconfig3
@GUID("cb164104-3aa9-45a7-9ac9-4daee131d6e1")
interface IWMStreamConfig3 : IWMStreamConfig2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmstreamconfig3-getlanguage
    HRESULT GetLanguage(PWSTR pwszLanguageString, ushort* pcchLanguageStringLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmstreamconfig3-setlanguage
    HRESULT SetLanguage(PWSTR pwszLanguageString);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmpacketsize
@GUID("cdfb97ab-188f-40b3-b643-5b7903975c59")
interface IWMPacketSize : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmpacketsize-getmaxpacketsize
    HRESULT GetMaxPacketSize(uint* pdwMaxPacketSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmpacketsize-setmaxpacketsize
    HRESULT SetMaxPacketSize(uint dwMaxPacketSize);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmpacketsize2
@GUID("8bfc2b9e-b646-4233-a877-1c6a079669dc")
interface IWMPacketSize2 : IWMPacketSize
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmpacketsize2-getminpacketsize
    HRESULT GetMinPacketSize(uint* pdwMinPacketSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmpacketsize2-setminpacketsize
    HRESULT SetMinPacketSize(uint dwMinPacketSize);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmstreamlist
@GUID("96406bdd-2b2b-11d3-b36b-00c04f6108ff")
interface IWMStreamList : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmstreamlist-getstreams
    HRESULT GetStreams(ushort* pwStreamNumArray, ushort* pcStreams);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmstreamlist-addstream
    HRESULT AddStream(ushort wStreamNum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmstreamlist-removestream
    HRESULT RemoveStream(ushort wStreamNum);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmmutualexclusion
@GUID("96406bde-2b2b-11d3-b36b-00c04f6108ff")
interface IWMMutualExclusion : IWMStreamList
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmmutualexclusion-gettype
    HRESULT GetType(GUID* pguidType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmmutualexclusion-settype
    HRESULT SetType(const(GUID)* guidType);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmmutualexclusion2
@GUID("0302b57d-89d1-4ba2-85c9-166f2c53eb91")
interface IWMMutualExclusion2 : IWMMutualExclusion
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmmutualexclusion2-getname
    HRESULT GetName(PWSTR pwszName, ushort* pcchName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmmutualexclusion2-setname
    HRESULT SetName(PWSTR pwszName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmmutualexclusion2-getrecordcount
    HRESULT GetRecordCount(ushort* pwRecordCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmmutualexclusion2-addrecord
    HRESULT AddRecord();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmmutualexclusion2-removerecord
    HRESULT RemoveRecord(ushort wRecordNumber);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmmutualexclusion2-getrecordname
    HRESULT GetRecordName(ushort wRecordNumber, PWSTR pwszRecordName, ushort* pcchRecordName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmmutualexclusion2-setrecordname
    HRESULT SetRecordName(ushort wRecordNumber, PWSTR pwszRecordName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmmutualexclusion2-getstreamsforrecord
    HRESULT GetStreamsForRecord(ushort wRecordNumber, ushort* pwStreamNumArray, ushort* pcStreams);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmmutualexclusion2-addstreamforrecord
    HRESULT AddStreamForRecord(ushort wRecordNumber, ushort wStreamNumber);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmmutualexclusion2-removestreamforrecord
    HRESULT RemoveStreamForRecord(ushort wRecordNumber, ushort wStreamNumber);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmbandwidthsharing
@GUID("ad694af1-f8d9-42f8-bc47-70311b0c4f9e")
interface IWMBandwidthSharing : IWMStreamList
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmbandwidthsharing-gettype
    HRESULT GetType(GUID* pguidType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmbandwidthsharing-settype
    HRESULT SetType(const(GUID)* guidType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmbandwidthsharing-getbandwidth
    HRESULT GetBandwidth(uint* pdwBitrate, uint* pmsBufferWindow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmbandwidthsharing-setbandwidth
    HRESULT SetBandwidth(uint dwBitrate, uint msBufferWindow);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmstreamprioritization
@GUID("8c1c6090-f9a8-4748-8ec3-dd1108ba1e77")
interface IWMStreamPrioritization : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmstreamprioritization-getpriorityrecords
    HRESULT GetPriorityRecords(WM_STREAM_PRIORITY_RECORD* pRecordArray, ushort* pcRecords);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmstreamprioritization-setpriorityrecords
    HRESULT SetPriorityRecords(WM_STREAM_PRIORITY_RECORD* pRecordArray, ushort cRecords);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmwriteradvanced
@GUID("96406be3-2b2b-11d3-b36b-00c04f6108ff")
interface IWMWriterAdvanced : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriteradvanced-getsinkcount
    HRESULT GetSinkCount(uint* pcSinks);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriteradvanced-getsink
    HRESULT GetSink(uint dwSinkNum, IWMWriterSink* ppSink);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriteradvanced-addsink
    HRESULT AddSink(IWMWriterSink pSink);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriteradvanced-removesink
    HRESULT RemoveSink(IWMWriterSink pSink);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriteradvanced-writestreamsample
    HRESULT WriteStreamSample(ushort wStreamNum, ulong cnsSampleTime, uint msSampleSendTime, 
                              ulong cnsSampleDuration, uint dwFlags, INSSBuffer pSample);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriteradvanced-setlivesource
    HRESULT SetLiveSource(BOOL fIsLiveSource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriteradvanced-isrealtime
    HRESULT IsRealTime(BOOL* pfRealTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriteradvanced-getwritertime
    HRESULT GetWriterTime(ulong* pcnsCurrentTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriteradvanced-getstatistics
    HRESULT GetStatistics(ushort wStreamNum, WM_WRITER_STATISTICS* pStats);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriteradvanced-setsynctolerance
    HRESULT SetSyncTolerance(uint msWindow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriteradvanced-getsynctolerance
    HRESULT GetSyncTolerance(uint* pmsWindow);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmwriteradvanced2
@GUID("962dc1ec-c046-4db8-9cc7-26ceae500817")
interface IWMWriterAdvanced2 : IWMWriterAdvanced
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriteradvanced2-getinputsetting
    HRESULT GetInputSetting(uint dwInputNum, const(PWSTR) pszName, WMT_ATTR_DATATYPE* pType, ubyte* pValue, 
                            ushort* pcbLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriteradvanced2-setinputsetting
    HRESULT SetInputSetting(uint dwInputNum, const(PWSTR) pszName, WMT_ATTR_DATATYPE Type, const(ubyte)* pValue, 
                            ushort cbLength);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmwriteradvanced3
@GUID("2cd6492d-7c37-4e76-9d3b-59261183a22e")
interface IWMWriterAdvanced3 : IWMWriterAdvanced2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriteradvanced3-getstatisticsex
    HRESULT GetStatisticsEx(ushort wStreamNum, WM_WRITER_STATISTICS_EX* pStats);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriteradvanced3-setnonblocking
    HRESULT SetNonBlocking();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmwriterpreprocess
@GUID("fc54a285-38c4-45b5-aa23-85b9f7cb424b")
interface IWMWriterPreprocess : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriterpreprocess-getmaxpreprocessingpasses
    HRESULT GetMaxPreprocessingPasses(uint dwInputNum, uint dwFlags, uint* pdwMaxNumPasses);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriterpreprocess-setnumpreprocessingpasses
    HRESULT SetNumPreprocessingPasses(uint dwInputNum, uint dwFlags, uint dwNumPasses);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriterpreprocess-beginpreprocessingpass
    HRESULT BeginPreprocessingPass(uint dwInputNum, uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriterpreprocess-preprocesssample
    HRESULT PreprocessSample(uint dwInputNum, ulong cnsSampleTime, uint dwFlags, INSSBuffer pSample);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriterpreprocess-endpreprocessingpass
    HRESULT EndPreprocessingPass(uint dwInputNum, uint dwFlags);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmwriterpostviewcallback
@GUID("d9d6549d-a193-4f24-b308-03123d9b7f8d")
interface IWMWriterPostViewCallback : IWMStatusCallback
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriterpostviewcallback-onpostviewsample
    HRESULT OnPostViewSample(ushort wStreamNumber, ulong cnsSampleTime, ulong cnsSampleDuration, uint dwFlags, 
                             INSSBuffer pSample, void* pvContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriterpostviewcallback-allocateforpostview
    HRESULT AllocateForPostView(ushort wStreamNum, uint cbBuffer, INSSBuffer* ppBuffer, void* pvContext);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmwriterpostview
@GUID("81e20ce4-75ef-491a-8004-fc53c45bdc3e")
interface IWMWriterPostView : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriterpostview-setpostviewcallback
    HRESULT SetPostViewCallback(IWMWriterPostViewCallback pCallback, void* pvContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriterpostview-setreceivepostviewsamples
    HRESULT SetReceivePostViewSamples(ushort wStreamNum, BOOL fReceivePostViewSamples);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriterpostview-getreceivepostviewsamples
    HRESULT GetReceivePostViewSamples(ushort wStreamNum, BOOL* pfReceivePostViewSamples);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriterpostview-getpostviewprops
    HRESULT GetPostViewProps(ushort wStreamNumber, IWMMediaProps* ppOutput);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriterpostview-setpostviewprops
    HRESULT SetPostViewProps(ushort wStreamNumber, IWMMediaProps pOutput);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriterpostview-getpostviewformatcount
    HRESULT GetPostViewFormatCount(ushort wStreamNumber, uint* pcFormats);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriterpostview-getpostviewformat
    HRESULT GetPostViewFormat(ushort wStreamNumber, uint dwFormatNumber, IWMMediaProps* ppProps);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriterpostview-setallocateforpostview
    HRESULT SetAllocateForPostView(ushort wStreamNumber, BOOL fAllocate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriterpostview-getallocateforpostview
    HRESULT GetAllocateForPostView(ushort wStreamNumber, BOOL* pfAllocate);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmwritersink
@GUID("96406be4-2b2b-11d3-b36b-00c04f6108ff")
interface IWMWriterSink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwritersink-onheader
    HRESULT OnHeader(INSSBuffer pHeader);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwritersink-isrealtime
    HRESULT IsRealTime(BOOL* pfRealTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwritersink-allocatedataunit
    HRESULT AllocateDataUnit(uint cbDataUnit, INSSBuffer* ppDataUnit);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwritersink-ondataunit
    HRESULT OnDataUnit(INSSBuffer pDataUnit);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwritersink-onendwriting
    HRESULT OnEndWriting();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmregistercallback
@GUID("cf4b1f99-4de2-4e49-a363-252740d99bc1")
interface IWMRegisterCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmregistercallback-advise
    HRESULT Advise(IWMStatusCallback pCallback, void* pvContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmregistercallback-unadvise
    HRESULT Unadvise(IWMStatusCallback pCallback, void* pvContext);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmwriterfilesink
@GUID("96406be5-2b2b-11d3-b36b-00c04f6108ff")
interface IWMWriterFileSink : IWMWriterSink
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriterfilesink-open
    HRESULT Open(const(PWSTR) pwszFilename);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmwriterfilesink2
@GUID("14282ba7-4aef-4205-8ce5-c229035a05bc")
interface IWMWriterFileSink2 : IWMWriterFileSink
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriterfilesink2-start
    HRESULT Start(ulong cnsStartTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriterfilesink2-stop
    HRESULT Stop(ulong cnsStopTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriterfilesink2-isstopped
    HRESULT IsStopped(BOOL* pfStopped);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriterfilesink2-getfileduration
    HRESULT GetFileDuration(ulong* pcnsDuration);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriterfilesink2-getfilesize
    HRESULT GetFileSize(ulong* pcbFile);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriterfilesink2-close
    HRESULT Close();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriterfilesink2-isclosed
    HRESULT IsClosed(BOOL* pfClosed);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmwriterfilesink3
@GUID("3fea4feb-2945-47a7-a1dd-c53a8fc4c45c")
interface IWMWriterFileSink3 : IWMWriterFileSink2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriterfilesink3-setautoindexing
    HRESULT SetAutoIndexing(BOOL fDoAutoIndexing);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriterfilesink3-getautoindexing
    HRESULT GetAutoIndexing(BOOL* pfAutoIndexing);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriterfilesink3-setcontrolstream
    HRESULT SetControlStream(ushort wStreamNumber, BOOL fShouldControlStartAndStop);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriterfilesink3-getmode
    HRESULT GetMode(uint* pdwFileSinkMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriterfilesink3-ondataunitex
    HRESULT OnDataUnitEx(WMT_FILESINK_DATA_UNIT* pFileSinkDataUnit);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriterfilesink3-setunbufferedio
    HRESULT SetUnbufferedIO(BOOL fUnbufferedIO, BOOL fRestrictMemUsage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriterfilesink3-getunbufferedio
    HRESULT GetUnbufferedIO(BOOL* pfUnbufferedIO);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriterfilesink3-completeoperations
    HRESULT CompleteOperations();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmwriternetworksink
@GUID("96406be7-2b2b-11d3-b36b-00c04f6108ff")
interface IWMWriterNetworkSink : IWMWriterSink
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriternetworksink-setmaximumclients
    HRESULT SetMaximumClients(uint dwMaxClients);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriternetworksink-getmaximumclients
    HRESULT GetMaximumClients(uint* pdwMaxClients);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriternetworksink-setnetworkprotocol
    HRESULT SetNetworkProtocol(WMT_NET_PROTOCOL protocol);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriternetworksink-getnetworkprotocol
    HRESULT GetNetworkProtocol(WMT_NET_PROTOCOL* pProtocol);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriternetworksink-gethosturl
    HRESULT GetHostURL(PWSTR pwszURL, uint* pcchURL);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriternetworksink-open
    HRESULT Open(uint* pdwPortNum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriternetworksink-disconnect
    HRESULT Disconnect();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriternetworksink-close
    HRESULT Close();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmclientconnections
@GUID("73c66010-a299-41df-b1f0-ccf03b09c1c6")
interface IWMClientConnections : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmclientconnections-getclientcount
    HRESULT GetClientCount(uint* pcClients);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmclientconnections-getclientproperties
    HRESULT GetClientProperties(uint dwClientNum, WM_CLIENT_PROPERTIES* pClientProperties);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmclientconnections2
@GUID("4091571e-4701-4593-bb3d-d5f5f0c74246")
interface IWMClientConnections2 : IWMClientConnections
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmclientconnections2-getclientinfo
    HRESULT GetClientInfo(uint dwClientNum, PWSTR pwszNetworkAddress, uint* pcchNetworkAddress, PWSTR pwszPort, 
                          uint* pcchPort, PWSTR pwszDNSName, uint* pcchDNSName);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmreaderadvanced
@GUID("96406bea-2b2b-11d3-b36b-00c04f6108ff")
interface IWMReaderAdvanced : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderadvanced-setuserprovidedclock
    HRESULT SetUserProvidedClock(BOOL fUserClock);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderadvanced-getuserprovidedclock
    HRESULT GetUserProvidedClock(BOOL* pfUserClock);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderadvanced-delivertime
    HRESULT DeliverTime(ulong cnsTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderadvanced-setmanualstreamselection
    HRESULT SetManualStreamSelection(BOOL fSelection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderadvanced-getmanualstreamselection
    HRESULT GetManualStreamSelection(BOOL* pfSelection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderadvanced-setstreamsselected
    HRESULT SetStreamsSelected(ushort cStreamCount, ushort* pwStreamNumbers, WMT_STREAM_SELECTION* pSelections);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderadvanced-getstreamselected
    HRESULT GetStreamSelected(ushort wStreamNum, WMT_STREAM_SELECTION* pSelection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderadvanced-setreceiveselectioncallbacks
    HRESULT SetReceiveSelectionCallbacks(BOOL fGetCallbacks);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderadvanced-getreceiveselectioncallbacks
    HRESULT GetReceiveSelectionCallbacks(BOOL* pfGetCallbacks);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderadvanced-setreceivestreamsamples
    HRESULT SetReceiveStreamSamples(ushort wStreamNum, BOOL fReceiveStreamSamples);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderadvanced-getreceivestreamsamples
    HRESULT GetReceiveStreamSamples(ushort wStreamNum, BOOL* pfReceiveStreamSamples);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderadvanced-setallocateforoutput
    HRESULT SetAllocateForOutput(uint dwOutputNum, BOOL fAllocate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderadvanced-getallocateforoutput
    HRESULT GetAllocateForOutput(uint dwOutputNum, BOOL* pfAllocate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderadvanced-setallocateforstream
    HRESULT SetAllocateForStream(ushort wStreamNum, BOOL fAllocate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderadvanced-getallocateforstream
    HRESULT GetAllocateForStream(ushort dwSreamNum, BOOL* pfAllocate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderadvanced-getstatistics
    HRESULT GetStatistics(WM_READER_STATISTICS* pStatistics);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderadvanced-setclientinfo
    HRESULT SetClientInfo(WM_READER_CLIENTINFO* pClientInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderadvanced-getmaxoutputsamplesize
    HRESULT GetMaxOutputSampleSize(uint dwOutput, uint* pcbMax);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderadvanced-getmaxstreamsamplesize
    HRESULT GetMaxStreamSampleSize(ushort wStream, uint* pcbMax);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderadvanced-notifylatedelivery
    HRESULT NotifyLateDelivery(ulong cnsLateness);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmreaderadvanced2
@GUID("ae14a945-b90c-4d0d-9127-80d665f7d73e")
interface IWMReaderAdvanced2 : IWMReaderAdvanced
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderadvanced2-setplaymode
    HRESULT SetPlayMode(WMT_PLAY_MODE Mode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderadvanced2-getplaymode
    HRESULT GetPlayMode(WMT_PLAY_MODE* pMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderadvanced2-getbufferprogress
    HRESULT GetBufferProgress(uint* pdwPercent, ulong* pcnsBuffering);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderadvanced2-getdownloadprogress
    HRESULT GetDownloadProgress(uint* pdwPercent, ulong* pqwBytesDownloaded, ulong* pcnsDownload);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderadvanced2-getsaveasprogress
    HRESULT GetSaveAsProgress(uint* pdwPercent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderadvanced2-savefileas
    HRESULT SaveFileAs(const(PWSTR) pwszFilename);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderadvanced2-getprotocolname
    HRESULT GetProtocolName(PWSTR pwszProtocol, uint* pcchProtocol);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderadvanced2-startatmarker
    HRESULT StartAtMarker(ushort wMarkerIndex, ulong cnsDuration, float fRate, void* pvContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderadvanced2-getoutputsetting
    HRESULT GetOutputSetting(uint dwOutputNum, const(PWSTR) pszName, WMT_ATTR_DATATYPE* pType, ubyte* pValue, 
                             ushort* pcbLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderadvanced2-setoutputsetting
    HRESULT SetOutputSetting(uint dwOutputNum, const(PWSTR) pszName, WMT_ATTR_DATATYPE Type, const(ubyte)* pValue, 
                             ushort cbLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderadvanced2-preroll
    HRESULT Preroll(ulong cnsStart, ulong cnsDuration, float fRate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderadvanced2-setlogclientid
    HRESULT SetLogClientID(BOOL fLogClientID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderadvanced2-getlogclientid
    HRESULT GetLogClientID(BOOL* pfLogClientID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderadvanced2-stopbuffering
    HRESULT StopBuffering();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderadvanced2-openstream
    HRESULT OpenStream(IStream pStream, IWMReaderCallback pCallback, void* pvContext);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmreaderadvanced3
@GUID("5dc0674b-f04b-4a4e-9f2a-b1afde2c8100")
interface IWMReaderAdvanced3 : IWMReaderAdvanced2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderadvanced3-stopnetstreaming
    HRESULT StopNetStreaming();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderadvanced3-startatposition
    HRESULT StartAtPosition(ushort wStreamNum, void* pvOffsetStart, void* pvDuration, 
                            WMT_OFFSET_FORMAT dwOffsetFormat, float fRate, void* pvContext);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmreaderadvanced4
@GUID("945a76a2-12ae-4d48-bd3c-cd1d90399b85")
interface IWMReaderAdvanced4 : IWMReaderAdvanced3
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderadvanced4-getlanguagecount
    HRESULT GetLanguageCount(uint dwOutputNum, ushort* pwLanguageCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderadvanced4-getlanguage
    HRESULT GetLanguage(uint dwOutputNum, ushort wLanguage, PWSTR pwszLanguageString, 
                        ushort* pcchLanguageStringLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderadvanced4-getmaxspeedfactor
    HRESULT GetMaxSpeedFactor(double* pdblFactor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderadvanced4-isusingfastcache
    HRESULT IsUsingFastCache(BOOL* pfUsingFastCache);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderadvanced4-addlogparam
    HRESULT AddLogParam(const(PWSTR) wszNameSpace, const(PWSTR) wszName, const(PWSTR) wszValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderadvanced4-sendlogparams
    HRESULT SendLogParams();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderadvanced4-cansavefileas
    HRESULT CanSaveFileAs(BOOL* pfCanSave);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderadvanced4-cancelsavefileas
    HRESULT CancelSaveFileAs();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderadvanced4-geturl
    HRESULT GetURL(PWSTR pwszURL, uint* pcchURL);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmreaderadvanced5
@GUID("24c44db0-55d1-49ae-a5cc-f13815e36363")
interface IWMReaderAdvanced5 : IWMReaderAdvanced4
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderadvanced5-setplayerhook
    HRESULT SetPlayerHook(uint dwOutputNum, IWMPlayerHook pHook);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmreaderadvanced6
@GUID("18a2e7f8-428f-4acd-8a00-e64639bc93de")
interface IWMReaderAdvanced6 : IWMReaderAdvanced5
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderadvanced6-setprotectstreamsamples
    HRESULT SetProtectStreamSamples(ubyte* pbCertificate, uint cbCertificate, uint dwCertificateType, uint dwFlags, 
                                    ubyte* pbInitializationVector, uint* pcbInitializationVector);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmplayerhook
@GUID("e5b7ca9a-0f1c-4f66-9002-74ec50d8b304")
interface IWMPlayerHook : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmplayerhook-predecode
    HRESULT PreDecode();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmreaderallocatorex
@GUID("9f762fa7-a22e-428d-93c9-ac82f3aafe5a")
interface IWMReaderAllocatorEx : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderallocatorex-allocateforstreamex
    HRESULT AllocateForStreamEx(ushort wStreamNum, uint cbBuffer, INSSBuffer* ppBuffer, uint dwFlags, 
                                ulong cnsSampleTime, ulong cnsSampleDuration, void* pvContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderallocatorex-allocateforoutputex
    HRESULT AllocateForOutputEx(uint dwOutputNum, uint cbBuffer, INSSBuffer* ppBuffer, uint dwFlags, 
                                ulong cnsSampleTime, ulong cnsSampleDuration, void* pvContext);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmreadertypenegotiation
@GUID("fdbe5592-81a1-41ea-93bd-735cad1adc05")
interface IWMReaderTypeNegotiation : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadertypenegotiation-tryoutputprops
    HRESULT TryOutputProps(uint dwOutputNum, IWMOutputMediaProps pOutput);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmreadercallbackadvanced
@GUID("96406beb-2b2b-11d3-b36b-00c04f6108ff")
interface IWMReaderCallbackAdvanced : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadercallbackadvanced-onstreamsample
    HRESULT OnStreamSample(ushort wStreamNum, ulong cnsSampleTime, ulong cnsSampleDuration, uint dwFlags, 
                           INSSBuffer pSample, void* pvContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadercallbackadvanced-ontime
    HRESULT OnTime(ulong cnsCurrentTime, void* pvContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadercallbackadvanced-onstreamselection
    HRESULT OnStreamSelection(ushort wStreamCount, ushort* pStreamNumbers, WMT_STREAM_SELECTION* pSelections, 
                              void* pvContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadercallbackadvanced-onoutputpropschanged
    HRESULT OnOutputPropsChanged(uint dwOutputNum, WM_MEDIA_TYPE* pMediaType, void* pvContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadercallbackadvanced-allocateforstream
    HRESULT AllocateForStream(ushort wStreamNum, uint cbBuffer, INSSBuffer* ppBuffer, void* pvContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadercallbackadvanced-allocateforoutput
    HRESULT AllocateForOutput(uint dwOutputNum, uint cbBuffer, INSSBuffer* ppBuffer, void* pvContext);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmdrmreader
@GUID("d2827540-3ee7-432c-b14c-dc17f085d3b3")
interface IWMDRMReader : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmdrmreader-acquirelicense
    HRESULT AcquireLicense(uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmdrmreader-cancellicenseacquisition
    HRESULT CancelLicenseAcquisition();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmdrmreader-individualize
    HRESULT Individualize(uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmdrmreader-cancelindividualization
    HRESULT CancelIndividualization();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmdrmreader-monitorlicenseacquisition
    HRESULT MonitorLicenseAcquisition();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmdrmreader-cancelmonitorlicenseacquisition
    HRESULT CancelMonitorLicenseAcquisition();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmdrmreader-setdrmproperty
    HRESULT SetDRMProperty(const(PWSTR) pwstrName, WMT_ATTR_DATATYPE dwType, const(ubyte)* pValue, ushort cbLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmdrmreader-getdrmproperty
    HRESULT GetDRMProperty(const(PWSTR) pwstrName, WMT_ATTR_DATATYPE* pdwType, ubyte* pValue, ushort* pcbLength);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmdrmreader2
@GUID("befe7a75-9f1d-4075-b9d9-a3c37bda49a0")
interface IWMDRMReader2 : IWMDRMReader
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmdrmreader2-setevaluateoutputlevellicenses
    HRESULT SetEvaluateOutputLevelLicenses(BOOL fEvaluate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmdrmreader2-getplayoutputlevels
    HRESULT GetPlayOutputLevels(DRM_PLAY_OPL* pPlayOPL, uint* pcbLength, uint* pdwMinAppComplianceLevel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmdrmreader2-getcopyoutputlevels
    HRESULT GetCopyOutputLevels(DRM_COPY_OPL* pCopyOPL, uint* pcbLength, uint* pdwMinAppComplianceLevel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmdrmreader2-trynextlicense
    HRESULT TryNextLicense();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmdrmreader3
@GUID("e08672de-f1e7-4ff4-a0a3-fc4b08e4caf8")
interface IWMDRMReader3 : IWMDRMReader2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmdrmreader3-getinclusionlist
    HRESULT GetInclusionList(GUID** ppGuids, uint* pcGuids);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmreaderplaylistburn
@GUID("f28c0300-9baa-4477-a846-1744d9cbf533")
interface IWMReaderPlaylistBurn : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderplaylistburn-initplaylistburn
    HRESULT InitPlaylistBurn(uint cFiles, PWSTR* ppwszFilenames, IWMStatusCallback pCallback, void* pvContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderplaylistburn-getinitresults
    HRESULT GetInitResults(uint cFiles, HRESULT* phrStati);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderplaylistburn-cancel
    HRESULT Cancel();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderplaylistburn-endplaylistburn
    HRESULT EndPlaylistBurn(HRESULT hrBurnResult);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmreadernetworkconfig
@GUID("96406bec-2b2b-11d3-b36b-00c04f6108ff")
interface IWMReaderNetworkConfig : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadernetworkconfig-getbufferingtime
    HRESULT GetBufferingTime(ulong* pcnsBufferingTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadernetworkconfig-setbufferingtime
    HRESULT SetBufferingTime(ulong cnsBufferingTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadernetworkconfig-getudpportranges
    HRESULT GetUDPPortRanges(WM_PORT_NUMBER_RANGE* pRangeArray, uint* pcRanges);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadernetworkconfig-setudpportranges
    HRESULT SetUDPPortRanges(WM_PORT_NUMBER_RANGE* pRangeArray, uint cRanges);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadernetworkconfig-getproxysettings
    HRESULT GetProxySettings(const(PWSTR) pwszProtocol, WMT_PROXY_SETTINGS* pProxySetting);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadernetworkconfig-setproxysettings
    HRESULT SetProxySettings(const(PWSTR) pwszProtocol, WMT_PROXY_SETTINGS ProxySetting);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadernetworkconfig-getproxyhostname
    HRESULT GetProxyHostName(const(PWSTR) pwszProtocol, PWSTR pwszHostName, uint* pcchHostName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadernetworkconfig-setproxyhostname
    HRESULT SetProxyHostName(const(PWSTR) pwszProtocol, const(PWSTR) pwszHostName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadernetworkconfig-getproxyport
    HRESULT GetProxyPort(const(PWSTR) pwszProtocol, uint* pdwPort);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadernetworkconfig-setproxyport
    HRESULT SetProxyPort(const(PWSTR) pwszProtocol, uint dwPort);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadernetworkconfig-getproxyexceptionlist
    HRESULT GetProxyExceptionList(const(PWSTR) pwszProtocol, PWSTR pwszExceptionList, uint* pcchExceptionList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadernetworkconfig-setproxyexceptionlist
    HRESULT SetProxyExceptionList(const(PWSTR) pwszProtocol, const(PWSTR) pwszExceptionList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadernetworkconfig-getproxybypassforlocal
    HRESULT GetProxyBypassForLocal(const(PWSTR) pwszProtocol, BOOL* pfBypassForLocal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadernetworkconfig-setproxybypassforlocal
    HRESULT SetProxyBypassForLocal(const(PWSTR) pwszProtocol, BOOL fBypassForLocal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadernetworkconfig-getforcererunautoproxydetection
    HRESULT GetForceRerunAutoProxyDetection(BOOL* pfForceRerunDetection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadernetworkconfig-setforcererunautoproxydetection
    HRESULT SetForceRerunAutoProxyDetection(BOOL fForceRerunDetection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadernetworkconfig-getenablemulticast
    HRESULT GetEnableMulticast(BOOL* pfEnableMulticast);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadernetworkconfig-setenablemulticast
    HRESULT SetEnableMulticast(BOOL fEnableMulticast);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadernetworkconfig-getenablehttp
    HRESULT GetEnableHTTP(BOOL* pfEnableHTTP);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadernetworkconfig-setenablehttp
    HRESULT SetEnableHTTP(BOOL fEnableHTTP);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadernetworkconfig-getenableudp
    HRESULT GetEnableUDP(BOOL* pfEnableUDP);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadernetworkconfig-setenableudp
    HRESULT SetEnableUDP(BOOL fEnableUDP);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadernetworkconfig-getenabletcp
    HRESULT GetEnableTCP(BOOL* pfEnableTCP);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadernetworkconfig-setenabletcp
    HRESULT SetEnableTCP(BOOL fEnableTCP);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadernetworkconfig-resetprotocolrollover
    HRESULT ResetProtocolRollover();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadernetworkconfig-getconnectionbandwidth
    HRESULT GetConnectionBandwidth(uint* pdwConnectionBandwidth);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadernetworkconfig-setconnectionbandwidth
    HRESULT SetConnectionBandwidth(uint dwConnectionBandwidth);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadernetworkconfig-getnumprotocolssupported
    HRESULT GetNumProtocolsSupported(uint* pcProtocols);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadernetworkconfig-getsupportedprotocolname
    HRESULT GetSupportedProtocolName(uint dwProtocolNum, PWSTR pwszProtocolName, uint* pcchProtocolName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadernetworkconfig-addloggingurl
    HRESULT AddLoggingUrl(const(PWSTR) pwszUrl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadernetworkconfig-getloggingurl
    HRESULT GetLoggingUrl(uint dwIndex, PWSTR pwszUrl, uint* pcchUrl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadernetworkconfig-getloggingurlcount
    HRESULT GetLoggingUrlCount(uint* pdwUrlCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadernetworkconfig-resetloggingurllist
    HRESULT ResetLoggingUrlList();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmreadernetworkconfig2
@GUID("d979a853-042b-4050-8387-c939db22013f")
interface IWMReaderNetworkConfig2 : IWMReaderNetworkConfig
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadernetworkconfig2-getenablecontentcaching
    HRESULT GetEnableContentCaching(BOOL* pfEnableContentCaching);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadernetworkconfig2-setenablecontentcaching
    HRESULT SetEnableContentCaching(BOOL fEnableContentCaching);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadernetworkconfig2-getenablefastcache
    HRESULT GetEnableFastCache(BOOL* pfEnableFastCache);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadernetworkconfig2-setenablefastcache
    HRESULT SetEnableFastCache(BOOL fEnableFastCache);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadernetworkconfig2-getacceleratedstreamingduration
    HRESULT GetAcceleratedStreamingDuration(ulong* pcnsAccelDuration);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadernetworkconfig2-setacceleratedstreamingduration
    HRESULT SetAcceleratedStreamingDuration(ulong cnsAccelDuration);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadernetworkconfig2-getautoreconnectlimit
    HRESULT GetAutoReconnectLimit(uint* pdwAutoReconnectLimit);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadernetworkconfig2-setautoreconnectlimit
    HRESULT SetAutoReconnectLimit(uint dwAutoReconnectLimit);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadernetworkconfig2-getenableresends
    HRESULT GetEnableResends(BOOL* pfEnableResends);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadernetworkconfig2-setenableresends
    HRESULT SetEnableResends(BOOL fEnableResends);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadernetworkconfig2-getenablethinning
    HRESULT GetEnableThinning(BOOL* pfEnableThinning);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadernetworkconfig2-setenablethinning
    HRESULT SetEnableThinning(BOOL fEnableThinning);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadernetworkconfig2-getmaxnetpacketsize
    HRESULT GetMaxNetPacketSize(uint* pdwMaxNetPacketSize);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmreaderstreamclock
@GUID("96406bed-2b2b-11d3-b36b-00c04f6108ff")
interface IWMReaderStreamClock : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderstreamclock-gettime
    HRESULT GetTime(ulong* pcnsNow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderstreamclock-settimer
    HRESULT SetTimer(ulong cnsWhen, void* pvParam, uint* pdwTimerId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderstreamclock-killtimer
    HRESULT KillTimer(uint dwTimerId);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmindexer
@GUID("6d7cdc71-9888-11d3-8edc-00c04f6109cf")
interface IWMIndexer : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmindexer-startindexing
    HRESULT StartIndexing(const(PWSTR) pwszURL, IWMStatusCallback pCallback, void* pvContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmindexer-cancel
    HRESULT Cancel();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmindexer2
@GUID("b70f1e42-6255-4df0-a6b9-02b212d9e2bb")
interface IWMIndexer2 : IWMIndexer
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmindexer2-configure
    HRESULT Configure(ushort wStreamNum, WMT_INDEXER_TYPE nIndexerType, void* pvInterval, void* pvIndexType);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmlicensebackup
@GUID("05e5ac9f-3fb6-4508-bb43-a4067ba1ebe8")
interface IWMLicenseBackup : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmlicensebackup-backuplicenses
    HRESULT BackupLicenses(uint dwFlags, IWMStatusCallback pCallback);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmlicensebackup-cancellicensebackup
    HRESULT CancelLicenseBackup();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmlicenserestore
@GUID("c70b6334-a22e-4efb-a245-15e65a004a13")
interface IWMLicenseRestore : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmlicenserestore-restorelicenses
    HRESULT RestoreLicenses(uint dwFlags, IWMStatusCallback pCallback);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmlicenserestore-cancellicenserestore
    HRESULT CancelLicenseRestore();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmbackuprestoreprops
@GUID("3c8e0da6-996f-4ff3-a1af-4838f9377e2e")
interface IWMBackupRestoreProps : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmbackuprestoreprops-getpropcount
    HRESULT GetPropCount(ushort* pcProps);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmbackuprestoreprops-getpropbyindex
    HRESULT GetPropByIndex(ushort wIndex, PWSTR pwszName, ushort* pcchNameLen, WMT_ATTR_DATATYPE* pType, 
                           ubyte* pValue, ushort* pcbLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmbackuprestoreprops-getpropbyname
    HRESULT GetPropByName(const(PWSTR) pszName, WMT_ATTR_DATATYPE* pType, ubyte* pValue, ushort* pcbLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmbackuprestoreprops-setprop
    HRESULT SetProp(const(PWSTR) pszName, WMT_ATTR_DATATYPE Type, const(ubyte)* pValue, ushort cbLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmbackuprestoreprops-removeprop
    HRESULT RemoveProp(const(PWSTR) pcwszName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmbackuprestoreprops-removeallprops
    HRESULT RemoveAllProps();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmcodecinfo
@GUID("a970f41e-34de-4a98-b3ba-e4b3ca7528f0")
interface IWMCodecInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmcodecinfo-getcodecinfocount
    HRESULT GetCodecInfoCount(const(GUID)* guidType, uint* pcCodecs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmcodecinfo-getcodecformatcount
    HRESULT GetCodecFormatCount(const(GUID)* guidType, uint dwCodecIndex, uint* pcFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmcodecinfo-getcodecformat
    HRESULT GetCodecFormat(const(GUID)* guidType, uint dwCodecIndex, uint dwFormatIndex, 
                           IWMStreamConfig* ppIStreamConfig);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmcodecinfo2
@GUID("aa65e273-b686-4056-91ec-dd768d4df710")
interface IWMCodecInfo2 : IWMCodecInfo
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmcodecinfo2-getcodecname
    HRESULT GetCodecName(const(GUID)* guidType, uint dwCodecIndex, PWSTR wszName, uint* pcchName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmcodecinfo2-getcodecformatdesc
    HRESULT GetCodecFormatDesc(const(GUID)* guidType, uint dwCodecIndex, uint dwFormatIndex, 
                               IWMStreamConfig* ppIStreamConfig, PWSTR wszDesc, uint* pcchDesc);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmcodecinfo3
@GUID("7e51f487-4d93-4f98-8ab4-27d0565adc51")
interface IWMCodecInfo3 : IWMCodecInfo2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmcodecinfo3-getcodecformatprop
    HRESULT GetCodecFormatProp(const(GUID)* guidType, uint dwCodecIndex, uint dwFormatIndex, const(PWSTR) pszName, 
                               WMT_ATTR_DATATYPE* pType, ubyte* pValue, uint* pdwSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmcodecinfo3-getcodecprop
    HRESULT GetCodecProp(const(GUID)* guidType, uint dwCodecIndex, const(PWSTR) pszName, WMT_ATTR_DATATYPE* pType, 
                         ubyte* pValue, uint* pdwSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmcodecinfo3-setcodecenumerationsetting
    HRESULT SetCodecEnumerationSetting(const(GUID)* guidType, uint dwCodecIndex, const(PWSTR) pszName, 
                                       WMT_ATTR_DATATYPE Type, const(ubyte)* pValue, uint dwSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmcodecinfo3-getcodecenumerationsetting
    HRESULT GetCodecEnumerationSetting(const(GUID)* guidType, uint dwCodecIndex, const(PWSTR) pszName, 
                                       WMT_ATTR_DATATYPE* pType, ubyte* pValue, uint* pdwSize);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmlanguagelist
@GUID("df683f00-2d49-4d8e-92b7-fb19f6a0dc57")
interface IWMLanguageList : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmlanguagelist-getlanguagecount
    HRESULT GetLanguageCount(ushort* pwCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmlanguagelist-getlanguagedetails
    HRESULT GetLanguageDetails(ushort wIndex, PWSTR pwszLanguageString, ushort* pcchLanguageStringLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmlanguagelist-addlanguagebyrfc1766string
    HRESULT AddLanguageByRFC1766String(PWSTR pwszLanguageString, ushort* pwIndex);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmwriterpushsink
@GUID("dc10e6a5-072c-467d-bf57-6330a9dde12a")
interface IWMWriterPushSink : IWMWriterSink
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriterpushsink-connect
    HRESULT Connect(const(PWSTR) pwszURL, const(PWSTR) pwszTemplateURL, BOOL fAutoDestroy);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriterpushsink-disconnect
    HRESULT Disconnect();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwriterpushsink-endsession
    HRESULT EndSession();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmdeviceregistration
@GUID("f6211f03-8d21-4e94-93e6-8510805f2d99")
interface IWMDeviceRegistration : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmdeviceregistration-registerdevice
    HRESULT RegisterDevice(uint dwRegisterType, ubyte* pbCertificate, uint cbCertificate, DRM_VAL16 SerialNumber, 
                           IWMRegisteredDevice* ppDevice);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmdeviceregistration-unregisterdevice
    HRESULT UnregisterDevice(uint dwRegisterType, ubyte* pbCertificate, uint cbCertificate, DRM_VAL16 SerialNumber);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmdeviceregistration-getregistrationstats
    HRESULT GetRegistrationStats(uint dwRegisterType, uint* pcRegisteredDevices);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmdeviceregistration-getfirstregistereddevice
    HRESULT GetFirstRegisteredDevice(uint dwRegisterType, IWMRegisteredDevice* ppDevice);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmdeviceregistration-getnextregistereddevice
    HRESULT GetNextRegisteredDevice(IWMRegisteredDevice* ppDevice);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmdeviceregistration-getregistereddevicebyid
    HRESULT GetRegisteredDeviceByID(uint dwRegisterType, ubyte* pbCertificate, uint cbCertificate, 
                                    DRM_VAL16 SerialNumber, IWMRegisteredDevice* ppDevice);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmregistereddevice
@GUID("a4503bec-5508-4148-97ac-bfa75760a70d")
interface IWMRegisteredDevice : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmregistereddevice-getdeviceserialnumber
    HRESULT GetDeviceSerialNumber(DRM_VAL16* pSerialNumber);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmregistereddevice-getdevicecertificate
    HRESULT GetDeviceCertificate(INSSBuffer* ppCertificate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmregistereddevice-getdevicetype
    HRESULT GetDeviceType(uint* pdwType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmregistereddevice-getattributecount
    HRESULT GetAttributeCount(uint* pcAttributes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmregistereddevice-getattributebyindex
    HRESULT GetAttributeByIndex(uint dwIndex, BSTR* pbstrName, BSTR* pbstrValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmregistereddevice-getattributebyname
    HRESULT GetAttributeByName(BSTR bstrName, BSTR* pbstrValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmregistereddevice-setattributebyname
    HRESULT SetAttributeByName(BSTR bstrName, BSTR bstrValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmregistereddevice-approve
    HRESULT Approve(BOOL fApprove);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmregistereddevice-isvalid
    HRESULT IsValid(BOOL* pfValid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmregistereddevice-isapproved
    HRESULT IsApproved(BOOL* pfApproved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmregistereddevice-iswmdrmcompliant
    HRESULT IsWmdrmCompliant(BOOL* pfCompliant);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmregistereddevice-isopened
    HRESULT IsOpened(BOOL* pfOpened);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmregistereddevice-open
    HRESULT Open();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmregistereddevice-close
    HRESULT Close();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmproximitydetection
@GUID("6a9fd8ee-b651-4bf0-b849-7d4ece79a2b1")
interface IWMProximityDetection : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmproximitydetection-startdetection
    HRESULT StartDetection(ubyte* pbRegistrationMsg, uint cbRegistrationMsg, ubyte* pbLocalAddress, 
                           uint cbLocalAddress, uint dwExtraPortsAllowed, INSSBuffer* ppRegistrationResponseMsg, 
                           IWMStatusCallback pCallback, void* pvContext);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmdrmmessageparser
@GUID("a73a0072-25a0-4c99-b4a5-ede8101a6c39")
interface IWMDRMMessageParser : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmdrmmessageparser-parseregistrationreqmsg
    HRESULT ParseRegistrationReqMsg(ubyte* pbRegistrationReqMsg, uint cbRegistrationReqMsg, 
                                    INSSBuffer* ppDeviceCert, DRM_VAL16* pDeviceSerialNumber);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmdrmmessageparser-parselicenserequestmsg
    HRESULT ParseLicenseRequestMsg(ubyte* pbLicenseRequestMsg, uint cbLicenseRequestMsg, INSSBuffer* ppDeviceCert, 
                                   DRM_VAL16* pDeviceSerialNumber, BSTR* pbstrAction);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmdrmtranscryptor
@GUID("69059850-6e6f-4bb2-806f-71863ddfc471")
interface IWMDRMTranscryptor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmdrmtranscryptor-initialize
    HRESULT Initialize(BSTR bstrFileName, ubyte* pbLicenseRequestMsg, uint cbLicenseRequestMsg, 
                       INSSBuffer* ppLicenseResponseMsg, IWMStatusCallback pCallback, void* pvContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmdrmtranscryptor-seek
    HRESULT Seek(ulong hnsTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmdrmtranscryptor-read
    HRESULT Read(ubyte* pbData, uint* pcbData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmdrmtranscryptor-close
    HRESULT Close();
}

@GUID("e0da439f-d331-496a-bece-18e5bac5dd23")
interface IWMDRMTranscryptor2 : IWMDRMTranscryptor
{
    HRESULT SeekEx(ulong cnsStartTime, ulong cnsDuration, float flRate, BOOL fIncludeFileHeader);
    HRESULT ZeroAdjustTimestamps(BOOL fEnable);
    HRESULT GetSeekStartTime(ulong* pcnsTime);
    HRESULT GetDuration(ulong* pcnsDuration);
}

@GUID("b1a887b2-a4f0-407a-b02e-efbd23bbecdf")
interface IWMDRMTranscryptionManager : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmdrmtranscryptionmanager-createtranscryptor
    HRESULT CreateTranscryptor(IWMDRMTranscryptor* ppTranscryptor);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmwatermarkinfo
@GUID("6f497062-f2e2-4624-8ea7-9dd40d81fc8d")
interface IWMWatermarkInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwatermarkinfo-getwatermarkentrycount
    HRESULT GetWatermarkEntryCount(WMT_WATERMARK_ENTRY_TYPE wmetType, uint* pdwCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmwatermarkinfo-getwatermarkentry
    HRESULT GetWatermarkEntry(WMT_WATERMARK_ENTRY_TYPE wmetType, uint dwEntryNum, WMT_WATERMARK_ENTRY* pEntry);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmreaderaccelerator
@GUID("bddc4d08-944d-4d52-a612-46c3fda07dd4")
interface IWMReaderAccelerator : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderaccelerator-getcodecinterface
    HRESULT GetCodecInterface(uint dwOutputNum, const(GUID)* riid, void** ppvCodecInterface);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreaderaccelerator-notify
    HRESULT Notify(uint dwOutputNum, WM_MEDIA_TYPE* pSubtype);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmreadertimecode
@GUID("f369e2f0-e081-4fe6-8450-b810b2f410d1")
interface IWMReaderTimecode : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadertimecode-gettimecoderangecount
    HRESULT GetTimecodeRangeCount(ushort wStreamNum, ushort* pwRangeCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmreadertimecode-gettimecoderangebounds
    HRESULT GetTimecodeRangeBounds(ushort wStreamNum, ushort wRangeNum, uint* pStartTimecode, uint* pEndTimecode);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmaddressaccess
@GUID("bb3c6389-1633-4e92-af14-9f3173ba39d0")
interface IWMAddressAccess : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmaddressaccess-getaccessentrycount
    HRESULT GetAccessEntryCount(WM_AETYPE aeType, uint* pcEntries);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmaddressaccess-getaccessentry
    HRESULT GetAccessEntry(WM_AETYPE aeType, uint dwEntryNum, WM_ADDRESS_ACCESSENTRY* pAddrAccessEntry);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmaddressaccess-addaccessentry
    HRESULT AddAccessEntry(WM_AETYPE aeType, WM_ADDRESS_ACCESSENTRY* pAddrAccessEntry);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmaddressaccess-removeaccessentry
    HRESULT RemoveAccessEntry(WM_AETYPE aeType, uint dwEntryNum);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmaddressaccess2
@GUID("65a83fc2-3e98-4d4d-81b5-2a742886b33d")
interface IWMAddressAccess2 : IWMAddressAccess
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmaddressaccess2-getaccessentryex
    HRESULT GetAccessEntryEx(WM_AETYPE aeType, uint dwEntryNum, BSTR* pbstrAddress, BSTR* pbstrMask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmaddressaccess2-addaccessentryex
    HRESULT AddAccessEntryEx(WM_AETYPE aeType, BSTR bstrAddress, BSTR bstrMask);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmimageinfo
@GUID("9f0aa3b6-7267-4d89-88f2-ba915aa5c4c6")
interface IWMImageInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmimageinfo-getimagecount
    HRESULT GetImageCount(uint* pcImages);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmimageinfo-getimage
    HRESULT GetImage(uint wIndex, ushort* pcchMIMEType, PWSTR pwszMIMEType, ushort* pcchDescription, 
                     PWSTR pwszDescription, ushort* pImageType, uint* pcbImageData, ubyte* pbImageData);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nn-wmsdkidl-iwmlicenserevocationagent
@GUID("6967f2c9-4e26-4b57-8894-799880f7ac7b")
interface IWMLicenseRevocationAgent : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmlicenserevocationagent-getlrbchallenge
    HRESULT GetLRBChallenge(ubyte* pMachineID, uint dwMachineIDLength, ubyte* pChallenge, uint dwChallengeLength, 
                            ubyte* pChallengeOutput, uint* pdwChallengeOutputLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsdkidl/nf-wmsdkidl-iwmlicenserevocationagent-processlrb
    HRESULT ProcessLRB(ubyte* pSignedLRB, uint dwSignedLRBLength, ubyte* pSignedACK, uint* pdwSignedACKLength);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsecure/nn-wmsecure-iwmauthorizer
@GUID("d9b67d36-a9ad-4eb4-baef-db284ef5504c")
interface IWMAuthorizer : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsecure/nf-wmsecure-iwmauthorizer-getcertcount
    HRESULT GetCertCount(uint* pcCerts);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsecure/nf-wmsecure-iwmauthorizer-getcert
    HRESULT GetCert(uint dwIndex, ubyte** ppbCertData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsecure/nf-wmsecure-iwmauthorizer-getshareddata
    HRESULT GetSharedData(uint dwCertIndex, const(ubyte)* pbSharedData, ubyte* pbCert, ubyte** ppbSharedData);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsecure/nn-wmsecure-iwmsecurechannel
@GUID("2720598a-d0f2-4189-bd10-91c46ef0936f")
interface IWMSecureChannel : IWMAuthorizer
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsecure/nf-wmsecure-iwmsecurechannel-wmsc_addcertificate
    HRESULT WMSC_AddCertificate(IWMAuthorizer pCert);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsecure/nf-wmsecure-iwmsecurechannel-wmsc_addsignature
    HRESULT WMSC_AddSignature(ubyte* pbCertSig, uint cbCertSig);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsecure/nf-wmsecure-iwmsecurechannel-wmsc_connect
    HRESULT WMSC_Connect(IWMSecureChannel pOtherSide);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsecure/nf-wmsecure-iwmsecurechannel-wmsc_isconnected
    HRESULT WMSC_IsConnected(BOOL* pfIsConnected);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsecure/nf-wmsecure-iwmsecurechannel-wmsc_disconnect
    HRESULT WMSC_Disconnect();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsecure/nf-wmsecure-iwmsecurechannel-wmsc_getvalidcertificate
    HRESULT WMSC_GetValidCertificate(ubyte** ppbCertificate, uint* pdwSignature);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsecure/nf-wmsecure-iwmsecurechannel-wmsc_encrypt
    HRESULT WMSC_Encrypt(ubyte* pbData, uint cbData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsecure/nf-wmsecure-iwmsecurechannel-wmsc_decrypt
    HRESULT WMSC_Decrypt(ubyte* pbData, uint cbData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsecure/nf-wmsecure-iwmsecurechannel-wmsc_lock
    HRESULT WMSC_Lock();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsecure/nf-wmsecure-iwmsecurechannel-wmsc_unlock
    HRESULT WMSC_Unlock();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsecure/nf-wmsecure-iwmsecurechannel-wmsc_setshareddata
    HRESULT WMSC_SetSharedData(uint dwCertIndex, const(ubyte)* pbSharedData);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsecure/nn-wmsecure-iwmgetsecurechannel
@GUID("94bc0598-c3d2-11d3-bedf-00c04f612986")
interface IWMGetSecureChannel : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsecure/nf-wmsecure-iwmgetsecurechannel-getpeersecurechannelinterface
    HRESULT GetPeerSecureChannelInterface(IWMSecureChannel* ppPeer);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmnetsourcecreator/nn-wmnetsourcecreator-insnetsourcecreator
@GUID("0c0e4080-9081-11d2-beec-0060082f2054")
interface INSNetSourceCreator : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmnetsourcecreator/nf-wmnetsourcecreator-insnetsourcecreator-initialize
    HRESULT Initialize();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmnetsourcecreator/nn-wmnetsourcecreator-insnetsourcecreator
    HRESULT CreateNetSource(const(PWSTR) pszStreamName, IUnknown pMonitor, ubyte* pData, IUnknown pUserContext, 
                            IUnknown pCallback, ulong qwContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmnetsourcecreator/nn-wmnetsourcecreator-insnetsourcecreator
    HRESULT GetNetSourceProperties(const(PWSTR) pszStreamName, IUnknown* ppPropertiesNode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmnetsourcecreator/nn-wmnetsourcecreator-insnetsourcecreator
    HRESULT GetNetSourceSharedNamespace(IUnknown* ppSharedNamespace);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmnetsourcecreator/nf-wmnetsourcecreator-insnetsourcecreator-getnetsourceadmininterface
    HRESULT GetNetSourceAdminInterface(const(PWSTR) pszStreamName, VARIANT* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmnetsourcecreator/nn-wmnetsourcecreator-insnetsourcecreator
    HRESULT GetNumProtocolsSupported(uint* pcProtocols);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmnetsourcecreator/nn-wmnetsourcecreator-insnetsourcecreator
    HRESULT GetProtocolName(uint dwProtocolNum, PWSTR pwszProtocolName, ushort* pcchProtocolName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmnetsourcecreator/nf-wmnetsourcecreator-insnetsourcecreator-shutdown
    HRESULT Shutdown();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmdxva/nn-wmdxva-iwmplayertimestamphook
@GUID("28580dda-d98e-48d0-b7ae-69e473a02825")
interface IWMPlayerTimestampHook : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmdxva/nf-wmdxva-iwmplayertimestamphook-maptimestamp
    HRESULT MapTimestamp(long rtIn, long* prtOut);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsinternaladminnetsource/nn-wmsinternaladminnetsource-iwmsinternaladminnetsource
@GUID("8bb23e5f-d127-4afb-8d02-ae5b66d54c78")
interface IWMSInternalAdminNetSource : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsinternaladminnetsource/nn-wmsinternaladminnetsource-iwmsinternaladminnetsource
    HRESULT Initialize(IUnknown pSharedNamespace, IUnknown pNamespaceNode, INSNetSourceCreator pNetSourceCreator, 
                       BOOL fEmbeddedInServer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsinternaladminnetsource/nn-wmsinternaladminnetsource-iwmsinternaladminnetsource
    HRESULT GetNetSourceCreator(INSNetSourceCreator* ppNetSourceCreator);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsinternaladminnetsource/nf-wmsinternaladminnetsource-iwmsinternaladminnetsource-setcredentials
    HRESULT SetCredentials(BSTR bstrRealm, BSTR bstrName, BSTR bstrPassword, BOOL fPersist, BOOL fConfirmedGood);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsinternaladminnetsource/nf-wmsinternaladminnetsource-iwmsinternaladminnetsource-getcredentials
    HRESULT GetCredentials(BSTR bstrRealm, BSTR* pbstrName, BSTR* pbstrPassword, BOOL* pfConfirmedGood);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsinternaladminnetsource/nf-wmsinternaladminnetsource-iwmsinternaladminnetsource-deletecredentials
    HRESULT DeleteCredentials(BSTR bstrRealm);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsinternaladminnetsource/nf-wmsinternaladminnetsource-iwmsinternaladminnetsource-getcredentialflags
    HRESULT GetCredentialFlags(uint* lpdwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsinternaladminnetsource/nf-wmsinternaladminnetsource-iwmsinternaladminnetsource-setcredentialflags
    HRESULT SetCredentialFlags(uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsinternaladminnetsource/nf-wmsinternaladminnetsource-iwmsinternaladminnetsource-findproxyforurl
    HRESULT FindProxyForURL(BSTR bstrProtocol, BSTR bstrHost, BOOL* pfProxyEnabled, BSTR* pbstrProxyServer, 
                            uint* pdwProxyPort, uint* pdwProxyContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsinternaladminnetsource/nf-wmsinternaladminnetsource-iwmsinternaladminnetsource-registerproxyfailure
    HRESULT RegisterProxyFailure(HRESULT hrParam, uint dwProxyContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsinternaladminnetsource/nf-wmsinternaladminnetsource-iwmsinternaladminnetsource-shutdownproxycontext
    HRESULT ShutdownProxyContext(uint dwProxyContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsinternaladminnetsource/nn-wmsinternaladminnetsource-iwmsinternaladminnetsource
    HRESULT IsUsingIE(uint dwProxyContext, BOOL* pfIsUsingIE);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsinternaladminnetsource/nn-wmsinternaladminnetsource-iwmsinternaladminnetsource2
@GUID("e74d58c3-cf77-4b51-af17-744687c43eae")
interface IWMSInternalAdminNetSource2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsinternaladminnetsource/nf-wmsinternaladminnetsource-iwmsinternaladminnetsource2-setcredentialsex
    HRESULT SetCredentialsEx(BSTR bstrRealm, BSTR bstrUrl, BOOL fProxy, BSTR bstrName, BSTR bstrPassword, 
                             BOOL fPersist, BOOL fConfirmedGood);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsinternaladminnetsource/nf-wmsinternaladminnetsource-iwmsinternaladminnetsource2-getcredentialsex
    HRESULT GetCredentialsEx(BSTR bstrRealm, BSTR bstrUrl, BOOL fProxy, 
                             NETSOURCE_URLCREDPOLICY_SETTINGS* pdwUrlPolicy, BSTR* pbstrName, BSTR* pbstrPassword, 
                             BOOL* pfConfirmedGood);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsinternaladminnetsource/nf-wmsinternaladminnetsource-iwmsinternaladminnetsource2-deletecredentialsex
    HRESULT DeleteCredentialsEx(BSTR bstrRealm, BSTR bstrUrl, BOOL fProxy);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsinternaladminnetsource/nn-wmsinternaladminnetsource-iwmsinternaladminnetsource2
    HRESULT FindProxyForURLEx(BSTR bstrProtocol, BSTR bstrHost, BSTR bstrUrl, BOOL* pfProxyEnabled, 
                              BSTR* pbstrProxyServer, uint* pdwProxyPort, uint* pdwProxyContext);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsinternaladminnetsource/nn-wmsinternaladminnetsource-iwmsinternaladminnetsource3
@GUID("6b63d08e-4590-44af-9eb3-57ff1e73bf80")
interface IWMSInternalAdminNetSource3 : IWMSInternalAdminNetSource2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsinternaladminnetsource/nn-wmsinternaladminnetsource-iwmsinternaladminnetsource3
    HRESULT GetNetSourceCreator2(IUnknown* ppNetSourceCreator);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsinternaladminnetsource/nf-wmsinternaladminnetsource-iwmsinternaladminnetsource3-findproxyforurlex2
    HRESULT FindProxyForURLEx2(BSTR bstrProtocol, BSTR bstrHost, BSTR bstrUrl, BOOL* pfProxyEnabled, 
                               BSTR* pbstrProxyServer, uint* pdwProxyPort, ulong* pqwProxyContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsinternaladminnetsource/nn-wmsinternaladminnetsource-iwmsinternaladminnetsource3
    HRESULT RegisterProxyFailure2(HRESULT hrParam, ulong qwProxyContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsinternaladminnetsource/nf-wmsinternaladminnetsource-iwmsinternaladminnetsource3-shutdownproxycontext2
    HRESULT ShutdownProxyContext2(ulong qwProxyContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsinternaladminnetsource/nn-wmsinternaladminnetsource-iwmsinternaladminnetsource3
    HRESULT IsUsingIE2(ulong qwProxyContext, BOOL* pfIsUsingIE);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsinternaladminnetsource/nf-wmsinternaladminnetsource-iwmsinternaladminnetsource3-setcredentialsex2
    HRESULT SetCredentialsEx2(BSTR bstrRealm, BSTR bstrUrl, BOOL fProxy, BSTR bstrName, BSTR bstrPassword, 
                              BOOL fPersist, BOOL fConfirmedGood, BOOL fClearTextAuthentication);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmsinternaladminnetsource/nf-wmsinternaladminnetsource-iwmsinternaladminnetsource3-getcredentialsex2
    HRESULT GetCredentialsEx2(BSTR bstrRealm, BSTR bstrUrl, BOOL fProxy, BOOL fClearTextAuthentication, 
                              NETSOURCE_URLCREDPOLICY_SETTINGS* pdwUrlPolicy, BSTR* pbstrName, BSTR* pbstrPassword, 
                              BOOL* pfConfirmedGood);
}


// GUIDs


const GUID IID_INSNetSourceCreator         = GUIDOF!INSNetSourceCreator;
const GUID IID_INSSBuffer                  = GUIDOF!INSSBuffer;
const GUID IID_INSSBuffer2                 = GUIDOF!INSSBuffer2;
const GUID IID_INSSBuffer3                 = GUIDOF!INSSBuffer3;
const GUID IID_INSSBuffer4                 = GUIDOF!INSSBuffer4;
const GUID IID_IWMAddressAccess            = GUIDOF!IWMAddressAccess;
const GUID IID_IWMAddressAccess2           = GUIDOF!IWMAddressAccess2;
const GUID IID_IWMAuthorizer               = GUIDOF!IWMAuthorizer;
const GUID IID_IWMBackupRestoreProps       = GUIDOF!IWMBackupRestoreProps;
const GUID IID_IWMBandwidthSharing         = GUIDOF!IWMBandwidthSharing;
const GUID IID_IWMClientConnections        = GUIDOF!IWMClientConnections;
const GUID IID_IWMClientConnections2       = GUIDOF!IWMClientConnections2;
const GUID IID_IWMCodecInfo                = GUIDOF!IWMCodecInfo;
const GUID IID_IWMCodecInfo2               = GUIDOF!IWMCodecInfo2;
const GUID IID_IWMCodecInfo3               = GUIDOF!IWMCodecInfo3;
const GUID IID_IWMCredentialCallback       = GUIDOF!IWMCredentialCallback;
const GUID IID_IWMDRMEditor                = GUIDOF!IWMDRMEditor;
const GUID IID_IWMDRMMessageParser         = GUIDOF!IWMDRMMessageParser;
const GUID IID_IWMDRMReader                = GUIDOF!IWMDRMReader;
const GUID IID_IWMDRMReader2               = GUIDOF!IWMDRMReader2;
const GUID IID_IWMDRMReader3               = GUIDOF!IWMDRMReader3;
const GUID IID_IWMDRMTranscryptionManager  = GUIDOF!IWMDRMTranscryptionManager;
const GUID IID_IWMDRMTranscryptor          = GUIDOF!IWMDRMTranscryptor;
const GUID IID_IWMDRMTranscryptor2         = GUIDOF!IWMDRMTranscryptor2;
const GUID IID_IWMDRMWriter                = GUIDOF!IWMDRMWriter;
const GUID IID_IWMDRMWriter2               = GUIDOF!IWMDRMWriter2;
const GUID IID_IWMDRMWriter3               = GUIDOF!IWMDRMWriter3;
const GUID IID_IWMDeviceRegistration       = GUIDOF!IWMDeviceRegistration;
const GUID IID_IWMGetSecureChannel         = GUIDOF!IWMGetSecureChannel;
const GUID IID_IWMHeaderInfo               = GUIDOF!IWMHeaderInfo;
const GUID IID_IWMHeaderInfo2              = GUIDOF!IWMHeaderInfo2;
const GUID IID_IWMHeaderInfo3              = GUIDOF!IWMHeaderInfo3;
const GUID IID_IWMIStreamProps             = GUIDOF!IWMIStreamProps;
const GUID IID_IWMImageInfo                = GUIDOF!IWMImageInfo;
const GUID IID_IWMIndexer                  = GUIDOF!IWMIndexer;
const GUID IID_IWMIndexer2                 = GUIDOF!IWMIndexer2;
const GUID IID_IWMInputMediaProps          = GUIDOF!IWMInputMediaProps;
const GUID IID_IWMLanguageList             = GUIDOF!IWMLanguageList;
const GUID IID_IWMLicenseBackup            = GUIDOF!IWMLicenseBackup;
const GUID IID_IWMLicenseRestore           = GUIDOF!IWMLicenseRestore;
const GUID IID_IWMLicenseRevocationAgent   = GUIDOF!IWMLicenseRevocationAgent;
const GUID IID_IWMMediaProps               = GUIDOF!IWMMediaProps;
const GUID IID_IWMMetadataEditor           = GUIDOF!IWMMetadataEditor;
const GUID IID_IWMMetadataEditor2          = GUIDOF!IWMMetadataEditor2;
const GUID IID_IWMMutualExclusion          = GUIDOF!IWMMutualExclusion;
const GUID IID_IWMMutualExclusion2         = GUIDOF!IWMMutualExclusion2;
const GUID IID_IWMOutputMediaProps         = GUIDOF!IWMOutputMediaProps;
const GUID IID_IWMPacketSize               = GUIDOF!IWMPacketSize;
const GUID IID_IWMPacketSize2              = GUIDOF!IWMPacketSize2;
const GUID IID_IWMPlayerHook               = GUIDOF!IWMPlayerHook;
const GUID IID_IWMPlayerTimestampHook      = GUIDOF!IWMPlayerTimestampHook;
const GUID IID_IWMProfile                  = GUIDOF!IWMProfile;
const GUID IID_IWMProfile2                 = GUIDOF!IWMProfile2;
const GUID IID_IWMProfile3                 = GUIDOF!IWMProfile3;
const GUID IID_IWMProfileManager           = GUIDOF!IWMProfileManager;
const GUID IID_IWMProfileManager2          = GUIDOF!IWMProfileManager2;
const GUID IID_IWMProfileManagerLanguage   = GUIDOF!IWMProfileManagerLanguage;
const GUID IID_IWMPropertyVault            = GUIDOF!IWMPropertyVault;
const GUID IID_IWMProximityDetection       = GUIDOF!IWMProximityDetection;
const GUID IID_IWMReader                   = GUIDOF!IWMReader;
const GUID IID_IWMReaderAccelerator        = GUIDOF!IWMReaderAccelerator;
const GUID IID_IWMReaderAdvanced           = GUIDOF!IWMReaderAdvanced;
const GUID IID_IWMReaderAdvanced2          = GUIDOF!IWMReaderAdvanced2;
const GUID IID_IWMReaderAdvanced3          = GUIDOF!IWMReaderAdvanced3;
const GUID IID_IWMReaderAdvanced4          = GUIDOF!IWMReaderAdvanced4;
const GUID IID_IWMReaderAdvanced5          = GUIDOF!IWMReaderAdvanced5;
const GUID IID_IWMReaderAdvanced6          = GUIDOF!IWMReaderAdvanced6;
const GUID IID_IWMReaderAllocatorEx        = GUIDOF!IWMReaderAllocatorEx;
const GUID IID_IWMReaderCallback           = GUIDOF!IWMReaderCallback;
const GUID IID_IWMReaderCallbackAdvanced   = GUIDOF!IWMReaderCallbackAdvanced;
const GUID IID_IWMReaderNetworkConfig      = GUIDOF!IWMReaderNetworkConfig;
const GUID IID_IWMReaderNetworkConfig2     = GUIDOF!IWMReaderNetworkConfig2;
const GUID IID_IWMReaderPlaylistBurn       = GUIDOF!IWMReaderPlaylistBurn;
const GUID IID_IWMReaderStreamClock        = GUIDOF!IWMReaderStreamClock;
const GUID IID_IWMReaderTimecode           = GUIDOF!IWMReaderTimecode;
const GUID IID_IWMReaderTypeNegotiation    = GUIDOF!IWMReaderTypeNegotiation;
const GUID IID_IWMRegisterCallback         = GUIDOF!IWMRegisterCallback;
const GUID IID_IWMRegisteredDevice         = GUIDOF!IWMRegisteredDevice;
const GUID IID_IWMSBufferAllocator         = GUIDOF!IWMSBufferAllocator;
const GUID IID_IWMSInternalAdminNetSource  = GUIDOF!IWMSInternalAdminNetSource;
const GUID IID_IWMSInternalAdminNetSource2 = GUIDOF!IWMSInternalAdminNetSource2;
const GUID IID_IWMSInternalAdminNetSource3 = GUIDOF!IWMSInternalAdminNetSource3;
const GUID IID_IWMSecureChannel            = GUIDOF!IWMSecureChannel;
const GUID IID_IWMStatusCallback           = GUIDOF!IWMStatusCallback;
const GUID IID_IWMStreamConfig             = GUIDOF!IWMStreamConfig;
const GUID IID_IWMStreamConfig2            = GUIDOF!IWMStreamConfig2;
const GUID IID_IWMStreamConfig3            = GUIDOF!IWMStreamConfig3;
const GUID IID_IWMStreamList               = GUIDOF!IWMStreamList;
const GUID IID_IWMStreamPrioritization     = GUIDOF!IWMStreamPrioritization;
const GUID IID_IWMSyncReader               = GUIDOF!IWMSyncReader;
const GUID IID_IWMSyncReader2              = GUIDOF!IWMSyncReader2;
const GUID IID_IWMVideoMediaProps          = GUIDOF!IWMVideoMediaProps;
const GUID IID_IWMWatermarkInfo            = GUIDOF!IWMWatermarkInfo;
const GUID IID_IWMWriter                   = GUIDOF!IWMWriter;
const GUID IID_IWMWriterAdvanced           = GUIDOF!IWMWriterAdvanced;
const GUID IID_IWMWriterAdvanced2          = GUIDOF!IWMWriterAdvanced2;
const GUID IID_IWMWriterAdvanced3          = GUIDOF!IWMWriterAdvanced3;
const GUID IID_IWMWriterFileSink           = GUIDOF!IWMWriterFileSink;
const GUID IID_IWMWriterFileSink2          = GUIDOF!IWMWriterFileSink2;
const GUID IID_IWMWriterFileSink3          = GUIDOF!IWMWriterFileSink3;
const GUID IID_IWMWriterNetworkSink        = GUIDOF!IWMWriterNetworkSink;
const GUID IID_IWMWriterPostView           = GUIDOF!IWMWriterPostView;
const GUID IID_IWMWriterPostViewCallback   = GUIDOF!IWMWriterPostViewCallback;
const GUID IID_IWMWriterPreprocess         = GUIDOF!IWMWriterPreprocess;
const GUID IID_IWMWriterPushSink           = GUIDOF!IWMWriterPushSink;
const GUID IID_IWMWriterSink               = GUIDOF!IWMWriterSink;
