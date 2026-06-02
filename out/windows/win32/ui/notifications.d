// Written in the D programming language.

module windows.win32.ui.notifications;

public import windows.core;
public import windows.win32.foundation : HRESULT, PWSTR;
public import windows.win32.system.com : IUnknown;

extern(Windows) @nogc nothrow:


// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/notificationactivationcallback/ns-notificationactivationcallback-notification_user_input_data
struct NOTIFICATION_USER_INPUT_DATA
{
    const(PWSTR) Key;
    const(PWSTR) Value;
}

// Interfaces

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/notificationactivationcallback/nn-notificationactivationcallback-inotificationactivationcallback
@GUID("53e31837-6600-4a81-9395-75cffe746f94")
interface INotificationActivationCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/notificationactivationcallback/nf-notificationactivationcallback-inotificationactivationcallback-activate
    HRESULT Activate(const(PWSTR) appUserModelId, const(PWSTR) invokedArgs, 
                     const(NOTIFICATION_USER_INPUT_DATA)* data, uint count);
}


// GUIDs


const GUID IID_INotificationActivationCallback = GUIDOF!INotificationActivationCallback;
