// Written in the D programming language.

module windows.win32.system.applicationverifier;

public import windows.core;
public import windows.win32.foundation : HANDLE;

extern(Windows) @nogc nothrow:


// Enums


alias VERIFIER_ENUM_RESOURCE_FLAGS = uint;
enum : uint
{
    AVRF_ENUM_RESOURCES_FLAGS_DONT_RESOLVE_TRACES = 0x00000002U,
    AVRF_ENUM_RESOURCES_FLAGS_SUSPEND             = 0x00000001U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/avrfsdk/ne-avrfsdk-euserallocationstate
alias eUserAllocationState = int;
enum : int
{
    AllocationStateUnknown = 0x00000000,
    AllocationStateBusy    = 0x00000001,
    AllocationStateFree    = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/avrfsdk/ne-avrfsdk-eheapallocationstate
alias eHeapAllocationState = int;
enum : int
{
    HeapFullPageHeap = 0x40000000,
    HeapMetadata     = 0x80000000,
    HeapStateMask    = 0xffff0000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/avrfsdk/ne-avrfsdk-eheapenumerationlevel
alias eHeapEnumerationLevel = int;
enum : int
{
    HeapEnumerationEverything = 0x00000000,
    HeapEnumerationStop       = 0xffffffff,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/avrfsdk/ne-avrfsdk-ehandle_trace_operations
alias eHANDLE_TRACE_OPERATIONS = int;
enum : int
{
    OperationDbUnused = 0x00000000,
    OperationDbOPEN   = 0x00000001,
    OperationDbCLOSE  = 0x00000002,
    OperationDbBADREF = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/avrfsdk/ne-avrfsdk-eavrfresourcetypes
alias eAvrfResourceTypes = int;
enum : int
{
    AvrfResourceHeapAllocation = 0x00000000,
    AvrfResourceHandleTrace    = 0x00000001,
    AvrfResourceMax            = 0x00000002,
}

// Constants


enum uint AVRF_MAX_TRACES = 0x00000020U;

// Callbacks

alias AVRF_RESOURCE_ENUMERATE_CALLBACK = uint function(void* ResourceDescription, void* EnumerationContext, 
                                                       uint* EnumerationLevel);
alias AVRF_HEAPALLOCATION_ENUMERATE_CALLBACK = uint function(AVRF_HEAP_ALLOCATION* HeapAllocation, 
                                                             void* EnumerationContext, uint* EnumerationLevel);
alias AVRF_HANDLEOPERATION_ENUMERATE_CALLBACK = uint function(AVRF_HANDLE_OPERATION* HandleOperation, 
                                                              void* EnumerationContext, uint* EnumerationLevel);

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/avrfsdk/ns-avrfsdk-avrf_backtrace_information
struct AVRF_BACKTRACE_INFORMATION
{
    uint      Depth;
    uint      Index;
    ulong[32] ReturnAddresses;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/avrfsdk/ns-avrfsdk-avrf_heap_allocation
struct AVRF_HEAP_ALLOCATION
{
    ulong HeapHandle;
    ulong UserAllocation;
    ulong UserAllocationSize;
    ulong Allocation;
    ulong AllocationSize;
    uint  UserAllocationState;
    uint  HeapState;
    ulong HeapContext;
    AVRF_BACKTRACE_INFORMATION* BackTraceInformation;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/avrfsdk/ns-avrfsdk-avrf_handle_operation
struct AVRF_HANDLE_OPERATION
{
    ulong Handle;
    uint  ProcessId;
    uint  ThreadId;
    uint  OperationType;
    uint  Spare0;
    AVRF_BACKTRACE_INFORMATION BackTraceInformation;
}

// Functions

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/avrfsdk/nf-avrfsdk-verifierenumerateresource
@DllImport("verifier.dll")
uint VerifierEnumerateResource(HANDLE Process, VERIFIER_ENUM_RESOURCE_FLAGS Flags, 
                               /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(eAvrfResourceTypes))], [])*/uint ResourceType, 
                               AVRF_RESOURCE_ENUMERATE_CALLBACK ResourceCallback, void* EnumerationContext);


