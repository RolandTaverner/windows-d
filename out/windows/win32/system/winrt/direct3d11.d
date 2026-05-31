// Written in the D programming language.

module windows.win32.system.winrt.direct3d11;

public import windows.core;
public import system : Guid;
public import windows.win32.foundation : HRESULT;
public import windows.win32.graphics.dxgi : IDXGIDevice, IDXGISurface;
public import windows.win32.system.com : IUnknown;
public import windows.win32.system.winrt : IInspectable;

extern(Windows) @nogc nothrow:


// Functions

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/windows.graphics.directx.direct3d11.interop/nf-windows-graphics-directx-direct3d11-interop-createdirect3d11devicefromdxgidevice))], [])
@DllImport("d3d11.dll")
HRESULT CreateDirect3D11DeviceFromDXGIDevice(IDXGIDevice dxgiDevice, IInspectable* graphicsDevice);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/windows.graphics.directx.direct3d11.interop/nf-windows-graphics-directx-direct3d11-interop-createdirect3d11surfacefromdxgisurface))], [])
@DllImport("d3d11.dll")
HRESULT CreateDirect3D11SurfaceFromDXGISurface(IDXGISurface dgxiSurface, IInspectable* graphicsSurface);


// Interfaces

@GUID("a9b3d012-3df2-4ee3-b8d1-8695f457d3c1")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/windows.graphics.directx.direct3d11.interop/ns-windows-graphics-directx-direct3d11-interop-idirect3ddxgiinterfaceaccess))], [])
interface IDirect3DDxgiInterfaceAccess : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/windows.graphics.directx.direct3d11.interop/nf-windows-graphics-directx-direct3d11-interop-idirect3ddxgiinterfaceaccess-getinterface))], [])
    HRESULT GetInterface(const(GUID)* iid, void** p);
}


// GUIDs


const GUID IID_IDirect3DDxgiInterfaceAccess = GUIDOF!IDirect3DDxgiInterfaceAccess;
