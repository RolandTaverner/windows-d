// Written in the D programming language.

module windows.win32.system.hostcompute;

public import windows.core;

extern(Windows) @nogc nothrow:


// Structs


//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HCS_CALLBACK
{
    void* Value;
}

