// Written in the D programming language.

module windows.win32.system.diagnostics.toolhelp;

public import windows.core;
public import windows.win32.foundation : BOOL, CHAR, HANDLE, HMODULE;

extern(Windows) @nogc nothrow:


// Enums

alias CREATE_TOOLHELP_SNAPSHOT_FLAGS = uint;
enum : uint
{
    TH32CS_INHERIT      = 0x80000000,
    TH32CS_SNAPALL      = 0x0000000f,
    TH32CS_SNAPHEAPLIST = 0x00000001,
    TH32CS_SNAPMODULE   = 0x00000008,
    TH32CS_SNAPMODULE32 = 0x00000010,
    TH32CS_SNAPPROCESS  = 0x00000002,
    TH32CS_SNAPTHREAD   = 0x00000004,
}
alias HEAPENTRY32_FLAGS = uint;
enum : uint
{
    LF32_FIXED    = 0x00000001,
    LF32_FREE     = 0x00000002,
    LF32_MOVEABLE = 0x00000004,
}

// Constants


enum uint MAX_MODULE_NAME32 = 0x000000ff;

enum : uint
{
    HF32_DEFAULT = 0x00000001,
    HF32_SHARED  = 0x00000002,
}

// Structs


//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tlhelp32/ns-tlhelp32-heaplist32))], [])
struct HEAPLIST32
{
    size_t dwSize;
    uint   th32ProcessID;
    size_t th32HeapID;
    uint   dwFlags;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tlhelp32/ns-tlhelp32-heapentry32))], [])
struct HEAPENTRY32
{
    size_t            dwSize;
    HANDLE            hHandle;
    size_t            dwAddress;
    size_t            dwBlockSize;
    HEAPENTRY32_FLAGS dwFlags;
    uint              dwLockCount;
    uint              dwResvd;
    uint              th32ProcessID;
    size_t            th32HeapID;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tlhelp32/ns-tlhelp32-processentry32w))], [])
struct PROCESSENTRY32W
{
    uint       dwSize;
    uint       cntUsage;
    uint       th32ProcessID;
    size_t     th32DefaultHeapID;
    uint       th32ModuleID;
    uint       cntThreads;
    uint       th32ParentProcessID;
    int        pcPriClassBase;
    uint       dwFlags;
    wchar[260] szExeFile;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tlhelp32/ns-tlhelp32-processentry32))], [])
struct PROCESSENTRY32
{
    uint      dwSize;
    uint      cntUsage;
    uint      th32ProcessID;
    size_t    th32DefaultHeapID;
    uint      th32ModuleID;
    uint      cntThreads;
    uint      th32ParentProcessID;
    int       pcPriClassBase;
    uint      dwFlags;
    CHAR[260] szExeFile;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tlhelp32/ns-tlhelp32-threadentry32))], [])
struct THREADENTRY32
{
    uint dwSize;
    uint cntUsage;
    uint th32ThreadID;
    uint th32OwnerProcessID;
    int  tpBasePri;
    int  tpDeltaPri;
    uint dwFlags;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tlhelp32/ns-tlhelp32-moduleentry32w))], [])
struct MODULEENTRY32W
{
    uint       dwSize;
    uint       th32ModuleID;
    uint       th32ProcessID;
    uint       GlblcntUsage;
    uint       ProccntUsage;
    ubyte*     modBaseAddr;
    uint       modBaseSize;
    HMODULE    hModule;
    wchar[256] szModule;
    wchar[260] szExePath;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tlhelp32/ns-tlhelp32-moduleentry32))], [])
struct MODULEENTRY32
{
    uint      dwSize;
    uint      th32ModuleID;
    uint      th32ProcessID;
    uint      GlblcntUsage;
    uint      ProccntUsage;
    ubyte*    modBaseAddr;
    uint      modBaseSize;
    HMODULE   hModule;
    CHAR[256] szModule;
    CHAR[260] szExePath;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
HANDLE CreateToolhelp32Snapshot(CREATE_TOOLHELP_SNAPSHOT_FLAGS dwFlags, uint th32ProcessID);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL Heap32ListFirst(HANDLE hSnapshot, HEAPLIST32* lphl);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL Heap32ListNext(HANDLE hSnapshot, HEAPLIST32* lphl);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL Heap32First(HEAPENTRY32* lphe, uint th32ProcessID, size_t th32HeapID);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL Heap32Next(HEAPENTRY32* lphe);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL Toolhelp32ReadProcessMemory(uint th32ProcessID, const(void)* lpBaseAddress, void* lpBuffer, size_t cbRead, 
                                 size_t* lpNumberOfBytesRead);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL Process32FirstW(HANDLE hSnapshot, PROCESSENTRY32W* lppe);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL Process32NextW(HANDLE hSnapshot, PROCESSENTRY32W* lppe);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL Process32First(HANDLE hSnapshot, PROCESSENTRY32* lppe);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL Process32Next(HANDLE hSnapshot, PROCESSENTRY32* lppe);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL Thread32First(HANDLE hSnapshot, THREADENTRY32* lpte);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL Thread32Next(HANDLE hSnapshot, THREADENTRY32* lpte);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL Module32FirstW(HANDLE hSnapshot, MODULEENTRY32W* lpme);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL Module32NextW(HANDLE hSnapshot, MODULEENTRY32W* lpme);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL Module32First(HANDLE hSnapshot, MODULEENTRY32* lpme);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL Module32Next(HANDLE hSnapshot, MODULEENTRY32* lpme);


