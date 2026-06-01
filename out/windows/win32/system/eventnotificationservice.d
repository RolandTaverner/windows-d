// Written in the D programming language.

module windows.win32.system.eventnotificationservice;

public import windows.core;
public import system.system : Guid;
public import windows.win32.foundation.foundation : BOOL, BSTR, HRESULT, PSTR, PWSTR;
public import windows.win32.system.com.com : IDispatch;

extern(Windows) @nogc nothrow:


// Enums


alias SENS_CONNECTION_TYPE = uint;
enum : uint
{
    CONNECTION_LAN = 0x00000000U,
    CONNECTION_WAN = 0x00000001U,
}

// Constants


enum : uint
{
    NETWORK_ALIVE_LAN      = 0x00000001U,
    NETWORK_ALIVE_WAN      = 0x00000002U,
    NETWORK_ALIVE_AOL      = 0x00000004U,
    NETWORK_ALIVE_INTERNET = 0x00000008U,
}

enum uint CONNECTION_AOL = 0x00000004U;

enum : GUID
{
    SENSGUID_PUBLISHER          = GUID("5fee1bd6-5b9b-11d1-8dd2-00aa004abd5e"),
    SENSGUID_SUBSCRIBER_LCE     = GUID("d3938ab0-5b9d-11d1-8dd2-00aa004abd5e"),
    SENSGUID_SUBSCRIBER_WININET = GUID("d3938ab5-5b9d-11d1-8dd2-00aa004abd5e"),
}

enum : GUID
{
    SENSGUID_EVENTCLASS_NETWORK = GUID("d5978620-5b9f-11d1-8dd2-00aa004abd5e"),
    SENSGUID_EVENTCLASS_LOGON   = GUID("d5978630-5b9f-11d1-8dd2-00aa004abd5e"),
    SENSGUID_EVENTCLASS_ONNOW   = GUID("d5978640-5b9f-11d1-8dd2-00aa004abd5e"),
    SENSGUID_EVENTCLASS_LOGON2  = GUID("d5978650-5b9f-11d1-8dd2-00aa004abd5e"),
}

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensapi/ns-sensapi-qocinfo
struct QOCINFO
{
    uint dwSize;
    uint dwFlags;
    uint dwInSpeed;
    uint dwOutSpeed;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensevts/ns-sensevts-sens_qocinfo
struct SENS_QOCINFO
{
    uint dwSize;
    uint dwFlags;
    uint dwOutSpeed;
    uint dwInSpeed;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SensApi.dll")
BOOL IsDestinationReachableA(const(PSTR) lpszDestination, QOCINFO* lpQOCInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SensApi.dll")
BOOL IsDestinationReachableW(const(PWSTR) lpszDestination, QOCINFO* lpQOCInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SensApi.dll")
BOOL IsNetworkAlive(uint* lpdwFlags);


// Interfaces

@GUID("d597cafe-5b9f-11d1-8dd2-00aa004abd5e")
struct SENS;

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensevts/nn-sensevts-isensnetwork
@GUID("d597bab1-5b9f-11d1-8dd2-00aa004abd5e")
interface ISensNetwork : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensevts/nf-sensevts-isensnetwork-connectionmade
    HRESULT ConnectionMade(BSTR bstrConnection, uint ulType, SENS_QOCINFO* lpQOCInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensevts/nf-sensevts-isensnetwork-connectionmadenoqocinfo
    HRESULT ConnectionMadeNoQOCInfo(BSTR bstrConnection, uint ulType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensevts/nf-sensevts-isensnetwork-connectionlost
    HRESULT ConnectionLost(BSTR bstrConnection, SENS_CONNECTION_TYPE ulType);
    HRESULT DestinationReachable(BSTR bstrDestination, BSTR bstrConnection, uint ulType, SENS_QOCINFO* lpQOCInfo);
    HRESULT DestinationReachableNoQOCInfo(BSTR bstrDestination, BSTR bstrConnection, uint ulType);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensevts/nn-sensevts-isensonnow
@GUID("d597bab2-5b9f-11d1-8dd2-00aa004abd5e")
interface ISensOnNow : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensevts/nf-sensevts-isensonnow-onacpower
    HRESULT OnACPower();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensevts/nf-sensevts-isensonnow-onbatterypower
    HRESULT OnBatteryPower(uint dwBatteryLifePercent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensevts/nf-sensevts-isensonnow-batterylow
    HRESULT BatteryLow(uint dwBatteryLifePercent);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensevts/nn-sensevts-isenslogon
@GUID("d597bab3-5b9f-11d1-8dd2-00aa004abd5e")
interface ISensLogon : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensevts/nf-sensevts-isenslogon-logon
    HRESULT Logon(BSTR bstrUserName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensevts/nf-sensevts-isenslogon-logoff
    HRESULT Logoff(BSTR bstrUserName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensevts/nf-sensevts-isenslogon-startshell
    HRESULT StartShell(BSTR bstrUserName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensevts/nf-sensevts-isenslogon-displaylock
    HRESULT DisplayLock(BSTR bstrUserName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensevts/nf-sensevts-isenslogon-displayunlock
    HRESULT DisplayUnlock(BSTR bstrUserName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensevts/nf-sensevts-isenslogon-startscreensaver
    HRESULT StartScreenSaver(BSTR bstrUserName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensevts/nf-sensevts-isenslogon-stopscreensaver
    HRESULT StopScreenSaver(BSTR bstrUserName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensevts/nn-sensevts-isenslogon2
@GUID("d597bab4-5b9f-11d1-8dd2-00aa004abd5e")
interface ISensLogon2 : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensevts/nf-sensevts-isenslogon2-logon
    HRESULT Logon(BSTR bstrUserName, uint dwSessionId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensevts/nf-sensevts-isenslogon2-logoff
    HRESULT Logoff(BSTR bstrUserName, uint dwSessionId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensevts/nf-sensevts-isenslogon2-sessiondisconnect
    HRESULT SessionDisconnect(BSTR bstrUserName, uint dwSessionId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensevts/nf-sensevts-isenslogon2-sessionreconnect
    HRESULT SessionReconnect(BSTR bstrUserName, uint dwSessionId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensevts/nf-sensevts-isenslogon2-postshell
    HRESULT PostShell(BSTR bstrUserName, uint dwSessionId);
}


// GUIDs

const GUID CLSID_SENS = GUIDOF!SENS;

const GUID IID_ISensLogon   = GUIDOF!ISensLogon;
const GUID IID_ISensLogon2  = GUIDOF!ISensLogon2;
const GUID IID_ISensNetwork = GUIDOF!ISensNetwork;
const GUID IID_ISensOnNow   = GUIDOF!ISensOnNow;
