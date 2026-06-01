// Written in the D programming language.

module windows.win32.system.winrt.graphics.capture;

public import windows.core;
public import windows.win32.foundation.foundation : HRESULT, HWND;
public import windows.win32.graphics.gdi : HMONITOR;
public import windows.win32.system.com.com : IUnknown;

extern(Windows) @nogc nothrow:


// Interfaces

@GUID("3628e81b-3cac-4c60-b7f4-23ce0e0c3356")
interface IGraphicsCaptureItemInterop : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.graphics.capture.interop/nf-windows-graphics-capture-interop-igraphicscaptureiteminterop-createforwindow
    HRESULT CreateForWindow(HWND window, const(GUID)* riid, void** result);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.graphics.capture.interop/nf-windows-graphics-capture-interop-igraphicscaptureiteminterop-createformonitor
    HRESULT CreateForMonitor(HMONITOR monitor, const(GUID)* riid, void** result);
}

@GUID("38e4c48b-94e6-4c44-9cfa-968193316c0c")
interface IWindowGraphicsCaptureItemInterop : IUnknown
{
    HRESULT GetWindow(HWND* window);
}

@GUID("33274d14-a076-4048-8416-747e9b04db7b")
interface IMonitorGraphicsCaptureItemInterop : IUnknown
{
    HRESULT GetMonitor(HMONITOR* monitor);
}


// GUIDs


const GUID IID_IGraphicsCaptureItemInterop        = GUIDOF!IGraphicsCaptureItemInterop;
const GUID IID_IMonitorGraphicsCaptureItemInterop = GUIDOF!IMonitorGraphicsCaptureItemInterop;
const GUID IID_IWindowGraphicsCaptureItemInterop  = GUIDOF!IWindowGraphicsCaptureItemInterop;
