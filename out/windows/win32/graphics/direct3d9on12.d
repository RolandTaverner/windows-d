// Written in the D programming language.

module windows.win32.graphics.direct3d9on12;

public import windows.core;
public import windows.win32.foundation : BOOL, HRESULT;
public import windows.win32.graphics.direct3d12 : ID3D12CommandQueue, ID3D12Fence;
public import windows.win32.graphics.direct3d9 : IDirect3D9, IDirect3D9Ex, IDirect3DResource9;
public import windows.win32.system.com : IUnknown;

extern(Windows) @nogc nothrow:


// Constants


enum uint MAX_D3D9ON12_QUEUES = 0x00000002U;

// Callbacks

alias PFN_Direct3DCreate9On12Ex = HRESULT function(uint SDKVersion, D3D9ON12_ARGS* pOverrideList, 
                                                   uint NumOverrideEntries, IDirect3D9Ex* ppOutputInterface);
alias PFN_Direct3DCreate9On12 = IDirect3D9 function(uint SDKVersion, D3D9ON12_ARGS* pOverrideList, 
                                                    uint NumOverrideEntries);

// Structs


struct D3D9ON12_ARGS
{
    BOOL        Enable9On12;
    IUnknown    pD3D12Device;
    IUnknown[2] ppD3D12Queues;
    uint        NumQueues;
    uint        NodeMask;
}

// Functions

@DllImport("d3d9.dll")
HRESULT Direct3DCreate9On12Ex(uint SDKVersion, D3D9ON12_ARGS* pOverrideList, uint NumOverrideEntries, 
                              IDirect3D9Ex* ppOutputInterface);

@DllImport("d3d9.dll")
IDirect3D9 Direct3DCreate9On12(uint SDKVersion, D3D9ON12_ARGS* pOverrideList, uint NumOverrideEntries);


// Interfaces

@GUID("e7fda234-b589-4049-940d-8878977531c8")
interface IDirect3DDevice9On12 : IUnknown
{
    HRESULT GetD3D12Device(const(GUID)* riid, void** ppvDevice);
    HRESULT UnwrapUnderlyingResource(IDirect3DResource9 pResource, ID3D12CommandQueue pCommandQueue, 
                                     const(GUID)* riid, void** ppvResource12);
    HRESULT ReturnUnderlyingResource(IDirect3DResource9 pResource, uint NumSync, ulong* pSignalValues, 
                                     ID3D12Fence* ppFences);
}


// GUIDs


const GUID IID_IDirect3DDevice9On12 = GUIDOF!IDirect3DDevice9On12;
