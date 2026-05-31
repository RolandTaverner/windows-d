// Written in the D programming language.

module windows.win32.management.mobiledevicemanagementregistration;

public import windows.core;
public import windows.win32.foundation : BOOL, HANDLE, HRESULT, PWSTR;

extern(Windows) @nogc nothrow:


// Enums

//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mdmregistration/ne-mdmregistration-registration_information_class))], [])
alias REGISTRATION_INFORMATION_CLASS = int;
enum : int
{
    DeviceRegistrationBasicInfo = 0x00000001,
    MaxDeviceInfoClass          = 0x00000002,
}

// Constants


enum : HRESULT
{
    MENROLL_E_DEVICE_MESSAGE_FORMAT_ERROR     = HRESULT(0x80180001),
    MENROLL_E_DEVICE_AUTHENTICATION_ERROR     = HRESULT(0x80180002),
    MENROLL_E_DEVICE_AUTHORIZATION_ERROR      = HRESULT(0x80180003),
    MENROLL_E_DEVICE_CERTIFICATEREQUEST_ERROR = HRESULT(0x80180004),
    MENROLL_E_DEVICE_CONFIGMGRSERVER_ERROR    = HRESULT(0x80180005),
    MENROLL_E_DEVICE_INTERNALSERVICE_ERROR    = HRESULT(0x80180006),
    MENROLL_E_DEVICE_INVALIDSECURITY_ERROR    = HRESULT(0x80180007),
    MENROLL_E_DEVICE_UNKNOWN_ERROR            = HRESULT(0x80180008),
}

enum HRESULT MENROLL_E_ENROLLMENT_IN_PROGRESS = HRESULT(0x80180009);
enum HRESULT MENROLL_E_DEVICE_ALREADY_ENROLLED = HRESULT(0x8018000a);
enum HRESULT MENROLL_E_DISCOVERY_SEC_CERT_DATE_INVALID = HRESULT(0x8018000d);
enum HRESULT MENROLL_E_PASSWORD_NEEDED = HRESULT(0x8018000e);

enum : HRESULT
{
    MENROLL_E_WAB_ERROR          = HRESULT(0x8018000f),
    MENROLL_E_CONNECTIVITY       = HRESULT(0x80180010),
    MENROLL_E_INVALIDSSLCERT     = HRESULT(0x80180012),
    MENROLL_E_DEVICECAPREACHED   = HRESULT(0x80180013),
    MENROLL_E_DEVICENOTSUPPORTED = HRESULT(0x80180014),
}

enum : HRESULT
{
    MENROLL_E_NOT_SUPPORTED      = HRESULT(0x80180015),
    MENROLL_E_NOTELIGIBLETORENEW = HRESULT(0x80180016),
}

enum : HRESULT
{
    MENROLL_E_INMAINTENANCE         = HRESULT(0x80180017),
    MENROLL_E_USER_LICENSE          = HRESULT(0x80180018),
    MENROLL_E_ENROLLMENTDATAINVALID = HRESULT(0x80180019),
}

enum HRESULT MENROLL_E_INSECUREREDIRECT = HRESULT(0x8018001a);

enum : HRESULT
{
    MENROLL_E_PLATFORM_WRONG_STATE   = HRESULT(0x8018001b),
    MENROLL_E_PLATFORM_LICENSE_ERROR = HRESULT(0x8018001c),
    MENROLL_E_PLATFORM_UNKNOWN_ERROR = HRESULT(0x8018001d),
}

enum : HRESULT
{
    MENROLL_E_PROV_CSP_CERTSTORE   = HRESULT(0x8018001e),
    MENROLL_E_PROV_CSP_W7          = HRESULT(0x8018001f),
    MENROLL_E_PROV_CSP_DMCLIENT    = HRESULT(0x80180020),
    MENROLL_E_PROV_CSP_PFW         = HRESULT(0x80180021),
    MENROLL_E_PROV_CSP_MISC        = HRESULT(0x80180022),
    MENROLL_E_PROV_UNKNOWN         = HRESULT(0x80180023),
    MENROLL_E_PROV_SSLCERTNOTFOUND = HRESULT(0x80180024),
    MENROLL_E_PROV_CSP_APPMGMT     = HRESULT(0x80180025),
}

enum HRESULT MENROLL_E_DEVICE_MANAGEMENT_BLOCKED = HRESULT(0x80180026);
enum HRESULT MENROLL_E_CERTPOLICY_PRIVATEKEYCREATION_FAILED = HRESULT(0x80180027);
enum HRESULT MENROLL_E_CERTAUTH_FAILED_TO_FIND_CERT = HRESULT(0x80180028);

enum : HRESULT
{
    MENROLL_E_EMPTY_MESSAGE      = HRESULT(0x80180029),
    MENROLL_E_USER_CANCELLED     = HRESULT(0x80180030),
    MENROLL_E_MDM_NOT_CONFIGURED = HRESULT(0x80180031),
}

enum HRESULT MENROLL_E_CUSTOMSERVERERROR = HRESULT(0x80180032);
enum HRESULT MENROLL_E_SERVER429 = HRESULT(0x80180033);
enum uint MDM_REGISTRATION_FACILITY_CODE = 0x00000019;
enum uint DEVICE_ENROLLER_FACILITY_CODE = 0x00000018;

enum : HRESULT
{
    MREGISTER_E_DEVICE_MESSAGE_FORMAT_ERROR    = HRESULT(0x80190001),
    MREGISTER_E_DEVICE_AUTHENTICATION_ERROR    = HRESULT(0x80190002),
    MREGISTER_E_DEVICE_AUTHORIZATION_ERROR     = HRESULT(0x80190003),
    MREGISTER_E_DEVICE_CERTIFCATEREQUEST_ERROR = HRESULT(0x80190004),
}

enum HRESULT MENROLL_E_DEVICE_CERTIFCATEREQUEST_ERROR = HRESULT(0x80180004);

enum : HRESULT
{
    MREGISTER_E_DEVICE_CONFIGMGRSERVER_ERROR = HRESULT(0x80190005),
    MREGISTER_E_DEVICE_INTERNALSERVICE_ERROR = HRESULT(0x80190006),
    MREGISTER_E_DEVICE_INVALIDSECURITY_ERROR = HRESULT(0x80190007),
    MREGISTER_E_DEVICE_UNKNOWN_ERROR         = HRESULT(0x80190008),
}

enum HRESULT MREGISTER_E_REGISTRATION_IN_PROGRESS = HRESULT(0x80190009);

enum : HRESULT
{
    MREGISTER_E_DEVICE_ALREADY_REGISTERED = HRESULT(0x8019000a),
    MREGISTER_E_DEVICE_NOT_REGISTERED     = HRESULT(0x8019000b),
}

enum HRESULT MENROLL_E_DEVICE_NOT_ENROLLED = HRESULT(0x8018000b);

enum : HRESULT
{
    MREGISTER_E_DISCOVERY_REDIRECTED           = HRESULT(0x8019000c),
    MREGISTER_E_DEVICE_NOT_AD_REGISTERED_ERROR = HRESULT(0x8019000d),
}

enum HRESULT MREGISTER_E_DISCOVERY_FAILED = HRESULT(0x8019000e);

enum : HRESULT
{
    MENROLL_E_NOTSUPPORTED  = HRESULT(0x80180015),
    MENROLL_E_USERLICENSE   = HRESULT(0x80180018),
    MENROLL_E_USER_CANCELED = HRESULT(0x8018002a),
}

enum : uint
{
    DEVICEREGISTRATIONTYPE_MDM_ONLY                  = 0x00000000,
    DEVICEREGISTRATIONTYPE_MAM                       = 0x00000005,
    DEVICEREGISTRATIONTYPE_MDM_DEVICEWIDE_WITH_AAD   = 0x00000006,
    DEVICEREGISTRATIONTYPE_MDM_USERSPECIFIC_WITH_AAD = 0x0000000d,
}

// Structs


//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mdmregistration/ns-mdmregistration-management_service_info))], [])
struct MANAGEMENT_SERVICE_INFO
{
    PWSTR pszMDMServiceUri;
    PWSTR pszAuthenticationUri;
}

struct MANAGEMENT_REGISTRATION_INFO
{
    BOOL  fDeviceRegisteredWithManagement;
    uint  dwDeviceRegistionKind;
    PWSTR pszUPN;
    PWSTR pszMDMServiceUri;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("MDMRegistration.dll")
HRESULT GetDeviceRegistrationInfo(REGISTRATION_INFORMATION_CLASS DeviceInformationClass, 
                                  void** ppDeviceRegistrationInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("MDMRegistration.dll")
HRESULT IsDeviceRegisteredWithManagement(BOOL* pfIsDeviceRegisteredWithManagement, uint cchUPN, PWSTR pszUPN);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("MDMRegistration.dll")
HRESULT IsManagementRegistrationAllowed(BOOL* pfIsManagementRegistrationAllowed);

@DllImport("MDMRegistration.dll")
HRESULT IsMdmUxWithoutAadAllowed(BOOL* isEnrollmentAllowed);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("MDMRegistration.dll")
HRESULT SetManagedExternally(BOOL IsManagedExternally);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("MDMRegistration.dll")
HRESULT DiscoverManagementService(const(PWSTR) pszUPN, MANAGEMENT_SERVICE_INFO** ppMgmtInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("MDMRegistration.dll")
HRESULT RegisterDeviceWithManagementUsingAADCredentials(HANDLE UserToken);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("MDMRegistration.dll")
HRESULT RegisterDeviceWithManagementUsingAADDeviceCredentials();

@DllImport("MDMRegistration.dll")
HRESULT RegisterDeviceWithManagementUsingAADDeviceCredentials2(const(PWSTR) MDMApplicationID);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("MDMRegistration.dll")
HRESULT RegisterDeviceWithManagement(const(PWSTR) pszUPN, const(PWSTR) ppszMDMServiceUri, 
                                     const(PWSTR) ppzsAccessToken);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("MDMRegistration.dll")
HRESULT UnregisterDeviceWithManagement(const(PWSTR) enrollmentID);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mdmregistration/nf-mdmregistration-getdevicemanagementconfiginfo))], [])
@DllImport("MDMRegistration.dll")
HRESULT GetDeviceManagementConfigInfo(const(PWSTR) providerID, uint* configStringBufferLength, PWSTR configString);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mdmregistration/nf-mdmregistration-setdevicemanagementconfiginfo))], [])
@DllImport("MDMRegistration.dll")
HRESULT SetDeviceManagementConfigInfo(const(PWSTR) providerID, const(PWSTR) configString);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("MDMRegistration.dll")
HRESULT GetManagementAppHyperlink(uint cchHyperlink, PWSTR pszHyperlink);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("MDMRegistration.dll")
HRESULT DiscoverManagementServiceEx(const(PWSTR) pszUPN, const(PWSTR) pszDiscoveryServiceCandidate, 
                                    MANAGEMENT_SERVICE_INFO** ppMgmtInfo);

@DllImport("MDMLocalManagement.dll")
HRESULT RegisterDeviceWithLocalManagement(BOOL* alreadyRegistered);

@DllImport("MDMLocalManagement.dll")
HRESULT ApplyLocalManagementSyncML(const(PWSTR) syncMLRequest, PWSTR* syncMLResult);

@DllImport("MDMLocalManagement.dll")
HRESULT UnregisterDeviceWithLocalManagement();


