// Written in the D programming language.

module windows.win32.system.winrt.winrt;

public import windows.core;
public import system.system : Guid;
public import windows.system : DispatcherQueueController;
public import windows.win32.foundation.foundation : BOOL, BSTR, HRESULT, HWND, PWSTR;
public import windows.win32.system.com.com : IStream, IUnknown;
public import windows.win32.system.com.marshal : IMarshal;
public import windows.win32.ui.shell.propertiessystem : INamedPropertyStore;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/ne-objidl-activationtype
alias ACTIVATIONTYPE = int;
enum : int
{
    ACTIVATIONTYPE_UNCATEGORIZED = 0x00000000,
    ACTIVATIONTYPE_FROM_MONIKER  = 0x00000001,
    ACTIVATIONTYPE_FROM_DATA     = 0x00000002,
    ACTIVATIONTYPE_FROM_STORAGE  = 0x00000004,
    ACTIVATIONTYPE_FROM_STREAM   = 0x00000008,
    ACTIVATIONTYPE_FROM_FILE     = 0x00000010,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/combaseapi/ne-combaseapi-agilereferenceoptions
enum AgileReferenceOptions : int
{
    AGILEREFERENCE_DEFAULT        = 0x00000000,
    AGILEREFERENCE_DELAYEDMARSHAL = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/inspectable/ne-inspectable-trustlevel
enum TrustLevel : int
{
    BaseTrust    = 0x00000000,
    PartialTrust = 0x00000001,
    FullTrust    = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dispatcherqueue/ne-dispatcherqueue-dispatcherqueue_thread_apartmenttype
alias DISPATCHERQUEUE_THREAD_APARTMENTTYPE = int;
enum : int
{
    DQTAT_COM_NONE = 0x00000000,
    DQTAT_COM_ASTA = 0x00000001,
    DQTAT_COM_STA  = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dispatcherqueue/ne-dispatcherqueue-dispatcherqueue_thread_type
alias DISPATCHERQUEUE_THREAD_TYPE = int;
enum : int
{
    DQTYPE_THREAD_DEDICATED = 0x00000001,
    DQTYPE_THREAD_CURRENT   = 0x00000002,
}

alias CASTING_CONNECTION_ERROR_STATUS = int;
enum : int
{
    CASTING_CONNECTION_ERROR_STATUS_SUCCEEDED                 = 0x00000000,
    CASTING_CONNECTION_ERROR_STATUS_DEVICE_DID_NOT_RESPOND    = 0x00000001,
    CASTING_CONNECTION_ERROR_STATUS_DEVICE_ERROR              = 0x00000002,
    CASTING_CONNECTION_ERROR_STATUS_DEVICE_LOCKED             = 0x00000003,
    CASTING_CONNECTION_ERROR_STATUS_PROTECTED_PLAYBACK_FAILED = 0x00000004,
    CASTING_CONNECTION_ERROR_STATUS_INVALID_CASTING_SOURCE    = 0x00000005,
    CASTING_CONNECTION_ERROR_STATUS_UNKNOWN                   = 0x00000006,
}

alias CASTING_CONNECTION_STATE = int;
enum : int
{
    CASTING_CONNECTION_STATE_DISCONNECTED  = 0x00000000,
    CASTING_CONNECTION_STATE_CONNECTED     = 0x00000001,
    CASTING_CONNECTION_STATE_RENDERING     = 0x00000002,
    CASTING_CONNECTION_STATE_DISCONNECTING = 0x00000003,
    CASTING_CONNECTION_STATE_CONNECTING    = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/roapi/ne-roapi-ro_init_type
alias RO_INIT_TYPE = int;
enum : int
{
    RO_INIT_SINGLETHREADED = 0x00000000,
    RO_INIT_MULTITHREADED  = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/roerrorapi/ne-roerrorapi-ro_error_reporting_flags
alias RO_ERROR_REPORTING_FLAGS = int;
enum : int
{
    RO_ERROR_REPORTING_NONE                 = 0x00000000,
    RO_ERROR_REPORTING_SUPPRESSEXCEPTIONS   = 0x00000001,
    RO_ERROR_REPORTING_FORCEEXCEPTIONS      = 0x00000002,
    RO_ERROR_REPORTING_USESETERRORINFO      = 0x00000004,
    RO_ERROR_REPORTING_SUPPRESSSETERRORINFO = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shcore/ne-shcore-bsos_options
alias BSOS_OPTIONS = int;
enum : int
{
    BSOS_DEFAULT                 = 0x00000000,
    BSOS_PREFERDESTINATIONSTREAM = 0x00000001,
}

// Constants


enum uint MAX_ERROR_MESSAGE_CHARS = 0x00000200U;

enum : const(wchar)*
{
    CastingSourceInfo_Property_PreferredSourceUriScheme = "PreferredSourceUriScheme",
    CastingSourceInfo_Property_CastingTypes             = "CastingTypes",
    CastingSourceInfo_Property_ProtectedMedia           = "ProtectedMedia",
}

// Callbacks

alias PINSPECT_HSTRING_CALLBACK = HRESULT function(void* context, size_t readAddress, uint length, ubyte* buffer);
alias PINSPECT_HSTRING_CALLBACK2 = HRESULT function(void* context, ulong readAddress, uint length, ubyte* buffer);
alias PFNGETACTIVATIONFACTORY = HRESULT function(HSTRING param0, IActivationFactory* param1);
alias PINSPECT_MEMORY_CALLBACK = HRESULT function(void* context, size_t readAddress, uint length, ubyte* buffer);

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventtoken/ns-eventtoken-eventregistrationtoken
struct EventRegistrationToken
{
    long value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/hstring/ns-hstring-hstring_header
struct HSTRING_HEADER
{
    uint      flags;
    uint      length;
    uint      padding1;
    uint      padding2;
    ptrdiff_t data;
}

@RAIIFree!WindowsDeleteString
// Microsoft documentation: https://learn.microsoft.com/windows/win32/WinRT/hstring
struct HSTRING
{
    void* Value;
}

@RAIIFree!WindowsDeleteStringBuffer
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/WinRT/hstring-buffer
struct HSTRING_BUFFER
{
    void* Value;
}

//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct APARTMENT_SHUTDOWN_REGISTRATION_COOKIE
{
    void* Value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/WinRT/ro-registration-cookie
struct RO_REGISTRATION_COOKIE
{
    ptrdiff_t Value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/combaseapi/ns-combaseapi-serverinformation
struct ServerInformation
{
    uint  dwServerPid;
    uint  dwServerTid;
    ulong ui64ServerAddress;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dispatcherqueue/ns-dispatcherqueue-dispatcherqueueoptions
struct DispatcherQueueOptions
{
    uint dwSize;
    DISPATCHERQUEUE_THREAD_TYPE threadType;
    DISPATCHERQUEUE_THREAD_APARTMENTTYPE apartmentType;
}

// Functions

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-codecodeproxy
@DllImport("OLE32.dll")
HRESULT CoDecodeProxy(uint dwClientPid, ulong ui64ProxyAddress, ServerInformation* pServerInformation);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("OLE32.dll")
HRESULT RoGetAgileReference(AgileReferenceOptions options, const(GUID)* riid, IUnknown pUnk, 
                            IAgileReference* ppAgileReference);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
uint HSTRING_UserSize(uint* param0, uint param1, HSTRING* param2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
ubyte* HSTRING_UserMarshal(uint* param0, ubyte* param1, HSTRING* param2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
ubyte* HSTRING_UserUnmarshal(uint* param0, ubyte* param1, HSTRING* param2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
void HSTRING_UserFree(uint* param0, HSTRING* param1);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
uint HSTRING_UserSize64(uint* param0, uint param1, HSTRING* param2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
ubyte* HSTRING_UserMarshal64(uint* param0, ubyte* param1, HSTRING* param2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
ubyte* HSTRING_UserUnmarshal64(uint* param0, ubyte* param1, HSTRING* param2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
void HSTRING_UserFree64(uint* param0, HSTRING* param1);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
HRESULT WindowsCreateString(const(PWSTR) sourceString, uint length, HSTRING* string);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
HRESULT WindowsCreateStringReference(const(PWSTR) sourceString, uint length, HSTRING_HEADER* hstringHeader, 
                                     HSTRING* string);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
HRESULT WindowsDeleteString(HSTRING string);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
HRESULT WindowsDuplicateString(HSTRING string, HSTRING* newString);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
uint WindowsGetStringLen(HSTRING string);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
PWSTR WindowsGetStringRawBuffer(HSTRING string, uint* length);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
BOOL WindowsIsStringEmpty(HSTRING string);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
HRESULT WindowsStringHasEmbeddedNull(HSTRING string, BOOL* hasEmbedNull);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
HRESULT WindowsCompareStringOrdinal(HSTRING string1, HSTRING string2, int* result);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
HRESULT WindowsSubstring(HSTRING string, uint startIndex, HSTRING* newString);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
HRESULT WindowsSubstringWithSpecifiedLength(HSTRING string, uint startIndex, uint length, HSTRING* newString);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
HRESULT WindowsConcatString(HSTRING string1, HSTRING string2, HSTRING* newString);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
HRESULT WindowsReplaceString(HSTRING string, HSTRING stringReplaced, HSTRING stringReplaceWith, HSTRING* newString);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
HRESULT WindowsTrimStringStart(HSTRING string, HSTRING trimString, HSTRING* newString);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
HRESULT WindowsTrimStringEnd(HSTRING string, HSTRING trimString, HSTRING* newString);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
HRESULT WindowsPreallocateStringBuffer(uint length, ushort** charBuffer, HSTRING_BUFFER* bufferHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
HRESULT WindowsPromoteStringBuffer(HSTRING_BUFFER bufferHandle, HSTRING* string);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
HRESULT WindowsDeleteStringBuffer(HSTRING_BUFFER bufferHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-string-l1-1-0.dll")
HRESULT WindowsInspectString(size_t targetHString, ushort machine, PINSPECT_HSTRING_CALLBACK callback, 
                             void* context, uint* length, size_t* targetStringAddress);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-string-l1-1-1.dll")
HRESULT WindowsInspectString2(ulong targetHString, ushort machine, PINSPECT_HSTRING_CALLBACK2 callback, 
                              void* context, uint* length, ulong* targetStringAddress);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-l1-1-0.dll")
HRESULT RoInitialize(RO_INIT_TYPE initType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-l1-1-0.dll")
void RoUninitialize();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-l1-1-0.dll")
HRESULT RoActivateInstance(HSTRING activatableClassId, IInspectable* instance);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-l1-1-0.dll")
HRESULT RoRegisterActivationFactories(HSTRING* activatableClassIds, 
                                      PFNGETACTIVATIONFACTORY* activationFactoryCallbacks, uint count, 
                                      RO_REGISTRATION_COOKIE* cookie);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-l1-1-0.dll")
void RoRevokeActivationFactories(RO_REGISTRATION_COOKIE cookie);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-l1-1-0.dll")
HRESULT RoGetActivationFactory(HSTRING activatableClassId, const(GUID)* iid, void** factory);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-l1-1-0.dll")
HRESULT RoRegisterForApartmentShutdown(IApartmentShutdown callbackObject, ulong* apartmentIdentifier, 
                                       APARTMENT_SHUTDOWN_REGISTRATION_COOKIE* regCookie);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-l1-1-0.dll")
HRESULT RoUnregisterForApartmentShutdown(APARTMENT_SHUTDOWN_REGISTRATION_COOKIE regCookie);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-l1-1-0.dll")
HRESULT RoGetApartmentIdentifier(ulong* apartmentIdentifier);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-robuffer-l1-1-0.dll")
HRESULT RoGetBufferMarshaler(IMarshal* bufferMarshaler);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-error-l1-1-0.dll")
HRESULT RoGetErrorReportingFlags(uint* pflags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-error-l1-1-0.dll")
HRESULT RoSetErrorReportingFlags(uint flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-error-l1-1-0.dll")
HRESULT RoResolveRestrictedErrorInfoReference(const(PWSTR) reference, IRestrictedErrorInfo* ppRestrictedErrorInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-error-l1-1-0.dll")
HRESULT SetRestrictedErrorInfo(IRestrictedErrorInfo pRestrictedErrorInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-error-l1-1-0.dll")
HRESULT GetRestrictedErrorInfo(IRestrictedErrorInfo* ppRestrictedErrorInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-error-l1-1-0.dll")
BOOL RoOriginateErrorW(HRESULT error, uint cchMax, const(PWSTR) message);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-error-l1-1-0.dll")
BOOL RoOriginateError(HRESULT error, HSTRING message);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-error-l1-1-0.dll")
BOOL RoTransformErrorW(HRESULT oldError, HRESULT newError, uint cchMax, const(PWSTR) message);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-error-l1-1-0.dll")
BOOL RoTransformError(HRESULT oldError, HRESULT newError, HSTRING message);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-error-l1-1-0.dll")
HRESULT RoCaptureErrorContext(HRESULT hr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-error-l1-1-0.dll")
void RoFailFastWithErrorContext(HRESULT hrError);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("api-ms-win-core-winrt-error-l1-1-1.dll")
BOOL RoOriginateLanguageException(HRESULT error, HSTRING message, IUnknown languageException);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("api-ms-win-core-winrt-error-l1-1-1.dll")
void RoClearError();

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/roerrorapi/nf-roerrorapi-roreportunhandlederror
@DllImport("api-ms-win-core-winrt-error-l1-1-1.dll")
HRESULT RoReportUnhandledError(IRestrictedErrorInfo pRestrictedErrorInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("api-ms-win-core-winrt-error-l1-1-1.dll")
HRESULT RoInspectThreadErrorInfo(size_t targetTebAddress, ushort machine, 
                                 PINSPECT_MEMORY_CALLBACK readMemoryCallback, void* context, 
                                 size_t* targetErrorInfoAddress);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("api-ms-win-core-winrt-error-l1-1-1.dll")
HRESULT RoInspectCapturedStackBackTrace(size_t targetErrorInfoAddress, ushort machine, 
                                        PINSPECT_MEMORY_CALLBACK readMemoryCallback, void* context, uint* frameCount, 
                                        size_t* targetBackTraceAddress);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/roerrorapi/nf-roerrorapi-rogetmatchingrestrictederrorinfo
@DllImport("api-ms-win-core-winrt-error-l1-1-1.dll")
HRESULT RoGetMatchingRestrictedErrorInfo(HRESULT hrIn, IRestrictedErrorInfo* ppRestrictedErrorInfo);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/roerrorapi/nf-roerrorapi-roreportfaileddelegate
@DllImport("api-ms-win-core-winrt-error-l1-1-1.dll")
HRESULT RoReportFailedDelegate(IUnknown punkDelegate, IRestrictedErrorInfo pRestrictedErrorInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-error-l1-1-1.dll")
BOOL IsErrorPropagationEnabled();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-registration-l1-1-0.dll")
HRESULT RoGetServerActivatableClasses(HSTRING serverName, HSTRING** activatableClassIds, uint* count);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-shcore-stream-winrt-l1-1-0.dll")
HRESULT CreateRandomAccessStreamOnFile(const(PWSTR) filePath, uint accessMode, const(GUID)* riid, void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-shcore-stream-winrt-l1-1-0.dll")
HRESULT CreateRandomAccessStreamOverStream(IStream stream, BSOS_OPTIONS options, const(GUID)* riid, void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-shcore-stream-winrt-l1-1-0.dll")
HRESULT CreateStreamOverRandomAccessStream(IUnknown randomAccessStream, const(GUID)* riid, void** ppv);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/corewindow/nf-corewindow-createcontrolinput
@DllImport("Windows.UI.dll")
HRESULT CreateControlInput(const(GUID)* riid, void** ppv);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/corewindow/nf-corewindow-createcontrolinputex
@DllImport("Windows.UI.dll")
HRESULT CreateControlInputEx(IUnknown pCoreWindow, const(GUID)* riid, void** ppv);


// Interfaces

@GUID("c03f6a43-65a4-9818-987e-e0b810d2a6f2")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nn-objidl-iagilereference
interface IAgileReference : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/WinRT/iagilereference-resolve
    HRESULT Resolve(const(GUID)* riid, void** ppvObjectReference);
}

@GUID("a2f05a09-27a2-42b5-bc0e-ac163ef49d9b")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nn-objidl-iapartmentshutdown
interface IApartmentShutdown : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-iapartmentshutdown-onuninitialize
    void OnUninitialize(ulong ui64ApartmentIdentifier);
}

@GUID("5c4ee536-6a98-4b86-a170-587013d6fd4b")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spatialinteractionmanagerinterop/nn-spatialinteractionmanagerinterop-ispatialinteractionmanagerinterop
interface ISpatialInteractionManagerInterop : IInspectable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spatialinteractionmanagerinterop/nf-spatialinteractionmanagerinterop-ispatialinteractionmanagerinterop-getforwindow
    HRESULT GetForWindow(HWND window, const(GUID)* riid, void** spatialInteractionManager);
}

@GUID("5c4ee536-6a98-4b86-a170-587013d6fd4b")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/holographicspaceinterop/nn-holographicspaceinterop-iholographicspaceinterop
interface IHolographicSpaceInterop : IInspectable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/holographicspaceinterop/nf-holographicspaceinterop-iholographicspaceinterop-createforwindow
    HRESULT CreateForWindow(HWND window, const(GUID)* riid, void** holographicSpace);
}

@GUID("af86e2e0-b12d-4c6a-9c5a-d7aa65101e90")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/inspectable/nn-inspectable-iinspectable
interface IInspectable : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/inspectable/nf-inspectable-iinspectable-getiids
    HRESULT GetIids(uint* iidCount, GUID** iids);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/inspectable/nf-inspectable-iinspectable-getruntimeclassname
    HRESULT GetRuntimeClassName(HSTRING* className);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/inspectable/nf-inspectable-iinspectable-gettrustlevel
    HRESULT GetTrustLevel(TrustLevel* trustLevel);
}

@GUID("d3ee12ad-3865-4362-9746-b75a682df0e6")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/accountssettingspaneinterop/nn-accountssettingspaneinterop-iaccountssettingspaneinterop
interface IAccountsSettingsPaneInterop : IInspectable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/accountssettingspaneinterop/nf-accountssettingspaneinterop-iaccountssettingspaneinterop-getforwindow
    HRESULT GetForWindow(HWND appWindow, const(GUID)* riid, void** accountsSettingsPane);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/accountssettingspaneinterop/nf-accountssettingspaneinterop-iaccountssettingspaneinterop-showmanageaccountsforwindowasync
    HRESULT ShowManageAccountsForWindowAsync(HWND appWindow, const(GUID)* riid, void** asyncAction);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/accountssettingspaneinterop/nf-accountssettingspaneinterop-iaccountssettingspaneinterop-showaddaccountforwindowasync
    HRESULT ShowAddAccountForWindowAsync(HWND appWindow, const(GUID)* riid, void** asyncAction);
}

@GUID("65219584-f9cb-4ae3-81f9-a28a6ca450d9")
interface IAppServiceConnectionExtendedExecution : IUnknown
{
    HRESULT OpenForExtendedExecutionAsync(const(GUID)* riid, void** operation);
}

@GUID("152b8a3b-b9b9-4685-b56e-974847bc7545")
interface ICorrelationVectorSource : IUnknown
{
    HRESULT get_CorrelationVector(HSTRING* cv);
}

@GUID("c79a6cb7-bebd-47a6-a2ad-4d45ad79c7bc")
interface ICastingEventHandler : IUnknown
{
    HRESULT OnStateChanged(CASTING_CONNECTION_STATE newState);
    HRESULT OnError(CASTING_CONNECTION_ERROR_STATUS errorStatus, const(PWSTR) errorMessage);
}

@GUID("f0a56423-a664-4fbd-8b43-409a45e8d9a1")
interface ICastingController : IUnknown
{
    HRESULT Initialize(IUnknown castingEngine, IUnknown castingSource);
    HRESULT Connect();
    HRESULT Disconnect();
    HRESULT Advise(ICastingEventHandler eventHandler, uint* cookie);
    HRESULT UnAdvise(uint cookie);
}

@GUID("45101ab7-7c3a-4bce-9500-12c09024b298")
interface ICastingSourceInfo : IUnknown
{
    HRESULT GetController(ICastingController* controller);
    HRESULT GetProperties(INamedPropertyStore* props);
}

@GUID("5ad8cba7-4c01-4dac-9074-827894292d63")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dragdropinterop/nn-dragdropinterop-idragdropmanagerinterop
interface IDragDropManagerInterop : IInspectable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dragdropinterop/nf-dragdropinterop-idragdropmanagerinterop-getforwindow
    HRESULT GetForWindow(HWND hwnd, const(GUID)* riid, void** ppv);
}

@GUID("75cf2c57-9195-4931-8332-f0b409e916af")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.14393))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/inputpaneinterop/nn-inputpaneinterop-iinputpaneinterop
interface IInputPaneInterop : IInspectable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/inputpaneinterop/nf-inputpaneinterop-iinputpaneinterop-getforwindow
    HRESULT GetForWindow(HWND appWindow, const(GUID)* riid, void** inputPane);
}

@GUID("24394699-1f2c-4eb3-8cd7-0ec1da42a540")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/playtomanagerinterop/nn-playtomanagerinterop-iplaytomanagerinterop
interface IPlayToManagerInterop : IInspectable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/playtomanagerinterop/nf-playtomanagerinterop-iplaytomanagerinterop-getforwindow
    HRESULT GetForWindow(HWND appWindow, const(GUID)* riid, void** playToManager);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/playtomanagerinterop/nf-playtomanagerinterop-iplaytomanagerinterop-showplaytouiforwindow
    HRESULT ShowPlayToUIForWindow(HWND appWindow);
}

@GUID("83c78b3c-d88b-4950-aa6e-22b8d22aabd3")
interface ICorrelationVectorInformation : IInspectable
{
    HRESULT get_LastCorrelationVectorForThread(HSTRING* cv);
    HRESULT get_NextCorrelationVectorForThread(HSTRING* cv);
    HRESULT put_NextCorrelationVectorForThread(HSTRING cv);
}

@GUID("3694dbf9-8f68-44be-8ff5-195c98ede8a6")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiviewsettingsinterop/nn-uiviewsettingsinterop-iuiviewsettingsinterop
interface IUIViewSettingsInterop : IInspectable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiviewsettingsinterop/nf-uiviewsettingsinterop-iuiviewsettingsinterop-getforwindow
    HRESULT GetForWindow(HWND hwnd, const(GUID)* riid, void** ppv);
}

@GUID("1ade314d-0e0a-40d9-824c-9a088a50059f")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/useractivityinterop/nn-useractivityinterop-iuseractivityinterop
interface IUserActivityInterop : IInspectable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/useractivityinterop/nf-useractivityinterop-iuseractivityinterop-createsessionforwindow
    HRESULT CreateSessionForWindow(HWND window, const(GUID)* iid, void** value);
}

@GUID("c15df8bc-8844-487a-b85b-7578e0f61419")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/useractivityinterop/nn-useractivityinterop-iuseractivitysourcehostinterop
interface IUserActivitySourceHostInterop : IInspectable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/useractivityinterop/nf-useractivityinterop-iuseractivitysourcehostinterop-setactivitysourcehost
    HRESULT SetActivitySourceHost(HSTRING activitySourceHost);
}

@GUID("dd69f876-9699-4715-9095-e37ea30dfa1b")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/useractivityinterop/nn-useractivityinterop-iuseractivityrequestmanagerinterop
interface IUserActivityRequestManagerInterop : IInspectable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/useractivityinterop/nf-useractivityinterop-iuseractivityrequestmanagerinterop-getforwindow
    HRESULT GetForWindow(HWND window, const(GUID)* iid, void** value);
}

@GUID("39e050c3-4e74-441a-8dc0-b81104df949c")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/userconsentverifierinterop/nn-userconsentverifierinterop-iuserconsentverifierinterop
interface IUserConsentVerifierInterop : IInspectable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/userconsentverifierinterop/nf-userconsentverifierinterop-iuserconsentverifierinterop-requestverificationforwindowasync
    HRESULT RequestVerificationForWindowAsync(HWND appWindow, HSTRING message, const(GUID)* riid, 
                                              void** asyncOperation);
}

@GUID("f4b8e804-811e-4436-b69c-44cb67b72084")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webauthenticationcoremanagerinterop/nn-webauthenticationcoremanagerinterop-iwebauthenticationcoremanagerinterop
interface IWebAuthenticationCoreManagerInterop : IInspectable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webauthenticationcoremanagerinterop/nf-webauthenticationcoremanagerinterop-iwebauthenticationcoremanagerinterop-requesttokenforwindowasync
    HRESULT RequestTokenForWindowAsync(HWND appWindow, IInspectable request, const(GUID)* riid, void** asyncInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webauthenticationcoremanagerinterop/nf-webauthenticationcoremanagerinterop-iwebauthenticationcoremanagerinterop-requesttokenwithwebaccountforwindowasync
    HRESULT RequestTokenWithWebAccountForWindowAsync(HWND appWindow, IInspectable request, IInspectable webAccount, 
                                                     const(GUID)* riid, void** asyncInfo);
}

@GUID("82ba7092-4c88-427d-a7bc-16dd93feb67e")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/restrictederrorinfo/nn-restrictederrorinfo-irestrictederrorinfo
interface IRestrictedErrorInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/restrictederrorinfo/nf-restrictederrorinfo-irestrictederrorinfo-geterrordetails
    HRESULT GetErrorDetails(BSTR* description, HRESULT* error, BSTR* restrictedDescription, BSTR* capabilitySid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/restrictederrorinfo/nf-restrictederrorinfo-irestrictederrorinfo-getreference
    HRESULT GetReference(BSTR* reference);
}

@GUID("04a2dbf3-df83-116c-0946-0812abf6e07d")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/restrictederrorinfo/nn-restrictederrorinfo-ilanguageexceptionerrorinfo
interface ILanguageExceptionErrorInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/restrictederrorinfo/nf-restrictederrorinfo-ilanguageexceptionerrorinfo-getlanguageexception
    HRESULT GetLanguageException(IUnknown* languageException);
}

@GUID("feb5a271-a6cd-45ce-880a-696706badc65")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/restrictederrorinfo/nn-restrictederrorinfo-ilanguageexceptiontransform
interface ILanguageExceptionTransform : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/restrictederrorinfo/nf-restrictederrorinfo-ilanguageexceptiontransform-gettransformedrestrictederrorinfo
    HRESULT GetTransformedRestrictedErrorInfo(IRestrictedErrorInfo* restrictedErrorInfo);
}

@GUID("cbe53fb5-f967-4258-8d34-42f5e25833de")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/restrictederrorinfo/nn-restrictederrorinfo-ilanguageexceptionstackbacktrace
interface ILanguageExceptionStackBackTrace : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/restrictederrorinfo/nf-restrictederrorinfo-ilanguageexceptionstackbacktrace-getstackbacktrace
    HRESULT GetStackBackTrace(uint maxFramesToCapture, size_t* stackBackTrace, uint* framesCaptured);
}

@GUID("5746e5c4-5b97-424c-b620-2822915734dd")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/restrictederrorinfo/nn-restrictederrorinfo-ilanguageexceptionerrorinfo2
interface ILanguageExceptionErrorInfo2 : ILanguageExceptionErrorInfo
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/restrictederrorinfo/nf-restrictederrorinfo-ilanguageexceptionerrorinfo2-getpreviouslanguageexceptionerrorinfo
    HRESULT GetPreviousLanguageExceptionErrorInfo(ILanguageExceptionErrorInfo2* previousLanguageExceptionErrorInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/restrictederrorinfo/nf-restrictederrorinfo-ilanguageexceptionerrorinfo2-capturepropagationcontext
    HRESULT CapturePropagationContext(IUnknown languageException);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/restrictederrorinfo/nf-restrictederrorinfo-ilanguageexceptionerrorinfo2-getpropagationcontexthead
    HRESULT GetPropagationContextHead(ILanguageExceptionErrorInfo2* propagatedLanguageExceptionErrorInfoHead);
}

@GUID("00000035-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/activation/nn-activation-iactivationfactory
interface IActivationFactory : IInspectable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/activation/nf-activation-iactivationfactory-activateinstance
    HRESULT ActivateInstance(IInspectable* instance);
}

@GUID("905a0fef-bc53-11df-8c49-001e4fc686da")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/robuffer/ns-robuffer-ibufferbyteaccess
interface IBufferByteAccess : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/robuffer/nf-robuffer-ibufferbyteaccess-buffer
    HRESULT Buffer(ubyte** value);
}

@GUID("5b0d3235-4dba-4d44-865e-8f1d0e4fd04d")
interface IMemoryBufferByteAccess : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/memorybuffer/nf-memorybuffer-imemorybufferbyteaccess-getbuffer
    HRESULT GetBuffer(ubyte** value, uint* capacity);
}

@GUID("00000037-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/weakreference/nn-weakreference-iweakreference
interface IWeakReference : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/weakreference/nf-weakreference-iweakreference-resolve(t_)
    HRESULT Resolve(const(GUID)* riid, void** objectReference);
}

@GUID("00000038-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/weakreference/nn-weakreference-iweakreferencesource
interface IWeakReferenceSource : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/weakreference/nf-weakreference-iweakreferencesource-getweakreference
    HRESULT GetWeakReference(IWeakReference* weakReference);
}

@GUID("ddb0472d-c911-4a1f-86d9-dc3d71a95f5a")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/systemmediatransportcontrolsinterop/nn-systemmediatransportcontrolsinterop-isystemmediatransportcontrolsinterop
interface ISystemMediaTransportControlsInterop : IInspectable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/systemmediatransportcontrolsinterop/nf-systemmediatransportcontrolsinterop-isystemmediatransportcontrolsinterop-getforwindow
    HRESULT GetForWindow(HWND appWindow, const(GUID)* riid, void** mediaTransportControl);
}

@GUID("6571a721-643d-43d4-aca4-6b6f5f30f1ad")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sharewindowcommandsourceinterop/nn-sharewindowcommandsourceinterop-isharewindowcommandeventargsinterop
interface IShareWindowCommandEventArgsInterop : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sharewindowcommandsourceinterop/nf-sharewindowcommandsourceinterop-isharewindowcommandeventargsinterop-getwindow
    HRESULT GetWindow(HWND* value);
}

@GUID("461a191f-8424-43a6-a0fa-3451a22f56ab")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sharewindowcommandsourceinterop/nn-sharewindowcommandsourceinterop-isharewindowcommandsourceinterop
interface IShareWindowCommandSourceInterop : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sharewindowcommandsourceinterop/nf-sharewindowcommandsourceinterop-isharewindowcommandsourceinterop-getforwindow
    HRESULT GetForWindow(HWND appWindow, const(GUID)* riid, void** shareWindowCommandSource);
}

@GUID("f5f84c8f-cfd0-4cd6-b66b-c5d26ff1689d")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/imessagedispatcher/nn-imessagedispatcher-imessagedispatcher
interface IMessageDispatcher : IInspectable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/imessagedispatcher/nf-imessagedispatcher-imessagedispatcher-pumpmessages
    HRESULT PumpMessages();
}

@GUID("45d64a29-a63e-4cb6-b498-5781d298cb4f")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/corewindow/nn-corewindow-icorewindowinterop
interface ICoreWindowInterop : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/corewindow/nf-corewindow-icorewindowinterop-get_windowhandle
    HRESULT get_WindowHandle(HWND* hwnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/corewindow/nf-corewindow-icorewindowinterop-put_messagehandled
    HRESULT put_MessageHandled(ubyte value);
}

@GUID("40bfe3e3-b75a-4479-ac96-475365749bb8")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/corewindow/nn-corewindow-icoreinputinterop
interface ICoreInputInterop : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/corewindow/nf-corewindow-icoreinputinterop-setinputsource
    HRESULT SetInputSource(IUnknown value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/corewindow/nf-corewindow-icoreinputinterop-put_messagehandled
    HRESULT put_MessageHandled(ubyte value);
}

@GUID("0576ab31-a310-4c40-ba31-fd37e0298dfa")
interface ICoreWindowComponentInterop : IUnknown
{
    HRESULT ConfigureComponentInput(uint hostViewInstanceId, HWND hwndHost, IUnknown inputSourceVisual);
    HRESULT GetViewInstanceId(uint* componentViewInstanceId);
}

@GUID("7a5b6fd1-cd73-4b6c-9cf4-2e869eaf470a")
interface ICoreWindowAdapterInterop : IInspectable
{
    HRESULT get_AppActivationClientAdapter(IUnknown* value);
    HRESULT get_ApplicationViewClientAdapter(IUnknown* value);
    HRESULT get_CoreApplicationViewClientAdapter(IUnknown* value);
    HRESULT get_HoloViewClientAdapter(IUnknown* value);
    HRESULT get_PositionerClientAdapter(IUnknown* value);
    HRESULT get_SystemNavigationClientAdapter(IUnknown* value);
    HRESULT get_TitleBarClientAdapter(IUnknown* value);
    HRESULT SetWindowClientAdapter(IUnknown value);
}

@GUID("b8a2acd7-a0f0-40ee-8ee7-c82f59cc5cd4")
interface ICoreInputInterop2 : IInspectable
{
    HRESULT get_WindowHandle(HWND* window);
    HRESULT ChangeHostingContext(HWND newParentWindow, uint newViewInstanceId);
}


// GUIDs


const GUID IID_IAccountsSettingsPaneInterop           = GUIDOF!IAccountsSettingsPaneInterop;
const GUID IID_IActivationFactory                     = GUIDOF!IActivationFactory;
const GUID IID_IAgileReference                        = GUIDOF!IAgileReference;
const GUID IID_IApartmentShutdown                     = GUIDOF!IApartmentShutdown;
const GUID IID_IAppServiceConnectionExtendedExecution = GUIDOF!IAppServiceConnectionExtendedExecution;
const GUID IID_IBufferByteAccess                      = GUIDOF!IBufferByteAccess;
const GUID IID_ICastingController                     = GUIDOF!ICastingController;
const GUID IID_ICastingEventHandler                   = GUIDOF!ICastingEventHandler;
const GUID IID_ICastingSourceInfo                     = GUIDOF!ICastingSourceInfo;
const GUID IID_ICoreInputInterop                      = GUIDOF!ICoreInputInterop;
const GUID IID_ICoreInputInterop2                     = GUIDOF!ICoreInputInterop2;
const GUID IID_ICoreWindowAdapterInterop              = GUIDOF!ICoreWindowAdapterInterop;
const GUID IID_ICoreWindowComponentInterop            = GUIDOF!ICoreWindowComponentInterop;
const GUID IID_ICoreWindowInterop                     = GUIDOF!ICoreWindowInterop;
const GUID IID_ICorrelationVectorInformation          = GUIDOF!ICorrelationVectorInformation;
const GUID IID_ICorrelationVectorSource               = GUIDOF!ICorrelationVectorSource;
const GUID IID_IDragDropManagerInterop                = GUIDOF!IDragDropManagerInterop;
const GUID IID_IHolographicSpaceInterop               = GUIDOF!IHolographicSpaceInterop;
const GUID IID_IInputPaneInterop                      = GUIDOF!IInputPaneInterop;
const GUID IID_IInspectable                           = GUIDOF!IInspectable;
const GUID IID_ILanguageExceptionErrorInfo            = GUIDOF!ILanguageExceptionErrorInfo;
const GUID IID_ILanguageExceptionErrorInfo2           = GUIDOF!ILanguageExceptionErrorInfo2;
const GUID IID_ILanguageExceptionStackBackTrace       = GUIDOF!ILanguageExceptionStackBackTrace;
const GUID IID_ILanguageExceptionTransform            = GUIDOF!ILanguageExceptionTransform;
const GUID IID_IMemoryBufferByteAccess                = GUIDOF!IMemoryBufferByteAccess;
const GUID IID_IMessageDispatcher                     = GUIDOF!IMessageDispatcher;
const GUID IID_IPlayToManagerInterop                  = GUIDOF!IPlayToManagerInterop;
const GUID IID_IRestrictedErrorInfo                   = GUIDOF!IRestrictedErrorInfo;
const GUID IID_IShareWindowCommandEventArgsInterop    = GUIDOF!IShareWindowCommandEventArgsInterop;
const GUID IID_IShareWindowCommandSourceInterop       = GUIDOF!IShareWindowCommandSourceInterop;
const GUID IID_ISpatialInteractionManagerInterop      = GUIDOF!ISpatialInteractionManagerInterop;
const GUID IID_ISystemMediaTransportControlsInterop   = GUIDOF!ISystemMediaTransportControlsInterop;
const GUID IID_IUIViewSettingsInterop                 = GUIDOF!IUIViewSettingsInterop;
const GUID IID_IUserActivityInterop                   = GUIDOF!IUserActivityInterop;
const GUID IID_IUserActivityRequestManagerInterop     = GUIDOF!IUserActivityRequestManagerInterop;
const GUID IID_IUserActivitySourceHostInterop         = GUIDOF!IUserActivitySourceHostInterop;
const GUID IID_IUserConsentVerifierInterop            = GUIDOF!IUserConsentVerifierInterop;
const GUID IID_IWeakReference                         = GUIDOF!IWeakReference;
const GUID IID_IWeakReferenceSource                   = GUIDOF!IWeakReferenceSource;
const GUID IID_IWebAuthenticationCoreManagerInterop   = GUIDOF!IWebAuthenticationCoreManagerInterop;
