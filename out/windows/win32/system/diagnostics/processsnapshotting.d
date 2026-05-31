// Written in the D programming language.

module windows.win32.system.diagnostics.processsnapshotting;

public import windows.core;
public import windows.win32.foundation : BOOL, FILETIME, HANDLE, PWSTR;
public import windows.win32.system.diagnostics.debug : CONTEXT;
public import windows.win32.system.memory : MEMORY_BASIC_INFORMATION;

extern(Windows) @nogc nothrow:


// Enums

//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/processsnapshot/ne-processsnapshot-pss_handle_flags))], [])
alias PSS_HANDLE_FLAGS = int;
enum : int
{
    PSS_HANDLE_NONE                           = 0x00000000,
    PSS_HANDLE_HAVE_TYPE                      = 0x00000001,
    PSS_HANDLE_HAVE_NAME                      = 0x00000002,
    PSS_HANDLE_HAVE_BASIC_INFORMATION         = 0x00000004,
    PSS_HANDLE_HAVE_TYPE_SPECIFIC_INFORMATION = 0x00000008,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/processsnapshot/ne-processsnapshot-pss_object_type))], [])
alias PSS_OBJECT_TYPE = int;
enum : int
{
    PSS_OBJECT_TYPE_UNKNOWN   = 0x00000000,
    PSS_OBJECT_TYPE_PROCESS   = 0x00000001,
    PSS_OBJECT_TYPE_THREAD    = 0x00000002,
    PSS_OBJECT_TYPE_MUTANT    = 0x00000003,
    PSS_OBJECT_TYPE_EVENT     = 0x00000004,
    PSS_OBJECT_TYPE_SECTION   = 0x00000005,
    PSS_OBJECT_TYPE_SEMAPHORE = 0x00000006,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/processsnapshot/ne-processsnapshot-pss_capture_flags))], [])
alias PSS_CAPTURE_FLAGS = uint;
enum : uint
{
    PSS_CAPTURE_NONE                             = 0x00000000,
    PSS_CAPTURE_VA_CLONE                         = 0x00000001,
    PSS_CAPTURE_RESERVED_00000002                = 0x00000002,
    PSS_CAPTURE_HANDLES                          = 0x00000004,
    PSS_CAPTURE_HANDLE_NAME_INFORMATION          = 0x00000008,
    PSS_CAPTURE_HANDLE_BASIC_INFORMATION         = 0x00000010,
    PSS_CAPTURE_HANDLE_TYPE_SPECIFIC_INFORMATION = 0x00000020,
    PSS_CAPTURE_HANDLE_TRACE                     = 0x00000040,
    PSS_CAPTURE_THREADS                          = 0x00000080,
    PSS_CAPTURE_THREAD_CONTEXT                   = 0x00000100,
    PSS_CAPTURE_THREAD_CONTEXT_EXTENDED          = 0x00000200,
    PSS_CAPTURE_RESERVED_00000400                = 0x00000400,
    PSS_CAPTURE_VA_SPACE                         = 0x00000800,
    PSS_CAPTURE_VA_SPACE_SECTION_INFORMATION     = 0x00001000,
    PSS_CAPTURE_IPT_TRACE                        = 0x00002000,
    PSS_CAPTURE_RESERVED_00004000                = 0x00004000,
    PSS_CREATE_BREAKAWAY_OPTIONAL                = 0x04000000,
    PSS_CREATE_BREAKAWAY                         = 0x08000000,
    PSS_CREATE_FORCE_BREAKAWAY                   = 0x10000000,
    PSS_CREATE_USE_VM_ALLOCATIONS                = 0x20000000,
    PSS_CREATE_MEASURE_PERFORMANCE               = 0x40000000,
    PSS_CREATE_RELEASE_SECTION                   = 0x80000000,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/processsnapshot/ne-processsnapshot-pss_query_information_class))], [])
alias PSS_QUERY_INFORMATION_CLASS = int;
enum : int
{
    PSS_QUERY_PROCESS_INFORMATION         = 0x00000000,
    PSS_QUERY_VA_CLONE_INFORMATION        = 0x00000001,
    PSS_QUERY_AUXILIARY_PAGES_INFORMATION = 0x00000002,
    PSS_QUERY_VA_SPACE_INFORMATION        = 0x00000003,
    PSS_QUERY_HANDLE_INFORMATION          = 0x00000004,
    PSS_QUERY_THREAD_INFORMATION          = 0x00000005,
    PSS_QUERY_HANDLE_TRACE_INFORMATION    = 0x00000006,
    PSS_QUERY_PERFORMANCE_COUNTERS        = 0x00000007,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/processsnapshot/ne-processsnapshot-pss_walk_information_class))], [])
alias PSS_WALK_INFORMATION_CLASS = int;
enum : int
{
    PSS_WALK_AUXILIARY_PAGES = 0x00000000,
    PSS_WALK_VA_SPACE        = 0x00000001,
    PSS_WALK_HANDLES         = 0x00000002,
    PSS_WALK_THREADS         = 0x00000003,
    PSS_WALK_THREAD_NAME     = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/processsnapshot/ne-processsnapshot-pss_duplicate_flags))], [])
alias PSS_DUPLICATE_FLAGS = int;
enum : int
{
    PSS_DUPLICATE_NONE         = 0x00000000,
    PSS_DUPLICATE_CLOSE_SOURCE = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/processsnapshot/ne-processsnapshot-pss_process_flags))], [])
alias PSS_PROCESS_FLAGS = int;
enum : int
{
    PSS_PROCESS_FLAGS_NONE        = 0x00000000,
    PSS_PROCESS_FLAGS_PROTECTED   = 0x00000001,
    PSS_PROCESS_FLAGS_WOW64       = 0x00000002,
    PSS_PROCESS_FLAGS_RESERVED_03 = 0x00000004,
    PSS_PROCESS_FLAGS_RESERVED_04 = 0x00000008,
    PSS_PROCESS_FLAGS_FROZEN      = 0x00000010,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/processsnapshot/ne-processsnapshot-pss_thread_flags))], [])
alias PSS_THREAD_FLAGS = int;
enum : int
{
    PSS_THREAD_FLAGS_NONE       = 0x00000000,
    PSS_THREAD_FLAGS_TERMINATED = 0x00000001,
}

// Constants


enum uint PSS_PERF_RESOLUTION = 0x000f4240;

// Structs


//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HPSS
{
    void* Value;
}

@RAIIFree!PssWalkMarkerFree
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HPSSWALK
{
    void* Value;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/processsnapshot/ns-processsnapshot-pss_process_information))], [])
struct PSS_PROCESS_INFORMATION
{
    uint              ExitStatus;
    void*             PebBaseAddress;
    size_t            AffinityMask;
    int               BasePriority;
    uint              ProcessId;
    uint              ParentProcessId;
    PSS_PROCESS_FLAGS Flags;
    FILETIME          CreateTime;
    FILETIME          ExitTime;
    FILETIME          KernelTime;
    FILETIME          UserTime;
    uint              PriorityClass;
    size_t            PeakVirtualSize;
    size_t            VirtualSize;
    uint              PageFaultCount;
    size_t            PeakWorkingSetSize;
    size_t            WorkingSetSize;
    size_t            QuotaPeakPagedPoolUsage;
    size_t            QuotaPagedPoolUsage;
    size_t            QuotaPeakNonPagedPoolUsage;
    size_t            QuotaNonPagedPoolUsage;
    size_t            PagefileUsage;
    size_t            PeakPagefileUsage;
    size_t            PrivateUsage;
    uint              ExecuteFlags;
    wchar[260]        ImageFileName;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/processsnapshot/ns-processsnapshot-pss_va_clone_information))], [])
struct PSS_VA_CLONE_INFORMATION
{
    HANDLE VaCloneHandle;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/processsnapshot/ns-processsnapshot-pss_auxiliary_pages_information))], [])
struct PSS_AUXILIARY_PAGES_INFORMATION
{
    uint AuxPagesCaptured;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/processsnapshot/ns-processsnapshot-pss_va_space_information))], [])
struct PSS_VA_SPACE_INFORMATION
{
    uint RegionCount;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/processsnapshot/ns-processsnapshot-pss_handle_information))], [])
struct PSS_HANDLE_INFORMATION
{
    uint HandlesCaptured;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/processsnapshot/ns-processsnapshot-pss_thread_information))], [])
struct PSS_THREAD_INFORMATION
{
    uint ThreadsCaptured;
    uint ContextLength;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/processsnapshot/ns-processsnapshot-pss_handle_trace_information))], [])
struct PSS_HANDLE_TRACE_INFORMATION
{
    HANDLE SectionHandle;
    uint   Size;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/processsnapshot/ns-processsnapshot-pss_performance_counters))], [])
struct PSS_PERFORMANCE_COUNTERS
{
    ulong TotalCycleCount;
    ulong TotalWallClockPeriod;
    ulong VaCloneCycleCount;
    ulong VaCloneWallClockPeriod;
    ulong VaSpaceCycleCount;
    ulong VaSpaceWallClockPeriod;
    ulong AuxPagesCycleCount;
    ulong AuxPagesWallClockPeriod;
    ulong HandlesCycleCount;
    ulong HandlesWallClockPeriod;
    ulong ThreadsCycleCount;
    ulong ThreadsWallClockPeriod;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/processsnapshot/ns-processsnapshot-pss_auxiliary_page_entry))], [])
struct PSS_AUXILIARY_PAGE_ENTRY
{
    void*    Address;
    MEMORY_BASIC_INFORMATION BasicInformation;
    FILETIME CaptureTime;
    void*    PageContents;
    uint     PageSize;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/processsnapshot/ns-processsnapshot-pss_va_space_entry))], [])
struct PSS_VA_SPACE_ENTRY
{
    void*        BaseAddress;
    void*        AllocationBase;
    uint         AllocationProtect;
    size_t       RegionSize;
    uint         State;
    uint         Protect;
    uint         Type;
    uint         TimeDateStamp;
    uint         SizeOfImage;
    void*        ImageBase;
    uint         CheckSum;
    ushort       MappedFileNameLength;
    const(PWSTR) MappedFileName;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/processsnapshot/ns-processsnapshot-pss_handle_entry))], [])
struct PSS_HANDLE_ENTRY
{
    HANDLE           Handle;
    PSS_HANDLE_FLAGS Flags;
    PSS_OBJECT_TYPE  ObjectType;
    FILETIME         CaptureTime;
    uint             Attributes;
    uint             GrantedAccess;
    uint             HandleCount;
    uint             PointerCount;
    uint             PagedPoolCharge;
    uint             NonPagedPoolCharge;
    FILETIME         CreationTime;
    ushort           TypeNameLength;
    const(PWSTR)     TypeName;
    ushort           ObjectNameLength;
    const(PWSTR)     ObjectName;
    _TypeSpecificInformation_e__Union TypeSpecificInformation;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/processsnapshot/ns-processsnapshot-pss_thread_entry))], [])
struct PSS_THREAD_ENTRY
{
    uint             ExitStatus;
    void*            TebBaseAddress;
    uint             ProcessId;
    uint             ThreadId;
    size_t           AffinityMask;
    int              Priority;
    int              BasePriority;
    void*            LastSyscallFirstArgument;
    ushort           LastSyscallNumber;
    FILETIME         CreateTime;
    FILETIME         ExitTime;
    FILETIME         KernelTime;
    FILETIME         UserTime;
    void*            Win32StartAddress;
    FILETIME         CaptureTime;
    PSS_THREAD_FLAGS Flags;
    ushort           SuspendCount;
    ushort           SizeOfContextRecord;
    CONTEXT*         ContextRecord;
}

struct PSS_THREAD_NAME
{
    ushort       ThreadNameSize;
    const(PWSTR) ThreadName;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/processsnapshot/ns-processsnapshot-pss_allocator))], [])
struct PSS_ALLOCATOR
{
    void*     Context;
    ptrdiff_t AllocRoutine;
    ptrdiff_t FreeRoutine;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("KERNEL32.dll")
uint PssCaptureSnapshot(HANDLE ProcessHandle, PSS_CAPTURE_FLAGS CaptureFlags, uint ThreadContextFlags, 
                        HPSS* SnapshotHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("KERNEL32.dll")
uint PssFreeSnapshot(HANDLE ProcessHandle, HPSS SnapshotHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("KERNEL32.dll")
uint PssQuerySnapshot(HPSS SnapshotHandle, PSS_QUERY_INFORMATION_CLASS InformationClass, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Buffer, 
                      uint BufferLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("KERNEL32.dll")
uint PssWalkSnapshot(HPSS SnapshotHandle, PSS_WALK_INFORMATION_CLASS InformationClass, HPSSWALK WalkMarkerHandle, 
                     void* Buffer, uint BufferLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("KERNEL32.dll")
uint PssDuplicateSnapshot(HANDLE SourceProcessHandle, HPSS SnapshotHandle, HANDLE TargetProcessHandle, 
                          HPSS* TargetSnapshotHandle, PSS_DUPLICATE_FLAGS Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("KERNEL32.dll")
uint PssWalkMarkerCreate(const(PSS_ALLOCATOR)* Allocator, HPSSWALK* WalkMarkerHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("KERNEL32.dll")
uint PssWalkMarkerFree(HPSSWALK WalkMarkerHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("KERNEL32.dll")
uint PssWalkMarkerGetPosition(HPSSWALK WalkMarkerHandle, size_t* Position);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("KERNEL32.dll")
uint PssWalkMarkerSetPosition(HPSSWALK WalkMarkerHandle, size_t Position);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("KERNEL32.dll")
uint PssWalkMarkerSeekToBeginning(HPSSWALK WalkMarkerHandle);


