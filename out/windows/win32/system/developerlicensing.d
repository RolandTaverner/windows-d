// Written in the D programming language.

module windows.win32.system.developerlicensing;

public import windows.core;
public import windows.win32.foundation.foundation : FILETIME, HRESULT, HWND;

extern(Windows) @nogc nothrow:


// Functions

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wsdevlicensing/nf-wsdevlicensing-checkdeveloperlicense
@DllImport("WSClient.dll")
HRESULT CheckDeveloperLicense(FILETIME* pExpiration);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wsdevlicensing/nf-wsdevlicensing-acquiredeveloperlicense
@DllImport("WSClient.dll")
HRESULT AcquireDeveloperLicense(HWND hwndParent, FILETIME* pExpiration);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wsdevlicensing/nf-wsdevlicensing-removedeveloperlicense
@DllImport("WSClient.dll")
HRESULT RemoveDeveloperLicense(HWND hwndParent);


