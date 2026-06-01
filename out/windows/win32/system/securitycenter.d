// Written in the D programming language.

module windows.win32.system.securitycenter;

public import windows.core;
public import windows.win32.foundation.foundation : BOOL, BSTR, HANDLE, HRESULT, PWSTR;
public import windows.win32.system.com.com : IDispatch;
public import windows.win32.system.threading : LPTHREAD_START_ROUTINE;

extern(Windows) @nogc nothrow:


// Enums


alias WSC_SECURITY_PRODUCT_SUBSTATUS = int;
enum : int
{
    WSC_SECURITY_PRODUCT_SUBSTATUS_NOT_SET            = 0x00000000,
    WSC_SECURITY_PRODUCT_SUBSTATUS_NO_ACTION          = 0x00000001,
    WSC_SECURITY_PRODUCT_SUBSTATUS_ACTION_RECOMMENDED = 0x00000002,
    WSC_SECURITY_PRODUCT_SUBSTATUS_ACTION_NEEDED      = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iwscapi/ne-iwscapi-wsc_security_product_state
alias WSC_SECURITY_PRODUCT_STATE = int;
enum : int
{
    WSC_SECURITY_PRODUCT_STATE_ON      = 0x00000000,
    WSC_SECURITY_PRODUCT_STATE_OFF     = 0x00000001,
    WSC_SECURITY_PRODUCT_STATE_SNOOZED = 0x00000002,
    WSC_SECURITY_PRODUCT_STATE_EXPIRED = 0x00000003,
}

alias SECURITY_PRODUCT_TYPE = int;
enum : int
{
    SECURITY_PRODUCT_TYPE_ANTIVIRUS   = 0x00000000,
    SECURITY_PRODUCT_TYPE_FIREWALL    = 0x00000001,
    SECURITY_PRODUCT_TYPE_ANTISPYWARE = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iwscapi/ne-iwscapi-wsc_security_signature_status
alias WSC_SECURITY_SIGNATURE_STATUS = int;
enum : int
{
    WSC_SECURITY_PRODUCT_OUT_OF_DATE = 0x00000000,
    WSC_SECURITY_PRODUCT_UP_TO_DATE  = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wscapi/ne-wscapi-wsc_security_provider
alias WSC_SECURITY_PROVIDER = int;
enum : int
{
    WSC_SECURITY_PROVIDER_FIREWALL             = 0x00000001,
    WSC_SECURITY_PROVIDER_AUTOUPDATE_SETTINGS  = 0x00000002,
    WSC_SECURITY_PROVIDER_ANTIVIRUS            = 0x00000004,
    WSC_SECURITY_PROVIDER_ANTISPYWARE          = 0x00000008,
    WSC_SECURITY_PROVIDER_INTERNET_SETTINGS    = 0x00000010,
    WSC_SECURITY_PROVIDER_USER_ACCOUNT_CONTROL = 0x00000020,
    WSC_SECURITY_PROVIDER_SERVICE              = 0x00000040,
    WSC_SECURITY_PROVIDER_NONE                 = 0x00000000,
    WSC_SECURITY_PROVIDER_ALL                  = 0x0000007f,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wscapi/ne-wscapi-wsc_security_provider_health
alias WSC_SECURITY_PROVIDER_HEALTH = int;
enum : int
{
    WSC_SECURITY_PROVIDER_HEALTH_GOOD         = 0x00000000,
    WSC_SECURITY_PROVIDER_HEALTH_NOTMONITORED = 0x00000001,
    WSC_SECURITY_PROVIDER_HEALTH_POOR         = 0x00000002,
    WSC_SECURITY_PROVIDER_HEALTH_SNOOZE       = 0x00000003,
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WSCAPI.dll")
HRESULT WscRegisterForChanges(void* Reserved, HANDLE* phCallbackRegistration, 
                              LPTHREAD_START_ROUTINE lpCallbackAddress, void* pContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WSCAPI.dll")
HRESULT WscUnRegisterChanges(HANDLE hRegistrationHandle);

@DllImport("WSCAPI.dll")
HRESULT WscRegisterForUserNotifications();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WSCAPI.dll")
HRESULT WscGetSecurityProviderHealth(uint Providers, WSC_SECURITY_PROVIDER_HEALTH* pHealth);

@DllImport("WSCAPI.dll")
HRESULT WscQueryAntiMalwareUri();

@DllImport("WSCAPI.dll")
HRESULT WscGetAntiMalwareUri(PWSTR* ppszUri);


// Interfaces

@GUID("17072f7b-9abe-4a74-a261-1eb76b55107a")
struct WSCProductList;

@GUID("2981a36e-f22d-11e5-9ce9-5e5517507c66")
struct WSCDefaultProduct;

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iwscapi/nn-iwscapi-iwscproduct
@GUID("8c38232e-3a45-4a27-92b0-1a16a975f669")
interface IWscProduct : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iwscapi/nf-iwscapi-iwscproduct-get_productname
    HRESULT get_ProductName(BSTR* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iwscapi/nf-iwscapi-iwscproduct-get_productstate
    HRESULT get_ProductState(WSC_SECURITY_PRODUCT_STATE* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iwscapi/nf-iwscapi-iwscproduct-get_signaturestatus
    HRESULT get_SignatureStatus(WSC_SECURITY_SIGNATURE_STATUS* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iwscapi/nf-iwscapi-iwscproduct-get_remediationpath
    HRESULT get_RemediationPath(BSTR* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iwscapi/nf-iwscapi-iwscproduct-get_productstatetimestamp
    HRESULT get_ProductStateTimestamp(BSTR* pVal);
    HRESULT get_ProductGuid(BSTR* pVal);
    HRESULT get_ProductIsDefault(BOOL* pVal);
}

@GUID("f896ca54-fe09-4403-86d4-23cb488d81d8")
interface IWscProduct2 : IWscProduct
{
    HRESULT get_AntivirusScanSubstatus(WSC_SECURITY_PRODUCT_SUBSTATUS* peStatus);
    HRESULT get_AntivirusSettingsSubstatus(WSC_SECURITY_PRODUCT_SUBSTATUS* peStatus);
    HRESULT get_AntivirusProtectionUpdateSubstatus(WSC_SECURITY_PRODUCT_SUBSTATUS* peStatus);
    HRESULT get_FirewallDomainProfileSubstatus(WSC_SECURITY_PRODUCT_SUBSTATUS* peStatus);
    HRESULT get_FirewallPrivateProfileSubstatus(WSC_SECURITY_PRODUCT_SUBSTATUS* peStatus);
    HRESULT get_FirewallPublicProfileSubstatus(WSC_SECURITY_PRODUCT_SUBSTATUS* peStatus);
}

@GUID("55536524-d1d1-4726-8c7c-04996a1904e7")
interface IWscProduct3 : IWscProduct2
{
    HRESULT get_AntivirusDaysUntilExpired(uint* pdwDays);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iwscapi/nn-iwscapi-iwscproductlist
@GUID("722a338c-6e8e-4e72-ac27-1417fb0c81c2")
interface IWSCProductList : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iwscapi/nf-iwscapi-iwscproductlist-initialize
    HRESULT Initialize(/*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(WSC_SECURITY_PROVIDER))], [])*/uint provider);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iwscapi/nf-iwscapi-iwscproductlist-get_count
    HRESULT get_Count(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iwscapi/nf-iwscapi-iwscproductlist-get_item
    HRESULT get_Item(uint index, IWscProduct* pVal);
}

@GUID("0476d69c-f21a-11e5-9ce9-5e5517507c66")
interface IWSCDefaultProduct : IDispatch
{
    HRESULT SetDefaultProduct(SECURITY_PRODUCT_TYPE eType, BSTR pGuid);
}


// GUIDs

const GUID CLSID_WSCDefaultProduct = GUIDOF!WSCDefaultProduct;
const GUID CLSID_WSCProductList    = GUIDOF!WSCProductList;

const GUID IID_IWSCDefaultProduct = GUIDOF!IWSCDefaultProduct;
const GUID IID_IWSCProductList    = GUIDOF!IWSCProductList;
const GUID IID_IWscProduct        = GUIDOF!IWscProduct;
const GUID IID_IWscProduct2       = GUIDOF!IWscProduct2;
const GUID IID_IWscProduct3       = GUIDOF!IWscProduct3;
