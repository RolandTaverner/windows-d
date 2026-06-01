// Written in the D programming language.

module windows.win32.gaming;

public import windows.core;
public import windows.win32.foundation.foundation : BOOL, BSTR, HRESULT, PWSTR;
public import windows.win32.system.com.com : IUnknown;
public import windows.win32.system.winrt.winrt : HSTRING, IInspectable;

extern(Windows) @nogc nothrow:


// Enums


alias GAME_INSTALL_SCOPE = int;
enum : int
{
    GIS_NOT_INSTALLED = 0x00000001,
    GIS_CURRENT_USER  = 0x00000002,
    GIS_ALL_USERS     = 0x00000003,
}

alias GAMESTATS_OPEN_TYPE = int;
enum : int
{
    GAMESTATS_OPEN_OPENORCREATE = 0x00000000,
    GAMESTATS_OPEN_OPENONLY     = 0x00000001,
}

alias GAMESTATS_OPEN_RESULT = int;
enum : int
{
    GAMESTATS_OPEN_CREATED = 0x00000000,
    GAMESTATS_OPEN_OPENED  = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gamingdeviceinformation/ne-gamingdeviceinformation-gaming_device_vendor_id
alias GAMING_DEVICE_VENDOR_ID = int;
enum : int
{
    GAMING_DEVICE_VENDOR_ID_NONE      = 0x00000000,
    GAMING_DEVICE_VENDOR_ID_MICROSOFT = 0xc2ec5032,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gamingdeviceinformation/ne-gamingdeviceinformation-gaming_device_device_id
alias GAMING_DEVICE_DEVICE_ID = int;
enum : int
{
    GAMING_DEVICE_DEVICE_ID_NONE                 = 0x00000000,
    GAMING_DEVICE_DEVICE_ID_XBOX_ONE             = 0x768bae26,
    GAMING_DEVICE_DEVICE_ID_XBOX_ONE_S           = 0x2a7361d9,
    GAMING_DEVICE_DEVICE_ID_XBOX_ONE_X           = 0x5ad617c7,
    GAMING_DEVICE_DEVICE_ID_XBOX_ONE_X_DEVKIT    = 0x10f7cde3,
    GAMING_DEVICE_DEVICE_ID_XBOX_SERIES_S        = 0x1d27fabb,
    GAMING_DEVICE_DEVICE_ID_XBOX_SERIES_X        = 0x2f7a3dff,
    GAMING_DEVICE_DEVICE_ID_XBOX_SERIES_X_DEVKIT = 0xde8a5661,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gamingtcui/ne-gamingtcui-knowngamingprivileges
enum KnownGamingPrivileges : int
{
    XPRIVILEGE_BROADCAST                   = 0x000000be,
    XPRIVILEGE_VIEW_FRIENDS_LIST           = 0x000000c5,
    XPRIVILEGE_GAME_DVR                    = 0x000000c6,
    XPRIVILEGE_SHARE_KINECT_CONTENT        = 0x000000c7,
    XPRIVILEGE_MULTIPLAYER_PARTIES         = 0x000000cb,
    XPRIVILEGE_COMMUNICATION_VOICE_INGAME  = 0x000000cd,
    XPRIVILEGE_COMMUNICATION_VOICE_SKYPE   = 0x000000ce,
    XPRIVILEGE_CLOUD_GAMING_MANAGE_SESSION = 0x000000cf,
    XPRIVILEGE_CLOUD_GAMING_JOIN_SESSION   = 0x000000d0,
    XPRIVILEGE_CLOUD_SAVED_GAMES           = 0x000000d1,
    XPRIVILEGE_SHARE_CONTENT               = 0x000000d3,
    XPRIVILEGE_PREMIUM_CONTENT             = 0x000000d6,
    XPRIVILEGE_SUBSCRIPTION_CONTENT        = 0x000000db,
    XPRIVILEGE_SOCIAL_NETWORK_SHARING      = 0x000000dc,
    XPRIVILEGE_PREMIUM_VIDEO               = 0x000000e0,
    XPRIVILEGE_VIDEO_COMMUNICATIONS        = 0x000000eb,
    XPRIVILEGE_PURCHASE_CONTENT            = 0x000000f5,
    XPRIVILEGE_USER_CREATED_CONTENT        = 0x000000f7,
    XPRIVILEGE_PROFILE_VIEWING             = 0x000000f9,
    XPRIVILEGE_COMMUNICATIONS              = 0x000000fc,
    XPRIVILEGE_MULTIPLAYER_SESSIONS        = 0x000000fe,
    XPRIVILEGE_ADD_FRIEND                  = 0x000000ff,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xblidpauthmanager/ne-xblidpauthmanager-xbl_idp_auth_token_status
alias XBL_IDP_AUTH_TOKEN_STATUS = int;
enum : int
{
    XBL_IDP_AUTH_TOKEN_STATUS_SUCCESS                 = 0x00000000,
    XBL_IDP_AUTH_TOKEN_STATUS_OFFLINE_SUCCESS         = 0x00000001,
    XBL_IDP_AUTH_TOKEN_STATUS_NO_ACCOUNT_SET          = 0x00000002,
    XBL_IDP_AUTH_TOKEN_STATUS_LOAD_MSA_ACCOUNT_FAILED = 0x00000003,
    XBL_IDP_AUTH_TOKEN_STATUS_XBOX_VETO               = 0x00000004,
    XBL_IDP_AUTH_TOKEN_STATUS_MSA_INTERRUPT           = 0x00000005,
    XBL_IDP_AUTH_TOKEN_STATUS_OFFLINE_NO_CONSENT      = 0x00000006,
    XBL_IDP_AUTH_TOKEN_STATUS_VIEW_NOT_SET            = 0x00000007,
    XBL_IDP_AUTH_TOKEN_STATUS_UNKNOWN                 = 0xffffffff,
}

// Constants


enum : const(wchar)*
{
    ID_GDF_XML_STR       = "__GDF_XML",
    ID_GDF_THUMBNAIL_STR = "__GDF_THUMBNAIL",
}

// Callbacks

alias GameUICompletionRoutine = void function(HRESULT returnCode, void* context);
alias PlayerPickerUICompletionRoutine = void function(HRESULT returnCode, void* context, 
                                                      const(HSTRING)* selectedXuids, size_t selectedXuidsCount);

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gamingdeviceinformation/ns-gamingdeviceinformation-gaming_device_model_information
struct GAMING_DEVICE_MODEL_INFORMATION
{
    GAMING_DEVICE_VENDOR_ID vendorId;
    GAMING_DEVICE_DEVICE_ID deviceId;
}

// Functions

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/expandedresources/nf-expandedresources-hasexpandedresources
@DllImport("api-ms-win-gaming-expandedresources-l1-1-0.dll")
HRESULT HasExpandedResources(BOOL* hasExpandedResources);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/expandedresources/nf-expandedresources-getexpandedresourceexclusivecpucount
@DllImport("api-ms-win-gaming-expandedresources-l1-1-0.dll")
HRESULT GetExpandedResourceExclusiveCpuCount(uint* exclusiveCpuCount);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/expandedresources/nf-expandedresources-releaseexclusivecpusets
@DllImport("api-ms-win-gaming-expandedresources-l1-1-0.dll")
HRESULT ReleaseExclusiveCpuSets();

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gamingdeviceinformation/nf-gamingdeviceinformation-getgamingdevicemodelinformation
@DllImport("api-ms-win-gaming-deviceinformation-l1-1-0.dll")
HRESULT GetGamingDeviceModelInformation(GAMING_DEVICE_MODEL_INFORMATION* information);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gamingtcui/nf-gamingtcui-showgameinviteui
@DllImport("api-ms-win-gaming-tcui-l1-1-0.dll")
HRESULT ShowGameInviteUI(HSTRING serviceConfigurationId, HSTRING sessionTemplateName, HSTRING sessionId, 
                         HSTRING invitationDisplayText, GameUICompletionRoutine completionRoutine, void* context);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gamingtcui/nf-gamingtcui-showplayerpickerui
@DllImport("api-ms-win-gaming-tcui-l1-1-0.dll")
HRESULT ShowPlayerPickerUI(HSTRING promptDisplayText, const(HSTRING)* xuids, size_t xuidsCount, 
                           const(HSTRING)* preSelectedXuids, size_t preSelectedXuidsCount, size_t minSelectionCount, 
                           size_t maxSelectionCount, PlayerPickerUICompletionRoutine completionRoutine, 
                           void* context);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gamingtcui/nf-gamingtcui-showprofilecardui
@DllImport("api-ms-win-gaming-tcui-l1-1-0.dll")
HRESULT ShowProfileCardUI(HSTRING targetUserXuid, GameUICompletionRoutine completionRoutine, void* context);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gamingtcui/nf-gamingtcui-showchangefriendrelationshipui
@DllImport("api-ms-win-gaming-tcui-l1-1-0.dll")
HRESULT ShowChangeFriendRelationshipUI(HSTRING targetUserXuid, GameUICompletionRoutine completionRoutine, 
                                       void* context);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gamingtcui/nf-gamingtcui-showtitleachievementsui
@DllImport("api-ms-win-gaming-tcui-l1-1-0.dll")
HRESULT ShowTitleAchievementsUI(uint titleId, GameUICompletionRoutine completionRoutine, void* context);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gamingtcui/nf-gamingtcui-processpendinggameui
@DllImport("api-ms-win-gaming-tcui-l1-1-0.dll")
HRESULT ProcessPendingGameUI(BOOL waitForCompletion);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gamingtcui/nf-gamingtcui-trycancelpendinggameui
@DllImport("api-ms-win-gaming-tcui-l1-1-0.dll")
BOOL TryCancelPendingGameUI();

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/gamingtcui/nf-gamingtcui-checkgamingprivilegewithui
@DllImport("api-ms-win-gaming-tcui-l1-1-1.dll")
HRESULT CheckGamingPrivilegeWithUI(uint privilegeId, HSTRING scope_, HSTRING policy, HSTRING friendlyMessage, 
                                   GameUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-1.dll")
HRESULT CheckGamingPrivilegeSilently(uint privilegeId, HSTRING scope_, HSTRING policy, BOOL* hasPrivilege);

@DllImport("api-ms-win-gaming-tcui-l1-1-2.dll")
HRESULT ShowGameInviteUIForUser(IInspectable user, HSTRING serviceConfigurationId, HSTRING sessionTemplateName, 
                                HSTRING sessionId, HSTRING invitationDisplayText, 
                                GameUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-2.dll")
HRESULT ShowPlayerPickerUIForUser(IInspectable user, HSTRING promptDisplayText, const(HSTRING)* xuids, 
                                  size_t xuidsCount, const(HSTRING)* preSelectedXuids, size_t preSelectedXuidsCount, 
                                  size_t minSelectionCount, size_t maxSelectionCount, 
                                  PlayerPickerUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-2.dll")
HRESULT ShowProfileCardUIForUser(IInspectable user, HSTRING targetUserXuid, 
                                 GameUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-2.dll")
HRESULT ShowChangeFriendRelationshipUIForUser(IInspectable user, HSTRING targetUserXuid, 
                                              GameUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-2.dll")
HRESULT ShowTitleAchievementsUIForUser(IInspectable user, uint titleId, GameUICompletionRoutine completionRoutine, 
                                       void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-2.dll")
HRESULT CheckGamingPrivilegeWithUIForUser(IInspectable user, uint privilegeId, HSTRING scope_, HSTRING policy, 
                                          HSTRING friendlyMessage, GameUICompletionRoutine completionRoutine, 
                                          void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-2.dll")
HRESULT CheckGamingPrivilegeSilentlyForUser(IInspectable user, uint privilegeId, HSTRING scope_, HSTRING policy, 
                                            BOOL* hasPrivilege);

@DllImport("api-ms-win-gaming-tcui-l1-1-3.dll")
HRESULT ShowGameInviteUIWithContext(HSTRING serviceConfigurationId, HSTRING sessionTemplateName, HSTRING sessionId, 
                                    HSTRING invitationDisplayText, HSTRING customActivationContext, 
                                    GameUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-3.dll")
HRESULT ShowGameInviteUIWithContextForUser(IInspectable user, HSTRING serviceConfigurationId, 
                                           HSTRING sessionTemplateName, HSTRING sessionId, 
                                           HSTRING invitationDisplayText, HSTRING customActivationContext, 
                                           GameUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-4.dll")
HRESULT ShowGameInfoUI(uint titleId, GameUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-4.dll")
HRESULT ShowGameInfoUIForUser(IInspectable user, uint titleId, GameUICompletionRoutine completionRoutine, 
                              void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-4.dll")
HRESULT ShowFindFriendsUI(GameUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-4.dll")
HRESULT ShowFindFriendsUIForUser(IInspectable user, GameUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-4.dll")
HRESULT ShowCustomizeUserProfileUI(GameUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-4.dll")
HRESULT ShowCustomizeUserProfileUIForUser(IInspectable user, GameUICompletionRoutine completionRoutine, 
                                          void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-4.dll")
HRESULT ShowUserSettingsUI(GameUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-4.dll")
HRESULT ShowUserSettingsUIForUser(IInspectable user, GameUICompletionRoutine completionRoutine, void* context);


// Interfaces

@GUID("9a5ea990-3034-4d6f-9128-01f3c61022bc")
struct GameExplorer;

@GUID("dbc85a2c-c0dc-4961-b6e2-d28b62c11ad4")
struct GameStatistics;

@GUID("ce23534b-56d8-4978-86a2-7ee570640468")
struct XblIdpAuthManager;

@GUID("9f493441-744a-410c-ae2b-9a22f7c7731f")
struct XblIdpAuthTokenResult;

@GUID("e7b2fb72-d728-49b3-a5f2-18ebf5f1349e")
interface IGameExplorer : IUnknown
{
    HRESULT AddGame(BSTR bstrGDFBinaryPath, BSTR bstrGameInstallDirectory, GAME_INSTALL_SCOPE installScope, 
                    GUID* pguidInstanceID);
    HRESULT RemoveGame(GUID guidInstanceID);
    HRESULT UpdateGame(GUID guidInstanceID);
    HRESULT VerifyAccess(BSTR bstrGDFBinaryPath, BOOL* pfHasAccess);
}

@GUID("3887c9ca-04a0-42ae-bc4c-5fa6c7721145")
interface IGameStatistics : IUnknown
{
    HRESULT GetMaxCategoryLength(uint* cch);
    HRESULT GetMaxNameLength(uint* cch);
    HRESULT GetMaxValueLength(uint* cch);
    HRESULT GetMaxCategories(ushort* pMax);
    HRESULT GetMaxStatsPerCategory(ushort* pMax);
    HRESULT SetCategoryTitle(ushort categoryIndex, const(PWSTR) title);
    HRESULT GetCategoryTitle(ushort categoryIndex, PWSTR* pTitle);
    HRESULT GetStatistic(ushort categoryIndex, ushort statIndex, PWSTR* pName, PWSTR* pValue);
    HRESULT SetStatistic(ushort categoryIndex, ushort statIndex, const(PWSTR) name, const(PWSTR) value);
    HRESULT Save(BOOL trackChanges);
    HRESULT SetLastPlayedCategory(uint categoryIndex);
    HRESULT GetLastPlayedCategory(uint* pCategoryIndex);
}

@GUID("aff3ea11-e70e-407d-95dd-35e612c41ce2")
interface IGameStatisticsMgr : IUnknown
{
    HRESULT GetGameStatistics(const(PWSTR) GDFBinaryPath, GAMESTATS_OPEN_TYPE openType, 
                              GAMESTATS_OPEN_RESULT* pOpenResult, IGameStatistics* ppiStats);
    HRESULT RemoveGameStatistics(const(PWSTR) GDFBinaryPath);
}

@GUID("86874aa7-a1ed-450d-a7eb-b89e20b2fff3")
interface IGameExplorer2 : IUnknown
{
    HRESULT InstallGame(const(PWSTR) binaryGDFPath, const(PWSTR) installDirectory, GAME_INSTALL_SCOPE installScope);
    HRESULT UninstallGame(const(PWSTR) binaryGDFPath);
    HRESULT CheckAccess(const(PWSTR) binaryGDFPath, BOOL* pHasAccess);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xblidpauthmanager/nn-xblidpauthmanager-ixblidpauthmanager
@GUID("eb5ddb08-8bbf-449b-ac21-b02ddeb3b136")
interface IXblIdpAuthManager : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xblidpauthmanager/nf-xblidpauthmanager-ixblidpauthmanager-setgameraccount
    HRESULT SetGamerAccount(const(PWSTR) msaAccountId, const(PWSTR) xuid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xblidpauthmanager/nf-xblidpauthmanager-ixblidpauthmanager-getgameraccount
    HRESULT GetGamerAccount(PWSTR* msaAccountId, PWSTR* xuid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xblidpauthmanager/nf-xblidpauthmanager-ixblidpauthmanager-setappviewinitialized
    HRESULT SetAppViewInitialized(const(PWSTR) appSid, const(PWSTR) msaAccountId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xblidpauthmanager/nf-xblidpauthmanager-ixblidpauthmanager-getenvironment
    HRESULT GetEnvironment(PWSTR* environment);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xblidpauthmanager/nf-xblidpauthmanager-ixblidpauthmanager-getsandbox
    HRESULT GetSandbox(PWSTR* sandbox);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xblidpauthmanager/nf-xblidpauthmanager-ixblidpauthmanager-gettokenandsignaturewithtokenresult
    HRESULT GetTokenAndSignatureWithTokenResult(const(PWSTR) msaAccountId, const(PWSTR) appSid, 
                                                const(PWSTR) msaTarget, const(PWSTR) msaPolicy, 
                                                const(PWSTR) httpMethod, const(PWSTR) uri, const(PWSTR) headers, 
                                                ubyte* body_, uint bodySize, BOOL forceRefresh, 
                                                IXblIdpAuthTokenResult* result);
}

@GUID("bf8c0950-8389-43dd-9a76-a19728ec5dc5")
interface IXblIdpAuthManager2 : IUnknown
{
    HRESULT GetUserlessTokenAndSignatureWithTokenResult(const(PWSTR) appSid, const(PWSTR) msaTarget, 
                                                        const(PWSTR) msaPolicy, const(PWSTR) httpMethod, 
                                                        const(PWSTR) uri, const(PWSTR) headers, ubyte* body_, 
                                                        uint bodySize, BOOL forceRefresh, 
                                                        IXblIdpAuthTokenResult* result);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xblidpauthmanager/nn-xblidpauthmanager-ixblidpauthtokenresult
@GUID("46ce0225-f267-4d68-b299-b2762552dec1")
interface IXblIdpAuthTokenResult : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xblidpauthmanager/nf-xblidpauthmanager-ixblidpauthtokenresult-getstatus
    HRESULT GetStatus(XBL_IDP_AUTH_TOKEN_STATUS* status);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xblidpauthmanager/nf-xblidpauthmanager-ixblidpauthtokenresult-geterrorcode
    HRESULT GetErrorCode(HRESULT* errorCode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xblidpauthmanager/nf-xblidpauthmanager-ixblidpauthtokenresult-gettoken
    HRESULT GetToken(PWSTR* token);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xblidpauthmanager/nf-xblidpauthmanager-ixblidpauthtokenresult-getsignature
    HRESULT GetSignature(PWSTR* signature);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xblidpauthmanager/nf-xblidpauthmanager-ixblidpauthtokenresult-getsandbox
    HRESULT GetSandbox(PWSTR* sandbox);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xblidpauthmanager/nf-xblidpauthmanager-ixblidpauthtokenresult-getenvironment
    HRESULT GetEnvironment(PWSTR* environment);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xblidpauthmanager/nf-xblidpauthmanager-ixblidpauthtokenresult-getmsaaccountid
    HRESULT GetMsaAccountId(PWSTR* msaAccountId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xblidpauthmanager/nf-xblidpauthmanager-ixblidpauthtokenresult-getxuid
    HRESULT GetXuid(PWSTR* xuid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xblidpauthmanager/nf-xblidpauthmanager-ixblidpauthtokenresult-getgamertag
    HRESULT GetGamertag(PWSTR* gamertag);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xblidpauthmanager/nf-xblidpauthmanager-ixblidpauthtokenresult-getagegroup
    HRESULT GetAgeGroup(PWSTR* ageGroup);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xblidpauthmanager/nf-xblidpauthmanager-ixblidpauthtokenresult-getprivileges
    HRESULT GetPrivileges(PWSTR* privileges);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xblidpauthmanager/nf-xblidpauthmanager-ixblidpauthtokenresult-getmsatarget
    HRESULT GetMsaTarget(PWSTR* msaTarget);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xblidpauthmanager/nf-xblidpauthmanager-ixblidpauthtokenresult-getmsapolicy
    HRESULT GetMsaPolicy(PWSTR* msaPolicy);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xblidpauthmanager/nf-xblidpauthmanager-ixblidpauthtokenresult-getmsaappid
    HRESULT GetMsaAppId(PWSTR* msaAppId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xblidpauthmanager/nf-xblidpauthmanager-ixblidpauthtokenresult-getredirect
    HRESULT GetRedirect(PWSTR* redirect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xblidpauthmanager/nf-xblidpauthmanager-ixblidpauthtokenresult-getmessage
    HRESULT GetMessage(PWSTR* message);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xblidpauthmanager/nf-xblidpauthmanager-ixblidpauthtokenresult-gethelpid
    HRESULT GetHelpId(PWSTR* helpId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xblidpauthmanager/nf-xblidpauthmanager-ixblidpauthtokenresult-getenforcementbans
    HRESULT GetEnforcementBans(PWSTR* enforcementBans);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xblidpauthmanager/nf-xblidpauthmanager-ixblidpauthtokenresult-getrestrictions
    HRESULT GetRestrictions(PWSTR* restrictions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xblidpauthmanager/nf-xblidpauthmanager-ixblidpauthtokenresult-gettitlerestrictions
    HRESULT GetTitleRestrictions(PWSTR* titleRestrictions);
}

@GUID("75d760b0-60b9-412d-994f-26b2cd5f7812")
interface IXblIdpAuthTokenResult2 : IUnknown
{
    HRESULT GetModernGamertag(PWSTR* value);
    HRESULT GetModernGamertagSuffix(PWSTR* value);
    HRESULT GetUniqueModernGamertag(PWSTR* value);
}


// GUIDs

const GUID CLSID_GameExplorer          = GUIDOF!GameExplorer;
const GUID CLSID_GameStatistics        = GUIDOF!GameStatistics;
const GUID CLSID_XblIdpAuthManager     = GUIDOF!XblIdpAuthManager;
const GUID CLSID_XblIdpAuthTokenResult = GUIDOF!XblIdpAuthTokenResult;

const GUID IID_IGameExplorer           = GUIDOF!IGameExplorer;
const GUID IID_IGameExplorer2          = GUIDOF!IGameExplorer2;
const GUID IID_IGameStatistics         = GUIDOF!IGameStatistics;
const GUID IID_IGameStatisticsMgr      = GUIDOF!IGameStatisticsMgr;
const GUID IID_IXblIdpAuthManager      = GUIDOF!IXblIdpAuthManager;
const GUID IID_IXblIdpAuthManager2     = GUIDOF!IXblIdpAuthManager2;
const GUID IID_IXblIdpAuthTokenResult  = GUIDOF!IXblIdpAuthTokenResult;
const GUID IID_IXblIdpAuthTokenResult2 = GUIDOF!IXblIdpAuthTokenResult2;
