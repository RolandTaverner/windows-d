// Written in the D programming language.

module windows.win32.system.pipes;

public import windows.core;
public import windows.win32.foundation : BOOL, HANDLE, PSTR, PWSTR;
public import windows.win32.security : SECURITY_ATTRIBUTES;
public import windows.win32.storage.filesystem : FILE_FLAGS_AND_ATTRIBUTES;
public import windows.win32.system.io : OVERLAPPED;

extern(Windows) @nogc nothrow:


// Enums


alias NAMED_PIPE_MODE = uint;
enum : uint
{
    PIPE_WAIT                  = 0x00000000U,
    PIPE_NOWAIT                = 0x00000001U,
    PIPE_READMODE_BYTE         = 0x00000000U,
    PIPE_READMODE_MESSAGE      = 0x00000002U,
    PIPE_CLIENT_END            = 0x00000000U,
    PIPE_SERVER_END            = 0x00000001U,
    PIPE_TYPE_BYTE             = 0x00000000U,
    PIPE_TYPE_MESSAGE          = 0x00000004U,
    PIPE_ACCEPT_REMOTE_CLIENTS = 0x00000000U,
    PIPE_REJECT_REMOTE_CLIENTS = 0x00000008U,
}

// Constants


enum uint PIPE_UNLIMITED_INSTANCES = 0x000000ffU;
enum uint NMPWAIT_WAIT_FOREVER = 0xffffffffU;

enum : uint
{
    NMPWAIT_NOWAIT           = 0x00000001U,
    NMPWAIT_USE_DEFAULT_WAIT = 0x00000000U,
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL CreatePipe(/*PARAM ATTR: IgnoreIfReturnAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])*/HANDLE* hReadPipe, 
                /*PARAM ATTR: IgnoreIfReturnAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])*/HANDLE* hWritePipe, 
                SECURITY_ATTRIBUTES* lpPipeAttributes, uint nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL ConnectNamedPipe(HANDLE hNamedPipe, OVERLAPPED* lpOverlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL DisconnectNamedPipe(HANDLE hNamedPipe);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL SetNamedPipeHandleState(HANDLE hNamedPipe, NAMED_PIPE_MODE* lpMode, uint* lpMaxCollectionCount, 
                             uint* lpCollectDataTimeout);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL PeekNamedPipe(HANDLE hNamedPipe, 
                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* lpBuffer, 
                   uint nBufferSize, uint* lpBytesRead, uint* lpTotalBytesAvail, uint* lpBytesLeftThisMessage);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL TransactNamedPipe(HANDLE hNamedPipe, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* lpInBuffer, 
                       uint nInBufferSize, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* lpOutBuffer, 
                       uint nOutBufferSize, uint* lpBytesRead, OVERLAPPED* lpOverlapped);

@DllImport("KERNEL32.dll")
HANDLE CreateNamedPipeW(const(PWSTR) lpName, FILE_FLAGS_AND_ATTRIBUTES dwOpenMode, NAMED_PIPE_MODE dwPipeMode, 
                        uint nMaxInstances, uint nOutBufferSize, uint nInBufferSize, uint nDefaultTimeOut, 
                        SECURITY_ATTRIBUTES* lpSecurityAttributes);

@DllImport("KERNEL32.dll")
BOOL WaitNamedPipeW(const(PWSTR) lpNamedPipeName, uint nTimeOut);

@DllImport("KERNEL32.dll")
BOOL GetNamedPipeClientComputerNameW(HANDLE Pipe, 
                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/PWSTR ClientComputerName, 
                                     uint ClientComputerNameLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL ImpersonateNamedPipeClient(HANDLE hNamedPipe);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL GetNamedPipeInfo(HANDLE hNamedPipe, NAMED_PIPE_MODE* lpFlags, uint* lpOutBufferSize, uint* lpInBufferSize, 
                      uint* lpMaxInstances);

@DllImport("KERNEL32.dll")
BOOL GetNamedPipeHandleStateW(HANDLE hNamedPipe, NAMED_PIPE_MODE* lpState, uint* lpCurInstances, 
                              uint* lpMaxCollectionCount, uint* lpCollectDataTimeout, PWSTR lpUserName, 
                              uint nMaxUserNameSize);

@DllImport("KERNEL32.dll")
BOOL CallNamedPipeW(const(PWSTR) lpNamedPipeName, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* lpInBuffer, 
                    uint nInBufferSize, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* lpOutBuffer, 
                    uint nOutBufferSize, uint* lpBytesRead, uint nTimeOut);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
HANDLE CreateNamedPipeA(const(PSTR) lpName, FILE_FLAGS_AND_ATTRIBUTES dwOpenMode, NAMED_PIPE_MODE dwPipeMode, 
                        uint nMaxInstances, uint nOutBufferSize, uint nInBufferSize, uint nDefaultTimeOut, 
                        SECURITY_ATTRIBUTES* lpSecurityAttributes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL GetNamedPipeHandleStateA(HANDLE hNamedPipe, NAMED_PIPE_MODE* lpState, uint* lpCurInstances, 
                              uint* lpMaxCollectionCount, uint* lpCollectDataTimeout, PSTR lpUserName, 
                              uint nMaxUserNameSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL CallNamedPipeA(const(PSTR) lpNamedPipeName, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* lpInBuffer, 
                    uint nInBufferSize, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* lpOutBuffer, 
                    uint nOutBufferSize, uint* lpBytesRead, uint nTimeOut);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL WaitNamedPipeA(const(PSTR) lpNamedPipeName, uint nTimeOut);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL GetNamedPipeClientComputerNameA(HANDLE Pipe, 
                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/PSTR ClientComputerName, 
                                     uint ClientComputerNameLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL GetNamedPipeClientProcessId(HANDLE Pipe, uint* ClientProcessId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL GetNamedPipeClientSessionId(HANDLE Pipe, uint* ClientSessionId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL GetNamedPipeServerProcessId(HANDLE Pipe, uint* ServerProcessId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL GetNamedPipeServerSessionId(HANDLE Pipe, uint* ServerSessionId);


