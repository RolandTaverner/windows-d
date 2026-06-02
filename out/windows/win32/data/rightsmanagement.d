// Written in the D programming language.

module windows.win32.data.rightsmanagement;

public import windows.core;
public import windows.win32.foundation : BOOL, FARPROC, HRESULT, HWND, PWSTR, SYSTEMTIME;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrmdefs/ne-msdrmdefs-drmtimetype
alias DRMTIMETYPE = int;
enum : int
{
    DRMTIMETYPE_SYSTEMUTC   = 0x00000000,
    DRMTIMETYPE_SYSTEMLOCAL = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrmdefs/ne-msdrmdefs-drmencodingtype
alias DRMENCODINGTYPE = int;
enum : int
{
    DRMENCODINGTYPE_BASE64 = 0x00000000,
    DRMENCODINGTYPE_STRING = 0x00000001,
    DRMENCODINGTYPE_LONG   = 0x00000002,
    DRMENCODINGTYPE_TIME   = 0x00000003,
    DRMENCODINGTYPE_UINT   = 0x00000004,
    DRMENCODINGTYPE_RAW    = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrmdefs/ne-msdrmdefs-drmattesttype
alias DRMATTESTTYPE = int;
enum : int
{
    DRMATTESTTYPE_FULLENVIRONMENT = 0x00000000,
    DRMATTESTTYPE_HASHONLY        = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrmdefs/ne-msdrmdefs-drmspectype
alias DRMSPECTYPE = int;
enum : int
{
    DRMSPECTYPE_UNKNOWN  = 0x00000000,
    DRMSPECTYPE_FILENAME = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrmdefs/ne-msdrmdefs-drmsecurityprovidertype
alias DRMSECURITYPROVIDERTYPE = int;
enum : int
{
    DRMSECURITYPROVIDERTYPE_SOFTWARESECREP = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrmdefs/ne-msdrmdefs-drmglobaloptions
alias DRMGLOBALOPTIONS = int;
enum : int
{
    DRMGLOBALOPTIONS_USE_WINHTTP                 = 0x00000000,
    DRMGLOBALOPTIONS_USE_SERVERSECURITYPROCESSOR = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrmdefs/ne-msdrmdefs-drm_status_msg
alias DRM_STATUS_MSG = int;
enum : int
{
    DRM_MSG_ACTIVATE_MACHINE                  = 0x00000000,
    DRM_MSG_ACTIVATE_GROUPIDENTITY            = 0x00000001,
    DRM_MSG_ACQUIRE_LICENSE                   = 0x00000002,
    DRM_MSG_ACQUIRE_ADVISORY                  = 0x00000003,
    DRM_MSG_SIGN_ISSUANCE_LICENSE             = 0x00000004,
    DRM_MSG_ACQUIRE_CLIENTLICENSOR            = 0x00000005,
    DRM_MSG_ACQUIRE_ISSUANCE_LICENSE_TEMPLATE = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrmdefs/ne-msdrmdefs-drm_usagepolicy_type
alias DRM_USAGEPOLICY_TYPE = int;
enum : int
{
    DRM_USAGEPOLICY_TYPE_BYNAME      = 0x00000000,
    DRM_USAGEPOLICY_TYPE_BYPUBLICKEY = 0x00000001,
    DRM_USAGEPOLICY_TYPE_BYDIGEST    = 0x00000002,
    DRM_USAGEPOLICY_TYPE_OSEXCLUSION = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrmdefs/ne-msdrmdefs-drm_distribution_point_info
alias DRM_DISTRIBUTION_POINT_INFO = int;
enum : int
{
    DRM_DISTRIBUTION_POINT_LICENSE_ACQUISITION = 0x00000000,
    DRM_DISTRIBUTION_POINT_PUBLISHING          = 0x00000001,
    DRM_DISTRIBUTION_POINT_REFERRAL_INFO       = 0x00000002,
}

// Constants


enum uint DRMHANDLE_INVALID = 0x00000000U;
enum uint DRMENVHANDLE_INVALID = 0x00000000U;
enum uint DRMQUERYHANDLE_INVALID = 0x00000000U;
enum uint DRMHSESSION_INVALID = 0x00000000U;
enum uint DRMPUBHANDLE_INVALID = 0x00000000U;

enum : uint
{
    DRM_AL_NONSILENT       = 0x00000001U,
    DRM_AL_NOPERSIST       = 0x00000002U,
    DRM_AL_CANCEL          = 0x00000004U,
    DRM_AL_FETCHNOADVISORY = 0x00000008U,
}

enum : uint
{
    DRM_AL_NOUI                       = 0x00000010U,
    DRM_ACTIVATE_MACHINE              = 0x00000001U,
    DRM_ACTIVATE_GROUPIDENTITY        = 0x00000002U,
    DRM_ACTIVATE_TEMPORARY            = 0x00000004U,
    DRM_ACTIVATE_CANCEL               = 0x00000008U,
    DRM_ACTIVATE_SILENT               = 0x00000010U,
    DRM_ACTIVATE_SHARED_GROUPIDENTITY = 0x00000020U,
}

enum uint DRM_ACTIVATE_DELAYED = 0x00000040U;

enum : uint
{
    DRM_EL_MACHINE            = 0x00000001U,
    DRM_EL_GROUPIDENTITY      = 0x00000002U,
    DRM_EL_GROUPIDENTITY_NAME = 0x00000004U,
    DRM_EL_GROUPIDENTITY_LID  = 0x00000008U,
}

enum uint DRM_EL_SPECIFIED_GROUPIDENTITY = 0x00000010U;

enum : uint
{
    DRM_EL_EUL                = 0x00000020U,
    DRM_EL_EUL_LID            = 0x00000040U,
    DRM_EL_CLIENTLICENSOR     = 0x00000080U,
    DRM_EL_CLIENTLICENSOR_LID = 0x00000100U,
}

enum uint DRM_EL_SPECIFIED_CLIENTLICENSOR = 0x00000200U;

enum : uint
{
    DRM_EL_REVOCATIONLIST     = 0x00000400U,
    DRM_EL_REVOCATIONLIST_LID = 0x00000800U,
}

enum : uint
{
    DRM_EL_EXPIRED                      = 0x00001000U,
    DRM_EL_ISSUERNAME                   = 0x00002000U,
    DRM_EL_ISSUANCELICENSE_TEMPLATE     = 0x00004000U,
    DRM_EL_ISSUANCELICENSE_TEMPLATE_LID = 0x00008000U,
}

enum : uint
{
    DRM_ADD_LICENSE_NOPERSIST = 0x00000000U,
    DRM_ADD_LICENSE_PERSIST   = 0x00000001U,
}

enum : uint
{
    DRM_SERVICE_TYPE_ACTIVATION     = 0x00000001U,
    DRM_SERVICE_TYPE_CERTIFICATION  = 0x00000002U,
    DRM_SERVICE_TYPE_PUBLISHING     = 0x00000004U,
    DRM_SERVICE_TYPE_CLIENTLICENSOR = 0x00000008U,
    DRM_SERVICE_TYPE_SILENT         = 0x00000010U,
    DRM_SERVICE_LOCATION_INTERNET   = 0x00000001U,
    DRM_SERVICE_LOCATION_ENTERPRISE = 0x00000002U,
}

enum : const(wchar)*
{
    DRM_DEFAULTGROUPIDTYPE_WINDOWSAUTH = "WindowsAuthProvider",
    DRM_DEFAULTGROUPIDTYPE_PASSPORT    = "PassportAuthProvider",
}

enum : uint
{
    DRM_SIGN_ONLINE  = 0x00000001U,
    DRM_SIGN_OFFLINE = 0x00000002U,
    DRM_SIGN_CANCEL  = 0x00000004U,
}

enum uint DRM_SERVER_ISSUANCELICENSE = 0x00000008U;
enum uint DRM_AUTO_GENERATE_KEY = 0x00000010U;
enum uint DRM_OWNER_LICENSE_NOPERSIST = 0x00000020U;
enum uint DRM_REUSE_KEY = 0x00000040U;

enum : uint
{
    DRM_LOCKBOXTYPE_NONE     = 0x00000000U,
    DRM_LOCKBOXTYPE_WHITEBOX = 0x00000001U,
    DRM_LOCKBOXTYPE_BLACKBOX = 0x00000002U,
    DRM_LOCKBOXTYPE_DEFAULT  = 0x00000002U,
}

enum : uint
{
    DRM_AILT_NONSILENT  = 0x00000001U,
    DRM_AILT_OBTAIN_ALL = 0x00000002U,
    DRM_AILT_CANCEL     = 0x00000004U,
}

enum uint MSDRM_CLIENT_ZONE = 0x0000cf00U;
enum uint MSDRM_POLICY_ZONE = 0x00009300U;
enum uint DRMIDVERSION = 0x00000000U;
enum uint DRMBOUNDLICENSEPARAMSVERSION = 0x00000001U;
enum uint DRMBINDINGFLAGS_IGNORE_VALIDITY_INTERVALS = 0x00000001U;
enum uint DRMLICENSEACQDATAVERSION = 0x00000000U;
enum uint DRMACTSERVINFOVERSION = 0x00000000U;
enum uint DRMCLIENTSTRUCTVERSION = 0x00000001U;
enum uint DRMCALLBACKVERSION = 0x00000001U;

// Callbacks

alias DRMCALLBACK = HRESULT function(DRM_STATUS_MSG param0, HRESULT param1, void* param2, void* param3);

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrmdefs/ns-msdrmdefs-drmid
struct DRMID
{
    uint  uVersion;
    PWSTR wszIDType;
    PWSTR wszID;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrmdefs/ns-msdrmdefs-drmboundlicenseparams
struct DRMBOUNDLICENSEPARAMS
{
    uint  uVersion;
    uint  hEnablingPrincipal;
    uint  hSecureStore;
    PWSTR wszRightsRequested;
    PWSTR wszRightsGroup;
    DRMID idResource;
    uint  cAuthenticatorCount;
    uint* rghAuthenticators;
    PWSTR wszDefaultEnablingPrincipalCredentials;
    uint  dwFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrmdefs/ns-msdrmdefs-drm_license_acq_data
struct DRM_LICENSE_ACQ_DATA
{
    uint   uVersion;
    PWSTR  wszURL;
    PWSTR  wszLocalFilename;
    ubyte* pbPostData;
    uint   dwPostDataSize;
    PWSTR  wszFriendlyName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrmdefs/ns-msdrmdefs-drm_actserv_info
struct DRM_ACTSERV_INFO
{
    uint  uVersion;
    PWSTR wszPubKey;
    PWSTR wszURL;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrmdefs/ns-msdrmdefs-drm_client_version_info
struct DRM_CLIENT_VERSION_INFO
{
    uint       uStructVersion;
    uint[4]    dwVersion;
    wchar[256] wszHierarchy;
    wchar[256] wszProductId;
    wchar[256] wszProductDescription;
}

// Functions

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmsetglobaloptions
@DllImport("msdrm.dll")
HRESULT DRMSetGlobalOptions(DRMGLOBALOPTIONS eGlobalOptions, void* pvdata, uint dwlen);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmgetclientversion
@DllImport("msdrm.dll")
HRESULT DRMGetClientVersion(DRM_CLIENT_VERSION_INFO* pDRMClientVersionInfo);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drminitenvironment
@DllImport("msdrm.dll")
HRESULT DRMInitEnvironment(DRMSECURITYPROVIDERTYPE eSecurityProviderType, DRMSPECTYPE eSpecification, 
                           PWSTR wszSecurityProvider, PWSTR wszManifestCredentials, PWSTR wszMachineCredentials, 
                           uint* phEnv, uint* phDefaultLibrary);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmloadlibrary
@DllImport("msdrm.dll")
HRESULT DRMLoadLibrary(uint hEnv, DRMSPECTYPE eSpecification, PWSTR wszLibraryProvider, PWSTR wszCredentials, 
                       uint* phLibrary);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmcreateenablingprincipal
@DllImport("msdrm.dll")
HRESULT DRMCreateEnablingPrincipal(uint hEnv, uint hLibrary, PWSTR wszObject, DRMID* pidPrincipal, 
                                   PWSTR wszCredentials, uint* phEnablingPrincipal);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmclosehandle
@DllImport("msdrm.dll")
HRESULT DRMCloseHandle(uint handle);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmcloseenvironmenthandle
@DllImport("msdrm.dll")
HRESULT DRMCloseEnvironmentHandle(uint hEnv);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmduplicatehandle
@DllImport("msdrm.dll")
HRESULT DRMDuplicateHandle(uint hToCopy, uint* phCopy);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmduplicateenvironmenthandle
@DllImport("msdrm.dll")
HRESULT DRMDuplicateEnvironmentHandle(uint hToCopy, uint* phCopy);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmregisterrevocationlist
@DllImport("msdrm.dll")
HRESULT DRMRegisterRevocationList(uint hEnv, PWSTR wszRevocationList);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmchecksecurity
@DllImport("msdrm.dll")
HRESULT DRMCheckSecurity(uint hEnv, uint cLevel);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmregistercontent
@DllImport("msdrm.dll")
HRESULT DRMRegisterContent(BOOL fRegister);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmencrypt
@DllImport("msdrm.dll")
HRESULT DRMEncrypt(uint hCryptoProvider, uint iPosition, uint cNumInBytes, ubyte* pbInData, uint* pcNumOutBytes, 
                   ubyte* pbOutData);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmdecrypt
@DllImport("msdrm.dll")
HRESULT DRMDecrypt(uint hCryptoProvider, uint iPosition, uint cNumInBytes, ubyte* pbInData, uint* pcNumOutBytes, 
                   ubyte* pbOutData);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmcreateboundlicense
@DllImport("msdrm.dll")
HRESULT DRMCreateBoundLicense(uint hEnv, DRMBOUNDLICENSEPARAMS* pParams, PWSTR wszLicenseChain, 
                              uint* phBoundLicense, uint* phErrorLog);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmcreateenablingbitsdecryptor
@DllImport("msdrm.dll")
HRESULT DRMCreateEnablingBitsDecryptor(uint hBoundLicense, PWSTR wszRight, uint hAuxLib, PWSTR wszAuxPlug, 
                                       uint* phDecryptor);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmcreateenablingbitsencryptor
@DllImport("msdrm.dll")
HRESULT DRMCreateEnablingBitsEncryptor(uint hBoundLicense, PWSTR wszRight, uint hAuxLib, PWSTR wszAuxPlug, 
                                       uint* phEncryptor);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmattest
@DllImport("msdrm.dll")
HRESULT DRMAttest(uint hEnablingPrincipal, PWSTR wszData, DRMATTESTTYPE eType, uint* pcAttestedBlob, 
                  PWSTR wszAttestedBlob);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmgettime
@DllImport("msdrm.dll")
HRESULT DRMGetTime(uint hEnv, DRMTIMETYPE eTimerIdType, SYSTEMTIME* poTimeObject);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmgetinfo
@DllImport("msdrm.dll")
HRESULT DRMGetInfo(uint handle, PWSTR wszAttribute, DRMENCODINGTYPE* peEncoding, uint* pcBuffer, ubyte* pbBuffer);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmgetenvironmentinfo
@DllImport("msdrm.dll")
HRESULT DRMGetEnvironmentInfo(uint handle, PWSTR wszAttribute, DRMENCODINGTYPE* peEncoding, uint* pcBuffer, 
                              ubyte* pbBuffer);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmgetprocaddress
@DllImport("msdrm.dll")
HRESULT DRMGetProcAddress(uint hLibrary, PWSTR wszProcName, FARPROC* ppfnProcAddress);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmgetboundlicenseobjectcount
@DllImport("msdrm.dll")
HRESULT DRMGetBoundLicenseObjectCount(uint hQueryRoot, PWSTR wszSubObjectType, uint* pcSubObjects);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmgetboundlicenseobject
@DllImport("msdrm.dll")
HRESULT DRMGetBoundLicenseObject(uint hQueryRoot, PWSTR wszSubObjectType, uint iWhich, uint* phSubObject);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmgetboundlicenseattributecount
@DllImport("msdrm.dll")
HRESULT DRMGetBoundLicenseAttributeCount(uint hQueryRoot, PWSTR wszAttribute, uint* pcAttributes);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmgetboundlicenseattribute
@DllImport("msdrm.dll")
HRESULT DRMGetBoundLicenseAttribute(uint hQueryRoot, PWSTR wszAttribute, uint iWhich, DRMENCODINGTYPE* peEncoding, 
                                    uint* pcBuffer, ubyte* pbBuffer);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmcreateclientsession
@DllImport("msdrm.dll")
HRESULT DRMCreateClientSession(DRMCALLBACK pfnCallback, uint uCallbackVersion, PWSTR wszGroupIDProviderType, 
                               PWSTR wszGroupID, uint* phClient);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmisactivated
@DllImport("msdrm.dll")
HRESULT DRMIsActivated(uint hClient, uint uFlags, DRM_ACTSERV_INFO* pActServInfo);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmactivate
@DllImport("msdrm.dll")
HRESULT DRMActivate(uint hClient, uint uFlags, uint uLangID, DRM_ACTSERV_INFO* pActServInfo, void* pvContext, 
                    HWND hParentWnd);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmgetservicelocation
@DllImport("msdrm.dll")
HRESULT DRMGetServiceLocation(uint hClient, uint uServiceType, uint uServiceLocation, PWSTR wszIssuanceLicense, 
                              uint* puServiceURLLength, PWSTR wszServiceURL);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmcreatelicensestoragesession
@DllImport("msdrm.dll")
HRESULT DRMCreateLicenseStorageSession(uint hEnv, uint hDefaultLibrary, uint hClient, uint uFlags, 
                                       PWSTR wszIssuanceLicense, uint* phLicenseStorage);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmaddlicense
@DllImport("msdrm.dll")
HRESULT DRMAddLicense(uint hLicenseStorage, uint uFlags, PWSTR wszLicense);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmacquireadvisories
@DllImport("msdrm.dll")
HRESULT DRMAcquireAdvisories(uint hLicenseStorage, PWSTR wszLicense, PWSTR wszURL, void* pvContext);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmenumeratelicense
@DllImport("msdrm.dll")
HRESULT DRMEnumerateLicense(uint hSession, uint uFlags, uint uIndex, BOOL* pfSharedFlag, 
                            uint* puCertificateDataLen, PWSTR wszCertificateData);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmacquirelicense
@DllImport("msdrm.dll")
HRESULT DRMAcquireLicense(uint hSession, uint uFlags, PWSTR wszGroupIdentityCredential, PWSTR wszRequestedRights, 
                          PWSTR wszCustomData, PWSTR wszURL, void* pvContext);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmdeletelicense
@DllImport("msdrm.dll")
HRESULT DRMDeleteLicense(uint hSession, PWSTR wszLicenseId);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmclosesession
@DllImport("msdrm.dll")
HRESULT DRMCloseSession(uint hSession);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmduplicatesession
@DllImport("msdrm.dll")
HRESULT DRMDuplicateSession(uint hSessionIn, uint* phSessionOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmgetsecurityprovider
@DllImport("msdrm.dll")
HRESULT DRMGetSecurityProvider(uint uFlags, uint* puTypeLen, PWSTR wszType, uint* puPathLen, PWSTR wszPath);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmencode
@DllImport("msdrm.dll")
HRESULT DRMEncode(PWSTR wszAlgID, uint uDataLen, ubyte* pbDecodedData, uint* puEncodedStringLen, 
                  PWSTR wszEncodedString);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmdecode
@DllImport("msdrm.dll")
HRESULT DRMDecode(PWSTR wszAlgID, PWSTR wszEncodedString, uint* puDecodedDataLen, ubyte* pbDecodedData);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmconstructcertificatechain
@DllImport("msdrm.dll")
HRESULT DRMConstructCertificateChain(uint cCertificates, PWSTR* rgwszCertificates, uint* pcChain, PWSTR wszChain);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmparseunboundlicense
@DllImport("msdrm.dll")
HRESULT DRMParseUnboundLicense(PWSTR wszCertificate, uint* phQueryRoot);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmclosequeryhandle
@DllImport("msdrm.dll")
HRESULT DRMCloseQueryHandle(uint hQuery);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmgetunboundlicenseobjectcount
@DllImport("msdrm.dll")
HRESULT DRMGetUnboundLicenseObjectCount(uint hQueryRoot, PWSTR wszSubObjectType, uint* pcSubObjects);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmgetunboundlicenseobject
@DllImport("msdrm.dll")
HRESULT DRMGetUnboundLicenseObject(uint hQueryRoot, PWSTR wszSubObjectType, uint iIndex, uint* phSubQuery);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmgetunboundlicenseattributecount
@DllImport("msdrm.dll")
HRESULT DRMGetUnboundLicenseAttributeCount(uint hQueryRoot, PWSTR wszAttributeType, uint* pcAttributes);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmgetunboundlicenseattribute
@DllImport("msdrm.dll")
HRESULT DRMGetUnboundLicenseAttribute(uint hQueryRoot, PWSTR wszAttributeType, uint iWhich, 
                                      DRMENCODINGTYPE* peEncoding, uint* pcBuffer, ubyte* pbBuffer);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmgetcertificatechaincount
@DllImport("msdrm.dll")
HRESULT DRMGetCertificateChainCount(PWSTR wszChain, uint* pcCertCount);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmdeconstructcertificatechain
@DllImport("msdrm.dll")
HRESULT DRMDeconstructCertificateChain(PWSTR wszChain, uint iWhich, uint* pcCert, PWSTR wszCert);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmverify
@DllImport("msdrm.dll")
HRESULT DRMVerify(PWSTR wszData, uint* pcAttestedData, PWSTR wszAttestedData, DRMATTESTTYPE* peType, 
                  uint* pcPrincipal, PWSTR wszPrincipal, uint* pcManifest, PWSTR wszManifest);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmcreateuser
@DllImport("msdrm.dll")
HRESULT DRMCreateUser(PWSTR wszUserName, PWSTR wszUserId, PWSTR wszUserIdType, uint* phUser);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmcreateright
@DllImport("msdrm.dll")
HRESULT DRMCreateRight(PWSTR wszRightName, SYSTEMTIME* pstFrom, SYSTEMTIME* pstUntil, uint cExtendedInfo, 
                       PWSTR* pwszExtendedInfoName, PWSTR* pwszExtendedInfoValue, uint* phRight);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmcreateissuancelicense
@DllImport("msdrm.dll")
HRESULT DRMCreateIssuanceLicense(SYSTEMTIME* pstTimeFrom, SYSTEMTIME* pstTimeUntil, PWSTR wszReferralInfoName, 
                                 PWSTR wszReferralInfoURL, uint hOwner, PWSTR wszIssuanceLicense, uint hBoundLicense, 
                                 uint* phIssuanceLicense);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmaddrightwithuser
@DllImport("msdrm.dll")
HRESULT DRMAddRightWithUser(uint hIssuanceLicense, uint hRight, uint hUser);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmclearallrights
@DllImport("msdrm.dll")
HRESULT DRMClearAllRights(uint hIssuanceLicense);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmsetmetadata
@DllImport("msdrm.dll")
HRESULT DRMSetMetaData(uint hIssuanceLicense, PWSTR wszContentId, PWSTR wszContentIdType, PWSTR wszSKUId, 
                       PWSTR wszSKUIdType, PWSTR wszContentType, PWSTR wszContentName);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmsetusagepolicy
@DllImport("msdrm.dll")
HRESULT DRMSetUsagePolicy(uint hIssuanceLicense, DRM_USAGEPOLICY_TYPE eUsagePolicyType, BOOL fDelete, 
                          BOOL fExclusion, PWSTR wszName, PWSTR wszMinVersion, PWSTR wszMaxVersion, 
                          PWSTR wszPublicKey, PWSTR wszDigestAlgorithm, ubyte* pbDigest, uint cbDigest);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmsetrevocationpoint
@DllImport("msdrm.dll")
HRESULT DRMSetRevocationPoint(uint hIssuanceLicense, BOOL fDelete, PWSTR wszId, PWSTR wszIdType, PWSTR wszURL, 
                              SYSTEMTIME* pstFrequency, PWSTR wszName, PWSTR wszPublicKey);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmsetapplicationspecificdata
@DllImport("msdrm.dll")
HRESULT DRMSetApplicationSpecificData(uint hIssuanceLicense, BOOL fDelete, PWSTR wszName, PWSTR wszValue);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmsetnameanddescription
@DllImport("msdrm.dll")
HRESULT DRMSetNameAndDescription(uint hIssuanceLicense, BOOL fDelete, uint lcid, PWSTR wszName, 
                                 PWSTR wszDescription);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmsetintervaltime
@DllImport("msdrm.dll")
HRESULT DRMSetIntervalTime(uint hIssuanceLicense, uint cDays);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmgetissuancelicensetemplate
@DllImport("msdrm.dll")
HRESULT DRMGetIssuanceLicenseTemplate(uint hIssuanceLicense, uint* puIssuanceLicenseTemplateLength, 
                                      PWSTR wszIssuanceLicenseTemplate);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmgetsignedissuancelicense
@DllImport("msdrm.dll")
HRESULT DRMGetSignedIssuanceLicense(uint hEnv, uint hIssuanceLicense, uint uFlags, ubyte* pbSymKey, uint cbSymKey, 
                                    PWSTR wszSymKeyType, PWSTR wszClientLicensorCertificate, DRMCALLBACK pfnCallback, 
                                    PWSTR wszURL, void* pvContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("msdrm.dll")
HRESULT DRMGetSignedIssuanceLicenseEx(uint hEnv, uint hIssuanceLicense, uint uFlags, 
                                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* pbSymKey, 
                                      uint cbSymKey, PWSTR wszSymKeyType, void* pvReserved, uint hEnablingPrincipal, 
                                      uint hBoundLicenseCLC, DRMCALLBACK pfnCallback, void* pvContext);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmclosepubhandle
@DllImport("msdrm.dll")
HRESULT DRMClosePubHandle(uint hPub);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmduplicatepubhandle
@DllImport("msdrm.dll")
HRESULT DRMDuplicatePubHandle(uint hPubIn, uint* phPubOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmgetuserinfo
@DllImport("msdrm.dll")
HRESULT DRMGetUserInfo(uint hUser, uint* puUserNameLength, PWSTR wszUserName, uint* puUserIdLength, 
                       PWSTR wszUserId, uint* puUserIdTypeLength, PWSTR wszUserIdType);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmgetrightinfo
@DllImport("msdrm.dll")
HRESULT DRMGetRightInfo(uint hRight, uint* puRightNameLength, PWSTR wszRightName, SYSTEMTIME* pstFrom, 
                        SYSTEMTIME* pstUntil);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmgetrightextendedinfo
@DllImport("msdrm.dll")
HRESULT DRMGetRightExtendedInfo(uint hRight, uint uIndex, uint* puExtendedInfoNameLength, 
                                PWSTR wszExtendedInfoName, uint* puExtendedInfoValueLength, 
                                PWSTR wszExtendedInfoValue);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmgetusers
@DllImport("msdrm.dll")
HRESULT DRMGetUsers(uint hIssuanceLicense, uint uIndex, uint* phUser);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmgetuserrights
@DllImport("msdrm.dll")
HRESULT DRMGetUserRights(uint hIssuanceLicense, uint hUser, uint uIndex, uint* phRight);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmgetmetadata
@DllImport("msdrm.dll")
HRESULT DRMGetMetaData(uint hIssuanceLicense, uint* puContentIdLength, PWSTR wszContentId, 
                       uint* puContentIdTypeLength, PWSTR wszContentIdType, uint* puSKUIdLength, PWSTR wszSKUId, 
                       uint* puSKUIdTypeLength, PWSTR wszSKUIdType, uint* puContentTypeLength, PWSTR wszContentType, 
                       uint* puContentNameLength, PWSTR wszContentName);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmgetapplicationspecificdata
@DllImport("msdrm.dll")
HRESULT DRMGetApplicationSpecificData(uint hIssuanceLicense, uint uIndex, uint* puNameLength, PWSTR wszName, 
                                      uint* puValueLength, PWSTR wszValue);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmgetissuancelicenseinfo
@DllImport("msdrm.dll")
HRESULT DRMGetIssuanceLicenseInfo(uint hIssuanceLicense, SYSTEMTIME* pstTimeFrom, SYSTEMTIME* pstTimeUntil, 
                                  uint uFlags, uint* puDistributionPointNameLength, PWSTR wszDistributionPointName, 
                                  uint* puDistributionPointURLLength, PWSTR wszDistributionPointURL, uint* phOwner, 
                                  BOOL* pfOfficial);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmgetrevocationpoint
@DllImport("msdrm.dll")
HRESULT DRMGetRevocationPoint(uint hIssuanceLicense, uint* puIdLength, PWSTR wszId, uint* puIdTypeLength, 
                              PWSTR wszIdType, uint* puURLLength, PWSTR wszRL, SYSTEMTIME* pstFrequency, 
                              uint* puNameLength, PWSTR wszName, uint* puPublicKeyLength, PWSTR wszPublicKey);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmgetusagepolicy
@DllImport("msdrm.dll")
HRESULT DRMGetUsagePolicy(uint hIssuanceLicense, uint uIndex, DRM_USAGEPOLICY_TYPE* peUsagePolicyType, 
                          BOOL* pfExclusion, uint* puNameLength, PWSTR wszName, uint* puMinVersionLength, 
                          PWSTR wszMinVersion, uint* puMaxVersionLength, PWSTR wszMaxVersion, 
                          uint* puPublicKeyLength, PWSTR wszPublicKey, uint* puDigestAlgorithmLength, 
                          PWSTR wszDigestAlgorithm, uint* pcbDigest, ubyte* pbDigest);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmgetnameanddescription
@DllImport("msdrm.dll")
HRESULT DRMGetNameAndDescription(uint hIssuanceLicense, uint uIndex, uint* pulcid, uint* puNameLength, 
                                 PWSTR wszName, uint* puDescriptionLength, PWSTR wszDescription);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmgetownerlicense
@DllImport("msdrm.dll")
HRESULT DRMGetOwnerLicense(uint hIssuanceLicense, uint* puOwnerLicenseLength, PWSTR wszOwnerLicense);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmgetintervaltime
@DllImport("msdrm.dll")
HRESULT DRMGetIntervalTime(uint hIssuanceLicense, uint* pcDays);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msdrm/nf-msdrm-drmrepair
@DllImport("msdrm.dll")
HRESULT DRMRepair();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("msdrm.dll")
HRESULT DRMRegisterProtectedWindow(uint hEnv, HWND hwnd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("msdrm.dll")
HRESULT DRMIsWindowProtected(HWND hwnd, BOOL* pfProtected);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("msdrm.dll")
HRESULT DRMAcquireIssuanceLicenseTemplate(uint hClient, uint uFlags, void* pvReserved, uint cTemplates, 
                                          PWSTR* pwszTemplateIds, PWSTR wszUrl, void* pvContext);


