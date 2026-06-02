// Written in the D programming language.

module windows.win32.media.streaming;

public import windows.core;
public import windows.win32.foundation : DEVPROPKEY, RECT;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mfidl/ne-mfidl-mf_transfer_video_frame_flags
alias MF_TRANSFER_VIDEO_FRAME_FLAGS = int;
enum : int
{
    MF_TRANSFER_VIDEO_FRAME_DEFAULT    = 0x00000000,
    MF_TRANSFER_VIDEO_FRAME_STRETCH    = 0x00000001,
    MF_TRANSFER_VIDEO_FRAME_IGNORE_PAR = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mfidl/ne-mfidl-mf_mediasource_status_info
alias MF_MEDIASOURCE_STATUS_INFO = int;
enum : int
{
    MF_MEDIASOURCE_STATUS_INFO_FULLYSUPPORTED = 0x00000000,
    MF_MEDIASOURCE_STATUS_INFO_UNKNOWN        = 0x00000001,
}

// Constants


enum : DEVPROPKEY
{
    DEVPKEY_Device_PacketWakeSupported     = DEVPROPKEY(GUID("88AD39DB-0D0C-4A38-8435-4043826B5C91"), 0),
    DEVPKEY_Device_SendPacketWakeSupported = DEVPROPKEY(GUID("88AD39DB-0D0C-4A38-8435-4043826B5C91"), 1),
}

enum : DEVPROPKEY
{
    DEVPKEY_Device_UDN                = DEVPROPKEY(GUID("88AD39DB-0D0C-4A38-8435-4043826B5C91"), 6),
    DEVPKEY_Device_SupportsAudio      = DEVPROPKEY(GUID("88AD39DB-0D0C-4A38-8435-4043826B5C91"), 8),
    DEVPKEY_Device_SupportsVideo      = DEVPROPKEY(GUID("88AD39DB-0D0C-4A38-8435-4043826B5C91"), 9),
    DEVPKEY_Device_SupportsImages     = DEVPROPKEY(GUID("88AD39DB-0D0C-4A38-8435-4043826B5C91"), 10),
    DEVPKEY_Device_SinkProtocolInfo   = DEVPROPKEY(GUID("88AD39DB-0D0C-4A38-8435-4043826B5C91"), 14),
    DEVPKEY_Device_DLNADOC            = DEVPROPKEY(GUID("88AD39DB-0D0C-4A38-8435-4043826B5C91"), 15),
    DEVPKEY_Device_DLNACAP            = DEVPROPKEY(GUID("88AD39DB-0D0C-4A38-8435-4043826B5C91"), 16),
    DEVPKEY_Device_SupportsSearch     = DEVPROPKEY(GUID("88AD39DB-0D0C-4A38-8435-4043826B5C91"), 17),
    DEVPKEY_Device_SupportsMute       = DEVPROPKEY(GUID("88AD39DB-0D0C-4A38-8435-4043826B5C91"), 18),
    DEVPKEY_Device_MaxVolume          = DEVPROPKEY(GUID("88AD39DB-0D0C-4A38-8435-4043826B5C91"), 19),
    DEVPKEY_Device_SupportsSetNextAVT = DEVPROPKEY(GUID("88AD39DB-0D0C-4A38-8435-4043826B5C91"), 20),
}

enum : GUID
{
    GUID_DEVINTERFACE_DMR = GUID("d0875fb4-2196-4c7a-a63d-e416addd60a1"),
    GUID_DEVINTERFACE_DMP = GUID("25b4e268-2a05-496e-803b-266837fbda4b"),
    GUID_DEVINTERFACE_DMS = GUID("c96037ae-a558-4470-b432-115a31b85553"),
}

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mfapi/ns-mfapi-facerectinfoblobheader
struct FaceRectInfoBlobHeader
{
    uint Size;
    uint Count;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mfapi/ns-mfapi-facerectinfo
struct FaceRectInfo
{
    RECT Region;
    int  confidenceLevel;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mfapi/ns-mfapi-facecharacterizationblobheader
struct FaceCharacterizationBlobHeader
{
    uint Size;
    uint Count;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mfapi/ns-mfapi-facecharacterization
struct FaceCharacterization
{
    uint BlinkScoreLeft;
    uint BlinkScoreRight;
    uint FacialExpression;
    uint FacialExpressionScore;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mfapi/ns-mfapi-capturedmetadataexposurecompensation
struct CapturedMetadataExposureCompensation
{
    ulong Flags;
    int   Value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mfapi/ns-mfapi-capturedmetadataisogains
struct CapturedMetadataISOGains
{
    float AnalogGain;
    float DigitalGain;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mfapi/ns-mfapi-capturedmetadatawhitebalancegains
struct CapturedMetadataWhiteBalanceGains
{
    float R;
    float G;
    float B;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mfapi/ns-mfapi-metadatatimestamps
struct MetadataTimeStamps
{
    uint Flags;
    long Device;
    long Presentation;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mfapi/ns-mfapi-histogramgrid
struct HistogramGrid
{
    uint Width;
    uint Height;
    RECT Region;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mfapi/ns-mfapi-histogramblobheader
struct HistogramBlobHeader
{
    uint Size;
    uint Histograms;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mfapi/ns-mfapi-histogramheader
struct HistogramHeader
{
    uint          Size;
    uint          Bins;
    uint          FourCC;
    uint          ChannelMasks;
    HistogramGrid Grid;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mfapi/ns-mfapi-histogramdataheader
struct HistogramDataHeader
{
    uint Size;
    uint ChannelMask;
    uint Linear;
}

