// Written in the D programming language.

module windows.win32.system.setupandmigration;

public import windows.core;
public import windows.win32.foundation.foundation : BOOL;

extern(Windows) @nogc nothrow:


// Callbacks

alias OOBE_COMPLETED_CALLBACK = void function(void* CallbackContext);

// Functions

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oobenotification/nf-oobenotification-oobecomplete
@DllImport("KERNEL32.dll")
BOOL OOBEComplete(BOOL* isOOBEComplete);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oobenotification/nf-oobenotification-registerwaituntiloobecompleted
@DllImport("KERNEL32.dll")
BOOL RegisterWaitUntilOOBECompleted(OOBE_COMPLETED_CALLBACK OOBECompletedCallback, void* CallbackContext, 
                                    void** WaitHandle);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oobenotification/nf-oobenotification-unregisterwaituntiloobecompleted
@DllImport("KERNEL32.dll")
BOOL UnregisterWaitUntilOOBECompleted(void* WaitHandle);


