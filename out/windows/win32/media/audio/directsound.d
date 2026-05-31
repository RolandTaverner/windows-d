// Written in the D programming language.

module windows.win32.media.audio.directsound;

public import windows.core;
public import system.system : Guid;
public import windows.win32.foundation.foundation : BOOL, HANDLE, HRESULT, HWND, PSTR,
                                                    PWSTR;
public import windows.win32.graphics.direct3d.direct3d : D3DVECTOR;
public import windows.win32.media.audio.audio : WAVEFORMATEX;
public import windows.win32.system.com.com : IUnknown;

extern(Windows) @nogc nothrow:


// Constants


enum uint DIRECTSOUND_VERSION = 0x00000700U;
enum uint _FACDS = 0x00000878U;

enum : GUID
{
    CLSID_DirectSound           = GUID("47d4d946-62e8-11cf-93bc-444553540000"),
    CLSID_DirectSound8          = GUID("3901cc3f-84b5-4fa4-ba35-aa8172b8a09b"),
    CLSID_DirectSoundCapture    = GUID("b0210780-89cd-11d0-af08-00a0c925cd16"),
    CLSID_DirectSoundCapture8   = GUID("e4bcac13-7f99-4908-9a8e-74e3bf24b6e1"),
    CLSID_DirectSoundFullDuplex = GUID("fea4300c-7959-4147-b26a-2377b9e7a91d"),
}

enum : GUID
{
    DSDEVID_DefaultPlayback      = GUID("def00000-9c6d-47ed-aaf1-4dda8f2b5c03"),
    DSDEVID_DefaultCapture       = GUID("def00001-9c6d-47ed-aaf1-4dda8f2b5c03"),
    DSDEVID_DefaultVoicePlayback = GUID("def00002-9c6d-47ed-aaf1-4dda8f2b5c03"),
    DSDEVID_DefaultVoiceCapture  = GUID("def00003-9c6d-47ed-aaf1-4dda8f2b5c03"),
}

enum : uint
{
    DSFX_LOCHARDWARE = 0x00000001U,
    DSFX_LOCSOFTWARE = 0x00000002U,
}

enum : uint
{
    DSCFX_LOCHARDWARE = 0x00000001U,
    DSCFX_LOCSOFTWARE = 0x00000002U,
}

enum : uint
{
    DSCFXR_LOCHARDWARE = 0x00000010U,
    DSCFXR_LOCSOFTWARE = 0x00000020U,
}

enum GUID GUID_All_Objects = GUID("aa114de5-c262-4169-a1c8-23d698cc73b5");

enum : uint
{
    KSPROPERTY_SUPPORT_GET = 0x00000001U,
    KSPROPERTY_SUPPORT_SET = 0x00000002U,
}

enum : uint
{
    DSFXGARGLE_WAVE_TRIANGLE = 0x00000000U,
    DSFXGARGLE_WAVE_SQUARE   = 0x00000001U,
    DSFXGARGLE_RATEHZ_MIN    = 0x00000001U,
    DSFXGARGLE_RATEHZ_MAX    = 0x000003e8U,
}

enum : uint
{
    DSFXCHORUS_WAVE_TRIANGLE = 0x00000000U,
    DSFXCHORUS_WAVE_SIN      = 0x00000001U,
}

enum : float
{
    DSFXCHORUS_WETDRYMIX_MIN = 0x0p+0,
    DSFXCHORUS_WETDRYMIX_MAX = 0x1.9p+6,
    DSFXCHORUS_DEPTH_MIN     = 0x0p+0,
    DSFXCHORUS_DEPTH_MAX     = 0x1.9p+6,
    DSFXCHORUS_FEEDBACK_MIN  = -0x1.8cp+6,
    DSFXCHORUS_FEEDBACK_MAX  = 0x1.8cp+6,
    DSFXCHORUS_FREQUENCY_MIN = 0x0p+0,
    DSFXCHORUS_FREQUENCY_MAX = 0x1.4p+3,
    DSFXCHORUS_DELAY_MIN     = 0x0p+0,
    DSFXCHORUS_DELAY_MAX     = 0x1.4p+4,
}

enum : uint
{
    DSFXCHORUS_PHASE_MIN     = 0x00000000U,
    DSFXCHORUS_PHASE_MAX     = 0x00000004U,
    DSFXCHORUS_PHASE_NEG_180 = 0x00000000U,
    DSFXCHORUS_PHASE_NEG_90  = 0x00000001U,
    DSFXCHORUS_PHASE_ZERO    = 0x00000002U,
    DSFXCHORUS_PHASE_90      = 0x00000003U,
    DSFXCHORUS_PHASE_180     = 0x00000004U,
}

enum : uint
{
    DSFXFLANGER_WAVE_TRIANGLE = 0x00000000U,
    DSFXFLANGER_WAVE_SIN      = 0x00000001U,
}

enum : float
{
    DSFXFLANGER_WETDRYMIX_MIN = 0x0p+0,
    DSFXFLANGER_WETDRYMIX_MAX = 0x1.9p+6,
    DSFXFLANGER_FREQUENCY_MIN = 0x0p+0,
    DSFXFLANGER_FREQUENCY_MAX = 0x1.4p+3,
    DSFXFLANGER_DEPTH_MIN     = 0x0p+0,
    DSFXFLANGER_DEPTH_MAX     = 0x1.9p+6,
}

enum : uint
{
    DSFXFLANGER_PHASE_MIN = 0x00000000U,
    DSFXFLANGER_PHASE_MAX = 0x00000004U,
}

enum : float
{
    DSFXFLANGER_FEEDBACK_MIN = -0x1.8cp+6,
    DSFXFLANGER_FEEDBACK_MAX = 0x1.8cp+6,
    DSFXFLANGER_DELAY_MIN    = 0x0p+0,
    DSFXFLANGER_DELAY_MAX    = 0x1p+2,
}

enum : uint
{
    DSFXFLANGER_PHASE_NEG_180 = 0x00000000U,
    DSFXFLANGER_PHASE_NEG_90  = 0x00000001U,
    DSFXFLANGER_PHASE_ZERO    = 0x00000002U,
    DSFXFLANGER_PHASE_90      = 0x00000003U,
    DSFXFLANGER_PHASE_180     = 0x00000004U,
}

enum : float
{
    DSFXECHO_WETDRYMIX_MIN  = 0x0p+0,
    DSFXECHO_WETDRYMIX_MAX  = 0x1.9p+6,
    DSFXECHO_FEEDBACK_MIN   = 0x0p+0,
    DSFXECHO_FEEDBACK_MAX   = 0x1.9p+6,
    DSFXECHO_LEFTDELAY_MIN  = 0x1p+0,
    DSFXECHO_LEFTDELAY_MAX  = 0x1.f4p+10,
    DSFXECHO_RIGHTDELAY_MIN = 0x1p+0,
    DSFXECHO_RIGHTDELAY_MAX = 0x1.f4p+10,
}

enum : uint
{
    DSFXECHO_PANDELAY_MIN = 0x00000000U,
    DSFXECHO_PANDELAY_MAX = 0x00000001U,
}

enum : float
{
    DSFXDISTORTION_GAIN_MIN                  = -0x1.ep+5,
    DSFXDISTORTION_GAIN_MAX                  = 0x0p+0,
    DSFXDISTORTION_EDGE_MIN                  = 0x0p+0,
    DSFXDISTORTION_EDGE_MAX                  = 0x1.9p+6,
    DSFXDISTORTION_POSTEQCENTERFREQUENCY_MIN = 0x1.9p+6,
    DSFXDISTORTION_POSTEQCENTERFREQUENCY_MAX = 0x1.f4p+12,
    DSFXDISTORTION_POSTEQBANDWIDTH_MIN       = 0x1.9p+6,
    DSFXDISTORTION_POSTEQBANDWIDTH_MAX       = 0x1.f4p+12,
    DSFXDISTORTION_PRELOWPASSCUTOFF_MIN      = 0x1.9p+6,
    DSFXDISTORTION_PRELOWPASSCUTOFF_MAX      = 0x1.f4p+12,
}

enum : float
{
    DSFXCOMPRESSOR_GAIN_MIN      = -0x1.ep+5,
    DSFXCOMPRESSOR_GAIN_MAX      = 0x1.ep+5,
    DSFXCOMPRESSOR_ATTACK_MIN    = 0x1.47ae14p-7,
    DSFXCOMPRESSOR_ATTACK_MAX    = 0x1.f4p+8,
    DSFXCOMPRESSOR_RELEASE_MIN   = 0x1.9p+5,
    DSFXCOMPRESSOR_RELEASE_MAX   = 0x1.77p+11,
    DSFXCOMPRESSOR_THRESHOLD_MIN = -0x1.ep+5,
    DSFXCOMPRESSOR_THRESHOLD_MAX = 0x0p+0,
    DSFXCOMPRESSOR_RATIO_MIN     = 0x1p+0,
    DSFXCOMPRESSOR_RATIO_MAX     = 0x1.9p+6,
    DSFXCOMPRESSOR_PREDELAY_MIN  = 0x0p+0,
    DSFXCOMPRESSOR_PREDELAY_MAX  = 0x1p+2,
}

enum : float
{
    DSFXPARAMEQ_CENTER_MIN    = 0x1.4p+6,
    DSFXPARAMEQ_CENTER_MAX    = 0x1.f4p+13,
    DSFXPARAMEQ_BANDWIDTH_MIN = 0x1p+0,
    DSFXPARAMEQ_BANDWIDTH_MAX = 0x1.2p+5,
    DSFXPARAMEQ_GAIN_MIN      = -0x1.ep+3,
    DSFXPARAMEQ_GAIN_MAX      = 0x1.ep+3,
}

enum int DSFX_I3DL2REVERB_ROOM_MIN = 0xffffd8f0;
enum uint DSFX_I3DL2REVERB_ROOM_MAX = 0x00000000U;

enum : int
{
    DSFX_I3DL2REVERB_ROOM_DEFAULT = 0xfffffc18,
    DSFX_I3DL2REVERB_ROOMHF_MIN   = 0xffffd8f0,
}

enum uint DSFX_I3DL2REVERB_ROOMHF_MAX = 0x00000000U;
enum int DSFX_I3DL2REVERB_ROOMHF_DEFAULT = 0xffffff9c;

enum : float
{
    DSFX_I3DL2REVERB_ROOMROLLOFFFACTOR_MIN     = 0x0p+0,
    DSFX_I3DL2REVERB_ROOMROLLOFFFACTOR_MAX     = 0x1.4p+3,
    DSFX_I3DL2REVERB_ROOMROLLOFFFACTOR_DEFAULT = 0x0p+0,
    DSFX_I3DL2REVERB_DECAYTIME_MIN             = 0x1.99999ap-4,
    DSFX_I3DL2REVERB_DECAYTIME_MAX             = 0x1.4p+4,
    DSFX_I3DL2REVERB_DECAYTIME_DEFAULT         = 0x1.7d70a4p+0,
    DSFX_I3DL2REVERB_DECAYHFRATIO_MIN          = 0x1.99999ap-4,
    DSFX_I3DL2REVERB_DECAYHFRATIO_MAX          = 0x1p+1,
    DSFX_I3DL2REVERB_DECAYHFRATIO_DEFAULT      = 0x1.a8f5c2p-1,
}

enum int DSFX_I3DL2REVERB_REFLECTIONS_MIN = 0xffffd8f0;
enum uint DSFX_I3DL2REVERB_REFLECTIONS_MAX = 0x000003e8U;
enum int DSFX_I3DL2REVERB_REFLECTIONS_DEFAULT = 0xfffff5d6;

enum : float
{
    DSFX_I3DL2REVERB_REFLECTIONSDELAY_MIN     = 0x0p+0,
    DSFX_I3DL2REVERB_REFLECTIONSDELAY_MAX     = 0x1.333334p-2,
    DSFX_I3DL2REVERB_REFLECTIONSDELAY_DEFAULT = 0x1.cac084p-8,
}

enum int DSFX_I3DL2REVERB_REVERB_MIN = 0xffffd8f0;

enum : uint
{
    DSFX_I3DL2REVERB_REVERB_MAX     = 0x000007d0U,
    DSFX_I3DL2REVERB_REVERB_DEFAULT = 0x000000c8U,
}

enum : float
{
    DSFX_I3DL2REVERB_REVERBDELAY_MIN     = 0x0p+0,
    DSFX_I3DL2REVERB_REVERBDELAY_MAX     = 0x1.99999ap-4,
    DSFX_I3DL2REVERB_REVERBDELAY_DEFAULT = 0x1.6872bp-7,
    DSFX_I3DL2REVERB_DIFFUSION_MIN       = 0x0p+0,
    DSFX_I3DL2REVERB_DIFFUSION_MAX       = 0x1.9p+6,
    DSFX_I3DL2REVERB_DIFFUSION_DEFAULT   = 0x1.9p+6,
    DSFX_I3DL2REVERB_DENSITY_MIN         = 0x0p+0,
    DSFX_I3DL2REVERB_DENSITY_MAX         = 0x1.9p+6,
    DSFX_I3DL2REVERB_DENSITY_DEFAULT     = 0x1.9p+6,
    DSFX_I3DL2REVERB_HFREFERENCE_MIN     = 0x1.4p+4,
    DSFX_I3DL2REVERB_HFREFERENCE_MAX     = 0x1.388p+14,
    DSFX_I3DL2REVERB_HFREFERENCE_DEFAULT = 0x1.388p+12,
}

enum : uint
{
    DSFX_I3DL2REVERB_QUALITY_MIN     = 0x00000000U,
    DSFX_I3DL2REVERB_QUALITY_MAX     = 0x00000003U,
    DSFX_I3DL2REVERB_QUALITY_DEFAULT = 0x00000002U,
}

enum : float
{
    DSFX_WAVESREVERB_INGAIN_MIN              = -0x1.8p+6,
    DSFX_WAVESREVERB_INGAIN_MAX              = 0x0p+0,
    DSFX_WAVESREVERB_INGAIN_DEFAULT          = 0x0p+0,
    DSFX_WAVESREVERB_REVERBMIX_MIN           = -0x1.8p+6,
    DSFX_WAVESREVERB_REVERBMIX_MAX           = 0x0p+0,
    DSFX_WAVESREVERB_REVERBMIX_DEFAULT       = 0x0p+0,
    DSFX_WAVESREVERB_REVERBTIME_MIN          = 0x1.0624dep-10,
    DSFX_WAVESREVERB_REVERBTIME_MAX          = 0x1.77p+11,
    DSFX_WAVESREVERB_REVERBTIME_DEFAULT      = 0x1.f4p+9,
    DSFX_WAVESREVERB_HIGHFREQRTRATIO_MIN     = 0x1.0624dep-10,
    DSFX_WAVESREVERB_HIGHFREQRTRATIO_MAX     = 0x1.ff7ceep-1,
    DSFX_WAVESREVERB_HIGHFREQRTRATIO_DEFAULT = 0x1.0624dep-10,
}

enum : uint
{
    DSCFX_AEC_MODE_PASS_THROUGH = 0x00000000U,
    DSCFX_AEC_MODE_HALF_DUPLEX  = 0x00000001U,
    DSCFX_AEC_MODE_FULL_DUPLEX  = 0x00000002U,
}

enum : uint
{
    DSCFX_AEC_STATUS_HISTORY_UNINITIALIZED          = 0x00000000U,
    DSCFX_AEC_STATUS_HISTORY_CONTINUOUSLY_CONVERGED = 0x00000001U,
    DSCFX_AEC_STATUS_HISTORY_PREVIOUSLY_DIVERGED    = 0x00000002U,
}

enum uint DSCFX_AEC_STATUS_CURRENTLY_CONVERGED = 0x00000008U;
enum HRESULT DS_NO_VIRTUALIZATION = HRESULT(0x0878000a);

enum : uint
{
    DSCAPS_PRIMARYMONO   = 0x00000001U,
    DSCAPS_PRIMARYSTEREO = 0x00000002U,
    DSCAPS_PRIMARY8BIT   = 0x00000004U,
    DSCAPS_PRIMARY16BIT  = 0x00000008U,
}

enum uint DSCAPS_CONTINUOUSRATE = 0x00000010U;

enum : uint
{
    DSCAPS_EMULDRIVER      = 0x00000020U,
    DSCAPS_CERTIFIED       = 0x00000040U,
    DSCAPS_SECONDARYMONO   = 0x00000100U,
    DSCAPS_SECONDARYSTEREO = 0x00000200U,
    DSCAPS_SECONDARY8BIT   = 0x00000400U,
    DSCAPS_SECONDARY16BIT  = 0x00000800U,
}

enum : uint
{
    DSSCL_NORMAL    = 0x00000001U,
    DSSCL_PRIORITY  = 0x00000002U,
    DSSCL_EXCLUSIVE = 0x00000003U,
}

enum uint DSSCL_WRITEPRIMARY = 0x00000004U;

enum : uint
{
    DSSPEAKER_DIRECTOUT        = 0x00000000U,
    DSSPEAKER_HEADPHONE        = 0x00000001U,
    DSSPEAKER_MONO             = 0x00000002U,
    DSSPEAKER_QUAD             = 0x00000003U,
    DSSPEAKER_STEREO           = 0x00000004U,
    DSSPEAKER_SURROUND         = 0x00000005U,
    DSSPEAKER_5POINT1          = 0x00000006U,
    DSSPEAKER_7POINT1          = 0x00000007U,
    DSSPEAKER_7POINT1_SURROUND = 0x00000008U,
}

enum uint DSSPEAKER_5POINT1_SURROUND = 0x00000009U;

enum : uint
{
    DSSPEAKER_7POINT1_WIDE    = 0x00000007U,
    DSSPEAKER_5POINT1_BACK    = 0x00000006U,
    DSSPEAKER_GEOMETRY_MIN    = 0x00000005U,
    DSSPEAKER_GEOMETRY_NARROW = 0x0000000aU,
    DSSPEAKER_GEOMETRY_WIDE   = 0x00000014U,
    DSSPEAKER_GEOMETRY_MAX    = 0x000000b4U,
}

enum uint DSBCAPS_PRIMARYBUFFER = 0x00000001U;

enum : uint
{
    DSBCAPS_STATIC              = 0x00000002U,
    DSBCAPS_LOCHARDWARE         = 0x00000004U,
    DSBCAPS_LOCSOFTWARE         = 0x00000008U,
    DSBCAPS_CTRL3D              = 0x00000010U,
    DSBCAPS_CTRLFREQUENCY       = 0x00000020U,
    DSBCAPS_CTRLPAN             = 0x00000040U,
    DSBCAPS_CTRLVOLUME          = 0x00000080U,
    DSBCAPS_CTRLPOSITIONNOTIFY  = 0x00000100U,
    DSBCAPS_CTRLFX              = 0x00000200U,
    DSBCAPS_STICKYFOCUS         = 0x00004000U,
    DSBCAPS_GLOBALFOCUS         = 0x00008000U,
    DSBCAPS_GETCURRENTPOSITION2 = 0x00010000U,
}

enum uint DSBCAPS_MUTE3DATMAXDISTANCE = 0x00020000U;

enum : uint
{
    DSBCAPS_LOCDEFER         = 0x00040000U,
    DSBCAPS_TRUEPLAYPOSITION = 0x00080000U,
}

enum : uint
{
    DSBPLAY_LOOPING          = 0x00000001U,
    DSBPLAY_LOCHARDWARE      = 0x00000002U,
    DSBPLAY_LOCSOFTWARE      = 0x00000004U,
    DSBPLAY_TERMINATEBY_TIME = 0x00000008U,
}

enum : ulong
{
    DSBPLAY_TERMINATEBY_DISTANCE = 0x0000000000000010UL,
    DSBPLAY_TERMINATEBY_PRIORITY = 0x0000000000000020UL,
}

enum : uint
{
    DSBSTATUS_PLAYING     = 0x00000001U,
    DSBSTATUS_BUFFERLOST  = 0x00000002U,
    DSBSTATUS_LOOPING     = 0x00000004U,
    DSBSTATUS_LOCHARDWARE = 0x00000008U,
    DSBSTATUS_LOCSOFTWARE = 0x00000010U,
    DSBSTATUS_TERMINATED  = 0x00000020U,
}

enum uint DSBLOCK_FROMWRITECURSOR = 0x00000001U;
enum uint DSBLOCK_ENTIREBUFFER = 0x00000002U;

enum : uint
{
    DSBFREQUENCY_ORIGINAL = 0x00000000U,
    DSBFREQUENCY_MIN      = 0x00000064U,
    DSBFREQUENCY_MAX      = 0x00030d40U,
}

enum int DSBPAN_LEFT = 0xffffd8f0;

enum : uint
{
    DSBPAN_CENTER = 0x00000000U,
    DSBPAN_RIGHT  = 0x00002710U,
}

enum int DSBVOLUME_MIN = 0xffffd8f0;
enum uint DSBVOLUME_MAX = 0x00000000U;

enum : uint
{
    DSBSIZE_MIN    = 0x00000004U,
    DSBSIZE_MAX    = 0x0fffffffU,
    DSBSIZE_FX_MIN = 0x00000096U,
}

enum uint DSBNOTIFICATIONS_MAX = 0x000186a0U;

enum : uint
{
    DS3DMODE_NORMAL       = 0x00000000U,
    DS3DMODE_HEADRELATIVE = 0x00000001U,
    DS3DMODE_DISABLE      = 0x00000002U,
}

enum uint DS3D_IMMEDIATE = 0x00000000U;
enum uint DS3D_DEFERRED = 0x00000001U;
enum float DS3D_DEFAULTDISTANCEFACTOR = 0x1p+0;
enum float DS3D_MINROLLOFFFACTOR = 0x0p+0;
enum float DS3D_MAXROLLOFFFACTOR = 0x1.4p+3;
enum float DS3D_DEFAULTROLLOFFFACTOR = 0x1p+0;
enum float DS3D_MINDOPPLERFACTOR = 0x0p+0;
enum float DS3D_MAXDOPPLERFACTOR = 0x1.4p+3;

enum : float
{
    DS3D_DEFAULTDOPPLERFACTOR = 0x1p+0,
    DS3D_DEFAULTMINDISTANCE   = 0x1p+0,
    DS3D_DEFAULTMAXDISTANCE   = 0x1.dcd65p+29,
}

enum uint DS3D_MINCONEANGLE = 0x00000000U;
enum uint DS3D_MAXCONEANGLE = 0x00000168U;

enum : uint
{
    DS3D_DEFAULTCONEANGLE         = 0x00000168U,
    DS3D_DEFAULTCONEOUTSIDEVOLUME = 0x00000000U,
}

enum : uint
{
    DSCCAPS_EMULDRIVER      = 0x00000020U,
    DSCCAPS_CERTIFIED       = 0x00000040U,
    DSCCAPS_MULTIPLECAPTURE = 0x00000001U,
}

enum : uint
{
    DSCBCAPS_WAVEMAPPED = 0x80000000U,
    DSCBCAPS_CTRLFX     = 0x00000200U,
}

enum uint DSCBLOCK_ENTIREBUFFER = 0x00000001U;

enum : uint
{
    DSCBSTATUS_CAPTURING = 0x00000001U,
    DSCBSTATUS_LOOPING   = 0x00000002U,
}

enum uint DSCBSTART_LOOPING = 0x00000001U;
enum uint DSBPN_OFFSETSTOP = 0xffffffffU;
enum uint DS_CERTIFIED = 0x00000000U;
enum uint DS_UNCERTIFIED = 0x00000001U;
enum GUID DS3DALG_NO_VIRTUALIZATION = GUID("c241333f-1c1b-11d2-94f5-00c04fc28aca");

enum : GUID
{
    DS3DALG_HRTF_FULL  = GUID("c2413340-1c1b-11d2-94f5-00c04fc28aca"),
    DS3DALG_HRTF_LIGHT = GUID("c2413342-1c1b-11d2-94f5-00c04fc28aca"),
}

enum : GUID
{
    GUID_DSFX_STANDARD_GARGLE      = GUID("dafd8210-5711-4b91-9fe3-f75b7ae279bf"),
    GUID_DSFX_STANDARD_CHORUS      = GUID("efe6629c-81f7-4281-bd91-c9d604a95af6"),
    GUID_DSFX_STANDARD_FLANGER     = GUID("efca3d92-dfd8-4672-a603-7420894bad98"),
    GUID_DSFX_STANDARD_ECHO        = GUID("ef3e932c-d40b-4f51-8ccf-3f98f1b29d5d"),
    GUID_DSFX_STANDARD_DISTORTION  = GUID("ef114c90-cd1d-484e-96e5-09cfaf912a21"),
    GUID_DSFX_STANDARD_COMPRESSOR  = GUID("ef011f79-4000-406d-87af-bffb3fc39d57"),
    GUID_DSFX_STANDARD_PARAMEQ     = GUID("120ced89-3bf4-4173-a132-3cb406cf3231"),
    GUID_DSFX_STANDARD_I3DL2REVERB = GUID("ef985e71-d5c7-42d4-ba4d-2d073e2e96f4"),
}

enum GUID GUID_DSFX_WAVES_REVERB = GUID("87fc0268-9a55-4360-95aa-004a1d9de26c");

enum : GUID
{
    GUID_DSCFX_CLASS_AEC  = GUID("bf963d80-c559-11d0-8a2b-00a0c9255ac1"),
    GUID_DSCFX_MS_AEC     = GUID("cdebb919-379a-488a-8765-f53cfd36de40"),
    GUID_DSCFX_SYSTEM_AEC = GUID("1c22c56d-9879-4f5b-a389-27996ddc2810"),
    GUID_DSCFX_CLASS_NS   = GUID("e07f903f-62fd-4e60-8cdd-dea7236665b5"),
    GUID_DSCFX_MS_NS      = GUID("11c5c73b-66e9-4ba1-a0ba-e814c6eed92d"),
    GUID_DSCFX_SYSTEM_NS  = GUID("5ab0882e-7274-4516-877d-4eee99ba4fd0"),
}

enum : int
{
    DSFXR_PRESENT     = 0x00000000,
    DSFXR_LOCHARDWARE = 0x00000001,
    DSFXR_LOCSOFTWARE = 0x00000002,
}

enum int DSFXR_UNALLOCATED = 0x00000003;

enum : int
{
    DSFXR_FAILED   = 0x00000004,
    DSFXR_UNKNOWN  = 0x00000005,
    DSFXR_SENDLOOP = 0x00000006,
}

enum : int
{
    DSFX_I3DL2_MATERIAL_PRESET_SINGLEWINDOW = 0x00000000,
    DSFX_I3DL2_MATERIAL_PRESET_DOUBLEWINDOW = 0x00000001,
    DSFX_I3DL2_MATERIAL_PRESET_THINDOOR     = 0x00000002,
    DSFX_I3DL2_MATERIAL_PRESET_THICKDOOR    = 0x00000003,
    DSFX_I3DL2_MATERIAL_PRESET_WOODWALL     = 0x00000004,
    DSFX_I3DL2_MATERIAL_PRESET_BRICKWALL    = 0x00000005,
    DSFX_I3DL2_MATERIAL_PRESET_STONEWALL    = 0x00000006,
    DSFX_I3DL2_MATERIAL_PRESET_CURTAIN      = 0x00000007,
}

enum : int
{
    DSFX_I3DL2_ENVIRONMENT_PRESET_DEFAULT         = 0x00000000,
    DSFX_I3DL2_ENVIRONMENT_PRESET_GENERIC         = 0x00000001,
    DSFX_I3DL2_ENVIRONMENT_PRESET_PADDEDCELL      = 0x00000002,
    DSFX_I3DL2_ENVIRONMENT_PRESET_ROOM            = 0x00000003,
    DSFX_I3DL2_ENVIRONMENT_PRESET_BATHROOM        = 0x00000004,
    DSFX_I3DL2_ENVIRONMENT_PRESET_LIVINGROOM      = 0x00000005,
    DSFX_I3DL2_ENVIRONMENT_PRESET_STONEROOM       = 0x00000006,
    DSFX_I3DL2_ENVIRONMENT_PRESET_AUDITORIUM      = 0x00000007,
    DSFX_I3DL2_ENVIRONMENT_PRESET_CONCERTHALL     = 0x00000008,
    DSFX_I3DL2_ENVIRONMENT_PRESET_CAVE            = 0x00000009,
    DSFX_I3DL2_ENVIRONMENT_PRESET_ARENA           = 0x0000000a,
    DSFX_I3DL2_ENVIRONMENT_PRESET_HANGAR          = 0x0000000b,
    DSFX_I3DL2_ENVIRONMENT_PRESET_CARPETEDHALLWAY = 0x0000000c,
    DSFX_I3DL2_ENVIRONMENT_PRESET_HALLWAY         = 0x0000000d,
    DSFX_I3DL2_ENVIRONMENT_PRESET_STONECORRIDOR   = 0x0000000e,
    DSFX_I3DL2_ENVIRONMENT_PRESET_ALLEY           = 0x0000000f,
    DSFX_I3DL2_ENVIRONMENT_PRESET_FOREST          = 0x00000010,
    DSFX_I3DL2_ENVIRONMENT_PRESET_CITY            = 0x00000011,
    DSFX_I3DL2_ENVIRONMENT_PRESET_MOUNTAINS       = 0x00000012,
    DSFX_I3DL2_ENVIRONMENT_PRESET_QUARRY          = 0x00000013,
    DSFX_I3DL2_ENVIRONMENT_PRESET_PLAIN           = 0x00000014,
    DSFX_I3DL2_ENVIRONMENT_PRESET_PARKINGLOT      = 0x00000015,
    DSFX_I3DL2_ENVIRONMENT_PRESET_SEWERPIPE       = 0x00000016,
    DSFX_I3DL2_ENVIRONMENT_PRESET_UNDERWATER      = 0x00000017,
    DSFX_I3DL2_ENVIRONMENT_PRESET_SMALLROOM       = 0x00000018,
    DSFX_I3DL2_ENVIRONMENT_PRESET_MEDIUMROOM      = 0x00000019,
    DSFX_I3DL2_ENVIRONMENT_PRESET_LARGEROOM       = 0x0000001a,
    DSFX_I3DL2_ENVIRONMENT_PRESET_MEDIUMHALL      = 0x0000001b,
    DSFX_I3DL2_ENVIRONMENT_PRESET_LARGEHALL       = 0x0000001c,
    DSFX_I3DL2_ENVIRONMENT_PRESET_PLATE           = 0x0000001d,
}

// Callbacks

//DELEGATE ATTR: AnsiAttribute : CustomAttributeSig([], [])
alias LPDSENUMCALLBACKA = BOOL function(GUID* param0, const(PSTR) param1, const(PSTR) param2, void* param3);
//DELEGATE ATTR: UnicodeAttribute : CustomAttributeSig([], [])
alias LPDSENUMCALLBACKW = BOOL function(GUID* param0, const(PWSTR) param1, const(PWSTR) param2, void* param3);

// Structs


struct DSCAPS
{
    uint dwSize;
    uint dwFlags;
    uint dwMinSecondarySampleRate;
    uint dwMaxSecondarySampleRate;
    uint dwPrimaryBuffers;
    uint dwMaxHwMixingAllBuffers;
    uint dwMaxHwMixingStaticBuffers;
    uint dwMaxHwMixingStreamingBuffers;
    uint dwFreeHwMixingAllBuffers;
    uint dwFreeHwMixingStaticBuffers;
    uint dwFreeHwMixingStreamingBuffers;
    uint dwMaxHw3DAllBuffers;
    uint dwMaxHw3DStaticBuffers;
    uint dwMaxHw3DStreamingBuffers;
    uint dwFreeHw3DAllBuffers;
    uint dwFreeHw3DStaticBuffers;
    uint dwFreeHw3DStreamingBuffers;
    uint dwTotalHwMemBytes;
    uint dwFreeHwMemBytes;
    uint dwMaxContigFreeHwMemBytes;
    uint dwUnlockTransferRateHwBuffers;
    uint dwPlayCpuOverheadSwBuffers;
    uint dwReserved1;
    uint dwReserved2;
}

struct DSBCAPS
{
    uint dwSize;
    uint dwFlags;
    uint dwBufferBytes;
    uint dwUnlockTransferRate;
    uint dwPlayCpuOverhead;
}

struct DSEFFECTDESC
{
    uint   dwSize;
    uint   dwFlags;
    GUID   guidDSFXClass;
    size_t dwReserved1;
    size_t dwReserved2;
}

struct DSCEFFECTDESC
{
    uint dwSize;
    uint dwFlags;
    GUID guidDSCFXClass;
    GUID guidDSCFXInstance;
    uint dwReserved1;
    uint dwReserved2;
}

struct DSBUFFERDESC
{
    uint          dwSize;
    uint          dwFlags;
    uint          dwBufferBytes;
    uint          dwReserved;
    WAVEFORMATEX* lpwfxFormat;
    GUID          guid3DAlgorithm;
}

struct DSBUFFERDESC1
{
    uint          dwSize;
    uint          dwFlags;
    uint          dwBufferBytes;
    uint          dwReserved;
    WAVEFORMATEX* lpwfxFormat;
}

struct DS3DBUFFER
{
    uint      dwSize;
    D3DVECTOR vPosition;
    D3DVECTOR vVelocity;
    uint      dwInsideConeAngle;
    uint      dwOutsideConeAngle;
    D3DVECTOR vConeOrientation;
    int       lConeOutsideVolume;
    float     flMinDistance;
    float     flMaxDistance;
    uint      dwMode;
}

struct DS3DLISTENER
{
    uint      dwSize;
    D3DVECTOR vPosition;
    D3DVECTOR vVelocity;
    D3DVECTOR vOrientFront;
    D3DVECTOR vOrientTop;
    float     flDistanceFactor;
    float     flRolloffFactor;
    float     flDopplerFactor;
}

struct DSCCAPS
{
    uint dwSize;
    uint dwFlags;
    uint dwFormats;
    uint dwChannels;
}

struct DSCBUFFERDESC1
{
    uint          dwSize;
    uint          dwFlags;
    uint          dwBufferBytes;
    uint          dwReserved;
    WAVEFORMATEX* lpwfxFormat;
}

struct DSCBUFFERDESC
{
    uint           dwSize;
    uint           dwFlags;
    uint           dwBufferBytes;
    uint           dwReserved;
    WAVEFORMATEX*  lpwfxFormat;
    uint           dwFXCount;
    DSCEFFECTDESC* lpDSCFXDesc;
}

struct DSCBCAPS
{
    uint dwSize;
    uint dwFlags;
    uint dwBufferBytes;
    uint dwReserved;
}

struct DSBPOSITIONNOTIFY
{
    uint   dwOffset;
    HANDLE hEventNotify;
}

struct DSFXGargle
{
    uint dwRateHz;
    uint dwWaveShape;
}

struct DSFXChorus
{
    float fWetDryMix;
    float fDepth;
    float fFeedback;
    float fFrequency;
    int   lWaveform;
    float fDelay;
    int   lPhase;
}

struct DSFXFlanger
{
    float fWetDryMix;
    float fDepth;
    float fFeedback;
    float fFrequency;
    int   lWaveform;
    float fDelay;
    int   lPhase;
}

struct DSFXEcho
{
    float fWetDryMix;
    float fFeedback;
    float fLeftDelay;
    float fRightDelay;
    int   lPanDelay;
}

struct DSFXDistortion
{
    float fGain;
    float fEdge;
    float fPostEQCenterFrequency;
    float fPostEQBandwidth;
    float fPreLowpassCutoff;
}

struct DSFXCompressor
{
    float fGain;
    float fAttack;
    float fRelease;
    float fThreshold;
    float fRatio;
    float fPredelay;
}

struct DSFXParamEq
{
    float fCenter;
    float fBandwidth;
    float fGain;
}

struct DSFXI3DL2Reverb
{
    int   lRoom;
    int   lRoomHF;
    float flRoomRolloffFactor;
    float flDecayTime;
    float flDecayHFRatio;
    int   lReflections;
    float flReflectionsDelay;
    int   lReverb;
    float flReverbDelay;
    float flDiffusion;
    float flDensity;
    float flHFReference;
}

struct DSFXWavesReverb
{
    float fInGain;
    float fReverbMix;
    float fReverbTime;
    float fHighFreqRTRatio;
}

struct DSCFXAec
{
    BOOL fEnable;
    BOOL fNoiseFill;
    uint dwMode;
}

struct DSCFXNoiseSuppress
{
    BOOL fEnable;
}

// Functions

@DllImport("DSOUND.dll")
HRESULT DirectSoundCreate(const(GUID)* pcGuidDevice, IDirectSound* ppDS, IUnknown pUnkOuter);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("DSOUND.dll")
HRESULT DirectSoundEnumerateA(LPDSENUMCALLBACKA pDSEnumCallback, void* pContext);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("DSOUND.dll")
HRESULT DirectSoundEnumerateW(LPDSENUMCALLBACKW pDSEnumCallback, void* pContext);

@DllImport("DSOUND.dll")
HRESULT DirectSoundCaptureCreate(const(GUID)* pcGuidDevice, IDirectSoundCapture* ppDSC, IUnknown pUnkOuter);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("DSOUND.dll")
HRESULT DirectSoundCaptureEnumerateA(LPDSENUMCALLBACKA pDSEnumCallback, void* pContext);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("DSOUND.dll")
HRESULT DirectSoundCaptureEnumerateW(LPDSENUMCALLBACKW pDSEnumCallback, void* pContext);

@DllImport("DSOUND.dll")
HRESULT DirectSoundCreate8(const(GUID)* pcGuidDevice, IDirectSound8* ppDS8, IUnknown pUnkOuter);

@DllImport("DSOUND.dll")
HRESULT DirectSoundCaptureCreate8(const(GUID)* pcGuidDevice, IDirectSoundCapture* ppDSC8, IUnknown pUnkOuter);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/DevNotes/directsoundfullduplexcreate
@DllImport("DSOUND.dll")
HRESULT DirectSoundFullDuplexCreate(const(GUID)* pcGuidCaptureDevice, const(GUID)* pcGuidRenderDevice, 
                                    DSCBUFFERDESC* pcDSCBufferDesc, DSBUFFERDESC* pcDSBufferDesc, HWND hWnd, 
                                    uint dwLevel, IDirectSoundFullDuplex* ppDSFD, 
                                    IDirectSoundCaptureBuffer8* ppDSCBuffer8, IDirectSoundBuffer8* ppDSBuffer8, 
                                    IUnknown pUnkOuter);

@DllImport("DSOUND.dll")
HRESULT GetDeviceID(const(GUID)* pGuidSrc, GUID* pGuidDest);


// Interfaces

@GUID("279afa83-4981-11ce-a521-0020af0be560")
interface IDirectSound : IUnknown
{
    HRESULT CreateSoundBuffer(DSBUFFERDESC* pcDSBufferDesc, IDirectSoundBuffer* ppDSBuffer, IUnknown pUnkOuter);
    HRESULT GetCaps(DSCAPS* pDSCaps);
    HRESULT DuplicateSoundBuffer(IDirectSoundBuffer pDSBufferOriginal, IDirectSoundBuffer* ppDSBufferDuplicate);
    HRESULT SetCooperativeLevel(HWND hwnd, uint dwLevel);
    HRESULT Compact();
    HRESULT GetSpeakerConfig(uint* pdwSpeakerConfig);
    HRESULT SetSpeakerConfig(uint dwSpeakerConfig);
    HRESULT Initialize(const(GUID)* pcGuidDevice);
}

@GUID("c50a7e93-f395-4834-9ef6-7fa99de50966")
interface IDirectSound8 : IDirectSound
{
    HRESULT VerifyCertification(uint* pdwCertified);
}

@GUID("279afa85-4981-11ce-a521-0020af0be560")
interface IDirectSoundBuffer : IUnknown
{
    HRESULT GetCaps(DSBCAPS* pDSBufferCaps);
    HRESULT GetCurrentPosition(uint* pdwCurrentPlayCursor, uint* pdwCurrentWriteCursor);
    HRESULT GetFormat(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/WAVEFORMATEX* pwfxFormat, 
                      uint dwSizeAllocated, uint* pdwSizeWritten);
    HRESULT GetVolume(int* plVolume);
    HRESULT GetPan(int* plPan);
    HRESULT GetFrequency(uint* pdwFrequency);
    HRESULT GetStatus(uint* pdwStatus);
    HRESULT Initialize(IDirectSound pDirectSound, DSBUFFERDESC* pcDSBufferDesc);
    HRESULT Lock(uint dwOffset, uint dwBytes, void** ppvAudioPtr1, uint* pdwAudioBytes1, void** ppvAudioPtr2, 
                 uint* pdwAudioBytes2, uint dwFlags);
    HRESULT Play(uint dwReserved1, uint dwPriority, uint dwFlags);
    HRESULT SetCurrentPosition(uint dwNewPosition);
    HRESULT SetFormat(WAVEFORMATEX* pcfxFormat);
    HRESULT SetVolume(int lVolume);
    HRESULT SetPan(int lPan);
    HRESULT SetFrequency(uint dwFrequency);
    HRESULT Stop();
    HRESULT Unlock(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* pvAudioPtr1, 
                   uint dwAudioBytes1, 
                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pvAudioPtr2, 
                   uint dwAudioBytes2);
    HRESULT Restore();
}

@GUID("6825a449-7524-4d82-920f-50e36ab3ab1e")
interface IDirectSoundBuffer8 : IDirectSoundBuffer
{
    HRESULT SetFX(uint dwEffectsCount, DSEFFECTDESC* pDSFXDesc, uint* pdwResultCodes);
    HRESULT AcquireResources(uint dwFlags, uint dwEffectsCount, uint* pdwResultCodes);
    HRESULT GetObjectInPath(const(GUID)* rguidObject, uint dwIndex, const(GUID)* rguidInterface, void** ppObject);
}

@GUID("279afa84-4981-11ce-a521-0020af0be560")
interface IDirectSound3DListener : IUnknown
{
    HRESULT GetAllParameters(DS3DLISTENER* pListener);
    HRESULT GetDistanceFactor(float* pflDistanceFactor);
    HRESULT GetDopplerFactor(float* pflDopplerFactor);
    HRESULT GetOrientation(D3DVECTOR* pvOrientFront, D3DVECTOR* pvOrientTop);
    HRESULT GetPosition(D3DVECTOR* pvPosition);
    HRESULT GetRolloffFactor(float* pflRolloffFactor);
    HRESULT GetVelocity(D3DVECTOR* pvVelocity);
    HRESULT SetAllParameters(DS3DLISTENER* pcListener, uint dwApply);
    HRESULT SetDistanceFactor(float flDistanceFactor, uint dwApply);
    HRESULT SetDopplerFactor(float flDopplerFactor, uint dwApply);
    HRESULT SetOrientation(float xFront, float yFront, float zFront, float xTop, float yTop, float zTop, 
                           uint dwApply);
    HRESULT SetPosition(float x, float y, float z, uint dwApply);
    HRESULT SetRolloffFactor(float flRolloffFactor, uint dwApply);
    HRESULT SetVelocity(float x, float y, float z, uint dwApply);
    HRESULT CommitDeferredSettings();
}

@GUID("279afa86-4981-11ce-a521-0020af0be560")
interface IDirectSound3DBuffer : IUnknown
{
    HRESULT GetAllParameters(DS3DBUFFER* pDs3dBuffer);
    HRESULT GetConeAngles(uint* pdwInsideConeAngle, uint* pdwOutsideConeAngle);
    HRESULT GetConeOrientation(D3DVECTOR* pvOrientation);
    HRESULT GetConeOutsideVolume(int* plConeOutsideVolume);
    HRESULT GetMaxDistance(float* pflMaxDistance);
    HRESULT GetMinDistance(float* pflMinDistance);
    HRESULT GetMode(uint* pdwMode);
    HRESULT GetPosition(D3DVECTOR* pvPosition);
    HRESULT GetVelocity(D3DVECTOR* pvVelocity);
    HRESULT SetAllParameters(DS3DBUFFER* pcDs3dBuffer, uint dwApply);
    HRESULT SetConeAngles(uint dwInsideConeAngle, uint dwOutsideConeAngle, uint dwApply);
    HRESULT SetConeOrientation(float x, float y, float z, uint dwApply);
    HRESULT SetConeOutsideVolume(int lConeOutsideVolume, uint dwApply);
    HRESULT SetMaxDistance(float flMaxDistance, uint dwApply);
    HRESULT SetMinDistance(float flMinDistance, uint dwApply);
    HRESULT SetMode(uint dwMode, uint dwApply);
    HRESULT SetPosition(float x, float y, float z, uint dwApply);
    HRESULT SetVelocity(float x, float y, float z, uint dwApply);
}

@GUID("b0210781-89cd-11d0-af08-00a0c925cd16")
interface IDirectSoundCapture : IUnknown
{
    HRESULT CreateCaptureBuffer(DSCBUFFERDESC* pcDSCBufferDesc, IDirectSoundCaptureBuffer* ppDSCBuffer, 
                                IUnknown pUnkOuter);
    HRESULT GetCaps(DSCCAPS* pDSCCaps);
    HRESULT Initialize(const(GUID)* pcGuidDevice);
}

@GUID("b0210782-89cd-11d0-af08-00a0c925cd16")
interface IDirectSoundCaptureBuffer : IUnknown
{
    HRESULT GetCaps(DSCBCAPS* pDSCBCaps);
    HRESULT GetCurrentPosition(uint* pdwCapturePosition, uint* pdwReadPosition);
    HRESULT GetFormat(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/WAVEFORMATEX* pwfxFormat, 
                      uint dwSizeAllocated, uint* pdwSizeWritten);
    HRESULT GetStatus(uint* pdwStatus);
    HRESULT Initialize(IDirectSoundCapture pDirectSoundCapture, DSCBUFFERDESC* pcDSCBufferDesc);
    HRESULT Lock(uint dwOffset, uint dwBytes, void** ppvAudioPtr1, uint* pdwAudioBytes1, void** ppvAudioPtr2, 
                 uint* pdwAudioBytes2, uint dwFlags);
    HRESULT Start(uint dwFlags);
    HRESULT Stop();
    HRESULT Unlock(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* pvAudioPtr1, 
                   uint dwAudioBytes1, 
                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pvAudioPtr2, 
                   uint dwAudioBytes2);
}

@GUID("00990df4-0dbb-4872-833e-6d303e80aeb6")
interface IDirectSoundCaptureBuffer8 : IDirectSoundCaptureBuffer
{
    HRESULT GetObjectInPath(const(GUID)* rguidObject, uint dwIndex, const(GUID)* rguidInterface, void** ppObject);
    HRESULT GetFXStatus(uint dwEffectsCount, uint* pdwFXStatus);
}

@GUID("b0210783-89cd-11d0-af08-00a0c925cd16")
interface IDirectSoundNotify : IUnknown
{
    HRESULT SetNotificationPositions(uint dwPositionNotifies, DSBPOSITIONNOTIFY* pcPositionNotifies);
}

@GUID("d616f352-d622-11ce-aac5-0020af0b99a3")
interface IDirectSoundFXGargle : IUnknown
{
    HRESULT SetAllParameters(DSFXGargle* pcDsFxGargle);
    HRESULT GetAllParameters(DSFXGargle* pDsFxGargle);
}

@GUID("880842e3-145f-43e6-a934-a71806e50547")
interface IDirectSoundFXChorus : IUnknown
{
    HRESULT SetAllParameters(DSFXChorus* pcDsFxChorus);
    HRESULT GetAllParameters(DSFXChorus* pDsFxChorus);
}

@GUID("903e9878-2c92-4072-9b2c-ea68f5396783")
interface IDirectSoundFXFlanger : IUnknown
{
    HRESULT SetAllParameters(DSFXFlanger* pcDsFxFlanger);
    HRESULT GetAllParameters(DSFXFlanger* pDsFxFlanger);
}

@GUID("8bd28edf-50db-4e92-a2bd-445488d1ed42")
interface IDirectSoundFXEcho : IUnknown
{
    HRESULT SetAllParameters(DSFXEcho* pcDsFxEcho);
    HRESULT GetAllParameters(DSFXEcho* pDsFxEcho);
}

@GUID("8ecf4326-455f-4d8b-bda9-8d5d3e9e3e0b")
interface IDirectSoundFXDistortion : IUnknown
{
    HRESULT SetAllParameters(DSFXDistortion* pcDsFxDistortion);
    HRESULT GetAllParameters(DSFXDistortion* pDsFxDistortion);
}

@GUID("4bbd1154-62f6-4e2c-a15c-d3b6c417f7a0")
interface IDirectSoundFXCompressor : IUnknown
{
    HRESULT SetAllParameters(DSFXCompressor* pcDsFxCompressor);
    HRESULT GetAllParameters(DSFXCompressor* pDsFxCompressor);
}

@GUID("c03ca9fe-fe90-4204-8078-82334cd177da")
interface IDirectSoundFXParamEq : IUnknown
{
    HRESULT SetAllParameters(DSFXParamEq* pcDsFxParamEq);
    HRESULT GetAllParameters(DSFXParamEq* pDsFxParamEq);
}

@GUID("4b166a6a-0d66-43f3-80e3-ee6280dee1a4")
interface IDirectSoundFXI3DL2Reverb : IUnknown
{
    HRESULT SetAllParameters(DSFXI3DL2Reverb* pcDsFxI3DL2Reverb);
    HRESULT GetAllParameters(DSFXI3DL2Reverb* pDsFxI3DL2Reverb);
    HRESULT SetPreset(uint dwPreset);
    HRESULT GetPreset(uint* pdwPreset);
    HRESULT SetQuality(int lQuality);
    HRESULT GetQuality(int* plQuality);
}

@GUID("46858c3a-0dc6-45e3-b760-d4eef16cb325")
interface IDirectSoundFXWavesReverb : IUnknown
{
    HRESULT SetAllParameters(DSFXWavesReverb* pcDsFxWavesReverb);
    HRESULT GetAllParameters(DSFXWavesReverb* pDsFxWavesReverb);
}

@GUID("ad74143d-903d-4ab7-8066-28d363036d65")
interface IDirectSoundCaptureFXAec : IUnknown
{
    HRESULT SetAllParameters(DSCFXAec* pDscFxAec);
    HRESULT GetAllParameters(DSCFXAec* pDscFxAec);
    HRESULT GetStatus(uint* pdwStatus);
    HRESULT Reset();
}

@GUID("ed311e41-fbae-4175-9625-cd0854f693ca")
interface IDirectSoundCaptureFXNoiseSuppress : IUnknown
{
    HRESULT SetAllParameters(DSCFXNoiseSuppress* pcDscFxNoiseSuppress);
    HRESULT GetAllParameters(DSCFXNoiseSuppress* pDscFxNoiseSuppress);
    HRESULT Reset();
}

@GUID("edcb4c7a-daab-4216-a42e-6c50596ddc1d")
interface IDirectSoundFullDuplex : IUnknown
{
    HRESULT Initialize(const(GUID)* pCaptureGuid, const(GUID)* pRenderGuid, DSCBUFFERDESC* lpDscBufferDesc, 
                       DSBUFFERDESC* lpDsBufferDesc, HWND hWnd, uint dwLevel, 
                       IDirectSoundCaptureBuffer8* lplpDirectSoundCaptureBuffer8, 
                       IDirectSoundBuffer8* lplpDirectSoundBuffer8);
}


// GUIDs


const GUID IID_IDirectSound                       = GUIDOF!IDirectSound;
const GUID IID_IDirectSound3DBuffer               = GUIDOF!IDirectSound3DBuffer;
const GUID IID_IDirectSound3DListener             = GUIDOF!IDirectSound3DListener;
const GUID IID_IDirectSound8                      = GUIDOF!IDirectSound8;
const GUID IID_IDirectSoundBuffer                 = GUIDOF!IDirectSoundBuffer;
const GUID IID_IDirectSoundBuffer8                = GUIDOF!IDirectSoundBuffer8;
const GUID IID_IDirectSoundCapture                = GUIDOF!IDirectSoundCapture;
const GUID IID_IDirectSoundCaptureBuffer          = GUIDOF!IDirectSoundCaptureBuffer;
const GUID IID_IDirectSoundCaptureBuffer8         = GUIDOF!IDirectSoundCaptureBuffer8;
const GUID IID_IDirectSoundCaptureFXAec           = GUIDOF!IDirectSoundCaptureFXAec;
const GUID IID_IDirectSoundCaptureFXNoiseSuppress = GUIDOF!IDirectSoundCaptureFXNoiseSuppress;
const GUID IID_IDirectSoundFXChorus               = GUIDOF!IDirectSoundFXChorus;
const GUID IID_IDirectSoundFXCompressor           = GUIDOF!IDirectSoundFXCompressor;
const GUID IID_IDirectSoundFXDistortion           = GUIDOF!IDirectSoundFXDistortion;
const GUID IID_IDirectSoundFXEcho                 = GUIDOF!IDirectSoundFXEcho;
const GUID IID_IDirectSoundFXFlanger              = GUIDOF!IDirectSoundFXFlanger;
const GUID IID_IDirectSoundFXGargle               = GUIDOF!IDirectSoundFXGargle;
const GUID IID_IDirectSoundFXI3DL2Reverb          = GUIDOF!IDirectSoundFXI3DL2Reverb;
const GUID IID_IDirectSoundFXParamEq              = GUIDOF!IDirectSoundFXParamEq;
const GUID IID_IDirectSoundFXWavesReverb          = GUIDOF!IDirectSoundFXWavesReverb;
const GUID IID_IDirectSoundFullDuplex             = GUIDOF!IDirectSoundFullDuplex;
const GUID IID_IDirectSoundNotify                 = GUIDOF!IDirectSoundNotify;
