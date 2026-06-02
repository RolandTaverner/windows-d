// Written in the D programming language.

module windows.win32.system.recovery;

public import windows.core;
public import windows.win32.foundation : BOOL, HANDLE, HRESULT, PWSTR;
public import windows.win32.system.windowsprogramming : APPLICATION_RECOVERY_CALLBACK;

extern(Windows) @nogc nothrow:


// Enums


alias REGISTER_APPLICATION_RESTART_FLAGS = uint;
enum : uint
{
    RESTART_NO_CRASH  = 0x00000001U,
    RESTART_NO_HANG   = 0x00000002U,
    RESTART_NO_PATCH  = 0x00000004U,
    RESTART_NO_REBOOT = 0x00000008U,
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
HRESULT RegisterApplicationRecoveryCallback(APPLICATION_RECOVERY_CALLBACK pRecoveyCallback, void* pvParameter, 
                                            uint dwPingInterval, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
HRESULT UnregisterApplicationRecoveryCallback();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
HRESULT RegisterApplicationRestart(const(PWSTR) pwzCommandline, REGISTER_APPLICATION_RESTART_FLAGS dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
HRESULT UnregisterApplicationRestart();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
HRESULT GetApplicationRecoveryCallback(HANDLE hProcess, APPLICATION_RECOVERY_CALLBACK* pRecoveryCallback, 
                                       void** ppvParameter, uint* pdwPingInterval, uint* pdwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
HRESULT GetApplicationRestartSettings(HANDLE hProcess, PWSTR pwzCommandline, uint* pcchSize, uint* pdwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
HRESULT ApplicationRecoveryInProgress(BOOL* pbCancelled);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
void ApplicationRecoveryFinished(BOOL bSuccess);


