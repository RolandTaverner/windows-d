// Written in the D programming language.

module windows.win32.system.winrt.coreinputview;

public import windows.core;
public import system.system : Guid;
public import windows.win32.foundation.foundation : HRESULT, HWND;
public import windows.win32.system.winrt.winrt : IInspectable;

extern(Windows) @nogc nothrow:


// Interfaces

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.viewmanagement.core.coreframeworkinputviewinterop/nn-windows-ui-viewmanagement-core-coreframeworkinputviewinterop-icoreframeworkinputviewinterop
@GUID("0e3da342-b11c-484b-9c1c-be0d61c2f6c5")
interface ICoreFrameworkInputViewInterop : IInspectable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windows.ui.viewmanagement.core.coreframeworkinputviewinterop/nf-windows-ui-viewmanagement-core-coreframeworkinputviewinterop-icoreframeworkinputviewinterop-getforwindow
    HRESULT GetForWindow(HWND appWindow, const(GUID)* riid, void** coreFrameworkInputView);
}


// GUIDs


const GUID IID_ICoreFrameworkInputViewInterop = GUIDOF!ICoreFrameworkInputViewInterop;
