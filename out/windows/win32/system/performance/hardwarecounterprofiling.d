// Written in the D programming language.

module windows.win32.system.performance.hardwarecounterprofiling;

public import windows.core;
public import windows.win32.foundation : BOOLEAN, HANDLE;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ne-winnt-hardware_counter_type
alias HARDWARE_COUNTER_TYPE = int;
enum : int
{
    PMCCounter             = 0x00000000,
    MaxHardwareCounterType = 0x00000001,
}

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-hardware_counter_data
struct HARDWARE_COUNTER_DATA
{
    HARDWARE_COUNTER_TYPE Type;
    uint  Reserved;
    ulong Value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-performance_data
struct PERFORMANCE_DATA
{
    ushort Size;
    ubyte  Version;
    ubyte  HwCountersCount;
    uint   ContextSwitchCount;
    ulong  WaitReasonBitMap;
    ulong  CycleTime;
    uint   RetryCount;
    uint   Reserved;
    HARDWARE_COUNTER_DATA[16] HwCounters;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("KERNEL32.dll")
uint EnableThreadProfiling(HANDLE ThreadHandle, uint Flags, ulong HardwareCounters, HANDLE* PerformanceDataHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("KERNEL32.dll")
uint DisableThreadProfiling(HANDLE PerformanceDataHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("KERNEL32.dll")
uint QueryThreadProfiling(HANDLE ThreadHandle, BOOLEAN* Enabled);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("KERNEL32.dll")
uint ReadThreadProfilingData(HANDLE PerformanceDataHandle, uint Flags, PERFORMANCE_DATA* PerformanceData);


