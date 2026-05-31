// Written in the D programming language.

module windows.win32.system.correlationvector;

public import windows.core;
public import system : Guid;
public import windows.win32.foundation : CHAR;

extern(Windows) @nogc nothrow:


// Constants


enum : uint
{
    RTL_CORRELATION_VECTOR_STRING_LENGTH    = 0x00000081,
    RTL_CORRELATION_VECTOR_V1_PREFIX_LENGTH = 0x00000010,
    RTL_CORRELATION_VECTOR_V1_LENGTH        = 0x00000040,
    RTL_CORRELATION_VECTOR_V2_PREFIX_LENGTH = 0x00000016,
    RTL_CORRELATION_VECTOR_V2_LENGTH        = 0x00000080,
}

// Structs


struct CORRELATION_VECTOR
{
    CHAR      Version;
    CHAR[129] Vector;
}

// Functions

@DllImport("ntdll.dll")
uint RtlInitializeCorrelationVector(CORRELATION_VECTOR* CorrelationVector, int Version, const(GUID)* Guid);

@DllImport("ntdll.dll")
uint RtlIncrementCorrelationVector(CORRELATION_VECTOR* CorrelationVector);

@DllImport("ntdll.dll")
uint RtlExtendCorrelationVector(CORRELATION_VECTOR* CorrelationVector);

@DllImport("ntdll.dll")
uint RtlValidateCorrelationVector(CORRELATION_VECTOR* Vector);


