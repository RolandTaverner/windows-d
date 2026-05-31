// Written in the D programming language.

module windows.win32.system.winrt.ml;

public import windows.core;
public import windows.win32.ai.machinelearning.winml : IMLOperatorRegistry;
public import windows.win32.foundation : HRESULT;
public import windows.win32.graphics.direct3d12 : ID3D12CommandQueue, ID3D12Resource;
public import windows.win32.system.com : IUnknown;

extern(Windows) @nogc nothrow:


// Interfaces

@GUID("1adaa23a-eb67-41f3-aad8-5d984e9bacd4")
interface ILearningModelOperatorProviderNative : IUnknown
{
    HRESULT GetRegistry(IMLOperatorRegistry* ppOperatorRegistry);
}

@GUID("52f547ef-5b03-49b5-82d6-565f1ee0dd49")
interface ITensorNative : IUnknown
{
    HRESULT GetBuffer(ubyte** value, uint* capacity);
    HRESULT GetD3D12Resource(ID3D12Resource* result);
}

@GUID("39d055a4-66f6-4ebc-95d9-7a29ebe7690a")
interface ITensorStaticsNative : IUnknown
{
    HRESULT CreateFromD3D12Resource(ID3D12Resource value, long* shape, int shapeCount, IUnknown* result);
}

@GUID("1e9b31a1-662e-4ae0-af67-f63bb337e634")
interface ILearningModelDeviceFactoryNative : IUnknown
{
    HRESULT CreateFromD3D12CommandQueue(ID3D12CommandQueue value, IUnknown* result);
}

@GUID("c71e953f-37b4-4564-8658-d8396866db0d")
interface ILearningModelSessionOptionsNative : IUnknown
{
    HRESULT SetIntraOpNumThreadsOverride(uint intraOpNumThreads);
}

@GUID("5da37a26-0526-414b-91e4-2a0fa3ddba40")
interface ILearningModelSessionOptionsNative1 : IUnknown
{
    HRESULT SetIntraOpThreadSpinning(ubyte allowSpinning);
}


// GUIDs


const GUID IID_ILearningModelDeviceFactoryNative    = GUIDOF!ILearningModelDeviceFactoryNative;
const GUID IID_ILearningModelOperatorProviderNative = GUIDOF!ILearningModelOperatorProviderNative;
const GUID IID_ILearningModelSessionOptionsNative   = GUIDOF!ILearningModelSessionOptionsNative;
const GUID IID_ILearningModelSessionOptionsNative1  = GUIDOF!ILearningModelSessionOptionsNative1;
const GUID IID_ITensorNative                        = GUIDOF!ITensorNative;
const GUID IID_ITensorStaticsNative                 = GUIDOF!ITensorStaticsNative;
