// Written in the D programming language.

module windows.win32.system.mailslots;

public import windows.core;
public import windows.win32.foundation.foundation : BOOL, HANDLE, PSTR, PWSTR;
public import windows.win32.security.security : SECURITY_ATTRIBUTES;

extern(Windows) @nogc nothrow:


// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
HANDLE CreateMailslotA(const(PSTR) lpName, uint nMaxMessageSize, uint lReadTimeout, 
                       SECURITY_ATTRIBUTES* lpSecurityAttributes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
HANDLE CreateMailslotW(const(PWSTR) lpName, uint nMaxMessageSize, uint lReadTimeout, 
                       SECURITY_ATTRIBUTES* lpSecurityAttributes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL GetMailslotInfo(HANDLE hMailslot, uint* lpMaxMessageSize, uint* lpNextSize, uint* lpMessageCount, 
                     uint* lpReadTimeout);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL SetMailslotInfo(HANDLE hMailslot, uint lReadTimeout);


