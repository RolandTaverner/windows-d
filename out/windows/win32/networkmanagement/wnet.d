// Written in the D programming language.

module windows.win32.networkmanagement.wnet;

public import windows.core;
public import windows.win32.foundation.foundation : BOOL, HANDLE, HWND, LUID, PSTR, PWSTR,
                                                    WIN32_ERROR;

extern(Windows) @nogc nothrow:


// Enums


alias UNC_INFO_LEVEL = uint;
enum : uint
{
    UNIVERSAL_NAME_INFO_LEVEL = 0x00000001U,
    REMOTE_NAME_INFO_LEVEL    = 0x00000002U,
}

alias WNPERM_DLG = uint;
enum : uint
{
    WNPERM_DLG_PERM  = 0x00000000U,
    WNPERM_DLG_AUDIT = 0x00000001U,
    WNPERM_DLG_OWNER = 0x00000002U,
}

alias WNET_OPEN_ENUM_USAGE = uint;
enum : uint
{
    RESOURCEUSAGE_NONE        = 0x00000000U,
    RESOURCEUSAGE_CONNECTABLE = 0x00000001U,
    RESOURCEUSAGE_CONTAINER   = 0x00000002U,
    RESOURCEUSAGE_ATTACHED    = 0x00000010U,
    RESOURCEUSAGE_ALL         = 0x00000013U,
}

alias NET_CONNECT_FLAGS = uint;
enum : uint
{
    CONNECT_UPDATE_PROFILE          = 0x00000001U,
    CONNECT_UPDATE_RECENT           = 0x00000002U,
    CONNECT_TEMPORARY               = 0x00000004U,
    CONNECT_INTERACTIVE             = 0x00000008U,
    CONNECT_PROMPT                  = 0x00000010U,
    CONNECT_NEED_DRIVE              = 0x00000020U,
    CONNECT_REFCOUNT                = 0x00000040U,
    CONNECT_REDIRECT                = 0x00000080U,
    CONNECT_LOCALDRIVE              = 0x00000100U,
    CONNECT_CURRENT_MEDIA           = 0x00000200U,
    CONNECT_DEFERRED                = 0x00000400U,
    CONNECT_RESERVED                = 0xff000000U,
    CONNECT_COMMANDLINE             = 0x00000800U,
    CONNECT_CMD_SAVECRED            = 0x00001000U,
    CONNECT_CRED_RESET              = 0x00002000U,
    CONNECT_REQUIRE_INTEGRITY       = 0x00004000U,
    CONNECT_REQUIRE_PRIVACY         = 0x00008000U,
    CONNECT_WRITE_THROUGH_SEMANTICS = 0x00010000U,
    CONNECT_GLOBAL_MAPPING          = 0x00040000U,
}

alias NP_PROPERTY_DIALOG_SELECTION = uint;
enum : uint
{
    WNPS_FILE = 0x00000000U,
    WNPS_DIR  = 0x00000001U,
    WNPS_MULT = 0x00000002U,
}

alias NPDIRECTORY_NOTIFY_OPERATION = uint;
enum : uint
{
    WNDN_MKDIR = 0x00000001U,
    WNDN_RMDIR = 0x00000002U,
    WNDN_MVDIR = 0x00000003U,
}

alias NET_RESOURCE_TYPE = uint;
enum : uint
{
    RESOURCETYPE_ANY   = 0x00000000U,
    RESOURCETYPE_DISK  = 0x00000001U,
    RESOURCETYPE_PRINT = 0x00000002U,
}

alias NETWORK_NAME_FORMAT_FLAGS = uint;
enum : uint
{
    WNFMT_MULTILINE   = 0x00000001U,
    WNFMT_ABBREVIATED = 0x00000002U,
}

alias NET_RESOURCE_SCOPE = uint;
enum : uint
{
    RESOURCE_CONNECTED  = 0x00000001U,
    RESOURCE_CONTEXT    = 0x00000005U,
    RESOURCE_GLOBALNET  = 0x00000002U,
    RESOURCE_REMEMBERED = 0x00000003U,
}

alias NETINFOSTRUCT_CHARACTERISTICS = uint;
enum : uint
{
    NETINFO_DLL16      = 0x00000001U,
    NETINFO_DISKRED    = 0x00000004U,
    NETINFO_PRINTERRED = 0x00000008U,
}

alias CONNECTDLGSTRUCT_FLAGS = uint;
enum : uint
{
    CONNDLG_RO_PATH     = 0x00000001U,
    CONNDLG_CONN_POINT  = 0x00000002U,
    CONNDLG_USE_MRU     = 0x00000004U,
    CONNDLG_HIDE_BOX    = 0x00000008U,
    CONNDLG_PERSIST     = 0x00000010U,
    CONNDLG_NOT_PERSIST = 0x00000020U,
}

alias DISCDLGSTRUCT_FLAGS = uint;
enum : uint
{
    DISC_UPDATE_PROFILE = 0x00000001U,
    DISC_NO_FORCE       = 0x00000040U,
}

// Constants


enum : uint
{
    WNGETCON_CONNECTED    = 0x00000000U,
    WNGETCON_DISCONNECTED = 0x00000001U,
}

enum : uint
{
    WNNC_SPEC_VERSION   = 0x00000001U,
    WNNC_SPEC_VERSION51 = 0x00050001U,
}

enum : uint
{
    WNNC_NET_TYPE = 0x00000002U,
    WNNC_NET_NONE = 0x00000000U,
}

enum uint WNNC_DRIVER_VERSION = 0x00000003U;

enum : uint
{
    WNNC_USER        = 0x00000004U,
    WNNC_USR_GETUSER = 0x00000001U,
}

enum : uint
{
    WNNC_CONNECTION           = 0x00000006U,
    WNNC_CON_ADDCONNECTION    = 0x00000001U,
    WNNC_CON_CANCELCONNECTION = 0x00000002U,
}

enum uint WNNC_CON_GETCONNECTIONS = 0x00000004U;

enum : uint
{
    WNNC_CON_ADDCONNECTION3 = 0x00000008U,
    WNNC_CON_ADDCONNECTION4 = 0x00000010U,
}

enum uint WNNC_CON_CANCELCONNECTION2 = 0x00000020U;
enum uint WNNC_CON_GETPERFORMANCE = 0x00000040U;
enum uint WNNC_CON_DEFER = 0x00000080U;

enum : uint
{
    WNNC_DIALOG             = 0x00000008U,
    WNNC_DLG_DEVICEMODE     = 0x00000001U,
    WNNC_DLG_PROPERTYDIALOG = 0x00000020U,
}

enum : uint
{
    WNNC_DLG_SEARCHDIALOG      = 0x00000040U,
    WNNC_DLG_FORMATNETWORKNAME = 0x00000080U,
}

enum uint WNNC_DLG_PERMISSIONEDITOR = 0x00000100U;

enum : uint
{
    WNNC_DLG_GETRESOURCEPARENT      = 0x00000200U,
    WNNC_DLG_GETRESOURCEINFORMATION = 0x00000800U,
}

enum : uint
{
    WNNC_ADMIN                = 0x00000009U,
    WNNC_ADM_GETDIRECTORYTYPE = 0x00000001U,
}

enum uint WNNC_ADM_DIRECTORYNOTIFY = 0x00000002U;

enum : uint
{
    WNNC_ENUMERATION    = 0x0000000bU,
    WNNC_ENUM_GLOBAL    = 0x00000001U,
    WNNC_ENUM_LOCAL     = 0x00000002U,
    WNNC_ENUM_CONTEXT   = 0x00000004U,
    WNNC_ENUM_SHAREABLE = 0x00000008U,
}

enum : uint
{
    WNNC_START          = 0x0000000cU,
    WNNC_WAIT_FOR_START = 0x00000001U,
}

enum uint WNNC_CONNECTION_FLAGS = 0x0000000dU;

enum : uint
{
    WNTYPE_DRIVE   = 0x00000001U,
    WNTYPE_FILE    = 0x00000002U,
    WNTYPE_PRINTER = 0x00000003U,
    WNTYPE_COMM    = 0x00000004U,
}

enum uint WNSRCH_REFRESH_FIRST_LEVEL = 0x00000001U;

enum : uint
{
    WNDT_NORMAL  = 0x00000000U,
    WNDT_NETWORK = 0x00000001U,
}

enum uint WN_NETWORK_CLASS = 0x00000001U;
enum uint WN_CREDENTIAL_CLASS = 0x00000002U;
enum uint WN_PRIMARY_AUTHENT_CLASS = 0x00000004U;
enum uint WN_SERVICE_CLASS = 0x00000008U;
enum uint WN_VALID_LOGON_ACCOUNT = 0x00000001U;
enum uint WN_NT_PASSWORD_CHANGED = 0x00000002U;

enum : uint
{
    NOTIFY_PRE  = 0x00000001U,
    NOTIFY_POST = 0x00000002U,
}

enum : uint
{
    WNPERMC_PERM  = 0x00000001U,
    WNPERMC_AUDIT = 0x00000002U,
    WNPERMC_OWNER = 0x00000004U,
}

enum : uint
{
    RESOURCE_RECENT       = 0x00000004U,
    RESOURCETYPE_RESERVED = 0x00000008U,
    RESOURCETYPE_UNKNOWN  = 0xffffffffU,
}

enum : uint
{
    RESOURCEUSAGE_NOLOCALDEVICE = 0x00000004U,
    RESOURCEUSAGE_SIBLING       = 0x00000008U,
    RESOURCEUSAGE_RESERVED      = 0x80000000U,
}

enum : uint
{
    RESOURCEDISPLAYTYPE_NETWORK      = 0x00000006U,
    RESOURCEDISPLAYTYPE_ROOT         = 0x00000007U,
    RESOURCEDISPLAYTYPE_SHAREADMIN   = 0x00000008U,
    RESOURCEDISPLAYTYPE_DIRECTORY    = 0x00000009U,
    RESOURCEDISPLAYTYPE_NDSCONTAINER = 0x0000000bU,
}

enum uint NETPROPERTY_PERSISTENT = 0x00000001U;

enum : uint
{
    WNFMT_INENUM     = 0x00000010U,
    WNFMT_CONNECTION = 0x00000020U,
}

enum uint WNCON_FORNETCARD = 0x00000001U;
enum uint WNCON_NOTROUTED = 0x00000002U;

enum : uint
{
    WNCON_SLOWLINK = 0x00000004U,
    WNCON_DYNAMIC  = 0x00000008U,
}

// Callbacks

alias PF_NPAddConnection = uint function(NETRESOURCEW* lpNetResource, PWSTR lpPassword, PWSTR lpUserName);
alias PF_NPAddConnection3 = uint function(HWND hwndOwner, NETRESOURCEW* lpNetResource, PWSTR lpPassword, 
                                          PWSTR lpUserName, uint dwFlags);
alias PF_NPAddConnection4 = uint function(HWND hwndOwner, NETRESOURCEW* lpNetResource, 
                                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpAuthBuffer, 
                                          uint cbAuthBuffer, uint dwFlags, 
                                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/ubyte* lpUseOptions, 
                                          uint cbUseOptions);
alias PF_NPCancelConnection = uint function(PWSTR lpName, BOOL fForce);
alias PF_NPCancelConnection2 = uint function(PWSTR lpName, BOOL fForce, uint dwFlags);
alias PF_NPGetConnection = uint function(PWSTR lpLocalName, PWSTR lpRemoteName, uint* lpnBufferLen);
alias PF_NPGetConnection3 = uint function(const(PWSTR) lpLocalName, uint dwLevel, 
                                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpBuffer, 
                                          uint* lpBufferSize);
alias PF_NPGetUniversalName = uint function(const(PWSTR) lpLocalPath, uint dwInfoLevel, 
                                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpBuffer, 
                                            uint* lpnBufferSize);
alias PF_NPGetConnectionPerformance = uint function(const(PWSTR) lpRemoteName, 
                                                    NETCONNECTINFOSTRUCT* lpNetConnectInfo);
alias PF_NPOpenEnum = uint function(uint dwScope, uint dwType, uint dwUsage, NETRESOURCEW* lpNetResource, 
                                    HANDLE* lphEnum);
alias PF_NPEnumResource = uint function(HANDLE hEnum, uint* lpcCount, 
                                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpBuffer, 
                                        uint* lpBufferSize);
alias PF_NPCloseEnum = uint function(HANDLE hEnum);
alias PF_NPGetCaps = uint function(uint ndex);
alias PF_NPGetUser = uint function(PWSTR lpName, PWSTR lpUserName, uint* lpnBufferLen);
alias PF_NPGetPersistentUseOptionsForConnection = uint function(PWSTR lpRemotePath, 
                                                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ubyte* lpReadUseOptions, 
                                                                uint cbReadUseOptions, 
                                                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* lpWriteUseOptions, 
                                                                uint* lpSizeWriteUseOptions);
alias PF_NPDeviceMode = uint function(HWND hParent);
alias PF_NPSearchDialog = uint function(HWND hwndParent, NETRESOURCEW* lpNetResource, void* lpBuffer, 
                                        uint cbBuffer, uint* lpnFlags);
alias PF_NPGetResourceParent = uint function(NETRESOURCEW* lpNetResource, 
                                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* lpBuffer, 
                                             uint* lpBufferSize);
alias PF_NPGetResourceInformation = uint function(NETRESOURCEW* lpNetResource, 
                                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* lpBuffer, 
                                                  uint* lpBufferSize, PWSTR* lplpSystem);
alias PF_NPFormatNetworkName = uint function(PWSTR lpRemoteName, PWSTR lpFormattedName, uint* lpnLength, 
                                             uint dwFlags, uint dwAveCharPerLine);
alias PF_NPGetPropertyText = uint function(uint iButton, uint nPropSel, PWSTR lpName, PWSTR lpButtonName, 
                                           uint nButtonNameLen, uint nType);
alias PF_NPPropertyDialog = uint function(HWND hwndParent, uint iButtonDlg, uint nPropSel, PWSTR lpFileName, 
                                          uint nType);
alias PF_NPGetDirectoryType = uint function(PWSTR lpName, int* lpType, BOOL bFlushCache);
alias PF_NPDirectoryNotify = uint function(HWND hwnd, PWSTR lpDir, uint dwOper);
alias PF_NPLogonNotify = uint function(LUID* lpLogonId, const(PWSTR) lpAuthentInfoType, void* lpAuthentInfo, 
                                       const(PWSTR) lpPreviousAuthentInfoType, void* lpPreviousAuthentInfo, 
                                       PWSTR lpStationName, void* StationHandle, PWSTR* lpLogonScript);
alias PF_NPPasswordChangeNotify = uint function(const(PWSTR) lpAuthentInfoType, void* lpAuthentInfo, 
                                                const(PWSTR) lpPreviousAuthentInfoType, void* lpPreviousAuthentInfo, 
                                                PWSTR lpStationName, void* StationHandle, uint dwChangeInfo);
alias PF_AddConnectNotify = uint function(NOTIFYINFO* lpNotifyInfo, NOTIFYADD* lpAddInfo);
alias PF_CancelConnectNotify = uint function(NOTIFYINFO* lpNotifyInfo, NOTIFYCANCEL* lpCancelInfo);
alias PF_NPFMXGetPermCaps = uint function(PWSTR lpDriveName);
alias PF_NPFMXEditPerm = uint function(PWSTR lpDriveName, HWND hwndFMX, uint nDialogType);
alias PF_NPFMXGetPermHelp = uint function(PWSTR lpDriveName, uint nDialogType, BOOL fDirectory, 
                                          void* lpFileNameBuffer, uint* lpBufferSize, uint* lpnHelpContext);

// Structs


//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnetwk/ns-winnetwk-netresourcea
struct NETRESOURCEA
{
    NET_RESOURCE_SCOPE dwScope;
    NET_RESOURCE_TYPE  dwType;
    uint               dwDisplayType;
    uint               dwUsage;
    PSTR               lpLocalName;
    PSTR               lpRemoteName;
    PSTR               lpComment;
    PSTR               lpProvider;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnetwk/ns-winnetwk-netresourcew
struct NETRESOURCEW
{
    NET_RESOURCE_SCOPE dwScope;
    NET_RESOURCE_TYPE  dwType;
    uint               dwDisplayType;
    uint               dwUsage;
    PWSTR              lpLocalName;
    PWSTR              lpRemoteName;
    PWSTR              lpComment;
    PWSTR              lpProvider;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnetwk/ns-winnetwk-connectdlgstructa
struct CONNECTDLGSTRUCTA
{
    uint          cbStructure;
    HWND          hwndOwner;
    NETRESOURCEA* lpConnRes;
    CONNECTDLGSTRUCT_FLAGS dwFlags;
    uint          dwDevNum;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnetwk/ns-winnetwk-connectdlgstructw
struct CONNECTDLGSTRUCTW
{
    uint          cbStructure;
    HWND          hwndOwner;
    NETRESOURCEW* lpConnRes;
    CONNECTDLGSTRUCT_FLAGS dwFlags;
    uint          dwDevNum;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnetwk/ns-winnetwk-discdlgstructa
struct DISCDLGSTRUCTA
{
    uint                cbStructure;
    HWND                hwndOwner;
    PSTR                lpLocalName;
    PSTR                lpRemoteName;
    DISCDLGSTRUCT_FLAGS dwFlags;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnetwk/ns-winnetwk-discdlgstructw
struct DISCDLGSTRUCTW
{
    uint                cbStructure;
    HWND                hwndOwner;
    PWSTR               lpLocalName;
    PWSTR               lpRemoteName;
    DISCDLGSTRUCT_FLAGS dwFlags;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnetwk/ns-winnetwk-universal_name_infoa
struct UNIVERSAL_NAME_INFOA
{
    PSTR lpUniversalName;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnetwk/ns-winnetwk-universal_name_infow
struct UNIVERSAL_NAME_INFOW
{
    PWSTR lpUniversalName;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnetwk/ns-winnetwk-remote_name_infoa
struct REMOTE_NAME_INFOA
{
    PSTR lpUniversalName;
    PSTR lpConnectionName;
    PSTR lpRemainingPath;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnetwk/ns-winnetwk-remote_name_infow
struct REMOTE_NAME_INFOW
{
    PWSTR lpUniversalName;
    PWSTR lpConnectionName;
    PWSTR lpRemainingPath;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnetwk/ns-winnetwk-netinfostruct
struct NETINFOSTRUCT
{
    uint        cbStructure;
    uint        dwProviderVersion;
    WIN32_ERROR dwStatus;
    NETINFOSTRUCT_CHARACTERISTICS dwCharacteristics;
    size_t      dwHandle;
    ushort      wNetType;
    uint        dwPrinters;
    uint        dwDrives;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnetwk/ns-winnetwk-netconnectinfostruct
struct NETCONNECTINFOSTRUCT
{
    uint cbStructure;
    uint dwFlags;
    uint dwSpeed;
    uint dwDelay;
    uint dwOptDataSize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/npapi/ns-npapi-notifyinfo
struct NOTIFYINFO
{
    uint  dwNotifyStatus;
    uint  dwOperationStatus;
    void* lpContext;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/npapi/ns-npapi-notifyadd
struct NOTIFYADD
{
    HWND              hwndOwner;
    NETRESOURCEA      NetResource;
    NET_CONNECT_FLAGS dwAddFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/npapi/ns-npapi-notifycancel
struct NOTIFYCANCEL
{
    PWSTR lpName;
    PWSTR lpProvider;
    uint  dwFlags;
    BOOL  fForce;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetAddConnectionA(const(PSTR) lpRemoteName, const(PSTR) lpPassword, const(PSTR) lpLocalName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetAddConnectionW(const(PWSTR) lpRemoteName, const(PWSTR) lpPassword, const(PWSTR) lpLocalName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetAddConnection2A(NETRESOURCEA* lpNetResource, const(PSTR) lpPassword, const(PSTR) lpUserName, 
                                NET_CONNECT_FLAGS dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetAddConnection2W(NETRESOURCEW* lpNetResource, const(PWSTR) lpPassword, const(PWSTR) lpUserName, 
                                NET_CONNECT_FLAGS dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetAddConnection3A(HWND hwndOwner, NETRESOURCEA* lpNetResource, const(PSTR) lpPassword, 
                                const(PSTR) lpUserName, NET_CONNECT_FLAGS dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetAddConnection3W(HWND hwndOwner, NETRESOURCEW* lpNetResource, const(PWSTR) lpPassword, 
                                const(PWSTR) lpUserName, NET_CONNECT_FLAGS dwFlags);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetAddConnection4A(HWND hwndOwner, NETRESOURCEA* lpNetResource, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pAuthBuffer, 
                                uint cbAuthBuffer, NET_CONNECT_FLAGS dwFlags, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/ubyte* lpUseOptions, 
                                uint cbUseOptions);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetAddConnection4W(HWND hwndOwner, NETRESOURCEW* lpNetResource, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pAuthBuffer, 
                                uint cbAuthBuffer, NET_CONNECT_FLAGS dwFlags, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/ubyte* lpUseOptions, 
                                uint cbUseOptions);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetCancelConnectionA(const(PSTR) lpName, BOOL fForce);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetCancelConnectionW(const(PWSTR) lpName, BOOL fForce);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetCancelConnection2A(const(PSTR) lpName, NET_CONNECT_FLAGS dwFlags, BOOL fForce);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetCancelConnection2W(const(PWSTR) lpName, NET_CONNECT_FLAGS dwFlags, BOOL fForce);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetGetConnectionA(const(PSTR) lpLocalName, PSTR lpRemoteName, uint* lpnLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetGetConnectionW(const(PWSTR) lpLocalName, PWSTR lpRemoteName, uint* lpnLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetUseConnectionA(HWND hwndOwner, NETRESOURCEA* lpNetResource, const(PSTR) lpPassword, 
                               const(PSTR) lpUserId, NET_CONNECT_FLAGS dwFlags, PSTR lpAccessName, 
                               uint* lpBufferSize, uint* lpResult);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetUseConnectionW(HWND hwndOwner, NETRESOURCEW* lpNetResource, const(PWSTR) lpPassword, 
                               const(PWSTR) lpUserId, NET_CONNECT_FLAGS dwFlags, PWSTR lpAccessName, 
                               uint* lpBufferSize, uint* lpResult);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetUseConnection4A(HWND hwndOwner, NETRESOURCEA* lpNetResource, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pAuthBuffer, 
                                uint cbAuthBuffer, uint dwFlags, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/ubyte* lpUseOptions, 
                                uint cbUseOptions, PSTR lpAccessName, uint* lpBufferSize, uint* lpResult);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetUseConnection4W(HWND hwndOwner, NETRESOURCEW* lpNetResource, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pAuthBuffer, 
                                uint cbAuthBuffer, uint dwFlags, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/ubyte* lpUseOptions, 
                                uint cbUseOptions, PWSTR lpAccessName, uint* lpBufferSize, uint* lpResult);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetConnectionDialog(HWND hwnd, uint dwType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetDisconnectDialog(HWND hwnd, uint dwType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetConnectionDialog1A(CONNECTDLGSTRUCTA* lpConnDlgStruct);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetConnectionDialog1W(CONNECTDLGSTRUCTW* lpConnDlgStruct);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetDisconnectDialog1A(DISCDLGSTRUCTA* lpConnDlgStruct);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetDisconnectDialog1W(DISCDLGSTRUCTW* lpConnDlgStruct);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetOpenEnumA(NET_RESOURCE_SCOPE dwScope, NET_RESOURCE_TYPE dwType, WNET_OPEN_ENUM_USAGE dwUsage, 
                          NETRESOURCEA* lpNetResource, 
                          /*PARAM ATTR: RAIIFreeAttribute : CustomAttributeSig([FixedArgSig(ElementSig(WNetCloseEnum))], [])*/HANDLE* lphEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetOpenEnumW(NET_RESOURCE_SCOPE dwScope, NET_RESOURCE_TYPE dwType, WNET_OPEN_ENUM_USAGE dwUsage, 
                          NETRESOURCEW* lpNetResource, 
                          /*PARAM ATTR: RAIIFreeAttribute : CustomAttributeSig([FixedArgSig(ElementSig(WNetCloseEnum))], [])*/HANDLE* lphEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetEnumResourceA(HANDLE hEnum, uint* lpcCount, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpBuffer, 
                              uint* lpBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetEnumResourceW(HANDLE hEnum, uint* lpcCount, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpBuffer, 
                              uint* lpBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetCloseEnum(HANDLE hEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetGetResourceParentA(NETRESOURCEA* lpNetResource, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* lpBuffer, 
                                   uint* lpcbBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetGetResourceParentW(NETRESOURCEW* lpNetResource, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* lpBuffer, 
                                   uint* lpcbBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetGetResourceInformationA(NETRESOURCEA* lpNetResource, 
                                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* lpBuffer, 
                                        uint* lpcbBuffer, PSTR* lplpSystem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetGetResourceInformationW(NETRESOURCEW* lpNetResource, 
                                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* lpBuffer, 
                                        uint* lpcbBuffer, PWSTR* lplpSystem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetGetUniversalNameA(const(PSTR) lpLocalPath, UNC_INFO_LEVEL dwInfoLevel, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpBuffer, 
                                  uint* lpBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetGetUniversalNameW(const(PWSTR) lpLocalPath, UNC_INFO_LEVEL dwInfoLevel, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpBuffer, 
                                  uint* lpBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetGetUserA(const(PSTR) lpName, PSTR lpUserName, uint* lpnLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetGetUserW(const(PWSTR) lpName, PWSTR lpUserName, uint* lpnLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetGetProviderNameA(uint dwNetType, PSTR lpProviderName, uint* lpBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetGetProviderNameW(uint dwNetType, PWSTR lpProviderName, uint* lpBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetGetNetworkInformationA(const(PSTR) lpProvider, NETINFOSTRUCT* lpNetInfoStruct);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetGetNetworkInformationW(const(PWSTR) lpProvider, NETINFOSTRUCT* lpNetInfoStruct);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetGetLastErrorA(uint* lpError, PSTR lpErrorBuf, uint nErrorBufSize, PSTR lpNameBuf, 
                              uint nNameBufSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetGetLastErrorW(uint* lpError, PWSTR lpErrorBuf, uint nErrorBufSize, PWSTR lpNameBuf, 
                              uint nNameBufSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPR.dll")
uint MultinetGetConnectionPerformanceA(NETRESOURCEA* lpNetResource, NETCONNECTINFOSTRUCT* lpNetConnectInfoStruct);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPR.dll")
uint MultinetGetConnectionPerformanceW(NETRESOURCEW* lpNetResource, NETCONNECTINFOSTRUCT* lpNetConnectInfoStruct);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("davclnt.dll")
uint NPAddConnection(NETRESOURCEW* lpNetResource, PWSTR lpPassword, PWSTR lpUserName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("davclnt.dll")
uint NPAddConnection3(HWND hwndOwner, NETRESOURCEW* lpNetResource, PWSTR lpPassword, PWSTR lpUserName, 
                      NET_CONNECT_FLAGS dwFlags);

@DllImport("NTLANMAN.dll")
uint NPAddConnection4(HWND hwndOwner, NETRESOURCEW* lpNetResource, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpAuthBuffer, 
                      uint cbAuthBuffer, uint dwFlags, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/ubyte* lpUseOptions, 
                      uint cbUseOptions);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("davclnt.dll")
uint NPCancelConnection(PWSTR lpName, BOOL fForce);

@DllImport("NTLANMAN.dll")
uint NPCancelConnection2(PWSTR lpName, BOOL fForce, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("davclnt.dll")
uint NPGetConnection(PWSTR lpLocalName, PWSTR lpRemoteName, uint* lpnBufferLen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("NTLANMAN.dll")
uint NPGetConnection3(const(PWSTR) lpLocalName, uint dwLevel, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpBuffer, 
                      uint* lpBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("davclnt.dll")
uint NPGetUniversalName(const(PWSTR) lpLocalPath, UNC_INFO_LEVEL dwInfoLevel, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpBuffer, 
                        uint* lpBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("NTLANMAN.dll")
uint NPGetConnectionPerformance(const(PWSTR) lpRemoteName, NETCONNECTINFOSTRUCT* lpNetConnectInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("davclnt.dll")
uint NPOpenEnum(uint dwScope, uint dwType, uint dwUsage, NETRESOURCEW* lpNetResource, HANDLE* lphEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("davclnt.dll")
uint NPEnumResource(HANDLE hEnum, uint* lpcCount, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpBuffer, 
                    uint* lpBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("davclnt.dll")
uint NPCloseEnum(HANDLE hEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("davclnt.dll")
uint NPGetCaps(uint ndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("davclnt.dll")
uint NPGetUser(PWSTR lpName, PWSTR lpUserName, uint* lpnBufferLen);

@DllImport("NTLANMAN.dll")
uint NPGetPersistentUseOptionsForConnection(PWSTR lpRemotePath, 
                                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ubyte* lpReadUseOptions, 
                                            uint cbReadUseOptions, 
                                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* lpWriteUseOptions, 
                                            uint* lpSizeWriteUseOptions);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("davclnt.dll")
uint NPGetResourceParent(NETRESOURCEW* lpNetResource, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* lpBuffer, 
                         uint* lpBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("davclnt.dll")
uint NPGetResourceInformation(NETRESOURCEW* lpNetResource, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* lpBuffer, 
                              uint* lpBufferSize, PWSTR* lplpSystem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("davclnt.dll")
uint NPFormatNetworkName(PWSTR lpRemoteName, PWSTR lpFormattedName, uint* lpnLength, 
                         NETWORK_NAME_FORMAT_FLAGS dwFlags, uint dwAveCharPerLine);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("MPR.dll")
void WNetSetLastErrorA(uint err, PSTR lpError, PSTR lpProviders);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("MPR.dll")
void WNetSetLastErrorW(uint err, PWSTR lpError, PWSTR lpProviders);


