// Written in the D programming language.

module windows.win32.system.transactionserver;

public import windows.core;
public import windows.win32.foundation.foundation : BSTR, HRESULT;
public import windows.win32.system.com.com : IDispatch, SAFEARRAY;

extern(Windows) @nogc nothrow:


// Enums


enum MTSPackageInstallOptions : int
{
    mtsInstallUsers = 0x00000001,
}

enum MTSPackageExportOptions : int
{
    mtsExportUsers = 0x00000001,
}

enum MTSAdminErrorCodes : int
{
    mtsErrObjectErrors           = 0x80110401,
    mtsErrObjectInvalid          = 0x80110402,
    mtsErrKeyMissing             = 0x80110403,
    mtsErrAlreadyInstalled       = 0x80110404,
    mtsErrDownloadFailed         = 0x80110405,
    mtsErrPDFWriteFail           = 0x80110407,
    mtsErrPDFReadFail            = 0x80110408,
    mtsErrPDFVersion             = 0x80110409,
    mtsErrCoReqCompInstalled     = 0x80110410,
    mtsErrBadPath                = 0x8011040a,
    mtsErrPackageExists          = 0x8011040b,
    mtsErrRoleExists             = 0x8011040c,
    mtsErrCantCopyFile           = 0x8011040d,
    mtsErrNoTypeLib              = 0x8011040e,
    mtsErrNoUser                 = 0x8011040f,
    mtsErrInvalidUserids         = 0x80110410,
    mtsErrNoRegistryCLSID        = 0x80110411,
    mtsErrBadRegistryProgID      = 0x80110412,
    mtsErrAuthenticationLevel    = 0x80110413,
    mtsErrUserPasswdNotValid     = 0x80110414,
    mtsErrNoRegistryRead         = 0x80110415,
    mtsErrNoRegistryWrite        = 0x80110416,
    mtsErrNoRegistryRepair       = 0x80110417,
    mtsErrCLSIDOrIIDMismatch     = 0x80110418,
    mtsErrRemoteInterface        = 0x80110419,
    mtsErrDllRegisterServer      = 0x8011041a,
    mtsErrNoServerShare          = 0x8011041b,
    mtsErrNoAccessToUNC          = 0x8011041c,
    mtsErrDllLoadFailed          = 0x8011041d,
    mtsErrBadRegistryLibID       = 0x8011041e,
    mtsErrPackDirNotFound        = 0x8011041f,
    mtsErrTreatAs                = 0x80110420,
    mtsErrBadForward             = 0x80110421,
    mtsErrBadIID                 = 0x80110422,
    mtsErrRegistrarFailed        = 0x80110423,
    mtsErrCompFileDoesNotExist   = 0x80110424,
    mtsErrCompFileLoadDLLFail    = 0x80110425,
    mtsErrCompFileGetClassObj    = 0x80110426,
    mtsErrCompFileClassNotAvail  = 0x80110427,
    mtsErrCompFileBadTLB         = 0x80110428,
    mtsErrCompFileNotInstallable = 0x80110429,
    mtsErrNotChangeable          = 0x8011042a,
    mtsErrNotDeletable           = 0x8011042b,
    mtsErrSession                = 0x8011042c,
    mtsErrCompFileNoRegistrar    = 0x80110434,
}

// Interfaces

@GUID("6eb22881-8a19-11d0-81b6-00a0c9231c29")
struct Catalog;

@GUID("6eb22882-8a19-11d0-81b6-00a0c9231c29")
struct CatalogObject;

@GUID("6eb22883-8a19-11d0-81b6-00a0c9231c29")
struct CatalogCollection;

@GUID("6eb22884-8a19-11d0-81b6-00a0c9231c29")
struct ComponentUtil;

@GUID("6eb22885-8a19-11d0-81b6-00a0c9231c29")
struct PackageUtil;

@GUID("6eb22886-8a19-11d0-81b6-00a0c9231c29")
struct RemoteComponentUtil;

@GUID("6eb22887-8a19-11d0-81b6-00a0c9231c29")
struct RoleAssociationUtil;

@GUID("6eb22870-8a19-11d0-81b6-00a0c9231c29")
interface ICatalog : IDispatch
{
    HRESULT GetCollection(BSTR bstrCollName, IDispatch* ppCatalogCollection);
    HRESULT Connect(BSTR bstrConnectString, IDispatch* ppCatalogCollection);
    HRESULT get_MajorVersion(int* retval);
    HRESULT get_MinorVersion(int* retval);
}

@GUID("6eb22873-8a19-11d0-81b6-00a0c9231c29")
interface IComponentUtil : IDispatch
{
    HRESULT InstallComponent(BSTR bstrDLLFile, BSTR bstrTypelibFile, BSTR bstrProxyStubDLLFile);
    HRESULT ImportComponent(BSTR bstrCLSID);
    HRESULT ImportComponentByName(BSTR bstrProgID);
    HRESULT GetCLSIDs(BSTR bstrDLLFile, BSTR bstrTypelibFile, SAFEARRAY** aCLSIDs);
}

@GUID("6eb22874-8a19-11d0-81b6-00a0c9231c29")
interface IPackageUtil : IDispatch
{
    HRESULT InstallPackage(BSTR bstrPackageFile, BSTR bstrInstallPath, int lOptions);
    HRESULT ExportPackage(BSTR bstrPackageID, BSTR bstrPackageFile, int lOptions);
    HRESULT ShutdownPackage(BSTR bstrPackageID);
}

@GUID("6eb22875-8a19-11d0-81b6-00a0c9231c29")
interface IRemoteComponentUtil : IDispatch
{
    HRESULT InstallRemoteComponent(BSTR bstrServer, BSTR bstrPackageID, BSTR bstrCLSID);
    HRESULT InstallRemoteComponentByName(BSTR bstrServer, BSTR bstrPackageName, BSTR bstrProgID);
}

@GUID("6eb22876-8a19-11d0-81b6-00a0c9231c29")
interface IRoleAssociationUtil : IDispatch
{
    HRESULT AssociateRole(BSTR bstrRoleID);
    HRESULT AssociateRoleByName(BSTR bstrRoleName);
}


// GUIDs

const GUID CLSID_Catalog             = GUIDOF!Catalog;
const GUID CLSID_CatalogCollection   = GUIDOF!CatalogCollection;
const GUID CLSID_CatalogObject       = GUIDOF!CatalogObject;
const GUID CLSID_ComponentUtil       = GUIDOF!ComponentUtil;
const GUID CLSID_PackageUtil         = GUIDOF!PackageUtil;
const GUID CLSID_RemoteComponentUtil = GUIDOF!RemoteComponentUtil;
const GUID CLSID_RoleAssociationUtil = GUIDOF!RoleAssociationUtil;

const GUID IID_ICatalog             = GUIDOF!ICatalog;
const GUID IID_IComponentUtil       = GUIDOF!IComponentUtil;
const GUID IID_IPackageUtil         = GUIDOF!IPackageUtil;
const GUID IID_IRemoteComponentUtil = GUIDOF!IRemoteComponentUtil;
const GUID IID_IRoleAssociationUtil = GUIDOF!IRoleAssociationUtil;
