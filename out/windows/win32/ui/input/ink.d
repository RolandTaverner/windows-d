// Written in the D programming language.

module windows.win32.ui.input.ink;

public import windows.core;
public import system.system : Guid;
public import windows.win32.foundation.foundation : BOOL, HRESULT;
public import windows.win32.system.com.com : IUnknown;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/inkrenderer/ne-inkrenderer-ink_high_contrast_adjustment
alias INK_HIGH_CONTRAST_ADJUSTMENT = int;
enum : int
{
    USE_SYSTEM_COLORS_WHEN_NECESSARY = 0x00000000,
    USE_SYSTEM_COLORS                = 0x00000001,
    USE_ORIGINAL_COLORS              = 0x00000002,
}

// Interfaces

@GUID("062584a6-f830-4bdc-a4d2-0a10ab062b1d")
struct InkDesktopHost;

@GUID("4044e60c-7b01-4671-a97c-04e0210a07a5")
struct InkD2DRenderer;

@GUID("fabea3fc-b108-45b6-a9fc-8d08fa9f85cf")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/inkpresenterdesktop/nn-inkpresenterdesktop-iinkcommitrequesthandler
interface IInkCommitRequestHandler : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/inkpresenterdesktop/nf-inkpresenterdesktop-iinkcommitrequesthandler-oncommitrequested
    HRESULT OnCommitRequested();
}

@GUID("73f3c0d9-2e8b-48f3-895e-20cbd27b723b")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/inkpresenterdesktop/nn-inkpresenterdesktop-iinkpresenterdesktop
interface IInkPresenterDesktop : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/inkpresenterdesktop/nf-inkpresenterdesktop-iinkpresenterdesktop-setrootvisual
    HRESULT SetRootVisual(IUnknown rootVisual, IUnknown device);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/inkpresenterdesktop/nf-inkpresenterdesktop-iinkpresenterdesktop-setcommitrequesthandler
    HRESULT SetCommitRequestHandler(IInkCommitRequestHandler handler);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/inkpresenterdesktop/nf-inkpresenterdesktop-iinkpresenterdesktop-getsize
    HRESULT GetSize(float* width, float* height);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/inkpresenterdesktop/nf-inkpresenterdesktop-iinkpresenterdesktop-setsize
    HRESULT SetSize(float width, float height);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/inkpresenterdesktop/nf-inkpresenterdesktop-iinkpresenterdesktop-onhighcontrastchanged
    HRESULT OnHighContrastChanged();
}

@GUID("ccda0a9a-1b78-4632-bb96-97800662e26c")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/inkpresenterdesktop/nn-inkpresenterdesktop-iinkhostworkitem
interface IInkHostWorkItem : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/inkpresenterdesktop/nf-inkpresenterdesktop-iinkhostworkitem-invoke
    HRESULT Invoke();
}

@GUID("4ce7d875-a981-4140-a1ff-ad93258e8d59")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/inkpresenterdesktop/nn-inkpresenterdesktop-iinkdesktophost
interface IInkDesktopHost : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/inkpresenterdesktop/nf-inkpresenterdesktop-iinkdesktophost-queueworkitem
    HRESULT QueueWorkItem(IInkHostWorkItem workItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/inkpresenterdesktop/nf-inkpresenterdesktop-iinkdesktophost-createinkpresenter
    HRESULT CreateInkPresenter(const(GUID)* riid, void** ppv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/inkpresenterdesktop/nf-inkpresenterdesktop-iinkdesktophost-createandinitializeinkpresenter
    HRESULT CreateAndInitializeInkPresenter(IUnknown rootVisual, float width, float height, const(GUID)* riid, 
                                            void** ppv);
}

@GUID("407fb1de-f85a-4150-97cf-b7fb274fb4f8")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/inkrenderer/nn-inkrenderer-iinkd2drenderer
interface IInkD2DRenderer : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/inkrenderer/nf-inkrenderer-iinkd2drenderer-draw
    HRESULT Draw(IUnknown pD2D1DeviceContext, IUnknown pInkStrokeIterable, BOOL fHighContrast);
}

@GUID("0a95dcd9-4578-4b71-b20b-bf664d4bfeee")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/inkrenderer/nn-inkrenderer-iinkd2drenderer2
interface IInkD2DRenderer2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/inkrenderer/nf-inkrenderer-iinkd2drenderer2-draw
    HRESULT Draw(IUnknown pD2D1DeviceContext, IUnknown pInkStrokeIterable, 
                 INK_HIGH_CONTRAST_ADJUSTMENT highContrastAdjustment);
}


// GUIDs

const GUID CLSID_InkD2DRenderer = GUIDOF!InkD2DRenderer;
const GUID CLSID_InkDesktopHost = GUIDOF!InkDesktopHost;

const GUID IID_IInkCommitRequestHandler = GUIDOF!IInkCommitRequestHandler;
const GUID IID_IInkD2DRenderer          = GUIDOF!IInkD2DRenderer;
const GUID IID_IInkD2DRenderer2         = GUIDOF!IInkD2DRenderer2;
const GUID IID_IInkDesktopHost          = GUIDOF!IInkDesktopHost;
const GUID IID_IInkHostWorkItem         = GUIDOF!IInkHostWorkItem;
const GUID IID_IInkPresenterDesktop     = GUIDOF!IInkPresenterDesktop;
