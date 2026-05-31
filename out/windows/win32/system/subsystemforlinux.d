// Written in the D programming language.

module windows.win32.system.subsystemforlinux;

public import windows.core;
public import windows.win32.foundation : BOOL, HANDLE, HRESULT, PSTR, PWSTR;

extern(Windows) @nogc nothrow:


// Enums

//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wslapi/ne-wslapi-wsl_distribution_flags))], [])
alias WSL_DISTRIBUTION_FLAGS = int;
enum : int
{
    WSL_DISTRIBUTION_FLAGS_NONE                  = 0x00000000,
    WSL_DISTRIBUTION_FLAGS_ENABLE_INTEROP        = 0x00000001,
    WSL_DISTRIBUTION_FLAGS_APPEND_NT_PATH        = 0x00000002,
    WSL_DISTRIBUTION_FLAGS_ENABLE_DRIVE_MOUNTING = 0x00000004,
}

// Functions

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wslapi/nf-wslapi-wslisdistributionregistered))], [])
@DllImport("Api-ms-win-wsl-api-l1-1-0.dll")
BOOL WslIsDistributionRegistered(const(PWSTR) distributionName);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wslapi/nf-wslapi-wslregisterdistribution))], [])
@DllImport("Api-ms-win-wsl-api-l1-1-0.dll")
HRESULT WslRegisterDistribution(const(PWSTR) distributionName, const(PWSTR) tarGzFilename);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wslapi/nf-wslapi-wslunregisterdistribution))], [])
@DllImport("Api-ms-win-wsl-api-l1-1-0.dll")
HRESULT WslUnregisterDistribution(const(PWSTR) distributionName);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wslapi/nf-wslapi-wslconfiguredistribution))], [])
@DllImport("Api-ms-win-wsl-api-l1-1-0.dll")
HRESULT WslConfigureDistribution(const(PWSTR) distributionName, uint defaultUID, 
                                 WSL_DISTRIBUTION_FLAGS wslDistributionFlags);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wslapi/nf-wslapi-wslgetdistributionconfiguration))], [])
@DllImport("Api-ms-win-wsl-api-l1-1-0.dll")
HRESULT WslGetDistributionConfiguration(const(PWSTR) distributionName, uint* distributionVersion, uint* defaultUID, 
                                        WSL_DISTRIBUTION_FLAGS* wslDistributionFlags, 
                                        PSTR** defaultEnvironmentVariables, uint* defaultEnvironmentVariableCount);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wslapi/nf-wslapi-wsllaunchinteractive))], [])
@DllImport("Api-ms-win-wsl-api-l1-1-0.dll")
HRESULT WslLaunchInteractive(const(PWSTR) distributionName, const(PWSTR) command, BOOL useCurrentWorkingDirectory, 
                             uint* exitCode);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wslapi/nf-wslapi-wsllaunch))], [])
@DllImport("Api-ms-win-wsl-api-l1-1-0.dll")
HRESULT WslLaunch(const(PWSTR) distributionName, const(PWSTR) command, BOOL useCurrentWorkingDirectory, 
                  HANDLE stdIn, HANDLE stdOut, HANDLE stdErr, HANDLE* process);


