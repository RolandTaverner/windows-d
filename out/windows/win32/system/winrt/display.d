// Written in the D programming language.

module windows.win32.system.winrt.display;

public import windows.core;
public import system : Guid;
public import windows.win32.foundation : HANDLE, HRESULT;
public import windows.win32.security : SECURITY_ATTRIBUTES;
public import windows.win32.system.com : IUnknown;
public import windows.win32.system.winrt : HSTRING, IInspectable;

extern(Windows) @nogc nothrow:


// Interfaces

@GUID("64338358-366a-471b-bd56-dd8ef48e439b")
interface IDisplayDeviceInterop : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/windows.devices.display.core.interop/nf-windows-devices-display-core-interop-idisplaydeviceinterop-createsharedhandle))], [])
    HRESULT CreateSharedHandle(IInspectable pObject, const(SECURITY_ATTRIBUTES)* pSecurityAttributes, uint Access, 
                               HSTRING Name, HANDLE* pHandle);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/windows.devices.display.core.interop/nf-windows-devices-display-core-interop-idisplaydeviceinterop-opensharedhandle))], [])
    HRESULT OpenSharedHandle(HANDLE NTHandle, GUID riid, void** ppvObj);
}

@GUID("a6ba4205-e59e-4e71-b25b-4e436d21ee3d")
interface IDisplayPathInterop : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/windows.devices.display.core.interop/nf-windows-devices-display-core-interop-idisplaypathinterop-createsourcepresentationhandle))], [])
    HRESULT CreateSourcePresentationHandle(HANDLE* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/windows.devices.display.core.interop/nf-windows-devices-display-core-interop-idisplaypathinterop-getsourceid))], [])
    HRESULT GetSourceId(uint* pSourceId);
}


// GUIDs


const GUID IID_IDisplayDeviceInterop = GUIDOF!IDisplayDeviceInterop;
const GUID IID_IDisplayPathInterop   = GUIDOF!IDisplayPathInterop;
