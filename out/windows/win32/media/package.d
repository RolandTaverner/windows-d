// Written in the D programming language.

module windows.win32.media;

public import windows.core;
public import windows.win32.foundation : HANDLE, HRESULT;
public import windows.win32.media.multimedia : HDRVR;
public import windows.win32.system.com : IUnknown;

extern(Windows) @nogc nothrow:


// Enums


alias TIMECODE_SAMPLE_FLAGS = uint;
enum : uint
{
    ED_DEVCAP_TIMECODE_READ = 0x00001019U,
    ED_DEVCAP_ATN_READ      = 0x000013b7U,
    ED_DEVCAP_RTC_READ      = 0x000013baU,
}

// Constants


enum : uint
{
    TIMERR_NOERROR = 0x00000000U,
    TIMERR_NOCANDO = 0x00000061U,
    TIMERR_STRUCT  = 0x00000081U,
}

enum uint MAXPNAMELEN = 0x00000020U;
enum uint MAXERRORLENGTH = 0x00000100U;

enum : uint
{
    MM_MICROSOFT   = 0x00000001U,
    MM_MIDI_MAPPER = 0x00000001U,
}

enum uint MM_WAVE_MAPPER = 0x00000002U;

enum : uint
{
    MM_SNDBLST_MIDIOUT = 0x00000003U,
    MM_SNDBLST_MIDIIN  = 0x00000004U,
    MM_SNDBLST_SYNTH   = 0x00000005U,
    MM_SNDBLST_WAVEOUT = 0x00000006U,
    MM_SNDBLST_WAVEIN  = 0x00000007U,
}

enum uint MM_ADLIB = 0x00000009U;

enum : uint
{
    MM_MPU401_MIDIOUT = 0x0000000aU,
    MM_MPU401_MIDIIN  = 0x0000000bU,
}

enum uint MM_PC_JOYSTICK = 0x0000000cU;

enum : uint
{
    TIME_MS      = 0x00000001U,
    TIME_SAMPLES = 0x00000002U,
    TIME_BYTES   = 0x00000004U,
    TIME_SMPTE   = 0x00000008U,
    TIME_MIDI    = 0x00000010U,
    TIME_TICKS   = 0x00000020U,
}

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Multimedia/mm-joy1move
    MM_JOY1MOVE       = 0x000003a0U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Multimedia/mm-joy2move
    MM_JOY2MOVE       = 0x000003a1U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Multimedia/mm-joy1zmove
    MM_JOY1ZMOVE      = 0x000003a2U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Multimedia/mm-joy2zmove
    MM_JOY2ZMOVE      = 0x000003a3U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Multimedia/mm-joy1buttondown
    MM_JOY1BUTTONDOWN = 0x000003b5U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/Multimedia/mm-joy2buttondown
enum uint MM_JOY2BUTTONDOWN = 0x000003b6U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Multimedia/mm-joy1buttonup
enum uint MM_JOY1BUTTONUP = 0x000003b7U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Multimedia/mm-joy2buttonup
enum uint MM_JOY2BUTTONUP = 0x000003b8U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Multimedia/mm-mcinotify
enum uint MM_MCINOTIFY = 0x000003b9U;

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Multimedia/mm-wom-open
    MM_WOM_OPEN  = 0x000003bbU,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Multimedia/mm-wom-close
    MM_WOM_CLOSE = 0x000003bcU,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Multimedia/mm-wom-done
    MM_WOM_DONE  = 0x000003bdU,
}

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Multimedia/mm-wim-open
    MM_WIM_OPEN  = 0x000003beU,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Multimedia/mm-wim-close
    MM_WIM_CLOSE = 0x000003bfU,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Multimedia/mm-wim-data
    MM_WIM_DATA  = 0x000003c0U,
}

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Multimedia/mm-mim-open
    MM_MIM_OPEN      = 0x000003c1U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Multimedia/mm-mim-close
    MM_MIM_CLOSE     = 0x000003c2U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Multimedia/mm-mim-data
    MM_MIM_DATA      = 0x000003c3U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Multimedia/mm-mim-longdata
    MM_MIM_LONGDATA  = 0x000003c4U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Multimedia/mm-mim-error
    MM_MIM_ERROR     = 0x000003c5U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Multimedia/mm-mim-longerror
    MM_MIM_LONGERROR = 0x000003c6U,
}

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Multimedia/mm-mom-open
    MM_MOM_OPEN  = 0x000003c7U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Multimedia/mm-mom-close
    MM_MOM_CLOSE = 0x000003c8U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Multimedia/mm-mom-done
    MM_MOM_DONE  = 0x000003c9U,
}

enum : uint
{
    MM_DRVM_OPEN  = 0x000003d0U,
    MM_DRVM_CLOSE = 0x000003d1U,
    MM_DRVM_DATA  = 0x000003d2U,
    MM_DRVM_ERROR = 0x000003d3U,
}

enum : uint
{
    MM_STREAM_OPEN  = 0x000003d4U,
    MM_STREAM_CLOSE = 0x000003d5U,
    MM_STREAM_DONE  = 0x000003d6U,
    MM_STREAM_ERROR = 0x000003d7U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/Multimedia/mm-mom-positioncb
enum uint MM_MOM_POSITIONCB = 0x000003caU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Multimedia/mm-mcisignal
enum uint MM_MCISIGNAL = 0x000003cbU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Multimedia/mm-mim-moredata
enum uint MM_MIM_MOREDATA = 0x000003ccU;

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Multimedia/mm-mixm-line-change
    MM_MIXM_LINE_CHANGE    = 0x000003d0U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Multimedia/mm-mixm-control-change
    MM_MIXM_CONTROL_CHANGE = 0x000003d1U,
}

enum uint MMSYSERR_BASE = 0x00000000U;
enum uint WAVERR_BASE = 0x00000020U;
enum uint MIDIERR_BASE = 0x00000040U;
enum uint TIMERR_BASE = 0x00000060U;
enum uint JOYERR_BASE = 0x000000a0U;
enum uint MCIERR_BASE = 0x00000100U;
enum uint MIXERR_BASE = 0x00000400U;
enum uint MCI_STRING_OFFSET = 0x00000200U;
enum uint MCI_VD_OFFSET = 0x00000400U;
enum uint MCI_CD_OFFSET = 0x00000440U;
enum uint MCI_WAVE_OFFSET = 0x00000480U;
enum uint MCI_SEQ_OFFSET = 0x000004c0U;

enum : uint
{
    MMSYSERR_NOERROR      = 0x00000000U,
    MMSYSERR_ERROR        = 0x00000001U,
    MMSYSERR_BADDEVICEID  = 0x00000002U,
    MMSYSERR_NOTENABLED   = 0x00000003U,
    MMSYSERR_ALLOCATED    = 0x00000004U,
    MMSYSERR_INVALHANDLE  = 0x00000005U,
    MMSYSERR_NODRIVER     = 0x00000006U,
    MMSYSERR_NOMEM        = 0x00000007U,
    MMSYSERR_NOTSUPPORTED = 0x00000008U,
    MMSYSERR_BADERRNUM    = 0x00000009U,
    MMSYSERR_INVALFLAG    = 0x0000000aU,
    MMSYSERR_INVALPARAM   = 0x0000000bU,
    MMSYSERR_HANDLEBUSY   = 0x0000000cU,
    MMSYSERR_INVALIDALIAS = 0x0000000dU,
    MMSYSERR_BADDB        = 0x0000000eU,
    MMSYSERR_KEYNOTFOUND  = 0x0000000fU,
    MMSYSERR_READERROR    = 0x00000010U,
    MMSYSERR_WRITEERROR   = 0x00000011U,
    MMSYSERR_DELETEERROR  = 0x00000012U,
    MMSYSERR_VALNOTFOUND  = 0x00000013U,
    MMSYSERR_NODRIVERCB   = 0x00000014U,
    MMSYSERR_MOREDATA     = 0x00000015U,
    MMSYSERR_LASTERROR    = 0x00000015U,
}

enum : uint
{
    TIME_ONESHOT  = 0x00000000U,
    TIME_PERIODIC = 0x00000001U,
}

enum : uint
{
    TIME_CALLBACK_FUNCTION    = 0x00000000U,
    TIME_CALLBACK_EVENT_SET   = 0x00000010U,
    TIME_CALLBACK_EVENT_PULSE = 0x00000020U,
}

enum uint TIME_KILL_SYNCHRONOUS = 0x00000100U;

// Callbacks

alias LPDRVCALLBACK = void function(HDRVR hdrvr, uint uMsg, size_t dwUser, size_t dw1, size_t dw2);
alias LPTIMECALLBACK = void function(uint uTimerID, uint uMsg, size_t dwUser, size_t dw1, size_t dw2);

// Structs


struct MMTIME
{
align (1):
    uint wType;
    union u
    {
    align (1):
        uint ms;
        uint sample;
        uint cb;
        uint ticks;
        struct smpte
        {
            ubyte    hour;
            ubyte    min;
            ubyte    sec;
            ubyte    frame;
            ubyte    fps;
            ubyte    dummy;
            ubyte[2] pad;
        }
        struct midi
        {
        align (1):
            uint songptrpos;
        }
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/timeapi/ns-timeapi-timecaps
struct TIMECAPS
{
    uint wPeriodMin;
    uint wPeriodMax;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ns-strmif-timecode
union TIMECODE
{
    struct
    {
        ushort wFrameRate;
        ushort wFrameFract;
        uint   dwFrames;
    }
    ulong qw;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ns-strmif-timecode_sample
struct TIMECODE_SAMPLE
{
    long     qwTick;
    TIMECODE timecode;
    uint     dwUser;
    TIMECODE_SAMPLE_FLAGS dwFlags;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint timeGetSystemTime(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/MMTIME* pmmt, 
                       uint cbmmt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint timeGetTime();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint timeGetDevCaps(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/TIMECAPS* ptc, 
                    uint cbtc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint timeBeginPeriod(uint uPeriod);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINMM.dll")
uint timeEndPeriod(uint uPeriod);

@DllImport("WINMM.dll")
uint timeSetEvent(uint uDelay, uint uResolution, LPTIMECALLBACK fptc, size_t dwUser, uint fuEvent);

@DllImport("WINMM.dll")
uint timeKillEvent(uint uTimerID);


// Interfaces

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/wmformat/ireferenceclock
@GUID("56a86897-0ad4-11ce-b03a-0020af0ba770")
interface IReferenceClock : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wmformat/ireferenceclock-gettime
    HRESULT GetTime(long* pTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wmformat/ireferenceclock-advisetime
    HRESULT AdviseTime(long baseTime, long streamTime, HANDLE hEvent, size_t* pdwAdviseCookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wmformat/ireferenceclock-adviseperiodic
    HRESULT AdvisePeriodic(long startTime, long periodTime, HANDLE hSemaphore, size_t* pdwAdviseCookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wmformat/ireferenceclock-unadvise
    HRESULT Unadvise(size_t dwAdviseCookie);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-ireferenceclocktimercontrol
@GUID("ebec459c-2eca-4d42-a8af-30df557614b8")
interface IReferenceClockTimerControl : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ireferenceclocktimercontrol-setdefaulttimerresolution
    HRESULT SetDefaultTimerResolution(long timerResolution);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ireferenceclocktimercontrol-getdefaulttimerresolution
    HRESULT GetDefaultTimerResolution(long* pTimerResolution);
}

@GUID("36b73885-c2c8-11cf-8b46-00805f6cef60")
interface IReferenceClock2 : IReferenceClock
{
}


// GUIDs


const GUID IID_IReferenceClock             = GUIDOF!IReferenceClock;
const GUID IID_IReferenceClock2            = GUIDOF!IReferenceClock2;
const GUID IID_IReferenceClockTimerControl = GUIDOF!IReferenceClockTimerControl;
