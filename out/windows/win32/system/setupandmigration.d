// Written in the D programming language.

module windows.win32.system.setupandmigration;

public import windows.core;
public import windows.win32.foundation : BOOL;

extern(Windows) @nogc nothrow:


// Callbacks

alias OOBE_COMPLETED_CALLBACK = void function(void* CallbackContext);

// Functions

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oobenotification/nf-oobenotification-oobecomplete))], [])
@DllImport("KERNEL32.dll")
BOOL OOBEComplete(BOOL* isOOBEComplete);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oobenotification/nf-oobenotification-registerwaituntiloobecompleted))], [])
@DllImport("KERNEL32.dll")
BOOL RegisterWaitUntilOOBECompleted(OOBE_COMPLETED_CALLBACK OOBECompletedCallback, void* CallbackContext, 
                                    void** WaitHandle);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oobenotification/nf-oobenotification-unregisterwaituntiloobecompleted))], [])
@DllImport("KERNEL32.dll")
BOOL UnregisterWaitUntilOOBECompleted(void* WaitHandle);


