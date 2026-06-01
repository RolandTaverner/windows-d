// Written in the D programming language.

module windows.win32.security.enterprisedata;

public import windows.core;
public import windows.win32.foundation.foundation : BOOL, HANDLE, HRESULT, HWND, NTSTATUS,
                                                    PWSTR;
public import windows.win32.storage.packaging.appx : PACKAGE_ID;
public import windows.win32.system.com.com : IUnknown;
public import windows.win32.system.winrt.winrt : HSTRING, IInspectable;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/srpapi/ne-srpapi-enterprise_data_policies
alias ENTERPRISE_DATA_POLICIES = int;
enum : int
{
    ENTERPRISE_POLICY_NONE        = 0x00000000,
    ENTERPRISE_POLICY_ALLOWED     = 0x00000001,
    ENTERPRISE_POLICY_ENLIGHTENED = 0x00000002,
    ENTERPRISE_POLICY_EXEMPT      = 0x00000004,
}

alias SRPHOSTING_TYPE = int;
enum : int
{
    SRPHOSTING_TYPE_NONE    = 0x00000000,
    SRPHOSTING_TYPE_WINHTTP = 0x00000001,
    SRPHOSTING_TYPE_WININET = 0x00000002,
}

alias SRPHOSTING_VERSION = int;
enum : int
{
    SRPHOSTING_VERSION1 = 0x00000001,
}

// Structs


struct _SRP_REQUEST
{
    ptrdiff_t Value;
}

struct HTHREAD_NETWORK_CONTEXT
{
    uint   ThreadId;
    HANDLE ThreadContext;
}

struct FILE_UNPROTECT_OPTIONS
{
    ubyte audit;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("srpapi.dll")
HRESULT SrpCreateThreadNetworkContext(const(PWSTR) enterpriseId, HTHREAD_NETWORK_CONTEXT* threadNetworkContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("srpapi.dll")
HRESULT SrpCloseThreadNetworkContext(HTHREAD_NETWORK_CONTEXT* threadNetworkContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("srpapi.dll")
HRESULT SrpSetTokenEnterpriseId(HANDLE tokenHandle, const(PWSTR) enterpriseId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("srpapi.dll")
HRESULT SrpGetEnterpriseIds(HANDLE tokenHandle, uint* numberOfBytes, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(PWSTR)* enterpriseIds, 
                            uint* enterpriseIdCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("srpapi.dll")
HRESULT SrpEnablePermissiveModeFileEncryption(const(PWSTR) enterpriseId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("srpapi.dll")
HRESULT SrpDisablePermissiveModeFileEncryption();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("srpapi.dll")
HRESULT SrpGetEnterprisePolicy(HANDLE tokenHandle, ENTERPRISE_DATA_POLICIES* policyFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("srpapi.dll")
NTSTATUS SrpIsTokenService(HANDLE TokenHandle, ubyte* IsTokenService);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("srpapi.dll")
HRESULT SrpDoesPolicyAllowAppExecution(const(PACKAGE_ID)* packageId, BOOL* isAllowed);

@DllImport("srpapi.dll")
NTSTATUS SrpIsAllowed(_SRP_REQUEST* FileInfo);

@DllImport("srpapi.dll")
HRESULT SrpHostingInitialize(SRPHOSTING_VERSION Version, SRPHOSTING_TYPE Type, void* pvData, uint cbData);

@DllImport("srpapi.dll")
void SrpHostingTerminate(SRPHOSTING_TYPE Type);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("efswrt.dll")
HRESULT ProtectFileToEnterpriseIdentity(const(PWSTR) fileOrFolderPath, const(PWSTR) identity);

@DllImport("efswrt.dll")
HRESULT UnprotectFile(const(PWSTR) fileOrFolderPath, const(FILE_UNPROTECT_OPTIONS)* options);


// Interfaces

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/efswrtinterop/nn-efswrtinterop-iprotectionpolicymanagerinterop
@GUID("4652651d-c1fe-4ba1-9f0a-c0f56596f721")
interface IProtectionPolicyManagerInterop : IInspectable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/efswrtinterop/nf-efswrtinterop-iprotectionpolicymanagerinterop-requestaccessforwindowasync
    HRESULT RequestAccessForWindowAsync(HWND appWindow, HSTRING sourceIdentity, HSTRING targetIdentity, 
                                        const(GUID)* riid, void** asyncOperation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/efswrtinterop/nf-efswrtinterop-iprotectionpolicymanagerinterop-getforwindow
    HRESULT GetForWindow(HWND appWindow, const(GUID)* riid, void** result);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/efswrtinterop/nn-efswrtinterop-iprotectionpolicymanagerinterop2
@GUID("157cfbe4-a78d-4156-b384-61fdac41e686")
interface IProtectionPolicyManagerInterop2 : IInspectable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/efswrtinterop/nf-efswrtinterop-iprotectionpolicymanagerinterop2-requestaccessforappwithwindowasync
    HRESULT RequestAccessForAppWithWindowAsync(HWND appWindow, HSTRING sourceIdentity, 
                                               HSTRING appPackageFamilyName, const(GUID)* riid, 
                                               void** asyncOperation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/efswrtinterop/nf-efswrtinterop-iprotectionpolicymanagerinterop2-requestaccesswithauditinginfoforwindowasync
    HRESULT RequestAccessWithAuditingInfoForWindowAsync(HWND appWindow, HSTRING sourceIdentity, 
                                                        HSTRING targetIdentity, IUnknown auditInfoUnk, 
                                                        const(GUID)* riid, void** asyncOperation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/efswrtinterop/nf-efswrtinterop-iprotectionpolicymanagerinterop2-requestaccesswithmessageforwindowasync
    HRESULT RequestAccessWithMessageForWindowAsync(HWND appWindow, HSTRING sourceIdentity, HSTRING targetIdentity, 
                                                   IUnknown auditInfoUnk, HSTRING messageFromApp, const(GUID)* riid, 
                                                   void** asyncOperation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/efswrtinterop/nf-efswrtinterop-iprotectionpolicymanagerinterop2-requestaccessforappwithauditinginfoforwindowasync
    HRESULT RequestAccessForAppWithAuditingInfoForWindowAsync(HWND appWindow, HSTRING sourceIdentity, 
                                                              HSTRING appPackageFamilyName, IUnknown auditInfoUnk, 
                                                              const(GUID)* riid, void** asyncOperation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/efswrtinterop/nf-efswrtinterop-iprotectionpolicymanagerinterop2-requestaccessforappwithmessageforwindowasync
    HRESULT RequestAccessForAppWithMessageForWindowAsync(HWND appWindow, HSTRING sourceIdentity, 
                                                         HSTRING appPackageFamilyName, IUnknown auditInfoUnk, 
                                                         HSTRING messageFromApp, const(GUID)* riid, 
                                                         void** asyncOperation);
}

@GUID("c1c03933-b398-4d93-b0fd-2972adf802c2")
interface IProtectionPolicyManagerInterop3 : IInspectable
{
    HRESULT RequestAccessWithBehaviorForWindowAsync(HWND appWindow, HSTRING sourceIdentity, HSTRING targetIdentity, 
                                                    IUnknown auditInfoUnk, HSTRING messageFromApp, uint behavior, 
                                                    const(GUID)* riid, void** asyncOperation);
    HRESULT RequestAccessForAppWithBehaviorForWindowAsync(HWND appWindow, HSTRING sourceIdentity, 
                                                          HSTRING appPackageFamilyName, IUnknown auditInfoUnk, 
                                                          HSTRING messageFromApp, uint behavior, const(GUID)* riid, 
                                                          void** asyncOperation);
    HRESULT RequestAccessToFilesForAppForWindowAsync(HWND appWindow, IUnknown sourceItemListUnk, 
                                                     HSTRING appPackageFamilyName, IUnknown auditInfoUnk, 
                                                     const(GUID)* riid, void** asyncOperation);
    HRESULT RequestAccessToFilesForAppWithMessageAndBehaviorForWindowAsync(HWND appWindow, 
                                                                           IUnknown sourceItemListUnk, 
                                                                           HSTRING appPackageFamilyName, 
                                                                           IUnknown auditInfoUnk, 
                                                                           HSTRING messageFromApp, uint behavior, 
                                                                           const(GUID)* riid, void** asyncOperation);
    HRESULT RequestAccessToFilesForProcessForWindowAsync(HWND appWindow, IUnknown sourceItemListUnk, 
                                                         uint processId, IUnknown auditInfoUnk, const(GUID)* riid, 
                                                         void** asyncOperation);
    HRESULT RequestAccessToFilesForProcessWithMessageAndBehaviorForWindowAsync(HWND appWindow, 
                                                                               IUnknown sourceItemListUnk, 
                                                                               uint processId, IUnknown auditInfoUnk, 
                                                                               HSTRING messageFromApp, uint behavior, 
                                                                               const(GUID)* riid, 
                                                                               void** asyncOperation);
}


// GUIDs


const GUID IID_IProtectionPolicyManagerInterop  = GUIDOF!IProtectionPolicyManagerInterop;
const GUID IID_IProtectionPolicyManagerInterop2 = GUIDOF!IProtectionPolicyManagerInterop2;
const GUID IID_IProtectionPolicyManagerInterop3 = GUIDOF!IProtectionPolicyManagerInterop3;
