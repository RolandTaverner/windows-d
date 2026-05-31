// Written in the D programming language.

module windows.win32.devices.tapi;

public import windows.core;
public import system : Guid;
public import windows.win32.foundation : BOOL, BSTR, CHAR, HANDLE, HINSTANCE, HRESULT,
                                         HWND, PSTR, PWSTR, SYSTEMTIME, VARIANT_BOOL,
                                         WPARAM;
public import windows.win32.media.directshow : ALLOCATOR_PROPERTIES;
public import windows.win32.media.mediafoundation : AM_MEDIA_TYPE;
public import windows.win32.system.addressbook : IAddrBook, IMAPITable, IMessage, SPropTagArray,
                                                 SPropValue;
public import windows.win32.system.com : CY, IDispatch, IEnumUnknown, IStream,
                                         IUnknown;
public import windows.win32.system.variant : VARIANT;
public import windows.win32.ui.windowsandmessaging : HICON;

extern(Windows) @nogc nothrow:


// Enums

//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-tapi_tonemode))], [])
alias TAPI_TONEMODE = int;
enum : int
{
    TTM_RINGBACK = 0x00000002,
    TTM_BUSY     = 0x00000004,
    TTM_BEEP     = 0x00000008,
    TTM_BILLING  = 0x00000010,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-tapi_gatherterm))], [])
alias TAPI_GATHERTERM = int;
enum : int
{
    TGT_BUFFERFULL   = 0x00000001,
    TGT_TERMDIGIT    = 0x00000002,
    TGT_FIRSTTIMEOUT = 0x00000004,
    TGT_INTERTIMEOUT = 0x00000008,
    TGT_CANCEL       = 0x00000010,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-address_event))], [])
alias ADDRESS_EVENT = int;
enum : int
{
    AE_STATE          = 0x00000000,
    AE_CAPSCHANGE     = 0x00000001,
    AE_RINGING        = 0x00000002,
    AE_CONFIGCHANGE   = 0x00000003,
    AE_FORWARD        = 0x00000004,
    AE_NEWTERMINAL    = 0x00000005,
    AE_REMOVETERMINAL = 0x00000006,
    AE_MSGWAITON      = 0x00000007,
    AE_MSGWAITOFF     = 0x00000008,
    AE_LASTITEM       = 0x00000008,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-address_state))], [])
alias ADDRESS_STATE = int;
enum : int
{
    AS_INSERVICE    = 0x00000000,
    AS_OUTOFSERVICE = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-call_state))], [])
alias CALL_STATE = int;
enum : int
{
    CS_IDLE         = 0x00000000,
    CS_INPROGRESS   = 0x00000001,
    CS_CONNECTED    = 0x00000002,
    CS_DISCONNECTED = 0x00000003,
    CS_OFFERING     = 0x00000004,
    CS_HOLD         = 0x00000005,
    CS_QUEUED       = 0x00000006,
    CS_LASTITEM     = 0x00000006,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-call_state_event_cause))], [])
alias CALL_STATE_EVENT_CAUSE = int;
enum : int
{
    CEC_NONE                  = 0x00000000,
    CEC_DISCONNECT_NORMAL     = 0x00000001,
    CEC_DISCONNECT_BUSY       = 0x00000002,
    CEC_DISCONNECT_BADADDRESS = 0x00000003,
    CEC_DISCONNECT_NOANSWER   = 0x00000004,
    CEC_DISCONNECT_CANCELLED  = 0x00000005,
    CEC_DISCONNECT_REJECTED   = 0x00000006,
    CEC_DISCONNECT_FAILED     = 0x00000007,
    CEC_DISCONNECT_BLOCKED    = 0x00000008,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-call_media_event))], [])
alias CALL_MEDIA_EVENT = int;
enum : int
{
    CME_NEW_STREAM      = 0x00000000,
    CME_STREAM_FAIL     = 0x00000001,
    CME_TERMINAL_FAIL   = 0x00000002,
    CME_STREAM_NOT_USED = 0x00000003,
    CME_STREAM_ACTIVE   = 0x00000004,
    CME_STREAM_INACTIVE = 0x00000005,
    CME_LASTITEM        = 0x00000005,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-call_media_event_cause))], [])
alias CALL_MEDIA_EVENT_CAUSE = int;
enum : int
{
    CMC_UNKNOWN            = 0x00000000,
    CMC_BAD_DEVICE         = 0x00000001,
    CMC_CONNECT_FAIL       = 0x00000002,
    CMC_LOCAL_REQUEST      = 0x00000003,
    CMC_REMOTE_REQUEST     = 0x00000004,
    CMC_MEDIA_TIMEOUT      = 0x00000005,
    CMC_MEDIA_RECOVERED    = 0x00000006,
    CMC_QUALITY_OF_SERVICE = 0x00000007,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-disconnect_code))], [])
alias DISCONNECT_CODE = int;
enum : int
{
    DC_NORMAL   = 0x00000000,
    DC_NOANSWER = 0x00000001,
    DC_REJECTED = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-terminal_state))], [])
alias TERMINAL_STATE = int;
enum : int
{
    TS_INUSE    = 0x00000000,
    TS_NOTINUSE = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-terminal_direction))], [])
alias TERMINAL_DIRECTION = int;
enum : int
{
    TD_CAPTURE          = 0x00000000,
    TD_RENDER           = 0x00000001,
    TD_BIDIRECTIONAL    = 0x00000002,
    TD_MULTITRACK_MIXED = 0x00000003,
    TD_NONE             = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-terminal_type))], [])
alias TERMINAL_TYPE = int;
enum : int
{
    TT_STATIC  = 0x00000000,
    TT_DYNAMIC = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-call_privilege))], [])
alias CALL_PRIVILEGE = int;
enum : int
{
    CP_OWNER   = 0x00000000,
    CP_MONITOR = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-tapi_event))], [])
alias TAPI_EVENT = int;
enum : int
{
    TE_TAPIOBJECT         = 0x00000001,
    TE_ADDRESS            = 0x00000002,
    TE_CALLNOTIFICATION   = 0x00000004,
    TE_CALLSTATE          = 0x00000008,
    TE_CALLMEDIA          = 0x00000010,
    TE_CALLHUB            = 0x00000020,
    TE_CALLINFOCHANGE     = 0x00000040,
    TE_PRIVATE            = 0x00000080,
    TE_REQUEST            = 0x00000100,
    TE_AGENT              = 0x00000200,
    TE_AGENTSESSION       = 0x00000400,
    TE_QOSEVENT           = 0x00000800,
    TE_AGENTHANDLER       = 0x00001000,
    TE_ACDGROUP           = 0x00002000,
    TE_QUEUE              = 0x00004000,
    TE_DIGITEVENT         = 0x00008000,
    TE_GENERATEEVENT      = 0x00010000,
    TE_ASRTERMINAL        = 0x00020000,
    TE_TTSTERMINAL        = 0x00040000,
    TE_FILETERMINAL       = 0x00080000,
    TE_TONETERMINAL       = 0x00100000,
    TE_PHONEEVENT         = 0x00200000,
    TE_TONEEVENT          = 0x00400000,
    TE_GATHERDIGITS       = 0x00800000,
    TE_ADDRESSDEVSPECIFIC = 0x01000000,
    TE_PHONEDEVSPECIFIC   = 0x02000000,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-call_notification_event))], [])
alias CALL_NOTIFICATION_EVENT = int;
enum : int
{
    CNE_OWNER    = 0x00000000,
    CNE_MONITOR  = 0x00000001,
    CNE_LASTITEM = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-callhub_event))], [])
alias CALLHUB_EVENT = int;
enum : int
{
    CHE_CALLJOIN    = 0x00000000,
    CHE_CALLLEAVE   = 0x00000001,
    CHE_CALLHUBNEW  = 0x00000002,
    CHE_CALLHUBIDLE = 0x00000003,
    CHE_LASTITEM    = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-callhub_state))], [])
alias CALLHUB_STATE = int;
enum : int
{
    CHS_ACTIVE = 0x00000000,
    CHS_IDLE   = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-tapiobject_event))], [])
alias TAPIOBJECT_EVENT = int;
enum : int
{
    TE_ADDRESSCREATE   = 0x00000000,
    TE_ADDRESSREMOVE   = 0x00000001,
    TE_REINIT          = 0x00000002,
    TE_TRANSLATECHANGE = 0x00000003,
    TE_ADDRESSCLOSE    = 0x00000004,
    TE_PHONECREATE     = 0x00000005,
    TE_PHONEREMOVE     = 0x00000006,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-tapi_object_type))], [])
alias TAPI_OBJECT_TYPE = int;
enum : int
{
    TOT_NONE     = 0x00000000,
    TOT_TAPI     = 0x00000001,
    TOT_ADDRESS  = 0x00000002,
    TOT_TERMINAL = 0x00000003,
    TOT_CALL     = 0x00000004,
    TOT_CALLHUB  = 0x00000005,
    TOT_PHONE    = 0x00000006,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-qos_service_level))], [])
alias QOS_SERVICE_LEVEL = int;
enum : int
{
    QSL_NEEDED       = 0x00000001,
    QSL_IF_AVAILABLE = 0x00000002,
    QSL_BEST_EFFORT  = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-qos_event))], [])
alias QOS_EVENT = int;
enum : int
{
    QE_NOQOS            = 0x00000001,
    QE_ADMISSIONFAILURE = 0x00000002,
    QE_POLICYFAILURE    = 0x00000003,
    QE_GENERICERROR     = 0x00000004,
    QE_LASTITEM         = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-callinfochange_cause))], [])
alias CALLINFOCHANGE_CAUSE = int;
enum : int
{
    CIC_OTHER         = 0x00000000,
    CIC_DEVSPECIFIC   = 0x00000001,
    CIC_BEARERMODE    = 0x00000002,
    CIC_RATE          = 0x00000003,
    CIC_APPSPECIFIC   = 0x00000004,
    CIC_CALLID        = 0x00000005,
    CIC_RELATEDCALLID = 0x00000006,
    CIC_ORIGIN        = 0x00000007,
    CIC_REASON        = 0x00000008,
    CIC_COMPLETIONID  = 0x00000009,
    CIC_NUMOWNERINCR  = 0x0000000a,
    CIC_NUMOWNERDECR  = 0x0000000b,
    CIC_NUMMONITORS   = 0x0000000c,
    CIC_TRUNK         = 0x0000000d,
    CIC_CALLERID      = 0x0000000e,
    CIC_CALLEDID      = 0x0000000f,
    CIC_CONNECTEDID   = 0x00000010,
    CIC_REDIRECTIONID = 0x00000011,
    CIC_REDIRECTINGID = 0x00000012,
    CIC_USERUSERINFO  = 0x00000013,
    CIC_HIGHLEVELCOMP = 0x00000014,
    CIC_LOWLEVELCOMP  = 0x00000015,
    CIC_CHARGINGINFO  = 0x00000016,
    CIC_TREATMENT     = 0x00000017,
    CIC_CALLDATA      = 0x00000018,
    CIC_PRIVILEGE     = 0x00000019,
    CIC_MEDIATYPE     = 0x0000001a,
    CIC_LASTITEM      = 0x0000001a,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-callinfo_long))], [])
alias CALLINFO_LONG = int;
enum : int
{
    CIL_MEDIATYPESAVAILABLE      = 0x00000000,
    CIL_BEARERMODE               = 0x00000001,
    CIL_CALLERIDADDRESSTYPE      = 0x00000002,
    CIL_CALLEDIDADDRESSTYPE      = 0x00000003,
    CIL_CONNECTEDIDADDRESSTYPE   = 0x00000004,
    CIL_REDIRECTIONIDADDRESSTYPE = 0x00000005,
    CIL_REDIRECTINGIDADDRESSTYPE = 0x00000006,
    CIL_ORIGIN                   = 0x00000007,
    CIL_REASON                   = 0x00000008,
    CIL_APPSPECIFIC              = 0x00000009,
    CIL_CALLPARAMSFLAGS          = 0x0000000a,
    CIL_CALLTREATMENT            = 0x0000000b,
    CIL_MINRATE                  = 0x0000000c,
    CIL_MAXRATE                  = 0x0000000d,
    CIL_COUNTRYCODE              = 0x0000000e,
    CIL_CALLID                   = 0x0000000f,
    CIL_RELATEDCALLID            = 0x00000010,
    CIL_COMPLETIONID             = 0x00000011,
    CIL_NUMBEROFOWNERS           = 0x00000012,
    CIL_NUMBEROFMONITORS         = 0x00000013,
    CIL_TRUNK                    = 0x00000014,
    CIL_RATE                     = 0x00000015,
    CIL_GENERATEDIGITDURATION    = 0x00000016,
    CIL_MONITORDIGITMODES        = 0x00000017,
    CIL_MONITORMEDIAMODES        = 0x00000018,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-callinfo_string))], [])
alias CALLINFO_STRING = int;
enum : int
{
    CIS_CALLERIDNAME            = 0x00000000,
    CIS_CALLERIDNUMBER          = 0x00000001,
    CIS_CALLEDIDNAME            = 0x00000002,
    CIS_CALLEDIDNUMBER          = 0x00000003,
    CIS_CONNECTEDIDNAME         = 0x00000004,
    CIS_CONNECTEDIDNUMBER       = 0x00000005,
    CIS_REDIRECTIONIDNAME       = 0x00000006,
    CIS_REDIRECTIONIDNUMBER     = 0x00000007,
    CIS_REDIRECTINGIDNAME       = 0x00000008,
    CIS_REDIRECTINGIDNUMBER     = 0x00000009,
    CIS_CALLEDPARTYFRIENDLYNAME = 0x0000000a,
    CIS_COMMENT                 = 0x0000000b,
    CIS_DISPLAYABLEADDRESS      = 0x0000000c,
    CIS_CALLINGPARTYID          = 0x0000000d,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-callinfo_buffer))], [])
alias CALLINFO_BUFFER = int;
enum : int
{
    CIB_USERUSERINFO                 = 0x00000000,
    CIB_DEVSPECIFICBUFFER            = 0x00000001,
    CIB_CALLDATABUFFER               = 0x00000002,
    CIB_CHARGINGINFOBUFFER           = 0x00000003,
    CIB_HIGHLEVELCOMPATIBILITYBUFFER = 0x00000004,
    CIB_LOWLEVELCOMPATIBILITYBUFFER  = 0x00000005,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-address_capability))], [])
alias ADDRESS_CAPABILITY = int;
enum : int
{
    AC_ADDRESSTYPES                 = 0x00000000,
    AC_BEARERMODES                  = 0x00000001,
    AC_MAXACTIVECALLS               = 0x00000002,
    AC_MAXONHOLDCALLS               = 0x00000003,
    AC_MAXONHOLDPENDINGCALLS        = 0x00000004,
    AC_MAXNUMCONFERENCE             = 0x00000005,
    AC_MAXNUMTRANSCONF              = 0x00000006,
    AC_MONITORDIGITSUPPORT          = 0x00000007,
    AC_GENERATEDIGITSUPPORT         = 0x00000008,
    AC_GENERATETONEMODES            = 0x00000009,
    AC_GENERATETONEMAXNUMFREQ       = 0x0000000a,
    AC_MONITORTONEMAXNUMFREQ        = 0x0000000b,
    AC_MONITORTONEMAXNUMENTRIES     = 0x0000000c,
    AC_DEVCAPFLAGS                  = 0x0000000d,
    AC_ANSWERMODES                  = 0x0000000e,
    AC_LINEFEATURES                 = 0x0000000f,
    AC_SETTABLEDEVSTATUS            = 0x00000010,
    AC_PARKSUPPORT                  = 0x00000011,
    AC_CALLERIDSUPPORT              = 0x00000012,
    AC_CALLEDIDSUPPORT              = 0x00000013,
    AC_CONNECTEDIDSUPPORT           = 0x00000014,
    AC_REDIRECTIONIDSUPPORT         = 0x00000015,
    AC_REDIRECTINGIDSUPPORT         = 0x00000016,
    AC_ADDRESSCAPFLAGS              = 0x00000017,
    AC_CALLFEATURES1                = 0x00000018,
    AC_CALLFEATURES2                = 0x00000019,
    AC_REMOVEFROMCONFCAPS           = 0x0000001a,
    AC_REMOVEFROMCONFSTATE          = 0x0000001b,
    AC_TRANSFERMODES                = 0x0000001c,
    AC_ADDRESSFEATURES              = 0x0000001d,
    AC_PREDICTIVEAUTOTRANSFERSTATES = 0x0000001e,
    AC_MAXCALLDATASIZE              = 0x0000001f,
    AC_LINEID                       = 0x00000020,
    AC_ADDRESSID                    = 0x00000021,
    AC_FORWARDMODES                 = 0x00000022,
    AC_MAXFORWARDENTRIES            = 0x00000023,
    AC_MAXSPECIFICENTRIES           = 0x00000024,
    AC_MINFWDNUMRINGS               = 0x00000025,
    AC_MAXFWDNUMRINGS               = 0x00000026,
    AC_MAXCALLCOMPLETIONS           = 0x00000027,
    AC_CALLCOMPLETIONCONDITIONS     = 0x00000028,
    AC_CALLCOMPLETIONMODES          = 0x00000029,
    AC_PERMANENTDEVICEID            = 0x0000002a,
    AC_GATHERDIGITSMINTIMEOUT       = 0x0000002b,
    AC_GATHERDIGITSMAXTIMEOUT       = 0x0000002c,
    AC_GENERATEDIGITMINDURATION     = 0x0000002d,
    AC_GENERATEDIGITMAXDURATION     = 0x0000002e,
    AC_GENERATEDIGITDEFAULTDURATION = 0x0000002f,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-address_capability_string))], [])
alias ADDRESS_CAPABILITY_STRING = int;
enum : int
{
    ACS_PROTOCOL              = 0x00000000,
    ACS_ADDRESSDEVICESPECIFIC = 0x00000001,
    ACS_LINEDEVICESPECIFIC    = 0x00000002,
    ACS_PROVIDERSPECIFIC      = 0x00000003,
    ACS_SWITCHSPECIFIC        = 0x00000004,
    ACS_PERMANENTDEVICEGUID   = 0x00000005,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-fullduplex_support))], [])
alias FULLDUPLEX_SUPPORT = int;
enum : int
{
    FDS_SUPPORTED    = 0x00000000,
    FDS_NOTSUPPORTED = 0x00000001,
    FDS_UNKNOWN      = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-finish_mode))], [])
alias FINISH_MODE = int;
enum : int
{
    FM_ASTRANSFER   = 0x00000000,
    FM_ASCONFERENCE = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-phone_privilege))], [])
alias PHONE_PRIVILEGE = int;
enum : int
{
    PP_OWNER   = 0x00000000,
    PP_MONITOR = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-phone_hook_switch_device))], [])
alias PHONE_HOOK_SWITCH_DEVICE = int;
enum : int
{
    PHSD_HANDSET      = 0x00000001,
    PHSD_SPEAKERPHONE = 0x00000002,
    PHSD_HEADSET      = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-phone_hook_switch_state))], [])
alias PHONE_HOOK_SWITCH_STATE = int;
enum : int
{
    PHSS_ONHOOK               = 0x00000001,
    PHSS_OFFHOOK_MIC_ONLY     = 0x00000002,
    PHSS_OFFHOOK_SPEAKER_ONLY = 0x00000004,
    PHSS_OFFHOOK              = 0x00000008,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-phone_lamp_mode))], [])
alias PHONE_LAMP_MODE = int;
enum : int
{
    LM_DUMMY         = 0x00000001,
    LM_OFF           = 0x00000002,
    LM_STEADY        = 0x00000004,
    LM_WINK          = 0x00000008,
    LM_FLASH         = 0x00000010,
    LM_FLUTTER       = 0x00000020,
    LM_BROKENFLUTTER = 0x00000040,
    LM_UNKNOWN       = 0x00000080,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-phonecaps_long))], [])
alias PHONECAPS_LONG = int;
enum : int
{
    PCL_HOOKSWITCHES                = 0x00000000,
    PCL_HANDSETHOOKSWITCHMODES      = 0x00000001,
    PCL_HEADSETHOOKSWITCHMODES      = 0x00000002,
    PCL_SPEAKERPHONEHOOKSWITCHMODES = 0x00000003,
    PCL_DISPLAYNUMROWS              = 0x00000004,
    PCL_DISPLAYNUMCOLUMNS           = 0x00000005,
    PCL_NUMRINGMODES                = 0x00000006,
    PCL_NUMBUTTONLAMPS              = 0x00000007,
    PCL_GENERICPHONE                = 0x00000008,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-phonecaps_string))], [])
alias PHONECAPS_STRING = int;
enum : int
{
    PCS_PHONENAME    = 0x00000000,
    PCS_PHONEINFO    = 0x00000001,
    PCS_PROVIDERINFO = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-phonecaps_buffer))], [])
alias PHONECAPS_BUFFER = int;
enum : int
{
    PCB_DEVSPECIFICBUFFER = 0x00000000,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-phone_button_state))], [])
alias PHONE_BUTTON_STATE = int;
enum : int
{
    PBS_UP      = 0x00000001,
    PBS_DOWN    = 0x00000002,
    PBS_UNKNOWN = 0x00000004,
    PBS_UNAVAIL = 0x00000008,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-phone_button_mode))], [])
alias PHONE_BUTTON_MODE = int;
enum : int
{
    PBM_DUMMY   = 0x00000000,
    PBM_CALL    = 0x00000001,
    PBM_FEATURE = 0x00000002,
    PBM_KEYPAD  = 0x00000003,
    PBM_LOCAL   = 0x00000004,
    PBM_DISPLAY = 0x00000005,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-phone_button_function))], [])
alias PHONE_BUTTON_FUNCTION = int;
enum : int
{
    PBF_UNKNOWN      = 0x00000000,
    PBF_CONFERENCE   = 0x00000001,
    PBF_TRANSFER     = 0x00000002,
    PBF_DROP         = 0x00000003,
    PBF_HOLD         = 0x00000004,
    PBF_RECALL       = 0x00000005,
    PBF_DISCONNECT   = 0x00000006,
    PBF_CONNECT      = 0x00000007,
    PBF_MSGWAITON    = 0x00000008,
    PBF_MSGWAITOFF   = 0x00000009,
    PBF_SELECTRING   = 0x0000000a,
    PBF_ABBREVDIAL   = 0x0000000b,
    PBF_FORWARD      = 0x0000000c,
    PBF_PICKUP       = 0x0000000d,
    PBF_RINGAGAIN    = 0x0000000e,
    PBF_PARK         = 0x0000000f,
    PBF_REJECT       = 0x00000010,
    PBF_REDIRECT     = 0x00000011,
    PBF_MUTE         = 0x00000012,
    PBF_VOLUMEUP     = 0x00000013,
    PBF_VOLUMEDOWN   = 0x00000014,
    PBF_SPEAKERON    = 0x00000015,
    PBF_SPEAKEROFF   = 0x00000016,
    PBF_FLASH        = 0x00000017,
    PBF_DATAON       = 0x00000018,
    PBF_DATAOFF      = 0x00000019,
    PBF_DONOTDISTURB = 0x0000001a,
    PBF_INTERCOM     = 0x0000001b,
    PBF_BRIDGEDAPP   = 0x0000001c,
    PBF_BUSY         = 0x0000001d,
    PBF_CALLAPP      = 0x0000001e,
    PBF_DATETIME     = 0x0000001f,
    PBF_DIRECTORY    = 0x00000020,
    PBF_COVER        = 0x00000021,
    PBF_CALLID       = 0x00000022,
    PBF_LASTNUM      = 0x00000023,
    PBF_NIGHTSRV     = 0x00000024,
    PBF_SENDCALLS    = 0x00000025,
    PBF_MSGINDICATOR = 0x00000026,
    PBF_REPDIAL      = 0x00000027,
    PBF_SETREPDIAL   = 0x00000028,
    PBF_SYSTEMSPEED  = 0x00000029,
    PBF_STATIONSPEED = 0x0000002a,
    PBF_CAMPON       = 0x0000002b,
    PBF_SAVEREPEAT   = 0x0000002c,
    PBF_QUEUECALL    = 0x0000002d,
    PBF_NONE         = 0x0000002e,
    PBF_SEND         = 0x0000002f,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-phone_tone))], [])
alias PHONE_TONE = int;
enum : int
{
    PT_KEYPADZERO       = 0x00000000,
    PT_KEYPADONE        = 0x00000001,
    PT_KEYPADTWO        = 0x00000002,
    PT_KEYPADTHREE      = 0x00000003,
    PT_KEYPADFOUR       = 0x00000004,
    PT_KEYPADFIVE       = 0x00000005,
    PT_KEYPADSIX        = 0x00000006,
    PT_KEYPADSEVEN      = 0x00000007,
    PT_KEYPADEIGHT      = 0x00000008,
    PT_KEYPADNINE       = 0x00000009,
    PT_KEYPADSTAR       = 0x0000000a,
    PT_KEYPADPOUND      = 0x0000000b,
    PT_KEYPADA          = 0x0000000c,
    PT_KEYPADB          = 0x0000000d,
    PT_KEYPADC          = 0x0000000e,
    PT_KEYPADD          = 0x0000000f,
    PT_NORMALDIALTONE   = 0x00000010,
    PT_EXTERNALDIALTONE = 0x00000011,
    PT_BUSY             = 0x00000012,
    PT_RINGBACK         = 0x00000013,
    PT_ERRORTONE        = 0x00000014,
    PT_SILENCE          = 0x00000015,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-phone_event))], [])
alias PHONE_EVENT = int;
enum : int
{
    PE_DISPLAY        = 0x00000000,
    PE_LAMPMODE       = 0x00000001,
    PE_RINGMODE       = 0x00000002,
    PE_RINGVOLUME     = 0x00000003,
    PE_HOOKSWITCH     = 0x00000004,
    PE_CAPSCHANGE     = 0x00000005,
    PE_BUTTON         = 0x00000006,
    PE_CLOSE          = 0x00000007,
    PE_NUMBERGATHERED = 0x00000008,
    PE_DIALING        = 0x00000009,
    PE_ANSWER         = 0x0000000a,
    PE_DISCONNECT     = 0x0000000b,
    PE_LASTITEM       = 0x0000000b,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-terminal_media_state))], [])
alias TERMINAL_MEDIA_STATE = int;
enum : int
{
    TMS_IDLE     = 0x00000000,
    TMS_ACTIVE   = 0x00000001,
    TMS_PAUSED   = 0x00000002,
    TMS_LASTITEM = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-ft_state_event_cause))], [])
alias FT_STATE_EVENT_CAUSE = int;
enum : int
{
    FTEC_NORMAL      = 0x00000000,
    FTEC_END_OF_FILE = 0x00000001,
    FTEC_READ_ERROR  = 0x00000002,
    FTEC_WRITE_ERROR = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/ne-tapi3cc-agent_event))], [])
alias AGENT_EVENT = int;
enum : int
{
    AE_NOT_READY     = 0x00000000,
    AE_READY         = 0x00000001,
    AE_BUSY_ACD      = 0x00000002,
    AE_BUSY_INCOMING = 0x00000003,
    AE_BUSY_OUTGOING = 0x00000004,
    AE_UNKNOWN       = 0x00000005,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/ne-tapi3cc-agent_state))], [])
alias AGENT_STATE = int;
enum : int
{
    AS_NOT_READY     = 0x00000000,
    AS_READY         = 0x00000001,
    AS_BUSY_ACD      = 0x00000002,
    AS_BUSY_INCOMING = 0x00000003,
    AS_BUSY_OUTGOING = 0x00000004,
    AS_UNKNOWN       = 0x00000005,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/ne-tapi3cc-agent_session_event))], [])
alias AGENT_SESSION_EVENT = int;
enum : int
{
    ASE_NEW_SESSION = 0x00000000,
    ASE_NOT_READY   = 0x00000001,
    ASE_READY       = 0x00000002,
    ASE_BUSY        = 0x00000003,
    ASE_WRAPUP      = 0x00000004,
    ASE_END         = 0x00000005,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/ne-tapi3cc-agent_session_state))], [])
alias AGENT_SESSION_STATE = int;
enum : int
{
    ASST_NOT_READY     = 0x00000000,
    ASST_READY         = 0x00000001,
    ASST_BUSY_ON_CALL  = 0x00000002,
    ASST_BUSY_WRAPUP   = 0x00000003,
    ASST_SESSION_ENDED = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/ne-tapi3cc-agenthandler_event))], [])
alias AGENTHANDLER_EVENT = int;
enum : int
{
    AHE_NEW_AGENTHANDLER     = 0x00000000,
    AHE_AGENTHANDLER_REMOVED = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/ne-tapi3cc-acdgroup_event))], [])
alias ACDGROUP_EVENT = int;
enum : int
{
    ACDGE_NEW_GROUP     = 0x00000000,
    ACDGE_GROUP_REMOVED = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/ne-tapi3cc-acdqueue_event))], [])
alias ACDQUEUE_EVENT = int;
enum : int
{
    ACDQE_NEW_QUEUE     = 0x00000000,
    ACDQE_QUEUE_REMOVED = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msp/ne-msp-msp_address_event))], [])
alias MSP_ADDRESS_EVENT = int;
enum : int
{
    ADDRESS_TERMINAL_AVAILABLE   = 0x00000000,
    ADDRESS_TERMINAL_UNAVAILABLE = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msp/ne-msp-msp_call_event))], [])
alias MSP_CALL_EVENT = int;
enum : int
{
    CALL_NEW_STREAM      = 0x00000000,
    CALL_STREAM_FAIL     = 0x00000001,
    CALL_TERMINAL_FAIL   = 0x00000002,
    CALL_STREAM_NOT_USED = 0x00000003,
    CALL_STREAM_ACTIVE   = 0x00000004,
    CALL_STREAM_INACTIVE = 0x00000005,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msp/ne-msp-msp_call_event_cause))], [])
alias MSP_CALL_EVENT_CAUSE = int;
enum : int
{
    CALL_CAUSE_UNKNOWN            = 0x00000000,
    CALL_CAUSE_BAD_DEVICE         = 0x00000001,
    CALL_CAUSE_CONNECT_FAIL       = 0x00000002,
    CALL_CAUSE_LOCAL_REQUEST      = 0x00000003,
    CALL_CAUSE_REMOTE_REQUEST     = 0x00000004,
    CALL_CAUSE_MEDIA_TIMEOUT      = 0x00000005,
    CALL_CAUSE_MEDIA_RECOVERED    = 0x00000006,
    CALL_CAUSE_QUALITY_OF_SERVICE = 0x00000007,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msp/ne-msp-msp_event))], [])
alias MSP_EVENT = int;
enum : int
{
    ME_ADDRESS_EVENT       = 0x00000000,
    ME_CALL_EVENT          = 0x00000001,
    ME_TSP_DATA            = 0x00000002,
    ME_PRIVATE_EVENT       = 0x00000003,
    ME_ASR_TERMINAL_EVENT  = 0x00000004,
    ME_TTS_TERMINAL_EVENT  = 0x00000005,
    ME_FILE_TERMINAL_EVENT = 0x00000006,
    ME_TONE_TERMINAL_EVENT = 0x00000007,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/ne-rend-directory_type))], [])
alias DIRECTORY_TYPE = int;
enum : int
{
    DT_NTDS = 0x00000001,
    DT_ILS  = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/ne-rend-directory_object_type))], [])
alias DIRECTORY_OBJECT_TYPE = int;
enum : int
{
    OT_CONFERENCE = 0x00000001,
    OT_USER       = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/ne-rend-rnd_advertising_scope))], [])
alias RND_ADVERTISING_SCOPE = int;
enum : int
{
    RAS_LOCAL  = 0x00000001,
    RAS_SITE   = 0x00000002,
    RAS_REGION = 0x00000003,
    RAS_WORLD  = 0x00000004,
}

// Constants


enum uint TAPI_CURRENT_VERSION = 0x00020002;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Tapi/line-addressstate))], [])*/int LINE_ADDRESSSTATE = 0x00000000;

enum : /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Tapi/line-callinfo))], [])*/int
{
    LINE_CALLINFO           = 0x00000001,
    LINE_CALLSTATE          = 0x00000002,
    LINE_CLOSE              = 0x00000003,
    LINE_DEVSPECIFIC        = 0x00000004,
    LINE_DEVSPECIFICFEATURE = 0x00000005,
}

enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Tapi/line-gatherdigits))], [])*/int LINE_GATHERDIGITS = 0x00000006;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Tapi/line-generate))], [])*/int LINE_GENERATE = 0x00000007;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Tapi/line-linedevstate))], [])*/int LINE_LINEDEVSTATE = 0x00000008;

enum : /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Tapi/line-monitordigits))], [])*/int
{
    LINE_MONITORDIGITS = 0x00000009,
    LINE_MONITORMEDIA  = 0x0000000a,
    LINE_MONITORTONE   = 0x0000000b,
}

enum : /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Tapi/line-reply))], [])*/int
{
    LINE_REPLY   = 0x0000000c,
    LINE_REQUEST = 0x0000000d,
}

enum : /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Tapi/phone-button))], [])*/int
{
    PHONE_BUTTON      = 0x0000000e,
    PHONE_CLOSE       = 0x0000000f,
    PHONE_DEVSPECIFIC = 0x00000010,
}

enum : /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Tapi/phone-reply))], [])*/int
{
    PHONE_REPLY = 0x00000011,
    PHONE_STATE = 0x00000012,
}

enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Tapi/line-create))], [])*/int LINE_CREATE = 0x00000013;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Tapi/phone-create))], [])*/int PHONE_CREATE = 0x00000014;

enum : /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Tapi/line-agentspecific))], [])*/int
{
    LINE_AGENTSPECIFIC = 0x00000015,
    LINE_AGENTSTATUS   = 0x00000016,
}

enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Tapi/line-appnewcall))], [])*/int LINE_APPNEWCALL = 0x00000017;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Tapi/line-proxyrequest))], [])*/int LINE_PROXYREQUEST = 0x00000018;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Tapi/line-remove))], [])*/int LINE_REMOVE = 0x00000019;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Tapi/phone-remove))], [])*/int PHONE_REMOVE = 0x0000001a;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Tapi/line-agentsessionstatus))], [])*/int LINE_AGENTSESSIONSTATUS = 0x0000001b;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Tapi/line-queuestatus))], [])*/int LINE_QUEUESTATUS = 0x0000001c;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Tapi/line-agentstatusex))], [])*/int LINE_AGENTSTATUSEX = 0x0000001d;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Tapi/line-groupstatus))], [])*/int LINE_GROUPSTATUS = 0x0000001e;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Tapi/line-proxystatus))], [])*/int LINE_PROXYSTATUS = 0x0000001f;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Tapi/line-appnewcallhub))], [])*/int LINE_APPNEWCALLHUB = 0x00000020;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Tapi/line-callhubclose))], [])*/int LINE_CALLHUBCLOSE = 0x00000021;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Tapi/line-devspecificex))], [])*/int LINE_DEVSPECIFICEX = 0x00000022;
enum uint INITIALIZE_NEGOTIATION = 0xffffffff;

enum : uint
{
    LINEADDRCAPFLAGS_FWDNUMRINGS              = 0x00000001,
    LINEADDRCAPFLAGS_PICKUPGROUPID            = 0x00000002,
    LINEADDRCAPFLAGS_SECURE                   = 0x00000004,
    LINEADDRCAPFLAGS_BLOCKIDDEFAULT           = 0x00000008,
    LINEADDRCAPFLAGS_BLOCKIDOVERRIDE          = 0x00000010,
    LINEADDRCAPFLAGS_DIALED                   = 0x00000020,
    LINEADDRCAPFLAGS_ORIGOFFHOOK              = 0x00000040,
    LINEADDRCAPFLAGS_DESTOFFHOOK              = 0x00000080,
    LINEADDRCAPFLAGS_FWDCONSULT               = 0x00000100,
    LINEADDRCAPFLAGS_SETUPCONFNULL            = 0x00000200,
    LINEADDRCAPFLAGS_AUTORECONNECT            = 0x00000400,
    LINEADDRCAPFLAGS_COMPLETIONID             = 0x00000800,
    LINEADDRCAPFLAGS_TRANSFERHELD             = 0x00001000,
    LINEADDRCAPFLAGS_TRANSFERMAKE             = 0x00002000,
    LINEADDRCAPFLAGS_CONFERENCEHELD           = 0x00004000,
    LINEADDRCAPFLAGS_CONFERENCEMAKE           = 0x00008000,
    LINEADDRCAPFLAGS_PARTIALDIAL              = 0x00010000,
    LINEADDRCAPFLAGS_FWDSTATUSVALID           = 0x00020000,
    LINEADDRCAPFLAGS_FWDINTEXTADDR            = 0x00040000,
    LINEADDRCAPFLAGS_FWDBUSYNAADDR            = 0x00080000,
    LINEADDRCAPFLAGS_ACCEPTTOALERT            = 0x00100000,
    LINEADDRCAPFLAGS_CONFDROP                 = 0x00200000,
    LINEADDRCAPFLAGS_PICKUPCALLWAIT           = 0x00400000,
    LINEADDRCAPFLAGS_PREDICTIVEDIALER         = 0x00800000,
    LINEADDRCAPFLAGS_QUEUE                    = 0x01000000,
    LINEADDRCAPFLAGS_ROUTEPOINT               = 0x02000000,
    LINEADDRCAPFLAGS_HOLDMAKESNEW             = 0x04000000,
    LINEADDRCAPFLAGS_NOINTERNALCALLS          = 0x08000000,
    LINEADDRCAPFLAGS_NOEXTERNALCALLS          = 0x10000000,
    LINEADDRCAPFLAGS_SETCALLINGID             = 0x20000000,
    LINEADDRCAPFLAGS_ACDGROUP                 = 0x40000000,
    LINEADDRCAPFLAGS_NOPSTNADDRESSTRANSLATION = 0x80000000,
}

enum : uint
{
    LINEADDRESSMODE_ADDRESSID    = 0x00000001,
    LINEADDRESSMODE_DIALABLEADDR = 0x00000002,
}

enum : uint
{
    LINEADDRESSSHARING_PRIVATE       = 0x00000001,
    LINEADDRESSSHARING_BRIDGEDEXCL   = 0x00000002,
    LINEADDRESSSHARING_BRIDGEDNEW    = 0x00000004,
    LINEADDRESSSHARING_BRIDGEDSHARED = 0x00000008,
    LINEADDRESSSHARING_MONITORED     = 0x00000010,
    LINEADDRESSSTATE_OTHER           = 0x00000001,
    LINEADDRESSSTATE_DEVSPECIFIC     = 0x00000002,
    LINEADDRESSSTATE_INUSEZERO       = 0x00000004,
    LINEADDRESSSTATE_INUSEONE        = 0x00000008,
    LINEADDRESSSTATE_INUSEMANY       = 0x00000010,
    LINEADDRESSSTATE_NUMCALLS        = 0x00000020,
    LINEADDRESSSTATE_FORWARD         = 0x00000040,
    LINEADDRESSSTATE_TERMINALS       = 0x00000080,
    LINEADDRESSSTATE_CAPSCHANGE      = 0x00000100,
    LINEADDRESSTYPE_PHONENUMBER      = 0x00000001,
    LINEADDRESSTYPE_SDP              = 0x00000002,
    LINEADDRESSTYPE_EMAILNAME        = 0x00000004,
    LINEADDRESSTYPE_DOMAINNAME       = 0x00000008,
    LINEADDRESSTYPE_IPADDRESS        = 0x00000010,
}

enum : uint
{
    LINEADDRFEATURE_FORWARD         = 0x00000001,
    LINEADDRFEATURE_MAKECALL        = 0x00000002,
    LINEADDRFEATURE_PICKUP          = 0x00000004,
    LINEADDRFEATURE_SETMEDIACONTROL = 0x00000008,
    LINEADDRFEATURE_SETTERMINAL     = 0x00000010,
    LINEADDRFEATURE_SETUPCONF       = 0x00000020,
    LINEADDRFEATURE_UNCOMPLETECALL  = 0x00000040,
    LINEADDRFEATURE_UNPARK          = 0x00000080,
    LINEADDRFEATURE_PICKUPHELD      = 0x00000100,
    LINEADDRFEATURE_PICKUPGROUP     = 0x00000200,
    LINEADDRFEATURE_PICKUPDIRECT    = 0x00000400,
    LINEADDRFEATURE_PICKUPWAITING   = 0x00000800,
    LINEADDRFEATURE_FORWARDFWD      = 0x00001000,
    LINEADDRFEATURE_FORWARDDND      = 0x00002000,
}

enum : uint
{
    LINEAGENTFEATURE_SETAGENTGROUP        = 0x00000001,
    LINEAGENTFEATURE_SETAGENTSTATE        = 0x00000002,
    LINEAGENTFEATURE_SETAGENTACTIVITY     = 0x00000004,
    LINEAGENTFEATURE_AGENTSPECIFIC        = 0x00000008,
    LINEAGENTFEATURE_GETAGENTACTIVITYLIST = 0x00000010,
    LINEAGENTFEATURE_GETAGENTGROUP        = 0x00000020,
}

enum : uint
{
    LINEAGENTSTATE_LOGGEDOFF        = 0x00000001,
    LINEAGENTSTATE_NOTREADY         = 0x00000002,
    LINEAGENTSTATE_READY            = 0x00000004,
    LINEAGENTSTATE_BUSYACD          = 0x00000008,
    LINEAGENTSTATE_BUSYINCOMING     = 0x00000010,
    LINEAGENTSTATE_BUSYOUTBOUND     = 0x00000020,
    LINEAGENTSTATE_BUSYOTHER        = 0x00000040,
    LINEAGENTSTATE_WORKINGAFTERCALL = 0x00000080,
    LINEAGENTSTATE_UNKNOWN          = 0x00000100,
    LINEAGENTSTATE_UNAVAIL          = 0x00000200,
    LINEAGENTSTATUS_GROUP           = 0x00000001,
    LINEAGENTSTATUS_STATE           = 0x00000002,
    LINEAGENTSTATUS_NEXTSTATE       = 0x00000004,
    LINEAGENTSTATUS_ACTIVITY        = 0x00000008,
    LINEAGENTSTATUS_ACTIVITYLIST    = 0x00000010,
    LINEAGENTSTATUS_GROUPLIST       = 0x00000020,
    LINEAGENTSTATUS_CAPSCHANGE      = 0x00000040,
    LINEAGENTSTATUS_VALIDSTATES     = 0x00000080,
    LINEAGENTSTATUS_VALIDNEXTSTATES = 0x00000100,
    LINEAGENTSTATEEX_NOTREADY       = 0x00000001,
    LINEAGENTSTATEEX_READY          = 0x00000002,
    LINEAGENTSTATEEX_BUSYACD        = 0x00000004,
    LINEAGENTSTATEEX_BUSYINCOMING   = 0x00000008,
    LINEAGENTSTATEEX_BUSYOUTGOING   = 0x00000010,
    LINEAGENTSTATEEX_UNKNOWN        = 0x00000020,
    LINEAGENTSTATEEX_RELEASED       = 0x00000040,
    LINEAGENTSTATUSEX_NEWAGENT      = 0x00000001,
    LINEAGENTSTATUSEX_STATE         = 0x00000002,
    LINEAGENTSTATUSEX_UPDATEINFO    = 0x00000004,
}

enum : uint
{
    LINEAGENTSESSIONSTATE_NOTREADY    = 0x00000001,
    LINEAGENTSESSIONSTATE_READY       = 0x00000002,
    LINEAGENTSESSIONSTATE_BUSYONCALL  = 0x00000004,
    LINEAGENTSESSIONSTATE_BUSYWRAPUP  = 0x00000008,
    LINEAGENTSESSIONSTATE_ENDED       = 0x00000010,
    LINEAGENTSESSIONSTATE_RELEASED    = 0x00000020,
    LINEAGENTSESSIONSTATUS_NEWSESSION = 0x00000001,
    LINEAGENTSESSIONSTATUS_STATE      = 0x00000002,
    LINEAGENTSESSIONSTATUS_UPDATEINFO = 0x00000004,
}

enum : uint
{
    LINEQUEUESTATUS_UPDATEINFO   = 0x00000001,
    LINEQUEUESTATUS_NEWQUEUE     = 0x00000002,
    LINEQUEUESTATUS_QUEUEREMOVED = 0x00000004,
}

enum : uint
{
    LINEGROUPSTATUS_NEWGROUP     = 0x00000001,
    LINEGROUPSTATUS_GROUPREMOVED = 0x00000002,
}

enum : uint
{
    LINEPROXYSTATUS_OPEN          = 0x00000001,
    LINEPROXYSTATUS_CLOSE         = 0x00000002,
    LINEPROXYSTATUS_ALLOPENFORACD = 0x00000004,
}

enum : uint
{
    LINEANSWERMODE_NONE = 0x00000001,
    LINEANSWERMODE_DROP = 0x00000002,
    LINEANSWERMODE_HOLD = 0x00000004,
}

enum : uint
{
    LINEBEARERMODE_VOICE            = 0x00000001,
    LINEBEARERMODE_SPEECH           = 0x00000002,
    LINEBEARERMODE_MULTIUSE         = 0x00000004,
    LINEBEARERMODE_DATA             = 0x00000008,
    LINEBEARERMODE_ALTSPEECHDATA    = 0x00000010,
    LINEBEARERMODE_NONCALLSIGNALING = 0x00000020,
    LINEBEARERMODE_PASSTHROUGH      = 0x00000040,
    LINEBEARERMODE_RESTRICTEDDATA   = 0x00000080,
}

enum : uint
{
    LINEBUSYMODE_STATION = 0x00000001,
    LINEBUSYMODE_TRUNK   = 0x00000002,
    LINEBUSYMODE_UNKNOWN = 0x00000004,
    LINEBUSYMODE_UNAVAIL = 0x00000008,
}

enum : uint
{
    LINECALLCOMPLCOND_BUSY     = 0x00000001,
    LINECALLCOMPLCOND_NOANSWER = 0x00000002,
    LINECALLCOMPLMODE_CAMPON   = 0x00000001,
    LINECALLCOMPLMODE_CALLBACK = 0x00000002,
    LINECALLCOMPLMODE_INTRUDE  = 0x00000004,
    LINECALLCOMPLMODE_MESSAGE  = 0x00000008,
}

enum : uint
{
    LINECALLFEATURE_ACCEPT              = 0x00000001,
    LINECALLFEATURE_ADDTOCONF           = 0x00000002,
    LINECALLFEATURE_ANSWER              = 0x00000004,
    LINECALLFEATURE_BLINDTRANSFER       = 0x00000008,
    LINECALLFEATURE_COMPLETECALL        = 0x00000010,
    LINECALLFEATURE_COMPLETETRANSF      = 0x00000020,
    LINECALLFEATURE_DIAL                = 0x00000040,
    LINECALLFEATURE_DROP                = 0x00000080,
    LINECALLFEATURE_GATHERDIGITS        = 0x00000100,
    LINECALLFEATURE_GENERATEDIGITS      = 0x00000200,
    LINECALLFEATURE_GENERATETONE        = 0x00000400,
    LINECALLFEATURE_HOLD                = 0x00000800,
    LINECALLFEATURE_MONITORDIGITS       = 0x00001000,
    LINECALLFEATURE_MONITORMEDIA        = 0x00002000,
    LINECALLFEATURE_MONITORTONES        = 0x00004000,
    LINECALLFEATURE_PARK                = 0x00008000,
    LINECALLFEATURE_PREPAREADDCONF      = 0x00010000,
    LINECALLFEATURE_REDIRECT            = 0x00020000,
    LINECALLFEATURE_REMOVEFROMCONF      = 0x00040000,
    LINECALLFEATURE_SECURECALL          = 0x00080000,
    LINECALLFEATURE_SENDUSERUSER        = 0x00100000,
    LINECALLFEATURE_SETCALLPARAMS       = 0x00200000,
    LINECALLFEATURE_SETMEDIACONTROL     = 0x00400000,
    LINECALLFEATURE_SETTERMINAL         = 0x00800000,
    LINECALLFEATURE_SETUPCONF           = 0x01000000,
    LINECALLFEATURE_SETUPTRANSFER       = 0x02000000,
    LINECALLFEATURE_SWAPHOLD            = 0x04000000,
    LINECALLFEATURE_UNHOLD              = 0x08000000,
    LINECALLFEATURE_RELEASEUSERUSERINFO = 0x10000000,
    LINECALLFEATURE_SETTREATMENT        = 0x20000000,
    LINECALLFEATURE_SETQOS              = 0x40000000,
    LINECALLFEATURE_SETCALLDATA         = 0x80000000,
    LINECALLFEATURE2_NOHOLDCONFERENCE   = 0x00000001,
    LINECALLFEATURE2_ONESTEPTRANSFER    = 0x00000002,
    LINECALLFEATURE2_COMPLCAMPON        = 0x00000004,
    LINECALLFEATURE2_COMPLCALLBACK      = 0x00000008,
    LINECALLFEATURE2_COMPLINTRUDE       = 0x00000010,
    LINECALLFEATURE2_COMPLMESSAGE       = 0x00000020,
    LINECALLFEATURE2_TRANSFERNORM       = 0x00000040,
    LINECALLFEATURE2_TRANSFERCONF       = 0x00000080,
    LINECALLFEATURE2_PARKDIRECT         = 0x00000100,
    LINECALLFEATURE2_PARKNONDIRECT      = 0x00000200,
}

enum : uint
{
    LINECALLHUBTRACKING_NONE          = 0x00000000,
    LINECALLHUBTRACKING_PROVIDERLEVEL = 0x00000001,
    LINECALLHUBTRACKING_ALLCALLS      = 0x00000002,
}

enum : uint
{
    LINECALLINFOSTATE_OTHER         = 0x00000001,
    LINECALLINFOSTATE_DEVSPECIFIC   = 0x00000002,
    LINECALLINFOSTATE_BEARERMODE    = 0x00000004,
    LINECALLINFOSTATE_RATE          = 0x00000008,
    LINECALLINFOSTATE_MEDIAMODE     = 0x00000010,
    LINECALLINFOSTATE_APPSPECIFIC   = 0x00000020,
    LINECALLINFOSTATE_CALLID        = 0x00000040,
    LINECALLINFOSTATE_RELATEDCALLID = 0x00000080,
    LINECALLINFOSTATE_ORIGIN        = 0x00000100,
    LINECALLINFOSTATE_REASON        = 0x00000200,
    LINECALLINFOSTATE_COMPLETIONID  = 0x00000400,
    LINECALLINFOSTATE_NUMOWNERINCR  = 0x00000800,
    LINECALLINFOSTATE_NUMOWNERDECR  = 0x00001000,
    LINECALLINFOSTATE_NUMMONITORS   = 0x00002000,
    LINECALLINFOSTATE_TRUNK         = 0x00004000,
    LINECALLINFOSTATE_CALLERID      = 0x00008000,
    LINECALLINFOSTATE_CALLEDID      = 0x00010000,
    LINECALLINFOSTATE_CONNECTEDID   = 0x00020000,
    LINECALLINFOSTATE_REDIRECTIONID = 0x00040000,
    LINECALLINFOSTATE_REDIRECTINGID = 0x00080000,
    LINECALLINFOSTATE_DISPLAY       = 0x00100000,
    LINECALLINFOSTATE_USERUSERINFO  = 0x00200000,
    LINECALLINFOSTATE_HIGHLEVELCOMP = 0x00400000,
    LINECALLINFOSTATE_LOWLEVELCOMP  = 0x00800000,
    LINECALLINFOSTATE_CHARGINGINFO  = 0x01000000,
    LINECALLINFOSTATE_TERMINAL      = 0x02000000,
    LINECALLINFOSTATE_DIALPARAMS    = 0x04000000,
    LINECALLINFOSTATE_MONITORMODES  = 0x08000000,
    LINECALLINFOSTATE_TREATMENT     = 0x10000000,
    LINECALLINFOSTATE_QOS           = 0x20000000,
    LINECALLINFOSTATE_CALLDATA      = 0x40000000,
}

enum : uint
{
    LINECALLORIGIN_OUTBOUND   = 0x00000001,
    LINECALLORIGIN_INTERNAL   = 0x00000002,
    LINECALLORIGIN_EXTERNAL   = 0x00000004,
    LINECALLORIGIN_UNKNOWN    = 0x00000010,
    LINECALLORIGIN_UNAVAIL    = 0x00000020,
    LINECALLORIGIN_CONFERENCE = 0x00000040,
    LINECALLORIGIN_INBOUND    = 0x00000080,
}

enum : uint
{
    LINECALLPARAMFLAGS_SECURE           = 0x00000001,
    LINECALLPARAMFLAGS_IDLE             = 0x00000002,
    LINECALLPARAMFLAGS_BLOCKID          = 0x00000004,
    LINECALLPARAMFLAGS_ORIGOFFHOOK      = 0x00000008,
    LINECALLPARAMFLAGS_DESTOFFHOOK      = 0x00000010,
    LINECALLPARAMFLAGS_NOHOLDCONFERENCE = 0x00000020,
    LINECALLPARAMFLAGS_PREDICTIVEDIAL   = 0x00000040,
    LINECALLPARAMFLAGS_ONESTEPTRANSFER  = 0x00000080,
}

enum : uint
{
    LINECALLPARTYID_BLOCKED   = 0x00000001,
    LINECALLPARTYID_OUTOFAREA = 0x00000002,
    LINECALLPARTYID_NAME      = 0x00000004,
    LINECALLPARTYID_ADDRESS   = 0x00000008,
    LINECALLPARTYID_PARTIAL   = 0x00000010,
    LINECALLPARTYID_UNKNOWN   = 0x00000020,
    LINECALLPARTYID_UNAVAIL   = 0x00000040,
}

enum : uint
{
    LINECALLPRIVILEGE_NONE    = 0x00000001,
    LINECALLPRIVILEGE_MONITOR = 0x00000002,
    LINECALLPRIVILEGE_OWNER   = 0x00000004,
}

enum : uint
{
    LINECALLREASON_DIRECT         = 0x00000001,
    LINECALLREASON_FWDBUSY        = 0x00000002,
    LINECALLREASON_FWDNOANSWER    = 0x00000004,
    LINECALLREASON_FWDUNCOND      = 0x00000008,
    LINECALLREASON_PICKUP         = 0x00000010,
    LINECALLREASON_UNPARK         = 0x00000020,
    LINECALLREASON_REDIRECT       = 0x00000040,
    LINECALLREASON_CALLCOMPLETION = 0x00000080,
    LINECALLREASON_TRANSFER       = 0x00000100,
    LINECALLREASON_REMINDER       = 0x00000200,
    LINECALLREASON_UNKNOWN        = 0x00000400,
    LINECALLREASON_UNAVAIL        = 0x00000800,
    LINECALLREASON_INTRUDE        = 0x00001000,
    LINECALLREASON_PARKED         = 0x00002000,
    LINECALLREASON_CAMPEDON       = 0x00004000,
    LINECALLREASON_ROUTEREQUEST   = 0x00008000,
}

enum : uint
{
    LINECALLSELECT_LINE              = 0x00000001,
    LINECALLSELECT_ADDRESS           = 0x00000002,
    LINECALLSELECT_CALL              = 0x00000004,
    LINECALLSELECT_DEVICEID          = 0x00000008,
    LINECALLSELECT_CALLID            = 0x00000010,
    LINECALLSTATE_IDLE               = 0x00000001,
    LINECALLSTATE_OFFERING           = 0x00000002,
    LINECALLSTATE_ACCEPTED           = 0x00000004,
    LINECALLSTATE_DIALTONE           = 0x00000008,
    LINECALLSTATE_DIALING            = 0x00000010,
    LINECALLSTATE_RINGBACK           = 0x00000020,
    LINECALLSTATE_BUSY               = 0x00000040,
    LINECALLSTATE_SPECIALINFO        = 0x00000080,
    LINECALLSTATE_CONNECTED          = 0x00000100,
    LINECALLSTATE_PROCEEDING         = 0x00000200,
    LINECALLSTATE_ONHOLD             = 0x00000400,
    LINECALLSTATE_CONFERENCED        = 0x00000800,
    LINECALLSTATE_ONHOLDPENDCONF     = 0x00001000,
    LINECALLSTATE_ONHOLDPENDTRANSFER = 0x00002000,
    LINECALLSTATE_DISCONNECTED       = 0x00004000,
    LINECALLSTATE_UNKNOWN            = 0x00008000,
}

enum : uint
{
    LINECALLTREATMENT_SILENCE  = 0x00000001,
    LINECALLTREATMENT_RINGBACK = 0x00000002,
    LINECALLTREATMENT_BUSY     = 0x00000003,
    LINECALLTREATMENT_MUSIC    = 0x00000004,
}

enum : uint
{
    LINECARDOPTION_PREDEFINED = 0x00000001,
    LINECARDOPTION_HIDDEN     = 0x00000002,
}

enum : uint
{
    LINECONNECTEDMODE_ACTIVE       = 0x00000001,
    LINECONNECTEDMODE_INACTIVE     = 0x00000002,
    LINECONNECTEDMODE_ACTIVEHELD   = 0x00000004,
    LINECONNECTEDMODE_INACTIVEHELD = 0x00000008,
    LINECONNECTEDMODE_CONFIRMED    = 0x00000010,
}

enum : uint
{
    LINEDEVCAPFLAGS_CROSSADDRCONF   = 0x00000001,
    LINEDEVCAPFLAGS_HIGHLEVCOMP     = 0x00000002,
    LINEDEVCAPFLAGS_LOWLEVCOMP      = 0x00000004,
    LINEDEVCAPFLAGS_MEDIACONTROL    = 0x00000008,
    LINEDEVCAPFLAGS_MULTIPLEADDR    = 0x00000010,
    LINEDEVCAPFLAGS_CLOSEDROP       = 0x00000020,
    LINEDEVCAPFLAGS_DIALBILLING     = 0x00000040,
    LINEDEVCAPFLAGS_DIALQUIET       = 0x00000080,
    LINEDEVCAPFLAGS_DIALDIALTONE    = 0x00000100,
    LINEDEVCAPFLAGS_MSP             = 0x00000200,
    LINEDEVCAPFLAGS_CALLHUB         = 0x00000400,
    LINEDEVCAPFLAGS_CALLHUBTRACKING = 0x00000800,
    LINEDEVCAPFLAGS_PRIVATEOBJECTS  = 0x00001000,
    LINEDEVCAPFLAGS_LOCAL           = 0x00002000,
}

enum : uint
{
    LINEDEVSTATE_OTHER           = 0x00000001,
    LINEDEVSTATE_RINGING         = 0x00000002,
    LINEDEVSTATE_CONNECTED       = 0x00000004,
    LINEDEVSTATE_DISCONNECTED    = 0x00000008,
    LINEDEVSTATE_MSGWAITON       = 0x00000010,
    LINEDEVSTATE_MSGWAITOFF      = 0x00000020,
    LINEDEVSTATE_INSERVICE       = 0x00000040,
    LINEDEVSTATE_OUTOFSERVICE    = 0x00000080,
    LINEDEVSTATE_MAINTENANCE     = 0x00000100,
    LINEDEVSTATE_OPEN            = 0x00000200,
    LINEDEVSTATE_CLOSE           = 0x00000400,
    LINEDEVSTATE_NUMCALLS        = 0x00000800,
    LINEDEVSTATE_NUMCOMPLETIONS  = 0x00001000,
    LINEDEVSTATE_TERMINALS       = 0x00002000,
    LINEDEVSTATE_ROAMMODE        = 0x00004000,
    LINEDEVSTATE_BATTERY         = 0x00008000,
    LINEDEVSTATE_SIGNAL          = 0x00010000,
    LINEDEVSTATE_DEVSPECIFIC     = 0x00020000,
    LINEDEVSTATE_REINIT          = 0x00040000,
    LINEDEVSTATE_LOCK            = 0x00080000,
    LINEDEVSTATE_CAPSCHANGE      = 0x00100000,
    LINEDEVSTATE_CONFIGCHANGE    = 0x00200000,
    LINEDEVSTATE_TRANSLATECHANGE = 0x00400000,
    LINEDEVSTATE_COMPLCANCEL     = 0x00800000,
    LINEDEVSTATE_REMOVED         = 0x01000000,
    LINEDEVSTATUSFLAGS_CONNECTED = 0x00000001,
    LINEDEVSTATUSFLAGS_MSGWAIT   = 0x00000002,
    LINEDEVSTATUSFLAGS_INSERVICE = 0x00000004,
    LINEDEVSTATUSFLAGS_LOCKED    = 0x00000008,
}

enum : uint
{
    LINEDIALTONEMODE_NORMAL   = 0x00000001,
    LINEDIALTONEMODE_SPECIAL  = 0x00000002,
    LINEDIALTONEMODE_INTERNAL = 0x00000004,
    LINEDIALTONEMODE_EXTERNAL = 0x00000008,
    LINEDIALTONEMODE_UNKNOWN  = 0x00000010,
    LINEDIALTONEMODE_UNAVAIL  = 0x00000020,
}

enum : uint
{
    LINEDIGITMODE_PULSE   = 0x00000001,
    LINEDIGITMODE_DTMF    = 0x00000002,
    LINEDIGITMODE_DTMFEND = 0x00000004,
}

enum : uint
{
    LINEDISCONNECTMODE_NORMAL            = 0x00000001,
    LINEDISCONNECTMODE_UNKNOWN           = 0x00000002,
    LINEDISCONNECTMODE_REJECT            = 0x00000004,
    LINEDISCONNECTMODE_PICKUP            = 0x00000008,
    LINEDISCONNECTMODE_FORWARDED         = 0x00000010,
    LINEDISCONNECTMODE_BUSY              = 0x00000020,
    LINEDISCONNECTMODE_NOANSWER          = 0x00000040,
    LINEDISCONNECTMODE_BADADDRESS        = 0x00000080,
    LINEDISCONNECTMODE_UNREACHABLE       = 0x00000100,
    LINEDISCONNECTMODE_CONGESTION        = 0x00000200,
    LINEDISCONNECTMODE_INCOMPATIBLE      = 0x00000400,
    LINEDISCONNECTMODE_UNAVAIL           = 0x00000800,
    LINEDISCONNECTMODE_NODIALTONE        = 0x00001000,
    LINEDISCONNECTMODE_NUMBERCHANGED     = 0x00002000,
    LINEDISCONNECTMODE_OUTOFORDER        = 0x00004000,
    LINEDISCONNECTMODE_TEMPFAILURE       = 0x00008000,
    LINEDISCONNECTMODE_QOSUNAVAIL        = 0x00010000,
    LINEDISCONNECTMODE_BLOCKED           = 0x00020000,
    LINEDISCONNECTMODE_DONOTDISTURB      = 0x00040000,
    LINEDISCONNECTMODE_CANCELLED         = 0x00080000,
    LINEDISCONNECTMODE_DESTINATIONBARRED = 0x00100000,
    LINEDISCONNECTMODE_FDNRESTRICT       = 0x00200000,
}

enum : uint
{
    LINEERR_ALLOCATED         = 0x80000001,
    LINEERR_BADDEVICEID       = 0x80000002,
    LINEERR_BEARERMODEUNAVAIL = 0x80000003,
}

enum : uint
{
    LINEERR_CALLUNAVAIL       = 0x80000005,
    LINEERR_COMPLETIONOVERRUN = 0x80000006,
}

enum uint LINEERR_CONFERENCEFULL = 0x80000007;

enum : uint
{
    LINEERR_DIALBILLING            = 0x80000008,
    LINEERR_DIALDIALTONE           = 0x80000009,
    LINEERR_DIALPROMPT             = 0x8000000a,
    LINEERR_DIALQUIET              = 0x8000000b,
    LINEERR_INCOMPATIBLEAPIVERSION = 0x8000000c,
    LINEERR_INCOMPATIBLEEXTVERSION = 0x8000000d,
}

enum : uint
{
    LINEERR_INIFILECORRUPT         = 0x8000000e,
    LINEERR_INUSE                  = 0x8000000f,
    LINEERR_INVALADDRESS           = 0x80000010,
    LINEERR_INVALADDRESSID         = 0x80000011,
    LINEERR_INVALADDRESSMODE       = 0x80000012,
    LINEERR_INVALADDRESSSTATE      = 0x80000013,
    LINEERR_INVALAPPHANDLE         = 0x80000014,
    LINEERR_INVALAPPNAME           = 0x80000015,
    LINEERR_INVALBEARERMODE        = 0x80000016,
    LINEERR_INVALCALLCOMPLMODE     = 0x80000017,
    LINEERR_INVALCALLHANDLE        = 0x80000018,
    LINEERR_INVALCALLPARAMS        = 0x80000019,
    LINEERR_INVALCALLPRIVILEGE     = 0x8000001a,
    LINEERR_INVALCALLSELECT        = 0x8000001b,
    LINEERR_INVALCALLSTATE         = 0x8000001c,
    LINEERR_INVALCALLSTATELIST     = 0x8000001d,
    LINEERR_INVALCARD              = 0x8000001e,
    LINEERR_INVALCOMPLETIONID      = 0x8000001f,
    LINEERR_INVALCONFCALLHANDLE    = 0x80000020,
    LINEERR_INVALCONSULTCALLHANDLE = 0x80000021,
    LINEERR_INVALCOUNTRYCODE       = 0x80000022,
    LINEERR_INVALDEVICECLASS       = 0x80000023,
    LINEERR_INVALDEVICEHANDLE      = 0x80000024,
    LINEERR_INVALDIALPARAMS        = 0x80000025,
    LINEERR_INVALDIGITLIST         = 0x80000026,
    LINEERR_INVALDIGITMODE         = 0x80000027,
    LINEERR_INVALDIGITS            = 0x80000028,
    LINEERR_INVALEXTVERSION        = 0x80000029,
    LINEERR_INVALGROUPID           = 0x8000002a,
    LINEERR_INVALLINEHANDLE        = 0x8000002b,
    LINEERR_INVALLINESTATE         = 0x8000002c,
    LINEERR_INVALLOCATION          = 0x8000002d,
    LINEERR_INVALMEDIALIST         = 0x8000002e,
    LINEERR_INVALMEDIAMODE         = 0x8000002f,
    LINEERR_INVALMESSAGEID         = 0x80000030,
    LINEERR_INVALPARAM             = 0x80000032,
    LINEERR_INVALPARKID            = 0x80000033,
    LINEERR_INVALPARKMODE          = 0x80000034,
    LINEERR_INVALPOINTER           = 0x80000035,
    LINEERR_INVALPRIVSELECT        = 0x80000036,
    LINEERR_INVALRATE              = 0x80000037,
    LINEERR_INVALREQUESTMODE       = 0x80000038,
    LINEERR_INVALTERMINALID        = 0x80000039,
    LINEERR_INVALTERMINALMODE      = 0x8000003a,
    LINEERR_INVALTIMEOUT           = 0x8000003b,
    LINEERR_INVALTONE              = 0x8000003c,
    LINEERR_INVALTONELIST          = 0x8000003d,
    LINEERR_INVALTONEMODE          = 0x8000003e,
    LINEERR_INVALTRANSFERMODE      = 0x8000003f,
}

enum uint LINEERR_LINEMAPPERFAILED = 0x80000040;

enum : uint
{
    LINEERR_NOCONFERENCE  = 0x80000041,
    LINEERR_NODEVICE      = 0x80000042,
    LINEERR_NODRIVER      = 0x80000043,
    LINEERR_NOMEM         = 0x80000044,
    LINEERR_NOREQUEST     = 0x80000045,
    LINEERR_NOTOWNER      = 0x80000046,
    LINEERR_NOTREGISTERED = 0x80000047,
}

enum : uint
{
    LINEERR_OPERATIONFAILED  = 0x80000048,
    LINEERR_OPERATIONUNAVAIL = 0x80000049,
}

enum : uint
{
    LINEERR_RATEUNAVAIL     = 0x8000004a,
    LINEERR_RESOURCEUNAVAIL = 0x8000004b,
    LINEERR_REQUESTOVERRUN  = 0x8000004c,
}

enum uint LINEERR_STRUCTURETOOSMALL = 0x8000004d;

enum : uint
{
    LINEERR_TARGETNOTFOUND     = 0x8000004e,
    LINEERR_TARGETSELF         = 0x8000004f,
    LINEERR_UNINITIALIZED      = 0x80000050,
    LINEERR_USERUSERINFOTOOBIG = 0x80000051,
}

enum : uint
{
    LINEERR_REINIT         = 0x80000052,
    LINEERR_ADDRESSBLOCKED = 0x80000053,
}

enum uint LINEERR_BILLINGREJECTED = 0x80000054;
enum uint LINEERR_INVALFEATURE = 0x80000055;
enum uint LINEERR_NOMULTIPLEINSTANCE = 0x80000056;

enum : uint
{
    LINEERR_INVALAGENTID       = 0x80000057,
    LINEERR_INVALAGENTGROUP    = 0x80000058,
    LINEERR_INVALPASSWORD      = 0x80000059,
    LINEERR_INVALAGENTSTATE    = 0x8000005a,
    LINEERR_INVALAGENTACTIVITY = 0x8000005b,
}

enum uint LINEERR_DIALVOICEDETECT = 0x8000005c;
enum uint LINEERR_USERCANCELLED = 0x8000005d;

enum : uint
{
    LINEERR_INVALADDRESSTYPE       = 0x8000005e,
    LINEERR_INVALAGENTSESSIONSTATE = 0x8000005f,
}

enum uint LINEERR_DISCONNECTED = 0x80000060;
enum uint LINEERR_SERVICE_NOT_RUNNING = 0x80000061;

enum : uint
{
    LINEFEATURE_DEVSPECIFIC     = 0x00000001,
    LINEFEATURE_DEVSPECIFICFEAT = 0x00000002,
    LINEFEATURE_FORWARD         = 0x00000004,
    LINEFEATURE_MAKECALL        = 0x00000008,
    LINEFEATURE_SETMEDIACONTROL = 0x00000010,
    LINEFEATURE_SETTERMINAL     = 0x00000020,
    LINEFEATURE_SETDEVSTATUS    = 0x00000040,
    LINEFEATURE_FORWARDFWD      = 0x00000080,
    LINEFEATURE_FORWARDDND      = 0x00000100,
}

enum : uint
{
    LINEFORWARDMODE_UNCOND         = 0x00000001,
    LINEFORWARDMODE_UNCONDINTERNAL = 0x00000002,
    LINEFORWARDMODE_UNCONDEXTERNAL = 0x00000004,
    LINEFORWARDMODE_UNCONDSPECIFIC = 0x00000008,
    LINEFORWARDMODE_BUSY           = 0x00000010,
    LINEFORWARDMODE_BUSYINTERNAL   = 0x00000020,
    LINEFORWARDMODE_BUSYEXTERNAL   = 0x00000040,
    LINEFORWARDMODE_BUSYSPECIFIC   = 0x00000080,
    LINEFORWARDMODE_NOANSW         = 0x00000100,
    LINEFORWARDMODE_NOANSWINTERNAL = 0x00000200,
    LINEFORWARDMODE_NOANSWEXTERNAL = 0x00000400,
    LINEFORWARDMODE_NOANSWSPECIFIC = 0x00000800,
    LINEFORWARDMODE_BUSYNA         = 0x00001000,
    LINEFORWARDMODE_BUSYNAINTERNAL = 0x00002000,
    LINEFORWARDMODE_BUSYNAEXTERNAL = 0x00004000,
    LINEFORWARDMODE_BUSYNASPECIFIC = 0x00008000,
    LINEFORWARDMODE_UNKNOWN        = 0x00010000,
    LINEFORWARDMODE_UNAVAIL        = 0x00020000,
}

enum : uint
{
    LINEGATHERTERM_BUFFERFULL   = 0x00000001,
    LINEGATHERTERM_TERMDIGIT    = 0x00000002,
    LINEGATHERTERM_FIRSTTIMEOUT = 0x00000004,
    LINEGATHERTERM_INTERTIMEOUT = 0x00000008,
    LINEGATHERTERM_CANCEL       = 0x00000010,
}

enum : uint
{
    LINEGENERATETERM_DONE   = 0x00000001,
    LINEGENERATETERM_CANCEL = 0x00000002,
}

enum : uint
{
    LINEINITIALIZEEXOPTION_USEHIDDENWINDOW   = 0x00000001,
    LINEINITIALIZEEXOPTION_USEEVENT          = 0x00000002,
    LINEINITIALIZEEXOPTION_USECOMPLETIONPORT = 0x00000003,
    LINEINITIALIZEEXOPTION_CALLHUBTRACKING   = 0x80000000,
}

enum uint LINELOCATIONOPTION_PULSEDIAL = 0x00000001;

enum : uint
{
    LINEMAPPER                    = 0xffffffff,
    LINEMEDIACONTROL_NONE         = 0x00000001,
    LINEMEDIACONTROL_START        = 0x00000002,
    LINEMEDIACONTROL_RESET        = 0x00000004,
    LINEMEDIACONTROL_PAUSE        = 0x00000008,
    LINEMEDIACONTROL_RESUME       = 0x00000010,
    LINEMEDIACONTROL_RATEUP       = 0x00000020,
    LINEMEDIACONTROL_RATEDOWN     = 0x00000040,
    LINEMEDIACONTROL_RATENORMAL   = 0x00000080,
    LINEMEDIACONTROL_VOLUMEUP     = 0x00000100,
    LINEMEDIACONTROL_VOLUMEDOWN   = 0x00000200,
    LINEMEDIACONTROL_VOLUMENORMAL = 0x00000400,
}

enum : uint
{
    LINEMEDIAMODE_UNKNOWN          = 0x00000002,
    LINEMEDIAMODE_INTERACTIVEVOICE = 0x00000004,
    LINEMEDIAMODE_AUTOMATEDVOICE   = 0x00000008,
    LINEMEDIAMODE_DATAMODEM        = 0x00000010,
    LINEMEDIAMODE_G3FAX            = 0x00000020,
    LINEMEDIAMODE_TDD              = 0x00000040,
    LINEMEDIAMODE_G4FAX            = 0x00000080,
    LINEMEDIAMODE_DIGITALDATA      = 0x00000100,
    LINEMEDIAMODE_TELETEX          = 0x00000200,
    LINEMEDIAMODE_VIDEOTEX         = 0x00000400,
    LINEMEDIAMODE_TELEX            = 0x00000800,
    LINEMEDIAMODE_MIXED            = 0x00001000,
    LINEMEDIAMODE_ADSI             = 0x00002000,
    LINEMEDIAMODE_VOICEVIEW        = 0x00004000,
    LINEMEDIAMODE_VIDEO            = 0x00008000,
}

enum uint LAST_LINEMEDIAMODE = 0x00008000;

enum : uint
{
    LINEOFFERINGMODE_ACTIVE   = 0x00000001,
    LINEOFFERINGMODE_INACTIVE = 0x00000002,
}

enum : uint
{
    LINEOPENOPTION_SINGLEADDRESS = 0x80000000,
    LINEOPENOPTION_PROXY         = 0x40000000,
}

enum : uint
{
    LINEPARKMODE_DIRECTED    = 0x00000001,
    LINEPARKMODE_NONDIRECTED = 0x00000002,
}

enum : uint
{
    LINEPROXYREQUEST_SETAGENTGROUP             = 0x00000001,
    LINEPROXYREQUEST_SETAGENTSTATE             = 0x00000002,
    LINEPROXYREQUEST_SETAGENTACTIVITY          = 0x00000003,
    LINEPROXYREQUEST_GETAGENTCAPS              = 0x00000004,
    LINEPROXYREQUEST_GETAGENTSTATUS            = 0x00000005,
    LINEPROXYREQUEST_AGENTSPECIFIC             = 0x00000006,
    LINEPROXYREQUEST_GETAGENTACTIVITYLIST      = 0x00000007,
    LINEPROXYREQUEST_GETAGENTGROUPLIST         = 0x00000008,
    LINEPROXYREQUEST_CREATEAGENT               = 0x00000009,
    LINEPROXYREQUEST_SETAGENTMEASUREMENTPERIOD = 0x0000000a,
    LINEPROXYREQUEST_GETAGENTINFO              = 0x0000000b,
    LINEPROXYREQUEST_CREATEAGENTSESSION        = 0x0000000c,
    LINEPROXYREQUEST_GETAGENTSESSIONLIST       = 0x0000000d,
    LINEPROXYREQUEST_SETAGENTSESSIONSTATE      = 0x0000000e,
    LINEPROXYREQUEST_GETAGENTSESSIONINFO       = 0x0000000f,
    LINEPROXYREQUEST_GETQUEUELIST              = 0x00000010,
    LINEPROXYREQUEST_SETQUEUEMEASUREMENTPERIOD = 0x00000011,
    LINEPROXYREQUEST_GETQUEUEINFO              = 0x00000012,
    LINEPROXYREQUEST_GETGROUPLIST              = 0x00000013,
    LINEPROXYREQUEST_SETAGENTSTATEEX           = 0x00000014,
}

enum : uint
{
    LINEREMOVEFROMCONF_NONE = 0x00000001,
    LINEREMOVEFROMCONF_LAST = 0x00000002,
    LINEREMOVEFROMCONF_ANY  = 0x00000003,
}

enum : uint
{
    LINEREQUESTMODE_MAKECALL  = 0x00000001,
    LINEREQUESTMODE_MEDIACALL = 0x00000002,
    LINEREQUESTMODE_DROP      = 0x00000004,
}

enum uint LAST_LINEREQUESTMODE = 0x00000002;

enum : uint
{
    LINEROAMMODE_UNKNOWN = 0x00000001,
    LINEROAMMODE_UNAVAIL = 0x00000002,
    LINEROAMMODE_HOME    = 0x00000004,
    LINEROAMMODE_ROAMA   = 0x00000008,
    LINEROAMMODE_ROAMB   = 0x00000010,
}

enum : uint
{
    LINESPECIALINFO_NOCIRCUIT = 0x00000001,
    LINESPECIALINFO_CUSTIRREG = 0x00000002,
    LINESPECIALINFO_REORDER   = 0x00000004,
    LINESPECIALINFO_UNKNOWN   = 0x00000008,
    LINESPECIALINFO_UNAVAIL   = 0x00000010,
}

enum : uint
{
    LINETERMDEV_PHONE          = 0x00000001,
    LINETERMDEV_HEADSET        = 0x00000002,
    LINETERMDEV_SPEAKER        = 0x00000004,
    LINETERMMODE_BUTTONS       = 0x00000001,
    LINETERMMODE_LAMPS         = 0x00000002,
    LINETERMMODE_DISPLAY       = 0x00000004,
    LINETERMMODE_RINGER        = 0x00000008,
    LINETERMMODE_HOOKSWITCH    = 0x00000010,
    LINETERMMODE_MEDIATOLINE   = 0x00000020,
    LINETERMMODE_MEDIAFROMLINE = 0x00000040,
    LINETERMMODE_MEDIABIDIRECT = 0x00000080,
}

enum : uint
{
    LINETERMSHARING_PRIVATE    = 0x00000001,
    LINETERMSHARING_SHAREDEXCL = 0x00000002,
    LINETERMSHARING_SHAREDCONF = 0x00000004,
}

enum : uint
{
    LINETOLLLISTOPTION_ADD    = 0x00000001,
    LINETOLLLISTOPTION_REMOVE = 0x00000002,
}

enum : uint
{
    LINETONEMODE_CUSTOM   = 0x00000001,
    LINETONEMODE_RINGBACK = 0x00000002,
    LINETONEMODE_BUSY     = 0x00000004,
    LINETONEMODE_BEEP     = 0x00000008,
    LINETONEMODE_BILLING  = 0x00000010,
}

enum : uint
{
    LINETRANSFERMODE_TRANSFER   = 0x00000001,
    LINETRANSFERMODE_CONFERENCE = 0x00000002,
}

enum : uint
{
    LINETRANSLATEOPTION_CARDOVERRIDE      = 0x00000001,
    LINETRANSLATEOPTION_CANCELCALLWAITING = 0x00000002,
    LINETRANSLATEOPTION_FORCELOCAL        = 0x00000004,
    LINETRANSLATEOPTION_FORCELD           = 0x00000008,
    LINETRANSLATERESULT_CANONICAL         = 0x00000001,
    LINETRANSLATERESULT_INTERNATIONAL     = 0x00000002,
    LINETRANSLATERESULT_LONGDISTANCE      = 0x00000004,
    LINETRANSLATERESULT_LOCAL             = 0x00000008,
    LINETRANSLATERESULT_INTOLLLIST        = 0x00000010,
    LINETRANSLATERESULT_NOTINTOLLLIST     = 0x00000020,
    LINETRANSLATERESULT_DIALBILLING       = 0x00000040,
    LINETRANSLATERESULT_DIALQUIET         = 0x00000080,
    LINETRANSLATERESULT_DIALDIALTONE      = 0x00000100,
    LINETRANSLATERESULT_DIALPROMPT        = 0x00000200,
    LINETRANSLATERESULT_VOICEDETECT       = 0x00000400,
    LINETRANSLATERESULT_NOTRANSLATION     = 0x00000800,
}

enum : uint
{
    PHONEBUTTONFUNCTION_UNKNOWN      = 0x00000000,
    PHONEBUTTONFUNCTION_CONFERENCE   = 0x00000001,
    PHONEBUTTONFUNCTION_TRANSFER     = 0x00000002,
    PHONEBUTTONFUNCTION_DROP         = 0x00000003,
    PHONEBUTTONFUNCTION_HOLD         = 0x00000004,
    PHONEBUTTONFUNCTION_RECALL       = 0x00000005,
    PHONEBUTTONFUNCTION_DISCONNECT   = 0x00000006,
    PHONEBUTTONFUNCTION_CONNECT      = 0x00000007,
    PHONEBUTTONFUNCTION_MSGWAITON    = 0x00000008,
    PHONEBUTTONFUNCTION_MSGWAITOFF   = 0x00000009,
    PHONEBUTTONFUNCTION_SELECTRING   = 0x0000000a,
    PHONEBUTTONFUNCTION_ABBREVDIAL   = 0x0000000b,
    PHONEBUTTONFUNCTION_FORWARD      = 0x0000000c,
    PHONEBUTTONFUNCTION_PICKUP       = 0x0000000d,
    PHONEBUTTONFUNCTION_RINGAGAIN    = 0x0000000e,
    PHONEBUTTONFUNCTION_PARK         = 0x0000000f,
    PHONEBUTTONFUNCTION_REJECT       = 0x00000010,
    PHONEBUTTONFUNCTION_REDIRECT     = 0x00000011,
    PHONEBUTTONFUNCTION_MUTE         = 0x00000012,
    PHONEBUTTONFUNCTION_VOLUMEUP     = 0x00000013,
    PHONEBUTTONFUNCTION_VOLUMEDOWN   = 0x00000014,
    PHONEBUTTONFUNCTION_SPEAKERON    = 0x00000015,
    PHONEBUTTONFUNCTION_SPEAKEROFF   = 0x00000016,
    PHONEBUTTONFUNCTION_FLASH        = 0x00000017,
    PHONEBUTTONFUNCTION_DATAON       = 0x00000018,
    PHONEBUTTONFUNCTION_DATAOFF      = 0x00000019,
    PHONEBUTTONFUNCTION_DONOTDISTURB = 0x0000001a,
    PHONEBUTTONFUNCTION_INTERCOM     = 0x0000001b,
    PHONEBUTTONFUNCTION_BRIDGEDAPP   = 0x0000001c,
    PHONEBUTTONFUNCTION_BUSY         = 0x0000001d,
    PHONEBUTTONFUNCTION_CALLAPP      = 0x0000001e,
    PHONEBUTTONFUNCTION_DATETIME     = 0x0000001f,
    PHONEBUTTONFUNCTION_DIRECTORY    = 0x00000020,
    PHONEBUTTONFUNCTION_COVER        = 0x00000021,
    PHONEBUTTONFUNCTION_CALLID       = 0x00000022,
    PHONEBUTTONFUNCTION_LASTNUM      = 0x00000023,
    PHONEBUTTONFUNCTION_NIGHTSRV     = 0x00000024,
    PHONEBUTTONFUNCTION_SENDCALLS    = 0x00000025,
    PHONEBUTTONFUNCTION_MSGINDICATOR = 0x00000026,
    PHONEBUTTONFUNCTION_REPDIAL      = 0x00000027,
    PHONEBUTTONFUNCTION_SETREPDIAL   = 0x00000028,
    PHONEBUTTONFUNCTION_SYSTEMSPEED  = 0x00000029,
    PHONEBUTTONFUNCTION_STATIONSPEED = 0x0000002a,
    PHONEBUTTONFUNCTION_CAMPON       = 0x0000002b,
    PHONEBUTTONFUNCTION_SAVEREPEAT   = 0x0000002c,
    PHONEBUTTONFUNCTION_QUEUECALL    = 0x0000002d,
    PHONEBUTTONFUNCTION_NONE         = 0x0000002e,
    PHONEBUTTONFUNCTION_SEND         = 0x0000002f,
    PHONEBUTTONMODE_DUMMY            = 0x00000001,
    PHONEBUTTONMODE_CALL             = 0x00000002,
    PHONEBUTTONMODE_FEATURE          = 0x00000004,
    PHONEBUTTONMODE_KEYPAD           = 0x00000008,
    PHONEBUTTONMODE_LOCAL            = 0x00000010,
    PHONEBUTTONMODE_DISPLAY          = 0x00000020,
    PHONEBUTTONSTATE_UP              = 0x00000001,
    PHONEBUTTONSTATE_DOWN            = 0x00000002,
    PHONEBUTTONSTATE_UNKNOWN         = 0x00000004,
    PHONEBUTTONSTATE_UNAVAIL         = 0x00000008,
}

enum : uint
{
    PHONEERR_ALLOCATED              = 0x90000001,
    PHONEERR_BADDEVICEID            = 0x90000002,
    PHONEERR_INCOMPATIBLEAPIVERSION = 0x90000003,
    PHONEERR_INCOMPATIBLEEXTVERSION = 0x90000004,
}

enum : uint
{
    PHONEERR_INIFILECORRUPT      = 0x90000005,
    PHONEERR_INUSE               = 0x90000006,
    PHONEERR_INVALAPPHANDLE      = 0x90000007,
    PHONEERR_INVALAPPNAME        = 0x90000008,
    PHONEERR_INVALBUTTONLAMPID   = 0x90000009,
    PHONEERR_INVALBUTTONMODE     = 0x9000000a,
    PHONEERR_INVALBUTTONSTATE    = 0x9000000b,
    PHONEERR_INVALDATAID         = 0x9000000c,
    PHONEERR_INVALDEVICECLASS    = 0x9000000d,
    PHONEERR_INVALEXTVERSION     = 0x9000000e,
    PHONEERR_INVALHOOKSWITCHDEV  = 0x9000000f,
    PHONEERR_INVALHOOKSWITCHMODE = 0x90000010,
    PHONEERR_INVALLAMPMODE       = 0x90000011,
    PHONEERR_INVALPARAM          = 0x90000012,
    PHONEERR_INVALPHONEHANDLE    = 0x90000013,
    PHONEERR_INVALPHONESTATE     = 0x90000014,
    PHONEERR_INVALPOINTER        = 0x90000015,
    PHONEERR_INVALPRIVILEGE      = 0x90000016,
    PHONEERR_INVALRINGMODE       = 0x90000017,
    PHONEERR_NODEVICE            = 0x90000018,
    PHONEERR_NODRIVER            = 0x90000019,
    PHONEERR_NOMEM               = 0x9000001a,
    PHONEERR_NOTOWNER            = 0x9000001b,
    PHONEERR_OPERATIONFAILED     = 0x9000001c,
    PHONEERR_OPERATIONUNAVAIL    = 0x9000001d,
}

enum : uint
{
    PHONEERR_RESOURCEUNAVAIL = 0x9000001f,
    PHONEERR_REQUESTOVERRUN  = 0x90000020,
}

enum uint PHONEERR_STRUCTURETOOSMALL = 0x90000021;

enum : uint
{
    PHONEERR_UNINITIALIZED       = 0x90000022,
    PHONEERR_REINIT              = 0x90000023,
    PHONEERR_DISCONNECTED        = 0x90000024,
    PHONEERR_SERVICE_NOT_RUNNING = 0x90000025,
}

enum : uint
{
    PHONEFEATURE_GETBUTTONINFO        = 0x00000001,
    PHONEFEATURE_GETDATA              = 0x00000002,
    PHONEFEATURE_GETDISPLAY           = 0x00000004,
    PHONEFEATURE_GETGAINHANDSET       = 0x00000008,
    PHONEFEATURE_GETGAINSPEAKER       = 0x00000010,
    PHONEFEATURE_GETGAINHEADSET       = 0x00000020,
    PHONEFEATURE_GETHOOKSWITCHHANDSET = 0x00000040,
    PHONEFEATURE_GETHOOKSWITCHSPEAKER = 0x00000080,
    PHONEFEATURE_GETHOOKSWITCHHEADSET = 0x00000100,
    PHONEFEATURE_GETLAMP              = 0x00000200,
    PHONEFEATURE_GETRING              = 0x00000400,
    PHONEFEATURE_GETVOLUMEHANDSET     = 0x00000800,
    PHONEFEATURE_GETVOLUMESPEAKER     = 0x00001000,
    PHONEFEATURE_GETVOLUMEHEADSET     = 0x00002000,
    PHONEFEATURE_SETBUTTONINFO        = 0x00004000,
    PHONEFEATURE_SETDATA              = 0x00008000,
    PHONEFEATURE_SETDISPLAY           = 0x00010000,
    PHONEFEATURE_SETGAINHANDSET       = 0x00020000,
    PHONEFEATURE_SETGAINSPEAKER       = 0x00040000,
    PHONEFEATURE_SETGAINHEADSET       = 0x00080000,
    PHONEFEATURE_SETHOOKSWITCHHANDSET = 0x00100000,
    PHONEFEATURE_SETHOOKSWITCHSPEAKER = 0x00200000,
    PHONEFEATURE_SETHOOKSWITCHHEADSET = 0x00400000,
    PHONEFEATURE_SETLAMP              = 0x00800000,
    PHONEFEATURE_SETRING              = 0x01000000,
    PHONEFEATURE_SETVOLUMEHANDSET     = 0x02000000,
    PHONEFEATURE_SETVOLUMESPEAKER     = 0x04000000,
    PHONEFEATURE_SETVOLUMEHEADSET     = 0x08000000,
    PHONEFEATURE_GENERICPHONE         = 0x10000000,
}

enum : uint
{
    PHONEHOOKSWITCHDEV_HANDSET     = 0x00000001,
    PHONEHOOKSWITCHDEV_SPEAKER     = 0x00000002,
    PHONEHOOKSWITCHDEV_HEADSET     = 0x00000004,
    PHONEHOOKSWITCHMODE_ONHOOK     = 0x00000001,
    PHONEHOOKSWITCHMODE_MIC        = 0x00000002,
    PHONEHOOKSWITCHMODE_SPEAKER    = 0x00000004,
    PHONEHOOKSWITCHMODE_MICSPEAKER = 0x00000008,
    PHONEHOOKSWITCHMODE_UNKNOWN    = 0x00000010,
}

enum : uint
{
    PHONEINITIALIZEEXOPTION_USEHIDDENWINDOW   = 0x00000001,
    PHONEINITIALIZEEXOPTION_USEEVENT          = 0x00000002,
    PHONEINITIALIZEEXOPTION_USECOMPLETIONPORT = 0x00000003,
}

enum : uint
{
    PHONELAMPMODE_DUMMY         = 0x00000001,
    PHONELAMPMODE_OFF           = 0x00000002,
    PHONELAMPMODE_STEADY        = 0x00000004,
    PHONELAMPMODE_WINK          = 0x00000008,
    PHONELAMPMODE_FLASH         = 0x00000010,
    PHONELAMPMODE_FLUTTER       = 0x00000020,
    PHONELAMPMODE_BROKENFLUTTER = 0x00000040,
    PHONELAMPMODE_UNKNOWN       = 0x00000080,
}

enum : uint
{
    PHONEPRIVILEGE_MONITOR = 0x00000001,
    PHONEPRIVILEGE_OWNER   = 0x00000002,
}

enum : uint
{
    PHONESTATE_OTHER             = 0x00000001,
    PHONESTATE_CONNECTED         = 0x00000002,
    PHONESTATE_DISCONNECTED      = 0x00000004,
    PHONESTATE_OWNER             = 0x00000008,
    PHONESTATE_MONITORS          = 0x00000010,
    PHONESTATE_DISPLAY           = 0x00000020,
    PHONESTATE_LAMP              = 0x00000040,
    PHONESTATE_RINGMODE          = 0x00000080,
    PHONESTATE_RINGVOLUME        = 0x00000100,
    PHONESTATE_HANDSETHOOKSWITCH = 0x00000200,
    PHONESTATE_HANDSETVOLUME     = 0x00000400,
    PHONESTATE_HANDSETGAIN       = 0x00000800,
    PHONESTATE_SPEAKERHOOKSWITCH = 0x00001000,
    PHONESTATE_SPEAKERVOLUME     = 0x00002000,
    PHONESTATE_SPEAKERGAIN       = 0x00004000,
    PHONESTATE_HEADSETHOOKSWITCH = 0x00008000,
    PHONESTATE_HEADSETVOLUME     = 0x00010000,
    PHONESTATE_HEADSETGAIN       = 0x00020000,
    PHONESTATE_SUSPEND           = 0x00040000,
    PHONESTATE_RESUME            = 0x00080000,
    PHONESTATE_DEVSPECIFIC       = 0x00100000,
    PHONESTATE_REINIT            = 0x00200000,
    PHONESTATE_CAPSCHANGE        = 0x00400000,
    PHONESTATE_REMOVED           = 0x00800000,
    PHONESTATUSFLAGS_CONNECTED   = 0x00000001,
    PHONESTATUSFLAGS_SUSPENDED   = 0x00000002,
}

enum : uint
{
    STRINGFORMAT_ASCII   = 0x00000001,
    STRINGFORMAT_DBCS    = 0x00000002,
    STRINGFORMAT_UNICODE = 0x00000003,
    STRINGFORMAT_BINARY  = 0x00000004,
}

enum uint TAPI_REPLY = 0x00000463;

enum : int
{
    TAPIERR_CONNECTED          = 0x00000000,
    TAPIERR_DROPPED            = 0xffffffff,
    TAPIERR_NOREQUESTRECIPIENT = 0xfffffffe,
}

enum int TAPIERR_REQUESTQUEUEFULL = 0xfffffffd;

enum : int
{
    TAPIERR_INVALDESTADDRESS  = 0xfffffffc,
    TAPIERR_INVALWINDOWHANDLE = 0xfffffffb,
    TAPIERR_INVALDEVICECLASS  = 0xfffffffa,
    TAPIERR_INVALDEVICEID     = 0xfffffff9,
}

enum : int
{
    TAPIERR_DEVICECLASSUNAVAIL = 0xfffffff8,
    TAPIERR_DEVICEIDUNAVAIL    = 0xfffffff7,
    TAPIERR_DEVICEINUSE        = 0xfffffff6,
    TAPIERR_DESTBUSY           = 0xfffffff5,
    TAPIERR_DESTNOANSWER       = 0xfffffff4,
    TAPIERR_DESTUNAVAIL        = 0xfffffff3,
    TAPIERR_UNKNOWNWINHANDLE   = 0xfffffff2,
    TAPIERR_UNKNOWNREQUESTID   = 0xfffffff1,
}

enum : int
{
    TAPIERR_REQUESTFAILED    = 0xfffffff0,
    TAPIERR_REQUESTCANCELLED = 0xffffffef,
}

enum int TAPIERR_INVALPOINTER = 0xffffffee;

enum : int
{
    TAPIERR_NOTADMIN       = 0xffffffed,
    TAPIERR_MMCWRITELOCKED = 0xffffffec,
}

enum int TAPIERR_PROVIDERALREADYINSTALLED = 0xffffffeb;

enum : int
{
    TAPIERR_SCP_ALREADY_EXISTS = 0xffffffea,
    TAPIERR_SCP_DOES_NOT_EXIST = 0xffffffe9,
}

enum int TAPIMAXDESTADDRESSSIZE = 0x00000050;
enum int TAPIMAXAPPNAMESIZE = 0x00000028;
enum int TAPIMAXCALLEDPARTYSIZE = 0x00000028;
enum int TAPIMAXCOMMENTSIZE = 0x00000050;

enum : int
{
    TAPIMAXDEVICECLASSSIZE = 0x00000028,
    TAPIMAXDEVICEIDSIZE    = 0x00000028,
}

enum uint INTERFACEMASK = 0x00ff0000;
enum uint DISPIDMASK = 0x0000ffff;

enum : uint
{
    IDISPTAPI           = 0x00010000,
    IDISPTAPICALLCENTER = 0x00020000,
}

enum uint IDISPCALLINFO = 0x00010000;
enum uint IDISPBASICCALLCONTROL = 0x00020000;
enum uint IDISPLEGACYCALLMEDIACONTROL = 0x00030000;
enum uint IDISPAGGREGATEDMSPCALLOBJ = 0x00040000;

enum : uint
{
    IDISPADDRESS             = 0x00010000,
    IDISPADDRESSCAPABILITIES = 0x00020000,
}

enum uint IDISPMEDIASUPPORT = 0x00030000;
enum uint IDISPADDRESSTRANSLATION = 0x00040000;
enum uint IDISPLEGACYADDRESSMEDIACONTROL = 0x00050000;
enum uint IDISPAGGREGATEDMSPADDRESSOBJ = 0x00060000;

enum : uint
{
    IDISPPHONE      = 0x00010000,
    IDISPAPC        = 0x00020000,
    IDISPMULTITRACK = 0x00010000,
}

enum : uint
{
    IDISPMEDIACONTROL  = 0x00020000,
    IDISPMEDIARECORD   = 0x00030000,
    IDISPMEDIAPLAYBACK = 0x00040000,
}

enum uint IDISPFILETRACK = 0x00010000;

enum : uint
{
    TAPIMEDIATYPE_AUDIO      = 0x00000008,
    TAPIMEDIATYPE_VIDEO      = 0x00008000,
    TAPIMEDIATYPE_DATAMODEM  = 0x00000010,
    TAPIMEDIATYPE_G3FAX      = 0x00000020,
    TAPIMEDIATYPE_MULTITRACK = 0x00010000,
}

enum uint TSPI_MESSAGE_BASE = 0x000001f4;
enum uint LINETSPIOPTION_NONREENTRANT = 0x00000001;

enum : int
{
    TUISPIDLL_OBJECT_LINEID         = 0x00000001,
    TUISPIDLL_OBJECT_PHONEID        = 0x00000002,
    TUISPIDLL_OBJECT_PROVIDERID     = 0x00000003,
    TUISPIDLL_OBJECT_DIALOGINSTANCE = 0x00000004,
}

enum : uint
{
    PRIVATEOBJECT_NONE    = 0x00000001,
    PRIVATEOBJECT_CALLID  = 0x00000002,
    PRIVATEOBJECT_LINE    = 0x00000003,
    PRIVATEOBJECT_CALL    = 0x00000004,
    PRIVATEOBJECT_PHONE   = 0x00000005,
    PRIVATEOBJECT_ADDRESS = 0x00000006,
}

enum uint LINEQOSREQUESTTYPE_SERVICELEVEL = 0x00000001;

enum : uint
{
    LINEQOSSERVICELEVEL_NEEDED      = 0x00000001,
    LINEQOSSERVICELEVEL_IFAVAILABLE = 0x00000002,
    LINEQOSSERVICELEVEL_BESTEFFORT  = 0x00000003,
}

enum : uint
{
    LINEEQOSINFO_NOQOS            = 0x00000001,
    LINEEQOSINFO_ADMISSIONFAILURE = 0x00000002,
    LINEEQOSINFO_POLICYFAILURE    = 0x00000003,
    LINEEQOSINFO_GENERICERROR     = 0x00000004,
}

enum uint TSPI_PROC_BASE = 0x000001f4;

enum : uint
{
    TSPI_LINEACCEPT                    = 0x000001f4,
    TSPI_LINEADDTOCONFERENCE           = 0x000001f5,
    TSPI_LINEANSWER                    = 0x000001f6,
    TSPI_LINEBLINDTRANSFER             = 0x000001f7,
    TSPI_LINECLOSE                     = 0x000001f8,
    TSPI_LINECLOSECALL                 = 0x000001f9,
    TSPI_LINECOMPLETECALL              = 0x000001fa,
    TSPI_LINECOMPLETETRANSFER          = 0x000001fb,
    TSPI_LINECONDITIONALMEDIADETECTION = 0x000001fc,
}

enum : uint
{
    TSPI_LINECONFIGDIALOG       = 0x000001fd,
    TSPI_LINEDEVSPECIFIC        = 0x000001fe,
    TSPI_LINEDEVSPECIFICFEATURE = 0x000001ff,
}

enum : uint
{
    TSPI_LINEDIAL             = 0x00000200,
    TSPI_LINEDROP             = 0x00000201,
    TSPI_LINEFORWARD          = 0x00000202,
    TSPI_LINEGATHERDIGITS     = 0x00000203,
    TSPI_LINEGENERATEDIGITS   = 0x00000204,
    TSPI_LINEGENERATETONE     = 0x00000205,
    TSPI_LINEGETADDRESSCAPS   = 0x00000206,
    TSPI_LINEGETADDRESSID     = 0x00000207,
    TSPI_LINEGETADDRESSSTATUS = 0x00000208,
    TSPI_LINEGETCALLADDRESSID = 0x00000209,
    TSPI_LINEGETCALLINFO      = 0x0000020a,
    TSPI_LINEGETCALLSTATUS    = 0x0000020b,
    TSPI_LINEGETDEVCAPS       = 0x0000020c,
    TSPI_LINEGETDEVCONFIG     = 0x0000020d,
    TSPI_LINEGETEXTENSIONID   = 0x0000020e,
    TSPI_LINEGETICON          = 0x0000020f,
    TSPI_LINEGETID            = 0x00000210,
    TSPI_LINEGETLINEDEVSTATUS = 0x00000211,
    TSPI_LINEGETNUMADDRESSIDS = 0x00000212,
}

enum : uint
{
    TSPI_LINEHOLD                 = 0x00000213,
    TSPI_LINEMAKECALL             = 0x00000214,
    TSPI_LINEMONITORDIGITS        = 0x00000215,
    TSPI_LINEMONITORMEDIA         = 0x00000216,
    TSPI_LINEMONITORTONES         = 0x00000217,
    TSPI_LINENEGOTIATEEXTVERSION  = 0x00000218,
    TSPI_LINENEGOTIATETSPIVERSION = 0x00000219,
}

enum : uint
{
    TSPI_LINEOPEN                   = 0x0000021a,
    TSPI_LINEPARK                   = 0x0000021b,
    TSPI_LINEPICKUP                 = 0x0000021c,
    TSPI_LINEPREPAREADDTOCONFERENCE = 0x0000021d,
}

enum : uint
{
    TSPI_LINEREDIRECT             = 0x0000021e,
    TSPI_LINEREMOVEFROMCONFERENCE = 0x0000021f,
}

enum : uint
{
    TSPI_LINESECURECALL               = 0x00000220,
    TSPI_LINESELECTEXTVERSION         = 0x00000221,
    TSPI_LINESENDUSERUSERINFO         = 0x00000222,
    TSPI_LINESETAPPSPECIFIC           = 0x00000223,
    TSPI_LINESETCALLPARAMS            = 0x00000224,
    TSPI_LINESETDEFAULTMEDIADETECTION = 0x00000225,
    TSPI_LINESETDEVCONFIG             = 0x00000226,
    TSPI_LINESETMEDIACONTROL          = 0x00000227,
    TSPI_LINESETMEDIAMODE             = 0x00000228,
    TSPI_LINESETSTATUSMESSAGES        = 0x00000229,
    TSPI_LINESETTERMINAL              = 0x0000022a,
    TSPI_LINESETUPCONFERENCE          = 0x0000022b,
    TSPI_LINESETUPTRANSFER            = 0x0000022c,
    TSPI_LINESWAPHOLD                 = 0x0000022d,
    TSPI_LINEUNCOMPLETECALL           = 0x0000022e,
    TSPI_LINEUNHOLD                   = 0x0000022f,
    TSPI_LINEUNPARK                   = 0x00000230,
}

enum : uint
{
    TSPI_PHONECLOSE                = 0x00000231,
    TSPI_PHONECONFIGDIALOG         = 0x00000232,
    TSPI_PHONEDEVSPECIFIC          = 0x00000233,
    TSPI_PHONEGETBUTTONINFO        = 0x00000234,
    TSPI_PHONEGETDATA              = 0x00000235,
    TSPI_PHONEGETDEVCAPS           = 0x00000236,
    TSPI_PHONEGETDISPLAY           = 0x00000237,
    TSPI_PHONEGETEXTENSIONID       = 0x00000238,
    TSPI_PHONEGETGAIN              = 0x00000239,
    TSPI_PHONEGETHOOKSWITCH        = 0x0000023a,
    TSPI_PHONEGETICON              = 0x0000023b,
    TSPI_PHONEGETID                = 0x0000023c,
    TSPI_PHONEGETLAMP              = 0x0000023d,
    TSPI_PHONEGETRING              = 0x0000023e,
    TSPI_PHONEGETSTATUS            = 0x0000023f,
    TSPI_PHONEGETVOLUME            = 0x00000240,
    TSPI_PHONENEGOTIATEEXTVERSION  = 0x00000241,
    TSPI_PHONENEGOTIATETSPIVERSION = 0x00000242,
}

enum : uint
{
    TSPI_PHONEOPEN              = 0x00000243,
    TSPI_PHONESELECTEXTVERSION  = 0x00000244,
    TSPI_PHONESETBUTTONINFO     = 0x00000245,
    TSPI_PHONESETDATA           = 0x00000246,
    TSPI_PHONESETDISPLAY        = 0x00000247,
    TSPI_PHONESETGAIN           = 0x00000248,
    TSPI_PHONESETHOOKSWITCH     = 0x00000249,
    TSPI_PHONESETLAMP           = 0x0000024a,
    TSPI_PHONESETRING           = 0x0000024b,
    TSPI_PHONESETSTATUSMESSAGES = 0x0000024c,
    TSPI_PHONESETVOLUME         = 0x0000024d,
}

enum : uint
{
    TSPI_PROVIDERCONFIG      = 0x0000024e,
    TSPI_PROVIDERINIT        = 0x0000024f,
    TSPI_PROVIDERINSTALL     = 0x00000250,
    TSPI_PROVIDERREMOVE      = 0x00000251,
    TSPI_PROVIDERSHUTDOWN    = 0x00000252,
    TSPI_PROVIDERENUMDEVICES = 0x00000253,
}

enum : uint
{
    TSPI_LINEDROPONCLOSE = 0x00000254,
    TSPI_LINEDROPNOOWNER = 0x00000255,
}

enum : uint
{
    TSPI_PROVIDERCREATELINEDEVICE  = 0x00000256,
    TSPI_PROVIDERCREATEPHONEDEVICE = 0x00000257,
}

enum uint TSPI_LINESETCURRENTLOCATION = 0x00000258;
enum uint TSPI_LINECONFIGDIALOGEDIT = 0x00000259;
enum uint TSPI_LINERELEASEUSERUSERINFO = 0x0000025a;

enum : uint
{
    TSPI_LINEGETCALLID          = 0x0000025b,
    TSPI_LINEGETCALLHUBTRACKING = 0x0000025c,
}

enum uint TSPI_LINESETCALLHUBTRACKING = 0x0000025d;
enum uint TSPI_LINERECEIVEMSPDATA = 0x0000025e;

enum : uint
{
    TSPI_LINEMSPIDENTIFY       = 0x0000025f,
    TSPI_LINECREATEMSPINSTANCE = 0x00000260,
}

enum uint TSPI_LINECLOSEMSPINSTANCE = 0x00000261;

enum : uint
{
    IDISPDIROBJECT        = 0x00010000,
    IDISPDIROBJCONFERENCE = 0x00020000,
    IDISPDIROBJUSER       = 0x00030000,
    IDISPDIRECTORY        = 0x00010000,
}

enum uint IDISPILSCONFIG = 0x00020000;

enum : uint
{
    RENDBIND_AUTHENTICATE       = 0x00000001,
    RENDBIND_DEFAULTDOMAINNAME  = 0x00000002,
    RENDBIND_DEFAULTUSERNAME    = 0x00000004,
    RENDBIND_DEFAULTPASSWORD    = 0x00000008,
    RENDBIND_DEFAULTCREDENTIALS = 0x0000000e,
}

enum : uint
{
    STRM_INITIAL          = 0x00000000,
    STRM_TERMINALSELECTED = 0x00000001,
}

enum uint STRM_CONFIGURED = 0x00000002;

enum : uint
{
    STRM_RUNNING = 0x00000004,
    STRM_PAUSED  = 0x00000008,
    STRM_STOPPED = 0x00000010,
}

enum : HRESULT
{
    TAPI_E_NOTENOUGHMEMORY = HRESULT(0x80040001),
    TAPI_E_NOITEMS         = HRESULT(0x80040002),
    TAPI_E_NOTSUPPORTED    = HRESULT(0x80040003),
}

enum HRESULT TAPI_E_INVALIDMEDIATYPE = HRESULT(0x80040004);
enum HRESULT TAPI_E_OPERATIONFAILED = HRESULT(0x80040005);

enum : HRESULT
{
    TAPI_E_ALLOCATED         = HRESULT(0x80040006),
    TAPI_E_CALLUNAVAIL       = HRESULT(0x80040007),
    TAPI_E_COMPLETIONOVERRUN = HRESULT(0x80040008),
}

enum HRESULT TAPI_E_CONFERENCEFULL = HRESULT(0x80040009);
enum HRESULT TAPI_E_DIALMODIFIERNOTSUPPORTED = HRESULT(0x8004000a);

enum : HRESULT
{
    TAPI_E_INUSE              = HRESULT(0x8004000b),
    TAPI_E_INVALADDRESS       = HRESULT(0x8004000c),
    TAPI_E_INVALADDRESSSTATE  = HRESULT(0x8004000d),
    TAPI_E_INVALCALLPARAMS    = HRESULT(0x8004000e),
    TAPI_E_INVALCALLPRIVILEGE = HRESULT(0x8004000f),
    TAPI_E_INVALCALLSTATE     = HRESULT(0x80040010),
    TAPI_E_INVALCARD          = HRESULT(0x80040011),
    TAPI_E_INVALCOMPLETIONID  = HRESULT(0x80040012),
    TAPI_E_INVALCOUNTRYCODE   = HRESULT(0x80040013),
    TAPI_E_INVALDEVICECLASS   = HRESULT(0x80040014),
    TAPI_E_INVALDIALPARAMS    = HRESULT(0x80040015),
    TAPI_E_INVALDIGITS        = HRESULT(0x80040016),
    TAPI_E_INVALGROUPID       = HRESULT(0x80040017),
    TAPI_E_INVALLOCATION      = HRESULT(0x80040018),
    TAPI_E_INVALMESSAGEID     = HRESULT(0x80040019),
    TAPI_E_INVALPARKID        = HRESULT(0x8004001a),
    TAPI_E_INVALRATE          = HRESULT(0x8004001b),
    TAPI_E_INVALTIMEOUT       = HRESULT(0x8004001c),
    TAPI_E_INVALTONE          = HRESULT(0x8004001d),
    TAPI_E_INVALLIST          = HRESULT(0x8004001e),
    TAPI_E_INVALMODE          = HRESULT(0x8004001f),
    TAPI_E_NOCONFERENCE       = HRESULT(0x80040020),
    TAPI_E_NODEVICE           = HRESULT(0x80040021),
    TAPI_E_NOREQUEST          = HRESULT(0x80040022),
    TAPI_E_NOTOWNER           = HRESULT(0x80040023),
    TAPI_E_NOTREGISTERED      = HRESULT(0x80040024),
}

enum HRESULT TAPI_E_REQUESTOVERRUN = HRESULT(0x80040025);

enum : HRESULT
{
    TAPI_E_TARGETNOTFOUND     = HRESULT(0x80040026),
    TAPI_E_TARGETSELF         = HRESULT(0x80040027),
    TAPI_E_USERUSERINFOTOOBIG = HRESULT(0x80040028),
}

enum : HRESULT
{
    TAPI_E_REINIT         = HRESULT(0x80040029),
    TAPI_E_ADDRESSBLOCKED = HRESULT(0x8004002a),
}

enum HRESULT TAPI_E_BILLINGREJECTED = HRESULT(0x8004002b);

enum : HRESULT
{
    TAPI_E_INVALFEATURE       = HRESULT(0x8004002c),
    TAPI_E_INVALBUTTONLAMPID  = HRESULT(0x8004002d),
    TAPI_E_INVALBUTTONSTATE   = HRESULT(0x8004002e),
    TAPI_E_INVALDATAID        = HRESULT(0x8004002f),
    TAPI_E_INVALHOOKSWITCHDEV = HRESULT(0x80040030),
}

enum : HRESULT
{
    TAPI_E_DROPPED            = HRESULT(0x80040031),
    TAPI_E_NOREQUESTRECIPIENT = HRESULT(0x80040032),
}

enum HRESULT TAPI_E_REQUESTQUEUEFULL = HRESULT(0x80040033);

enum : HRESULT
{
    TAPI_E_DESTBUSY     = HRESULT(0x80040034),
    TAPI_E_DESTNOANSWER = HRESULT(0x80040035),
    TAPI_E_DESTUNAVAIL  = HRESULT(0x80040036),
}

enum : HRESULT
{
    TAPI_E_REQUESTFAILED    = HRESULT(0x80040037),
    TAPI_E_REQUESTCANCELLED = HRESULT(0x80040038),
}

enum : HRESULT
{
    TAPI_E_INVALPRIVILEGE       = HRESULT(0x80040039),
    TAPI_E_INVALIDDIRECTION     = HRESULT(0x8004003a),
    TAPI_E_INVALIDTERMINAL      = HRESULT(0x8004003b),
    TAPI_E_INVALIDTERMINALCLASS = HRESULT(0x8004003c),
}

enum : HRESULT
{
    TAPI_E_NODRIVER           = HRESULT(0x8004003d),
    TAPI_E_MAXSTREAMS         = HRESULT(0x8004003e),
    TAPI_E_NOTERMINALSELECTED = HRESULT(0x8004003f),
}

enum HRESULT TAPI_E_TERMINALINUSE = HRESULT(0x80040040);

enum : HRESULT
{
    TAPI_E_NOTSTOPPED   = HRESULT(0x80040041),
    TAPI_E_MAXTERMINALS = HRESULT(0x80040042),
}

enum HRESULT TAPI_E_INVALIDSTREAM = HRESULT(0x80040043);

enum : HRESULT
{
    TAPI_E_TIMEOUT                       = HRESULT(0x80040044),
    TAPI_E_CALLCENTER_GROUP_REMOVED      = HRESULT(0x80040045),
    TAPI_E_CALLCENTER_QUEUE_REMOVED      = HRESULT(0x80040046),
    TAPI_E_CALLCENTER_NO_AGENT_ID        = HRESULT(0x80040047),
    TAPI_E_CALLCENTER_INVALAGENTID       = HRESULT(0x80040048),
    TAPI_E_CALLCENTER_INVALAGENTGROUP    = HRESULT(0x80040049),
    TAPI_E_CALLCENTER_INVALPASSWORD      = HRESULT(0x8004004a),
    TAPI_E_CALLCENTER_INVALAGENTSTATE    = HRESULT(0x8004004b),
    TAPI_E_CALLCENTER_INVALAGENTACTIVITY = HRESULT(0x8004004c),
}

enum HRESULT TAPI_E_REGISTRY_SETTING_CORRUPT = HRESULT(0x8004004d);
enum HRESULT TAPI_E_TERMINAL_PEER = HRESULT(0x8004004e);
enum HRESULT TAPI_E_PEER_NOT_SET = HRESULT(0x8004004f);

enum : HRESULT
{
    TAPI_E_NOEVENT          = HRESULT(0x80040050),
    TAPI_E_INVALADDRESSTYPE = HRESULT(0x80040051),
}

enum HRESULT TAPI_E_RESOURCEUNAVAIL = HRESULT(0x80040052);
enum HRESULT TAPI_E_PHONENOTOPEN = HRESULT(0x80040053);
enum HRESULT TAPI_E_CALLNOTSELECTED = HRESULT(0x80040054);

enum : HRESULT
{
    TAPI_E_WRONGEVENT         = HRESULT(0x80040055),
    TAPI_E_NOFORMAT           = HRESULT(0x80040056),
    TAPI_E_INVALIDSTREAMSTATE = HRESULT(0x80040057),
}

enum HRESULT TAPI_E_WRONG_STATE = HRESULT(0x80040058);
enum HRESULT TAPI_E_NOT_INITIALIZED = HRESULT(0x80040059);
enum HRESULT TAPI_E_SERVICE_NOT_RUNNING = HRESULT(0x8004005a);

enum : /*FIELD ATTR: NativeEncodingAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ansi))], [])*/const(wchar)*
{
    OPENTNEFSTREAM   = "OpenTnefStream",
    OPENTNEFSTREAMEX = "OpenTnefStreamEx",
}

enum /*FIELD ATTR: NativeEncodingAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ansi))], [])*/const(wchar)* GETTNEFSTREAMCODEPAGE = "GetTnefStreamCodePage";
enum uint cbDisplayName = 0x00000029;
enum uint cbEmailName = 0x0000000b;
enum uint cbSeverName = 0x0000000c;
enum uint cbTYPE = 0x00000010;
enum uint cbMaxIdData = 0x000000c8;

enum : uint
{
    prioLow  = 0x00000003,
    prioNorm = 0x00000002,
    prioHigh = 0x00000001,
}

enum : int
{
    atypNull    = 0x00000000,
    atypFile    = 0x00000001,
    atypOle     = 0x00000002,
    atypPicture = 0x00000003,
}

enum int atypMax = 0x00000004;

// Callbacks

alias LINECALLBACK = void function(uint hDevice, uint dwMessage, size_t dwInstance, size_t dwParam1, 
                                   size_t dwParam2, size_t dwParam3);
alias PHONECALLBACK = void function(uint hDevice, uint dwMessage, size_t dwInstance, size_t dwParam1, 
                                    size_t dwParam2, size_t dwParam3);
alias ASYNC_COMPLETION = void function(uint dwRequestID, int lResult);
alias LINEEVENT = void function(HTAPILINE htLine, HTAPICALL htCall, uint dwMsg, size_t dwParam1, size_t dwParam2, 
                                size_t dwParam3);
alias PHONEEVENT = void function(HTAPIPHONE htPhone, uint dwMsg, size_t dwParam1, size_t dwParam2, size_t dwParam3);
alias TUISPIDLLCALLBACK = int function(size_t dwObjectID, uint dwObjectType, void* lpParams, uint dwSize);
alias LPOPENTNEFSTREAM = HRESULT function(void* lpvSupport, IStream lpStream, byte* lpszStreamName, uint ulFlags, 
                                          IMessage lpMessage, ushort wKeyVal, ITnef* lppTNEF);
alias LPOPENTNEFSTREAMEX = HRESULT function(void* lpvSupport, IStream lpStream, byte* lpszStreamName, uint ulFlags, 
                                            IMessage lpMessage, ushort wKeyVal, IAddrBook lpAdressBook, 
                                            ITnef* lppTNEF);
alias LPGETTNEFSTREAMCODEPAGE = HRESULT function(IStream lpStream, uint* lpulCodepage, uint* lpulSubCodepage);

// Structs


struct HDRVCALL
{
    void* Value;
}

struct HDRVLINE
{
    void* Value;
}

struct HDRVPHONE
{
    void* Value;
}

struct HDRVMSPLINE
{
    void* Value;
}

struct HDRVDIALOGINSTANCE
{
    void* Value;
}

struct HTAPICALL
{
    void* Value;
}

struct HTAPILINE
{
    void* Value;
}

struct HTAPIPHONE
{
    void* Value;
}

struct HPROVIDER
{
    void* Value;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-lineaddresscaps))], [])
struct LINEADDRESSCAPS
{
align (1):
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwLineDeviceID;
    uint dwAddressSize;
    uint dwAddressOffset;
    uint dwDevSpecificSize;
    uint dwDevSpecificOffset;
    uint dwAddressSharing;
    uint dwAddressStates;
    uint dwCallInfoStates;
    uint dwCallerIDFlags;
    uint dwCalledIDFlags;
    uint dwConnectedIDFlags;
    uint dwRedirectionIDFlags;
    uint dwRedirectingIDFlags;
    uint dwCallStates;
    uint dwDialToneModes;
    uint dwBusyModes;
    uint dwSpecialInfo;
    uint dwDisconnectModes;
    uint dwMaxNumActiveCalls;
    uint dwMaxNumOnHoldCalls;
    uint dwMaxNumOnHoldPendingCalls;
    uint dwMaxNumConference;
    uint dwMaxNumTransConf;
    uint dwAddrCapFlags;
    uint dwCallFeatures;
    uint dwRemoveFromConfCaps;
    uint dwRemoveFromConfState;
    uint dwTransferModes;
    uint dwParkModes;
    uint dwForwardModes;
    uint dwMaxForwardEntries;
    uint dwMaxSpecificEntries;
    uint dwMinFwdNumRings;
    uint dwMaxFwdNumRings;
    uint dwMaxCallCompletions;
    uint dwCallCompletionConds;
    uint dwCallCompletionModes;
    uint dwNumCompletionMessages;
    uint dwCompletionMsgTextEntrySize;
    uint dwCompletionMsgTextSize;
    uint dwCompletionMsgTextOffset;
    uint dwAddressFeatures;
    uint dwPredictiveAutoTransferStates;
    uint dwNumCallTreatments;
    uint dwCallTreatmentListSize;
    uint dwCallTreatmentListOffset;
    uint dwDeviceClassesSize;
    uint dwDeviceClassesOffset;
    uint dwMaxCallDataSize;
    uint dwCallFeatures2;
    uint dwMaxNoAnswerTimeout;
    uint dwConnectedModes;
    uint dwOfferingModes;
    uint dwAvailableMediaModes;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-lineaddressstatus))], [])
struct LINEADDRESSSTATUS
{
align (1):
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwNumInUse;
    uint dwNumActiveCalls;
    uint dwNumOnHoldCalls;
    uint dwNumOnHoldPendCalls;
    uint dwAddressFeatures;
    uint dwNumRingsNoAnswer;
    uint dwForwardNumEntries;
    uint dwForwardSize;
    uint dwForwardOffset;
    uint dwTerminalModesSize;
    uint dwTerminalModesOffset;
    uint dwDevSpecificSize;
    uint dwDevSpecificOffset;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-lineagentactivityentry))], [])
struct LINEAGENTACTIVITYENTRY
{
align (1):
    uint dwID;
    uint dwNameSize;
    uint dwNameOffset;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-lineagentactivitylist))], [])
struct LINEAGENTACTIVITYLIST
{
align (1):
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwNumEntries;
    uint dwListSize;
    uint dwListOffset;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-lineagentcaps))], [])
struct LINEAGENTCAPS
{
align (1):
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwAgentHandlerInfoSize;
    uint dwAgentHandlerInfoOffset;
    uint dwCapsVersion;
    uint dwFeatures;
    uint dwStates;
    uint dwNextStates;
    uint dwMaxNumGroupEntries;
    uint dwAgentStatusMessages;
    uint dwNumAgentExtensionIDs;
    uint dwAgentExtensionIDListSize;
    uint dwAgentExtensionIDListOffset;
    GUID ProxyGUID;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-lineagentgroupentry))], [])
struct LINEAGENTGROUPENTRY
{
align (1):
    _GroupID_e__Struct GroupID;
    uint               dwNameSize;
    uint               dwNameOffset;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-lineagentgrouplist))], [])
struct LINEAGENTGROUPLIST
{
align (1):
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwNumEntries;
    uint dwListSize;
    uint dwListOffset;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-lineagentstatus))], [])
struct LINEAGENTSTATUS
{
align (1):
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwNumEntries;
    uint dwGroupListSize;
    uint dwGroupListOffset;
    uint dwState;
    uint dwNextState;
    uint dwActivityID;
    uint dwActivitySize;
    uint dwActivityOffset;
    uint dwAgentFeatures;
    uint dwValidStates;
    uint dwValidNextStates;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-lineappinfo))], [])
struct LINEAPPINFO
{
align (1):
    uint dwMachineNameSize;
    uint dwMachineNameOffset;
    uint dwUserNameSize;
    uint dwUserNameOffset;
    uint dwModuleFilenameSize;
    uint dwModuleFilenameOffset;
    uint dwFriendlyNameSize;
    uint dwFriendlyNameOffset;
    uint dwMediaModes;
    uint dwAddressID;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-lineagententry))], [])
struct LINEAGENTENTRY
{
align (1):
    uint hAgent;
    uint dwNameSize;
    uint dwNameOffset;
    uint dwIDSize;
    uint dwIDOffset;
    uint dwPINSize;
    uint dwPINOffset;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-lineagentlist))], [])
struct LINEAGENTLIST
{
align (1):
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwNumEntries;
    uint dwListSize;
    uint dwListOffset;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-lineagentinfo))], [])
struct LINEAGENTINFO
{
align (1):
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwAgentState;
    uint dwNextAgentState;
    uint dwMeasurementPeriod;
    CY   cyOverallCallRate;
    uint dwNumberOfACDCalls;
    uint dwNumberOfIncomingCalls;
    uint dwNumberOfOutgoingCalls;
    uint dwTotalACDTalkTime;
    uint dwTotalACDCallTime;
    uint dwTotalACDWrapUpTime;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-lineagentsessionentry))], [])
struct LINEAGENTSESSIONENTRY
{
align (1):
    uint hAgentSession;
    uint hAgent;
    GUID GroupID;
    uint dwWorkingAddressID;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-lineagentsessionlist))], [])
struct LINEAGENTSESSIONLIST
{
align (1):
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwNumEntries;
    uint dwListSize;
    uint dwListOffset;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-lineagentsessioninfo))], [])
struct LINEAGENTSESSIONINFO
{
align (1):
    uint   dwTotalSize;
    uint   dwNeededSize;
    uint   dwUsedSize;
    uint   dwAgentSessionState;
    uint   dwNextAgentSessionState;
    double dateSessionStartTime;
    uint   dwSessionDuration;
    uint   dwNumberOfCalls;
    uint   dwTotalTalkTime;
    uint   dwAverageTalkTime;
    uint   dwTotalCallTime;
    uint   dwAverageCallTime;
    uint   dwTotalWrapUpTime;
    uint   dwAverageWrapUpTime;
    CY     cyACDCallRate;
    uint   dwLongestTimeToAnswer;
    uint   dwAverageTimeToAnswer;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linequeueentry))], [])
struct LINEQUEUEENTRY
{
align (1):
    uint dwQueueID;
    uint dwNameSize;
    uint dwNameOffset;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linequeuelist))], [])
struct LINEQUEUELIST
{
align (1):
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwNumEntries;
    uint dwListSize;
    uint dwListOffset;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linequeueinfo))], [])
struct LINEQUEUEINFO
{
align (1):
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwMeasurementPeriod;
    uint dwTotalCallsQueued;
    uint dwCurrentCallsQueued;
    uint dwTotalCallsAbandoned;
    uint dwTotalCallsFlowedIn;
    uint dwTotalCallsFlowedOut;
    uint dwLongestEverWaitTime;
    uint dwCurrentLongestWaitTime;
    uint dwAverageWaitTime;
    uint dwFinalDisposition;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-lineproxyrequestlist))], [])
struct LINEPROXYREQUESTLIST
{
align (1):
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwNumEntries;
    uint dwListSize;
    uint dwListOffset;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linedialparams))], [])
struct LINEDIALPARAMS
{
align (1):
    uint dwDialPause;
    uint dwDialSpeed;
    uint dwDigitDuration;
    uint dwWaitForDialtone;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linecallinfo))], [])
struct LINECALLINFO
{
align (1):
    uint           dwTotalSize;
    uint           dwNeededSize;
    uint           dwUsedSize;
    uint           hLine;
    uint           dwLineDeviceID;
    uint           dwAddressID;
    uint           dwBearerMode;
    uint           dwRate;
    uint           dwMediaMode;
    uint           dwAppSpecific;
    uint           dwCallID;
    uint           dwRelatedCallID;
    uint           dwCallParamFlags;
    uint           dwCallStates;
    uint           dwMonitorDigitModes;
    uint           dwMonitorMediaModes;
    LINEDIALPARAMS DialParams;
    uint           dwOrigin;
    uint           dwReason;
    uint           dwCompletionID;
    uint           dwNumOwners;
    uint           dwNumMonitors;
    uint           dwCountryCode;
    uint           dwTrunk;
    uint           dwCallerIDFlags;
    uint           dwCallerIDSize;
    uint           dwCallerIDOffset;
    uint           dwCallerIDNameSize;
    uint           dwCallerIDNameOffset;
    uint           dwCalledIDFlags;
    uint           dwCalledIDSize;
    uint           dwCalledIDOffset;
    uint           dwCalledIDNameSize;
    uint           dwCalledIDNameOffset;
    uint           dwConnectedIDFlags;
    uint           dwConnectedIDSize;
    uint           dwConnectedIDOffset;
    uint           dwConnectedIDNameSize;
    uint           dwConnectedIDNameOffset;
    uint           dwRedirectionIDFlags;
    uint           dwRedirectionIDSize;
    uint           dwRedirectionIDOffset;
    uint           dwRedirectionIDNameSize;
    uint           dwRedirectionIDNameOffset;
    uint           dwRedirectingIDFlags;
    uint           dwRedirectingIDSize;
    uint           dwRedirectingIDOffset;
    uint           dwRedirectingIDNameSize;
    uint           dwRedirectingIDNameOffset;
    uint           dwAppNameSize;
    uint           dwAppNameOffset;
    uint           dwDisplayableAddressSize;
    uint           dwDisplayableAddressOffset;
    uint           dwCalledPartySize;
    uint           dwCalledPartyOffset;
    uint           dwCommentSize;
    uint           dwCommentOffset;
    uint           dwDisplaySize;
    uint           dwDisplayOffset;
    uint           dwUserUserInfoSize;
    uint           dwUserUserInfoOffset;
    uint           dwHighLevelCompSize;
    uint           dwHighLevelCompOffset;
    uint           dwLowLevelCompSize;
    uint           dwLowLevelCompOffset;
    uint           dwChargingInfoSize;
    uint           dwChargingInfoOffset;
    uint           dwTerminalModesSize;
    uint           dwTerminalModesOffset;
    uint           dwDevSpecificSize;
    uint           dwDevSpecificOffset;
    uint           dwCallTreatment;
    uint           dwCallDataSize;
    uint           dwCallDataOffset;
    uint           dwSendingFlowspecSize;
    uint           dwSendingFlowspecOffset;
    uint           dwReceivingFlowspecSize;
    uint           dwReceivingFlowspecOffset;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linecalllist))], [])
struct LINECALLLIST
{
align (1):
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwCallsNumEntries;
    uint dwCallsSize;
    uint dwCallsOffset;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linecallparams))], [])
struct LINECALLPARAMS
{
align (1):
    uint           dwTotalSize;
    uint           dwBearerMode;
    uint           dwMinRate;
    uint           dwMaxRate;
    uint           dwMediaMode;
    uint           dwCallParamFlags;
    uint           dwAddressMode;
    uint           dwAddressID;
    LINEDIALPARAMS DialParams;
    uint           dwOrigAddressSize;
    uint           dwOrigAddressOffset;
    uint           dwDisplayableAddressSize;
    uint           dwDisplayableAddressOffset;
    uint           dwCalledPartySize;
    uint           dwCalledPartyOffset;
    uint           dwCommentSize;
    uint           dwCommentOffset;
    uint           dwUserUserInfoSize;
    uint           dwUserUserInfoOffset;
    uint           dwHighLevelCompSize;
    uint           dwHighLevelCompOffset;
    uint           dwLowLevelCompSize;
    uint           dwLowLevelCompOffset;
    uint           dwDevSpecificSize;
    uint           dwDevSpecificOffset;
    uint           dwPredictiveAutoTransferStates;
    uint           dwTargetAddressSize;
    uint           dwTargetAddressOffset;
    uint           dwSendingFlowspecSize;
    uint           dwSendingFlowspecOffset;
    uint           dwReceivingFlowspecSize;
    uint           dwReceivingFlowspecOffset;
    uint           dwDeviceClassSize;
    uint           dwDeviceClassOffset;
    uint           dwDeviceConfigSize;
    uint           dwDeviceConfigOffset;
    uint           dwCallDataSize;
    uint           dwCallDataOffset;
    uint           dwNoAnswerTimeout;
    uint           dwCallingPartyIDSize;
    uint           dwCallingPartyIDOffset;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linecallstatus))], [])
struct LINECALLSTATUS
{
align (1):
    uint       dwTotalSize;
    uint       dwNeededSize;
    uint       dwUsedSize;
    uint       dwCallState;
    uint       dwCallStateMode;
    uint       dwCallPrivilege;
    uint       dwCallFeatures;
    uint       dwDevSpecificSize;
    uint       dwDevSpecificOffset;
    uint       dwCallFeatures2;
    SYSTEMTIME tStateEntryTime;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linecalltreatmententry))], [])
struct LINECALLTREATMENTENTRY
{
align (1):
    uint dwCallTreatmentID;
    uint dwCallTreatmentNameSize;
    uint dwCallTreatmentNameOffset;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linecardentry))], [])
struct LINECARDENTRY
{
align (1):
    uint dwPermanentCardID;
    uint dwCardNameSize;
    uint dwCardNameOffset;
    uint dwCardNumberDigits;
    uint dwSameAreaRuleSize;
    uint dwSameAreaRuleOffset;
    uint dwLongDistanceRuleSize;
    uint dwLongDistanceRuleOffset;
    uint dwInternationalRuleSize;
    uint dwInternationalRuleOffset;
    uint dwOptions;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linecountryentry))], [])
struct LINECOUNTRYENTRY
{
align (1):
    uint dwCountryID;
    uint dwCountryCode;
    uint dwNextCountryID;
    uint dwCountryNameSize;
    uint dwCountryNameOffset;
    uint dwSameAreaRuleSize;
    uint dwSameAreaRuleOffset;
    uint dwLongDistanceRuleSize;
    uint dwLongDistanceRuleOffset;
    uint dwInternationalRuleSize;
    uint dwInternationalRuleOffset;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linecountrylist))], [])
struct LINECOUNTRYLIST
{
align (1):
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwNumCountries;
    uint dwCountryListSize;
    uint dwCountryListOffset;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linedevcaps))], [])
struct LINEDEVCAPS
{
align (1):
    uint           dwTotalSize;
    uint           dwNeededSize;
    uint           dwUsedSize;
    uint           dwProviderInfoSize;
    uint           dwProviderInfoOffset;
    uint           dwSwitchInfoSize;
    uint           dwSwitchInfoOffset;
    uint           dwPermanentLineID;
    uint           dwLineNameSize;
    uint           dwLineNameOffset;
    uint           dwStringFormat;
    uint           dwAddressModes;
    uint           dwNumAddresses;
    uint           dwBearerModes;
    uint           dwMaxRate;
    uint           dwMediaModes;
    uint           dwGenerateToneModes;
    uint           dwGenerateToneMaxNumFreq;
    uint           dwGenerateDigitModes;
    uint           dwMonitorToneMaxNumFreq;
    uint           dwMonitorToneMaxNumEntries;
    uint           dwMonitorDigitModes;
    uint           dwGatherDigitsMinTimeout;
    uint           dwGatherDigitsMaxTimeout;
    uint           dwMedCtlDigitMaxListSize;
    uint           dwMedCtlMediaMaxListSize;
    uint           dwMedCtlToneMaxListSize;
    uint           dwMedCtlCallStateMaxListSize;
    uint           dwDevCapFlags;
    uint           dwMaxNumActiveCalls;
    uint           dwAnswerMode;
    uint           dwRingModes;
    uint           dwLineStates;
    uint           dwUUIAcceptSize;
    uint           dwUUIAnswerSize;
    uint           dwUUIMakeCallSize;
    uint           dwUUIDropSize;
    uint           dwUUISendUserUserInfoSize;
    uint           dwUUICallInfoSize;
    LINEDIALPARAMS MinDialParams;
    LINEDIALPARAMS MaxDialParams;
    LINEDIALPARAMS DefaultDialParams;
    uint           dwNumTerminals;
    uint           dwTerminalCapsSize;
    uint           dwTerminalCapsOffset;
    uint           dwTerminalTextEntrySize;
    uint           dwTerminalTextSize;
    uint           dwTerminalTextOffset;
    uint           dwDevSpecificSize;
    uint           dwDevSpecificOffset;
    uint           dwLineFeatures;
    uint           dwSettableDevStatus;
    uint           dwDeviceClassesSize;
    uint           dwDeviceClassesOffset;
    GUID           PermanentLineGuid;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linedevstatus))], [])
struct LINEDEVSTATUS
{
align (1):
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwNumOpens;
    uint dwOpenMediaModes;
    uint dwNumActiveCalls;
    uint dwNumOnHoldCalls;
    uint dwNumOnHoldPendCalls;
    uint dwLineFeatures;
    uint dwNumCallCompletions;
    uint dwRingMode;
    uint dwSignalLevel;
    uint dwBatteryLevel;
    uint dwRoamMode;
    uint dwDevStatusFlags;
    uint dwTerminalModesSize;
    uint dwTerminalModesOffset;
    uint dwDevSpecificSize;
    uint dwDevSpecificOffset;
    uint dwAvailableMediaModes;
    uint dwAppInfoSize;
    uint dwAppInfoOffset;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-lineextensionid))], [])
struct LINEEXTENSIONID
{
align (1):
    uint dwExtensionID0;
    uint dwExtensionID1;
    uint dwExtensionID2;
    uint dwExtensionID3;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-lineforward))], [])
struct LINEFORWARD
{
align (1):
    uint dwForwardMode;
    uint dwCallerAddressSize;
    uint dwCallerAddressOffset;
    uint dwDestCountryCode;
    uint dwDestAddressSize;
    uint dwDestAddressOffset;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-lineforwardlist))], [])
struct LINEFORWARDLIST
{
align (1):
    uint dwTotalSize;
    uint dwNumEntries;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/LINEFORWARD[1] ForwardList;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linegeneratetone))], [])
struct LINEGENERATETONE
{
align (1):
    uint dwFrequency;
    uint dwCadenceOn;
    uint dwCadenceOff;
    uint dwVolume;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-lineinitializeexparams))], [])
struct LINEINITIALIZEEXPARAMS
{
align (1):
    uint              dwTotalSize;
    uint              dwNeededSize;
    uint              dwUsedSize;
    uint              dwOptions;
    _Handles_e__Union Handles;
    uint              dwCompletionKey;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linelocationentry))], [])
struct LINELOCATIONENTRY
{
align (1):
    uint dwPermanentLocationID;
    uint dwLocationNameSize;
    uint dwLocationNameOffset;
    uint dwCountryCode;
    uint dwCityCodeSize;
    uint dwCityCodeOffset;
    uint dwPreferredCardID;
    uint dwLocalAccessCodeSize;
    uint dwLocalAccessCodeOffset;
    uint dwLongDistanceAccessCodeSize;
    uint dwLongDistanceAccessCodeOffset;
    uint dwTollPrefixListSize;
    uint dwTollPrefixListOffset;
    uint dwCountryID;
    uint dwOptions;
    uint dwCancelCallWaitingSize;
    uint dwCancelCallWaitingOffset;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linemediacontrolcallstate))], [])
struct LINEMEDIACONTROLCALLSTATE
{
align (1):
    uint dwCallStates;
    uint dwMediaControl;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linemediacontroldigit))], [])
struct LINEMEDIACONTROLDIGIT
{
align (1):
    uint dwDigit;
    uint dwDigitModes;
    uint dwMediaControl;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linemediacontrolmedia))], [])
struct LINEMEDIACONTROLMEDIA
{
align (1):
    uint dwMediaModes;
    uint dwDuration;
    uint dwMediaControl;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linemediacontroltone))], [])
struct LINEMEDIACONTROLTONE
{
align (1):
    uint dwAppSpecific;
    uint dwDuration;
    uint dwFrequency1;
    uint dwFrequency2;
    uint dwFrequency3;
    uint dwMediaControl;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linemessage))], [])
struct LINEMESSAGE
{
align (1):
    uint   hDevice;
    uint   dwMessageID;
    size_t dwCallbackInstance;
    size_t dwParam1;
    size_t dwParam2;
    size_t dwParam3;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linemonitortone))], [])
struct LINEMONITORTONE
{
align (1):
    uint dwAppSpecific;
    uint dwDuration;
    uint dwFrequency1;
    uint dwFrequency2;
    uint dwFrequency3;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-lineproviderentry))], [])
struct LINEPROVIDERENTRY
{
align (1):
    uint dwPermanentProviderID;
    uint dwProviderFilenameSize;
    uint dwProviderFilenameOffset;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-lineproviderlist))], [])
struct LINEPROVIDERLIST
{
align (1):
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwNumProviders;
    uint dwProviderListSize;
    uint dwProviderListOffset;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-lineproxyrequest))], [])
struct LINEPROXYREQUEST
{
align (1):
    uint                dwSize;
    uint                dwClientMachineNameSize;
    uint                dwClientMachineNameOffset;
    uint                dwClientUserNameSize;
    uint                dwClientUserNameOffset;
    uint                dwClientAppAPIVersion;
    uint                dwRequestType;
    _Anonymous_e__Union Anonymous;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linereqmakecall))], [])
struct LINEREQMAKECALL
{
    CHAR[80] szDestAddress;
    CHAR[40] szAppName;
    CHAR[40] szCalledParty;
    CHAR[80] szComment;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
struct LINEREQMAKECALLW
{
align (1):
    wchar[80] szDestAddress;
    wchar[40] szAppName;
    wchar[40] szCalledParty;
    wchar[80] szComment;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linereqmediacall))], [])
struct LINEREQMEDIACALL
{
align (1):
    HWND      hWnd;
    WPARAM    wRequestID;
    CHAR[40]  szDeviceClass;
    ubyte[40] ucDeviceID;
    uint      dwSize;
    uint      dwSecure;
    CHAR[80]  szDestAddress;
    CHAR[40]  szAppName;
    CHAR[40]  szCalledParty;
    CHAR[80]  szComment;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
struct LINEREQMEDIACALLW
{
align (1):
    HWND      hWnd;
    WPARAM    wRequestID;
    wchar[40] szDeviceClass;
    ubyte[40] ucDeviceID;
    uint      dwSize;
    uint      dwSecure;
    wchar[80] szDestAddress;
    wchar[40] szAppName;
    wchar[40] szCalledParty;
    wchar[80] szComment;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linetermcaps))], [])
struct LINETERMCAPS
{
align (1):
    uint dwTermDev;
    uint dwTermModes;
    uint dwTermSharing;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linetranslatecaps))], [])
struct LINETRANSLATECAPS
{
align (1):
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwNumLocations;
    uint dwLocationListSize;
    uint dwLocationListOffset;
    uint dwCurrentLocationID;
    uint dwNumCards;
    uint dwCardListSize;
    uint dwCardListOffset;
    uint dwCurrentPreferredCardID;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linetranslateoutput))], [])
struct LINETRANSLATEOUTPUT
{
align (1):
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwDialableStringSize;
    uint dwDialableStringOffset;
    uint dwDisplayableStringSize;
    uint dwDisplayableStringOffset;
    uint dwCurrentCountry;
    uint dwDestCountry;
    uint dwTranslateResults;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-phonebuttoninfo))], [])
struct PHONEBUTTONINFO
{
align (1):
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwButtonMode;
    uint dwButtonFunction;
    uint dwButtonTextSize;
    uint dwButtonTextOffset;
    uint dwDevSpecificSize;
    uint dwDevSpecificOffset;
    uint dwButtonState;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-phonecaps))], [])
struct PHONECAPS
{
align (1):
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwProviderInfoSize;
    uint dwProviderInfoOffset;
    uint dwPhoneInfoSize;
    uint dwPhoneInfoOffset;
    uint dwPermanentPhoneID;
    uint dwPhoneNameSize;
    uint dwPhoneNameOffset;
    uint dwStringFormat;
    uint dwPhoneStates;
    uint dwHookSwitchDevs;
    uint dwHandsetHookSwitchModes;
    uint dwSpeakerHookSwitchModes;
    uint dwHeadsetHookSwitchModes;
    uint dwVolumeFlags;
    uint dwGainFlags;
    uint dwDisplayNumRows;
    uint dwDisplayNumColumns;
    uint dwNumRingModes;
    uint dwNumButtonLamps;
    uint dwButtonModesSize;
    uint dwButtonModesOffset;
    uint dwButtonFunctionsSize;
    uint dwButtonFunctionsOffset;
    uint dwLampModesSize;
    uint dwLampModesOffset;
    uint dwNumSetData;
    uint dwSetDataSize;
    uint dwSetDataOffset;
    uint dwNumGetData;
    uint dwGetDataSize;
    uint dwGetDataOffset;
    uint dwDevSpecificSize;
    uint dwDevSpecificOffset;
    uint dwDeviceClassesSize;
    uint dwDeviceClassesOffset;
    uint dwPhoneFeatures;
    uint dwSettableHandsetHookSwitchModes;
    uint dwSettableSpeakerHookSwitchModes;
    uint dwSettableHeadsetHookSwitchModes;
    uint dwMonitoredHandsetHookSwitchModes;
    uint dwMonitoredSpeakerHookSwitchModes;
    uint dwMonitoredHeadsetHookSwitchModes;
    GUID PermanentPhoneGuid;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-phoneextensionid))], [])
struct PHONEEXTENSIONID
{
align (1):
    uint dwExtensionID0;
    uint dwExtensionID1;
    uint dwExtensionID2;
    uint dwExtensionID3;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-phoneinitializeexparams))], [])
struct PHONEINITIALIZEEXPARAMS
{
align (1):
    uint              dwTotalSize;
    uint              dwNeededSize;
    uint              dwUsedSize;
    uint              dwOptions;
    _Handles_e__Union Handles;
    uint              dwCompletionKey;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-phonemessage))], [])
struct PHONEMESSAGE
{
align (1):
    uint   hDevice;
    uint   dwMessageID;
    size_t dwCallbackInstance;
    size_t dwParam1;
    size_t dwParam2;
    size_t dwParam3;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-phonestatus))], [])
struct PHONESTATUS
{
align (1):
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwStatusFlags;
    uint dwNumOwners;
    uint dwNumMonitors;
    uint dwRingMode;
    uint dwRingVolume;
    uint dwHandsetHookSwitchMode;
    uint dwHandsetVolume;
    uint dwHandsetGain;
    uint dwSpeakerHookSwitchMode;
    uint dwSpeakerVolume;
    uint dwSpeakerGain;
    uint dwHeadsetHookSwitchMode;
    uint dwHeadsetVolume;
    uint dwHeadsetGain;
    uint dwDisplaySize;
    uint dwDisplayOffset;
    uint dwLampModesSize;
    uint dwLampModesOffset;
    uint dwOwnerNameSize;
    uint dwOwnerNameOffset;
    uint dwDevSpecificSize;
    uint dwDevSpecificOffset;
    uint dwPhoneFeatures;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-varstring))], [])
struct VARSTRING
{
align (1):
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwStringFormat;
    uint dwStringSize;
    uint dwStringOffset;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tspi/ns-tspi-tuispicreatedialoginstanceparams))], [])
struct TUISPICREATEDIALOGINSTANCEPARAMS
{
    uint               dwRequestID;
    HDRVDIALOGINSTANCE hdDlgInst;
    uint               htDlgInst;
    const(PWSTR)       lpszUIDLLName;
    void*              lpParams;
    uint               dwSize;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/ns-tapi3if-tapi_customtone))], [])
struct TAPI_CUSTOMTONE
{
    uint dwFrequency;
    uint dwCadenceOn;
    uint dwCadenceOff;
    uint dwVolume;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/ns-tapi3if-tapi_detecttone))], [])
struct TAPI_DETECTTONE
{
    uint dwAppSpecific;
    uint dwDuration;
    uint dwFrequency1;
    uint dwFrequency2;
    uint dwFrequency3;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msp/ns-msp-msp_event_info))], [])
struct MSP_EVENT_INFO
{
    uint                dwSize;
    MSP_EVENT           Event;
    int*                hCall;
    _Anonymous_e__Union Anonymous;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/office/client-developer/outlook/mapi/stnefproblem))], [])
struct STnefProblem
{
    uint ulComponent;
    uint ulAttribute;
    uint ulPropTag;
    int  scode;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/office/client-developer/outlook/mapi/stnefproblemarray))], [])
struct STnefProblemArray
{
    uint cProblem;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/STnefProblem[1] aProblem;
}

struct RENDDATA
{
align (1):
    ushort atyp;
    uint   ulPosition;
    ushort dxWidth;
    ushort dyHeight;
    uint   dwFlags;
}

struct DTR
{
align (1):
    ushort wYear;
    ushort wMonth;
    ushort wDay;
    ushort wHour;
    ushort wMinute;
    ushort wSecond;
    ushort wDayOfWeek;
}

struct TRP
{
    ushort trpid;
    ushort cbgrtrp;
    ushort cch;
    ushort cbRgb;
}

struct ADDRALIAS
{
    CHAR[41] rgchName;
    CHAR[11] rgchEName;
    CHAR[12] rgchSrvr;
    uint     dibDetail;
    ushort   type;
}

struct NSID
{
    uint              dwSize;
    ubyte[16]         uchType;
    uint              xtype;
    int               lTime;
    _address_e__Union address;
}

// Functions

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-lineaccept))], [])
@DllImport("TAPI32.dll")
int lineAccept(uint hCall, const(PSTR) lpsUserUserInfo, uint dwSize);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineAddProvider(const(PSTR) lpszProviderFilename, HWND hwndOwner, uint* lpdwPermanentProviderID);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineAddProviderA(const(PSTR) lpszProviderFilename, HWND hwndOwner, uint* lpdwPermanentProviderID);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineAddProviderW(const(PWSTR) lpszProviderFilename, HWND hwndOwner, uint* lpdwPermanentProviderID);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-lineaddtoconference))], [])
@DllImport("TAPI32.dll")
int lineAddToConference(uint hConfCall, uint hConsultCall);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-lineagentspecific))], [])
@DllImport("TAPI32.dll")
int lineAgentSpecific(uint hLine, uint dwAddressID, uint dwAgentExtensionIDIndex, void* lpParams, uint dwSize);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-lineanswer))], [])
@DllImport("TAPI32.dll")
int lineAnswer(uint hCall, const(PSTR) lpsUserUserInfo, uint dwSize);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineBlindTransfer(uint hCall, const(PSTR) lpszDestAddress, uint dwCountryCode);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineBlindTransferA(uint hCall, const(PSTR) lpszDestAddress, uint dwCountryCode);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineBlindTransferW(uint hCall, const(PWSTR) lpszDestAddressW, uint dwCountryCode);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-lineclose))], [])
@DllImport("TAPI32.dll")
int lineClose(uint hLine);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linecompletecall))], [])
@DllImport("TAPI32.dll")
int lineCompleteCall(uint hCall, uint* lpdwCompletionID, uint dwCompletionMode, uint dwMessageID);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linecompletetransfer))], [])
@DllImport("TAPI32.dll")
int lineCompleteTransfer(uint hCall, uint hConsultCall, uint* lphConfCall, uint dwTransferMode);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineConfigDialog(uint dwDeviceID, HWND hwndOwner, const(PSTR) lpszDeviceClass);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineConfigDialogA(uint dwDeviceID, HWND hwndOwner, const(PSTR) lpszDeviceClass);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineConfigDialogW(uint dwDeviceID, HWND hwndOwner, const(PWSTR) lpszDeviceClass);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineConfigDialogEdit(uint dwDeviceID, HWND hwndOwner, const(PSTR) lpszDeviceClass, 
                         const(void)* lpDeviceConfigIn, uint dwSize, VARSTRING* lpDeviceConfigOut);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineConfigDialogEditA(uint dwDeviceID, HWND hwndOwner, const(PSTR) lpszDeviceClass, 
                          const(void)* lpDeviceConfigIn, uint dwSize, VARSTRING* lpDeviceConfigOut);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineConfigDialogEditW(uint dwDeviceID, HWND hwndOwner, const(PWSTR) lpszDeviceClass, 
                          const(void)* lpDeviceConfigIn, uint dwSize, VARSTRING* lpDeviceConfigOut);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-lineconfigprovider))], [])
@DllImport("TAPI32.dll")
int lineConfigProvider(HWND hwndOwner, uint dwPermanentProviderID);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineCreateAgentW(uint hLine, const(PWSTR) lpszAgentID, const(PWSTR) lpszAgentPIN, uint* lphAgent);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineCreateAgentA(uint hLine, const(PSTR) lpszAgentID, const(PSTR) lpszAgentPIN, uint* lphAgent);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineCreateAgentSessionW(uint hLine, uint hAgent, const(PWSTR) lpszAgentPIN, uint dwWorkingAddressID, 
                            GUID* lpGroupID, uint* lphAgentSession);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineCreateAgentSessionA(uint hLine, uint hAgent, const(PSTR) lpszAgentPIN, uint dwWorkingAddressID, 
                            GUID* lpGroupID, uint* lphAgentSession);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linedeallocatecall))], [])
@DllImport("TAPI32.dll")
int lineDeallocateCall(uint hCall);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linedevspecific))], [])
@DllImport("TAPI32.dll")
int lineDevSpecific(uint hLine, uint dwAddressID, uint hCall, void* lpParams, uint dwSize);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linedevspecificfeature))], [])
@DllImport("TAPI32.dll")
int lineDevSpecificFeature(uint hLine, uint dwFeature, void* lpParams, uint dwSize);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineDial(uint hCall, const(PSTR) lpszDestAddress, uint dwCountryCode);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineDialA(uint hCall, const(PSTR) lpszDestAddress, uint dwCountryCode);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineDialW(uint hCall, const(PWSTR) lpszDestAddress, uint dwCountryCode);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linedrop))], [])
@DllImport("TAPI32.dll")
int lineDrop(uint hCall, const(PSTR) lpsUserUserInfo, uint dwSize);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineForward(uint hLine, uint bAllAddresses, uint dwAddressID, const(LINEFORWARDLIST)* lpForwardList, 
                uint dwNumRingsNoAnswer, uint* lphConsultCall, const(LINECALLPARAMS)* lpCallParams);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineForwardA(uint hLine, uint bAllAddresses, uint dwAddressID, const(LINEFORWARDLIST)* lpForwardList, 
                 uint dwNumRingsNoAnswer, uint* lphConsultCall, const(LINECALLPARAMS)* lpCallParams);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineForwardW(uint hLine, uint bAllAddresses, uint dwAddressID, const(LINEFORWARDLIST)* lpForwardList, 
                 uint dwNumRingsNoAnswer, uint* lphConsultCall, const(LINECALLPARAMS)* lpCallParams);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGatherDigits(uint hCall, uint dwDigitModes, PSTR lpsDigits, uint dwNumDigits, 
                     const(PSTR) lpszTerminationDigits, uint dwFirstDigitTimeout, uint dwInterDigitTimeout);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGatherDigitsA(uint hCall, uint dwDigitModes, PSTR lpsDigits, uint dwNumDigits, 
                      const(PSTR) lpszTerminationDigits, uint dwFirstDigitTimeout, uint dwInterDigitTimeout);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGatherDigitsW(uint hCall, uint dwDigitModes, PWSTR lpsDigits, uint dwNumDigits, 
                      const(PWSTR) lpszTerminationDigits, uint dwFirstDigitTimeout, uint dwInterDigitTimeout);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGenerateDigits(uint hCall, uint dwDigitMode, const(PSTR) lpszDigits, uint dwDuration);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGenerateDigitsA(uint hCall, uint dwDigitMode, const(PSTR) lpszDigits, uint dwDuration);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGenerateDigitsW(uint hCall, uint dwDigitMode, const(PWSTR) lpszDigits, uint dwDuration);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linegeneratetone))], [])
@DllImport("TAPI32.dll")
int lineGenerateTone(uint hCall, uint dwToneMode, uint dwDuration, uint dwNumTones, 
                     const(LINEGENERATETONE)* lpTones);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetAddressCaps(uint hLineApp, uint dwDeviceID, uint dwAddressID, uint dwAPIVersion, uint dwExtVersion, 
                       LINEADDRESSCAPS* lpAddressCaps);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetAddressCapsA(uint hLineApp, uint dwDeviceID, uint dwAddressID, uint dwAPIVersion, uint dwExtVersion, 
                        LINEADDRESSCAPS* lpAddressCaps);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetAddressCapsW(uint hLineApp, uint dwDeviceID, uint dwAddressID, uint dwAPIVersion, uint dwExtVersion, 
                        LINEADDRESSCAPS* lpAddressCaps);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetAddressID(uint hLine, uint* lpdwAddressID, uint dwAddressMode, const(PSTR) lpsAddress, uint dwSize);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetAddressIDA(uint hLine, uint* lpdwAddressID, uint dwAddressMode, const(PSTR) lpsAddress, uint dwSize);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetAddressIDW(uint hLine, uint* lpdwAddressID, uint dwAddressMode, const(PWSTR) lpsAddress, uint dwSize);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetAddressStatus(uint hLine, uint dwAddressID, LINEADDRESSSTATUS* lpAddressStatus);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetAddressStatusA(uint hLine, uint dwAddressID, LINEADDRESSSTATUS* lpAddressStatus);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetAddressStatusW(uint hLine, uint dwAddressID, LINEADDRESSSTATUS* lpAddressStatus);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetAgentActivityListA(uint hLine, uint dwAddressID, LINEAGENTACTIVITYLIST* lpAgentActivityList);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetAgentActivityListW(uint hLine, uint dwAddressID, LINEAGENTACTIVITYLIST* lpAgentActivityList);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetAgentCapsA(uint hLineApp, uint dwDeviceID, uint dwAddressID, uint dwAppAPIVersion, 
                      LINEAGENTCAPS* lpAgentCaps);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetAgentCapsW(uint hLineApp, uint dwDeviceID, uint dwAddressID, uint dwAppAPIVersion, 
                      LINEAGENTCAPS* lpAgentCaps);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetAgentGroupListA(uint hLine, uint dwAddressID, LINEAGENTGROUPLIST* lpAgentGroupList);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetAgentGroupListW(uint hLine, uint dwAddressID, LINEAGENTGROUPLIST* lpAgentGroupList);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linegetagentinfo))], [])
@DllImport("TAPI32.dll")
int lineGetAgentInfo(uint hLine, uint hAgent, LINEAGENTINFO* lpAgentInfo);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linegetagentsessioninfo))], [])
@DllImport("TAPI32.dll")
int lineGetAgentSessionInfo(uint hLine, uint hAgentSession, LINEAGENTSESSIONINFO* lpAgentSessionInfo);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linegetagentsessionlist))], [])
@DllImport("TAPI32.dll")
int lineGetAgentSessionList(uint hLine, uint hAgent, LINEAGENTSESSIONLIST* lpAgentSessionList);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetAgentStatusA(uint hLine, uint dwAddressID, LINEAGENTSTATUS* lpAgentStatus);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetAgentStatusW(uint hLine, uint dwAddressID, LINEAGENTSTATUS* lpAgentStatus);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetAppPriority(const(PSTR) lpszAppFilename, uint dwMediaMode, LINEEXTENSIONID* lpExtensionID, 
                       uint dwRequestMode, VARSTRING* lpExtensionName, uint* lpdwPriority);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetAppPriorityA(const(PSTR) lpszAppFilename, uint dwMediaMode, LINEEXTENSIONID* lpExtensionID, 
                        uint dwRequestMode, VARSTRING* lpExtensionName, uint* lpdwPriority);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetAppPriorityW(const(PWSTR) lpszAppFilename, uint dwMediaMode, LINEEXTENSIONID* lpExtensionID, 
                        uint dwRequestMode, VARSTRING* lpExtensionName, uint* lpdwPriority);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetCallInfo(uint hCall, LINECALLINFO* lpCallInfo);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetCallInfoA(uint hCall, LINECALLINFO* lpCallInfo);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetCallInfoW(uint hCall, LINECALLINFO* lpCallInfo);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linegetcallstatus))], [])
@DllImport("TAPI32.dll")
int lineGetCallStatus(uint hCall, LINECALLSTATUS* lpCallStatus);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linegetconfrelatedcalls))], [])
@DllImport("TAPI32.dll")
int lineGetConfRelatedCalls(uint hCall, LINECALLLIST* lpCallList);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetCountry(uint dwCountryID, uint dwAPIVersion, LINECOUNTRYLIST* lpLineCountryList);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetCountryA(uint dwCountryID, uint dwAPIVersion, LINECOUNTRYLIST* lpLineCountryList);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetCountryW(uint dwCountryID, uint dwAPIVersion, LINECOUNTRYLIST* lpLineCountryList);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetDevCaps(uint hLineApp, uint dwDeviceID, uint dwAPIVersion, uint dwExtVersion, 
                   LINEDEVCAPS* lpLineDevCaps);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetDevCapsA(uint hLineApp, uint dwDeviceID, uint dwAPIVersion, uint dwExtVersion, 
                    LINEDEVCAPS* lpLineDevCaps);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetDevCapsW(uint hLineApp, uint dwDeviceID, uint dwAPIVersion, uint dwExtVersion, 
                    LINEDEVCAPS* lpLineDevCaps);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetDevConfig(uint dwDeviceID, VARSTRING* lpDeviceConfig, const(PSTR) lpszDeviceClass);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetDevConfigA(uint dwDeviceID, VARSTRING* lpDeviceConfig, const(PSTR) lpszDeviceClass);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetDevConfigW(uint dwDeviceID, VARSTRING* lpDeviceConfig, const(PWSTR) lpszDeviceClass);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetGroupListA(uint hLine, LINEAGENTGROUPLIST* lpGroupList);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetGroupListW(uint hLine, LINEAGENTGROUPLIST* lpGroupList);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetIcon(uint dwDeviceID, const(PSTR) lpszDeviceClass, HICON* lphIcon);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetIconA(uint dwDeviceID, const(PSTR) lpszDeviceClass, HICON* lphIcon);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetIconW(uint dwDeviceID, const(PWSTR) lpszDeviceClass, HICON* lphIcon);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetID(uint hLine, uint dwAddressID, uint hCall, uint dwSelect, VARSTRING* lpDeviceID, 
              const(PSTR) lpszDeviceClass);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetIDA(uint hLine, uint dwAddressID, uint hCall, uint dwSelect, VARSTRING* lpDeviceID, 
               const(PSTR) lpszDeviceClass);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetIDW(uint hLine, uint dwAddressID, uint hCall, uint dwSelect, VARSTRING* lpDeviceID, 
               const(PWSTR) lpszDeviceClass);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetLineDevStatus(uint hLine, LINEDEVSTATUS* lpLineDevStatus);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetLineDevStatusA(uint hLine, LINEDEVSTATUS* lpLineDevStatus);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetLineDevStatusW(uint hLine, LINEDEVSTATUS* lpLineDevStatus);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linegetmessage))], [])
@DllImport("TAPI32.dll")
int lineGetMessage(uint hLineApp, LINEMESSAGE* lpMessage, uint dwTimeout);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linegetnewcalls))], [])
@DllImport("TAPI32.dll")
int lineGetNewCalls(uint hLine, uint dwAddressID, uint dwSelect, LINECALLLIST* lpCallList);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linegetnumrings))], [])
@DllImport("TAPI32.dll")
int lineGetNumRings(uint hLine, uint dwAddressID, uint* lpdwNumRings);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetProviderList(uint dwAPIVersion, LINEPROVIDERLIST* lpProviderList);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetProviderListA(uint dwAPIVersion, LINEPROVIDERLIST* lpProviderList);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetProviderListW(uint dwAPIVersion, LINEPROVIDERLIST* lpProviderList);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linegetproxystatus))], [])
@DllImport("TAPI32.dll")
int lineGetProxyStatus(uint hLineApp, uint dwDeviceID, uint dwAppAPIVersion, 
                       LINEPROXYREQUESTLIST* lpLineProxyReqestList);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linegetqueueinfo))], [])
@DllImport("TAPI32.dll")
int lineGetQueueInfo(uint hLine, uint dwQueueID, LINEQUEUEINFO* lpLineQueueInfo);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetQueueListA(uint hLine, GUID* lpGroupID, LINEQUEUELIST* lpQueueList);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetQueueListW(uint hLine, GUID* lpGroupID, LINEQUEUELIST* lpQueueList);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetRequest(uint hLineApp, uint dwRequestMode, void* lpRequestBuffer);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetRequestA(uint hLineApp, uint dwRequestMode, void* lpRequestBuffer);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetRequestW(uint hLineApp, uint dwRequestMode, void* lpRequestBuffer);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linegetstatusmessages))], [])
@DllImport("TAPI32.dll")
int lineGetStatusMessages(uint hLine, uint* lpdwLineStates, uint* lpdwAddressStates);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetTranslateCaps(uint hLineApp, uint dwAPIVersion, LINETRANSLATECAPS* lpTranslateCaps);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetTranslateCapsA(uint hLineApp, uint dwAPIVersion, LINETRANSLATECAPS* lpTranslateCaps);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineGetTranslateCapsW(uint hLineApp, uint dwAPIVersion, LINETRANSLATECAPS* lpTranslateCaps);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineHandoff(uint hCall, const(PSTR) lpszFileName, uint dwMediaMode);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineHandoffA(uint hCall, const(PSTR) lpszFileName, uint dwMediaMode);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineHandoffW(uint hCall, const(PWSTR) lpszFileName, uint dwMediaMode);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linehold))], [])
@DllImport("TAPI32.dll")
int lineHold(uint hCall);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-lineinitialize))], [])
@DllImport("TAPI32.dll")
int lineInitialize(uint* lphLineApp, HINSTANCE hInstance, LINECALLBACK lpfnCallback, const(PSTR) lpszAppName, 
                   uint* lpdwNumDevs);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineInitializeExA(uint* lphLineApp, HINSTANCE hInstance, LINECALLBACK lpfnCallback, 
                      const(PSTR) lpszFriendlyAppName, uint* lpdwNumDevs, uint* lpdwAPIVersion, 
                      LINEINITIALIZEEXPARAMS* lpLineInitializeExParams);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineInitializeExW(uint* lphLineApp, HINSTANCE hInstance, LINECALLBACK lpfnCallback, 
                      const(PWSTR) lpszFriendlyAppName, uint* lpdwNumDevs, uint* lpdwAPIVersion, 
                      LINEINITIALIZEEXPARAMS* lpLineInitializeExParams);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineMakeCall(uint hLine, uint* lphCall, const(PSTR) lpszDestAddress, uint dwCountryCode, 
                 const(LINECALLPARAMS)* lpCallParams);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineMakeCallA(uint hLine, uint* lphCall, const(PSTR) lpszDestAddress, uint dwCountryCode, 
                  const(LINECALLPARAMS)* lpCallParams);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineMakeCallW(uint hLine, uint* lphCall, const(PWSTR) lpszDestAddress, uint dwCountryCode, 
                  const(LINECALLPARAMS)* lpCallParams);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linemonitordigits))], [])
@DllImport("TAPI32.dll")
int lineMonitorDigits(uint hCall, uint dwDigitModes);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linemonitormedia))], [])
@DllImport("TAPI32.dll")
int lineMonitorMedia(uint hCall, uint dwMediaModes);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linemonitortones))], [])
@DllImport("TAPI32.dll")
int lineMonitorTones(uint hCall, const(LINEMONITORTONE)* lpToneList, uint dwNumEntries);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linenegotiateapiversion))], [])
@DllImport("TAPI32.dll")
int lineNegotiateAPIVersion(uint hLineApp, uint dwDeviceID, uint dwAPILowVersion, uint dwAPIHighVersion, 
                            uint* lpdwAPIVersion, LINEEXTENSIONID* lpExtensionID);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linenegotiateextversion))], [])
@DllImport("TAPI32.dll")
int lineNegotiateExtVersion(uint hLineApp, uint dwDeviceID, uint dwAPIVersion, uint dwExtLowVersion, 
                            uint dwExtHighVersion, uint* lpdwExtVersion);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineOpen(uint hLineApp, uint dwDeviceID, uint* lphLine, uint dwAPIVersion, uint dwExtVersion, 
             size_t dwCallbackInstance, uint dwPrivileges, uint dwMediaModes, const(LINECALLPARAMS)* lpCallParams);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineOpenA(uint hLineApp, uint dwDeviceID, uint* lphLine, uint dwAPIVersion, uint dwExtVersion, 
              size_t dwCallbackInstance, uint dwPrivileges, uint dwMediaModes, const(LINECALLPARAMS)* lpCallParams);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineOpenW(uint hLineApp, uint dwDeviceID, uint* lphLine, uint dwAPIVersion, uint dwExtVersion, 
              size_t dwCallbackInstance, uint dwPrivileges, uint dwMediaModes, const(LINECALLPARAMS)* lpCallParams);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int linePark(uint hCall, uint dwParkMode, const(PSTR) lpszDirAddress, VARSTRING* lpNonDirAddress);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineParkA(uint hCall, uint dwParkMode, const(PSTR) lpszDirAddress, VARSTRING* lpNonDirAddress);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineParkW(uint hCall, uint dwParkMode, const(PWSTR) lpszDirAddress, VARSTRING* lpNonDirAddress);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int linePickup(uint hLine, uint dwAddressID, uint* lphCall, const(PSTR) lpszDestAddress, const(PSTR) lpszGroupID);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int linePickupA(uint hLine, uint dwAddressID, uint* lphCall, const(PSTR) lpszDestAddress, const(PSTR) lpszGroupID);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int linePickupW(uint hLine, uint dwAddressID, uint* lphCall, const(PWSTR) lpszDestAddress, 
                const(PWSTR) lpszGroupID);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int linePrepareAddToConference(uint hConfCall, uint* lphConsultCall, const(LINECALLPARAMS)* lpCallParams);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int linePrepareAddToConferenceA(uint hConfCall, uint* lphConsultCall, const(LINECALLPARAMS)* lpCallParams);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int linePrepareAddToConferenceW(uint hConfCall, uint* lphConsultCall, const(LINECALLPARAMS)* lpCallParams);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-lineproxymessage))], [])
@DllImport("TAPI32.dll")
int lineProxyMessage(uint hLine, uint hCall, uint dwMsg, uint dwParam1, uint dwParam2, uint dwParam3);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-lineproxyresponse))], [])
@DllImport("TAPI32.dll")
int lineProxyResponse(uint hLine, LINEPROXYREQUEST* lpProxyRequest, uint dwResult);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineRedirect(uint hCall, const(PSTR) lpszDestAddress, uint dwCountryCode);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineRedirectA(uint hCall, const(PSTR) lpszDestAddress, uint dwCountryCode);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineRedirectW(uint hCall, const(PWSTR) lpszDestAddress, uint dwCountryCode);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-lineregisterrequestrecipient))], [])
@DllImport("TAPI32.dll")
int lineRegisterRequestRecipient(uint hLineApp, uint dwRegistrationInstance, uint dwRequestMode, uint bEnable);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linereleaseuseruserinfo))], [])
@DllImport("TAPI32.dll")
int lineReleaseUserUserInfo(uint hCall);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-lineremovefromconference))], [])
@DllImport("TAPI32.dll")
int lineRemoveFromConference(uint hCall);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-lineremoveprovider))], [])
@DllImport("TAPI32.dll")
int lineRemoveProvider(uint dwPermanentProviderID, HWND hwndOwner);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linesecurecall))], [])
@DllImport("TAPI32.dll")
int lineSecureCall(uint hCall);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linesenduseruserinfo))], [])
@DllImport("TAPI32.dll")
int lineSendUserUserInfo(uint hCall, const(PSTR) lpsUserUserInfo, uint dwSize);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linesetagentactivity))], [])
@DllImport("TAPI32.dll")
int lineSetAgentActivity(uint hLine, uint dwAddressID, uint dwActivityID);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linesetagentgroup))], [])
@DllImport("TAPI32.dll")
int lineSetAgentGroup(uint hLine, uint dwAddressID, LINEAGENTGROUPLIST* lpAgentGroupList);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linesetagentmeasurementperiod))], [])
@DllImport("TAPI32.dll")
int lineSetAgentMeasurementPeriod(uint hLine, uint hAgent, uint dwMeasurementPeriod);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linesetagentsessionstate))], [])
@DllImport("TAPI32.dll")
int lineSetAgentSessionState(uint hLine, uint hAgentSession, uint dwAgentSessionState, 
                             uint dwNextAgentSessionState);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linesetagentstateex))], [])
@DllImport("TAPI32.dll")
int lineSetAgentStateEx(uint hLine, uint hAgent, uint dwAgentState, uint dwNextAgentState);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linesetagentstate))], [])
@DllImport("TAPI32.dll")
int lineSetAgentState(uint hLine, uint dwAddressID, uint dwAgentState, uint dwNextAgentState);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineSetAppPriority(const(PSTR) lpszAppFilename, uint dwMediaMode, LINEEXTENSIONID* lpExtensionID, 
                       uint dwRequestMode, const(PSTR) lpszExtensionName, uint dwPriority);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineSetAppPriorityA(const(PSTR) lpszAppFilename, uint dwMediaMode, LINEEXTENSIONID* lpExtensionID, 
                        uint dwRequestMode, const(PSTR) lpszExtensionName, uint dwPriority);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineSetAppPriorityW(const(PWSTR) lpszAppFilename, uint dwMediaMode, LINEEXTENSIONID* lpExtensionID, 
                        uint dwRequestMode, const(PWSTR) lpszExtensionName, uint dwPriority);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linesetappspecific))], [])
@DllImport("TAPI32.dll")
int lineSetAppSpecific(uint hCall, uint dwAppSpecific);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linesetcalldata))], [])
@DllImport("TAPI32.dll")
int lineSetCallData(uint hCall, void* lpCallData, uint dwSize);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linesetcallparams))], [])
@DllImport("TAPI32.dll")
int lineSetCallParams(uint hCall, uint dwBearerMode, uint dwMinRate, uint dwMaxRate, 
                      const(LINEDIALPARAMS)* lpDialParams);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linesetcallprivilege))], [])
@DllImport("TAPI32.dll")
int lineSetCallPrivilege(uint hCall, uint dwCallPrivilege);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linesetcallqualityofservice))], [])
@DllImport("TAPI32.dll")
int lineSetCallQualityOfService(uint hCall, void* lpSendingFlowspec, uint dwSendingFlowspecSize, 
                                void* lpReceivingFlowspec, uint dwReceivingFlowspecSize);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linesetcalltreatment))], [])
@DllImport("TAPI32.dll")
int lineSetCallTreatment(uint hCall, uint dwTreatment);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linesetcurrentlocation))], [])
@DllImport("TAPI32.dll")
int lineSetCurrentLocation(uint hLineApp, uint dwLocation);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineSetDevConfig(uint dwDeviceID, const(void)* lpDeviceConfig, uint dwSize, const(PSTR) lpszDeviceClass);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineSetDevConfigA(uint dwDeviceID, const(void)* lpDeviceConfig, uint dwSize, const(PSTR) lpszDeviceClass);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineSetDevConfigW(uint dwDeviceID, const(void)* lpDeviceConfig, uint dwSize, const(PWSTR) lpszDeviceClass);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linesetlinedevstatus))], [])
@DllImport("TAPI32.dll")
int lineSetLineDevStatus(uint hLine, uint dwStatusToChange, uint fStatus);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linesetmediacontrol))], [])
@DllImport("TAPI32.dll")
int lineSetMediaControl(uint hLine, uint dwAddressID, uint hCall, uint dwSelect, 
                        const(LINEMEDIACONTROLDIGIT)* lpDigitList, uint dwDigitNumEntries, 
                        const(LINEMEDIACONTROLMEDIA)* lpMediaList, uint dwMediaNumEntries, 
                        const(LINEMEDIACONTROLTONE)* lpToneList, uint dwToneNumEntries, 
                        const(LINEMEDIACONTROLCALLSTATE)* lpCallStateList, uint dwCallStateNumEntries);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linesetmediamode))], [])
@DllImport("TAPI32.dll")
int lineSetMediaMode(uint hCall, uint dwMediaModes);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linesetqueuemeasurementperiod))], [])
@DllImport("TAPI32.dll")
int lineSetQueueMeasurementPeriod(uint hLine, uint dwQueueID, uint dwMeasurementPeriod);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linesetnumrings))], [])
@DllImport("TAPI32.dll")
int lineSetNumRings(uint hLine, uint dwAddressID, uint dwNumRings);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linesetstatusmessages))], [])
@DllImport("TAPI32.dll")
int lineSetStatusMessages(uint hLine, uint dwLineStates, uint dwAddressStates);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linesetterminal))], [])
@DllImport("TAPI32.dll")
int lineSetTerminal(uint hLine, uint dwAddressID, uint hCall, uint dwSelect, uint dwTerminalModes, 
                    uint dwTerminalID, uint bEnable);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineSetTollList(uint hLineApp, uint dwDeviceID, const(PSTR) lpszAddressIn, uint dwTollListOption);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineSetTollListA(uint hLineApp, uint dwDeviceID, const(PSTR) lpszAddressIn, uint dwTollListOption);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineSetTollListW(uint hLineApp, uint dwDeviceID, const(PWSTR) lpszAddressInW, uint dwTollListOption);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineSetupConference(uint hCall, uint hLine, uint* lphConfCall, uint* lphConsultCall, uint dwNumParties, 
                        const(LINECALLPARAMS)* lpCallParams);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineSetupConferenceA(uint hCall, uint hLine, uint* lphConfCall, uint* lphConsultCall, uint dwNumParties, 
                         const(LINECALLPARAMS)* lpCallParams);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineSetupConferenceW(uint hCall, uint hLine, uint* lphConfCall, uint* lphConsultCall, uint dwNumParties, 
                         const(LINECALLPARAMS)* lpCallParams);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineSetupTransfer(uint hCall, uint* lphConsultCall, const(LINECALLPARAMS)* lpCallParams);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineSetupTransferA(uint hCall, uint* lphConsultCall, const(LINECALLPARAMS)* lpCallParams);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineSetupTransferW(uint hCall, uint* lphConsultCall, const(LINECALLPARAMS)* lpCallParams);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-lineshutdown))], [])
@DllImport("TAPI32.dll")
int lineShutdown(uint hLineApp);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-lineswaphold))], [])
@DllImport("TAPI32.dll")
int lineSwapHold(uint hActiveCall, uint hHeldCall);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineTranslateAddress(uint hLineApp, uint dwDeviceID, uint dwAPIVersion, const(PSTR) lpszAddressIn, uint dwCard, 
                         uint dwTranslateOptions, LINETRANSLATEOUTPUT* lpTranslateOutput);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineTranslateAddressA(uint hLineApp, uint dwDeviceID, uint dwAPIVersion, const(PSTR) lpszAddressIn, 
                          uint dwCard, uint dwTranslateOptions, LINETRANSLATEOUTPUT* lpTranslateOutput);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineTranslateAddressW(uint hLineApp, uint dwDeviceID, uint dwAPIVersion, const(PWSTR) lpszAddressIn, 
                          uint dwCard, uint dwTranslateOptions, LINETRANSLATEOUTPUT* lpTranslateOutput);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineTranslateDialog(uint hLineApp, uint dwDeviceID, uint dwAPIVersion, HWND hwndOwner, 
                        const(PSTR) lpszAddressIn);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineTranslateDialogA(uint hLineApp, uint dwDeviceID, uint dwAPIVersion, HWND hwndOwner, 
                         const(PSTR) lpszAddressIn);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineTranslateDialogW(uint hLineApp, uint dwDeviceID, uint dwAPIVersion, HWND hwndOwner, 
                         const(PWSTR) lpszAddressIn);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-lineuncompletecall))], [])
@DllImport("TAPI32.dll")
int lineUncompleteCall(uint hLine, uint dwCompletionID);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-lineunhold))], [])
@DllImport("TAPI32.dll")
int lineUnhold(uint hCall);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineUnpark(uint hLine, uint dwAddressID, uint* lphCall, const(PSTR) lpszDestAddress);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineUnparkA(uint hLine, uint dwAddressID, uint* lphCall, const(PSTR) lpszDestAddress);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int lineUnparkW(uint hLine, uint dwAddressID, uint* lphCall, const(PWSTR) lpszDestAddress);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-phoneclose))], [])
@DllImport("TAPI32.dll")
int phoneClose(uint hPhone);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int phoneConfigDialog(uint dwDeviceID, HWND hwndOwner, const(PSTR) lpszDeviceClass);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int phoneConfigDialogA(uint dwDeviceID, HWND hwndOwner, const(PSTR) lpszDeviceClass);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int phoneConfigDialogW(uint dwDeviceID, HWND hwndOwner, const(PWSTR) lpszDeviceClass);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-phonedevspecific))], [])
@DllImport("TAPI32.dll")
int phoneDevSpecific(uint hPhone, void* lpParams, uint dwSize);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int phoneGetButtonInfo(uint hPhone, uint dwButtonLampID, PHONEBUTTONINFO* lpButtonInfo);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int phoneGetButtonInfoA(uint hPhone, uint dwButtonLampID, PHONEBUTTONINFO* lpButtonInfo);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int phoneGetButtonInfoW(uint hPhone, uint dwButtonLampID, PHONEBUTTONINFO* lpButtonInfo);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-phonegetdata))], [])
@DllImport("TAPI32.dll")
int phoneGetData(uint hPhone, uint dwDataID, void* lpData, uint dwSize);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int phoneGetDevCaps(uint hPhoneApp, uint dwDeviceID, uint dwAPIVersion, uint dwExtVersion, PHONECAPS* lpPhoneCaps);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int phoneGetDevCapsA(uint hPhoneApp, uint dwDeviceID, uint dwAPIVersion, uint dwExtVersion, PHONECAPS* lpPhoneCaps);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int phoneGetDevCapsW(uint hPhoneApp, uint dwDeviceID, uint dwAPIVersion, uint dwExtVersion, PHONECAPS* lpPhoneCaps);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-phonegetdisplay))], [])
@DllImport("TAPI32.dll")
int phoneGetDisplay(uint hPhone, VARSTRING* lpDisplay);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-phonegetgain))], [])
@DllImport("TAPI32.dll")
int phoneGetGain(uint hPhone, uint dwHookSwitchDev, uint* lpdwGain);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-phonegethookswitch))], [])
@DllImport("TAPI32.dll")
int phoneGetHookSwitch(uint hPhone, uint* lpdwHookSwitchDevs);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int phoneGetIcon(uint dwDeviceID, const(PSTR) lpszDeviceClass, HICON* lphIcon);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int phoneGetIconA(uint dwDeviceID, const(PSTR) lpszDeviceClass, HICON* lphIcon);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int phoneGetIconW(uint dwDeviceID, const(PWSTR) lpszDeviceClass, HICON* lphIcon);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int phoneGetID(uint hPhone, VARSTRING* lpDeviceID, const(PSTR) lpszDeviceClass);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int phoneGetIDA(uint hPhone, VARSTRING* lpDeviceID, const(PSTR) lpszDeviceClass);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int phoneGetIDW(uint hPhone, VARSTRING* lpDeviceID, const(PWSTR) lpszDeviceClass);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-phonegetlamp))], [])
@DllImport("TAPI32.dll")
int phoneGetLamp(uint hPhone, uint dwButtonLampID, uint* lpdwLampMode);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-phonegetmessage))], [])
@DllImport("TAPI32.dll")
int phoneGetMessage(uint hPhoneApp, PHONEMESSAGE* lpMessage, uint dwTimeout);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-phonegetring))], [])
@DllImport("TAPI32.dll")
int phoneGetRing(uint hPhone, uint* lpdwRingMode, uint* lpdwVolume);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int phoneGetStatus(uint hPhone, PHONESTATUS* lpPhoneStatus);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int phoneGetStatusA(uint hPhone, PHONESTATUS* lpPhoneStatus);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int phoneGetStatusW(uint hPhone, PHONESTATUS* lpPhoneStatus);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-phonegetstatusmessages))], [])
@DllImport("TAPI32.dll")
int phoneGetStatusMessages(uint hPhone, uint* lpdwPhoneStates, uint* lpdwButtonModes, uint* lpdwButtonStates);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-phonegetvolume))], [])
@DllImport("TAPI32.dll")
int phoneGetVolume(uint hPhone, uint dwHookSwitchDev, uint* lpdwVolume);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-phoneinitialize))], [])
@DllImport("TAPI32.dll")
int phoneInitialize(uint* lphPhoneApp, HINSTANCE hInstance, PHONECALLBACK lpfnCallback, const(PSTR) lpszAppName, 
                    uint* lpdwNumDevs);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int phoneInitializeExA(uint* lphPhoneApp, HINSTANCE hInstance, PHONECALLBACK lpfnCallback, 
                       const(PSTR) lpszFriendlyAppName, uint* lpdwNumDevs, uint* lpdwAPIVersion, 
                       PHONEINITIALIZEEXPARAMS* lpPhoneInitializeExParams);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int phoneInitializeExW(uint* lphPhoneApp, HINSTANCE hInstance, PHONECALLBACK lpfnCallback, 
                       const(PWSTR) lpszFriendlyAppName, uint* lpdwNumDevs, uint* lpdwAPIVersion, 
                       PHONEINITIALIZEEXPARAMS* lpPhoneInitializeExParams);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-phonenegotiateapiversion))], [])
@DllImport("TAPI32.dll")
int phoneNegotiateAPIVersion(uint hPhoneApp, uint dwDeviceID, uint dwAPILowVersion, uint dwAPIHighVersion, 
                             uint* lpdwAPIVersion, PHONEEXTENSIONID* lpExtensionID);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-phonenegotiateextversion))], [])
@DllImport("TAPI32.dll")
int phoneNegotiateExtVersion(uint hPhoneApp, uint dwDeviceID, uint dwAPIVersion, uint dwExtLowVersion, 
                             uint dwExtHighVersion, uint* lpdwExtVersion);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-phoneopen))], [])
@DllImport("TAPI32.dll")
int phoneOpen(uint hPhoneApp, uint dwDeviceID, uint* lphPhone, uint dwAPIVersion, uint dwExtVersion, 
              size_t dwCallbackInstance, uint dwPrivilege);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int phoneSetButtonInfo(uint hPhone, uint dwButtonLampID, const(PHONEBUTTONINFO)* lpButtonInfo);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int phoneSetButtonInfoA(uint hPhone, uint dwButtonLampID, const(PHONEBUTTONINFO)* lpButtonInfo);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int phoneSetButtonInfoW(uint hPhone, uint dwButtonLampID, const(PHONEBUTTONINFO)* lpButtonInfo);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-phonesetdata))], [])
@DllImport("TAPI32.dll")
int phoneSetData(uint hPhone, uint dwDataID, const(void)* lpData, uint dwSize);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-phonesetdisplay))], [])
@DllImport("TAPI32.dll")
int phoneSetDisplay(uint hPhone, uint dwRow, uint dwColumn, const(PSTR) lpsDisplay, uint dwSize);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-phonesetgain))], [])
@DllImport("TAPI32.dll")
int phoneSetGain(uint hPhone, uint dwHookSwitchDev, uint dwGain);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-phonesethookswitch))], [])
@DllImport("TAPI32.dll")
int phoneSetHookSwitch(uint hPhone, uint dwHookSwitchDevs, uint dwHookSwitchMode);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-phonesetlamp))], [])
@DllImport("TAPI32.dll")
int phoneSetLamp(uint hPhone, uint dwButtonLampID, uint dwLampMode);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-phonesetring))], [])
@DllImport("TAPI32.dll")
int phoneSetRing(uint hPhone, uint dwRingMode, uint dwVolume);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-phonesetstatusmessages))], [])
@DllImport("TAPI32.dll")
int phoneSetStatusMessages(uint hPhone, uint dwPhoneStates, uint dwButtonModes, uint dwButtonStates);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-phonesetvolume))], [])
@DllImport("TAPI32.dll")
int phoneSetVolume(uint hPhone, uint dwHookSwitchDev, uint dwVolume);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-phoneshutdown))], [])
@DllImport("TAPI32.dll")
int phoneShutdown(uint hPhoneApp);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int tapiGetLocationInfo(PSTR lpszCountryCode, PSTR lpszCityCode);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int tapiGetLocationInfoA(PSTR lpszCountryCode, PSTR lpszCityCode);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int tapiGetLocationInfoW(PWSTR lpszCountryCodeW, PWSTR lpszCityCodeW);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-tapirequestdrop))], [])
@DllImport("TAPI32.dll")
int tapiRequestDrop(HWND hwnd, WPARAM wRequestID);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int tapiRequestMakeCall(const(PSTR) lpszDestAddress, const(PSTR) lpszAppName, const(PSTR) lpszCalledParty, 
                        const(PSTR) lpszComment);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int tapiRequestMakeCallA(const(PSTR) lpszDestAddress, const(PSTR) lpszAppName, const(PSTR) lpszCalledParty, 
                         const(PSTR) lpszComment);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int tapiRequestMakeCallW(const(PWSTR) lpszDestAddress, const(PWSTR) lpszAppName, const(PWSTR) lpszCalledParty, 
                         const(PWSTR) lpszComment);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int tapiRequestMediaCall(HWND hwnd, WPARAM wRequestID, const(PSTR) lpszDeviceClass, const(PSTR) lpDeviceID, 
                         uint dwSize, uint dwSecure, const(PSTR) lpszDestAddress, const(PSTR) lpszAppName, 
                         const(PSTR) lpszCalledParty, const(PSTR) lpszComment);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int tapiRequestMediaCallA(HWND hwnd, WPARAM wRequestID, const(PSTR) lpszDeviceClass, const(PSTR) lpDeviceID, 
                          uint dwSize, uint dwSecure, const(PSTR) lpszDestAddress, const(PSTR) lpszAppName, 
                          const(PSTR) lpszCalledParty, const(PSTR) lpszComment);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("TAPI32.dll")
int tapiRequestMediaCallW(HWND hwnd, WPARAM wRequestID, const(PWSTR) lpszDeviceClass, const(PWSTR) lpDeviceID, 
                          uint dwSize, uint dwSecure, const(PWSTR) lpszDestAddress, const(PWSTR) lpszAppName, 
                          const(PWSTR) lpszCalledParty, const(PWSTR) lpszComment);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/office/client-developer/outlook/mapi/opentnefstream))], [])
@DllImport("MAPI32.dll")
HRESULT OpenTnefStream(void* lpvSupport, IStream lpStream, byte* lpszStreamName, uint ulFlags, IMessage lpMessage, 
                       ushort wKeyVal, ITnef* lppTNEF);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/office/client-developer/outlook/mapi/opentnefstreamex))], [])
@DllImport("MAPI32.dll")
HRESULT OpenTnefStreamEx(void* lpvSupport, IStream lpStream, byte* lpszStreamName, uint ulFlags, 
                         IMessage lpMessage, ushort wKeyVal, IAddrBook lpAdressBook, ITnef* lppTNEF);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/office/client-developer/outlook/mapi/gettnefstreamcodepage))], [])
@DllImport("MAPI32.dll")
HRESULT GetTnefStreamCodepage(IStream lpStream, uint* lpulCodepage, uint* lpulSubCodepage);


// Interfaces

@GUID("21d6d48e-a88b-11d0-83dd-00aa003ccabd")
struct TAPI;

@GUID("e9225296-c759-11d1-a02b-00c04fb6809f")
struct DispatchMapper;

@GUID("ac48ffe0-f8c4-11d1-a030-00c04fb6809f")
struct RequestMakeCall;

@GUID("f1029e5b-cb5b-11d0-8d59-00c04fd91ac0")
struct Rendezvous;

@GUID("df0daef2-a289-11d1-8697-006008b0e5d2")
struct McastAddressAllocation;

@GUID("b1efc382-9355-11d0-835c-00aa003ccabd")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-ittapi))], [])
interface ITTAPI : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittapi-initialize))], [])
    HRESULT Initialize();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittapi-shutdown))], [])
    HRESULT Shutdown();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittapi-get_addresses))], [])
    HRESULT get_Addresses(VARIANT* pVariant);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittapi-enumerateaddresses))], [])
    HRESULT EnumerateAddresses(IEnumAddress* ppEnumAddress);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittapi-registercallnotifications))], [])
    HRESULT RegisterCallNotifications(ITAddress pAddress, VARIANT_BOOL fMonitor, VARIANT_BOOL fOwner, 
                                      int lMediaTypes, int lCallbackInstance, int* plRegister);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittapi-unregisternotifications))], [])
    HRESULT UnregisterNotifications(int lRegister);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittapi-get_callhubs))], [])
    HRESULT get_CallHubs(VARIANT* pVariant);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittapi-enumeratecallhubs))], [])
    HRESULT EnumerateCallHubs(IEnumCallHub* ppEnumCallHub);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittapi-setcallhubtracking))], [])
    HRESULT SetCallHubTracking(VARIANT pAddresses, VARIANT_BOOL bTracking);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittapi-enumerateprivatetapiobjects))], [])
    HRESULT EnumeratePrivateTAPIObjects(IEnumUnknown* ppEnumUnknown);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittapi-get_privatetapiobjects))], [])
    HRESULT get_PrivateTAPIObjects(VARIANT* pVariant);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittapi-registerrequestrecipient))], [])
    HRESULT RegisterRequestRecipient(int lRegistrationInstance, int lRequestMode, VARIANT_BOOL fEnable);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittapi-setassistedtelephonypriority))], [])
    HRESULT SetAssistedTelephonyPriority(BSTR pAppFilename, VARIANT_BOOL fPriority);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittapi-setapplicationpriority))], [])
    HRESULT SetApplicationPriority(BSTR pAppFilename, int lMediaType, VARIANT_BOOL fPriority);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittapi-put_eventfilter))], [])
    HRESULT put_EventFilter(int lFilterMask);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittapi-get_eventfilter))], [])
    HRESULT get_EventFilter(int* plFilterMask);
}

@GUID("54fbdc8c-d90f-4dad-9695-b373097f094b")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-ittapi2))], [])
interface ITTAPI2 : ITTAPI
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittapi2-get_phones))], [])
    HRESULT get_Phones(VARIANT* pPhones);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittapi2-enumeratephones))], [])
    HRESULT EnumeratePhones(IEnumPhone* ppEnumPhone);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittapi2-createemptycollectionobject))], [])
    HRESULT CreateEmptyCollectionObject(ITCollection2* ppCollection);
}

@GUID("b1efc384-9355-11d0-835c-00aa003ccabd")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itmediasupport))], [])
interface ITMediaSupport : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itmediasupport-get_mediatypes))], [])
    HRESULT get_MediaTypes(int* plMediaTypes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itmediasupport-querymediatype))], [])
    HRESULT QueryMediaType(int lMediaType, VARIANT_BOOL* pfSupport);
}

@GUID("41757f4a-cf09-4b34-bc96-0a79d2390076")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itpluggableterminalclassinfo))], [])
interface ITPluggableTerminalClassInfo : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itpluggableterminalclassinfo-get_name))], [])
    HRESULT get_Name(BSTR* pName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itpluggableterminalclassinfo-get_company))], [])
    HRESULT get_Company(BSTR* pCompany);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itpluggableterminalclassinfo-get_version))], [])
    HRESULT get_Version(BSTR* pVersion);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itpluggableterminalclassinfo-get_terminalclass))], [])
    HRESULT get_TerminalClass(BSTR* pTerminalClass);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itpluggableterminalclassinfo-get_clsid))], [])
    HRESULT get_CLSID(BSTR* pCLSID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itpluggableterminalclassinfo-get_direction))], [])
    HRESULT get_Direction(TERMINAL_DIRECTION* pDirection);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itpluggableterminalclassinfo-get_mediatypes))], [])
    HRESULT get_MediaTypes(int* pMediaTypes);
}

@GUID("6d54e42c-4625-4359-a6f7-631999107e05")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itpluggableterminalsuperclassinfo))], [])
interface ITPluggableTerminalSuperclassInfo : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itpluggableterminalsuperclassinfo-get_name))], [])
    HRESULT get_Name(BSTR* pName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itpluggableterminalsuperclassinfo-get_clsid))], [])
    HRESULT get_CLSID(BSTR* pCLSID);
}

@GUID("b1efc385-9355-11d0-835c-00aa003ccabd")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itterminalsupport))], [])
interface ITTerminalSupport : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itterminalsupport-get_staticterminals))], [])
    HRESULT get_StaticTerminals(VARIANT* pVariant);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itterminalsupport-enumeratestaticterminals))], [])
    HRESULT EnumerateStaticTerminals(IEnumTerminal* ppTerminalEnumerator);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itterminalsupport-get_dynamicterminalclasses))], [])
    HRESULT get_DynamicTerminalClasses(VARIANT* pVariant);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itterminalsupport-enumeratedynamicterminalclasses))], [])
    HRESULT EnumerateDynamicTerminalClasses(IEnumTerminalClass* ppTerminalClassEnumerator);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itterminalsupport-createterminal))], [])
    HRESULT CreateTerminal(BSTR pTerminalClass, int lMediaType, TERMINAL_DIRECTION Direction, 
                           ITTerminal* ppTerminal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itterminalsupport-getdefaultstaticterminal))], [])
    HRESULT GetDefaultStaticTerminal(int lMediaType, TERMINAL_DIRECTION Direction, ITTerminal* ppTerminal);
}

@GUID("f3eb39bc-1b1f-4e99-a0c0-56305c4dd591")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itterminalsupport2))], [])
interface ITTerminalSupport2 : ITTerminalSupport
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itterminalsupport2-get_pluggablesuperclasses))], [])
    HRESULT get_PluggableSuperclasses(VARIANT* pVariant);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itterminalsupport2-enumeratepluggablesuperclasses))], [])
    HRESULT EnumeratePluggableSuperclasses(IEnumPluggableSuperclassInfo* ppSuperclassEnumerator);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itterminalsupport2-get_pluggableterminalclasses))], [])
    HRESULT get_PluggableTerminalClasses(BSTR bstrTerminalSuperclass, int lMediaType, VARIANT* pVariant);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itterminalsupport2-enumeratepluggableterminalclasses))], [])
    HRESULT EnumeratePluggableTerminalClasses(GUID iidTerminalSuperclass, int lMediaType, 
                                              IEnumPluggableTerminalClassInfo* ppClassEnumerator);
}

@GUID("b1efc386-9355-11d0-835c-00aa003ccabd")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itaddress))], [])
interface ITAddress : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddress-get_state))], [])
    HRESULT get_State(ADDRESS_STATE* pAddressState);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddress-get_addressname))], [])
    HRESULT get_AddressName(BSTR* ppName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddress-get_serviceprovidername))], [])
    HRESULT get_ServiceProviderName(BSTR* ppName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddress-get_tapiobject))], [])
    HRESULT get_TAPIObject(ITTAPI* ppTapiObject);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddress-createcall))], [])
    HRESULT CreateCall(BSTR pDestAddress, int lAddressType, int lMediaTypes, ITBasicCallControl* ppCall);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddress-get_calls))], [])
    HRESULT get_Calls(VARIANT* pVariant);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddress-enumeratecalls))], [])
    HRESULT EnumerateCalls(IEnumCall* ppCallEnum);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddress-get_dialableaddress))], [])
    HRESULT get_DialableAddress(BSTR* pDialableAddress);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddress-createforwardinfoobject))], [])
    HRESULT CreateForwardInfoObject(ITForwardInformation* ppForwardInfo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddress-forward))], [])
    HRESULT Forward(ITForwardInformation pForwardInfo, ITBasicCallControl pCall);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddress-get_currentforwardinfo))], [])
    HRESULT get_CurrentForwardInfo(ITForwardInformation* ppForwardInfo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddress-put_messagewaiting))], [])
    HRESULT put_MessageWaiting(VARIANT_BOOL fMessageWaiting);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddress-get_messagewaiting))], [])
    HRESULT get_MessageWaiting(VARIANT_BOOL* pfMessageWaiting);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddress-put_donotdisturb))], [])
    HRESULT put_DoNotDisturb(VARIANT_BOOL fDoNotDisturb);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddress-get_donotdisturb))], [])
    HRESULT get_DoNotDisturb(VARIANT_BOOL* pfDoNotDisturb);
}

@GUID("b0ae5d9b-be51-46c9-b0f7-dfa8a22a8bc4")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itaddress2))], [])
interface ITAddress2 : ITAddress
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddress2-get_phones))], [])
    HRESULT get_Phones(VARIANT* pPhones);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddress2-enumeratephones))], [])
    HRESULT EnumeratePhones(IEnumPhone* ppEnumPhone);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddress2-getphonefromterminal))], [])
    HRESULT GetPhoneFromTerminal(ITTerminal pTerminal, ITPhone* ppPhone);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddress2-get_preferredphones))], [])
    HRESULT get_PreferredPhones(VARIANT* pPhones);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddress2-enumeratepreferredphones))], [])
    HRESULT EnumeratePreferredPhones(IEnumPhone* ppEnumPhone);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddress2-get_eventfilter))], [])
    HRESULT get_EventFilter(TAPI_EVENT TapiEvent, int lSubEvent, VARIANT_BOOL* pEnable);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddress2-put_eventfilter))], [])
    HRESULT put_EventFilter(TAPI_EVENT TapiEvent, int lSubEvent, VARIANT_BOOL bEnable);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddress2-devicespecific))], [])
    HRESULT DeviceSpecific(ITCallInfo pCall, ubyte* pParams, uint dwSize);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddress2-devicespecificvariant))], [])
    HRESULT DeviceSpecificVariant(ITCallInfo pCall, VARIANT varDevSpecificByteArray);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddress2-negotiateextversion))], [])
    HRESULT NegotiateExtVersion(int lLowVersion, int lHighVersion, int* plExtVersion);
}

@GUID("8df232f5-821b-11d1-bb5c-00c04fb6809f")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itaddresscapabilities))], [])
interface ITAddressCapabilities : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddresscapabilities-get_addresscapability))], [])
    HRESULT get_AddressCapability(ADDRESS_CAPABILITY AddressCap, int* plCapability);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddresscapabilities-get_addresscapabilitystring))], [])
    HRESULT get_AddressCapabilityString(ADDRESS_CAPABILITY_STRING AddressCapString, BSTR* ppCapabilityString);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddresscapabilities-get_calltreatments))], [])
    HRESULT get_CallTreatments(VARIANT* pVariant);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddresscapabilities-enumeratecalltreatments))], [])
    HRESULT EnumerateCallTreatments(IEnumBstr* ppEnumCallTreatment);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddresscapabilities-get_completionmessages))], [])
    HRESULT get_CompletionMessages(VARIANT* pVariant);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddresscapabilities-enumeratecompletionmessages))], [])
    HRESULT EnumerateCompletionMessages(IEnumBstr* ppEnumCompletionMessage);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddresscapabilities-get_deviceclasses))], [])
    HRESULT get_DeviceClasses(VARIANT* pVariant);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddresscapabilities-enumeratedeviceclasses))], [])
    HRESULT EnumerateDeviceClasses(IEnumBstr* ppEnumDeviceClass);
}

@GUID("09d48db4-10cc-4388-9de7-a8465618975a")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itphone))], [])
interface ITPhone : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-open))], [])
    HRESULT Open(PHONE_PRIVILEGE Privilege);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-close))], [])
    HRESULT Close();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-get_addresses))], [])
    HRESULT get_Addresses(VARIANT* pAddresses);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-enumerateaddresses))], [])
    HRESULT EnumerateAddresses(IEnumAddress* ppEnumAddress);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-get_phonecapslong))], [])
    HRESULT get_PhoneCapsLong(PHONECAPS_LONG pclCap, int* plCapability);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-get_phonecapsstring))], [])
    HRESULT get_PhoneCapsString(PHONECAPS_STRING pcsCap, BSTR* ppCapability);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-get_terminals))], [])
    HRESULT get_Terminals(ITAddress pAddress, VARIANT* pTerminals);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-enumerateterminals))], [])
    HRESULT EnumerateTerminals(ITAddress pAddress, IEnumTerminal* ppEnumTerminal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-get_buttonmode))], [])
    HRESULT get_ButtonMode(int lButtonID, PHONE_BUTTON_MODE* pButtonMode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-put_buttonmode))], [])
    HRESULT put_ButtonMode(int lButtonID, PHONE_BUTTON_MODE ButtonMode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-get_buttonfunction))], [])
    HRESULT get_ButtonFunction(int lButtonID, PHONE_BUTTON_FUNCTION* pButtonFunction);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-put_buttonfunction))], [])
    HRESULT put_ButtonFunction(int lButtonID, PHONE_BUTTON_FUNCTION ButtonFunction);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-get_buttontext))], [])
    HRESULT get_ButtonText(int lButtonID, BSTR* ppButtonText);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-put_buttontext))], [])
    HRESULT put_ButtonText(int lButtonID, BSTR bstrButtonText);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-get_buttonstate))], [])
    HRESULT get_ButtonState(int lButtonID, PHONE_BUTTON_STATE* pButtonState);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-get_hookswitchstate))], [])
    HRESULT get_HookSwitchState(PHONE_HOOK_SWITCH_DEVICE HookSwitchDevice, 
                                PHONE_HOOK_SWITCH_STATE* pHookSwitchState);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-put_hookswitchstate))], [])
    HRESULT put_HookSwitchState(PHONE_HOOK_SWITCH_DEVICE HookSwitchDevice, PHONE_HOOK_SWITCH_STATE HookSwitchState);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-put_ringmode))], [])
    HRESULT put_RingMode(int lRingMode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-get_ringmode))], [])
    HRESULT get_RingMode(int* plRingMode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-put_ringvolume))], [])
    HRESULT put_RingVolume(int lRingVolume);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-get_ringvolume))], [])
    HRESULT get_RingVolume(int* plRingVolume);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-get_privilege))], [])
    HRESULT get_Privilege(PHONE_PRIVILEGE* pPrivilege);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-getphonecapsbuffer))], [])
    HRESULT GetPhoneCapsBuffer(PHONECAPS_BUFFER pcbCaps, uint* pdwSize, ubyte** ppPhoneCapsBuffer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-get_phonecapsbuffer))], [])
    HRESULT get_PhoneCapsBuffer(PHONECAPS_BUFFER pcbCaps, VARIANT* pVarBuffer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-get_lampmode))], [])
    HRESULT get_LampMode(int lLampID, PHONE_LAMP_MODE* pLampMode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-put_lampmode))], [])
    HRESULT put_LampMode(int lLampID, PHONE_LAMP_MODE LampMode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-get_display))], [])
    HRESULT get_Display(BSTR* pbstrDisplay);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-setdisplay))], [])
    HRESULT SetDisplay(int lRow, int lColumn, BSTR bstrDisplay);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-get_preferredaddresses))], [])
    HRESULT get_PreferredAddresses(VARIANT* pAddresses);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-enumeratepreferredaddresses))], [])
    HRESULT EnumeratePreferredAddresses(IEnumAddress* ppEnumAddress);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-devicespecific))], [])
    HRESULT DeviceSpecific(ubyte* pParams, uint dwSize);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-devicespecificvariant))], [])
    HRESULT DeviceSpecificVariant(VARIANT varDevSpecificByteArray);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-negotiateextversion))], [])
    HRESULT NegotiateExtVersion(int lLowVersion, int lHighVersion, int* plExtVersion);
}

@GUID("1ee1af0e-6159-4a61-b79b-6a4ba3fc9dfc")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itautomatedphonecontrol))], [])
interface ITAutomatedPhoneControl : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-starttone))], [])
    HRESULT StartTone(PHONE_TONE Tone, int lDuration);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-stoptone))], [])
    HRESULT StopTone();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-get_tone))], [])
    HRESULT get_Tone(PHONE_TONE* pTone);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-startringer))], [])
    HRESULT StartRinger(int lRingMode, int lDuration);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-stopringer))], [])
    HRESULT StopRinger();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-get_ringer))], [])
    HRESULT get_Ringer(VARIANT_BOOL* pfRinging);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-put_phonehandlingenabled))], [])
    HRESULT put_PhoneHandlingEnabled(VARIANT_BOOL fEnabled);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-get_phonehandlingenabled))], [])
    HRESULT get_PhoneHandlingEnabled(VARIANT_BOOL* pfEnabled);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-put_autoendofnumbertimeout))], [])
    HRESULT put_AutoEndOfNumberTimeout(int lTimeout);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-get_autoendofnumbertimeout))], [])
    HRESULT get_AutoEndOfNumberTimeout(int* plTimeout);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-put_autodialtone))], [])
    HRESULT put_AutoDialtone(VARIANT_BOOL fEnabled);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-get_autodialtone))], [])
    HRESULT get_AutoDialtone(VARIANT_BOOL* pfEnabled);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-put_autostoptonesononhook))], [])
    HRESULT put_AutoStopTonesOnOnHook(VARIANT_BOOL fEnabled);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-get_autostoptonesononhook))], [])
    HRESULT get_AutoStopTonesOnOnHook(VARIANT_BOOL* pfEnabled);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-put_autostopringonoffhook))], [])
    HRESULT put_AutoStopRingOnOffHook(VARIANT_BOOL fEnabled);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-get_autostopringonoffhook))], [])
    HRESULT get_AutoStopRingOnOffHook(VARIANT_BOOL* pfEnabled);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-put_autokeypadtones))], [])
    HRESULT put_AutoKeypadTones(VARIANT_BOOL fEnabled);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-get_autokeypadtones))], [])
    HRESULT get_AutoKeypadTones(VARIANT_BOOL* pfEnabled);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-put_autokeypadtonesminimumduration))], [])
    HRESULT put_AutoKeypadTonesMinimumDuration(int lDuration);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-get_autokeypadtonesminimumduration))], [])
    HRESULT get_AutoKeypadTonesMinimumDuration(int* plDuration);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-put_autovolumecontrol))], [])
    HRESULT put_AutoVolumeControl(VARIANT_BOOL fEnabled);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-get_autovolumecontrol))], [])
    HRESULT get_AutoVolumeControl(VARIANT_BOOL* fEnabled);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-put_autovolumecontrolstep))], [])
    HRESULT put_AutoVolumeControlStep(int lStepSize);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-get_autovolumecontrolstep))], [])
    HRESULT get_AutoVolumeControlStep(int* plStepSize);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-put_autovolumecontrolrepeatdelay))], [])
    HRESULT put_AutoVolumeControlRepeatDelay(int lDelay);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-get_autovolumecontrolrepeatdelay))], [])
    HRESULT get_AutoVolumeControlRepeatDelay(int* plDelay);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-put_autovolumecontrolrepeatperiod))], [])
    HRESULT put_AutoVolumeControlRepeatPeriod(int lPeriod);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-get_autovolumecontrolrepeatperiod))], [])
    HRESULT get_AutoVolumeControlRepeatPeriod(int* plPeriod);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-selectcall))], [])
    HRESULT SelectCall(ITCallInfo pCall, VARIANT_BOOL fSelectDefaultTerminals);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-unselectcall))], [])
    HRESULT UnselectCall(ITCallInfo pCall);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-enumerateselectedcalls))], [])
    HRESULT EnumerateSelectedCalls(IEnumCall* ppCallEnum);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-get_selectedcalls))], [])
    HRESULT get_SelectedCalls(VARIANT* pVariant);
}

@GUID("b1efc389-9355-11d0-835c-00aa003ccabd")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itbasiccallcontrol))], [])
interface ITBasicCallControl : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itbasiccallcontrol-connect))], [])
    HRESULT Connect(VARIANT_BOOL fSync);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itbasiccallcontrol-answer))], [])
    HRESULT Answer();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itbasiccallcontrol-disconnect))], [])
    HRESULT Disconnect(DISCONNECT_CODE code);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itbasiccallcontrol-hold))], [])
    HRESULT Hold(VARIANT_BOOL fHold);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itbasiccallcontrol-handoffdirect))], [])
    HRESULT HandoffDirect(BSTR pApplicationName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itbasiccallcontrol-handoffindirect))], [])
    HRESULT HandoffIndirect(int lMediaType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itbasiccallcontrol-conference))], [])
    HRESULT Conference(ITBasicCallControl pCall, VARIANT_BOOL fSync);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itbasiccallcontrol-transfer))], [])
    HRESULT Transfer(ITBasicCallControl pCall, VARIANT_BOOL fSync);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itbasiccallcontrol-blindtransfer))], [])
    HRESULT BlindTransfer(BSTR pDestAddress);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itbasiccallcontrol-swaphold))], [])
    HRESULT SwapHold(ITBasicCallControl pCall);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itbasiccallcontrol-parkdirect))], [])
    HRESULT ParkDirect(BSTR pParkAddress);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itbasiccallcontrol-parkindirect))], [])
    HRESULT ParkIndirect(BSTR* ppNonDirAddress);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itbasiccallcontrol-unpark))], [])
    HRESULT Unpark();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itbasiccallcontrol-setqos))], [])
    HRESULT SetQOS(int lMediaType, QOS_SERVICE_LEVEL ServiceLevel);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itbasiccallcontrol-pickup))], [])
    HRESULT Pickup(BSTR pGroupID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itbasiccallcontrol-dial))], [])
    HRESULT Dial(BSTR pDestAddress);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itbasiccallcontrol-finish))], [])
    HRESULT Finish(FINISH_MODE finishMode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itbasiccallcontrol-removefromconference))], [])
    HRESULT RemoveFromConference();
}

@GUID("350f85d1-1227-11d3-83d4-00c04fb6809f")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itcallinfo))], [])
interface ITCallInfo : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallinfo-get_address))], [])
    HRESULT get_Address(ITAddress* ppAddress);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallinfo-get_callstate))], [])
    HRESULT get_CallState(CALL_STATE* pCallState);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallinfo-get_privilege))], [])
    HRESULT get_Privilege(CALL_PRIVILEGE* pPrivilege);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallinfo-get_callhub))], [])
    HRESULT get_CallHub(ITCallHub* ppCallHub);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallinfo-get_callinfolong))], [])
    HRESULT get_CallInfoLong(CALLINFO_LONG CallInfoLong, int* plCallInfoLongVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallinfo-put_callinfolong))], [])
    HRESULT put_CallInfoLong(CALLINFO_LONG CallInfoLong, int lCallInfoLongVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallinfo-get_callinfostring))], [])
    HRESULT get_CallInfoString(CALLINFO_STRING CallInfoString, BSTR* ppCallInfoString);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallinfo-put_callinfostring))], [])
    HRESULT put_CallInfoString(CALLINFO_STRING CallInfoString, BSTR pCallInfoString);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallinfo-get_callinfobuffer))], [])
    HRESULT get_CallInfoBuffer(CALLINFO_BUFFER CallInfoBuffer, VARIANT* ppCallInfoBuffer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallinfo-put_callinfobuffer))], [])
    HRESULT put_CallInfoBuffer(CALLINFO_BUFFER CallInfoBuffer, VARIANT pCallInfoBuffer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallinfo-getcallinfobuffer))], [])
    HRESULT GetCallInfoBuffer(CALLINFO_BUFFER CallInfoBuffer, uint* pdwSize, ubyte** ppCallInfoBuffer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallinfo-setcallinfobuffer))], [])
    HRESULT SetCallInfoBuffer(CALLINFO_BUFFER CallInfoBuffer, uint dwSize, ubyte* pCallInfoBuffer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallinfo-releaseuseruserinfo))], [])
    HRESULT ReleaseUserUserInfo();
}

@GUID("94d70ca6-7ab0-4daa-81ca-b8f8643faec1")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itcallinfo2))], [])
interface ITCallInfo2 : ITCallInfo
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallinfo2-get_eventfilter))], [])
    HRESULT get_EventFilter(TAPI_EVENT TapiEvent, int lSubEvent, VARIANT_BOOL* pEnable);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallinfo2-put_eventfilter))], [])
    HRESULT put_EventFilter(TAPI_EVENT TapiEvent, int lSubEvent, VARIANT_BOOL bEnable);
}

@GUID("b1efc38a-9355-11d0-835c-00aa003ccabd")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itterminal))], [])
interface ITTerminal : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itterminal-get_name))], [])
    HRESULT get_Name(BSTR* ppName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itterminal-get_state))], [])
    HRESULT get_State(TERMINAL_STATE* pTerminalState);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itterminal-get_terminaltype))], [])
    HRESULT get_TerminalType(TERMINAL_TYPE* pType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itterminal-get_terminalclass))], [])
    HRESULT get_TerminalClass(BSTR* ppTerminalClass);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itterminal-get_mediatype))], [])
    HRESULT get_MediaType(int* plMediaType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itterminal-get_direction))], [])
    HRESULT get_Direction(TERMINAL_DIRECTION* pDirection);
}

@GUID("fe040091-ade8-4072-95c9-bf7de8c54b44")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itmultitrackterminal))], [])
interface ITMultiTrackTerminal : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itmultitrackterminal-get_trackterminals))], [])
    HRESULT get_TrackTerminals(VARIANT* pVariant);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itmultitrackterminal-enumeratetrackterminals))], [])
    HRESULT EnumerateTrackTerminals(IEnumTerminal* ppEnumTerminal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itmultitrackterminal-createtrackterminal))], [])
    HRESULT CreateTrackTerminal(int MediaType, TERMINAL_DIRECTION TerminalDirection, ITTerminal* ppTerminal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itmultitrackterminal-get_mediatypesinuse))], [])
    HRESULT get_MediaTypesInUse(int* plMediaTypesInUse);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itmultitrackterminal-get_directionsinuse))], [])
    HRESULT get_DirectionsInUse(TERMINAL_DIRECTION* plDirectionsInUsed);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itmultitrackterminal-removetrackterminal))], [])
    HRESULT RemoveTrackTerminal(ITTerminal pTrackTerminalToRemove);
}

@GUID("31ca6ea9-c08a-4bea-8811-8e9c1ba3ea3a")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itfiletrack))], [])
interface ITFileTrack : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itfiletrack-get_format))], [])
    HRESULT get_Format(AM_MEDIA_TYPE** ppmt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itfiletrack-put_format))], [])
    HRESULT put_Format(const(AM_MEDIA_TYPE)* pmt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itfiletrack-get_controllingterminal))], [])
    HRESULT get_ControllingTerminal(ITTerminal* ppControllingTerminal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itfiletrack-get_audioformatforscripting))], [])
    HRESULT get_AudioFormatForScripting(ITScriptableAudioFormat* ppAudioFormat);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itfiletrack-put_audioformatforscripting))], [])
    HRESULT put_AudioFormatForScripting(ITScriptableAudioFormat pAudioFormat);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itfiletrack-get_emptyaudioformatforscripting))], [])
    HRESULT get_EmptyAudioFormatForScripting(ITScriptableAudioFormat* ppAudioFormat);
}

@GUID("627e8ae6-ae4c-4a69-bb63-2ad625404b77")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itmediaplayback))], [])
interface ITMediaPlayback : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itmediaplayback-put_playlist))], [])
    HRESULT put_PlayList(VARIANT PlayListVariant);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itmediaplayback-get_playlist))], [])
    HRESULT get_PlayList(VARIANT* pPlayListVariant);
}

@GUID("f5dd4592-5476-4cc1-9d4d-fad3eefe7db2")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itmediarecord))], [])
interface ITMediaRecord : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itmediarecord-put_filename))], [])
    HRESULT put_FileName(BSTR bstrFileName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itmediarecord-get_filename))], [])
    HRESULT get_FileName(BSTR* pbstrFileName);
}

@GUID("c445dde8-5199-4bc7-9807-5ffb92e42e09")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itmediacontrol))], [])
interface ITMediaControl : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itmediacontrol-start))], [])
    HRESULT Start();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itmediacontrol-stop))], [])
    HRESULT Stop();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itmediacontrol-pause))], [])
    HRESULT Pause();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itmediacontrol-get_mediastate))], [])
    HRESULT get_MediaState(TERMINAL_MEDIA_STATE* pTerminalMediaState);
}

@GUID("b1efc38d-9355-11d0-835c-00aa003ccabd")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itbasicaudioterminal))], [])
interface ITBasicAudioTerminal : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itbasicaudioterminal-put_volume))], [])
    HRESULT put_Volume(int lVolume);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itbasicaudioterminal-get_volume))], [])
    HRESULT get_Volume(int* plVolume);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itbasicaudioterminal-put_balance))], [])
    HRESULT put_Balance(int lBalance);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itbasicaudioterminal-get_balance))], [])
    HRESULT get_Balance(int* plBalance);
}

@GUID("a86b7871-d14c-48e6-922e-a8d15f984800")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itstaticaudioterminal))], [])
interface ITStaticAudioTerminal : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itstaticaudioterminal-get_waveid))], [])
    HRESULT get_WaveId(int* plWaveId);
}

@GUID("a3c1544e-5b92-11d1-8f4e-00c04fb6809f")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itcallhub))], [])
interface ITCallHub : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallhub-clear))], [])
    HRESULT Clear();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallhub-enumeratecalls))], [])
    HRESULT EnumerateCalls(IEnumCall* ppEnumCall);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallhub-get_calls))], [])
    HRESULT get_Calls(VARIANT* pCalls);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallhub-get_numcalls))], [])
    HRESULT get_NumCalls(int* plCalls);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallhub-get_state))], [])
    HRESULT get_State(CALLHUB_STATE* pState);
}

@GUID("ab493640-4c0b-11d2-a046-00c04fb6809f")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itlegacyaddressmediacontrol))], [])
interface ITLegacyAddressMediaControl : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlegacyaddressmediacontrol-getid))], [])
    HRESULT GetID(BSTR pDeviceClass, uint* pdwSize, ubyte** ppDeviceID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlegacyaddressmediacontrol-getdevconfig))], [])
    HRESULT GetDevConfig(BSTR pDeviceClass, uint* pdwSize, ubyte** ppDeviceConfig);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlegacyaddressmediacontrol-setdevconfig))], [])
    HRESULT SetDevConfig(BSTR pDeviceClass, uint dwSize, ubyte* pDeviceConfig);
}

@GUID("0e269cd0-10d4-4121-9c22-9c85d625650d")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itprivateevent))], [])
interface ITPrivateEvent : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itprivateevent-get_address))], [])
    HRESULT get_Address(ITAddress* ppAddress);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itprivateevent-get_call))], [])
    HRESULT get_Call(ITCallInfo* ppCallInfo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itprivateevent-get_callhub))], [])
    HRESULT get_CallHub(ITCallHub* ppCallHub);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itprivateevent-get_eventcode))], [])
    HRESULT get_EventCode(int* plEventCode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itprivateevent-get_eventinterface))], [])
    HRESULT get_EventInterface(IDispatch* pEventInterface);
}

@GUID("b0ee512b-a531-409e-9dd9-4099fe86c738")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itlegacyaddressmediacontrol2))], [])
interface ITLegacyAddressMediaControl2 : ITLegacyAddressMediaControl
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlegacyaddressmediacontrol2-configdialog))], [])
    HRESULT ConfigDialog(HWND hwndOwner, BSTR pDeviceClass);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlegacyaddressmediacontrol2-configdialogedit))], [])
    HRESULT ConfigDialogEdit(HWND hwndOwner, BSTR pDeviceClass, uint dwSizeIn, ubyte* pDeviceConfigIn, 
                             uint* pdwSizeOut, ubyte** ppDeviceConfigOut);
}

@GUID("d624582f-cc23-4436-b8a5-47c625c8045d")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itlegacycallmediacontrol))], [])
interface ITLegacyCallMediaControl : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlegacycallmediacontrol-detectdigits))], [])
    HRESULT DetectDigits(int DigitMode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlegacycallmediacontrol-generatedigits))], [])
    HRESULT GenerateDigits(BSTR pDigits, int DigitMode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlegacycallmediacontrol-getid))], [])
    HRESULT GetID(BSTR pDeviceClass, uint* pdwSize, ubyte** ppDeviceID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlegacycallmediacontrol-setmediatype))], [])
    HRESULT SetMediaType(int lMediaType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlegacycallmediacontrol-monitormedia))], [])
    HRESULT MonitorMedia(int lMediaType);
}

@GUID("57ca332d-7bc2-44f1-a60c-936fe8d7ce73")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itlegacycallmediacontrol2))], [])
interface ITLegacyCallMediaControl2 : ITLegacyCallMediaControl
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlegacycallmediacontrol2-generatedigits2))], [])
    HRESULT GenerateDigits2(BSTR pDigits, int DigitMode, int lDuration);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlegacycallmediacontrol2-gatherdigits))], [])
    HRESULT GatherDigits(int DigitMode, int lNumDigits, BSTR pTerminationDigits, int lFirstDigitTimeout, 
                         int lInterDigitTimeout);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlegacycallmediacontrol2-detecttones))], [])
    HRESULT DetectTones(TAPI_DETECTTONE* pToneList, int lNumTones);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlegacycallmediacontrol2-detecttonesbycollection))], [])
    HRESULT DetectTonesByCollection(ITCollection2 pDetectToneCollection);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlegacycallmediacontrol2-generatetone))], [])
    HRESULT GenerateTone(TAPI_TONEMODE ToneMode, int lDuration);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlegacycallmediacontrol2-generatecustomtones))], [])
    HRESULT GenerateCustomTones(TAPI_CUSTOMTONE* pToneList, int lNumTones, int lDuration);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlegacycallmediacontrol2-generatecustomtonesbycollection))], [])
    HRESULT GenerateCustomTonesByCollection(ITCollection2 pCustomToneCollection, int lDuration);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlegacycallmediacontrol2-createdetecttoneobject))], [])
    HRESULT CreateDetectToneObject(ITDetectTone* ppDetectTone);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlegacycallmediacontrol2-createcustomtoneobject))], [])
    HRESULT CreateCustomToneObject(ITCustomTone* ppCustomTone);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlegacycallmediacontrol2-getidasvariant))], [])
    HRESULT GetIDAsVariant(BSTR bstrDeviceClass, VARIANT* pVarDeviceID);
}

@GUID("961f79bd-3097-49df-a1d6-909b77e89ca0")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itdetecttone))], [])
interface ITDetectTone : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itdetecttone-get_appspecific))], [])
    HRESULT get_AppSpecific(int* plAppSpecific);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itdetecttone-put_appspecific))], [])
    HRESULT put_AppSpecific(int lAppSpecific);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itdetecttone-get_duration))], [])
    HRESULT get_Duration(int* plDuration);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itdetecttone-put_duration))], [])
    HRESULT put_Duration(int lDuration);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itdetecttone-get_frequency))], [])
    HRESULT get_Frequency(int Index, int* plFrequency);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itdetecttone-put_frequency))], [])
    HRESULT put_Frequency(int Index, int lFrequency);
}

@GUID("357ad764-b3c6-4b2a-8fa5-0722827a9254")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itcustomtone))], [])
interface ITCustomTone : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcustomtone-get_frequency))], [])
    HRESULT get_Frequency(int* plFrequency);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcustomtone-put_frequency))], [])
    HRESULT put_Frequency(int lFrequency);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcustomtone-get_cadenceon))], [])
    HRESULT get_CadenceOn(int* plCadenceOn);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcustomtone-put_cadenceon))], [])
    HRESULT put_CadenceOn(int CadenceOn);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcustomtone-get_cadenceoff))], [])
    HRESULT get_CadenceOff(int* plCadenceOff);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcustomtone-put_cadenceoff))], [])
    HRESULT put_CadenceOff(int lCadenceOff);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcustomtone-get_volume))], [])
    HRESULT get_Volume(int* plVolume);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcustomtone-put_volume))], [])
    HRESULT put_Volume(int lVolume);
}

@GUID("f15b7669-4780-4595-8c89-fb369c8cf7aa")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-ienumphone))], [])
interface IEnumPhone : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumphone-next))], [])
    HRESULT Next(uint celt, ITPhone* ppElements, uint* pceltFetched);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumphone-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumphone-skip))], [])
    HRESULT Skip(uint celt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumphone-clone))], [])
    HRESULT Clone(IEnumPhone* ppEnum);
}

@GUID("ae269cf4-935e-11d0-835c-00aa003ccabd")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-ienumterminal))], [])
interface IEnumTerminal : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumterminal-next))], [])
    HRESULT Next(uint celt, ITTerminal* ppElements, uint* pceltFetched);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumterminal-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumterminal-skip))], [])
    HRESULT Skip(uint celt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumterminal-clone))], [])
    HRESULT Clone(IEnumTerminal* ppEnum);
}

@GUID("ae269cf5-935e-11d0-835c-00aa003ccabd")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-ienumterminalclass))], [])
interface IEnumTerminalClass : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumterminalclass-next))], [])
    HRESULT Next(uint celt, GUID* pElements, uint* pceltFetched);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumterminalclass-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumterminalclass-skip))], [])
    HRESULT Skip(uint celt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumterminalclass-clone))], [])
    HRESULT Clone(IEnumTerminalClass* ppEnum);
}

@GUID("ae269cf6-935e-11d0-835c-00aa003ccabd")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-ienumcall))], [])
interface IEnumCall : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumcall-next))], [])
    HRESULT Next(uint celt, ITCallInfo* ppElements, uint* pceltFetched);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumcall-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumcall-skip))], [])
    HRESULT Skip(uint celt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumcall-clone))], [])
    HRESULT Clone(IEnumCall* ppEnum);
}

@GUID("1666fca1-9363-11d0-835c-00aa003ccabd")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-ienumaddress))], [])
interface IEnumAddress : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumaddress-next))], [])
    HRESULT Next(uint celt, ITAddress* ppElements, uint* pceltFetched);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumaddress-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumaddress-skip))], [])
    HRESULT Skip(uint celt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumaddress-clone))], [])
    HRESULT Clone(IEnumAddress* ppEnum);
}

@GUID("a3c15450-5b92-11d1-8f4e-00c04fb6809f")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-ienumcallhub))], [])
interface IEnumCallHub : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumcallhub-next))], [])
    HRESULT Next(uint celt, ITCallHub* ppElements, uint* pceltFetched);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumcallhub-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumcallhub-skip))], [])
    HRESULT Skip(uint celt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumcallhub-clone))], [])
    HRESULT Clone(IEnumCallHub* ppEnum);
}

@GUID("35372049-0bc6-11d2-a033-00c04fb6809f")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-ienumbstr))], [])
interface IEnumBstr : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumbstr-next))], [])
    HRESULT Next(uint celt, BSTR* ppStrings, uint* pceltFetched);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumbstr-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumbstr-skip))], [])
    HRESULT Skip(uint celt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumbstr-clone))], [])
    HRESULT Clone(IEnumBstr* ppEnum);
}

@GUID("4567450c-dbee-4e3f-aaf5-37bf9ebf5e29")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-ienumpluggableterminalclassinfo))], [])
interface IEnumPluggableTerminalClassInfo : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumpluggableterminalclassinfo-next))], [])
    HRESULT Next(uint celt, ITPluggableTerminalClassInfo* ppElements, uint* pceltFetched);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumpluggableterminalclassinfo-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumpluggableterminalclassinfo-skip))], [])
    HRESULT Skip(uint celt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumpluggableterminalclassinfo-clone))], [])
    HRESULT Clone(IEnumPluggableTerminalClassInfo* ppEnum);
}

@GUID("e9586a80-89e6-4cff-931d-478d5751f4c0")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-ienumpluggablesuperclassinfo))], [])
interface IEnumPluggableSuperclassInfo : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumpluggablesuperclassinfo-next))], [])
    HRESULT Next(uint celt, ITPluggableTerminalSuperclassInfo* ppElements, uint* pceltFetched);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumpluggablesuperclassinfo-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumpluggablesuperclassinfo-skip))], [])
    HRESULT Skip(uint celt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumpluggablesuperclassinfo-clone))], [])
    HRESULT Clone(IEnumPluggableSuperclassInfo* ppEnum);
}

@GUID("8f942dd8-64ed-4aaf-a77d-b23db0837ead")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itphoneevent))], [])
interface ITPhoneEvent : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphoneevent-get_phone))], [])
    HRESULT get_Phone(ITPhone* ppPhone);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphoneevent-get_event))], [])
    HRESULT get_Event(PHONE_EVENT* pEvent);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphoneevent-get_buttonstate))], [])
    HRESULT get_ButtonState(PHONE_BUTTON_STATE* pState);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphoneevent-get_hookswitchstate))], [])
    HRESULT get_HookSwitchState(PHONE_HOOK_SWITCH_STATE* pState);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphoneevent-get_hookswitchdevice))], [])
    HRESULT get_HookSwitchDevice(PHONE_HOOK_SWITCH_DEVICE* pDevice);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphoneevent-get_ringmode))], [])
    HRESULT get_RingMode(int* plRingMode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphoneevent-get_buttonlampid))], [])
    HRESULT get_ButtonLampId(int* plButtonLampId);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphoneevent-get_numbergathered))], [])
    HRESULT get_NumberGathered(BSTR* ppNumber);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphoneevent-get_call))], [])
    HRESULT get_Call(ITCallInfo* ppCallInfo);
}

@GUID("62f47097-95c9-11d0-835d-00aa003ccabd")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itcallstateevent))], [])
interface ITCallStateEvent : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallstateevent-get_call))], [])
    HRESULT get_Call(ITCallInfo* ppCallInfo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallstateevent-get_state))], [])
    HRESULT get_State(CALL_STATE* pCallState);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallstateevent-get_cause))], [])
    HRESULT get_Cause(CALL_STATE_EVENT_CAUSE* pCEC);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallstateevent-get_callbackinstance))], [])
    HRESULT get_CallbackInstance(int* plCallbackInstance);
}

@GUID("63ffb2a6-872b-4cd3-a501-326e8fb40af7")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itphonedevicespecificevent))], [])
interface ITPhoneDeviceSpecificEvent : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphonedevicespecificevent-get_phone))], [])
    HRESULT get_Phone(ITPhone* ppPhone);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphonedevicespecificevent-get_lparam1))], [])
    HRESULT get_lParam1(int* pParam1);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphonedevicespecificevent-get_lparam2))], [])
    HRESULT get_lParam2(int* pParam2);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphonedevicespecificevent-get_lparam3))], [])
    HRESULT get_lParam3(int* pParam3);
}

@GUID("ff36b87f-ec3a-11d0-8ee4-00c04fb6809f")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itcallmediaevent))], [])
interface ITCallMediaEvent : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallmediaevent-get_call))], [])
    HRESULT get_Call(ITCallInfo* ppCallInfo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallmediaevent-get_event))], [])
    HRESULT get_Event(CALL_MEDIA_EVENT* pCallMediaEvent);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallmediaevent-get_error))], [])
    HRESULT get_Error(HRESULT* phrError);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallmediaevent-get_terminal))], [])
    HRESULT get_Terminal(ITTerminal* ppTerminal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallmediaevent-get_stream))], [])
    HRESULT get_Stream(ITStream* ppStream);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallmediaevent-get_cause))], [])
    HRESULT get_Cause(CALL_MEDIA_EVENT_CAUSE* pCause);
}

@GUID("80d3bfac-57d9-11d2-a04a-00c04fb6809f")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itdigitdetectionevent))], [])
interface ITDigitDetectionEvent : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itdigitdetectionevent-get_call))], [])
    HRESULT get_Call(ITCallInfo* ppCallInfo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itdigitdetectionevent-get_digit))], [])
    HRESULT get_Digit(ubyte* pucDigit);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itdigitdetectionevent-get_digitmode))], [])
    HRESULT get_DigitMode(int* pDigitMode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itdigitdetectionevent-get_tickcount))], [])
    HRESULT get_TickCount(int* plTickCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itdigitdetectionevent-get_callbackinstance))], [])
    HRESULT get_CallbackInstance(int* plCallbackInstance);
}

@GUID("80d3bfad-57d9-11d2-a04a-00c04fb6809f")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itdigitgenerationevent))], [])
interface ITDigitGenerationEvent : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itdigitgenerationevent-get_call))], [])
    HRESULT get_Call(ITCallInfo* ppCallInfo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itdigitgenerationevent-get_generationtermination))], [])
    HRESULT get_GenerationTermination(int* plGenerationTermination);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itdigitgenerationevent-get_tickcount))], [])
    HRESULT get_TickCount(int* plTickCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itdigitgenerationevent-get_callbackinstance))], [])
    HRESULT get_CallbackInstance(int* plCallbackInstance);
}

@GUID("e52ec4c1-cba3-441a-9e6a-93cb909e9724")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itdigitsgatheredevent))], [])
interface ITDigitsGatheredEvent : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itdigitsgatheredevent-get_call))], [])
    HRESULT get_Call(ITCallInfo* ppCallInfo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itdigitsgatheredevent-get_digits))], [])
    HRESULT get_Digits(BSTR* ppDigits);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itdigitsgatheredevent-get_gathertermination))], [])
    HRESULT get_GatherTermination(TAPI_GATHERTERM* pGatherTermination);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itdigitsgatheredevent-get_tickcount))], [])
    HRESULT get_TickCount(int* plTickCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itdigitsgatheredevent-get_callbackinstance))], [])
    HRESULT get_CallbackInstance(int* plCallbackInstance);
}

@GUID("407e0faf-d047-4753-b0c6-8e060373fecd")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-ittonedetectionevent))], [])
interface ITToneDetectionEvent : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittonedetectionevent-get_call))], [])
    HRESULT get_Call(ITCallInfo* ppCallInfo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittonedetectionevent-get_appspecific))], [])
    HRESULT get_AppSpecific(int* plAppSpecific);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittonedetectionevent-get_tickcount))], [])
    HRESULT get_TickCount(int* plTickCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittonedetectionevent-get_callbackinstance))], [])
    HRESULT get_CallbackInstance(int* plCallbackInstance);
}

@GUID("f4854d48-937a-11d1-bb58-00c04fb6809f")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-ittapiobjectevent))], [])
interface ITTAPIObjectEvent : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittapiobjectevent-get_tapiobject))], [])
    HRESULT get_TAPIObject(ITTAPI* ppTAPIObject);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittapiobjectevent-get_event))], [])
    HRESULT get_Event(TAPIOBJECT_EVENT* pEvent);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittapiobjectevent-get_address))], [])
    HRESULT get_Address(ITAddress* ppAddress);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittapiobjectevent-get_callbackinstance))], [])
    HRESULT get_CallbackInstance(int* plCallbackInstance);
}

@GUID("359dda6e-68ce-4383-bf0b-169133c41b46")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-ittapiobjectevent2))], [])
interface ITTAPIObjectEvent2 : ITTAPIObjectEvent
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittapiobjectevent2-get_phone))], [])
    HRESULT get_Phone(ITPhone* ppPhone);
}

@GUID("eddb9426-3b91-11d1-8f30-00c04fb6809f")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-ittapieventnotification))], [])
interface ITTAPIEventNotification : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittapieventnotification-event))], [])
    HRESULT Event(TAPI_EVENT TapiEvent, IDispatch pEvent);
}

@GUID("a3c15451-5b92-11d1-8f4e-00c04fb6809f")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itcallhubevent))], [])
interface ITCallHubEvent : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallhubevent-get_event))], [])
    HRESULT get_Event(CALLHUB_EVENT* pEvent);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallhubevent-get_callhub))], [])
    HRESULT get_CallHub(ITCallHub* ppCallHub);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallhubevent-get_call))], [])
    HRESULT get_Call(ITCallInfo* ppCall);
}

@GUID("831ce2d1-83b5-11d1-bb5c-00c04fb6809f")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itaddressevent))], [])
interface ITAddressEvent : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddressevent-get_address))], [])
    HRESULT get_Address(ITAddress* ppAddress);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddressevent-get_event))], [])
    HRESULT get_Event(ADDRESS_EVENT* pEvent);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddressevent-get_terminal))], [])
    HRESULT get_Terminal(ITTerminal* ppTerminal);
}

@GUID("3acb216b-40bd-487a-8672-5ce77bd7e3a3")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itaddressdevicespecificevent))], [])
interface ITAddressDeviceSpecificEvent : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddressdevicespecificevent-get_address))], [])
    HRESULT get_Address(ITAddress* ppAddress);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddressdevicespecificevent-get_call))], [])
    HRESULT get_Call(ITCallInfo* ppCall);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddressdevicespecificevent-get_lparam1))], [])
    HRESULT get_lParam1(int* pParam1);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddressdevicespecificevent-get_lparam2))], [])
    HRESULT get_lParam2(int* pParam2);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddressdevicespecificevent-get_lparam3))], [])
    HRESULT get_lParam3(int* pParam3);
}

@GUID("e4a7fbac-8c17-4427-9f55-9f589ac8af00")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itfileterminalevent))], [])
interface ITFileTerminalEvent : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itfileterminalevent-get_terminal))], [])
    HRESULT get_Terminal(ITTerminal* ppTerminal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itfileterminalevent-get_track))], [])
    HRESULT get_Track(ITFileTrack* ppTrackTerminal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itfileterminalevent-get_call))], [])
    HRESULT get_Call(ITCallInfo* ppCall);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itfileterminalevent-get_state))], [])
    HRESULT get_State(TERMINAL_MEDIA_STATE* pState);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itfileterminalevent-get_cause))], [])
    HRESULT get_Cause(FT_STATE_EVENT_CAUSE* pCause);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itfileterminalevent-get_error))], [])
    HRESULT get_Error(HRESULT* phrErrorCode);
}

@GUID("d964788f-95a5-461d-ab0c-b9900a6c2713")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itttsterminalevent))], [])
interface ITTTSTerminalEvent : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itttsterminalevent-get_terminal))], [])
    HRESULT get_Terminal(ITTerminal* ppTerminal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itttsterminalevent-get_call))], [])
    HRESULT get_Call(ITCallInfo* ppCall);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itttsterminalevent-get_error))], [])
    HRESULT get_Error(HRESULT* phrErrorCode);
}

@GUID("ee016a02-4fa9-467c-933f-5a15b12377d7")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itasrterminalevent))], [])
interface ITASRTerminalEvent : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itasrterminalevent-get_terminal))], [])
    HRESULT get_Terminal(ITTerminal* ppTerminal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itasrterminalevent-get_call))], [])
    HRESULT get_Call(ITCallInfo* ppCall);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itasrterminalevent-get_error))], [])
    HRESULT get_Error(HRESULT* phrErrorCode);
}

@GUID("e6f56009-611f-4945-bbd2-2d0ce5612056")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-ittoneterminalevent))], [])
interface ITToneTerminalEvent : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittoneterminalevent-get_terminal))], [])
    HRESULT get_Terminal(ITTerminal* ppTerminal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittoneterminalevent-get_call))], [])
    HRESULT get_Call(ITCallInfo* ppCall);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittoneterminalevent-get_error))], [])
    HRESULT get_Error(HRESULT* phrErrorCode);
}

@GUID("cfa3357c-ad77-11d1-bb68-00c04fb6809f")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itqosevent))], [])
interface ITQOSEvent : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itqosevent-get_call))], [])
    HRESULT get_Call(ITCallInfo* ppCall);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itqosevent-get_event))], [])
    HRESULT get_Event(QOS_EVENT* pQosEvent);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itqosevent-get_mediatype))], [])
    HRESULT get_MediaType(int* plMediaType);
}

@GUID("5d4b65f9-e51c-11d1-a02f-00c04fb6809f")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itcallinfochangeevent))], [])
interface ITCallInfoChangeEvent : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallinfochangeevent-get_call))], [])
    HRESULT get_Call(ITCallInfo* ppCall);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallinfochangeevent-get_cause))], [])
    HRESULT get_Cause(CALLINFOCHANGE_CAUSE* pCIC);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallinfochangeevent-get_callbackinstance))], [])
    HRESULT get_CallbackInstance(int* plCallbackInstance);
}

@GUID("ac48ffdf-f8c4-11d1-a030-00c04fb6809f")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itrequest))], [])
interface ITRequest : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itrequest-makecall))], [])
    HRESULT MakeCall(BSTR pDestAddress, BSTR pAppName, BSTR pCalledParty, BSTR pComment);
}

@GUID("ac48ffde-f8c4-11d1-a030-00c04fb6809f")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itrequestevent))], [])
interface ITRequestEvent : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itrequestevent-get_registrationinstance))], [])
    HRESULT get_RegistrationInstance(int* plRegistrationInstance);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itrequestevent-get_requestmode))], [])
    HRESULT get_RequestMode(int* plRequestMode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itrequestevent-get_destaddress))], [])
    HRESULT get_DestAddress(BSTR* ppDestAddress);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itrequestevent-get_appname))], [])
    HRESULT get_AppName(BSTR* ppAppName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itrequestevent-get_calledparty))], [])
    HRESULT get_CalledParty(BSTR* ppCalledParty);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itrequestevent-get_comment))], [])
    HRESULT get_Comment(BSTR* ppComment);
}

@GUID("5ec5acf2-9c02-11d0-8362-00aa003ccabd")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itcollection))], [])
interface ITCollection : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcollection-get_count))], [])
    HRESULT get_Count(int* lCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcollection-get_item))], [])
    HRESULT get_Item(int Index, VARIANT* pVariant);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcollection-get__newenum))], [])
    HRESULT get__NewEnum(IUnknown* ppNewEnum);
}

@GUID("e6dddda5-a6d3-48ff-8737-d32fc4d95477")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itcollection2))], [])
interface ITCollection2 : ITCollection
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcollection2-add))], [])
    HRESULT Add(int Index, VARIANT* pVariant);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcollection2-remove))], [])
    HRESULT Remove(int Index);
}

@GUID("449f659e-88a3-11d1-bb5d-00c04fb6809f")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itforwardinformation))], [])
interface ITForwardInformation : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itforwardinformation-put_numringsnoanswer))], [])
    HRESULT put_NumRingsNoAnswer(int lNumRings);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itforwardinformation-get_numringsnoanswer))], [])
    HRESULT get_NumRingsNoAnswer(int* plNumRings);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itforwardinformation-setforwardtype))], [])
    HRESULT SetForwardType(int ForwardType, BSTR pDestAddress, BSTR pCallerAddress);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itforwardinformation-get_forwardtypedestination))], [])
    HRESULT get_ForwardTypeDestination(int ForwardType, BSTR* ppDestAddress);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itforwardinformation-get_forwardtypecaller))], [])
    HRESULT get_ForwardTypeCaller(int Forwardtype, BSTR* ppCallerAddress);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itforwardinformation-getforwardtype))], [])
    HRESULT GetForwardType(int ForwardType, BSTR* ppDestinationAddress, BSTR* ppCallerAddress);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itforwardinformation-clear))], [])
    HRESULT Clear();
}

@GUID("5229b4ed-b260-4382-8e1a-5df3a8a4ccc0")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itforwardinformation2))], [])
interface ITForwardInformation2 : ITForwardInformation
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itforwardinformation2-setforwardtype2))], [])
    HRESULT SetForwardType2(int ForwardType, BSTR pDestAddress, int DestAddressType, BSTR pCallerAddress, 
                            int CallerAddressType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itforwardinformation2-getforwardtype2))], [])
    HRESULT GetForwardType2(int ForwardType, BSTR* ppDestinationAddress, int* pDestAddressType, 
                            BSTR* ppCallerAddress, int* pCallerAddressType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itforwardinformation2-get_forwardtypedestinationaddresstype))], [])
    HRESULT get_ForwardTypeDestinationAddressType(int ForwardType, int* pDestAddressType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itforwardinformation2-get_forwardtypecalleraddresstype))], [])
    HRESULT get_ForwardTypeCallerAddressType(int Forwardtype, int* pCallerAddressType);
}

@GUID("0c4d8f03-8ddb-11d1-a09e-00805fc147d3")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itaddresstranslation))], [])
interface ITAddressTranslation : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddresstranslation-translateaddress))], [])
    HRESULT TranslateAddress(BSTR pAddressToTranslate, int lCard, int lTranslateOptions, 
                             ITAddressTranslationInfo* ppTranslated);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddresstranslation-translatedialog))], [])
    HRESULT TranslateDialog(ptrdiff_t hwndOwner, BSTR pAddressIn);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddresstranslation-enumeratelocations))], [])
    HRESULT EnumerateLocations(IEnumLocation* ppEnumLocation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddresstranslation-get_locations))], [])
    HRESULT get_Locations(VARIANT* pVariant);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddresstranslation-enumeratecallingcards))], [])
    HRESULT EnumerateCallingCards(IEnumCallingCard* ppEnumCallingCard);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddresstranslation-get_callingcards))], [])
    HRESULT get_CallingCards(VARIANT* pVariant);
}

@GUID("afc15945-8d40-11d1-a09e-00805fc147d3")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itaddresstranslationinfo))], [])
interface ITAddressTranslationInfo : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddresstranslationinfo-get_dialablestring))], [])
    HRESULT get_DialableString(BSTR* ppDialableString);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddresstranslationinfo-get_displayablestring))], [])
    HRESULT get_DisplayableString(BSTR* ppDisplayableString);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddresstranslationinfo-get_currentcountrycode))], [])
    HRESULT get_CurrentCountryCode(int* CountryCode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddresstranslationinfo-get_destinationcountrycode))], [])
    HRESULT get_DestinationCountryCode(int* CountryCode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddresstranslationinfo-get_translationresults))], [])
    HRESULT get_TranslationResults(int* plResults);
}

@GUID("0c4d8eff-8ddb-11d1-a09e-00805fc147d3")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itlocationinfo))], [])
interface ITLocationInfo : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlocationinfo-get_permanentlocationid))], [])
    HRESULT get_PermanentLocationID(int* plLocationID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlocationinfo-get_countrycode))], [])
    HRESULT get_CountryCode(int* plCountryCode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlocationinfo-get_countryid))], [])
    HRESULT get_CountryID(int* plCountryID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlocationinfo-get_options))], [])
    HRESULT get_Options(int* plOptions);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlocationinfo-get_preferredcardid))], [])
    HRESULT get_PreferredCardID(int* plCardID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlocationinfo-get_locationname))], [])
    HRESULT get_LocationName(BSTR* ppLocationName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlocationinfo-get_citycode))], [])
    HRESULT get_CityCode(BSTR* ppCode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlocationinfo-get_localaccesscode))], [])
    HRESULT get_LocalAccessCode(BSTR* ppCode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlocationinfo-get_longdistanceaccesscode))], [])
    HRESULT get_LongDistanceAccessCode(BSTR* ppCode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlocationinfo-get_tollprefixlist))], [])
    HRESULT get_TollPrefixList(BSTR* ppTollList);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlocationinfo-get_cancelcallwaitingcode))], [])
    HRESULT get_CancelCallWaitingCode(BSTR* ppCode);
}

@GUID("0c4d8f01-8ddb-11d1-a09e-00805fc147d3")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-ienumlocation))], [])
interface IEnumLocation : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumlocation-next))], [])
    HRESULT Next(uint celt, ITLocationInfo* ppElements, uint* pceltFetched);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumlocation-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumlocation-skip))], [])
    HRESULT Skip(uint celt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumlocation-clone))], [])
    HRESULT Clone(IEnumLocation* ppEnum);
}

@GUID("0c4d8f00-8ddb-11d1-a09e-00805fc147d3")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itcallingcard))], [])
interface ITCallingCard : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallingcard-get_permanentcardid))], [])
    HRESULT get_PermanentCardID(int* plCardID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallingcard-get_numberofdigits))], [])
    HRESULT get_NumberOfDigits(int* plDigits);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallingcard-get_options))], [])
    HRESULT get_Options(int* plOptions);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallingcard-get_cardname))], [])
    HRESULT get_CardName(BSTR* ppCardName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallingcard-get_sameareadialingrule))], [])
    HRESULT get_SameAreaDialingRule(BSTR* ppRule);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallingcard-get_longdistancedialingrule))], [])
    HRESULT get_LongDistanceDialingRule(BSTR* ppRule);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallingcard-get_internationaldialingrule))], [])
    HRESULT get_InternationalDialingRule(BSTR* ppRule);
}

@GUID("0c4d8f02-8ddb-11d1-a09e-00805fc147d3")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-ienumcallingcard))], [])
interface IEnumCallingCard : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumcallingcard-next))], [])
    HRESULT Next(uint celt, ITCallingCard* ppElements, uint* pceltFetched);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumcallingcard-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumcallingcard-skip))], [])
    HRESULT Skip(uint celt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumcallingcard-clone))], [])
    HRESULT Clone(IEnumCallingCard* ppEnum);
}

@GUID("895801df-3dd6-11d1-8f30-00c04fb6809f")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itcallnotificationevent))], [])
interface ITCallNotificationEvent : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallnotificationevent-get_call))], [])
    HRESULT get_Call(ITCallInfo* ppCall);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallnotificationevent-get_event))], [])
    HRESULT get_Event(CALL_NOTIFICATION_EVENT* pCallNotificationEvent);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallnotificationevent-get_callbackinstance))], [])
    HRESULT get_CallbackInstance(int* plCallbackInstance);
}

@GUID("e9225295-c759-11d1-a02b-00c04fb6809f")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itdispatchmapper))], [])
interface ITDispatchMapper : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itdispatchmapper-querydispatchinterface))], [])
    HRESULT QueryDispatchInterface(BSTR pIID, IDispatch pInterfaceToMap, IDispatch* ppReturnedInterface);
}

@GUID("ee3bd604-3868-11d2-a045-00c04fb6809f")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itstreamcontrol))], [])
interface ITStreamControl : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itstreamcontrol-createstream))], [])
    HRESULT CreateStream(int lMediaType, TERMINAL_DIRECTION td, ITStream* ppStream);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itstreamcontrol-removestream))], [])
    HRESULT RemoveStream(ITStream pStream);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itstreamcontrol-enumeratestreams))], [])
    HRESULT EnumerateStreams(IEnumStream* ppEnumStream);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itstreamcontrol-get_streams))], [])
    HRESULT get_Streams(VARIANT* pVariant);
}

@GUID("ee3bd605-3868-11d2-a045-00c04fb6809f")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itstream))], [])
interface ITStream : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itstream-get_mediatype))], [])
    HRESULT get_MediaType(int* plMediaType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itstream-get_direction))], [])
    HRESULT get_Direction(TERMINAL_DIRECTION* pTD);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itstream-get_name))], [])
    HRESULT get_Name(BSTR* ppName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itstream-startstream))], [])
    HRESULT StartStream();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itstream-pausestream))], [])
    HRESULT PauseStream();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itstream-stopstream))], [])
    HRESULT StopStream();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itstream-selectterminal))], [])
    HRESULT SelectTerminal(ITTerminal pTerminal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itstream-unselectterminal))], [])
    HRESULT UnselectTerminal(ITTerminal pTerminal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itstream-enumerateterminals))], [])
    HRESULT EnumerateTerminals(IEnumTerminal* ppEnumTerminal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itstream-get_terminals))], [])
    HRESULT get_Terminals(VARIANT* pTerminals);
}

@GUID("ee3bd606-3868-11d2-a045-00c04fb6809f")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-ienumstream))], [])
interface IEnumStream : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumstream-next))], [])
    HRESULT Next(uint celt, ITStream* ppElements, uint* pceltFetched);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumstream-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumstream-skip))], [])
    HRESULT Skip(uint celt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumstream-clone))], [])
    HRESULT Clone(IEnumStream* ppEnum);
}

@GUID("ee3bd607-3868-11d2-a045-00c04fb6809f")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itsubstreamcontrol))], [])
interface ITSubStreamControl : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itsubstreamcontrol-createsubstream))], [])
    HRESULT CreateSubStream(ITSubStream* ppSubStream);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itsubstreamcontrol-removesubstream))], [])
    HRESULT RemoveSubStream(ITSubStream pSubStream);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itsubstreamcontrol-enumeratesubstreams))], [])
    HRESULT EnumerateSubStreams(IEnumSubStream* ppEnumSubStream);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itsubstreamcontrol-get_substreams))], [])
    HRESULT get_SubStreams(VARIANT* pVariant);
}

@GUID("ee3bd608-3868-11d2-a045-00c04fb6809f")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itsubstream))], [])
interface ITSubStream : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itsubstream-startsubstream))], [])
    HRESULT StartSubStream();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itsubstream-pausesubstream))], [])
    HRESULT PauseSubStream();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itsubstream-stopsubstream))], [])
    HRESULT StopSubStream();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itsubstream-selectterminal))], [])
    HRESULT SelectTerminal(ITTerminal pTerminal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itsubstream-unselectterminal))], [])
    HRESULT UnselectTerminal(ITTerminal pTerminal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itsubstream-enumerateterminals))], [])
    HRESULT EnumerateTerminals(IEnumTerminal* ppEnumTerminal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itsubstream-get_terminals))], [])
    HRESULT get_Terminals(VARIANT* pTerminals);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itsubstream-get_stream))], [])
    HRESULT get_Stream(ITStream* ppITStream);
}

@GUID("ee3bd609-3868-11d2-a045-00c04fb6809f")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-ienumsubstream))], [])
interface IEnumSubStream : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumsubstream-next))], [])
    HRESULT Next(uint celt, ITSubStream* ppElements, uint* pceltFetched);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumsubstream-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumsubstream-skip))], [])
    HRESULT Skip(uint celt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumsubstream-clone))], [])
    HRESULT Clone(IEnumSubStream* ppEnum);
}

@GUID("207823ea-e252-11d2-b77e-0080c7135381")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itlegacywavesupport))], [])
interface ITLegacyWaveSupport : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlegacywavesupport-isfullduplex))], [])
    HRESULT IsFullDuplex(FULLDUPLEX_SUPPORT* pSupport);
}

@GUID("161a4a56-1e99-4b3f-a46a-168f38a5ee4c")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itbasiccallcontrol2))], [])
interface ITBasicCallControl2 : ITBasicCallControl
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itbasiccallcontrol2-requestterminal))], [])
    HRESULT RequestTerminal(BSTR bstrTerminalClassGUID, int lMediaType, TERMINAL_DIRECTION Direction, 
                            ITTerminal* ppTerminal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itbasiccallcontrol2-selectterminaloncall))], [])
    HRESULT SelectTerminalOnCall(ITTerminal pTerminal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itbasiccallcontrol2-unselectterminaloncall))], [])
    HRESULT UnselectTerminalOnCall(ITTerminal pTerminal);
}

@GUID("b87658bd-3c59-4f64-be74-aede3e86a81e")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itscriptableaudioformat))], [])
interface ITScriptableAudioFormat : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itscriptableaudioformat-get_channels))], [])
    HRESULT get_Channels(int* pVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itscriptableaudioformat-put_channels))], [])
    HRESULT put_Channels(const(int) nNewVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itscriptableaudioformat-get_samplespersec))], [])
    HRESULT get_SamplesPerSec(int* pVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itscriptableaudioformat-put_samplespersec))], [])
    HRESULT put_SamplesPerSec(const(int) nNewVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itscriptableaudioformat-get_avgbytespersec))], [])
    HRESULT get_AvgBytesPerSec(int* pVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itscriptableaudioformat-put_avgbytespersec))], [])
    HRESULT put_AvgBytesPerSec(const(int) nNewVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itscriptableaudioformat-get_blockalign))], [])
    HRESULT get_BlockAlign(int* pVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itscriptableaudioformat-put_blockalign))], [])
    HRESULT put_BlockAlign(const(int) nNewVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itscriptableaudioformat-get_bitspersample))], [])
    HRESULT get_BitsPerSample(int* pVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itscriptableaudioformat-put_bitspersample))], [])
    HRESULT put_BitsPerSample(const(int) nNewVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itscriptableaudioformat-get_formattag))], [])
    HRESULT get_FormatTag(int* pVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itscriptableaudioformat-put_formattag))], [])
    HRESULT put_FormatTag(const(int) nNewVal);
}

@GUID("5770ece5-4b27-11d1-bf80-00805fc147d3")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nn-tapi3cc-itagent))], [])
interface ITAgent : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagent-enumerateagentsessions))], [])
    HRESULT EnumerateAgentSessions(IEnumAgentSession* ppEnumAgentSession);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagent-createsession))], [])
    HRESULT CreateSession(ITACDGroup pACDGroup, ITAddress pAddress, ITAgentSession* ppAgentSession);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagent-createsessionwithpin))], [])
    HRESULT CreateSessionWithPIN(ITACDGroup pACDGroup, ITAddress pAddress, BSTR pPIN, 
                                 ITAgentSession* ppAgentSession);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagent-get_id))], [])
    HRESULT get_ID(BSTR* ppID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagent-get_user))], [])
    HRESULT get_User(BSTR* ppUser);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagent-put_state))], [])
    HRESULT put_State(AGENT_STATE AgentState);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagent-get_state))], [])
    HRESULT get_State(AGENT_STATE* pAgentState);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagent-put_measurementperiod))], [])
    HRESULT put_MeasurementPeriod(int lPeriod);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagent-get_measurementperiod))], [])
    HRESULT get_MeasurementPeriod(int* plPeriod);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagent-get_overallcallrate))], [])
    HRESULT get_OverallCallRate(CY* pcyCallrate);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagent-get_numberofacdcalls))], [])
    HRESULT get_NumberOfACDCalls(int* plCalls);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagent-get_numberofincomingcalls))], [])
    HRESULT get_NumberOfIncomingCalls(int* plCalls);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagent-get_numberofoutgoingcalls))], [])
    HRESULT get_NumberOfOutgoingCalls(int* plCalls);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagent-get_totalacdtalktime))], [])
    HRESULT get_TotalACDTalkTime(int* plTalkTime);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagent-get_totalacdcalltime))], [])
    HRESULT get_TotalACDCallTime(int* plCallTime);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagent-get_totalwrapuptime))], [])
    HRESULT get_TotalWrapUpTime(int* plWrapUpTime);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagent-get_agentsessions))], [])
    HRESULT get_AgentSessions(VARIANT* pVariant);
}

@GUID("5afc3147-4bcc-11d1-bf80-00805fc147d3")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nn-tapi3cc-itagentsession))], [])
interface ITAgentSession : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagentsession-get_agent))], [])
    HRESULT get_Agent(ITAgent* ppAgent);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagentsession-get_address))], [])
    HRESULT get_Address(ITAddress* ppAddress);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagentsession-get_acdgroup))], [])
    HRESULT get_ACDGroup(ITACDGroup* ppACDGroup);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagentsession-put_state))], [])
    HRESULT put_State(AGENT_SESSION_STATE SessionState);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagentsession-get_state))], [])
    HRESULT get_State(AGENT_SESSION_STATE* pSessionState);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagentsession-get_sessionstarttime))], [])
    HRESULT get_SessionStartTime(double* pdateSessionStart);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagentsession-get_sessionduration))], [])
    HRESULT get_SessionDuration(int* plDuration);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagentsession-get_numberofcalls))], [])
    HRESULT get_NumberOfCalls(int* plCalls);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagentsession-get_totaltalktime))], [])
    HRESULT get_TotalTalkTime(int* plTalkTime);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagentsession-get_averagetalktime))], [])
    HRESULT get_AverageTalkTime(int* plTalkTime);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagentsession-get_totalcalltime))], [])
    HRESULT get_TotalCallTime(int* plCallTime);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagentsession-get_averagecalltime))], [])
    HRESULT get_AverageCallTime(int* plCallTime);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagentsession-get_totalwrapuptime))], [])
    HRESULT get_TotalWrapUpTime(int* plWrapUpTime);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagentsession-get_averagewrapuptime))], [])
    HRESULT get_AverageWrapUpTime(int* plWrapUpTime);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagentsession-get_acdcallrate))], [])
    HRESULT get_ACDCallRate(CY* pcyCallrate);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagentsession-get_longesttimetoanswer))], [])
    HRESULT get_LongestTimeToAnswer(int* plAnswerTime);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagentsession-get_averagetimetoanswer))], [])
    HRESULT get_AverageTimeToAnswer(int* plAnswerTime);
}

@GUID("5afc3148-4bcc-11d1-bf80-00805fc147d3")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nn-tapi3cc-itacdgroup))], [])
interface ITACDGroup : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itacdgroup-get_name))], [])
    HRESULT get_Name(BSTR* ppName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itacdgroup-enumeratequeues))], [])
    HRESULT EnumerateQueues(IEnumQueue* ppEnumQueue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itacdgroup-get_queues))], [])
    HRESULT get_Queues(VARIANT* pVariant);
}

@GUID("5afc3149-4bcc-11d1-bf80-00805fc147d3")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nn-tapi3cc-itqueue))], [])
interface ITQueue : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itqueue-put_measurementperiod))], [])
    HRESULT put_MeasurementPeriod(int lPeriod);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itqueue-get_measurementperiod))], [])
    HRESULT get_MeasurementPeriod(int* plPeriod);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itqueue-get_totalcallsqueued))], [])
    HRESULT get_TotalCallsQueued(int* plCalls);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itqueue-get_currentcallsqueued))], [])
    HRESULT get_CurrentCallsQueued(int* plCalls);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itqueue-get_totalcallsabandoned))], [])
    HRESULT get_TotalCallsAbandoned(int* plCalls);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itqueue-get_totalcallsflowedin))], [])
    HRESULT get_TotalCallsFlowedIn(int* plCalls);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itqueue-get_totalcallsflowedout))], [])
    HRESULT get_TotalCallsFlowedOut(int* plCalls);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itqueue-get_longesteverwaittime))], [])
    HRESULT get_LongestEverWaitTime(int* plWaitTime);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itqueue-get_currentlongestwaittime))], [])
    HRESULT get_CurrentLongestWaitTime(int* plWaitTime);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itqueue-get_averagewaittime))], [])
    HRESULT get_AverageWaitTime(int* plWaitTime);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itqueue-get_finaldisposition))], [])
    HRESULT get_FinalDisposition(int* plCalls);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itqueue-get_name))], [])
    HRESULT get_Name(BSTR* ppName);
}

@GUID("5afc314a-4bcc-11d1-bf80-00805fc147d3")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nn-tapi3cc-itagentevent))], [])
interface ITAgentEvent : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagentevent-get_agent))], [])
    HRESULT get_Agent(ITAgent* ppAgent);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagentevent-get_event))], [])
    HRESULT get_Event(AGENT_EVENT* pEvent);
}

@GUID("5afc314b-4bcc-11d1-bf80-00805fc147d3")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nn-tapi3cc-itagentsessionevent))], [])
interface ITAgentSessionEvent : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagentsessionevent-get_session))], [])
    HRESULT get_Session(ITAgentSession* ppSession);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagentsessionevent-get_event))], [])
    HRESULT get_Event(AGENT_SESSION_EVENT* pEvent);
}

@GUID("297f3032-bd11-11d1-a0a7-00805fc147d3")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nn-tapi3cc-itacdgroupevent))], [])
interface ITACDGroupEvent : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itacdgroupevent-get_group))], [])
    HRESULT get_Group(ITACDGroup* ppGroup);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itacdgroupevent-get_event))], [])
    HRESULT get_Event(ACDGROUP_EVENT* pEvent);
}

@GUID("297f3033-bd11-11d1-a0a7-00805fc147d3")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nn-tapi3cc-itqueueevent))], [])
interface ITQueueEvent : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itqueueevent-get_queue))], [])
    HRESULT get_Queue(ITQueue* ppQueue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itqueueevent-get_event))], [])
    HRESULT get_Event(ACDQUEUE_EVENT* pEvent);
}

@GUID("297f3034-bd11-11d1-a0a7-00805fc147d3")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nn-tapi3cc-itagenthandlerevent))], [])
interface ITAgentHandlerEvent : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagenthandlerevent-get_agenthandler))], [])
    HRESULT get_AgentHandler(ITAgentHandler* ppAgentHandler);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagenthandlerevent-get_event))], [])
    HRESULT get_Event(AGENTHANDLER_EVENT* pEvent);
}

@GUID("5afc3154-4bcc-11d1-bf80-00805fc147d3")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nn-tapi3cc-ittapicallcenter))], [])
interface ITTAPICallCenter : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-ittapicallcenter-enumerateagenthandlers))], [])
    HRESULT EnumerateAgentHandlers(IEnumAgentHandler* ppEnumHandler);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-ittapicallcenter-get_agenthandlers))], [])
    HRESULT get_AgentHandlers(VARIANT* pVariant);
}

@GUID("587e8c22-9802-11d1-a0a4-00805fc147d3")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nn-tapi3cc-itagenthandler))], [])
interface ITAgentHandler : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagenthandler-get_name))], [])
    HRESULT get_Name(BSTR* ppName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagenthandler-createagent))], [])
    HRESULT CreateAgent(ITAgent* ppAgent);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagenthandler-createagentwithid))], [])
    HRESULT CreateAgentWithID(BSTR pID, BSTR pPIN, ITAgent* ppAgent);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagenthandler-enumerateacdgroups))], [])
    HRESULT EnumerateACDGroups(IEnumACDGroup* ppEnumACDGroup);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagenthandler-enumerateusableaddresses))], [])
    HRESULT EnumerateUsableAddresses(IEnumAddress* ppEnumAddress);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagenthandler-get_acdgroups))], [])
    HRESULT get_ACDGroups(VARIANT* pVariant);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagenthandler-get_usableaddresses))], [])
    HRESULT get_UsableAddresses(VARIANT* pVariant);
}

@GUID("5afc314d-4bcc-11d1-bf80-00805fc147d3")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nn-tapi3cc-ienumagent))], [])
interface IEnumAgent : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-ienumagent-next))], [])
    HRESULT Next(uint celt, ITAgent* ppElements, uint* pceltFetched);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-ienumagent-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-ienumagent-skip))], [])
    HRESULT Skip(uint celt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-ienumagent-clone))], [])
    HRESULT Clone(IEnumAgent* ppEnum);
}

@GUID("5afc314e-4bcc-11d1-bf80-00805fc147d3")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nn-tapi3cc-ienumagentsession))], [])
interface IEnumAgentSession : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-ienumagentsession-next))], [])
    HRESULT Next(uint celt, ITAgentSession* ppElements, uint* pceltFetched);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-ienumagentsession-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-ienumagentsession-skip))], [])
    HRESULT Skip(uint celt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-ienumagentsession-clone))], [])
    HRESULT Clone(IEnumAgentSession* ppEnum);
}

@GUID("5afc3158-4bcc-11d1-bf80-00805fc147d3")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nn-tapi3cc-ienumqueue))], [])
interface IEnumQueue : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-ienumqueue-next))], [])
    HRESULT Next(uint celt, ITQueue* ppElements, uint* pceltFetched);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-ienumqueue-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-ienumqueue-skip))], [])
    HRESULT Skip(uint celt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-ienumqueue-clone))], [])
    HRESULT Clone(IEnumQueue* ppEnum);
}

@GUID("5afc3157-4bcc-11d1-bf80-00805fc147d3")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nn-tapi3cc-ienumacdgroup))], [])
interface IEnumACDGroup : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-ienumacdgroup-next))], [])
    HRESULT Next(uint celt, ITACDGroup* ppElements, uint* pceltFetched);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-ienumacdgroup-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-ienumacdgroup-skip))], [])
    HRESULT Skip(uint celt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-ienumacdgroup-clone))], [])
    HRESULT Clone(IEnumACDGroup* ppEnum);
}

@GUID("587e8c28-9802-11d1-a0a4-00805fc147d3")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nn-tapi3cc-ienumagenthandler))], [])
interface IEnumAgentHandler : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-ienumagenthandler-next))], [])
    HRESULT Next(uint celt, ITAgentHandler* ppElements, uint* pceltFetched);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-ienumagenthandler-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-ienumagenthandler-skip))], [])
    HRESULT Skip(uint celt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-ienumagenthandler-clone))], [])
    HRESULT Clone(IEnumAgentHandler* ppEnum);
}

@GUID("0364eb00-4a77-11d1-a671-006097c9a2e8")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3ds/nn-tapi3ds-itammediaformat))], [])
interface ITAMMediaFormat : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3ds/nf-tapi3ds-itammediaformat-get_mediaformat))], [])
    HRESULT get_MediaFormat(AM_MEDIA_TYPE** ppmt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3ds/nf-tapi3ds-itammediaformat-put_mediaformat))], [])
    HRESULT put_MediaFormat(const(AM_MEDIA_TYPE)* pmt);
}

@GUID("c1bc3c90-bcfe-11d1-9745-00c04fd91ac0")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3ds/nn-tapi3ds-itallocatorproperties))], [])
interface ITAllocatorProperties : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3ds/nf-tapi3ds-itallocatorproperties-setallocatorproperties))], [])
    HRESULT SetAllocatorProperties(ALLOCATOR_PROPERTIES* pAllocProperties);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3ds/nf-tapi3ds-itallocatorproperties-getallocatorproperties))], [])
    HRESULT GetAllocatorProperties(ALLOCATOR_PROPERTIES* pAllocProperties);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3ds/nf-tapi3ds-itallocatorproperties-setallocatebuffers))], [])
    HRESULT SetAllocateBuffers(BOOL bAllocBuffers);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3ds/nf-tapi3ds-itallocatorproperties-getallocatebuffers))], [])
    HRESULT GetAllocateBuffers(BOOL* pbAllocBuffers);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3ds/nf-tapi3ds-itallocatorproperties-setbuffersize))], [])
    HRESULT SetBufferSize(uint BufferSize);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tapi3ds/nf-tapi3ds-itallocatorproperties-getbuffersize))], [])
    HRESULT GetBufferSize(uint* pBufferSize);
}

@GUID("6e0887be-ba1a-492e-bd10-4020ec5e33e0")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msp/nn-msp-itpluggableterminaleventsink))], [])
interface ITPluggableTerminalEventSink : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msp/nf-msp-itpluggableterminaleventsink-fireevent))], [])
    HRESULT FireEvent(const(MSP_EVENT_INFO)* pMspEventInfo);
}

@GUID("f7115709-a216-4957-a759-060ab32a90d1")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msp/nn-msp-itpluggableterminaleventsinkregistration))], [])
interface ITPluggableTerminalEventSinkRegistration : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msp/nf-msp-itpluggableterminaleventsinkregistration-registersink))], [])
    HRESULT RegisterSink(ITPluggableTerminalEventSink pEventSink);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msp/nf-msp-itpluggableterminaleventsinkregistration-unregistersink))], [])
    HRESULT UnregisterSink();
}

@GUID("ee3bd600-3868-11d2-a045-00c04fb6809f")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msp/nn-msp-itmspaddress))], [])
interface ITMSPAddress : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msp/nf-msp-itmspaddress-initialize))], [])
    HRESULT Initialize(int* hEvent);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msp/nf-msp-itmspaddress-shutdown))], [])
    HRESULT Shutdown();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msp/nf-msp-itmspaddress-createmspcall))], [])
    HRESULT CreateMSPCall(int* hCall, uint dwReserved, uint dwMediaType, IUnknown pOuterUnknown, 
                          IUnknown* ppStreamControl);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msp/nf-msp-itmspaddress-shutdownmspcall))], [])
    HRESULT ShutdownMSPCall(IUnknown pStreamControl);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msp/nf-msp-itmspaddress-receivetspdata))], [])
    HRESULT ReceiveTSPData(IUnknown pMSPCall, ubyte* pBuffer, uint dwSize);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msp/nf-msp-itmspaddress-getevent))], [])
    HRESULT GetEvent(uint* pdwSize, ubyte* pEventBuffer);
}

@GUID("9f34325b-7e62-11d2-9457-00c04f8ec888")
interface ITTAPIDispatchEventNotification : IDispatch
{
}

@GUID("f1029e5d-cb5b-11d0-8d59-00c04fd91ac0")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nn-rend-itdirectoryobjectconference))], [])
interface ITDirectoryObjectConference : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectoryobjectconference-get_protocol))], [])
    HRESULT get_Protocol(BSTR* ppProtocol);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectoryobjectconference-get_originator))], [])
    HRESULT get_Originator(BSTR* ppOriginator);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectoryobjectconference-put_originator))], [])
    HRESULT put_Originator(BSTR pOriginator);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectoryobjectconference-get_advertisingscope))], [])
    HRESULT get_AdvertisingScope(RND_ADVERTISING_SCOPE* pAdvertisingScope);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectoryobjectconference-put_advertisingscope))], [])
    HRESULT put_AdvertisingScope(RND_ADVERTISING_SCOPE AdvertisingScope);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectoryobjectconference-get_url))], [])
    HRESULT get_Url(BSTR* ppUrl);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectoryobjectconference-put_url))], [])
    HRESULT put_Url(BSTR pUrl);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectoryobjectconference-get_description))], [])
    HRESULT get_Description(BSTR* ppDescription);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectoryobjectconference-put_description))], [])
    HRESULT put_Description(BSTR pDescription);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectoryobjectconference-get_isencrypted))], [])
    HRESULT get_IsEncrypted(VARIANT_BOOL* pfEncrypted);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectoryobjectconference-put_isencrypted))], [])
    HRESULT put_IsEncrypted(VARIANT_BOOL fEncrypted);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectoryobjectconference-get_starttime))], [])
    HRESULT get_StartTime(double* pDate);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectoryobjectconference-put_starttime))], [])
    HRESULT put_StartTime(double Date);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectoryobjectconference-get_stoptime))], [])
    HRESULT get_StopTime(double* pDate);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectoryobjectconference-put_stoptime))], [])
    HRESULT put_StopTime(double Date);
}

@GUID("34621d6f-6cff-11d1-aff7-00c04fc31fee")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nn-rend-itdirectoryobjectuser))], [])
interface ITDirectoryObjectUser : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectoryobjectuser-get_ipphoneprimary))], [])
    HRESULT get_IPPhonePrimary(BSTR* ppName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectoryobjectuser-put_ipphoneprimary))], [])
    HRESULT put_IPPhonePrimary(BSTR pName);
}

@GUID("34621d70-6cff-11d1-aff7-00c04fc31fee")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nn-rend-ienumdialableaddrs))], [])
interface IEnumDialableAddrs : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-ienumdialableaddrs-next))], [])
    HRESULT Next(uint celt, BSTR* ppElements, uint* pcFetched);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-ienumdialableaddrs-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-ienumdialableaddrs-skip))], [])
    HRESULT Skip(uint celt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-ienumdialableaddrs-clone))], [])
    HRESULT Clone(IEnumDialableAddrs* ppEnum);
}

@GUID("34621d6e-6cff-11d1-aff7-00c04fc31fee")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nn-rend-itdirectoryobject))], [])
interface ITDirectoryObject : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectoryobject-get_objecttype))], [])
    HRESULT get_ObjectType(DIRECTORY_OBJECT_TYPE* pObjectType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectoryobject-get_name))], [])
    HRESULT get_Name(BSTR* ppName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectoryobject-put_name))], [])
    HRESULT put_Name(BSTR pName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectoryobject-get_dialableaddrs))], [])
    HRESULT get_DialableAddrs(int dwAddressType, VARIANT* pVariant);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectoryobject-enumeratedialableaddrs))], [])
    HRESULT EnumerateDialableAddrs(uint dwAddressType, IEnumDialableAddrs* ppEnumDialableAddrs);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectoryobject-get_securitydescriptor))], [])
    HRESULT get_SecurityDescriptor(IDispatch* ppSecDes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectoryobject-put_securitydescriptor))], [])
    HRESULT put_SecurityDescriptor(IDispatch pSecDes);
}

@GUID("06c9b64a-306d-11d1-9774-00c04fd91ac0")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nn-rend-ienumdirectoryobject))], [])
interface IEnumDirectoryObject : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-ienumdirectoryobject-next))], [])
    HRESULT Next(uint celt, ITDirectoryObject* pVal, uint* pcFetched);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-ienumdirectoryobject-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-ienumdirectoryobject-skip))], [])
    HRESULT Skip(uint celt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-ienumdirectoryobject-clone))], [])
    HRESULT Clone(IEnumDirectoryObject* ppEnum);
}

@GUID("34621d72-6cff-11d1-aff7-00c04fc31fee")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nn-rend-itilsconfig))], [])
interface ITILSConfig : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itilsconfig-get_port))], [])
    HRESULT get_Port(int* pPort);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itilsconfig-put_port))], [])
    HRESULT put_Port(int Port);
}

@GUID("34621d6c-6cff-11d1-aff7-00c04fc31fee")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nn-rend-itdirectory))], [])
interface ITDirectory : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectory-get_directorytype))], [])
    HRESULT get_DirectoryType(DIRECTORY_TYPE* pDirectoryType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectory-get_displayname))], [])
    HRESULT get_DisplayName(BSTR* pName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectory-get_isdynamic))], [])
    HRESULT get_IsDynamic(VARIANT_BOOL* pfDynamic);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectory-get_defaultobjectttl))], [])
    HRESULT get_DefaultObjectTTL(int* pTTL);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectory-put_defaultobjectttl))], [])
    HRESULT put_DefaultObjectTTL(int TTL);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectory-enableautorefresh))], [])
    HRESULT EnableAutoRefresh(VARIANT_BOOL fEnable);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectory-connect))], [])
    HRESULT Connect(VARIANT_BOOL fSecure);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectory-bind))], [])
    HRESULT Bind(BSTR pDomainName, BSTR pUserName, BSTR pPassword, int lFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectory-adddirectoryobject))], [])
    HRESULT AddDirectoryObject(ITDirectoryObject pDirectoryObject);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectory-modifydirectoryobject))], [])
    HRESULT ModifyDirectoryObject(ITDirectoryObject pDirectoryObject);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectory-refreshdirectoryobject))], [])
    HRESULT RefreshDirectoryObject(ITDirectoryObject pDirectoryObject);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectory-deletedirectoryobject))], [])
    HRESULT DeleteDirectoryObject(ITDirectoryObject pDirectoryObject);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectory-get_directoryobjects))], [])
    HRESULT get_DirectoryObjects(DIRECTORY_OBJECT_TYPE DirectoryObjectType, BSTR pName, VARIANT* pVariant);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectory-enumeratedirectoryobjects))], [])
    HRESULT EnumerateDirectoryObjects(DIRECTORY_OBJECT_TYPE DirectoryObjectType, BSTR pName, 
                                      IEnumDirectoryObject* ppEnumObject);
}

@GUID("34621d6d-6cff-11d1-aff7-00c04fc31fee")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nn-rend-ienumdirectory))], [])
interface IEnumDirectory : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-ienumdirectory-next))], [])
    HRESULT Next(uint celt, ITDirectory* ppElements, uint* pcFetched);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-ienumdirectory-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-ienumdirectory-skip))], [])
    HRESULT Skip(uint celt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-ienumdirectory-clone))], [])
    HRESULT Clone(IEnumDirectory* ppEnum);
}

@GUID("34621d6b-6cff-11d1-aff7-00c04fc31fee")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nn-rend-itrendezvous))], [])
interface ITRendezvous : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itrendezvous-get_defaultdirectories))], [])
    HRESULT get_DefaultDirectories(VARIANT* pVariant);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itrendezvous-enumeratedefaultdirectories))], [])
    HRESULT EnumerateDefaultDirectories(IEnumDirectory* ppEnumDirectory);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itrendezvous-createdirectory))], [])
    HRESULT CreateDirectory(DIRECTORY_TYPE DirectoryType, BSTR pName, ITDirectory* ppDir);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itrendezvous-createdirectoryobject))], [])
    HRESULT CreateDirectoryObject(DIRECTORY_OBJECT_TYPE DirectoryObjectType, BSTR pName, 
                                  ITDirectoryObject* ppDirectoryObject);
}

@GUID("df0daef4-a289-11d1-8697-006008b0e5d2")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mdhcp/nn-mdhcp-imcastscope))], [])
interface IMcastScope : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-imcastscope-get_scopeid))], [])
    HRESULT get_ScopeID(int* pID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-imcastscope-get_serverid))], [])
    HRESULT get_ServerID(int* pID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-imcastscope-get_interfaceid))], [])
    HRESULT get_InterfaceID(int* pID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-imcastscope-get_scopedescription))], [])
    HRESULT get_ScopeDescription(BSTR* ppDescription);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-imcastscope-get_ttl))], [])
    HRESULT get_TTL(int* pTTL);
}

@GUID("df0daefd-a289-11d1-8697-006008b0e5d2")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mdhcp/nn-mdhcp-imcastleaseinfo))], [])
interface IMcastLeaseInfo : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-imcastleaseinfo-get_requestid))], [])
    HRESULT get_RequestID(BSTR* ppRequestID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-imcastleaseinfo-get_leasestarttime))], [])
    HRESULT get_LeaseStartTime(double* pTime);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-imcastleaseinfo-put_leasestarttime))], [])
    HRESULT put_LeaseStartTime(double time);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-imcastleaseinfo-get_leasestoptime))], [])
    HRESULT get_LeaseStopTime(double* pTime);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-imcastleaseinfo-put_leasestoptime))], [])
    HRESULT put_LeaseStopTime(double time);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-imcastleaseinfo-get_addresscount))], [])
    HRESULT get_AddressCount(int* pCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-imcastleaseinfo-get_serveraddress))], [])
    HRESULT get_ServerAddress(BSTR* ppAddress);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-imcastleaseinfo-get_ttl))], [])
    HRESULT get_TTL(int* pTTL);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-imcastleaseinfo-get_addresses))], [])
    HRESULT get_Addresses(VARIANT* pVariant);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-imcastleaseinfo-enumerateaddresses))], [])
    HRESULT EnumerateAddresses(IEnumBstr* ppEnumAddresses);
}

@GUID("df0daf09-a289-11d1-8697-006008b0e5d2")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mdhcp/nn-mdhcp-ienummcastscope))], [])
interface IEnumMcastScope : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-ienummcastscope-next))], [])
    HRESULT Next(uint celt, IMcastScope* ppScopes, uint* pceltFetched);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-ienummcastscope-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-ienummcastscope-skip))], [])
    HRESULT Skip(uint celt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-ienummcastscope-clone))], [])
    HRESULT Clone(IEnumMcastScope* ppEnum);
}

@GUID("df0daef1-a289-11d1-8697-006008b0e5d2")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mdhcp/nn-mdhcp-imcastaddressallocation))], [])
interface IMcastAddressAllocation : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-imcastaddressallocation-get_scopes))], [])
    HRESULT get_Scopes(VARIANT* pVariant);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-imcastaddressallocation-enumeratescopes))], [])
    HRESULT EnumerateScopes(IEnumMcastScope* ppEnumMcastScope);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-imcastaddressallocation-requestaddress))], [])
    HRESULT RequestAddress(IMcastScope pScope, double LeaseStartTime, double LeaseStopTime, int NumAddresses, 
                           IMcastLeaseInfo* ppLeaseResponse);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-imcastaddressallocation-renewaddress))], [])
    HRESULT RenewAddress(int lReserved, IMcastLeaseInfo pRenewRequest, IMcastLeaseInfo* ppRenewResponse);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-imcastaddressallocation-releaseaddress))], [])
    HRESULT ReleaseAddress(IMcastLeaseInfo pReleaseRequest);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-imcastaddressallocation-createleaseinfo))], [])
    HRESULT CreateLeaseInfo(double LeaseStartTime, double LeaseStopTime, uint dwNumAddresses, PWSTR* ppAddresses, 
                            PWSTR pRequestID, PWSTR pServerAddress, IMcastLeaseInfo* ppReleaseRequest);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-imcastaddressallocation-createleaseinfofromvariant))], [])
    HRESULT CreateLeaseInfoFromVariant(double LeaseStartTime, double LeaseStopTime, VARIANT vAddresses, 
                                       BSTR pRequestID, BSTR pServerAddress, IMcastLeaseInfo* ppReleaseRequest);
}

//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/office/client-developer/outlook/mapi/itnefiunknown))], [])
interface ITnef : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/office/client-developer/outlook/mapi/itnef-addprops))], [])
    HRESULT AddProps(uint ulFlags, uint ulElemID, void* lpvData, SPropTagArray* lpPropList);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/office/client-developer/outlook/mapi/itnef-extractprops))], [])
    HRESULT ExtractProps(uint ulFlags, SPropTagArray* lpPropList, STnefProblemArray** lpProblems);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/office/client-developer/outlook/mapi/itnef-finish))], [])
    HRESULT Finish(uint ulFlags, ushort* lpKey, STnefProblemArray** lpProblems);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/office/client-developer/outlook/mapi/itnef-opentaggedbody))], [])
    HRESULT OpenTaggedBody(IMessage lpMessage, uint ulFlags, IStream* lppStream);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/office/client-developer/outlook/mapi/itnef-setprops))], [])
    HRESULT SetProps(uint ulFlags, uint ulElemID, uint cValues, SPropValue* lpProps);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/office/client-developer/outlook/mapi/itnef-encoderecips))], [])
    HRESULT EncodeRecips(uint ulFlags, IMAPITable lpRecipientTable);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/office/client-developer/outlook/mapi/itnef-finishcomponent))], [])
    HRESULT FinishComponent(uint ulFlags, uint ulComponentID, SPropTagArray* lpCustomPropList, 
                            SPropValue* lpCustomProps, SPropTagArray* lpPropList, STnefProblemArray** lpProblems);
}


// GUIDs

const GUID CLSID_DispatchMapper         = GUIDOF!DispatchMapper;
const GUID CLSID_McastAddressAllocation = GUIDOF!McastAddressAllocation;
const GUID CLSID_Rendezvous             = GUIDOF!Rendezvous;
const GUID CLSID_RequestMakeCall        = GUIDOF!RequestMakeCall;
const GUID CLSID_TAPI                   = GUIDOF!TAPI;

const GUID IID_IEnumACDGroup                            = GUIDOF!IEnumACDGroup;
const GUID IID_IEnumAddress                             = GUIDOF!IEnumAddress;
const GUID IID_IEnumAgent                               = GUIDOF!IEnumAgent;
const GUID IID_IEnumAgentHandler                        = GUIDOF!IEnumAgentHandler;
const GUID IID_IEnumAgentSession                        = GUIDOF!IEnumAgentSession;
const GUID IID_IEnumBstr                                = GUIDOF!IEnumBstr;
const GUID IID_IEnumCall                                = GUIDOF!IEnumCall;
const GUID IID_IEnumCallHub                             = GUIDOF!IEnumCallHub;
const GUID IID_IEnumCallingCard                         = GUIDOF!IEnumCallingCard;
const GUID IID_IEnumDialableAddrs                       = GUIDOF!IEnumDialableAddrs;
const GUID IID_IEnumDirectory                           = GUIDOF!IEnumDirectory;
const GUID IID_IEnumDirectoryObject                     = GUIDOF!IEnumDirectoryObject;
const GUID IID_IEnumLocation                            = GUIDOF!IEnumLocation;
const GUID IID_IEnumMcastScope                          = GUIDOF!IEnumMcastScope;
const GUID IID_IEnumPhone                               = GUIDOF!IEnumPhone;
const GUID IID_IEnumPluggableSuperclassInfo             = GUIDOF!IEnumPluggableSuperclassInfo;
const GUID IID_IEnumPluggableTerminalClassInfo          = GUIDOF!IEnumPluggableTerminalClassInfo;
const GUID IID_IEnumQueue                               = GUIDOF!IEnumQueue;
const GUID IID_IEnumStream                              = GUIDOF!IEnumStream;
const GUID IID_IEnumSubStream                           = GUIDOF!IEnumSubStream;
const GUID IID_IEnumTerminal                            = GUIDOF!IEnumTerminal;
const GUID IID_IEnumTerminalClass                       = GUIDOF!IEnumTerminalClass;
const GUID IID_IMcastAddressAllocation                  = GUIDOF!IMcastAddressAllocation;
const GUID IID_IMcastLeaseInfo                          = GUIDOF!IMcastLeaseInfo;
const GUID IID_IMcastScope                              = GUIDOF!IMcastScope;
const GUID IID_ITACDGroup                               = GUIDOF!ITACDGroup;
const GUID IID_ITACDGroupEvent                          = GUIDOF!ITACDGroupEvent;
const GUID IID_ITAMMediaFormat                          = GUIDOF!ITAMMediaFormat;
const GUID IID_ITASRTerminalEvent                       = GUIDOF!ITASRTerminalEvent;
const GUID IID_ITAddress                                = GUIDOF!ITAddress;
const GUID IID_ITAddress2                               = GUIDOF!ITAddress2;
const GUID IID_ITAddressCapabilities                    = GUIDOF!ITAddressCapabilities;
const GUID IID_ITAddressDeviceSpecificEvent             = GUIDOF!ITAddressDeviceSpecificEvent;
const GUID IID_ITAddressEvent                           = GUIDOF!ITAddressEvent;
const GUID IID_ITAddressTranslation                     = GUIDOF!ITAddressTranslation;
const GUID IID_ITAddressTranslationInfo                 = GUIDOF!ITAddressTranslationInfo;
const GUID IID_ITAgent                                  = GUIDOF!ITAgent;
const GUID IID_ITAgentEvent                             = GUIDOF!ITAgentEvent;
const GUID IID_ITAgentHandler                           = GUIDOF!ITAgentHandler;
const GUID IID_ITAgentHandlerEvent                      = GUIDOF!ITAgentHandlerEvent;
const GUID IID_ITAgentSession                           = GUIDOF!ITAgentSession;
const GUID IID_ITAgentSessionEvent                      = GUIDOF!ITAgentSessionEvent;
const GUID IID_ITAllocatorProperties                    = GUIDOF!ITAllocatorProperties;
const GUID IID_ITAutomatedPhoneControl                  = GUIDOF!ITAutomatedPhoneControl;
const GUID IID_ITBasicAudioTerminal                     = GUIDOF!ITBasicAudioTerminal;
const GUID IID_ITBasicCallControl                       = GUIDOF!ITBasicCallControl;
const GUID IID_ITBasicCallControl2                      = GUIDOF!ITBasicCallControl2;
const GUID IID_ITCallHub                                = GUIDOF!ITCallHub;
const GUID IID_ITCallHubEvent                           = GUIDOF!ITCallHubEvent;
const GUID IID_ITCallInfo                               = GUIDOF!ITCallInfo;
const GUID IID_ITCallInfo2                              = GUIDOF!ITCallInfo2;
const GUID IID_ITCallInfoChangeEvent                    = GUIDOF!ITCallInfoChangeEvent;
const GUID IID_ITCallMediaEvent                         = GUIDOF!ITCallMediaEvent;
const GUID IID_ITCallNotificationEvent                  = GUIDOF!ITCallNotificationEvent;
const GUID IID_ITCallStateEvent                         = GUIDOF!ITCallStateEvent;
const GUID IID_ITCallingCard                            = GUIDOF!ITCallingCard;
const GUID IID_ITCollection                             = GUIDOF!ITCollection;
const GUID IID_ITCollection2                            = GUIDOF!ITCollection2;
const GUID IID_ITCustomTone                             = GUIDOF!ITCustomTone;
const GUID IID_ITDetectTone                             = GUIDOF!ITDetectTone;
const GUID IID_ITDigitDetectionEvent                    = GUIDOF!ITDigitDetectionEvent;
const GUID IID_ITDigitGenerationEvent                   = GUIDOF!ITDigitGenerationEvent;
const GUID IID_ITDigitsGatheredEvent                    = GUIDOF!ITDigitsGatheredEvent;
const GUID IID_ITDirectory                              = GUIDOF!ITDirectory;
const GUID IID_ITDirectoryObject                        = GUIDOF!ITDirectoryObject;
const GUID IID_ITDirectoryObjectConference              = GUIDOF!ITDirectoryObjectConference;
const GUID IID_ITDirectoryObjectUser                    = GUIDOF!ITDirectoryObjectUser;
const GUID IID_ITDispatchMapper                         = GUIDOF!ITDispatchMapper;
const GUID IID_ITFileTerminalEvent                      = GUIDOF!ITFileTerminalEvent;
const GUID IID_ITFileTrack                              = GUIDOF!ITFileTrack;
const GUID IID_ITForwardInformation                     = GUIDOF!ITForwardInformation;
const GUID IID_ITForwardInformation2                    = GUIDOF!ITForwardInformation2;
const GUID IID_ITILSConfig                              = GUIDOF!ITILSConfig;
const GUID IID_ITLegacyAddressMediaControl              = GUIDOF!ITLegacyAddressMediaControl;
const GUID IID_ITLegacyAddressMediaControl2             = GUIDOF!ITLegacyAddressMediaControl2;
const GUID IID_ITLegacyCallMediaControl                 = GUIDOF!ITLegacyCallMediaControl;
const GUID IID_ITLegacyCallMediaControl2                = GUIDOF!ITLegacyCallMediaControl2;
const GUID IID_ITLegacyWaveSupport                      = GUIDOF!ITLegacyWaveSupport;
const GUID IID_ITLocationInfo                           = GUIDOF!ITLocationInfo;
const GUID IID_ITMSPAddress                             = GUIDOF!ITMSPAddress;
const GUID IID_ITMediaControl                           = GUIDOF!ITMediaControl;
const GUID IID_ITMediaPlayback                          = GUIDOF!ITMediaPlayback;
const GUID IID_ITMediaRecord                            = GUIDOF!ITMediaRecord;
const GUID IID_ITMediaSupport                           = GUIDOF!ITMediaSupport;
const GUID IID_ITMultiTrackTerminal                     = GUIDOF!ITMultiTrackTerminal;
const GUID IID_ITPhone                                  = GUIDOF!ITPhone;
const GUID IID_ITPhoneDeviceSpecificEvent               = GUIDOF!ITPhoneDeviceSpecificEvent;
const GUID IID_ITPhoneEvent                             = GUIDOF!ITPhoneEvent;
const GUID IID_ITPluggableTerminalClassInfo             = GUIDOF!ITPluggableTerminalClassInfo;
const GUID IID_ITPluggableTerminalEventSink             = GUIDOF!ITPluggableTerminalEventSink;
const GUID IID_ITPluggableTerminalEventSinkRegistration = GUIDOF!ITPluggableTerminalEventSinkRegistration;
const GUID IID_ITPluggableTerminalSuperclassInfo        = GUIDOF!ITPluggableTerminalSuperclassInfo;
const GUID IID_ITPrivateEvent                           = GUIDOF!ITPrivateEvent;
const GUID IID_ITQOSEvent                               = GUIDOF!ITQOSEvent;
const GUID IID_ITQueue                                  = GUIDOF!ITQueue;
const GUID IID_ITQueueEvent                             = GUIDOF!ITQueueEvent;
const GUID IID_ITRendezvous                             = GUIDOF!ITRendezvous;
const GUID IID_ITRequest                                = GUIDOF!ITRequest;
const GUID IID_ITRequestEvent                           = GUIDOF!ITRequestEvent;
const GUID IID_ITScriptableAudioFormat                  = GUIDOF!ITScriptableAudioFormat;
const GUID IID_ITStaticAudioTerminal                    = GUIDOF!ITStaticAudioTerminal;
const GUID IID_ITStream                                 = GUIDOF!ITStream;
const GUID IID_ITStreamControl                          = GUIDOF!ITStreamControl;
const GUID IID_ITSubStream                              = GUIDOF!ITSubStream;
const GUID IID_ITSubStreamControl                       = GUIDOF!ITSubStreamControl;
const GUID IID_ITTAPI                                   = GUIDOF!ITTAPI;
const GUID IID_ITTAPI2                                  = GUIDOF!ITTAPI2;
const GUID IID_ITTAPICallCenter                         = GUIDOF!ITTAPICallCenter;
const GUID IID_ITTAPIDispatchEventNotification          = GUIDOF!ITTAPIDispatchEventNotification;
const GUID IID_ITTAPIEventNotification                  = GUIDOF!ITTAPIEventNotification;
const GUID IID_ITTAPIObjectEvent                        = GUIDOF!ITTAPIObjectEvent;
const GUID IID_ITTAPIObjectEvent2                       = GUIDOF!ITTAPIObjectEvent2;
const GUID IID_ITTTSTerminalEvent                       = GUIDOF!ITTTSTerminalEvent;
const GUID IID_ITTerminal                               = GUIDOF!ITTerminal;
const GUID IID_ITTerminalSupport                        = GUIDOF!ITTerminalSupport;
const GUID IID_ITTerminalSupport2                       = GUIDOF!ITTerminalSupport2;
const GUID IID_ITToneDetectionEvent                     = GUIDOF!ITToneDetectionEvent;
const GUID IID_ITToneTerminalEvent                      = GUIDOF!ITToneTerminalEvent;
