// Written in the D programming language.

module windows.win32.system.diagnostics.clrprofiling;

public import windows.core;
public import system : Guid;
public import windows.win32.foundation : BOOL, HANDLE, HRESULT, PWSTR;
public import windows.win32.system.com : IUnknown;
public import windows.win32.system.winrt.metadata : ASSEMBLYMETADATA, COR_FIELD_OFFSET,
                                                    CorElementType;

extern(Windows) @nogc nothrow:


// Enums

enum CorDebugIlToNativeMappingTypes : int
{
    NO_MAPPING = 0xffffffff,
    PROLOG     = 0xfffffffe,
    EPILOG     = 0xfffffffd,
}
alias COR_PRF_SNAPSHOT_INFO = int;
enum : int
{
    COR_PRF_SNAPSHOT_DEFAULT          = 0x00000000,
    COR_PRF_SNAPSHOT_REGISTER_CONTEXT = 0x00000001,
    COR_PRF_SNAPSHOT_X86_OPTIMIZED    = 0x00000002,
}
alias COR_PRF_STATIC_TYPE = int;
enum : int
{
    COR_PRF_FIELD_NOT_A_STATIC      = 0x00000000,
    COR_PRF_FIELD_APP_DOMAIN_STATIC = 0x00000001,
    COR_PRF_FIELD_THREAD_STATIC     = 0x00000002,
    COR_PRF_FIELD_CONTEXT_STATIC    = 0x00000004,
    COR_PRF_FIELD_RVA_STATIC        = 0x00000008,
}
alias COR_PRF_MONITOR = int;
enum : int
{
    COR_PRF_MONITOR_NONE                                 = 0x00000000,
    COR_PRF_MONITOR_FUNCTION_UNLOADS                     = 0x00000001,
    COR_PRF_MONITOR_CLASS_LOADS                          = 0x00000002,
    COR_PRF_MONITOR_MODULE_LOADS                         = 0x00000004,
    COR_PRF_MONITOR_ASSEMBLY_LOADS                       = 0x00000008,
    COR_PRF_MONITOR_APPDOMAIN_LOADS                      = 0x00000010,
    COR_PRF_MONITOR_JIT_COMPILATION                      = 0x00000020,
    COR_PRF_MONITOR_EXCEPTIONS                           = 0x00000040,
    COR_PRF_MONITOR_GC                                   = 0x00000080,
    COR_PRF_MONITOR_OBJECT_ALLOCATED                     = 0x00000100,
    COR_PRF_MONITOR_THREADS                              = 0x00000200,
    COR_PRF_MONITOR_REMOTING                             = 0x00000400,
    COR_PRF_MONITOR_CODE_TRANSITIONS                     = 0x00000800,
    COR_PRF_MONITOR_ENTERLEAVE                           = 0x00001000,
    COR_PRF_MONITOR_CCW                                  = 0x00002000,
    COR_PRF_MONITOR_REMOTING_COOKIE                      = 0x00004400,
    COR_PRF_MONITOR_REMOTING_ASYNC                       = 0x00008400,
    COR_PRF_MONITOR_SUSPENDS                             = 0x00010000,
    COR_PRF_MONITOR_CACHE_SEARCHES                       = 0x00020000,
    COR_PRF_ENABLE_REJIT                                 = 0x00040000,
    COR_PRF_ENABLE_INPROC_DEBUGGING                      = 0x00080000,
    COR_PRF_ENABLE_JIT_MAPS                              = 0x00100000,
    COR_PRF_DISABLE_INLINING                             = 0x00200000,
    COR_PRF_DISABLE_OPTIMIZATIONS                        = 0x00400000,
    COR_PRF_ENABLE_OBJECT_ALLOCATED                      = 0x00800000,
    COR_PRF_MONITOR_CLR_EXCEPTIONS                       = 0x01000000,
    COR_PRF_MONITOR_ALL                                  = 0x0107ffff,
    COR_PRF_ENABLE_FUNCTION_ARGS                         = 0x02000000,
    COR_PRF_ENABLE_FUNCTION_RETVAL                       = 0x04000000,
    COR_PRF_ENABLE_FRAME_INFO                            = 0x08000000,
    COR_PRF_ENABLE_STACK_SNAPSHOT                        = 0x10000000,
    COR_PRF_USE_PROFILE_IMAGES                           = 0x20000000,
    COR_PRF_DISABLE_TRANSPARENCY_CHECKS_UNDER_FULL_TRUST = 0x40000000,
    COR_PRF_DISABLE_ALL_NGEN_IMAGES                      = 0x80000000,
    COR_PRF_ALL                                          = 0x8fffffff,
    COR_PRF_REQUIRE_PROFILE_IMAGE                        = 0x20001800,
    COR_PRF_ALLOWABLE_AFTER_ATTACH                       = 0x100502fe,
    COR_PRF_ALLOWABLE_NOTIFICATION_PROFILER              = 0xb1e32b7f,
    COR_PRF_MONITOR_IMMUTABLE                            = 0xeef8cc00,
}
alias COR_PRF_HIGH_MONITOR = int;
enum : int
{
    COR_PRF_HIGH_MONITOR_NONE                     = 0x00000000,
    COR_PRF_HIGH_ADD_ASSEMBLY_REFERENCES          = 0x00000001,
    COR_PRF_HIGH_IN_MEMORY_SYMBOLS_UPDATED        = 0x00000002,
    COR_PRF_HIGH_MONITOR_DYNAMIC_FUNCTION_UNLOADS = 0x00000004,
    COR_PRF_HIGH_DISABLE_TIERED_COMPILATION       = 0x00000008,
    COR_PRF_HIGH_BASIC_GC                         = 0x00000010,
    COR_PRF_HIGH_MONITOR_GC_MOVED_OBJECTS         = 0x00000020,
    COR_PRF_HIGH_REQUIRE_PROFILE_IMAGE            = 0x00000000,
    COR_PRF_HIGH_MONITOR_LARGEOBJECT_ALLOCATED    = 0x00000040,
    COR_PRF_HIGH_MONITOR_EVENT_PIPE               = 0x00000080,
    COR_PRF_HIGH_MONITOR_PINNEDOBJECT_ALLOCATED   = 0x00000100,
    COR_PRF_HIGH_ALLOWABLE_AFTER_ATTACH           = 0x000000f6,
    COR_PRF_HIGH_ALLOWABLE_NOTIFICATION_PROFILER  = 0x000000fe,
    COR_PRF_HIGH_MONITOR_IMMUTABLE                = 0x00000008,
}
alias COR_PRF_MISC = int;
enum : int
{
    PROFILER_PARENT_UNKNOWN = 0xfffffffd,
    PROFILER_GLOBAL_CLASS   = 0xfffffffe,
    PROFILER_GLOBAL_MODULE  = 0xffffffff,
}
alias COR_PRF_JIT_CACHE = int;
enum : int
{
    COR_PRF_CACHED_FUNCTION_FOUND     = 0x00000000,
    COR_PRF_CACHED_FUNCTION_NOT_FOUND = 0x00000001,
}
alias COR_PRF_TRANSITION_REASON = int;
enum : int
{
    COR_PRF_TRANSITION_CALL   = 0x00000000,
    COR_PRF_TRANSITION_RETURN = 0x00000001,
}
alias COR_PRF_SUSPEND_REASON = int;
enum : int
{
    COR_PRF_SUSPEND_OTHER                  = 0x00000000,
    COR_PRF_SUSPEND_FOR_GC                 = 0x00000001,
    COR_PRF_SUSPEND_FOR_APPDOMAIN_SHUTDOWN = 0x00000002,
    COR_PRF_SUSPEND_FOR_CODE_PITCHING      = 0x00000003,
    COR_PRF_SUSPEND_FOR_SHUTDOWN           = 0x00000004,
    COR_PRF_SUSPEND_FOR_INPROC_DEBUGGER    = 0x00000006,
    COR_PRF_SUSPEND_FOR_GC_PREP            = 0x00000007,
    COR_PRF_SUSPEND_FOR_REJIT              = 0x00000008,
    COR_PRF_SUSPEND_FOR_PROFILER           = 0x00000009,
}
alias COR_PRF_RUNTIME_TYPE = int;
enum : int
{
    COR_PRF_DESKTOP_CLR = 0x00000001,
    COR_PRF_CORE_CLR    = 0x00000002,
}
alias COR_PRF_REJIT_FLAGS = int;
enum : int
{
    COR_PRF_REJIT_BLOCK_INLINING     = 0x00000001,
    COR_PRF_REJIT_INLINING_CALLBACKS = 0x00000002,
}
alias COR_PRF_EVENTPIPE_PARAM_TYPE = int;
enum : int
{
    COR_PRF_EVENTPIPE_OBJECT   = 0x00000001,
    COR_PRF_EVENTPIPE_BOOLEAN  = 0x00000003,
    COR_PRF_EVENTPIPE_CHAR     = 0x00000004,
    COR_PRF_EVENTPIPE_SBYTE    = 0x00000005,
    COR_PRF_EVENTPIPE_BYTE     = 0x00000006,
    COR_PRF_EVENTPIPE_INT16    = 0x00000007,
    COR_PRF_EVENTPIPE_UINT16   = 0x00000008,
    COR_PRF_EVENTPIPE_INT32    = 0x00000009,
    COR_PRF_EVENTPIPE_UINT32   = 0x0000000a,
    COR_PRF_EVENTPIPE_INT64    = 0x0000000b,
    COR_PRF_EVENTPIPE_UINT64   = 0x0000000c,
    COR_PRF_EVENTPIPE_SINGLE   = 0x0000000d,
    COR_PRF_EVENTPIPE_DOUBLE   = 0x0000000e,
    COR_PRF_EVENTPIPE_DECIMAL  = 0x0000000f,
    COR_PRF_EVENTPIPE_DATETIME = 0x00000010,
    COR_PRF_EVENTPIPE_GUID     = 0x00000011,
    COR_PRF_EVENTPIPE_STRING   = 0x00000012,
    COR_PRF_EVENTPIPE_ARRAY    = 0x00000013,
}
alias COR_PRF_EVENTPIPE_LEVEL = int;
enum : int
{
    COR_PRF_EVENTPIPE_LOGALWAYS     = 0x00000000,
    COR_PRF_EVENTPIPE_CRITICAL      = 0x00000001,
    COR_PRF_EVENTPIPE_ERROR         = 0x00000002,
    COR_PRF_EVENTPIPE_WARNING       = 0x00000003,
    COR_PRF_EVENTPIPE_INFORMATIONAL = 0x00000004,
    COR_PRF_EVENTPIPE_VERBOSE       = 0x00000005,
}
alias COR_PRF_HANDLE_TYPE = int;
enum : int
{
    COR_PRF_HANDLE_TYPE_WEAK   = 0x00000001,
    COR_PRF_HANDLE_TYPE_STRONG = 0x00000002,
    COR_PRF_HANDLE_TYPE_PINNED = 0x00000003,
}
alias COR_PRF_GC_ROOT_KIND = int;
enum : int
{
    COR_PRF_GC_ROOT_STACK     = 0x00000001,
    COR_PRF_GC_ROOT_FINALIZER = 0x00000002,
    COR_PRF_GC_ROOT_HANDLE    = 0x00000003,
    COR_PRF_GC_ROOT_OTHER     = 0x00000000,
}
alias COR_PRF_GC_ROOT_FLAGS = int;
enum : int
{
    COR_PRF_GC_ROOT_PINNING    = 0x00000001,
    COR_PRF_GC_ROOT_WEAKREF    = 0x00000002,
    COR_PRF_GC_ROOT_INTERIOR   = 0x00000004,
    COR_PRF_GC_ROOT_REFCOUNTED = 0x00000008,
}
alias COR_PRF_FINALIZER_FLAGS = int;
enum : int
{
    COR_PRF_FINALIZER_CRITICAL = 0x00000001,
}
alias COR_PRF_GC_GENERATION = int;
enum : int
{
    COR_PRF_GC_GEN_0              = 0x00000000,
    COR_PRF_GC_GEN_1              = 0x00000001,
    COR_PRF_GC_GEN_2              = 0x00000002,
    COR_PRF_GC_LARGE_OBJECT_HEAP  = 0x00000003,
    COR_PRF_GC_PINNED_OBJECT_HEAP = 0x00000004,
}
alias COR_PRF_CLAUSE_TYPE = int;
enum : int
{
    COR_PRF_CLAUSE_NONE    = 0x00000000,
    COR_PRF_CLAUSE_FILTER  = 0x00000001,
    COR_PRF_CLAUSE_CATCH   = 0x00000002,
    COR_PRF_CLAUSE_FINALLY = 0x00000003,
}
alias COR_PRF_GC_REASON = int;
enum : int
{
    COR_PRF_GC_INDUCED = 0x00000001,
    COR_PRF_GC_OTHER   = 0x00000000,
}
alias COR_PRF_MODULE_FLAGS = int;
enum : int
{
    COR_PRF_MODULE_DISK            = 0x00000001,
    COR_PRF_MODULE_NGEN            = 0x00000002,
    COR_PRF_MODULE_DYNAMIC         = 0x00000004,
    COR_PRF_MODULE_COLLECTIBLE     = 0x00000008,
    COR_PRF_MODULE_RESOURCE        = 0x00000010,
    COR_PRF_MODULE_FLAT_LAYOUT     = 0x00000020,
    COR_PRF_MODULE_WINDOWS_RUNTIME = 0x00000040,
}
alias COR_PRF_CODEGEN_FLAGS = int;
enum : int
{
    COR_PRF_CODEGEN_DISABLE_INLINING          = 0x00000001,
    COR_PRF_CODEGEN_DISABLE_ALL_OPTIMIZATIONS = 0x00000002,
}

// Callbacks

alias FunctionIDMapper = size_t function(size_t funcId, BOOL* pbHookFunction);
alias FunctionIDMapper2 = size_t function(size_t funcId, void* clientData, BOOL* pbHookFunction);
alias FunctionEnter = void function(size_t funcID);
alias FunctionLeave = void function(size_t funcID);
alias FunctionTailcall = void function(size_t funcID);
alias FunctionEnter2 = void function(size_t funcId, size_t clientData, size_t func, 
                                     COR_PRF_FUNCTION_ARGUMENT_INFO* argumentInfo);
alias FunctionLeave2 = void function(size_t funcId, size_t clientData, size_t func, 
                                     COR_PRF_FUNCTION_ARGUMENT_RANGE* retvalRange);
alias FunctionTailcall2 = void function(size_t funcId, size_t clientData, size_t func);
alias FunctionEnter3 = void function(FunctionIDOrClientID functionIDOrClientID);
alias FunctionLeave3 = void function(FunctionIDOrClientID functionIDOrClientID);
alias FunctionTailcall3 = void function(FunctionIDOrClientID functionIDOrClientID);
alias FunctionEnter3WithInfo = void function(FunctionIDOrClientID functionIDOrClientID, size_t eltInfo);
alias FunctionLeave3WithInfo = void function(FunctionIDOrClientID functionIDOrClientID, size_t eltInfo);
alias FunctionTailcall3WithInfo = void function(FunctionIDOrClientID functionIDOrClientID, size_t eltInfo);
alias StackSnapshotCallback = HRESULT function(size_t funcId, size_t ip, size_t frameInfo, uint contextSize, 
                                               ubyte* context, void* clientData);
alias ObjectReferenceCallback = BOOL function(size_t root, size_t* reference, void* clientData);
alias EventPipeProviderCallback = void function(const(ubyte)* source_id, uint is_enabled, ubyte level, 
                                                ulong match_any_keywords, ulong match_all_keywords, 
                                                COR_PRF_FILTER_DATA* filter_data, void* callback_data);

// Structs


struct COR_IL_MAP
{
    uint oldOffset;
    uint newOffset;
    BOOL fAccurate;
}

struct COR_DEBUG_IL_TO_NATIVE_MAP
{
    uint ilOffset;
    uint nativeStartOffset;
    uint nativeEndOffset;
}

union FunctionIDOrClientID
{
    size_t functionID;
    size_t clientID;
}

struct COR_PRF_FUNCTION_ARGUMENT_RANGE
{
    size_t startAddress;
    uint   length;
}

struct COR_PRF_FUNCTION_ARGUMENT_INFO
{
    uint numRanges;
    uint totalArgumentSize;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/COR_PRF_FUNCTION_ARGUMENT_RANGE[1] ranges;
}

struct COR_PRF_CODE_INFO
{
    size_t startAddress;
    size_t size;
}

struct COR_PRF_FUNCTION
{
    size_t functionId;
    size_t reJitId;
}

struct COR_PRF_ASSEMBLY_REFERENCE_INFO
{
    void*             pbPublicKeyOrToken;
    uint              cbPublicKeyOrToken;
    const(PWSTR)      szName;
    ASSEMBLYMETADATA* pMetaData;
    void*             pbHashValue;
    uint              cbHashValue;
    uint              dwAssemblyRefFlags;
}

struct COR_PRF_METHOD
{
    size_t moduleId;
    uint   methodId;
}

struct COR_PRF_EVENTPIPE_PROVIDER_CONFIG
{
    const(PWSTR) providerName;
    ulong        keywords;
    uint         loggingLevel;
    const(PWSTR) filterData;
}

struct COR_PRF_EVENTPIPE_PARAM_DESC
{
    uint         type;
    uint         elementType;
    const(PWSTR) name;
}

struct COR_PRF_EVENT_DATA
{
    ulong ptr;
    uint  size;
    uint  reserved;
}

struct COR_PRF_FILTER_DATA
{
    ulong Ptr;
    uint  Size;
    uint  Type;
}

struct COR_PRF_GC_GENERATION_RANGE
{
    COR_PRF_GC_GENERATION generation;
    size_t rangeStart;
    size_t rangeLength;
    size_t rangeLengthReserved;
}

struct COR_PRF_NONGC_HEAP_RANGE
{
    size_t rangeStart;
    size_t rangeLength;
    size_t rangeLengthReserved;
}

struct COR_PRF_EX_CLAUSE_INFO
{
    COR_PRF_CLAUSE_TYPE clauseType;
    size_t              programCounter;
    size_t              framePointer;
    size_t              shadowStackPointer;
}

// Interfaces

@GUID("176fbed1-a55c-4796-98ca-a9da0ef883e7")
interface ICorProfilerCallback : IUnknown
{
    HRESULT Initialize(IUnknown pICorProfilerInfoUnk);
    HRESULT Shutdown();
    HRESULT AppDomainCreationStarted(size_t appDomainId);
    HRESULT AppDomainCreationFinished(size_t appDomainId, HRESULT hrStatus);
    HRESULT AppDomainShutdownStarted(size_t appDomainId);
    HRESULT AppDomainShutdownFinished(size_t appDomainId, HRESULT hrStatus);
    HRESULT AssemblyLoadStarted(size_t assemblyId);
    HRESULT AssemblyLoadFinished(size_t assemblyId, HRESULT hrStatus);
    HRESULT AssemblyUnloadStarted(size_t assemblyId);
    HRESULT AssemblyUnloadFinished(size_t assemblyId, HRESULT hrStatus);
    HRESULT ModuleLoadStarted(size_t moduleId);
    HRESULT ModuleLoadFinished(size_t moduleId, HRESULT hrStatus);
    HRESULT ModuleUnloadStarted(size_t moduleId);
    HRESULT ModuleUnloadFinished(size_t moduleId, HRESULT hrStatus);
    HRESULT ModuleAttachedToAssembly(size_t moduleId, size_t AssemblyId);
    HRESULT ClassLoadStarted(size_t classId);
    HRESULT ClassLoadFinished(size_t classId, HRESULT hrStatus);
    HRESULT ClassUnloadStarted(size_t classId);
    HRESULT ClassUnloadFinished(size_t classId, HRESULT hrStatus);
    HRESULT FunctionUnloadStarted(size_t functionId);
    HRESULT JITCompilationStarted(size_t functionId, BOOL fIsSafeToBlock);
    HRESULT JITCompilationFinished(size_t functionId, HRESULT hrStatus, BOOL fIsSafeToBlock);
    HRESULT JITCachedFunctionSearchStarted(size_t functionId, BOOL* pbUseCachedFunction);
    HRESULT JITCachedFunctionSearchFinished(size_t functionId, COR_PRF_JIT_CACHE result);
    HRESULT JITFunctionPitched(size_t functionId);
    HRESULT JITInlining(size_t callerId, size_t calleeId, BOOL* pfShouldInline);
    HRESULT ThreadCreated(size_t threadId);
    HRESULT ThreadDestroyed(size_t threadId);
    HRESULT ThreadAssignedToOSThread(size_t managedThreadId, uint osThreadId);
    HRESULT RemotingClientInvocationStarted();
    HRESULT RemotingClientSendingMessage(GUID* pCookie, BOOL fIsAsync);
    HRESULT RemotingClientReceivingReply(GUID* pCookie, BOOL fIsAsync);
    HRESULT RemotingClientInvocationFinished();
    HRESULT RemotingServerReceivingMessage(GUID* pCookie, BOOL fIsAsync);
    HRESULT RemotingServerInvocationStarted();
    HRESULT RemotingServerInvocationReturned();
    HRESULT RemotingServerSendingReply(GUID* pCookie, BOOL fIsAsync);
    HRESULT UnmanagedToManagedTransition(size_t functionId, COR_PRF_TRANSITION_REASON reason);
    HRESULT ManagedToUnmanagedTransition(size_t functionId, COR_PRF_TRANSITION_REASON reason);
    HRESULT RuntimeSuspendStarted(COR_PRF_SUSPEND_REASON suspendReason);
    HRESULT RuntimeSuspendFinished();
    HRESULT RuntimeSuspendAborted();
    HRESULT RuntimeResumeStarted();
    HRESULT RuntimeResumeFinished();
    HRESULT RuntimeThreadSuspended(size_t threadId);
    HRESULT RuntimeThreadResumed(size_t threadId);
    HRESULT MovedReferences(uint cMovedObjectIDRanges, size_t* oldObjectIDRangeStart, 
                            size_t* newObjectIDRangeStart, uint* cObjectIDRangeLength);
    HRESULT ObjectAllocated(size_t objectId, size_t classId);
    HRESULT ObjectsAllocatedByClass(uint cClassCount, size_t* classIds, uint* cObjects);
    HRESULT ObjectReferences(size_t objectId, size_t classId, uint cObjectRefs, size_t* objectRefIds);
    HRESULT RootReferences(uint cRootRefs, size_t* rootRefIds);
    HRESULT ExceptionThrown(size_t thrownObjectId);
    HRESULT ExceptionSearchFunctionEnter(size_t functionId);
    HRESULT ExceptionSearchFunctionLeave();
    HRESULT ExceptionSearchFilterEnter(size_t functionId);
    HRESULT ExceptionSearchFilterLeave();
    HRESULT ExceptionSearchCatcherFound(size_t functionId);
    HRESULT ExceptionOSHandlerEnter(size_t __unused);
    HRESULT ExceptionOSHandlerLeave(size_t __unused);
    HRESULT ExceptionUnwindFunctionEnter(size_t functionId);
    HRESULT ExceptionUnwindFunctionLeave();
    HRESULT ExceptionUnwindFinallyEnter(size_t functionId);
    HRESULT ExceptionUnwindFinallyLeave();
    HRESULT ExceptionCatcherEnter(size_t functionId, size_t objectId);
    HRESULT ExceptionCatcherLeave();
    HRESULT COMClassicVTableCreated(size_t wrappedClassId, const(GUID)* implementedIID, void* pVTable, uint cSlots);
    HRESULT COMClassicVTableDestroyed(size_t wrappedClassId, const(GUID)* implementedIID, void* pVTable);
    HRESULT ExceptionCLRCatcherFound();
    HRESULT ExceptionCLRCatcherExecute();
}

@GUID("8a8cc829-ccf2-49fe-bbae-0f022228071a")
interface ICorProfilerCallback2 : ICorProfilerCallback
{
    HRESULT ThreadNameChanged(size_t threadId, uint cchName, PWSTR name);
    HRESULT GarbageCollectionStarted(int cGenerations, BOOL* generationCollected, COR_PRF_GC_REASON reason);
    HRESULT SurvivingReferences(uint cSurvivingObjectIDRanges, size_t* objectIDRangeStart, 
                                uint* cObjectIDRangeLength);
    HRESULT GarbageCollectionFinished();
    HRESULT FinalizeableObjectQueued(uint finalizerFlags, size_t objectID);
    HRESULT RootReferences2(uint cRootRefs, size_t* rootRefIds, COR_PRF_GC_ROOT_KIND* rootKinds, 
                            COR_PRF_GC_ROOT_FLAGS* rootFlags, size_t* rootIds);
    HRESULT HandleCreated(size_t handleId, size_t initialObjectId);
    HRESULT HandleDestroyed(size_t handleId);
}

@GUID("4fd2ed52-7731-4b8d-9469-03d2cc3086c5")
interface ICorProfilerCallback3 : ICorProfilerCallback2
{
    HRESULT InitializeForAttach(IUnknown pCorProfilerInfoUnk, void* pvClientData, uint cbClientData);
    HRESULT ProfilerAttachComplete();
    HRESULT ProfilerDetachSucceeded();
}

@GUID("7b63b2e3-107d-4d48-b2f6-f61e229470d2")
interface ICorProfilerCallback4 : ICorProfilerCallback3
{
    HRESULT ReJITCompilationStarted(size_t functionId, size_t rejitId, BOOL fIsSafeToBlock);
    HRESULT GetReJITParameters(size_t moduleId, uint methodId, ICorProfilerFunctionControl pFunctionControl);
    HRESULT ReJITCompilationFinished(size_t functionId, size_t rejitId, HRESULT hrStatus, BOOL fIsSafeToBlock);
    HRESULT ReJITError(size_t moduleId, uint methodId, size_t functionId, HRESULT hrStatus);
    HRESULT MovedReferences2(uint cMovedObjectIDRanges, size_t* oldObjectIDRangeStart, 
                             size_t* newObjectIDRangeStart, size_t* cObjectIDRangeLength);
    HRESULT SurvivingReferences2(uint cSurvivingObjectIDRanges, size_t* objectIDRangeStart, 
                                 size_t* cObjectIDRangeLength);
}

@GUID("8dfba405-8c9f-45f8-bffa-83b14cef78b5")
interface ICorProfilerCallback5 : ICorProfilerCallback4
{
    HRESULT ConditionalWeakTableElementReferences(uint cRootRefs, size_t* keyRefIds, size_t* valueRefIds, 
                                                  size_t* rootIds);
}

@GUID("fc13df4b-4448-4f4f-950c-ba8d19d00c36")
interface ICorProfilerCallback6 : ICorProfilerCallback5
{
    HRESULT GetAssemblyReferences(const(PWSTR) wszAssemblyPath, 
                                  ICorProfilerAssemblyReferenceProvider pAsmRefProvider);
}

@GUID("f76a2dba-1d52-4539-866c-2aa518f9efc3")
interface ICorProfilerCallback7 : ICorProfilerCallback6
{
    HRESULT ModuleInMemorySymbolsUpdated(size_t moduleId);
}

@GUID("5bed9b15-c079-4d47-bfe2-215a140c07e0")
interface ICorProfilerCallback8 : ICorProfilerCallback7
{
    HRESULT DynamicMethodJITCompilationStarted(size_t functionId, BOOL fIsSafeToBlock, ubyte* pILHeader, 
                                               uint cbILHeader);
    HRESULT DynamicMethodJITCompilationFinished(size_t functionId, HRESULT hrStatus, BOOL fIsSafeToBlock);
}

@GUID("27583ec3-c8f5-482f-8052-194b8ce4705a")
interface ICorProfilerCallback9 : ICorProfilerCallback8
{
    HRESULT DynamicMethodUnloaded(size_t functionId);
}

@GUID("cec5b60e-c69c-495f-87f6-84d28ee16ffb")
interface ICorProfilerCallback10 : ICorProfilerCallback9
{
    HRESULT EventPipeEventDelivered(size_t provider, uint eventId, uint eventVersion, uint cbMetadataBlob, 
                                    ubyte* metadataBlob, uint cbEventData, ubyte* eventData, 
                                    const(GUID)* pActivityId, const(GUID)* pRelatedActivityId, size_t eventThread, 
                                    uint numStackFrames, size_t* stackFrames);
    HRESULT EventPipeProviderCreated(size_t provider);
}

@GUID("42350846-aaed-47f7-b128-fd0c98881cde")
interface ICorProfilerCallback11 : ICorProfilerCallback10
{
    HRESULT LoadAsNotificationOnly(BOOL* pbNotificationOnly);
}

@GUID("28b5557d-3f3f-48b4-90b2-5f9eea2f6c48")
interface ICorProfilerInfo : IUnknown
{
    HRESULT GetClassFromObject(size_t objectId, size_t* pClassId);
    HRESULT GetClassFromToken(size_t moduleId, uint typeDef, size_t* pClassId);
    HRESULT GetCodeInfo(size_t functionId, ubyte** pStart, uint* pcSize);
    HRESULT GetEventMask(uint* pdwEvents);
    HRESULT GetFunctionFromIP(ubyte* ip, size_t* pFunctionId);
    HRESULT GetFunctionFromToken(size_t moduleId, uint token, size_t* pFunctionId);
    HRESULT GetHandleFromThread(size_t threadId, HANDLE* phThread);
    HRESULT GetObjectSize(size_t objectId, uint* pcSize);
    HRESULT IsArrayClass(size_t classId, CorElementType* pBaseElemType, size_t* pBaseClassId, uint* pcRank);
    HRESULT GetThreadInfo(size_t threadId, uint* pdwWin32ThreadId);
    HRESULT GetCurrentThreadID(size_t* pThreadId);
    HRESULT GetClassIDInfo(size_t classId, size_t* pModuleId, uint* pTypeDefToken);
    HRESULT GetFunctionInfo(size_t functionId, size_t* pClassId, size_t* pModuleId, uint* pToken);
    HRESULT SetEventMask(uint dwEvents);
    HRESULT SetEnterLeaveFunctionHooks(FunctionEnter* pFuncEnter, FunctionLeave* pFuncLeave, 
                                       FunctionTailcall* pFuncTailcall);
    HRESULT SetFunctionIDMapper(FunctionIDMapper* pFunc);
    HRESULT GetTokenAndMetaDataFromFunction(size_t functionId, const(GUID)* riid, IUnknown* ppImport, uint* pToken);
    HRESULT GetModuleInfo(size_t moduleId, ubyte** ppBaseLoadAddress, uint cchName, uint* pcchName, PWSTR szName, 
                          size_t* pAssemblyId);
    HRESULT GetModuleMetaData(size_t moduleId, uint dwOpenFlags, const(GUID)* riid, IUnknown* ppOut);
    HRESULT GetILFunctionBody(size_t moduleId, uint methodId, ubyte** ppMethodHeader, uint* pcbMethodSize);
    HRESULT GetILFunctionBodyAllocator(size_t moduleId, IMethodMalloc* ppMalloc);
    HRESULT SetILFunctionBody(size_t moduleId, uint methodid, ubyte* pbNewILMethodHeader);
    HRESULT GetAppDomainInfo(size_t appDomainId, uint cchName, uint* pcchName, PWSTR szName, size_t* pProcessId);
    HRESULT GetAssemblyInfo(size_t assemblyId, uint cchName, uint* pcchName, PWSTR szName, size_t* pAppDomainId, 
                            size_t* pModuleId);
    HRESULT SetFunctionReJIT(size_t functionId);
    HRESULT ForceGC();
    HRESULT SetILInstrumentedCodeMap(size_t functionId, BOOL fStartJit, uint cILMapEntries, 
                                     COR_IL_MAP* rgILMapEntries);
    HRESULT GetInprocInspectionInterface(IUnknown* ppicd);
    HRESULT GetInprocInspectionIThisThread(IUnknown* ppicd);
    HRESULT GetThreadContext(size_t threadId, size_t* pContextId);
    HRESULT BeginInprocDebugging(BOOL fThisThreadOnly, uint* pdwProfilerContext);
    HRESULT EndInprocDebugging(uint dwProfilerContext);
    HRESULT GetILToNativeMapping(size_t functionId, uint cMap, uint* pcMap, COR_DEBUG_IL_TO_NATIVE_MAP* map);
}

@GUID("cc0935cd-a518-487d-b0bb-a93214e65478")
interface ICorProfilerInfo2 : ICorProfilerInfo
{
    HRESULT DoStackSnapshot(size_t thread, StackSnapshotCallback* callback, uint infoFlags, void* clientData, 
                            ubyte* context, uint contextSize);
    HRESULT SetEnterLeaveFunctionHooks2(FunctionEnter2* pFuncEnter, FunctionLeave2* pFuncLeave, 
                                        FunctionTailcall2* pFuncTailcall);
    HRESULT GetFunctionInfo2(size_t funcId, size_t frameInfo, size_t* pClassId, size_t* pModuleId, uint* pToken, 
                             uint cTypeArgs, uint* pcTypeArgs, size_t* typeArgs);
    HRESULT GetStringLayout(uint* pBufferLengthOffset, uint* pStringLengthOffset, uint* pBufferOffset);
    HRESULT GetClassLayout(size_t classID, COR_FIELD_OFFSET* rFieldOffset, uint cFieldOffset, uint* pcFieldOffset, 
                           uint* pulClassSize);
    HRESULT GetClassIDInfo2(size_t classId, size_t* pModuleId, uint* pTypeDefToken, size_t* pParentClassId, 
                            uint cNumTypeArgs, uint* pcNumTypeArgs, size_t* typeArgs);
    HRESULT GetCodeInfo2(size_t functionID, uint cCodeInfos, uint* pcCodeInfos, COR_PRF_CODE_INFO* codeInfos);
    HRESULT GetClassFromTokenAndTypeArgs(size_t moduleID, uint typeDef, uint cTypeArgs, size_t* typeArgs, 
                                         size_t* pClassID);
    HRESULT GetFunctionFromTokenAndTypeArgs(size_t moduleID, uint funcDef, size_t classId, uint cTypeArgs, 
                                            size_t* typeArgs, size_t* pFunctionID);
    HRESULT EnumModuleFrozenObjects(size_t moduleID, ICorProfilerObjectEnum* ppEnum);
    HRESULT GetArrayObjectInfo(size_t objectId, uint cDimensions, uint* pDimensionSizes, 
                               int* pDimensionLowerBounds, ubyte** ppData);
    HRESULT GetBoxClassLayout(size_t classId, uint* pBufferOffset);
    HRESULT GetThreadAppDomain(size_t threadId, size_t* pAppDomainId);
    HRESULT GetRVAStaticAddress(size_t classId, uint fieldToken, void** ppAddress);
    HRESULT GetAppDomainStaticAddress(size_t classId, uint fieldToken, size_t appDomainId, void** ppAddress);
    HRESULT GetThreadStaticAddress(size_t classId, uint fieldToken, size_t threadId, void** ppAddress);
    HRESULT GetContextStaticAddress(size_t classId, uint fieldToken, size_t contextId, void** ppAddress);
    HRESULT GetStaticFieldInfo(size_t classId, uint fieldToken, COR_PRF_STATIC_TYPE* pFieldInfo);
    HRESULT GetGenerationBounds(uint cObjectRanges, uint* pcObjectRanges, COR_PRF_GC_GENERATION_RANGE* ranges);
    HRESULT GetObjectGeneration(size_t objectId, COR_PRF_GC_GENERATION_RANGE* range);
    HRESULT GetNotifiedExceptionClauseInfo(COR_PRF_EX_CLAUSE_INFO* pinfo);
}

@GUID("b555ed4f-452a-4e54-8b39-b5360bad32a0")
interface ICorProfilerInfo3 : ICorProfilerInfo2
{
    HRESULT EnumJITedFunctions(ICorProfilerFunctionEnum* ppEnum);
    HRESULT RequestProfilerDetach(uint dwExpectedCompletionMilliseconds);
    HRESULT SetFunctionIDMapper2(FunctionIDMapper2* pFunc, void* clientData);
    HRESULT GetStringLayout2(uint* pStringLengthOffset, uint* pBufferOffset);
    HRESULT SetEnterLeaveFunctionHooks3(FunctionEnter3* pFuncEnter3, FunctionLeave3* pFuncLeave3, 
                                        FunctionTailcall3* pFuncTailcall3);
    HRESULT SetEnterLeaveFunctionHooks3WithInfo(FunctionEnter3WithInfo* pFuncEnter3WithInfo, 
                                                FunctionLeave3WithInfo* pFuncLeave3WithInfo, 
                                                FunctionTailcall3WithInfo* pFuncTailcall3WithInfo);
    HRESULT GetFunctionEnter3Info(size_t functionId, size_t eltInfo, size_t* pFrameInfo, uint* pcbArgumentInfo, 
                                  COR_PRF_FUNCTION_ARGUMENT_INFO* pArgumentInfo);
    HRESULT GetFunctionLeave3Info(size_t functionId, size_t eltInfo, size_t* pFrameInfo, 
                                  COR_PRF_FUNCTION_ARGUMENT_RANGE* pRetvalRange);
    HRESULT GetFunctionTailcall3Info(size_t functionId, size_t eltInfo, size_t* pFrameInfo);
    HRESULT EnumModules(ICorProfilerModuleEnum* ppEnum);
    HRESULT GetRuntimeInformation(ushort* pClrInstanceId, COR_PRF_RUNTIME_TYPE* pRuntimeType, 
                                  ushort* pMajorVersion, ushort* pMinorVersion, ushort* pBuildNumber, 
                                  ushort* pQFEVersion, uint cchVersionString, uint* pcchVersionString, 
                                  PWSTR szVersionString);
    HRESULT GetThreadStaticAddress2(size_t classId, uint fieldToken, size_t appDomainId, size_t threadId, 
                                    void** ppAddress);
    HRESULT GetAppDomainsContainingModule(size_t moduleId, uint cAppDomainIds, uint* pcAppDomainIds, 
                                          size_t* appDomainIds);
    HRESULT GetModuleInfo2(size_t moduleId, ubyte** ppBaseLoadAddress, uint cchName, uint* pcchName, PWSTR szName, 
                           size_t* pAssemblyId, uint* pdwModuleFlags);
}

@GUID("2c6269bd-2d13-4321-ae12-6686365fd6af")
interface ICorProfilerObjectEnum : IUnknown
{
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(ICorProfilerObjectEnum* ppEnum);
    HRESULT GetCount(uint* pcelt);
    HRESULT Next(uint celt, size_t* objects, uint* pceltFetched);
}

@GUID("ff71301a-b994-429d-a10b-b345a65280ef")
interface ICorProfilerFunctionEnum : IUnknown
{
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(ICorProfilerFunctionEnum* ppEnum);
    HRESULT GetCount(uint* pcelt);
    HRESULT Next(uint celt, COR_PRF_FUNCTION* ids, uint* pceltFetched);
}

@GUID("b0266d75-2081-4493-af7f-028ba34db891")
interface ICorProfilerModuleEnum : IUnknown
{
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(ICorProfilerModuleEnum* ppEnum);
    HRESULT GetCount(uint* pcelt);
    HRESULT Next(uint celt, size_t* ids, uint* pceltFetched);
}

@GUID("a0efb28b-6ee2-4d7b-b983-a75ef7beedb8")
interface IMethodMalloc : IUnknown
{
    void* Alloc(uint cb);
}

@GUID("f0963021-e1ea-4732-8581-e01b0bd3c0c6")
interface ICorProfilerFunctionControl : IUnknown
{
    HRESULT SetCodegenFlags(uint flags);
    HRESULT SetILFunctionBody(uint cbNewILMethodHeader, ubyte* pbNewILMethodHeader);
    HRESULT SetILInstrumentedCodeMap(uint cILMapEntries, COR_IL_MAP* rgILMapEntries);
}

@GUID("0d8fdcaa-6257-47bf-b1bf-94dac88466ee")
interface ICorProfilerInfo4 : ICorProfilerInfo3
{
    HRESULT EnumThreads(ICorProfilerThreadEnum* ppEnum);
    HRESULT InitializeCurrentThread();
    HRESULT RequestReJIT(uint cFunctions, size_t* moduleIds, uint* methodIds);
    HRESULT RequestRevert(uint cFunctions, size_t* moduleIds, uint* methodIds, HRESULT* status);
    HRESULT GetCodeInfo3(size_t functionID, size_t reJitId, uint cCodeInfos, uint* pcCodeInfos, 
                         COR_PRF_CODE_INFO* codeInfos);
    HRESULT GetFunctionFromIP2(ubyte* ip, size_t* pFunctionId, size_t* pReJitId);
    HRESULT GetReJITIDs(size_t functionId, uint cReJitIds, uint* pcReJitIds, size_t* reJitIds);
    HRESULT GetILToNativeMapping2(size_t functionId, size_t reJitId, uint cMap, uint* pcMap, 
                                  COR_DEBUG_IL_TO_NATIVE_MAP* map);
    HRESULT EnumJITedFunctions2(ICorProfilerFunctionEnum* ppEnum);
    HRESULT GetObjectSize2(size_t objectId, size_t* pcSize);
}

@GUID("07602928-ce38-4b83-81e7-74adaf781214")
interface ICorProfilerInfo5 : ICorProfilerInfo4
{
    HRESULT GetEventMask2(uint* pdwEventsLow, uint* pdwEventsHigh);
    HRESULT SetEventMask2(uint dwEventsLow, uint dwEventsHigh);
}

@GUID("f30a070d-bffb-46a7-b1d8-8781ef7b698a")
interface ICorProfilerInfo6 : ICorProfilerInfo5
{
    HRESULT EnumNgenModuleMethodsInliningThisMethod(size_t inlinersModuleId, size_t inlineeModuleId, 
                                                    uint inlineeMethodId, BOOL* incompleteData, 
                                                    ICorProfilerMethodEnum* ppEnum);
}

@GUID("9aeecc0d-63e0-4187-8c00-e312f503f663")
interface ICorProfilerInfo7 : ICorProfilerInfo6
{
    HRESULT ApplyMetaData(size_t moduleId);
    HRESULT GetInMemorySymbolsLength(size_t moduleId, uint* pCountSymbolBytes);
    HRESULT ReadInMemorySymbols(size_t moduleId, uint symbolsReadOffset, ubyte* pSymbolBytes, 
                                uint countSymbolBytes, uint* pCountSymbolBytesRead);
}

@GUID("c5ac80a6-782e-4716-8044-39598c60cfbf")
interface ICorProfilerInfo8 : ICorProfilerInfo7
{
    HRESULT IsFunctionDynamic(size_t functionId, BOOL* isDynamic);
    HRESULT GetFunctionFromIP3(ubyte* ip, size_t* functionId, size_t* pReJitId);
    HRESULT GetDynamicFunctionInfo(size_t functionId, size_t* moduleId, ubyte** ppvSig, uint* pbSig, uint cchName, 
                                   uint* pcchName, PWSTR wszName);
}

@GUID("008170db-f8cc-4796-9a51-dc8aa0b47012")
interface ICorProfilerInfo9 : ICorProfilerInfo8
{
    HRESULT GetNativeCodeStartAddresses(size_t functionID, size_t reJitId, uint cCodeStartAddresses, 
                                        uint* pcCodeStartAddresses, size_t* codeStartAddresses);
    HRESULT GetILToNativeMapping3(size_t pNativeCodeStartAddress, uint cMap, uint* pcMap, 
                                  COR_DEBUG_IL_TO_NATIVE_MAP* map);
    HRESULT GetCodeInfo4(size_t pNativeCodeStartAddress, uint cCodeInfos, uint* pcCodeInfos, 
                         COR_PRF_CODE_INFO* codeInfos);
}

@GUID("2f1b5152-c869-40c9-aa5f-3abe026bd720")
interface ICorProfilerInfo10 : ICorProfilerInfo9
{
    HRESULT EnumerateObjectReferences(size_t objectId, ObjectReferenceCallback callback, void* clientData);
    HRESULT IsFrozenObject(size_t objectId, BOOL* pbFrozen);
    HRESULT GetLOHObjectSizeThreshold(uint* pThreshold);
    HRESULT RequestReJITWithInliners(uint dwRejitFlags, uint cFunctions, size_t* moduleIds, uint* methodIds);
    HRESULT SuspendRuntime();
    HRESULT ResumeRuntime();
}

@GUID("06398876-8987-4154-b621-40a00d6e4d04")
interface ICorProfilerInfo11 : ICorProfilerInfo10
{
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
    HRESULT GetEnvironmentVariableA(const(PWSTR) szName, uint cchValue, uint* pcchValue, PWSTR szValue);
    HRESULT SetEnvironmentVariable(const(PWSTR) szName, const(PWSTR) szValue);
}

@GUID("27b24ccd-1cb1-47c5-96ee-98190dc30959")
interface ICorProfilerInfo12 : ICorProfilerInfo11
{
    HRESULT EventPipeStartSession(uint cProviderConfigs, COR_PRF_EVENTPIPE_PROVIDER_CONFIG* pProviderConfigs, 
                                  BOOL requestRundown, ulong* pSession);
    HRESULT EventPipeAddProviderToSession(ulong session, COR_PRF_EVENTPIPE_PROVIDER_CONFIG providerConfig);
    HRESULT EventPipeStopSession(ulong session);
    HRESULT EventPipeCreateProvider(const(PWSTR) providerName, size_t* pProvider);
    HRESULT EventPipeGetProviderInfo(size_t provider, uint cchName, uint* pcchName, PWSTR providerName);
    HRESULT EventPipeDefineEvent(size_t provider, const(PWSTR) eventName, uint eventID, ulong keywords, 
                                 uint eventVersion, uint level, ubyte opcode, BOOL needStack, uint cParamDescs, 
                                 COR_PRF_EVENTPIPE_PARAM_DESC* pParamDescs, size_t* pEvent);
    HRESULT EventPipeWriteEvent(size_t event, uint cData, COR_PRF_EVENT_DATA* data, const(GUID)* pActivityId, 
                                const(GUID)* pRelatedActivityId);
}

@GUID("6e6c7ee2-0701-4ec2-9d29-2e8733b66934")
interface ICorProfilerInfo13 : ICorProfilerInfo12
{
    HRESULT CreateHandle(size_t object, COR_PRF_HANDLE_TYPE type, void*** pHandle);
    HRESULT DestroyHandle(void** handle);
    HRESULT GetObjectIDFromHandle(void** handle, size_t* pObject);
}

@GUID("f460e352-d76d-4fe9-835f-f6af9d6e862d")
interface ICorProfilerInfo14 : ICorProfilerInfo13
{
    HRESULT EnumerateNonGCObjects(ICorProfilerObjectEnum* ppEnum);
    HRESULT GetNonGCHeapBounds(uint cObjectRanges, uint* pcObjectRanges, COR_PRF_NONGC_HEAP_RANGE* ranges);
    HRESULT EventPipeCreateProvider2(const(PWSTR) providerName, EventPipeProviderCallback* pCallback, 
                                     size_t* pProvider);
}

@GUID("fccee788-0088-454b-a811-c99f298d1942")
interface ICorProfilerMethodEnum : IUnknown
{
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(ICorProfilerMethodEnum* ppEnum);
    HRESULT GetCount(uint* pcelt);
    HRESULT Next(uint celt, COR_PRF_METHOD* elements, uint* pceltFetched);
}

@GUID("571194f7-25ed-419f-aa8b-7016b3159701")
interface ICorProfilerThreadEnum : IUnknown
{
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(ICorProfilerThreadEnum* ppEnum);
    HRESULT GetCount(uint* pcelt);
    HRESULT Next(uint celt, size_t* ids, uint* pceltFetched);
}

@GUID("66a78c24-2eef-4f65-b45f-dd1d8038bf3c")
interface ICorProfilerAssemblyReferenceProvider : IUnknown
{
    HRESULT AddAssemblyReference(const(COR_PRF_ASSEMBLY_REFERENCE_INFO)* pAssemblyRefInfo);
}


// GUIDs


const GUID IID_ICorProfilerAssemblyReferenceProvider = GUIDOF!ICorProfilerAssemblyReferenceProvider;
const GUID IID_ICorProfilerCallback                  = GUIDOF!ICorProfilerCallback;
const GUID IID_ICorProfilerCallback10                = GUIDOF!ICorProfilerCallback10;
const GUID IID_ICorProfilerCallback11                = GUIDOF!ICorProfilerCallback11;
const GUID IID_ICorProfilerCallback2                 = GUIDOF!ICorProfilerCallback2;
const GUID IID_ICorProfilerCallback3                 = GUIDOF!ICorProfilerCallback3;
const GUID IID_ICorProfilerCallback4                 = GUIDOF!ICorProfilerCallback4;
const GUID IID_ICorProfilerCallback5                 = GUIDOF!ICorProfilerCallback5;
const GUID IID_ICorProfilerCallback6                 = GUIDOF!ICorProfilerCallback6;
const GUID IID_ICorProfilerCallback7                 = GUIDOF!ICorProfilerCallback7;
const GUID IID_ICorProfilerCallback8                 = GUIDOF!ICorProfilerCallback8;
const GUID IID_ICorProfilerCallback9                 = GUIDOF!ICorProfilerCallback9;
const GUID IID_ICorProfilerFunctionControl           = GUIDOF!ICorProfilerFunctionControl;
const GUID IID_ICorProfilerFunctionEnum              = GUIDOF!ICorProfilerFunctionEnum;
const GUID IID_ICorProfilerInfo                      = GUIDOF!ICorProfilerInfo;
const GUID IID_ICorProfilerInfo10                    = GUIDOF!ICorProfilerInfo10;
const GUID IID_ICorProfilerInfo11                    = GUIDOF!ICorProfilerInfo11;
const GUID IID_ICorProfilerInfo12                    = GUIDOF!ICorProfilerInfo12;
const GUID IID_ICorProfilerInfo13                    = GUIDOF!ICorProfilerInfo13;
const GUID IID_ICorProfilerInfo14                    = GUIDOF!ICorProfilerInfo14;
const GUID IID_ICorProfilerInfo2                     = GUIDOF!ICorProfilerInfo2;
const GUID IID_ICorProfilerInfo3                     = GUIDOF!ICorProfilerInfo3;
const GUID IID_ICorProfilerInfo4                     = GUIDOF!ICorProfilerInfo4;
const GUID IID_ICorProfilerInfo5                     = GUIDOF!ICorProfilerInfo5;
const GUID IID_ICorProfilerInfo6                     = GUIDOF!ICorProfilerInfo6;
const GUID IID_ICorProfilerInfo7                     = GUIDOF!ICorProfilerInfo7;
const GUID IID_ICorProfilerInfo8                     = GUIDOF!ICorProfilerInfo8;
const GUID IID_ICorProfilerInfo9                     = GUIDOF!ICorProfilerInfo9;
const GUID IID_ICorProfilerMethodEnum                = GUIDOF!ICorProfilerMethodEnum;
const GUID IID_ICorProfilerModuleEnum                = GUIDOF!ICorProfilerModuleEnum;
const GUID IID_ICorProfilerObjectEnum                = GUIDOF!ICorProfilerObjectEnum;
const GUID IID_ICorProfilerThreadEnum                = GUIDOF!ICorProfilerThreadEnum;
const GUID IID_IMethodMalloc                         = GUIDOF!IMethodMalloc;
