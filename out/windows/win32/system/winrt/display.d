// Written in the D programming language.

module windows.win32.system.winrt.display;

public import windows.core;
public import system.system : Guid;
public import windows.win32.foundation.foundation : HANDLE, HRESULT;
public import windows.win32.security.security : SECURITY_ATTRIBUTES;
public import windows.win32.system.com.com : IUnknown;
public import windows.win32.system.winrt.winrt : HSTRING, IInspectable;

extern(Windows) @nogc nothrow:


// Interfaces

@GUID("64338358-366a-471b-bd56-dd8ef48e439b")
interface IDisplayDeviceInterop : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.devices.display.core.interop/nf-windows-devices-display-core-interop-idisplaydeviceinterop-createsharedhandle
    HRESULT CreateSharedHandle(IInspectable pObject, const(SECURITY_ATTRIBUTES)* pSecurityAttributes, uint Access, 
                               HSTRING Name, HANDLE* pHandle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.devices.display.core.interop/nf-windows-devices-display-core-interop-idisplaydeviceinterop-opensharedhandle
    HRESULT OpenSharedHandle(HANDLE NTHandle, GUID riid, void** ppvObj);
}

@GUID("a6ba4205-e59e-4e71-b25b-4e436d21ee3d")
interface IDisplayPathInterop : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.devices.display.core.interop/nf-windows-devices-display-core-interop-idisplaypathinterop-createsourcepresentationhandle
    HRESULT CreateSourcePresentationHandle(HANDLE* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.devices.display.core.interop/nf-windows-devices-display-core-interop-idisplaypathinterop-getsourceid
    HRESULT GetSourceId(uint* pSourceId);
}


// GUIDs


const GUID IID_IDisplayDeviceInterop = GUIDOF!IDisplayDeviceInterop;
const GUID IID_IDisplayPathInterop   = GUIDOF!IDisplayPathInterop;
