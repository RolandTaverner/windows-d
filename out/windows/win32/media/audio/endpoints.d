// Written in the D programming language.

module windows.win32.media.audio.endpoints;

public import windows.core;
public import windows.win32.foundation : BOOL, HRESULT, PROPERTYKEY, PWSTR;
public import windows.win32.media.audio : AUDIO_VOLUME_NOTIFICATION_DATA;
public import windows.win32.media.audio.apo : APO_CONNECTION_PROPERTY;
public import windows.win32.media.audio : IMMDevice, WAVEFORMATEX;
public import windows.win32.media.kernelstreaming : AUDIO_CURVE_TYPE;
public import windows.win32.system.com : IUnknown;

extern(Windows) @nogc nothrow:


// Enums


enum EndpointConnectorType : int
{
    eHostProcessConnector        = 0x00000000,
    eOffloadConnector            = 0x00000001,
    eLoopbackConnector           = 0x00000002,
    eKeywordDetectorConnector    = 0x00000003,
    eLoopbackConnectorPostVolume = 0x00000004,
    eConnectorCount              = 0x00000005,
}

// Constants


enum : PROPERTYKEY
{
    DEVPKEY_AudioEndpointPlugin_FactoryCLSID  = PROPERTYKEY(GUID("12D83BD7-CF12-46BE-8540-812710D3021C"), 1),
    DEVPKEY_AudioEndpointPlugin_DataFlow      = PROPERTYKEY(GUID("12D83BD7-CF12-46BE-8540-812710D3021C"), 2),
    DEVPKEY_AudioEndpointPlugin_PnPInterface  = PROPERTYKEY(GUID("12D83BD7-CF12-46BE-8540-812710D3021C"), 3),
    DEVPKEY_AudioEndpointPlugin2_FactoryCLSID = PROPERTYKEY(GUID("12D83BD7-CF12-46BE-8540-812710D3021C"), 4),
}

// Structs


struct AUDIO_ENDPOINT_SHARED_CREATE_PARAMS
{
    uint         u32Size;
    uint         u32TSSessionId;
    EndpointConnectorType targetEndpointConnectorType;
    WAVEFORMATEX wfxDeviceFormat;
}

// Interfaces

@GUID("9f2f7b66-65ac-4fa6-8ae4-123c78b89313")
struct DEVINTERFACE_AUDIOENDPOINTPLUGIN;

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioendpoints/nn-audioendpoints-iaudioendpointformatcontrol
@GUID("784cfd40-9f89-456e-a1a6-873b006a664e")
interface IAudioEndpointFormatControl : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioendpoints/nf-audioendpoints-iaudioendpointformatcontrol-resettodefault
    HRESULT ResetToDefault(uint ResetFlags);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/nn-audioengineendpoint-iaudioendpointoffloadstreamvolume
@GUID("64f1dd49-71ca-4281-8672-3a9eddd1d0b6")
interface IAudioEndpointOffloadStreamVolume : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/nf-audioengineendpoint-iaudioendpointoffloadstreamvolume-getvolumechannelcount
    HRESULT GetVolumeChannelCount(uint* pu32ChannelCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/nf-audioengineendpoint-iaudioendpointoffloadstreamvolume-setchannelvolumes
    HRESULT SetChannelVolumes(uint u32ChannelCount, float* pf32Volumes, AUDIO_CURVE_TYPE u32CurveType, 
                              long* pCurveDuration);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/nf-audioengineendpoint-iaudioendpointoffloadstreamvolume-getchannelvolumes
    HRESULT GetChannelVolumes(uint u32ChannelCount, float* pf32Volumes);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/nn-audioengineendpoint-iaudioendpointoffloadstreammute
@GUID("dfe21355-5ec2-40e0-8d6b-710ac3c00249")
interface IAudioEndpointOffloadStreamMute : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/nf-audioengineendpoint-iaudioendpointoffloadstreammute-setmute
    HRESULT SetMute(ubyte bMuted);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/nf-audioengineendpoint-iaudioendpointoffloadstreammute-getmute
    HRESULT GetMute(ubyte* pbMuted);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/nn-audioengineendpoint-iaudioendpointoffloadstreammeter
@GUID("e1546dce-9dd1-418b-9ab2-348ced161c86")
interface IAudioEndpointOffloadStreamMeter : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/nf-audioengineendpoint-iaudioendpointoffloadstreammeter-getmeterchannelcount
    HRESULT GetMeterChannelCount(uint* pu32ChannelCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/nf-audioengineendpoint-iaudioendpointoffloadstreammeter-getmeteringdata
    HRESULT GetMeteringData(uint u32ChannelCount, float* pf32PeakValues);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/nn-audioengineendpoint-iaudioendpointlastbuffercontrol
@GUID("f8520dd3-8f9d-4437-9861-62f584c33dd6")
interface IAudioEndpointLastBufferControl : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/nf-audioengineendpoint-iaudioendpointlastbuffercontrol-islastbuffercontrolsupported
    BOOL IsLastBufferControlSupported();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/nf-audioengineendpoint-iaudioendpointlastbuffercontrol-releaseoutputdatapointerforlastbuffer
    void ReleaseOutputDataPointerForLastBuffer(const(APO_CONNECTION_PROPERTY)* pConnectionProperty);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/nn-audioengineendpoint-iaudiolfxcontrol
@GUID("076a6922-d802-4f83-baf6-409d9ca11bfe")
interface IAudioLfxControl : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/nf-audioengineendpoint-iaudiolfxcontrol-setlocaleffectsstate
    HRESULT SetLocalEffectsState(BOOL bEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/nf-audioengineendpoint-iaudiolfxcontrol-getlocaleffectsstate
    HRESULT GetLocalEffectsState(BOOL* pbEnabled);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/nn-audioengineendpoint-ihardwareaudioenginebase
@GUID("eddce3e4-f3c1-453a-b461-223563cbd886")
interface IHardwareAudioEngineBase : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/nf-audioengineendpoint-ihardwareaudioenginebase-getavailableoffloadconnectorcount
    HRESULT GetAvailableOffloadConnectorCount(PWSTR _pwstrDeviceId, uint _uConnectorId, 
                                              uint* _pAvailableConnectorInstanceCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/nf-audioengineendpoint-ihardwareaudioenginebase-getengineformat
    HRESULT GetEngineFormat(IMMDevice pDevice, BOOL _bRequestDeviceFormat, WAVEFORMATEX** _ppwfxFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/nf-audioengineendpoint-ihardwareaudioenginebase-setenginedeviceformat
    HRESULT SetEngineDeviceFormat(IMMDevice pDevice, WAVEFORMATEX* _pwfxFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/nf-audioengineendpoint-ihardwareaudioenginebase-setgfxstate
    HRESULT SetGfxState(IMMDevice pDevice, BOOL _bEnable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audioengineendpoint/nf-audioengineendpoint-ihardwareaudioenginebase-getgfxstate
    HRESULT GetGfxState(IMMDevice pDevice, BOOL* _pbEnable);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/endpointvolume/nn-endpointvolume-iaudioendpointvolumecallback
@GUID("657804fa-d6ad-4496-8a60-352752af4f89")
interface IAudioEndpointVolumeCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/endpointvolume/nf-endpointvolume-iaudioendpointvolumecallback-onnotify
    HRESULT OnNotify(AUDIO_VOLUME_NOTIFICATION_DATA* pNotify);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/endpointvolume/nn-endpointvolume-iaudioendpointvolume
@GUID("5cdf2c82-841e-4546-9722-0cf74078229a")
interface IAudioEndpointVolume : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/endpointvolume/nf-endpointvolume-iaudioendpointvolume-registercontrolchangenotify
    HRESULT RegisterControlChangeNotify(IAudioEndpointVolumeCallback pNotify);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/endpointvolume/nf-endpointvolume-iaudioendpointvolume-unregistercontrolchangenotify
    HRESULT UnregisterControlChangeNotify(IAudioEndpointVolumeCallback pNotify);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/endpointvolume/nf-endpointvolume-iaudioendpointvolume-getchannelcount
    HRESULT GetChannelCount(uint* pnChannelCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/endpointvolume/nf-endpointvolume-iaudioendpointvolume-setmastervolumelevel
    HRESULT SetMasterVolumeLevel(float fLevelDB, const(GUID)* pguidEventContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/endpointvolume/nf-endpointvolume-iaudioendpointvolume-setmastervolumelevelscalar
    HRESULT SetMasterVolumeLevelScalar(float fLevel, const(GUID)* pguidEventContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/endpointvolume/nf-endpointvolume-iaudioendpointvolume-getmastervolumelevel
    HRESULT GetMasterVolumeLevel(float* pfLevelDB);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/endpointvolume/nf-endpointvolume-iaudioendpointvolume-getmastervolumelevelscalar
    HRESULT GetMasterVolumeLevelScalar(float* pfLevel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/endpointvolume/nf-endpointvolume-iaudioendpointvolume-setchannelvolumelevel
    HRESULT SetChannelVolumeLevel(uint nChannel, float fLevelDB, const(GUID)* pguidEventContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/endpointvolume/nf-endpointvolume-iaudioendpointvolume-setchannelvolumelevelscalar
    HRESULT SetChannelVolumeLevelScalar(uint nChannel, float fLevel, const(GUID)* pguidEventContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/endpointvolume/nf-endpointvolume-iaudioendpointvolume-getchannelvolumelevel
    HRESULT GetChannelVolumeLevel(uint nChannel, float* pfLevelDB);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/endpointvolume/nf-endpointvolume-iaudioendpointvolume-getchannelvolumelevelscalar
    HRESULT GetChannelVolumeLevelScalar(uint nChannel, float* pfLevel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/endpointvolume/nf-endpointvolume-iaudioendpointvolume-setmute
    HRESULT SetMute(BOOL bMute, const(GUID)* pguidEventContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/endpointvolume/nf-endpointvolume-iaudioendpointvolume-getmute
    HRESULT GetMute(BOOL* pbMute);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/endpointvolume/nf-endpointvolume-iaudioendpointvolume-getvolumestepinfo
    HRESULT GetVolumeStepInfo(uint* pnStep, uint* pnStepCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/endpointvolume/nf-endpointvolume-iaudioendpointvolume-volumestepup
    HRESULT VolumeStepUp(const(GUID)* pguidEventContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/endpointvolume/nf-endpointvolume-iaudioendpointvolume-volumestepdown
    HRESULT VolumeStepDown(const(GUID)* pguidEventContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/endpointvolume/nf-endpointvolume-iaudioendpointvolume-queryhardwaresupport
    HRESULT QueryHardwareSupport(uint* pdwHardwareSupportMask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/endpointvolume/nf-endpointvolume-iaudioendpointvolume-getvolumerange
    HRESULT GetVolumeRange(float* pflVolumeMindB, float* pflVolumeMaxdB, float* pflVolumeIncrementdB);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/endpointvolume/nn-endpointvolume-iaudioendpointvolumeex
@GUID("66e11784-f695-4f28-a505-a7080081a78f")
interface IAudioEndpointVolumeEx : IAudioEndpointVolume
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/endpointvolume/nf-endpointvolume-iaudioendpointvolumeex-getvolumerangechannel
    HRESULT GetVolumeRangeChannel(uint iChannel, float* pflVolumeMindB, float* pflVolumeMaxdB, 
                                  float* pflVolumeIncrementdB);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/endpointvolume/nn-endpointvolume-iaudiometerinformation
@GUID("c02216f6-8c67-4b5b-9d00-d008e73e0064")
interface IAudioMeterInformation : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/endpointvolume/nf-endpointvolume-iaudiometerinformation-getpeakvalue
    HRESULT GetPeakValue(float* pfPeak);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/endpointvolume/nf-endpointvolume-iaudiometerinformation-getmeteringchannelcount
    HRESULT GetMeteringChannelCount(uint* pnChannelCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/endpointvolume/nf-endpointvolume-iaudiometerinformation-getchannelspeakvalues
    HRESULT GetChannelsPeakValues(uint u32ChannelCount, float* afPeakValues);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/endpointvolume/nf-endpointvolume-iaudiometerinformation-queryhardwaresupport
    HRESULT QueryHardwareSupport(uint* pdwHardwareSupportMask);
}


// GUIDs

const GUID CLSID_DEVINTERFACE_AUDIOENDPOINTPLUGIN = GUIDOF!DEVINTERFACE_AUDIOENDPOINTPLUGIN;

const GUID IID_IAudioEndpointFormatControl       = GUIDOF!IAudioEndpointFormatControl;
const GUID IID_IAudioEndpointLastBufferControl   = GUIDOF!IAudioEndpointLastBufferControl;
const GUID IID_IAudioEndpointOffloadStreamMeter  = GUIDOF!IAudioEndpointOffloadStreamMeter;
const GUID IID_IAudioEndpointOffloadStreamMute   = GUIDOF!IAudioEndpointOffloadStreamMute;
const GUID IID_IAudioEndpointOffloadStreamVolume = GUIDOF!IAudioEndpointOffloadStreamVolume;
const GUID IID_IAudioEndpointVolume              = GUIDOF!IAudioEndpointVolume;
const GUID IID_IAudioEndpointVolumeCallback      = GUIDOF!IAudioEndpointVolumeCallback;
const GUID IID_IAudioEndpointVolumeEx            = GUIDOF!IAudioEndpointVolumeEx;
const GUID IID_IAudioLfxControl                  = GUIDOF!IAudioLfxControl;
const GUID IID_IAudioMeterInformation            = GUIDOF!IAudioMeterInformation;
const GUID IID_IHardwareAudioEngineBase          = GUIDOF!IHardwareAudioEngineBase;
