// Written in the D programming language.

module windows.win32.media.audio;

public import windows.core;
public import system : Guid;
public import windows.win32.foundation : BOOL, CHAR, HANDLE, HINSTANCE, HMODULE,
                                         HRESULT, HTASK, HWND, LPARAM, LRESULT,
                                         PROPERTYKEY, PSTR, PWSTR, WPARAM;
public import windows.win32.media : MMTIME;
public import windows.win32.media.multimedia : HDRVR;
public import windows.win32.system.com : CLSCTX, INTERFACEINFO, IUnknown, STGM;
public import windows.win32.system.com.structuredstorage : PROPVARIANT;
public import windows.win32.ui.shell.propertiessystem : IPropertyStore;
public import windows.win32.ui.windowsandmessaging : HICON;

extern(Windows) @nogc nothrow:


// Enums

alias MIDI_WAVE_OPEN_TYPE = uint;
enum : uint
{
    CALLBACK_TYPEMASK                        = 0x00070000,
    CALLBACK_NULL                            = 0x00000000,
    CALLBACK_WINDOW                          = 0x00010000,
    CALLBACK_TASK                            = 0x00020000,
    CALLBACK_FUNCTION                        = 0x00030000,
    CALLBACK_THREAD                          = 0x00020000,
    CALLBACK_EVENT                           = 0x00050000,
    WAVE_FORMAT_QUERY                        = 0x00000001,
    WAVE_ALLOWSYNC                           = 0x00000002,
    WAVE_MAPPED                              = 0x00000004,
    WAVE_FORMAT_DIRECT                       = 0x00000008,
    WAVE_FORMAT_DIRECT_QUERY                 = 0x00000009,
    WAVE_MAPPED_DEFAULT_COMMUNICATION_DEVICE = 0x00000010,
    MIDI_IO_STATUS                           = 0x00000020,
}
alias SND_FLAGS = uint;
enum : uint
{
    SND_APPLICATION = 0x00000080,
    SND_ALIAS       = 0x00010000,
    SND_ALIAS_ID    = 0x00110000,
    SND_FILENAME    = 0x00020000,
    SND_RESOURCE    = 0x00040004,
    SND_ASYNC       = 0x00000001,
    SND_NODEFAULT   = 0x00000002,
    SND_LOOP        = 0x00000008,
    SND_MEMORY      = 0x00000004,
    SND_NOSTOP      = 0x00000010,
    SND_NOWAIT      = 0x00002000,
    SND_PURGE       = 0x00000040,
    SND_SENTRY      = 0x00080000,
    SND_SYNC        = 0x00000000,
    SND_SYSTEM      = 0x00200000,
}
alias MIXERLINE_COMPONENTTYPE = uint;
enum : uint
{
    MIXERLINE_COMPONENTTYPE_DST_DIGITAL     = 0x00000001,
    MIXERLINE_COMPONENTTYPE_DST_HEADPHONES  = 0x00000005,
    MIXERLINE_COMPONENTTYPE_DST_LINE        = 0x00000002,
    MIXERLINE_COMPONENTTYPE_DST_MONITOR     = 0x00000003,
    MIXERLINE_COMPONENTTYPE_DST_SPEAKERS    = 0x00000004,
    MIXERLINE_COMPONENTTYPE_DST_TELEPHONE   = 0x00000006,
    MIXERLINE_COMPONENTTYPE_DST_UNDEFINED   = 0x00000000,
    MIXERLINE_COMPONENTTYPE_DST_VOICEIN     = 0x00000008,
    MIXERLINE_COMPONENTTYPE_DST_WAVEIN      = 0x00000007,
    MIXERLINE_COMPONENTTYPE_SRC_ANALOG      = 0x0000100a,
    MIXERLINE_COMPONENTTYPE_SRC_AUXILIARY   = 0x00001009,
    MIXERLINE_COMPONENTTYPE_SRC_COMPACTDISC = 0x00001005,
    MIXERLINE_COMPONENTTYPE_SRC_DIGITAL     = 0x00001001,
    MIXERLINE_COMPONENTTYPE_SRC_LINE        = 0x00001002,
    MIXERLINE_COMPONENTTYPE_SRC_MICROPHONE  = 0x00001003,
    MIXERLINE_COMPONENTTYPE_SRC_PCSPEAKER   = 0x00001007,
    MIXERLINE_COMPONENTTYPE_SRC_SYNTHESIZER = 0x00001004,
    MIXERLINE_COMPONENTTYPE_SRC_TELEPHONE   = 0x00001006,
    MIXERLINE_COMPONENTTYPE_SRC_UNDEFINED   = 0x00001000,
    MIXERLINE_COMPONENTTYPE_SRC_WAVEOUT     = 0x00001008,
}
alias DEVICE_STATE = uint;
enum : uint
{
    DEVICE_STATE_ACTIVE     = 0x00000001,
    DEVICE_STATE_DISABLED   = 0x00000002,
    DEVICE_STATE_NOTPRESENT = 0x00000004,
    DEVICE_STATE_UNPLUGGED  = 0x00000008,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audiosessiontypes/ne-audiosessiontypes-audclnt_sharemode))], [])
alias AUDCLNT_SHAREMODE = int;
enum : int
{
    AUDCLNT_SHAREMODE_SHARED    = 0x00000000,
    AUDCLNT_SHAREMODE_EXCLUSIVE = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audiosessiontypes/ne-audiosessiontypes-audio_stream_category))], [])
alias AUDIO_STREAM_CATEGORY = int;
enum : int
{
    AudioCategory_Other               = 0x00000000,
    AudioCategory_ForegroundOnlyMedia = 0x00000001,
    AudioCategory_Communications      = 0x00000003,
    AudioCategory_Alerts              = 0x00000004,
    AudioCategory_SoundEffects        = 0x00000005,
    AudioCategory_GameEffects         = 0x00000006,
    AudioCategory_GameMedia           = 0x00000007,
    AudioCategory_GameChat            = 0x00000008,
    AudioCategory_Speech              = 0x00000009,
    AudioCategory_Movie               = 0x0000000a,
    AudioCategory_Media               = 0x0000000b,
    AudioCategory_FarFieldSpeech      = 0x0000000c,
    AudioCategory_UniformSpeech       = 0x0000000d,
    AudioCategory_VoiceTyping         = 0x0000000e,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audiosessiontypes/ne-audiosessiontypes-audiosessionstate))], [])
enum AudioSessionState : int
{
    AudioSessionStateInactive = 0x00000000,
    AudioSessionStateActive   = 0x00000001,
    AudioSessionStateExpired  = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/ne-audioclient-_audclnt_bufferflags))], [])
alias _AUDCLNT_BUFFERFLAGS = int;
enum : int
{
    AUDCLNT_BUFFERFLAGS_DATA_DISCONTINUITY = 0x00000001,
    AUDCLNT_BUFFERFLAGS_SILENT             = 0x00000002,
    AUDCLNT_BUFFERFLAGS_TIMESTAMP_ERROR    = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/ne-audioclient-audclnt_streamoptions))], [])
alias AUDCLNT_STREAMOPTIONS = int;
enum : int
{
    AUDCLNT_STREAMOPTIONS_NONE                 = 0x00000000,
    AUDCLNT_STREAMOPTIONS_RAW                  = 0x00000001,
    AUDCLNT_STREAMOPTIONS_MATCH_FORMAT         = 0x00000002,
    AUDCLNT_STREAMOPTIONS_AMBISONICS           = 0x00000004,
    AUDCLNT_STREAMOPTIONS_POST_VOLUME_LOOPBACK = 0x00000008,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/ne-audioclient-audio_ducking_options))], [])
alias AUDIO_DUCKING_OPTIONS = int;
enum : int
{
    AUDIO_DUCKING_OPTIONS_DEFAULT                   = 0x00000000,
    AUDIO_DUCKING_OPTIONS_DO_NOT_DUCK_OTHER_STREAMS = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/ne-audioclient-audio_effect_state))], [])
alias AUDIO_EFFECT_STATE = int;
enum : int
{
    AUDIO_EFFECT_STATE_OFF = 0x00000000,
    AUDIO_EFFECT_STATE_ON  = 0x00000001,
}
alias AMBISONICS_TYPE = int;
enum : int
{
    AMBISONICS_TYPE_FULL3D = 0x00000000,
}
alias AMBISONICS_CHANNEL_ORDERING = int;
enum : int
{
    AMBISONICS_CHANNEL_ORDERING_ACN = 0x00000000,
}
alias AMBISONICS_NORMALIZATION = int;
enum : int
{
    AMBISONICS_NORMALIZATION_SN3D = 0x00000000,
    AMBISONICS_NORMALIZATION_N3D  = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudioclient/ne-spatialaudioclient-audioobjecttype))], [])
enum AudioObjectType : int
{
    AudioObjectType_None             = 0x00000000,
    AudioObjectType_Dynamic          = 0x00000001,
    AudioObjectType_FrontLeft        = 0x00000002,
    AudioObjectType_FrontRight       = 0x00000004,
    AudioObjectType_FrontCenter      = 0x00000008,
    AudioObjectType_LowFrequency     = 0x00000010,
    AudioObjectType_SideLeft         = 0x00000020,
    AudioObjectType_SideRight        = 0x00000040,
    AudioObjectType_BackLeft         = 0x00000080,
    AudioObjectType_BackRight        = 0x00000100,
    AudioObjectType_TopFrontLeft     = 0x00000200,
    AudioObjectType_TopFrontRight    = 0x00000400,
    AudioObjectType_TopBackLeft      = 0x00000800,
    AudioObjectType_TopBackRight     = 0x00001000,
    AudioObjectType_BottomFrontLeft  = 0x00002000,
    AudioObjectType_BottomFrontRight = 0x00004000,
    AudioObjectType_BottomBackLeft   = 0x00008000,
    AudioObjectType_BottomBackRight  = 0x00010000,
    AudioObjectType_BackCenter       = 0x00020000,
    AudioObjectType_StereoLeft       = 0x00040000,
    AudioObjectType_StereoRight      = 0x00080000,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudioclient/ne-spatialaudioclient-spatial_audio_stream_options))], [])
alias SPATIAL_AUDIO_STREAM_OPTIONS = int;
enum : int
{
    SPATIAL_AUDIO_STREAM_OPTIONS_NONE    = 0x00000000,
    SPATIAL_AUDIO_STREAM_OPTIONS_OFFLOAD = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiohrtf/ne-spatialaudiohrtf-spatialaudiohrtfdirectivitytype))], [])
enum SpatialAudioHrtfDirectivityType : int
{
    SpatialAudioHrtfDirectivity_OmniDirectional = 0x00000000,
    SpatialAudioHrtfDirectivity_Cardioid        = 0x00000001,
    SpatialAudioHrtfDirectivity_Cone            = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiohrtf/ne-spatialaudiohrtf-spatialaudiohrtfenvironmenttype))], [])
enum SpatialAudioHrtfEnvironmentType : int
{
    SpatialAudioHrtfEnvironment_Small    = 0x00000000,
    SpatialAudioHrtfEnvironment_Medium   = 0x00000001,
    SpatialAudioHrtfEnvironment_Large    = 0x00000002,
    SpatialAudioHrtfEnvironment_Outdoors = 0x00000003,
    SpatialAudioHrtfEnvironment_Average  = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiohrtf/ne-spatialaudiohrtf-spatialaudiohrtfdistancedecaytype))], [])
enum SpatialAudioHrtfDistanceDecayType : int
{
    SpatialAudioHrtfDistanceDecay_NaturalDecay = 0x00000000,
    SpatialAudioHrtfDistanceDecay_CustomDecay  = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmdeviceapi/ne-mmdeviceapi-edataflow))], [])
enum EDataFlow : int
{
    eRender              = 0x00000000,
    eCapture             = 0x00000001,
    eAll                 = 0x00000002,
    EDataFlow_enum_count = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmdeviceapi/ne-mmdeviceapi-erole))], [])
enum ERole : int
{
    eConsole         = 0x00000000,
    eMultimedia      = 0x00000001,
    eCommunications  = 0x00000002,
    ERole_enum_count = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmdeviceapi/ne-mmdeviceapi-endpointformfactor))], [])
enum EndpointFormFactor : int
{
    RemoteNetworkDevice           = 0x00000000,
    Speakers                      = 0x00000001,
    LineLevel                     = 0x00000002,
    Headphones                    = 0x00000003,
    Microphone                    = 0x00000004,
    Headset                       = 0x00000005,
    Handset                       = 0x00000006,
    UnknownDigitalPassthrough     = 0x00000007,
    SPDIF                         = 0x00000008,
    DigitalAudioDisplayDevice     = 0x00000009,
    UnknownFormFactor             = 0x0000000a,
    EndpointFormFactor_enum_count = 0x0000000b,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmdeviceapi/ne-mmdeviceapi-audio_systemeffects_propertystore_type))], [])
alias AUDIO_SYSTEMEFFECTS_PROPERTYSTORE_TYPE = int;
enum : int
{
    AUDIO_SYSTEMEFFECTS_PROPERTYSTORE_TYPE_DEFAULT    = 0x00000000,
    AUDIO_SYSTEMEFFECTS_PROPERTYSTORE_TYPE_USER       = 0x00000001,
    AUDIO_SYSTEMEFFECTS_PROPERTYSTORE_TYPE_VOLATILE   = 0x00000002,
    AUDIO_SYSTEMEFFECTS_PROPERTYSTORE_TYPE_ENUM_COUNT = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/ne-devicetopology-dataflow))], [])
enum DataFlow : int
{
    In      = 0x00000000,
    Out     = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/ne-devicetopology-parttype))], [])
enum PartType : int
{
    Connector = 0x00000000,
    Subunit   = 0x00000001,
}
//ENUM ATTR: ScopedEnumAttribute : CustomAttributeSig([], [])
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/ne-devicetopology-connectortype))], [])
enum ConnectorType : int
{
    Unknown_Connector = 0x00000000,
    Physical_Internal = 0x00000001,
    Physical_External = 0x00000002,
    Software_IO       = 0x00000003,
    Software_Fixed    = 0x00000004,
    Network           = 0x00000005,
}
enum AudioSessionDisconnectReason : int
{
    DisconnectReasonDeviceRemoval         = 0x00000000,
    DisconnectReasonServerShutdown        = 0x00000001,
    DisconnectReasonFormatChanged         = 0x00000002,
    DisconnectReasonSessionLogoff         = 0x00000003,
    DisconnectReasonSessionDisconnected   = 0x00000004,
    DisconnectReasonExclusiveModeOverride = 0x00000005,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiometadata/ne-spatialaudiometadata-spatialaudiometadatawriteroverflowmode))], [])
enum SpatialAudioMetadataWriterOverflowMode : int
{
    SpatialAudioMetadataWriterOverflow_Fail          = 0x00000000,
    SpatialAudioMetadataWriterOverflow_MergeWithNew  = 0x00000001,
    SpatialAudioMetadataWriterOverflow_MergeWithLast = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiometadata/ne-spatialaudiometadata-spatialaudiometadatacopymode))], [])
enum SpatialAudioMetadataCopyMode : int
{
    SpatialAudioMetadataCopy_Overwrite            = 0x00000000,
    SpatialAudioMetadataCopy_Append               = 0x00000001,
    SpatialAudioMetadataCopy_AppendMergeWithLast  = 0x00000002,
    SpatialAudioMetadataCopy_AppendMergeWithFirst = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclientactivationparams/ne-audioclientactivationparams-process_loopback_mode))], [])
alias PROCESS_LOOPBACK_MODE = int;
enum : int
{
    PROCESS_LOOPBACK_MODE_INCLUDE_TARGET_PROCESS_TREE = 0x00000000,
    PROCESS_LOOPBACK_MODE_EXCLUDE_TARGET_PROCESS_TREE = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclientactivationparams/ne-audioclientactivationparams-audioclient_activation_type))], [])
alias AUDIOCLIENT_ACTIVATION_TYPE = int;
enum : int
{
    AUDIOCLIENT_ACTIVATION_TYPE_DEFAULT          = 0x00000000,
    AUDIOCLIENT_ACTIVATION_TYPE_PROCESS_LOOPBACK = 0x00000001,
}
enum AudioStateMonitorSoundLevel : int
{
    Muted   = 0x00000000,
    Low     = 0x00000001,
    Full    = 0x00000002,
}

// Constants


enum : uint
{
    MIXERCONTROL_CONTROLTYPE_CUSTOM         = 0x00000000,
    MIXERCONTROL_CONTROLTYPE_BOOLEANMETER   = 0x10010000,
    MIXERCONTROL_CONTROLTYPE_SIGNEDMETER    = 0x10020000,
    MIXERCONTROL_CONTROLTYPE_PEAKMETER      = 0x10020001,
    MIXERCONTROL_CONTROLTYPE_UNSIGNEDMETER  = 0x10030000,
    MIXERCONTROL_CONTROLTYPE_BOOLEAN        = 0x20010000,
    MIXERCONTROL_CONTROLTYPE_ONOFF          = 0x20010001,
    MIXERCONTROL_CONTROLTYPE_MUTE           = 0x20010002,
    MIXERCONTROL_CONTROLTYPE_MONO           = 0x20010003,
    MIXERCONTROL_CONTROLTYPE_LOUDNESS       = 0x20010004,
    MIXERCONTROL_CONTROLTYPE_STEREOENH      = 0x20010005,
    MIXERCONTROL_CONTROLTYPE_BASS_BOOST     = 0x20012277,
    MIXERCONTROL_CONTROLTYPE_BUTTON         = 0x21010000,
    MIXERCONTROL_CONTROLTYPE_DECIBELS       = 0x30040000,
    MIXERCONTROL_CONTROLTYPE_SIGNED         = 0x30020000,
    MIXERCONTROL_CONTROLTYPE_UNSIGNED       = 0x30030000,
    MIXERCONTROL_CONTROLTYPE_PERCENT        = 0x30050000,
    MIXERCONTROL_CONTROLTYPE_SLIDER         = 0x40020000,
    MIXERCONTROL_CONTROLTYPE_PAN            = 0x40020001,
    MIXERCONTROL_CONTROLTYPE_QSOUNDPAN      = 0x40020002,
    MIXERCONTROL_CONTROLTYPE_FADER          = 0x50030000,
    MIXERCONTROL_CONTROLTYPE_VOLUME         = 0x50030001,
    MIXERCONTROL_CONTROLTYPE_BASS           = 0x50030002,
    MIXERCONTROL_CONTROLTYPE_TREBLE         = 0x50030003,
    MIXERCONTROL_CONTROLTYPE_EQUALIZER      = 0x50030004,
    MIXERCONTROL_CONTROLTYPE_SINGLESELECT   = 0x70010000,
    MIXERCONTROL_CONTROLTYPE_MUX            = 0x70010001,
    MIXERCONTROL_CONTROLTYPE_MULTIPLESELECT = 0x71010000,
    MIXERCONTROL_CONTROLTYPE_MIXER          = 0x71010001,
    MIXERCONTROL_CONTROLTYPE_MICROTIME      = 0x60030000,
    MIXERCONTROL_CONTROLTYPE_MILLITIME      = 0x61030000,
}

enum uint WAVE_MAPPER = 0xffffffff;
enum uint ENDPOINT_FORMAT_RESET_MIX_ONLY = 0x00000001;

enum : uint
{
    ENDPOINT_HARDWARE_SUPPORT_VOLUME = 0x00000001,
    ENDPOINT_HARDWARE_SUPPORT_MUTE   = 0x00000002,
    ENDPOINT_HARDWARE_SUPPORT_METER  = 0x00000004,
}

enum uint AUDIOCLOCK_CHARACTERISTIC_FIXED_FREQ = 0x00000001;
enum uint AMBISONICS_PARAM_VERSION_1 = 0x00000001;
enum HRESULT AUDCLNT_E_NOT_INITIALIZED = HRESULT(0x88890001);
enum HRESULT AUDCLNT_E_ALREADY_INITIALIZED = HRESULT(0x88890002);
enum HRESULT AUDCLNT_E_WRONG_ENDPOINT_TYPE = HRESULT(0x88890003);
enum HRESULT AUDCLNT_E_DEVICE_INVALIDATED = HRESULT(0x88890004);

enum : HRESULT
{
    AUDCLNT_E_NOT_STOPPED      = HRESULT(0x88890005),
    AUDCLNT_E_BUFFER_TOO_LARGE = HRESULT(0x88890006),
}

enum : HRESULT
{
    AUDCLNT_E_OUT_OF_ORDER       = HRESULT(0x88890007),
    AUDCLNT_E_UNSUPPORTED_FORMAT = HRESULT(0x88890008),
}

enum : HRESULT
{
    AUDCLNT_E_INVALID_SIZE             = HRESULT(0x88890009),
    AUDCLNT_E_DEVICE_IN_USE            = HRESULT(0x8889000a),
    AUDCLNT_E_BUFFER_OPERATION_PENDING = HRESULT(0x8889000b),
}

enum HRESULT AUDCLNT_E_THREAD_NOT_REGISTERED = HRESULT(0x8889000c);
enum HRESULT AUDCLNT_E_EXCLUSIVE_MODE_NOT_ALLOWED = HRESULT(0x8889000e);
enum HRESULT AUDCLNT_E_ENDPOINT_CREATE_FAILED = HRESULT(0x8889000f);
enum HRESULT AUDCLNT_E_SERVICE_NOT_RUNNING = HRESULT(0x88890010);
enum HRESULT AUDCLNT_E_EVENTHANDLE_NOT_EXPECTED = HRESULT(0x88890011);
enum HRESULT AUDCLNT_E_EXCLUSIVE_MODE_ONLY = HRESULT(0x88890012);
enum HRESULT AUDCLNT_E_BUFDURATION_PERIOD_NOT_EQUAL = HRESULT(0x88890013);
enum HRESULT AUDCLNT_E_EVENTHANDLE_NOT_SET = HRESULT(0x88890014);
enum HRESULT AUDCLNT_E_INCORRECT_BUFFER_SIZE = HRESULT(0x88890015);
enum HRESULT AUDCLNT_E_BUFFER_SIZE_ERROR = HRESULT(0x88890016);
enum HRESULT AUDCLNT_E_CPUUSAGE_EXCEEDED = HRESULT(0x88890017);

enum : HRESULT
{
    AUDCLNT_E_BUFFER_ERROR            = HRESULT(0x88890018),
    AUDCLNT_E_BUFFER_SIZE_NOT_ALIGNED = HRESULT(0x88890019),
}

enum : HRESULT
{
    AUDCLNT_E_INVALID_DEVICE_PERIOD = HRESULT(0x88890020),
    AUDCLNT_E_INVALID_STREAM_FLAG   = HRESULT(0x88890021),
}

enum HRESULT AUDCLNT_E_ENDPOINT_OFFLOAD_NOT_CAPABLE = HRESULT(0x88890022);
enum HRESULT AUDCLNT_E_OUT_OF_OFFLOAD_RESOURCES = HRESULT(0x88890023);
enum HRESULT AUDCLNT_E_OFFLOAD_MODE_ONLY = HRESULT(0x88890024);
enum HRESULT AUDCLNT_E_NONOFFLOAD_MODE_ONLY = HRESULT(0x88890025);
enum HRESULT AUDCLNT_E_RESOURCES_INVALIDATED = HRESULT(0x88890026);
enum HRESULT AUDCLNT_E_RAW_MODE_UNSUPPORTED = HRESULT(0x88890027);

enum : HRESULT
{
    AUDCLNT_E_ENGINE_PERIODICITY_LOCKED = HRESULT(0x88890028),
    AUDCLNT_E_ENGINE_FORMAT_LOCKED      = HRESULT(0x88890029),
}

enum : HRESULT
{
    AUDCLNT_E_HEADTRACKING_ENABLED     = HRESULT(0x88890030),
    AUDCLNT_E_HEADTRACKING_UNSUPPORTED = HRESULT(0x88890040),
}

enum : HRESULT
{
    AUDCLNT_E_EFFECT_NOT_AVAILABLE   = HRESULT(0x88890041),
    AUDCLNT_E_EFFECT_STATE_READ_ONLY = HRESULT(0x88890042),
}

enum HRESULT AUDCLNT_E_POST_VOLUME_LOOPBACK_UNSUPPORTED = HRESULT(0x88890043);

enum : HRESULT
{
    AUDCLNT_S_BUFFER_EMPTY              = HRESULT(0x08890001),
    AUDCLNT_S_THREAD_ALREADY_REGISTERED = HRESULT(0x08890002),
}

enum HRESULT AUDCLNT_S_POSITION_STALLED = HRESULT(0x08890003);

enum : uint
{
    AUDCLNT_STREAMFLAGS_CROSSPROCESS        = 0x00010000,
    AUDCLNT_STREAMFLAGS_LOOPBACK            = 0x00020000,
    AUDCLNT_STREAMFLAGS_EVENTCALLBACK       = 0x00040000,
    AUDCLNT_STREAMFLAGS_NOPERSIST           = 0x00080000,
    AUDCLNT_STREAMFLAGS_RATEADJUST          = 0x00100000,
    AUDCLNT_STREAMFLAGS_SRC_DEFAULT_QUALITY = 0x08000000,
    AUDCLNT_STREAMFLAGS_AUTOCONVERTPCM      = 0x80000000,
}

enum : uint
{
    AUDCLNT_SESSIONFLAGS_EXPIREWHENUNOWNED       = 0x10000000,
    AUDCLNT_SESSIONFLAGS_DISPLAY_HIDE            = 0x20000000,
    AUDCLNT_SESSIONFLAGS_DISPLAY_HIDEWHENEXPIRED = 0x40000000,
}

enum : HRESULT
{
    SPTLAUDCLNT_E_DESTROYED             = HRESULT(0x88890100),
    SPTLAUDCLNT_E_OUT_OF_ORDER          = HRESULT(0x88890101),
    SPTLAUDCLNT_E_RESOURCES_INVALIDATED = HRESULT(0x88890102),
}

enum : HRESULT
{
    SPTLAUDCLNT_E_NO_MORE_OBJECTS        = HRESULT(0x88890103),
    SPTLAUDCLNT_E_PROPERTY_NOT_SUPPORTED = HRESULT(0x88890104),
}

enum HRESULT SPTLAUDCLNT_E_ERRORS_IN_OBJECT_CALLS = HRESULT(0x88890105);
enum HRESULT SPTLAUDCLNT_E_METADATA_FORMAT_NOT_SUPPORTED = HRESULT(0x88890106);

enum : HRESULT
{
    SPTLAUDCLNT_E_STREAM_NOT_AVAILABLE        = HRESULT(0x88890107),
    SPTLAUDCLNT_E_INVALID_LICENSE             = HRESULT(0x88890108),
    SPTLAUDCLNT_E_STREAM_NOT_STOPPED          = HRESULT(0x8889010a),
    SPTLAUDCLNT_E_STATIC_OBJECT_NOT_AVAILABLE = HRESULT(0x8889010b),
}

enum HRESULT SPTLAUDCLNT_E_OBJECT_ALREADY_ACTIVE = HRESULT(0x8889010c);
enum HRESULT SPTLAUDCLNT_E_INTERNAL = HRESULT(0x8889010d);
enum uint DEVICE_STATEMASK_ALL = 0x0000000f;

enum : /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/CoreAudio/pkey-audioendpoint-formfactor))], [])*/PROPERTYKEY
{
    PKEY_AudioEndpoint_FormFactor               = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/CoreAudio/pkey-audioendpoint-formfactor))], [])*/PROPERTYKEY(GUID("1DA5D803-D492-4EDD-8C23-E0C0FFEE7F0E"), 0),
    PKEY_AudioEndpoint_ControlPanelPageProvider = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/CoreAudio/pkey-audioendpoint-formfactor))], [])*/PROPERTYKEY(GUID("1DA5D803-D492-4EDD-8C23-E0C0FFEE7F0E"), 1),
    PKEY_AudioEndpoint_Association              = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/CoreAudio/pkey-audioendpoint-formfactor))], [])*/PROPERTYKEY(GUID("1DA5D803-D492-4EDD-8C23-E0C0FFEE7F0E"), 2),
    PKEY_AudioEndpoint_PhysicalSpeakers         = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/CoreAudio/pkey-audioendpoint-formfactor))], [])*/PROPERTYKEY(GUID("1DA5D803-D492-4EDD-8C23-E0C0FFEE7F0E"), 3),
    PKEY_AudioEndpoint_GUID                     = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/CoreAudio/pkey-audioendpoint-formfactor))], [])*/PROPERTYKEY(GUID("1DA5D803-D492-4EDD-8C23-E0C0FFEE7F0E"), 4),
    PKEY_AudioEndpoint_Disable_SysFx            = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/CoreAudio/pkey-audioendpoint-formfactor))], [])*/PROPERTYKEY(GUID("1DA5D803-D492-4EDD-8C23-E0C0FFEE7F0E"), 5),
}

enum : uint
{
    ENDPOINT_SYSFX_ENABLED  = 0x00000000,
    ENDPOINT_SYSFX_DISABLED = 0x00000001,
}

enum : /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/CoreAudio/pkey-audioendpoint-fullrangespeakers))], [])*/PROPERTYKEY
{
    PKEY_AudioEndpoint_FullRangeSpeakers         = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/CoreAudio/pkey-audioendpoint-fullrangespeakers))], [])*/PROPERTYKEY(GUID("1DA5D803-D492-4EDD-8C23-E0C0FFEE7F0E"), 6),
    PKEY_AudioEndpoint_Supports_EventDriven_Mode = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/CoreAudio/pkey-audioendpoint-fullrangespeakers))], [])*/PROPERTYKEY(GUID("1DA5D803-D492-4EDD-8C23-E0C0FFEE7F0E"), 7),
    PKEY_AudioEndpoint_JackSubType               = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/CoreAudio/pkey-audioendpoint-fullrangespeakers))], [])*/PROPERTYKEY(GUID("1DA5D803-D492-4EDD-8C23-E0C0FFEE7F0E"), 8),
    PKEY_AudioEndpoint_Default_VolumeInDb        = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/CoreAudio/pkey-audioendpoint-fullrangespeakers))], [])*/PROPERTYKEY(GUID("1DA5D803-D492-4EDD-8C23-E0C0FFEE7F0E"), 9),
    PKEY_AudioEndpoint_Max_VolumeInDb            = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/CoreAudio/pkey-audioendpoint-fullrangespeakers))], [])*/PROPERTYKEY(GUID("1DA5D803-D492-4EDD-8C23-E0C0FFEE7F0E"), 10),
    PKEY_AudioEndpoint_Min_VolumeInDb            = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/CoreAudio/pkey-audioendpoint-fullrangespeakers))], [])*/PROPERTYKEY(GUID("1DA5D803-D492-4EDD-8C23-E0C0FFEE7F0E"), 11),
}

enum : /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/CoreAudio/pkey-audioengine-deviceformat))], [])*/PROPERTYKEY
{
    PKEY_AudioEngine_DeviceFormat             = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/CoreAudio/pkey-audioengine-deviceformat))], [])*/PROPERTYKEY(GUID("F19F064D-082C-4E27-BC73-6882A1BB8E4C"), 0),
    PKEY_AudioEngine_OEMFormat                = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/CoreAudio/pkey-audioengine-deviceformat))], [])*/PROPERTYKEY(GUID("E4870E26-3CC5-4CD2-BA46-CA0A9A70ED04"), 3),
    PKEY_AudioEndpointLogo_IconEffects        = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/CoreAudio/pkey-audioengine-deviceformat))], [])*/PROPERTYKEY(GUID("F1AB780D-2010-4ED3-A3A6-8B87F0F0C476"), 0),
    PKEY_AudioEndpointLogo_IconPath           = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/CoreAudio/pkey-audioengine-deviceformat))], [])*/PROPERTYKEY(GUID("F1AB780D-2010-4ED3-A3A6-8B87F0F0C476"), 1),
    PKEY_AudioEndpointSettings_MenuText       = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/CoreAudio/pkey-audioengine-deviceformat))], [])*/PROPERTYKEY(GUID("14242002-0320-4DE4-9555-A7D82B73C286"), 0),
    PKEY_AudioEndpointSettings_LaunchContract = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/CoreAudio/pkey-audioengine-deviceformat))], [])*/PROPERTYKEY(GUID("14242002-0320-4DE4-9555-A7D82B73C286"), 1),
}

enum : GUID
{
    DEVINTERFACE_AUDIO_RENDER  = GUID("e6327cad-dcec-4949-ae8a-991e976a79d2"),
    DEVINTERFACE_AUDIO_CAPTURE = GUID("2eef81be-33fa-4800-9670-1cd474972c3f"),
    DEVINTERFACE_MIDI_OUTPUT   = GUID("6dc23320-ab33-4ce4-80d4-bbb3ebbf2814"),
    DEVINTERFACE_MIDI_INPUT    = GUID("504be32c-ccf6-4d2c-b73f-6f8b3747e22b"),
}

enum GUID EVENTCONTEXT_VOLUMESLIDER = GUID("e2c2e9de-09b1-4b04-84e5-07931225ee04");
enum uint SPATIAL_AUDIO_STANDARD_COMMANDS_START = 0x000000c8;
enum uint SPATIAL_AUDIO_POSITION = 0x000000c8;

enum : HRESULT
{
    SPTLAUD_MD_CLNT_E_COMMAND_NOT_FOUND           = HRESULT(0x88890200),
    SPTLAUD_MD_CLNT_E_OBJECT_NOT_INITIALIZED      = HRESULT(0x88890201),
    SPTLAUD_MD_CLNT_E_INVALID_ARGS                = HRESULT(0x88890202),
    SPTLAUD_MD_CLNT_E_METADATA_FORMAT_NOT_FOUND   = HRESULT(0x88890203),
    SPTLAUD_MD_CLNT_E_VALUE_BUFFER_INCORRECT_SIZE = HRESULT(0x88890204),
}

enum : HRESULT
{
    SPTLAUD_MD_CLNT_E_MEMORY_BOUNDS                 = HRESULT(0x88890205),
    SPTLAUD_MD_CLNT_E_NO_MORE_COMMANDS              = HRESULT(0x88890206),
    SPTLAUD_MD_CLNT_E_BUFFER_ALREADY_ATTACHED       = HRESULT(0x88890207),
    SPTLAUD_MD_CLNT_E_BUFFER_NOT_ATTACHED           = HRESULT(0x88890208),
    SPTLAUD_MD_CLNT_E_FRAMECOUNT_OUT_OF_RANGE       = HRESULT(0x88890209),
    SPTLAUD_MD_CLNT_E_NO_ITEMS_FOUND                = HRESULT(0x88890210),
    SPTLAUD_MD_CLNT_E_ITEM_COPY_OVERFLOW            = HRESULT(0x88890211),
    SPTLAUD_MD_CLNT_E_NO_ITEMS_OPEN                 = HRESULT(0x88890212),
    SPTLAUD_MD_CLNT_E_ITEMS_ALREADY_OPEN            = HRESULT(0x88890213),
    SPTLAUD_MD_CLNT_E_ATTACH_FAILED_INTERNAL_BUFFER = HRESULT(0x88890214),
}

enum HRESULT SPTLAUD_MD_CLNT_E_DETACH_FAILED_INTERNAL_BUFFER = HRESULT(0x88890215);

enum : HRESULT
{
    SPTLAUD_MD_CLNT_E_NO_BUFFER_ATTACHED       = HRESULT(0x88890216),
    SPTLAUD_MD_CLNT_E_NO_MORE_ITEMS            = HRESULT(0x88890217),
    SPTLAUD_MD_CLNT_E_FRAMEOFFSET_OUT_OF_RANGE = HRESULT(0x88890218),
    SPTLAUD_MD_CLNT_E_ITEM_MUST_HAVE_COMMANDS  = HRESULT(0x88890219),
    SPTLAUD_MD_CLNT_E_NO_ITEMOFFSET_WRITTEN    = HRESULT(0x88890220),
    SPTLAUD_MD_CLNT_E_NO_ITEMS_WRITTEN         = HRESULT(0x88890221),
    SPTLAUD_MD_CLNT_E_COMMAND_ALREADY_WRITTEN  = HRESULT(0x88890222),
    SPTLAUD_MD_CLNT_E_FORMAT_MISMATCH          = HRESULT(0x88890223),
    SPTLAUD_MD_CLNT_E_BUFFER_STILL_ATTACHED    = HRESULT(0x88890224),
    SPTLAUD_MD_CLNT_E_ITEMS_LOCKED_FOR_WRITING = HRESULT(0x88890225),
}

enum const(wchar)* VIRTUAL_AUDIO_DEVICE_PROCESS_LOOPBACK = "VAD\\Process_Loopback";

enum : uint
{
    WAVERR_BADFORMAT    = 0x00000020,
    WAVERR_STILLPLAYING = 0x00000021,
}

enum : uint
{
    WAVERR_UNPREPARED = 0x00000022,
    WAVERR_SYNC       = 0x00000023,
    WAVERR_LASTERROR  = 0x00000023,
}

enum : uint
{
    WHDR_DONE     = 0x00000001,
    WHDR_PREPARED = 0x00000002,
}

enum uint WHDR_BEGINLOOP = 0x00000004;

enum : uint
{
    WHDR_ENDLOOP = 0x00000008,
    WHDR_INQUEUE = 0x00000010,
}

enum : uint
{
    WAVECAPS_PITCH          = 0x00000001,
    WAVECAPS_PLAYBACKRATE   = 0x00000002,
    WAVECAPS_VOLUME         = 0x00000004,
    WAVECAPS_LRVOLUME       = 0x00000008,
    WAVECAPS_SYNC           = 0x00000010,
    WAVECAPS_SAMPLEACCURATE = 0x00000020,
}

enum uint WAVE_INVALIDFORMAT = 0x00000000;

enum : uint
{
    WAVE_FORMAT_1M08  = 0x00000001,
    WAVE_FORMAT_1S08  = 0x00000002,
    WAVE_FORMAT_1M16  = 0x00000004,
    WAVE_FORMAT_1S16  = 0x00000008,
    WAVE_FORMAT_2M08  = 0x00000010,
    WAVE_FORMAT_2S08  = 0x00000020,
    WAVE_FORMAT_2M16  = 0x00000040,
    WAVE_FORMAT_2S16  = 0x00000080,
    WAVE_FORMAT_4M08  = 0x00000100,
    WAVE_FORMAT_4S08  = 0x00000200,
    WAVE_FORMAT_4M16  = 0x00000400,
    WAVE_FORMAT_4S16  = 0x00000800,
    WAVE_FORMAT_44M08 = 0x00000100,
    WAVE_FORMAT_44S08 = 0x00000200,
    WAVE_FORMAT_44M16 = 0x00000400,
    WAVE_FORMAT_44S16 = 0x00000800,
    WAVE_FORMAT_48M08 = 0x00001000,
    WAVE_FORMAT_48S08 = 0x00002000,
    WAVE_FORMAT_48M16 = 0x00004000,
    WAVE_FORMAT_48S16 = 0x00008000,
    WAVE_FORMAT_96M08 = 0x00010000,
    WAVE_FORMAT_96S08 = 0x00020000,
    WAVE_FORMAT_96M16 = 0x00040000,
    WAVE_FORMAT_96S16 = 0x00080000,
    WAVE_FORMAT_PCM   = 0x00000001,
}

enum : uint
{
    MIDIERR_UNPREPARED   = 0x00000040,
    MIDIERR_STILLPLAYING = 0x00000041,
}

enum : uint
{
    MIDIERR_NOMAP        = 0x00000042,
    MIDIERR_NOTREADY     = 0x00000043,
    MIDIERR_NODEVICE     = 0x00000044,
    MIDIERR_INVALIDSETUP = 0x00000045,
}

enum : uint
{
    MIDIERR_BADOPENMODE   = 0x00000046,
    MIDIERR_DONT_CONTINUE = 0x00000047,
}

enum uint MIDIERR_LASTERROR = 0x00000047;
enum uint MIDIPATCHSIZE = 0x00000080;

enum : uint
{
    MIDI_CACHE_ALL     = 0x00000001,
    MIDI_CACHE_BESTFIT = 0x00000002,
    MIDI_CACHE_QUERY   = 0x00000003,
}

enum uint MIDI_UNCACHE = 0x00000004;
enum uint MOD_MIDIPORT = 0x00000001;

enum : uint
{
    MOD_SYNTH   = 0x00000002,
    MOD_SQSYNTH = 0x00000003,
}

enum uint MOD_FMSYNTH = 0x00000004;
enum uint MOD_MAPPER = 0x00000005;
enum uint MOD_WAVETABLE = 0x00000006;
enum uint MOD_SWSYNTH = 0x00000007;

enum : uint
{
    MIDICAPS_VOLUME   = 0x00000001,
    MIDICAPS_LRVOLUME = 0x00000002,
    MIDICAPS_CACHE    = 0x00000004,
    MIDICAPS_STREAM   = 0x00000008,
}

enum : uint
{
    MHDR_DONE     = 0x00000001,
    MHDR_PREPARED = 0x00000002,
}

enum : uint
{
    MHDR_INQUEUE = 0x00000004,
    MHDR_ISSTRM  = 0x00000008,
}

enum : int
{
    MEVT_F_SHORT    = 0x00000000,
    MEVT_F_LONG     = 0x80000000,
    MEVT_F_CALLBACK = 0x40000000,
}

enum ubyte MEVT_SHORTMSG = 0x00;

enum : ubyte
{
    MEVT_TEMPO   = 0x01,
    MEVT_NOP     = 0x02,
    MEVT_LONGMSG = 0x80,
    MEVT_COMMENT = 0x82,
    MEVT_VERSION = 0x84,
}

enum int MIDISTRM_ERROR = 0xfffffffe;

enum : int
{
    MIDIPROP_SET     = 0x80000000,
    MIDIPROP_GET     = 0x40000000,
    MIDIPROP_TIMEDIV = 0x00000001,
    MIDIPROP_TEMPO   = 0x00000002,
}

enum : uint
{
    AUXCAPS_CDAUDIO  = 0x00000001,
    AUXCAPS_AUXIN    = 0x00000002,
    AUXCAPS_VOLUME   = 0x00000001,
    AUXCAPS_LRVOLUME = 0x00000002,
}

enum uint MIXER_SHORT_NAME_CHARS = 0x00000010;
enum uint MIXER_LONG_NAME_CHARS = 0x00000040;

enum : uint
{
    MIXERR_INVALLINE    = 0x00000400,
    MIXERR_INVALCONTROL = 0x00000401,
    MIXERR_INVALVALUE   = 0x00000402,
    MIXERR_LASTERROR    = 0x00000402,
}

enum : int
{
    MIXER_OBJECTF_HANDLE  = 0x80000000,
    MIXER_OBJECTF_MIXER   = 0x00000000,
    MIXER_OBJECTF_WAVEOUT = 0x10000000,
    MIXER_OBJECTF_WAVEIN  = 0x20000000,
    MIXER_OBJECTF_MIDIOUT = 0x30000000,
    MIXER_OBJECTF_MIDIIN  = 0x40000000,
    MIXER_OBJECTF_AUX     = 0x50000000,
}

enum : int
{
    MIXERLINE_LINEF_ACTIVE            = 0x00000001,
    MIXERLINE_LINEF_DISCONNECTED      = 0x00008000,
    MIXERLINE_LINEF_SOURCE            = 0x80000000,
    MIXERLINE_COMPONENTTYPE_DST_FIRST = 0x00000000,
}

enum uint MIXERLINE_COMPONENTTYPE_DST_LAST = 0x00000008;
enum int MIXERLINE_COMPONENTTYPE_SRC_FIRST = 0x00001000;
enum uint MIXERLINE_COMPONENTTYPE_SRC_LAST = 0x0000100a;

enum : uint
{
    MIXERLINE_TARGETTYPE_UNDEFINED = 0x00000000,
    MIXERLINE_TARGETTYPE_WAVEOUT   = 0x00000001,
    MIXERLINE_TARGETTYPE_WAVEIN    = 0x00000002,
    MIXERLINE_TARGETTYPE_MIDIOUT   = 0x00000003,
    MIXERLINE_TARGETTYPE_MIDIIN    = 0x00000004,
    MIXERLINE_TARGETTYPE_AUX       = 0x00000005,
}

enum : int
{
    MIXER_GETLINEINFOF_DESTINATION   = 0x00000000,
    MIXER_GETLINEINFOF_SOURCE        = 0x00000001,
    MIXER_GETLINEINFOF_LINEID        = 0x00000002,
    MIXER_GETLINEINFOF_COMPONENTTYPE = 0x00000003,
    MIXER_GETLINEINFOF_TARGETTYPE    = 0x00000004,
    MIXER_GETLINEINFOF_QUERYMASK     = 0x0000000f,
}

enum : int
{
    MIXERCONTROL_CONTROLF_UNIFORM     = 0x00000001,
    MIXERCONTROL_CONTROLF_MULTIPLE    = 0x00000002,
    MIXERCONTROL_CONTROLF_DISABLED    = 0x80000000,
    MIXERCONTROL_CT_CLASS_MASK        = 0xf0000000,
    MIXERCONTROL_CT_CLASS_CUSTOM      = 0x00000000,
    MIXERCONTROL_CT_CLASS_METER       = 0x10000000,
    MIXERCONTROL_CT_CLASS_SWITCH      = 0x20000000,
    MIXERCONTROL_CT_CLASS_NUMBER      = 0x30000000,
    MIXERCONTROL_CT_CLASS_SLIDER      = 0x40000000,
    MIXERCONTROL_CT_CLASS_FADER       = 0x50000000,
    MIXERCONTROL_CT_CLASS_TIME        = 0x60000000,
    MIXERCONTROL_CT_CLASS_LIST        = 0x70000000,
    MIXERCONTROL_CT_SUBCLASS_MASK     = 0x0f000000,
    MIXERCONTROL_CT_SC_SWITCH_BOOLEAN = 0x00000000,
    MIXERCONTROL_CT_SC_SWITCH_BUTTON  = 0x01000000,
    MIXERCONTROL_CT_SC_METER_POLLED   = 0x00000000,
    MIXERCONTROL_CT_SC_TIME_MICROSECS = 0x00000000,
    MIXERCONTROL_CT_SC_TIME_MILLISECS = 0x01000000,
    MIXERCONTROL_CT_SC_LIST_SINGLE    = 0x00000000,
    MIXERCONTROL_CT_SC_LIST_MULTIPLE  = 0x01000000,
    MIXERCONTROL_CT_UNITS_MASK        = 0x00ff0000,
    MIXERCONTROL_CT_UNITS_CUSTOM      = 0x00000000,
    MIXERCONTROL_CT_UNITS_BOOLEAN     = 0x00010000,
    MIXERCONTROL_CT_UNITS_SIGNED      = 0x00020000,
    MIXERCONTROL_CT_UNITS_UNSIGNED    = 0x00030000,
    MIXERCONTROL_CT_UNITS_DECIBELS    = 0x00040000,
    MIXERCONTROL_CT_UNITS_PERCENT     = 0x00050000,
}

enum : int
{
    MIXER_GETLINECONTROLSF_ALL       = 0x00000000,
    MIXER_GETLINECONTROLSF_ONEBYID   = 0x00000001,
    MIXER_GETLINECONTROLSF_ONEBYTYPE = 0x00000002,
    MIXER_GETLINECONTROLSF_QUERYMASK = 0x0000000f,
}

enum : int
{
    MIXER_GETCONTROLDETAILSF_VALUE     = 0x00000000,
    MIXER_GETCONTROLDETAILSF_LISTTEXT  = 0x00000001,
    MIXER_GETCONTROLDETAILSF_QUERYMASK = 0x0000000f,
}

enum : int
{
    MIXER_SETCONTROLDETAILSF_VALUE     = 0x00000000,
    MIXER_SETCONTROLDETAILSF_CUSTOM    = 0x00000001,
    MIXER_SETCONTROLDETAILSF_QUERYMASK = 0x0000000f,
}

enum : uint
{
    DRV_MAPPER_PREFERRED_INPUT_GET  = 0x00004000,
    DRV_MAPPER_PREFERRED_OUTPUT_GET = 0x00004002,
}

enum : uint
{
    DRVM_MAPPER        = 0x00002000,
    DRVM_MAPPER_STATUS = 0x00002000,
}

enum uint WIDM_MAPPER_STATUS = 0x00002000;

enum : uint
{
    WAVEIN_MAPPER_STATUS_DEVICE = 0x00000000,
    WAVEIN_MAPPER_STATUS_MAPPED = 0x00000001,
    WAVEIN_MAPPER_STATUS_FORMAT = 0x00000002,
}

enum uint WODM_MAPPER_STATUS = 0x00002000;

enum : uint
{
    WAVEOUT_MAPPER_STATUS_DEVICE = 0x00000000,
    WAVEOUT_MAPPER_STATUS_MAPPED = 0x00000001,
    WAVEOUT_MAPPER_STATUS_FORMAT = 0x00000002,
}

enum : uint
{
    ACMERR_BASE        = 0x00000200,
    ACMERR_NOTPOSSIBLE = 0x00000200,
}

enum : uint
{
    ACMERR_BUSY       = 0x00000201,
    ACMERR_UNPREPARED = 0x00000202,
    ACMERR_CANCELED   = 0x00000203,
}

enum : uint
{
    ACM_METRIC_COUNT_DRIVERS          = 0x00000001,
    ACM_METRIC_COUNT_CODECS           = 0x00000002,
    ACM_METRIC_COUNT_CONVERTERS       = 0x00000003,
    ACM_METRIC_COUNT_FILTERS          = 0x00000004,
    ACM_METRIC_COUNT_DISABLED         = 0x00000005,
    ACM_METRIC_COUNT_HARDWARE         = 0x00000006,
    ACM_METRIC_COUNT_LOCAL_DRIVERS    = 0x00000014,
    ACM_METRIC_COUNT_LOCAL_CODECS     = 0x00000015,
    ACM_METRIC_COUNT_LOCAL_CONVERTERS = 0x00000016,
    ACM_METRIC_COUNT_LOCAL_FILTERS    = 0x00000017,
    ACM_METRIC_COUNT_LOCAL_DISABLED   = 0x00000018,
}

enum : uint
{
    ACM_METRIC_HARDWARE_WAVE_INPUT  = 0x0000001e,
    ACM_METRIC_HARDWARE_WAVE_OUTPUT = 0x0000001f,
}

enum : uint
{
    ACM_METRIC_MAX_SIZE_FORMAT = 0x00000032,
    ACM_METRIC_MAX_SIZE_FILTER = 0x00000033,
    ACM_METRIC_DRIVER_SUPPORT  = 0x00000064,
    ACM_METRIC_DRIVER_PRIORITY = 0x00000065,
}

enum : int
{
    ACM_DRIVERENUMF_NOLOCAL   = 0x40000000,
    ACM_DRIVERENUMF_DISABLED  = 0x80000000,
    ACM_DRIVERADDF_NAME       = 0x00000001,
    ACM_DRIVERADDF_FUNCTION   = 0x00000003,
    ACM_DRIVERADDF_NOTIFYHWND = 0x00000004,
    ACM_DRIVERADDF_TYPEMASK   = 0x00000007,
    ACM_DRIVERADDF_LOCAL      = 0x00000000,
    ACM_DRIVERADDF_GLOBAL     = 0x00000008,
}

enum : uint
{
    ACMDM_USER          = 0x00004000,
    ACMDM_RESERVED_LOW  = 0x00006000,
    ACMDM_RESERVED_HIGH = 0x00006fff,
}

enum uint ACMDM_DRIVER_ABOUT = 0x0000600b;

enum : int
{
    ACM_DRIVERPRIORITYF_ENABLE    = 0x00000001,
    ACM_DRIVERPRIORITYF_DISABLE   = 0x00000002,
    ACM_DRIVERPRIORITYF_ABLEMASK  = 0x00000003,
    ACM_DRIVERPRIORITYF_BEGIN     = 0x00010000,
    ACM_DRIVERPRIORITYF_END       = 0x00020000,
    ACM_DRIVERPRIORITYF_DEFERMASK = 0x00030000,
}

enum : uint
{
    ACMDRIVERDETAILS_SHORTNAME_CHARS = 0x00000020,
    ACMDRIVERDETAILS_LONGNAME_CHARS  = 0x00000080,
    ACMDRIVERDETAILS_COPYRIGHT_CHARS = 0x00000050,
    ACMDRIVERDETAILS_LICENSING_CHARS = 0x00000080,
    ACMDRIVERDETAILS_FEATURES_CHARS  = 0x00000200,
}

enum : int
{
    ACMDRIVERDETAILS_SUPPORTF_CODEC     = 0x00000001,
    ACMDRIVERDETAILS_SUPPORTF_CONVERTER = 0x00000002,
    ACMDRIVERDETAILS_SUPPORTF_FILTER    = 0x00000004,
    ACMDRIVERDETAILS_SUPPORTF_HARDWARE  = 0x00000008,
    ACMDRIVERDETAILS_SUPPORTF_ASYNC     = 0x00000010,
    ACMDRIVERDETAILS_SUPPORTF_LOCAL     = 0x40000000,
    ACMDRIVERDETAILS_SUPPORTF_DISABLED  = 0x80000000,
}

enum uint ACMFORMATTAGDETAILS_FORMATTAG_CHARS = 0x00000030;

enum : int
{
    ACM_FORMATTAGDETAILSF_INDEX       = 0x00000000,
    ACM_FORMATTAGDETAILSF_FORMATTAG   = 0x00000001,
    ACM_FORMATTAGDETAILSF_LARGESTSIZE = 0x00000002,
    ACM_FORMATTAGDETAILSF_QUERYMASK   = 0x0000000f,
}

enum uint ACMFORMATDETAILS_FORMAT_CHARS = 0x00000080;

enum : int
{
    ACM_FORMATDETAILSF_INDEX     = 0x00000000,
    ACM_FORMATDETAILSF_FORMAT    = 0x00000001,
    ACM_FORMATDETAILSF_QUERYMASK = 0x0000000f,
}

enum : int
{
    ACM_FORMATENUMF_WFORMATTAG        = 0x00010000,
    ACM_FORMATENUMF_NCHANNELS         = 0x00020000,
    ACM_FORMATENUMF_NSAMPLESPERSEC    = 0x00040000,
    ACM_FORMATENUMF_WBITSPERSAMPLE    = 0x00080000,
    ACM_FORMATENUMF_CONVERT           = 0x00100000,
    ACM_FORMATENUMF_SUGGEST           = 0x00200000,
    ACM_FORMATENUMF_HARDWARE          = 0x00400000,
    ACM_FORMATENUMF_INPUT             = 0x00800000,
    ACM_FORMATENUMF_OUTPUT            = 0x01000000,
    ACM_FORMATSUGGESTF_WFORMATTAG     = 0x00010000,
    ACM_FORMATSUGGESTF_NCHANNELS      = 0x00020000,
    ACM_FORMATSUGGESTF_NSAMPLESPERSEC = 0x00040000,
    ACM_FORMATSUGGESTF_WBITSPERSAMPLE = 0x00080000,
    ACM_FORMATSUGGESTF_TYPEMASK       = 0x00ff0000,
}

enum : /*FIELD ATTR: NativeEncodingAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ansi))], [])*/const(wchar)*
{
    ACMHELPMSGSTRINGA      = "acmchoose_help",
    ACMHELPMSGSTRINGW      = "acmchoose_help",
    ACMHELPMSGCONTEXTMENUA = "acmchoose_contextmenu",
    ACMHELPMSGCONTEXTMENUW = "acmchoose_contextmenu",
    ACMHELPMSGCONTEXTHELPA = "acmchoose_contexthelp",
    ACMHELPMSGCONTEXTHELPW = "acmchoose_contexthelp",
    ACMHELPMSGSTRING       = "acmchoose_help",
    ACMHELPMSGCONTEXTMENU  = "acmchoose_contextmenu",
    ACMHELPMSGCONTEXTHELP  = "acmchoose_contexthelp",
}

enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Multimedia/mm-acm-formatchoose))], [])*/uint MM_ACM_FORMATCHOOSE = 0x00008000;

enum : uint
{
    FORMATCHOOSE_MESSAGE          = 0x00000000,
    FORMATCHOOSE_FORMATTAG_VERIFY = 0x00000000,
    FORMATCHOOSE_FORMAT_VERIFY    = 0x00000001,
    FORMATCHOOSE_CUSTOM_VERIFY    = 0x00000002,
}

enum : int
{
    ACMFORMATCHOOSE_STYLEF_SHOWHELP             = 0x00000004,
    ACMFORMATCHOOSE_STYLEF_ENABLEHOOK           = 0x00000008,
    ACMFORMATCHOOSE_STYLEF_ENABLETEMPLATE       = 0x00000010,
    ACMFORMATCHOOSE_STYLEF_ENABLETEMPLATEHANDLE = 0x00000020,
    ACMFORMATCHOOSE_STYLEF_INITTOWFXSTRUCT      = 0x00000040,
    ACMFORMATCHOOSE_STYLEF_CONTEXTHELP          = 0x00000080,
}

enum uint ACMFILTERTAGDETAILS_FILTERTAG_CHARS = 0x00000030;

enum : int
{
    ACM_FILTERTAGDETAILSF_INDEX       = 0x00000000,
    ACM_FILTERTAGDETAILSF_FILTERTAG   = 0x00000001,
    ACM_FILTERTAGDETAILSF_LARGESTSIZE = 0x00000002,
    ACM_FILTERTAGDETAILSF_QUERYMASK   = 0x0000000f,
}

enum uint ACMFILTERDETAILS_FILTER_CHARS = 0x00000080;

enum : int
{
    ACM_FILTERDETAILSF_INDEX     = 0x00000000,
    ACM_FILTERDETAILSF_FILTER    = 0x00000001,
    ACM_FILTERDETAILSF_QUERYMASK = 0x0000000f,
}

enum int ACM_FILTERENUMF_DWFILTERTAG = 0x00010000;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Multimedia/mm-acm-filterchoose))], [])*/uint MM_ACM_FILTERCHOOSE = 0x00008000;

enum : uint
{
    FILTERCHOOSE_MESSAGE          = 0x00000000,
    FILTERCHOOSE_FILTERTAG_VERIFY = 0x00000000,
    FILTERCHOOSE_FILTER_VERIFY    = 0x00000001,
    FILTERCHOOSE_CUSTOM_VERIFY    = 0x00000002,
}

enum : int
{
    ACMFILTERCHOOSE_STYLEF_SHOWHELP             = 0x00000004,
    ACMFILTERCHOOSE_STYLEF_ENABLEHOOK           = 0x00000008,
    ACMFILTERCHOOSE_STYLEF_ENABLETEMPLATE       = 0x00000010,
    ACMFILTERCHOOSE_STYLEF_ENABLETEMPLATEHANDLE = 0x00000020,
    ACMFILTERCHOOSE_STYLEF_INITTOFILTERSTRUCT   = 0x00000040,
    ACMFILTERCHOOSE_STYLEF_CONTEXTHELP          = 0x00000080,
}

enum : int
{
    ACMSTREAMHEADER_STATUSF_DONE     = 0x00010000,
    ACMSTREAMHEADER_STATUSF_PREPARED = 0x00020000,
    ACMSTREAMHEADER_STATUSF_INQUEUE  = 0x00100000,
}

enum : uint
{
    ACM_STREAMOPENF_QUERY       = 0x00000001,
    ACM_STREAMOPENF_ASYNC       = 0x00000002,
    ACM_STREAMOPENF_NONREALTIME = 0x00000004,
}

enum : int
{
    ACM_STREAMSIZEF_SOURCE      = 0x00000000,
    ACM_STREAMSIZEF_DESTINATION = 0x00000001,
    ACM_STREAMSIZEF_QUERYMASK   = 0x0000000f,
}

enum : uint
{
    ACM_STREAMCONVERTF_BLOCKALIGN = 0x00000004,
    ACM_STREAMCONVERTF_START      = 0x00000010,
    ACM_STREAMCONVERTF_END        = 0x00000020,
}

enum int SND_RING = 0x00100000;
enum uint SND_ALIAS_START = 0x00000000;

enum : uint
{
    ACMDM_DRIVER_NOTIFY  = 0x00006001,
    ACMDM_DRIVER_DETAILS = 0x0000600a,
}

enum : uint
{
    ACMDM_HARDWARE_WAVE_CAPS_INPUT  = 0x00006014,
    ACMDM_HARDWARE_WAVE_CAPS_OUTPUT = 0x00006015,
}

enum : uint
{
    ACMDM_FORMATTAG_DETAILS = 0x00006019,
    ACMDM_FORMAT_DETAILS    = 0x0000601a,
    ACMDM_FORMAT_SUGGEST    = 0x0000601b,
}

enum : uint
{
    ACMDM_FILTERTAG_DETAILS = 0x00006032,
    ACMDM_FILTER_DETAILS    = 0x00006033,
}

enum : uint
{
    ACMDM_STREAM_OPEN      = 0x0000604c,
    ACMDM_STREAM_CLOSE     = 0x0000604d,
    ACMDM_STREAM_SIZE      = 0x0000604e,
    ACMDM_STREAM_CONVERT   = 0x0000604f,
    ACMDM_STREAM_RESET     = 0x00006050,
    ACMDM_STREAM_PREPARE   = 0x00006051,
    ACMDM_STREAM_UNPREPARE = 0x00006052,
    ACMDM_STREAM_UPDATE    = 0x00006053,
}

// Callbacks

alias LPWAVECALLBACK = void function(HDRVR hdrvr, uint uMsg, size_t dwUser, size_t dw1, size_t dw2);
alias LPMIDICALLBACK = void function(HDRVR hdrvr, uint uMsg, size_t dwUser, size_t dw1, size_t dw2);
alias PAudioStateMonitorCallback = void function(IAudioStateMonitor audioStateMonitor, void* context);
alias ACMDRIVERENUMCB = BOOL function(HACMDRIVERID hadid, size_t dwInstance, uint fdwSupport);
alias LPACMDRIVERPROC = LRESULT function(size_t param0, HACMDRIVERID param1, uint param2, LPARAM param3, 
                                         LPARAM param4);
//DELEGATE ATTR: AnsiAttribute : CustomAttributeSig([], [])
alias ACMFORMATTAGENUMCBA = BOOL function(HACMDRIVERID hadid, ACMFORMATTAGDETAILSA* paftd, size_t dwInstance, 
                                          uint fdwSupport);
//DELEGATE ATTR: UnicodeAttribute : CustomAttributeSig([], [])
alias ACMFORMATTAGENUMCBW = BOOL function(HACMDRIVERID hadid, ACMFORMATTAGDETAILSW* paftd, size_t dwInstance, 
                                          uint fdwSupport);
//DELEGATE ATTR: AnsiAttribute : CustomAttributeSig([], [])
alias ACMFORMATENUMCBA = BOOL function(HACMDRIVERID hadid, ACMFORMATDETAILSA* pafd, size_t dwInstance, 
                                       uint fdwSupport);
//DELEGATE ATTR: UnicodeAttribute : CustomAttributeSig([], [])
alias ACMFORMATENUMCBW = BOOL function(HACMDRIVERID hadid, tACMFORMATDETAILSW* pafd, size_t dwInstance, 
                                       uint fdwSupport);
//DELEGATE ATTR: AnsiAttribute : CustomAttributeSig([], [])
alias ACMFORMATCHOOSEHOOKPROCA = uint function(HWND hwnd, uint uMsg, WPARAM wParam, LPARAM lParam);
//DELEGATE ATTR: UnicodeAttribute : CustomAttributeSig([], [])
alias ACMFORMATCHOOSEHOOKPROCW = uint function(HWND hwnd, uint uMsg, WPARAM wParam, LPARAM lParam);
//DELEGATE ATTR: AnsiAttribute : CustomAttributeSig([], [])
alias ACMFILTERTAGENUMCBA = BOOL function(HACMDRIVERID hadid, ACMFILTERTAGDETAILSA* paftd, size_t dwInstance, 
                                          uint fdwSupport);
//DELEGATE ATTR: UnicodeAttribute : CustomAttributeSig([], [])
alias ACMFILTERTAGENUMCBW = BOOL function(HACMDRIVERID hadid, ACMFILTERTAGDETAILSW* paftd, size_t dwInstance, 
                                          uint fdwSupport);
//DELEGATE ATTR: AnsiAttribute : CustomAttributeSig([], [])
alias ACMFILTERENUMCBA = BOOL function(HACMDRIVERID hadid, ACMFILTERDETAILSA* pafd, size_t dwInstance, 
                                       uint fdwSupport);
//DELEGATE ATTR: UnicodeAttribute : CustomAttributeSig([], [])
alias ACMFILTERENUMCBW = BOOL function(HACMDRIVERID hadid, ACMFILTERDETAILSW* pafd, size_t dwInstance, 
                                       uint fdwSupport);
//DELEGATE ATTR: AnsiAttribute : CustomAttributeSig([], [])
alias ACMFILTERCHOOSEHOOKPROCA = uint function(HWND hwnd, uint uMsg, WPARAM wParam, LPARAM lParam);
//DELEGATE ATTR: UnicodeAttribute : CustomAttributeSig([], [])
alias ACMFILTERCHOOSEHOOKPROCW = uint function(HWND hwnd, uint uMsg, WPARAM wParam, LPARAM lParam);

// Structs


//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/endpointvolume/ns-endpointvolume-audio_volume_notification_data))], [])
struct AUDIO_VOLUME_NOTIFICATION_DATA
{
    GUID  guidEventContext;
    BOOL  bMuted;
    float fMasterVolume;
    uint  nChannels;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/float[1] afChannelVolumes;
}

//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HMIDI
{
    void* Value;
}

@RAIIFree!midiInClose
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HMIDIIN
{
    void* Value;
}

@RAIIFree!midiOutClose
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HMIDIOUT
{
    void* Value;
}

@RAIIFree!midiStreamClose
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HMIDISTRM
{
    void* Value;
}

@RAIIFree!mixerClose
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HMIXER
{
    void* Value;
}

//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HMIXEROBJ
{
    void* Value;
}

//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HWAVE
{
    void* Value;
}

@RAIIFree!waveOutClose
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HWAVEOUT
{
    void* Value;
}

@RAIIFree!waveInClose
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HWAVEIN
{
    void* Value;
}

//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HACMDRIVERID
{
    void* Value;
}

@RAIIFree!acmDriverClose
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HACMDRIVER
{
    void* Value;
}

@RAIIFree!acmStreamClose
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HACMSTREAM
{
    void* Value;
}

//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HACMOBJ
{
    void* Value;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmreg/ns-mmreg-waveformatextensible))], [])
struct WAVEFORMATEXTENSIBLE
{
align (1):
    WAVEFORMATEX      Format;
    _Samples_e__Union Samples;
    uint              dwChannelMask;
    GUID              SubFormat;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmreg/ns-mmreg-wavefilter))], [])
struct WAVEFILTER
{
align (1):
    uint    cbStruct;
    uint    dwFilterTag;
    uint    fdwFilter;
    uint[5] dwReserved;
}

struct VOLUMEWAVEFILTER
{
align (1):
    WAVEFILTER wfltr;
    uint       dwVolume;
}

struct ECHOWAVEFILTER
{
align (1):
    WAVEFILTER wfltr;
    uint       dwVolume;
    uint       dwDelay;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msacm/ns-msacm-acmstreamheader))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(6))], [])
struct ACMSTREAMHEADER
{
align (1):
    uint     cbStruct;
    uint     fdwStatus;
    size_t   dwUser;
    ubyte*   pbSrc;
    uint     cbSrcLength;
    uint     cbSrcLengthUsed;
    size_t   dwSrcUser;
    ubyte*   pbDst;
    uint     cbDstLength;
    uint     cbDstLengthUsed;
    size_t   dwDstUser;
    uint[15] dwReservedDriver;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmeapi/ns-mmeapi-wavehdr))], [])
struct WAVEHDR
{
align (1):
    /*FIELD ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PSTR lpData;
    uint     dwBufferLength;
    uint     dwBytesRecorded;
    size_t   dwUser;
    uint     dwFlags;
    uint     dwLoops;
    WAVEHDR* lpNext;
    size_t   reserved;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmeapi/ns-mmeapi-waveoutcapsa))], [])
struct WAVEOUTCAPSA
{
align (1):
    ushort   wMid;
    ushort   wPid;
    uint     vDriverVersion;
    CHAR[32] szPname;
    uint     dwFormats;
    ushort   wChannels;
    ushort   wReserved1;
    uint     dwSupport;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmeapi/ns-mmeapi-waveoutcapsw))], [])
struct WAVEOUTCAPSW
{
align (1):
    ushort    wMid;
    ushort    wPid;
    uint      vDriverVersion;
    wchar[32] szPname;
    uint      dwFormats;
    ushort    wChannels;
    ushort    wReserved1;
    uint      dwSupport;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
struct WAVEOUTCAPS2A
{
align (1):
    ushort   wMid;
    ushort   wPid;
    uint     vDriverVersion;
    CHAR[32] szPname;
    uint     dwFormats;
    ushort   wChannels;
    ushort   wReserved1;
    uint     dwSupport;
    GUID     ManufacturerGuid;
    GUID     ProductGuid;
    GUID     NameGuid;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
struct WAVEOUTCAPS2W
{
align (1):
    ushort    wMid;
    ushort    wPid;
    uint      vDriverVersion;
    wchar[32] szPname;
    uint      dwFormats;
    ushort    wChannels;
    ushort    wReserved1;
    uint      dwSupport;
    GUID      ManufacturerGuid;
    GUID      ProductGuid;
    GUID      NameGuid;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmeapi/ns-mmeapi-waveincapsa))], [])
struct WAVEINCAPSA
{
align (1):
    ushort   wMid;
    ushort   wPid;
    uint     vDriverVersion;
    CHAR[32] szPname;
    uint     dwFormats;
    ushort   wChannels;
    ushort   wReserved1;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmeapi/ns-mmeapi-waveincapsw))], [])
struct WAVEINCAPSW
{
align (1):
    ushort    wMid;
    ushort    wPid;
    uint      vDriverVersion;
    wchar[32] szPname;
    uint      dwFormats;
    ushort    wChannels;
    ushort    wReserved1;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
struct WAVEINCAPS2A
{
align (1):
    ushort   wMid;
    ushort   wPid;
    uint     vDriverVersion;
    CHAR[32] szPname;
    uint     dwFormats;
    ushort   wChannels;
    ushort   wReserved1;
    GUID     ManufacturerGuid;
    GUID     ProductGuid;
    GUID     NameGuid;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
struct WAVEINCAPS2W
{
align (1):
    ushort    wMid;
    ushort    wPid;
    uint      vDriverVersion;
    wchar[32] szPname;
    uint      dwFormats;
    ushort    wChannels;
    ushort    wReserved1;
    GUID      ManufacturerGuid;
    GUID      ProductGuid;
    GUID      NameGuid;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmeapi/ns-mmeapi-waveformat))], [])
struct WAVEFORMAT
{
align (1):
    ushort wFormatTag;
    ushort nChannels;
    uint   nSamplesPerSec;
    uint   nAvgBytesPerSec;
    ushort nBlockAlign;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmeapi/ns-mmeapi-pcmwaveformat))], [])
struct PCMWAVEFORMAT
{
align (1):
    WAVEFORMAT wf;
    ushort     wBitsPerSample;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmeapi/ns-mmeapi-waveformatex))], [])
struct WAVEFORMATEX
{
align (1):
    ushort wFormatTag;
    ushort nChannels;
    uint   nSamplesPerSec;
    uint   nAvgBytesPerSec;
    ushort nBlockAlign;
    ushort wBitsPerSample;
    ushort cbSize;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmeapi/ns-mmeapi-midioutcapsa))], [])
struct MIDIOUTCAPSA
{
align (1):
    ushort   wMid;
    ushort   wPid;
    uint     vDriverVersion;
    CHAR[32] szPname;
    ushort   wTechnology;
    ushort   wVoices;
    ushort   wNotes;
    ushort   wChannelMask;
    uint     dwSupport;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmeapi/ns-mmeapi-midioutcapsw))], [])
struct MIDIOUTCAPSW
{
align (1):
    ushort    wMid;
    ushort    wPid;
    uint      vDriverVersion;
    wchar[32] szPname;
    ushort    wTechnology;
    ushort    wVoices;
    ushort    wNotes;
    ushort    wChannelMask;
    uint      dwSupport;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
struct MIDIOUTCAPS2A
{
align (1):
    ushort   wMid;
    ushort   wPid;
    uint     vDriverVersion;
    CHAR[32] szPname;
    ushort   wTechnology;
    ushort   wVoices;
    ushort   wNotes;
    ushort   wChannelMask;
    uint     dwSupport;
    GUID     ManufacturerGuid;
    GUID     ProductGuid;
    GUID     NameGuid;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
struct MIDIOUTCAPS2W
{
align (1):
    ushort    wMid;
    ushort    wPid;
    uint      vDriverVersion;
    wchar[32] szPname;
    ushort    wTechnology;
    ushort    wVoices;
    ushort    wNotes;
    ushort    wChannelMask;
    uint      dwSupport;
    GUID      ManufacturerGuid;
    GUID      ProductGuid;
    GUID      NameGuid;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmeapi/ns-mmeapi-midiincapsa))], [])
struct MIDIINCAPSA
{
align (1):
    ushort   wMid;
    ushort   wPid;
    uint     vDriverVersion;
    CHAR[32] szPname;
    uint     dwSupport;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmeapi/ns-mmeapi-midiincapsw))], [])
struct MIDIINCAPSW
{
align (1):
    ushort    wMid;
    ushort    wPid;
    uint      vDriverVersion;
    wchar[32] szPname;
    uint      dwSupport;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
struct MIDIINCAPS2A
{
align (1):
    ushort   wMid;
    ushort   wPid;
    uint     vDriverVersion;
    CHAR[32] szPname;
    uint     dwSupport;
    GUID     ManufacturerGuid;
    GUID     ProductGuid;
    GUID     NameGuid;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
struct MIDIINCAPS2W
{
align (1):
    ushort    wMid;
    ushort    wPid;
    uint      vDriverVersion;
    wchar[32] szPname;
    uint      dwSupport;
    GUID      ManufacturerGuid;
    GUID      ProductGuid;
    GUID      NameGuid;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmeapi/ns-mmeapi-midihdr))], [])
struct MIDIHDR
{
align (1):
    PSTR      lpData;
    uint      dwBufferLength;
    uint      dwBytesRecorded;
    size_t    dwUser;
    uint      dwFlags;
    MIDIHDR*  lpNext;
    size_t    reserved;
    uint      dwOffset;
    size_t[8] dwReserved;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmeapi/ns-mmeapi-midievent))], [])
struct MIDIEVENT
{
align (1):
    uint dwDeltaTime;
    uint dwStreamID;
    uint dwEvent;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/uint[1] dwParms;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmeapi/ns-mmeapi-midistrmbuffver))], [])
struct MIDISTRMBUFFVER
{
align (1):
    uint dwVersion;
    uint dwMid;
    uint dwOEMVersion;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmeapi/ns-mmeapi-midiproptimediv))], [])
struct MIDIPROPTIMEDIV
{
align (1):
    uint cbStruct;
    uint dwTimeDiv;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmeapi/ns-mmeapi-midiproptempo))], [])
struct MIDIPROPTEMPO
{
align (1):
    uint cbStruct;
    uint dwTempo;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmeapi/ns-mmeapi-auxcapsa))], [])
struct AUXCAPSA
{
align (1):
    ushort   wMid;
    ushort   wPid;
    uint     vDriverVersion;
    CHAR[32] szPname;
    ushort   wTechnology;
    ushort   wReserved1;
    uint     dwSupport;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmeapi/ns-mmeapi-auxcapsw))], [])
struct AUXCAPSW
{
align (1):
    ushort    wMid;
    ushort    wPid;
    uint      vDriverVersion;
    wchar[32] szPname;
    ushort    wTechnology;
    ushort    wReserved1;
    uint      dwSupport;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
struct AUXCAPS2A
{
align (1):
    ushort   wMid;
    ushort   wPid;
    uint     vDriverVersion;
    CHAR[32] szPname;
    ushort   wTechnology;
    ushort   wReserved1;
    uint     dwSupport;
    GUID     ManufacturerGuid;
    GUID     ProductGuid;
    GUID     NameGuid;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
struct AUXCAPS2W
{
align (1):
    ushort    wMid;
    ushort    wPid;
    uint      vDriverVersion;
    wchar[32] szPname;
    ushort    wTechnology;
    ushort    wReserved1;
    uint      dwSupport;
    GUID      ManufacturerGuid;
    GUID      ProductGuid;
    GUID      NameGuid;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmeapi/ns-mmeapi-mixercapsa))], [])
struct MIXERCAPSA
{
align (1):
    ushort   wMid;
    ushort   wPid;
    uint     vDriverVersion;
    CHAR[32] szPname;
    uint     fdwSupport;
    uint     cDestinations;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmeapi/ns-mmeapi-mixercapsw))], [])
struct MIXERCAPSW
{
align (1):
    ushort    wMid;
    ushort    wPid;
    uint      vDriverVersion;
    wchar[32] szPname;
    uint      fdwSupport;
    uint      cDestinations;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
struct MIXERCAPS2A
{
align (1):
    ushort   wMid;
    ushort   wPid;
    uint     vDriverVersion;
    CHAR[32] szPname;
    uint     fdwSupport;
    uint     cDestinations;
    GUID     ManufacturerGuid;
    GUID     ProductGuid;
    GUID     NameGuid;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
struct MIXERCAPS2W
{
align (1):
    ushort    wMid;
    ushort    wPid;
    uint      vDriverVersion;
    wchar[32] szPname;
    uint      fdwSupport;
    uint      cDestinations;
    GUID      ManufacturerGuid;
    GUID      ProductGuid;
    GUID      NameGuid;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmeapi/ns-mmeapi-mixerlinea))], [])
struct MIXERLINEA
{
align (1):
    uint              cbStruct;
    uint              dwDestination;
    uint              dwSource;
    uint              dwLineID;
    uint              fdwLine;
    size_t            dwUser;
    MIXERLINE_COMPONENTTYPE dwComponentType;
    uint              cChannels;
    uint              cConnections;
    uint              cControls;
    CHAR[16]          szShortName;
    CHAR[64]          szName;
    _Target_e__Struct Target;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmeapi/ns-mmeapi-mixerlinew))], [])
struct MIXERLINEW
{
align (1):
    uint              cbStruct;
    uint              dwDestination;
    uint              dwSource;
    uint              dwLineID;
    uint              fdwLine;
    size_t            dwUser;
    MIXERLINE_COMPONENTTYPE dwComponentType;
    uint              cChannels;
    uint              cConnections;
    uint              cControls;
    wchar[16]         szShortName;
    wchar[64]         szName;
    _Target_e__Struct Target;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmeapi/ns-mmeapi-mixercontrola))], [])
struct MIXERCONTROLA
{
align (1):
    uint              cbStruct;
    uint              dwControlID;
    uint              dwControlType;
    uint              fdwControl;
    uint              cMultipleItems;
    CHAR[16]          szShortName;
    CHAR[64]          szName;
    _Bounds_e__Union  Bounds;
    _Metrics_e__Union Metrics;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmeapi/ns-mmeapi-mixercontrolw))], [])
struct MIXERCONTROLW
{
align (1):
    uint              cbStruct;
    uint              dwControlID;
    uint              dwControlType;
    uint              fdwControl;
    uint              cMultipleItems;
    wchar[16]         szShortName;
    wchar[64]         szName;
    _Bounds_e__Union  Bounds;
    _Metrics_e__Union Metrics;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmeapi/ns-mmeapi-mixerlinecontrolsa))], [])
struct MIXERLINECONTROLSA
{
align (1):
    uint                cbStruct;
    uint                dwLineID;
    _Anonymous_e__Union Anonymous;
    uint                cControls;
    uint                cbmxctrl;
    MIXERCONTROLA*      pamxctrl;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmeapi/ns-mmeapi-mixerlinecontrolsw))], [])
struct MIXERLINECONTROLSW
{
align (1):
    uint                cbStruct;
    uint                dwLineID;
    _Anonymous_e__Union Anonymous;
    uint                cControls;
    uint                cbmxctrl;
    MIXERCONTROLW*      pamxctrl;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmeapi/ns-mmeapi-mixercontroldetails))], [])
struct MIXERCONTROLDETAILS
{
align (1):
    uint                cbStruct;
    uint                dwControlID;
    uint                cChannels;
    _Anonymous_e__Union Anonymous;
    uint                cbDetails;
    void*               paDetails;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmeapi/ns-mmeapi-mixercontroldetails_listtexta))], [])
struct MIXERCONTROLDETAILS_LISTTEXTA
{
align (1):
    uint     dwParam1;
    uint     dwParam2;
    CHAR[64] szName;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmeapi/ns-mmeapi-mixercontroldetails_listtextw))], [])
struct MIXERCONTROLDETAILS_LISTTEXTW
{
align (1):
    uint      dwParam1;
    uint      dwParam2;
    wchar[64] szName;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmeapi/ns-mmeapi-mixercontroldetails_boolean))], [])
struct MIXERCONTROLDETAILS_BOOLEAN
{
align (1):
    int fValue;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmeapi/ns-mmeapi-mixercontroldetails_signed))], [])
struct MIXERCONTROLDETAILS_SIGNED
{
align (1):
    int lValue;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmeapi/ns-mmeapi-mixercontroldetails_unsigned))], [])
struct MIXERCONTROLDETAILS_UNSIGNED
{
align (1):
    uint dwValue;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/ns-audioclient-audioclientproperties~r1))], [])
struct AudioClientProperties
{
    uint cbSize;
    BOOL bIsOffload;
    AUDIO_STREAM_CATEGORY eCategory;
    AUDCLNT_STREAMOPTIONS Options;
}

struct AudioClient3ActivationParams
{
    GUID tracingContextId;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/ns-audioclient-audio_effect))], [])
struct AUDIO_EFFECT
{
    GUID               id;
    BOOL               canSetState;
    AUDIO_EFFECT_STATE state;
}

struct AMBISONICS_PARAMS
{
    uint            u32Size;
    uint            u32Version;
    AMBISONICS_TYPE u32Type;
    AMBISONICS_CHANNEL_ORDERING u32ChannelOrdering;
    AMBISONICS_NORMALIZATION u32Normalization;
    uint            u32Order;
    uint            u32NumChannels;
    uint*           pu32ChannelMap;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudioclient/ns-spatialaudioclient-spatialaudioobjectrenderstreamactivationparams))], [])
struct SpatialAudioObjectRenderStreamActivationParams
{
align (1):
    const(WAVEFORMATEX)* ObjectFormat;
    AudioObjectType      StaticObjectTypeMask;
    uint                 MinDynamicObjectCount;
    uint                 MaxDynamicObjectCount;
    AUDIO_STREAM_CATEGORY Category;
    HANDLE               EventHandle;
    ISpatialAudioObjectRenderStreamNotify NotifyObject;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudioclient/ns-spatialaudioclient-spatialaudioobjectrenderstreamactivationparams2))], [])
struct SpatialAudioObjectRenderStreamActivationParams2
{
align (1):
    const(WAVEFORMATEX)* ObjectFormat;
    AudioObjectType      StaticObjectTypeMask;
    uint                 MinDynamicObjectCount;
    uint                 MaxDynamicObjectCount;
    AUDIO_STREAM_CATEGORY Category;
    HANDLE               EventHandle;
    ISpatialAudioObjectRenderStreamNotify NotifyObject;
    SPATIAL_AUDIO_STREAM_OPTIONS Options;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudioclient/ns-spatialaudioclient-spatialaudioclientactivationparams))], [])
struct SpatialAudioClientActivationParams
{
    GUID tracingContextId;
    GUID appId;
    int  majorVersion;
    int  minorVersion1;
    int  minorVersion2;
    int  minorVersion3;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiohrtf/ns-spatialaudiohrtf-spatialaudiohrtfdirectivity))], [])
struct SpatialAudioHrtfDirectivity
{
align (1):
    SpatialAudioHrtfDirectivityType Type;
    float Scaling;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiohrtf/ns-spatialaudiohrtf-spatialaudiohrtfdirectivitycardioid))], [])
struct SpatialAudioHrtfDirectivityCardioid
{
align (1):
    SpatialAudioHrtfDirectivity directivity;
    float Order;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiohrtf/ns-spatialaudiohrtf-spatialaudiohrtfdirectivitycone))], [])
struct SpatialAudioHrtfDirectivityCone
{
align (1):
    SpatialAudioHrtfDirectivity directivity;
    float InnerAngle;
    float OuterAngle;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiohrtf/ns-spatialaudiohrtf-spatialaudiohrtfdirectivityunion))], [])
union SpatialAudioHrtfDirectivityUnion
{
    SpatialAudioHrtfDirectivityCone Cone;
    SpatialAudioHrtfDirectivityCardioid Cardiod;
    SpatialAudioHrtfDirectivity Omni;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiohrtf/ns-spatialaudiohrtf-spatialaudiohrtfdistancedecay))], [])
struct SpatialAudioHrtfDistanceDecay
{
align (1):
    SpatialAudioHrtfDistanceDecayType Type;
    float MaxGain;
    float MinGain;
    float UnityGainDistance;
    float CutoffDistance;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiohrtf/ns-spatialaudiohrtf-spatialaudiohrtfactivationparams))], [])
struct SpatialAudioHrtfActivationParams
{
align (1):
    const(WAVEFORMATEX)* ObjectFormat;
    AudioObjectType      StaticObjectTypeMask;
    uint                 MinDynamicObjectCount;
    uint                 MaxDynamicObjectCount;
    AUDIO_STREAM_CATEGORY Category;
    HANDLE               EventHandle;
    ISpatialAudioObjectRenderStreamNotify NotifyObject;
    SpatialAudioHrtfDistanceDecay* DistanceDecay;
    SpatialAudioHrtfDirectivityUnion* Directivity;
    SpatialAudioHrtfEnvironmentType* Environment;
    float*               Orientation;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiohrtf/ns-spatialaudiohrtf-spatialaudiohrtfactivationparams2))], [])
struct SpatialAudioHrtfActivationParams2
{
align (1):
    const(WAVEFORMATEX)* ObjectFormat;
    AudioObjectType      StaticObjectTypeMask;
    uint                 MinDynamicObjectCount;
    uint                 MaxDynamicObjectCount;
    AUDIO_STREAM_CATEGORY Category;
    HANDLE               EventHandle;
    ISpatialAudioObjectRenderStreamNotify NotifyObject;
    SpatialAudioHrtfDistanceDecay* DistanceDecay;
    SpatialAudioHrtfDirectivityUnion* Directivity;
    SpatialAudioHrtfEnvironmentType* Environment;
    float*               Orientation;
    SPATIAL_AUDIO_STREAM_OPTIONS Options;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmdeviceapi/ns-mmdeviceapi-directx_audio_activation_params))], [])
struct DIRECTX_AUDIO_ACTIVATION_PARAMS
{
    uint cbDirectXAudioActivationParams;
    GUID guidAudioSession;
    uint dwAudioStreamFlags;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmdeviceapi/ns-mmdeviceapi-audioextensionparams))], [])
struct AudioExtensionParams
{
    LPARAM    AddPageParam;
    IMMDevice pEndpoint;
    IMMDevice pPnpInterface;
    IMMDevice pPnpDevnode;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiometadata/ns-spatialaudiometadata-spatialaudiometadataitemsinfo))], [])
struct SpatialAudioMetadataItemsInfo
{
align (1):
    ushort FrameCount;
    ushort ItemCount;
    ushort MaxItemCount;
    uint   MaxValueBufferLength;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiometadata/ns-spatialaudiometadata-spatialaudioobjectrenderstreamformetadataactivationparams))], [])
struct SpatialAudioObjectRenderStreamForMetadataActivationParams
{
align (1):
    const(WAVEFORMATEX)* ObjectFormat;
    AudioObjectType      StaticObjectTypeMask;
    uint                 MinDynamicObjectCount;
    uint                 MaxDynamicObjectCount;
    AUDIO_STREAM_CATEGORY Category;
    HANDLE               EventHandle;
    GUID                 MetadataFormatId;
    ushort               MaxMetadataItemCount;
    const(PROPVARIANT)*  MetadataActivationParams;
    ISpatialAudioObjectRenderStreamNotify NotifyObject;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiometadata/ns-spatialaudiometadata-spatialaudioobjectrenderstreamformetadataactivationparams2))], [])
struct SpatialAudioObjectRenderStreamForMetadataActivationParams2
{
align (1):
    const(WAVEFORMATEX)* ObjectFormat;
    AudioObjectType      StaticObjectTypeMask;
    uint                 MinDynamicObjectCount;
    uint                 MaxDynamicObjectCount;
    AUDIO_STREAM_CATEGORY Category;
    HANDLE               EventHandle;
    GUID                 MetadataFormatId;
    uint                 MaxMetadataItemCount;
    const(PROPVARIANT)*  MetadataActivationParams;
    ISpatialAudioObjectRenderStreamNotify NotifyObject;
    SPATIAL_AUDIO_STREAM_OPTIONS Options;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclientactivationparams/ns-audioclientactivationparams-audioclient_process_loopback_params))], [])
struct AUDIOCLIENT_PROCESS_LOOPBACK_PARAMS
{
    uint TargetProcessId;
    PROCESS_LOOPBACK_MODE ProcessLoopbackMode;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclientactivationparams/ns-audioclientactivationparams-audioclient_activation_params))], [])
struct AUDIOCLIENT_ACTIVATION_PARAMS
{
    AUDIOCLIENT_ACTIVATION_TYPE ActivationType;
    _Anonymous_e__Union Anonymous;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
struct ACMDRIVERDETAILSA
{
align (1):
    uint      cbStruct;
    uint      fccType;
    uint      fccComp;
    ushort    wMid;
    ushort    wPid;
    uint      vdwACM;
    uint      vdwDriver;
    uint      fdwSupport;
    uint      cFormatTags;
    uint      cFilterTags;
    HICON     hicon;
    CHAR[32]  szShortName;
    CHAR[128] szLongName;
    CHAR[80]  szCopyright;
    CHAR[128] szLicensing;
    CHAR[512] szFeatures;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
struct ACMDRIVERDETAILSW
{
align (1):
    uint       cbStruct;
    uint       fccType;
    uint       fccComp;
    ushort     wMid;
    ushort     wPid;
    uint       vdwACM;
    uint       vdwDriver;
    uint       fdwSupport;
    uint       cFormatTags;
    uint       cFilterTags;
    HICON      hicon;
    wchar[32]  szShortName;
    wchar[128] szLongName;
    wchar[80]  szCopyright;
    wchar[128] szLicensing;
    wchar[512] szFeatures;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
struct ACMFORMATTAGDETAILSA
{
align (1):
    uint     cbStruct;
    uint     dwFormatTagIndex;
    uint     dwFormatTag;
    uint     cbFormatSize;
    uint     fdwSupport;
    uint     cStandardFormats;
    CHAR[48] szFormatTag;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
struct ACMFORMATTAGDETAILSW
{
align (1):
    uint      cbStruct;
    uint      dwFormatTagIndex;
    uint      dwFormatTag;
    uint      cbFormatSize;
    uint      fdwSupport;
    uint      cStandardFormats;
    wchar[48] szFormatTag;
}

struct ACMFORMATDETAILSA
{
align (1):
    uint          cbStruct;
    uint          dwFormatIndex;
    uint          dwFormatTag;
    uint          fdwSupport;
    WAVEFORMATEX* pwfx;
    uint          cbwfx;
    CHAR[128]     szFormat;
}

struct tACMFORMATDETAILSW
{
align (1):
    uint          cbStruct;
    uint          dwFormatIndex;
    uint          dwFormatTag;
    uint          fdwSupport;
    WAVEFORMATEX* pwfx;
    uint          cbwfx;
    wchar[128]    szFormat;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
struct ACMFORMATCHOOSEA
{
align (1):
    uint          cbStruct;
    uint          fdwStyle;
    HWND          hwndOwner;
    WAVEFORMATEX* pwfx;
    uint          cbwfx;
    const(PSTR)   pszTitle;
    CHAR[48]      szFormatTag;
    CHAR[128]     szFormat;
    PSTR          pszName;
    uint          cchName;
    uint          fdwEnum;
    WAVEFORMATEX* pwfxEnum;
    HINSTANCE     hInstance;
    const(PSTR)   pszTemplateName;
    LPARAM        lCustData;
    ACMFORMATCHOOSEHOOKPROCA pfnHook;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
struct ACMFORMATCHOOSEW
{
align (1):
    uint          cbStruct;
    uint          fdwStyle;
    HWND          hwndOwner;
    WAVEFORMATEX* pwfx;
    uint          cbwfx;
    const(PWSTR)  pszTitle;
    wchar[48]     szFormatTag;
    wchar[128]    szFormat;
    PWSTR         pszName;
    uint          cchName;
    uint          fdwEnum;
    WAVEFORMATEX* pwfxEnum;
    HINSTANCE     hInstance;
    const(PWSTR)  pszTemplateName;
    LPARAM        lCustData;
    ACMFORMATCHOOSEHOOKPROCW pfnHook;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
struct ACMFILTERTAGDETAILSA
{
align (1):
    uint     cbStruct;
    uint     dwFilterTagIndex;
    uint     dwFilterTag;
    uint     cbFilterSize;
    uint     fdwSupport;
    uint     cStandardFilters;
    CHAR[48] szFilterTag;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
struct ACMFILTERTAGDETAILSW
{
align (1):
    uint      cbStruct;
    uint      dwFilterTagIndex;
    uint      dwFilterTag;
    uint      cbFilterSize;
    uint      fdwSupport;
    uint      cStandardFilters;
    wchar[48] szFilterTag;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
struct ACMFILTERDETAILSA
{
align (1):
    uint        cbStruct;
    uint        dwFilterIndex;
    uint        dwFilterTag;
    uint        fdwSupport;
    WAVEFILTER* pwfltr;
    uint        cbwfltr;
    CHAR[128]   szFilter;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
struct ACMFILTERDETAILSW
{
align (1):
    uint        cbStruct;
    uint        dwFilterIndex;
    uint        dwFilterTag;
    uint        fdwSupport;
    WAVEFILTER* pwfltr;
    uint        cbwfltr;
    wchar[128]  szFilter;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
struct ACMFILTERCHOOSEA
{
align (1):
    uint        cbStruct;
    uint        fdwStyle;
    HWND        hwndOwner;
    WAVEFILTER* pwfltr;
    uint        cbwfltr;
    const(PSTR) pszTitle;
    CHAR[48]    szFilterTag;
    CHAR[128]   szFilter;
    PSTR        pszName;
    uint        cchName;
    uint        fdwEnum;
    WAVEFILTER* pwfltrEnum;
    HINSTANCE   hInstance;
    const(PSTR) pszTemplateName;
    LPARAM      lCustData;
    ACMFILTERCHOOSEHOOKPROCA pfnHook;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
struct ACMFILTERCHOOSEW
{
align (1):
    uint         cbStruct;
    uint         fdwStyle;
    HWND         hwndOwner;
    WAVEFILTER*  pwfltr;
    uint         cbwfltr;
    const(PWSTR) pszTitle;
    wchar[48]    szFilterTag;
    wchar[128]   szFilter;
    PWSTR        pszName;
    uint         cchName;
    uint         fdwEnum;
    WAVEFILTER*  pwfltrEnum;
    HINSTANCE    hInstance;
    const(PWSTR) pszTemplateName;
    LPARAM       lCustData;
    ACMFILTERCHOOSEHOOKPROCW pfnHook;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msacm/ns-msacm-acmstreamheader))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(1))], [])
struct ACMSTREAMHEADER
{
align (1):
    uint     cbStruct;
    uint     fdwStatus;
    size_t   dwUser;
    ubyte*   pbSrc;
    uint     cbSrcLength;
    uint     cbSrcLengthUsed;
    size_t   dwSrcUser;
    ubyte*   pbDst;
    uint     cbDstLength;
    uint     cbDstLengthUsed;
    size_t   dwDstUser;
    uint[10] dwReservedDriver;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
struct ACMDRVOPENDESCA
{
align (1):
    uint        cbStruct;
    uint        fccType;
    uint        fccComp;
    uint        dwVersion;
    uint        dwFlags;
    uint        dwError;
    const(PSTR) pszSectionName;
    const(PSTR) pszAliasName;
    uint        dnDevNode;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
struct ACMDRVOPENDESCW
{
align (1):
    uint         cbStruct;
    uint         fccType;
    uint         fccComp;
    uint         dwVersion;
    uint         dwFlags;
    uint         dwError;
    const(PWSTR) pszSectionName;
    const(PWSTR) pszAliasName;
    uint         dnDevNode;
}

struct ACMDRVSTREAMINSTANCE
{
align (1):
    uint          cbStruct;
    WAVEFORMATEX* pwfxSrc;
    WAVEFORMATEX* pwfxDst;
    WAVEFILTER*   pwfltr;
    size_t        dwCallback;
    size_t        dwInstance;
    uint          fdwOpen;
    uint          fdwDriver;
    size_t        dwDriver;
    HACMSTREAM    has;
}

struct ACMDRVSTREAMHEADER
{
align (1):
    uint                cbStruct;
    uint                fdwStatus;
    size_t              dwUser;
    ubyte*              pbSrc;
    uint                cbSrcLength;
    uint                cbSrcLengthUsed;
    size_t              dwSrcUser;
    ubyte*              pbDst;
    uint                cbDstLength;
    uint                cbDstLengthUsed;
    size_t              dwDstUser;
    uint                fdwConvert;
    ACMDRVSTREAMHEADER* padshNext;
    uint                fdwDriver;
    size_t              dwDriver;
    uint                fdwPrepared;
    size_t              dwPrepared;
    ubyte*              pbPreparedSrc;
    uint                cbPreparedSrcLength;
    ubyte*              pbPreparedDst;
    uint                cbPreparedDstLength;
}

struct ACMDRVSTREAMSIZE
{
align (1):
    uint cbStruct;
    uint fdwSize;
    uint cbSrcLength;
    uint cbDstLength;
}

struct ACMDRVFORMATSUGGEST
{
align (1):
    uint          cbStruct;
    uint          fdwSuggest;
    WAVEFORMATEX* pwfxSrc;
    uint          cbwfxSrc;
    WAVEFORMATEX* pwfxDst;
    uint          cbwfxDst;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT CoRegisterMessageFilter(IMessageFilter lpMessageFilter, IMessageFilter* lplpMessageFilter);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("WINMM.dll")
BOOL sndPlaySoundA(const(PSTR) pszSound, uint fuSound);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("WINMM.dll")
BOOL sndPlaySoundW(const(PWSTR) pszSound, uint fuSound);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("WINMM.dll")
BOOL PlaySoundA(const(PSTR) pszSound, HMODULE hmod, SND_FLAGS fdwSound);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("WINMM.dll")
BOOL PlaySoundW(const(PWSTR) pszSound, HMODULE hmod, SND_FLAGS fdwSound);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint waveOutGetNumDevs();

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("WINMM.dll")
uint waveOutGetDevCapsA(size_t uDeviceID, WAVEOUTCAPSA* pwoc, uint cbwoc);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("WINMM.dll")
uint waveOutGetDevCapsW(size_t uDeviceID, WAVEOUTCAPSW* pwoc, uint cbwoc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint waveOutGetVolume(HWAVEOUT hwo, uint* pdwVolume);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint waveOutSetVolume(HWAVEOUT hwo, uint dwVolume);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("WINMM.dll")
uint waveOutGetErrorTextA(uint mmrError, PSTR pszText, uint cchText);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("WINMM.dll")
uint waveOutGetErrorTextW(uint mmrError, PWSTR pszText, uint cchText);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint waveOutOpen(HWAVEOUT* phwo, uint uDeviceID, WAVEFORMATEX* pwfx, size_t dwCallback, size_t dwInstance, 
                 MIDI_WAVE_OPEN_TYPE fdwOpen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint waveOutClose(HWAVEOUT hwo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint waveOutPrepareHeader(HWAVEOUT hwo, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/WAVEHDR* pwh, 
                          uint cbwh);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint waveOutUnprepareHeader(HWAVEOUT hwo, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/WAVEHDR* pwh, 
                            uint cbwh);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint waveOutWrite(HWAVEOUT hwo, 
                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/WAVEHDR* pwh, 
                  uint cbwh);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint waveOutPause(HWAVEOUT hwo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint waveOutRestart(HWAVEOUT hwo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint waveOutReset(HWAVEOUT hwo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint waveOutBreakLoop(HWAVEOUT hwo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint waveOutGetPosition(HWAVEOUT hwo, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/MMTIME* pmmt, 
                        uint cbmmt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint waveOutGetPitch(HWAVEOUT hwo, uint* pdwPitch);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint waveOutSetPitch(HWAVEOUT hwo, uint dwPitch);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint waveOutGetPlaybackRate(HWAVEOUT hwo, uint* pdwRate);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint waveOutSetPlaybackRate(HWAVEOUT hwo, uint dwRate);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint waveOutGetID(HWAVEOUT hwo, uint* puDeviceID);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint waveOutMessage(HWAVEOUT hwo, uint uMsg, size_t dw1, size_t dw2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint waveInGetNumDevs();

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("WINMM.dll")
uint waveInGetDevCapsA(size_t uDeviceID, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/WAVEINCAPSA* pwic, 
                       uint cbwic);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("WINMM.dll")
uint waveInGetDevCapsW(size_t uDeviceID, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/WAVEINCAPSW* pwic, 
                       uint cbwic);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("WINMM.dll")
uint waveInGetErrorTextA(uint mmrError, PSTR pszText, uint cchText);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("WINMM.dll")
uint waveInGetErrorTextW(uint mmrError, PWSTR pszText, uint cchText);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint waveInOpen(HWAVEIN* phwi, uint uDeviceID, WAVEFORMATEX* pwfx, size_t dwCallback, size_t dwInstance, 
                MIDI_WAVE_OPEN_TYPE fdwOpen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint waveInClose(HWAVEIN hwi);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint waveInPrepareHeader(HWAVEIN hwi, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/WAVEHDR* pwh, 
                         uint cbwh);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint waveInUnprepareHeader(HWAVEIN hwi, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/WAVEHDR* pwh, 
                           uint cbwh);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint waveInAddBuffer(HWAVEIN hwi, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/WAVEHDR* pwh, 
                     uint cbwh);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint waveInStart(HWAVEIN hwi);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint waveInStop(HWAVEIN hwi);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint waveInReset(HWAVEIN hwi);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint waveInGetPosition(HWAVEIN hwi, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/MMTIME* pmmt, 
                       uint cbmmt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint waveInGetID(HWAVEIN hwi, uint* puDeviceID);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint waveInMessage(HWAVEIN hwi, uint uMsg, size_t dw1, size_t dw2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint midiOutGetNumDevs();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint midiStreamOpen(HMIDISTRM* phms, uint* puDeviceID, uint cMidi, size_t dwCallback, size_t dwInstance, 
                    uint fdwOpen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint midiStreamClose(HMIDISTRM hms);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint midiStreamProperty(HMIDISTRM hms, ubyte* lppropdata, uint dwProperty);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint midiStreamPosition(HMIDISTRM hms, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/MMTIME* lpmmt, 
                        uint cbmmt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint midiStreamOut(HMIDISTRM hms, 
                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/MIDIHDR* pmh, 
                   uint cbmh);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint midiStreamPause(HMIDISTRM hms);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint midiStreamRestart(HMIDISTRM hms);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint midiStreamStop(HMIDISTRM hms);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint midiConnect(HMIDI hmi, HMIDIOUT hmo, void* pReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint midiDisconnect(HMIDI hmi, HMIDIOUT hmo, void* pReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint midiOutGetDevCapsA(size_t uDeviceID, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/MIDIOUTCAPSA* pmoc, 
                        uint cbmoc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint midiOutGetDevCapsW(size_t uDeviceID, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/MIDIOUTCAPSW* pmoc, 
                        uint cbmoc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint midiOutGetVolume(HMIDIOUT hmo, uint* pdwVolume);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint midiOutSetVolume(HMIDIOUT hmo, uint dwVolume);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint midiOutGetErrorTextA(uint mmrError, PSTR pszText, uint cchText);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint midiOutGetErrorTextW(uint mmrError, PWSTR pszText, uint cchText);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint midiOutOpen(HMIDIOUT* phmo, uint uDeviceID, size_t dwCallback, size_t dwInstance, MIDI_WAVE_OPEN_TYPE fdwOpen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint midiOutClose(HMIDIOUT hmo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint midiOutPrepareHeader(HMIDIOUT hmo, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/MIDIHDR* pmh, 
                          uint cbmh);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint midiOutUnprepareHeader(HMIDIOUT hmo, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/MIDIHDR* pmh, 
                            uint cbmh);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint midiOutShortMsg(HMIDIOUT hmo, uint dwMsg);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint midiOutLongMsg(HMIDIOUT hmo, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/MIDIHDR* pmh, 
                    uint cbmh);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint midiOutReset(HMIDIOUT hmo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint midiOutCachePatches(HMIDIOUT hmo, uint uBank, ushort* pwpa, uint fuCache);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint midiOutCacheDrumPatches(HMIDIOUT hmo, uint uPatch, ushort* pwkya, uint fuCache);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint midiOutGetID(HMIDIOUT hmo, uint* puDeviceID);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint midiOutMessage(HMIDIOUT hmo, uint uMsg, size_t dw1, size_t dw2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint midiInGetNumDevs();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint midiInGetDevCapsA(size_t uDeviceID, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/MIDIINCAPSA* pmic, 
                       uint cbmic);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint midiInGetDevCapsW(size_t uDeviceID, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/MIDIINCAPSW* pmic, 
                       uint cbmic);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint midiInGetErrorTextA(uint mmrError, PSTR pszText, uint cchText);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint midiInGetErrorTextW(uint mmrError, PWSTR pszText, uint cchText);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint midiInOpen(HMIDIIN* phmi, uint uDeviceID, size_t dwCallback, size_t dwInstance, MIDI_WAVE_OPEN_TYPE fdwOpen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint midiInClose(HMIDIIN hmi);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint midiInPrepareHeader(HMIDIIN hmi, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/MIDIHDR* pmh, 
                         uint cbmh);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint midiInUnprepareHeader(HMIDIIN hmi, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/MIDIHDR* pmh, 
                           uint cbmh);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint midiInAddBuffer(HMIDIIN hmi, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/MIDIHDR* pmh, 
                     uint cbmh);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint midiInStart(HMIDIIN hmi);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint midiInStop(HMIDIIN hmi);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint midiInReset(HMIDIIN hmi);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint midiInGetID(HMIDIIN hmi, uint* puDeviceID);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint midiInMessage(HMIDIIN hmi, uint uMsg, size_t dw1, size_t dw2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint auxGetNumDevs();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint auxGetDevCapsA(size_t uDeviceID, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/AUXCAPSA* pac, 
                    uint cbac);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint auxGetDevCapsW(size_t uDeviceID, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/AUXCAPSW* pac, 
                    uint cbac);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint auxSetVolume(uint uDeviceID, uint dwVolume);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint auxGetVolume(uint uDeviceID, uint* pdwVolume);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint auxOutMessage(uint uDeviceID, uint uMsg, size_t dw1, size_t dw2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint mixerGetNumDevs();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint mixerGetDevCapsA(size_t uMxId, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/MIXERCAPSA* pmxcaps, 
                      uint cbmxcaps);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint mixerGetDevCapsW(size_t uMxId, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/MIXERCAPSW* pmxcaps, 
                      uint cbmxcaps);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint mixerOpen(HMIXER* phmx, uint uMxId, size_t dwCallback, size_t dwInstance, uint fdwOpen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint mixerClose(HMIXER hmx);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint mixerMessage(HMIXER hmx, uint uMsg, size_t dwParam1, size_t dwParam2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint mixerGetLineInfoA(HMIXEROBJ hmxobj, MIXERLINEA* pmxl, uint fdwInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint mixerGetLineInfoW(HMIXEROBJ hmxobj, MIXERLINEW* pmxl, uint fdwInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint mixerGetID(HMIXEROBJ hmxobj, uint* puMxId, uint fdwId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint mixerGetLineControlsA(HMIXEROBJ hmxobj, MIXERLINECONTROLSA* pmxlc, uint fdwControls);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint mixerGetLineControlsW(HMIXEROBJ hmxobj, MIXERLINECONTROLSW* pmxlc, uint fdwControls);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint mixerGetControlDetailsA(HMIXEROBJ hmxobj, MIXERCONTROLDETAILS* pmxcd, uint fdwDetails);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint mixerGetControlDetailsW(HMIXEROBJ hmxobj, MIXERCONTROLDETAILS* pmxcd, uint fdwDetails);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint mixerSetControlDetails(HMIXEROBJ hmxobj, MIXERCONTROLDETAILS* pmxcd, uint fdwDetails);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("MMDevAPI.dll")
HRESULT ActivateAudioInterfaceAsync(const(PWSTR) deviceInterfacePath, const(GUID)* riid, 
                                    PROPVARIANT* activationParams, 
                                    IActivateAudioInterfaceCompletionHandler completionHandler, 
                                    IActivateAudioInterfaceAsyncOperation* activationOperation);

@DllImport("Windows.Media.MediaControl.dll")
HRESULT CreateRenderAudioStateMonitor(IAudioStateMonitor* audioStateMonitor);

@DllImport("Windows.Media.MediaControl.dll")
HRESULT CreateRenderAudioStateMonitorForCategory(AUDIO_STREAM_CATEGORY category, 
                                                 IAudioStateMonitor* audioStateMonitor);

@DllImport("Windows.Media.MediaControl.dll")
HRESULT CreateRenderAudioStateMonitorForCategoryAndDeviceRole(AUDIO_STREAM_CATEGORY category, ERole role, 
                                                              IAudioStateMonitor* audioStateMonitor);

@DllImport("Windows.Media.MediaControl.dll")
HRESULT CreateRenderAudioStateMonitorForCategoryAndDeviceId(AUDIO_STREAM_CATEGORY category, const(PWSTR) deviceId, 
                                                            IAudioStateMonitor* audioStateMonitor);

@DllImport("Windows.Media.MediaControl.dll")
HRESULT CreateCaptureAudioStateMonitor(IAudioStateMonitor* audioStateMonitor);

@DllImport("Windows.Media.MediaControl.dll")
HRESULT CreateCaptureAudioStateMonitorForCategory(AUDIO_STREAM_CATEGORY category, 
                                                  IAudioStateMonitor* audioStateMonitor);

@DllImport("Windows.Media.MediaControl.dll")
HRESULT CreateCaptureAudioStateMonitorForCategoryAndDeviceRole(AUDIO_STREAM_CATEGORY category, ERole role, 
                                                               IAudioStateMonitor* audioStateMonitor);

@DllImport("Windows.Media.MediaControl.dll")
HRESULT CreateCaptureAudioStateMonitorForCategoryAndDeviceId(AUDIO_STREAM_CATEGORY category, const(PWSTR) deviceId, 
                                                             IAudioStateMonitor* audioStateMonitor);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSACM32.dll")
uint acmGetVersion();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSACM32.dll")
uint acmMetrics(HACMOBJ hao, uint uMetric, void* pMetric);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSACM32.dll")
uint acmDriverEnum(ACMDRIVERENUMCB fnCallback, size_t dwInstance, uint fdwEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSACM32.dll")
uint acmDriverID(HACMOBJ hao, HACMDRIVERID* phadid, uint fdwDriverID);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSACM32.dll")
uint acmDriverAddA(HACMDRIVERID* phadid, HINSTANCE hinstModule, LPARAM lParam, uint dwPriority, uint fdwAdd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSACM32.dll")
uint acmDriverAddW(HACMDRIVERID* phadid, HINSTANCE hinstModule, LPARAM lParam, uint dwPriority, uint fdwAdd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSACM32.dll")
uint acmDriverRemove(HACMDRIVERID hadid, uint fdwRemove);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSACM32.dll")
uint acmDriverOpen(HACMDRIVER* phad, HACMDRIVERID hadid, uint fdwOpen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSACM32.dll")
uint acmDriverClose(HACMDRIVER had, uint fdwClose);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSACM32.dll")
LRESULT acmDriverMessage(HACMDRIVER had, uint uMsg, LPARAM lParam1, LPARAM lParam2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSACM32.dll")
uint acmDriverPriority(HACMDRIVERID hadid, uint dwPriority, uint fdwPriority);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSACM32.dll")
uint acmDriverDetailsA(HACMDRIVERID hadid, ACMDRIVERDETAILSA* padd, uint fdwDetails);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSACM32.dll")
uint acmDriverDetailsW(HACMDRIVERID hadid, ACMDRIVERDETAILSW* padd, uint fdwDetails);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSACM32.dll")
uint acmFormatTagDetailsA(HACMDRIVER had, ACMFORMATTAGDETAILSA* paftd, uint fdwDetails);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSACM32.dll")
uint acmFormatTagDetailsW(HACMDRIVER had, ACMFORMATTAGDETAILSW* paftd, uint fdwDetails);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSACM32.dll")
uint acmFormatTagEnumA(HACMDRIVER had, ACMFORMATTAGDETAILSA* paftd, ACMFORMATTAGENUMCBA fnCallback, 
                       size_t dwInstance, uint fdwEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSACM32.dll")
uint acmFormatTagEnumW(HACMDRIVER had, ACMFORMATTAGDETAILSW* paftd, ACMFORMATTAGENUMCBW fnCallback, 
                       size_t dwInstance, uint fdwEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSACM32.dll")
uint acmFormatDetailsA(HACMDRIVER had, ACMFORMATDETAILSA* pafd, uint fdwDetails);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSACM32.dll")
uint acmFormatDetailsW(HACMDRIVER had, tACMFORMATDETAILSW* pafd, uint fdwDetails);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSACM32.dll")
uint acmFormatEnumA(HACMDRIVER had, ACMFORMATDETAILSA* pafd, ACMFORMATENUMCBA fnCallback, size_t dwInstance, 
                    uint fdwEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSACM32.dll")
uint acmFormatEnumW(HACMDRIVER had, tACMFORMATDETAILSW* pafd, ACMFORMATENUMCBW fnCallback, size_t dwInstance, 
                    uint fdwEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSACM32.dll")
uint acmFormatSuggest(HACMDRIVER had, WAVEFORMATEX* pwfxSrc, WAVEFORMATEX* pwfxDst, uint cbwfxDst, uint fdwSuggest);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSACM32.dll")
uint acmFormatChooseA(ACMFORMATCHOOSEA* pafmtc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSACM32.dll")
uint acmFormatChooseW(ACMFORMATCHOOSEW* pafmtc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSACM32.dll")
uint acmFilterTagDetailsA(HACMDRIVER had, ACMFILTERTAGDETAILSA* paftd, uint fdwDetails);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSACM32.dll")
uint acmFilterTagDetailsW(HACMDRIVER had, ACMFILTERTAGDETAILSW* paftd, uint fdwDetails);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSACM32.dll")
uint acmFilterTagEnumA(HACMDRIVER had, ACMFILTERTAGDETAILSA* paftd, ACMFILTERTAGENUMCBA fnCallback, 
                       size_t dwInstance, uint fdwEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSACM32.dll")
uint acmFilterTagEnumW(HACMDRIVER had, ACMFILTERTAGDETAILSW* paftd, ACMFILTERTAGENUMCBW fnCallback, 
                       size_t dwInstance, uint fdwEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSACM32.dll")
uint acmFilterDetailsA(HACMDRIVER had, ACMFILTERDETAILSA* pafd, uint fdwDetails);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSACM32.dll")
uint acmFilterDetailsW(HACMDRIVER had, ACMFILTERDETAILSW* pafd, uint fdwDetails);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSACM32.dll")
uint acmFilterEnumA(HACMDRIVER had, ACMFILTERDETAILSA* pafd, ACMFILTERENUMCBA fnCallback, size_t dwInstance, 
                    uint fdwEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSACM32.dll")
uint acmFilterEnumW(HACMDRIVER had, ACMFILTERDETAILSW* pafd, ACMFILTERENUMCBW fnCallback, size_t dwInstance, 
                    uint fdwEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSACM32.dll")
uint acmFilterChooseA(ACMFILTERCHOOSEA* pafltrc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSACM32.dll")
uint acmFilterChooseW(ACMFILTERCHOOSEW* pafltrc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSACM32.dll")
uint acmStreamOpen(HACMSTREAM* phas, HACMDRIVER had, WAVEFORMATEX* pwfxSrc, WAVEFORMATEX* pwfxDst, 
                   WAVEFILTER* pwfltr, size_t dwCallback, size_t dwInstance, uint fdwOpen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSACM32.dll")
uint acmStreamClose(HACMSTREAM has, uint fdwClose);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSACM32.dll")
uint acmStreamSize(HACMSTREAM has, uint cbInput, uint* pdwOutputBytes, uint fdwSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSACM32.dll")
uint acmStreamReset(HACMSTREAM has, uint fdwReset);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSACM32.dll")
uint acmStreamMessage(HACMSTREAM has, uint uMsg, LPARAM lParam1, LPARAM lParam2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSACM32.dll")
uint acmStreamConvert(HACMSTREAM has, ACMSTREAMHEADER* pash, uint fdwConvert);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSACM32.dll")
uint acmStreamPrepareHeader(HACMSTREAM has, ACMSTREAMHEADER* pash, uint fdwPrepare);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSACM32.dll")
uint acmStreamUnprepareHeader(HACMSTREAM has, ACMSTREAMHEADER* pash, uint fdwUnprepare);


// Interfaces

@GUID("bcde0395-e52f-467c-8e3d-c4579291692e")
struct MMDeviceEnumerator;

@GUID("1df639d0-5ec1-47aa-9379-828dc1aa8c59")
struct DeviceTopology;

@GUID("00000016-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nn-objidl-imessagefilter))], [])
interface IMessageFilter : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-imessagefilter-handleincomingcall))], [])
    uint HandleInComingCall(uint dwCallType, HTASK htaskCaller, uint dwTickCount, INTERFACEINFO* lpInterfaceInfo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-imessagefilter-retryrejectedcall))], [])
    uint RetryRejectedCall(HTASK htaskCallee, uint dwTickCount, uint dwRejectType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-imessagefilter-messagepending))], [])
    uint MessagePending(HTASK htaskCallee, uint dwTickCount, uint dwPendingType);
}

@GUID("1cb9ad4c-dbfa-4c32-b178-c2f568a703b2")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nn-audioclient-iaudioclient))], [])
interface IAudioClient : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nf-audioclient-iaudioclient-initialize))], [])
    HRESULT Initialize(AUDCLNT_SHAREMODE ShareMode, uint StreamFlags, long hnsBufferDuration, long hnsPeriodicity, 
                       const(WAVEFORMATEX)* pFormat, const(GUID)* AudioSessionGuid);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nf-audioclient-iaudioclient-getbuffersize))], [])
    HRESULT GetBufferSize(uint* pNumBufferFrames);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nf-audioclient-iaudioclient-getstreamlatency))], [])
    HRESULT GetStreamLatency(long* phnsLatency);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nf-audioclient-iaudioclient-getcurrentpadding))], [])
    HRESULT GetCurrentPadding(uint* pNumPaddingFrames);
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT IsFormatSupported(AUDCLNT_SHAREMODE ShareMode, const(WAVEFORMATEX)* pFormat, 
                              WAVEFORMATEX** ppClosestMatch);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nf-audioclient-iaudioclient-getmixformat))], [])
    HRESULT GetMixFormat(WAVEFORMATEX** ppDeviceFormat);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nf-audioclient-iaudioclient-getdeviceperiod))], [])
    HRESULT GetDevicePeriod(long* phnsDefaultDevicePeriod, long* phnsMinimumDevicePeriod);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nf-audioclient-iaudioclient-start))], [])
    HRESULT Start();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nf-audioclient-iaudioclient-stop))], [])
    HRESULT Stop();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nf-audioclient-iaudioclient-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nf-audioclient-iaudioclient-seteventhandle))], [])
    HRESULT SetEventHandle(HANDLE eventHandle);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nf-audioclient-iaudioclient-getservice))], [])
    HRESULT GetService(const(GUID)* riid, void** ppv);
}

@GUID("726778cd-f60a-4eda-82de-e47610cd78aa")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nn-audioclient-iaudioclient2))], [])
interface IAudioClient2 : IAudioClient
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nf-audioclient-iaudioclient2-isoffloadcapable))], [])
    HRESULT IsOffloadCapable(AUDIO_STREAM_CATEGORY Category, BOOL* pbOffloadCapable);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nf-audioclient-iaudioclient2-setclientproperties))], [])
    HRESULT SetClientProperties(const(AudioClientProperties)* pProperties);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nf-audioclient-iaudioclient2-getbuffersizelimits))], [])
    HRESULT GetBufferSizeLimits(const(WAVEFORMATEX)* pFormat, BOOL bEventDriven, long* phnsMinBufferDuration, 
                                long* phnsMaxBufferDuration);
}

@GUID("7ed4ee07-8e67-4cd4-8c1a-2b7a5987ad42")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nn-audioclient-iaudioclient3))], [])
interface IAudioClient3 : IAudioClient2
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nf-audioclient-iaudioclient3-getsharedmodeengineperiod))], [])
    HRESULT GetSharedModeEnginePeriod(const(WAVEFORMATEX)* pFormat, uint* pDefaultPeriodInFrames, 
                                      uint* pFundamentalPeriodInFrames, uint* pMinPeriodInFrames, 
                                      uint* pMaxPeriodInFrames);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nf-audioclient-iaudioclient3-getcurrentsharedmodeengineperiod))], [])
    HRESULT GetCurrentSharedModeEnginePeriod(WAVEFORMATEX** ppFormat, uint* pCurrentPeriodInFrames);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nf-audioclient-iaudioclient3-initializesharedaudiostream))], [])
    HRESULT InitializeSharedAudioStream(uint StreamFlags, uint PeriodInFrames, const(WAVEFORMATEX)* pFormat, 
                                        const(GUID)* AudioSessionGuid);
}

@GUID("f294acfc-3146-4483-a7bf-addca7c260e2")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nn-audioclient-iaudiorenderclient))], [])
interface IAudioRenderClient : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nf-audioclient-iaudiorenderclient-getbuffer))], [])
    HRESULT GetBuffer(uint NumFramesRequested, ubyte** ppData);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nf-audioclient-iaudiorenderclient-releasebuffer))], [])
    HRESULT ReleaseBuffer(uint NumFramesWritten, uint dwFlags);
}

@GUID("c8adbd64-e71e-48a0-a4de-185c395cd317")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nn-audioclient-iaudiocaptureclient))], [])
interface IAudioCaptureClient : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nf-audioclient-iaudiocaptureclient-getbuffer))], [])
    HRESULT GetBuffer(ubyte** ppData, uint* pNumFramesToRead, uint* pdwFlags, ulong* pu64DevicePosition, 
                      ulong* pu64QPCPosition);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nf-audioclient-iaudiocaptureclient-releasebuffer))], [])
    HRESULT ReleaseBuffer(uint NumFramesRead);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nf-audioclient-iaudiocaptureclient-getnextpacketsize))], [])
    HRESULT GetNextPacketSize(uint* pNumFramesInNextPacket);
}

@GUID("cd63314f-3fba-4a1b-812c-ef96358728e7")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nn-audioclient-iaudioclock))], [])
interface IAudioClock : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nf-audioclient-iaudioclock-getfrequency))], [])
    HRESULT GetFrequency(ulong* pu64Frequency);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nf-audioclient-iaudioclock-getposition))], [])
    HRESULT GetPosition(ulong* pu64Position, ulong* pu64QPCPosition);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nf-audioclient-iaudioclock-getcharacteristics))], [])
    HRESULT GetCharacteristics(uint* pdwCharacteristics);
}

@GUID("6f49ff73-6727-49ac-a008-d98cf5e70048")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nn-audioclient-iaudioclock2))], [])
interface IAudioClock2 : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nf-audioclient-iaudioclock2-getdeviceposition))], [])
    HRESULT GetDevicePosition(ulong* DevicePosition, ulong* QPCPosition);
}

@GUID("f6e4c0a0-46d9-4fb8-be21-57a3ef2b626c")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nn-audioclient-iaudioclockadjustment))], [])
interface IAudioClockAdjustment : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nf-audioclient-iaudioclockadjustment-setsamplerate))], [])
    HRESULT SetSampleRate(float flSampleRate);
}

@GUID("87ce5498-68d6-44e5-9215-6da47ef883d8")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nn-audioclient-isimpleaudiovolume))], [])
interface ISimpleAudioVolume : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nf-audioclient-isimpleaudiovolume-setmastervolume))], [])
    HRESULT SetMasterVolume(float fLevel, const(GUID)* EventContext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nf-audioclient-isimpleaudiovolume-getmastervolume))], [])
    HRESULT GetMasterVolume(float* pfLevel);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nf-audioclient-isimpleaudiovolume-setmute))], [])
    HRESULT SetMute(const(BOOL) bMute, const(GUID)* EventContext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nf-audioclient-isimpleaudiovolume-getmute))], [])
    HRESULT GetMute(BOOL* pbMute);
}

@GUID("c789d381-a28c-4168-b28f-d3a837924dc3")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nn-audioclient-iaudioclientduckingcontrol))], [])
interface IAudioClientDuckingControl : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nf-audioclient-iaudioclientduckingcontrol-setduckingoptionsforcurrentstream))], [])
    HRESULT SetDuckingOptionsForCurrentStream(AUDIO_DUCKING_OPTIONS options);
}

@GUID("a7a7ef10-1f49-45e0-ad35-612057cc8f74")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nn-audioclient-iaudioviewmanagerservice))], [])
interface IAudioViewManagerService : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nf-audioclient-iaudioviewmanagerservice-setaudiostreamwindow))], [])
    HRESULT SetAudioStreamWindow(HWND hwnd);
}

@GUID("a5ded44f-3c5d-4b2b-bd1e-5dc1ee20bbf6")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nn-audioclient-iaudioeffectschangednotificationclient))], [])
interface IAudioEffectsChangedNotificationClient : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nf-audioclient-iaudioeffectschangednotificationclient-onaudioeffectschanged))], [])
    HRESULT OnAudioEffectsChanged();
}

@GUID("4460b3ae-4b44-4527-8676-7548a8acd260")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nn-audioclient-iaudioeffectsmanager))], [])
interface IAudioEffectsManager : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nf-audioclient-iaudioeffectsmanager-registeraudioeffectschangednotificationcallback))], [])
    HRESULT RegisterAudioEffectsChangedNotificationCallback(IAudioEffectsChangedNotificationClient client);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nf-audioclient-iaudioeffectsmanager-unregisteraudioeffectschangednotificationcallback))], [])
    HRESULT UnregisterAudioEffectsChangedNotificationCallback(IAudioEffectsChangedNotificationClient client);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nf-audioclient-iaudioeffectsmanager-getaudioeffects))], [])
    HRESULT GetAudioEffects(AUDIO_EFFECT** effects, uint* numEffects);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nf-audioclient-iaudioeffectsmanager-setaudioeffectstate))], [])
    HRESULT SetAudioEffectState(GUID effectId, AUDIO_EFFECT_STATE state);
}

@GUID("93014887-242d-4068-8a15-cf5e93b90fe3")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nn-audioclient-iaudiostreamvolume))], [])
interface IAudioStreamVolume : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nf-audioclient-iaudiostreamvolume-getchannelcount))], [])
    HRESULT GetChannelCount(uint* pdwCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nf-audioclient-iaudiostreamvolume-setchannelvolume))], [])
    HRESULT SetChannelVolume(uint dwIndex, const(float) fLevel);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nf-audioclient-iaudiostreamvolume-getchannelvolume))], [])
    HRESULT GetChannelVolume(uint dwIndex, float* pfLevel);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nf-audioclient-iaudiostreamvolume-setallvolumes))], [])
    HRESULT SetAllVolumes(uint dwCount, const(float)* pfVolumes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nf-audioclient-iaudiostreamvolume-getallvolumes))], [])
    HRESULT GetAllVolumes(uint dwCount, float* pfVolumes);
}

@GUID("28724c91-df35-4856-9f76-d6a26413f3df")
interface IAudioAmbisonicsControl : IUnknown
{
    HRESULT SetData(const(AMBISONICS_PARAMS)* pAmbisonicsParams, uint cbAmbisonicsParams);
    HRESULT SetHeadTracking(BOOL bEnableHeadTracking);
    HRESULT GetHeadTracking(BOOL* pbEnableHeadTracking);
    HRESULT SetRotation(float X, float Y, float Z, float W);
}

@GUID("1c158861-b533-4b30-b1cf-e853e51c59b8")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nn-audioclient-ichannelaudiovolume))], [])
interface IChannelAudioVolume : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nf-audioclient-ichannelaudiovolume-getchannelcount))], [])
    HRESULT GetChannelCount(uint* pdwCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nf-audioclient-ichannelaudiovolume-setchannelvolume))], [])
    HRESULT SetChannelVolume(uint dwIndex, const(float) fLevel, const(GUID)* EventContext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nf-audioclient-ichannelaudiovolume-getchannelvolume))], [])
    HRESULT GetChannelVolume(uint dwIndex, float* pfLevel);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nf-audioclient-ichannelaudiovolume-setallvolumes))], [])
    HRESULT SetAllVolumes(uint dwCount, const(float)* pfVolumes, const(GUID)* EventContext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nf-audioclient-ichannelaudiovolume-getallvolumes))], [])
    HRESULT GetAllVolumes(uint dwCount, float* pfVolumes);
}

@GUID("f4ae25b5-aaa3-437d-b6b3-dbbe2d0e9549")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nn-audioclient-iacousticechocancellationcontrol))], [])
interface IAcousticEchoCancellationControl : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audioclient/nf-audioclient-iacousticechocancellationcontrol-setechocancellationrenderendpoint))], [])
    HRESULT SetEchoCancellationRenderEndpoint(const(PWSTR) endpointId);
}

@GUID("dcdaa858-895a-4a22-a5eb-67bda506096d")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudioclient/nn-spatialaudioclient-iaudioformatenumerator))], [])
interface IAudioFormatEnumerator : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudioclient/nf-spatialaudioclient-iaudioformatenumerator-getcount))], [])
    HRESULT GetCount(uint* count);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudioclient/nf-spatialaudioclient-iaudioformatenumerator-getformat))], [])
    HRESULT GetFormat(uint index, WAVEFORMATEX** format);
}

@GUID("cce0b8f2-8d4d-4efb-a8cf-3d6ecf1c30e0")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudioclient/nn-spatialaudioclient-ispatialaudioobjectbase))], [])
interface ISpatialAudioObjectBase : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudioclient/nf-spatialaudioclient-ispatialaudioobjectbase-getbuffer))], [])
    HRESULT GetBuffer(ubyte** buffer, uint* bufferLength);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudioclient/nf-spatialaudioclient-ispatialaudioobjectbase-setendofstream))], [])
    HRESULT SetEndOfStream(uint frameCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudioclient/nf-spatialaudioclient-ispatialaudioobjectbase-isactive))], [])
    HRESULT IsActive(BOOL* isActive);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudioclient/nf-spatialaudioclient-ispatialaudioobjectbase-getaudioobjecttype))], [])
    HRESULT GetAudioObjectType(AudioObjectType* audioObjectType);
}

@GUID("dde28967-521b-46e5-8f00-bd6f2bc8ab1d")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudioclient/nn-spatialaudioclient-ispatialaudioobject))], [])
interface ISpatialAudioObject : ISpatialAudioObjectBase
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudioclient/nf-spatialaudioclient-ispatialaudioobject-setposition))], [])
    HRESULT SetPosition(float x, float y, float z);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudioclient/nf-spatialaudioclient-ispatialaudioobject-setvolume))], [])
    HRESULT SetVolume(float volume);
}

@GUID("feaaf403-c1d8-450d-aa05-e0ccee7502a8")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudioclient/nn-spatialaudioclient-ispatialaudioobjectrenderstreambase))], [])
interface ISpatialAudioObjectRenderStreamBase : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudioclient/nf-spatialaudioclient-ispatialaudioobjectrenderstreambase-getavailabledynamicobjectcount))], [])
    HRESULT GetAvailableDynamicObjectCount(uint* value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudioclient/nf-spatialaudioclient-ispatialaudioobjectrenderstreambase-getservice))], [])
    HRESULT GetService(const(GUID)* riid, void** service);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudioclient/nf-spatialaudioclient-ispatialaudioobjectrenderstreambase-start))], [])
    HRESULT Start();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudioclient/nf-spatialaudioclient-ispatialaudioobjectrenderstreambase-stop))], [])
    HRESULT Stop();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudioclient/nf-spatialaudioclient-ispatialaudioobjectrenderstreambase-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudioclient/nf-spatialaudioclient-ispatialaudioobjectrenderstreambase-beginupdatingaudioobjects))], [])
    HRESULT BeginUpdatingAudioObjects(uint* availableDynamicObjectCount, uint* frameCountPerBuffer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudioclient/nf-spatialaudioclient-ispatialaudioobjectrenderstreambase-endupdatingaudioobjects))], [])
    HRESULT EndUpdatingAudioObjects();
}

@GUID("bab5f473-b423-477b-85f5-b5a332a04153")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudioclient/nn-spatialaudioclient-ispatialaudioobjectrenderstream))], [])
interface ISpatialAudioObjectRenderStream : ISpatialAudioObjectRenderStreamBase
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudioclient/nf-spatialaudioclient-ispatialaudioobjectrenderstream-activatespatialaudioobject))], [])
    HRESULT ActivateSpatialAudioObject(AudioObjectType type, ISpatialAudioObject* audioObject);
}

@GUID("dddf83e6-68d7-4c70-883f-a1836afb4a50")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudioclient/nn-spatialaudioclient-ispatialaudioobjectrenderstreamnotify))], [])
interface ISpatialAudioObjectRenderStreamNotify : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudioclient/nf-spatialaudioclient-ispatialaudioobjectrenderstreamnotify-onavailabledynamicobjectcountchange))], [])
    HRESULT OnAvailableDynamicObjectCountChange(ISpatialAudioObjectRenderStreamBase sender, 
                                                long hnsComplianceDeadlineTime, 
                                                uint availableDynamicObjectCountChange);
}

@GUID("bbf8e066-aaaa-49be-9a4d-fd2a858ea27f")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudioclient/nn-spatialaudioclient-ispatialaudioclient))], [])
interface ISpatialAudioClient : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudioclient/nf-spatialaudioclient-ispatialaudioclient-getstaticobjectposition))], [])
    HRESULT GetStaticObjectPosition(AudioObjectType type, float* x, float* y, float* z);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudioclient/nf-spatialaudioclient-ispatialaudioclient-getnativestaticobjecttypemask))], [])
    HRESULT GetNativeStaticObjectTypeMask(AudioObjectType* mask);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudioclient/nf-spatialaudioclient-ispatialaudioclient-getmaxdynamicobjectcount))], [])
    HRESULT GetMaxDynamicObjectCount(uint* value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudioclient/nf-spatialaudioclient-ispatialaudioclient-getsupportedaudioobjectformatenumerator))], [])
    HRESULT GetSupportedAudioObjectFormatEnumerator(IAudioFormatEnumerator* enumerator);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudioclient/nf-spatialaudioclient-ispatialaudioclient-getmaxframecount))], [])
    HRESULT GetMaxFrameCount(const(WAVEFORMATEX)* objectFormat, uint* frameCountPerBuffer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudioclient/nf-spatialaudioclient-ispatialaudioclient-isaudioobjectformatsupported))], [])
    HRESULT IsAudioObjectFormatSupported(const(WAVEFORMATEX)* objectFormat);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudioclient/nf-spatialaudioclient-ispatialaudioclient-isspatialaudiostreamavailable))], [])
    HRESULT IsSpatialAudioStreamAvailable(const(GUID)* streamUuid, const(PROPVARIANT)* auxiliaryInfo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudioclient/nf-spatialaudioclient-ispatialaudioclient-activatespatialaudiostream))], [])
    HRESULT ActivateSpatialAudioStream(const(PROPVARIANT)* activationParams, const(GUID)* riid, void** stream);
}

@GUID("caabe452-a66a-4bee-a93e-e320463f6a53")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudioclient/nn-spatialaudioclient-ispatialaudioclient2))], [])
interface ISpatialAudioClient2 : ISpatialAudioClient
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudioclient/nf-spatialaudioclient-ispatialaudioclient2-isoffloadcapable))], [])
    HRESULT IsOffloadCapable(AUDIO_STREAM_CATEGORY category, BOOL* isOffloadCapable);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudioclient/nf-spatialaudioclient-ispatialaudioclient2-getmaxframecountforcategory))], [])
    HRESULT GetMaxFrameCountForCategory(AUDIO_STREAM_CATEGORY category, BOOL offloadEnabled, 
                                        const(WAVEFORMATEX)* objectFormat, uint* frameCountPerBuffer);
}

@GUID("d7436ade-1978-4e14-aba0-555bd8eb83b4")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiohrtf/nn-spatialaudiohrtf-ispatialaudioobjectforhrtf))], [])
interface ISpatialAudioObjectForHrtf : ISpatialAudioObjectBase
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiohrtf/nf-spatialaudiohrtf-ispatialaudioobjectforhrtf-setposition))], [])
    HRESULT SetPosition(float x, float y, float z);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiohrtf/nf-spatialaudiohrtf-ispatialaudioobjectforhrtf-setgain))], [])
    HRESULT SetGain(float gain);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiohrtf/nf-spatialaudiohrtf-ispatialaudioobjectforhrtf-setorientation))], [])
    HRESULT SetOrientation(const(float)** orientation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiohrtf/nf-spatialaudiohrtf-ispatialaudioobjectforhrtf-setenvironment))], [])
    HRESULT SetEnvironment(SpatialAudioHrtfEnvironmentType environment);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiohrtf/nf-spatialaudiohrtf-ispatialaudioobjectforhrtf-setdistancedecay))], [])
    HRESULT SetDistanceDecay(SpatialAudioHrtfDistanceDecay* distanceDecay);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiohrtf/nf-spatialaudiohrtf-ispatialaudioobjectforhrtf-setdirectivity))], [])
    HRESULT SetDirectivity(SpatialAudioHrtfDirectivityUnion* directivity);
}

@GUID("e08deef9-5363-406e-9fdc-080ee247bbe0")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiohrtf/nn-spatialaudiohrtf-ispatialaudioobjectrenderstreamforhrtf))], [])
interface ISpatialAudioObjectRenderStreamForHrtf : ISpatialAudioObjectRenderStreamBase
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiohrtf/nf-spatialaudiohrtf-ispatialaudioobjectrenderstreamforhrtf-activatespatialaudioobjectforhrtf))], [])
    HRESULT ActivateSpatialAudioObjectForHrtf(AudioObjectType type, ISpatialAudioObjectForHrtf* audioObject);
}

@GUID("7991eec9-7e89-4d85-8390-6c703cec60c0")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmdeviceapi/nn-mmdeviceapi-immnotificationclient))], [])
interface IMMNotificationClient : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmdeviceapi/nf-mmdeviceapi-immnotificationclient-ondevicestatechanged))], [])
    HRESULT OnDeviceStateChanged(const(PWSTR) pwstrDeviceId, DEVICE_STATE dwNewState);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmdeviceapi/nf-mmdeviceapi-immnotificationclient-ondeviceadded))], [])
    HRESULT OnDeviceAdded(const(PWSTR) pwstrDeviceId);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmdeviceapi/nf-mmdeviceapi-immnotificationclient-ondeviceremoved))], [])
    HRESULT OnDeviceRemoved(const(PWSTR) pwstrDeviceId);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmdeviceapi/nf-mmdeviceapi-immnotificationclient-ondefaultdevicechanged))], [])
    HRESULT OnDefaultDeviceChanged(EDataFlow flow, ERole role, const(PWSTR) pwstrDefaultDeviceId);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmdeviceapi/nf-mmdeviceapi-immnotificationclient-onpropertyvaluechanged))], [])
    HRESULT OnPropertyValueChanged(const(PWSTR) pwstrDeviceId, const(PROPERTYKEY) key);
}

@GUID("d666063f-1587-4e43-81f1-b948e807363f")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmdeviceapi/nn-mmdeviceapi-immdevice))], [])
interface IMMDevice : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmdeviceapi/nf-mmdeviceapi-immdevice-activate))], [])
    HRESULT Activate(const(GUID)* iid, CLSCTX dwClsCtx, PROPVARIANT* pActivationParams, void** ppInterface);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmdeviceapi/nf-mmdeviceapi-immdevice-openpropertystore))], [])
    HRESULT OpenPropertyStore(STGM stgmAccess, IPropertyStore* ppProperties);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmdeviceapi/nf-mmdeviceapi-immdevice-getid))], [])
    HRESULT GetId(PWSTR* ppstrId);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmdeviceapi/nf-mmdeviceapi-immdevice-getstate))], [])
    HRESULT GetState(DEVICE_STATE* pdwState);
}

@GUID("0bd7a1be-7a1a-44db-8397-cc5392387b5e")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmdeviceapi/nn-mmdeviceapi-immdevicecollection))], [])
interface IMMDeviceCollection : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmdeviceapi/nf-mmdeviceapi-immdevicecollection-getcount))], [])
    HRESULT GetCount(uint* pcDevices);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmdeviceapi/nf-mmdeviceapi-immdevicecollection-item))], [])
    HRESULT Item(uint nDevice, IMMDevice* ppDevice);
}

@GUID("1be09788-6894-4089-8586-9a2a6c265ac5")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmdeviceapi/nn-mmdeviceapi-immendpoint))], [])
interface IMMEndpoint : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmdeviceapi/nf-mmdeviceapi-immendpoint-getdataflow))], [])
    HRESULT GetDataFlow(EDataFlow* pDataFlow);
}

@GUID("a95664d2-9614-4f35-a746-de8db63617e6")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmdeviceapi/nn-mmdeviceapi-immdeviceenumerator))], [])
interface IMMDeviceEnumerator : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmdeviceapi/nf-mmdeviceapi-immdeviceenumerator-enumaudioendpoints))], [])
    HRESULT EnumAudioEndpoints(EDataFlow dataFlow, DEVICE_STATE dwStateMask, IMMDeviceCollection* ppDevices);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmdeviceapi/nf-mmdeviceapi-immdeviceenumerator-getdefaultaudioendpoint))], [])
    HRESULT GetDefaultAudioEndpoint(EDataFlow dataFlow, ERole role, IMMDevice* ppEndpoint);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmdeviceapi/nf-mmdeviceapi-immdeviceenumerator-getdevice))], [])
    HRESULT GetDevice(const(PWSTR) pwstrId, IMMDevice* ppDevice);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmdeviceapi/nf-mmdeviceapi-immdeviceenumerator-registerendpointnotificationcallback))], [])
    HRESULT RegisterEndpointNotificationCallback(IMMNotificationClient pClient);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmdeviceapi/nf-mmdeviceapi-immdeviceenumerator-unregisterendpointnotificationcallback))], [])
    HRESULT UnregisterEndpointNotificationCallback(IMMNotificationClient pClient);
}

@GUID("3b0d0ea4-d0a9-4b0e-935b-09516746fac0")
interface IMMDeviceActivator : IUnknown
{
    HRESULT Activate(const(GUID)* iid, IMMDevice pDevice, PROPVARIANT* pActivationParams, void** ppInterface);
}

@GUID("41d949ab-9862-444a-80f6-c261334da5eb")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmdeviceapi/nn-mmdeviceapi-iactivateaudiointerfacecompletionhandler))], [])
interface IActivateAudioInterfaceCompletionHandler : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmdeviceapi/nf-mmdeviceapi-iactivateaudiointerfacecompletionhandler-activatecompleted))], [])
    HRESULT ActivateCompleted(IActivateAudioInterfaceAsyncOperation activateOperation);
}

@GUID("72a22d78-cde4-431d-b8cc-843a71199b6d")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmdeviceapi/nn-mmdeviceapi-iactivateaudiointerfaceasyncoperation))], [])
interface IActivateAudioInterfaceAsyncOperation : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmdeviceapi/nf-mmdeviceapi-iactivateaudiointerfaceasyncoperation-getactivateresult))], [])
    HRESULT GetActivateResult(HRESULT* activateResult, IUnknown* activatedInterface);
}

@GUID("20049d40-56d5-400e-a2ef-385599feed49")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmdeviceapi/nn-mmdeviceapi-iaudiosystemeffectspropertychangenotificationclient))], [])
interface IAudioSystemEffectsPropertyChangeNotificationClient : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmdeviceapi/nf-mmdeviceapi-iaudiosystemeffectspropertychangenotificationclient-onpropertychanged))], [])
    HRESULT OnPropertyChanged(AUDIO_SYSTEMEFFECTS_PROPERTYSTORE_TYPE type, const(PROPERTYKEY) key);
}

@GUID("302ae7f9-d7e0-43e4-971b-1f8293613d2a")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmdeviceapi/nn-mmdeviceapi-iaudiosystemeffectspropertystore))], [])
interface IAudioSystemEffectsPropertyStore : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmdeviceapi/nf-mmdeviceapi-iaudiosystemeffectspropertystore-opendefaultpropertystore))], [])
    HRESULT OpenDefaultPropertyStore(uint stgmAccess, IPropertyStore* propStore);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmdeviceapi/nf-mmdeviceapi-iaudiosystemeffectspropertystore-openuserpropertystore))], [])
    HRESULT OpenUserPropertyStore(uint stgmAccess, IPropertyStore* propStore);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmdeviceapi/nf-mmdeviceapi-iaudiosystemeffectspropertystore-openvolatilepropertystore))], [])
    HRESULT OpenVolatilePropertyStore(uint stgmAccess, IPropertyStore* propStore);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmdeviceapi/nf-mmdeviceapi-iaudiosystemeffectspropertystore-resetuserpropertystore))], [])
    HRESULT ResetUserPropertyStore();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmdeviceapi/nf-mmdeviceapi-iaudiosystemeffectspropertystore-resetvolatilepropertystore))], [])
    HRESULT ResetVolatilePropertyStore();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmdeviceapi/nf-mmdeviceapi-iaudiosystemeffectspropertystore-registerpropertychangenotification))], [])
    HRESULT RegisterPropertyChangeNotification(IAudioSystemEffectsPropertyChangeNotificationClient callback);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mmdeviceapi/nf-mmdeviceapi-iaudiosystemeffectspropertystore-unregisterpropertychangenotification))], [])
    HRESULT UnregisterPropertyChangeNotification(IAudioSystemEffectsPropertyChangeNotificationClient callback);
}

@GUID("c2f8e001-f205-4bc9-99bc-c13b1e048ccb")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nn-devicetopology-iperchanneldblevel))], [])
interface IPerChannelDbLevel : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-iperchanneldblevel-getchannelcount))], [])
    HRESULT GetChannelCount(uint* pcChannels);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-iperchanneldblevel-getlevelrange))], [])
    HRESULT GetLevelRange(uint nChannel, float* pfMinLevelDB, float* pfMaxLevelDB, float* pfStepping);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-iperchanneldblevel-getlevel))], [])
    HRESULT GetLevel(uint nChannel, float* pfLevelDB);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-iperchanneldblevel-setlevel))], [])
    HRESULT SetLevel(uint nChannel, float fLevelDB, const(GUID)* pguidEventContext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-iperchanneldblevel-setleveluniform))], [])
    HRESULT SetLevelUniform(float fLevelDB, const(GUID)* pguidEventContext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-iperchanneldblevel-setlevelallchannels))], [])
    HRESULT SetLevelAllChannels(float* aLevelsDB, uint cChannels, const(GUID)* pguidEventContext);
}

@GUID("7fb7b48f-531d-44a2-bcb3-5ad5a134b3dc")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nn-devicetopology-iaudiovolumelevel))], [])
interface IAudioVolumeLevel : IPerChannelDbLevel
{
}

@GUID("bb11c46f-ec28-493c-b88a-5db88062ce98")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nn-devicetopology-iaudiochannelconfig))], [])
interface IAudioChannelConfig : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-iaudiochannelconfig-setchannelconfig))], [])
    HRESULT SetChannelConfig(uint dwConfig, const(GUID)* pguidEventContext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-iaudiochannelconfig-getchannelconfig))], [])
    HRESULT GetChannelConfig(uint* pdwConfig);
}

@GUID("7d8b1437-dd53-4350-9c1b-1ee2890bd938")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nn-devicetopology-iaudioloudness))], [])
interface IAudioLoudness : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-iaudioloudness-getenabled))], [])
    HRESULT GetEnabled(BOOL* pbEnabled);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-iaudioloudness-setenabled))], [])
    HRESULT SetEnabled(BOOL bEnable, const(GUID)* pguidEventContext);
}

@GUID("4f03dc02-5e6e-4653-8f72-a030c123d598")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nn-devicetopology-iaudioinputselector))], [])
interface IAudioInputSelector : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-iaudioinputselector-getselection))], [])
    HRESULT GetSelection(uint* pnIdSelected);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-iaudioinputselector-setselection))], [])
    HRESULT SetSelection(uint nIdSelect, const(GUID)* pguidEventContext);
}

@GUID("bb515f69-94a7-429e-8b9c-271b3f11a3ab")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nn-devicetopology-iaudiooutputselector))], [])
interface IAudioOutputSelector : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-iaudiooutputselector-getselection))], [])
    HRESULT GetSelection(uint* pnIdSelected);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-iaudiooutputselector-setselection))], [])
    HRESULT SetSelection(uint nIdSelect, const(GUID)* pguidEventContext);
}

@GUID("df45aeea-b74a-4b6b-afad-2366b6aa012e")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nn-devicetopology-iaudiomute))], [])
interface IAudioMute : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-iaudiomute-setmute))], [])
    HRESULT SetMute(BOOL bMuted, const(GUID)* pguidEventContext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-iaudiomute-getmute))], [])
    HRESULT GetMute(BOOL* pbMuted);
}

@GUID("a2b1a1d9-4db3-425d-a2b2-bd335cb3e2e5")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nn-devicetopology-iaudiobass))], [])
interface IAudioBass : IPerChannelDbLevel
{
}

@GUID("5e54b6d7-b44b-40d9-9a9e-e691d9ce6edf")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nn-devicetopology-iaudiomidrange))], [])
interface IAudioMidrange : IPerChannelDbLevel
{
}

@GUID("0a717812-694e-4907-b74b-bafa5cfdca7b")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nn-devicetopology-iaudiotreble))], [])
interface IAudioTreble : IPerChannelDbLevel
{
}

@GUID("85401fd4-6de4-4b9d-9869-2d6753a82f3c")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nn-devicetopology-iaudioautogaincontrol))], [])
interface IAudioAutoGainControl : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-iaudioautogaincontrol-getenabled))], [])
    HRESULT GetEnabled(BOOL* pbEnabled);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-iaudioautogaincontrol-setenabled))], [])
    HRESULT SetEnabled(BOOL bEnable, const(GUID)* pguidEventContext);
}

@GUID("dd79923c-0599-45e0-b8b6-c8df7db6e796")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nn-devicetopology-iaudiopeakmeter))], [])
interface IAudioPeakMeter : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-iaudiopeakmeter-getchannelcount))], [])
    HRESULT GetChannelCount(uint* pcChannels);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-iaudiopeakmeter-getlevel))], [])
    HRESULT GetLevel(uint nChannel, float* pfLevel);
}

@GUID("3b22bcbf-2586-4af0-8583-205d391b807c")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nn-devicetopology-idevicespecificproperty))], [])
interface IDeviceSpecificProperty : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-idevicespecificproperty-gettype))], [])
    HRESULT GetType(ushort* pVType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-idevicespecificproperty-getvalue))], [])
    HRESULT GetValue(void* pvValue, uint* pcbValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-idevicespecificproperty-setvalue))], [])
    HRESULT SetValue(void* pvValue, uint cbValue, const(GUID)* pguidEventContext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-idevicespecificproperty-get4brange))], [])
    HRESULT Get4BRange(int* plMin, int* plMax, int* plStepping);
}

@GUID("6daa848c-5eb0-45cc-aea5-998a2cda1ffb")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nn-devicetopology-ipartslist))], [])
interface IPartsList : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-ipartslist-getcount))], [])
    HRESULT GetCount(uint* pCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-ipartslist-getpart))], [])
    HRESULT GetPart(uint nIndex, IPart* ppPart);
}

@GUID("ae2de0e4-5bca-4f2d-aa46-5d13f8fdb3a9")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nn-devicetopology-ipart))], [])
interface IPart : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-ipart-getname))], [])
    HRESULT GetName(PWSTR* ppwstrName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-ipart-getlocalid))], [])
    HRESULT GetLocalId(uint* pnId);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-ipart-getglobalid))], [])
    HRESULT GetGlobalId(PWSTR* ppwstrGlobalId);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-ipart-getparttype))], [])
    HRESULT GetPartType(PartType* pPartType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-ipart-getsubtype))], [])
    HRESULT GetSubType(GUID* pSubType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-ipart-getcontrolinterfacecount))], [])
    HRESULT GetControlInterfaceCount(uint* pCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-ipart-getcontrolinterface))], [])
    HRESULT GetControlInterface(uint nIndex, IControlInterface* ppInterfaceDesc);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-ipart-enumpartsincoming))], [])
    HRESULT EnumPartsIncoming(IPartsList* ppParts);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-ipart-enumpartsoutgoing))], [])
    HRESULT EnumPartsOutgoing(IPartsList* ppParts);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-ipart-gettopologyobject))], [])
    HRESULT GetTopologyObject(IDeviceTopology* ppTopology);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-ipart-activate))], [])
    HRESULT Activate(uint dwClsContext, const(GUID)* refiid, void** ppvObject);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-ipart-registercontrolchangecallback))], [])
    HRESULT RegisterControlChangeCallback(const(GUID)* riid, IControlChangeNotify pNotify);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-ipart-unregistercontrolchangecallback))], [])
    HRESULT UnregisterControlChangeCallback(IControlChangeNotify pNotify);
}

@GUID("9c2c4058-23f5-41de-877a-df3af236a09e")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nn-devicetopology-iconnector))], [])
interface IConnector : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-iconnector-gettype))], [])
    HRESULT GetType(ConnectorType* pType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-iconnector-getdataflow))], [])
    HRESULT GetDataFlow(DataFlow* pFlow);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-iconnector-connectto))], [])
    HRESULT ConnectTo(IConnector pConnectTo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-iconnector-disconnect))], [])
    HRESULT Disconnect();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-iconnector-isconnected))], [])
    HRESULT IsConnected(BOOL* pbConnected);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-iconnector-getconnectedto))], [])
    HRESULT GetConnectedTo(IConnector* ppConTo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-iconnector-getconnectoridconnectedto))], [])
    HRESULT GetConnectorIdConnectedTo(PWSTR* ppwstrConnectorId);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-iconnector-getdeviceidconnectedto))], [])
    HRESULT GetDeviceIdConnectedTo(PWSTR* ppwstrDeviceId);
}

@GUID("82149a85-dba6-4487-86bb-ea8f7fefcc71")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nn-devicetopology-isubunit))], [])
interface ISubunit : IUnknown
{
}

@GUID("45d37c3f-5140-444a-ae24-400789f3cbf3")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nn-devicetopology-icontrolinterface))], [])
interface IControlInterface : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-icontrolinterface-getname))], [])
    HRESULT GetName(PWSTR* ppwstrName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-icontrolinterface-getiid))], [])
    HRESULT GetIID(GUID* pIID);
}

@GUID("a09513ed-c709-4d21-bd7b-5f34c47f3947")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nn-devicetopology-icontrolchangenotify))], [])
interface IControlChangeNotify : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-icontrolchangenotify-onnotify))], [])
    HRESULT OnNotify(uint dwSenderProcessId, const(GUID)* pguidEventContext);
}

@GUID("2a07407e-6497-4a18-9787-32f79bd0d98f")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nn-devicetopology-idevicetopology))], [])
interface IDeviceTopology : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-idevicetopology-getconnectorcount))], [])
    HRESULT GetConnectorCount(uint* pCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-idevicetopology-getconnector))], [])
    HRESULT GetConnector(uint nIndex, IConnector* ppConnector);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-idevicetopology-getsubunitcount))], [])
    HRESULT GetSubunitCount(uint* pCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-idevicetopology-getsubunit))], [])
    HRESULT GetSubunit(uint nIndex, ISubunit* ppSubunit);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-idevicetopology-getpartbyid))], [])
    HRESULT GetPartById(uint nId, IPart* ppPart);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-idevicetopology-getdeviceid))], [])
    HRESULT GetDeviceId(PWSTR* ppwstrDeviceId);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/devicetopology/nf-devicetopology-idevicetopology-getsignalpath))], [])
    HRESULT GetSignalPath(IPart pIPartFrom, IPart pIPartTo, BOOL bRejectMixedPaths, IPartsList* ppParts);
}

@GUID("24918acc-64b3-37c1-8ca9-74a66e9957a8")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audiopolicy/nn-audiopolicy-iaudiosessionevents))], [])
interface IAudioSessionEvents : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audiopolicy/nf-audiopolicy-iaudiosessionevents-ondisplaynamechanged))], [])
    HRESULT OnDisplayNameChanged(const(PWSTR) NewDisplayName, const(GUID)* EventContext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audiopolicy/nf-audiopolicy-iaudiosessionevents-oniconpathchanged))], [])
    HRESULT OnIconPathChanged(const(PWSTR) NewIconPath, const(GUID)* EventContext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audiopolicy/nf-audiopolicy-iaudiosessionevents-onsimplevolumechanged))], [])
    HRESULT OnSimpleVolumeChanged(float NewVolume, BOOL NewMute, const(GUID)* EventContext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audiopolicy/nf-audiopolicy-iaudiosessionevents-onchannelvolumechanged))], [])
    HRESULT OnChannelVolumeChanged(uint ChannelCount, float* NewChannelVolumeArray, uint ChangedChannel, 
                                   const(GUID)* EventContext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audiopolicy/nf-audiopolicy-iaudiosessionevents-ongroupingparamchanged))], [])
    HRESULT OnGroupingParamChanged(const(GUID)* NewGroupingParam, const(GUID)* EventContext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audiopolicy/nf-audiopolicy-iaudiosessionevents-onstatechanged))], [])
    HRESULT OnStateChanged(AudioSessionState NewState);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audiopolicy/nf-audiopolicy-iaudiosessionevents-onsessiondisconnected))], [])
    HRESULT OnSessionDisconnected(AudioSessionDisconnectReason DisconnectReason);
}

@GUID("f4b1a599-7266-4319-a8ca-e70acb11e8cd")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audiopolicy/nn-audiopolicy-iaudiosessioncontrol))], [])
interface IAudioSessionControl : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audiopolicy/nf-audiopolicy-iaudiosessioncontrol-getstate))], [])
    HRESULT GetState(AudioSessionState* pRetVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audiopolicy/nf-audiopolicy-iaudiosessioncontrol-getdisplayname))], [])
    HRESULT GetDisplayName(PWSTR* pRetVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audiopolicy/nf-audiopolicy-iaudiosessioncontrol-setdisplayname))], [])
    HRESULT SetDisplayName(const(PWSTR) Value, const(GUID)* EventContext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audiopolicy/nf-audiopolicy-iaudiosessioncontrol-geticonpath))], [])
    HRESULT GetIconPath(PWSTR* pRetVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audiopolicy/nf-audiopolicy-iaudiosessioncontrol-seticonpath))], [])
    HRESULT SetIconPath(const(PWSTR) Value, const(GUID)* EventContext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audiopolicy/nf-audiopolicy-iaudiosessioncontrol-getgroupingparam))], [])
    HRESULT GetGroupingParam(GUID* pRetVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audiopolicy/nf-audiopolicy-iaudiosessioncontrol-setgroupingparam))], [])
    HRESULT SetGroupingParam(const(GUID)* Override, const(GUID)* EventContext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audiopolicy/nf-audiopolicy-iaudiosessioncontrol-registeraudiosessionnotification))], [])
    HRESULT RegisterAudioSessionNotification(IAudioSessionEvents NewNotifications);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audiopolicy/nf-audiopolicy-iaudiosessioncontrol-unregisteraudiosessionnotification))], [])
    HRESULT UnregisterAudioSessionNotification(IAudioSessionEvents NewNotifications);
}

@GUID("bfb7ff88-7239-4fc9-8fa2-07c950be9c6d")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audiopolicy/nn-audiopolicy-iaudiosessioncontrol2))], [])
interface IAudioSessionControl2 : IAudioSessionControl
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audiopolicy/nf-audiopolicy-iaudiosessioncontrol2-getsessionidentifier))], [])
    HRESULT GetSessionIdentifier(PWSTR* pRetVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audiopolicy/nf-audiopolicy-iaudiosessioncontrol2-getsessioninstanceidentifier))], [])
    HRESULT GetSessionInstanceIdentifier(PWSTR* pRetVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audiopolicy/nf-audiopolicy-iaudiosessioncontrol2-getprocessid))], [])
    HRESULT GetProcessId(uint* pRetVal);
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT IsSystemSoundsSession();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audiopolicy/nf-audiopolicy-iaudiosessioncontrol2-setduckingpreference))], [])
    HRESULT SetDuckingPreference(BOOL optOut);
}

@GUID("bfa971f1-4d5e-40bb-935e-967039bfbee4")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audiopolicy/nn-audiopolicy-iaudiosessionmanager))], [])
interface IAudioSessionManager : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audiopolicy/nf-audiopolicy-iaudiosessionmanager-getaudiosessioncontrol))], [])
    HRESULT GetAudioSessionControl(const(GUID)* AudioSessionGuid, uint StreamFlags, 
                                   IAudioSessionControl* SessionControl);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audiopolicy/nf-audiopolicy-iaudiosessionmanager-getsimpleaudiovolume))], [])
    HRESULT GetSimpleAudioVolume(const(GUID)* AudioSessionGuid, uint StreamFlags, ISimpleAudioVolume* AudioVolume);
}

@GUID("c3b284d4-6d39-4359-b3cf-b56ddb3bb39c")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audiopolicy/nn-audiopolicy-iaudiovolumeducknotification))], [])
interface IAudioVolumeDuckNotification : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audiopolicy/nf-audiopolicy-iaudiovolumeducknotification-onvolumeducknotification))], [])
    HRESULT OnVolumeDuckNotification(const(PWSTR) sessionID, uint countCommunicationSessions);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audiopolicy/nf-audiopolicy-iaudiovolumeducknotification-onvolumeunducknotification))], [])
    HRESULT OnVolumeUnduckNotification(const(PWSTR) sessionID);
}

@GUID("641dd20b-4d41-49cc-aba3-174b9477bb08")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audiopolicy/nn-audiopolicy-iaudiosessionnotification))], [])
interface IAudioSessionNotification : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audiopolicy/nf-audiopolicy-iaudiosessionnotification-onsessioncreated))], [])
    HRESULT OnSessionCreated(IAudioSessionControl NewSession);
}

@GUID("e2f5bb11-0570-40ca-acdd-3aa01277dee8")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audiopolicy/nn-audiopolicy-iaudiosessionenumerator))], [])
interface IAudioSessionEnumerator : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audiopolicy/nf-audiopolicy-iaudiosessionenumerator-getcount))], [])
    HRESULT GetCount(int* SessionCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audiopolicy/nf-audiopolicy-iaudiosessionenumerator-getsession))], [])
    HRESULT GetSession(int SessionCount, IAudioSessionControl* Session);
}

@GUID("77aa99a0-1bd6-484f-8bc7-2c654c9a9b6f")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audiopolicy/nn-audiopolicy-iaudiosessionmanager2))], [])
interface IAudioSessionManager2 : IAudioSessionManager
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audiopolicy/nf-audiopolicy-iaudiosessionmanager2-getsessionenumerator))], [])
    HRESULT GetSessionEnumerator(IAudioSessionEnumerator* SessionEnum);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audiopolicy/nf-audiopolicy-iaudiosessionmanager2-registersessionnotification))], [])
    HRESULT RegisterSessionNotification(IAudioSessionNotification SessionNotification);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audiopolicy/nf-audiopolicy-iaudiosessionmanager2-unregistersessionnotification))], [])
    HRESULT UnregisterSessionNotification(IAudioSessionNotification SessionNotification);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audiopolicy/nf-audiopolicy-iaudiosessionmanager2-registerducknotification))], [])
    HRESULT RegisterDuckNotification(const(PWSTR) sessionID, IAudioVolumeDuckNotification duckNotification);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/audiopolicy/nf-audiopolicy-iaudiosessionmanager2-unregisterducknotification))], [])
    HRESULT UnregisterDuckNotification(IAudioVolumeDuckNotification duckNotification);
}

@GUID("bcd7c78f-3098-4f22-b547-a2f25a381269")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiometadata/nn-spatialaudiometadata-ispatialaudiometadataitems))], [])
interface ISpatialAudioMetadataItems : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiometadata/nf-spatialaudiometadata-ispatialaudiometadataitems-getframecount))], [])
    HRESULT GetFrameCount(ushort* frameCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiometadata/nf-spatialaudiometadata-ispatialaudiometadataitems-getitemcount))], [])
    HRESULT GetItemCount(ushort* itemCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiometadata/nf-spatialaudiometadata-ispatialaudiometadataitems-getmaxitemcount))], [])
    HRESULT GetMaxItemCount(ushort* maxItemCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiometadata/nf-spatialaudiometadata-ispatialaudiometadataitems-getmaxvaluebufferlength))], [])
    HRESULT GetMaxValueBufferLength(uint* maxValueBufferLength);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiometadata/nf-spatialaudiometadata-ispatialaudiometadataitems-getinfo))], [])
    HRESULT GetInfo(SpatialAudioMetadataItemsInfo* info);
}

@GUID("1b17ca01-2955-444d-a430-537dc589a844")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiometadata/nn-spatialaudiometadata-ispatialaudiometadatawriter))], [])
interface ISpatialAudioMetadataWriter : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiometadata/nf-spatialaudiometadata-ispatialaudiometadatawriter-open))], [])
    HRESULT Open(ISpatialAudioMetadataItems metadataItems);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiometadata/nf-spatialaudiometadata-ispatialaudiometadatawriter-writenextitem))], [])
    HRESULT WriteNextItem(ushort frameOffset);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiometadata/nf-spatialaudiometadata-ispatialaudiometadatawriter-writenextitemcommand))], [])
    HRESULT WriteNextItemCommand(ubyte commandID, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(void)* valueBuffer, 
                                 uint valueBufferLength);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/CoreAudio/ispatialaudiometadatawriter-close))], [])
    HRESULT Close();
}

@GUID("b78e86a2-31d9-4c32-94d2-7df40fc7ebec")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiometadata/nn-spatialaudiometadata-ispatialaudiometadatareader))], [])
interface ISpatialAudioMetadataReader : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiometadata/nf-spatialaudiometadata-ispatialaudiometadatareader-open))], [])
    HRESULT Open(ISpatialAudioMetadataItems metadataItems);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiometadata/nf-spatialaudiometadata-ispatialaudiometadatareader-readnextitem))], [])
    HRESULT ReadNextItem(ubyte* commandCount, ushort* frameOffset);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiometadata/nf-spatialaudiometadata-ispatialaudiometadatareader-readnextitemcommand))], [])
    HRESULT ReadNextItemCommand(ubyte* commandID, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* valueBuffer, 
                                uint maxValueBufferLength, uint* valueBufferLength);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiometadata/nf-spatialaudiometadata-ispatialaudiometadatareader-close))], [])
    HRESULT Close();
}

@GUID("d224b233-e251-4fd0-9ca2-d5ecf9a68404")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiometadata/nn-spatialaudiometadata-ispatialaudiometadatacopier))], [])
interface ISpatialAudioMetadataCopier : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiometadata/nf-spatialaudiometadata-ispatialaudiometadatacopier-open))], [])
    HRESULT Open(ISpatialAudioMetadataItems metadataItems);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiometadata/nf-spatialaudiometadata-ispatialaudiometadatacopier-copymetadataforframes))], [])
    HRESULT CopyMetadataForFrames(ushort copyFrameCount, SpatialAudioMetadataCopyMode copyMode, 
                                  ISpatialAudioMetadataItems dstMetadataItems, ushort* itemsCopied);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiometadata/nf-spatialaudiometadata-ispatialaudiometadatacopier-close))], [])
    HRESULT Close();
}

@GUID("42640a16-e1bd-42d9-9ff6-031ab71a2dba")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiometadata/nn-spatialaudiometadata-ispatialaudiometadataitemsbuffer))], [])
interface ISpatialAudioMetadataItemsBuffer : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiometadata/nf-spatialaudiometadata-ispatialaudiometadataitemsbuffer-attachtobuffer))], [])
    HRESULT AttachToBuffer(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/ubyte* buffer, 
                           uint bufferLength);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiometadata/nf-spatialaudiometadata-ispatialaudiometadataitemsbuffer-attachtopopulatedbuffer))], [])
    HRESULT AttachToPopulatedBuffer(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/ubyte* buffer, 
                                    uint bufferLength);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiometadata/nf-spatialaudiometadata-ispatialaudiometadataitemsbuffer-detachbuffer))], [])
    HRESULT DetachBuffer();
}

@GUID("777d4a3b-f6ff-4a26-85dc-68d7cdeda1d4")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiometadata/nn-spatialaudiometadata-ispatialaudiometadataclient))], [])
interface ISpatialAudioMetadataClient : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiometadata/nf-spatialaudiometadata-ispatialaudiometadataclient-activatespatialaudiometadataitems))], [])
    HRESULT ActivateSpatialAudioMetadataItems(ushort maxItemCount, ushort frameCount, 
                                              ISpatialAudioMetadataItemsBuffer* metadataItemsBuffer, 
                                              ISpatialAudioMetadataItems* metadataItems);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiometadata/nf-spatialaudiometadata-ispatialaudiometadataclient-getspatialaudiometadataitemsbufferlength))], [])
    HRESULT GetSpatialAudioMetadataItemsBufferLength(ushort maxItemCount, uint* bufferLength);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiometadata/nf-spatialaudiometadata-ispatialaudiometadataclient-activatespatialaudiometadatawriter))], [])
    HRESULT ActivateSpatialAudioMetadataWriter(SpatialAudioMetadataWriterOverflowMode overflowMode, 
                                               ISpatialAudioMetadataWriter* metadataWriter);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiometadata/nf-spatialaudiometadata-ispatialaudiometadataclient-activatespatialaudiometadatacopier))], [])
    HRESULT ActivateSpatialAudioMetadataCopier(ISpatialAudioMetadataCopier* metadataCopier);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiometadata/nf-spatialaudiometadata-ispatialaudiometadataclient-activatespatialaudiometadatareader))], [])
    HRESULT ActivateSpatialAudioMetadataReader(ISpatialAudioMetadataReader* metadataReader);
}

@GUID("0df2c94b-f5f9-472d-af6b-c46e0ac9cd05")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiometadata/nn-spatialaudiometadata-ispatialaudioobjectformetadatacommands))], [])
interface ISpatialAudioObjectForMetadataCommands : ISpatialAudioObjectBase
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiometadata/nf-spatialaudiometadata-ispatialaudioobjectformetadatacommands-writenextmetadatacommand))], [])
    HRESULT WriteNextMetadataCommand(ubyte commandID, 
                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* valueBuffer, 
                                     uint valueBufferLength);
}

@GUID("ddea49ff-3bc0-4377-8aad-9fbcfd808566")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiometadata/nn-spatialaudiometadata-ispatialaudioobjectformetadataitems))], [])
interface ISpatialAudioObjectForMetadataItems : ISpatialAudioObjectBase
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiometadata/nf-spatialaudiometadata-ispatialaudioobjectformetadataitems-getspatialaudiometadataitems))], [])
    HRESULT GetSpatialAudioMetadataItems(ISpatialAudioMetadataItems* metadataItems);
}

@GUID("bbc9c907-48d5-4a2e-a0c7-f7f0d67c1fb1")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiometadata/nn-spatialaudiometadata-ispatialaudioobjectrenderstreamformetadata))], [])
interface ISpatialAudioObjectRenderStreamForMetadata : ISpatialAudioObjectRenderStreamBase
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiometadata/nf-spatialaudiometadata-ispatialaudioobjectrenderstreamformetadata-activatespatialaudioobjectformetadatacommands))], [])
    HRESULT ActivateSpatialAudioObjectForMetadataCommands(AudioObjectType type, 
                                                          ISpatialAudioObjectForMetadataCommands* audioObject);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/spatialaudiometadata/nf-spatialaudiometadata-ispatialaudioobjectrenderstreamformetadata-activatespatialaudioobjectformetadataitems))], [])
    HRESULT ActivateSpatialAudioObjectForMetadataItems(AudioObjectType type, 
                                                       ISpatialAudioObjectForMetadataItems* audioObject);
}

@GUID("63bd8738-e30d-4c77-bf5c-834e87c657e2")
interface IAudioStateMonitor : IUnknown
{
    HRESULT RegisterCallback(PAudioStateMonitorCallback callback, void* context, long* registration);
    void    UnregisterCallback(long registration);
    AudioStateMonitorSoundLevel GetSoundLevel();
}


// GUIDs

const GUID CLSID_DeviceTopology     = GUIDOF!DeviceTopology;
const GUID CLSID_MMDeviceEnumerator = GUIDOF!MMDeviceEnumerator;

const GUID IID_IAcousticEchoCancellationControl                    = GUIDOF!IAcousticEchoCancellationControl;
const GUID IID_IActivateAudioInterfaceAsyncOperation               = GUIDOF!IActivateAudioInterfaceAsyncOperation;
const GUID IID_IActivateAudioInterfaceCompletionHandler            = GUIDOF!IActivateAudioInterfaceCompletionHandler;
const GUID IID_IAudioAmbisonicsControl                             = GUIDOF!IAudioAmbisonicsControl;
const GUID IID_IAudioAutoGainControl                               = GUIDOF!IAudioAutoGainControl;
const GUID IID_IAudioBass                                          = GUIDOF!IAudioBass;
const GUID IID_IAudioCaptureClient                                 = GUIDOF!IAudioCaptureClient;
const GUID IID_IAudioChannelConfig                                 = GUIDOF!IAudioChannelConfig;
const GUID IID_IAudioClient                                        = GUIDOF!IAudioClient;
const GUID IID_IAudioClient2                                       = GUIDOF!IAudioClient2;
const GUID IID_IAudioClient3                                       = GUIDOF!IAudioClient3;
const GUID IID_IAudioClientDuckingControl                          = GUIDOF!IAudioClientDuckingControl;
const GUID IID_IAudioClock                                         = GUIDOF!IAudioClock;
const GUID IID_IAudioClock2                                        = GUIDOF!IAudioClock2;
const GUID IID_IAudioClockAdjustment                               = GUIDOF!IAudioClockAdjustment;
const GUID IID_IAudioEffectsChangedNotificationClient              = GUIDOF!IAudioEffectsChangedNotificationClient;
const GUID IID_IAudioEffectsManager                                = GUIDOF!IAudioEffectsManager;
const GUID IID_IAudioFormatEnumerator                              = GUIDOF!IAudioFormatEnumerator;
const GUID IID_IAudioInputSelector                                 = GUIDOF!IAudioInputSelector;
const GUID IID_IAudioLoudness                                      = GUIDOF!IAudioLoudness;
const GUID IID_IAudioMidrange                                      = GUIDOF!IAudioMidrange;
const GUID IID_IAudioMute                                          = GUIDOF!IAudioMute;
const GUID IID_IAudioOutputSelector                                = GUIDOF!IAudioOutputSelector;
const GUID IID_IAudioPeakMeter                                     = GUIDOF!IAudioPeakMeter;
const GUID IID_IAudioRenderClient                                  = GUIDOF!IAudioRenderClient;
const GUID IID_IAudioSessionControl                                = GUIDOF!IAudioSessionControl;
const GUID IID_IAudioSessionControl2                               = GUIDOF!IAudioSessionControl2;
const GUID IID_IAudioSessionEnumerator                             = GUIDOF!IAudioSessionEnumerator;
const GUID IID_IAudioSessionEvents                                 = GUIDOF!IAudioSessionEvents;
const GUID IID_IAudioSessionManager                                = GUIDOF!IAudioSessionManager;
const GUID IID_IAudioSessionManager2                               = GUIDOF!IAudioSessionManager2;
const GUID IID_IAudioSessionNotification                           = GUIDOF!IAudioSessionNotification;
const GUID IID_IAudioStateMonitor                                  = GUIDOF!IAudioStateMonitor;
const GUID IID_IAudioStreamVolume                                  = GUIDOF!IAudioStreamVolume;
const GUID IID_IAudioSystemEffectsPropertyChangeNotificationClient = GUIDOF!IAudioSystemEffectsPropertyChangeNotificationClient;
const GUID IID_IAudioSystemEffectsPropertyStore                    = GUIDOF!IAudioSystemEffectsPropertyStore;
const GUID IID_IAudioTreble                                        = GUIDOF!IAudioTreble;
const GUID IID_IAudioViewManagerService                            = GUIDOF!IAudioViewManagerService;
const GUID IID_IAudioVolumeDuckNotification                        = GUIDOF!IAudioVolumeDuckNotification;
const GUID IID_IAudioVolumeLevel                                   = GUIDOF!IAudioVolumeLevel;
const GUID IID_IChannelAudioVolume                                 = GUIDOF!IChannelAudioVolume;
const GUID IID_IConnector                                          = GUIDOF!IConnector;
const GUID IID_IControlChangeNotify                                = GUIDOF!IControlChangeNotify;
const GUID IID_IControlInterface                                   = GUIDOF!IControlInterface;
const GUID IID_IDeviceSpecificProperty                             = GUIDOF!IDeviceSpecificProperty;
const GUID IID_IDeviceTopology                                     = GUIDOF!IDeviceTopology;
const GUID IID_IMMDevice                                           = GUIDOF!IMMDevice;
const GUID IID_IMMDeviceActivator                                  = GUIDOF!IMMDeviceActivator;
const GUID IID_IMMDeviceCollection                                 = GUIDOF!IMMDeviceCollection;
const GUID IID_IMMDeviceEnumerator                                 = GUIDOF!IMMDeviceEnumerator;
const GUID IID_IMMEndpoint                                         = GUIDOF!IMMEndpoint;
const GUID IID_IMMNotificationClient                               = GUIDOF!IMMNotificationClient;
const GUID IID_IMessageFilter                                      = GUIDOF!IMessageFilter;
const GUID IID_IPart                                               = GUIDOF!IPart;
const GUID IID_IPartsList                                          = GUIDOF!IPartsList;
const GUID IID_IPerChannelDbLevel                                  = GUIDOF!IPerChannelDbLevel;
const GUID IID_ISimpleAudioVolume                                  = GUIDOF!ISimpleAudioVolume;
const GUID IID_ISpatialAudioClient                                 = GUIDOF!ISpatialAudioClient;
const GUID IID_ISpatialAudioClient2                                = GUIDOF!ISpatialAudioClient2;
const GUID IID_ISpatialAudioMetadataClient                         = GUIDOF!ISpatialAudioMetadataClient;
const GUID IID_ISpatialAudioMetadataCopier                         = GUIDOF!ISpatialAudioMetadataCopier;
const GUID IID_ISpatialAudioMetadataItems                          = GUIDOF!ISpatialAudioMetadataItems;
const GUID IID_ISpatialAudioMetadataItemsBuffer                    = GUIDOF!ISpatialAudioMetadataItemsBuffer;
const GUID IID_ISpatialAudioMetadataReader                         = GUIDOF!ISpatialAudioMetadataReader;
const GUID IID_ISpatialAudioMetadataWriter                         = GUIDOF!ISpatialAudioMetadataWriter;
const GUID IID_ISpatialAudioObject                                 = GUIDOF!ISpatialAudioObject;
const GUID IID_ISpatialAudioObjectBase                             = GUIDOF!ISpatialAudioObjectBase;
const GUID IID_ISpatialAudioObjectForHrtf                          = GUIDOF!ISpatialAudioObjectForHrtf;
const GUID IID_ISpatialAudioObjectForMetadataCommands              = GUIDOF!ISpatialAudioObjectForMetadataCommands;
const GUID IID_ISpatialAudioObjectForMetadataItems                 = GUIDOF!ISpatialAudioObjectForMetadataItems;
const GUID IID_ISpatialAudioObjectRenderStream                     = GUIDOF!ISpatialAudioObjectRenderStream;
const GUID IID_ISpatialAudioObjectRenderStreamBase                 = GUIDOF!ISpatialAudioObjectRenderStreamBase;
const GUID IID_ISpatialAudioObjectRenderStreamForHrtf              = GUIDOF!ISpatialAudioObjectRenderStreamForHrtf;
const GUID IID_ISpatialAudioObjectRenderStreamForMetadata          = GUIDOF!ISpatialAudioObjectRenderStreamForMetadata;
const GUID IID_ISpatialAudioObjectRenderStreamNotify               = GUIDOF!ISpatialAudioObjectRenderStreamNotify;
const GUID IID_ISubunit                                            = GUIDOF!ISubunit;
