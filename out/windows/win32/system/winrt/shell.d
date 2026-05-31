// Written in the D programming language.

module windows.win32.system.winrt.shell;

public import windows.core;
public import windows.win32.foundation : HRESULT, PWSTR;
public import windows.win32.system.com : IUnknown;
public import windows.win32.ui.shell : IShellItem;

extern(Windows) @nogc nothrow:


// Enums

enum CreateProcessMethod : int
{
    CpCreateProcess         = 0x00000000,
    CpCreateProcessAsUser   = 0x00000001,
    CpAicLaunchAdminProcess = 0x00000002,
}

// Interfaces

@GUID("30dc931f-33fc-4ffd-a168-942258cf3ca4")
interface IDDEInitializer : IUnknown
{
    HRESULT Initialize(const(PWSTR) fileExtensionOrProtocol, CreateProcessMethod method, 
                       const(PWSTR) currentDirectory, IShellItem execTarget, IUnknown site, const(PWSTR) application, 
                       const(PWSTR) targetFile, const(PWSTR) arguments, const(PWSTR) verb);
}


// GUIDs


const GUID IID_IDDEInitializer = GUIDOF!IDDEInitializer;
