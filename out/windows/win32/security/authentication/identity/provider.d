// Written in the D programming language.

module windows.win32.security.authentication.identity.provider;

public import windows.core;
public import system.system : Guid;
public import windows.win32.foundation.foundation : BOOL, HRESULT, HWND, PROPERTYKEY, PWSTR;
public import windows.win32.system.com.com : IBindCtx, IEnumUnknown, IUnknown;
public import windows.win32.system.com.structuredstorage : PROPVARIANT;
public import windows.win32.system.variant : VARIANT;
public import windows.win32.ui.shell.propertiessystem : IPropertyStore;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sdoias/ne-sdoias-identity_type
alias IDENTITY_TYPE = int;
enum : int
{
    IDENTITIES_ALL     = 0x00000000,
    IDENTITIES_ME_ONLY = 0x00000001,
}

enum IdentityUpdateEvent : int
{
    IDENTITY_ASSOCIATED    = 0x00000001,
    IDENTITY_DISASSOCIATED = 0x00000002,
    IDENTITY_CREATED       = 0x00000004,
    IDENTITY_IMPORTED      = 0x00000008,
    IDENTITY_DELETED       = 0x00000010,
    IDENTITY_PROPCHANGED   = 0x00000020,
    IDENTITY_CONNECTED     = 0x00000040,
    IDENTITY_DISCONNECTED  = 0x00000080,
}

alias IDENTITY_URL = int;
enum : int
{
    IDENTITY_URL_CREATE_ACCOUNT_WIZARD  = 0x00000000,
    IDENTITY_URL_SIGN_IN_WIZARD         = 0x00000001,
    IDENTITY_URL_CHANGE_PASSWORD_WIZARD = 0x00000002,
    IDENTITY_URL_IFEXISTS_WIZARD        = 0x00000003,
    IDENTITY_URL_ACCOUNT_SETTINGS       = 0x00000004,
    IDENTITY_URL_RESTORE_WIZARD         = 0x00000005,
    IDENTITY_URL_CONNECT_WIZARD         = 0x00000006,
}

alias ACCOUNT_STATE = int;
enum : int
{
    NOT_CONNECTED     = 0x00000000,
    CONNECTING        = 0x00000001,
    CONNECT_COMPLETED = 0x00000002,
}

// Constants


enum : const(wchar)*
{
    IDENTITY_KEYWORD_ASSOCIATED = "associated",
    IDENTITY_KEYWORD_LOCAL      = "local",
    IDENTITY_KEYWORD_HOMEGROUP  = "homegroup",
    IDENTITY_KEYWORD_CONNECTED  = "connected",
}

enum GUID OID_OAssociatedIdentityProviderObject = GUID("98c5a3dd-db68-4f1a-8d2b-9079cdfeaf61");
enum const(wchar)* STR_OUT_OF_BOX_EXPERIENCE = "OutOfBoxExperience";
enum const(wchar)* STR_MODERN_SETTINGS_ADD_USER = "ModernSettingsAddUser";
enum const(wchar)* STR_OUT_OF_BOX_UPGRADE_EXPERIENCE = "OutOfBoxUpgradeExperience";
enum const(wchar)* STR_COMPLETE_ACCOUNT = "CompleteAccount";
enum const(wchar)* STR_NTH_USER_FIRST_AUTH = "NthUserFirstAuth";
enum const(wchar)* STR_USER_NAME = "Username";
enum const(wchar)* STR_PROPERTY_STORE = "PropertyStore";

// Interfaces

@GUID("30d49246-d217-465f-b00b-ac9ddd652eb7")
struct CoClassIdentityStore;

@GUID("ecf5bf46-e3b6-449a-b56b-43f58f867814")
struct CIdentityProfileHandler;

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/identityprovider/nn-identityprovider-iidentityadvise
@GUID("4e982fed-d14b-440c-b8d6-bb386453d386")
interface IIdentityAdvise : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/identityprovider/nf-identityprovider-iidentityadvise-identityupdated
    HRESULT IdentityUpdated(/*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(IdentityUpdateEvent))], [])*/uint dwIdentityUpdateEvents, 
                            const(PWSTR) lpszUniqueID);
}

@GUID("3ab4c8da-d038-4830-8dd9-3253c55a127f")
interface AsyncIIdentityAdvise : IUnknown
{
    HRESULT Begin_IdentityUpdated(uint dwIdentityUpdateEvents, const(PWSTR) lpszUniqueID);
    HRESULT Finish_IdentityUpdated();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/identityprovider/nn-identityprovider-iidentityprovider
@GUID("0d1b9e0c-e8ba-4f55-a81b-bce934b948f5")
interface IIdentityProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/identityprovider/nf-identityprovider-iidentityprovider-getidentityenum
    HRESULT GetIdentityEnum(const(IDENTITY_TYPE) eIdentityType, const(PROPERTYKEY)* pFilterkey, 
                            const(PROPVARIANT)* pFilterPropVarValue, IEnumUnknown* ppIdentityEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/identityprovider/nf-identityprovider-iidentityprovider-create
    HRESULT Create(const(PWSTR) lpszUserName, IPropertyStore* ppPropertyStore, const(PROPVARIANT)* pKeywordsToAdd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/identityprovider/nf-identityprovider-iidentityprovider-import
    HRESULT Import(IPropertyStore pPropertyStore);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/identityprovider/nf-identityprovider-iidentityprovider-delete
    HRESULT Delete(const(PWSTR) lpszUniqueID, const(PROPVARIANT)* pKeywordsToDelete);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/identityprovider/nf-identityprovider-iidentityprovider-findbyuniqueid
    HRESULT FindByUniqueID(const(PWSTR) lpszUniqueID, IPropertyStore* ppPropertyStore);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/identityprovider/nf-identityprovider-iidentityprovider-getproviderpropertystore
    HRESULT GetProviderPropertyStore(IPropertyStore* ppPropertyStore);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/identityprovider/nf-identityprovider-iidentityprovider-advise
    HRESULT Advise(IIdentityAdvise pIdentityAdvise, 
                   /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(IdentityUpdateEvent))], [])*/uint dwIdentityUpdateEvents, 
                   uint* pdwCookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/identityprovider/nf-identityprovider-iidentityprovider-unadvise
    HRESULT UnAdvise(const(uint) dwCookie);
}

@GUID("c6fc9901-c433-4646-8f48-4e4687aae2a0")
interface AsyncIIdentityProvider : IUnknown
{
    HRESULT Begin_GetIdentityEnum(const(IDENTITY_TYPE) eIdentityType, const(PROPERTYKEY)* pFilterkey, 
                                  const(PROPVARIANT)* pFilterPropVarValue);
    HRESULT Finish_GetIdentityEnum(IEnumUnknown* ppIdentityEnum);
    HRESULT Begin_Create(const(PWSTR) lpszUserName, const(PROPVARIANT)* pKeywordsToAdd);
    HRESULT Finish_Create(IPropertyStore* ppPropertyStore);
    HRESULT Begin_Import(IPropertyStore pPropertyStore);
    HRESULT Finish_Import();
    HRESULT Begin_Delete(const(PWSTR) lpszUniqueID, const(PROPVARIANT)* pKeywordsToDelete);
    HRESULT Finish_Delete();
    HRESULT Begin_FindByUniqueID(const(PWSTR) lpszUniqueID);
    HRESULT Finish_FindByUniqueID(IPropertyStore* ppPropertyStore);
    HRESULT Begin_GetProviderPropertyStore();
    HRESULT Finish_GetProviderPropertyStore(IPropertyStore* ppPropertyStore);
    HRESULT Begin_Advise(IIdentityAdvise pIdentityAdvise, uint dwIdentityUpdateEvents);
    HRESULT Finish_Advise(uint* pdwCookie);
    HRESULT Begin_UnAdvise(const(uint) dwCookie);
    HRESULT Finish_UnAdvise();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/identityprovider/nn-identityprovider-iassociatedidentityprovider
@GUID("2af066b3-4cbb-4cba-a798-204b6af68cc0")
interface IAssociatedIdentityProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/identityprovider/nf-identityprovider-iassociatedidentityprovider-associateidentity
    HRESULT AssociateIdentity(HWND hwndParent, IPropertyStore* ppPropertyStore);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/identityprovider/nf-identityprovider-iassociatedidentityprovider-disassociateidentity
    HRESULT DisassociateIdentity(HWND hwndParent, const(PWSTR) lpszUniqueID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/identityprovider/nf-identityprovider-iassociatedidentityprovider-changecredential
    HRESULT ChangeCredential(HWND hwndParent, const(PWSTR) lpszUniqueID);
}

@GUID("2834d6ed-297e-4e72-8a51-961e86f05152")
interface AsyncIAssociatedIdentityProvider : IUnknown
{
    HRESULT Begin_AssociateIdentity(HWND hwndParent);
    HRESULT Finish_AssociateIdentity(IPropertyStore* ppPropertyStore);
    HRESULT Begin_DisassociateIdentity(HWND hwndParent, const(PWSTR) lpszUniqueID);
    HRESULT Finish_DisassociateIdentity();
    HRESULT Begin_ChangeCredential(HWND hwndParent, const(PWSTR) lpszUniqueID);
    HRESULT Finish_ChangeCredential();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/identityprovider/nn-identityprovider-iconnectedidentityprovider
@GUID("b7417b54-e08c-429b-96c8-678d1369ecb1")
interface IConnectedIdentityProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/identityprovider/nf-identityprovider-iconnectedidentityprovider-connectidentity
    HRESULT ConnectIdentity(ubyte* AuthBuffer, uint AuthBufferSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/identityprovider/nf-identityprovider-iconnectedidentityprovider-disconnectidentity
    HRESULT DisconnectIdentity();
    HRESULT IsConnected(BOOL* Connected);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/identityprovider/nf-identityprovider-iconnectedidentityprovider-geturl
    HRESULT GetUrl(IDENTITY_URL Identifier, IBindCtx Context, VARIANT* PostData, PWSTR* Url);
    HRESULT GetAccountState(ACCOUNT_STATE* pState);
}

@GUID("9ce55141-bce9-4e15-824d-43d79f512f93")
interface AsyncIConnectedIdentityProvider : IUnknown
{
    HRESULT Begin_ConnectIdentity(ubyte* AuthBuffer, uint AuthBufferSize);
    HRESULT Finish_ConnectIdentity();
    HRESULT Begin_DisconnectIdentity();
    HRESULT Finish_DisconnectIdentity();
    HRESULT Begin_IsConnected();
    HRESULT Finish_IsConnected(BOOL* Connected);
    HRESULT Begin_GetUrl(IDENTITY_URL Identifier, IBindCtx Context);
    HRESULT Finish_GetUrl(VARIANT* PostData, PWSTR* Url);
    HRESULT Begin_GetAccountState();
    HRESULT Finish_GetAccountState(ACCOUNT_STATE* pState);
}

@GUID("5e7ef254-979f-43b5-b74e-06e4eb7df0f9")
interface IIdentityAuthentication : IUnknown
{
    HRESULT SetIdentityCredential(ubyte* CredBuffer, uint CredBufferLength);
    HRESULT ValidateIdentityCredential(ubyte* CredBuffer, uint CredBufferLength, 
                                       IPropertyStore* ppIdentityProperties);
}

@GUID("f9a2f918-feca-4e9c-9633-61cbf13ed34d")
interface AsyncIIdentityAuthentication : IUnknown
{
    HRESULT Begin_SetIdentityCredential(ubyte* CredBuffer, uint CredBufferLength);
    HRESULT Finish_SetIdentityCredential();
    HRESULT Begin_ValidateIdentityCredential(ubyte* CredBuffer, uint CredBufferLength, 
                                             IPropertyStore* ppIdentityProperties);
    HRESULT Finish_ValidateIdentityCredential(IPropertyStore* ppIdentityProperties);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/identitystore/nn-identitystore-iidentitystore
@GUID("df586fa5-6f35-44f1-b209-b38e169772eb")
interface IIdentityStore : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/identitystore/nf-identitystore-iidentitystore-getcount
    HRESULT GetCount(uint* pdwProviders);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/identitystore/nf-identitystore-iidentitystore-getat
    HRESULT GetAt(const(uint) dwProvider, GUID* pProvGuid, IUnknown* ppIdentityProvider);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/identitystore/nf-identitystore-iidentitystore-addtocache
    HRESULT AddToCache(const(PWSTR) lpszUniqueID, const(GUID)* ProviderGUID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/identitystore/nf-identitystore-iidentitystore-converttosid
    HRESULT ConvertToSid(const(PWSTR) lpszUniqueID, const(GUID)* ProviderGUID, ushort cbSid, ubyte* pSid, 
                         ushort* pcbRequiredSid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/identitystore/nf-identitystore-iidentitystore-enumerateidentities
    HRESULT EnumerateIdentities(const(IDENTITY_TYPE) eIdentityType, const(PROPERTYKEY)* pFilterkey, 
                                const(PROPVARIANT)* pFilterPropVarValue, IEnumUnknown* ppIdentityEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/identitystore/nf-identitystore-iidentitystore-reset
    HRESULT Reset();
}

@GUID("eefa1616-48de-4872-aa64-6e6206535a51")
interface AsyncIIdentityStore : IUnknown
{
    HRESULT Begin_GetCount();
    HRESULT Finish_GetCount(uint* pdwProviders);
    HRESULT Begin_GetAt(const(uint) dwProvider, GUID* pProvGuid);
    HRESULT Finish_GetAt(GUID* pProvGuid, IUnknown* ppIdentityProvider);
    HRESULT Begin_AddToCache(const(PWSTR) lpszUniqueID, const(GUID)* ProviderGUID);
    HRESULT Finish_AddToCache();
    HRESULT Begin_ConvertToSid(const(PWSTR) lpszUniqueID, const(GUID)* ProviderGUID, ushort cbSid, ubyte* pSid);
    HRESULT Finish_ConvertToSid(ubyte* pSid, ushort* pcbRequiredSid);
    HRESULT Begin_EnumerateIdentities(const(IDENTITY_TYPE) eIdentityType, const(PROPERTYKEY)* pFilterkey, 
                                      const(PROPVARIANT)* pFilterPropVarValue);
    HRESULT Finish_EnumerateIdentities(IEnumUnknown* ppIdentityEnum);
    HRESULT Begin_Reset();
    HRESULT Finish_Reset();
}

@GUID("f9f9eb98-8f7f-4e38-9577-6980114ce32b")
interface IIdentityStoreEx : IUnknown
{
    HRESULT CreateConnectedIdentity(const(PWSTR) LocalName, const(PWSTR) ConnectedName, const(GUID)* ProviderGUID);
    HRESULT DeleteConnectedIdentity(const(PWSTR) ConnectedName, const(GUID)* ProviderGUID);
}

@GUID("fca3af9a-8a07-4eae-8632-ec3de658a36a")
interface AsyncIIdentityStoreEx : IUnknown
{
    HRESULT Begin_CreateConnectedIdentity(const(PWSTR) LocalName, const(PWSTR) ConnectedName, 
                                          const(GUID)* ProviderGUID);
    HRESULT Finish_CreateConnectedIdentity();
    HRESULT Begin_DeleteConnectedIdentity(const(PWSTR) ConnectedName, const(GUID)* ProviderGUID);
    HRESULT Finish_DeleteConnectedIdentity();
}


// GUIDs

const GUID CLSID_CIdentityProfileHandler = GUIDOF!CIdentityProfileHandler;
const GUID CLSID_CoClassIdentityStore    = GUIDOF!CoClassIdentityStore;

const GUID IID_AsyncIAssociatedIdentityProvider = GUIDOF!AsyncIAssociatedIdentityProvider;
const GUID IID_AsyncIConnectedIdentityProvider  = GUIDOF!AsyncIConnectedIdentityProvider;
const GUID IID_AsyncIIdentityAdvise             = GUIDOF!AsyncIIdentityAdvise;
const GUID IID_AsyncIIdentityAuthentication     = GUIDOF!AsyncIIdentityAuthentication;
const GUID IID_AsyncIIdentityProvider           = GUIDOF!AsyncIIdentityProvider;
const GUID IID_AsyncIIdentityStore              = GUIDOF!AsyncIIdentityStore;
const GUID IID_AsyncIIdentityStoreEx            = GUIDOF!AsyncIIdentityStoreEx;
const GUID IID_IAssociatedIdentityProvider      = GUIDOF!IAssociatedIdentityProvider;
const GUID IID_IConnectedIdentityProvider       = GUIDOF!IConnectedIdentityProvider;
const GUID IID_IIdentityAdvise                  = GUIDOF!IIdentityAdvise;
const GUID IID_IIdentityAuthentication          = GUIDOF!IIdentityAuthentication;
const GUID IID_IIdentityProvider                = GUIDOF!IIdentityProvider;
const GUID IID_IIdentityStore                   = GUIDOF!IIdentityStore;
const GUID IID_IIdentityStoreEx                 = GUIDOF!IIdentityStoreEx;
