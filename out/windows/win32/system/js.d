// Written in the D programming language.

module windows.win32.system.js;

public import windows.core;
public import windows.win32.foundation.foundation : HRESULT, PWSTR;
public import windows.win32.system.diagnostics.debug_.activescript : IActiveScriptProfilerCallback,
                                                                     IActiveScriptProfilerHeapEnum,
                                                                     IDebugApplication32,
                                                                     IDebugApplication64,
                                                                     PROFILER_EVENT_MASK;
public import windows.win32.system.variant : VARIANT;

extern(Windows) @nogc nothrow:


// Enums


enum JsRuntimeVersion : int
{
    JsRuntimeVersion10   = 0x00000000,
    JsRuntimeVersion11   = 0x00000001,
    JsRuntimeVersionEdge = 0xffffffff,
}

enum JsErrorCode : uint
{
    JsNoError                         = 0x00000000U,
    JsErrorCategoryUsage              = 0x00010000U,
    JsErrorInvalidArgument            = 0x00010001U,
    JsErrorNullArgument               = 0x00010002U,
    JsErrorNoCurrentContext           = 0x00010003U,
    JsErrorInExceptionState           = 0x00010004U,
    JsErrorNotImplemented             = 0x00010005U,
    JsErrorWrongThread                = 0x00010006U,
    JsErrorRuntimeInUse               = 0x00010007U,
    JsErrorBadSerializedScript        = 0x00010008U,
    JsErrorInDisabledState            = 0x00010009U,
    JsErrorCannotDisableExecution     = 0x0001000aU,
    JsErrorHeapEnumInProgress         = 0x0001000bU,
    JsErrorArgumentNotObject          = 0x0001000cU,
    JsErrorInProfileCallback          = 0x0001000dU,
    JsErrorInThreadServiceCallback    = 0x0001000eU,
    JsErrorCannotSerializeDebugScript = 0x0001000fU,
    JsErrorAlreadyDebuggingContext    = 0x00010010U,
    JsErrorAlreadyProfilingContext    = 0x00010011U,
    JsErrorIdleNotEnabled             = 0x00010012U,
    JsErrorCategoryEngine             = 0x00020000U,
    JsErrorOutOfMemory                = 0x00020001U,
    JsErrorCategoryScript             = 0x00030000U,
    JsErrorScriptException            = 0x00030001U,
    JsErrorScriptCompile              = 0x00030002U,
    JsErrorScriptTerminated           = 0x00030003U,
    JsErrorScriptEvalDisabled         = 0x00030004U,
    JsErrorCategoryFatal              = 0x00040000U,
    JsErrorFatal                      = 0x00040001U,
}

enum JsRuntimeAttributes : int
{
    JsRuntimeAttributeNone                        = 0x00000000,
    JsRuntimeAttributeDisableBackgroundWork       = 0x00000001,
    JsRuntimeAttributeAllowScriptInterrupt        = 0x00000002,
    JsRuntimeAttributeEnableIdleProcessing        = 0x00000004,
    JsRuntimeAttributeDisableNativeCodeGeneration = 0x00000008,
    JsRuntimeAttributeDisableEval                 = 0x00000010,
}

enum JsMemoryEventType : int
{
    JsMemoryAllocate = 0x00000000,
    JsMemoryFree     = 0x00000001,
    JsMemoryFailure  = 0x00000002,
}

enum JsValueType : int
{
    JsUndefined = 0x00000000,
    JsNull      = 0x00000001,
    JsNumber    = 0x00000002,
    JsString    = 0x00000003,
    JsBoolean   = 0x00000004,
    JsObject    = 0x00000005,
    JsFunction  = 0x00000006,
    JsError     = 0x00000007,
    JsArray     = 0x00000008,
}

// Constants


enum ulong JS_SOURCE_CONTEXT_NONE = 0xffffffffffffffffUL;

// Callbacks

alias JsMemoryAllocationCallback = bool function(void* callbackState, JsMemoryEventType allocationEvent, 
                                                 size_t allocationSize);
alias JsBeforeCollectCallback = void function(void* callbackState);
alias JsBackgroundWorkItemCallback = void function(void* callbackState);
alias JsThreadServiceCallback = bool function(JsBackgroundWorkItemCallback callback, void* callbackState);
alias JsFinalizeCallback = void function(void* data);
alias JsNativeFunction = void* function(void* callee, bool isConstructCall, void** arguments, ushort argumentCount, 
                                        void* callbackState);

// Functions


version(X86_64)
{
    @DllImport("chakra.dll")
JsErrorCode JsCreateContext(void* runtime, IDebugApplication64 debugApplication, void** newContext);
}

version(AArch64)
{
    @DllImport("chakra.dll")
JsErrorCode JsCreateContext(void* runtime, IDebugApplication64 debugApplication, void** newContext);
}

version(X86_64)
{
    @DllImport("chakra.dll")
JsErrorCode JsStartDebugging(IDebugApplication64 debugApplication);
}

version(AArch64)
{
    @DllImport("chakra.dll")
JsErrorCode JsStartDebugging(IDebugApplication64 debugApplication);
}
@DllImport("chakra.dll")
JsErrorCode JsCreateRuntime(JsRuntimeAttributes attributes, JsRuntimeVersion runtimeVersion, 
                            JsThreadServiceCallback threadService, void** runtime);

@DllImport("chakra.dll")
JsErrorCode JsCollectGarbage(void* runtime);

@DllImport("chakra.dll")
JsErrorCode JsDisposeRuntime(void* runtime);

@DllImport("chakra.dll")
JsErrorCode JsGetRuntimeMemoryUsage(void* runtime, size_t* memoryUsage);

@DllImport("chakra.dll")
JsErrorCode JsGetRuntimeMemoryLimit(void* runtime, size_t* memoryLimit);

@DllImport("chakra.dll")
JsErrorCode JsSetRuntimeMemoryLimit(void* runtime, size_t memoryLimit);

@DllImport("chakra.dll")
JsErrorCode JsSetRuntimeMemoryAllocationCallback(void* runtime, void* callbackState, 
                                                 JsMemoryAllocationCallback allocationCallback);

@DllImport("chakra.dll")
JsErrorCode JsSetRuntimeBeforeCollectCallback(void* runtime, void* callbackState, 
                                              JsBeforeCollectCallback beforeCollectCallback);

@DllImport("chakra.dll")
JsErrorCode JsAddRef(void* ref_, uint* count);

@DllImport("chakra.dll")
JsErrorCode JsRelease(void* ref_, uint* count);


version(X86)
{
    @DllImport("chakra.dll")
JsErrorCode JsCreateContext(void* runtime, IDebugApplication32 debugApplication, void** newContext);
}
@DllImport("chakra.dll")
JsErrorCode JsGetCurrentContext(void** currentContext);

@DllImport("chakra.dll")
JsErrorCode JsSetCurrentContext(void* context);

@DllImport("chakra.dll")
JsErrorCode JsGetRuntime(void* context, void** runtime);


version(X86)
{
    @DllImport("chakra.dll")
JsErrorCode JsStartDebugging(IDebugApplication32 debugApplication);
}
@DllImport("chakra.dll")
JsErrorCode JsIdle(uint* nextIdleTick);

@DllImport("chakra.dll")
JsErrorCode JsParseScript(const(PWSTR) script, size_t sourceContext, const(PWSTR) sourceUrl, void** result);

@DllImport("chakra.dll")
JsErrorCode JsRunScript(const(PWSTR) script, size_t sourceContext, const(PWSTR) sourceUrl, void** result);

@DllImport("chakra.dll")
JsErrorCode JsSerializeScript(const(PWSTR) script, ubyte* buffer, uint* bufferSize);

@DllImport("chakra.dll")
JsErrorCode JsParseSerializedScript(const(PWSTR) script, ubyte* buffer, size_t sourceContext, 
                                    const(PWSTR) sourceUrl, void** result);

@DllImport("chakra.dll")
JsErrorCode JsRunSerializedScript(const(PWSTR) script, ubyte* buffer, size_t sourceContext, const(PWSTR) sourceUrl, 
                                  void** result);

@DllImport("chakra.dll")
JsErrorCode JsGetPropertyIdFromName(const(PWSTR) name, void** propertyId);

@DllImport("chakra.dll")
JsErrorCode JsGetPropertyNameFromId(void* propertyId, const(ushort)** name);

@DllImport("chakra.dll")
JsErrorCode JsGetUndefinedValue(void** undefinedValue);

@DllImport("chakra.dll")
JsErrorCode JsGetNullValue(void** nullValue);

@DllImport("chakra.dll")
JsErrorCode JsGetTrueValue(void** trueValue);

@DllImport("chakra.dll")
JsErrorCode JsGetFalseValue(void** falseValue);

@DllImport("chakra.dll")
JsErrorCode JsBoolToBoolean(ubyte value, void** booleanValue);

@DllImport("chakra.dll")
JsErrorCode JsBooleanToBool(void* value, bool* boolValue);

@DllImport("chakra.dll")
JsErrorCode JsConvertValueToBoolean(void* value, void** booleanValue);

@DllImport("chakra.dll")
JsErrorCode JsGetValueType(void* value, JsValueType* type);

@DllImport("chakra.dll")
JsErrorCode JsDoubleToNumber(double doubleValue, void** value);

@DllImport("chakra.dll")
JsErrorCode JsIntToNumber(int intValue, void** value);

@DllImport("chakra.dll")
JsErrorCode JsNumberToDouble(void* value, double* doubleValue);

@DllImport("chakra.dll")
JsErrorCode JsConvertValueToNumber(void* value, void** numberValue);

@DllImport("chakra.dll")
JsErrorCode JsGetStringLength(void* stringValue, int* length);

@DllImport("chakra.dll")
JsErrorCode JsPointerToString(const(PWSTR) stringValue, size_t stringLength, void** value);

@DllImport("chakra.dll")
JsErrorCode JsStringToPointer(void* value, const(ushort)** stringValue, size_t* stringLength);

@DllImport("chakra.dll")
JsErrorCode JsConvertValueToString(void* value, void** stringValue);

@DllImport("chakra.dll")
JsErrorCode JsVariantToValue(VARIANT* variant, void** value);

@DllImport("chakra.dll")
JsErrorCode JsValueToVariant(void* object, VARIANT* variant);

@DllImport("chakra.dll")
JsErrorCode JsGetGlobalObject(void** globalObject);

@DllImport("chakra.dll")
JsErrorCode JsCreateObject(void** object);

@DllImport("chakra.dll")
JsErrorCode JsCreateExternalObject(void* data, JsFinalizeCallback finalizeCallback, void** object);

@DllImport("chakra.dll")
JsErrorCode JsConvertValueToObject(void* value, void** object);

@DllImport("chakra.dll")
JsErrorCode JsGetPrototype(void* object, void** prototypeObject);

@DllImport("chakra.dll")
JsErrorCode JsSetPrototype(void* object, void* prototypeObject);

@DllImport("chakra.dll")
JsErrorCode JsGetExtensionAllowed(void* object, bool* value);

@DllImport("chakra.dll")
JsErrorCode JsPreventExtension(void* object);

@DllImport("chakra.dll")
JsErrorCode JsGetProperty(void* object, void* propertyId, void** value);

@DllImport("chakra.dll")
JsErrorCode JsGetOwnPropertyDescriptor(void* object, void* propertyId, void** propertyDescriptor);

@DllImport("chakra.dll")
JsErrorCode JsGetOwnPropertyNames(void* object, void** propertyNames);

@DllImport("chakra.dll")
JsErrorCode JsSetProperty(void* object, void* propertyId, void* value, ubyte useStrictRules);

@DllImport("chakra.dll")
JsErrorCode JsHasProperty(void* object, void* propertyId, bool* hasProperty);

@DllImport("chakra.dll")
JsErrorCode JsDeleteProperty(void* object, void* propertyId, ubyte useStrictRules, void** result);

@DllImport("chakra.dll")
JsErrorCode JsDefineProperty(void* object, void* propertyId, void* propertyDescriptor, bool* result);

@DllImport("chakra.dll")
JsErrorCode JsHasIndexedProperty(void* object, void* index, bool* result);

@DllImport("chakra.dll")
JsErrorCode JsGetIndexedProperty(void* object, void* index, void** result);

@DllImport("chakra.dll")
JsErrorCode JsSetIndexedProperty(void* object, void* index, void* value);

@DllImport("chakra.dll")
JsErrorCode JsDeleteIndexedProperty(void* object, void* index);

@DllImport("chakra.dll")
JsErrorCode JsEquals(void* object1, void* object2, bool* result);

@DllImport("chakra.dll")
JsErrorCode JsStrictEquals(void* object1, void* object2, bool* result);

@DllImport("chakra.dll")
JsErrorCode JsHasExternalData(void* object, bool* value);

@DllImport("chakra.dll")
JsErrorCode JsGetExternalData(void* object, void** externalData);

@DllImport("chakra.dll")
JsErrorCode JsSetExternalData(void* object, void* externalData);

@DllImport("chakra.dll")
JsErrorCode JsCreateArray(uint length, void** result);

@DllImport("chakra.dll")
JsErrorCode JsCallFunction(void* function_, void** arguments, ushort argumentCount, void** result);

@DllImport("chakra.dll")
JsErrorCode JsConstructObject(void* function_, void** arguments, ushort argumentCount, void** result);

@DllImport("chakra.dll")
JsErrorCode JsCreateFunction(JsNativeFunction nativeFunction, void* callbackState, void** function_);

@DllImport("chakra.dll")
JsErrorCode JsCreateError(void* message, void** error);

@DllImport("chakra.dll")
JsErrorCode JsCreateRangeError(void* message, void** error);

@DllImport("chakra.dll")
JsErrorCode JsCreateReferenceError(void* message, void** error);

@DllImport("chakra.dll")
JsErrorCode JsCreateSyntaxError(void* message, void** error);

@DllImport("chakra.dll")
JsErrorCode JsCreateTypeError(void* message, void** error);

@DllImport("chakra.dll")
JsErrorCode JsCreateURIError(void* message, void** error);

@DllImport("chakra.dll")
JsErrorCode JsHasException(bool* hasException);

@DllImport("chakra.dll")
JsErrorCode JsGetAndClearException(void** exception);

@DllImport("chakra.dll")
JsErrorCode JsSetException(void* exception);

@DllImport("chakra.dll")
JsErrorCode JsDisableRuntimeExecution(void* runtime);

@DllImport("chakra.dll")
JsErrorCode JsEnableRuntimeExecution(void* runtime);

@DllImport("chakra.dll")
JsErrorCode JsIsRuntimeExecutionDisabled(void* runtime, bool* isDisabled);

@DllImport("chakra.dll")
JsErrorCode JsStartProfiling(IActiveScriptProfilerCallback callback, PROFILER_EVENT_MASK eventMask, uint context);

@DllImport("chakra.dll")
JsErrorCode JsStopProfiling(HRESULT reason);

@DllImport("chakra.dll")
JsErrorCode JsEnumerateHeap(IActiveScriptProfilerHeapEnum* enumerator);

@DllImport("chakra.dll")
JsErrorCode JsIsEnumeratingHeap(bool* isEnumeratingHeap);


