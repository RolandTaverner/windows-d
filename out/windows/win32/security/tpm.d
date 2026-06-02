// Written in the D programming language.

module windows.win32.security.tpm;

public import windows.core;
public import windows.win32.foundation : BOOL, HRESULT, PWSTR;
public import windows.win32.system.com : IUnknown;

extern(Windows) @nogc nothrow:


// Enums


alias TPMVSC_ATTESTATION_TYPE = int;
enum : int
{
    TPMVSC_ATTESTATION_NONE                = 0x00000000,
    TPMVSC_ATTESTATION_AIK_ONLY            = 0x00000001,
    TPMVSC_ATTESTATION_AIK_AND_CERTIFICATE = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tpmvscmgr/ne-tpmvscmgr-tpmvscmgr_status
alias TPMVSCMGR_STATUS = int;
enum : int
{
    TPMVSCMGR_STATUS_VTPMSMARTCARD_INITIALIZING  = 0x00000000,
    TPMVSCMGR_STATUS_VTPMSMARTCARD_CREATING      = 0x00000001,
    TPMVSCMGR_STATUS_VTPMSMARTCARD_DESTROYING    = 0x00000002,
    TPMVSCMGR_STATUS_VGIDSSIMULATOR_INITIALIZING = 0x00000003,
    TPMVSCMGR_STATUS_VGIDSSIMULATOR_CREATING     = 0x00000004,
    TPMVSCMGR_STATUS_VGIDSSIMULATOR_DESTROYING   = 0x00000005,
    TPMVSCMGR_STATUS_VREADER_INITIALIZING        = 0x00000006,
    TPMVSCMGR_STATUS_VREADER_CREATING            = 0x00000007,
    TPMVSCMGR_STATUS_VREADER_DESTROYING          = 0x00000008,
    TPMVSCMGR_STATUS_GENERATE_WAITING            = 0x00000009,
    TPMVSCMGR_STATUS_GENERATE_AUTHENTICATING     = 0x0000000a,
    TPMVSCMGR_STATUS_GENERATE_RUNNING            = 0x0000000b,
    TPMVSCMGR_STATUS_CARD_CREATED                = 0x0000000c,
    TPMVSCMGR_STATUS_CARD_DESTROYED              = 0x0000000d,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tpmvscmgr/ne-tpmvscmgr-tpmvscmgr_error
alias TPMVSCMGR_ERROR = int;
enum : int
{
    TPMVSCMGR_ERROR_IMPERSONATION                 = 0x00000000,
    TPMVSCMGR_ERROR_PIN_COMPLEXITY                = 0x00000001,
    TPMVSCMGR_ERROR_READER_COUNT_LIMIT            = 0x00000002,
    TPMVSCMGR_ERROR_TERMINAL_SERVICES_SESSION     = 0x00000003,
    TPMVSCMGR_ERROR_VTPMSMARTCARD_INITIALIZE      = 0x00000004,
    TPMVSCMGR_ERROR_VTPMSMARTCARD_CREATE          = 0x00000005,
    TPMVSCMGR_ERROR_VTPMSMARTCARD_DESTROY         = 0x00000006,
    TPMVSCMGR_ERROR_VGIDSSIMULATOR_INITIALIZE     = 0x00000007,
    TPMVSCMGR_ERROR_VGIDSSIMULATOR_CREATE         = 0x00000008,
    TPMVSCMGR_ERROR_VGIDSSIMULATOR_DESTROY        = 0x00000009,
    TPMVSCMGR_ERROR_VGIDSSIMULATOR_WRITE_PROPERTY = 0x0000000a,
    TPMVSCMGR_ERROR_VGIDSSIMULATOR_READ_PROPERTY  = 0x0000000b,
    TPMVSCMGR_ERROR_VREADER_INITIALIZE            = 0x0000000c,
    TPMVSCMGR_ERROR_VREADER_CREATE                = 0x0000000d,
    TPMVSCMGR_ERROR_VREADER_DESTROY               = 0x0000000e,
    TPMVSCMGR_ERROR_GENERATE_LOCATE_READER        = 0x0000000f,
    TPMVSCMGR_ERROR_GENERATE_FILESYSTEM           = 0x00000010,
    TPMVSCMGR_ERROR_CARD_CREATE                   = 0x00000011,
    TPMVSCMGR_ERROR_CARD_DESTROY                  = 0x00000012,
}

// Constants


enum uint TPMVSC_DEFAULT_ADMIN_ALGORITHM_ID = 0x00000082U;

// Interfaces

@GUID("16a18e86-7f6e-4c20-ad89-4ffc0db7a96a")
struct TpmVirtualSmartCardManager;

@GUID("152ea2a8-70dc-4c59-8b2a-32aa3ca0dcac")
struct RemoteTpmVirtualSmartCardManager;

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tpmvscmgr/nn-tpmvscmgr-itpmvirtualsmartcardmanagerstatuscallback
@GUID("1a1bb35f-abb8-451c-a1ae-33d98f1bef4a")
interface ITpmVirtualSmartCardManagerStatusCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tpmvscmgr/nf-tpmvscmgr-itpmvirtualsmartcardmanagerstatuscallback-reportprogress
    HRESULT ReportProgress(TPMVSCMGR_STATUS Status);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tpmvscmgr/nf-tpmvscmgr-itpmvirtualsmartcardmanagerstatuscallback-reporterror
    HRESULT ReportError(TPMVSCMGR_ERROR Error);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tpmvscmgr/nn-tpmvscmgr-itpmvirtualsmartcardmanager
@GUID("112b1dff-d9dc-41f7-869f-d67fee7cb591")
interface ITpmVirtualSmartCardManager : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tpmvscmgr/nf-tpmvscmgr-itpmvirtualsmartcardmanager-createvirtualsmartcard
    HRESULT CreateVirtualSmartCard(const(PWSTR) pszFriendlyName, ubyte bAdminAlgId, const(ubyte)* pbAdminKey, 
                                   uint cbAdminKey, const(ubyte)* pbAdminKcv, uint cbAdminKcv, const(ubyte)* pbPuk, 
                                   uint cbPuk, const(ubyte)* pbPin, uint cbPin, BOOL fGenerate, 
                                   ITpmVirtualSmartCardManagerStatusCallback pStatusCallback, PWSTR* ppszInstanceId, 
                                   BOOL* pfNeedReboot);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tpmvscmgr/nf-tpmvscmgr-itpmvirtualsmartcardmanager-destroyvirtualsmartcard
    HRESULT DestroyVirtualSmartCard(const(PWSTR) pszInstanceId, 
                                    ITpmVirtualSmartCardManagerStatusCallback pStatusCallback, BOOL* pfNeedReboot);
}

@GUID("fdf8a2b9-02de-47f4-bc26-aa85ab5e5267")
interface ITpmVirtualSmartCardManager2 : ITpmVirtualSmartCardManager
{
    HRESULT CreateVirtualSmartCardWithPinPolicy(const(PWSTR) pszFriendlyName, ubyte bAdminAlgId, 
                                                const(ubyte)* pbAdminKey, uint cbAdminKey, const(ubyte)* pbAdminKcv, 
                                                uint cbAdminKcv, const(ubyte)* pbPuk, uint cbPuk, 
                                                const(ubyte)* pbPin, uint cbPin, const(ubyte)* pbPinPolicy, 
                                                uint cbPinPolicy, BOOL fGenerate, 
                                                ITpmVirtualSmartCardManagerStatusCallback pStatusCallback, 
                                                PWSTR* ppszInstanceId, BOOL* pfNeedReboot);
}

@GUID("3c745a97-f375-4150-be17-5950f694c699")
interface ITpmVirtualSmartCardManager3 : ITpmVirtualSmartCardManager2
{
    HRESULT CreateVirtualSmartCardWithAttestation(const(PWSTR) pszFriendlyName, ubyte bAdminAlgId, 
                                                  const(ubyte)* pbAdminKey, uint cbAdminKey, 
                                                  const(ubyte)* pbAdminKcv, uint cbAdminKcv, const(ubyte)* pbPuk, 
                                                  uint cbPuk, const(ubyte)* pbPin, uint cbPin, 
                                                  const(ubyte)* pbPinPolicy, uint cbPinPolicy, 
                                                  TPMVSC_ATTESTATION_TYPE attestationType, BOOL fGenerate, 
                                                  ITpmVirtualSmartCardManagerStatusCallback pStatusCallback, 
                                                  PWSTR* ppszInstanceId);
}


// GUIDs

const GUID CLSID_RemoteTpmVirtualSmartCardManager = GUIDOF!RemoteTpmVirtualSmartCardManager;
const GUID CLSID_TpmVirtualSmartCardManager       = GUIDOF!TpmVirtualSmartCardManager;

const GUID IID_ITpmVirtualSmartCardManager               = GUIDOF!ITpmVirtualSmartCardManager;
const GUID IID_ITpmVirtualSmartCardManager2              = GUIDOF!ITpmVirtualSmartCardManager2;
const GUID IID_ITpmVirtualSmartCardManager3              = GUIDOF!ITpmVirtualSmartCardManager3;
const GUID IID_ITpmVirtualSmartCardManagerStatusCallback = GUIDOF!ITpmVirtualSmartCardManagerStatusCallback;
