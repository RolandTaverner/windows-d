// Written in the D programming language.

module windows.win32.system.com.callobj;

public import windows.core;
public import system.system : Guid;
public import windows.win32.foundation.foundation : BOOL, BOOLEAN, HRESULT, PWSTR;
public import windows.win32.system.com.com : ITypeInfo, IUnknown, MSHLFLAGS;
public import windows.win32.system.variant : VARIANT;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/callobj/ne-callobj-callframe_copy
alias CALLFRAME_COPY = int;
enum : int
{
    CALLFRAME_COPY_NESTED      = 0x00000001,
    CALLFRAME_COPY_INDEPENDENT = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/callobj/ne-callobj-callframe_free
alias CALLFRAME_FREE = int;
enum : int
{
    CALLFRAME_FREE_NONE      = 0x00000000,
    CALLFRAME_FREE_IN        = 0x00000001,
    CALLFRAME_FREE_INOUT     = 0x00000002,
    CALLFRAME_FREE_OUT       = 0x00000004,
    CALLFRAME_FREE_TOP_INOUT = 0x00000008,
    CALLFRAME_FREE_TOP_OUT   = 0x00000010,
    CALLFRAME_FREE_ALL       = 0x0000001f,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/callobj/ne-callobj-callframe_null
alias CALLFRAME_NULL = int;
enum : int
{
    CALLFRAME_NULL_NONE  = 0x00000000,
    CALLFRAME_NULL_INOUT = 0x00000002,
    CALLFRAME_NULL_OUT   = 0x00000004,
    CALLFRAME_NULL_ALL   = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/callobj/ne-callobj-callframe_walk
alias CALLFRAME_WALK = int;
enum : int
{
    CALLFRAME_WALK_IN    = 0x00000001,
    CALLFRAME_WALK_INOUT = 0x00000002,
    CALLFRAME_WALK_OUT   = 0x00000004,
}

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/callobj/ns-callobj-callframeinfo
struct CALLFRAMEINFO
{
    uint iMethod;
    BOOL fHasInValues;
    BOOL fHasInOutValues;
    BOOL fHasOutValues;
    BOOL fDerivesFromIDispatch;
    int  cInInterfacesMax;
    int  cInOutInterfacesMax;
    int  cOutInterfacesMax;
    int  cTopLevelInInterfaces;
    GUID iid;
    uint cMethod;
    uint cParams;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/callobj/ns-callobj-callframeparaminfo
struct CALLFRAMEPARAMINFO
{
    BOOLEAN fIn;
    BOOLEAN fOut;
    uint    stackOffset;
    uint    cbParam;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/callobj/ns-callobj-callframe_marshalcontext
struct CALLFRAME_MARSHALCONTEXT
{
    BOOLEAN  fIn;
    uint     dwDestContext;
    void*    pvDestContext;
    IUnknown punkReserved;
    GUID     guidTransferSyntax;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ole32.dll")
HRESULT CoGetInterceptor(const(GUID)* iidIntercepted, IUnknown punkOuter, const(GUID)* iid, void** ppv);

@DllImport("ole32.dll")
HRESULT CoGetInterceptorFromTypeInfo(const(GUID)* iidIntercepted, IUnknown punkOuter, ITypeInfo typeInfo, 
                                     const(GUID)* iid, void** ppv);


// Interfaces

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/callobj/nn-callobj-icallframe
@GUID("d573b4b0-894e-11d2-b8b6-00c04fb9618a")
interface ICallFrame : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/callobj/nf-callobj-icallframe-getinfo
    HRESULT GetInfo(CALLFRAMEINFO* pInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/callobj/nf-callobj-icallframe-getiidandmethod
    HRESULT GetIIDAndMethod(GUID* pIID, uint* piMethod);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/callobj/nf-callobj-icallframe-getnames
    HRESULT GetNames(PWSTR* pwszInterface, PWSTR* pwszMethod);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/callobj/nf-callobj-icallframe-getstacklocation
    void*   GetStackLocation();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/callobj/nf-callobj-icallframe-setstacklocation
    void    SetStackLocation(void* pvStack);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/callobj/nf-callobj-icallframe-setreturnvalue
    void    SetReturnValue(HRESULT hr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/callobj/nf-callobj-icallframe-getreturnvalue
    HRESULT GetReturnValue();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/callobj/nf-callobj-icallframe-getparaminfo
    HRESULT GetParamInfo(uint iparam, CALLFRAMEPARAMINFO* pInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/callobj/nf-callobj-icallframe-setparam
    HRESULT SetParam(uint iparam, VARIANT* pvar);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/callobj/nf-callobj-icallframe-getparam
    HRESULT GetParam(uint iparam, VARIANT* pvar);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/callobj/nf-callobj-icallframe-copy
    HRESULT Copy(CALLFRAME_COPY copyControl, ICallFrameWalker pWalker, ICallFrame* ppFrame);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/callobj/nf-callobj-icallframe-free
    HRESULT Free(ICallFrame pframeArgsDest, ICallFrameWalker pWalkerDestFree, ICallFrameWalker pWalkerCopy, 
                 uint freeFlags, ICallFrameWalker pWalkerFree, uint nullFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/callobj/nf-callobj-icallframe-freeparam
    HRESULT FreeParam(uint iparam, uint freeFlags, ICallFrameWalker pWalkerFree, uint nullFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/callobj/nf-callobj-icallframe-walkframe
    HRESULT WalkFrame(uint walkWhat, ICallFrameWalker pWalker);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/callobj/nf-callobj-icallframe-getmarshalsizemax
    HRESULT GetMarshalSizeMax(CALLFRAME_MARSHALCONTEXT* pmshlContext, MSHLFLAGS mshlflags, uint* pcbBufferNeeded);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/callobj/nf-callobj-icallframe-marshal
    HRESULT Marshal(CALLFRAME_MARSHALCONTEXT* pmshlContext, MSHLFLAGS mshlflags, void* pBuffer, uint cbBuffer, 
                    uint* pcbBufferUsed, uint* pdataRep, uint* prpcFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/callobj/nf-callobj-icallframe-unmarshal
    HRESULT Unmarshal(void* pBuffer, uint cbBuffer, uint dataRep, CALLFRAME_MARSHALCONTEXT* pcontext, 
                      uint* pcbUnmarshalled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/callobj/nf-callobj-icallframe-releasemarshaldata
    HRESULT ReleaseMarshalData(void* pBuffer, uint cbBuffer, uint ibFirstRelease, uint dataRep, 
                               CALLFRAME_MARSHALCONTEXT* pcontext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/callobj/nf-callobj-icallframe-invoke
    HRESULT Invoke(void* pvReceiver);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/callobj/nn-callobj-icallindirect
@GUID("d573b4b1-894e-11d2-b8b6-00c04fb9618a")
interface ICallIndirect : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/callobj/nf-callobj-icallindirect-callindirect
    HRESULT CallIndirect(HRESULT* phrReturn, uint iMethod, void* pvArgs, uint* cbArgs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/callobj/nf-callobj-icallindirect-getmethodinfo
    HRESULT GetMethodInfo(uint iMethod, CALLFRAMEINFO* pInfo, PWSTR* pwszMethod);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/callobj/nf-callobj-icallindirect-getstacksize
    HRESULT GetStackSize(uint iMethod, uint* cbArgs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/callobj/nf-callobj-icallindirect-getiid
    HRESULT GetIID(GUID* piid, BOOL* pfDerivesFromIDispatch, uint* pcMethod, PWSTR* pwszInterface);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/callobj/nn-callobj-icallinterceptor
@GUID("60c7ca75-896d-11d2-b8b6-00c04fb9618a")
interface ICallInterceptor : ICallIndirect
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/callobj/nf-callobj-icallinterceptor-registersink
    HRESULT RegisterSink(ICallFrameEvents psink);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/callobj/nf-callobj-icallinterceptor-getregisteredsink
    HRESULT GetRegisteredSink(ICallFrameEvents* ppsink);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/callobj/nn-callobj-icallframeevents
@GUID("fd5e0843-fc91-11d0-97d7-00c04fb9618a")
interface ICallFrameEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/callobj/nf-callobj-icallframeevents-oncall
    HRESULT OnCall(ICallFrame pFrame);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/callobj/nn-callobj-icallunmarshal
@GUID("5333b003-2e42-11d2-b89d-00c04fb9618a")
interface ICallUnmarshal : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/callobj/nf-callobj-icallunmarshal-unmarshal
    HRESULT Unmarshal(uint iMethod, void* pBuffer, uint cbBuffer, BOOL fForceBufferCopy, uint dataRep, 
                      CALLFRAME_MARSHALCONTEXT* pcontext, uint* pcbUnmarshalled, ICallFrame* ppFrame);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/callobj/nf-callobj-icallunmarshal-releasemarshaldata
    HRESULT ReleaseMarshalData(uint iMethod, void* pBuffer, uint cbBuffer, uint ibFirstRelease, uint dataRep, 
                               CALLFRAME_MARSHALCONTEXT* pcontext);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/callobj/nn-callobj-icallframewalker
@GUID("08b23919-392d-11d2-b8a4-00c04fb9618a")
interface ICallFrameWalker : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/callobj/nf-callobj-icallframewalker-onwalkinterface
    HRESULT OnWalkInterface(const(GUID)* iid, void** ppvInterface, BOOL fIn, BOOL fOut);
}

@GUID("d1fb5a79-7706-11d1-adba-00c04fc2adc0")
interface IInterfaceRelated : IUnknown
{
    HRESULT SetIID(const(GUID)* iid);
    HRESULT GetIID(GUID* piid);
}


// GUIDs


const GUID IID_ICallFrame        = GUIDOF!ICallFrame;
const GUID IID_ICallFrameEvents  = GUIDOF!ICallFrameEvents;
const GUID IID_ICallFrameWalker  = GUIDOF!ICallFrameWalker;
const GUID IID_ICallIndirect     = GUIDOF!ICallIndirect;
const GUID IID_ICallInterceptor  = GUIDOF!ICallInterceptor;
const GUID IID_ICallUnmarshal    = GUIDOF!ICallUnmarshal;
const GUID IID_IInterfaceRelated = GUIDOF!IInterfaceRelated;
