// Written in the D programming language.

module windows.win32.system.winrt.storage;

public import windows.core;
public import windows.win32.foundation.foundation : HANDLE, HRESULT, PWSTR;
public import windows.win32.system.com.com : IUnknown;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windowsstoragecom/ne-windowsstoragecom-handle_options
alias HANDLE_OPTIONS = uint;
enum : uint
{
    HO_NONE                  = 0x00000000U,
    HO_OPEN_REQUIRING_OPLOCK = 0x00040000U,
    HO_DELETE_ON_CLOSE       = 0x04000000U,
    HO_SEQUENTIAL_SCAN       = 0x08000000U,
    HO_RANDOM_ACCESS         = 0x10000000U,
    HO_NO_BUFFERING          = 0x20000000U,
    HO_OVERLAPPED            = 0x40000000U,
    HO_WRITE_THROUGH         = 0x80000000U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windowsstoragecom/ne-windowsstoragecom-handle_access_options
alias HANDLE_ACCESS_OPTIONS = int;
enum : int
{
    HAO_NONE            = 0x00000000,
    HAO_READ_ATTRIBUTES = 0x00000080,
    HAO_READ            = 0x00120089,
    HAO_WRITE           = 0x00120116,
    HAO_DELETE          = 0x00010000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windowsstoragecom/ne-windowsstoragecom-handle_sharing_options
alias HANDLE_SHARING_OPTIONS = int;
enum : int
{
    HSO_SHARE_NONE   = 0x00000000,
    HSO_SHARE_READ   = 0x00000001,
    HSO_SHARE_WRITE  = 0x00000002,
    HSO_SHARE_DELETE = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windowsstoragecom/ne-windowsstoragecom-handle_creation_options
alias HANDLE_CREATION_OPTIONS = int;
enum : int
{
    HCO_CREATE_NEW        = 0x00000001,
    HCO_CREATE_ALWAYS     = 0x00000002,
    HCO_OPEN_EXISTING     = 0x00000003,
    HCO_OPEN_ALWAYS       = 0x00000004,
    HCO_TRUNCATE_EXISTING = 0x00000005,
}

// Interfaces

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windowsstoragecom/nn-windowsstoragecom-irandomaccessstreamfileaccessmode
@GUID("332e5848-2e15-458e-85c4-c911c0c3d6f4")
interface IRandomAccessStreamFileAccessMode : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windowsstoragecom/nf-windowsstoragecom-irandomaccessstreamfileaccessmode-getmode
    HRESULT GetMode(uint* fileAccessMode);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windowsstoragecom/nn-windowsstoragecom-iunbufferedfilehandleoplockcallback
@GUID("d1019a0e-6243-4329-8497-2e75894d7710")
interface IUnbufferedFileHandleOplockCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windowsstoragecom/nf-windowsstoragecom-iunbufferedfilehandleoplockcallback-onbrokencallback
    HRESULT OnBrokenCallback();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windowsstoragecom/nn-windowsstoragecom-iunbufferedfilehandleprovider
@GUID("a65c9109-42ab-4b94-a7b1-dd2e4e68515e")
interface IUnbufferedFileHandleProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windowsstoragecom/nf-windowsstoragecom-iunbufferedfilehandleprovider-openunbufferedfilehandle
    HRESULT OpenUnbufferedFileHandle(IUnbufferedFileHandleOplockCallback oplockBreakCallback, size_t* fileHandle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windowsstoragecom/nf-windowsstoragecom-iunbufferedfilehandleprovider-closeunbufferedfilehandle
    HRESULT CloseUnbufferedFileHandle();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windowsstoragecom/nn-windowsstoragecom-ioplockbreakinghandler
@GUID("826abe3d-3acd-47d3-84f2-88aaedcf6304")
interface IOplockBreakingHandler : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windowsstoragecom/nf-windowsstoragecom-ioplockbreakinghandler-oplockbreaking
    HRESULT OplockBreaking();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windowsstoragecom/nn-windowsstoragecom-istorageitemhandleaccess
@GUID("5ca296b2-2c25-4d22-b785-b885c8201e6a")
interface IStorageItemHandleAccess : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windowsstoragecom/nf-windowsstoragecom-istorageitemhandleaccess-create
    HRESULT Create(HANDLE_ACCESS_OPTIONS accessOptions, HANDLE_SHARING_OPTIONS sharingOptions, 
                   HANDLE_OPTIONS options, IOplockBreakingHandler oplockBreakingHandler, HANDLE* interopHandle);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windowsstoragecom/nn-windowsstoragecom-istoragefolderhandleaccess
@GUID("df19938f-5462-48a0-be65-d2a3271a08d6")
interface IStorageFolderHandleAccess : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/windowsstoragecom/nf-windowsstoragecom-istoragefolderhandleaccess-create
    HRESULT Create(const(PWSTR) fileName, HANDLE_CREATION_OPTIONS creationOptions, 
                   HANDLE_ACCESS_OPTIONS accessOptions, HANDLE_SHARING_OPTIONS sharingOptions, 
                   HANDLE_OPTIONS options, IOplockBreakingHandler oplockBreakingHandler, HANDLE* interopHandle);
}


// GUIDs


const GUID IID_IOplockBreakingHandler              = GUIDOF!IOplockBreakingHandler;
const GUID IID_IRandomAccessStreamFileAccessMode   = GUIDOF!IRandomAccessStreamFileAccessMode;
const GUID IID_IStorageFolderHandleAccess          = GUIDOF!IStorageFolderHandleAccess;
const GUID IID_IStorageItemHandleAccess            = GUIDOF!IStorageItemHandleAccess;
const GUID IID_IUnbufferedFileHandleOplockCallback = GUIDOF!IUnbufferedFileHandleOplockCallback;
const GUID IID_IUnbufferedFileHandleProvider       = GUIDOF!IUnbufferedFileHandleProvider;
