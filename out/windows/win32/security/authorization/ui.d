// Written in the D programming language.

module windows.win32.security.authorization.ui;

public import windows.core;
public import windows.win32.foundation : BOOL, BOOLEAN, HINSTANCE, HRESULT, HWND,
                                         PWSTR;
public import windows.win32.security : ACE_FLAGS, ACL;
public import windows.win32.security.authorization : AUTHZ_SECURITY_ATTRIBUTES_INFORMATION,
                                                     AUTHZ_SECURITY_ATTRIBUTE_OPERATION,
                                                     AUTHZ_SID_OPERATION, INHERITED_FROMA;
public import windows.win32.security : OBJECT_SECURITY_INFORMATION, OBJECT_TYPE_LIST,
                                       PSECURITY_DESCRIPTOR, PSID, TOKEN_GROUPS;
public import windows.win32.system.com : IDataObject, IUnknown;
public import windows.win32.ui.controls : HPROPSHEETPAGE, PSPCB_MESSAGE;

extern(Windows) @nogc nothrow:


// Enums


alias SECURITY_INFO_PAGE_FLAGS = uint;
enum : uint
{
    SI_ADVANCED        = 0x00000010U,
    SI_EDIT_AUDITS     = 0x00000002U,
    SI_EDIT_PROPERTIES = 0x00000080U,
}

alias SI_OBJECT_INFO_FLAGS = uint;
enum : uint
{
    SI_AUDITS_ELEVATION_REQUIRED       = 0x02000000U,
    SI_DISABLE_DENY_ACE                = 0x80000000U,
    SI_EDIT_EFFECTIVE                  = 0x00020000U,
    SI_ENABLE_CENTRAL_POLICY           = 0x40000000U,
    SI_ENABLE_EDIT_ATTRIBUTE_CONDITION = 0x20000000U,
    SI_MAY_WRITE                       = 0x10000000U,
    SI_NO_ADDITIONAL_PERMISSION        = 0x00200000U,
    SI_OWNER_ELEVATION_REQUIRED        = 0x04000000U,
    SI_PERMS_ELEVATION_REQUIRED        = 0x01000000U,
    SI_RESET_DACL                      = 0x00040000U,
    SI_RESET_OWNER                     = 0x00100000U,
    SI_RESET_SACL                      = 0x00080000U,
    SI_SCOPE_ELEVATION_REQUIRED        = 0x08000000U,
    SI_VIEW_ONLY                       = 0x00400000U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/aclui/ne-aclui-si_page_type
alias SI_PAGE_TYPE = int;
enum : int
{
    SI_PAGE_PERM          = 0x00000000,
    SI_PAGE_ADVPERM       = 0x00000001,
    SI_PAGE_AUDIT         = 0x00000002,
    SI_PAGE_OWNER         = 0x00000003,
    SI_PAGE_EFFECTIVE     = 0x00000004,
    SI_PAGE_TAKEOWNERSHIP = 0x00000005,
    SI_PAGE_SHARE         = 0x00000006,
}

alias SI_PAGE_ACTIVATED = int;
enum : int
{
    SI_SHOW_DEFAULT                  = 0x00000000,
    SI_SHOW_PERM_ACTIVATED           = 0x00000001,
    SI_SHOW_AUDIT_ACTIVATED          = 0x00000002,
    SI_SHOW_OWNER_ACTIVATED          = 0x00000003,
    SI_SHOW_EFFECTIVE_ACTIVATED      = 0x00000004,
    SI_SHOW_SHARE_ACTIVATED          = 0x00000005,
    SI_SHOW_CENTRAL_POLICY_ACTIVATED = 0x00000006,
}

// Constants


enum : int
{
    SI_EDIT_PERMS = 0x00000000,
    SI_EDIT_OWNER = 0x00000001,
}

enum int SI_CONTAINER = 0x00000004;

enum : int
{
    SI_READONLY = 0x00000008,
    SI_RESET    = 0x00000020,
}

enum : int
{
    SI_OWNER_READONLY = 0x00000040,
    SI_OWNER_RECURSE  = 0x00000100,
}

enum int SI_NO_ACL_PROTECT = 0x00000200;
enum int SI_NO_TREE_APPLY = 0x00000400;
enum int SI_PAGE_TITLE = 0x00000800;
enum int SI_SERVER_IS_DC = 0x00001000;

enum : int
{
    SI_RESET_DACL_TREE = 0x00004000,
    SI_RESET_SACL_TREE = 0x00008000,
}

enum int SI_OBJECT_GUID = 0x00010000;

enum : int
{
    SI_ACCESS_SPECIFIC  = 0x00010000,
    SI_ACCESS_GENERAL   = 0x00020000,
    SI_ACCESS_CONTAINER = 0x00040000,
    SI_ACCESS_PROPERTY  = 0x00080000,
}

enum : int
{
    DOBJ_RES_CONT = 0x00000001,
    DOBJ_RES_ROOT = 0x00000002,
}

enum int DOBJ_VOL_NTACLS = 0x00000004;
enum int DOBJ_COND_NTACLS = 0x00000008;
enum int DOBJ_RIBBON_LAUNCH = 0x00000010;
enum const(wchar)* CFSTR_ACLUI_SID_INFO_LIST = "CFSTR_ACLUI_SID_INFO_LIST";

enum : uint
{
    SECURITY_OBJECT_ID_OBJECT_SD           = 0x00000001U,
    SECURITY_OBJECT_ID_SHARE               = 0x00000002U,
    SECURITY_OBJECT_ID_CENTRAL_POLICY      = 0x00000003U,
    SECURITY_OBJECT_ID_CENTRAL_ACCESS_RULE = 0x00000004U,
}

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/aclui/ns-aclui-si_object_info
struct SI_OBJECT_INFO
{
    SI_OBJECT_INFO_FLAGS dwFlags;
    HINSTANCE            hInstance;
    PWSTR                pszServerName;
    PWSTR                pszObjectName;
    PWSTR                pszPageTitle;
    GUID                 guidObjectType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/aclui/ns-aclui-si_access
struct SI_ACCESS
{
    const(GUID)* pguid;
    uint         mask;
    const(PWSTR) pszName;
    uint         dwFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/aclui/ns-aclui-si_inherit_type
struct SI_INHERIT_TYPE
{
    const(GUID)* pguid;
    ACE_FLAGS    dwFlags;
    const(PWSTR) pszName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/aclui/ns-aclui-sid_info
struct SID_INFO
{
    PSID  pSid;
    PWSTR pwzCommonName;
    PWSTR pwzClass;
    PWSTR pwzUPN;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/aclui/ns-aclui-sid_info_list
struct SID_INFO_LIST
{
    uint        cItems;
    SID_INFO[1] aSidInfo; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/aclui/ns-aclui-security_object
struct SECURITY_OBJECT
{
    PWSTR   pwszName;
    void*   pData;
    uint    cbData;
    void*   pData2;
    uint    cbData2;
    uint    Id;
    BOOLEAN fWellKnown;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/aclui/ns-aclui-effperm_result_list
struct EFFPERM_RESULT_LIST
{
    BOOLEAN           fEvaluated;
    uint              cObjectTypeListLength;
    OBJECT_TYPE_LIST* pObjectTypeList;
    uint*             pGrantedAccessList;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ACLUI.dll")
HPROPSHEETPAGE CreateSecurityPage(ISecurityInformation psi);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ACLUI.dll")
BOOL EditSecurity(HWND hwndOwner, ISecurityInformation psi);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ACLUI.dll")
HRESULT EditSecurityAdvanced(HWND hwndOwner, ISecurityInformation psi, SI_PAGE_TYPE uSIPage);


// Interfaces

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/aclui/nn-aclui-isecurityinformation
@GUID("965fc360-16ff-11d0-91cb-00aa00bbb723")
interface ISecurityInformation : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/aclui/nf-aclui-isecurityinformation-getobjectinformation
    HRESULT GetObjectInformation(SI_OBJECT_INFO* pObjectInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/aclui/nf-aclui-isecurityinformation-getsecurity
    HRESULT GetSecurity(OBJECT_SECURITY_INFORMATION RequestedInformation, 
                        PSECURITY_DESCRIPTOR* ppSecurityDescriptor, BOOL fDefault);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/aclui/nf-aclui-isecurityinformation-setsecurity
    HRESULT SetSecurity(OBJECT_SECURITY_INFORMATION SecurityInformation, PSECURITY_DESCRIPTOR pSecurityDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/aclui/nf-aclui-isecurityinformation-getaccessrights
    HRESULT GetAccessRights(const(GUID)* pguidObjectType, SECURITY_INFO_PAGE_FLAGS dwFlags, SI_ACCESS** ppAccess, 
                            uint* pcAccesses, uint* piDefaultAccess);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/aclui/nf-aclui-isecurityinformation-mapgeneric
    HRESULT MapGeneric(const(GUID)* pguidObjectType, ubyte* pAceFlags, uint* pMask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/aclui/nf-aclui-isecurityinformation-getinherittypes
    HRESULT GetInheritTypes(SI_INHERIT_TYPE** ppInheritTypes, uint* pcInheritTypes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/aclui/nf-aclui-isecurityinformation-propertysheetpagecallback
    HRESULT PropertySheetPageCallback(HWND hwnd, PSPCB_MESSAGE uMsg, SI_PAGE_TYPE uPage);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/aclui/nn-aclui-isecurityinformation2
@GUID("c3ccfdb4-6f88-11d2-a3ce-00c04fb1782a")
interface ISecurityInformation2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/aclui/nf-aclui-isecurityinformation2-isdaclcanonical
    BOOL    IsDaclCanonical(ACL* pDacl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/aclui/nf-aclui-isecurityinformation2-lookupsids
    HRESULT LookupSids(uint cSids, PSID* rgpSids, IDataObject* ppdo);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/aclui/nn-aclui-ieffectivepermission
@GUID("3853dc76-9f35-407c-88a1-d19344365fbc")
interface IEffectivePermission : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/aclui/nf-aclui-ieffectivepermission-geteffectivepermission
    HRESULT GetEffectivePermission(const(GUID)* pguidObjectType, PSID pUserSid, const(PWSTR) pszServerName, 
                                   PSECURITY_DESCRIPTOR pSD, OBJECT_TYPE_LIST** ppObjectTypeList, 
                                   uint* pcObjectTypeListLength, uint** ppGrantedAccessList, 
                                   uint* pcGrantedAccessListLength);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/aclui/nn-aclui-isecurityobjecttypeinfo
@GUID("fc3066eb-79ef-444b-9111-d18a75ebf2fa")
interface ISecurityObjectTypeInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/aclui/nf-aclui-isecurityobjecttypeinfo-getinheritsource
    HRESULT GetInheritSource(uint si, ACL* pACL, INHERITED_FROMA** ppInheritArray);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/aclui/nn-aclui-isecurityinformation3
@GUID("e2cdc9cc-31bd-4f8f-8c8b-b641af516a1a")
interface ISecurityInformation3 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/aclui/nf-aclui-isecurityinformation3-getfullresourcename
    HRESULT GetFullResourceName(PWSTR* ppszResourceName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/aclui/nf-aclui-isecurityinformation3-openelevatededitor
    HRESULT OpenElevatedEditor(HWND hWnd, SI_PAGE_TYPE uPage);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/aclui/nn-aclui-isecurityinformation4
@GUID("ea961070-cd14-4621-ace4-f63c03e583e4")
interface ISecurityInformation4 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/aclui/nf-aclui-isecurityinformation4-getsecondarysecurity
    HRESULT GetSecondarySecurity(SECURITY_OBJECT** pSecurityObjects, uint* pSecurityObjectCount);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/aclui/nn-aclui-ieffectivepermission2
@GUID("941fabca-dd47-4fca-90bb-b0e10255f20d")
interface IEffectivePermission2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/aclui/nf-aclui-ieffectivepermission2-computeeffectivepermissionwithsecondarysecurity
    HRESULT ComputeEffectivePermissionWithSecondarySecurity(PSID pSid, PSID pDeviceSid, const(PWSTR) pszServerName, 
                                                            SECURITY_OBJECT* pSecurityObjects, 
                                                            uint dwSecurityObjectCount, TOKEN_GROUPS* pUserGroups, 
                                                            AUTHZ_SID_OPERATION* pAuthzUserGroupsOperations, 
                                                            TOKEN_GROUPS* pDeviceGroups, 
                                                            AUTHZ_SID_OPERATION* pAuthzDeviceGroupsOperations, 
                                                            AUTHZ_SECURITY_ATTRIBUTES_INFORMATION* pAuthzUserClaims, 
                                                            AUTHZ_SECURITY_ATTRIBUTE_OPERATION* pAuthzUserClaimsOperations, 
                                                            AUTHZ_SECURITY_ATTRIBUTES_INFORMATION* pAuthzDeviceClaims, 
                                                            AUTHZ_SECURITY_ATTRIBUTE_OPERATION* pAuthzDeviceClaimsOperations, 
                                                            EFFPERM_RESULT_LIST* pEffpermResultLists);
}


// GUIDs


const GUID IID_IEffectivePermission    = GUIDOF!IEffectivePermission;
const GUID IID_IEffectivePermission2   = GUIDOF!IEffectivePermission2;
const GUID IID_ISecurityInformation    = GUIDOF!ISecurityInformation;
const GUID IID_ISecurityInformation2   = GUIDOF!ISecurityInformation2;
const GUID IID_ISecurityInformation3   = GUIDOF!ISecurityInformation3;
const GUID IID_ISecurityInformation4   = GUIDOF!ISecurityInformation4;
const GUID IID_ISecurityObjectTypeInfo = GUIDOF!ISecurityObjectTypeInfo;
