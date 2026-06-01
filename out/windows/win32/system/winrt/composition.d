// Written in the D programming language.

module windows.win32.system.winrt.composition;

public import windows.core;
public import windows.ui.composition.composition : CompositionCapabilities, CompositionGraphicsDevice,
                                                   CompositionTexture;
public import windows.ui.composition.desktop : DesktopWindowTarget;
public import windows.ui.composition.composition : ICompositionSurface;
public import windows.win32.foundation.foundation : BOOL, HANDLE, HRESULT, HWND, POINT,
                                                    RECT, SIZE;
public import windows.win32.system.com.com : IUnknown;
public import windows.win32.system.winrt.winrt : IInspectable;
public import windows.win32.ui.input.pointer : POINTER_INFO;

extern(Windows) @nogc nothrow:


// Interfaces

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.composition.interop/nn-windows-ui-composition-interop-icompositiondrawingsurfaceinterop
@GUID("fd04e6e3-fe0c-4c3c-ab19-a07601a576ee")
interface ICompositionDrawingSurfaceInterop : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.composition.interop/nf-windows-ui-composition-interop-icompositiondrawingsurfaceinterop-begindraw
    HRESULT BeginDraw(const(RECT)* updateRect, const(GUID)* iid, void** updateObject, POINT* updateOffset);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.composition.interop/nf-windows-ui-composition-interop-icompositiondrawingsurfaceinterop-enddraw
    HRESULT EndDraw();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.composition.interop/nf-windows-ui-composition-interop-icompositiondrawingsurfaceinterop-resize
    HRESULT Resize(SIZE sizePixels);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.composition.interop/nf-windows-ui-composition-interop-icompositiondrawingsurfaceinterop-scroll
    HRESULT Scroll(const(RECT)* scrollRect, const(RECT)* clipRect, int offsetX, int offsetY);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.composition.interop/nf-windows-ui-composition-interop-icompositiondrawingsurfaceinterop-resumedraw
    HRESULT ResumeDraw();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.composition.interop/nf-windows-ui-composition-interop-icompositiondrawingsurfaceinterop-suspenddraw
    HRESULT SuspendDraw();
}

@GUID("41e64aae-98c0-4239-8e95-a330dd6aa18b")
interface ICompositionDrawingSurfaceInterop2 : ICompositionDrawingSurfaceInterop
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.composition.interop/nf-windows-ui-composition-interop-icompositiondrawingsurfaceinterop2-copysurface
    HRESULT CopySurface(IUnknown destinationResource, int destinationOffsetX, int destinationOffsetY, 
                        const(RECT)* sourceRectangle);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.composition.interop/nn-windows-ui-composition-interop-icompositiongraphicsdeviceinterop
@GUID("a116ff71-f8bf-4c8a-9c98-70779a32a9c8")
interface ICompositionGraphicsDeviceInterop : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.composition.interop/nf-windows-ui-composition-interop-icompositiongraphicsdeviceinterop-getrenderingdevice
    HRESULT GetRenderingDevice(IUnknown* value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.composition.interop/nf-windows-ui-composition-interop-icompositiongraphicsdeviceinterop-setrenderingdevice
    HRESULT SetRenderingDevice(IUnknown value);
}

@GUID("d3eef34c-0667-4afc-8d13-867607b0fe91")
interface ICompositorInterop2 : IUnknown
{
    HRESULT CheckCompositionTextureSupport(IUnknown renderingDevice, BOOL* supportsCompositionTextures);
    HRESULT CreateCompositionTexture(IUnknown d3dTexture, CompositionTexture* compositionTexture);
}

@GUID("d528a265-f0a5-422f-a39d-ef62d7cd1cc4")
interface ICompositionTextureInterop : IUnknown
{
    HRESULT GetAvailableFence(ulong* fenceValue, const(GUID)* iid, void** availableFence);
}

@GUID("11f62cd1-2f9d-42d3-b05f-d6790d9e9f8e")
interface IVisualInteractionSourceInterop : IUnknown
{
    HRESULT TryRedirectForManipulation(const(POINTER_INFO)* pointerInfo);
}

@GUID("35dbf59e-e3f9-45b0-81e7-fe75f4145dc9")
interface IDesktopWindowTargetInterop : IUnknown
{
    HRESULT get_Hwnd(HWND* value);
}


// GUIDs


const GUID IID_ICompositionDrawingSurfaceInterop  = GUIDOF!ICompositionDrawingSurfaceInterop;
const GUID IID_ICompositionDrawingSurfaceInterop2 = GUIDOF!ICompositionDrawingSurfaceInterop2;
const GUID IID_ICompositionGraphicsDeviceInterop  = GUIDOF!ICompositionGraphicsDeviceInterop;
const GUID IID_ICompositionTextureInterop         = GUIDOF!ICompositionTextureInterop;
const GUID IID_ICompositorInterop2                = GUIDOF!ICompositorInterop2;
const GUID IID_IDesktopWindowTargetInterop        = GUIDOF!IDesktopWindowTargetInterop;
const GUID IID_IVisualInteractionSourceInterop    = GUIDOF!IVisualInteractionSourceInterop;
