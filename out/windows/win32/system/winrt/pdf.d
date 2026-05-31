// Written in the D programming language.

module windows.win32.system.winrt.pdf;

public import windows.core;
public import windows.win32.foundation : BOOLEAN, HRESULT, POINT;
public import windows.win32.graphics.direct2d.common : D2D_COLOR_F, D2D_RECT_F;
public import windows.win32.graphics.direct2d : ID2D1DeviceContext;
public import windows.win32.graphics.dxgi : IDXGIDevice, IDXGISurface;
public import windows.win32.system.com : IUnknown;

extern(Windows) @nogc nothrow:


// Callbacks

alias PFN_PDF_CREATE_RENDERER = HRESULT function(IDXGIDevice param0, IPdfRendererNative* param1);

// Structs


//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/windows.data.pdf.interop/ns-windows-data-pdf-interop-pdf_render_params))], [])
struct PDF_RENDER_PARAMS
{
    D2D_RECT_F  SourceRect;
    uint        DestinationWidth;
    uint        DestinationHeight;
    D2D_COLOR_F BackgroundColor;
    BOOLEAN     IgnoreHighContrast;
}

// Functions

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/windows.data.pdf.interop/nf-windows-data-pdf-interop-pdfcreaterenderer))], [])
@DllImport("Windows.Data.Pdf.dll")
HRESULT PdfCreateRenderer(IDXGIDevice pDevice, IPdfRendererNative* ppRenderer);


// Interfaces

@GUID("7d9dcd91-d277-4947-8527-07a0daeda94a")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/windows.data.pdf.interop/nn-windows-data-pdf-interop-ipdfrenderernative))], [])
interface IPdfRendererNative : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/windows.data.pdf.interop/nf-windows-data-pdf-interop-ipdfrenderernative-renderpagetosurface))], [])
    HRESULT RenderPageToSurface(IUnknown pdfPage, IDXGISurface pSurface, POINT offset, 
                                PDF_RENDER_PARAMS* pRenderParams);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/windows.data.pdf.interop/nf-windows-data-pdf-interop-ipdfrenderernative-renderpagetodevicecontext))], [])
    HRESULT RenderPageToDeviceContext(IUnknown pdfPage, ID2D1DeviceContext pD2DDeviceContext, 
                                      PDF_RENDER_PARAMS* pRenderParams);
}


// GUIDs


const GUID IID_IPdfRendererNative = GUIDOF!IPdfRendererNative;
