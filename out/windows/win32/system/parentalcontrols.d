// Written in the D programming language.

module windows.win32.system.parentalcontrols;

public import windows.core;
public import windows.win32.foundation : BOOL, BSTR, HRESULT, HWND, PWSTR, SYSTEMTIME;
public import windows.win32.system.com : IUnknown;

extern(Windows) @nogc nothrow:


// Enums


alias WPCFLAG_OVERRIDE = int;
enum : int
{
    WPCFLAG_APPLICATION = 0x00000001,
}

alias WPCFLAG_RESTRICTION = int;
enum : int
{
    WPCFLAG_NO_RESTRICTION            = 0x00000000,
    WPCFLAG_LOGGING_REQUIRED          = 0x00000001,
    WPCFLAG_WEB_FILTERED              = 0x00000002,
    WPCFLAG_HOURS_RESTRICTED          = 0x00000004,
    WPCFLAG_GAMES_BLOCKED             = 0x00000008,
    WPCFLAG_APPS_RESTRICTED           = 0x00000010,
    WPCFLAG_TIME_ALLOWANCE_RESTRICTED = 0x00000020,
    WPCFLAG_GAMES_RESTRICTED          = 0x00000040,
}

alias WPCFLAG_WEB_SETTING = int;
enum : int
{
    WPCFLAG_WEB_SETTING_NOTBLOCKED       = 0x00000000,
    WPCFLAG_WEB_SETTING_DOWNLOADSBLOCKED = 0x00000001,
}

alias WPCFLAG_VISIBILITY = int;
enum : int
{
    WPCFLAG_WPC_VISIBLE = 0x00000000,
    WPCFLAG_WPC_HIDDEN  = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wpcevent/ne-wpcevent-wpcflag_isblocked
alias WPCFLAG_ISBLOCKED = int;
enum : int
{
    WPCFLAG_ISBLOCKED_NOTBLOCKED            = 0x00000000,
    WPCFLAG_ISBLOCKED_IMBLOCKED             = 0x00000001,
    WPCFLAG_ISBLOCKED_EMAILBLOCKED          = 0x00000002,
    WPCFLAG_ISBLOCKED_MEDIAPLAYBACKBLOCKED  = 0x00000004,
    WPCFLAG_ISBLOCKED_WEBBLOCKED            = 0x00000008,
    WPCFLAG_ISBLOCKED_GAMESBLOCKED          = 0x00000010,
    WPCFLAG_ISBLOCKED_CONTACTBLOCKED        = 0x00000020,
    WPCFLAG_ISBLOCKED_FEATUREBLOCKED        = 0x00000040,
    WPCFLAG_ISBLOCKED_DOWNLOADBLOCKED       = 0x00000080,
    WPCFLAG_ISBLOCKED_RATINGBLOCKED         = 0x00000100,
    WPCFLAG_ISBLOCKED_DESCRIPTORBLOCKED     = 0x00000200,
    WPCFLAG_ISBLOCKED_EXPLICITBLOCK         = 0x00000400,
    WPCFLAG_ISBLOCKED_BADPASS               = 0x00000800,
    WPCFLAG_ISBLOCKED_MAXHOURS              = 0x00001000,
    WPCFLAG_ISBLOCKED_SPECHOURS             = 0x00002000,
    WPCFLAG_ISBLOCKED_SETTINGSCHANGEBLOCKED = 0x00004000,
    WPCFLAG_ISBLOCKED_ATTACHMENTBLOCKED     = 0x00008000,
    WPCFLAG_ISBLOCKED_SENDERBLOCKED         = 0x00010000,
    WPCFLAG_ISBLOCKED_RECEIVERBLOCKED       = 0x00020000,
    WPCFLAG_ISBLOCKED_NOTEXPLICITLYALLOWED  = 0x00040000,
    WPCFLAG_ISBLOCKED_NOTINLIST             = 0x00080000,
    WPCFLAG_ISBLOCKED_CATEGORYBLOCKED       = 0x00100000,
    WPCFLAG_ISBLOCKED_CATEGORYNOTINLIST     = 0x00200000,
    WPCFLAG_ISBLOCKED_NOTKIDS               = 0x00400000,
    WPCFLAG_ISBLOCKED_UNRATED               = 0x00800000,
    WPCFLAG_ISBLOCKED_NOACCESS              = 0x01000000,
    WPCFLAG_ISBLOCKED_INTERNALERROR         = 0xffffffff,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wpcevent/ne-wpcevent-wpcflag_logoff_type
alias WPCFLAG_LOGOFF_TYPE = int;
enum : int
{
    WPCFLAG_LOGOFF_TYPE_LOGOUT    = 0x00000000,
    WPCFLAG_LOGOFF_TYPE_RESTART   = 0x00000001,
    WPCFLAG_LOGOFF_TYPE_SHUTDOWN  = 0x00000002,
    WPCFLAG_LOGOFF_TYPE_FUS       = 0x00000004,
    WPCFLAG_LOGOFF_TYPE_FORCEDFUS = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wpcevent/ne-wpcevent-wpcflag_im_leave
alias WPCFLAG_IM_LEAVE = int;
enum : int
{
    WPCFLAG_IM_LEAVE_NORMAL           = 0x00000000,
    WPCFLAG_IM_LEAVE_FORCED           = 0x00000001,
    WPCFLAG_IM_LEAVE_CONVERSATION_END = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wpcevent/ne-wpcevent-wpc_args_settingschangeevent
alias WPC_ARGS_SETTINGSCHANGEEVENT = int;
enum : int
{
    WPC_ARGS_SETTINGSCHANGEEVENT_CLASS    = 0x00000000,
    WPC_ARGS_SETTINGSCHANGEEVENT_SETTING  = 0x00000001,
    WPC_ARGS_SETTINGSCHANGEEVENT_OWNER    = 0x00000002,
    WPC_ARGS_SETTINGSCHANGEEVENT_OLDVAL   = 0x00000003,
    WPC_ARGS_SETTINGSCHANGEEVENT_NEWVAL   = 0x00000004,
    WPC_ARGS_SETTINGSCHANGEEVENT_REASON   = 0x00000005,
    WPC_ARGS_SETTINGSCHANGEEVENT_OPTIONAL = 0x00000006,
    WPC_ARGS_SETTINGSCHANGEEVENT_CARGS    = 0x00000007,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wpcevent/ne-wpcevent-wpc_args_saferappblocked
alias WPC_ARGS_SAFERAPPBLOCKED = int;
enum : int
{
    WPC_ARGS_SAFERAPPBLOCKED_TIMESTAMP = 0x00000000,
    WPC_ARGS_SAFERAPPBLOCKED_USERID    = 0x00000001,
    WPC_ARGS_SAFERAPPBLOCKED_PATH      = 0x00000002,
    WPC_ARGS_SAFERAPPBLOCKED_RULEID    = 0x00000003,
    WPC_ARGS_SAFERAPPBLOCKED_CARGS     = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wpcevent/ne-wpcevent-wpc_args_emailreceievedevent
alias WPC_ARGS_EMAILRECEIEVEDEVENT = int;
enum : int
{
    WPC_ARGS_EMAILRECEIEVEDEVENT_SENDER         = 0x00000000,
    WPC_ARGS_EMAILRECEIEVEDEVENT_APPNAME        = 0x00000001,
    WPC_ARGS_EMAILRECEIEVEDEVENT_APPVERSION     = 0x00000002,
    WPC_ARGS_EMAILRECEIEVEDEVENT_SUBJECT        = 0x00000003,
    WPC_ARGS_EMAILRECEIEVEDEVENT_REASON         = 0x00000004,
    WPC_ARGS_EMAILRECEIEVEDEVENT_RECIPCOUNT     = 0x00000005,
    WPC_ARGS_EMAILRECEIEVEDEVENT_RECIPIENT      = 0x00000006,
    WPC_ARGS_EMAILRECEIEVEDEVENT_ATTACHCOUNT    = 0x00000007,
    WPC_ARGS_EMAILRECEIEVEDEVENT_ATTACHMENTNAME = 0x00000008,
    WPC_ARGS_EMAILRECEIEVEDEVENT_RECEIVEDTIME   = 0x00000009,
    WPC_ARGS_EMAILRECEIEVEDEVENT_EMAILACCOUNT   = 0x0000000a,
    WPC_ARGS_EMAILRECEIEVEDEVENT_CARGS          = 0x0000000b,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wpcevent/ne-wpcevent-wpc_args_emailsentevent
alias WPC_ARGS_EMAILSENTEVENT = int;
enum : int
{
    WPC_ARGS_EMAILSENTEVENT_SENDER         = 0x00000000,
    WPC_ARGS_EMAILSENTEVENT_APPNAME        = 0x00000001,
    WPC_ARGS_EMAILSENTEVENT_APPVERSION     = 0x00000002,
    WPC_ARGS_EMAILSENTEVENT_SUBJECT        = 0x00000003,
    WPC_ARGS_EMAILSENTEVENT_REASON         = 0x00000004,
    WPC_ARGS_EMAILSENTEVENT_RECIPCOUNT     = 0x00000005,
    WPC_ARGS_EMAILSENTEVENT_RECIPIENT      = 0x00000006,
    WPC_ARGS_EMAILSENTEVENT_ATTACHCOUNT    = 0x00000007,
    WPC_ARGS_EMAILSENTEVENT_ATTACHMENTNAME = 0x00000008,
    WPC_ARGS_EMAILSENTEVENT_EMAILACCOUNT   = 0x00000009,
    WPC_ARGS_EMAILSENTEVENT_CARGS          = 0x0000000a,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wpcevent/ne-wpcevent-wpc_args_emailcontactevent
alias WPC_ARGS_EMAILCONTACTEVENT = int;
enum : int
{
    WPC_ARGS_EMAILCONTACTEVENT_APPNAME      = 0x00000000,
    WPC_ARGS_EMAILCONTACTEVENT_APPVERSION   = 0x00000001,
    WPC_ARGS_EMAILCONTACTEVENT_OLDNAME      = 0x00000002,
    WPC_ARGS_EMAILCONTACTEVENT_OLDID        = 0x00000003,
    WPC_ARGS_EMAILCONTACTEVENT_NEWNAME      = 0x00000004,
    WPC_ARGS_EMAILCONTACTEVENT_NEWID        = 0x00000005,
    WPC_ARGS_EMAILCONTACTEVENT_REASON       = 0x00000006,
    WPC_ARGS_EMAILCONTACTEVENT_EMAILACCOUNT = 0x00000007,
    WPC_ARGS_EMAILCONTACTEVENT_CARGS        = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wpcevent/ne-wpcevent-wpc_media_type
alias WPC_MEDIA_TYPE = int;
enum : int
{
    WPC_MEDIA_TYPE_OTHER        = 0x00000000,
    WPC_MEDIA_TYPE_DVD          = 0x00000001,
    WPC_MEDIA_TYPE_RECORDED_TV  = 0x00000002,
    WPC_MEDIA_TYPE_AUDIO_FILE   = 0x00000003,
    WPC_MEDIA_TYPE_CD_AUDIO     = 0x00000004,
    WPC_MEDIA_TYPE_VIDEO_FILE   = 0x00000005,
    WPC_MEDIA_TYPE_PICTURE_FILE = 0x00000006,
    WPC_MEDIA_TYPE_MAX          = 0x00000007,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wpcevent/ne-wpcevent-wpc_media_explicit
alias WPC_MEDIA_EXPLICIT = int;
enum : int
{
    WPC_MEDIA_EXPLICIT_FALSE   = 0x00000000,
    WPC_MEDIA_EXPLICIT_TRUE    = 0x00000001,
    WPC_MEDIA_EXPLICIT_UNKNOWN = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wpcevent/ne-wpcevent-wpc_args_mediaplaybackevent
alias WPC_ARGS_MEDIAPLAYBACKEVENT = int;
enum : int
{
    WPC_ARGS_MEDIAPLAYBACKEVENT_APPNAME    = 0x00000000,
    WPC_ARGS_MEDIAPLAYBACKEVENT_APPVERSION = 0x00000001,
    WPC_ARGS_MEDIAPLAYBACKEVENT_MEDIATYPE  = 0x00000002,
    WPC_ARGS_MEDIAPLAYBACKEVENT_PATH       = 0x00000003,
    WPC_ARGS_MEDIAPLAYBACKEVENT_TITLE      = 0x00000004,
    WPC_ARGS_MEDIAPLAYBACKEVENT_PML        = 0x00000005,
    WPC_ARGS_MEDIAPLAYBACKEVENT_ALBUM      = 0x00000006,
    WPC_ARGS_MEDIAPLAYBACKEVENT_EXPLICIT   = 0x00000007,
    WPC_ARGS_MEDIAPLAYBACKEVENT_REASON     = 0x00000008,
    WPC_ARGS_MEDIAPLAYBACKEVENT_CARGS      = 0x00000009,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wpcevent/ne-wpcevent-wpc_args_mediadownloadevent
alias WPC_ARGS_MEDIADOWNLOADEVENT = int;
enum : int
{
    WPC_ARGS_MEDIADOWNLOADEVENT_APPNAME    = 0x00000000,
    WPC_ARGS_MEDIADOWNLOADEVENT_APPVERSION = 0x00000001,
    WPC_ARGS_MEDIADOWNLOADEVENT_MEDIATYPE  = 0x00000002,
    WPC_ARGS_MEDIADOWNLOADEVENT_PATH       = 0x00000003,
    WPC_ARGS_MEDIADOWNLOADEVENT_TITLE      = 0x00000004,
    WPC_ARGS_MEDIADOWNLOADEVENT_PML        = 0x00000005,
    WPC_ARGS_MEDIADOWNLOADEVENT_ALBUM      = 0x00000006,
    WPC_ARGS_MEDIADOWNLOADEVENT_EXPLICIT   = 0x00000007,
    WPC_ARGS_MEDIADOWNLOADEVENT_REASON     = 0x00000008,
    WPC_ARGS_MEDIADOWNLOADEVENT_CARGS      = 0x00000009,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wpcevent/ne-wpcevent-wpc_args_conversationinitevent
alias WPC_ARGS_CONVERSATIONINITEVENT = int;
enum : int
{
    WPC_ARGS_CONVERSATIONINITEVENT_APPNAME      = 0x00000000,
    WPC_ARGS_CONVERSATIONINITEVENT_APPVERSION   = 0x00000001,
    WPC_ARGS_CONVERSATIONINITEVENT_ACCOUNTNAME  = 0x00000002,
    WPC_ARGS_CONVERSATIONINITEVENT_CONVID       = 0x00000003,
    WPC_ARGS_CONVERSATIONINITEVENT_REQUESTINGIP = 0x00000004,
    WPC_ARGS_CONVERSATIONINITEVENT_SENDER       = 0x00000005,
    WPC_ARGS_CONVERSATIONINITEVENT_REASON       = 0x00000006,
    WPC_ARGS_CONVERSATIONINITEVENT_RECIPCOUNT   = 0x00000007,
    WPC_ARGS_CONVERSATIONINITEVENT_RECIPIENT    = 0x00000008,
    WPC_ARGS_CONVERSATIONINITEVENT_CARGS        = 0x00000009,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wpcevent/ne-wpcevent-wpc_args_conversationjoinevent
alias WPC_ARGS_CONVERSATIONJOINEVENT = int;
enum : int
{
    WPC_ARGS_CONVERSATIONJOINEVENT_APPNAME     = 0x00000000,
    WPC_ARGS_CONVERSATIONJOINEVENT_APPVERSION  = 0x00000001,
    WPC_ARGS_CONVERSATIONJOINEVENT_ACCOUNTNAME = 0x00000002,
    WPC_ARGS_CONVERSATIONJOINEVENT_CONVID      = 0x00000003,
    WPC_ARGS_CONVERSATIONJOINEVENT_JOININGIP   = 0x00000004,
    WPC_ARGS_CONVERSATIONJOINEVENT_JOININGUSER = 0x00000005,
    WPC_ARGS_CONVERSATIONJOINEVENT_REASON      = 0x00000006,
    WPC_ARGS_CONVERSATIONJOINEVENT_MEMBERCOUNT = 0x00000007,
    WPC_ARGS_CONVERSATIONJOINEVENT_MEMBER      = 0x00000008,
    WPC_ARGS_CONVERSATIONJOINEVENT_SENDER      = 0x00000009,
    WPC_ARGS_CONVERSATIONJOINEVENT_CARGS       = 0x0000000a,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wpcevent/ne-wpcevent-wpc_args_conversationleaveevent
alias WPC_ARGS_CONVERSATIONLEAVEEVENT = int;
enum : int
{
    WPC_ARGS_CONVERSATIONLEAVEEVENT_APPNAME     = 0x00000000,
    WPC_ARGS_CONVERSATIONLEAVEEVENT_APPVERSION  = 0x00000001,
    WPC_ARGS_CONVERSATIONLEAVEEVENT_ACCOUNTNAME = 0x00000002,
    WPC_ARGS_CONVERSATIONLEAVEEVENT_CONVID      = 0x00000003,
    WPC_ARGS_CONVERSATIONLEAVEEVENT_LEAVINGIP   = 0x00000004,
    WPC_ARGS_CONVERSATIONLEAVEEVENT_LEAVINGUSER = 0x00000005,
    WPC_ARGS_CONVERSATIONLEAVEEVENT_REASON      = 0x00000006,
    WPC_ARGS_CONVERSATIONLEAVEEVENT_MEMBERCOUNT = 0x00000007,
    WPC_ARGS_CONVERSATIONLEAVEEVENT_MEMBER      = 0x00000008,
    WPC_ARGS_CONVERSATIONLEAVEEVENT_FLAGS       = 0x00000009,
    WPC_ARGS_CONVERSATIONLEAVEEVENT_CARGS       = 0x0000000a,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wpcevent/ne-wpcevent-wpcflag_im_feature
alias WPCFLAG_IM_FEATURE = int;
enum : int
{
    WPCFLAG_IM_FEATURE_NONE     = 0x00000000,
    WPCFLAG_IM_FEATURE_VIDEO    = 0x00000001,
    WPCFLAG_IM_FEATURE_AUDIO    = 0x00000002,
    WPCFLAG_IM_FEATURE_GAME     = 0x00000004,
    WPCFLAG_IM_FEATURE_SMS      = 0x00000008,
    WPCFLAG_IM_FEATURE_FILESWAP = 0x00000010,
    WPCFLAG_IM_FEATURE_URLSWAP  = 0x00000020,
    WPCFLAG_IM_FEATURE_SENDING  = 0x80000000,
    WPCFLAG_IM_FEATURE_ALL      = 0xffffffff,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wpcevent/ne-wpcevent-wpc_args_imfeatureevent
alias WPC_ARGS_IMFEATUREEVENT = int;
enum : int
{
    WPC_ARGS_IMFEATUREEVENT_APPNAME     = 0x00000000,
    WPC_ARGS_IMFEATUREEVENT_APPVERSION  = 0x00000001,
    WPC_ARGS_IMFEATUREEVENT_ACCOUNTNAME = 0x00000002,
    WPC_ARGS_IMFEATUREEVENT_CONVID      = 0x00000003,
    WPC_ARGS_IMFEATUREEVENT_MEDIATYPE   = 0x00000004,
    WPC_ARGS_IMFEATUREEVENT_REASON      = 0x00000005,
    WPC_ARGS_IMFEATUREEVENT_RECIPCOUNT  = 0x00000006,
    WPC_ARGS_IMFEATUREEVENT_RECIPIENT   = 0x00000007,
    WPC_ARGS_IMFEATUREEVENT_SENDER      = 0x00000008,
    WPC_ARGS_IMFEATUREEVENT_SENDERIP    = 0x00000009,
    WPC_ARGS_IMFEATUREEVENT_DATA        = 0x0000000a,
    WPC_ARGS_IMFEATUREEVENT_CARGS       = 0x0000000b,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wpcevent/ne-wpcevent-wpc_args_imcontactevent
alias WPC_ARGS_IMCONTACTEVENT = int;
enum : int
{
    WPC_ARGS_IMCONTACTEVENT_APPNAME     = 0x00000000,
    WPC_ARGS_IMCONTACTEVENT_APPVERSION  = 0x00000001,
    WPC_ARGS_IMCONTACTEVENT_ACCOUNTNAME = 0x00000002,
    WPC_ARGS_IMCONTACTEVENT_OLDNAME     = 0x00000003,
    WPC_ARGS_IMCONTACTEVENT_OLDID       = 0x00000004,
    WPC_ARGS_IMCONTACTEVENT_NEWNAME     = 0x00000005,
    WPC_ARGS_IMCONTACTEVENT_NEWID       = 0x00000006,
    WPC_ARGS_IMCONTACTEVENT_REASON      = 0x00000007,
    WPC_ARGS_IMCONTACTEVENT_CARGS       = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wpcevent/ne-wpcevent-wpc_args_gamestartevent
alias WPC_ARGS_GAMESTARTEVENT = int;
enum : int
{
    WPC_ARGS_GAMESTARTEVENT_APPID        = 0x00000000,
    WPC_ARGS_GAMESTARTEVENT_INSTANCEID   = 0x00000001,
    WPC_ARGS_GAMESTARTEVENT_APPVERSION   = 0x00000002,
    WPC_ARGS_GAMESTARTEVENT_PATH         = 0x00000003,
    WPC_ARGS_GAMESTARTEVENT_RATING       = 0x00000004,
    WPC_ARGS_GAMESTARTEVENT_RATINGSYSTEM = 0x00000005,
    WPC_ARGS_GAMESTARTEVENT_REASON       = 0x00000006,
    WPC_ARGS_GAMESTARTEVENT_DESCCOUNT    = 0x00000007,
    WPC_ARGS_GAMESTARTEVENT_DESCRIPTOR   = 0x00000008,
    WPC_ARGS_GAMESTARTEVENT_PID          = 0x00000009,
    WPC_ARGS_GAMESTARTEVENT_CARGS        = 0x0000000a,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wpcevent/ne-wpcevent-wpc_args_filedownloadevent
alias WPC_ARGS_FILEDOWNLOADEVENT = int;
enum : int
{
    WPC_ARGS_FILEDOWNLOADEVENT_URL     = 0x00000000,
    WPC_ARGS_FILEDOWNLOADEVENT_APPNAME = 0x00000001,
    WPC_ARGS_FILEDOWNLOADEVENT_VERSION = 0x00000002,
    WPC_ARGS_FILEDOWNLOADEVENT_BLOCKED = 0x00000003,
    WPC_ARGS_FILEDOWNLOADEVENT_PATH    = 0x00000004,
    WPC_ARGS_FILEDOWNLOADEVENT_CARGS   = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wpcevent/ne-wpcevent-wpc_args_urlvisitevent
alias WPC_ARGS_URLVISITEVENT = int;
enum : int
{
    WPC_ARGS_URLVISITEVENT_URL            = 0x00000000,
    WPC_ARGS_URLVISITEVENT_APPNAME        = 0x00000001,
    WPC_ARGS_URLVISITEVENT_VERSION        = 0x00000002,
    WPC_ARGS_URLVISITEVENT_REASON         = 0x00000003,
    WPC_ARGS_URLVISITEVENT_RATINGSYSTEMID = 0x00000004,
    WPC_ARGS_URLVISITEVENT_CATCOUNT       = 0x00000005,
    WPC_ARGS_URLVISITEVENT_CATEGORY       = 0x00000006,
    WPC_ARGS_URLVISITEVENT_CARGS          = 0x00000007,
}

alias WPC_ARGS_WEBSITEVISITEVENT = int;
enum : int
{
    WPC_ARGS_WEBSITEVISITEVENT_URL                   = 0x00000000,
    WPC_ARGS_WEBSITEVISITEVENT_DECISION              = 0x00000001,
    WPC_ARGS_WEBSITEVISITEVENT_CATEGORIES            = 0x00000002,
    WPC_ARGS_WEBSITEVISITEVENT_BLOCKEDCATEGORIES     = 0x00000003,
    WPC_ARGS_WEBSITEVISITEVENT_SERIALIZEDAPPLICATION = 0x00000004,
    WPC_ARGS_WEBSITEVISITEVENT_TITLE                 = 0x00000005,
    WPC_ARGS_WEBSITEVISITEVENT_CONTENTTYPE           = 0x00000006,
    WPC_ARGS_WEBSITEVISITEVENT_REFERRER              = 0x00000007,
    WPC_ARGS_WEBSITEVISITEVENT_TELEMETRY             = 0x00000008,
    WPC_ARGS_WEBSITEVISITEVENT_CARGS                 = 0x00000009,
}

alias WPC_ARGS_APPLICATIONEVENT = int;
enum : int
{
    WPC_ARGS_APPLICATIONEVENT_SERIALIZEDAPPLICATION = 0x00000000,
    WPC_ARGS_APPLICATIONEVENT_DECISION              = 0x00000001,
    WPC_ARGS_APPLICATIONEVENT_PROCESSID             = 0x00000002,
    WPC_ARGS_APPLICATIONEVENT_CREATIONTIME          = 0x00000003,
    WPC_ARGS_APPLICATIONEVENT_TIMEUSED              = 0x00000004,
    WPC_ARGS_APPLICATIONEVENT_CARGS                 = 0x00000005,
}

alias WPC_ARGS_COMPUTERUSAGEEVENT = int;
enum : int
{
    WPC_ARGS_COMPUTERUSAGEEVENT_ID       = 0x00000000,
    WPC_ARGS_COMPUTERUSAGEEVENT_TIMEUSED = 0x00000001,
    WPC_ARGS_COMPUTERUSAGEEVENT_CARGS    = 0x00000002,
}

alias WPC_ARGS_CONTENTUSAGEEVENT = int;
enum : int
{
    WPC_ARGS_CONTENTUSAGEEVENT_CONTENTPROVIDERID    = 0x00000000,
    WPC_ARGS_CONTENTUSAGEEVENT_CONTENTPROVIDERTITLE = 0x00000001,
    WPC_ARGS_CONTENTUSAGEEVENT_ID                   = 0x00000002,
    WPC_ARGS_CONTENTUSAGEEVENT_TITLE                = 0x00000003,
    WPC_ARGS_CONTENTUSAGEEVENT_CATEGORY             = 0x00000004,
    WPC_ARGS_CONTENTUSAGEEVENT_RATINGS              = 0x00000005,
    WPC_ARGS_CONTENTUSAGEEVENT_DECISION             = 0x00000006,
    WPC_ARGS_CONTENTUSAGEEVENT_CARGS                = 0x00000007,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wpcevent/ne-wpcevent-wpc_args_customevent
alias WPC_ARGS_CUSTOMEVENT = int;
enum : int
{
    WPC_ARGS_CUSTOMEVENT_PUBLISHER  = 0x00000000,
    WPC_ARGS_CUSTOMEVENT_APPNAME    = 0x00000001,
    WPC_ARGS_CUSTOMEVENT_APPVERSION = 0x00000002,
    WPC_ARGS_CUSTOMEVENT_EVENT      = 0x00000003,
    WPC_ARGS_CUSTOMEVENT_VALUE1     = 0x00000004,
    WPC_ARGS_CUSTOMEVENT_VALUE2     = 0x00000005,
    WPC_ARGS_CUSTOMEVENT_VALUE3     = 0x00000006,
    WPC_ARGS_CUSTOMEVENT_BLOCKED    = 0x00000007,
    WPC_ARGS_CUSTOMEVENT_REASON     = 0x00000008,
    WPC_ARGS_CUSTOMEVENT_CARGS      = 0x00000009,
}

alias WPC_ARGS_WEBOVERRIDEEVENT = int;
enum : int
{
    WPC_ARGS_WEBOVERRIDEEVENT_USERID = 0x00000000,
    WPC_ARGS_WEBOVERRIDEEVENT_URL    = 0x00000001,
    WPC_ARGS_WEBOVERRIDEEVENT_REASON = 0x00000002,
    WPC_ARGS_WEBOVERRIDEEVENT_CARGS  = 0x00000003,
}

alias WPC_ARGS_APPOVERRIDEEVENT = int;
enum : int
{
    WPC_ARGS_APPOVERRIDEEVENT_USERID = 0x00000000,
    WPC_ARGS_APPOVERRIDEEVENT_PATH   = 0x00000001,
    WPC_ARGS_APPOVERRIDEEVENT_REASON = 0x00000002,
    WPC_ARGS_APPOVERRIDEEVENT_CARGS  = 0x00000003,
}

alias WPC_SETTINGS = int;
enum : int
{
    WPC_SETTINGS_WPC_EXTENSION_PATH                = 0x00000000,
    WPC_SETTINGS_WPC_EXTENSION_SILO                = 0x00000001,
    WPC_SETTINGS_WPC_EXTENSION_IMAGE_PATH          = 0x00000002,
    WPC_SETTINGS_WPC_EXTENSION_DISABLEDIMAGE_PATH  = 0x00000003,
    WPC_SETTINGS_WPC_EXTENSION_NAME                = 0x00000004,
    WPC_SETTINGS_WPC_EXTENSION_SUB_TITLE           = 0x00000005,
    WPC_SETTINGS_SYSTEM_CURRENT_RATING_SYSTEM      = 0x00000006,
    WPC_SETTINGS_SYSTEM_LAST_LOG_VIEW              = 0x00000007,
    WPC_SETTINGS_SYSTEM_LOG_VIEW_REMINDER_INTERVAL = 0x00000008,
    WPC_SETTINGS_SYSTEM_HTTP_EXEMPTION_LIST        = 0x00000009,
    WPC_SETTINGS_SYSTEM_URL_EXEMPTION_LIST         = 0x0000000a,
    WPC_SETTINGS_SYSTEM_FILTER_ID                  = 0x0000000b,
    WPC_SETTINGS_SYSTEM_FILTER_NAME                = 0x0000000c,
    WPC_SETTINGS_SYSTEM_LOCALE                     = 0x0000000d,
    WPC_SETTINGS_ALLOW_BLOCK                       = 0x0000000e,
    WPC_SETTINGS_GAME_BLOCKED                      = 0x0000000f,
    WPC_SETTINGS_GAME_ALLOW_UNRATED                = 0x00000010,
    WPC_SETTINGS_GAME_MAX_ALLOWED                  = 0x00000011,
    WPC_SETTINGS_GAME_DENIED_DESCRIPTORS           = 0x00000012,
    WPC_SETTINGS_USER_WPC_ENABLED                  = 0x00000013,
    WPC_SETTINGS_USER_LOGGING_REQUIRED             = 0x00000014,
    WPC_SETTINGS_USER_HOURLY_RESTRICTIONS          = 0x00000015,
    WPC_SETTINGS_USER_OVERRRIDE_REQUESTS           = 0x00000016,
    WPC_SETTINGS_USER_LOGON_HOURS                  = 0x00000017,
    WPC_SETTINGS_USER_APP_RESTRICTIONS             = 0x00000018,
    WPC_SETTINGS_WEB_FILTER_ON                     = 0x00000019,
    WPC_SETTINGS_WEB_DOWNLOAD_BLOCKED              = 0x0000001a,
    WPC_SETTINGS_WEB_FILTER_LEVEL                  = 0x0000001b,
    WPC_SETTINGS_WEB_BLOCKED_CATEGORY_LIST         = 0x0000001c,
    WPC_SETTINGS_WEB_BLOCK_UNRATED                 = 0x0000001d,
    WPC_SETTINGS_WPC_ENABLED                       = 0x0000001e,
    WPC_SETTINGS_WPC_LOGGING_REQUIRED              = 0x0000001f,
    WPC_SETTINGS_RATING_SYSTEM_PATH                = 0x00000020,
    WPC_SETTINGS_WPC_PROVIDER_CURRENT              = 0x00000021,
    WPC_SETTINGS_USER_TIME_ALLOWANCE               = 0x00000022,
    WPC_SETTINGS_USER_TIME_ALLOWANCE_RESTRICTIONS  = 0x00000023,
    WPC_SETTINGS_GAME_RESTRICTED                   = 0x00000024,
    WPC_SETTING_COUNT                              = 0x00000025,
}

// Constants


enum uint ARRAY_SEP_CHAR = 0x00000009U;
enum uint WPCCHANNEL = 0x00000010U;

enum : uint
{
    WPC_SETTINGS_LOCATE = 0x00000014U,
    WPC_SETTINGS_MODIFY = 0x00000015U,
}

enum uint WPC_APP_LAUNCH = 0x00000016U;
enum uint WPC_SYSTEM = 0x00000017U;

enum : uint
{
    WPC_WEB                    = 0x00000018U,
    WPCPROV_TASK_SettingChange = 0x00000001U,
    WPCPROV_TASK_GameStart     = 0x00000002U,
    WPCPROV_TASK_UrlVisit      = 0x00000003U,
    WPCPROV_TASK_EmailReceived = 0x00000004U,
    WPCPROV_TASK_EmailSent     = 0x00000005U,
    WPCPROV_TASK_MediaPlayback = 0x00000006U,
    WPCPROV_TASK_IMInvitation  = 0x00000007U,
    WPCPROV_TASK_IMJoin        = 0x00000008U,
    WPCPROV_TASK_IMLeave       = 0x00000009U,
    WPCPROV_TASK_FileDownload  = 0x0000000aU,
    WPCPROV_TASK_IMFeature     = 0x0000000bU,
    WPCPROV_TASK_Custom        = 0x0000000dU,
    WPCPROV_TASK_EmailContact  = 0x0000000eU,
    WPCPROV_TASK_IMContact     = 0x0000000fU,
    WPCPROV_TASK_AppBlocked    = 0x00000010U,
    WPCPROV_TASK_AppOverride   = 0x00000011U,
    WPCPROV_TASK_WebOverride   = 0x00000012U,
    WPCPROV_TASK_WebsiteVisit  = 0x00000013U,
    WPCPROV_TASK_Application   = 0x00000014U,
    WPCPROV_TASK_ComputerUsage = 0x00000015U,
    WPCPROV_TASK_ContentUsage  = 0x00000016U,
}

enum : uint
{
    WPCPROV_KEYWORD_WPC        = 0x00000010U,
    WPCPROV_KEYWORD_ThirdParty = 0x00000020U,
}

enum uint WPCEVENT_SYS_SETTINGCHANGE_value = 0x00000001U;
enum uint WPCEVENT_GAME_START_value = 0x00000002U;
enum uint WPCEVENT_WEB_URLVISIT_value = 0x00000003U;

enum : uint
{
    WPCEVENT_EMAIL_RECEIVED_value = 0x00000004U,
    WPCEVENT_EMAIL_SENT_value     = 0x00000005U,
}

enum uint WPCEVENT_MEDIA_PLAYBACK_value = 0x00000006U;

enum : uint
{
    WPCEVENT_IM_INVITATION_value = 0x00000007U,
    WPCEVENT_IM_JOIN_value       = 0x00000008U,
    WPCEVENT_IM_LEAVE_value      = 0x00000009U,
}

enum uint WPCEVENT_WEB_FILEDOWNLOAD_value = 0x0000000aU;
enum uint WPCEVENT_IM_FEATURE_value = 0x0000000bU;

enum : uint
{
    WPCEVENT_CUSTOM_value        = 0x0000000dU,
    WPCEVENT_EMAIL_CONTACT_value = 0x0000000eU,
}

enum uint WPCEVENT_IM_CONTACT_value = 0x0000000fU;
enum uint WPCEVENT_SYSTEM_APPBLOCKED_value = 0x00000010U;
enum uint WPCEVENT_APPOVERRIDE_value = 0x00000011U;

enum : uint
{
    WPCEVENT_WEBOVERRIDE_value      = 0x00000012U,
    WPCEVENT_WEB_WEBSITEVISIT_value = 0x00000013U,
}

enum uint WPCEVENT_APPLICATION_value = 0x00000014U;
enum uint WPCEVENT_COMPUTERUSAGE_value = 0x00000015U;
enum uint WPCEVENT_CONTENTUSAGE_value = 0x00000016U;

enum : int
{
    MSG_Keyword_WPC        = 0x10000005,
    MSG_Keyword_ThirdParty = 0x10000006,
}

enum : int
{
    MSG_Opcode_Locate = 0x30000014,
    MSG_Opcode_Modify = 0x30000015,
    MSG_Opcode_Launch = 0x30000016,
    MSG_Opcode_System = 0x30000017,
    MSG_Opcode_Web    = 0x30000018,
}

enum : int
{
    MSG_Task_SettingChange = 0x70000001,
    MSG_Task_GameStart     = 0x70000002,
    MSG_Task_UrlVisit      = 0x70000003,
    MSG_Task_EmailReceived = 0x70000004,
    MSG_Task_EmailSent     = 0x70000005,
    MSG_Task_MediaPlayback = 0x70000006,
    MSG_Task_IMInvitation  = 0x70000007,
    MSG_Task_IMJoin        = 0x70000008,
    MSG_Task_IMLeave       = 0x70000009,
    MSG_Task_FileDownload  = 0x7000000a,
    MSG_Task_IMFeature     = 0x7000000b,
    MSG_Task_Custom        = 0x7000000d,
    MSG_Task_EmailContact  = 0x7000000e,
    MSG_Task_IMContact     = 0x7000000f,
    MSG_Task_AppBlocked    = 0x70000010,
    MSG_Task_AppOverride   = 0x70000011,
    MSG_Task_WebOverride   = 0x70000012,
    MSG_Task_WebsiteVisit  = 0x70000013,
    MSG_Task_Application   = 0x70000014,
    MSG_Task_ComputerUsage = 0x70000015,
    MSG_Task_ContentUsage  = 0x70000016,
}

enum int MSG_Publisher_Name = 0x90000001;

enum : int
{
    MSG_Event_SettingChange = 0xb0000001,
    MSG_Event_GameStart     = 0xb0000002,
    MSG_Event_UrlVisit      = 0xb0000003,
    MSG_Event_EmailReceived = 0xb0000004,
    MSG_Event_EmailSent     = 0xb0000005,
    MSG_Event_MediaPlayback = 0xb0000006,
    MSG_Event_IMInvitation  = 0xb0000007,
    MSG_Event_IMJoin        = 0xb0000008,
    MSG_Event_IMLeave       = 0xb0000009,
    MSG_Event_FileDownload  = 0xb000000a,
    MSG_Event_IMFeature     = 0xb000000b,
    MSG_Event_Custom        = 0xb000000d,
    MSG_Event_EmailContact  = 0xb000000e,
    MSG_Event_IMContact     = 0xb000000f,
    MSG_Event_AppBlocked    = 0xb0000010,
    MSG_Event_AppOverride   = 0xb0000011,
    MSG_Event_WebOverride   = 0xb0000012,
    MSG_Event_WebsiteVisit  = 0xb0000013,
    MSG_Event_Application   = 0xb0000014,
    MSG_Event_ComputerUsage = 0xb0000015,
    MSG_Event_ContentUsage  = 0xb0000016,
}

enum uint FACILITY_WPC = 0x00000999U;
enum GUID WPCPROV = GUID("01090065-b467-4503-9b28-533766761087");

// Interfaces

@GUID("355dffaa-3b9f-435c-b428-5d44290bc5f2")
struct WpcSettingsProvider;

@GUID("bb18c7a0-2186-4be0-97d8-04847b628e02")
struct WpcProviderSupport;

@GUID("e77cc89b-7401-4c04-8ced-149db35add04")
struct WindowsParentalControls;

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wpcapi/nn-wpcapi-iwpcproviderstate
@GUID("50b6a267-c4bd-450b-adb5-759073837c9e")
interface IWPCProviderState : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wpcapi/nf-wpcapi-iwpcproviderstate-enable
    HRESULT Enable();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wpcapi/nf-wpcapi-iwpcproviderstate-disable
    HRESULT Disable();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wpcapi/nn-wpcapi-iwpcproviderconfig
@GUID("bef54196-2d02-4a26-b6e5-d65af295d0f1")
interface IWPCProviderConfig : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wpcapi/nf-wpcapi-iwpcproviderconfig-getusersummary
    HRESULT GetUserSummary(BSTR bstrSID, BSTR* pbstrUserSummary);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wpcapi/nf-wpcapi-iwpcproviderconfig-configure
    HRESULT Configure(HWND hWnd, BSTR bstrSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wpcapi/nf-wpcapi-iwpcproviderconfig-requestoverride
    HRESULT RequestOverride(HWND hWnd, BSTR bstrPath, 
                            /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(WPCFLAG_RESTRICTION))], [])*/uint dwFlags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wpcapi/nn-wpcapi-iwpcsettings
@GUID("8fdf6ca1-0189-47e4-b670-1a8a4636e340")
interface IWPCSettings : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wpcapi/nf-wpcapi-iwpcsettings-isloggingrequired
    HRESULT IsLoggingRequired(BOOL* pfRequired);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wpcapi/nf-wpcapi-iwpcsettings-getlastsettingschangetime
    HRESULT GetLastSettingsChangeTime(SYSTEMTIME* pTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wpcapi/nf-wpcapi-iwpcsettings-getrestrictions
    HRESULT GetRestrictions(WPCFLAG_RESTRICTION* pdwRestrictions);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wpcapi/nn-wpcapi-iwpcgamessettings
@GUID("95e87780-e158-489e-b452-bbb850790715")
interface IWPCGamesSettings : IWPCSettings
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wpcapi/nf-wpcapi-iwpcgamessettings-isblocked
    HRESULT IsBlocked(GUID guidAppID, uint* pdwReasons);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wpcapi/nn-wpcapi-iwpcwebsettings
@GUID("ffccbdb8-0992-4c30-b0f1-1cbb09c240aa")
interface IWPCWebSettings : IWPCSettings
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wpcapi/nf-wpcapi-iwpcwebsettings-getsettings
    HRESULT GetSettings(WPCFLAG_WEB_SETTING* pdwSettings);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wpcapi/nf-wpcapi-iwpcwebsettings-requesturloverride
    HRESULT RequestURLOverride(HWND hWnd, const(PWSTR) pcszURL, uint cURLs, const(PWSTR)* ppcszSubURLs, 
                               BOOL* pfChanged);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wpcapi/nn-wpcapi-iwindowsparentalcontrolscore
@GUID("4ff40a0f-3f3b-4d7c-a41b-4f39d7b44d05")
interface IWindowsParentalControlsCore : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wpcapi/nf-wpcapi-iwindowsparentalcontrolscore-getvisibility
    HRESULT GetVisibility(WPCFLAG_VISIBILITY* peVisibility);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wpcapi/nf-wpcapi-iwindowsparentalcontrolscore-getusersettings
    HRESULT GetUserSettings(const(PWSTR) pcszSID, IWPCSettings* ppSettings);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wpcapi/nf-wpcapi-iwindowsparentalcontrolscore-getwebsettings
    HRESULT GetWebSettings(const(PWSTR) pcszSID, IWPCWebSettings* ppSettings);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wpcapi/nf-wpcapi-iwindowsparentalcontrolscore-getwebfilterinfo
    HRESULT GetWebFilterInfo(GUID* pguidID, PWSTR* ppszName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wpcapi/nn-wpcapi-iwindowsparentalcontrols
@GUID("28b4d88b-e072-49e6-804d-26edbe21a7b9")
interface IWindowsParentalControls : IWindowsParentalControlsCore
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wpcapi/nf-wpcapi-iwindowsparentalcontrols-getgamessettings
    HRESULT GetGamesSettings(const(PWSTR) pcszSID, IWPCGamesSettings* ppSettings);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wpcapi/nn-wpcapi-iwpcprovidersupport
@GUID("41eba572-23ed-4779-bec1-8df96206c44c")
interface IWPCProviderSupport : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wpcapi/nf-wpcapi-iwpcprovidersupport-getcurrent
    HRESULT GetCurrent(GUID* pguidProvider);
}


// GUIDs

const GUID CLSID_WindowsParentalControls = GUIDOF!WindowsParentalControls;
const GUID CLSID_WpcProviderSupport      = GUIDOF!WpcProviderSupport;
const GUID CLSID_WpcSettingsProvider     = GUIDOF!WpcSettingsProvider;

const GUID IID_IWPCGamesSettings            = GUIDOF!IWPCGamesSettings;
const GUID IID_IWPCProviderConfig           = GUIDOF!IWPCProviderConfig;
const GUID IID_IWPCProviderState            = GUIDOF!IWPCProviderState;
const GUID IID_IWPCProviderSupport          = GUIDOF!IWPCProviderSupport;
const GUID IID_IWPCSettings                 = GUIDOF!IWPCSettings;
const GUID IID_IWPCWebSettings              = GUIDOF!IWPCWebSettings;
const GUID IID_IWindowsParentalControls     = GUIDOF!IWindowsParentalControls;
const GUID IID_IWindowsParentalControlsCore = GUIDOF!IWindowsParentalControlsCore;
