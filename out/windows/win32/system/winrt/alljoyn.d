// Written in the D programming language.

module windows.win32.system.winrt.alljoyn;

public import windows.core;
public import system.system : Guid;
public import windows.win32.foundation.foundation : HRESULT;
public import windows.win32.system.winrt.winrt : HSTRING, IInspectable;

extern(Windows) @nogc nothrow:


// Interfaces

@GUID("fd89c65b-b50e-4a19-9d0c-b42b783281cd")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.devices.alljoyn.interop/nn-windows-devices-alljoyn-interop-iwindowsdevicesalljoynbusattachmentinterop
interface IWindowsDevicesAllJoynBusAttachmentInterop : IInspectable
{
    HRESULT get_Win32Handle(ulong* value);
}

@GUID("4b8f7505-b239-4e7b-88af-f6682575d861")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.devices.alljoyn.interop/nn-windows-devices-alljoyn-interop-iwindowsdevicesalljoynbusattachmentfactoryinterop
interface IWindowsDevicesAllJoynBusAttachmentFactoryInterop : IInspectable
{
    HRESULT CreateFromWin32Handle(ulong win32handle, ubyte enableAboutData, const(GUID)* riid, void** ppv);
}

@GUID("d78aa3d5-5054-428f-99f2-ec3a5de3c3bc")
interface IWindowsDevicesAllJoynBusObjectInterop : IInspectable
{
    HRESULT AddPropertyGetHandler(void* context, HSTRING interfaceName, ptrdiff_t callback);
    HRESULT AddPropertySetHandler(void* context, HSTRING interfaceName, ptrdiff_t callback);
    HRESULT get_Win32Handle(ulong* value);
}

@GUID("6174e506-8b95-4e36-95c0-b88fed34938c")
interface IWindowsDevicesAllJoynBusObjectFactoryInterop : IInspectable
{
    HRESULT CreateFromWin32Handle(ulong win32handle, const(GUID)* riid, void** ppv);
}


// GUIDs


const GUID IID_IWindowsDevicesAllJoynBusAttachmentFactoryInterop = GUIDOF!IWindowsDevicesAllJoynBusAttachmentFactoryInterop;
const GUID IID_IWindowsDevicesAllJoynBusAttachmentInterop        = GUIDOF!IWindowsDevicesAllJoynBusAttachmentInterop;
const GUID IID_IWindowsDevicesAllJoynBusObjectFactoryInterop     = GUIDOF!IWindowsDevicesAllJoynBusObjectFactoryInterop;
const GUID IID_IWindowsDevicesAllJoynBusObjectInterop            = GUIDOF!IWindowsDevicesAllJoynBusObjectInterop;
