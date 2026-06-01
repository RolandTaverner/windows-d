// Written in the D programming language.

module windows.win32.system.winrt.graphics.imaging;

public import windows.core;
public import system.system : Guid;
public import windows.win32.foundation.foundation : BOOL, HRESULT;
public import windows.win32.graphics.imaging.imaging : IWICBitmap;
public import windows.win32.media.mediafoundation : IMF2DBuffer2, MFVideoArea;
public import windows.win32.system.winrt.winrt : IInspectable;

extern(Windows) @nogc nothrow:


// Constants


enum GUID CLSID_SoftwareBitmapNativeFactory = GUID("84e65691-8602-4a84-be46-708be9cd4b74");

// Interfaces

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.graphics.imaging.interop/nn-windows-graphics-imaging-interop-isoftwarebitmapnative
@GUID("94bc8415-04ea-4b2e-af13-4de95aa898eb")
interface ISoftwareBitmapNative : IInspectable
{
    HRESULT GetData(const(GUID)* riid, void** ppv);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.graphics.imaging.interop/nn-windows-graphics-imaging-interop-isoftwarebitmapnativefactory
@GUID("c3c181ec-2914-4791-af02-02d224a10b43")
interface ISoftwareBitmapNativeFactory : IInspectable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.graphics.imaging.interop/nf-windows-graphics-imaging-interop-isoftwarebitmapnativefactory-createfromwicbitmap
    HRESULT CreateFromWICBitmap(IWICBitmap data, BOOL forceReadOnly, const(GUID)* riid, void** ppv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.graphics.imaging.interop/nf-windows-graphics-imaging-interop-isoftwarebitmapnativefactory-createfrommf2dbuffer2
    HRESULT CreateFromMF2DBuffer2(IMF2DBuffer2 data, const(GUID)* subtype, uint width, uint height, 
                                  BOOL forceReadOnly, const(MFVideoArea)* minDisplayAperture, const(GUID)* riid, 
                                  void** ppv);
}


// GUIDs


const GUID IID_ISoftwareBitmapNative        = GUIDOF!ISoftwareBitmapNative;
const GUID IID_ISoftwareBitmapNativeFactory = GUIDOF!ISoftwareBitmapNativeFactory;
