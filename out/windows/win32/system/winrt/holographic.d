// Written in the D programming language.

module windows.win32.system.winrt.holographic;

public import windows.core;
public import windows.win32.foundation : HRESULT;
public import windows.win32.graphics.direct3d12 : D3D12_RESOURCE_DESC, ID3D12CommandQueue,
                                                  ID3D12Device, ID3D12Fence,
                                                  ID3D12ProtectedResourceSession,
                                                  ID3D12Resource;
public import windows.win32.system.winrt : IInspectable;

extern(Windows) @nogc nothrow:


// Interfaces

@GUID("7cc1f9c5-6d02-41fa-9500-e1809eb48eec")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/windows.graphics.holographic.interop/nn-windows-graphics-holographic-interop-iholographiccamerainterop))], [])
interface IHolographicCameraInterop : IInspectable
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/windows.graphics.holographic.interop/nf-windows-graphics-holographic-interop-iholographiccamerainterop-createdirect3d12backbufferresource))], [])
    HRESULT CreateDirect3D12BackBufferResource(ID3D12Device pDevice, D3D12_RESOURCE_DESC* pTexture2DDesc, 
                                               ID3D12Resource* ppCreatedTexture2DResource);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/windows.graphics.holographic.interop/nf-windows-graphics-holographic-interop-iholographiccamerainterop-createdirect3d12hardwareprotectedbackbufferresource))], [])
    HRESULT CreateDirect3D12HardwareProtectedBackBufferResource(ID3D12Device pDevice, 
                                                                D3D12_RESOURCE_DESC* pTexture2DDesc, 
                                                                ID3D12ProtectedResourceSession pProtectedResourceSession, 
                                                                ID3D12Resource* ppCreatedTexture2DResource);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/windows.graphics.holographic.interop/nf-windows-graphics-holographic-interop-iholographiccamerainterop-acquiredirect3d12bufferresource))], [])
    HRESULT AcquireDirect3D12BufferResource(ID3D12Resource pResourceToAcquire, ID3D12CommandQueue pCommandQueue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/windows.graphics.holographic.interop/nf-windows-graphics-holographic-interop-iholographiccamerainterop-acquiredirect3d12bufferresourcewithtimeout))], [])
    HRESULT AcquireDirect3D12BufferResourceWithTimeout(ID3D12Resource pResourceToAcquire, 
                                                       ID3D12CommandQueue pCommandQueue, ulong duration);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/windows.graphics.holographic.interop/nf-windows-graphics-holographic-interop-iholographiccamerainterop-unacquiredirect3d12bufferresource))], [])
    HRESULT UnacquireDirect3D12BufferResource(ID3D12Resource pResourceToUnacquire);
}

@GUID("f75b68d6-d1fd-4707-aafd-fa6f4c0e3bf4")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/windows.graphics.holographic.interop/nn-windows-graphics-holographic-interop-iholographiccamerarenderingparametersinterop))], [])
interface IHolographicCameraRenderingParametersInterop : IInspectable
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/windows.graphics.holographic.interop/nf-windows-graphics-holographic-interop-iholographiccamerarenderingparametersinterop-commitdirect3d12resource))], [])
    HRESULT CommitDirect3D12Resource(ID3D12Resource pColorResourceToCommit, ID3D12Fence pColorResourceFence, 
                                     ulong colorResourceFenceSignalValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/windows.graphics.holographic.interop/nf-windows-graphics-holographic-interop-iholographiccamerarenderingparametersinterop-commitdirect3d12resourcewithdepthdata))], [])
    HRESULT CommitDirect3D12ResourceWithDepthData(ID3D12Resource pColorResourceToCommit, 
                                                  ID3D12Fence pColorResourceFence, 
                                                  ulong colorResourceFenceSignalValue, 
                                                  ID3D12Resource pDepthResourceToCommit, 
                                                  ID3D12Fence pDepthResourceFence, 
                                                  ulong depthResourceFenceSignalValue);
}

@GUID("cfa688f0-639e-4a47-83d7-6b7f5ebf7fed")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/windows.graphics.holographic.interop/nn-windows-graphics-holographic-interop-iholographicquadlayerinterop))], [])
interface IHolographicQuadLayerInterop : IInspectable
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/windows.graphics.holographic.interop/nf-windows-graphics-holographic-interop-iholographicquadlayerinterop-createdirect3d12contentbufferresource))], [])
    HRESULT CreateDirect3D12ContentBufferResource(ID3D12Device pDevice, D3D12_RESOURCE_DESC* pTexture2DDesc, 
                                                  ID3D12Resource* ppTexture2DResource);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/windows.graphics.holographic.interop/nf-windows-graphics-holographic-interop-iholographicquadlayerinterop-createdirect3d12hardwareprotectedcontentbufferresource))], [])
    HRESULT CreateDirect3D12HardwareProtectedContentBufferResource(ID3D12Device pDevice, 
                                                                   D3D12_RESOURCE_DESC* pTexture2DDesc, 
                                                                   ID3D12ProtectedResourceSession pProtectedResourceSession, 
                                                                   ID3D12Resource* ppCreatedTexture2DResource);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/windows.graphics.holographic.interop/nf-windows-graphics-holographic-interop-iholographicquadlayerinterop-acquiredirect3d12bufferresource))], [])
    HRESULT AcquireDirect3D12BufferResource(ID3D12Resource pResourceToAcquire, ID3D12CommandQueue pCommandQueue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/windows.graphics.holographic.interop/nf-windows-graphics-holographic-interop-iholographicquadlayerinterop-acquiredirect3d12bufferresourcewithtimeout))], [])
    HRESULT AcquireDirect3D12BufferResourceWithTimeout(ID3D12Resource pResourceToAcquire, 
                                                       ID3D12CommandQueue pCommandQueue, ulong duration);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/windows.graphics.holographic.interop/nf-windows-graphics-holographic-interop-iholographicquadlayerinterop-unacquiredirect3d12bufferresource))], [])
    HRESULT UnacquireDirect3D12BufferResource(ID3D12Resource pResourceToUnacquire);
}

@GUID("e5f549cd-c909-444f-8809-7cc18a9c8920")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/windows.graphics.holographic.interop/nn-windows-graphics-holographic-interop-iholographicquadlayerupdateparametersinterop))], [])
interface IHolographicQuadLayerUpdateParametersInterop : IInspectable
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/windows.graphics.holographic.interop/nf-windows-graphics-holographic-interop-iholographicquadlayerupdateparametersinterop-commitdirect3d12resource))], [])
    HRESULT CommitDirect3D12Resource(ID3D12Resource pColorResourceToCommit, ID3D12Fence pColorResourceFence, 
                                     ulong colorResourceFenceSignalValue);
}


// GUIDs


const GUID IID_IHolographicCameraInterop                    = GUIDOF!IHolographicCameraInterop;
const GUID IID_IHolographicCameraRenderingParametersInterop = GUIDOF!IHolographicCameraRenderingParametersInterop;
const GUID IID_IHolographicQuadLayerInterop                 = GUIDOF!IHolographicQuadLayerInterop;
const GUID IID_IHolographicQuadLayerUpdateParametersInterop = GUIDOF!IHolographicQuadLayerUpdateParametersInterop;
