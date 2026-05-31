// Written in the D programming language.

module windows.win32.system.environment;

public import windows.core;
public import windows.win32.foundation.foundation : BOOL, BOOLEAN, HANDLE, HRESULT, PSTR,
                                                    PWSTR;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntenclv/ne-ntenclv-enclave_sealing_identity_policy
alias ENCLAVE_SEALING_IDENTITY_POLICY = int;
enum : int
{
    ENCLAVE_IDENTITY_POLICY_SEAL_INVALID           = 0x00000000,
    ENCLAVE_IDENTITY_POLICY_SEAL_EXACT_CODE        = 0x00000001,
    ENCLAVE_IDENTITY_POLICY_SEAL_SAME_PRIMARY_CODE = 0x00000002,
    ENCLAVE_IDENTITY_POLICY_SEAL_SAME_IMAGE        = 0x00000003,
    ENCLAVE_IDENTITY_POLICY_SEAL_SAME_FAMILY       = 0x00000004,
    ENCLAVE_IDENTITY_POLICY_SEAL_SAME_AUTHOR       = 0x00000005,
}

// Constants


enum : uint
{
    ENCLAVE_RUNTIME_POLICY_ALLOW_FULL_DEBUG    = 0x00000001U,
    ENCLAVE_RUNTIME_POLICY_ALLOW_DYNAMIC_DEBUG = 0x00000002U,
}

enum uint ENCLAVE_UNSEAL_FLAG_STALE_KEY = 0x00000001U;

enum : uint
{
    ENCLAVE_FLAG_FULL_DEBUG_ENABLED    = 0x00000001U,
    ENCLAVE_FLAG_DYNAMIC_DEBUG_ENABLED = 0x00000002U,
    ENCLAVE_FLAG_DYNAMIC_DEBUG_ACTIVE  = 0x00000004U,
}

enum : uint
{
    VBS_ENCLAVE_REPORT_PKG_HEADER_VERSION_CURRENT             = 0x00000001U,
    VBS_ENCLAVE_REPORT_SIGNATURE_SCHEME_SHA256_RSA_PSS_SHA256 = 0x00000001U,
}

enum uint VBS_ENCLAVE_REPORT_VERSION_CURRENT = 0x00000001U;
enum uint ENCLAVE_REPORT_DATA_LENGTH = 0x00000040U;

enum : uint
{
    VBS_ENCLAVE_VARDATA_INVALID = 0x00000000U,
    VBS_ENCLAVE_VARDATA_MODULE  = 0x00000001U,
}

enum : uint
{
    ENCLAVE_VBS_BASIC_KEY_FLAG_MEASUREMENT = 0x00000001U,
    ENCLAVE_VBS_BASIC_KEY_FLAG_FAMILY_ID   = 0x00000002U,
    ENCLAVE_VBS_BASIC_KEY_FLAG_IMAGE_ID    = 0x00000004U,
    ENCLAVE_VBS_BASIC_KEY_FLAG_DEBUG_KEY   = 0x00000008U,
}

// Callbacks


version(X86_64)
{
    alias VBS_BASIC_ENCLAVE_BASIC_CALL_RETURN_FROM_EXCEPTION = int function(VBS_BASIC_ENCLAVE_EXCEPTION_AMD64* ExceptionRecord);
}

version(X86_64)
{
    alias VBS_BASIC_ENCLAVE_BASIC_CALL_TERMINATE_THREAD = int function(VBS_BASIC_ENCLAVE_THREAD_DESCRIPTOR64* ThreadDescriptor);
}

version(AArch64)
{
    alias VBS_BASIC_ENCLAVE_BASIC_CALL_TERMINATE_THREAD = int function(VBS_BASIC_ENCLAVE_THREAD_DESCRIPTOR64* ThreadDescriptor);
}

version(X86_64)
{
    alias VBS_BASIC_ENCLAVE_BASIC_CALL_INTERRUPT_THREAD = int function(VBS_BASIC_ENCLAVE_THREAD_DESCRIPTOR64* ThreadDescriptor);
}

version(AArch64)
{
    alias VBS_BASIC_ENCLAVE_BASIC_CALL_INTERRUPT_THREAD = int function(VBS_BASIC_ENCLAVE_THREAD_DESCRIPTOR64* ThreadDescriptor);
}

version(X86_64)
{
    alias VBS_BASIC_ENCLAVE_BASIC_CALL_CREATE_THREAD = int function(VBS_BASIC_ENCLAVE_THREAD_DESCRIPTOR64* ThreadDescriptor);
}

version(AArch64)
{
    alias VBS_BASIC_ENCLAVE_BASIC_CALL_CREATE_THREAD = int function(VBS_BASIC_ENCLAVE_THREAD_DESCRIPTOR64* ThreadDescriptor);
}
alias VBS_BASIC_ENCLAVE_BASIC_CALL_RETURN_FROM_ENCLAVE = void function(size_t ReturnValue);

version(X86)
{
    alias VBS_BASIC_ENCLAVE_BASIC_CALL_RETURN_FROM_EXCEPTION = int function(void* ExceptionRecord);
}

version(AArch64)
{
    alias VBS_BASIC_ENCLAVE_BASIC_CALL_RETURN_FROM_EXCEPTION = int function(void* ExceptionRecord);
}

version(X86)
{
    alias VBS_BASIC_ENCLAVE_BASIC_CALL_TERMINATE_THREAD = int function(VBS_BASIC_ENCLAVE_THREAD_DESCRIPTOR32* ThreadDescriptor);
}

version(X86)
{
    alias VBS_BASIC_ENCLAVE_BASIC_CALL_INTERRUPT_THREAD = int function(VBS_BASIC_ENCLAVE_THREAD_DESCRIPTOR32* ThreadDescriptor);
}
alias VBS_BASIC_ENCLAVE_BASIC_CALL_COMMIT_PAGES = int function(void* EnclaveAddress, size_t NumberOfBytes, 
                                                               void* SourceAddress, uint PageProtection);
alias VBS_BASIC_ENCLAVE_BASIC_CALL_DECOMMIT_PAGES = int function(void* EnclaveAddress, size_t NumberOfBytes);
alias VBS_BASIC_ENCLAVE_BASIC_CALL_PROTECT_PAGES = int function(void* EnclaveAddress, size_t NumberOfytes, 
                                                                uint PageProtection);

version(X86)
{
    alias VBS_BASIC_ENCLAVE_BASIC_CALL_CREATE_THREAD = int function(VBS_BASIC_ENCLAVE_THREAD_DESCRIPTOR32* ThreadDescriptor);
}
alias VBS_BASIC_ENCLAVE_BASIC_CALL_GET_ENCLAVE_INFORMATION = int function(ENCLAVE_INFORMATION* EnclaveInfo);
alias VBS_BASIC_ENCLAVE_BASIC_CALL_GENERATE_KEY = int function(ENCLAVE_VBS_BASIC_KEY_REQUEST* KeyRequest, 
                                                               uint RequestedKeySize, ubyte* ReturnedKey);
alias VBS_BASIC_ENCLAVE_BASIC_CALL_GENERATE_REPORT = int function(const(ubyte)* EnclaveData, 
                                                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* Report, 
                                                                  uint BufferSize, uint* OutputSize);
alias VBS_BASIC_ENCLAVE_BASIC_CALL_VERIFY_REPORT = int function(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* Report, 
                                                                uint ReportSize);
alias VBS_BASIC_ENCLAVE_BASIC_CALL_GENERATE_RANDOM_DATA = int function(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/ubyte* Buffer, 
                                                                       uint NumberOfBytes, ulong* Generation);

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntenclv/ns-ntenclv-enclave_identity
struct ENCLAVE_IDENTITY
{
align (1):
    ubyte[32] OwnerId;
    ubyte[32] UniqueId;
    ubyte[32] AuthorId;
    ubyte[16] FamilyId;
    ubyte[16] ImageId;
    uint      EnclaveSvn;
    uint      SecureKernelSvn;
    uint      PlatformSvn;
    uint      Flags;
    uint      SigningLevel;
    uint      EnclaveType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntenclv/ns-ntenclv-vbs_enclave_report_pkg_header
struct VBS_ENCLAVE_REPORT_PKG_HEADER
{
align (1):
    uint PackageSize;
    uint Version;
    uint SignatureScheme;
    uint SignedStatementSize;
    uint SignatureSize;
    uint Reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntenclv/ns-ntenclv-vbs_enclave_report
struct VBS_ENCLAVE_REPORT
{
align (1):
    uint             ReportSize;
    uint             ReportVersion;
    ubyte[64]        EnclaveData;
    ENCLAVE_IDENTITY EnclaveIdentity;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntenclv/ns-ntenclv-vbs_enclave_report_vardata_header
struct VBS_ENCLAVE_REPORT_VARDATA_HEADER
{
align (1):
    uint DataType;
    uint Size;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntenclv/ns-ntenclv-vbs_enclave_report_module
struct VBS_ENCLAVE_REPORT_MODULE
{
align (1):
    VBS_ENCLAVE_REPORT_VARDATA_HEADER Header;
    ubyte[32] UniqueId;
    ubyte[32] AuthorId;
    ubyte[16] FamilyId;
    ubyte[16] ImageId;
    uint      Svn;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/wchar[1] ModuleName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntenclv/ns-ntenclv-enclave_information
struct ENCLAVE_INFORMATION
{
    uint             EnclaveType;
    uint             Reserved;
    void*            BaseAddress;
    size_t           Size;
    ENCLAVE_IDENTITY Identity;
}

struct VBS_BASIC_ENCLAVE_THREAD_DESCRIPTOR32
{
    uint[4] ThreadContext;
    uint    EntryPoint;
    uint    StackPointer;
    uint    ExceptionEntryPoint;
    uint    ExceptionStack;
    uint    ExceptionActive;
}

struct VBS_BASIC_ENCLAVE_THREAD_DESCRIPTOR64
{
    ulong[4] ThreadContext;
    ulong    EntryPoint;
    ulong    StackPointer;
    ulong    ExceptionEntryPoint;
    ulong    ExceptionStack;
    uint     ExceptionActive;
}

struct VBS_BASIC_ENCLAVE_EXCEPTION_AMD64
{
    uint      ExceptionCode;
    uint      NumberParameters;
    size_t[3] ExceptionInformation;
    size_t    ExceptionRAX;
    size_t    ExceptionRCX;
    size_t    ExceptionRIP;
    size_t    ExceptionRFLAGS;
    size_t    ExceptionRSP;
}

struct ENCLAVE_VBS_BASIC_KEY_REQUEST
{
    uint RequestSize;
    uint Flags;
    uint EnclaveSVN;
    uint SystemKeyID;
    uint CurrentSystemKeyID;
}

struct VBS_BASIC_ENCLAVE_SYSCALL_PAGE
{
    VBS_BASIC_ENCLAVE_BASIC_CALL_RETURN_FROM_ENCLAVE ReturnFromEnclave;
    VBS_BASIC_ENCLAVE_BASIC_CALL_RETURN_FROM_EXCEPTION ReturnFromException;
    VBS_BASIC_ENCLAVE_BASIC_CALL_TERMINATE_THREAD TerminateThread;
    VBS_BASIC_ENCLAVE_BASIC_CALL_INTERRUPT_THREAD InterruptThread;
    VBS_BASIC_ENCLAVE_BASIC_CALL_COMMIT_PAGES CommitPages;
    VBS_BASIC_ENCLAVE_BASIC_CALL_DECOMMIT_PAGES DecommitPages;
    VBS_BASIC_ENCLAVE_BASIC_CALL_PROTECT_PAGES ProtectPages;
    VBS_BASIC_ENCLAVE_BASIC_CALL_CREATE_THREAD CreateThread;
    VBS_BASIC_ENCLAVE_BASIC_CALL_GET_ENCLAVE_INFORMATION GetEnclaveInformation;
    VBS_BASIC_ENCLAVE_BASIC_CALL_GENERATE_KEY GenerateKey;
    VBS_BASIC_ENCLAVE_BASIC_CALL_GENERATE_REPORT GenerateReport;
    VBS_BASIC_ENCLAVE_BASIC_CALL_VERIFY_REPORT VerifyReport;
    VBS_BASIC_ENCLAVE_BASIC_CALL_GENERATE_RANDOM_DATA GenerateRandomData;
}

struct PS_TRUSTLET_TKSESSION_ID
{
    ulong[4] SessionId;
}

struct TRUSTLET_BINDING_DATA
{
align (1):
    ulong TrustletIdentity;
    PS_TRUSTLET_TKSESSION_ID TrustletSessionId;
    uint  TrustletSvn;
    uint  Reserved1;
    ulong Reserved2;
}

// Functions

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("KERNEL32.dll")
BOOL SetEnvironmentStringsW(/*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PWSTR NewEnvironment);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
PSTR GetCommandLineA();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
PWSTR GetCommandLineW();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
PSTR GetEnvironmentStrings();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
PWSTR GetEnvironmentStringsW();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL FreeEnvironmentStringsA(/*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PSTR penv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL FreeEnvironmentStringsW(/*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PWSTR penv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
uint GetEnvironmentVariableA(const(PSTR) lpName, PSTR lpBuffer, uint nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
uint GetEnvironmentVariableW(const(PWSTR) lpName, PWSTR lpBuffer, uint nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL SetEnvironmentVariableA(const(PSTR) lpName, const(PSTR) lpValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL SetEnvironmentVariableW(const(PWSTR) lpName, const(PWSTR) lpValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
uint ExpandEnvironmentStringsA(const(PSTR) lpSrc, PSTR lpDst, uint nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
uint ExpandEnvironmentStringsW(const(PWSTR) lpSrc, PWSTR lpDst, uint nSize);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("KERNEL32.dll")
BOOL SetCurrentDirectoryA(const(PSTR) lpPathName);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("KERNEL32.dll")
BOOL SetCurrentDirectoryW(const(PWSTR) lpPathName);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("KERNEL32.dll")
uint GetCurrentDirectoryA(uint nBufferLength, PSTR lpBuffer);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("KERNEL32.dll")
uint GetCurrentDirectoryW(uint nBufferLength, PWSTR lpBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL NeedCurrentDirectoryForExePathA(const(PSTR) ExeName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL NeedCurrentDirectoryForExePathW(const(PWSTR) ExeName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USERENV.dll")
BOOL CreateEnvironmentBlock(void** lpEnvironment, HANDLE hToken, BOOL bInherit);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USERENV.dll")
BOOL DestroyEnvironmentBlock(void* lpEnvironment);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USERENV.dll")
BOOL ExpandEnvironmentStringsForUserA(HANDLE hToken, const(PSTR) lpSrc, PSTR lpDest, uint dwSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USERENV.dll")
BOOL ExpandEnvironmentStringsForUserW(HANDLE hToken, const(PWSTR) lpSrc, PWSTR lpDest, uint dwSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("KERNEL32.dll")
BOOL IsEnclaveTypeSupported(uint flEnclaveType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("KERNEL32.dll")
void* CreateEnclave(HANDLE hProcess, void* lpAddress, size_t dwSize, size_t dwInitialCommitment, 
                    uint flEnclaveType, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/const(void)* lpEnclaveInformation, 
                    uint dwInfoLength, uint* lpEnclaveError);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("KERNEL32.dll")
BOOL LoadEnclaveData(HANDLE hProcess, void* lpAddress, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/const(void)* lpBuffer, 
                     size_t nSize, uint flProtect, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/const(void)* lpPageInformation, 
                     uint dwInfoLength, size_t* lpNumberOfBytesWritten, uint* lpEnclaveError);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("KERNEL32.dll")
BOOL InitializeEnclave(HANDLE hProcess, void* lpAddress, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/const(void)* lpEnclaveInformation, 
                       uint dwInfoLength, uint* lpEnclaveError);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("api-ms-win-core-enclave-l1-1-1.dll")
BOOL LoadEnclaveImageA(void* lpEnclaveAddress, const(PSTR) lpImageName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("api-ms-win-core-enclave-l1-1-1.dll")
BOOL LoadEnclaveImageW(void* lpEnclaveAddress, const(PWSTR) lpImageName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("vertdll.dll")
BOOL CallEnclave(ptrdiff_t lpRoutine, void* lpParameter, BOOL fWaitForThread, void** lpReturnValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("vertdll.dll")
BOOL TerminateEnclave(void* lpAddress, BOOL fWait);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("api-ms-win-core-enclave-l1-1-1.dll")
BOOL DeleteEnclave(void* lpAddress);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("vertdll.dll")
HRESULT EnclaveGetAttestationReport(const(ubyte)* EnclaveData, 
                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* Report, 
                                    uint BufferSize, uint* OutputSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("vertdll.dll")
HRESULT EnclaveVerifyAttestationReport(uint EnclaveType, 
                                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(void)* Report, 
                                       uint ReportSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("vertdll.dll")
HRESULT EnclaveSealData(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* DataToEncrypt, 
                        uint DataToEncryptSize, ENCLAVE_SEALING_IDENTITY_POLICY IdentityPolicy, uint RuntimePolicy, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* ProtectedBlob, 
                        uint BufferSize, uint* ProtectedBlobSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("vertdll.dll")
HRESULT EnclaveUnsealData(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* ProtectedBlob, 
                          uint ProtectedBlobSize, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* DecryptedData, 
                          uint BufferSize, uint* DecryptedDataSize, ENCLAVE_IDENTITY* SealingIdentity, 
                          uint* UnsealingFlags);

@DllImport("vertdll.dll")
HRESULT EnclaveEncryptDataForTrustlet(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* DataToEncrypt, 
                                      uint DataToEncryptSize, TRUSTLET_BINDING_DATA* TrustletBindingData, 
                                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* EncryptedData, 
                                      uint BufferSize, uint* EncryptedDataSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("vertdll.dll")
HRESULT EnclaveGetEnclaveInformation(uint InformationSize, 
                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/ENCLAVE_INFORMATION* EnclaveInformation);

@DllImport("vertdll.dll")
BOOLEAN EnclaveUsesAttestedKeys();

@DllImport("vertdll.dll")
HRESULT EnclaveRestrictContainingProcessAccess(BOOL RestrictAccess, BOOL* PreviouslyRestricted);

@DllImport("vertdll.dll")
HRESULT EnclaveCopyIntoEnclave(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* EnclaveAddress, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(void)* UnsecureAddress, 
                               size_t NumberOfBytes);

@DllImport("vertdll.dll")
HRESULT EnclaveCopyOutOfEnclave(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* UnsecureAddress, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(void)* EnclaveAddress, 
                                size_t NumberOfBytes);


