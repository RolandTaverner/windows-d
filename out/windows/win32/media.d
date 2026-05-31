// Written in the D programming language.

module windows.win32.media;

public import windows.core;
public import windows.win32.foundation : HANDLE, HRESULT;
public import windows.win32.system.com : IUnknown;

extern(Windows) @nogc nothrow:


// Enums

alias TIMECODE_SAMPLE_FLAGS = uint;
enum : uint
{
    ED_DEVCAP_TIMECODE_READ = 0x00001019,
    ED_DEVCAP_ATN_READ      = 0x000013b7,
    ED_DEVCAP_RTC_READ      = 0x000013ba,
}

// Constants


enum : uint
{
    TIMERR_NOERROR = 0x00000000,
    TIMERR_NOCANDO = 0x00000061,
    TIMERR_STRUCT  = 0x00000081,
}

enum uint MAXPNAMELEN = 0x00000020;
enum uint MAXERRORLENGTH = 0x00000100;

enum : uint
{
    MM_MICROSOFT   = 0x00000001,
    MM_MIDI_MAPPER = 0x00000001,
}

enum uint MM_WAVE_MAPPER = 0x00000002;

enum : uint
{
    MM_SNDBLST_MIDIOUT = 0x00000003,
    MM_SNDBLST_MIDIIN  = 0x00000004,
    MM_SNDBLST_SYNTH   = 0x00000005,
    MM_SNDBLST_WAVEOUT = 0x00000006,
    MM_SNDBLST_WAVEIN  = 0x00000007,
}

enum uint MM_ADLIB = 0x00000009;

enum : uint
{
    MM_MPU401_MIDIOUT = 0x0000000a,
    MM_MPU401_MIDIIN  = 0x0000000b,
}

enum uint MM_PC_JOYSTICK = 0x0000000c;

enum : uint
{
    TIME_MS      = 0x00000001,
    TIME_SAMPLES = 0x00000002,
    TIME_BYTES   = 0x00000004,
    TIME_SMPTE   = 0x00000008,
    TIME_MIDI    = 0x00000010,
    TIME_TICKS   = 0x00000020,
}

enum : /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Multimedia/mm-joy1move))], [])*/uint
{
    MM_JOY1MOVE       = 0x000003a0,
    MM_JOY2MOVE       = 0x000003a1,
    MM_JOY1ZMOVE      = 0x000003a2,
    MM_JOY2ZMOVE      = 0x000003a3,
    MM_JOY1BUTTONDOWN = 0x000003b5,
}

enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Multimedia/mm-joy2buttondown))], [])*/uint MM_JOY2BUTTONDOWN = 0x000003b6;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Multimedia/mm-joy1buttonup))], [])*/uint MM_JOY1BUTTONUP = 0x000003b7;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Multimedia/mm-joy2buttonup))], [])*/uint MM_JOY2BUTTONUP = 0x000003b8;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Multimedia/mm-mcinotify))], [])*/uint MM_MCINOTIFY = 0x000003b9;

enum : /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Multimedia/mm-wom-open))], [])*/uint
{
    MM_WOM_OPEN  = 0x000003bb,
    MM_WOM_CLOSE = 0x000003bc,
    MM_WOM_DONE  = 0x000003bd,
}

enum : /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Multimedia/mm-wim-open))], [])*/uint
{
    MM_WIM_OPEN  = 0x000003be,
    MM_WIM_CLOSE = 0x000003bf,
    MM_WIM_DATA  = 0x000003c0,
}

enum : /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Multimedia/mm-mim-open))], [])*/uint
{
    MM_MIM_OPEN      = 0x000003c1,
    MM_MIM_CLOSE     = 0x000003c2,
    MM_MIM_DATA      = 0x000003c3,
    MM_MIM_LONGDATA  = 0x000003c4,
    MM_MIM_ERROR     = 0x000003c5,
    MM_MIM_LONGERROR = 0x000003c6,
}

enum : /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Multimedia/mm-mom-open))], [])*/uint
{
    MM_MOM_OPEN  = 0x000003c7,
    MM_MOM_CLOSE = 0x000003c8,
    MM_MOM_DONE  = 0x000003c9,
}

enum : uint
{
    MM_DRVM_OPEN  = 0x000003d0,
    MM_DRVM_CLOSE = 0x000003d1,
    MM_DRVM_DATA  = 0x000003d2,
    MM_DRVM_ERROR = 0x000003d3,
}

enum : uint
{
    MM_STREAM_OPEN  = 0x000003d4,
    MM_STREAM_CLOSE = 0x000003d5,
    MM_STREAM_DONE  = 0x000003d6,
    MM_STREAM_ERROR = 0x000003d7,
}

enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Multimedia/mm-mom-positioncb))], [])*/uint MM_MOM_POSITIONCB = 0x000003ca;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Multimedia/mm-mcisignal))], [])*/uint MM_MCISIGNAL = 0x000003cb;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Multimedia/mm-mim-moredata))], [])*/uint MM_MIM_MOREDATA = 0x000003cc;

enum : /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Multimedia/mm-mixm-line-change))], [])*/uint
{
    MM_MIXM_LINE_CHANGE    = 0x000003d0,
    MM_MIXM_CONTROL_CHANGE = 0x000003d1,
}

enum uint MMSYSERR_BASE = 0x00000000;
enum uint WAVERR_BASE = 0x00000020;
enum uint MIDIERR_BASE = 0x00000040;
enum uint TIMERR_BASE = 0x00000060;
enum uint JOYERR_BASE = 0x000000a0;
enum uint MCIERR_BASE = 0x00000100;
enum uint MIXERR_BASE = 0x00000400;
enum uint MCI_STRING_OFFSET = 0x00000200;
enum uint MCI_VD_OFFSET = 0x00000400;
enum uint MCI_CD_OFFSET = 0x00000440;
enum uint MCI_WAVE_OFFSET = 0x00000480;
enum uint MCI_SEQ_OFFSET = 0x000004c0;

enum : uint
{
    MMSYSERR_NOERROR      = 0x00000000,
    MMSYSERR_ERROR        = 0x00000001,
    MMSYSERR_BADDEVICEID  = 0x00000002,
    MMSYSERR_NOTENABLED   = 0x00000003,
    MMSYSERR_ALLOCATED    = 0x00000004,
    MMSYSERR_INVALHANDLE  = 0x00000005,
    MMSYSERR_NODRIVER     = 0x00000006,
    MMSYSERR_NOMEM        = 0x00000007,
    MMSYSERR_NOTSUPPORTED = 0x00000008,
    MMSYSERR_BADERRNUM    = 0x00000009,
    MMSYSERR_INVALFLAG    = 0x0000000a,
    MMSYSERR_INVALPARAM   = 0x0000000b,
    MMSYSERR_HANDLEBUSY   = 0x0000000c,
    MMSYSERR_INVALIDALIAS = 0x0000000d,
    MMSYSERR_BADDB        = 0x0000000e,
    MMSYSERR_KEYNOTFOUND  = 0x0000000f,
    MMSYSERR_READERROR    = 0x00000010,
    MMSYSERR_WRITEERROR   = 0x00000011,
    MMSYSERR_DELETEERROR  = 0x00000012,
    MMSYSERR_VALNOTFOUND  = 0x00000013,
    MMSYSERR_NODRIVERCB   = 0x00000014,
    MMSYSERR_MOREDATA     = 0x00000015,
    MMSYSERR_LASTERROR    = 0x00000015,
}

enum : uint
{
    TIME_ONESHOT  = 0x00000000,
    TIME_PERIODIC = 0x00000001,
}

enum : uint
{
    TIME_CALLBACK_FUNCTION    = 0x00000000,
    TIME_CALLBACK_EVENT_SET   = 0x00000010,
    TIME_CALLBACK_EVENT_PULSE = 0x00000020,
}

enum uint TIME_KILL_SYNCHRONOUS = 0x00000100;

// Callbacks

alias LPDRVCALLBACK = void function(HDRVR hdrvr, uint uMsg, size_t dwUser, size_t dw1, size_t dw2);
alias LPTIMECALLBACK = void function(uint uTimerID, uint uMsg, size_t dwUser, size_t dw1, size_t dw2);

// Structs


struct MMTIME
{
align (1):
    uint        wType;
    _u_e__Union u;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/timeapi/ns-timeapi-timecaps))], [])
struct TIMECAPS
{
    uint wPeriodMin;
    uint wPeriodMax;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/strmif/ns-strmif-timecode))], [])
union TIMECODE
{
    _Anonymous_e__Struct Anonymous;
    ulong                qw;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/strmif/ns-strmif-timecode_sample))], [])
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

@GUID("56a86897-0ad4-11ce-b03a-0020af0ba770")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wmformat/ireferenceclock))], [])
interface IReferenceClock : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wmformat/ireferenceclock-gettime))], [])
    HRESULT GetTime(long* pTime);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wmformat/ireferenceclock-advisetime))], [])
    HRESULT AdviseTime(long baseTime, long streamTime, HANDLE hEvent, size_t* pdwAdviseCookie);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wmformat/ireferenceclock-adviseperiodic))], [])
    HRESULT AdvisePeriodic(long startTime, long periodTime, HANDLE hSemaphore, size_t* pdwAdviseCookie);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/wmformat/ireferenceclock-unadvise))], [])
    HRESULT Unadvise(size_t dwAdviseCookie);
}

@GUID("ebec459c-2eca-4d42-a8af-30df557614b8")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-ireferenceclocktimercontrol))], [])
interface IReferenceClockTimerControl : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ireferenceclocktimercontrol-setdefaulttimerresolution))], [])
    HRESULT SetDefaultTimerResolution(long timerResolution);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ireferenceclocktimercontrol-getdefaulttimerresolution))], [])
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
