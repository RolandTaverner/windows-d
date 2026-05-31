// Written in the D programming language.

module windows.win32.system.useraccesslogging;

public import windows.core;
public import system : Guid;
public import windows.win32.foundation : HRESULT, PWSTR;
public import windows.win32.networking.winsock : SOCKADDR_STORAGE;

extern(Windows) @nogc nothrow:


// Structs


//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ual/ns-ual-ual_data_blob))], [])
struct UAL_DATA_BLOB
{
    uint             Size;
    GUID             RoleGuid;
    GUID             TenantId;
    SOCKADDR_STORAGE Address;
    wchar[260]       UserName;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("ualapi.dll")
HRESULT UalStart(UAL_DATA_BLOB* Data);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("ualapi.dll")
HRESULT UalStop(UAL_DATA_BLOB* Data);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("ualapi.dll")
HRESULT UalInstrument(UAL_DATA_BLOB* Data);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("ualapi.dll")
HRESULT UalRegisterProduct(const(PWSTR) wszProductName, const(PWSTR) wszRoleName, const(PWSTR) wszGuid);


