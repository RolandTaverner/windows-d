// Written in the D programming language.

module windows.win32.graphics.compositionswapchain;

public import windows.core;
public import system.system : Guid;
public import windows.win32.foundation.foundation : HANDLE, HRESULT, LUID, RECT;
public import windows.win32.graphics.dxgi.common : DXGI_ALPHA_MODE, DXGI_COLOR_SPACE_TYPE;
public import windows.win32.system.com.com : IUnknown;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentationtypes/ne-presentationtypes-presentstatisticskind
enum PresentStatisticsKind : int
{
    PresentStatisticsKind_PresentStatus        = 0x00000001,
    PresentStatisticsKind_CompositionFrame     = 0x00000002,
    PresentStatisticsKind_IndependentFlipFrame = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentation/ne-presentation-presentstatus
enum PresentStatus : int
{
    PresentStatus_Queued   = 0x00000000,
    PresentStatus_Skipped  = 0x00000001,
    PresentStatus_Canceled = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentation/ne-presentation-compositionframeinstancekind
enum CompositionFrameInstanceKind : int
{
    CompositionFrameInstanceKind_ComposedOnScreen       = 0x00000000,
    CompositionFrameInstanceKind_ScanoutOnScreen        = 0x00000001,
    CompositionFrameInstanceKind_ComposedToIntermediate = 0x00000002,
}

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentationtypes/ns-presentationtypes-systeminterrupttime
struct SystemInterruptTime
{
    ulong value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentationtypes/ns-presentationtypes-presentationtransform
struct PresentationTransform
{
    float M11;
    float M12;
    float M21;
    float M22;
    float M31;
    float M32;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentation/ns-presentation-compositionframedisplayinstance
struct CompositionFrameDisplayInstance
{
    LUID  displayAdapterLUID;
    uint  displayVidPnSourceId;
    uint  displayUniqueId;
    LUID  renderAdapterLUID;
    CompositionFrameInstanceKind instanceKind;
    PresentationTransform finalTransform;
    ubyte requiredCrossAdapterCopy;
    DXGI_COLOR_SPACE_TYPE colorSpace;
}

// Functions

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentation/nf-presentation-createpresentationfactory
@DllImport("dcomp.dll")
HRESULT CreatePresentationFactory(IUnknown d3dDevice, const(GUID)* riid, void** presentationFactory);


// Interfaces

@GUID("2e217d3a-5abb-4138-9a13-a775593c89ca")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentation/nn-presentation-ipresentationbuffer
interface IPresentationBuffer : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentation/nf-presentation-ipresentationbuffer-getavailableevent
    HRESULT GetAvailableEvent(HANDLE* availableEventHandle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentation/nf-presentation-ipresentationbuffer-isavailable
    HRESULT IsAvailable(ubyte* isAvailable);
}

@GUID("5668bb79-3d8e-415c-b215-f38020f2d252")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentation/nn-presentation-ipresentationcontent
interface IPresentationContent : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentation/nf-presentation-ipresentationcontent-settag
    void SetTag(size_t tag);
}

@GUID("956710fb-ea40-4eba-a3eb-4375a0eb4edc")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentation/nn-presentation-ipresentationsurface
interface IPresentationSurface : IPresentationContent
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentation/nf-presentation-ipresentationsurface-setbuffer
    HRESULT SetBuffer(IPresentationBuffer presentationBuffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentation/nf-presentation-ipresentationsurface-setcolorspace
    HRESULT SetColorSpace(DXGI_COLOR_SPACE_TYPE colorSpace);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentation/nf-presentation-ipresentationsurface-setalphamode
    HRESULT SetAlphaMode(DXGI_ALPHA_MODE alphaMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentation/nf-presentation-ipresentationsurface-setsourcerect
    HRESULT SetSourceRect(const(RECT)* sourceRect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentation/nf-presentation-ipresentationsurface-settransform
    HRESULT SetTransform(PresentationTransform* transform);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentation/nf-presentation-ipresentationsurface-restricttooutput
    HRESULT RestrictToOutput(IUnknown output);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentation/nf-presentation-ipresentationsurface-setdisablereadback
    HRESULT SetDisableReadback(ubyte value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentation/nf-presentation-ipresentationsurface-setletterboxingmargins
    HRESULT SetLetterboxingMargins(float leftLetterboxSize, float topLetterboxSize, float rightLetterboxSize, 
                                   float bottomLetterboxSize);
}

@GUID("95609569-c5f0-47f9-8804-5345f2e2767e")
interface IPresentationSurface2 : IPresentationSurface
{
    void SetIsHdrContent(ubyte isHdrContent);
}

@GUID("b44b8bda-7282-495d-9dd7-ceadd8b4bb86")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentation/nn-presentation-ipresentstatistics
interface IPresentStatistics : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentation/nf-presentation-ipresentstatistics-getpresentid
    ulong GetPresentId();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentation/nf-presentation-ipresentstatistics-getkind
    PresentStatisticsKind GetKind();
}

@GUID("fb562f82-6292-470a-88b1-843661e7f20c")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentation/nn-presentation-ipresentationmanager
interface IPresentationManager : IUnknown
{
    HRESULT AddBufferFromResource(IUnknown resource, IPresentationBuffer* presentationBuffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentation/nf-presentation-ipresentationmanager-createpresentationsurface
    HRESULT CreatePresentationSurface(HANDLE compositionSurfaceHandle, IPresentationSurface* presentationSurface);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentation/nf-presentation-ipresentationmanager-getnextpresentid
    ulong   GetNextPresentId();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentation/nf-presentation-ipresentationmanager-settargettime
    HRESULT SetTargetTime(SystemInterruptTime targetTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentation/nf-presentation-ipresentationmanager-setpreferredpresentduration
    HRESULT SetPreferredPresentDuration(SystemInterruptTime preferredDuration, 
                                        SystemInterruptTime deviationTolerance);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentation/nf-presentation-ipresentationmanager-forcevsyncinterrupt
    HRESULT ForceVSyncInterrupt(ubyte forceVsyncInterrupt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentation/nf-presentation-ipresentationmanager-present
    HRESULT Present();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentation/nf-presentation-ipresentationmanager-getpresentretiringfence
    HRESULT GetPresentRetiringFence(const(GUID)* riid, void** fence);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentation/nf-presentation-ipresentationmanager-cancelpresentsfrom
    HRESULT CancelPresentsFrom(ulong presentIdToCancelFrom);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentation/nf-presentation-ipresentationmanager-getlostevent
    HRESULT GetLostEvent(HANDLE* lostEventHandle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentation/nf-presentation-ipresentationmanager-getpresentstatisticsavailableevent
    HRESULT GetPresentStatisticsAvailableEvent(HANDLE* presentStatisticsAvailableEventHandle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentation/nf-presentation-ipresentationmanager-enablepresentstatisticskind
    HRESULT EnablePresentStatisticsKind(PresentStatisticsKind presentStatisticsKind, ubyte enabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentation/nf-presentation-ipresentationmanager-getnextpresentstatistics
    HRESULT GetNextPresentStatistics(IPresentStatistics* nextPresentStatistics);
}

@GUID("8fb37b58-1d74-4f64-a49c-1f97a80a2ec0")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentation/nn-presentation-ipresentationfactory
interface IPresentationFactory : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentation/nf-presentation-ipresentationfactory-ispresentationsupported
    ubyte   IsPresentationSupported();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentation/nf-presentation-ipresentationfactory-ispresentationsupportedwithindependentflip
    ubyte   IsPresentationSupportedWithIndependentFlip();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentation/nf-presentation-ipresentationfactory-createpresentationmanager
    HRESULT CreatePresentationManager(IPresentationManager* ppPresentationManager);
}

@GUID("2bd0b885-a16f-4bd9-a59a-d073e069d416")
interface IPresentationFactory_SupportHdrAware : IUnknown
{
}

@GUID("c9ed2a41-79cb-435e-964e-c8553055420c")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentation/nn-presentation-ipresentstatuspresentstatistics
interface IPresentStatusPresentStatistics : IPresentStatistics
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentation/nf-presentation-ipresentstatuspresentstatistics-getcompositionframeid
    ulong GetCompositionFrameId();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentation/nf-presentation-ipresentstatuspresentstatistics-getpresentstatus
    PresentStatus GetPresentStatus();
}

@GUID("ab41d127-c101-4c0a-911d-f9f2e9d08e64")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentation/nn-presentation-icompositionframepresentstatistics
interface ICompositionFramePresentStatistics : IPresentStatistics
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentation/nf-presentation-icompositionframepresentstatistics-getcontenttag
    size_t GetContentTag();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentation/nf-presentation-icompositionframepresentstatistics-getcompositionframeid
    ulong  GetCompositionFrameId();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentation/nf-presentation-icompositionframepresentstatistics-getdisplayinstancearray
    void   GetDisplayInstanceArray(uint* displayInstanceArrayCount, 
                                   const(CompositionFrameDisplayInstance)** displayInstanceArray);
}

@GUID("8c93be27-ad94-4da0-8fd4-2413132d124e")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentation/nn-presentation-iindependentflipframepresentstatistics
interface IIndependentFlipFramePresentStatistics : IPresentStatistics
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentation/nf-presentation-iindependentflipframepresentstatistics-getoutputadapterluid
    LUID   GetOutputAdapterLUID();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentation/nf-presentation-iindependentflipframepresentstatistics-getoutputvidpnsourceid
    uint   GetOutputVidPnSourceId();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentation/nf-presentation-iindependentflipframepresentstatistics-getcontenttag
    size_t GetContentTag();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentation/nf-presentation-iindependentflipframepresentstatistics-getdisplayedtime
    SystemInterruptTime GetDisplayedTime();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/presentation/nf-presentation-iindependentflipframepresentstatistics-getpresentduration
    SystemInterruptTime GetPresentDuration();
}


// GUIDs


const GUID IID_ICompositionFramePresentStatistics     = GUIDOF!ICompositionFramePresentStatistics;
const GUID IID_IIndependentFlipFramePresentStatistics = GUIDOF!IIndependentFlipFramePresentStatistics;
const GUID IID_IPresentStatistics                     = GUIDOF!IPresentStatistics;
const GUID IID_IPresentStatusPresentStatistics        = GUIDOF!IPresentStatusPresentStatistics;
const GUID IID_IPresentationBuffer                    = GUIDOF!IPresentationBuffer;
const GUID IID_IPresentationContent                   = GUIDOF!IPresentationContent;
const GUID IID_IPresentationFactory                   = GUIDOF!IPresentationFactory;
const GUID IID_IPresentationFactory_SupportHdrAware   = GUIDOF!IPresentationFactory_SupportHdrAware;
const GUID IID_IPresentationManager                   = GUIDOF!IPresentationManager;
const GUID IID_IPresentationSurface                   = GUIDOF!IPresentationSurface;
const GUID IID_IPresentationSurface2                  = GUIDOF!IPresentationSurface2;
