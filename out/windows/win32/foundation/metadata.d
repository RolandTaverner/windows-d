// Written in the D programming language.

module windows.win32.foundation.metadata;

public import windows.core;

extern(Windows) @nogc nothrow:


// Enums


enum Architecture : int
{
    None    = 0x00000000,
    X86     = 0x00000001,
    X64     = 0x00000002,
    Arm64   = 0x00000004,
    All     = 0x00000007,
}

