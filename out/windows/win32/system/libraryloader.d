// Written in the D programming language.

module windows.win32.system.libraryloader;

public import windows.core;
public import windows.win32.foundation.foundation : BOOL, FARPROC, HANDLE, HGLOBAL, HMODULE,
                                                    HRSRC, PSTR, PWSTR;

extern(Windows) @nogc nothrow:


// Enums


alias LOAD_LIBRARY_FLAGS = uint;
enum : uint
{
    DONT_RESOLVE_DLL_REFERENCES               = 0x00000001U,
    LOAD_LIBRARY_AS_DATAFILE                  = 0x00000002U,
    LOAD_WITH_ALTERED_SEARCH_PATH             = 0x00000008U,
    LOAD_IGNORE_CODE_AUTHZ_LEVEL              = 0x00000010U,
    LOAD_LIBRARY_AS_IMAGE_RESOURCE            = 0x00000020U,
    LOAD_LIBRARY_AS_DATAFILE_EXCLUSIVE        = 0x00000040U,
    LOAD_LIBRARY_REQUIRE_SIGNED_TARGET        = 0x00000080U,
    LOAD_LIBRARY_SEARCH_DLL_LOAD_DIR          = 0x00000100U,
    LOAD_LIBRARY_SEARCH_APPLICATION_DIR       = 0x00000200U,
    LOAD_LIBRARY_SEARCH_USER_DIRS             = 0x00000400U,
    LOAD_LIBRARY_SEARCH_SYSTEM32              = 0x00000800U,
    LOAD_LIBRARY_SEARCH_DEFAULT_DIRS          = 0x00001000U,
    LOAD_LIBRARY_SAFE_CURRENT_DIRS            = 0x00002000U,
    LOAD_LIBRARY_SEARCH_SYSTEM32_NO_FORWARDER = 0x00004000U,
}

// Constants


enum : uint
{
    FIND_RESOURCE_DIRECTORY_TYPES     = 0x00000100U,
    FIND_RESOURCE_DIRECTORY_NAMES     = 0x00000200U,
    FIND_RESOURCE_DIRECTORY_LANGUAGES = 0x00000400U,
}

enum : uint
{
    RESOURCE_ENUM_LN           = 0x00000001U,
    RESOURCE_ENUM_MUI          = 0x00000002U,
    RESOURCE_ENUM_MUI_SYSTEM   = 0x00000004U,
    RESOURCE_ENUM_VALIDATE     = 0x00000008U,
    RESOURCE_ENUM_MODULE_EXACT = 0x00000010U,
}

enum uint SUPPORT_LANG_NUMBER = 0x00000020U;

enum : uint
{
    GET_MODULE_HANDLE_EX_FLAG_PIN                = 0x00000001U,
    GET_MODULE_HANDLE_EX_FLAG_UNCHANGED_REFCOUNT = 0x00000002U,
    GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS       = 0x00000004U,
}

enum uint CURRENT_IMPORT_REDIRECTION_VERSION = 0x00000001U;
enum uint LOAD_LIBRARY_OS_INTEGRITY_CONTINUITY = 0x00008000U;

// Callbacks

//DELEGATE ATTR: AnsiAttribute : CustomAttributeSig([], [])
alias ENUMRESLANGPROCA = BOOL function(HMODULE hModule, const(PSTR) lpType, const(PSTR) lpName, ushort wLanguage, 
                                       ptrdiff_t lParam);
//DELEGATE ATTR: UnicodeAttribute : CustomAttributeSig([], [])
alias ENUMRESLANGPROCW = BOOL function(HMODULE hModule, const(PWSTR) lpType, const(PWSTR) lpName, ushort wLanguage, 
                                       ptrdiff_t lParam);
//DELEGATE ATTR: AnsiAttribute : CustomAttributeSig([], [])
alias ENUMRESNAMEPROCA = BOOL function(HMODULE hModule, const(PSTR) lpType, PSTR lpName, ptrdiff_t lParam);
//DELEGATE ATTR: UnicodeAttribute : CustomAttributeSig([], [])
alias ENUMRESNAMEPROCW = BOOL function(HMODULE hModule, const(PWSTR) lpType, PWSTR lpName, ptrdiff_t lParam);
//DELEGATE ATTR: AnsiAttribute : CustomAttributeSig([], [])
alias ENUMRESTYPEPROCA = BOOL function(HMODULE hModule, PSTR lpType, ptrdiff_t lParam);
//DELEGATE ATTR: UnicodeAttribute : CustomAttributeSig([], [])
alias ENUMRESTYPEPROCW = BOOL function(HMODULE hModule, PWSTR lpType, ptrdiff_t lParam);
//DELEGATE ATTR: AnsiAttribute : CustomAttributeSig([], [])
alias PGET_MODULE_HANDLE_EXA = BOOL function(uint dwFlags, const(PSTR) lpModuleName, HMODULE* phModule);
//DELEGATE ATTR: UnicodeAttribute : CustomAttributeSig([], [])
alias PGET_MODULE_HANDLE_EXW = BOOL function(uint dwFlags, const(PWSTR) lpModuleName, HMODULE* phModule);

// Structs


struct ENUMUILANG
{
    uint    NumOfEnumUILang;
    uint    SizeOfEnumUIBuffer;
    ushort* pEnumUIBuffer;
}

struct REDIRECTION_FUNCTION_DESCRIPTOR
{
    const(PSTR) DllName;
    const(PSTR) FunctionName;
    void*       RedirectionTarget;
}

struct REDIRECTION_DESCRIPTOR
{
    uint Version;
    uint FunctionCount;
    REDIRECTION_FUNCTION_DESCRIPTOR* Redirections;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL DisableThreadLibraryCalls(HMODULE hLibModule);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("KERNEL32.dll")
HRSRC FindResourceExW(HMODULE hModule, const(PWSTR) lpType, const(PWSTR) lpName, ushort wLanguage);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
void FreeLibraryAndExitThread(HMODULE hLibModule, uint dwExitCode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL FreeResource(HGLOBAL hResData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
uint GetModuleFileNameA(HMODULE hModule, PSTR lpFilename, uint nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
uint GetModuleFileNameW(HMODULE hModule, PWSTR lpFilename, uint nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
HMODULE GetModuleHandleA(const(PSTR) lpModuleName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
HMODULE GetModuleHandleW(const(PWSTR) lpModuleName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL GetModuleHandleExA(uint dwFlags, const(PSTR) lpModuleName, HMODULE* phModule);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL GetModuleHandleExW(uint dwFlags, const(PWSTR) lpModuleName, HMODULE* phModule);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
FARPROC GetProcAddress(HMODULE hModule, const(PSTR) lpProcName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
HMODULE LoadLibraryExA(const(PSTR) lpLibFileName, 
                       /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/HANDLE hFile, 
                       LOAD_LIBRARY_FLAGS dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
HMODULE LoadLibraryExW(const(PWSTR) lpLibFileName, 
                       /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/HANDLE hFile, 
                       LOAD_LIBRARY_FLAGS dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
HGLOBAL LoadResource(HMODULE hModule, HRSRC hResInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
void* LockResource(HGLOBAL hResData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
uint SizeofResource(HMODULE hModule, HRSRC hResInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("KERNEL32.dll")
void* AddDllDirectory(const(PWSTR) NewDirectory);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("KERNEL32.dll")
BOOL RemoveDllDirectory(void* Cookie);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("KERNEL32.dll")
BOOL SetDefaultDllDirectories(LOAD_LIBRARY_FLAGS DirectoryFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL EnumResourceLanguagesExA(HMODULE hModule, const(PSTR) lpType, const(PSTR) lpName, ENUMRESLANGPROCA lpEnumFunc, 
                              ptrdiff_t lParam, uint dwFlags, ushort LangId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL EnumResourceLanguagesExW(HMODULE hModule, const(PWSTR) lpType, const(PWSTR) lpName, 
                              ENUMRESLANGPROCW lpEnumFunc, ptrdiff_t lParam, uint dwFlags, ushort LangId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL EnumResourceNamesExA(HMODULE hModule, const(PSTR) lpType, ENUMRESNAMEPROCA lpEnumFunc, ptrdiff_t lParam, 
                          uint dwFlags, ushort LangId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL EnumResourceNamesExW(HMODULE hModule, const(PWSTR) lpType, ENUMRESNAMEPROCW lpEnumFunc, ptrdiff_t lParam, 
                          uint dwFlags, ushort LangId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL EnumResourceTypesExA(HMODULE hModule, ENUMRESTYPEPROCA lpEnumFunc, ptrdiff_t lParam, uint dwFlags, 
                          ushort LangId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL EnumResourceTypesExW(HMODULE hModule, ENUMRESTYPEPROCW lpEnumFunc, ptrdiff_t lParam, uint dwFlags, 
                          ushort LangId);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("KERNEL32.dll")
HRSRC FindResourceW(HMODULE hModule, const(PWSTR) lpName, const(PWSTR) lpType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
HMODULE LoadLibraryA(const(PSTR) lpLibFileName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
HMODULE LoadLibraryW(const(PWSTR) lpLibFileName);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("KERNEL32.dll")
BOOL EnumResourceNamesW(HMODULE hModule, const(PWSTR) lpType, ENUMRESNAMEPROCW lpEnumFunc, ptrdiff_t lParam);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL EnumResourceNamesA(HMODULE hModule, const(PSTR) lpType, ENUMRESNAMEPROCA lpEnumFunc, ptrdiff_t lParam);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("KERNEL32.dll")
HMODULE LoadPackagedLibrary(const(PWSTR) lpwLibFileName, 
                            /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint Reserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("api-ms-win-core-libraryloader-l2-1-0.dll")
BOOL QueryOptionalDelayLoadedAPI(HMODULE hParentModule, const(PSTR) lpDllName, const(PSTR) lpProcName, 
                                 /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint Reserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
uint LoadModule(const(PSTR) lpModuleName, void* lpParameterBlock);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
HRSRC FindResourceA(HMODULE hModule, const(PSTR) lpName, const(PSTR) lpType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
HRSRC FindResourceExA(HMODULE hModule, const(PSTR) lpType, const(PSTR) lpName, ushort wLanguage);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL EnumResourceTypesA(HMODULE hModule, ENUMRESTYPEPROCA lpEnumFunc, ptrdiff_t lParam);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL EnumResourceTypesW(HMODULE hModule, ENUMRESTYPEPROCW lpEnumFunc, ptrdiff_t lParam);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL EnumResourceLanguagesA(HMODULE hModule, const(PSTR) lpType, const(PSTR) lpName, ENUMRESLANGPROCA lpEnumFunc, 
                            ptrdiff_t lParam);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL EnumResourceLanguagesW(HMODULE hModule, const(PWSTR) lpType, const(PWSTR) lpName, ENUMRESLANGPROCW lpEnumFunc, 
                            ptrdiff_t lParam);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
HANDLE BeginUpdateResourceA(const(PSTR) pFileName, BOOL bDeleteExistingResources);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
HANDLE BeginUpdateResourceW(const(PWSTR) pFileName, BOOL bDeleteExistingResources);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL UpdateResourceA(HANDLE hUpdate, const(PSTR) lpType, const(PSTR) lpName, ushort wLanguage, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* lpData, 
                     uint cb);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL UpdateResourceW(HANDLE hUpdate, const(PWSTR) lpType, const(PWSTR) lpName, ushort wLanguage, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* lpData, 
                     uint cb);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL EndUpdateResourceA(HANDLE hUpdate, BOOL fDiscard);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL EndUpdateResourceW(HANDLE hUpdate, BOOL fDiscard);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL SetDllDirectoryA(const(PSTR) lpPathName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL SetDllDirectoryW(const(PWSTR) lpPathName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
uint GetDllDirectoryA(uint nBufferLength, PSTR lpBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
uint GetDllDirectoryW(uint nBufferLength, PWSTR lpBuffer);


