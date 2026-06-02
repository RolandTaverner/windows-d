// Written in the D programming language.

module windows.win32.networkmanagement.webdav;

public import windows.core;
public import windows.win32.foundation : BOOL, HANDLE, PWSTR;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/davclnt/ne-davclnt-authnextstep
alias AUTHNEXTSTEP = int;
enum : int
{
    DefaultBehavior = 0x00000000,
    RetryRequest    = 0x00000001,
    CancelRequest   = 0x00000002,
}

// Constants


enum : uint
{
    DAV_AUTHN_SCHEME_BASIC     = 0x00000001U,
    DAV_AUTHN_SCHEME_NTLM      = 0x00000002U,
    DAV_AUTHN_SCHEME_PASSPORT  = 0x00000004U,
    DAV_AUTHN_SCHEME_DIGEST    = 0x00000008U,
    DAV_AUTHN_SCHEME_NEGOTIATE = 0x00000010U,
    DAV_AUTHN_SCHEME_CERT      = 0x00010000U,
    DAV_AUTHN_SCHEME_FBA       = 0x00100000U,
}

// Callbacks

alias PFNDAVAUTHCALLBACK_FREECRED = uint function(void* pbuffer);
alias PFNDAVAUTHCALLBACK = uint function(PWSTR lpwzServerName, PWSTR lpwzRemoteName, uint dwAuthScheme, 
                                         uint dwFlags, DAV_CALLBACK_CRED* pCallbackCred, AUTHNEXTSTEP* NextStep, 
                                         PFNDAVAUTHCALLBACK_FREECRED* pFreeCred);

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/davclnt/ns-davclnt-dav_callback_auth_blob
struct DAV_CALLBACK_AUTH_BLOB
{
    void* pBuffer;
    uint  ulSize;
    uint  ulType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/davclnt/ns-davclnt-dav_callback_auth_unp
struct DAV_CALLBACK_AUTH_UNP
{
    PWSTR pszUserName;
    uint  ulUserNameLength;
    PWSTR pszPassword;
    uint  ulPasswordLength;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/davclnt/ns-davclnt-dav_callback_cred
struct DAV_CALLBACK_CRED
{
    DAV_CALLBACK_AUTH_BLOB AuthBlob;
    DAV_CALLBACK_AUTH_UNP UNPBlob;
    BOOL bAuthBlobValid;
    BOOL bSave;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
uint DavAddConnection(HANDLE* ConnectionHandle, const(PWSTR) RemoteName, const(PWSTR) UserName, 
                      const(PWSTR) Password, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* ClientCert, 
                      uint CertSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
uint DavDeleteConnection(HANDLE ConnectionHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
uint DavGetUNCFromHTTPPath(const(PWSTR) Url, PWSTR UncPath, uint* lpSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
uint DavGetHTTPFromUNCPath(const(PWSTR) UncPath, PWSTR Url, uint* lpSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("davclnt.dll")
uint DavGetTheLockOwnerOfTheFile(const(PWSTR) FileName, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/PWSTR LockOwnerName, 
                                 uint* LockOwnerNameLengthInBytes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
uint DavGetExtendedError(HANDLE hFile, uint* ExtError, PWSTR ExtErrorString, uint* cChSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
uint DavFlushFile(HANDLE hFile);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("davclnt.dll")
uint DavInvalidateCache(const(PWSTR) URLName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("davclnt.dll")
uint DavCancelConnectionsToServer(PWSTR lpName, BOOL fForce);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("davclnt.dll")
uint DavRegisterAuthCallback(PFNDAVAUTHCALLBACK CallBack, uint Version);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("davclnt.dll")
void DavUnregisterAuthCallback(uint hCallback);


