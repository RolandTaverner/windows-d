// Written in the D programming language.

module windows.win32.ui.input.radial;

public import windows.core;
public import windows.win32.foundation.foundation : HRESULT, HWND;
public import windows.win32.system.winrt.winrt : IInspectable;

extern(Windows) @nogc nothrow:


// Interfaces

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.14393))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/radialcontrollerinterop/nn-radialcontrollerinterop-iradialcontrollerinterop
@GUID("1b0535c9-57ad-45c1-9d79-ad5c34360513")
interface IRadialControllerInterop : IInspectable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/radialcontrollerinterop/nf-radialcontrollerinterop-iradialcontrollerinterop-createforwindow
    HRESULT CreateForWindow(HWND hwnd, const(GUID)* riid, void** ppv);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.14393))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/radialcontrollerinterop/nn-radialcontrollerinterop-iradialcontrollerconfigurationinterop
@GUID("787cdaac-3186-476d-87e4-b9374a7b9970")
interface IRadialControllerConfigurationInterop : IInspectable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/radialcontrollerinterop/nf-radialcontrollerinterop-iradialcontrollerconfigurationinterop-getforwindow
    HRESULT GetForWindow(HWND hwnd, const(GUID)* riid, void** ppv);
}

@GUID("3d577eff-4cee-11e6-b535-001bdc06ab3b")
interface IRadialControllerIndependentInputSourceInterop : IInspectable
{
    HRESULT CreateForWindow(HWND hwnd, const(GUID)* riid, void** ppv);
}


// GUIDs


const GUID IID_IRadialControllerConfigurationInterop          = GUIDOF!IRadialControllerConfigurationInterop;
const GUID IID_IRadialControllerIndependentInputSourceInterop = GUIDOF!IRadialControllerIndependentInputSourceInterop;
const GUID IID_IRadialControllerInterop                       = GUIDOF!IRadialControllerInterop;
