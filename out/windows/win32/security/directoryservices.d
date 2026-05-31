// Written in the D programming language.

module windows.win32.security.directoryservices;

public import windows.core;
public import windows.win32.foundation.foundation : HRESULT, HWND, LPARAM, PWSTR;
public import windows.win32.security.authorization.ui : ISecurityInformation;
public import windows.win32.security.security : PSECURITY_DESCRIPTOR;
public import windows.win32.ui.controls.controls : HPROPSHEETPAGE;

extern(Windows) @nogc nothrow:


// Constants


enum uint DSSI_READ_ONLY = 0x00000001U;
enum uint DSSI_NO_ACCESS_CHECK = 0x00000002U;

enum : uint
{
    DSSI_NO_EDIT_SACL  = 0x00000004U,
    DSSI_NO_EDIT_OWNER = 0x00000008U,
}

enum : uint
{
    DSSI_IS_ROOT             = 0x00000010U,
    DSSI_NO_FILTER           = 0x00000020U,
    DSSI_NO_READONLY_MESSAGE = 0x00000040U,
}

// Callbacks

alias PFNREADOBJECTSECURITY = HRESULT function(const(PWSTR) param0, uint param1, PSECURITY_DESCRIPTOR* param2, 
                                               LPARAM param3);
alias PFNWRITEOBJECTSECURITY = HRESULT function(const(PWSTR) param0, uint param1, PSECURITY_DESCRIPTOR param2, 
                                                LPARAM param3);
alias PFNDSCREATEISECINFO = HRESULT function(const(PWSTR) param0, const(PWSTR) param1, uint param2, 
                                             ISecurityInformation* param3, PFNREADOBJECTSECURITY param4, 
                                             PFNWRITEOBJECTSECURITY param5, LPARAM param6);
alias PFNDSCREATEISECINFOEX = HRESULT function(const(PWSTR) param0, const(PWSTR) param1, const(PWSTR) param2, 
                                               const(PWSTR) param3, const(PWSTR) param4, uint param5, 
                                               ISecurityInformation* param6, PFNREADOBJECTSECURITY param7, 
                                               PFNWRITEOBJECTSECURITY param8, LPARAM param9);
alias PFNDSCREATESECPAGE = HRESULT function(const(PWSTR) param0, const(PWSTR) param1, uint param2, 
                                            HPROPSHEETPAGE* param3, PFNREADOBJECTSECURITY param4, 
                                            PFNWRITEOBJECTSECURITY param5, LPARAM param6);
alias PFNDSEDITSECURITY = HRESULT function(HWND param0, const(PWSTR) param1, const(PWSTR) param2, uint param3, 
                                           const(PWSTR) param4, PFNREADOBJECTSECURITY param5, 
                                           PFNWRITEOBJECTSECURITY param6, LPARAM param7);

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DSSEC.dll")
HRESULT DSCreateISecurityInfoObject(const(PWSTR) pwszObjectPath, const(PWSTR) pwszObjectClass, uint dwFlags, 
                                    ISecurityInformation* ppSI, PFNREADOBJECTSECURITY pfnReadSD, 
                                    PFNWRITEOBJECTSECURITY pfnWriteSD, LPARAM lpContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DSSEC.dll")
HRESULT DSCreateISecurityInfoObjectEx(const(PWSTR) pwszObjectPath, const(PWSTR) pwszObjectClass, 
                                      const(PWSTR) pwszServer, const(PWSTR) pwszUserName, const(PWSTR) pwszPassword, 
                                      uint dwFlags, ISecurityInformation* ppSI, PFNREADOBJECTSECURITY pfnReadSD, 
                                      PFNWRITEOBJECTSECURITY pfnWriteSD, LPARAM lpContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("DSSEC.dll")
HRESULT DSCreateSecurityPage(const(PWSTR) pwszObjectPath, const(PWSTR) pwszObjectClass, uint dwFlags, 
                             HPROPSHEETPAGE* phPage, PFNREADOBJECTSECURITY pfnReadSD, 
                             PFNWRITEOBJECTSECURITY pfnWriteSD, LPARAM lpContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("DSSEC.dll")
HRESULT DSEditSecurity(HWND hwndOwner, const(PWSTR) pwszObjectPath, const(PWSTR) pwszObjectClass, uint dwFlags, 
                       const(PWSTR) pwszCaption, PFNREADOBJECTSECURITY pfnReadSD, PFNWRITEOBJECTSECURITY pfnWriteSD, 
                       LPARAM lpContext);


