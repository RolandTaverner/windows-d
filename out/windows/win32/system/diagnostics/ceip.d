// Written in the D programming language.

module windows.win32.system.diagnostics.ceip;

public import windows.core;
public import windows.win32.foundation : BOOL;

extern(Windows) @nogc nothrow:


// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("KERNEL32.dll")
BOOL CeipIsOptedIn();


