// Written in the D programming language.

module windows.win32.system.com.channelcredentials;

public import windows.core;
public import windows.win32.foundation.foundation : BOOL, BSTR, HRESULT;
public import windows.win32.system.com.com : IDispatch;
public import windows.win32.system.variant : VARIANT;

extern(Windows) @nogc nothrow:


// Interfaces

@GUID("181b448c-c17c-4b17-ac6d-06699b93198f")
interface IChannelCredentials : IDispatch
{
    HRESULT SetWindowsCredential(BSTR domain, BSTR username, BSTR password, int impersonationLevel, BOOL allowNtlm);
    HRESULT SetUserNameCredential(BSTR username, BSTR password);
    HRESULT SetClientCertificateFromStore(BSTR storeLocation, BSTR storeName, BSTR findYype, VARIANT findValue);
    HRESULT SetClientCertificateFromStoreByName(BSTR subjectName, BSTR storeLocation, BSTR storeName);
    HRESULT SetClientCertificateFromFile(BSTR filename, BSTR password, BSTR keystorageFlags);
    HRESULT SetDefaultServiceCertificateFromStore(BSTR storeLocation, BSTR storeName, BSTR findType, 
                                                  VARIANT findValue);
    HRESULT SetDefaultServiceCertificateFromStoreByName(BSTR subjectName, BSTR storeLocation, BSTR storeName);
    HRESULT SetDefaultServiceCertificateFromFile(BSTR filename, BSTR password, BSTR keystorageFlags);
    HRESULT SetServiceCertificateAuthentication(BSTR storeLocation, BSTR revocationMode, 
                                                BSTR certificateValidationMode);
    HRESULT SetIssuedToken(BSTR localIssuerAddres, BSTR localIssuerBindingType, BSTR localIssuerBinding);
}


// GUIDs


const GUID IID_IChannelCredentials = GUIDOF!IChannelCredentials;
