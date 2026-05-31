// Written in the D programming language.

module windows.win32.storage.operationrecorder;

public import windows.core;
public import windows.win32.foundation.foundation : BOOL;

extern(Windows) @nogc nothrow:


// Enums


alias OPERATION_START_FLAGS = uint;
enum : uint
{
    OPERATION_START_TRACE_CURRENT_THREAD = 0x00000001U,
}

alias OPERATION_END_PARAMETERS_FLAGS = uint;
enum : uint
{
    OPERATION_END_DISCARD = 0x00000001U,
}

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/ns-winbase-operation_start_parameters
struct OPERATION_START_PARAMETERS
{
    uint Version;
    uint OperationId;
    OPERATION_START_FLAGS Flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/ns-winbase-operation_end_parameters
struct OPERATION_END_PARAMETERS
{
    uint Version;
    uint OperationId;
    OPERATION_END_PARAMETERS_FLAGS Flags;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("ADVAPI32.dll")
BOOL OperationStart(OPERATION_START_PARAMETERS* OperationStartParams);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("ADVAPI32.dll")
BOOL OperationEnd(OPERATION_END_PARAMETERS* OperationEndParams);


