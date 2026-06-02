// Written in the D programming language.

module windows.win32.security.isolation;

public import windows.core;
public import windows.win32.foundation : BOOL, HANDLE, HRESULT, PWSTR;
public import windows.win32.security : PSID, SID_AND_ATTRIBUTES;
public import windows.win32.system.com : IUnknown;
public import windows.win32.system.registry : HKEY;

extern(Windows) @nogc nothrow:


// Constants


enum const(wchar)* WDAG_CLIPBOARD_TAG = "CrossIsolatedEnvironmentContent";

// Structs


struct IsolatedAppLauncherTelemetryParameters
{
    BOOL EnableForLaunch;
    GUID CorrelationGUID;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("KERNEL32.dll")
BOOL GetAppContainerNamedObjectPath(HANDLE Token, PSID AppContainerSid, uint ObjectPathLength, PWSTR ObjectPath, 
                                    uint* ReturnLength);

deprecated("IsProcessInWDAGContainer is deprecated and might not work on all platforms. For more info, see MSDN.") 
@DllImport("api-ms-win-security-isolatedcontainer-l1-1-1.dll")
HRESULT IsProcessInWDAGContainer(void* Reserved, BOOL* isProcessInWDAGContainer);

deprecated("IsProcessInIsolatedContainer is deprecated and might not work on all platforms. For more info, see MSDN.") 
@DllImport("api-ms-win-security-isolatedcontainer-l1-1-0.dll")
HRESULT IsProcessInIsolatedContainer(BOOL* isProcessInIsolatedContainer);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/isolatedwindowsenvironmentutils/nf-isolatedwindowsenvironmentutils-isprocessinisolatedwindowsenvironment
@DllImport("IsolatedWindowsEnvironmentUtils.dll")
HRESULT IsProcessInIsolatedWindowsEnvironment(BOOL* isProcessInIsolatedWindowsEnvironment);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/isolatedwindowsenvironmentutils/nf-isolatedwindowsenvironmentutils-iscrossisolatedenvironmentclipboardcontent
@DllImport("IsolatedWindowsEnvironmentUtils.dll")
HRESULT IsCrossIsolatedEnvironmentClipboardContent(BOOL* isCrossIsolatedEnvironmentClipboardContent);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("USERENV.dll")
HRESULT CreateAppContainerProfile(const(PWSTR) pszAppContainerName, const(PWSTR) pszDisplayName, 
                                  const(PWSTR) pszDescription, SID_AND_ATTRIBUTES* pCapabilities, 
                                  uint dwCapabilityCount, PSID* ppSidAppContainerSid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("USERENV.dll")
HRESULT DeleteAppContainerProfile(const(PWSTR) pszAppContainerName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("USERENV.dll")
HRESULT GetAppContainerRegistryLocation(uint desiredAccess, HKEY* phAppContainerKey);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("USERENV.dll")
HRESULT GetAppContainerFolderPath(const(PWSTR) pszAppContainerSid, PWSTR* ppszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("USERENV.dll")
HRESULT DeriveRestrictedAppContainerSidFromAppContainerSidAndRestrictedName(PSID psidAppContainerSid, 
                                                                            const(PWSTR) pszRestrictedAppContainerName, 
                                                                            PSID* ppsidRestrictedAppContainerSid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("USERENV.dll")
HRESULT DeriveAppContainerSidFromAppContainerName(const(PWSTR) pszAppContainerName, PSID* ppsidAppContainerSid);


// Interfaces

@GUID("bc812430-e75e-4fd1-9641-1f9f1e2d9a1f")
struct IsolatedAppLauncher;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/isolatedapplauncher/nn-isolatedapplauncher-iisolatedapplauncher
@GUID("f686878f-7b42-4cc4-96fb-f4f3b6e3d24d")
interface IIsolatedAppLauncher : IUnknown
{
    HRESULT Launch(const(PWSTR) appUserModelId, const(PWSTR) arguments, 
                   const(IsolatedAppLauncherTelemetryParameters)* telemetryParameters);
}

@GUID("1aa24232-9a91-4201-88cb-122f9d6522e0")
interface IIsolatedProcessLauncher : IUnknown
{
    HRESULT LaunchProcess(const(PWSTR) process, const(PWSTR) arguments, const(PWSTR) workingDirectory);
    HRESULT ShareDirectory(const(PWSTR) hostPath, const(PWSTR) containerPath, BOOL readOnly);
    HRESULT GetContainerGuid(GUID* guid);
    HRESULT AllowSetForegroundAccess(uint pid);
    HRESULT IsContainerRunning(BOOL* running);
}

@GUID("780e4416-5e72-4123-808e-66dc6479feef")
interface IIsolatedProcessLauncher2 : IIsolatedProcessLauncher
{
    HRESULT LaunchProcess2(const(PWSTR) process, const(PWSTR) arguments, const(PWSTR) workingDirectory, 
                           const(GUID)* correlationGuid);
}


// GUIDs

const GUID CLSID_IsolatedAppLauncher = GUIDOF!IsolatedAppLauncher;

const GUID IID_IIsolatedAppLauncher      = GUIDOF!IIsolatedAppLauncher;
const GUID IID_IIsolatedProcessLauncher  = GUIDOF!IIsolatedProcessLauncher;
const GUID IID_IIsolatedProcessLauncher2 = GUIDOF!IIsolatedProcessLauncher2;
