// Written in the D programming language.

module windows.win32.devices.portabledevices;

public import windows.core;
public import system : Guid;
public import windows.win32.devices.properties : DEVPROPTYPE;
public import windows.win32.foundation : BOOL, BSTR, DEVPROPKEY, HRESULT, PROPERTYKEY,
                                         PWSTR;
public import windows.win32.system.com : IDispatch, IStream, IUnknown;
public import windows.win32.system.com.structuredstorage : PROPVARIANT;
public import windows.win32.ui.shell.propertiessystem : IPropertyStore;

extern(Windows) @nogc nothrow:


// Enums

//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/delete-object-options))], [])
alias DELETE_OBJECT_OPTIONS = int;
enum : int
{
    PORTABLE_DEVICE_DELETE_NO_RECURSION   = 0x00000000,
    PORTABLE_DEVICE_DELETE_WITH_RECURSION = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-device-types))], [])
alias WPD_DEVICE_TYPES = int;
enum : int
{
    WPD_DEVICE_TYPE_GENERIC                      = 0x00000000,
    WPD_DEVICE_TYPE_CAMERA                       = 0x00000001,
    WPD_DEVICE_TYPE_MEDIA_PLAYER                 = 0x00000002,
    WPD_DEVICE_TYPE_PHONE                        = 0x00000003,
    WPD_DEVICE_TYPE_VIDEO                        = 0x00000004,
    WPD_DEVICE_TYPE_PERSONAL_INFORMATION_MANAGER = 0x00000005,
    WPD_DEVICE_TYPE_AUDIO_RECORDER               = 0x00000006,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpdattributeform))], [])
enum WpdAttributeForm : int
{
    WPD_PROPERTY_ATTRIBUTE_FORM_UNSPECIFIED        = 0x00000000,
    WPD_PROPERTY_ATTRIBUTE_FORM_RANGE              = 0x00000001,
    WPD_PROPERTY_ATTRIBUTE_FORM_ENUMERATION        = 0x00000002,
    WPD_PROPERTY_ATTRIBUTE_FORM_REGULAR_EXPRESSION = 0x00000003,
    WPD_PROPERTY_ATTRIBUTE_FORM_OBJECT_IDENTIFIER  = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-parameter-attribute-form))], [])
enum WpdParameterAttributeForm : int
{
    WPD_PARAMETER_ATTRIBUTE_FORM_UNSPECIFIED        = 0x00000000,
    WPD_PARAMETER_ATTRIBUTE_FORM_RANGE              = 0x00000001,
    WPD_PARAMETER_ATTRIBUTE_FORM_ENUMERATION        = 0x00000002,
    WPD_PARAMETER_ATTRIBUTE_FORM_REGULAR_EXPRESSION = 0x00000003,
    WPD_PARAMETER_ATTRIBUTE_FORM_OBJECT_IDENTIFIER  = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-device-transports))], [])
alias WPD_DEVICE_TRANSPORTS = int;
enum : int
{
    WPD_DEVICE_TRANSPORT_UNSPECIFIED = 0x00000000,
    WPD_DEVICE_TRANSPORT_USB         = 0x00000001,
    WPD_DEVICE_TRANSPORT_IP          = 0x00000002,
    WPD_DEVICE_TRANSPORT_BLUETOOTH   = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-storage-type-values))], [])
alias WPD_STORAGE_TYPE_VALUES = int;
enum : int
{
    WPD_STORAGE_TYPE_UNDEFINED     = 0x00000000,
    WPD_STORAGE_TYPE_FIXED_ROM     = 0x00000001,
    WPD_STORAGE_TYPE_REMOVABLE_ROM = 0x00000002,
    WPD_STORAGE_TYPE_FIXED_RAM     = 0x00000003,
    WPD_STORAGE_TYPE_REMOVABLE_RAM = 0x00000004,
}
alias WPD_STORAGE_ACCESS_CAPABILITY_VALUES = int;
enum : int
{
    WPD_STORAGE_ACCESS_CAPABILITY_READWRITE                         = 0x00000000,
    WPD_STORAGE_ACCESS_CAPABILITY_READ_ONLY_WITHOUT_OBJECT_DELETION = 0x00000001,
    WPD_STORAGE_ACCESS_CAPABILITY_READ_ONLY_WITH_OBJECT_DELETION    = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-sms-encoding-types))], [])
alias WPD_SMS_ENCODING_TYPES = int;
enum : int
{
    SMS_ENCODING_7_BIT  = 0x00000000,
    SMS_ENCODING_8_BIT  = 0x00000001,
    SMS_ENCODING_UTF_16 = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/sms-message-types))], [])
alias SMS_MESSAGE_TYPES = int;
enum : int
{
    SMS_TEXT_MESSAGE   = 0x00000000,
    SMS_BINARY_MESSAGE = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-power-sources))], [])
alias WPD_POWER_SOURCES = int;
enum : int
{
    WPD_POWER_SOURCE_BATTERY  = 0x00000000,
    WPD_POWER_SOURCE_EXTERNAL = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-white-balance-settings))], [])
alias WPD_WHITE_BALANCE_SETTINGS = int;
enum : int
{
    WPD_WHITE_BALANCE_UNDEFINED          = 0x00000000,
    WPD_WHITE_BALANCE_MANUAL             = 0x00000001,
    WPD_WHITE_BALANCE_AUTOMATIC          = 0x00000002,
    WPD_WHITE_BALANCE_ONE_PUSH_AUTOMATIC = 0x00000003,
    WPD_WHITE_BALANCE_DAYLIGHT           = 0x00000004,
    WPD_WHITE_BALANCE_FLORESCENT         = 0x00000005,
    WPD_WHITE_BALANCE_TUNGSTEN           = 0x00000006,
    WPD_WHITE_BALANCE_FLASH              = 0x00000007,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-focus-modes))], [])
alias WPD_FOCUS_MODES = int;
enum : int
{
    WPD_FOCUS_UNDEFINED       = 0x00000000,
    WPD_FOCUS_MANUAL          = 0x00000001,
    WPD_FOCUS_AUTOMATIC       = 0x00000002,
    WPD_FOCUS_AUTOMATIC_MACRO = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-exposure-metering-modes))], [])
alias WPD_EXPOSURE_METERING_MODES = int;
enum : int
{
    WPD_EXPOSURE_METERING_MODE_UNDEFINED               = 0x00000000,
    WPD_EXPOSURE_METERING_MODE_AVERAGE                 = 0x00000001,
    WPD_EXPOSURE_METERING_MODE_CENTER_WEIGHTED_AVERAGE = 0x00000002,
    WPD_EXPOSURE_METERING_MODE_MULTI_SPOT              = 0x00000003,
    WPD_EXPOSURE_METERING_MODE_CENTER_SPOT             = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-flash-modes))], [])
alias WPD_FLASH_MODES = int;
enum : int
{
    WPD_FLASH_MODE_UNDEFINED     = 0x00000000,
    WPD_FLASH_MODE_AUTO          = 0x00000001,
    WPD_FLASH_MODE_OFF           = 0x00000002,
    WPD_FLASH_MODE_FILL          = 0x00000003,
    WPD_FLASH_MODE_RED_EYE_AUTO  = 0x00000004,
    WPD_FLASH_MODE_RED_EYE_FILL  = 0x00000005,
    WPD_FLASH_MODE_EXTERNAL_SYNC = 0x00000006,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-exposure-program-modes))], [])
alias WPD_EXPOSURE_PROGRAM_MODES = int;
enum : int
{
    WPD_EXPOSURE_PROGRAM_MODE_UNDEFINED         = 0x00000000,
    WPD_EXPOSURE_PROGRAM_MODE_MANUAL            = 0x00000001,
    WPD_EXPOSURE_PROGRAM_MODE_AUTO              = 0x00000002,
    WPD_EXPOSURE_PROGRAM_MODE_APERTURE_PRIORITY = 0x00000003,
    WPD_EXPOSURE_PROGRAM_MODE_SHUTTER_PRIORITY  = 0x00000004,
    WPD_EXPOSURE_PROGRAM_MODE_CREATIVE          = 0x00000005,
    WPD_EXPOSURE_PROGRAM_MODE_ACTION            = 0x00000006,
    WPD_EXPOSURE_PROGRAM_MODE_PORTRAIT          = 0x00000007,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-capture-modes))], [])
alias WPD_CAPTURE_MODES = int;
enum : int
{
    WPD_CAPTURE_MODE_UNDEFINED = 0x00000000,
    WPD_CAPTURE_MODE_NORMAL    = 0x00000001,
    WPD_CAPTURE_MODE_BURST     = 0x00000002,
    WPD_CAPTURE_MODE_TIMELAPSE = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-effect-modes))], [])
alias WPD_EFFECT_MODES = int;
enum : int
{
    WPD_EFFECT_MODE_UNDEFINED       = 0x00000000,
    WPD_EFFECT_MODE_COLOR           = 0x00000001,
    WPD_EFFECT_MODE_BLACK_AND_WHITE = 0x00000002,
    WPD_EFFECT_MODE_SEPIA           = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-focus-metering-modes))], [])
alias WPD_FOCUS_METERING_MODES = int;
enum : int
{
    WPD_FOCUS_METERING_MODE_UNDEFINED   = 0x00000000,
    WPD_FOCUS_METERING_MODE_CENTER_SPOT = 0x00000001,
    WPD_FOCUS_METERING_MODE_MULTI_SPOT  = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-bitrate-types))], [])
alias WPD_BITRATE_TYPES = int;
enum : int
{
    WPD_BITRATE_TYPE_UNUSED   = 0x00000000,
    WPD_BITRATE_TYPE_DISCRETE = 0x00000001,
    WPD_BITRATE_TYPE_VARIABLE = 0x00000002,
    WPD_BITRATE_TYPE_FREE     = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-meta-genres))], [])
alias WPD_META_GENRES = int;
enum : int
{
    WPD_META_GENRE_UNUSED                           = 0x00000000,
    WPD_META_GENRE_GENERIC_MUSIC_AUDIO_FILE         = 0x00000001,
    WPD_META_GENRE_GENERIC_NON_MUSIC_AUDIO_FILE     = 0x00000011,
    WPD_META_GENRE_SPOKEN_WORD_AUDIO_BOOK_FILES     = 0x00000012,
    WPD_META_GENRE_SPOKEN_WORD_FILES_NON_AUDIO_BOOK = 0x00000013,
    WPD_META_GENRE_SPOKEN_WORD_NEWS                 = 0x00000014,
    WPD_META_GENRE_SPOKEN_WORD_TALK_SHOWS           = 0x00000015,
    WPD_META_GENRE_GENERIC_VIDEO_FILE               = 0x00000021,
    WPD_META_GENRE_NEWS_VIDEO_FILE                  = 0x00000022,
    WPD_META_GENRE_MUSIC_VIDEO_FILE                 = 0x00000023,
    WPD_META_GENRE_HOME_VIDEO_FILE                  = 0x00000024,
    WPD_META_GENRE_FEATURE_FILM_VIDEO_FILE          = 0x00000025,
    WPD_META_GENRE_TELEVISION_VIDEO_FILE            = 0x00000026,
    WPD_META_GENRE_TRAINING_EDUCATIONAL_VIDEO_FILE  = 0x00000027,
    WPD_META_GENRE_PHOTO_MONTAGE_VIDEO_FILE         = 0x00000028,
    WPD_META_GENRE_GENERIC_NON_AUDIO_NON_VIDEO      = 0x00000030,
    WPD_META_GENRE_AUDIO_PODCAST                    = 0x00000040,
    WPD_META_GENRE_VIDEO_PODCAST                    = 0x00000041,
    WPD_META_GENRE_MIXED_PODCAST                    = 0x00000042,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-cropped-status-values))], [])
alias WPD_CROPPED_STATUS_VALUES = int;
enum : int
{
    WPD_CROPPED_STATUS_NOT_CROPPED           = 0x00000000,
    WPD_CROPPED_STATUS_CROPPED               = 0x00000001,
    WPD_CROPPED_STATUS_SHOULD_NOT_BE_CROPPED = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-color-corrected-status-values))], [])
alias WPD_COLOR_CORRECTED_STATUS_VALUES = int;
enum : int
{
    WPD_COLOR_CORRECTED_STATUS_NOT_CORRECTED           = 0x00000000,
    WPD_COLOR_CORRECTED_STATUS_CORRECTED               = 0x00000001,
    WPD_COLOR_CORRECTED_STATUS_SHOULD_NOT_BE_CORRECTED = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-video-scan-types))], [])
alias WPD_VIDEO_SCAN_TYPES = int;
enum : int
{
    WPD_VIDEO_SCAN_TYPE_UNUSED                          = 0x00000000,
    WPD_VIDEO_SCAN_TYPE_PROGRESSIVE                     = 0x00000001,
    WPD_VIDEO_SCAN_TYPE_FIELD_INTERLEAVED_UPPER_FIRST   = 0x00000002,
    WPD_VIDEO_SCAN_TYPE_FIELD_INTERLEAVED_LOWER_FIRST   = 0x00000003,
    WPD_VIDEO_SCAN_TYPE_FIELD_SINGLE_UPPER_FIRST        = 0x00000004,
    WPD_VIDEO_SCAN_TYPE_FIELD_SINGLE_LOWER_FIRST        = 0x00000005,
    WPD_VIDEO_SCAN_TYPE_MIXED_INTERLACE                 = 0x00000006,
    WPD_VIDEO_SCAN_TYPE_MIXED_INTERLACE_AND_PROGRESSIVE = 0x00000007,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-operation-states))], [])
alias WPD_OPERATION_STATES = int;
enum : int
{
    WPD_OPERATION_STATE_UNSPECIFIED = 0x00000000,
    WPD_OPERATION_STATE_STARTED     = 0x00000001,
    WPD_OPERATION_STATE_RUNNING     = 0x00000002,
    WPD_OPERATION_STATE_PAUSED      = 0x00000003,
    WPD_OPERATION_STATE_CANCELLED   = 0x00000004,
    WPD_OPERATION_STATE_FINISHED    = 0x00000005,
    WPD_OPERATION_STATE_ABORTED     = 0x00000006,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-section-data-units-values))], [])
alias WPD_SECTION_DATA_UNITS_VALUES = int;
enum : int
{
    WPD_SECTION_DATA_UNITS_BYTES        = 0x00000000,
    WPD_SECTION_DATA_UNITS_MILLISECONDS = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-rendering-information-profile-entry-types))], [])
alias WPD_RENDERING_INFORMATION_PROFILE_ENTRY_TYPES = int;
enum : int
{
    WPD_RENDERING_INFORMATION_PROFILE_ENTRY_TYPE_OBJECT   = 0x00000000,
    WPD_RENDERING_INFORMATION_PROFILE_ENTRY_TYPE_RESOURCE = 0x00000001,
}
alias WPD_COMMAND_ACCESS_TYPES = int;
enum : int
{
    WPD_COMMAND_ACCESS_READ                              = 0x00000001,
    WPD_COMMAND_ACCESS_READWRITE                         = 0x00000003,
    WPD_COMMAND_ACCESS_FROM_PROPERTY_WITH_STGM_ACCESS    = 0x00000004,
    WPD_COMMAND_ACCESS_FROM_PROPERTY_WITH_FILE_ACCESS    = 0x00000008,
    WPD_COMMAND_ACCESS_FROM_ATTRIBUTE_WITH_METHOD_ACCESS = 0x00000010,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-service-inheritance-types2))], [])
alias WPD_SERVICE_INHERITANCE_TYPES = int;
enum : int
{
    WPD_SERVICE_INHERITANCE_IMPLEMENTATION = 0x00000000,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-parameter-usage-types))], [])
alias WPD_PARAMETER_USAGE_TYPES = int;
enum : int
{
    WPD_PARAMETER_USAGE_RETURN = 0x00000000,
    WPD_PARAMETER_USAGE_IN     = 0x00000001,
    WPD_PARAMETER_USAGE_OUT    = 0x00000002,
    WPD_PARAMETER_USAGE_INOUT  = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-stream-units))], [])
alias WPD_STREAM_UNITS = int;
enum : int
{
    WPD_STREAM_UNITS_BYTES        = 0x00000000,
    WPD_STREAM_UNITS_FRAMES       = 0x00000001,
    WPD_STREAM_UNITS_ROWS         = 0x00000002,
    WPD_STREAM_UNITS_MILLISECONDS = 0x00000004,
    WPD_STREAM_UNITS_MICROSECONDS = 0x00000008,
}
alias DEVICE_RADIO_STATE = int;
enum : int
{
    DRS_RADIO_ON                    = 0x00000000,
    DRS_SW_RADIO_OFF                = 0x00000001,
    DRS_HW_RADIO_OFF                = 0x00000002,
    DRS_SW_HW_RADIO_OFF             = 0x00000003,
    DRS_HW_RADIO_ON_UNCONTROLLABLE  = 0x00000004,
    DRS_RADIO_INVALID               = 0x00000005,
    DRS_HW_RADIO_OFF_UNCONTROLLABLE = 0x00000006,
    DRS_RADIO_MAX                   = 0x00000006,
}
alias SYSTEM_RADIO_STATE = int;
enum : int
{
    SRS_RADIO_ENABLED  = 0x00000000,
    SRS_RADIO_DISABLED = 0x00000001,
}

// Constants


enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3927062522, 22685, 17522, 132, 228, 10, 190, 54, 253, 98, 239}, 2))], [])*/DEVPROPKEY DEVPKEY_MTPBTH_IsConnected = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3927062522, 22685, 17522, 132, 228, 10, 190, 54, 253, 98, 239}, 2))], [])*/DEVPROPKEY(GUID("EA1237FA-589D-4472-84E4-0ABE36FD62EF"), 2);

enum : GUID
{
    GUID_DEVINTERFACE_WPD         = GUID("6ac27878-a6fa-4155-ba85-f98f491d4f33"),
    GUID_DEVINTERFACE_WPD_PRIVATE = GUID("ba0c718f-4ded-49b7-bdd3-fabe28661211"),
    GUID_DEVINTERFACE_WPD_SERVICE = GUID("9ef44f80-3d64-4246-a6aa-206f328d1edc"),
}

enum uint WPD_CONTROL_FUNCTION_GENERIC_MESSAGE = 0x00000042;

enum : uint
{
    IOCTL_WPD_MESSAGE_READWRITE_ACCESS = 0x0040c108,
    IOCTL_WPD_MESSAGE_READ_ACCESS      = 0x00404108,
}

enum const(wchar)* WPD_DEVICE_OBJECT_ID = "DEVICE";

enum : const(wchar)*
{
    PORTABLE_DEVICE_TYPE                              = "PortableDeviceType",
    PORTABLE_DEVICE_ICON                              = "Icons",
    PORTABLE_DEVICE_NAMESPACE_TIMEOUT                 = "PortableDeviceNameSpaceTimeout",
    PORTABLE_DEVICE_NAMESPACE_EXCLUDE_FROM_SHELL      = "PortableDeviceNameSpaceExcludeFromShell",
    PORTABLE_DEVICE_NAMESPACE_THUMBNAIL_CONTENT_TYPES = "PortableDeviceNameSpaceThumbnailContentTypes",
}

enum : const(wchar)*
{
    PORTABLE_DEVICE_IS_MASS_STORAGE       = "PortableDeviceIsMassStorage",
    PORTABLE_DEVICE_DRM_SCHEME_WMDRM10_PD = "WMDRM10-PD",
    PORTABLE_DEVICE_DRM_SCHEME_PDDRM      = "PDDRM",
}

enum uint FACILITY_WPD = 0x0000002a;

enum : HRESULT
{
    E_WPD_DEVICE_ALREADY_OPENED = HRESULT(0x802a0001),
    E_WPD_DEVICE_NOT_OPEN       = HRESULT(0x802a0002),
}

enum HRESULT E_WPD_OBJECT_ALREADY_ATTACHED_TO_DEVICE = HRESULT(0x802a0003);

enum : HRESULT
{
    E_WPD_OBJECT_NOT_ATTACHED_TO_DEVICE = HRESULT(0x802a0004),
    E_WPD_OBJECT_NOT_COMMITED           = HRESULT(0x802a0005),
}

enum HRESULT E_WPD_DEVICE_IS_HUNG = HRESULT(0x802a0006);

enum : HRESULT
{
    E_WPD_SMS_INVALID_RECIPIENT    = HRESULT(0x802a0064),
    E_WPD_SMS_INVALID_MESSAGE_BODY = HRESULT(0x802a0065),
}

enum HRESULT E_WPD_SMS_SERVICE_UNAVAILABLE = HRESULT(0x802a0066);

enum : HRESULT
{
    E_WPD_SERVICE_ALREADY_OPENED = HRESULT(0x802a00c8),
    E_WPD_SERVICE_NOT_OPEN       = HRESULT(0x802a00c9),
}

enum HRESULT E_WPD_OBJECT_ALREADY_ATTACHED_TO_SERVICE = HRESULT(0x802a00ca);
enum HRESULT E_WPD_OBJECT_NOT_ATTACHED_TO_SERVICE = HRESULT(0x802a00cb);
enum HRESULT E_WPD_SERVICE_BAD_PARAMETER_ORDER = HRESULT(0x802a00cc);

enum : GUID
{
    WPD_EVENT_NOTIFICATION                = GUID("2ba2e40a-6b4c-4295-bb43-26322b99aeb2"),
    WPD_EVENT_OBJECT_ADDED                = GUID("a726da95-e207-4b02-8d44-bef2e86cbffc"),
    WPD_EVENT_OBJECT_REMOVED              = GUID("be82ab88-a52c-4823-96e5-d0272671fc38"),
    WPD_EVENT_OBJECT_UPDATED              = GUID("1445a759-2e01-485d-9f27-ff07dae697ab"),
    WPD_EVENT_DEVICE_RESET                = GUID("7755cf53-c1ed-44f3-b5a2-451e2c376b27"),
    WPD_EVENT_DEVICE_CAPABILITIES_UPDATED = GUID("36885aa1-cd54-4daa-b3d0-afb3e03f5999"),
}

enum : GUID
{
    WPD_EVENT_STORAGE_FORMAT            = GUID("3782616b-22bc-4474-a251-3070f8d38857"),
    WPD_EVENT_OBJECT_TRANSFER_REQUESTED = GUID("8d16a0a1-f2c6-41da-8f19-5e53721adbf2"),
}

enum : GUID
{
    WPD_EVENT_DEVICE_REMOVED          = GUID("e4cbca1b-6918-48b9-85ee-02be7c850af9"),
    WPD_EVENT_SERVICE_METHOD_COMPLETE = GUID("8a33f5f8-0acc-4d9b-9cc4-112d353b86ca"),
}

enum : GUID
{
    WPD_CONTENT_TYPE_FUNCTIONAL_OBJECT   = GUID("99ed0160-17ff-4c44-9d98-1d7a6f941921"),
    WPD_CONTENT_TYPE_FOLDER              = GUID("27e2e392-a111-48e0-ab0c-e17705a05f85"),
    WPD_CONTENT_TYPE_IMAGE               = GUID("ef2107d5-a52a-4243-a26b-62d4176d7603"),
    WPD_CONTENT_TYPE_DOCUMENT            = GUID("680adf52-950a-4041-9b41-65e393648155"),
    WPD_CONTENT_TYPE_CONTACT             = GUID("eaba8313-4525-4707-9f0e-87c6808e9435"),
    WPD_CONTENT_TYPE_CONTACT_GROUP       = GUID("346b8932-4c36-40d8-9415-1828291f9de9"),
    WPD_CONTENT_TYPE_AUDIO               = GUID("4ad2c85e-5e2d-45e5-8864-4f229e3c6cf0"),
    WPD_CONTENT_TYPE_VIDEO               = GUID("9261b03c-3d78-4519-85e3-02c5e1f50bb9"),
    WPD_CONTENT_TYPE_TELEVISION          = GUID("60a169cf-f2ae-4e21-9375-9677f11c1c6e"),
    WPD_CONTENT_TYPE_PLAYLIST            = GUID("1a33f7e4-af13-48f5-994e-77369dfe04a3"),
    WPD_CONTENT_TYPE_MIXED_CONTENT_ALBUM = GUID("00f0c3ac-a593-49ac-9219-24abca5a2563"),
    WPD_CONTENT_TYPE_AUDIO_ALBUM         = GUID("aa18737e-5009-48fa-ae21-85f24383b4e6"),
    WPD_CONTENT_TYPE_IMAGE_ALBUM         = GUID("75793148-15f5-4a30-a813-54ed8a37e226"),
    WPD_CONTENT_TYPE_VIDEO_ALBUM         = GUID("012b0db7-d4c1-45d6-b081-94b87779614f"),
    WPD_CONTENT_TYPE_MEMO                = GUID("9cd20ecf-3b50-414f-a641-e473ffe45751"),
    WPD_CONTENT_TYPE_EMAIL               = GUID("8038044a-7e51-4f8f-883d-1d0623d14533"),
    WPD_CONTENT_TYPE_APPOINTMENT         = GUID("0fed060e-8793-4b1e-90c9-48ac389ac631"),
    WPD_CONTENT_TYPE_TASK                = GUID("63252f2c-887f-4cb6-b1ac-d29855dcef6c"),
    WPD_CONTENT_TYPE_PROGRAM             = GUID("d269f96a-247c-4bff-98fb-97f3c49220e6"),
    WPD_CONTENT_TYPE_GENERIC_FILE        = GUID("0085e0a6-8d34-45d7-bc5c-447e59c73d48"),
    WPD_CONTENT_TYPE_CALENDAR            = GUID("a1fd5967-6023-49a0-9df1-f8060be751b0"),
    WPD_CONTENT_TYPE_GENERIC_MESSAGE     = GUID("e80eaaf8-b2db-4133-b67e-1bef4b4a6e5f"),
    WPD_CONTENT_TYPE_NETWORK_ASSOCIATION = GUID("031da7ee-18c8-4205-847e-89a11261d0f3"),
    WPD_CONTENT_TYPE_CERTIFICATE         = GUID("dc3876e8-a948-4060-9050-cbd77e8a3d87"),
    WPD_CONTENT_TYPE_WIRELESS_PROFILE    = GUID("0bac070a-9f5f-4da4-a8f6-3de44d68fd6c"),
    WPD_CONTENT_TYPE_MEDIA_CAST          = GUID("5e88b3cc-3e65-4e62-bfff-229495253ab0"),
    WPD_CONTENT_TYPE_SECTION             = GUID("821089f5-1d91-4dc9-be3c-bbb1b35b18ce"),
    WPD_CONTENT_TYPE_UNSPECIFIED         = GUID("28d8d31e-249c-454e-aabc-34883168e634"),
    WPD_CONTENT_TYPE_ALL                 = GUID("80e170d2-1055-4a3e-b952-82cc4f8a8689"),
}

enum : GUID
{
    WPD_FUNCTIONAL_CATEGORY_DEVICE                = GUID("08ea466b-e3a4-4336-a1f3-a44d2b5c438c"),
    WPD_FUNCTIONAL_CATEGORY_STORAGE               = GUID("23f05bbc-15de-4c2a-a55b-a9af5ce412ef"),
    WPD_FUNCTIONAL_CATEGORY_STILL_IMAGE_CAPTURE   = GUID("613ca327-ab93-4900-b4fa-895bb5874b79"),
    WPD_FUNCTIONAL_CATEGORY_AUDIO_CAPTURE         = GUID("3f2a1919-c7c2-4a00-855d-f57cf06debbb"),
    WPD_FUNCTIONAL_CATEGORY_VIDEO_CAPTURE         = GUID("e23e5f6b-7243-43aa-8df1-0eb3d968a918"),
    WPD_FUNCTIONAL_CATEGORY_SMS                   = GUID("0044a0b1-c1e9-4afd-b358-a62c6117c9cf"),
    WPD_FUNCTIONAL_CATEGORY_RENDERING_INFORMATION = GUID("08600ba4-a7ba-4a01-ab0e-0065d0a356d3"),
    WPD_FUNCTIONAL_CATEGORY_NETWORK_CONFIGURATION = GUID("48f4db72-7c6a-4ab0-9e1a-470e3cdbf26a"),
    WPD_FUNCTIONAL_CATEGORY_ALL                   = GUID("2d8a6512-a74c-448e-ba8a-f4ac07c49399"),
}

enum : GUID
{
    WPD_OBJECT_FORMAT_ICON                = GUID("077232ed-102c-4638-9c22-83f142bfc822"),
    WPD_OBJECT_FORMAT_M4A                 = GUID("30aba7ac-6ffd-4c23-a359-3e9b52f3f1c8"),
    WPD_OBJECT_FORMAT_NETWORK_ASSOCIATION = GUID("b1020000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_X509V3CERTIFICATE   = GUID("b1030000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_MICROSOFT_WFC       = GUID("b1040000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_3GPA                = GUID("e5172730-f971-41ef-a10b-2271a0019d7a"),
    WPD_OBJECT_FORMAT_3G2A                = GUID("1a11202d-8759-4e34-ba5e-b1211087eee4"),
    WPD_OBJECT_FORMAT_ALL                 = GUID("c1f62eb2-4bb3-479c-9cfa-05b5f3a57b22"),
}

enum GUID WPD_CATEGORY_NULL = GUID("00000000-0000-0000-0000-000000000000");
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 0))], [])*/PROPERTYKEY WPD_PROPERTY_NULL = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 0))], [])*/PROPERTYKEY(GUID("00000000-0000-0000-0000-000000000000"), 0);
enum GUID WPD_OBJECT_PROPERTIES_V1 = GUID("ef6b490d-5cd8-437a-affc-da8b60ee4a3c");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4016785677, 23768, 17274, 175, 252, 218, 139, 96, 238, 74, 60}, 7))], [])*/PROPERTYKEY
{
    WPD_OBJECT_CONTENT_TYPE                   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4016785677, 23768, 17274, 175, 252, 218, 139, 96, 238, 74, 60}, 7))], [])*/PROPERTYKEY(GUID("EF6B490D-5CD8-437A-AFFC-DA8B60EE4A3C"), 7),
    WPD_OBJECT_REFERENCES                     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4016785677, 23768, 17274, 175, 252, 218, 139, 96, 238, 74, 60}, 7))], [])*/PROPERTYKEY(GUID("EF6B490D-5CD8-437A-AFFC-DA8B60EE4A3C"), 14),
    WPD_OBJECT_CONTAINER_FUNCTIONAL_OBJECT_ID = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4016785677, 23768, 17274, 175, 252, 218, 139, 96, 238, 74, 60}, 7))], [])*/PROPERTYKEY(GUID("EF6B490D-5CD8-437A-AFFC-DA8B60EE4A3C"), 23),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4016785677, 23768, 17274, 175, 252, 218, 139, 96, 238, 74, 60}, 24))], [])*/PROPERTYKEY WPD_OBJECT_GENERATE_THUMBNAIL_FROM_RESOURCE = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4016785677, 23768, 17274, 175, 252, 218, 139, 96, 238, 74, 60}, 24))], [])*/PROPERTYKEY(GUID("EF6B490D-5CD8-437A-AFFC-DA8B60EE4A3C"), 24);
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4016785677, 23768, 17274, 175, 252, 218, 139, 96, 238, 74, 60}, 25))], [])*/PROPERTYKEY WPD_OBJECT_HINT_LOCATION_DISPLAY_NAME = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4016785677, 23768, 17274, 175, 252, 218, 139, 96, 238, 74, 60}, 25))], [])*/PROPERTYKEY(GUID("EF6B490D-5CD8-437A-AFFC-DA8B60EE4A3C"), 25);
enum GUID WPD_OBJECT_PROPERTIES_V2 = GUID("0373cd3d-4a46-40d7-b4d8-73e8da74e775");
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({57920829, 19014, 16599, 180, 216, 115, 232, 218, 116, 231, 117}, 2))], [])*/PROPERTYKEY WPD_OBJECT_SUPPORTED_UNITS = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({57920829, 19014, 16599, 180, 216, 115, 232, 218, 116, 231, 117}, 2))], [])*/PROPERTYKEY(GUID("0373CD3D-4A46-40D7-B4D8-73E8DA74E775"), 2);
enum GUID WPD_FUNCTIONAL_OBJECT_PROPERTIES_V1 = GUID("8f052d93-abca-4fc5-a5ac-b01df4dbe598");
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2399481235, 43978, 20421, 165, 172, 176, 29, 244, 219, 229, 152}, 2))], [])*/PROPERTYKEY WPD_FUNCTIONAL_OBJECT_CATEGORY = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2399481235, 43978, 20421, 165, 172, 176, 29, 244, 219, 229, 152}, 2))], [])*/PROPERTYKEY(GUID("8F052D93-ABCA-4FC5-A5AC-B01DF4DBE598"), 2);
enum GUID WPD_STORAGE_OBJECT_PROPERTIES_V1 = GUID("01a3057a-74d6-4e80-bea7-dc4c212ce50a");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({27460986, 29910, 20096, 190, 167, 220, 76, 33, 44, 229, 10}, 2))], [])*/PROPERTYKEY
{
    WPD_STORAGE_TYPE                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({27460986, 29910, 20096, 190, 167, 220, 76, 33, 44, 229, 10}, 2))], [])*/PROPERTYKEY(GUID("01A3057A-74D6-4E80-BEA7-DC4C212CE50A"), 2),
    WPD_STORAGE_FILE_SYSTEM_TYPE      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({27460986, 29910, 20096, 190, 167, 220, 76, 33, 44, 229, 10}, 2))], [])*/PROPERTYKEY(GUID("01A3057A-74D6-4E80-BEA7-DC4C212CE50A"), 3),
    WPD_STORAGE_CAPACITY              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({27460986, 29910, 20096, 190, 167, 220, 76, 33, 44, 229, 10}, 2))], [])*/PROPERTYKEY(GUID("01A3057A-74D6-4E80-BEA7-DC4C212CE50A"), 4),
    WPD_STORAGE_FREE_SPACE_IN_BYTES   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({27460986, 29910, 20096, 190, 167, 220, 76, 33, 44, 229, 10}, 2))], [])*/PROPERTYKEY(GUID("01A3057A-74D6-4E80-BEA7-DC4C212CE50A"), 5),
    WPD_STORAGE_FREE_SPACE_IN_OBJECTS = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({27460986, 29910, 20096, 190, 167, 220, 76, 33, 44, 229, 10}, 2))], [])*/PROPERTYKEY(GUID("01A3057A-74D6-4E80-BEA7-DC4C212CE50A"), 6),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({27460986, 29910, 20096, 190, 167, 220, 76, 33, 44, 229, 10}, 7))], [])*/PROPERTYKEY
{
    WPD_STORAGE_DESCRIPTION         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({27460986, 29910, 20096, 190, 167, 220, 76, 33, 44, 229, 10}, 7))], [])*/PROPERTYKEY(GUID("01A3057A-74D6-4E80-BEA7-DC4C212CE50A"), 7),
    WPD_STORAGE_SERIAL_NUMBER       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({27460986, 29910, 20096, 190, 167, 220, 76, 33, 44, 229, 10}, 7))], [])*/PROPERTYKEY(GUID("01A3057A-74D6-4E80-BEA7-DC4C212CE50A"), 8),
    WPD_STORAGE_MAX_OBJECT_SIZE     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({27460986, 29910, 20096, 190, 167, 220, 76, 33, 44, 229, 10}, 7))], [])*/PROPERTYKEY(GUID("01A3057A-74D6-4E80-BEA7-DC4C212CE50A"), 9),
    WPD_STORAGE_CAPACITY_IN_OBJECTS = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({27460986, 29910, 20096, 190, 167, 220, 76, 33, 44, 229, 10}, 7))], [])*/PROPERTYKEY(GUID("01A3057A-74D6-4E80-BEA7-DC4C212CE50A"), 10),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({27460986, 29910, 20096, 190, 167, 220, 76, 33, 44, 229, 10}, 11))], [])*/PROPERTYKEY WPD_STORAGE_ACCESS_CAPABILITY = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({27460986, 29910, 20096, 190, 167, 220, 76, 33, 44, 229, 10}, 11))], [])*/PROPERTYKEY(GUID("01A3057A-74D6-4E80-BEA7-DC4C212CE50A"), 11);
enum GUID WPD_NETWORK_ASSOCIATION_PROPERTIES_V1 = GUID("e4c93c1f-b203-43f1-a100-5a07d11b0274");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3838393375, 45571, 17393, 161, 0, 90, 7, 209, 27, 2, 116}, 2))], [])*/PROPERTYKEY
{
    WPD_NETWORK_ASSOCIATION_HOST_NETWORK_IDENTIFIERS = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3838393375, 45571, 17393, 161, 0, 90, 7, 209, 27, 2, 116}, 2))], [])*/PROPERTYKEY(GUID("E4C93C1F-B203-43F1-A100-5A07D11B0274"), 2),
    WPD_NETWORK_ASSOCIATION_X509V3SEQUENCE           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3838393375, 45571, 17393, 161, 0, 90, 7, 209, 27, 2, 116}, 2))], [])*/PROPERTYKEY(GUID("E4C93C1F-B203-43F1-A100-5A07D11B0274"), 3),
}

enum GUID WPD_STILL_IMAGE_CAPTURE_OBJECT_PROPERTIES_V1 = GUID("58c571ec-1bcb-42a7-8ac5-bb291573a260");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1489334764, 7115, 17063, 138, 197, 187, 41, 21, 115, 162, 96}, 2))], [])*/PROPERTYKEY
{
    WPD_STILL_IMAGE_CAPTURE_RESOLUTION         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1489334764, 7115, 17063, 138, 197, 187, 41, 21, 115, 162, 96}, 2))], [])*/PROPERTYKEY(GUID("58C571EC-1BCB-42A7-8AC5-BB291573A260"), 2),
    WPD_STILL_IMAGE_CAPTURE_FORMAT             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1489334764, 7115, 17063, 138, 197, 187, 41, 21, 115, 162, 96}, 2))], [])*/PROPERTYKEY(GUID("58C571EC-1BCB-42A7-8AC5-BB291573A260"), 3),
    WPD_STILL_IMAGE_COMPRESSION_SETTING        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1489334764, 7115, 17063, 138, 197, 187, 41, 21, 115, 162, 96}, 2))], [])*/PROPERTYKEY(GUID("58C571EC-1BCB-42A7-8AC5-BB291573A260"), 4),
    WPD_STILL_IMAGE_WHITE_BALANCE              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1489334764, 7115, 17063, 138, 197, 187, 41, 21, 115, 162, 96}, 2))], [])*/PROPERTYKEY(GUID("58C571EC-1BCB-42A7-8AC5-BB291573A260"), 5),
    WPD_STILL_IMAGE_RGB_GAIN                   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1489334764, 7115, 17063, 138, 197, 187, 41, 21, 115, 162, 96}, 2))], [])*/PROPERTYKEY(GUID("58C571EC-1BCB-42A7-8AC5-BB291573A260"), 6),
    WPD_STILL_IMAGE_FNUMBER                    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1489334764, 7115, 17063, 138, 197, 187, 41, 21, 115, 162, 96}, 2))], [])*/PROPERTYKEY(GUID("58C571EC-1BCB-42A7-8AC5-BB291573A260"), 7),
    WPD_STILL_IMAGE_FOCAL_LENGTH               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1489334764, 7115, 17063, 138, 197, 187, 41, 21, 115, 162, 96}, 2))], [])*/PROPERTYKEY(GUID("58C571EC-1BCB-42A7-8AC5-BB291573A260"), 8),
    WPD_STILL_IMAGE_FOCUS_DISTANCE             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1489334764, 7115, 17063, 138, 197, 187, 41, 21, 115, 162, 96}, 2))], [])*/PROPERTYKEY(GUID("58C571EC-1BCB-42A7-8AC5-BB291573A260"), 9),
    WPD_STILL_IMAGE_FOCUS_MODE                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1489334764, 7115, 17063, 138, 197, 187, 41, 21, 115, 162, 96}, 2))], [])*/PROPERTYKEY(GUID("58C571EC-1BCB-42A7-8AC5-BB291573A260"), 10),
    WPD_STILL_IMAGE_EXPOSURE_METERING_MODE     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1489334764, 7115, 17063, 138, 197, 187, 41, 21, 115, 162, 96}, 2))], [])*/PROPERTYKEY(GUID("58C571EC-1BCB-42A7-8AC5-BB291573A260"), 11),
    WPD_STILL_IMAGE_FLASH_MODE                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1489334764, 7115, 17063, 138, 197, 187, 41, 21, 115, 162, 96}, 2))], [])*/PROPERTYKEY(GUID("58C571EC-1BCB-42A7-8AC5-BB291573A260"), 12),
    WPD_STILL_IMAGE_EXPOSURE_TIME              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1489334764, 7115, 17063, 138, 197, 187, 41, 21, 115, 162, 96}, 2))], [])*/PROPERTYKEY(GUID("58C571EC-1BCB-42A7-8AC5-BB291573A260"), 13),
    WPD_STILL_IMAGE_EXPOSURE_PROGRAM_MODE      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1489334764, 7115, 17063, 138, 197, 187, 41, 21, 115, 162, 96}, 2))], [])*/PROPERTYKEY(GUID("58C571EC-1BCB-42A7-8AC5-BB291573A260"), 14),
    WPD_STILL_IMAGE_EXPOSURE_INDEX             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1489334764, 7115, 17063, 138, 197, 187, 41, 21, 115, 162, 96}, 2))], [])*/PROPERTYKEY(GUID("58C571EC-1BCB-42A7-8AC5-BB291573A260"), 15),
    WPD_STILL_IMAGE_EXPOSURE_BIAS_COMPENSATION = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1489334764, 7115, 17063, 138, 197, 187, 41, 21, 115, 162, 96}, 2))], [])*/PROPERTYKEY(GUID("58C571EC-1BCB-42A7-8AC5-BB291573A260"), 16),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1489334764, 7115, 17063, 138, 197, 187, 41, 21, 115, 162, 96}, 17))], [])*/PROPERTYKEY
{
    WPD_STILL_IMAGE_CAPTURE_DELAY       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1489334764, 7115, 17063, 138, 197, 187, 41, 21, 115, 162, 96}, 17))], [])*/PROPERTYKEY(GUID("58C571EC-1BCB-42A7-8AC5-BB291573A260"), 17),
    WPD_STILL_IMAGE_CAPTURE_MODE        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1489334764, 7115, 17063, 138, 197, 187, 41, 21, 115, 162, 96}, 17))], [])*/PROPERTYKEY(GUID("58C571EC-1BCB-42A7-8AC5-BB291573A260"), 18),
    WPD_STILL_IMAGE_CONTRAST            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1489334764, 7115, 17063, 138, 197, 187, 41, 21, 115, 162, 96}, 17))], [])*/PROPERTYKEY(GUID("58C571EC-1BCB-42A7-8AC5-BB291573A260"), 19),
    WPD_STILL_IMAGE_SHARPNESS           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1489334764, 7115, 17063, 138, 197, 187, 41, 21, 115, 162, 96}, 17))], [])*/PROPERTYKEY(GUID("58C571EC-1BCB-42A7-8AC5-BB291573A260"), 20),
    WPD_STILL_IMAGE_DIGITAL_ZOOM        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1489334764, 7115, 17063, 138, 197, 187, 41, 21, 115, 162, 96}, 17))], [])*/PROPERTYKEY(GUID("58C571EC-1BCB-42A7-8AC5-BB291573A260"), 21),
    WPD_STILL_IMAGE_EFFECT_MODE         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1489334764, 7115, 17063, 138, 197, 187, 41, 21, 115, 162, 96}, 17))], [])*/PROPERTYKEY(GUID("58C571EC-1BCB-42A7-8AC5-BB291573A260"), 22),
    WPD_STILL_IMAGE_BURST_NUMBER        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1489334764, 7115, 17063, 138, 197, 187, 41, 21, 115, 162, 96}, 17))], [])*/PROPERTYKEY(GUID("58C571EC-1BCB-42A7-8AC5-BB291573A260"), 23),
    WPD_STILL_IMAGE_BURST_INTERVAL      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1489334764, 7115, 17063, 138, 197, 187, 41, 21, 115, 162, 96}, 17))], [])*/PROPERTYKEY(GUID("58C571EC-1BCB-42A7-8AC5-BB291573A260"), 24),
    WPD_STILL_IMAGE_TIMELAPSE_NUMBER    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1489334764, 7115, 17063, 138, 197, 187, 41, 21, 115, 162, 96}, 17))], [])*/PROPERTYKEY(GUID("58C571EC-1BCB-42A7-8AC5-BB291573A260"), 25),
    WPD_STILL_IMAGE_TIMELAPSE_INTERVAL  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1489334764, 7115, 17063, 138, 197, 187, 41, 21, 115, 162, 96}, 17))], [])*/PROPERTYKEY(GUID("58C571EC-1BCB-42A7-8AC5-BB291573A260"), 26),
    WPD_STILL_IMAGE_FOCUS_METERING_MODE = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1489334764, 7115, 17063, 138, 197, 187, 41, 21, 115, 162, 96}, 17))], [])*/PROPERTYKEY(GUID("58C571EC-1BCB-42A7-8AC5-BB291573A260"), 27),
    WPD_STILL_IMAGE_UPLOAD_URL          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1489334764, 7115, 17063, 138, 197, 187, 41, 21, 115, 162, 96}, 17))], [])*/PROPERTYKEY(GUID("58C571EC-1BCB-42A7-8AC5-BB291573A260"), 28),
    WPD_STILL_IMAGE_ARTIST              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1489334764, 7115, 17063, 138, 197, 187, 41, 21, 115, 162, 96}, 17))], [])*/PROPERTYKEY(GUID("58C571EC-1BCB-42A7-8AC5-BB291573A260"), 29),
    WPD_STILL_IMAGE_CAMERA_MODEL        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1489334764, 7115, 17063, 138, 197, 187, 41, 21, 115, 162, 96}, 17))], [])*/PROPERTYKEY(GUID("58C571EC-1BCB-42A7-8AC5-BB291573A260"), 30),
    WPD_STILL_IMAGE_CAMERA_MANUFACTURER = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1489334764, 7115, 17063, 138, 197, 187, 41, 21, 115, 162, 96}, 17))], [])*/PROPERTYKEY(GUID("58C571EC-1BCB-42A7-8AC5-BB291573A260"), 31),
}

enum GUID WPD_RENDERING_INFORMATION_OBJECT_PROPERTIES_V1 = GUID("c53d039f-ee23-4a31-8590-7639879870b4");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3309110175, 60963, 18993, 133, 144, 118, 57, 135, 152, 112, 180}, 2))], [])*/PROPERTYKEY
{
    WPD_RENDERING_INFORMATION_PROFILES                          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3309110175, 60963, 18993, 133, 144, 118, 57, 135, 152, 112, 180}, 2))], [])*/PROPERTYKEY(GUID("C53D039F-EE23-4A31-8590-7639879870B4"), 2),
    WPD_RENDERING_INFORMATION_PROFILE_ENTRY_TYPE                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3309110175, 60963, 18993, 133, 144, 118, 57, 135, 152, 112, 180}, 2))], [])*/PROPERTYKEY(GUID("C53D039F-EE23-4A31-8590-7639879870B4"), 3),
    WPD_RENDERING_INFORMATION_PROFILE_ENTRY_CREATABLE_RESOURCES = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3309110175, 60963, 18993, 133, 144, 118, 57, 135, 152, 112, 180}, 2))], [])*/PROPERTYKEY(GUID("C53D039F-EE23-4A31-8590-7639879870B4"), 4),
}

enum GUID WPD_CLIENT_INFORMATION_PROPERTIES_V1 = GUID("204d9f0c-2292-4080-9f42-40664e70f859");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({541957900, 8850, 16512, 159, 66, 64, 102, 78, 112, 248, 89}, 2))], [])*/PROPERTYKEY
{
    WPD_CLIENT_NAME                          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({541957900, 8850, 16512, 159, 66, 64, 102, 78, 112, 248, 89}, 2))], [])*/PROPERTYKEY(GUID("204D9F0C-2292-4080-9F42-40664E70F859"), 2),
    WPD_CLIENT_MAJOR_VERSION                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({541957900, 8850, 16512, 159, 66, 64, 102, 78, 112, 248, 89}, 2))], [])*/PROPERTYKEY(GUID("204D9F0C-2292-4080-9F42-40664E70F859"), 3),
    WPD_CLIENT_MINOR_VERSION                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({541957900, 8850, 16512, 159, 66, 64, 102, 78, 112, 248, 89}, 2))], [])*/PROPERTYKEY(GUID("204D9F0C-2292-4080-9F42-40664E70F859"), 4),
    WPD_CLIENT_REVISION                      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({541957900, 8850, 16512, 159, 66, 64, 102, 78, 112, 248, 89}, 2))], [])*/PROPERTYKEY(GUID("204D9F0C-2292-4080-9F42-40664E70F859"), 5),
    WPD_CLIENT_WMDRM_APPLICATION_PRIVATE_KEY = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({541957900, 8850, 16512, 159, 66, 64, 102, 78, 112, 248, 89}, 2))], [])*/PROPERTYKEY(GUID("204D9F0C-2292-4080-9F42-40664E70F859"), 6),
    WPD_CLIENT_WMDRM_APPLICATION_CERTIFICATE = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({541957900, 8850, 16512, 159, 66, 64, 102, 78, 112, 248, 89}, 2))], [])*/PROPERTYKEY(GUID("204D9F0C-2292-4080-9F42-40664E70F859"), 7),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({541957900, 8850, 16512, 159, 66, 64, 102, 78, 112, 248, 89}, 8))], [])*/PROPERTYKEY WPD_CLIENT_SECURITY_QUALITY_OF_SERVICE = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({541957900, 8850, 16512, 159, 66, 64, 102, 78, 112, 248, 89}, 8))], [])*/PROPERTYKEY(GUID("204D9F0C-2292-4080-9F42-40664E70F859"), 8);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({541957900, 8850, 16512, 159, 66, 64, 102, 78, 112, 248, 89}, 9))], [])*/PROPERTYKEY
{
    WPD_CLIENT_DESIRED_ACCESS              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({541957900, 8850, 16512, 159, 66, 64, 102, 78, 112, 248, 89}, 9))], [])*/PROPERTYKEY(GUID("204D9F0C-2292-4080-9F42-40664E70F859"), 9),
    WPD_CLIENT_SHARE_MODE                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({541957900, 8850, 16512, 159, 66, 64, 102, 78, 112, 248, 89}, 9))], [])*/PROPERTYKEY(GUID("204D9F0C-2292-4080-9F42-40664E70F859"), 10),
    WPD_CLIENT_EVENT_COOKIE                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({541957900, 8850, 16512, 159, 66, 64, 102, 78, 112, 248, 89}, 9))], [])*/PROPERTYKEY(GUID("204D9F0C-2292-4080-9F42-40664E70F859"), 11),
    WPD_CLIENT_MINIMUM_RESULTS_BUFFER_SIZE = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({541957900, 8850, 16512, 159, 66, 64, 102, 78, 112, 248, 89}, 9))], [])*/PROPERTYKEY(GUID("204D9F0C-2292-4080-9F42-40664E70F859"), 12),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({541957900, 8850, 16512, 159, 66, 64, 102, 78, 112, 248, 89}, 13))], [])*/PROPERTYKEY WPD_CLIENT_MANUAL_CLOSE_ON_DISCONNECT = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({541957900, 8850, 16512, 159, 66, 64, 102, 78, 112, 248, 89}, 13))], [])*/PROPERTYKEY(GUID("204D9F0C-2292-4080-9F42-40664E70F859"), 13);
enum GUID WPD_PROPERTY_ATTRIBUTES_V1 = GUID("ab7943d8-6332-445f-a00d-8d5ef1e96f37");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2876851160, 25394, 17503, 160, 13, 141, 94, 241, 233, 111, 55}, 2))], [])*/PROPERTYKEY
{
    WPD_PROPERTY_ATTRIBUTE_FORM                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2876851160, 25394, 17503, 160, 13, 141, 94, 241, 233, 111, 55}, 2))], [])*/PROPERTYKEY(GUID("AB7943D8-6332-445F-A00D-8D5EF1E96F37"), 2),
    WPD_PROPERTY_ATTRIBUTE_CAN_READ             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2876851160, 25394, 17503, 160, 13, 141, 94, 241, 233, 111, 55}, 2))], [])*/PROPERTYKEY(GUID("AB7943D8-6332-445F-A00D-8D5EF1E96F37"), 3),
    WPD_PROPERTY_ATTRIBUTE_CAN_WRITE            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2876851160, 25394, 17503, 160, 13, 141, 94, 241, 233, 111, 55}, 2))], [])*/PROPERTYKEY(GUID("AB7943D8-6332-445F-A00D-8D5EF1E96F37"), 4),
    WPD_PROPERTY_ATTRIBUTE_CAN_DELETE           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2876851160, 25394, 17503, 160, 13, 141, 94, 241, 233, 111, 55}, 2))], [])*/PROPERTYKEY(GUID("AB7943D8-6332-445F-A00D-8D5EF1E96F37"), 5),
    WPD_PROPERTY_ATTRIBUTE_DEFAULT_VALUE        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2876851160, 25394, 17503, 160, 13, 141, 94, 241, 233, 111, 55}, 2))], [])*/PROPERTYKEY(GUID("AB7943D8-6332-445F-A00D-8D5EF1E96F37"), 6),
    WPD_PROPERTY_ATTRIBUTE_FAST_PROPERTY        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2876851160, 25394, 17503, 160, 13, 141, 94, 241, 233, 111, 55}, 2))], [])*/PROPERTYKEY(GUID("AB7943D8-6332-445F-A00D-8D5EF1E96F37"), 7),
    WPD_PROPERTY_ATTRIBUTE_RANGE_MIN            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2876851160, 25394, 17503, 160, 13, 141, 94, 241, 233, 111, 55}, 2))], [])*/PROPERTYKEY(GUID("AB7943D8-6332-445F-A00D-8D5EF1E96F37"), 8),
    WPD_PROPERTY_ATTRIBUTE_RANGE_MAX            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2876851160, 25394, 17503, 160, 13, 141, 94, 241, 233, 111, 55}, 2))], [])*/PROPERTYKEY(GUID("AB7943D8-6332-445F-A00D-8D5EF1E96F37"), 9),
    WPD_PROPERTY_ATTRIBUTE_RANGE_STEP           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2876851160, 25394, 17503, 160, 13, 141, 94, 241, 233, 111, 55}, 2))], [])*/PROPERTYKEY(GUID("AB7943D8-6332-445F-A00D-8D5EF1E96F37"), 10),
    WPD_PROPERTY_ATTRIBUTE_ENUMERATION_ELEMENTS = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2876851160, 25394, 17503, 160, 13, 141, 94, 241, 233, 111, 55}, 2))], [])*/PROPERTYKEY(GUID("AB7943D8-6332-445F-A00D-8D5EF1E96F37"), 11),
    WPD_PROPERTY_ATTRIBUTE_REGULAR_EXPRESSION   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2876851160, 25394, 17503, 160, 13, 141, 94, 241, 233, 111, 55}, 2))], [])*/PROPERTYKEY(GUID("AB7943D8-6332-445F-A00D-8D5EF1E96F37"), 12),
    WPD_PROPERTY_ATTRIBUTE_MAX_SIZE             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2876851160, 25394, 17503, 160, 13, 141, 94, 241, 233, 111, 55}, 2))], [])*/PROPERTYKEY(GUID("AB7943D8-6332-445F-A00D-8D5EF1E96F37"), 13),
}

enum GUID WPD_PROPERTY_ATTRIBUTES_V2 = GUID("5d9da160-74ae-43cc-85a9-fe555a80798e");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1570611552, 29870, 17356, 133, 169, 254, 85, 90, 128, 121, 142}, 2))], [])*/PROPERTYKEY
{
    WPD_PROPERTY_ATTRIBUTE_NAME    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1570611552, 29870, 17356, 133, 169, 254, 85, 90, 128, 121, 142}, 2))], [])*/PROPERTYKEY(GUID("5D9DA160-74AE-43CC-85A9-FE555A80798E"), 2),
    WPD_PROPERTY_ATTRIBUTE_VARTYPE = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1570611552, 29870, 17356, 133, 169, 254, 85, 90, 128, 121, 142}, 2))], [])*/PROPERTYKEY(GUID("5D9DA160-74AE-43CC-85A9-FE555A80798E"), 3),
}

enum GUID WPD_CLASS_EXTENSION_OPTIONS_V1 = GUID("6309ffef-a87c-4ca7-8434-797576e40a96");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1661599727, 43132, 19623, 132, 52, 121, 117, 118, 228, 10, 150}, 2))], [])*/PROPERTYKEY
{
    WPD_CLASS_EXTENSION_OPTIONS_SUPPORTED_CONTENT_TYPES               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1661599727, 43132, 19623, 132, 52, 121, 117, 118, 228, 10, 150}, 2))], [])*/PROPERTYKEY(GUID("6309FFEF-A87C-4CA7-8434-797576E40A96"), 2),
    WPD_CLASS_EXTENSION_OPTIONS_DONT_REGISTER_WPD_DEVICE_INTERFACE    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1661599727, 43132, 19623, 132, 52, 121, 117, 118, 228, 10, 150}, 2))], [])*/PROPERTYKEY(GUID("6309FFEF-A87C-4CA7-8434-797576E40A96"), 3),
    WPD_CLASS_EXTENSION_OPTIONS_REGISTER_WPD_PRIVATE_DEVICE_INTERFACE = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1661599727, 43132, 19623, 132, 52, 121, 117, 118, 228, 10, 150}, 2))], [])*/PROPERTYKEY(GUID("6309FFEF-A87C-4CA7-8434-797576E40A96"), 4),
}

enum GUID WPD_CLASS_EXTENSION_OPTIONS_V2 = GUID("3e3595da-4d71-49fe-a0b4-d4406c3ae93f");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1043699162, 19825, 18942, 160, 180, 212, 64, 108, 58, 233, 63}, 2))], [])*/PROPERTYKEY
{
    WPD_CLASS_EXTENSION_OPTIONS_MULTITRANSPORT_MODE          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1043699162, 19825, 18942, 160, 180, 212, 64, 108, 58, 233, 63}, 2))], [])*/PROPERTYKEY(GUID("3E3595DA-4D71-49FE-A0B4-D4406C3AE93F"), 2),
    WPD_CLASS_EXTENSION_OPTIONS_DEVICE_IDENTIFICATION_VALUES = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1043699162, 19825, 18942, 160, 180, 212, 64, 108, 58, 233, 63}, 2))], [])*/PROPERTYKEY(GUID("3E3595DA-4D71-49FE-A0B4-D4406C3AE93F"), 3),
    WPD_CLASS_EXTENSION_OPTIONS_TRANSPORT_BANDWIDTH          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1043699162, 19825, 18942, 160, 180, 212, 64, 108, 58, 233, 63}, 2))], [])*/PROPERTYKEY(GUID("3E3595DA-4D71-49FE-A0B4-D4406C3AE93F"), 4),
}

enum GUID WPD_CLASS_EXTENSION_OPTIONS_V3 = GUID("65c160f8-1367-4ce2-939d-8310839f0d30");
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1707172088, 4967, 19682, 147, 157, 131, 16, 131, 159, 13, 48}, 2))], [])*/PROPERTYKEY WPD_CLASS_EXTENSION_OPTIONS_SILENCE_AUTOPLAY = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1707172088, 4967, 19682, 147, 157, 131, 16, 131, 159, 13, 48}, 2))], [])*/PROPERTYKEY(GUID("65C160F8-1367-4CE2-939D-8310839F0D30"), 2);
enum GUID WPD_RESOURCE_ATTRIBUTES_V1 = GUID("1eb6f604-9278-429f-93cc-5bb8c06656b6");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({515307012, 37496, 17055, 147, 204, 91, 184, 192, 102, 86, 182}, 2))], [])*/PROPERTYKEY
{
    WPD_RESOURCE_ATTRIBUTE_TOTAL_SIZE                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({515307012, 37496, 17055, 147, 204, 91, 184, 192, 102, 86, 182}, 2))], [])*/PROPERTYKEY(GUID("1EB6F604-9278-429F-93CC-5BB8C06656B6"), 2),
    WPD_RESOURCE_ATTRIBUTE_CAN_READ                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({515307012, 37496, 17055, 147, 204, 91, 184, 192, 102, 86, 182}, 2))], [])*/PROPERTYKEY(GUID("1EB6F604-9278-429F-93CC-5BB8C06656B6"), 3),
    WPD_RESOURCE_ATTRIBUTE_CAN_WRITE                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({515307012, 37496, 17055, 147, 204, 91, 184, 192, 102, 86, 182}, 2))], [])*/PROPERTYKEY(GUID("1EB6F604-9278-429F-93CC-5BB8C06656B6"), 4),
    WPD_RESOURCE_ATTRIBUTE_CAN_DELETE                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({515307012, 37496, 17055, 147, 204, 91, 184, 192, 102, 86, 182}, 2))], [])*/PROPERTYKEY(GUID("1EB6F604-9278-429F-93CC-5BB8C06656B6"), 5),
    WPD_RESOURCE_ATTRIBUTE_OPTIMAL_READ_BUFFER_SIZE  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({515307012, 37496, 17055, 147, 204, 91, 184, 192, 102, 86, 182}, 2))], [])*/PROPERTYKEY(GUID("1EB6F604-9278-429F-93CC-5BB8C06656B6"), 6),
    WPD_RESOURCE_ATTRIBUTE_OPTIMAL_WRITE_BUFFER_SIZE = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({515307012, 37496, 17055, 147, 204, 91, 184, 192, 102, 86, 182}, 2))], [])*/PROPERTYKEY(GUID("1EB6F604-9278-429F-93CC-5BB8C06656B6"), 7),
    WPD_RESOURCE_ATTRIBUTE_FORMAT                    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({515307012, 37496, 17055, 147, 204, 91, 184, 192, 102, 86, 182}, 2))], [])*/PROPERTYKEY(GUID("1EB6F604-9278-429F-93CC-5BB8C06656B6"), 8),
    WPD_RESOURCE_ATTRIBUTE_RESOURCE_KEY              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({515307012, 37496, 17055, 147, 204, 91, 184, 192, 102, 86, 182}, 2))], [])*/PROPERTYKEY(GUID("1EB6F604-9278-429F-93CC-5BB8C06656B6"), 9),
}

enum GUID WPD_DEVICE_PROPERTIES_V1 = GUID("26d4979a-e643-4626-9e2b-736dc0c92fdc");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({651466650, 58947, 17958, 158, 43, 115, 109, 192, 201, 47, 220}, 2))], [])*/PROPERTYKEY
{
    WPD_DEVICE_SYNC_PARTNER            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({651466650, 58947, 17958, 158, 43, 115, 109, 192, 201, 47, 220}, 2))], [])*/PROPERTYKEY(GUID("26D4979A-E643-4626-9E2B-736DC0C92FDC"), 2),
    WPD_DEVICE_FIRMWARE_VERSION        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({651466650, 58947, 17958, 158, 43, 115, 109, 192, 201, 47, 220}, 2))], [])*/PROPERTYKEY(GUID("26D4979A-E643-4626-9E2B-736DC0C92FDC"), 3),
    WPD_DEVICE_POWER_LEVEL             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({651466650, 58947, 17958, 158, 43, 115, 109, 192, 201, 47, 220}, 2))], [])*/PROPERTYKEY(GUID("26D4979A-E643-4626-9E2B-736DC0C92FDC"), 4),
    WPD_DEVICE_POWER_SOURCE            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({651466650, 58947, 17958, 158, 43, 115, 109, 192, 201, 47, 220}, 2))], [])*/PROPERTYKEY(GUID("26D4979A-E643-4626-9E2B-736DC0C92FDC"), 5),
    WPD_DEVICE_PROTOCOL                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({651466650, 58947, 17958, 158, 43, 115, 109, 192, 201, 47, 220}, 2))], [])*/PROPERTYKEY(GUID("26D4979A-E643-4626-9E2B-736DC0C92FDC"), 6),
    WPD_DEVICE_MANUFACTURER            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({651466650, 58947, 17958, 158, 43, 115, 109, 192, 201, 47, 220}, 2))], [])*/PROPERTYKEY(GUID("26D4979A-E643-4626-9E2B-736DC0C92FDC"), 7),
    WPD_DEVICE_MODEL                   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({651466650, 58947, 17958, 158, 43, 115, 109, 192, 201, 47, 220}, 2))], [])*/PROPERTYKEY(GUID("26D4979A-E643-4626-9E2B-736DC0C92FDC"), 8),
    WPD_DEVICE_SERIAL_NUMBER           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({651466650, 58947, 17958, 158, 43, 115, 109, 192, 201, 47, 220}, 2))], [])*/PROPERTYKEY(GUID("26D4979A-E643-4626-9E2B-736DC0C92FDC"), 9),
    WPD_DEVICE_SUPPORTS_NON_CONSUMABLE = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({651466650, 58947, 17958, 158, 43, 115, 109, 192, 201, 47, 220}, 2))], [])*/PROPERTYKEY(GUID("26D4979A-E643-4626-9E2B-736DC0C92FDC"), 10),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({651466650, 58947, 17958, 158, 43, 115, 109, 192, 201, 47, 220}, 11))], [])*/PROPERTYKEY
{
    WPD_DEVICE_DATETIME                      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({651466650, 58947, 17958, 158, 43, 115, 109, 192, 201, 47, 220}, 11))], [])*/PROPERTYKEY(GUID("26D4979A-E643-4626-9E2B-736DC0C92FDC"), 11),
    WPD_DEVICE_FRIENDLY_NAME                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({651466650, 58947, 17958, 158, 43, 115, 109, 192, 201, 47, 220}, 11))], [])*/PROPERTYKEY(GUID("26D4979A-E643-4626-9E2B-736DC0C92FDC"), 12),
    WPD_DEVICE_SUPPORTED_DRM_SCHEMES         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({651466650, 58947, 17958, 158, 43, 115, 109, 192, 201, 47, 220}, 11))], [])*/PROPERTYKEY(GUID("26D4979A-E643-4626-9E2B-736DC0C92FDC"), 13),
    WPD_DEVICE_SUPPORTED_FORMATS_ARE_ORDERED = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({651466650, 58947, 17958, 158, 43, 115, 109, 192, 201, 47, 220}, 11))], [])*/PROPERTYKEY(GUID("26D4979A-E643-4626-9E2B-736DC0C92FDC"), 14),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({651466650, 58947, 17958, 158, 43, 115, 109, 192, 201, 47, 220}, 15))], [])*/PROPERTYKEY
{
    WPD_DEVICE_TYPE               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({651466650, 58947, 17958, 158, 43, 115, 109, 192, 201, 47, 220}, 15))], [])*/PROPERTYKEY(GUID("26D4979A-E643-4626-9E2B-736DC0C92FDC"), 15),
    WPD_DEVICE_NETWORK_IDENTIFIER = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({651466650, 58947, 17958, 158, 43, 115, 109, 192, 201, 47, 220}, 15))], [])*/PROPERTYKEY(GUID("26D4979A-E643-4626-9E2B-736DC0C92FDC"), 16),
}

enum GUID WPD_DEVICE_PROPERTIES_V2 = GUID("463dd662-7fc4-4291-911c-7f4c9cca9799");
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1178457698, 32708, 17041, 145, 28, 127, 76, 156, 202, 151, 153}, 2))], [])*/PROPERTYKEY WPD_DEVICE_FUNCTIONAL_UNIQUE_ID = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1178457698, 32708, 17041, 145, 28, 127, 76, 156, 202, 151, 153}, 2))], [])*/PROPERTYKEY(GUID("463DD662-7FC4-4291-911C-7F4C9CCA9799"), 2);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1178457698, 32708, 17041, 145, 28, 127, 76, 156, 202, 151, 153}, 3))], [])*/PROPERTYKEY
{
    WPD_DEVICE_MODEL_UNIQUE_ID  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1178457698, 32708, 17041, 145, 28, 127, 76, 156, 202, 151, 153}, 3))], [])*/PROPERTYKEY(GUID("463DD662-7FC4-4291-911C-7F4C9CCA9799"), 3),
    WPD_DEVICE_TRANSPORT        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1178457698, 32708, 17041, 145, 28, 127, 76, 156, 202, 151, 153}, 3))], [])*/PROPERTYKEY(GUID("463DD662-7FC4-4291-911C-7F4C9CCA9799"), 4),
    WPD_DEVICE_USE_DEVICE_STAGE = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1178457698, 32708, 17041, 145, 28, 127, 76, 156, 202, 151, 153}, 3))], [])*/PROPERTYKEY(GUID("463DD662-7FC4-4291-911C-7F4C9CCA9799"), 5),
}

enum GUID WPD_DEVICE_PROPERTIES_V3 = GUID("6c2b878c-c2ec-490d-b425-d7a75e23e5ed");
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1814792076, 49900, 18701, 180, 37, 215, 167, 94, 35, 229, 237}, 1))], [])*/PROPERTYKEY WPD_DEVICE_EDP_IDENTITY = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1814792076, 49900, 18701, 180, 37, 215, 167, 94, 35, 229, 237}, 1))], [])*/PROPERTYKEY(GUID("6C2B878C-C2EC-490D-B425-D7A75E23E5ED"), 1);
enum GUID WPD_SERVICE_PROPERTIES_V1 = GUID("7510698a-cb54-481c-b8db-0d75c93f1c06");
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1964009866, 52052, 18460, 184, 219, 13, 117, 201, 63, 28, 6}, 2))], [])*/PROPERTYKEY WPD_SERVICE_VERSION = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1964009866, 52052, 18460, 184, 219, 13, 117, 201, 63, 28, 6}, 2))], [])*/PROPERTYKEY(GUID("7510698A-CB54-481C-B8DB-0D75C93F1C06"), 2);
enum GUID WPD_EVENT_PROPERTIES_V1 = GUID("15ab1953-f817-4fef-a921-5676e838f6e0");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({363534675, 63511, 20463, 169, 33, 86, 118, 232, 56, 246, 224}, 2))], [])*/PROPERTYKEY
{
    WPD_EVENT_PARAMETER_PNP_DEVICE_ID                      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({363534675, 63511, 20463, 169, 33, 86, 118, 232, 56, 246, 224}, 2))], [])*/PROPERTYKEY(GUID("15AB1953-F817-4FEF-A921-5676E838F6E0"), 2),
    WPD_EVENT_PARAMETER_EVENT_ID                           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({363534675, 63511, 20463, 169, 33, 86, 118, 232, 56, 246, 224}, 2))], [])*/PROPERTYKEY(GUID("15AB1953-F817-4FEF-A921-5676E838F6E0"), 3),
    WPD_EVENT_PARAMETER_OPERATION_STATE                    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({363534675, 63511, 20463, 169, 33, 86, 118, 232, 56, 246, 224}, 2))], [])*/PROPERTYKEY(GUID("15AB1953-F817-4FEF-A921-5676E838F6E0"), 4),
    WPD_EVENT_PARAMETER_OPERATION_PROGRESS                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({363534675, 63511, 20463, 169, 33, 86, 118, 232, 56, 246, 224}, 2))], [])*/PROPERTYKEY(GUID("15AB1953-F817-4FEF-A921-5676E838F6E0"), 5),
    WPD_EVENT_PARAMETER_OBJECT_PARENT_PERSISTENT_UNIQUE_ID = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({363534675, 63511, 20463, 169, 33, 86, 118, 232, 56, 246, 224}, 2))], [])*/PROPERTYKEY(GUID("15AB1953-F817-4FEF-A921-5676E838F6E0"), 6),
    WPD_EVENT_PARAMETER_OBJECT_CREATION_COOKIE             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({363534675, 63511, 20463, 169, 33, 86, 118, 232, 56, 246, 224}, 2))], [])*/PROPERTYKEY(GUID("15AB1953-F817-4FEF-A921-5676E838F6E0"), 7),
    WPD_EVENT_PARAMETER_CHILD_HIERARCHY_CHANGED            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({363534675, 63511, 20463, 169, 33, 86, 118, 232, 56, 246, 224}, 2))], [])*/PROPERTYKEY(GUID("15AB1953-F817-4FEF-A921-5676E838F6E0"), 8),
}

enum GUID WPD_EVENT_PROPERTIES_V2 = GUID("52807b8a-4914-4323-9b9a-74f654b2b846");
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1384151946, 18708, 17187, 155, 154, 116, 246, 84, 178, 184, 70}, 2))], [])*/PROPERTYKEY WPD_EVENT_PARAMETER_SERVICE_METHOD_CONTEXT = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1384151946, 18708, 17187, 155, 154, 116, 246, 84, 178, 184, 70}, 2))], [])*/PROPERTYKEY(GUID("52807B8A-4914-4323-9B9A-74F654B2B846"), 2);
enum GUID WPD_EVENT_OPTIONS_V1 = GUID("b3d8dad7-a361-4b83-8a48-5b02ce10713b");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3017333463, 41825, 19331, 138, 72, 91, 2, 206, 16, 113, 59}, 2))], [])*/PROPERTYKEY
{
    WPD_EVENT_OPTION_IS_BROADCAST_EVENT = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3017333463, 41825, 19331, 138, 72, 91, 2, 206, 16, 113, 59}, 2))], [])*/PROPERTYKEY(GUID("B3D8DAD7-A361-4B83-8A48-5B02CE10713B"), 2),
    WPD_EVENT_OPTION_IS_AUTOPLAY_EVENT  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3017333463, 41825, 19331, 138, 72, 91, 2, 206, 16, 113, 59}, 2))], [])*/PROPERTYKEY(GUID("B3D8DAD7-A361-4B83-8A48-5B02CE10713B"), 3),
}

enum GUID WPD_EVENT_ATTRIBUTES_V1 = GUID("10c96578-2e81-4111-adde-e08ca6138f6d");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({281634168, 11905, 16657, 173, 222, 224, 140, 166, 19, 143, 109}, 2))], [])*/PROPERTYKEY
{
    WPD_EVENT_ATTRIBUTE_NAME       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({281634168, 11905, 16657, 173, 222, 224, 140, 166, 19, 143, 109}, 2))], [])*/PROPERTYKEY(GUID("10C96578-2E81-4111-ADDE-E08CA6138F6D"), 2),
    WPD_EVENT_ATTRIBUTE_PARAMETERS = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({281634168, 11905, 16657, 173, 222, 224, 140, 166, 19, 143, 109}, 2))], [])*/PROPERTYKEY(GUID("10C96578-2E81-4111-ADDE-E08CA6138F6D"), 3),
    WPD_EVENT_ATTRIBUTE_OPTIONS    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({281634168, 11905, 16657, 173, 222, 224, 140, 166, 19, 143, 109}, 2))], [])*/PROPERTYKEY(GUID("10C96578-2E81-4111-ADDE-E08CA6138F6D"), 4),
}

enum GUID WPD_API_OPTIONS_V1 = GUID("10e54a3e-052d-4777-a13c-de7614be2bc4");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({283462206, 1325, 18295, 161, 60, 222, 118, 20, 190, 43, 196}, 2))], [])*/PROPERTYKEY
{
    WPD_API_OPTION_USE_CLEAR_DATA_STREAM = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({283462206, 1325, 18295, 161, 60, 222, 118, 20, 190, 43, 196}, 2))], [])*/PROPERTYKEY(GUID("10E54A3E-052D-4777-A13C-DE7614BE2BC4"), 2),
    WPD_API_OPTION_IOCTL_ACCESS          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({283462206, 1325, 18295, 161, 60, 222, 118, 20, 190, 43, 196}, 2))], [])*/PROPERTYKEY(GUID("10E54A3E-052D-4777-A13C-DE7614BE2BC4"), 3),
}

enum GUID WPD_FORMAT_ATTRIBUTES_V1 = GUID("a0a02000-bcaf-4be8-b3f5-233f231cf58f");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2694848512, 48303, 19432, 179, 245, 35, 63, 35, 28, 245, 143}, 2))], [])*/PROPERTYKEY
{
    WPD_FORMAT_ATTRIBUTE_NAME     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2694848512, 48303, 19432, 179, 245, 35, 63, 35, 28, 245, 143}, 2))], [])*/PROPERTYKEY(GUID("A0A02000-BCAF-4BE8-B3F5-233F231CF58F"), 2),
    WPD_FORMAT_ATTRIBUTE_MIMETYPE = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2694848512, 48303, 19432, 179, 245, 35, 63, 35, 28, 245, 143}, 2))], [])*/PROPERTYKEY(GUID("A0A02000-BCAF-4BE8-B3F5-233F231CF58F"), 3),
}

enum GUID WPD_METHOD_ATTRIBUTES_V1 = GUID("f17a5071-f039-44af-8efe-432cf32e432a");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4051325041, 61497, 17583, 142, 254, 67, 44, 243, 46, 67, 42}, 2))], [])*/PROPERTYKEY
{
    WPD_METHOD_ATTRIBUTE_NAME              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4051325041, 61497, 17583, 142, 254, 67, 44, 243, 46, 67, 42}, 2))], [])*/PROPERTYKEY(GUID("F17A5071-F039-44AF-8EFE-432CF32E432A"), 2),
    WPD_METHOD_ATTRIBUTE_ASSOCIATED_FORMAT = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4051325041, 61497, 17583, 142, 254, 67, 44, 243, 46, 67, 42}, 2))], [])*/PROPERTYKEY(GUID("F17A5071-F039-44AF-8EFE-432CF32E432A"), 3),
    WPD_METHOD_ATTRIBUTE_ACCESS            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4051325041, 61497, 17583, 142, 254, 67, 44, 243, 46, 67, 42}, 2))], [])*/PROPERTYKEY(GUID("F17A5071-F039-44AF-8EFE-432CF32E432A"), 4),
    WPD_METHOD_ATTRIBUTE_PARAMETERS        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4051325041, 61497, 17583, 142, 254, 67, 44, 243, 46, 67, 42}, 2))], [])*/PROPERTYKEY(GUID("F17A5071-F039-44AF-8EFE-432CF32E432A"), 5),
}

enum GUID WPD_PARAMETER_ATTRIBUTES_V1 = GUID("e6864dd7-f325-45ea-a1d5-97cf73b6ca58");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3867561431, 62245, 17898, 161, 213, 151, 207, 115, 182, 202, 88}, 2))], [])*/PROPERTYKEY
{
    WPD_PARAMETER_ATTRIBUTE_ORDER                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3867561431, 62245, 17898, 161, 213, 151, 207, 115, 182, 202, 88}, 2))], [])*/PROPERTYKEY(GUID("E6864DD7-F325-45EA-A1D5-97CF73B6CA58"), 2),
    WPD_PARAMETER_ATTRIBUTE_USAGE                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3867561431, 62245, 17898, 161, 213, 151, 207, 115, 182, 202, 88}, 2))], [])*/PROPERTYKEY(GUID("E6864DD7-F325-45EA-A1D5-97CF73B6CA58"), 3),
    WPD_PARAMETER_ATTRIBUTE_FORM                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3867561431, 62245, 17898, 161, 213, 151, 207, 115, 182, 202, 88}, 2))], [])*/PROPERTYKEY(GUID("E6864DD7-F325-45EA-A1D5-97CF73B6CA58"), 4),
    WPD_PARAMETER_ATTRIBUTE_DEFAULT_VALUE        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3867561431, 62245, 17898, 161, 213, 151, 207, 115, 182, 202, 88}, 2))], [])*/PROPERTYKEY(GUID("E6864DD7-F325-45EA-A1D5-97CF73B6CA58"), 5),
    WPD_PARAMETER_ATTRIBUTE_RANGE_MIN            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3867561431, 62245, 17898, 161, 213, 151, 207, 115, 182, 202, 88}, 2))], [])*/PROPERTYKEY(GUID("E6864DD7-F325-45EA-A1D5-97CF73B6CA58"), 6),
    WPD_PARAMETER_ATTRIBUTE_RANGE_MAX            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3867561431, 62245, 17898, 161, 213, 151, 207, 115, 182, 202, 88}, 2))], [])*/PROPERTYKEY(GUID("E6864DD7-F325-45EA-A1D5-97CF73B6CA58"), 7),
    WPD_PARAMETER_ATTRIBUTE_RANGE_STEP           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3867561431, 62245, 17898, 161, 213, 151, 207, 115, 182, 202, 88}, 2))], [])*/PROPERTYKEY(GUID("E6864DD7-F325-45EA-A1D5-97CF73B6CA58"), 8),
    WPD_PARAMETER_ATTRIBUTE_ENUMERATION_ELEMENTS = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3867561431, 62245, 17898, 161, 213, 151, 207, 115, 182, 202, 88}, 2))], [])*/PROPERTYKEY(GUID("E6864DD7-F325-45EA-A1D5-97CF73B6CA58"), 9),
    WPD_PARAMETER_ATTRIBUTE_REGULAR_EXPRESSION   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3867561431, 62245, 17898, 161, 213, 151, 207, 115, 182, 202, 88}, 2))], [])*/PROPERTYKEY(GUID("E6864DD7-F325-45EA-A1D5-97CF73B6CA58"), 10),
    WPD_PARAMETER_ATTRIBUTE_MAX_SIZE             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3867561431, 62245, 17898, 161, 213, 151, 207, 115, 182, 202, 88}, 2))], [])*/PROPERTYKEY(GUID("E6864DD7-F325-45EA-A1D5-97CF73B6CA58"), 11),
    WPD_PARAMETER_ATTRIBUTE_VARTYPE              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3867561431, 62245, 17898, 161, 213, 151, 207, 115, 182, 202, 88}, 2))], [])*/PROPERTYKEY(GUID("E6864DD7-F325-45EA-A1D5-97CF73B6CA58"), 12),
    WPD_PARAMETER_ATTRIBUTE_NAME                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3867561431, 62245, 17898, 161, 213, 151, 207, 115, 182, 202, 88}, 2))], [])*/PROPERTYKEY(GUID("E6864DD7-F325-45EA-A1D5-97CF73B6CA58"), 13),
}

enum GUID WPD_CATEGORY_COMMON = GUID("f0422a9c-5dc8-4440-b5bd-5df28835658a");

enum : /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-command-common-reset-device-command))], [])*/PROPERTYKEY
{
    WPD_COMMAND_COMMON_RESET_DEVICE                              = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-command-common-reset-device-command))], [])*/PROPERTYKEY(GUID("F0422A9C-5DC8-4440-B5BD-5DF28835658A"), 2),
    WPD_COMMAND_COMMON_GET_OBJECT_IDS_FROM_PERSISTENT_UNIQUE_IDS = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-command-common-reset-device-command))], [])*/PROPERTYKEY(GUID("F0422A9C-5DC8-4440-B5BD-5DF28835658A"), 3),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4030868124, 24008, 17472, 181, 189, 93, 242, 136, 53, 101, 138}, 4))], [])*/PROPERTYKEY WPD_COMMAND_COMMON_SAVE_CLIENT_INFORMATION = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4030868124, 24008, 17472, 181, 189, 93, 242, 136, 53, 101, 138}, 4))], [])*/PROPERTYKEY(GUID("F0422A9C-5DC8-4440-B5BD-5DF28835658A"), 4);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4030868124, 24008, 17472, 181, 189, 93, 242, 136, 53, 101, 138}, 1001))], [])*/PROPERTYKEY
{
    WPD_PROPERTY_COMMON_COMMAND_CATEGORY           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4030868124, 24008, 17472, 181, 189, 93, 242, 136, 53, 101, 138}, 1001))], [])*/PROPERTYKEY(GUID("F0422A9C-5DC8-4440-B5BD-5DF28835658A"), 1001),
    WPD_PROPERTY_COMMON_COMMAND_ID                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4030868124, 24008, 17472, 181, 189, 93, 242, 136, 53, 101, 138}, 1001))], [])*/PROPERTYKEY(GUID("F0422A9C-5DC8-4440-B5BD-5DF28835658A"), 1002),
    WPD_PROPERTY_COMMON_HRESULT                    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4030868124, 24008, 17472, 181, 189, 93, 242, 136, 53, 101, 138}, 1001))], [])*/PROPERTYKEY(GUID("F0422A9C-5DC8-4440-B5BD-5DF28835658A"), 1003),
    WPD_PROPERTY_COMMON_DRIVER_ERROR_CODE          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4030868124, 24008, 17472, 181, 189, 93, 242, 136, 53, 101, 138}, 1001))], [])*/PROPERTYKEY(GUID("F0422A9C-5DC8-4440-B5BD-5DF28835658A"), 1004),
    WPD_PROPERTY_COMMON_COMMAND_TARGET             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4030868124, 24008, 17472, 181, 189, 93, 242, 136, 53, 101, 138}, 1001))], [])*/PROPERTYKEY(GUID("F0422A9C-5DC8-4440-B5BD-5DF28835658A"), 1006),
    WPD_PROPERTY_COMMON_PERSISTENT_UNIQUE_IDS      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4030868124, 24008, 17472, 181, 189, 93, 242, 136, 53, 101, 138}, 1001))], [])*/PROPERTYKEY(GUID("F0422A9C-5DC8-4440-B5BD-5DF28835658A"), 1007),
    WPD_PROPERTY_COMMON_OBJECT_IDS                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4030868124, 24008, 17472, 181, 189, 93, 242, 136, 53, 101, 138}, 1001))], [])*/PROPERTYKEY(GUID("F0422A9C-5DC8-4440-B5BD-5DF28835658A"), 1008),
    WPD_PROPERTY_COMMON_CLIENT_INFORMATION         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4030868124, 24008, 17472, 181, 189, 93, 242, 136, 53, 101, 138}, 1001))], [])*/PROPERTYKEY(GUID("F0422A9C-5DC8-4440-B5BD-5DF28835658A"), 1009),
    WPD_PROPERTY_COMMON_CLIENT_INFORMATION_CONTEXT = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4030868124, 24008, 17472, 181, 189, 93, 242, 136, 53, 101, 138}, 1001))], [])*/PROPERTYKEY(GUID("F0422A9C-5DC8-4440-B5BD-5DF28835658A"), 1010),
    WPD_PROPERTY_COMMON_ACTIVITY_ID                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4030868124, 24008, 17472, 181, 189, 93, 242, 136, 53, 101, 138}, 1001))], [])*/PROPERTYKEY(GUID("F0422A9C-5DC8-4440-B5BD-5DF28835658A"), 1011),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4030868124, 24008, 17472, 181, 189, 93, 242, 136, 53, 101, 138}, 5001))], [])*/PROPERTYKEY WPD_OPTION_VALID_OBJECT_IDS = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4030868124, 24008, 17472, 181, 189, 93, 242, 136, 53, 101, 138}, 5001))], [])*/PROPERTYKEY(GUID("F0422A9C-5DC8-4440-B5BD-5DF28835658A"), 5001);
enum GUID WPD_CATEGORY_OBJECT_ENUMERATION = GUID("b7474e91-e7f8-4ad9-b400-ad1a4b58eeec");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3074903697, 59384, 19161, 180, 0, 173, 26, 75, 88, 238, 236}, 2))], [])*/PROPERTYKEY
{
    WPD_COMMAND_OBJECT_ENUMERATION_START_FIND = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3074903697, 59384, 19161, 180, 0, 173, 26, 75, 88, 238, 236}, 2))], [])*/PROPERTYKEY(GUID("B7474E91-E7F8-4AD9-B400-AD1A4B58EEEC"), 2),
    WPD_COMMAND_OBJECT_ENUMERATION_FIND_NEXT  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3074903697, 59384, 19161, 180, 0, 173, 26, 75, 88, 238, 236}, 2))], [])*/PROPERTYKEY(GUID("B7474E91-E7F8-4AD9-B400-AD1A4B58EEEC"), 3),
    WPD_COMMAND_OBJECT_ENUMERATION_END_FIND   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3074903697, 59384, 19161, 180, 0, 173, 26, 75, 88, 238, 236}, 2))], [])*/PROPERTYKEY(GUID("B7474E91-E7F8-4AD9-B400-AD1A4B58EEEC"), 4),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3074903697, 59384, 19161, 180, 0, 173, 26, 75, 88, 238, 236}, 1001))], [])*/PROPERTYKEY
{
    WPD_PROPERTY_OBJECT_ENUMERATION_PARENT_ID             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3074903697, 59384, 19161, 180, 0, 173, 26, 75, 88, 238, 236}, 1001))], [])*/PROPERTYKEY(GUID("B7474E91-E7F8-4AD9-B400-AD1A4B58EEEC"), 1001),
    WPD_PROPERTY_OBJECT_ENUMERATION_FILTER                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3074903697, 59384, 19161, 180, 0, 173, 26, 75, 88, 238, 236}, 1001))], [])*/PROPERTYKEY(GUID("B7474E91-E7F8-4AD9-B400-AD1A4B58EEEC"), 1002),
    WPD_PROPERTY_OBJECT_ENUMERATION_OBJECT_IDS            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3074903697, 59384, 19161, 180, 0, 173, 26, 75, 88, 238, 236}, 1001))], [])*/PROPERTYKEY(GUID("B7474E91-E7F8-4AD9-B400-AD1A4B58EEEC"), 1003),
    WPD_PROPERTY_OBJECT_ENUMERATION_CONTEXT               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3074903697, 59384, 19161, 180, 0, 173, 26, 75, 88, 238, 236}, 1001))], [])*/PROPERTYKEY(GUID("B7474E91-E7F8-4AD9-B400-AD1A4B58EEEC"), 1004),
    WPD_PROPERTY_OBJECT_ENUMERATION_NUM_OBJECTS_REQUESTED = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3074903697, 59384, 19161, 180, 0, 173, 26, 75, 88, 238, 236}, 1001))], [])*/PROPERTYKEY(GUID("B7474E91-E7F8-4AD9-B400-AD1A4B58EEEC"), 1005),
}

enum GUID WPD_CATEGORY_OBJECT_PROPERTIES = GUID("9e5582e4-0814-44e6-981a-b2998d583804");

enum : /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-command-object-properties-get-supported2))], [])*/PROPERTYKEY
{
    WPD_COMMAND_OBJECT_PROPERTIES_GET_SUPPORTED  = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-command-object-properties-get-supported2))], [])*/PROPERTYKEY(GUID("9E5582E4-0814-44E6-981A-B2998D583804"), 2),
    WPD_COMMAND_OBJECT_PROPERTIES_GET_ATTRIBUTES = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-command-object-properties-get-supported2))], [])*/PROPERTYKEY(GUID("9E5582E4-0814-44E6-981A-B2998D583804"), 3),
    WPD_COMMAND_OBJECT_PROPERTIES_GET            = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-command-object-properties-get-supported2))], [])*/PROPERTYKEY(GUID("9E5582E4-0814-44E6-981A-B2998D583804"), 4),
    WPD_COMMAND_OBJECT_PROPERTIES_SET            = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-command-object-properties-get-supported2))], [])*/PROPERTYKEY(GUID("9E5582E4-0814-44E6-981A-B2998D583804"), 5),
    WPD_COMMAND_OBJECT_PROPERTIES_GET_ALL        = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-command-object-properties-get-supported2))], [])*/PROPERTYKEY(GUID("9E5582E4-0814-44E6-981A-B2998D583804"), 6),
    WPD_COMMAND_OBJECT_PROPERTIES_DELETE         = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-command-object-properties-get-supported2))], [])*/PROPERTYKEY(GUID("9E5582E4-0814-44E6-981A-B2998D583804"), 7),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2656404196, 2068, 17638, 152, 26, 178, 153, 141, 88, 56, 4}, 1001))], [])*/PROPERTYKEY
{
    WPD_PROPERTY_OBJECT_PROPERTIES_OBJECT_ID               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2656404196, 2068, 17638, 152, 26, 178, 153, 141, 88, 56, 4}, 1001))], [])*/PROPERTYKEY(GUID("9E5582E4-0814-44E6-981A-B2998D583804"), 1001),
    WPD_PROPERTY_OBJECT_PROPERTIES_PROPERTY_KEYS           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2656404196, 2068, 17638, 152, 26, 178, 153, 141, 88, 56, 4}, 1001))], [])*/PROPERTYKEY(GUID("9E5582E4-0814-44E6-981A-B2998D583804"), 1002),
    WPD_PROPERTY_OBJECT_PROPERTIES_PROPERTY_ATTRIBUTES     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2656404196, 2068, 17638, 152, 26, 178, 153, 141, 88, 56, 4}, 1001))], [])*/PROPERTYKEY(GUID("9E5582E4-0814-44E6-981A-B2998D583804"), 1003),
    WPD_PROPERTY_OBJECT_PROPERTIES_PROPERTY_VALUES         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2656404196, 2068, 17638, 152, 26, 178, 153, 141, 88, 56, 4}, 1001))], [])*/PROPERTYKEY(GUID("9E5582E4-0814-44E6-981A-B2998D583804"), 1004),
    WPD_PROPERTY_OBJECT_PROPERTIES_PROPERTY_WRITE_RESULTS  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2656404196, 2068, 17638, 152, 26, 178, 153, 141, 88, 56, 4}, 1001))], [])*/PROPERTYKEY(GUID("9E5582E4-0814-44E6-981A-B2998D583804"), 1005),
    WPD_PROPERTY_OBJECT_PROPERTIES_PROPERTY_DELETE_RESULTS = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2656404196, 2068, 17638, 152, 26, 178, 153, 141, 88, 56, 4}, 1001))], [])*/PROPERTYKEY(GUID("9E5582E4-0814-44E6-981A-B2998D583804"), 1006),
}

enum GUID WPD_CATEGORY_OBJECT_PROPERTIES_BULK = GUID("11c824dd-04cd-4e4e-8c7b-f6efb794d84e");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({298329309, 1229, 20046, 140, 123, 246, 239, 183, 148, 216, 78}, 2))], [])*/PROPERTYKEY
{
    WPD_COMMAND_OBJECT_PROPERTIES_BULK_GET_VALUES_BY_OBJECT_LIST_START   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({298329309, 1229, 20046, 140, 123, 246, 239, 183, 148, 216, 78}, 2))], [])*/PROPERTYKEY(GUID("11C824DD-04CD-4E4E-8C7B-F6EFB794D84E"), 2),
    WPD_COMMAND_OBJECT_PROPERTIES_BULK_GET_VALUES_BY_OBJECT_LIST_NEXT    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({298329309, 1229, 20046, 140, 123, 246, 239, 183, 148, 216, 78}, 2))], [])*/PROPERTYKEY(GUID("11C824DD-04CD-4E4E-8C7B-F6EFB794D84E"), 3),
    WPD_COMMAND_OBJECT_PROPERTIES_BULK_GET_VALUES_BY_OBJECT_LIST_END     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({298329309, 1229, 20046, 140, 123, 246, 239, 183, 148, 216, 78}, 2))], [])*/PROPERTYKEY(GUID("11C824DD-04CD-4E4E-8C7B-F6EFB794D84E"), 4),
    WPD_COMMAND_OBJECT_PROPERTIES_BULK_GET_VALUES_BY_OBJECT_FORMAT_START = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({298329309, 1229, 20046, 140, 123, 246, 239, 183, 148, 216, 78}, 2))], [])*/PROPERTYKEY(GUID("11C824DD-04CD-4E4E-8C7B-F6EFB794D84E"), 5),
    WPD_COMMAND_OBJECT_PROPERTIES_BULK_GET_VALUES_BY_OBJECT_FORMAT_NEXT  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({298329309, 1229, 20046, 140, 123, 246, 239, 183, 148, 216, 78}, 2))], [])*/PROPERTYKEY(GUID("11C824DD-04CD-4E4E-8C7B-F6EFB794D84E"), 6),
    WPD_COMMAND_OBJECT_PROPERTIES_BULK_GET_VALUES_BY_OBJECT_FORMAT_END   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({298329309, 1229, 20046, 140, 123, 246, 239, 183, 148, 216, 78}, 2))], [])*/PROPERTYKEY(GUID("11C824DD-04CD-4E4E-8C7B-F6EFB794D84E"), 7),
    WPD_COMMAND_OBJECT_PROPERTIES_BULK_SET_VALUES_BY_OBJECT_LIST_START   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({298329309, 1229, 20046, 140, 123, 246, 239, 183, 148, 216, 78}, 2))], [])*/PROPERTYKEY(GUID("11C824DD-04CD-4E4E-8C7B-F6EFB794D84E"), 8),
    WPD_COMMAND_OBJECT_PROPERTIES_BULK_SET_VALUES_BY_OBJECT_LIST_NEXT    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({298329309, 1229, 20046, 140, 123, 246, 239, 183, 148, 216, 78}, 2))], [])*/PROPERTYKEY(GUID("11C824DD-04CD-4E4E-8C7B-F6EFB794D84E"), 9),
    WPD_COMMAND_OBJECT_PROPERTIES_BULK_SET_VALUES_BY_OBJECT_LIST_END     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({298329309, 1229, 20046, 140, 123, 246, 239, 183, 148, 216, 78}, 2))], [])*/PROPERTYKEY(GUID("11C824DD-04CD-4E4E-8C7B-F6EFB794D84E"), 10),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({298329309, 1229, 20046, 140, 123, 246, 239, 183, 148, 216, 78}, 1001))], [])*/PROPERTYKEY
{
    WPD_PROPERTY_OBJECT_PROPERTIES_BULK_OBJECT_IDS       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({298329309, 1229, 20046, 140, 123, 246, 239, 183, 148, 216, 78}, 1001))], [])*/PROPERTYKEY(GUID("11C824DD-04CD-4E4E-8C7B-F6EFB794D84E"), 1001),
    WPD_PROPERTY_OBJECT_PROPERTIES_BULK_CONTEXT          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({298329309, 1229, 20046, 140, 123, 246, 239, 183, 148, 216, 78}, 1001))], [])*/PROPERTYKEY(GUID("11C824DD-04CD-4E4E-8C7B-F6EFB794D84E"), 1002),
    WPD_PROPERTY_OBJECT_PROPERTIES_BULK_VALUES           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({298329309, 1229, 20046, 140, 123, 246, 239, 183, 148, 216, 78}, 1001))], [])*/PROPERTYKEY(GUID("11C824DD-04CD-4E4E-8C7B-F6EFB794D84E"), 1003),
    WPD_PROPERTY_OBJECT_PROPERTIES_BULK_PROPERTY_KEYS    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({298329309, 1229, 20046, 140, 123, 246, 239, 183, 148, 216, 78}, 1001))], [])*/PROPERTYKEY(GUID("11C824DD-04CD-4E4E-8C7B-F6EFB794D84E"), 1004),
    WPD_PROPERTY_OBJECT_PROPERTIES_BULK_DEPTH            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({298329309, 1229, 20046, 140, 123, 246, 239, 183, 148, 216, 78}, 1001))], [])*/PROPERTYKEY(GUID("11C824DD-04CD-4E4E-8C7B-F6EFB794D84E"), 1005),
    WPD_PROPERTY_OBJECT_PROPERTIES_BULK_PARENT_OBJECT_ID = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({298329309, 1229, 20046, 140, 123, 246, 239, 183, 148, 216, 78}, 1001))], [])*/PROPERTYKEY(GUID("11C824DD-04CD-4E4E-8C7B-F6EFB794D84E"), 1006),
    WPD_PROPERTY_OBJECT_PROPERTIES_BULK_OBJECT_FORMAT    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({298329309, 1229, 20046, 140, 123, 246, 239, 183, 148, 216, 78}, 1001))], [])*/PROPERTYKEY(GUID("11C824DD-04CD-4E4E-8C7B-F6EFB794D84E"), 1007),
    WPD_PROPERTY_OBJECT_PROPERTIES_BULK_WRITE_RESULTS    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({298329309, 1229, 20046, 140, 123, 246, 239, 183, 148, 216, 78}, 1001))], [])*/PROPERTYKEY(GUID("11C824DD-04CD-4E4E-8C7B-F6EFB794D84E"), 1008),
}

enum GUID WPD_CATEGORY_OBJECT_RESOURCES = GUID("b3a2b22d-a595-4108-be0a-fc3c965f3d4a");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3013784109, 42389, 16648, 190, 10, 252, 60, 150, 95, 61, 74}, 2))], [])*/PROPERTYKEY
{
    WPD_COMMAND_OBJECT_RESOURCES_GET_SUPPORTED   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3013784109, 42389, 16648, 190, 10, 252, 60, 150, 95, 61, 74}, 2))], [])*/PROPERTYKEY(GUID("B3A2B22D-A595-4108-BE0A-FC3C965F3D4A"), 2),
    WPD_COMMAND_OBJECT_RESOURCES_GET_ATTRIBUTES  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3013784109, 42389, 16648, 190, 10, 252, 60, 150, 95, 61, 74}, 2))], [])*/PROPERTYKEY(GUID("B3A2B22D-A595-4108-BE0A-FC3C965F3D4A"), 3),
    WPD_COMMAND_OBJECT_RESOURCES_OPEN            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3013784109, 42389, 16648, 190, 10, 252, 60, 150, 95, 61, 74}, 2))], [])*/PROPERTYKEY(GUID("B3A2B22D-A595-4108-BE0A-FC3C965F3D4A"), 4),
    WPD_COMMAND_OBJECT_RESOURCES_READ            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3013784109, 42389, 16648, 190, 10, 252, 60, 150, 95, 61, 74}, 2))], [])*/PROPERTYKEY(GUID("B3A2B22D-A595-4108-BE0A-FC3C965F3D4A"), 5),
    WPD_COMMAND_OBJECT_RESOURCES_WRITE           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3013784109, 42389, 16648, 190, 10, 252, 60, 150, 95, 61, 74}, 2))], [])*/PROPERTYKEY(GUID("B3A2B22D-A595-4108-BE0A-FC3C965F3D4A"), 6),
    WPD_COMMAND_OBJECT_RESOURCES_CLOSE           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3013784109, 42389, 16648, 190, 10, 252, 60, 150, 95, 61, 74}, 2))], [])*/PROPERTYKEY(GUID("B3A2B22D-A595-4108-BE0A-FC3C965F3D4A"), 7),
    WPD_COMMAND_OBJECT_RESOURCES_DELETE          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3013784109, 42389, 16648, 190, 10, 252, 60, 150, 95, 61, 74}, 2))], [])*/PROPERTYKEY(GUID("B3A2B22D-A595-4108-BE0A-FC3C965F3D4A"), 8),
    WPD_COMMAND_OBJECT_RESOURCES_CREATE_RESOURCE = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3013784109, 42389, 16648, 190, 10, 252, 60, 150, 95, 61, 74}, 2))], [])*/PROPERTYKEY(GUID("B3A2B22D-A595-4108-BE0A-FC3C965F3D4A"), 9),
    WPD_COMMAND_OBJECT_RESOURCES_REVERT          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3013784109, 42389, 16648, 190, 10, 252, 60, 150, 95, 61, 74}, 2))], [])*/PROPERTYKEY(GUID("B3A2B22D-A595-4108-BE0A-FC3C965F3D4A"), 10),
    WPD_COMMAND_OBJECT_RESOURCES_SEEK            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3013784109, 42389, 16648, 190, 10, 252, 60, 150, 95, 61, 74}, 2))], [])*/PROPERTYKEY(GUID("B3A2B22D-A595-4108-BE0A-FC3C965F3D4A"), 11),
    WPD_COMMAND_OBJECT_RESOURCES_COMMIT          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3013784109, 42389, 16648, 190, 10, 252, 60, 150, 95, 61, 74}, 2))], [])*/PROPERTYKEY(GUID("B3A2B22D-A595-4108-BE0A-FC3C965F3D4A"), 12),
    WPD_COMMAND_OBJECT_RESOURCES_SEEK_IN_UNITS   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3013784109, 42389, 16648, 190, 10, 252, 60, 150, 95, 61, 74}, 2))], [])*/PROPERTYKEY(GUID("B3A2B22D-A595-4108-BE0A-FC3C965F3D4A"), 13),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3013784109, 42389, 16648, 190, 10, 252, 60, 150, 95, 61, 74}, 1001))], [])*/PROPERTYKEY
{
    WPD_PROPERTY_OBJECT_RESOURCES_OBJECT_ID                    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3013784109, 42389, 16648, 190, 10, 252, 60, 150, 95, 61, 74}, 1001))], [])*/PROPERTYKEY(GUID("B3A2B22D-A595-4108-BE0A-FC3C965F3D4A"), 1001),
    WPD_PROPERTY_OBJECT_RESOURCES_ACCESS_MODE                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3013784109, 42389, 16648, 190, 10, 252, 60, 150, 95, 61, 74}, 1001))], [])*/PROPERTYKEY(GUID("B3A2B22D-A595-4108-BE0A-FC3C965F3D4A"), 1002),
    WPD_PROPERTY_OBJECT_RESOURCES_RESOURCE_KEYS                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3013784109, 42389, 16648, 190, 10, 252, 60, 150, 95, 61, 74}, 1001))], [])*/PROPERTYKEY(GUID("B3A2B22D-A595-4108-BE0A-FC3C965F3D4A"), 1003),
    WPD_PROPERTY_OBJECT_RESOURCES_RESOURCE_ATTRIBUTES          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3013784109, 42389, 16648, 190, 10, 252, 60, 150, 95, 61, 74}, 1001))], [])*/PROPERTYKEY(GUID("B3A2B22D-A595-4108-BE0A-FC3C965F3D4A"), 1004),
    WPD_PROPERTY_OBJECT_RESOURCES_CONTEXT                      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3013784109, 42389, 16648, 190, 10, 252, 60, 150, 95, 61, 74}, 1001))], [])*/PROPERTYKEY(GUID("B3A2B22D-A595-4108-BE0A-FC3C965F3D4A"), 1005),
    WPD_PROPERTY_OBJECT_RESOURCES_NUM_BYTES_TO_READ            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3013784109, 42389, 16648, 190, 10, 252, 60, 150, 95, 61, 74}, 1001))], [])*/PROPERTYKEY(GUID("B3A2B22D-A595-4108-BE0A-FC3C965F3D4A"), 1006),
    WPD_PROPERTY_OBJECT_RESOURCES_NUM_BYTES_READ               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3013784109, 42389, 16648, 190, 10, 252, 60, 150, 95, 61, 74}, 1001))], [])*/PROPERTYKEY(GUID("B3A2B22D-A595-4108-BE0A-FC3C965F3D4A"), 1007),
    WPD_PROPERTY_OBJECT_RESOURCES_NUM_BYTES_TO_WRITE           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3013784109, 42389, 16648, 190, 10, 252, 60, 150, 95, 61, 74}, 1001))], [])*/PROPERTYKEY(GUID("B3A2B22D-A595-4108-BE0A-FC3C965F3D4A"), 1008),
    WPD_PROPERTY_OBJECT_RESOURCES_NUM_BYTES_WRITTEN            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3013784109, 42389, 16648, 190, 10, 252, 60, 150, 95, 61, 74}, 1001))], [])*/PROPERTYKEY(GUID("B3A2B22D-A595-4108-BE0A-FC3C965F3D4A"), 1009),
    WPD_PROPERTY_OBJECT_RESOURCES_DATA                         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3013784109, 42389, 16648, 190, 10, 252, 60, 150, 95, 61, 74}, 1001))], [])*/PROPERTYKEY(GUID("B3A2B22D-A595-4108-BE0A-FC3C965F3D4A"), 1010),
    WPD_PROPERTY_OBJECT_RESOURCES_OPTIMAL_TRANSFER_BUFFER_SIZE = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3013784109, 42389, 16648, 190, 10, 252, 60, 150, 95, 61, 74}, 1001))], [])*/PROPERTYKEY(GUID("B3A2B22D-A595-4108-BE0A-FC3C965F3D4A"), 1011),
    WPD_PROPERTY_OBJECT_RESOURCES_SEEK_OFFSET                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3013784109, 42389, 16648, 190, 10, 252, 60, 150, 95, 61, 74}, 1001))], [])*/PROPERTYKEY(GUID("B3A2B22D-A595-4108-BE0A-FC3C965F3D4A"), 1012),
    WPD_PROPERTY_OBJECT_RESOURCES_SEEK_ORIGIN_FLAG             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3013784109, 42389, 16648, 190, 10, 252, 60, 150, 95, 61, 74}, 1001))], [])*/PROPERTYKEY(GUID("B3A2B22D-A595-4108-BE0A-FC3C965F3D4A"), 1013),
    WPD_PROPERTY_OBJECT_RESOURCES_POSITION_FROM_START          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3013784109, 42389, 16648, 190, 10, 252, 60, 150, 95, 61, 74}, 1001))], [])*/PROPERTYKEY(GUID("B3A2B22D-A595-4108-BE0A-FC3C965F3D4A"), 1014),
    WPD_PROPERTY_OBJECT_RESOURCES_SUPPORTS_UNITS               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3013784109, 42389, 16648, 190, 10, 252, 60, 150, 95, 61, 74}, 1001))], [])*/PROPERTYKEY(GUID("B3A2B22D-A595-4108-BE0A-FC3C965F3D4A"), 1015),
    WPD_PROPERTY_OBJECT_RESOURCES_STREAM_UNITS                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3013784109, 42389, 16648, 190, 10, 252, 60, 150, 95, 61, 74}, 1001))], [])*/PROPERTYKEY(GUID("B3A2B22D-A595-4108-BE0A-FC3C965F3D4A"), 1016),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3013784109, 42389, 16648, 190, 10, 252, 60, 150, 95, 61, 74}, 5001))], [])*/PROPERTYKEY
{
    WPD_OPTION_OBJECT_RESOURCES_SEEK_ON_READ_SUPPORTED  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3013784109, 42389, 16648, 190, 10, 252, 60, 150, 95, 61, 74}, 5001))], [])*/PROPERTYKEY(GUID("B3A2B22D-A595-4108-BE0A-FC3C965F3D4A"), 5001),
    WPD_OPTION_OBJECT_RESOURCES_SEEK_ON_WRITE_SUPPORTED = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3013784109, 42389, 16648, 190, 10, 252, 60, 150, 95, 61, 74}, 5001))], [])*/PROPERTYKEY(GUID("B3A2B22D-A595-4108-BE0A-FC3C965F3D4A"), 5002),
    WPD_OPTION_OBJECT_RESOURCES_NO_INPUT_BUFFER_ON_READ = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3013784109, 42389, 16648, 190, 10, 252, 60, 150, 95, 61, 74}, 5001))], [])*/PROPERTYKEY(GUID("B3A2B22D-A595-4108-BE0A-FC3C965F3D4A"), 5003),
}

enum GUID WPD_CATEGORY_OBJECT_MANAGEMENT = GUID("ef1e43dd-a9ed-4341-8bcc-186192aea089");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4011738077, 43501, 17217, 139, 204, 24, 97, 146, 174, 160, 137}, 2))], [])*/PROPERTYKEY
{
    WPD_COMMAND_OBJECT_MANAGEMENT_CREATE_OBJECT_WITH_PROPERTIES_ONLY     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4011738077, 43501, 17217, 139, 204, 24, 97, 146, 174, 160, 137}, 2))], [])*/PROPERTYKEY(GUID("EF1E43DD-A9ED-4341-8BCC-186192AEA089"), 2),
    WPD_COMMAND_OBJECT_MANAGEMENT_CREATE_OBJECT_WITH_PROPERTIES_AND_DATA = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4011738077, 43501, 17217, 139, 204, 24, 97, 146, 174, 160, 137}, 2))], [])*/PROPERTYKEY(GUID("EF1E43DD-A9ED-4341-8BCC-186192AEA089"), 3),
    WPD_COMMAND_OBJECT_MANAGEMENT_WRITE_OBJECT_DATA                      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4011738077, 43501, 17217, 139, 204, 24, 97, 146, 174, 160, 137}, 2))], [])*/PROPERTYKEY(GUID("EF1E43DD-A9ED-4341-8BCC-186192AEA089"), 4),
    WPD_COMMAND_OBJECT_MANAGEMENT_COMMIT_OBJECT                          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4011738077, 43501, 17217, 139, 204, 24, 97, 146, 174, 160, 137}, 2))], [])*/PROPERTYKEY(GUID("EF1E43DD-A9ED-4341-8BCC-186192AEA089"), 5),
    WPD_COMMAND_OBJECT_MANAGEMENT_REVERT_OBJECT                          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4011738077, 43501, 17217, 139, 204, 24, 97, 146, 174, 160, 137}, 2))], [])*/PROPERTYKEY(GUID("EF1E43DD-A9ED-4341-8BCC-186192AEA089"), 6),
    WPD_COMMAND_OBJECT_MANAGEMENT_DELETE_OBJECTS                         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4011738077, 43501, 17217, 139, 204, 24, 97, 146, 174, 160, 137}, 2))], [])*/PROPERTYKEY(GUID("EF1E43DD-A9ED-4341-8BCC-186192AEA089"), 7),
    WPD_COMMAND_OBJECT_MANAGEMENT_MOVE_OBJECTS                           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4011738077, 43501, 17217, 139, 204, 24, 97, 146, 174, 160, 137}, 2))], [])*/PROPERTYKEY(GUID("EF1E43DD-A9ED-4341-8BCC-186192AEA089"), 8),
    WPD_COMMAND_OBJECT_MANAGEMENT_COPY_OBJECTS                           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4011738077, 43501, 17217, 139, 204, 24, 97, 146, 174, 160, 137}, 2))], [])*/PROPERTYKEY(GUID("EF1E43DD-A9ED-4341-8BCC-186192AEA089"), 9),
    WPD_COMMAND_OBJECT_MANAGEMENT_UPDATE_OBJECT_WITH_PROPERTIES_AND_DATA = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4011738077, 43501, 17217, 139, 204, 24, 97, 146, 174, 160, 137}, 2))], [])*/PROPERTYKEY(GUID("EF1E43DD-A9ED-4341-8BCC-186192AEA089"), 10),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4011738077, 43501, 17217, 139, 204, 24, 97, 146, 174, 160, 137}, 1001))], [])*/PROPERTYKEY
{
    WPD_PROPERTY_OBJECT_MANAGEMENT_CREATION_PROPERTIES          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4011738077, 43501, 17217, 139, 204, 24, 97, 146, 174, 160, 137}, 1001))], [])*/PROPERTYKEY(GUID("EF1E43DD-A9ED-4341-8BCC-186192AEA089"), 1001),
    WPD_PROPERTY_OBJECT_MANAGEMENT_CONTEXT                      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4011738077, 43501, 17217, 139, 204, 24, 97, 146, 174, 160, 137}, 1001))], [])*/PROPERTYKEY(GUID("EF1E43DD-A9ED-4341-8BCC-186192AEA089"), 1002),
    WPD_PROPERTY_OBJECT_MANAGEMENT_NUM_BYTES_TO_WRITE           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4011738077, 43501, 17217, 139, 204, 24, 97, 146, 174, 160, 137}, 1001))], [])*/PROPERTYKEY(GUID("EF1E43DD-A9ED-4341-8BCC-186192AEA089"), 1003),
    WPD_PROPERTY_OBJECT_MANAGEMENT_NUM_BYTES_WRITTEN            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4011738077, 43501, 17217, 139, 204, 24, 97, 146, 174, 160, 137}, 1001))], [])*/PROPERTYKEY(GUID("EF1E43DD-A9ED-4341-8BCC-186192AEA089"), 1004),
    WPD_PROPERTY_OBJECT_MANAGEMENT_DATA                         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4011738077, 43501, 17217, 139, 204, 24, 97, 146, 174, 160, 137}, 1001))], [])*/PROPERTYKEY(GUID("EF1E43DD-A9ED-4341-8BCC-186192AEA089"), 1005),
    WPD_PROPERTY_OBJECT_MANAGEMENT_OBJECT_ID                    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4011738077, 43501, 17217, 139, 204, 24, 97, 146, 174, 160, 137}, 1001))], [])*/PROPERTYKEY(GUID("EF1E43DD-A9ED-4341-8BCC-186192AEA089"), 1006),
    WPD_PROPERTY_OBJECT_MANAGEMENT_DELETE_OPTIONS               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4011738077, 43501, 17217, 139, 204, 24, 97, 146, 174, 160, 137}, 1001))], [])*/PROPERTYKEY(GUID("EF1E43DD-A9ED-4341-8BCC-186192AEA089"), 1007),
    WPD_PROPERTY_OBJECT_MANAGEMENT_OPTIMAL_TRANSFER_BUFFER_SIZE = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4011738077, 43501, 17217, 139, 204, 24, 97, 146, 174, 160, 137}, 1001))], [])*/PROPERTYKEY(GUID("EF1E43DD-A9ED-4341-8BCC-186192AEA089"), 1008),
    WPD_PROPERTY_OBJECT_MANAGEMENT_OBJECT_IDS                   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4011738077, 43501, 17217, 139, 204, 24, 97, 146, 174, 160, 137}, 1001))], [])*/PROPERTYKEY(GUID("EF1E43DD-A9ED-4341-8BCC-186192AEA089"), 1009),
    WPD_PROPERTY_OBJECT_MANAGEMENT_DELETE_RESULTS               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4011738077, 43501, 17217, 139, 204, 24, 97, 146, 174, 160, 137}, 1001))], [])*/PROPERTYKEY(GUID("EF1E43DD-A9ED-4341-8BCC-186192AEA089"), 1010),
    WPD_PROPERTY_OBJECT_MANAGEMENT_DESTINATION_FOLDER_OBJECT_ID = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4011738077, 43501, 17217, 139, 204, 24, 97, 146, 174, 160, 137}, 1001))], [])*/PROPERTYKEY(GUID("EF1E43DD-A9ED-4341-8BCC-186192AEA089"), 1011),
    WPD_PROPERTY_OBJECT_MANAGEMENT_MOVE_RESULTS                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4011738077, 43501, 17217, 139, 204, 24, 97, 146, 174, 160, 137}, 1001))], [])*/PROPERTYKEY(GUID("EF1E43DD-A9ED-4341-8BCC-186192AEA089"), 1012),
    WPD_PROPERTY_OBJECT_MANAGEMENT_COPY_RESULTS                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4011738077, 43501, 17217, 139, 204, 24, 97, 146, 174, 160, 137}, 1001))], [])*/PROPERTYKEY(GUID("EF1E43DD-A9ED-4341-8BCC-186192AEA089"), 1013),
    WPD_PROPERTY_OBJECT_MANAGEMENT_UPDATE_PROPERTIES            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4011738077, 43501, 17217, 139, 204, 24, 97, 146, 174, 160, 137}, 1001))], [])*/PROPERTYKEY(GUID("EF1E43DD-A9ED-4341-8BCC-186192AEA089"), 1014),
    WPD_PROPERTY_OBJECT_MANAGEMENT_PROPERTY_KEYS                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4011738077, 43501, 17217, 139, 204, 24, 97, 146, 174, 160, 137}, 1001))], [])*/PROPERTYKEY(GUID("EF1E43DD-A9ED-4341-8BCC-186192AEA089"), 1015),
    WPD_PROPERTY_OBJECT_MANAGEMENT_OBJECT_FORMAT                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4011738077, 43501, 17217, 139, 204, 24, 97, 146, 174, 160, 137}, 1001))], [])*/PROPERTYKEY(GUID("EF1E43DD-A9ED-4341-8BCC-186192AEA089"), 1016),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4011738077, 43501, 17217, 139, 204, 24, 97, 146, 174, 160, 137}, 5001))], [])*/PROPERTYKEY WPD_OPTION_OBJECT_MANAGEMENT_RECURSIVE_DELETE_SUPPORTED = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4011738077, 43501, 17217, 139, 204, 24, 97, 146, 174, 160, 137}, 5001))], [])*/PROPERTYKEY(GUID("EF1E43DD-A9ED-4341-8BCC-186192AEA089"), 5001);
enum GUID WPD_CATEGORY_CAPABILITIES = GUID("0cabec78-6b74-41c6-9216-2639d1fce356");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({212593784, 27508, 16838, 146, 22, 38, 57, 209, 252, 227, 86}, 2))], [])*/PROPERTYKEY
{
    WPD_COMMAND_CAPABILITIES_GET_SUPPORTED_COMMANDS              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({212593784, 27508, 16838, 146, 22, 38, 57, 209, 252, 227, 86}, 2))], [])*/PROPERTYKEY(GUID("0CABEC78-6B74-41C6-9216-2639D1FCE356"), 2),
    WPD_COMMAND_CAPABILITIES_GET_COMMAND_OPTIONS                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({212593784, 27508, 16838, 146, 22, 38, 57, 209, 252, 227, 86}, 2))], [])*/PROPERTYKEY(GUID("0CABEC78-6B74-41C6-9216-2639D1FCE356"), 3),
    WPD_COMMAND_CAPABILITIES_GET_SUPPORTED_FUNCTIONAL_CATEGORIES = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({212593784, 27508, 16838, 146, 22, 38, 57, 209, 252, 227, 86}, 2))], [])*/PROPERTYKEY(GUID("0CABEC78-6B74-41C6-9216-2639D1FCE356"), 4),
    WPD_COMMAND_CAPABILITIES_GET_FUNCTIONAL_OBJECTS              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({212593784, 27508, 16838, 146, 22, 38, 57, 209, 252, 227, 86}, 2))], [])*/PROPERTYKEY(GUID("0CABEC78-6B74-41C6-9216-2639D1FCE356"), 5),
    WPD_COMMAND_CAPABILITIES_GET_SUPPORTED_CONTENT_TYPES         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({212593784, 27508, 16838, 146, 22, 38, 57, 209, 252, 227, 86}, 2))], [])*/PROPERTYKEY(GUID("0CABEC78-6B74-41C6-9216-2639D1FCE356"), 6),
    WPD_COMMAND_CAPABILITIES_GET_SUPPORTED_FORMATS               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({212593784, 27508, 16838, 146, 22, 38, 57, 209, 252, 227, 86}, 2))], [])*/PROPERTYKEY(GUID("0CABEC78-6B74-41C6-9216-2639D1FCE356"), 7),
    WPD_COMMAND_CAPABILITIES_GET_SUPPORTED_FORMAT_PROPERTIES     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({212593784, 27508, 16838, 146, 22, 38, 57, 209, 252, 227, 86}, 2))], [])*/PROPERTYKEY(GUID("0CABEC78-6B74-41C6-9216-2639D1FCE356"), 8),
    WPD_COMMAND_CAPABILITIES_GET_FIXED_PROPERTY_ATTRIBUTES       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({212593784, 27508, 16838, 146, 22, 38, 57, 209, 252, 227, 86}, 2))], [])*/PROPERTYKEY(GUID("0CABEC78-6B74-41C6-9216-2639D1FCE356"), 9),
    WPD_COMMAND_CAPABILITIES_GET_SUPPORTED_EVENTS                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({212593784, 27508, 16838, 146, 22, 38, 57, 209, 252, 227, 86}, 2))], [])*/PROPERTYKEY(GUID("0CABEC78-6B74-41C6-9216-2639D1FCE356"), 10),
    WPD_COMMAND_CAPABILITIES_GET_EVENT_OPTIONS                   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({212593784, 27508, 16838, 146, 22, 38, 57, 209, 252, 227, 86}, 2))], [])*/PROPERTYKEY(GUID("0CABEC78-6B74-41C6-9216-2639D1FCE356"), 11),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({212593784, 27508, 16838, 146, 22, 38, 57, 209, 252, 227, 86}, 1001))], [])*/PROPERTYKEY
{
    WPD_PROPERTY_CAPABILITIES_SUPPORTED_COMMANDS    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({212593784, 27508, 16838, 146, 22, 38, 57, 209, 252, 227, 86}, 1001))], [])*/PROPERTYKEY(GUID("0CABEC78-6B74-41C6-9216-2639D1FCE356"), 1001),
    WPD_PROPERTY_CAPABILITIES_COMMAND               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({212593784, 27508, 16838, 146, 22, 38, 57, 209, 252, 227, 86}, 1001))], [])*/PROPERTYKEY(GUID("0CABEC78-6B74-41C6-9216-2639D1FCE356"), 1002),
    WPD_PROPERTY_CAPABILITIES_COMMAND_OPTIONS       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({212593784, 27508, 16838, 146, 22, 38, 57, 209, 252, 227, 86}, 1001))], [])*/PROPERTYKEY(GUID("0CABEC78-6B74-41C6-9216-2639D1FCE356"), 1003),
    WPD_PROPERTY_CAPABILITIES_FUNCTIONAL_CATEGORIES = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({212593784, 27508, 16838, 146, 22, 38, 57, 209, 252, 227, 86}, 1001))], [])*/PROPERTYKEY(GUID("0CABEC78-6B74-41C6-9216-2639D1FCE356"), 1004),
    WPD_PROPERTY_CAPABILITIES_FUNCTIONAL_CATEGORY   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({212593784, 27508, 16838, 146, 22, 38, 57, 209, 252, 227, 86}, 1001))], [])*/PROPERTYKEY(GUID("0CABEC78-6B74-41C6-9216-2639D1FCE356"), 1005),
    WPD_PROPERTY_CAPABILITIES_FUNCTIONAL_OBJECTS    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({212593784, 27508, 16838, 146, 22, 38, 57, 209, 252, 227, 86}, 1001))], [])*/PROPERTYKEY(GUID("0CABEC78-6B74-41C6-9216-2639D1FCE356"), 1006),
    WPD_PROPERTY_CAPABILITIES_CONTENT_TYPES         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({212593784, 27508, 16838, 146, 22, 38, 57, 209, 252, 227, 86}, 1001))], [])*/PROPERTYKEY(GUID("0CABEC78-6B74-41C6-9216-2639D1FCE356"), 1007),
    WPD_PROPERTY_CAPABILITIES_CONTENT_TYPE          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({212593784, 27508, 16838, 146, 22, 38, 57, 209, 252, 227, 86}, 1001))], [])*/PROPERTYKEY(GUID("0CABEC78-6B74-41C6-9216-2639D1FCE356"), 1008),
    WPD_PROPERTY_CAPABILITIES_FORMATS               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({212593784, 27508, 16838, 146, 22, 38, 57, 209, 252, 227, 86}, 1001))], [])*/PROPERTYKEY(GUID("0CABEC78-6B74-41C6-9216-2639D1FCE356"), 1009),
    WPD_PROPERTY_CAPABILITIES_FORMAT                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({212593784, 27508, 16838, 146, 22, 38, 57, 209, 252, 227, 86}, 1001))], [])*/PROPERTYKEY(GUID("0CABEC78-6B74-41C6-9216-2639D1FCE356"), 1010),
    WPD_PROPERTY_CAPABILITIES_PROPERTY_KEYS         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({212593784, 27508, 16838, 146, 22, 38, 57, 209, 252, 227, 86}, 1001))], [])*/PROPERTYKEY(GUID("0CABEC78-6B74-41C6-9216-2639D1FCE356"), 1011),
    WPD_PROPERTY_CAPABILITIES_PROPERTY_ATTRIBUTES   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({212593784, 27508, 16838, 146, 22, 38, 57, 209, 252, 227, 86}, 1001))], [])*/PROPERTYKEY(GUID("0CABEC78-6B74-41C6-9216-2639D1FCE356"), 1012),
    WPD_PROPERTY_CAPABILITIES_SUPPORTED_EVENTS      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({212593784, 27508, 16838, 146, 22, 38, 57, 209, 252, 227, 86}, 1001))], [])*/PROPERTYKEY(GUID("0CABEC78-6B74-41C6-9216-2639D1FCE356"), 1013),
    WPD_PROPERTY_CAPABILITIES_EVENT                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({212593784, 27508, 16838, 146, 22, 38, 57, 209, 252, 227, 86}, 1001))], [])*/PROPERTYKEY(GUID("0CABEC78-6B74-41C6-9216-2639D1FCE356"), 1014),
    WPD_PROPERTY_CAPABILITIES_EVENT_OPTIONS         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({212593784, 27508, 16838, 146, 22, 38, 57, 209, 252, 227, 86}, 1001))], [])*/PROPERTYKEY(GUID("0CABEC78-6B74-41C6-9216-2639D1FCE356"), 1015),
}

enum GUID WPD_CATEGORY_STORAGE = GUID("d8f907a6-34cc-45fa-97fb-d007fa47ec94");

enum : /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-command-storage-format-command))], [])*/PROPERTYKEY
{
    WPD_COMMAND_STORAGE_FORMAT = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-command-storage-format-command))], [])*/PROPERTYKEY(GUID("D8F907A6-34CC-45FA-97FB-D007FA47EC94"), 2),
    WPD_COMMAND_STORAGE_EJECT  = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-command-storage-format-command))], [])*/PROPERTYKEY(GUID("D8F907A6-34CC-45FA-97FB-D007FA47EC94"), 4),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3640199078, 13516, 17914, 151, 251, 208, 7, 250, 71, 236, 148}, 1001))], [])*/PROPERTYKEY
{
    WPD_PROPERTY_STORAGE_OBJECT_ID             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3640199078, 13516, 17914, 151, 251, 208, 7, 250, 71, 236, 148}, 1001))], [])*/PROPERTYKEY(GUID("D8F907A6-34CC-45FA-97FB-D007FA47EC94"), 1001),
    WPD_PROPERTY_STORAGE_DESTINATION_OBJECT_ID = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3640199078, 13516, 17914, 151, 251, 208, 7, 250, 71, 236, 148}, 1001))], [])*/PROPERTYKEY(GUID("D8F907A6-34CC-45FA-97FB-D007FA47EC94"), 1002),
}

enum GUID WPD_CATEGORY_SMS = GUID("afc25d66-fe0d-4114-9097-970c93e920d1");
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-command-sms-send-command))], [])*/PROPERTYKEY WPD_COMMAND_SMS_SEND = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-command-sms-send-command))], [])*/PROPERTYKEY(GUID("AFC25D66-FE0D-4114-9097-970C93E920D1"), 2);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2948750694, 65037, 16660, 144, 151, 151, 12, 147, 233, 32, 209}, 1001))], [])*/PROPERTYKEY
{
    WPD_PROPERTY_SMS_RECIPIENT      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2948750694, 65037, 16660, 144, 151, 151, 12, 147, 233, 32, 209}, 1001))], [])*/PROPERTYKEY(GUID("AFC25D66-FE0D-4114-9097-970C93E920D1"), 1001),
    WPD_PROPERTY_SMS_MESSAGE_TYPE   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2948750694, 65037, 16660, 144, 151, 151, 12, 147, 233, 32, 209}, 1001))], [])*/PROPERTYKEY(GUID("AFC25D66-FE0D-4114-9097-970C93E920D1"), 1002),
    WPD_PROPERTY_SMS_TEXT_MESSAGE   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2948750694, 65037, 16660, 144, 151, 151, 12, 147, 233, 32, 209}, 1001))], [])*/PROPERTYKEY(GUID("AFC25D66-FE0D-4114-9097-970C93E920D1"), 1003),
    WPD_PROPERTY_SMS_BINARY_MESSAGE = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2948750694, 65037, 16660, 144, 151, 151, 12, 147, 233, 32, 209}, 1001))], [])*/PROPERTYKEY(GUID("AFC25D66-FE0D-4114-9097-970C93E920D1"), 1004),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2948750694, 65037, 16660, 144, 151, 151, 12, 147, 233, 32, 209}, 5001))], [])*/PROPERTYKEY WPD_OPTION_SMS_BINARY_MESSAGE_SUPPORTED = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2948750694, 65037, 16660, 144, 151, 151, 12, 147, 233, 32, 209}, 5001))], [])*/PROPERTYKEY(GUID("AFC25D66-FE0D-4114-9097-970C93E920D1"), 5001);
enum GUID WPD_CATEGORY_STILL_IMAGE_CAPTURE = GUID("4fcd6982-22a2-4b05-a48b-62d38bf27b32");
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-command-still-image-capture-initiate-command))], [])*/PROPERTYKEY WPD_COMMAND_STILL_IMAGE_CAPTURE_INITIATE = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-command-still-image-capture-initiate-command))], [])*/PROPERTYKEY(GUID("4FCD6982-22A2-4B05-A48B-62D38BF27B32"), 2);
enum GUID WPD_CATEGORY_MEDIA_CAPTURE = GUID("59b433ba-fe44-4d8d-808c-6bcb9b0f15e8");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1504981946, 65092, 19853, 128, 140, 107, 203, 155, 15, 21, 232}, 2))], [])*/PROPERTYKEY
{
    WPD_COMMAND_MEDIA_CAPTURE_START = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1504981946, 65092, 19853, 128, 140, 107, 203, 155, 15, 21, 232}, 2))], [])*/PROPERTYKEY(GUID("59B433BA-FE44-4D8D-808C-6BCB9B0F15E8"), 2),
    WPD_COMMAND_MEDIA_CAPTURE_STOP  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1504981946, 65092, 19853, 128, 140, 107, 203, 155, 15, 21, 232}, 2))], [])*/PROPERTYKEY(GUID("59B433BA-FE44-4D8D-808C-6BCB9B0F15E8"), 3),
    WPD_COMMAND_MEDIA_CAPTURE_PAUSE = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1504981946, 65092, 19853, 128, 140, 107, 203, 155, 15, 21, 232}, 2))], [])*/PROPERTYKEY(GUID("59B433BA-FE44-4D8D-808C-6BCB9B0F15E8"), 4),
}

enum GUID WPD_CATEGORY_DEVICE_HINTS = GUID("0d5fb92b-cb46-4c4f-8343-0bc3d3f17c84");
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-command-device-hints-get-content-location-command))], [])*/PROPERTYKEY WPD_COMMAND_DEVICE_HINTS_GET_CONTENT_LOCATION = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-command-device-hints-get-content-location-command))], [])*/PROPERTYKEY(GUID("0D5FB92B-CB46-4C4F-8343-0BC3D3F17C84"), 2);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({224377131, 52038, 19535, 131, 67, 11, 195, 211, 241, 124, 132}, 1001))], [])*/PROPERTYKEY
{
    WPD_PROPERTY_DEVICE_HINTS_CONTENT_TYPE      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({224377131, 52038, 19535, 131, 67, 11, 195, 211, 241, 124, 132}, 1001))], [])*/PROPERTYKEY(GUID("0D5FB92B-CB46-4C4F-8343-0BC3D3F17C84"), 1001),
    WPD_PROPERTY_DEVICE_HINTS_CONTENT_LOCATIONS = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({224377131, 52038, 19535, 131, 67, 11, 195, 211, 241, 124, 132}, 1001))], [])*/PROPERTYKEY(GUID("0D5FB92B-CB46-4C4F-8343-0BC3D3F17C84"), 1002),
}

enum GUID WPD_CLASS_EXTENSION_V1 = GUID("33fb0d11-64a3-4fac-b4c7-3dfeaa99b051");
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({872090897, 25763, 20396, 180, 199, 61, 254, 170, 153, 176, 81}, 2))], [])*/PROPERTYKEY WPD_COMMAND_CLASS_EXTENSION_WRITE_DEVICE_INFORMATION = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({872090897, 25763, 20396, 180, 199, 61, 254, 170, 153, 176, 81}, 2))], [])*/PROPERTYKEY(GUID("33FB0D11-64A3-4FAC-B4C7-3DFEAA99B051"), 2);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({872090897, 25763, 20396, 180, 199, 61, 254, 170, 153, 176, 81}, 1001))], [])*/PROPERTYKEY
{
    WPD_PROPERTY_CLASS_EXTENSION_DEVICE_INFORMATION_VALUES        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({872090897, 25763, 20396, 180, 199, 61, 254, 170, 153, 176, 81}, 1001))], [])*/PROPERTYKEY(GUID("33FB0D11-64A3-4FAC-B4C7-3DFEAA99B051"), 1001),
    WPD_PROPERTY_CLASS_EXTENSION_DEVICE_INFORMATION_WRITE_RESULTS = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({872090897, 25763, 20396, 180, 199, 61, 254, 170, 153, 176, 81}, 1001))], [])*/PROPERTYKEY(GUID("33FB0D11-64A3-4FAC-B4C7-3DFEAA99B051"), 1002),
}

enum GUID WPD_CLASS_EXTENSION_V2 = GUID("7f0779b5-fa2b-4766-9cb2-f73ba30b6758");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2131196341, 64043, 18278, 156, 178, 247, 59, 163, 11, 103, 88}, 2))], [])*/PROPERTYKEY
{
    WPD_COMMAND_CLASS_EXTENSION_REGISTER_SERVICE_INTERFACES   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2131196341, 64043, 18278, 156, 178, 247, 59, 163, 11, 103, 88}, 2))], [])*/PROPERTYKEY(GUID("7F0779B5-FA2B-4766-9CB2-F73BA30B6758"), 2),
    WPD_COMMAND_CLASS_EXTENSION_UNREGISTER_SERVICE_INTERFACES = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2131196341, 64043, 18278, 156, 178, 247, 59, 163, 11, 103, 88}, 2))], [])*/PROPERTYKEY(GUID("7F0779B5-FA2B-4766-9CB2-F73BA30B6758"), 3),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2131196341, 64043, 18278, 156, 178, 247, 59, 163, 11, 103, 88}, 1001))], [])*/PROPERTYKEY
{
    WPD_PROPERTY_CLASS_EXTENSION_SERVICE_OBJECT_ID            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2131196341, 64043, 18278, 156, 178, 247, 59, 163, 11, 103, 88}, 1001))], [])*/PROPERTYKEY(GUID("7F0779B5-FA2B-4766-9CB2-F73BA30B6758"), 1001),
    WPD_PROPERTY_CLASS_EXTENSION_SERVICE_INTERFACES           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2131196341, 64043, 18278, 156, 178, 247, 59, 163, 11, 103, 88}, 1001))], [])*/PROPERTYKEY(GUID("7F0779B5-FA2B-4766-9CB2-F73BA30B6758"), 1002),
    WPD_PROPERTY_CLASS_EXTENSION_SERVICE_REGISTRATION_RESULTS = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2131196341, 64043, 18278, 156, 178, 247, 59, 163, 11, 103, 88}, 1001))], [])*/PROPERTYKEY(GUID("7F0779B5-FA2B-4766-9CB2-F73BA30B6758"), 1003),
}

enum GUID WPD_CATEGORY_NETWORK_CONFIGURATION = GUID("78f9c6fc-79b8-473c-9060-6bd23dd072c4");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2029635324, 31160, 18236, 144, 96, 107, 210, 61, 208, 114, 196}, 2))], [])*/PROPERTYKEY
{
    WPD_COMMAND_GENERATE_KEYPAIR         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2029635324, 31160, 18236, 144, 96, 107, 210, 61, 208, 114, 196}, 2))], [])*/PROPERTYKEY(GUID("78F9C6FC-79B8-473C-9060-6BD23DD072C4"), 2),
    WPD_COMMAND_COMMIT_KEYPAIR           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2029635324, 31160, 18236, 144, 96, 107, 210, 61, 208, 114, 196}, 2))], [])*/PROPERTYKEY(GUID("78F9C6FC-79B8-473C-9060-6BD23DD072C4"), 3),
    WPD_COMMAND_PROCESS_WIRELESS_PROFILE = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2029635324, 31160, 18236, 144, 96, 107, 210, 61, 208, 114, 196}, 2))], [])*/PROPERTYKEY(GUID("78F9C6FC-79B8-473C-9060-6BD23DD072C4"), 4),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2029635324, 31160, 18236, 144, 96, 107, 210, 61, 208, 114, 196}, 1001))], [])*/PROPERTYKEY WPD_PROPERTY_PUBLIC_KEY = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2029635324, 31160, 18236, 144, 96, 107, 210, 61, 208, 114, 196}, 1001))], [])*/PROPERTYKEY(GUID("78F9C6FC-79B8-473C-9060-6BD23DD072C4"), 1001);
enum GUID WPD_CATEGORY_SERVICE_COMMON = GUID("322f071d-36ef-477f-b4b5-6f52d734baee");
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({841942813, 14063, 18303, 180, 181, 111, 82, 215, 52, 186, 238}, 2))], [])*/PROPERTYKEY WPD_COMMAND_SERVICE_COMMON_GET_SERVICE_OBJECT_ID = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({841942813, 14063, 18303, 180, 181, 111, 82, 215, 52, 186, 238}, 2))], [])*/PROPERTYKEY(GUID("322F071D-36EF-477F-B4B5-6F52D734BAEE"), 2);
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({841942813, 14063, 18303, 180, 181, 111, 82, 215, 52, 186, 238}, 1001))], [])*/PROPERTYKEY WPD_PROPERTY_SERVICE_OBJECT_ID = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({841942813, 14063, 18303, 180, 181, 111, 82, 215, 52, 186, 238}, 1001))], [])*/PROPERTYKEY(GUID("322F071D-36EF-477F-B4B5-6F52D734BAEE"), 1001);
enum GUID WPD_CATEGORY_SERVICE_CAPABILITIES = GUID("24457e74-2e9f-44f9-8c57-1d1bcb170b89");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({608534132, 11935, 17657, 140, 87, 29, 27, 203, 23, 11, 137}, 2))], [])*/PROPERTYKEY
{
    WPD_COMMAND_SERVICE_CAPABILITIES_GET_SUPPORTED_METHODS           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({608534132, 11935, 17657, 140, 87, 29, 27, 203, 23, 11, 137}, 2))], [])*/PROPERTYKEY(GUID("24457E74-2E9F-44F9-8C57-1D1BCB170B89"), 2),
    WPD_COMMAND_SERVICE_CAPABILITIES_GET_SUPPORTED_METHODS_BY_FORMAT = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({608534132, 11935, 17657, 140, 87, 29, 27, 203, 23, 11, 137}, 2))], [])*/PROPERTYKEY(GUID("24457E74-2E9F-44F9-8C57-1D1BCB170B89"), 3),
    WPD_COMMAND_SERVICE_CAPABILITIES_GET_METHOD_ATTRIBUTES           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({608534132, 11935, 17657, 140, 87, 29, 27, 203, 23, 11, 137}, 2))], [])*/PROPERTYKEY(GUID("24457E74-2E9F-44F9-8C57-1D1BCB170B89"), 4),
    WPD_COMMAND_SERVICE_CAPABILITIES_GET_METHOD_PARAMETER_ATTRIBUTES = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({608534132, 11935, 17657, 140, 87, 29, 27, 203, 23, 11, 137}, 2))], [])*/PROPERTYKEY(GUID("24457E74-2E9F-44F9-8C57-1D1BCB170B89"), 5),
    WPD_COMMAND_SERVICE_CAPABILITIES_GET_SUPPORTED_FORMATS           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({608534132, 11935, 17657, 140, 87, 29, 27, 203, 23, 11, 137}, 2))], [])*/PROPERTYKEY(GUID("24457E74-2E9F-44F9-8C57-1D1BCB170B89"), 6),
    WPD_COMMAND_SERVICE_CAPABILITIES_GET_FORMAT_ATTRIBUTES           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({608534132, 11935, 17657, 140, 87, 29, 27, 203, 23, 11, 137}, 2))], [])*/PROPERTYKEY(GUID("24457E74-2E9F-44F9-8C57-1D1BCB170B89"), 7),
    WPD_COMMAND_SERVICE_CAPABILITIES_GET_SUPPORTED_FORMAT_PROPERTIES = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({608534132, 11935, 17657, 140, 87, 29, 27, 203, 23, 11, 137}, 2))], [])*/PROPERTYKEY(GUID("24457E74-2E9F-44F9-8C57-1D1BCB170B89"), 8),
    WPD_COMMAND_SERVICE_CAPABILITIES_GET_FORMAT_PROPERTY_ATTRIBUTES  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({608534132, 11935, 17657, 140, 87, 29, 27, 203, 23, 11, 137}, 2))], [])*/PROPERTYKEY(GUID("24457E74-2E9F-44F9-8C57-1D1BCB170B89"), 9),
    WPD_COMMAND_SERVICE_CAPABILITIES_GET_SUPPORTED_EVENTS            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({608534132, 11935, 17657, 140, 87, 29, 27, 203, 23, 11, 137}, 2))], [])*/PROPERTYKEY(GUID("24457E74-2E9F-44F9-8C57-1D1BCB170B89"), 10),
    WPD_COMMAND_SERVICE_CAPABILITIES_GET_EVENT_ATTRIBUTES            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({608534132, 11935, 17657, 140, 87, 29, 27, 203, 23, 11, 137}, 2))], [])*/PROPERTYKEY(GUID("24457E74-2E9F-44F9-8C57-1D1BCB170B89"), 11),
    WPD_COMMAND_SERVICE_CAPABILITIES_GET_EVENT_PARAMETER_ATTRIBUTES  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({608534132, 11935, 17657, 140, 87, 29, 27, 203, 23, 11, 137}, 2))], [])*/PROPERTYKEY(GUID("24457E74-2E9F-44F9-8C57-1D1BCB170B89"), 12),
    WPD_COMMAND_SERVICE_CAPABILITIES_GET_INHERITED_SERVICES          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({608534132, 11935, 17657, 140, 87, 29, 27, 203, 23, 11, 137}, 2))], [])*/PROPERTYKEY(GUID("24457E74-2E9F-44F9-8C57-1D1BCB170B89"), 13),
    WPD_COMMAND_SERVICE_CAPABILITIES_GET_FORMAT_RENDERING_PROFILES   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({608534132, 11935, 17657, 140, 87, 29, 27, 203, 23, 11, 137}, 2))], [])*/PROPERTYKEY(GUID("24457E74-2E9F-44F9-8C57-1D1BCB170B89"), 14),
    WPD_COMMAND_SERVICE_CAPABILITIES_GET_SUPPORTED_COMMANDS          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({608534132, 11935, 17657, 140, 87, 29, 27, 203, 23, 11, 137}, 2))], [])*/PROPERTYKEY(GUID("24457E74-2E9F-44F9-8C57-1D1BCB170B89"), 15),
    WPD_COMMAND_SERVICE_CAPABILITIES_GET_COMMAND_OPTIONS             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({608534132, 11935, 17657, 140, 87, 29, 27, 203, 23, 11, 137}, 2))], [])*/PROPERTYKEY(GUID("24457E74-2E9F-44F9-8C57-1D1BCB170B89"), 16),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({608534132, 11935, 17657, 140, 87, 29, 27, 203, 23, 11, 137}, 1001))], [])*/PROPERTYKEY
{
    WPD_PROPERTY_SERVICE_CAPABILITIES_SUPPORTED_METHODS    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({608534132, 11935, 17657, 140, 87, 29, 27, 203, 23, 11, 137}, 1001))], [])*/PROPERTYKEY(GUID("24457E74-2E9F-44F9-8C57-1D1BCB170B89"), 1001),
    WPD_PROPERTY_SERVICE_CAPABILITIES_FORMAT               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({608534132, 11935, 17657, 140, 87, 29, 27, 203, 23, 11, 137}, 1001))], [])*/PROPERTYKEY(GUID("24457E74-2E9F-44F9-8C57-1D1BCB170B89"), 1002),
    WPD_PROPERTY_SERVICE_CAPABILITIES_METHOD               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({608534132, 11935, 17657, 140, 87, 29, 27, 203, 23, 11, 137}, 1001))], [])*/PROPERTYKEY(GUID("24457E74-2E9F-44F9-8C57-1D1BCB170B89"), 1003),
    WPD_PROPERTY_SERVICE_CAPABILITIES_METHOD_ATTRIBUTES    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({608534132, 11935, 17657, 140, 87, 29, 27, 203, 23, 11, 137}, 1001))], [])*/PROPERTYKEY(GUID("24457E74-2E9F-44F9-8C57-1D1BCB170B89"), 1004),
    WPD_PROPERTY_SERVICE_CAPABILITIES_PARAMETER            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({608534132, 11935, 17657, 140, 87, 29, 27, 203, 23, 11, 137}, 1001))], [])*/PROPERTYKEY(GUID("24457E74-2E9F-44F9-8C57-1D1BCB170B89"), 1005),
    WPD_PROPERTY_SERVICE_CAPABILITIES_PARAMETER_ATTRIBUTES = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({608534132, 11935, 17657, 140, 87, 29, 27, 203, 23, 11, 137}, 1001))], [])*/PROPERTYKEY(GUID("24457E74-2E9F-44F9-8C57-1D1BCB170B89"), 1006),
    WPD_PROPERTY_SERVICE_CAPABILITIES_FORMATS              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({608534132, 11935, 17657, 140, 87, 29, 27, 203, 23, 11, 137}, 1001))], [])*/PROPERTYKEY(GUID("24457E74-2E9F-44F9-8C57-1D1BCB170B89"), 1007),
    WPD_PROPERTY_SERVICE_CAPABILITIES_FORMAT_ATTRIBUTES    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({608534132, 11935, 17657, 140, 87, 29, 27, 203, 23, 11, 137}, 1001))], [])*/PROPERTYKEY(GUID("24457E74-2E9F-44F9-8C57-1D1BCB170B89"), 1008),
    WPD_PROPERTY_SERVICE_CAPABILITIES_PROPERTY_KEYS        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({608534132, 11935, 17657, 140, 87, 29, 27, 203, 23, 11, 137}, 1001))], [])*/PROPERTYKEY(GUID("24457E74-2E9F-44F9-8C57-1D1BCB170B89"), 1009),
    WPD_PROPERTY_SERVICE_CAPABILITIES_PROPERTY_ATTRIBUTES  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({608534132, 11935, 17657, 140, 87, 29, 27, 203, 23, 11, 137}, 1001))], [])*/PROPERTYKEY(GUID("24457E74-2E9F-44F9-8C57-1D1BCB170B89"), 1010),
    WPD_PROPERTY_SERVICE_CAPABILITIES_SUPPORTED_EVENTS     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({608534132, 11935, 17657, 140, 87, 29, 27, 203, 23, 11, 137}, 1001))], [])*/PROPERTYKEY(GUID("24457E74-2E9F-44F9-8C57-1D1BCB170B89"), 1011),
    WPD_PROPERTY_SERVICE_CAPABILITIES_EVENT                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({608534132, 11935, 17657, 140, 87, 29, 27, 203, 23, 11, 137}, 1001))], [])*/PROPERTYKEY(GUID("24457E74-2E9F-44F9-8C57-1D1BCB170B89"), 1012),
    WPD_PROPERTY_SERVICE_CAPABILITIES_EVENT_ATTRIBUTES     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({608534132, 11935, 17657, 140, 87, 29, 27, 203, 23, 11, 137}, 1001))], [])*/PROPERTYKEY(GUID("24457E74-2E9F-44F9-8C57-1D1BCB170B89"), 1013),
    WPD_PROPERTY_SERVICE_CAPABILITIES_INHERITANCE_TYPE     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({608534132, 11935, 17657, 140, 87, 29, 27, 203, 23, 11, 137}, 1001))], [])*/PROPERTYKEY(GUID("24457E74-2E9F-44F9-8C57-1D1BCB170B89"), 1014),
    WPD_PROPERTY_SERVICE_CAPABILITIES_INHERITED_SERVICES   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({608534132, 11935, 17657, 140, 87, 29, 27, 203, 23, 11, 137}, 1001))], [])*/PROPERTYKEY(GUID("24457E74-2E9F-44F9-8C57-1D1BCB170B89"), 1015),
    WPD_PROPERTY_SERVICE_CAPABILITIES_RENDERING_PROFILES   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({608534132, 11935, 17657, 140, 87, 29, 27, 203, 23, 11, 137}, 1001))], [])*/PROPERTYKEY(GUID("24457E74-2E9F-44F9-8C57-1D1BCB170B89"), 1016),
    WPD_PROPERTY_SERVICE_CAPABILITIES_SUPPORTED_COMMANDS   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({608534132, 11935, 17657, 140, 87, 29, 27, 203, 23, 11, 137}, 1001))], [])*/PROPERTYKEY(GUID("24457E74-2E9F-44F9-8C57-1D1BCB170B89"), 1017),
    WPD_PROPERTY_SERVICE_CAPABILITIES_COMMAND              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({608534132, 11935, 17657, 140, 87, 29, 27, 203, 23, 11, 137}, 1001))], [])*/PROPERTYKEY(GUID("24457E74-2E9F-44F9-8C57-1D1BCB170B89"), 1018),
    WPD_PROPERTY_SERVICE_CAPABILITIES_COMMAND_OPTIONS      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({608534132, 11935, 17657, 140, 87, 29, 27, 203, 23, 11, 137}, 1001))], [])*/PROPERTYKEY(GUID("24457E74-2E9F-44F9-8C57-1D1BCB170B89"), 1019),
}

enum GUID WPD_CATEGORY_SERVICE_METHODS = GUID("2d521ca8-c1b0-4268-a342-cf19321569bc");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({760356008, 49584, 17000, 163, 66, 207, 25, 50, 21, 105, 188}, 2))], [])*/PROPERTYKEY
{
    WPD_COMMAND_SERVICE_METHODS_START_INVOKE  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({760356008, 49584, 17000, 163, 66, 207, 25, 50, 21, 105, 188}, 2))], [])*/PROPERTYKEY(GUID("2D521CA8-C1B0-4268-A342-CF19321569BC"), 2),
    WPD_COMMAND_SERVICE_METHODS_CANCEL_INVOKE = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({760356008, 49584, 17000, 163, 66, 207, 25, 50, 21, 105, 188}, 2))], [])*/PROPERTYKEY(GUID("2D521CA8-C1B0-4268-A342-CF19321569BC"), 3),
    WPD_COMMAND_SERVICE_METHODS_END_INVOKE    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({760356008, 49584, 17000, 163, 66, 207, 25, 50, 21, 105, 188}, 2))], [])*/PROPERTYKEY(GUID("2D521CA8-C1B0-4268-A342-CF19321569BC"), 4),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({760356008, 49584, 17000, 163, 66, 207, 25, 50, 21, 105, 188}, 1001))], [])*/PROPERTYKEY
{
    WPD_PROPERTY_SERVICE_METHOD                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({760356008, 49584, 17000, 163, 66, 207, 25, 50, 21, 105, 188}, 1001))], [])*/PROPERTYKEY(GUID("2D521CA8-C1B0-4268-A342-CF19321569BC"), 1001),
    WPD_PROPERTY_SERVICE_METHOD_PARAMETER_VALUES = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({760356008, 49584, 17000, 163, 66, 207, 25, 50, 21, 105, 188}, 1001))], [])*/PROPERTYKEY(GUID("2D521CA8-C1B0-4268-A342-CF19321569BC"), 1002),
    WPD_PROPERTY_SERVICE_METHOD_RESULT_VALUES    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({760356008, 49584, 17000, 163, 66, 207, 25, 50, 21, 105, 188}, 1001))], [])*/PROPERTYKEY(GUID("2D521CA8-C1B0-4268-A342-CF19321569BC"), 1003),
    WPD_PROPERTY_SERVICE_METHOD_CONTEXT          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({760356008, 49584, 17000, 163, 66, 207, 25, 50, 21, 105, 188}, 1001))], [])*/PROPERTYKEY(GUID("2D521CA8-C1B0-4268-A342-CF19321569BC"), 1004),
    WPD_PROPERTY_SERVICE_METHOD_HRESULT          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({760356008, 49584, 17000, 163, 66, 207, 25, 50, 21, 105, 188}, 1001))], [])*/PROPERTYKEY(GUID("2D521CA8-C1B0-4268-A342-CF19321569BC"), 1005),
}

enum : /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-resource-default))], [])*/PROPERTYKEY
{
    WPD_RESOURCE_DEFAULT       = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-resource-default))], [])*/PROPERTYKEY(GUID("E81E79BE-34F0-41BF-B53F-F1A06AE87842"), 0),
    WPD_RESOURCE_CONTACT_PHOTO = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-resource-default))], [])*/PROPERTYKEY(GUID("2C4D6803-80EA-4580-AF9A-5BE1A23EDDCB"), 0),
    WPD_RESOURCE_THUMBNAIL     = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-resource-default))], [])*/PROPERTYKEY(GUID("C7C407BA-98FA-46B5-9960-23FEC124CFDE"), 0),
    WPD_RESOURCE_ICON          = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-resource-default))], [])*/PROPERTYKEY(GUID("F195FED8-AA28-4EE3-B153-E182DD5EDC39"), 0),
    WPD_RESOURCE_AUDIO_CLIP    = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-resource-default))], [])*/PROPERTYKEY(GUID("3BC13982-85B1-48E0-95A6-8D3AD06BE117"), 0),
    WPD_RESOURCE_ALBUM_ART     = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-resource-default))], [])*/PROPERTYKEY(GUID("F02AA354-2300-4E2D-A1B9-3B6730F7FA21"), 0),
    WPD_RESOURCE_GENERIC       = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-resource-default))], [])*/PROPERTYKEY(GUID("B9B9F515-BA70-4647-94DC-FA4925E95A07"), 0),
    WPD_RESOURCE_VIDEO_CLIP    = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-resource-default))], [])*/PROPERTYKEY(GUID("B566EE42-6368-4290-8662-70182FB79F20"), 0),
    WPD_RESOURCE_BRANDING_ART  = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-resource-default))], [])*/PROPERTYKEY(GUID("B633B1AE-6CAF-4A87-9589-22DED6DD5899"), 0),
}

enum : GUID
{
    WPD_OBJECT_FORMAT_PROPERTIES_ONLY        = GUID("30010000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_UNSPECIFIED            = GUID("30000000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_SCRIPT                 = GUID("30020000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_EXECUTABLE             = GUID("30030000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_TEXT                   = GUID("30040000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_HTML                   = GUID("30050000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_DPOF                   = GUID("30060000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_AIFF                   = GUID("30070000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_WAVE                   = GUID("30080000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_MP3                    = GUID("30090000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_AVI                    = GUID("300a0000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_MPEG                   = GUID("300b0000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_ASF                    = GUID("300c0000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_EXIF                   = GUID("38010000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_TIFFEP                 = GUID("38020000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_FLASHPIX               = GUID("38030000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_BMP                    = GUID("38040000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_CIFF                   = GUID("38050000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_GIF                    = GUID("38070000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_JFIF                   = GUID("38080000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_PCD                    = GUID("38090000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_PICT                   = GUID("380a0000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_PNG                    = GUID("380b0000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_TIFF                   = GUID("380d0000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_TIFFIT                 = GUID("380e0000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_JP2                    = GUID("380f0000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_JPX                    = GUID("38100000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_WBMP                   = GUID("b8030000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_JPEGXR                 = GUID("b8040000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_WINDOWSIMAGEFORMAT     = GUID("b8810000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_WMA                    = GUID("b9010000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_WMV                    = GUID("b9810000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_WPLPLAYLIST            = GUID("ba100000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_M3UPLAYLIST            = GUID("ba110000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_MPLPLAYLIST            = GUID("ba120000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_ASXPLAYLIST            = GUID("ba130000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_PLSPLAYLIST            = GUID("ba140000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_ABSTRACT_CONTACT_GROUP = GUID("ba060000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_ABSTRACT_MEDIA_CAST    = GUID("ba0b0000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_VCALENDAR1             = GUID("be020000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_ICALENDAR              = GUID("be030000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_ABSTRACT_CONTACT       = GUID("bb810000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_VCARD2                 = GUID("bb820000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_VCARD3                 = GUID("bb830000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_XML                    = GUID("ba820000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_AAC                    = GUID("b9030000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_AUDIBLE                = GUID("b9040000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_FLAC                   = GUID("b9060000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_QCELP                  = GUID("b9070000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_AMR                    = GUID("b9080000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_OGG                    = GUID("b9020000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_MP4                    = GUID("b9820000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_MP2                    = GUID("b9830000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_MICROSOFT_WORD         = GUID("ba830000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_MHT_COMPILED_HTML      = GUID("ba840000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_MICROSOFT_EXCEL        = GUID("ba850000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_MICROSOFT_POWERPOINT   = GUID("ba860000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_3GP                    = GUID("b9840000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_3G2                    = GUID("b9850000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_AVCHD                  = GUID("b9860000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_ATSCTS                 = GUID("b9870000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_DVBTS                  = GUID("b9880000-ae6c-4804-98ba-c57b46965fe7"),
    WPD_OBJECT_FORMAT_MKV                    = GUID("b9900000-ae6c-4804-98ba-c57b46965fe7"),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4016785677, 23768, 17274, 175, 252, 218, 139, 96, 238, 74, 60}, 2))], [])*/PROPERTYKEY
{
    WPD_OBJECT_ID                   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4016785677, 23768, 17274, 175, 252, 218, 139, 96, 238, 74, 60}, 2))], [])*/PROPERTYKEY(GUID("EF6B490D-5CD8-437A-AFFC-DA8B60EE4A3C"), 2),
    WPD_OBJECT_PARENT_ID            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4016785677, 23768, 17274, 175, 252, 218, 139, 96, 238, 74, 60}, 2))], [])*/PROPERTYKEY(GUID("EF6B490D-5CD8-437A-AFFC-DA8B60EE4A3C"), 3),
    WPD_OBJECT_NAME                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4016785677, 23768, 17274, 175, 252, 218, 139, 96, 238, 74, 60}, 2))], [])*/PROPERTYKEY(GUID("EF6B490D-5CD8-437A-AFFC-DA8B60EE4A3C"), 4),
    WPD_OBJECT_PERSISTENT_UNIQUE_ID = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4016785677, 23768, 17274, 175, 252, 218, 139, 96, 238, 74, 60}, 2))], [])*/PROPERTYKEY(GUID("EF6B490D-5CD8-437A-AFFC-DA8B60EE4A3C"), 5),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4016785677, 23768, 17274, 175, 252, 218, 139, 96, 238, 74, 60}, 6))], [])*/PROPERTYKEY
{
    WPD_OBJECT_FORMAT             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4016785677, 23768, 17274, 175, 252, 218, 139, 96, 238, 74, 60}, 6))], [])*/PROPERTYKEY(GUID("EF6B490D-5CD8-437A-AFFC-DA8B60EE4A3C"), 6),
    WPD_OBJECT_ISHIDDEN           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4016785677, 23768, 17274, 175, 252, 218, 139, 96, 238, 74, 60}, 6))], [])*/PROPERTYKEY(GUID("EF6B490D-5CD8-437A-AFFC-DA8B60EE4A3C"), 9),
    WPD_OBJECT_ISSYSTEM           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4016785677, 23768, 17274, 175, 252, 218, 139, 96, 238, 74, 60}, 6))], [])*/PROPERTYKEY(GUID("EF6B490D-5CD8-437A-AFFC-DA8B60EE4A3C"), 10),
    WPD_OBJECT_SIZE               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4016785677, 23768, 17274, 175, 252, 218, 139, 96, 238, 74, 60}, 6))], [])*/PROPERTYKEY(GUID("EF6B490D-5CD8-437A-AFFC-DA8B60EE4A3C"), 11),
    WPD_OBJECT_ORIGINAL_FILE_NAME = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4016785677, 23768, 17274, 175, 252, 218, 139, 96, 238, 74, 60}, 6))], [])*/PROPERTYKEY(GUID("EF6B490D-5CD8-437A-AFFC-DA8B60EE4A3C"), 12),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4016785677, 23768, 17274, 175, 252, 218, 139, 96, 238, 74, 60}, 13))], [])*/PROPERTYKEY
{
    WPD_OBJECT_NON_CONSUMABLE   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4016785677, 23768, 17274, 175, 252, 218, 139, 96, 238, 74, 60}, 13))], [])*/PROPERTYKEY(GUID("EF6B490D-5CD8-437A-AFFC-DA8B60EE4A3C"), 13),
    WPD_OBJECT_KEYWORDS         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4016785677, 23768, 17274, 175, 252, 218, 139, 96, 238, 74, 60}, 13))], [])*/PROPERTYKEY(GUID("EF6B490D-5CD8-437A-AFFC-DA8B60EE4A3C"), 15),
    WPD_OBJECT_SYNC_ID          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4016785677, 23768, 17274, 175, 252, 218, 139, 96, 238, 74, 60}, 13))], [])*/PROPERTYKEY(GUID("EF6B490D-5CD8-437A-AFFC-DA8B60EE4A3C"), 16),
    WPD_OBJECT_IS_DRM_PROTECTED = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4016785677, 23768, 17274, 175, 252, 218, 139, 96, 238, 74, 60}, 13))], [])*/PROPERTYKEY(GUID("EF6B490D-5CD8-437A-AFFC-DA8B60EE4A3C"), 17),
    WPD_OBJECT_DATE_CREATED     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4016785677, 23768, 17274, 175, 252, 218, 139, 96, 238, 74, 60}, 13))], [])*/PROPERTYKEY(GUID("EF6B490D-5CD8-437A-AFFC-DA8B60EE4A3C"), 18),
    WPD_OBJECT_DATE_MODIFIED    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4016785677, 23768, 17274, 175, 252, 218, 139, 96, 238, 74, 60}, 13))], [])*/PROPERTYKEY(GUID("EF6B490D-5CD8-437A-AFFC-DA8B60EE4A3C"), 19),
    WPD_OBJECT_DATE_AUTHORED    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4016785677, 23768, 17274, 175, 252, 218, 139, 96, 238, 74, 60}, 13))], [])*/PROPERTYKEY(GUID("EF6B490D-5CD8-437A-AFFC-DA8B60EE4A3C"), 20),
    WPD_OBJECT_BACK_REFERENCES  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4016785677, 23768, 17274, 175, 252, 218, 139, 96, 238, 74, 60}, 13))], [])*/PROPERTYKEY(GUID("EF6B490D-5CD8-437A-AFFC-DA8B60EE4A3C"), 21),
    WPD_OBJECT_CAN_DELETE       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4016785677, 23768, 17274, 175, 252, 218, 139, 96, 238, 74, 60}, 13))], [])*/PROPERTYKEY(GUID("EF6B490D-5CD8-437A-AFFC-DA8B60EE4A3C"), 26),
    WPD_OBJECT_LANGUAGE_LOCALE  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4016785677, 23768, 17274, 175, 252, 218, 139, 96, 238, 74, 60}, 13))], [])*/PROPERTYKEY(GUID("EF6B490D-5CD8-437A-AFFC-DA8B60EE4A3C"), 27),
}

enum GUID WPD_FOLDER_OBJECT_PROPERTIES_V1 = GUID("7e9a7abf-e568-4b34-aa2f-13bb12ab177d");
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2124053183, 58728, 19252, 170, 47, 19, 187, 18, 171, 23, 125}, 2))], [])*/PROPERTYKEY WPD_FOLDER_CONTENT_TYPES_ALLOWED = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2124053183, 58728, 19252, 170, 47, 19, 187, 18, 171, 23, 125}, 2))], [])*/PROPERTYKEY(GUID("7E9A7ABF-E568-4B34-AA2F-13BB12AB177D"), 2);
enum GUID WPD_IMAGE_OBJECT_PROPERTIES_V1 = GUID("63d64908-9fa1-479f-85ba-9952216447db");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1674987784, 40865, 18335, 133, 186, 153, 82, 33, 100, 71, 219}, 3))], [])*/PROPERTYKEY
{
    WPD_IMAGE_BITDEPTH               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1674987784, 40865, 18335, 133, 186, 153, 82, 33, 100, 71, 219}, 3))], [])*/PROPERTYKEY(GUID("63D64908-9FA1-479F-85BA-9952216447DB"), 3),
    WPD_IMAGE_CROPPED_STATUS         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1674987784, 40865, 18335, 133, 186, 153, 82, 33, 100, 71, 219}, 3))], [])*/PROPERTYKEY(GUID("63D64908-9FA1-479F-85BA-9952216447DB"), 4),
    WPD_IMAGE_COLOR_CORRECTED_STATUS = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1674987784, 40865, 18335, 133, 186, 153, 82, 33, 100, 71, 219}, 3))], [])*/PROPERTYKEY(GUID("63D64908-9FA1-479F-85BA-9952216447DB"), 5),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1674987784, 40865, 18335, 133, 186, 153, 82, 33, 100, 71, 219}, 6))], [])*/PROPERTYKEY
{
    WPD_IMAGE_FNUMBER               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1674987784, 40865, 18335, 133, 186, 153, 82, 33, 100, 71, 219}, 6))], [])*/PROPERTYKEY(GUID("63D64908-9FA1-479F-85BA-9952216447DB"), 6),
    WPD_IMAGE_EXPOSURE_TIME         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1674987784, 40865, 18335, 133, 186, 153, 82, 33, 100, 71, 219}, 6))], [])*/PROPERTYKEY(GUID("63D64908-9FA1-479F-85BA-9952216447DB"), 7),
    WPD_IMAGE_EXPOSURE_INDEX        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1674987784, 40865, 18335, 133, 186, 153, 82, 33, 100, 71, 219}, 6))], [])*/PROPERTYKEY(GUID("63D64908-9FA1-479F-85BA-9952216447DB"), 8),
    WPD_IMAGE_HORIZONTAL_RESOLUTION = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1674987784, 40865, 18335, 133, 186, 153, 82, 33, 100, 71, 219}, 6))], [])*/PROPERTYKEY(GUID("63D64908-9FA1-479F-85BA-9952216447DB"), 9),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1674987784, 40865, 18335, 133, 186, 153, 82, 33, 100, 71, 219}, 10))], [])*/PROPERTYKEY WPD_IMAGE_VERTICAL_RESOLUTION = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1674987784, 40865, 18335, 133, 186, 153, 82, 33, 100, 71, 219}, 10))], [])*/PROPERTYKEY(GUID("63D64908-9FA1-479F-85BA-9952216447DB"), 10);
enum GUID WPD_DOCUMENT_OBJECT_PROPERTIES_V1 = GUID("0b110203-eb95-4f02-93e0-97c631493ad5");
enum GUID WPD_MEDIA_PROPERTIES_V1 = GUID("2ed8ba05-0ad3-42dc-b0d0-bc95ac396ac8");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({785955333, 2771, 17116, 176, 208, 188, 149, 172, 57, 106, 200}, 2))], [])*/PROPERTYKEY
{
    WPD_MEDIA_TOTAL_BITRATE           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({785955333, 2771, 17116, 176, 208, 188, 149, 172, 57, 106, 200}, 2))], [])*/PROPERTYKEY(GUID("2ED8BA05-0AD3-42DC-B0D0-BC95AC396AC8"), 2),
    WPD_MEDIA_BITRATE_TYPE            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({785955333, 2771, 17116, 176, 208, 188, 149, 172, 57, 106, 200}, 2))], [])*/PROPERTYKEY(GUID("2ED8BA05-0AD3-42DC-B0D0-BC95AC396AC8"), 3),
    WPD_MEDIA_COPYRIGHT               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({785955333, 2771, 17116, 176, 208, 188, 149, 172, 57, 106, 200}, 2))], [])*/PROPERTYKEY(GUID("2ED8BA05-0AD3-42DC-B0D0-BC95AC396AC8"), 4),
    WPD_MEDIA_SUBSCRIPTION_CONTENT_ID = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({785955333, 2771, 17116, 176, 208, 188, 149, 172, 57, 106, 200}, 2))], [])*/PROPERTYKEY(GUID("2ED8BA05-0AD3-42DC-B0D0-BC95AC396AC8"), 5),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({785955333, 2771, 17116, 176, 208, 188, 149, 172, 57, 106, 200}, 6))], [])*/PROPERTYKEY
{
    WPD_MEDIA_USE_COUNT          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({785955333, 2771, 17116, 176, 208, 188, 149, 172, 57, 106, 200}, 6))], [])*/PROPERTYKEY(GUID("2ED8BA05-0AD3-42DC-B0D0-BC95AC396AC8"), 6),
    WPD_MEDIA_SKIP_COUNT         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({785955333, 2771, 17116, 176, 208, 188, 149, 172, 57, 106, 200}, 6))], [])*/PROPERTYKEY(GUID("2ED8BA05-0AD3-42DC-B0D0-BC95AC396AC8"), 7),
    WPD_MEDIA_LAST_ACCESSED_TIME = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({785955333, 2771, 17116, 176, 208, 188, 149, 172, 57, 106, 200}, 6))], [])*/PROPERTYKEY(GUID("2ED8BA05-0AD3-42DC-B0D0-BC95AC396AC8"), 8),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({785955333, 2771, 17116, 176, 208, 188, 149, 172, 57, 106, 200}, 9))], [])*/PROPERTYKEY WPD_MEDIA_PARENTAL_RATING = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({785955333, 2771, 17116, 176, 208, 188, 149, 172, 57, 106, 200}, 9))], [])*/PROPERTYKEY(GUID("2ED8BA05-0AD3-42DC-B0D0-BC95AC396AC8"), 9);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({785955333, 2771, 17116, 176, 208, 188, 149, 172, 57, 106, 200}, 10))], [])*/PROPERTYKEY
{
    WPD_MEDIA_META_GENRE       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({785955333, 2771, 17116, 176, 208, 188, 149, 172, 57, 106, 200}, 10))], [])*/PROPERTYKEY(GUID("2ED8BA05-0AD3-42DC-B0D0-BC95AC396AC8"), 10),
    WPD_MEDIA_COMPOSER         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({785955333, 2771, 17116, 176, 208, 188, 149, 172, 57, 106, 200}, 10))], [])*/PROPERTYKEY(GUID("2ED8BA05-0AD3-42DC-B0D0-BC95AC396AC8"), 11),
    WPD_MEDIA_EFFECTIVE_RATING = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({785955333, 2771, 17116, 176, 208, 188, 149, 172, 57, 106, 200}, 10))], [])*/PROPERTYKEY(GUID("2ED8BA05-0AD3-42DC-B0D0-BC95AC396AC8"), 12),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({785955333, 2771, 17116, 176, 208, 188, 149, 172, 57, 106, 200}, 13))], [])*/PROPERTYKEY
{
    WPD_MEDIA_SUB_TITLE             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({785955333, 2771, 17116, 176, 208, 188, 149, 172, 57, 106, 200}, 13))], [])*/PROPERTYKEY(GUID("2ED8BA05-0AD3-42DC-B0D0-BC95AC396AC8"), 13),
    WPD_MEDIA_RELEASE_DATE          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({785955333, 2771, 17116, 176, 208, 188, 149, 172, 57, 106, 200}, 13))], [])*/PROPERTYKEY(GUID("2ED8BA05-0AD3-42DC-B0D0-BC95AC396AC8"), 14),
    WPD_MEDIA_SAMPLE_RATE           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({785955333, 2771, 17116, 176, 208, 188, 149, 172, 57, 106, 200}, 13))], [])*/PROPERTYKEY(GUID("2ED8BA05-0AD3-42DC-B0D0-BC95AC396AC8"), 15),
    WPD_MEDIA_STAR_RATING           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({785955333, 2771, 17116, 176, 208, 188, 149, 172, 57, 106, 200}, 13))], [])*/PROPERTYKEY(GUID("2ED8BA05-0AD3-42DC-B0D0-BC95AC396AC8"), 16),
    WPD_MEDIA_USER_EFFECTIVE_RATING = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({785955333, 2771, 17116, 176, 208, 188, 149, 172, 57, 106, 200}, 13))], [])*/PROPERTYKEY(GUID("2ED8BA05-0AD3-42DC-B0D0-BC95AC396AC8"), 17),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({785955333, 2771, 17116, 176, 208, 188, 149, 172, 57, 106, 200}, 18))], [])*/PROPERTYKEY
{
    WPD_MEDIA_TITLE            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({785955333, 2771, 17116, 176, 208, 188, 149, 172, 57, 106, 200}, 18))], [])*/PROPERTYKEY(GUID("2ED8BA05-0AD3-42DC-B0D0-BC95AC396AC8"), 18),
    WPD_MEDIA_DURATION         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({785955333, 2771, 17116, 176, 208, 188, 149, 172, 57, 106, 200}, 18))], [])*/PROPERTYKEY(GUID("2ED8BA05-0AD3-42DC-B0D0-BC95AC396AC8"), 19),
    WPD_MEDIA_BUY_NOW          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({785955333, 2771, 17116, 176, 208, 188, 149, 172, 57, 106, 200}, 18))], [])*/PROPERTYKEY(GUID("2ED8BA05-0AD3-42DC-B0D0-BC95AC396AC8"), 20),
    WPD_MEDIA_ENCODING_PROFILE = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({785955333, 2771, 17116, 176, 208, 188, 149, 172, 57, 106, 200}, 18))], [])*/PROPERTYKEY(GUID("2ED8BA05-0AD3-42DC-B0D0-BC95AC396AC8"), 21),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({785955333, 2771, 17116, 176, 208, 188, 149, 172, 57, 106, 200}, 22))], [])*/PROPERTYKEY
{
    WPD_MEDIA_WIDTH           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({785955333, 2771, 17116, 176, 208, 188, 149, 172, 57, 106, 200}, 22))], [])*/PROPERTYKEY(GUID("2ED8BA05-0AD3-42DC-B0D0-BC95AC396AC8"), 22),
    WPD_MEDIA_HEIGHT          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({785955333, 2771, 17116, 176, 208, 188, 149, 172, 57, 106, 200}, 22))], [])*/PROPERTYKEY(GUID("2ED8BA05-0AD3-42DC-B0D0-BC95AC396AC8"), 23),
    WPD_MEDIA_ARTIST          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({785955333, 2771, 17116, 176, 208, 188, 149, 172, 57, 106, 200}, 22))], [])*/PROPERTYKEY(GUID("2ED8BA05-0AD3-42DC-B0D0-BC95AC396AC8"), 24),
    WPD_MEDIA_ALBUM_ARTIST    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({785955333, 2771, 17116, 176, 208, 188, 149, 172, 57, 106, 200}, 22))], [])*/PROPERTYKEY(GUID("2ED8BA05-0AD3-42DC-B0D0-BC95AC396AC8"), 25),
    WPD_MEDIA_OWNER           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({785955333, 2771, 17116, 176, 208, 188, 149, 172, 57, 106, 200}, 22))], [])*/PROPERTYKEY(GUID("2ED8BA05-0AD3-42DC-B0D0-BC95AC396AC8"), 26),
    WPD_MEDIA_MANAGING_EDITOR = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({785955333, 2771, 17116, 176, 208, 188, 149, 172, 57, 106, 200}, 22))], [])*/PROPERTYKEY(GUID("2ED8BA05-0AD3-42DC-B0D0-BC95AC396AC8"), 27),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({785955333, 2771, 17116, 176, 208, 188, 149, 172, 57, 106, 200}, 28))], [])*/PROPERTYKEY
{
    WPD_MEDIA_WEBMASTER       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({785955333, 2771, 17116, 176, 208, 188, 149, 172, 57, 106, 200}, 28))], [])*/PROPERTYKEY(GUID("2ED8BA05-0AD3-42DC-B0D0-BC95AC396AC8"), 28),
    WPD_MEDIA_SOURCE_URL      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({785955333, 2771, 17116, 176, 208, 188, 149, 172, 57, 106, 200}, 28))], [])*/PROPERTYKEY(GUID("2ED8BA05-0AD3-42DC-B0D0-BC95AC396AC8"), 29),
    WPD_MEDIA_DESTINATION_URL = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({785955333, 2771, 17116, 176, 208, 188, 149, 172, 57, 106, 200}, 28))], [])*/PROPERTYKEY(GUID("2ED8BA05-0AD3-42DC-B0D0-BC95AC396AC8"), 30),
    WPD_MEDIA_DESCRIPTION     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({785955333, 2771, 17116, 176, 208, 188, 149, 172, 57, 106, 200}, 28))], [])*/PROPERTYKEY(GUID("2ED8BA05-0AD3-42DC-B0D0-BC95AC396AC8"), 31),
    WPD_MEDIA_GENRE           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({785955333, 2771, 17116, 176, 208, 188, 149, 172, 57, 106, 200}, 28))], [])*/PROPERTYKEY(GUID("2ED8BA05-0AD3-42DC-B0D0-BC95AC396AC8"), 32),
    WPD_MEDIA_TIME_BOOKMARK   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({785955333, 2771, 17116, 176, 208, 188, 149, 172, 57, 106, 200}, 28))], [])*/PROPERTYKEY(GUID("2ED8BA05-0AD3-42DC-B0D0-BC95AC396AC8"), 33),
    WPD_MEDIA_OBJECT_BOOKMARK = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({785955333, 2771, 17116, 176, 208, 188, 149, 172, 57, 106, 200}, 28))], [])*/PROPERTYKEY(GUID("2ED8BA05-0AD3-42DC-B0D0-BC95AC396AC8"), 34),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({785955333, 2771, 17116, 176, 208, 188, 149, 172, 57, 106, 200}, 35))], [])*/PROPERTYKEY WPD_MEDIA_LAST_BUILD_DATE = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({785955333, 2771, 17116, 176, 208, 188, 149, 172, 57, 106, 200}, 35))], [])*/PROPERTYKEY(GUID("2ED8BA05-0AD3-42DC-B0D0-BC95AC396AC8"), 35);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({785955333, 2771, 17116, 176, 208, 188, 149, 172, 57, 106, 200}, 36))], [])*/PROPERTYKEY
{
    WPD_MEDIA_BYTE_BOOKMARK   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({785955333, 2771, 17116, 176, 208, 188, 149, 172, 57, 106, 200}, 36))], [])*/PROPERTYKEY(GUID("2ED8BA05-0AD3-42DC-B0D0-BC95AC396AC8"), 36),
    WPD_MEDIA_TIME_TO_LIVE    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({785955333, 2771, 17116, 176, 208, 188, 149, 172, 57, 106, 200}, 36))], [])*/PROPERTYKEY(GUID("2ED8BA05-0AD3-42DC-B0D0-BC95AC396AC8"), 37),
    WPD_MEDIA_GUID            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({785955333, 2771, 17116, 176, 208, 188, 149, 172, 57, 106, 200}, 36))], [])*/PROPERTYKEY(GUID("2ED8BA05-0AD3-42DC-B0D0-BC95AC396AC8"), 38),
    WPD_MEDIA_SUB_DESCRIPTION = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({785955333, 2771, 17116, 176, 208, 188, 149, 172, 57, 106, 200}, 36))], [])*/PROPERTYKEY(GUID("2ED8BA05-0AD3-42DC-B0D0-BC95AC396AC8"), 39),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({785955333, 2771, 17116, 176, 208, 188, 149, 172, 57, 106, 200}, 49))], [])*/PROPERTYKEY WPD_MEDIA_AUDIO_ENCODING_PROFILE = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({785955333, 2771, 17116, 176, 208, 188, 149, 172, 57, 106, 200}, 49))], [])*/PROPERTYKEY(GUID("2ED8BA05-0AD3-42DC-B0D0-BC95AC396AC8"), 49);
enum GUID WPD_CONTACT_OBJECT_PROPERTIES_V1 = GUID("fbd4fdab-987d-4777-b3f9-726185a9312b");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 2))], [])*/PROPERTYKEY
{
    WPD_CONTACT_DISPLAY_NAME                        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 2))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 2),
    WPD_CONTACT_FIRST_NAME                          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 2))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 3),
    WPD_CONTACT_MIDDLE_NAMES                        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 2))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 4),
    WPD_CONTACT_LAST_NAME                           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 2))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 5),
    WPD_CONTACT_PREFIX                              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 2))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 6),
    WPD_CONTACT_SUFFIX                              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 2))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 7),
    WPD_CONTACT_PHONETIC_FIRST_NAME                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 2))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 8),
    WPD_CONTACT_PHONETIC_LAST_NAME                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 2))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 9),
    WPD_CONTACT_PERSONAL_FULL_POSTAL_ADDRESS        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 2))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 10),
    WPD_CONTACT_PERSONAL_POSTAL_ADDRESS_LINE1       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 2))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 11),
    WPD_CONTACT_PERSONAL_POSTAL_ADDRESS_LINE2       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 2))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 12),
    WPD_CONTACT_PERSONAL_POSTAL_ADDRESS_CITY        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 2))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 13),
    WPD_CONTACT_PERSONAL_POSTAL_ADDRESS_REGION      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 2))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 14),
    WPD_CONTACT_PERSONAL_POSTAL_ADDRESS_POSTAL_CODE = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 2))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 15),
    WPD_CONTACT_PERSONAL_POSTAL_ADDRESS_COUNTRY     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 2))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 16),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 17))], [])*/PROPERTYKEY
{
    WPD_CONTACT_BUSINESS_FULL_POSTAL_ADDRESS        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 17))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 17),
    WPD_CONTACT_BUSINESS_POSTAL_ADDRESS_LINE1       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 17))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 18),
    WPD_CONTACT_BUSINESS_POSTAL_ADDRESS_LINE2       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 17))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 19),
    WPD_CONTACT_BUSINESS_POSTAL_ADDRESS_CITY        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 17))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 20),
    WPD_CONTACT_BUSINESS_POSTAL_ADDRESS_REGION      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 17))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 21),
    WPD_CONTACT_BUSINESS_POSTAL_ADDRESS_POSTAL_CODE = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 17))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 22),
    WPD_CONTACT_BUSINESS_POSTAL_ADDRESS_COUNTRY     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 17))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 23),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 24))], [])*/PROPERTYKEY
{
    WPD_CONTACT_OTHER_FULL_POSTAL_ADDRESS           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 24))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 24),
    WPD_CONTACT_OTHER_POSTAL_ADDRESS_LINE1          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 24))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 25),
    WPD_CONTACT_OTHER_POSTAL_ADDRESS_LINE2          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 24))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 26),
    WPD_CONTACT_OTHER_POSTAL_ADDRESS_CITY           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 24))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 27),
    WPD_CONTACT_OTHER_POSTAL_ADDRESS_REGION         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 24))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 28),
    WPD_CONTACT_OTHER_POSTAL_ADDRESS_POSTAL_CODE    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 24))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 29),
    WPD_CONTACT_OTHER_POSTAL_ADDRESS_POSTAL_COUNTRY = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 24))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 30),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 31))], [])*/PROPERTYKEY WPD_CONTACT_PRIMARY_EMAIL_ADDRESS = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 31))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 31);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 32))], [])*/PROPERTYKEY
{
    WPD_CONTACT_PERSONAL_EMAIL       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 32))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 32),
    WPD_CONTACT_PERSONAL_EMAIL2      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 32))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 33),
    WPD_CONTACT_BUSINESS_EMAIL       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 32))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 34),
    WPD_CONTACT_BUSINESS_EMAIL2      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 32))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 35),
    WPD_CONTACT_OTHER_EMAILS         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 32))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 36),
    WPD_CONTACT_PRIMARY_PHONE        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 32))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 37),
    WPD_CONTACT_PERSONAL_PHONE       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 32))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 38),
    WPD_CONTACT_PERSONAL_PHONE2      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 32))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 39),
    WPD_CONTACT_BUSINESS_PHONE       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 32))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 40),
    WPD_CONTACT_BUSINESS_PHONE2      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 32))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 41),
    WPD_CONTACT_MOBILE_PHONE         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 32))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 42),
    WPD_CONTACT_MOBILE_PHONE2        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 32))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 43),
    WPD_CONTACT_PERSONAL_FAX         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 32))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 44),
    WPD_CONTACT_BUSINESS_FAX         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 32))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 45),
    WPD_CONTACT_PAGER                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 32))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 46),
    WPD_CONTACT_OTHER_PHONES         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 32))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 47),
    WPD_CONTACT_PRIMARY_WEB_ADDRESS  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 32))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 48),
    WPD_CONTACT_PERSONAL_WEB_ADDRESS = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 32))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 49),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 50))], [])*/PROPERTYKEY WPD_CONTACT_BUSINESS_WEB_ADDRESS = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 50))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 50);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 51))], [])*/PROPERTYKEY
{
    WPD_CONTACT_INSTANT_MESSENGER  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 51))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 51),
    WPD_CONTACT_INSTANT_MESSENGER2 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 51))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 52),
    WPD_CONTACT_INSTANT_MESSENGER3 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 51))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 53),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 54))], [])*/PROPERTYKEY
{
    WPD_CONTACT_COMPANY_NAME          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 54))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 54),
    WPD_CONTACT_PHONETIC_COMPANY_NAME = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 54))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 55),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 56))], [])*/PROPERTYKEY
{
    WPD_CONTACT_ROLE             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 56))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 56),
    WPD_CONTACT_BIRTHDATE        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 56))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 57),
    WPD_CONTACT_PRIMARY_FAX      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 56))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 58),
    WPD_CONTACT_SPOUSE           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 56))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 59),
    WPD_CONTACT_CHILDREN         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 56))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 60),
    WPD_CONTACT_ASSISTANT        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 56))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 61),
    WPD_CONTACT_ANNIVERSARY_DATE = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 56))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 62),
    WPD_CONTACT_RINGTONE         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4225039787, 39037, 18295, 179, 249, 114, 97, 133, 169, 49, 43}, 56))], [])*/PROPERTYKEY(GUID("FBD4FDAB-987D-4777-B3F9-726185A9312B"), 63),
}

enum GUID WPD_MUSIC_OBJECT_PROPERTIES_V1 = GUID("b324f56a-dc5d-46e5-b6df-d2ea414888c6");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3005543786, 56413, 18149, 182, 223, 210, 234, 65, 72, 136, 198}, 3))], [])*/PROPERTYKEY
{
    WPD_MUSIC_ALBUM  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3005543786, 56413, 18149, 182, 223, 210, 234, 65, 72, 136, 198}, 3))], [])*/PROPERTYKEY(GUID("B324F56A-DC5D-46E5-B6DF-D2EA414888C6"), 3),
    WPD_MUSIC_TRACK  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3005543786, 56413, 18149, 182, 223, 210, 234, 65, 72, 136, 198}, 3))], [])*/PROPERTYKEY(GUID("B324F56A-DC5D-46E5-B6DF-D2EA414888C6"), 4),
    WPD_MUSIC_LYRICS = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3005543786, 56413, 18149, 182, 223, 210, 234, 65, 72, 136, 198}, 3))], [])*/PROPERTYKEY(GUID("B324F56A-DC5D-46E5-B6DF-D2EA414888C6"), 6),
    WPD_MUSIC_MOOD   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3005543786, 56413, 18149, 182, 223, 210, 234, 65, 72, 136, 198}, 3))], [])*/PROPERTYKEY(GUID("B324F56A-DC5D-46E5-B6DF-D2EA414888C6"), 8),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3005543786, 56413, 18149, 182, 223, 210, 234, 65, 72, 136, 198}, 9))], [])*/PROPERTYKEY
{
    WPD_AUDIO_BITRATE         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3005543786, 56413, 18149, 182, 223, 210, 234, 65, 72, 136, 198}, 9))], [])*/PROPERTYKEY(GUID("B324F56A-DC5D-46E5-B6DF-D2EA414888C6"), 9),
    WPD_AUDIO_CHANNEL_COUNT   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3005543786, 56413, 18149, 182, 223, 210, 234, 65, 72, 136, 198}, 9))], [])*/PROPERTYKEY(GUID("B324F56A-DC5D-46E5-B6DF-D2EA414888C6"), 10),
    WPD_AUDIO_FORMAT_CODE     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3005543786, 56413, 18149, 182, 223, 210, 234, 65, 72, 136, 198}, 9))], [])*/PROPERTYKEY(GUID("B324F56A-DC5D-46E5-B6DF-D2EA414888C6"), 11),
    WPD_AUDIO_BIT_DEPTH       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3005543786, 56413, 18149, 182, 223, 210, 234, 65, 72, 136, 198}, 9))], [])*/PROPERTYKEY(GUID("B324F56A-DC5D-46E5-B6DF-D2EA414888C6"), 12),
    WPD_AUDIO_BLOCK_ALIGNMENT = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3005543786, 56413, 18149, 182, 223, 210, 234, 65, 72, 136, 198}, 9))], [])*/PROPERTYKEY(GUID("B324F56A-DC5D-46E5-B6DF-D2EA414888C6"), 13),
}

enum GUID WPD_VIDEO_OBJECT_PROPERTIES_V1 = GUID("346f2163-f998-4146-8b01-d19b4c00de9a");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({879698275, 63896, 16710, 139, 1, 209, 155, 76, 0, 222, 154}, 2))], [])*/PROPERTYKEY
{
    WPD_VIDEO_AUTHOR                    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({879698275, 63896, 16710, 139, 1, 209, 155, 76, 0, 222, 154}, 2))], [])*/PROPERTYKEY(GUID("346F2163-F998-4146-8B01-D19B4C00DE9A"), 2),
    WPD_VIDEO_RECORDEDTV_STATION_NAME   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({879698275, 63896, 16710, 139, 1, 209, 155, 76, 0, 222, 154}, 2))], [])*/PROPERTYKEY(GUID("346F2163-F998-4146-8B01-D19B4C00DE9A"), 4),
    WPD_VIDEO_RECORDEDTV_CHANNEL_NUMBER = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({879698275, 63896, 16710, 139, 1, 209, 155, 76, 0, 222, 154}, 2))], [])*/PROPERTYKEY(GUID("346F2163-F998-4146-8B01-D19B4C00DE9A"), 5),
    WPD_VIDEO_RECORDEDTV_REPEAT         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({879698275, 63896, 16710, 139, 1, 209, 155, 76, 0, 222, 154}, 2))], [])*/PROPERTYKEY(GUID("346F2163-F998-4146-8B01-D19B4C00DE9A"), 7),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({879698275, 63896, 16710, 139, 1, 209, 155, 76, 0, 222, 154}, 8))], [])*/PROPERTYKEY
{
    WPD_VIDEO_BUFFER_SIZE        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({879698275, 63896, 16710, 139, 1, 209, 155, 76, 0, 222, 154}, 8))], [])*/PROPERTYKEY(GUID("346F2163-F998-4146-8B01-D19B4C00DE9A"), 8),
    WPD_VIDEO_CREDITS            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({879698275, 63896, 16710, 139, 1, 209, 155, 76, 0, 222, 154}, 8))], [])*/PROPERTYKEY(GUID("346F2163-F998-4146-8B01-D19B4C00DE9A"), 9),
    WPD_VIDEO_KEY_FRAME_DISTANCE = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({879698275, 63896, 16710, 139, 1, 209, 155, 76, 0, 222, 154}, 8))], [])*/PROPERTYKEY(GUID("346F2163-F998-4146-8B01-D19B4C00DE9A"), 10),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({879698275, 63896, 16710, 139, 1, 209, 155, 76, 0, 222, 154}, 11))], [])*/PROPERTYKEY WPD_VIDEO_QUALITY_SETTING = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({879698275, 63896, 16710, 139, 1, 209, 155, 76, 0, 222, 154}, 11))], [])*/PROPERTYKEY(GUID("346F2163-F998-4146-8B01-D19B4C00DE9A"), 11);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({879698275, 63896, 16710, 139, 1, 209, 155, 76, 0, 222, 154}, 12))], [])*/PROPERTYKEY
{
    WPD_VIDEO_SCAN_TYPE   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({879698275, 63896, 16710, 139, 1, 209, 155, 76, 0, 222, 154}, 12))], [])*/PROPERTYKEY(GUID("346F2163-F998-4146-8B01-D19B4C00DE9A"), 12),
    WPD_VIDEO_BITRATE     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({879698275, 63896, 16710, 139, 1, 209, 155, 76, 0, 222, 154}, 12))], [])*/PROPERTYKEY(GUID("346F2163-F998-4146-8B01-D19B4C00DE9A"), 13),
    WPD_VIDEO_FOURCC_CODE = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({879698275, 63896, 16710, 139, 1, 209, 155, 76, 0, 222, 154}, 12))], [])*/PROPERTYKEY(GUID("346F2163-F998-4146-8B01-D19B4C00DE9A"), 14),
    WPD_VIDEO_FRAMERATE   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({879698275, 63896, 16710, 139, 1, 209, 155, 76, 0, 222, 154}, 12))], [])*/PROPERTYKEY(GUID("346F2163-F998-4146-8B01-D19B4C00DE9A"), 15),
}

enum GUID WPD_COMMON_INFORMATION_OBJECT_PROPERTIES_V1 = GUID("b28ae94b-05a4-4e8e-be01-72cc7e099d8f");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2995448139, 1444, 20110, 190, 1, 114, 204, 126, 9, 157, 143}, 2))], [])*/PROPERTYKEY
{
    WPD_COMMON_INFORMATION_SUBJECT        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2995448139, 1444, 20110, 190, 1, 114, 204, 126, 9, 157, 143}, 2))], [])*/PROPERTYKEY(GUID("B28AE94B-05A4-4E8E-BE01-72CC7E099D8F"), 2),
    WPD_COMMON_INFORMATION_BODY_TEXT      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2995448139, 1444, 20110, 190, 1, 114, 204, 126, 9, 157, 143}, 2))], [])*/PROPERTYKEY(GUID("B28AE94B-05A4-4E8E-BE01-72CC7E099D8F"), 3),
    WPD_COMMON_INFORMATION_PRIORITY       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2995448139, 1444, 20110, 190, 1, 114, 204, 126, 9, 157, 143}, 2))], [])*/PROPERTYKEY(GUID("B28AE94B-05A4-4E8E-BE01-72CC7E099D8F"), 4),
    WPD_COMMON_INFORMATION_START_DATETIME = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2995448139, 1444, 20110, 190, 1, 114, 204, 126, 9, 157, 143}, 2))], [])*/PROPERTYKEY(GUID("B28AE94B-05A4-4E8E-BE01-72CC7E099D8F"), 5),
    WPD_COMMON_INFORMATION_END_DATETIME   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2995448139, 1444, 20110, 190, 1, 114, 204, 126, 9, 157, 143}, 2))], [])*/PROPERTYKEY(GUID("B28AE94B-05A4-4E8E-BE01-72CC7E099D8F"), 6),
    WPD_COMMON_INFORMATION_NOTES          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2995448139, 1444, 20110, 190, 1, 114, 204, 126, 9, 157, 143}, 2))], [])*/PROPERTYKEY(GUID("B28AE94B-05A4-4E8E-BE01-72CC7E099D8F"), 7),
}

enum GUID WPD_MEMO_OBJECT_PROPERTIES_V1 = GUID("5ffbfc7b-7483-41ad-afb9-da3f4e592b8d");
enum GUID WPD_EMAIL_OBJECT_PROPERTIES_V1 = GUID("41f8f65a-5484-4782-b13d-4740dd7c37c5");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1106835034, 21636, 18306, 177, 61, 71, 64, 221, 124, 55, 197}, 2))], [])*/PROPERTYKEY
{
    WPD_EMAIL_TO_LINE         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1106835034, 21636, 18306, 177, 61, 71, 64, 221, 124, 55, 197}, 2))], [])*/PROPERTYKEY(GUID("41F8F65A-5484-4782-B13D-4740DD7C37C5"), 2),
    WPD_EMAIL_CC_LINE         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1106835034, 21636, 18306, 177, 61, 71, 64, 221, 124, 55, 197}, 2))], [])*/PROPERTYKEY(GUID("41F8F65A-5484-4782-B13D-4740DD7C37C5"), 3),
    WPD_EMAIL_BCC_LINE        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1106835034, 21636, 18306, 177, 61, 71, 64, 221, 124, 55, 197}, 2))], [])*/PROPERTYKEY(GUID("41F8F65A-5484-4782-B13D-4740DD7C37C5"), 4),
    WPD_EMAIL_HAS_BEEN_READ   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1106835034, 21636, 18306, 177, 61, 71, 64, 221, 124, 55, 197}, 2))], [])*/PROPERTYKEY(GUID("41F8F65A-5484-4782-B13D-4740DD7C37C5"), 7),
    WPD_EMAIL_RECEIVED_TIME   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1106835034, 21636, 18306, 177, 61, 71, 64, 221, 124, 55, 197}, 2))], [])*/PROPERTYKEY(GUID("41F8F65A-5484-4782-B13D-4740DD7C37C5"), 8),
    WPD_EMAIL_HAS_ATTACHMENTS = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1106835034, 21636, 18306, 177, 61, 71, 64, 221, 124, 55, 197}, 2))], [])*/PROPERTYKEY(GUID("41F8F65A-5484-4782-B13D-4740DD7C37C5"), 9),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1106835034, 21636, 18306, 177, 61, 71, 64, 221, 124, 55, 197}, 10))], [])*/PROPERTYKEY WPD_EMAIL_SENDER_ADDRESS = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1106835034, 21636, 18306, 177, 61, 71, 64, 221, 124, 55, 197}, 10))], [])*/PROPERTYKEY(GUID("41F8F65A-5484-4782-B13D-4740DD7C37C5"), 10);
enum GUID WPD_APPOINTMENT_OBJECT_PROPERTIES_V1 = GUID("f99efd03-431d-40d8-a1c9-4e220d9c88d3");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4187946243, 17181, 16600, 161, 201, 78, 34, 13, 156, 136, 211}, 3))], [])*/PROPERTYKEY
{
    WPD_APPOINTMENT_LOCATION            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4187946243, 17181, 16600, 161, 201, 78, 34, 13, 156, 136, 211}, 3))], [])*/PROPERTYKEY(GUID("F99EFD03-431D-40D8-A1C9-4E220D9C88D3"), 3),
    WPD_APPOINTMENT_TYPE                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4187946243, 17181, 16600, 161, 201, 78, 34, 13, 156, 136, 211}, 3))], [])*/PROPERTYKEY(GUID("F99EFD03-431D-40D8-A1C9-4E220D9C88D3"), 7),
    WPD_APPOINTMENT_REQUIRED_ATTENDEES  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4187946243, 17181, 16600, 161, 201, 78, 34, 13, 156, 136, 211}, 3))], [])*/PROPERTYKEY(GUID("F99EFD03-431D-40D8-A1C9-4E220D9C88D3"), 8),
    WPD_APPOINTMENT_OPTIONAL_ATTENDEES  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4187946243, 17181, 16600, 161, 201, 78, 34, 13, 156, 136, 211}, 3))], [])*/PROPERTYKEY(GUID("F99EFD03-431D-40D8-A1C9-4E220D9C88D3"), 9),
    WPD_APPOINTMENT_ACCEPTED_ATTENDEES  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4187946243, 17181, 16600, 161, 201, 78, 34, 13, 156, 136, 211}, 3))], [])*/PROPERTYKEY(GUID("F99EFD03-431D-40D8-A1C9-4E220D9C88D3"), 10),
    WPD_APPOINTMENT_RESOURCES           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4187946243, 17181, 16600, 161, 201, 78, 34, 13, 156, 136, 211}, 3))], [])*/PROPERTYKEY(GUID("F99EFD03-431D-40D8-A1C9-4E220D9C88D3"), 11),
    WPD_APPOINTMENT_TENTATIVE_ATTENDEES = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4187946243, 17181, 16600, 161, 201, 78, 34, 13, 156, 136, 211}, 3))], [])*/PROPERTYKEY(GUID("F99EFD03-431D-40D8-A1C9-4E220D9C88D3"), 12),
    WPD_APPOINTMENT_DECLINED_ATTENDEES  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4187946243, 17181, 16600, 161, 201, 78, 34, 13, 156, 136, 211}, 3))], [])*/PROPERTYKEY(GUID("F99EFD03-431D-40D8-A1C9-4E220D9C88D3"), 13),
}

enum GUID WPD_TASK_OBJECT_PROPERTIES_V1 = GUID("e354e95e-d8a0-4637-a03a-0cb26838dbc7");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3813992798, 55456, 17975, 160, 58, 12, 178, 104, 56, 219, 199}, 6))], [])*/PROPERTYKEY
{
    WPD_TASK_STATUS           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3813992798, 55456, 17975, 160, 58, 12, 178, 104, 56, 219, 199}, 6))], [])*/PROPERTYKEY(GUID("E354E95E-D8A0-4637-A03A-0CB26838DBC7"), 6),
    WPD_TASK_PERCENT_COMPLETE = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3813992798, 55456, 17975, 160, 58, 12, 178, 104, 56, 219, 199}, 6))], [])*/PROPERTYKEY(GUID("E354E95E-D8A0-4637-A03A-0CB26838DBC7"), 8),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3813992798, 55456, 17975, 160, 58, 12, 178, 104, 56, 219, 199}, 10))], [])*/PROPERTYKEY
{
    WPD_TASK_REMINDER_DATE = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3813992798, 55456, 17975, 160, 58, 12, 178, 104, 56, 219, 199}, 10))], [])*/PROPERTYKEY(GUID("E354E95E-D8A0-4637-A03A-0CB26838DBC7"), 10),
    WPD_TASK_OWNER         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3813992798, 55456, 17975, 160, 58, 12, 178, 104, 56, 219, 199}, 10))], [])*/PROPERTYKEY(GUID("E354E95E-D8A0-4637-A03A-0CB26838DBC7"), 11),
}

enum GUID WPD_SMS_OBJECT_PROPERTIES_V1 = GUID("7e1074cc-50ff-4dd1-a742-53be6f093a0d");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2115007692, 20735, 19921, 167, 66, 83, 190, 111, 9, 58, 13}, 2))], [])*/PROPERTYKEY
{
    WPD_SMS_PROVIDER    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2115007692, 20735, 19921, 167, 66, 83, 190, 111, 9, 58, 13}, 2))], [])*/PROPERTYKEY(GUID("7E1074CC-50FF-4DD1-A742-53BE6F093A0D"), 2),
    WPD_SMS_TIMEOUT     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2115007692, 20735, 19921, 167, 66, 83, 190, 111, 9, 58, 13}, 2))], [])*/PROPERTYKEY(GUID("7E1074CC-50FF-4DD1-A742-53BE6F093A0D"), 3),
    WPD_SMS_MAX_PAYLOAD = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2115007692, 20735, 19921, 167, 66, 83, 190, 111, 9, 58, 13}, 2))], [])*/PROPERTYKEY(GUID("7E1074CC-50FF-4DD1-A742-53BE6F093A0D"), 4),
    WPD_SMS_ENCODING    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2115007692, 20735, 19921, 167, 66, 83, 190, 111, 9, 58, 13}, 2))], [])*/PROPERTYKEY(GUID("7E1074CC-50FF-4DD1-A742-53BE6F093A0D"), 5),
}

enum GUID WPD_SECTION_OBJECT_PROPERTIES_V1 = GUID("516afd2b-c64e-44f0-98dc-bee1c88f7d66");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1365966123, 50766, 17648, 152, 220, 190, 225, 200, 143, 125, 102}, 2))], [])*/PROPERTYKEY
{
    WPD_SECTION_DATA_OFFSET                     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1365966123, 50766, 17648, 152, 220, 190, 225, 200, 143, 125, 102}, 2))], [])*/PROPERTYKEY(GUID("516AFD2B-C64E-44F0-98DC-BEE1C88F7D66"), 2),
    WPD_SECTION_DATA_LENGTH                     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1365966123, 50766, 17648, 152, 220, 190, 225, 200, 143, 125, 102}, 2))], [])*/PROPERTYKEY(GUID("516AFD2B-C64E-44F0-98DC-BEE1C88F7D66"), 3),
    WPD_SECTION_DATA_UNITS                      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1365966123, 50766, 17648, 152, 220, 190, 225, 200, 143, 125, 102}, 2))], [])*/PROPERTYKEY(GUID("516AFD2B-C64E-44F0-98DC-BEE1C88F7D66"), 4),
    WPD_SECTION_DATA_REFERENCED_OBJECT_RESOURCE = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1365966123, 50766, 17648, 152, 220, 190, 225, 200, 143, 125, 102}, 2))], [])*/PROPERTYKEY(GUID("516AFD2B-C64E-44F0-98DC-BEE1C88F7D66"), 5),
}

enum const(wchar)* NAME_Undefined = "Undefined";
enum const(wchar)* NAME_Association = "Association";

enum : const(wchar)*
{
    NAME_DeviceScript     = "DeviceScript",
    NAME_DeviceExecutable = "DeviceExecutable",
}

enum const(wchar)* NAME_TextDocument = "TextDocument";
enum const(wchar)* NAME_HTMLDocument = "HTMLDocument";
enum const(wchar)* NAME_DPOFDocument = "DPOFDocument";
enum const(wchar)* NAME_AIFFFile = "AIFFFile";

enum : const(wchar)*
{
    NAME_WAVFile  = "WAVFile",
    NAME_MP3File  = "MP3File",
    NAME_AVIFile  = "AVIFile",
    NAME_MPEGFile = "MPEGFile",
}

enum : const(wchar)*
{
    NAME_ASFFile      = "ASFFile",
    NAME_UnknownImage = "UnknownImage",
}

enum const(wchar)* NAME_EXIFImage = "EXIFImage";
enum const(wchar)* NAME_TIFFEPImage = "TIFFEPImage";
enum const(wchar)* NAME_FlashPixImage = "FlashPixImage";
enum const(wchar)* NAME_BMPImage = "BMPImage";
enum const(wchar)* NAME_CIFFImage = "CIFFImage";
enum const(wchar)* NAME_GIFImage = "GIFImage";
enum const(wchar)* NAME_JFIFImage = "JFIFImage";

enum : const(wchar)*
{
    NAME_PCDImage  = "PCDImage",
    NAME_PICTImage = "PICTImage",
    NAME_PNGImage  = "PNGImage",
}

enum : const(wchar)*
{
    NAME_TIFFImage   = "TIFFImage",
    NAME_TIFFITImage = "TIFFITImage",
}

enum : const(wchar)*
{
    NAME_JP2Image = "JP2Image",
    NAME_JPXImage = "JPXImage",
}

enum const(wchar)* NAME_FirmwareFile = "FirmwareFile";
enum const(wchar)* NAME_WBMPImage = "WBMPImage";
enum const(wchar)* NAME_JPEGXRImage = "JPEGXRImage";
enum const(wchar)* NAME_HDPhotoImage = "HDPhotoImage";
enum const(wchar)* NAME_UndefinedAudio = "UndefinedAudio";

enum : const(wchar)*
{
    NAME_WMAFile     = "WMAFile",
    NAME_OGGFile     = "OGGFile",
    NAME_AACFile     = "AACFile",
    NAME_AudibleFile = "AudibleFile",
}

enum const(wchar)* NAME_FLACFile = "FLACFile";
enum const(wchar)* NAME_QCELPFile = "QCELPFile";

enum : const(wchar)*
{
    NAME_AMRFile        = "AMRFile",
    NAME_UndefinedVideo = "UndefinedVideo",
}

enum : const(wchar)*
{
    NAME_WMVFile   = "WMVFile",
    NAME_MPEG4File = "MPEG4File",
    NAME_MPEG2File = "MPEG2File",
}

enum : const(wchar)*
{
    NAME_3GPPFile  = "3GPPFile",
    NAME_3GPP2File = "3GPP2File",
}

enum : const(wchar)*
{
    NAME_AVCHDFile  = "AVCHDFile",
    NAME_ATSCTSFile = "ATSCTSFile",
}

enum const(wchar)* NAME_DVBTSFile = "DVBTSFile";
enum const(wchar)* NAME_UndefinedCollection = "UndefinedCollection";

enum : const(wchar)*
{
    NAME_AbstractMultimediaAlbum     = "AbstractMultimediaAlbum",
    NAME_AbstractImageAlbum          = "AbstractImageAlbum",
    NAME_AbstractAudioAlbum          = "AbstractAudioAlbum",
    NAME_AbstractVideoAlbum          = "AbstractVideoAlbum",
    NAME_AbstractAudioVideoAlbum     = "AbstractAudioVideoAlbum",
    NAME_AbstractChapteredProduction = "AbstractChapteredProduction",
    NAME_AbstractAudioPlaylist       = "AbstractAudioPlaylist",
    NAME_AbstractVideoPlaylist       = "AbstractVideoPlaylist",
    NAME_AbstractMediacast           = "AbstractMediacast",
}

enum const(wchar)* NAME_WPLPlaylist = "WPLPlaylist";
enum const(wchar)* NAME_M3UPlaylist = "M3UPlaylist";
enum const(wchar)* NAME_MPLPlaylist = "MPLPlaylist";
enum const(wchar)* NAME_ASXPlaylist = "ASXPlaylist";
enum const(wchar)* NAME_PSLPlaylist = "PSLPlaylist";
enum const(wchar)* NAME_UndefinedDocument = "UndefinedDocument";
enum const(wchar)* NAME_AbstractDocument = "AbstractDocument";
enum const(wchar)* NAME_XMLDocument = "XMLDocument";
enum const(wchar)* NAME_WordDocument = "WordDocument";
enum const(wchar)* NAME_MHTDocument = "MHTDocument";
enum const(wchar)* NAME_ExcelDocument = "ExcelDocument";
enum const(wchar)* NAME_PowerPointDocument = "PowerPointDocument";

enum : const(wchar)*
{
    NAME_GenericObj_ObjectID              = "ObjectID",
    NAME_GenericObj_ReferenceParentID     = "ReferenceParentID",
    NAME_GenericObj_StorageID             = "StorageID",
    NAME_GenericObj_ObjectFormat          = "ObjectFormat",
    NAME_GenericObj_ProtectionStatus      = "ProtectionStatus",
    NAME_GenericObj_ObjectSize            = "ObjectSize",
    NAME_GenericObj_AssociationType       = "AssociationType",
    NAME_GenericObj_AssociationDesc       = "AssociationDesc",
    NAME_GenericObj_ObjectFileName        = "ObjectFileName",
    NAME_GenericObj_DateCreated           = "DateCreated",
    NAME_GenericObj_DateModified          = "DateModified",
    NAME_GenericObj_Keywords              = "Keywords",
    NAME_GenericObj_ParentID              = "ParentID",
    NAME_GenericObj_AllowedFolderContents = "AllowedFolderContents",
    NAME_GenericObj_Hidden                = "Hidden",
    NAME_GenericObj_SystemObject          = "SystemObject",
    NAME_GenericObj_PersistentUID         = "PersistentUID",
    NAME_GenericObj_SyncID                = "SyncID",
    NAME_GenericObj_PropertyBag           = "PropertyBag",
    NAME_GenericObj_Name                  = "Name",
}

enum const(wchar)* NAME_MediaObj_Artist = "Artist";

enum : const(wchar)*
{
    NAME_GenericObj_DateAuthored   = "DateAuthored",
    NAME_GenericObj_Description    = "Description",
    NAME_GenericObj_LanguageLocale = "LanguageLocale",
    NAME_GenericObj_Copyright      = "Copyright",
}

enum const(wchar)* NAME_VideoObj_Source = "Source";
enum const(wchar)* NAME_MediaObj_GeographicOrigin = "GeographicOrigin";

enum : const(wchar)*
{
    NAME_GenericObj_DateAdded     = "DateAdded",
    NAME_GenericObj_NonConsumable = "NonConsumable",
    NAME_GenericObj_Corrupt       = "Corrupt",
}

enum : const(wchar)*
{
    NAME_MediaObj_Width      = "Width",
    NAME_MediaObj_Height     = "Height",
    NAME_MediaObj_Duration   = "Duration",
    NAME_MediaObj_UserRating = "UserRating",
    NAME_MediaObj_Track      = "Track",
    NAME_MediaObj_Genre      = "Genre",
    NAME_MediaObj_Credits    = "Credits",
}

enum const(wchar)* NAME_AudioObj_Lyrics = "Lyrics";
enum const(wchar)* NAME_MediaObj_SubscriptionContentID = "SubscriptionContentID";

enum : const(wchar)*
{
    NAME_MediaObj_Producer  = "Producer",
    NAME_MediaObj_UseCount  = "UseCount",
    NAME_MediaObj_SkipCount = "SkipCount",
}

enum const(wchar)* NAME_GenericObj_DateAccessed = "DateAccessed";

enum : const(wchar)*
{
    NAME_MediaObj_ParentalRating      = "ParentalRating",
    NAME_MediaObj_MediaType           = "MediaType",
    NAME_MediaObj_Composer            = "Composer",
    NAME_MediaObj_EffectiveRating     = "EffectiveRating",
    NAME_MediaObj_Subtitle            = "Subtitle",
    NAME_MediaObj_DateOriginalRelease = "DateOriginalRelease",
    NAME_MediaObj_AlbumName           = "AlbumName",
    NAME_MediaObj_AlbumArtist         = "AlbumArtist",
    NAME_MediaObj_Mood                = "Mood",
}

enum : const(wchar)*
{
    NAME_GenericObj_DRMStatus      = "DRMStatus",
    NAME_GenericObj_SubDescription = "SubDescription",
}

enum : const(wchar)*
{
    NAME_ImageObj_IsCropped        = "IsCropped",
    NAME_ImageObj_IsColorCorrected = "IsColorCorrected",
    NAME_ImageObj_ImageBitDepth    = "ImageBitDepth",
    NAME_ImageObj_Aperature        = "Aperature",
    NAME_ImageObj_Exposure         = "Exposure",
    NAME_ImageObj_ISOSpeed         = "ISOSpeed",
}

enum : const(wchar)*
{
    NAME_MediaObj_Owner          = "Owner",
    NAME_MediaObj_Editor         = "Editor",
    NAME_MediaObj_WebMaster      = "WebMaster",
    NAME_MediaObj_URLSource      = "URLSource",
    NAME_MediaObj_URLLink        = "URLLink",
    NAME_MediaObj_BookmarkTime   = "BookmarkTime",
    NAME_MediaObj_BookmarkObject = "BookmarkObject",
    NAME_MediaObj_BookmarkByte   = "BookmarkByte",
}

enum : const(wchar)*
{
    NAME_GenericObj_DateRevised = "DateRevised",
    NAME_GenericObj_TimeToLive  = "TimeToLive",
}

enum : const(wchar)*
{
    NAME_MediaObj_MediaUID     = "MediaUID",
    NAME_MediaObj_TotalBitRate = "TotalBitRate",
    NAME_MediaObj_BitRateType  = "BitRateType",
    NAME_MediaObj_SampleRate   = "SampleRate",
}

enum : const(wchar)*
{
    NAME_AudioObj_Channels            = "Channels",
    NAME_AudioObj_AudioBitDepth       = "AudioBitDepth",
    NAME_AudioObj_AudioBlockAlignment = "AudioBlockAlignment",
}

enum const(wchar)* NAME_VideoObj_ScanType = "ScanType";

enum : const(wchar)*
{
    NAME_AudioObj_AudioFormatCode = "AudioFormatCode",
    NAME_AudioObj_AudioBitRate    = "AudioBitRate",
}

enum : const(wchar)*
{
    NAME_VideoObj_VideoFormatCode  = "VideoFormatCode",
    NAME_VideoObj_VideoBitRate     = "VideoBitRate",
    NAME_VideoObj_VideoFrameRate   = "VideoFrameRate",
    NAME_VideoObj_KeyFrameDistance = "KeyFrameDistance",
}

enum : const(wchar)*
{
    NAME_MediaObj_BufferSize           = "BufferSize",
    NAME_MediaObj_EncodingQuality      = "EncodingQuality",
    NAME_MediaObj_EncodingProfile      = "EncodingProfile",
    NAME_MediaObj_AudioEncodingProfile = "AudioEncodingProfile",
}

enum uint DEVSVC_SERVICEINFO_VERSION = 0x00000064;

enum : uint
{
    DEVSVCTYPE_DEFAULT  = 0x00000000,
    DEVSVCTYPE_ABSTRACT = 0x00000001,
}

enum : const(wchar)*
{
    NAME_Services_ServiceDisplayName = "ServiceDisplayName",
    NAME_Services_ServiceIcon        = "ServiceIcon",
    NAME_Services_ServiceLocale      = "ServiceLocale",
}

enum const(wchar)* NAME_CalendarSvc = "Calendar";
enum uint TYPE_CalendarSvc = 0x00000000;

enum : const(wchar)*
{
    NAME_CalendarSvc_SyncWindowStart = "SyncWindowStart",
    NAME_CalendarSvc_SyncWindowEnd   = "SyncWindowEnd",
}

enum : const(wchar)*
{
    NAME_AbstractActivity           = "AbstractActivity",
    NAME_AbstractActivityOccurrence = "AbstractActivityOccurrence",
}

enum const(wchar)* NAME_VCalendar1Activity = "VCalendar1";
enum const(wchar)* NAME_ICalendarActivity = "ICalendar";

enum : const(wchar)*
{
    NAME_CalendarObj_Location       = "Location",
    NAME_CalendarObj_Accepted       = "Accepted",
    NAME_CalendarObj_Tentative      = "Tentative",
    NAME_CalendarObj_Declined       = "Declined",
    NAME_CalendarObj_TimeZone       = "TimeZone",
    NAME_CalendarObj_ReminderOffset = "ReminderOffset",
    NAME_CalendarObj_BusyStatus     = "BusyStatus",
}

enum : uint
{
    ENUM_CalendarObj_BusyStatusFree        = 0x00000000,
    ENUM_CalendarObj_BusyStatusBusy        = 0x00000001,
    ENUM_CalendarObj_BusyStatusOutOfOffice = 0x00000002,
    ENUM_CalendarObj_BusyStatusTentative   = 0x00000003,
}

enum : const(wchar)*
{
    NAME_CalendarObj_PatternStartTime = "PatternStartTime",
    NAME_CalendarObj_PatternDuration  = "PatternDuration",
    NAME_CalendarObj_BeginDateTime    = "BeginDateTime",
    NAME_CalendarObj_EndDateTime      = "EndDateTime",
}

enum const(wchar)* NAME_HintsSvc = "Hints";
enum uint TYPE_HintsSvc = 0x00000000;
enum const(wchar)* NAME_MessageSvc = "Message";
enum uint TYPE_MessageSvc = 0x00000000;

enum : const(wchar)*
{
    NAME_AbstractMessage       = "AbstractMessage",
    NAME_AbstractMessageFolder = "AbstractMessageFolder",
}

enum : const(wchar)*
{
    NAME_MessageObj_Subject  = "Subject",
    NAME_MessageObj_Body     = "Body",
    NAME_MessageObj_Priority = "Priority",
}

enum : uint
{
    ENUM_MessageObj_PriorityHighest = 0x00000002,
    ENUM_MessageObj_PriorityNormal  = 0x00000001,
    ENUM_MessageObj_PriorityLowest  = 0x00000000,
}

enum : const(wchar)*
{
    NAME_MessageObj_Category = "Category",
    NAME_MessageObj_Sender   = "Sender",
    NAME_MessageObj_To       = "To",
    NAME_MessageObj_CC       = "CC",
    NAME_MessageObj_BCC      = "BCC",
    NAME_MessageObj_Read     = "Read",
}

enum : uint
{
    ENUM_MessageObj_ReadFalse = 0x00000000,
    ENUM_MessageObj_ReadTrue  = 0x000000ff,
}

enum : const(wchar)*
{
    NAME_MessageObj_ReceivedTime            = "ReceivedTime",
    NAME_MessageObj_PatternOriginalDateTime = "PatternOriginalDateTime",
    NAME_MessageObj_PatternType             = "PatternType",
}

enum : uint
{
    ENUM_MessageObj_PatternTypeDaily   = 0x00000001,
    ENUM_MessageObj_PatternTypeWeekly  = 0x00000002,
    ENUM_MessageObj_PatternTypeMonthly = 0x00000003,
    ENUM_MessageObj_PatternTypeYearly  = 0x00000004,
}

enum : const(wchar)*
{
    NAME_MessageObj_PatternValidStartDate = "PatternValidStartDate",
    NAME_MessageObj_PatternValidEndDate   = "PatternValidEndDate",
    NAME_MessageObj_PatternPeriod         = "PatternPeriod",
    NAME_MessageObj_PatternDayOfWeek      = "PatternDayOfWeek",
}

enum : uint
{
    FLAG_MessageObj_DayOfWeekNone      = 0x00000000,
    FLAG_MessageObj_DayOfWeekSunday    = 0x00000001,
    FLAG_MessageObj_DayOfWeekMonday    = 0x00000002,
    FLAG_MessageObj_DayOfWeekTuesday   = 0x00000004,
    FLAG_MessageObj_DayOfWeekWednesday = 0x00000008,
    FLAG_MessageObj_DayOfWeekThursday  = 0x00000010,
    FLAG_MessageObj_DayOfWeekFriday    = 0x00000020,
    FLAG_MessageObj_DayOfWeekSaturday  = 0x00000040,
}

enum const(wchar)* NAME_MessageObj_PatternDayOfMonth = "PatternDayOfMonth";
enum uint RANGEMIN_MessageObj_PatternDayOfMonth = 0x00000001;
enum uint RANGEMAX_MessageObj_PatternDayOfMonth = 0x0000001f;
enum uint RANGESTEP_MessageObj_PatternDayOfMonth = 0x00000001;
enum const(wchar)* NAME_MessageObj_PatternMonthOfYear = "PatternMonthOfYear";
enum uint RANGEMIN_MessageObj_PatternMonthOfYear = 0x00000001;
enum uint RANGEMAX_MessageObj_PatternMonthOfYear = 0x0000000c;
enum uint RANGESTEP_MessageObj_PatternMonthOfYear = 0x00000001;
enum const(wchar)* NAME_MessageObj_PatternInstance = "PatternInstance";

enum : uint
{
    ENUM_MessageObj_PatternInstanceNone   = 0x00000000,
    ENUM_MessageObj_PatternInstanceFirst  = 0x00000001,
    ENUM_MessageObj_PatternInstanceSecond = 0x00000002,
    ENUM_MessageObj_PatternInstanceThird  = 0x00000003,
    ENUM_MessageObj_PatternInstanceFourth = 0x00000004,
    ENUM_MessageObj_PatternInstanceLast   = 0x00000005,
}

enum const(wchar)* NAME_MessageObj_PatternDeleteDates = "PatternDeleteDates";
enum const(wchar)* NAME_DeviceMetadataSvc = "Metadata";
enum uint TYPE_DeviceMetadataSvc = 0x00000000;

enum : const(wchar)*
{
    NAME_DeviceMetadataCAB            = "DeviceMetadataCAB",
    NAME_DeviceMetadataObj_ContentID  = "ContentID",
    NAME_DeviceMetadataObj_DefaultCAB = "DefaultCAB",
}

enum : uint
{
    ENUM_DeviceMetadataObj_DefaultCABFalse = 0x00000000,
    ENUM_DeviceMetadataObj_DefaultCABTrue  = 0x00000001,
}

enum const(wchar)* NAME_NotesSvc = "Notes";
enum uint TYPE_NotesSvc = 0x00000000;
enum const(wchar)* NAME_AbstractNote = "AbstractNote";
enum const(wchar)* NAME_StatusSvc = "Status";
enum uint TYPE_StatusSvc = 0x00000000;
enum const(wchar)* NAME_StatusSvc_SignalStrength = "SignalStrength";
enum uint RANGEMIN_StatusSvc_SignalStrength = 0x00000000;
enum uint RANGEMAX_StatusSvc_SignalStrength = 0x00000004;
enum uint RANGESTEP_StatusSvc_SignalStrength = 0x00000001;
enum const(wchar)* NAME_StatusSvc_TextMessages = "TextMessages";
enum uint RANGEMAX_StatusSvc_TextMessages = 0x000000ff;
enum const(wchar)* NAME_StatusSvc_NewPictures = "NewPictures";
enum uint RANGEMAX_StatusSvc_NewPictures = 0x0000ffff;
enum const(wchar)* NAME_StatusSvc_MissedCalls = "MissedCalls";
enum uint RANGEMAX_StatusSvc_MissedCalls = 0x000000ff;
enum const(wchar)* NAME_StatusSvc_VoiceMail = "VoiceMail";
enum uint RANGEMAX_StatusSvc_VoiceMail = 0x000000ff;

enum : const(wchar)*
{
    NAME_StatusSvc_NetworkName = "NetworkName",
    NAME_StatusSvc_NetworkType = "NetworkType",
    NAME_StatusSvc_Roaming     = "Roaming",
}

enum : uint
{
    ENUM_StatusSvc_RoamingInactive = 0x00000000,
    ENUM_StatusSvc_RoamingActive   = 0x00000001,
    ENUM_StatusSvc_RoamingUnknown  = 0x00000002,
}

enum const(wchar)* NAME_StatusSvc_BatteryLife = "BatteryLife";
enum uint RANGEMIN_StatusSvc_BatteryLife = 0x00000000;
enum uint RANGEMAX_StatusSvc_BatteryLife = 0x00000064;
enum uint RANGESTEP_StatusSvc_BatteryLife = 0x00000001;
enum const(wchar)* NAME_StatusSvc_ChargingState = "ChargingState";

enum : uint
{
    ENUM_StatusSvc_ChargingInactive = 0x00000000,
    ENUM_StatusSvc_ChargingActive   = 0x00000001,
    ENUM_StatusSvc_ChargingUnknown  = 0x00000002,
}

enum : const(wchar)*
{
    NAME_StatusSvc_StorageCapacity  = "StorageCapacity",
    NAME_StatusSvc_StorageFreeSpace = "StorageFreeSpace",
}

enum : const(wchar)*
{
    NAME_SyncSvc_SyncFormat      = "SyncFormat",
    NAME_SyncSvc_LocalOnlyDelete = "LocalOnlyDelete",
    NAME_SyncSvc_FilterType      = "FilterType",
}

enum : uint
{
    SYNCSVC_FILTER_NONE                            = 0x00000000,
    SYNCSVC_FILTER_CONTACTS_WITH_PHONE             = 0x00000001,
    SYNCSVC_FILTER_TASK_ACTIVE                     = 0x00000002,
    SYNCSVC_FILTER_CALENDAR_WINDOW_WITH_RECURRENCE = 0x00000003,
}

enum const(wchar)* NAME_SyncSvc_SyncObjectReferences = "SyncObjectReferences";

enum : uint
{
    ENUM_SyncSvc_SyncObjectReferencesDisabled = 0x00000000,
    ENUM_SyncSvc_SyncObjectReferencesEnabled  = 0x000000ff,
}

enum const(wchar)* NAME_SyncObj_LastAuthorProxyID = "LastAuthorProxyID";

enum : const(wchar)*
{
    NAME_SyncSvc_BeginSync = "BeginSync",
    NAME_SyncSvc_EndSync   = "EndSync",
}

enum const(wchar)* NAME_TasksSvc = "Tasks";
enum uint TYPE_TasksSvc = 0x00000000;
enum const(wchar)* NAME_TasksSvc_SyncActiveOnly = "FilterType";
enum const(wchar)* NAME_AbstractTask = "AbstractTask";

enum : const(wchar)*
{
    NAME_TaskObj_ReminderDateTime = "ReminderDateTime",
    NAME_TaskObj_Complete         = "Complete",
}

enum : uint
{
    ENUM_TaskObj_CompleteFalse = 0x00000000,
    ENUM_TaskObj_CompleteTrue  = 0x000000ff,
}

enum : const(wchar)*
{
    NAME_TaskObj_BeginDate = "BeginDate",
    NAME_TaskObj_EndDate   = "EndDate",
}

enum GUID WPD_CATEGORY_MTP_EXT_VENDOR_OPERATIONS = GUID("4d545058-1a2e-4106-a357-771e0819fc56");

enum : /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-command-mtp-ext-get-supported-vendor-opcodes))], [])*/PROPERTYKEY
{
    WPD_COMMAND_MTP_EXT_GET_SUPPORTED_VENDOR_OPCODES       = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-command-mtp-ext-get-supported-vendor-opcodes))], [])*/PROPERTYKEY(GUID("4D545058-1A2E-4106-A357-771E0819FC56"), 11),
    WPD_COMMAND_MTP_EXT_EXECUTE_COMMAND_WITHOUT_DATA_PHASE = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-command-mtp-ext-get-supported-vendor-opcodes))], [])*/PROPERTYKEY(GUID("4D545058-1A2E-4106-A357-771E0819FC56"), 12),
    WPD_COMMAND_MTP_EXT_EXECUTE_COMMAND_WITH_DATA_TO_READ  = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-command-mtp-ext-get-supported-vendor-opcodes))], [])*/PROPERTYKEY(GUID("4D545058-1A2E-4106-A357-771E0819FC56"), 13),
    WPD_COMMAND_MTP_EXT_EXECUTE_COMMAND_WITH_DATA_TO_WRITE = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-command-mtp-ext-get-supported-vendor-opcodes))], [])*/PROPERTYKEY(GUID("4D545058-1A2E-4106-A357-771E0819FC56"), 14),
}

enum : /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-command-mtp-ext-read-data))], [])*/PROPERTYKEY
{
    WPD_COMMAND_MTP_EXT_READ_DATA                        = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-command-mtp-ext-read-data))], [])*/PROPERTYKEY(GUID("4D545058-1A2E-4106-A357-771E0819FC56"), 15),
    WPD_COMMAND_MTP_EXT_WRITE_DATA                       = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-command-mtp-ext-read-data))], [])*/PROPERTYKEY(GUID("4D545058-1A2E-4106-A357-771E0819FC56"), 16),
    WPD_COMMAND_MTP_EXT_END_DATA_TRANSFER                = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-command-mtp-ext-read-data))], [])*/PROPERTYKEY(GUID("4D545058-1A2E-4106-A357-771E0819FC56"), 17),
    WPD_COMMAND_MTP_EXT_GET_VENDOR_EXTENSION_DESCRIPTION = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/wpd-command-mtp-ext-read-data))], [])*/PROPERTYKEY(GUID("4D545058-1A2E-4106-A357-771E0819FC56"), 18),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1297371224, 6702, 16646, 163, 87, 119, 30, 8, 25, 252, 86}, 1001))], [])*/PROPERTYKEY
{
    WPD_PROPERTY_MTP_EXT_OPERATION_CODE               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1297371224, 6702, 16646, 163, 87, 119, 30, 8, 25, 252, 86}, 1001))], [])*/PROPERTYKEY(GUID("4D545058-1A2E-4106-A357-771E0819FC56"), 1001),
    WPD_PROPERTY_MTP_EXT_OPERATION_PARAMS             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1297371224, 6702, 16646, 163, 87, 119, 30, 8, 25, 252, 86}, 1001))], [])*/PROPERTYKEY(GUID("4D545058-1A2E-4106-A357-771E0819FC56"), 1002),
    WPD_PROPERTY_MTP_EXT_RESPONSE_CODE                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1297371224, 6702, 16646, 163, 87, 119, 30, 8, 25, 252, 86}, 1001))], [])*/PROPERTYKEY(GUID("4D545058-1A2E-4106-A357-771E0819FC56"), 1003),
    WPD_PROPERTY_MTP_EXT_RESPONSE_PARAMS              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1297371224, 6702, 16646, 163, 87, 119, 30, 8, 25, 252, 86}, 1001))], [])*/PROPERTYKEY(GUID("4D545058-1A2E-4106-A357-771E0819FC56"), 1004),
    WPD_PROPERTY_MTP_EXT_VENDOR_OPERATION_CODES       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1297371224, 6702, 16646, 163, 87, 119, 30, 8, 25, 252, 86}, 1001))], [])*/PROPERTYKEY(GUID("4D545058-1A2E-4106-A357-771E0819FC56"), 1005),
    WPD_PROPERTY_MTP_EXT_TRANSFER_CONTEXT             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1297371224, 6702, 16646, 163, 87, 119, 30, 8, 25, 252, 86}, 1001))], [])*/PROPERTYKEY(GUID("4D545058-1A2E-4106-A357-771E0819FC56"), 1006),
    WPD_PROPERTY_MTP_EXT_TRANSFER_TOTAL_DATA_SIZE     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1297371224, 6702, 16646, 163, 87, 119, 30, 8, 25, 252, 86}, 1001))], [])*/PROPERTYKEY(GUID("4D545058-1A2E-4106-A357-771E0819FC56"), 1007),
    WPD_PROPERTY_MTP_EXT_TRANSFER_NUM_BYTES_TO_READ   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1297371224, 6702, 16646, 163, 87, 119, 30, 8, 25, 252, 86}, 1001))], [])*/PROPERTYKEY(GUID("4D545058-1A2E-4106-A357-771E0819FC56"), 1008),
    WPD_PROPERTY_MTP_EXT_TRANSFER_NUM_BYTES_READ      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1297371224, 6702, 16646, 163, 87, 119, 30, 8, 25, 252, 86}, 1001))], [])*/PROPERTYKEY(GUID("4D545058-1A2E-4106-A357-771E0819FC56"), 1009),
    WPD_PROPERTY_MTP_EXT_TRANSFER_NUM_BYTES_TO_WRITE  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1297371224, 6702, 16646, 163, 87, 119, 30, 8, 25, 252, 86}, 1001))], [])*/PROPERTYKEY(GUID("4D545058-1A2E-4106-A357-771E0819FC56"), 1010),
    WPD_PROPERTY_MTP_EXT_TRANSFER_NUM_BYTES_WRITTEN   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1297371224, 6702, 16646, 163, 87, 119, 30, 8, 25, 252, 86}, 1001))], [])*/PROPERTYKEY(GUID("4D545058-1A2E-4106-A357-771E0819FC56"), 1011),
    WPD_PROPERTY_MTP_EXT_TRANSFER_DATA                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1297371224, 6702, 16646, 163, 87, 119, 30, 8, 25, 252, 86}, 1001))], [])*/PROPERTYKEY(GUID("4D545058-1A2E-4106-A357-771E0819FC56"), 1012),
    WPD_PROPERTY_MTP_EXT_OPTIMAL_TRANSFER_BUFFER_SIZE = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1297371224, 6702, 16646, 163, 87, 119, 30, 8, 25, 252, 86}, 1001))], [])*/PROPERTYKEY(GUID("4D545058-1A2E-4106-A357-771E0819FC56"), 1013),
    WPD_PROPERTY_MTP_EXT_VENDOR_EXTENSION_DESCRIPTION = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1297371224, 6702, 16646, 163, 87, 119, 30, 8, 25, 252, 86}, 1001))], [])*/PROPERTYKEY(GUID("4D545058-1A2E-4106-A357-771E0819FC56"), 1014),
}

enum : GUID
{
    WPD_PROPERTIES_MTP_VENDOR_EXTENDED_OBJECT_PROPS = GUID("4d545058-4fce-4578-95c8-8698a9bc0f49"),
    WPD_PROPERTIES_MTP_VENDOR_EXTENDED_DEVICE_PROPS = GUID("4d545058-8900-40b3-8f1d-dc246e1e8370"),
}

enum GUID WPD_EVENT_MTP_VENDOR_EXTENDED_EVENTS = GUID("00000000-5738-4ff2-8445-be3126691059");
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1297371224, 61320, 20045, 149, 195, 79, 50, 127, 114, 138, 150}, 1011))], [])*/PROPERTYKEY WPD_PROPERTY_MTP_EXT_EVENT_PARAMS = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1297371224, 61320, 20045, 149, 195, 79, 50, 127, 114, 138, 150}, 1011))], [])*/PROPERTYKEY(GUID("4D545058-EF88-4E4D-95C3-4F327F728A96"), 1011);
enum GUID CLSID_WPD_NAMESPACE_EXTENSION = GUID("35786d3c-b075-49b9-88dd-029876e11c01");
enum GUID WPDNSE_OBJECT_PROPERTIES_V1 = GUID("34d71409-4b47-4d80-aaac-3a28a4a3b3e6");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({886510601, 19271, 19840, 170, 172, 58, 40, 164, 163, 179, 230}, 2))], [])*/PROPERTYKEY
{
    WPDNSE_OBJECT_HAS_CONTACT_PHOTO       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({886510601, 19271, 19840, 170, 172, 58, 40, 164, 163, 179, 230}, 2))], [])*/PROPERTYKEY(GUID("34D71409-4B47-4D80-AAAC-3A28A4A3B3E6"), 2),
    WPDNSE_OBJECT_HAS_THUMBNAIL           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({886510601, 19271, 19840, 170, 172, 58, 40, 164, 163, 179, 230}, 2))], [])*/PROPERTYKEY(GUID("34D71409-4B47-4D80-AAAC-3A28A4A3B3E6"), 3),
    WPDNSE_OBJECT_HAS_ICON                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({886510601, 19271, 19840, 170, 172, 58, 40, 164, 163, 179, 230}, 2))], [])*/PROPERTYKEY(GUID("34D71409-4B47-4D80-AAAC-3A28A4A3B3E6"), 4),
    WPDNSE_OBJECT_HAS_AUDIO_CLIP          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({886510601, 19271, 19840, 170, 172, 58, 40, 164, 163, 179, 230}, 2))], [])*/PROPERTYKEY(GUID("34D71409-4B47-4D80-AAAC-3A28A4A3B3E6"), 5),
    WPDNSE_OBJECT_HAS_ALBUM_ART           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({886510601, 19271, 19840, 170, 172, 58, 40, 164, 163, 179, 230}, 2))], [])*/PROPERTYKEY(GUID("34D71409-4B47-4D80-AAAC-3A28A4A3B3E6"), 6),
    WPDNSE_OBJECT_OPTIMAL_READ_BLOCK_SIZE = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({886510601, 19271, 19840, 170, 172, 58, 40, 164, 163, 179, 230}, 2))], [])*/PROPERTYKEY(GUID("34D71409-4B47-4D80-AAAC-3A28A4A3B3E6"), 7),
}

enum : uint
{
    WPDNSE_PROPSHEET_DEVICE_GENERAL     = 0x00000001,
    WPDNSE_PROPSHEET_STORAGE_GENERAL    = 0x00000002,
    WPDNSE_PROPSHEET_CONTENT_GENERAL    = 0x00000004,
    WPDNSE_PROPSHEET_CONTENT_REFERENCES = 0x00000008,
    WPDNSE_PROPSHEET_CONTENT_RESOURCES  = 0x00000010,
    WPDNSE_PROPSHEET_CONTENT_DETAILS    = 0x00000020,
}

enum : const(wchar)*
{
    STR_WPDNSE_FAST_ENUM   = "WPDNSE Fast Enum",
    STR_WPDNSE_SIMPLE_ITEM = "WPDNSE SimpleItem",
}

enum const(wchar)* NAME_ContactsSvc = "Contacts";
enum uint TYPE_ContactsSvc = 0x00000000;
enum const(wchar)* NAME_ContactSvc_SyncWithPhoneOnly = "FilterType";
enum const(wchar)* NAME_AbstractContact = "AbstractContact";

enum : const(wchar)*
{
    NAME_VCard2Contact = "VCard2Contact",
    NAME_VCard3Contact = "VCard3Contact",
}

enum const(wchar)* NAME_AbstractContactGroup = "AbstractContactGroup";

enum : const(wchar)*
{
    NAME_ContactObj_GivenName                 = "GivenName",
    NAME_ContactObj_MiddleNames               = "MiddleNames",
    NAME_ContactObj_FamilyName                = "FamilyName",
    NAME_ContactObj_Title                     = "Title",
    NAME_ContactObj_Suffix                    = "Suffix",
    NAME_ContactObj_PhoneticGivenName         = "PhoneticGivenName",
    NAME_ContactObj_PhoneticFamilyName        = "PhoneticFamilyName",
    NAME_ContactObj_PersonalAddressFull       = "PersonalAddressFull",
    NAME_ContactObj_PersonalAddressStreet     = "PersonalAddressStreet",
    NAME_ContactObj_PersonalAddressLine2      = "PersonalAddressLine2",
    NAME_ContactObj_PersonalAddressCity       = "PersonalAddressCity",
    NAME_ContactObj_PersonalAddressRegion     = "PersonalAddressRegion",
    NAME_ContactObj_PersonalAddressPostalCode = "PersonalAddressPostalCode",
    NAME_ContactObj_PersonalAddressCountry    = "PersonalAddressCountry",
    NAME_ContactObj_BusinessAddressFull       = "BusinessAddressFull",
    NAME_ContactObj_BusinessAddressStreet     = "BusinessAddressStreet",
    NAME_ContactObj_BusinessAddressLine2      = "BusinessAddressLine2",
    NAME_ContactObj_BusinessAddressCity       = "BusinessAddressCity",
    NAME_ContactObj_BusinessAddressRegion     = "BusinessAddressRegion",
    NAME_ContactObj_BusinessAddressPostalCode = "BusinessAddressPostalCode",
    NAME_ContactObj_BusinessAddressCountry    = "BusinessAddressCountry",
    NAME_ContactObj_OtherAddressFull          = "OtherAddressFull",
    NAME_ContactObj_OtherAddressStreet        = "OtherAddressStreet",
    NAME_ContactObj_OtherAddressLine2         = "OtherAddressLine2",
    NAME_ContactObj_OtherAddressCity          = "OtherAddressCity",
    NAME_ContactObj_OtherAddressRegion        = "OtherAddressRegion",
    NAME_ContactObj_OtherAddressPostalCode    = "OtherAddressPostalCode",
    NAME_ContactObj_OtherAddressCountry       = "OtherAddressCountry",
    NAME_ContactObj_Email                     = "Email",
    NAME_ContactObj_PersonalEmail             = "PersonalEmail",
    NAME_ContactObj_PersonalEmail2            = "PersonalEmail2",
    NAME_ContactObj_BusinessEmail             = "BusinessEmail",
    NAME_ContactObj_BusinessEmail2            = "BusinessEmail2",
    NAME_ContactObj_OtherEmail                = "OtherEmail",
    NAME_ContactObj_Phone                     = "Phone",
    NAME_ContactObj_PersonalPhone             = "PersonalPhone",
    NAME_ContactObj_PersonalPhone2            = "PersonalPhone2",
    NAME_ContactObj_BusinessPhone             = "BusinessPhone",
    NAME_ContactObj_BusinessPhone2            = "BusinessPhone2",
    NAME_ContactObj_MobilePhone               = "MobilePhone",
    NAME_ContactObj_MobilePhone2              = "MobilePhone2",
    NAME_ContactObj_PersonalFax               = "PersonalFax",
    NAME_ContactObj_BusinessFax               = "BusinessFax",
    NAME_ContactObj_Pager                     = "Pager",
    NAME_ContactObj_OtherPhone                = "OtherPhone",
    NAME_ContactObj_WebAddress                = "WebAddress",
    NAME_ContactObj_PersonalWebAddress        = "PersonalWebAddress",
    NAME_ContactObj_BusinessWebAddress        = "BusinessWebAddress",
    NAME_ContactObj_IMAddress                 = "IMAddress",
    NAME_ContactObj_IMAddress2                = "IMAddress2",
    NAME_ContactObj_IMAddress3                = "IMAddress3",
    NAME_ContactObj_Organization              = "Organization",
    NAME_ContactObj_PhoneticOrganization      = "PhoneticOrganization",
    NAME_ContactObj_Role                      = "Role",
    NAME_ContactObj_Fax                       = "Fax",
    NAME_ContactObj_Spouse                    = "Spouse",
    NAME_ContactObj_Children                  = "Children",
    NAME_ContactObj_Assistant                 = "Assistant",
    NAME_ContactObj_Ringtone                  = "Ringtone",
    NAME_ContactObj_Birthdate                 = "Birthdate",
    NAME_ContactObj_AnniversaryDate           = "AnniversaryDate",
}

enum const(wchar)* NAME_RingtonesSvc = "Ringtones";
enum uint TYPE_RingtonesSvc = 0x00000000;
enum const(wchar)* NAME_RingtonesSvc_DefaultRingtone = "DefaultRingtone";
enum const(wchar)* NAME_AnchorSyncSvc = "AnchorSync";
enum uint TYPE_AnchorSyncSvc = 0x00000001;

enum : const(wchar)*
{
    NAME_AnchorSyncSvc_VersionProps      = "AnchorVersionProps",
    NAME_AnchorSyncSvc_ReplicaID         = "AnchorReplicaID",
    NAME_AnchorSyncSvc_KnowledgeObjectID = "AnchorKnowledgeObjectID",
    NAME_AnchorSyncSvc_LastSyncProxyID   = "AnchorLastSyncProxyID",
    NAME_AnchorSyncSvc_CurrentAnchor     = "AnchorCurrentAnchor",
    NAME_AnchorSyncSvc_ProviderVersion   = "AnchorProviderVersion",
    NAME_AnchorSyncSvc_SyncFormat        = "SyncFormat",
    NAME_AnchorSyncSvc_LocalOnlyDelete   = "LocalOnlyDelete",
    NAME_AnchorSyncSvc_FilterType        = "FilterType",
    NAME_AnchorSyncKnowledge             = "AnchorSyncKnowledge",
    NAME_AnchorResults                   = "AnchorResults",
    NAME_AnchorResults_AnchorState       = "AnchorState",
}

enum : uint
{
    ENUM_AnchorResults_AnchorStateNormal  = 0x00000000,
    ENUM_AnchorResults_AnchorStateInvalid = 0x00000001,
    ENUM_AnchorResults_AnchorStateOld     = 0x00000002,
}

enum : const(wchar)*
{
    NAME_AnchorResults_Anchor         = "Anchor",
    NAME_AnchorResults_ResultObjectID = "ResultObjectID",
}

enum : const(wchar)*
{
    NAME_AnchorSyncSvc_GetChangesSinceAnchor = "GetChangesSinceAnchor",
    NAME_AnchorSyncSvc_BeginSync             = "BeginSync",
    NAME_AnchorSyncSvc_EndSync               = "EndSync",
}

enum : uint
{
    ENUM_AnchorResults_ItemStateInvalid = 0x00000000,
    ENUM_AnchorResults_ItemStateDeleted = 0x00000001,
    ENUM_AnchorResults_ItemStateCreated = 0x00000002,
    ENUM_AnchorResults_ItemStateUpdated = 0x00000003,
    ENUM_AnchorResults_ItemStateChanged = 0x00000004,
}

enum const(wchar)* NAME_FullEnumSyncSvc = "FullEnumSync";
enum uint TYPE_FullEnumSyncSvc = 0x00000001;

enum : const(wchar)*
{
    NAME_FullEnumSyncSvc_VersionProps      = "FullEnumVersionProps",
    NAME_FullEnumSyncSvc_ReplicaID         = "FullEnumReplicaID",
    NAME_FullEnumSyncSvc_KnowledgeObjectID = "FullEnumKnowledgeObjectID",
    NAME_FullEnumSyncSvc_LastSyncProxyID   = "FullEnumLastSyncProxyID",
    NAME_FullEnumSyncSvc_ProviderVersion   = "FullEnumProviderVersion",
    NAME_FullEnumSyncSvc_SyncFormat        = "SyncFormat",
    NAME_FullEnumSyncSvc_LocalOnlyDelete   = "LocalOnlyDelete",
    NAME_FullEnumSyncSvc_FilterType        = "FilterType",
    NAME_FullEnumSyncKnowledge             = "FullEnumSyncKnowledge",
    NAME_FullEnumSyncSvc_BeginSync         = "BeginSync",
    NAME_FullEnumSyncSvc_EndSync           = "EndSync",
}

// Structs


struct WPD_COMMAND_ACCESS_LOOKUP_ENTRY
{
    PROPERTYKEY Command;
    uint        AccessType;
    PROPERTYKEY AccessProperty;
}

// Functions

@DllImport("DMProcessXMLFiltered.dll")
HRESULT DMProcessConfigXMLFiltered(const(PWSTR) pszXmlIn, const(PWSTR)* rgszAllowedCspNodes, 
                                   uint dwNumAllowedCspNodes, BSTR* pbstrXmlOut);


// Interfaces

@GUID("0b91a74b-ad7c-4a9d-b563-29eef9167172")
struct WpdSerializer;

@GUID("0c15d503-d017-47ce-9016-7b3f978721cc")
struct PortableDeviceValues;

@GUID("de2d022d-2480-43be-97f0-d1fa2cf98f4f")
struct PortableDeviceKeyCollection;

@GUID("08a99e2f-6d6d-4b80-af5a-baf2bcbe4cb9")
struct PortableDevicePropVariantCollection;

@GUID("3882134d-14cf-4220-9cb4-435f86d83f60")
struct PortableDeviceValuesCollection;

@GUID("728a21c5-3d9e-48d7-9810-864848f0f404")
struct PortableDevice;

@GUID("0af10cec-2ecd-4b92-9581-34f6ae0637f3")
struct PortableDeviceManager;

@GUID("ef5db4c2-9312-422c-9152-411cd9c4dd84")
struct PortableDeviceService;

@GUID("43232233-8338-4658-ae01-0b4ae830b6b0")
struct PortableDeviceDispatchFactory;

@GUID("f7c0039a-4762-488a-b4b3-760ef9a1ba9b")
struct PortableDeviceFTM;

@GUID("1649b154-c794-497a-9b03-f3f0121302f3")
struct PortableDeviceServiceFTM;

@GUID("186dd02c-2dec-41b5-a7d4-b59056fade51")
struct PortableDeviceWebControl;

@GUID("a1570149-e645-4f43-8b0d-409b061db2fc")
struct EnumBthMtpConnectors;

@GUID("b32f4002-bb27-45ff-af4f-06631c1e8dad")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iwpdserializer))], [])
interface IWpdSerializer : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iwpdserializer-getiportabledevicevaluesfrombuffer))], [])
    HRESULT GetIPortableDeviceValuesFromBuffer(ubyte* pBuffer, uint dwInputBufferLength, 
                                               IPortableDeviceValues* ppParams);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iwpdserializer-writeiportabledevicevaluestobuffer))], [])
    HRESULT WriteIPortableDeviceValuesToBuffer(uint dwOutputBufferLength, IPortableDeviceValues pResults, 
                                               ubyte* pBuffer, uint* pdwBytesWritten);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iwpdserializer-getbufferfromiportabledevicevalues))], [])
    HRESULT GetBufferFromIPortableDeviceValues(IPortableDeviceValues pSource, ubyte** ppBuffer, 
                                               uint* pdwBufferSize);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iwpdserializer-getserializedsize))], [])
    HRESULT GetSerializedSize(IPortableDeviceValues pSource, uint* pdwSize);
}

@GUID("6848f6f2-3155-4f86-b6f5-263eeeab3143")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicevalues))], [])
interface IPortableDeviceValues : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicevalues-getcount))], [])
    HRESULT GetCount(uint* pcelt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicevalues-getat))], [])
    HRESULT GetAt(const(uint) index, PROPERTYKEY* pKey, PROPVARIANT* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicevalues-setvalue))], [])
    HRESULT SetValue(const(PROPERTYKEY)* key, const(PROPVARIANT)* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicevalues-getvalue))], [])
    HRESULT GetValue(const(PROPERTYKEY)* key, PROPVARIANT* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicevalues-setstringvalue))], [])
    HRESULT SetStringValue(const(PROPERTYKEY)* key, const(PWSTR) Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicevalues-getstringvalue))], [])
    HRESULT GetStringValue(const(PROPERTYKEY)* key, PWSTR* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicevalues-setunsignedintegervalue))], [])
    HRESULT SetUnsignedIntegerValue(const(PROPERTYKEY)* key, const(uint) Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicevalues-getunsignedintegervalue))], [])
    HRESULT GetUnsignedIntegerValue(const(PROPERTYKEY)* key, uint* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicevalues-setsignedintegervalue))], [])
    HRESULT SetSignedIntegerValue(const(PROPERTYKEY)* key, const(int) Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicevalues-getsignedintegervalue))], [])
    HRESULT GetSignedIntegerValue(const(PROPERTYKEY)* key, int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicevalues-setunsignedlargeintegervalue))], [])
    HRESULT SetUnsignedLargeIntegerValue(const(PROPERTYKEY)* key, const(ulong) Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicevalues-getunsignedlargeintegervalue))], [])
    HRESULT GetUnsignedLargeIntegerValue(const(PROPERTYKEY)* key, ulong* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicevalues-setsignedlargeintegervalue))], [])
    HRESULT SetSignedLargeIntegerValue(const(PROPERTYKEY)* key, const(long) Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicevalues-getsignedlargeintegervalue))], [])
    HRESULT GetSignedLargeIntegerValue(const(PROPERTYKEY)* key, long* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicevalues-setfloatvalue))], [])
    HRESULT SetFloatValue(const(PROPERTYKEY)* key, const(float) Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicevalues-getfloatvalue))], [])
    HRESULT GetFloatValue(const(PROPERTYKEY)* key, float* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicevalues-seterrorvalue))], [])
    HRESULT SetErrorValue(const(PROPERTYKEY)* key, const(HRESULT) Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicevalues-geterrorvalue))], [])
    HRESULT GetErrorValue(const(PROPERTYKEY)* key, HRESULT* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicevalues-setkeyvalue))], [])
    HRESULT SetKeyValue(const(PROPERTYKEY)* key, const(PROPERTYKEY)* Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicevalues-getkeyvalue))], [])
    HRESULT GetKeyValue(const(PROPERTYKEY)* key, PROPERTYKEY* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicevalues-setboolvalue))], [])
    HRESULT SetBoolValue(const(PROPERTYKEY)* key, const(BOOL) Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicevalues-getboolvalue))], [])
    HRESULT GetBoolValue(const(PROPERTYKEY)* key, BOOL* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicevalues-setiunknownvalue))], [])
    HRESULT SetIUnknownValue(const(PROPERTYKEY)* key, IUnknown pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicevalues-getiunknownvalue))], [])
    HRESULT GetIUnknownValue(const(PROPERTYKEY)* key, IUnknown* ppValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicevalues-setguidvalue))], [])
    HRESULT SetGuidValue(const(PROPERTYKEY)* key, const(GUID)* Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicevalues-getguidvalue))], [])
    HRESULT GetGuidValue(const(PROPERTYKEY)* key, GUID* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicevalues-setbuffervalue))], [])
    HRESULT SetBufferValue(const(PROPERTYKEY)* key, ubyte* pValue, uint cbValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicevalues-getbuffervalue))], [])
    HRESULT GetBufferValue(const(PROPERTYKEY)* key, ubyte** ppValue, uint* pcbValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicevalues-setiportabledevicevaluesvalue))], [])
    HRESULT SetIPortableDeviceValuesValue(const(PROPERTYKEY)* key, IPortableDeviceValues pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicevalues-getiportabledevicevaluesvalue))], [])
    HRESULT GetIPortableDeviceValuesValue(const(PROPERTYKEY)* key, IPortableDeviceValues* ppValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicevalues-setiportabledevicepropvariantcollectionvalue))], [])
    HRESULT SetIPortableDevicePropVariantCollectionValue(const(PROPERTYKEY)* key, 
                                                         IPortableDevicePropVariantCollection pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicevalues-getiportabledevicepropvariantcollectionvalue))], [])
    HRESULT GetIPortableDevicePropVariantCollectionValue(const(PROPERTYKEY)* key, 
                                                         IPortableDevicePropVariantCollection* ppValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicevalues-setiportabledevicekeycollectionvalue))], [])
    HRESULT SetIPortableDeviceKeyCollectionValue(const(PROPERTYKEY)* key, IPortableDeviceKeyCollection pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicevalues-getiportabledevicekeycollectionvalue))], [])
    HRESULT GetIPortableDeviceKeyCollectionValue(const(PROPERTYKEY)* key, IPortableDeviceKeyCollection* ppValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicevalues-setiportabledevicevaluescollectionvalue))], [])
    HRESULT SetIPortableDeviceValuesCollectionValue(const(PROPERTYKEY)* key, 
                                                    IPortableDeviceValuesCollection pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicevalues-getiportabledevicevaluescollectionvalue))], [])
    HRESULT GetIPortableDeviceValuesCollectionValue(const(PROPERTYKEY)* key, 
                                                    IPortableDeviceValuesCollection* ppValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicevalues-removevalue))], [])
    HRESULT RemoveValue(const(PROPERTYKEY)* key);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicevalues-copyvaluesfrompropertystore))], [])
    HRESULT CopyValuesFromPropertyStore(IPropertyStore pStore);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicevalues-copyvaluestopropertystore))], [])
    HRESULT CopyValuesToPropertyStore(IPropertyStore pStore);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicevalues-clear))], [])
    HRESULT Clear();
}

@GUID("dada2357-e0ad-492e-98db-dd61c53ba353")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicekeycollection))], [])
interface IPortableDeviceKeyCollection : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicekeycollection-getcount))], [])
    HRESULT GetCount(uint* pcElems);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicekeycollection-getat))], [])
    HRESULT GetAt(const(uint) dwIndex, PROPERTYKEY* pKey);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicekeycollection-add))], [])
    HRESULT Add(const(PROPERTYKEY)* Key);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicekeycollection-clear))], [])
    HRESULT Clear();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicekeycollection-removeat))], [])
    HRESULT RemoveAt(const(uint) dwIndex);
}

@GUID("89b2e422-4f1b-4316-bcef-a44afea83eb3")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicepropvariantcollection))], [])
interface IPortableDevicePropVariantCollection : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicepropvariantcollection-getcount))], [])
    HRESULT GetCount(uint* pcElems);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicepropvariantcollection-getat))], [])
    HRESULT GetAt(const(uint) dwIndex, PROPVARIANT* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicepropvariantcollection-add))], [])
    HRESULT Add(const(PROPVARIANT)* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicepropvariantcollection-gettype))], [])
    HRESULT GetType(ushort* pvt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicepropvariantcollection-changetype))], [])
    HRESULT ChangeType(const(ushort) vt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicepropvariantcollection-clear))], [])
    HRESULT Clear();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicepropvariantcollection-removeat))], [])
    HRESULT RemoveAt(const(uint) dwIndex);
}

@GUID("6e3f2d79-4e07-48c4-8208-d8c2e5af4a99")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicevaluescollection))], [])
interface IPortableDeviceValuesCollection : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicevaluescollection-getcount))], [])
    HRESULT GetCount(uint* pcElems);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicevaluescollection-getat))], [])
    HRESULT GetAt(const(uint) dwIndex, IPortableDeviceValues* ppValues);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicevaluescollection-add))], [])
    HRESULT Add(IPortableDeviceValues pValues);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicevaluescollection-clear))], [])
    HRESULT Clear();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iportabledevicevaluescollection-removeat))], [])
    HRESULT RemoveAt(const(uint) dwIndex);
}

@GUID("a1567595-4c2f-4574-a6fa-ecef917b9a40")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nn-portabledeviceapi-iportabledevicemanager))], [])
interface IPortableDeviceManager : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledevicemanager-getdevices))], [])
    HRESULT GetDevices(PWSTR* pPnPDeviceIDs, uint* pcPnPDeviceIDs);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledevicemanager-refreshdevicelist))], [])
    HRESULT RefreshDeviceList();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledevicemanager-getdevicefriendlyname))], [])
    HRESULT GetDeviceFriendlyName(const(PWSTR) pszPnPDeviceID, PWSTR pDeviceFriendlyName, 
                                  uint* pcchDeviceFriendlyName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledevicemanager-getdevicedescription))], [])
    HRESULT GetDeviceDescription(const(PWSTR) pszPnPDeviceID, PWSTR pDeviceDescription, 
                                 uint* pcchDeviceDescription);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledevicemanager-getdevicemanufacturer))], [])
    HRESULT GetDeviceManufacturer(const(PWSTR) pszPnPDeviceID, PWSTR pDeviceManufacturer, 
                                  uint* pcchDeviceManufacturer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledevicemanager-getdeviceproperty))], [])
    HRESULT GetDeviceProperty(const(PWSTR) pszPnPDeviceID, const(PWSTR) pszDevicePropertyName, ubyte* pData, 
                              uint* pcbData, uint* pdwType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledevicemanager-getprivatedevices))], [])
    HRESULT GetPrivateDevices(PWSTR* pPnPDeviceIDs, uint* pcPnPDeviceIDs);
}

@GUID("625e2df8-6392-4cf0-9ad1-3cfa5f17775c")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nn-portabledeviceapi-iportabledevice))], [])
interface IPortableDevice : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledevice-open))], [])
    HRESULT Open(const(PWSTR) pszPnPDeviceID, IPortableDeviceValues pClientInfo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledevice-sendcommand))], [])
    HRESULT SendCommand(const(uint) dwFlags, IPortableDeviceValues pParameters, IPortableDeviceValues* ppResults);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledevice-content))], [])
    HRESULT Content(IPortableDeviceContent* ppContent);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledevice-capabilities))], [])
    HRESULT Capabilities(IPortableDeviceCapabilities* ppCapabilities);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledevice-cancel))], [])
    HRESULT Cancel();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledevice-close))], [])
    HRESULT Close();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledevice-advise))], [])
    HRESULT Advise(const(uint) dwFlags, IPortableDeviceEventCallback pCallback, IPortableDeviceValues pParameters, 
                   PWSTR* ppszCookie);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledevice-unadvise))], [])
    HRESULT Unadvise(const(PWSTR) pszCookie);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledevice-getpnpdeviceid))], [])
    HRESULT GetPnPDeviceID(PWSTR* ppszPnPDeviceID);
}

@GUID("6a96ed84-7c73-4480-9938-bf5af477d426")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nn-portabledeviceapi-iportabledevicecontent))], [])
interface IPortableDeviceContent : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledevicecontent-enumobjects))], [])
    HRESULT EnumObjects(const(uint) dwFlags, const(PWSTR) pszParentObjectID, IPortableDeviceValues pFilter, 
                        IEnumPortableDeviceObjectIDs* ppEnum);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledevicecontent-properties))], [])
    HRESULT Properties(IPortableDeviceProperties* ppProperties);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledevicecontent-transfer))], [])
    HRESULT Transfer(IPortableDeviceResources* ppResources);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledevicecontent-createobjectwithpropertiesonly))], [])
    HRESULT CreateObjectWithPropertiesOnly(IPortableDeviceValues pValues, PWSTR* ppszObjectID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledevicecontent-createobjectwithpropertiesanddata))], [])
    HRESULT CreateObjectWithPropertiesAndData(IPortableDeviceValues pValues, IStream* ppData, 
                                              uint* pdwOptimalWriteBufferSize, PWSTR* ppszCookie);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledevicecontent-delete))], [])
    HRESULT Delete(const(uint) dwOptions, IPortableDevicePropVariantCollection pObjectIDs, 
                   IPortableDevicePropVariantCollection* ppResults);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledevicecontent-getobjectidsfrompersistentuniqueids))], [])
    HRESULT GetObjectIDsFromPersistentUniqueIDs(IPortableDevicePropVariantCollection pPersistentUniqueIDs, 
                                                IPortableDevicePropVariantCollection* ppObjectIDs);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledevicecontent-cancel))], [])
    HRESULT Cancel();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledevicecontent-move))], [])
    HRESULT Move(IPortableDevicePropVariantCollection pObjectIDs, const(PWSTR) pszDestinationFolderObjectID, 
                 IPortableDevicePropVariantCollection* ppResults);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledevicecontent-copy))], [])
    HRESULT Copy(IPortableDevicePropVariantCollection pObjectIDs, const(PWSTR) pszDestinationFolderObjectID, 
                 IPortableDevicePropVariantCollection* ppResults);
}

@GUID("9b4add96-f6bf-4034-8708-eca72bf10554")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nn-portabledeviceapi-iportabledevicecontent2))], [])
interface IPortableDeviceContent2 : IPortableDeviceContent
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledevicecontent2-updateobjectwithpropertiesanddata))], [])
    HRESULT UpdateObjectWithPropertiesAndData(const(PWSTR) pszObjectID, IPortableDeviceValues pProperties, 
                                              IStream* ppData, uint* pdwOptimalWriteBufferSize);
}

@GUID("10ece955-cf41-4728-bfa0-41eedf1bbf19")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nn-portabledeviceapi-ienumportabledeviceobjectids))], [])
interface IEnumPortableDeviceObjectIDs : IUnknown
{
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT Next(uint cObjects, PWSTR* pObjIDs, uint* pcFetched);
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT Skip(uint cObjects);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-ienumportabledeviceobjectids-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-ienumportabledeviceobjectids-clone))], [])
    HRESULT Clone(IEnumPortableDeviceObjectIDs* ppEnum);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-ienumportabledeviceobjectids-cancel))], [])
    HRESULT Cancel();
}

@GUID("7f6d695c-03df-4439-a809-59266beee3a6")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nn-portabledeviceapi-iportabledeviceproperties))], [])
interface IPortableDeviceProperties : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledeviceproperties-getsupportedproperties))], [])
    HRESULT GetSupportedProperties(const(PWSTR) pszObjectID, IPortableDeviceKeyCollection* ppKeys);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledeviceproperties-getpropertyattributes))], [])
    HRESULT GetPropertyAttributes(const(PWSTR) pszObjectID, const(PROPERTYKEY)* Key, 
                                  IPortableDeviceValues* ppAttributes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledeviceproperties-getvalues))], [])
    HRESULT GetValues(const(PWSTR) pszObjectID, IPortableDeviceKeyCollection pKeys, 
                      IPortableDeviceValues* ppValues);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledeviceproperties-setvalues))], [])
    HRESULT SetValues(const(PWSTR) pszObjectID, IPortableDeviceValues pValues, IPortableDeviceValues* ppResults);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledeviceproperties-delete))], [])
    HRESULT Delete(const(PWSTR) pszObjectID, IPortableDeviceKeyCollection pKeys);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledeviceproperties-cancel))], [])
    HRESULT Cancel();
}

@GUID("fd8878ac-d841-4d17-891c-e6829cdb6934")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nn-portabledeviceapi-iportabledeviceresources))], [])
interface IPortableDeviceResources : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledeviceresources-getsupportedresources))], [])
    HRESULT GetSupportedResources(const(PWSTR) pszObjectID, IPortableDeviceKeyCollection* ppKeys);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledeviceresources-getresourceattributes))], [])
    HRESULT GetResourceAttributes(const(PWSTR) pszObjectID, const(PROPERTYKEY)* Key, 
                                  IPortableDeviceValues* ppResourceAttributes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledeviceresources-getstream))], [])
    HRESULT GetStream(const(PWSTR) pszObjectID, const(PROPERTYKEY)* Key, const(uint) dwMode, 
                      uint* pdwOptimalBufferSize, IStream* ppStream);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledeviceresources-delete))], [])
    HRESULT Delete(const(PWSTR) pszObjectID, IPortableDeviceKeyCollection pKeys);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledeviceresources-cancel))], [])
    HRESULT Cancel();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledeviceresources-createresource))], [])
    HRESULT CreateResource(IPortableDeviceValues pResourceAttributes, IStream* ppData, 
                           uint* pdwOptimalWriteBufferSize, PWSTR* ppszCookie);
}

@GUID("2c8c6dbf-e3dc-4061-becc-8542e810d126")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nn-portabledeviceapi-iportabledevicecapabilities))], [])
interface IPortableDeviceCapabilities : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledevicecapabilities-getsupportedcommands))], [])
    HRESULT GetSupportedCommands(IPortableDeviceKeyCollection* ppCommands);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledevicecapabilities-getcommandoptions))], [])
    HRESULT GetCommandOptions(const(PROPERTYKEY)* Command, IPortableDeviceValues* ppOptions);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledevicecapabilities-getfunctionalcategories))], [])
    HRESULT GetFunctionalCategories(IPortableDevicePropVariantCollection* ppCategories);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledevicecapabilities-getfunctionalobjects))], [])
    HRESULT GetFunctionalObjects(const(GUID)* Category, IPortableDevicePropVariantCollection* ppObjectIDs);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledevicecapabilities-getsupportedcontenttypes))], [])
    HRESULT GetSupportedContentTypes(const(GUID)* Category, IPortableDevicePropVariantCollection* ppContentTypes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledevicecapabilities-getsupportedformats))], [])
    HRESULT GetSupportedFormats(const(GUID)* ContentType, IPortableDevicePropVariantCollection* ppFormats);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledevicecapabilities-getsupportedformatproperties))], [])
    HRESULT GetSupportedFormatProperties(const(GUID)* Format, IPortableDeviceKeyCollection* ppKeys);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledevicecapabilities-getfixedpropertyattributes))], [])
    HRESULT GetFixedPropertyAttributes(const(GUID)* Format, const(PROPERTYKEY)* Key, 
                                       IPortableDeviceValues* ppAttributes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledevicecapabilities-cancel))], [])
    HRESULT Cancel();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledevicecapabilities-getsupportedevents))], [])
    HRESULT GetSupportedEvents(IPortableDevicePropVariantCollection* ppEvents);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledevicecapabilities-geteventoptions))], [])
    HRESULT GetEventOptions(const(GUID)* Event, IPortableDeviceValues* ppOptions);
}

@GUID("a8792a31-f385-493c-a893-40f64eb45f6e")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nn-portabledeviceapi-iportabledeviceeventcallback))], [])
interface IPortableDeviceEventCallback : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledeviceeventcallback-onevent))], [])
    HRESULT OnEvent(IPortableDeviceValues pEventParameters);
}

@GUID("88e04db3-1012-4d64-9996-f703a950d3f4")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nn-portabledeviceapi-iportabledevicedatastream))], [])
interface IPortableDeviceDataStream : IStream
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledevicedatastream-getobjectid))], [])
    HRESULT GetObjectID(PWSTR* ppszObjectID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledevicedatastream-cancel))], [])
    HRESULT Cancel();
}

@GUID("5e98025f-bfc4-47a2-9a5f-bc900a507c67")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nn-portabledeviceapi-iportabledeviceunitsstream))], [])
interface IPortableDeviceUnitsStream : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledeviceunitsstream-seekinunits))], [])
    HRESULT SeekInUnits(long dlibMove, WPD_STREAM_UNITS units, uint dwOrigin, ulong* plibNewPosition);
    HRESULT Cancel();
}

@GUID("482b05c0-4056-44ed-9e0f-5e23b009da93")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nn-portabledeviceapi-iportabledevicepropertiesbulk))], [])
interface IPortableDevicePropertiesBulk : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledevicepropertiesbulk-queuegetvaluesbyobjectlist))], [])
    HRESULT QueueGetValuesByObjectList(IPortableDevicePropVariantCollection pObjectIDs, 
                                       IPortableDeviceKeyCollection pKeys, 
                                       IPortableDevicePropertiesBulkCallback pCallback, GUID* pContext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledevicepropertiesbulk-queuegetvaluesbyobjectformat))], [])
    HRESULT QueueGetValuesByObjectFormat(const(GUID)* pguidObjectFormat, const(PWSTR) pszParentObjectID, 
                                         const(uint) dwDepth, IPortableDeviceKeyCollection pKeys, 
                                         IPortableDevicePropertiesBulkCallback pCallback, GUID* pContext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledevicepropertiesbulk-queuesetvaluesbyobjectlist))], [])
    HRESULT QueueSetValuesByObjectList(IPortableDeviceValuesCollection pObjectValues, 
                                       IPortableDevicePropertiesBulkCallback pCallback, GUID* pContext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledevicepropertiesbulk-start))], [])
    HRESULT Start(const(GUID)* pContext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledevicepropertiesbulk-cancel))], [])
    HRESULT Cancel(const(GUID)* pContext);
}

@GUID("9deacb80-11e8-40e3-a9f3-f557986a7845")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nn-portabledeviceapi-iportabledevicepropertiesbulkcallback))], [])
interface IPortableDevicePropertiesBulkCallback : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledevicepropertiesbulkcallback-onstart))], [])
    HRESULT OnStart(const(GUID)* pContext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledevicepropertiesbulkcallback-onprogress))], [])
    HRESULT OnProgress(const(GUID)* pContext, IPortableDeviceValuesCollection pResults);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledevicepropertiesbulkcallback-onend))], [])
    HRESULT OnEnd(const(GUID)* pContext, HRESULT hrStatus);
}

@GUID("a8abc4e9-a84a-47a9-80b3-c5d9b172a961")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nn-portabledeviceapi-iportabledeviceservicemanager))], [])
interface IPortableDeviceServiceManager : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledeviceservicemanager-getdeviceservices))], [])
    HRESULT GetDeviceServices(const(PWSTR) pszPnPDeviceID, const(GUID)* guidServiceCategory, PWSTR* pServices, 
                              uint* pcServices);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledeviceservicemanager-getdeviceforservice))], [])
    HRESULT GetDeviceForService(const(PWSTR) pszPnPServiceID, PWSTR* ppszPnPDeviceID);
}

@GUID("d3bd3a44-d7b5-40a9-98b7-2fa4d01dec08")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nn-portabledeviceapi-iportabledeviceservice))], [])
interface IPortableDeviceService : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledeviceservice-open))], [])
    HRESULT Open(const(PWSTR) pszPnPServiceID, IPortableDeviceValues pClientInfo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledeviceservice-capabilities))], [])
    HRESULT Capabilities(IPortableDeviceServiceCapabilities* ppCapabilities);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledeviceservice-content))], [])
    HRESULT Content(IPortableDeviceContent2* ppContent);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledeviceservice-methods))], [])
    HRESULT Methods(IPortableDeviceServiceMethods* ppMethods);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledeviceservice-cancel))], [])
    HRESULT Cancel();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledeviceservice-close))], [])
    HRESULT Close();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledeviceservice-getserviceobjectid))], [])
    HRESULT GetServiceObjectID(PWSTR* ppszServiceObjectID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledeviceservice-getpnpserviceid))], [])
    HRESULT GetPnPServiceID(PWSTR* ppszPnPServiceID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledeviceservice-advise))], [])
    HRESULT Advise(const(uint) dwFlags, IPortableDeviceEventCallback pCallback, IPortableDeviceValues pParameters, 
                   PWSTR* ppszCookie);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledeviceservice-unadvise))], [])
    HRESULT Unadvise(const(PWSTR) pszCookie);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledeviceservice-sendcommand))], [])
    HRESULT SendCommand(const(uint) dwFlags, IPortableDeviceValues pParameters, IPortableDeviceValues* ppResults);
}

@GUID("24dbd89d-413e-43e0-bd5b-197f3c56c886")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nn-portabledeviceapi-iportabledeviceservicecapabilities))], [])
interface IPortableDeviceServiceCapabilities : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledeviceservicecapabilities-getsupportedmethods))], [])
    HRESULT GetSupportedMethods(IPortableDevicePropVariantCollection* ppMethods);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledeviceservicecapabilities-getsupportedmethodsbyformat))], [])
    HRESULT GetSupportedMethodsByFormat(const(GUID)* Format, IPortableDevicePropVariantCollection* ppMethods);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledeviceservicecapabilities-getmethodattributes))], [])
    HRESULT GetMethodAttributes(const(GUID)* Method, IPortableDeviceValues* ppAttributes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledeviceservicecapabilities-getmethodparameterattributes))], [])
    HRESULT GetMethodParameterAttributes(const(GUID)* Method, const(PROPERTYKEY)* Parameter, 
                                         IPortableDeviceValues* ppAttributes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledeviceservicecapabilities-getsupportedformats))], [])
    HRESULT GetSupportedFormats(IPortableDevicePropVariantCollection* ppFormats);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledeviceservicecapabilities-getformatattributes))], [])
    HRESULT GetFormatAttributes(const(GUID)* Format, IPortableDeviceValues* ppAttributes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledeviceservicecapabilities-getsupportedformatproperties))], [])
    HRESULT GetSupportedFormatProperties(const(GUID)* Format, IPortableDeviceKeyCollection* ppKeys);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledeviceservicecapabilities-getformatpropertyattributes))], [])
    HRESULT GetFormatPropertyAttributes(const(GUID)* Format, const(PROPERTYKEY)* Property, 
                                        IPortableDeviceValues* ppAttributes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledeviceservicecapabilities-getsupportedevents))], [])
    HRESULT GetSupportedEvents(IPortableDevicePropVariantCollection* ppEvents);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledeviceservicecapabilities-geteventattributes))], [])
    HRESULT GetEventAttributes(const(GUID)* Event, IPortableDeviceValues* ppAttributes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledeviceservicecapabilities-geteventparameterattributes))], [])
    HRESULT GetEventParameterAttributes(const(GUID)* Event, const(PROPERTYKEY)* Parameter, 
                                        IPortableDeviceValues* ppAttributes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledeviceservicecapabilities-getinheritedservices))], [])
    HRESULT GetInheritedServices(const(uint) dwInheritanceType, IPortableDevicePropVariantCollection* ppServices);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledeviceservicecapabilities-getformatrenderingprofiles))], [])
    HRESULT GetFormatRenderingProfiles(const(GUID)* Format, IPortableDeviceValuesCollection* ppRenderingProfiles);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledeviceservicecapabilities-getsupportedcommands))], [])
    HRESULT GetSupportedCommands(IPortableDeviceKeyCollection* ppCommands);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledeviceservicecapabilities-getcommandoptions))], [])
    HRESULT GetCommandOptions(const(PROPERTYKEY)* Command, IPortableDeviceValues* ppOptions);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledeviceservicecapabilities-cancel))], [])
    HRESULT Cancel();
}

@GUID("e20333c9-fd34-412d-a381-cc6f2d820df7")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nn-portabledeviceapi-iportabledeviceservicemethods))], [])
interface IPortableDeviceServiceMethods : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledeviceservicemethods-invoke))], [])
    HRESULT Invoke(const(GUID)* Method, IPortableDeviceValues pParameters, IPortableDeviceValues* ppResults);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledeviceservicemethods-invokeasync))], [])
    HRESULT InvokeAsync(const(GUID)* Method, IPortableDeviceValues pParameters, 
                        IPortableDeviceServiceMethodCallback pCallback);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledeviceservicemethods-cancel))], [])
    HRESULT Cancel(IPortableDeviceServiceMethodCallback pCallback);
}

@GUID("c424233c-afce-4828-a756-7ed7a2350083")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nn-portabledeviceapi-iportabledeviceservicemethodcallback))], [])
interface IPortableDeviceServiceMethodCallback : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledeviceservicemethodcallback-oncomplete))], [])
    HRESULT OnComplete(HRESULT hrStatus, IPortableDeviceValues pResults);
}

@GUID("e56b0534-d9b9-425c-9b99-75f97cb3d7c8")
interface IPortableDeviceServiceActivation : IUnknown
{
    HRESULT OpenAsync(const(PWSTR) pszPnPServiceID, IPortableDeviceValues pClientInfo, 
                      IPortableDeviceServiceOpenCallback pCallback);
    HRESULT CancelOpenAsync();
}

@GUID("bced49c8-8efe-41ed-960b-61313abd47a9")
interface IPortableDeviceServiceOpenCallback : IUnknown
{
    HRESULT OnComplete(HRESULT hrStatus);
}

@GUID("5e1eafc3-e3d7-4132-96fa-759c0f9d1e0f")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nn-portabledeviceapi-iportabledevicedispatchfactory))], [])
interface IPortableDeviceDispatchFactory : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledevicedispatchfactory-getdevicedispatch))], [])
    HRESULT GetDeviceDispatch(const(PWSTR) pszPnPDeviceID, IDispatch* ppDeviceDispatch);
}

@GUID("94fc7953-5ca1-483a-8aee-df52e7747d00")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nn-portabledeviceapi-iportabledevicewebcontrol))], [])
interface IPortableDeviceWebControl : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledevicewebcontrol-getdevicefromid))], [])
    HRESULT GetDeviceFromId(BSTR deviceId, IDispatch* ppDevice);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceapi/nf-portabledeviceapi-iportabledevicewebcontrol-getdevicefromidasync))], [])
    HRESULT GetDeviceFromIdAsync(BSTR deviceId, IDispatch pCompletionHandler, IDispatch pErrorHandler);
}

@GUID("bfdef549-9247-454f-bd82-06fe80853faa")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/ienumportabledeviceconnectors))], [])
interface IEnumPortableDeviceConnectors : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/ienumportabledeviceconnectors-next))], [])
    HRESULT Next(uint cRequested, IPortableDeviceConnector* pConnectors, uint* pcFetched);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/ienumportabledeviceconnectors-skip))], [])
    HRESULT Skip(uint cConnectors);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/ienumportabledeviceconnectors-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/ienumportabledeviceconnectors-clone))], [])
    HRESULT Clone(IEnumPortableDeviceConnectors* ppEnum);
}

@GUID("625e2df8-6392-4cf0-9ad1-3cfa5f17775c")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceconnectapi/nn-portabledeviceconnectapi-iportabledeviceconnector))], [])
interface IPortableDeviceConnector : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceconnectapi/nf-portabledeviceconnectapi-iportabledeviceconnector-connect))], [])
    HRESULT Connect(IConnectionRequestCallback pCallback);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceconnectapi/nf-portabledeviceconnectapi-iportabledeviceconnector-disconnect))], [])
    HRESULT Disconnect(IConnectionRequestCallback pCallback);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceconnectapi/nf-portabledeviceconnectapi-iportabledeviceconnector-cancel))], [])
    HRESULT Cancel(IConnectionRequestCallback pCallback);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceconnectapi/nf-portabledeviceconnectapi-iportabledeviceconnector-getproperty))], [])
    HRESULT GetProperty(const(DEVPROPKEY)* pPropertyKey, DEVPROPTYPE* pPropertyType, ubyte** ppData, uint* pcbData);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceconnectapi/nf-portabledeviceconnectapi-iportabledeviceconnector-setproperty))], [])
    HRESULT SetProperty(const(DEVPROPKEY)* pPropertyKey, DEVPROPTYPE PropertyType, const(ubyte)* pData, 
                        uint cbData);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/portabledeviceconnectapi/nf-portabledeviceconnectapi-iportabledeviceconnector-getpnpid))], [])
    HRESULT GetPnPID(PWSTR* ppwszPnPID);
}

@GUID("272c9ae0-7161-4ae0-91bd-9f448ee9c427")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iconnectionrequestcallback))], [])
interface IConnectionRequestCallback : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wpd_sdk/iconnectionrequestcallback-oncomplete))], [])
    HRESULT OnComplete(HRESULT hrStatus);
}

@GUID("6cfdcab5-fc47-42a5-9241-074b58830e73")
interface IMediaRadioManager : IUnknown
{
    HRESULT GetRadioInstances(IRadioInstanceCollection* ppCollection);
    HRESULT OnSystemRadioStateChange(SYSTEM_RADIO_STATE sysRadioState, uint uTimeoutSec);
}

@GUID("e5791fae-5665-4e0c-95be-5fde31644185")
interface IRadioInstanceCollection : IUnknown
{
    HRESULT GetCount(uint* pcInstance);
    HRESULT GetAt(uint uIndex, IRadioInstance* ppRadioInstance);
}

@GUID("70aa1c9e-f2b4-4c61-86d3-6b9fb75fd1a2")
interface IRadioInstance : IUnknown
{
    HRESULT GetRadioManagerSignature(GUID* pguidSignature);
    HRESULT GetInstanceSignature(BSTR* pbstrId);
    HRESULT GetFriendlyName(uint lcid, BSTR* pbstrName);
    HRESULT GetRadioState(DEVICE_RADIO_STATE* pRadioState);
    HRESULT SetRadioState(DEVICE_RADIO_STATE radioState, uint uTimeoutSec);
    BOOL    IsMultiComm();
    BOOL    IsAssociatingDevice();
}

@GUID("89d81f5f-c147-49ed-a11c-77b20c31e7c9")
interface IMediaRadioManagerNotifySink : IUnknown
{
    HRESULT OnInstanceAdd(IRadioInstance pRadioInstance);
    HRESULT OnInstanceRemove(BSTR bstrRadioInstanceId);
    HRESULT OnInstanceRadioChange(BSTR bstrRadioInstanceId, DEVICE_RADIO_STATE radioState);
}


// GUIDs

const GUID CLSID_EnumBthMtpConnectors                = GUIDOF!EnumBthMtpConnectors;
const GUID CLSID_PortableDevice                      = GUIDOF!PortableDevice;
const GUID CLSID_PortableDeviceDispatchFactory       = GUIDOF!PortableDeviceDispatchFactory;
const GUID CLSID_PortableDeviceFTM                   = GUIDOF!PortableDeviceFTM;
const GUID CLSID_PortableDeviceKeyCollection         = GUIDOF!PortableDeviceKeyCollection;
const GUID CLSID_PortableDeviceManager               = GUIDOF!PortableDeviceManager;
const GUID CLSID_PortableDevicePropVariantCollection = GUIDOF!PortableDevicePropVariantCollection;
const GUID CLSID_PortableDeviceService               = GUIDOF!PortableDeviceService;
const GUID CLSID_PortableDeviceServiceFTM            = GUIDOF!PortableDeviceServiceFTM;
const GUID CLSID_PortableDeviceValues                = GUIDOF!PortableDeviceValues;
const GUID CLSID_PortableDeviceValuesCollection      = GUIDOF!PortableDeviceValuesCollection;
const GUID CLSID_PortableDeviceWebControl            = GUIDOF!PortableDeviceWebControl;
const GUID CLSID_WpdSerializer                       = GUIDOF!WpdSerializer;

const GUID IID_IConnectionRequestCallback            = GUIDOF!IConnectionRequestCallback;
const GUID IID_IEnumPortableDeviceConnectors         = GUIDOF!IEnumPortableDeviceConnectors;
const GUID IID_IEnumPortableDeviceObjectIDs          = GUIDOF!IEnumPortableDeviceObjectIDs;
const GUID IID_IMediaRadioManager                    = GUIDOF!IMediaRadioManager;
const GUID IID_IMediaRadioManagerNotifySink          = GUIDOF!IMediaRadioManagerNotifySink;
const GUID IID_IPortableDevice                       = GUIDOF!IPortableDevice;
const GUID IID_IPortableDeviceCapabilities           = GUIDOF!IPortableDeviceCapabilities;
const GUID IID_IPortableDeviceConnector              = GUIDOF!IPortableDeviceConnector;
const GUID IID_IPortableDeviceContent                = GUIDOF!IPortableDeviceContent;
const GUID IID_IPortableDeviceContent2               = GUIDOF!IPortableDeviceContent2;
const GUID IID_IPortableDeviceDataStream             = GUIDOF!IPortableDeviceDataStream;
const GUID IID_IPortableDeviceDispatchFactory        = GUIDOF!IPortableDeviceDispatchFactory;
const GUID IID_IPortableDeviceEventCallback          = GUIDOF!IPortableDeviceEventCallback;
const GUID IID_IPortableDeviceKeyCollection          = GUIDOF!IPortableDeviceKeyCollection;
const GUID IID_IPortableDeviceManager                = GUIDOF!IPortableDeviceManager;
const GUID IID_IPortableDevicePropVariantCollection  = GUIDOF!IPortableDevicePropVariantCollection;
const GUID IID_IPortableDeviceProperties             = GUIDOF!IPortableDeviceProperties;
const GUID IID_IPortableDevicePropertiesBulk         = GUIDOF!IPortableDevicePropertiesBulk;
const GUID IID_IPortableDevicePropertiesBulkCallback = GUIDOF!IPortableDevicePropertiesBulkCallback;
const GUID IID_IPortableDeviceResources              = GUIDOF!IPortableDeviceResources;
const GUID IID_IPortableDeviceService                = GUIDOF!IPortableDeviceService;
const GUID IID_IPortableDeviceServiceActivation      = GUIDOF!IPortableDeviceServiceActivation;
const GUID IID_IPortableDeviceServiceCapabilities    = GUIDOF!IPortableDeviceServiceCapabilities;
const GUID IID_IPortableDeviceServiceManager         = GUIDOF!IPortableDeviceServiceManager;
const GUID IID_IPortableDeviceServiceMethodCallback  = GUIDOF!IPortableDeviceServiceMethodCallback;
const GUID IID_IPortableDeviceServiceMethods         = GUIDOF!IPortableDeviceServiceMethods;
const GUID IID_IPortableDeviceServiceOpenCallback    = GUIDOF!IPortableDeviceServiceOpenCallback;
const GUID IID_IPortableDeviceUnitsStream            = GUIDOF!IPortableDeviceUnitsStream;
const GUID IID_IPortableDeviceValues                 = GUIDOF!IPortableDeviceValues;
const GUID IID_IPortableDeviceValuesCollection       = GUIDOF!IPortableDeviceValuesCollection;
const GUID IID_IPortableDeviceWebControl             = GUIDOF!IPortableDeviceWebControl;
const GUID IID_IRadioInstance                        = GUIDOF!IRadioInstance;
const GUID IID_IRadioInstanceCollection              = GUIDOF!IRadioInstanceCollection;
const GUID IID_IWpdSerializer                        = GUIDOF!IWpdSerializer;
