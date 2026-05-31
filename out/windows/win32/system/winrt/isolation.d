// Written in the D programming language.

module windows.win32.system.winrt.isolation;

public import windows.core;
public import windows.win32.foundation.foundation : HRESULT, HWND;
public import windows.win32.system.com.com : IUnknown;

extern(Windows) @nogc nothrow:


// Interfaces

@GUID("85713c2e-8e62-46c5-8de2-c647e1d54636")
interface IIsolatedEnvironmentInterop : IUnknown
{
    HRESULT GetHostHwndInterop(HWND containerHwnd, HWND* hostHwnd);
}


// GUIDs


const GUID IID_IIsolatedEnvironmentInterop = GUIDOF!IIsolatedEnvironmentInterop;
