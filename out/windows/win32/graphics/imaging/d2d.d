// Written in the D programming language.

module windows.win32.graphics.imaging.d2d;

public import windows.core;
public import windows.win32.foundation : HRESULT;
public import windows.win32.graphics.direct2d : ID2D1Device, ID2D1Image;
public import windows.win32.graphics.imaging : IWICBitmapEncoder, IWICBitmapFrameEncode,
                                               IWICBitmapToneMapper, IWICImagingFactory,
                                               WICImageParameters;
public import windows.win32.system.com : IUnknown;

extern(Windows) @nogc nothrow:


// Interfaces

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicimageencoder
@GUID("04c75bf8-3ce1-473b-acc5-3cc4f5e94999")
interface IWICImageEncoder : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimageencoder-writeframe
    HRESULT WriteFrame(ID2D1Image pImage, IWICBitmapFrameEncode pFrameEncode, 
                       const(WICImageParameters)* pImageParameters);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimageencoder-writeframethumbnail
    HRESULT WriteFrameThumbnail(ID2D1Image pImage, IWICBitmapFrameEncode pFrameEncode, 
                                const(WICImageParameters)* pImageParameters);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimageencoder-writethumbnail
    HRESULT WriteThumbnail(ID2D1Image pImage, IWICBitmapEncoder pEncoder, 
                           const(WICImageParameters)* pImageParameters);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicimagingfactory2
@GUID("7b816b45-1996-4476-b132-de9e247c8af0")
interface IWICImagingFactory2 : IWICImagingFactory
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimagingfactory2-createimageencoder
    HRESULT CreateImageEncoder(ID2D1Device pD2DDevice, IWICImageEncoder* ppWICImageEncoder);
}

@GUID("489b3d8b-624a-4258-b678-7eece70f299d")
interface IWICImagingFactory3 : IWICImagingFactory2
{
    HRESULT CreateBitmapToneMapper(IWICBitmapToneMapper* ppToneMapper);
}


// GUIDs


const GUID IID_IWICImageEncoder    = GUIDOF!IWICImageEncoder;
const GUID IID_IWICImagingFactory2 = GUIDOF!IWICImagingFactory2;
const GUID IID_IWICImagingFactory3 = GUIDOF!IWICImagingFactory3;
