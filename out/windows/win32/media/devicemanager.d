// Written in the D programming language.

module windows.win32.media.devicemanager;

public import windows.core;
public import system.system : Guid;
public import windows.win32.foundation.foundation : BOOL, HRESULT, PSTR, PWSTR;
public import windows.win32.media.audio.audio : WAVEFORMATEX;
public import windows.win32.media.mediafoundation : VIDEOINFOHEADER;
public import windows.win32.system.com.com : IUnknown;
public import windows.win32.system.com.structuredstorage : PROPVARIANT;
public import windows.win32.system.ole : ISpecifyPropertyPages;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/WMDM/wmdm-tag-datatype
alias WMDM_TAG_DATATYPE = int;
enum : int
{
    WMDM_TYPE_DWORD  = 0x00000000,
    WMDM_TYPE_STRING = 0x00000001,
    WMDM_TYPE_BINARY = 0x00000002,
    WMDM_TYPE_BOOL   = 0x00000003,
    WMDM_TYPE_QWORD  = 0x00000004,
    WMDM_TYPE_WORD   = 0x00000005,
    WMDM_TYPE_GUID   = 0x00000006,
    WMDM_TYPE_DATE   = 0x00000007,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/WMDM/wmdm-session-type
alias WMDM_SESSION_TYPE = int;
enum : int
{
    WMDM_SESSION_NONE                 = 0x00000000,
    WMDM_SESSION_TRANSFER_TO_DEVICE   = 0x00000001,
    WMDM_SESSION_TRANSFER_FROM_DEVICE = 0x00000010,
    WMDM_SESSION_DELETE               = 0x00000100,
    WMDM_SESSION_CUSTOM               = 0x00001000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/WMDM/wmdm-storage-enum-mode
alias WMDM_STORAGE_ENUM_MODE = int;
enum : int
{
    ENUM_MODE_RAW             = 0x00000000,
    ENUM_MODE_USE_DEVICE_PREF = 0x00000001,
    ENUM_MODE_METADATA_VIEWS  = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/WMDM/wmdm-formatcode
alias WMDM_FORMATCODE = int;
enum : int
{
    WMDM_FORMATCODE_NOTUSED                     = 0x00000000,
    WMDM_FORMATCODE_ALLIMAGES                   = 0xffffffff,
    WMDM_FORMATCODE_UNDEFINED                   = 0x00003000,
    WMDM_FORMATCODE_ASSOCIATION                 = 0x00003001,
    WMDM_FORMATCODE_SCRIPT                      = 0x00003002,
    WMDM_FORMATCODE_EXECUTABLE                  = 0x00003003,
    WMDM_FORMATCODE_TEXT                        = 0x00003004,
    WMDM_FORMATCODE_HTML                        = 0x00003005,
    WMDM_FORMATCODE_DPOF                        = 0x00003006,
    WMDM_FORMATCODE_AIFF                        = 0x00003007,
    WMDM_FORMATCODE_WAVE                        = 0x00003008,
    WMDM_FORMATCODE_MP3                         = 0x00003009,
    WMDM_FORMATCODE_AVI                         = 0x0000300a,
    WMDM_FORMATCODE_MPEG                        = 0x0000300b,
    WMDM_FORMATCODE_ASF                         = 0x0000300c,
    WMDM_FORMATCODE_RESERVED_FIRST              = 0x0000300d,
    WMDM_FORMATCODE_RESERVED_LAST               = 0x000037ff,
    WMDM_FORMATCODE_IMAGE_UNDEFINED             = 0x00003800,
    WMDM_FORMATCODE_IMAGE_EXIF                  = 0x00003801,
    WMDM_FORMATCODE_IMAGE_TIFFEP                = 0x00003802,
    WMDM_FORMATCODE_IMAGE_FLASHPIX              = 0x00003803,
    WMDM_FORMATCODE_IMAGE_BMP                   = 0x00003804,
    WMDM_FORMATCODE_IMAGE_CIFF                  = 0x00003805,
    WMDM_FORMATCODE_IMAGE_GIF                   = 0x00003807,
    WMDM_FORMATCODE_IMAGE_JFIF                  = 0x00003808,
    WMDM_FORMATCODE_IMAGE_PCD                   = 0x00003809,
    WMDM_FORMATCODE_IMAGE_PICT                  = 0x0000380a,
    WMDM_FORMATCODE_IMAGE_PNG                   = 0x0000380b,
    WMDM_FORMATCODE_IMAGE_TIFF                  = 0x0000380d,
    WMDM_FORMATCODE_IMAGE_TIFFIT                = 0x0000380e,
    WMDM_FORMATCODE_IMAGE_JP2                   = 0x0000380f,
    WMDM_FORMATCODE_IMAGE_JPX                   = 0x00003810,
    WMDM_FORMATCODE_IMAGE_RESERVED_FIRST        = 0x00003811,
    WMDM_FORMATCODE_IMAGE_RESERVED_LAST         = 0x00003fff,
    WMDM_FORMATCODE_UNDEFINEDFIRMWARE           = 0x0000b802,
    WMDM_FORMATCODE_WBMP                        = 0x0000b803,
    WMDM_FORMATCODE_JPEGXR                      = 0x0000b804,
    WMDM_FORMATCODE_WINDOWSIMAGEFORMAT          = 0x0000b881,
    WMDM_FORMATCODE_UNDEFINEDAUDIO              = 0x0000b900,
    WMDM_FORMATCODE_WMA                         = 0x0000b901,
    WMDM_FORMATCODE_OGG                         = 0x0000b902,
    WMDM_FORMATCODE_AAC                         = 0x0000b903,
    WMDM_FORMATCODE_AUDIBLE                     = 0x0000b904,
    WMDM_FORMATCODE_FLAC                        = 0x0000b906,
    WMDM_FORMATCODE_QCELP                       = 0x0000b907,
    WMDM_FORMATCODE_AMR                         = 0x0000b908,
    WMDM_FORMATCODE_UNDEFINEDVIDEO              = 0x0000b980,
    WMDM_FORMATCODE_WMV                         = 0x0000b981,
    WMDM_FORMATCODE_MP4                         = 0x0000b982,
    WMDM_FORMATCODE_MP2                         = 0x0000b983,
    WMDM_FORMATCODE_3GP                         = 0x0000b984,
    WMDM_FORMATCODE_3G2                         = 0x0000b985,
    WMDM_FORMATCODE_AVCHD                       = 0x0000b986,
    WMDM_FORMATCODE_ATSCTS                      = 0x0000b987,
    WMDM_FORMATCODE_DVBTS                       = 0x0000b988,
    WMDM_FORMATCODE_MKV                         = 0x0000b989,
    WMDM_FORMATCODE_MKA                         = 0x0000b98a,
    WMDM_FORMATCODE_MK3D                        = 0x0000b98b,
    WMDM_FORMATCODE_UNDEFINEDCOLLECTION         = 0x0000ba00,
    WMDM_FORMATCODE_ABSTRACTMULTIMEDIAALBUM     = 0x0000ba01,
    WMDM_FORMATCODE_ABSTRACTIMAGEALBUM          = 0x0000ba02,
    WMDM_FORMATCODE_ABSTRACTAUDIOALBUM          = 0x0000ba03,
    WMDM_FORMATCODE_ABSTRACTVIDEOALBUM          = 0x0000ba04,
    WMDM_FORMATCODE_ABSTRACTAUDIOVIDEOPLAYLIST  = 0x0000ba05,
    WMDM_FORMATCODE_ABSTRACTCONTACTGROUP        = 0x0000ba06,
    WMDM_FORMATCODE_ABSTRACTMESSAGEFOLDER       = 0x0000ba07,
    WMDM_FORMATCODE_ABSTRACTCHAPTEREDPRODUCTION = 0x0000ba08,
    WMDM_FORMATCODE_MEDIA_CAST                  = 0x0000ba0b,
    WMDM_FORMATCODE_WPLPLAYLIST                 = 0x0000ba10,
    WMDM_FORMATCODE_M3UPLAYLIST                 = 0x0000ba11,
    WMDM_FORMATCODE_MPLPLAYLIST                 = 0x0000ba12,
    WMDM_FORMATCODE_ASXPLAYLIST                 = 0x0000ba13,
    WMDM_FORMATCODE_PLSPLAYLIST                 = 0x0000ba14,
    WMDM_FORMATCODE_UNDEFINEDDOCUMENT           = 0x0000ba80,
    WMDM_FORMATCODE_ABSTRACTDOCUMENT            = 0x0000ba81,
    WMDM_FORMATCODE_XMLDOCUMENT                 = 0x0000ba82,
    WMDM_FORMATCODE_MICROSOFTWORDDOCUMENT       = 0x0000ba83,
    WMDM_FORMATCODE_MHTCOMPILEDHTMLDOCUMENT     = 0x0000ba84,
    WMDM_FORMATCODE_MICROSOFTEXCELSPREADSHEET   = 0x0000ba85,
    WMDM_FORMATCODE_MICROSOFTPOWERPOINTDOCUMENT = 0x0000ba86,
    WMDM_FORMATCODE_UNDEFINEDMESSAGE            = 0x0000bb00,
    WMDM_FORMATCODE_ABSTRACTMESSAGE             = 0x0000bb01,
    WMDM_FORMATCODE_UNDEFINEDCONTACT            = 0x0000bb80,
    WMDM_FORMATCODE_ABSTRACTCONTACT             = 0x0000bb81,
    WMDM_FORMATCODE_VCARD2                      = 0x0000bb82,
    WMDM_FORMATCODE_VCARD3                      = 0x0000bb83,
    WMDM_FORMATCODE_UNDEFINEDCALENDARITEM       = 0x0000be00,
    WMDM_FORMATCODE_ABSTRACTCALENDARITEM        = 0x0000be01,
    WMDM_FORMATCODE_VCALENDAR1                  = 0x0000be02,
    WMDM_FORMATCODE_VCALENDAR2                  = 0x0000be03,
    WMDM_FORMATCODE_UNDEFINEDWINDOWSEXECUTABLE  = 0x0000be80,
    WMDM_FORMATCODE_M4A                         = 0x4d503441,
    WMDM_FORMATCODE_3GPA                        = 0x33475041,
    WMDM_FORMATCODE_3G2A                        = 0x33473241,
    WMDM_FORMATCODE_SECTION                     = 0x0000be82,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/WMDM/wmdm-enum-prop-valid-values-form
alias WMDM_ENUM_PROP_VALID_VALUES_FORM = int;
enum : int
{
    WMDM_ENUM_PROP_VALID_VALUES_ANY   = 0x00000000,
    WMDM_ENUM_PROP_VALID_VALUES_RANGE = 0x00000001,
    WMDM_ENUM_PROP_VALID_VALUES_ENUM  = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/WMDM/wmdm-find-scope
alias WMDM_FIND_SCOPE = int;
enum : int
{
    WMDM_FIND_SCOPE_GLOBAL             = 0x00000000,
    WMDM_FIND_SCOPE_IMMEDIATE_CHILDREN = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/WMDM/wmdmmessage
enum WMDMMessage : int
{
    WMDM_MSG_DEVICE_ARRIVAL = 0x00000000,
    WMDM_MSG_DEVICE_REMOVAL = 0x00000001,
    WMDM_MSG_MEDIA_ARRIVAL  = 0x00000002,
    WMDM_MSG_MEDIA_REMOVAL  = 0x00000003,
}

// Constants


enum uint IOCTL_MTP_CUSTOM_COMMAND = 0x3150544dU;

enum : uint
{
    MTP_NEXTPHASE_READ_DATA  = 0x00000001U,
    MTP_NEXTPHASE_WRITE_DATA = 0x00000002U,
    MTP_NEXTPHASE_NO_DATA    = 0x00000003U,
}

enum uint RSA_KEY_LEN = 0x00000040U;
enum uint SAC_SESSION_KEYLEN = 0x00000008U;

enum : uint
{
    SAC_PROTOCOL_WMDM = 0x00000001U,
    SAC_PROTOCOL_V1   = 0x00000002U,
}

enum : uint
{
    SAC_CERT_X509 = 0x00000001U,
    SAC_CERT_V1   = 0x00000002U,
}

enum : GUID
{
    WMDM_DEVICE_PROTOCOL_MTP  = GUID("979e54e5-0afc-4604-8d93-dc798a4bcf45"),
    WMDM_DEVICE_PROTOCOL_RAPI = GUID("2a11ed91-8c8f-41e4-82d1-8386e003561c"),
    WMDM_DEVICE_PROTOCOL_MSC  = GUID("a4d2c26c-a881-44bb-bd5d-1f703c71f7a9"),
}

enum GUID WMDM_SERVICE_PROVIDER_VENDOR_MICROSOFT = GUID("7de8686d-78ee-43ea-a496-c625ac91cc5d");
enum uint WMDMID_LENGTH = 0x00000080U;
enum uint WMDM_MAC_LENGTH = 0x00000008U;

enum : int
{
    WMDM_S_NOT_ALL_PROPERTIES_APPLIED   = 0x00045001,
    WMDM_S_NOT_ALL_PROPERTIES_RETRIEVED = 0x00045002,
}

enum : int
{
    WMDM_E_BUSY          = 0x80045000,
    WMDM_E_INTERFACEDEAD = 0x80045001,
    WMDM_E_INVALIDTYPE   = 0x80045002,
}

enum int WMDM_E_PROCESSFAILED = 0x80045003;

enum : int
{
    WMDM_E_NOTSUPPORTED         = 0x80045004,
    WMDM_E_NOTCERTIFIED         = 0x80045005,
    WMDM_E_NORIGHTS             = 0x80045006,
    WMDM_E_CALL_OUT_OF_SEQUENCE = 0x80045007,
}

enum int WMDM_E_BUFFERTOOSMALL = 0x80045008;

enum : int
{
    WMDM_E_MOREDATA         = 0x80045009,
    WMDM_E_MAC_CHECK_FAILED = 0x8004500a,
}

enum int WMDM_E_USER_CANCELLED = 0x8004500b;

enum : int
{
    WMDM_E_SDMI_TRIGGER      = 0x8004500c,
    WMDM_E_SDMI_NOMORECOPIES = 0x8004500d,
}

enum : int
{
    WMDM_E_REVOKED          = 0x8004500e,
    WMDM_E_LICENSE_NOTEXIST = 0x8004500f,
}

enum : int
{
    WMDM_E_INCORRECT_APPSEC = 0x80045010,
    WMDM_E_INCORRECT_RIGHTS = 0x80045011,
}

enum int WMDM_E_LICENSE_EXPIRED = 0x80045012;
enum int WMDM_E_CANTOPEN_PMSN_SERVICE_PIPE = 0x80045013;
enum int WMDM_E_TOO_MANY_SESSIONS = 0x80045013;
enum uint WMDM_WMDM_REVOKED = 0x00000001U;
enum uint WMDM_APP_REVOKED = 0x00000002U;
enum uint WMDM_SP_REVOKED = 0x00000004U;
enum uint WMDM_SCP_REVOKED = 0x00000008U;

enum : uint
{
    WMDM_GET_FORMAT_SUPPORT_AUDIO = 0x00000001U,
    WMDM_GET_FORMAT_SUPPORT_VIDEO = 0x00000002U,
    WMDM_GET_FORMAT_SUPPORT_FILE  = 0x00000004U,
}

enum : uint
{
    WMDM_RIGHTS_PLAYBACKCOUNT  = 0x00000001U,
    WMDM_RIGHTS_EXPIRATIONDATE = 0x00000002U,
    WMDM_RIGHTS_GROUPID        = 0x00000004U,
    WMDM_RIGHTS_FREESERIALIDS  = 0x00000008U,
    WMDM_RIGHTS_NAMEDSERIALIDS = 0x00000010U,
}

enum : uint
{
    WMDM_DEVICE_TYPE_PLAYBACK               = 0x00000001U,
    WMDM_DEVICE_TYPE_RECORD                 = 0x00000002U,
    WMDM_DEVICE_TYPE_DECODE                 = 0x00000004U,
    WMDM_DEVICE_TYPE_ENCODE                 = 0x00000008U,
    WMDM_DEVICE_TYPE_STORAGE                = 0x00000010U,
    WMDM_DEVICE_TYPE_VIRTUAL                = 0x00000020U,
    WMDM_DEVICE_TYPE_SDMI                   = 0x00000040U,
    WMDM_DEVICE_TYPE_NONSDMI                = 0x00000080U,
    WMDM_DEVICE_TYPE_NONREENTRANT           = 0x00000100U,
    WMDM_DEVICE_TYPE_FILELISTRESYNC         = 0x00000200U,
    WMDM_DEVICE_TYPE_VIEW_PREF_METADATAVIEW = 0x00000400U,
}

enum : uint
{
    WMDM_POWER_CAP_BATTERY       = 0x00000001U,
    WMDM_POWER_CAP_EXTERNAL      = 0x00000002U,
    WMDM_POWER_IS_BATTERY        = 0x00000004U,
    WMDM_POWER_IS_EXTERNAL       = 0x00000008U,
    WMDM_POWER_PERCENT_AVAILABLE = 0x00000010U,
}

enum : uint
{
    WMDM_STATUS_READY                   = 0x00000001U,
    WMDM_STATUS_BUSY                    = 0x00000002U,
    WMDM_STATUS_DEVICE_NOTPRESENT       = 0x00000004U,
    WMDM_STATUS_DEVICECONTROL_PLAYING   = 0x00000008U,
    WMDM_STATUS_DEVICECONTROL_RECORDING = 0x00000010U,
    WMDM_STATUS_DEVICECONTROL_PAUSED    = 0x00000020U,
    WMDM_STATUS_DEVICECONTROL_REMOTE    = 0x00000040U,
    WMDM_STATUS_DEVICECONTROL_STREAM    = 0x00000080U,
}

enum : uint
{
    WMDM_STATUS_STORAGE_NOTPRESENT       = 0x00000100U,
    WMDM_STATUS_STORAGE_INITIALIZING     = 0x00000200U,
    WMDM_STATUS_STORAGE_BROKEN           = 0x00000400U,
    WMDM_STATUS_STORAGE_NOTSUPPORTED     = 0x00000800U,
    WMDM_STATUS_STORAGE_UNFORMATTED      = 0x00001000U,
    WMDM_STATUS_STORAGECONTROL_INSERTING = 0x00002000U,
    WMDM_STATUS_STORAGECONTROL_DELETING  = 0x00004000U,
    WMDM_STATUS_STORAGECONTROL_APPENDING = 0x00008000U,
    WMDM_STATUS_STORAGECONTROL_MOVING    = 0x00010000U,
    WMDM_STATUS_STORAGECONTROL_READING   = 0x00020000U,
}

enum : uint
{
    WMDM_DEVICECAP_CANPLAY         = 0x00000001U,
    WMDM_DEVICECAP_CANSTREAMPLAY   = 0x00000002U,
    WMDM_DEVICECAP_CANRECORD       = 0x00000004U,
    WMDM_DEVICECAP_CANSTREAMRECORD = 0x00000008U,
    WMDM_DEVICECAP_CANPAUSE        = 0x00000010U,
    WMDM_DEVICECAP_CANRESUME       = 0x00000020U,
    WMDM_DEVICECAP_CANSTOP         = 0x00000040U,
    WMDM_DEVICECAP_CANSEEK         = 0x00000080U,
    WMDM_DEVICECAP_HASSECURECLOCK  = 0x00000100U,
}

enum : uint
{
    WMDM_SEEK_REMOTECONTROL  = 0x00000001U,
    WMDM_SEEK_STREAMINGAUDIO = 0x00000002U,
}

enum : uint
{
    WMDM_STORAGE_ATTR_FILESYSTEM   = 0x00000001U,
    WMDM_STORAGE_ATTR_REMOVABLE    = 0x00000002U,
    WMDM_STORAGE_ATTR_NONREMOVABLE = 0x00000004U,
}

enum : uint
{
    WMDM_FILE_ATTR_FOLDER = 0x00000008U,
    WMDM_FILE_ATTR_LINK   = 0x00000010U,
    WMDM_FILE_ATTR_FILE   = 0x00000020U,
    WMDM_FILE_ATTR_VIDEO  = 0x00000040U,
}

enum : uint
{
    WMDM_STORAGE_ATTR_CANEDITMETADATA = 0x00000080U,
    WMDM_STORAGE_ATTR_FOLDERS         = 0x00000100U,
}

enum : uint
{
    WMDM_FILE_ATTR_AUDIO       = 0x00001000U,
    WMDM_FILE_ATTR_DATA        = 0x00002000U,
    WMDM_FILE_ATTR_CANPLAY     = 0x00004000U,
    WMDM_FILE_ATTR_CANDELETE   = 0x00008000U,
    WMDM_FILE_ATTR_CANMOVE     = 0x00010000U,
    WMDM_FILE_ATTR_CANRENAME   = 0x00020000U,
    WMDM_FILE_ATTR_CANREAD     = 0x00040000U,
    WMDM_FILE_ATTR_MUSIC       = 0x00080000U,
    WMDM_FILE_CREATE_OVERWRITE = 0x00100000U,
}

enum : uint
{
    WMDM_FILE_ATTR_AUDIOBOOK = 0x00200000U,
    WMDM_FILE_ATTR_HIDDEN    = 0x00400000U,
    WMDM_FILE_ATTR_SYSTEM    = 0x00800000U,
    WMDM_FILE_ATTR_READONLY  = 0x01000000U,
}

enum : uint
{
    WMDM_STORAGE_ATTR_HAS_FOLDERS     = 0x02000000U,
    WMDM_STORAGE_ATTR_HAS_FILES       = 0x04000000U,
    WMDM_STORAGE_IS_DEFAULT           = 0x08000000U,
    WMDM_STORAGE_CONTAINS_DEFAULT     = 0x10000000U,
    WMDM_STORAGE_ATTR_VIRTUAL         = 0x20000000U,
    WMDM_STORAGECAP_FOLDERSINROOT     = 0x00000001U,
    WMDM_STORAGECAP_FILESINROOT       = 0x00000002U,
    WMDM_STORAGECAP_FOLDERSINFOLDERS  = 0x00000004U,
    WMDM_STORAGECAP_FILESINFOLDERS    = 0x00000008U,
    WMDM_STORAGECAP_FOLDERLIMITEXISTS = 0x00000010U,
    WMDM_STORAGECAP_FILELIMITEXISTS   = 0x00000020U,
    WMDM_STORAGECAP_NOT_INITIALIZABLE = 0x00000040U,
}

enum : uint
{
    WMDM_MODE_BLOCK  = 0x00000001U,
    WMDM_MODE_THREAD = 0x00000002U,
}

enum : uint
{
    WMDM_CONTENT_FILE               = 0x00000004U,
    WMDM_CONTENT_FOLDER             = 0x00000008U,
    WMDM_CONTENT_OPERATIONINTERFACE = 0x00000010U,
}

enum : uint
{
    WMDM_MODE_QUERY                = 0x00000020U,
    WMDM_MODE_PROGRESS             = 0x00000040U,
    WMDM_MODE_TRANSFER_PROTECTED   = 0x00000080U,
    WMDM_MODE_TRANSFER_UNPROTECTED = 0x00000100U,
}

enum : uint
{
    WMDM_STORAGECONTROL_INSERTBEFORE = 0x00000200U,
    WMDM_STORAGECONTROL_INSERTAFTER  = 0x00000400U,
    WMDM_STORAGECONTROL_INSERTINTO   = 0x00000800U,
}

enum uint WMDM_MODE_RECURSIVE = 0x00001000U;

enum : uint
{
    WMDM_RIGHTS_PLAY_ON_PC              = 0x00000001U,
    WMDM_RIGHTS_COPY_TO_NON_SDMI_DEVICE = 0x00000002U,
    WMDM_RIGHTS_COPY_TO_CD              = 0x00000008U,
    WMDM_RIGHTS_COPY_TO_SDMI_DEVICE     = 0x00000010U,
}

enum : uint
{
    WMDM_SEEK_BEGIN   = 0x00000001U,
    WMDM_SEEK_CURRENT = 0x00000002U,
    WMDM_SEEK_END     = 0x00000008U,
}

enum uint DO_NOT_VIRTUALIZE_STORAGES_AS_DEVICES = 0x00000001U;
enum uint ALLOW_OUTOFBAND_NOTIFICATION = 0x00000002U;

enum : uint
{
    MDSP_READ     = 0x00000001U,
    MDSP_WRITE    = 0x00000002U,
    MDSP_SEEK_BOF = 0x00000001U,
    MDSP_SEEK_CUR = 0x00000002U,
    MDSP_SEEK_EOF = 0x00000004U,
}

enum : int
{
    WMDM_SCP_EXAMINE_EXTENSION = 0x00000001,
    WMDM_SCP_EXAMINE_DATA      = 0x00000002,
    WMDM_SCP_DECIDE_DATA       = 0x00000008,
    WMDM_SCP_PROTECTED_OUTPUT  = 0x00000010,
}

enum int WMDM_SCP_UNPROTECTED_OUTPUT = 0x00000020;

enum : int
{
    WMDM_SCP_RIGHTS_DATA         = 0x00000040,
    WMDM_SCP_TRANSFER_OBJECTDATA = 0x00000020,
}

enum int WMDM_SCP_NO_MORE_CHANGES = 0x00000040;

enum : int
{
    WMDM_SCP_DRMINFO_NOT_DRMPROTECTED = 0x00000000,
    WMDM_SCP_DRMINFO_V1HEADER         = 0x00000001,
    WMDM_SCP_DRMINFO_V2HEADER         = 0x00000002,
}

enum : GUID
{
    SCP_EVENTID_ACQSECURECLOCK = GUID("86248cc9-4a59-43e2-9146-48a7f3f4140c"),
    SCP_EVENTID_NEEDTOINDIV    = GUID("87a507c7-b469-4386-b976-d5d1ce538a6f"),
    SCP_EVENTID_DRMINFO        = GUID("213dd287-41d2-432b-9e3f-3b4f7b3581dd"),
}

enum GUID SCP_PARAMID_DRMVERSION = GUID("41d0155d-7cc7-4217-ada9-005074624da4");
enum uint SAC_MAC_LEN = 0x00000008U;

enum : uint
{
    WMDM_LOG_SEV_INFO    = 0x00000001U,
    WMDM_LOG_SEV_WARN    = 0x00000002U,
    WMDM_LOG_SEV_ERROR   = 0x00000004U,
    WMDM_LOG_NOTIMESTAMP = 0x00000010U,
}

enum : const(wchar)*
{
    g_wszWMDMFileName         = "WMDM/FileName",
    g_wszWMDMFormatCode       = "WMDM/FormatCode",
    g_wszWMDMLastModifiedDate = "WMDM/LastModifiedDate",
}

enum : const(wchar)*
{
    g_wszWMDMFileCreationDate = "WMDM/FileCreationDate",
    g_wszWMDMFileSize         = "WMDM/FileSize",
    g_wszWMDMFileAttributes   = "WMDM/FileAttributes",
}

enum const(wchar)* g_wszAudioWAVECodec = "WMDM/AudioWAVECodec";
enum const(wchar)* g_wszVideoFourCCCodec = "WMDM/VideoFourCCCodec";

enum : const(wchar)*
{
    g_wszWMDMTitle              = "WMDM/Title",
    g_wszWMDMAuthor             = "WMDM/Author",
    g_wszWMDMDescription        = "WMDM/Description",
    g_wszWMDMIsProtected        = "WMDM/IsProtected",
    g_wszWMDMAlbumTitle         = "WMDM/AlbumTitle",
    g_wszWMDMAlbumArtist        = "WMDM/AlbumArtist",
    g_wszWMDMTrack              = "WMDM/Track",
    g_wszWMDMGenre              = "WMDM/Genre",
    g_wszWMDMTrackMood          = "WMDM/TrackMood",
    g_wszWMDMAlbumCoverFormat   = "WMDM/AlbumCoverFormat",
    g_wszWMDMAlbumCoverSize     = "WMDM/AlbumCoverSize",
    g_wszWMDMAlbumCoverHeight   = "WMDM/AlbumCoverHeight",
    g_wszWMDMAlbumCoverWidth    = "WMDM/AlbumCoverWidth",
    g_wszWMDMAlbumCoverDuration = "WMDM/AlbumCoverDuration",
    g_wszWMDMAlbumCoverData     = "WMDM/AlbumCoverData",
}

enum : const(wchar)*
{
    g_wszWMDMYear           = "WMDM/Year",
    g_wszWMDMComposer       = "WMDM/Composer",
    g_wszWMDMCodec          = "WMDM/Codec",
    g_wszWMDMDRMId          = "WMDM/DRMId",
    g_wszWMDMBitrate        = "WMDM/Bitrate",
    g_wszWMDMBitRateType    = "WMDM/BitRateType",
    g_wszWMDMSampleRate     = "WMDM/SampleRate",
    g_wszWMDMNumChannels    = "WMDM/NumChannels",
    g_wszWMDMBlockAlignment = "WMDM/BlockAlignment",
}

enum : const(wchar)*
{
    g_wszWMDMAudioBitDepth    = "WMDM/AudioBitDepth",
    g_wszWMDMTotalBitrate     = "WMDM/TotalBitrate",
    g_wszWMDMVideoBitrate     = "WMDM/VideoBitrate",
    g_wszWMDMFrameRate        = "WMDM/FrameRate",
    g_wszWMDMScanType         = "WMDM/ScanType",
    g_wszWMDMKeyFrameDistance = "WMDM/KeyFrameDistance",
}

enum : const(wchar)*
{
    g_wszWMDMBufferSize     = "WMDM/BufferSize",
    g_wszWMDMQualitySetting = "WMDM/QualitySetting",
}

enum const(wchar)* g_wszWMDMEncodingProfile = "WMDM/EncodingProfile";

enum : const(wchar)*
{
    g_wszWMDMDuration           = "WMDM/Duration",
    g_wszWMDMAlbumArt           = "WMDM/AlbumArt",
    g_wszWMDMBuyNow             = "WMDM/BuyNow",
    g_wszWMDMNonConsumable      = "WMDM/NonConsumable",
    g_wszWMDMediaClassPrimaryID = "WMDM/MediaClassPrimaryID",
}

enum const(wchar)* g_wszWMDMMediaClassSecondaryID = "WMDM/MediaClassSecondaryID";

enum : const(wchar)*
{
    g_wszWMDMUserEffectiveRating = "WMDM/UserEffectiveRating",
    g_wszWMDMUserRating          = "WMDM/UserRating",
    g_wszWMDMUserRatingOnDevice  = "WMDM/UserRatingOnDevice",
}

enum : const(wchar)*
{
    g_wszWMDMPlayCount       = "WMDM/PlayCount",
    g_wszWMDMDevicePlayCount = "WMDM/DevicePlayCount",
}

enum : const(wchar)*
{
    g_wszWMDMAuthorDate       = "WMDM/AuthorDate",
    g_wszWMDMUserLastPlayTime = "WMDM/UserLastPlayTime",
}

enum : const(wchar)*
{
    g_wszWMDMSubTitle            = "WMDM/SubTitle",
    g_wszWMDMSubTitleDescription = "WMDM/SubTitleDescription",
}

enum : const(wchar)*
{
    g_wszWMDMMediaCredits                   = "WMDM/MediaCredits",
    g_wszWMDMMediaStationName               = "WMDM/MediaStationName",
    g_wszWMDMMediaOriginalChannel           = "WMDM/MediaOriginalChannel",
    g_wszWMDMMediaOriginalBroadcastDateTime = "WMDM/MediaOriginalBroadcastDateTime",
}

enum const(wchar)* g_wszWMDMProviderCopyright = "WMDM/ProviderCopyright";

enum : const(wchar)*
{
    g_wszWMDMSyncID             = "WMDM/SyncID",
    g_wszWMDMPersistentUniqueID = "WMDM/PersistentUniqueID",
}

enum : const(wchar)*
{
    g_wszWMDMWidth          = "WMDM/Width",
    g_wszWMDMHeight         = "WMDM/Height",
    g_wszWMDMSyncTime       = "WMDM/SyncTime",
    g_wszWMDMParentalRating = "WMDM/ParentalRating",
}

enum : const(wchar)*
{
    g_wszWMDMMetaGenre                 = "WMDM/MetaGenre",
    g_wszWMDMIsRepeat                  = "WMDM/IsRepeat",
    g_wszWMDMSupportedDeviceProperties = "WMDM/SupportedDeviceProperties",
}

enum const(wchar)* g_wszWMDMDeviceFriendlyName = "WMDM/DeviceFriendlyName";

enum : const(wchar)*
{
    g_wszWMDMFormatsSupported           = "WMDM/FormatsSupported",
    g_wszWMDMFormatsSupportedAreOrdered = "WMDM/FormatsSupportedAreOrdered",
}

enum const(wchar)* g_wszWMDMSyncRelationshipID = "WMDM/SyncRelationshipID";

enum : const(wchar)*
{
    g_wszWMDMDeviceModelName             = "WMDM/DeviceModelName",
    g_wszWMDMDeviceFirmwareVersion       = "WMDM/DeviceFirmwareVersion",
    g_wszWMDMDeviceVendorExtension       = "WMDM/DeviceVendorExtension",
    g_wszWMDMDeviceProtocol              = "WMDM/DeviceProtocol",
    g_wszWMDMDeviceServiceProviderVendor = "WMDM/DeviceServiceProviderVendor",
    g_wszWMDMDeviceRevocationInfo        = "WMDM/DeviceRevocationInfo",
}

enum : const(wchar)*
{
    g_wszWMDMCollectionID   = "WMDM/CollectionID",
    g_wszWMDMOwner          = "WMDM/Owner",
    g_wszWMDMEditor         = "WMDM/Editor",
    g_wszWMDMWebmaster      = "WMDM/Webmaster",
    g_wszWMDMSourceURL      = "WMDM/SourceURL",
    g_wszWMDMDestinationURL = "WMDM/DestinationURL",
}

enum : const(wchar)*
{
    g_wszWMDMCategory       = "WMDM/Category",
    g_wszWMDMTimeBookmark   = "WMDM/TimeBookmark",
    g_wszWMDMObjectBookmark = "WMDM/ObjectBookmark",
}

enum : const(wchar)*
{
    g_wszWMDMByteBookmark = "WMDM/ByteBookmark",
    g_wszWMDMDataOffset   = "WMDM/DataOffset",
    g_wszWMDMDataLength   = "WMDM/DataLength",
    g_wszWMDMDataUnits    = "WMDM/DataUnits",
    g_wszWMDMTimeToLive   = "WMDM/TimeToLive",
    g_wszWMDMMediaGuid    = "WMDM/MediaGuid",
}

enum const(wchar)* g_wszWPDPassthroughPropertyValues = "WPD/PassthroughPropertyValues";
enum GUID EVENT_WMDM_CONTENT_TRANSFER = GUID("339c9bf4-bcfe-4ed8-94df-eaf8c26ab61b");
enum uint MTP_COMMAND_MAX_PARAMS = 0x00000005U;
enum uint MTP_RESPONSE_MAX_PARAMS = 0x00000005U;
enum ushort MTP_RESPONSE_OK = cast(ushort) 0x2001;

// Structs


struct MACINFO
{
    BOOL      fUsed;
    ubyte[36] abMacState;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/WMDM/wmfilecapabilities
struct WMFILECAPABILITIES
{
    PWSTR pwszMimeType;
    uint  dwReserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/WMDM/opaquecommand
struct OPAQUECOMMAND
{
    GUID      guidCommand;
    uint      dwDataLen;
    ubyte*    pData;
    ubyte[20] abMAC;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/WMDM/wmdmid
struct WMDMID
{
    uint       cbSize;
    uint       dwVendorID;
    ubyte[128] pID;
    uint       SerialNumberLength;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/WMDM/wmdmdatetime
struct WMDMDATETIME
{
    ushort wYear;
    ushort wMonth;
    ushort wDay;
    ushort wHour;
    ushort wMinute;
    ushort wSecond;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/WMDM/wmdmrights
struct WMDMRIGHTS
{
    uint         cbSize;
    uint         dwContentType;
    uint         fuFlags;
    uint         fuRights;
    uint         dwAppSec;
    uint         dwPlaybackCount;
    WMDMDATETIME ExpirationDate;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/WMDM/wmdmmetadataview
struct WMDMMetadataView
{
    PWSTR    pwszViewName;
    uint     nDepth;
    ushort** ppwszTags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/WMDM/wmdm-prop-values-range
struct WMDM_PROP_VALUES_RANGE
{
    PROPVARIANT rangeMin;
    PROPVARIANT rangeMax;
    PROPVARIANT rangeStep;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/WMDM/wmdm-prop-values-enum
struct WMDM_PROP_VALUES_ENUM
{
    uint         cEnumValues;
    PROPVARIANT* pValues;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/WMDM/wmdm-prop-desc
struct WMDM_PROP_DESC
{
    PWSTR pwszPropName;
    WMDM_ENUM_PROP_VALID_VALUES_FORM ValidValuesForm;
    union ValidValues
    {
        WMDM_PROP_VALUES_RANGE ValidValuesRange;
        WMDM_PROP_VALUES_ENUM EnumeratedValidValues;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/WMDM/wmdm-prop-config
struct WMDM_PROP_CONFIG
{
    uint            nPreference;
    uint            nPropDesc;
    WMDM_PROP_DESC* pPropDesc;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/WMDM/wmdm-format-capability
struct WMDM_FORMAT_CAPABILITY
{
    uint              nPropConfig;
    WMDM_PROP_CONFIG* pConfigs;
}

union WMDMDetermineMaxPropStringLen
{
    wchar[27] sz001;
    wchar[31] sz002;
    wchar[14] sz003;
    wchar[16] sz004;
    wchar[22] sz005;
    wchar[14] sz006;
    wchar[20] sz007;
    wchar[20] sz008;
    wchar[22] sz009;
    wchar[11] sz010;
    wchar[12] sz011;
    wchar[17] sz012;
    wchar[17] sz013;
    wchar[16] sz014;
    wchar[17] sz015;
    wchar[11] sz016;
    wchar[11] sz017;
    wchar[15] sz018;
    wchar[22] sz019;
    wchar[20] sz020;
    wchar[22] sz021;
    wchar[21] sz022;
    wchar[24] sz023;
    wchar[20] sz024;
    wchar[10] sz025;
    wchar[14] sz026;
    wchar[11] sz027;
    wchar[11] sz028;
    wchar[13] sz029;
    wchar[17] sz030;
    wchar[16] sz031;
    wchar[17] sz032;
    wchar[20] sz033;
    wchar[19] sz034;
    wchar[18] sz035;
    wchar[18] sz036;
    wchar[15] sz037;
    wchar[14] sz041;
    wchar[22] sz043;
    wchar[16] sz044;
    wchar[20] sz045;
    wchar[14] sz046;
    wchar[14] sz047;
    wchar[12] sz048;
    wchar[25] sz049;
    wchar[26] sz050;
    wchar[25] sz051;
    wchar[16] sz052;
    wchar[24] sz053;
    wchar[15] sz054;
    wchar[21] sz055;
    wchar[16] sz056;
    wchar[22] sz057;
    wchar[14] sz058;
    wchar[25] sz059;
    wchar[18] sz060;
    wchar[22] sz061;
    wchar[26] sz062;
    wchar[36] sz063;
    wchar[23] sz064;
    wchar[12] sz065;
    wchar[24] sz066;
    wchar[11] sz067;
    wchar[12] sz068;
    wchar[14] sz069;
    wchar[20] sz070;
    wchar[15] sz071;
    wchar[14] sz072;
    wchar[31] sz073;
    wchar[24] sz074;
    wchar[22] sz075;
    wchar[24] sz076;
    wchar[21] sz077;
    wchar[27] sz078;
    wchar[27] sz079;
    wchar[20] sz080;
    wchar[33] sz081;
    wchar[21] sz082;
    wchar[32] sz083;
    wchar[26] sz084;
    wchar[18] sz085;
    wchar[30] sz086;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mtpext/ns-mtpext-mtp_command_data_in
struct MTP_COMMAND_DATA_IN
{
align (1):
    ushort  OpCode;
    uint    NumParams;
    uint[5] Params;
    uint    NextPhase;
    uint    CommandWriteDataSize;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] CommandWriteData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mtpext/ns-mtpext-mtp_command_data_out
struct MTP_COMMAND_DATA_OUT
{
align (1):
    ushort  ResponseCode;
    uint    NumParams;
    uint[5] Params;
    uint    CommandReadDataSize;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] CommandReadData;
}

// Interfaces

@GUID("50040c1d-bdbf-4924-b873-f14d6c5bfd66")
struct MediaDevMgrClassFactory;

@GUID("25baad81-3560-11d3-8471-00c04f79dbc0")
struct MediaDevMgr;

@GUID("807b3cdf-357a-11d3-8471-00c04f79dbc0")
struct WMDMDevice;

@GUID("807b3ce0-357a-11d3-8471-00c04f79dbc0")
struct WMDMStorage;

@GUID("807b3ce1-357a-11d3-8471-00c04f79dbc0")
struct WMDMStorageGlobal;

@GUID("430e35af-3971-11d3-8474-00c04f79dbc0")
struct WMDMDeviceEnum;

@GUID("eb401a3b-3af7-11d3-8474-00c04f79dbc0")
struct WMDMStorageEnum;

@GUID("110a3202-5a79-11d3-8d78-444553540000")
struct WMDMLogger;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-iwmdmmetadata
@GUID("ec3b0663-0951-460a-9a80-0dceed3c043c")
interface IWMDMMetaData : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmmetadata-additem
    HRESULT AddItem(WMDM_TAG_DATATYPE Type, const(PWSTR) pwszTagName, ubyte* pValue, uint iLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmmetadata-querybyname
    HRESULT QueryByName(const(PWSTR) pwszTagName, WMDM_TAG_DATATYPE* pType, ubyte** pValue, uint* pcbLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmmetadata-querybyindex
    HRESULT QueryByIndex(uint iIndex, ushort** ppwszName, WMDM_TAG_DATATYPE* pType, ubyte** ppValue, 
                         uint* pcbLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmmetadata-getitemcount
    HRESULT GetItemCount(uint* iCount);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-iwmdevicemanager
@GUID("1dcb3a00-33ed-11d3-8470-00c04f79dbc0")
interface IWMDeviceManager : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdevicemanager-getrevision
    HRESULT GetRevision(uint* pdwRevision);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdevicemanager-getdevicecount
    HRESULT GetDeviceCount(uint* pdwCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdevicemanager-enumdevices
    HRESULT EnumDevices(IWMDMEnumDevice* ppEnumDevice);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-iwmdevicemanager2
@GUID("923e5249-8731-4c5b-9b1c-b8b60b6e46af")
interface IWMDeviceManager2 : IWMDeviceManager
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdevicemanager2-getdevicefromcanonicalname
    HRESULT GetDeviceFromCanonicalName(const(PWSTR) pwszCanonicalName, IWMDMDevice* ppDevice);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdevicemanager2-enumdevices2
    HRESULT EnumDevices2(IWMDMEnumDevice* ppEnumDevice);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdevicemanager2-reinitialize
    HRESULT Reinitialize();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-iwmdevicemanager3
@GUID("af185c41-100d-46ed-be2e-9ce8c44594ef")
interface IWMDeviceManager3 : IWMDeviceManager2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdevicemanager3-setdeviceenumpreference
    HRESULT SetDeviceEnumPreference(uint dwEnumPref);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-iwmdmstorageglobals
@GUID("1dcb3a07-33ed-11d3-8470-00c04f79dbc0")
interface IWMDMStorageGlobals : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmstorageglobals-getcapabilities
    HRESULT GetCapabilities(uint* pdwCapabilities);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmstorageglobals-getserialnumber
    HRESULT GetSerialNumber(WMDMID* pSerialNum, ubyte* abMac);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmstorageglobals-gettotalsize
    HRESULT GetTotalSize(uint* pdwTotalSizeLow, uint* pdwTotalSizeHigh);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmstorageglobals-gettotalfree
    HRESULT GetTotalFree(uint* pdwFreeLow, uint* pdwFreeHigh);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmstorageglobals-gettotalbad
    HRESULT GetTotalBad(uint* pdwBadLow, uint* pdwBadHigh);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmstorageglobals-getstatus
    HRESULT GetStatus(uint* pdwStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmstorageglobals-initialize
    HRESULT Initialize(uint fuMode, IWMDMProgress pProgress);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-iwmdmstorage
@GUID("1dcb3a06-33ed-11d3-8470-00c04f79dbc0")
interface IWMDMStorage : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmstorage-setattributes
    HRESULT SetAttributes(uint dwAttributes, WAVEFORMATEX* pFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmstorage-getstorageglobals
    HRESULT GetStorageGlobals(IWMDMStorageGlobals* ppStorageGlobals);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmstorage-getattributes
    HRESULT GetAttributes(uint* pdwAttributes, WAVEFORMATEX* pFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmstorage-getname
    HRESULT GetName(PWSTR pwszName, uint nMaxChars);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmstorage-getdate
    HRESULT GetDate(WMDMDATETIME* pDateTimeUTC);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmstorage-getsize
    HRESULT GetSize(uint* pdwSizeLow, uint* pdwSizeHigh);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmstorage-getrights
    HRESULT GetRights(WMDMRIGHTS** ppRights, uint* pnRightsCount, ubyte* abMac);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmstorage-enumstorage
    HRESULT EnumStorage(IWMDMEnumStorage* pEnumStorage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmstorage-sendopaquecommand
    HRESULT SendOpaqueCommand(OPAQUECOMMAND* pCommand);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-iwmdmstorage2
@GUID("1ed5a144-5cd5-4683-9eff-72cbdb2d9533")
interface IWMDMStorage2 : IWMDMStorage
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmstorage2-getstorage
    HRESULT GetStorage(const(PWSTR) pszStorageName, IWMDMStorage* ppStorage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmstorage2-setattributes2
    HRESULT SetAttributes2(uint dwAttributes, uint dwAttributesEx, WAVEFORMATEX* pFormat, 
                           VIDEOINFOHEADER* pVideoFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmstorage2-getattributes2
    HRESULT GetAttributes2(uint* pdwAttributes, uint* pdwAttributesEx, WAVEFORMATEX* pAudioFormat, 
                           VIDEOINFOHEADER* pVideoFormat);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-iwmdmstorage3
@GUID("97717eea-926a-464e-96a4-247b0216026e")
interface IWMDMStorage3 : IWMDMStorage2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmstorage3-getmetadata
    HRESULT GetMetadata(IWMDMMetaData* ppMetadata);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmstorage3-setmetadata
    HRESULT SetMetadata(IWMDMMetaData pMetadata);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmstorage3-createemptymetadataobject
    HRESULT CreateEmptyMetadataObject(IWMDMMetaData* ppMetadata);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmstorage3-setenumpreference
    HRESULT SetEnumPreference(WMDM_STORAGE_ENUM_MODE* pMode, uint nViews, WMDMMetadataView* pViews);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-iwmdmstorage4
@GUID("c225bac5-a03a-40b8-9a23-91cf478c64a6")
interface IWMDMStorage4 : IWMDMStorage3
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmstorage4-setreferences
    HRESULT SetReferences(uint dwRefs, IWMDMStorage* ppIWMDMStorage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmstorage4-getreferences
    HRESULT GetReferences(uint* pdwRefs, IWMDMStorage** pppIWMDMStorage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmstorage4-getrightswithprogress
    HRESULT GetRightsWithProgress(IWMDMProgress3 pIProgressCallback, WMDMRIGHTS** ppRights, uint* pnRightsCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmstorage4-getspecifiedmetadata
    HRESULT GetSpecifiedMetadata(uint cProperties, const(PWSTR)* ppwszPropNames, IWMDMMetaData* ppMetadata);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmstorage4-findstorage
    HRESULT FindStorage(WMDM_FIND_SCOPE findScope, const(PWSTR) pwszUniqueID, IWMDMStorage* ppStorage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmstorage4-getparent
    HRESULT GetParent(IWMDMStorage* ppStorage);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-iwmdmoperation
@GUID("1dcb3a0b-33ed-11d3-8470-00c04f79dbc0")
interface IWMDMOperation : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmoperation-beginread
    HRESULT BeginRead();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmoperation-beginwrite
    HRESULT BeginWrite();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmoperation-getobjectname
    HRESULT GetObjectName(PWSTR pwszName, uint nMaxChars);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmoperation-setobjectname
    HRESULT SetObjectName(PWSTR pwszName, uint nMaxChars);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmoperation-getobjectattributes
    HRESULT GetObjectAttributes(uint* pdwAttributes, WAVEFORMATEX* pFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmoperation-setobjectattributes
    HRESULT SetObjectAttributes(uint dwAttributes, WAVEFORMATEX* pFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmoperation-getobjecttotalsize
    HRESULT GetObjectTotalSize(uint* pdwSize, uint* pdwSizeHigh);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmoperation-setobjecttotalsize
    HRESULT SetObjectTotalSize(uint dwSize, uint dwSizeHigh);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmoperation-transferobjectdata
    HRESULT TransferObjectData(ubyte* pData, uint* pdwSize, ubyte* abMac);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmoperation-end
    HRESULT End(HRESULT* phCompletionCode, IUnknown pNewObject);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-iwmdmoperation2
@GUID("33445b48-7df7-425c-ad8f-0fc6d82f9f75")
interface IWMDMOperation2 : IWMDMOperation
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmoperation2-setobjectattributes2
    HRESULT SetObjectAttributes2(uint dwAttributes, uint dwAttributesEx, WAVEFORMATEX* pFormat, 
                                 VIDEOINFOHEADER* pVideoFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmoperation2-getobjectattributes2
    HRESULT GetObjectAttributes2(uint* pdwAttributes, uint* pdwAttributesEx, WAVEFORMATEX* pAudioFormat, 
                                 VIDEOINFOHEADER* pVideoFormat);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-iwmdmoperation3
@GUID("d1f9b46a-9ca8-46d8-9d0f-1ec9bae54919")
interface IWMDMOperation3 : IWMDMOperation
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmoperation3-transferobjectdataonclearchannel
    HRESULT TransferObjectDataOnClearChannel(ubyte* pData, uint* pdwSize);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-iwmdmprogress
@GUID("1dcb3a0c-33ed-11d3-8470-00c04f79dbc0")
interface IWMDMProgress : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmprogress-begin
    HRESULT Begin(uint dwEstimatedTicks);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmprogress-progress
    HRESULT Progress(uint dwTranspiredTicks);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmprogress-end
    HRESULT End();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-iwmdmprogress2
@GUID("3a43f550-b383-4e92-b04a-e6bbc660fefc")
interface IWMDMProgress2 : IWMDMProgress
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmprogress2-end2
    HRESULT End2(HRESULT hrCompletionCode);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-iwmdmprogress3
@GUID("21de01cb-3bb4-4929-b21a-17af3f80f658")
interface IWMDMProgress3 : IWMDMProgress2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmprogress3-begin3
    HRESULT Begin3(GUID EventId, uint dwEstimatedTicks, OPAQUECOMMAND* pContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmprogress3-progress3
    HRESULT Progress3(GUID EventId, uint dwTranspiredTicks, OPAQUECOMMAND* pContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmprogress3-end3
    HRESULT End3(GUID EventId, HRESULT hrCompletionCode, OPAQUECOMMAND* pContext);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-iwmdmdevice
@GUID("1dcb3a02-33ed-11d3-8470-00c04f79dbc0")
interface IWMDMDevice : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmdevice-getname
    HRESULT GetName(PWSTR pwszName, uint nMaxChars);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmdevice-getmanufacturer
    HRESULT GetManufacturer(PWSTR pwszName, uint nMaxChars);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmdevice-getversion
    HRESULT GetVersion(uint* pdwVersion);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmdevice-gettype
    HRESULT GetType(uint* pdwType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmdevice-getserialnumber
    HRESULT GetSerialNumber(WMDMID* pSerialNumber, ubyte* abMac);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmdevice-getpowersource
    HRESULT GetPowerSource(uint* pdwPowerSource, uint* pdwPercentRemaining);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmdevice-getstatus
    HRESULT GetStatus(uint* pdwStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmdevice-getdeviceicon
    HRESULT GetDeviceIcon(uint* hIcon);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmdevice-enumstorage
    HRESULT EnumStorage(IWMDMEnumStorage* ppEnumStorage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmdevice-getformatsupport
    HRESULT GetFormatSupport(WAVEFORMATEX** ppFormatEx, uint* pnFormatCount, PWSTR** pppwszMimeType, 
                             uint* pnMimeTypeCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmdevice-sendopaquecommand
    HRESULT SendOpaqueCommand(OPAQUECOMMAND* pCommand);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-iwmdmdevice2
@GUID("e34f3d37-9d67-4fc1-9252-62d28b2f8b55")
interface IWMDMDevice2 : IWMDMDevice
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmdevice2-getstorage
    HRESULT GetStorage(const(PWSTR) pszStorageName, IWMDMStorage* ppStorage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmdevice2-getformatsupport2
    HRESULT GetFormatSupport2(uint dwFlags, WAVEFORMATEX** ppAudioFormatEx, uint* pnAudioFormatCount, 
                              VIDEOINFOHEADER** ppVideoFormatEx, uint* pnVideoFormatCount, 
                              WMFILECAPABILITIES** ppFileType, uint* pnFileTypeCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmdevice2-getspecifypropertypages
    HRESULT GetSpecifyPropertyPages(ISpecifyPropertyPages* ppSpecifyPropPages, IUnknown** pppUnknowns, 
                                    uint* pcUnks);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmdevice2-getcanonicalname
    HRESULT GetCanonicalName(PWSTR pwszPnPName, uint nMaxChars);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-iwmdmdevice3
@GUID("6c03e4fe-05db-4dda-9e3c-06233a6d5d65")
interface IWMDMDevice3 : IWMDMDevice2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmdevice3-getproperty
    HRESULT GetProperty(const(PWSTR) pwszPropName, PROPVARIANT* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmdevice3-setproperty
    HRESULT SetProperty(const(PWSTR) pwszPropName, const(PROPVARIANT)* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmdevice3-getformatcapability
    HRESULT GetFormatCapability(WMDM_FORMATCODE format, WMDM_FORMAT_CAPABILITY* pFormatSupport);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmdevice3-deviceiocontrol
    HRESULT DeviceIoControl(uint dwIoControlCode, ubyte* lpInBuffer, uint nInBufferSize, ubyte* lpOutBuffer, 
                            uint* pnOutBufferSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmdevice3-findstorage
    HRESULT FindStorage(WMDM_FIND_SCOPE findScope, const(PWSTR) pwszUniqueID, IWMDMStorage* ppStorage);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-iwmdmdevicesession
@GUID("82af0a65-9d96-412c-83e5-3c43e4b06cc7")
interface IWMDMDeviceSession : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmdevicesession-beginsession
    HRESULT BeginSession(WMDM_SESSION_TYPE type, ubyte* pCtx, uint dwSizeCtx);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmdevicesession-endsession
    HRESULT EndSession(WMDM_SESSION_TYPE type, ubyte* pCtx, uint dwSizeCtx);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-iwmdmenumdevice
@GUID("1dcb3a01-33ed-11d3-8470-00c04f79dbc0")
interface IWMDMEnumDevice : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmenumdevice-next
    HRESULT Next(uint celt, IWMDMDevice* ppDevice, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmenumdevice-skip
    HRESULT Skip(uint celt, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmenumdevice-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmenumdevice-clone
    HRESULT Clone(IWMDMEnumDevice* ppEnumDevice);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-iwmdmdevicecontrol
@GUID("1dcb3a04-33ed-11d3-8470-00c04f79dbc0")
interface IWMDMDeviceControl : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmdevicecontrol-getstatus
    HRESULT GetStatus(uint* pdwStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmdevicecontrol-getcapabilities
    HRESULT GetCapabilities(uint* pdwCapabilitiesMask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmdevicecontrol-play
    HRESULT Play();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmdevicecontrol-record
    HRESULT Record(WAVEFORMATEX* pFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmdevicecontrol-pause
    HRESULT Pause();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmdevicecontrol-resume
    HRESULT Resume();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmdevicecontrol-stop
    HRESULT Stop();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmdevicecontrol-seek
    HRESULT Seek(uint fuMode, int nOffset);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-iwmdmenumstorage
@GUID("1dcb3a05-33ed-11d3-8470-00c04f79dbc0")
interface IWMDMEnumStorage : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmenumstorage-next
    HRESULT Next(uint celt, IWMDMStorage* ppStorage, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmenumstorage-skip
    HRESULT Skip(uint celt, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmenumstorage-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmenumstorage-clone
    HRESULT Clone(IWMDMEnumStorage* ppEnumStorage);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-iwmdmstoragecontrol
@GUID("1dcb3a08-33ed-11d3-8470-00c04f79dbc0")
interface IWMDMStorageControl : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmstoragecontrol-insert
    HRESULT Insert(uint fuMode, PWSTR pwszFile, IWMDMOperation pOperation, IWMDMProgress pProgress, 
                   IWMDMStorage* ppNewObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmstoragecontrol-delete
    HRESULT Delete(uint fuMode, IWMDMProgress pProgress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmstoragecontrol-rename
    HRESULT Rename(uint fuMode, PWSTR pwszNewName, IWMDMProgress pProgress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmstoragecontrol-read
    HRESULT Read(uint fuMode, PWSTR pwszFile, IWMDMProgress pProgress, IWMDMOperation pOperation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmstoragecontrol-move
    HRESULT Move(uint fuMode, IWMDMStorage pTargetObject, IWMDMProgress pProgress);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-iwmdmstoragecontrol2
@GUID("972c2e88-bd6c-4125-8e09-84f837e637b6")
interface IWMDMStorageControl2 : IWMDMStorageControl
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmstoragecontrol2-insert2
    HRESULT Insert2(uint fuMode, PWSTR pwszFileSource, PWSTR pwszFileDest, IWMDMOperation pOperation, 
                    IWMDMProgress pProgress, IUnknown pUnknown, IWMDMStorage* ppNewObject);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-iwmdmstoragecontrol3
@GUID("b3266365-d4f3-4696-8d53-bd27ec60993a")
interface IWMDMStorageControl3 : IWMDMStorageControl2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmstoragecontrol3-insert3
    HRESULT Insert3(uint fuMode, uint fuType, PWSTR pwszFileSource, PWSTR pwszFileDest, IWMDMOperation pOperation, 
                    IWMDMProgress pProgress, IWMDMMetaData pMetaData, IUnknown pUnknown, IWMDMStorage* ppNewObject);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-iwmdmobjectinfo
@GUID("1dcb3a09-33ed-11d3-8470-00c04f79dbc0")
interface IWMDMObjectInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmobjectinfo-getplaylength
    HRESULT GetPlayLength(uint* pdwLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmobjectinfo-setplaylength
    HRESULT SetPlayLength(uint dwLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmobjectinfo-getplayoffset
    HRESULT GetPlayOffset(uint* pdwOffset);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmobjectinfo-setplayoffset
    HRESULT SetPlayOffset(uint dwOffset);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmobjectinfo-gettotallength
    HRESULT GetTotalLength(uint* pdwLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmobjectinfo-getlastplayposition
    HRESULT GetLastPlayPosition(uint* pdwLastPos);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmobjectinfo-getlongestplayposition
    HRESULT GetLongestPlayPosition(uint* pdwLongestPos);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-iwmdmrevoked
@GUID("ebeccedb-88ee-4e55-b6a4-8d9f07d696aa")
interface IWMDMRevoked : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmrevoked-getrevocationurl
    HRESULT GetRevocationURL(PWSTR* ppwszRevocationURL, uint* pdwBufferLen, uint* pdwRevokedBitFlag);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-iwmdmnotification
@GUID("3f5e95c0-0f43-4ed4-93d2-c89a45d59b81")
interface IWMDMNotification : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iwmdmnotification-wmdmmessage
    HRESULT WMDMMessage(uint dwMessageType, const(PWSTR) pwszCanonicalName);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-imdserviceprovider
@GUID("1dcb3a10-33ed-11d3-8470-00c04f79dbc0")
interface IMDServiceProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdserviceprovider-getdevicecount
    HRESULT GetDeviceCount(uint* pdwCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdserviceprovider-enumdevices
    HRESULT EnumDevices(IMDSPEnumDevice* ppEnumDevice);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-imdserviceprovider2
@GUID("b2fa24b7-cda3-4694-9862-413ae1a34819")
interface IMDServiceProvider2 : IMDServiceProvider
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdserviceprovider2-createdevice
    HRESULT CreateDevice(const(PWSTR) pwszDevicePath, uint* pdwCount, IMDSPDevice** pppDeviceArray);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-imdserviceprovider3
@GUID("4ed13ef3-a971-4d19-9f51-0e1826b2da57")
interface IMDServiceProvider3 : IMDServiceProvider2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdserviceprovider3-setdeviceenumpreference
    HRESULT SetDeviceEnumPreference(uint dwEnumPref);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-imdspenumdevice
@GUID("1dcb3a11-33ed-11d3-8470-00c04f79dbc0")
interface IMDSPEnumDevice : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspenumdevice-next
    HRESULT Next(uint celt, IMDSPDevice* ppDevice, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspenumdevice-skip
    HRESULT Skip(uint celt, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspenumdevice-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspenumdevice-clone
    HRESULT Clone(IMDSPEnumDevice* ppEnumDevice);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-imdspdevice
@GUID("1dcb3a12-33ed-11d3-8470-00c04f79dbc0")
interface IMDSPDevice : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspdevice-getname
    HRESULT GetName(PWSTR pwszName, uint nMaxChars);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspdevice-getmanufacturer
    HRESULT GetManufacturer(PWSTR pwszName, uint nMaxChars);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspdevice-getversion
    HRESULT GetVersion(uint* pdwVersion);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspdevice-gettype
    HRESULT GetType(uint* pdwType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspdevice-getserialnumber
    HRESULT GetSerialNumber(WMDMID* pSerialNumber, ubyte* abMac);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspdevice-getpowersource
    HRESULT GetPowerSource(uint* pdwPowerSource, uint* pdwPercentRemaining);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspdevice-getstatus
    HRESULT GetStatus(uint* pdwStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspdevice-getdeviceicon
    HRESULT GetDeviceIcon(uint* hIcon);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspdevice-enumstorage
    HRESULT EnumStorage(IMDSPEnumStorage* ppEnumStorage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspdevice-getformatsupport
    HRESULT GetFormatSupport(WAVEFORMATEX** pFormatEx, uint* pnFormatCount, PWSTR** pppwszMimeType, 
                             uint* pnMimeTypeCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspdevice-sendopaquecommand
    HRESULT SendOpaqueCommand(OPAQUECOMMAND* pCommand);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-imdspdevice2
@GUID("420d16ad-c97d-4e00-82aa-00e9f4335ddd")
interface IMDSPDevice2 : IMDSPDevice
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspdevice2-getstorage
    HRESULT GetStorage(const(PWSTR) pszStorageName, IMDSPStorage* ppStorage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspdevice2-getformatsupport2
    HRESULT GetFormatSupport2(uint dwFlags, WAVEFORMATEX** ppAudioFormatEx, uint* pnAudioFormatCount, 
                              VIDEOINFOHEADER** ppVideoFormatEx, uint* pnVideoFormatCount, 
                              WMFILECAPABILITIES** ppFileType, uint* pnFileTypeCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspdevice2-getspecifypropertypages
    HRESULT GetSpecifyPropertyPages(ISpecifyPropertyPages* ppSpecifyPropPages, IUnknown** pppUnknowns, 
                                    uint* pcUnks);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspdevice2-getcanonicalname
    HRESULT GetCanonicalName(PWSTR pwszPnPName, uint nMaxChars);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-imdspdevice3
@GUID("1a839845-fc55-487c-976f-ee38ac0e8c4e")
interface IMDSPDevice3 : IMDSPDevice2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspdevice3-getproperty
    HRESULT GetProperty(const(PWSTR) pwszPropName, PROPVARIANT* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspdevice3-setproperty
    HRESULT SetProperty(const(PWSTR) pwszPropName, const(PROPVARIANT)* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspdevice3-getformatcapability
    HRESULT GetFormatCapability(WMDM_FORMATCODE format, WMDM_FORMAT_CAPABILITY* pFormatSupport);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspdevice3-deviceiocontrol
    HRESULT DeviceIoControl(uint dwIoControlCode, ubyte* lpInBuffer, uint nInBufferSize, ubyte* lpOutBuffer, 
                            uint* pnOutBufferSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspdevice3-findstorage
    HRESULT FindStorage(WMDM_FIND_SCOPE findScope, const(PWSTR) pwszUniqueID, IMDSPStorage* ppStorage);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-imdspdevicecontrol
@GUID("1dcb3a14-33ed-11d3-8470-00c04f79dbc0")
interface IMDSPDeviceControl : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspdevicecontrol-getdcstatus
    HRESULT GetDCStatus(uint* pdwStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspdevicecontrol-getcapabilities
    HRESULT GetCapabilities(uint* pdwCapabilitiesMask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspdevicecontrol-play
    HRESULT Play();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspdevicecontrol-record
    HRESULT Record(WAVEFORMATEX* pFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspdevicecontrol-pause
    HRESULT Pause();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspdevicecontrol-resume
    HRESULT Resume();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspdevicecontrol-stop
    HRESULT Stop();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspdevicecontrol-seek
    HRESULT Seek(uint fuMode, int nOffset);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-imdspenumstorage
@GUID("1dcb3a15-33ed-11d3-8470-00c04f79dbc0")
interface IMDSPEnumStorage : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspenumstorage-next
    HRESULT Next(uint celt, IMDSPStorage* ppStorage, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspenumstorage-skip
    HRESULT Skip(uint celt, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspenumstorage-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspenumstorage-clone
    HRESULT Clone(IMDSPEnumStorage* ppEnumStorage);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-imdspstorage
@GUID("1dcb3a16-33ed-11d3-8470-00c04f79dbc0")
interface IMDSPStorage : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspstorage-setattributes
    HRESULT SetAttributes(uint dwAttributes, WAVEFORMATEX* pFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspstorage-getstorageglobals
    HRESULT GetStorageGlobals(IMDSPStorageGlobals* ppStorageGlobals);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspstorage-getattributes
    HRESULT GetAttributes(uint* pdwAttributes, WAVEFORMATEX* pFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspstorage-getname
    HRESULT GetName(PWSTR pwszName, uint nMaxChars);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspstorage-getdate
    HRESULT GetDate(WMDMDATETIME* pDateTimeUTC);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspstorage-getsize
    HRESULT GetSize(uint* pdwSizeLow, uint* pdwSizeHigh);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspstorage-getrights
    HRESULT GetRights(WMDMRIGHTS** ppRights, uint* pnRightsCount, ubyte* abMac);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspstorage-createstorage
    HRESULT CreateStorage(uint dwAttributes, WAVEFORMATEX* pFormat, PWSTR pwszName, IMDSPStorage* ppNewStorage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspstorage-enumstorage
    HRESULT EnumStorage(IMDSPEnumStorage* ppEnumStorage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspstorage-sendopaquecommand
    HRESULT SendOpaqueCommand(OPAQUECOMMAND* pCommand);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-imdspstorage2
@GUID("0a5e07a5-6454-4451-9c36-1c6ae7e2b1d6")
interface IMDSPStorage2 : IMDSPStorage
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspstorage2-getstorage
    HRESULT GetStorage(const(PWSTR) pszStorageName, IMDSPStorage* ppStorage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspstorage2-createstorage2
    HRESULT CreateStorage2(uint dwAttributes, uint dwAttributesEx, WAVEFORMATEX* pAudioFormat, 
                           VIDEOINFOHEADER* pVideoFormat, PWSTR pwszName, ulong qwFileSize, 
                           IMDSPStorage* ppNewStorage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspstorage2-setattributes2
    HRESULT SetAttributes2(uint dwAttributes, uint dwAttributesEx, WAVEFORMATEX* pAudioFormat, 
                           VIDEOINFOHEADER* pVideoFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspstorage2-getattributes2
    HRESULT GetAttributes2(uint* pdwAttributes, uint* pdwAttributesEx, WAVEFORMATEX* pAudioFormat, 
                           VIDEOINFOHEADER* pVideoFormat);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-imdspstorage3
@GUID("6c669867-97ed-4a67-9706-1c5529d2a414")
interface IMDSPStorage3 : IMDSPStorage2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspstorage3-getmetadata
    HRESULT GetMetadata(IWMDMMetaData pMetadata);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspstorage3-setmetadata
    HRESULT SetMetadata(IWMDMMetaData pMetadata);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-imdspstorage4
@GUID("3133b2c4-515c-481b-b1ce-39327ecb4f74")
interface IMDSPStorage4 : IMDSPStorage3
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspstorage4-setreferences
    HRESULT SetReferences(uint dwRefs, IMDSPStorage* ppISPStorage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspstorage4-getreferences
    HRESULT GetReferences(uint* pdwRefs, IMDSPStorage** pppISPStorage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspstorage4-createstoragewithmetadata
    HRESULT CreateStorageWithMetadata(uint dwAttributes, const(PWSTR) pwszName, IWMDMMetaData pMetadata, 
                                      ulong qwFileSize, IMDSPStorage* ppNewStorage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspstorage4-getspecifiedmetadata
    HRESULT GetSpecifiedMetadata(uint cProperties, const(PWSTR)* ppwszPropNames, IWMDMMetaData pMetadata);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspstorage4-findstorage
    HRESULT FindStorage(WMDM_FIND_SCOPE findScope, const(PWSTR) pwszUniqueID, IMDSPStorage* ppStorage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspstorage4-getparent
    HRESULT GetParent(IMDSPStorage* ppStorage);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-imdspstorageglobals
@GUID("1dcb3a17-33ed-11d3-8470-00c04f79dbc0")
interface IMDSPStorageGlobals : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspstorageglobals-getcapabilities
    HRESULT GetCapabilities(uint* pdwCapabilities);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspstorageglobals-getserialnumber
    HRESULT GetSerialNumber(WMDMID* pSerialNum, ubyte* abMac);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspstorageglobals-gettotalsize
    HRESULT GetTotalSize(uint* pdwTotalSizeLow, uint* pdwTotalSizeHigh);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspstorageglobals-gettotalfree
    HRESULT GetTotalFree(uint* pdwFreeLow, uint* pdwFreeHigh);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspstorageglobals-gettotalbad
    HRESULT GetTotalBad(uint* pdwBadLow, uint* pdwBadHigh);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspstorageglobals-getstatus
    HRESULT GetStatus(uint* pdwStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspstorageglobals-initialize
    HRESULT Initialize(uint fuMode, IWMDMProgress pProgress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspstorageglobals-getdevice
    HRESULT GetDevice(IMDSPDevice* ppDevice);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspstorageglobals-getrootstorage
    HRESULT GetRootStorage(IMDSPStorage* ppRoot);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-imdspobjectinfo
@GUID("1dcb3a19-33ed-11d3-8470-00c04f79dbc0")
interface IMDSPObjectInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspobjectinfo-getplaylength
    HRESULT GetPlayLength(uint* pdwLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspobjectinfo-setplaylength
    HRESULT SetPlayLength(uint dwLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspobjectinfo-getplayoffset
    HRESULT GetPlayOffset(uint* pdwOffset);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspobjectinfo-setplayoffset
    HRESULT SetPlayOffset(uint dwOffset);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspobjectinfo-gettotallength
    HRESULT GetTotalLength(uint* pdwLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspobjectinfo-getlastplayposition
    HRESULT GetLastPlayPosition(uint* pdwLastPos);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspobjectinfo-getlongestplayposition
    HRESULT GetLongestPlayPosition(uint* pdwLongestPos);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-imdspobject
@GUID("1dcb3a18-33ed-11d3-8470-00c04f79dbc0")
interface IMDSPObject : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspobject-open
    HRESULT Open(uint fuMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspobject-read
    HRESULT Read(ubyte* pData, uint* pdwSize, ubyte* abMac);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspobject-write
    HRESULT Write(ubyte* pData, uint* pdwSize, ubyte* abMac);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspobject-delete
    HRESULT Delete(uint fuMode, IWMDMProgress pProgress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspobject-seek
    HRESULT Seek(uint fuFlags, uint dwOffset);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspobject-rename
    HRESULT Rename(PWSTR pwszNewName, IWMDMProgress pProgress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspobject-move
    HRESULT Move(uint fuMode, IWMDMProgress pProgress, IMDSPStorage pTarget);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspobject-close
    HRESULT Close();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-imdspobject2
@GUID("3f34cd3e-5907-4341-9af9-97f4187c3aa5")
interface IMDSPObject2 : IMDSPObject
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspobject2-readonclearchannel
    HRESULT ReadOnClearChannel(ubyte* pData, uint* pdwSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspobject2-writeonclearchannel
    HRESULT WriteOnClearChannel(ubyte* pData, uint* pdwSize);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-imdspdirecttransfer
@GUID("c2fe57a8-9304-478c-9ee4-47e397b912d7")
interface IMDSPDirectTransfer : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdspdirecttransfer-transfertodevice
    HRESULT TransferToDevice(const(PWSTR) pwszSourceFilePath, IWMDMOperation pSourceOperation, uint fuFlags, 
                             PWSTR pwszDestinationName, IWMDMMetaData pSourceMetaData, 
                             IWMDMProgress pTransferProgress, IMDSPStorage* ppNewObject);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-imdsprevoked
@GUID("a4e8f2d4-3f31-464d-b53d-4fc335998184")
interface IMDSPRevoked : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-imdsprevoked-getrevocationurl
    HRESULT GetRevocationURL(PWSTR* ppwszRevocationURL, uint* pdwBufferLen);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-iscpsecureauthenticate
@GUID("1dcb3a0f-33ed-11d3-8470-00c04f79dbc0")
interface ISCPSecureAuthenticate : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iscpsecureauthenticate-getsecurequery
    HRESULT GetSecureQuery(ISCPSecureQuery* ppSecureQuery);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-iscpsecureauthenticate2
@GUID("b580cfae-1672-47e2-acaa-44bbecbcae5b")
interface ISCPSecureAuthenticate2 : ISCPSecureAuthenticate
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iscpsecureauthenticate2-getscpsession
    HRESULT GetSCPSession(ISCPSession* ppSCPSession);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-iscpsecurequery
@GUID("1dcb3a0d-33ed-11d3-8470-00c04f79dbc0")
interface ISCPSecureQuery : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iscpsecurequery-getdatademands
    HRESULT GetDataDemands(uint* pfuFlags, uint* pdwMinRightsData, uint* pdwMinExamineData, uint* pdwMinDecideData, 
                           ubyte* abMac);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iscpsecurequery-examinedata
    HRESULT ExamineData(uint fuFlags, PWSTR pwszExtension, ubyte* pData, uint dwSize, ubyte* abMac);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iscpsecurequery-makedecision
    HRESULT MakeDecision(uint fuFlags, ubyte* pData, uint dwSize, uint dwAppSec, ubyte* pbSPSessionKey, 
                         uint dwSessionKeyLen, IMDSPStorageGlobals pStorageGlobals, ISCPSecureExchange* ppExchange, 
                         ubyte* abMac);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iscpsecurequery-getrights
    HRESULT GetRights(ubyte* pData, uint dwSize, ubyte* pbSPSessionKey, uint dwSessionKeyLen, 
                      IMDSPStorageGlobals pStgGlobals, WMDMRIGHTS** ppRights, uint* pnRightsCount, ubyte* abMac);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-iscpsecurequery2
@GUID("ebe17e25-4fd7-4632-af46-6d93d4fcc72e")
interface ISCPSecureQuery2 : ISCPSecureQuery
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iscpsecurequery2-makedecision2
    HRESULT MakeDecision2(uint fuFlags, ubyte* pData, uint dwSize, uint dwAppSec, ubyte* pbSPSessionKey, 
                          uint dwSessionKeyLen, IMDSPStorageGlobals pStorageGlobals, ubyte* pAppCertApp, 
                          uint dwAppCertAppLen, ubyte* pAppCertSP, uint dwAppCertSPLen, PWSTR* pszRevocationURL, 
                          uint* pdwRevocationURLLen, uint* pdwRevocationBitFlag, ulong* pqwFileSize, 
                          IUnknown pUnknown, ISCPSecureExchange* ppExchange, ubyte* abMac);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-iscpsecureexchange
@GUID("1dcb3a0e-33ed-11d3-8470-00c04f79dbc0")
interface ISCPSecureExchange : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iscpsecureexchange-transfercontainerdata
    HRESULT TransferContainerData(ubyte* pData, uint dwSize, uint* pfuReadyFlags, ubyte* abMac);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iscpsecureexchange-objectdata
    HRESULT ObjectData(ubyte* pData, uint* pdwSize, ubyte* abMac);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iscpsecureexchange-transfercomplete
    HRESULT TransferComplete();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-iscpsecureexchange2
@GUID("6c62fc7b-2690-483f-9d44-0a20cb35577c")
interface ISCPSecureExchange2 : ISCPSecureExchange
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iscpsecureexchange2-transfercontainerdata2
    HRESULT TransferContainerData2(ubyte* pData, uint dwSize, IWMDMProgress3 pProgressCallback, 
                                   uint* pfuReadyFlags, ubyte* abMac);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-iscpsecureexchange3
@GUID("ab4e77e4-8908-4b17-bd2a-b1dbe6dd69e1")
interface ISCPSecureExchange3 : ISCPSecureExchange2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iscpsecureexchange3-transfercontainerdataonclearchannel
    HRESULT TransferContainerDataOnClearChannel(IMDSPDevice pDevice, ubyte* pData, uint dwSize, 
                                                IWMDMProgress3 pProgressCallback, uint* pfuReadyFlags);
    HRESULT GetObjectDataOnClearChannel(IMDSPDevice pDevice, ubyte* pData, uint* pdwSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iscpsecureexchange3-transfercompletefordevice
    HRESULT TransferCompleteForDevice(IMDSPDevice pDevice);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-iscpsession
@GUID("88a3e6ed-eee4-4619-bbb3-fd4fb62715d1")
interface ISCPSession : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iscpsession-beginsession
    HRESULT BeginSession(IMDSPDevice pIDevice, ubyte* pCtx, uint dwSizeCtx);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iscpsession-endsession
    HRESULT EndSession(ubyte* pCtx, uint dwSizeCtx);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iscpsession-getsecurequery
    HRESULT GetSecureQuery(ISCPSecureQuery* ppSecureQuery);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-iscpsecurequery3
@GUID("b7edd1a2-4dab-484b-b3c5-ad39b8b4c0b1")
interface ISCPSecureQuery3 : ISCPSecureQuery2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iscpsecurequery3-getrightsonclearchannel
    HRESULT GetRightsOnClearChannel(ubyte* pData, uint dwSize, ubyte* pbSPSessionKey, uint dwSessionKeyLen, 
                                    IMDSPStorageGlobals pStgGlobals, IWMDMProgress3 pProgressCallback, 
                                    WMDMRIGHTS** ppRights, uint* pnRightsCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-iscpsecurequery3-makedecisiononclearchannel
    HRESULT MakeDecisionOnClearChannel(uint fuFlags, ubyte* pData, uint dwSize, uint dwAppSec, 
                                       ubyte* pbSPSessionKey, uint dwSessionKeyLen, 
                                       IMDSPStorageGlobals pStorageGlobals, IWMDMProgress3 pProgressCallback, 
                                       ubyte* pAppCertApp, uint dwAppCertAppLen, ubyte* pAppCertSP, 
                                       uint dwAppCertSPLen, PWSTR* pszRevocationURL, uint* pdwRevocationURLLen, 
                                       uint* pdwRevocationBitFlag, ulong* pqwFileSize, IUnknown pUnknown, 
                                       ISCPSecureExchange* ppExchange);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nn-mswmdm-icomponentauthenticate
@GUID("a9889c00-6d2b-11d3-8496-00c04f79dbc0")
interface IComponentAuthenticate : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-icomponentauthenticate-sacauth
    HRESULT SACAuth(uint dwProtocolID, uint dwPass, ubyte* pbDataIn, uint dwDataInLen, ubyte** ppbDataOut, 
                    uint* pdwDataOutLen);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswmdm/nf-mswmdm-icomponentauthenticate-sacgetprotocols
    HRESULT SACGetProtocols(uint** ppdwProtocols, uint* pdwProtocolCount);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmdmlog/nn-wmdmlog-iwmdmlogger
@GUID("110a3200-5a79-11d3-8d78-444553540000")
interface IWMDMLogger : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmdmlog/nf-wmdmlog-iwmdmlogger-isenabled
    HRESULT IsEnabled(BOOL* pfEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmdmlog/nf-wmdmlog-iwmdmlogger-enable
    HRESULT Enable(BOOL fEnable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmdmlog/nf-wmdmlog-iwmdmlogger-getlogfilename
    HRESULT GetLogFileName(PSTR pszFilename, uint nMaxChars);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmdmlog/nf-wmdmlog-iwmdmlogger-setlogfilename
    HRESULT SetLogFileName(PSTR pszFilename);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmdmlog/nf-wmdmlog-iwmdmlogger-logstring
    HRESULT LogString(uint dwFlags, PSTR pszSrcName, PSTR pszLog);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmdmlog/nf-wmdmlog-iwmdmlogger-logdword
    HRESULT LogDword(uint dwFlags, PSTR pszSrcName, PSTR pszLogFormat, uint dwLog);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmdmlog/nf-wmdmlog-iwmdmlogger-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmdmlog/nf-wmdmlog-iwmdmlogger-getsizeparams
    HRESULT GetSizeParams(uint* pdwMaxSize, uint* pdwShrinkToSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmdmlog/nf-wmdmlog-iwmdmlogger-setsizeparams
    HRESULT SetSizeParams(uint dwMaxSize, uint dwShrinkToSize);
}


// GUIDs

const GUID CLSID_MediaDevMgr             = GUIDOF!MediaDevMgr;
const GUID CLSID_MediaDevMgrClassFactory = GUIDOF!MediaDevMgrClassFactory;
const GUID CLSID_WMDMDevice              = GUIDOF!WMDMDevice;
const GUID CLSID_WMDMDeviceEnum          = GUIDOF!WMDMDeviceEnum;
const GUID CLSID_WMDMLogger              = GUIDOF!WMDMLogger;
const GUID CLSID_WMDMStorage             = GUIDOF!WMDMStorage;
const GUID CLSID_WMDMStorageEnum         = GUIDOF!WMDMStorageEnum;
const GUID CLSID_WMDMStorageGlobal       = GUIDOF!WMDMStorageGlobal;

const GUID IID_IComponentAuthenticate  = GUIDOF!IComponentAuthenticate;
const GUID IID_IMDSPDevice             = GUIDOF!IMDSPDevice;
const GUID IID_IMDSPDevice2            = GUIDOF!IMDSPDevice2;
const GUID IID_IMDSPDevice3            = GUIDOF!IMDSPDevice3;
const GUID IID_IMDSPDeviceControl      = GUIDOF!IMDSPDeviceControl;
const GUID IID_IMDSPDirectTransfer     = GUIDOF!IMDSPDirectTransfer;
const GUID IID_IMDSPEnumDevice         = GUIDOF!IMDSPEnumDevice;
const GUID IID_IMDSPEnumStorage        = GUIDOF!IMDSPEnumStorage;
const GUID IID_IMDSPObject             = GUIDOF!IMDSPObject;
const GUID IID_IMDSPObject2            = GUIDOF!IMDSPObject2;
const GUID IID_IMDSPObjectInfo         = GUIDOF!IMDSPObjectInfo;
const GUID IID_IMDSPRevoked            = GUIDOF!IMDSPRevoked;
const GUID IID_IMDSPStorage            = GUIDOF!IMDSPStorage;
const GUID IID_IMDSPStorage2           = GUIDOF!IMDSPStorage2;
const GUID IID_IMDSPStorage3           = GUIDOF!IMDSPStorage3;
const GUID IID_IMDSPStorage4           = GUIDOF!IMDSPStorage4;
const GUID IID_IMDSPStorageGlobals     = GUIDOF!IMDSPStorageGlobals;
const GUID IID_IMDServiceProvider      = GUIDOF!IMDServiceProvider;
const GUID IID_IMDServiceProvider2     = GUIDOF!IMDServiceProvider2;
const GUID IID_IMDServiceProvider3     = GUIDOF!IMDServiceProvider3;
const GUID IID_ISCPSecureAuthenticate  = GUIDOF!ISCPSecureAuthenticate;
const GUID IID_ISCPSecureAuthenticate2 = GUIDOF!ISCPSecureAuthenticate2;
const GUID IID_ISCPSecureExchange      = GUIDOF!ISCPSecureExchange;
const GUID IID_ISCPSecureExchange2     = GUIDOF!ISCPSecureExchange2;
const GUID IID_ISCPSecureExchange3     = GUIDOF!ISCPSecureExchange3;
const GUID IID_ISCPSecureQuery         = GUIDOF!ISCPSecureQuery;
const GUID IID_ISCPSecureQuery2        = GUIDOF!ISCPSecureQuery2;
const GUID IID_ISCPSecureQuery3        = GUIDOF!ISCPSecureQuery3;
const GUID IID_ISCPSession             = GUIDOF!ISCPSession;
const GUID IID_IWMDMDevice             = GUIDOF!IWMDMDevice;
const GUID IID_IWMDMDevice2            = GUIDOF!IWMDMDevice2;
const GUID IID_IWMDMDevice3            = GUIDOF!IWMDMDevice3;
const GUID IID_IWMDMDeviceControl      = GUIDOF!IWMDMDeviceControl;
const GUID IID_IWMDMDeviceSession      = GUIDOF!IWMDMDeviceSession;
const GUID IID_IWMDMEnumDevice         = GUIDOF!IWMDMEnumDevice;
const GUID IID_IWMDMEnumStorage        = GUIDOF!IWMDMEnumStorage;
const GUID IID_IWMDMLogger             = GUIDOF!IWMDMLogger;
const GUID IID_IWMDMMetaData           = GUIDOF!IWMDMMetaData;
const GUID IID_IWMDMNotification       = GUIDOF!IWMDMNotification;
const GUID IID_IWMDMObjectInfo         = GUIDOF!IWMDMObjectInfo;
const GUID IID_IWMDMOperation          = GUIDOF!IWMDMOperation;
const GUID IID_IWMDMOperation2         = GUIDOF!IWMDMOperation2;
const GUID IID_IWMDMOperation3         = GUIDOF!IWMDMOperation3;
const GUID IID_IWMDMProgress           = GUIDOF!IWMDMProgress;
const GUID IID_IWMDMProgress2          = GUIDOF!IWMDMProgress2;
const GUID IID_IWMDMProgress3          = GUIDOF!IWMDMProgress3;
const GUID IID_IWMDMRevoked            = GUIDOF!IWMDMRevoked;
const GUID IID_IWMDMStorage            = GUIDOF!IWMDMStorage;
const GUID IID_IWMDMStorage2           = GUIDOF!IWMDMStorage2;
const GUID IID_IWMDMStorage3           = GUIDOF!IWMDMStorage3;
const GUID IID_IWMDMStorage4           = GUIDOF!IWMDMStorage4;
const GUID IID_IWMDMStorageControl     = GUIDOF!IWMDMStorageControl;
const GUID IID_IWMDMStorageControl2    = GUIDOF!IWMDMStorageControl2;
const GUID IID_IWMDMStorageControl3    = GUIDOF!IWMDMStorageControl3;
const GUID IID_IWMDMStorageGlobals     = GUIDOF!IWMDMStorageGlobals;
const GUID IID_IWMDeviceManager        = GUIDOF!IWMDeviceManager;
const GUID IID_IWMDeviceManager2       = GUIDOF!IWMDeviceManager2;
const GUID IID_IWMDeviceManager3       = GUIDOF!IWMDeviceManager3;
