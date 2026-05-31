// Written in the D programming language.

module windows.win32.system.serverbackup;

public import windows.core;
public import system.system : Guid;
public import windows.win32.foundation.foundation : BOOLEAN, HRESULT, PWSTR;
public import windows.win32.system.com.com : IUnknown;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wsbonline/ne-wsbonline-wsb_ob_status_entry_pair_type
alias WSB_OB_STATUS_ENTRY_PAIR_TYPE = int;
enum : int
{
    WSB_OB_ET_UNDEFINED = 0x00000000,
    WSB_OB_ET_STRING    = 0x00000001,
    WSB_OB_ET_NUMBER    = 0x00000002,
    WSB_OB_ET_DATETIME  = 0x00000003,
    WSB_OB_ET_TIME      = 0x00000004,
    WSB_OB_ET_SIZE      = 0x00000005,
    WSB_OB_ET_MAX       = 0x00000006,
}

// Constants


enum : uint
{
    WSB_MAX_OB_STATUS_VALUE_TYPE_PAIR = 0x00000005U,
    WSB_MAX_OB_STATUS_ENTRY           = 0x00000005U,
}

enum HRESULT WSBAPP_ASYNC_IN_PROGRESS = HRESULT(0x007a0004);

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wsbonline/ns-wsbonline-wsb_ob_status_entry_value_type_pair
struct WSB_OB_STATUS_ENTRY_VALUE_TYPE_PAIR
{
    PWSTR m_wszObStatusEntryPairValue;
    WSB_OB_STATUS_ENTRY_PAIR_TYPE m_ObStatusEntryPairType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wsbonline/ns-wsbonline-wsb_ob_status_entry
struct WSB_OB_STATUS_ENTRY
{
    uint m_dwIcon;
    uint m_dwStatusEntryName;
    uint m_dwStatusEntryValue;
    uint m_cValueTypePair;
    WSB_OB_STATUS_ENTRY_VALUE_TYPE_PAIR* m_rgValueTypePair;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wsbonline/ns-wsbonline-wsb_ob_status_info
struct WSB_OB_STATUS_INFO
{
    GUID                 m_guidSnapinId;
    uint                 m_cStatusEntry;
    WSB_OB_STATUS_ENTRY* m_rgStatusEntry;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wsbonline/ns-wsbonline-wsb_ob_registration_info
struct WSB_OB_REGISTRATION_INFO
{
    PWSTR   m_wszResourceDLL;
    GUID    m_guidSnapinId;
    uint    m_dwProviderName;
    uint    m_dwProviderIcon;
    BOOLEAN m_bSupportsRemoting;
}

// Interfaces

@GUID("1eff3510-4a27-46ad-b9e0-08332f0f4f6d")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wsbapp/nn-wsbapp-iwsbapplicationbackupsupport
interface IWsbApplicationBackupSupport : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wsbapp/nf-wsbapp-iwsbapplicationbackupsupport-checkconsistency
    HRESULT CheckConsistency(PWSTR wszWriterMetadata, PWSTR wszComponentName, PWSTR wszComponentLogicalPath, 
                             uint cVolumes, PWSTR* rgwszSourceVolumePath, PWSTR* rgwszSnapshotVolumePath, 
                             IWsbApplicationAsync* ppAsync);
}

@GUID("8d3bdb38-4ee8-4718-85f9-c7dbc4ab77aa")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wsbapp/nn-wsbapp-iwsbapplicationrestoresupport
interface IWsbApplicationRestoreSupport : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wsbapp/nf-wsbapp-iwsbapplicationrestoresupport-prerestore
    HRESULT PreRestore(PWSTR wszWriterMetadata, PWSTR wszComponentName, PWSTR wszComponentLogicalPath, 
                       BOOLEAN bNoRollForward);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wsbapp/nf-wsbapp-iwsbapplicationrestoresupport-postrestore
    HRESULT PostRestore(PWSTR wszWriterMetadata, PWSTR wszComponentName, PWSTR wszComponentLogicalPath, 
                        BOOLEAN bNoRollForward);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wsbapp/nf-wsbapp-iwsbapplicationrestoresupport-ordercomponents
    HRESULT OrderComponents(uint cComponents, PWSTR* rgComponentName, PWSTR* rgComponentLogicalPaths, 
                            PWSTR** prgComponentName, PWSTR** prgComponentLogicalPath);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wsbapp/nf-wsbapp-iwsbapplicationrestoresupport-isrollforwardsupported
    HRESULT IsRollForwardSupported(ubyte* pbRollForwardSupported);
}

@GUID("0843f6f7-895c-44a6-b0c2-05a5022aa3a1")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wsbapp/nn-wsbapp-iwsbapplicationasync
interface IWsbApplicationAsync : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wsbapp/nf-wsbapp-iwsbapplicationasync-querystatus
    HRESULT QueryStatus(HRESULT* phrResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wsbapp/nf-wsbapp-iwsbapplicationasync-abort
    HRESULT Abort();
}


// GUIDs


const GUID IID_IWsbApplicationAsync          = GUIDOF!IWsbApplicationAsync;
const GUID IID_IWsbApplicationBackupSupport  = GUIDOF!IWsbApplicationBackupSupport;
const GUID IID_IWsbApplicationRestoreSupport = GUIDOF!IWsbApplicationRestoreSupport;
