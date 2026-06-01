// Written in the D programming language.

module windows.win32.media.audio.apo;

public import windows.core;
public import windows.win32.foundation.foundation : BOOL, HANDLE, HRESULT, LPARAM, PROPERTYKEY,
                                                    PWSTR;
public import windows.win32.media.audio.audio : AUDIO_SYSTEMEFFECTS_PROPERTYSTORE_TYPE, AUDIO_VOLUME_NOTIFICATION_DATA,
                                                IMMDevice, IMMDeviceCollection,
                                                WAVEFORMATEX;
public import windows.win32.system.com.com : IServiceProvider, IUnknown;
public import windows.win32.ui.shell.propertiessystem : IPropertyStore;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioapotypes/ne-audioapotypes-apo_buffer_flags
alias APO_BUFFER_FLAGS = int;
enum : int
{
    BUFFER_INVALID = 0x00000000,
    BUFFER_VALID   = 0x00000001,
    BUFFER_SILENT  = 0x00000002,
}

alias APO_CONNECTION_BUFFER_TYPE = int;
enum : int
{
    APO_CONNECTION_BUFFER_TYPE_ALLOCATED = 0x00000000,
    APO_CONNECTION_BUFFER_TYPE_EXTERNAL  = 0x00000001,
    APO_CONNECTION_BUFFER_TYPE_DEPENDANT = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioenginebaseapo/ne-audioenginebaseapo-apo_flag
alias APO_FLAG = int;
enum : int
{
    APO_FLAG_NONE                       = 0x00000000,
    APO_FLAG_INPLACE                    = 0x00000001,
    APO_FLAG_SAMPLESPERFRAME_MUST_MATCH = 0x00000002,
    APO_FLAG_FRAMESPERSECOND_MUST_MATCH = 0x00000004,
    APO_FLAG_BITSPERSAMPLE_MUST_MATCH   = 0x00000008,
    APO_FLAG_MIXER                      = 0x00000010,
    APO_FLAG_DEFAULT                    = 0x0000000e,
}

alias AUDIO_FLOW_TYPE = int;
enum : int
{
    AUDIO_FLOW_PULL = 0x00000000,
    AUDIO_FLOW_PUSH = 0x00000001,
}

enum EAudioConstriction : int
{
    eAudioConstrictionOff   = 0x00000000,
    eAudioConstriction48_16 = 0x00000001,
    eAudioConstriction44_16 = 0x00000002,
    eAudioConstriction14_14 = 0x00000003,
    eAudioConstrictionMute  = 0x00000004,
}

alias APO_REFERENCE_STREAM_PROPERTIES = int;
enum : int
{
    APO_REFERENCE_STREAM_PROPERTIES_NONE                 = 0x00000000,
    APO_REFERENCE_STREAM_PROPERTIES_POST_VOLUME_LOOPBACK = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineextensionapo/ne-audioengineextensionapo-audio_systemeffect_state
alias AUDIO_SYSTEMEFFECT_STATE = int;
enum : int
{
    AUDIO_SYSTEMEFFECT_STATE_OFF = 0x00000000,
    AUDIO_SYSTEMEFFECT_STATE_ON  = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineextensionapo/ne-audioengineextensionapo-apo_log_level
alias APO_LOG_LEVEL = int;
enum : int
{
    APO_LOG_LEVEL_ALWAYS   = 0x00000000,
    APO_LOG_LEVEL_CRITICAL = 0x00000001,
    APO_LOG_LEVEL_ERROR    = 0x00000002,
    APO_LOG_LEVEL_WARNING  = 0x00000003,
    APO_LOG_LEVEL_INFO     = 0x00000004,
    APO_LOG_LEVEL_VERBOSE  = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineextensionapo/ne-audioengineextensionapo-apo_notification_type
alias APO_NOTIFICATION_TYPE = int;
enum : int
{
    APO_NOTIFICATION_TYPE_NONE                           = 0x00000000,
    APO_NOTIFICATION_TYPE_ENDPOINT_VOLUME                = 0x00000001,
    APO_NOTIFICATION_TYPE_ENDPOINT_PROPERTY_CHANGE       = 0x00000002,
    APO_NOTIFICATION_TYPE_SYSTEM_EFFECTS_PROPERTY_CHANGE = 0x00000003,
    APO_NOTIFICATION_TYPE_ENDPOINT_VOLUME2               = 0x00000004,
    APO_NOTIFICATION_TYPE_DEVICE_ORIENTATION             = 0x00000005,
    APO_NOTIFICATION_TYPE_MICROPHONE_BOOST               = 0x00000006,
    APO_NOTIFICATION_TYPE_AUDIO_ENVIRONMENT_STATE_CHANGE = 0x00000007,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineextensionapo/ne-audioengineextensionapo-device_orientation_type
alias DEVICE_ORIENTATION_TYPE = int;
enum : int
{
    DEVICE_NOT_ROTATED                   = 0x00000000,
    DEVICE_ROTATED_90_DEGREES_CLOCKWISE  = 0x00000001,
    DEVICE_ROTATED_180_DEGREES_CLOCKWISE = 0x00000002,
    DEVICE_ROTATED_270_DEGREES_CLOCKWISE = 0x00000003,
}

// Constants


enum HRESULT APOERR_ALREADY_INITIALIZED = HRESULT(0x887d0001);
enum HRESULT APOERR_NOT_INITIALIZED = HRESULT(0x887d0002);
enum HRESULT APOERR_FORMAT_NOT_SUPPORTED = HRESULT(0x887d0003);
enum HRESULT APOERR_INVALID_APO_CLSID = HRESULT(0x887d0004);
enum HRESULT APOERR_BUFFERS_OVERLAP = HRESULT(0x887d0005);
enum HRESULT APOERR_ALREADY_UNLOCKED = HRESULT(0x887d0006);
enum HRESULT APOERR_NUM_CONNECTIONS_INVALID = HRESULT(0x887d0007);

enum : HRESULT
{
    APOERR_INVALID_OUTPUT_MAXFRAMECOUNT = HRESULT(0x887d0008),
    APOERR_INVALID_CONNECTION_FORMAT    = HRESULT(0x887d0009),
}

enum : HRESULT
{
    APOERR_APO_LOCKED          = HRESULT(0x887d000a),
    APOERR_INVALID_COEFFCOUNT  = HRESULT(0x887d000b),
    APOERR_INVALID_COEFFICIENT = HRESULT(0x887d000c),
    APOERR_INVALID_CURVE_PARAM = HRESULT(0x887d000d),
    APOERR_INVALID_INPUTID     = HRESULT(0x887d000e),
}

enum double AUDIO_MIN_FRAMERATE = 0x1.4p+3;
enum double AUDIO_MAX_FRAMERATE = 0x1.77p+18;
enum uint AUDIO_MIN_CHANNELS = 0x00000001U;
enum uint AUDIO_MAX_CHANNELS = 0x00001000U;

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 0))], [])*/PROPERTYKEY
{
    PKEY_FX_Association       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 0))], [])*/PROPERTYKEY(GUID("D04E05A6-594B-4FB6-A80D-01AF5EED7D1D"), 0),
    PKEY_FX_PreMixEffectClsid = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 0))], [])*/PROPERTYKEY(GUID("D04E05A6-594B-4FB6-A80D-01AF5EED7D1D"), 1),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 2))], [])*/PROPERTYKEY PKEY_FX_PostMixEffectClsid = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 2))], [])*/PROPERTYKEY(GUID("D04E05A6-594B-4FB6-A80D-01AF5EED7D1D"), 2);
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 3))], [])*/PROPERTYKEY PKEY_FX_UserInterfaceClsid = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 3))], [])*/PROPERTYKEY(GUID("D04E05A6-594B-4FB6-A80D-01AF5EED7D1D"), 3);
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 4))], [])*/PROPERTYKEY PKEY_FX_FriendlyName = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 4))], [])*/PROPERTYKEY(GUID("D04E05A6-594B-4FB6-A80D-01AF5EED7D1D"), 4);
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 5))], [])*/PROPERTYKEY PKEY_FX_StreamEffectClsid = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 5))], [])*/PROPERTYKEY(GUID("D04E05A6-594B-4FB6-A80D-01AF5EED7D1D"), 5);
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 6))], [])*/PROPERTYKEY PKEY_FX_ModeEffectClsid = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 6))], [])*/PROPERTYKEY(GUID("D04E05A6-594B-4FB6-A80D-01AF5EED7D1D"), 6);
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 7))], [])*/PROPERTYKEY PKEY_FX_EndpointEffectClsid = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 7))], [])*/PROPERTYKEY(GUID("D04E05A6-594B-4FB6-A80D-01AF5EED7D1D"), 7);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 8))], [])*/PROPERTYKEY
{
    PKEY_FX_KeywordDetector_StreamEffectClsid   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 8))], [])*/PROPERTYKEY(GUID("D04E05A6-594B-4FB6-A80D-01AF5EED7D1D"), 8),
    PKEY_FX_KeywordDetector_ModeEffectClsid     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 8))], [])*/PROPERTYKEY(GUID("D04E05A6-594B-4FB6-A80D-01AF5EED7D1D"), 9),
    PKEY_FX_KeywordDetector_EndpointEffectClsid = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 8))], [])*/PROPERTYKEY(GUID("D04E05A6-594B-4FB6-A80D-01AF5EED7D1D"), 10),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 11))], [])*/PROPERTYKEY
{
    PKEY_FX_Offload_StreamEffectClsid = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 11))], [])*/PROPERTYKEY(GUID("D04E05A6-594B-4FB6-A80D-01AF5EED7D1D"), 11),
    PKEY_FX_Offload_ModeEffectClsid   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 11))], [])*/PROPERTYKEY(GUID("D04E05A6-594B-4FB6-A80D-01AF5EED7D1D"), 12),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 13))], [])*/PROPERTYKEY
{
    PKEY_CompositeFX_StreamEffectClsid                   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 13))], [])*/PROPERTYKEY(GUID("D04E05A6-594B-4FB6-A80D-01AF5EED7D1D"), 13),
    PKEY_CompositeFX_ModeEffectClsid                     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 13))], [])*/PROPERTYKEY(GUID("D04E05A6-594B-4FB6-A80D-01AF5EED7D1D"), 14),
    PKEY_CompositeFX_EndpointEffectClsid                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 13))], [])*/PROPERTYKEY(GUID("D04E05A6-594B-4FB6-A80D-01AF5EED7D1D"), 15),
    PKEY_CompositeFX_KeywordDetector_StreamEffectClsid   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 13))], [])*/PROPERTYKEY(GUID("D04E05A6-594B-4FB6-A80D-01AF5EED7D1D"), 16),
    PKEY_CompositeFX_KeywordDetector_ModeEffectClsid     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 13))], [])*/PROPERTYKEY(GUID("D04E05A6-594B-4FB6-A80D-01AF5EED7D1D"), 17),
    PKEY_CompositeFX_KeywordDetector_EndpointEffectClsid = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 13))], [])*/PROPERTYKEY(GUID("D04E05A6-594B-4FB6-A80D-01AF5EED7D1D"), 18),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 19))], [])*/PROPERTYKEY
{
    PKEY_CompositeFX_Offload_StreamEffectClsid = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 19))], [])*/PROPERTYKEY(GUID("D04E05A6-594B-4FB6-A80D-01AF5EED7D1D"), 19),
    PKEY_CompositeFX_Offload_ModeEffectClsid   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 19))], [])*/PROPERTYKEY(GUID("D04E05A6-594B-4FB6-A80D-01AF5EED7D1D"), 20),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 21))], [])*/PROPERTYKEY
{
    PKEY_FX_SupportAppLauncher = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 21))], [])*/PROPERTYKEY(GUID("D04E05A6-594B-4FB6-A80D-01AF5EED7D1D"), 21),
    PKEY_FX_SupportedFormats   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 21))], [])*/PROPERTYKEY(GUID("D04E05A6-594B-4FB6-A80D-01AF5EED7D1D"), 22),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 23))], [])*/PROPERTYKEY
{
    PKEY_FX_Enumerator   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 23))], [])*/PROPERTYKEY(GUID("D04E05A6-594B-4FB6-A80D-01AF5EED7D1D"), 23),
    PKEY_FX_VersionMajor = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 23))], [])*/PROPERTYKEY(GUID("D04E05A6-594B-4FB6-A80D-01AF5EED7D1D"), 24),
    PKEY_FX_VersionMinor = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 23))], [])*/PROPERTYKEY(GUID("D04E05A6-594B-4FB6-A80D-01AF5EED7D1D"), 25),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 26))], [])*/PROPERTYKEY
{
    PKEY_FX_Author                   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 26))], [])*/PROPERTYKEY(GUID("D04E05A6-594B-4FB6-A80D-01AF5EED7D1D"), 26),
    PKEY_FX_ObjectId                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 26))], [])*/PROPERTYKEY(GUID("D04E05A6-594B-4FB6-A80D-01AF5EED7D1D"), 27),
    PKEY_FX_State                    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 26))], [])*/PROPERTYKEY(GUID("D04E05A6-594B-4FB6-A80D-01AF5EED7D1D"), 28),
    PKEY_FX_EffectPackSchema_Version = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 26))], [])*/PROPERTYKEY(GUID("D04E05A6-594B-4FB6-A80D-01AF5EED7D1D"), 29),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 30))], [])*/PROPERTYKEY
{
    PKEY_FX_ApplyToBluetooth = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 30))], [])*/PROPERTYKEY(GUID("D04E05A6-594B-4FB6-A80D-01AF5EED7D1D"), 30),
    PKEY_FX_ApplyToUsb       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 30))], [])*/PROPERTYKEY(GUID("D04E05A6-594B-4FB6-A80D-01AF5EED7D1D"), 31),
    PKEY_FX_ApplyToRender    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 30))], [])*/PROPERTYKEY(GUID("D04E05A6-594B-4FB6-A80D-01AF5EED7D1D"), 32),
    PKEY_FX_ApplyToCapture   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 30))], [])*/PROPERTYKEY(GUID("D04E05A6-594B-4FB6-A80D-01AF5EED7D1D"), 33),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 34))], [])*/PROPERTYKEY
{
    PKEY_FX_RequestSetAsDefault         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 34))], [])*/PROPERTYKEY(GUID("D04E05A6-594B-4FB6-A80D-01AF5EED7D1D"), 34),
    PKEY_FX_RequestSetAsDefaultPriority = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 34))], [])*/PROPERTYKEY(GUID("D04E05A6-594B-4FB6-A80D-01AF5EED7D1D"), 35),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 36))], [])*/PROPERTYKEY PKEY_FX_OEM_Preferred_EffectPack_Id = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3494774182, 22859, 20406, 168, 13, 1, 175, 94, 237, 125, 29}, 36))], [])*/PROPERTYKEY(GUID("D04E05A6-594B-4FB6-A80D-01AF5EED7D1D"), 36);
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/CoreAudio/pkey-sfx-processingmodes-supported-for-streaming))], [])*/PROPERTYKEY PKEY_SFX_ProcessingModes_Supported_For_Streaming = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/CoreAudio/pkey-sfx-processingmodes-supported-for-streaming))], [])*/PROPERTYKEY(GUID("D3993A3F-99C2-4402-B5EC-A92A0367664B"), 5);
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/CoreAudio/pkey-mfx-processingmodes-supported-for-streaming))], [])*/PROPERTYKEY PKEY_MFX_ProcessingModes_Supported_For_Streaming = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/CoreAudio/pkey-mfx-processingmodes-supported-for-streaming))], [])*/PROPERTYKEY(GUID("D3993A3F-99C2-4402-B5EC-A92A0367664B"), 6);
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/CoreAudio/pkey-efx-processingmodes-supported-for-streaming))], [])*/PROPERTYKEY PKEY_EFX_ProcessingModes_Supported_For_Streaming = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/CoreAudio/pkey-efx-processingmodes-supported-for-streaming))], [])*/PROPERTYKEY(GUID("D3993A3F-99C2-4402-B5EC-A92A0367664B"), 7);
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3550034495, 39362, 17410, 181, 236, 169, 42, 3, 103, 102, 75}, 8))], [])*/PROPERTYKEY PKEY_SFX_KeywordDetector_ProcessingModes_Supported_For_Streaming = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3550034495, 39362, 17410, 181, 236, 169, 42, 3, 103, 102, 75}, 8))], [])*/PROPERTYKEY(GUID("D3993A3F-99C2-4402-B5EC-A92A0367664B"), 8);
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3550034495, 39362, 17410, 181, 236, 169, 42, 3, 103, 102, 75}, 9))], [])*/PROPERTYKEY PKEY_MFX_KeywordDetector_ProcessingModes_Supported_For_Streaming = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3550034495, 39362, 17410, 181, 236, 169, 42, 3, 103, 102, 75}, 9))], [])*/PROPERTYKEY(GUID("D3993A3F-99C2-4402-B5EC-A92A0367664B"), 9);
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3550034495, 39362, 17410, 181, 236, 169, 42, 3, 103, 102, 75}, 10))], [])*/PROPERTYKEY PKEY_EFX_KeywordDetector_ProcessingModes_Supported_For_Streaming = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3550034495, 39362, 17410, 181, 236, 169, 42, 3, 103, 102, 75}, 10))], [])*/PROPERTYKEY(GUID("D3993A3F-99C2-4402-B5EC-A92A0367664B"), 10);
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3550034495, 39362, 17410, 181, 236, 169, 42, 3, 103, 102, 75}, 11))], [])*/PROPERTYKEY PKEY_SFX_Offload_ProcessingModes_Supported_For_Streaming = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3550034495, 39362, 17410, 181, 236, 169, 42, 3, 103, 102, 75}, 11))], [])*/PROPERTYKEY(GUID("D3993A3F-99C2-4402-B5EC-A92A0367664B"), 11);
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3550034495, 39362, 17410, 181, 236, 169, 42, 3, 103, 102, 75}, 12))], [])*/PROPERTYKEY PKEY_MFX_Offload_ProcessingModes_Supported_For_Streaming = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3550034495, 39362, 17410, 181, 236, 169, 42, 3, 103, 102, 75}, 12))], [])*/PROPERTYKEY(GUID("D3993A3F-99C2-4402-B5EC-A92A0367664B"), 12);
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3550034495, 39362, 17410, 181, 236, 169, 42, 3, 103, 102, 75}, 13))], [])*/PROPERTYKEY PKEY_APO_SWFallback_ProcessingModes = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3550034495, 39362, 17410, 181, 236, 169, 42, 3, 103, 102, 75}, 13))], [])*/PROPERTYKEY(GUID("D3993A3F-99C2-4402-B5EC-A92A0367664B"), 13);
enum GUID PKEY_FX_EffectPack_Schema_V1 = GUID("7abf23d9-727e-4d0b-86a3-dd501d260001");

enum : GUID
{
    SID_AudioProcessingObjectRTQueue        = GUID("458c1a1f-6899-4c12-99ac-e2e6ac253104"),
    SID_AudioProcessingObjectLoggingService = GUID("8b8008af-09f9-456e-a173-bdb58499bce7"),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1257995144, 42579, 17573, 153, 219, 104, 127, 215, 74, 240, 187}, 2))], [])*/PROPERTYKEY PKEY_AudioEnvironment_SpatialAudioActive = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1257995144, 42579, 17573, 153, 219, 104, 127, 215, 74, 240, 187}, 2))], [])*/PROPERTYKEY(GUID("4AFB7B88-A653-44A5-99DB-687FD74AF0BB"), 2);

enum : uint
{
    AUDIOMEDIATYPE_EQUAL_FORMAT_TYPES     = 0x00000002U,
    AUDIOMEDIATYPE_EQUAL_FORMAT_DATA      = 0x00000004U,
    AUDIOMEDIATYPE_EQUAL_FORMAT_USER_DATA = 0x00000008U,
}

// Callbacks

alias FNAPONOTIFICATIONCALLBACK = HRESULT function(APO_REG_PROPERTIES* pProperties, void* pvRefData);

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audiomediatype/ns-audiomediatype-uncompressedaudioformat
struct UNCOMPRESSEDAUDIOFORMAT
{
    GUID  guidFormatType;
    uint  dwSamplesPerFrame;
    uint  dwBytesPerSampleContainer;
    uint  dwValidBitsPerSample;
    float fFramesPerSecond;
    uint  dwChannelMask;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioapotypes/ns-audioapotypes-apo_connection_property
struct APO_CONNECTION_PROPERTY
{
    size_t           pBuffer;
    uint             u32ValidFrameCount;
    APO_BUFFER_FLAGS u32BufferFlags;
    uint             u32Signature;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioapotypes/ns-audioapotypes-apo_connection_property_v2
struct APO_CONNECTION_PROPERTY_V2
{
    APO_CONNECTION_PROPERTY property;
    ulong u64QPCTime;
}

struct APO_CONNECTION_DESCRIPTOR
{
    APO_CONNECTION_BUFFER_TYPE Type;
    size_t          pBuffer;
    uint            u32MaxFrameCount;
    IAudioMediaType pFormat;
    uint            u32Signature;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioenginebaseapo/ns-audioenginebaseapo-apo_reg_properties
struct APO_REG_PROPERTIES
{
    GUID       clsid;
    APO_FLAG   Flags;
    wchar[256] szFriendlyName;
    wchar[256] szCopyrightInfo;
    uint       u32MajorVersion;
    uint       u32MinorVersion;
    uint       u32MinInputConnections;
    uint       u32MaxInputConnections;
    uint       u32MinOutputConnections;
    uint       u32MaxOutputConnections;
    uint       u32MaxInstances;
    uint       u32NumAPOInterfaces;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/GUID[1] iidAPOInterfaceList;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioenginebaseapo/ns-audioenginebaseapo-apoinitbasestruct
struct APOInitBaseStruct
{
    uint cbSize;
    GUID clsid;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioenginebaseapo/ns-audioenginebaseapo-apoinitsystemeffects
struct APOInitSystemEffects
{
    APOInitBaseStruct   APOInit;
    IPropertyStore      pAPOEndpointProperties;
    IPropertyStore      pAPOSystemEffectsProperties;
    void*               pReserved;
    IMMDeviceCollection pDeviceCollection;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioenginebaseapo/ns-audioenginebaseapo-apoinitsystemeffects2
struct APOInitSystemEffects2
{
    APOInitBaseStruct   APOInit;
    IPropertyStore      pAPOEndpointProperties;
    IPropertyStore      pAPOSystemEffectsProperties;
    void*               pReserved;
    IMMDeviceCollection pDeviceCollection;
    uint                nSoftwareIoDeviceInCollection;
    uint                nSoftwareIoConnectorIndex;
    GUID                AudioProcessingMode;
    BOOL                InitializeForDiscoveryOnly;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioenginebaseapo/ns-audioenginebaseapo-audiofxextensionparams
struct AudioFXExtensionParams
{
    LPARAM         AddPageParam;
    PWSTR          pwstrEndpointID;
    IPropertyStore pFxProperties;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineextensionapo/ns-audioengineextensionapo-audio_systemeffect
struct AUDIO_SYSTEMEFFECT
{
    GUID id;
    BOOL canSetState;
    AUDIO_SYSTEMEFFECT_STATE state;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineextensionapo/ns-audioengineextensionapo-apoinitsystemeffects3
struct APOInitSystemEffects3
{
    APOInitBaseStruct   APOInit;
    IPropertyStore      pAPOEndpointProperties;
    IServiceProvider    pServiceProvider;
    IMMDeviceCollection pDeviceCollection;
    uint                nSoftwareIoDeviceInCollection;
    uint                nSoftwareIoConnectorIndex;
    GUID                AudioProcessingMode;
    BOOL                InitializeForDiscoveryOnly;
}

struct AcousticEchoCanceller_Reference_Input
{
    APOInitSystemEffects3 apoInitSystemEffects;
    APO_REFERENCE_STREAM_PROPERTIES streamProperties;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineextensionapo/ns-audioengineextensionapo-audio_endpoint_volume_change_notification
struct AUDIO_ENDPOINT_VOLUME_CHANGE_NOTIFICATION
{
    IMMDevice endpoint;
    AUDIO_VOLUME_NOTIFICATION_DATA* volume;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineextensionapo/ns-audioengineextensionapo-audio_endpoint_property_change_notification
struct AUDIO_ENDPOINT_PROPERTY_CHANGE_NOTIFICATION
{
    IMMDevice      endpoint;
    IPropertyStore propertyStore;
    PROPERTYKEY    propertyKey;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineextensionapo/ns-audioengineextensionapo-audio_systemeffects_property_change_notification
struct AUDIO_SYSTEMEFFECTS_PROPERTY_CHANGE_NOTIFICATION
{
    IMMDevice      endpoint;
    GUID           propertyStoreContext;
    AUDIO_SYSTEMEFFECTS_PROPERTYSTORE_TYPE propertyStoreType;
    IPropertyStore propertyStore;
    PROPERTYKEY    propertyKey;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineextensionapo/ns-audioengineextensionapo-audio_volume_notification_data2
struct AUDIO_VOLUME_NOTIFICATION_DATA2
{
    AUDIO_VOLUME_NOTIFICATION_DATA* notificationData;
    float masterVolumeInDb;
    float volumeMinInDb;
    float volumeMaxInDb;
    float volumeIncrementInDb;
    uint  step;
    uint  stepCount;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/float[1] channelVolumesInDb;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineextensionapo/ns-audioengineextensionapo-audio_endpoint_volume_change_notification2
struct AUDIO_ENDPOINT_VOLUME_CHANGE_NOTIFICATION2
{
    IMMDevice endpoint;
    AUDIO_VOLUME_NOTIFICATION_DATA2* volume;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineextensionapo/ns-audioengineextensionapo-audio_microphone_boost_notification
struct AUDIO_MICROPHONE_BOOST_NOTIFICATION
{
    IMMDevice endpoint;
    GUID      eventContext;
    BOOL      microphoneBoostEnabled;
    float     levelInDb;
    float     levelMinInDb;
    float     levelMaxInDb;
    float     levelStepInDb;
    BOOL      muteSupported;
    BOOL      mute;
}

struct AUDIO_ENVIRONMENT_STATE_CHANGE_NOTIFICATION
{
    IPropertyStore propertyStore;
    PROPERTYKEY    propertyKey;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineextensionapo/ns-audioengineextensionapo-apo_notification
struct APO_NOTIFICATION
{
    APO_NOTIFICATION_TYPE type;
    union
    {
        AUDIO_ENDPOINT_VOLUME_CHANGE_NOTIFICATION audioEndpointVolumeChange;
        AUDIO_ENDPOINT_PROPERTY_CHANGE_NOTIFICATION audioEndpointPropertyChange;
        AUDIO_SYSTEMEFFECTS_PROPERTY_CHANGE_NOTIFICATION audioSystemEffectsPropertyChange;
        AUDIO_ENDPOINT_VOLUME_CHANGE_NOTIFICATION2 audioEndpointVolumeChange2;
        DEVICE_ORIENTATION_TYPE deviceOrientation;
        AUDIO_MICROPHONE_BOOST_NOTIFICATION audioMicrophoneBoostChange;
        AUDIO_ENVIRONMENT_STATE_CHANGE_NOTIFICATION audioEnvironmentChange;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineextensionapo/ns-audioengineextensionapo-audio_endpoint_volume_apo_notification_descriptor
struct AUDIO_ENDPOINT_VOLUME_APO_NOTIFICATION_DESCRIPTOR
{
    IMMDevice device;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineextensionapo/ns-audioengineextensionapo-audio_endpoint_property_change_apo_notification_descriptor
struct AUDIO_ENDPOINT_PROPERTY_CHANGE_APO_NOTIFICATION_DESCRIPTOR
{
    IMMDevice device;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineextensionapo/ns-audioengineextensionapo-audio_systemeffects_property_change_apo_notification_descriptor
struct AUDIO_SYSTEMEFFECTS_PROPERTY_CHANGE_APO_NOTIFICATION_DESCRIPTOR
{
    IMMDevice device;
    GUID      propertyStoreContext;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineextensionapo/ns-audioengineextensionapo-audio_microphone_boost_apo_notification_descriptor
struct AUDIO_MICROPHONE_BOOST_APO_NOTIFICATION_DESCRIPTOR
{
    IMMDevice device;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineextensionapo/ns-audioengineextensionapo-apo_notification_descriptor
struct APO_NOTIFICATION_DESCRIPTOR
{
    APO_NOTIFICATION_TYPE type;
    union
    {
        AUDIO_ENDPOINT_VOLUME_APO_NOTIFICATION_DESCRIPTOR audioEndpointVolume;
        AUDIO_ENDPOINT_PROPERTY_CHANGE_APO_NOTIFICATION_DESCRIPTOR audioEndpointPropertyChange;
        AUDIO_SYSTEMEFFECTS_PROPERTY_CHANGE_APO_NOTIFICATION_DESCRIPTOR audioSystemEffectsPropertyChange;
        AUDIO_MICROPHONE_BOOST_APO_NOTIFICATION_DESCRIPTOR audioMicrophoneBoost;
    }
}

// Interfaces

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audiomediatype/nn-audiomediatype-iaudiomediatype
@GUID("4e997f73-b71f-4798-873b-ed7dfcf15b4d")
interface IAudioMediaType : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audiomediatype/nf-audiomediatype-iaudiomediatype-iscompressedformat
    HRESULT IsCompressedFormat(BOOL* pfCompressed);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audiomediatype/nf-audiomediatype-iaudiomediatype-isequal
    HRESULT IsEqual(IAudioMediaType pIAudioType, uint* pdwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audiomediatype/nf-audiomediatype-iaudiomediatype-getaudioformat
    WAVEFORMATEX* GetAudioFormat();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audiomediatype/nf-audiomediatype-iaudiomediatype-getuncompressedaudioformat
    HRESULT GetUncompressedAudioFormat(UNCOMPRESSEDAUDIOFORMAT* pUncompressedAudioFormat);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioenginebaseapo/nn-audioenginebaseapo-iaudioprocessingobjectrt
@GUID("9e1d6a6d-ddbc-4e95-a4c7-ad64ba37846c")
interface IAudioProcessingObjectRT : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioenginebaseapo/nf-audioenginebaseapo-iaudioprocessingobjectrt-apoprocess
    void APOProcess(uint u32NumInputConnections, APO_CONNECTION_PROPERTY** ppInputConnections, 
                    uint u32NumOutputConnections, APO_CONNECTION_PROPERTY** ppOutputConnections);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioenginebaseapo/nf-audioenginebaseapo-iaudioprocessingobjectrt-calcinputframes
    uint CalcInputFrames(uint u32OutputFrameCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioenginebaseapo/nf-audioenginebaseapo-iaudioprocessingobjectrt-calcoutputframes
    uint CalcOutputFrames(uint u32InputFrameCount);
}

@GUID("7ba1db8f-78ad-49cd-9591-f79d80a17c81")
interface IAudioProcessingObjectVBR : IUnknown
{
    HRESULT CalcMaxInputFrames(uint u32MaxOutputFrameCount, uint* pu32InputFrameCount);
    HRESULT CalcMaxOutputFrames(uint u32MaxInputFrameCount, uint* pu32OutputFrameCount);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioenginebaseapo/nn-audioenginebaseapo-iaudioprocessingobjectconfiguration
@GUID("0e5ed805-aba6-49c3-8f9a-2b8c889c4fa8")
interface IAudioProcessingObjectConfiguration : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioenginebaseapo/nf-audioenginebaseapo-iaudioprocessingobjectconfiguration-lockforprocess
    HRESULT LockForProcess(uint u32NumInputConnections, APO_CONNECTION_DESCRIPTOR** ppInputConnections, 
                           uint u32NumOutputConnections, APO_CONNECTION_DESCRIPTOR** ppOutputConnections);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioenginebaseapo/nf-audioenginebaseapo-iaudioprocessingobjectconfiguration-unlockforprocess
    HRESULT UnlockForProcess();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioenginebaseapo/nn-audioenginebaseapo-iaudioprocessingobject
@GUID("fd7f2b29-24d0-4b5c-b177-592c39f9ca10")
interface IAudioProcessingObject : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioenginebaseapo/nf-audioenginebaseapo-iaudioprocessingobject-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioenginebaseapo/nf-audioenginebaseapo-iaudioprocessingobject-getlatency
    HRESULT GetLatency(long* pTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioenginebaseapo/nf-audioenginebaseapo-iaudioprocessingobject-getregistrationproperties
    HRESULT GetRegistrationProperties(APO_REG_PROPERTIES** ppRegProps);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioenginebaseapo/nf-audioenginebaseapo-iaudioprocessingobject-initialize
    HRESULT Initialize(uint cbDataSize, ubyte* pbyData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioenginebaseapo/nf-audioenginebaseapo-iaudioprocessingobject-isinputformatsupported
    HRESULT IsInputFormatSupported(IAudioMediaType pOppositeFormat, IAudioMediaType pRequestedInputFormat, 
                                   IAudioMediaType* ppSupportedInputFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioenginebaseapo/nf-audioenginebaseapo-iaudioprocessingobject-isoutputformatsupported
    HRESULT IsOutputFormatSupported(IAudioMediaType pOppositeFormat, IAudioMediaType pRequestedOutputFormat, 
                                    IAudioMediaType* ppSupportedOutputFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioenginebaseapo/nf-audioenginebaseapo-iaudioprocessingobject-getinputchannelcount
    HRESULT GetInputChannelCount(uint* pu32ChannelCount);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioenginebaseapo/nn-audioenginebaseapo-iaudiodevicemodulesclient
@GUID("98f37dac-d0b6-49f5-896a-aa4d169a4c48")
interface IAudioDeviceModulesClient : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioenginebaseapo/nf-audioenginebaseapo-iaudiodevicemodulesclient-setaudiodevicemodulesmanager
    HRESULT SetAudioDeviceModulesManager(IUnknown pAudioDeviceModulesManager);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioenginebaseapo/nn-audioenginebaseapo-iaudiosystemeffects
@GUID("5fa00f27-add6-499a-8a9d-6b98521fa75b")
interface IAudioSystemEffects : IUnknown
{
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioenginebaseapo/nn-audioenginebaseapo-iaudiosystemeffects2
@GUID("bafe99d2-7436-44ce-9e0e-4d89afbfff56")
interface IAudioSystemEffects2 : IAudioSystemEffects
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioenginebaseapo/nf-audioenginebaseapo-iaudiosystemeffects2-geteffectslist
    HRESULT GetEffectsList(GUID** ppEffectsIds, uint* pcEffects, HANDLE Event);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioenginebaseapo/nn-audioenginebaseapo-iaudiosystemeffectscustomformats
@GUID("b1176e34-bb7f-4f05-bebd-1b18a534e097")
interface IAudioSystemEffectsCustomFormats : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioenginebaseapo/nf-audioenginebaseapo-iaudiosystemeffectscustomformats-getformatcount
    HRESULT GetFormatCount(uint* pcFormats);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioenginebaseapo/nf-audioenginebaseapo-iaudiosystemeffectscustomformats-getformat
    HRESULT GetFormat(uint nFormat, IAudioMediaType* ppFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioenginebaseapo/nf-audioenginebaseapo-iaudiosystemeffectscustomformats-getformatrepresentation
    HRESULT GetFormatRepresentation(uint nFormat, PWSTR* ppwstrFormatRep);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioenginebaseapo/nn-audioenginebaseapo-iapoauxiliaryinputconfiguration
@GUID("4ceb0aab-fa19-48ed-a857-87771ae1b768")
interface IApoAuxiliaryInputConfiguration : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioenginebaseapo/nf-audioenginebaseapo-iapoauxiliaryinputconfiguration-addauxiliaryinput
    HRESULT AddAuxiliaryInput(uint dwInputId, uint cbDataSize, ubyte* pbyData, 
                              APO_CONNECTION_DESCRIPTOR* pInputConnection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioenginebaseapo/nf-audioenginebaseapo-iapoauxiliaryinputconfiguration-removeauxiliaryinput
    HRESULT RemoveAuxiliaryInput(uint dwInputId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioenginebaseapo/nf-audioenginebaseapo-iapoauxiliaryinputconfiguration-isinputformatsupported
    HRESULT IsInputFormatSupported(IAudioMediaType pRequestedInputFormat, IAudioMediaType* ppSupportedInputFormat);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioenginebaseapo/nn-audioenginebaseapo-iapoauxiliaryinputrt
@GUID("f851809c-c177-49a0-b1b2-b66f017943ab")
interface IApoAuxiliaryInputRT : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioenginebaseapo/nf-audioenginebaseapo-iapoauxiliaryinputrt-acceptinput
    void AcceptInput(uint dwInputId, const(APO_CONNECTION_PROPERTY)* pInputConnection);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioenginebaseapo/nn-audioenginebaseapo-iapoacousticechocancellation
@GUID("25385759-3236-4101-a943-25693dfb5d2d")
interface IApoAcousticEchoCancellation : IUnknown
{
}

@GUID("f235855f-f06d-45b3-a63f-ee4b71509dc2")
interface IApoAcousticEchoCancellation2 : IApoAcousticEchoCancellation
{
    HRESULT GetDesiredReferenceStreamProperties(APO_REFERENCE_STREAM_PROPERTIES* pProperties);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineextensionapo/nn-audioengineextensionapo-iaudiosystemeffects3
@GUID("c58b31cd-fc6a-4255-bc1f-ad29bb0a4a17")
interface IAudioSystemEffects3 : IAudioSystemEffects2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineextensionapo/nf-audioengineextensionapo-iaudiosystemeffects3-getcontrollablesystemeffectslist
    HRESULT GetControllableSystemEffectsList(AUDIO_SYSTEMEFFECT** effects, uint* numEffects, HANDLE event);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineextensionapo/nf-audioengineextensionapo-iaudiosystemeffects3-setaudiosystemeffectstate
    HRESULT SetAudioSystemEffectState(GUID effectId, AUDIO_SYSTEMEFFECT_STATE state);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineextensionapo/nn-audioengineextensionapo-iaudioprocessingobjectrtqueueservice
@GUID("acd65e2f-955b-4b57-b9bf-ac297bb752c9")
interface IAudioProcessingObjectRTQueueService : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineextensionapo/nf-audioengineextensionapo-iaudioprocessingobjectrtqueueservice-getrealtimeworkqueue
    HRESULT GetRealTimeWorkQueue(uint* workQueueId);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineextensionapo/nn-audioengineextensionapo-iaudioprocessingobjectloggingservice
@GUID("698f0107-1745-4708-95a5-d84478a62a65")
interface IAudioProcessingObjectLoggingService : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineextensionapo/nf-audioengineextensionapo-iaudioprocessingobjectloggingservice-apolog
    void ApoLog(APO_LOG_LEVEL level, const(PWSTR) format);
}

@GUID("51cbd3c4-f1f3-4d2f-a0e1-7e9c4dd0feb3")
interface IAudioProcessingObjectPreferredFormatSupport : IUnknown
{
    HRESULT GetPreferredInputFormat(IAudioMediaType outputFormat, IAudioMediaType* preferredFormat);
    HRESULT GetPreferredOutputFormat(IAudioMediaType inputFormat, IAudioMediaType* preferredFormat);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineextensionapo/nn-audioengineextensionapo-iaudioprocessingobjectnotifications
@GUID("56b0c76f-02fd-4b21-a52e-9f8219fc86e4")
interface IAudioProcessingObjectNotifications : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineextensionapo/nf-audioengineextensionapo-iaudioprocessingobjectnotifications-getaponotificationregistrationinfo
    HRESULT GetApoNotificationRegistrationInfo(APO_NOTIFICATION_DESCRIPTOR** apoNotifications, uint* count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineextensionapo/nf-audioengineextensionapo-iaudioprocessingobjectnotifications-handlenotification
    void    HandleNotification(APO_NOTIFICATION* apoNotification);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineextensionapo/nn-audioengineextensionapo-iaudioprocessingobjectnotifications2
@GUID("ca2cfbde-a9d6-4eb0-bc95-c4d026b380f0")
interface IAudioProcessingObjectNotifications2 : IAudioProcessingObjectNotifications
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineextensionapo/nf-audioengineextensionapo-iaudioprocessingobjectnotifications2-getaponotificationregistrationinfo2
    HRESULT GetApoNotificationRegistrationInfo2(APO_NOTIFICATION_TYPE maxApoNotificationTypeSupported, 
                                                APO_NOTIFICATION_DESCRIPTOR** apoNotifications, uint* count);
}


// GUIDs


const GUID IID_IApoAcousticEchoCancellation                 = GUIDOF!IApoAcousticEchoCancellation;
const GUID IID_IApoAcousticEchoCancellation2                = GUIDOF!IApoAcousticEchoCancellation2;
const GUID IID_IApoAuxiliaryInputConfiguration              = GUIDOF!IApoAuxiliaryInputConfiguration;
const GUID IID_IApoAuxiliaryInputRT                         = GUIDOF!IApoAuxiliaryInputRT;
const GUID IID_IAudioDeviceModulesClient                    = GUIDOF!IAudioDeviceModulesClient;
const GUID IID_IAudioMediaType                              = GUIDOF!IAudioMediaType;
const GUID IID_IAudioProcessingObject                       = GUIDOF!IAudioProcessingObject;
const GUID IID_IAudioProcessingObjectConfiguration          = GUIDOF!IAudioProcessingObjectConfiguration;
const GUID IID_IAudioProcessingObjectLoggingService         = GUIDOF!IAudioProcessingObjectLoggingService;
const GUID IID_IAudioProcessingObjectNotifications          = GUIDOF!IAudioProcessingObjectNotifications;
const GUID IID_IAudioProcessingObjectNotifications2         = GUIDOF!IAudioProcessingObjectNotifications2;
const GUID IID_IAudioProcessingObjectPreferredFormatSupport = GUIDOF!IAudioProcessingObjectPreferredFormatSupport;
const GUID IID_IAudioProcessingObjectRT                     = GUIDOF!IAudioProcessingObjectRT;
const GUID IID_IAudioProcessingObjectRTQueueService         = GUIDOF!IAudioProcessingObjectRTQueueService;
const GUID IID_IAudioProcessingObjectVBR                    = GUIDOF!IAudioProcessingObjectVBR;
const GUID IID_IAudioSystemEffects                          = GUIDOF!IAudioSystemEffects;
const GUID IID_IAudioSystemEffects2                         = GUIDOF!IAudioSystemEffects2;
const GUID IID_IAudioSystemEffects3                         = GUIDOF!IAudioSystemEffects3;
const GUID IID_IAudioSystemEffectsCustomFormats             = GUIDOF!IAudioSystemEffectsCustomFormats;
