// Written in the D programming language.

module windows.win32.media.librarysharingservices;

public import windows.core;
public import windows.win32.foundation.foundation : BSTR, HRESULT, VARIANT_BOOL;
public import windows.win32.system.com.com : IDispatch;
public import windows.win32.system.variant : VARIANT;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmlss/ne-wmlss-windowsmedialibrarysharingdeviceauthorizationstatus
enum WindowsMediaLibrarySharingDeviceAuthorizationStatus : int
{
    DEVICE_AUTHORIZATION_UNKNOWN = 0x00000000,
    DEVICE_AUTHORIZATION_ALLOWED = 0x00000001,
    DEVICE_AUTHORIZATION_DENIED  = 0x00000002,
}

// Interfaces

@GUID("ad581b00-7b64-4e59-a38d-d2c5bf51ddb3")
struct WindowsMediaLibrarySharingServices;

@GUID("81e26927-7a7d-40a7-81d4-bddc02960e3e")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmlss/nn-wmlss-iwindowsmedialibrarysharingdeviceproperty
interface IWindowsMediaLibrarySharingDeviceProperty : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmlss/nf-wmlss-iwindowsmedialibrarysharingdeviceproperty-get_name
    HRESULT get_Name(BSTR* name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmlss/nf-wmlss-iwindowsmedialibrarysharingdeviceproperty-get_value
    HRESULT get_Value(VARIANT* value);
}

@GUID("c4623214-6b06-40c5-a623-b2ff4c076bfd")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmlss/nn-wmlss-iwindowsmedialibrarysharingdeviceproperties
interface IWindowsMediaLibrarySharingDeviceProperties : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmlss/nf-wmlss-iwindowsmedialibrarysharingdeviceproperties-get_item
    HRESULT get_Item(int index, IWindowsMediaLibrarySharingDeviceProperty* property);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmlss/nf-wmlss-iwindowsmedialibrarysharingdeviceproperties-get_count
    HRESULT get_Count(int* count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmlss/nf-wmlss-iwindowsmedialibrarysharingdeviceproperties-getproperty
    HRESULT GetProperty(BSTR name, IWindowsMediaLibrarySharingDeviceProperty* property);
}

@GUID("3dccc293-4fd9-4191-a25b-8e57c5d27bd4")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmlss/nn-wmlss-iwindowsmedialibrarysharingdevice
interface IWindowsMediaLibrarySharingDevice : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmlss/nf-wmlss-iwindowsmedialibrarysharingdevice-get_deviceid
    HRESULT get_DeviceID(BSTR* deviceID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmlss/nf-wmlss-iwindowsmedialibrarysharingdevice-get_authorization
    HRESULT get_Authorization(WindowsMediaLibrarySharingDeviceAuthorizationStatus* authorization);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmlss/nf-wmlss-iwindowsmedialibrarysharingdevice-put_authorization
    HRESULT put_Authorization(WindowsMediaLibrarySharingDeviceAuthorizationStatus authorization);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmlss/nf-wmlss-iwindowsmedialibrarysharingdevice-get_properties
    HRESULT get_Properties(IWindowsMediaLibrarySharingDeviceProperties* deviceProperties);
}

@GUID("1803f9d6-fe6d-4546-bf5b-992fe8ec12d1")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmlss/nn-wmlss-iwindowsmedialibrarysharingdevices
interface IWindowsMediaLibrarySharingDevices : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmlss/nf-wmlss-iwindowsmedialibrarysharingdevices-get_item
    HRESULT get_Item(int index, IWindowsMediaLibrarySharingDevice* device);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmlss/nf-wmlss-iwindowsmedialibrarysharingdevices-get_count
    HRESULT get_Count(int* count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmlss/nf-wmlss-iwindowsmedialibrarysharingdevices-getdevice
    HRESULT GetDevice(BSTR deviceID, IWindowsMediaLibrarySharingDevice* device);
}

@GUID("01f5f85e-0a81-40da-a7c8-21ef3af8440c")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmlss/nn-wmlss-iwindowsmedialibrarysharingservices
interface IWindowsMediaLibrarySharingServices : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmlss/nf-wmlss-iwindowsmedialibrarysharingservices-showsharemediacpl
    HRESULT showShareMediaCPL(BSTR device);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmlss/nf-wmlss-iwindowsmedialibrarysharingservices-get_userhomemediasharingstate
    HRESULT get_userHomeMediaSharingState(VARIANT_BOOL* sharingEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmlss/nf-wmlss-iwindowsmedialibrarysharingservices-put_userhomemediasharingstate
    HRESULT put_userHomeMediaSharingState(VARIANT_BOOL sharingEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmlss/nf-wmlss-iwindowsmedialibrarysharingservices-get_userhomemediasharinglibraryname
    HRESULT get_userHomeMediaSharingLibraryName(BSTR* libraryName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmlss/nf-wmlss-iwindowsmedialibrarysharingservices-put_userhomemediasharinglibraryname
    HRESULT put_userHomeMediaSharingLibraryName(BSTR libraryName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmlss/nf-wmlss-iwindowsmedialibrarysharingservices-get_computerhomemediasharingallowedstate
    HRESULT get_computerHomeMediaSharingAllowedState(VARIANT_BOOL* sharingAllowed);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmlss/nf-wmlss-iwindowsmedialibrarysharingservices-put_computerhomemediasharingallowedstate
    HRESULT put_computerHomeMediaSharingAllowedState(VARIANT_BOOL sharingAllowed);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmlss/nf-wmlss-iwindowsmedialibrarysharingservices-get_userinternetmediasharingstate
    HRESULT get_userInternetMediaSharingState(VARIANT_BOOL* sharingEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmlss/nf-wmlss-iwindowsmedialibrarysharingservices-put_userinternetmediasharingstate
    HRESULT put_userInternetMediaSharingState(VARIANT_BOOL sharingEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmlss/nf-wmlss-iwindowsmedialibrarysharingservices-get_computerinternetmediasharingallowedstate
    HRESULT get_computerInternetMediaSharingAllowedState(VARIANT_BOOL* sharingAllowed);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmlss/nf-wmlss-iwindowsmedialibrarysharingservices-put_computerinternetmediasharingallowedstate
    HRESULT put_computerInternetMediaSharingAllowedState(VARIANT_BOOL sharingAllowed);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmlss/nf-wmlss-iwindowsmedialibrarysharingservices-get_internetmediasharingsecuritygroup
    HRESULT get_internetMediaSharingSecurityGroup(BSTR* securityGroup);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmlss/nf-wmlss-iwindowsmedialibrarysharingservices-put_internetmediasharingsecuritygroup
    HRESULT put_internetMediaSharingSecurityGroup(BSTR securityGroup);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmlss/nf-wmlss-iwindowsmedialibrarysharingservices-get_allowsharingtoalldevices
    HRESULT get_allowSharingToAllDevices(VARIANT_BOOL* sharingEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmlss/nf-wmlss-iwindowsmedialibrarysharingservices-put_allowsharingtoalldevices
    HRESULT put_allowSharingToAllDevices(VARIANT_BOOL sharingEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmlss/nf-wmlss-iwindowsmedialibrarysharingservices-setdefaultauthorization
    HRESULT setDefaultAuthorization(BSTR MACAddresses, BSTR friendlyName, VARIANT_BOOL authorization);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmlss/nf-wmlss-iwindowsmedialibrarysharingservices-setauthorizationstate
    HRESULT setAuthorizationState(BSTR MACAddress, VARIANT_BOOL authorizationState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmlss/nf-wmlss-iwindowsmedialibrarysharingservices-getalldevices
    HRESULT getAllDevices(IWindowsMediaLibrarySharingDevices* devices);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmlss/nf-wmlss-iwindowsmedialibrarysharingservices-get_customsettingsapplied
    HRESULT get_customSettingsApplied(VARIANT_BOOL* customSettingsApplied);
}


// GUIDs

const GUID CLSID_WindowsMediaLibrarySharingServices = GUIDOF!WindowsMediaLibrarySharingServices;

const GUID IID_IWindowsMediaLibrarySharingDevice           = GUIDOF!IWindowsMediaLibrarySharingDevice;
const GUID IID_IWindowsMediaLibrarySharingDeviceProperties = GUIDOF!IWindowsMediaLibrarySharingDeviceProperties;
const GUID IID_IWindowsMediaLibrarySharingDeviceProperty   = GUIDOF!IWindowsMediaLibrarySharingDeviceProperty;
const GUID IID_IWindowsMediaLibrarySharingDevices          = GUIDOF!IWindowsMediaLibrarySharingDevices;
const GUID IID_IWindowsMediaLibrarySharingServices         = GUIDOF!IWindowsMediaLibrarySharingServices;
