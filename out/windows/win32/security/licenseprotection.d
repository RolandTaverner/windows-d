// Written in the D programming language.

module windows.win32.security.licenseprotection;

public import windows.core;
public import windows.win32.foundation : FILETIME, HRESULT, PWSTR;

extern(Windows) @nogc nothrow:


// Enums

enum LicenseProtectionStatus : int
{
    Success                 = 0x00000000,
    LicenseKeyNotFound      = 0x00000001,
    LicenseKeyUnprotected   = 0x00000002,
    LicenseKeyCorrupted     = 0x00000003,
    LicenseKeyAlreadyExists = 0x00000004,
}

// Functions

@DllImport("licenseprotection.dll")
HRESULT RegisterLicenseKeyWithExpiration(const(PWSTR) licenseKey, uint validityInDays, 
                                         LicenseProtectionStatus* status);

@DllImport("licenseprotection.dll")
HRESULT ValidateLicenseKeyProtection(const(PWSTR) licenseKey, FILETIME* notValidBefore, FILETIME* notValidAfter, 
                                     LicenseProtectionStatus* status);


