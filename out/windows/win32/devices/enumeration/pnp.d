// Written in the D programming language.

module windows.win32.devices.enumeration.pnp;

public import windows.core;
public import windows.win32.devices.properties : DEVPROPERTY;
public import windows.win32.foundation : BOOL, BSTR, HRESULT, PWSTR, VARIANT_BOOL;
public import windows.win32.security : SECURITY_DESCRIPTOR;
public import windows.win32.system.com : IDispatch, IUnknown;
public import windows.win32.system.variant : VARIANT;

extern(Windows) @nogc nothrow:


// Enums


alias SW_DEVICE_CAPABILITIES = int;
enum : int
{
    SWDeviceCapabilitiesNone           = 0x00000000,
    SWDeviceCapabilitiesRemovable      = 0x00000001,
    SWDeviceCapabilitiesSilentInstall  = 0x00000002,
    SWDeviceCapabilitiesNoDisplayInUI  = 0x00000004,
    SWDeviceCapabilitiesDriverRequired = 0x00000008,
}

alias SW_DEVICE_LIFETIME = int;
enum : int
{
    SWDeviceLifetimeHandle        = 0x00000000,
    SWDeviceLifetimeParentPresent = 0x00000001,
    SWDeviceLifetimeMax           = 0x00000002,
}

// Constants


enum HRESULT UPNP_E_ROOT_ELEMENT_EXPECTED = HRESULT(0x80040200);
enum HRESULT UPNP_E_DEVICE_ELEMENT_EXPECTED = HRESULT(0x80040201);

enum : HRESULT
{
    UPNP_E_SERVICE_ELEMENT_EXPECTED = HRESULT(0x80040202),
    UPNP_E_SERVICE_NODE_INCOMPLETE  = HRESULT(0x80040203),
}

enum HRESULT UPNP_E_DEVICE_NODE_INCOMPLETE = HRESULT(0x80040204);

enum : HRESULT
{
    UPNP_E_ICON_ELEMENT_EXPECTED = HRESULT(0x80040205),
    UPNP_E_ICON_NODE_INCOMPLETE  = HRESULT(0x80040206),
}

enum : HRESULT
{
    UPNP_E_INVALID_ACTION    = HRESULT(0x80040207),
    UPNP_E_INVALID_ARGUMENTS = HRESULT(0x80040208),
}

enum HRESULT UPNP_E_OUT_OF_SYNC = HRESULT(0x80040209);
enum HRESULT UPNP_E_ACTION_REQUEST_FAILED = HRESULT(0x80040210);
enum HRESULT UPNP_E_TRANSPORT_ERROR = HRESULT(0x80040211);
enum HRESULT UPNP_E_VARIABLE_VALUE_UNKNOWN = HRESULT(0x80040212);
enum HRESULT UPNP_E_INVALID_VARIABLE = HRESULT(0x80040213);
enum HRESULT UPNP_E_DEVICE_ERROR = HRESULT(0x80040214);
enum HRESULT UPNP_E_PROTOCOL_ERROR = HRESULT(0x80040215);
enum HRESULT UPNP_E_ERROR_PROCESSING_RESPONSE = HRESULT(0x80040216);
enum HRESULT UPNP_E_DEVICE_TIMEOUT = HRESULT(0x80040217);
enum HRESULT UPNP_E_INVALID_DOCUMENT = HRESULT(0x80040500);
enum HRESULT UPNP_E_EVENT_SUBSCRIPTION_FAILED = HRESULT(0x80040501);

enum : uint
{
    FAULT_INVALID_ACTION          = 0x00000191U,
    FAULT_INVALID_ARG             = 0x00000192U,
    FAULT_INVALID_SEQUENCE_NUMBER = 0x00000193U,
    FAULT_INVALID_VARIABLE        = 0x00000194U,
}

enum uint FAULT_DEVICE_INTERNAL_ERROR = 0x000001f5U;

enum : uint
{
    FAULT_ACTION_SPECIFIC_BASE = 0x00000258U,
    FAULT_ACTION_SPECIFIC_MAX  = 0x00000383U,
}

enum HRESULT UPNP_E_ACTION_SPECIFIC_BASE = HRESULT(0x80040300);

enum : uint
{
    UPNP_ADDRESSFAMILY_IPv4 = 0x00000001U,
    UPNP_ADDRESSFAMILY_IPv6 = 0x00000002U,
    UPNP_ADDRESSFAMILY_BOTH = 0x00000003U,
}

enum uint UPNP_SERVICE_DELAY_SCPD_AND_SUBSCRIPTION = 0x00000001U;
enum HRESULT UPNP_E_REQUIRED_ELEMENT_ERROR = HRESULT(0x8004a020);

enum : HRESULT
{
    UPNP_E_DUPLICATE_NOT_ALLOWED = HRESULT(0x8004a021),
    UPNP_E_DUPLICATE_SERVICE_ID  = HRESULT(0x8004a022),
}

enum : HRESULT
{
    UPNP_E_INVALID_DESCRIPTION    = HRESULT(0x8004a023),
    UPNP_E_INVALID_SERVICE        = HRESULT(0x8004a024),
    UPNP_E_INVALID_ICON           = HRESULT(0x8004a025),
    UPNP_E_INVALID_XML            = HRESULT(0x8004a026),
    UPNP_E_INVALID_ROOT_NAMESPACE = HRESULT(0x8004a027),
}

enum HRESULT UPNP_E_SUFFIX_TOO_LONG = HRESULT(0x8004a028);
enum HRESULT UPNP_E_URLBASE_PRESENT = HRESULT(0x8004a029);
enum HRESULT UPNP_E_VALUE_TOO_LONG = HRESULT(0x8004a030);

enum : HRESULT
{
    UPNP_E_DEVICE_RUNNING       = HRESULT(0x8004a031),
    UPNP_E_DEVICE_NOTREGISTERED = HRESULT(0x8004a032),
}

enum const(wchar)* REMOTE_ADDRESS_VALUE_NAME = "RemoteAddress";
enum const(wchar)* ADDRESS_FAMILY_VALUE_NAME = "AddressFamily";

// Callbacks

alias SW_DEVICE_CREATE_CALLBACK = void function(HSWDEVICE hSwDevice, HRESULT CreateResult, void* pContext, 
                                                const(PWSTR) pszDeviceInstanceId);

// Structs


@RAIIFree!SwDeviceClose
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HSWDEVICE
{
    void* Value;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/swdevicedef/ns-swdevicedef-sw_device_create_info
struct SW_DEVICE_CREATE_INFO
{
    uint         cbSize;
    const(PWSTR) pszInstanceId;
    const(PWSTR) pszzHardwareIds;
    const(PWSTR) pszzCompatibleIds;
    const(GUID)* pContainerId;
    uint         CapabilityFlags;
    const(PWSTR) pszDeviceDescription;
    const(PWSTR) pszDeviceLocation;
    const(SECURITY_DESCRIPTOR)* pSecurityDescriptor;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("CFGMGR32.dll")
HRESULT SwDeviceCreate(const(PWSTR) pszEnumeratorName, const(PWSTR) pszParentDeviceInstance, 
                       const(SW_DEVICE_CREATE_INFO)* pCreateInfo, uint cPropertyCount, 
                       const(DEVPROPERTY)* pProperties, SW_DEVICE_CREATE_CALLBACK pCallback, void* pContext, 
                       HSWDEVICE* phSwDevice);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("CFGMGR32.dll")
void SwDeviceClose(HSWDEVICE hSwDevice);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("CFGMGR32.dll")
HRESULT SwDeviceSetLifetime(HSWDEVICE hSwDevice, SW_DEVICE_LIFETIME Lifetime);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("CFGMGR32.dll")
HRESULT SwDeviceGetLifetime(HSWDEVICE hSwDevice, SW_DEVICE_LIFETIME* pLifetime);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("CFGMGR32.dll")
HRESULT SwDevicePropertySet(HSWDEVICE hSwDevice, uint cPropertyCount, const(DEVPROPERTY)* pProperties);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("CFGMGR32.dll")
HRESULT SwDeviceInterfaceRegister(HSWDEVICE hSwDevice, const(GUID)* pInterfaceClassGuid, 
                                  const(PWSTR) pszReferenceString, uint cPropertyCount, 
                                  const(DEVPROPERTY)* pProperties, BOOL fEnabled, PWSTR* ppszDeviceInterfaceId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("CFGMGR32.dll")
void SwMemFree(void* pMem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("CFGMGR32.dll")
HRESULT SwDeviceInterfaceSetState(HSWDEVICE hSwDevice, const(PWSTR) pszDeviceInterfaceId, BOOL fEnabled);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("CFGMGR32.dll")
HRESULT SwDeviceInterfacePropertySet(HSWDEVICE hSwDevice, const(PWSTR) pszDeviceInterfaceId, uint cPropertyCount, 
                                     const(DEVPROPERTY)* pProperties);


// Interfaces

@GUID("e2085f28-feb7-404a-b8e7-e659bdeaaa02")
struct UPnPDeviceFinder;

@GUID("b9e84ffd-ad3c-40a4-b835-0882ebcbaaa8")
struct UPnPDevices;

@GUID("a32552c5-ba61-457a-b59a-a2561e125e33")
struct UPnPDevice;

@GUID("c0bc4b4a-a406-4efc-932f-b8546b8100cc")
struct UPnPServices;

@GUID("c624ba95-fbcb-4409-8c03-8cceec533ef1")
struct UPnPService;

@GUID("1d8a9b47-3a28-4ce2-8a4b-bd34e45bceeb")
struct UPnPDescriptionDocument;

@GUID("181b54fc-380b-4a75-b3f1-4ac45e9605b0")
struct UPnPDeviceFinderEx;

@GUID("33fd0563-d81a-4393-83cc-0195b1da2f91")
struct UPnPDescriptionDocumentEx;

@GUID("204810b9-73b2-11d4-bf42-00b0d0118b56")
struct UPnPRegistrar;

@GUID("2e5e84e9-4049-4244-b728-2d24227157c7")
struct UPnPRemoteEndpointInfo;

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nn-upnp-iupnpdevicefinder
@GUID("adda3d55-6f72-4319-bff9-18600a539b10")
interface IUPnPDeviceFinder : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpdevicefinder-findbytype
    HRESULT FindByType(BSTR bstrTypeURI, uint dwFlags, IUPnPDevices* pDevices);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpdevicefinder-createasyncfind
    HRESULT CreateAsyncFind(BSTR bstrTypeURI, uint dwFlags, IUnknown punkDeviceFinderCallback, int* plFindData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpdevicefinder-startasyncfind
    HRESULT StartAsyncFind(int lFindData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpdevicefinder-cancelasyncfind
    HRESULT CancelAsyncFind(int lFindData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpdevicefinder-findbyudn
    HRESULT FindByUDN(BSTR bstrUDN, IUPnPDevice* pDevice);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nn-upnp-iupnpaddressfamilycontrol
@GUID("e3bf6178-694e-459f-a5a6-191ea0ffa1c7")
interface IUPnPAddressFamilyControl : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpaddressfamilycontrol-setaddressfamily
    HRESULT SetAddressFamily(int dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpaddressfamilycontrol-getaddressfamily
    HRESULT GetAddressFamily(int* pdwFlags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nn-upnp-iupnphttpheadercontrol
@GUID("0405af4f-8b5c-447c-80f2-b75984a31f3c")
interface IUPnPHttpHeaderControl : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnphttpheadercontrol-addrequestheaders
    HRESULT AddRequestHeaders(BSTR bstrHttpHeaders);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nn-upnp-iupnpdevicefindercallback
@GUID("415a984a-88b3-49f3-92af-0508bedf0d6c")
interface IUPnPDeviceFinderCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpdevicefindercallback-deviceadded
    HRESULT DeviceAdded(int lFindData, IUPnPDevice pDevice);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpdevicefindercallback-deviceremoved
    HRESULT DeviceRemoved(int lFindData, BSTR bstrUDN);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpdevicefindercallback-searchcomplete
    HRESULT SearchComplete(int lFindData);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nn-upnp-iupnpservices
@GUID("3f8c8e9e-9a7a-4dc8-bc41-ff31fa374956")
interface IUPnPServices : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpservices-get_count
    HRESULT get_Count(int* plCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpservices-get__newenum
    HRESULT get__NewEnum(IUnknown* ppunk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpservices-get_item
    HRESULT get_Item(BSTR bstrServiceId, IUPnPService* ppService);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nn-upnp-iupnpservice
@GUID("a295019c-dc65-47dd-90dc-7fe918a1ab44")
interface IUPnPService : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpservice-querystatevariable
    HRESULT QueryStateVariable(BSTR bstrVariableName, VARIANT* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpservice-invokeaction
    HRESULT InvokeAction(BSTR bstrActionName, VARIANT vInActionArgs, VARIANT* pvOutActionArgs, VARIANT* pvRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpservice-get_servicetypeidentifier
    HRESULT get_ServiceTypeIdentifier(BSTR* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpservice-addcallback
    HRESULT AddCallback(IUnknown pUnkCallback);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpservice-get_id
    HRESULT get_Id(BSTR* pbstrId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpservice-get_lasttransportstatus
    HRESULT get_LastTransportStatus(int* plValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nn-upnp-iupnpasyncresult
@GUID("4d65fd08-d13e-4274-9c8b-dd8d028c8644")
interface IUPnPAsyncResult : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpasyncresult-asyncoperationcomplete
    HRESULT AsyncOperationComplete(ulong ullRequestID);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nn-upnp-iupnpserviceasync
@GUID("098bdaf5-5ec1-49e7-a260-b3a11dd8680c")
interface IUPnPServiceAsync : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpserviceasync-begininvokeaction
    HRESULT BeginInvokeAction(BSTR bstrActionName, VARIANT vInActionArgs, IUPnPAsyncResult pAsyncResult, 
                              ulong* pullRequestID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpserviceasync-endinvokeaction
    HRESULT EndInvokeAction(ulong ullRequestID, VARIANT* pvOutActionArgs, VARIANT* pvRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpserviceasync-beginquerystatevariable
    HRESULT BeginQueryStateVariable(BSTR bstrVariableName, IUPnPAsyncResult pAsyncResult, ulong* pullRequestID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpserviceasync-endquerystatevariable
    HRESULT EndQueryStateVariable(ulong ullRequestID, VARIANT* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpserviceasync-beginsubscribetoevents
    HRESULT BeginSubscribeToEvents(IUnknown pUnkCallback, IUPnPAsyncResult pAsyncResult, ulong* pullRequestID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpserviceasync-endsubscribetoevents
    HRESULT EndSubscribeToEvents(ulong ullRequestID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpserviceasync-beginscpddownload
    HRESULT BeginSCPDDownload(IUPnPAsyncResult pAsyncResult, ulong* pullRequestID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpserviceasync-endscpddownload
    HRESULT EndSCPDDownload(ulong ullRequestID, BSTR* pbstrSCPDDoc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpserviceasync-cancelasyncoperation
    HRESULT CancelAsyncOperation(ulong ullRequestID);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nn-upnp-iupnpservicecallback
@GUID("31fadca9-ab73-464b-b67d-5c1d0f83c8b8")
interface IUPnPServiceCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpservicecallback-statevariablechanged
    HRESULT StateVariableChanged(IUPnPService pus, const(PWSTR) pcwszStateVarName, VARIANT vaValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpservicecallback-serviceinstancedied
    HRESULT ServiceInstanceDied(IUPnPService pus);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nn-upnp-iupnpserviceenumproperty
@GUID("38873b37-91bb-49f4-b249-2e8efbb8a816")
interface IUPnPServiceEnumProperty : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpserviceenumproperty-setserviceenumproperty
    HRESULT SetServiceEnumProperty(uint dwMask);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nn-upnp-iupnpservicedocumentaccess
@GUID("21905529-0a5e-4589-825d-7e6d87ea6998")
interface IUPnPServiceDocumentAccess : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpservicedocumentaccess-getdocumenturl
    HRESULT GetDocumentURL(BSTR* pbstrDocUrl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpservicedocumentaccess-getdocument
    HRESULT GetDocument(BSTR* pbstrDoc);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nn-upnp-iupnpdevices
@GUID("fdbc0c73-bda3-4c66-ac4f-f2d96fdad68c")
interface IUPnPDevices : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpdevices-get_count
    HRESULT get_Count(int* plCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpdevices-get__newenum
    HRESULT get__NewEnum(IUnknown* ppunk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpdevices-get_item
    HRESULT get_Item(BSTR bstrUDN, IUPnPDevice* ppDevice);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nn-upnp-iupnpdevice
@GUID("3d44d0d1-98c9-4889-acd1-f9d674bf2221")
interface IUPnPDevice : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpdevice-get_isrootdevice
    HRESULT get_IsRootDevice(VARIANT_BOOL* pvarb);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpdevice-get_rootdevice
    HRESULT get_RootDevice(IUPnPDevice* ppudRootDevice);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpdevice-get_parentdevice
    HRESULT get_ParentDevice(IUPnPDevice* ppudDeviceParent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpdevice-get_haschildren
    HRESULT get_HasChildren(VARIANT_BOOL* pvarb);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpdevice-get_children
    HRESULT get_Children(IUPnPDevices* ppudChildren);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpdevice-get_uniquedevicename
    HRESULT get_UniqueDeviceName(BSTR* pbstr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpdevice-get_friendlyname
    HRESULT get_FriendlyName(BSTR* pbstr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpdevice-get_type
    HRESULT get_Type(BSTR* pbstr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpdevice-get_presentationurl
    HRESULT get_PresentationURL(BSTR* pbstr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpdevice-get_manufacturername
    HRESULT get_ManufacturerName(BSTR* pbstr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpdevice-get_manufacturerurl
    HRESULT get_ManufacturerURL(BSTR* pbstr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpdevice-get_modelname
    HRESULT get_ModelName(BSTR* pbstr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpdevice-get_modelnumber
    HRESULT get_ModelNumber(BSTR* pbstr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpdevice-get_description
    HRESULT get_Description(BSTR* pbstr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpdevice-get_modelurl
    HRESULT get_ModelURL(BSTR* pbstr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpdevice-get_upc
    HRESULT get_UPC(BSTR* pbstr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpdevice-get_serialnumber
    HRESULT get_SerialNumber(BSTR* pbstr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpdevice-iconurl
    HRESULT IconURL(BSTR bstrEncodingFormat, int lSizeX, int lSizeY, int lBitDepth, BSTR* pbstrIconURL);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpdevice-get_services
    HRESULT get_Services(IUPnPServices* ppusServices);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nn-upnp-iupnpdevicedocumentaccess
@GUID("e7772804-3287-418e-9072-cf2b47238981")
interface IUPnPDeviceDocumentAccess : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpdevicedocumentaccess-getdocumenturl
    HRESULT GetDocumentURL(BSTR* pbstrDocument);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nn-upnp-iupnpdevicedocumentaccessex
@GUID("c4bc4050-6178-4bd1-a4b8-6398321f3247")
interface IUPnPDeviceDocumentAccessEx : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpdevicedocumentaccessex-getdocument
    HRESULT GetDocument(BSTR* pbstrDocument);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nn-upnp-iupnpdescriptiondocument
@GUID("11d1c1b2-7daa-4c9e-9595-7f82ed206d1e")
interface IUPnPDescriptionDocument : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpdescriptiondocument-get_readystate
    HRESULT get_ReadyState(int* plReadyState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpdescriptiondocument-load
    HRESULT Load(BSTR bstrUrl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpdescriptiondocument-loadasync
    HRESULT LoadAsync(BSTR bstrUrl, IUnknown punkCallback);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpdescriptiondocument-get_loadresult
    HRESULT get_LoadResult(int* phrError);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpdescriptiondocument-abort
    HRESULT Abort();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpdescriptiondocument-rootdevice
    HRESULT RootDevice(IUPnPDevice* ppudRootDevice);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpdescriptiondocument-devicebyudn
    HRESULT DeviceByUDN(BSTR bstrUDN, IUPnPDevice* ppudDevice);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nn-upnp-iupnpdevicefinderaddcallbackwithinterface
@GUID("983dfc0b-1796-44df-8975-ca545b620ee5")
interface IUPnPDeviceFinderAddCallbackWithInterface : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpdevicefinderaddcallbackwithinterface-deviceaddedwithinterface
    HRESULT DeviceAddedWithInterface(int lFindData, IUPnPDevice pDevice, GUID* pguidInterface);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nn-upnp-iupnpdescriptiondocumentcallback
@GUID("77394c69-5486-40d6-9bc3-4991983e02da")
interface IUPnPDescriptionDocumentCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnp/nf-upnp-iupnpdescriptiondocumentcallback-loadcomplete
    HRESULT LoadComplete(HRESULT hrLoadResult);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnphost/nn-upnphost-iupnpeventsink
@GUID("204810b4-73b2-11d4-bf42-00b0d0118b56")
interface IUPnPEventSink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnphost/nf-upnphost-iupnpeventsink-onstatechanged
    HRESULT OnStateChanged(uint cChanges, int* rgdispidChanges);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnphost/nf-upnphost-iupnpeventsink-onstatechangedsafe
    HRESULT OnStateChangedSafe(VARIANT varsadispidChanges);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnphost/nn-upnphost-iupnpeventsource
@GUID("204810b5-73b2-11d4-bf42-00b0d0118b56")
interface IUPnPEventSource : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnphost/nf-upnphost-iupnpeventsource-advise
    HRESULT Advise(IUPnPEventSink pesSubscriber);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnphost/nf-upnphost-iupnpeventsource-unadvise
    HRESULT Unadvise(IUPnPEventSink pesSubscriber);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnphost/nn-upnphost-iupnpregistrar
@GUID("204810b6-73b2-11d4-bf42-00b0d0118b56")
interface IUPnPRegistrar : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnphost/nf-upnphost-iupnpregistrar-registerdevice
    HRESULT RegisterDevice(BSTR bstrXMLDesc, BSTR bstrProgIDDeviceControlClass, BSTR bstrInitString, 
                           BSTR bstrContainerId, BSTR bstrResourcePath, int nLifeTime, BSTR* pbstrDeviceIdentifier);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnphost/nf-upnphost-iupnpregistrar-registerrunningdevice
    HRESULT RegisterRunningDevice(BSTR bstrXMLDesc, IUnknown punkDeviceControl, BSTR bstrInitString, 
                                  BSTR bstrResourcePath, int nLifeTime, BSTR* pbstrDeviceIdentifier);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnphost/nf-upnphost-iupnpregistrar-registerdeviceprovider
    HRESULT RegisterDeviceProvider(BSTR bstrProviderName, BSTR bstrProgIDProviderClass, BSTR bstrInitString, 
                                   BSTR bstrContainerId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnphost/nf-upnphost-iupnpregistrar-getuniquedevicename
    HRESULT GetUniqueDeviceName(BSTR bstrDeviceIdentifier, BSTR bstrTemplateUDN, BSTR* pbstrUDN);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnphost/nf-upnphost-iupnpregistrar-unregisterdevice
    HRESULT UnregisterDevice(BSTR bstrDeviceIdentifier, BOOL fPermanent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnphost/nf-upnphost-iupnpregistrar-unregisterdeviceprovider
    HRESULT UnregisterDeviceProvider(BSTR bstrProviderName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnphost/nn-upnphost-iupnpreregistrar
@GUID("204810b7-73b2-11d4-bf42-00b0d0118b56")
interface IUPnPReregistrar : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnphost/nf-upnphost-iupnpreregistrar-reregisterdevice
    HRESULT ReregisterDevice(BSTR bstrDeviceIdentifier, BSTR bstrXMLDesc, BSTR bstrProgIDDeviceControlClass, 
                             BSTR bstrInitString, BSTR bstrContainerId, BSTR bstrResourcePath, int nLifeTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnphost/nf-upnphost-iupnpreregistrar-reregisterrunningdevice
    HRESULT ReregisterRunningDevice(BSTR bstrDeviceIdentifier, BSTR bstrXMLDesc, IUnknown punkDeviceControl, 
                                    BSTR bstrInitString, BSTR bstrResourcePath, int nLifeTime);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnphost/nn-upnphost-iupnpdevicecontrol
@GUID("204810ba-73b2-11d4-bf42-00b0d0118b56")
interface IUPnPDeviceControl : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnphost/nf-upnphost-iupnpdevicecontrol-initialize
    HRESULT Initialize(BSTR bstrXMLDesc, BSTR bstrDeviceIdentifier, BSTR bstrInitString);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnphost/nf-upnphost-iupnpdevicecontrol-getserviceobject
    HRESULT GetServiceObject(BSTR bstrUDN, BSTR bstrServiceId, IDispatch* ppdispService);
}

@GUID("204810bb-73b2-11d4-bf42-00b0d0118b56")
interface IUPnPDeviceControlHttpHeaders : IUnknown
{
    HRESULT GetAdditionalResponseHeaders(BSTR* bstrHttpResponseHeaders);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnphost/nn-upnphost-iupnpdeviceprovider
@GUID("204810b8-73b2-11d4-bf42-00b0d0118b56")
interface IUPnPDeviceProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnphost/nf-upnphost-iupnpdeviceprovider-start
    HRESULT Start(BSTR bstrInitString);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnphost/nf-upnphost-iupnpdeviceprovider-stop
    HRESULT Stop();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnphost/nn-upnphost-iupnpremoteendpointinfo
@GUID("c92eb863-0269-4aff-9c72-75321bba2952")
interface IUPnPRemoteEndpointInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnphost/nf-upnphost-iupnpremoteendpointinfo-getdwordvalue
    HRESULT GetDwordValue(BSTR bstrValueName, uint* pdwValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnphost/nf-upnphost-iupnpremoteendpointinfo-getstringvalue
    HRESULT GetStringValue(BSTR bstrValueName, BSTR* pbstrValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/upnphost/nf-upnphost-iupnpremoteendpointinfo-getguidvalue
    HRESULT GetGuidValue(BSTR bstrValueName, GUID* pguidValue);
}


// GUIDs

const GUID CLSID_UPnPDescriptionDocument   = GUIDOF!UPnPDescriptionDocument;
const GUID CLSID_UPnPDescriptionDocumentEx = GUIDOF!UPnPDescriptionDocumentEx;
const GUID CLSID_UPnPDevice                = GUIDOF!UPnPDevice;
const GUID CLSID_UPnPDeviceFinder          = GUIDOF!UPnPDeviceFinder;
const GUID CLSID_UPnPDeviceFinderEx        = GUIDOF!UPnPDeviceFinderEx;
const GUID CLSID_UPnPDevices               = GUIDOF!UPnPDevices;
const GUID CLSID_UPnPRegistrar             = GUIDOF!UPnPRegistrar;
const GUID CLSID_UPnPRemoteEndpointInfo    = GUIDOF!UPnPRemoteEndpointInfo;
const GUID CLSID_UPnPService               = GUIDOF!UPnPService;
const GUID CLSID_UPnPServices              = GUIDOF!UPnPServices;

const GUID IID_IUPnPAddressFamilyControl                 = GUIDOF!IUPnPAddressFamilyControl;
const GUID IID_IUPnPAsyncResult                          = GUIDOF!IUPnPAsyncResult;
const GUID IID_IUPnPDescriptionDocument                  = GUIDOF!IUPnPDescriptionDocument;
const GUID IID_IUPnPDescriptionDocumentCallback          = GUIDOF!IUPnPDescriptionDocumentCallback;
const GUID IID_IUPnPDevice                               = GUIDOF!IUPnPDevice;
const GUID IID_IUPnPDeviceControl                        = GUIDOF!IUPnPDeviceControl;
const GUID IID_IUPnPDeviceControlHttpHeaders             = GUIDOF!IUPnPDeviceControlHttpHeaders;
const GUID IID_IUPnPDeviceDocumentAccess                 = GUIDOF!IUPnPDeviceDocumentAccess;
const GUID IID_IUPnPDeviceDocumentAccessEx               = GUIDOF!IUPnPDeviceDocumentAccessEx;
const GUID IID_IUPnPDeviceFinder                         = GUIDOF!IUPnPDeviceFinder;
const GUID IID_IUPnPDeviceFinderAddCallbackWithInterface = GUIDOF!IUPnPDeviceFinderAddCallbackWithInterface;
const GUID IID_IUPnPDeviceFinderCallback                 = GUIDOF!IUPnPDeviceFinderCallback;
const GUID IID_IUPnPDeviceProvider                       = GUIDOF!IUPnPDeviceProvider;
const GUID IID_IUPnPDevices                              = GUIDOF!IUPnPDevices;
const GUID IID_IUPnPEventSink                            = GUIDOF!IUPnPEventSink;
const GUID IID_IUPnPEventSource                          = GUIDOF!IUPnPEventSource;
const GUID IID_IUPnPHttpHeaderControl                    = GUIDOF!IUPnPHttpHeaderControl;
const GUID IID_IUPnPRegistrar                            = GUIDOF!IUPnPRegistrar;
const GUID IID_IUPnPRemoteEndpointInfo                   = GUIDOF!IUPnPRemoteEndpointInfo;
const GUID IID_IUPnPReregistrar                          = GUIDOF!IUPnPReregistrar;
const GUID IID_IUPnPService                              = GUIDOF!IUPnPService;
const GUID IID_IUPnPServiceAsync                         = GUIDOF!IUPnPServiceAsync;
const GUID IID_IUPnPServiceCallback                      = GUIDOF!IUPnPServiceCallback;
const GUID IID_IUPnPServiceDocumentAccess                = GUIDOF!IUPnPServiceDocumentAccess;
const GUID IID_IUPnPServiceEnumProperty                  = GUIDOF!IUPnPServiceEnumProperty;
const GUID IID_IUPnPServices                             = GUIDOF!IUPnPServices;
