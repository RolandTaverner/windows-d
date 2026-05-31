// Written in the D programming language.

module windows.win32.system.passwordmanagement;

public import windows.core;
public import windows.win32.foundation : BOOLEAN, CHAR, PWSTR;

extern(Windows) @nogc nothrow:


// Structs


//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mschapp/ns-mschapp-cypher_block))], [])
struct CYPHER_BLOCK
{
    CHAR[8] data;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mschapp/ns-mschapp-lm_owf_password))], [])
struct LM_OWF_PASSWORD
{
    CYPHER_BLOCK[2] data;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mschapp/ns-mschapp-sampr_encrypted_user_password))], [])
struct SAMPR_ENCRYPTED_USER_PASSWORD
{
    ubyte[516] Buffer;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mschapp/ns-mschapp-encrypted_lm_owf_password))], [])
struct ENCRYPTED_LM_OWF_PASSWORD
{
    CYPHER_BLOCK[2] data;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
uint MSChapSrvChangePassword(PWSTR ServerName, PWSTR UserName, BOOLEAN LmOldPresent, 
                             LM_OWF_PASSWORD* LmOldOwfPassword, LM_OWF_PASSWORD* LmNewOwfPassword, 
                             LM_OWF_PASSWORD* NtOldOwfPassword, LM_OWF_PASSWORD* NtNewOwfPassword);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
uint MSChapSrvChangePassword2(PWSTR ServerName, PWSTR UserName, 
                              SAMPR_ENCRYPTED_USER_PASSWORD* NewPasswordEncryptedWithOldNt, 
                              ENCRYPTED_LM_OWF_PASSWORD* OldNtOwfPasswordEncryptedWithNewNt, BOOLEAN LmPresent, 
                              SAMPR_ENCRYPTED_USER_PASSWORD* NewPasswordEncryptedWithOldLm, 
                              ENCRYPTED_LM_OWF_PASSWORD* OldLmOwfPasswordEncryptedWithNewLmOrNt);


