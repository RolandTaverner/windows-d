// Written in the D programming language.

module windows.win32.graphics.direct3d11on12;

public import windows.core;
public import system.system : Guid;
public import windows.win32.foundation.foundation : HRESULT;
public import windows.win32.graphics.direct3d.direct3d : D3D_FEATURE_LEVEL;
public import windows.win32.graphics.direct3d11 : ID3D11Device, ID3D11DeviceContext,
                                                  ID3D11Resource;
public import windows.win32.graphics.direct3d12 : D3D12_RESOURCE_STATES, ID3D12CommandQueue,
                                                  ID3D12Fence;
public import windows.win32.system.com.com : IUnknown;

extern(Windows) @nogc nothrow:


// Callbacks

alias PFN_D3D11ON12_CREATE_DEVICE = HRESULT function(IUnknown param0, uint param1, 
                                                     const(D3D_FEATURE_LEVEL)* param2, uint FeatureLevels, 
                                                     IUnknown* param4, uint NumQueues, uint param6, 
                                                     ID3D11Device* param7, ID3D11DeviceContext* param8, 
                                                     D3D_FEATURE_LEVEL* param9);

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d11on12/ns-d3d11on12-d3d11_resource_flags
struct D3D11_RESOURCE_FLAGS
{
    uint BindFlags;
    uint MiscFlags;
    uint CPUAccessFlags;
    uint StructureByteStride;
}

// Functions

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d11on12/nf-d3d11on12-d3d11on12createdevice
@DllImport("d3d11.dll")
HRESULT D3D11On12CreateDevice(IUnknown pDevice, uint Flags, const(D3D_FEATURE_LEVEL)* pFeatureLevels, 
                              uint FeatureLevels, IUnknown* ppCommandQueues, uint NumQueues, uint NodeMask, 
                              ID3D11Device* ppDevice, ID3D11DeviceContext* ppImmediateContext, 
                              D3D_FEATURE_LEVEL* pChosenFeatureLevel);


// Interfaces

@GUID("85611e73-70a9-490e-9614-a9e302777904")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d11on12/nn-d3d11on12-id3d11on12device
interface ID3D11On12Device : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d11on12/nf-d3d11on12-id3d11on12device-createwrappedresource
    HRESULT CreateWrappedResource(IUnknown pResource12, const(D3D11_RESOURCE_FLAGS)* pFlags11, 
                                  D3D12_RESOURCE_STATES InState, D3D12_RESOURCE_STATES OutState, const(GUID)* riid, 
                                  void** ppResource11);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d11on12/nf-d3d11on12-id3d11on12device-releasewrappedresources
    void    ReleaseWrappedResources(ID3D11Resource* ppResources, uint NumResources);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d11on12/nf-d3d11on12-id3d11on12device-acquirewrappedresources
    void    AcquireWrappedResources(ID3D11Resource* ppResources, uint NumResources);
}

@GUID("bdb64df4-ea2f-4c70-b861-aaab1258bb5d")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.18362))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d11on12/nn-d3d11on12-id3d11on12device1
interface ID3D11On12Device1 : ID3D11On12Device
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d11on12/nf-d3d11on12-id3d11on12device1-getd3d12device
    HRESULT GetD3D12Device(const(GUID)* riid, void** ppvDevice);
}

@GUID("dc90f331-4740-43fa-866e-67f12cb58223")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.19041))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d11on12/nn-d3d11on12-id3d11on12device2
interface ID3D11On12Device2 : ID3D11On12Device1
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d11on12/nf-d3d11on12-id3d11on12device2-unwrapunderlyingresource
    HRESULT UnwrapUnderlyingResource(ID3D11Resource pResource11, ID3D12CommandQueue pCommandQueue, 
                                     const(GUID)* riid, void** ppvResource12);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d11on12/nf-d3d11on12-id3d11on12device2-returnunderlyingresource
    HRESULT ReturnUnderlyingResource(ID3D11Resource pResource11, uint NumSync, ulong* pSignalValues, 
                                     ID3D12Fence* ppFences);
}


// GUIDs


const GUID IID_ID3D11On12Device  = GUIDOF!ID3D11On12Device;
const GUID IID_ID3D11On12Device1 = GUIDOF!ID3D11On12Device1;
const GUID IID_ID3D11On12Device2 = GUIDOF!ID3D11On12Device2;
