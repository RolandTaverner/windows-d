// Written in the D programming language.

module windows.win32.security.winwlx;

public import windows.core;
public import windows.win32.foundation.foundation : BOOL, HANDLE, HWND, LPARAM, LUID, PWSTR;
public import windows.win32.security.security : QUOTA_LIMITS;
public import windows.win32.system.stationsanddesktops : HDESK;
public import windows.win32.ui.windowsandmessaging : DLGPROC, DLGTEMPLATE;

extern(Windows) @nogc nothrow:


// Enums


alias WLX_SHUTDOWN_TYPE = uint;
enum : uint
{
    WLX_SAS_ACTION_SHUTDOWN           = 0x00000005U,
    WLX_SAS_ACTION_SHUTDOWN_REBOOT    = 0x0000000bU,
    WLX_SAS_ACTION_SHUTDOWN_POWER_OFF = 0x0000000aU,
}

// Constants


enum : uint
{
    WLX_VERSION_1_0 = 0x00010000U,
    WLX_VERSION_1_1 = 0x00010001U,
    WLX_VERSION_1_2 = 0x00010002U,
    WLX_VERSION_1_3 = 0x00010003U,
    WLX_VERSION_1_4 = 0x00010004U,
}

enum uint WLX_CURRENT_VERSION = 0x00010004U;

enum : uint
{
    WLX_SAS_TYPE_TIMEOUT                 = 0x00000000U,
    WLX_SAS_TYPE_CTRL_ALT_DEL            = 0x00000001U,
    WLX_SAS_TYPE_SCRNSVR_TIMEOUT         = 0x00000002U,
    WLX_SAS_TYPE_SCRNSVR_ACTIVITY        = 0x00000003U,
    WLX_SAS_TYPE_USER_LOGOFF             = 0x00000004U,
    WLX_SAS_TYPE_SC_INSERT               = 0x00000005U,
    WLX_SAS_TYPE_SC_REMOVE               = 0x00000006U,
    WLX_SAS_TYPE_AUTHENTICATED           = 0x00000007U,
    WLX_SAS_TYPE_SC_FIRST_READER_ARRIVED = 0x00000008U,
    WLX_SAS_TYPE_SC_LAST_READER_REMOVED  = 0x00000009U,
}

enum : uint
{
    WLX_SAS_TYPE_SWITCHUSER     = 0x0000000aU,
    WLX_SAS_TYPE_MAX_MSFT_VALUE = 0x0000007fU,
}

enum uint WLX_LOGON_OPT_NO_PROFILE = 0x00000001U;

enum : uint
{
    WLX_PROFILE_TYPE_V1_0 = 0x00000001U,
    WLX_PROFILE_TYPE_V2_0 = 0x00000002U,
}

enum : uint
{
    WLX_SAS_ACTION_LOGON                = 0x00000001U,
    WLX_SAS_ACTION_NONE                 = 0x00000002U,
    WLX_SAS_ACTION_LOCK_WKSTA           = 0x00000003U,
    WLX_SAS_ACTION_LOGOFF               = 0x00000004U,
    WLX_SAS_ACTION_PWD_CHANGED          = 0x00000006U,
    WLX_SAS_ACTION_TASKLIST             = 0x00000007U,
    WLX_SAS_ACTION_UNLOCK_WKSTA         = 0x00000008U,
    WLX_SAS_ACTION_FORCE_LOGOFF         = 0x00000009U,
    WLX_SAS_ACTION_SHUTDOWN_SLEEP       = 0x0000000cU,
    WLX_SAS_ACTION_SHUTDOWN_SLEEP2      = 0x0000000dU,
    WLX_SAS_ACTION_SHUTDOWN_HIBERNATE   = 0x0000000eU,
    WLX_SAS_ACTION_RECONNECTED          = 0x0000000fU,
    WLX_SAS_ACTION_DELAYED_FORCE_LOGOFF = 0x00000010U,
    WLX_SAS_ACTION_SWITCH_CONSOLE       = 0x00000011U,
}

enum uint WLX_WM_SAS = 0x00000659U;

enum : uint
{
    WLX_DLG_SAS           = 0x00000065U,
    WLX_DLG_INPUT_TIMEOUT = 0x00000066U,
}

enum uint WLX_DLG_SCREEN_SAVER_TIMEOUT = 0x00000067U;
enum uint WLX_DLG_USER_LOGOFF = 0x00000068U;
enum uint WLX_DIRECTORY_LENGTH = 0x00000100U;

enum : uint
{
    WLX_CREDENTIAL_TYPE_V1_0 = 0x00000001U,
    WLX_CREDENTIAL_TYPE_V2_0 = 0x00000002U,
}

enum uint WLX_CONSOLESWITCHCREDENTIAL_TYPE_V1_0 = 0x00000001U;

enum : uint
{
    STATUSMSG_OPTION_NOANIMATION   = 0x00000001U,
    STATUSMSG_OPTION_SETFOREGROUND = 0x00000002U,
}

enum : uint
{
    WLX_DESKTOP_NAME   = 0x00000001U,
    WLX_DESKTOP_HANDLE = 0x00000002U,
}

enum : uint
{
    WLX_CREATE_INSTANCE_ONLY = 0x00000001U,
    WLX_CREATE_USER          = 0x00000002U,
}

enum : uint
{
    WLX_OPTION_USE_CTRL_ALT_DEL  = 0x00000001U,
    WLX_OPTION_CONTEXT_POINTER   = 0x00000002U,
    WLX_OPTION_USE_SMART_CARD    = 0x00000003U,
    WLX_OPTION_FORCE_LOGOFF_TIME = 0x00000004U,
}

enum uint WLX_OPTION_IGNORE_AUTO_LOGON = 0x00000008U;

enum : uint
{
    WLX_OPTION_NO_SWITCH_ON_SAS    = 0x00000009U,
    WLX_OPTION_SMART_CARD_PRESENT  = 0x00010001U,
    WLX_OPTION_SMART_CARD_INFO     = 0x00010002U,
    WLX_OPTION_DISPATCH_TABLE_SIZE = 0x00010003U,
}

// Callbacks

alias PWLX_USE_CTRL_ALT_DEL = void function(HANDLE hWlx);
alias PWLX_SET_CONTEXT_POINTER = void function(HANDLE hWlx, void* pWlxContext);
alias PWLX_SAS_NOTIFY = void function(HANDLE hWlx, uint dwSasType);
alias PWLX_SET_TIMEOUT = BOOL function(HANDLE hWlx, uint Timeout);
alias PWLX_ASSIGN_SHELL_PROTECTION = int function(HANDLE hWlx, HANDLE hToken, HANDLE hProcess, HANDLE hThread);
alias PWLX_MESSAGE_BOX = int function(HANDLE hWlx, HWND hwndOwner, PWSTR lpszText, PWSTR lpszTitle, uint fuStyle);
alias PWLX_DIALOG_BOX = int function(HANDLE hWlx, HANDLE hInst, PWSTR lpszTemplate, HWND hwndOwner, DLGPROC dlgprc);
alias PWLX_DIALOG_BOX_INDIRECT = int function(HANDLE hWlx, HANDLE hInst, DLGTEMPLATE* hDialogTemplate, 
                                              HWND hwndOwner, DLGPROC dlgprc);
alias PWLX_DIALOG_BOX_PARAM = int function(HANDLE hWlx, HANDLE hInst, PWSTR lpszTemplate, HWND hwndOwner, 
                                           DLGPROC dlgprc, LPARAM dwInitParam);
alias PWLX_DIALOG_BOX_INDIRECT_PARAM = int function(HANDLE hWlx, HANDLE hInst, DLGTEMPLATE* hDialogTemplate, 
                                                    HWND hwndOwner, DLGPROC dlgprc, LPARAM dwInitParam);
alias PWLX_SWITCH_DESKTOP_TO_USER = int function(HANDLE hWlx);
alias PWLX_SWITCH_DESKTOP_TO_WINLOGON = int function(HANDLE hWlx);
alias PWLX_CHANGE_PASSWORD_NOTIFY = int function(HANDLE hWlx, WLX_MPR_NOTIFY_INFO* pMprInfo, uint dwChangeInfo);
alias PWLX_GET_SOURCE_DESKTOP = BOOL function(HANDLE hWlx, WLX_DESKTOP** ppDesktop);
alias PWLX_SET_RETURN_DESKTOP = BOOL function(HANDLE hWlx, WLX_DESKTOP* pDesktop);
alias PWLX_CREATE_USER_DESKTOP = BOOL function(HANDLE hWlx, HANDLE hToken, uint Flags, PWSTR pszDesktopName, 
                                               WLX_DESKTOP** ppDesktop);
alias PWLX_CHANGE_PASSWORD_NOTIFY_EX = int function(HANDLE hWlx, WLX_MPR_NOTIFY_INFO* pMprInfo, uint dwChangeInfo, 
                                                    PWSTR ProviderName, void* Reserved);
alias PWLX_CLOSE_USER_DESKTOP = BOOL function(HANDLE hWlx, WLX_DESKTOP* pDesktop, HANDLE hToken);
alias PWLX_SET_OPTION = BOOL function(HANDLE hWlx, uint Option, size_t Value, size_t* OldValue);
alias PWLX_GET_OPTION = BOOL function(HANDLE hWlx, uint Option, size_t* Value);
alias PWLX_WIN31_MIGRATE = void function(HANDLE hWlx);
alias PWLX_QUERY_CLIENT_CREDENTIALS = BOOL function(WLX_CLIENT_CREDENTIALS_INFO_V1_0* pCred);
alias PWLX_QUERY_IC_CREDENTIALS = BOOL function(WLX_CLIENT_CREDENTIALS_INFO_V1_0* pCred);
alias PWLX_QUERY_TS_LOGON_CREDENTIALS = BOOL function(WLX_CLIENT_CREDENTIALS_INFO_V2_0* pCred);
alias PWLX_DISCONNECT = BOOL function();
alias PWLX_QUERY_TERMINAL_SERVICES_DATA = uint function(HANDLE hWlx, WLX_TERMINAL_SERVICES_DATA* pTSData, 
                                                        PWSTR UserName, PWSTR Domain);
alias PWLX_QUERY_CONSOLESWITCH_CREDENTIALS = uint function(WLX_CONSOLESWITCH_CREDENTIALS_INFO_V1_0* pCred);
alias PFNMSGECALLBACK = uint function(BOOL bVerbose, PWSTR lpMessage);

// Structs


struct WLX_SC_NOTIFICATION_INFO
{
    PWSTR pszCard;
    PWSTR pszReader;
    PWSTR pszContainer;
    PWSTR pszCryptoProvider;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winwlx/ns-winwlx-wlx_profile_v1_0
struct WLX_PROFILE_V1_0
{
    uint  dwType;
    PWSTR pszProfile;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winwlx/ns-winwlx-wlx_profile_v2_0
struct WLX_PROFILE_V2_0
{
    uint  dwType;
    PWSTR pszProfile;
    PWSTR pszPolicy;
    PWSTR pszNetworkDefaultUserProfile;
    PWSTR pszServerName;
    PWSTR pszEnvironment;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winwlx/ns-winwlx-wlx_mpr_notify_info
struct WLX_MPR_NOTIFY_INFO
{
    PWSTR pszUserName;
    PWSTR pszDomain;
    PWSTR pszPassword;
    PWSTR pszOldPassword;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winwlx/ns-winwlx-wlx_terminal_services_data
struct WLX_TERMINAL_SERVICES_DATA
{
    wchar[257] ProfilePath;
    wchar[257] HomeDir;
    wchar[4]   HomeDirDrive;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winwlx/ns-winwlx-wlx_client_credentials_info_v1_0
struct WLX_CLIENT_CREDENTIALS_INFO_V1_0
{
    uint  dwType;
    PWSTR pszUserName;
    PWSTR pszDomain;
    PWSTR pszPassword;
    BOOL  fPromptForPassword;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winwlx/ns-winwlx-wlx_client_credentials_info_v2_0
struct WLX_CLIENT_CREDENTIALS_INFO_V2_0
{
    uint  dwType;
    PWSTR pszUserName;
    PWSTR pszDomain;
    PWSTR pszPassword;
    BOOL  fPromptForPassword;
    BOOL  fDisconnectOnLogonFailure;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winwlx/ns-winwlx-wlx_consoleswitch_credentials_info_v1_0
struct WLX_CONSOLESWITCH_CREDENTIALS_INFO_V1_0
{
    uint         dwType;
    HANDLE       UserToken;
    LUID         LogonId;
    QUOTA_LIMITS Quotas;
    PWSTR        UserName;
    PWSTR        Domain;
    long         LogonTime;
    BOOL         SmartCardLogon;
    uint         ProfileLength;
    uint         MessageType;
    ushort       LogonCount;
    ushort       BadPasswordCount;
    long         ProfileLogonTime;
    long         LogoffTime;
    long         KickOffTime;
    long         PasswordLastSet;
    long         PasswordCanChange;
    long         PasswordMustChange;
    PWSTR        LogonScript;
    PWSTR        HomeDirectory;
    PWSTR        FullName;
    PWSTR        ProfilePath;
    PWSTR        HomeDirectoryDrive;
    PWSTR        LogonServer;
    uint         UserFlags;
    uint         PrivateDataLen;
    ubyte*       PrivateData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winwlx/ns-winwlx-wlx_desktop
struct WLX_DESKTOP
{
    uint  Size;
    uint  Flags;
    HDESK hDesktop;
    PWSTR pszDesktopName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winwlx/ns-winwlx-wlx_dispatch_version_1_0
struct WLX_DISPATCH_VERSION_1_0
{
    PWLX_USE_CTRL_ALT_DEL WlxUseCtrlAltDel;
    PWLX_SET_CONTEXT_POINTER WlxSetContextPointer;
    PWLX_SAS_NOTIFY  WlxSasNotify;
    PWLX_SET_TIMEOUT WlxSetTimeout;
    PWLX_ASSIGN_SHELL_PROTECTION WlxAssignShellProtection;
    PWLX_MESSAGE_BOX WlxMessageBox;
    PWLX_DIALOG_BOX  WlxDialogBox;
    PWLX_DIALOG_BOX_PARAM WlxDialogBoxParam;
    PWLX_DIALOG_BOX_INDIRECT WlxDialogBoxIndirect;
    PWLX_DIALOG_BOX_INDIRECT_PARAM WlxDialogBoxIndirectParam;
    PWLX_SWITCH_DESKTOP_TO_USER WlxSwitchDesktopToUser;
    PWLX_SWITCH_DESKTOP_TO_WINLOGON WlxSwitchDesktopToWinlogon;
    PWLX_CHANGE_PASSWORD_NOTIFY WlxChangePasswordNotify;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winwlx/ns-winwlx-wlx_dispatch_version_1_1
struct WLX_DISPATCH_VERSION_1_1
{
    PWLX_USE_CTRL_ALT_DEL WlxUseCtrlAltDel;
    PWLX_SET_CONTEXT_POINTER WlxSetContextPointer;
    PWLX_SAS_NOTIFY  WlxSasNotify;
    PWLX_SET_TIMEOUT WlxSetTimeout;
    PWLX_ASSIGN_SHELL_PROTECTION WlxAssignShellProtection;
    PWLX_MESSAGE_BOX WlxMessageBox;
    PWLX_DIALOG_BOX  WlxDialogBox;
    PWLX_DIALOG_BOX_PARAM WlxDialogBoxParam;
    PWLX_DIALOG_BOX_INDIRECT WlxDialogBoxIndirect;
    PWLX_DIALOG_BOX_INDIRECT_PARAM WlxDialogBoxIndirectParam;
    PWLX_SWITCH_DESKTOP_TO_USER WlxSwitchDesktopToUser;
    PWLX_SWITCH_DESKTOP_TO_WINLOGON WlxSwitchDesktopToWinlogon;
    PWLX_CHANGE_PASSWORD_NOTIFY WlxChangePasswordNotify;
    PWLX_GET_SOURCE_DESKTOP WlxGetSourceDesktop;
    PWLX_SET_RETURN_DESKTOP WlxSetReturnDesktop;
    PWLX_CREATE_USER_DESKTOP WlxCreateUserDesktop;
    PWLX_CHANGE_PASSWORD_NOTIFY_EX WlxChangePasswordNotifyEx;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winwlx/ns-winwlx-wlx_dispatch_version_1_2
struct WLX_DISPATCH_VERSION_1_2
{
    PWLX_USE_CTRL_ALT_DEL WlxUseCtrlAltDel;
    PWLX_SET_CONTEXT_POINTER WlxSetContextPointer;
    PWLX_SAS_NOTIFY  WlxSasNotify;
    PWLX_SET_TIMEOUT WlxSetTimeout;
    PWLX_ASSIGN_SHELL_PROTECTION WlxAssignShellProtection;
    PWLX_MESSAGE_BOX WlxMessageBox;
    PWLX_DIALOG_BOX  WlxDialogBox;
    PWLX_DIALOG_BOX_PARAM WlxDialogBoxParam;
    PWLX_DIALOG_BOX_INDIRECT WlxDialogBoxIndirect;
    PWLX_DIALOG_BOX_INDIRECT_PARAM WlxDialogBoxIndirectParam;
    PWLX_SWITCH_DESKTOP_TO_USER WlxSwitchDesktopToUser;
    PWLX_SWITCH_DESKTOP_TO_WINLOGON WlxSwitchDesktopToWinlogon;
    PWLX_CHANGE_PASSWORD_NOTIFY WlxChangePasswordNotify;
    PWLX_GET_SOURCE_DESKTOP WlxGetSourceDesktop;
    PWLX_SET_RETURN_DESKTOP WlxSetReturnDesktop;
    PWLX_CREATE_USER_DESKTOP WlxCreateUserDesktop;
    PWLX_CHANGE_PASSWORD_NOTIFY_EX WlxChangePasswordNotifyEx;
    PWLX_CLOSE_USER_DESKTOP WlxCloseUserDesktop;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winwlx/ns-winwlx-wlx_dispatch_version_1_3
struct WLX_DISPATCH_VERSION_1_3
{
    PWLX_USE_CTRL_ALT_DEL WlxUseCtrlAltDel;
    PWLX_SET_CONTEXT_POINTER WlxSetContextPointer;
    PWLX_SAS_NOTIFY    WlxSasNotify;
    PWLX_SET_TIMEOUT   WlxSetTimeout;
    PWLX_ASSIGN_SHELL_PROTECTION WlxAssignShellProtection;
    PWLX_MESSAGE_BOX   WlxMessageBox;
    PWLX_DIALOG_BOX    WlxDialogBox;
    PWLX_DIALOG_BOX_PARAM WlxDialogBoxParam;
    PWLX_DIALOG_BOX_INDIRECT WlxDialogBoxIndirect;
    PWLX_DIALOG_BOX_INDIRECT_PARAM WlxDialogBoxIndirectParam;
    PWLX_SWITCH_DESKTOP_TO_USER WlxSwitchDesktopToUser;
    PWLX_SWITCH_DESKTOP_TO_WINLOGON WlxSwitchDesktopToWinlogon;
    PWLX_CHANGE_PASSWORD_NOTIFY WlxChangePasswordNotify;
    PWLX_GET_SOURCE_DESKTOP WlxGetSourceDesktop;
    PWLX_SET_RETURN_DESKTOP WlxSetReturnDesktop;
    PWLX_CREATE_USER_DESKTOP WlxCreateUserDesktop;
    PWLX_CHANGE_PASSWORD_NOTIFY_EX WlxChangePasswordNotifyEx;
    PWLX_CLOSE_USER_DESKTOP WlxCloseUserDesktop;
    PWLX_SET_OPTION    WlxSetOption;
    PWLX_GET_OPTION    WlxGetOption;
    PWLX_WIN31_MIGRATE WlxWin31Migrate;
    PWLX_QUERY_CLIENT_CREDENTIALS WlxQueryClientCredentials;
    PWLX_QUERY_IC_CREDENTIALS WlxQueryInetConnectorCredentials;
    PWLX_DISCONNECT    WlxDisconnect;
    PWLX_QUERY_TERMINAL_SERVICES_DATA WlxQueryTerminalServicesData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winwlx/ns-winwlx-wlx_dispatch_version_1_4
struct WLX_DISPATCH_VERSION_1_4
{
    PWLX_USE_CTRL_ALT_DEL WlxUseCtrlAltDel;
    PWLX_SET_CONTEXT_POINTER WlxSetContextPointer;
    PWLX_SAS_NOTIFY    WlxSasNotify;
    PWLX_SET_TIMEOUT   WlxSetTimeout;
    PWLX_ASSIGN_SHELL_PROTECTION WlxAssignShellProtection;
    PWLX_MESSAGE_BOX   WlxMessageBox;
    PWLX_DIALOG_BOX    WlxDialogBox;
    PWLX_DIALOG_BOX_PARAM WlxDialogBoxParam;
    PWLX_DIALOG_BOX_INDIRECT WlxDialogBoxIndirect;
    PWLX_DIALOG_BOX_INDIRECT_PARAM WlxDialogBoxIndirectParam;
    PWLX_SWITCH_DESKTOP_TO_USER WlxSwitchDesktopToUser;
    PWLX_SWITCH_DESKTOP_TO_WINLOGON WlxSwitchDesktopToWinlogon;
    PWLX_CHANGE_PASSWORD_NOTIFY WlxChangePasswordNotify;
    PWLX_GET_SOURCE_DESKTOP WlxGetSourceDesktop;
    PWLX_SET_RETURN_DESKTOP WlxSetReturnDesktop;
    PWLX_CREATE_USER_DESKTOP WlxCreateUserDesktop;
    PWLX_CHANGE_PASSWORD_NOTIFY_EX WlxChangePasswordNotifyEx;
    PWLX_CLOSE_USER_DESKTOP WlxCloseUserDesktop;
    PWLX_SET_OPTION    WlxSetOption;
    PWLX_GET_OPTION    WlxGetOption;
    PWLX_WIN31_MIGRATE WlxWin31Migrate;
    PWLX_QUERY_CLIENT_CREDENTIALS WlxQueryClientCredentials;
    PWLX_QUERY_IC_CREDENTIALS WlxQueryInetConnectorCredentials;
    PWLX_DISCONNECT    WlxDisconnect;
    PWLX_QUERY_TERMINAL_SERVICES_DATA WlxQueryTerminalServicesData;
    PWLX_QUERY_CONSOLESWITCH_CREDENTIALS WlxQueryConsoleSwitchCredentials;
    PWLX_QUERY_TS_LOGON_CREDENTIALS WlxQueryTsLogonCredentials;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winwlx/ns-winwlx-wlx_notification_info
struct WLX_NOTIFICATION_INFO
{
    uint            Size;
    uint            Flags;
    PWSTR           UserName;
    PWSTR           Domain;
    PWSTR           WindowStation;
    HANDLE          hToken;
    HDESK           hDesktop;
    PFNMSGECALLBACK pStatusCallback;
}

