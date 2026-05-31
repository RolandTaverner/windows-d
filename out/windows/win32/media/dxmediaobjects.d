// Written in the D programming language.

module windows.win32.media.dxmediaobjects;

public import windows.core;
public import system : Guid;
public import windows.win32.foundation : BOOL, HRESULT, PWSTR;
public import windows.win32.system.com : IUnknown;

extern(Windows) @nogc nothrow:


// Enums

//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/ne-mediaobj-_dmo_input_data_buffer_flags))], [])
alias _DMO_INPUT_DATA_BUFFER_FLAGS = int;
enum : int
{
    DMO_INPUT_DATA_BUFFERF_SYNCPOINT     = 0x00000001,
    DMO_INPUT_DATA_BUFFERF_TIME          = 0x00000002,
    DMO_INPUT_DATA_BUFFERF_TIMELENGTH    = 0x00000004,
    DMO_INPUT_DATA_BUFFERF_DISCONTINUITY = 0x00000008,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/ne-mediaobj-_dmo_output_data_buffer_flags))], [])
alias _DMO_OUTPUT_DATA_BUFFER_FLAGS = int;
enum : int
{
    DMO_OUTPUT_DATA_BUFFERF_SYNCPOINT     = 0x00000001,
    DMO_OUTPUT_DATA_BUFFERF_TIME          = 0x00000002,
    DMO_OUTPUT_DATA_BUFFERF_TIMELENGTH    = 0x00000004,
    DMO_OUTPUT_DATA_BUFFERF_DISCONTINUITY = 0x00000008,
    DMO_OUTPUT_DATA_BUFFERF_INCOMPLETE    = 0x01000000,
}
alias _DMO_INPUT_STATUS_FLAGS = int;
enum : int
{
    DMO_INPUT_STATUSF_ACCEPT_DATA = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/ne-mediaobj-_dmo_input_stream_info_flags))], [])
alias _DMO_INPUT_STREAM_INFO_FLAGS = int;
enum : int
{
    DMO_INPUT_STREAMF_WHOLE_SAMPLES            = 0x00000001,
    DMO_INPUT_STREAMF_SINGLE_SAMPLE_PER_BUFFER = 0x00000002,
    DMO_INPUT_STREAMF_FIXED_SAMPLE_SIZE        = 0x00000004,
    DMO_INPUT_STREAMF_HOLDS_BUFFERS            = 0x00000008,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/ne-mediaobj-_dmo_output_stream_info_flags))], [])
alias _DMO_OUTPUT_STREAM_INFO_FLAGS = int;
enum : int
{
    DMO_OUTPUT_STREAMF_WHOLE_SAMPLES            = 0x00000001,
    DMO_OUTPUT_STREAMF_SINGLE_SAMPLE_PER_BUFFER = 0x00000002,
    DMO_OUTPUT_STREAMF_FIXED_SAMPLE_SIZE        = 0x00000004,
    DMO_OUTPUT_STREAMF_DISCARDABLE              = 0x00000008,
    DMO_OUTPUT_STREAMF_OPTIONAL                 = 0x00000010,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/ne-mediaobj-_dmo_set_type_flags))], [])
alias _DMO_SET_TYPE_FLAGS = int;
enum : int
{
    DMO_SET_TYPEF_TEST_ONLY = 0x00000001,
    DMO_SET_TYPEF_CLEAR     = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/ne-mediaobj-_dmo_process_output_flags))], [])
alias _DMO_PROCESS_OUTPUT_FLAGS = int;
enum : int
{
    DMO_PROCESS_OUTPUT_DISCARD_WHEN_NO_BUFFER = 0x00000001,
}
alias _DMO_INPLACE_PROCESS_FLAGS = int;
enum : int
{
    DMO_INPLACE_NORMAL = 0x00000000,
    DMO_INPLACE_ZERO   = 0x00000001,
}
alias _DMO_QUALITY_STATUS_FLAGS = int;
enum : int
{
    DMO_QUALITY_STATUS_ENABLED = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/ne-mediaobj-_dmo_video_output_stream_flags))], [])
alias _DMO_VIDEO_OUTPUT_STREAM_FLAGS = int;
enum : int
{
    DMO_VOSF_NEEDS_PREVIOUS_SAMPLE = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dmoreg/ne-dmoreg-dmo_register_flags))], [])
alias DMO_REGISTER_FLAGS = int;
enum : int
{
    DMO_REGISTERF_IS_KEYED = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dmoreg/ne-dmoreg-dmo_enum_flags))], [])
alias DMO_ENUM_FLAGS = int;
enum : int
{
    DMO_ENUMF_INCLUDE_KEYED = 0x00000001,
}

// Constants


enum : HRESULT
{
    DMO_E_INVALIDSTREAMINDEX = HRESULT(0x80040201),
    DMO_E_INVALIDTYPE        = HRESULT(0x80040202),
}

enum HRESULT DMO_E_TYPE_NOT_SET = HRESULT(0x80040203);
enum HRESULT DMO_E_NOTACCEPTING = HRESULT(0x80040204);
enum HRESULT DMO_E_TYPE_NOT_ACCEPTED = HRESULT(0x80040205);
enum HRESULT DMO_E_NO_MORE_ITEMS = HRESULT(0x80040206);

enum : GUID
{
    DMOCATEGORY_AUDIO_DECODER        = GUID("57f2db8b-e6bb-4513-9d43-dcd2a6593125"),
    DMOCATEGORY_AUDIO_ENCODER        = GUID("33d9a761-90c8-11d0-bd43-00a0c911ce86"),
    DMOCATEGORY_VIDEO_DECODER        = GUID("4a69b442-28be-4991-969c-b500adf5d8a8"),
    DMOCATEGORY_VIDEO_ENCODER        = GUID("33d9a760-90c8-11d0-bd43-00a0c911ce86"),
    DMOCATEGORY_AUDIO_EFFECT         = GUID("f3602b3f-0592-48df-a4cd-674721e7ebeb"),
    DMOCATEGORY_VIDEO_EFFECT         = GUID("d990ee14-776c-4723-be46-3da2f56f10b9"),
    DMOCATEGORY_AUDIO_CAPTURE_EFFECT = GUID("f665aaba-3e09-4920-aa5f-219811148f09"),
    DMOCATEGORY_ACOUSTIC_ECHO_CANCEL = GUID("bf963d80-c559-11d0-8a2b-00a0c9255ac1"),
    DMOCATEGORY_AUDIO_NOISE_SUPPRESS = GUID("e07f903f-62fd-4e60-8cdd-dea7236665b5"),
    DMOCATEGORY_AGC                  = GUID("e88c9ba0-c557-11d0-8a2b-00a0c9255ac1"),
}

// Structs


//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/ns-mediaobj-dmo_media_type))], [])
struct DMO_MEDIA_TYPE
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

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/ns-mediaobj-dmo_output_data_buffer))], [])
struct DMO_OUTPUT_DATA_BUFFER
{
    IMediaBuffer pBuffer;
    uint         dwStatus;
    long         rtTimestamp;
    long         rtTimelength;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dmoreg/ns-dmoreg-dmo_partial_mediatype))], [])
struct DMO_PARTIAL_MEDIATYPE
{
    GUID type;
    GUID subtype;
}

// Functions

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dmoreg/nf-dmoreg-dmoregister))], [])
@DllImport("msdmo.dll")
HRESULT DMORegister(const(PWSTR) szName, const(GUID)* clsidDMO, const(GUID)* guidCategory, uint dwFlags, 
                    uint cInTypes, const(DMO_PARTIAL_MEDIATYPE)* pInTypes, uint cOutTypes, 
                    const(DMO_PARTIAL_MEDIATYPE)* pOutTypes);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dmoreg/nf-dmoreg-dmounregister))], [])
@DllImport("msdmo.dll")
HRESULT DMOUnregister(const(GUID)* clsidDMO, const(GUID)* guidCategory);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dmoreg/nf-dmoreg-dmoenum))], [])
@DllImport("msdmo.dll")
HRESULT DMOEnum(const(GUID)* guidCategory, uint dwFlags, uint cInTypes, const(DMO_PARTIAL_MEDIATYPE)* pInTypes, 
                uint cOutTypes, const(DMO_PARTIAL_MEDIATYPE)* pOutTypes, IEnumDMO* ppEnum);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dmoreg/nf-dmoreg-dmogettypes))], [])
@DllImport("msdmo.dll")
HRESULT DMOGetTypes(const(GUID)* clsidDMO, uint ulInputTypesRequested, uint* pulInputTypesSupplied, 
                    DMO_PARTIAL_MEDIATYPE* pInputTypes, uint ulOutputTypesRequested, uint* pulOutputTypesSupplied, 
                    DMO_PARTIAL_MEDIATYPE* pOutputTypes);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dmoreg/nf-dmoreg-dmogetname))], [])
@DllImport("msdmo.dll")
HRESULT DMOGetName(const(GUID)* clsidDMO, PWSTR szName);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dmort/nf-dmort-moinitmediatype))], [])
@DllImport("msdmo.dll")
HRESULT MoInitMediaType(DMO_MEDIA_TYPE* pmt, uint cbFormat);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dmort/nf-dmort-mofreemediatype))], [])
@DllImport("msdmo.dll")
HRESULT MoFreeMediaType(DMO_MEDIA_TYPE* pmt);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dmort/nf-dmort-mocopymediatype))], [])
@DllImport("msdmo.dll")
HRESULT MoCopyMediaType(DMO_MEDIA_TYPE* pmtDest, const(DMO_MEDIA_TYPE)* pmtSrc);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dmort/nf-dmort-mocreatemediatype))], [])
@DllImport("msdmo.dll")
HRESULT MoCreateMediaType(DMO_MEDIA_TYPE** ppmt, uint cbFormat);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dmort/nf-dmort-modeletemediatype))], [])
@DllImport("msdmo.dll")
HRESULT MoDeleteMediaType(DMO_MEDIA_TYPE* pmt);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dmort/nf-dmort-moduplicatemediatype))], [])
@DllImport("msdmo.dll")
HRESULT MoDuplicateMediaType(DMO_MEDIA_TYPE** ppmtDest, const(DMO_MEDIA_TYPE)* pmtSrc);


// Interfaces

@GUID("59eff8b9-938c-4a26-82f2-95cb84cdc837")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/nn-mediaobj-imediabuffer))], [])
interface IMediaBuffer : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/nf-mediaobj-imediabuffer-setlength))], [])
    HRESULT SetLength(uint cbLength);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/nf-mediaobj-imediabuffer-getmaxlength))], [])
    HRESULT GetMaxLength(uint* pcbMaxLength);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/nf-mediaobj-imediabuffer-getbufferandlength))], [])
    HRESULT GetBufferAndLength(ubyte** ppBuffer, uint* pcbLength);
}

@GUID("d8ad0f58-5494-4102-97c5-ec798e59bcf4")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/nn-mediaobj-imediaobject))], [])
interface IMediaObject : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/nf-mediaobj-imediaobject-getstreamcount))], [])
    HRESULT GetStreamCount(uint* pcInputStreams, uint* pcOutputStreams);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/nf-mediaobj-imediaobject-getinputstreaminfo))], [])
    HRESULT GetInputStreamInfo(uint dwInputStreamIndex, uint* pdwFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/nf-mediaobj-imediaobject-getoutputstreaminfo))], [])
    HRESULT GetOutputStreamInfo(uint dwOutputStreamIndex, uint* pdwFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/nf-mediaobj-imediaobject-getinputtype))], [])
    HRESULT GetInputType(uint dwInputStreamIndex, uint dwTypeIndex, DMO_MEDIA_TYPE* pmt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/nf-mediaobj-imediaobject-getoutputtype))], [])
    HRESULT GetOutputType(uint dwOutputStreamIndex, uint dwTypeIndex, DMO_MEDIA_TYPE* pmt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/nf-mediaobj-imediaobject-setinputtype))], [])
    HRESULT SetInputType(uint dwInputStreamIndex, const(DMO_MEDIA_TYPE)* pmt, uint dwFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/nf-mediaobj-imediaobject-setoutputtype))], [])
    HRESULT SetOutputType(uint dwOutputStreamIndex, const(DMO_MEDIA_TYPE)* pmt, uint dwFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/nf-mediaobj-imediaobject-getinputcurrenttype))], [])
    HRESULT GetInputCurrentType(uint dwInputStreamIndex, DMO_MEDIA_TYPE* pmt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/nf-mediaobj-imediaobject-getoutputcurrenttype))], [])
    HRESULT GetOutputCurrentType(uint dwOutputStreamIndex, DMO_MEDIA_TYPE* pmt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/nf-mediaobj-imediaobject-getinputsizeinfo))], [])
    HRESULT GetInputSizeInfo(uint dwInputStreamIndex, uint* pcbSize, uint* pcbMaxLookahead, uint* pcbAlignment);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/nf-mediaobj-imediaobject-getoutputsizeinfo))], [])
    HRESULT GetOutputSizeInfo(uint dwOutputStreamIndex, uint* pcbSize, uint* pcbAlignment);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/nf-mediaobj-imediaobject-getinputmaxlatency))], [])
    HRESULT GetInputMaxLatency(uint dwInputStreamIndex, long* prtMaxLatency);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/nf-mediaobj-imediaobject-setinputmaxlatency))], [])
    HRESULT SetInputMaxLatency(uint dwInputStreamIndex, long rtMaxLatency);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/nf-mediaobj-imediaobject-flush))], [])
    HRESULT Flush();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/nf-mediaobj-imediaobject-discontinuity))], [])
    HRESULT Discontinuity(uint dwInputStreamIndex);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/nf-mediaobj-imediaobject-allocatestreamingresources))], [])
    HRESULT AllocateStreamingResources();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/nf-mediaobj-imediaobject-freestreamingresources))], [])
    HRESULT FreeStreamingResources();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/nf-mediaobj-imediaobject-getinputstatus))], [])
    HRESULT GetInputStatus(uint dwInputStreamIndex, uint* dwFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/nf-mediaobj-imediaobject-processinput))], [])
    HRESULT ProcessInput(uint dwInputStreamIndex, IMediaBuffer pBuffer, uint dwFlags, long rtTimestamp, 
                         long rtTimelength);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/nf-mediaobj-imediaobject-processoutput))], [])
    HRESULT ProcessOutput(uint dwFlags, uint cOutputBufferCount, DMO_OUTPUT_DATA_BUFFER* pOutputBuffers, 
                          uint* pdwStatus);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/nf-mediaobj-imediaobject-lock))], [])
    HRESULT Lock(int bLock);
}

@GUID("2c3cd98a-2bfa-4a53-9c27-5249ba64ba0f")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/nn-mediaobj-ienumdmo))], [])
interface IEnumDMO : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/nf-mediaobj-ienumdmo-next))], [])
    HRESULT Next(uint cItemsToFetch, GUID* pCLSID, PWSTR* Names, uint* pcItemsFetched);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/nf-mediaobj-ienumdmo-skip))], [])
    HRESULT Skip(uint cItemsToSkip);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/nf-mediaobj-ienumdmo-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/nf-mediaobj-ienumdmo-clone))], [])
    HRESULT Clone(IEnumDMO* ppEnum);
}

@GUID("651b9ad0-0fc7-4aa9-9538-d89931010741")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/nn-mediaobj-imediaobjectinplace))], [])
interface IMediaObjectInPlace : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/nf-mediaobj-imediaobjectinplace-process))], [])
    HRESULT Process(uint ulSize, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/ubyte* pData, 
                    long refTimeStart, uint dwFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/nf-mediaobj-imediaobjectinplace-clone))], [])
    HRESULT Clone(IMediaObjectInPlace* ppMediaObject);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/nf-mediaobj-imediaobjectinplace-getlatency))], [])
    HRESULT GetLatency(long* pLatencyTime);
}

@GUID("65abea96-cf36-453f-af8a-705e98f16260")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/nn-mediaobj-idmoqualitycontrol))], [])
interface IDMOQualityControl : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/nf-mediaobj-idmoqualitycontrol-setnow))], [])
    HRESULT SetNow(long rtNow);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/nf-mediaobj-idmoqualitycontrol-setstatus))], [])
    HRESULT SetStatus(uint dwFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/nf-mediaobj-idmoqualitycontrol-getstatus))], [])
    HRESULT GetStatus(uint* pdwFlags);
}

@GUID("be8f4f4e-5b16-4d29-b350-7f6b5d9298ac")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/nn-mediaobj-idmovideooutputoptimizations))], [])
interface IDMOVideoOutputOptimizations : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/nf-mediaobj-idmovideooutputoptimizations-queryoperationmodepreferences))], [])
    HRESULT QueryOperationModePreferences(uint ulOutputStreamIndex, uint* pdwRequestedCapabilities);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/nf-mediaobj-idmovideooutputoptimizations-setoperationmode))], [])
    HRESULT SetOperationMode(uint ulOutputStreamIndex, uint dwEnabledFeatures);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/nf-mediaobj-idmovideooutputoptimizations-getcurrentoperationmode))], [])
    HRESULT GetCurrentOperationMode(uint ulOutputStreamIndex, uint* pdwEnabledFeatures);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mediaobj/nf-mediaobj-idmovideooutputoptimizations-getcurrentsamplerequirements))], [])
    HRESULT GetCurrentSampleRequirements(uint ulOutputStreamIndex, uint* pdwRequestedFeatures);
}


// GUIDs


const GUID IID_IDMOQualityControl           = GUIDOF!IDMOQualityControl;
const GUID IID_IDMOVideoOutputOptimizations = GUIDOF!IDMOVideoOutputOptimizations;
const GUID IID_IEnumDMO                     = GUIDOF!IEnumDMO;
const GUID IID_IMediaBuffer                 = GUIDOF!IMediaBuffer;
const GUID IID_IMediaObject                 = GUIDOF!IMediaObject;
const GUID IID_IMediaObjectInPlace          = GUIDOF!IMediaObjectInPlace;
